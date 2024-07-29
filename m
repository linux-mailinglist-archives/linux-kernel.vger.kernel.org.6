Return-Path: <linux-kernel+bounces-265935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFFA93F7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C64282F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41E18FC6E;
	Mon, 29 Jul 2024 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KtuVtq+Q"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448618E77B;
	Mon, 29 Jul 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262904; cv=none; b=iwQozx05Q7N/lVCOBbj7ffH4bdpJMjHWwzjuD7ptesdnxyu7JmR3rLoaqtDQ9ZJWM2Gz1KRFau0jMJ4a8cDq0wXmsWzthJkJiSQJkq9s7xwRGOY+Fkg6386FTB3MVXRi7Dl6K7NnuwB/wfPYBzPzM+Z/OSJ1DLghtHDGmKAKfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262904; c=relaxed/simple;
	bh=/LCxw3wWVE6p9YheOsyvaxcJuRl64jBMckhlFs50MK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc3o4Z32i5fPo4v0zjzWSF57yCBi4QKY6VZzw39mTLgyMFfI5gKYNrjh2WURJGjIQknxSR2NFtT2G3qOuh0e7sYCM71NOdg6u/+3vzviCIgr9pRQlKbfPAUUQAPvd2V6jGrFRGenWYgTlrA/vxytBy5ppVPyBlqACnbnA7THXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KtuVtq+Q; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 62277240009;
	Mon, 29 Jul 2024 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxhVI5cINOPlLM9ZHr8aejS0o32n/nWcepwPUyLTegw=;
	b=KtuVtq+Q0c/lU5+zmBceS/FUeiqQVG+3KxqDZjwIttlPB99AWFJSVqgvZ1bIb3udjmTUnX
	KbcEP0OcvAXMBhizqikvZszwh19iwgRFaNSIFYAXvh6MPq6wzM/CnZq74ENrA0w8FOMwvs
	aSL9yLLd924RgSrqIV1Venh+GXIUjcO3lSerq6I01xU4TNWyjtT5kadBkFnEx3Yu3FPrXp
	T7nCC7yRPJ43rqQl+Qj7Py+7CAvks79Pzl5MLTeFBQl3uk17g8gzBq4oqYZDZhtpQWkqTF
	P3BHdPWVLJ7l1obiShL0NrY63XZVfaQyV6EKZHLIpEavXwhQJzUBCZtzMjVyfg==
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
Subject: [PATCH v1 36/36] MAINTAINERS: Add QE files related to the Freescale QMC controller
Date: Mon, 29 Jul 2024 16:21:05 +0200
Message-ID: <20240729142107.104574-37-herve.codina@bootlin.com>
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


