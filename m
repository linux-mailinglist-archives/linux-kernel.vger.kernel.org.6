Return-Path: <linux-kernel+bounces-181386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CB88C7B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D084E1C21AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A2157492;
	Thu, 16 May 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK+Hqie3"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E7156F4A
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881456; cv=none; b=Rg33QKOj6XKRsku86F6yzEwAtidPTrR3WOOMRGhrLfqpK2IzL69SxivMT4hcQwldsUk4f8M0Mbm6IyV9X+bh7kyw9eKFjLOIEkLL+2gS4+2i/iIJ7Gwnoai2+HORoxy1FCjkIEGHhLmJZTnSQO1Ir8pzn+8MrHw/wvXQvilC4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881456; c=relaxed/simple;
	bh=ulmiXgsd906reEU5mkxZmxamZrST13sJiESSIufQs24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSj7dNO1RLJe0VWheaCVaGwfLqfUGbTsRxrqICOZ8qxADVJZFiRu499DI84IU3ZqKq1f9GC9DT8AEaUoGGI1K+yTwXM6b8g7N3qeY+xDh0GeiIEHXYTdJTETllNK3ARuXm4EAZkkmhdUeeYP6f80XziAy/lHTRS/IbCXfuEFOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK+Hqie3; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7e1b887c488so29571739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881454; x=1716486254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZuRS8IeAScp8y/gysB1rc+IyuJyj3IoD2Z9IwMDBuQ=;
        b=iK+Hqie3Bm7+gyhSFegedtjsEPIgudiEyfHO27PYuqV/6UIupKsmMZwHyK7STQgxhR
         aoZ8uUPTYTi/oRtkuVGGhUmmF1hRnN3s5GDayi+f5It+D9rpESP5mrzD1RGGVkf10vWE
         fytGiHO98nm3Ghiq5tRAJbyuofqA8YWRrTh0Iaw+UBQBWOTy264wctkjWOBVeVtRTixN
         nZcbWQeEQwR4rybGB1VabTCbVxrcR+IHr7waOwjaFoHaxyxaDRhS7QJvyYhsDYGpIZga
         1C44HGs+cTQQ12Ziq9aSgi+dcGylPPpaf4ILRq0WBmTRuCu0y3U/pQhf14BQweGrwH+M
         S9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881454; x=1716486254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZuRS8IeAScp8y/gysB1rc+IyuJyj3IoD2Z9IwMDBuQ=;
        b=VP1tj23HKJ8Mc0XHNN5/HdGHnosE435YUMocxjoOh/MJwK2Vzmfo6GiG7isiLpnAUg
         rX/8J59b4CWeKNo1VO2FeAlX4LjDHVm1PtgCsCJuHmLTf0OuQFJzL2OPKLcdn+W87ThH
         8KwtBN2aMc6rU14XyWHWXiukwXkVK8kjroOLjvoQw4VSKZBt7u4KAPDVDDIsddIdYjyh
         cf0bOiZvvtU7tVf8S7nMEdR+xWWFvo+7p/CAFFQgHok7hRw52qKBdq0UFppLxncXh+79
         UP10INdlqOSas78YAZ/dcSoQ2drra1+Bl5o82tRrI05TQipaGu5FiVjlj6BSiBMmD0xC
         eqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNAavsxhHo1/J0f/5eFQnyshnMmzY5ZxXGUpCYEBkYaLvxfzsa67SRZvkWvCg+5Y4i1kGYYecfwZCeELq6QZUW0sTXUZY2CUgSRXk+
X-Gm-Message-State: AOJu0YwgmijXWn4xQ2wwKuETE7CC8rc1IhYVBZxVxOy8FsFVXIYF6ZtD
	iasWV5yatG94C8c5zCeSVL3PQZyDc+6J7uOA32sb1r1uxloXqzgd
X-Google-Smtp-Source: AGHT+IF+TqjjE+8WXcXliVtf1uF9wKonO4QRNRhZ4eL8CQDDFSHt7vzGJL5dtU20RMRcP3PWxxYg4w==
X-Received: by 2002:a6b:dd0b:0:b0:7e1:be36:ac5a with SMTP id ca18e2360f4ac-7e1be36aea3mr1352182039f.10.1715881453884;
        Thu, 16 May 2024 10:44:13 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 04/33] dyndbg: make ddebug_class_param union members same size
Date: Thu, 16 May 2024 11:43:28 -0600
Message-ID: <20240516174357.26755-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ddebug_class_param keeps a ref to the state-storage of the
param; make both class-types use the same unsigned long storage type.
ISTM this is simpler and safer.

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
2.45.0


