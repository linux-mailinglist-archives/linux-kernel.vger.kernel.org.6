Return-Path: <linux-kernel+bounces-195175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76858D487F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A0A1C2350C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAA4152180;
	Thu, 30 May 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vvr3ccyV"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973336F314
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061394; cv=none; b=VGdDc7Q9RNCI/5CQWVDjHXeHXFYnnjeHWC0T6simH4XQSNW+nnDQv8qBqCknurmBWnpyR9BVQAyIonoi9zJyRAI1Nb7w2xlxiikzJ4uuJECRVv0nBYZHfNSWSd6RYB28Ctz0VogF+D+VSJ0NM34ciOkDS+Iwxtk3VL78tvWqHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061394; c=relaxed/simple;
	bh=JKzSnQecgd7u4K89EAQFL82K4hnMXOXK390++g7jjcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CJAp7SeJHXLv0uODqk10OMlumSwcjRIK9HPa8OkcNNyD1C/YepxiVPP2xMIdGFcEcX1vUGjexa0yZVFnZv9DYJXAYDmSv+Z5ljgbNpB0ZQWjljP6ur5jqc1e117q+6vJ1EDTrx3uft2/FKcCRReZSgs6ZzZM5E/8ofFk0Aac8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vvr3ccyV; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U9TVb0054130;
	Thu, 30 May 2024 04:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717061371;
	bh=2hYA47DOvcDeTkKm028dYBABl6cBIAITymbjUen38/Y=;
	h=From:To:CC:Subject:Date;
	b=vvr3ccyVZvfrtqQvNHF9KJapDGYjEeYxAZ1h5VElEjNXCSDF/z68UTlE1RpgdQfRF
	 gHLl+MtwNwFtcubIM+qle3st1V3L/+0Hw+XDnti9D5AIBFbBsyeCCUWd8syUuQb16T
	 G7WgWHmgM2InkE4IYkLsao52U/+3eHbrS0vV3i8I=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U9TVmB050427
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 04:29:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 04:29:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 04:29:31 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U9TUZt074178;
	Thu, 30 May 2024 04:29:31 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <mripard@kernel.org>, <sam@ravnborg.org>, <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH v4 0/2] Add mode_valid and atomic_check hooks for sii902x bridge
Date: Thu, 30 May 2024 14:59:28 +0530
Message-ID: <20240530092930.434026-1-j-choudhary@ti.com>
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

Move the mode_valid hook to drm_bridge_funcs structure to take care
of the case when the encoder attaches the bridge chain with the
DRM_BRIDGE_ATTACH_NO_CONNECTOR flag in which case, the connector is not
initialized in the bridge's attach call and mode_valid is not called.

Also add this check to the atomic_check call as suggested by Maxime in
v1 patch.

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

Jayesh Choudhary (2):
  drm/bridge: sii902x: Fix mode_valid hook
  drm/bridge: Add pixel clock check in atomic_check

 drivers/gpu/drm/bridge/sii902x.c | 38 ++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

-- 
2.25.1


