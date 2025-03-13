Return-Path: <linux-kernel+bounces-558842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A9DA5EBFF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C93B189647D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EAF1FC7F0;
	Thu, 13 Mar 2025 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ofdEWQJY"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096321FBE8E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849102; cv=none; b=r515m7AHkvLJ6EoBlfd5gwibCCVIAshl2QW8qokieVh50HUf7b5p6w6K8bt9XWBJXI0Je2Km4/yuzkP4XsuK0D/oYfUNxXn1Sara1Qv1oAh8w9826dkDJMkAa0vDjgt3JWnuAIb3WPoPyHSu2XENwVFtkRhSR79Qyr6DArr6MUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849102; c=relaxed/simple;
	bh=Tj645q9eNem2mWG0f9T8+quM62XYJmnNKPTtUs1bzek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHizlAjy4q8ilStTfFIe84hBSgTpq5mNFd1rTxZ9IZxytnYl0KMfnSKsRBTULwG/8MkKqDOrxBSQj9qECixI5EPrYsvoSFPScKHAt/bbofOZwk7wgnW0furoq5YJ5u00mmEN4N5uzZjqDRHvcHQPlC05yTmdiE913fn+GS0WQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ofdEWQJY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f42992f608so1226227a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849099; x=1742453899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dV52GHaIMEPgQHguZuBTFzmZYTI1o5W7vkJBLWdUl1Q=;
        b=ofdEWQJYmc3hZHVaZ3Vq+tq4+nkL5r5FB3o6ZWB8LsO4UnXz9dTwvcDys1yswW3jbn
         j3HApxea8zenAsO8eVxwfZQRObDInnGfVwWnalSa9qsGZXki8q45I4oYw44RAF4F4eem
         kY1Pq37/PC3Ollzyz7Y3IvdX7BENNN7MGKnyHvAmqrlCI5N/SP8Z9Aqy40CNG1/N/eP/
         SNEoplj0MGCOSqZ+TS9NUgYGrxEyKjkrnUwYSpnSnVPk4YZ05IlH+ViGDQC5bmV7qAcM
         hzzh0JahM6ik/mR+FyWSqA+Oj0g2iAk2IFMF5cs8Hgqru2EJamgSOgmMBVVhUibc3bQ7
         +iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849099; x=1742453899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV52GHaIMEPgQHguZuBTFzmZYTI1o5W7vkJBLWdUl1Q=;
        b=C99hL5Cj/n/i44TaFAD4iR49HkvlYtoGFP8F9T0Rh1oos4StxgvabapH4ae9hp1nOO
         WaHhPKKk/mvWBu4wFBowt7MT7DbXX/IeVjpEjZ6gNO97wy88Yz/SxYNc9MJ0W+pxeBTC
         qsWt5uQXBxnbmfjAGBmXsDTKFp9w3JDKpAo4hNEK18teOLo9OjDd32R8cHzuQgwqhTs0
         q2r8w5tan1d76AJEl+TQyAGOs4wjjpRRLBv8kpUTmBYOem+AEyGmgKlMOmglRBm/7VIc
         KjDFQUjd4Vs0cITYfQzfU+O9J0nrMwgNlhiUIKed69573uaEUGxHgmQuStkoJSqXcZdR
         MCZw==
X-Forwarded-Encrypted: i=1; AJvYcCVY697f4xdtRpUprKxSVAMFyZme7pygg5KvuKMFfrQrRJT9hmhjK6TY74WJaHy0h4XpWmnu1kKDrAIGKTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0cTvMyzN0ySSVevGogFn4OiAiDbT9pIBwaIazvfrhyXI4PBS
	zlnB4HQikg24JnUs+MUGLnNBNSsT0dhAPRj3VHYhfJjckRIXLXkZRVhjROzChdM=
X-Gm-Gg: ASbGncs66nu4SY54Se4DMpdk+CBcz2gPSYYiJY4mzB7rdW8UO3Gf73X/pmkyicZdUNF
	4/z0+kwwQN35RZ2VhNSNW9FqDSwvHcOR3tnrG8LhkzAHqIiXc4BP2kinqd29emd8LXtHaCtENFu
	OBVU/26M90x0p4ZOWx7eMF0iZ6LfyuptwEsXkpswOoifsQq4xmOTa2CKRUCdb570qilQ0ZNzN4T
	Nc54B3l1+mTzodr9DTn2kKtF5lwTGxLgisISt5CnuHfFewVo4X+IXl23WKVOHbNu5DVLjk319bq
	y0uWrtWegPWbDrIml1DmphgKjyXNWWGFrKUtvYq1beSYMJ70
X-Google-Smtp-Source: AGHT+IEdM86wLdPa/J6rG1pbebGy/mfNmQe+uLQUEr6OB03UsH6Ds/Qp3ZpxLVj4ahH7YgLID6TR2g==
X-Received: by 2002:a17:90b:4ad0:b0:2ff:6fc3:79c4 with SMTP id 98e67ed59e1d1-2ff7cef5cdamr34627616a91.27.1741849099153;
        Wed, 12 Mar 2025 23:58:19 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30138b5d229sm610894a91.22.2025.03.12.23.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 23:58:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:57:46 +0900
Subject: [PATCH v4 5/7] KVM: arm64: PMU: Call kvm_pmu_handle_pmcr() after
 masking PMCNTENSET_EL0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pmc-v4-5-2c976827118c@daynix.com>
References: <20250313-pmc-v4-0-2c976827118c@daynix.com>
In-Reply-To: <20250313-pmc-v4-0-2c976827118c@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <andrew.jones@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

kvm_pmu_handle_pmcr() expects PMCNTENSET_EL0 only contains valid
counters.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/pmu-emul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 3ed8b74d9925..461c76a9cb6b 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -831,11 +831,11 @@ void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu)
 {
 	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
 
-	kvm_pmu_handle_pmcr(vcpu, kvm_vcpu_read_pmcr(vcpu));
-
 	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) &= mask;
 	__vcpu_sys_reg(vcpu, PMINTENSET_EL1) &= mask;
 	__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) &= mask;
+
+	kvm_pmu_handle_pmcr(vcpu, kvm_vcpu_read_pmcr(vcpu));
 }
 
 int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)

-- 
2.48.1


