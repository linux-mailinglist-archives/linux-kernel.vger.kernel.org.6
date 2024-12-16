Return-Path: <linux-kernel+bounces-447520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD769F33B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAD4164B11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00282063DC;
	Mon, 16 Dec 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzwbVNYY"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E812E1CD;
	Mon, 16 Dec 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360675; cv=none; b=ksAiDE8CH4G0LWE97x7mUo9oizPQ1AB5d/y8s//IQS/Tvlh7SACouaCBXpxijihdGrps9hy54+nBM/nHc7KmJw+9nfWh2iyY9v7TUy5Bt8malDaMj2B1zK3IS6Jd3tJtgJNXrj40mV1e5bZjr1YuT0sB/NmxYM5EciHqV+iZJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360675; c=relaxed/simple;
	bh=ysrKQp2ttkXFu3hKElJL5pFgXA5DQVf+fUlliXUM1FA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TMJ0jFQRsT4swYeD6DT0LcwxvFoy+ScgSn5ICDcqSILJ4jFkFmqKaWMxFKrFPEP7aq2DRHpH7+k0wsRa75pVLCmXhoBlJw6/ETDJhRtDFPOEJ57sUGGsdzfoxcofwQ2lRlRgMX6vse+HxbPXCsgOo6uiOdiMeOv7JvF8jcErXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzwbVNYY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43622354a3eso29049635e9.1;
        Mon, 16 Dec 2024 06:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734360672; x=1734965472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAsk9ZjNjG2Xsz4F0kxEND8XevJ5WxVcer/d+hZes7Q=;
        b=DzwbVNYYdjzNMLZD8pODEU9vk7nu/kJ00KYDLy7JSCWsRdBe9vMbvHIM1I8x8roz8x
         OiLvkyEnr29d5gECxQ8AImtYPrPCOF7IjIT/7fawBItfM2iXuGePBgQLv6jMc7Lp0JHT
         T5KInQCDvCAR8CLtDrIs2Z93orZu5ZyPSeWu+f4FJElgX/K0l913Z78SRMF0Ux3m49bX
         XRGMaKnH5jcpiPi2yGW3zibR7ehSs/ymwpQzanooB7vd8h5/mI0XS9LFHCyL46lIluV8
         iCoYYUOvT+FwxfZCtVAwcNjq9i98xpcn+BMJFpUcMAeyou/asEzqlUf+0x1wxKaybpbx
         fOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360672; x=1734965472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAsk9ZjNjG2Xsz4F0kxEND8XevJ5WxVcer/d+hZes7Q=;
        b=Bqnnm2yM/6E6BGIpgepY3vkIFPXjcRzdyAwlrHr6aYLiiqqGpjUQXRRCFlu62XyocA
         5Z2kUkTQQGPYuAA2NX/E3+p0x1DbJEZwbeP+xS4kB3pqbczmqmK8lNP/xLYXqAYM5c8N
         6MLsqL63px+KdN83XeqeauPePufoT38oYo+7JbHbCoXtXXx8n2gifZcbPIz6be/mSYW+
         QUFlP2pOhKWwozwDrwVy6GzZUghZCWivp61rKvja8pDBAZjV+DYpePMVkqXxOpCohd1X
         L2X25mmFaIIylaR9WQ8SEPlFpbF8qM2DVqfHlGwCmlixieFooRFl+738Svnl8Ixk1L53
         hE/w==
X-Forwarded-Encrypted: i=1; AJvYcCUP+M3X5E6GVhCMgliOEzzaQ4diCFSprwVnGadvwqko7U8rolBSnRpP03iKFOxvFxhhegLvfBFXvbmUTCM=@vger.kernel.org, AJvYcCWDtBWqjIWPq+CBmegzW2YQmeROc+ucwbnnQs9K4pFsDgkc1DqBVGc5DppOxPt8YuKNycviOnuc4Rpw@vger.kernel.org, AJvYcCXnuKYoUdUdcEPrwHFHzy2e2Tl87c8E4x36E3yMaBMmeMu/wfO7V4iDGfTeC2rn2/uYdAkjGPqJVvOfxJzu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2S/5do8LUEmZtvCwvkNexKjxnExyWWKRHCJ2xntjtEU/8tDu
	KPFXW/WdkN3NM3ftScgmAtfciKArGggw6/IONWeIp/OYXUxsfZ1R
X-Gm-Gg: ASbGnctIVR8wh/aSWD2UUNEy+5BgBJD0HJlEp5mAEYp816LVPalpfIVFCcHKFJXq1vO
	qtzlx4uyVYBXUdrvwbkrT5e1TL6CQYhHrr1Zmc3Kuq0hVopcyaVzC9wsjulnc5wpL2gjRcCzrdw
	LF3afyq6gYAmKLIvi3GjVbDK5gs0kzdtTL+A3pJvtEonoDq2LHmXf9dSw7Zks23OcgxIpRVwhfe
	xZTAX8mmCM0nUtckPDABYTKVMusNnpwxoThn4lRXIZqGnJZ1sWDO9pQ2L+NsmNesgFhYnleaQgX
	wKgmIlY6esefwc39
X-Google-Smtp-Source: AGHT+IEEdMUhmjBce9trMWEaZmzDbJkRmOJV4eeE4OPNHba9b9GfzehogBrTvU3TQeHPPyjiEdm+kg==
X-Received: by 2002:a05:600c:4ed4:b0:434:a734:d268 with SMTP id 5b1f17b1804b1-4362aa589f0mr119266575e9.14.1734360671467;
        Mon, 16 Dec 2024 06:51:11 -0800 (PST)
Received: from playground.localdomain ([92.120.5.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ed6csm141616455e9.24.2024.12.16.06.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:51:10 -0800 (PST)
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
Subject: [PATCH v3 0/5] add sof support on imx95
Date: Mon, 16 Dec 2024 09:50:34 -0500
Message-Id: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
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
Changes in v3:
- Ordered DT nodes alphabetically
- Removed 'cpu' and 'cpu_ep' labels from binding example
- Some small changes to the binding commit messages/titles.
- Link to v2: https://lore.kernel.org/lkml/20241113195240.3699-1-laurentiumihalcea111@gmail.com/

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
  ASoC: dt-bindings: add common binding for NXP audio processors
  ASoC: dt-bindings: support imx95's CM7 core
  ASoC: dt-bindings: audio-graph-card2: add widgets and hp-det-gpios
    support
  ASoC: SOF: imx: add driver for imx95
  arm64: dts: imx: add imx95 dts for sof

 .../bindings/sound/audio-graph-card2.yaml     |   4 +
 .../bindings/sound/fsl,imx95-cm7-sof.yaml     |  44 ++
 .../bindings/sound/fsl,sof-cpu.yaml           |  35 ++
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx95-19x19-evk-sof.dts     |  75 ++++
 sound/soc/sof/imx/Kconfig                     |   8 +
 sound/soc/sof/imx/Makefile                    |   2 +
 sound/soc/sof/imx/imx95.c                     | 401 ++++++++++++++++++
 8 files changed, 570 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
 create mode 100644 sound/soc/sof/imx/imx95.c

-- 
2.34.1


