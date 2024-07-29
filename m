Return-Path: <linux-kernel+bounces-266527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEB094012D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7DB2831C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2762418F2F5;
	Mon, 29 Jul 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnbAnMun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4AD18EFE6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292629; cv=none; b=G7YgI4IoxChlneeltomD1tBSuhRldjBb7H3WwC0eTW3ygR3UiB9s64dYxkfZAm/Y4zSdcLrBrfbcuEIIIu4C3fQiuRjymJS1O80W8+T/+le5Kaqn/FXS6DSwkUBKh8cNdQvG5KQpiPZfP28+Q7wlJUPqbjfhle6AtyK6dhQVgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292629; c=relaxed/simple;
	bh=kYEpslrw3qv91f7QU65Rqm8td8PbyA3ZDp2nZ1DY0Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ut0XbAR1fO/1ffEAXJ/yiwEbwxIbnk/mf/XFVINFt2LxbMJNqkXSkQpc4IBpwGfyCOXf/LJX6O+9uHh9Uo5QMogelwqAsthj6nUqbMnAA37gezm8GouiXk1F5TJTzsdnA8wodUJNOd14z1BQEJA60vl10GpikdUPF4TN7QUc1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnbAnMun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C9EC32786;
	Mon, 29 Jul 2024 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292629;
	bh=kYEpslrw3qv91f7QU65Rqm8td8PbyA3ZDp2nZ1DY0Es=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nnbAnMunqog+UAW2lrJNZaTfBP1tOWpXRfTIgWEstN8hJzVXU/2Sa/tHy9RpKMnK6
	 GA+VRXR/rQeEzdn7cnGg04nEec6+VLH5DJ5mRC3NGrpcgMFOlGxgi5/eDQlOvQSZYy
	 s2Tfqtdy7+RpGPsSgIxx5NLZzaSndiIMgg4SHBEwUg1C/++hqunxnbKlufew8Z7jij
	 K1BK6ZO5o546qcKA58lPb9IPVyXpI1M3JniWe7P3epxKghPYGQUbh+04s9aUVvh4zI
	 xUsLZkloLwz4CVlUgkJH2UoplRY9ZlIniQFc4aI829zddsfoWe2Uv2LKxsZ5AvO6ek
	 ZKQa2u6x1boKg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Mon, 29 Jul 2024 16:36:43 -0600
Subject: [PATCH 1/2] cxl: Drop printing of DT properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-dt-cxl-cleanup-v1-1-a75eea80d231@kernel.org>
References: <20240729-dt-cxl-cleanup-v1-0-a75eea80d231@kernel.org>
In-Reply-To: <20240729-dt-cxl-cleanup-v1-0-a75eea80d231@kernel.org>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

There's little reason to dump DT property values when they can be read
at any time from the DT in /proc/device-tree. If such a feature is
needed, then it really should be implemented in the DT core such that
any module/driver can use it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/misc/cxl/of.c | 101 ++------------------------------------------------
 1 file changed, 3 insertions(+), 98 deletions(-)

diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
index bcc005dff1c0..21ecce0f9403 100644
--- a/drivers/misc/cxl/of.c
+++ b/drivers/misc/cxl/of.c
@@ -19,8 +19,6 @@ static const __be32 *read_prop_string(const struct device_node *np,
 	const __be32 *prop;
 
 	prop = of_get_property(np, prop_name, NULL);
-	if (cxl_verbose && prop)
-		pr_info("%s: %s\n", prop_name, (char *) prop);
 	return prop;
 }
 
@@ -32,8 +30,6 @@ static const __be32 *read_prop_dword(const struct device_node *np,
 	prop = of_get_property(np, prop_name, NULL);
 	if (prop)
 		*val = be32_to_cpu(prop[0]);
-	if (cxl_verbose && prop)
-		pr_info("%s: %#x (%u)\n", prop_name, *val, *val);
 	return prop;
 }
 
@@ -45,8 +41,6 @@ static const __be64 *read_prop64_dword(const struct device_node *np,
 	prop = of_get_property(np, prop_name, NULL);
 	if (prop)
 		*val = be64_to_cpu(prop[0]);
-	if (cxl_verbose && prop)
-		pr_info("%s: %#llx (%llu)\n", prop_name, *val, *val);
 	return prop;
 }
 
@@ -100,9 +94,6 @@ static int read_phys_addr(struct device_node *np, char *prop_name,
 					type, prop_name);
 				return -EINVAL;
 			}
-			if (cxl_verbose)
-				pr_info("%s: %#x %#llx (size %#llx)\n",
-					prop_name, type, addr, size);
 		}
 	}
 	return 0;
@@ -139,27 +130,13 @@ int cxl_of_read_afu_handle(struct cxl_afu *afu, struct device_node *afu_np)
 
 int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *np)
 {
-	int i, len, rc;
-	char *p;
+	int i, rc;
 	const __be32 *prop;
 	u16 device_id, vendor_id;
 	u32 val = 0, class_code;
 
 	/* Properties are read in the same order as listed in PAPR */
 
-	if (cxl_verbose) {
-		pr_info("Dump of the 'ibm,coherent-platform-function' node properties:\n");
-
-		prop = of_get_property(np, "compatible", &len);
-		i = 0;
-		while (i < len) {
-			p = (char *) prop + i;
-			pr_info("compatible: %s\n", p);
-			i += strlen(p) + 1;
-		}
-		read_prop_string(np, "name");
-	}
-
 	rc = read_phys_addr(np, "reg", afu);
 	if (rc)
 		return rc;
@@ -173,19 +150,10 @@ int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *np)
 	else
 		afu->psa = true;
 
