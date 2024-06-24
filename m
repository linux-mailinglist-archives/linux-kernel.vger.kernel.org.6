Return-Path: <linux-kernel+bounces-227524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1D9152A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BAAB241B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4D19CD14;
	Mon, 24 Jun 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPssf/AW"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1C1DFEF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243595; cv=none; b=Ui45FrbfShQItVCjOTZm0GTEu6LYBpZCSmaQbsMZ2hFxy5LcXWZxmVL4U5gMzxH4t2FvO1U8/b8zkgkHuWqXQYMPPs20ZO5DznweV89Ea4P54/CeSV6ZC4rNFNewOZVSHvmt4IgN4eHFRrsokKRJCBrGJ4U8xW4qfovNCi8tuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243595; c=relaxed/simple;
	bh=PNhh5ehsMxF2LOxMh76qrqxwBtMJjXPCOf+gr4CXx5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G48Pq20coQ3Unk945TT96M8jScB16ccnMQmcqD4aZ4+66dXiINmqqkhIXjvRUi+9MxC6s6dbOz82VvalxfTrpmoBmBM4xvCecxm5fW0jvXn8MIbymE6JOS6w2L+e+GTJJ6aJsdnTLOw7VBlXO6bG8KohXrU8H0HAej/1bslLfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPssf/AW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d2fc03740so2984515a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719243592; x=1719848392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Um90VWkbcYelt0C5CIOgh4uaZxeFwHm3wXcemS5Cnc=;
        b=EPssf/AWICgZewzshC5DQ4/6Ztx/4t/E+G0AMxsp4Igl5oUjl87lRwGL2TtWAiqQ72
         l6Ny9FqT55BzXvOO0zSG8QGesP3YdKffCO59H9/12fSccGr7ps9BfsnP4wm7ooIKY87k
         //oZRe1E6fuxYfy3uoYsFvFWNDSHZR9IlwdNfgj7qlXkkNpayLQMp6JCe01gBx7IHWMu
         b1758Z0bXaimvLgd66SXfvCgWzYviWPTMFkd6gQOcMgSDuY1l/lDPjVDRQxfOZi8U6/e
         JV54GumUJbj221YIQzBwHUkg54v0l3wg8sABIyVUffjw5ku+TbtuyNOqYR+NSuaBatPq
         xRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243592; x=1719848392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Um90VWkbcYelt0C5CIOgh4uaZxeFwHm3wXcemS5Cnc=;
        b=ZZLFtwkHkMQqyFQoT1foIgdbqNg8uoDQYTjOVWerEtk3kqY0CltM5MX/lPvw39LG/6
         zIgtcaMM29vbeNS1Ou+A1QSk2pVgcGjkrN+vOqkxePSS2IZUmvu8VorKUUJ9ql/1ZCIf
         EdTjdIBAFsQusIpZF9hUrWrgMM+q9MjpwlQnOussaROwg9qyaDZbHvEbLpqNZ09B/YcE
         QEOSbRBgerftqLY8bCiHVItM9UaReluN+TwuIQiN1qIwJ65epKW/sJIX0XMn5BGpjOkO
         nXp6iUVjOuLEQFOXgSgqhas2R2UNaWx/ViASYRRO/NFq7Qi+VOcZk3f0EgnvzSVFVzag
         kw4w==
X-Forwarded-Encrypted: i=1; AJvYcCUmlOJTMkaekn+wzR2JYU+gsUIiaiWLvrbp56GYfiOe2cAfcP919hk+jjz9jYUubD2XL/OlaY/LwQA8BYLm2wqER/C6vOsAknqsD0OU
X-Gm-Message-State: AOJu0YxDLfoxPZc6FgHn6sN6LFPOmcbf21yNZuREv3gxKoDfT4eOxnZu
	QJRummC3r7/R9WB3x3hLwmJkme2ngy6kzmfAy+BZzhO1GaXx0KI=
X-Google-Smtp-Source: AGHT+IFvKzGBJX1pKjaSk7oNGX6fNPxoxee171EiYefvjdTeRvVQ4cKjihF96kUKxxFjm1p6T08W6w==
X-Received: by 2002:a17:906:7746:b0:a6f:3210:ac1d with SMTP id a640c23a62f3a-a7245df6125mr288419266b.63.1719243591813;
        Mon, 24 Jun 2024 08:39:51 -0700 (PDT)
Received: from p183 ([46.53.250.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72488b3270sm203301066b.140.2024.06.24.08.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:39:51 -0700 (PDT)
Date: Mon, 24 Jun 2024 18:39:49 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v2] compiler.h: simplify data_race() macro
Message-ID: <fb62163f-ba21-4661-be5b-bb5124abc87d@p183>
References: <f214f15e-4a0a-4f24-9bd7-8f84cbc12e5a@p183>
 <CANpmjNO=zv6D807cNLAQ3eGLrigUs9xtYNxoHhyuYvHkhhSUWg@mail.gmail.com>
 <2aab04d1-c16b-44e4-a283-7bbf8cba28e7@p183>
 <CANpmjNMZU=T6J5OBpELxB=ZqOnrkou2iRG7zaqoNy7bCGgH9hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNMZU=T6J5OBpELxB=ZqOnrkou2iRG7zaqoNy7bCGgH9hA@mail.gmail.com>

-Wdeclaration-after-statement used since forever required statement
expressions to inject __kcsan_disable_current(), __kcsan_enable_current()
to mark data race. Now that it is gone, make macro expansion simpler.

__unqual_scalar_typeof() is wordy macro by itself.
"expr" is expanded twice.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/compiler.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -200,10 +200,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  */
 #define data_race(expr)							\
 ({									\
-	__unqual_scalar_typeof(({ expr; })) __v = ({			\
-		__kcsan_disable_current();				\
-		expr;							\
-	});								\
+	__kcsan_disable_current();					\
+	__auto_type __v = (expr);					\
 	__kcsan_enable_current();					\
 	__v;								\
 })

