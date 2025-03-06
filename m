Return-Path: <linux-kernel+bounces-548622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B908BA5472A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D953F16686D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124B17B50B;
	Thu,  6 Mar 2025 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RI+pI/BV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A42E64A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255237; cv=none; b=khNMEiORh+L5ya2aU/lhwkQiGstW24DYAzriN9o/SPVMpWkebDaClfOtyiO3Ajbg4P0+AW/9+mL+eeOHkyUqBywU+bgOZEpQ10AddE94DNYQiipZVWv3gZBdszOUEQ4m4yvaEa0YaWmt7fOVIJ35KHvgHllnSAzT3pPgjTCKa2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255237; c=relaxed/simple;
	bh=5Lhtwd5cH2PKhD/dFJio5Nb5ixUzvTEXAnioAWegKMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pu/jm1JljacUHv2+U4UoQ08T7buRwSheKfO9M0T64NITao4zhHIkl9mRf8v+NNY5b9fxha67VBpaLm7QqqIqwJ4j0Vp1k30IQATfpgrUbAk/WRYK9X21jRCF6BUSyaSKScS39ASB4uFf2AuULx/LHO1pt5N2I4CCG9NnP7licbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RI+pI/BV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741255234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wkn24CpGo6+FUEVuRlexbhMNX+ALW6So6mD2WHyvwXE=;
	b=RI+pI/BVU+gFMwm/8XuiSvwJq51la0DjwqiX10cHf4yDjWkJMptj3Jmd4ZCqXzoDfvqt5C
	NavXVZiPwII9o4WHy7e94QeFbxkBcK7UXqZfN/dJD5hxlS0anAD6ciXU2/Ar2RVBujqB1b
	bnknV1A+phQfE/BFkCdi3E4Y22gzfaA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-6F2ic2MsNWOFRGMf9ybOGQ-1; Thu, 06 Mar 2025 05:00:33 -0500
X-MC-Unique: 6F2ic2MsNWOFRGMf9ybOGQ-1
X-Mimecast-MFC-AGG-ID: 6F2ic2MsNWOFRGMf9ybOGQ_1741255232
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4388eee7073so8600015e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255232; x=1741860032;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wkn24CpGo6+FUEVuRlexbhMNX+ALW6So6mD2WHyvwXE=;
        b=lPsYlHm4u0LAcgfHNHg6tDt0avdQ2eG0HgCZikm1E/5T6UvjRg4/CYOK7qIoyRrmts
         iQqKCc7Hy52iL231qDSusPnvOaRrpw6GRW8p8JWxEmrJ/Pu5JwYWxSgwN/scBXmHDKUw
         lM2SDoQYgvahrtL7h1UaV0ldAFtUZzoy2d0bhWH+tjdKrP10bM3nx9/MWd1UvyOONiku
         7X3wbEqAUzTOJ0TtvtLH9lTXqIuGFI8VzPKIt5FAXLZm26CofqYUDMOlbdftT4jgh2zG
         TbnaLZzjBsD5p82Fgm9TJW5eajIBkDggR0wm9Gv2GrEvHJbDK34NDG1bRKUgOszGzJ6W
         A4cA==
X-Forwarded-Encrypted: i=1; AJvYcCVYIBwa9pmCtlReutzKoL8Y6oyrrIx6MVMqK4uURWFELI9ubdHDPHHLEElbYM6kTFvuJP7IHB5HFm34xns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYM8GCXwKTel9LclT6g3Fi1xTBF7eavNaDhlrfWJLM0X4n7jq8
	TOQPa3Bvq/G+vDV6inifk0sBcP7h6zSJ56BaXHXrh+Ev6SV6I0Gr8dspEfsarTReakya4waNKPN
	cFS7MTQ42N66Y9/v6Wa0R/ug0zJT6Hyn5fUac+9IzQuVuZ65JTAK1KJYKZ8JYqA==
X-Gm-Gg: ASbGnctc0fKVvc3EG4YyyU4prXRmXkIhb99VcWkooHfqNRZ2Dx9wN7hopjejYkB3LnF
	5RFaMy6phvv/acKwZPLF8W4SJdALumze68WIdC+2xlDKZDrMh/rHUs4bQRViSMkWWTy7OTKAh6z
	kJTcgMkcD92aH2SkSu1+7NFtzOgG2cmh+ewnCqGzXuPltJ3fhQ9Q2TmdM3Oz/5mMFm12FCYFQXW
	Fp32MJZ3wxDu37VcCRqDPPQOGWe/OfXw9wtrD2VkhTZf6FKFDXizh7VLaeh/qmQy1z/3Fn1YS2D
	bS+hu/bDsE8=
X-Received: by 2002:a05:600c:1c9c:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-43bdb3b8fc5mr21081135e9.11.1741255232018;
        Thu, 06 Mar 2025 02:00:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbZl9Jwi9K2ockg9+UNE+kX6iPaGsi8yOptcqo6NIW8PqlcWYlqkjfEnAsg9dPJ6hUpVn3bw==
X-Received: by 2002:a05:600c:1c9c:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-43bdb3b8fc5mr21080845e9.11.1741255231504;
        Thu, 06 Mar 2025 02:00:31 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd435cd8csm45017965e9.40.2025.03.06.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:00:30 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, Sean Christopherson
 <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "Maciej S. Szmigiero"
 <maciej.szmigiero@oracle.com>
