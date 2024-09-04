Return-Path: <linux-kernel+bounces-315258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280C96C015
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8353328BF7B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CD31DC74D;
	Wed,  4 Sep 2024 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VBCHAifb"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C01E1301
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459479; cv=none; b=Px4n/KeSh5mEvCtENe5pBT2rtv3FBecbkYvEolg6bUbAHcSNHxoJaJFJwZAPr/99gWtgTkve7gDtDFftaIxv46Yke/hs4XdgUDZD1bVWSB6Ts2N/3FytjduFAJI/EDMInyGbO844EVPLqWc+Rq6NTtrWm+VwfO3JoDUoJUgP/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459479; c=relaxed/simple;
	bh=iF+xnUz4ZVPd2l4qR5ydbQTMDvMlGwihx9FK85bYczg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GyeQ244K5bMw8cGDZL0PIGo3wIQVo9U5tos+EDWVA4VqvvuQhkeJVrb853ggozzEQUnQaf38KwKIBvTtG5NcwMTw2siTSEqZ69GCGy529n3wwcD5fafHqPzupsD3Y9lTkV000VLecTD6g3cH55Ku/htAxrJyR/8RAPSV1jHbqxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VBCHAifb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374cacf18b1so2205633f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725459475; x=1726064275; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELDHVvYsM0/cFEKySzl95MUb/4tJhoB1VGQyY2w6COY=;
        b=VBCHAifbDYwPY+Y0isVK11BK8nmWrskpjz0X0JzQLSjK9JakaspdhoANHHMecNrqNN
         mrDrcwiUnx+HUk98wMtW5UkHcvHoIsusSwn7MLNg1N4BJyF5o854UCJemU0+B3JKIf4k
         7sND0Ue5b5YT1GiP8XJ3+tj2pmqMbV5ud0rH/OPXqEdaBnUoxDyTfom0+KD05c88/3xu
         50Isv6vGa8eIDNueKAUc9gSXSo4Ua1bK3PyUZK0ZhDwxO051uul+2pnxn/m6B90n2Rwr
         f7TeZdtLyuoc0xCo+1qFWsC0fRK2IacbbopIydFSh5CJ6ka6GlnIqQbb2Kh9ycqz3TTc
         iX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459475; x=1726064275;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELDHVvYsM0/cFEKySzl95MUb/4tJhoB1VGQyY2w6COY=;
        b=I1CQKCbJCqBdvpm5V5tTFI9pM0LjrsbbqlfhWAEabgeVeJ1hAxQ3z+4MnF/u/4ur9O
         d+L6Yi8sAB9gXswY4aIjCNY2lPyLt8bpXS54XmBQeUa7FM7oDCyPIPI4F1DrCJbByW+M
         EFL8Kajo9P+NriSXnvY5FBEqLXBHNk2hwYR4HuWoL9hw50rv8ekHNFFu0hMssAbeNgv4
         6lUS/corD33wyWuB3ocz7mipkt3kciS+wDkrojfeBSF1VuRguXMSje+42o3YqwG70i3z
         BFMI5vl+HUSX1gtwudXCXOHs7EoXgLbyZuXkENy2gktT06P5+Wl2foLiyEs28jtCkqjr
         /JRA==
X-Gm-Message-State: AOJu0YzwcPUDrC5dMthlOXrHnsnFmYenthA5LUQMSv7i/ViqTVZefBOj
	jBoSvMQBA50gx3OvynNT96a/eB7vQ//CjLmhPZksHiMZ1kt6B7aROX2d6/wQxtc=
X-Google-Smtp-Source: AGHT+IGkD3blpPqv6B8eGGu6NVRvgAJ4j0fFjCWqCu3ka/hfnJLfo9Cgeq7k7QsaXhiUlobUpmTbug==
X-Received: by 2002:adf:e407:0:b0:374:ba61:b77e with SMTP id ffacd0b85a97d-374ba61b935mr8044857f8f.63.1725459474751;
        Wed, 04 Sep 2024 07:17:54 -0700 (PDT)
