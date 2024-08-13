Return-Path: <linux-kernel+bounces-285263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 207FE950B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE362B2301D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471EC1A2C12;
	Tue, 13 Aug 2024 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjZByQBE"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6B170A18
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569962; cv=none; b=PJ8nztI8vEi0+vQ/9TxViB6P6hXHwMgiAn3NsFQp92UkCjtzzYvuo8TCHYBl3a7JfytBehj+HCUJRdKrXUkx24rIsWv8bzsoTR7yAppWJs6rZJDsgd7wzwbrS3cEgg8m/dvs+cx0W5XSpwrj2vH5Hrhx6oVA8H3gsRDBsDopO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569962; c=relaxed/simple;
	bh=Od8Vv679wkIb+OJjG6reaAuxQT6UfeebfzvssUo8H4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUYJl+5XqicR5L9K4CH75rxrdEUNEomy8Rfc38vP1KsYLQNa6IkU5Ud1xM/1FKzEd6uy9tWwjIV/PYNYRaeshU213ptKz2bHKEASLBpG53hYg8Ovi/0Q/+DBgyn4tZ2KCrlXjdSXJBP7lWUH1q/1jKh9jrxTQBiJbAcIiDM3swk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjZByQBE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135eso151903a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723569958; x=1724174758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBL96drYSuoCdxGZV7Oeu8x351yRAla81LihXM7ATxg=;
        b=PjZByQBER6wZoMONpYEDURjqiBQI01KY8Zj0NqRfcgC9wFqn8iBdPz/Ab/nWmbahix
         PHvPRK+TyTISVc6QPhwYeh4WuxYgLr47LVdyJgclx9ayttK6kOGnqQpuj+Q0E6Gaj90p
         nwVNMEhVGlTV5w1iMh1ShgxVvtK3M2gmFWA4DKAkGLkml6vCoi5lI/jG3hYUlI/CABKC
         xG6RXyVY3n7lEbVnh3HYzuelxfRtI8X4IrSkYJDvUHMkQXHpKHj5FY7fPqNy7q8KbEhU
         4CkLgyLQW7IuUsE8FUiap6f3nxdNBpGmwg6oFHMjb5nXvPrnlbceZ0XPqIaGzNSxB6Ym
         zmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723569958; x=1724174758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBL96drYSuoCdxGZV7Oeu8x351yRAla81LihXM7ATxg=;
        b=QXDyz+YLS3RD5jTSaqU1SaBJtLkdeLCT4P5C50Y53NWCsoQV6i8MXN9Rz88nT/ia6Y
         QjLhOtQqIk7I895DEWsJA1IOv/xgRn3xCK750H/6t90HJA4q/Ywo5Dz8emIA/Ui9O+U8
         8QbAcnD0CMlL9Hbn+MW67bilVYgSwdzKT1B0PaG65nqa78IynHQ0n+u229U/nWinzRHH
         E82/aQA1MGzOTcEkP+va2ZbTaMGfsSujTxIUrjwUGZeMEZVK1KBDpoQXb0gjLaiVlLHy
         wtevyJDQCVhqO2u6BpSb5SgJiMzDPub7vd+ac4bcqBT1joQ4SJl3PF7NwU336NH1aDdq
         rO9w==
X-Forwarded-Encrypted: i=1; AJvYcCVniUJhTQATb4G97xpdoKCxGELLBLWPAOyteakpalg1+aZjOc8R+B/iCe9LlkADYOzVnVs48GKC9xi/grxWweYn/+n2HBz40XSxxue+
X-Gm-Message-State: AOJu0YwVow7xToV7l3WiH1NbEX0RD+L68ef/dT+4Z+R2sPFepufxoL1R
	aUwqxR43qAAeJRU01O/2P7uK8IHItBWShgXvzfrA2wFo8AdSuBjJ
X-Google-Smtp-Source: AGHT+IE4QVfh8ydmK+TpVVe6ygWjOUjOSzuDmszscqXIoFmJ1plu1mVf8Z/I++P76Wku5ywDOfQJfA==
X-Received: by 2002:a05:6402:2497:b0:5af:b1d8:f3d5 with SMTP id 4fb4d7f45d1cf-5bea1696b2fmr315160a12.12.1723569957956;
        Tue, 13 Aug 2024 10:25:57 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f33cfsm3048343a12.5.2024.08.13.10.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:25:57 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] mm/kmemleak: Use IS_ERR_PCPU() for pointer in the percpu address space
Date: Tue, 13 Aug 2024 19:25:11 +0200
Message-ID: <20240813172543.38411-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240813172543.38411-1-ubizjak@gmail.com>
References: <20240813172543.38411-1-ubizjak@gmail.com>
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


