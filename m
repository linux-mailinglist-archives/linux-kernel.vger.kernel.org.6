Return-Path: <linux-kernel+bounces-520839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291F4A3AFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E4C1895021
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F99D18C011;
	Wed, 19 Feb 2025 03:15:24 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08954648
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934924; cv=none; b=hhDVoY83A+voWn1hHz2oQ22Mk+0uJQniJcRCaXG+zgeyqRLjjjVh7PMCvsnnSNU4CCDTWMOTOZmRNx3MzsXJTzUFTNL0qPj59Igo0rvzvaMhKYOu43foVC9o+v5Wai/4yDk+4X+Vu7CXR9TV18WzPVVbhj7tMkT7ESlI6wFo+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934924; c=relaxed/simple;
	bh=ReXX7Ap5WK6/LVQb1qlxomuNOI7pCZMVuqGe9us64T8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Zzh7aRr6mtYSY0GCRx0Si2IjukXW/iu9+HsZHljgJDACOYZS0J7wSgGhciAI+0X7I/d3oEYhuu5f7Dn5qhZUTcH7d0iB/rV3J5B8FdP1wy80KIMhC6q24aV4wIWAfq04GnmqFY1MVwkeSpPvs8c3gQJV7jwrMK2lq1tNpgO8npQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YyLxZ6xZkz1Y1s5;
	Wed, 19 Feb 2025 11:10:42 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 973A71802D0;
	Wed, 19 Feb 2025 11:15:18 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 11:15:17 +0800
Subject: Re: [PATCH v3 2/3] mm: memory-hotplug: check folio ref count first in
 do_migrate_range
To: Wupeng Ma <mawupeng1@huawei.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <osalvador@suse.de>,
	<nao.horiguchi@gmail.com>, <mhocko@suse.com>
References: <20250217014329.3610326-1-mawupeng1@huawei.com>
 <20250217014329.3610326-3-mawupeng1@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6625b73d-64e5-01e5-a114-e667a0ea52bb@huawei.com>
Date: Wed, 19 Feb 2025 11:15:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250217014329.3610326-3-mawupeng1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2025/2/17 9:43, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> If a folio has an increased reference count, folio_try_get() will acquire
> it, perform necessary operations, and then release it. In the case of a
> poisoned folio without an elevated reference count (which is unlikely for
> memory-failure), folio_try_get() will simply bypass it.
> 
> Therefore, relocate the folio_try_get() function, responsible for checking
> and acquiring this reference count at first.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

