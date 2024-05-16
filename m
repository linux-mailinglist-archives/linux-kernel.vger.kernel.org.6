Return-Path: <linux-kernel+bounces-180789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE848C731C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA52B22DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FB5142E88;
	Thu, 16 May 2024 08:45:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E437142
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849130; cv=none; b=hzCimQSF1Lgofyt4GkKoOUyNEY+DvmQtTCwR5sSRXLZ6XRTNP+YuhR0kTY94YP5PjOEdmQyveykYcVFezp402q7cJ0nXRrpXYQp6f5jKy5r0FkBRAKOfBSRHc+YBbUXMx0OGAU0GyHztjePcJ0cMDpwr+02E1lQKOdRNRHC1AbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849130; c=relaxed/simple;
	bh=7aYx2NAHJSdm6UY/JfxSDGIF/gJzItywug9/e9fWLng=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dz7xbDpU//s7if2M5ZHa72oTGjpbqaQjkQSaz280r2V7u74HG4REVyN9B8eMOcaD5IePz/IUPjghrfuh0omhL55IgrAtyLCe9WLPApMUHN+Y2iOirlNB4ZcCG69qTIsSWvQRDjLuxgwKYBTgU9dUF0DaceebvAW7ZIPbHYhQ5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vg3VN5cTSzxNgp;
	Thu, 16 May 2024 16:41:48 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E42D1800C7;
	Thu, 16 May 2024 16:45:23 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 16:45:23 +0800
Subject: Re: [PATCH v2] mm/huge_memory: don't unpoison huge_zero_folio
To: Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>
CC: <akpm@linux-foundation.org>, <shy828301@gmail.com>,
	<nao.horiguchi@gmail.com>, <xuyu@linux.alibaba.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240515023607.870022-1-linmiaohe@huawei.com>
 <e1c93779-8cde-4986-85d3-2134fb8970b3@redhat.com>
 <ZkXDS9y_cBSzBzeN@localhost.localdomain>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fd1b4d3f-be4c-16e2-00d9-8ea6443c68f3@huawei.com>
Date: Thu, 16 May 2024 16:45:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZkXDS9y_cBSzBzeN@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/16 16:26, Oscar Salvador wrote:
> On Wed, May 15, 2024 at 05:55:39PM +0200, David Hildenbrand wrote:
>>> +	if (is_huge_zero_folio(folio)) {
>>> +		unpoison_pr_info("Unpoison: huge zero page is not supported %#lx\n",
>>> +				 pfn, &unpoison_rs);
>>> +		goto unlock_mutex;
>>> +	}
>>> +
> 
> Sorry for spamming your reply David, but for some unknown reason I am not able
> to find the original patch in my mailbox, in none of the two accountes I am
> subscribed, so I guess I will have to reply here.
> 
> Just two things
> 
> 1) We do not care if someone grabs a refcount for huge_zero_folio,
>    because since it is not supported anyway the outcome will not change.
>    Also, AFAIK, there is no chance we can unpoison that folio.
>    Therefore, I would just lift the check two blocks and place it right after
>    the hw_memory_failure check.
> 
> 2) The whole thing is unsupported, but you will return -EBUSY while you
>    should be returning -EOPNOTSUPP AFAICS.
> 

Thanks for your comment. Do you mean something like below?

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 16ada4fb02b7..a9fe9eda593f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2546,6 +2546,13 @@ int unpoison_memory(unsigned long pfn)
                goto unlock_mutex;
        }

+       if (is_huge_zero_folio(folio)) {
+               unpoison_pr_info("Unpoison: huge zero page is not supported %#lx\n",
+                                pfn, &unpoison_rs);
+               ret = -EOPNOTSUPP;
+               goto unlock_mutex;
+       }
+
        if (!PageHWPoison(p)) {
                unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
                                 pfn, &unpoison_rs);

Thanks.
.

> with that you can add:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
>  
> 


