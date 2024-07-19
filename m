Return-Path: <linux-kernel+bounces-257726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08AB937E26
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCA0281EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F8149C74;
	Fri, 19 Jul 2024 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoI3Ey6G"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53A1494D7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433074; cv=none; b=IuEs0/gLO4t1lVF5hBGTGUhlN4Ef8tSXYQKw1wpSf1nY7vAVGLnMo8zL9ikYH1v4PKDEthaN+as9ifB23r7AAOG0I+0qCbZu+V9slggaTJsuxPv9tQ1iBgVU3bkk2hT9NA2qvm/LgywX3Et36uTC3r1f1705SlMPc9OryZhpq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433074; c=relaxed/simple;
	bh=Z1cH1V9K2pPOjjICaFF7xPr76fow0RyXynIXQuiRywA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g8+SnH4G3ovzGrxi4SsEPWDsPsxUDx1uHZ3vdO6UJMDVJ2foZUYM7fbIMHeB4DN9g7XRt0r0Ywcuk+Iefb5M18IUe9f81iDt8vgdfjN/fOHPJXMgB1URm/SWDyTmNrkgujhribkh9PeS22w2MUU1UbvMZXHGNvRxT7iohk+M5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoI3Ey6G; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-778702b9f8fso1648491a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433073; x=1722037873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RdVO46PMlcBgI+ne7j7UwSAA4lN1OIh/NoMWcCiQ7DM=;
        b=OoI3Ey6GTgrYVKbH5Dz1xQw/VxYVlAZlUJSuCfbXBYjp4p0lHZj37PYNPQOBrsJoTK
         0CZueGELn7K2s9ongLOoh3i5vJ1vPREDEXwtfaSV9kSL1wBf+T5IPgvsqzG4HvoWuPPL
         GU2FgT41NNicpd9Oi6z1vQDdfQgkqexjcrofT7CoKP0dLIijEESME+2RwNP0+hlBOf7v
         sZlIxq361CVmwuWeR4rjmBLhBuprwwR9+W1Q8WEamQt0UDG6z2dIbFINFU4i1bYpNZle
         adFd0vBObsHgwb4AzUQ+kvYIB0An/9C5ZShJvBdOy6s0XVkqSW1O1hQt35RjQ/b0dnAp
         YJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433073; x=1722037873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdVO46PMlcBgI+ne7j7UwSAA4lN1OIh/NoMWcCiQ7DM=;
        b=uTn48kA8TFbHr9eRSDbbSeim0OP8FBdqxq3VNxJyvXbzPIqVhThHJe/ytaaK9PdRYJ
         OnlO0ea7na9LnJYdHjOqrsMYwG8CTioauh4ziZg6pFFxEz6QyBjh9Ndi3KEc+Gpn9ozQ
         Fd8dOvGh5bA/dBVeLcBI0kYa5WCeyZfFAZUVqbIekpPBYXkdUuIjo0lHHPFIIaB5zkbi
         q/QqmtaM8xbbeCHMZ3GsGVnwCta8PJED0WuLM898n98dfPGZpxp1Gm3EUc+b4gcLKPUx
         ORML7Uez4h7q26J14Am8n2IS+RSFW7H05gNZHzgv0o7X+mxLa2D4OdY2XTxzq60f5Wuu
         Wsfg==
X-Forwarded-Encrypted: i=1; AJvYcCUY7ZNBlnP8NKHfecWylpoMTBUrDGFPv35O/CbNU6qKZtOdaNDfFLkJ+fRQ/y1eyd6paZZVLTng4zes3d42624IW48TxQRsDsHvScs/
X-Gm-Message-State: AOJu0YwHJaMJm9wlWX0PGEkRWp/aGb7/nxlLAIkEg4lT/+B8e1fHoPWH
	k7ANQpFeOyskCyBUasbGfquW9tgPsd0kLmJLXXfrVRPPPmCfO1NoV16ul8zxjwPV6dZjduqyspL
	TSQ==
