Return-Path: <linux-kernel+bounces-254260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B44509330FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E49B2375F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E219F48C;
	Tue, 16 Jul 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InPBS0Ec"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3C1A0AF7;
	Tue, 16 Jul 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156309; cv=none; b=oby9dnksb1TzPYOMwGeSWV9xjqAoRKicWibi4RqkXnIij1fLKhv3BJF9Ar0rCVgpBdK+4qKbUGqbgZQguOODWR9PbzLi2QZPn2vAiyNiq3dgEaSxtBAPpxzjf2WpoUaaIrliKEWjPETyFCXax7tazyuVbs0WEg9cYBvpcR+Gmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156309; c=relaxed/simple;
	bh=zmxGi1tH6sFd6Ybk1duPh2EblNtdPK14vDVZ+goc9v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJaGELWc1dVJGh3Oh3K6ahVxTSgfAwG3sdSAkeBQrXWaVAkdec5TrYMhc1e1xWibaMlsoXpvrwTJdOPVPZv5kfW9h44uQw5b7SvZohKs/pcvNdz5rUwKOqS3RuZu/+MXogH4rDHjafa5xXqnq4m+JeYiVK1rQrYUuXF2YuqBabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InPBS0Ec; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f97e794f34so4318439f.3;
        Tue, 16 Jul 2024 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156306; x=1721761106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgKlPNiKWVnT1pPVJRogWWF3tyIXWVHBmJ5ag9aE+c4=;
        b=InPBS0EcBPx6DZhqxBYr6lOm9vJaLUau66enQTPK+40ua0/nHDMZzLcrhaHc7S27xk
         piQCCQTs2oE7rinBAwuz9AY51JE94GUvYW0qA1vCCoA/DPcbHH9fvjIJvWjOVSRCDbZh
         Aba7BoUOD+i64N0vzyMyMYxff6xrgaLQ43jg8bm+Hz4oZPihLrBY0X4HwYsKFS30ZURF
         r92niye3xF8QjwYoMxzoQ5HWItnoNR+JoEjmAJsSONhy9bHYSKnApQyrVdXaYPHS0aQx
         k0QhwbvQ2OGTt6Ti18uhxaddI7zRc39B2+muSl6Shr9eShGA/EI7zgvbp+wcvB8s3Hmm
         M75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156306; x=1721761106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgKlPNiKWVnT1pPVJRogWWF3tyIXWVHBmJ5ag9aE+c4=;
        b=QU9LUpMWtCu0xYvXDCJ5el+bJ3dMMbANgF7qv72VUv8mFaBVH2QfCg7Ny+oS27Lf6U
         m4kawYUh0IRGmyXdyouT7WBZUPzQPFrQWQeTRD1+EqdDA7a/J54VhnDm6Fw/CFw3zrww
         XAszIQs3j+dJQ4Iu8KmfEPOz8FsO/74NjQWc1PBruno79cevouF2b34WPl42x5m/5cYd
         ORyM1ALSRsU3J12XVXRtqwjB2+fYjodfOj0aCkXHyzotGOj7Eb96YpfJam3McODNUCbY
         SQlmgJn0stSQQ1Bms+/fIwj0tto5hZN4KEWjRp3iRx8S2LaQYNZ2H1SqAYY2aWbxZznt
         s18A==
X-Forwarded-Encrypted: i=1; AJvYcCX4Qou/5zh9XbgzgKiXbqBOyQOrXR4IbRLD1Bj/sEwFxyZzI9NkS+9jlzExplr5jsDME35c5luuWo8oko8G653GMTHj95+8Mm74
X-Gm-Message-State: AOJu0YyvDlN6WCe2aNSG5Lafbg3p3H1w69yyZ+Ro3wRVYK9ZUEDFZua5
	GIjt/EKK5W2CHqesZRIo8i4DG4pYaBDslNkQ4T/WXcimWPFlEb8BTdtcH0so
X-Google-Smtp-Source: AGHT+IFRmNckkjQyPTVfVxjCsaJMm6za2ny8WaaVkqbSQmHgJS9XbrIwtq9t8iiqyHlZ74DkBNTv6Q==
X-Received: by 2002:a05:6602:26c1:b0:7fa:8178:d672 with SMTP id ca18e2360f4ac-816c2a1fd63mr52960539f.4.1721156306300;
        Tue, 16 Jul 2024 11:58:26 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 06/54] dyndbg: ddebug_apply_class_bitmap - add module arg, select on it
Date: Tue, 16 Jul 2024 12:57:18 -0600
Message-ID: <20240716185806.1572048-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
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


