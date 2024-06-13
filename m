Return-Path: <linux-kernel+bounces-212841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4131290672B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551211C22534
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8926140E2E;
	Thu, 13 Jun 2024 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XPEd3qwS"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125EA140388
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267931; cv=none; b=UsE66ktEECPLOS2RVzCP2ONRxalLbGjwyd9yxNuKfGyLS7paXUt7NvMsUdaMuAKU4CsQj8N9a0dfxU9OiZcs+ZwyKWzuXXN8H2ijRO+/Q7fYbe7XH7vznBiEJW5uF3XdBO/OaTz7fKVep49IPyUv3OCiqIMkM/TRCsqfbRYK3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267931; c=relaxed/simple;
	bh=2lBCoyVSwCfn0+jjzoILCmsqHh6FBjPGpDkiN1EcNSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L8eCf9RBkCBOnQMzI0lDrHPLWKxScYca3fkqOl+TuqXXBKKDCIHssZy4mL0bO/kG7DxZbDH+ohYPQENCGo8GFiIksSdY0F3hzv6O3iGw8pR8NblaNzZSWW+rAlGZHo9VjHNI+4O2ei1OlE8QGnwvWS41DlVQqMAvQl5Xs+EYIDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XPEd3qwS; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8c6pA100718;
	Thu, 13 Jun 2024 03:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718267886;
	bh=TjyMmrW2J2r+RcKqfozTMKJxd3RBvb0XNqHfQ8z62jg=;
	h=From:To:CC:Subject:Date;
	b=XPEd3qwSH1MVbmbuJI6Y+54FQjNdEelkS9Bac9iU3apsnY/6VdSnkgeATU4kl4fkb
	 c17jjv1oGnRnFroFTD5G/EL/sBNUFKSIaIgl6pxD1dE40jBD20bXfS8p2K2Jw9Gsp8
	 b+w7Dvb8sKw7pHF8pUGVo6YfJxyTCyvIwR387qd8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8c6La021739
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:38:06 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:38:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:38:06 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8c5nn070145;
	Thu, 13 Jun 2024 03:38:06 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <sui.jingfeng@linux.dev>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <sam@ravnborg.org>, <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH v5 0/3] SII902X HDMI Bridge fixups
Date: Thu, 13 Jun 2024 14:08:02 +0530
Message-ID: <20240613083805.439337-1-j-choudhary@ti.com>
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

- Move the mode_valid hook to drm_bridge_funcs structure to take care
  of the case when the encoder attaches the bridge chain with the
  DRM_BRIDGE_ATTACH_NO_CONNECTOR flag in which case, the connector is
  not initialized in the bridge's attach call and mode_valid is not
  called.

- Also add this check to the atomic_check call as suggested by Maxime in
  v1 patch.

- Move from deprecated enable()/disable() hooks to atomic hooks as
  suggested in v4 by Sam

Testing has been done on AM62X platform which have SII902X HDMI bridge.
From the logs we can see the propagated modes and flip test for 1080p
resolution.

Testlog:
<https://gist.github.com/Jayesh2000/9bea6840672869337039296bc1145df4>

Changelog v4->v5:
- Add followup patch to replace deprecated bridge hooks
- Fix atomic check to return negative value
- Made commit message for [1/2] in v4 more clear while keeping the R-by and
  Acked-by tags.
- Fix commit header for [2/2] in v4

v4 patch:
<https://lore.kernel.org/all/20240530092930.434026-1-j-choudhary@ti.com/>

Changelog v3->v4:
- Remove mode_valid hook from connector_helper_funcs as it is not needed.

v3 patch:
<https://lore.kernel.org/all/20240524093509.127189-1-j-choudhary@ti.com/>

Changelog v2->v3:
- Remove newline that was introduced in [1/2] and later deleted in [2/2]
  in v2

v2 patch:
<https://lore.kernel.org/all/20240524073305.107293-1-j-choudhary@ti.com/>

Changelog v1->v2:
- Add KHZ suffix in the macros to be more clear
- Add the hook for drm_bridge_funcs as well
- Add check in atomic_check dunction call (in a separate patch)

v1 patch:
<https://lore.kernel.org/all/20240408081435.216927-1-j-choudhary@ti.com/>

Jayesh Choudhary (3):
  drm/bridge: sii902x: Fix mode_valid hook
  drm/bridge: sii902x: Support atomic bridge APIs
  drm/bridge: sii902x: Add pixel clock check in atomic_check

 drivers/gpu/drm/bridge/sii902x.c | 46 +++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 13 deletions(-)

-- 
2.25.1


