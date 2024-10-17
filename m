Return-Path: <linux-kernel+bounces-369334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5900E9A1BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB551F23804
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF151D0DCE;
	Thu, 17 Oct 2024 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSjODoTO"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C21D097C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151048; cv=none; b=AbiK4Hb3cNzjgji+i4Y0uT6D/DzeAQ391sdWdDaweAx0WdOfvFgP9qRD6LOJxKS49U4DYmRd8IeYfKdRFZxtnO6OPjxWMs9IOlC7jZRJ1AuXH2kI9W1dtw1nIR0LRJ6tWLmLvOUs4IiTeUXamd6KGARNEI0WmnX7DbB98sPkhEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151048; c=relaxed/simple;
	bh=HWKIORT8+W09Waw7flyNktUO1G3IW0avG0+KftjZrCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WbG7OoXK3qKrEdNQAER0G8vOxHDoPGNvvqRQqCG2kqBzsTXUeRyEF9FvPEVAcIks0wN0z+XaFEg9fUzT1fhx0iVNiiuxNSmccPDhXtnGGEeT+Fs8E3yUI0qZbpwF0We9AY8oZd8eciB9lZtX0zZJ9maZbJJROzt74OzUwH4FIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSjODoTO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e580256c2so483357b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729151045; x=1729755845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XhT6uxKP9Uae+hLZ9BtprRmoqKINvKXGmZwujbe2LRc=;
        b=QSjODoTOm6tRthoMPo9uZVgD81fz8y39heMW3H/pJmpY//EjuF8a6wWDyzfSl7LvzU
         DRpIePVldoI9YnfjNWUA1Os4nuBdRjH8tNSo9hrO4/YURrtxBRIMQn9T7ZvhWQxSrZjy
         ELAHC5TBurLC2kyhpOzcmQ3Jm2WjLeopog79qMmV/DwMrBywVAmlM27IQ/jiU4XBAAS3
         +O0y4RG53PKFOJobP1T+p9HZF3CuqSHeWmDO9Ks8S1AT356h3QYf7CdcHUE/S+N3hHe6
         jkzgn4G4XlfGod6TOPh5Mf1IyNmu8eccXWinW4yXSpwSeOXXChuIn26ORRVYQ6mqODet
         YRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729151045; x=1729755845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhT6uxKP9Uae+hLZ9BtprRmoqKINvKXGmZwujbe2LRc=;
        b=Qz/cc1FWxVPTlLlaw8OgG5j7v9iZ1VGKP0EYIIrrO54syx23l66s8KMbQ/wttIwM/L
         res+kUyv0Qluq4umZwWfPH0UElfggVqBXG8NndHsmY0Wan1DHMUcaDK25ZIZ5H0wVv5P
         f485h8k0rrX9FkXrWNQSzvRrk//qGR2+mBrd9kpeX2b2ia7lP5wDesDqRl1aH271OoaG
         40dyeZ7sqace9nJ+qCOD31XoaGhaBLwrI+xyUjV6rE9EtO+tETJIU2mtN7BD9uN3ZmMn
         QdZM2DyGDHOqbs9pKx7eCYnHcE9orWgYc2KzVCxY0PWTq6Fu0GH3Jap4/gt0rTd4k4Zv
         CXag==
X-Forwarded-Encrypted: i=1; AJvYcCXiJQ8l497QVAUR0hyuWh0tWtRQj8QpvLF4buyEhkcmIahnSCfK+xKw3ShDVJYCfwGGln1IZ+0UUW1yZ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYXgYqZu0x8qfopR8UocOaahUOOXEEjQwzbdfP8wWKo3eN4qi
	AU1aL5QiRsxLqhQydgEtbBp40X/8nstWH/cWqBDuFxlUaJb1GmKM
X-Google-Smtp-Source: AGHT+IHeoK+fdmwnCvRuEF5gFuBt4IZPo4cdR0NzysiFxpQdaMBkJiTW+YU5+JLubqS0oIucWGhNOg==
X-Received: by 2002:a05:6a00:1892:b0:71e:7636:3323 with SMTP id d2e1a72fcca58-71e76363525mr13079868b3a.7.1729151045116;
        Thu, 17 Oct 2024 00:44:05 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:e8b7:1946:b2b3:ca4a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77371186sm4168695b3a.35.2024.10.17.00.44.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Oct 2024 00:44:04 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC] fs: erofs: support PG_mappedtodisk flag for folios with zero-filled
Date: Thu, 17 Oct 2024 20:43:46 +1300
Message-Id: <20241017074346.35284-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When a folio has never been zero-filled, mark it as mappedtodisk
to allow other software components to recognize and utilize the
flag.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 fs/erofs/fileio.c | 2 ++
 fs/erofs/zdata.c  | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 3af96b1e2c2a..aa4cb438ea95 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -88,6 +88,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 	struct erofs_map_blocks *map = &io->map;
 	unsigned int cur = 0, end = folio_size(folio), len, attached = 0;
 	loff_t pos = folio_pos(folio), ofs;
+	bool fully_mapped = true;
 	struct iov_iter iter;
 	struct bio_vec bv;
 	int err = 0;
@@ -124,6 +125,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 			erofs_put_metabuf(&buf);
 		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, cur + len);
+			fully_mapped = false;
 			attached = 0;
 		} else {
 			if (io->rq && (map->m_pa + ofs != io->dev.m_pa ||
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8936790618c6..0158de4f3d95 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -926,7 +926,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 	const loff_t offset = folio_pos(folio);
 	const unsigned int bs = i_blocksize(inode);
 	unsigned int end = folio_size(folio), split = 0, cur, pgs;
-	bool tight, excl;
+	bool tight, excl, fully_mapped = true;
 	int err = 0;
 
 	tight = (bs == PAGE_SIZE);
@@ -949,6 +949,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 
 		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, end);
+			fully_mapped = false;
 			tight = false;
 		} else if (map->m_flags & EROFS_MAP_FRAGMENT) {
 			erofs_off_t fpos = offset + cur - map->m_la;
@@ -1009,6 +1010,9 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 			tight = (bs == PAGE_SIZE);
 		}
 	} while ((end = cur) > 0);
+
+	if (fully_mapped)
+		folio_set_mappedtodisk(folio);
 	erofs_onlinefolio_end(folio, err);
 	return err;
 }
-- 
2.39.3 (Apple Git-146)


