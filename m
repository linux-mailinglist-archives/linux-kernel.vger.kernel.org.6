Return-Path: <linux-kernel+bounces-572000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746BBA6C542
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6259C7A4B10
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480FA22FDEE;
	Fri, 21 Mar 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN5aLRrb"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621CD1E9B3A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592819; cv=none; b=sKkhw3AqoUDx9MRgBbYUndEaaayyrTVU8bCpo77HRedLw3+Gm9zgQuQusq/twHaHuUmbCdvEjyNp/BoQfqQi973oh0UPieDKX4Utx3s16014sMmYmIwTMGcEo4dq8gHB5Ld5c3eENPZGxM9NKKaCuEdOgNbLkEoi4Ym+18+RFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592819; c=relaxed/simple;
	bh=T5d7tD8SIcC9RmsXy18j/29M4RCAvEgcpEJxiwXK3/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egCTErbR8LqQaNxBjlOh8tj914FeEjK7QWntlaYv5Pgr5DljPDfMG/kHOq8j+xxdfkCJxKVFq/l3yDE7yUtjzfGNylbHMWWFFlGJcUWFcFeDFMyGBTNhe4DhnBm/42CfvYUcCknmHpeKNBaUON8k/670jZXbGa+ApBZ5ylAd6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN5aLRrb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so4705504a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742592817; x=1743197617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3gNTEK4SXip0MhTu2oen60AgaT04JTUdvDNuHpiX3I=;
        b=PN5aLRrbyKz7zZ21wvPMsV/ndoX7vu6Q/i4WroAZEogqnqLqOWTc31sqB/3ELvJ4+Q
         zhA9SZyA1tGTNV/M/1zFoXE1DeJHy/4oBGTIRyFZ0qW2thvBVTXiPcByoDHSPo9+tQ/H
         KhO/4GZh7dIFuveC+e9KiWkCWM4GXpf9uAVlIkK0uJ/2TbvGEu7bDT06Y0kvnMzee9pU
         DK8uqvap/c/FKRGoc4PUkCaCfrnfcBbjeHi64iiekcuCyhZk3RjULUN1PoCiFEz1TeDI
         4JoIwaDSQW2ksjh/8tdDamRh99ml4D4KdVRU+bVChvqPqgh+65ASD2XbxTHvpJpkDgSo
         iarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742592817; x=1743197617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3gNTEK4SXip0MhTu2oen60AgaT04JTUdvDNuHpiX3I=;
        b=B/QyODjseEDyDMJXA9rr5jCCgoTBVLZp8ZbEvuBzokjmHtbvE8FuCf3xHwejhqbooh
         N42TNR4CD0rg9GHhQkwbayHanXl11uAxAj4W72W1oNVImM317BUtcz4O3ctlAEdYDlh7
         bHmxMGo9MwWEAyQ/GCPUhT/7homSBTrvFEP0LSyDQlOV4f3Ir8EtXIKZyE/OpBu71sEz
         j2qEAzW86vIsQ7X2Yomm5kdpqnJyfm0akd2wrM392hkL7vQ6d67Unuuxee2ZwTG2o6Dd
         kh+CLn88e5JVANv25S2qKYWMvoqczRB/D7Q/xvULDQ2qH9jMgliTRnHbgMQENiMCq0El
         0EAw==
X-Gm-Message-State: AOJu0Yw9b8nrJUpdjbj8fUmCOA4lUzB7YR/uATOLaBuO9awnbK4DDA8D
	jKhVPFmXXrj9M5Q1VsCQMQI1X2gD/1ZEVh8aOIPW9+N7pdkY/qiCTjH2ZA==
X-Gm-Gg: ASbGncvGKujKujhDydvh00Tzggg1szjqUHd5F3v2Ab9CTirmrh7/XSxXzc724SH8aHP
	wJsYr/bi6aeF4NR31myaGtPOMNwGIkL+3Kiru4/2TzWmw5Qf58vrm/Qbkk+Laq+GY31YIX3Cx5T
	F7c+CzoUKKNgqWiZP7yeexPj1vUGGpcr0x59qR4pKyR3z13bzvH/VBk0kpfEncJcQm8ELWDbfzY
	wSPPKun9cGUPRFB1Ij15LlJiD1iSbGE673baY4pGw1KdkMPml7crziRSezX3DqSYJqGAvYzesmL
	Dveoh2o7ixvrNXzLVvkivlLdTQAgj9ggNp6dkl14vz4qGue2Yu/iO/27HekAW44RmOWmStJMbMR
	PHt22+nFXsvSZZpZ6RO2kHywQmByS0YptzwGM
X-Google-Smtp-Source: AGHT+IHL4gLrRnolLn2RuFalo6zdPIhky0QXHmnL8mIVHFnAXzODNWFN6/G1zjWaxk8afCiljbC3WQ==
X-Received: by 2002:a17:90b:5408:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-3030ff0dfd6mr5993365a91.34.1742592817259;
        Fri, 21 Mar 2025 14:33:37 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:ebb9:3c53:835a:6046])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b493sm22629325ad.34.2025.03.21.14.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:33:36 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: support zero sized file truncate for device aliasing files
Date: Fri, 21 Mar 2025 14:33:28 -0700
Message-ID: <20250321213328.1170234-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

support a file truncation to zero size for device aliasing files.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: make the extent length zero
---
 fs/f2fs/file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f92a9fba9991..69952f208086 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -775,6 +775,11 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 		f2fs_update_time(sbi, REQ_TIME);
 
 		f2fs_put_page(ipage, 1);
+
+		write_lock(&et->lock);
+		et->largest.len = 0;
+		write_unlock(&et->lock);
+
 		goto out;
 	}
 
@@ -1036,7 +1041,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if ((attr->ia_valid & ATTR_SIZE)) {
 		if (!f2fs_is_compress_backend_ready(inode) ||
-				IS_DEVICE_ALIASING(inode))
+				(IS_DEVICE_ALIASING(inode) && attr->ia_size))
 			return -EOPNOTSUPP;
 		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
 			!IS_ALIGNED(attr->ia_size,
-- 
2.49.0.395.g12beb8f557-goog


