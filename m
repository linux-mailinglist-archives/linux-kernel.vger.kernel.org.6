Return-Path: <linux-kernel+bounces-278995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20A94B77D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF19A287172
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB6190054;
	Thu,  8 Aug 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J4oT5Fvj"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5518F2C5;
	Thu,  8 Aug 2024 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101128; cv=none; b=o0OeVVIhzjYqoWPrfsoBehNx9AOdgN8NLppRTQMTJoHny21rD22avBm1LVIX+fl/pmc6lXxWikeW1xk5oTylktEi6JLsGgan/S6KxrW/Mu8bzvIm1J17LFyLGzxvh1EEpf0IwVl7ceep/zazrMvQ7nKWTWfAhoq7zNQ2qEze7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101128; c=relaxed/simple;
	bh=F8s6yzp64tr+2GEhxFD3mLAG4D1Hq5C+3bSsnp4ihyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALwbwW6DrVXGKURiuQAQhxWL0CCFCN2Qjr+aIQnIyFMbWk+vyjW4hkqCUlWvfbBV8kAxWMWmdVKj1mN9RdCCYtvlon+p5rVPwINP45jueD7ZmezXUUqfRejzcjqHzQK1LTuyjjPesoaiMJ1EAwu2LEbQUF4bgWCr0F1a9SCp10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J4oT5Fvj; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 9A51AC0011;
	Thu,  8 Aug 2024 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRmg897+NKdDYmLNDqHaxye34rUwBmU1XumvUwBt0Ek=;
	b=J4oT5FvjNo9S+QOAGvFSsy7inqi3Nws/oy5rf2sCtqrJ3Mb4+HI0NXSfasWDONj8NNNKF9
	dJo6Wx0iCt/8agnYemkvO2nd6ynD0LlutlNnYXf6TFgFl+Yn7tRuw8y4++DRU9cHZTL9XA
	5Wyk7/O+InHXW3wU9U/4DinjI93dmyGSbRY4ogyy2xgnfPfOMqZMPrbmEs5/ZE7UpCTgvO
	kmpWZFmIEdYxmcOE9WuKC1PjzxLo/MmdGo2bwweyWFS9+cuISDajQDEbR9WjFNE1DK0/F9
	e8hA44la4ZmvNg8NUmkgfOdu30a9CHj2688fhDOrXm0RH8U1vo1MzKJehIW0BQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 32/36] soc: fsl: qe: Add resource-managed muram allocators
Date: Thu,  8 Aug 2024 09:11:25 +0200
Message-ID: <20240808071132.149251-33-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Introduce devm_cpm_muram_alloc() and devm_cpm_muram_alloc_fixed(), the
resource-managed version of cpm_muram_alloc and cpm_muram_alloc_fixed().

These resource-managed versions simplify the user avoiding the need to
call cpm_muram_free(). Indeed, the allocated area returned by these
functions will be automatically freed on driver detach.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qe_common.c | 80 ++++++++++++++++++++++++++++++++++
 include/soc/fsl/qe/qe.h        | 22 +++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index a877347d37d3..02c29f5f86d3 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -13,6 +13,7 @@
  * 2006 (c) MontaVista Software, Inc.
  * Vitaly Bordug <vbordug@ru.mvista.com>
  */
+#include <linux/device.h>
 #include <linux/genalloc.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -187,6 +188,49 @@ void cpm_muram_free(s32 offset)
 }
 EXPORT_SYMBOL(cpm_muram_free);
 
