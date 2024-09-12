Return-Path: <linux-kernel+bounces-326970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE30976F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F27F283EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75CD1BE86F;
	Thu, 12 Sep 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7D9zGtk"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5A1BE870
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726160406; cv=none; b=O/oC9oEPAjH4jSi+tEn7KFFCR3gBX0Dc+CLDdO1IzH9iqYZm53Ki9ni66Cgz8pDo3MoY8bU8KeeUYcfWl7z6PnHP2MIkJTQApsiZS7rLu+Wl7ywOexvAwTzRbzBX/DtPlgjBeNULplaUBZ3Is+nOiGj8NtpAoynpXUP4DPWzIXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726160406; c=relaxed/simple;
	bh=I5hgJtlq/CfdHea2tM7jJQ5fMVUiXCFAGWGSojf1pR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DiZbf3PXl7/E/VChsjteK54emf1iCZs4owx+If9HC9oaI6qo1H9F0YiiD/uHvPSdeHtr/rmU9pgcHGmfX5yXR2KRzBhNCNYEHDGlmKAXSL5FBR6ZrP9FXuy7+uB0bEuG7cJjFf1CFIrgFc2pxvIWDHInCDwSaXB/3EWMPY6H4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7D9zGtk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-206bd1c6ccdso12459905ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726160404; x=1726765204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIVKZWUip3GLsx70oKEFoxX4dCo2eU2HKBSzLiNYHak=;
        b=l7D9zGtkbaXozM3j+F+ER+mhWYkt0fr7ZcsF7Htvfn/stS/7F0k5Lic7xTfUbi24fm
         dY5fcPJRtzB/INg6OJ7KLnMcfcKq8e993TBOBnGZIeAG5RrprHiCkYvLY/ISzYxaHTtj
         aNndQCKJCiowrarbdqTPR0ZALpAqianR5Hk/MZzNdihdbWwX/5vYAwRWmW4XpTRxyLNP
         OA20Cpkd5NViW/PHwWlHdd4hiFnmKiRZWt/4buIkv9bp4pbTF0tfQcd5K1lh+s5r6Xd2
         xuESGaqfA3oYZbOr0ZuIvctZxhTikys9Lv24u40IoEfLQn7rVU/icAPA55Zn9SfmkZYT
         jWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726160404; x=1726765204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIVKZWUip3GLsx70oKEFoxX4dCo2eU2HKBSzLiNYHak=;
        b=dF/MUZT9zCb9hZPigbl+57jc/RRjhPJdFJK9fhUwfcIcHkoQXtSUjJuA/l7bExM4AV
         NKYozNPHfuijWg14nXWAaFLafKkvrwXg145NnQ5WgqjghcrIIRsWhqmV30pP48m+MHc9
         qw8hnoTVwdBXTzzlihOX/02cr+C+vwmPELH7jG/wuXKNBQB8f57cEMyrs5ID4fRKGswF
         CRAqEzew/3AwSfEw/W4+FbRLFAxU13SM/MYzNoC04WLWgHXLBM5DkM7yfs6FdtSIpaWi
         QYa9D9TGyTL1Hf7anJ1685Yookt1aQWd8R4++G0B+gFRRsM4hSaHitHbYlnct/b/c/ew
         JXrA==
X-Gm-Message-State: AOJu0Yyo/oquwAzH1ThiS58sY6fbYFPg4HtnBrs7drX2htUVFtN8x0nO
	8ScJamSs6KPooyu9Bbmi09EbMwMRxT7dnJn5xK2TrY9bvwV6rb+N70pXsg==
X-Google-Smtp-Source: AGHT+IE02vl34aJqOrFB6OC4nqdE9Xan48RKJeN7El4vbOPifqBDLjurvNnyBh3MHNswUt5tytY8sw==
X-Received: by 2002:a17:903:41d1:b0:206:d6ac:854f with SMTP id d9443c01a7336-2076e3157aemr52560915ad.3.1726160403556;
        Thu, 12 Sep 2024 10:00:03 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:a5d8:3c37:f48b:3b20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b01a093sm16309775ad.276.2024.09.12.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:00:03 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: forcibly migrate to secure space for zoned device file pinning
Date: Thu, 12 Sep 2024 09:59:58 -0700
Message-ID: <20240912165958.386947-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

We need to migrate data blocks even though it is full to secure space
for zoned device file pinning.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
---
v2: change to fit on a new prototype of do_garbage_collect
---
 fs/f2fs/gc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d3e3104c4492..baa98c3bd667 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2070,8 +2070,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
-		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
-						dry_run_sections == 0, false);
+		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
 		if (!dry_run && get_valid_blocks(sbi, segno, true))
-- 
2.46.0.662.g92d0881bb0-goog


