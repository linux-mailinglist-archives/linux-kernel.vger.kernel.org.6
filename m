Return-Path: <linux-kernel+bounces-386962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38729B4A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E15B2318F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387B205152;
	Tue, 29 Oct 2024 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/So58y5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013F621
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206498; cv=none; b=AfNRY/9/+KkbVnuCd3d69ioA5tPmA4XJbnxrwiZr5wihCqFVb8i37PPmz7iie342gMUS/m/NPej64xio7HmUhOwIFrOyGXTypv65d07SLzHSh6EL0CjoxBN61XsQWwbqempabkgjMqbylZ+WzKcy2WJoPluDv8VvUfiUX8xl4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206498; c=relaxed/simple;
	bh=Wex6gFIV/J8rLBJiJxZ4ZdioYaHe0p44J6ueJWb6qrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQOmjs6zqoj8OLNEvMn5U9Ofb5IA+ax7/3xjm0UEq0ZWmRz/+VDE7y43CupopGN4WcixSnrDcnol9hAQ1FbtGvsofHQ1YxTisQ/RI8AYmznUg2eobZV7X2ekahapnihvOck0Lv7mXLsr9jqRCR99kN6F7uxX9UrLVoN5/l5zt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/So58y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF069C4CEE5;
	Tue, 29 Oct 2024 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730206498;
	bh=Wex6gFIV/J8rLBJiJxZ4ZdioYaHe0p44J6ueJWb6qrc=;
	h=From:To:Cc:Subject:Date:From;
	b=N/So58y5EM8xcrpTbBQ6ikchzhOzf2w8gCBAwmRGDYvAgJ+/GFt2KWza3BdAIqvCA
	 xqJDUCWrlem+JCZ2Bp+j5/KjL8BMFamn6056+1EbS4jnn2KXI4THVCwoO4ZPQoOjGQ
	 RQ2sy8zrZxwLYgZ+pMbleeXqpFkOcSGOOyJ2clYrqVCJl80Sc7l4dop+LFXB8Mp/KL
	 WH1fUAlLhGm4Vty9KQ7FWLetsfVZbDRlyDw8lmO/+6P8/g8bQEmYjDRmxaW5cL49e4
	 6IwUf2XokSpkKSkugE01Hf/kTNUD4gjBB5M4Vp/gHJYCmLV/cRhD/lWRVrhHzkV9b2
	 nxUrR/OHOIKZw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 00/10] clockevents: Rearrange cpuhotplug operations v2
Date: Tue, 29 Oct 2024 13:54:41 +0100
Message-ID: <20241029125451.54574-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some recent RCU issues triggered with offline ticks uncovered
hotplug behaviour differences between oneshot and periodic ticks.
The former is disabled on the dying CPU but not the latter. Also
the clockevents hotplug code is quite chaotic. This is a proposal to
fix the situation.

Changes since v1:

* Fix build error
* Fix commits prefixes

Thanks.

Frederic Weisbecker (10):
  clockevents: Improve clockevents_notify_released() comment
  clockevents: Shutdown and unregister current clockevents at
    CPUHP_AP_TICK_DYING
  tick: Remove now unneeded low-res tick stop on CPUHP_AP_TICK_DYING
  ARM: smp_twd: Remove clockevents shutdown call on offlining
  clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call
    on offlining
  clocksource/drivers/arm_global_timer: Remove clockevents shutdown call
    on offlining
  clocksource/drivers/exynos_mct: Remove clockevents shutdown call on
    offlining
  clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on
    offlining
  clocksource/drivers/qcom: Remove clockevents shutdown call on
    offlining
  clocksource/drivers/timer-tegra: Remove clockevents shutdown call on
    offlining

 arch/arm/kernel/smp_twd.c                 |  1 -
 drivers/clocksource/arm_arch_timer.c      |  2 -
 drivers/clocksource/arm_global_timer.c    |  1 -
 drivers/clocksource/exynos_mct.c          |  1 -
 drivers/clocksource/timer-armada-370-xp.c |  1 -
 drivers/clocksource/timer-qcom.c          |  1 -
 drivers/clocksource/timer-tegra.c         |  1 -
 include/linux/tick.h                      |  2 -
 kernel/cpu.c                              |  2 -
 kernel/time/clockevents.c                 | 45 ++++++++++++-----------
 kernel/time/tick-internal.h               |  3 +-
 kernel/time/tick-sched.c                  | 25 +++----------
 12 files changed, 31 insertions(+), 54 deletions(-)

-- 
2.46.0


