Return-Path: <linux-kernel+bounces-238939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E589253B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B740F287D96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF9A13213B;
	Wed,  3 Jul 2024 06:31:29 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799049641;
	Wed,  3 Jul 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988289; cv=none; b=SdW31fK5jCN9LIDhS11t/ThQYDTiTgPOTZ1CW5/vHzK6EdrGJB4eCv0cL/xTKcyhnxwhhY3Vthy5xUxQ+guj2lWpK2k8FzqWwibCBm4xQn8TqjkcCupRBZibmvG6QozQhaWhLy/hATe08wT0aIusnVo57yidB0F7+CRVEGknY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988289; c=relaxed/simple;
	bh=wPHD84jZMZht71iaK0Af8cD7f+Ly3by38T6UF64r0R8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rlrhcCnXAbyp7QO9rWgUZ+VX7Ai5C3RLYKO1zdqUknOXGMXB9PNYuKIICduZryIP+LJ9Wbs47BS8MnxdIr5+J181XFO1HEETe/4KavZhHIFLzFh7mSk1/lZTWyAEG1j8vwQu7VFecv5772QO1QRCgyZwxqgHn69/tczNrnuGgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid10-sz.amlogic.com (10.28.11.69) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Wed, 3 Jul 2024
 14:16:13 +0800
From: zelong dong <zelong.dong@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>, Rob Herring
	<robh@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kelvin.zhang@amlogic.com>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 0/3] reset: amlogic-a4/a5: add reset driver
Date: Wed, 3 Jul 2024 14:16:07 +0800
Message-ID: <20240703061610.37217-1-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zelong Dong <zelong.dong@amlogic.com>

This patchset adds Reset controller driver support for
Amlogic A4/A5 SoC. The RESET registers count and offset
for A4/A5 Soc are same as S4 Soc.

Zelong Dong (3):
  dt-bindings: reset: Add compatible and DT bindings for Amlogic A4/A5
    Reset Controller
  arm64: dts: amlogic: Add Amlogic A4 reset controller
  arm64: dts: amlogic: Add Amlogic A5 reset controller

 .../bindings/reset/amlogic,meson-reset.yaml   | 22 +++--
 .../boot/dts/amlogic/amlogic-a4-common.dtsi   |  8 ++
 .../arm64/boot/dts/amlogic/amlogic-a4-reset.h | 93 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi   |  1 +
 .../arm64/boot/dts/amlogic/amlogic-a5-reset.h | 95 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi   |  1 +
 6 files changed, 213 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h

-- 
2.35.1


