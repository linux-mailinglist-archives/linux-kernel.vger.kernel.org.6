Return-Path: <linux-kernel+bounces-570200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02029A6ADDC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1878466A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0F22288CC;
	Thu, 20 Mar 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkHsdDt1"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7422A80A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496794; cv=none; b=AH0PApLkzzGhssIMrvoxpTOrMiNkDdnWU8qJehcBnUCHiEyNeoIWqvc8yZ2LciPILIyKl+ZOyRyrEPPG0FhdZ/jBRFwgQkD0RTajfZz9L+86+OHAF290uqE9K3BTC5FtC81k0T1kEClCmLxF4a6gfZtKg+wR50RqzK6+C5kULrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496794; c=relaxed/simple;
	bh=0Dhm60OPYd02BgLSGA/TUiS5W84HGPcUidm8klZ3WHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb38nE6c1JGZZJALw9WDhnoB99ewetDIU/6eJLnZbScBZsljPrR6miNPy7GTOxNo5Phd42hVbUOiQbnUjftM69u48z10SSkn88G7KdOxI/vKs+raczjoD9Ksm31cUDeGOtCnfwCcE8k2M+g4DZSdztOKHulSRr7bEfU+cTBZdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkHsdDt1; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b43b60b6bso41386839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496792; x=1743101592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTvJV6QS5TSCdXLFqdRdaWDLgeOVU3a+oqnRdZ34+Qg=;
        b=XkHsdDt1xCDDMbcs9wpGxemwvRJOWEmDCPh56YGNYbBAJ8Ig7uFc/1+zVpO/PFAv8t
         WYGqdT2e/nJZLXZGqX0tUNHoj8e/XzpFQ1nDB+Gh9t2PN1pTyAMM4jwtqsfvY1F+tThQ
         MHBd7ftaSmH8DEFk7Y2JG3QfNUtAst2yeDUesU3W+slvug5cK+CAFdGvF92J/wqIy3ww
         QARM+i6JPH0DPNHgQSsNtOgFLVf0iV0HAtmaJObcpqRNBsi2osMfYYQzWN0tCoNjNrv+
         /fLUE35DUZi7z6CldH3Dpd95yds06FN/roAVsVw1OS5lLxVzLPTxYC5UB3ilc5bsYETQ
         T/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496792; x=1743101592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTvJV6QS5TSCdXLFqdRdaWDLgeOVU3a+oqnRdZ34+Qg=;
        b=SKHjdomro6+7BChFzHN/iXCc8mEJVhUekr8hCyYU6+IcV6olbNfpyglzujTUjE3fNd
         nuAuCxLFUYIDrKIff5I/pvjMmqEPVK0zyVIa4VP4r1O3beUdunQyX7DMENFMGquYsBv3
         /zaFvdE38BbbO3rarZCYAzPmUBaPFdvW8+ouDHBZr21s+eOCQyj+5y9mj6ohXo5s24gR
         KH+wE270W36s5dCr85GLvXZmWRsdXkv2a+5ccaSDEjpS3YXUb+laFGzVRTEHoLLqv+Fk
         s5C7jvzDUmcj4wG3x4B/+KxREtPJHypZRwigwbd3yDtb8FsY+fwhi4D6vqGVEdvd4srX
         Jdgg==
X-Gm-Message-State: AOJu0YxH+BYUtN9fpcRganVe8RJYHLhNUblJKyiL0sGulOxZ4orhbmgQ
	xqxXm9KnKtPQjdYWMsdLFbakcSrOPzsxKzF23WfNBm8zBB9vKyRlycsTu9HZ
X-Gm-Gg: ASbGncsRVeKgs1WKGdub1uLNLrFKhV9GzvNS6Og7XiSs9xFdhme5jUuStHp/b5Cn3cv
	C/YoltbERr+B1LMF+FzzLpQiVty/4LAD26CYCNJzLdmxDB4HY1eIEHQrKfqUVlZqT9SkhErGMGs
	UJVmNNMpWeZZq5Li/beVBk7f6a2f9/3VafJTULKbup9DgA94uXOffPou13wSXvt3Dird1YBY0M5
	OOej7PA1CWbyAPFJH6hWT8csDOSzR6u0RZPVxKktR2HIRkOQGTo8RzfquJVIG/Bxs94HhErdlWp
	wtV2WDhGBIFfQV3IFThjuWos5dfruUzyG8UBw7Y5X8jTSkOzW65mgPKQ5iRbGVm1y9A4qGumnmI
	/FA==
X-Google-Smtp-Source: AGHT+IFTm9Zlgpvi08G4P5p/+bcibqVl4sDZN0j3q0oWcNr2hmLwfea3pde9nvTR9c8Y2yKOoouONg==
X-Received: by 2002:a05:6602:3a13:b0:85b:4d78:cfe7 with SMTP id ca18e2360f4ac-85e2bec5c71mr92422239f.4.1742496791700;
        Thu, 20 Mar 2025 11:53:11 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:11 -0700 (PDT)
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
Subject: [PATCH v2 09/59] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date: Thu, 20 Mar 2025 12:51:47 -0600
Message-ID: <20250320185238.447458-10-jim.cromie@gmail.com>
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

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 4b001309bb6a..dd7320b9616d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -595,7 +595,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -604,12 +605,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -621,9 +622,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -679,7 +680,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, *dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -689,7 +690,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -743,7 +744,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, modnm);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -756,7 +757,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, modnm);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.49.0


