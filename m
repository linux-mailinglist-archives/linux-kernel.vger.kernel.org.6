Return-Path: <linux-kernel+bounces-566526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA06A67937
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8536E7A4BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A516210F59;
	Tue, 18 Mar 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8w+SCI9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB7211A11
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314955; cv=none; b=sgn2q4gFj8N5CiMc8mo20A7uorkLsJQv/oZ0fsv/P+ZGwi3LIIOeyM+eThgvuk3g2UuRKcISEZibATgUJhNYf3H9vW8Q2kZlDcqDST7heDLZQKDVKOtNaRzn7MzvMX3upPRWQzQi9V1/Hq5phsSPMcjw8CgsyXZPij29gq80eT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314955; c=relaxed/simple;
	bh=/SRPXQbaf+4iJEV8AA2PUV0vcYcie4z4t6TK3FOgTPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLDzaRlX1T4AXX4i79//bcoE47WNO4oR92c0cDVg3qA0frE1z5jMcXY4xZ6Saxdeof3lqBUTcr38mHfULwVRTp+apDRwTAPU1XQ+8DJikRW8Pz6/OtEC8RglR9QukTRrMODtR9pC4gFqLW8OT5n5XjKh9cST9vz6InBtNj+cvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8w+SCI9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913cf69784so4953946f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742314952; x=1742919752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmRDDnwo9Eqxsm96UUThsAjcmobce4RnV2whoqeLhr8=;
        b=c8w+SCI9PSp2ZlgJ+q5adJ33ZnVF07YVFhYFDAP/FrJiSKXL804cRdZcbJ+EvDpvvG
         wbTTz7VZYsSiLMz3jcvfAKgzrQ9NcyUWlX94LnajbLFY88ZanEHnuRbsS/6njMGNY00y
         7wVtyzikoFaScbORhLHRPeNx/J1mhdG7XnxwmN8nq6h1pIcxRsbOIfn570nFBJ0zo0qr
         5F0uOL+jo9H3rb2HzxwPiE8f5/f7QLMUa5oU4fp5s+m+Lx1YHxh6lynn4qmlIusPQO/9
         pv3R6O1souLWC/ZELLsXMrM7GudeR8NytQf9+zSFzZkFpVNvN+N5nuUpyEX3kqNr+zjE
         e9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314952; x=1742919752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmRDDnwo9Eqxsm96UUThsAjcmobce4RnV2whoqeLhr8=;
        b=F5SUpTwCKIcR1O0CMfpNzy5ZnlmAP7dPowHeF06oBKTIRmQsLVL1m3/Y/tNGkmL+Kk
         HMhBK2rvNxVlXqcONCQ6Ka3/67HRQUcjfaYLwRz9j0KRR2Abcr1sbEuBxsbfyJW2S4Nv
         u8qoC1Zp0pszqoheAe5rvuwVA/SfaHlMm3zZqe4lBJE/ASbNE5evavViQna4oVrFP3/X
         hFwMNBhrHw3xBdZSYG74GvNIJ/cP2zu1sGsuMW2Q4Qxho89DIIg7brh3aWe9ypOMtzW8
         7G3khIjm2RVNgc3yKZL9xExj5kKiFBMN6pKX3H7fhzEzDGduX69Tw8L2jjURyUZXIntA
         k6lA==
X-Forwarded-Encrypted: i=1; AJvYcCVE4PF8sgKduTu9UfV6CxIdgyuZA6TkqaeBn2rVEMN3VByESNjg07M07aE1T4DrqA1/2rrPO0g/ZFpZ7vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI67OV7T/jQ4N+2r5fcK/tkp6TCE/HPID9TJcr3NlXvK4uzy+Y
	8P3UP529N5S4/xmtCfJFpqhz9fZkhUaHxr080S1eEJANrXGIYkSuKmVVj7oQ+y8=
X-Gm-Gg: ASbGncu+sA5MxaEExaiEsEoMgeNFOSG7CRazIEoNhItzKZVtHB+lmEIdMRbsbV8rZRZ
	MwQOk6ct+/WMcuk1gpaNRPCRkLATH3V+n4QEe5Iex28+qHRQBQv3XvlmD9DY3m2mBz9OOuB+1Cv
	RSE40DETqcGW2z4qkCzOg2oTpbE9cdF9huk3/k9+WFt+mr8MUkHJIOo86E7Jo3SpZUJelmOEZAP
	4I84cs5elvPJ2pTfk9+qjsZa0mWkkxR+RlTCxsnt71IET7BeAeJ42yCrbrrWIiTYSma7lVFA0t5
	qIhdPwBNJFJ8qxgFLDXB3KV6m2eQsoy8x6Vp3lYJIcDfJEs=
