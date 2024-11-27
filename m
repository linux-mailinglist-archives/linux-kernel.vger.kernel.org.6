Return-Path: <linux-kernel+bounces-423730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2669DABF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C40281F28
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6640C2010E4;
	Wed, 27 Nov 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="geadsehf"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7720102A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725888; cv=none; b=WTF/UjrHnIjoTYww9LCiO9uAbRifsoNvePrUDyfaBvwNpLNQngnV4A0P0p6QjUqogNSxlmSO4Pb+BARqTYVV7QOFwbDBgiOK28mEFidIpgb2vy/bqENLs3jr7i49swu7/Qig/V18z6UXXrZJhvGPUufIQkuK7i4wGHyjE99ZFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725888; c=relaxed/simple;
	bh=su/n92AzBztSNoNYUl/lOKH5DlhZ0lVKituapnI/Td0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COIigv4K33iKQyr25FkEK2K3/aIoy+y8sp4NZekS4FMD1tAQtqvyczg43rwTXPdn7gcLvx1VHd0PhkGpPH7LdeMq5kd5vzF31O709iMb4N721+8YiEkIv7j6dD8XOSSOAPHAwcZZaXGPn7IvrNYNaqv00fHyU7m07E56FCmIqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=geadsehf; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF09BBFB98;
	Wed, 27 Nov 2024 17:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1732725885; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=13D+wyJPJmO8MKQWxkHfAKBMu7JpxD+W0TTMGRBbJxY=;
	b=geadsehfstQAloXeeSe7Hmk2QwTKV7loelGSbTGQMgPeQy54xqlORJcbvVb+8mmg/vH0p3
	p/u3Yb8LKw8jdBiTO3Z9L+xm0M9B8quKSY7Ky/Eib1ZKaPnGZOAgu6mamd+JQu6xDlpVtC
	NziIKTkKJN5aQZCKF7WBeOpNgovf0C3DkV3wQGIxAcZwrM7TDaVTItOKhkLSchvPIlLvRC
	7sy143kRvaihu8q1mvSzkogjqJA5yNi5QRGAMRrT5XcsYZlT+ASRA5AKqhT5+dmr6vZo+i
	fXdpdTS/a/Pss7zbDM3dOXbCu3R+uHc9CIhGO0MztMn7/rUwNjwXX/xClAXS3A==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>
Cc: Bo Liu <liubo03@inspur.com>,
	Joy Zou <joy.zou@nxp.com>
Subject: [PATCH v2 07/11] regulator: pca9450: Fix enable register for LDO5
Date: Wed, 27 Nov 2024 17:42:23 +0100
Message-ID: <20241127164337.613915-8-frieder@fris.de>
In-Reply-To: <20241127164337.613915-1-frieder@fris.de>
References: <20241127164337.613915-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The LDO5 regulator has two configuration registers, but only
LDO5CTRL_L contains the bits for enabling/disabling the regulator.

Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Changes for v2:
* none
---
 drivers/regulator/pca9450-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 8e525deaff0b7..7f7e176bef452 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -506,7 +506,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
 			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
-			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
 			.owner = THIS_MODULE,
 		},
@@ -715,7 +715,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
 			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
-			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
 			.owner = THIS_MODULE,
 		},
@@ -887,7 +887,7 @@ static const struct pca9450_regulator_desc pca9451a_regulators[] = {
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
 			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
-			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
 			.owner = THIS_MODULE,
 		},
-- 
2.46.1


