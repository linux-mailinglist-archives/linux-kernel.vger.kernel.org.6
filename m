Return-Path: <linux-kernel+bounces-257734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843A937E37
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8097B20CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065C14D293;
	Fri, 19 Jul 2024 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="znOsomye"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413114B95F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433090; cv=none; b=e2kfjcTvOzr2HIB+67Xsoeio66MMVu7hcrV882VQJcnWyENzDSijR12UBYll4UxETexTTycDQxB295mRVZHxzB9/kiFfvf6Kgb6ewoeIihDE/PXBN5Y2ti9rCYqHiE7XsQr5d5nt+l2owEqueLo9oFhtFEMrP7nhSSdoyDOho3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433090; c=relaxed/simple;
	bh=LPH8q9W4fShc7MD86NNRowGmzhOW/kmQBwXTLxhGfcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IA852a0KD6jd79gc3/+9GXVDU1SXz+sh3zdE/ujrhfDF4/1ctNrO6YeL4KbHvlHi3TtMlpfRN+AZrHP0IxQXhcG3T4zOoGaWwn9B859CbNIxmQZxlN458ZublMe70oczQpRx6jCjE8HRYgWfc7r3XYrfKDQkqaxTcVE7blRhRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=znOsomye; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2caaaf5870aso2145338a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433089; x=1722037889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rEJGCMpMk3RIfu2QMQ4nUitiZAubqCnC3LYp6iaILlU=;
        b=znOsomyeF6udBTvEt251PI3t3XPmo5EOLU5WVaDq8p1zjZuAkAMAVZ8aKmr/dpbrnl
         nOy3m/I3SUfeZRX+0bDgC3RUvheiYJe1d2jp85ZZ9Gp+25rmqkAiD5sbBLAyoBTMd9hd
         SDoJSP56C/Emkq6BdKwsDb2xePyRq+BSP3bYXY1B9GgsmXzDSQhdfVxyz4nd2Dn+CtuO
         cUIlDIOgUb75OMkQ5Utxr7faP0eZ0EgkwLV13OG4Z3X5K4y7GmRnktkEaADMprFdfCbN
         mLpW3UsHSVme845xuKp6RoP4zI2NL6U+RQM0GA7WJuqNYVqPMMC2ZQlXc0fClqK4KwRk
         M4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433089; x=1722037889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEJGCMpMk3RIfu2QMQ4nUitiZAubqCnC3LYp6iaILlU=;
        b=bD4i/+IxI1osS7mbBmrQRHFAAzwCFpk+GzSHCzrgQQ4uQwwgsW9E5CSinRMm1NdheX
         00ScgYkQ3N6OXHozsMez5qS0Z59BKXK2/CcHvFa5SWYgyQSaw91rGgXpTkMmFI+j6fVX
         SWiDhudQ1NZlgA9KZ0CDYwNAcCqiCejwXb2dsV1iFzdv/BIBDSbkz0UwoouYA/4hHcjr
         bLEbnNsZgw1aCsON93vE5EelrdoWpZhW/uDkWmQ5azCWrYICFyGMRuoXjQQv6FqSG1iP
         30z1vN05Pkb89necZn9jFeP2Zh3dAab2B9a2td6xktsSZWKPwKhyDMjhhvzJFYnGEVDx
         qf+g==
X-Forwarded-Encrypted: i=1; AJvYcCUkQvBZo6ttIofw5Ix7pTNHewLy6SMxK9JXCD29h4NnuDFZhGAqLuFB6Dyi7lIhcnqs3IgPBhCmpcHuY5axgKFxbYAPR4LPkyBgbdMW
X-Gm-Message-State: AOJu0Ywd36CfXoDaW09ySceY26sV1TAFlqJXIrK9KB+atzs2AVZMUiRQ
	52aiggfh5RGYIMC3KFug0qFa6rAQSFc6sG0drmnQutlWZmTVgakdt10eYr+lnjQRkft+7kDBqyu
	wOA==
X-Google-Smtp-Source: AGHT+IFNSTCJ4CN2s2b9vbf+ii17GENMZV/5sakKmq6+fG9OzPne60xcEuzETwhtYlL5iJJ6q//VK1rZGY4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7884:b0:2bd:f679:24ac with SMTP id
 98e67ed59e1d1-2cd15e5389dmr4232a91.0.1721433088762; Fri, 19 Jul 2024 16:51:28
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:51:07 -0700
In-Reply-To: <20240719235107.3023592-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719235107.3023592-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719235107.3023592-11-seanjc@google.com>
Subject: [PATCH v2 10/10] KVM: selftests: Play nice with AMD's AVIC errata
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"

When AVIC, and thus IPI virtualization on AMD, is enabled, the CPU will
virtualize ICR writes.  Unfortunately, the CPU doesn't do a very good job,
as it fails to clear the BUSY bit and also allows writing ICR2[23:0],
despite them being "RESERVED MBZ".  Account for the quirky behavior in
the xapic_state test to avoid failures in a configuration that likely has
no hope of ever being enabled in production.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/xapic_state_test.c   | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index a940adf429ef..a72bdc4c5c52 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -13,6 +13,7 @@
 struct xapic_vcpu {
 	struct kvm_vcpu *vcpu;
 	bool is_x2apic;
+	bool has_xavic_errata;
 };
 
 static void xapic_guest_code(void)
@@ -79,12 +80,17 @@ static void ____test_icr(struct xapic_vcpu *x, uint64_t val)
 	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &xapic);
 	icr = (u64)(*((u32 *)&xapic.regs[APIC_ICR])) |
 	      (u64)(*((u32 *)&xapic.regs[APIC_ICR2])) << 32;
-	if (!x->is_x2apic)
-		val &= (-1u | (0xffull << (32 + 24)));
-	else if (val & X2APIC_RSVD_BITS_MASK)
+	if (!x->is_x2apic) {
+		if (!x->has_xavic_errata)
+			val &= (-1u | (0xffull << (32 + 24)));
+	} else if (val & X2APIC_RSVD_BITS_MASK) {
 		return;
+	}
 
-	TEST_ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
+	if (x->has_xavic_errata)
+		TEST_ASSERT_EQ(icr & ~APIC_ICR_BUSY, val & ~APIC_ICR_BUSY);
+	else
+		TEST_ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
 }
 
 static void __test_icr(struct xapic_vcpu *x, uint64_t val)
@@ -209,6 +215,15 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&x.vcpu, xapic_guest_code);
 	x.is_x2apic = false;
 
+	/*
+	 * AMD's AVIC implementation is buggy (fails to clear the ICR BUSY bit),
+	 * and also diverges from KVM with respect to ICR2[23:0] (KVM and Intel
+	 * drops writes, AMD does not).  Account for the errata when checking
+	 * that KVM reads back what was written.
+	 */
+	x.has_xavic_errata = host_cpu_is_amd &&
+			     get_kvm_amd_param_bool("avic");
+
 	vcpu_clear_cpuid_feature(x.vcpu, X86_FEATURE_X2APIC);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
-- 
2.45.2.1089.g2a221341d9-goog


