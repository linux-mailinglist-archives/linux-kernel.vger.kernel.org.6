Return-Path: <linux-kernel+bounces-254265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2E993311A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE6C283D50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C6A1A01D2;
	Tue, 16 Jul 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8MK/CXo"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576D1A2FA6;
	Tue, 16 Jul 2024 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156314; cv=none; b=i8+HtZ+d9GNPTFD1rYZ/IXIjvL8PDUnmnrBqHZDlnOY23YDpo8+35NMSvHpuuNW72C2C2S4UU0dDUwfUB0bkpsVeQ4niJfO8oUnLu1fB54NI6Cwy3cLQc0/uEn03hmNEjx6iFEo3PTvjcv94Pwd3+ok3GKMXrU4up+3Pb04X7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156314; c=relaxed/simple;
	bh=uMahtcUZExquPuJFLJnN2pPquWpAjSBlWHTcT3D1arI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gvc0OOoW9pzuw4UKvR0xvHXvpEogExO3ckPyoQCAMwOpBcnVdUhkg9duuIWzFvrGhv/2o0rjUmGu5x78fFSqhqlEWvMe52ZXynPmY2KG5A5PSrh4qajJnrC+w9wAvGk20/94X7zg2AZJE2FpKzZWHU3IGylqUDPV8d1NZOIQCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8MK/CXo; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7fd3dbc01deso6010139f.0;
        Tue, 16 Jul 2024 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156312; x=1721761112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rzL7Ai7iKqeKJnszxdFQBmj3pbR9EFBsW0IKIFtNrQ=;
        b=j8MK/CXoAMA50iOqJTgh8s6dgvTjFpIDTuQjnUUshdSILPto/miUrAqOtxFGnprmol
         HFux9FdzRZ+6/s8IARXLlrPhkzB//VeYYYu5g34f9pbX943jj9Th5QLVSCAiD/TfZMYO
         jn2pS+7JeiLci+s+d4zfiIS0/jX9kce5VHb81qOEdaMICG7JnUG7kP81vd8AkYXWmXO+
         bilvuMfRc2jBQk54LYthib7uo3Ch7F/267pELld/uU2UMhKehFV0WuCh9xck3tnB4tSf
         Pvz33wB2WnG4N/TAdSF9B2uj0BAcXuzTaYpRce64uGVWWRdkp74iITyMD4CJ3cVUAHru
         sBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156312; x=1721761112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rzL7Ai7iKqeKJnszxdFQBmj3pbR9EFBsW0IKIFtNrQ=;
        b=CDt6sfqJrrY1iVHDzydWinESjNoddBPUtWct5recZtT12GShDq+EfAcQXT5K6Ft2hF
         veO67WrBnWvqWtWqO6KDETOprD3Go2m1mtreN0uxCsd7RpRZCONkA7m9J/EILjbiMwiE
         otSjRVbCfoKcpzhHtqDks9e3Pm40/YiD62MmsjwSccsksqslvGOUtg2qyloZo+xHiCSJ
         8v0ZLq/oaSK1bi6XZ+YiP5cZrcGaZ4S0/OdEgzbkUxcfbyfeHIOpKCS8PALIOWC/yUb2
         foICxEqCtNcHaUZdESQ54UZkN2JGo/vFjBSdzetYp3PVAL2jaWWOlWXYC7kxinIiikO7
         TjOA==
X-Forwarded-Encrypted: i=1; AJvYcCUHmc3oY8RjOdaan1fqlI2Zzm4Wocw0AebhT3yIz86YVxCer3cpjNhYap9ZI2sY1H8dlTrf45aoaNY/nRjAhnFFbU8l9YZI0RHj
X-Gm-Message-State: AOJu0Yx4xOCHkMa6HCQzuA4t5d5lSLi5g8sJba8mOdD/365KM5vVRPlK
	JxD7xjvEY/iM/P4nZ3nYPDp7UGeL/1gio0SgytMkJ/HG1AKACDwacJSTSK2o
X-Google-Smtp-Source: AGHT+IFfR30H2Bdi7TX62v9owfKKB159Qxax+zs6sy+PqRoyxnj4KxOG5l42wZ7oJYL3T2Y94rH3hA==
X-Received: by 2002:a5e:c00f:0:b0:803:8f26:e0c5 with SMTP id ca18e2360f4ac-816c39b599bmr36645439f.9.1721156312261;
        Tue, 16 Jul 2024 11:58:32 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:31 -0700 (PDT)
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
Subject: [PATCH v9-resend 11/54] dyndbg: tighten ddebug_class_name() 1st arg type
Date: Tue, 16 Jul 2024 12:57:23 -0600
Message-ID: <20240716185806.1572048-12-jim.cromie@gmail.com>
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

Change function's 1st arg-type, and deref in the caller.
The fn doesn't need any other fields in the struct.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8320cadeb251..882354e1e78f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1120,12 +1120,12 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 #define class_in_range(class_id, map)					\
 	(class_id >= map->base && class_id < map->base + map->length)
 
-static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map = iter->table->classes;
-	int i, nc = iter->table->num_classes;
+	struct ddebug_class_map *map = dt->classes;
+	int i;
 
-	for (i = 0; i < nc; i++, map++)
+	for (i = 0; i < dt->num_classes; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1159,7 +1159,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_puts(m, "\"");
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-- 
2.45.2


