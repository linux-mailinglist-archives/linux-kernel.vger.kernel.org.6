Return-Path: <linux-kernel+bounces-273102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE8B946491
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9DB1F21F06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6B9132105;
	Fri,  2 Aug 2024 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTmrSSg2"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B778C60
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631520; cv=none; b=O3TjUEBd7yHxYGygQxLZawVVZ4NSWj+GX1pg5Q4zzvEJNvc6aTIHj8scCLbIEfPMCsGeao3ADYho8iL/0B12G8JZe4j495vJV3VUiC+twTkDF+TX21J6mJzPe/wucKDh8aiSRXVcBojVdPBWfwZPTN7HoBI8NbMf9v1FEOoLJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631520; c=relaxed/simple;
	bh=cEmBxHf9lxfhKNujzAja0PlMob6xSKDSsBphNmFY1I8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VW6nvnocus4Nz/vD8JKtrLW5hoc1inXKUyH8fPSgprvwKSPS04bdicb79BCeNVInmhxtpfTYEXir0PxThtOZzGQZvTCzeqEQ0GH7hsk6KgdONOSgi6lLJsqcGZMThrfZyOxGGS7n3LauPRjZNmQBP5A4lM2UBY/VQvgQHuulxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTmrSSg2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ff24acb60dso38502925ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722631518; x=1723236318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef/zFHnzH9ziD4r800QDczQlgiF3jMvJYDOovUok0uI=;
        b=vTmrSSg25bm4QZoascZIVHbSyDjR61ae2uHC0PRVm6F2TkQR8jnPLOS6KPclk0tNJP
         NLKcizkkCgFVyTtxzUTlbbUU/pT0ZDJmN7EWe+GcZLr2m+JiGf11MEzw6bd5I07RBXD0
         Bd0+ENeWfucRvzF90Dk5inUm9mxz5Lta39y0atd3UfndejQOS164rwUKW38kqTLb2YVj
         K6vK34xrdNzMkukJiL5W1IvSuAWjYsLwbbzE4lyK+gQcIoGE4R3ogHKhx1KDtI1CSHi5
         gGXar3pYueGE44onnV/yhtyW3WfKOcgDZJ+bNmtFHtcFWghcUpqB5VAf/I8wpnuT/Jvr
         ZvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722631518; x=1723236318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ef/zFHnzH9ziD4r800QDczQlgiF3jMvJYDOovUok0uI=;
        b=wmGJZQtHeEhlnkSnz0h14ix6XooZ5kXzOgASC0B2S46k2/QU0ByUTAowSEg6h5t1L9
         GOcwwt2jVAyOmlcJ9XTYV+270uWT34mINBh5K/BqN4m31729dpoBvajmv1VftQ+3LUK9
         f4bAUcnwO9b5wJDXZzVA947V92ur+K7+xXi1M1h9V5ht+H+5Fqd+I8qEoca9GFfuCmDo
         mEwIYr4fgrUy0S9g2qJG72kadof+KzvItygyBcqJBJ2xEAkCUNExnvjDC4IJ/NDHC973
         ekdtXMo4l/GOiF9dkk9tGR7Yf+7CCF9Q4o4C0ijSiT+EDN4ehHiRWNPP1elbLTn+ZLpv
         tg2w==
X-Forwarded-Encrypted: i=1; AJvYcCVT2CvVpTlKf0ZAFajd2HA6yXwiBDhKuZVVM7OV0N2feCMrCSXzzaQ0lEJbC9pSOI6jBdcV/JfyFLoegByjAO0HEjQMYUPsWC0hiG9K
X-Gm-Message-State: AOJu0YyJqkF+yfO4FobQlZiF0ZiFqOQUjzAET/QGA220cMQvHLb0Avre
	IUMRXSd217TUrO35xqNLOF3pyDPpxF9BD/2oRWlm1yQF5LQgrcG082Zq4jQWcq3Y6GHk2OPdZ50
	g6w==
X-Google-Smtp-Source: AGHT+IGUaCH5GW1GuzLfD6kYR2Ssu+ja9saSMgach2eDhR8Bt+zw4+jG2/PGa+s1mkXBM9gh1y7A6UyHYEU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:dac5:b0:1f7:516:4235 with SMTP id
 d9443c01a7336-1ff57bed391mr2256355ad.6.1722631518251; Fri, 02 Aug 2024
 13:45:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:45:10 -0700
In-Reply-To: <20240802204511.352017-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802204511.352017-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802204511.352017-3-seanjc@google.com>
Subject: [PATCH 2/3] KVM: SVM: Add host SEV-ES save area structure into VMCB
 via a union
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Incorporate the _host_ SEV-ES save area into the VMCB as a union with the
legacy save area.  The SEV-ES variant used to save/load host state is
larger than the legacy save area, but resides at the same offset.  Prefix
the field with "host" to make it as obvious as possible that the SEV-ES
variant in the VMCB is only ever used for host state.  Guest state for
SEV-ES VMs is stored in a completely separate page (VMSA), albeit with
the same layout as the host state.

Add a compile-time assert to ensure the VMCB layout is correct, i.e. that
KVM's layout matches the architectural definitions.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/svm.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index f0dea3750ca9..2b59b9951c90 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -516,6 +516,20 @@ struct ghcb {
 	u32 ghcb_usage;
 } __packed;
 
+struct vmcb {
+	struct vmcb_control_area control;
+	union {
+		struct vmcb_save_area save;
+
+		/*
+		 * For SEV-ES VMs, the save area in the VMCB is used only to
+		 * save/load host state.  Guest state resides in a separate
+		 * page, the aptly named VM Save Area (VMSA), that is encrypted
+		 * with the guest's private key.
+		 */
+		struct sev_es_save_area host_sev_es_save;
+	};
+} __packed;
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		744
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
@@ -532,6 +546,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_ON(sizeof(struct ghcb_save_area)	!= EXPECTED_GHCB_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
+	BUILD_BUG_ON(offsetof(struct vmcb, save)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
 
 	/* Check offsets of reserved fields */
@@ -568,11 +583,6 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(ghcb, 0xff0);
 }
 
-struct vmcb {
-	struct vmcb_control_area control;
-	struct vmcb_save_area save;
-} __packed;
-
 #define SVM_CPUID_FUNC 0x8000000a
 
 #define SVM_SELECTOR_S_SHIFT 4
-- 
2.46.0.rc2.264.g509ed76dc8-goog


