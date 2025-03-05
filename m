Return-Path: <linux-kernel+bounces-546049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46F7A4F58B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E1F16FF65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FAC19CD0E;
	Wed,  5 Mar 2025 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng6AnIrA"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBFE18A6D5;
	Wed,  5 Mar 2025 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146293; cv=none; b=LYlOo5Yj/0cYBif3kWrA2xJ1TBzlVvcSBlxcqqNiHYVqNkKfEZIdHhrH7HvYYrBz3BqPQJOJYoWsqoAyhzi39yO6aA1MtcwAFibkaowkNN5qnv+mQY1wku9gKSNqsoAtqJejPIlggdNLFE5XPDR1ue4QNpddEMiT/zPn9Mchw94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146293; c=relaxed/simple;
	bh=G6B56ZsAoR/bIh1JopEk7s/pj+lVV13//00JyF8B6Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVOfMXPJJigAlHpTT45Fl4BsC/PguCb8kkHVXmjs5B2LOWXo7kRTSZGR+zQ40GVYLzHB/D8BDRT/73equKREwDbYx1KYXAmf3hw3UO0ZcIe2XMS0GfQ693P+AHKd0oBHoJ0GxjFggazJBp6akxrWIxGbnyV3zGA4xTJPekAuTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ng6AnIrA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22339936bbfso94647325ad.1;
        Tue, 04 Mar 2025 19:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741146291; x=1741751091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSYH5+SwcmtCe+p0n+lRYfrltYt+gVN39RZaCf2MCi8=;
        b=Ng6AnIrAIhRf4cqhhF10DZnupgtIbc66jh/XZx8DHsFA36VePuYxT9NpP6nArZeD2n
         yOa+S7SWx6OT0m+RAHsKaLqfmwqmNwxoIQgyYXp9UDhXKKN33Xopu1GSofHyImDblHMg
         CpXrDMuPxLpNYCKX0frGW0lWjr3hslJWXw4hmIfuR495m0us27Du4d/Z3D+bXNx1Sroh
         /GQ2MkaWndc4f0GCeZ+sXDII6PpSH37QwjxyrsjC8Nm2weGkQi3+4PMEmT1j53ZBGJ/0
         YfjgCIa7I3bHXP93js+Eqz4ZGbwo4dpkfUQeNrl6AqQ+kWEESnclZi/dZxSLAAQs9JXJ
         CpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741146291; x=1741751091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSYH5+SwcmtCe+p0n+lRYfrltYt+gVN39RZaCf2MCi8=;
        b=uY9ENssMDJ5kSg6JIUwQwq8iBmjyrmcJL4N0LtDuMKyKjBDSXaRUPuZqYVP3ZNLdHU
         vbNUXV9ihSX4SPsosDM0dfv0DchqDbWRaN19UWO7jGXKYyQlSAbMCUC/41YQG4Ju5kIj
         uf3ad+ihx1HmyON0CO+etQ+W/8nwvzIHPbmHGJNxYfniL/rHqzA6k6ovd2me6JT6GOMI
         uP5v3K6E95ITHjlSE3Ihc5yr3NN7HHIzxK5SE3oZBUOao+RajpH+Yft0CcGzsSLn3vC+
         CGIZSezJSknPisZZT9EzBsSUEyCYAn1tZEx0mvb22eY+QfcKi8zAZo7vtfbbUi23rNmb
         WfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVOHtXa9jXE8N8nX5GRgiFPTi/29UIv6xVpmUgULlkFfOTLsOjNLE36s4EAkqM4SjkIEcxu6IDyf1h@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1L/upqkSeY/k8h0/It2ywMZShaHVWmeekzVcRQ4PefMF8PSn
	SJrpWo4+RM4n7mtfDTB+j63+F9STYptgUSywpHSLrStCP/WFouJ7
X-Gm-Gg: ASbGncsYH6jY5dQGcR9TxUSPn8cvAx9wOczdjHGYVCUP8xSq8dudPB05ywnQAiPYEov
	9SsasH1cKklcl5oHOLaSeDwQszb0bhJpi0/3+yWeRzZxXeqM/WiL9/q4VPz5coWMCUadC/SIKFN
	LJfiLgelD4InRXd6urjnHcSnaxoJcAijTpRuJmlMedNIKMa+4zUVa3OZu+b5aJcMmHIllmcn3IL
	E0IJZLEqKVz91EZJgreq8eo16EZsVZs7YNM9Yv3YW07IU0oS9PVriVzoeftTksfALy6ro8J/Igz
	2TDb2Q6zM+nxxYIDPjJuBfyzVmrlB15oIKNxXrXR0ztEzUc8WQ4DJhA=
X-Google-Smtp-Source: AGHT+IEY/W5EzK2xQM9ApeNVjlE0dvEXpH3lZiSewWlXGQlloKZ5FWhsNbQOOWfviYkdHfIw/kEpyg==
X-Received: by 2002:a17:903:11c3:b0:215:4a4e:9262 with SMTP id d9443c01a7336-223f1c6af8fmr20720365ad.8.1741146291089;
        Tue, 04 Mar 2025 19:44:51 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c37sm102734335ad.133.2025.03.04.19.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:44:50 -0800 (PST)
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
Subject: [PATCH v6 5/5] i3c: master: svc: Fix npcm845 DAA process corruption
Date: Wed,  5 Mar 2025 11:44:14 +0800
Message-Id: <20250305034414.2246870-6-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305034414.2246870-1-yschu@nuvoton.com>
References: <20250305034414.2246870-1-yschu@nuvoton.com>
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
index 5c29912e0a69..df7eb038c6c9 100644
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
 
 const struct svc_i3c_drvdata npcm845_drvdata = {
 	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
-		SVC_I3C_QUIRK_FALSE_SLVSTART,
+		SVC_I3C_QUIRK_FALSE_SLVSTART |
+		SVC_I3C_QUIRK_DAA_CORRUPT,
 };
 
 const struct svc_i3c_drvdata svc_default_drvdata = {};
-- 
2.34.1


