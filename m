Return-Path: <linux-kernel+bounces-266529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CB894012F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375791F23330
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504818FC88;
	Mon, 29 Jul 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU7zxDBU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8A18FC67
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292630; cv=none; b=WXjKPhI2xvRi79+NpBhq5ZuiV5IVtdjElej8l0381Ekx8ZnC0RwXvR/SX2gNXV/lZVnb0kf4ApF4tyvmzrcbEAFAV+6JpwYuTWDy5Jew1IsTToHbiRHFTuGQFiCepBX32ROKHWERf8SbImK0QG0OS0AmRl5k1XWDplE9VfHdBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292630; c=relaxed/simple;
	bh=IXtp7HqcDIQj4kFmNqFhPVCKm3qy+JfE9YB4r53YkJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5zfquSZhviOzpaWCtwTr4ZN0VqYrZmPWUsnswRRVpJi1E+o/8dd9VbjRT1m/0HkjH2q7KYILz3ukJRUnuA+Lc9usQP8u7HD7PMsNJCm6GehpqjyOcbsVIXEelDMMQGpZXgxDfVgJ17WU9LlDEqihVPp5uSIialf5pmcwFbmG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU7zxDBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44892C4AF09;
	Mon, 29 Jul 2024 22:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292630;
	bh=IXtp7HqcDIQj4kFmNqFhPVCKm3qy+JfE9YB4r53YkJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cU7zxDBUMqoGRm5uAIND0DvLyAbYj3s1CxqRxkIgmWd9WozNrj1w619qDlxJW1/l9
	 Syfrwz9ScitiCZX5UsxNI10d7IHhE3ROojx/s7UBpwIEbAUDqLK+0pmo3PJm3pIk9X
	 fp6QNboBN+HMltlLHpuKlfxiZgDRFMo0oC6uZOVbe84Difz8vJX85OYeoxBWFseL+c
	 NyyEnYrMIgWzuHIi6CcnB1aSSjKlx1tlZBTC8yUjL1McD6kP1DTEVXiJFWgn5+KwIO
	 ijVuF6n4wu6e/lDndEK+dGUhDyw9cvLChEDiWE+vuMYw61We14fHxC0X75AOExfRA/
	 5aCEo0uHnEbGQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Mon, 29 Jul 2024 16:36:44 -0600
Subject: [PATCH 2/2] cxl: Use of_property_ accessor functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-dt-cxl-cleanup-v1-2-a75eea80d231@kernel.org>
References: <20240729-dt-cxl-cleanup-v1-0-a75eea80d231@kernel.org>
In-Reply-To: <20240729-dt-cxl-cleanup-v1-0-a75eea80d231@kernel.org>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

The CXL driver has its own custom implementations of typed DT property
accessors. Replace the custom property accessor functions with the
common DT property functions.

This clean-up is part of a larger effort to remove of_get_property() and
other DT functions which leak pointers to DT node and property data.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/misc/cxl/of.c  | 106 ++++++++++---------------------------------------
 drivers/misc/cxl/pci.c |  32 ++++++---------
 2 files changed, 33 insertions(+), 105 deletions(-)

diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
index 21ecce0f9403..03633cccd043 100644
--- a/drivers/misc/cxl/of.c
+++ b/drivers/misc/cxl/of.c
@@ -7,59 +7,12 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 
 #include "cxl.h"
 
-
-static const __be32 *read_prop_string(const struct device_node *np,
-				const char *prop_name)
-{
-	const __be32 *prop;
-
-	prop = of_get_property(np, prop_name, NULL);
-	return prop;
-}
-
-static const __be32 *read_prop_dword(const struct device_node *np,
-				const char *prop_name, u32 *val)
-{
-	const __be32 *prop;
-
-	prop = of_get_property(np, prop_name, NULL);
-	if (prop)
-		*val = be32_to_cpu(prop[0]);
-	return prop;
-}
-
-static const __be64 *read_prop64_dword(const struct device_node *np,
-				const char *prop_name, u64 *val)
-{
-	const __be64 *prop;
-
-	prop = of_get_property(np, prop_name, NULL);
-	if (prop)
-		*val = be64_to_cpu(prop[0]);
-	return prop;
-}
-
-
-static int read_handle(struct device_node *np, u64 *handle)
-{
-	const __be32 *prop;
-	u64 size;
-
-	/* Get address and size of the node */
-	prop = of_get_address(np, 0, &size, NULL);
-	if (size)
-		return -EINVAL;
-
-	/* Helper to read a big number; size is in cells (not bytes) */
-	*handle = of_read_number(prop, of_n_addr_cells(np));
-	return 0;
-}
-
 static int read_phys_addr(struct device_node *np, char *prop_name,
 			struct cxl_afu *afu)
 {
@@ -121,17 +74,12 @@ static int read_vpd(struct cxl *adapter, struct cxl_afu *afu)
 
 int cxl_of_read_afu_handle(struct cxl_afu *afu, struct device_node *afu_np)
 {
-	if (read_handle(afu_np, &afu->guest->handle))
-		return -EINVAL;
-	pr_devel("AFU handle: 0x%.16llx\n", afu->guest->handle);
-
-	return 0;
+	return of_property_read_reg(afu_np, 0, &afu->guest->handle, NULL);
 }
 
 int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *np)
 {
 	int i, rc;
-	const __be32 *prop;
 	u16 device_id, vendor_id;
 	u32 val = 0, class_code;
 
@@ -150,16 +98,15 @@ int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *np)
 	else
 		afu->psa = true;
 
