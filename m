Return-Path: <linux-kernel+bounces-178292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF118C4B78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61391F22974
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346DC2E3;
	Tue, 14 May 2024 03:31:41 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFB17C2;
	Tue, 14 May 2024 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715657500; cv=none; b=Xk0Z45jE/xnPqPXSVp4x9L+RvmicsuM6Y+9GPWn0AB3xmXc3JcmPxA880CJaG3ayYdIrczwQUVYCgj9Vum/vcL13VutE56Q2CC1o7dXOV9CfLctBqbChkgO9tOiPNyr1+EEqZdKwt+nMtEQ9thqa71uMzEcdyPS8NmSNIfJg6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715657500; c=relaxed/simple;
	bh=C5xYCfcQWl/XWOBVZGHYyJOwt9SRH8lTLVBSQ+N8FN8=;
	h=From:To:Subject:Date:Message-Id; b=HzOyPbMVtif1DD3Ffbl/KunyU8FVDOoNH12F4MRdyK1g2fr2I/Q5SPO4kz/xksBH9fmSXxzvy7SAFgeQNoZPJiJlwycoQGvHwUgXFuXUUaVar/K4PVPqiAmK3+daATLgp04tLU2R3jDsJHvPepi6mlhdkPv/MayflSW6IJhAf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 262E12017DC;
	Tue, 14 May 2024 05:31:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D01162017D7;
	Tue, 14 May 2024 05:31:30 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AABC3180226C;
	Tue, 14 May 2024 11:31:28 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] ASoC: fsl_xcvr: Support i.MX95 platform
Date: Tue, 14 May 2024 11:12:07 +0800
Message-Id: <1715656329-8061-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On i.MX95 wakeup domain, there is one instance of Audio XCVR
supporting SPDIF mode with a connection to the Audio XCVR physical
interface.

changes in v2:
- Merge patch 1&2, 3&4 from v1 together.
- Add more comments in commit message
- Add constaint for clocks used on i.mx95
- Add 'select SND_SOC_FSL_UTILS' for compiling issue.

Shengjiu Wang (2):
  ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX95
  ASoC: fsl_xcvr: Add support for i.MX95 platform

 .../devicetree/bindings/sound/fsl,xcvr.yaml   |  55 ++++++--
 sound/soc/fsl/Kconfig                         |   1 +
 sound/soc/fsl/fsl_xcvr.c                      | 128 ++++++++++++------
 sound/soc/fsl/fsl_xcvr.h                      |  91 +++++++++++++
 4 files changed, 222 insertions(+), 53 deletions(-)

-- 
2.34.1


