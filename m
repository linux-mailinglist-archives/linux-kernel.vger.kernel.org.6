Return-Path: <linux-kernel+bounces-390526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED469B7AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE8BB259DA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96D19F471;
	Thu, 31 Oct 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dDMAso1R"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CE19F40E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378403; cv=none; b=EdstcvbKrD90wJYSXj3lHgc1zRG/iJtSZRs6zPdjGCi1DS0jygq/ejHxg4RxanSkE6Ur1d1VnYgwvGlXd2iZ/tuDnSTUfgV3uD6X+ajnj6QVuUv4KL+cnhNb75u8wkyNhHccViRWFAuJAOhFRZ03scrCS5XARGsU/x/zvR+ijt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378403; c=relaxed/simple;
	bh=/rku8w+ZQaIMVwtmKD47gNNf1ahswgiaRlMEWV6ZL3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSUp8kCEY+Bi35hiVqu0f6veTMs3/61Uo2+xJQgWpOjppVTJ/NuM7q2ZIzai6hb+3njRf6TUbvtSEA2INnmm+GuAQaaM7HG9AnCQ8ic/qP+VNOxX+0m4kvgSjEnlbqjntEHu2uLMvJoGkY0cVQ9azOPw+lAPo+J5SK8F47OzdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dDMAso1R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315abed18aso7167105e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730378400; x=1730983200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDn/Q9PuaiRUmXk0kNabW3oFFLNcUS+yUJImQy0llLY=;
        b=dDMAso1RstuRXgTQ6aZhMBZjlqHyhY6+3YVT/87vxyEWbZGTEjKf/bH5KKs2HVmzxk
         RNxrZjaTz5t4YEtKOX+KOSqJohro8joV1LCu2L+zJ/Yr7Jw0XjRYqaZfSdu9KbYfkOXC
         8QShbDCfBGYVlHDb7k0HjxsEpmFtJmGCW9me1XdIXWaa7MXpZEohCJPtPmKtZ0HvyP1m
         CBbUpOyRvQed/AltVBh9p0GjwD2ZpMAys1EjRnHNqoW/yh1rVDyz+OlQg/wx869/Hgq8
         wvpI+PVreN/GIXrbOf/ZlD5IRWK4ClLrBz1t8DBjHyVC/gSH63T46Rx3CNc/JX3raiBk
         jaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378400; x=1730983200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDn/Q9PuaiRUmXk0kNabW3oFFLNcUS+yUJImQy0llLY=;
        b=Mwp6S3h3mq6mdvUwEJtVNqD0lLTw/7jVNb8TphzkK7SGETPIIfLIr+ZKZbcMmOS8sY
         0lNlKjUFSTCV+tQluBs4O/Zd4y2C13oWzxNZNwxyXLBp8b2yIbxth5867r/k65gEJee6
         3TLMNQFAl4X3QRgi+Ywk9V4a/wgvY27gVy3kviE8paNvpjSUwe26mXe3hEi1G9TZlmI5
         j+K6YH1XIgvKFP+nBbpXJRC61Zro71x1Y3vuncyu+25XaWWSKp/hPuHsNZL3L6Uw5+Mi
         ViLrdOFZAjupKwozY5rXjFll3AjMtrL3d1fmFu9rqfiL9EhY/ZXfhRoMHsl7DxYdq5rs
         W7cA==
X-Forwarded-Encrypted: i=1; AJvYcCVuz9fpGq667mG6Gz+U93R9TliNA1N97TzhdZpS8w2fElKBciIa4B9Hx6inOQguT7YXL2EJmMqwK9QN7wY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg9LrIDiLoWIacL3nfvpMQPRCCX2nK8K/YGTsZjGG9HNoqCqXM
	Bqav9p/d1ohZZkSUuF3bfjz6mpX6HC8doL/K1/EgBg8eS1wX7PWWuUd9HK2e9is=
X-Google-Smtp-Source: AGHT+IGDAHRdlYmFq/60UQUNs2YlJ3Goxa2Kz3Vq1xQX23qZB2p5fUnXsQ++A0pOGewMXGkHHTy3Bw==
X-Received: by 2002:a05:600c:4588:b0:431:51c0:c90f with SMTP id 5b1f17b1804b1-4319acc2ca1mr169624675e9.21.1730378399971;
        Thu, 31 Oct 2024 05:39:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a6bc:32f9:21fc:be97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116af7esm2004922f8f.103.2024.10.31.05.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:39:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] gpio: fix uninit-value in swnode_find_gpio
Date: Thu, 31 Oct 2024 13:39:56 +0100
Message-ID: <173037839477.7100.6092134366756840133.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026090642.28633-1-surajsonawane0215@gmail.com>
References: <20241022194624.34223-1-surajsonawane0215@gmail.com> <20241026090642.28633-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sat, 26 Oct 2024 14:36:42 +0530, Suraj Sonawane wrote:
> Fix an issue detected by the Smatch tool:
> 
> drivers/gpio/gpiolib-swnode.c:78 swnode_find_gpio() error:
> uninitialized symbol 'ret'.
> 
> The issue occurs because the 'ret' variable may be used without
> initialization if the for_each_gpio_property_name loop does not run.
> This could lead to returning an undefined value, causing unpredictable
> behavior.
> 
> [...]

Applied, thanks!

[1/1] gpio: fix uninit-value in swnode_find_gpio
      commit: a14968aea637bbe38a99e6089944e4ad8e6c49e5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

