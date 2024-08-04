Return-Path: <linux-kernel+bounces-273886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8F946F33
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305AD1C21265
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA549654;
	Sun,  4 Aug 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="RPSe+GaA"
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7273CF7E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722780020; cv=none; b=SDXP2k4QiSQE6CICsA/AmQJiDPOgenLbCvbE4vk14rwcelTwUBb1LZ06S+IcQe8p7vXXMiQV+toec4CDb9I5JXe5vgbunyQWT4xXTwHEvd68TDgJXmSn1OOcvpjD+hindjY6QzBfubQinxvbwFNSqrT1LuxW8AVPWVwIDD7jizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722780020; c=relaxed/simple;
	bh=m876A2GsQgfOTGHpdHgrxcX3ISbk2r46rH1W+Dyrem4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XP9hYZjRtPx0r9LDzS/e+r0s8w2fpKcVuzssf7vMfc2RWSf7OHjhMi6YyjJZZfgQDvdPuQfWNDa1nlUunbCBGhetLBRXWC4Vux98LbvjNj3XZnnFjJqFyvODMjl1nVPPo9zBinULBgWPzduV3HWXFGy5fPKnf/qRSBrV9LaQpPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=RPSe+GaA; arc=none smtp.client-ip=129.70.45.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1722780013;
	bh=m876A2GsQgfOTGHpdHgrxcX3ISbk2r46rH1W+Dyrem4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RPSe+GaAbVD7/kHTEEsKRQlkLMmquP4kVooxiB9KCB3PvNKHcf8MusIu2fCK8W8bJ
	 bijPkhBtUoNzwhuGJ33Hu8snD8colrtVVi4tpeX6y2HvTY9FEAD+JoqdZHo+ijtkWh
	 RV+uWPzYd3G7VIBcvoGpT4kMbAYBZDpTGP5cYcfJxfJsK5JXbysmGTxJ/GVlCYvzP+
	 AUvy5M5e0oJftXyioSmftLDiTrITMSkJhZBn8H6O5WediVx4W3N3Vto6wAolaINAJD
	 3vnQPozr3gGYIoHxbCyBONy7+LSqS8FYevBt4IoH//LwSTtNSsWQ1FhkXQTzkadVXr
	 84651KGijGvYQ==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id 320D921086;
	Sun,  4 Aug 2024 16:00:13 +0200 (CEST)
From: tjakobi@math.uni-bielefeld.de
To: Evan Quan <evan.quan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/amdgpu/swsmu: fix SMU11 typos (memlk -> memclk)
Date: Sun,  4 Aug 2024 15:56:29 +0200
Message-ID: <ba5afac355b7c74b417c8f886e992abbfa3c046c.1722778722.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <cover.1722778722.git.tjakobi@math.uni-bielefeld.de>
References: <cover.1722778722.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

No functional changes.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5a68d365967f..a1a0e6224d72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1978,7 +1978,7 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			2,
-			"MEMLK",
+			"MEMCLK",
 			activity_monitor.Mem_FPS,
 			activity_monitor.Mem_MinFreqStep,
 			activity_monitor.Mem_MinActiveFreqType,
@@ -2038,7 +2038,7 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 			activity_monitor.Soc_PD_Data_error_coeff = input[8];
 			activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
 			break;
-		case 2: /* Memlk */
+		case 2: /* Memclk */
 			activity_monitor.Mem_FPS = input[1];
 			activity_monitor.Mem_MinFreqStep = input[2];
 			activity_monitor.Mem_MinActiveFreqType = input[3];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e426f457a017..a7340569b9a1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1691,7 +1691,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			2,
-			"MEMLK",
+			"MEMCLK",
 			activity_monitor->Mem_FPS,
 			activity_monitor->Mem_MinFreqStep,
 			activity_monitor->Mem_MinActiveFreqType,
@@ -1754,7 +1754,7 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 			activity_monitor->Fclk_PD_Data_error_coeff = input[8];
 			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
 			break;
-		case 2: /* Memlk */
+		case 2: /* Memclk */
 			activity_monitor->Mem_FPS = input[1];
 			activity_monitor->Mem_MinFreqStep = input[2];
 			activity_monitor->Mem_MinActiveFreqType = input[3];
-- 
2.44.2


