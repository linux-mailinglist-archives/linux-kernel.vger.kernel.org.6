Return-Path: <linux-kernel+bounces-552061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DFA574DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E600C3B5152
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAA256C9B;
	Fri,  7 Mar 2025 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VOBt5Vhb"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B023FC68
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386320; cv=none; b=BVdAwXfw86okyh2194VexUaxM05+o8uH65hxdYwR9mTtx6q/PYBIM/qp8E1iVr1Epd5GbZXxvYJivUuXHqr7n6FokIOp+PD6X9/HG+GO48Sm1yjVczaNjOebBOFSXMmJnXuy0Tx62URQwgKyynq8Rv+FB1Gg3zYNz2c/hPpRbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386320; c=relaxed/simple;
	bh=Tefjw0Zt4cnyZO02FKhjkwBKwBWG4UZLtaZPQIzucR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R39bSblh6HSPJh84AbLLVXj/exHV3wVY04+bPiXv0aY11yoQAioWa9RPBeN1KwMDVvia/i+9TxAB1JEVEmRnpnr5VopzyqBdPpYeE0Dto4G7r0avaV146f7/E4366RRwthaHPUc8kb0jjAC3zRwTCjXqFSgSZZoqYptoHTaB2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=VOBt5Vhb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf45d8db04so365078766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1741386316; x=1741991116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7bxGM8ehnB0CKiiNXfobN0duR+gRIWC930Rlv14dlw=;
        b=VOBt5VhbTOia0Al5PKYxai4X+deB6jaRpfsUq7LHAjRR3qtE58dZazkmVMzcVQ/nh2
         xlOg7a2SL44mIW2FFujDKocMJ0Q+ImKdDgX10VpDgYcOHtLNDJVdPMWx4J6ilCiqIgdA
         QbiibculboRuexNoF2QGzv4YRvQSlo4KGVP/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741386316; x=1741991116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7bxGM8ehnB0CKiiNXfobN0duR+gRIWC930Rlv14dlw=;
        b=tuE/4XvloYc79t3mpURP166h9hpcNuk/NtVCQx4vq5MOl9q7sySDOsTYqckDfjrh/a
         ax/OLaZCtR/FXrXyu+QVR7dDHPUGQM4B1lQpOci0Z2FYLoAAyMHdFRE6VjB9JAqv4yg+
         2IcpHchIsXrM/tvD+uYGbo92DSSgaWCwJaNGnJ7R2+YHg47smTm4DHAGA2QPqUryk5Ih
         y9ESy2wt5e0+M91hQYCP4CDNYoW2wNfHBxdxvGVatHOoVfCQ+gMFKUyFX83sUYwO7Zz8
         tUbLZ5A0HIBuD8R202gy1jJb9XrKOcSkfwHeyo9r0q888h/0L7/GOfh/aSAVsiGiJiuf
         Dp8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8TyrBTu3ucgM8yPRl+z0zEPyW70V2xQCkzMjLd9/rNtHL59FNXtJIYs4PY5jF51Ybw5fnjBGJz8SckV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwheoPUHvZEfdKmJmeJs4u1RfD2mHfUE6UFlNpjO4IKmlZTOSF
	rLQZEK+C/ZbsQ5k1fQfsO9UNJ62ON4vUQ7/h+YyMtBL9amZSrs3j5t+lSgxUoaM=
X-Gm-Gg: ASbGncu1RXaj71WbUnRpJvtp9sUvW/wHaA79wLjr/NU0peqt7k5dlfTdsVQKqUD+CvR
	iNSVaUMW1fp5IpOI2ONnGZdxX0YBPYpXjbRJPAAxB7I2r3XoJ2vVCIFeleHuQf+QjW+KJkgflQ4
	EXnSYrcYXf3yW/k0k6iIXJzVvKqhW/A6HixSgRyANCIMXeYV23E9M/zN2HNf8GQBZy4gkCZ7Aud
	z06TYWNT6vGT5XZeatdSmny+e9Qkt0gDxwlMUbRn1hqc4ior7sK7wBaVK2HEpAiGI8RSPEmOJrL
	QmbtaPIAH1fE6kWz3DlYawKN0f8ER5Av8xcZN2ytjY0TTzWtRP1a9iGOgnzPZ6bg9k/ozxZxmnz
	AzRU=
X-Google-Smtp-Source: AGHT+IGTO+rlQYp8L/Ng/3pTy8WwsLZtG1hOzMYWfjy73pYnHQygx5aMKEaDNsFM6tybUcd4gs8WgA==
X-Received: by 2002:a17:906:794f:b0:abf:6b14:6cfb with SMTP id a640c23a62f3a-ac2525e314cmr594597266b.5.1741386315785;
        Fri, 07 Mar 2025 14:25:15 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac239438f9bsm339136066b.11.2025.03.07.14.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:25:15 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/pipe.c: merge if statements with identical conditions
Date: Fri,  7 Mar 2025 23:25:00 +0100
Message-ID: <20250307222500.1117662-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As 'head' is not updated after head+1 is assigned to pipe->head, the
condition being tested here is exactly the same as in the big if
statement just above. Merge the two bodies.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/pipe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 097400cce241..27385e3e5417 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -547,10 +547,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 			if (!iov_iter_count(from))
 				break;
-		}
-
-		if (!pipe_full(head, pipe->tail, pipe->max_usage))
 			continue;
+		}
 
 		/* Wait for buffer space to become available. */
 		if ((filp->f_flags & O_NONBLOCK) ||
-- 
2.48.1


