Return-Path: <linux-kernel+bounces-268313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66287942317
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941931C2162F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83C18E043;
	Tue, 30 Jul 2024 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5Yf2ozl"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B6145A11
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379639; cv=none; b=o51vg0P9EFBAyhfN6vVy5tsR/ptrzCOi6x3KiNpZCVbHIxkijkX6PL2zQQJy8gHfP+9UTVnxZff7T4JJsvf6WhD+WoL3Y0tiE4DGkiZgtFMaXzu1vzuXFmYT0LPJqyUlZbywni687OycdAg+oZq+Q9o6ohmxUW6fMwV/M8ORtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379639; c=relaxed/simple;
	bh=z7Uee3GhNhYk0xKTBz8kHLWwD2DkX1XtMtPpuc3Vjss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUF8oe88oCW7HpXHA/glFYHzd1IKlosNOOZlkiNavqSkQFHHXwAcOjDPms2DiaGXjWE73xXDvSUvGqrw3OZZ6brQg7zi3nV4ckqmRe4/z+YXX5CHhMYEHwO0ID8FqD70Mhx+BO/BUfO+adL5GXXVobgXJKjY0Q73sbMMcZpBFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5Yf2ozl; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-67b709024bfso41693287b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722379637; x=1722984437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15PKFj8shF3ngEYd4PvdNdzLn2bIlUHmbcoq9oTRbEs=;
        b=G5Yf2ozlsJPzOWaFO7P6oCyjW5g05wuBtE6J+lDQ6F8OQIdEaub0VwUP+onF5eJ87d
         HQBdOZgcbtBdgykQdw2EIDjApnulQ68/9EMObRk8xQ19Q3C4PR6tN8SXwxkVH2inmLVI
         4cZFDTw2eDhHxjGzOOFxMo0e6nKS1+Z0rvMhzVc6Q9sGQuEm2J+He/bhcPupWz3E+/R0
         9rMfIvlg3RtaAIt4OOT459jt+wdDzrSTmAC1VTw4uLeF1UAvefAeBNLhQNy0fbF/3N6N
         o7hO0RtWZUY9nEHptzMqOcE5r5QTfGMhVRPy+BWMhWabGSDKzNb0urMaQLFEzcdnSdaW
         oaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379637; x=1722984437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15PKFj8shF3ngEYd4PvdNdzLn2bIlUHmbcoq9oTRbEs=;
        b=fK5Ku9XyLjXEuc4fazC0Tkww1nMvBBRmJPLZ3SRcOh1cPW+W27wPGr+FYSBXUnJXzv
         pTmaf0XIj5w8idyMR7RbBnMSV9cwv9apb0xPOT7zT7Iaum6Alon/sjADVM+O+yNORh2+
         IinvwWuAWS7G/lzJFXEjygPoCohhCm7kzCP5DR+0YfnSVPocSYCn98ni4IUIBtKTceba
         /NCaQvwYrdAT6C4Jzj1rVsvw16K6wnJtCoRfe1ShoIgPaXVmqn8GlbHmqz0sibW4tBpD
         f4AkAk3+1XiGu/7pKN3AwaYKC9dqYDgXBYDpE1RhngxVAyrJTzNY26T+QVxvrVljTNiD
         FcsA==
X-Forwarded-Encrypted: i=1; AJvYcCUPfyaHX2jk3gAw8yIIawoE9hAn7GdkBYqfSrhc4iD+PMwzOAbJT0DMWPnFbjL717MQ9bsZHkt8GUCc/CVvx42OVVuXGgYjVMxarZ9y
X-Gm-Message-State: AOJu0Yy0liGHgY+pyTVpXHeR1+qDaCEuvTejRzA+pE6FLT8m2ICFDeye
	Rhi3DJtyZhvJTrNU6SvwHrwrwdZXEFYOl6fe1VMburpm3+GE/TnE
X-Google-Smtp-Source: AGHT+IFjcTqdoCR13ox+jYM2hdeniYqCSu8uV5/HJmPbYKUh/pGoE3ca/5m2AFwz7N9b/CRVST4QRA==
X-Received: by 2002:a0d:f386:0:b0:61b:df5:7876 with SMTP id 00721157ae682-67a05c8bb3bmr136648857b3.6.1722379636977;
        Tue, 30 Jul 2024 15:47:16 -0700 (PDT)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-683bc9b736asm2669857b3.11.2024.07.30.15.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:47:16 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	flintglass@gmail.com,
	chengming.zhou@linux.dev
Subject: [PATCH v2 1/2] zswap: implement a second chance algorithm for dynamic zswap shrinker (fix)
Date: Tue, 30 Jul 2024 15:47:16 -0700
Message-ID: <20240730224716.2392068-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730222707.2324536-2-nphamcs@gmail.com>
References: <20240730222707.2324536-2-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I put the referenced bit documentation in the wrong order. Fix this.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f4e001c9e7e0..f7f6bbb400c4 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -184,13 +184,13 @@ static struct shrinker *zswap_shrinker;
  * page within zswap.
  *
  * swpentry - associated swap entry, the offset indexes into the red-black tree
+ * length - the length in bytes of the compressed page data.  Needed during
+ *          decompression. For a same value filled page length is 0, and both
+ *          pool and lru are invalid and must be ignored.
  * referenced - true if the entry recently entered the zswap pool. Unset by the
  *              dynamic shrinker. The entry is only reclaimed by the dynamic
  *              shrinker if referenced is unset. See comments in the shrinker
  *              section for context.
- * length - the length in bytes of the compressed page data.  Needed during
- *          decompression. For a same value filled page length is 0, and both
- *          pool and lru are invalid and must be ignored.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
  * value - value of the same-value filled pages which have same content
-- 
2.43.0

