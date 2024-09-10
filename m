Return-Path: <linux-kernel+bounces-323189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED6973927
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936891C249E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83240192D65;
	Tue, 10 Sep 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/2ZKCVg"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716AF18E11
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976614; cv=none; b=VNf07kEggAXv7CnWGYy8Zh7agrocC18lI6fJ5zpXDswmqCM8WFn5xTMNRp0bIqXG3hqzMxhQlIG1eN0iI631AhO3SyTc0ZuBYBCfPeqWIpR5Oy0bAToYNC+KNZWDCyS8deKDExOUCfqff15j5GsF9vjxR9etLEHo13F00lL4lnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976614; c=relaxed/simple;
	bh=QabBgPx6a8SpUC8XTl9SGcrVqUuup6mA22HDPIUyoeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GyBIhpHq2GkZlsRZGjJYrii5AxyyWAvzVCW5MWi4z3E4mvUe5AIMTjvnJOAKJ5LesgMU14dzKREqO3P8658dkQ8J2zWEuGyaX62pd7dHGc7zBNcee7D3ga2iMafP4VUxeAXKiZ4cTFHMp3rZUg9Itt/va0xqI4mM0Szj7Ox/GEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/2ZKCVg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2068acc8b98so51661055ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725976612; x=1726581412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UiJ6/NiAxMWwoZLksU92Vs8y9/jjGEjZVsnJDxc3H6g=;
        b=c/2ZKCVgoIBcJr5XNElY1A6r0T0W9mYX1OBkfu0PB0gqy+xV2ctP3dBUiBAFJHaiSy
         Pd0QfeZa9F0E1ZARQT7+mWtYrtmsjwnMCQFMZ3blRXsBPjg+WAGa67d7SWH6BokykIMz
         f8ur4lGXnyVFSc9zoYwxIg5x3MNuWuCeCMNgFxkns3KBl+WH1p9Elx2yYi+aWfg6Szc7
         2nPAE34R5lJVbQllOwcZ1Kv4Gi938Qk5skY5Y1A8uZcgArIrc+6yf+LBGjpHsdvJH6j2
         5kKaYsm6lF4GcAuPx6OGKOmxnarBDJwIk1zwe9KXlwEUdUEJyjy2uUHBsflzRpUB7gyF
         wFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725976612; x=1726581412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiJ6/NiAxMWwoZLksU92Vs8y9/jjGEjZVsnJDxc3H6g=;
        b=QKIgRmXpi14hEMKEAuMKBua/BQgHLBN2m6ZaLFmEkXHrLlgnfQM9sVIiJLxZQxmaEu
         2LL7uadSfeG6Bj2/RwIq9krVteSp9gER7/CcBx+iq3OVYAyVbE3UoUxkcvey/1Ppz3Yp
         cf1F8yWKjWKEGq9MmiZ+H3UMCoSAFP9KwKBlgVsKT0iWKyyv6wPBPSADTFAIO0oTsQic
         T/eiSbXW2Subg3wCKewCHjdB7lVwLU6trDfmRg4Anw1AmMuGjHhrlKgmvAV/9DRMDa6e
         DVVp9GqKdbKV+6TQNs84sGb3BqkYCn5NdYT/bkmXRjoz1CG+vz2NPpJWMUTHi3F5skz/
         RD7g==
X-Forwarded-Encrypted: i=1; AJvYcCXhugaXb2oda4gPMmnOjmyR2NdLEfZHaNr74wkkgSnAYX96vmI8cLgDpb9lLLgm47i1at6Lhg4zu8iFe+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPt41IH1FiImKCkoJ/TsPzsJUPO2FtBHeOn7ZJkZQ8kGmGxrY
	VUmhwCFetMAyBjaEy+BqrQR30PRV6uCE+9cwhJVsZqLR6u7tY1J9
X-Google-Smtp-Source: AGHT+IEN0rUdBgXg+4In1D5q6hvtsWIDFLUtM/NmJkI5GTwJJ/oyYdIKF49k/6SzKVf0VZ02c1xChg==
X-Received: by 2002:a17:903:234e:b0:207:18cc:f76 with SMTP id d9443c01a7336-2074c5f2152mr11933075ad.23.1725976611523;
        Tue, 10 Sep 2024 06:56:51 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20714b8d48fsm47556035ad.284.2024.09.10.06.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 06:56:51 -0700 (PDT)
From: Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH] mkfs.f2fs: adjust zone alignment when using convention partition with zoned one
Date: Tue, 10 Sep 2024 22:56:36 +0900
Message-Id: <20240910135636.471-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When formatting conventional partition with zoned one, we are already
aligning the starting block address of the next device to the zone size.
Therefore, we do not align the segment0 address to the zone alignment.
This reduces the wasted zone_align_start_offset.

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 mkfs/f2fs_format.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 37d23f3..71f5ec8 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -252,11 +252,19 @@ static int f2fs_prepare_super_block(void)
 
 	set_sb(block_count, c.total_sectors >> log_sectors_per_block);
 
-	zone_align_start_offset =
-		((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE +
-		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
-		zone_size_bytes * zone_size_bytes -
-		(uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
+	if (c.zoned_mode && c.ndevs > 1) {
+		zone_align_start_offset =
+			((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE +
+			2 * F2FS_BLKSIZE + segment_size_bytes - 1) /
+			segment_size_bytes * segment_size_bytes -
+			(uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
+	} else {
+		zone_align_start_offset =
+			((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE +
+			2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
+			zone_size_bytes * zone_size_bytes -
+			(uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
+	}
 
 	if (c.feature & F2FS_FEATURE_RO)
 		zone_align_start_offset = 8192;
-- 
2.25.1