Subject: Re: QEMU's Hyper-V HV_X64_MSR_EOM is broken with split IRQCHIP
In-Reply-To: <87a59zq0x2.fsf@redhat.com>
References: <Z8ZBzEJ7--VWKdWd@google.com> <87ikoposs6.fsf@redhat.com>
 <Z8cNBTgz3YBDga3c@google.com> <87cyewq2ea.fsf@redhat.com>
 <23cfae5adcdee2c69014d18b2b19be157ef2c20d.camel@redhat.com>
 <87a59zq0x2.fsf@redhat.com>
Date: Thu, 06 Mar 2025 11:00:29 +0100
Message-ID: <87senqo4w2.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Maxim Levitsky <mlevitsk@redhat.com> writes:
>
>> On Tue, 2025-03-04 at 15:46 +0100, Vitaly Kuznetsov wrote:
>>> Sean Christopherson <seanjc@google.com> writes:
>>> 
>>> > On Tue, Mar 04, 2025, Vitaly Kuznetsov wrote:
>>> > > Sean Christopherson <seanjc@google.com> writes:
>>> > > 
>>> > > > FYI, QEMU's Hyper-V emulation of HV_X64_MSR_EOM has been broken since QEMU commit
>>> > > > c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), as nothing in KVM
>>> > > > will forward the EOM notification to userspace.  I have no idea if anything in
>>> > > > QEMU besides hyperv_testdev.c cares.
>>> > > 
>>> > > The only VMBus device in QEMU besides the testdev seems to be Hyper-V
>>> > > ballooning driver, Cc: Maciej to check whether it's a real problem for
>>> > > it or not.
>>> > > 
>>> > > > The bug is reproducible by running the hyperv_connections KVM-Unit-Test with a
>>> > > > split IRQCHIP.
>>> > > 
>>> > > Thanks, I can reproduce the problem too.
>>> > > 
>>> > > > Hacking QEMU and KVM (see KVM commit 654f1f13ea56 ("kvm: Check irqchip mode before
>>> > > > assign irqfd") as below gets the test to pass.  Assuming that's not a palatable
>>> > > > solution, the other options I can think of would be for QEMU to intercept
>>> > > > HV_X64_MSR_EOM when using a split IRQCHIP, or to modify KVM to do KVM_EXIT_HYPERV_SYNIC
>>> > > > on writes to HV_X64_MSR_EOM with a split IRQCHIP.
>>> > > 
>>> > > AFAIR, Hyper-V message interface is a fairly generic communication
>>> > > mechanism which in theory can be used without interrupts at all: the
>>> > > corresponding SINT can be masked and the guest can be polling for
>>> > > messages, proccessing them and then writing to HV_X64_MSR_EOM to trigger
>>> > > delivery on the next queued message. To support this scenario on the
>>> > > backend, we need to receive HV_X64_MSR_EOM writes regardless of whether
>>> > > irqchip is split or not. (In theory, we can get away without this by
>>> > > just checking if pending messages can be delivered upon each vCPU entry
>>> > > but this can take an undefined amount of time in some scenarios so I
>>> > > guess we're better off with notifications).
>>> > 
>>> > Before c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), and without
>>> > a split IRCHIP, QEMU gets notified via eventfd.  On writes to HV_X64_MSR_EOM, KVM
>>> > invokes irq_acked(), i.e. irqfd_resampler_ack(), for all SINT routes.  The eventfd
>>> > signal gets back to sint_ack_handler(), which invokes msg_retry() to re-post the
>>> > message.
>>> > 
>>> > I.e. trapping HV_X64_MSR_EOM on would be a slow path relative to what's there for
>>> > in-kernel IRQCHIP.
>>> 
>>> My understanding is that the only type of message which requires fast
>>> processing is STIMER messages but we don't do stimers in userspace. I
>>> guess it is possible to have a competing 'noisy neighbough' in userspace
>>> draining message slots but then we are slow anyway.
>>> 
>>
>> Hi,
>>
>> AFAIK, HV_X64_MSR_EOM is only one of the ways for the guest to signal that it processed the SYNIC message.
>>
>> Guest can also signal that it finished processing a SYNIC message using HV_X64_MSR_EOI or even by writing to EOI
>> local apic register, and I actually think that the later is what is used by at least recent Windows.
>>
>
> Hyper-V SynIC has two distinct concepts: "messages" and "events". While
> events are just flags (like interrupts), messages actually carry
> information and the recipient is responsible for clearing message slot
> (there are only 16 of them per vCPU AFAIR). Strictly speaking,
> HV_X64_MSR_EOM is optional and hypervisor may deliver a new message to
> an empty slot at any time. It may use EOI as a trigger but note that
> not every message delivery results in an interrupt as e.g. SINT can be
> configured in 'polling' mode -- and that's when HV_X64_MSR_EOM comes
> handy.
>

Thinking more about this, I believe we should not be using eventfd for
delivering writes to HV_X64_MSR_EOM to VMM at all. Namely, writes to
HV_X64_MSR_EOM should not invoke irq_acked(): it should be valid for a
guest to poll for messages by writing to HV_X64_MSR_EOM within the
interrupt handler, drain the queue and then write to the EOI
register. In this case, the VMM may want to distinguish between EOI and
EOM. We can do a separate eventfd, of course, but I think it's an
overkill and 'slow' processing will do just fine.

-- 
Vitaly


