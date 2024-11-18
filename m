Return-Path: <linux-kernel+bounces-413557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3023F9D1AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A57B21110
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E391E7655;
	Mon, 18 Nov 2024 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="mhiL004E"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A41925A2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967914; cv=none; b=OWOnkuiYEJbgGN5oczm3CZqjzxTERQpaufLPLbo+OKMdYUKFcruhZEAmtNX/8dpvs9Hdafan+7+eE3ysipCV/tF23FTi58UsWk//+u+wSsNJdCylxCfoQUOFMDiBdRB+9eyZLflvF1edfy8BopHVRcc1mxcc8GSiZ0qbcgW9WQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967914; c=relaxed/simple;
	bh=ViWUTm5YLllJxtuiwR7b6gWuZ4LAmdj22suzOl11QZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l9pFpOJ0cIR/q0ugzugGnN2PqXdJHI6bTBOIu588T/GO0VCAXy18h09pO8uEdhwID1Okd+IYSDoAuyHNRQCTFwy/XWGicCGFnTM1pNtugUiEtxRV0qFzIisnt14pNzV2DIJXeg0QcTUlXYVIPWMcQo4yVZZtLN7dT5yeIGufuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=mhiL004E; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id F0D291E0008;
	Mon, 18 Nov 2024 15:42:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru F0D291E0008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1731933772; bh=j5rebjL+mlIZO9+tBTCrAr7sdKNYnS0zH0ITX1r28zg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=mhiL004EOfb/i23Uf6HPyZDhiOCRKbSfR6joCbYcyhowapXjRPx28SuF3zMUnDbzv
	 slWm0rkEpB4ioYV4QWDHJO743PGz/MOvO6Dv31alMkuMrb6yz4Z8MtwDUfS0XjEbsI
	 ymiKTZY5zXGKHTAaF2a13i/Y7iqW21nWllh5H6sfWCHif5iB8uVMl9pdxHg1LZ3jvk
	 f6L/QO1ic3ml+VZzJpkAt6YkyYPR2gP3yqq+Ui1J+GmNHBteETeuWMdftOdGbkml/E
	 INVFGEjMj9tb22js5+ETDZOecqeoCtJWqALqaVAzuznMzWYO1TvAt5PirZtAHtx8dv
	 EDSBeGfsjH6pw==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 18 Nov 2024 15:42:52 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.246.216) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Mon, 18 Nov
 2024 15:42:49 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Kenneth Feng <kenneth.feng@amd.com>
CC: Murad Masimov <m.masimov@maxima.ru>, Alex Deucher
	<alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ma Jun
	<Jun.Ma2@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Yang Wang
	<kevinyang.wang@amd.com>, Asad Kamal <asad.kamal@amd.com>, Hawking Zhang
	<Hawking.Zhang@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tim Huang <Tim.Huang@amd.com>, Tao Zhou <tao.zhou1@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
	Evan Quan <quanliangl@hotmail.com>, Kevin Wang <kevin1.wang@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/amd/pm: prevent invalid fan speed value in smu13 driver
Date: Mon, 18 Nov 2024 15:42:17 +0300
Message-ID: <20241118124220.274-1-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189241 [Nov 18 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg02.maxima.ru:7.1.1;81.200.124.62:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/18 10:31:00 #26875800
X-KSMG-AntiVirus-Status: Clean, skipped

If user-provided fan speed is higher than max speed, ->set_fan_speed_rpm() won't
return error code, which can lead not only to problems with the hardware, but
also to a zero division in smu_v13_0_set_fan_speed_rpm, since (8 * speed), which
is used as a divisor, can evaluate to zero because of an integer overflow.

Define ->get_fan_parameters() callbacks for smu_v13_0_0 and smu_v13_0_7 in order
to have smu->fan_max_rpm variable initialized. Modify ->set_fan_speed_rpm()
callback to fail if speed is higher than smu->fan_max_rpm.

Fixes: c05d1c401572 ("drm/amd/swsmu: add aldebaran smu13 ip support (v3)")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 11 +++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e17466cc1952..6f3277639fe9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1228,7 +1228,7 @@ int smu_v13_0_set_fan_speed_rpm(struct smu_context *smu,
 	uint32_t tach_period;
 	int ret;

-	if (!speed)
+	if (!speed || speed > smu->fan_max_rpm)
 		return -EINVAL;

 	ret = smu_v13_0_auto_fan_control(smu, 0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index d53e162dcd8d..44844cddb3bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -947,6 +947,16 @@ static int smu_v13_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 	return 0;
 }

+static int smu_v13_0_0_get_fan_parameters(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *smc_pptable = table_context->driver_pptable;
+
+	smu->fan_max_rpm = smc_pptable->SkuTable.FanMaximumRpm;
+
+	return 0;
+}
+
 static int smu_v13_0_0_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor,
 				   void *data,
@@ -3045,6 +3055,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v13_0_0_get_dpm_ultimate_freq,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.read_sensor = smu_v13_0_0_read_sensor,
+	.get_fan_parameters = smu_v13_0_0_get_fan_parameters,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.print_clk_levels = smu_v13_0_0_print_clk_levels,
 	.force_clk_levels = smu_v13_0_0_force_clk_levels,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b891a5e0a396..b305bce1bccc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -936,6 +936,16 @@ static int smu_v13_0_7_get_dpm_ultimate_freq(struct smu_context *smu,
 	return 0;
 }

+static int smu_v13_0_7_get_fan_parameters(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *smc_pptable = table_context->driver_pptable;
+
+	smu->fan_max_rpm = smc_pptable->SkuTable.FanMaximumRpm;
+
+	return 0;
+}
+
 static int smu_v13_0_7_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor,
 				   void *data,
@@ -2628,6 +2638,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v13_0_7_get_dpm_ultimate_freq,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.read_sensor = smu_v13_0_7_read_sensor,
+	.get_fan_parameters = smu_v13_0_7_get_fan_parameters,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.print_clk_levels = smu_v13_0_7_print_clk_levels,
 	.force_clk_levels = smu_v13_0_7_force_clk_levels,
--
2.39.2


