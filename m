Return-Path: <linux-kernel+bounces-273055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63540946416
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242B12811A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A42130A7C;
	Fri,  2 Aug 2024 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRfxlCDL"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D476F6E611
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628289; cv=none; b=vBD+8R7DK2uT3/dfDytlP745jj2MiiJRFej/ryeWUuN+Ai0iaNlyWD+Sh42hinjlKlYywYr21YQeSq1cBzFTptoIeW45X5xr3tYURUavgNcD1Pg7ks8917yDGNUfrIgJomI/XOlJZiG6SdU1vK/rHgzNquytdA+bTtCjKKqukK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628289; c=relaxed/simple;
	bh=TlVRiUICJX5iI1P2EisP0czzGlPcN/R9pgkv0nTLVyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JCRVuUPLndY/F6et5DnfT/mLmAS8sBavdAG4bgqdcV+oBc6rAbcaFHDuYCNR9rZ1E+sBIPwjpJ+lThpbt3tuFaWmuzqBCrlw2hRmOWC4oVXVNVUalm2F4KZg8wT0sJAziqeui2t4x6grJp0WQmwYdKH7Qts9r8RJqyvh89QQSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gRfxlCDL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6688b5b40faso201461027b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722628286; x=1723233086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iMEFOq5Tk4KyJyaLBMXv5gnfBdOhdNIzblrVnJpsjo0=;
        b=gRfxlCDL95WQMFsto3I01rjyW+WQ3sYDWiGzxuUpkwFgpmdMEYgqPmYRE8VH7vYuTM
         Tq26s1pmLTmT8OUfMFkPFRmvu6l4P3ex/mPUobuH2Qnx/SIkWGQ8QztQjJCwNQ4BR0Di
         k5ybn97zdOfP717Id8ZKa1HsoNnqj32PU5ksWkqJwiZbtftrffS1AnGVksu/hoCaoYaF
         KZ2Q6xSJfNy9hDnq9FuSMEyPLsEw4gpJB001kcjNl5cgtFRHwuEwHwBmjQT6s4zitsX7
         H1YftSItbuxZjBHHIazGIuezsJMoH1tGEyRiZ3TvqVNcjCfVYjQ2kL1422+h/G0sVsrN
         5Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722628286; x=1723233086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMEFOq5Tk4KyJyaLBMXv5gnfBdOhdNIzblrVnJpsjo0=;
        b=jSphE4GGHysYwpR6Z+m5wo1wpMtSUP9e1kk7vWHArAl1Ro9EsQOMKm6qOt8RIVVHl2
         UVLCTLz20bQPMqt5EwDMj53+LRpqjEj5/OvttLx4uamZ9Pf1JUGyXH1QJW+lGFL8sWti
         1krR4qqMBhmDzXoImuP3SCDB+qLbJ8+1mprGOjPdbelTTbfwcb6Bol4RfvmwkhFhVTRw
         MnQpa89XdajPSiVx8T000Nl1nHr/RTa2WS9o8f0GdTzu5h2VpHcyWN3n3WPyUPMEiyTB
         jmUv6hZIZ6hABzX1OpElH4T721/h4joI1LCDf12oSs844arBgtCVhmHD0bN2P1Sm4m+l
         PK5w==
X-Forwarded-Encrypted: i=1; AJvYcCUA0oVYmG/K1Cmk8hWu3lyFypsPIBde1GHZVov4KILrC9BiEXlTucKP+OhlW+d0kUbYItkZH/DLUnms5AYfScFXJ7sjhtsiHWQicjzE
X-Gm-Message-State: AOJu0YzvS5+Fv6+ENkyBhw9KuExFMut2qPv1ChwvJOk0sEPXGrPASXXc
	nUe1YHfTsmS4aTN6pbItFH39izBLQRDg11acrKwhDtp55FZg099+wCxkpY+gzGYWNvpBdID9jpx
	hPg==
X-Google-Smtp-Source: AGHT+IEMQIhmUdXTQxP5VzE0A3c9BCZw8dM8LR647TTNv36aIGWuOmIV2yy9svYvy4E20onflnwZ7K40qLM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:113:b0:62c:f6fd:5401 with SMTP id
 00721157ae682-68963bd9bb6mr1995527b3.6.1722628285936; Fri, 02 Aug 2024
 12:51:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 12:51:17 -0700
In-Reply-To: <20240802195120.325560-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802195120.325560-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802195120.325560-3-seanjc@google.com>
Subject: [PATCH 2/5] KVM: x86: Dedup fastpath MSR post-handling logic
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now that the WRMSR fastpath for x2APIC_ICR and TSC_DEADLINE are identical,
ignoring the backend MSR handling, consolidate the common bits of skipping
the instruction and setting the return value.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf397110953f..332584476129 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2164,31 +2164,32 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
 {
 	u32 msr = kvm_rcx_read(vcpu);
 	u64 data;
-	fastpath_t ret = EXIT_FASTPATH_NONE;
+	fastpath_t ret;
+	bool handled;
 
 	kvm_vcpu_srcu_read_lock(vcpu);
 
 	switch (msr) {
 	case APIC_BASE_MSR + (APIC_ICR >> 4):
 		data = kvm_read_edx_eax(vcpu);
-		if (!handle_fastpath_set_x2apic_icr_irqoff(vcpu, data)) {
-			kvm_skip_emulated_instruction(vcpu);
-			ret = EXIT_FASTPATH_REENTER_GUEST;
-		}
+		handled = !handle_fastpath_set_x2apic_icr_irqoff(vcpu, data);
 		break;
 	case MSR_IA32_TSC_DEADLINE:
 		data = kvm_read_edx_eax(vcpu);
-		if (!handle_fastpath_set_tscdeadline(vcpu, data)) {
-			kvm_skip_emulated_instruction(vcpu);
-			ret = EXIT_FASTPATH_REENTER_GUEST;
-		}
+		handled = !handle_fastpath_set_tscdeadline(vcpu, data);
 		break;
 	default:
+		handled = false;
 		break;
 	}
 
-	if (ret != EXIT_FASTPATH_NONE)
+	if (handled) {
+		kvm_skip_emulated_instruction(vcpu);
+		ret = EXIT_FASTPATH_REENTER_GUEST;
 		trace_kvm_msr_write(msr, data);
+	} else {
+		ret = EXIT_FASTPATH_NONE;
+	}
 
 	kvm_vcpu_srcu_read_unlock(vcpu);
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog


