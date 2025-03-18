Return-Path: <linux-kernel+bounces-566707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB476A67B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1604B881814
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA62F2135A3;
	Tue, 18 Mar 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rAxQrmx"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54B20B807
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320993; cv=none; b=axHXE1YSa+vSO8v7QP9DSX752ghZ8JlAckpv8SkIDIJa832ZprjBz4c3gzrWYbcyYGVg8717oXA+GhjZgaWMYGYy5d9NW7LLoxOJPgsvp4BDfnEAApnWOkTc9E6yIprQHD8t4RQtVjbu+B2nZR9tNmqmGYw1jZJCJ/EYAKfvOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320993; c=relaxed/simple;
	bh=KENC4RjlZ0X4TyudrMDbrXvOzjDL0WiMjcmJsQFWibc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IeqRtwbruE3J1DKWL2uuwrgX1fjhXSEXCLT3ocLEnB0sG5rtVegLp3UP02UrmiV/TcP4DqJwweTcTQh6tr+HuvojERhBBuUBaYlZsq5hDWBfcMf5KewCHlVsfyrXHUv/IVRkwc506CoI9bH1soUeG+PZFaarM39lTyuSpqTLhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rAxQrmx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224191d9228so118285395ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742320987; x=1742925787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzJAfV/bUsOvTBEHqlYxu62ZiO+HkVeOaadUps7WQgc=;
        b=4rAxQrmxFB39h3vA6iwtV/btrQzn46web3yVTDBXHaZeSQBRWmZybqeDBdZNQC1wJp
         mhSjnRkfFakw8NcMh/6bsobwBK6IXsHRrjh7dLux0P3O9xrOk7IvNSNEZv7JxUXp6pml
         sryOhf4pMVhiH4dBjFH9KqAlxGXf6AufnlAzpnk5rrt+/vk4JoiPVHDaydeGbZCSggCf
         1s0AhRgcJHEV8Jciv1Z57GIhuP2XDplTEywNc7F6J8gW4rkUyV834gndByOctX0V9Jh3
         mzpoqYV0jQPsiY9pYc0kf0YkCUY/6F0T84pBFUKCvT/h3nuX0dEjAkNQBeUmQOffRiOE
         A9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320987; x=1742925787;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzJAfV/bUsOvTBEHqlYxu62ZiO+HkVeOaadUps7WQgc=;
        b=HwKnzx4/KMsDQ0WZa78ChtwDg3h0m0C1/srzYzZEXUsXs74fNEDz81jazA630BP3fN
         FPllQYwhjJrrAkPh+CvTh9aGYykjm0dPJpAyZWKdBiD8Y+uMQ2OHkFtHQzYdo53GV7tP
         DzPsbuDoGCtgeBTgEOMfR38p35+wvthGs8fVdZOQP77lyMHuB33ZNsC7nT66b1aL8pHc
         ohWpHjh+vXMkd+Nnw0sp+D/j0kaUdDuXcbtBG88pRe7Y1A3hLbD0aiq9Zjs9CGNitQr0
         1C9C86Rkp3pcPGT4H03zMGTUI7yag1Okfp1d9X8l9xNQH/QtVs68+DUBuFHlC7qqceqE
         hf1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVChufO3yuDnKxQZrNe/IK844tTbWPC8Gt4l0X/F2TQduiBchKXdB6DII/82KhutSBzl9V0ekV3P8sBcTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqB2FmtIk29WW46bz7/C21g8E+e2gak1WgyXY1Xi4uZlbMLhT
	kDgZblQLxcpt6COIMxJlvrEG36Br8ubVUrortek6i4ueB/tLIO2+Hh6IJ+GqwgNfgEHZk0leEkW
	Aew==
X-Google-Smtp-Source: AGHT+IEQhlpm2/LL+7EBkmZARZuu5EZhZyR1zpmdmd4aRSN4LdpUvkThdLTY/U47aPkpqbQsnhWd5hPZ1GE=
X-Received: from pfbcq25.prod.google.com ([2002:a05:6a00:3319:b0:732:51fc:618f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a83:b0:1f5:837b:186a
 with SMTP id adf61e73a8af0-1f5c10f6505mr27660358637.6.1742320987462; Tue, 18
 Mar 2025 11:03:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Mar 2025 11:02:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318180303.283401-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Changes for 6.15
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

There are two conflicts between the PV clock pull request and the Xen
pull request.

1. The Xen branch moves Xen TSC leaf updates to CPUID emulation, and the PV
   clock branch renames the fields in kvm_vcpu_arch that are used to update
   the Xen leafs.  After the dust settles, kvm_cpuid() should look like:

   		} else if (IS_ENABLED(CONFIG_KVM_XEN) &&
			   kvm_xen_is_tsc_leaf(vcpu, function)) {
			/*
			 * Update guest TSC frequency information if necessary.
			 * Ignore failures, there is no sane value that can be
			 * provided if KVM can't get the TSC frequency.
			 */
			if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, vcpu))
				kvm_guest_time_update(vcpu);

			if (index == 1) {
				*ecx = vcpu->arch.pvclock_tsc_mul;
				*edx = vcpu->arch.pvclock_tsc_shift;
			} else if (index == 2) {
				*eax = vcpu->arch.hw_tsc_khz;
			}
		}

2. The Xen branch moves and renames xen_hvm_config so that its xen.hvm_config,
   while PV clock branch shuffles use of xen_hvm_config/xen.hvm_config flags.
   The resulting code in kvm_guest_time_update() should look like:

#ifdef CONFIG_KVM_XEN
	/*
	 * For Xen guests we may need to override PVCLOCK_TSC_STABLE_BIT as unless
	 * explicitly told to use TSC as its clocksource Xen will not set this bit.
	 * This default behaviour led to bugs in some guest kernels which cause
	 * problems if they observe PVCLOCK_TSC_STABLE_BIT in the pvclock flags.
	 *
	 * Note!  Clear TSC_STABLE only for Xen clocks, i.e. the order matters!
	 */
	if (ka->xen.hvm_config.flags & KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE)
		hv_clock.flags &= ~PVCLOCK_TSC_STABLE_BIT;

	if (vcpu->xen.vcpu_info_cache.active)
		kvm_setup_guest_pvclock(&hv_clock, v, &vcpu->xen.vcpu_info_cache,
					offsetof(struct compat_vcpu_info, time));
	if (vcpu->xen.vcpu_time_info_cache.active)
		kvm_setup_guest_pvclock(&hv_clock, v, &vcpu->xen.vcpu_time_info_cache, 0);
#endif

