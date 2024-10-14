Return-Path: <linux-kernel+bounces-363521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9399C36E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152CB1F21610
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B6815B54A;
	Mon, 14 Oct 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jSnugpN4"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69F158DDC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894721; cv=none; b=tUcgqNvJiziM4IM8frr82zt7rYhEfRD5gycOb4anJnZK1XhtKP5gqw8S69zERK0O+0AI2sWQBQwZNlHcb7Gqad/g53m5XjOYqwLUs5iZ8m/EFed8wVNYgSJV4zEyDSMVYKPjEXpmLcY/8qbwU1dirXifWdCIs0+iMlzTzHrHfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894721; c=relaxed/simple;
	bh=ymMY6wG019hIB4LuqCKoOdBQGAW9q5bmqi1Jf1cm0O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGFP6WevlAkYkSddwN9gWccU1L+qAoKlfCZkRuSnA1cKwSqwA0xPHPKQT6+iQWf1va3/+rBkVME0TG4GXCq8euXaM/hAcYCuopC+ihy9Atfdj3ZD/4GZv0BcPvt/hl9wvpTJuywBg6TDtXqMx244IC8zl3y9Cqsp0uzljy4J57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jSnugpN4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d518f9abcso2120327f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728894718; x=1729499518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guGzyQ4Pn8eIZx+G4Woa75avKhk9ZXhUydqY1g8oJBk=;
        b=jSnugpN4au6zSETVhmFpi9Rvh5BrWkeEPdHoXs0q6zVugagexBHM79UYuWzpFIPWMO
         nHft04yAMf1FTYQCFp1isYS8//zI2Gf6Og3pO/xdXrlCJPp2ltZtBVnxi5WFMHcrAp+l
         H/1BtZw57y1+IKMfl6EQ4GERHsRgtmQ0C9oVgXQbBPzN7xKchCmZm06HAlGrOGxCwiUM
         vkG/0G0xbewZFIOb3QyFZuxEgeopvexzfXuA81M2WfCWwgjHsVQtlDfWmEhLia2Rm9m8
         WxEo7rfuqYMQDXYzL0Gusw8xM/CIfgMOkkUUPvq3CKOZoc8awR+ykIZR9mtbMRXZpZA7
         US4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894718; x=1729499518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guGzyQ4Pn8eIZx+G4Woa75avKhk9ZXhUydqY1g8oJBk=;
        b=Rtfu9MMYnooGjOaHaLrVVuwPiDArQCZw/15Zz/J7ytedVAGfbl+PqqwVPfrU7nFrUz
         evjo1NIC9T4qU3+mOi6x/nUeCG8peoXpILP+GoDwtyrUOeGEXuVeeZtbEvqaGuqmBxHk
         O2Q2J8obSG3FQRPqSEkeVCiNhBQCKEEcXnn7cGJ3ULMoL8RBXyOfCwV3qud3OKl+HOpe
         z8mYYTh70lNkJGuDD0prz/iCwEelOlHWCL26QIXnlyrJdeiplO/DuESKK0ug21xkEa7A
         8Y03wAzi1b9yKX8oFH0tmlGVDGZOFMWA8v6flz3aTU8SacPVDnkEHOMc+1XX0DVIGK8+
         6iHA==
X-Forwarded-Encrypted: i=1; AJvYcCU8yfnf4vH0URryYJ9oh2i/eh7KCY4S+MIAHymz+I5ine8cFcj5Hbo53Lm5Hb+LIei2SM6BroRVf9vOp94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Z2GpEswV75rqsRfCR+RuyErgpgkX3yscmcj764G2RLITqs/t
	fNfDz2pGAwBOKst4oViez7IOVUjYLpIKIJbHOxAvrjjp2FI/PO1BQbMI19uyG0s=
X-Google-Smtp-Source: AGHT+IFwECvdj4t0VsS+A12qb0pKkvEfEjwhFJ85X5l9vojSF88ctMfnDXq9ErQNMBe1T2irN+sfqw==
X-Received: by 2002:adf:a39a:0:b0:37d:54de:1609 with SMTP id ffacd0b85a97d-37d5518e67bmr7370279f8f.10.1728894718380;
        Mon, 14 Oct 2024 01:31:58 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ed69dsm10737698f8f.92.2024.10.14.01.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:31:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Keerthy <j-keerthy@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] gpio: davinci: allow building the module with COMPILE_TEST=y
Date: Mon, 14 Oct 2024 10:31:37 +0200
Message-ID: <172889468796.57095.5694917494000811618.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007103440.38416-1-brgl@bgdev.pl>
References: <20241007103440.38416-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 07 Oct 2024 12:34:39 +0200, Bartosz Golaszewski wrote:
> Make it possible to build the module when COMPILE_TEST is enabled for
> better build coverage. Stop using of_match_ptr() to avoid build warnings.
> 
> 

Applied, thanks!

[1/2] gpio: davinci: allow building the module with COMPILE_TEST=y
      commit: 56d6ff4b8faf1c2d5c850ed8b4e5dfa6cd81413b
[2/2] gpio: davinci: use generic device properties
      commit: 5dfdcd9e73119dcb60b0299e96d2d84d23c354fd

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

