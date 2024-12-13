Return-Path: <linux-kernel+bounces-444982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F89F0F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0416283592
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDD21E1C3F;
	Fri, 13 Dec 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RS+kN+2G"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF71E1C09
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101370; cv=none; b=BLkyXjA8GaZusToxDr+G4AJncyp1WV9mgfvs9W+v4pF0zD/dzS/QwBnAVmMhGDlmokOWwEx2WNimwoFOkjDef8FrTq/ggKAIPHDdNhSPosfQ7Xarr0wPTRAbS9uoESmYu4vXx85zOZ5fRbMdTaPhuMxV58Q6oCr6DmK/rdWXRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101370; c=relaxed/simple;
	bh=p0xHJvZoXjbk5ERaUq4AaNWghCS8HToY8pwcypXQFQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Czh7kyAWY0kxekRnW9OXkh1zIDLvxJZpxETU/fcJhU9FFTn4sRd2oOJhSJnxWRqhxF420ykb87FBXzWKaqNBvyst/x9ew9J1Ifm4OGvS4r+WVLmqk+UgWJjGlL0oT79ennQuRrfwGJz0HYCLbWJY+SXFIZ5acH+lsBr96JFNYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RS+kN+2G; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862d6d5765so1239173f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101367; x=1734706167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoj5GqPpJoW7JmFtjxPMWybNEJbYYEOKTO2N9SmSlgA=;
        b=RS+kN+2G2ryrcRR9dfZw0UgrzeSomiFHF6dBSGnlSp2tE+50l/AaHi/vV6dEQ1TBzI
         QUGP/8n1F/lKCskqUPV3u8z8Y0uryzh6ogqrID/+AgcnXxkRiRd1EfoseBV8x9vRpZyi
         CEQobaYNekmpF1fYcUyyvEF2WTEGFRdnPryZdx0exC0RmgnHF7N8ezJCsWUAlyg8Cm4d
         561xuSscTK40DUeSxsvuhDRpqh3leHCBA0f8GOGIDT5Q9bLVfPkt54oWkkmj5XHwdOqf
         31xeQJhskABYPkB3/egzqqAni5GyfhiWe2bFNw1gg8+7o/UTADw+5gRrABjpOGFveXNo
         84iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101367; x=1734706167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoj5GqPpJoW7JmFtjxPMWybNEJbYYEOKTO2N9SmSlgA=;
        b=VVcbyF7lGfaM46sEwj0q6XSdq/K84iw0iysdOUXYyiBLRGAtlYBxWwv3P4zlLyFnNl
         wEmy/OaJXhaVldNgXO+bS4tHSz1foZPuBSFA/XLPuYgwt1yTBXc1h6asP+UUsFD4C80U
         ksCrDrLH2pAS2dzp3wCpPBzvITlOlttUds7mc9x7MgfyIgu+t1uJx3UGB7xBXqpbSWzI
         mi6rcEY06OOulOMs+EyXqd+xoVG0VSipaajfwh7Lqe7DNfZhZelFmyChQqu3YFSt+1d/
         kpYRAvHYFKZ3zk7+AnhOltroo50LQYgEjuahYg4g7MN02DOtbdLlWdOJ9P5yUz9X7YWh
         rMHQ==
X-Gm-Message-State: AOJu0Yzsf63/neE4E9TOQH8mwGJJhpPaPP7fuV3b1YK/JEZFiBBy9Cpp
	pEI5FgF2aUd1v2R5GLv6k16CQccsGBLqD1kEh3yZ78f93evGWvyIYDx/TzKV3Rk+yEIvwJ28Kx6
	k
X-Gm-Gg: ASbGncs4k6kjEaA7kc7NWHpvfwxI8/JqJKPV0kqfeWMRHDEnSU3Es8DZrQmym7KfBtQ
	TZVscwa3C2sy93iLsgOKTSM2skYKpcyuuhHSS5+Mhq82gcdxWsB6E5gbPpXfwUEeBoSZcztJTFZ
	KHKRmod7TmNSLc5XSBZ9VWqdPeUATSY+bZX3O3P+VpM0OmvAo9SGIGBwBiIuqB12jhJWI/XPcwB
	aJprmOzG9lGBL2tZONcHNKcMpCgCPwDCkIIhO/XllGWPG9DTtRbXmLtZA==
