Return-Path: <linux-kernel+bounces-299359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A763395D39A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7051C23712
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B1E18BC0B;
	Fri, 23 Aug 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="lfOoUhxn"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DE18A6C7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430921; cv=none; b=Tfb7TjTKfk5dOPElgnAFqep38Flz6xujJg7Kp2qTIhj9uy9E7dNy1sEpuv8BU7xTewDil/n+Fab2Y6PcWIgLo/tQtI9MFxAKJng88RiXZfKdtTOP3aVcKIhdCsfUFgbZZXrngiuVNM7R10xcpZ0jgwPpEwc5iAXZoWzOalVYznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430921; c=relaxed/simple;
	bh=8RdcJvVv3gShrKDsP0JLU8Wsg0kuGNpupzjo7uvrHe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okjC8GU923Ojwib6D9N/qaRtNYb//ihAXzpUcNVUp5G47AI3GdfDK0r9rcRC70prxcacevh1DtSJ/SzUpPLFfAIGuBdlkLWxVcfOaxlMPfF+XCTnodtIbbOA7jKeN0q6u32QpqsaPLZNBg1O3nh9FzJ+1Fw3o9eaI6MkY1pcIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=lfOoUhxn; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53341decf9aso196658e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724430917; x=1725035717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjrTEbgn235rhvAj96iSdJKR0hzx2vUIB4UjFS1NRO8=;
        b=lfOoUhxnIojgZ6SKsAbGEr0AGMxptBKWzy64KxtZF1u7/bI4w5AVQQe19u95IjRVdd
         tsJvB5KaR+sgUGidRUnnG9CHX5GQcHcl2sZeCUxH2vkg2BphVrspHnYhEI/nZ65WmH4m
         XDy2ujWGuz3XqCgADC/1CrY1DpSjX3yRrbAAW73Hvj1nrBWsefnsfwSRs73b+WUuDttY
         EKI5/7zpjg8sPkDGfAd3v4RvlHjkfMxhTwAgc7prV+lVMc23YfoZ6I+XX344plcGM/ES
         eGivgesTG6YkMfzZ38oeV8v8cvJupRILh13Gv6HMpj1YA2Qi2vw0F9ko5PDNz5hBspE2
         AyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430917; x=1725035717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjrTEbgn235rhvAj96iSdJKR0hzx2vUIB4UjFS1NRO8=;
        b=orl9J1f0XJKZiD4ekHQeDLA2RFIMMGoQ5pyK9wiQdHtW7xaNh2d/uQOuP8V7j4KADV
         PSw5xS1EUKiAD3xRntSw/6fKRrWvJNIRmnWgn7JU3q6OTSswJJ/0wTMx2kWqIn42s79T
         rlkRP7VHEGEk51JBBHjoQZdg8+NKVTnihR+HptDstE1awM/rUzyr+Y3vauHwpxps4PHZ
         41fVQzYTCHdtxfR4nPkmOiT2Au/X9+93rBNN6ivjn/nwUbbpUTRj5x52ypqQ1P6vbmQq
         EnFOGUg0nCIyNSHA1B1Q18q3RLymhpmMHP3MxjB0kWwJ/AZ2uWQv4JDYBedRzkNTCerz
         pjIg==
X-Gm-Message-State: AOJu0Yx/jTu5QdaN5tsmX8SbQ2IP4KURhPiDMuTAoyB/GhuQbqwOIzT5
	CVoN3spidAxG7SDWlvTZIkQG7aUoGYtbOunjoKJgXAKMCg6yY/iV8Ou3q6xafV1ED2PapqwCYAP
	y
X-Google-Smtp-Source: AGHT+IEG+5HzmoKtxYv7K5mHJzlZfGPcBhD6/5HldN1KYcznaq5LdMfnwge5FilF0SAzHPozeP4Adw==
X-Received: by 2002:a05:6512:3ba7:b0:52e:9b87:2340 with SMTP id 2adb3069b0e04-534387be0d3mr1104239e87.6.1724430917206;
        Fri, 23 Aug 2024 09:35:17 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a5dcsm282423166b.172.2024.08.23.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:35:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kees@kernel.org,
	gustavoars@kernel.org,
	andriy.shevchenko@linux.intel.com,
	mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] params: Annotate struct module_param_attrs with __counted_by()
