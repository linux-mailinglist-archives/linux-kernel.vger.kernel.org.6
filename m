Return-Path: <linux-kernel+bounces-549503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D58EA5534F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAE83B0676
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0767025D54E;
	Thu,  6 Mar 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pascal-lab.net header.i=@pascal-lab.net header.b="b7CyRVsS"
Received: from out198-191.us.a.mail.aliyun.com (out198-191.us.a.mail.aliyun.com [47.90.198.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2EB25A35E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283019; cv=none; b=BYx0i08bugD5tTR9xOqbXaiJZS6zTpozLpSH8/H9pASmJclC6xVT2gxMciiSzbvJsO013M1GTYfveuTTlQPrZZmc3U9d0hcafoeusZ1PerWXNiK/cNydt4HCHYi8XWNgUlte5Mhc/YMUJUEIUE1jhXpAaIBkb1rqZv4paKiCckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283019; c=relaxed/simple;
	bh=ceAxW0wcpCgaPLr4vhaECO1Q+DYRORbjOyasSwcXyMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTcZgF9ysbBqKU7hiJShet1uTTJ41YEFhe5hGrtBmkmwdWuKod3jBSvcqHMJbLo+4DFTAFADZvtObW5Wyb9gdpieZrj8JoeAqzgtzsc5rmjokBXpW6fNu9s42hNpfn4VoxhCOR6JYWqU7yWoIKBHNzYkU36O7km8i9uKW4YvPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pascal-lab.net; spf=pass smtp.mailfrom=pascal-lab.net; dkim=pass (1024-bit key) header.d=pascal-lab.net header.i=@pascal-lab.net header.b=b7CyRVsS; arc=none smtp.client-ip=47.90.198.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pascal-lab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pascal-lab.net
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=pascal-lab.net; s=default;
	t=1741283004; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eAGkuDLEsX76lQqIfTyLCBObjDcJx0xLHtbT0UI2peU=;
	b=b7CyRVsSCZzI0BG0lntyY7o/+49Txs4uAqHmoiC3sFcMu8/oPmpL01kLRlGYuhskfeLJc0+vv/R/RBSTj2XAxZFrgOl7N8UTxRoBshy3FQJNxupyDsDRPZGAT0Sd62dAud6okx92A9nVnG9lyGYkQ0hjheCkEO/Q1K8vTfGGzwU=
Received: from archlinux.nju.edu.cn(mailfrom:yujundong@pascal-lab.net fp:SMTPD_---.bmGopiL_1741279337 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 07 Mar 2025 00:42:19 +0800
From: Yujun Dong <yujundong@pascal-lab.net>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yujundong@pascal-lab.net
Subject: Re: [PATCH] cpuidle, sched: Use smp_mb__after_atomic() in current_clr_polling()
Date: Fri,  7 Mar 2025 00:42:17 +0800
Message-ID: <20250306164217.3028977-1-yujundong@pascal-lab.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z740eIZcK31DQETq@gmail.com>
References: <Z740eIZcK31DQETq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ingo, 

* Ingo Molnar <mingo@kernel.org> wrote:
>
> [ Sorry about the belated reply, found this in my TODO pile ... ]
>
> * Yujun Dong <yujundong@pascal-lab.net> wrote:
>
>> In architectures that use the polling bit, current_clr_polling() employs
>> smp_mb() to ensure that the clearing of the polling bit is visible to
>> other cores before checking TIF_NEED_RESCHED.
>>
>> However, smp_mb() can be costly. Given that clear_bit() is an atomic
>> operation, replacing smp_mb() with smp_mb__after_atomic() is appropriate.
>>
>> Many architectures implement smp_mb__after_atomic() as a lighter-weight
>> barrier compared to smp_mb(), leading to performance improvements.
>> For instance, on x86, smp_mb__after_atomic() is a no-op. This change
>> eliminates a smp_mb() instruction in the cpuidle wake-up path, saving
>> several CPU cycles and thereby reducing wake-up latency.
>>
>> Architectures that do not use the polling bit will retain the original
>> smp_mb() behavior to ensure that existing dependencies remain unaffected.
>>
>> Signed-off-by: Yujun Dong <yujundong@pascal-lab.net>
>> ---
>>  include/linux/sched/idle.h | 23 ++++++++++++++++-------
>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
>> index e670ac282333..439f6029d3b9 100644
>> --- a/include/linux/sched/idle.h
>> +++ b/include/linux/sched/idle.h
>> @@ -79,6 +79,21 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
>>  	return unlikely(tif_need_resched());
>>  }
>>  
>> +static __always_inline void current_clr_polling(void)
>> +{
>> +	__current_clr_polling();
>> +
>> +	/*
>> +	 * Ensure we check TIF_NEED_RESCHED after we clear the polling bit.
>> +	 * Once the bit is cleared, we'll get IPIs with every new
>> +	 * TIF_NEED_RESCHED and the IPI handler, scheduler_ipi(), will also
>> +	 * fold.
>> +	 */
>> +	smp_mb__after_atomic(); /* paired with resched_curr() */
>> +
>> +	preempt_fold_need_resched();
>> +}
>> +
>>  #else
>>  static inline void __current_set_polling(void) { }
>>  static inline void __current_clr_polling(void) { }
>> @@ -91,21 +106,15 @@ static inline bool __must_check current_clr_polling_and_test(void)
>>  {
>>  	return unlikely(tif_need_resched());
>>  }
>> -#endif
>>  
>>  static __always_inline void current_clr_polling(void)
>>  {
>>  	__current_clr_polling();
>>  
>> -	/*
>> -	 * Ensure we check TIF_NEED_RESCHED after we clear the polling bit.
>> -	 * Once the bit is cleared, we'll get IPIs with every new
>> -	 * TIF_NEED_RESCHED and the IPI handler, scheduler_ipi(), will also
>> -	 * fold.
>> -	 */
>>  	smp_mb(); /* paired with resched_curr() */
>
> So this part is weird: you remove the comment that justifies the 
> smp_mb(), but you leave the smp_mb() in place. Why?
>
> Thanks,
>
> 	Ingo

Thanks for pointing that out. The comment removal in the non-polling
branch was intentional, but my original explanation was unclear. Let
me rephrase:

Polling architectures (with the TIF_POLLING flag):
1. __current_clr_polling() performs atomic ops -> 
Use smp_mb__after_atomic()
2. Keep original "clear polling bit" comment as it directly explains
the barrier's purpose.

Non-polling architectures (#else branch):
1. __current_clr_polling() is a no-op -> Original comment about
"clearing the bit" becomes misleading.
2. However, the smp_mb() must remain to preserve pre-existing memory
ordering guarantees. And explicitly documenting it requires new
wording to avoid confusion.

Proposed approaches:
Option A: Add a comment for non-polling smp_mb() like "Paired with
resched_curr(), as per pre-existing memory ordering guarantees"
Option B: Leave code as-is (no comment) and elaborate in the commit
message: "For non-polling architectures, retain smp_mb() to avoid
subtle regressions, while intentionally omitting the bit-specific
comment that no longer applies."

Which direction would you consider most maintainable? Your insight
would be greatly appreciated.

Best regards,
Yujun

