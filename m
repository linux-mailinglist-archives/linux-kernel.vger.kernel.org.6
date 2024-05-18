Return-Path: <linux-kernel+bounces-182709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE788C8EB9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2651C21355
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C822107;
	Sat, 18 May 2024 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pt+JPCwB"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7236C
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990678; cv=none; b=RzXOOm2m031HqcPl1NleKgi8ZiY3M+c3n0tZ8++L6xekcOsJnSQvbvphJokgqW2c1Ty59a8k9mDljljn1LRjxHL7sUUlyW7aJISDsBDJKaGt9cBSVZznslVIJAbQCuADeyVMXxWXQWTMhXhmV/KzjhQ3FVH1AvYh+VZcCOmbBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990678; c=relaxed/simple;
	bh=/eRx5j9Olq8g0v9QNR4KXSf1H43quyf1+GkCeQgXyEY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b8/whVV5+OwlQAPO0V4e4P+rT47xO8ZYGupqrANKPPOPN4tgAl21ZDC/MDtT5iXV5MSrx9dZkxVhpNRDFxGveM7SIwUm5u47TY1mHZS7FvFs2GfcvhH+GAsjthEcC9KNmzjfkU+CKKftdVZK9s5xbIUvuemSbCK5HjwLLCdDbjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pt+JPCwB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so13955317276.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715990675; x=1716595475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiLhUKHp10aDhXqcSVOgtW3D4BVCW/QzlTVoUhBFy1Q=;
        b=Pt+JPCwBn1tfPY18JP3NJ7hchO2V87LymriZ9xCtE70UkrV/tzo6Qjn4v9CQMY0OlP
         s4m7yUlza9K0GACDwxBWJK36A7MBj/y7Ti2nqSGneJJuNDWeZtFA4MXJ3MG8Iz+0P075
         1xeUOikgtrdElP9bkxlxl54+cTiubX1noRknnqD6JWBUzM0EJsBfVMebQh0p1wXjsW+b
         ngAAfesO1ngH9vGZOj2SXnbHDqhOOvO+YXGOwQHDIxdJcTN8gkYwmn3gktC6ZWh+gNjK
         6D8atEfRJGCon3mD6oRBl9/aASkEw1mF7aTK9wSof/1SrBqhwciEdxjzqX82lb1YqGrn
         90JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990675; x=1716595475;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiLhUKHp10aDhXqcSVOgtW3D4BVCW/QzlTVoUhBFy1Q=;
        b=tI8dRCqgb4pZI5XDE3w2fIB22vwH5GKBj2B8fOjPvCjpEv31iezucXzu+L70KWS6ik
         LbttUcRLaoWZmPoBHQIMxsJOn0+9GlDDlLygnuWIOSH1jIDbw/ezc6jKPWzthKvwtj6H
         +/JgNWANKPopx/1pQbE1LZOagyCjwnxISd6Ndtg/5RGZjIWVz5tEpzXcaxpHkkpJ24kh
         aN5lLeiporssIMHq5mOt7VmjNrg/cSrt5DPP3hYK5TwMFP4tO793gL0ID92pI2FU/lNh
         x4CXgb6iXGB7RNKI2a2iHH1rU/wPW5TKk9OerXWt34+4eS22dNXIL/6ny37php9bKFhb
         Udew==
X-Forwarded-Encrypted: i=1; AJvYcCWeQdJAJWXtlcLoJA/lGktxpxO1cFSp990mTwdL2s8ghYYWYLO9GeX2gCnvHs7PBf+oBchayULBmcQvMyD12RzgxyZgTIqL1o2YJTfQ
X-Gm-Message-State: AOJu0YzySXouq2xgHr4BemtAStmq/bj1CrNLpiX49rcz0Z1TncyvwRRf
	9cGL07wKzT1fC+99U1pzN5FTvsvB3agy3+i6VXcHTfF9SYUKzyQRkxtQYFfFn5RD4inh0CF7gQf
	pSQ==
X-Google-Smtp-Source: AGHT+IF5DYn1btGPCq0V3AyD6cn+jNWly1UHkCrbUtndtAlMJEetnjrnH0XnnkPKOuaiEh7TB/MPxXsXaz4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b31a:0:b0:de4:64c4:d90c with SMTP id
 3f1490d57ef6-dee4f4fb5bdmr2095762276.12.1715990675621; Fri, 17 May 2024
 17:04:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 17:04:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240518000430.1118488-1-seanjc@google.com>
Subject: [PATCH 0/9] KVM: x86: Fixes for KVM_INTEL_PROVE_VE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fixes and debug help for prove #VE support.  I'm not in love with the sanity
check implementation, but I also don't love the idea of plumbing in @kvm to
the low level SPTE helpers.

Not super well tested, but I wanted to get this posted asap in case someone
wants to debug the unexpected #VEs we're seeing.

Note, Isaku's patch needs his SoB.

Isaku Yamahata (1):
  KVM: x86/mmu: Use SHADOW_NONPRESENT_VALUE for atomic zap in TDP MMU

Sean Christopherson (8):
  KVM: nVMX: Initialize #VE info page for vmcs02 when proving #VE
    support
  KVM: nVMX: Always handle #VEs in L0 (never forward #VEs from L2 to L1)
  KVM: x86/mmu: Add sanity checks that KVM doesn't create EPT #VE SPTEs
  KVM: VMX: Dump VMCS on unexpected #VE
  KVM: x86/mmu: Print SPTEs on unexpected #VE
  KVM: VMX: Don't kill the VM on an unexpected #VE
  KVM: VMX: Enumerate EPT Violation #VE support in /proc/cpuinfo
  KVM: x86: Disable KVM_INTEL_PROVE_VE by default

 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/include/asm/vmxfeatures.h |  2 +-
 arch/x86/kvm/Kconfig               |  6 ++--
 arch/x86/kvm/mmu/mmu.c             | 45 ++++++++++++++++++++++++------
 arch/x86/kvm/mmu/spte.h            |  9 ++++++
 arch/x86/kvm/mmu/tdp_iter.h        |  2 ++
 arch/x86/kvm/mmu/tdp_mmu.c         |  2 +-
 arch/x86/kvm/vmx/nested.c          |  5 ++++
 arch/x86/kvm/vmx/vmx.c             | 11 ++++++--
 9 files changed, 67 insertions(+), 16 deletions(-)


base-commit: 4aad0b1893a141f114ba40ed509066f3c9bc24b0
-- 
2.45.0.215.g3402c0e53f-goog


