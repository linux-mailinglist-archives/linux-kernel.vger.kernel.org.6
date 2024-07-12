Return-Path: <linux-kernel+bounces-250181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA092F4FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7FD1C21F51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912BC132C39;
	Fri, 12 Jul 2024 05:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QedeuExY"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A5132104
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761574; cv=none; b=oxY9mt87AMtt6H77QRt0XRyiHtjY5gGTpaFqVG6/Fut3t2lPM3/Ml89+kvU3ih+679HUvCh7eEl1ydyOuxJH7BzwORk2gtkR7b8CnNi/4O6hXwomPzpgZloe6hhdrwY1vyUrkQnge3PdadFOk/q5yGPBBQK9is+kwwppSVQJpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761574; c=relaxed/simple;
	bh=26FMC06RAj74awgXpxaoTTL9LLEerkdHyU5eXGMrwqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAijNxZwwM6cImRktEoQV6+27gCGYGGIGTiUQnmqIXDB0f74vz780qBb7cCpeM2DMe0emixadSOFyICMrIqG45NRhoJ0a0cWtSsDxsVolK+S9YdLLeVEj5So1go6iG4IIwrZDoQhqJik6xaJp1FFQ3yt8X2ma2L0RAXQBX3vjr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QedeuExY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b05260c39so1189954b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761572; x=1721366372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM31fGaT/iXt00GqtzCm1xbl9EeHSa7uOeAlnW7mZpk=;
        b=QedeuExYntVxq2cC6otKpTnVxgDG/EDzgpSDLs0oLsmfgQ8SlO2ACtv1et3TqaWQAZ
         bqKchcBBeXi6rKHBOg4LzCTn9Dh4Tk98Ix6LSsSLQGnF5v0UyD3g695rl6GwHFqmqM/0
         SzL6gNRrW4/eEJOl7dKvPGGOzq0h0V/mb4D2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761572; x=1721366372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM31fGaT/iXt00GqtzCm1xbl9EeHSa7uOeAlnW7mZpk=;
        b=vbozd5oiaZNl1p1enyTX4yr1ViP/UT5A/O9MCSzvFr55e5ULP1DSaX/fHVO7Qd8Kax
         OlooI1OpFAsE9pyonXDwEWgr/cFJQjwWDgyLaySRvcPqWWEgMTESZIoZqWMmyWfcqvL8
         i1k1tY1iB6vV/S4YL733PJlcJx5fGfPb/d5/XNo92mcbArdbTYu5pG8hkpYWkB/zpc3u
         EWnUBbIe7yF9zflL1liGZ8DM+wlL9QjgHK0owi6LMr3dvgzSXdJec7JyWA7TRZTToWIL
         I8qz7+jcTnnUrIo+nOIAIMi3Q2A2VIkU0GlnxYWb0j+e8sYIZl9LnSmGU1uKHffYSlx6
         kCPA==
X-Gm-Message-State: AOJu0YxyyNqiVLUvtpX0QdOo8yEX10xLLwvGBO/whp7qC/XZNUCVAWaz
	g93GC/T4r7jEpdFxN+JTs1PDsnEZ7OwojYUUMPVoyIFH+AdNV1DUkf50SyF4Rg5z3YVZ4gV6+xy
	Dy4Qg
X-Google-Smtp-Source: AGHT+IEl0D1pr3FtX9Qv5hugbvRDGy3/Sf955VMF/uhacWvDXMBmDUtTt4wYr4NBZQeAPEBI7ar+xw==
X-Received: by 2002:a05:6a00:124a:b0:70a:fdd8:51f2 with SMTP id d2e1a72fcca58-70b43566035mr12187438b3a.15.1720761571860;
        Thu, 11 Jul 2024 22:19:31 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:31 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 12/23] zram: check that backends array has at least one backend
Date: Fri, 12 Jul 2024 14:18:23 +0900
Message-ID: <20240712051850.484318-13-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240712051850.484318-1-senozhatsky@chromium.org>
References: <20240712051850.484318-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that backends array has anything apart from the
sentinel NULL value.

We also select LZO_BACKEND if none backends were selected.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig | 19 +++++++++++++------
 drivers/block/zram/zcomp.c |  8 ++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index ddc19853ea96..40e035468de2 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -15,12 +15,6 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
-config ZRAM_BACKEND_LZO
-	bool "lzo and lzo-rle compression support"
-	depends on ZRAM
-	select LZO_COMPRESS
-	select LZO_DECOMPRESS
-
 config ZRAM_BACKEND_LZ4
 	bool "lz4 compression support"
 	depends on ZRAM
@@ -51,6 +45,19 @@ config ZRAM_BACKEND_842
 	select 842_COMPRESS
 	select 842_DECOMPRESS
 
+config ZRAM_BACKEND_FORCE_LZO
+	depends on ZRAM
+	def_bool !ZRAM_BACKEND_LZ4 && !ZRAM_BACKEND_LZ4HC && \
+		!ZRAM_BACKEND_ZSTD && !ZRAM_BACKEND_DEFLATE && \
+		!ZRAM_BACKEND_842
+
+config ZRAM_BACKEND_LZO
+	bool "lzo and lzo-rle compression support" if !ZRAM_BACKEND_FORCE_LZO
+	depends on ZRAM
+	default ZRAM_BACKEND_FORCE_LZO
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 48ac7a3e8906..cb7afbd4d8fe 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -191,6 +191,14 @@ struct zcomp *zcomp_create(const char *alg)
 	struct zcomp *comp;
 	int error;
 
+	/*
+	 * The backends array has a sentinel NULL value, so the minimum
+	 * size is 1. In order to be valid the array, apart from the
+	 * sentinel NULL element, should have at least one compression
+	 * backend selected.
+	 */
+	BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
+
 	comp = kzalloc(sizeof(struct zcomp), GFP_KERNEL);
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
-- 
2.45.2.993.g49e7a77208-goog