X-Google-Smtp-Source: AGHT+IG89RNTzAe/9DbcvL6vbr1RIH/IF1uo8b6fNVKeWEEIDb5CO4Aje6k8AftMtkfUVUDJ7opmpQ==
X-Received: by 2002:a5d:59a8:0:b0:385:f5c4:b30d with SMTP id ffacd0b85a97d-3888e0b882emr2286934f8f.39.1734101366915;
        Fri, 13 Dec 2024 06:49:26 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:dd7a:c2d:2b46:b1a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824c50b7sm7196295f8f.57.2024.12.13.06.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:49:25 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org
Cc: james.clark@linaro.org,
	mike.leach@linaro.org,
	suzuki.poulose@arm.com,
	alexander.shishkin@linux.intel.com
Subject: [PATCH v2 2/3] coresight: tmc: Update error logging in tmc common functions
Date: Fri, 13 Dec 2024 14:49:18 +0000
Message-Id: <20241213144919.110642-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213144919.110642-1-mike.leach@linaro.org>
References: <20241213144919.110642-1-mike.leach@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance the error logging in the tmc_wait_for_tmcready() and
tmc_flush_and_stop() to print key tmc  register values on error
conditions to improve hardware debug information.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-core.c  | 37 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index e9876252a789..1a9299adae93 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -34,25 +34,36 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
 DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
 DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
 
+#define TMC_WAIT_READY_FMT_STR "timeout while waiting for TMC to be Ready [STS=0x%04x]\n"
+
 int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 {
 	struct coresight_device *csdev = drvdata->csdev;
 	struct csdev_access *csa = &csdev->access;
+	u32 tmc_sts = 0;
 
 	/* Ensure formatter, unformatter and hardware fifo are empty */
-	if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
-		dev_err(&csdev->dev,
-			"timeout while waiting for TMC to be Ready\n");
+	if (coresight_timeout_retval(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1,
+				     &tmc_sts)) {
+		dev_err(&csdev->dev, TMC_WAIT_READY_FMT_STR, tmc_sts);
 		return -EBUSY;
 	}
 	return 0;
 }
 
-void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
+int tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 {
 	struct coresight_device *csdev = drvdata->csdev;
 	struct csdev_access *csa = &csdev->access;
-	u32 ffcr;
+	u32 ffcr, ffsr, tmc_sts;
+	int rc = 0;
+
+	/* note any MemErr present when stopping TMC */
+	tmc_sts = readl_relaxed(drvdata->base + TMC_STS);
+	if (tmc_sts & TMC_STS_MEMERR)
+		dev_err(&csdev->dev,
+			"MemErr detected before Manual Flush; STS[0x%02x]\n",
+			tmc_sts);
 
 	ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
 	ffcr |= TMC_FFCR_STOP_ON_FLUSH;
@@ -60,12 +71,22 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 	ffcr |= BIT(TMC_FFCR_FLUSHMAN_BIT);
 	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
 	/* Ensure flush completes */
-	if (coresight_timeout(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
+	if (coresight_timeout_retval(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0,
+				     &ffcr)) {
+		ffsr = readl_relaxed(drvdata->base + TMC_FFSR);
 		dev_err(&csdev->dev,
-		"timeout while waiting for completion of Manual Flush\n");
+			"timeout while waiting for completion of Manual Flush\n");
+		dev_err(&csdev->dev,
+			"regs: FFCR[0x%02x] FFSR[0x%02x] STS[0x%02x]\n",
+			ffcr, ffsr, tmc_sts);
+		rc = -EBUSY;
 	}
 
-	tmc_wait_for_tmcready(drvdata);
+	if (tmc_wait_for_tmcready(drvdata)) {
+		dev_err(&csdev->dev, "TMC ready error after Manual flush\n");
+		rc = -EBUSY;
+	}
+	return rc;
 }
 
 void tmc_enable_hw(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 2671926be62a..34513f07c3aa 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -259,7 +259,7 @@ struct tmc_sg_table {
 
 /* Generic functions */
 int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
-void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
+int tmc_flush_and_stop(struct tmc_drvdata *drvdata);
 void tmc_enable_hw(struct tmc_drvdata *drvdata);
 void tmc_disable_hw(struct tmc_drvdata *drvdata);
 u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
-- 
2.25.1


