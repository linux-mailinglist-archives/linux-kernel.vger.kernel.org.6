Return-Path: <linux-kernel+bounces-275999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F0948D13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035A11F24FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF2B1C0DC0;
	Tue,  6 Aug 2024 10:47:43 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443701BBBF5;
	Tue,  6 Aug 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941262; cv=none; b=Qk6TA44D67bfaXZPTjDvU45fs64xQVYnHZzGIqvyYnNJq/xDtvpCDWXky/Vu6g8hdyPCKiweJImTPznuOrbBU5yV+t+sV10RiOqsQpiA1gx2zp7sNTRTwDQu/7KMNN0/udLi9itqx4pI4YezvTprQNit/s4dkZSljCeneVqe7Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941262; c=relaxed/simple;
	bh=9fdUbeL5VmVbgc4V2YDBBj0iZm0h0ykJsMbO/3e+Wo8=;
	h=From:To:Subject:Date:Message-Id; b=M0AZcwfM9cvac5/kR8WwOuuT6tLPj33QzX3rEdKaoMnsL+AlNVhmSWIm41JLqeVtLt9mf8yF9pmz3PIxYFXFir/yN0rbprUYLM4Kp8oPOC1syp4BjVug1CJO4Xtl8+i5y+XKJ8L0I4+n8jLMNHh5sRbsHZEKb4NczpZm9aGDrKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C7017200691;
	Tue,  6 Aug 2024 12:47:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D918200E65;
	Tue,  6 Aug 2024 12:47:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D12E4183487B;
	Tue,  6 Aug 2024 18:47:31 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 0/6] ASoC: fsl: add memory to memory function for ASRC
Date: Tue,  6 Aug 2024 18:26:37 +0800
Message-Id: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This function is base on the accelerator implementation
for compress API:
https://patchwork.kernel.org/project/alsa-devel/patch/20240731083843.59911-1-perex@perex.cz/

Audio signal processing also has the requirement for memory to
memory similar as Video.

This asrc memory to memory (memory ->asrc->memory) case is a non
real time use case.

User fills the input buffer to the asrc module, after conversion, then asrc
sends back the output buffer to user. So it is not a traditional ALSA playback
and capture case.

Because we had implemented the "memory -> asrc ->i2s device-> codec"
use case in ALSA.  Now the "memory->asrc->memory" needs
to reuse the code in asrc driver, so the patch 1 and patch 2 is for refining
the code to make it can be shared by the "memory->asrc->memory"
driver.

Other change is to add memory to memory support for two kinds of i.MX ASRC
modules.

Shengjiu Wang (6):
  ALSA: compress: add Sample Rate Converter codec support
  ASoC: fsl_asrc: define functions for memory to memory usage
  ASoC: fsl_easrc: define functions for memory to memory usage
  ASoC: fsl_asrc_m2m: Add memory to memory function
  ASoC: fsl_asrc: register m2m platform device
  ASoC: fsl_easrc: register m2m platform device

 include/uapi/sound/compress_offload.h |   2 +
 include/uapi/sound/compress_params.h  |   9 +-
 sound/soc/fsl/Kconfig                 |   1 +
 sound/soc/fsl/Makefile                |   2 +-
 sound/soc/fsl/fsl_asrc.c              | 176 +++++-
 sound/soc/fsl/fsl_asrc.h              |   2 +
 sound/soc/fsl/fsl_asrc_common.h       |  68 +++
 sound/soc/fsl/fsl_asrc_m2m.c          | 769 ++++++++++++++++++++++++++
 sound/soc/fsl/fsl_easrc.c             | 259 ++++++++-
 sound/soc/fsl/fsl_easrc.h             |   4 +
 10 files changed, 1284 insertions(+), 8 deletions(-)
 create mode 100644 sound/soc/fsl/fsl_asrc_m2m.c

-- 
2.34.1


