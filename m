Return-Path: <linux-kernel+bounces-528427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71338A4179A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4873B34FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF41FCCF3;
	Mon, 24 Feb 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCSJuQ/o"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F991FBCB9;
	Mon, 24 Feb 2025 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386391; cv=none; b=HyNVMBEPVfGYhWptQHKheXpBghHDH6PdmoNpeP7aIzEgziFDHjN/5nLVmFz3ZGzGI/W7lfZXhfcoyETMEL4NPg/TynFOGaLlghcFmTov8TKK2EDTzmWnqkCgwnVrzy09DqIzulDQpb3tvbuqFWQLxzJyrjSGIP2JqDFxjdV820c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386391; c=relaxed/simple;
	bh=2X7tfsUl5HpGxgWVGWz6C35KUS72yu1Udq+8hJpnhsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mwla6RnAEroaR+3ipbuE8CJfMUwyS4fh0KzuucXedN/Odv+JU1sBgUaKC/wTo5sNf6y2anhiVX0/kOHBDpTLbzqZKntUDrcV8/h0mrignxhn56i3Fe01L0zU2Offf90lNxuBi7Y/CkgqZrR2SOaQurYGHc43hMwXlFrm8r1+Lec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCSJuQ/o; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c8cf98bbso91743805ad.1;
        Mon, 24 Feb 2025 00:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740386390; x=1740991190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2THBoMljTsJt94BbNpCp/YTgHXkT5f9Tt/dpOHOy6U=;
        b=BCSJuQ/oevUz4XpUI2xlPrOLiGD5n5/DRKDYfDaGuDTfUJlhJk4De0MSWXKqQNVhli
         wKQT83N14wU4Tooi41wnPJOc8ULhFI2w83pl7hiyKnxF1En9096B1OQHJSk1uO5dqfV0
         mrkVptT2pX49BGStNTBZjbKMzP/K/0euaiyJuRX698Rt9OizcVzBo9RLktjs77/YOyIY
         BwhdcnXq4i83bqMur1J+RgqUr+DpP9fS7AvKRtsHVT2iNGjwGtJMQetQu5n0kvbshPVP
         Uaty9miTGbuV0tQ8ZMSOmZe/wXPddiDhU3HI4g53uAlwM+ihY6xmoc+aP2TrDz/jIl2d
         HgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386390; x=1740991190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2THBoMljTsJt94BbNpCp/YTgHXkT5f9Tt/dpOHOy6U=;
        b=mkvZJC/F7LMU1R1NndTPdHLeu6u1PicXBC6QG3VLPUBVfA3/kpAg6ZZdtBhqvYP5Jx
         JKazxjbKcCfQ6yeLHKltEbez8BHjPxE7rVUlL8Ci1EOlAG73mg2zdg4/mUVVYP0yZG/e
         fVKhESxzUl648H5xLdtjNG0/yDwZe0z0C6GOXV43dTc8kaTT9nq+c7etR7AWmZKx1wZF
         uSelKWqZFy3znQRG4e/KZDzYFX0ArtcZ5zfNbq/MREsOOtit6OtkLbeibX9yBfRFCBYx
         +02CJgzR6DH2P4fZSFomYW0AdaQR66gZlY2j6kZ5cLZ3RDpgIuAn+ezo9CSCYagJ75e5
         ul8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFlGihMFW4tn+EFW9OF5aqWt6uAJx7d3+NcQPYNZRh/sPujhNRonSSVNtmadb7StUOlmzUFvIjBoSg@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDJRYZFSpRiIOVUEdeDoMkhjwnPANm9ppbrUwYJbIa9/6n0E3
	xqztcBlgPrb2/0IRpQckEsYR0Rg+KNidMF0X5d1krwpybH1FhUzVfHG0SA==
X-Gm-Gg: ASbGncsOuiQHbIT+unimDbLodfhDyaNi+gMca+muHsmfI2SqOYwfTme5FdpZpvG/NIU
	nsube/3DcQYSLy4kIn9Tpr2YC9Jm73VIGUFo/B6c1TD2CsDuPHvEsYEkluj6OlxF1arP8h0q6MG
	NuAkkcsuVJJM2m0JKXyxzh9vpEPD9SkUusDYxF+u+AnJOfvFg75h4UDyM+u/Hg/MDrjIxpFbKN7
	IID2H3IWqdDxMfMJm9uyxxpbQXM4ejcyFvCYpYu7ohAMfD4aDpTkeq5W1QEvnDyDcAuEFYS66sn
	uVrfj6t9sJRrTcLKLWP3sPhWlPjIcOd7BNqe
X-Google-Smtp-Source: AGHT+IHPyq8u2np9gCVs9VjWgMl09L8z2ydAhriEM3Mo//Ztd8gpkj+ZbDCs/Wj2n6eQzW+dpn8+6A==
X-Received: by 2002:a05:6a00:3d0a:b0:730:888a:251d with SMTP id d2e1a72fcca58-73426d9ee22mr21997073b3a.20.1740386389638;
        Mon, 24 Feb 2025 00:39:49 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327590ff12sm14634793b3a.115.2025.02.24.00.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:39:49 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v4 2/5] i3c: master: svc: Add support for Nuvoton npcm845 i3c
