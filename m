Return-Path: <linux-kernel+bounces-301718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C595F482
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9AC1F2297F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897F71925B3;
	Mon, 26 Aug 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SszDalbu"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE718E058;
	Mon, 26 Aug 2024 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684391; cv=none; b=GDm2moecgOBOhfQo7MEWVk5abnkMaVW2n9J7Si8WJ6mtXMQ1Xgy9MxhjD6/EaDEallvgNstN8ADex+sjmME6snnOdqfVXCy7rDXq6AFadjdepoLuvPoi51R1BZWU4XrWvUS1JJFCNWqTA2Wgv45TTLbQbaHwG6xJL4AEOf8sZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684391; c=relaxed/simple;
	bh=mboCcy8eE8VoWopa1aE0RTEnskSSkA+AcEIT/WbLRmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhw+JhfWYMvERA25zUMLTApJ3DseDZek2Qhs5oW4kp7W8T5cfSK8ni/pS/G21AAkLA0EdL+upKbaWeipzMIH602K8Hq8vxYMDNKIf+jbUi+S+krtoqUUPecjvud9PY61kfclRjafy4iFn0ADLtc8pS8tlIvr2qBx7KhZKbjX2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SszDalbu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so5631101a12.0;
        Mon, 26 Aug 2024 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724684388; x=1725289188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iC5W4YI3ekOiIiQAZjV2m8wLevRuxg18418X1UuEsQk=;
        b=SszDalbuQYUheZfSv6Q8UIulDz9c6Qur4bBp6Mqvgl76q7uJHaWdrvQ+cBvOOgOCPz
         FO5lJk0N3us2jgVd1vbKwu8DlXkZ/i2s8Oe1ncRPwT671fNcbcyF2oY2z/qlP28TF3ns
         SmsZqXjKG6ArB9hzQ/VKj5cDGvoZhF3eNu4TuXraf3JFtmZXf2dOeyS6humb/NYhBaIX
         6xA+JYcSRAw8ZQxt4D6wDabEYidE2fGpUqYTFinG6FsdTIPOJ8RDQ3ZXkDa+jSJDDuO2
         0ngNFDqL9KkSTg4v93teVa74VTyzKkRjPv7SOCfT+HFP+YMrUnygCeO8GYZPw+Em+qd1
         tgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724684388; x=1725289188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iC5W4YI3ekOiIiQAZjV2m8wLevRuxg18418X1UuEsQk=;
        b=B8X4AvpPJa8AgAm0CApOifaCEMl1+bSt2ws7PMEHDlVvCTkQzj9OxI4JEEUWUhE5ao
         +i6zh5ge4wp6y9O/GfCNOWW2pn8z1MkG1RSRn0/j/wMjqo79UkuGzAsch5FBIuI7+0wD
         HV3uJJfXFFZBR7IPJydCikCFeeWjOUsSQ/JykpjlFZbtK2nPbNRPH7Gls/hFbxmF3K75
         0FZaUPTJWVtUmv9XCtD7adoXfuqKRJVP/Ec2nRGAoDCUGcZcD1b662PHI5CQafybi4HL
         Ejp/1V1JgZdYUtY5WUdlNHIFVSZPCLAb2PLhNYiFZzHds1/EnRhSm5nTbPe+dmnDyDNl
         QJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCVccNj0lf+8by0QS+PQ7Dq+wwypDkQ4Jf8ar+gsMDaUhWG2mYlmeQaURbVdLZR7l1R9K0gGe2hR3abIHeKJNX4=@vger.kernel.org, AJvYcCXCRnvC1NumIEOF5GTdDKHlI2aVrrPTIjNfx7kNbb4By8Cmqyn/J0Tip3A+suq61JjqUNlHsq96uqpVJRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbUR3BaBz2jzZ+VtwmTBgbvvQ1b1zc4yKjeJWvUKcwI141SvR
	3eMRa0QutvHxlmOXgJgiUI5ixtBmob63JoRff5uI/GQxJ1HC/T6W
X-Google-Smtp-Source: AGHT+IF/53L/EqaoN8iv/IwSOanvlbp3GT/lJwqx7EsAUMflm2fPMFfb9pf4pwDWsT8KHE/Rf46iZA==
X-Received: by 2002:a05:6402:84b:b0:5c0:b793:df4e with SMTP id 4fb4d7f45d1cf-5c0b793e939mr529839a12.22.1724684387140;
        Mon, 26 Aug 2024 07:59:47 -0700 (PDT)
