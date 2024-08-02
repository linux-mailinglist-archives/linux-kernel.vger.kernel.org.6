Return-Path: <linux-kernel+bounces-273016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B1946369
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFBA283821
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767F1547FD;
	Fri,  2 Aug 2024 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6niLgpp"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF221547D3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624919; cv=none; b=Br0G/DjTUId6vP9qfNoKO/a2t3OBQo0DjhzlCWPqkHyoFnmK7kgZanz8QlhXQt4J/aSXDZpIL1LLNSb26BHbPT3WLIyCBEJTU3FUNr+qq7hr0ruDhTrQTlVt/wRh0QGazp6ggSosnV1O2C4L6H2O80LBEiMFeJ89AQ2Cd9SqbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624919; c=relaxed/simple;
	bh=mnZrmuWPX5t5ja+UqCYeyUexo17oJVd0vuCAX1ZnhL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ViEcZh/HsW0gTP9eB9kJZm45fGfBejt1lpLHLY89u5YYPdDV5Uw077nvRVhNTmxHWXhZHz85rmBKMnMHojWDMPBUe5uo7JBgMSwnhUHfMd8aY0VQUpqrrIZE9Bo8cM/WaiSr6eFiV7sYfHaixkNCN40asmKT37wuslEMgvA6e+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O6niLgpp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc58790766so86861255ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722624918; x=1723229718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EajeKonpCp6o2uEc/AdOOPSf3UouMnnGsvqbuEFiuOQ=;
        b=O6niLgppqygRnW6C4uydYsE3KkEYJJN6bCWkDqhDxCWy77HpKaXhH0dm+eNiCkdRDE
         Kf2+fHpGyrujS/gXDog+21EbmumXbSc/RspukCBp63aQ0LtCoeNZPHPqLXOWUsS9TZ5Z
         f0bj3ypQs9IH5KIBcGyZKZwCGQN4wDt3nz/PCv8WqRSU/lM0LBuFO3vNrToOO+EKB3mx
         GqJKl9EzoUPAHJW6Wb69oDTyl/iT2C30VWQdtBG6gMmnsurUbP4AFeBxQLsf+7t91v10
         V07DB1aLZyjqONURQEgoL6RAED2Q89d67YKGgXC4WlSyOIIS1dTJesMFMFQqFYaS1zu/
         0KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624918; x=1723229718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EajeKonpCp6o2uEc/AdOOPSf3UouMnnGsvqbuEFiuOQ=;
        b=rBVoDKE0LvFewyZkEc6wm/x8ESMmXf8mYlpyniqc+7slO8IXgZIWAW5KkjKbVgpLyv
         Zu/V5g78LUeYDA2lzSJ/1ObBby7I0lpzid5RKpshoRglUWyTJ3//BXBfWy08YAHTvhUk
         VQ6HUErjsBIsN93UbjT04R69uDtmF/e6lePlOC3lw0G29/ppyhROUXxlFsW9Gqo+E5ZN
         c5dBvX6dA7JLw4RR/frpSMHQhCybT11L2vzIxCjAS28KFKB8fxiO3ypKPYkRsMes6VBO
         zyDcxNNcNqnDxhUGF6ZERbk7DU3pBy0CJ/U+MT0Yy4OuKzV5+mQaxO19wD7PRG4NdVC6
         udOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBnH5Lf1UO8eyFQSzOm5+kgYMcDJP5JsQGEItPmWJpISrNsTMAQ3EMLlLOBEf3ztY0x1ovgEqs00MMCxOcT7/QqJrnRMxLBS40ruRz
X-Gm-Message-State: AOJu0YzUDtZauNuxrMGBZM9k/OSh/pYnpxFnhfCw8ncC750UDFpEktMt
	gCnSoMHqW0NuHjXjnKw/QcZRMS+Koq7tVE+NC0hLrB+r3fW20OB82pgxZEPqgKe0dDdOdaImQkT
	FJw==
X-Google-Smtp-Source: AGHT+IH4+t9YlrlI1s9wcp4ujmavOTmaJnP3SWsealeFsAcIA1+C7/YLWm0qqu4tVUlW2gwx478HHOJLckI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:234e:b0:1fd:d740:b1e5 with SMTP id
 d9443c01a7336-1ff572a81a2mr3170335ad.6.1722624917668; Fri, 02 Aug 2024
 11:55:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:55:03 -0700
In-Reply-To: <20240802185511.305849-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802185511.305849-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802185511.305849-2-seanjc@google.com>
Subject: [PATCH 1/9] KVM: x86: Co-locate initialization of feature MSRs in kvm_arch_vcpu_create()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bunch all of the feature MSR initialization in kvm_arch_vcpu_create() so
that it can be easily quirked in a future patch.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 08c3480f1606..9d667c5ab1a9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12259,6 +12259,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_async_pf_hash_reset(vcpu);
 
+	vcpu->arch.arch_capabilities = kvm_get_arch_capabilities();
+	vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
 	vcpu->arch.perf_capabilities = kvm_caps.supported_perf_cap;
 	kvm_pmu_init(vcpu);
 
@@ -12273,8 +12275,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (r)
 		goto free_guest_fpu;
 
-	vcpu->arch.arch_capabilities = kvm_get_arch_capabilities();
-	vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
 	kvm_xen_init_vcpu(vcpu);
 	vcpu_load(vcpu);
 	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz);
-- 
2.46.0.rc2.264.g509ed76dc8-goog