-	read_prop_dword(np, "ibm,#processes", &afu->max_procs_virtualised);
+	of_property_read_u32(np, "ibm,#processes", &afu->max_procs_virtualised);
 
 	if (cxl_verbose)
 		read_vpd(NULL, afu);
 
-	read_prop_dword(np, "ibm,max-ints-per-process", &afu->guest->max_ints);
+	of_property_read_u32(np, "ibm,max-ints-per-process", &afu->guest->max_ints);
 	afu->irqs_max = afu->guest->max_ints;
 
-	prop = read_prop_dword(np, "ibm,min-ints-per-process", &afu->pp_irqs);
-	if (prop) {
+	if (!of_property_read_u32(np, "ibm,min-ints-per-process", &afu->pp_irqs)) {
 		/* One extra interrupt for the PSL interrupt is already
 		 * included. Remove it now to keep only AFU interrupts and
 		 * match the native case.
@@ -167,13 +114,13 @@ int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *np)
 		afu->pp_irqs--;
 	}
 
-	read_prop64_dword(np, "ibm,error-buffer-size", &afu->eb_len);
+	of_property_read_u64(np, "ibm,error-buffer-size", &afu->eb_len);
 	afu->eb_offset = 0;
 
-	read_prop64_dword(np, "ibm,config-record-size", &afu->crs_len);
+	of_property_read_u64(np, "ibm,config-record-size", &afu->crs_len);
 	afu->crs_offset = 0;
 
-	read_prop_dword(np, "ibm,#config-records", &afu->crs_num);
+	of_property_read_u32(np, "ibm,#config-records", &afu->crs_num);
 
 	if (cxl_verbose) {
 		for (i = 0; i < afu->crs_num; i++) {
@@ -201,14 +148,12 @@ int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *np)
 	 * not supported
 	 */
 	val = 0;
-	prop = read_prop_dword(np, "ibm,process-mmio", &val);
-	if (prop && val == 1)
+	if (!of_property_read_u32(np, "ibm,process-mmio", &val) && val == 1)
 		afu->pp_psa = true;
 	else
 		afu->pp_psa = false;
 
-	prop = read_prop_dword(np, "ibm,function-error-interrupt", &val);
-	if (prop)
+	if (!of_property_read_u32(np, "ibm,function-error-interrupt", &val))
 		afu->serr_hwirq = val;
 
 	pr_devel("AFU handle: %#llx\n", afu->guest->handle);
@@ -279,17 +224,13 @@ static int read_adapter_irq_config(struct cxl *adapter, struct device_node *np)
 
 int cxl_of_read_adapter_handle(struct cxl *adapter, struct device_node *np)
 {
-	if (read_handle(np, &adapter->guest->handle))
-		return -EINVAL;
-	pr_devel("Adapter handle: 0x%.16llx\n", adapter->guest->handle);
-
-	return 0;
+	return of_property_read_reg(np, 0, &adapter->guest->handle, NULL);
 }
 
 int cxl_of_read_adapter_properties(struct cxl *adapter, struct device_node *np)
 {
 	int rc;
-	const __be32 *prop;
+	const char *p;
 	u32 val = 0;
 
 	/* Properties are read in the same order as listed in PAPR */
@@ -297,37 +238,30 @@ int cxl_of_read_adapter_properties(struct cxl *adapter, struct device_node *np)
 	if ((rc = read_adapter_irq_config(adapter, np)))
 		return rc;
 
-	prop = read_prop_dword(np, "ibm,caia-version", &val);
-	if (prop) {
+	if (!of_property_read_u32(np, "ibm,caia-version", &val)) {
 		adapter->caia_major = (val & 0xFF00) >> 8;
 		adapter->caia_minor = val & 0xFF;
 	}
 
-	prop = read_prop_dword(np, "ibm,psl-revision", &val);
-	if (prop)
+	if (!of_property_read_u32(np, "ibm,psl-revision", &val))
 		adapter->psl_rev = val;
 
-	prop = read_prop_string(np, "status");
-	if (prop) {
-		adapter->guest->status = kasprintf(GFP_KERNEL, "%s", (char *) prop);
+	if (!of_property_read_string(np, "status", &p)) {
+		adapter->guest->status = kasprintf(GFP_KERNEL, "%s", p);
 		if (adapter->guest->status == NULL)
 			return -ENOMEM;
 	}
 
-	prop = read_prop_dword(np, "vendor-id", &val);
-	if (prop)
+	if (!of_property_read_u32(np, "vendor-id", &val))
 		adapter->guest->vendor = val;
 
-	prop = read_prop_dword(np, "device-id", &val);
-	if (prop)
+	if (!of_property_read_u32(np, "device-id", &val))
 		adapter->guest->device = val;
 
-	prop = read_prop_dword(np, "subsystem-vendor-id", &val);
-	if (prop)
+	if (!of_property_read_u32(np, "subsystem-vendor-id", &val))
 		adapter->guest->subsystem_vendor = val;
 
-	prop = read_prop_dword(np, "subsystem-id", &val);
-	if (prop)
+	if (!of_property_read_u32(np, "subsystem-id", &val))
 		adapter->guest->subsystem = val;
 
 	if (cxl_verbose)
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 4cf9e7c42a24..3d52f9b92d0d 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -363,17 +363,17 @@ int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
 {
 	int rc;
 	struct device_node *np;
-	const __be32 *prop;
+	u32 id;
 
 	if (!(np = pnv_pci_get_phb_node(dev)))
 		return -ENODEV;
 
-	while (np && !(prop = of_get_property(np, "ibm,chip-id", NULL)))
+	while (np && of_property_read_u32(np, "ibm,chip-id", &id))
 		np = of_get_next_parent(np);
 	if (!np)
 		return -ENODEV;
 
-	*chipid = be32_to_cpup(prop);
+	*chipid = id;
 
 	rc = get_phb_index(np, phb_index);
 	if (rc) {
@@ -398,32 +398,26 @@ static DEFINE_MUTEX(indications_mutex);
 static int get_phb_indications(struct pci_dev *dev, u64 *capiind, u64 *asnind,
 			       u64 *nbwind)
 {
-	static u64 nbw, asn, capi = 0;
+	static u32 val[3];
 	struct device_node *np;
-	const __be32 *prop;
 
 	mutex_lock(&indications_mutex);
-	if (!capi) {
+	if (!val[0]) {
 		if (!(np = pnv_pci_get_phb_node(dev))) {
 			mutex_unlock(&indications_mutex);
 			return -ENODEV;
 		}
 
-		prop = of_get_property(np, "ibm,phb-indications", NULL);
-		if (!prop) {
-			nbw = 0x0300UL; /* legacy values */
-			asn = 0x0400UL;
-			capi = 0x0200UL;
-		} else {
-			nbw = (u64)be32_to_cpu(prop[2]);
-			asn = (u64)be32_to_cpu(prop[1]);
-			capi = (u64)be32_to_cpu(prop[0]);
+		if (of_property_read_u32_array(np, "ibm,phb-indications", val, 3)) {
+			val[2] = 0x0300UL; /* legacy values */
+			val[1] = 0x0400UL;
+			val[0] = 0x0200UL;
 		}
 		of_node_put(np);
 	}
-	*capiind = capi;
-	*asnind = asn;
-	*nbwind = nbw;
+	*capiind = val[0];
+	*asnind = val[1];
+	*nbwind = val[2];
 	mutex_unlock(&indications_mutex);
 	return 0;
 }
@@ -605,7 +599,7 @@ static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 
 	/* Do not fail when CAPP timebase sync is not supported by OPAL */
 	of_node_get(np);
-	if (! of_get_property(np, "ibm,capp-timebase-sync", NULL)) {
+	if (!of_property_present(np, "ibm,capp-timebase-sync")) {
 		of_node_put(np);
 		dev_info(&dev->dev, "PSL timebase inactive: OPAL support missing\n");
 		return;

-- 
2.43.0


