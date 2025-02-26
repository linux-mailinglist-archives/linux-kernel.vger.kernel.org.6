Return-Path: <linux-kernel+bounces-534902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFBEA46C73
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FB616E37F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D79B1B2182;
	Wed, 26 Feb 2025 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="t/KmLHxg"
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11461E1DF8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601822; cv=none; b=ng5GzyppdBBQKSxhhKwZSeRgRcanRWVUB7594bh9u67MoIItJ4cD9lpoc96fWTNyeiAuwAMewHBzubv0xU6cRvxVpipPgNPXjUAnw6064z02Y0ST7fgWpIBGiGPMRBUuA2cdhB6AcI84Hr2U8lqwh3P+apNXZDa7GVoaU0iT2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601822; c=relaxed/simple;
	bh=99/yD0MCWnwnXD1agKNODcXGlCx7eSPDV8KyDCaB2n4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eVzNADuF9uj5rlUhOLg15LRhOPzbHnuope41lwhL0YbwlONWYIyZsPMNJLowETsgfWnLvFK06cMMHIvWOo9pgHV0QxvbDRMDF/4qD9XUxlR+N6sb7ExN1aroKukC8p+N6w0KBHtdAld38vInbQUNjkhOeAC7eqKQrMS3+2P9JqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=t/KmLHxg; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 44CC9C001A;
	Wed, 26 Feb 2025 23:30:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 44CC9C001A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1740601814; bh=2KT/ScqJnpt/ZJ3+IQvKjosQnxz+MuCoyqiJa/Langg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=t/KmLHxgqDueZXfCEAbw/htWLYZWK4igPvAAbUFtQOPavHXhOjupDNYC6RtXuOqyH
	 nQyDHwo/T0zdhHgY7xHr9bKJYOb29CkLRe9/YvGKtsXBNph55zx18cm8ohrCHLJKrU
	 /z7l/czJLg2/CdFwhF6TSl44/0UWcNhOyXXmSOTxHFxNoz2xc8tAo+P+mGfouQ+GaG
	 HvdM5xApsRBtvAKb4I5/UM2v/ValJAgZgy6vrS8eUvuCVNnTkXt+MQOFcQ8E5KCF68
	 t+FgqAPBl3oVT07GBUNUcYQ67uFD0KBM99pxZ6RDJCYs2wT3oXVlJCAv5kzGNEskgr
	 82d5sbhsKjFLw==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Wed, 26 Feb 2025 23:30:14 +0300 (MSK)
Received: from localhost.maximatelecom.ru (178.236.220.144) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Wed, 26 Feb 2025 23:30:13 +0300
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
Subject: [PATCH v3] drm/amd/display: fix type mismatch in CalculateDynamicMetadataParameters()
Date: Thu, 27 Feb 2025 01:28:51 +0500
Message-ID: <20250226202853.13319-1-v.shevtsov@mt-integration.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, ksmg01.maxima.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191329 [Feb 26 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/02/26 17:13:00 #27470398
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

There is a type mismatch between what CalculateDynamicMetadataParameters()
takes and what is passed to it. Currently this function accepts several
args as signed long but it's called with unsigned integers and integer. On
some systems where long is 32 bits and one of these unsigned int params is
greater than INT_MAX it may cause passing input params as negative values.

Fix this by changing these argument types from long to unsigned int and to
int respectively. Also this will align the function's definition with
similar functions in other dcn* drivers.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 6725a88f88a7 ("drm/amd/display: Add DCN3 DML")
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
---
v3: Update the description to include int in addition to unsigned int.
v2: Change DynamicMetadataLinesBeforeActiveRequired type from unsigned int
    to int as per Alex Hung's observation.
    Add Fixes tag missed by chance.

 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index cee1b351e105..f1fe49401bc0 100644
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
+		int DynamicMetadataLinesBeforeActiveRequired,
 		int InterlaceEnable,
 		bool ProgressiveToInterlaceUnitInOPP,
 		double *Tsetup,
@@ -3265,8 +3265,8 @@ static double CalculateWriteBackDelay(
 
 
 static void CalculateDynamicMetadataParameters(int MaxInterDCNTileRepeaters, double DPPCLK, double DISPCLK,
-		double DCFClkDeepSleep, double PixelClock, long HTotal, long VBlank, long DynamicMetadataTransmittedBytes,
-		long DynamicMetadataLinesBeforeActiveRequired, int InterlaceEnable, bool ProgressiveToInterlaceUnitInOPP,
+		double DCFClkDeepSleep, double PixelClock, unsigned int HTotal, unsigned int VBlank, unsigned int DynamicMetadataTransmittedBytes,
+		int DynamicMetadataLinesBeforeActiveRequired, int InterlaceEnable, bool ProgressiveToInterlaceUnitInOPP,
 		double *Tsetup, double *Tdmbf, double *Tdmec, double *Tdmsks)
 {
 	double TotalRepeaterDelayTime = 0;
-- 
2.48.1


