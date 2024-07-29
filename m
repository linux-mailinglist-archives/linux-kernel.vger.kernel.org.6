Return-Path: <linux-kernel+bounces-265913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 801C093F79F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19220B2217E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6671B16EB7A;
	Mon, 29 Jul 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="duk3dFdA"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88615990E;
	Mon, 29 Jul 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262889; cv=none; b=NbEnrVFGdE4VBd0xV4zFKykUJObhkB+KBoA7KPj8pA4O20wFg5bnvVbB+PDbv9HqJjetxIjB7qc2gcvP98BpdJ3SNQlERdJt2Cx5st8AoKEXhebUAWgfxH9asoAChwZJUE9+ClHqDwHi1KNdFqOAMCeXG1mwll78F1Q+f1oYYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262889; c=relaxed/simple;
	bh=F3VQ6Yle7susksmFSWNHj03FG8rdRE/TYIjNBkgHHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqTjp310rpUJ69r1YmKrLP49DH928RyE/9Pr65tm8biXeEfaIDuJ9ANq/Wol18uAsSfc3Xh4Y57uYXyb3mLDGaqunMdgAvcR2eN6q7JJeP1PlL/AE4Gtti9RxXiiETwrzCLvTEl+B0VCgMCgWK6n5eo7CP5t0kxwwHwhHCR6sk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=duk3dFdA; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6579224000A;
	Mon, 29 Jul 2024 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaXjEZNpUJnLB3rQBWEOUhhIwVLHy+ulcMNJJs5r5ug=;
	b=duk3dFdAoHtb+xzohumqm4Wi0pQgaItSUni7pV2kqg6o93Y4xJJ6xNdLRNclU4Oid4pLPh
	nT/o9v8wKGK8CkfaHkxY82/nYDvQNaprtuLkmVGhMP35XQrNPcnUNzkqZvQ2x0C45GMcim
	WYFpwl/c5EmI/OuBBgxNtlkyfM/tR5xDXjaCXRNuBeDzTzbna7dnY4wk75tjeTWFY2v2Vd
	ofigj+cFD0uQD8yrHShwrRqbJeKQ8kiONbc0+dd0mWo7MsMY/sAAWns4rEH4poXJ5o+xCk
	ZcQyVeP8sPgerFZnA5og2nKyjWB57uQTXrHPIMfC5wJT96dHwiKU9cKxfWGnow==
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
Subject: [PATCH v1 15/36] MAINTAINERS: Add QE files related to the Freescale TSA controller
Date: Mon, 29 Jul 2024 16:20:44 +0200
Message-ID: <20240729142107.104574-16-herve.codina@bootlin.com>
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


