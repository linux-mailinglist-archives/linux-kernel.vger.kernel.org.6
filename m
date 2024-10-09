Return-Path: <linux-kernel+bounces-356807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32397996709
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE161F26556
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAA1189520;
	Wed,  9 Oct 2024 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C+a9xtKX"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B213918FDD0;
	Wed,  9 Oct 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469300; cv=none; b=Ogp1b2rFPgc+DWCj8GRMI92APy3So7/YNahrHuRzg9ZR44/r9DM2AaxLhZlwCk8AytLOd5JnrRdyW2LgGimpEctzEIot/JJ8Z2MOP05rg68/OIJJ2m6xd/y8McRN+4ZNbzyyRcFoxZkJfB4oz1Ooev2iQpGbqSbfexfof3FUx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469300; c=relaxed/simple;
	bh=eLmxVvpqAJZvk2947HsSg6d5m7wmY6HauGswzFdldMo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NZqAdzd04Gpf6ez1s5TzU05XV12y7EkMze5BYy85sUMxNjZvTnVxl3CMN8NCCwWtlkl7HYr2E0a1kRquV26t3nWgUvgnd+aejL9ccyBBE5ipopR0Nr7B0ZIBysMhjS+uLy4z0wirw3zd/dXznpiLNDxngr9yyTwFTqQ/YJWFKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C+a9xtKX; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 499AIIhC053118;
	Wed, 9 Oct 2024 05:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728469098;
	bh=2x7pjOR+UZM+R8Ptic3xXN9W+OZrURWJaft0V2hCinw=;
	h=From:To:CC:Subject:Date;
	b=C+a9xtKXFiWhVvgh113ayZXGwb3COeX1vlyRe4LYKmLkQDEUD+k4L0OmrYustoyhL
	 Yjx7qOBSgfM17bSBAs3Vr7m4m/MKI2vhycHF+wJRU1U+3eCaAWTGCjmplvtHJj5INl
	 cx6eg8YFqaAW514DeBdl7RKj7+BeLizb2GwHdtgE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 499AIIja029733
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Oct 2024 05:18:18 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Oct 2024 05:18:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Oct 2024 05:18:18 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.191])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 499AICRw084727;
	Wed, 9 Oct 2024 05:18:13 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-firmware@kernel.org>
CC: <baojun.xu@ti.com>, <derekjohn.clark@gmail.com>, <13916275206@139.com>,
        <romangg@manjaro.org>, <linux-sound@vger.kernel.org>,
        <robinchen@ti.com>, <linux-kernel@vger.kernel.org>, <k-yi@ti.com>,
        <navada@ti.com>, <philm@manjaro.org>, <jlobue10@gmail.com>,
        <luke@ljones.dev>, <antheas.dk@gmail.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] Upload dsp firmware for ASUS laptop 1EB30 & 1EB31 and Update WHENCE for both
Date: Wed, 9 Oct 2024 18:18:05 +0800
Message-ID: <20241009101807.1473-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 WHENCE                     |   4 ++++
 ti/tas2781/TAS2XXX2234.bin | Bin
 2 files changed, 4 insertions(+)
 mode change 100644 => 100755 ti/tas2781/TAS2XXX2234.bin

diff --git a/WHENCE b/WHENCE
index a9c8bb5..00096eb 100644
--- a/WHENCE
+++ b/WHENCE
@@ -7487,6 +7487,8 @@ Originates from https://git.codelinaro.org/linaro/qcomlt/audioreach-topology.git
 --------------------------------------------------------------------------
 
 Driver: ti-tas2781 - tas2781 firmware
+File: ti/tas2781/TAS2XXX1EB30.bin
+File: ti/tas2781/TAS2XXX1EB31.bin
 File: ti/tas2781/TAS2XXX2234.bin
 File: ti/tas2781/TAS2XXX387D.bin
 File: ti/tas2781/TAS2XXX387E.bin
@@ -7516,6 +7518,8 @@ File: ti/tas2781/TAS2XXX38DF.bin
 File: ti/tas2781/TAS2XXX38E0.bin
 File: ti/tas2781/TIAS2781RCA2.bin
 File: ti/tas2781/TIAS2781RCA4.bin
+Link: TAS2XXX1EB30.bin -> ti/tas2781/TAS2XXX1EB30.bin
+Link: TAS2XXX1EB31.bin -> ti/tas2781/TAS2XXX1EB31.bin
 Link: TAS2XXX2234.bin -> ti/tas2781/TAS2XXX2234.bin
 Link: TAS2XXX387D.bin -> ti/tas2781/TAS2XXX387D.bin
 Link: TAS2XXX387E.bin -> ti/tas2781/TAS2XXX387E.bin
diff --git a/ti/tas2781/TAS2XXX2234.bin b/ti/tas2781/TAS2XXX2234.bin
old mode 100644
new mode 100755
-- 
2.34.1


