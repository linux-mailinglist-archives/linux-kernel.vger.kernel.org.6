Return-Path: <linux-kernel+bounces-562387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED7FA62524
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B2D19C2AAA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90B19DF4D;
	Sat, 15 Mar 2025 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdiikDAQ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58119C546
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008005; cv=none; b=gIMwf+zHOyeecVsXdoV62ns0vRgqHjMeVCL3dv3KYAeokR7TJa8WQSAgDss+0M/4lIn62Vb9ABPY8fL7paIvEww40APLdhS+mYgPvlXzQFyUTqvrk1w70pH5s6yA7sXUPO3m1TfQi4sWmLyzDclp2Hh5nELuaKU6S0afOi06bJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008005; c=relaxed/simple;
	bh=kyZPgKDP+G4NiFhQkapY7Z40kUAzSIF8X2Em11vw2i8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uHtHq8j3UkwRI2r41hB3gZCgCVkDfIKdw7Oo6Rt+PxE7puxhtTiVGDVCHnrONvKqN8NLB6durDrHlFs4E1juGdVT49meqm+XMArBh6lVKTN4ddClAyPnFx6+OmQJ9uE7SomoreCf4D+mE5mS/LNyK9q6VRKr2FRUsEyPfBeJiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdiikDAQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225505d1ca5so45191445ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742008004; x=1742612804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=G6aJw5/ES1UOfEaKxfAACWN89ZnVy5JuxHZXx05VAEo=;
        b=gdiikDAQmhkZVpccgyQyzXAoXEyPBvXk7uxwtMnsIEoCMG/6J/BXs7ntlpXlvhaXA1
         qQ2LV5Hub8fmwTAxiZrRsS7Mz8b6GrBvz68AtJVzAugBDu0ah73wDHoDEgJ+CapP0m/q
         EGXDQM7H2T47tzcJmExK1A9Dy1gMDJXJm7AhnGDP8O47sqB5Lvj993ozXe4kca2xFmOI
         s6yvHWTJZZd1PmuroBrrlZCg6S08dtxaU7fWrgmxz+ZUGaSFKZN90ThcSj33hQzpLw6X
         lrO6ftmct1pjCMTkIvTNYuTStn+DYlbCrnlyatbV33ODq3YtPYzHRtmIIR49Tkp8ttWZ
         CSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742008004; x=1742612804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6aJw5/ES1UOfEaKxfAACWN89ZnVy5JuxHZXx05VAEo=;
        b=WsLX0/u+cczfe1rRgpeEEZ1FyNv6pG21QG/uQhJI5q41tqx/HXKAeJCXdh6vJnbTYB
         uZpZoak1N5/APIGOISUrTrnOhW5Rq5r/Sc6nO76Zzo7HO1f5veEUCfCRBJhk66UF9IOd
         zHJwOVDorYy8K3qNP3KusZ/ZnCleTiZ4S5vofErgYf1eZoC9gcggSPcnzPjfqYz0046e
         /jXiS4jj+1wcr9t2HRck2VjSTSVS1lkLdRAO64D551QeGcv7P5dibNsV8DCvQ+tTdsxX
         tduhkiCtcqKxoKL0OjIFUw6E9pmJy98xrNa67brvgITs34uArgTnHn8wEPIhz+DhU5W4
         hJ0A==
X-Gm-Message-State: AOJu0YyeIRZhQIO50wbRLoQ6beDrym6nDVRzbel6/kWR1VORJM5RRgBh
	Y9nsfwzWxgfx8EtwTJ5piNJNyGqOEXxaUFDblt38pNMCPkpbwqDYl6oXcg7Tmbbd8pPSCKQnBaw
	fCQ==
X-Google-Smtp-Source: AGHT+IESdoU5JvhAzuOhjydI2CjAPYyqye5HZ3O+0f0UA0gPpp7LXZq02t7B33tZ8tgvi8g0NZmeMCZy9I0=
X-Received: from pjbee15.prod.google.com ([2002:a17:90a:fc4f:b0:2fe:d556:ec6e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e548:b0:223:653e:eb09
 with SMTP id d9443c01a7336-225e0a369c4mr48322735ad.7.1742008004023; Fri, 14
 Mar 2025 20:06:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 20:06:28 -0700
In-Reply-To: <20250315030630.2371712-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250315030630.2371712-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315030630.2371712-8-seanjc@google.com>
Subject: [PATCH 7/8] KVM: VMX: Use arch_xchg() when processing PIR to avoid instrumentation
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Use arch_xchg() when moving IRQs from the PIR to the vIRR, purely to avoid
instrumentation so that KVM is compatible with the needs of posted MSI.
This will allow extracting the core PIR logic to common code and sharing
it between KVM and posted MSI handling.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d7e36faffc72..b65e0f7223fe 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -680,7 +680,7 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 		if (!pir_vals[i])
 			continue;
 
-		pir_vals[i] = xchg(&pir[i], 0);
+		pir_vals[i] = arch_xchg(&pir[i], 0);
 	}
 
 	for (i = vec = 0; i <= 7; i++, vec += 32) {
-- 
2.49.0.rc1.451.g8f38331e32-goog


