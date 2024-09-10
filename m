Return-Path: <linux-kernel+bounces-322971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B3897361A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44C01F23CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418D818EFEE;
	Tue, 10 Sep 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wAZgJ9Dw"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE074171671;
	Tue, 10 Sep 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967185; cv=none; b=DXJq/4WixY2jEeUiqbGFAzoZFC8/gfwWotEPxeC/MTJ9c+c8tUPbx9JPg/vWGt3N0EeZVD3pI4fcJVGRZ371oXabxG18f8N1ipgEI1E0K7fSZ67gYpPFeTvNb24HMInm9nzF9TyZNMk1aR0w2EYMRyzAJn2rNFj+C4LHe86qfSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967185; c=relaxed/simple;
	bh=NITUG13tg6OeRjUeeRV7q4yVc5SHqZar4SuO8+29cuA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CsEUDMpjXbEHJdTREdNIcKMA8+AocpRVd8zZCgGuqOnBQXa+xROAnG+/RBdeaRocXgQLikkI0H6Hr4AZUesc7virHSLpdUQ/XHk7mVc34uzavNPnmi0q5OjmULnY8q/1oRoI+RKb5RIZ/0sESsHCFwKyNmEO52R65wSGmbD/Dcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wAZgJ9Dw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-156-87-48.elisa-laajakaista.fi [91.156.87.48])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2BBABC8A;
	Tue, 10 Sep 2024 13:18:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725967104;
	bh=NITUG13tg6OeRjUeeRV7q4yVc5SHqZar4SuO8+29cuA=;
	h=From:Subject:Date:To:Cc:From;
	b=wAZgJ9Dwzdy0Cy+BVVn5PYr7PFtBpzLdqbkdrdKJQzvzuIJMUSUkBJLjYAwUbDFYC
	 vVUGAbxYZFVmcpGoKvthtIWHC/WIbsD2w3kPyOgL/xeYGD5MJgQZLrDfZWX4omnYEl
	 d8UckE94fKz9ZYFpWYejNYBEGTlmdou1Afcw/3co=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v3 0/3] drm: xlnx: zynqmp: Add DP audio support
Date: Tue, 10 Sep 2024 14:19:18 +0300
Message-Id: <20240910-xilinx-dp-audio-v3-0-75560793f4d0@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADcr4GYC/3XNQQ7CIBCF4as0rMUU2lBx5T2MiykDdhKFBpTUN
 L27tCsTdfm/ZL6ZWbKRbGLHambRZkoUfIlmVzEzgL9aTliayVq2dSMkn+hGfuI4cngiBd6qA6C
 QTjvVsnI1Ruto2sTzpfRA6RHia3uQxbr+t7LgNVdamU47MH2vT4QWUvB9gIh7E+5sJbP8ZPQ3I
 wujJSpsoDPQ2R/Msixv8Z7ofvwAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3325;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=NITUG13tg6OeRjUeeRV7q4yVc5SHqZar4SuO8+29cuA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBm4CtFkj2OEzt5vjCDAw7ixveNwniJGPXDDCDjG
 3q9ejfqVZyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZuArRQAKCRD6PaqMvJYe
 9cOBEACK/WWJMncR8gV/veFBv7cUYc7po2u4ALuJ/rDNhCEQjnerX31CWZOFsBTiRQpIKzWSFYP
 vGZCwxwunaszhccgL05hhkYN8v7dKgpuLgFJicmjLq/OpE3KJoyDSIwwtcyptzMPPAuV7nz3976
 WamvaCeWoB/J9B1cFqan2GK09+XCW8XY2+DCFLEYStNoYm/4ZyzMMbH1b1AIrtn8nfEfwd3A2AO
 0TL4YHSMJcuyOwXqf51pu47u/vrg0FESIO9SXowYExsaM4sfOZICfPVgVnQfpZk9MDCZwPubmUS
 yGXQcRrHADZcKop3zIATQszwQtgBxuQiXRkDSplVhB7pISQLa1okZkWQYKyJ5nnsC7nvFQsqDTY
 1f2nG0Q5TNoXTgzzHaxUlrCuqG0NIJavKf8jmt5r+e35c62Pj0w1Hj1Bg7yVS9ZOwTzhPRylJqJ
 v15kk+z8IT0ES9nSzSXTSOSTlR9S/CIEyl+K4yNyIn1vNJLmrPQgt7DjZZ2TyYEmgFtjtwMIato
 HVgcOF+sQ/qv8a+9Qgr0+bf6OnU24eC7FUK3oC6EvxONdvRuBUgsqyonWH589Cgnp+O5NCaAI2I
 OObfIKVT0fHCtVrj8DyIIOm5oESeONwDRenPvW0XLF6XYnAtsoKN3bi2JRLWqvLKd1BAepeYRdj
 Bf9RdgmrHaZbaHA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add DisplayPort audio support for Xilinx ZynqMP platforms.

This depends on patch adding cyclic DMA mode for DPDMA driver:

https://lore.kernel.org/all/20240228042124.3074044-3-vishal.sagar@amd.com/

If that patch is missing, starting an audio playback will fail with an
ASoC error. The cyclic DMA patch has recently been accepted to the DMA
tree.

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
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

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
 drivers/gpu/drm/xlnx/zynqmp_dp_audio.c             | 461 +++++++++++++++++++++
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                |  39 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.h                |  15 +-
 11 files changed, 553 insertions(+), 105 deletions(-)
---
base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
change-id: 20240312-xilinx-dp-audio-468ad12f9f64

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


