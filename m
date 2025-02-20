Return-Path: <linux-kernel+bounces-523354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B762A3D569
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D0F7A7734
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AE41EF0B4;
	Thu, 20 Feb 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEEW7DPz"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926891CAA9C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045160; cv=none; b=a3zie/hBjacBcjjImjLPVxe4yriMtFB7UVeFYw4rRCAoC7eCbG5gLVfLx/qteo7sZk6gX7WC+fGP+Z/VLxrX+1PrCohG1rLZxlARKENMduKBs7ojV9J5RuMWdCzr/jAYR/y1oTDIi/ONT0U5pDa/vNXNHgx9Fg/G0oUkpKYuwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045160; c=relaxed/simple;
	bh=Yr8RMKXKdGV5oJjT0KPtw2wvX3kiO10N8z9eFC0ljUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XoolrMYT6FaRGhKb86pVzwt3Lu0Ol1ehYOb9g7LjMT7jj3Sls13IIzQ67v87xVxE5dcFFH4CSltb+aPtgAhX3vJqQjKYsKGcrRiU9ULvnSeAmUrwKZI+CfxDzkNM/y1NVKGVcPMRIpnGrHiZICMfzZdmII0nN5ARiVF+jj535LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEEW7DPz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-546267ed92fso905772e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740045156; x=1740649956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oYeH3hsiujJqSPD+ca7uJNb/p23dTbfjFDyBF22SX3c=;
        b=UEEW7DPzE+s8zZ54kuRNk0krDYK5NzWz5exGjR7mcUJ7KB6DtYVPT7sONVFTZ0Gym+
         r1XSinXprmX9N52UZdM63p9gM9HAq+REjHsRzKWT038JPJC890VinM7+gMbFPdVa8pNI
         E9K5LWRcYuo8ZGXkvp69mUa9ioYUCdBtFiOASa+JUq1E4nFnJRbf04mDA3lFMoUHj3wG
         e0Mv3lUD8J7Jv+YIq4qiSdqX04g0eMsxv6hgimlrFrOHG+sdr29SPMpFj6fWMHhQEq77
         /eltjLxEyOYItIqVv5Pt4RbWpS/uzjvZR4zhK4g+OR1My5nfWZzSN/toPIJ+4UD6OXAQ
         FjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045156; x=1740649956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYeH3hsiujJqSPD+ca7uJNb/p23dTbfjFDyBF22SX3c=;
        b=t15GdjXZtJJLCTlFKwy/bu+RMPLeUx6BXskufkSVhSpNjq+RGltgGQ88twAxWhdbTL
         gCv6xBIzNX3SKnilrHKpmQZPSLmP40cH/lsUS4lIN/jT49LBSSbiBIV77Kgolts+4xrt
         Flr5rFulrqVgjh3D6AyTk4x/b9EvqnWH7gdHX+nxtzHi6Ysfm6Q/7uwvihFVsC/mOTex
         iU2bTRypmfZPh+VXUN/ihoIOIbvVtF9OCp/qLXLbP36svta+sfiaxw2awOxKzT1Si0z7
         vS1j/DUYc817fbC7U0raAX81w4MgnXGv6/bTofdUGTwInsbyqIzWDH7Adp0YzYTYWXwx
         aMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk8TYGDBqNhbyGcrw9sJv/puRSXNaNrV1u+kMiewx4U8hNAc2cUNhasgMBX4jbmoD1/EEIUdDCDvn2Wek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDJTd6+8TILrLfGE+0Syd8lGbmef8RPkyBAyAglo7JF60rKez
	QDyTbgwpHU4LDasuEP6hdRd8XQDC+IUPmbqTdTP6uiIz8lspRu11
X-Gm-Gg: ASbGncvtK+IJNe50nbsDnYPfQ5JPSIHqfbLs44cMa5oqXg5x8lRSAyWdLmbBpet+qqB
	OH2edChNMRFT1sVmRdQbNPuVVZu8++1f+/SMoJrkvA2aJ3m6l3bMud+VfatobBaZXqtVdk9+sdR
	CHryUE/7NjWTF3OJW3HF3zaaDKX5YbtGZfzsqBVLRhy9niBWIeCmxKrK0K5v83OgR+lCQdKeTUb
	19s3Q9OhnwFGFTbBWpwxxnVJ+jDD1VZavy3mbKwn07xVwXLoJLmwRQsOc0k8v0INyDosmI4OjF4
	1qXRpFJlxBn4uFVx0nrH2DVYzdqOJcIRSk6KU096ihaJ9eVns3EcpEmkPw==
X-Google-Smtp-Source: AGHT+IEs1WdJOsowbPu0y6P5M0ykiG0ZNKvSxS8Q3SxhJOnODBOR4GHwarRnsfe4nv6Bt0HQ2krh5Q==
X-Received: by 2002:a05:6512:3dab:b0:545:11fa:caf0 with SMTP id 2adb3069b0e04-5452fe26518mr7080901e87.6.1740045156197;
        Thu, 20 Feb 2025 01:52:36 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545304defb0sm1741428e87.6.2025.02.20.01.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:52:35 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] fs/jfs: Prevent integer overflow in AG size calculation
Date: Thu, 20 Feb 2025 12:52:31 +0300
Message-Id: <20250220095231.1686611-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JFS filesystem calculates allocation group (AG) size using 1 <<
l2agsize in dbExtendFS(). When l2agsize exceeds 31 (possible with >2TB
aggregates on 32-bit systems), this 32-bit shift operation causes undefined
behavior and improper AG sizing.

On 32-bit architectures:
- Left-shifting 1 by 32+ bits results in 0 due to integer overflow
- This creates invalid AG sizes (0 or garbage values) in
sbi->bmap->db_agsize
- Subsequent block allocations would reference invalid AG structures
- Could lead to:
  - Filesystem corruption during extend operations
  - Kernel crashes due to invalid memory accesses
  - Security vulnerabilities via malformed on-disk structures

Fix by casting to s64 before shifting:
bmp->db_agsize = (s64)1 << l2agsize;

This ensures 64-bit arithmetic even on 32-bit architectures. The cast
matches the data type of db_agsize (s64) and follows similar patterns in
JFS block calculation code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index f9009e4f9ffd..edb22cf9521a 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3403,7 +3403,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 	oldl2agsize = bmp->db_agl2size;
 
 	bmp->db_agl2size = l2agsize;
-	bmp->db_agsize = 1 << l2agsize;
+	bmp->db_agsize = (s64)1 << l2agsize;
 
 	/* compute new number of AG */
 	agno = bmp->db_numag;
-- 
2.34.1


