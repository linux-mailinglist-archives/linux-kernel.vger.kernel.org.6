Return-Path: <linux-kernel+bounces-325403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABED97593F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102791F23996
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590641B2ECE;
	Wed, 11 Sep 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jpfr9b8O"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE261B251A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075460; cv=none; b=ZGN4ZjydgKUH5FoR8xJQFrYmBFz9I6UbrUjbmBOq0BpOx4YuMhdfPBgFbcFUTsx/CE1/kk2T5gK7RypP8xzkZm9TgIGNboJ4y3tw2ViQvONXL5ukWb1xKeCcgn3Q+JNjPNje9FC1sAC996e23Q2GX4vciH94X//hT13Ax35N56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075460; c=relaxed/simple;
	bh=XFs0Nh/hOrp5kuukoiTsZ1BajDbH+w0gqLETXRYqyHo=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=tQIEYotxpcPPE/Y9CMgEuv6ajpyU4Qhpve6cpqpju4k2mMVncHcJ4td0hVVTyYr8P1FS/J0Lh38w+9Lfhp7cIalFh2P77Y68HPUwakhXa739tdvdRc5bfQUDy0RfmlOfMRYlteGhXx+cJUtSi8t8MIHKczKEd3XNimi55KOkAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jpfr9b8O; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1aa529e30eso277270276.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726075458; x=1726680258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SaSesydasxzfbVhVncU6hEY4UY7i9QKYOocGcFq6lVw=;
        b=Jpfr9b8O7aI/k+j93LNwHynWn6CaJe3d9RqwHdfQaVrNvLtB2TQEmL9GPRFSHY3YHv
         wWqIWyspltFStFntlCG5UrOIclxAXXuBtSfmlsxGrucb9KSuXarCO6fUd3gDodlkR8j0
         Rp28ReoTZ5F7lgJ+KkT5xXU01zxR0INIZQn5ZmIABMnlCkJhsaM35VuymCxwS0c8tL07
         QtKSyVhpBeiUUoNMWvs8e963C+3H8wxfGLdYql70FK8yTWsqcyJ0V7PGsBPk8tHl3Wbj
         14NHeTZFBnOa/nMysLOEO7+aUJp3JFQ5uyMCGpEkolLozilOYUfArgwm80M/2ocAJhZd
         iEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075458; x=1726680258;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaSesydasxzfbVhVncU6hEY4UY7i9QKYOocGcFq6lVw=;
        b=kpuGPQdvrn9KIKEjwxNh/g6GhrXnERCjP94xjU4gzAU0rDR0bgZEIsNDeVdPHP+r/6
         OP608E4QG4Y02QHFm9dE4C48kGxQLx0zbv7X+JVoC4qhmCoLJQdgGWpZlDXA/dPGVmZr
         6G4shmrNZS0Y9ypWczzquq7pDsDMuF8ZyxZpDTN5TB+6s+GdhS4F2CwIe4Qm6RH0OmwQ
         /b1lDNyrNu1CCXKjfH1DYdG/wsI5sdmpMCXVgfd9/97hqdPKjWlTT+39+OdKBOVIYUMK
         JhhowzsdbNk/ap7WgtAGjBIZRTIrfWXnqlJy2KcebPeuLmfGjV5hcb0vHwTx8j/74zzZ
         75yA==
X-Forwarded-Encrypted: i=1; AJvYcCUbeQWqbJWfoCb2EnEqBpqGjKPE0OJG7zhmobX13AJ7f6jGggyrr5Pda0u06Fb2kvbsYBnjmUAPbdz0rFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMcrWy2lZnME5pBHTvcmD6HdMAXdzVdInKY0XI0DzvNuEq50O
	2XmVC4JCGl5vbBrgMgZyTPIE553PoCnZnaqAGKeomg03jiMOuiZw4Ywzir6DwmElvIiXRVeRkqi
	txkBViz4BnN6bJdGi9dkkwA==
