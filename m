Return-Path: <linux-kernel+bounces-537955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F34BA492E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491EC1713A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D42B1DF973;
	Fri, 28 Feb 2025 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggHJbmaV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F01DEFC5;
	Fri, 28 Feb 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729875; cv=none; b=gYmT0QMiH9Z9GHZiZRnqQlgbFsZbtQgiHZluYzeeOnnueMSJdPjcKkyGcszihc+mfVfPVaaBYIp2R02BjruMYhDcfZqOLF7vDIYZ9nzn+cCMOvSiD7yrXX2oKamhe+zKYwD1SM4uk3I9o8ae/ucg39f7xmN6s17V0fp+wvDngZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729875; c=relaxed/simple;
	bh=x2141hNFezK6mYwqWQI9537WXt7YCIJnzh0zwLxszv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=arn4imeAw9BC6e8q5YGLf2Y4m5Ljbs7PzcrXS2qzt2bilVVopN/SzDaULefqWTUpBnVaogIYoXB5FxvkEP9PBAoLw0wlmcRZSXz24NMcAM5b5c/Sm+MEOq1SMG+dhGN8okCK1/My8C1vPV++j95c6h3WXvIoSecj6q9lQUcgiGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggHJbmaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D17D6C4CED6;
	Fri, 28 Feb 2025 08:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740729874;
	bh=x2141hNFezK6mYwqWQI9537WXt7YCIJnzh0zwLxszv8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ggHJbmaVVOISS/Zmur3noPoa9ob4zXIkPHN/yvlkzVW30sINZG185Q7hEHhYiN+eR
	 yen0N5/zOSKn8GEgJHuBTwcSFevgaUGaTUK/F4awi5n/IELEwzVhtQ+8D6inTliy62
	 wAJeMGLJ3qZAmGSqNqnhzCwlg6khEWpO6JAu3DFbEuKe+xTetT+TUW/4LT9UU127ew
	 WQM1C8vNbbAElSCdlxqhkoDHn/Re8zYCFGaI6Z06zI5+Eb4EBOuVecqulbYYt/ZQ+0
	 zyLB/BBEFBx+QdgbxotiPFjxLEYt6PNVUS3gs1+EBph/xJWce+wNqG5N0I1UICA4Q2
	 Eb5P29/iNrRsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF6DC282C5;
	Fri, 28 Feb 2025 08:04:34 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Subject: [PATCH v3 0/6] Add support for S4 audio
Date: Fri, 28 Feb 2025 16:04:08 +0800
Message-Id: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPhtwWcC/13M0QrCIBiG4VsZHmf4q0PXUfcREebc9kOboSXF8
 N5zg4h1+H3wPjOJLqCL5FDNJLiEEf1UhthVxA5m6h3FtmzCGa8ZAKPm2aK/tCGhC5QpUwsNVjb
 ySkpyD67D18qdzmUPGB8+vFc9wfJ+IbGFElBGtQWpFOuENuxoxpvv0e6tH8lCJf7LOci/nJdcK
 K2hM0LZxm3znPMH59QOeOkAAAA=
X-Change-ID: 20250110-audio_drvier-07a5381c494b
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com, 
 jiebing chen <jiebing.chen@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740729872; l=1652;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=x2141hNFezK6mYwqWQI9537WXt7YCIJnzh0zwLxszv8=;
 b=D0A/1LXJsQqSGXP7YG/LoMPSb5KDruBemjmW99wLhc4KV+CLVtukH8eStEK+HV3PGNIo4yL/o
 9+irLhQOedMDqh4SfvL/ccR5s7Ie9UnlESjSA7Etj+eVhwTWTgYbH3T
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

Add s4 audio base driver. 

Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
---
Changes in v3:
- remove g12a tocodec switch event
- Modify the incorrect title for dt-bindings
- Link to v2: https://lore.kernel.org/r/20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com

Changes in v2:
- remove tdm pad control and change tocodec base on g12a
- change hifipll rate to support 24bit
- add s4 audio clock
- Link to v1: https://lore.kernel.org/r/20250113-audio_drvier-v1-0-8c14770f38a0@amlogic.com

---
jiebing chen (6):
      dt-bindings: clock: meson: Add audio power domain for s4 soc
      dt-bindings: clock: axg-audio: Add mclk and sclk pad clock ids
      dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
      clk: meson: axg-audio: Add the mclk pad div for s4
      ASoC: meson: s4: Add s4 tocodec driver
      arm64: dts: amlogic: Add Amlogic S4 Audio

 .../bindings/clock/amlogic,axg-audio-clkc.yaml     |  18 +
 .../bindings/sound/amlogic,g12a-toacodec.yaml      |   1 +
 .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     | 219 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 371 ++++++++++++++++++-
 drivers/clk/meson/axg-audio.c                      | 410 ++++++++++++++++++++-
 drivers/clk/meson/axg-audio.h                      |   4 +
 include/dt-bindings/clock/axg-audio-clkc.h         |  11 +
 sound/soc/meson/g12a-toacodec.c                    |  51 +++
 8 files changed, 1081 insertions(+), 4 deletions(-)
---
base-commit: 6ecd20965bdc21b265a0671ccf36d9ad8043f5ab
change-id: 20250110-audio_drvier-07a5381c494b

Best regards,
-- 
jiebing chen <jiebing.chen@amlogic.com>



