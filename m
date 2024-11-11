Return-Path: <linux-kernel+bounces-404158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9159C4002
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A47280E58
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4619E826;
	Mon, 11 Nov 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="aqdgVia9"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2219C552
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333378; cv=none; b=XguDpE3pLjKgKGc1XbZVTWXVfW1OInafnNNYWe5fh65Gq2jAlQp1NlN+p3k+RfSK9i6ruyrGpTenXgbqzWKjZ7JNb14mEV+2yAtYQ1Rz63taZM/WhaOAHpUW23i0U3U7VZa7zi+hvML6eGdTIdkKDJ4/Knm9mA+rn029Ovg7CeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333378; c=relaxed/simple;
	bh=rJg4Ot2wfIOLuawfosJDRgwzzd4/06vpPtzaMrAdYew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZlyEql97ebkuQVYAtVcPgB+AIdnP4Z1brWlaOj1sdL1Qzi6ZRY4xwONc+5ph594coi0zcBj8imErYzreAUpn23J/hoitX6dO0BWC+tY5mtaH2zpsOaneYFbsceABw7IDxIELl8A7WuwP4lSf+5mXQCWZ2cLTr53wRw9Nbfz1YYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=aqdgVia9; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id C0A011E0006;
	Mon, 11 Nov 2024 16:47:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru C0A011E0006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1731332870; bh=8tXd0LJo0Wnt8jjrZ2luigCRDhUjB19IfjB6lhPbGzM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=aqdgVia9jt7wANQk0R34mmmSgtIc38sm5cUps8TzIPkqf7cMbSv5mxzFK0x/Nt+is
	 y7EWmz6ijtNOVy5ql7Adp4GXB5ytv7tZ7AhQBqZynF60DAHw23A3ef9yVpWTRec71D
	 pnQz02hfdwo4osKumZkkEz2fmjd1GKb767IEXEpq7Zqn31R2AH8/9TXmRp1QfubOzM
	 3FQX76vRG8Cqhz0ZLdN4Cigfrexc+01COus3ZFVGgvKHa3cFb+o2jDUkSrmwfQs3Ku
	 T3knU7RyB+fEU2u3Fpou2PlZhXYBKr+xFvdxsMrTOYZNfTfB+X0n70844d8oTdNZEV
	 1RYnOUhRLks9g==
Received: from ksmg02.maxima.ru (autodiscover.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 11 Nov 2024 16:47:50 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.217) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Mon, 11 Nov
 2024 16:47:49 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Dave Airlie <airlied@redhat.com>
CC: Murad Masimov <m.masimov@maxima.ru>, Thomas Zimmermann
	<tzimmermann@suse.de>, Jocelyn Falempe <jfalempe@redhat.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/mgag200: Apply upper limit for clock variable
Date: Mon, 11 Nov 2024 16:46:39 +0300
Message-ID: <20241111134644.1507-1-m.masimov@maxima.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 189084 [Nov 11 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, ksmg02.maxima.ru:7.1.1;81.200.124.62:7.1.2;127.0.0.199:7.1.2;maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/11 06:58:00 #26843820
X-KSMG-AntiVirus-Status: Clean, skipped

If the value of the clock variable is higher than 800000, the value of the
variable m, which is used as a divisor, will remain zero, because
(clock * testp) will be higher than vcomax in every loop iteration, which
leads to skipping every iteration and leaving variable m unmodified.

Clamp value of the clock variable to the upper limit, the same way it's done
with the lower limit.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 877507bb954e ("drm/mgag200: Provide per-device callbacks for PIXPLLC")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 drivers/gpu/drm/mgag200/mgag200_g200se.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
index 7a32d3b1d226..69402a591f59 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
@@ -218,6 +218,8 @@ static int mgag200_g200se_04_pixpllc_atomic_check(struct drm_crtc *crtc,

 	if (clock < 25000)
 		clock = 25000;
+	else if (clock > 800000)
+		clock = 800000;
 	clock = clock * 2;

 	/* Permited delta is 0.5% as VESA Specification */
--
2.39.2


