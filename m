Return-Path: <linux-kernel+bounces-417366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897D9D530C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FFBB24D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B931E0DB5;
	Thu, 21 Nov 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACTzjQHK"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863CA1E04AC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215219; cv=none; b=QTkdZC12yQhRBdv7K7ljp22iSRDmfELqpqZFcijKODx0Sb9pKQ5tcpfvY1/F/1PhzuvHSgG7oA41HTc37uuaahECoRpXM1TWGJXHm774C0Hz+jwUql/n1vuiHR8yq6rJgu7jW17Xba/zNdaRSk1PNjOA6UHctnXq7bFThwPW0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215219; c=relaxed/simple;
	bh=VnUEvIgOY10j/aE/ufecNYMq79Fqq+mS5k1WDTSCKFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SybPHkQEGsAbZn4UZycrctXlOE0090mDkYrt0aj3fdSnY2Nsn7+PxvRaXr/sz3wHy1dADhzLGlMLy9SHFLE/ahhUnxmbz2VZar0g7dWEU+B95TT6wb9bCcxIjoKnkNeH40ngWrX5+tgiZZX2sxP/IHyFWz//HvHelY9+11DfZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ACTzjQHK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30cf48435fso1968530276.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215216; x=1732820016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AFRU4BWr8SpweEeBBix0zZoy9QkEncA+tQMcSsG2aPs=;
        b=ACTzjQHKDGL++AUqRLNBtmYDz9y5TfwonJSnUUFsHXdKIpFi9gQZcxXoLNXn9XArv/
         W0YjSc5Nvnt+47E2nFUv4m6Cqe6b/F1HxgU92TBSpI9ZhUx1bO4P1SR2Hdm2QQOj177i
         svIn41ihyk/eKtx8n9Ue51nU/5Ic18OiFu5XeWom2G1RJ/8FruQVB4RezAa6G6Wp25Xe
         cb8fJDfUJNP2nmojZdA61CbQ0mfn6z3VispEUXTw826BcO13KTQRANR4jlR4V7qJZWJ2
         mwj8C+mlZKRxCqG07sc/PhuaHKXyPSPTeP/ocs8kzrjZLt6a0P5Q4T0g1qEphwvxrTM1
         b5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215216; x=1732820016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFRU4BWr8SpweEeBBix0zZoy9QkEncA+tQMcSsG2aPs=;
        b=ejVWjPUhA5EIfE/Ndw4SzOfj5opSXzUaUSAJU8Ubb7+Rpr9sdkyfG/jSVTXuWCtq8P
         frd2ICMBK72uMydDAQOTEepZmBBTBDK2oLFYeNTLgZzL3M4mT+jAd05Mr2qKNItKWmj4
         NokrcYLpqWS/GLPL0Jhg+bQCVXowt5Qp9tUBzYvGpo0FqrSajyeb0+xroyuXh1TtzVHw
         g+Z10fl6UU0bP5jxeK6RcalykjDyOkQvKZX86AOhUautBYZxyMDUQtsrja8n2XXC/iri
         p5VgMVRXLxJlHuM5Mx6w0yEZnL4mowPL8j3GNcS+GW0RweEVGnp14b8hXZep/4UlXA99
         hPbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgmLnh+mLWdsil27wHthi+NKbPflWY0sc5uTV9NOEcV3uMYnQqIvRp/xJToiKY/WIjySnl/bCH2TGWmX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7NVQKOsa7r97tu5Lp2k4iscc6Y7mksKAuWWx3h4t3jqGYUYz
	WkbgcDD4TlioAoZtbKuS2yR0xbkVSlXF+4sJK9/9vcW0XAuCj8SqADdw7fFEdCNYxnJPRmPVSeT
	auqKD0w==
X-Google-Smtp-Source: AGHT+IG5NTyhfTOvOMtguS2XrmwrQUHPkXMhoswbbltJbsHj7nG8Hf9HsNhFgPZx0QThUafRc4jHGvqlK4Je
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a5b:f51:0:b0:e28:e97f:538d with SMTP id
 3f1490d57ef6-e38cb5d9aa0mr3198276.6.1732215216510; Thu, 21 Nov 2024 10:53:36
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:53:03 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-12-mizhang@google.com>
Subject: [RFC PATCH 11/22] KVM: x86: Initialize guest [am]perf at vcpu power-on
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

The guest's IA32_APERF and IA32_MPERF MSRs start at zero. However,
IA32_MPERF should be incremented whenever the vCPU is in C0, just as
the host's IA32_MPERF MSR is incremented by hardware.

Record the host TSC at vcpu_reset() to start tracking time spent in C0.
Later patches will add the host TSC delta to the guest's stored IA32_MPERF
value at appropriate points.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/kvm_host.h | 9 +++++++++
 arch/x86/kvm/x86.c              | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 04ef56d10cbb1..067e6ec7f7e9c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -738,6 +738,13 @@ struct kvm_queued_exception {
 	bool has_payload;
 };
 
+struct kvm_vcpu_aperfmperf {
+	u64 guest_aperf;
+	u64 guest_mperf;
+	u64 host_tsc;
+	bool loaded_while_running;
+};
+
 struct kvm_vcpu_arch {
 	/*
 	 * rip and regs accesses must go through
@@ -1040,6 +1047,8 @@ struct kvm_vcpu_arch {
 #if IS_ENABLED(CONFIG_HYPERV)
 	hpa_t hv_root_tdp;
 #endif
+
+	struct kvm_vcpu_aperfmperf aperfmperf;
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3c6b0ca91e5f5..d66cccff13347 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12476,6 +12476,13 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 		__kvm_set_xcr(vcpu, 0, XFEATURE_MASK_FP);
 		__kvm_set_msr(vcpu, MSR_IA32_XSS, 0, true);
+
+		/*
+		 * IA32_MPERF should start running now. Record the host TSC
+		 * so that we can add the host TSC delta the next time that
+		 * we load the guest [am]perf values into the hardware MSRs.
+		 */
+		vcpu->arch.aperfmperf.host_tsc = rdtsc();
 	}
 
 	/* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */
-- 
2.47.0.371.ga323438b13-goog


