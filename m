Return-Path: <linux-kernel+bounces-530321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B6FA43207
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD8717B946
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C618DD299;
	Tue, 25 Feb 2025 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1pOb+ZR"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B84C76
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444440; cv=none; b=Enk8Jql+ci5T0aRkhQG7qVyvn/H3oM8zZRwWCjmnSTm5xwOsajo8HJ3eD+Do+nPicEQlix5oe3C1YlEfKjDSduoKeHsO66lnhsrRfID7lT1Nd7MAfx2Q8xWURI+47nzmJ/2i/RZpXsojKD3nLvgfJyCifrO7o9cp2prr0OKWwOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444440; c=relaxed/simple;
	bh=Bti+4WFdsQWdwawsSlCRg6Upf2HmU0CDyT4BY606188=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i8RVpdwYXtdgCe+EJUvNq3r15TgNBrKQIaQxncnPwtte6VfgK2FV9JwhBm6ct92L9ifXYwgCNu/+G/GMLODUG8p7JtegDOOhPAJpV51dBSbs/ZAs1UQbuP5mXsqlBLtquHvksWbLndFm1VElnOzbDoXSDET/i6D83CFypikXodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1pOb+ZR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1eadf5a8so10845765a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740444438; x=1741049238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I5KMzQoVShSgVrtM4DxTTsmM2BWrfSX+7bpV0asZP4o=;
        b=V1pOb+ZR+ushTuoOIFzQESPElcQZ0thDGREmZCxKZhK61LIlYknPC/5hRr+jXxdNiH
         OQTiBl6Vu7M5z6hZLLTGVMPxJPEuH+wIS2rEgemwi6WYY4qDv0LAPSR/96ms9QObWE6P
         zmj8XtrxNNJrALlT5dIkbeyRUozAN2cyITSw94hLPBT1CkZHMznTUPhNpq+4xzoDILEj
         VEyXtwccq3w/i3jxhq5MMqd0i0LU7fpOv/BQ3fyaMXB5/wpF9PImnjx2TTSUCKEF8JLk
         Qs312AMNh/B6OdR8cMf2gnGojm/7d7gM4qtnJcm+kGDPmfZMRPUJ54k2+brF0yn/6DLl
         YESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740444438; x=1741049238;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5KMzQoVShSgVrtM4DxTTsmM2BWrfSX+7bpV0asZP4o=;
        b=QzcNdLQx7CDJB5475xhq3UKXUoHIvzGI8BSM9Z1ptFl/gYckCZgg3JfxVVmascKnzI
         RlmfBYKBlLfvBqt1+q8BQDRoypMJHMBcNc+kHs6Qsn+TgR1WJ4eORKtRkia6OVVRb2vw
         m3XXgpECFA1gsP7+vO0IfteEhbsbHDaTYPflee1yP2yDPoob3u1M8dkp9jCKFT0kdmGL
         v35dgVsifqCmnOpgzqZB2H10drQoA5BfTlMAXO1IRO0eNCiaS9Lzq4IYXukChe97rp8T
         4osygVVoUEucpjFknm2sp+9RxWnvaY7siGo/5MBSURU3k6z56oQCqALp9v2EhzoEmvVY
         hNUA==
X-Forwarded-Encrypted: i=1; AJvYcCUrqgyP+IvySPDInSWbQxo+CmGpqS6ZyNOV3tdZrJVcb9U1iiBGgSv2lTPlP2CGTkuz/rRKawETDNe87a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGj/cK5pXWUc9ktERPxHw+buLNwb2OKuRLMb+LUo/rwab+qq6A
	2kiFpcgKf2Qg7Ujlbs+8BYWGxVANoNfwkTo8K8rpffeN7aJIIp33NAtK8Y4FUdDvsmYyKrjEuZL
	kyZzX7UWuMek7FCOglw==
X-Google-Smtp-Source: AGHT+IHpAVDfWrqEo9rKctpl0ggmR96y2poe6zx51fhSxaTxTg/nRaaD77F/bbkyc7Y8iGsQ0zvHJqrkdR2Dr46s
X-Received: from pfbfa9.prod.google.com ([2002:a05:6a00:2d09:b0:730:8566:41dd])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9215:b0:1ee:7c7d:e66a with SMTP id adf61e73a8af0-1eef3ca2d1amr25377522637.23.1740444437979;
 Mon, 24 Feb 2025 16:47:17 -0800 (PST)
Date: Tue, 25 Feb 2025 00:47:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225004704.603652-1-vannapurve@google.com>
Subject: [PATCH v6 0/3] x86/tdx: Fix HLT logic execution for TDX VMs
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

Changes since v5:
1) Addressed Dave's comments.
2) Dropped the cleanup patch for now, it can be discussed separately.

v5: https://lore.kernel.org/lkml/20250220211628.1832258-1-vannapurve@google.com/

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
 arch/x86/include/asm/tdx.h            |  2 +-
 arch/x86/kernel/paravirt.c            | 14 ++++++----
 arch/x86/kernel/process.c             |  2 +-
 8 files changed, 77 insertions(+), 39 deletions(-)

-- 
2.48.1.658.g4767266eb4-goog


