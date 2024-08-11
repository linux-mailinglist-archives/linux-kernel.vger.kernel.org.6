Return-Path: <linux-kernel+bounces-282196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E7894E0B1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 11:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12E61C21070
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743E438F9C;
	Sun, 11 Aug 2024 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ejLoU/KY"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B402206E;
	Sun, 11 Aug 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723368638; cv=none; b=dATimAlid3kRbUhIpED9z/Azyit3oCcoqoXu1q9HTDHh7bX1kSWcu/S52/lLHlYx2bPfsuPY+Y1P6RbPi29z5MaotINJO1SvFQ8OmV/gWV1pgEcs+Zs6DuMTY6LLFDvlNP7Ryp/hg8OL96KTrQAXGuSnWedo47di0R5ucvePBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723368638; c=relaxed/simple;
	bh=GN0A5EbIfQaHhXtYr8sTGVmRQRCvKxqIVGy51w+O5G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLA5x2ItBOQAt5rK+Uupag17xk3O0gP0t8vPl7yoNWxox3JJuyt565HnBupXw0o5VRovMtZB1V1I7y1vs8JMAMmdvpGhddSUiicUQretUaegi+/gM8IRFkUJj0rCPYa+KLT+O/QxG+Y6iLOyxSKb9aUMnH0h78gOY0gzeiEYG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ejLoU/KY; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id d4u8sXXQdPZ0yd4u8seuKK; Sun, 11 Aug 2024 11:30:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723368627;
	bh=vH6776X2q6P6GBwTwVrFQw2I+W41yFf77V4n/US8fFg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ejLoU/KYvz82OqY5KPL8/I6MerFK5CJr+IDJ8AO8pJMYBsBZY85GrI80CGexz55SO
	 9FRMKvzSP9JNRVosZ8HCssAV35JOvIWm6ByRWNph0Q2xStJmen/CE6tCXx2DGOhwvd
	 z1baL4vtT0en8xo3DKSMB8bRIAnoFu/7vRp1h0StPEXvfkqpcn8tqGV7oi9jT5e2Qw
	 IV/s/PmaqC/46mIvRLk5lCZoLUm89Ez7rmSRLcnAWSPew8DWYvksX76ztfHCemvWv7
	 CtebWI4ee9kv/+AASqzrhR+cBgtSADI2bYKS0o2IHWuzdaX1ZlCLRd3VS1UmFGKAMn
	 a+PdM02r/naSw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Aug 2024 11:30:27 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] coresight: configfs: Constify struct config_item_type
Date: Sun, 11 Aug 2024 11:30:20 +0200
Message-ID: <1011717e5ed35ec12113a0d8c233823e820fb524.1723368522.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct config_item_type' is not modified in this driver.

These structures are only used with config_group_init_type_name() which
takes a "const struct config_item_type *" as a 3rd argument or with
struct config_group.cg_item.ci_type which is also a "const struct
config_item_type	*".

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   4904	   1376	    136	   6416	   1910	drivers/hwtracing/coresight/coresight-syscfg-configfs.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   5264	   1120	     16	   6400	   1900	drivers/hwtracing/coresight/coresight-syscfg-configfs.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 .../hwtracing/coresight/coresight-syscfg-configfs.c  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 433ede94dd63..213b4159b062 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -160,7 +160,7 @@ static struct configfs_attribute *cscfg_config_view_attrs[] = {
 	NULL,
 };
 
-static struct config_item_type cscfg_config_view_type = {
+static const struct config_item_type cscfg_config_view_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_attrs = cscfg_config_view_attrs,
 };
@@ -170,7 +170,7 @@ static struct configfs_attribute *cscfg_config_preset_attrs[] = {
 	NULL,
 };
 
-static struct config_item_type cscfg_config_preset_type = {
+static const struct config_item_type cscfg_config_preset_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_attrs = cscfg_config_preset_attrs,
 };
@@ -272,7 +272,7 @@ static struct configfs_attribute *cscfg_feature_view_attrs[] = {
 	NULL,
 };
 
-static struct config_item_type cscfg_feature_view_type = {
+static const struct config_item_type cscfg_feature_view_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_attrs = cscfg_feature_view_attrs,
 };
@@ -309,7 +309,7 @@ static struct configfs_attribute *cscfg_param_view_attrs[] = {
 	NULL,
 };
 
-static struct config_item_type cscfg_param_view_type = {
+static const struct config_item_type cscfg_param_view_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_attrs = cscfg_param_view_attrs,
 };
@@ -380,7 +380,7 @@ static struct config_group *cscfg_create_feature_group(struct cscfg_feature_desc
 	return &feat_view->group;
 }
 
-static struct config_item_type cscfg_configs_type = {
+static const struct config_item_type cscfg_configs_type = {
 	.ct_owner = THIS_MODULE,
 };
 
@@ -414,7 +414,7 @@ void cscfg_configfs_del_config(struct cscfg_config_desc *config_desc)
 	}
 }
 
-static struct config_item_type cscfg_features_type = {
+static const struct config_item_type cscfg_features_type = {
 	.ct_owner = THIS_MODULE,
 };
 
-- 
2.46.0


