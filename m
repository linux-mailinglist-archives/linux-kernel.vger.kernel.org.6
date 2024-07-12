Return-Path: <linux-kernel+bounces-250169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1739F92F4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA31282DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB145020;
	Fri, 12 Jul 2024 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DcxBJ++I"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F02EAE6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761548; cv=none; b=J7RKBar/9LDGhaoe/0eVmV/eowUxr4/IddW6V//5RqjgT37Ci3ChuU7/fK+yaiKCdSZC6s23QrYmNyezyRZBYYaHn/wTp1Hoii/VuuvNc6CBpDqEhix1VQdv5Hc7xmN+VrwgnpSxd5yb42VacyfV6weTQy/NP0afHy1IJxaqmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761548; c=relaxed/simple;
	bh=vdYvQfcQu1mt93UPykwvclLXnIntkTvh7GSWCA4dW2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8ChtScIC6BnQNunDcN9ob8CZ9FtSLL+V+USgB7JGLR+kM1Ob56jN5MpOnMRLWVp1Nl9Tf88QY4hU5PlbgU1q7iFSNYD0MvARP1GOXtfKr8ubsz6wfSaO0i6qq/WtaHAGGkUztW0imY17xJuVY8SSo2nrFOCl44V/Nz1tjOF9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DcxBJ++I; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7036e383089so909634a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761545; x=1721366345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECaTUdajKrss2jyo4a5iaGCo7q7p1EgM+Xi9/dziakE=;
        b=DcxBJ++IqOrORfS1Rqen2SVdkyzNAjPUj/F0bTCwPVTkMZJCMjCosR/Ss9lBfLRoiY
         BjslASMeb3Wf2Nw2g8JlrCrZRsEdTY6YmcyT2nU1hFEzFv7cgSMdeBfO27oYOeEruxXV
         zZqPoHXOFBsKFHTFi9BtnRQqBfKvzPeMZcpdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761545; x=1721366345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECaTUdajKrss2jyo4a5iaGCo7q7p1EgM+Xi9/dziakE=;
        b=BYDuv857NTAsSq3HtWj0Yqb+FVL+2Q5Yh3/DY76EZg7N5sng0LK8+I2qjJZECPfZJ4
         iKIQ4V+XEp2yYtwH8EX1PN514QjFEJKM3p1/7UFVl9yrCYr5wsxz39Zn+5M+ueJhtY4Y
         VODOvvcV2H/zZpS/VLwWLwJRJWPxrYMnxzOP2iMuHPNdIu8JrevfQbN1LsgwvvN2OGcT
         vT+sEr8/BkBiIp4mL7XXEGYDmaa8ITsOFuEyThzpMpdM5UZhYhOo95GVHHUomKqOFff4
         WdGwD1fq9G8lWB9gn6CNkNoxm0Vj+UVKpyKWjQLepke1FGDI4fAScvbwq3qSGGmbUbPW
         DcBg==
X-Gm-Message-State: AOJu0Yyw0BAdjww62zN/TjBY4vUtbZsQVzu+A6MZf5Vr+D5APIRLOMKj
	GA4Z6Sr0N0zp0OoGbEzE+NlDpLlDe7flZ7KKwV1Xm2Oi6X+dYajWTsjj4i4GrQ==
X-Google-Smtp-Source: AGHT+IFrDm6735UI/63EjXzjrotK6RyvKolr4AO3e1cwckwjGynCvF7pulss+Ma/8qhI3+63C1uKjQ==
X-Received: by 2002:a05:6830:849:b0:704:46de:5820 with SMTP id 46e09a7af769-70446de5c70mr9419292a34.34.1720761545505;
        Thu, 11 Jul 2024 22:19:05 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:05 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCH v6 03/23] lib: zstd: fix null-deref in ZSTD_createCDict_advanced2()
Date: Fri, 12 Jul 2024 14:18:14 +0900
Message-ID: <20240712051850.484318-4-senozhatsky@chromium.org>
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
2.45.2.993.g49e7a77208-goog


