Return-Path: <linux-kernel+bounces-310113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44311967524
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 07:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79362827B6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E13A8D8;
	Sun,  1 Sep 2024 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwFfERkV"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E239FD8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725170002; cv=none; b=DB8fIUyo3u6fiOixy8NCG4wx4tttRh5fPKdoxjaN2ptRC4lxmW20lHBf5NZREnTsnABh4WUH7AZ1X9LY1ah5cMnM3RRkyp+89OO6ub+mD1zwPdV+Sq5kg+X1hP6TxYzq+xUxTv8rVrA+DtLzjhJOa5HFNjm2MO53LyxTi9a8YQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725170002; c=relaxed/simple;
	bh=f3HIRO2FtEHmgYQkGZU9b7HHyVC5AoNm2DH+bNuDE0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gjiVr/OhLoYIOlIpW2RVoOkAArnPgHgr9S9BmZJUL64pPHn2z1J8ah+g47Ued2xB33oP4IvBNU0MKO2SBrlE9vBK95tXKrVf3hn8AJZrBnDXN67FEXeq2INZARVOwr3FYk4+Phy1PY3Ptc5pBBg3YVofKa5FJDJdP+UXBEape9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwFfERkV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-72703dd2b86so443018a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 22:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725170000; x=1725774800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H10vQY2eYGxYNlauphQnXHhVCeHV2RNw8WlZZvwawMg=;
        b=BwFfERkVV+CS6lyesJrw2W6VD8ehfO+126zQT3jw4zZIjEPePc55VdSnI01MvbA40Z
         54klK9IjNMTI/kbY61oaDBG43jR3q9HcmMDuZ1j9eXG94zU3TNMS3pg9Zk8MuK52OXMH
         qG594i229hvczcAasflMG89ufclnr7fmI23Ft3rdit/n5PKcDiDSpkfRwpClyFBpViM6
         DAhKgatDAdotKvZic28HWFGQllKK7uK4JuFjO01u1bvOAGx+55m8gaMiuFcsW/5J6yWj
         ABEChy6ZCSuKzzov3yFxEJcRoubOkT8yrRu+c/Ae6zFi/YVN1IxU87vmMI/tGcEts06r
         wzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725170000; x=1725774800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H10vQY2eYGxYNlauphQnXHhVCeHV2RNw8WlZZvwawMg=;
        b=v+xW1SLri7G3A8MeGXcBNjY3RLJXp2QgqhQ8hVipU8VrGzek/mQFsh+RNwQMNtYHhM
         4r9A/L5RCyaTXzqAslKrYt/xpLp71yMJ+3x3xqrsEuA0JbwlcjneJftcz7fJGgENs/lK
         rvzPTsqoY8xEr0aZfj7H5DlM3onFj2WXzXiMWgbY+yQI4lDviiK9pm2F1t9AGyyHvJvU
         zuf5Kzc23FNB3+BoZ1qlarD7aMpUUMw3jFJ7wFGCymcLxsoGfZKKXOhK+hQkmZWRjj0s
         ZyPOQLpc5YiTuCuLGRB8g42ly16YsUvBUMIlwf7UrjfxIv1GrKe/0DFoZUPPOWQ0g+/n
         Ss0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwYUfxvegYlBuUPZYBFaRL8xeI9zXvVnOwAAela/jJdwkW4QXbseouvlBmBmcMx6PsKrYvBGoF0V8vOD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxOssdff1TVuYVF1PmM5BNQXS4rvuQpgRk2YZij7bvqAd5XhW
	CxPy2jgPT8KS0n7wc+/ymQuYhLVSHBJrmN6nByw993SL+0IbQqIF
X-Google-Smtp-Source: AGHT+IFAVOg1lOGqTcu6PEdWd7ibEkTsiB0XZ4LHjRft2CbE2B7t1f9IttV2W4e1xT58gGoBBNWlYQ==
X-Received: by 2002:a05:6a21:3385:b0:1c4:af14:d9a4 with SMTP id adf61e73a8af0-1ccee3bc42dmr3881067637.3.1725170000388;
        Sat, 31 Aug 2024 22:53:20 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:faac:461f:8c99:394])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20568bb0f19sm3387285ad.208.2024.08.31.22.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 22:53:20 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	R Sundar <prosunofficial@gmail.com>
Subject: [PATCH] mm: Removed @freeptr_offset to prevent doc warning
Date: Sun,  1 Sep 2024 11:23:11 +0530
Message-Id: <20240901055311.20905-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./mm/slab_common.c:385: warning: Excess function parameter 'freeptr_offset' description in 'kmem_cache_create_usercopy'
Removed @freeptr_offset to fix above doc warning.  

Signed-off-by: R Sundar <prosunofficial@gmail.com>
---
 mm/slab_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index d48ef4fe1ea8..ad438ba62485 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -353,7 +353,6 @@ do_kmem_cache_create_usercopy(const char *name,
  * for copying to userspace
  * @name: A string which is used in /proc/slabinfo to identify this cache.
  * @size: The size of objects to be created in this cache.
- * @freeptr_offset: Custom offset for the free pointer in RCU caches
  * @align: The required alignment for the objects.
  * @flags: SLAB flags
  * @useroffset: Usercopy region offset
-- 
2.34.1


