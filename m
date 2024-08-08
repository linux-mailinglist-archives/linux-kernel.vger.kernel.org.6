Return-Path: <linux-kernel+bounces-278977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F7E94B750
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1043C1C235B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4118B490;
	Thu,  8 Aug 2024 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J5m91NDS"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A91898F7;
	Thu,  8 Aug 2024 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101114; cv=none; b=ChBLokSDyH2uVcLdlVQGHfJUXFPVcgsdpMP5szHdVDImRmHU4s0RwKeXXbMYAMpRl4p5rewbOWCUntH5tqKLEA6vrh/yeTNkzcD+xWZHWJRKvu31vBgiCP5yDbd5tRe1GIH05z/XiIydRgz13hyoAhlkZ3aYyRbL1OahUGeSeDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101114; c=relaxed/simple;
	bh=q6diW6Xmhy6S7ScZm1SnWKBHnFWOZzCd4opBp581G+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFqnqpEDcFWl2nGRKbB5mWi1+mxIOAIVVwAoTNPhPnp2wI0RvbaXqKhPgQezlCR0iHnNHZnxhvvsenHJFp44O9QwRU0y7qfgUhQQcWjdp/i89SLGjcskr2g+1SzhisqNOQGM6koBBRyZxPO2rgzGodVhkxfG+kTrAjZzcQ9QcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J5m91NDS; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 49D7EC0015;
	Thu,  8 Aug 2024 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDkbjpdwehTbuqGwy1A5u6/MWoALzTXa6kx6sAsjxTM=;
	b=J5m91NDS6uxe9OXJ7dhzneA38q0LATdq5KeIgX6yMgd65tfHFx3OpZDBETqRdt9QR1Ghrt
	noNMpb7t0LUIdsiTnXw+CJpWGLeH7hF6kpTy8VrcPWS8Y5KKZhfHZduFzlbcV0iQl3n2sd
	kqsfu9IMVB2HE2KHl89jgbn9+7iqBfisa5/a5etX76Bm/E1KotSbTnflJWdph+BQDlwtqM
	17/mVR0di7w5fY6WODhp5lzZV2vZV4UyqJlhgCanEaoVWfSMz8Q1Xws4ktFqAZY7BK4a3Q
	0GjZ5T2qeHniP0M74Z376XeW2hFBNManPimP//mjZzAzq5h8bVioXkt/3gmrBg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 16/36] soc: fsl: cpm1: tsa: Introduce tsa_serial_get_num()
Date: Thu,  8 Aug 2024 09:11:09 +0200
Message-ID: <20240808071132.149251-17-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

TSA consumers in CPM1 implementation don't need to know about the serial
device number used by the TSA component. In QUICC Engine implementation,
this information is needed.

Improve the TSA API with tsa_serial_get_num() in order to provide this
information.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 56 ++++++++++++++++++++++++++--------------
 drivers/soc/fsl/qe/tsa.h |  3 +++
 2 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index c540cf9144c0..f0889b3fcaf2 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -231,6 +231,39 @@ static bool tsa_is_qe(const struct tsa *tsa)
 	return IS_ENABLED(CONFIG_QUICC_ENGINE);
 }
 
+static int tsa_qe_serial_get_num(struct tsa_serial *tsa_serial)
+{
+	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
+
+	switch (tsa_serial->id) {
+	case FSL_QE_TSA_UCC1: return 0;
+	case FSL_QE_TSA_UCC2: return 1;
+	case FSL_QE_TSA_UCC3: return 2;
+	case FSL_QE_TSA_UCC4: return 3;
+	case FSL_QE_TSA_UCC5: return 4;
+	default:
+		break;
+	}
+
+	dev_err(tsa->dev, "Unsupported serial id %u\n", tsa_serial->id);
+	return -EINVAL;
+}
+
+int tsa_serial_get_num(struct tsa_serial *tsa_serial)
+{
+	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
+
+	/*
+	 * There is no need to get the serial num out of the TSA driver in the
+	 * CPM case.
+	 * Further more, in CPM, we can have 2 types of serial SCCs and FCCs.
+	 * What kind of numbering to use that can be global to both SCCs and
+	 * FCCs ?
+	 */
+	return tsa_is_qe(tsa) ? tsa_qe_serial_get_num(tsa_serial) : -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(tsa_serial_get_num);
+
 static int tsa_cpm1_serial_connect(struct tsa_serial *tsa_serial, bool connect)
 {
 	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
@@ -271,26 +304,9 @@ static int tsa_qe_serial_connect(struct tsa_serial *tsa_serial, bool connect)
 	int ucc_num;
 	int ret;
 
-	switch (tsa_serial->id) {
-	case FSL_QE_TSA_UCC1:
-		ucc_num = 0;
-		break;
-	case FSL_QE_TSA_UCC2:
-		ucc_num = 1;
-		break;
-	case FSL_QE_TSA_UCC3:
-		ucc_num = 2;
-		break;
-	case FSL_QE_TSA_UCC4:
-		ucc_num = 3;
-		break;
-	case FSL_QE_TSA_UCC5:
-		ucc_num = 4;
-		break;
-	default:
-		dev_err(tsa->dev, "Unsupported serial id %u\n", tsa_serial->id);
-		return -EINVAL;
-	}
+	ucc_num = tsa_qe_serial_get_num(tsa_serial);
+	if (ucc_num < 0)
+		return ucc_num;
 
 	spin_lock_irqsave(&tsa->lock, flags);
 	ret = ucc_set_qe_mux_tsa(ucc_num, connect);
diff --git a/drivers/soc/fsl/qe/tsa.h b/drivers/soc/fsl/qe/tsa.h
index d9df89b6da3e..da137bc0f49b 100644
--- a/drivers/soc/fsl/qe/tsa.h
+++ b/drivers/soc/fsl/qe/tsa.h
@@ -39,4 +39,7 @@ struct tsa_serial_info {
 /* Get information */
 int tsa_serial_get_info(struct tsa_serial *tsa_serial, struct tsa_serial_info *info);
 
+/* Get serial number */
+int tsa_serial_get_num(struct tsa_serial *tsa_serial);
+
 #endif /* __SOC_FSL_TSA_H__ */
-- 
2.45.0


