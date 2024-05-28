Return-Path: <linux-kernel+bounces-192131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D8C8D18E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AFE1C227D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B57516B74B;
	Tue, 28 May 2024 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEY4OmKy"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618217E8E1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893295; cv=none; b=B3bfdrocGrpEWS0YlI0rfDJpmazpueUXSSjG6nL+Nlphdl6CEXyKc9uHUrOaZMxr9z7sz69l+XYdQXsOMe2S+FcntjDl/X7XjWNhnXmudDFiY3KFoYM3Jc3WmX04us/GAzRmMALZ2Kaf78GyYmS2NcSgoEtDNfZHRt5BDh8PHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893295; c=relaxed/simple;
	bh=QsH7qyHnZwV+pVIlBEiVwh3VnBjC3Pq0FfVyhDVfYEw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T1xK7nzT+M+NZuZGG9InF3uKa6D1o17ZR/HlBGTX9RlvKN7NRGw/5CMDum+Dpq2ausIxD1kb/mP0+z6fAFyuVAtVbV40bAH5QlpLKFciS9Xdj1XvESWVv0SW+2Qq+d7x5cY7WGz0nqu+FUg57qJKU+OKbKcoARSoyjp6pgrbE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEY4OmKy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a3dec382eso6932727b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716893293; x=1717498093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=168aCLfPuYgGXMseZYgeOmJsf4bgrF3NmHxiEDuMCbc=;
        b=ZEY4OmKyTXPnwOfWfCcIFWDK56Hv5mfeLoNv8GK/zeYCLvgI0CwHQNaHnw7Ehn3aWI
         ArLDCV/3mH2ztwH3eVUCEZwtpVcC5oT5xPFii8aAd7kTsS2qosh8jdyfQhNhkeVwtFhY
         qls89tkAHjOL92V4+XAbi7c0Ax05igejxPkx8t/fgXTblHwZRxW5EIRZzcifIMGCKGCU
         gNoYwSFpL7BxGOQqc1/BYdS25wQRuHTmMjDGmI6WGLkOc+sYCRGMdKITwZamA/zQUb7Y
         /FSGu1gil4kUms8floPaKVmpJRlURyd8RSObFv3Q8EiCuY9+988lJwbuDO2nwbwBNdAK
         RaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716893293; x=1717498093;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=168aCLfPuYgGXMseZYgeOmJsf4bgrF3NmHxiEDuMCbc=;
        b=qKi+UxYFKcIbWmixJnIvM2VeO35PxgSfe0jhX7EaJGjehmGjR9xpA4V6ovUpHOAshA
         +ucpKjNSD34/XAzfnQ4eaivSB/jTOrPEIyLInfUvBsiQVWHefFoADw6fG0FXxSYoxmqY
         di5ZL/xubYhb2ckdn1FN/zbNQWjTM2sB93uFQmlupTjntgPZLhDqVvC2o/Ggtc5EqJgv
         BjrZaDIO5siMnlwtm9+sIdZ3qTOeQPZ3zC+h+LI+SU988DK5l3VVs9YxRUY3tklv+5Dt
         0E2QaRVDrTreQ0+WepL6FXSYpI9G5y32H8HMqhhdvItkMPFVcOAXZcOerJCWM8ggzDSa
         IC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlX4u+3mJFWgmk2kJvOj23KUavrZ5lX5pjDrzyDMRH7r+S5E1gpOzXou+gMSkLI9JvXXtAyW+xtZkVIDASfwUde+01LsXi+LXXptyT
X-Gm-Message-State: AOJu0Yxb18ikhINwsOJrDcIGmlsijIZOM0voZM8fBbnuaSCAvesGariX
	L+4e6T8FmcSkbumIrV5Nmld0fAXwTRQ7UAPV/YR5TU8oqP89BQC+WXszew6iGETOlYvlrOzyg1e
	JgQ==
X-Google-Smtp-Source: AGHT+IEDWQiLMhofWJRVp2xMhEilUEioPkayeNWYBHymPh/j08uSwId41HBaCP4sI/H4bKASCeL6PRXSLEM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:6416:417e:596:420a])
 (user=glider job=sendgmr) by 2002:a05:690c:600b:b0:611:5a9d:bb0e with SMTP id
 00721157ae682-62a076284d6mr32629097b3.4.1716893292893; Tue, 28 May 2024
 03:48:12 -0700 (PDT)
Date: Tue, 28 May 2024 12:48:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528104807.738758-1-glider@google.com>
Subject: [PATCH 1/2] kmsan: do not wipe out origin when doing partial unpoisoning
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: elver@google.com, dvyukov@google.com, akpm@linux-foundation.org, 
	bjohannesmeyer@gmail.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

As noticed by Brian, KMSAN should not be zeroing the origin when
unpoisoning parts of a four-byte uninitialized value, e.g.:

    char a[4];
    kmsan_unpoison_memory(a, 1);

This led to false negatives, as certain poisoned values could receive zero
origins, preventing those values from being reported.

To fix the problem, check that kmsan_internal_set_shadow_origin() writes
zero origins only to slots which have zero shadow.

Reported-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Link: https://lore.kernel.org/lkml/20240524232804.1984355-1-bjohannesmeyer@gmail.com/T/
Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index cf2d70e9c9a5f..95f859e38c533 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -196,8 +196,7 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 				      u32 origin, bool checked)
 {
 	u64 address = (u64)addr;
-	void *shadow_start;
-	u32 *origin_start;
+	u32 *shadow_start, *origin_start;
 	size_t pad = 0;
 
 	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
@@ -225,8 +224,16 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 	origin_start =
 		(u32 *)kmsan_get_metadata((void *)address, KMSAN_META_ORIGIN);
 
-	for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++)
-		origin_start[i] = origin;
+	/*
+	 * If the new origin is non-zero, assume that the shadow byte is also non-zero,
+	 * and unconditionally overwrite the old origin slot.
+	 * If the new origin is zero, overwrite the old origin slot iff the
+	 * corresponding shadow slot is zero.
+	 */
+	for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++) {
+		if (origin || !shadow_start[i])
+			origin_start[i] = origin;
+	}
 }
 
 struct page *kmsan_vmalloc_to_page_or_null(void *vaddr)
-- 
2.45.1.288.g0e0cd299f1-goog


