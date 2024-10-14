Return-Path: <linux-kernel+bounces-363517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB61399C363
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0201C2090C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B741581F8;
	Mon, 14 Oct 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2BZNe7cS"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF301537CB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894715; cv=none; b=miFgMkW41erlA9zPnxqURZiY/aKFYstEwHvvgzyXpi02HQaPmHcgM3Zi+NSppDHgbTmCEw75y9EwPKLCZQ7Tq3T0gy3odfE7mMbCEkIs+z6ExgRvybygPCGH6YQWap+rbAEQApTH9n2BToiVCKUnBPZjH9tHuUa0UjFLR/tDGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894715; c=relaxed/simple;
	bh=1PvLezkk4vhImsgms8spDDX0FpqxpTPwQTRhciJhJg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QL3iRrwinhZity8EO069irQR2wf40t11WTjLdr9tDhAEzNwzyT/CKM+ndM2OhbvqLanY0nSXNUvKH9w6rOOl3M81x3t7fPdMpaEw/Vz1Uu+xc1G0yEtGk9CcqT37+jgZMYGAuXiU9bq+ldKfYECc90uiXCzmKF2itzOu0YvLUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2BZNe7cS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d325beee2so2387138f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728894713; x=1729499513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3uzILTqMUGVv6AXrppPM9T8gaGZe5Do58YvOV6Fx1w=;
        b=2BZNe7cSA5qoEBX93A+dOqSqAawWsw6vA+0T3NghLHf2dG1BJ0P/wUOvCTO/USgREW
         VH1LdWEuzGqrJahwmoeK4jKEBnwNN2bvmziM8URtX9sJgqSMCGRqdfSGVc8tGgX19u/m
         5v9lKe1MRJT8g6yu5PkYaQRhYWYlV9mKzdWJVH+bP3EPDHlSaTmU/pRhFWxtNnrNnlWa
         iyxIApP1n6Aj5hrV/47rwH/toOO8ktoEbkUwl/+rwd2sH1TVV7fStfnDM0GQ99OK3TrE
         0KMtjW1xQWInkbDnwL6cdTE701K25roAzJm/8h7eYngwz6LDLUUOVkgcabk8YrrL0ey6
         piPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894713; x=1729499513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3uzILTqMUGVv6AXrppPM9T8gaGZe5Do58YvOV6Fx1w=;
        b=clYiK7pICke0CQzyn3GZOeHSvtqJOyKhmy6qaCwn3y7b/ZNcNSbsVxjIiNPFVDIR4z
         7ZW2z+PJespklDQn5pFlj9VlRs8a+isbL+kDtyYI9GUz7iYUuQ32JsnJOuIhhR0z55z9
         ppjFUkyVFk6JQBkDN1BLA/VVQcCEIt5Nkx5+xGMpsjE9thOmNGXc8ZtZC8sYzdB2RV2n
         56TGu8smwoeD53fjaShCEtnE/agkuihewMlz5tV7ugG6HecBV9eE4dZfZQeRMy0VUWWd
         hf4qAPRJFXUSSXFRo0Qraa34dzDWxMfS44iJQvsab2E0e3Wk+p9gqZvwRjZc16MvS9P1
         wqXA==
X-Forwarded-Encrypted: i=1; AJvYcCWrDcpspOzTW4Gm6bfZt0urnfkecJ7iAUxAC+aCtVXkNTin1rL6TEIbKm2N/tFxLRL3r2CgswYJ+H3PrQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIwxtMRi8gewp0yQl4TUQWSBeYtADz7jut7Dd+oDqtLXlTqIKr
	rx77xGUPANsTzHzRGeNsPZ+l9oln6MUTtvOvn1A3OYM5NFUK0lm+cghLblTJxA0=
X-Google-Smtp-Source: AGHT+IHo0j5k08VMhjhdsV7Jsy/XzDEj84FT5zAaaDWUJRJ/KPAmWd5SN+Z+UwT5u9czj/rHKtmGpA==
X-Received: by 2002:adf:fa92:0:b0:37c:fdc9:fc17 with SMTP id ffacd0b85a97d-37d5ff2c4a9mr4568729f8f.23.1728894708073;
        Mon, 14 Oct 2024 01:31:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ed69dsm10737698f8f.92.2024.10.14.01.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:31:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: ljca: use devm_mutex_init() to simplify the error path and remove()
Date: Mon, 14 Oct 2024 10:31:33 +0200
Message-ID: <172889468798.57095.15647553616181059957.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008162416.85111-1-brgl@bgdev.pl>
References: <20241008162416.85111-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 08 Oct 2024 18:24:16 +0200, Bartosz Golaszewski wrote:
> Destroying the mutexes is done at the end of remove() so switching to
> devres does not constitute a functional change. Use devm_mutex_init()
> and remove repetitions of mutex_destroy().
> 
> 

Applied, thanks!

[1/1] gpio: ljca: use devm_mutex_init() to simplify the error path and remove()
      commit: 476f18c0895df7b281eb84b3e687e6101c844338

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

