Return-Path: <linux-kernel+bounces-436935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD79E8CD6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C917281B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B80B215182;
	Mon,  9 Dec 2024 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="Wg4gUh25"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E103215160
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731200; cv=none; b=PY+Bof7trEBC97ycs7YecHIAFmM/oSkbJ4XtZ6/10D7WGqREZjdxlWs9r1I6AmWNQFk61nRqm17dz2nvu/vr4yJf5B097gdQwXOKnN/oAxupYZlWFctoNfKOVqqOpqaQ3yEQ3cTZnvflDp5nD4bZGTARD0CINX5sx4LcwpO1kAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731200; c=relaxed/simple;
	bh=UsGGTZ2nD/E5yGIXaoCFDWmRL4HG9Qwb6kXnKLoJ/7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bbpAeFkwCFFDTWtIOVPsSZgCt9/7h4/RDnjV0uWNUIWRDPVdwfZ5djMo7zAD6+SHr30ce3VPR5IEZ58zQYI5DVSoGvKBDPD7Fm5JL+/sCK6i7PkP9bSbPY1m8BiFv81Me4TqcaAclKcc1bqVbVa9BfYrx6nwiPm1u6QiE8Lfq7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=Wg4gUh25; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30167f4c1deso12283741fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 23:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733731197; x=1734335997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lyaICWOg29JMNgD4hxKKtD1x7CHdhnKiLgfWSMOBd7Q=;
        b=Wg4gUh25f40I7NOy2JFwLuQTS6bWAAAG899qyUNhT0PzN2U67MGEGoy1+4GveIHhxw
         qbLtb0yN55Li1YThiPGt2rCx3iSBD/+JkmxmBYrC90uLflhAmaO39EN5nCj+OO71P+Fi
         EiBZaTVMbarDWKRS3AFNJOyvj8Zsc+2w2niF9Rg7mGrr0QKJWrrw2zUfnRmAVGV4i3mO
         nHrOOVjArw/LIlLPRkgpUN5DGc476mWjOLUvY/e9Eh/NjOemo0XbQt2mzuVe9+QzIJeD
         wivnak6//zK4DKNb3GUR/34dp6Kysla3aWBFtbVjerlSPMaFoEKj7YCtWrFrjhXOjUw/
         hnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733731197; x=1734335997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyaICWOg29JMNgD4hxKKtD1x7CHdhnKiLgfWSMOBd7Q=;
        b=CwHhr+PW2C2SM9Tqybr6Q1tzc2z/bP/aQUt6I5K1tSY+ipav8cDqkggKU8GNUFxKNe
         qz1ocENNeAMoLAjo9Mkt16WWwIubFPWaLl6h89Sh3I89zzKQu8bKJTOJsbb0a9iXApPE
         eokBqPuRjls87hB5zx5gYcGaY1jf1rhQjT5gaNpjwobvwlQV3dKzl5GZgraAEpyNa9Bq
         sOGAJIc5R5trf4DUp9+FGEGdMWvmmrSXeIHmjKNjgvCXCLOv5U7AAic7qUV8cg/JJrFO
         cxuXusXhZ47eQKVtigXcr31LBu99rn2UmHDx5Onu17jqMgwjJtM7JbuB23y/p8mLTZBr
         Ec6g==
X-Forwarded-Encrypted: i=1; AJvYcCW92Ah1gTvfj4KWhlrvwSfjEcKJbji0t1FjriL8qeUZEnteUI4mh8bfk8mjCaaxTX36uXt9qpYbTA1pBow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQYNHV1GL+9XLEd68PgcPfwF/kLMwLUbJAOq21N7nApyF6RCW
	Y09Dd9+pshSknYP7UlDaL8JSqH2wSn0YMpJ+KmvdVVgSQEnFbIOV3t0DXFaM37o=
X-Gm-Gg: ASbGnctrn7kxEvTD+bwZ0Y+9o9Crjo807HcE3FUUHa3as6LweAmBZ5uWqXpFOZLxERo
	ilfy/X2z1BqJZ7EeSrSgZ0CEfwZE3U/BL+UxHT6CuEXNwSiJgyDvKNiOqyGZtA4jmcanj4ai3ny
	cYfA/37wXdJYa0M/lonLmzogkRi1YUEODCY+IxA5OW612Xa+xfsm6NBm/5zq941iLcVFuqQ7F7m
	O2INC4nOvWVKo/YWTp9DeVfswPgYAzDnhtQv2CbfV/DnH7fCZMmlsXjMZbgT4Oe
