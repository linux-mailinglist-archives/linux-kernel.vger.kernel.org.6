Return-Path: <linux-kernel+bounces-256575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751E1935084
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA74283FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C3A144D22;
	Thu, 18 Jul 2024 16:17:49 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352F139580
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721319469; cv=none; b=JJ4P8WhpRf21EDnvLDsr4IXgxy46N2Z6VUX8GP12ico7ZRRFxyjzabstEHbJkjlqWGQ/bf7KOvbFHpeyxiFoL6R62BDH9liHHsnfj7GcAuJfolUK+lSD6PB9mnJX+Xl0mwjYPBQzhEV3rRtq4jmMh7Q9hK8yFVMhZucx03BEmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721319469; c=relaxed/simple;
	bh=dqSd8wfLPnLEIbot77ROpng07zk/Fqu2JWeroHiHHvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fl4l7dmSx2WXO2fkPetp/XaAcYn+djJD1MNoIIOSpztjcXQLn9p3ci2DphWOkgnuwKlPn4/7W4KUcL4gm4AWegT20aXDoxKjaPIF9PgaSs6CxBvQuitoPcPQ7iEIM2i90NVocDzs8t9jG59lS5bP8r1tjrcKxSl52ngouWeeYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 46IGH1dk085127;
	Fri, 19 Jul 2024 00:17:01 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 9F4DB2004BAA;
	Fri, 19 Jul 2024 00:21:30 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Fri, 19 Jul 2024 00:17:05 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <akpm@linux-foundation.org>
CC: <jiaoxupo@h3c.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shaohaojize@126.com>, <zhang.chuna@h3c.com>,
        <zhang.zhansheng@h3c.com>, <zhang.zhengming@h3c.com>
Subject: [PATCH v2] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock.?=
Date: Fri, 19 Jul 2024 00:18:32 +0800
Message-ID: <1721319512-23585-1-git-send-email-zhang.chuna@h3c.com>
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
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 46IGH1dk085127

Very sorry to disturb! Just a friendly ping to check in on the status of the 
patch "Give kmap_lock before call flush_tlb_kernel_rang，avoid kmap_high deadlock.".  
Please let me know if there is any additional information from my side.

Sincerely look forward to your suggestions and guidance!

>>> >> --- a/mm/highmem.c
>>> >> +++ b/mm/highmem.c
>>> >> @@ -220,8 +220,11 @@ static void flush_all_zero_pkmaps(void)
>>> >>       set_page_address(page, NULL);
>>> >>       need_flush = 1;
>>> >>   }
>>> >> - if (need_flush)
>>> >> + if (need_flush) {
>>> >> +     unlock_kmap();
>>> >>       flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
>>> >> +     lock_kmap();
>>> >> + }
>>> >>  }
>>> 
>>> >Why is dropping the lock like this safe?  What data is it protecting 
>>> >and why is it OK to leave that data unprotected here?
>>> 
>>> kmap_lock is used to protect pkmap_count, pkmap_page_table and last_pkmap_nr(static variable). 
>>> When call flush_tlb_kernel_range(PKMAP_ADDR(0), 
>>> PKMAP_ADDR(LAST_PKMAP)), flush_tlb_kernel_range will neither modify nor read these variables. Leave that data unprotected here is safe.

>>No, the risk here is that when the lock is dropped, other threads will modify the data.  And when this thread (the one running
>>flush_all_zero_pkmaps()) retakes the lock, that data may now be unexpectedly altered.

>map_new_virtual aims to find an usable entry pkmap_count[last_pkmap_nr]. When read and modify the pkmap_count[last_pkmap_nr], the kmap_lock is 
>not dropped. 
>"if (!pkmap_count[last_pkmap_nr])" determine pkmap_count[last_pkmap_nr] is usable or not. If unusable, try agin.

>Furthermore, the value of static variable last_pkmap_nr is stored in a local variable last_pkmap_nr, when kmap_lock is acquired, 
>this is thread-safe.

>In an extreme case, if Thread A and Thread B access the same last_pkmap_nr, Thread A calls function flush_tlb_kernel_range and release the 
>kmap_lock, and Thread B then acquires the kmap_lock and modifies the variable pkmap_count[last_pkmap_nr]. After Thread A completes 
>the execution of function flush_tlb_kernel_range, it will check the variable pkmap_count[last_pkmap_nr]. 
>If pkmap_count[last_pkmap_nr] != 0, Thread A continue to call get_next_pkmap_nr and get next last_pkmap_nr. 

>static inline unsigned long map_new_virtual(struct page *page)
>{
>        unsigned long vaddr;
>        int count;
>        unsigned int last_pkmap_nr; // local variable to store static variable last_pkmap_nr
>        unsigned int color = get_pkmap_color(page);

>start:
>        ...
>                        flush_all_zero_pkmaps();// release kmap_lock, then acquire it
>                        count = get_pkmap_entries_count(color);
>                } 
>                ...
>                if (!pkmap_count[last_pkmap_nr]) // pkmap_count[last_pkmap_nr] is used or not
>                        break;  /* Found a usable entry */
>                if (--count) 
>                        continue;
>
>               ...
>        vaddr = PKMAP_ADDR(last_pkmap_nr);
>        set_pte_at(&init_mm, vaddr,
>                   &(pkmap_page_table[last_pkmap_nr]), mk_pte(page, kmap_prot));
>
>        pkmap_count[last_pkmap_nr] = 1;
>        ...
>        return vaddr;
>}
   
-- 
1.8.3.1