Received: from localhost (189-18-187-19.dsl.telesp.net.br. [189.18.187.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8c4d6e012sm7272417a91.29.2024.09.04.07.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:17:54 -0700 (PDT)
From: "Ricardo B. Marliere" <ricardo.marliere@suse.com>
Date: Wed, 04 Sep 2024 11:17:23 -0300
Subject: [PATCH v2] bus: fsl-mc: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-class_cleanup-fsl-mc-bus-v2-1-83fa25cbdc68@suse.com>
X-B4-Tracking: v=1; b=H4sIAPJr2GYC/x3MwQqDMAyA4VeRnA2E2oPuVWRIG1MXqJ00OAbiu
 6/s+B3+/wKTqmLw6C6o8lHTd2lwfQf8CmUT1LUZHDlPE3nkHMwWzhLKeWCyjDtjPA2HSH4dKcW
 JB2j5USXp97+en/f9A1VYS49qAAAA
To: Stuart Yoder <stuyoder@gmail.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo.marliere@suse.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6798;
 i=ricardo.marliere@suse.com; h=from:subject:message-id;
 bh=iF+xnUz4ZVPd2l4qR5ydbQTMDvMlGwihx9FK85bYczg=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBm2GwQbmdWX+KAX9FGwgD5cr9/sgSd7B39pIqzz
 xJTXfoySfSJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZthsEAAKCRDJC4p8Y4ZY
 puoVD/9auRpWOIpZjhD950/p+J7hVSvnPgH+pRzGey3BK46K1hcAzVYEcFl9i297Hz+3xAtJk7w
 ACaGCph4gu+0M6T3OCNLMuj2IUpKxKQMfYaazzWVKzrJ7Cf5a9Ns2cqG7MQFnDquzbp5nwzs+nU
 2aJwBvfZKMQzDvhP6X8ipnyEAMVHYqSVGAPisW87ko4JvOEOZ0WKFi17a3BjMej6FimmZU6APe0
 RdGrGJ6AikKI87SvmHjxy1ZWgJIMyeTsXWg64t/k/Mc6aW7Qb9QZRFGUx2tn1q/3g5n/sB4UMwK
 inoGtkCTdBJX2FL7lprYxdRU8IayrJ/05+XbYkoh0wQFACtVXa6nXyA+u/XtTieAftD1+aQTIrO
 ZLBt0divL6ngyTsrjTVHIjjISI8r6bDEu307mM9CRUhXm2qmpBAKc/Te0wTZQ3zfR1MxFMA09jq
 bTIEdwp+mMTz2yv18JoJuB6oTwS2V2SavRg5f+eOdyuvjnY4JAOiP4PPnioEzQcyHY/TZae31WZ
 po2XBK6RTkWq4g6pxCNercNDdUGLjHZ1J/56yiQ50bfts4M1rBMIJXcPGK6+KJWwtwbEzEN/D8w
 ZwG8xszSNQ/6nO2WrTVDgkWiSSm/jOCimjNZ2YIFZewUVzy7vr3E70ZYrHGsnh8DxrT5tOGwdEd
 tKxyF6hkCGpUczQ==
X-Developer-Key: i=ricardo.marliere@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move all the
device_type variables used in the bus to be constant structures as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo.marliere@suse.com>
---
v1->v2:
- Added missing specifiers regarding:
https://lore.kernel.org/oe-kbuild-all/202403091124.VOzGG1lj-lkp@intel.com/
https://lore.kernel.org/oe-kbuild-all/202403090918.89zrHUF2-lkp@intel.com/
https://lore.kernel.org/oe-kbuild-all/202409041701.8NfSraMa-lkp@intel.com/

v1: https://lore.kernel.org/all/20240309-device_cleanup-gregkh-v1-1-8ca586ef17ba@marliere.net/
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 36 ++++++++++++++++++------------------
 include/linux/fsl/mc.h          | 30 +++++++++++++++---------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index dd68b8191a0a..2f68aa30dae6 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -320,90 +320,90 @@ struct bus_type fsl_mc_bus_type = {
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
 
-struct device_type fsl_mc_bus_dprc_type = {
+const struct device_type fsl_mc_bus_dprc_type = {
 	.name = "fsl_mc_bus_dprc"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dprc_type);
 
-struct device_type fsl_mc_bus_dpni_type = {
+const struct device_type fsl_mc_bus_dpni_type = {
 	.name = "fsl_mc_bus_dpni"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpni_type);
 
-struct device_type fsl_mc_bus_dpio_type = {
+const struct device_type fsl_mc_bus_dpio_type = {
 	.name = "fsl_mc_bus_dpio"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpio_type);
 
-struct device_type fsl_mc_bus_dpsw_type = {
+const struct device_type fsl_mc_bus_dpsw_type = {
 	.name = "fsl_mc_bus_dpsw"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpsw_type);
 
-struct device_type fsl_mc_bus_dpbp_type = {
+const struct device_type fsl_mc_bus_dpbp_type = {
 	.name = "fsl_mc_bus_dpbp"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpbp_type);
 
-struct device_type fsl_mc_bus_dpcon_type = {
+const struct device_type fsl_mc_bus_dpcon_type = {
 	.name = "fsl_mc_bus_dpcon"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpcon_type);
 
-struct device_type fsl_mc_bus_dpmcp_type = {
+const struct device_type fsl_mc_bus_dpmcp_type = {
 	.name = "fsl_mc_bus_dpmcp"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpmcp_type);
 
-struct device_type fsl_mc_bus_dpmac_type = {
+const struct device_type fsl_mc_bus_dpmac_type = {
 	.name = "fsl_mc_bus_dpmac"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpmac_type);
 
-struct device_type fsl_mc_bus_dprtc_type = {
+const struct device_type fsl_mc_bus_dprtc_type = {
 	.name = "fsl_mc_bus_dprtc"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dprtc_type);
 
-struct device_type fsl_mc_bus_dpseci_type = {
+const struct device_type fsl_mc_bus_dpseci_type = {
 	.name = "fsl_mc_bus_dpseci"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpseci_type);
 
-struct device_type fsl_mc_bus_dpdmux_type = {
+const struct device_type fsl_mc_bus_dpdmux_type = {
 	.name = "fsl_mc_bus_dpdmux"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdmux_type);
 
-struct device_type fsl_mc_bus_dpdcei_type = {
+const struct device_type fsl_mc_bus_dpdcei_type = {
 	.name = "fsl_mc_bus_dpdcei"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdcei_type);
 
-struct device_type fsl_mc_bus_dpaiop_type = {
+const struct device_type fsl_mc_bus_dpaiop_type = {
 	.name = "fsl_mc_bus_dpaiop"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpaiop_type);
 
-struct device_type fsl_mc_bus_dpci_type = {
+const struct device_type fsl_mc_bus_dpci_type = {
 	.name = "fsl_mc_bus_dpci"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpci_type);
 
-struct device_type fsl_mc_bus_dpdmai_type = {
+const struct device_type fsl_mc_bus_dpdmai_type = {
 	.name = "fsl_mc_bus_dpdmai"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdmai_type);
 
-struct device_type fsl_mc_bus_dpdbg_type = {
+const struct device_type fsl_mc_bus_dpdbg_type = {
 	.name = "fsl_mc_bus_dpdbg"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdbg_type);
 
-static struct device_type *fsl_mc_get_device_type(const char *type)
+static const struct device_type *fsl_mc_get_device_type(const char *type)
 {
 	static const struct {
-		struct device_type *dev_type;
+		const struct device_type *dev_type;
 		const char *type;
 	} dev_types[] = {
 		{ &fsl_mc_bus_dprc_type, "dprc" },
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 083c860fd28e..ee6cbf9ab580 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -438,21 +438,21 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 
 extern struct bus_type fsl_mc_bus_type;
 
-extern struct device_type fsl_mc_bus_dprc_type;
-extern struct device_type fsl_mc_bus_dpni_type;
-extern struct device_type fsl_mc_bus_dpio_type;
-extern struct device_type fsl_mc_bus_dpsw_type;
-extern struct device_type fsl_mc_bus_dpbp_type;
-extern struct device_type fsl_mc_bus_dpcon_type;
-extern struct device_type fsl_mc_bus_dpmcp_type;
-extern struct device_type fsl_mc_bus_dpmac_type;
-extern struct device_type fsl_mc_bus_dprtc_type;
-extern struct device_type fsl_mc_bus_dpseci_type;
-extern struct device_type fsl_mc_bus_dpdmux_type;
-extern struct device_type fsl_mc_bus_dpdcei_type;
-extern struct device_type fsl_mc_bus_dpaiop_type;
-extern struct device_type fsl_mc_bus_dpci_type;
-extern struct device_type fsl_mc_bus_dpdmai_type;
+extern const struct device_type fsl_mc_bus_dprc_type;
+extern const struct device_type fsl_mc_bus_dpni_type;
+extern const struct device_type fsl_mc_bus_dpio_type;
+extern const struct device_type fsl_mc_bus_dpsw_type;
+extern const struct device_type fsl_mc_bus_dpbp_type;
+extern const struct device_type fsl_mc_bus_dpcon_type;
+extern const struct device_type fsl_mc_bus_dpmcp_type;
+extern const struct device_type fsl_mc_bus_dpmac_type;
+extern const struct device_type fsl_mc_bus_dprtc_type;
+extern const struct device_type fsl_mc_bus_dpseci_type;
+extern const struct device_type fsl_mc_bus_dpdmux_type;
+extern const struct device_type fsl_mc_bus_dpdcei_type;
+extern const struct device_type fsl_mc_bus_dpaiop_type;
+extern const struct device_type fsl_mc_bus_dpci_type;
+extern const struct device_type fsl_mc_bus_dpdmai_type;
 
 static inline bool is_fsl_mc_bus_dprc(const struct fsl_mc_device *mc_dev)
 {

---
base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
change-id: 20240904-class_cleanup-fsl-mc-bus-3b04d80fb9c3

Best regards,
-- 
Ricardo B. Marliere <ricardo.marliere@suse.com>


