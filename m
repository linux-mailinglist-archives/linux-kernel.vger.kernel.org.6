Return-Path: <linux-kernel+bounces-545629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CEA4EF63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878D6172C60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B312780FB;
	Tue,  4 Mar 2025 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKHSVMcl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700DC264F8C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123898; cv=none; b=hofoZrCYfj44HoGIqLYwmjAbWVXBNZN4Fnjg+2iTMixIlMqj/fMBflzVDPwIQJkmiwAJRbqb5epxHzisSmLURTfOHkG00nSIixs+QbYGjkZlPot/Rcnt0ruQWHOP0paD7KweAzIJMxpULouNeRkwUWF6WkbbQ5sP+3qwU8Gm/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123898; c=relaxed/simple;
	bh=iZIzip/a82vX2LkJv4zSZm4C3SJDxHZJwHDvU2KQ3Lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=obT9boisS8dNqy39HuvYJfo5mqtdiuUfha25md0FG6k1fcOyvmrV8CilNyneoFZI5qe2KrS1y7z6bo8jvy14u0xFCYkjpSZXXgiRxPX3M1dyzSnrW24Ld8kIvW+E1QS+HJUotFb+zebrH5Lc/W2xQkals29TIYXPjeZtje69c8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKHSVMcl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741123895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/u+lFueGmAvUTM+DtaLsQO1A1g/BaRj/gNOIsb+910g=;
	b=PKHSVMclxtCDIQ+ZkfTp4Q3WZXs3lReg5RD0iiLH0Wf0BegavvJbwUd0NzQsuACnny2tOe
	noWX3jQ2acxzsdereNtHsJPGlV2ei2ASeoepzaw32JevZLJNwfC5rG3IeepOF8Iwbcd11B
	qxjniK52Y4Z4DOCxCmnjfgC3SgXdTIw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-xRlHr9LWPdikS5dTTrEJMg-1; Tue, 04 Mar 2025 16:31:34 -0500
X-MC-Unique: xRlHr9LWPdikS5dTTrEJMg-1
X-Mimecast-MFC-AGG-ID: xRlHr9LWPdikS5dTTrEJMg_1741123893
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47506816e5aso15775791cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 13:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741123893; x=1741728693;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/u+lFueGmAvUTM+DtaLsQO1A1g/BaRj/gNOIsb+910g=;
        b=k0xg56+ArS3KO8/7WgozwQvaQuQ8IOgdLDJjUOA9ZWA8gFhYtNAKbGw9Gk8vtKWRJ7
         SX2Nk8wViLnZ4V3GXO68xz/LSqp/il9b0kLjXMrFK/dyUJTgYipI/bOOOaRPckXVdWLn
         bMCMPkwSGtC5mU7GBnTKPuh7QSePyY7Kz+WdV3GqPXT2Grpsai2+y+hkz2C1+3eSC7Uu
         FbBrTQRdt9MjwJRbIzoZHUCENOdod32IH1HupUu+TIgx5Mt1X8fugwwTCB2gNdM7uk9W
         Y1IKHSNCCD8sulwuYtEIoEY1Jl5HI+A4XWsLham51HAlg8yfL3XprH3fGJA52qAqfu3q
         9u+g==
X-Forwarded-Encrypted: i=1; AJvYcCWsAeGVALbJDpsVg8bGTbKp+d/y5hx/qGcvatbO2MaPS/XK7II9Do1pea4/VWyl3KJxJCVeDMdyzOes9HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq8/hdT3y8ZiT66MxPuA0vihbJtoSaaNGlulVP3CyJTLFy9y8/
	JG20iqQY1RD4PM4FVrOL1cx71b/v8sYdmVxJwgIVMO5CD7dPg1GPeRGkfzlurVS7YhxYnbM69+1
	TDzPPtMTRRD96k1ZgSsLuOCGgFt8pdjDGFivMFwQZVJ5NLrO1hZXAVEBFIQPa5w==
X-Gm-Gg: ASbGncsV2ouZSgYC9xf9SNeRk0sF4sn2pDjrGsLG2eVuIEjhNGy5tkuUQDDL5AfPe+w
	YIRckGsMife8qzUQNQwJZiqLNvdYaWYM0aGwX9BJadwy5duz8rlF3KhZaoBipt0MGCaweLGrxgZ
	69makwZqnOSzWANX/q4wWugPOk3CFREfVSRxdFjZBHhq9PQ6hYm2xrksP7DBXppy4MHq0Sj+/xE
	2IFNdrQuQRWrOH/TP+NpBDeus8j++bAIEpsSoUAcTitBua5dJky0CXllA4Hx2n4gi5ROBtJDztG
	G7UphZdTD1PknlY=
X-Received: by 2002:a05:622a:60f:b0:471:be0e:e853 with SMTP id d75a77b69052e-4750b43c3d2mr11681841cf.20.1741123893528;
        Tue, 04 Mar 2025 13:31:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq3Qm8HjXWzqA8J3MceftXH5+TdpP0G/l/xsbfQtBrI9xoJPnzFc7gCJPy7NR5vHnpnooV3A==
