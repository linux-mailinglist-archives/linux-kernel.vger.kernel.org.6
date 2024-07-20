Return-Path: <linux-kernel+bounces-257742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC37A937E5A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D301F25765
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC97146A96;
	Sat, 20 Jul 2024 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prD03J7k"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B412BF02
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433711; cv=none; b=fqIYdbwLzNxkG+KMvFzYLKqo8XO/lLz3sjkfbn87f5izvmCcrRYMuOfMXN2RGzDyChUdYgtSe9SMFZY3ECEMnAveuC+XbUGYOsBNiDI3M4GzLwWGk6ML3VRicYF8FpMFvrRvApHAPftxFLLYNkI4Ah2IKPNBo2nFrKkXYZAQLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433711; c=relaxed/simple;
	bh=NpPButGwFDSYrLorKe8iH3ljuXBaeaiLkK5vQ21zXqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yi35pCGCWlkF/rPhNLwqfLPyd5nTcFIHLIXbVS6SEKbHX+8SOT6dJ8PLcCD/wFGzBZMKwLHiEnyL2HKiEipxko93c8JNeMz5wALjX0zURrISyrJz9IIpxTuG2IHHO5JVdm6t8vklGqYmNe1nLCaYnnfdbmnIUW21ZFEJHmLwPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prD03J7k; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-649731dd35bso2280004a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 17:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433710; x=1722038510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq2xg9NVZTZ/gCE3mn/xVWeIQnPrQ6LUdOw/VjX+ck4=;
        b=prD03J7krQ/xdGunx4yHKufmVdNw6dNQOsUMYf+lHtLU/0p651AgVeHMOURrm/ExgO
         dzHvaTRBEFwnocnV/k1RSLy93WO8gJA3GEfDq+2+FR+ZVvUYAjbmB1tV6TZ+QLe/3WGA
         kJhZivjNRoLWgvuTqZV9gXHzCvQoyx3LHLY4wPr4swe22UFF87DoWvExx2iwwy1RwoEM
         0nuPaIc5rprgIXreaiRwD65lXX3s3ZPHZi7YY132at3MPosTfNfagrCp8RfUp2sLVs7O
         088t1hosl+qc53a3jeMzrFqcCP3p2hYOUdmVLJZ58Lll7rVq5aYZmoNrAt+9TAenii3H
         hgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433710; x=1722038510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq2xg9NVZTZ/gCE3mn/xVWeIQnPrQ6LUdOw/VjX+ck4=;
        b=HOgOpKHw+IFQ0JNTZbPKiJaRDxwoMA0Qh0vgkCAaGXoUHZxrJyon0byAt4bbwrIapN
         cU3lHTh6/turTJzojAL/XO2G2BBevlbNMUSi7lQQncUTLoQKdAkxW1vMrJUiC4Oyxah+
         hIBgKyL4SeZrAfLX7nVOKBd/pJzi+b5UrybDRKPCQ+KdwiKgU0lJhtMH+IzKkbGcGsm9
         8Z9SKTzmKp5kH/uezvRpsEfiNhTrLsE1Z02pHSs6STJ78X37mldRF9B8/sSivX46fKnR
         s3YwcfqUoMvK/B6ff5t/At6uaXRvU91eEwjxMp77Zb1FktSnu/EgySDbrPx+du1/3DwW
         j8kA==
X-Forwarded-Encrypted: i=1; AJvYcCVp0OkeaSG9z27Up67R2VqxcMwjumgSSKfpx9gsBql3cpe9w141au3XaL7bHfmvmkxCyLcSyexgiEeJdj9sLp42X9Vf8bfOIRsnJ5oJ
X-Gm-Message-State: AOJu0Yx8Uv/dvRSK1WH2RHa17xsxhpqpXnrABH8ijrNTSnLKm+Uas/h5
	URuqU7X1acaAT0T0rgHr1mr2Eb5UmEf7g3Ut/WxZbALbiFrC9voF9kdO8hsL2CXT29uWm6daQxA
	a1Q==
X-Google-Smtp-Source: AGHT+IELR11zvr+k5NZltD7ajnFqM1nKVjvphuk/ZGPqsRsgEqciHJSU9H9jGjr6wO9UTObuyYHtjLnArFo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:f454:0:b0:71a:e413:b0ef with SMTP id
 41be03b00d2f7-79f9da0db86mr3785a12.3.1721433709702; Fri, 19 Jul 2024 17:01:49
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 17:01:37 -0700
In-Reply-To: <20240720000138.3027780-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240720000138.3027780-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240720000138.3027780-6-seanjc@google.com>
Subject: [PATCH 5/6] KVM: nVMX: Explicitly invalidate posted_intr_nv if PI is
 disabled at VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly set posted_intr_nv to -1 when emulating nested VM-Enter and
posted interrupts are disabled to make it clear that posted_intr_nv is
valid if and only if nested posted interrupts are enabled, and as a cheap
way to harden against KVM bugs.

Note, KVM initializes posted_intr_nv to -1 at vCPU creation and when
resets it to -1 when unloading vmcs12 and/or leaving nested mode, i.e.
this is not a bug fix (or at least, it's not intended to be a bug fix).

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7e0a944088eb..40cf4839ca47 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2317,10 +2317,12 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 
 	/* Posted interrupts setting is only taken from vmcs12.  */
 	vmx->nested.pi_pending = false;
-	if (nested_cpu_has_posted_intr(vmcs12))
+	if (nested_cpu_has_posted_intr(vmcs12)) {
 		vmx->nested.posted_intr_nv = vmcs12->posted_intr_nv;
-	else
+	} else {
+		vmx->nested.posted_intr_nv = -1;
 		exec_control &= ~PIN_BASED_POSTED_INTR;
+	}
 	pin_controls_set(vmx, exec_control);
 
 	/*
-- 
2.45.2.1089.g2a221341d9-goog


