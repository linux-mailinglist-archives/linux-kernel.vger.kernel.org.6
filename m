Return-Path: <linux-kernel+bounces-256060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F30934879
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D50E2829A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582367347E;
	Thu, 18 Jul 2024 07:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q/LwbwxA"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6A8488;
	Thu, 18 Jul 2024 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286093; cv=none; b=vBdV6NUA46Ey7qkz68ERxj7iRqbl5z0L8+cI6ZjeC9o4idodcUI1brgGTf1/R5D+qlb6YPNoFq/Gxlnrz9u2MREPVaWndSolPK7AqEMyh+T3Ua8BGfwg5+jRpaJ0zQwrP6csbDAmCY5fplGOAy/YoEsZWJjzFlohsMLdL48w3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286093; c=relaxed/simple;
	bh=s4Nm0pt3ObUkkwHFoDzvsGzhfX79K/Wlh3m1nazqm7Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvmLfRuJUiKAjoipOdSQj1rRX7weTbqL1a24wwM+NKib++UF0n3K4M3k06Bs5DYgQZp5S+cSd/k+ornPcyBgMLlNLc9/tXdPIEitqx5Kzfxk5+cDzXOISVdbtfP/GQX9/mXw6JpIScio8IAzPf1FiAXzuNMf5/FHqDO1j3oT9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q/LwbwxA; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46I70V0m023685;
	Thu, 18 Jul 2024 02:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721286031;
	bh=7RVqeIDLuD6xV55kFX0VpsHpoNGYN5G0haiDA1UmC5I=;
	h=From:To:CC:Subject:Date;
	b=q/LwbwxAFcNZCWIc3wwUrtOEX9MqIGdECNcIJ7fiTKoWGkwFr6T8ADh/Ditr8yIDb
	 d9EypqLEkCOqv9b2V0r+Cp+A6n9TOYohT4D3xn4VKjqY/J6ZBDx2n1GeMbkdv9EZAj
	 2JcOtASvELtvnPooBan9CqwXLKzjuD7PpYuLg85A=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46I70VGj019248
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jul 2024 02:00:31 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jul 2024 02:00:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jul 2024 02:00:31 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46I70QHt006129;
	Thu, 18 Jul 2024 02:00:27 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-firmware@kernel.org>
CC: <zigo@debian.org>, <baojun.xu@ti.com>, <13564923607@139.com>,
        <v-po@ti.com>, <linux-sound@vger.kernel.org>, <robinchen@ti.com>,
        <linux-kernel@vger.kernel.org>, <mimperial@lenovo.com>,
        <cchen50@lenovo.com>, <soyer@irl.hu>, <stuart.a.hayhurst@gmail.com>,
        <navada@ti.com>, Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v2] ASoC: tas2781: fix the license issue for tas781 firmware
Date: Thu, 18 Jul 2024 15:00:22 +0800
Message-ID: <20240718070022.591-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix the license issue for tas781 firmware, which are shipped as .bin
opaque. Remove the GPL-2+, which imposes having the source code
available.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v2:
 - Drop "Found in hex form in kernel source."
 - Drop Allegedly, Add Redistributable.
v1:
 - Remove the GPL-2+ and fix the license issue.
 - Update the year of copyright.
---
 WHENCE | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/WHENCE b/WHENCE
index b2fc018..3d95a97 100644
--- a/WHENCE
+++ b/WHENCE
@@ -7384,10 +7384,8 @@ Link: TAS2XXX38E0.bin -> ti/tas2781/TAS2XXX38E0.bin
 Link: TIAS2781RCA2.bin -> ti/tas2781/TIAS2781RCA2.bin
 Link: TIAS2781RCA4.bin -> ti/tas2781/TIAS2781RCA4.bin
 
-Licence: Allegedly GPLv2+, but no source visible. Marked:
-	 Copyright (C) 2023 Texas Instruments
-
-Found in hex form in kernel source.
+Licence: Redistributable. See LICENCE.ti-tspa for details. Marked:
+	 Copyright (C) 2023 - 2024 Texas Instruments
 
 --------------------------------------------------------------------------
 
@@ -7397,10 +7395,8 @@ File: ti/tas2563/INT8866RCA2.bin
 Link: TAS2XXX3870.bin -> ti/tas2563/TAS2XXX3870.bin
 Link: INT8866RCA2.bin -> ti/tas2563/INT8866RCA2.bin
 
-Licence: Allegedly GPLv2+, but no source visible. Marked:
-	 Copyright (C) 2023 Texas Instruments
-
-Found in hex form in kernel source.
+Licence: Redistributable. LICENCE.ti-tspa for details. Marked:
+	 Copyright (C) 2023 - 2024 Texas Instruments
 
 --------------------------------------------------------------------------
 
-- 
2.34.1


