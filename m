Return-Path: <linux-kernel+bounces-243777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76493929A6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B57A1F2115A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B76F3C30;
	Mon,  8 Jul 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHVEMQBp"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB763C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720400424; cv=none; b=T8epB7j4qZPCT8Bp5SYaafDoC7JBSG1h5EjOqIqUAfKmJUiJT9m+Um6s2KVN7d5UrqEKqZzgGRVD4GJkbQ/cYwBvGI3ETuScoc9wqHgHyvHx/5ADzHQWV1JZ0gJsIN/04sP+P7v/Lftuh6Eug/yrPnHmWYFVytKzFGzCcxHK+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720400424; c=relaxed/simple;
	bh=SbJ5jH7HTCaPQ29C934mRKx80B8YiJkDdAkEVCksC+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=guHl3jch6tjI6hnHTaebldxisNsJqqTrNxXFjtUeW6wxBY4e+VvFEZJ9q+ZJwE8IIdEzjjePB69cXJXAau2ZuFYc8MvdFTbQXJgJn89fgnwvSVsDVpAv6Z9M2GoqDZ2y9UeHwjXWjNIwSfXjL7SvUbtfGVvAIhxaBuzZCqcu8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHVEMQBp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso3844619a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 18:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720400421; x=1721005221; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hlxAVPd+z/4aF6F4fWIjQzN+IGGbLzBgd/ODx938I10=;
        b=bHVEMQBppkN9witXzbQUBSplsOCiNzgVdZhumh8s8OIaKX6KyypsAb6zeU+H4cSb52
         i6C0SUmkSxwZlwLQpae0P6Tqt0jifHw0EdiUy/MwFY4lO89rpVOXgs6obpv22ZyMADZ4
         HGsQoBlC5hR7qcdGY1AxdaO/vGb7yIA6euai8B+ORlgLlBB1taSwXqX5+BVr9pCGFg8J
         Kqxxgw2uRkXm9iNh0ZI6GNLRdUs+Za3AobBQILcNqJuoLIhevs+2n0KGtOSGmRKar1cj
         IO+JvxEVcpU2e0c1gqrefvuNx5y3zctsnpz0PY+dNDbEvEoMALOicjBhDXEd1asuS7GV
         Le+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720400421; x=1721005221;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlxAVPd+z/4aF6F4fWIjQzN+IGGbLzBgd/ODx938I10=;
        b=RVLSO+6jYO1flBHldVVF1g4GNIloGsH6bY4cSz4gKxFTzW0jKR+VepZT7ia8WZRXZa
         oXXGYnP+Jyo7YyemwNDa6QNrYSLse47Sk8Xr7NajJc+PPHojrTNNr85/A2UUk6R4ZEPQ
         ibZGcgqEXhNBe9XITRlL56FMdeH4zvCdTIwwNXufaNkOnLfZ/fWt/z+aUiwEseRbXQFm
         Oo69GSNFWpJYiV/zLZ3RbjdZ1+b4CIfJWjuYdRC6tyHfI5VCh2lTSP6bZuAvK3xSOc8/
         9zdcF1Wdlp1W6M3NopWAo+mEVvGtk/JbjvDcEv0/cm+EeDi9q275QjjMRxBfTYgAEI5i
         saNA==
X-Forwarded-Encrypted: i=1; AJvYcCWHt1xBCu91Pp06WTILS3rDfKhEjmwlVMfDH5BAJ55H7ZNdnjxBLy848K9YvCHUQuMvcW3bc7cKEUYjrwEPiezOz8qmjkWAGSfpQi4l
X-Gm-Message-State: AOJu0YzPrRHUcERLyK33N8q+g7Dw83+vQF5hUrAa9iVAsjZehIT8oHhB
	pyq4F1I1NCiGJR63D7yn2bsIa2shXTVvcwDmvuzBWNXPD4xA2Mox
X-Google-Smtp-Source: AGHT+IFX5JH5fjmnJZzHRqOg0baK8jtW9JI8FZKW4fJv88ESO66YeKMsIB3wCBd+Yn1bb+6es6HRXQ==
X-Received: by 2002:a05:6402:5255:b0:58c:7c2f:5c0b with SMTP id 4fb4d7f45d1cf-58e5b4ae20dmr5541899a12.25.1720400421288;
        Sun, 07 Jul 2024 18:00:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58ceee04b51sm5987050a12.71.2024.07.07.18.00.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jul 2024 18:00:20 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	mjguzik@gmail.com,
	tandersen@netflix.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 2/3] kernel/fork.c: get totalram_pages from memblock to calculate max_threads
Date: Mon,  8 Jul 2024 01:00:09 +0000
Message-Id: <20240708010010.32347-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240708010010.32347-1-richard.weiyang@gmail.com>
References: <20240708010010.32347-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Since we plan to move the accounting into __free_pages_core(),
totalram_pages may not represent the total usable pages on system
at this point when defer_init is enabled.

Instead we can get the total estimated pages from memblock directly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport (IBM) <rppt@kernel.org>
CC: David Hildenbrand <david@redhat.com>
CC: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..e80e889543f3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -44,6 +44,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/memblock.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -999,7 +1000,7 @@ void __init __weak arch_task_cache_init(void) { }
 static void set_max_threads(unsigned int max_threads_suggested)
 {
 	u64 threads;
-	unsigned long nr_pages = totalram_pages();
+	unsigned long nr_pages = memblock_estimated_nr_pages();
 
 	/*
 	 * The number of threads shall be limited such that the thread
-- 
2.34.1


