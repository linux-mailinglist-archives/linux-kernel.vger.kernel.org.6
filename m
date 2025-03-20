Return-Path: <linux-kernel+bounces-569432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84697A6A2E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE1E3BE9CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A8224236;
	Thu, 20 Mar 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJqkP0AW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214642A93;
	Thu, 20 Mar 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463759; cv=none; b=W/CtsZR1vXgkbSvtd9wrOKtSAjXYfaPHK3J7/Uqn+zFXVdUpYI3Ygc2wzPIGvvF+aoUAIwA4kK+3KcilH/2/FBPIYLcI8szvfIyb6kBsDHdbDmpaiyoJ2JSebvHwrQmzjR3Otp7DZKggzd/gtwjG/i27zswViMkCgz15xzEal+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463759; c=relaxed/simple;
	bh=tmmYDcXWXP5v9hOu5c1RzTIofH/+ekVsnoiPWg8PmP4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=etVC+ofFj+Oo9lE/78ZilfF5aI2JzL4xXLsYCo6M1SJ71Nh1Oja23VcyEqVfJ3VytCIBJ0Kubrm6fq3OmVDS5AiA+1uCBxCoaW8BoWVIv4ryHBZyRY73WMFKGP8461KdGn7RinBMhdwZNPVKZIxuZ4excLhSGL7epJt58uwfGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJqkP0AW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6F61C4CEDD;
	Thu, 20 Mar 2025 09:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742463758;
	bh=tmmYDcXWXP5v9hOu5c1RzTIofH/+ekVsnoiPWg8PmP4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=CJqkP0AWvMSw5PqbZ9NuZfobLKy2y8F9rQ46T2Gec8KN/93VS/N0u7yc9EFoChlNx
	 0ReMWP7vADqQ9Dl8UPnRpAvAdX6DQ5OjYnfRP4qxzeRxEICVC9A+fDUaPhlV+H7LUT
	 EImFScARttvfaR6cKUC4u8DFrhzUPMlZeShOpLPHq+KH8qCssdkrQ+6uQWBlpxckeD
	 DFdIvWW1Xm65T6rWqv7UbIgToHn/wNxtWC04nT5y5wxmDKqnnAPEzPtxiYp4EQ4YAc
	 wKQkiTqXZuPtaBAhqUG42a0+gS65UPZwr8phyf75fFgK34inulLB8lvpEDBsJHhTzk
	 KiT9pq1AJXh/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6632C28B30;
	Thu, 20 Mar 2025 09:42:38 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH v5 0/3] Add support for Amlogic A4/A5 Reset
Date: Thu, 20 Mar 2025 17:42:07 +0800
Message-Id: <20250320-a4-a5-reset-v5-0-296f83bf733d@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/i22cC/23OQQqDMBCF4atI1h1JNImxq96juEjjRANqJBFpK
 969Ueii0M3Av5iPt5GIwWEk12wjAVcXnZ9SiEtGTK+nDsG1qUlBC0FLVoLmoAUEjLiAlLVE8WA
 KGSXpYw5o3fPU7k1qG/wISx9Qfw1Oa6ZoxQvGckVlBQzeOPipy9t0bnocfOdMbvx4eL2Liw+vc
 9zKD/X/jpUDhcRKKxVvpbE/ULPv+wcXqykJ6AAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742463756; l=2430;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=tmmYDcXWXP5v9hOu5c1RzTIofH/+ekVsnoiPWg8PmP4=;
 b=2xwp9yaqEA8eQ6er0AAQQeZeArBNXbW+XSNv/QZW5i8mWfeyfCli+/D3cz4kCFJ3TLEKP9WLS
 3BrBtFjkJAFAKDB2eNUkoEKsUCeoTxFD4ZEK0rI1MefV5HiH+gmSYZE
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add dt-binding compatibles and device nodes for Amlogic A4/A5 reset.

Imported from f20240918074211.8067-1-zelong.dong@amlogic.com

Changes in v5:
- Rebasing on top of the latest upstream changes.
- Link to v4: https://lore.kernel.org/r/20250313-a4-a5-reset-v4-0-8076f684d6cf@amlogic.com

Changes in v4:
- Remove the superfluous 'items' in the dt-binding.
- Rebasing due to recent upstream changes.
- Link to v3: https://lore.kernel.org/all/20240918074211.8067-1-zelong.dong@amlogic.com/

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
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        |  8 ++
 5 files changed, 218 insertions(+), 8 deletions(-)
---
base-commit: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
change-id: 20250313-a4-a5-reset-6696e5b18e10

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



