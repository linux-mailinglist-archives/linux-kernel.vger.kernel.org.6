Return-Path: <linux-kernel+bounces-435175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10899E7383
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB37E16DAE7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4920B7E4;
	Fri,  6 Dec 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWcrq0ED"
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078753A7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498442; cv=none; b=gZNUzRkzTRLiAYkKfsJa/AjLZs8OQGrig+lQSjMMkRsvs/ZNR3sktQ8yIOMOOhyQftsu9ALGe1VBfR+QasaZj7zWtzGm0tkUP61aK8VmgaJN5+sKrsnd16HXJkf4RM7z3nVsgIWWA6h78MM9/aHKWSY9lnFA8ozMGQyy0uzrcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498442; c=relaxed/simple;
	bh=v8ZU8R9473XafyQXs0A95lmwgJKLwlPcEXOAahTb4EU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f8uNjxhI//3HVgAjpNjIk8VDqt4Fp4Rl+5JROuCFGQ/wZ3+/3ve06Yim8N03olVk33qS+Z5BPI3GZts/IkkDldDHqqLK5c7X7kLLOK/cnpl9bj3Y6tZEL0R24zMkJ3dlLNC2YNjY2Ou/fKPptHhHSYTHH0FvqnX7uyWZyKc9GiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vWcrq0ED; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d88cde9cedso39996976d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733498440; x=1734103240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwVnOnXdfn92wl4sT1YHXRB8FIHmKCEwkprjF00N97k=;
        b=vWcrq0EDKdK/Ll8bmDAqelLex90GkvnEJo0nHKYdHYDkC8xTRrS9UfvzVqVe3Kyng5
         6PEDn/ggasB6DmGTYnC9LhzfD4mh6uvMDLUx7ME2TmlTM6uHFuPceH7kgXGryPObVFk4
         dNJbLBF57Q7CO+OpOP/zX6zUX2nTcni4XPD0SbM1xr0zy9Oi26co+0HxMTzB5r1w+N9J
         me2vIZ6EzkbBZpRPYvH1C91B0E210q+nknIpB7xgDSUkSgVx7kceUjUKFwuKZaE+QvqO
         PDMKT2btHaVUL0rX5gFSIJ5Wq7vvLFQ1/YdtSebg2UkoR23a+MUzx6+GyMmRzJ1jhvc/
         vP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498440; x=1734103240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwVnOnXdfn92wl4sT1YHXRB8FIHmKCEwkprjF00N97k=;
        b=hbtxCB4eSQCH9WYQJXyy7FDqHVghCUMw/+KS5yXR/IOHU0s7qc1OmlNd66h7dqPXQz
         pQ6zX0qzPbDgTc7Re8q38//zNilVjbNA9JRUDg6lVvA5hEtawV7QlWDp5Xj6Pk5Ba/Fy
         1lys6Quu3kvQPE7ydyaeDQWl+pdWASxCkSNQt6YON/AbUz2grz2NEIjDXZ/JdhTJbKXA
         IKRUicLsHlhCZMlCeo1mucvTDbbtBtQYyTUBqPC4CfERaM7rTQAhhnwPsniS+3ONgYKJ
         4WEmfXNag05TvZH1u7N7ifXQNvKpcge4/0qb7tpP4kj8PwZfTGnyyzpy1oGB1BQma2Ko
         Komg==
X-Forwarded-Encrypted: i=1; AJvYcCW/AKoIyX3PeCqs1B2OBCUQwPdRH91LX3Fr13mCNCrEZ8iiDAuClhdXRkoGJoTgqQsthSCZIjWBxy9TJYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfY54MRCbIIl+iHGNIToC2pikp1EWRV5XUXhts2gH6/2uG9bUO
	jhKrz8v/M21KDe0M6aAin1+OzRZTw8kJcAKhxwEoQZuplnCZS7uRx6f64oyTj6sm8u6F9SyiFYN
	FCxFA5w==
X-Google-Smtp-Source: AGHT+IEfH1FXtnHp81uHQNCbhvflcG0KCGwOxAvecsfDiGH/fvZvEhEAXyUWb5dx7T3rn+eUqooSkCPdnl8A
X-Received: from qvkj21.prod.google.com ([2002:a0c:e015:0:b0:6d8:a4c0:2078])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:d68:b0:6d8:b3a7:759e
 with SMTP id 6a1803df08f44-6d8e726ed48mr55069936d6.46.1733498439696; Fri, 06
 Dec 2024 07:20:39 -0800 (PST)
Date: Fri,  6 Dec 2024 10:20:31 -0500
In-Reply-To: <20241206152032.1222067-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206152032.1222067-1-bgeffon@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206152032.1222067-2-bgeffon@google.com>
Subject: [PATCH 1/2] mremap: Fix new_addr being used as a hint with MREMAP_DONTUNMAP
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>, Marco Vanotti <mvanotti@google.com>
Content-Type: text/plain; charset="UTF-8"

Two non-mutually exclusive paths can land in mremap_to, MREMAP_FIXED
and MREMAP_DONTUNMAP which are called from mremap(). In the case of
MREMAP_FIXED we must validate the new_addr to ensure that the new
address is valid. In the case of MREMAP_DONTUNMAP without MREMAP_FIXED
a new address is specified as a hint, just like it would be in the
case of mmap. In this second case we don't need to perform any checks
because get_unmapped_area() will align new_addr, just like it would in
the case of mmap.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Reported-by: Marco Vanotti <mvanotti@google.com>
---
 mm/mremap.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 60473413836b..286ffdb883df 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -912,15 +912,27 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	unsigned long ret;
 	unsigned long map_flags = 0;
 
-	if (offset_in_page(new_addr))
-		return -EINVAL;
+	/*
+	 * Two non-mutually exclusive paths can land in mremap_to, MREMAP_FIXED
+	 * and MREMAP_DONTUNMAP which are called from mremap(). In the case of
+	 * MREMAP_FIXED we must validate the new_addr to ensure that the new
+	 * address is valid. In the case of MREMAP_DONTUNMAP without MREMAP_FIXED
+	 * a new address is specified as a hint, just like it would be in the
+	 * case of mmap. In this second case we don't need to perform any checks
+	 * because get_unmapped_area() will align new_addr, just like it would in
+	 * the case of mmap.
+	 */
+	if (flags & MREMAP_FIXED) {
+		if (offset_in_page(new_addr))
+			return -EINVAL;
 
-	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
-		return -EINVAL;
+		if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
+			return -EINVAL;
 
-	/* Ensure the old/new locations do not overlap */
-	if (addr + old_len > new_addr && new_addr + new_len > addr)
-		return -EINVAL;
+		/* Ensure the old/new locations do not overlap */
+		if (addr + old_len > new_addr && new_addr + new_len > addr)
+			return -EINVAL;
+	}
 
 	/*
 	 * move_vma() need us to stay 4 maps below the threshold, otherwise
-- 
2.47.0.338.g60cca15819-goog


