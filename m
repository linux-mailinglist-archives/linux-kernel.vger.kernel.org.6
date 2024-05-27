Return-Path: <linux-kernel+bounces-191392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6079B8D0E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB4B283442
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7716086C;
	Mon, 27 May 2024 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYv2ITGJ"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A091667C3
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716841826; cv=none; b=fzVHkCxSC8hTqB4U7a0wz83zWKqvaHpJK4JSYHvr5xp5jSKVVtjpsYMCkPAP5l3Qf3C7IdKxUGMORYI01ijuOisVgaW/K4q67E+0cJAHqxZHDK3p6N6ay05IY92AVkacjPmVmn7QVOVI4XA9KSYSjOnQMS9HJiZ+l3vx80n+eHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716841826; c=relaxed/simple;
	bh=1LD7c5LViI7urQvc+sfSQLQyNFLgn5A2MV6jvln6c2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZTcsNEO2aAGmO05lRrIo5u/jyfd+sghZthcqPKuWq3+geuNlSjSXGCy8gFi4A95Dmb5YhSDnaY8z/FN9CpEIoaDg55yBgjCY0LLzGyVKk9V2xPTTeD9ePRLbfoN32Jm+66aW3+TCs9EjdqLzKksWp7Af1fR/Q4kQpLStYCfHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYv2ITGJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-698ef41ed78so15000a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716841824; x=1717446624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u1J2zaM6wMEMZtGfmaKCd9HEjdRd9oqVcYxMgAgPQg=;
        b=OYv2ITGJjitO9pPbRF1dauiNbJ3wlxMr/+0oviLu3guYNVtqRpqygsNOitYif+rpji
         Tb9zODnok6h2laJC5SKPIu7YaM8Rs38waMuYjHvYHjQhWZMT07Q9oVvXNl/GttPq3PXT
         dyk/c2ZuTIV9WAMoCWigfeEdOaTuj58JPt7/qWGpbhNAPX98exrMDpSPU4yRAOi6oEyS
         TYB04WBEtiiE/hUKw+Bkmb6erbb2LTlWKSPb4ZQ2Yss8tkU6QLHAcii+CoseLzrObciq
         FI1Ox41QV6DkcSfh7GY87bz5d1sbBjWAlW9YG6dCarP+M0nBSwruoT/Ttmt6Y2L0Monh
         i3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716841824; x=1717446624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u1J2zaM6wMEMZtGfmaKCd9HEjdRd9oqVcYxMgAgPQg=;
        b=AEKpbpvQKAgIfE3e/179MzN7ObIvBHJ/1YXqouv7UssH2HTgwypyf1oFq6XSlN+w8K
         2+4HywgEncWLUqHHd8RTQRG1Jb6i00gJbiESBcDyDsAmMcCMrX+pMGt5GiaIVNrp38Y/
         O6lLMos2fnLO4EJzSrE0TdtsoZ8Id4hZmBcsNswzQ8EjIHXk1EMd4Qkg3V65JzbQoms1
         59lbMfYfnS0OZXbpHgvMV/17YkIrUoMnM833/XW1PiUSH6gLyP6zQdqp8l3RqEYYMMMA
         4afM0aGeSD2dYYQQUzDrIhfXjda0l3JV3095CTKt8bm1xYXVNpjp4deCQuSPCts3E9s/
         SlqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6mvPmXKqj34uQ/kvrIGj1UVQyk3RlqaRduqwqajfODIQKEcG7ez3HSarTOmbND1FJF6bUXuliyR8371gEcf5VL+hA9r+k4bnV9Vi3
X-Gm-Message-State: AOJu0YwkDCfdQC+1tjXKd7sAkNVtCR47fOYIP9QwlVJF29hSC6M950gl
	wLETyrSb3FM6ANxDEdYPt19dWPzfPQe7iYMTzfjPTK7jmPTfazfcWc39gA==
X-Google-Smtp-Source: AGHT+IEqo3X1+g+xb8gq3a69aw38LlEIjE24l4riHOcwFr919xGm+e7v0AexfS3qQRnsRZA0dz3Cnw==
X-Received: by 2002:a05:6a00:2e85:b0:6fd:1705:9cb8 with SMTP id d2e1a72fcca58-6fd17059fdemr7479260b3a.1.1716841823980;
        Mon, 27 May 2024 13:30:23 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822092a678sm5324279a12.11.2024.05.27.13.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:30:23 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 3/4] lib/sort: Optimize heapsort for handling final 2 or 3 elements
Date: Tue, 28 May 2024 04:30:10 +0800
Message-Id: <20240527203011.1644280-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527203011.1644280-1-visitorckw@gmail.com>
References: <20240527203011.1644280-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After building the heap, the code continuously pops two elements from
the heap until only 2 or 3 elements remain, at which point it switches
back to a regular heapsort with one element popped at a time. However,
to handle the final 2 or 3 elements, an additional else-if statement in
the while loop was introduced, potentially increasing branch misses.
Moreover, when there are only 2 or 3 elements left, continuing with
regular heapify operations is unnecessary as these cases are simple
enough to be handled with a single comparison and 1 or 2 swaps outside
the while loop.

Eliminating the additional else-if statement and directly managing
cases involving 2 or 3 elements outside the loop reduces unnecessary
conditional branches resulting from the numerous loops and conditionals
in heapify.

This optimization maintains consistent numbers of comparisons and swaps
for arrays with even lengths while reducing swaps and comparisons for
arrays with odd lengths from 2.5 swaps and 1 comparison to 1.5 swaps
and 1 comparison.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/sort.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/sort.c b/lib/sort.c
index b918ae15302d..048b7a6ef967 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -250,10 +250,7 @@ void sort_r(void *base, size_t num, size_t size,
 			a = size << shift;
 			n -= size;
 			do_swap(base + a, base + n, size, swap_func, priv);
-		} else if (n > size) {	/* Sorting: Extract root */
-			n -= size;
-			do_swap(base, base + n, size, swap_func, priv);
-		} else	{		/* Sort complete */
+		} else {		/* Sort complete */
 			break;
 		}
 
@@ -283,6 +280,11 @@ void sort_r(void *base, size_t num, size_t size,
 			do_swap(base + b, base + c, size, swap_func, priv);
 		}
 	}
+
+	n -= size;
+	do_swap(base, base + n, size, swap_func, priv);
+	if (n == size * 2 && do_cmp(base, base + size, cmp_func, priv) > 0)
+		do_swap(base, base + size, size, swap_func, priv);
 }
 EXPORT_SYMBOL(sort_r);
 
-- 
2.34.1


