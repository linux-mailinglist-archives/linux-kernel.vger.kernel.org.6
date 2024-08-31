Return-Path: <linux-kernel+bounces-309588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7D5966D35
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA08B284C61
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F15A4C74;
	Sat, 31 Aug 2024 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEpBGVw6"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52558184F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063342; cv=none; b=Lr42h+gv5sohbDkFs368DHsXEJnh7XV8QvO7SgBnrtscaGB0TdiRL8xwrBNc6tEEkB10IA7RTH0Qf1Gh1qSQn0kks4T3auN880XBcLez9XWwmKEfg/jLhlFMi7ocGFq4KyB8ig/SPWkNt4z+50DBP5bHzc0aBYLvMq0L1OwPfbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063342; c=relaxed/simple;
	bh=KuZ0OoLpHGEBrE1b1ZW5sIbzye+2VwcQFnPIkPLV4f4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CmhoxuDJ35EKgGgKs97uYsGh5RUs4pvTXoisQFBiaYL6CE+pe8sOMIf2eL1U+DD5UU2Yt9Ikf97EPzTVR0A42KDVpwzbnBRRXFkCKzSMn9KQR4akrjscUWaau1oMEEu91TQRIxtS0sqJXSrVnhJQD2wTmao915H1kRhIe82SKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEpBGVw6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-714290c2b34so2321021b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063341; x=1725668141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTFtS87rRNga7epLMEfljyowaniVQp7YdYYjP/4rKoU=;
        b=WEpBGVw6IuaXCqG+tS7RNI8IxP08g4wTUH2cD25eB8xzLoJ8fqPr3CboV93HSA+CI0
         6bzXupXs9VUJNdWEGbxLVahEJudmT83k120kFyuYBFiHPs9/OmyB7WZB8IdDrInSTeys
         mEt6HMYahq8pvJWy6YdrmIH4zCdT/uPLVqPrr17DP8Ta9Wxwg1MhG8xbX7zwWwHwi5A9
         6tJcWmW8wu0v5J1jj1zibIEhMu4EhAz7nPNz60wbggy44W/JGhlBXhNNp7ZtcLhmPuGZ
         e6AvSVZX4wrtaOZtkHwyVianWRX/GvR0cMK1yo1homYBeN803Mq5y1Krk2ZdiuuMjZQG
         kPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063341; x=1725668141;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTFtS87rRNga7epLMEfljyowaniVQp7YdYYjP/4rKoU=;
        b=PyJFRbbGxJgH6pTV5j9Ab81fSRO57XO7T2SB2re6KyqXgfCzNNETOfF6+7CLLa6TWE
         wPHYH5AbyaK4gDFY5JFrf24NHMUOFYAQNrHr83vklBn4D+WvcdwlT1y3YQFQ7luEGoMO
         N34tkecsYt+te3SMOSM/awky1gvR1l4qy+Bi3Lp64vvsFBnEYO+aweQz1DI5P9G3xndR
         MFKk/DtCY1j7Ii0TKWmDTtzYzrKQQOzV1khP2U4jEbAPs0wG8DLBamkki6wdKG7Ji/WU
         KzQzCmr6xnBnHDTiAw3D0WKPayWv19ERz79j4Y2nWXJK9tfYwHXGoollaCXs4LOa1r9d
         awCw==
X-Forwarded-Encrypted: i=1; AJvYcCUMA68+I9/QREJ/AjwKuy/tpbTCptP39u2EpWVSBUmeNT6eKlNQdGpIVqak4bazsDmoJeuRpx+fJQUL9eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1Z7A05fAfA2gFBrX6JibyiA2PEvGUT6696PmfTZEYwcWPndZ
	pFV70OxazbA4ykWkh9lq796BVOZEaIxQy0gpESaZWjXIoBxpSBjVY+McfJYxNOU6mjv0IaHozLL
	CIA==
X-Google-Smtp-Source: AGHT+IHatimWdzRYXvUKQfJLlDc85fVrVzYWQP70nBC338iYJOdi5vN66dK+0pDXHS/TtafnsiqigY81dTc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9152:b0:714:378b:c7c5 with SMTP id
 d2e1a72fcca58-716f2091e9fmr18050b3a.0.1725063340488; Fri, 30 Aug 2024
 17:15:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 17:15:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831001538.336683-1-seanjc@google.com>
Subject: [PATCH v2 00/22] KVM: x86: Fix multiple #PF RO infinite loop bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix an amusing number of minor bugs that can lead to KVM putting the guest into
an infinite "retry #PF" loop, and cleanup and consolidate the unprotect+retry
paths (there are four-ish).

As a bonus, adding RET_PF_WRITE_PROTECTED obviates the need for
kvm_lookup_pfn()[*].

[*] https://lore.kernel.org/all/63c41e25-2523-4397-96b4-557394281443@redhat.com

v2:
 - Gather reviews.
 - Rewrite the comment for the nested NPT "fast" unprotect path to explain what
   it actually handles. [Yuan]
 - Drop Cc: stable for the remaining patches, as it's extremely unlikely these
   fixes would actually prevent a guest from dying. [Paolo]
 - Move the patch to replace PFERR_NESTED_GUEST_PAGE much earlier. [Paolo]
 - Wrap indirect_shadow_pages with READ_ONCE(). [Paolo]
 - Massage a few changelogs to (hopefully) fix weird wordings. [Paolo]
 - Always refer directly to last_retry_{addr,eip} in comments, instead of
   indirectly referencing them as "infinite loop protection". [Paolo]
 - WARN if write-protection hits the MMIO cache. [Yuan]

v1: https://lore.kernel.org/all/20240809190319.1710470-1-seanjc@google.com

Sean Christopherson (22):
  KVM: VMX: Set PFERR_GUEST_{FINAL,PAGE}_MASK if and only if the GVA is
    valid
  KVM: x86/mmu: Replace PFERR_NESTED_GUEST_PAGE with a more descriptive
    helper
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
  KVM: x86/mmu: WARN on MMIO cache hit when emulating write-protected
    gfn

 arch/x86/include/asm/kvm_host.h |  14 ++-
 arch/x86/kvm/mmu/mmu.c          | 200 +++++++++++++++++++++++---------
 arch/x86/kvm/mmu/mmu_internal.h |   3 +
 arch/x86/kvm/mmu/mmutrace.h     |   1 +
 arch/x86/kvm/mmu/paging_tmpl.h  |   2 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
 arch/x86/kvm/vmx/vmx.c          |   5 +-
 arch/x86/kvm/x86.c              | 133 ++++++---------------
 8 files changed, 198 insertions(+), 166 deletions(-)


base-commit: a1206bc992c3cd3f758a9b46117dfc7e59e8c10f
-- 
2.46.0.469.g59c65b2a67-goog


