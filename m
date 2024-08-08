Return-Path: <linux-kernel+bounces-278971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24294B743
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401C51C23514
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86AA189F30;
	Thu,  8 Aug 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n9ythkk4"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F5188CD7;
	Thu,  8 Aug 2024 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101112; cv=none; b=lf5TrL9rpdAFYVwaFn1fNRlhcQZ0c+ALedm1RDE4QKIvYJpLXP58XtjUb9o5LBWQomQBiJPOtO7mGxqkAgG7ZjqIP9G/tJ28zEAFxmtUpioC3VjnGy9v3M5TeJejD3gXKXSBI5PvmHPZCsjOGMBFid7kQI0/vXg6LX6N8tX7jqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101112; c=relaxed/simple;
	bh=garDM2VCcIh7nFxERMMTQlNcCfhkxCqcAVpMIfokR+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yii0urwOOGERSG5IJE3qic0rTp5HH3hrC5xJegrVQeIDUUd0kepaR4j2vFE/Le5vYzviOYqKtQn5bcF1Am+uifDC8G0ClEP1gU/u6zr5ArkuibphPZccnhDgvdtWWaMne7LBx6JIJ5EuKGUdhnKweK0k2MgPVMXa+BG5W79V2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n9ythkk4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 722C1C0010;
	Thu,  8 Aug 2024 07:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtWIrdliZOmk8NGcbWjUR4YnnqWzac5bc0tUFTTDrBg=;
	b=n9ythkk4tPk0SkNnLb94KE9A50bNV96RbYFZxM828pb0A6tEsWZ9x0Om6HU34reSr9TcR8
	vw6yQyR9Vx6cEP02+7+QHzZd8gVTqUjqQSefDNSpsA0XGzVRlVlTA0thE4vRbDeqIH/kdv
	Vupe6M85lctOD9vuZjcYUHIMtL83G9JRiA1uAEzeB4aVRJDJTUybsPM2FAv2IeLvfoqNn/
	WnfdDAwIaphvMCbYka99zMaUuwNPG4MjTDi+g0zG+ao5pWFlXL+nI3TOfSGdTOfVGcOeRJ
	lHPpvSzBrQ5pb5vAcOKilSv8YgB4Y8vzzMzeBjdQIE5mFmVFDkQHJrpBQcN3DQ==
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
Subject: [PATCH v2 06/36] soc: fsl: cpm1: tsa: Add missing spinlock comment
Date: Thu,  8 Aug 2024 09:10:59 +0200
Message-ID: <20240808071132.149251-7-herve.codina@bootlin.com>
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

checkpatch.pl raises the following issue
  CHECK: spinlock_t definition without comment

Add the missing comment.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 7b1032fb1572..a9d35b44489d 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -128,7 +128,7 @@ struct tsa {
 	void __iomem *si_regs;
 	void __iomem *si_ram;
 	resource_size_t si_ram_sz;
-	spinlock_t	lock;
+	spinlock_t	lock; /* Lock for read/modify/write sequence */
 	int tdms; /* TSA_TDMx ORed */
 	struct tsa_tdm tdm[2]; /* TDMa and TDMb */
 	struct tsa_serial {
-- 
2.45.0


