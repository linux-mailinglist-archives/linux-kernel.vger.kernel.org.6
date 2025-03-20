Return-Path: <linux-kernel+bounces-570210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 420CBA6ADDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA81189BC37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF9229B0E;
	Thu, 20 Mar 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si3I6irI"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E3227EA3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496806; cv=none; b=XVJ4ilE6NrNym/oDnK3pNouoEHDmtQMWJ5CicuQGmn2qJxGezK2gzXS8KBpThaxdF29+X0otPODDXPC7AhNgbhFFMpHb9GuPZatJA9JFBUI4KGjjPElrVwaHqwFzAZ2pP+v+0vRtK+1fhgtXEOxDozUNYfXzzariEgje9I2igy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496806; c=relaxed/simple;
	bh=jTmllfX+7WznOHVsFvbpkre/ns8CUTE4QgQb0R2Hq2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt1aDuLzofD/6ZZZHrIceWFG0aEmnC9YSoi8AXKiZkP4mOH/aFU61sPsfynhz2uNUZMgIS6JDA9IpZyTC4/LdF5eXzBegH0uUXcmXffheBDKLBZXzqGfVI4fjbbFq1glrivAKBkzlkPzx84CMSKNDZqyn5fuf0e/M8ajjf+R97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si3I6irI; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85e14ce87ceso35268539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496803; x=1743101603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1nVDSOdSTk0fqBsskB5sY/F3HN+d83fKtpTqplT46k=;
        b=Si3I6irIU+9j85w8VkWnNQeAGShUeRkJtDPjFamepzJYbWEN4TmtQJQiwJncxDbHQj
         7p8tZNpirHNUDy8Y7PY55KQj5v8tVBsEpzWBpQgf7ejPJZQDgT5WPrHMCKXp7SwwSLbB
         QUuKW6vU4ftkglH+bSws64nwgXq8RxCa1QP2OAT7W/8G8OWGkZ+pPqrMgbL5+Mnemo9b
         e9LIPWLNkN+YWMrpcmHXrJqN+Ly2rwGBSWY8hNaya4SKDu7qduy2tozpFxHo+MzP9/uN
         0o2sw3fqmsrLNpFzrFJ64/tIbhuF7Jcb2r+UIqfmghCQqu+FBvKfy8PE64MUYJnCPOHY
         8EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496803; x=1743101603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1nVDSOdSTk0fqBsskB5sY/F3HN+d83fKtpTqplT46k=;
        b=X6qi+rBSdkIu3YtFe4yuUouptdh7b+YIRolVLAudWBqxND0OlU01xcwF5SW/uifJIL
         rxd9Wk7ypcOs1C+p7yM02JWmfhEX8+pwx76GelEVrITlYMDSW6fsO4BfAAylzag9UHG6
         x5UUWZAxJaH+Rs2x5yXok+29+G2u3+MTYSmwmhVgDr1f4/+6mryrDZ0d1QOjq36bPE5Z
         gh0W1IsnbShsUjI1xUVFSUAUPl8kfeGaV0xVMc0ol0VT7jcEolMb0JNyEPv9WxX84jwm
         6h+46vgfJkOJdgLnnqEw8mUe8YlM+OB8scZ1nKO5V/SZre1y9phrCUyoJ63aeZeNeXr3
         cOVQ==
X-Gm-Message-State: AOJu0Ywz3Q6xvbrBQ+UaBfFMZi32ajmNNS4zNIlTaWckdc2O7kk0xBQ3
	mJTBxzS4UGqXvvsySW9Jjul3rQMNqhntxRvbUwYHdtq547deKTNJFIO/FaJx
X-Gm-Gg: ASbGnctlPwi7mUwFw3QiVVIVDqYH1ypUczDCzG8zepv0wQZBgaxuWPeL2rdHjpqP0uu
	kdeTYjFg4sV4EirKDJtS3v1Otl2MPtCmewZje/Egoa/HllPKhJ8Iqz96WdAQwq+d3WEpzbbWPsZ
	W8RlWJiw7yb5OQ/uuIlN2+3SO0bS1iOVbUfTCl2kTs5X5evrVp41TNIBfwo7XdfqQxChld1ActM
	n/I9lK/Vi1A90F3Kz1RKPr8qIobLXytyOE9GsF4zHaNd3vxkZssQkBD46hDdcVwJKSukf6e5RtR
	hL6wihuyrIJDTHe1q78ek8gM3eipmfsOUFe+81tcDzhJBbqA5s1uTLbcAkdR043hnlQm7yHvc7x
	PZw==
