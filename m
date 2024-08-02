Return-Path: <linux-kernel+bounces-272976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3109462FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A21281B2D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8E91E3CD2;
	Fri,  2 Aug 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsOSvbMo"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D11A83D6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622797; cv=none; b=BIPpo6f3Rfcp9q5RA+AIve4/nBEa25DT4Z5jrq1TUdIMd9MAd5WDZD0JtI6KX5rx1C5YEY53p3ow7br7/DCZbJSf+ZABL94vDOucv8LHOwjVYOq6TY8B6W7wtK4uzoMhzzjnPRu7tEV7kZ8pHDH34GLd9UiV6lUz8pRDVC+6TcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622797; c=relaxed/simple;
	bh=KPLJgEJ/YLE4ImH6B/0BvTHADqCesy6cg2Mgr42CQOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YumDgRSo7vrjRIageCY2BEewpvpD9Ts0p2nWZfwSl4lElaUHJjOOmlZbx9tlVK8WvJnYuMNmydTeDiCZKuAPnR4SHa+vrMPBAWTw0AyrLiYsJfk2mYVjg2+nBlAFbToiun9ckbMfEge+HBmcb3DHkDQE0R1cSylipB39c9UqM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lsOSvbMo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb639aa911so8765327a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722622795; x=1723227595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VW65TnSe3VDX+Z2p8XcPpkoNA7LEX/iy6oraj4XmO9c=;
        b=lsOSvbMouzEaHvN2FswNed2RB8U0Oavh+AFQ4XGE7QVmibpUELRvusuH4qbeK0fcB1
         twexQGL6WZlx0t64vxE26YA0+A6kL5TsHEsiJ61S2CiTHc4bXSYOZqL62et/c23Rwf3L
         QV3bjq2GOUlfVGBH6XhTSkbbdp5Lf9Zk8St6yHZR5t5bqYPpUzeOE0J9jM9yrR4wQUQZ
         xQDgE+6/wHJQiLi6cOj8fgHHb/bNTZ6csjb6+I+JBq2Mi9lnFwhzg0vOyhVTy0zQZ4va
         guRq4eBy+WcM7cX88xd0rwbfSZW27N48eulNYe287bseCba3BDnz7k6Z+hgQQloQxfUu
         bWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722622795; x=1723227595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VW65TnSe3VDX+Z2p8XcPpkoNA7LEX/iy6oraj4XmO9c=;
        b=LRiHdUWfVjb9xQvEeViM7/tZkvUBj1KVyZE56+oiwJtDu/eoM1vpHZvun4W4mt83GV
         lpAXz2cxkZiGgV6n6CXnLHokE/zlZ+eXjmlyN59ieufWlojgbW8kcG0XJ3owUYzkwKl0
         G6t7noW/x6Djh/PZ8Q5FmqR8oPDxZ5v+mi9vU2Kb58pXMbAtMdsnLEgMzsdR5YZGXiX7
         xHtZ1r96iGrtAovK/DTuSgUWaWWEe1nvWbN3RKDZGiy1PDP9VonrMLx2slUUqg6y0pZr
         2iWpwjt/H+2VGDWUw1/lWF0yLoxH6Zc44mZYc19g0p/RE2GtNw9F1NedP9csaDrM9WaZ
         5L7g==
X-Forwarded-Encrypted: i=1; AJvYcCVXxLdZQyksYq8rgZT3XB0/v5o1Hp3jVhRU1EN8YmTyUt5do1yl6ZjmpSJUEeJR6P5CnIyp+ypp7VVY118aGiQFn4e/1C0oB7vWpzZb
X-Gm-Message-State: AOJu0YykOYDbexkeY5Z0hlSxsluMHxBTq9Z5d7hMTUBrmfm4VCEV+TLS
	eFOzNYPgCuPd5ALXRJPinCAgiCWeWS5d2whfPTxNkYuDrKXzP6axZ46OcUpF+9iyAmM+g8JsGab
	xYQ==
X-Google-Smtp-Source: AGHT+IHC2KYxnPAs2UD3E/vc510cwpqXgXyw7rAYKuvHYwr4mXpoWWx2tKTMlZBvYrh1ocwK8+X9gwZAAUI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:dc0c:b0:2c9:8b25:d72d with SMTP id
 98e67ed59e1d1-2cff93c1210mr58862a91.2.1722622794752; Fri, 02 Aug 2024
 11:19:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:19:34 -0700
In-Reply-To: <20240802181935.292540-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802181935.292540-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802181935.292540-10-seanjc@google.com>
Subject: [PATCH v2 09/10] KVM: x86: Suppress failures on userspace access to
 advertised, unsupported MSRs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Extend KVM's suppression of failures due to a userspace access to an
unsupported, but advertised as a "to save" MSR to all MSRs, not just those
that happen to reach the default case statements in kvm_get_msr_common()
and kvm_set_msr_common().  KVM's soon-to-be-established ABI is that if an
MSR is advertised to userspace, then userspace is allowed to read the MSR,
and write back the value that was read, i.e. why an MSR is unsupported
doesn't change KVM's ABI.

Practically speaking, this is very nearly a nop, as the only other paths
that return KVM_MSR_RET_UNSUPPORTED are {svm,vmx}_get_feature_msr(), and
it's unlikely, though not impossible, that userspace is using KVM_GET_MSRS
on unsupported MSRs.

The primary goal of moving the suppression to common code is to allow
returning KVM_MSR_RET_UNSUPPORTED as appropriate throughout KVM, without
having to manually handle the "is userspace accessing an advertised"
waiver.  I.e. this will allow formalizing KVM's ABI without incurring a
high maintenance cost.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d0ea6340fba1..ad28f0acc4fa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -512,6 +512,15 @@ static __always_inline int kvm_do_msr_access(struct kvm_vcpu *vcpu, u32 msr,
 	if (ret != KVM_MSR_RET_UNSUPPORTED)
 		return ret;
 
+	/*
+	 * Userspace is allowed to read MSRs, and write '0' to MSRs, that KVM
+	 * reports as to-be-saved, even if an MSR isn't fully supported.
+	 * Simply check that @data is '0', which covers both the write '0' case
+	 * and all reads (in which case @data is zeroed on failure; see above).
+	 */
+	if (host_initiated && !*data && kvm_is_msr_to_save(msr))
+		return 0;
+
 	if (!ignore_msrs) {
 		kvm_debug_ratelimited("unhandled %s: 0x%x data 0x%llx\n",
 				      op, msr, *data);
@@ -4140,14 +4149,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
 
-		/*
-		 * Userspace is allowed to write '0' to MSRs that KVM reports
-		 * as to-be-saved, even if an MSRs isn't fully supported.
-		 */
-		if (msr_info->host_initiated && !data &&
-		    kvm_is_msr_to_save(msr))
-			break;
-
 		return KVM_MSR_RET_UNSUPPORTED;
 	}
 	return 0;
@@ -4499,16 +4500,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
 			return kvm_pmu_get_msr(vcpu, msr_info);
 
-		/*
-		 * Userspace is allowed to read MSRs that KVM reports as
-		 * to-be-saved, even if an MSR isn't fully supported.
-		 */
-		if (msr_info->host_initiated &&
-		    kvm_is_msr_to_save(msr_info->index)) {
-			msr_info->data = 0;
-			break;
-		}
-
 		return KVM_MSR_RET_UNSUPPORTED;
 	}
 	return 0;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


