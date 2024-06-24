Return-Path: <linux-kernel+bounces-226746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C43CD914304
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0F21F23DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD4938FA3;
	Mon, 24 Jun 2024 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d/WVlL9c"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCF18AE4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719211945; cv=none; b=CP68TRg82I8zQU0lvxddJnc4WtxHWjCBj5BJW21ECLPz20qJ8BfAeLjlpTjRBgD20jUQn2HORPf4QG2/tO5bhoIxxRdfkkMF91Sf/G/nvAk3A4dagZc0IpjfRyhvCIAnUYOhnY8jGkNoKI6lEA7GACsWbIKLGnFfJNcZJrSwtFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719211945; c=relaxed/simple;
	bh=eY3vBvoy7ECqVBDFC1VJsM3NLvWJAEShoV4q5XmQ3M4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y69hK4lJX73woh3JedpWFqlaWsBmtFPKoRHMlLStidW70ZGv6JoubLhI6Y3+UnVYOF+fL9qQt28458wUSz0+QIUMt+JMrWHWP50yAu0ifEb5edEGanP6P+oyqeOEYuYw3ER4MYoIwS4tz5Vj9A4kOCTHfX+hBRlJCUdxIzJRxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d/WVlL9c; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45O6q8Yt071112;
	Mon, 24 Jun 2024 01:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719211928;
	bh=cY/MgF7N4sFebIcXMFWZ9VzMKJ35Y3rtq3CJoSCZ9FY=;
	h=From:To:CC:Subject:Date;
	b=d/WVlL9cz4BOau0K9soTtBdTGA3CRz5CrLQRymNUhQ303VKyV38rMzTnOP43eicbp
	 Q5q2eLfxROEArDJQzlCYakW62aSpVuaEtGNbPEs+9zA2fqgQOoaCkom9PDHoAqNUTJ
	 2TWk5Br3Y6HQ1ZBTXiPnNuJTD0iHxSpIKKayzrlU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45O6q8qv014772
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Jun 2024 01:52:08 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 01:52:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jun 2024 01:52:08 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45O6q6wg006595;
	Mon, 24 Jun 2024 01:52:06 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <nm@ti.com>, <ssantosh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH] soc: ti: k3-socinfo: Add J721E SR2.0
Date: Mon, 24 Jun 2024 12:22:05 +0530
Message-ID: <20240624065205.718449-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support to detect J721E SR2.0

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 59101bf7cf23..4fb0f0a24828 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -61,7 +61,7 @@ static const struct k3_soc_id {
 };
 
 static const char * const j721e_rev_string_map[] = {
-	"1.0", "1.1",
+	"1.0", "1.1", "2.0",
 };
 
 static int
-- 
2.34.1


