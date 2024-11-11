Return-Path: <linux-kernel+bounces-404350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E89C42B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D26B2B20ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA821A0BC3;
	Mon, 11 Nov 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="MrdOOnJX"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60619C569
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342848; cv=none; b=mw4mO1Sont5egfJaFqtCXVkSv/s236zrnftOP0M3EpongTekrDB/IJEWr7T4Ha5dA4KuW8uP1qKY4yOPVhm7iT1i+3/heg7ZroxG2jsijz9JnKcS67OEaIWEHn779+T/LZUH4JxKvQ3Am5eaNGkBLk7fWYH1SVWFDCargMAw5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342848; c=relaxed/simple;
	bh=dP+HmGMFd5NloqEQ0JLEOqYnA62qL1rmpFys7NAWwYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BDDiyOWkygcCRvMtwyR71U69cNVWpret0UbGsORaTZk7P7sO/NzJIiBNu8HnA4jkAODgP7JJBxmTmg19ZsehC3VgJR0XO576zqUAIn5VcqF6TQpvaZxy7I0MLF6XcYH7avxLS0s8p+DobziM46BGu7drY/LUqBsXI9ZEjtG/if4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=MrdOOnJX; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id B33671E0003;
	Mon, 11 Nov 2024 19:33:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru B33671E0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1731342839; bh=e2562SIQvLHnyfeL1tvjYy46Uc1ATcYhf55JZtX+YWY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=MrdOOnJXwUnpfAU8e+Q8uZGg8vAtpKIMmb+tV4LTUbRir5gdH9N86VC3uBcSXt/bC
	 NhIKNmBBwh5d1qOWLmGnFHJmDa0JY7weCbCFTDx5bO66xnnAF+vmtd5p0ZuOSiIDvH
	 6X4ULrCz1gketdhao4fdqi79xpNzJXrtEAHx9xI/STQC/Bf/wKr/hbkKZELullXpyL
	 ZFkw51Dyxf9UjWyswurvEmb3Ir6JnCO8xsmF/jnnNpv/1Rco+rUbyFFrReLFrbe2U8
	 5Qe9r9yZBhFon/sFSy7/iuNdcGf40OeaRGups7VO2g1r48/s/rW0SSteEmBGx0d8QF
	 ty/FV2+bNqKTg==
Received: from ksmg02.maxima.ru (autodiscover.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 11 Nov 2024 19:33:59 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.169) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Mon, 11 Nov
 2024 19:33:56 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Dave Airlie <airlied@redhat.com>
CC: Murad Masimov <m.masimov@maxima.ru>, Thomas Zimmermann
	<tzimmermann@suse.de>, Jocelyn Falempe <jfalempe@redhat.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] drm/mgag200: Apply upper limit for clock variable
Date: Mon, 11 Nov 2024 19:33:00 +0300
Message-ID: <20241111163306.860-1-m.masimov@maxima.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 189089 [Nov 11 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;maxima.ru:7.1.1;81.200.124.62:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg02.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
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

Clamp value of the clock variable between the lower and the upper limits.
It should be correct, since there is already a similar lower limit check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e829d7ef9f17 ("drm/mgag200: Add support for a new rev of G200e")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 drivers/gpu/drm/mgag200/mgag200_g200se.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
index 7a32d3b1d226..4934c27b084e 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
@@ -216,8 +216,7 @@ static int mgag200_g200se_04_pixpllc_atomic_check(struct drm_crtc *crtc,
 	m = n = p = s = 0;
 	delta = 0xffffffff;

-	if (clock < 25000)
-		clock = 25000;
+	clock = clamp(clock, 25000L, 800000L);
 	clock = clock * 2;

 	/* Permited delta is 0.5% as VESA Specification */
--
2.39.2


