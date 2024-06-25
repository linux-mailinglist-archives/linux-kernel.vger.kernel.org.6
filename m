Return-Path: <linux-kernel+bounces-229353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E7D916EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B983D1C2323D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E3175571;
	Tue, 25 Jun 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="orxw8gKU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7gjZlCzt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D61459E2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334880; cv=none; b=jcYzOtCLJmUbvFj3Gu9/faUet+eEWKBwqKBwAfpQJPC8dKFJ1hXGfa+EprI3j91bcKmq8ujIF400OdcUU4zag3nI+Zi6jAhOvbJqSQchm/JL0rY4wdBM/jvX5T+CjzuhCQaUPRUpJov5kvn5phYmBUtLBbOH9/gsPuBgS2C1tUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334880; c=relaxed/simple;
	bh=kBWLRp3ypWzYrlVDDZqOPvG4ZJoCBU4nQ4kJVTALPR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XLOUaIcb3/kESbd8TmLKvjxQZJpN5HBU2pFfdfZ4iGV577QyREge3PSAnvSiIG6+Tap737NAYaijeyNh/aewofqHS1WCX685NkhFhLfIgDaHpHIlDeoRfh6LJbbyOp0Lw1g7w9KYmhTbAs9WKSSUBZuAgUmaA4kOE/uUigWhD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=orxw8gKU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7gjZlCzt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719334877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKXkwwu4nzLj1zW6It22vxejWp+j65I6Gm8pgE3Pn48=;
	b=orxw8gKUuBANxkKs9duqGx7KbBPRgtz7uSpay4a2KS12B9QBOpsNcKR1Go+D4h7riFwTBw
	2YNVMhwBuseudR1lFlCZVmlkg1y0Tkbaqk0wvWh9wyuyS02ZmC+yHnB1COQd3r483zzkhQ
	JJxxA4pPyspDmPpdE3GJFtuCatDYXPRVM6fbsvrwNrLd47J9cY6v0ZTwd+nH28WraRHssY
	0fU+74Gd4e1uaGTVtG7MsuBP0FgChR7bua4fjAed9uwrB/bFZHqLv8n0LhOM49+bAOC3G2
	UdStk+4g1a5ILXbG390/VCf5OTKCesfb/TxC0o2fKf/CDhzoyIMKMbyECV8ghg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719334877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKXkwwu4nzLj1zW6It22vxejWp+j65I6Gm8pgE3Pn48=;
	b=7gjZlCztOG6Y4jlX1IkoSuBzAVVxxgLpz8iRsIkA0KbgJgb7XA1iz1i0RU5yuM0ZaHWZeN
	6L4TxOb2O+PC/gAQ==
To: Xin Li <xin@zytor.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>,
 linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin3.li@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] x86/fred: Always install system interrupt handler
 into IDT
In-Reply-To: <49c53a1a-55b2-441e-8ec2-1a2d87a3ccc4@zytor.com>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
 <2f632ef59c8c9cc27c3702bc2d286496ed298d65.1718972598.git.houwenlong.hwl@antgroup.com>
 <dca1635b-1e08-4dbb-9dbb-335cbdcf9b9d@zytor.com> <87jzid5hmb.ffs@tglx>
 <49c53a1a-55b2-441e-8ec2-1a2d87a3ccc4@zytor.com>
Date: Tue, 25 Jun 2024 19:01:17 +0200
Message-ID: <871q4l5542.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 25 2024 at 09:30, Xin Li wrote:

> On 6/25/2024 5:31 AM, Thomas Gleixner wrote:
>> On Tue, Jun 25 2024 at 02:19, Xin Li wrote:
>>> On 6/21/2024 6:12 AM, Hou Wenlong wrote:
>>>> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
>>>> index d4f24499b256..daee9f7765bc 100644
>>>> --- a/arch/x86/include/asm/idtentry.h
>>>> +++ b/arch/x86/include/asm/idtentry.h
>>>> @@ -470,8 +470,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
>>>>    #define sysvec_install(vector, function) {				\
>>>>    	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
>>>>    		fred_install_sysvec(vector, function);			\
>>>> -	else								\
>>>> -		idt_install_sysvec(vector, asm_##function);		\
>>>
>>> empty line, it improves readability.
>>>
>>> And please put a comment here to explain why this is unconditionally
>>> done for IDT.
>> 
>> Wait. If we need this during early boot, then why don't we enable FRED
>> earlier?
>
> Unconditionally call idt_install_sysvec() is still needed, right?

Not when we enable FRED early enough.

> But this sounds a smart move to me!  Because it helps to deal with not
> only the initialization order issue, but also the following cases in a
> longer term:
>
> 1) BIOS enables FRED and keeps it enabled when transferring control to
>     Linux.  Then we just need to disable FRED when it is disabled in the
>     kernel command line.
>
> 2) IDT support is removed from a kernel config thus a kernel binary, say
>     a new kernel config CONFIG_X86_IDT is added and set to N.
>
> And we need to:
>
> 1) Find a place to enable FRED as early as possible if not yet enabled.
>
> 2) Disable FRED when fred=off is in the kernel command line.
>
> Anything I missed?

No.

Thanks,

        tglx