Date: Fri, 23 Aug 2024 16:59:33 +0200
Message-ID: <20240823145931.107964-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Increment num before adding a new param_attribute to the attrs array and
adjust the array index accordingly. Increment num immediately after the
first reallocation such that the reallocation for the NULL terminator
only needs to add 1 (instead of 2) to mk->mp->num.

Use struct_size() instead of manually calculating the size for the
reallocation.

Use krealloc_array() for the additional NULL terminator.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use krealloc_array() as suggested by Andy Shevchenko
- Link to v1: https://lore.kernel.org/linux-kernel/20240823123300.37574-1-thorsten.blum@toblux.com/
---
 kernel/params.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 2e447f8ae183..5f6643676697 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -551,7 +551,7 @@ struct module_param_attrs
 {
 	unsigned int num;
 	struct attribute_group grp;
-	struct param_attribute attrs[];
+	struct param_attribute attrs[] __counted_by(num);
 };
 
 #ifdef CONFIG_SYSFS
@@ -651,35 +651,32 @@ static __modinit int add_sysfs_param(struct module_kobject *mk,
 	}
 
 	/* Enlarge allocations. */
-	new_mp = krealloc(mk->mp,
-			  sizeof(*mk->mp) +
-			  sizeof(mk->mp->attrs[0]) * (mk->mp->num + 1),
+	new_mp = krealloc(mk->mp, struct_size(mk->mp, attrs, mk->mp->num + 1),
 			  GFP_KERNEL);
 	if (!new_mp)
 		return -ENOMEM;
 	mk->mp = new_mp;
+	mk->mp->num++;
 
 	/* Extra pointer for NULL terminator */
-	new_attrs = krealloc(mk->mp->grp.attrs,
-			     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 2),
-			     GFP_KERNEL);
+	new_attrs = krealloc_array(mk->mp->grp.attrs, mk->mp->num + 1,
+				   sizeof(mk->mp->grp.attrs[0]), GFP_KERNEL);
 	if (!new_attrs)
 		return -ENOMEM;
 	mk->mp->grp.attrs = new_attrs;
 
 	/* Tack new one on the end. */
-	memset(&mk->mp->attrs[mk->mp->num], 0, sizeof(mk->mp->attrs[0]));
-	sysfs_attr_init(&mk->mp->attrs[mk->mp->num].mattr.attr);
-	mk->mp->attrs[mk->mp->num].param = kp;
-	mk->mp->attrs[mk->mp->num].mattr.show = param_attr_show;
+	memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));
+	sysfs_attr_init(&mk->mp->attrs[mk->mp->num - 1].mattr.attr);
+	mk->mp->attrs[mk->mp->num - 1].param = kp;
+	mk->mp->attrs[mk->mp->num - 1].mattr.show = param_attr_show;
 	/* Do not allow runtime DAC changes to make param writable. */
 	if ((kp->perm & (S_IWUSR | S_IWGRP | S_IWOTH)) != 0)
-		mk->mp->attrs[mk->mp->num].mattr.store = param_attr_store;
+		mk->mp->attrs[mk->mp->num - 1].mattr.store = param_attr_store;
 	else
-		mk->mp->attrs[mk->mp->num].mattr.store = NULL;
-	mk->mp->attrs[mk->mp->num].mattr.attr.name = (char *)name;
-	mk->mp->attrs[mk->mp->num].mattr.attr.mode = kp->perm;
-	mk->mp->num++;
+		mk->mp->attrs[mk->mp->num - 1].mattr.store = NULL;
+	mk->mp->attrs[mk->mp->num - 1].mattr.attr.name = (char *)name;
+	mk->mp->attrs[mk->mp->num - 1].mattr.attr.mode = kp->perm;
 
 	/* Fix up all the pointers, since krealloc can move us */
 	for (i = 0; i < mk->mp->num; i++)
-- 
2.46.0


