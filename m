Return-Path: <linux-kernel+bounces-574592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 539ADA6E73F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170DB1895C49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E21F1523;
	Mon, 24 Mar 2025 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="a5qdpjSi"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C11F0E4B;
	Mon, 24 Mar 2025 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742859644; cv=none; b=FmtYzwpTmGlTAF9XP3ODeaTIMAR+7IcqwHXprYF8ELwkYhZgGiENTX7LDtBjhla05H9am6SJ/GApbvwYW/j6qz3my9ZKKXlsNqKzKRnFQijQmZxjEz1wV6xZ7iSYecq8zmcD7SeCE73JDpSIhC5i2y6uHSmVc4j7JKjUiANr6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742859644; c=relaxed/simple;
	bh=rCmrnBlao2XUfzAQtujQ7ftFEmxwoE6+EH3ux0BP3Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqObv8FDjSRfFlFDKdWgCNZfOz7YAyqw40wXwCYe2ojbCjFrvgcWH52qvw4s8Qj/Gbs3C+UhTRMXEsRU5XfI7k5hIN7wcNMtdJme2jA0LpYPMFM8Rzn0kh1jl7yLDQBBJynTo5+VbvmS/Gy2EZ3vNeyRsOUtH1Nap1M0+97zwig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=a5qdpjSi; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3619C102E64C5;
	Tue, 25 Mar 2025 00:40:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742859638; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ebW5uUbDixz+WtbLPFY5UlkKryXzpM2RUhwCViXppAI=;
	b=a5qdpjSiqcP8TPDm/nqcqKeCTCdZ/Aaw1VFhOf78vzuwvd+GofIRY7yLIoU2jEby8DcMA3
	g52MEK89jy/T2o+oHOKIa2q0wsPPf2rp3EMZhN4VcQELMbPidB0YZlU25oG8Jwr1Skk0Qz
	/iiFkliEWNAg8sBEHJdp8a9+lTheVQhzxxcP0lsf976Phajm4i9jUVGeQX+5CJspFbKEVT
	wMIxBKYCLp9qn5AAq//ihsnuDOjwkGBEmH85FA1GeE7qxoyhYQdAWw8jGSCSA9U3MwgNjv
	KVBiKhzlFmGt6KKdQmZkY8PgaLExbHse+cmiO1oHXYJQtO5nYEnlqYNMG4tYTw==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Goncalves <joao.goncalves@toradex.com>,
	Joao Goncalves <jpaulo.silvagoncalves@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: imx: document i.MX 95 Verdin Evaluation Kit (EVK)
Date: Tue, 25 Mar 2025 00:40:01 +0100
Message-ID: <20250324234013.140440-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Document support for i.MX 95 Verdin Evaluation Kit (EVK), which
used to be the Titan EVK.

Note that the SoM used in this EVK is a derivative SoM from Verdin
line of SoMs, an actual i.MX95 Verdin SoM is under development.

[1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95-evaluation-kit

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Joao Goncalves <joao.goncalves@toradex.com>
Cc: Joao Goncalves <jpaulo.silvagoncalves@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1b90870958a22..30dc200cc1561 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1352,6 +1352,7 @@ properties:
           - enum:
               - fsl,imx95-15x15-evk       # i.MX95 15x15 EVK Board
               - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
+              - toradex,verdin-imx95-19x19-evk  # i.MX95 Verdin Evaluation Kit (EVK)
           - const: fsl,imx95
 
       - description: i.MXRT1050 based Boards
-- 
2.47.2


