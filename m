Return-Path: <linux-kernel+bounces-362804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83FF99B977
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23A91C20AC4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA09642AA5;
	Sun, 13 Oct 2024 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMXT1pDr"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A85231C9D;
	Sun, 13 Oct 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728824518; cv=none; b=a46YefXba0y+0y+MWTXw4JXVlVONzumeN/2/piHrkbkT/iouNRjIkQCVCqdZM/xoil1/7zAgnYBULpl8ZyYO0hqq9ppJFGYbCSJFrjs5S+T24r6uIlgd6YhE59KXz6lyifH1MrT+DxYybdmAwZd5NhSocj5KCQq/PEzOSMoaqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728824518; c=relaxed/simple;
	bh=QXZEJoFSggOrdz5mMDrg+gJdJU7I21DSRG8B6ih233o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTOYpuissYreh8f8ufIxQKbJBc9OCGIBZzUS+oqNDZ/6Hmn0uwp+7oeouSWI0T2RHpCiWEy+S87zgiJVkXdDnfQh2k5Pl5r7AHHlxMyimynFm+zOC60yg56hnFynWobedYXzH6wdA/h00b7iH2jguQ9C/OKszt0rqtpbTaAnMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMXT1pDr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99ffeea60bso78601866b.3;
        Sun, 13 Oct 2024 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728824515; x=1729429315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUH0O52iG9NocMBQX2ifD6HnZr5R8mVmxmATQ3anrSs=;
        b=jMXT1pDrInGvE03fMxC9e9yqQ94T52UZa8WBZklD6GX9BgyCx5vOl/gxMern9zrB72
         17yhjA0bFZ596sm17BptwNcp2gscXEd62rS822RywSc2SpwOZpjaswGftiErv69ClGU5
         +8CoQwzB9m1JrLm+2gOCqbLqKVj8RIfIfxvjC7t1DtRI4+aCwGBhSOT5t0qA07evSA5r
         atTF4k0pE9UMCpJ1iCdFKGuhDonWCGyZRsDFACO6RDY/FloSUXUObz70+z0ffOygW79M
         w4zTayUlGBtTKWH+ZXtJGqm3IBlT7NEHOF4LumO9LejSrwbYuBtr8SsxMrVCMvtMn+hq
         8agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728824515; x=1729429315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUH0O52iG9NocMBQX2ifD6HnZr5R8mVmxmATQ3anrSs=;
        b=j95W7AIu4T1DWlh8jF36lv8QFo/L6eQK/8GDaRn8MIriqQHOZhD0gSr/t4Cq2mWlMZ
         25mC/ziZlbYpzXzK7ju1PXpXq8OjiKlQgEU13l8n7QL8+3NOweb6lwN0yH6N/uMU1fq4
         aKkdjcWjSkRVfqNvKxbkyZYuMm3oIXfBt66CAi33LDR6xR2C3N6sGvwsiGFeNu2Dqxyo
         bZipJYNAGJzQ2XL+wrmK0PY89KKDnPj33oRuh93ncOhmfB7Fer1RSCoNHlm2ZZXG1zHA
         tOEkLN3Sm3YL/HYoIPkMNek4Y7jCkFr4sNwI4WOuf+2RRp9q56t2rOYk+H3Zm0UQvQB6
         WK7w==
X-Forwarded-Encrypted: i=1; AJvYcCU3PDjR1whNeRxwcTENZ/UbkovWZyaD/641BVwIQP1q6Za/jGn7GxqjFa3g1haQAzfZPz+AgH2E2NSuSEAM@vger.kernel.org, AJvYcCVBeqY5gboZ3xG7mkh6xcfoq4bWc5vNNTEPaPTDQPW83FqgqThb7MDd3h74WeT4JcwRGRLgeJmln2kd@vger.kernel.org, AJvYcCWCPu4m8NS4Z7E0qk3x1rw94C7c+xwj2HJE50LhIci/WH3rGzp3dikIdueVulrx/clhIXZet5Lyeqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8wvuDIo/YfAYYsJnca1iwSB7V+xgm/zh/WKjg2hrBhybctLw
	pzhP/o5+f4ZwRl2rGSdxNFnX17y3ipM2j5jzG4pMZT91x8AT0t+g
X-Google-Smtp-Source: AGHT+IF9TP9UXY7+Xn/KTanZ8SmeeHtdh4zwU64TMJUgxaxAT9yUrVHKBUO3RgLezRWQskcH3dLtjw==
X-Received: by 2002:a17:907:2d8b:b0:a99:399f:cf2b with SMTP id a640c23a62f3a-a99b93ae7c8mr624523566b.12.1728824514634;
        Sun, 13 Oct 2024 06:01:54 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0d9de967sm19209666b.139.2024.10.13.06.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 06:01:54 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: akpm@linux-foundation.org,
	dvyukov@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	snovitoll@gmail.com,
	vincenzo.frascino@arm.com,
	elver@google.com,
	corbet@lwn.net,
	alexs@kernel.org,
	siyanteng@loongson.cn,
	2023002089@link.tyut.edu.cn,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 1/3] kasan: move checks to do_strncpy_from_user
Date: Sun, 13 Oct 2024 18:02:09 +0500
Message-Id: <20241013130211.3067196-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241013130211.3067196-1-snovitoll@gmail.com>
References: <CA+fCnZdeuNxTmGaYniiRMhS-TtNhiwj_MwW53K73a5Wiui+8RQ@mail.gmail.com>
 <20241013130211.3067196-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since in the commit 2865baf54077("x86: support user address masking instead
of non-speculative conditional") do_strncpy_from_user() is called from
multiple places, we should sanitize the kernel *dst memory and size
which were done in strncpy_from_user() previously.

Fixes: 2865baf54077 ("x86: support user address masking instead of non-speculative conditional")
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 lib/strncpy_from_user.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 989a12a6787..f36ad821176 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -31,6 +31,9 @@ static __always_inline long do_strncpy_from_user(char *dst, const char __user *s
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	unsigned long res = 0;
 
+	kasan_check_write(dst, count);
+	check_object_size(dst, count, false);
+
 	if (IS_UNALIGNED(src, dst))
 		goto byte_at_a_time;
 
@@ -142,8 +145,6 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 		if (max > count)
 			max = count;
 
-		kasan_check_write(dst, count);
-		check_object_size(dst, count, false);
 		if (user_read_access_begin(src, max)) {
 			retval = do_strncpy_from_user(dst, src, count, max);
 			user_read_access_end();
-- 
2.34.1


