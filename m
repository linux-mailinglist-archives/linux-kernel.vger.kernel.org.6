Return-Path: <linux-kernel+bounces-211437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C92090519E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D6EB2262A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D7216F261;
	Wed, 12 Jun 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZO2NDaR"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9F16D4D3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193101; cv=none; b=pTMKTt00WYjZ7H7kzK/4WRzXZSQc40a0cCKGo7VjXrUioHZbABTgqlc40d1CuTfpnh7Vyqmz9C3obPXu2DfhpMYPnRHtT0HlIzId4IqoZnzHdE6rwaT5SSt3Qfb/d+HFfAHMvvSTqr7tmogVs1tSZTidyRP5b8Ht8T6O0DK7Kns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193101; c=relaxed/simple;
	bh=Cqxmc4vU6fJ1ptk84gOC8RIBnHsYAaGlG8/IcCyV160=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/8OMSU2MB7dDxNdDRTznLqZYA7aCJCOV8bC2tBhkJKC7wsv7EarNbmMRGeWUubO4N7K/DWf1JXan7sk0EmwbWMOqF1vDePaihvH+kKOWRvSOTSIpOpoq9TM2+HR/H4O0vt4yDaRqfX/8XRXgTBlXiCUj1OeyDQ6xruTeMBnHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZO2NDaR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso668636966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718193098; x=1718797898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md7Cta9c0UVJz/TGAYvqfK5C0UOgh9je44EY4i9/Lj8=;
        b=zZO2NDaRcaBHuQMozur+7Fm4cUyD18mS5kCo18VyegIi2+zicPXQ/TDCndb3n1NWYY
         TscsRuoWZabPoa4oM8TCUwNGE2ll2XNKpnp+0iamj/72zxs+y9INU1bSPbPTfGUdG+GO
         VihXA6Xs6tsyJga382tBdUp7EIN5H0rN01a4W1QstWSPEg3T8zbSdTPYHAx9lPccwTZl
         4sMpUDp1WKseREnNioka0NBTfvSMW2M67v3d+7MXIgbDs5JPw4ow3jgLig9wpYnK2ARH
         tBo7uOcoupWhzs3Z1ywIydueDCQGi+jw2uqR+5MDIpoo9VVSWR3IlZ3XnUdf86nuXaaH
         JpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193098; x=1718797898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md7Cta9c0UVJz/TGAYvqfK5C0UOgh9je44EY4i9/Lj8=;
        b=apWLsXqaDb/dF/TcvYzG9kAWzdrPzRPQynlaC6RTd7vwEablvU29SPSm/gPXkLmmPG
         d3YOv2iOwjzGyO+KRp0vi1Ut4kdKnz9M5oQpF8d7ClhuVKyL92w8QVEAZ9iGeonjKCS+
         IPtzqkmi+dynZ41W1YsPoqEVlvCibgDPPiKI27gWzRlsC4CnDw0/7r9eGFktNkg1WQtA
         7Bn/Hrco/C+xJLP/1t+PhpwL+IVpgBme8YUCOtq6sNzXwGcMcHVcWTlr/uUOS/p9WnkD
         0RMVyjS+SYI4qOEU8GO2KoYOHlwMMtBrU3b4umIF9Vzjv/+rtQZ0wFaXTLmUMRgzjIaW
         cUXw==
X-Forwarded-Encrypted: i=1; AJvYcCUaZ2V7flTCuh+EWFK6symInxP2dHdxKuDbs5PoqyjFSfD0u40GxtK/PkNX0M/S7UzDotkXWhedQ2omMUQdvbwqdmelcDJOQo5gjwnZ
X-Gm-Message-State: AOJu0YxMpHYHxJ08V/Eq9sKv3n74F5altFWNAvuhMKP95J9bQMNev8ey
	3V4pVPqHrYyBtN7l+EVfDPkNoYup3o7InfSuRxG/ucBVphpNrJii/AZHf98smFDnqu8Db0zyReb
	1
X-Google-Smtp-Source: AGHT+IHWofN4XRRk27pqtnbrMr8jm0y9pVLTuG5m4eo7uZs4c3yYHlfkS480GWAJdWtb1ZyWojDx9A==
X-Received: by 2002:a17:906:3bcb:b0:a6f:2ee7:b21a with SMTP id a640c23a62f3a-a6f48026d98mr104094766b.65.1718193098085;
        Wed, 12 Jun 2024 04:51:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f29d305b2sm5944700f8f.8.2024.06.12.04.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:51:37 -0700 (PDT)
From: Dan Carpenter <dan.carpenter@linaro.org>
To: error27@gmail.com,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: SVM: Fix uninitialized variable bug
Date: Wed, 12 Jun 2024 14:50:38 +0300
Message-ID: <20240612115040.2423290-3-dan.carpenter@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612115040.2423290-2-dan.carpenter@linaro.org>
References: <20240612115040.2423290-2-dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If snp_lookup_rmpentry() fails then "assigned" is printed in the error
message but it was never initialized.  Initialize it to false.

Fixes: dee5a47cc7a4 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The compiler is generally already zeroing stack variables so this doesn't cost
anything.

 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 43a450fb01fd..70d8d213d401 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2199,7 +2199,7 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn_start, kvm_pfn_t pf
 
 	for (gfn = gfn_start, i = 0; gfn < gfn_start + npages; gfn++, i++) {
 		struct sev_data_snp_launch_update fw_args = {0};
-		bool assigned;
+		bool assigned = false;
 		int level;
 
 		if (!kvm_mem_is_private(kvm, gfn)) {
-- 
2.43.0


