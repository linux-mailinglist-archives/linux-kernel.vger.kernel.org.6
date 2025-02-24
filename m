Return-Path: <linux-kernel+bounces-529252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07D6A42236
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60091188F251
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124562571A8;
	Mon, 24 Feb 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="C9QenuBo"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749A24BBFC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405544; cv=none; b=UNdZv/OE7ff+auc+pcGjGzKipPdXZKKHy8UuNE6paVF7VwOEtSw+Kfc65mw1wm7p9PFnjFifoGoqAqB0l5RqtUpHYzSZcLlkRaoPH6cpl+czxZf6hZQETZ2mV4eogBvA+a/DSCiNBbERVGuKdOFpgHxIdBxfpdy/NcG+JIRFwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405544; c=relaxed/simple;
	bh=KJAjATzJr8jGQvQpU1dCW7Hnx/8ze/nn6XH4TERPhp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCaopGKetJ21UUiCFzm8EwfhD9O+t5CTHhoIkrs8Xb/fBf33RbMkpksL5ErfrQK5waXy2bDr5xudZoZJu7b/96pjsnRyn7zyDnZRyk6sD0r+3ksUXlBppu2z5rx7Elwk4XrliEINWqcqAaZZvF8CetAgdm1zpWj24DsUuHql2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=C9QenuBo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso26249155e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740405540; x=1741010340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwQMQDOZfV3huFqPSokcnS5jFHBZg9nLFIfYzvl2178=;
        b=C9QenuBo5XASCmDniZKNqRRDx1lpM8qoHX9x7wfXJAZ0oWEXud2I40E8w50toWsmtF
         epGIDe81HsJoQMIDsvRDLEerF8/FodrPLkXp5Xa7FiVARpM5+jEIe8lsWGZgcmCJ4at5
         kjvXuE8MD6kC41dgAIZ3x9Kake+jWW6VLudcFeWfSOrP8KDR3KyhNBEVNbc7GphioQU/
         pU464xJJuOeFRuNZTt1Z5U5T7RU8F6KD8wspbkQWy2TzgrKE8Oh1GZ3mIWnAlydq0JGs
         JmZA/rCqxJMS6c/c4lvUwYoQk4W7BN7ZowN+8NAgxuWMozF1pNnwycFnhaVpzA8lenWh
         de3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740405540; x=1741010340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwQMQDOZfV3huFqPSokcnS5jFHBZg9nLFIfYzvl2178=;
        b=eIYHK2vgEVZXjJKedxgsh3uigEYBK3ObsUS4Mtsrey9bNMydrETH0LXzqKEp5F3L6w
         LXylVvvJ6ollxkW+nevA9Tg8xOm2eLAWLh4ELVZpSq/DCg74aTpV5/sevl2oF041cqok
         9/ssg0moik6U9CGUGGK6awSih8LuSL5hfQ+LmLQm8QRaXQJyzLj7lZ9k7VbAcziDHis2
         Aa/+Rylvvnq1e42LPZYJo4rZUSkb1rZevZIC/jjabn3gdveRKQ1c2YSexDXLYghRT4P+
         vNJ194gziZVQMuZaFGXCNQLyLD9xyES3xU65U8jgRdBYfxiDnF/7kxMcSAyN//MKUsjC
         da8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCnt5lIYHHBF/UhgnbHyJ8O0sRjRDPI9GHrkMmdsbnuBZs5iwTmaA6bopE5ctxB2cBre100+QW8rWvPyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpllsNs38/ICbmpThHeu1q9HNQ0S4Jm/8ePMJBKtUn4KinQbx2
	oIt3q7c/j72ZuXalDCQhv7DTzoiEvzbRSYoNYz89F4NKIurW7VGhgfPEppfjEj4=
X-Gm-Gg: ASbGncvmV/woeScqX9rgBzyVan3aWxvVNL1kAUR98B3HKfP+YzHsXmYQU0H2nCdNy76
	ytalo3z10AUqFOesUzDC/OcCgMnGoCo7uwr9QPLrM9N5zxB5zBZ4Tc1Wnx48KjkJO60+qhUUJdR
	nXJUslgDcp147u/goUXgTu9HvoVi6RCgdcBp+SWJvDRTpAR2RVXGnNXBFJIT1eHLP8alHII32/L
	sW1n7nivIAPAIlgL73AFejEA4x61MUo7Z3FN9KBlAqRzFEDCemD0hjVQbedmbGmOT3wbgXm2kcG
	sWzchhElOpe6vO+5BOVYgCjC
X-Google-Smtp-Source: AGHT+IH5Jq0uXoNvpa8b9PRdgJON3IwyYfWk3fQO9KX90xo4mvjpcxwEFrV7a5vo2KNF0wJv5+V04Q==
X-Received: by 2002:a05:600c:3548:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-439ae272bcfmr98738955e9.0.1740405540468;
        Mon, 24 Feb 2025 05:59:00 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:eb70:990:c1af:664a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399c4e3b1esm114523185e9.1.2025.02.24.05.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:59:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	Koichiro Den <koichiro.den@canonical.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add synchronous fake device creation utility for GPIO drivers
Date: Mon, 24 Feb 2025 14:58:58 +0100
Message-ID: <174040547574.48618.1949653889364615138.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250221133501.2203897-1-koichiro.den@canonical.com>
References: <20250221133501.2203897-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 21 Feb 2025 22:34:58 +0900, Koichiro Den wrote:
> This patch series introduces a utility for some GPIO devices to reduce
> code duplication. There are no functional changes.
> 
> In this series, only gpio-sim and gpio-virtuser are updated to use
> dev-sync-probe, as the current gpio-aggregator does not benefit from it at
> all. A follow-up patch series that introduces a configfs interface for
> gpio-aggregator will convert it to use dev-sync-probe as well.
> 
> [...]

I don't see any further issues and it passes my libgpiod tests so I queued
this series for v6.15. You can now base your aggregator work on top of my
gpio/for-next branch. Thanks!

[1/3] gpio: introduce utilities for synchronous fake device creation
      commit: eb5ab6ffb4ca2d28121455dd7452061367ed5588
[2/3] gpio: sim: convert to use dev-sync-probe utilities
      commit: 2f41dbf9cb84349f510ebf2165c13102f79a550b
[3/3] gpio: virtuser: convert to use dev-sync-probe utilities
      commit: 45af02f06f6943d73cf9309fd2a63a908b587f57

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

