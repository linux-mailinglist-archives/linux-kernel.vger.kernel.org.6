Return-Path: <linux-kernel+bounces-177428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE418C3E78
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9591F223A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AE8149DEE;
	Mon, 13 May 2024 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="inYDeJkN"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74314885F;
	Mon, 13 May 2024 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594263; cv=none; b=SXg4xxpNf7IrW7xePelx9yCjai2rYxkB5q9qEVmaDXIDa0Y4nGaUKB85Nx4ANKwcWq0Qc1ht/qqNUZfx/yMdNgC63WufJT80JaqBvqdJY8hLuHm/gfzSBIUfyp/1UuAnYpi2Mk8VUGMp6x27/3CrzGVErqOt+Y5EfDkPjVhry8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594263; c=relaxed/simple;
	bh=ONXTzfoVpAqJAl3Cy8PPEfPis15j61KbxftW3XHUqAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFfh6gXYtZJ6jrtYH+qfYvLQZVGGzvsI5Ajdae9RcO6AUL4OP8U40mAUUsh6rNqX68DXz1EJdc6KwXvqjuvisW6sZes2JDffdUaqJ46DFwB8B6Hd/BSDqjOw9s8Fgq/avNLYSIiny6xL6+Qtqb+IL3SBO6l0Xfh9bImiK7/XCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=inYDeJkN; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D7IReu005135;
	Mon, 13 May 2024 11:57:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=Xyl2llGqcawjv/NLOJHJO+piLXi1kTJoDevxVAPcFnM=; b=in
	YDeJkNHAev0SEhvOZI009DKhYm8aRhZeRAK2jrD0X3y20P4CZ+vhAaDvoFAVJOjy
	vyJoJKcgTzoRB5KBH2WDO/soFxHjAwu7fAyfkUz0Q0YYDwjW2qsiiUYfFkbD0orn
	HcCCxmcNplPpy5Kog9cHwoZz7mhReaSxsXE3ZQGS67kZrOZY0H9SWnNjLmq2nzHn
	BiGuVx0E2X1ydCaJM4L9BDwZ8ncml/mPJLd8wCWmtmKJklNgQKRPYMEIrdyeP8zO
	pXVL7amZdBZdoYnbWaer6HiOfxnwOwkvZyPHXEWpF04Z3qIjbukAkSe6/efnWaPA
	a595eYpGP83YmGQJlX3w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y1y8gnhw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 11:57:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DA91C40057;
	Mon, 13 May 2024 11:57:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0908F21660C;
	Mon, 13 May 2024 11:56:33 +0200 (CEST)
Received: from localhost (10.48.87.205) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 11:56:32 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal
 Paillet <p.paillet@foss.st.com>
CC: Marek Vasut <marex@denx.de>,
        Patrick Delaunay
	<patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v3 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add compatible for STM32MP13
Date: Mon, 13 May 2024 11:56:04 +0200
Message-ID: <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_06,2024-05-10_02,2023-05-22_02

Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v3:
- Replace oneOf/const by enum; solve the V2 issues for dt_binding_check

Changes in v2:
- update for Rob review, only add compatible for STM32MP13 family

 .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
index c9586d277f41..c766f0a15a31 100644
--- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32mp1,pwr-reg
+    enum:
+      - st,stm32mp1,pwr-reg
+      - st,stm32mp13-pwr-reg
 
   reg:
     maxItems: 1
-- 
2.25.1


