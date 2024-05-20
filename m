Return-Path: <linux-kernel+bounces-184031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A28CA1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44AA1F225AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3A4138493;
	Mon, 20 May 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfj/W0gA"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841D34CDE
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227975; cv=none; b=nIU4WwdhnOSQ7sziW0sIcQpXBbjozQ0Q5GKFTWhISvBkoEQJSL6Ps3gbrYXLoX8bIFpCrmGLruIEMKzPtOxkRFAS+YznF8Dn23r95XTTlBYxOeOVtZzAdQDPJ8xO+XFBSo/J43q5uL1aW+F6kTBuYDISoTKnvlb1IlC+lI8aAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227975; c=relaxed/simple;
	bh=AsxPKNARpXRNviMqudutLRYQTcU1bTFjcspQZ+x3v9s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tjbJbUg0S1m4wlUFO7hpeb4FvWYi9OHFYQqo/G01AcU8CX+TGOyEJqSzU0CYGI9P42iIDBFkdaNKDqMLb2DPNX326t9Km1ZzKRgjowRhezoqwAWQ6oFjmq22YUGKXKOIyQq825Ze0xJ3tkb8OLRjH2QRHWA4JM7O3EsGuJmXw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bfj/W0gA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so20437069276.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716227971; x=1716832771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GnZMYTDY7gkoXtRjM5gJMHXnymrbwpWeITINywdKFo=;
        b=bfj/W0gAM4PMl01L70cob+Ssz5Y7vKslv/8fSyJdtXXvwLdgCcwUnGiGwiU7ma4Jwp
         YYvu7ABhLCXUxTO9ayzLA9szHsm/iCLHG2lrMnGSw5IVaTFwx8ecZr1trYgDxmYJl1IE
         8H1z+i5LjJIniteaUIab1RJjzFaot0W3cg9Jw3H7TxigMyWcfd1Tcit4vkl9EIqREnh4
         Hqjr+u1RMsnsTHaDz3FfCCiocHEzqQu8gK8ddmddmIn5rUYjOr3ZD+oa6OQJvG/3+wyi
         ghP+GCo9+Sb7S6RtJy8Zl9Q7P1POPvNkOST0fmGGLKGgCielzVnHZXy1Ht0hsr22E2sS
         qahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716227971; x=1716832771;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GnZMYTDY7gkoXtRjM5gJMHXnymrbwpWeITINywdKFo=;
        b=pt/TCSN49Tq96EPkpNqmE/wVAc0H+H10YkEX0PiGMhj0cNElcnlQqKnxIhZzwtznTh
         z8f7z2Fo4EIwihEMJfRCFDRTeviRzeiBL5fIBp9dWnq7VUlF2c7ZzFYlW3adqh/c6kxY
         SBntSlmCprKB6dPlRFawWYnPChkAv8gkrJKXr2mfxjo0Frh/7fPOU3zLrhR7chNUT9Ee
         P4Yga7MXDuTWVAMDvlp3Yk5aENW0dOKqo+AF58uQ6qCLk6ETWAYwE47F+2fKuKNUMnx5
         WLBaRW6OexbvWc5Nk+vn/8Veuu3uY0UEGYoG1E3eXCwoXc2xv+iVE0STRQOYcTQRcxMn
         B+qA==
X-Forwarded-Encrypted: i=1; AJvYcCVsVXCAPsL11wWIhdhYTEb8czBBEyHza/jX4bOWsni/I165oMeJJVen8spLn58bw9QAftVhPLy0Goj+qX5mer61fdZ4hVnL03U0h3pZ
X-Gm-Message-State: AOJu0YwJDxV1Kdzjygj+Mqzizf0Igy4RFdciI9IHsWJ20nU5AeleIqDZ
	rLjpfVVqRtkNjm+gj9SE55Eg9kWC1xBmMynEOOA7yu0h8iJyA7Pa2AeJ857NnxBJG0Ph0FE7IA3
	kxQ==
X-Google-Smtp-Source: AGHT+IErAclYXPpBw712ginJqPQhQouGO1QEb7Y90m4CJpjie9HOnAm2zRjKLKULN5s7hIHJflLykiB4lW4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c3:b0:dee:7621:19d9 with SMTP id
 3f1490d57ef6-dee76211f20mr6997989276.13.1716227971692; Mon, 20 May 2024
 10:59:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 20 May 2024 10:59:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240520175925.1217334-1-seanjc@google.com>
Subject: [PATCH v7 00/10] x86/cpu: KVM: Clean up PAT and VMX macros
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

The primary goal of this series is to clean up the VMX MSR macros and their
usage in KVM.

The first half of the series touches memtype code that (obviously) impacts
areas well outside of KVM, in order to address several warts:

  (a) KVM is defining VMX specific macros for the architectural memtypes
  (b) the PAT and MTRR code define similar, yet different macros
  (c) that the PAT code not only has macros for the types (well, enums),
      it also has macros for encoding the entire PAT MSR that can be used
      by KVM.

