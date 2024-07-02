Return-Path: <linux-kernel+bounces-238426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E45924AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B50B1C20D53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7A22101AC;
	Tue,  2 Jul 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnYoHdwf"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E520FAB8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957503; cv=none; b=cg+uh29dRChEgVyVEhD+Td2P/SuFpGfvQgx3SwwSp2vR16PVoJOH90EsD4MK3hzIq8yWVzwYv3h5dYTzUglk1UWRsGBkus9sZaU4/uA+oqu0oWZnOMiQwDl6Wy+1r7sIuOZ+km94/FRuGhzqL1hLNz+f4S4XFKHVpWEOPSN9+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957503; c=relaxed/simple;
	bh=zmxGi1tH6sFd6Ybk1duPh2EblNtdPK14vDVZ+goc9v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdeMAn5lTJikiD9NOP6AIBoGGPnAZEMhQaAFRh1Rq3GVZ2Sh2j5tQHcjJx2JNwsGtroeP8T3YqgtWeObJ4Bh5MusGpPZJJrr3kNgckf7KPe18tGXQy3a53vZSxMD9oyzMrcbkRlnckhErZ1KeMTv1zn/ELJQX947aeOebitLATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnYoHdwf; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7f6309e9f29so165178439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957501; x=1720562301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgKlPNiKWVnT1pPVJRogWWF3tyIXWVHBmJ5ag9aE+c4=;
        b=HnYoHdwfoM3Ql+7HwqEsvLfGEGvbj9LgQQ2pTrt3HmVbfRO6k+xft4mHP+kihohUXM
         ojcnpwBkEhmxm0lhP1mbXyNHSYlnZA0F5d79x7KLPoisKD0Rh/jikuxVdvPa+7uGl1Cy
         u1AnSHL2QWqBhxLMkAym1wNf25DVI4+0NY8HhEAuXXgqsETs8CiN0wyNZV4alolHNKyV
         AV00yNp8vJ9UpAXN27y1BU8HHGPTSrbE49EU2LIu76JTeLNNu2l5wSsHRZNjCqi3UjQ7
         xgIrBXW++hfhPRw73PJYrfoUcTqbIjkygYFYGKdpAe4q3uuTStnMmprxOzI7petsWuZ0
         yryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957501; x=1720562301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgKlPNiKWVnT1pPVJRogWWF3tyIXWVHBmJ5ag9aE+c4=;
        b=uQKzINCREe+07GrRBKpABp/IyNjSOJozDNG4scyDdtTJRo4U/AzIuj2nKJGGeOHNQQ
         DegHJ/C4zIPSZSifTUq7cKDi9/T4vhp9KfGkQWlg/jjDL378cESt38CI1Cd/VnCQXh1Q
         flHlAf0C38WsFiW2XFqBsNBYadzSX+zIcpWW2dKWjE8/59YnQ1dSL8zQ6NZZoxOwa0de
         FwEWt/zh3XeqeJFILwS9I8+yhAiYU4TlYc3InzAebvkMpvorpcdKY0hkSMHe2Amq83mI
         QYz96KxrNjoWMWWRE1nNPDszut9dOlGSvtvYXYqZNqeO0kxEDGDh200NSCdnx1IwFABE
         ln4A==
X-Gm-Message-State: AOJu0Yw+Z3Sd6uLeBApc3z3JUE6A9t0ILevk/dQ66sYZaa3lC8sDXO62
	8P27xtKh5bnCv2aFYhvvcYvn9XmDxFSkFSOW5S0sPG15HyAKXQ97
X-Google-Smtp-Source: AGHT+IEouPw8z+/+QZWHDW3dmgyQBg1bWleLTxR4pkI5y+9ohF4HuUpGu7gB4NJ1D41ODvUT06RDlQ==
X-Received: by 2002:a5e:8d19:0:b0:7f6:2e72:e810 with SMTP id ca18e2360f4ac-7f62edffb18mr1166209939f.3.1719957501499;
        Tue, 02 Jul 2024 14:58:21 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:21 -0700 (PDT)
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
Subject: [PATCH v9 06/52] dyndbg: ddebug_apply_class_bitmap - add module arg, select on it
Date: Tue,  2 Jul 2024 15:56:56 -0600
Message-ID: <20240702215804.2201271-7-jim.cromie@gmail.com>
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

Add param: query_module to ddebug_apply_class_bitmap(), and pass it
thru to _ddebug_queries(), replacing NULL with query_module.  This
allows its caller to update just one module, or all (as currently).

We'll use this later to propagate drm.debug to each USEr as they're
modprobed.

No functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---

after `modprobe i915`, heres the module dependencies,
though not all on drm.debug.

bash-5.2# lsmod
Module                  Size  Used by
i915                 3133440  0
drm_buddy              20480  1 i915
ttm                    90112  1 i915
i2c_algo_bit           16384  1 i915
video                  61440  1 i915
wmi                    32768  1 video
drm_display_helper    200704  1 i915
drm_kms_helper        208896  2 drm_display_helper,i915
drm                   606208  5 drm_kms_helper,drm_display_helper,drm_buddy,i915,ttm
cec                    57344  2 drm_display_helper,i915
---
 lib/dynamic_debug.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 46e4cdd8e6be..a1fd2e9dbafb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -605,7 +605,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new bitmap to the sys-knob's current bit-state */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits)
+				     unsigned long *new_bits, unsigned long *old_bits,
+				     const char *query_modname)
 {
 #define QUERY_SIZE 128
 	char query[QUERY_SIZE];
@@ -613,7 +614,8 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
+		  query_modname ?: "");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -622,12 +624,15 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
 			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
 
-		ct = ddebug_exec_queries(query, NULL);
+		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
+	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
+		  query_modname ?: "");
+
 	return matches;
 }
 
@@ -682,7 +687,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -692,7 +697,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -755,7 +760,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, NULL);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -768,7 +773,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.45.2