X-Google-Smtp-Source: AGHT+IHG24aBOTH82S8mBQHA/EvCsTlCM5udW3Pp2gSPLLt+6zfnyCulJ1Vi6Jmto8NNjpaOuq2HQg==
X-Received: by 2002:a5d:6d08:0:b0:391:4940:45c3 with SMTP id ffacd0b85a97d-39720e3c9bcmr18659540f8f.54.1742314952061;
        Tue, 18 Mar 2025 09:22:32 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975ae2sm18914732f8f.51.2025.03.18.09.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:22:31 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 18 Mar 2025 16:22:00 +0000
Subject: [PATCH v2 6/8] coresight: Clear self hosted claim tag on probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-james-coresight-claim-tags-v2-6-e9c8a9cde84e@linaro.org>
References: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
In-Reply-To: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.0

This can be left behind from a crashed kernel after a kexec so clear it
when probing each device. Clearing the self hosted bit even when claimed
externally is harmless, so do it unconditionally.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c       | 1 +
 drivers/hwtracing/coresight/coresight-cti-core.c   | 2 ++
 drivers/hwtracing/coresight/coresight-etb10.c      | 2 ++
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 1 +
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
 drivers/hwtracing/coresight/coresight-funnel.c     | 1 +
 drivers/hwtracing/coresight/coresight-replicator.c | 1 +
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 1 +
 8 files changed, 11 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index fa170c966bc3..deaacfd875af 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -558,6 +558,7 @@ static int __catu_probe(struct device *dev, struct resource *res)
 	catu_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
 	catu_desc.ops = &catu_ops;
 
+	coresight_clear_self_claim_tag(&catu_desc.access);
 	drvdata->csdev = coresight_register(&catu_desc);
 	if (IS_ERR(drvdata->csdev))
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 80f6265e3740..8fb30dd73fd2 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -931,6 +931,8 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 	cti_desc.ops = &cti_ops;
 	cti_desc.groups = drvdata->ctidev.con_groups;
 	cti_desc.dev = dev;
+
+	coresight_clear_self_claim_tag(&cti_desc.access);
 	drvdata->csdev = coresight_register(&cti_desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 7948597d483d..2bfcb669aa84 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -772,6 +772,8 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.pdata = pdata;
 	desc.dev = dev;
 	desc.groups = coresight_etb_groups;
+
+	coresight_clear_self_claim_tag(&desc.access);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index cfd463ac715c..1c6204e14422 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -764,6 +764,7 @@ static void etm_init_arch_data(void *info)
 	drvdata->nr_ext_out = BMVAL(etmccr, 20, 22);
 	drvdata->nr_ctxid_cmp = BMVAL(etmccr, 24, 25);
 
+	coresight_clear_self_claim_tag_unlocked(&drvdata->csa);
 	etm_set_pwrdwn(drvdata);
 	etm_clr_pwrup(drvdata);
 	CS_LOCK(drvdata->csa.base);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index e5972f16abff..52c9aa56e8b9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1372,6 +1372,8 @@ static void etm4_init_arch_data(void *info)
 	drvdata->nrseqstate = FIELD_GET(TRCIDR5_NUMSEQSTATE_MASK, etmidr5);
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = FIELD_GET(TRCIDR5_NUMCNTR_MASK, etmidr5);
+
+	coresight_clear_self_claim_tag_unlocked(csa);
 	etm4_cs_lock(drvdata, csa);
 	cpu_detect_trace_filtering(drvdata);
 }
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 0541712b2bcb..7249cc356ccb 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -255,6 +255,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 		drvdata->base = base;
 		desc.groups = coresight_funnel_groups;
 		desc.access = CSDEV_ACCESS_IOMEM(base);
+		coresight_clear_self_claim_tag(&desc.access);
 	}
 
 	dev_set_drvdata(dev, drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index ee7ee79f6cf7..b2acd4535c74 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -284,6 +284,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	desc.pdata = dev->platform_data;
 	desc.dev = dev;
 
+	coresight_clear_self_claim_tag(&desc.access);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index a7814e8e657b..a09579eff3fd 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -869,6 +869,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	dev->platform_data = pdata;
 	desc.pdata = pdata;
 
+	coresight_clear_self_claim_tag(&desc.access);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);

-- 
2.34.1


