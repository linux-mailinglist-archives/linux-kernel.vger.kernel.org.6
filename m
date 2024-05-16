Return-Path: <linux-kernel+bounces-181389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318248C7B82
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553561C216E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672CC1581E7;
	Thu, 16 May 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfXlW3dM"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC35157A74
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881459; cv=none; b=CL/aNn1ePWKDv+CFaDV332hyhdQQ7TocyETv5GWt5p57rPQxHc/dSRMVG5s7HsqFIKT9sLdlSSjRnCPJye0IpTzaXWdGkJrMEoa9arI0nZlgI7OikNKcAXMolDGNRUDhBzs36TzrucolqTzdZ6MwDtvw+6wtsRvBumJAkrpThWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881459; c=relaxed/simple;
	bh=vWHueNHym1y38hL4VQt3Hm0HOaNKFSlXmaKD6E18tGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiIDkz64VksP5pbv2WBkpWzdrPXA/P2PBoouOf83ZeckRgDZ4ijdT6ro3dxfGnqdJ3oflW3TN4r4UPEGXNqeBsI+12YWCHb6dm0qe6eFstbqB8zzHgYwSM7WON/MzdVbyWthyhhlzGIVC/AREJfqQXiIMqKrIIqfcHlWHP7M79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfXlW3dM; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7e1c06191d0so26161039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881457; x=1716486257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr3n6uiG4JNkms4eZuQ6L/2AOxbSXY48bgOgRcB/ufk=;
        b=BfXlW3dM6lEACshMD31B0VTWgoK45OljwrFK+lnwmzurFMabR6DPMcuBo3AqOYFfQJ
         pph/JCDuGEdnWX4tjVXA9s8hFtRydFtlwUYDv5MTorpA6NAH2kldEbScQrM8TMfF/vMB
         pevMGIyB0qiys2BJdTAJYKQyn4ler/bqJXFXUs7nhT8zBdgFv3wM+u6OeUns7i/iaX1i
         7UKEXupqZj90dDceuz/aY0OHuolUkOccz/KYl6uSYiJE27NJuLicSOrK349Vr4PlalFY
         xcqBVuiVDF+OK3MhDWYnqT4Po5u5CjMkX1baDe/lJ5vh+W2oq0r20eRW7sYAcgS8Ez04
         nIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881457; x=1716486257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr3n6uiG4JNkms4eZuQ6L/2AOxbSXY48bgOgRcB/ufk=;
        b=JakQJLnoqbi12qDWFDEDjqCwIycv3yaM0yMjl2k1CZtGef5tVTj/tuB4XLG1xoOy/Q
         tTRfpHj8t9JhSW/UR+gyu/nytEAg9nhDhkqGF/nYhdSFrfJ25TNcMs0Dy3YxYa+4lGsu
         Wc26x4p5A412+vBLZFvoy33xH83IobAvzmp4IxPlDAiDVI2JuNHmbzfof6oF3DAFKvhV
         jW34t5dCklMZojyV1aCW8ssFrOxAXR2Yqzd+CrGrdxFSRI9istP2Hzmertk/hF4eq57v
         nsLDXMA7V3aKLqw3tYfSAQHyVqJ3ZOqGeTqhhutm3l9FLID00XrCFzq/vAgwh2MPMgKn
         KSZw==
X-Forwarded-Encrypted: i=1; AJvYcCUVaNZnIDMJQQsT6RH3EVG+XO3Mw5DF85JLKj89mpWUHSkuLY6EOzu1LTbLeZ9HaPLD/ev0hplZ7pB/3RwQLcOORGNtl3IhxTRYSYbm
X-Gm-Message-State: AOJu0Yypu0eh7uIzhCnoGfdTe2ABtTPnzl35u+N2Kgmj1rnNg22viKsO
	nJAEyoL4c9dwkgsSZ0l/2r7/ym4xJ5sQsHHcapfGVR7TehANWcGt
X-Google-Smtp-Source: AGHT+IHbttR7dFYK3sq2VJen5StaG2QPJnfpnPF7J5AJb/2lRHedsqSOUOgclet1Vsxjxvc/R/g/pQ==
X-Received: by 2002:a5d:88c6:0:b0:7de:f134:4c8c with SMTP id ca18e2360f4ac-7e1a337f27bmr1849855139f.2.1715881457357;
        Thu, 16 May 2024 10:44:17 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 07/33] dyndbg: split param_set_dyndbg_classes to _module & wrapper fns
Date: Thu, 16 May 2024 11:43:31 -0600
Message-ID: <20240516174357.26755-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split api-fn: param_set_dyndbg_classes(), adding modname param and
passing NULL in from api-fn.

The new arg allows caller to specify that only one module is affected
by a prdbgs update.  This selectivity will be used later to narrow the
scope of changes made.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a1fd2e9dbafb..4a48f830507f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -711,18 +711,9 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 	return 0;
 }
 
-/**
- * param_set_dyndbg_classes - class FOO >control
- * @instr: string echo>d to sysfs, input depends on map_type
- * @kp:    kp->arg has state: bits/lvl, map, map_type
- *
- * Enable/disable prdbgs by their class, as given in the arguments to
- * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
- * levels by bitpos.
- *
- * Returns: 0 or <0 if error.
- */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *modnm)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
@@ -759,8 +750,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, NULL);
+		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -773,7 +764,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -782,6 +773,22 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
 }
+
+/**
+ * param_set_dyndbg_classes - class FOO >control
+ * @instr: string echo>d to sysfs, input depends on map_type
+ * @kp:    kp->arg has state: bits/lvl, map, map_type
+ *
+ * Enable/disable prdbgs by their class, as given in the arguments to
+ * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
+ * levels by bitpos.
+ *
+ * Returns: 0 or <0 if error.
+ */
+int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+{
+	return param_set_dyndbg_module_classes(instr, kp, NULL);
+}
 EXPORT_SYMBOL(param_set_dyndbg_classes);
 
 /**
-- 
2.45.0


