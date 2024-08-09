Return-Path: <linux-kernel+bounces-281418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F69094D6CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDDDB21D0A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB915EFD0;
	Fri,  9 Aug 2024 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESdkwtK3"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEDE14B06A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230209; cv=none; b=V65K1VWSWp+cqBrH1ZRzBxax9XATHPrw7JwpRshugt7ggErqIne+rFJs+YNrIwZ0PI2Pbwskaxa3jQv0M9ggkgDOdZ/nu3aXMinhWnYBi78qvF2o9HcWPOA5bO6eCFNeTtqcFu/UqbSMXKGheEIAI6yQ1loHjlcEl6WzYdRIRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230209; c=relaxed/simple;
	bh=ZQLLTeLMBIEJhBkIwQT3YlIR/s3hcV7ccG9E1dpoOME=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T/VLA2llyMsQlEZ8R1mNh0PzD+4p11tszo9bt9NIR3Wmq19Zk62EsmF6xtErGbtbsH4bqPlv5zzInkMhbULNOTMIbvijG0sp5Sk+zZbHrlmQGTX9SjwNUZLUfvmdSmTFZPxn85yxr/fJz4dIIFAfODSyzTBxEeYgJCT/sLNVrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESdkwtK3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6506bfeaf64so46509517b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230206; x=1723835006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU2vSz6TwyPSz91eAh+7kprYrDZ7GY5mJ2QbvGjupP4=;
        b=ESdkwtK3qNoOpEmHNcdEg5YmqWQQt8sNnmBUcxnpwmo0MGB6KZ+ZFgJ62htAh+PK/L
         mUJRCmtxOC8fbk2/PxIFdEqjiSXR8ywkZoLqnGXYURSpWPYpr1H8U8SdNQwYdWc31U3K
         D2gzhJCeVWe8pZ5xyXoz5EagOohW+aASRjSCoAzVxskgq494R5QnKAqkCWbmEuimiC3h
         C5GtTbrCRNbDCX0wLXAFsftVjsBHTuw0L5NTJUfGjxdnYpAXohlB376J08yymQc7OK/o
         SZY80xt7kaBL84L0DW95dZwOhn6/9rW5IAZUsA6L2F5VIHUAQ+bpfFEaAIkiG03IesGW
         Xbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230206; x=1723835006;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aU2vSz6TwyPSz91eAh+7kprYrDZ7GY5mJ2QbvGjupP4=;
        b=WA/mGnxWbvrhGOGYhCTd96upfcExaYxgomgvuBp2kGbzecXkV5UmuiPerdvlYp79sM
         vqhTiZdU+P3vslfIF0f2UGdN72jmH3ZrwnO3cfQUxiiStEcBP9GbmgGgFan3eu+YYICY
         z9GSY8h/RPL1XieTdIjywvZWxnP81In/yWy2/MbIrPD6UxBUIpea2pEis78gUYzV2Qe2
         A16bBaruycnHvJOLVbWNGOjgHY9ZALkpfZRXnE9EYYQe7vpcQhTN3ySuyj+VUxtPVEhg
         D0AFpNs0bCgclN2Vu9pzyL5I96evWDLD0bsJi9kAJ5Jsmz4BmKUQf8DWNcvshNFJ61NE
         ZL/g==
X-Forwarded-Encrypted: i=1; AJvYcCWC1bpL04GP5ZVRnBQjJHOImrin5uzyBUpdw1DsdJD75K3+pAsRsFHXdnBl6fqo8NSLwStz276mlr6KD68RCk1Jmh+NxJzNoDw39PWj
X-Gm-Message-State: AOJu0YymoTTSHbE+MWlS8mFqSzCo/mkQlC2wJKdhEVDgifj5rmcLm1/6
	1PIY4APCbBZ1WBRTlepgxG4NB7qDot6gdPM6CUmgafymFQpQx2soAAmdbE4/LMlxrskWDfrQo4j
	u5w==
X-Google-Smtp-Source: AGHT+IEhTr84VWIzodvN4nwh0VeQNTWMRQZX82uN2NtmzqmtCIYUdEP1WCkak1HNHQUiRXUH7AbdwzrnLyU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2e89:b0:69b:2f8e:4d10 with SMTP id
 00721157ae682-69ec8c8e5d4mr637717b3.7.1723230206582; Fri, 09 Aug 2024
 12:03:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:02:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809190319.1710470-1-seanjc@google.com>
