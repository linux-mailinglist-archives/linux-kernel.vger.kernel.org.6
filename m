Return-Path: <linux-kernel+bounces-248681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10392E08B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4534F281CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792412FB0B;
	Thu, 11 Jul 2024 07:07:55 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638D82C6C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681675; cv=none; b=jIa7PyfBzhQy7/ZapcjXELAOKHwU8Utc/UbSVHomkMLaIKRDs9XHMEROEUwUI4Cqk2VjicMMS1kiIkiqG4nAw5UcBdVa5twoEJamH7gdRydlR8hylu5XtSHyCVpuCvkifxX3bXibxWQInVl3Na/DXstBG/mkA8+lwlyoUOKUJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681675; c=relaxed/simple;
	bh=1cflDGwK7k00vOVD3jt/VsX0HzcFBwyfn1MsA1MEkxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KByiYWRT5CPoaYsY2aFrKTEoCk6pSwXKeAOwfK0a0dFXDWZ5XbPYy4XCUFSpioMwAELcQbIl3ZR750rPNVA9pOZWYPb64aofBtAK2AmmqYzCZOiTDni6PPtS9WtXHY6CQ9itK6h+AT/lCVo16yv6/LgBIpsTGiQCX8A4TMGQ56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 46B76Vht095028;
	Thu, 11 Jul 2024 15:06:31 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 6F1402307389;
	Thu, 11 Jul 2024 15:10:48 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Thu, 11 Jul 2024 15:06:33 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <akpm@linux-foundation.org>
CC: <jiaoxupo@h3c.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shaohaojize@126.com>, <zhang.chuna@h3c.com>,
        <zhang.zhansheng@h3c.com>, <zhang.zhengming@h3c.com>
Subject: [PATCH v2] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock.?=
Date: Thu, 11 Jul 2024 15:07:56 +0800
Message-ID: <1720681676-53147-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20240710103611.809895ff809df9ed411bfaa8@linux-foundation.org>
References: <20240710103611.809895ff809df9ed411bfaa8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 46B76Vht095028

>> Use kmap_high and kmap_XXX or kumap_xxx among differt cores at the 
>> same time may cause deadlock. The issue is like this：


>What is kmap_XXX?

kmap/kunmap.

>>  CPU 0:                                                 CPU 1:
>>  kmap_high(){                                           kmap_xxx() {
>>                ...                                        irq_disable();
>>         spin_lock(&kmap_lock)
>>                ...
>>         map_new_virtual                                     ...
>>            flush_all_zero_pkmaps
>>             flush_tlb_kernel_range        /* CPU0 holds the kmap_lock */
>>                 smp_call_function_many         spin_lock(&kmap_lock)
>>                       ...                                   ....
>>         spin_unlock(&kmap_lock)
>>                ...
>> 
>> CPU 0 holds the kmap_lock, waiting for CPU 1 respond to IPI. But CPU 1 
>> has disabled irqs, waiting for kmap_lock, cannot answer the IPI. Fix 
>> this by releasing  kmap_lock before call flush_tlb_kernel_range, avoid 
>> kmap_lock deadlock.
>> 
>> Fixes: 3297e760776a ("highmem: atomic highmem kmap page pinning")

>Wow, that's 15 years old.  Has the deadlock been observed?

Yeah, the device crashed due to this reason. 
 
>> --- a/mm/highmem.c
>> +++ b/mm/highmem.c
>> @@ -220,8 +220,11 @@ static void flush_all_zero_pkmaps(void)
>>  		set_page_address(page, NULL);
>>  		need_flush = 1;
>>  	}
>> -	if (need_flush)
>> +	if (need_flush) {
>> +		unlock_kmap();
>>  		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
>> +		lock_kmap();
>> +	}
>>  }

>Why is dropping the lock like this safe?  What data is it protecting and why is it OK to 
>leave that data unprotected here?

kmap_lock is used to protect pkmap_count, pkmap_page_table and last_pkmap_nr(static variable). 
When call flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP)), flush_tlb_kernel_range
will neither modify nor read these variables. Leave that data unprotected here is safe.
-- 
1.8.3.1


