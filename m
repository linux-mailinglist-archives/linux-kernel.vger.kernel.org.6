Return-Path: <linux-kernel+bounces-548381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F74EA54412
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DDA3B0DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68CA1FDA65;
	Thu,  6 Mar 2025 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIkB2eni"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814162036F5;
	Thu,  6 Mar 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247694; cv=none; b=AMChA7HYSSg8mEinJY+/+pFXf6URLH4j1fHkSbDnEsLkbepJnX3EQu/PPgHvkNbw9YQk6ypr+yfhKm3IyHk8bwRrwsAdhWdDDqCN0Nf8lNOxHa3FuI2XkMkysWSA3mooO1pGZQaVivKYqnS3vxLSfKf6kOwDiGwD43s/NaFEBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247694; c=relaxed/simple;
	bh=zhogwmaQprEJIOZabiKKa/2rYvbETYpUnpa2KFbJWEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isrldIyy7Nu72P0XO3BpEWyHmkY2Mj5i8PPgQOnOx2YKFhqAP6g5QCQhNx7fjTG4F3gXHYfSjmY/nVaQzUXB1eikkqsBNhdsjpBQGm+Mp+zPDsVoYYf86CrzwcAnupMHq4q2ejv0Ih80C33PnvuOed+j83DC2B5b9e3gdV5u/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIkB2eni; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223cc017ef5so5287775ad.0;
        Wed, 05 Mar 2025 23:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741247692; x=1741852492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeHU0+uQ+ewEIetG9U1VzF4scs/x4AYkl7k9gMV2eYc=;
        b=gIkB2eniK6WwiI9lOmcRvSWVB6Hw+lRt1KBLKy1ViTE2XDiciZ+am1YgcCyUYMm14f
         RbrH0AZBL6a0U/6zL3JopkoYRMHyiUGh2w4j9viutvKzzyndfvhwB1eZfFyppCr1wK5j
         5c4BqYb5O88rxxUC/oKFuDyb+A7gasNSUPzY/RWJ2l3S/BMmoMTbB3knwB4JXSl6LUAy
         eI6pRlICQhwXAiD/nJyvH6a58Z32eonXDlwR12Xkzhs1b7ofR+ydsC0YxO6G3dDmqp7A
         ntP48C6JdOcfLWS01LWVAvqwsdkNu/GfqNB8QRF3sI4h77ItsHq2yOhtI5ZJ80Ih8wYR
         KMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741247692; x=1741852492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeHU0+uQ+ewEIetG9U1VzF4scs/x4AYkl7k9gMV2eYc=;
        b=k93p9+oE8cdpUwIVHXs5V2iyOpvKLeLhMEHMN6Fpik6G9Jo8dcsLctbzhuebkhDnwS
         eu8Cc0OvmAbRyhNPeXF5PashlbqbjNYbRjRCFLB8RvIbS0+6WVomL6O0gnDKkc6Yo+FL
         ckgUJJTVp21Hri25ibo/GmtF3tipyq2nF/6rAHVRWChZnW9gwY2f4lCFLGyjy8J+IYgG
         O+Sla3QuQQdjdxxabEAQHqVSnjGnIo8p3XH57rP2h3UTPFEowNCELW0n6KC3yh6PSkB2
         EeCsYdarBeO38OacN+RS000p7xae1mJ3Tia8Wwv3zMOxUXlMeq+6g9wMJ9f6tGc4YR8s
         lKOg==
X-Forwarded-Encrypted: i=1; AJvYcCXOEYlUmQIAcn8VHf8cq4z9YRdhPl9p/Y517WVuTg/Cy39AS1HtGtdnTrtdxX/7kt4gimnF9AT4FGII@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJmxuVmfXbInl8008oLbs5PP6EIgw6Z/w2Lfx7c96HjrLfjh5
	fVGWZ2wn5W7WmFGZR9OAcI+9jh7lPv65aaq84LEbtNKl9WH6jGFW
