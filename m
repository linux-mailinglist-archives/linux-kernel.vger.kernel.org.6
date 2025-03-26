Return-Path: <linux-kernel+bounces-577386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB086A71C69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8695817C951
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F6E1FE46F;
	Wed, 26 Mar 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="YHXdEvNf"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0B1F91F3;
	Wed, 26 Mar 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007765; cv=none; b=qSA2mZex7hSdeomhUSWbUBqddeAzs5MUhvhWE4trvNjZJWZ1byX6GLcT71xtm+ZHLQtElR3yL7NIfuevG9CNzyEF+CCL2nn69zLUt6kwimm00HfL2XSJ7tscxB0Ue7kh9XO5Q3OCe4Psi0ZLw86J0n6Kuz9h0LH6PflTlVrT9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007765; c=relaxed/simple;
	bh=AiV3JtqpuKX4w4TzhqQhNz5mqpYDAlaAlzR9okWvUas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AGZrBo7cAT3zA61jbdXW4Tz8YnAVCTFBU3btmfGagwA6SuiKTV1BVmHenI+6lx76u+u+B/Y93daphIRnRlcFrqvs4poryzWtGEIWL+GHgYhCQUefh21oZLjTb6piKDPHJbhtOTOprW0VHfPPdDOVt0d+t+Xlm2nVFxanBi55M30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=YHXdEvNf; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QBt2Sp012691;
	Wed, 26 Mar 2025 16:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=L
	SUA1zThrdwdUlQspKjbmzFvYxGIaR7/+vnlWfD1acI=; b=YHXdEvNf1QXeUr3+f
	dJ0397Zem+eVE9bwJcfByk056qVKQSW+un4b5mni3yzdOd+45xVQHt8THkeDZvSG
	Oqa0FVQXyu3fcRkWRqkXISszczvY0Vw3Af9NLCXykfT4jVScurc0IaVb64u0VkHa
	fHcecA0wrhhUc86rqEGwYUxMXlq8r+vaBXdtZWeGHGcXwLLI7rTW4P/+VirKCx2l
	332+X0zxH6GlMQWi2S4hihQxQsd/qrSxV5oJ7GArDM+sqwK8OCWKUofpOHZ9W7h2
	1nazvMK/4SQVaagOgJphN1wvKFSU983sbQveqw7jkYO37e3H/se9sfz+gFipnW8J
	aZ+WA==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 45kbmy9d6d-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 26 Mar 2025 16:49:02 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.0.133) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 16:48:53 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Wed, 26 Mar 2025 16:48:37 +0000
Subject: [PATCH DO NOT MERGE v5 17/18] arm64: dts: ti: k3-am62: New GPU
 binding details
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250326-sets-bxs-4-64-patch-v1-v5-17-e4c46e8280a9@imgtec.com>
References: <20250326-sets-bxs-4-64-patch-v1-v5-0-e4c46e8280a9@imgtec.com>
In-Reply-To: <20250326-sets-bxs-4-64-patch-v1-v5-0-e4c46e8280a9@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>,
        "Michal
 Wilczynski" <m.wilczynski@samsung.com>,
        Alessio Belle
	<alessio.belle@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=AiV3JtqpuKX4w4TzhqQhNz5mqpYDAlaAlzR9okWvUas=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaQ/0X/2xFifk7voZ9WZxoMvSozkVxhGMSnNnxb12JFJ1
 8POKUSgo5SFQYyDQVZMkWXHCssVan/UtCRu/CqGmcPKBDKEgYtTACZyci0jw/XG6W8dhX7Mn+Vk
 rakW/NEqiPta7dtLs9xUj8kuX3/pZgjDX6lzm9xsj4ccn3H65aYJFXNXGeedz9399OFzph2qCd0
 bZ/ACAA==
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: U_OTcN-_xOCu4tQDDwLneFQVcMEy5-aR
X-Authority-Analysis: v=2.4 cv=L+sdQ/T8 c=1 sm=1 tr=0 ts=67e42ffe cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=ETbM1kImDFEA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=OLj8r6_nq0VfqmG8xPEA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: U_OTcN-_xOCu4tQDDwLneFQVcMEy5-aR

Use the new compatible string introduced earlier (in "dt-bindings: gpu:
img: More explicit compatible strings") and add a name to the single power
domain for this GPU (introduced in "dt-bindings: gpu: img: Power domain
details").

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v5:
- None
- Link to v4: https://lore.kernel.org/r/20250320-sets-bxs-4-64-patch-v1-v4-17-d987cf4ca439@imgtec.com
Changes in v4:
- None
- Link to v3: https://lore.kernel.org/r/20250310-sets-bxs-4-64-patch-v1-v3-17-143b3dbef02f@imgtec.com
Changes in v3:
- None
- Link to v2: https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-7-3fd45d9fb0cf@imgtec.com
Changes in v2:
- None
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-7-4ed30e865892@imgtec.com
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 7d355aa73ea2116723735f70b9351cefcd8bc118..d17b25cae196b08d24adbe7c913ccaba7eed37eb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -691,12 +691,14 @@ ospi0: spi@fc40000 {
 	};
 
 	gpu: gpu@fd00000 {
-		compatible = "ti,am62-gpu", "img,img-axe";
+		compatible = "ti,am62-gpu", "img,img-axe-1-16m", "img,img-axe",
+			     "img,img-rogue";
 		reg = <0x00 0x0fd00000 0x00 0x20000>;
 		clocks = <&k3_clks 187 0>;
 		clock-names = "core";
 		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
+		power-domain-names = "a";
 	};
 
 	cpsw3g: ethernet@8000000 {

-- 
2.49.0


