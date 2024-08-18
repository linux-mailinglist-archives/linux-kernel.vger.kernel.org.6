Return-Path: <linux-kernel+bounces-291065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B2955CD7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563CF2819CE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673E71B3A;
	Sun, 18 Aug 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ti7yHAR7"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95964442C
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723989498; cv=none; b=GChy4walARdFOZyrDY4VexIEUYnDsoxea7stmblyfYTkZLnJA6ACUW+soQUA6X1jeuEcjem7qo2OFk1STYqnNL9U55CgCgYxo03X6vWoD8ipbiXYDV+6CspJMps2gR8M111GnebI05//deBbLnmMM41vmA2cKyQB7yc+EYoMe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723989498; c=relaxed/simple;
	bh=L9G640q76I5sjf35H+3LA+D6rFSYn3T+ZXH6z1tdi6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQHhymXjx1TzFTkgx9mKUxW9VLsR3k91N4dtpduX1bm8CO2tTfrvXpBT2SyDtBTf2f+aMpXFsjzUzotboEZ5dGlFfFq/4ysc6tKfkuwpFvoEeT/wAcirUtXlJYcBgL3RdCIo2zsDA/K0DB0kgbyIZzX5Zzxz145nsZspzkJMlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ti7yHAR7; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53310adb4c3so3614118e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723989495; x=1724594295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5YVOgV3k3g/k3CPrGRvdRn8S9vMPP1RTyUc631PFhQ=;
        b=ti7yHAR7Gx1J8s02/ecOZkev/oykHhkoBH9MbH/R8DuDVg9gUgYSity/tMkSyULWnU
         3MVo9sqk/tOQ9iN8J7zN13EERtdmNEqtc/ThyLm8ciLvEr41ieYMGltP4LKRcpQouzkl
         a4m0S9BosJ5FmHBIc3dEZj14aNdr95MH95a8RT2eXCBNphMU32kpPKERvTggFuXpO4sq
         oiDcKuwg0d4jXoyIaLJQoeP4wp7yHTaCn2g2JTLYG62UeOsB9J1R+Kw3hIcqr+qv2Bq6
         +Y1WoRUnOfe8wV9iAyXy4uDe2NuUhGEaLY0TGk4Ins9x3BqMtBBvl0gflyDZ75KF3eYv
         4Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723989495; x=1724594295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5YVOgV3k3g/k3CPrGRvdRn8S9vMPP1RTyUc631PFhQ=;
        b=f9a+X/Wu6GMbEK5itlK4U2+7Es9lX4nKa7Ee5TxyAUl16SxpwLZLNhDR7rU7xjcdrU
         pEdQtXqkiZC1JJWDfkv3sPkF0RHnjNuG5FuZrMQiW6BeIE3bEwVSuZckby988a2Hrh6d
         DVVJMC3eS3ZJTsKswUpgSpBgk/fDAWKdiHm17NP3dIev8b1N3FxPXNBBd/aPFPhIScco
         UNZPVOEhp7k39kWecNNLc6bZRH6T5JqAFX47ZPWYILvNSarVCO8TNv5+k5Q+8jGg5X0H
         vVACogGYkROCeSu1ZSl5w1aifN+H/qiKpJe5JtNZ8kPe/9nF5gbA3acXa73xqU+M1+8j
         ndjg==
X-Gm-Message-State: AOJu0YxEX0vdXl/e8ZOEt3NkUDQ1TSCkx3JfQdxmueXKV5wAyGW7m6mC
	1F5hlbYeFPwXjym/eMAox3H7EVfN1o4cXdAdJip6cxFl8nni8/eCeegrpccL96f3nLH+fSmFzpJ
	MALA=
X-Google-Smtp-Source: AGHT+IE48naH5+JYhmKinRDxZOYDsUiAUGe6VwFsrFmbW31HE1grzk7nhLV+5GVF743H09bVOryh7Q==
X-Received: by 2002:a05:6512:33ce:b0:52c:8df9:2e6f with SMTP id 2adb3069b0e04-5331c6db965mr5686585e87.42.1723989494482;
        Sun, 18 Aug 2024 06:58:14 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934116sm519612966b.109.2024.08.18.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 06:58:14 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dushistov@mail.ru
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ufs: Remove unused ufs_old_cylinder_group struct and related macros
Date: Sun, 18 Aug 2024 15:58:02 +0200
Message-ID: <20240818135802.1832-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct and the macros are no longer used. Remove them.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/ufs/ufs_fs.h | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/fs/ufs/ufs_fs.h b/fs/ufs/ufs_fs.h
index ef9ead44776a..3dedbebcfc92 100644
--- a/fs/ufs/ufs_fs.h
+++ b/fs/ufs/ufs_fs.h
@@ -521,15 +521,6 @@ struct ufs_super_block {
 #define	CG_MAGIC	0x090255
 #define ufs_cg_chkmagic(sb, ucg) \
 	(fs32_to_cpu((sb), (ucg)->cg_magic) == CG_MAGIC)
-/*
- * Macros for access to old cylinder group array structures
- */
-#define ufs_ocg_blktot(sb, ucg)      fs32_to_cpu((sb), ((struct ufs_old_cylinder_group *)(ucg))->cg_btot)
-#define ufs_ocg_blks(sb, ucg, cylno) fs32_to_cpu((sb), ((struct ufs_old_cylinder_group *)(ucg))->cg_b[cylno])
-#define ufs_ocg_inosused(sb, ucg)    fs32_to_cpu((sb), ((struct ufs_old_cylinder_group *)(ucg))->cg_iused)
-#define ufs_ocg_blksfree(sb, ucg)    fs32_to_cpu((sb), ((struct ufs_old_cylinder_group *)(ucg))->cg_free)
-#define ufs_ocg_chkmagic(sb, ucg) \
-	(fs32_to_cpu((sb), ((struct ufs_old_cylinder_group *)(ucg))->cg_magic) == CG_MAGIC)
 
 /*
  * size of this structure is 172 B
@@ -575,28 +566,6 @@ struct	ufs_cylinder_group {
 /* actually longer */
 };
 
-/* Historic Cylinder group info */
-struct ufs_old_cylinder_group {
-	__fs32	cg_link;		/* linked list of cyl groups */
-	__fs32	cg_rlink;		/* for incore cyl groups     */
-	__fs32	cg_time;		/* time last written */
-	__fs32	cg_cgx;			/* we are the cgx'th cylinder group */
-	__fs16	cg_ncyl;		/* number of cyl's this cg */
-	__fs16	cg_niblk;		/* number of inode blocks this cg */
-	__fs32	cg_ndblk;		/* number of data blocks this cg */
-	struct	ufs_csum cg_cs;		/* cylinder summary information */
-	__fs32	cg_rotor;		/* position of last used block */
-	__fs32	cg_frotor;		/* position of last used frag */
-	__fs32	cg_irotor;		/* position of last used inode */
-	__fs32	cg_frsum[8];		/* counts of available frags */
-	__fs32	cg_btot[32];		/* block totals per cylinder */
-	__fs16	cg_b[32][8];		/* positions of free blocks */
-	__u8	cg_iused[256];		/* used inode map */
-	__fs32	cg_magic;		/* magic number */
-	__u8	cg_free[1];		/* free block map */
-/* actually longer */
-};
-
 /*
  * structure of an on-disk inode
  */
-- 
2.46.0


