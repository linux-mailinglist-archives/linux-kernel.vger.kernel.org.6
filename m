Return-Path: <linux-kernel+bounces-546396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76789A4FA1C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3161891D43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F51FC7CA;
	Wed,  5 Mar 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVcvA3Jw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F2F1E2847
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167078; cv=none; b=duiO/5iwiB8xRmGZkv7sc1yt3LAqNQgOLGscyO7TmINHWGzirrF4loGIqfAIn8bnpjaKsHrC0epS9URhC4ugLD6PVSeFdNb7OVFIxXqVCz9ryidEYbC0UVz0BWU5eKAKfHvJe3YOGXBK5KuThDq0D3Rw826Cr9dz8MYnc5GfRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167078; c=relaxed/simple;
	bh=rPpCgMC17V7JoNq3my1d0NuYKUuz+vVAE9BRDCL9wPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dQycYVQ3ldYvpZ3kzN/I3j4olUf7Hi9W1aFqZhzvuKo1gj6tBwGLYdq7JarEJXzF7xmjeeQw/W5r0DxHCpzwieOkAYdZXKRgp/wqlBQXclC3ZfvNBF+IewQqv/re3tEmUTsu39T6Kc1rAL26hHq2o/agzyuGQ5Qpc+Ljh/GKSho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVcvA3Jw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zokY/zW9Qk6aohEYTWS6Q+XwTXqNJ2SeGPIv+W/XMUc=;
	b=EVcvA3Jw/QcjpDgffHPa3SPEu2xJNpNX2YgqwXr1iTj/1qn2M6BGrIQ7i9CYxJTEb3805m
	emO2VN/tOHum7nujFjHc2LKA/Q7fe74zwPcagdwzpPaJ2E8WaVSuk0Q1fXfhtpXuhhDbMo
	LK1qY2v2IzLHzScH/gt6cMi5fa5Bu9I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-QiKk48HFOWi23DAbruNXRA-1; Wed, 05 Mar 2025 04:31:08 -0500
X-MC-Unique: QiKk48HFOWi23DAbruNXRA-1
X-Mimecast-MFC-AGG-ID: QiKk48HFOWi23DAbruNXRA_1741167067
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abf6e9bbef5so369504466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167067; x=1741771867;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zokY/zW9Qk6aohEYTWS6Q+XwTXqNJ2SeGPIv+W/XMUc=;
        b=mmjU32G89K9omI4TcBopADIU7OX+7Vs04rynfmBzAxG1d0gRfbGntfaG+rbJG+xta9
         s3fv7THYs+t9HUqKyuWPthlXEzDq3Mv1+ICbVlrH1ajCZlrcNj6Wv5fQBsY1jHCzLp/C
         AJeuyUy23TCvI/NCxxzjEy6CJ+AqLPPYHJM8KMwyfGz5O+qfRgXFCgl5Heo3WLuNBXCb
         VKzlImvBVJsMYdzCkWWojmpUfu8Ry9L9bFzwSK4UoWHZr3rdZbC2krT2Aev/yNDdYVqw
         U1VY6J/c7o7iGoFcsqKyLdpRxzlzuSB8nVHTuFBusb8gyRQEshLARf1MNwbcKo435YTV
         MC2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEO/6eSWDi8mkIBfNM+UvjGChgNDGyz8B5F9CzRkiXoh06AGlBgKMm5zLP2oGV77fg7W+tHevrfTLPr+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpWypFkR7LR3eKLols0I+YOVUmUeqfvIxOB/aWI/1MPKW9qMRY
	dNeCiemm10VPzwC8A/s+CGKZo6XWO+usp/obE4TCSyegIzjq1PyEPHZM8XBpbYyy8Ha87lA5BJN
	5pkB6XWRjLjgsbrjje72+9QJBudwNvYWScCBEhhXNyZbGppWubTdqJMnCjyjF/o5SyvBkvA==
X-Gm-Gg: ASbGncucr7aeeZzVcBC3U5DgA3PnqfL8AMOGkQSG2uyB1F5r6f/KL1+Z+J3QEoafOJA
	r76jvQ85Oxpbrw52JQ0dUxSdQ4/ClRxYo+CCLPBu9zfGVkq7pnOdZcKl0Ls5qWsocaioN9jSQ1P
	NirH935TSRKSRO32503Wt+cKFt9FN01ro6s0yvAQARnNf91F8eomaHq5SxHTHNt+tKeqpWyIib3
	R4w773Ek6t9Sbcyl3G6JTvRmhRj3lb2/Xo4QpabHxwUEGfKGWUiM6VB/XU424Z0eNlfNBOxKOZU
	xpGETlYBD4Y=
X-Received: by 2002:a05:6402:538f:b0:5e0:984c:3cca with SMTP id 4fb4d7f45d1cf-5e59f3f14bemr2193624a12.19.1741167067088;
        Wed, 05 Mar 2025 01:31:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJgUESasqHtiSK4/yXYk+BtaK4+6WBXnnAzpknzV6CWPdAXX/dygcAjWw4srlCUFmHfcWheQ==
X-Received: by 2002:a05:6402:538f:b0:5e0:984c:3cca with SMTP id 4fb4d7f45d1cf-5e59f3f14bemr2193597a12.19.1741167066612;
        Wed, 05 Mar 2025 01:31:06 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c2f408cdsm9315351a12.0.2025.03.05.01.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:31:06 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, Sean Christopherson
 <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "Maciej S. Szmigiero"
 <maciej.szmigiero@oracle.com>
