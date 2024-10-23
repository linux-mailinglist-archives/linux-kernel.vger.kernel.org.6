Return-Path: <linux-kernel+bounces-377977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304469AC973
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D91E2811D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E91AB52E;
	Wed, 23 Oct 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UgBdd0p0"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DC49652;
	Wed, 23 Oct 2024 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684388; cv=none; b=XObxaQsB8GSJ3U1wqJAVSk+nlnqFlSYBQR12ju4ITIHAB04+YdQyEqC2OnZvEyRYjEVs4AglJ3xaplGu99VgXM71jNr+WJFzkRn8geRpKQTuC6s8gsfLLn8SmP29jsZatd0rP8Z4EobxXex8v85W57WAad3QVrHZN8aXaBHAcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684388; c=relaxed/simple;
	bh=Q5I4r72oA/6A0mpxkrBboGMIhbKMjAbnlCQclz2hNqM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hwJh0P86SYs62x2KN+4iKe/gK4EXJavYuGnHv19Ij5yDIaJ3m18V2Ypwv6aCMv5mX5xQY9Ie1queUVSkYV2eDszQW5XLlc5FyrYLYjdvlFsbMkMYeqsYnORzeCtTsF1yb5rSvgmwc63k5AGxZNCloaAueeOh0V96S03VrIbKTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UgBdd0p0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 93653A47;
	Wed, 23 Oct 2024 13:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729684276;
	bh=Q5I4r72oA/6A0mpxkrBboGMIhbKMjAbnlCQclz2hNqM=;
	h=From:Subject:Date:To:Cc:From;
	b=UgBdd0p0wrxwrHjwmBr8V54eRNOweONCoWruGBpa+lFM//MV3bNlAtKA0/X80Sjuk
	 LzJdODRQfQ1nxCREphnIuZSCqHJWUEgGMkcs2wtdoue8+87GC+na3Pevy2mixlRMQd
	 X+3XKPfccTmGzM1YT8Xa6zTbaynAbpGawO7m/06c=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 0/3] drm: xlnx: zynqmp: Add DP audio support
Date: Wed, 23 Oct 2024 14:52:40 +0300
Message-Id: <20241023-xilinx-dp-audio-v4-0-5128881457be@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIjjGGcC/3XNTQ7CIBCG4asY1mL4E8SV9zAuKAN2Ei0NaFPT9
 O6iG020y/dL5pmJlJAxFLJfTSSHAQumroZar4hvXXcOFKE2EUwoJrmgI16wGyn01N0BE1V654C
 LaKNWpF71OUQc3+LxVLvFckv58X4w8Ne6bA2cMqqt9sZG55vGHhCCK6lrksuw8elKXuQgvhn7y
 4jKWAEapDPembDAyA9jOftlZGXMdquZsTIqYH+YeZ6fShmsZkMBAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3283;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Q5I4r72oA/6A0mpxkrBboGMIhbKMjAbnlCQclz2hNqM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnGOOYdB4a29tVAERuM4J3tvaK345HA1KyQtUjj
 TTsMJvwMHGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZxjjmAAKCRD6PaqMvJYe
 9fPjEACbXxnFCCLs8Mot4EVKD+efiSDJolwjJ9LFaYGBQfisgK3vFY392SIR+xdLwqKNSLbUmZP
 wVfzdCsMJVSSMZenAkFoi2g25R0FzNEsN5M/o9gF23GuJlzazq0w90vvdgMoG4wBzhR3yurw8Dt
 tPsyt9i+j0IEjUQPyv9dA+4DKtpJKXfDonGYCX8MOQUea4YPG6o83cg6qak0IPUwrE06Pc2KKlQ
 l9U2WluNZTjRMfPmJWq2M1tEj7xZC38Fctj1EWOQyr36W5mgz2sfzQcI1ppEfTMbRyb588lAD+g
 nnku4uInc7r+UwDkxC+q9y4j6SBzFLV0xYD01m1BC65QmvW11nlUMWat/H7BF+c5tyl6AnRx72k
 XPvKVQEOhejBFzZChS4i7OHTr320DGGNus9nkJS00ehD3f5omBBpEcbx3BYIm8IjcjbqJBmMYT+
 YKbghB2IY+Qjgwccbaefe9kfYIhV6Mmga8LLg5zDXqEX6xbkqvbCMXwk5Q1JKEbDPkCZWF+ej80
 /3JbNZSfpXgcjWMd0McrdtSnMoOY//W4chNnr8DAWpPpNwu9vEKbb53vsC6oQnm95azwS/6fBM3
 XWYhhqNFPLqD8Lg36EmegS0sBYGfb/n6KtImFVLXt9aszAFFpp1iLzeZJ+uUrIHZ8O1tJItXREI
 eIaWoFozhgJjNDw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add DisplayPort audio support for Xilinx ZynqMP platforms.

The current DT is, for some reason, missing the DMA channels for the
audio. This series adds that to the bindings and the dts file, but to
support older dtb files without the audio DMA, the driver will not fail
if the audio DMA is missing, but will just mark the audio support as
disabled.

To: Lars-Peter Clausen <lars@metafoo.de>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Michal Simek <michal.simek@amd.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Vishal Sagar <vishal.sagar@amd.com>
Cc: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: Péter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Changes in v4:
- Update copyright year
- Use guard(mutex) in the zynqmp_dp_audio.c
- Add Rb and Ab tags
- Link to v3: https://lore.kernel.org/r/20240910-xilinx-dp-audio-v3-0-75560793f4d0@ideasonboard.com

Changes in v3:
- Expand the description in "dt-bindings: display/xlnx/zynqmp-dpsub: Add
  audio DMAs" to be more clear about the DT binding change.
- Rebased on top of current upstream
- Link to v2: https://lore.kernel.org/r/20240319-xilinx-dp-audio-v2-0-92d6d3a7ca7e@ideasonboard.com

Changes in v2:
- Fix a missing double-quote in the DT binding
- Link to v1: https://lore.kernel.org/r/20240312-xilinx-dp-audio-v1-0-696c79facbb9@ideasonboard.com

---
Tomi Valkeinen (3):
      dt-bindings: display/xlnx/zynqmp-dpsub: Add audio DMAs
      arm64: dts: zynqmp: Add DMA for DP audio
      drm: xlnx: zynqmp_dpsub: Add DP audio support

 .../bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml   |  10 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +-
 drivers/gpu/drm/xlnx/Kconfig                       |   9 +
 drivers/gpu/drm/xlnx/Makefile                      |   1 +
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 |  48 ---
 drivers/gpu/drm/xlnx/zynqmp_disp_regs.h            |   7 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c                   |  54 ++-
 drivers/gpu/drm/xlnx/zynqmp_dp.h                   |   7 +
 drivers/gpu/drm/xlnx/zynqmp_dp_audio.c             | 447 +++++++++++++++++++++
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                |  39 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.h                |  15 +-
 11 files changed, 539 insertions(+), 105 deletions(-)
---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20240312-xilinx-dp-audio-468ad12f9f64

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


