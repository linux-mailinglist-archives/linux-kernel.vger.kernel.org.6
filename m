Return-Path: <linux-kernel+bounces-337150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0AD9845FA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC281C227EB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5901A76D2;
	Tue, 24 Sep 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWm+oua/"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068F1A76D8
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181149; cv=none; b=fPCb+ZSeYaaFTgz9ceNnPKA6NMNy8vWeOt/DF9RiLbPynd/gA1UVzWXevNOuKWGbO02YLnNHWOgejd7ukPf1pIS3r1oA1n3ozEW3Ll5r3fKmgxpyPUSqGbCqhlf7r0B1Q7+sdAyIbMtJxBM5rnsXo/6cebogb8xgDM9EiIix9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181149; c=relaxed/simple;
	bh=zSEaBEiz0fDT3KRybsgEQnZ7x7PikIZPSwGuq4v+J3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TuO78k6AS8y+XR8YvQGrSxpuHYxs8Xzc4YZ05QXKjnLysBLzMTFJOFxjMOA6JpiQ/zHgCmEwveo5pHVRYjDtqLvrFke0WaS2BVtSb3gpQ1CyAOo853sRc7LeHqa2bJpQNi3izzyVez0e9zdbf2hJ1ALODNnc3ZVHEvIMoKedAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWm+oua/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so2646578a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727181147; x=1727785947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Gpe5z9CsTim9CBbaab66JvpHBddFQKLsRD0FtJ3vuQ=;
        b=iWm+oua/rC8Vh1R6DOmVOMFckSRvKtJYlN4OersDA6UsarffuICaRjFk1QtLjYSkxm
         oELSoeyoQ48v7LMWzEym1Y2HRhtGn82A++yJf+k7R/kyDXRAximGTvb5CA0Gd6+k1MYN
         OqfdbpbmLIArDPrSAq09cMEtg0vQgICyBwo5RRJzfY9QiepZoU8CnFgo2rG0X8uUNbii
         NnGbibeSqta6dlalWJjCbmuEuwT5BRdxzk/G/C5AFSdHpKNIAkgIM2dXr2YE39D7ZTzc
         8k8r5gveaEg1QH+e8Ae1YVdlqSLeYz/zdptH9Ap0wNjAolvfu9uaXuHRMS1n/8awK7++
         kU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727181147; x=1727785947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Gpe5z9CsTim9CBbaab66JvpHBddFQKLsRD0FtJ3vuQ=;
        b=FhjdWUpIUjNwu5PxFNBPeoEpIlQdoS/yBYO/Gf0I8zUAHedCGZYRCl/eLMBMxjWCng
         XCv0zKFZ5HAfzHK6E3F5Mbi4x4VkI0ZVjIMwCJ4i+rSCgpJCxQfgpUa+yeKXHhDViqnm
         V0xkSWsW+52W4C04vXg9R8AlzaL+4OlugnI12v9H4vWUXFUlys21+9jcf6scwpFvRhr9
         iaQAzFlpvL8VO33/sV4DVorTmMEgFYgS0fyrOdJr2KWCxUZxX4EjhbYCDXvMibkdV+Gh
         oqslNqDeCdb2WMRy94bN4dAINnBE249xbUkJs+KbzrFZNKUd5K32DF90cWnF1BGL36sw
         MHMg==
X-Forwarded-Encrypted: i=1; AJvYcCWuolieSVD9WaFYHUQGNeHuBC8KwP1aLMBEoYn1Cp6DbqhKs19P0rX5tUdiJyC5JX8qYFz7plmoCT7yW8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqCjReQJQXrGVQmezHG23gs3ASPRxjpstrL+Os9FAN+ZGolrK
	XxbqtzlJ4/bMl8JMgZKP8vXqMsZyR5C48ZlH4v35+n54IANqNP5R4YUMOGnI
X-Google-Smtp-Source: AGHT+IE1daw3BjAOW6AcSIHY1AWEajlz/uHZbI/qA8szYL3+6yJxj31Lnankac1edCz/KQKQolAgqg==
X-Received: by 2002:a05:6a20:e188:b0:1cc:d9dc:5637 with SMTP id adf61e73a8af0-1d343df87f1mr4609820637.23.1727181147175;
        Tue, 24 Sep 2024 05:32:27 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c5ad4sm1115566b3a.188.2024.09.24.05.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:32:26 -0700 (PDT)
From: Zhang Boyang <zhangboyang.id@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH 1/5] rslib: Fix incorrect documentation of rs_modnn()
Date: Tue, 24 Sep 2024 20:31:37 +0800
Message-Id: <20240924123141.16962-2-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240924123141.16962-1-zhangboyang.id@gmail.com>
References: <20240924123141.16962-1-zhangboyang.id@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous documentation of rs_modnn() states simple arithmetic modulo
return a wrong result for values >= (3 * rs->nn). However, that is not
true. The rs_modnn() does the exactly same job as (x % rs->nn). This can
be proved from following loop invariants:

  while (x >= rs->nn) {
    x -= rs->nn; // (1)
    x = (x >> rs->mm) + (x & rs->nn); // (2)
  }

Let x0 denote the value of x before assignment. At (1), it is obvious
that x % nn == x0 % nn. At (2), because nn == ((1 << mm) - 1), we have

  x0 % nn == x0 % nn
  x0 % nn == (((x0 >> mm) << mm) + (x0 & nn)) % nn
  x0 % nn == ((x0 >> mm) * (nn + 1) + (x0 & nn)) % nn
  x0 % nn == ((x0 >> mm) * ((nn + 1) % nn) + (x0 & nn)) % nn
  x0 % nn == ((x0 >> mm) * 1 + (x0 & nn)) % nn   // let's assume nn > 1
  x0 % nn == ((x0 >> mm) + (x0 & nn)) % nn
  x0 % nn == x % nn

When the loop exits, it is obvious that 0 <= x < nn, so the return value
must equal to (x % rs->nn).

This patch also fixes the kernel-doc style of rs_modnn().

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index a04dacbdc8ae..f76e0fc097a4 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -106,7 +106,8 @@ struct rs_control *init_rs_non_canonical(int symsize, int (*func)(int),
 /* Release a rs control structure */
 void free_rs(struct rs_control *rs);
 
-/** modulo replacement for galois field arithmetics
+/**
+ * rs_modnn() - Modulo replacement for galois field arithmetics
  *
  *  @rs:	Pointer to the RS codec
  *  @x:		the value to reduce
@@ -115,8 +116,7 @@ void free_rs(struct rs_control *rs);
  *  rs->mm = number of bits per symbol
  *  rs->nn = (2^rs->mm) - 1
  *
- *  Simple arithmetic modulo would return a wrong result for values
- *  >= 3 * rs->nn
+ *  Calculate (x % rs->nn), without using a div instruction
 */
 static inline int rs_modnn(struct rs_codec *rs, int x)
 {
-- 
2.30.2


