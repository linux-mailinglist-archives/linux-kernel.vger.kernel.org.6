Return-Path: <linux-kernel+bounces-403549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BED9C3713
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C5D1C20AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6ED14A0A3;
	Mon, 11 Nov 2024 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAEK7ZDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256832C18C;
	Mon, 11 Nov 2024 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731296230; cv=none; b=eW0XiafgDY4RJi0M2/9jmkmhsR1RXPUGc7cXjhA9sBFiebDLnlwH14QjVhEQtNDmOC5lF2Y8YiRPaVHPsgRMAVpSp4PR2T/rujCRkKZXcc4PQfEWyS8obQmUd1HMk3U+5YbCeh7+KGhVlt1wvAWR/ZuZY5PNP2Z6d9Hm70RflK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731296230; c=relaxed/simple;
	bh=g6bebViV2vgswvScFFgT4ihiXpYioBTgIRcyCJ4wOg0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EtdxJRJHIIVBJ63/e5ZC3TAGzF4hoHysXT+hF93nsHW80Hb0EbR8f+PlVc247kWJjAK49pYbzG2e10E8KAkgKiu+TiqMO6ucpy2K3xVYu88iwOIwPqGNoR4jmniyvjqSTRGClxX8ZjIxmYC9c0/up3KltagtaoVeOo7722sQ21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAEK7ZDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AACF0C4CECD;
	Mon, 11 Nov 2024 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731296229;
	bh=g6bebViV2vgswvScFFgT4ihiXpYioBTgIRcyCJ4wOg0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lAEK7ZDGnUWWeuGgGHoSBZSIch//gY4F4iZv+vqgfDMvl4H2cXdo1ktf7PTJalbhK
	 OqPDqc7hZoV+ypChfdcdFWFRgOPUIW2OpBGKmVf4wL3KfMT3qfqkNprFjUWHwoIxoi
	 8w/5kxlytyCl8AA9bqTbC2JO45bqunfJLZ+sUBno9FnWb1bSNpLoZtxRt8K0RJ1/Du
	 +doveSPWZ5KWISLC+6CjI6csMkXFnJIOvQoV3YM4yZO6ONSsB0Xv5t6oYDrQ/GvldD
	 bbSPZsyRjIElY3luIiIy0FHF0x/5R6H5fTHmpj9NbXxSw6TcPnFCIn5FGCDtlu2Lbi
	 QjecLV+Ifsb0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F0D12D49;
	Mon, 11 Nov 2024 03:37:09 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] clk: Fix issues related to CLK_IGNORE_UNUSED
 failures and amlogic glitch free mux
Date: Mon, 11 Nov 2024 11:37:00 +0800
Message-Id: <20241111-fix_glitch_free-v2-0-0099fd9ad3e5@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANx7MWcC/3WNwQqDMBBEf0X23JS4ltb01P8oInbdJAtqJBFpE
 f+9qfce3zDzZoPEUTjBvdgg8ipJwpQBTwWQ7ybHSvrMgBov2qBRVt6tG2Qh39rIrNBoqmuDFVU
 l5NUcOVcO47PJ7CUtIX6Og7X8pf9da6m0QrSGquvrxr19dOMQnNCZwgjNvu9f+2eoY7AAAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731296227; l=2635;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=g6bebViV2vgswvScFFgT4ihiXpYioBTgIRcyCJ4wOg0=;
 b=5sClNyptQe3+bagbINnhGgZawIIkUqgm0F9mH6dWCZh1WqRUKdk8EPEuNykuNhlrS8kgQYefe
 +FPz2kz/kQND05wRTL8OF9cTnv6S6R+ApC+whsKI9TACfH4LDcdITbt
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

If CLK_OPS_PARENT_ENABLE is configured for clock,
clk_core_disable_unprepare() is called in clk_disable_unused_subtree().
Even clocks that are configured with CLK_IGNORE_UNUSED are disabled,
resulting in the failure of CLK_IGNORE_UNUSED.

To ensure that amlogic glitch free mux can switch clock channels
properly, add flag CLK_OPS_PARENT_ENABLE to glitch free mux. The issue
that CLK_OPS_PARENT_ENABLE in CCF causes CLK_IGNORE_UNUSED to fail is
also exposed.

glitch free mux channel switchover failure issue(Test vpu_clk on S4):
step 1:
$ cat /sys/kernel/debug/clk/vpu/clk_parent 
vpu_0
$ cat /sys/kernel/debug/clk/vpu_0/clk_rate 
399999994
$ cat /sys/kernel/debug/clk/vpu_1/clk_rate 
666666656
$ echo 1 > /sys/kernel/debug/clk/vpu/clk_prepare_enable 
$ cat /sys/kernel/debug/meson-clk-msr/clks/cts_vpu_clk
399987500       +/-12500Hz

step 2:
$ echo 0 > /sys/kernel/debug/clk/vpu/clk_prepare_enable 
$ echo 1 > /sys/kernel/debug/clk/vpu/clk_parent 
$ cat /sys/kernel/debug/clk/vpu/clk_parent 
vpu_1
$ cat /sys/kernel/debug/clk/vpu/clk_rate 
666666656
$ echo 1 > /sys/kernel/debug/clk/vpu/clk_prepare_enable 
$ cat /sys/kernel/debug/meson-clk-msr/clks/cts_vpu_clk
0       +/-3125Hz

In step2, vpu_0 is disabled, and the vpu is not switched to vpu_1. At
this time, the vpu is still connected to vpu_0 and vpu_0 is disabled at
this time, resulting in the clk-measure not measuring the clock.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Changes in v2:
- The failure of glitch-free mux switching and the suppression of glitch
are split into two patch.
- The glitch-free mux adds support for the meson-8 family.
- Link to v1: https://lore.kernel.org/r/20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com

---
Chuan Liu (3):
      clk: Fix the CLK_IGNORE_UNUSED failure issue
      clk: meson: Fix failure of glitch-free mux switching
      clk: meson: Fix glitch occurs when setting up glitch-free mux

 drivers/clk/clk.c                  | 67 ++++++++++++++++++++++++++++++++++++--
 drivers/clk/meson/a1-peripherals.c | 12 +++----
 drivers/clk/meson/axg.c            | 16 +++++----
 drivers/clk/meson/c3-peripherals.c |  6 ++--
 drivers/clk/meson/g12a.c           | 18 ++++++----
 drivers/clk/meson/gxbb.c           | 18 ++++++----
 drivers/clk/meson/meson8b.c        | 21 ++++++++++--
 drivers/clk/meson/s4-peripherals.c | 32 +++++++++---------
 8 files changed, 140 insertions(+), 50 deletions(-)
---
base-commit: 664988eb47dd2d6ae1d9e4188ec91832562f8f26
change-id: 20240929-fix_glitch_free-290c88923c31

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



