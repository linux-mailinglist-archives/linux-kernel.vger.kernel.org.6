Return-Path: <linux-kernel+bounces-283276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22BA94EF79
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54001C217CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0CF183094;
	Mon, 12 Aug 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="hLKWZiAs"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AC17F4E5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472774; cv=none; b=SfGPOjVlhDzm5Pypb5nYw39Pqc8DBDRo0iWCGinQaVfcXirav/wwtJ5jEUx1PruSp9McLnL3WSAcZpoJWgoXbJSHG97sh9YSMcUn1BU4HokfxcxcHkynBvpCZC5FF3oJQsNIWDfiUBepnP93tHFDtcPw2j6C/ep4pR7Xx/jbpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472774; c=relaxed/simple;
	bh=V/XN2IJlnRlLKosTXmH+9S6EEI//usQMCIJ8qs/hozw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhR2eLQvomV4xuwbbeBlqs/I6QBczH18WwDr8Blr3SsHbSuIaFuyA2zO6bm/1Dcm9dLLjfRD5/4qew6dumUYZjFAOpOzFnduOTCktn5eMR7N6Z0t3olxYiyfJPkHh53YJb75wFcCjZ26fqezrjr1F3891nBtZj4AVNhXQloyD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=hLKWZiAs; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240812141554b49d59cb063aced410
        for <linux-kernel@vger.kernel.org>;
        Mon, 12 Aug 2024 16:15:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=pd/VpIRV516pqsgMsPuysNVtHzsHKVyjXVwp6LAdEi8=;
 b=hLKWZiAse5JNnpzONR2N3Qr9k8QD8eToGyE3sS7yIaom9QuW26iJLSAEPUN9l4vChF14QR
 dz+JHQEAFK9bAgoTPOmcPAuIdkxfoLYUnCyeGt5AQ5yfpA9Hz7xHleTa83DWuKniD4N8Xglf
 2dHWVqUfhK+aX689K19w3COLiqcwp4/0qVTUotmoYy5q4vgzIVp2b6tVKF78ZRgwb4RJuKH1
 WyEzRMC9bagza537JMGkVnCoL6EYw09geoQJn68qwqw8lrYbmOY5F1QCUpkca7OtrJbfZ8Jf
 Dl0XkV+BGZmyTK3sQTHI63gpUtiFu47ah+9OYuKw0If2nW6JX+QqRDwg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Minda Chen <minda.chen@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/3] riscv: jh7110: Fix configuration for on-chip USB 2.0 support
Date: Mon, 12 Aug 2024 16:15:50 +0200
Message-ID: <cover.1723472153.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

While mainline has support for the USB controller of the JH7110 since 6.5,
this never really worked, even not with latest downstream kernels by Starfive -
unless you were also using an old downstream U-Boot version. The reason for
that was a missing syscon setting that prevented the connection between USB
2.0 PHY and the controller. This series finally fixes the issue.

Changes in v2:
 - fix copy&paste mistake in error patch found by kernel test robot and Dan Carpenter

Jan

CC: Conor Dooley <conor+dt@kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>

Jan Kiszka (3):
  dt-bindings: phy: jh7110-usb-phy: Add sys-syscon property
  riscv: dts: starfive: jh7110: Add sys-syscon property to usbphy0
  phy: starfive: jh7110-usb: Fix link configuration to controller

 .../bindings/phy/starfive,jh7110-usb-phy.yaml | 11 ++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  1 +
 drivers/phy/starfive/phy-jh7110-usb.c         | 20 +++++++++++++++++++
 3 files changed, 32 insertions(+)

-- 
2.43.0


