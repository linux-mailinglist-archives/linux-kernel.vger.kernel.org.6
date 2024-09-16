Return-Path: <linux-kernel+bounces-331049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD7A97A7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391FA1C23913
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B215B57D;
	Mon, 16 Sep 2024 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/6WvRZW"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF01DFE4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726514421; cv=none; b=nDSWFprmnezi+t8z2SZ1dl7C+hE7sV3WkXRqr+GJX1zBoNbjKdktKnL6LBIBPwLW4P+jxCs+0T+FlPE4jeCsBOhGFNKbqTd367aI2PcKUc/YJUSckLTNQw7+R7lVVWw+D+8dG4kmqb7TqTANjYrxk5/PbF+EW0aUqzQ3Ut/Y4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726514421; c=relaxed/simple;
	bh=ZMl7vUoztAbjdUZRxOYMKtukZUb6V244faNWg/3AvyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7Z8MxqcTx9dXFHRnRLMjLftt7hJVlRQXJv0mWlks4e1bKWPMKj9L2uQmUAY8wKSXExsOr5PD81VjfvAvmSGxhr8FcUXDsWgi/TvaSk+nDm1wA8QX0E292yj9SJmdJkvZ4O5RyDvGbAGgPeMatw2LHOANinnnXeYQwVnovyJFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/6WvRZW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db12af2f31so4222886a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726514419; x=1727119219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCOzp6QHBfvs6xs4vpuMqr/hEn/jvY9MoT1Ovg5yP4w=;
        b=i/6WvRZW07XZJXbAtLXilju2QDIQMdTwbQACOQSK4SCM6zJlKm/fHcZqm/Vjaihdzp
         WBcRyWuViO9TgFyYUTTz+hor6vXgWE9fANoMtDgm7en6XGXUkh990Jb36iKAtlUEYqO2
         kvuNwnFr+12oNk5SgYO6MOR1xyB/JUBIb4FVYTZJQEy4es0PxdrmK/rDtuUv5Y7mredh
         CM7euP9XF8Qxook8vGHO7xMakVWLhwa3GTmBQuZX0uEgeAV2uDFCsc4sXwemNkKeWOIL
         j+tCnEmNqIV3N3OrarPfGrRRASg1fJEfwv9UE0MuKIeRcoVQGeFp2XFpEQtCjCTELvt4
         8jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726514419; x=1727119219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCOzp6QHBfvs6xs4vpuMqr/hEn/jvY9MoT1Ovg5yP4w=;
        b=hK6Lj3KbDyM804/0T9mUmFJQIIXnhuR2KNBnCVXPIobRHkUtCys/+D/6qOKy0u6c+k
         mv4Jw1/jS+DUuP3xeGvTE8Ug1ySRwKoA8XhJfH1OBQ/Mt8+6Hf+2QTztEzY9zBnBb+7D
         36MpULJXwnfDZqXE64KjxoenEB/9d/l3VuYJaEH+N86fbWW3a61qW34Q9lc/tMddN5hB
         YDO1fj5xWvjl0ALqPzUlKJuqMZHPFk/2FCqrdWYv2e5Ai2Ct3NEMm4rIo0KB1Up6rVJG
         i1/0Y73KXoWHvw5RkyRZNzxCbPGyYMA9BzevgmpiMumwLYTNqOSKPg1HjvAwm9++Thum
         uGDg==
X-Gm-Message-State: AOJu0YxdZYJFAKsK5yEAT6Pq0VpjawDPKbs3eQmuIyejq1qZBt6sqPgL
	3xhitBVvk2oTwDQ8DWBg/1HoVbhRCTYHO9sW2jedCJIVSHswcfa7hCG4dA==
X-Google-Smtp-Source: AGHT+IF2nMFy5fRfjIMPD4iNzaQ3EfphxhpscR8O2F4QebRfKGJA7y6e0tWvPk4fMNE2NipnfH6F7w==
X-Received: by 2002:a17:902:da84:b0:206:adc8:2dcb with SMTP id d9443c01a7336-2076e35b147mr297247795ad.25.1726514419271;
        Mon, 16 Sep 2024 12:20:19 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:b01f:7889:2bb8:3ce5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da875sm39348975ad.39.2024.09.16.12.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 12:20:18 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2 1/2] mkfs.f2fs: change -c option description
Date: Mon, 16 Sep 2024 12:20:13 -0700
Message-ID: <20240916192014.1611002-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Current description confuses users like they can add addtional devices
with one -c option using commas(,) at the same time.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 mkfs/f2fs_format_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index c98e73c..2ba1c21 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -50,7 +50,7 @@ static void mkfs_usage()
 	MSG(0, "\nUsage: mkfs.f2fs [options] device [sectors]\n");
 	MSG(0, "[options]:\n");
 	MSG(0, "  -b filesystem block size [default:4096]\n");
-	MSG(0, "  -c device1[,device2,...] up to 7 additional devices, except meta device\n");
+	MSG(0, "  -c [device_name] up to 7 additional devices, except meta device\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -e [cold file ext list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -E [hot file ext list] e.g. \"db\"\n");
-- 
2.46.0.662.g92d0881bb0-goog


