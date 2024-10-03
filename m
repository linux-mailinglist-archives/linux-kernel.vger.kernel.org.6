Return-Path: <linux-kernel+bounces-349738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83EF98FACD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5913B1F235CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4691D0BAA;
	Thu,  3 Oct 2024 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1z/LBtT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DB1D095B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999023; cv=none; b=b8dqtdvveBfB6BnIGNecABBpgd04oranQDiOnwrD26FdMR59zdEMgS5lpnis9sHAJtPNPkj4TolNasapSIMfniCwSoSvZv1GVCj+wVUuZYGy+mcP8jtuFHjm+MNuh+pLPHu2hg18xPWyfVkF5HE7FQ/ZV3CDj3GVx7cDdneeIFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999023; c=relaxed/simple;
	bh=MrYOzORlxdvEa+Cs6Xo6pLGsWIU47wFJtrLYLFKiQI8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bVmD/7cMJ/PY0FatYF12NicgWCtUMPNH6Y3fTGkmjt1XqyFu9JQ3gP8f1dbjQXQzyEaVWNeazEuC0/ot31gYSaAqNfm/UANHs0nQaBCxIedd1krpav/xB8e4+eNkOd6gmHjHTlMKxsvaG4xk+DQeOHixl2cJSjqz5auyYZX3XKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1z/LBtT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2555d3d0eso26359847b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727999021; x=1728603821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtUCmr7mtM7hVh0Kaw2sO5RiGWbeEtWgmTNgsqx09LA=;
        b=S1z/LBtTIshVaz+8AGSebKl0cVHrn8MjbXKHEqlMwOQiEvluIGxACu7iYcClx8T6gj
         fm02n3+nRuIIJ5P+FnMFsIj7y84Lioj8NX7t97KTgrjltZOXBSPcmcuqNXbaApZMWBSK
         lJs3xVHDA5bu5RoZZ7CmM8UlE9Dn/lhCYb4jr5KWMOLfMWmbfG8NWhfmaPwCT2k67t0M
         jVmjijefKDQXGNXP8jX05yXoNoNcDZKIvj0V2AVGNMzcGClxpof3Towm3/Et/+fj3vUq
         KB4R4JTm/N6FI8fghSEZ1PzOJ0x05wbI3fr32IlhrUJ0z5GwV9OlOxOhStt19fqdWNIB
         qskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999021; x=1728603821;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtUCmr7mtM7hVh0Kaw2sO5RiGWbeEtWgmTNgsqx09LA=;
        b=FOjqL1hR/UHQMNTC6wm2nLWI2FFkbDZbkmPHxNt5WzZVsiWvo6K8dFAuNFpUe4fvpU
         7drVKhedchJ3M9kPFY+HO3bujGS2JJ4cNbJeAL89H7vveBS+iYFU06hEH7rxvq6KwbnY
         Kk/SwgHCasobLQlsk2aanP9vVDavzNNsycKYm1GlIHfqrBHBctiBoxmV+vRD9GcTy11s
         Q5NC592qZDKResY23eqmzNXtDi6CsUzLpyzxI0C/WbvwMYDs+ETIFMGwlOyyGh+/HuSW
         7bRZ0jTArtwwhfOrRUcT++evgMoWwHOrwud14IpR0Ib12lOjJFNx/TpzP2Z6RWxgDEY7
         kHyw==
X-Forwarded-Encrypted: i=1; AJvYcCUxQh+j2EkFwFfjbnaThX8SgYBlcquwfcjkYa+2PAO+fqHcAYFru5l3pdDy+oaMNViD1L3J29uXOeMHrZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzou3aTA6j6Nd3tLZWZzr5/zSZLZbXuhOI6EObDZB75Lt8R4FRs
	6uK531GPTC3SNhN66cXwRUZtSxrm/f+9VxFLic4LGc4TqauEKUKyw0de3JKFss0uWPBkR4Hiq1M
	IZA==
X-Google-Smtp-Source: AGHT+IGTW2PoLyhi1EMsJ8TMLt9jNvc61TWk24+p5mZeg7b9r9RI7ofkvrv86tt32Dt8OzEiS0pstg/iI4E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4502:b0:68d:52a1:bf4 with SMTP id
 00721157ae682-6e2c6fdd0afmr126887b3.2.1727999020776; Thu, 03 Oct 2024
 16:43:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Oct 2024 16:43:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003234337.273364-1-seanjc@google.com>
Subject: [PATCH 00/11] KVM: selftests: AVX support + fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Enable CR4.OSXSAVE and XCR0.AVX by default when creating selftests vCPUs
in order to play nice with compilers that have been configured to enable
-march=x86-64-v3 by default.

While it would be easier to force v2 (or earlier), there are enough tests
that want XCR0 configured that it will (hopefully) be a net postive to
enable all XCR0 features by default.

The only real hiccup is the CR4/CPUID sync test, which disables CR4.OSXSAVE
to verify KVM toggles the associated CPUID bit.  And if it calls memset()
while OSXAVE is disabled, kablooie.  Fixing that requires a bit of assembly,
but overall I think it's worth carrying a few lines of assembly in order to
gain test coverage for running AVX instructions in guests, and boy are
compilers good at abusing AVX :-)

Fix a few bugs/warts found along the way.  Notably, the CPUID test has an
array out-of-bounds bug that can result in false passes (I only noticed
because it was getting a false pass on gcc).

Sean Christopherson (11):
  KVM: selftests: Fix out-of-bounds reads in CPUID test's array lookups
  KVM: selftests: Precisely mask off dynamic fields in CPUID test
  KVM: selftests: Mask off OSPKE and OSXSAVE when comparing CPUID
    entries
  KVM: selftests: Rework OSXSAVE CR4=>CPUID test to play nice with AVX
    insns
  KVM: selftests: Configure XCR0 to max supported value by default
  KVM: selftests: Verify XCR0 can be "downgraded" and "upgraded"
  KVM: selftests: Drop manual CR4.OSXSAVE enabling from CR4/CPUID sync
    test
  KVM: selftests: Drop manual XCR0 configuration from AMX test
  KVM: selftests: Drop manual XCR0 configuration from state test
  KVM: selftests: Drop manual XCR0 configuration from SEV smoke test
  KVM: selftests: Ensure KVM supports AVX for SEV-ES VMSA FPU test

 .../selftests/kvm/include/x86_64/processor.h  |  5 ++
 .../selftests/kvm/lib/x86_64/processor.c      | 24 +++++++
 tools/testing/selftests/kvm/x86_64/amx_test.c | 23 ++-----
 .../testing/selftests/kvm/x86_64/cpuid_test.c | 67 ++++++++++++-------
 .../kvm/x86_64/cr4_cpuid_sync_test.c          | 53 +++++++++------
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 19 ++----
 .../testing/selftests/kvm/x86_64/state_test.c |  5 --
 .../selftests/kvm/x86_64/xcr0_cpuid_test.c    | 11 ++-
 8 files changed, 122 insertions(+), 85 deletions(-)


base-commit: efbc6bd090f48ccf64f7a8dd5daea775821d57ec
-- 
2.47.0.rc0.187.ge670bccf7e-goog


