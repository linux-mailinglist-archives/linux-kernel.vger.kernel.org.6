Return-Path: <linux-kernel+bounces-342811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C1D989335
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CC81C22947
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6F13A3E4;
	Sun, 29 Sep 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMvI8bvP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695F47F53;
	Sun, 29 Sep 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727590228; cv=none; b=WLJlwFIp8+ie/4ohu9Rhs12r4j+vZ8+JpQO/uz8z6aIHlDQZLaWv+mMkGPDVkE8Tq7bF2Xm/Fx1p6+wScteEPE3MroBf8wOQV/f/KWt2kknuzTRsi6dq2PHPxfdj9TZ6RYuw1k1vp7GTa0xNGOG3bUQcWRjzjUTTrEctU/Yz4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727590228; c=relaxed/simple;
	bh=VuF+6B8clsCESzRY45mjWVDnp0roeP9EanMgzGgHiWE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nBYV9jFpp6W0YaraYDnu1KJDcHfoCzUuecfzGzdUFzjODwEwOZB+fBvd9AxuoYAENHH1UIZ4OcKsyo8A3AApB5PnJ21W9xKDg2rZ8hjPhUsfdf1kHqqJ8m7OcFxVFXMYEVgZHvOYqd9BXESbovbhr6T9PD7D4wa2v2uXoQQiB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMvI8bvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1419C4CEC5;
	Sun, 29 Sep 2024 06:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727590227;
	bh=VuF+6B8clsCESzRY45mjWVDnp0roeP9EanMgzGgHiWE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=PMvI8bvPOh99P0uhs1qw02qI/4fAiG+OaPeubI6weUSf7yES471ck+AnnR9LmruEZ
	 YCYeBHzXZ2pPvRu7YSY7svBrXGAUf5wBT7bdtfhfvAWuAdI52KN7zaEVAl2hrkz0AX
	 VhuxAKvcOK1j7935S1vzvVNXWIYDfL9um59N9pc6LIlseZWGLBHJ1jGXeaDrmgzumU
	 PFtqe1oFUzmFFYAo6J8kTq3so1uJqc7UjU1HxIq76Wa5MVP6mpRK/WsKH1N+GKmnNm
	 LPbshINP3VSGxN2nD3kh2shDro1j1VG5GL3T89dxojjimjeb8zyzhUWP3UpbHP0LDV
	 DBAbnsJ8FW2Jg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF78ECF6498;
	Sun, 29 Sep 2024 06:10:27 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH 0/2] clk: Fix issues related to CLK_IGNORE_UNUSED failures
 and amlogic glitch free mux
Date: Sun, 29 Sep 2024 14:10:04 +0800
Message-Id: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADzv+GYC/x2MQQqAIBAAvxJ7TtCtg/aVCAlbdSEsNCII/550H
 JiZFwplpgJT90KmmwsfqYHqO3BxTYEEb40BJY7SoBGeHxt2vly0PhMJNNJpbXBwg4JWnZma8h/
 npdYP3BY0HWEAAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727590225; l=2225;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=VuF+6B8clsCESzRY45mjWVDnp0roeP9EanMgzGgHiWE=;
 b=uv2V//H+abP/S3Lw1qAz+VmyJFzrQupRRNbZVAZLVVbSOXL4PGoneT4nrv9LXoR4p9o9RDGqB
 VeQpA48RrjADXJl+sHwiniuTizO/DMQ0PwSjqDVVZVEBJLoBCahwUM5
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
Chuan Liu (2):
      clk: Fix the CLK_IGNORE_UNUSED failure issue
      clk: meson: Fix glitch free mux related issues

 drivers/clk/clk.c                  | 67 ++++++++++++++++++++++++++++++++++++--
 drivers/clk/meson/a1-peripherals.c | 12 +++----
 drivers/clk/meson/axg.c            | 16 +++++----
 drivers/clk/meson/c3-peripherals.c |  6 ++--
 drivers/clk/meson/g12a.c           | 18 ++++++----
 drivers/clk/meson/gxbb.c           | 18 ++++++----
 drivers/clk/meson/s4-peripherals.c | 32 +++++++++---------
 7 files changed, 122 insertions(+), 47 deletions(-)
---
base-commit: e736da1956cf0880a02ec5023f3487eea7611b5f
change-id: 20240929-fix_glitch_free-290c88923c31

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



