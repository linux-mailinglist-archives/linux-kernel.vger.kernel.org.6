Return-Path: <linux-kernel+bounces-185152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 247EB8CB13A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4BECB22462
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1461442E3;
	Tue, 21 May 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Zdbx9h1Y"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC061448DA
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305205; cv=none; b=JcM5jPcUF6IyTTatq4s1jOGLsflnRdgnGHHpO9N0JR0mlu9Te/cEOvh39aGbKqxSDNQ42+72gZI+xdHLphnszYvvOJ6XCus2wmZC2KZkK3nf+4IJyQcChuYjQUuwCLmc2ra5BvQCoYcgPsmGhwqRUP3hgPvFtjEhMl0HuFpMeQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305205; c=relaxed/simple;
	bh=aiHtBVIcUBQAnB5Q2EBmNg8ODIWt4KSjAsZp4MaE7bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIRCs3uia/gaRyWWwJ5zqPmJ0MvJNf3eJWKJJAe0oZq/eHgIzWbf1Zs9BeOGg3/Ow1puX0675W8bfts2XyEgn+9kcsJ1CL/fPKFAPOjFBMg8gjAmEU5xIN3TW14rjcZFMzGLedM6nvVOAAjUXOypTO/qSuVjxV7z2joSnT7sIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Zdbx9h1Y; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5ce2f0deffso553855566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1716305202; x=1716910002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjFz7A85flN3TvntQYJ6kQFqr3/C0cpeamTEx2vLXLU=;
        b=Zdbx9h1Y1VzFBHgpKkn0VUrx0LM9HC/BZnvkVkosPwf07A70+JXWaV9PtzKWGXvBb/
         wCUsmOg0bvA9G6ia8l3I3I++UI+TYEK99UVEBAnCD7K012yPC91Ji7FHjXNNaf7Ro4FU
         At/c2fEf6EEGrrbD6pquSn8OUSSEG2pSGUtXaw6Sefa2AnhyY9u2tL6/tPweLuE7zGML
         iptl+wIW3HB4pVXb/6vSEPrnc96l7eK2isZHDodpUw+gKdvcDpLqnoxXeY/997x7IxWD
         8zorYdOsSDrE1UqX6W0yXpu4Dqz4iM1ixpEYFNsNbY823BcMJ2V4Sycsgjf5qBm6hDa8
         JKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305202; x=1716910002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjFz7A85flN3TvntQYJ6kQFqr3/C0cpeamTEx2vLXLU=;
        b=sxFq3RKdvnQ2/wK9sj/eXYW6A5aTE9VNADFnX9QAZO4EfXSwAtREluTLrHNobxnxHV
         xhVykVvEE11A0qLOwsG3vYlOlpnzp2Lqp35RsGuG+z2qJ348ju5CSr8EbD6WABQsFlWw
         iQ8So3jARM/oFjmACyJ238GOj7+ymdYyD0JzyO4TdbO0Eq/8piBTvkVaVh4aE0MrtO1C
         ww5KmD6K4IKttJl2nsXVzVvvlurJ169/YQCmm20VB8or4m6YTMvmhdF1CXVOhxkGaIo8
         cLemEuhor+sJLhSJNwBYFbkKLI7AcwY9fzmwJM0gRiwucziMhqdT5SAL8jzz4G8CUJ6F
         EnoA==
X-Forwarded-Encrypted: i=1; AJvYcCVGAHuj4rLitSsVRogHlZQGg46P93Zqg3PEcC2G/7w3NIi32PNd1B2IEhTcLkSq2dTiZp6dzH+qQ1Ctbslz9qcSflzTy+Np6+bcDbay
X-Gm-Message-State: AOJu0YyLqkXx1sCOos5lyJVESC8HL04W0/zqnu1rB/6+zmTIgHXxkBTr
	3jPm/HZ1PqN9jU9bheBi8HZBeJ/gjQ3wmVwBQbv4Dsu/wFHhVEI5/xGvI4YcbWo=
X-Google-Smtp-Source: AGHT+IH9GEyPJ76wtwNB4/jHWZs7niX/sYQbANa7CsmlIy9vKqofJGQiIZsdI4gRpsE8eF4yskDYXw==
X-Received: by 2002:a17:907:845:b0:a59:b376:87b3 with SMTP id a640c23a62f3a-a5a2d6657e1mr2483206366b.62.1716305202032;
        Tue, 21 May 2024 08:26:42 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b180c7sm1638327666b.221.2024.05.21.08.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:26:41 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: naresh.solanki@9elements.com,
	andy.shevchenko@gmail.com,
	broonie@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pinctrl: cy8c95x0: Use REGCACHE_MAPLE
Date: Tue, 21 May 2024 17:25:59 +0200
Message-ID: <20240521152602.1097764-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240521152602.1097764-1-patrick.rudolph@9elements.com>
References: <20240521152602.1097764-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use REGCACHE_MAPLE instead of REGCACHE_FLAT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 9570de598193..4efb8b5cc2d3 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -457,7 +457,7 @@ static const struct regmap_config cy8c9520_i2c_regmap = {
 	.volatile_reg = cy8c95x0_volatile_register,
 	.precious_reg = cy8c95x0_precious_register,
 
-	.cache_type = REGCACHE_FLAT,
+	.cache_type = REGCACHE_MAPLE,
 	.ranges	= NULL,			/* Updated at runtime */
 	.num_ranges = 1,
 	.max_register = 0,		/* Updated at runtime */
-- 
2.44.0


