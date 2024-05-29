Return-Path: <linux-kernel+bounces-193804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C68D325A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3AE1F2205A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34783168C3D;
	Wed, 29 May 2024 08:56:10 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57015A866;
	Wed, 29 May 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972969; cv=none; b=PpF0grpkmtfuqudOjp39324+eZc+9jxO10LClC0VM9dwq9Bs98/qOLw01SAcYzpkyuvcnHWiy2mGMGDBD0/8y+d1AOZZASY+qg+ZC7E7xNvWNk3Oo0hd7V/IPk7A2UKoLkXveRQj/sf6NDfLDUH7e07IfwV155UdC4cztKw5P2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972969; c=relaxed/simple;
	bh=8uJ+Ht6iXJJOtD0OBhPsuto/ZVwxQGIwgIZklWSY/vs=;
	h=From:To:Subject:Date:Message-Id; b=iwVc+hByfbhPvsgQVVE3NA5VxNXgsgGbT93iGRKYR8UlkTwWApKOC5HvaYOe+EKGGxnqWmcEUz3zxYm2JWA6l0u6ypZXCsuZOG058vtqokRnc52kp7dqAOM6abXi2rBtwnhgH9xB7b+XMnhVRvIT9egdRVTXYckt6spqQ/WlUNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D9D151A0C20;
	Wed, 29 May 2024 10:55:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E6ED1A083E;
	Wed, 29 May 2024 10:55:59 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CE558180222F;
	Wed, 29 May 2024 16:55:56 +0800 (+08)
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
Subject: [PATCH v4 0/2] ASoC: fsl_xcvr: Support i.MX95 platform
Date: Wed, 29 May 2024 16:40:00 +0800
Message-Id: <1716972002-2315-1-git-send-email-shengjiu.wang@nxp.com>
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

changes in v4:
- refine the constarint for 'clocks' according to Rob's comments

changes in v3:
- refine the constraint for 'resets', 'clocks', 'interrupts' in document.

changes in v2:
- Merge patch 1&2, 3&4 from v1 together.
- Add more comments in commit message
- Add constaint for clocks used on i.mx95
- Add 'select SND_SOC_FSL_UTILS' for compiling issue.

Shengjiu Wang (2):
  ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX95
  ASoC: fsl_xcvr: Add support for i.MX95 platform

 .../devicetree/bindings/sound/fsl,xcvr.yaml   |  32 ++++-
 sound/soc/fsl/Kconfig                         |   1 +
 sound/soc/fsl/fsl_xcvr.c                      | 128 ++++++++++++------
 sound/soc/fsl/fsl_xcvr.h                      |  91 +++++++++++++
 4 files changed, 208 insertions(+), 44 deletions(-)

-- 
2.34.1


