Return-Path: <linux-kernel+bounces-206311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B50839007B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A4B1C23B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAEC199E8F;
	Fri,  7 Jun 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="mALkROfw"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD118732F;
	Fri,  7 Jun 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771939; cv=none; b=c0eSprP8vZ1rmNMPw0D2g4wMqLH6bbz7CWSR5SK4TDSvWQGURTIsu9wug/TR/9G4M0tgdJUnMp09ZCVbLmx9tiMa1D9zLCGMiCeKZ4uj0pEeyY1IZtvUORA3T78pY8a8rTmbmqvx+z1qkstwxy2r9T8/WV11h9kja8c5wuBM2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771939; c=relaxed/simple;
	bh=j2UtZvnfethoTFHwn5s9iGaN6lSq9VkOWo0P2Bvb8Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWTtyN+Xvsie+J92xzuAcqf5UUivzbJupGRTL/5Hea5lbWa5ZEZN2VErS/hh4bA8Ovjo+1iGb6/8nvyDjlJcn+9Afv3kr+AMqC4poX4gYbSN/cMg/+6wL0hq5ceP00qig0XWad4RT7DPBL4nJ1m5iKi/wO7O2v3uKqgNzguTP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=mALkROfw; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6F8D105B34;
	Fri,  7 Jun 2024 17:51:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1717771923; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=geCYlXiO0IWtdW5F32VwIPOBGEnsd+xctEzn2zYkT+Q=;
	b=mALkROfww//auwXsXckN7RnBgbpRARuAQO54gWBvcmpHminERhO/pKBKkhW/pNqaEJB6yZ
	lBVDM28GVNkz/hPbPqWCNBVPARmoBbPBd2PuNnJkO5kCm7UY7GMnj4Ok9c++lhwer5Sc+A
	vibn8v8eCzV65Xs6pKFWs4GHZ5zt2TpFB5LII9VHwwO0JjpioZQQJdBHO8ri8zaWIsbIhR
	K8EQH+XVsmsA6IEJ285aKv0pSN5zSHjV9paZNVpIaDrQs7x06BXwnC3jzz6oFb7yMaC3Hv
	2UtpdIB0OzsgYuX2mp5qEk+rb6/dOK2M+hzeE5lvDZ3lsSy1g5JIKb8OF78mrQ==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] arm64: meson: add support for JetHome JetHub D2
Date: Fri,  7 Jun 2024 17:50:02 +0300
Message-ID: <20240607145148.2246990-1-adeep@lexina.in>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add support for new controller.
JetHome Jethub D2 (j200) is a home automation controller with the following
features:
  - DIN Rail Mounting
  - Amlogic S905X3 (ARM Cortex-A55) quad-core
  - micro-HDMI video out
  - 4GB LPDDR4
  - 32GB eMMC flash
  - 1 x USB 2.0
  - 1 x 10/100/1000Mbps ethernet
  - two module slots for radio/wire interface cards
  - 2 x gpio LEDS
  - 1 x 1-Wire
  - 1 x RS-485
  - 3 x dry contact digital GPIO inputs
  - 2 x relay GPIO outputs
  - DC 9-36V power source with battery UPS on board option

Viacheslav Bocharov (2):
  dt-bindings: arm: amlogic: add binding for JetHome JetHub D2
  arm64: dts: meson-axg: add support for JetHome JetHub D2 (j200)

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-sm1-jethome-jethub-j200.dts | 614 ++++++++++++++++++
 3 files changed, 616 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dts


base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
-- 
2.45.2


