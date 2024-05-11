Return-Path: <linux-kernel+bounces-176442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00708C2FF6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8EC1C21A65
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1752522A;
	Sat, 11 May 2024 07:01:29 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF11C01
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715410889; cv=none; b=mFedSiAWQ3w071G1Vhhf52LTosPkTXNEuwvTGHzGI6mSeKwg9lzL6pZIBwers6wmM36WJyhEFHOrfyxTaD1XTUldQGTOOHSJX4JWuVoyfMzsZsrvOiTYjnOvnurc15yy3eQkqBapn/+EpWELZDvl3ANR7b7IAlZ2Aic2gwDXEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715410889; c=relaxed/simple;
	bh=hFlGXqO0EmzU9X3MNoUf5RRWsvR8Dm8tkO3dbjntPyU=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hhJxtancOEdys+9aipI1hHwRT9AIOKzTok3DpCAIFxAu9G6BsTPGBDBE+R+4wl7xY3bPygoORc8qmzipwq21GUttyTdn2way+IZGDwOBw7rDTeXmiK9GmfA1MS4WkFdVqc+IFudp39iYtGzqWvRCUxPaUSUyoe6OmFId66V1fyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VbxQJ1npYzgYtK;
	Sat, 11 May 2024 14:57:28 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 48F941800C7;
	Sat, 11 May 2024 15:01:23 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 11 May 2024 15:01:22 +0800
Subject: Re: [PATCH v2 1/5] mm/memory-failure: try to send SIGBUS even if
 unmap failed
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <osalvador@suse.de>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240510062602.901510-1-jane.chu@oracle.com>
 <20240510062602.901510-2-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1c03e22a-2f8e-5bfb-1b02-3992fd9173a7@huawei.com>
Date: Sat, 11 May 2024 15:01:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240510062602.901510-2-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/10 14:25, Jane Chu wrote:
> For years when it comes down to kill a process due to hwpoison,
> a SIGBUS is delivered only if unmap has been successful.
> Otherwise, a SIGKILL is delivered. And the reason for that is
> to prevent the involved process from accessing the hwpoisoned
> page again.
> 
> Since then a lot has changed, a hwpoisoned page is marked and
> upon being re-accessed, the memory-failure handler invokes
> kill_accessing_process() to kill the process immediately.
> So let's take out the '!unmap_success' factor and try to deliver
> SIGBUS if possible.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

LGTM. Thanks.
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