Subject: [PATCH 00/22] KVM: x86: Fix multiple #PF RO infinite loop bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

The folks doing TDX enabling ran into a problem where exposing a read-only
memslot to a TDX guest put it into an infinite loop.  The most immediate
issue is that KVM never creates MMIO SPTEs for RO memslots, because except
for TDX (which isn't officially supported yet), such SPTEs can't distinguish
between reads and writes, i.e. would trigger MMIO on everything and thus
defeat the purpose of having a RX memslot.

That breaks TDX, SEV-ES, and SNP, i.e. VM types that rely on MMIO caching
to reflect MMIO faults into the guest as #VC/#VE, as the guest never sees
the fault, KVM refuses to emulate, the guest loops indefinitely.  That's
patch 1.

Patches 2-4 fix an amusing number of other bugs that made it difficult to
figure out the true root cause.

The rest is a bunch of cleanups to consolidate all of the unprotect+retry
paths (there are four-ish).

As a bonus, adding RET_PF_WRITE_PROTECTED obviates the need for
kvm_lookup_pfn()[*].

[*] https://lore.kernel.org/all/63c41e25-2523-4397-96b4-557394281443@redhat.com

Sean Christopherson (22):
  KVM: x86: Disallow read-only memslots for SEV-ES and SEV-SNP (and TDX)
  KVM: VMX: Set PFERR_GUEST_{FINAL,PAGE}_MASK if and only if the GVA is
    valid
  KVM: x86/mmu: Trigger unprotect logic only on write-protection page
    faults
  KVM: x86/mmu: Skip emulation on page fault iff 1+ SPs were unprotected
  KVM: x86: Retry to-be-emulated insn in "slow" unprotect path iff sp is
    zapped
  KVM: x86: Get RIP from vCPU state when storing it to last_retry_eip
  KVM: x86: Store gpa as gpa_t, not unsigned long, when unprotecting for
    retry
  KVM: x86/mmu: Apply retry protection to "fast nTDP unprotect" path
  KVM: x86/mmu: Try "unprotect for retry" iff there are indirect SPs
  KVM: x86/mmu: Replace PFERR_NESTED_GUEST_PAGE with a more descriptive
    helper
  KVM: x86: Move EMULTYPE_ALLOW_RETRY_PF to x86_emulate_instruction()
  KVM: x86: Fold retry_instruction() into x86_emulate_instruction()
  KVM: x86/mmu: Don't try to unprotect an INVALID_GPA
  KVM: x86/mmu: Always walk guest PTEs with WRITE access when
    unprotecting
  KVM: x86/mmu: Move event re-injection unprotect+retry into common path
  KVM: x86: Remove manual pfn lookup when retrying #PF after failed
    emulation
  KVM: x86: Check EMULTYPE_WRITE_PF_TO_SP before unprotecting gfn
  KVM: x86: Apply retry protection to "unprotect on failure" path
  KVM: x86: Update retry protection fields when forcing retry on
    emulation failure
  KVM: x86: Rename
    reexecute_instruction()=>kvm_unprotect_and_retry_on_failure()
  KVM: x86/mmu: Subsume kvm_mmu_unprotect_page() into the and_retry()
    version
  KVM: x86/mmu: Detect if unprotect will do anything based on
    invalid_list

 arch/x86/include/asm/kvm_host.h |  16 ++-
 arch/x86/kvm/mmu/mmu.c          | 175 ++++++++++++++++++++++----------
 arch/x86/kvm/mmu/mmu_internal.h |   3 +
 arch/x86/kvm/mmu/mmutrace.h     |   1 +
 arch/x86/kvm/mmu/paging_tmpl.h  |   2 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
 arch/x86/kvm/vmx/vmx.c          |   5 +-
 arch/x86/kvm/x86.c              | 133 +++++++-----------------
 include/linux/kvm_host.h        |   7 ++
 virt/kvm/kvm_main.c             |   5 +-
 10 files changed, 184 insertions(+), 169 deletions(-)


base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.76.ge559c4bf1a-goog


