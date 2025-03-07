Return-Path: <linux-kernel+bounces-550271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A991A55D66
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4F3170B6E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FD316631C;
	Fri,  7 Mar 2025 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pascal-lab.net header.i=@pascal-lab.net header.b="U9ncMhyc"
Received: from out28-67.mail.aliyun.com (out28-67.mail.aliyun.com [115.124.28.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5185931
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741312765; cv=none; b=qUsTbyR7Ui4mf/X1iFP9Ye+of+CIxIL6C6924rjeHnA/m7/sv2RG/yTjjClmVQRT1+W8C466EkpP8l6rEBDQHA7VMbc9s2g55bERRpMymZ3Y0ATwzc8N5EZu0e7t2MK21G20ls93Hnj3uscP0DOe4PelNM/Ca2E1ZwHNhelmkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741312765; c=relaxed/simple;
	bh=ceAxW0wcpCgaPLr4vhaECO1Q+DYRORbjOyasSwcXyMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBkGgcILLxRFtnNnUol82sViy/CWqV/lJzXSUR6BNWmjce2iMwqaeaaB9gmZzkwoINJqat58fxEW6pPXVrawGZA+4GAu2LbwS3LONeyNgDUgxQk9b7qR6RM7QEjyNF0hg8kdbts5fFfd3vJwgDTtIh4g53gtFPrOTeaDWUkHAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pascal-lab.net; spf=pass smtp.mailfrom=pascal-lab.net; dkim=pass (1024-bit key) header.d=pascal-lab.net header.i=@pascal-lab.net header.b=U9ncMhyc; arc=none smtp.client-ip=115.124.28.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pascal-lab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pascal-lab.net
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=pascal-lab.net; s=default;
	t=1741312759; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eAGkuDLEsX76lQqIfTyLCBObjDcJx0xLHtbT0UI2peU=;
	b=U9ncMhycXSKouzrRXz+i7R5AqpBbYdHtjsvV06Beh3LKjuWOFSXzNfuQNZc9BlEAoFTpNW33dd+W0DvYcdeGtABzt+OvU1gWFBLV3aonSSReMfXJd/e/F1KbuhHNJzqR86uj9pvwG8FJIw6wfTGCqPBL7N5PI5kq/7IrgnK75f4=
Received: from archlinux.nju.edu.cn(mailfrom:yujundong@pascal-lab.net fp:SMTPD_---.bmZnPeR_1741312441 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 07 Mar 2025 09:54:02 +0800
From: Yujun Dong <yujundong@pascal-lab.net>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yujundong@pascal-lab.net
Subject: Re: [PATCH] cpuidle, sched: Use smp_mb__after_atomic() in current_clr_polling()
Date: Fri,  7 Mar 2025 09:53:44 +0800
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