X-Google-Smtp-Source: AGHT+IH4yjPZ1ALGBr4+xtqjqm4342HJGSTD7ZfSUlKbMYjDcvCHYG3uzYKEc1m8Irx/IaUkQJYYFA==
X-Received: by 2002:a2e:86da:0:b0:302:2620:ec89 with SMTP id 38308e7fff4ca-3022620ef1dmr4409821fa.19.1733731196698;
        Sun, 08 Dec 2024 23:59:56 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-300342fc466sm8388761fa.125.2024.12.08.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:59:56 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net] net: renesas: rswitch: fix initial MPIC register setting
Date: Mon,  9 Dec 2024 12:59:51 +0500
Message-Id: <20241209075951.163924-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPIC.PIS must be set per phy interface type.
MPIC.LSC must be set per speed.

Do that strictly per datasheet, instead of hardcoding MPIC.PIS to GMII.

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 27 ++++++++++++++++++++------
 drivers/net/ethernet/renesas/rswitch.h | 14 ++++++-------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 7f17b9656cc3..6ca5f72193eb 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1124,25 +1124,40 @@ static int rswitch_etha_wait_link_verification(struct rswitch_etha *etha)
 
 static void rswitch_rmac_setting(struct rswitch_etha *etha, const u8 *mac)
 {
-	u32 val;
+	u32 pis, lsc;
 
 	rswitch_etha_write_mac_address(etha, mac);
 
+	switch (etha->phy_interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		pis = MPIC_PIS_GMII;
+		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_5GBASER:
+		pis = MPIC_PIS_XGMII;
+		break;
+	default:
+		pis = FIELD_GET(MPIC_PIS, ioread32(etha->addr + MPIC));
+		break;
+	}
+
 	switch (etha->speed) {
 	case 100:
-		val = MPIC_LSC_100M;
+		lsc = MPIC_LSC_100M;
 		break;
 	case 1000:
-		val = MPIC_LSC_1G;
+		lsc = MPIC_LSC_1G;
 		break;
 	case 2500:
-		val = MPIC_LSC_2_5G;
+		lsc = MPIC_LSC_2_5G;
 		break;
 	default:
-		return;
+		lsc = FIELD_GET(MPIC_LSC, ioread32(etha->addr + MPIC));
+		break;
 	}
 
-	iowrite32(MPIC_PIS_GMII | val, etha->addr + MPIC);
+	rswitch_modify(etha->addr, MPIC, MPIC_PIS | MPIC_LSC,
+		       FIELD_PREP(MPIC_PIS, pis) | FIELD_PREP(MPIC_LSC, lsc));
 }
 
 static void rswitch_etha_enable_mii(struct rswitch_etha *etha)
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 741b089c8523..abcf2aac49cd 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -725,13 +725,13 @@ enum rswitch_etha_mode {
 
 #define EAVCC_VEM_SC_TAG	(0x3 << 16)
 
-#define MPIC_PIS_MII		0x00
-#define MPIC_PIS_GMII		0x02
-#define MPIC_PIS_XGMII		0x04
-#define MPIC_LSC_SHIFT		3
-#define MPIC_LSC_100M		(1 << MPIC_LSC_SHIFT)
-#define MPIC_LSC_1G		(2 << MPIC_LSC_SHIFT)
-#define MPIC_LSC_2_5G		(3 << MPIC_LSC_SHIFT)
+#define MPIC_PIS		GENMASK(2, 0)
+#define MPIC_PIS_GMII		2
+#define MPIC_PIS_XGMII		4
+#define MPIC_LSC		GENMASK(5, 3)
+#define MPIC_LSC_100M		1
+#define MPIC_LSC_1G		2
+#define MPIC_LSC_2_5G		3
 
 #define MPSM_PSME		BIT(0)
 #define MPSM_MFF		BIT(2)
-- 
2.39.5


