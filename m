Return-Path: <linux-kernel+bounces-558708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA59A5E9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6971896AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4E13790B;
	Thu, 13 Mar 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjlRCPI5"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A6B8635C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832402; cv=none; b=f6cgbFaAl4EklMbNq8r4vNqkZ5CGDZQXNhKi6os6I6x1sjVgoJCzuNrz7+L3+V4d0jl9vBjQmy7W3dOfqCzW+fy40fiFgJiABVUzcPZhSRaGMvVNWwfm2O4ueDQwC0Tp1aOdN9Yegz3XyzCsRSaEFPhEOnCIkuFES3ABfWX2Oew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832402; c=relaxed/simple;
	bh=/aIPWqp9LXKFEOXp2hDhwWiOmfrCgTzlcuMg3NdcVgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1YBoC+Zav8de5UPtgi9aBSJ2ubPgkxQ47M9HPAZvsi/yCFhtae9dZxLpX4bze+voDnqY0Ej1YWAuY8+2YmqXF1J2lwP0T9AqZktupLCLU2jaiSKliLGAR/77XwTIWT6g8C25++yDxe4JpiDGTRjnprHfKPCbbn+VERSMCJGmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjlRCPI5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso914793a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741832400; x=1742437200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM07y6mRejtfGVMen1h/wSs59kI5KFRRXlr+zYZ8+Iw=;
        b=VjlRCPI5G5euMkcxcEeVHbVaK3ND0OB9kVG79Mg7thZhquMNRHs3ncUUZF/CK4gFrP
         yeC48vG9mQ8d0MEYOzhkUYpcQfD6TUa/Heu4MPhUEJkaclNU1P+SHYmZD6S9ScVFKhOr
         fQk5cPbv+TbIrmGDZ5c6bjUSs+3+czGmX65vJgGz5/ADVWnHFZp7yVr2EVV9ZDbKQXeY
         VCrw6uyY3E09im07taJ1g+8VZgzh3D28ljDmOnBpKiUG18pb/PkDxh1jKjSMgakhBhEs
         PR2DASvSgxWnVl8tuVLyt44cPNZ3DcaB0w1mSefqaoiB9Bz5Z+6vDtd3i2AI3qsq9uz9
         NsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741832400; x=1742437200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM07y6mRejtfGVMen1h/wSs59kI5KFRRXlr+zYZ8+Iw=;
        b=V4KeSnh1zRLg3mkTU44G5IDUXm68d1tIKcX+MZ5zEkdiOVb89bRtdrEmRnSzVqToSK
         3uKryvmTRZF9cxtP8nIiO58uwsEKZUHnp3yMcQ1MexTHOu4ijEn5jHflw5CV8nWgwqly
         ds0Oj+IqIufnyysydm/iIREUgIuOs4z6ooV6Vp8kvDpR3v4PKL87hLghLp+JkhuvTt+1
         u1KGd4IBoGxt9U/W/KykrkcU8o4v+c7r5oCstjEfKcjrlDoLTWRL8jDdM+Xi65A4R8yH
         G3sd6AjapwxgbwKc8IyWCpfxr8ngL1HH076p+DX91Wg779FHxijOHYjpooqvLo+h/ri4
         RjmA==
X-Gm-Message-State: AOJu0YwjUVkamgSrEI/pakx7Q3Wno/4xK852wuGJlrebYJub8QQ6uAoo
	KmiimD/xcqfb8/u43+t+EPQb1yvZM4Tucghd6syeyC1KVxM7HV6E7qERaAkW
X-Gm-Gg: ASbGncsBTqwfYegqk/MY3PmWRUFyAIIwHLrS2+4RHPOHIfF7Iy/KDcjxyhW2sDyut9H
	jYsWOxZECCcmPXYtTZLR6ZeASmyqAnGbsrEfpZmrQ39NvGKBC/OMaUZbvp3TKmgkvevoDOdgxcD
	GtOHZuOY8vMElioMKc6N5DFgosAbqdpv0pgui7HBVwagCdXy3/wQDAkDUKq1+inKBTuL5EJGyDe
	6u/pWphKAl/iw241EcWAfJtx/7XqK5y3TsvS4UbkA/y87NDWX8R+34x+oJzdlbSmUrpurQPWOsA
	Bshj+hLiigQH3IxIcSCl8+zlmy3L1vmVrMCVltMabKkzoParOHPX6U4=
X-Google-Smtp-Source: AGHT+IH9h4gO1h633yHabDi56gUwUKc/1ei4QrFAgLV1x3b/3cKCpZ3eVwq4OVI4qIBzDVM8XCyTpg==
X-Received: by 2002:a17:90b:164f:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2ff7cf13a9cmr39914901a91.33.1741832400202;
        Wed, 12 Mar 2025 19:20:00 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301182181c3sm2651251a91.5.2025.03.12.19.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:19:59 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH 1/4] nodemask: drop nodes_shift
Date: Wed, 12 Mar 2025 22:19:49 -0400
Message-ID: <20250313021953.86035-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313021953.86035-1-yury.norov@gmail.com>
References: <20250313021953.86035-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nodes_shift_{left,right} are not used. Drop them.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/nodemask.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 9fd7a0ce9c1a..b1a26ef5912e 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -39,9 +39,6 @@
  * int nodes_full(mask)			Is mask full (all bits sets)?
  * int nodes_weight(mask)		Hamming weight - number of set bits
  *
- * void nodes_shift_right(dst, src, n)	Shift right
- * void nodes_shift_left(dst, src, n)	Shift left
- *
  * unsigned int first_node(mask)	Number lowest set bit, or MAX_NUMNODES
  * unsigend int next_node(node, mask)	Next node past 'node', or MAX_NUMNODES
  * unsigned int next_node_in(node, mask) Next node past 'node', or wrap to first,
@@ -241,22 +238,6 @@ static __always_inline int __nodes_weight(const nodemask_t *srcp, unsigned int n
 	return bitmap_weight(srcp->bits, nbits);
 }
 
-#define nodes_shift_right(dst, src, n) \
-			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
-static __always_inline void __nodes_shift_right(nodemask_t *dstp,
-					const nodemask_t *srcp, int n, int nbits)
-{
-	bitmap_shift_right(dstp->bits, srcp->bits, n, nbits);
-}
-
-#define nodes_shift_left(dst, src, n) \
-			__nodes_shift_left(&(dst), &(src), (n), MAX_NUMNODES)
-static __always_inline void __nodes_shift_left(nodemask_t *dstp,
-					const nodemask_t *srcp, int n, int nbits)
-{
-	bitmap_shift_left(dstp->bits, srcp->bits, n, nbits);
-}
-
 /* FIXME: better would be to fix all architectures to never return
           > MAX_NUMNODES, then the silly min_ts could be dropped. */
 
-- 
2.43.0


