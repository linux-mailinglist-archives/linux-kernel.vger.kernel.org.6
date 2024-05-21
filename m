Return-Path: <linux-kernel+bounces-184809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EFB8CAC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B250282582
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66CB6CDD0;
	Tue, 21 May 2024 10:34:14 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A871B32;
	Tue, 21 May 2024 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287654; cv=none; b=gKAgJaCNO8oYymZiGPGLoIx4dGtwaxgoVFkvVnvQmrQU0JiNr8fFjvM3ZTWlA70HWscFSeqiumjlXRd31eACqVmA1DyrrQowV72s0vFN+8IkFg/Y0VemsWpb6pvCaIUqpEb06Zb8122g4dEcHKAckBsJyJ6KddWfqfNWIAnd67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287654; c=relaxed/simple;
	bh=1Jv1yuE9xzAE/z8EGE/kaVxPvVhA9WNP8EjeoYGlOPM=;
	h=From:To:Subject:Date:Message-Id; b=r1dY+4MsS7QbS9+lfPwmIBOJeygnUxRIDBLlaBRzMJMLqKy/R6rqeE0QB0T8JMiv6SaIi3wsYXzm0bJafpmHVQpR+djdf5DbssLuWCAhGP8sAnVM+x/GSUzgoArSSsKJ+4XgLbw7CtgYYMO7LPFbdhLx1NbDl255tt8WfxG1l2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D026C200A2D;
	Tue, 21 May 2024 12:34:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 621302008DD;
	Tue, 21 May 2024 12:34:04 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 98E11180226C;
	Tue, 21 May 2024 18:34:01 +0800 (+08)
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
Subject: [PATCH v3 0/2] ASoC: fsl_xcvr: Support i.MX95 platform
Date: Tue, 21 May 2024 18:13:34 +0800
Message-Id: <1716286416-17621-1-git-send-email-shengjiu.wang@nxp.com>
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

 .../devicetree/bindings/sound/fsl,xcvr.yaml   |  37 ++++-
 sound/soc/fsl/Kconfig                         |   1 +
 sound/soc/fsl/fsl_xcvr.c                      | 128 ++++++++++++------
 sound/soc/fsl/fsl_xcvr.h                      |  91 +++++++++++++
 4 files changed, 213 insertions(+), 44 deletions(-)

-- 
2.34.1


