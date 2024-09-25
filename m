Return-Path: <linux-kernel+bounces-338119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A736F98538E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D261F2508D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8D215665C;
	Wed, 25 Sep 2024 07:17:52 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBF155C98;
	Wed, 25 Sep 2024 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248672; cv=none; b=RTuZzHQu/oWDHqCvlBH9rp+U66viwGDBDyKPKu4PuB8veDBhSOd/rRZJj+UXE3mVp+rR8vX9BNV3WDG/8LcTWj6yEelC3SwOcLD6LUzPGOWl9N33pwgGJYGW7Ejtr4Sgrs2/ovOpNk8DUmnVRpwazQrzvCoWOFT1zvtdM0+B3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248672; c=relaxed/simple;
	bh=JlqzkcI1dW2ynQ75PjrYYS6kdHiITrvjuZiQki7W53g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KBk4oSwcb2UKWhlBbxncePbFAOVCXy4mWaQN4kckxSuLMba9z2Ua+XlYrOvopHU2jMG3r8BRtkKgWXYTQuRaNSS2ScR8F1yBNUnXHAmtzb4ev/ELm99+QMCUxhpMDZfiOv8cYMJMFBuBsa+n3SvosuMCtzrymf/jeAaZqkqx3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FA491A038D;
	Wed, 25 Sep 2024 09:17:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CB8DC1A0056;
	Wed, 25 Sep 2024 09:17:48 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2B8AF183AD44;
	Wed, 25 Sep 2024 15:17:47 +0800 (+08)
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
Subject: [PATCH v4 0/7] ASoC: fsl: add memory to memory function for ASRC
Date: Wed, 25 Sep 2024 14:55:09 +0800
Message-Id: <1727247316-16156-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This function is base on the accelerator implementation
for compress API:
https://patchwork.kernel.org/project/alsa-devel/patch/20240731083843.59911-1-perex@perex.cz/
Add it to this patch set.

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

changes in v4:
- remove the RFC tag, no comments receive in v3
- Add Jaroslav Kysela's patch in this patch set. because it may be
  better for reviewing in a full patch set.
- Fix the list_for_each_entry_reverse to list_for_each_entry_safe_reverse
- Fix some coding style issues in Jaroslav Kysela's patch

changes in v3:
- use Jaroslav's suggestion for header file compress_params.h (PATCH 01)
- remove the ASRC_OUTPUT_FORMAT/ASRC_OUTPUT_RATE definition
- remove ASRC_RATIO_MOD in this version because it uses .set_metadata()
  Will wait Jaroslav's update or other better method in the future.
- Address some comments from Pierre.

changes in v2:
- Remove the changes in compress API
- drop the SNDRV_COMPRESS_SRC_RATIO_MOD
- drop the SND_AUDIOCODEC_SRC and struct snd_dec_src
- define private metadata key value
  ASRC_OUTPUT_FORMAT/ASRC_OUTPUT_RATE/ASRC_RATIO_MOD

Jaroslav Kysela (1):
  ALSA: compress_offload: introduce accel operation mode

Shengjiu Wang (6):
  ALSA: compress: Add output rate and output format support
  ASoC: fsl_asrc: define functions for memory to memory usage
  ASoC: fsl_easrc: define functions for memory to memory usage
  ASoC: fsl_asrc_m2m: Add memory to memory function
  ASoC: fsl_asrc: register m2m platform device
  ASoC: fsl_easrc: register m2m platform device

 .../sound/designs/compress-accel.rst          | 136 ++++
 include/sound/compress_driver.h               |  46 ++
 include/uapi/sound/compress_offload.h         |  63 +-
 include/uapi/sound/compress_params.h          |  23 +-
 sound/core/Kconfig                            |   3 +
 sound/core/compress_offload.c                 | 351 ++++++++-
 sound/soc/fsl/Kconfig                         |   1 +
 sound/soc/fsl/Makefile                        |   2 +-
 sound/soc/fsl/fsl_asrc.c                      | 179 ++++-
 sound/soc/fsl/fsl_asrc.h                      |   2 +
 sound/soc/fsl/fsl_asrc_common.h               |  70 ++
 sound/soc/fsl/fsl_asrc_m2m.c                  | 727 ++++++++++++++++++
 sound/soc/fsl/fsl_easrc.c                     | 261 ++++++-
 sound/soc/fsl/fsl_easrc.h                     |   4 +
 14 files changed, 1851 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/sound/designs/compress-accel.rst
 create mode 100644 sound/soc/fsl/fsl_asrc_m2m.c

-- 
2.34.1


