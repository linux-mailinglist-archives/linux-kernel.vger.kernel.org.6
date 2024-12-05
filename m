Return-Path: <linux-kernel+bounces-433203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC089E5515
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58523164CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FF7217710;
	Thu,  5 Dec 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OPtka1xb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA7217718
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400650; cv=none; b=EovrZQ1/MBtbTIxJJzhV+qulblYxDhZjja6cUYsPcfzTqXGnmbTMoKKmkHvTz112QKW2Wl8rNHGrBB7YAcHGup92tPETaYrABX5xLb+32C9TdYp41imMYuqfdpGnz8OnkR7uwN2lY1IvEaEWsspVyxyUsaCc/ZCCaHqA2egVTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400650; c=relaxed/simple;
	bh=2EZLrM0ZLYYdbPxLmXbwElTcSDaUUFW0yoyYRrkj0Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOBKn1/evq8vJ1d0KGu5rXlQ6eAerK3nZ032NNlHmtaxRoY/MJL3Ut5ygiUmkNVWxinIc+MvP6pTP7GGfgAhjRQySVJcRyhg1a5703wwsfcJw4jUYJvgTUDbmqQs8Htv+3ZBhqDBn+tSuUPkRQBI/kQRoJuqpPN/T5HCvDDu9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OPtka1xb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so8941245e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733400647; x=1734005447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt/CPBcS57R6kXLbkiRsszi+u13mNakGJLbglDYv4Qs=;
        b=OPtka1xbNSnLHImw/SXzmr+vThp69HlpLao6h8MAYbHaOsNc6dq0iCM+OMrR138uow
         HzqgCk8UDWKG/7KMWHtKMRJ1S8HiPD6x6uoC1Rmvy/PUrHCVRs0fINP0P0XPL4T0X9zq
         sDqPl2wN8D8rbTjt2txODLTHVW+k4IH6LjpBzCO3LdAdLdqYYCV5JW7AQ1knwZlG5WOu
         dBn+vF4/HHQHrAv05x1saKN9LvoMx2qAxI+wpacl/cqBstKNwf1+1vociSfl4oynozH6
         vD65XvWtgXMjVyR48tMMWawjtM5vsYkjZp3g+3hcrRgYwJZwHYGb5g0n/vYIavyAWYRQ
         8wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400647; x=1734005447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qt/CPBcS57R6kXLbkiRsszi+u13mNakGJLbglDYv4Qs=;
        b=TI0HobYj37hi1sxWRqFqYLrwPXlX6WtikMaG3TAvxBZvNRtMpu4V7yj/lhWDweTtKV
         dW451DxfotM1USEkFzqO2q2g3gyCEYQPqoM4ZDYBeKEI1cqv0Z8R6/gP8GkQg8Pc5Mib
         pNl9PyaDpFrpoIM80y4GfomVHffixe1moXKLq52q+97iukZ1LGmVVUGxxFWH7MlOEr+f
         kHXqMKy7AEKCvvYWfm3J8Lsy9CxrODgYrYflPC0zeBElgl0QtdFKyUlk1qezi6n2xA3E
         VnxomK0Mb/uvbEYDuePCO9Kv+B1vzwDubFSAtbEOIzjv1CV446QlE3c0gCnZKSwaWSOB
         qdLA==
X-Forwarded-Encrypted: i=1; AJvYcCVXbUo9gfxf0wQ1ak/spw9ch5KM5hb4aQFFFXA+KTioy7bQxXfTk28kKUBXFyd+mZ/6IfaPNoD3oH1cTy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+E3MwjdepWLAUrNZrKwxLc4TNFa0VGcyFIIHqifvpMLdqEyS
	fMRZ7GKNz1y9RJUAn0WvkOw/G0+7i+2/gXnBCLn48+Q/dpDQXNABMJkbUOiRP6s=
X-Gm-Gg: ASbGncvFUjrr4H0pNzorV/WRp/hq3zcrw0JBGI7T4FDVTjdFrKS6QQVYr1DSCdlDhtW
	LZ6GfVXfEjtUyLNf23/OBFZerYlj1c63kwD7uLTWj3NfGcnqtlw0QczsUCbb/xx13aYGXXww+9x
	Nl19YvlIEMZtyru1A4Ap8HC+BgkL/ULkkAA4Aq6JKPJ10mtfMAcBycyE/c+mg0CdSB3Py6adWWs
	PjwJCtkqtMxrFhis0AzpeKvYRK5GaiUN2O/zH38d9XlDjuu
X-Google-Smtp-Source: AGHT+IFfZ50+YagInJgFWXUcpmHfKY6JBPuy+JFDnVOzAD63Uh2CX35OZkA94Lrmw5g1ER5Pu8VJOQ==
X-Received: by 2002:a05:600c:3c9b:b0:434:a706:c0f0 with SMTP id 5b1f17b1804b1-434d09b5fbdmr91829905e9.14.1733400647235;
        Thu, 05 Dec 2024 04:10:47 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:c2c8:33f:e860])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0980ddsm22089655e9.0.2024.12.05.04.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:10:46 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Wentong Wu <wentong.wu@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Haoyu Li <lihaoyu499@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drivers: gpio: gpio-ljca: Initialize num before accessing item in ljca_gpio_config
Date: Thu,  5 Dec 2024 13:10:45 +0100
Message-ID: <173340064220.41307.8479220444337077350.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203141451.342316-1-lihaoyu499@gmail.com>
References: <20241203141451.342316-1-lihaoyu499@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 03 Dec 2024 22:14:51 +0800, Haoyu Li wrote:
> With the new __counted_by annocation in ljca_gpio_packet, the "num"
> struct member must be set before accessing the "item" array. Failing to
> do so will trigger a runtime warning when enabling CONFIG_UBSAN_BOUNDS
> and CONFIG_FORTIFY_SOURCE.
> 
> Fixes: 1034cc423f1b ("gpio: update Intel LJCA USB GPIO driver")
> 
> [...]

Applied, thanks!

[1/1] drivers: gpio: gpio-ljca: Initialize num before accessing item in ljca_gpio_config
      commit: 963deccd17d4e538a8bafb1617803746efe910ef

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

