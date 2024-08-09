Return-Path: <linux-kernel+bounces-281420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5DA94D6CD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A24E282062
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2D16726E;
	Fri,  9 Aug 2024 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDK1iV3p"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64615FD15
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230212; cv=none; b=nwxn1+owur9o1awnkEelRrAf2vIgiZhJj/KNeWNunGDLpyRu/cOUG05US5sGVsfLGveFvet9yoms83wT09n6+BhKryA5BbLH/jViVLiKwAPVU6YW7E0yEcMtJgB+duAn+KbwUOnb/JXbWHVaaarucZ1cKGdkw7pLQPQ8+iBkHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230212; c=relaxed/simple;
	bh=/3Mc0aYUnYlmMvDT2VZdsvGshabqaL6eclOqKW0yriU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sa8r55LlZjovK5guagtHk2d9Q4F9k0R/tSfktaXx1dF+vhvhUtdhGPmBLWtLQJNBmTqTBk9/b4Vy9jTPAIl++wjwn7jn63IaFkJEZy79DaqsIu5hc5hK1eSnGWhobAegcIni4QpL5ZE93VJnMMDSVOhY3bxyuF4UeN7M8r/CciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDK1iV3p; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d34fa1726so2497865b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230210; x=1723835010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqYKYc5ZaZDxsjSNj47554NGsl1XvrBnLwjmIYW0Wgc=;
        b=oDK1iV3purwsR54IVPgw81HLbhgJHjrtb77iJTs3+5eF2ctuvhuFITBCMxYca4DIlQ
         9qZztRVNSIXlxffv6qBQErqEt8YU86uDzVcIBC4DHfKBn6IFt3QI8DkXQVN+QTLVAgSK
         ciE5Sh+gutRUC/0VHpfdsK44jQZ8PhNeBPB7sP2r7W/d+iXC9QPGAvFk6GjJ4FDpWGmK
         m3pCezCnruPMFGO4BX4MeFC0EUzAg6H9RvrUByGg+VfAP2SEoFu+6rlniXKLsVB0ffri
         o+SStKmeZ1PZoamq+dZCMQ8lYn/kghkWjDHhtbsRg3KXPZoYE3srKLk7KuKMe/T19g9g
         l/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230210; x=1723835010;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NqYKYc5ZaZDxsjSNj47554NGsl1XvrBnLwjmIYW0Wgc=;
        b=XQsqit4fLw9yqTY+YL5bnFej/qXfMGVprRq9ZnOEnnaavSIUd1EYRoUDqkeUMpIhVp
         R7Z2ckJ18wlj7XxWx4QIv+14ndS55FDXIsX80DnnlWqxiLsgiImk1qlip8a3Yx5WZxqz
         1C+EoYaMYCYsFnvPpnoWmFrUghXYV+tOY0Exbp0j8EyZOk+lm1EeEdbxifyYROCZ2LCH
         uxupiqz36NJM+LV7FOdrgrOOc6XcYeK27d+ZY8BkanUv6XyxtmYgXn2wSxIExgrwxoaZ
         a/ZCksEV1O1+nohQoCtLv+bknA/fp6zbeizdFIvEOknczm96r+yWfYXUPQ6ja96c4QfC
         ZyCg==
X-Forwarded-Encrypted: i=1; AJvYcCXpLsp0HN0FOqMB4v2gRu1zf4ljdTQwsQTzoMzOZQdZLuoqTJfqwyCxAAzn91vdDhDhx+DlvokWXnCrs4A8RXLR3TctKLBKOEHhkaER
X-Gm-Message-State: AOJu0YwbyOgEauHcJddTfTCnPOYfz0BPyT5r2qTkUa+lANGZNwDi4L59
	WOeqNunNyivz2k/jQKS5VQW1xV3QqSymmIDGS44WPxoHZ1Xs2+CiD5vCvD/r9POFOB1v/hzQEgM
	Ehw==
X-Google-Smtp-Source: AGHT+IHgCacj5m1MLlQUENYq6BFjimFqJz5RZsNs8W7hnjalJaUAINnEvpiTyC8RkzL0KTMAd+i6sITJmiw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:66d7:b0:706:3421:7406 with SMTP id
 d2e1a72fcca58-710dc62cb1bmr198733b3a.1.1723230210279; Fri, 09 Aug 2024
 12:03:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:02:59 -0700
In-Reply-To: <20240809190319.1710470-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809190319.1710470-3-seanjc@google.com>
Subject: [PATCH 02/22] KVM: VMX: Set PFERR_GUEST_{FINAL,PAGE}_MASK if and only
 if the GVA is valid
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Set PFERR_GUEST_{FINAL,PAGE}_MASK based on EPT_VIOLATION_GVA_TRANSLATED if
and only if EPT_VIOLATION_GVA_IS_VALID is also set in exit qualification.
Per the SDM, bit 8 (EPT_VIOLATION_GVA_TRANSLATED) is valid if and only if
bit 7 (EPT_VIOLATION_GVA_IS_VALID) is set, and is '0' if bit 7 is '0'.

  Bit 7 (a.k.a. EPT_VIOLATION_GVA_IS_VALID)

  Set if the guest linear-address field is valid.  The guest linear-address
  field is valid for all EPT violations except those resulting from an
  attempt to load the guest PDPTEs as part of the execution of the MOV CR
  instruction and those due to trace-address pre-translation

  Bit 8 (a.k.a. EPT_VIOLATION_GVA_TRANSLATED)

  If bit 7 is 1:
    =E2=80=A2 Set if the access causing the EPT violation is to a guest-phy=
sical
      address that is the translation of a linear address.
    =E2=80=A2 Clear if the access causing the EPT violation is to a paging-=
structure
      entry as part of a page walk or the update of an accessed or dirty bi=
t.
      Reserved if bit 7 is 0 (cleared to 0).

Failure to guard the logic on GVA_IS_VALID results in KVM marking the page
fault as PFERR_GUEST_PAGE_MASK when there is no known GVA, which can put
the vCPU into an infinite loop due to kvm_mmu_page_fault() getting false
positive on its PFERR_NESTED_GUEST_PAGE logic (though only because that
logic is also buggy/flawed).

In practice, this is largely a non-issue because so GVA_IS_VALID is almost
always set.  However, when TDX comes along, GVA_IS_VALID will *never* be
set, as the TDX Module deliberately clears bits 12:7 in exit qualification,
e.g. so that the faulting virtual address and other metadata that aren't
practically useful for the hypervisor aren't leaked to the untrusted host.

  When exit is due to EPT violation, bits 12-7 of the exit qualification
  are cleared to 0.

Fixes: eebed2438923 ("kvm: nVMX: Add support for fast unprotection of neste=
d guest page tables")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f18c2d8c7476..52de013550e9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5804,8 +5804,9 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu=
)
 	error_code |=3D (exit_qualification & EPT_VIOLATION_RWX_MASK)
 		      ? PFERR_PRESENT_MASK : 0;
=20
-	error_code |=3D (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) !=3D =
0 ?
-	       PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
+	if (error_code & EPT_VIOLATION_GVA_IS_VALID)
+		error_code |=3D (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
+			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
=20
 	/*
 	 * Check that the GPA doesn't exceed physical memory limits, as that is
--=20
2.46.0.76.ge559c4bf1a-goog


