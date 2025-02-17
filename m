Return-Path: <linux-kernel+bounces-518466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E95A38F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEEB1736C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21891B85DF;
	Mon, 17 Feb 2025 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIuuyuDy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AB1AF0D6;
	Mon, 17 Feb 2025 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834300; cv=none; b=G3NjNlnsbisBbDt+MdoV1ViHpnfbbue0AYoVYmhYoDI9QbZLmqyXoCJPQRMkfV4q2nrgV/XikGBT9FCL/cpYuuJQXwmLF31Wc48HUbAwRzIhIT99a2jdytPIWSulewMEx9T4I/fgxny2S+tACISDOLIIjPN/GBCToP6u7hIWaOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834300; c=relaxed/simple;
	bh=A//T4FziV5YTqBmwItukIEcIB39iJrlwpQY2sdqd/PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzzMHQLetkQQf3jCaaJpttPEiLoirnCrQfrvbv/Zr3MlvxOV1o7deNIbGlbhfauchfbFiUcpTQusPyn0cIDJS5YX+rvF0CXRaO//PmOgfpIYXZ3g5532btzcdt3Ulfwids9fayb+EVD+APWGOuAT8UvqhancZ3tE1wn+T8jBqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIuuyuDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A9CC4CEEB;
	Mon, 17 Feb 2025 23:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739834298;
	bh=A//T4FziV5YTqBmwItukIEcIB39iJrlwpQY2sdqd/PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIuuyuDyhMnAOqZAwRkfWyYj6Ucp9jPEEq9dHfVGWfkLBTbs3vEtFh44QAvj54OzQ
	 fTMBakxYx15jKOUTFzroydwn9otXVLSV0sxxsYeDTSd7E+aGcK1dfN0ffWvKikaJfA
	 yM+4G2Y4iz1zMNjoPnlt/vMmF27vZX1fzMp4Xiq+XIpCmtZRgRW7YJYu25JEAFTrNm
	 wHeFvWJ1XKWzM0kfDZ56rWt1LD+gLAmNX3PeMpRZOyIV0jxTsDe1UaQfKvxxFdCZms
	 pdFSSVDybpsVRpnq8EuXEZlGV4nZR7g7l4Y1oZEAIgT9enCb4NOk1LJRJY5+my77xV
	 4TMMhnY/UTVMw==
From: Mario Limonciello <superm1@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org (open list:AMD NODE DRIVER),
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS)
Subject: [PATCH 7/7] ASoC: SOF: amd: Drop host bridge ID from struct
Date: Mon, 17 Feb 2025 17:17:47 -0600
Message-ID: <20250217231747.1656228-8-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217231747.1656228-1-superm1@kernel.org>
References: <20250217231747.1656228-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

host_bridge_id is no longer used by any of the SoCs as they
all use AMD_NODE to communicate with SMN routers.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/sof/amd/acp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 4bfb05d93b25a..d084db34eed8d 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -197,7 +197,6 @@ struct acp_dsp_stream {
 
 struct sof_amd_acp_desc {
 	const char *name;
-	unsigned int host_bridge_id;
 	u32 pgfsm_base;
 	u32 ext_intr_enb;
 	u32 ext_intr_cntl;
-- 
2.43.0


