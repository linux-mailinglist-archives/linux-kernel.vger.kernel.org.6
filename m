Return-Path: <linux-kernel+bounces-257715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F864937E11
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA59B216ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78241149C6E;
	Fri, 19 Jul 2024 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPPHYkBy"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517691494D6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721432634; cv=none; b=W0HPsn2z5RI3Lb0NQPpSKsPgQwg0EPJLqihlNkgabEx6tLETcmFIl9EBZ2JKO5GrifDJe34gWe2onBdradKDRVpjslwq9EIrjRayjISmoKqWLStF5CjROoxp2W8i4EJYnVmISZ8RnMoYcQaqPNn7KxlW5TwhHMX08ennK+qvuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721432634; c=relaxed/simple;
	bh=Z1cH1V9K2pPOjjICaFF7xPr76fow0RyXynIXQuiRywA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tAvBG54vgguRl1VCzXnxzvlPnfQTL0Y5ww7xmBUJ0YV6JyhZigumxKG0gMIZQ5mx/2x6E7wxwZ1+sUTEj7wk77cEs6vhCi3KXcQ0XnlmJ+70ar0EAagH2jK5TAC4WCU8BmccDKzXbQj2qeC1MJBuPBZPmD6KALUxMhYn7VqFSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TPPHYkBy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70b0e67e335so1121092b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721432633; x=1722037433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RdVO46PMlcBgI+ne7j7UwSAA4lN1OIh/NoMWcCiQ7DM=;
        b=TPPHYkBy3TiUELDRlwMuEx+qBxW/BuO8KYkUDyHRSf5MRNaGhFPDHXmDgsmVwaNDIJ
         h03JcUYfpPEroZmy0kWXwF2IhAvoCKaKYp1tatz34XiYTzXqudOIWGVsqlgOH1BOJMHP
         DRV19vp/2yVwlm5/dOIMoynZG9OGr8jYTLrjEvOcGsKb7nGIVzrjUpF0Nlg9g8AX3IKh
         LPT/cWKLZHsPOa7cV3sTWdOv+zjK6GyAmce0HRb0FbGNyZTycFsqSAYdJeFgy1k8cTK8
         TzrICGeUx3icxZ6SBMFaYOx2/VTKm+aKWaBbCWL7EO/3/cjusTZrV0cB7XMxqgurea7e
         wu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721432633; x=1722037433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdVO46PMlcBgI+ne7j7UwSAA4lN1OIh/NoMWcCiQ7DM=;
        b=dUrbsZAPW8bWLeZMtnpidW7wVZHUoGFXdEq7b/H/WsB0E8UBluY7J83lglaRYW4ArX
         Y+UGu3KlDTXM8XMCcdfg9Wuw4yjcA6lJfG7d+xttipzviHqKsSh3iIpKAM9/Ye7nbXCz
         MihSUk8vfH8hSENkg4HVZet/qFqXCn/1PupP5vvxXq53Juk15lwyl3eUDrKTe/G8hjQ0
         q1u/E5LsflOZ9IYsiQtZvnj43BfnxjB8N3QTbzBIidoJBOME3X8eMu0XXD9sDOzvnmjz
         H8EN+fijmDnvSGfgHsUgl78D35cj3Xy0eStnlNjAvmarNKTNexH9KJP1XHDJXdRkx3NA
         h9cg==
X-Forwarded-Encrypted: i=1; AJvYcCXOToHB2JNSnrh0OX0t/P2gdX9N6Oqn4n5hQiSkJQ1FHia2Cc5MWcrveLj1uXilrabfAJoxdy+4+eZXyYFJPMY80nGLHLmK0JCAhJR0
X-Gm-Message-State: AOJu0YyvdBE9o/17IyHF5y93AqXl/MsKKsvaVdv+3P3j1RZpfd5vIVKu
	yscZx6jzb9FX2DiKDxoeK0RxZpbkPO0DeHAE4qY1Q+wiu4sf9zcvL0BQJ9WbfKISFeVxYTQRns6
	Obw==
X-Google-Smtp-Source: AGHT+IGrqTi7r+bD33iXiOlKe24I4fRBWbe1ifwKtqgnwHLxRGmTs+zh59kEsCtnf3DhIB+XwN5wBZPlmi0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:87d8:0:b0:70a:ffc2:ba with SMTP id
 d2e1a72fcca58-70d0845b84dmr4399b3a.0.1721432632396; Fri, 19 Jul 2024 16:43:52
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:43:39 -0700
In-Reply-To: <20240719234346.3020464-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719234346.3020464-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719234346.3020464-3-seanjc@google.com>
Subject: [PATCH 2/8] KVM: x86: Move x2APIC ICR helper above kvm_apic_write_nodecode()
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


