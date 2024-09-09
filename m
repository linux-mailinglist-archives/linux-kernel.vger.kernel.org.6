Return-Path: <linux-kernel+bounces-321125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF02D9714E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EF7284B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C6F1B3F38;
	Mon,  9 Sep 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKyCT0K4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59291B3B2D;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876557; cv=none; b=mYFMEsfzSA1fkuPDyECXG2RHf+915b6yTWm5pg2Td6lC0nVZzQRek53Mg9ldb0cHAMX83SWVK3h8Na84ihC+YiNmn2bGtS+coQScouJDnhBLgmB6Dnne3pwCwE4shXmnZcX+qOJD7cp6a2YCC/FcNPFcETLbEVb0uiLvKtl1khw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876557; c=relaxed/simple;
	bh=C7UAKdScvu7TqeOxKRUYoZYp71CrNXj0fxW/6EE1p80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ziswleu3e2mCQRA/k46707XrNnJ2t7eAdUGBmqqYGq+D5zhFPtpZznM3MaeAt3avS7XngUWuwCSO+3uO73q2HgrdvpnLX6VFrplDMJNPJlZXh9pN8C5taG38MCbHobUe0srPd6UyoU2O8orB9NDXkEV1CMyBmmhLNPDix2cLijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKyCT0K4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51807C4CEC5;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725876557;
	bh=C7UAKdScvu7TqeOxKRUYoZYp71CrNXj0fxW/6EE1p80=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iKyCT0K4PzGo7YlCMs9PzcPsdrdRWcCagpOicLeWx2QXvdGHcsUCP0R1ITAqC7/Wp
	 E39v1EUTbBMaB+/8BFEm77O0FKhrpOfdzHPmVcUjnWM2vuMyriNhQhNPS2248EopWj
	 K53PW0E1GKISSSCng980tExiLdy/SIA8Gu3PUHT6cBwh9tGlyd4VwO493u0Uz7i4YC
	 ELe2jOCl51RFzdWoRxpa/OxoXov222Tw/PXg0r74UhFRwn0Vp51P+ZgD3zKXs0Qoxb
	 LxAXZBmxn3c09Ra+dy4nvDnQp58YUPy0oLyoWu9opG8fdQVcpfTmNF4PCIllpeEnih
	 FS4Jvtz/ORz3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1D2ECE57E;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH v3 0/3] clk: meson: Fix an issue with inaccurate hifi_pll
 frequency
Date: Mon, 09 Sep 2024 18:08:55 +0800
Message-Id: <20240909-fix_clk-v3-0-a6d8f6333c04@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjJ3mYC/3WMQQrCMBBFr1KyNpJMS2JdeQ8RSdNJO9g2kkhQS
 u9uWlBw4fLN/PdmFjEQRnYsZhYwUSQ/ZSh3BbO9mTrk1GZmIKAStai4o+fVDjeu1MFpIw00UrG
 8vgfMr610vmTuKT58eG3hJNfrp6G+jSS54FBrjU60GlCfzDj4juze+pGtlQR/TMimNmVdSWzAt
 u7XXJblDTHE2i3aAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876555; l=2168;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=C7UAKdScvu7TqeOxKRUYoZYp71CrNXj0fxW/6EE1p80=;
 b=r9wUHlsoq+nN2A4qwXV3+SL+QBGKsPgq1dITS+PtSp9p0RSpqv12zxxoy3xJOqTi6JUlv6j19
 abISxvo8WXbAgvtHG2Kc1n/BF7CodJCx2fpxzYaOaXsQOac3SIrYpkN
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

Some PLLS with fractional multipliers have fractional denominators with
fixed values, instead of the previous "(1 << pll-> frc.width)".

The hifi_pll for both C3 and S4 supports a fractional multiplier and has
a fixed fractional denominator of "100000".

Here are the results of the C3-based command tests (already defined
CLOCK_ALLOW_WRITE_DEBUGFS):
* echo 491520000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
* cat /sys/kernel/debug/clk/hifi_pll/clk_rate
491520000
* echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
* cat /sys/kernel/debug/meson-clk-msr/clks/hifi_pll_clk
491515625       +/-15625Hz
* devmem 0xfe008100 32
0xD00304A3
* devmem 0xfe008104 32
0x00014820

Based on the register information read above, it can be obtained:
m = 0xA3 = 0d163;
n = 0x1 = 0d1
frac = 0x14820 = 0d84000
od = 0x3 = 0d3

hifi_pll calculates the output frequency:
calc_rate = xtal_rate / n * (m + (frac / frac_max)) >> od;
calc_rate = 24000000 / 1 * (163 + (84000 / 100000)) >> 3;
calc_rate = 491520000

clk_rate, msr_rate, and calc_rate all match.

The test and calculation results of S4 are consistent with those of C3,
which will not be repeated here.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Changes in v3:
- Drop the call to unlikely().
- Link to v2: https://lore.kernel.org/r/20240906-fix_clk-v2-0-7a3941eb2cdf@amlogic.com

Changes in v2:
- Added frac_max to the pll parameter instead of flag.
- frac_max is added to hifi_pll for C3 and S4.
- Link to v1: https://lore.kernel.org/r/20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com

---
Chuan Liu (3):
      clk: meson: Support PLL with fixed fractional denominators
      clk: meson: c3: pll: fix frac maximum value for hifi_pll
      clk: meson: s4: pll: fix frac maximum value for hifi_pll

 drivers/clk/meson/c3-pll.c  | 1 +
 drivers/clk/meson/clk-pll.c | 8 +++++---
 drivers/clk/meson/clk-pll.h | 1 +
 drivers/clk/meson/s4-pll.c  | 1 +
 4 files changed, 8 insertions(+), 3 deletions(-)
---
base-commit: 80344f4c1a1edec507a20adca476af84ea58cd4c
change-id: 20240904-fix_clk-668f7a1a2b16

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



