Return-Path: <linux-kernel+bounces-565861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8728EA67031
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C4E188A626
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293E20296A;
	Tue, 18 Mar 2025 09:47:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B11922FD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291266; cv=none; b=TCdRGRkGO9xHgBZCAcKtFpnUdm49jjnhQujkBGKhjO72F94ftYTRFu/fLcs/+2bQzFs/nV5wmFIhvmXuOyaPtsZyRgBzWB9AlRzUMc965G4DfT4ssC2B8Z9b6G7r8G8idqQP1fJk2rCssX/71ixvr4QkwdnhtoxLheUG8U9Hf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291266; c=relaxed/simple;
	bh=Hx4mqugbNK33rWitoAdE6GZHAFrVfvtTEot5U5WyLOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=quD4cGjPFpPdUxYof0A7thqP1VaRP9QmnkR/LXWwsyBX6V7bSxC7yQ+tzE/pH9VmH/7T1cyG3UZbHzYx/ZfkZwy9Bq6xZdVsRvME2psfQXNDIBZIaA/0VTgmZp69hvvSFbzqimLmuy3nEn1yacB5f6mQAKZM3qUypej3nQ9ma9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTXc-0008Mr-4r; Tue, 18 Mar 2025 10:47:20 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTXa-000P5z-3D;
	Tue, 18 Mar 2025 10:47:19 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTXb-00CoOT-0z;
	Tue, 18 Mar 2025 10:47:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v7 7/7] Documentation: Add sysfs documentation for PSCRR reboot reason tracking
Date: Tue, 18 Mar 2025 10:47:16 +0100
Message-Id: <20250318094716.3053546-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318094716.3053546-1-o.rempel@pengutronix.de>
References: <20250318094716.3053546-1-o.rempel@pengutronix.de>
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

Add documentation for the Power State Change Reason Recorder (PSCRR)
sysfs interface, which allows tracking of system shutdown and reboot
reasons. The documentation provides details on available sysfs entries
under `/sys/kernel/pscrr/`, explaining their functionality, example usage,
and how they interact with different backend storage options (e.g., NVMEM).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v7:
- document expected values
---
 .../ABI/testing/sysfs-kernel-reboot-pscrr     | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot-pscrr

diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
new file mode 100644
index 000000000000..9aa3df8f2fc7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
@@ -0,0 +1,79 @@
+What:		/sys/kernel/pscrr/reason
+Date:		April 2025
+KernelVersion:  6.15
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		This file provides access to the last recorded power state
+		change reason. The storage backend is configurable and, if
+		supported, the reason may be stored persistently in an
+		NVMEM cell or another backend.
+
+		Reading this file returns an integer representing the last
+		recorded shutdown or reboot cause.
+
+		Writing an integer value to this file sets the reason to be
+		stored and recorded for system analysis.
+
+		Example usage (values are for illustration and may not reflect
+		actual reasons used in a given system):
+		  Read:
+			$ cat /sys/kernel/pscrr/reason
+			3   # (Example: Power loss event, may differ per system)
+
+		  Write:
+			$ echo 5 > /sys/kernel/pscrr/reason
+			# Sets the reason to 5 (Example: User-triggered reboot,
+			# this may not be a real value in your system)
+
+		Values are defined in:
+		  - `include/linux/reboot.h` (enum psc_reason)
+
+		Supported Values:
+		Defined in `include/linux/reboot.h` (enum psc_reason):
+
+		+-------+---------------------------+--------------------------+
+		| Value | Symbol                    | Description              |
+		+-------+---------------------------+--------------------------+
+		| 0     | PSCR_UNKNOWN              | Unknown or unspecified   |
+		|       |                           | power state change reason|
+		+-------+---------------------------+--------------------------+
+		| 1     | PSCR_UNDER_VOLTAGE        | Supply voltage drop below|
+		|       |                           | safe threshold.          |
+		+-------+---------------------------+--------------------------+
+		| 2     | PSCR_OVER_CURRENT         | Excessive current draw,  |
+		|       |                           | potential short circuit. |
+		+-------+---------------------------+--------------------------+
+		| 3     | PSCR_REGULATOR_FAILURE    | Failure in voltage       |
+		|       |                           | regulator, preventing    |
+		|       |                           | stable power delivery.   |
+		+-------+---------------------------+--------------------------+
+		| 4     | PSCR_OVER_TEMPERATURE     | Unsafe system temperature|
+		|       |                           | detected by sensors.     |
+		+-------+---------------------------+--------------------------+
+		| 5     | PSCR_EC_PANIC             | Shutdown/reboot triggered|
+		|       |                           | by Embedded Controller   |
+		|       |                           | (EC) panic.              |
+		+-------+---------------------------+--------------------------+
+
+		(Note: The actual reason codes used on a specific system depend
+		on hardware capabilities and configuration.)
+
+What:		/sys/kernel/pscrr/reason_boot
+Date:		April 2025
+KernelVersion:  6.15
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		This file provides the last recorded power state change reason
+		from before the current system boot. If a supported backend
+		(e.g., NVMEM) is configured, this value is retained across
+		reboots.
+
+		Example usage (values are for illustration and may not reflect
+		actual reasons used in a given system):
+		  Read:
+			$ cat /sys/kernel/pscrr/reason_boot
+			2   # (Example: Over-temperature shutdown, may differ per system)
+
+		Supported Values:
+		Same as `/sys/kernel/pscrr/reason` (see above).
+
-- 
2.39.5


