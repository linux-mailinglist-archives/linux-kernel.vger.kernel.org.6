Return-Path: <linux-kernel+bounces-562386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC0DA62521
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696D23BA48F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0619CC3A;
	Sat, 15 Mar 2025 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1dv00/Uc"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794C199E8D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008004; cv=none; b=RSaBQkhcJE+20+2VFsC+PSwImGOLGtRbMwCXJ1jEf4zf9CgC/7VAZYIRLFk8lVZNC353kna9fF3lJpm7q55ivsqqVP5AlQg9QASJUWnaNQrp0vIBGsXTm7XNQmcuxOvxfSCZ+kkhWVn1uur1212Xhe2CFvzwM7mxqAcJN0i353k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008004; c=relaxed/simple;
	bh=DIDA37JL8eeKhWGYjcN5PxZYRrpmJV0kRjJacIWUfhQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ri8tFKuWTKx7vP9js73kOTfmsX4XC93OrmqLMu4cs7+9ut5kPPbXxBjHScOXk9wHG7ynQdNt/3JCiSbi1M+pAalHkva+h7VhHwU9QHlsls5pzLcc7dyV2UtdtY5o6GprPI3v+Amfc2Kv3T3scmsI6OLxzz3FM1GQsNIQLdXjZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1dv00/Uc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff68033070so473344a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742008002; x=1742612802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hv39/O/PnMVFihpfgZT9SpR99lFAgaV130aLFM9qjm4=;
        b=1dv00/UcK4oER/YLiOMaxFVrKEWirmRovwQWwX6yItUbKsCfoh7wT1wHH0k4wITgBC
         Q6Ad4AnqU8nJ1xIQevzuGzQPCrCNeX2URXUpPBUAhxbcMWgpvmhMGNWL+g0rVIrXDA/Y
         Qc7/pDe+k2f4vAd485redXeir59iSCOD32B/ZIgtrIhn12koiU2VyMqZFD1YD+SUjLy0
         dB6Ua0QKW1juHyHTktBsqcg/ChpXS6LYe0CmX5YG5z1oK66ZE1CIVetlExdo47Y2gU5q
         U7sc03bYLwFU6qjIDpp5Ga4Tu1xJBgoemKAdxVfWx3kG8zjK8892umX+6JJZ/M0yMZUi
         ACqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742008002; x=1742612802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hv39/O/PnMVFihpfgZT9SpR99lFAgaV130aLFM9qjm4=;
        b=q/5iMvwJwFrzU2RtNlLwuaLOkljb0Z7WIW+jermJ6TPwVCwct1J15+FzxPL3ReIvBp
         nFjD4I6+ohzc3dSuQnpB2xIvlynV7a4DHZq+idvk3GbAHXdR42jYG+XxuRAkak4cyNOA
         +Uj9i4JoWgS7lJO+Fq7sCmQLfCizmb2bmXK2aEa/1f00/jrBlI/1LCqhEbHgByq5YMzz
         DNBhUOGfwYCk+KYJilwwpsUQ45DFXFTIbtFSVS3JZeJZleZXqgjcXXvQdr0CHqpkSuqi
         DQWlkFtaWyu2VuTxD57CqalPoMvEqhnj9YHB3QCjqwyKOZBeIdHr5DKZY8bJ57Qh3L6w
         saCQ==
X-Gm-Message-State: AOJu0YxdOc47B1VTNYO/LtgTvcd4Jrjw8D6Jo4SygmJ8ZETEEn7FcfLj
	dhC1aJ5fiRgTMeyIw0iwwlIxDYmxTdLgs5/va7IGviQdqZcHOAQMANEgTJWnB8BL0ZP7yXV3zcj
	3MQ==
X-Google-Smtp-Source: AGHT+IHWjt/BJeVYOLv32GnaoqzmTC0s6P3U8PoNtZJT15p0guIAJtE+fq85gGZBlDG7yQuICOSFHSPkotI=
X-Received: from pjbph6.prod.google.com ([2002:a17:90b:3bc6:b0:2fc:11a0:c549])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:514e:b0:2fa:157e:c78e
 with SMTP id 98e67ed59e1d1-30151cab344mr6435643a91.7.1742008002348; Fri, 14
 Mar 2025 20:06:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 20:06:27 -0700
In-Reply-To: <20250315030630.2371712-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250315030630.2371712-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315030630.2371712-7-seanjc@google.com>
Subject: [PATCH 6/8] KVM: VMX: Isolate pure loads from atomic XCHG when
 processing PIR
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework KVM's processing of the PIR to use the same algorithm as posted
MSIs, i.e. to do READ(x4) => XCHG(x4) instead of (READ+XCHG)(x4).  Given
KVM's long-standing, sub-optimal use of 32-bit accesses to the PIR, it's
safe to say far more thought and investigation was put into handling the
PIR for posted MSIs, i.e. there's no reason to assume KVM's existing
logic is meaningful, let alone superior.

Matching the processing done by posted MSIs will also allow deduplicating
the code between KVM and posted MSIs.

See the comment for handle_pending_pir() added by commit 1b03d82ba15e
("x86/irq: Install posted MSI notification handler") for details on
why isolating loads from XCHG is desirable.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e4f182ee9340..d7e36faffc72 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -659,6 +659,7 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 {
 	unsigned long pir_vals[NR_PIR_WORDS];
 	u32 *__pir = (void *)pir_vals;
+	bool found_irq = false;
 	u32 i, vec;
 	u32 irr_val, prev_irr_val;
 	int max_updated_irr;
@@ -668,6 +669,14 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 
 	for (i = 0; i < NR_PIR_WORDS; i++) {
 		pir_vals[i] = READ_ONCE(pir[i]);
+		if (pir_vals[i])
+			found_irq = true;
+	}
+
+	if (!found_irq)
+		return false;
+
+	for (i = 0; i < NR_PIR_WORDS; i++) {
 		if (!pir_vals[i])
 			continue;
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


