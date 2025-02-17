Return-Path: <linux-kernel+bounces-517527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC3CA38208
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38EB173E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E3B21A436;
	Mon, 17 Feb 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRdmqC7k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B1218EB3;
	Mon, 17 Feb 2025 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792377; cv=none; b=IOJhlV18CSyQ2qhBrj2OKbevuacwkzeXIneRqypj+rSOFErRoWtQSCFsDLMpLW+sDVNACEpTcUqDZczFPe7FGOKdN4Hi5eV8se7WP6rykw1FcP9jMAq3U6NEYkwwQS1RkVXh/WADyNE+DfPhllpjemxW7ElqkvJT13Xfx8Xf15Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792377; c=relaxed/simple;
	bh=eRJtlx+TXRz4sj1yjZeqRnBx9fEKd9tRMuECk2LsGb0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y97Drp38ywJ08RiUOuYq29+pSqPJRYpeTyWnfx+GbUm0dRtth2dCXsgRaYP8P7uYTY/uwR/FbsbPQ2b9N0jrfGuXtl5IeMK8Wc0SQzU/SHtuHGTqA05DxLTcYfU5WJVM7dfdVyiziHMdxyQ34DQzgTHqq13BWMF0irnn6znw2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRdmqC7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C81CDC4CEE4;
	Mon, 17 Feb 2025 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739792376;
	bh=eRJtlx+TXRz4sj1yjZeqRnBx9fEKd9tRMuECk2LsGb0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DRdmqC7kFX+YX7FOorXzZDbEwEujI1ib5++hgeOGoBD7fMIKi1U6wsdKdNMTTxRrn
	 M/6pT5GNlnaLpPJPuZhY4PsshcA3kWyKOO9cwGU1Rw6gSf3cvTO8tACJ5vbz9VkTgI
	 UlnYyhFrPaZaUDdMqihQ2DOxPQ1OqC/o6DgarK22kJYX5cr+rGltBGPqy0cTiK4wNi
	 MQ3yE+3C1bnG7FnWFhI0MaTWPkxdCXis8StJua+xVw+BAdxWtrx40/5dRbsQlqzbEZ
	 hVjGr5xHiGfzjYo7mvveRmN0StSfl5Na0rPOCQnYqQNzO6qjkWSCdGI7+OVvhqxzaO
	 nXH1Tsi6h4w3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1A8C021A9;
	Mon, 17 Feb 2025 11:39:36 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH v7 0/5] Driver for pre-DCP apple display controller.
Date: Mon, 17 Feb 2025 12:39:30 +0100
Message-Id: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPIfs2cC/2XPy2rDMBAF0F8JWldFj5Hkyar/UbrQY5QI6jjIx
 bQE/3vlQG3jLu8w5zLzYCPVQiM7nx6s0lTGMtxacC8nFq/+diFeUstMCQVSKuA+3VPtuTI5kk6
 p806ytnyvlMv3s+j9o+VrGb+G+vPsneQy/VcxSS64lihTR5YA/dul9+XzNQ49WyomtWd2Zaqxi
 AI6o7WNAo9M/zEjmluZXph1kKLE7F0+Mtiz7UhojDAYZYXXmOWRmY0pYVZmGgMCiugwhKyOzO7
 Z9ptdjux8QA1daA/u2TzPvyoNbD+vAQAA
X-Change-ID: 20241124-adpdrm-25fce3dd8a71
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
 Janne Grunau <j@jannau.net>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alyssa Ross <hi@alyssa.is>, Sasha Finkelstein <fnkl.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neal Gompa <neal@gompa.dev>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739792375; l=2867;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=eRJtlx+TXRz4sj1yjZeqRnBx9fEKd9tRMuECk2LsGb0=;
 b=RMk5Ud/lR7LohTZmy9UXcBvRVStjq2rym8WI1uCB7NGENaBDElVWONJTm0BSFwHXh7TPamH+2
 9jlTs2MhNBVBO5XIig2VNo5M79PSAX6EfUmfQHIje6w4udnL07lurUj
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

Hi.

This patch series adds support for a secondary display controller
present on Apple M1/M2 chips and used to drive the display of the
"touchbar" touch panel present on those. 

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
Changes in v7:
- No changes aside from adding r-b trailers, effectively a resend.
- Link to v6: https://lore.kernel.org/r/20250206-adpdrm-v6-0-c8ab9348b853@gmail.com

Changes in v6:
- Use the drm_connector_helper_get_modes_fixed helper.
- Split out into a separate MAINTAINERS entry
- Link to v5: https://lore.kernel.org/r/20250205-adpdrm-v5-0-4e4ec979bbf2@gmail.com

Changes in v5:
- Moved to using the component framework.
- Other lifetime fixes
- Link to v4: https://lore.kernel.org/r/20250114-adpdrm-v4-0-e9b5260a39f1@gmail.com

Changes in v4:
- Fixed dt bindings.
- Link to v3: https://lore.kernel.org/r/20250112-adpdrm-v3-0-c674dc19fa7f@gmail.com

Changes in v3:
- Fixed building as module after splitting out mipi block
- Addressing the review feedback.
- Link to v2: https://lore.kernel.org/r/20241126-adpdrm-v2-0-c90485336c09@gmail.com

Changes in v2:
- Addressing the review feedback.
- Split out the mipi part of the display controller into a separate device
- Link to v1: https://lore.kernel.org/r/20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com

---
Sasha Finkelstein (5):
      dt-bindings: display: Add Apple pre-DCP display controller
      drm: adp: Add Apple Display Pipe driver
      drm: panel: Add a panel driver for the Summit display
      arm64: dts: apple: Add touchbar screen nodes
      MAINTAINERS: Add entries for touchbar display driver

 .../display/apple,h7-display-pipe-mipi.yaml        |  83 +++
 .../bindings/display/apple,h7-display-pipe.yaml    |  88 +++
 .../bindings/display/panel/apple,summit.yaml       |  58 ++
 MAINTAINERS                                        |  16 +
 arch/arm64/boot/dts/apple/t8103-j293.dts           |  31 ++
 arch/arm64/boot/dts/apple/t8103.dtsi               |  61 ++
 arch/arm64/boot/dts/apple/t8112-j493.dts           |  31 ++
 arch/arm64/boot/dts/apple/t8112.dtsi               |  61 ++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/adp/Kconfig                        |  17 +
 drivers/gpu/drm/adp/Makefile                       |   5 +
 drivers/gpu/drm/adp/adp-mipi.c                     | 276 +++++++++
 drivers/gpu/drm/adp/adp_drv.c                      | 617 +++++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-summit.c               | 132 +++++
 17 files changed, 1489 insertions(+)
---
base-commit: b62cef9a5c673f1b8083159f5dc03c1c5daced2f
change-id: 20241124-adpdrm-25fce3dd8a71



