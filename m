Return-Path: <linux-kernel+bounces-438034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7C9E9C07
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA8318873E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F71F14884C;
	Mon,  9 Dec 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVdGjpfb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EA13C908
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762802; cv=none; b=FoXfbuc38fTgY75SvfsOZ6C0GwpRhEyf0h4kXAV4M4UQHkM3wS1gr6w40PRlHL3EEI0WeImpzsEr3/BajlhXedx3vLsXk3kH2akMumzfEika8gqlf/V6aqlkNQpIZ5PNeDNmCwosSyp6micfo5gh4NwgXDpfDk8fIUdhwx9a1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762802; c=relaxed/simple;
	bh=N13BCSHzak5uS5rs7WJF8kh9LHJf3n5b7MpEjh/Qa68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARkHHYsJwIpgZKZ/api0O45TkO9OltyQ3z61WHkJnaGkEMaC+kROCs/yoErGFa6H3z1Iz1dURwm3blw/rLQEvwicUdvuATElX93S+CtEonql9phmyL34bhGWeLiWWfiCypVz8Q8jk89UpjAChc27uZAULYCYh/Yv33EdISvhFJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVdGjpfb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733762799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bf28CO39ovGyTPfztFZ3utKq/b0MD2z7TptwMs0iNHM=;
	b=MVdGjpfbvfC3J45Y2NJMMVXBcBI2Cuq9xlzyBCiZ+cDWzDZBVrhAuiURsu5FuW8qPm0cjC
	i9/flAyu3djdeDC6CyV6nVhunXxHi8s/vOSU1MmPpmro/I0n1EI3Lo3rjeJFvsFN/M9PjJ
	t4thaqpvrFUZpWUOmdJuLwTa05n8CJY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-QS5rtrUDP_C8uR0rk0qszQ-1; Mon, 09 Dec 2024 11:46:38 -0500
X-MC-Unique: QS5rtrUDP_C8uR0rk0qszQ-1
X-Mimecast-MFC-AGG-ID: QS5rtrUDP_C8uR0rk0qszQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467659b34f7so26843641cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733762797; x=1734367597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf28CO39ovGyTPfztFZ3utKq/b0MD2z7TptwMs0iNHM=;
        b=D0hSYMEaecmJpyIgWW8rQyJ7Vvy56BB8IvYS4qvzhBJY1wgAaQIrn4c3EsntGrmIdL
         SXQj+ygxo85MEVkZjYxY/00Mxn4wx2/qkEkg1bZMoVbQBUDW6KhTCVM/+LKbHb1qKUB6
         2spVYl6gK+NEC/l7xNh/YOB/5w0ZKLv0QQ6EyhHah0/etRaXsj2uXFaOvTb55jzeciY8
         UpB5hgYBqoNo/31FIs2qJnU0NYtmzYqCe1F/5PMt/rBvdK0E/9REIm/0lFttaS4qQXu7
         avBpCwuIP6sJkKXw/c7JG6J/tq+P8KfBn2TWc+qHmklNOSmIDqI9E6Xy32xRFInY9uo+
         QJWA==
X-Forwarded-Encrypted: i=1; AJvYcCVtVBw19KvZD/1P7GIqpmGlikyqxF5Mgrz+sOwpSaJBv7n3BIp/CGviFliIPOMY2B9g/8dyNXh0h9BjiWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyLh8AX6sucqbGExi9oZsl/9HX3G5T5dmVDYSEJzBr25y6H7v
	xDzwSep48Oyct0l3N86t+6eyi9SSh1Zzuqwez1mmX2OzpcTF84joLuJ6T4SkfzW7HmD9NPyfGHX
	1W1UHAq/lQxRrU4AK41gj/nX5TXFT4HjpTgXnZCYSjMdtPk8NsFyq0o8dIhOwUg==
