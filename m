Return-Path: <linux-kernel+bounces-208792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F81902934
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C401F22374
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8914D449;
	Mon, 10 Jun 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IJ/r93kh"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA1381AD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047524; cv=none; b=gdk9Pa71V7nGlgzjNRhfEoQP2XzmUdybss/4CVP6Rzpzw3bRa6rwYTsRrcDTuZo2HsamAw996NhVVmJqrmyroMsLC/t/r0eWFD2vf2HWZpgWP/QBPVLecCceHgiECH17VO6rnVlP0+LAnS+yXpW3AmaJHO5PMc40v4lCMPaehE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047524; c=relaxed/simple;
	bh=SOVjdRe34GOCQ47UTPDLtwEILeGBHtV9nlGEoCZtDX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtgHAAIrL1vCQ/KfF9zocfI4VI7p7Es1Sff9hrc1DyrhWrmMq+AO25erYimK0YAUEYf9TaOsIcXDDAAetuftzwQSeYPwEkrL7syMqg3TGnxHhrce9/AoTiUhCJwUy+yJfpodknZHiVJl4GNOBOzlhBUn90Fhxtj4Oi2CET4+jEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IJ/r93kh; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7eb7c8f114eso76408339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718047522; x=1718652322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWSKoL8sJ/aT4qro5GEGdCnI9tnOTqY2PEo9IoOrefY=;
        b=IJ/r93khilULqwaB+qD6mJWToh7H+r1MCSHCTFxMMlpYKpV7OT3BtqEz2rBsKTX6Tm
         Xq0UvYirHGORKB4PeTdCgodkPZqcg8CTTNoVtMIQRMuRKU/CY2nNb0QPTBrJtjAKffP9
         eUpwgbaI0zuIXabZJdar9Z+hP0vuFzfibPFbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047522; x=1718652322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWSKoL8sJ/aT4qro5GEGdCnI9tnOTqY2PEo9IoOrefY=;
        b=Yi2ByWV2/7b6VB7Kkti6WyvZyQ9rx5/QrTFe2gOF7IrKiXiO/NhzMf3fBK0dctgXwu
         R5G/C4UKem5KdV8raGuy75PZu51zjgtp2QictQh4iBzYrJ+TEm94QargQTLcNYKP5AhG
         KoZrcuFNhecb4qdcpFBImZWV64SIlwmrVTpODDF677nAKmcoAVUCJP1wIQADyped7TkB
         VhyczZB2gL8IK49cOUvEJyT2xUhkDWe63gSE/pUkujzcTMcyunLtF43WIwa+UQXJmKFz
         uuxhWU5FFUdCDaUR7n4WMgVaxzAEYLSEwjtzLOQAWH+CEvqQI+E63MjssSWmtzXwYVOc
         PXww==
X-Gm-Message-State: AOJu0YxN8Cjlt2aWn0H8pKc+PSXWLx0Sw53wMais0pNOR0yL8KTQmMYh
	LpEfGTpxxqBhtPfc2iGHHf+NhDaHAU/kqfk4upC4xsuR/enwQ5/BwWhFwK94N/e+clODVO7b6Ii
	MhA==
X-Google-Smtp-Source: AGHT+IEv4EKwqbjfHVuBTPRh8XxEFg2EqS2zqSbjRuHEfyhQ4zkdjlHgLdf5ZV51zSXi76hv7TJt+A==
X-Received: by 2002:a05:6602:1594:b0:7eb:906e:e3ee with SMTP id ca18e2360f4ac-7eb906ee88bmr297163739f.12.1718047522177;
        Mon, 10 Jun 2024 12:25:22 -0700 (PDT)
Received: from rink.bld.corp.google.com ([2620:15c:183:200:8f60:cf26:3e5a:293a])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a24bde48sm2637939173.152.2024.06.10.12.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:25:21 -0700 (PDT)
From: Jett Rink <jettrink@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: jettrink@chromium.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: Add new device/vendor ID 0x50666666
Date: Mon, 10 Jun 2024 13:25:14 -0600
Message-ID: <20240610132513.1.I6434acf426183b4077ba3e8af4eccaa5921c6c2f@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept another DID:VID for the next generation Google TPM. This TPM
has the same Ti50 firmware and fulfills the same interface.

Signed-off-by: Jett Rink <jettrink@chromium.org>
---

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index 86c9a1a43adb..d9b6abdcda5f 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -32,7 +32,8 @@
 #define TPM_CR50_TIMEOUT_SHORT_MS	2		/* Short timeout during transactions */
 #define TPM_CR50_TIMEOUT_NOIRQ_MS	20		/* Timeout for TPM ready without IRQ */
 #define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID reg value */
-#define TPM_TI50_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
+#define TPM_TI50_DT_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
+#define TPM_TI50_OT_I2C_DID_VID		0x50666666L	/* Device and vendor ID reg value */
 #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
 #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
 #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
@@ -781,13 +782,17 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 	}
 
 	vendor = le32_to_cpup((__le32 *)buf);
-	if (vendor != TPM_CR50_I2C_DID_VID && vendor != TPM_TI50_I2C_DID_VID) {
+	if (vendor != TPM_CR50_I2C_DID_VID &&
+	    vendor != TPM_TI50_DT_I2C_DID_VID &&
+	    vendor != TPM_TI50_OT_I2C_DID_VID) {
 		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
 		return -ENODEV;
 	}
 
 	dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
-		 vendor == TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
+		 vendor == TPM_CR50_I2C_DID_VID	   ? "cr50" :
+		 vendor == TPM_TI50_DT_I2C_DID_VID ? "ti50 DT" :
+						     "ti50 OT",
 		 client->addr, client->irq, vendor >> 16);
 	return tpm_chip_register(chip);
 }
-- 
2.45.2.505.gda0bf45e8d-goog