X-Google-Smtp-Source: AGHT+IF0bUdUbcCOClt0/WYli3uuDRUJs0keADgBT2fi3kki6SRriwc15ZsmXxjB7diodiG4JkONa9BVdzmH2TzP6g==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:529:b0:e1d:96a7:c9b1 with
 SMTP id 3f1490d57ef6-e1d9dc2cfd7mr203276.6.1726075457958; Wed, 11 Sep 2024
 10:24:17 -0700 (PDT)
Date: Wed, 11 Sep 2024 17:24:17 +0000
In-Reply-To: <ZtmHBuggqUr3ncw6@J2N7QTR9R3> (message from Mark Rutland on Thu,
 5 Sep 2024 11:25:10 +0100)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnty13ycddq.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 1/5] arm: perf: Drop unused functions
From: Colton Lewis <coltonlewis@google.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: kvm@vger.kernel.org, oliver.upton@linux.dev, seanjc@google.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, will@kernel.org, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Mark Rutland <mark.rutland@arm.com> writes:

> On Wed, Sep 04, 2024 at 08:41:29PM +0000, Colton Lewis wrote:
>> perf_instruction_pointer() and perf_misc_flags() aren't used anywhere
>> in this particular perf implementation. Drop them.

> I think it'd be better to say that arch/arm's implementation of these is
> equivalent to the generic versions in include/linux/perf_event.h, and so
> arch/arm doesn't need to provide its own versions. It doesn't matter if
> arch/arm uses them itself since they're being provided for the core perf
> code.

> With words to that effect:

Done

> Acked-by: Mark Rutland <mark.rutland@arm.com>

> Mark.


>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm/include/asm/perf_event.h |  7 -------
>>   arch/arm/kernel/perf_callchain.c  | 17 -----------------
>>   2 files changed, 24 deletions(-)

>> diff --git a/arch/arm/include/asm/perf_event.h  
>> b/arch/arm/include/asm/perf_event.h
>> index bdbc1e590891..c08f16f2e243 100644
>> --- a/arch/arm/include/asm/perf_event.h
>> +++ b/arch/arm/include/asm/perf_event.h
>> @@ -8,13 +8,6 @@
>>   #ifndef __ARM_PERF_EVENT_H__
>>   #define __ARM_PERF_EVENT_H__

>> -#ifdef CONFIG_PERF_EVENTS
>> -struct pt_regs;
>> -extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
>> -extern unsigned long perf_misc_flags(struct pt_regs *regs);
>> -#define perf_misc_flags(regs)	perf_misc_flags(regs)
>> -#endif
>> -
>>   #define perf_arch_fetch_caller_regs(regs, __ip) { \
>>   	(regs)->ARM_pc = (__ip); \
>>   	frame_pointer((regs)) = (unsigned long) __builtin_frame_address(0); \
>> diff --git a/arch/arm/kernel/perf_callchain.c  
>> b/arch/arm/kernel/perf_callchain.c
>> index 1d230ac9d0eb..a2601b1ef318 100644
>> --- a/arch/arm/kernel/perf_callchain.c
>> +++ b/arch/arm/kernel/perf_callchain.c
>> @@ -96,20 +96,3 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx  
>> *entry, struct pt_regs *re
>>   	arm_get_current_stackframe(regs, &fr);
>>   	walk_stackframe(&fr, callchain_trace, entry);
>>   }
>> -
>> -unsigned long perf_instruction_pointer(struct pt_regs *regs)
>> -{
>> -	return instruction_pointer(regs);
>> -}
>> -
>> -unsigned long perf_misc_flags(struct pt_regs *regs)
>> -{
>> -	int misc = 0;
>> -
>> -	if (user_mode(regs))
>> -		misc |= PERF_RECORD_MISC_USER;
>> -	else
>> -		misc |= PERF_RECORD_MISC_KERNEL;
>> -
>> -	return misc;
>> -}
>> --
>> 2.46.0.469.g59c65b2a67-goog


