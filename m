Return-Path: <linux-kernel+bounces-424073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E226D9DB05B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7049E166F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B252973451;
	Thu, 28 Nov 2024 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMcPu1mW"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74503F9CC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732754636; cv=none; b=TJFkaVQBKYAqRq/GG+zA5DFFiJ+pduL7RNr2kHk6cyElR7xnmKNF/SwQyUWuszpZk7aX8vjjPL7u+KjM7n87X3vraS4ppZg0ugPqeQq++HIcGDZqUrXiA8e48aSEanar8XZHmlcFQKQrOgrPrb4to7Lhhmv0lyFS9AYRyUwtLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732754636; c=relaxed/simple;
	bh=AgF1nLFRJT2jGgGNEvzsKs6m0B0/bKeLHYnQ3NQUIic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ua263tfaBbwWUIqCSJhXjvioRNr4Ufxa6DGn7a/9O+QMjvKHr0UwlZhl+O9OnleWb2R4gSdM9/KizxIWgHfenUdUfi9qcdap9GvDVDQE9obNR7tyTCjW47oWtYM26qr/F3EF+hmwo7m0kC9CMGE6r/5ztoCuQq3tvyCaxzHRzvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMcPu1mW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea2dd29d16so307992a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732754634; x=1733359434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dDZT1bmtmeMkj/4PbsRTAxMKbyk+c3Rb1LRLdcLSYzc=;
        b=iMcPu1mW5FyKzgEe/m80oOhGh0/ZDI2Ang0Nn0OEB2CphL89imrYEyCXvd+/PP/mxT
         0zstjftCgJVBzenM9yIhb71rtHgX5cHWNIJ+OJrf1vD1KyXBEOEpKprsPFQe73bfkEW1
         FiIliBS7fGZVwTCObDuwgxAOD8kslb8+Ks6nrJ8W80tQhI8qKzE+e4DAJ8uOzgn86eBs
         dNgwI3BWSD6/fb3cOHl54oXzMo0iz0yW87Vhife8aEtQZ4jVsVepYt83AqveVaYNs+ef
         SBmxzFLpyD4jnJWcz9d2SrusZNrY22scmALgyqzK8P9K4WMt4nsfxOT79fnUZDoxbIhp
         BebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732754634; x=1733359434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDZT1bmtmeMkj/4PbsRTAxMKbyk+c3Rb1LRLdcLSYzc=;
        b=bcrBlS6uiZ2li4jUEL50C8A95vVzfcdG6UZ869OOmPM9xssOX5M+OzgxQ3KSH8cXXM
         0eGx77h2yKjHr8I6M2lamjNH9gFAcgbM6IupzcFaK7eTT/Ms/fF6WpEMNq33IAiDM6dn
         e66+yLAmoTx5hl2TVT10d4qLLf+z2XKXM17QTnQxD63JxJe6u30r8c4qDP0g+Ct4u3qs
         NsQDLey8a1OInDD77n7tblUoVD1Ety1VTGtj7SLcW9kqS9+0IecTKbeIdWU+u5wjkhoC
         JbwrirqGukNDNVNBzy/H0rvtdqTdhGbWizZasiXEdrlWZne4U4tZGxeXf4dlkIIpcZ5V
         oacA==
X-Forwarded-Encrypted: i=1; AJvYcCUk0tYcMScB2433Q9ZpNbR541siUkawkMtecMBlGmH7Kwn/PZnryF6AjTvsud6cpmwvUdeTMngQOJ8AQ/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sdxjrC7ldqq3vuFuVWxtJjFOJm3dgn3dS3fmJ1HsgELZ513t
	MBhmwhAL+uBB9jCZBdh8vwRK2tnGP1o1DeZsv74oWIDSyw7Zgqd1AXsBCeKjyPn/Fh5ayMMHcv4
	TdQ==
X-Google-Smtp-Source: AGHT+IFvrKrb++Xh6P0AIe+4NdzweBJ/xiuvfkWJ8bzV4vHyK2OmIv7X9EgrfXBEvIn57suFkD1uefwv9ZA=
X-Received: from pjbsq16.prod.google.com ([2002:a17:90b:5310:b0:2ea:22cd:7ff1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c85:b0:2ea:aa69:106a
 with SMTP id 98e67ed59e1d1-2ee08e9bd37mr6163133a91.2.1732754634166; Wed, 27
 Nov 2024 16:43:54 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:43:42 -0800
In-Reply-To: <20241128004344.4072099-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128004344.4072099-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128004344.4072099-5-seanjc@google.com>
Subject: [PATCH v4 4/6] KVM: x86: Bump hypercall stat prior to fully
 completing hypercall
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

Increment the "hypercalls" stat for KVM hypercalls as soon as KVM knows
it will skip the guest instruction, i.e. once KVM is committed to emulating
the hypercall.  Waiting until completion adds no known value, and creates a
discrepancy where the stat will be bumped if KVM exits to userspace as a
result of trying to skip the instruction, but not if the hypercall itself
exits.

Handling the stat in common code will also avoid the need for another
helper to dedup code when TDX comes along (TDX needs a separate completion
path due to GPR usage differences).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 13fe5d6eb8f3..11434752b467 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9979,7 +9979,6 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 	if (!is_64_bit_hypercall(vcpu))
 		ret = (u32)ret;
 	kvm_rax_write(vcpu, ret);
-	++vcpu->stat.hypercalls;
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
@@ -9990,6 +9989,8 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 {
 	unsigned long ret;
 
+	++vcpu->stat.hypercalls;
+
 	trace_kvm_hypercall(nr, a0, a1, a2, a3);
 
 	if (!op_64_bit) {
@@ -10070,7 +10071,6 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 	}
 
 out:
-	++vcpu->stat.hypercalls;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__kvm_emulate_hypercall);
-- 
2.47.0.338.g60cca15819-goog