X-Gm-Gg: ASbGncugJcCQegWh8Ej4Ty6ivJ18DSA88+kBVpMkG1Yegb4Bz6lteBt9dZFrhNZDDEd
	VAHXG0zQvWXA1ZwR/SkVH48Xpj7wT6+MQfIY3KxoRr7/smeB71bkU4wh13UTFtEwUHxVo2QKeHf
	/YZbpCi+09kTj0hUPr8YFkASAkbkdp30KhhfpFpeNZpfOySZF3mAOry9KqAptwRvqMWy7SOUbj9
	Pqt2gnc4F0HzCgTG/DDAKZrFD5tLfpCivVcx7501RBTqzd4zVhIAjUDdvpa1S2vhj6cqJs4am7E
	ppEvyrP/PDqcof8QsTKsRJZ5Zj+akfH1aXnHhShOkqbhGkr6Bs8N61s=
X-Google-Smtp-Source: AGHT+IGNTTEhiHJu3DzwlvrowX7noAbEyvQn1CqmoH1Ut3T89pAMQ/uSrN2Xy6F5yWg7r2FyzlOwew==
X-Received: by 2002:a17:903:fa7:b0:223:5525:6239 with SMTP id d9443c01a7336-223f1d0fe68mr106221875ad.38.1741247691779;
        Wed, 05 Mar 2025 23:54:51 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa448dsm6085485ad.210.2025.03.05.23.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:54:51 -0800 (PST)
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
Subject: [PATCH v7 5/5] i3c: master: svc: Fix npcm845 DAA process corruption
Date: Thu,  6 Mar 2025 15:54:29 +0800
Message-Id: <20250306075429.2265183-6-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306075429.2265183-1-yschu@nuvoton.com>
References: <20250306075429.2265183-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

When MCONFIG.SKEW=0 and MCONFIG.ODHPP=0, the ENTDAA transaction gets
corrupted and results in a no repeated-start condition at the end of
address assignment.

Workaround: Set MCONFIG.SKEW to 1 before initiating the DAA process.
After the DAA process is completed, return MCONFIG.SKEW to its previous
value.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 30 ++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 1cab5b8594de..c086e0e38279 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -32,6 +32,7 @@
 #define   SVC_I3C_MCONFIG_ODBAUD(x) FIELD_PREP(GENMASK(23, 16), (x))
 #define   SVC_I3C_MCONFIG_ODHPP(x) FIELD_PREP(BIT(24), (x))
 #define   SVC_I3C_MCONFIG_SKEW(x) FIELD_PREP(GENMASK(27, 25), (x))
+#define   SVC_I3C_MCONFIG_SKEW_MASK GENMASK(27, 25)
 #define   SVC_I3C_MCONFIG_I2CBAUD(x) FIELD_PREP(GENMASK(31, 28), (x))
 
 #define SVC_I3C_MCTRL        0x084
@@ -150,6 +151,16 @@
  * If it is a true SlvStart, the MSTATUS state is SLVREQ.
  */
 #define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
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
 
 struct svc_i3c_cmd {
 	u8 addr;
@@ -259,6 +270,13 @@ static inline bool svc_has_quirk(struct svc_i3c_master *master, u32 quirk)
 	return (master->drvdata->quirks & quirk);
 }
 
+static inline bool svc_has_daa_corrupt(struct svc_i3c_master *master)
+{
+	return ((master->drvdata->quirks & SVC_I3C_QUIRK_DAA_CORRUPT) &&
+		!(master->mctrl_config &
+		(SVC_I3C_MCONFIG_SKEW_MASK | SVC_I3C_MCONFIG_ODHPP(1))));
+}
+
 static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
 {
 	return !!(master->enabled_events & mask);
@@ -1144,7 +1162,16 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	}
 
 	spin_lock_irqsave(&master->xferqueue.lock, flags);
+
+	if (svc_has_daa_corrupt(master))
+		writel(master->mctrl_config | SVC_I3C_MCONFIG_SKEW(1),
+		       master->regs + SVC_I3C_MCONFIG);
+
 	ret = svc_i3c_master_do_daa_locked(master, addrs, &dev_nb);
+
+	if (svc_has_daa_corrupt(master))
+		writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
+
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 
 	svc_i3c_master_clear_merrwarn(master);
@@ -2031,7 +2058,8 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 
 static const struct svc_i3c_drvdata npcm845_drvdata = {
 	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
-		SVC_I3C_QUIRK_FALSE_SLVSTART,
+		SVC_I3C_QUIRK_FALSE_SLVSTART |
+		SVC_I3C_QUIRK_DAA_CORRUPT,
 };
 
 static const struct svc_i3c_drvdata svc_default_drvdata = {};
-- 
2.34.1


