Return-Path: <linux-kernel+bounces-558978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACCFA5EDDC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C1F189F4F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F6260A55;
	Thu, 13 Mar 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CachgJnn"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C7225A23
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854044; cv=none; b=AUoOkZghnq2HZiY4T4Imnne1fCSwB/1kYJiLoXMJbvh4/X3+oY+KuSw5d18OK/mHr6Ll71bP1jWjfjrn4GwnZ+wRfgsTQ35oyKHNSCNqW4Z3XwMDVlEuvRq0iymMqewW1rYquldE0tTdRn17IwYobTKwmdgQ2YWpiPp4owObhQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854044; c=relaxed/simple;
	bh=SjIN5pGdqHItZf6d6Qk2kPvBoUEnKMsk2a3iE+GF1tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAYzKHxIsn/8N6EZv0HV13BZeJbd5MkmNAVa000A/UtQxprWx1Kp7gJ0diJQIirhaNF1kYacK939/R4GkDan3r0gDcNyaSud+pb34mVrK2Rq3+pCnku9PnOzbqiMLXdVKkZMAeah4H4rrFKMpyTq3CjXUYOENPpgaCqF1ijzAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CachgJnn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43948021a45so5335055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741854040; x=1742458840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKvZQurkQ9RsE9+DByjOMj/p9v8kGhQoEtP4/SJolog=;
        b=CachgJnnFBNBciwh4B/R54ffsQ3Z9AjHcsvinEaVUUrGRy0drWzBgVHOO3SScnb/Va
         puEVVmYq119efB0/nnkErGD2YjQXX5ru3/liePeXRDyYA43yPSIP6PHuStxH2S3oUuFM
         ttmY43SQdF/4IrfKNdL4YS0XCyo3C6X8U2GD5iDANaZ5C0f9vuifGQJHivkvAXFN/Zw+
         RoTJ3ezin2nXmBO8dKKJITd6L93rwxMCoXPce1aYLBPJqUq3IWiahTScFZ2h//ND55ee
         JR3PVjbCmxgroMOFy77gmuKLkIwWYDcCJbCL/hxa7a3pARggnz3+dTjlWLVI7wHAX9Op
         yrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741854040; x=1742458840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKvZQurkQ9RsE9+DByjOMj/p9v8kGhQoEtP4/SJolog=;
        b=ghlim9pyHRgJrqSIRvtPFhToG5zrvhVHxyeh8NGRivB+GGOb5mQ4e96Y3d0yUr+5mP
         QjSzE4XqYJ7c68vx9oNEDjYHVr+efJtkXQRZWsMvGNQ+kK0LbldbpJKf+0uMclU+NnA9
         WgpU2MkTvxiJ2nvb8CloAt4a/jts5rROwr8zvKQ1LoWmBzotIJ5EoxMwGBsO+M/oUY15
         D90sfoW/jgVnkj6hCJa8W9fyRjWjz3LoK9Qqz/OCLZy+RFaXr0haZE2CQ6KJBRj7VHQK
         /XY7e6TCYKCPcNyiRm0qeRfNKTI+WhaGtQMB0S7Bz/YkCPIWrCQf6BJkv7Z4wcmvgucX
         QT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdO7HtbZMST53gzfWzZJYNKG03lN+SqZ6aslaYG4UzFKBt+xT2JFUbZgrV4hygL8nmJPkgCjwYcfSbJoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQuYDhOb6CeZZL92LgEe4olBK2SOkymmg0fFn1s1wh+kJLsWUc
	cLCap5D/VMHkB/vw+JqUksNnPLdo5vP5LBM8suaulrWSwoyHgZmoHO3UxdqLujU=
X-Gm-Gg: ASbGnctS9+47CeXfTv6XM7A2fE99JGOsfBqgip4rizJk0OwOH3HvNvLLDQ6T+PuG5DO
	bMftdBs9TR18MlD01KT6hUsgl22pnlL4YGJouLqldyWCPmSV14lgWRRhmfv+q2Wyb1HGs8zbEY3
	StjOmMq1YjmT9rc4a164ZmgxDQvjcjigLFC9OsF2V8NDRLkFYNLuRFsaTKrazCOEFsI/lDj0U3E
	YedWHo9XOGjGSzo7kyqlBc9Y/rcPpbvIYgLZJI6d9jZav5gztojFv+gs7/YoCxXlK/2EjApe7Zh
	ChR0ikj2j73DyYEhGAzDrBDpZTCASbDpG6Q9uEIO5z/f
X-Google-Smtp-Source: AGHT+IH3kWe07MDhWQnUjptIQdVl9JI8Gu/cjZzOcZrcKaxf93MQMfdXK/RBg6XKCwZ2N8EpQN5fFA==
X-Received: by 2002:a05:600c:3ca0:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-43d0aee17e8mr36190405e9.28.1741854040459;
        Thu, 13 Mar 2025 01:20:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:90f7:ca4b:a5e1:8693])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8d068esm45070275e9.33.2025.03.13.01.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 01:20:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	David Jander <david@protonic.nl>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT v2] gpio: cdev: use raw notifier for line state events
Date: Thu, 13 Mar 2025 09:20:37 +0100
Message-ID: <174185403526.7115.14841250128287935450.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250311-gpiolib-line-state-raw-notifier-v2-1-138374581e1e@linaro.org>
References: <20250311-gpiolib-line-state-raw-notifier-v2-1-138374581e1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 11 Mar 2025 15:31:43 +0100, Bartosz Golaszewski wrote:
> We use a notifier to implement the mechanism of informing the user-space
> about changes in GPIO line status. We register with the notifier when
> the GPIO character device file is opened and unregister when the last
> reference to the associated file descriptor is dropped.
> 
> Since commit fcc8b637c542 ("gpiolib: switch the line state notifier to
> atomic") we use the atomic notifier variant. Atomic notifiers call
> rcu_synchronize in atomic_notifier_chain_unregister() which caused a
> significant performance regression in some circumstances, observed by
> user-space when calling close() on the GPIO device file descriptor.
> 
> [...]

Applied, thanks!

[1/1] gpio: cdev: use raw notifier for line state events
      commit: dcb73cbaaeb39c9fd00bf2e019f911725945e2fe

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

