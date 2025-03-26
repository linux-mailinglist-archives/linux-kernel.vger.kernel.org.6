Return-Path: <linux-kernel+bounces-577195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29232A719B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E6D171EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305F1F4284;
	Wed, 26 Mar 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ikzW2MH1"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540621F4197;
	Wed, 26 Mar 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001085; cv=none; b=UkE78FUFookTXAxJdkbq3Wan9a5UWwvcacSV/3nRBjnXzm9nOaGiCtWUbhfoBjZwg4QGIb6TC5fgvnj0U8i2L90qkQ3thgDcQD5wexgI8KoDW+zvOyasgG2QEEMiIqXiF8X7FDKfOJyM+wiJIgkbC3gAhpVcMSPPTZwjvGW6xdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001085; c=relaxed/simple;
	bh=QVOXaPoW8j1JbgyK9EX4B0EZ6amjqc8hUERyGWV8bI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KWmrrK7oesEkqZYRP2k2f5KLHXjjF4v1pnF1V3P5Qg3tjHwd0yJUloYM3HOOuRgfmXdpznmLga1CRsQsu0DQ2bh64TiyG66ol6P4w6TJogH5ADnS80nVjgA0n4F/n9VTWSYnz8pVjwOLd78TFznNk6uFzES59LbY0ObeWSwN5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ikzW2MH1; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52QEvbdM2222392
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 09:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743001057;
	bh=eXD8bmoxHD/Y0t9zn8pp0a84HOCX8GjkBQKf1mH3xlA=;
	h=From:To:CC:Subject:Date;
	b=ikzW2MH1uelOfwc2Eid2VFy4x4CYvmpWtkv42vqU+Uv1pvLY0WdhNoScEBcLpPbfA
	 Xp+5MrtXP+fqZCRLvpoicF1JYUe4EHGDyKLo4rwMvP8hS0Z4HrOQSGTDoWQvdYEzf2
	 d/WWYKFNHjUKAalxMwpMCyOvEWH2vUqJkusaiAeM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52QEvbTY097951
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Mar 2025 09:57:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Mar 2025 09:57:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Mar 2025 09:57:37 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52QEvaSn045765;
	Wed, 26 Mar 2025 09:57:37 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <simona@ffwll.ch>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>,
        <s-jain1@ti.com>, <r-donadkar@ti.com>, <j-choudhary@ti.com>,
        <h-shenoy@ti.com>, <devarsht@ti.com>
Subject: [PATCH v4 0/3] Add support for AM62L DSS
Date: Wed, 26 Mar 2025 20:27:33 +0530
Message-ID: <20250326145736.3659670-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This adds support for DSS subsystem present in TI's AM62L SoC
which supports single display pipeline with DPI output which
is also routed to DSI Tx controller within the SoC.

Change Log:
V4:
- Update vid_info struct to keep hw_id and instantiate
  only for actually existing pipes

V3:
- Make generic infra to support truncated K3 DSS IP's
- Remove AM62A updates from AM62L DT binding updates

V2:
- Fix incorrect format of compatible string (comma instead of
  hyphen) for AM62L SoC
- Use separate register space and helper functions for AM62L
  due to minor differences in register offset/bit position differences
  for first plane

Rangediff:
V3->V4:
- https://gist.github.com/devarsht/1e75c9e1ac0cdfc01703a0776e31e782

V2->V3:
- https://gist.github.com/devarsht/24fa8dd2986861efa431352d19ebbb41

V1->V2
- https://gist.github.com/devarsht/11d47f25ca9fea6976e6284330ddf443

Links to previous versions:
V3: https://lore.kernel.org/all/20250306132914.1469387-1-devarsht@ti.com/
V2: https://lore.kernel.org/all/20250204061552.3720261-1-devarsht@ti.com/
V1: https://lore.kernel.org/all/20241231090432.3649158-1-devarsht@ti.com/

Test logs:
https://gist.github.com/devarsht/16fe796b8fd3ea8abf5df8e2327d2311

Devarsh Thakkar (3):
  dt-bindings: display: ti,am65x-dss: Add support for AM62L DSS
  drm/tidss: Update infrastructure to support K3 DSS cut-down versions
  drm/tidss: Add support for AM62L display subsystem

 .../bindings/display/ti/ti,am65x-dss.yaml     |  21 ++-
 drivers/gpu/drm/tidss/tidss_crtc.c            |   8 +-
 drivers/gpu/drm/tidss/tidss_dispc.c           | 176 ++++++++++++++----
 drivers/gpu/drm/tidss/tidss_dispc.h           |  13 +-
 drivers/gpu/drm/tidss/tidss_drv.c             |   1 +
 drivers/gpu/drm/tidss/tidss_kms.c             |   2 +-
 drivers/gpu/drm/tidss/tidss_plane.c           |   2 +-
 7 files changed, 178 insertions(+), 45 deletions(-)

-- 
2.39.1


