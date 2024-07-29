Return-Path: <linux-kernel+bounces-265931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEABA93F7D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1291C20A24
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A23918EFF5;
	Mon, 29 Jul 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m4MueV+6"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280D18D4BA;
	Mon, 29 Jul 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262902; cv=none; b=VABnXPD7T2yK80lVkYjEcihLwc+iQf/jpoZhJe89t7KLR8KPZh0CCM36XJqTf0lP52RblfWPvK5TLS/vJJJVPEedBWiPBFpgEgCd84J/sfF3w36uCPC4rPlWBeYtzF5BtyDdNJlhWF2xx6bY2AdBhI8oXYU4i81iEEavI6GlRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262902; c=relaxed/simple;
	bh=3+qtmqX+chTgMnupCp4PL29bqLHG+9zZC2Ulx4NMLh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB9HG9IKUW+HC844KBperbkus6xGsL3laBMc9XJqo2p9YZuUkbx1Ay/ZgoauokabnTynKgiu0dmJbtbZj8ug86Z43sdj8F/LAl5cdoWz9THFiZsjFbWRFfhh+tOBzlxtlhoC5IYrKXv1tDV8czjYz+mG8daYIGXxTI9XaHJtAtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m4MueV+6; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 530CE24000F;
	Mon, 29 Jul 2024 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvEzUuiCOfnh2DPlfnjuHlcRxA+Sue8P0D/mhBqQDnk=;
	b=m4MueV+62neQQ+6i2Jf3Co/fNl8epSTFK7rLSK+raxG95/As948+ozAVoaKxlbk/QKEiZA
	XS3eHzvo3CL7EbDjnxX2+XhmxfbNJQsdZlj/RYZd7/4VI/FUjAS1em9C5CntcDv9tIXl9a
	qJmEKi3SIV4gFl8WqT4DaWVJ/JIN8+ITFhK/YomaPRS1+FMKlAXGJZmpnThAmtPmA82xHT
	0lOJE7+IlhMlncYakTgl9sXM26swCUcB9XMPTptQI81ossum/L03QQ32X2gIE+6TGEYg+3
	qOgu3UFY8W+aPl/R0GPkQa95izoP5GBI32HpwYGnQ3t8huEA5NCVITHNTIH1zw==
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
Subject: [PATCH v1 33/36] soc: fsl: qe: Add missing PUSHSCHED command
Date: Mon, 29 Jul 2024 16:21:02 +0200
Message-ID: <20240729142107.104574-34-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240729142107.104574-1-herve.codina@bootlin.com>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The PUSHSCHED command is missing in the QE header file.

This command is supported on MPC8321 and is used to modify the start
address for the task running on a given peripheral. It is needed for the
QMC in order to perform the re-initialization procedure and so, ensure
the correct UCC setup in that case.

Simply add the missing command in the commands list available in the QE
header file.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/soc/fsl/qe/qe.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 629835b6c71d..8f967d15e479 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -469,6 +469,7 @@ enum comm_dir {
 #define QE_QMC_STOP_TX			0x0000000c
 #define QE_QMC_STOP_RX			0x0000000d
 #define QE_SS7_SU_FIL_RESET		0x0000000e
+#define QE_PUSHSCHED			0x0000000f
 /* jonathbr added from here down for 83xx */
 #define QE_RESET_BCS			0x0000000a
 #define QE_MCC_INIT_TX_RX_16		0x00000003
-- 
2.45.0


