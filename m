Return-Path: <linux-kernel+bounces-238427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E480924AD3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861D0B24EF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA1721C162;
	Tue,  2 Jul 2024 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IISy27uR"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB28210199
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957505; cv=none; b=SX5LJHLlEMo+Cq4CdZ1Dzvg1ikRC3x8qxSj7d+BaUqG5BaKchqEtq4Vddco0gqYj5kHFcAoY7uZHNa/FMEk4b9N8dsZLJErbdXFPjPU/zfqcQpQxUnGve4RLuTzRXZZAp82CRWOFohWd/VD4Bsp12JZ9lHsxXaoQZyQNRICEHlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957505; c=relaxed/simple;
	bh=LfbPL0PeRvX6qcgfNwuiYcYLVX8gyNp/+Z0M/GkZpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sihy9k14kSRO2jJOVY0dUgcMi/7h3EhhwSzDiNwogESGJfWC+I9bfiiKG0X6KoZ+xQvWcSgtYVFs//wVNY0pCj3YVXEzA0IR0mqEpvjf3/4Y1McUqLGaowATSO8EJWcvLuwxoyvSymtCR8Vki2EsZMPl/3DUOnYcd+34+bbQyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IISy27uR; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7eba486df76so856139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957503; x=1720562303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xZzQ/E3vZK+E5MMlKfK/qTb5+sylxnNOul573hVp9Y=;
        b=IISy27uR5ytBM+uB0P7NwvbwehUZeWtRCadF5zw30UeHvyK1TR4uyCfpfURbfNdWNa
         J45ECsExcS5Frwv2drOrhsD1dgvyw6EYbVxK+BTPUVHzyK4LpOAx+Qz6ubVZOQaYheBc
         VfjgHBVNHwaqLE87CBudpKm5382Mzv6HLBaixpQ0dYmY6RDsl5RdQZmDoLBtux/GdcNt
         RgLdUXlu/GoBVkv76+6vomZbWdcUrvNEhKUIdlrPbzGQN5bBbuVk99kP8p0u+8kmw17S
         2c1ARKaMWOuvENQ9FrOAEZvWMA5/pwUqxRvIaax6mRkdzaJrP9eWqsVoJozvQe+SdVpc
         bRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957503; x=1720562303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xZzQ/E3vZK+E5MMlKfK/qTb5+sylxnNOul573hVp9Y=;
        b=rS56DaSukG8Re9qCQmJEW+81ztiUbrmwK1IHROw3ECVHOg6bUhicXtrMq1ZBgn35yK
         f5CXiGZadUtSv8iNz5/uYDhyZJOjnYdK1WHBZnrFoV85lYgDZtLlVpUd47xqb2VkKAH/
         subLSpI9oB5HRRTW8+fdiQbSxA6UvaLqOdAspmFzARUlJF6AcM9SMIktE1QUr1fQpIRp
         FdKzRyuHeW3z8jY1D7wJ0+IMntqaPi/ktRJpFXzqVzDpNnb4jlYgNFDiNTZu9bMls+yz
         UFhyU4IT4ukCN0q09Ve+3mpjudHqeAmrEhy+N3n/4iyr8O2G192v73QJLnPSTalP60Xq
         jyMA==
X-Gm-Message-State: AOJu0Yx4O7iVeKqHxDjuG7XeHE2GY+FeZ5CnkbwsqAe+ju9JDGK9dGJP
	Me4t4z1pE7+UvuzDKC/3glYistAQTtxRjjof9JcyN3IMZ2pf5c41k+gslw==
X-Google-Smtp-Source: AGHT+IGYdWlTTC7TRfqgE6BZNMFEtFIymMFnXp3OmPzaWNa0nuspcltmmeqiu/SmLsP4XIoxiBNboQ==
X-Received: by 2002:a05:6602:178e:b0:7eb:eeba:5e83 with SMTP id ca18e2360f4ac-7f62eeab155mr453600539f.9.1719957502788;
        Tue, 02 Jul 2024 14:58:22 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 07/52] dyndbg: split param_set_dyndbg_classes to _module & wrapper fns
Date: Tue,  2 Jul 2024 15:56:57 -0600
Message-ID: <20240702215804.2201271-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
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
2.45.2


