Return-Path: <linux-kernel+bounces-203392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7DA8FDA3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B022A1F2514A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B51667F6;
	Wed,  5 Jun 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9RrZyN1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490315FA6E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629564; cv=none; b=Iitnfj+HUtzI1J1U6Vg5WMSYBUvVPSNQf1KJR2FyFPpQLEAeB67bn1hmk0o4rqAvJNFKWhq7azM0j5matrm2HuRSLBHl2KOSqwg4d5+YB0A3Ghpddh99TMZ24hs/Uy92FlRHNqnyRaALI0AmyIyybA4eQuEdGepZPdcLTgENme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629564; c=relaxed/simple;
	bh=bPYpKaFffVT7czraRt/cDjH6Nr8d+yMIXoAp76YawnI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sHXddQGn9m46EHTNu8JzD/S/uY2tojhJC19U6CU/b3EllgYYFDU7XymMOqzD6gwLodu+mEGuWSzXLSXrETqoRCwHKWN8jZooED0AEfXxvljdMkT0LtE3XDEh5S3jibwyvJQgVgHDBtu0XpMmRy1TN3t+W4TT0qMgPck82TpAMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9RrZyN1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a1e9807c0so3939677b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717629562; x=1718234362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hI7a+TyPUatLlBqya9hLDCAQBrkIObBfpV8d3FDL4ek=;
        b=c9RrZyN1hItO/rOqh/IOH/V25NUi3P3XLrsPIupk5t009sr0UJB88ekNYW2YQT+1GR
         K+fOe2wb7exwgSk07n93VzqZHCinfcP8L9n7/o1JNx1ukptqwaes5FhDNe9GTK/Wa+Zq
         zDsIoUvXyOFHlDDYcFNZyBAeg5HSOYEZRU1Z2FGTnR0EqPv6+uAwEt/y+Bx6N4UhecCo
         EtbXooikuns1R8sBz3EMNLss3uA5ZmYhhzxaJOIfRDVYkzTA5e5JuU6R0jqvuoyxmAB6
         N+LOaWBXkGLtriUDghrXv4c09Dc6kPQOFAmT2lEFlWhGHx1Uk1fpa/zR43V/8nd6uMMR
         4zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717629562; x=1718234362;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hI7a+TyPUatLlBqya9hLDCAQBrkIObBfpV8d3FDL4ek=;
        b=iob0bVmrrkLNLkx+Xk2lwaajgmewwaAGSHjUR8QTM9Nq6DBm8/Ut92+K5osRlTtWxV
         fdd3UIHqlczPoCBTVv76rraenNil/aPbLVX8uSFCW85GTicqxW9xe8cpWPUP76qgy3Po
         9GFkGQudI7x93pF/UAZzF/QOiInXfaMPor4/Iy7AcdmhExI028aPI9tvpRJvZA+PxG2n
         tEVMBMP8DMiQmPM9k9cMfom/el7fj2n4tfe3+Z8DMxeLgaf2VbMvQQ0OJikg6JSQfV2n
         Tzz0SSmqEqpr4pp9XfSxRHPywpnOuQ5fx7k7BFC9DLR0XNN+7dyqdWXSQDmuu6mLsyPG
         5hWA==
X-Gm-Message-State: AOJu0Yw7KAvOGO4jk+wLhJQkSoXXjJwNUqpPp7rFEX8F4nqquyxO0uzp
	YGZPT9/SCyMXL1b/lPzIaod8yjfaNK48/+n0CpQMDM8f56FhF4Bo1zQzAJ1RxK3qx2U6WfuhWsm
	x8A==
X-Google-Smtp-Source: AGHT+IFo05Hsu0bhH6GHB6K49InVKQvcRCX8vVk+2uKwLe/Cco1GZvM1/9WzUfOV4FHMu2bPNVtzCr8y6Fo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:dcf:b0:61b:e53e:c7ae with SMTP id
 00721157ae682-62cc709c399mr2965957b3.2.1717629562002; Wed, 05 Jun 2024
 16:19:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  5 Jun 2024 16:19:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605231918.2915961-1-seanjc@google.com>
Subject: [PATCH v8 00/10] x86/cpu: KVM: Clean up PAT and VMX macros
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Jim Mattson <jmattson@google.com>, Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>
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

  https://github.com/kvm-x86/linux next

v8:
 - Collect more reviews.
 - Call out opportunistic change in patch 4. [Xiaoyao]
 - Hopefully actually Cc the x86 maintainers to get Acks on the PAT changes.

v7:
 - https://lore.kernel.org/all/20240520175925.1217334-1-seanjc@google.com
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


base-commit: af0903ab52ee6d6f0f63af67fa73d5eb00f79b9a
-- 
2.45.1.467.gbab1589fc0-goog


