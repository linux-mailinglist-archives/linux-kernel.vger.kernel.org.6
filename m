Return-Path: <linux-kernel+bounces-368102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024679A0B37
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A054D1F269FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E8208204;
	Wed, 16 Oct 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxKntXep"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92C1E531;
	Wed, 16 Oct 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084696; cv=none; b=Sxu9l9rQnanMP+XSOo/+TL6frxPTdbvqA6JvrhCsuyL/QPkaZQOUwRQ+bs3RCZa29HKuNBYFRf6hISX3QLzCnLRsvkqsmLPUrXAvIlcvMtm9jF5ehUojbSqw8+DKFGs9Dn2h6dD4Y0b3iOwHIt5SkKmK0uNCCFPyKHHKOM+MwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084696; c=relaxed/simple;
	bh=k5jHVU5o1XkCwlhhkfpdMmMdfMfX5fqRpC8pZhrWBks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aa59qkgfsbQLCOtR+MYMVXAs8dVlUpm1Uf332Ie1mf8vLYFStvGnsYvBb0Hg/JlnrkVngUmHnmDNkZdx9I1zfTsbNxMs8u4zqk+9JJwdh9xHX9tb1y+BFA624eL5lGdFCv9goglBMXm1+d00yI4Tzc+1zeV5L02yF67m7dJQzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxKntXep; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431195c3538so47321535e9.3;
        Wed, 16 Oct 2024 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729084694; x=1729689494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp8mlzCFerHZwOQsdYQzAEyYccT5PlBtmx7TKcs3NbQ=;
        b=dxKntXep6Otl4T0n3DRgpAUXt+xudMkoH5Exn7J+cSKLRE0APyc4SWbAhnuhCtoVEr
         5894TT9Rjwcp4riPlpvH8VP7JMLgdEDzQbmSl6dHBdesk7HEESNGecWA+j7atu+9PWwf
         zMReRHoyLnJM3UDDMpzqvrnvb2ZHYZd1fBRPlihwLxhPjpvcmwple0Q2HTM0+8IOGtUZ
         gwemrDUzCsALo9+DQfOiDqyT3tKDsmUFU/7+gVEKzA9Qt0UPFP345wDP3FnXhRoBreP+
         XFEG6EYXUoirs6tYT9yGTPXMNSQOehDs7SV5almmuokZ9p6TcCG6f3CNHFBDuqrJWmD6
         4k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084694; x=1729689494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp8mlzCFerHZwOQsdYQzAEyYccT5PlBtmx7TKcs3NbQ=;
        b=MJYRh3gl11FrQUHw/PItGOzl1q+9gQbB7TFLLimodfNNeZYRCjmuuXOjGS5Rkz/Ikf
         7mxGqh6h4kgNu4Kr9RcUMO6PMKvyT30AqVe/7w1dW9+40r8+be7ollJ/sn8kSh2mAeFQ
         ulbST/aiw+h00pvv63uV8WaXFOFRALqV5pPfl5t5IS0x563TTeHOxZBSjFyNlrT1T992
         fZgBn8iKqSoQlmqNBBBljkf7ckN2508LDjmnsLMPhdWBdlsZUdumnqTqs5QeRq3dpQHB
         PhTHxQgg1KrILn2+gbynUgV87p8/UUb0lt/Kwx11Wn2AD5pNctwdlj8XWuUZfmQXnXC7
         ZVGw==
X-Forwarded-Encrypted: i=1; AJvYcCVr62KzCukePw2vL//h/CIYeil8BPuBzDcVT7BbqNS86k+2r8lKVaCteCCaU7MOmg9pFHLH793nNhsVVFPY@vger.kernel.org, AJvYcCWbBSrnWJK4IrHiNvAgTk2I92sDCB0TxZ3mHBEPoKohQlBt6q5R7ZoCoH4IMHKK4S5RzfmaNypZFbQ=@vger.kernel.org, AJvYcCXJ3exfttWqifJrcPMT5kIbU9Xaav+pyBM3dzmvkUyzk9ji+B1kl2ciB3+zT8TlXiTynKsfV5aL5Eb+@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzMG/+ABUF6QM/r48vdjbj+0yb25RUO2HGW0w/Bh0UHSmN9YQ
	uBX5gdfQdDcU0G3AFV1Ov1PVntIASzQRj4rmROMC5S7zGzRewFMh
X-Google-Smtp-Source: AGHT+IEPh2uD/e424mZy3TzaSgh1zMe8F8B2stIBFMZzi9dKTninoOvYVP/vLIQdZEOFtDvCeX2T8g==
X-Received: by 2002:a05:600c:4514:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-4314a362525mr29799615e9.28.1729084693271;
        Wed, 16 Oct 2024 06:18:13 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f5698aesm49612825e9.11.2024.10.16.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:18:12 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: 2023002089@link.tyut.edu.cn,
	akpm@linux-foundation.org,
	alexs@kernel.org,
	corbet@lwn.net,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	siyanteng@loongson.cn,
	snovitoll@gmail.com,
	vincenzo.frascino@arm.com,
	workflows@vger.kernel.org
Subject: [PATCH v4 1/3] kasan: move checks to do_strncpy_from_user
Date: Wed, 16 Oct 2024 18:18:00 +0500
Message-Id: <20241016131802.3115788-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016131802.3115788-1-snovitoll@gmail.com>
References: <CA+fCnZf8YRH=gkmwU8enMLnGi7hHfVP4DSE2TLrmmVsHT10wRQ@mail.gmail.com>
 <20241016131802.3115788-1-snovitoll@gmail.com>
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
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 lib/strncpy_from_user.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 989a12a6787..6dc234913dd 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -120,6 +120,9 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	kasan_check_write(dst, count);
+	check_object_size(dst, count, false);
+
 	if (can_do_masked_user_access()) {
 		long retval;
 
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