X-Received: by 2002:a05:622a:60f:b0:471:be0e:e853 with SMTP id d75a77b69052e-4750b43c3d2mr11681531cf.20.1741123893214;
        Tue, 04 Mar 2025 13:31:33 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e0f1e0c1sm36608431cf.47.2025.03.04.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:31:32 -0800 (PST)
Message-ID: <23cfae5adcdee2c69014d18b2b19be157ef2c20d.camel@redhat.com>
Subject: Re: QEMU's Hyper-V HV_X64_MSR_EOM is broken with split IRQCHIP
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson
	 <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Paolo Bonzini
	 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "Maciej S. Szmigiero"
	 <maciej.szmigiero@oracle.com>
Date: Tue, 04 Mar 2025 16:31:31 -0500
In-Reply-To: <87cyewq2ea.fsf@redhat.com>
References: <Z8ZBzEJ7--VWKdWd@google.com> <87ikoposs6.fsf@redhat.com>
	 <Z8cNBTgz3YBDga3c@google.com> <87cyewq2ea.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2025-03-04 at 15:46 +0100, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Tue, Mar 04, 2025, Vitaly Kuznetsov wrote:
> > > Sean Christopherson <seanjc@google.com> writes:
> > > 
> > > > FYI, QEMU's Hyper-V emulation of HV_X64_MSR_EOM has been broken since QEMU commit
> > > > c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), as nothing in KVM
> > > > will forward the EOM notification to userspace.  I have no idea if anything in
> > > > QEMU besides hyperv_testdev.c cares.
> > > 
> > > The only VMBus device in QEMU besides the testdev seems to be Hyper-V
> > > ballooning driver, Cc: Maciej to check whether it's a real problem for
> > > it or not.
> > > 
> > > > The bug is reproducible by running the hyperv_connections KVM-Unit-Test with a
> > > > split IRQCHIP.
> > > 
> > > Thanks, I can reproduce the problem too.
> > > 
> > > > Hacking QEMU and KVM (see KVM commit 654f1f13ea56 ("kvm: Check irqchip mode before
> > > > assign irqfd") as below gets the test to pass.  Assuming that's not a palatable
> > > > solution, the other options I can think of would be for QEMU to intercept
> > > > HV_X64_MSR_EOM when using a split IRQCHIP, or to modify KVM to do KVM_EXIT_HYPERV_SYNIC
> > > > on writes to HV_X64_MSR_EOM with a split IRQCHIP.
> > > 
> > > AFAIR, Hyper-V message interface is a fairly generic communication
> > > mechanism which in theory can be used without interrupts at all: the
> > > corresponding SINT can be masked and the guest can be polling for
> > > messages, proccessing them and then writing to HV_X64_MSR_EOM to trigger
> > > delivery on the next queued message. To support this scenario on the
> > > backend, we need to receive HV_X64_MSR_EOM writes regardless of whether
> > > irqchip is split or not. (In theory, we can get away without this by
> > > just checking if pending messages can be delivered upon each vCPU entry
> > > but this can take an undefined amount of time in some scenarios so I
> > > guess we're better off with notifications).
> > 
> > Before c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), and without
> > a split IRCHIP, QEMU gets notified via eventfd.  On writes to HV_X64_MSR_EOM, KVM
> > invokes irq_acked(), i.e. irqfd_resampler_ack(), for all SINT routes.  The eventfd
> > signal gets back to sint_ack_handler(), which invokes msg_retry() to re-post the
> > message.
> > 
> > I.e. trapping HV_X64_MSR_EOM on would be a slow path relative to what's there for
> > in-kernel IRQCHIP.
> 
> My understanding is that the only type of message which requires fast
> processing is STIMER messages but we don't do stimers in userspace. I
> guess it is possible to have a competing 'noisy neighbough' in userspace
> draining message slots but then we are slow anyway.
> 

Hi,

AFAIK, HV_X64_MSR_EOM is only one of the ways for the guest to signal that it processed the SYNIC message.

Guest can also signal that it finished processing a SYNIC message using HV_X64_MSR_EOI or even by writing to EOI
local apic register, and I actually think that the later is what is used by at least recent Windows.


Now KVM does intercept EOI and it even "happens" to work with both APICv and AVIC:

APICv has EOI 'exiting bitmap' and SYNC interrupts are set there (see vcpu_load_eoi_exitmap).

AVIC intercepts EOI write iff the interrupt was level-triggered and SYNIC interrupts happen
to be indeed level-triggered:

static int synic_set_irq(struct kvm_vcpu_hv_synic *synic, u32 sint)
...
	irq.shorthand = APIC_DEST_SELF;
	irq.dest_mode = APIC_DEST_PHYSICAL;
	irq.delivery_mode = APIC_DM_FIXED;
	irq.vector =
vector;
	irq.level = 1;
...


Best regards,
	Maxim Levitsky




