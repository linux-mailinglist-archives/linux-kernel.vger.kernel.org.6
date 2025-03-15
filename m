Return-Path: <linux-kernel+bounces-562380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB137A62516
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D366189FB2D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37D218C93C;
	Sat, 15 Mar 2025 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lu/1AfyR"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD917BED0
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007994; cv=none; b=TVnXbZrMlkVStfh1FqgxwCbb0+mblHICQY7aibdRBglURabcmL+f01W010FB9xC6/JQQqzdSpowqopiDR3ZU00Z+vGRexZachTII4I2qdEN6eARvOPrvjGqxOO+wpAlOu3soyuuES3cUOwOPXkvybLxL956Hx+NvzPeZNh7nylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007994; c=relaxed/simple;
	bh=YFjSxhw5wICpqlhn2+SBT+UI7aYyjrHGuxj/z7Cm2Sw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b0YpQulG1CO9ZscPx0Ww4+1dbNLRzQI/Ld5SV6bzsnMUTjBQkJp9wNOamHDUktBzwOkhrr1usw4IP5RA5R4PKYtznO3vh1ZztRI+xK7pmEsTlmIzSeL9EpzMtwJ8hU14iY+DW2OAfpeMnYrLsmaepmD6vgcbedQrObSTOvsEd8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lu/1AfyR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240c997059so59545495ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742007992; x=1742612792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2ZX01PI6Yqklh+FBYpkhlAmh91WriSaacZw2NWi3Oc=;
        b=lu/1AfyRbd5V+74YK/HJHe9W5c1Vg8AHYyvmHz+oR/WOn6fYgGh7vCSfdniB8RHV19
         wvDophw8uBUpeQdxIB1jt705oW/pidqcxHTtfhvz+o704GBOAhUx2txSrDW6T++yiIx3
         3KuNNPSbmgyusIMVqd4J/RpXPnIGUY0wwK7OMXpZo8TULBJFtxcsTYZAHvxjiKurjiyC
         NzFQYMZ5YIO6GQ/dw9XZo2bD2ZJIQ2HkE1HVn+JEGQUVYQ032Qt/iDfPwdIBIwlxW/dt
         1Qv5Vxb3Kku6vWFIYe0NmzyIn1Xa3O8CzogH1jNZrkR7mDahL2RxcSsnAhHKcE0Ftmmp
         DpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742007992; x=1742612792;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2ZX01PI6Yqklh+FBYpkhlAmh91WriSaacZw2NWi3Oc=;
        b=m19IPoNk+cZqFpamA3xylXiLEL48psd6zXUslaS9myXGFzrsS40BFh0VLq7Nc/84rR
         4EpD7ACDroZ7dYbGGvL8glqXJIsJpHKulGevMA1a4NGdmKg6aMdhNS1u5u5xsxPjkf/X
         l/XkjuXKbCviOseYzWAk40ixATrswmW1v0FkILBzFf6X3WczD4j4jOnOAlyQD1Vadkm8
         unfOIJ3PG++LScz1fcT/R159LB5NUu/H05jTSvIv6/ACUstd+8vSO7rZhpeDKykj0/xk
         06AnJfWPy9o6zIpECrIYnu1LSYtoIRf0JL/IbmqafBOB/Q5vEZRZurGMyHGYu/iZBtJO
         R/og==
X-Gm-Message-State: AOJu0Yxw3D7aGdW0bPipFt7HaLJ1D0auxMMp5zbE0F9KcBAokuBuvFPl
	EZ5CkRbNRIWvE4Z9BIUbNnMXqtSsq5yX5Pul23SUNrGR2cUJK7WD+GR16MrkjpXdstceqtCcLN2
	ptg==
X-Google-Smtp-Source: AGHT+IHL2LYaXR50kWQxDhmTJ+tOm7KlWU3qKMdLw3ptqdSgC3BqQWsYyFqF2SrHhElRbe2bRC4mBlr8l50=
X-Received: from pfbfv4.prod.google.com ([2002:a05:6a00:6184:b0:730:96d1:c213])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b95:b0:736:3c2b:c38e
 with SMTP id d2e1a72fcca58-7372235aca9mr5294705b3a.13.1742007992145; Fri, 14
 Mar 2025 20:06:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 20:06:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315030630.2371712-1-seanjc@google.com>
Subject: [PATCH 0/8] x86/irq: KVM: Optimize KVM's PIR harvesting
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Optimizing KVM's PIR harvesting using the same techniques as posted MSIs,
most notably to use 8-byte accesses on 64-bit kernels (/facepalm).

Fix a few warts along the way, and finish up by adding a helper to dedup
the PIR harvesting code between KVM and posted MSIs.

Sean Christopherson (8):
  x86/irq: Ensure initial PIR loads are performed exactly once
  x86/irq: Track if IRQ was found in PIR during initial loop (to load
    PIR vals)
  KVM: VMX: Ensure vIRR isn't reloaded at odd times when sync'ing PIR
  x86/irq: KVM: Track PIR bitmap as an "unsigned long" array
  KVM: VMX: Process PIR using 64-bit accesses on 64-bit kernels
  KVM: VMX: Isolate pure loads from atomic XCHG when processing PIR
  KVM: VMX: Use arch_xchg() when processing PIR to avoid instrumentation
  x86/irq: KVM: Add helper for harvesting PIR to deduplicate KVM and
    posted MSIs

 arch/x86/include/asm/posted_intr.h | 79 +++++++++++++++++++++++++++---
 arch/x86/kernel/irq.c              | 63 ++++--------------------
 arch/x86/kvm/lapic.c               | 20 ++++----
 arch/x86/kvm/lapic.h               |  4 +-
 arch/x86/kvm/vmx/posted_intr.h     |  2 +-
 5 files changed, 96 insertions(+), 72 deletions(-)


base-commit: c9ea48bb6ee6b28bbc956c1e8af98044618fed5e
-- 
2.49.0.rc1.451.g8f38331e32-goog


