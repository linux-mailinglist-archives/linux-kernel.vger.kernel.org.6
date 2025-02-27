Return-Path: <linux-kernel+bounces-535667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E420A475BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F116816B7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885E7221DB5;
	Thu, 27 Feb 2025 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQJWwfNe"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4422206BB;
	Thu, 27 Feb 2025 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636121; cv=none; b=d/sFyRNSUbKryEG4IfKZ60MnD0aDjxwHQ95nTaI4E3snhC20WloizyEAdyZTId2RXH/PhUGorL0MsO41CfsMZ1w5NaCvBja0P8moTFidcjqd77fOpK/lYkQ3JNXBnvrDod7e7miiO0Yir/9Bfs2sLnXyl+ELWB5NfArq4b1Yo3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636121; c=relaxed/simple;
	bh=OWeq6d6NKg5biA4HMES8aq5niN8erXf9y3LUci07koM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECZwzfgQi0VNrzOlU9nWEnoPaCvkt+Z8g1LWQQfBmsVOh2ZYrrJFc/f9iMiGHT8QyRmbT2/tfElGUtkOm3Fi9KgGKIYzwfm0lME1FeZElVa6hJfvyDbfeOhzhzTvxJUpQihe8EulsKR04RyJoqbsKcQdEctPmGM8Xxgm9buD/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQJWwfNe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c8f38febso8876635ad.2;
        Wed, 26 Feb 2025 22:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740636120; x=1741240920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OREH+iLC47dZ2hUuoqhiGCsdCQC5cRnPwerNbjmWOc=;
        b=AQJWwfNeCZwhlSO5WLKV7ysbmXelBcG1Q6pgW+1nRd+LamGrVTBLmCaluypcAh3jhg
         wu2uYgUeAVNGfP+QkHcdM+dJH1rEJ1qLf4BBZO1Wv21/AgNbUnd4ll7cVKQUi0qkvphb
         SNVGKM3MTUwSIICWuMPfQEK4NcgMb/yjZ0GTjAKbKP8ZKVzxx1SJ5vaeGDq1u17Nz/uP
         lzrK5uGCX6lMlznP8RWcmnDo9UeMUN2QaUa5H6CQ+V7b061MOPqwRg0kUxnru9+z5Zoz
         wvauMvv0mvNbZJhzheP69CWHixVpIvQdxggbXHQbGLd+haOfHnabZP+zZGeHT3aa3a3F
         y9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740636120; x=1741240920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OREH+iLC47dZ2hUuoqhiGCsdCQC5cRnPwerNbjmWOc=;
        b=INZGxv+2lUmE4GFEbQbNkbsyCU3ElpH95B9JZHLbDLTKc/zYgmCun+8s++Ogew+Wvq
         HzfnGFhGYLHceH1qC3RuWUeNikvdr6ioth789h3WMZwaNofhR4qKvMQtLC1tJfXhayrp
         iPxBqCpew3FHmLJaXBAdEtMSBIi2gjc6YQ/mb4VTsE4tQ16vZuBuytE07FQyxxevgwgi
         g49v9FtNWPkPeKzz5tyNr62O2Ipja/52hD4qppYr2aJFe25ubXWK5YOuB4wBhHqf3XFc
         cv5Lq3miaSq4EPW9+iAVbiigqs6S1MXSnmID3tIfoKbg2PkRGzW2cqTvWHB769UosQkw
         Xh5A==
X-Forwarded-Encrypted: i=1; AJvYcCWzV7ghNqofyp1B7WwB1SNgS1hsZeX8JkixVxI3AASZzvG8uztZBlIE2io8zwyDYLJFPrJh/seDZFLx@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJi+7nlcvN4VCkHIdKbuIKRgaVQTFYb1BVTHOs/MhW83CP5mM
	EIwmAxAsUvzAiQx+IRwIPOUxD4iTe5i5J4auDWqqduk+gCXX8fhc
X-Gm-Gg: ASbGncsDMkGnLfRnVws2Gu3iU//mUmasSVy+tP9rqM4uLZWbHLYIQH5bZtG3x44ydO4
	H2/Lu1zLcTTS7kyEUI63UEAN41jnkTyXTHyzZG930KnQUQHqIDK+lEQAm2tyJ1aOGcS+yC6NA2n
	hlE1/ecb8Uhysr3H9zpnlVzwGFApzS6uTy3IwBqOLvN7HVl3rpfI2XaoRJqVhGrineXLeGrRsgh
	2wfCFB5SZKRTJisORWHI7F6Rfd6GEA+Gxp8UHgZccI5pV2J+w1SP+HUUcQ9tQEOV+ROgyrqtqY6
	g1k+z3Ucn24b6BIsEBSidjYXaq1YL9FEjZdB
X-Google-Smtp-Source: AGHT+IEqIBEjElcYfutyZm2+ie7egiFz7kMRAMyX+Q/RVxplxMI9mjXMEKkY217XYnf9eGB2wXWsGg==
X-Received: by 2002:a17:902:d502:b0:21a:8300:b9ce with SMTP id d9443c01a7336-221a002afb5mr415841785ad.49.1740636119772;
        Wed, 26 Feb 2025 22:01:59 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe824b67a1sm2728177a91.0.2025.02.26.22.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 22:01:59 -0800 (PST)
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
	yschu@nuvoton.com,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 5/5] i3c: master: svc: Fix npcm845 DAA process corruption
Date: Thu, 27 Feb 2025 14:01:31 +0800
Message-Id: <20250227060131.2206860-6-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227060131.2206860-1-yschu@nuvoton.com>
References: <20250227060131.2206860-1-yschu@nuvoton.com>
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
 drivers/i3c/master/svc-i3c-master.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 952afc75f6e4..774f94ee761c 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1169,7 +1169,16 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
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
-- 
2.34.1