X-Gm-Gg: ASbGncsUWVKPv+Mx8Lm4nGcwgf974MNDfQLxkPpZPGCqvJIK2zoooH/jjKE0M+LL3fr
	6HuXCQzGimu1BFmbjd3HSCc7lQIVpxEMWKy4BahfRgxyL9yrZ//FxSpwSoQZnGMunqJhmtLpg8Q
	fo4qwbwpi6OKnp+YHsJOIPS9v3gz7yYmkWVzGHZhoWQsnzFL48jJp7KabVTpjL3l742xXTVH7fu
	/Nx6kDhyzfqF1wbwJtGsyeYkPcwJpDJNWjuu6NxT1XxFCsSrdN03ld4dFNifalHglLlTeQ6BUxa
	Y5RzVaCFKX3cHO5J
X-Received: by 2002:ac8:7f82:0:b0:467:6019:9569 with SMTP id d75a77b69052e-46760199622mr98743951cf.17.1733762797365;
        Mon, 09 Dec 2024 08:46:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW4soDtw8HxIFjNK41EdqQnNHAOjJwO6UUujwJSKBvsRzHIOZEJzs+RldkZNVTtdqj3Ba0ag==
X-Received: by 2002:ac8:7f82:0:b0:467:6019:9569 with SMTP id d75a77b69052e-46760199622mr98743331cf.17.1733762796898;
        Mon, 09 Dec 2024 08:46:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296fcb20sm52927651cf.47.2024.12.09.08.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 08:46:36 -0800 (PST)
Message-ID: <bcb4289b-507c-4ea1-afc7-6febd34d88db@redhat.com>
Date: Mon, 9 Dec 2024 17:46:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: nv: Set ISTATUS for emulated timers, If timer
 expired
Content-Language: en-US
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Marc Zyngier <maz@kernel.org>
Cc: kvmarm <kvmarm@lists.linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, oliver.upton@linux.dev,
 christoffer.dall@arm.com, suzuki.poulose@arm.com, will@kernel.org,
 catalin.marinas@arm.com, coltonlewis@google.com, joey.gouly@arm.com,
 yuzenghui@huawei.com, darren@os.amperecomputing.com,
 vishnu@os.amperecomputing.com
References: <20241209053201.339939-1-gankulkarni@os.amperecomputing.com>
 <867c89tc4q.wl-maz@kernel.org>
 <c5b1c3d7-56ca-4afc-a831-045dba4beffa@os.amperecomputing.com>
 <865xntt2kv.wl-maz@kernel.org>
 <8be59ff3-6a68-48e1-8181-0ce4b2e7180f@os.amperecomputing.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <8be59ff3-6a68-48e1-8181-0ce4b2e7180f@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12/9/24 16:39, Ganapatrao Kulkarni wrote:
> 
> 
> On 09-12-2024 06:50 pm, Marc Zyngier wrote:
>> On Mon, 09 Dec 2024 12:25:34 +0000,
>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>>>
>>>>> During automated testing of Nested Virtualization using avocado-vt,
>>>>
>>>> Which is not merged upstream. So what branch are you using? Based on
>>>> what kernel version? On what HW? With which virtualisation features?
>>>>
>>>
>>> Testing is done on Ampere's AmpereOne platform using 6.10 based kernel
>>> with NV patches from your repo.
>>
>> Grmbl... *Which* patches? At least give me the SHA1 of the branch,
>> because I have no idea what you are running. And 6.10 is definitely
>> not something I care about. If you're using the NV patches, the
>> *minimum* you should run is 6.13-rc1, because that's what the current
>> code is based on.
>>
> 
> I tried 6.13-rc1 based nv-next branch today, which failed to boot
> UEFI as L1. Yet to debug this.

I confirm am stuck with the same issue with nv-next on AmpereOne.

Thanks

Eric

