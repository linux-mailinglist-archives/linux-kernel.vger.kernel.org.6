Return-Path: <linux-kernel+bounces-392836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F3E9B98AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE1B281662
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004341D0483;
	Fri,  1 Nov 2024 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULkUw9c1"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14971487D6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489509; cv=none; b=L2bRuj4ST5slK9/ssJlEDxSwxtvnIVIlVOkRnU3zBnnTsRL11m4qRezeTaca8qBNP2J0kpCrRItqknNsI3zQjgBi3EKeSEIEtlVo2ZTqHCWxBaoG2YQRPoCSC5eUoDJ4hT44/T4woDQOmZo7foHTpmnvCxJvlENcpn5+MqE3k7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489509; c=relaxed/simple;
	bh=Ydtn34bo6yYS/1Yfgke+Vh3SnrVAuJi8koS7bnhJeH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hEa/nS07N3dnxU5LPo+bTHGWc0OHk5M1Uw710ZGcx3G8zeB5UwGcYFlRyAhtEvpyJvbnVVUMukwnXUXUxUxqTuMf3llGapzux+nv3XLpNNmxQeDjXJePt2KhzIH8RyYi4vaoH4lYguY1CCVPi2491GPJbGrDruUPhMyqxYehyv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULkUw9c1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-210d5ea3cf5so20976685ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730489507; x=1731094307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbaegUVJNOr9V01yWcgxuLVN1F7S/BsruvWxQD+2AsE=;
        b=ULkUw9c1VeAQ7mxkprtBvVuvCfsl9s+27Zqy3IIaPdF0mga3qb1aipkMh2Q0sP+nRG
         2YWkgJzsSXLR4EEtPO52lbgQVb6ToF0JmoayIhX6JzyWWK71FNLeFUjB57NMk0N/ZMlJ
         XRmFIqow8ucmlo0gG4WaLk99YhTOY9Gq2qAFDSMU9GDwJwCT7hwB7+MLPPzhmzE9cq/B
         gnXIeofBYNw/zaUBCVB9ztUTRbgiIhm1Lfyw8IdKHX5/JSE1n1SRtmO9XtJ5vEcDPJeB
         fg1Yrg1nIB0umRlZrpF5sjk6ormsTz6OB/zFD0ZcWi1VSEZIGwKj81PZ7pkZpGStquXq
         MYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489507; x=1731094307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbaegUVJNOr9V01yWcgxuLVN1F7S/BsruvWxQD+2AsE=;
        b=FvkBAGDqCeeHz4FA5bOZqDkWkIy0rzjOsHkKkmp7/YDlYKcewtmJV9tDWt6gtb9yTF
         AusW7g7ggZLA2JGD3nL6eK6gHy/P9w33v0r+c8thy3kBfrdh5ZKvY1ndCkukzTGgCRJd
         ZRVQy3DMM072L5TXQP5LBnlzQQEz6Keu7KlZSy0cypRS3OHogyl1U27C8WcSCND1eXp7
         9dOs7eZ6Uo76g49iV+y0UfGVQgo0x6ojzimGaAZorLRzDfcRmw/DEBA0bfaC4f8oohxo
         Ag1EhBeQ49aWuNvLU4sWsWFkORd8mlH0hX9Lg5e123mBoKutx0ozf2XgrgJWCiU4iM9J
         aQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlIXZcfmjOLrfE1s1zWq4r5+/jC5u2HzFlilG2H8U5GHeqO1YMtad/Y0WBFzZdqco1aHUqrRfsHvr23P4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41P44sjpFRHpmkRnvdBOsFS3zlBV6D/ppvso/qYn1XHCZydwT
	ylYr/Y+SatpKYOEC6cHMzzZ/QlvtduLVdpEDwaFXpWt10Fz5sqYoTh5lKTuSXFA05laYmMFOiaS
	oKw==
X-Google-Smtp-Source: AGHT+IGrCzXLZqMTXley3z2HFHQYMw38eZK8/faOaOnxAdII/p+rSmb/BjvBGy9Iia9EgQNAqq4VHCZuJRo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:aa0c:b0:20c:5beb:9c6a with SMTP id
 d9443c01a7336-2111946702emr76805ad.4.1730489507177; Fri, 01 Nov 2024 12:31:47
 -0700 (PDT)
