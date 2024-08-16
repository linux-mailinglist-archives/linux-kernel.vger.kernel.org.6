Return-Path: <linux-kernel+bounces-289568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9CB9547B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0142A1F21E39
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8CE1B3F0B;
	Fri, 16 Aug 2024 11:12:59 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58A1991AA;
	Fri, 16 Aug 2024 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806778; cv=none; b=ToEb2FPgHg/69ukyeV/rkYwIdy9/vs7G4zlK6FklbyYC4DCY5ZLaRHo4Ix4nqzVg2d7GfxG4P+Hxx4UFDHnQvjg/kMbJpeT8lYTb0HQIJu7Q48lG2bCzoPNiT1BlQK2d0Eft8ILb1cxKt67GklMZiLzYdR3OOq2TV9z8LQuT2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806778; c=relaxed/simple;
	bh=9jypwgkLnbPydOwG4i0GQk6puDwWS/KwqBH4sUsJ7g0=;
	h=From:To:Subject:Date:Message-Id; b=WEyndHkvyZOzlibhXW6Y87d8VYdm/CacZs/tVK3U0vl4/tUDdAO3JK5rBkGguhYQWlUHfK8utUyKxlSZfis6Bu3QXTPF6fEkH2tQSyO5uRSr3L7Rjl02ZBgqbwQZnsrbWAIVDiLvr4IZfPh2ZcowFk2Oym9RuGKsyU2XAGk4URk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EFBF1A0DCE;
	Fri, 16 Aug 2024 13:03:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 319411A1529;
	Fri, 16 Aug 2024 13:03:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4B1DF1800318;
	Fri, 16 Aug 2024 19:03:10 +0800 (+08)
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
Subject: [RFC PATCH v2 0/6] ASoC: fsl: add memory to memory function for ASRC
Date: Fri, 16 Aug 2024 18:42:33 +0800
Message-Id: <1723804959-31921-1-git-send-email-shengjiu.wang@nxp.com>
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

changes in v2:
- Remove the changes in compress API
- drop the SNDRV_COMPRESS_SRC_RATIO_MOD
- drop the SND_AUDIOCODEC_SRC and struct snd_dec_src
- define private metadata key value
  ASRC_OUTPUT_FORMAT/ASRC_OUTPUT_RATE/ASRC_RATIO_MOD

Shengjiu Wang (6):
  ALSA: compress: reserve space in snd_compr_metadata.key for private
    usage
  ASoC: fsl_asrc: define functions for memory to memory usage
  ASoC: fsl_easrc: define functions for memory to memory usage
  ASoC: fsl_asrc_m2m: Add memory to memory function
  ASoC: fsl_asrc: register m2m platform device
  ASoC: fsl_easrc: register m2m platform device

 include/uapi/sound/compress_offload.h |   2 +-
 sound/soc/fsl/Kconfig                 |   1 +
 sound/soc/fsl/Makefile                |   2 +-
 sound/soc/fsl/fsl_asrc.c              | 176 +++++-
 sound/soc/fsl/fsl_asrc.h              |   2 +
 sound/soc/fsl/fsl_asrc_common.h       |  68 +++
 sound/soc/fsl/fsl_asrc_m2m.c          | 791 ++++++++++++++++++++++++++
 sound/soc/fsl/fsl_easrc.c             | 259 ++++++++-
 sound/soc/fsl/fsl_easrc.h             |   4 +
 9 files changed, 1297 insertions(+), 8 deletions(-)
 create mode 100644 sound/soc/fsl/fsl_asrc_m2m.c

-- 
2.34.1


