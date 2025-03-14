Return-Path: <linux-kernel+bounces-561708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE0A61511
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F5A172703
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534951FAC3D;
	Fri, 14 Mar 2025 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz23vvNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05911519B0;
	Fri, 14 Mar 2025 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966549; cv=none; b=gE2oYTVcPIsNdiQ88etXhgQi5vkkJlkFdXb1DLxboeIT/gpDNx1DeA0K+eriUEEJUJJhVGHiG0aLCIg1bAK8X66yUT8ORcsoSP3b8x0wI24X3wNet57hYlkRUc4ZAGHnV8KkUx5ESpwT1VllOLHk0CpHVPYerPP8hGMO9OA4ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966549; c=relaxed/simple;
	bh=QRq38aB1YYgf1DqT1XzB4YAfEYRe0Kw3c+SXSC0Um9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OSvZ+6/UMXosG3SQ8q4utLJeR1Rp63tMerrPspDroX2m/ulmsaFAV1ZTUFKRGeH5PQoYaOjYg/zyC4o1sqA1YqbAKM2O+m4COUNxEpAyMRVj7nRRXsVCQ5PdLOyG5vTxC8YSAkUY+JFsZwOZg30+49cwRvvLPnVbpixecNQjmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz23vvNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C69C4CEE3;
	Fri, 14 Mar 2025 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741966549;
	bh=QRq38aB1YYgf1DqT1XzB4YAfEYRe0Kw3c+SXSC0Um9M=;
	h=From:To:Cc:Subject:Date:From;
	b=rz23vvNe2MXgI7lbIHxxZ4a3gpKLJY5DLSc7EvVQGRbMFcftDO6y6jF945apwdB+M
	 9BDsLpfpTgq3ylIWIgDr4qY68o+7s8/3T/VTEGHkTD70w3jnP1pTlbRE1zKmun04DM
	 ZOFjaYBTagkJKiqg8BBUMQpeJ+TAn5v7wSkvkPqK9cPG1H2dwexyIvtKZOFSeNH8nC
	 bZKl9LgpQjZtWSY/0wQGp7y0/MhF8sURrCtfSC9cKBenRP99WhQ6QYRluwOJaYxB6s
	 wURaYakwQxU66/XdcDTK5yo2yOmDt4gBkYKa70wI0AcPTMTw/jSqlKihB94VYp7kvE
	 PM3QvJDR5MHpA==
From: Arnd Bergmann <arnd@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] reset: imx: fix incorrect module device table
Date: Fri, 14 Mar 2025 16:35:37 +0100
Message-Id: <20250314153541.3555813-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The ID table is for of_device_id, not platform_device_id:

ERROR: modpost: drivers/reset/reset-imx-scu: type mismatch between imx_scu_reset_ids[] and MODULE_DEVICE_TABLE(platform, ...)

Fixes: 6b64fde5c183 ("reset: imx: Add SCU reset driver for i.MX8QXP and i.MX8QM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/reset/reset-imx-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-imx-scu.c b/drivers/reset/reset-imx-scu.c
index d3074eaad4c9..919fc29f944c 100644
--- a/drivers/reset/reset-imx-scu.c
+++ b/drivers/reset/reset-imx-scu.c
@@ -85,7 +85,7 @@ static const struct of_device_id imx_scu_reset_ids[] = {
 	{ .compatible = "fsl,imx-scu-reset", },
 	{}
 };
-MODULE_DEVICE_TABLE(platform, imx_scu_reset_ids);
+MODULE_DEVICE_TABLE(of, imx_scu_reset_ids);
 
 static struct platform_driver imx_scu_reset_driver = {
 	.probe          = imx_scu_reset_probe,
-- 
2.39.5