Date: Fri, 1 Nov 2024 12:31:45 -0700
In-Reply-To: <173039505052.1508646.12399325550980838662.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003234337.273364-1-seanjc@google.com> <173039505052.1508646.12399325550980838662.b4-ty@google.com>
Message-ID: <ZyUsoew4e3XQQEvr@google.com>
Subject: Re: [PATCH 00/11] KVM: selftests: AVX support + fixes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 31, 2024, Sean Christopherson wrote:
> On Thu, 03 Oct 2024 16:43:26 -0700, Sean Christopherson wrote:
> > Enable CR4.OSXSAVE and XCR0.AVX by default when creating selftests vCPUs
> > in order to play nice with compilers that have been configured to enable
> > -march=x86-64-v3 by default.
> > 
> > While it would be easier to force v2 (or earlier), there are enough tests
> > that want XCR0 configured that it will (hopefully) be a net postive to
> > enable all XCR0 features by default.
> > 
> > [...]
> 
> Applied to kvm-x86 selftests, minus patch 1 which went into 6.12.  At some point
> in the 6.13 cycle I'll send a revert for the "march" madness.
> 
> [01/11] KVM: selftests: Fix out-of-bounds reads in CPUID test's array lookups
>         (no commit info)
> [02/11] KVM: selftests: Precisely mask off dynamic fields in CPUID test
>         https://github.com/kvm-x86/linux/commit/c0124e2e74a7
> [03/11] KVM: selftests: Mask off OSPKE and OSXSAVE when comparing CPUID entries
>         https://github.com/kvm-x86/linux/commit/01e2827157ef
> [04/11] KVM: selftests: Rework OSXSAVE CR4=>CPUID test to play nice with AVX insns
>         https://github.com/kvm-x86/linux/commit/cf50f01336d3
> [05/11] KVM: selftests: Configure XCR0 to max supported value by default
>         https://github.com/kvm-x86/linux/commit/331b8ddaebc1
> [06/11] KVM: selftests: Verify XCR0 can be "downgraded" and "upgraded"
>         https://github.com/kvm-x86/linux/commit/d87b459428c0
> [07/11] KVM: selftests: Drop manual CR4.OSXSAVE enabling from CR4/CPUID sync test
>         https://github.com/kvm-x86/linux/commit/86502f01b8b9
> [08/11] KVM: selftests: Drop manual XCR0 configuration from AMX test
>         https://github.com/kvm-x86/linux/commit/fd7b6d77fa6d
> [09/11] KVM: selftests: Drop manual XCR0 configuration from state test
>         https://github.com/kvm-x86/linux/commit/818646fea3ea
> [10/11] KVM: selftests: Drop manual XCR0 configuration from SEV smoke test
>         https://github.com/kvm-x86/linux/commit/ce22d24024ea
> [11/11] KVM: selftests: Ensure KVM supports AVX for SEV-ES VMSA FPU test
>         https://github.com/kvm-x86/linux/commit/08cc7ab1a6ca

And because I mucked up the mmu_stress_test/vcpu_get_reg() series and had to yank
it out, the hashes for this series got changed:

[02/11] KVM: selftests: Precisely mask off dynamic fields in CPUID test
        https://github.com/kvm-x86/linux/commit/f2c5aa31670d
[03/11] KVM: selftests: Mask off OSPKE and OSXSAVE when comparing CPUID entries
        https://github.com/kvm-x86/linux/commit/164cea33bfed
[04/11] KVM: selftests: Rework OSXSAVE CR4=>CPUID test to play nice with AVX insns
        https://github.com/kvm-x86/linux/commit/2b9a126a2986
[05/11] KVM: selftests: Configure XCR0 to max supported value by default
        https://github.com/kvm-x86/linux/commit/8b14c4d85d03
[06/11] KVM: selftests: Verify XCR0 can be "downgraded" and "upgraded"
        https://github.com/kvm-x86/linux/commit/8ae01bf64caa
[07/11] KVM: selftests: Drop manual CR4.OSXSAVE enabling from CR4/CPUID sync test
        https://github.com/kvm-x86/linux/commit/3678c7f6114f
[08/11] KVM: selftests: Drop manual XCR0 configuration from AMX test
        https://github.com/kvm-x86/linux/commit/d87331890a38
[09/11] KVM: selftests: Drop manual XCR0 configuration from state test
        https://github.com/kvm-x86/linux/commit/28439090ece6
[10/11] KVM: selftests: Drop manual XCR0 configuration from SEV smoke test
        https://github.com/kvm-x86/linux/commit/3c4c128d02ed
[11/11] KVM: selftests: Ensure KVM supports AVX for SEV-ES VMSA FPU test
        https://github.com/kvm-x86/linux/commit/89f8869835e4

