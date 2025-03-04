Return-Path: <linux-kernel+bounces-544405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE0EA4E0FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA00E3A8BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B0720896B;
	Tue,  4 Mar 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3yNME0H"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBE52080F5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098248; cv=none; b=Bn1NsmfAg/KV6XF1gK1CDaL+WIYHwnrC1rMUKbMlFHI5/kDsFRsBAqrjoJSUFgOms4g2EgNodPSJ7xwXn0FMB2GnmXtlL+KLEUXi44trs/M6WH4lN/K/qj0zBJ+kh0yHK8keQowaBfIb4wCD9hzdArsPetuoIUD4eXqvEmLRDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098248; c=relaxed/simple;
	bh=9Bl9KwN0gqToxnWw3xRARnhDd5Ny5Hr/yDwL7Fo49yo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hsci1y0zNZAeaQQ/r9JeY3pSXo+KSBNncRfTzJxios+EiiHF7//efJdiaIXRwS9Yruocn0LxfeUctmOryw4353i47i/nGEr3GDmvgMCq0yLlLqfFsGcjWeTiLKVaOcN7rsjNS7XVC6/mEaex0MsIepxEbFIB8E8HN6iAhrH94f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3yNME0H; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fee7f85d03so8759455a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741098246; x=1741703046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0bJtWO/zgI2jPul9efwN4/8kC8XZP1YPShn0ZzQqIY=;
        b=d3yNME0HUSQ7V93gBlOJ2WfEjImVNOr/6vMFbYHwbP/gor34aGg6WYSdsg9SuyI5Y5
         fob/J7hWUxHaWcO7lWWSVJ9nTmage31vDPP4yJctnA56jt2UH2X+WXLbs7H1unydeNZv
         wMqgpw3i+0zvbtFD78ltR/p8a6eFnIQPYHr3gSTr0CMURctexULWp5O8Dt3YXRUublFG
         5TA7zqXuMAPTy02cfI1xOSZXzaxrfjbIllcLPgsvhD/ElLWvJJEUO8kkzwQR1nONoPxD
         epN52qatSfBWuaM8mS69mbQ4DhPZQ0TfI6bLPNgjTVB2tZXf4V60o6C4SZ83McgK1s+7
         C4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098246; x=1741703046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0bJtWO/zgI2jPul9efwN4/8kC8XZP1YPShn0ZzQqIY=;
        b=WfF85vhIsH5hsxP0crf6nmU+jRvFU9lXw0iCHQUSprgdKINROiZCnWigKXBVBq4ow0
         CHl/a8qJV1Gc6h/I/xe5GVk2I7UWxL+V7mtHSYGko4WVOa+afzknyw29hcOioAAApTco
         xvnsN/we0LHcNrigTGwJHffGTYwA6KnH6AE3DYwZi6OGC+4cg9FLO4byzem1QlO0S2Q4
         1SAlTMZ6GDOW8cQqXQydeO7+d9cBKj7gtAFfjliIyNT0UUiQPCkPO9HUIj6Xlq57XmCC
         3QdBQo4MKwT3+9w7s8OVHNjFTLp8FunksRCcOYuJFXyJZxYREvd8m7qKyWbBxtb2dVzA
         jV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2y3QfD39eOJgiZ7u/TFZ8mn2K0OSV54mShN/kBF5WWfD4NuA/JtbA7s7PTc2NaceersGIrglDgUI9f6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YybPqkYAAtiEpQlfYrcO0gCb3fyxFM+Mg8QjP6CGLHm9pcQJlLW
	sYelPfx4psLyc0ILBmI2o/FKJ+ICRLwKo/NmwknFBaleSsGA/8n1azzlJD4lsDTWRZHLmPg3NWI
	C9Q==
X-Google-Smtp-Source: AGHT+IGL3TvS3xJpuQuBmUEPAOK05SjuoCnEI7eL2mdXhB6ZVp9f2QmZKZ+Ad458Pw2V2VPF2vgblI0mNPs=
X-Received: from pjbsj5.prod.google.com ([2002:a17:90b:2d85:b0:2f9:c349:2f84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c6:b0:2ee:53b3:3f1c
 with SMTP id 98e67ed59e1d1-2febab2ed89mr25640807a91.5.1741098246542; Tue, 04
 Mar 2025 06:24:06 -0800 (PST)
Date: Tue, 4 Mar 2025 06:24:05 -0800
In-Reply-To: <87ikoposs6.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z8ZBzEJ7--VWKdWd@google.com> <87ikoposs6.fsf@redhat.com>
Message-ID: <Z8cNBTgz3YBDga3c@google.com>
Subject: Re: QEMU's Hyper-V HV_X64_MSR_EOM is broken with split IRQCHIP
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 04, 2025, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > FYI, QEMU's Hyper-V emulation of HV_X64_MSR_EOM has been broken since QEMU commit
> > c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), as nothing in KVM
> > will forward the EOM notification to userspace.  I have no idea if anything in
> > QEMU besides hyperv_testdev.c cares.
> 
> The only VMBus device in QEMU besides the testdev seems to be Hyper-V
> ballooning driver, Cc: Maciej to check whether it's a real problem for
> it or not.
> 
> >
> > The bug is reproducible by running the hyperv_connections KVM-Unit-Test with a
> > split IRQCHIP.
> 
> Thanks, I can reproduce the problem too.
> 
> >
> > Hacking QEMU and KVM (see KVM commit 654f1f13ea56 ("kvm: Check irqchip mode before
> > assign irqfd") as below gets the test to pass.  Assuming that's not a palatable
> > solution, the other options I can think of would be for QEMU to intercept
> > HV_X64_MSR_EOM when using a split IRQCHIP, or to modify KVM to do KVM_EXIT_HYPERV_SYNIC
> > on writes to HV_X64_MSR_EOM with a split IRQCHIP.
> 
> AFAIR, Hyper-V message interface is a fairly generic communication
> mechanism which in theory can be used without interrupts at all: the
> corresponding SINT can be masked and the guest can be polling for
> messages, proccessing them and then writing to HV_X64_MSR_EOM to trigger
> delivery on the next queued message. To support this scenario on the
> backend, we need to receive HV_X64_MSR_EOM writes regardless of whether
> irqchip is split or not. (In theory, we can get away without this by
> just checking if pending messages can be delivered upon each vCPU entry
> but this can take an undefined amount of time in some scenarios so I
> guess we're better off with notifications).

Before c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), and without
a split IRCHIP, QEMU gets notified via eventfd.  On writes to HV_X64_MSR_EOM, KVM
invokes irq_acked(), i.e. irqfd_resampler_ack(), for all SINT routes.  The eventfd
signal gets back to sint_ack_handler(), which invokes msg_retry() to re-post the
message.

I.e. trapping HV_X64_MSR_EOM on would be a slow path relative to what's there for
in-kernel IRQCHIP.

