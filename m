Return-Path: <linux-kernel+bounces-272973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B13B9462F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274CC1C20F67
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13D1A34D2;
	Fri,  2 Aug 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="deW1Ykhf"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BAB175D5E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622791; cv=none; b=trzfTTan4zdhplYHG/IRMaF/cye4BDwnhe+uOyA+vLR0+NlDxBOaA5LfWoZuW3D58zPIXUNNGbo57QHUUwjPBmSqj7AsFxbXefBhludAQAntWoTKumFjRlsctJboP2xsCoLVUAGET/3GyuwNaGYSf5uUAVA2bKfs2pchxcVaI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622791; c=relaxed/simple;
	bh=/bvTtQNRkvNsH1xfdg1QYCugiedxqxo4QB5+ISIcE1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XrRO6/QVLWbOg2ZujpCjbJOP7c9/qOVcST/A9lpr4U8I1IzErjoUP00oz+MNuMdtFm/mgHnIf3vwlf4FWR5So0TC9/+fn0lzdDH4R3lWXLFwB6J8UHN8MIg14YFJFjDkUwNXhaECt/K/bw2DgS9UChyMdJbwPfQ3Tkm//VAIP/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=deW1Ykhf; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-781cc721188so7486963a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722622789; x=1723227589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ljUnkMiG++SY4Qp4y5L/vw9gXfBRTB4h0f2GdA4zH0E=;
        b=deW1YkhfcZ4lt/MKeTgzCZDFoQxStrEMZZMS5uoSH3+6O+0dXSoUvMt+rVspGLt95n
         6axoVWQE4O0nWHZ4ATVXW6n7xUTCuCGwKcgvUJI2Reg4lmsLG12hFiQ+h5rupA7yb+9e
         Ma+EF/jDjaZzDIFZMCy7FLK3qxMCx6FSNdyfUWCI7GsSmJjPkzA0EFV4VE0Yv/j/muN7
         aMo6iEVQ2HYBLL/TTYrKGbMHLd1C7tXoAXUv+2g5qwW4tpPDiy9pb/0QKqs/C09mY6iF
         TlOwjkSAQ2DnFGIgd8CQX6QwvhVNY2vbGxhEqq/MSVn6MqByxTdz3DzKE28hDCqegq/y
         SuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722622789; x=1723227589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljUnkMiG++SY4Qp4y5L/vw9gXfBRTB4h0f2GdA4zH0E=;
        b=hvaIOeqDq4YKFTEEX1IHN8mN5Ud8MFfdqKX5qG2ovwT6lCRECpH3MAmGS1rIPzpQZO
         fNvUSF+9P9Skr6/rEsvAcvkyyzVpxmdB2nLbaeCNdIXO3Cfhb64tIUBE4VSdR/CdbhpI
         jSjr6IByDVNkMDxbh558JkWDiIx5dmc71Oqg8I3UsC8FaqySle7rTPxI4mxjMdhCP2GH
         dJPFKcJCzH7Q5XnSs47jETv2xQRw6mkg62+nZV3HnYzzy5j7y222Sxn0x+f00Z6oPpPr
         lfya+Wn7eSieCH2z+IeH+E6S4SJEfi1MDKu3+Gp0mb8XH8uDAY/pW4ZQZutXQ18rrMPI
         rcgw==
X-Forwarded-Encrypted: i=1; AJvYcCV7mjjxjbCreS+1wq597kl8EHHvL4BK7jVOskMpPXj2xUelL0OYPMdZRsWKmn+1uuyK+WYAlskjl18RhRWhHjpV+QJ2Tcuh0R8Rhz++
X-Gm-Message-State: AOJu0YyL3k+n6zFLWs9QVbFd00XVSOdpRt+msKqSycamteuwswMi8nvu
	FEtoR8nXJxRLP/BtCCdaLFzuFjNGDyo7FweBw0PmE0I/YDSVe3Hi2nNE3YRG0oXm5eoY8nynSnH
	jUg==
X-Google-Smtp-Source: AGHT+IGkexDJJzr/ldNDkgj7g3TvnPn669xg/DKex/JnoQk0mnOKpuGLpI7/QDSdq77MIzwNH38n3eRvpKc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:9d02:0:b0:5dc:2d1c:43c6 with SMTP id
 41be03b00d2f7-7b74a1f8ec5mr7609a12.9.1722622789133; Fri, 02 Aug 2024 11:19:49
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:19:31 -0700
In-Reply-To: <20240802181935.292540-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802181935.292540-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802181935.292540-7-seanjc@google.com>
Subject: [PATCH v2 06/10] KVM: x86: Refactor kvm_get_feature_msr() to avoid
 struct kvm_msr_entry
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Refactor kvm_get_feature_msr() to take the components of kvm_msr_entry as
separate parameters, along with a vCPU pointer, i.e. to give it the same
prototype as kvm_{g,s}et_msr_ignored_check().  This will allow using a
common inner helper for handling accesses to "regular" and feature MSRs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 660ff8795d92..52f11682dd09 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1662,39 +1662,38 @@ static u64 kvm_get_arch_capabilities(void)
 	return data;
 }
 
-static int kvm_get_feature_msr(struct kvm_msr_entry *msr)
+static int kvm_get_feature_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
+			       bool host_initiated)
 {
-	switch (msr->index) {
+	WARN_ON_ONCE(!host_initiated);
+
+	switch (index) {
 	case MSR_IA32_ARCH_CAPABILITIES:
-		msr->data = kvm_get_arch_capabilities();
+		*data = kvm_get_arch_capabilities();
 		break;
 	case MSR_IA32_PERF_CAPABILITIES:
-		msr->data = kvm_caps.supported_perf_cap;
+		*data = kvm_caps.supported_perf_cap;
 		break;
 	case MSR_IA32_UCODE_REV:
-		rdmsrl_safe(msr->index, &msr->data);
+		rdmsrl_safe(index, data);
 		break;
 	default:
-		return kvm_x86_call(get_feature_msr)(msr->index, &msr->data);
+		return kvm_x86_call(get_feature_msr)(index, data);
 	}
 	return 0;
 }
 
 static int do_get_feature_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 {
-	struct kvm_msr_entry msr;
 	int r;
 
 	/* Unconditionally clear the output for simplicity */
-	msr.data = 0;
-	msr.index = index;
-	r = kvm_get_feature_msr(&msr);
+	*data = 0;
+	r = kvm_get_feature_msr(vcpu, index, data, true);
 
 	if (r == KVM_MSR_RET_UNSUPPORTED && kvm_msr_ignored_check(index, 0, false))
 		r = 0;
 
-	*data = msr.data;
-
 	return r;
 }
 
@@ -7381,11 +7380,9 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 
 static void kvm_probe_feature_msr(u32 msr_index)
 {
-	struct kvm_msr_entry msr = {
-		.index = msr_index,
-	};
+	u64 data;
 
-	if (kvm_get_feature_msr(&msr))
+	if (kvm_get_feature_msr(NULL, msr_index, &data, true))
 		return;
 
 	msr_based_features[num_msr_based_features++] = msr_index;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


