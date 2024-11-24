Return-Path: <linux-kernel+bounces-420304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76FB9D7893
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727BF282AD5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDEE184551;
	Sun, 24 Nov 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE2eWlsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959A81632F1;
	Sun, 24 Nov 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732487381; cv=none; b=pR39AG3A/jflZv3iwjT9Fignr1Fir151SZO8TTmHyzeVIxOFB5UG8v1BxdlFBaotTjCndPgaDwT2U5lEivcnhLNweGGdPjb0Br6/g/H0KsIsdf3FpvN4axrQbf8R8p3jg3WNVCzTPmCICrOAOQPcVqT861BM9Heboi6uEieQp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732487381; c=relaxed/simple;
	bh=c79EAnCWulfs6GRWWUruMhPsTaQlP4sqW+UN5ZBM3qQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eFJAiI68imcCL7rMFeJy1+po27NgyPr42+wXBH5ZolEM1++22iHVkcpxJWtoUogj3yhPQVNho/ebpk/t4iTg0KEF02MW/G6Lxy2cq+scoRmV3sZaXaGKbcRPhOYxtvX8JtU+fp+/sNazpbSeagnQcvK3mwOi+CSRlktW4N4DI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE2eWlsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B4BFC4CED3;
	Sun, 24 Nov 2024 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732487381;
	bh=c79EAnCWulfs6GRWWUruMhPsTaQlP4sqW+UN5ZBM3qQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QE2eWlsGZUYvRr5tymXSf2YV+O+HTyF/z63nFx8qvcsdejVyHnFnqIulXzffn8yzF
	 3F+c0briKayYmDn260FNSC4tyH7XM1bHXNjMD9O7VG8pACNlsFtRkDcxC4mgjSyCID
	 y/NobayM6riJAX5YNvlR8e1m8Oin3f4VocWq6lb44QawfUyRx73Gmy0wTCRBKZ5v4Y
	 AZwQXB9Vcw9u8OLoDcKCHTBpT5qkY60wKtz70CH/v8yJT+uvaK3sVldJZsoNRnYXn5
	 jdYSPLR0x55/xpkeSYzKXc+99VPugf8ZA4sg6W54Y9jp32rLA9gYKB6upDuw53bdpm
	 rSrpGJGJnHYYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C76E668BD;
	Sun, 24 Nov 2024 22:29:41 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH 0/5] Driver for pre-DCP apple display controller.
Date: Sun, 24 Nov 2024 23:29:23 +0100
Message-Id: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMOoQ2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyMT3cSUgpSiXF0j07TkVOOUFItEc0MloOKCotS0zAqwQdGxtbUAW3O
 zcFgAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732487379; l=1534;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=c79EAnCWulfs6GRWWUruMhPsTaQlP4sqW+UN5ZBM3qQ=;
 b=s7QBvkr2M/7LlXCH7u4T7kGhNjKD+UEGgYObKwAiPkwJOUb/YCf5XOLGMPqL2P9zWjtZeWozU
 1YTYqOqXFULA3D4XrCefQz7WnGtLwUgiixx7AL+ou4ofz0QXoOYNVGG
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
Sasha Finkelstein (5):
      dt-bindgins: display: Add Apple pre-DCP display controller bindings
      gpu: drm: adp: Add Apple Display Pipe driver
      gpu: drm: adp: Add a backlight driver for the Summit LCD
      arm64: dts: apple: Add touchbar screen nodes
      MAINTAINERS: Add entries for touchbar display driver

 .../bindings/display/apple,display-pipe.yaml       |  59 ++
 .../bindings/display/panel/apple,summit.yaml       |  24 +
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/apple/t8103-j293.dts           |   8 +
 arch/arm64/boot/dts/apple/t8103.dtsi               |  26 +
 arch/arm64/boot/dts/apple/t8112-j493.dts           |  15 +
 arch/arm64/boot/dts/apple/t8112.dtsi               |  25 +
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/adp/Kconfig                        |  14 +
 drivers/gpu/drm/adp/Makefile                       |   5 +
 drivers/gpu/drm/adp/adp_drv.c                      | 814 +++++++++++++++++++++
 drivers/gpu/drm/adp/panel-summit.c                 | 108 +++
 13 files changed, 1103 insertions(+)
---
base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
change-id: 20241124-adpdrm-25fce3dd8a71



