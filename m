Return-Path: <linux-kernel+bounces-181974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 174598C847D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D8D1F24161
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9F3612D;
	Fri, 17 May 2024 10:05:42 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEAC2D051;
	Fri, 17 May 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940342; cv=none; b=kcdWGQPcc+inP+fhJaYDQtvd5H4zonj5wKjOCvRAKm6xM6jFs4AWxlweQbgRVURAYTJQC/ozhohVlOIDbK5hZq7l2k02oo+ijqTu9OPhaQr4J976OubRY70xAwT18aXNCCS0KbRPcEA45mQbEAsxJsfDZYYK4LD3KHN3yfUsOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940342; c=relaxed/simple;
	bh=pEs/JKZaxSvaPBCNOuyYTemDq6eGWIXQge9sqbJNRo0=;
	h=From:To:Subject:Date:Message-Id; b=gGpy/3OacgDonT6zJUdRC7rDZlzNdIY7esskh6oAKX/hDMCOeaa+GyZpPu7CWerG/PBtEG8sevzEaqym325T2Hx55ihT/a2fygMqOGnGoaqjLVMQZwrqKlbuMsdlrSO1T7+yZT8DSXx1D8wQzLKesx36NYEayHrhqNCPR2wWGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 67BEE1A0EAB;
	Fri, 17 May 2024 12:05:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C72F1A04A4;
	Fri, 17 May 2024 12:05:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 71255181D0FF;
	Fri, 17 May 2024 18:05:31 +0800 (+08)
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
Subject: [PATCH 0/2] ASoC: fsl_mqs: Add i.MX95 platform support
Date: Fri, 17 May 2024 17:45:44 +0800
Message-Id: <1715939146-13031-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In order to support the MQS module on i.MX95, a new property
"fsl,mqs-ctrl" needs to be added, as there are two MQS instances
on the i.MX95 platform, the definition of bit positions in the
control register is different. This new property is to distinguish
these two instances.

Without this property, the difference of platforms except the
i.MX95 was handled by the driver itself. But this new property can
also be used for previous platforms.

The MQS only has one control register, the register may be
in General Purpose Register memory space, or MQS its own
memory space, or controlled by System Manager.
The bit position in the register may be different for each
platform, there are four parts (bits for module enablement,
bits for reset, bits for oversampling ratio, bits for divider ratio).
This new property includes all these things.

Shengjiu Wang (2):
  ASoC: dt-bindings: fsl,mqs: Add i.MX95 platform support
  ASoC: fsl_mqs: Add i.MX95 platform support

 .../devicetree/bindings/sound/fsl,mqs.yaml    |  17 +++
 sound/soc/fsl/fsl_mqs.c                       | 106 ++++++++++++++----
 2 files changed, 103 insertions(+), 20 deletions(-)

-- 
2.34.1


