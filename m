Return-Path: <linux-kernel+bounces-392753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237619B97BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC935281348
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44011D89E9;
	Fri,  1 Nov 2024 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDHk3TRy"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7361D27A0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486180; cv=none; b=jaAcy8+/Yd4rh4GV+xmaQfuawnwjS/9NDKtBEChX5596LppMAksDYoGlVWnl7+pBIaatpjo013IJfml6tBSm633Pnrg8i048f+gOlmkZ7mlw2QzqIXkA5Mj71xHLqGlEpCXXxT/r1+NZkRT0YMcsz3gUtDMaxSOVi6pLrC3zmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486180; c=relaxed/simple;
	bh=wETa+dLcXchkDF6niCLZKhIJhZbg0XK3Wfx1WgkxMCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TiSgTxCnOJGmvOxQBUUTpaOVX4erJs310BQOFnv7DC3GLpiZODtPSMwOzp96yrF5wryKCpmhpQGuhNniOrYN0TYj8lm0A0TChBjdKOmKKZMTr9hO60PzKsmXvNCLj+rIrX9jQRoLV2ncgSPlChS8T0KoTgYJgZZwPzYTJzI1uRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDHk3TRy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-204e310e050so27106245ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730486178; x=1731090978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=t6n3TCROGALKBhF87tS4HVc6hSldgq3keX1Nmca5GdQ=;
        b=MDHk3TRyDF0J5zovlyekZcJk15Cg90yrmpNGQnIykNg4UT/vWmf2MFi8otvSWkgtDD
         0ShRvpELKEW7cj+rT0B8yo9L8pAs0R1+iJAcuSNODEj1SIzSZ6rg08GMp2aB4t7EnPDU
         HNw0NBkH8reDlTtAFQ0m5k0dHbMJsv8GVy7gMtPdu0UozJf+fcKg6R28H/J5nOSCAxEn
         mOdWVRcMdcmtHt0xahGe6B+0M5cDxlq76L8ExAw6KpA8mgp0yIon3EZ4L/tf15iR9CKV
         NXDsVJt3ICxYv92h9zIhc0eSM+/3OeTy07vRX/YMauqzqMbPIEGHVbn+KofzrIoX7wit
         Hqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486178; x=1731090978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6n3TCROGALKBhF87tS4HVc6hSldgq3keX1Nmca5GdQ=;
        b=G1mUxgK3ExjBKx1Nq6DqQJ5XbemwMR/WwiDNp47jLwxPPSM+piQnv+NLWR2IDFe61u
         hYqa767Bb3znZSU2Fzjv+jDTwpjfWAsDQxF4imtnDzgLU5KV+WPnNdMFS053gZXZI9Y9
         M27LMv/ONvgu1+PMHJnjeD6Giqr2hUef2aJo7RcCjIvu64ahMw0jgAv2vdU0+V0DHToQ
         ia4KyidDJuy7dhlkqmJYPugjR6L6AHg4Xr5vSELz1He36CbjEol9WYrjRqjNaPQxYfw5
         OQ6hzSCSYfllh1fCzaQMMZqjJcMGF+vI89lute7xq7nz/v6Rhu3y0jNCfTuUXAqVi0gI
         q3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlExCUoj9sY7jcYMukL8043CmdtVn2WUp0XSESmciMhYaqh9+c+lnX2NqUUYdz6438m/rhxchhTzaK0mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjSDa6I9RKPvbZyQ220NUrFPZ2seaYGem7VRcCZqBrRhtLJXD5
	HEQwehatv+XLzLLBEBfLuP4iS/odtKelAp9acBrjB7hfaCcsXi33u2z3CC8HCIVI0kyNWWzT1Sc
	gnA==
X-Google-Smtp-Source: AGHT+IH9li/61FEUW1xJGw5b33eDgRmdCZyYAPvyxxo44gUVaRYqdHjdk4v5TgKyy+vIqOwzof42J6bDicI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:e54b:b0:20b:7be8:8ecc with SMTP id
 d9443c01a7336-210c68803d5mr2548335ad.1.1730486178136; Fri, 01 Nov 2024
 11:36:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 11:35:55 -0700
In-Reply-To: <20241101183555.1794700-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101183555.1794700-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101183555.1794700-10-seanjc@google.com>
Subject: [PATCH v2 9/9] KVM: x86: Short-circuit all of kvm_apic_set_base() if
 MSR value is unchanged
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Do nothing in from kvm_apic_set_base() if the incoming MSR value is the
same as the current value, as validating the mode transitions is obviously
unnecessary, and rejecting the write is pointless if the vCPU already has
an invalid value, e.g. if userspace is doing weird things and modified
guest CPUID after setting MSR_IA32_APICBASE.

Bailing early avoids kvm_recalculate_apic_map()'s slow path in the rare
scenario where the map is DIRTY due to some other vCPU dirtying the map,
in which case it's the other vCPU/task's responsibility to recalculate the
map.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 7b2342e40e4e..59a64b703aad 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2582,9 +2582,6 @@ static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
 	u64 old_value = vcpu->arch.apic_base;
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	if (old_value == value)
-		return;
-
 	vcpu->arch.apic_base = value;
 
 	if ((old_value ^ value) & MSR_IA32_APICBASE_ENABLE)
@@ -2632,6 +2629,10 @@ int kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value, bool host_initiated)
 {
 	enum lapic_mode old_mode = kvm_get_apic_mode(vcpu);
 	enum lapic_mode new_mode = kvm_apic_mode(value);
+
+	if (vcpu->arch.apic_base == value)
+		return 0;
+
 	u64 reserved_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu) | 0x2ff |
 		(guest_cpuid_has(vcpu, X86_FEATURE_X2APIC) ? 0 : X2APIC_ENABLE);
 
-- 
2.47.0.163.g1226f6d8fa-goog


