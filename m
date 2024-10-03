Return-Path: <linux-kernel+bounces-349750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9389298FAF1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573BA284AF0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CA21D2F7A;
	Thu,  3 Oct 2024 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYuke+Ur"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07FD1D2F4E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999043; cv=none; b=aEaK93G6YKfyt2g1ljBYnkev4sOiAjhc+CgeVuXxqQpPseouXKpLWLjrYuMAIDTt6xX59LCN0cJm1or0OuQBId5h0OoKaDS/VPvvxPsDpSYuDd5CzgkdmDEHAO248zARArMF2JsAbbcpSmVlBCwQKAb86bwk3l7t8E4djGVGtGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999043; c=relaxed/simple;
	bh=WxcrHJSR5dRPO5GeLxqc3vQBEoOmpv6JaJwJcRuT2ac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SuVein7lFrcPluzUN7bo47wPMNwhoquAntrrbwqXaVSflrfl5Gdz3VH33Nge0G/syIK3m9K6c7ME8qc7X0jNW4joRz+vRf55CduOxsLgNX54hfVelRYQDXYTlKjmDTbmrzHhJLVd4nnQr8+TXR5V9hhAfgC0gjWRHCNNSMSJhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYuke+Ur; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25ccea54e0so2139713276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727999041; x=1728603841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CDMdVHdl900NNV0/6Aj888t96l8f72iUXOQpGAshdmU=;
        b=aYuke+UrNk/s/VLRBH1UvMXOMX3/SWIMYIw32is8Cx4UxIIDkU7pXYkQCFNltm7lT9
         Adec3dlN90znQ4QdElDKNpGpsbaQf4TLWeXj29qgVgIkqBqrZavWC6H2iIKV//qso3rw
         0CpoJKKUHECMwarorxQ1mcys6EAK2vzyK77sgk0AzqvsAJoI0t7lmINtSwn3/20lK5j3
         muhLpgcuk19Zw9tjwOPRf3M3wSyBi4LOgNxifu/3Jv+kg+AM9Y9pGQ4bq7pTe+roV0dZ
         Gi3lXD3bEqnsW3XjW+uqZNoW+hJhu5bOpGmnkdXVty0QB6qWtIBLI1JKqkuvO3rSV4jI
         AYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999041; x=1728603841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDMdVHdl900NNV0/6Aj888t96l8f72iUXOQpGAshdmU=;
        b=wfPnA33vxWYNbdY44k38zWYhMN2JmNCRehYUd/95hKSykS3wBIA+OneW5gVLpYTHR1
         E7WxinbaXcPObniHR4DcfN9tiNEAGtk6yxXmP/vyvZKQIK8yvZFC/4YvY7jTG+waHC+d
         GKr7LD/aZvby23OZC0Jg9xPlGohQDnKJrNyqrigdw7OUSAwxwOO1fzuZypPC5mwS9Ols
         eTNfT5ppANgnP8XIduBTAg4NBUU1NwvcfzO9M1BVlk9QmN75fv9txVbHdWuUoe1SdrMP
         vgRnZMa5qTQA3N772dibOSpnLxWatGAzixoljCZVMyifQ+xn6YbMcN5XkzIwo6nYPeKj
         3cxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjS3ee1hbXEqPa7ELq1ZRo7cJ/7Fu0tR3vMZciSU5fNHwHed9kmR7ZMi+UEKG4Bikduh2VyCxKY+dmGWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1oIkZ8Ejyp9qjfSg9JsE4TFW0s5+VYbTy4pdqbHXNC/qd6cZk
	ZSFDVqOZATOjUrjU0fKdFD04DGyMPzhUa1GINByPojD1MmX00D7lmgeZZPHDTMe+ZT3wakjT9ts
	v1g==
X-Google-Smtp-Source: AGHT+IHoFWU1x0IMqBwd4GgvSk5uqMLFn7or/VSYh3NJinoehg83VQkjefevxGf34pZsKQ4xF4gjbZVNPQ8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:74c6:0:b0:e1f:eaf1:2254 with SMTP id
 3f1490d57ef6-e289393b7aamr1220276.8.1727999040874; Thu, 03 Oct 2024 16:44:00
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Oct 2024 16:43:37 -0700
In-Reply-To: <20241003234337.273364-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003234337.273364-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003234337.273364-12-seanjc@google.com>
Subject: [PATCH 11/11] KVM: selftests: Ensure KVM supports AVX for SEV-ES VMSA
 FPU test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Verify that KVM's supported XCR0 includes AVX (and earlier features) when
running the SEV-ES VMSA XSAVE test.  In practice, the issue will likely
never pop up, since KVM support for AVX predates KVM support for SEV-ES,
but checking for KVM support makes the requirement more obvious.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/sev_smoke_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 965fc362dee3..ae77698e6e97 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -181,6 +181,8 @@ static void test_sev_es_shutdown(void)
 
 int main(int argc, char *argv[])
 {
+	const u64 xf_mask = XFEATURE_MASK_X87_AVX;
+
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
 
 	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
@@ -193,7 +195,7 @@ int main(int argc, char *argv[])
 		test_sev_es_shutdown();
 
 		if (kvm_has_cap(KVM_CAP_XCRS) &&
-		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
+		    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
 			test_sync_vmsa(0);
 			test_sync_vmsa(SEV_POLICY_NO_DBG);
 		}
-- 
2.47.0.rc0.187.ge670bccf7e-goog


