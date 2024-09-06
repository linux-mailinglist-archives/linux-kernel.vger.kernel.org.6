Return-Path: <linux-kernel+bounces-318680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A096F19C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15328B242E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6011CA686;
	Fri,  6 Sep 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHQ3RjM5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784EF1C9EBA;
	Fri,  6 Sep 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618898; cv=none; b=LbpD89f3jBUipJtSUmja5DYSkwqYM816aQLKhIhjrvOf3P5NLzaFJyy8QhYhlr12vIpIxsW5gfSVOGG5C9Z2AnzbTtLMjRmuMOkZ74wpV1RZa+2Ms40xIYnAogEQ8tunkAQXEQSKQBJBmUBdW63dVYhB2/ee/Z6bdJqj4WsGhu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618898; c=relaxed/simple;
	bh=7v54Zyw0i0C7dV0JkDzLhWAWLm9ZlK6RJGxHS8FL/Mo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MV27C666t67UZwqLhHahgI5SlG7QIugyPBKTl4iEb335dip5grJJKyG3F0pEfM1W+XPGN7Ml3okRljbmW+j4MEkYkorIgDrgeZom3eNImT+nw6K9v/8ynrFH5F3XCWQ0dlH6yyHgPnjskeDUAZHL7dFAL6O0VXxX1T3Q+Xwlszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHQ3RjM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1767C4CEC4;
	Fri,  6 Sep 2024 10:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725618898;
	bh=7v54Zyw0i0C7dV0JkDzLhWAWLm9ZlK6RJGxHS8FL/Mo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DHQ3RjM51GgPIb4qS4GAWbKuBBFegHLtmS0VKUoFMJvkC+iJDqS2m8uqdH1vSAalw
	 nF9ThSuDHpEmRSs4eNHTJP1/mh37/x2v1WDmsX+YsfGqcEM7Gd6VlPLMM6V9hQAJnD
	 nKTBEyM3K0/Ke4s574Cd/oPRJl+eWjYkMQ8RxQFwip16hnmftJ4yV8HeLcMeceIu/1
	 Igl1rUHOgXx5ZzRSnWhc0seNM17anac1I5v4GYnjb50+3Q5b3oGnVcSZwfjwYWYEJm
	 LfCE92K7RYPbQqq5PHDXxQL9tAI9KVXIwtBVXzoVV4sZykIQKE4VU6x29fo9ArUydN
	 1KjZRPOMeb7aQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C958ECD5BDD;
	Fri,  6 Sep 2024 10:34:57 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] clk: meson: Fix an issue with inaccurate hifi_pll
 frequency
Date: Fri, 06 Sep 2024 18:34:39 +0800
Message-Id: <20240906-fix_clk-v2-0-7a3941eb2cdf@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/a2mYC/z3MQQrCMBCF4auUWRtJhpJYV95DisR00g62TUmkK
 CV3NxZ0+c88vg0SRaYE52qDSCsnDnMJPFTgBjv3JLgrDSixlo2shefXzY0PofXJG6ss3pWGsl4
 ildcuXdvSA6dniO8dXtX3+jP031iVkAIbY8jLziCZi53G0LM7ujBBm3P+ALL78/ugAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725618896; l=2030;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=7v54Zyw0i0C7dV0JkDzLhWAWLm9ZlK6RJGxHS8FL/Mo=;
 b=edTobeBEWT7l5dp1KG9XBG20u88x9MHA5yUkCW5VI+uHjOQNbuVboAoWqLOhYqX6RvsOilHm9
 HXorFqcrXw3B/6ASQW/BrWaJqJgVvTW+QHvSQGQrFADat7+1Bnw9rsd
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



