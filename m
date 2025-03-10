Return-Path: <linux-kernel+bounces-553973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BC4A59154
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE98516C528
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E5E227574;
	Mon, 10 Mar 2025 10:37:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0D224240
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603067; cv=none; b=kb1Krm3B7wKEdTAsMozWWgS5eRTa0xekkrsALvjDn2uj5JJnnf+6hSPhFbHLTuYKPt4lBleoA+Y9rsX8Vu+CSf3xygzr0ZQcDRJJMfQE+d103TzH7Xoxl9os7ABQgEg4NFsGsYK5EDUTUpmq0YL6NhSJl3PPLizBweNcP/9S4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603067; c=relaxed/simple;
	bh=WZ44EqYMRcMuhnvfDOn94ImnQ/OhaCbBhGQ53Ky/+Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lSa7H+HGEZGfTD8awrfkX8dfwf86Ns4ST1v9slldsK9NFD8gIS2eAkWjqLMKpyLkB3vlE2+iRsY8BoQrkRQTMDGSR8mqoQeb/3/VFG+EfbOy2akc9MAzdIN9F+amEaohhAcdLBLGNqMpa5e6v6sOUnFRFO0+bQ762GoyEVk8oUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1traVq-0004EA-5V; Mon, 10 Mar 2025 11:37:34 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1traVp-004yyx-0r;
	Mon, 10 Mar 2025 11:37:33 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1traVp-001mCN-0d;
	Mon, 10 Mar 2025 11:37:33 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v5 0/7] Introduction of PSCR Framework and Related Components
Date: Mon, 10 Mar 2025 11:37:25 +0100
Message-Id: <20250310103732.423542-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

changes v5:
- fix compile with NVMEM=n and potential issues with NVMEM=m

changes v4:
- fix compile with CONFIG_PSCRR=n

changes v3
- rework to remove devicetree dependencies
- extend NVMEM to search devices and cells by names.

changes v2:
- rename the framework from PSCR to PSCRR (last R is for Recorder)
- extend power on reason header and use it to show detected reason on
  system start and in sysfs.
- remove "unknow" reason
- rebase on top of v6.8-rc1
- yaml fixes
- zero reason state on boot

Hello all,

This patch series introduces the Power State Change Reasons Recording
(PSCRR) framework and its related components into the kernel. The PSCR
framework is designed for systems where traditional methods of storing
power state change reasons, like PMICs or watchdogs, are inadequate. It
provides a structured way to store reasons for system shutdowns and
reboots, such as under-voltage or software-triggered events, in
non-volatile hardware storage.

These changes are critical for systems requiring detailed postmortem
analysis and where immediate power-down scenarios limit traditional
storage options. The framework also assists bootloaders and early-stage
system components in making informed recovery decisions.

Oleksij Rempel (7):
  power: Extend power_on_reason.h for upcoming PSCRR framework
  power: reset: Introduce PSCR Recording Framework for Non-Volatile
    Storage
  nvmem: provide consumer access to cell size metrics
  nvmem: add support for device and sysfs-based cell lookups
  power: reset: add PSCR NVMEM Driver for Recording Power State Change
    Reasons
  regulator: set Power State Change Reason before
    hw_protection_shutdown()
  thermal: core: Record PSCR before hw_protection_shutdown()

 drivers/nvmem/core.c                  | 116 ++++++++
 drivers/power/reset/Kconfig           |  30 ++
 drivers/power/reset/Makefile          |   2 +
 drivers/power/reset/pscrr-nvmem.c     | 254 ++++++++++++++++
 drivers/power/reset/pscrr.c           | 408 ++++++++++++++++++++++++++
 drivers/regulator/core.c              |   6 +
 drivers/thermal/thermal_core.c        |   3 +
 include/linux/nvmem-consumer.h        |  21 ++
 include/linux/power/power_on_reason.h |   3 +
 include/linux/pscrr.h                 |  89 ++++++
 10 files changed, 932 insertions(+)
 create mode 100644 drivers/power/reset/pscrr-nvmem.c
 create mode 100644 drivers/power/reset/pscrr.c
 create mode 100644 include/linux/pscrr.h

--
2.39.5


