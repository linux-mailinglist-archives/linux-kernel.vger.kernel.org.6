Return-Path: <linux-kernel+bounces-408231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4279C7C68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB87CB25708
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B720605E;
	Wed, 13 Nov 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0mAeY+x"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC8201276;
	Wed, 13 Nov 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527602; cv=none; b=KVpTz66VqzAg+Gg0Smj3MS+UfHGqIMhKAuitpMzICdgMrz1oevSkfF0C6ns1kg7Qi39+bdZTLYvfEyj7DAvczoJA8EyYS3e0BcXi/XdFqeGvidh13UYY8nxPCEfdraw8hv2MZcF25OuIpD+QftpSU+WHxWxZYNi3jvzDnGA43XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527602; c=relaxed/simple;
	bh=fZyjE9zHWKAp6KH2H57u9MkeLSHGkrs8DtfPsCk0w5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YQ7bJkgyaFF1vyz5+wQ3Z+alPD8DJP8npadhKfQ4yjfw51zi1XoUbEfEHpkUg/RSLB7JLKofkPrJ9QMk9cd5/lXFaLcIKNEHRyXg8hYr8sM3TA9ei1U9Mmz8qArB9d60TRk4cipeXUaDWln2rDD3Oo7/jgJHvg87tolip9Ikg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0mAeY+x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-432d9b8558aso246985e9.0;
        Wed, 13 Nov 2024 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731527597; x=1732132397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJ8QMGzCMpCaQwAwEg2/P5qPEfEiY64c9xCdF+siaoo=;
        b=a0mAeY+x8hSqYu6efWsapBHxI1zn81QpUOITdodZT7RfSizIoI/imK5RoUq2dV1dJs
         kA40i11ddJygkLkDngGYB7T/Dq/3JQUUwExP44ns0uGI7rRjRiGsuhR5QY9wSzfpH/Xw
         I2j7gkXVtJfjVSNXkwGUo8tRObZj6YurSoICbZaWox2eJyMevRFbfwBSEJetegB+JU2k
         xcIR2NCogMtDPJmwVfBSgFRpx//IfJ1duko/Eok4tkZjZvxDmfY2fb/Fy72vM10W9YRF
         VHxPPrIK+vvHpAiaOwkPBKstreNE2HebEDjIfpA/zjb99mstIPW+l/IW4BIwJmeJPJfu
         uT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731527597; x=1732132397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJ8QMGzCMpCaQwAwEg2/P5qPEfEiY64c9xCdF+siaoo=;
        b=gGxUi13f1FBwmnhmk35mWK5khrWZRObovY7T0YuKYmrRUH3hqzTnRDwBc+9oI7pbUF
         Pc+sp1HrY5HhGdF7wGMSnytqkJmRXRxhSOhIG2BH70bXDIHfiF2hYwgDRSES9zS810QD
         naOzRETpMYBYjzG/jTJzMbzI8+nbGt4pm29E6DZEOxy4bF3bo67DZm+U8HmYG22g4ki8
         +dxoWKOn92jcs0SbyOmK9Ef6LR40G351h22JoUm4KLfuX4hGMc6r10QZI9XFIhM8V1TD
         7R/rfjBHk+H1t6FA65g84fkLd99KEqlGc3er20W6LP40bmj/HCE6dFslzcyipd7yFJoz
         5rUA==
X-Forwarded-Encrypted: i=1; AJvYcCUCzQw+YBQDhaTCAmjbcnaTwD1B/ZfN1Kop0hp6xfNa0Hf5BGfjLU44mDZNckqI1JoOO5fTt2tkH3wYgJE=@vger.kernel.org, AJvYcCVSBNg0GI0wo94++cogo6HsI9eXH55fwuwi7ObPlqozoy6BYkl6SnngyebAdIBpLL9Mx3/b0W7Bljb/GlJz@vger.kernel.org, AJvYcCXRVGvh5VRkyCnNnUEftG1yoy1HFcKHblP3bauUfDLrk+/2TXvp7qokE1Rhi7Sn7S5KMmIXXG3q29/N@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWyjUYvHg/8lZRWo5XDIQnVyQaJl8LHbP4AFigPeoxRTnWgoq
	lPNHxKY2euv91H0nZR9X5CbTqTvtKXbo+H3TPwcEwoC3RhieItnx
X-Google-Smtp-Source: AGHT+IEJ+OgyDhiObJDLSUqfKPbscxIsWPEYCybVM9JHR8F0mDVuDPh5t34siJcnZuIWqoUEsXJC1w==
X-Received: by 2002:a5d:64e7:0:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-38214064d0amr634681f8f.22.1731527597046;
        Wed, 13 Nov 2024 11:53:17 -0800 (PST)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5503c58sm34633065e9.22.2024.11.13.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:53:15 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Frank Li <Frank.li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] add sof support on imx95
Date: Wed, 13 Nov 2024 14:52:35 -0500
Message-Id: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add sof support on imx95. This series also includes some changes to
the audio-graph-card2 binding required for the support.

---
Changes in v2:
- Added new binding for 95's CM7 core with SOF. fsl,dsp.yaml is no longer used.
- "hp-det-gpios" and "widgets" properties now reference the definitions from audio-graph.yaml
- Removed extra empty spaces from DTS as suggested by Frank
- Ordered 'edma2', 'sai3', 'wm8962' DT nodes alphabetically. The order of the nodes
placed inside / is kept the same for readability
- Ordered driver header files includes alphabetically as suggested by Frank
- Removed "reg-names" and changed the maximum size of the "reg" property to 1 to align
with the other NXP CPUs sharing the same programming model (i.e: audio processing with SOF).
The region described in the DTS is the SRAM and the mailbox region is now hardcoded in the
driver as an offset to the start of the SRAM region.
- Added new binding with properties required by all NXP CPUs sharing the same programming
model (i.e: audio processing with SOF).
- Various driver adjustments made to accomodate the DT changes + some bug fixing related
to the mboxes not being requested/free'd on resume/suspend.
- Fixed value passed to "dma-channel-mask". A set bit means the channel is masked, not the
other way around.
- Link to v1: https://lore.kernel.org/lkml/20241023162114.3354-1-laurentiumihalcea111@gmail.com/
---

Laurentiu Mihalcea (5):
  ASoC: dt-bindings: add common binding for NXP CPUs
  ASoC: dt-bindings: add binding for imx95's CM7 core
  ASoC: dt-bindings: audio-graph-card2: add widgets and hp-det-gpios
    support
  ASoC: SOF: imx: add driver for imx95
  arm64: dts: imx: add imx95 dts for sof

 .../bindings/sound/audio-graph-card2.yaml     |   4 +
 .../bindings/sound/fsl,imx95-cm7-sof.yaml     |  44 ++
 .../bindings/sound/fsl,sof-cpu.yaml           |  35 ++
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx95-19x19-evk-sof.dts     |  74 ++++
 sound/soc/sof/imx/Kconfig                     |   8 +
 sound/soc/sof/imx/Makefile                    |   2 +
 sound/soc/sof/imx/imx95.c                     | 401 ++++++++++++++++++
 8 files changed, 569 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
 create mode 100644 sound/soc/sof/imx/imx95.c

-- 
2.34.1


