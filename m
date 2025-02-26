Return-Path: <linux-kernel+bounces-532802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8637CA45263
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EA316BB85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F02F19DF8B;
	Wed, 26 Feb 2025 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W33KhOJh"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A66EEAFA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534522; cv=none; b=OeM4vNIdJ+1EeByCpoHxtmBeYcRRWYu+xlu8cna/ibeXgaO64qK9KghMq0wpW0YXn9395cBt5EBfLt9RxessXbdktMQf0y2Y+KRPjfzB9jpu4EcT75eXIimHCVFtRLutV7tkAZmfcrUTSFB19jkWn+oeEbOyCCncKCiSNlsdPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534522; c=relaxed/simple;
	bh=8KerjFk2EvGwBFPKQDzV8ouER5CpZD5Yyf5qGt3H7/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jLyzemcUO6+viwpD//E6qXd5BjZn7SLxWanlVS+HyjjkXXwmTuN04DTz8LQ0DgRRmnSjzf1ru2db+NtHVeKB8iGDdfY1UQ10EFMLAR3z18RqqsAX1GyqmkkKbyU6b3QaK7y/HaJLffT7trE6dZldbOzXf5JmLGSXTGRhn1IP2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W33KhOJh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so20759692a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740534520; x=1741139320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxV7S/kNxrYNocrcYJbAAgRx5UIwaRych+aDBLsw374=;
        b=W33KhOJh+c86u34AeCXBGI1TUzZGsfa20n8uGVxfedx6lsXubEMXdirwVTqbdNA20P
         gIq51sfRCotgXqc7fsilR2SQXl/vhm22k7UHQqcLioo7pyAfeTcJJXAZeD09c5Dfznig
         xVNyVk5c0UbAF2wtCZSxjKsTFt36Ijfv1bzk1chI4MU8UgIz+IUZ0cl9v3Ndtlx9qb7m
         gyxHwyXAKTTVq/F4VMQDUb5bdCDoLYj5X033zmKE0hA50EbQjsj0RlvUmZYsGbjHKbf7
         9OYAbaCwOo5jL/xLK85A9H1i9uLEsK5MCIPXc7Q+RSjgip1aUuYUdVMJOxDpsFsS4ZZF
         vUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740534520; x=1741139320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxV7S/kNxrYNocrcYJbAAgRx5UIwaRych+aDBLsw374=;
        b=bwJqqZEGpO9F6XBvEU0VXXMybKeYm8PZztZARxBBDz3LXDEm/bF08Vxgo50/lpIEY3
         lRqTMsy8CyRjVghK2wRapxV9MigMqFdrzrE10KP5A+eUwwVIbDTlS2m0AL9iYaUavD4j
         xUgrN11Xtb2NNtbSLrYO1TNnEy7NLkG28UYERtrV/f9VCU2FlZh5sOrkl+lpJzs4qMyk
         xKubcSWH/YkJyjpK08JxS/KBa4oP4EmAfS5rHS/2vS1Bn1D3Dny2nKEnGJb2dGB+Ylvg
         i4aSKKa6dRLzxYhgRZ9GGx6M9j36lZAV09F7VmlvyBaEacCuTtXH4GbKXym7ur0/nYo8
         +5wg==
X-Forwarded-Encrypted: i=1; AJvYcCW2T13b/fCJNtiIophFvpwunXLdjqQNXtXez65ZujsMlWvppnlbZ3mYQRTtt4mx2ScCTscTT52AaT1ahzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2UyWkdpF1oXIrhz2dAmXUAMse5DKqeinvUD7OPk8emWzRpee
	dT2SnWlpt7fvxCb6jYuOu0xH+Tml3CNMmS+ZOhUyyEnTIeVNIu1OFnPf/378SiAMlaSKt7mpg71
	aEg==
