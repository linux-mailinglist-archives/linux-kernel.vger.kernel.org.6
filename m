Return-Path: <linux-kernel+bounces-525509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E1A3F0BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8AA7013FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2812046BF;
	Fri, 21 Feb 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P4OCPx79"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984220AF93
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130802; cv=none; b=MvYIM8bo70UsWvXBdtplz8csqMUXilWNjeoMYvUl9L/1KUiYt/88KVZeGJV+XGHken5YjvT2jP0k1jA2wJhQybGOqtCexQ7XUW9TQOuci/IrEdKUq3BR+x9yTEri3SjdmPhGi5OpQNYgynWh69UgO0Wauk0gOSQLQKeZUTZ/Tak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130802; c=relaxed/simple;
	bh=3bl4FZa1Jj9/SryddhJVpujsF+YKBcOIbQtdPgtbXnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fz88DGxiEA0Hu3++ijldE24x0AHU/BV9SPhe70PfD1FPHoP095uxgB40YVoNfw1HSE1EFvcwpiZzM9AStJ58UkxMX9qCwqRF/RWHPQV1nNEAK3t3uNDvAELBGBKPPGKsuFZFhZtOEckSkh+Rus9AYvr/VO3JTmoRnk97IpIyMNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P4OCPx79; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc11834404so3034543a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130800; x=1740735600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvgHEnC+lRfOrRLv2RIVOYlOBk4EIx2tIzOwTFt2Qag=;
        b=P4OCPx79NjnXbDXCIgmjUgADksFo3ZYka96NcPhnag9ikTfrAnhjXjUHTnBhjYoxcr
         mrkMYIyparPSbWyuIgiFKHrmJl9gMc88VggKK8RTavnOba4TFAkywVcwGh1FjIG+r/hw
         T94rAV8Xe9i8N/eQH4YiALe34u32c3tpwU0Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130800; x=1740735600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvgHEnC+lRfOrRLv2RIVOYlOBk4EIx2tIzOwTFt2Qag=;
        b=QsH28ocQlnNUn19ieEe3rcdRk3A8Hms+s9VHVd9lRX5WWoRXp4eUeVwNsrzQulW++3
         NAknrmsNE718fFgBXnpSgm6hYXKNG1rToSUc5ZEbv5JQYF0wUQ/lgwGa0Mk5uvhOh0m/
         XnkvMPQ/AYwsbNVY23QpHsAHTG+KkpdIXHaMRY4EX1eFXB3Vhyh3kX7yKwDJ8hwxFtt7
         R6YegR4bbXsBYUyy64Jrv439uP+XGx60Emr/yfpMK71DpEdRUTMfF4dZW46PbeJqLqM0
         bYqcgFlzWvpvN6tLm6RXR2KqX7VCNbHrCST6ibQMomfrc4pFLgejQX+cmamSHgVyeQUh
         FKlw==
X-Forwarded-Encrypted: i=1; AJvYcCVFcKpBjQ2jMUflcEbWJqefNyxr8McPGzkr9/u9VjwG/dj3ePD/x6zIw2rBZwQEyI394MHwYBK50LHI4PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhoFlu1pY0dwjm6GHQC9VnEdJBVKoEa8h9FfpwsT70SSnV9PP4
	eyZY28XjzUkGCp4dVtKVexUcl7EcDqNHADqYE/ablhj5vR4XjIp146gYomh++A==
X-Gm-Gg: ASbGnctPjoqaXHA2NbrBp0kLNsdrgY5VuLoVd5Gg2+jK2a95HJN4ZCuOK7dG9CqZw5e
	IrssIdjXYxM/S8V8gT7DkudEaYNthKAld7G4s9eywhXRnE57fCAJ5KPhIBOv42+PDzrlTtEWsCd
	TRkox+1opfZMMDW5RlxtQMBIE17V6nsDNzWwcw6qGWI714wAoNmuH0LBNUC/trL5Ut8kqzAie/o
	NOp+9+Pn9dRi8ItSA3/jVvhi/k0fpbbHiYAjuYIgfhXWloysZ6X4AzpWYGaq+5c5zmTqP5YrDsE
	RnhHv1DJKqJWA4LrZU084NaIja8=
X-Google-Smtp-Source: AGHT+IEeaNCIbiqEVAo1RmizyW1uxrb4z6DMOQbzYKHkv/Y97ooxMJdlMx5xw1SmW1HKoPKFG7FKUw==
X-Received: by 2002:a17:90b:1811:b0:2ee:aed2:c15c with SMTP id 98e67ed59e1d1-2fce873aeffmr3562067a91.28.1740130800521;
        Fri, 21 Feb 2025 01:40:00 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb12dc27sm898120a91.45.2025.02.21.01.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:40:00 -0800 (PST)
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
Subject: [PATCH v7 14/17] zram: permit reclaim in zstd custom allocator
Date: Fri, 21 Feb 2025 18:38:07 +0900
Message-ID: <20250221093832.1949691-15-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221093832.1949691-1-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
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


