Return-Path: <linux-kernel+bounces-522585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A389DA3CC17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213FD1891D67
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4325B679;
	Wed, 19 Feb 2025 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bOHxzrpV"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACC325B685
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002937; cv=none; b=k3N5QBPF1r9XaxIEOh+0SgC2Uw/ZNgHbzkO0danGfOwIiKd3A/dR9imOImVLl15E6LV6titvdiIIKXiS/JkaId0yvh9vR1d5eH6+ITY9IhdodiH/UziNdQr6xk0B6gnxwv/Y80OUoWcoF68N7P8fcylXptIKIszaCM8E+YfVWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002937; c=relaxed/simple;
	bh=ZDnXQNxZSdtniqEnRAJpWEHxHQ0ZCfRWVHN8eLvT1n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/35PNkCfCtkhVhD+JhOOeOuI935VvtfSqBxUedniMipRqsBXQYiAnyfAYy3OrYYKRltLAT2WWCF7+bbIvjGpjk9sSQpA4jUTYajhXgjX0ebLiS7szeF0Lm+IHty6U9ypt0POnCdw4NuA1E3TgXXXP5YfaUt3w1WxYFmPoPebQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bOHxzrpV; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740002932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTXO+dYDUqewKhUkYqS4LHmg8GncOYyCsaWbEf+gKPg=;
	b=bOHxzrpV6rtqhXJgH2AdXljP1eEfnnPOO32CXrfjhzSd1izdBMFxvLo1939tQ+XgrO/pOo
	Ee4En0Mfnxp2DFFG1Ahdjbj97M1WfdHYEHlTfwtJH+56UMjP/TOA/57GEZNB8kkfJ6YeG0
	uWcpz4YtUs/w/0i5jqvAdGn1TIbaR6Y=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] KVM: nVMX: Always use IBPB to properly virtualize IBRS
Date: Wed, 19 Feb 2025 22:08:25 +0000
Message-ID: <20250219220826.2453186-6-yosry.ahmed@linux.dev>
In-Reply-To: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On synthesized nested VM-exits in VMX, an IBPB is performed if IBRS is
advertised to the guest to properly provide separate prediction domains
for L1 and L2. However, this is currently conditional on
X86_FEATURE_USE_IBPB, which depends on the host spectre_v2_user
mitigation.

In short, if spectre_v2_user=no, IBRS is not virtualized correctly and
L1 becomes suspectible to attacks from L2. Fix this by performing the
IBPB regardless of X86_FEATURE_USE_IBPB.

Fixes: 2e7eab81425a ("KVM: VMX: Execute IBPB on emulated VM-exit when guest has IBRS")
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/vmx/nested.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 504f328907ad4..ca18c3eec76d8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5026,8 +5026,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	 * doesn't isolate different VMCSs, i.e. in this case, doesn't provide
 	 * separate modes for L2 vs L1.
 	 */
-	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
-	    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL))
 		indirect_branch_prediction_barrier();
 
 	/* Update any VMCS fields that might have changed while L2 ran */
-- 
2.48.1.601.g30ceb7b040-goog