Received: from ?IPV6:2003:df:bf21:aa00:afae:5558:6eb4:dc84? (p200300dfbf21aa00afae55586eb4dc84.dip0.t-ipconnect.de. [2003:df:bf21:aa00:afae:5558:6eb4:dc84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a96d0sm5758540a12.86.2024.08.26.07.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:59:46 -0700 (PDT)
Message-ID: <afa6d33a-c933-4996-8cdf-e1677772d63e@gmail.com>
Date: Mon, 26 Aug 2024 16:59:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
To: Boqun Feng <boqun.feng@gmail.com>, Dirk Behme <dirk.behme@de.bosch.com>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Aakash Sen Sharma <aakashsensharma@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>
References: <20240802001452.464985-1-lyude@redhat.com>
 <20240802001452.464985-2-lyude@redhat.com>
 <3f6a5c86-8dc4-4a62-8308-5ca25f9e4aec@de.bosch.com>
 <ZsyPezklN_tANFtQ@boqun-archlinux>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <ZsyPezklN_tANFtQ@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 26.08.24 um 16:21 schrieb Boqun Feng:
> On Mon, Aug 26, 2024 at 01:21:17PM +0200, Dirk Behme wrote:
>> Hi Lyude,
>>
>> On 02.08.2024 02:10, Lyude Paul wrote:
>>> This introduces a module for dealing with interrupt-disabled contexts,
>>> including the ability to enable and disable interrupts
>>> (with_irqs_disabled()) - along with the ability to annotate functions as
>>> expecting that IRQs are already disabled on the local CPU.
>>>
>>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> ...
>>> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
>>> new file mode 100644
>>> index 0000000000000..b52f8073e5cd0
>>> --- /dev/null
>>> +++ b/rust/kernel/irq.rs
>>> @@ -0,0 +1,84 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Interrupt controls
>>> +//!
>>> +//! This module allows Rust code to control processor interrupts. [`with_irqs_disabled()`] may be
>>> +//! used for nested disables of interrupts, whereas [`IrqDisabled`] can be used for annotating code
>>> +//! that requires interrupts to be disabled.
>>> +
>>> +use bindings;
>>> +use core::marker::*;
>>> +
>>> +/// A token that is only available in contexts where IRQs are disabled.
>>> +///
>>> +/// [`IrqDisabled`] is marker made available when interrupts are not active. Certain functions take
>>> +/// an [`IrqDisabled`] in order to indicate that they may only be run in IRQ-free contexts.
>>> +///
>>> +/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
>>> +/// interrupts are disabled where required.
>>> +///
>>> +/// This token can be created by [`with_irqs_disabled`]. See [`with_irqs_disabled`] for examples and
>>> +/// further information.
>>> +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
>>> +pub struct IrqDisabled<'a>(PhantomData<(&'a (), *mut ())>);
>>> +
>>> +impl IrqDisabled<'_> {
>>> +    /// Create a new [`IrqDisabled`] without disabling interrupts.
>>> +    ///
>>> +    /// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
>>> +    /// without interrupts. If debug assertions are enabled, this function will assert that
>>> +    /// interrupts are disabled upon creation. Otherwise, it has no size or cost at runtime.
>>> +    ///
>>> +    /// # Panics
>>> +    ///
>>> +    /// If debug assertions are enabled, this function will panic if interrupts are not disabled
>>> +    /// upon creation.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// This function must only be called in contexts where it is already known that interrupts have
>>> +    /// been disabled for the current CPU, as the user is making a promise that they will remain
>>> +    /// disabled at least until this [`IrqDisabled`] is dropped.
>>> +    pub unsafe fn new() -> Self {
>>> +        // SAFETY: FFI call with no special requirements
>>> +        debug_assert!(unsafe { bindings::irqs_disabled() });
>>> +
>>> +        Self(PhantomData)
>>> +    }
>>> +}
>>
>> I have some (understanding) questions for this IrqDisabled::new():
>>
>> 1. It looks to me that both examples, below in this file irq.rs nor the
>> with_irqs_disabled() example in spinlock.rs in the 3rd patch seem to use
>> IrqDisabled::new()? At least some debug pr_info() added here doesn't print
>> anything.
>>
>> What's the intended use case of IrqDisabled::new()? Do we have any example?
>>
>> I 'simulated' an interrupt handler where we know the interrupts are
>> disabled:
>>
>> let flags = unsafe { bindings::local_irq_save() }; // Simulate IRQ disable
>> of an interrupt handler
>> let mut g = foo.lock_with(unsafe {IrqDisabled::new() });
>> g.val = 42;
>> unsafe { bindings::local_irq_restore(flags) }; // Simulate IRQ re-enable of
>> an interrupt handler
>>
>> Is this the intended use case?
>>
>>
>> 2. If the example above is what is intended here, is it intended that this
>> has to be called unsafe{}?
>>
>> foo.lock_with(unsafe {IrqDisabled::new() });
>>
>>
>> 3. I somehow feel slightly uncomfortable with the debug_assert!().
>>
>> I understood that this is intended to be not in production code and only
>> enabled with RUST_DEBUG_ASSERTIONS for performance reasons? But I have some
>> doubts how many people have RUST_DEBUG_ASSERTIONS enabled? And disable it
>> for the production build?
>>
>> Wouldn't it be better to be on the safe side and have this check, always?
> 
> No, for example in your code example above, the IRQ is knon being
> disabled, so actually there's no point to check. The checking of course
> makes sense in a function where there is no IRQ	disable code, and you
> want to make sure it's only called when IRQ disabled. But that's
> something you want to make sure at development time rather than in the
> production.

I think I'm thinking the other way around ;)

Make sure I get a warning if I'm (as the developer) have done anything 
wrong in my assumption about the interrupt state my code is running with.

So cover the human failure case.


>> Wouldn't a permanent if statement checking this be safer for all cases?
> 
> I don't think so, it's just a checking, even if we enable this in the
> production, the best it could do is just telling us the code is
> incorrect.

Yes, exactly, this is what I'm looking for. Isn't this what the C's 
WARN_ONCE() & friends are about? Let the machine tell us that the 
programmer has done something wrong :)


> If one realy wants to make sure a function works in both IRQ
> disabled and enabled cases, he/she should check the irq status and
> handle it accordingly 

No, this is not what I'm looking for. I'm just about noticing the 
programming error case.

Best regards

Dirk


> e.g.
> 
> 	if (irqs_disabled()) {
> 		// irq is disabled, we can call it directly
> 		do_sth();
> 	} else {
> 		// Disable IRQ on our own.
> 		local_irq_disable();
> 		do_sth();
> 		local_irq_enabled();
> 	}
> 
>> Compare e.g. BUG_ON() or WARN_ONCE() or similar in the kernel's C code?
>>
>> Or could we invent anything more clever?
>>
> 
> I'm open to any new idea, but for the time being, I think the
> debug_assert!() makes more sense.
> 
> Regards,
> Boqun
> 
>>
> [...]
> 


