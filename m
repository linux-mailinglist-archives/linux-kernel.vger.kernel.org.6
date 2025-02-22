Return-Path: <linux-kernel+bounces-527523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B6BA40C50
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F64A189EF1C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC41362;
	Sun, 23 Feb 2025 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="O2JFj+xk"
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245AB29A9
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740269108; cv=none; b=JQUhevIks8dUHgbR/6blZ28NQfKdwZv5MR319CeLPRDt+45lAEPLG2B3yPtt9ixO6xE/fROlYZAU6ahGNpdY4n4tgN71+UIiNo1Oge2x0aZpbCP94qEJWuTeuslf6LT9vo88yiNbQMNxff+MlHqmWQstK84K8nu5rEnbjfBoOD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740269108; c=relaxed/simple;
	bh=E9cdjRUVITPLQsgGsHuH4nhFKsBTV7y3Z0+t1B5sOPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hM60bHNRzKVl7WEayBXdhsTU+85lxFTaGaCyJSvRr37y8pxqEhS/JOMfHmZutHtM8d+1sbPnl2a9PSpLlsA5H5c5K5eCMMt0gpMytdLlF+uMTvNTiTLDwekBM4gFNQ17LSYcVbibkLcvgqCAH+BcFUSPksvP5vzt3cdVfTMevzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=O2JFj+xk; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 93A90C0010;
	Sun, 23 Feb 2025 02:59:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 93A90C0010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1740268763; bh=5MgY5RqIvIZhdOAndrhlIhNOxars4SRgjV828wmNqdk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=O2JFj+xkSNjMfp/9QMUMVJqFWU8xlje2xDAdp4spqnNVbnHHhO1rH9kzh+JJtZr4n
	 9FwVC9+y52ixjqm3B3Ubfgp3499ZhPyF0ostpaTfaNP8cftaQCzBtNMRKL1ELeY0Dd
	 tZg3l8qET6Smk07C6xgRiT2sDYgH4KihWSH5QukDmbyluy5IsMTpLW7F1YzSvco0nj
	 1Oryz+i0EukW6byUrzEzlDy07FpH0FGWfGaASNuq/MQ2X2S468LnlTMIiVw1nZWCpy
	 CBc8R8VdynzBacli0U+ol3XgD77ogng/5bIAWEIjrMETNXRSVNIDAwYCYgNOQojsgU
	 D4wsDff7n+dfA==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Sun, 23 Feb 2025 02:59:23 +0300 (MSK)
Received: from localhost.maximatelecom.ru (178.236.220.144) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Sun, 23 Feb 2025 02:59:20 +0300
From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
To: Chaitanya Dhere <chaitanya.dhere@amd.com>
CC: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>, Jun Lei
	<jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li
	<sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alex Hung
	<alex.hung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Aric Cyr
	<aric.cyr@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drm/amd/display: fix type mismatch in CalculateDynamicMetadataParameters()
Date: Sun, 23 Feb 2025 04:58:16 +0500
Message-ID: <20250222235818.1990-1-v.shevtsov@mt-integration.ru>
X-Mailer: git-send-email 2.48.1
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
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191202 [Feb 22 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/02/22 16:52:00 #27403738
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

There is a type mismatch between what CalculateDynamicMetadataParameters()
takes and what is passed to it. Currently this function accepts several
args as signed long but it's called with unsigned integers. On some systems
where long is 32 bits and one of these input params is greater than INT_MAX
it may cause passing input params as negative values.

Fix this by changing these argument types from long to unsigned int. Also
this will align the function's definition with similar functions in other
dcn* drivers.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
---
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index cee1b351e105..c6c7ce84e260 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -281,10 +281,10 @@ static void CalculateDynamicMetadataParameters(
 		double DISPCLK,
 		double DCFClkDeepSleep,
 		double PixelClock,
-		long HTotal,
-		long VBlank,
-		long DynamicMetadataTransmittedBytes,
-		long DynamicMetadataLinesBeforeActiveRequired,
+		unsigned int HTotal,
+		unsigned int VBlank,
+		unsigned int DynamicMetadataTransmittedBytes,
+		unsigned int DynamicMetadataLinesBeforeActiveRequired,
 		int InterlaceEnable,
 		bool ProgressiveToInterlaceUnitInOPP,
 		double *Tsetup,
@@ -3265,8 +3265,8 @@ static double CalculateWriteBackDelay(
 
 
 static void CalculateDynamicMetadataParameters(int MaxInterDCNTileRepeaters, double DPPCLK, double DISPCLK,
-		double DCFClkDeepSleep, double PixelClock, long HTotal, long VBlank, long DynamicMetadataTransmittedBytes,
-		long DynamicMetadataLinesBeforeActiveRequired, int InterlaceEnable, bool ProgressiveToInterlaceUnitInOPP,
+		double DCFClkDeepSleep, double PixelClock, unsigned int HTotal, unsigned int VBlank, unsigned int DynamicMetadataTransmittedBytes,
+		unsigned int DynamicMetadataLinesBeforeActiveRequired, int InterlaceEnable, bool ProgressiveToInterlaceUnitInOPP,
 		double *Tsetup, double *Tdmbf, double *Tdmec, double *Tdmsks)
 {
 	double TotalRepeaterDelayTime = 0;
-- 
2.48.1


