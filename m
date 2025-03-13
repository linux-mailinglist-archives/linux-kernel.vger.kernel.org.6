Return-Path: <linux-kernel+bounces-558711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65EBA5E9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1500B175DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F6114901B;
	Thu, 13 Mar 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIUvvNG+"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823014658C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832410; cv=none; b=rKFD8kBPxz/oI7V43pxkhql4xy59vlG6gHUhywEqMvHMAEu1h1UTgUGXlyxwnkvAva60U/zRamRmoDPa5qKy6W1GRwCXhlymciW0jL7vylkVYFmirWa9KyWMjyF4stW46gOcmZ9QWPzl6hyEPDIxLxG28PKd72tCLHtjD1n7BHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832410; c=relaxed/simple;
	bh=l0rwUcCJ2FyNJ6tzvfLStV2z+Q0pi6N7ETW8/F9bHwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9oT2aax5rezwueRHFYTP24nn38njcjzMhxWcP8aJSKWXCbTRiQxo5dH3I2sQoA7ABSL/v6GYxmdXwYdKmfjxTM5tYj/AKR/D3d4rlNCV11+eYnMobSCQJ7tmF+N8QV5ScLSk1hv0btiRD5csWecT+a9tdzngzGebGVaBUwU2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIUvvNG+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22355618fd9so8893945ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741832408; x=1742437208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhrJ8HGtR8k3dxAA+AgdZEOnZohoN1a96l9KBcI/XnA=;
        b=QIUvvNG+G1NqiJ4bw3QJvmOFw2DIjHioijgaZzPjWRJFvUYtX+GK8Vn8LGcC3LBerf
         9TSpRRXOViQ+x1e6jC61zcxfvDsBOptjJi3aIUDAeCeK2OBcfv75m+22a56bK90sKEa3
         AurjB1T9LvpepiBFV2DccY25ueBT0Ef/qEwSvgqokKSt2hDyIx8dPM5OxAXcczqnSunK
         SJ2+VHYerXalt6XbODcmhbLm+Cw4VJdLc7OLtn7TjFfHgNXzkLpTiGmPgASUDwnDg1Dd
         anKmtP31QlLB2RR/p2IV1K5dsPNG2ma7jj/Xihklk+Xby2Wz/0FHEO/j48BpKe1idReH
         Wb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741832408; x=1742437208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhrJ8HGtR8k3dxAA+AgdZEOnZohoN1a96l9KBcI/XnA=;
        b=jQtTp9TU37o3ZCKEcSg5zZ8QDsk3fTOy/b6B30ag2HTknb3phlSuHs+BKzwKyMRwGO
         zHsAAwd/+u9LX4920cAhkwe7hSrXqkkV5MPDygMKguE4rN3SoTLIlvLI+nbGP3L9azXb
         xze6kjvaIE8QXnwYt1SUCXJS5NUoirS/e21zukCi9pSTB4E/5gFwaYk6h32s2QRB/Zec
         v07JUGQ7GJWrgHAwqXpoN6togsiJ9Rb8CvlTQiOp1kAFbiHc1wIZ8getCBlKS9siUDNi
         0YP3RCvqnKa17JWN0uhqxBjfw75Mm8LUlN1fGmeXAJeZ6VZi5y0kjv59RlbsFe/veHgy
         SShw==
X-Gm-Message-State: AOJu0YwNse8OtKpvuxFrzOMyy7mdFEO9UjeEGpO5481ybdPTfp5LDNqz
	Aj6aq/u2062pGvbInKAFutq863YPAqWU+AdD491OeFElDprJjRfEc4Z4Iz7c
X-Gm-Gg: ASbGnctca+lmBXzGa4EvGo69WN94oQsIP7yBW21OxrmSZpUCYFizktASiIiB6mOEQ7r
	9eFD95wM8cB2/Yp69/4vuu14ZNNaJrhUlCHnxmUWyWQNUOHMdDImbR6I40Bs5soHC/LviVw+vV4
	3zibiKf+0+k8t3Q2RBVLvMnDj13GWmC6KdaZn1S68A7c4/7o6bucuEeiNBemud3fUY27an5EhrW
	YupRCPtQNXtGWqGM1dJc5HTpi89QkPOiAgsHeiil1ONYg6UNrHRlm58rD8X4rKh4x+j1rYKYl3N
	eyHhUnFQBZxkkmtkwsug40e/vq/MYvQS7QWveh26xrj/
X-Google-Smtp-Source: AGHT+IFcQfoNRBmW4J0WVDBuE/gGCx1w5h+8C1HXlvpyeZVWWTFjP7qL4lXzgdHuMvZqdEU+k1TZgA==
X-Received: by 2002:a05:6a00:a09:b0:736:ab1d:83c4 with SMTP id d2e1a72fcca58-736eb65d07amr13574673b3a.0.1741832408295;
        Wed, 12 Mar 2025 19:20:08 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371155934asm232634b3a.56.2025.03.12.19.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:20:07 -0700 (PDT)
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
Subject: [PATCH 4/4] cpumask: drop cpumask_assign_cpu()
Date: Wed, 12 Mar 2025 22:19:52 -0400
Message-ID: <20250313021953.86035-5-yury.norov@gmail.com>
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

Commit decde1fa209323c7 ("cpumask: Add assign cpu") was merged bypassing
cpumasks reviewers. It adds atomic and non-atomic cpumask_assign_cpu()
helpers.

In the same merge window, commit 5c563ee90a22d3 ("cpumask: introduce
assign_cpu() macro") added the same functionality. So now we have it
duplicated.

__cpumask_assign_cpu() has never been used since introducing, and because
this series reworks the only user of cpumask_assign_cpu(), both functions
become a dead code.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f8caa025c6bb..ddeefb2744b1 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -558,22 +558,6 @@ static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
 	__clear_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
 
-/**
- * cpumask_assign_cpu - assign a cpu in a cpumask
- * @cpu: cpu number (< nr_cpu_ids)
- * @dstp: the cpumask pointer
- * @bool: the value to assign
- */
-static __always_inline void cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
-{
-	assign_bit(cpumask_check(cpu), cpumask_bits(dstp), value);
-}
-
-static __always_inline void __cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
-{
-	__assign_bit(cpumask_check(cpu), cpumask_bits(dstp), value);
-}
-
 /**
  * cpumask_test_cpu - test for a cpu in a cpumask
  * @cpu: cpu number (< nr_cpu_ids)
-- 
2.43.0


