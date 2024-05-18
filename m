Return-Path: <linux-kernel+bounces-182716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB7B8C8EC7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52335B2175B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65FD33F7;
	Sat, 18 May 2024 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5udJawD"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6728DD5
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990692; cv=none; b=DrWiwf1fH3+LPiIRDVxuc/lS4iUEsgYeUDEFW3O9Wu7cxjZ8quW8TjaVpyOy3LzYUeJk4/wRVoDtc4EA+N6Kw+q8IY1QHAiP+pLx5I17brCr76/29PQJwb4PtBh7Q3wfFxus3y+hRQv+sAX8t3I8M4NApxLu9wtf81lmEjbdvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990692; c=relaxed/simple;
	bh=d+HGE5FKbalq1IyET5esmBeH4ox7PVAkkfHJLMxz3xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HL3GXWTaa7pQH6ewvURBDGtTM1byioPqCxYIRDdn987ZK6FfcOb1v//Kd/xabNaATsreVC0/FC31ZxVK/PQM2LkVzvvgN8tVidTc93F6lJSJbFBm7ZFZZpJ1Jjp76Y5fgLnI62drMAYrRgRUOBUzgEUA55Hj0Cp4k/OkoVdntQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5udJawD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de8b66d59f7so12399627276.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715990690; x=1716595490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gllonWtr/HXeH3HBzo9n0ORhoUvXSPNion6U8aTZ5rc=;
        b=N5udJawDMf7x+Wc0ZtJ4eh90N7pmyDLFo1b5pAMHBK8FgD6X5BUdM637bDySWH55s4
         RnPUCFCFfLkZpAz7JLDAKzb/YAxGpxoqH+PLWrjWmsZlSsB7s4xiXhsAGYA/qM/HQIlb
         qoCmvoABa3T7dtjlRiVbvXPaxs6762Q9D6RUH7WZd/UXfCJoLtWxgGBPPJYetTDA2L02
         /4JoQTO1j2EiHm7FjAfIrRgY7CF8HAIIkYiN72CAKLP5JoP9RxGJKvO488d9si7AJ2Po
         cfQ2ffg9OAJpeyL7rS4+52tjJrW10HwUfqfMOgsDJg2P8HuAFFXNFPO9Ztm01ytZuv3p
         frsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990690; x=1716595490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gllonWtr/HXeH3HBzo9n0ORhoUvXSPNion6U8aTZ5rc=;
        b=EklRq4MrV38Mu2Oyb/GxJ4lg7OFwF8s27TEm62MoqA16+Cp6B94a6hxNJkSyavluyi
         p5vFdV/vWlVYb+NmXuJjzubb0JdnKV5/mFlzZgJvpK9FZDpG/kBUVTCaHWhCvcWmlkDu
         Yw6WDX+o2ZTwD/TOcQKIqM0smCqKkme97QK1kBvZG9Mi2g0KiCrUfUfQNGOU9nUyasFU
         taqCN5b3ygG+zEMOHT9+GfoqDP3jSPB82OCPHA2gJj+T2cQjkLaAxj36B75RHi6HTHbr
         oX7VvkBebT5pZZoViw8YLtUwZiurmBsPbXezc3bgDoeKRqWuaR3GJqX9NB14k4vMTd27
         Z5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUaKFwCJYbZZbcZ+pkRJu+NdDhGJObyeAvWGKbB3KnvyaQZ0NBzSPbym+Hlf+YXXDF6N0emwEIrQSLsVp6oiqjfecU7iUQXbb+nT74C
X-Gm-Message-State: AOJu0YwA22RxTbFXzM1j012q0jKg9wwD5u3Mvq2yrbHDVF2sDecuaeJG
	nUYLDYDfXGk5RBz9WgpKywU666H/ZDNZWgZFdQ7dKuUVVKFBrCGR+rKhrWDowipGXZ9inCKnUcJ
	Usw==
X-Google-Smtp-Source: AGHT+IFAyinQ0ziYwYxNYFhEDBpRzcHlzA15Uvh759ilYWGg6F9fzj5Lm4hz9NDOEEtMykWD/Id/cx5EJhg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2d8f:b0:de5:4b39:ffd0 with SMTP id
 3f1490d57ef6-df49021cfccmr116977276.0.1715990689912; Fri, 17 May 2024
 17:04:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 17:04:28 -0700
In-Reply-To: <20240518000430.1118488-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240518000430.1118488-8-seanjc@google.com>
Subject: [PATCH 7/9] KVM: VMX: Don't kill the VM on an unexpected #VE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Don't terminiate the VM on an unexpected #VE, as it's extremely unlikely
the #VE is fatal to the guest, and even less likely that it presents a
danger to the host.  Simply resume the guest on "failure", as the #VE info
page's BUSY field will prevent converting any more EPT Violations to #VEs
for the vCPU (at least, that's what the BUSY field is supposed to do).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2a3fce61c785..58832aae2248 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5217,14 +5217,14 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 	if (is_invalid_opcode(intr_info))
 		return handle_ud(vcpu);
 
-	if (KVM_BUG_ON(is_ve_fault(intr_info), vcpu->kvm)) {
+	if (WARN_ON_ONCE(is_ve_fault(intr_info))) {
 		struct vmx_ve_information *ve_info = vmx->ve_info;
 
 		WARN_ONCE(ve_info->exit_reason != EXIT_REASON_EPT_VIOLATION,
 			  "Unexpected #VE on VM-Exit reason 0x%x", ve_info->exit_reason);
 		dump_vmcs(vcpu);
 		kvm_mmu_print_sptes(vcpu, ve_info->guest_physical_address, "#VE");
-		return -EIO;
+		return 1;
 	}
 
 	error_code = 0;
-- 
2.45.0.215.g3402c0e53f-goog


