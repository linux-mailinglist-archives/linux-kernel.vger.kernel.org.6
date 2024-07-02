Return-Path: <linux-kernel+bounces-238432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26C924AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84E31F23D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C957317A58D;
	Tue,  2 Jul 2024 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfvgmzBU"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933683DABF3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957511; cv=none; b=qtoBtOVUnsJcK+H046ZxknEnE1IGnUfGBdvJOXP7eaOtBgVexDu8xp2rxf2zFBluahYq79/Zhnktbk2TwpblC3n5j/odIy6KMrzx4IVj0xHZpXT+JOMy+kEX3SMwoec+b8MnfbIcsH1jJWbPEfk+7SuKM2NKToxgPJEinOOwfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957511; c=relaxed/simple;
	bh=kQpImjRpf3lCUXFxXFVQ9RLQLbMtMWnnOYX/irJ8EJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXEGaVylwkU9+4WewDOOSy2GlTkknrLPtwZmhbsBsQJDFh6J53NV93Gy1pVwwAkYenir2+GBtYYQ3voQf+EhWcjQ8XQvUzQ4cgU1lCQbuwXieAICpaebiHJ5ypIX8ovO1mI7qksRB8BCBB8X1xnBh1No8ZPTrAiSMTL+Y+AG4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfvgmzBU; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7ebde93bf79so181721339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957509; x=1720562309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLqcnZIYyHoDNxKwcA/NtHztZqWZ7lBC267I9FzlvwU=;
        b=DfvgmzBUfYqc/cuIJn+/WNwF0iU60vm5wsHrlyUFAJ4+A0NXUkVgdTsWwW1ebYysQ1
         Z8i/h4177/9IqpWEZaepHEW2u0VcVHkiBLd5nKKFtb4UXVK7KXWq/MLLj3LBAep7Kig0
         FdtUEei4J7FFOez3f+NAwMF4QY/jo19wiq4zFsZ51dIo/827NlgfHZFZTItN120V5Wl5
         tcwhvG7cl7MaiT10PcA2ln9jztsfbum8q8VqaFQ7baVHGgAqtmD6383OPdylFTiZgsye
         pjLtHY3lJtQcCvU2om9KUR8B4b6gmummK63d0UUNbZttlf4iiIy74QE9JLluaapaEjG8
         wvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957509; x=1720562309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLqcnZIYyHoDNxKwcA/NtHztZqWZ7lBC267I9FzlvwU=;
        b=cOTtfHhN+UL12pYOlYXa1A+GPXKD3Ve47w8Gkn6//jkTYCfYw1IO0yvNWQKi1qL1XY
         yl4DArbOVXqjNs7YUUTul5Ry41BOxOouG8ST24aUqR0KQI9PG8+rzoDZtk4s5qRwZhZB
         S6t30qfD2sK4i//bMI4lUlySP16dxw794PW1gkGNW4kijmkj8Tf98DwFxDZwV7DGHcHQ
         hvIh1pdovLqE5JQMHsfl69QFVSholXawx47764XF7duSSzBMj8wzIZaMPPRl7HP390fS
         XD8BtxIt/LtACSyAb5zX2EO7GwlgwDHwcpXHz9kC1W6puyIrhlGDV7au/TIF8Itiekzw
         vo3g==
X-Gm-Message-State: AOJu0YyDgNklQBVM1AGtzcq6AWosho0V00/YptrYwHrBxv/qmPKHRP5Z
	JDuMfclNkDjJZurJo3IZ4clI0dwe4/Rs0SDe9dZCJkP9Iz9L8oY1
X-Google-Smtp-Source: AGHT+IEGVNNIZc+H4xshZL2c97eLukzO+VTh9nx0u7xBoOYpjR9heRfhc2y94YMqLVUj1nsH5UD92Q==
X-Received: by 2002:a5d:8455:0:b0:7f5:bd0c:b532 with SMTP id ca18e2360f4ac-7f62ed69020mr1001562739f.0.1719957508569;
        Tue, 02 Jul 2024 14:58:28 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:28 -0700 (PDT)
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
Subject: [PATCH v9 12/52] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date: Tue,  2 Jul 2024 15:57:02 -0600
Message-ID: <20240702215804.2201271-13-jim.cromie@gmail.com>
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


