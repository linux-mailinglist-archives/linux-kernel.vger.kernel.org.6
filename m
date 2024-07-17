Return-Path: <linux-kernel+bounces-254677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0371D933646
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F795B2206A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A71ABA5E;
	Wed, 17 Jul 2024 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sIDoK+Tc"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78230AD5A;
	Wed, 17 Jul 2024 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721193035; cv=none; b=l+TmN/iU9jwGOdYYtXwSC0EhUa6c0szsByt+Mo8PWGRCnlZ3jRKdWj+az5xpZ7zAf5N4WP4LfurliYCQGOM30yZI5lHXZUCqXpmzvtoHIjG0L+5CDtw9fFkZw//W5VtKtgtpyTh9vuP8b3E+mROfTnoVaH5Q0Ee7mjRoLkxNmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721193035; c=relaxed/simple;
	bh=+u5nnLKYwp/6wtiocm4ix8p6rvb0RiPBvJ5u7yHI1Ds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hA9CBcdYSwJuPxk7ePpf5Acbw5JnHYoTvzqZ3rlahiRpFLohUMO7BCp1A70GM2uNUc60BTdzHCmmtfGDVCnRE9sF2Jc9cJd6cpw+W+YNXFKBf8dMZq+iKC/3WG9Ez4tn9Bipmar16Wvy2qhH8sGbGYaRUp8tbSyxAaeT/wpXIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sIDoK+Tc; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46H59Sfh122485;
	Wed, 17 Jul 2024 00:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721192968;
	bh=7L9STx9OurQV4QAGt/5PU0GHa7eFyMMm4I1geDhiLs4=;
	h=From:To:CC:Subject:Date;
	b=sIDoK+TcDsMwAME5uWkpoADtUx1vsibkln8lIq0h+axf+5HGeozyZpQuP3O66AqeB
	 T6FQtC+FX0Je7JZ+Tiv8zCzV+2+a6DZKfKwpskJKya+DOfSH5/1gj/RZU8IPp1mNYf
	 1yxhpP1r7QDI3EVGFi+ryr/2iHOvRFFhSNAgGgDU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46H59SbT043198
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jul 2024 00:09:28 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jul 2024 00:09:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jul 2024 00:09:28 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.243])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46H59NEA011177;
	Wed, 17 Jul 2024 00:09:24 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-firmware@kernel.org>
CC: <zigo@debian.org>, <baojun.xu@ti.com>, <13564923607@139.com>,
        <v-po@ti.com>, <linux-sound@vger.kernel.org>, <robinchen@ti.com>,
        <linux-kernel@vger.kernel.org>, <mimperial@lenovo.com>,
        <cchen50@lenovo.com>, <soyer@irl.hu>, <stuart.a.hayhurst@gmail.com>,
        <navada@ti.com>, Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v1] ASoC: tas2781: fix the license issue for tas781 firmware
Date: Wed, 17 Jul 2024 13:09:18 +0800
Message-ID: <20240717050919.692-1-shenghao-ding@ti.com>
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
v1:
 - Remove the GPL-2+ and fix the license issue.
 - Update the year of copyright.
---
 WHENCE | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/WHENCE b/WHENCE
index b2fc018..b5b12c2 100644
--- a/WHENCE
+++ b/WHENCE
@@ -7384,8 +7384,8 @@ Link: TAS2XXX38E0.bin -> ti/tas2781/TAS2XXX38E0.bin
 Link: TIAS2781RCA2.bin -> ti/tas2781/TIAS2781RCA2.bin
 Link: TIAS2781RCA4.bin -> ti/tas2781/TIAS2781RCA4.bin
 
-Licence: Allegedly GPLv2+, but no source visible. Marked:
-	 Copyright (C) 2023 Texas Instruments
+Licence: Allegedly LICENCE.ti-tspa, but no source visible. Marked:
+	 Copyright (C) 2023 - 2024 Texas Instruments
 
 Found in hex form in kernel source.
 
@@ -7397,8 +7397,8 @@ File: ti/tas2563/INT8866RCA2.bin
 Link: TAS2XXX3870.bin -> ti/tas2563/TAS2XXX3870.bin
 Link: INT8866RCA2.bin -> ti/tas2563/INT8866RCA2.bin
 
-Licence: Allegedly GPLv2+, but no source visible. Marked:
-	 Copyright (C) 2023 Texas Instruments
+Licence: Allegedly LICENCE.ti-tspa, but no source visible. Marked:
+	 Copyright (C) 2023 - 2024 Texas Instruments
 
 Found in hex form in kernel source.
 
-- 
2.34.1


