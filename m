Return-Path: <linux-kernel+bounces-562368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F51A624CA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A922B19C4212
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988D7189BB5;
	Sat, 15 Mar 2025 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZ+ZzfDx"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612B1885A1
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006467; cv=none; b=CWECQwfehsuHtLi0eJxiV4arIkchurbnSSwucSpr/1Ujf51gRCZxodN2AtniLyQS8bvDHNw9l4F2w6C8adIcDOo8PzNTZBtPoLlWYaRoT2u7zksVlF6vq9WT1gsMBmBxNVsOA+fr2lSOESL5rBsoOgOLDzZOwdxJsCVF2Fnw188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006467; c=relaxed/simple;
	bh=gvsLlj9bc8Y/r9hbCjuUIcoMB8ZWIq1plW/QuzquFqc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hB6wY3J/VWaQVkYAhFKwfLk2pCyzlWleJuHyHUSCvo8fAPKIbuGz4S4jVB3vRzObr9NMgUA/OmJY8Y4zuWQXoLjtBkUvRW1b+AzZX7vIdklcQO+sWhRtxLqQPwGDYpeq+gQs7Devzd8IYl8vfFQGl4pAa8nIBiOpaCOh0mATTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZ+ZzfDx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224347aef79so46268795ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742006465; x=1742611265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiP10EQ5oII7sHIYrQJinL/4J0tbjHxSuA2R3IlRhwA=;
        b=AZ+ZzfDx+SjcarfNXzmZTGIuSjpcJPxjvoKZgSv8cmgUGSpyT6EOk5O3uSgOAB0gE7
         r6QIs84oxttGbcjE4xw/fk3x8X9mQq+pn4BOcahL0fyOvmPAFOkNptM3ZIE6fgWakhn+
         PX1Ncfo/XLT0TZB0aLJHZA7CZKmTatKji7Oe5wVUftGiROqNtEvnlNebD5roEHRF9dps
         rvd7kImis4hhcY/dKYDtBqmK5GQW1hhYptRiFRsDTjibyGDji4DsDFrOKNfq0GQb6G1V
         J2ot5m46/111rjU4cAeNesEe5Dho+jTT4FzG+1zYrsu9re4ghuZw3463WZ3ZXZxSLt1x
         N/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742006465; x=1742611265;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiP10EQ5oII7sHIYrQJinL/4J0tbjHxSuA2R3IlRhwA=;
        b=D+okrWYmrofFDlvhNu3OvlvPBQnjCQV+ijl0UBbyaOUdKHRv18sgpQk2MCwyeglHEM
         V/dpajH5QvMV9ffJM/bbzYYzZjDmUrSWqtn41GiyTpicoEE4L2GaJsTUfKLRSjFnyLoW
         x4FoZ5V0Fq4dmZpqA1H9xxC9QBkiibSNKSU7dgV3SCghGT3zVRYP4jgXcneEtGWQN9Iv
         sXdMdsMUi092/fJNF9VG6F4qH6Mrd70xCZ8UoSRJYEcS8EGTprB+s2yrjLKh8Zhel6vC
         QG8oCNkya4jwCYcY0My/5EvF+MMhJY48KFSbR0mOVVojJzapK3RENZ9HI04fmug5CBeO
         JBLA==
X-Forwarded-Encrypted: i=1; AJvYcCV0DqUy2xeTqxvpIH1rd+AKXvUNwEiY/RqCzHO9zPFgFAqzElstDbSYkmdpTiFu+wMIWA/nH9+G1CCbC6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40PBsxGrQzanjUpIUiX+VCSDUz+hAFXLjZ8ZWlD2kdJAxfVnw
	YRo80c2y0jx+eFGAStkS+DIFAc0PVKUakkmliLf/owEW9ZzdN+4buaYxSupLAbwL8OnNMTGoqEa
	ONg==
X-Google-Smtp-Source: AGHT+IEMI0xUsGGPOON5xErQpH0hhzK7pxW1UAww271VxpwLNReHuRNE5EZwjkA9vyJADWk8JYlj/7Hjo2E=
X-Received: from pjbok3.prod.google.com ([2002:a17:90b:1d43:b0:2fb:fac8:f45b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da85:b0:224:910:23f0
 with SMTP id d9443c01a7336-225e0b11989mr57074235ad.49.1742006464811; Fri, 14
 Mar 2025 19:41:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 19:41:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315024102.2361628-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Explicitly zero-initialize on-stack CPUID unions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Explicitly zero/empty-initialize the unions used for PMU related CPUID
entries, instead of manually zeroing all fields (hopefully), or in the
case of 0x80000022, relying on the compiler to clobber the uninitialized
bitfields.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 5e4d4934c0d3..571c906ffcbf 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1427,8 +1427,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		}
 		break;
 	case 0xa: { /* Architectural Performance Monitoring */
-		union cpuid10_eax eax;
-		union cpuid10_edx edx;
+		union cpuid10_eax eax = { };
+		union cpuid10_edx edx = { };
 
 		if (!enable_pmu || !static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
@@ -1444,8 +1444,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		if (kvm_pmu_cap.version)
 			edx.split.anythread_deprecated = 1;
-		edx.split.reserved1 = 0;
-		edx.split.reserved2 = 0;
 
 		entry->eax = eax.full;
 		entry->ebx = kvm_pmu_cap.events_mask;
@@ -1763,7 +1761,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	/* AMD Extended Performance Monitoring and Debug */
 	case 0x80000022: {
-		union cpuid_0x80000022_ebx ebx;
+		union cpuid_0x80000022_ebx ebx = { };
 
 		entry->ecx = entry->edx = 0;
 		if (!enable_pmu || !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2)) {

base-commit: c9ea48bb6ee6b28bbc956c1e8af98044618fed5e
-- 
2.49.0.rc1.451.g8f38331e32-goog


