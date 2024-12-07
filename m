Return-Path: <linux-kernel+bounces-435984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CC49E7F66
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 10:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9558418848E2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE6413C8EA;
	Sat,  7 Dec 2024 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="kpA3bEpy"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAC913D504
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733563669; cv=none; b=VWV0yuJTO8UWpYjh1gnXPNvt4oF99lx7capldrvFU7DdUiiy27JD7mPRni+Wkv/cdtuqip4vhavAA2JdlQYoZkq5boMrwqnDBGmfannF1OnWIWLM0/mwI0xLI3MoUe9VmxfnSx/7sbSsTp4w9bl/IvJed23vRquY+Xl2VaZA1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733563669; c=relaxed/simple;
	bh=Ro6MhyKNk1l+AXdNKlQl0/0Lye7Oy37t+emvxlOs2+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sOgJ5mJOwcB8ZugUBTKsUOq3uZI3BfTWSK5x6vdytX8MkLVCamZ62CZMkCDiC4Pr9hdWWXH+ORd1842mTgDlm5sveOdaUiv0TxlQmiOx0/Q4gKZRDY1x3VNcDYylpCaYSwDD//f3O2M116yagh2O7cC+y2nScJVOsE/jwO79zz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kpA3bEpy; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=kpA3bEpyz0oEBU5XERXpI1f/66ReLFXxxZSr0Lw6I22tRJiAOAi7MCNktGkTbqs8giuw4F/NkYjbCf9fdVQd0QhWOPpGHidex1DrfB81Al/IkJxLq3D0St1jSdBib7Z/vJk+Pop0uIxD2lc3q6Em8aXPnL/JdoJesXU6Y6MFtcB6ZfgjWMSYS2C2el+7MR0fLjMcQ9PFqIibhOGEPLrMivVy90ORpfBBBJBJutUVUs2hWRl9+sVFNhahbI+2kkWS1Kvr7mPO2L6dn5Yssqu6PEv6hwzlTE64Szaysic/yGUkPRBzZrlBPkRJ52xz+qqtHkmkMFwi5JGmMZ+FgB5Sgg==; s=purelymail2; d=purelymail.com; v=1; bh=Ro6MhyKNk1l+AXdNKlQl0/0Lye7Oy37t+emvxlOs2+A=; h=Feedback-ID:Received:From:Subject:Date:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 830824762;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 07 Dec 2024 09:27:19 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Subject: [PATCH v3 0/3] clk: samsung: Introduce Exynos990 clock support
Date: Sat, 07 Dec 2024 10:25:37 +0100
Message-Id: <20241207-exynos990-cmu-v3-0-20c0f6ea02f0@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEUVGcC/3XMQQ6CMBCF4auQWVtTK22sK+9hWIwwwCTQmg4SC
 OHuVvYu/5e8bwOhxCRwLzZINLNwDDmupwLqHkNHipvcYLQpL0Y7RcsaonivVT1+lL1hg1Zbh42
 F/Hknank5vGeVu2eZYloPfja/9Z80G6VV6ZxrW43a+9djpDDhMKyCgUbkMHCgJOeYOqj2ff8CE
 ZZ1sLsAAAA=
X-Change-ID: 20241206-exynos990-cmu-58ada5056ad5
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733563563; l=1623;
 i=igor.belwon@mentallysanemainliners.org; s=20241206;
 h=from:subject:message-id; bh=Ro6MhyKNk1l+AXdNKlQl0/0Lye7Oy37t+emvxlOs2+A=;
 b=hGpyVIrPLp4ffp2d87s/yShUwtjq5nAmovf1IBQ9e2hrhB/Pk62YPxVYL+M5QwPkFkKES2DGu
 uyfi9fZacYMAEF8aABhLY/RQnVScMqKlt36/jykwOdtutjTxitCWOsU
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=qKAuSTWKTaGQM0vwBxV0p6hPKMN4vh0CwZ+bozrG5lY=

Hi all,

This patchset adds support for the Clock Management Unit found in the
Exynos990 SoC. This CMU allows for clocking peripherals such as USB, UFS,
MCT, et cetera.

Currently there are two blocks implemented, CMU_TOP which
generates clocks for other blocks, and CMU_HSI0, which generates clocks
for USB. More blocks will be added (hopefully soon), like HSI1 for UFS.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
Changes in v3:
- Reordered "required:" item in bindings (Ivaylo, thank you!)
- Changed clock-names for the HSI0 block to conform with other Exynos
  platforms clock drivers. (Ivaylo, thank you!)

- Link to v2: https://lore.kernel.org/r/20241206-exynos990-cmu-v2-0-4666ff0a099b@mentallysanemainliners.org

---
Igor Belwon (3):
      dt-bindings: clock: Add Exynos990 SoC CMU bindings
      clk: samsung: clk-pll: Add support for pll_{0717x, 0718x, 0732x}
      clk: samsung: Introduce Exynos990 clock controller driver

 .../bindings/clock/samsung,exynos990-clock.yaml    |  120 ++
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos990.c                | 1343 ++++++++++++++++++++
 drivers/clk/samsung/clk-pll.c                      |   14 +-
 drivers/clk/samsung/clk-pll.h                      |    3 +
 include/dt-bindings/clock/samsung,exynos990.h      |  236 ++++
 6 files changed, 1715 insertions(+), 2 deletions(-)
---
base-commit: ebe1b11614e079c5e366ce9bd3c8f44ca0fbcc1b
change-id: 20241206-exynos990-cmu-58ada5056ad5

Best regards,
-- 
Igor Belwon <igor.belwon@mentallysanemainliners.org>


