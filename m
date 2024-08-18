Return-Path: <linux-kernel+bounces-291219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F44955F27
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC59B20E80
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7B155725;
	Sun, 18 Aug 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID5NUka1"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AE1552EB
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724014972; cv=none; b=BCzeVaFgSruIhrjme+5jvAJeJleNLqf+b5LA2840Aw00awTt0DB2QZAo9YIW3oX9jE0Gc5hBbpfDXkhTEWt0mvE50+WV4jJBS4T6wVhkNM1wBqEf/Cisq6Q3Jt217d6ZvnQiKDBfRo4SBZWJFJTc85UrWH8KbCPKegFN6XGnV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724014972; c=relaxed/simple;
	bh=Od8Vv679wkIb+OJjG6reaAuxQT6UfeebfzvssUo8H4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVDPcGE7dFt7yaTxU7Gnym/1p52a/j42zr/LPdgro3ejXoPI7NbkO08t1grHH174e061GOP7+TTqs5aobwfYQeU1sKDGa2LkQCuzRMbd8XjOLwJXTQgz65PGy2/kN9FvlvcmNwqFYBGNFHFYyJe8NN4WbVB94EHR/8Zs8m2Qbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID5NUka1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9a369055so361864666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724014969; x=1724619769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBL96drYSuoCdxGZV7Oeu8x351yRAla81LihXM7ATxg=;
        b=ID5NUka1jcuai5ZTHII7nJMN+0rTJJqdCFHhw5HwNGm1/+K7LWUy47sRdbVJxH2wv0
         Ubl37jXnwXYSGn57m9b638L7JN4acl3VnthEbnprd9SDoobTtuWtqaQybGnFBLkvHI67
         d3NmL2X5qLMQiortcaT64oPsFo8n9KgA5fKStT7Z27/qYSjvTzrVkU+F+G9YsetLLLW1
         zmHwmIi9MzRC07o/pg2EBRRkinwGAcTKsV+4eGwsEC/Ujc8Pgu3n/mlWUWd8U61XsDQ5
         rkrHLO4awZqOHukbTnQzk30nCc3fovkTJiLkpTYPQlMNon4sITN2QrROz17TechX5wZ2
         lReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724014969; x=1724619769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBL96drYSuoCdxGZV7Oeu8x351yRAla81LihXM7ATxg=;
        b=p81sSgPwRfbNWF6gscTURUXvKV3M9FBpmiHKP65V/nGMeOMMFdyDUsvJpSVUqnXAQ2
         9TA+ywa6eOMqacoNElxhxUvhatjYZdETmOhYpBbItkqugIMKaE8gNRaAuZgA7X2jFNgR
         +uqn8X0DMS3K2fcu7yl76xTV+zn/bIDoz9G5wb45KB+NnVEz9tk24I94Nwlvnt6D5HAH
         gS7EBSWyFcuUoIwbb9XwqSJGHUgTNAUKB5tHh7GeGnErXVaXjMVdoZUIFdXYioOKJULx
         dYBiesnbgMU+q5ji2S95685/KckHjHa9AUmwE0iutF08kbHuZXJLBNcdbhuCIg6HvlR1
         OE5w==
X-Forwarded-Encrypted: i=1; AJvYcCX2rjtyuW3UYb9V7ScgQjER2pbnyw0uc+h662xcr+1mdw6aTcwuwZyrHJ8d7nIKc7mzjpUzT9evOju6PVCOhEHkUlxiX5gjM5akNn89
X-Gm-Message-State: AOJu0Yy+0yh9uDiyVSwokz/S7qeuOGdkPGFeouJLumo6Fl9FRZQ0TzZF
	e3JPQJx7kAypNrQ5IQBquMMApPiVnzoipfTdLuaGGJD2JES+rFDZ
X-Google-Smtp-Source: AGHT+IGaRA6V0RqJu1NK84ILI5ADVTm+Oy+tgaxaQutwadRkt+b2L4mLzehwnrGD21KawqEWePr3pA==
X-Received: by 2002:a17:907:6093:b0:a77:db36:1ccf with SMTP id a640c23a62f3a-a83aa0a0587mr325441066b.42.1724014969123;
        Sun, 18 Aug 2024 14:02:49 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfd5esm552895466b.78.2024.08.18.14.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 14:02:48 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/2] mm/kmemleak: Use IS_ERR_PCPU() for pointer in the percpu address space
Date: Sun, 18 Aug 2024 23:01:52 +0200
Message-ID: <20240818210235.33481-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240818210235.33481-1-ubizjak@gmail.com>
References: <20240818210235.33481-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use IS_ERR_PCPU() instead of IS_ERR() for pointers in the percpu address
space. The patch also fixes following sparse warnings:

kmemleak.c:1063:39: warning: cast removes address space '__percpu' of expression
kmemleak.c:1138:37: warning: cast removes address space '__percpu' of expression

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kmemleak.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 764b08100570..fa468809d043 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1059,8 +1059,8 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 	 * Percpu allocations are only scanned and not reported as leaks
 	 * (min_count is set to 0).
 	 */
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		create_object_percpu((unsigned long)ptr, size, 0, gfp);
+	if (kmemleak_enabled && ptr && !IS_ERR_PCPU(ptr))
+		create_object_percpu((__force unsigned long)ptr, size, 0, gfp);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
 
@@ -1134,8 +1134,8 @@ void __ref kmemleak_free_percpu(const void __percpu *ptr)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
-		delete_object_full((unsigned long)ptr, OBJECT_PERCPU);
+	if (kmemleak_free_enabled && ptr && !IS_ERR_PCPU(ptr))
+		delete_object_full((__force unsigned long)ptr, OBJECT_PERCPU);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_percpu);
 
-- 
2.42.0


