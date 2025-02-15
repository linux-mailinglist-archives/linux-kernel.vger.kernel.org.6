Return-Path: <linux-kernel+bounces-515945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310FEA36AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6BF16AE5B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637AC144304;
	Sat, 15 Feb 2025 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKqYx03f"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD274E09
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582083; cv=none; b=jQ9p9uNmk+XM6qd5dOPB8vxCf53+oDY7HkiHmRNIjCUvCX6VqEJJbsPRe7PKfvBvcfAlUlxmZprC6zoR8/Z9q56OOxX80fgFVZqMTVwuhIF6WVqvbZFfHaV8H4y01Uu3UQY0sPxC1SbdmDw3hI2JueZs3cCLhOcUt9GFMO3MyA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582083; c=relaxed/simple;
	bh=5xz8jYzPHf6amN47H298De5D9Y9tv1lp18wh8jahuOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9d0pVo3l9NXK21docJh4slgN+IkDlis0IrQaoLjh9wKXuIGSPfqT3RVWwTv3lXggX3AKcZL2bNu1QoV8AjlpQTJed2CpHU97JbYpNWHa0CQB8+sxm0PPORtm8bmjhaquzTw3fOlKbrc5+zbkx1A6I4C2FxRRNF8IuKZCtVQLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKqYx03f; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220fff23644so14695015ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739582081; x=1740186881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GLdih/SuzIjNw6oPbBJsSyQpCg9vqoYPBoF6JqvqcU0=;
        b=fKqYx03fSRk0KWaQ0vKK7pE93MNuapj66D+iGOq9iN7aAHeo1HTdZ7zbMt3qOIik6H
         tmNi648gvc79IIwK7mZy45a4delXqJOnLrGiEfyhR8CHNDzUa4csuDb91tKA7LcnkIBB
         EQXBPvwtVcO5Q8Lxs+B2MziexU1wJVEhz2PgjL7jUyMElY3Zggrm+Jzjy/9zbStYmruP
         DcjgH7jE/FlB1RhIHbQTsZN5KxFJ26AbVqWcxdChDh2TFc5X6CnNeKy4MHHeiXlsTorw
         GVuBXr+fX1RFCHE4TmOxy/pVmDiwK7hSVkMOtpIER9XY3xWgdvImUFvLlH5opkfQarXA
         K08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739582081; x=1740186881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLdih/SuzIjNw6oPbBJsSyQpCg9vqoYPBoF6JqvqcU0=;
        b=BDrBT/knBiVw48t2flhkRHeX5XaOJFVJwfnGISzkbaKgWNege7Y6KVn/7FP1xaK+AE
         /AQgBQ/kz90kO5t9f0IuIzn5V18D3/vznWZvxMt8WD5L+MlXybQyWmzAi34NJ8v2hXF7
         N5CaPkEr4bh/y/U0buvRgKzycF0kOud0WMbVvViKn9yRHCZ7urFlKnhHP/5vkK6hwvWY
         95qOcN6lK5PmO/bBKSF0Ku4URsSfDJDONcYuMughxnmPk/ipzGYolapSVEIkuP1JgrZy
         N5UAQACFzcJ+hePLZ/ZsgdU/ULZYLxLsdPSsKkf2+I4FaDceKM0qZVf1CgzUx0RMxpvh
         rzAA==
X-Forwarded-Encrypted: i=1; AJvYcCWXJthcqyLyV8snUD34QDZqciXIKtTlyccHTIxTSoaXMH9rJeLmdL7BW6zLJWr97Vh2WBrdxwY4meJKwV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxd4/w+ubLG2JWcAk58c7zv672uS3wE9Pl4goCdhi5D9YdlWv5
	02EG3BUAHTHWH3lCpTFnaf3cGIM8z4jxQPzV+CKbc3DWIxLeSFvvYLS0cN1CeufXLzk2KVUf0IR
	THg==
X-Google-Smtp-Source: AGHT+IFZUvzAbZYpqr2AjgrHoxhevdhJ9HY2uplUSiVhOtxQe9AbMED3arOME3GI3dmwMldwaM//5r5OIG4=
X-Received: from pfbgb10.prod.google.com ([2002:a05:6a00:628a:b0:731:9461:420e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a91:b0:1ee:40e2:8f51
 with SMTP id adf61e73a8af0-1ee8cc4c56dmr2573341637.42.1739582081022; Fri, 14
 Feb 2025 17:14:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:14:33 -0800
In-Reply-To: <20250215011437.1203084-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215011437.1203084-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215011437.1203084-2-seanjc@google.com>
Subject: [PATCH v2 1/5] KVM: x86/xen: Restrict hypercall MSR to unofficial
 synthetic range
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joao Martins <joao.m.martins@oracle.com>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Reject userspace attempts to set the Xen hypercall page MSR to an index
outside of the "standard" virtualization range [0x40000000, 0x4fffffff],
as KVM is not equipped to handle collisions with real MSRs, e.g. KVM
doesn't update MSR interception, conflicts with VMCS/VMCB fields, special
case writes in KVM, etc.

While the MSR index isn't strictly ABI, i.e. can theoretically float to
any value, in practice no known VMM sets the MSR index to anything other
than 0x40000000 or 0x40000200.

Cc: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/uapi/asm/kvm.h | 3 +++
 arch/x86/kvm/xen.c              | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 9e75da97bce0..460306b35a4b 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -559,6 +559,9 @@ struct kvm_x86_mce {
 #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)
 #define KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA	(1 << 8)
 
+#define KVM_XEN_MSR_MIN_INDEX			0x40000000u
+#define KVM_XEN_MSR_MAX_INDEX			0x4fffffffu
+
 struct kvm_xen_hvm_config {
 	__u32 flags;
 	__u32 msr;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index a909b817b9c0..5b94825001a7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1324,6 +1324,15 @@ int kvm_xen_hvm_config(struct kvm *kvm, struct kvm_xen_hvm_config *xhc)
 	     xhc->blob_size_32 || xhc->blob_size_64))
 		return -EINVAL;
 
+	/*
+	 * Restrict the MSR to the range that is unofficially reserved for
+	 * synthetic, virtualization-defined MSRs, e.g. to prevent confusing
+	 * KVM by colliding with a real MSR that requires special handling.
+	 */
+	if (xhc->msr &&
+	    (xhc->msr < KVM_XEN_MSR_MIN_INDEX || xhc->msr > KVM_XEN_MSR_MAX_INDEX))
+		return -EINVAL;
+
 	mutex_lock(&kvm->arch.xen.xen_lock);
 
 	if (xhc->msr && !kvm->arch.xen_hvm_config.msr)
-- 
2.48.1.601.g30ceb7b040-goog


