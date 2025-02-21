Return-Path: <linux-kernel+bounces-526756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D6A402B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA99A422B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D38256C7A;
	Fri, 21 Feb 2025 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QSip9Y8Z"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146E255E43
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177089; cv=none; b=cnrY3J40RNmNJN7aqBOMgSGmDe50ADXO9TJ6MgTP9BewPfSf3eaHm8p4HOy0PNSoVfNL4raH2Bp2ZHo+eQFSlDxTVvBI93S1ZXENUMTOaNTRoZtJhxqLmoHZTA9nDXP6DE2OkWu3rxE1TehE0k+5d1w42dMVgsdEmmOU5cIJa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177089; c=relaxed/simple;
	bh=3bl4FZa1Jj9/SryddhJVpujsF+YKBcOIbQtdPgtbXnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzBNwFwSriurvCfbZNBDj3thp49DDd2r3VGwCXFSEzXCIHNM7FRGlLGxt9dvHJ8ajzKswyTgdbD9eLskZszuUPTadS9i9o9w0itG65SsUFYjB7zS0AiN8BDmM0U/WaZDEp32Ghc0yiyo1TuDPkgncuYCxGZFOlITV0DOWVJoooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QSip9Y8Z; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fcff77ff9bso631832a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177087; x=1740781887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvgHEnC+lRfOrRLv2RIVOYlOBk4EIx2tIzOwTFt2Qag=;
        b=QSip9Y8Z8xkdGPkpIWEIWa2TbY9sLeIeJtolKcFOQR0+9FiDrk3gIBlbUD4ahrxhtE
         dFrAsbO+R2QvygZ76H/eP08IxtHKfWBVRRmrDgYn5z/z6j0nhhsPLuUNgxkjNmTy2OBl
         oJkhLnL3yqXaXN5Xvg3t17f3Zd3q+NTuag6JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177087; x=1740781887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvgHEnC+lRfOrRLv2RIVOYlOBk4EIx2tIzOwTFt2Qag=;
        b=h7AwD9MW8efsCqJYMR5YvCJ/iBqyLb6l9nB2ZQufUH56+sNAfMDS40N2uJ0vvJILgD
         +9zJrOfaiSJhhtBfl4PaG+jxrv92K2G34lIiiH37dlsfV//7/hk1qPKth2vzgO++cU0w
         CB4ZEX1kNd75Z216rwXaN2kW6Wqlwmg7x2TvT+onsShjKu6LuVL+2f0NxBAAFO7ZA+Zf
         T8a4Af3GL8uye2ejkoJ6vAZ0kpn4TS0mfAOY6XCHxbosOp5sTtUVPYUHk4PFSApyO/BN
         +uhxuBI5nYwP/oG61yjlriFS+0qDeFoeke0cecTrE4AZR0r/4XDItv52RObefuzBzJCJ
         V9rw==
X-Forwarded-Encrypted: i=1; AJvYcCUj1Fw7ZAzXSGyc2oVLP/cbnfDTCJlOpAhJeaap6DJbj6a84HxiUVcQA3Tn/8OJc5O0MkpWqKAZ/LH1d3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWytlOPB4lgnxUXZj3fPxhRxjXdxUicHmxmjXZpoRwsynmqqYQ
	imJb1lx3+pxc9qe0rRbtnAUDVygxEAUCNkB52IYYdtzVTSM5CFduqsDLBQ4En810YlHjMkRGY00
	=
X-Gm-Gg: ASbGnctqCA5DaqpVtWejwDhZcgHve3RB5VpFzfgNEC0Nxi0HMxJvdhPimA7So8uS1V7
	WCUtbSN2szI1525lpmbuaWoj4e34JgT91ufA7ptuwKvPK7ZiHvaAys5bQARvrrhAg3mQXCWG+GK
	vk/RK9ytWArAuNWJUzRmOastC3DoasL9hQ8tPo4DUK3R2qfmQOJOwmHYUTNSQ6BESnaqtOekVR1
	NJl6WNLEUm+/fyDPJ2tj5FevLGShTYvd53N02zKVYthmWP2uIwvmulNc5uYAV+9DGRIswsQ5tV5
	RlzIS9V1mR9ScuAMFTYbg06Vl+0=
X-Google-Smtp-Source: AGHT+IGkPWWH6TqJ9/sgUjEBD1TJB2UYf0Tm0PHjDPg6aqJ3PVT1Kgk4bf+kZD6+22IEnkZqjfOIWw==
X-Received: by 2002:a17:90b:2792:b0:2f8:49ad:4079 with SMTP id 98e67ed59e1d1-2fce779bc14mr7402899a91.6.1740177086823;
        Fri, 21 Feb 2025 14:31:26 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-addee79a984sm11481158a12.32.2025.02.21.14.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:31:26 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v8 14/17] zram: permit reclaim in zstd custom allocator
Date: Sat, 22 Feb 2025 07:25:45 +0900
Message-ID: <20250221222958.2225035-15-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221222958.2225035-1-senozhatsky@chromium.org>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When configured with pre-trained compression/decompression
dictionary support, zstd requires custom memory allocator,
which it calls internally from compression()/decompression()
routines.  That means allocation from atomic context (either
under entry spin-lock, or per-CPU local-lock or both).  Now,
with non-atomic zram read()/write(), those limitations are
relaxed and we can allow direct and indirect reclaim.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 1184c0036f44..53431251ea62 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -24,19 +24,14 @@ struct zstd_params {
 /*
  * For C/D dictionaries we need to provide zstd with zstd_custom_mem,
  * which zstd uses internally to allocate/free memory when needed.
- *
- * This means that allocator.customAlloc() can be called from zcomp_compress()
- * under local-lock (per-CPU compression stream), in which case we must use
- * GFP_ATOMIC.
- *
- * Another complication here is that we can be configured as a swap device.
  */
 static void *zstd_custom_alloc(void *opaque, size_t size)
 {
-	if (!preemptible())
+	/* Technically this should not happen */
+	if (WARN_ON_ONCE(!preemptible()))
 		return kvzalloc(size, GFP_ATOMIC);
 
-	return kvzalloc(size, __GFP_KSWAPD_RECLAIM | __GFP_NOWARN);
+	return kvzalloc(size, GFP_NOIO | __GFP_NOWARN);
 }
 
 static void zstd_custom_free(void *opaque, void *address)
-- 
2.48.1.601.g30ceb7b040-goog


