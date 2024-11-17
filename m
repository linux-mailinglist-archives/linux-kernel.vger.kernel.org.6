Return-Path: <linux-kernel+bounces-411992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DAF9D0215
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 06:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48D1B21B10
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 05:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15B17BA0;
	Sun, 17 Nov 2024 05:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="2XpYOsZ+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541DF4ED
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731821116; cv=none; b=ZnY5YagIdJjmbd+pmV3zF74vw5Zshx20LAn0u6yJHymI8+/rmQ5jGxxLmyRhBVVl15zTI34LLX85erf1Wtdjb8hl8a181vpqfo0rlwJpYzLi0hyZsBKMIvS8x1qSFcDr7gDNROxWgcB3qs6nEqVjgsYRPnRJd3/EGBWySzeInZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731821116; c=relaxed/simple;
	bh=EV31Kyi+ba116VpSGTDegR88Sau8O7OfMNVUSkJ7Tu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BduVAnp6F7w7kNXBH7i1LVEf2Vi67KBC387QCOHDzoVPFI5wOHxDf2iykldgFgwD8nHthutWAkAq2uQU8Khd5BR3Q1TdGA632iupHm5GXfMtBucxfq2XEex4Zh7YRfm+D2qs4EgRVaSomirTaRmGy/oo7IYfL1n2VunOQ8ZG7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=2XpYOsZ+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72467c35ddeso2238343b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1731821114; x=1732425914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1VW7Eea+1GT6H8MpnapiTmJLeEwFPnQEnPcJgx9UmgI=;
        b=2XpYOsZ+zV8IguskPdxsY2bKfwbyUTslGmYyU/OAcvAuZVaUbJMuzmTlpbtrOKxGhj
         4svEzlGmiMwu8W7GIL20Akm/nCZ46i2wBTxJyHr+r+g+2smhinyNxyf0CAlAuQ6KL4rr
         aFQT7rCxrFpKdTed28biv1tx23Lw+GOnVzPTC8vOY1vsOn5PSQGr+Ud3Ft33MeNrCH20
         XuSrtviRTN8NIHYHzdzQum2nr9tQ75Zbt9qBadg7HN2g5CuY6V6RwS+gn7aetl7SEOQA
         IRAWyVytiAKEkiUKYmCq7/Lr04Vu1WaDczocKOb4/73AvvaZO4B7l6497Y/RaWcVqrRm
         eYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731821114; x=1732425914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VW7Eea+1GT6H8MpnapiTmJLeEwFPnQEnPcJgx9UmgI=;
        b=aK6vcw8w21f9tS1e/VLq45815fMihMV9RtuuOwiuikWDuI6ltNX3G4nF5IF1AboBlr
         Zk05si252M7TKVyTq42Mf/sys/ZtNPQGHmeImY5ICWp8pxonN52PfbimHO9K6f78wgIy
         R2E/kq01R6/ew2JnIb2NToSyu3rH6YQWUop1EGlQvRpnw3EtnxAa5Xa5vN4rk2h9k15O
         DAuaz17iu7KK7E1SaVG85ss9kCwl8rUdvbXlF0J7iNNJe9EGk+6jRV6aKR8xF1/cPP8K
         5A5R1WTkFXePPMPGw1P3+lUahtt/n7VAwFaSlZjNwqiNV2WmkexsIFw6Rghae/Ib+jIp
         8Kiw==
X-Gm-Message-State: AOJu0Yx04w4EDCq24aDUJEvGdwWb4SK/oPqS9ki5TUHNzPVLd3TmTrzH
	c10g/zpE2RLW1W4W3tUnxez+ENxjdFHr676FoeFIexyNVT10F3TYqa+VyjDV
X-Google-Smtp-Source: AGHT+IGIKhBFzH/0EKB/6b5lM8SAr8TWxF0Njpp5ye0c++OJX5e0IdyZKNZw2hCNJzCUyGgKB+BcJg==
X-Received: by 2002:a05:6a00:10cd:b0:724:7843:4cf3 with SMTP id d2e1a72fcca58-7247843508dmr13674357b3a.0.1731821113905;
        Sat, 16 Nov 2024 21:25:13 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:96f6:cb09:e09e:fe02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1a69sm3956170b3a.141.2024.11.16.21.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 21:25:13 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: Johan Hovold <johan@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] gnss: mtk: Simplify return variables in mtk_set_active and mtk_set_standby
Date: Sun, 17 Nov 2024 14:25:01 +0900
Message-ID: <20241117052501.1138926-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simply return directly instead of assign the return value.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/gnss/mtk.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
index c62b1211f4fe4e..be20f6d6470736 100644
--- a/drivers/gnss/mtk.c
+++ b/drivers/gnss/mtk.c
@@ -24,25 +24,15 @@ struct mtk_data {
 static int mtk_set_active(struct gnss_serial *gserial)
 {
 	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
-	int ret;
 
-	ret = regulator_enable(data->vcc);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regulator_enable(data->vcc);
 }
 
 static int mtk_set_standby(struct gnss_serial *gserial)
 {
 	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
-	int ret;
 
-	ret = regulator_disable(data->vcc);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regulator_disable(data->vcc);
 }
 
 static int mtk_set_power(struct gnss_serial *gserial,
-- 
2.45.2


