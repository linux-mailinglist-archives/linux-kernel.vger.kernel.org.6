Return-Path: <linux-kernel+bounces-309589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04293966D37
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7261F244DD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9FBA933;
	Sat, 31 Aug 2024 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVS4K4EC"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729DB4C8C
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063344; cv=none; b=erWxSOlUxcQHWX+iAp3zor8HgyzFPPN+NP+9+GpMCo1f3mYSQ78x4yZHQIODO79HUGkDib3JdhMM8cHfk3mwE/2fbQPWho/0PKO+VCXEHTANr0OitYBTW8LjJ2xBIkZWp3qX93G/34kCqbaf6sr2MdtYq3I2s0oqdLb3wJVawQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063344; c=relaxed/simple;
	bh=YXptvY2Uza2H6tZmzonyv74pSte76Tmo4IfX2fwO+lI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C9u6YSlOLDFJLFeHquS4MX6tpPSRGFONpk1bn6oot8kTQiLRs5VKX1uIMwBR4Q6GdeKalc3PXk2MfxbTZZaiyKLB7+eyTbWOLQkhs4qSEpOEaHGQstMBI4q5TmjX73eroyZQnRufA4dPZn/ijJQORw+7SuTkzSQlD45dRxoh1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVS4K4EC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7142a78918bso2851653b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063343; x=1725668143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE7D/Acr9LdQYMIXlBbpo74VePMtTsMcOWGqO6E6aPU=;
        b=wVS4K4ECSWnN4B2tXS5Xi+dfWOwdFk322Z3lzJgGYbNbPuUk1GVvTgQl1EF2ZORY38
         ygjMeFPBXe6cWuHk/yvVr3aryruQGspP8HdJKGDqhdzE2KkA6mC7hnRFaTOKg9UwQywR
         SZRU1ya92RrqYrA2esJCvU9eMKpCMUyWhGONaTCBMWr6VF12KyVzLvTo7duQzHG9uynM
         zmtgYcP2hn40AYEZn1AmkgebR71OKQmZAzDhQh/Hf5we0VFvUK/UU7MOzG59mJ27jIku
         PDHgP49RazXClrJ2AzxVYkmKC09zntgMVqGjLnZIClTAsE6vFG6h5oMR5gOGB5aj+/iJ
         JkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063343; x=1725668143;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TE7D/Acr9LdQYMIXlBbpo74VePMtTsMcOWGqO6E6aPU=;
        b=aOhMjIEke0aDCpO0BixS1/rtpKwu/N47c0jl/vrIp0O8Z0CuCS3vvpVpY5yFIGQz1o
         3zBgsdaRr6NNnI1Js0cQaP9iabinpG48s1JzKLpkAsPr3IX7WUUA/opOp0DoTO4lx08R
         N5uetE/bi4sePzO9+pNMbQX6gSHjlISISpG+TK/ndP+wWHgknqO/Ex07Rkpsl6u8uZEV
         tRDa9KxiKjTSIwlmXZGvaQHriENytDqzgjXSLL6mKQ6wfRgNWamN896/S1VGrmIUydWs
         AhbBFHNXo9vaEfut3P1SxfCL42rMUDsWoxiIvom/u6Qoe35cHb6buoXugh2mRGBUyp0R
         Et/w==
X-Forwarded-Encrypted: i=1; AJvYcCWe8SjtyAD6BIVGKGq3VROtowBW9mWiMktetTZ66Q8l1szAvpWA4nrE3FJvQ58eXWr1uGPXkF5fat8F1qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXs0ODCA8ZplJuRo/GQAC+OpWBUWs2WLC0N108Q3v6gtggoVH
	LkH+8XlgZ1kqbYs/VV8nRhwzSAPUvobwgNdNGf+Ct1WEB0ViLEtX0qNzx4AXmJcJZw4b2zWLsyf
	h5g==
X-Google-Smtp-Source: AGHT+IHgRgu3nlEMwZydwng1Zdptt9mq0HfSF6rdSzaH8wMvVyFEIrgTbt4SBvsLsaty6rpdkiRrHOmEX/c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:739d:b0:714:200c:39b0 with SMTP id
 d2e1a72fcca58-717308ae005mr11477b3a.6.1725063342706; Fri, 30 Aug 2024
 17:15:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 17:15:16 -0700
In-Reply-To: <20240831001538.336683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831001538.336683-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831001538.336683-2-seanjc@google.com>
Subject: [PATCH v2 01/22] KVM: VMX: Set PFERR_GUEST_{FINAL,PAGE}_MASK if and
 only if the GVA is valid
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
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
Reviewed-by: Yuan Yao <yuan.yao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f9fbc299126c..ad5c3f149fd3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5800,8 +5800,9 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu=
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
2.46.0.469.g59c65b2a67-goog


