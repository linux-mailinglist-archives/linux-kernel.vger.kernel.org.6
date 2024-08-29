Return-Path: <linux-kernel+bounces-307749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D460E965265
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138A01C2138E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443CB1BBBDC;
	Thu, 29 Aug 2024 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaQdqw9M"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DF1BAEE1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968375; cv=none; b=NrfwNvoHW6xS5puSnihAjPTHWcPTfjvoqTaOJ/s1HlJurubIwPHE4Kq10KHaW8D2/Tv7khEPy9+E7rp7Bhjayte/sK0ceES2hx/o6SbW5fErUxff6uXAKKkBsR2ZPkcBjUyOwI4CtCoLK47I9X4F1gvwdLIEpcW5AZnjnTR67Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968375; c=relaxed/simple;
	bh=KRjJjuoUUfTIWldRXultJqzCLzEmodZUEBmzS8PrfyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLMdB6U5OkgbpGwsBJD0oDj5hJvPOnOtNxCqKYOh7cFBaDWz6+nhbE60Hf2eU8uquT8sL4zH709Y/+FHbKtwfs9SAGlUPBz7aZ1ncTGV/MBsvLHDGVqEhUDVLL8hYi4NSqq/GAxkKv3FnjBK99dSZtn9rIvYDj/mczd2aC+CsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaQdqw9M; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5dc93fa5639so709396eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968373; x=1725573173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRLMPwvKQt3Fm+472wogPuvTaJti/5yUeUAEHMi0T1Y=;
        b=aaQdqw9MF3Be6FCTDPKp2V0mSOZqDEnGGlDQP734uQ4NDVRDRys8XTIL84rGhExIn7
         BBMHL9e+2su08c68riWMNZweJ2KHsDBZB6bupbR7olFjfBq3YsCMwNWARTjE7j3bXk4N
         5nlW0c1v9EkM1qDH6nJKUOEIMhcor1AgJMORkJupWrQf/opnPumuNZNfMvq/qhjSfIm1
         jds4lSWkS4zHxHnBHaJM/y7Qu/EJNjDX4tY73j4m6dBsxYuPu9jup/VFOxVuvOp88N/P
         vzP+ctQpL30PzlBf4x/am7H6iyGVjta3p1c+vgh6tApu7YmxEqvNARJf80wMJN3qsgBV
         ZXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968373; x=1725573173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRLMPwvKQt3Fm+472wogPuvTaJti/5yUeUAEHMi0T1Y=;
        b=AOjk0Gu443RqZNzH2i4Wh8p32pLxs5VszP5SyRpsWvPBmMtJKiKWDqwmWx/HZxlScI
         /WBmmf84xuDtTfanCPLZb/G9gKCeOZMUmGzwcrKt4cv1M8ghxZwen7PlW5tljbw1VmoJ
         z/7FvFN4Xp70fnDKh8uJJQUdI7mr/ryW7PelxZYlsreaVhjs1UgrdmTfd14bYH1jNY4m
         jn3Th0g47mKwm+0tV226j9fIF8PduhhcSJ85ymirWLL2WlkTsDVnA06o4IEcgqwYGTWV
         Bd/f24f7LffBnoqtQpjXurSL1o0wCpB7c1HUONj1/7TKHdOBkUVAGk04vZvrX0eBQnTC
         Cu0A==
X-Gm-Message-State: AOJu0Yy4RgPXYgg6N5M7gXu6HaJNf7JeXmzA/FW5cQEPnR3N1AomkhK1
	69Efcw6MgrNzT6M0CC/wFfAdziMCb+FL4Lsojc+JPjr0VuieqoU5MMmdmQ==
X-Google-Smtp-Source: AGHT+IHReHz5dkOTT0E3ySn9+cM7bJ/Nx1/8UlkAX6jCOafZzdoUXXv/EWl/dSX8evhDJKm++nRTGQ==
X-Received: by 2002:a05:6358:9107:b0:1ac:f2bb:8aa6 with SMTP id e5c5f4694b2df-1b603cc8d4amr518379555d.21.1724968372848;
        Thu, 29 Aug 2024 14:52:52 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:a1e7:73eb:e77e:3e2b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d512asm1705653a12.78.2024.08.29.14.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:52:52 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 3/7] f2fs: add reserved_segments sysfs node
Date: Thu, 29 Aug 2024 14:52:38 -0700
Message-ID: <20240829215242.3641502-3-daeho43@gmail.com>
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

For the fine tuning of GC behavior, add reserved_segments sysfs node.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/sysfs.c                         | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index cad6c3dc1f9c..4fcd0f824bde 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -763,3 +763,9 @@ Date:		November 2023
 Contact:	"Chao Yu" <chao@kernel.org>
 Description:	It controls to enable/disable IO aware feature for background discard.
 		By default, the value is 1 which indicates IO aware is on.
+
+What:		/sys/fs/f2fs/<disk>/reserved_segments
+Date:		August 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	In order to fine tune GC behavior, we can control the number of
+		reserved segments.
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index fee7ee45ceaa..2ed773132f40 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -969,6 +969,7 @@ SM_INFO_GENERAL_RW_ATTR(min_fsync_blocks);
 SM_INFO_GENERAL_RW_ATTR(min_seq_blocks);
 SM_INFO_GENERAL_RW_ATTR(min_hot_blocks);
 SM_INFO_GENERAL_RW_ATTR(min_ssr_sections);
+SM_INFO_GENERAL_RW_ATTR(reserved_segments);
 
 /* DCC_INFO ATTR */
 DCC_INFO_RW_ATTR(max_small_discards, max_discards);
@@ -1138,6 +1139,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(min_seq_blocks),
 	ATTR_LIST(min_hot_blocks),
 	ATTR_LIST(min_ssr_sections),
+	ATTR_LIST(reserved_segments),
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(migration_granularity),
 	ATTR_LIST(dir_level),
-- 
2.46.0.469.g59c65b2a67-goog


