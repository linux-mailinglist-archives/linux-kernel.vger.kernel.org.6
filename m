Return-Path: <linux-kernel+bounces-569640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342AA6A58B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1974A885A42
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32197227E9F;
	Thu, 20 Mar 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="Yrt1Zcua"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34BC2248BE;
	Thu, 20 Mar 2025 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471399; cv=none; b=d8jr8dF/56fJw+XleesH3CTo8/UP99uSHj2ydoAlq0fbwi621eMMWR374l0xfREfPwl8CLn5fLJ1L7AaYx7XiBxy9WJdQxKpN4S62xokm1MYiRqo5va4IJluIBLwG38Mh/rnS4Kyur8D4aPJTvgpD+iKDbKQaTmL4AOm3MuVF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471399; c=relaxed/simple;
	bh=4w59+wJqTohRxc+N5ZtS0T9I/Thj8vwf9kdSOpRZL/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h6Bmc0Q7CH7i+k0/Cug2dpv5X7WmxbgHe5pv6AQ6ZGwuZcSqxjXWbpqHT7PioyCLoiCjS5eEb744PyzFBwWuB0n4EMoPI2kRfM6EFBRJoSWxbA+isyNpqayYQWWFHpU43Fde7DYk9UbD/2mDoO7isWn6kdalv3soQDW5oVOVL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=Yrt1Zcua; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K5Ntgc021993;
	Thu, 20 Mar 2025 11:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=y
	wDQS3TEICVkFpyU1IANjP3F5baWDkaiJ57bVe+Bzdc=; b=Yrt1ZcuaQgbuWu3F3
	ifir/S2Iw65Gu0mZTKau8c4KEGjOdENMKcykLWwZk6zLJzDDV2QJT1VM8VcNa/zl
	hBiIGNu5qa02/SPY9VsT8X43SStQA8gaD7OcRvnegnKoM/baxAfHrjJUpvNVEx4Q
	MXTcWd74Don7jA5k+3z5xfHiRZJ/c328/30MjByecOf8dL9K/R9CDvJtq2qGjO4t
	mBcHXTWXcqRvxU/E3AmSYHPAg03KbVDePcxBNW4OnKYVWbisV5H9bi1Nv70pIVZY
	N87ibe9j5hAWZodYOFy4lQuPzbhvd8qFmlLslAkI05sdBgiTPJbcAgSDgxP78Cd9
	oh7ig==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 45d2h1kwg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Mar 2025 11:32:28 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.0.133) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 11:32:27 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Thu, 20 Mar 2025 11:32:16 +0000
Subject: [PATCH v4 06/18] drm/imagination: Mask GPU IRQs in threaded
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250320-sets-bxs-4-64-patch-v1-v4-6-d987cf4ca439@imgtec.com>
References: <20250320-sets-bxs-4-64-patch-v1-v4-0-d987cf4ca439@imgtec.com>
In-Reply-To: <20250320-sets-bxs-4-64-patch-v1-v4-0-d987cf4ca439@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=eC25C/T7YrBtcMuUr5aF0H552IrNwIQ79drEEVwOlX8=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaTf/nNESYtxh7L2xit1Z1z7feVXX1Usf6G26Hq/4LL0F
 bye/BnrOkpZGMQ4GGTFFFl2rLBcofZHTUvixq9imDmsTCBDGLg4BWAiTz8w/BXRufNq2vfVS6bZ
 fjxWq/u1NCZ9T5nQfuOuVR1my0J/Jmkw/GZ5sqelbvWK6+J3Zpjo6x1ZVyBcZ7psmp60v3d3r0n
 bLxYA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: V_L_Fbytshy73OFHQ0uAdojkQvO8le3c
X-Proofpoint-ORIG-GUID: V_L_Fbytshy73OFHQ0uAdojkQvO8le3c
X-Authority-Analysis: v=2.4 cv=V8Z90fni c=1 sm=1 tr=0 ts=67dbfccc cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=ETbM1kImDFEA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=MXbv0OSQah28ATDbmwsA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22

From: Alessio Belle <alessio.belle@imgtec.com>

Pass IRQF_ONESHOT flag to request_threaded_irq(), so that interrupts will
be masked by the kernel until the end of the threaded IRQ handler. Since
the calls to pvr_fw_irq_enable() and pvr_fw_irq_disable() are now
redundant, remove them.

Interrupts to the host from the soon-to-be-added RISC-V firmware
processors cannot be masked in hardware. This change allows us to continue
using the threaded handler in GPUs with a RISC-V firmware.

For simplicity, the same approach is taken for all firmware processors.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v4:
- None
- Link to v3: https://lore.kernel.org/r/20250310-sets-bxs-4-64-patch-v1-v3-6-143b3dbef02f@imgtec.com
Changes in v3:
- Added
---
 drivers/gpu/drm/imagination/pvr_device.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 1704c0268589bdeb65fa6535f9ec63182b0a3e94..b6ce936f07c8bb26d240e50b72a1d991dbe4b045 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -169,8 +169,6 @@ static irqreturn_t pvr_device_irq_thread_handler(int irq, void *data)
 		ret = IRQ_HANDLED;
 	}
 
-	/* Unmask FW irqs before returning, so new interrupts can be received. */
-	pvr_fw_irq_enable(pvr_dev);
 	return ret;
 }
 
@@ -181,10 +179,6 @@ static irqreturn_t pvr_device_irq_handler(int irq, void *data)
 	if (!pvr_fw_irq_pending(pvr_dev))
 		return IRQ_NONE; /* Spurious IRQ - ignore. */
 
-	/* Mask the FW interrupts before waking up the thread. Will be unmasked
-	 * when the thread handler is done processing events.
-	 */
-	pvr_fw_irq_disable(pvr_dev);
 	return IRQ_WAKE_THREAD;
 }
 
@@ -213,9 +207,13 @@ pvr_device_irq_init(struct pvr_device *pvr_dev)
 	pvr_fw_irq_clear(pvr_dev);
 	pvr_fw_irq_enable(pvr_dev);
 
+	/*
+	 * The ONESHOT flag ensures IRQs are masked while the thread handler is
+	 * running.
+	 */
 	return request_threaded_irq(pvr_dev->irq, pvr_device_irq_handler,
 				    pvr_device_irq_thread_handler,
-				    IRQF_SHARED, "gpu", pvr_dev);
+				    IRQF_SHARED | IRQF_ONESHOT, "gpu", pvr_dev);
 }
 
 /**

-- 
2.49.0


