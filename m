Return-Path: <linux-kernel+bounces-278998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8894B781
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F7E1F247AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3935E190462;
	Thu,  8 Aug 2024 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YXV9Ky2G"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BC318FDAD;
	Thu,  8 Aug 2024 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101129; cv=none; b=mWTsexFwZ6D2rl/54Iq6QBpaRxWlVCkad3BcnZPAgcEFUHxFEqJf7lzdjW7Tq5twTXIjUWII5vayCYaGC/fPrzzl3ZP/Svc7iYsia1++1WDwVjMytLVZhLrh1Rg084ra8Q4B9feZixHYnA+s/xRtt2G8Igb91vs+ef+FelUD+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101129; c=relaxed/simple;
	bh=/LCxw3wWVE6p9YheOsyvaxcJuRl64jBMckhlFs50MK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qf7l9ziKeVxBUJsWxgatxyQKQ83YYUzWlpP/El0JRyHTcIw3Z4jkV/zA1oG0kcM8tUZ3bJqUbW33SlCVa1QsNGrW9wd6j+WurjbPMAGxNQfAqApWPtjYu2zAcGrnz4pgFZLMkzNGTqaEnu7y1rhWdMzQbMou8dPVfyWnKM2g/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YXV9Ky2G; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A8986C0013;
	Thu,  8 Aug 2024 07:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxhVI5cINOPlLM9ZHr8aejS0o32n/nWcepwPUyLTegw=;
	b=YXV9Ky2Gyww2NMCQI07ysxQ5mmIF9Ws8qRDdaJu32NJ7e66r4CjEgO2zbcBLfjTg78pLXr
	2R7yX9YRYuq9plVEcXz3/NuxbRbvhNQYd97DyfqWkiBYdnaXOglrjVG45oS9zl/Z1we2jO
	W2XF5Y4v2gQMzSoUPvbvOFZnwVEZmn2LOPp2828DrJ7mcx0qzxEFXOeGfJoufaQLeu0LJ/
	9e40sBf9Uxr74genQSnrvGBGfWilkUiXF3Z4kXKyAMHFzQcayU3lZ/RXPbhFc+f83/MnoA
	2GhKOh3iIejJ8fNPUtWF7N+4U3v5sG+bYUJGxawP78CrDrML5hSgqUIzPbEDGQ==
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
Subject: [PATCH v2 36/36] MAINTAINERS: Add QE files related to the Freescale QMC controller
Date: Thu,  8 Aug 2024 09:11:29 +0200
Message-ID: <20240808071132.149251-37-herve.codina@bootlin.com>
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

The Freescale QMC controller driver supports both QE and CPM1.

Add the newly introduced QE files to the existing entry.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d32d38f2247..1331bdeb7386 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8996,6 +8996,7 @@ M:	Herve Codina <herve.codina@bootlin.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
+F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml
 F:	drivers/soc/fsl/qe/qmc.c
 F:	include/soc/fsl/qe/qmc.h
 
-- 
2.45.0


