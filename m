Return-Path: <linux-kernel+bounces-417363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7929D5302
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372DCB22E73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49D1DFE23;
	Thu, 21 Nov 2024 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6Wb3y92"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618831DF99F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215214; cv=none; b=KEX2HM4H4jHU/xVFNPzDK/5IWB6n0PjnKZwn+KQwUNiqQtGQ2CsULIvkn/2RckPoZgOXnknWRSgoroC+EU1d+VBc/+23lW3GfJy3ODOeSUAsJgzJnPAJSkXCk1nCRloR7OUJlxOfKzotuT3QfUIt8Q6BXkjVPADPzgevaWD3Z+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215214; c=relaxed/simple;
	bh=AdrfMvymD5zuRqTBBGGoWNJ0DY8WVGxpVB1lhy6aBew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rj9dWUkcHKpEdyghyXGjR36eEQHyH1i3kzcsu8Cugfwau9J3eR4yyfyPmzcf2dURGBJKymdakoPMtDyO5XyF6gmOJ/ebutK7QVTfCEMEEibf39nsjn6W/XVnRtVCVzlj7MPI+XdXM7lRMkKK5u9kT7phuvs1pAciM1ZYd4qn1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c6Wb3y92; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eebd4e7cc5so14915757b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215211; x=1732820011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=w7D09IdaThZ8r32cYXtPxjnC2nPk7QEMmJJMfReh37c=;
        b=c6Wb3y92jN9o1wPhx1H+KZtjUhOaBjvDEfYVw+FCK3DHZdtS6/wyXVHkn1aWAbJoQ2
         R1pkXJaSF5eibHaUkPoqxUKHZG/cqM13vXaDgvodrGHxiywJKY/NSVA0YNQ6a+cOh1kX
         RgHGXskBmN0IqFYn0xFDxZVFplviQmfREwjmAweHplMDxCDWjnGsIpRubdCLnEeAeKZ+
         ttEeYWv+dA0CRLP7DrOKbfN7TCvDdI0H7iEbGFMTO4yxqqyqcemDkD8P9Kzg3/9DNCwA
         T7J8MX5oaA2r5QoZjSE3Fy9nJsZ6oaCUtQP7EbQGheA8e1DCPGfnWzqsCdlQyMaCsoPj
         qgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215211; x=1732820011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7D09IdaThZ8r32cYXtPxjnC2nPk7QEMmJJMfReh37c=;
        b=NPnA0QmZ/l/o1+XPW7vcKgxKT8dtpK9DZfMvTYTdpeUGK5xc4Pe/OVFVUm2rd+okd4
         26NmLulnG6a1RMhmQ+NNVwMi6nv4Sq2UkufYAmWM02J/TQNVkTwRTlERPqjihkQjnTID
         /9pbpHfBJYr3gDFSFZjhw4aygBUORmOy4ktmyiXMsE3beLhef6oloWH9fh68kTbXtTU/
         ZxdLQZk2tGvP2YOohWXnTMQLAohL44eOfoBOUXpmL26YV63Hf20CpbFTt1s2R0BLNqUV
         lWNJYmnf7K38f01JOHgnPA2uy2QyuKflDDJWaVs8amIxqnKR49KMGDMbS+BrEwbmsSao
         F5XA==
X-Forwarded-Encrypted: i=1; AJvYcCVBlVVsAFL4HUAcmYrlpoaPIlwzWNNtEKTqi+PBwKejLJsJGxEhpS5y8skf6ALRdrr52r/he1zjHTbYovY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoF3ydw62kicFdNKbmo1n66lgaWqho33cbPrKzzn1F6CSH92V
	U+4Jsj436L/xySf+rhxysumrla5/9At7z7CMEVBV4OZmtby3s+DQV13iOmuGvP8Fc2+3xe7jmqZ
	Q0fm5tw==
X-Google-Smtp-Source: AGHT+IFbxnZIDPmwz4a6QDx5WTc3XPCOUOGBb+6SCxkWJJgfTYLxgm8qVWZQaaUmH8BKA4bQqcQX6mWx6Kh8
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a81:a742:0:b0:6ee:a2b0:a803 with SMTP id
 00721157ae682-6eecd2b215emr527187b3.1.1732215211264; Thu, 21 Nov 2024
 10:53:31 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:53:00 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-9-mizhang@google.com>
Subject: [RFC PATCH 08/22] KVM: nVMX: Nested VM-exit may transition from
 HALTED to RUNNABLE
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

When a halted vCPU is awakened by a nested event, it might have been
the target of a previous KVM_HC_KICK_CPU hypercall, in which case
pv_unhalted would be set. This flag should be cleared before the next
HLT instruction, as kvm_vcpu_has_events() would otherwise return true
and prevent the vCPU from entering the halt state.

Use kvm_vcpu_make_runnable() to ensure consistent handling of the
HALTED to RUNNABLE state transition.

Fixes: b6b8a1451fc4 ("KVM: nVMX: Rework interception of IRQs and NMIs")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 931a7361c30f2..202eacfd87036 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5048,7 +5048,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		vmx->nested.need_vmcs12_to_shadow_sync = true;
 
 	/* in case we halted in L2 */
-	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
+	kvm_vcpu_make_runnable(vcpu);
 
 	if (likely(!vmx->fail)) {
 		if (vm_exit_reason != -1)
-- 
2.47.0.371.ga323438b13-goog


