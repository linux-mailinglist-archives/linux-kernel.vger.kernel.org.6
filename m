Return-Path: <linux-kernel+bounces-570227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC4DA6ADFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479B0986A91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F623535B;
	Thu, 20 Mar 2025 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHR/435G"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81D233738
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496827; cv=none; b=Nn1aHbrGSc4YaVtRyOfpJyJ+lru2TVyn7/SzOc+Kp6IISDaFW5lA0TyiHyFX77j5Cel9pUyRQhNVDwAY5TWPghxoHKCAQyat3O2fKTF3QiDiS30DFrSlqSKA89871BaXdnLpW+CXRHi4akiYVRLZe88LSLUP9hGPuT5atKN8Zp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496827; c=relaxed/simple;
	bh=PrYndz+ppQ2qI1vGMHYHFpzdORbrir9vhxzAPF5Oh8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDpVmR/1CzEiVBxdQUmQDmaoV4C8HUu/q5col28tfhk1oqIrqz4r6hsJCRt2Pk0+fZ5SDm3cR5Q2wSXoJ1M8vv7ZMzbvUTSoIbN1YhdTvcZiR6HHTv6xGcMHQcZPWhPr2UPXNBKk+CCVdqtefGqVc58bzaFnUydBmrmmHZan3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHR/435G; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso39665839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496825; x=1743101625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Bsn0H7+fs71frfQ+1OquFl1HD8Y6SgOd3dNDu3Wz8I=;
        b=BHR/435GZMGbpWbG4N44N1tiouQ1hDIvw/fRTQBzzL3gUJzB224TDbN29Yhlln9rkm
         Xe1cK5T9ZTg/JqAlN9QeK8NniVwm2RGGZRG12dvnpkeesrtQVIo3bEA31Felh4tZpobi
         doQEcLT7lRFXXe+nHogxZg5a3vqT0+jLbP49Mn+xhODCAf/51XeZ2S+Togyu6fPUZfXU
         +aaJq9QLR+4tPdZAlQK06Fl/R+bjz8DoUYiGgc31KJYyBnEG48TlrjGHkqGuqz/eafa7
         sNIn86zk6YybpGT1bekjkmY9XLSh9AKOmYirwP6rvId6ms1ZhK1F799w87255NmrCMiD
         LSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496825; x=1743101625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Bsn0H7+fs71frfQ+1OquFl1HD8Y6SgOd3dNDu3Wz8I=;
        b=TDOdIKX+Kbak8cRnOfTxvRuHVG2Wllwq+NRVHLTti1spLRlaBS+6o32tQ4iiU3hpBc
         dwYQ0wvdGn6RwYhGUnHgZxpSofZKS6I1OE5xSTcggocPJ+mnQe77g7kXVJAvdF+I3SSY
         +cvYV5j4v14bFdZtCUu1r3tQQosypXphRdFfXEY9u/76xEHAG+yR9gMrNLAO6sy/ZIdc
         evrTzwaBLdkzQQOqse5saNn0fdL77XcwuORgOE2iHpX1O1pFgRspARltvVddPrZTHE3r
         IRrg5EkhjT+X9ox7WrJN0PM36t4rZr+TUgmWnylSgE9didm43+ZstIiWqsLWGz8q3LHx
         iL9A==
X-Gm-Message-State: AOJu0YzJsZYwscu8l1FdEXf4D+OgwfiOZh7Z6xgm8L2T9bUbc+JfZDS5
	xg/hC9POYOey52RzkW7rf3bMGJKEKTykxKiPQEUjaC0MJY7ojps9zsppX7PC
X-Gm-Gg: ASbGncsNTFgV3R/Bv/okizoxSneZHrolaKp5+PLYvB3tuqp8nnt+aBwS67064/NF1Xa
	wO3FvQOXjUEvSVa02rhgb3UaEKc1AMw5qg+FkJvQUKNiVv9BmGM16EJv6IX/KETNhGCh/AWmBH0
	D4oo+EqaqgXoPkIFmL2RqSD/EeMYYN9UXx1eYE3NhorDgtuIgr0XQlD56hvzhPpmscmOLoM97OC
	tVHFO0qjUJGdlN0yjN8bzLMc/RVFHLD1w1xi7NlqlXPvsVlRB2nksNewVeUlvZk7tIeBgIC77yE
	fF9IDhfqdajZvOkW9AhkXKtlIg/gwWk73Rz/VCvyYVel/rhO7W5GuxAWi84J04DxjNa0YYgQinJ
	HRg==
X-Google-Smtp-Source: AGHT+IFBsswm/PB9JzXq4uuRlWaB+fwcfKZNp5OK53APl/ScwLJfw2dIo+UeZ8s3nXlJQ90V+RQYRw==
X-Received: by 2002:a05:6602:4c83:b0:85b:577b:37c9 with SMTP id ca18e2360f4ac-85e2cc5fe8fmr34189539f.12.1742496825365;
        Thu, 20 Mar 2025 11:53:45 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 36/59] drm-dyndbg: adapt drm core to use dyndbg classmaps-v2
Date: Thu, 20 Mar 2025 12:52:14 -0600
Message-ID: <20250320185238.447458-37-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dyndbg's CLASSMAP-v1 api was broken; DECLARE_DYNDBG_CLASSMAP tried to
do too much.  Its replaced by DRM_CLASSMAP_DEFINE, which creates &
EXPORTs a classmap (in DRM core), and DRM_CLASSMAP_USE which refers to
the classmap defined elsewhere.

The drivers still use DECLARE_DYNDBG_CLASSMAP for now, so they still
redundantly re-declare the classmap, but we can convert the drivers
later to DYNDBG_CLASSMAP_USE

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
this ignores a checkpatch
 WARNING: Argument 'name' is not used in function-like macro
 #70: FILE: include/drm/drm_print.h:148:
 +#define DRM_CLASSMAP_USE(name)

the macro is empty, and correct. only 1 arg is expected.
---
 drivers/gpu/drm/drm_print.c | 25 +++++++++++++------------
 include/drm/drm_print.h     |  8 ++++++++
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 79517bd4418f..a3b70d104afa 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -55,18 +55,19 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 module_param_named(debug, __drm_debug, ulong, 0600);
 #else
-/* classnames must match vals of enum drm_debug_category */
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+/* classnames must match value-symbols of enum drm_debug_category */
+DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
+		    DRM_UT_CORE,
+		    "DRM_UT_CORE",
+		    "DRM_UT_DRIVER",
+		    "DRM_UT_KMS",
+		    "DRM_UT_PRIME",
+		    "DRM_UT_ATOMIC",
+		    "DRM_UT_VBL",
+		    "DRM_UT_STATE",
+		    "DRM_UT_LEASE",
+		    "DRM_UT_DP",
+		    "DRM_UT_DRMRES");
 
 static struct ddebug_class_param drm_debug_bitmap = {
 	.bits = &__drm_debug,
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 9732f514566d..e86ebb716b4c 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -141,6 +141,14 @@ enum drm_debug_category {
 	DRM_UT_DRMRES
 };
 
+#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
+#define DRM_CLASSMAP_DEFINE(...)    DYNAMIC_DEBUG_CLASSMAP_DEFINE(__VA_ARGS__)
+#define DRM_CLASSMAP_USE(name)      DYNAMIC_DEBUG_CLASSMAP_USE(name)
+#else
+#define DRM_CLASSMAP_DEFINE(...)
+#define DRM_CLASSMAP_USE(name)
+#endif
+
 static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
 {
 	return unlikely(__drm_debug & BIT(category));
-- 
2.49.0


