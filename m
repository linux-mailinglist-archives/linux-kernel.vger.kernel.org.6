Return-Path: <linux-kernel+bounces-181394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B348C7B87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F57B281AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8766158A00;
	Thu, 16 May 2024 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdGVBjrJ"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F7158853
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881465; cv=none; b=n6yixIZT/5LyzzhBVcc7gSeyu+fywUG38tkFUkHEtNe/qUFP52RGCQREANBoFXnjxcUAIWcDLIkQybA5AghCud7gS9Hc8Edm060unYU/xbKRofxvqTj/ra6EB2hp7YuXMpm8ebIi7bSLO+UfZgc+oMnOZtCrfuv+ObX5jZYQ4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881465; c=relaxed/simple;
	bh=DES3NQVjSftPoIo/YZX4J19NesczPszboxMHXTH93go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1m8R1vX020q+oXiL9envoGF40Top4tD2LwvmAzhbhXVmI6h4DEGLt+lJH6pY22w4hx3PeOpg382ze/cXgIlwMUD+QBub9HX5PXouBaPU6kEwWaBS4I//ba8feYlRC0/v+qE8QpNHgaYoKnEmW4hDPdCCb0B5N9ipMGTMF3QhYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdGVBjrJ; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7e1b4f96994so66976439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881463; x=1716486263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/+BGhbOz9ThsBPVSV0xCuQLzG1RnkW6Je60rnbWJXc=;
        b=bdGVBjrJT+4CUC+aVefLyvB5s7PHofoJPwlAG3TZ59vyiiywI162CCYK0UpCOn/6Ls
         4PCrAPBZbO4XvLq4+shIa/Un/omaRVh55B+T2708txQixFSSmnSRNAVxWlw8aBwbVrDG
         k/La9LV28B77nNuIGWX2W4Uca2F5Mk8HV1e88HwypPofjDPxNit5Gzlwkos7tn8iXcIk
         6aJaphsR/hArRwZl3JJch3D3ks2x3TF8H+GQeAkILx5VnI0Au2FwabOX+LOUWr8KTp5B
         pDIQ7H8ZUUADsl9zMHiroV/VAIKG7+Ij1A3FaSerLmz2DkefkTJL7sJA5XHLuGnurfx0
         N8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881463; x=1716486263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/+BGhbOz9ThsBPVSV0xCuQLzG1RnkW6Je60rnbWJXc=;
        b=cQLiIQ6xPlZrhkLqVCbO4xYdHXLBhM0fDm8p7Q1Q7Uwh5K7rTQFwcIYBcQWBMIL1wi
         EYxDq+3uTERcpBp+LGf2qZEYmhy/zdTx+r8TXrNXaWVGSaBywmpwocKDX9JJF4WDeifx
         AtvthcvUD6uDQqi/u1tKLwWuGEDvFg7kANnv4KUHzfbIi5c9jAsmwG+eO3SlRbXczuoz
         p81a+9DPTBOAt3k3H6pfIWbB1iA5I9+lYuy4/Lh7P2IwfNDOnNHp+Rv3Gzt/AFF9AG2p
         /+sVia4iljnZuLA5S2953zHmFBzDlKyRkdkUoQe7R7Ui3PuwtnB/fg36nV8vawuAwubJ
         Yn2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWB+56V0W7AS5dZWkvEjKsM9CfQDjexXWekQ2qC11O43zEtO8b3c/3pMFFixZmmEVdPu42nW3VL1/3WJKOaE9TInzLQ/rSWUUCJmisQ
X-Gm-Message-State: AOJu0YxJCQ0fC+bbX6XOakuxvGgo/CnlT6qDrDZ8T7j4Veb5kham6TYC
	aQ/DLSjRpgggdntIIWsGc0Kig85VSUic/lS6UxmcbZIiUz+D6U61
X-Google-Smtp-Source: AGHT+IEO8piBRBYI+ag8uXzaA691Zk/hAKmJ0I9kwSMmOeM7ZW8xidVBF2U7n3baRxAblkrJqSJrnQ==
X-Received: by 2002:a05:6e02:1c23:b0:36c:4c02:f172 with SMTP id e9e14a558f8ab-36cc1465d9amr217350185ab.17.1715881462782;
        Thu, 16 May 2024 10:44:22 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:22 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 12/33] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date: Thu, 16 May 2024 11:43:36 -0600
Message-ID: <20240516174357.26755-13-jim.cromie@gmail.com>
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

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 882354e1e78f..d4a0ae31d059 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -597,7 +597,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -606,12 +607,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
+		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
@@ -623,9 +624,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
@@ -681,7 +682,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, *dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -691,7 +692,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -745,7 +746,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, modnm);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -758,7 +759,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, modnm);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.45.0


