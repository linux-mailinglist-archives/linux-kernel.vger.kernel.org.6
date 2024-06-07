Return-Path: <linux-kernel+bounces-206540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0CE900B2E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC3C28680F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7F19B593;
	Fri,  7 Jun 2024 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGbTp4o1"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4519ADB1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781176; cv=none; b=VRsTciN3HJZa8DrQr8dkTWmRLe8vU1vsteusNvoGSLWkI7bq663l1ezhcl6COcDSzqH3fXqXUra4vKeCwwomvDvKHYcKca0gJBcd7mKK3e5odacG3mFNHNB9FhmJZ8BcIzd8MLc/xjWx9ftUrKJDqqqMgdt8dntR8uYmuwehMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781176; c=relaxed/simple;
	bh=CmeU6X6XuRUCMZgWNmWWbwkO7e45T52s6O6uFlVMD4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uiJzuPOI2naGYExHB/OZlH7oJ5dZu6dXKlSsajv+U8i9PoTctWPQwwh2gd6ZCYd40T8WZOWao9Fl8IHM6I7kfAYXcG/Q8LtC3a//jMUfavGqK3g1/meAiZS5Wbu4C7IUJt2Zar4HKMppZMDppneUAg20j4XAGTkSrOOoeazcLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGbTp4o1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c1e9cbab00so1817552a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717781174; x=1718385974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nvAxTcZIvC1OdGrlu2eJxWT3B4hHYurQ+uIblxla4PA=;
        b=zGbTp4o1gvvfKg1SufjTOQJSja6C0ucpU/ZpqFqcCWgzMOv72MqE5X2BV88zu5ea3O
         /pnTM3mGshd++JyXUtmnJX0Rbbk287AqoffV7nwYurLHsPTKRnoi1/w8Mr0o723trkyj
         W9EnBTsZD3tfepoGOTCNinaa8PktrY/rv2DixHDdAyxIrzKQYTV/TN3pnfmn8CyhZ3Wv
         K+3GyJiHtpV/FrRACu/2SewvHl8EOAsj7slHyEXCQnj2EIJMX9Ae2z+5A5Xz2jaZ4ClV
         2UXxeRFDXh70ANO5w+Xq1dOJrkzfZiP8sX3vYTNzC0FAl4Whv+m2KmEWR5OCaMMnjbKF
         Icig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781174; x=1718385974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvAxTcZIvC1OdGrlu2eJxWT3B4hHYurQ+uIblxla4PA=;
        b=c84j9zwUGNmaRs9ZwJ5TSuVkN+ClIiqBV6BLz1eRhsIDUrK6C7jkGdZ0mrzDTge44K
         ixxDHDa1+EwMQWhWkETEywiOXAe0SNUL8jqWnmOxiMtqKJ+KLPDjaifpkX+kf3x1mbvJ
         ZNSDeLnpaVwzgAoUWyoHxNLOG2ytAsLL/SphgDkYskseYi8+tjMWNog2kIyb12Oz2LH3
         RHqhajNBczO2aOD2qr+gVpxbaTla/r/9wrKPWwZ6moYx3UBNIvcMSF9aDqVNZoofF01e
         zP3/8UYrYts+1HNyEQCooEeVaZgLZoxOIV04SeBUyMJ27abkZWQru/C0MjMpd5tdMF28
         aaYA==
X-Forwarded-Encrypted: i=1; AJvYcCUy0KGvbSgJuOpQ1+u8EmP6eQk5q8sQovUloxNnqc2lz78wsn/g2gjQGfrdkOMnW2OMErurd8W6QAi6VJjuMsr8h3T1gUiHuHjzLwn/
X-Gm-Message-State: AOJu0Yz8Bo0IRbjtetOHs5Wx5yLiL9ViwJ9l1EtbOEn61ZwRuD1X0L4/
	FTAidNUip2ueax8Che7ZWGvrTrxxarG5abhTqG4u1PT93J/YbTHJJ+oxZJsjWD+nF3z/4yr907Q
	wng==
X-Google-Smtp-Source: AGHT+IGxcLR1b1Vm2e5rkoqR3n1WKlpdaBelsURlYgVJIykIKm0lGuKPenh5KLDsE4HFKo215OoI1C+zKeo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5a82:b0:2c2:d12e:c344 with SMTP id
 98e67ed59e1d1-2c2d12ed108mr3554a91.2.1717781174029; Fri, 07 Jun 2024 10:26:14
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  7 Jun 2024 10:26:04 -0700
In-Reply-To: <20240607172609.3205077-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240607172609.3205077-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607172609.3205077-2-seanjc@google.com>
Subject: [PATCH 1/6] KVM: nVMX: Add a helper to get highest pending from
 Posted Interrupt vector
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper to retrieve the highest pending vector given a Posted
Interrupt descriptor.  While the actual operation is straightforward, it's
surprisingly easy to mess up, e.g. if one tries to reuse lapic.c's
find_highest_vector(), which doesn't work with PID.PIR due to the APIC's
IRR and ISR component registers being physically discontiguous (they're
4-byte registers aligned at 16-byte intervals).

To make PIR handling more consistent with respect to IRR and ISR handling,
return -1 to indicate "no interrupt pending".

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c      |  5 +++--
 arch/x86/kvm/vmx/posted_intr.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 75b4f41d9926..0710486d42cc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -12,6 +12,7 @@
 #include "mmu.h"
 #include "nested.h"
 #include "pmu.h"
+#include "posted_intr.h"
 #include "sgx.h"
 #include "trace.h"
 #include "vmx.h"
@@ -3899,8 +3900,8 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
 		return 0;
 
-	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
-	if (max_irr != 256) {
+	max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+	if (max_irr > 0) {
 		vapic_page = vmx->nested.virtual_apic_map.hva;
 		if (!vapic_page)
 			goto mmio_needed;
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index 6b2a0226257e..1715d2ab07be 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __KVM_X86_VMX_POSTED_INTR_H
 #define __KVM_X86_VMX_POSTED_INTR_H
+
+#include <linux/find.h>
 #include <asm/posted_intr.h>
 
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
@@ -12,4 +14,12 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		       uint32_t guest_irq, bool set);
 void vmx_pi_start_assignment(struct kvm *kvm);
 
+static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
+{
+	int vec;
+
+	vec = find_last_bit((unsigned long *)pi_desc->pir, 256);
+	return vec < 256 ? vec : -1;
+}
+
 #endif /* __KVM_X86_VMX_POSTED_INTR_H */
-- 
2.45.2.505.gda0bf45e8d-goog


