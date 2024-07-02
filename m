Return-Path: <linux-kernel+bounces-238431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1677924AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962741F21DEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A533DAC0B;
	Tue,  2 Jul 2024 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNNckNkP"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000B21C193
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957509; cv=none; b=Ih37bTpJ2454HxmmVrYRAV2ni2C9A09wKgftKFWVkjATHKV+jSF0llNRkAxmR8llI4ZxTdt0jU9ZTXrIH2RsAdPjQfot8vIMvqBAZ8sQSeonuyxGn8oC14lUDqKzDrA2aw58nLNGyJ22EstB0toLR0XiT5iA4EQvYivch5UKiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957509; c=relaxed/simple;
	bh=uMahtcUZExquPuJFLJnN2pPquWpAjSBlWHTcT3D1arI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ4bWjrchKIblwrGY1PSsnSTWfm2PduGo2FMBCHvvu69Fo7Y5ARKw6RUA3vnyZVGT6Qc7mKupjpS13MG1adzs9JSs4ojbvCpoaAfkYR1spYftY5R2nfafbH2A2Alr1ukN9mU4qoSyHmaPpd6yX5aRpzOE0dLcE2oRMBroyKeiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNNckNkP; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ebde93bf79so181720539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957507; x=1720562307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rzL7Ai7iKqeKJnszxdFQBmj3pbR9EFBsW0IKIFtNrQ=;
        b=MNNckNkPQltvJjDpdZ5i/6it1AvmrtkKw5+C89p1di4dqHUhElC7BuUW1FtNEqoo5F
         AbbZGCjzzJIXWcV6kM0XxQKuDqVoCSQax8eOTD8Tsa/llP7xmVHIj3gEhN6aa1W+2FGi
         dnVaR/+4Zpxtg/m9CVtd/0kndozIk4J4cYcKRN+TrixrPRrP5CWjAJYeaNryiRJ+VQpy
         MreMIrRN0IEDYRZ2PnB3KzdUZnH+dAwo3F0hcsdqqa54bR2RIm1S4iH7fAKrYD1eTr0i
         bP+Sp67bCBYezEec1aTWr1cU0oAtUQl9Hiht5TrXZTpT7q4UtvDNcGvsCx6HFsMDem0R
         3FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957507; x=1720562307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rzL7Ai7iKqeKJnszxdFQBmj3pbR9EFBsW0IKIFtNrQ=;
        b=UYLPjLxLarbjX28c73ePh73+ky2Crb53XbPP1aAN8S+dtro8tN7nGxJ4+7ebojqSn9
         akXNS2/XSCp9Edpq6hgv1u7yOBfDKY7sLxmBQCyCWnJ1conPzUJIOKafAGJhaeBLYUY8
         LtIQxKhK7pcPwvcVGvy4i1U0twdwBaIwkHpp4TbnQ54/Er7NsYOxYuXtM/gajon/xazD
         CdrnZdFcB/repUwr0JjsOhKY8ZHAuoVwI4vnUXDlaWIFIPDSeV+44J5S3NKgpRAy9bxs
         VeoY3bg22hqhUp4OdiyqbVlFQ3a+JlGWUcTclJ8DOuzhfc6kgF0/A2hy46YV0CkB9BeK
         k36g==
X-Gm-Message-State: AOJu0YyQ8L9Ld4nnfrfflqgiabpXmKTYm21ApriEw4Gru9kI7cBR0UW9
	wgcAfvicLctmXOmyYrbzvfmp+HxSxwY4YbutfGmKdYrMXERFLYtA
X-Google-Smtp-Source: AGHT+IF56ls3w7f2WSNbJ8aXQHldMBv+gn+afom4mP2VlDrZdzOAf5MG5lr7DVKBeB+D9m7lbJ2S+w==
X-Received: by 2002:a5d:840d:0:b0:7f3:d89c:601b with SMTP id ca18e2360f4ac-7f62ee54715mr1057898039f.5.1719957507558;
        Tue, 02 Jul 2024 14:58:27 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:26 -0700 (PDT)
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
Subject: [PATCH v9 11/52] dyndbg: tighten ddebug_class_name() 1st arg type
Date: Tue,  2 Jul 2024 15:57:01 -0600
Message-ID: <20240702215804.2201271-12-jim.cromie@gmail.com>
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


