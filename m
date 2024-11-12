Return-Path: <linux-kernel+bounces-405679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E1A9C5529
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF4B284102
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7477622ABFE;
	Tue, 12 Nov 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5NsVYoc"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5AA22ABC5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407901; cv=none; b=HYiJl1UWmsOBPbJsWUbiRHjTO+RpwqtztAput+IJ21RSKAEiKaSN07zZI6p8lEOvKj/K8nKyv9vQ7uB+lIgSPoHz+n2pSWD0sEOZ4ZSTZM0bMjdoZ9wD3mTfzOtiYoFrsvWnDB56ugjxl5WKKw5zoxmlIP8/fI0OryxnFe34fkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407901; c=relaxed/simple;
	bh=z2j2I0Qm2rkQ7y5e1vIEopVvmmPdhbqBCsJHGjoqZU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T242Z+M2wydj0gEImTIWX2qdtV69roWJ0ASpfL7JguniP3uh5uo/Jwt5WnUWdjb1Bc8Ls0vkcAe7hLMkhVuxxSpLmma3+m1pdfMXtj7R1BRFhL7DnsQDAzEiuU55m9E4yCYdyn6Im3pUgvGXdeDNnOfSdPo0c1HOK337rDaxUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5NsVYoc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so48180075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731407898; x=1732012698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdrH76534AdnOkkz/8MUO16ELoaDJWuaGxP7kufZ9lk=;
        b=n5NsVYocWspY1swY0WKdTR+DcOqkCww2+opBnjKha0bJqO1po7lZTo6SrGsPOnNRyA
         Lf3oBfcNDVv0w7BQdP9xKIyKzNPtpbdJ1HqA8RQNex/5/PyOI++AjKB/2RDVLoMxANh8
         q8c8ZXkhrOfAuakp/qgAI2d0x0qyJIfRt1nweGEZk1PmYBTETA/aNPEI3KE54Wm/SOTx
         rSH6OX+iQP3TR6cenQYcLpnlW6kHhfp0RTjWDwJF6rqlVpTmO92S50Il6tc9120y2Crf
         /QNWGdXXFstdn9IKNK7hjL5skswUdAQwR0NHhDMB2nOS7GR+0mwgw6WDH1zl9ahnenQb
         TMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407898; x=1732012698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdrH76534AdnOkkz/8MUO16ELoaDJWuaGxP7kufZ9lk=;
        b=LvuWoat4DmU6ESu+KUBID2/zlCvj8VSzB+2Y5w7fxPTVP3zsXCbq9uBJm9U7lHq1VI
         hdJ3XN5cXVLkUEM0qdgFbyvCaUYsNzCpxqiLUE3wzeYejCIoJK87KmKuzKd+ceVlb5Wm
         PAkNyG29hX9FsPYN0sC/t0bZd1VUHWxVcZ8XmEZO1Ul/UV60dZYgztTGjhKvPVMbVYJe
         rjTxGxlN30OtOarOjnzQG+7ZGb+aGHuhArC6wkHShLG4PyuYW/cGSYgfsI2SuSeUzjF8
         LofWxieF2Z78KFvkfEeTGed0pFkbtUqMygxHTiSesJpS3MxXaqMHQCVlm8BcVO4DITf9
         CPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNzwGIzDEadwuZq8dMVT6L4VfbdvGBUpPcndgi62kSH638n3CkKQI3RuDylrAO2eKtfTnxrOueg2NQ/V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8cDQXLcOWNL8XoxRlaiRlW/pAb8kDngeXBrTyaNUu8MdxRo7
	QEFnbyfGg/LqEuMS4TrOfZAIUYck3kJ50wuV7idUPDYUcK+AgFmIDpgPLjDKB1U=
X-Google-Smtp-Source: AGHT+IF1FS9ufu9o4Y4stQLYGJvoNNDm9mRT+SEMwJRqakkQKPd/4nKseuKIJE+lWn0kSfJLNtfHQw==
X-Received: by 2002:a05:600c:3b22:b0:431:52da:9d67 with SMTP id 5b1f17b1804b1-432b74fdaf9mr140208015e9.3.1731407898314;
        Tue, 12 Nov 2024 02:38:18 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbf436ffsm142270955e9.44.2024.11.12.02.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:38:17 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: suzuki.poulose@arm.com,
	oliver.upton@linux.dev,
	coresight@lists.linaro.org,
	kvmarm@lists.linux.dev
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	James Morse <james.morse@arm.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	Fuad Tabba <tabba@google.com>,
	Mark Brown <broonie@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/12] KVM: arm64: Add flag for FEAT_TRF
Date: Tue, 12 Nov 2024 10:37:05 +0000
Message-Id: <20241112103717.589952-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112103717.589952-1-james.clark@linaro.org>
References: <20241112103717.589952-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

FEAT_TRF can control trace generation at different ELs so this will
enable support of exclude/include guest rules when it's present without
TRBE. With TRBE we'll have to continue to always disable guest trace.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/kvm/debug.c            | 14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 61ff34e1ffef..5dfc3f4f74b2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -939,6 +939,8 @@ struct kvm_vcpu_arch {
 #define HOST_FEAT_HAS_SPE	__kvm_single_flag(feats, BIT(0))
 /* Save TRBE context if active  */
 #define HOST_FEAT_HAS_TRBE	__kvm_single_flag(feats, BIT(1))
+/* CPU has Feat_TRF */
+#define HOST_FEAT_HAS_TRF	__kvm_single_flag(feats, BIT(2))
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
 #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index cf5558806687..fb41ef5d9db9 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -89,10 +89,16 @@ void kvm_arm_init_debug(void)
 	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
 		host_data_set_flag(HOST_FEAT_HAS_SPE);
 
-	/* Check if we have TRBE implemented and available at the host */
-	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
-	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
-		host_data_set_flag(HOST_FEAT_HAS_TRBE);
+	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceFilt_SHIFT)) {
+		host_data_set_flag(HOST_FEAT_HAS_TRF);
+		/*
+		 * The architecture mandates FEAT_TRF with TRBE, so only need to check
+		 * for TRBE if TRF exists.
+		 */
+		if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
+		    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
+			host_data_set_flag(HOST_FEAT_HAS_TRBE);
+	}
 }
 
 /**
-- 
2.34.1


