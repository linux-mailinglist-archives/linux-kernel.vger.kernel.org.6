Return-Path: <linux-kernel+bounces-311055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADE96845E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE48B263BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5151513DDC3;
	Mon,  2 Sep 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MJMbxJR5"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55619183CA4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272120; cv=none; b=eC4E53UzX5vPHFx6wKVDdB8dzio3Xj/M2FDecJvvItg5HVGAuo1qilSWxBiTbjJoSS2fqYo+Pq4jLn/EaKbUV9pv217toIM9qzwFqzlpe+TmV9D7Y/GGnSmPfAyZl8BswWiWl9hbjd+6eizYvDT3V87c7QXgiQK/mVABBUxE2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272120; c=relaxed/simple;
	bh=Jm/9zpKWdN5ZRm82KiJYSeXJpLpRnmNO9l5aVzEDFok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnZZiJGntwVzSUMa9+SBYTsc7uEU/18chyd4lyWycXDc7hKJFm606GPXwqtBXtaDBPFV87TGRt3zt3nXuyi2QoXCRgC7NkEpUiPSlHHb5Gyjtn7ZnXeFLoiCq8dLo+1qb6J4J76I6SZ7K7AKdvdBmx39BJL/n2uXSgmygJstvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MJMbxJR5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so18192805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725272118; x=1725876918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEbOFXH+ztFzC8/9D7KQi4eZyS6Ajs70PSFTJgZpLM8=;
        b=MJMbxJR5NWfMH9VZOnV7UcwXL9x7B4rZiOdxzCXvcuFFsUX38gaaX7tED4vRXIKy+8
         rpqpGCnnD/Qztewi7AAVbI1JlsYJeOxU2ZLpWhJh9zvBlHAxfcBsF6q4J2bMmjO/eSQb
         mKac7xfdbySvoIoLO8ze/Yde6p4D0xGjI2rAELdpkGJrMR0rgQi303j4U91aQEniNAai
         S8dk3HIBecUBK2WB3kVpupyjt7yoRCT1TEBsNPKyA0ZMJ5iZcTl8j7HDxX6QjRix4Tmr
         IXDLuA7/oFs1wzZz5WFgc2hvhakHhVztQKc7OSzRWZuFumd6bVFbMJYNDQof72S84sUV
         MqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272118; x=1725876918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEbOFXH+ztFzC8/9D7KQi4eZyS6Ajs70PSFTJgZpLM8=;
        b=RONlOixqaARuyde2ne/wRqFeyLZiSp7c/A2Q0g7VQBeZTePTyREZIyxXAzaiRlKi64
         H4yrHiQiNv51JLVxH2wKMiXxyrDO0iRj7h5ZO4FwT2wc4+wJ/+gl3k8Vo+XpckSpnuHc
         hsWSaneFfkijXbXRD2J8HdSYqr0KFNFs9GkhGJJXAfmjn9Te90VFJNEUsPKYjMsDHytD
         H88XywNLGexjyhbYIxHnnB9lDH3Q794V/LbjL28DjqreqpYvPN+7GdO17cBGaD8ja2QB
         Y7VunpbOyVYthVvjzgaNi2GxbuJBLeMyy0OHgMSpQZ93gVoLjJ44H9wnk10y8Kjqh8xK
         QqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSi0M3Qf4LALfj/7Pb2NPimg4eG8Ay1n0fHwnOMiLqINLcTzGZWbwKvDzchQAvB4XXYvFacRt2hZQROd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4ZqFd98YYWOxjobjvXmxNXh5PBKFxIYGR4BPyKEc5aqtpZKO
	5Pwm/u6CWzSOt+c/R1Fce28h5VIGj2HkGXay/04bUlvSIkEDCQCEYC/IPK+j1LI=
X-Google-Smtp-Source: AGHT+IHri22NPJilBulD/iiJNM1Yc120imgz1vN8BJCCOsuPOoIdwGHz0KTvEmXe/8gLUuIkFRCxNA==
X-Received: by 2002:a05:600c:3596:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-42bb02c0711mr105726205e9.8.1725272117279;
        Mon, 02 Sep 2024 03:15:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c2b29d2esm5158442f8f.107.2024.09.02.03.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:15:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: msc313: Replace of_node_to_fwnode() with more suitable API
Date: Mon,  2 Sep 2024 12:15:15 +0200
Message-ID: <172527210935.23717.16487261955368784745.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822224130.706564-1-andy.shevchenko@gmail.com>
References: <20240822224130.706564-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 23 Aug 2024 01:41:30 +0300, Andy Shevchenko wrote:
> of_node_to_fwnode() is a IRQ domain specific implementation of
> of_fwnode_handle(). Replace the former with more suitable API.
> 
> 

Applied, thanks!

[1/1] gpio: msc313: Replace of_node_to_fwnode() with more suitable API
      commit: f3434cec84705e1c4c00cd24909cb8c79d97a452

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

