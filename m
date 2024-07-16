Return-Path: <linux-kernel+bounces-254266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B43933127
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A351C23098
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90251A38E5;
	Tue, 16 Jul 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwuJw1VF"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57951A2FCA;
	Tue, 16 Jul 2024 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156316; cv=none; b=FibONGtKKh/J0JPLKRBMnKGRWKdulDu93gnNzzbIJOWYT5puvgEZUEySMm+pzIKDjsOpMqmNV22c2HR3LRn/JFBsw6tE3dGzwNo9JBVSjE7MVw0wiq07aRiCyJJnFQb1LATYsSRix2GmyYN5mEeErD2iLD1bQACoDQ0SciFBwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156316; c=relaxed/simple;
	bh=kQpImjRpf3lCUXFxXFVQ9RLQLbMtMWnnOYX/irJ8EJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSkGvpNGa9YA9c/pddWzrehIcpY0jPnC06BQ1U0/1ATcZXb/mzxAiw381cic1i78ZZiPooTKQr4qFVA7FZen5pRpHs/CBnIrUg1ERJC3SrrwjLe5heUU3mWkU2b7FotEHjT9vcIXQK7IZBjesZI7uWjrQYz4UuKIUulsS7M/JIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwuJw1VF; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8036ce660e5so6226039f.1;
        Tue, 16 Jul 2024 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156313; x=1721761113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLqcnZIYyHoDNxKwcA/NtHztZqWZ7lBC267I9FzlvwU=;
        b=gwuJw1VFmCt+bZSafp4K7WXvoaAVgOKhDZVSTZCjlJwdwk0Uj5cRBWTbbrlxp42bo3
         j2IMxo5TBSgnb4+wY6yQAdU40md3KPa1qc5XoxrONeDCfSWH/0BHfriyeKOT5kR8glzg
         hUyDx8/cXWO9uT0h4+uX9OFO7+Bw0dW9GGlw8tCdsoEozx4M9pHUlPO1mg9y/+Ou9Giw
         toG/dDLKs314/AQmbtQOQX2bWSAyx2jbCfRT1ohaufwUvSQ+FoOrr4spWo9W/l7SOHgr
         VCi4WF4rddPVh1PTfPshKwy3KxqcylnNk/N+vcVPhdZ5MWDP/yFOI8GNhxJl1HAmlT0U
         VEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156313; x=1721761113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLqcnZIYyHoDNxKwcA/NtHztZqWZ7lBC267I9FzlvwU=;
        b=lP4ZcX/toEFBGtkykTaoSUh8B8NYLGjoG0rMpG/LuCvB5Dkp3IyUxKfFsQOhYRomMc
         UT5wLlMyZM5MoSRNjLUKs2RWxmpYQ2q7bBJHn/FnJQYPuvciOY/MSovVrU9JLO4S69VK
         ejCpB2oRcwNbFSZ/oEkUctPyC9un4wvoQVHlp3ikPA/eynK87LoBX/K9gZpEk1Z0PRGE
         lzHM7ShAXF2imCGLYzRc3LgfS+S2owyL5ro2wRHIIbd/aX1GoPnPxkN6TJYMjbj0OeyH
         7ORQprEdsQ6+0KQO0fEBX/hX0qDTM694UwqYYVlszhJaS70JPOtSMYwRPlUpD5jf3UBt
         AUUg==
X-Forwarded-Encrypted: i=1; AJvYcCWOo9k9L21ykxNDENElF0Acir3HhjnR5sZTrgv5PnkSHvf6nQDj/e2OnqtwINRG5OQAeQVI5ScuAXpGOdkscWAo3NBDEbKGfO+C
X-Gm-Message-State: AOJu0YxNhF2Rq1+rLv7rR+iuuwHhWF9p5DLN4c5dWoo7PBx0h6lyEVP2
	ihqXGD157MHuaOLOZS1DwOmxE2tLO5ECE4oo87aadXwZ9ZZ/RYiuNHCx4cUQ
X-Google-Smtp-Source: AGHT+IEBh1KUyAhIwH/3Q8vkZrwZOsSPNNB7tgksRdOxwZTOxanlH2I5x4mlC8tGhLUoFXR34R5rFQ==
X-Received: by 2002:a05:6602:14cc:b0:7f3:d714:53d8 with SMTP id ca18e2360f4ac-816c642357cmr28222939f.14.1721156313441;
        Tue, 16 Jul 2024 11:58:33 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:33 -0700 (PDT)
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
Subject: [PATCH v9-resend 12/54] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date: Tue, 16 Jul 2024 12:57:24 -0600
Message-ID: <20240716185806.1572048-13-jim.cromie@gmail.com>
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
2.45.2


