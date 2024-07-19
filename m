Return-Path: <linux-kernel+bounces-257961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B847393817B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 15:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20303B21543
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3BE12E1C7;
	Sat, 20 Jul 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sqnSy2ao"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149563209
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721482511; cv=none; b=JN5SGEhOiV8Y1oXA8Lo4xgrprLZJRk/rcF5Bk8yxQMa3mjAzqw7S1rfUt9IQ0t/HYVbDZzuv+bSfZmO98UTODb1H9h4wPxqNo7N5R0dgegdP0fsJw0eHJ5Lw5XnPQPcs5U5jxIjl92400B+GcL9WorGsMYDCvcWHUOSeAprTMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721482511; c=relaxed/simple;
	bh=EbCxln+yCG51QiJ7GKCzZDttDTY7cN6Q5urHZxtSm5Q=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=UA/X7tIqc37uXFbwciVdrexDJ/rYDek0dd9lGSaBC2hTIFWrtKSxnaHpr1iz09/4mWf39sCfpQOjiPkv1N4I2/fSudG7DIlJ6w3xq72Rr8BSWtODHcTwTdAHqni31PcLddxIY5fgjD4oNidY3NIaSLSIlhvIXQ/90uvijQrQHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sqnSy2ao; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb81c0ecb4so1376990a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721482508; x=1722087308; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=okX3z9/O4JxpS7ZY3ssg2VM6MGJ5Gd7HSr4hGICtRaQ=;
        b=sqnSy2aoSsQkzsyP5vNqeCwNtnv46HO/Ku+1PAGoIgptgBLBc+XlaZa5Etk0b2+WVD
         myWy48CrMD2KcHbl673+uT/qRUuuz8fStlKs9gIdKrPVuKSyBsHQGIkdqQgpsaHX+7vU
         hUA2JFMiwsdmmIDGz5DHA/nCFicZoPxxi7+sbRZgZPhEPqDaEGuGUnASdYvtQgP7JMEp
         Ah/r6c8XZ5GRuruSirKUcEYAJXcdmek9c9jnBNEbC3CB6FMbOujnD3JZDGwMVfi8VKGu
         n1oT7Spd3OiYCXF+01dD8rNhdEeKCt+53R0ukrql1Yhc/QZrrQ7o/8ceMbFle1fZ6O9Y
         i/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721482508; x=1722087308;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okX3z9/O4JxpS7ZY3ssg2VM6MGJ5Gd7HSr4hGICtRaQ=;
        b=wAL57yrGDIaAhxCsxZ1fmn6tKmIW+dRWZf3ukbKdz+z1G1E326h9xCOwFJfA1VsAf7
         udHAgE24IZ5WdZrJ1SZHLktZDVO0kRUM1Gch0E89yu95BWAQkVXo3IbIjiRM9O3IRpmR
         fzglLOpR7xglPGyZbIy2EFaKU3DcclakX9GwktOWcp45NBeTjNizw5B2mfp1mLwRg6MF
         WfWwT65pLoKV49oEpDT5vAkonkAv7sRWh7hMe0aUom8HNBWiHufEvjYjeGwd0b7OSLwN
         kfYOhIOI4dh81cB8/7mRDcLEzJZmVgXYPVBHTKiASjvxEq0lh5f/8lhfsd3zlcnvXK+v
         AF+w==
X-Forwarded-Encrypted: i=1; AJvYcCWF07bAPYdkfVYqHu8uHMnVRYb5laQlOy+IPfjfPd+vij16p/pdr9CaV+o9U65t4p0zlgUSB17tgwb8vP8oDOWRKBMHf5i81rVQKo5g
X-Gm-Message-State: AOJu0YxzuhEUqFFA7wfb9zhHPR6xZ+nD8GHXXN3nkjKm3KWE15CVj/AA
	NnqM6fO9fk9wCyG7r1m2fL3NHXAeRqK+DdZ+3bLFLLXcCWpKYxQXg3qRMp706dA=
X-Google-Smtp-Source: AGHT+IEo9zfPWvHmxxSk8ddC7++jG3WjgsugpmTZfOPfhJCYUsON31LAXDkBtajkrFwAOoXVxE4NzQ==
X-Received: by 2002:a17:90a:e381:b0:2c3:2f5a:17d4 with SMTP id 98e67ed59e1d1-2cd16d1c5f2mr4312138a91.4.1721482508093;
        Sat, 20 Jul 2024 06:35:08 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c72075sm3534264a91.28.2024.07.20.06.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 06:35:07 -0700 (PDT)
Subject: [PATCH] cache: StarFive: Require a 64-bit system
Date: Fri, 19 Jul 2024 09:38:41 -0700
Message-ID: <20240719163841.19018-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Conor Dooley <conor@kernel.org>

From: Palmer Dabbelt <palmer@rivosinc.com>

This has a bunch of {read,write}q() calls, so it won't work on 32-bit
systems.  I don't think there's any 32-bit StarFive systems, so for now
just require 64-bit.

Fixes: cabff60ca77d ("cache: Add StarFive StarLink cache management")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/cache/Kconfig                   | 1 +
 drivers/cache/starfive_starlink_cache.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 94abd8f632a7..db51386c663a 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -18,6 +18,7 @@ config STARFIVE_STARLINK_CACHE
 	bool "StarFive StarLink Cache controller"
 	depends on RISCV
 	depends on ARCH_STARFIVE
+	depends on 64BIT
 	select RISCV_DMA_NONCOHERENT
 	select RISCV_NONSTANDARD_CACHE_OPS
 	help
diff --git a/drivers/cache/starfive_starlink_cache.c b/drivers/cache/starfive_starlink_cache.c
index 24c7d078ca22..8ee9569771f8 100644
--- a/drivers/cache/starfive_starlink_cache.c
+++ b/drivers/cache/starfive_starlink_cache.c
@@ -19,7 +19,7 @@
 #define STARLINK_CACHE_FLUSH_CTL			0x10
 #define STARLINK_CACHE_ALIGN				0x40
 
-#define STARLINK_CACHE_ADDRESS_RANGE_MASK		GENMASK(39, 0)
+#define STARLINK_CACHE_ADDRESS_RANGE_MASK		GENMASK(39ULL, 0)
 #define STARLINK_CACHE_FLUSH_CTL_MODE_MASK		GENMASK(2, 1)
 #define STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK		BIT(0)
 
-- 
2.45.2


