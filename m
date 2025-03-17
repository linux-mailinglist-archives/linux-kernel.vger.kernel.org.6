Return-Path: <linux-kernel+bounces-564792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35399A65ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E991889349
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7D71A0BCD;
	Mon, 17 Mar 2025 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7OMJy2i"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311FAA48
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232518; cv=none; b=HhCu/PPKvDXh+ietPh7y5Cf+alJeZEoUE2PycLZu5/3u7ESFMu/u1v76HFJ5ZBhRqf1JX/K4y/G14mcfbjrLxwkNkfgZVEAaDT9hOYznVv6wMPwXL4YIsfueeLLEcNoRjECGDrJpVS1KNVuE9jMtCQNQAm7hdBKPvrlB4rXWIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232518; c=relaxed/simple;
	bh=n1HtH0CH+ItuYcREfDLanVJtBgzilNRkaXyx6UAvirM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h7zRB9EjAFjDKzM8Z6Ol8H0YMGLbUMMKnL3XjQCkrcyQGZcHefjhdEg+KUA4CJbRXE3Ti2Fz1j9xYgypRoIOce2PpOKNnQETJwE6fIfswk+TX5KALvjVn/dkPGnlYEG5gYxODuMynkDdlw6RQrEW6ncrySp5zM91IB8xaZ8OPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7OMJy2i; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3011cfa31f6so3610035a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742232516; x=1742837316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BX7bVuSKahRyPKb9YA83comeFxklFZtwaF75tpX/Pg=;
        b=D7OMJy2iJMi4l35L2r7FIuG12nYLjmqPy8uT/oHG0iLBNNrDIGFugUdLMNV0GyGhRe
         DSLrn/tF7/sxdvbQXe8+GJZn89f8aIqMmgceawGNb7v+Mlk636HjVZ3MzSTJsaFBK/zl
         tPKKVYOeCftirv1PcC2GGrEjLGVCelhYg1uIois3GKgXETnuAuHU9LADThG60UnA6bOb
         xCDsNujaKrZT6lANVHbzAVDgoIGCmckDhzSv71q+vplG7nUvdWa0FQCI/9Aw8oph7EtP
         tIqIpgsUNACdvhj097qtKHWvb6mhZ/AaBW3xqtdWdFU0qH+6o1ae97dEWA77aLpri+cA
         l3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232516; x=1742837316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BX7bVuSKahRyPKb9YA83comeFxklFZtwaF75tpX/Pg=;
        b=Kpznf/0o2Gp47JC8OYko+eAZVEPfG1lFX4WYQOzRC00OKsM2HatLkjFPedgfRQSBui
         EdkX7ClAYyVrPI4BO1jdYD2FXZQPaU545c5ciUC84pUXUXFsnJD/ZBnrV3Mt77KAmW8K
         L3e1SdlyHWQ1q1uO0P4sYmXQMPIpdLEh63L5HCAv6VWQjOBdM3zlA/d341FqfVuY0igh
         w9Z0GUxBcAlBYCJZQofxbtvt2JjvW4jwkLrc6LiTr7oMLbWHhTtJyWPEkFDWIPZFnj5O
         m6hMLBMqxBk9j9DPJMi/8q3Lz4vXY3Mw8n23TLzyPHSjcWpo8654UTkpe+jcnc/bsFPW
         dggw==
X-Forwarded-Encrypted: i=1; AJvYcCWBiW5s+yqG5GA/GNMZy/1vU/0jGo9Uio2YY1TeB2evh7TGgIn4gGDZf3s64L0BdFS7jRTM2/KGgG13bmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDz04q5rKNqLiqZCnf+aOmCbmXX1qmSTQWEs7QoKKFmBMNhskW
	fFh1sX62PEuTGCeXN/UVmo/oAcrkAx4dNJ7q75Dyg6IZy6iAzp4uFHNp+08FzD43yi+Gra8mU9y
	PZg==
X-Google-Smtp-Source: AGHT+IG8HqXW25R2SEcblihnltUxnDotlqWu3JGVurlbYqgtjNjgC2Oe+rqDw4Lug+IJBnWfx4OHQTfY+Zc=
X-Received: from pjbsy7.prod.google.com ([2002:a17:90b:2d07:b0:2ff:6945:bce8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b46:b0:2ea:3f34:f18f
 with SMTP id 98e67ed59e1d1-30151ca0bf3mr15217984a91.19.1742232516460; Mon, 17
 Mar 2025 10:28:36 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:28:34 -0700
In-Reply-To: <48899db8-c506-b4d1-06cd-6ba9041437f7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6053e8eba1456e4c1bf667f38cc20a0ea05bc72c.1742232014.git.thomas.lendacky@amd.com>
 <48899db8-c506-b4d1-06cd-6ba9041437f7@amd.com>
Message-ID: <Z9hbwkqwDKlyPsqv@google.com>
Subject: Re: [PATCH] KVM: SVM: Fix SNP AP destroy race with VMRUN
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 17, 2025, Tom Lendacky wrote:
> On 3/17/25 12:20, Tom Lendacky wrote:
> > An AP destroy request for a target vCPU is typically followed by an
> > RMPADJUST to remove the VMSA attribute from the page currently being
> > used as the VMSA for the target vCPU. This can result in a vCPU that
> > is about to VMRUN to exit with #VMEXIT_INVALID.
> > 
> > This usually does not happen as APs are typically sitting in HLT when
> > being destroyed and therefore the vCPU thread is not running at the time.
> > However, if HLT is allowed inside the VM, then the vCPU could be about to
> > VMRUN when the VMSA attribute is removed from the VMSA page, resulting in
> > a #VMEXIT_INVALID when the vCPU actually issues the VMRUN and causing the
> > guest to crash. An RMPADJUST against an in-use (already running) VMSA
> > results in a #NPF for the vCPU issuing the RMPADJUST, so the VMSA
> > attribute cannot be changed until the VMRUN for target vCPU exits. The
> > Qemu command line option '-overcommit cpu-pm=on' is an example of allowing
> > HLT inside the guest.
> > 
> > Use kvm_test_request() to ensure that the target vCPU sees the AP destroy
> > request before returning to the initiating vCPU.
> > 
> > Fixes: e366f92ea99e ("KVM: SEV: Support SEV-SNP AP Creation NAE event")
> > Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Sean,
> 
> If you're ok with this approach for the fix, this patch may need to be
> adjusted given your series around AP creation fixes, unless you want to
> put this as an early patch in your series. Let me know what you'd like
> to do.

This is unsafe as it requires userspace to do KVM_RUN _and_ for the vCPU to get
far enough along to consume the request.

Very off-the-cuff, but I assume KVM_REQ_UPDATE_PROTECTED_GUEST_STATE just needs
to be annotated with KVM_REQUEST_WAIT.

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 04e6c5604bc3..67abfe97c600 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -124,7 +124,8 @@
        KVM_ARCH_REQ_FLAGS(31, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_HV_TLB_FLUSH \
        KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
-#define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE   KVM_ARCH_REQ(34)
+#define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE \
+       KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT)
 
 #define CR0_RESERVED_BITS                                               \
        (~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \



