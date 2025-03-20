Return-Path: <linux-kernel+bounces-570206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F18A6ADDF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07D3984D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E8022CBF8;
	Thu, 20 Mar 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhu/AGb2"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41122B8DB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496801; cv=none; b=HpoXwhggFeOjL4wQoHGnKZ6gNBxCre4gPbC4L5UQX7DqnMlp7TuQCQY2p8n8p+OoCbYBi+Iy782le/zB2Lfdc/ESU9UT6Ugn0Ts28wjPADl2iOEn3RlFbpK7RqYvxlGr0dwL5IavO7SNuNU7KE6+E4gM3tZn2r+x3kInv0JzfQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496801; c=relaxed/simple;
	bh=LDPjjvj1+ESf+Tko3z87s2Q4I5ChRFj1fM9WdfaD/o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQt+Rgzxx4+6vmt0dwUHWiWUAmwmpe3KGtyVerLtQDz+8TNS77t5j8jRPlJKSv4iIV1vOu3OMl1sJ9OWaAptD1imJmBApCoEq5/izp2N4C2xB8w5otIcBwY+KC5gI2RIl6hIRpDdbIrq/2RN4Z/hFzdUaY2G6RE1kWYbEjTPfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhu/AGb2; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so103380639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496799; x=1743101599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kaCTiwhJayt1JlAfm8DPKyx6wcUxQmldJtN5HWBOOw=;
        b=hhu/AGb2SFl86C70J5w2Eu8MK83feUEhY/6A4VqMFHC2Qn6MAzDvKmx98iN2YqI4DN
         fs2j4PScfzNbY7zMHG8+wGar1B6U4QEmGXkNYMFJo8FYH3gBIjlt5AMzSDB4IEpLTQ6u
         yACzunYl0l9FsBLce4zWH7U0a7zYQw9qHyx2zQrNAzZElkgS8QRfLcyp8mbhgEVHkr6q
         GszYQxT6/YECKJog0UB0LR6m9ZO0lJTmRPTLup1o9Vfmbpf8/j5QAdkl/R6D/WI8LUCy
         Lasi1CYvNpTAln1keqekopsEzUfJVW3iw3yVVkZ4JyH/Tasfk3n91nXzp0P8df+o+i+c
         3/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496799; x=1743101599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kaCTiwhJayt1JlAfm8DPKyx6wcUxQmldJtN5HWBOOw=;
        b=jbk8mN/cde6zaMFCnIXCW1M2fqK8Um/gsDnV1KQutmlnRgwQ4SdJUtPH1bc9IT46DI
         u0/DpuLSxmFagiQicIuPvUy92iScP0PGx3BXIrXs8wrqiDqlwkZlZ620FaP1vvYZahOK
         pbHfYW8ojOh7HQ5sDx7TzJYWyGNJ6EMs5+4MdIgG+K/fTSb9VjWt8xK4iYyPImsJOguH
         7WNPlCHKkXXAkBO1BpgW0TwlvgDSdp7ImBSZb4RizeAG0MufDgRtwPpFK1mPS4+4Y6Hj
         E/hXknySbTopaH3WcOa6vDR7yvaHy3CRcIGWXeSR7LzxQlWvrMcrfWcyjxq+Z7wmvUdU
         1INw==
X-Gm-Message-State: AOJu0YxRG81vQ9LZNwYMa9SMmaof29AqiCnjIm3YsE6JV7hBm1tlqJwS
	x+4vXfjFVfTfjI6AzG+0DEkV/8/lJLqxf13GIAPSXz3i16LXkdLH4xW3dhy6
X-Gm-Gg: ASbGncsKi90U0qlq5/a9aOD2/9CfGfPKwKqjPe6/CXGeSKxcrCz1ui2qa2dCYCop+mM
	in4sO6EFW6yzY2uQ+8b2akmmr66cK9UtRdjxy7R6HoCTbhj9PIGploDjEy56rAqztVQPbIFuK6s
	y/NGt100juhwKCzlNHTZt555l5Zgs4XCp9Wh+Roxkc/vDYcMpMuh6QpoHJ+h/HDnWRDgs2f/NdW
	6Iz3+wlRUdLseuH6Atvmbe6bRORa1hPLikGz4lqZ2riZe6Lvt/pwO6DmiPMx83/cErq0+PLJy1x
	RW1Z5DxJaxPvg6QdbfF2QqGRMEQPJ9uVSlbmP1ihSOphnfMWh1b19S+SEnW++fAQvJbNZVD1vV5
	sSA==