The memtype changes aren't strictly required for the KVM-focused changes in
the second half of the series, but splitting this into two series would
generating a number of conflicts that would be cumbersome to resolve after
the fact.

I would like to take this through the KVM tree, as I don't expect the PAT/MTRR
code to see much change in the near future, and IIRC the original motiviation
of the VMX MSR cleanups was to prepare for KVM feature enabling (FRED maybe?).

Based on:

  git://git.kernel.org/pub/scm/virt/kvm/kvm.git queue

v7:
 - Collect reviews.
 - Fix an Author misattribution issue. [Xiaoyao]
 - Add vmx_basic_encode_vmcs_info() to avoid ending up with a mix of open-coded
   shift/masks and #defined shift/masks. [Xiaoyao]
 - Remove an "#undef PAT" that got left behind. [Kai]

v6:
 - https://lore.kernel.org/all/20240309012725.1409949-1-seanjc@google.com
 - Add all the PAT/memtype patches.
 - Split the VMX changes into more appropriately sized chunks.
 - Multiple minor modifications to make the macro mess more maintainable
   (and yes, I edited that sentence to use "modifications" specifically
   for alliteration purposes).

v5:
* https://lore.kernel.org/all/20240206182032.1596-1-xin3.li@intel.com
* Do not split VMX_BASIC bit definitions across multiple files (Kai
  Huang).
* Put some words to the changelog to justify changes around memory
  type macros (Kai Huang).
* Remove a leftover ';' (Kai Huang).

v4:
* Remove vmx_basic_vmcs_basic_cap() (Kai Huang).
* Add 2 macros VMX_BASIC_VMCS12_SIZE and VMX_BASIC_MEM_TYPE_WB to
  avoid keeping 2 their bit shift macros (Kai Huang).

v3:
* Simply save the full/raw value of MSR_IA32_VMX_BASIC in the global
  vmcs_config, and then use the helpers to extract info from it as
  needed (Sean Christopherson).
* Move all VMX_MISC related changes to the second patch (Kai Huang).
* Commonize memory type definitions used in the VMX files, as memory
  types are architectural.

v2:
* Don't add field shift macros unless it's really needed, extra layer
  of indirect makes it harder to read (Sean Christopherson).
* Add a static_assert() to ensure that VMX_BASIC_FEATURES_MASK doesn't
  overlap with VMX_BASIC_RESERVED_BITS (Sean Christopherson).
* read MSR_IA32_VMX_BASIC into an u64 rather than 2 u32 (Sean
  Christopherson).
* Add 2 new functions for extracting fields from VMX basic (Sean
  Christopherson).
* Drop the tools header update (Sean Christopherson).
* Move VMX basic field macros to arch/x86/include/asm/vmx.h.

Sean Christopherson (5):
  x86/cpu: KVM: Add common defines for architectural memory types (PAT,
    MTRRs, etc.)
  x86/cpu: KVM: Move macro to encode PAT value to common header
  KVM: x86: Stuff vCPU's PAT with default value at RESET, not creation
  KVM: nVMX: Add a helper to encode VMCS info in MSR_IA32_VMX_BASIC
  KVM VMX: Move MSR_IA32_VMX_MISC bit defines to asm/vmx.h

Xin Li (5):
  KVM: VMX: Move MSR_IA32_VMX_BASIC bit defines to asm/vmx.h
  KVM: VMX: Track CPU's MSR_IA32_VMX_BASIC as a single 64-bit value
  KVM: nVMX: Use macros and #defines in vmx_restore_vmx_basic()
  KVM: VMX: Open code VMX preemption timer rate mask in its accessor
  KVM: nVMX: Use macros and #defines in vmx_restore_vmx_misc()

 arch/x86/include/asm/msr-index.h | 34 ++++++++++--------
 arch/x86/include/asm/vmx.h       | 40 +++++++++++++++------
 arch/x86/kernel/cpu/mtrr/mtrr.c  |  6 ++++
 arch/x86/kvm/vmx/capabilities.h  | 10 +++---
 arch/x86/kvm/vmx/nested.c        | 62 +++++++++++++++++++++-----------
 arch/x86/kvm/vmx/nested.h        |  2 +-
 arch/x86/kvm/vmx/vmx.c           | 30 ++++++++--------
 arch/x86/kvm/x86.c               |  4 +--
 arch/x86/kvm/x86.h               |  3 +-
 arch/x86/mm/pat/memtype.c        | 36 ++++++-------------
 10 files changed, 132 insertions(+), 95 deletions(-)


base-commit: 4aad0b1893a141f114ba40ed509066f3c9bc24b0
-- 
2.45.0.215.g3402c0e53f-goog


