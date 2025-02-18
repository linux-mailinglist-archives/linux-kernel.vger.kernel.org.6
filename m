Return-Path: <linux-kernel+bounces-519402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13015A39C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9781A188C2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950852500CE;
	Tue, 18 Feb 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkUS4ir7"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B48241108
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882745; cv=none; b=eHiXgiLl1EB45S7aR72CR1t8In6kOcOsl9x7hPWGzeyrde0Fyi7OGBCHUbGXV1bNYJXsg+mbPDzWTa79R7feYOMZDz3JlGYp4I/85kEyiSBM+vabSyI76hlFy0MrzB1AshLJOap4qJGkNCptEcV5x6mr/qgDY1u5srxdTlvXK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882745; c=relaxed/simple;
	bh=RavdE/UlQvRgShqHGge32zjyJ+SYqS72qfeGAshiLRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BooBmZvrAkmQi1QDoWeuibS47tPTaL1rRhG0m6Csx3bkOTWsHEy2K88isXlxSCmEARO+Z/XPJtsdbAIRT0QtVuV1HX29YI/dT/XAhpM7H0ptvBG58mAlWtnG9iTXkc2s6L7pNyRxpfktetksU66t4PQFX4tY1m+QVl5mayd722Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkUS4ir7; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30920855d5bso42032871fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 04:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739882741; x=1740487541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjM/WutdghfOa1rqYy4L0lCjsN+xham0bipKmB62Pf4=;
        b=MkUS4ir7m+6XKgARQxZhSntv5f//M+3bJzDqGKE4tnKsdFadrqvVj6Vw1LMiMroWZm
         +x1hq4uKZ28jE3x9hQiHfJQHg1Dmt43vQ6kaNksw5grLVZiQL3aq4/k2/7nKgJqrsM3X
         TiGjAOyCQU4vMt66z8/2qqUHLAUCWjNsRwmsGZEQghHOs25e9Y3z8dME+NtoUb1MrCS1
         kTBTC3R/qP/swbMQrAQdLX93j0SPfPV30j3lFPYDc7B1L1yVGWRzB7QLqmf7EliidzSJ
         AxzXLGyh7psbRy8MvWSRVhvo1yKdGUKb7Md9ZtYDIsXxquRIN2IwbUxhfDnHyGg4TVsA
         Dj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739882741; x=1740487541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjM/WutdghfOa1rqYy4L0lCjsN+xham0bipKmB62Pf4=;
        b=s+hhR678IsT+XWC5j9Pl8Bv5EiGZk8Y0ZKEXiuQRexnxcUXthyItl8Ze/4iO2BNUDs
         oEesT8LKOHM3h6SBCgX6z8cPYokHKG0rj91QgZLy6VdwLP24E+Dv6gnXCbs3GYZDWAmj
         oGHHXlXqXwBiJoTa21pryw9REGxq4f94EK9NECDsWZ6b/p0WllPTjOojzRF0m6PmEyBY
         YEUt4ohyKC62YeuQm5eTaj34bkbiuMh7KyGCXXlsWbLU0CYAxKiO5PkrfuM4jFV9DNWw
         gHL+qgin8KfvHb6d4nvxmgR+mD3tWFb6h0cNyp3BlHAdWOLzwJU6dxLcw0K1QAt6TLo4
         nCLg==
X-Forwarded-Encrypted: i=1; AJvYcCXFnEDCMwYVj3D+eEUejqrhzKKdugsprAtWAHBz+41Hp7/njnWPJaYx5sfT89yQUzpLy5+lG/UFpoNfYK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGZsT3yx7r2T7Fg6LFP8oFHwauf6q1qbKIhDxem/ua9e2Pd378
	29YXfE/20KTFMiKj5U2NQXxoTx8/rJ2yOcN040i6DB1Dt1ntUrV2iCPf73InC2WP6Q==
X-Gm-Gg: ASbGnctfComrVfjtXRhoOhh7sQ/78E1SKPXmIIpo/kK9/2XDsNEax05o6mw3O/MPPC2
	oxQhcIexoqfyyQPcQp3yMAcGtoLhCukwbg8QmmCz3B93q3s1M0yg+v+pdHM3l0iPKMSdBQIY1SI
	Gv6QtSxAUO6TI+slBnYDFIHIbUy7f8B6KoBe0Xlde1FDuppkfxzjZS2Pdv5NkGsmQuBUIpCDJ0t
	OuoFYfmni5QkyqiPCysIqredus/uG0KcfKTwtTBLrRb6OT3pyCG6rTmmKnaorqBBtoXS0+oren7
	lFkBZ/0BSDlVwfYZadpfNsU6AO3apH+0/FebvOlQF4EUqX+htY4/d0SJFQ==
X-Google-Smtp-Source: AGHT+IENyW2umSDB5pOJx7840FOiWwuBpfLSj8lgmLXbWx7P6AbWicT9TJtBU9iAjWywalwJYLCE5A==
X-Received: by 2002:a2e:918e:0:b0:308:e9ae:b5b1 with SMTP id 38308e7fff4ca-309288dd513mr39040061fa.9.1739882740962;
        Tue, 18 Feb 2025 04:45:40 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309259213e0sm14449281fa.58.2025.02.18.04.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 04:45:40 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH 5.10.y] fs/jfs: Prevent integer overflow in AG size calculation
Date: Tue, 18 Feb 2025 15:44:28 +0300
Message-Id: <20250218124428.1638816-1-rand.sec96@gmail.com>
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
index ef220709c7f5..eedea23d70ff 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3465,7 +3465,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 	oldl2agsize = bmp->db_agl2size;
 
 	bmp->db_agl2size = l2agsize;
-	bmp->db_agsize = 1 << l2agsize;
+	bmp->db_agsize = (s64)1 << l2agsize;
 
 	/* compute new number of AG */
 	agno = bmp->db_numag;
-- 
2.34.1


