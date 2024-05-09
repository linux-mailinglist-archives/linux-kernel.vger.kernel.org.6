Return-Path: <linux-kernel+bounces-174084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B58C0A0D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4921F22F7B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA54147C6F;
	Thu,  9 May 2024 03:18:41 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4601DDEB;
	Thu,  9 May 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224721; cv=none; b=T02Q8ckx1u/y2eMiCBL6bgSxy44Che/xql82W8+gzlUkNWrjDxf8THoqpQ2jEKIuyAjb1ua7qFkNWrCRA3Oem8y3BW0sbWmF67DwoxQszzU6kd9ISvOSVmcclQm0jV1CLNS8Pf96pvO97DO4VTIclvtSZPwSALcxjZPmi2f17U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224721; c=relaxed/simple;
	bh=FEu9+pGrH6Ue95etWUKSQKyGUULlshNpk9Nh/JCzfmQ=;
	h=From:To:Subject:Date:Message-Id; b=MX/1qQNnAKZjfEpLyyrXDF0Fz7fh7eGVkF/cnD9puu5RkEIU3aafJVkgjbaEg0lPmHqULRaduwwYXMuXDp2Kgznp15Z4reLJJZ3/J0Ibvov9/IO7CRyIMEW+aBxIR9/wYiYVdbJRR9ww9J7+JBR0KyINyVm1TX3UDTv/9d44vAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 505D9200AAA;
	Thu,  9 May 2024 05:18:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 03CDD2007D5;
	Thu,  9 May 2024 05:18:38 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CEF81180222F;
	Thu,  9 May 2024 11:18:35 +0800 (+08)
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
Subject: [PATCH 0/4] ASoC: fsl_xcvr: Support i.MX95 platform
Date: Thu,  9 May 2024 10:57:36 +0800
Message-Id: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
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

Shengjiu Wang (4):
  ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX95
  ASoC: dt-bindings: fsl,xcvr: Add two PLL clock sources
  ASoC: fsl_xcvr: Support reparent pll clocks for phy_clk
  ASoC: fsl_xcvr: Add support for i.MX95 platform

 .../devicetree/bindings/sound/fsl,xcvr.yaml   |   7 +
 sound/soc/fsl/fsl_xcvr.c                      | 128 ++++++++++++------
 sound/soc/fsl/fsl_xcvr.h                      |  91 +++++++++++++
 3 files changed, 183 insertions(+), 43 deletions(-)

-- 
2.34.1


