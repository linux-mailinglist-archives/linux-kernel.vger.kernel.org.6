Return-Path: <linux-kernel+bounces-370223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8519A298F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD69280DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A931DF269;
	Thu, 17 Oct 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9WmVyVG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD71DF723
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183847; cv=none; b=qLjraeX9xQJ6mMUqNgD8389tEgF8F5zXSlN6K2TkX/ABul+3zFXkGXNMGjAZ/fKsNOhBRx8IV7PhMKlvum0g4DdsyUNaJ965Yj0m9PdcYHUpSnRrhmUBL15UwS9iiwArqsR3y/95EDJFJ4dDn1TV+ljjfrz5dPT2pNJXnZbyrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183847; c=relaxed/simple;
	bh=/Yd7Di+LPG3k5F26oGx5g5AkCxjly5CQwnOdlgPosWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjqnXAh4Doqktf7y+syZQgLRATX15Vw8KLQqQNy6Kx9FxmomJvFqk7LqWR4ozdhVQTYegXAfxmfw5o9ItA6Ss3HENaaHWN4VfTKTbRBfDp2fd1XQVeP3m3/kbfYTfrrhgNwh30NDazSh7Kupaiav3K1zfT2P9jncE+xybBeBIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9WmVyVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE003C4CEC3;
	Thu, 17 Oct 2024 16:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183847;
	bh=/Yd7Di+LPG3k5F26oGx5g5AkCxjly5CQwnOdlgPosWo=;
	h=From:To:Cc:Subject:Date:From;
	b=t9WmVyVGQj7kXMVv+eeq+ix9NxHi2SDl+y8QPIy2Z6UHw54iAXJQvUMgK6zivUFzq
	 /WMj9sBvq/kXYNl1+fHBYZXPIS2G0/Q2Avk23oSHXjOtG2io0406AGVGukqtNEYVWf
	 mIbsLldW9WFmEvR4dc+tL+ZURWkDS6S88AC2XmpINliIzlgdngsgLqJ6OVQHeluF8f
	 3Hk785FPYLV41Qf6iHMeBtqqEswuxVNfRYEi60WNHk0VKlUiTWJA6nSQIDGSskhRwk
	 xaAfkKb9NcNConDG/QSOX/3Fus7Fez29+uT+BPH/HDKqvfNKYW3xj14tyQxa0/Py2/
	 vv49dZHgrqcCQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 00/10] clockevents: Rearrange cpuhotplug operations
Date: Thu, 17 Oct 2024 18:50:31 +0200
Message-ID: <20241017165041.6954-1-frederic@kernel.org>
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

Frederic Weisbecker (10):
  clockevents: Improve clockevents_notify_released() comment
  clockevents: Shutdown and unregister current clockevents at
    CPUHP_AP_TICK_DYING
  tick: Remove now unneeded low-res tick stop on CPUHP_AP_TICK_DYING
  arm/twd: Remove clockevents shutdown call on offlining
  clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call
    on offlining
  clocksource/driver/arm_global_timer: Remove clockevents shutdown call
    on offlining
  drivers/clocksource/exynos_mct: Remove clockevents shutdown call on
    offlining
  clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on
    offlining
  clocksource/drivers/qcom: Remove clockevents shutdown call on
    offlining
  drivers/clocksource/timer-tegra: Remove clockevents shutdown call on
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
 kernel/time/tick-sched.c                  | 25 +++----------
 11 files changed, 30 insertions(+), 52 deletions(-)

-- 
2.46.0


