Return-Path: <linux-kernel+bounces-333591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA43B97CB11
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2411F25CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69C51A01A9;
	Thu, 19 Sep 2024 14:36:23 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F5C19E96D;
	Thu, 19 Sep 2024 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756583; cv=none; b=VM5FFTAqOQ/J/GC4YRK/lrAydbIKNm7fW5g8/sP2wRt3Vy1z9Y2ORWY+0feWSa7PO2efz3hxz82plzOtIDThhcP+hOgbV1AraZMA3sSSQ87We2cIcR+xcdfVII93NpvuOvTJQW4ZNc44oXrEZHmuCyiBi9TLC147Zp2w57RW+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756583; c=relaxed/simple;
	bh=j0IKG2YMV86ojTcj1IbJ6LxDlaE9XrPP8xWbXLz7RDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pus73e9BmzUCltZdrv7GIAPAl9cDbnW4rc/+Ds8TV6kkYsmQqO3ZaMXnrNIOB44I4qlGeMGUdoh0etkt7on8WUetwuIHoDdMjMvUyZ8NzOMc5gOXfkHBf0VIBmeqqpKZGauDmbrYi9/bAVthEFg0vs4S70+oHO/Wtpteoyg11j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 19 Sep
 2024 17:36:15 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 19 Sep
 2024 17:36:14 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Jani Nikula
	<jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	"Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
	<tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<lvc-patches@linuxtesting.org>, Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.10/5.15 1/1] drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()
Date: Thu, 19 Sep 2024 07:36:07 -0700
Message-ID: <20240919143607.14178-2-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919143607.14178-1-n.zhandarovich@fintech.ru>
References: <20240919143607.14178-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

commit 5b511572660190db1dc8ba412efd0be0d3781ab6 upstream.

On the off chance that clock value ends up being too high (by means
of skl_ddi_calculate_wrpll() having been called with big enough
value of crtc_state->port_clock * 1000), one possible consequence
may be that the result will not be able to fit into signed int.

Fix this issue by moving conversion of clock parameter from kHz to Hz
into the body of skl_ddi_calculate_wrpll(), as well as casting the
same parameter to u64 type while calculating the value for AFE clock.
This both mitigates the overflow problem and avoids possible erroneous
integer promotion mishaps.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 82d354370189 ("drm/i915/skl: Implementation of SKL DPLL programming")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
[Nikita: This patch had to be cherry-picked due to function
skl_ddi_calculate_wrpll() having had bool return value instead of
an int one in 5.15 and earlier kernel versions.]
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index 91b37b76618d..40c392b7ce75 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -1465,11 +1465,11 @@ static void skl_wrpll_params_populate(struct skl_wrpll_params *params,
 }
 
 static bool
-skl_ddi_calculate_wrpll(int clock /* in Hz */,
+skl_ddi_calculate_wrpll(int clock,
 			int ref_clock,
 			struct skl_wrpll_params *wrpll_params)
 {
-	u64 afe_clock = clock * 5; /* AFE Clock is 5x Pixel clock */
+	u64 afe_clock = (u64)clock * 1000 * 5; /* AFE Clock is 5x Pixel clock, in HZ */
 	u64 dco_central_freq[3] = { 8400000000ULL,
 				    9000000000ULL,
 				    9600000000ULL };
@@ -1552,7 +1552,7 @@ static bool skl_ddi_hdmi_pll_dividers(struct intel_crtc_state *crtc_state)
 
 	ctrl1 |= DPLL_CTRL1_HDMI_MODE(0);
 
-	if (!skl_ddi_calculate_wrpll(crtc_state->port_clock * 1000,
+	if (!skl_ddi_calculate_wrpll(crtc_state->port_clock,
 				     i915->dpll.ref_clks.nssc,
 				     &wrpll_params))
 		return false;
-- 
2.25.1


