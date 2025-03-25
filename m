Return-Path: <linux-kernel+bounces-574881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C909CA6EB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434FC171856
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F81E1A5B86;
	Tue, 25 Mar 2025 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kMdkIpJ/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5CD530
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889880; cv=none; b=N9Tp+XSphBF9mjJjNucYTAUG4rpo7UTFt513kXnG2e6qorsPAIBN/vI+BOTUjZSpwNeQLhMcV3HL4EhMqAisnWMlUOiM6yXP03Lr33RFv3r5gsyX+oimV8UQKiTWc2PCIPruN+S/UMBe2ALNy0S+Kj40RZOauXTsrOwuxbtkoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889880; c=relaxed/simple;
	bh=yqmQrP8iFtg6eBho0ncA9LV+PFNUu6PVgOioXYl82t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMVuFctehfqoW6nuJSheO6GDClM7VX8QJkA5dbwaL1BpZxI1fmRVU0MjAVTMNcVh0HvdW7FDPSoVcG9MF+3E6TUFmtZvZys7QeEBQ8uQ1TTcqfJTavyK6OhvnEQjiewrrotX/bl33Y9mozKmRBWmv/O6MnaZDYlHuuMBpBDe/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kMdkIpJ/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de12bso32744475ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742889878; x=1743494678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AUtkKoa3g3hBxsspuzhFy0YyIsrFmT1mIyA+rh1WJbg=;
        b=kMdkIpJ/wKPZkNWmjDICN4xePY0TXmvRCoj17Wz1fPjCTZ6EdRZCrKmThef4HqGwvp
         GmjXDPCfFkW52dCrbADqy0Y1S76765RSxbloTeYZSM0cjEuLpab5qGXTJxkdwxcvDfG0
         /VuHX/bx7zVUMRFoT70lXiyjgAfXjuKylq7Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742889878; x=1743494678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUtkKoa3g3hBxsspuzhFy0YyIsrFmT1mIyA+rh1WJbg=;
        b=pVDc+phBskan6wFjoYr0PGPeeIUvSnQp01baDZOgyLKXSRP5wO7cUYfR47HEx5sv/u
         UUrA0NCpfFad2xezRz8np9V22onB+zulOtil21dc33FCBcAnJPRHqgADdFYGeoBrQhpS
         OgaSdZshh9f10LQe5bLYJr0HtzMeAEId2O6spSS1KHANEIgPJHtzvwxxOBpOHuKywSPZ
         zhvURIH9FunJ0AKm5PQShyszhf+LGkxYLQDJjiUZxOwm0LfNurm3JC+hH8FsLtBTK9Ek
         xguVgeBZ3VzBKEPIEaW4P8thAcLJMKI2cr0jyBaHvit78SHjKEH2cPDjJaviR4wZ/FQG
         a5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXit0bhyTjMRaDYfSz9i68mNI5FGcYMmTEToqQILfcKWtSZ1kU7X6LjQITS4gGwgNZ2VKKLH0i7Xp3N51c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHE8cvwlCMnxT5xuzWzz4Ru/xVuQEhXfmI+a1arsXAxdQcdWdl
	WuSuoBvRGl+lzD3zpDG+/azp4lPkUQKPWaJRNPdPniS/lEncEmvmO9NeFRFZTmG7ctfXt4cDTuJ
	r/g==
X-Gm-Gg: ASbGncuI4fh6gG3wxtsxfuOyeOdPuVVabVODtNPeVsaxjATo/revE74aOo0KT4ftQRh
	VVad2TeUiRi9b15itHjqKiLLU0zyh+ixloj4bxB18GDmFdxL6HA3t1r97JvnUjLU7HEc3mlT4ta
	HkK7lKSintGk/QbRv6mre2TBJA2Lv+aw4LzOs2m4rSy5u3c2svDdXSLf6vmfa/QjnjXs4EgHmNk
	4QDRZqXPzTCgUOMNDq4gyEpZgPpeBvPNBLJG/RIjdkIL66knear0PcCKuHGPVHwui5NuZ1EHVYN
	yUgIAtTc8Ofu4TxJTTPOlDMhvh6kiafXxu/SXE4FkkiX/wPIEz9ONt0RnsMPeRnH/Vn/rRI=
X-Google-Smtp-Source: AGHT+IHAczMfLGWCXdItIfmDjlXsPg9Gkemi2vQzJKAzlGMp9AUyeZeYvL1KX3k2HFar1A+vaZb7UA==
X-Received: by 2002:a17:902:ef02:b0:220:be86:a421 with SMTP id d9443c01a7336-22780e14e9cmr278300215ad.38.1742889877565;
        Tue, 25 Mar 2025 01:04:37 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f107:eb57:41d8:a285])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45862sm83817215ad.70.2025.03.25.01.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:04:36 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zsmalloc: cleanup headers includes
Date: Tue, 25 Mar 2025 17:04:16 +0900
Message-ID: <20250325080427.3449359-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused headers includes from zsmalloc and move
pagemap.h and migrate.h includes into zpdesc header.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zpdesc.h   |  3 +++
 mm/zsmalloc.c | 12 +-----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index fa47fece2237..57e7a4d6c6ca 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -7,6 +7,9 @@
 #ifndef __MM_ZPDESC_H__
 #define __MM_ZPDESC_H__
 
+#include <linux/migrate.h>
+#include <linux/pagemap.h>
+
 /*
  * struct zpdesc -	Memory descriptor for zpool memory.
  * @flags:		Page flags, mostly unused by zsmalloc.
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 961b270f023c..2119af63d0d4 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -26,17 +26,10 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/highmem.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/pgtable.h>
-#include <asm/tlbflush.h>
-#include <linux/cpumask.h>
-#include <linux/cpu.h>
-#include <linux/vmalloc.h>
-#include <linux/preempt.h>
 #include <linux/spinlock.h>
 #include <linux/sprintf.h>
 #include <linux/shrinker.h>
@@ -44,11 +37,8 @@
 #include <linux/debugfs.h>
 #include <linux/zsmalloc.h>
 #include <linux/zpool.h>
-#include <linux/migrate.h>
-#include <linux/wait.h>
-#include <linux/pagemap.h>
 #include <linux/fs.h>
-#include <linux/local_lock.h>
+#include <linux/workqueue.h>
 #include "zpdesc.h"
 
 #define ZSPAGE_MAGIC	0x58
-- 
2.49.0.395.g12beb8f557-goog