> 
> 
> QEMU from Eric's repo is used for the testing.
> https://github.com/eauger/qemu/tree/v9.0-nv-rfcv3
> 
>> Also, does this machine have FEAT_ECV?
> 
> Yes!
>>
>>>
>>>>> it has been observed that during some boot test iterations,
>>>>> the Guest-Hypervisor boot was getting crashed with a
>>>>> synchronous exception while it is still booting EDK2.
>>>>>
>>>>> The test is launching Multiple instances of Guest-Hypervisor boot
>>>>
>>>> Is the multiple instance aspect really relevant to the reproduction of
>>>> the problem?
>>>
>>> Not really, but it requires multiple attempts/iterations to hit the
>>> issue. Even with automated test, it was seen at some iteration out of
>>> 10 to 15 iterations.
>>>
>>>>
>>>>> and while booting, QEMU monitor issued the command "info register"
>>>>> at regular intervals to take a register dump. To execute this
>>>>> command, QEMU stops the run and does the register read of various
>>>>> registers. While resuming the run, the function kvm_arm_timer_write()
>>>>> writes back the saved CNTV_CTL_EL0 register with ISTATUS cleared
>>>>> always
>>>>
>>>> It is userspace that causes this write-back, right? AFAICT, KVM never
>>>> does that on its own.
>>>>
>>>>> and resulting in the loss of pending interrupt for emulated timers.
>>>>
>>>> How does a missing interrupt result in a synchronous exception in
>>>> EDK2? In my experience, EDK2 panics if it sees spurious interrupts,
>>>> not when it is missing interrupts (it just locks up, which is
>>>> expected).
>>>
>>> Not sure, why it is hitting exception, rather than hang at EDK2.
>>> However, EDK2 timer handler code is ignoring the interrupt since
>>> ISTATUS is not set and not moving CVAL forward.
>>
>> How is EDK2 getting this exception? Is this injected by KVM? Or is
>> that some EDK2 bug?
>>
>>>
>>>>
>>>>> In hardware based timers, ISTATUS is a RO/WI bit and gets set by the
>>>>> h/w, if the condition is still met. However, in Nested-Virtualization
>>>>> case, the Guest-Hypervisor's EDK2 is using an emulated virtual timer
>>>>> and losing ISTATUS state and the interrupt forever.
>>>>
>>>> Why is this specific to NV? Can't the same thing happen to the
>>>> physical timer in a non-VHE configuration?
>>>>
>>>
>>> You mean, emulated v-timer in non-VHE boot?
>>
>> Emulated *physical* timer.
>>
>>> It might impact non-VHE case as well, not tried though.
>>
>> Can you please try?
> 
> Sure, I will try non-VHE as well.
>>
>> [...]
>>
>>>> But overall, this very much looks like it is only papering over the
>>>> real issue, which is that the *emulation* should regenerate the
>>>> pending bit, and not rely on the userspace interface.
>>>>
>>>> As far as I can tell, we already correctly compute the status bit on
>>>> read (read_timer_ctl()), so the guest should always observe something
>>>> consistent when it traps. We also *never* use the status bit as an
>>>> input to the emulation, and always recompute it from scratch (it is
>>>> only there for the benefit of the guest or userspace).
>>>>
>>>
>>> For emulated timers, we are not asserting again by calling
>>> kvm_timer_update_irq in timer_emulate() until the level is down and
>>> ready for trigger again. This was done to fix high rate of spurious
>>> interrupts getting generated to V-Timer. Hence we are not able to
>>> recover, if once ISTATUS is lost.
>>
>> Again, a trapping read should see the correct value, since we populate
>> that bit at read time.
>>
>>>> So I can't see how upstream is broken in at the moment, and you need
>>>> to explain how this actually triggers. Ideally, with a standalone
>>>> reproducer or a selftest.
>>>
>>> We could reproduce the issue with the simple test/script.
>>> On one shell, launch L1 using qemu with add-on option
>>>
>>> "-monitor unix:gh_monitor,server,nowait
>>>
>>> On another shell, while L1 boots and still in UEFI, run repeatedly the
>>> command (or put in a while 1 loop script)
>>>
>>> "echo "info registers" | socat - unix-connect:gh_monitor >
>>> /tmp/info_registers"
>>>
>>> With above steps we were able to hit the issue within few attempts.
>>
>> That's not a standalone reproducer. QEMU doesn't support NV, and
>> kvmtool doesn't have this sort of interface. I was asking for a bit of
>> C code that I could run directly, not something that requires me to
>> drag even more experimental code.
>>
>> So here's my current guess, since you don't give me the needed
>> information. For what you describe to happen, I can only see two
>> possibilities:
>>
>> - either your HW doesn't have FEAT_ECV, in which case the guest
>>    directly reads from memory
>>
> 
> We do have the FEAT_ECV on AmpereOne, I was the one reported/fixed bug
> with FEAT_ECV(CNTPOFF offset issue) in the past.
> 
>> - or you are running with something like this patch [1], and we serve
>>    the guest by reading from memory very early, without returning to
>>    the bulk of the emulation code
> 
> I see the kernel I am testing has this patch[1].
>>
>> In either case, we only publish the updated status if the current IRQ
>> state is different from the computed output of the timer while
>> performing the emulation.
>>
>> So if you were writing back a status bit set to 0 while the interrupt
>> was already pending, we'd deliver an interrupt, but not recompute the
>> status. The guest would consider the interrupt as spurious, not touch
>> the timer, and we'd never make forward progress. Rinse, repeat.
>>
>> Assuming I got the analysis right, 
> 
> Yes, this is what I tried to explain. LR shows pending, but UEFI is not
> consuming and treating it as spurious since ISTATUS is not set.
> 
> it would only be a matter of
>> hoisting the publication of the status into timer_emulate(), so that
>> it is made up to date on load.
>>
>> Please give the fixup below a go.
>>
> 
> Sure, I will give a try with below diff and let you know tomorrow.
> This should work, I remember, this was the one of the option/fix that we
> tried as fix while debugging.
> 
>>
>> [1] https://lore.kernel.org/all/20241202172134.384923-6-maz@kernel.org/
>>
>>  From 2bbd6f9b41a20ad573376c20c158ff3c12db5009 Mon Sep 17 00:00:00 2001
>> From: Marc Zyngier <maz@kernel.org>
>> Date: Mon, 9 Dec 2024 10:58:08 +0000
>> Subject: [PATCH] fixup! KVM: arm64: nv: Publish emulated timer
>> interrupt state
>>   in the in-memory state
>>
>> ---
>>   arch/arm64/kvm/arch_timer.c | 32 +++++++++++++-------------------
>>   1 file changed, 13 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
>> index 895f09658ef83..91bda986c344b 100644
>> --- a/arch/arm64/kvm/arch_timer.c
>> +++ b/arch/arm64/kvm/arch_timer.c
>> @@ -432,25 +432,6 @@ static void kvm_timer_update_irq(struct kvm_vcpu
>> *vcpu, bool new_level,
>>   {
>>       int ret;
>>   -    /*
>> -     * Paper over NV2 brokenness by publishing the interrupt status
>> -     * bit. This still results in a poor quality of emulation (guest
>> -     * writes will have no effect until the next exit).
>> -     *
>> -     * But hey, it's fast, right?
>> -     */
>> -    if (is_hyp_ctxt(vcpu) &&
>> -        (timer_ctx == vcpu_vtimer(vcpu) || timer_ctx ==
>> vcpu_ptimer(vcpu))) {
>> -        u32 ctl = timer_get_ctl(timer_ctx);
>> -
>> -        if (new_level)
>> -            ctl |= ARCH_TIMER_CTRL_IT_STAT;
>> -        else
>> -            ctl &= ~ARCH_TIMER_CTRL_IT_STAT;
>> -
>> -        timer_set_ctl(timer_ctx, ctl);
>> -    }
>> -
>>       timer_ctx->irq.level = new_level;
>>       trace_kvm_timer_update_irq(vcpu->vcpu_id, timer_irq(timer_ctx),
>>                      timer_ctx->irq.level);
>> @@ -471,6 +452,19 @@ static void timer_emulate(struct
>> arch_timer_context *ctx)
>>         trace_kvm_timer_emulate(ctx, should_fire);
>>   +    /*
>> +     * Paper over NV2 brokenness by publishing the interrupt status
>> +     * bit. This still results in a poor quality of emulation (guest
>> +     * writes will have no effect until the next exit).
>> +     *
>> +     * But hey, it's fast, right?
>> +     */
>> +    if (is_hyp_ctxt(ctx->vcpu)) {
>> +        unsigned long val = timer_get_ctl(ctx);
>> +        __assign_bit(__ffs(ARCH_TIMER_CTRL_IT_STAT), &val, should_fire);
>> +        timer_set_ctl(ctx, val);
>> +    }
>> +
>>       if (should_fire != ctx->irq.level) {
>>           kvm_timer_update_irq(ctx->vcpu, should_fire, ctx);
>>           return;
> 


