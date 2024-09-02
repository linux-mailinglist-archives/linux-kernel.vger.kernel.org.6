Return-Path: <linux-kernel+bounces-311075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1308968496
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1E21F22B85
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE5C13D8B2;
	Mon,  2 Sep 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="P5iw3VaB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19313D52F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272660; cv=none; b=ZITAOJ+eBpSCMBq31RTncKdYWeoHGyJvLf63zbqBx7UyRRE8SseGqfKv7RuRq8SAD2Op6iG+H8Pq9fpWLbr+LajU4ygJpI4iFhKBLhJeeAL/BQ/rbswewIW4aZu9GVrsQ1lixEeuvMlXRHRJLueAymjcBdpftZdJmdDorRrnUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272660; c=relaxed/simple;
	bh=gXW5IGW0IPozlyICvSYuGNANAfh1ljoZfqxGc3+VBBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTJrdlhvDePHT0ErZ/HOE29qHQjGCKhBaIo+8nNurnRi5ZwbAy7c0+FRaFstp4ih04cNCDlkqYcfm/aq/46lK1/YWte1WTy2t9qGexxrnGoyZRfRgea5+X4rOCh64FSZzLrJ0T+Huxf6yNn8hh5ro4LTbq0l/hF9zOKtTP4VZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=P5iw3VaB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bfb50e4e6so17207065e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725272657; x=1725877457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66zc93w6h3Yxyh/dXNjsUBXiL2CdAUkYEm1vEjG0oi0=;
        b=P5iw3VaBvX+c7Y67s6A+3kpW0Fj2tyKZCNddK9vbuj2ANXJsjW5wAWXLwgCf8ZTWso
         ukpf9gaoxS8cukzvE34bLaxwpBenl7ZpUN7j5PUDNBv0vIl8pUTRkMoCz9SqiuQmpqLK
         2d6J27Tljh5zGbDb6uXjT4qEMveCahA0FuyCulJU8O08nRcTIP1HcyGu4RfqjwyGw00e
         T18Z6QUV63DnNU/NutoQbjqKYNkUcfNC/z9a7cvsMBv/qTHHSzCx/a39ljXxZlnFKNnB
         FksJ/z23bjMf7qCOENA1L7EOGTZcete/xmsTxMxQhdJPDhFRB2csEHCGUWqtirVrMtsD
         j4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272657; x=1725877457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66zc93w6h3Yxyh/dXNjsUBXiL2CdAUkYEm1vEjG0oi0=;
        b=pEuzSEQv4rU9FaoT2gzA68Ih4UhIwQfPUc7TdJ95wKyivw9uDDCGTwOyGP5fLWJEpa
         idDHoPYLujc6EwLPqCcoDsKaI/916PkpKePAVOkE+2CnJ/PWzjUdbaXnRVqnyIAC3rgl
         /LBP3xDK3pq4vxpvQxDiudy0fXpD2KG6VBzSyhIqJD457x93qwRNh3SaRjF6r3slGhzK
         j1eUI/e/Km50c0X7tMJFJ376ZnUHvFeTORqzKR2NTjKJFunZ90Yk1GLIQp42d+58g208
         X2UB+gaSvE5xDHs3hSjMm0z0EVV0BJWyfFiKyejSSYo1Ba5+n2F1+l9fuRXXskoOGwl5
         eoag==
X-Forwarded-Encrypted: i=1; AJvYcCVbWH8L7BAUdJ7GDYii8AIBQ1PhtaZXfyp22+v1oPu6WdnKI4+CqA+yIGQSBaNhjgKeRBYgMiQUG1SOeZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7IMSGX2Vashk5oyWa/lHXhQywf35ztWuHrhZbwMVEpc+eByx
	zbsi8+IfhnFG4J34bsTKQ97w1XKiIgaLiMLX9Rh2PYJNbyvOGoxkfLRCQnLUo98=
X-Google-Smtp-Source: AGHT+IHjcnbJW7HwD324OLYv7BK1hmnio6Y0jnOfLHKAowm9udV1mN/yQjceZbV45M94QmC8QP2buQ==
X-Received: by 2002:a5d:47a7:0:b0:371:8a69:18b5 with SMTP id ffacd0b85a97d-3749b58962fmr9605503f8f.44.1725272656686;
        Mon, 02 Sep 2024 03:24:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4981asm11069810f8f.24.2024.09.02.03.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:24:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 1/1] gpiolib: Update the kernel documentation - add Return sections
Date: Mon,  2 Sep 2024 12:24:13 +0200
Message-ID: <172527265102.24810.2842549659164698006.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828164449.2777666-1-andriy.shevchenko@linux.intel.com>
References: <20240828164449.2777666-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 28 Aug 2024 19:41:35 +0300, Andy Shevchenko wrote:
> $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> 67
> 
> Fix these by adding Return sections. While at it, make sure all of
> Return sections use the same style.
> 
> 
> [...]

Applied, thanks!

[1/1] gpiolib: Update the kernel documentation - add Return sections
      commit: b3b12a60eec1415ac68e79e3e6f932772765a897

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

