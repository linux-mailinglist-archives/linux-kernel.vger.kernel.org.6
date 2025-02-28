Return-Path: <linux-kernel+bounces-537608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA5A48E15
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1631216C055
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF07F4502A;
	Fri, 28 Feb 2025 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNPHmsEw"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BA3596A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707063; cv=none; b=MZAqYqkbPDwxFuBY5q6qJQAIT16xDCZJdMKc+bSHckZ1DndN63VluJyv3S9sLeY04+LlVwmlQuqnuWGNWG7Ay4I5n0o87mXDAVV5H224qkU0IFQqKLvr1v5HsTdePmImlHtCC1epGG91FWw4wIVI/pS3WAZH9XInVfzXE7lM3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707063; c=relaxed/simple;
	bh=a+hhsISpwSOV3NLgMMWxmhkEHZcRYIqr8+kcQE1b/fo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Scv9u2wYKoN7B3M+sGe8V2yE0AfFvAjlAZFNS7hGC+jpu7RAAOhIqDYxy7zHiU4tvaGtJZOinbjGLj28LfBllia1lxMbKl9/rbaSezJdngew3YB6q33QDzIJYxzSHxRRBa9qmMHqOBGVIgRyac7QYtwF6/hmI3yKM7Ur9xaEa0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNPHmsEw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22367f4e9b9so8364055ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740707061; x=1741311861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FqF8Q8XFXYncfUenWuJBDSsEIDlyEuKebDS/PZCwdMY=;
        b=rNPHmsEwTBZWTvr74VAaKAc1GYnnLOjfnTCZX3LHNYS5keBIy2uiWEilZnHR5bVVcR
         VyVRP0po4sH9ntczANtwGU0E1yjBMMUx2LEEsJxjlFeR4qHt480uuw1eLk0u6vjkEahl
         shDJEn7A5Ni69f4H1hVnXQ+sIpJb2wxsrjwqMCCOBANLoZkCASNCC/45qBl+ZLliPQfp
         o7m0C1i3RZNHWq1qcCcYKhb4hoRVH2MzX6jAW300l6aZsATL4p2t0XXe4F2V7ZbAtvyo
         K0uH7SlMCMDbXeIvSaQMbL2cmivvona0EQ6EyglUUZNWyjxoMPLnX4PpTASNX6lGoLzR
         HmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740707061; x=1741311861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqF8Q8XFXYncfUenWuJBDSsEIDlyEuKebDS/PZCwdMY=;
        b=s5FlBRYV8ZUbnQoMNUR0AsjLFpRDejiQPkLDmGyHDiJdgembRyjxobQ70ztVUO4bWr
         Ky14wGSV4m9uJjYhAm6phORMiXDqzSdj3LQKUE12ogBYfCHgEqC+IRuD7B6vf0ivGLPD
         5dt6e++thOmixBAO33npTY0Y1RwaJjuKTpTRfHQf64DBTt9HR/VryelGGoDDTSsQbKSo
         Kmb7mEWT0R+0LQUQYudLd21XvI8Hz16hxqBfw2ZWyzn2sufxEF8+80YTB4eDl5sfKhEG
         BTUEicCFNfM0AUp0oko1b4b3/rIoLtRzNCt4VSutUaEoGHESFIVVQcm9Tp0qzz/FbFdL
         QPsw==
X-Forwarded-Encrypted: i=1; AJvYcCViUvq533QkrCkqjJypGI9LjR41avRIG42tznCsQv2ZR9zpSpHuoG2vkn783RH3p2c+43K+DwzSzV0WYCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQj6Sj27Y+yLroD0JVtTpV3FfMNdyq1yeoQXNtjJtBvR/HFpI
	KE5DyUZDUm93pconwNnoFMiytVwPV3rn+D41vjDLrx/CldIh80+S1m4PQa0nVmX/QVZTB9aWh/7
	ZWyYI1aXWHQLzjCEUqQ==
X-Google-Smtp-Source: AGHT+IHq3/FYvnhcHmzR3dKBMJGYwE2w4qWoTkMltxQfzf+L6EUDYcTCBM+hlhmazTHObSb1r5X3Jip2Rwz7uXpy
X-Received: from plble4.prod.google.com ([2002:a17:902:fb04:b0:216:25a2:2ecf])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:298f:b0:21f:3e2d:7d2e with SMTP id d9443c01a7336-22368fbc80emr20133165ad.27.1740707061150;
 Thu, 27 Feb 2025 17:44:21 -0800 (PST)
Date: Fri, 28 Feb 2025 01:44:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228014416.3925664-1-vannapurve@google.com>
Subject: [PATCH v7 0/3] x86/tdx: Fix HLT logic execution for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	pbonzini@redhat.com, seanjc@google.com, kai.huang@intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, 
	afranji@google.com, kees@kernel.org, jikos@kernel.org, peterz@infradead.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events. As per current TDX spec, HLT
#VE handler doesn't have access to interruptibility state to selectively
enable interrupts, it ends up enabling interrupts during #VE handling
before the TDCALL is executed.
 
Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
effectively solved this issue for idle routines by defining TDX specific
idle routine which directly invokes TDCALL while keeping interrupts
disabled, but missed handling arch_safe_halt(). This series intends to fix
arch_safe_halt() execution for TDX VMs.

Changes introduced by the series include:
- Move *halt() variants outside CONFIG_PARAVIRT_XXL and under
  CONFIG_PARAVIRT [1].
- Add explicit dependency on CONFIG_PARAVIRT for TDX VMs.
- Route "sti; hlt" sequences via tdx_safe_halt() for reliability.
- Route "hlt" sequences via tdx_halt() to avoid unnecessary #VEs.
- Warn and fail emulation if HLT #VE emulation executes with interrupts
  enabled.

Changes since v6:
1) Addressed Kirills's comments.
2) Fixed a build failure.

v6: https://lore.kernel.org/lkml/20250225004704.603652-1-vannapurve@google.com/
 
Kirill A. Shutemov (1):
  x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT

Vishal Annapurve (2):
  x86/tdx: Fix arch_safe_halt() execution for TDX VMs
  x86/tdx: Emit warning if IRQs are enabled during HLT #VE handling

 arch/x86/Kconfig                      |  1 +
 arch/x86/coco/tdx/tdx.c               | 34 ++++++++++++++++++++++-
 arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 +++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/include/asm/tdx.h            |  4 +--
 arch/x86/kernel/paravirt.c            | 14 ++++++----
 arch/x86/kernel/process.c             |  2 +-
 8 files changed, 78 insertions(+), 40 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog


