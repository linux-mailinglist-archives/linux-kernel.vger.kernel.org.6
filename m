Return-Path: <linux-kernel+bounces-334672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB53997DA51
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EAC283760
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C38186E5B;
	Fri, 20 Sep 2024 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="sfrcMMTP"
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D03BBC9
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726868639; cv=none; b=QHcIUt8xYI5dLruEMVL73SQRfH9f/5evWBXzO8Yyf54trckf22zvnOOpZnHGVwK0zSTuHGWfKmiCiqfoX3hMbMLh4FiQKe+2K6DL0fwiMm60RoSwZH3qR9qIIg997XtJJ50yWW0v9TH1O5IKhVFu5wao3o/khiCHniPJLxd9Gig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726868639; c=relaxed/simple;
	bh=wVXt34WD3MP8hwh2aEMu8PXCTGj2/9B0oEKrZfoMnh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o9zFtQF4oeOhVGyxrCh4Cidt7d/Q0mIr5F9tF61Hg8rvmb5zaMcghhyFz4XGkypHc+4uAK47KDCvoXakNAmSFW5xRnutbAAu2mTo7uxe6JMcY3iV8/0nZxpBrqcTcBhhWvzoBXndfwkFfA7PSIyEIPxOLCCGU6UiyiN8t6VU3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=sfrcMMTP; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 97D58C0003;
	Sat, 21 Sep 2024 00:43:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 97D58C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1726868625; bh=WC3ILFut2f0eUKoeHk92ph9UKGLO6mpEKbgxlt9i2W4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=sfrcMMTPsJ/3rdVLHfmRN2+ZOQIjISfUOe+lpW3tkctLsY3jM9dJ/NxZA8jf0hTq3
	 501oL4PdUEk7uwUTWIlgKBAOfJGVtXgaUimRD76ccBED0L2j7BrzIKBrG3GelbYrRp
	 L72wLXLY6DFuWQOVtJl0ee2IRoq68yaE+mnm3uNhAjLAkFsA4Kv1zyhooru4ZTuRfx
	 JdqHeWW2MyZNONULoCElWbRk/aCbAp5vHZCLsbLA9Aj5yvcwX8+4Vhbace+4K63wXZ
	 euD8RUYn7bUUw7JiUVsHEkwWP6SVeN75EbF5vAdD9X6RwMvl2p8a10wbnNkO76c5er
	 U1fCLAvlNL6kw==
Received: from ksmg01.maxima.ru (unknown [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Sat, 21 Sep 2024 00:43:45 +0300 (MSK)
Received: from localhost.maximatelecom.ru (10.0.247.181) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Sat, 21 Sep 2024 00:43:41 +0300
From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
To: Harry Wentland <harry.wentland@amd.com>
CC: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alvin Lee
	<alvin.lee2@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Dillon Varone <dillon.varone@amd.com>, yi-lchen
	<yi-lchen@amd.com>, Alex Hung <alex.hung@amd.com>, Chris Park
	<chris.park@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, George Shen <george.shen@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Samson Tam <samson.tam@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/amd/display: fix typos in several function pointer checks
Date: Sat, 21 Sep 2024 02:43:40 +0500
Message-ID: <20240920214342.14792-1-v.shevtsov@maxima.ru>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187892 [Sep 20 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg01.maxima.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61, {DNS response errors}
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/20 19:27:00 #26647840
X-KSMG-AntiVirus-Status: Clean, skipped

Fix several copypaste mistakes in *_disable_link_output() functions where
an improper function pointer is checked before dereference.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index d52ce58c6a98..c2364cb66d0b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3258,7 +3258,7 @@ void dce110_disable_link_output(struct dc_link *link,
 	 * from enable/disable link output and only call edp panel control
 	 * in enable_link_dp and disable_link_dp once.
 	 */
-	if (dmcu != NULL && dmcu->funcs->lock_phy)
+	if (dmcu != NULL && dmcu->funcs->unlock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 4e93eeedfc1b..5b6cf2a8e38d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -478,7 +478,7 @@ void dcn314_disable_link_output(struct dc_link *link,
 	 * from enable/disable link output and only call edp panel control
 	 * in enable_link_dp and disable_link_dp once.
 	 */
-	if (dmcu != NULL && dmcu->funcs->lock_phy)
+	if (dmcu != NULL && dmcu->funcs->unlock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index a36e11606f90..84153682af1a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1384,10 +1384,10 @@ void dcn32_disable_link_output(struct dc_link *link,
 	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 
 	if (signal == SIGNAL_TYPE_EDP &&
-			link->dc->hwss.edp_backlight_control &&
+			link->dc->hwss.edp_power_control &&
 			!link->skip_implict_edp_power_control)
 		link->dc->hwss.edp_power_control(link, false);
-	else if (dmcu != NULL && dmcu->funcs->lock_phy)
+	else if (dmcu != NULL && dmcu->funcs->unlock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
 
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
-- 
2.46.1


