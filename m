Return-Path: <linux-kernel+bounces-199115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E38D8253
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4235E28613E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7DF12BF3D;
	Mon,  3 Jun 2024 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP/vHJfZ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9612BF23
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418015; cv=none; b=s0uejELkFC+jMdA1WtwOZTlPFX9q9NSBIo5enYQoo1vdhgBLzA175FXwOfZE4F8r169ZEQ/z0+dJawK2vCcmdHu3oWQ0ZUwzePw7vuWrd4CMt77zVbAcu353eQLJvh6rcvVYURmoiC0fM5otBmjWfez9k4oMJ7+x8NcqFOjlVJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418015; c=relaxed/simple;
	bh=kYIuQsN2L0HfcJb21dz7RS0YauRbygmsFvNM6IcF+4Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sXbbWpvcxqLyZOp8uILOh/cLHY5G8OAGptFpkSQndIm0TbfVyPPMQnGNrbi5TeX3Oa+oqHea9kHleK7Y4GHGbEfkQs6FsIF1IyYXnQh/Je7DFKABuhNwRKCy4bjdC7wkR5Yy26zeSB97ILnHxaeq9e3Qh8MI5M09s8S9fcl65AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP/vHJfZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52962423ed8so4771779e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717418012; x=1718022812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Ru8Np0KrRH/lYPvykLiPbmxJAWT+d6nNSuG8nv7VOk=;
        b=hP/vHJfZi/bHrQ4IuhaBnYngwwZ2sieK1DnZjJdIiIwot+xje1GXPGNRUDB9vwu2dR
         VbUv9H4Ank2P/V2VKcnk44SqoXGY31aFJ3nLJq7AiuGUaucTr5n67ZHW3FEDQis1379R
         yK/DYRkEYOmGd2xnAmq81LBGa0XbKYzbILoUKbUKvaKKHa2mV4O3Oz5B0QEuJsRqImYc
         NWANY+djXBoLuMYN+8Mqzyvgqa35sGIe2xB4Y459b3LjPgcyFtzmfzW3J0pZR5Q/nzZf
         vWa4dJ3C7vbb0JBeB0L1pIJ23pkDz7SvNMBpXMwe7K2mQ5FQNjIP5MLwYHug2EVWH5k4
         abgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717418012; x=1718022812;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ru8Np0KrRH/lYPvykLiPbmxJAWT+d6nNSuG8nv7VOk=;
        b=LaBzPQWWpeCrVR8Q0FP75NwYM7SVcR1cT6QycvABmjAnBQB3Q9TR9OQRQvB9zfglZN
         PDzHOsl8pHu23edyvELI/EKy7xOJhqVIXNiZ8yIf01pYfJ62zH2+85+m6YWS9xrxeQER
         SvoN4KF+Nkw7IwbY0P7WgYDZ4E0Y3WCx3iLDijuGRWkS9hnGckkKSHU0CIJl8ysTdxNi
         nW3BhacFbuY6PR9Mbwc0nHPH7yk9jLgUs37Hxqzvkf4aqOHYviCsSZRacfPo+6xVmTGA
         KPOkmC1EC+L5rkN9o8jg1eVbgqNbryJ22dhf3NVnVkWzoptBDvwioullrCln2+0etSV0
         dzZw==
X-Forwarded-Encrypted: i=1; AJvYcCX4MQikx0KJImrr0OVKR8zGEZasQRadoTSVt1Jl5fPW/DutN4+gMcaWZt7da5sYma1YoXzK1SQQ+bfI8jLlU8JGAXX3t8HvOLas6FJ7
X-Gm-Message-State: AOJu0YylzzH9LDNb9fDbz/2ikOV1UOb+Ciyjx8cb/XI3PYOOvviwhX3G
	5TQFI/SYYk4dIjRMhXD+KRi473bjD0dpAWZQkhoqgxLbScT//iRnHPRCHw0YdRK14BSUG4n0JpH
	iunLvZIcwI7ZJYupov+RKP1hDOE0=
X-Google-Smtp-Source: AGHT+IELbgEKpUYqgg7/B8eBPlQ72lpREBzdEuG36lLClLg99bLNWWdoXAoX4HgzvKzIriL8h+z/Kw3R6J65SU1E728=
X-Received: by 2002:a05:6512:314a:b0:52b:79a5:517a with SMTP id
 2adb3069b0e04-52b8959daa7mr5518994e87.33.1717418011642; Mon, 03 Jun 2024
 05:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Geunsik Lim <geunsik.lim@gmail.com>
Date: Mon, 3 Jun 2024 21:33:19 +0900
Message-ID: <CAGFP0L+BaNAtCF7c7cJ1bvbjomp03Fy0=6=w6dj29Fnr0ygSCA@mail.gmail.com>
Subject: [PATCH] fix: Prevent memory leak by checking for NULL buffer before
 calling css_put()
To: Axel Rasmussen <axelrasmussen@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
	Hugh Dickins <hughd@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

This commit addresses a potential memory leak in the
`get_mm_memcg_path()` function
by explicitly checking if the allocated buffer (`buf`) is NULL before
calling the
`css_put()` function. The prefix 'css' means abbreviation of cgroup_subsys_state

Previously, the code would directly call `css_put()` without checking
the value of
`buf`, which could lead to a memory leak if the buffer allocation failed.
This commit introduces a conditional check to ensure that `css_put()`
is only called
if `buf` is not NULL.

This change enhances the code's robustness and prevents memory leaks, improving
overall system stability.

**Specific Changes:**

* In the `out_put` label, an `if` statement is added to check
  if `buf` is not NULL before calling `css_put()`.

**Benefits:**

* Prevents potential memory leaks
* Enhances code robustness
* Improves system stability

Signed-off-by: Geunsik Lim <leemgs@gmail.com>
Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
---
 mm/mmap_lock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 1854850b4b89..7314045b0e3b 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -213,7 +213,8 @@ static const char *get_mm_memcg_path(struct mm_struct *mm)
        cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);

 out_put:
-       css_put(&memcg->css);
+        if (buf != NULL)
+                css_put(&memcg->css);
 out:
        return buf;
 }
--
2.34.1
----
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

