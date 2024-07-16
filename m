Return-Path: <linux-kernel+bounces-254261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D65933104
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345B4282F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6D1A2C00;
	Tue, 16 Jul 2024 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToOejOro"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35A1A254C;
	Tue, 16 Jul 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156310; cv=none; b=U/fZZAsKzsfidckTwdbupCVa7r6Qlqu/IbYFiFl+ZZ6ihWz3vtOSOqvP7PfxW2otRF5c7nEl1Nc8yhmG54GDt7+8rNSqmqKnZcVy/qsEbwOoNQzfDrtlsdNzzDMxGyy+Ka/qscTjRnHXJPjGG/ILWXN3AzvZ4pCKnssfqYaMpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156310; c=relaxed/simple;
	bh=LfbPL0PeRvX6qcgfNwuiYcYLVX8gyNp/+Z0M/GkZpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvlqvWYwwTeQCZg9KWOS9QhgLzLYgQXdZ5vv+wWDXs6KsYep69SUvsvIY5zoN/7U9KhO5Rbhpv0ltWO2dpDATUqVVDD8w0urAsWViOikuDjO67xCoy6ZWfr5+UZXKs2xHDYgPERiPAqmjq5TblyBewvz08G+ugUkPp3axzFBiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToOejOro; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7f684710ff5so2495839f.1;
        Tue, 16 Jul 2024 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156307; x=1721761107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xZzQ/E3vZK+E5MMlKfK/qTb5+sylxnNOul573hVp9Y=;
        b=ToOejOroRNr58AA0iTYO8Hp96VG/Zelm+iSpQgwY04eLcTy8AgIp7FC4iF2S8MludG
         6pXNCWjwdC2DbqzShup9sGiAVf0EXNYHkDCej+QXJXA04rYL5wgYEylOJTG71dQKHabH
         qV1PeAFGiaaPTeSYOCZyf3fp4XULxYKwIbU/Rfx8PgGL2FQnWhstsWjO+SUIVX//6ZHb
         gkcJN6loqhgjtTW4WFjIS+ajmgaoir7e2T322NQUAGhdilGnX5sy+1vxL91LtTc3xIFk
         62CWq9zAlXwGIffQYIMoILav9z25DwKlQkwrh2lO6a3UPYWWFs4T8lZ14cZxq7FX+79F
         +c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156307; x=1721761107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xZzQ/E3vZK+E5MMlKfK/qTb5+sylxnNOul573hVp9Y=;
        b=ov5vHXSBAACuh32rUjzabtMP5oOYTKod3tAr1ogSoHD86+KTMKned47VykMph7cr6v
         FuNOb35V2ehfEd8YPHGBp7cT5/Fo8m8xRw440xQbrst19zGvyNEj8zD91MXilrcGDlip
         m/lLqvKFoZKpYRv1wgN1bMhGimrx5SKwunqnXzRZnj04fLhnSafWU0ry3yxMjjJB50P5
         lW3OjQfKLo9fb5IpuUjfBbme7JXRkrztnLhtuC3RGUCSqk4xJVcahBrdjZ1fXSYHD3dn
         G16nCJG4VZYfcRk/461lx/X3kHnMCOe/pBFeriQJzSOO4MV6WY6+FzF2iSz+lh9vp/Ia
         ZMqA==
X-Forwarded-Encrypted: i=1; AJvYcCVNw88wWCDumfVFeTz0//EfTGBdGI1JsQqFuBjmkt51sB2ebdRIc2nBHmWyIsh5/tN2lfe0Kuyw8SD8ME6Ig+rr4m+xQaBGn0h/
X-Gm-Message-State: AOJu0YwcpDQGU90UCVsWYASh8KQ/p1+PCv8nroVpJEetRc/f15TLRGIN
	4Xh78oqYmT/VGEoDehr6t90BrNm4j6gInAOdJ6n/xM07WiJ8W0Xr4zB8X81j
X-Google-Smtp-Source: AGHT+IFfuMTN+7knhkikS57P3DNV4ZeL623SZbQUXOKpXKyMTTpxm4y3uLOsfAj4qttEd3VwZMrCFQ==
X-Received: by 2002:a05:6602:314e:b0:7f9:c925:24cc with SMTP id ca18e2360f4ac-816c2926c09mr24652139f.1.1721156307440;
        Tue, 16 Jul 2024 11:58:27 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:27 -0700 (PDT)
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
Subject: [PATCH v9-resend 07/54] dyndbg: split param_set_dyndbg_classes to _module & wrapper fns
Date: Tue, 16 Jul 2024 12:57:19 -0600
Message-ID: <20240716185806.1572048-8-jim.cromie@gmail.com>
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


