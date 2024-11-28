Return-Path: <linux-kernel+bounces-424072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA189DB059
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEE5B21536
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1543945C14;
	Thu, 28 Nov 2024 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRbohuJA"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B922615
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732754634; cv=none; b=btcjDpURjtY6NRsjck4gACgo2tfKO4p11Rz2wYc7sC53jmIggHrZHBiHpK3pqciI8cHEmeCHRHOm7qOlNo5UXie2asPQSSP9K3befSBOzLuBaMa3e8PFkT9T5s1IUomQxBfbBzj7PWZ+1plzfcB2D6ssNGKpsQWoVqrdpsRY4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732754634; c=relaxed/simple;
	bh=jyPX3MdAUnX1bDy5TiI1V6ZoW1meXejrHFasqL8eDK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RG6doMLeEt/WeYYip9mzQznH6vhkm04n3Pz6PO22zQN51yXq8O2/aTOTnI8ZdzllKTislwPg4Zsw1XdvKlVM+4+sc+aoHjpB7U23klhzqDPoDIuyaNIRE/bVwOMPWPhHs6u4uqCo5qmuOs6/8BaFVdRQiIHAtApyZBtl+DU8wcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRbohuJA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee0c9962daso311236a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732754632; x=1733359432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1w6JVsg4OUo1AnaxThquyWJswnSGtvGXHMhG9ntSUjE=;
        b=LRbohuJAneS6Fzwyo0Nu1qq3tkK9wU4TjGm/exnwHhou4HP0qz9ZFla55/i07tyYm0
         TlueK+Uk8TDzc9+KfSvPEs3vi+tnaa1jSWLw33uhrBHngTEnQutuPbYrnV50SlOBNfcp
         aH05IDaep7q9HEE84f0Z2fPgtvY0BzBo1XLza0Rpu7yNgQn3lYFmUiBAyluZWXdgI6M3
         uQwDmlvxVqRniicympzZmF0roTylHiFgvy90VFHSUzq6/pM2vbLlEXXyhUOj4+hpHMfV
         nHsCgtgz7St2OdhdD3x+Hd3PaBmZ2OXQqoRZ3lQEcRgkibYVavk8ZOsx+VI/b6vM0Ow1
         55hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732754632; x=1733359432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w6JVsg4OUo1AnaxThquyWJswnSGtvGXHMhG9ntSUjE=;
        b=Wlx8Cbs/qDvDS5zQX3Cu3C1KYdXkpPBLz3YnkZzfUMvLCqdvFlqjM8C7qOwZCjrgxT
         Ht+AF6qbVcbJCx6NaQfghmjqqvsSn6FAMahdtMAvY1yyyMq1u0cy9Ip58HE90Ssv28vj
         Dq+Pv4Rpz3u5YG0WSudic165N0vxD7aequK0g7mEMxf4UmWjJvRtu2rMK/gaDW4opoIG
         CB+oKuHVYNFGC9GDNj4EKfHGomSclz5JnFHGi3XaUNHzDfm5THpTE+2wuSyQkVy9/y3N
         OsZgsV8EO2Uy3skoeCkvhUzwNGqIIxpHIFd70ZE618wgFPjlr9BkR2TWoN7I7pwR0Vgc
         +mEw==
X-Forwarded-Encrypted: i=1; AJvYcCVyK3BLxIT0ZrmVe20kHmd9qJa6IObRdrqXyo/1PqmNY4XvJNoaNXeEpQQwic9201Mx8fwloPojL856YGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoqmh9bpaDDhh1PZO+mLsQ3a8zhkqa2oMLZfuW1NZHyMA1Slbe
	AXuwpkukymTs+UPkL2TxBfoEnNMtw+gl48DmO/I8E9tdnW/+asBzBNx3PzZ/1UQkriGWydvz2wI
	pGQ==
X-Google-Smtp-Source: AGHT+IEQTw6NycY68SHBk7WI4L2KbulF4hVElsyaIaLj1wJbiWRwmM/PjWD0Btsx9ro7hcsaxrPuaWvf6Js=
X-Received: from pjbli14.prod.google.com ([2002:a17:90b:48ce:b0:2e2:9f67:1ca3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d12:b0:2ea:4c5f:923e
 with SMTP id 98e67ed59e1d1-2ee08e9a0dbmr6652768a91.5.1732754632474; Wed, 27
 Nov 2024 16:43:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:43:41 -0800
In-Reply-To: <20241128004344.4072099-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128004344.4072099-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128004344.4072099-4-seanjc@google.com>
Subject: [PATCH v4 3/6] KVM: x86: Move "emulate hypercall" function
 declarations to x86.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the declarations for the hypercall emulation APIs to x86.h.  While
the helpers are exported, they are intended to be consumed only KVM vendor
modules, i.e. don't need to exposed to the kernel at-large.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 6 ------
 arch/x86/kvm/x86.h              | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e159e44a6a1b..c1251b371421 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2181,12 +2181,6 @@ static inline void kvm_clear_apicv_inhibit(struct kvm *kvm,
 	kvm_set_or_clear_apicv_inhibit(kvm, reason, false);
 }
 
-unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
-				      unsigned long a0, unsigned long a1,
-				      unsigned long a2, unsigned long a3,
-				      int op_64_bit, int cpl);
-int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
-
 int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
 		       void *insn, int insn_len);
 void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 45dd53284dbd..6db13b696468 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -617,4 +617,10 @@ static inline bool user_exit_on_hypercall(struct kvm *kvm, unsigned long hc_nr)
 	return kvm->arch.hypercall_exit_enabled & BIT(hc_nr);
 }
 
+unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
+				      unsigned long a0, unsigned long a1,
+				      unsigned long a2, unsigned long a3,
+				      int op_64_bit, int cpl);
+int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
+
 #endif
-- 
2.47.0.338.g60cca15819-goog


