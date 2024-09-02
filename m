Return-Path: <linux-kernel+bounces-311147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC75096857A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099E81C22889
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C497347B;
	Mon,  2 Sep 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hB731neu"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C518454E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274631; cv=none; b=GAecza2qhuSbZfghsXRZfHy061w1lmr2yZJBYzm8CvWTRbOI+t9RE3Zzp39196j86mCYeFLirX8PPFYf5s6kJXkSQ11n/oSGCodzd41fd2hq95lNKNnBS7nAEBhprZABiQxuG6dSOLTtQCEOP/4HXSNWeUFqQRbpIPvSA9KEarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274631; c=relaxed/simple;
	bh=KowW0rkixne512vm0Qy0iPWor7Pg9ob+bDapKE4dzkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UF4Hmidjn/PfLV5AdeYdRud7J8bndBtlSXWbBFrnmClyTUDEiXQcl/kUqbQ9S20ZdFDnOlO109eKUKtvDPZy9QuzKXyzty6Q2RNr3CXhhzT14BEHuy4jJvD4hu8Q1B9HGWljPRPaneOz2oO6Dy3ubY3DVowz3y5ZwyxmsJvulpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hB731neu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7142e002aceso3219292b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274629; x=1725879429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaWScTZgQAfjVv5JZEhm3RyQE+cAh0ntRD2bN4eyTkw=;
        b=hB731neu09hl8jSVser5M9XjmayhucQLyumhk3tSghbEMed3datfPhCFHkYO26lT8E
         tmpTaFDK56aQXvN71ive4TUDc5iLgo7lvKmsmBX/RYe89+KR4GbC1FJi17cszn9h012J
         I7ZIacZsaO3qO7cY+hOPQ52/Mf+Yrxa1I5Cos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274629; x=1725879429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaWScTZgQAfjVv5JZEhm3RyQE+cAh0ntRD2bN4eyTkw=;
        b=p63rkIqMkh+F5mvvh/oaHAKqHAHPFUfb+O8yiIT3flOHTnc+FkC7zkO4unZiixL85C
         r/9LstVO9L9j8nKYnZ5EuZ71twmT40glaWVCVVK+ps0dYQaqdyyi/jqfgNtjOLfxUipv
         iUrMs1H+VmLn6PsLJldLmL8ZeF3zCYYLraByDiUYsODVn6EFQ9gkR/HxwVGMhQIUx83R
         bfSwJ/Qhfdt0D87biiqUI1R7tW3HNV7rxqgMbfywlmOoaoWr1d8JMTg/2oDlZu03Dv7l
         jQNAX+uNigJ7q7mFE2ae/VhGqpMQKPocD71rAfN7PU5pZzahtAqHu+ea2Rb/sVLfTZTK
         aMKw==
X-Forwarded-Encrypted: i=1; AJvYcCViFWKsClIfZuUBYbqM33CBj0gZItEUhfTq3dJB7C4Cufhys2vTRy4/qLUC7C5FgDHJGkQNL6JqDBPqE5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8y3JQGbSSIj4XulD9k5gpUWrncJaIKZtx1xzBvYhSFd8KXyY
	RTEndRR67qWe0NQsZB5VST9NDjC6k/qL6tvkvmzoUAZAkG2g4PpuOuVafvU5yw==
X-Google-Smtp-Source: AGHT+IHwE0wSTERpJZdwvh6eItYkPP1B5yXZM49JR+Lef52b0nKpBdSmfS/gFmJcDxytI6quQHVxLQ==
X-Received: by 2002:a05:6a21:1690:b0:1cc:d4a2:63d3 with SMTP id adf61e73a8af0-1cece4d816fmr6183116637.10.1725274629638;
        Mon, 02 Sep 2024 03:57:09 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:09 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCHv7 03/24] lib: zstd: fix null-deref in ZSTD_createCDict_advanced2()
Date: Mon,  2 Sep 2024 19:55:51 +0900
Message-ID: <20240902105656.1383858-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ZSTD_createCDict_advanced2() must ensure that
ZSTD_createCDict_advanced_internal() has successfully
allocated cdict.  customMalloc() may be called under
low memory condition and may be unable to allocate
workspace for cdict.

Cc: Nick Terrell <terrelln@fb.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 lib/zstd/compress/zstd_compress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/zstd/compress/zstd_compress.c b/lib/zstd/compress/zstd_compress.c
index c1c316e9e289..e48c73880477 100644
--- a/lib/zstd/compress/zstd_compress.c
+++ b/lib/zstd/compress/zstd_compress.c
@@ -5336,6 +5336,8 @@ ZSTD_CDict* ZSTD_createCDict_advanced2(
                         dictLoadMethod, cctxParams.cParams,
                         cctxParams.useRowMatchFinder, cctxParams.enableDedicatedDictSearch,
                         customMem);
+    if (!cdict)
+        return NULL;
 
     if (ZSTD_isError( ZSTD_initCDict_internal(cdict,
                                     dict, dictSize,
-- 
2.46.0.469.g59c65b2a67-goog