-	if (cxl_verbose) {
-		read_prop_string(np, "ibm,loc-code");
-		read_prop_string(np, "device_type");
-	}
-
 	read_prop_dword(np, "ibm,#processes", &afu->max_procs_virtualised);
 
-	if (cxl_verbose) {
-		read_prop_dword(np, "ibm,scratchpad-size", &val);
-		read_prop_dword(np, "ibm,programmable", &val);
-		read_prop_string(np, "ibm,phandle");
+	if (cxl_verbose)
 		read_vpd(NULL, afu);
-	}
 
 	read_prop_dword(np, "ibm,max-ints-per-process", &afu->guest->max_ints);
 	afu->irqs_max = afu->guest->max_ints;
@@ -199,17 +167,9 @@ int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *np)
 		afu->pp_irqs--;
 	}
 
-	if (cxl_verbose) {
-		read_prop_dword(np, "ibm,max-ints", &val);
-		read_prop_dword(np, "ibm,vpd-size", &val);
-	}
-
 	read_prop64_dword(np, "ibm,error-buffer-size", &afu->eb_len);
 	afu->eb_offset = 0;
 
-	if (cxl_verbose)
-		read_prop_dword(np, "ibm,config-record-type", &val);
-
 	read_prop64_dword(np, "ibm,config-record-size", &afu->crs_len);
 	afu->crs_offset = 0;
 
@@ -235,15 +195,6 @@ int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *np)
 					i, class_code);
 			}
 		}
-
-		read_prop_dword(np, "ibm,function-number", &val);
-		read_prop_dword(np, "ibm,privileged-function", &val);
-		read_prop_dword(np, "vendor-id", &val);
-		read_prop_dword(np, "device-id", &val);
-		read_prop_dword(np, "revision-id", &val);
-		read_prop_dword(np, "class-code", &val);
-		read_prop_dword(np, "subsystem-vendor-id", &val);
-		read_prop_dword(np, "subsystem-id", &val);
 	}
 	/*
 	 * if "ibm,process-mmio" doesn't exist then per-process mmio is
@@ -256,12 +207,6 @@ int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *np)
 	else
 		afu->pp_psa = false;
 
-	if (cxl_verbose) {
-		read_prop_dword(np, "ibm,supports-aur", &val);
-		read_prop_dword(np, "ibm,supports-csrp", &val);
-		read_prop_dword(np, "ibm,supports-prr", &val);
-	}
-
 	prop = read_prop_dword(np, "ibm,function-error-interrupt", &val);
 	if (prop)
 		afu->serr_hwirq = val;
@@ -343,49 +288,15 @@ int cxl_of_read_adapter_handle(struct cxl *adapter, struct device_node *np)
 
 int cxl_of_read_adapter_properties(struct cxl *adapter, struct device_node *np)
 {
-	int rc, len, naddr, i;
-	char *p;
+	int rc;
 	const __be32 *prop;
 	u32 val = 0;
 
 	/* Properties are read in the same order as listed in PAPR */
 
-	naddr = of_n_addr_cells(np);
-
-	if (cxl_verbose) {
-		pr_info("Dump of the 'ibm,coherent-platform-facility' node properties:\n");
-
-		read_prop_dword(np, "#address-cells", &val);
-		read_prop_dword(np, "#size-cells", &val);
-
-		prop = of_get_property(np, "compatible", &len);
-		i = 0;
-		while (i < len) {
-			p = (char *) prop + i;
-			pr_info("compatible: %s\n", p);
-			i += strlen(p) + 1;
-		}
-		read_prop_string(np, "name");
-		read_prop_string(np, "model");
-
-		prop = of_get_property(np, "reg", NULL);
-		if (prop) {
-			pr_info("reg: addr:%#llx size:%#x\n",
-				of_read_number(prop, naddr),
-				be32_to_cpu(prop[naddr]));
-		}
-
-		read_prop_string(np, "ibm,loc-code");
-	}
-
 	if ((rc = read_adapter_irq_config(adapter, np)))
 		return rc;
 
-	if (cxl_verbose) {
-		read_prop_string(np, "device_type");
-		read_prop_string(np, "ibm,phandle");
-	}
-
 	prop = read_prop_dword(np, "ibm,caia-version", &val);
 	if (prop) {
 		adapter->caia_major = (val & 0xFF00) >> 8;
@@ -411,12 +322,6 @@ int cxl_of_read_adapter_properties(struct cxl *adapter, struct device_node *np)
 	if (prop)
 		adapter->guest->device = val;
 
-	if (cxl_verbose) {
-		read_prop_dword(np, "ibm,privileged-facility", &val);
-		read_prop_dword(np, "revision-id", &val);
-		read_prop_dword(np, "class-code", &val);
-	}
-
 	prop = read_prop_dword(np, "subsystem-vendor-id", &val);
 	if (prop)
 		adapter->guest->subsystem_vendor = val;

-- 
2.43.0


