Return-Path: <linux-kernel+bounces-382182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C055C9B0A78
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6C6283204
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2896D21A4BF;
	Fri, 25 Oct 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="METl8kqp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1A1AF0DC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875634; cv=none; b=Qk08UHsUs6/t1uon473VC2XgG9GeHwGBXx/aTsKM8bGD1DQglXxwo6I2Y/ZD10vmMEZoxUtx97kTxYRizGs7lXcFutmvkzFT2TtS80bJCkY3hh3oKLF4VRfgoCN6O5wJWhvSdjYzueiJFmYzHiUD1s4N15DcEFtAG2gW+Ax6Mz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875634; c=relaxed/simple;
	bh=8ktKVcqw5HisbBhAg2zreoRGPviAkMtrTdGNCx0HSdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPDoGfmeYwmgef/PySUKqtBCdurx8B7Db+f3fRlT7UyA58yjkvIgddnv/XZx1dHgHP4B0ephJD5QqY1b1FqvwvlsinOO2CQ58iqrSFaGkr4+66MKg1vzqiQFqqyGq4siVs9nyIzLTXT03Wt49pT8vXEYU63m0EONKv1KL/5EENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=METl8kqp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c6f492d2dso23783205ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729875632; x=1730480432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncTae3ZwmA9C+qJN0T5EhF65fJ0IgO7SweDWmp+kk80=;
        b=METl8kqpstK5losqRb005WyH1802UiCoHlEhDJa6BvkR/jHxcC/RrXo0V1j3R+49N3
         N6tPrYqQe5C/itKVHpeMivP2RP7QJnnU8Ey+w43TwePJAdgCIXg/uwxMvTsAzsvqL3SX
         +hHN6dQmLWfDyXwsOZo2QM4c/EIe7kjV0nyS3TzqCrHUwgx8qP5YbgxLYv7md2fhTkQJ
         s9l0oF3NNZa0dJpISo0jqysvzIdvGoaUF2/UDprE13HUkIVDUrnoftufspH6s50a4yVS
         8PFc1+QjfngZTwi67Vbodk/+uZ2lRj1NeEtm95N5dLyNhFkuPctf2LYJ7HBgeDz8JJVN
         HdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875632; x=1730480432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncTae3ZwmA9C+qJN0T5EhF65fJ0IgO7SweDWmp+kk80=;
        b=sxJa6ANmwsSOoURxN3kvwllkxTZaoxIDd7HHOKvHwcuJ24/3aBm0mfjO2DQ+/Yb8NH
         a/PxAMLN7LRECL/nO7f7RqiYzZ0Y3SZloHpgmVFUktZFliJWqh0ilwu/PU+9tvdQHid9
         2xWoTNFuGTEtKf/wo0UcYVC+6l5radCbJu0ll8iBhypyuro+g9Xs5T3YHTmVB7LnbPqh
         Qi02XC9Wf5SlhoTPTgcku9uCLn0i2i1LJWCIrBMMUnzjgysgT5pZOxVrYpjIIOC69xsJ
         2Id6qskV6E6WgDguaI0+JE7q5En8vq7XgSM5JxS4005oJILhuVKoEXzCX6TYRsS6yxt5
         XAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeTZ1GpRVxQINXjMZjP4+L7ICA5pi1PHCooKXda1ZMxnSGM6nAf3GTrv9Mj0Y36ra+rcBjkGUAGkWkWaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZvczEyIHwRtJeAif+alPRhFYBaD9awxlU+z33ahX9TFGGhLum
	DJz6QtH/0H+VfiKWgo2snZKkd3TfKW1PBKeKODuZqxBStN+jHVel
X-Google-Smtp-Source: AGHT+IGh7PcIa/2vfyb8aAlOZYb5BeBvWw13eMRLOWnbL0Pqb4cThQvr4YnC41xRrfcNeHHx0ZsM5A==
X-Received: by 2002:a17:903:190:b0:20c:f87f:b7d0 with SMTP id d9443c01a7336-20fa9e06013mr159469035ad.14.1729875632047;
        Fri, 25 Oct 2024 10:00:32 -0700 (PDT)
Received: from TW-MATTJAN1.eu.trendnet.org (219-87-142-18.static.tfn.net.tw. [219.87.142.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04b8f5sm11325935ad.270.2024.10.25.10.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:00:31 -0700 (PDT)
From: Matt Jan <zoo868e@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Matt Jan <zoo868e@gmail.com>,
	syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
Subject: [PATCH v3] jfs: UBSAN: shift-out-of-bounds in dbFindBits
Date: Sat, 26 Oct 2024 01:00:10 +0800
Message-Id: <20241025170010.19654-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <671b3f75.050a0220.2eb763.00d7.GAE@google.com>
References: <671b3f75.050a0220.2eb763.00d7.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return immediately if the needed free bits span a full word to avoid
out-of-bounds shifting.

#syz test

Reported-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
Changes in v3: Return the result earlier instead of assert it
Changes in v2: Test if the patch resolve the issue through syzbot and
reference the reporter.

 fs/jfs/jfs_dmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 974ecf5e0d95..45b7a393b769 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3012,6 +3012,11 @@ static int dbFindBits(u32 word, int l2nb)
 	int bitno, nb;
 	u32 mask;
 
+	/* return immediately if the number of free bits is a word
+	 */
+	if (l2nb == BUDMIN)
+		return (!!word) << BUDMIN;
+
 	/* get the number of bits.
 	 */
 	nb = 1 << l2nb;
-- 
2.25.1


