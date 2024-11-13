Return-Path: <linux-kernel+bounces-407910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF619C78DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7669AB2B889
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E7201032;
	Wed, 13 Nov 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pumB7NJx"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B720102D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511867; cv=none; b=sztcCaL286i4FqUAELKMrsVR28L+qkKXeU6VbOYQd7nUpUh9oX0VAvrVh3L++x+Xjz+fxXK/oZWKqY8tkT2sQtFet/7JhfXoDovWbnq/6ZmtwxeBYxS/sNGN4D+g5xPOA9j7/aOKPRI0vqp0LfmFtFUgKEDrTdWXFb0rSnfS9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511867; c=relaxed/simple;
	bh=lX4i+/0Y6aWDk820KZdFk0O5Zn5VbSwVe/5pG/xWPt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZ4KXCLQ03mVIzBYHiQIvIW8LThAruK++6Zet5yj3yXfVlG4PjSwPB6jd07xLUC/vVq++ytmyDwWIJ9UaPUwA9G0yYtD5bQqBNfgkcLXN4fptto7Krhl2C5gHgcY6XkeKn8O+qSNVYF55lS1kmzE5UvhCvufRsPq9WwVFULbVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pumB7NJx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso62729705e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731511864; x=1732116664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPqgoBuFPYoqwqusaU3/yu0yJhFSW80NUjkLt0D/Jzk=;
        b=pumB7NJxM72/KxnwGyzPzjCS8QyCmiNgojsZV4XXpKfDaEsHx8+ZEcipmCfGb/Hdfu
         rCU9eJ5Yy802dz7ScsaPBI4KJUYDg7dBUrO8znTRMNfQhWmbgsWwpoXWcLLrDHvnxAI6
         C/kzJNZvYGHDbXBCcOYQfswt59Qj1M5G3yMGUQTYDdBQxLZZcfs7/nUwl7sXsnEvAqKV
         a5aWBjc9W949NxrWhi1wyIBIZJyYC6JUe/exH3E3PJoQYbcFgvNw8l48itUyRtwTjUyr
         /N+eTJ74pLMT7LhJLzognZnzJsNRyIWcR/W6TLgNb1dRKf2prGnIkhXpVJYqXf41W+ft
         agNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511864; x=1732116664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPqgoBuFPYoqwqusaU3/yu0yJhFSW80NUjkLt0D/Jzk=;
        b=hexUXCVL0mj6NIBLq/74TWslckMEvGuyEwE9gknxF4IJF0xjAICVKcpIunZZEzDS7N
         fFTpPAj6gZfcpliJsbxwgj+mywbktFxpsMhjiVfSvwAWPO6Looa6PkqP3KKBvmjGSlB8
         cJyV998UKSKwjAAAIf9gnv0tWIHTf3pdnsNH6rZXikQ49sq+U3OYvAj8vhR2yF3+Cmdg
         07PwWyalu+FvswCMm8rGP8qYBbZgf89HSecEYNjIErhDM5vhohpJ34EH545QhnBhCwqE
         +DC6jAaukhA3n+KofoRSFfxGoNcmAbfu/2TNf0SCaOpRHsKeZLA+2fv3pWrbXczxy/3f
         JhVw==
X-Forwarded-Encrypted: i=1; AJvYcCUxL/CyHgnt61rp6HQaBOHHXskOF6R82nWS8OAPaCvTixX/HjF+rNQYIwbtq9/iYxtM5x7U9egp9bBSebc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTA+030t6QFe7dRGrebEekwReFiPD2V+dPKPeGG1EBc9gJAIqx
	VwaCsUCVMMRhsOMKgNRYAvxRQX+eUNwDA6EssdsOUKDy5wxAA82f9ylO5lvXjqQ=
X-Google-Smtp-Source: AGHT+IECAqHdUxLOO7rCDqvc1tDCBe6uKr49t2jmybCecdAzqYZXI/qLCRS1qYjcf6huPIkfjJc/LQ==
X-Received: by 2002:a05:600c:35d5:b0:431:5f8c:ccbd with SMTP id 5b1f17b1804b1-432b74fda62mr186930795e9.4.1731511864479;
        Wed, 13 Nov 2024 07:31:04 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1b75:191:f7eb:da75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d555908bsm27731205e9.44.2024.11.13.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:31:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: brgl@bgdev.pl,
	warthog618@gmail.com,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: gpio: Fix several incorrect format specifiers
Date: Wed, 13 Nov 2024 16:31:00 +0100
Message-ID: <173151185739.90976.16408170612410991805.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113021458.291252-1-luoyifan@cmss.chinamobile.com>
References: <20241113021458.291252-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 13 Nov 2024 10:14:58 +0800, Luo Yifan wrote:
> Make a minor change to eliminate static checker warnings. The variable
> lines[] is unsigned, so the correct format specifier should be %u
> instead of %d.
> 
> 

Applied, thanks!

[1/1] tools: gpio: Fix several incorrect format specifiers
      commit: b6621b1d4b1d0459ba6b49c0bc498c352ac115ab

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

