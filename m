Return-Path: <linux-kernel+bounces-238424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0F8924A94
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9119B2442A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6907120FABB;
	Tue,  2 Jul 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEEJLvCA"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A9205E25
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957501; cv=none; b=s5R2MTJ8fEj25oRt6fakwd0+mpHOeTWFB/ly25RDuqxwbNW0a0dHokuT7Ec+hTnWVVJcS0eheRT9qB4KSidLtXR8csEMeuopLE5zCEv0/mcp0+jpo7FNOHhGX9rUstXqW58cNF0T5P7cmPlrsN6BdSI86gBzD020Po3s9KbQbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957501; c=relaxed/simple;
	bh=uhPTREid/iI5QW+kDL12NrYcA8qj1btOyogJwiZFVEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHq+BEHZ6AtCHjM8RYArUSltxI9jJWHeyP8G+B0h0eVd0jZfERlETkuzV1C2HRaJIa7G9oJNY84Mni6s06Pm5S9eccfttpiMpiMzkzSEebw06QChGYaVxb2eqWqAWyDqTHVk5Nq1zbXHeCMKkWz6UFguH4NyllR7EZt1HkbIhwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEEJLvCA; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f61549406eso180453439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957499; x=1720562299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9Cfh8vQIJvZJJ9snElx0jBXe6PzWuVjUPtCeny8PSA=;
        b=nEEJLvCAtV1oZdR4UGorH1FppC3rjRJtAr2NFQhcJRHrC/sKiVg8JKr+bQUE8w6QzK
         ic6C8oWLZxI6Eekh1QD1zCv75dlCEeOfX3/cwBvfhI0QWDqcqYg/vgEB6d2zvXUh1IiP
         DCEYPH1cXdyshyCQbxUYRPUiiFr32jinACtaUy4wPl6s765CzDn5IjTa2wtTFHPXrB9J
         /Nz3VJWcxsMIkpaoXwl3KiFSQPi2kR9aV4jd4YPyZoeueTPYY8eP9Gi39y3aVXrG9TSG
         YSWM62bOASfvFMlKBoo6VzXb4O3crx/pMmYlowATeTipPUIwSYxHhBLJFBuClB3IhIsA
         VJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957499; x=1720562299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9Cfh8vQIJvZJJ9snElx0jBXe6PzWuVjUPtCeny8PSA=;
        b=gVK6wiwhAtZd/uH0j97clv7ZvPSj67NFWSQMrsejSNBoxbSYpO4u539rh1htKzeT7C
         EntHL5RLfbC1SVZfSC3av8uuZ0basWFb19Xlzas/6X3Aavaidncrmfd2zqvW1LJBDsLX
         RYM9HFYOW/4XPl1nuEH1/zP1yYzswI0VhyO8DP5IUNIgpXTcwqbSZsUpCSfu0gOOsVA5
         KzA09Vr5g/zwaoVHmn4Pl3KtE94XEmqrcMGnRZRWA6J0vjQ2PalV3XK8q/C8IvV8yRlt
         cf4Ys7W86UkHItNfn+aA/G6+bZFI+dQywxgj6dtfgD3FmSIuz6LXayazPDf0uJq8A36m
         WoaA==
X-Gm-Message-State: AOJu0Yy/GIX83eQc49JCVRP9Ay+WGkTTM0+H+iytMZGlw+YyFTUF6a55
	2OLORnDRUmj8PgXEpqGQjuvNmDaGIL/1mPIE1Pb6F2QcauFmOXe/
X-Google-Smtp-Source: AGHT+IG2ft1Pm2/g4PtzgBlVmK5r7iXT/FGK9csFrxluaEy4o+i8PIv1GdXT4+15tPtbVitEa/IibQ==
X-Received: by 2002:a6b:5a0e:0:b0:7f6:210c:61b0 with SMTP id ca18e2360f4ac-7f62ee853a4mr1060817239f.20.1719957499460;
        Tue, 02 Jul 2024 14:58:19 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:18 -0700 (PDT)
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
Subject: [PATCH v9 04/52] dyndbg: make ddebug_class_param union members same size
Date: Tue,  2 Jul 2024 15:56:54 -0600
Message-ID: <20240702215804.2201271-5-jim.cromie@gmail.com>
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

struct ddebug_class_param keeps a ref to the state-storage of the
param; make both class-types use the same unsigned long storage type.

ISTM this is simpler and safer; it avoids an irrelevant difference,
and if 2 users somehow get class-type mixed up (or refer to the wrong
union member), at least they will both see the same value.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4fcbf4d4fd0a..5231aaf361c4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -124,7 +124,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 73ccf947d4aa..152b04c05981 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -799,7 +799,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.45.2


