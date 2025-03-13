Return-Path: <linux-kernel+bounces-559061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A01A5EF01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860F717D454
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF93E264F83;
	Thu, 13 Mar 2025 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bza46KCm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EEB263F51;
	Thu, 13 Mar 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856789; cv=none; b=Gxp1/BRpBqo9K60INpHURbh7BS89NKcWZ2vEV0cIXP6ZYWoRT1zvOT2JfJd4BZWsylPXjUUEhq0QzHoTcJpXrO51/3w29ZNOlgpzjDl4VeO5j6W4U+zwaPWxH3QsjuoZIWhHP60/n0PFOGsE1b0xaMhjpj5T79nnOjIj7uGniaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856789; c=relaxed/simple;
	bh=1ja7mHZeHudNCodpKe3qYm3l9veMaBwyP3hwIp5NWr4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J+eiuvX/uymXWCCUrUX2kHxkSeVOdxajgkgdYVuwSGnvjTrdCcxXFLgyR2Syp07PQLvjneucgZwAuoEHg8A9LEQS0a3yQsGNzGnx4ZGbBqB83+l26Vb1esZ599e1NnpJ924cUYShEmIDMq0e7XZaKQ+px1xQMmZbCUcm4//yQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bza46KCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2521BC4CEE3;
	Thu, 13 Mar 2025 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856788;
	bh=1ja7mHZeHudNCodpKe3qYm3l9veMaBwyP3hwIp5NWr4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Bza46KCm/po/0NmJzXHx8CnYXBVzoXsebR/FP18uu3aHSfrCWZ+QOuxuVEuFSSJBc
	 jCbDOxAM2uCc2O4fwjiEkLvwvzrzUz/rN97LTIvHHjNTxWnIkUc0TgzgnY6hmKJeRA
	 /TlCY0EbuDfaIoBuhMBBSM7wxSPMg+N3BoHhdcS5rAm4P6tvGBa4ZJiziuuYmaIrsp
	 MH2yGbaERZeIJBoxYjrdENS51UyB6zWZwU5o4aKStl523x9C0eQOSvLnVcfl5eVz1H
	 WUKDuDBhu7s8+l7eLmxoWQSbY0AjtYFe1mJ25zSc0jydgcoDBu/30DkL/4XGWN7b5I
	 5OwzrwagWzv8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0803CC282DE;
	Thu, 13 Mar 2025 09:06:28 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH v4 0/3] Add support for Amlogic A4/A5 Reset
Date: Thu, 13 Mar 2025 17:05:33 +0800
Message-Id: <20250313-a4-a5-reset-v4-0-8076f684d6cf@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN2f0mcC/zXMQQqDMBCF4avIrDsho0mMXfUepYtUxxhQI4mUU
 vHuDYVuHnyL9x+QOQXOcK0OSPwKOcS1QF0q6Ce3esYwFEMtay0batApdBoTZ97RmM6wfpJlklA
 eW+IxvH+1+6N4THHBfUrs/g0lO7KyVTWRsNK0SPjhOa5eDGVubpmjD73o4wLn+QVKZgpXnQAAA
 A==
X-Change-ID: 20250313-a4-a5-reset-6696e5b18e10
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zelong Dong <zelong.dong@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Kelvin Zhang <kelvin.zhang@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741856786; l=2180;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=1ja7mHZeHudNCodpKe3qYm3l9veMaBwyP3hwIp5NWr4=;
 b=+y6YpahXn/H8d6uBxPaLg0oIdcj3Whr285cRL5hi5hAjNJpt/pR8MZbPy74o3ZyW3XZdyiiFL
 yAJEEaYHUltC55VwID1a4W+FwgAxlSZDF2VWghoy11wLeK5un2gSVeB
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add dt-binding compatibles and device nodes for Amlogic A4/A5 reset.

Imported from f20240918074211.8067-1-zelong.dong@amlogic.com

Changes in v4:
- Remove the superfluous 'items' in the dt-binding.
- Rebasing due to recent upstream changes.

Changes in v3:
- rebase on 'amlogic,t7-reset' patchset
- Link to v2: https://lore.kernel.org/all/20240715051217.5286-1-zelong.dong@amlogic.com/

Changes in v2:
- remove 'amlogic,t7-reset'
- move 'amlogic,c3-reset' to the other enum list
- move reset node from amlogic-a4-common.dtsi to
  amlogic-a4.dtsi/amlogic-a5.dtsi
- Link to v1: https://lore.kernel.org/all/20240703061610.37217-1-zelong.dong@amlogic.com/

---
Zelong Dong (3):
  dt-bindings: reset: Add compatible for Amlogic A4/A5 Reset Controller
  arm64: dts: amlogic: Add Amlogic A4 reset controller
  arm64: dts: amlogic: Add Amlogic A5 reset controller

 .../bindings/reset/amlogic,meson-reset.yaml   | 23 +++--
 .../arm64/boot/dts/amlogic/amlogic-a4-reset.h | 93 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi   | 10 ++
 .../arm64/boot/dts/amlogic/amlogic-a5-reset.h | 95 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi   | 10 ++
 5 files changed, 223 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h

--
2.35.1

---
Zelong Dong (3):
      dt-bindings: reset: Add compatible for Amlogic A4/A5 Reset Controller
      arm64: dts: amlogic: Add A4 Reset Controller
      arm64: dts: amlogic: Add A5 Reset Controller

 .../bindings/reset/amlogic,meson-reset.yaml        | 22 +++--
 arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h     | 93 +++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |  8 ++
 arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h     | 95 ++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 10 +++
 5 files changed, 220 insertions(+), 8 deletions(-)
---
base-commit: 9fbcd7b32bf7c0a5bda0f22c25df29d00a872017
change-id: 20250313-a4-a5-reset-6696e5b18e10

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



