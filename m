Return-Path: <linux-kernel+bounces-307748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D31965264
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD37B22FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14F1BB688;
	Thu, 29 Aug 2024 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDKjhoAC"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E641BA88A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968372; cv=none; b=ECiJRfN1EEI3gxLTTYWXWtvZzVGHob+pML7V186ipLQlVZAivjqcfztd1PBJBNr+HdDmTpMApt6GuWY0YTPkDXp4yE9L3oaf3IIJCIim97WEaer45fTYWlkkcBrIICtEQGrguMnwRHPvOvWMVk8CGYbrcOuZifB0MxseJ0jLn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968372; c=relaxed/simple;
	bh=jU760OJwbR9fRPYvKdp3bAl6q9zIVKUFCUiMFyEVD7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2DhBXAQbjNc+S0vqzf0Bqo99pjcIsRpZHZSJqfcxfVcXHJUyZQ0Idkicxbfk9Qz1m0gOOZ4dckcyhIsG8oouePYD68bfH4sqDN1DzPn1GdVVYZaberradBUcefS7UTSKqTUA6DvSgACnRTnsRmgy1LfPwMfweOoLnjM+vPYrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDKjhoAC; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70930972e19so510002a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968370; x=1725573170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69BLrci8h2uTitvESztrQSBwSpGSo97sp/z053MaEPc=;
        b=XDKjhoAC83aIHXJvAsqAxf0z7HOb5FyNqnkSDxY9S1ruLSPdlkrio3eHU0W+9g1l++
         swPMox1TEMlEKycC8HuXKhSrntEILqO6MAcRUp9r8hxmCYwYQ/uSC++5je5TDoy877ov
         5iCE3s3NU8/Pgi7jlPQBCJRoHQfvQGfYpMrjIPbUo+eufC4fnYf+Y8rduySLxmHo0TwW
         GPtI/H/F/LctMN5Mogp5DcCGxa81nvWrorje1VtkITkbQm8hUlCBafuCW6mDIsGH9OTs
         vI28GkYS2Wn7SthgL+z1UMZI2Y1sDS0HtZlgwDE+U/DLB8VtWZGJ3QiHzMbmubvzKxDz
         rtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968370; x=1725573170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69BLrci8h2uTitvESztrQSBwSpGSo97sp/z053MaEPc=;
        b=qiZFPeP1ygG0W9hk6S2RKulOc/aguDIx4UwkhoTgp7LFj4rRNm5vDWIpHWQ850nPBg
         OE4aNb04LNeFf+vcwiL0tSbcnezgOMc4lnWFIOLNAT+9vhZw2mztXJ0uEadHbPmjAAOm
         CSUOLutzlepsaPgG/mzaHwH7hRzpdF8LlARFaE4jNmiVv7UlnB1vwgov5fWAO4+ExH3B
         Ne7Cgpzf0gn5GbbG630u6SKSOHBvycEjGlQeS+18qV4ijuF3VYET1DPULkTzQPGB+Eah
         WsPqmZFr8Xyhas0mFjOsZ5/WcwvP3xXffM2scufKpU2kKLRjZJHFAjBrVPQFSXOyL1Fr
         0V6Q==
X-Gm-Message-State: AOJu0Yz5f5X09tGbbIZgw7wiNc5CLLPhGYSJnWU+YktKLIeORxweV6DJ
	N5LKTlz0j9paiM1rRyeFzfS8JSl05sE+0lSrEVPmLu8Sc803VnGoT01h/w==
X-Google-Smtp-Source: AGHT+IH2rAoCzKieGURg0hEYXUEFMYscZLTq0dHlouR7C/XTDPs+NEDDfKhc1cHTJv8eT6BXCLxtxA==
X-Received: by 2002:a05:6358:910d:b0:1b1:ac7f:51d5 with SMTP id e5c5f4694b2df-1b603cb548dmr515038355d.22.1724968370066;
        Thu, 29 Aug 2024 14:52:50 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:a1e7:73eb:e77e:3e2b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d512asm1705653a12.78.2024.08.29.14.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:52:49 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/7] f2fs: read summary blocks with the correct amount for migration_granularity
Date: Thu, 29 Aug 2024 14:52:37 -0700
Message-ID: <20240829215242.3641502-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240829215242.3641502-1-daeho43@gmail.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Now we do readahead for a full section by not considering
migration_granularity and it triggers unnecessary read. So, make it read
with the correct amount.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 46e3bc26b78a..b5d3fd40b17a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1708,24 +1708,33 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	struct blk_plug plug;
 	unsigned int segno = start_segno;
 	unsigned int end_segno = start_segno + SEGS_PER_SEC(sbi);
+	unsigned int sec_end_segno;
 	int seg_freed = 0, migrated = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
 	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
 	int submitted = 0;
 
-	if (__is_large_section(sbi))
-		end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
+	if (__is_large_section(sbi)) {
+		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
 
-	/*
-	 * zone-capacity can be less than zone-size in zoned devices,
-	 * resulting in less than expected usable segments in the zone,
-	 * calculate the end segno in the zone which can be garbage collected
-	 */
-	if (f2fs_sb_has_blkzoned(sbi))
-		end_segno -= SEGS_PER_SEC(sbi) -
+		/*
+		 * zone-capacity can be less than zone-size in zoned devices,
+		 * resulting in less than expected usable segments in the zone,
+		 * calculate the end segno in the zone which can be garbage
+		 * collected
+		 */
+		if (f2fs_sb_has_blkzoned(sbi))
+			sec_end_segno -= SEGS_PER_SEC(sbi) -
 					f2fs_usable_segs_in_sec(sbi, segno);
 
+		if (gc_type == BG_GC)
+			end_segno = start_segno + sbi->migration_granularity;
+
+		if (end_segno > sec_end_segno)
+			end_segno = sec_end_segno;
+	}
+
 	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
 
 	/* readahead multi ssa blocks those have contiguous address */
@@ -1762,9 +1771,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 		if (get_valid_blocks(sbi, segno, false) == 0)
 			goto freed;
-		if (gc_type == BG_GC && __is_large_section(sbi) &&
-				migrated >= sbi->migration_granularity)
-			goto skip;
 		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
 			goto skip;
 
@@ -1803,7 +1809,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 		if (__is_large_section(sbi))
 			sbi->next_victim_seg[gc_type] =
-				(segno + 1 < end_segno) ? segno + 1 : NULL_SEGNO;
+				(segno + 1 < sec_end_segno) ?
+					segno + 1 : NULL_SEGNO;
 skip:
 		f2fs_put_page(sum_page, 0);
 	}
-- 
2.46.0.469.g59c65b2a67-goog


