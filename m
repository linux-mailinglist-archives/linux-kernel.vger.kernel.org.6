Return-Path: <linux-kernel+bounces-570202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D96A6ADDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB338A3EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2822B8AD;
	Thu, 20 Mar 2025 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJGV6nXf"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26E22AE75
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496797; cv=none; b=Jlpczl/QyKQOVAAI64Qoayj7kdqp9kK6vbn8KgI9qqm9BxsXslMxaXpkKAjkV7EV7SdW+/S0gHxY7aHq7oAPwyFHzEcApwigDmWT9oViVQGWL9xo5my6oBmIT7JzOQ+0DCDhaVAmwV5iCKMpblNlxz+y9yfAyZIYAQSzABxEYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496797; c=relaxed/simple;
	bh=1K6DQhZhFry44gYmbighccKt/i7eLBnf4xU8SdNM/QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofjyGe9Ffv7YDVOvxGzyDvsSpxWSGCy5AcYrLgoP78N2DBgo9jNFhEluqW0IOGeD21J5SRCRkUuHIK3vK5DgzwFQnSoeiT/JOpAEIRhP7MTuhe131NNEWzDeWQN8Kf0608/5iSKI/FPwQvtqaA0whUWWvD8dVOg27edSsl2VNYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJGV6nXf; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85da5a3667bso37818939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496794; x=1743101594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur6z9vuL/Wl0h5x6aY6sqJ81bhBxaoHzCCJFlunb8r4=;
        b=VJGV6nXf4sSCMk5s7YeHzgBVUfvyHn77ZEE/a+CBjQTnhoO6XvncH9hogIjPS6vtEi
         rkxZZg7w3d9SFDTYUnmJyiownVZrglwku9QyQQVCyctCKHx4xh8XMQHM+JmnTtE/RhK3
         TZ20J1uLwEDJ7uWVqvomSpm1UgyXbGXmB7hKzq20c2//Ox2MFoBpeeDnyJL1Bk+TIVzV
         IJqXaOTebcQ4a+0uEf0Fg/QBctEWjdg34kUR+65S9rkEAhzL1NQhiAlzEOA/8Nj87tF3
         oeYwHd5S38CkFnSE2U0pQTAI0XUjXhYiTWtdUNiTSx8yHz/oxZqzYSh2XTDdAkTJxiak
         +j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496794; x=1743101594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ur6z9vuL/Wl0h5x6aY6sqJ81bhBxaoHzCCJFlunb8r4=;
        b=uNuRZYbEvUdc7y7/XWcttp0Nmi453nu4kYaINo7iLhsGKmNn+/xzRDPEPiv0oPg6XX
         35qgKH0kzcfYEPeUw+5B83ymuMe7YcQZqJgEv1HDt5P6WJdXmpEM2Nu1qUfulax/t4cr
         Cl0cPgbvh8CbEqPF+075y+hUrPw6gy+Tk+y+6H5Gc9woXDCe1aAP4qU7SNOgVeKySj3C
         CLNcodL0qjBGOn1xBo5cpLoKxWJjwbB8mAWFA+ZDeKTOYisP2MCCc1t7yGd2l/2qjK4t
         Hu7eQiX8MudMsOZxJ514VXGwg2Q4/FV7ET0Ams8DZzQtiAxJNQ/m5CJYIXwPH52rHAPy
         WUMw==
X-Gm-Message-State: AOJu0Yyen6g5aPa+a+lFQRnNTH1kzAUweizAaLP18X7FV/c9ebuGGgyU
	B+KVUtOKe8XxkgARX3NthoVBrRFBwks4aXog6+kwqw2GbbTonWxw6yig2sU7
X-Gm-Gg: ASbGncuSBOy5/eMvYNeb3BRHjFxLpnyoTrzuzaHImxCx9Ms1PNW/Q/o5lf+3IYMgHlu
	JDvRBdCgoCy2ruzqUHbQ2tkNyNGHBSRlNCnCotdXxV0TOWG+DWMlpRiFYgikggLK4FLsXeXN6W6
	e4D+igXC/NXdFMQHXUBIPqt/KNiqpPatnFflSjtrFBodLEOF1RKAU+izIUxhNI0mjlbMlMkhBC1
	6QO0BHTtE4XTV6R60faI2+rgp+YX/oQX6xOBjg1w+BKYSh5tK4bTHk3S5vcKq94ghOt7slscwE1
	WrbQltOPDIckoKz8Moms9RvxJkkTH5m8igVjxCiEe4Xk91idERtudrFfpATtJrAiUfx1rFc+tT9
	laQ==
X-Google-Smtp-Source: AGHT+IESYenQHMzRBHYonFjmp7r3ksmfWrw+L2hl6Qv939KfXIhSdVM5EOYoDB82ETAAu/GcYHzYNA==
X-Received: by 2002:a05:6602:488b:b0:85e:1879:c708 with SMTP id ca18e2360f4ac-85e2ca388bbmr48518039f.1.1742496794435;
        Thu, 20 Mar 2025 11:53:14 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:13 -0700 (PDT)
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
Subject: [PATCH v2 11/59] dyndbg: macrofy a 2-index for-loop pattern
Date: Thu, 20 Mar 2025 12:51:49 -0600
Message-ID: <20250320185238.447458-12-jim.cromie@gmail.com>
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

dynamic-debug has several __sections, each with <vecname>,
num_<vecname>, and it iterates over these with a 2-index for-loop.
These loops are fiddly with the 2 names.

We have only 2 such loops now, but are getting more soon; lets
embed/abstract the fiddlyness in the for_subvec() macro, and avoid
repeating it going forward.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d5572712ce55..94f6c8fd787b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -128,6 +128,21 @@ do {								\
 #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
 #define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
 
+
+/*
+ * simplify a repeated for-loop pattern walking N steps in a T _vec
+ * member inside a struct _box.  It expects int i and T *_sp to be
+ * declared in the caller.
+ * @_i:  caller provided counter.
+ * @_sp: cursor into _vec, to examine each item.
+ * @_box: ptr to a struct containing @_vec member
+ * @_vec: name of a sub-struct member in _box, with array-ref and length
+ */
+#define for_subvec(_i, _sp, _box, _vec)				       \
+	for ((_i) = 0, (_sp) = (_box)->_vec;			       \
+	     (_i) < (_box)->num_##_vec;				       \
+	     (_i)++, (_sp)++)
+
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
@@ -156,7 +171,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
+	for_subvec(i, map, dt, classes) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -1221,8 +1236,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * the builtin/modular classmap vector/section.  Save the start
 	 * and length of the subrange at its edges.
 	 */
-	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
-
+	for_subvec(i, cm, di, classes) {
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-- 
2.49.0


