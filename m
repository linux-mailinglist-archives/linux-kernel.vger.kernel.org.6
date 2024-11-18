Return-Path: <linux-kernel+bounces-412468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBDA9D095B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D371F21E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C614A09F;
	Mon, 18 Nov 2024 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0H5eX/q"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F313D24E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910175; cv=none; b=N60Nlbqniu5o+jzULJWg1S3ZH/HoZxRs8BjAMpUvf0KZgjWv/UWAGvIGF+22BS56EtTuU1qqZfIItsXJlBaO4VrFRXYDgvGCC6lwb/FXlQrfZVXLNwWNAHh2AsZf10iGvRA3StKWA5yzzgBQ/MgbKmTFLdb8OqvvhrsVfnPF7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910175; c=relaxed/simple;
	bh=MYcA1SYZL5eECQEt5Blz/24x/o2zDNEKaLVbv9fsM/M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LbUovXjRyZ47hevdmjZ/zKMfcPoyA0oWsVTaBV2t0hJ76qbq+h2QVTwKiZpHPK5ASHbmedNKkyinobiSgheGBvjq5LtyChQRYhKN9DkNZ6wUlQoOQrI4DhkzVabM+6cmXp6XV5RWT2WC3mhJ3RZR8cIX1soZ0ZRabB69ihnkgoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0H5eX/q; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53da2140769so1424118e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 22:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731910172; x=1732514972; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGNA6sx5LHgcCMlgC1W32r3d4tE2U1BHHSY/+BLBKZw=;
        b=G0H5eX/qXMlKMCaDoGTIR93N14HgXeaFvTpHGw1o8jSXfvI3zY0JaKqmGtXn7Jonth
         owkqo6EkDktekZNhHzSJukROtx+SGfaD7Zr17GHFeYW82CX8h4w+7eAZuBNIsLpFpbxd
         IisbNv188QbdxFcAF8ahHY9RNc78wSZLoCzjG5ywWLoo+fSSbufEna6r6Lp7IXjXbXHk
         Muy81sSa4gM7hYQEHm6s+5yXfnByij3cRMfUf7Xd0hSzUup9CEnIEPH7MypJFP/HIakN
         a9x3Dzin46aZyTH1vA3K2dzHVQ1syrGjNBxIlNZMGBmjbLl70j9R8K2UfAfqFu+kmLWR
         r4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731910172; x=1732514972;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGNA6sx5LHgcCMlgC1W32r3d4tE2U1BHHSY/+BLBKZw=;
        b=VLIoLzM6MzeUsoO+vBTejbHK/mlaESdqoefhpvkx+WevX30HS/dEgQjU1TxWlnYCKp
         vHFOOJf4/mnGXOwMIjSzriAGQZfI16zmN10MUtjPKIa8FN+C7trHuBrSh0INcaqq+pXP
         JONAeTavKg8vsWB1kAIXbegqT3o7AsOMshDxwhSe4r6cswN7PlSOAZUdMwD4GyeLJiYT
         Hmcmj16HWDXEYO8GytjUIaROzvbq0rlTxUnoxM8xbkoTF+P5K+TEzqCoyYyBfOo2t+Rt
         YnDGr0xilk9+BK2YMQN4LOonizWXK708UwDmZIfRjpP5ztKX/WrTvCbG/uwp+NmdvUJv
         IM4g==
X-Forwarded-Encrypted: i=1; AJvYcCULRaKo0jJY6KGlHcnMuZDj/EbQDnU/y3uHlMxj09fnAlyno5sqDBd3NGctnEug1KMW3znzCHOKh0ku5GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynuaddIStSiq5ssQfkadLqiO/69jZkejOtpohBko/K5l5wRnI7
	LiehhV2jLOZjbCYlvKnG/JSsg5oUtU391vOmuMcAbLRh/jD2HkiAeG5jDgOliVo=
X-Google-Smtp-Source: AGHT+IG8+xEQp0aLf6lrQpiL2Ytg5PnQnbX2T1yiNEt0PqVgi/U6NwJqxM86obfWK6ZPpQ4c/Z5APA==
X-Received: by 2002:a05:6512:3a84:b0:53d:a927:8206 with SMTP id 2adb3069b0e04-53dab29ad8dmr3537156e87.20.1731910171992;
        Sun, 17 Nov 2024 22:09:31 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432daafc6b3sm144771705e9.0.2024.11.17.22.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 22:09:31 -0800 (PST)
Date: Mon, 18 Nov 2024 09:09:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] overflow: improve size_add/mul for 32bit systems
Message-ID: <ebdae636-11f3-4f02-a158-f15bbed2847f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

On 32bit systems, if you pass a long long to size_add()/mul() the top
32 bits are truncated away so the function doesn't work as expected.
Add a test to prevent this.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/linux/overflow.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 0c7e3dcfe867..e90cd5245497 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -263,7 +263,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * with any overflow causing the return value to be SIZE_MAX. The
  * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
+static inline size_t __must_check __size_mul(size_t factor1, size_t factor2)
 {
 	size_t bytes;
 
@@ -273,6 +273,18 @@ static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
 	return bytes;
 }
 
+#define size_mul(a, b) ({						\
+	typeof(a) __a = (a);						\
+	typeof(b) __b = (b);						\
+	unsigned long __res;						\
+	if (UINT_MAX == SIZE_MAX &&					\
+	    (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))		\
+		__res = ULONG_MAX;					\
+	else								\
+		__res = __size_mul(__a, __b);				\
+	__res;								\
+})
+
 /**
  * size_add() - Calculate size_t addition with saturation at SIZE_MAX
  * @addend1: first addend
@@ -282,7 +294,7 @@ static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
  * with any overflow causing the return value to be SIZE_MAX. The
  * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline size_t __must_check size_add(size_t addend1, size_t addend2)
+static inline size_t __must_check __size_add(size_t addend1, size_t addend2)
 {
 	size_t bytes;
 
@@ -292,6 +304,18 @@ static inline size_t __must_check size_add(size_t addend1, size_t addend2)
 	return bytes;
 }
 
+#define size_add(a, b) ({						\
+	typeof(a) __a = (a);						\
+	typeof(b) __b = (b);						\
+	unsigned long __res;						\
+	if (UINT_MAX == SIZE_MAX &&					\
+	    (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))		\
+		__res = ULONG_MAX;					\
+	else								\
+		__res = __size_add(__a, __b);				\
+	__res;								\
+})
+
 /**
  * size_sub() - Calculate size_t subtraction with saturation at SIZE_MAX
  * @minuend: value to subtract from
-- 
2.45.2


