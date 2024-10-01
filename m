Return-Path: <linux-kernel+bounces-345774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B169398BAF1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E305D1C223D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3A1BF801;
	Tue,  1 Oct 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pN97RCP5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1119DF9A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781844; cv=none; b=OoCYodcGB7tn7QLCMh5BZpAffQVCFwxhXqIzHIeLC7LfpfLqEwi76Rf10m6W9YBHLXACZVH0ZmVmL9F8jJ1lE0b+TCbwW4KBliV8b64OZhmHm5auODNsfMk1JSTslecviae3XqvL6sH3ZdE259ZCTirAlSRgnImmxZjJAMEwYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781844; c=relaxed/simple;
	bh=sXXgqHQa9Widx7yDUBLgFY+o29P8M0HLTr5bNdEzFvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gCqAZk6+W4hDP2hEsBKloG6wWss7l/ISrVF5QpQpR+mfn/SSsXDwg9aF1oHD2pcEt5pA9fs49daQHENCe2dUzvMLYWbavwGrps3JxlovKS+uEq0mHzpDka3aNP7l+IAqRJIs+KFOwi3xgtZf5xSOvZ6y07xIgqjCnyZXJf2t/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pN97RCP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DE8C4CEC6;
	Tue,  1 Oct 2024 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781843;
	bh=sXXgqHQa9Widx7yDUBLgFY+o29P8M0HLTr5bNdEzFvc=;
	h=From:Date:Subject:To:Cc:From;
	b=pN97RCP5JS9FoMBxFBQGIZ92Bcfdx5/e7SwmifEHbww+RCmxzaIFKMZzPppK8S1Om
	 AFCof4xhd5XO9NX14Q8tDB+Xz/UVBy4Ar9D+6IQpT0AZ2SlmUJ1BICku3jx22He2eB
	 QgtLI2a6AOVwfW5lxiXvgIX5L0Whs4v9n6SAcMSAWDUhP4NaGSjus6LhmoY1yyEDmm
	 0Q1fpnlN+a+IjySKK46JgClYVQ22Ou+/kcI4/jV7lhIBy4heSwrh1m/kF2Ec1s5z6q
	 4APs1sBMOO1gjGCu9FztHx92SK/8/eYDuCObbgNhSvGhkHEZ3a6UgUqvlCxUPAv9CD
	 EdtPe2/oaM4/Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 12:23:56 +0100
Subject: [PATCH v3] clocksource: sp804: Make user selectable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-vexpress-sp804-v3-1-0a2d3f7883e4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMvb+2YC/4XNzQ6CMAzA8VchO1szuvHlyfcwHsYosKhAOrNgC
 O/u4KQH4/Hfpr8uwhM78uKULIIpOO/GIYY6JML2ZugIXBNboEQtM0Qw/Mg1BJonJu/BT6XUoPK
 syStV1rKwIp7GXevmnb1cY/fOP0d+7V9Cuk3/gCGFFKTS2jYaqS6K8414oPtx5E5sYsBPpfqhY
 FRsptGU0rRKmS9lXdc3Fs5twP8AAAA=
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ross Burton <ross.burton@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sXXgqHQa9Widx7yDUBLgFY+o29P8M0HLTr5bNdEzFvc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm+9vQp7qXoYs0XolQAHVdukM9GIOTuZfciVURc5Or
 Zp5WIcaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvvb0AAKCRAk1otyXVSH0Ai0B/
 4uU+yxam9fxUSl7BunsND0BflzLqvni6JhwPUtkevxfMRx55xLRWnTwgoBASr66puv52JgZEXVF8UK
 q5q2UHsMN8HwrnsmkPgu+dYCmeNmITAQEu2w4OEUnwjYhegiWBtk8AuWVBkaTHfj5rMqGzBvnTu5Gl
 20tc9vctRmwI3W01oDh7nOxCcxAtJ8PEHlPkiLUP1WEzRuchRcMz/kdzqHAMkHuS5aj2U1pVpq9AIy
 NmhraSeqGk7tjIVA92vLUSQ4hO9B/FrMZU2X19iBqEcrDcOP2zKWdoK1gACw/x35T/ZvxyvRkYhqtI
 WIGosqXEJFvsj61u2Ly98ZH1CnbwPz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The sp804 is currently only user selectable if COMPILE_TEST, this was
done by commit dfc82faad725 ("clocksource/drivers/sp804: Add
COMPILE_TEST to CONFIG_ARM_TIMER_SP804") in order to avoid it being
spuriously offered on platforms that won't have the hardware since it's
generally only seen on Arm based platforms.  This config is overly
restrictive, while platforms that rely on the SP804 do select it in
their Kconfig there are others such as the Arm fast models which have a
SP804 available but currently unused by Linux.  Relax the dependency to
allow it to be user selectable on arm and arm64 to avoid surprises and
in case someone comes up with a use for extra timer hardware.

Fixes: dfc82faad725 ("clocksource/drivers/sp804: Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804")
Reported-by: Ross Burton <ross.burton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Rebase onto v6.12-rc1.
- Link to v2: https://lore.kernel.org/r/20240529-arm64-vexpress-sp804-v2-1-c542a80af33a@kernel.org

Changes in v2:
- Rebase onto v6.10-rc1.
- Link to v1: https://lore.kernel.org/r/20240522-arm64-vexpress-sp804-v1-1-0344cd42eb77@kernel.org
---
 drivers/clocksource/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 95dd4660b5b6..d546903dba4f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -400,7 +400,8 @@ config ARM_GT_INITIAL_PRESCALER_VAL
 	  This affects CPU_FREQ max delta from the initial frequency.
 
 config ARM_TIMER_SP804
-	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
+	bool "Support for Dual Timer SP804 module"
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && HAVE_CLK
 	select CLKSRC_MMIO
 	select TIMER_OF if OF

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240522-arm64-vexpress-sp804-365d6938b07c

Best regards,
-- 
Mark Brown <broonie@kernel.org>


