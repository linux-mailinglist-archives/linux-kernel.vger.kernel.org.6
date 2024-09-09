Return-Path: <linux-kernel+bounces-322166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D4C97253A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EF71F24982
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D0418DF7C;
	Mon,  9 Sep 2024 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPbfbvnr"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79018CC17
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920397; cv=none; b=MIGo5Y0rZaW/udyaD9/N+wIyrLbGWzCfms8v3MEATzpHgIFb1pk/rezY6uxMbzyrbCinsw2nrbRqMVrplZz8xhdmcsuo1xDAYS1js5+lszFkEmnQ924vSsZPq3yR3WTMNMEORGNCEYHH3bBadtwChl0d2s9lyD3uiTu+evANp+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920397; c=relaxed/simple;
	bh=wp/Mv8Ctb/+iKFe6vapKkSFhOmoqHxk0Xaoa3zyc0c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs02X2xAcrUo/CaRhwRBqShM7zz+z3/O3f8Mh7cu7R8gGuBY9SgRX9dlLh+LIJV8PXRZyc9vTIDr7o39uyVR4zRVwu7ErKSi7gVSV1089pa6/nVUDlQZnSGx/fQlspYwAhdShy5GdEZa24w3AUJKLc+TIb8leeIanNCBq1AV92U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPbfbvnr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so36784a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725920395; x=1726525195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OACeXNWxgnQWjl/GPxHOu7e05WAZ024o5ed3CF2Sd1M=;
        b=fPbfbvnrNLgk+PHglHWzKlzuyoShcl547ZzXmUDZTkJB50+RV3fq5tr0r+f/zhjuhI
         GuMhUEdAT8ac5PG5AJJ1YJCnxEKIzAL1/scK3LnCVlAKML0qSNxTFepcTIUD3lLiEawI
         T5BX7X2YOUO9cac48t4MLC3EALT10ODy9yFTWpnhSeMip2RE075bDZotKEHoAcUrLfpn
         mT5/xTPRDuOAXysXR5YVTXK0ZNEm8Pr9wi3gFBkw5JbvF6DxCqhj3gusEkYNTVgEYGOm
         oQv6fQ8t+hYh44gQprw8xvX0ycJIuU7g2Jn62ibg4E8JLLaDZ5Ha91CFKEhinSyj8YW3
         eAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725920395; x=1726525195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OACeXNWxgnQWjl/GPxHOu7e05WAZ024o5ed3CF2Sd1M=;
        b=ojsq7WfI9wozwX7W+2ub/PnRIo1JNzfp/PnV0JT6K7dkr8vwPWLV7g/UbOSxZ4vYFg
         evOaX72gQXY5u776ui8WziScA4MMfGy1HL05JI4GBjzD8hlajVHKNHG8A+dimNVH/XnF
         Hh0nV7R5rqJJSGRrBqAb7cAlSW/TQ8lmSvYitWgliFWx72PFF9Ia+CH1RWlx5mQEn+pq
         SI9txZvRZNdKufFC2HMoT86/aAhZGvTPnl2M+ucdU6PLZFmO0/i4MqyRjLEkPZXvf9jH
         KjRct20uOKEG4Z6YVjR4IYFcEvx8K+YPfyyp4qR2VYBnXrfMiftx0uY9pldlkxva6YLt
         Bv8w==
X-Gm-Message-State: AOJu0YxIcoX6UJhum+t31r+aXZ61XG1ZJyJEJvQN1LWYNa/E7bHQfMEI
	9kn3niZLmw0cvI14I3SBmLpZ29x1ojzOd4uhkLs+1Og2DndXAkkj73Ufyg==
X-Google-Smtp-Source: AGHT+IFiVrAHTyaAA3aagaI8EUCRG30d1RLs1T2oXVIq2zT/RwpjuVnxkZL2lJMP2ePV+f8MLzLbIQ==
X-Received: by 2002:a17:90a:d48a:b0:2d3:c638:ec67 with SMTP id 98e67ed59e1d1-2dad4bab1acmr12586878a91.0.1725920395010;
        Mon, 09 Sep 2024 15:19:55 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:ed56:14c3:db02:6c66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04988470sm5016840a91.54.2024.09.09.15.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 15:19:54 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2 4/7] f2fs: increase BG GC migration window granularity when boosted for zoned devices
Date: Mon,  9 Sep 2024 15:19:43 -0700
Message-ID: <20240909221946.2004046-4-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240909221946.2004046-1-daeho43@gmail.com>
References: <20240909221946.2004046-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Need bigger BG GC migration window granularity when free section is
running low.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.c | 12 ++++++++++--
 fs/f2fs/gc.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5cd316d2102d..9a3d3994cf2b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1728,10 +1728,18 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			sec_end_segno -= SEGS_PER_SEC(sbi) -
 					f2fs_usable_segs_in_sec(sbi, segno);
 
-		if (gc_type == BG_GC)
-			end_segno = start_segno +
+		if (gc_type == BG_GC) {
+			unsigned int window_granularity =
 				sbi->migration_window_granularity;
 
+			if (f2fs_sb_has_blkzoned(sbi) &&
+					!has_enough_free_blocks(sbi,
+					LIMIT_BOOST_ZONED_GC))
+				window_granularity *= BOOST_GC_MULTIPLE;
+
+			end_segno = start_segno + window_granularity;
+		}
+
 		if (end_segno > sec_end_segno)
 			end_segno = sec_end_segno;
 	}
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 245f93663745..78abeebd68b5 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -33,6 +33,7 @@
 #define LIMIT_NO_ZONED_GC	60 /* percentage over total user space of no gc for zoned devices */
 #define LIMIT_BOOST_ZONED_GC	25 /* percentage over total user space of boosted gc for zoned devices */
 #define DEF_MIGRATION_WINDOW_GRANULARITY_ZONED	3
+#define BOOST_GC_MULTIPLE	5
 
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
-- 
2.46.0.598.g6f2099f65c-goog


