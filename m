Return-Path: <linux-kernel+bounces-206944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25750901025
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34B8B229AB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41383176FD8;
	Sat,  8 Jun 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gthcl2iv"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E42176ABC;
	Sat,  8 Jun 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717834372; cv=none; b=WWZVBmwih0CM9Sc/oYR8/zfHrWWGL+hNQWMWf6TKCnOZvV+qQKC3V/Cc8MsepDOBmVkTftE6GsE0VOIzKhPPc28trnj0GcrxOzbCdmz4o9uOf5aPTcJjSdR8MyeIIwMjAPmWLDdVGLMG+C3FHjxK1sAua8omNXruN/W04eQnrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717834372; c=relaxed/simple;
	bh=uOqrwTrndkshyrpD+eXmWOKCmadDalmhjImwkQ3pihs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXFjFPU4FMUBGrtBTnyLJc06Jn2lVJ74f/mXrE3TPdGsYFAVKisikCuTc8jd6/yyNgVluiEWR/b6+zBxa6/66LTIY8RA74aeBmq7mfOXq6nUlfJ930QKtFiZLGTNlc3gIYuw9rvhM6jCHlRUs0l57FLJK2lVfReKLn7RDUroz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gthcl2iv; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717834365;
	bh=uOqrwTrndkshyrpD+eXmWOKCmadDalmhjImwkQ3pihs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gthcl2ivvcxPygDOG+vr7Mvnq8Lzvgyf+wRW7rujHo4L4uJn71ZiGX2bt9nGwgNhR
	 2W2qBRQLMaL6E+a9UXuIMcc71Bz16V0+Y86/oAiJt2jlPgZGd85H7gJC/qKNMPk8Xi
	 /uQj+i4wOFQsysxPd91Sx/eVc3BwiY5YhpxZpLfs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 08 Jun 2024 10:12:46 +0200
Subject: [PATCH 4/5] hwmon: (cros_ec) Split temperature channel params
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240608-cros_ec-hwmon-pwm-v1-4-d29dfc26fbc3@weissschuh.net>
References: <20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net>
In-Reply-To: <20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Stephen Horvath <s.horvath@outlook.com.au>, chrome-platform@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717834365; l=3087;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uOqrwTrndkshyrpD+eXmWOKCmadDalmhjImwkQ3pihs=;
 b=P+7vcuq9iT0rpTV+K/76Tt9+v2o4ROJUSLOOKUTiDuKyNcOJM4Ygo/GboDTHiDjbykWZzSM/H
 4gdJPDR9fZtCZ16xtIg0H2ZkVSLbjMkQk6E7mMRYtXaVxW8wa+LGqgd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

An upcoming change will add more channel parameters.
This leads to a lot of churn and very long lines.

Use a macro to encapsulate all of the shared values.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hwmon/cros_ec_hwmon.c | 50 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 48b7073a4991..5cddf78cfe0e 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -277,31 +277,33 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
+
+#define CROS_EC_HWMON_TEMP_PARAMS (HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL)
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL),
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS,
+			   CROS_EC_HWMON_TEMP_PARAMS),
 	NULL
 };
 

-- 
2.45.2