Subject: Re: QEMU's Hyper-V HV_X64_MSR_EOM is broken with split IRQCHIP
In-Reply-To: <23cfae5adcdee2c69014d18b2b19be157ef2c20d.camel@redhat.com>
References: <Z8ZBzEJ7--VWKdWd@google.com> <87ikoposs6.fsf@redhat.com>
 <Z8cNBTgz3YBDga3c@google.com> <87cyewq2ea.fsf@redhat.com>
 <23cfae5adcdee2c69014d18b2b19be157ef2c20d.camel@redhat.com>
Date: Wed, 05 Mar 2025 10:31:05 +0100
Message-ID: <87a59zq0x2.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Tue, 2025-03-04 at 15:46 +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Tue, Mar 04, 2025, Vitaly Kuznetsov wrote:
>> > > Sean Christopherson <seanjc@google.com> writes:
>> > > 
>> > > > FYI, QEMU's Hyper-V emulation of HV_X64_MSR_EOM has been broken since QEMU commit
>> > > > c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), as nothing in KVM
>> > > > will forward the EOM notification to userspace.  I have no idea if anything in
>> > > > QEMU besides hyperv_testdev.c cares.
>> > > 
>> > > The only VMBus device in QEMU besides the testdev seems to be Hyper-V
>> > > ballooning driver, Cc: Maciej to check whether it's a real problem for
>> > > it or not.
>> > > 
>> > > > The bug is reproducible by running the hyperv_connections KVM-Unit-Test with a
>> > > > split IRQCHIP.
>> > > 
>> > > Thanks, I can reproduce the problem too.
>> > > 
>> > > > Hacking QEMU and KVM (see KVM commit 654f1f13ea56 ("kvm: Check irqchip mode before
>> > > > assign irqfd") as below gets the test to pass.  Assuming that's not a palatable
>> > > > solution, the other options I can think of would be for QEMU to intercept
>> > > > HV_X64_MSR_EOM when using a split IRQCHIP, or to modify KVM to do KVM_EXIT_HYPERV_SYNIC
>> > > > on writes to HV_X64_MSR_EOM with a split IRQCHIP.
>> > > 
>> > > AFAIR, Hyper-V message interface is a fairly generic communication
>> > > mechanism which in theory can be used without interrupts at all: the
>> > > corresponding SINT can be masked and the guest can be polling for
>> > > messages, proccessing them and then writing to HV_X64_MSR_EOM to trigger
>> > > delivery on the next queued message. To support this scenario on the
>> > > backend, we need to receive HV_X64_MSR_EOM writes regardless of whether
>> > > irqchip is split or not. (In theory, we can get away without this by
>> > > just checking if pending messages can be delivered upon each vCPU entry
>> > > but this can take an undefined amount of time in some scenarios so I
>> > > guess we're better off with notifications).
>> > 
>> > Before c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), and without
>> > a split IRCHIP, QEMU gets notified via eventfd.  On writes to HV_X64_MSR_EOM, KVM
>> > invokes irq_acked(), i.e. irqfd_resampler_ack(), for all SINT routes.  The eventfd
>> > signal gets back to sint_ack_handler(), which invokes msg_retry() to re-post the
>> > message.
>> > 
>> > I.e. trapping HV_X64_MSR_EOM on would be a slow path relative to what's there for
>> > in-kernel IRQCHIP.
>> 
>> My understanding is that the only type of message which requires fast
>> processing is STIMER messages but we don't do stimers in userspace. I
>> guess it is possible to have a competing 'noisy neighbough' in userspace
>> draining message slots but then we are slow anyway.
>> 
>
> Hi,
>
> AFAIK, HV_X64_MSR_EOM is only one of the ways for the guest to signal that it processed the SYNIC message.
>
> Guest can also signal that it finished processing a SYNIC message using HV_X64_MSR_EOI or even by writing to EOI
> local apic register, and I actually think that the later is what is used by at least recent Windows.
>

Hyper-V SynIC has two distinct concepts: "messages" and "events". While
events are just flags (like interrupts), messages actually carry
information and the recipient is responsible for clearing message slot
(there are only 16 of them per vCPU AFAIR). Strictly speaking,
HV_X64_MSR_EOM is optional and hypervisor may deliver a new message to
an empty slot at any time. It may use EOI as a trigger but note that
not every message delivery results in an interrupt as e.g. SINT can be
configured in 'polling' mode -- and that's when HV_X64_MSR_EOM comes
handy.

>
> Now KVM does intercept EOI and it even "happens" to work with both APICv and AVIC:
>
> APICv has EOI 'exiting bitmap' and SYNC interrupts are set there (see vcpu_load_eoi_exitmap).
>
> AVIC intercepts EOI write iff the interrupt was level-triggered and SYNIC interrupts happen
> to be indeed level-triggered:
>
> static int synic_set_irq(struct kvm_vcpu_hv_synic *synic, u32 sint)
> ...
> 	irq.shorthand = APIC_DEST_SELF;
> 	irq.dest_mode = APIC_DEST_PHYSICAL;
> 	irq.delivery_mode = APIC_DM_FIXED;
> 	irq.vector =
> vector;
> 	irq.level = 1;
> ...
>

Yea, I think the problem here is specific to HV_X64_MSR_EOM.

-- 
Vitaly


