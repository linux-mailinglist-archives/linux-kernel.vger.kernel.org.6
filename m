Return-Path: <linux-kernel+bounces-278384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA9694AF90
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79CC4B24945
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D713E02E;
	Wed,  7 Aug 2024 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o8In/KR9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q/AR+8Gw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AD762DF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054872; cv=none; b=mFtloGOUg1plXl6AwkGS5bhpzRHg66fWTkCos/z6XRkP1ExHM9qrmVk+eDF+t7jkAkftyB5TLzqXt6ifCIzz4ATa1JW1hxBbTLZJderNJaXFwlspOp7rP/wqcN4racltKsRLIQNmeuoJcjnSGToE0+gOf26kkFfRF+AcYCbMuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054872; c=relaxed/simple;
	bh=FD9Tpd1iL3F0FAsGJjkeeLcfZM9a1xLxGOk1VpxfNvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D05GpgGsoxzFeVZ6F6ysJTYn1nV5t3juH3MoHDjGoihmNph9kJGTPQ+QQEs0gN7NAWyM78ne21G11uXzKdBQHGwlKdLRKbCP5OUAw2h35vCCqfMl682h0KJfRFlfv3STEU5+rrdFP+IuiEqQGTF3dnnrDx/U3qcQ6wMXaWMOzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o8In/KR9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q/AR+8Gw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723054868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2HrLmZ9XeHOhUS8WYo0E0BBl1AsID+YPzMkVyxdWeqc=;
	b=o8In/KR9wW9IGRyuBxLNV4pqUidRxrRczrg2XlNey/cWD47peE21R7cr9CNuI0hVqzsfb4
	HUV/hEl8eG/zzHkShAOQ6fzCktsimR5QEN9utvbC8C2JXb/i64zGBvk1SlGIKf2pdj/+ql
	gd3o7sgJPzRLKmrJV3brNU7c/nQ5YkXnq62V8bTic0013zABO3DZFAq21b9mp3l3DDLvaM
	qT7QM4Fu2QoxtSL0g/PuTbWw6hoPapyaGuC+4kV7B2MfPZi3s3ycnMpboZw4obvlKx4mpZ
	Ud58UoIlGUSOTUa+K1/vVyT+E6h9HM4XgR7DBiAiZI3AlEj0WXkkO8p/9K9M2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723054868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2HrLmZ9XeHOhUS8WYo0E0BBl1AsID+YPzMkVyxdWeqc=;
	b=q/AR+8GwWpPjpOxD5eYfL1QahX2Nrc3iyA71yGYklpQhkI1QVAXPmm7FGSZiq4aWDvwuv0
	ndzimejTo/WWiYCg==
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
 andrew.cooper3@citrix.com, seanjc@google.com
Subject: Re: [PATCH v1 1/3] x86/entry: Test ti_work for zero before
 processing individual bits
In-Reply-To: <874j7w2oju.ffs@tglx>
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-2-xin@zytor.com> <874j7w2oju.ffs@tglx>
Date: Wed, 07 Aug 2024 20:21:08 +0200
Message-ID: <87v80c19ez.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 07 2024 at 20:08, Thomas Gleixner wrote:
> On Tue, Aug 06 2024 at 22:47, Xin Li wrote:
>> In most cases, ti_work values passed to arch_exit_to_user_mode_prepare()
>> are zeros, e.g., 99% in kernel build tests.  So an obvious optimization
>> is to test ti_work for zero before processing individual bits in it.
>>
>> In addition, Intel 0day tests find no perf regression with this change.
>>
>> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> ---
>>  arch/x86/include/asm/entry-common.h | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
>> index fb2809b20b0a..4c78b99060b5 100644
>> --- a/arch/x86/include/asm/entry-common.h
>> +++ b/arch/x86/include/asm/entry-common.h
>> @@ -47,15 +47,17 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
>>  static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>>  						  unsigned long ti_work)
>>  {
>> -	if (ti_work & _TIF_USER_RETURN_NOTIFY)
>> -		fire_user_return_notifiers();
>> +	if (unlikely(ti_work)) {
>> +		if (ti_work & _TIF_USER_RETURN_NOTIFY)
>> +			fire_user_return_notifiers();
>>  
>> -	if (unlikely(ti_work & _TIF_IO_BITMAP))
>> -		tss_update_io_bitmap();
>> +		if (unlikely(ti_work & _TIF_IO_BITMAP))
>> +			tss_update_io_bitmap();
>>  
>> -	fpregs_assert_state_consistent();
>
> Please keep this unconditional and independent of ti_work. It's a debug
> feature and you kill coverage with making it conditional on ti_work.

Also spare the extra indentation level and do:

static inline void arch_exit_work(unsigned long ti_work)
{
	if (ti_work & _TIF_USER_RETURN_NOTIFY)
		fire_user_return_notifiers();

	if (unlikely(ti_work & _TIF_IO_BITMAP))
		tss_update_io_bitmap();

	fpregs_assert_state_consistent();
	if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
		switch_fpu_return();
}

static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
						  unsigned long ti_work)
{
	if (IS_ENABLED(CONFIG_X86_DEBUG_FPU) || unlikely(ti_work))
		arch_exit_work(ti_work);
        ...

Thanks,

        tglx