X-Google-Smtp-Source: AGHT+IG+eXZQew9Zz3S46b21hITOH+yZSzgsGUgOD50otkztworp1cnBoNHaVXECO8PqrRp10phT8Q==
X-Received: by 2002:a05:6602:3587:b0:85c:c7f9:9a1c with SMTP id ca18e2360f4ac-85e2cc5fee2mr44402139f.13.1742496798829;
        Thu, 20 Mar 2025 11:53:18 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:18 -0700 (PDT)
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
Subject: [PATCH v2 15/59] dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
Date: Thu, 20 Mar 2025 12:51:53 -0600
Message-ID: <20250320185238.447458-16-jim.cromie@gmail.com>
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

The body of ddebug_attach_module_classes() is dominated by a
code-block that finds the contiguous subrange of classmaps matching on
modname, and saves it into the ddebug_table's info record.

Implement this block in a macro to accommodate different component
vectors in the "box" (as named in the for_subvec macro).

And hoist its invocation out of ddebug_attach_module_classes() up into
ddebug_add_module().  This moves the filtering step up closer to
dynamic_debug_init(), which effectively does the same for builtin
pr_debug descriptors; segmenting them into subranges by modname.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 57 ++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f7ec2365ab40..192783ff7b98 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1242,30 +1242,34 @@ static const struct proc_ops proc_fops = {
 
 static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
-	struct ddebug_class_map *cm;
-	int i, nc = 0;
-
-	/*
-	 * Find this module's classmaps in a subrange/wholerange of
-	 * the builtin/modular classmap vector/section.  Save the start
-	 * and length of the subrange at its edges.
-	 */
-	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->mod_name)) {
-			if (!nc) {
-				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
-				dt->info.maps.start = cm;
-			}
-			nc++;
-		}
-	}
-	if (nc) {
-		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
-	}
+	vpr_info("module:%s attached %d classes\n", dt->mod_name, dt->info.maps.len);
 }
 
+/*
+ * scan the named array: @_vec, ref'd from inside @_box, for the
+ * start,len of the sub-array of elements matching on ->mod_name;
+ * remember them in _dst.  Macro depends upon the fields being in both
+ * _box and _dst.
+ * @_i:   caller provided counter var, init'd by macro
+ * @_sp:  cursor into @_vec.
+ * @_box: ptr to a struct with @_vec, num__##@_vec, mod_name fields.
+ * @_vec: name of ref into array[T] of builtin/modular __section data.
+ * @_dst: ptr to struct with @_vec and num__##@_vec fields, both updated.
+ */
+#define dd_mark_vector_subrange(_i, _dst, _sp, _box, _vec) ({	\
+	int nc = 0;							\
+	for_subvec(_i, _sp, _box, _vec) {				\
+		if (!strcmp((_sp)->mod_name, (_dst)->mod_name)) {	\
+			if (!nc++)					\
+				(_dst)->info._vec.start = (_sp);	\
+		} else {						\
+			if (nc)						\
+				break; /* end of consecutive matches */ \
+		}							\
+	}								\
+	(_dst)->info._vec.len = nc;					\
+})
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1273,6 +1277,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
+	struct ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1294,6 +1300,13 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->info = *di;
 
 	INIT_LIST_HEAD(&dt->link);
+	/*
+	 * for builtin modules, ddebug_init() insures that the di
+	 * cursor marks just the module's descriptors, but it doesn't
+	 * do so for the builtin class _maps & _users.  find the
+	 * start,len of the vectors by mod_name, save to dt.
+	 */
+	dd_mark_vector_subrange(i, dt, cm, di, maps);
 
 	if (di->maps.len)
 		ddebug_attach_module_classes(dt, di);
-- 
2.49.0


