Return-Path: <linux-kernel+bounces-312798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBBA969B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EC11F2493E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D361A42AB;
	Tue,  3 Sep 2024 11:23:54 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589D1B12E9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362634; cv=none; b=Riczf2s+sPEyMsTdRkZMGZ8kxZ9tj5bmrDI+ij7VZNlxwE6fqvP4vRsuMur1xZpdsq4dlGGrdg8/DyGsuFnlPQ88miLb1GmvxR6FvVfv52om93t7bwNPZu4x7loxhL7cUh5qiX+jR0gKnt9BrVaIRM16DVoI28wdiAac24N8tE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362634; c=relaxed/simple;
	bh=JaGUiRQtMj4JTm4ZqumIazS8EjiQPlqpupWFtVCGWsw=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bkgKmiRMT2Jo5AllbCyIx4fmd7vRuoC6QJfYbKNwS+01Q2QWVjd6qrDOm6vCQwuiV03TiJaoDh0/5FWw/OMeW0ZgHdCb04ogIza0MV+5sBolhalVXAWdpxD5pG4ftz7oKTPdzbfQeL59Rpc0djMhe/tj60/kyBK2q5mfJNRMk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wyjt93sjPz2Cp6N;
	Tue,  3 Sep 2024 19:23:29 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FC0714011F;
	Tue,  3 Sep 2024 19:23:48 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 19:23:48 +0800
Subject: Re: [PATCH 2/5] debugobjects: Remove redundant checks in fill_pool()
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-3-thunder.leizhen@huawei.com> <87plpl8422.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a6b2ca3b-ebde-1f6d-0cf2-de5017e57bf9@huawei.com>
Date: Tue, 3 Sep 2024 19:23:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87plpl8422.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/3 17:44, Thomas Gleixner wrote:
> On Mon, Sep 02 2024 at 22:05, Zhen Lei wrote:
>> The conditions for the inner and outer loops are exactly the same, so the
>> outer 'while' should be changed to 'if'. Then we'll see that the
>> second
> 
> We'll see nothing. Please write change logs in passive voice and do not
> try to impersonate code.

OK

> 
>> condition of the new 'if' is already guaranteed above and can be
>> removed.
> 
> Yes, the conditions are the same. But a 'if' is not the same as a 'while'.
> 
> So you need to explain why the outer loop is not required and why it
> does not make a difference in terms of functionality.

OK, I'll write a good description in V2.

> 
>> @@ -142,8 +142,7 @@ static void fill_pool(void)
>>  	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
>>  	 * sections.
>>  	 */
> 
> The comment does not make sense anymore. Please fixup comments when
> changing the code. It's a pain to read a comment and then see that the
> code does something different.

OK

> 
>> -	while (READ_ONCE(obj_nr_tofree) &&
>> -	       READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
>> +	if (READ_ONCE(obj_nr_tofree)) {
>>  		raw_spin_lock_irqsave(&pool_lock, flags);
>>  		/*
>>  		 * Recheck with the lock held as the worker thread might have
> 
> Thanks,
> 
>         tglx
> 
> .
> 

-- 
Regards,
  Zhen Lei

