Return-Path: <linux-kernel+bounces-218840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4290C6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7E3B2263A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21291A08BB;
	Tue, 18 Jun 2024 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fp+dgBEQ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483F1A08AC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698515; cv=none; b=GDG6xvHL50qB+Hk/cwHAVBI+OFTCM4jVTTWD4xd9U7LshZ3g3+3720qcBagpbJT0Ckfe0nWm7F8JmmtMO+ppbF0TM9yqdJijieER0lZqZfehtaZxH81GxDi3jgBj5w2KV3G0ng2MJfD+JN2T4+bFeqaGkH8ODS8u7n7J+aoIZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698515; c=relaxed/simple;
	bh=+HqGHUStJZsZFFhIuPUlXTMLTzmjF/BHExBzgcosEZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nB251n4w2edkOXmQEMlYGqpgEg4B7Ugc8kHdJA/7MfpXPMSRb3GCpWZ5o9jbz1BWgunA5JPnoT7tzaHxb1aEhuMfVELRtJwWnuLxYzL1WWIEOAnRlRCZleijXy3rPZbWocIn7tjxHlcyaeKs3Buxp84PzgmXRHYdYEdjrNcOdUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fp+dgBEQ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45I8EJgW025729;
	Tue, 18 Jun 2024 03:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718698459;
	bh=PSyC1cSgLHJUy5WdcIFWpbRsw57FqFOYek3lPPDMuRA=;
	h=From:To:CC:Subject:Date;
	b=Fp+dgBEQHt68q3YP9JNiqiWBdMX5J7jNrwnK02toesuVapUDKNU44pt6AiySFFvYz
	 mSMMaif3bicHlJi+pHro2OmFDxP01IZrDF2NkRCP66e6QNuePB+UtXHJL0yski0uNV
	 cTHUcsOT5fxibM3VqEvA3dm0nwEBMLrGKwAZeRvk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45I8EJwD128587
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 03:14:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 03:14:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 03:14:19 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45I8EI1N116957;
	Tue, 18 Jun 2024 03:14:19 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <dianders@chromium.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <j-choudhary@ti.com>
CC: <linux-kernel@vger.kernel.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <spanda@codeaurora.org>, <a-bhatia1@ti.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH v2 0/2] SN65DSI86 minor fixes
Date: Tue, 18 Jun 2024 13:44:16 +0530
Message-ID: <20240618081418.250953-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello All,

These 2 patches add the atomic check hook for sn65dsi86 bridge and
does a minor math fix for dsi rate calculation.

According to the datasheet[0], for the max resolution, it says:
  Suitable for 60 fps 4K 4096 x 2304 resolution at 18
  bpp color, and WUXGA 1920 x 1200 resolution
  with 3D graphics at 60 fps (120 fps equivalent)

A very usual clock frequency for 4K@60fps resolution is 594MHz.
So keeping the max value supported by the bridge as 600MHz for
safe check.

DSI clock frequency range check are as per datasheet[0].

Changelog v1->v2:
- Check the value in atomic_check hook
- Fix the "Fixes" tag
- Fix MAX_DSI_CLK_RANGE to reflect actual supported value
- Add mode_clock check to ensure that the bit_rate_khz variable
  does not overflow instead of justifying by reverse calculation
  in comments.
- Fix commit message to show that the math uissue was found during
  code inspection.

v1 patch:
<https://lore.kernel.org/all/20240408073623.186489-1-j-choudhary@ti.com/>

[0]: <https://www.ti.com/lit/gpn/sn65dsi86>

Jayesh Choudhary (2):
  drm/bridge: ti-sn65dsi86: Add atomic_check hook for the bridge
  drm/bridge: ti-sn65dsi86: Fix ti_sn_bridge_set_dsi_rate function

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 67 +++++++++++++++++++--------
 1 file changed, 47 insertions(+), 20 deletions(-)

-- 
2.25.1


