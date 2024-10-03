Return-Path: <linux-kernel+bounces-349745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C623798FAE8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73931282869
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F681D271C;
	Thu,  3 Oct 2024 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQMSKbCT"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D401D221C
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999035; cv=none; b=q6SRh5lCclnxEGI+NK3oBc+H2toIuCpL0Y+sglqQTe3Kr2GOL49qOgAV2+UoRDJ7/fEVo5DUQehO+RoMPlvhO8gixfG2FPI1RtTYMPnuY9Rm7ozjKu0Tb/fb57q7WTVwsEFEXQoz8eULwJ8DpXa6hPNtS214MatqaFWTYOuwjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999035; c=relaxed/simple;
	bh=YWaZS/REFKJMLevlqrMIo/CR/NX3I+PwQJV5TvOBW+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ego45BYHxuw2ANb0WYNGP2FnNevdLTMasISwLhYPHfi5ZcxMqHDuqnubAndUeE+GxKdKr8F/eG3Mfs4JBoFprDox/68TAHrmXOBt1e28DNAx2N9qWkOseIfG82vkDO+UCo7xfX9x8n5ErKj9VHob5cGUkm/6+Unyh7U53Xmd3LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQMSKbCT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7c6a9c1a9b8so971088a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727999032; x=1728603832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xgBcuvGk3o3ZhJ5eerG862wxsCgl+dqWJVsjJCQrLX8=;
        b=tQMSKbCTN833z8PFmSr0bP6Be9Ipa2H0X8P+Nfmi+zYAJM6Iduuok3T9oHynd6H/Tw
         iGu2Mq+3sUWbtl5XYOOa6ybifHd/wOi/tCmvbCjjBbtwQ7bQHuwBcYPM6L/01IolCExF
         CatAu7x/VpsrRu1Gj0a0nDrO3FsFuAIfTl0KO8L+h04vdcEK4MgMPD3dvSTejB/9KwhA
         qB4yTZSOtnHpk49Slm6OkZWSWCYnFRManXCh7rMf9Zw3y5+PJASirc+MDNIw6lBHy1h6
         rOE1gsaoeeRyPWhFhpSQ280QsTRfq3KwGHNsc6GA2t50ZQZNXYoES8JaAbKwDvd5UP/S
         VwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999032; x=1728603832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgBcuvGk3o3ZhJ5eerG862wxsCgl+dqWJVsjJCQrLX8=;
        b=gbzCyPru0llrIcVMK1psXUbmBZQyV4lWDAr23JNBPquCrMqGMWPzbHDwaZcItmxZOO
         6S9PQapZhgWRbaYVsxXH7AzNuilsPrkFkj1drt9dhWcnC8l2i9CE1v0Ag6pnW5oLAlJ7
         AGYdMdbBU1CedK2142HWjqKk5+awVYfFxzYkC7huoWWhTaD/cXQuXRy5MKOV88eX9CXH
         +ffcE5XvEdS5Ws4ZxaiueHhZpYMRu+zeE9qJIs4Dy+zVycD5g1hMcCrZ8ZlRow3hC16f
         5C1o0CVgFQoUK4hZ9J3G4TPm+xcOHBqQhG4WuW3OrjmYehcSdvvNsd2IDSRNaqpRQsaq
         /Ehw==
X-Forwarded-Encrypted: i=1; AJvYcCXKKpLJ78dBQKm6mox/Uafu3R79emCn9YmFxdWFru9BDzUZLNzT7n+BzMYhDniaPZlBsrb+9TTliIbCPCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xlwJT2GUprfZ29z7pAxMoV2tRIngESfKhiYmGJhsPr4jnw3a
	+ntLez3BgBwaKy2i/BPnFsDKcRHXr9mRHEUoBVs8+dUXN9v9Odw3CCBEF/cq5qwxkaz6XaBNvlb
	Qvg==
X-Google-Smtp-Source: AGHT+IFXq9RCb6WRkwMAtMcPJ9IUSeE+59BJekmESI3c/ddtcupPuWgRFNALH1TsU96CuFHtqHa2A7atpFQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:8c07:0:b0:7db:16b4:7a2a with SMTP id
 41be03b00d2f7-7e9e59a8976mr1289a12.2.1727999031876; Thu, 03 Oct 2024 16:43:51
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Oct 2024 16:43:32 -0700
In-Reply-To: <20241003234337.273364-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003234337.273364-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003234337.273364-7-seanjc@google.com>
Subject: [PATCH 06/11] KVM: selftests: Verify XCR0 can be "downgraded" and "upgraded"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM selftests enable all supported XCR0 features by default, add
a testcase to the XCR0 vs. CPUID test to verify that the guest can disable
everything except the legacy FPU in XCR0, and then re-enable the full
feature set, which is kinda sorta what the test did before XCR0 was setup
by default.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c b/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
index a4aecdc77da5..c8a5c5e51661 100644
--- a/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
@@ -79,6 +79,11 @@ static void guest_code(void)
 	ASSERT_ALL_OR_NONE_XFEATURE(supported_xcr0,
 				    XFEATURE_MASK_XTILE);
 
+	vector = xsetbv_safe(0, XFEATURE_MASK_FP);
+	__GUEST_ASSERT(!vector,
+		       "Expected success on XSETBV(FP), got vector '0x%x'",
+		       vector);
+
 	vector = xsetbv_safe(0, supported_xcr0);
 	__GUEST_ASSERT(!vector,
 		       "Expected success on XSETBV(0x%lx), got vector '0x%x'",
-- 
2.47.0.rc0.187.ge670bccf7e-goog