X-Google-Smtp-Source: AGHT+IExFGU9ljWjx6Aj4b9tqQMNQW9GgQqOuAm24OEnh+Sl1LU78XnDIKRwIvCClszHTNZH6s9Ukw==
X-Received: by 2002:a05:6602:3791:b0:85b:36cc:201b with SMTP id ca18e2360f4ac-85e2be17260mr111956239f.2.1742496803503;
        Thu, 20 Mar 2025 11:53:23 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:23 -0700 (PDT)
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
Subject: [PATCH v2 19/59] dyndbg: detect class_id reservation conflicts
Date: Thu, 20 Mar 2025 12:51:57 -0600
Message-ID: <20250320185238.447458-20-jim.cromie@gmail.com>
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

If a module _DEFINEs + _USEs 2 or more classmaps, it must devise them
to share the per-module 0..62 class-id space; ie their respective
base,+length reservations cannot overlap.

To detect conflicts at modprobe, add ddebug_class_range_overlap(),
call it from ddebug_add_module(), and WARN and return -EINVAL when
they're detected.

test_dynamic_debug.c:

If built with -DFORCE_CLASSID_CONFLICT, the test-modules get 2 bad
DYNDBG_CLASS_DEFINE declarations, into parent and the _submod.  These
conflict with one of the good ones in the parent (D2_CORE..etc),
causing the modprobe(s) to warn

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
---
 lib/dynamic_debug.c      | 33 +++++++++++++++++++++++++++++++--
 lib/test_dynamic_debug.c |  8 ++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index aebafa1be06a..e84b6677e94d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1225,7 +1225,7 @@ static void ddebug_apply_params(const struct _ddebug_class_map *cm, const char *
 	}
 }
 
-static void ddebug_apply_class_maps(struct ddebug_table *dt)
+static void ddebug_apply_class_maps(const struct ddebug_table *dt)
 {
 	struct _ddebug_class_map *cm;
 	int i;
@@ -1236,7 +1236,7 @@ static void ddebug_apply_class_maps(struct ddebug_table *dt)
 	vpr_dt_info(dt, "attached %d classmaps to module: %s ", i, cm->mod_name);
 }
 
-static void ddebug_apply_class_users(struct ddebug_table *dt)
+static void ddebug_apply_class_users(const struct ddebug_table *dt)
 {
 	struct _ddebug_class_user *cli;
 	int i;
@@ -1272,6 +1272,22 @@ static void ddebug_apply_class_users(struct ddebug_table *dt)
 	(_dst)->info._vec.len = nc;					\
 })
 
+static int __maybe_unused
+ddebug_class_range_overlap(struct _ddebug_class_map *cm,
+			   u64 *reserved_ids)
+{
+	u64 range = (((1ULL << cm->length) - 1) << cm->base);
+
+	if (range & *reserved_ids) {
+		pr_err("[%d..%d] on %s conflicts with %llx\n", cm->base,
+		       cm->base + cm->length - 1, cm->class_names[0],
+		       *reserved_ids);
+		return -EINVAL;
+	}
+	*reserved_ids |= range;
+	return 0;
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1281,6 +1297,7 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	struct ddebug_table *dt;
 	struct _ddebug_class_map *cm;
 	struct _ddebug_class_user *cli;
+	u64 reserved_ids = 0;
 	int i;
 
 	if (!di->descs.len)
@@ -1312,6 +1329,13 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dd_mark_vector_subrange(i, dt, cm, di, maps);
 	dd_mark_vector_subrange(i, dt, cli, di, users);
 
+	for_subvec(i, cm, &dt->info, maps)
+		if (ddebug_class_range_overlap(cm, &reserved_ids))
+			goto cleanup;
+	for_subvec(i, cli, &dt->info, users)
+		if (ddebug_class_range_overlap(cli->map, &reserved_ids))
+			goto cleanup;
+
 	if (dt->info.maps.len)
 		ddebug_apply_class_maps(dt);
 
@@ -1324,6 +1348,11 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 
 	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
 	return 0;
+cleanup:
+	WARN_ONCE("dyndbg multi-classmap conflict in %s\n", modname);
+	kfree(dt);
+	return -EINVAL;
+
 }
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 1070107f74f1..e42916b08fd4 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -128,6 +128,14 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 DYNAMIC_DEBUG_CLASSMAP_PARAM(disjoint_bits, p);
 DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
 
+#ifdef FORCE_CLASSID_CONFLICT
+/*
+ * Enable with -Dflag on compile to test overlapping class-id range
+ * detection.  This should warn on modprobes.
+ */
+DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
+#endif
+
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
 /*
-- 
2.49.0