Date: Mon, 24 Feb 2025 16:39:05 +0800
Message-Id: <20250224083908.1880383-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224083908.1880383-1-yschu@nuvoton.com>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
Add quirks to address the npcm845 specific issues.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 56 +++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6057d8c7dec..8834f87a4767 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -32,6 +32,7 @@
 #define   SVC_I3C_MCONFIG_ODBAUD(x) FIELD_PREP(GENMASK(23, 16), (x))
 #define   SVC_I3C_MCONFIG_ODHPP(x) FIELD_PREP(BIT(24), (x))
 #define   SVC_I3C_MCONFIG_SKEW(x) FIELD_PREP(GENMASK(27, 25), (x))
+#define   SVC_I3C_MCONFIG_SKEW_MASK GENMASK(27, 25)
 #define   SVC_I3C_MCONFIG_I2CBAUD(x) FIELD_PREP(GENMASK(31, 28), (x))
 
 #define SVC_I3C_MCTRL        0x084
@@ -133,6 +134,32 @@
 #define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
 #define SVC_I3C_EVENT_HOTJOIN	BIT(31)
 
+/*
+ * SVC_I3C_QUIRK_FIFO_EMPTY:
+ * I3C HW stalls the write transfer if the transmit FIFO becomes empty,
+ * when new data is written to FIFO, I3C HW resumes the transfer but
+ * the first transmitted data bit may have the wrong value.
+ * Workaround:
+ * Fill the FIFO in advance to prevent FIFO from becoming empty.
+ */
+#define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
+/*
+ * SVC_I3C_QUIRK_FLASE_SLVSTART:
+ * I3C HW may generate an invalid SlvStart event when emitting a STOP.
+ * If it is a true SlvStart, the MSTATUS state is SLVREQ.
+ */
+#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
+/*
+ * SVC_I3C_QUIRK_DAA_CORRUPT:
+ * When MCONFIG.SKEW=0 and MCONFIG.ODHPP=0, the ENTDAA transaction gets
+ * corrupted and results in a no repeated-start condition at the end of
+ * address assignment.
+ * Workaround:
+ * Set MCONFIG.SKEW to 1 before initiating the DAA process. After the DAA
+ * process is completed, return MCONFIG.SKEW to its previous value.
+ */
+#define SVC_I3C_QUIRK_DAA_CORRUPT	BIT(2)
+
 struct svc_i3c_cmd {
 	u8 addr;
 	bool rnw;
@@ -158,6 +185,10 @@ struct svc_i3c_regs_save {
 	u32 mdynaddr;
 };
 
+struct svc_i3c_drvdata {
+	u32 quirks;
+};
+
 /**
  * struct svc_i3c_master - Silvaco I3C Master structure
  * @base: I3C master controller
@@ -183,6 +214,7 @@ struct svc_i3c_regs_save {
  * @ibi.tbq_slot: To be queued IBI slot
  * @ibi.lock: IBI lock
  * @lock: Transfer lock, protect between IBI work thread and callbacks from master
+ * @drvdata: Driver data
  * @enabled_events: Bit masks for enable events (IBI, HotJoin).
  * @mctrl_config: Configuration value in SVC_I3C_MCTRL for setting speed back.
  */
@@ -214,6 +246,7 @@ struct svc_i3c_master {
 		spinlock_t lock;
 	} ibi;
 	struct mutex lock;
+	const struct svc_i3c_drvdata *drvdata;
 	u32 enabled_events;
 	u32 mctrl_config;
 };
@@ -230,6 +263,27 @@ struct svc_i3c_i2c_dev_data {
 	struct i3c_generic_ibi_pool *ibi_pool;
 };
 
+const struct svc_i3c_drvdata npcm845_drvdata = {
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY | SVC_I3C_QUIRK_FALSE_SLVSTART
+		| SVC_I3C_QUIRK_DAA_CORRUPT,
+};
+
+static bool svc_has_quirk(struct svc_i3c_master *master, u32 quirk)
+{
+	if (!master->drvdata)
+		return false;
+
+	if ((master->drvdata->quirks & quirk) == SVC_I3C_QUIRK_DAA_CORRUPT) {
+		if (master->mctrl_config &
+		    (SVC_I3C_MCONFIG_SKEW_MASK | SVC_I3C_MCONFIG_ODHPP(1)))
+			return false;
+		else
+			return true;
+	}
+
+	return (master->drvdata->quirks & quirk);
+}
+
 static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
 {
 	return !!(master->enabled_events & mask);
@@ -1868,6 +1922,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, master);
+	master->drvdata = of_device_get_match_data(dev);
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1960,6 +2015,7 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
 	{ .compatible = "silvaco,i3c-master-v1"},
+	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
-- 
2.34.1


