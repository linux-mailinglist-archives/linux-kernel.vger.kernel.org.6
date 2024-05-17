Return-Path: <linux-kernel+bounces-182457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F48C8B78
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6586B23F28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7593F1514D0;
	Fri, 17 May 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBIhUSqk"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A614F9E7
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967631; cv=none; b=bDJM9vFBzskdIkLmu39Ie29CNAb/2Eb7Bh4uvE4K6ED+PEEjuD0o5cQr3nfhWNtt+M8B78wtRqG0RksIBSmqSmOjKD2oTETYuYVg6ZdwIuJaJL2WGOE5LSmIu4hCwxoYDfB6JlJyWxO8uH+b+9ThhH0asZEPdl4kaIweMFpncfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967631; c=relaxed/simple;
	bh=PqMqX+3x1bIr4+NpDZ79D9dOt32hT1CsI2jeKQ/B0sY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=olBphvdn155a5Pyo0F8Mun6EtdH2wHOGRxvKPG9jrjoBuG+F459w+qPLceRMcmgXCZdAg6HVKrCCwENbnQM+cc0a5Tr+8oigwGPfTSKb0wElrKRCugzTAExYPKJ6Le9dv3sjs1j8CRcYKfqIx7BjCjwGlVHEYz6hvxcjP4cj6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBIhUSqk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bed763956so176296547b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967629; x=1716572429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsjChn418Ntu+DqBgfF+38S1grz68rrrmXdGJxdDwbw=;
        b=CBIhUSqkPraomd3pjVa4yk+iQncn66btnWYNRT+5j70Sp+n/IIwnW1CTbKWKJ2EeRz
         lnPHY55VZMeyQKJhHydx06AN4N0zRTzeUgp0+sEM4EXCCdyUE0U3RMYGLXA0Sow9WQco
         C2pQ8QjQUlsel7QY5rE0oy/NpFg+yGtxW3fjOicyoLfb9lFiltgs0K0SLWPJJh+fxfog
         wVeSPVer+HmCW7AXx0oF3xtOr0ninVCDvfvACGA781Pus4FjKO3TK1vrVKhIB1WpyOnd
         VR8i27+miivRmSlnA5B6ZNHCR7ne5v537dzTQS3WNE/SwcvWoi826qlkrxv5RBSm3E5u
         HFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967629; x=1716572429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsjChn418Ntu+DqBgfF+38S1grz68rrrmXdGJxdDwbw=;
        b=V4DThl2nrXfepB//46XDHvUsmLi8n7vgZSou0BjWW60y/rjsiOilSfZcCAYIn4Yr2E
         HfFhvNGd8ervwJmTdxuvXraRZgFm1Jcb5c9JWlcwmmuMTpgUMURasvSJ+C3SDvaLlcwT
         wkDP/TMbTwAmFZfUfrkY2cjxBpNvqkLfvhnzdUUY9weklsFYQ7jR94HX/emj/AUr272a
         Buz4HgRIuB6ghCnA2219YNOSAv5KgtiCzNijsyJAy7/IlJqVS5WyBIlIwev8yYOAS9OH
         w81AfLJnWh0IaRNYh4c2nHD7ac8KwI2lpUCGzXyoYrCcptBNl5qe3JtVBFx2tLQscavB
         yjfg==
X-Forwarded-Encrypted: i=1; AJvYcCXn4FENo1uRyzrhPqMl3n7Z/ekMZVYCrBI3Wx3dLFmWVoxWEIow1DH5cZqMK1iSR3JhrpqTG5HsTx7G4hcF2vbpC76dnYEjqB5NqVCH
X-Gm-Message-State: AOJu0YxkBCWP9sXFLQSYCTInQjdpvpEoL1y/iEQiFjHIj8uSwu1TrKg2
	hcSEBHg9xWMJAfySWwdFPpbIxAEElnWKFp8exP5iQ3DVD3M/Pkdx0gLS6+bklsLLkm5v20xq7IN
	cmw==
X-Google-Smtp-Source: AGHT+IGaF8y+uYPG0UJDlFomcWXBxHm5li4snyeKf0G3gnWAnWlp7qIe3VcAPPoE6IEIWlxEe55XR4P/x/Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d590:0:b0:627:6431:caa8 with SMTP id
 00721157ae682-6276431dc58mr16425147b3.3.1715967629479; Fri, 17 May 2024
 10:40:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:01 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-25-seanjc@google.com>
Subject: [PATCH v2 24/49] KVM: x86: #undef SPEC_CTRL_SSBD in cpuid.c to avoid
 macro collisions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Undefine SPEC_CTRL_SSBD, which is #defined by msr-index.h to represent the
enable flag in MSR_IA32_SPEC_CTRL, to avoid issues with the macro being
unpacked into its raw value when passed to KVM's F() macro.  This will
allow using multiple layers of macros in F() and friends, e.g. to harden
against incorrect usage of F().

No functional change intended (cpuid.c doesn't consume SPEC_CTRL_SSBD).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8efffd48cdf1..a16d6e070c11 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -639,6 +639,12 @@ static __always_inline void kvm_cpu_cap_init(u32 leaf, u32 mask)
 	kvm_cpu_caps[leaf] &= raw_cpuid_get(cpuid);
 }
 
+/*
+ * Undefine the MSR bit macro to avoid token concatenation issues when
+ * processing X86_FEATURE_SPEC_CTRL_SSBD.
+ */
+#undef SPEC_CTRL_SSBD
+
 void kvm_set_cpu_caps(void)
 {
 	memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
-- 
2.45.0.215.g3402c0e53f-goog


