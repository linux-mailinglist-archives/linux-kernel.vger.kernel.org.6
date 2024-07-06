Return-Path: <linux-kernel+bounces-243039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A49290ED
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 06:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79722835A7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1125A1CD3F;
	Sat,  6 Jul 2024 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UX8q+ONy"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08221C697
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241819; cv=none; b=eByWAfOO6NN8FKdGID4gtku6BgrjT3La4PXgfRQdbaInfLLQ3B3oLZlnlrg9qd4iPXaoA24uUWr9ViiLb/yyawONeHd7N+BqJ8lqzuwXNZ3Si1vy7Q4bRJhWWiU315JhUTDQXPwl4T6BLca1yzx+0wbfstV7Ym++0R61/LykQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241819; c=relaxed/simple;
	bh=AxI1yOXfNzixZbRuyuo/WRbDbgz5hU/FIRLKw3O+4EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiEA07OY5qamJ4cbdFyIon+S5ZhcZIfo5RSimajOzKateH+tL0lkw9BaBUhwj197ipVosnlIR3gwvcplVi4kCOvywvQWs4KqO5rHo/9RaOxigLPZN3MhddihCKAm8FciwXh3Itkbltpx/hNulqhWi3O6CWNv/DetTU1kjVBjykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UX8q+ONy; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c651c521f2so797276eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241817; x=1720846617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf1Swlc+GcHPMZi81XclrU8zJMIYY20nEHE2YL4cnE0=;
        b=UX8q+ONyyCOhy/HNFav0eOTF+1tdlmNRISDBfdAbY5gc1l8NAw2vLtkyG6V4EAtMIj
         kKYFzyPLMhQm71Bo95BjgH5lNCqwHELZhxRQid2aJiB18pEKx6qWPp0cRvU1bz3j5pZ0
         YLi+jSwjPz3XWWZ4CnEgSGndsd9K2wHsiGTDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241817; x=1720846617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jf1Swlc+GcHPMZi81XclrU8zJMIYY20nEHE2YL4cnE0=;
        b=dfcXfsbdNpWVgpaQ5V5uG/1LNkeprh+qHtdmJpLfAslpXSxMIvE52WMtklnIcKdatH
         6e6TIQXOHrxUpqlcBJh1vt8MYhpdFqv2uE/ZYZfUaypuCswtTuaT/Sf38d1Vu4etOzKB
         uNLOCF0+lI3p1D2aP4LJgULYnJ5EijoGSiV36kIeJS6t++jhArFdAMX1S2zsYlh4O+yL
         2A4aHGUSWZkEO7KtX+CfiHrslWMCA0jp9d3w7NbBaIxD7mJdofwDbyJh8skq0Kf3kylL
         4izAyGBLzw3NcG1G/7ljAWL8FZPmShmeb6lWwhYxNDZSMSABQi/+/lQnSm/+CEut3qkJ
         zzXw==
X-Gm-Message-State: AOJu0YwgdhxRnQr5h+vodYyuqKCoXrEGmvCujK448X3WCj1U1/5M/4dv
	TTzntljatzPmil3xdSFNCTLfTg6URBBBnRYPqqH2E6V+uy8QuULfDt31NOtBqQ==
X-Google-Smtp-Source: AGHT+IF+tti8aMl4R/ryaZBrmJNkrtaFNv3vJz5tuQqhihSxL1fkpB0i/XD2WlUyxrwEoXsjSzAzgQ==
X-Received: by 2002:a05:6870:9706:b0:25a:eca3:6b58 with SMTP id 586e51a60fabf-25e2bea664fmr5737810fac.43.1720241816931;
        Fri, 05 Jul 2024 21:56:56 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:56:56 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCHv5 03/23] lib: zstd: fix null-deref in ZSTD_createCDict_advanced2()
Date: Sat,  6 Jul 2024 13:56:05 +0900
Message-ID: <20240706045641.631961-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240706045641.631961-1-senozhatsky@chromium.org>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
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
2.45.2.803.g4e1b14247a-goog


