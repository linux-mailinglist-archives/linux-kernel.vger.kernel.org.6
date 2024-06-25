Return-Path: <linux-kernel+bounces-228424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B721915FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77119280E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D0F1474A6;
	Tue, 25 Jun 2024 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ecunNsoc"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E54146A9A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299586; cv=none; b=BSljGY7PFaD66mnWwclzE0DxhWGbbL92/sM8kLKjTIW/YPo1dK9m8QOYWK/egMqc5rCStkr2B3kFKP0OLsJk0Wcrr0LYQQbkUKpwqXLw30KByoIiO32lHvQHF4odFlO8tNwBNMTjjwkFXQ/Q0FU48UMupZmP8u5EpC0hvvEs0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299586; c=relaxed/simple;
	bh=Qdy8JgnGU81YmB17wZu3mSBStqS5FA1Q5HKjhu15RTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jK2DSu0nd8s7z+TBiHcZe2XkdP7xMiSB1620ugYG4h0lTggEh5ODG16RLLg9gyC9r5RxiMqKaEv6hER4N0zhrKA2wj/aPKlPotodnjysfvuVSMN8FK3HYQu0letAhg9zMr8r1Ym+Nmt32u20bg+aA2qmBJf+itn8/ZfE2r4aDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ecunNsoc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3621ac606e1so3647800f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719299583; x=1719904383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiqfK75Bp/qrGJcp9xZSVsWz9JIfgUEAJ/gXBVvf1Vs=;
        b=ecunNsocp4gOS2Q2SB7E3tsalCVSmrsWiEcwpsXhPhEsHPUvNBymlIKpcMIBuMU9GU
         Nw8H32cAylzFXv1/kXQr7w7laravxlVbH6l5HmcEr8laJwUadzslJNaT/XhwNKvCj1gs
         nTmFC+3Oi7mY6OyV3MkEn2IDq2RwUkd9IYpdkJMKuWVsOFTUMZjjuVox0MtWKMD4R/sB
         K47KYDgq7Ivb3sFJHmbzxUGWP0gWqYzry2IjvfgFY8X2T6ZqGbjz9XxvLWQ1yX5ngX3p
         TLb41e9nTYK41Vm7YO4Uy6hX/2oHLDZtKAxUosnCF2ikObQTtlKLadwsoS/guf7cp0FV
         4xOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299583; x=1719904383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiqfK75Bp/qrGJcp9xZSVsWz9JIfgUEAJ/gXBVvf1Vs=;
        b=GrmSYyjnRIld9cLhRRqhSJ20dBuYeRZp+Bp4KVmuacLCsyrAwSu13alOkKFds7Z0SV
         5rj6bblODvM+SJ0mzkQsQ3qh63ZyX0gDx4Qm/jxUVYe9I10veths3qR1pthVMgDEcZ/q
         1LIo7+iymwxS6EsXWtI+kLMNDViuUdkjRm39dPpTQ+z/FxwIhDuHZhg1Af3ledUt7Qrq
         kuyl01zUBAKNJ2Ddet1D4uc9NS3bUo605+fDXiG16ia1v1jbH2s2qDWHCLlWPOCnKLul
         18yQIB7XkNn+0LZLJBWD5ajt4sNFR6KJpqZD5vP/lOepFG7kgkj4ngSRd/UmOF/7zwen
         +U/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxAxm4jRXKqrzzchoQ489PfW8RbeeAcx4hjoQW9uoNi0TyE1UknBllvOAk1MjChTcwwtQPDlMtsYNR2Y/7E95hAK/CKT5Bpjx70VGn
X-Gm-Message-State: AOJu0YwnmFI9Yt63w0d9kZVnGJYIHjavOuiE5/tDEJ41dE2TwW6BX1+v
	M9AsSZIxZRQOsyI+638DpqyduwKquMtyMbdB0G3GmdHDg0cURmOOJjaH16qq4WI=
X-Google-Smtp-Source: AGHT+IFkJP307iRceFscJf8nbUOaivnGN6WYme9itcYMjW40VFTx5xPfWKXkQozV3rAkdytXaodNPQ==
X-Received: by 2002:a05:6000:4e5:b0:35f:fd7:6102 with SMTP id ffacd0b85a97d-366e36ebe9emr4412480f8f.35.1719299583435;
        Tue, 25 Jun 2024 00:13:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2b2c:4971:1887:588b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8aa6sm12107253f8f.105.2024.06.25.00.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:13:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Support Opensource <support.opensource@diasemi.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] pinctrl: da9062: replace gpiochip_get_desc() with gpio_device_get_desc()
Date: Tue, 25 Jun 2024 09:13:01 +0200
Message-ID: <171929957893.5997.4621922816766021380.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618111824.15593-1-brgl@bgdev.pl>
References: <20240618111824.15593-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 18 Jun 2024 13:18:24 +0200, Bartosz Golaszewski wrote:
> In order to finally confine the unsafe gpiochip_get_desc() to
> drivers/gpio/, let's convert this driver to using the safer alternative
> that takes the gpio_device as argument.
> 
> 

Applied, thanks!

[1/1] pinctrl: da9062: replace gpiochip_get_desc() with gpio_device_get_desc()
      commit: 8657af6c0a9afaa11947b7476119834898823b52

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