+static void devm_cpm_muram_release(struct device *dev, void *res)
+{
+	s32 *info = res;
+
+	cpm_muram_free(*info);
+}
+
+/**
+ * devm_cpm_muram_alloc - Resource-managed cpm_muram_alloc
+ * @dev: Device to allocate memory for
+ * @size: number of bytes to allocate
+ * @align: requested alignment, in bytes
+ *
+ * This function returns a non-negative offset into the muram area, or
+ * a negative errno on failure as cpm_muram_alloc() does.
+ * Use cpm_muram_addr() to get the virtual address of the area.
+ *
+ * Compare against cpm_muram_alloc(), the memory allocated by this
+ * resource-managed version is automatically freed on driver detach and so,
+ * cpm_muram_free() must not be called to release the allocated memory.
+ */
+s32 devm_cpm_muram_alloc(struct device *dev, unsigned long size,
+			 unsigned long align)
+{
+	s32 info;
+	s32 *dr;
+
+	dr = devres_alloc(devm_cpm_muram_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	info = cpm_muram_alloc(size, align);
+	if (info >= 0) {
+		*dr = info;
+		devres_add(dev, dr);
+	} else {
+		devres_free(dr);
+	}
+
+	return info;
+}
+EXPORT_SYMBOL(devm_cpm_muram_alloc);
+
 /*
  * cpm_muram_alloc_fixed - reserve a specific region of multi-user ram
  * @offset: offset of allocation start address
@@ -211,6 +255,42 @@ s32 cpm_muram_alloc_fixed(unsigned long offset, unsigned long size)
 }
 EXPORT_SYMBOL(cpm_muram_alloc_fixed);
 
+/**
+ * devm_cpm_muram_alloc_fixed - Resource-managed cpm_muram_alloc_fixed
+ * @dev: Device to allocate memory for
+ * @offset: offset of allocation start address
+ * @size: number of bytes to allocate
+ *
+ * This function returns a non-negative offset into the muram area, or
+ * a negative errno on failure as cpm_muram_alloc_fixed() does.
+ * Use cpm_muram_addr() to get the virtual address of the area.
+ *
+ * Compare against cpm_muram_alloc_fixed(), the memory allocated by this
+ * resource-managed version is automatically freed on driver detach and so,
+ * cpm_muram_free() must not be called to release the allocated memory.
+ */
+s32 devm_cpm_muram_alloc_fixed(struct device *dev, unsigned long offset,
+			       unsigned long size)
+{
+	s32 info;
+	s32 *dr;
+
+	dr = devres_alloc(devm_cpm_muram_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	info = cpm_muram_alloc_fixed(offset, size);
+	if (info >= 0) {
+		*dr = info;
+		devres_add(dev, dr);
+	} else {
+		devres_free(dr);
+	}
+
+	return info;
+}
+EXPORT_SYMBOL(devm_cpm_muram_alloc_fixed);
+
 /**
  * cpm_muram_addr - turn a muram offset into a virtual address
  * @offset: muram offset to convert
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index af793f2a0ec4..629835b6c71d 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -23,6 +23,8 @@
 #include <linux/of_address.h>
 #include <linux/types.h>
 
+struct device;
+
 #define QE_NUM_OF_SNUM	256	/* There are 256 serial number in QE */
 #define QE_NUM_OF_BRGS	16
 #define QE_NUM_OF_PORTS	1024
@@ -93,8 +95,12 @@ int cpm_muram_init(void);
 
 #if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
 s32 cpm_muram_alloc(unsigned long size, unsigned long align);
+s32 devm_cpm_muram_alloc(struct device *dev, unsigned long size,
+			 unsigned long align);
 void cpm_muram_free(s32 offset);
 s32 cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
+s32 devm_cpm_muram_alloc_fixed(struct device *dev, unsigned long offset,
+			       unsigned long size);
 void __iomem *cpm_muram_addr(unsigned long offset);
 unsigned long cpm_muram_offset(const void __iomem *addr);
 dma_addr_t cpm_muram_dma(void __iomem *addr);
@@ -106,6 +112,12 @@ static inline s32 cpm_muram_alloc(unsigned long size,
 	return -ENOSYS;
 }
 
+static inline s32 devm_cpm_muram_alloc(struct device *dev, unsigned long size,
+				       unsigned long align)
+{
+	return -ENOSYS;
+}
+
 static inline void cpm_muram_free(s32 offset)
 {
 }
@@ -116,6 +128,13 @@ static inline s32 cpm_muram_alloc_fixed(unsigned long offset,
 	return -ENOSYS;
 }
 
+static inline s32 devm_cpm_muram_alloc_fixed(struct device *dev,
+					     unsigned long offset,
+					     unsigned long size)
+{
+	return -ENOSYS;
+}
+
 static inline void __iomem *cpm_muram_addr(unsigned long offset)
 {
 	return NULL;
@@ -172,7 +191,6 @@ static inline int par_io_data_set(u8 port, u8 pin, u8 val) { return -ENOSYS; }
 /*
  * Pin multiplexing functions.
  */
-struct device;
 struct qe_pin;
 #ifdef CONFIG_QE_GPIO
 extern struct qe_pin *qe_pin_request(struct device *dev, int index);
@@ -233,7 +251,9 @@ static inline int qe_alive_during_sleep(void)
 /* we actually use cpm_muram implementation, define this for convenience */
 #define qe_muram_init cpm_muram_init
 #define qe_muram_alloc cpm_muram_alloc
+#define devm_qe_muram_alloc devm_cpm_muram_alloc
 #define qe_muram_alloc_fixed cpm_muram_alloc_fixed
+#define devm_qe_muram_alloc_fixed devm_cpm_muram_alloc_fixed
 #define qe_muram_free cpm_muram_free
 #define qe_muram_addr cpm_muram_addr
 #define qe_muram_offset cpm_muram_offset
-- 
2.45.0


