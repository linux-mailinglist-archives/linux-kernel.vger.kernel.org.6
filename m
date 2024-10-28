Return-Path: <linux-kernel+bounces-384700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ACA9B2D67
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8BA280EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2D1D9334;
	Mon, 28 Oct 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFzqSECV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC961D90AD;
	Mon, 28 Oct 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112669; cv=none; b=eSceA/vbvacg/2yXx7kA8u4hbdYfCcK20sqnTZVP31ZhLwqWizv23XXh3UKM+IqBhvC+CeD1bEqYkTOwMWDz8aMAeWcPwTseJCVmxk18lxBx7cUoo+FL580T0+OyZKFM6DVG4IwlW5NkZrZmtbLT00L+pcZNrjB31AoLdY5cpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112669; c=relaxed/simple;
	bh=7lam01olvUb3QSFzRWm5ouSmAo57fVc3EtizsiBcnsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlVe7Y8+GqY4vABn3mV0FJ/1UdP4YhnJ2jM8+FIq9xSbWC8dJLXRXXaq62mnzbZNvmvaKTd9BeQX7GLAW/FWlXvnKP6JSmqS+bqBLWwjvqfOdId+kz5CFxEygFJxWLuPTIqL6rCZzRR/qPIuafGd1P9VPpjk4ADku/SiEqAmjms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFzqSECV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B76C4CEE8;
	Mon, 28 Oct 2024 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112669;
	bh=7lam01olvUb3QSFzRWm5ouSmAo57fVc3EtizsiBcnsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFzqSECVcqWowTN2vTltnRV/Oyxyg9LNCwpgEtv16bkNeK53zzb/0Z5M19CUwGBKb
	 gvqo++yzNZGLVv0dn0C6hmoRVKChatWBkrG8JWNq2j18whCtaPmsccAz5ID1+Et8w8
	 QGYlQMTd0Gvs4Vqi8FrEgd16R7jUxOC7vNzoOO8IwMsQyq7mUW9/dEkBumf8MQkOJn
	 JJx7w+1lycK+vyNDkLGTcu3pz193sAvNxL5MlSq914A4CxzihOosEHDAsZS5N1glqj
	 guOHV8rDIDHsTizXvwmsPTuKx1kO+OAuPsqupKcz+MBah1LjV0O95fNwPR+Qx7lNsS
	 cKPkFZhhuVP2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.11 05/32] ASoC: fsl_esai: change dev_warn to dev_dbg in irq handler
Date: Mon, 28 Oct 2024 06:49:47 -0400
Message-ID: <20241028105050.3559169-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 54c805c1eb264c839fa3027d0073bb7f323b0722 ]

Irq handler need to be executed as fast as possible, so
the log in irq handler is better to use dev_dbg which needs
to be enabled when debugging.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Link: https://patch.msgid.link/1728622433-2873-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index d0d8a01da9bdd..0cf9484183d43 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -119,10 +119,10 @@ static irqreturn_t esai_isr(int irq, void *devid)
 		dev_dbg(&pdev->dev, "isr: Transmission Initialized\n");
 
 	if (esr & ESAI_ESR_RFF_MASK)
-		dev_warn(&pdev->dev, "isr: Receiving overrun\n");
+		dev_dbg(&pdev->dev, "isr: Receiving overrun\n");
 
 	if (esr & ESAI_ESR_TFE_MASK)
-		dev_warn(&pdev->dev, "isr: Transmission underrun\n");
+		dev_dbg(&pdev->dev, "isr: Transmission underrun\n");
 
 	if (esr & ESAI_ESR_TLS_MASK)
 		dev_dbg(&pdev->dev, "isr: Just transmitted the last slot\n");
-- 
2.43.0


