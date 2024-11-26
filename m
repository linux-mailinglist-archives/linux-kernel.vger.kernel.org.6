Return-Path: <linux-kernel+bounces-422586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD83E9D9B91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8464C286AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ECB1DACB4;
	Tue, 26 Nov 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a99O8UWv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A191D9694;
	Tue, 26 Nov 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638866; cv=none; b=KU6oOVuTBHcWmL2TkQ/tiM7uaUt7WtsDM5FeBB53P4W2n4ftEN8ZydNJoknZBN06uBJbVZKVsKJT6v8U8cEJSi3anzHa5dndYZEiwnVXmN4MaWORtYyIa1Toz3J8qXRHGiuiMw+4py0uWhd8GwS4kX/Nz7KC4a+oboAQf338Vf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638866; c=relaxed/simple;
	bh=/LDcePj0XDKsYma0zK+FP7xyH1ASdKtuEO+PZnGEDFc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZTvtBQyHRCh+tcNd/V7hSfyZDVNgSxm/1djTxA182RkHIPx8N1FxgdtrUnXHRg5L8VG9y6u6GL1xlMYyG7mWtiAkJcVed3VbmlKMeSjk6jfwBaUjQB5gACmmzVVYIQgHiMcOVjfZ6VM6FDaoZ/eYg20jhhJO2W5oF0xoDxObMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a99O8UWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4865C4CED3;
	Tue, 26 Nov 2024 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732638865;
	bh=/LDcePj0XDKsYma0zK+FP7xyH1ASdKtuEO+PZnGEDFc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=a99O8UWvqNcfnyMxK2dxnhjfTBiX2N75eQ/DkDrR+dQA6DZluHFfy88xA0PWdPhzu
	 DRAGNJkMHf2pRK7rIi5zMgTk0dbFtMuhUCBtawk6M1fHm44i6sOjHcQZSDHj7HOAyW
	 3m78QcpINTiKv/Lf2wo2E1dwQgz5zNDpp3dabtm229Nlw17itUow0JlSWqRzI1aH53
	 v3ZS6HensCtlQI9ft2UwzHvKoszRdb07g9bfgCJUi7AOfePesWu1kDlISbU+EJ+IqC
	 +rFNcpNz+zoJLDql0cxBrXBOC9jDXm+iEdophb3ptSV7fi0TP0NAaGEQ/Qt6U5ekm5
	 EqVl5OtcNDRLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BBBD3B9BE;
	Tue, 26 Nov 2024 16:34:25 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH v2 0/5] Driver for pre-DCP apple display controller.
Date: Tue, 26 Nov 2024 17:34:19 +0100
Message-Id: <20241126-adpdrm-v2-0-c90485336c09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIv4RWcC/2XMQQ6CMBCF4auQWVvDlKrAynsYFk1ngEkskNY0G
 tK7W9m6/F9evh0iB+EIfbVD4CRR1qWEPlXgZrtMrIRKg661QdRGWdooeKUvo+OGqLU3hHLeAo/
 yPqDHUHqW+FrD53AT/tY/IqGqVYMdUstXNp29T97K8+xWD0PO+QtOmwltnAAAAA==
X-Change-ID: 20241124-adpdrm-25fce3dd8a71
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732638864; l=2009;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=/LDcePj0XDKsYma0zK+FP7xyH1ASdKtuEO+PZnGEDFc=;
 b=OZR7bklMcaizua9kd4TjpLz0AjqB1X+Vunzk81NYY7+bDd6YxbJUoKnvBPvak/Wdfbw4r/1u6
 ivWR35297jmCQnjxOTmbOKHjfiKdJI/RzDIBL6aOxGv6AdRQodof9IX
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
Changes in v2:
- Addressing the review feedback.
- Split out the mipi part of the display controller into a separate device
- Link to v1: https://lore.kernel.org/r/20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com

---
Sasha Finkelstein (5):
      dt-bindings: display: Add Apple pre-DCP display controller bindings
      drm: adp: Add Apple Display Pipe driver
      drm: panel: Add a panel driver for the Summit display
      arm64: dts: apple: Add touchbar screen nodes
      MAINTAINERS: Add entries for touchbar display driver

 .../display/apple,h7-display-pipe-mipi.yaml        |  89 +++
 .../bindings/display/apple,h7-display-pipe.yaml    |  77 +++
 .../bindings/display/panel/apple,summit.yaml       |  58 ++
 MAINTAINERS                                        |   5 +
 arch/arm64/boot/dts/apple/t8103-j293.dts           |  31 ++
 arch/arm64/boot/dts/apple/t8103.dtsi               |  61 +++
 arch/arm64/boot/dts/apple/t8112-j493.dts           |  31 ++
 arch/arm64/boot/dts/apple/t8112.dtsi               |  62 +++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/adp/Kconfig                        |  16 +
 drivers/gpu/drm/adp/Makefile                       |   4 +
 drivers/gpu/drm/adp/adp-mipi.c                     | 251 +++++++++
 drivers/gpu/drm/adp/adp_drv.c                      | 594 +++++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-summit.c               | 143 +++++
 17 files changed, 1435 insertions(+)
---
base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
change-id: 20241124-adpdrm-25fce3dd8a71



