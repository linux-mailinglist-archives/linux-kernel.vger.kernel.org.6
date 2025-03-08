Return-Path: <linux-kernel+bounces-552768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E3A57DE2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1689216DAAF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31461EFF90;
	Sat,  8 Mar 2025 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="QERspmPT"
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604D1392
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741463787; cv=none; b=JFQD2S+25OKDMLDiYUsm3cn0TBdnDI0IoIR28bHtpR4K9zyLikqbS5T5U/WwTv+aNS2BoZhrZT3yQ5TWVn2tcRBp98CNg1waJD6nyhKUV1f5V0+P6Nud4yos4gb9moY2pe+3IgDg+bA1CpqHUm8BC3Z1lKMAsg6h9ZiJb/WsOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741463787; c=relaxed/simple;
	bh=0Gv4NSp/M2R/Or0jS2vcJyqiVcKF/Ne3xf3gs4CjUSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hI8Z5e96tGzoC/wgrKh7vAn/gVHVTqT72htXh72Dc/CJC9k6lObL013NdcGJwSh6jfS8QCiPsME4adq/NK//w0yevbLZD7s5qTfdpVDTa7uCn7HDcgBsFCS5iWN1+X7tuYFeid8V+PBRVmdBLIrnR0ik8pGOecOXwBDsgCpsFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=QERspmPT; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 523E4C0006;
	Sat,  8 Mar 2025 22:56:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 523E4C0006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1741463773; bh=WpEM5XZntMVPqkHvNhpNB66b5R4qVE7anHYLznaG1Jk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=QERspmPTqiuStZeqLF8pXge0J4m0s/73gTLd7NJfetxqWiKEsYqCo/8TQHJ/F5j3H
	 tPIsXp87UWa0akx1aUDObXyMRQunHdxSJaityC7NO/0wZW6HnUtS7WkkAqDO9Cri2q
	 hY6yjJmE858RUslCV8htsksIA6xYQtLAgACcXlajne34FyS8sGT1J65vqWP4eO9khs
	 lkbHVqYJpdoTc/g99W69ft6h8Oquk0czakm1JXKM+huyhy1OalC3He5VwnYPSkw8lo
	 hkTqXYxDNGlUSAgJ9BJ3ntD6LuAb6Y7LNYrBuzpwEWWyC1jtijCW1HlfZ5nedROsrG
	 dD2JhL4rgaevA==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Sat,  8 Mar 2025 22:56:13 +0300 (MSK)
Received: from localhost.localdomain (5.1.51.128) by mmail-p-exch01.mt.ru
 (81.200.124.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Sat, 8 Mar 2025
 22:56:12 +0300
From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
To: Dave Airlie <airlied@redhat.com>
CC: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>, Thomas Zimmermann
	<tzimmermann@suse.de>, Jocelyn Falempe <jfalempe@redhat.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drm/mgag200: fix division by zero in mgag200_g200_pixpllc_atomic_check()
Date: Sun, 9 Mar 2025 00:54:45 +0500
Message-ID: <20250308195451.14853-1-v.shevtsov@mt-integration.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1;81.200.124.61:7.1.2;mt-integration.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191593 [Mar 08 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/08 18:36:00 #27678783
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

There is a small chance to perform a division by zero. According to the
driver code, clock may have a value less than (p_clk_min >> 3). p_clk_min
itself may have a value up to 2032000 in case of a BIOS PINS version 5.

If this is the case, then f_vco gets the value greater than delta and the
condition (tmp_delta < delta) is always false because the variable computed
is always less than f_vco. This was tested with ref_clk = 27050.

As a result variable m remains zero and then is used as a divisor.

Check if m is zero before performing a possibly unsafe division.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 877507bb954e ("drm/mgag200: Provide per-device callbacks for PIXPLLC")
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
---
 drivers/gpu/drm/mgag200/mgag200_g200.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mgag200/mgag200_g200.c b/drivers/gpu/drm/mgag200/mgag200_g200.c
index f874e2949840..484b22930ce1 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200.c
@@ -115,6 +115,10 @@ static int mgag200_g200_pixpllc_atomic_check(struct drm_crtc *crtc, struct drm_a
 			}
 		}
 	}
+
+	if (!m)
+		return -EINVAL;
+
 	f_vco = ref_clk * n / m;
 	if (f_vco < 100000)
 		s = 0;
-- 
2.48.1


