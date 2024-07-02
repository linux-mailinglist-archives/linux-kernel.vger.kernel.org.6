Return-Path: <linux-kernel+bounces-238430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191BF924AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00E32858A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560903DABEC;
	Tue,  2 Jul 2024 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSopgz0P"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB821C17B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957508; cv=none; b=STu2eR94HdzsvH9gxNIMbz7lQMK0HQOo/2HPHa/ilTTPoKLHIhi5cB3Xu2styME7loKdGhMdSsZAwbMTNRGpQvfAnv+cB3b/HbBMqpodH+p7jeI5Xu06KDgR5rJw89zld4PmndCy4JT4fjKgHR/A0fl6qve6aNAUUM1hSDF5pC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957508; c=relaxed/simple;
	bh=hDky0tcbjpEUJlBM4lJpM2oQBO65Ubzgv+qLWDk5NXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPXQyL9NnD1+/mSFomB8uJlTBsvXH8Hp2Hx98yGS0W/W8ITJ5ZXyIDGVk/o+saezWlvuMk/2aBCKKnyV1mcjIjpZ/C8aZT7vwq0skSAJz2ygiDSkXzgOSJ2tUYkOF9IvlhseU0uK1fa8PnkRME3H1X2LX2dia4inQ91tYQm5Q7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSopgz0P; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f3d3f1294dso169374439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957506; x=1720562306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kihqcq8gEwvlFuKQVqVa3kRjj6JIPweX7rDvgcIT9h8=;
        b=dSopgz0P1nlCniv0FSUgIcfDL8XOvcxWDRvl+F1pOH3Qu/X+uGTUEF8raeF5imb/Bt
         0tUiZrfIYRPXpJGgKTlvzdch5u7XvLF+mzE43IsuMCWVULspDm5oua7pDA3Cj7FW0QAZ
         WLYXLH0byupuC0eCUn5gwKAhcK7otpWrIkKVyKz5fGXcDQoQWIMJ5U9A/2HIK13DwYCD
         y5Jw8rmZ7Cz8FHS6TNMPX9OklPMtio/JJHcAh8ijZ79JxudXOHZaSm8Q7hGKFQjIkf8J
         gfAtc9K41hkTjehYZG2fY36lkY+P4zg+GfbO5dWarz/wObVsjXZ270oiB0Z12ujUJDd1
         ECFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957506; x=1720562306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kihqcq8gEwvlFuKQVqVa3kRjj6JIPweX7rDvgcIT9h8=;
        b=HbF5PgwADj23d9GCxi9DocXg+rXCuIZcAqcD/cz1oD0UXnEXVeEk5MCL8ImB1gty/X
         oqkykMjMoZgmfBtJlVFd6U3lEFBlELqbIIi4Ii0+0LiKAgVInvV0WIywAlH7KvHcIrSR
         u9NzYbhoo2Wy/x0wy5q1MPvuZZsnYZ+x25bdQ1Vg2iSbATyCOWrFKAVbZ2ME1Q9CJL8s
         6elgjcjiyJ4T3WvkiI6xABcM020OvXLQ4Nyp/ToeoXio2rCnRI6Ab2CtLoOrdUr/ARuN
         3r5IaV+JbvE9OWbcslJzPZI6NGeyGEh8L2/V74R7nFW8c9fGsq69pc3d5hqO7joLBrRu
         Mknw==
X-Gm-Message-State: AOJu0YyczwRnn7ZEhrGwECb/ME1ABxBziukLMEXWoQ46x/aWEybFQjYg
	6P8GXUn5M3zrnwbYYVMD46dNvh6JiWcOmwXyz4eyPa42NocO4Vci
X-Google-Smtp-Source: AGHT+IF8hAhxFCTOhvSpcCx/i+r/frukj2a98ZVky9/KM97IGZV37TQytURYtKcRbWkLrVOQ3MdKcA==
X-Received: by 2002:a05:6602:349:b0:7eb:cba1:b19e with SMTP id ca18e2360f4ac-7f62ee0d9b4mr1212668139f.8.1719957506351;
        Tue, 02 Jul 2024 14:58:26 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:25 -0700 (PDT)
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
Subject: [PATCH v9 10/52] dyndbg: silence debugs with no-change updates
Date: Tue,  2 Jul 2024 15:57:00 -0600
Message-ID: <20240702215804.2201271-11-jim.cromie@gmail.com>
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

In ddebug_apply_class_bitmap(), check for actual changes to the bits
before announcing them, to declutter logs.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 368381dbd266..8320cadeb251 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -595,7 +595,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 				     unsigned long *new_bits, unsigned long *old_bits,
 				     const char *query_modname)
@@ -606,8 +606,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -622,8 +623,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
-- 
2.45.2