X-Google-Smtp-Source: AGHT+IGmFkrrWPx3tuEOZ0FODIaBqubff0bPniwUu0Iu1FG6TzHsKKgJswuzEa2qgvqE403sR3EIJhNUJ+w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1b0e:b0:2ca:f1a0:8e74 with SMTP id
 98e67ed59e1d1-2cd170a5399mr56982a91.2.1721433072795; Fri, 19 Jul 2024
 16:51:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:50:59 -0700
In-Reply-To: <20240719235107.3023592-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719235107.3023592-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719235107.3023592-3-seanjc@google.com>
Subject: [PATCH v2 02/10] KVM: x86: Move x2APIC ICR helper above kvm_apic_write_nodecode()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hoist kvm_x2apic_icr_write() above kvm_apic_write_nodecode() so that a
local helper to _read_ the x2APIC ICR can be added and used in the
nodecode path without needing a forward declaration.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 35c4567567a2..d14ef485b0bd 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2455,6 +2455,29 @@ void kvm_lapic_set_eoi(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_lapic_set_eoi);
 
+#define X2APIC_ICR_RESERVED_BITS (GENMASK_ULL(31, 20) | GENMASK_ULL(17, 16) | BIT(13))
+
+int kvm_x2apic_icr_write(struct kvm_lapic *apic, u64 data)
+{
+	if (data & X2APIC_ICR_RESERVED_BITS)
+		return 1;
+
+	/*
+	 * The BUSY bit is reserved on both Intel and AMD in x2APIC mode, but
+	 * only AMD requires it to be zero, Intel essentially just ignores the
+	 * bit.  And if IPI virtualization (Intel) or x2AVIC (AMD) is enabled,
+	 * the CPU performs the reserved bits checks, i.e. the underlying CPU
+	 * behavior will "win".  Arbitrarily clear the BUSY bit, as there is no
+	 * sane way to provide consistent behavior with respect to hardware.
+	 */
+	data &= ~APIC_ICR_BUSY;
+
+	kvm_apic_send_ipi(apic, (u32)data, (u32)(data >> 32));
+	kvm_lapic_set_reg64(apic, APIC_ICR, data);
+	trace_kvm_apic_write(APIC_ICR, data);
+	return 0;
+}
+
 /* emulate APIC access in a trap manner */
 void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
 {
@@ -3186,29 +3209,6 @@ int kvm_lapic_set_vapic_addr(struct kvm_vcpu *vcpu, gpa_t vapic_addr)
 	return 0;
 }
 
-#define X2APIC_ICR_RESERVED_BITS (GENMASK_ULL(31, 20) | GENMASK_ULL(17, 16) | BIT(13))
-
-int kvm_x2apic_icr_write(struct kvm_lapic *apic, u64 data)
-{
-	if (data & X2APIC_ICR_RESERVED_BITS)
-		return 1;
-
-	/*
-	 * The BUSY bit is reserved on both Intel and AMD in x2APIC mode, but
-	 * only AMD requires it to be zero, Intel essentially just ignores the
-	 * bit.  And if IPI virtualization (Intel) or x2AVIC (AMD) is enabled,
-	 * the CPU performs the reserved bits checks, i.e. the underlying CPU
-	 * behavior will "win".  Arbitrarily clear the BUSY bit, as there is no
-	 * sane way to provide consistent behavior with respect to hardware.
-	 */
-	data &= ~APIC_ICR_BUSY;
-
-	kvm_apic_send_ipi(apic, (u32)data, (u32)(data >> 32));
-	kvm_lapic_set_reg64(apic, APIC_ICR, data);
-	trace_kvm_apic_write(APIC_ICR, data);
-	return 0;
-}
-
 static int kvm_lapic_msr_read(struct kvm_lapic *apic, u32 reg, u64 *data)
 {
 	u32 low;
-- 
2.45.2.1089.g2a221341d9-goog


