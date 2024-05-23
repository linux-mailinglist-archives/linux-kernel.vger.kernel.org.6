Return-Path: <linux-kernel+bounces-186921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B958CCACA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0CEB213D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA3513A86D;
	Thu, 23 May 2024 02:37:27 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42613A402
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431847; cv=none; b=QInZXpjXEMgD4/QeOCMoRw1Fm0yTjzGj9gu7Xmu8LL5WNEU3lp8jkKnf1I3FCaE9iebcmwRvWU4ofA+z+Y6OgaslzOm5X6GX5IKrMVztOjSRAEfyR3p3Aqs8D9Of0yQQl0JCUHEqVanpdW2ZLr+XULJ69sXnYo41aTo8byab/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431847; c=relaxed/simple;
	bh=LaxKU9orJW+qM7/dbsH5lIFRw3eqR7TOG2kQqnqLufA=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F4dd6KWgSSO+BQBULTFcNko+0iJXv0UoPvGvdL9602gIdwfmQT1Mq/bdEAIkQ/kpVa8TbvilLbxn/lmgFHb7/nyukJ13tdJA7k0L2hC7nNgVaRusFz1XLKx2Zm7aCqicWcowZXpzB22rTYrJzM56cjIk9MRqhB0/B1csu/Z2rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VlC3813HHzcjjS;
	Thu, 23 May 2024 10:36:04 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 1040318007F;
	Thu, 23 May 2024 10:37:22 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 10:37:21 +0800
Subject: Re: [PATCH v3 4/5] mm/memory-failure: move hwpoison_filter() higher
 up
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <osalvador@suse.de>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240521235429.2368017-1-jane.chu@oracle.com>
 <20240521235429.2368017-5-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <951dd730-40c7-80e5-c36c-e07c91a9fdcb@huawei.com>
Date: Thu, 23 May 2024 10:37:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240521235429.2368017-5-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/22 7:54, Jane Chu wrote:
> Move hwpoison_filter() higher up as there is no need to spend a lot
> cycles only to find out later that the page is supposed to be skipped
> from hwpoison handling.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.


