Return-Path: <linux-kernel+bounces-396756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBBB9BD196
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DF3283303
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBD31E9094;
	Tue,  5 Nov 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="UKjW+i+L"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50417DE06;
	Tue,  5 Nov 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822393; cv=none; b=GkkVK//4mE049Vg9+XsU98/47+MAGyeuZAJDhBsufTLEOPXCeB88e8DseoeSmjBFrAiOA3XAV06xQskhsrWVDK8jfv60Hb5Ku5j5GF9bfeXDCIvVk50NvASjUlvXk2uASBjTkvmNk7BD1FST/elcOHWW0n0JBL8KdA7SZRQt+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822393; c=relaxed/simple;
	bh=mhj9qzB4F/27DhRif7aHavNUs3MTmjLQ5Y75yR8FQg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ApHKi6AFuSSEe4U5pG3Qn6EhWrX6sIZE5KZXIVmpHCF3rTj6LGvHk7ztqpgC+XOyNeliTePdyS/Suygy9UnYfYoXVvst85BV/2RbvDqHn8iJ50BraLAx2oNIaqM77NOy1Im9ZXxwI8ZZZSudEPzJsF9V2/MR16dgvYhX9SM4ySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=UKjW+i+L; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5EF3v4003827;
	Tue, 5 Nov 2024 15:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=o
	yQk52fjfjov/TTmy0J8enqdMCQvCuXWq/70BrSA3dk=; b=UKjW+i+LyaojuTL5C
	Kikja5WdOeklNG8p6vGGdJwGcd6MR6kZew65BiuFihK0dUWyP7tx1xIKC2q1/gqX
	fjRs+RUvGyVcvqe89VOjvCeXk8OJlELODD+cAlHmulWjWLDEZJvVgFZmziPxyk+1
	DsXwbmI+dydAQr8cgPMbuXBDLsUnqdtcTYvfK1cpkxQSfxGb0LGmrgp0tcm7QRrf
	cIRDMEKCT0MNyMHZcFHCT1w0sQGxhVLCr83YG8sIgCkj2uQOjmHbZuRVMXNMdc2P
	5O1jX+IugcQph4HOaFDbduvpn+EL3+8IDUkiV8nsJgPAV+RxbAiMEvZ2a6qmfJRA
	5LqbQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 42nb7wta0s-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 15:58:28 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 5 Nov 2024 15:58:27 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Tue, 5 Nov 2024 15:58:11 +0000
Subject: [PATCH 05/21] drm/imagination: Use more specific compatible
 strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241105-sets-bxs-4-64-patch-v1-v1-5-4ed30e865892@imgtec.com>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
In-Reply-To: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
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
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=mhj9qzB4F/27DhRif7aHavNUs3MTmjLQ5Y75yR8FQg4=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRrOcxlfrNgz+8ZWl4pW9w01MqWbbx/7oOYypkFDnWpU
 6qWWk6+3lHKwiDGwSArpsiyY4XlCrU/aloSN34Vw8xhZQIZwsDFKQATOfOa4X/B6h1r+Xs7Xuu7
 yEn/2HEpvuLuhu31nLtuv3h4KrZ0FudDRoY7/SK5ASVuHxprLAyNF+TbPhHTmB0czVjsWVDtILR
 3EzcA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=ddzS3mXe c=1 sm=1 tr=0 ts=672a40a4 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=r_1tXGB3AAAA:8 a=6TxX0kamTyKH95WNaFsA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: iVbBUY6VW6vbtndNjdQaHzxvdKF4kIJA
X-Proofpoint-ORIG-GUID: iVbBUY6VW6vbtndNjdQaHzxvdKF4kIJA

Follow-on from the companion dt-bindings change ("dt-bindings: gpu: img:
More explicit compatible strings"), deprecating "img,img-axe" in favour of
the more specific "img,img-axe-1-16m".

Keep the previous compatible string around for backwards compatibility.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 684a9b9a2247b8f5b0f4a91ec984af2cff5a4c29..fbd8802abcf1271e260209957d95ea705dbe7f14 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1471,6 +1471,16 @@ static void pvr_remove(struct platform_device *plat_dev)
 }
 
 static const struct of_device_id dt_match[] = {
+	{ .compatible = "img,img-rogue", .data = NULL },
+
+	/* All supported GPU models */
+	{ .compatible = "img,img-axe-1-16m", .data = NULL },
+
+	/*
+	 * This legacy compatible string was introduced early on before the more specific GPU
+	 * identifiers were used. Keep it around here for compatibility, but never use
+	 * "img,img-axe" in new devicetrees.
+	 */
 	{ .compatible = "img,img-axe", .data = NULL },
 	{}
 };

-- 
2.47.0


