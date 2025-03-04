Return-Path: <linux-kernel+bounces-544233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E091A4DF21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704D97A34BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2762045B8;
	Tue,  4 Mar 2025 13:25:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F2204090
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094701; cv=none; b=sfpIAW3VOiVISoi4igYurt2fJTCuL124y87/3/DM5S7mt5jK9emDA642ivJMV3OjpveO6TCIhaNV5n2FMWHVTwNwb+7fKwOW3HeB623Dzy5wIlV6hbO3davFLaQ5HK/5yOjm/IOsFxpTGExaJoMdUvz/U3xTqB4FZ/DMQ9dEoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094701; c=relaxed/simple;
	bh=+6O+mA2fzpX7x0jBw55O1jhy+s61L25CXgYyz0ThUBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABpYu9PVBG2BdND8CRTzx97aByVw3I8YLdzKoM4i7VDyoGK/2FzxHb7GPz4LrhP9Qj0q+ORCyvbOLc68ZcHqt4SAYVRUJ47ptU+wgtAoBUwnzIrcr2IJNbRnP8hzaUtivF243WT3Gxkp1yRJ9//wPbQ/BjOZFIpVoyN5CovyXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tpSGB-000727-JP; Tue, 04 Mar 2025 14:24:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpSGA-003yyz-2a;
	Tue, 04 Mar 2025 14:24:34 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpSGA-000sjZ-2M;
	Tue, 04 Mar 2025 14:24:34 +0100
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
Subject: [PATCH v3 1/7] power: Extend power_on_reason.h for upcoming PSCRR framework
Date: Tue,  4 Mar 2025 14:24:27 +0100
Message-Id: <20250304132433.210355-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304132433.210355-1-o.rempel@pengutronix.de>
References: <20250304132433.210355-1-o.rempel@pengutronix.de>
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

Prepare for the introduction of the Power State Change Reason Recorder
(PSCRR)  framework by expanding the power_on_reason.h header. This
extension includes new power-on reasons:
- POWER_ON_REASON_OVER_CURRENT for over-current conditions.
- POWER_ON_REASON_REGULATOR_FAILURE for regulator failures.
- POWER_ON_REASON_OVERTEMPERATURE for over temperature situations.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/power/power_on_reason.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index 95a1ec0c403c..f2446cece277 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -15,5 +15,8 @@
 #define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
 #define POWER_ON_REASON_BROWN_OUT "brown-out reset"
 #define POWER_ON_REASON_UNKNOWN "unknown reason"
+#define POWER_ON_REASON_OVER_CURRENT "over current"
+#define POWER_ON_REASON_REGULATOR_FAILURE "regulator failure"
+#define POWER_ON_REASON_OVERTEMPERATURE "overtemperature"
 
 #endif /* POWER_ON_REASON_H */
-- 
2.39.5


