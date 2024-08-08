Return-Path: <linux-kernel+bounces-278976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E828594B74F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B71C238C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848518B487;
	Thu,  8 Aug 2024 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g9ATk1Bs"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138F189527;
	Thu,  8 Aug 2024 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101113; cv=none; b=G4e3tfPz6hplIWYzhbzlI12hO85iLBAaHZnTSJGrkCdIABMJN2B2dfCwewBMn0CA0nLnwaYpqBzow91wFw0F9pe6yK0Y/DwMoZPE/RItZy1bx+qG5/+uZ0TEijfYYz3w2THXbAdqOCh0dL52TnotCQyRk0kdE/76NzWeRV0zI04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101113; c=relaxed/simple;
	bh=F3VQ6Yle7susksmFSWNHj03FG8rdRE/TYIjNBkgHHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5LPnCp1x05ttHUuHyp6N7IKQF28+HbWRR1QYI/6n4YPw5PPOBf0omGEH7o2Uio5J3XYvhORawE0VUYvsh8fZ0xsUa06ioyJcNmLUIzzR9li2cGjItJ6LJhb1ibsqFN1cDMWnyNkJ/Ci3vnPXhD8t4hTU8J5lupF00mkELceQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g9ATk1Bs; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7BBCEC0005;
	Thu,  8 Aug 2024 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaXjEZNpUJnLB3rQBWEOUhhIwVLHy+ulcMNJJs5r5ug=;
	b=g9ATk1Bs2ojL25FopiaM3g7t9TI2JwBUFa+NxdUaLGSfjtYYTjRsCGvIBl7RN0rA+ljzVX
	OjyWp7YNEB4d9BP5RY6fXB2l8AsCAPEd9UwH78kLvhlzaoc4ZMLgNd5aN4CPFSJe8Ad4cJ
	wmnjn8WGtEPqC0rERCquPHCoDsL49LrR+/L0uK0LFA/yu72Vog7Zj5aw5JAX+f07cxcbs/
	T1XZxs0QlxefuZcqos86CWmFGSM7XQd472pF89C1m6XZkAVdRdmV914aRNmoobq0tN3RPu
	5u/Q8pNX1SGzVjOpdzvRpGzKpR3GGKZ9LwRASnv2QbEU0Y3S0Qj/aVsetw1Hcw==
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
Subject: [PATCH v2 15/36] MAINTAINERS: Add QE files related to the Freescale TSA controller
Date: Thu,  8 Aug 2024 09:11:08 +0200
Message-ID: <20240808071132.149251-16-herve.codina@bootlin.com>
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

The Freescale TSA controller driver supports both QE and CPM1.

Add the newly introduced QE files to the existing entry.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..1d32d38f2247 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9011,9 +9011,11 @@ M:	Herve Codina <herve.codina@bootlin.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
+F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml
 F:	drivers/soc/fsl/qe/tsa.c
 F:	drivers/soc/fsl/qe/tsa.h
 F:	include/dt-bindings/soc/cpm1-fsl,tsa.h
+F:	include/dt-bindings/soc/qe-fsl,tsa.h
 
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
 L:	netdev@vger.kernel.org
-- 
2.45.0