X-Google-Smtp-Source: AGHT+IG6F4CEGu1Wh56KOfshDry3QLMGkz+lzFq3rrJNvVa5WCqoW7cR/Az9DHNbApkDRbLe1gfNGWHwcpw=
X-Received: from pjtq6.prod.google.com ([2002:a17:90a:c106:b0:2fc:11a0:c53f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5686:b0:2ee:aed6:9ec2
 with SMTP id 98e67ed59e1d1-2fe7e30045emr3002205a91.14.1740534520656; Tue, 25
 Feb 2025 17:48:40 -0800 (PST)
Date: Tue, 25 Feb 2025 17:48:39 -0800
In-Reply-To: <20250208105318.16861-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250208105318.16861-1-yan.y.zhao@intel.com>
Message-ID: <Z75y90KM_fE6H1cJ@google.com>
Subject: Re: [PATCH] KVM: selftests: Wait mprotect_ro_done before write to RO
 in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Feb 08, 2025, Yan Zhao wrote:
> In the read-only mprotect() phase of mmu_stress_test, ensure that
> mprotect(PROT_READ) has completed before the guest starts writing to the
> read-only mprotect() memory.
> 
> Without waiting for mprotect_ro_done before the guest starts writing in
> stage 3 (the stage for read-only mprotect()), the host's assertion of stage
> 3 could fail if mprotect_ro_done is set to true in the window between the
> guest finishing writes to all GPAs and executing GUEST_SYNC(3).
> 
> This scenario is easy to occur especially when there are hundred of vCPUs.
> 
> CPU 0                  CPU 1 guest     CPU 1 host
>                                        enter stage 3's 1st loop
>                        //in stage 3
>                        write all GPAs
>                        @rip 0x4025f0
> 
> mprotect(PROT_READ)
> mprotect_ro_done=true
>                        GUEST_SYNC(3)
>                                        r=0, continue stage 3's 1st loop
> 
>                        //in stage 4
>                        write GPA
>                        @rip 0x402635
> 
>                                        -EFAULT, jump out stage 3's 1st loop
>                                        enter stage 3's 2nd loop
>                        write GPA
>                        @rip 0x402635
>                                        -EFAULT, continue stage 3's 2nd loop
>                                        guest rip += 3
> 
> The test then fails and reports "Unhandled exception '0xe' at guest RIP
> '0x402638'", since the next valid guest rip address is 0x402639, i.e. the
> "(mem) = val" in vcpu_arch_put_guest() is compiled into a mov instruction
> of length 4.

This shouldn't happen.  On x86, stage 3 is a hand-coded "mov %rax, (%rax)", not
vcpu_arch_put_guest().  Either something else is going on, or __x86_64__ isn't
defined?

	do {
		for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
#ifdef __x86_64__
			asm volatile(".byte 0x48,0x89,0x00" :: "a"(gpa) : "memory"); /* mov %rax, (%rax) */
#elif defined(__aarch64__)
			asm volatile("str %0, [%0]" :: "r" (gpa) : "memory");
#else
			vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
#endif
	} while (!READ_ONCE(mprotect_ro_done));

	/*
	 * Only architectures that write the entire range can explicitly sync,
	 * as other architectures will be stuck on the write fault.
	 */
#if defined(__x86_64__) || defined(__aarch64__)
	GUEST_SYNC(3);
#endif

	for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
		vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
	GUEST_SYNC(4);



> Even if it could be compiled into a mov instruction of length 3, the
> following execution of GUEST_SYNC(4) in guest could still cause the host
> failure of the assertion of stage 3.

Sorry, I don't follow.  The guest doesn't get "released" from GUEST_SYNC(3) until
the host runs the vCPU again, and that happens after asserting on stage 3 and
synchronizing with the main thread.

	assert_sync_stage(vcpu, 3);
#endif /* __x86_64__ || __aarch64__ */
	rendezvous_with_boss();

	/*
	 * Stage 4.  Run to completion, waiting for mprotect(PROT_WRITE) to
	 * make the memory writable again.
	 */
	do {
		r = _vcpu_run(vcpu);
	} while (r && errno == EFAULT);

