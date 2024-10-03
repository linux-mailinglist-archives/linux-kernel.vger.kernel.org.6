Return-Path: <linux-kernel+bounces-349470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A755398F68D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94EB1C22EA3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ADE1ABEB8;
	Thu,  3 Oct 2024 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gouGuzzy"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A81ABEB7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981641; cv=none; b=H067t3a5uQXOzx5ofDwaXZh544b0DfFogQvw2fs11qV/+UFqw0HmfjpSUMImNvk5jmopWQh1H+W4Hvs+IjoiNPLa92j5RrAib+chtomSkPhED5SjuQkVVsUT6JjCcAjX+XkN79DSFtf4wL1z3gv9cOILO7b0doocPPF00Qmwjzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981641; c=relaxed/simple;
	bh=Aqe59oBmHOyl5wWiS1U9TJYJQG6Xi9YPCCHb6ik+U3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHGZQfJb6+b2YMuL2HutNZ+1B1ImizKcN9fLxIeOsRtaKHKDtiKi5GjL6oGBizP27asaClMp2ex2H64iW6e4pgJjPNJTRJaQnamcDFYAOJgNZzQDITjAJ2Tg4t0WloMczc7ospAbbnjwl5nHjkr9L18RWC3NQaywQ2+XGg1V7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gouGuzzy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cafda818aso12761215e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727981638; x=1728586438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7Rgivd96fCzL22YiGf6WhlNkKr0h3M5JifVUpHx5A0=;
        b=gouGuzzyFyO89iwnUZkliBMHAGJH4D/HjB7voreS9uqMPY8byltWXYYbuxN7jVS722
         OM1hszG5EjzcC5ZRHIVdpLWNfzYMVc+vXZmu+LD4hKOPp0++QVhXeU61wMxvqDyU8gpC
         LMMhHQg8cBNAdNomed7vcGJI4bna0zlByE7uyqb+JuY9Nw/GX2/oC+DRKG1fi7priMAH
         eMxK1xzQqy5eDauvB195gwDLIT7f+asWTxmpYR1jz9rCWwAYcmkcT4a39TNDGcDTCEb7
         ruOCv3AYnqqcbdShNF+qkcTdTQKvQmWRGXW4z2WISnyAgv2PuQj9mASLsq9aIzkpwinN
         W5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727981638; x=1728586438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7Rgivd96fCzL22YiGf6WhlNkKr0h3M5JifVUpHx5A0=;
        b=vpgQkY1cjYVI7pX+zb7ZOeokLPunuHLqPic3cLXVXnbNeGVOlxGc0V6QzJXkPNFL+U
         H/qOeBKWwhRl7kuUwucLQQYwQIRrLDFJqp/mtnaCciQ7U3lIqJcoH/7BPTq9ST6d2MS3
         unBX9QHkczJP6fYwJGoWn6DWgE6CJ/KMThY+9w3i+XANQqqNgl0srdubhqU0yEccvahK
         laAdRbRDb3t/KeMbi0VGkxc5Es3Ix2Xq81yv0L6TAdxc0DdVzDTS+leCcspYn6DZPmpT
         4an3lt+QV1Kdzu4dZEHtbZSloa9nEZYy2V7r5T9OIFcIy9PE/faPAvsAGWOLrVpuLxF2
         fsrA==
X-Forwarded-Encrypted: i=1; AJvYcCU0XGO46PczHOsYk5dwGxW0D7CSVdVAEJZ016TtVxnhYtaWBeE8lrROQBXzkcdJk4zuCzoxxuSBs3iJ8Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4dALmKlQncVOrfjk8Z1ixyADLa0xB5Z2MP9DZW3NEdFqgOf7y
	HRf9VahOlAxQm8BcpXNjIAtYuWsI0BgvBWOmLJH/ZLdlK7/oST9AGbnn7aVAIJI=
X-Google-Smtp-Source: AGHT+IGdMDDuB+X/iH8qp2PoHwumzrpJ170SAsJSIi+VUZmj/upMuarzwVOFa8anmg4yM5/TdKFQUg==
X-Received: by 2002:a05:600c:3511:b0:42c:acb0:ddb6 with SMTP id 5b1f17b1804b1-42f85aa8087mr507345e9.9.1727981637826;
        Thu, 03 Oct 2024 11:53:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d16b:3a82:8bfb:222a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a02ef4bsm50870425e9.47.2024.10.03.11.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 11:53:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar <prabhakar.csengg@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] gpiolib: Fix potential NULL pointer dereference in gpiod_get_label()
Date: Thu,  3 Oct 2024 20:53:55 +0200
Message-ID: <172798159241.47650.3165790189839746577.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003131351.472015-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241003131351.472015-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 03 Oct 2024 14:13:51 +0100, Prabhakar wrote:
> In `gpiod_get_label()`, it is possible that `srcu_dereference_check()` may
> return a NULL pointer, leading to a scenario where `label->str` is accessed
> without verifying if `label` itself is NULL.
> 
> This patch adds a proper NULL check for `label` before accessing
> `label->str`. The check for `label->str != NULL` is removed because
> `label->str` can never be NULL if `label` is not NULL.
> 
> [...]

Good catch, thanks! I added Fixes: tags and queued it for rc2.

[1/1] gpiolib: Fix potential NULL pointer dereference in gpiod_get_label()
      commit: 7b99b5ab885993bff010ebcd93be5e511c56e28a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

