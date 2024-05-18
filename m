Return-Path: <linux-kernel+bounces-182711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A8E8C8EBE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B037D1F22483
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944D7D529;
	Sat, 18 May 2024 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="102onJoX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF66AD7
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990682; cv=none; b=uRsUTLswFJZ/YaqY/wyD8zLcCH32qN/bECmhjtw6oqhgZev9FGtKZSicklLYcNCtopcea4ybQTy5m/x1Uq+uOiTfll6xC8kcRshBGPcoS7W6ORkuV+Z1F4bRASgkRnQNAUpnwU5rqCTGDoGaNuBbj8TzxBzPrnJ9OTdmN+qF5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990682; c=relaxed/simple;
	bh=ZZiN6+e15dQN6MMssxaWW8K/IugjsD8kYnxv2JER8Sw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bkl15FkvvTHOZVur9195o5Ren7dECcDKcXMsI/IVJ5GlCLpch3JbmXvXQxv6JetujfOV60CxeVrgUsgBfnZcpB9NuDnPHpkUzdkt80XWu5elw+vsXtoGn+cvbbzDfGTnCA7foFCb82YEOruMIlakPmmx5dXe0OuLx7xDMRjmGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=102onJoX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be23bb01aso205246297b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715990679; x=1716595479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=55Fpx2MIulH1TJ9s55duhi3yhB4vtlMWdhuL3vC3xBQ=;
        b=102onJoXcHKtnZIhIvcFD1NxbGYQaWUDYwUBOb5zjT1Twet3+CU98Ozq1ygilfSclm
         jQDpux1E4rmrG/gGDfrDilnBq5eKZIDze3qjoEl+DhEWMVCMcDAr10IIwIyF8GF9qnym
         kNZ282emV3bX/dsjxsY8mg0QcuSBfpl+gYKVMa9igy1P6WiOCqfeiL5UoDcZ8JGvLnk5
         2grc237SlimHtbE4VJtygDVbWF72+4G3rx83003OVjI5XVwe1xPBIZ27hgTNwacnWW+p
         j9fGSgJBc9fXyvQb+6Sd7T2q3LHl7CaxlJKCXjDEtshat1K96p1gHRb5j34y0zSGYE8c
         juJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990679; x=1716595479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55Fpx2MIulH1TJ9s55duhi3yhB4vtlMWdhuL3vC3xBQ=;
        b=wW4dS/YvOwjqnqFTh8m/HOuJgsTUVrd+aKh2d1z4eAYIWWyL6PCcUce+Dh+jhsjx4B
         YnrY+6QqLzmCYc0OzojUItdNJYxBQpwp/U5h0XW1MmbLX3P5vs3Gf4/indu0nKowkxuX
         M+FcKYUriAZRwfPd8nE01nstkMuqkoBcmXI+bC6/sPoveE1TemXzwkD0gObEqg8x911i
         8lUfTOKJY3lu0YCtFGC4ueENtzKQJxeSmKfkviZAPaKKCnTf3QT6zDRsWRwcIKhi6rHS
         zfteAmYWUs0CaEWtiHJlNXa0JdRO7timoBpBJCFxU+hTmp5zZQC2DMl/3JhSuFeXTOyt
         B4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1qRNFW1JDSPn9gE1axs0eKKpRbRoyFTSBJGSyVteUI5cz7OppNg3GqzM+5sMLUzRrrv7oQd8XSM4+4MrdU1x7PX611Jy5haIe9fAb
X-Gm-Message-State: AOJu0YwvrhsAgLYJAg2chq//Thx42PRm7KKvX7q0xO0lFWf8/an1z89P
	Ep5dhtuw9gk2mtpkoqwLmjo8nKtTdEmVVuocw4OTpPFBlDQYxxkR4+71ArL/XHsI78nWkEfPxT7
	cdw==
X-Google-Smtp-Source: AGHT+IFiVlGymQzpow3h8j4sNOJKTfw4H5KxXwAelQPEmYeQwtXrj3JO1q9+VPmJJ7oNI5OfSrZMzmiPyrA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:338c:b0:61b:ea08:111f with SMTP id
 00721157ae682-622aff9d4cdmr58113437b3.6.1715990679473; Fri, 17 May 2024
 17:04:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 17:04:23 -0700
In-Reply-To: <20240518000430.1118488-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240518000430.1118488-3-seanjc@google.com>
Subject: [PATCH 2/9] KVM: nVMX: Initialize #VE info page for vmcs02 when
 proving #VE support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Point vmcs02.VE_INFORMATION_ADDRESS at the vCPU's #VE info page when
initializing vmcs02, otherwise KVM will run L2 with EPT Violation #VE
enabled and a VE info address pointing at pfn 0.

Fixes: 8131cf5b4fd8 ("KVM: VMX: Introduce test mode related to EPT violation VE")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index d5b832126e34..6798fadaa335 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2242,6 +2242,9 @@ static void prepare_vmcs02_constant_state(struct vcpu_vmx *vmx)
 		vmcs_write64(EPT_POINTER,
 			     construct_eptp(&vmx->vcpu, 0, PT64_ROOT_4LEVEL));
 
+	if (vmx->ve_info)
+		vmcs_write64(VE_INFORMATION_ADDRESS, __pa(vmx->ve_info));
+
 	/* All VMFUNCs are currently emulated through L0 vmexits.  */
 	if (cpu_has_vmx_vmfunc())
 		vmcs_write64(VM_FUNCTION_CONTROL, 0);
-- 
2.45.0.215.g3402c0e53f-goog


