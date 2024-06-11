Return-Path: <linux-kernel+bounces-210556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73467904588
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4177E286589
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E97A7F49B;
	Tue, 11 Jun 2024 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JjJRGOyU"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DA2628D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136465; cv=none; b=LNyHIznWcQ696S7rWIRI5WOkHAHeAAOYXRDk1DfsqRxYqAVkHjYE6SaN8xi0IUvV1/Vxgd2U4xYWAOdQh29XvcysadFxk6tpvgg3ubjBWIJMGAG/FFFp2Irlt5nUZMs+bZDCeW+RHHvVLEM+x7Wq93cvZD3ND2BWAD+3R8o1FJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136465; c=relaxed/simple;
	bh=uReg+kfZth5tCK460EQJnSZ/+0Rb0enkBQQFyijfOd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPuRP4QsAFLN52KMk2gljKshbvx6BZJSqXmZ5/SMixbm2xzkRPpkD4DAjWwD6xm39o1ajstIf9xucClNTjZl0OpJ/8I7fs7qH6hqRM8Z04SPumcAJUk+Vqb6+3kC7q6g0WH0Ubi1Hghx3qApAJoap8SaywJKA18pUxfC59MBYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JjJRGOyU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354be94c874so1087589f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718136463; x=1718741263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp0SmRihTKvCwUxjNzXPLTei6TKKBMfz5Eth2lbQK94=;
        b=JjJRGOyU/hYfzxIUW2CWR7Va/LY7E0yRivBhjC4rpIvttPrnvL5/l5xSFkS5VhFA6m
         snDNXnkDToWPpYzBtbxdh4nZiYsNV2bID9GlaaZ/Q65630pgG1XGFUWxUSRErudWLWgN
         1fskKtVvIgxCIG8UHa3h3vuhAEwFTvNc6EEZfVKBew647s9hr1JtzDQ/3+AWY2hjeBm6
         sZxXlff1s1jl8emZv+34HI3Ds2yyt2PBNfg7UuvrVZMVi5xcfzD4aJ8Mnxf9LDcbXnsc
         VEN9mRJxFTaoYCUHeRuUIoSdSlX/vbabiUbzPDnZC55ko0EFVUxcbLf582vHlLFWDRVn
         X3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136463; x=1718741263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp0SmRihTKvCwUxjNzXPLTei6TKKBMfz5Eth2lbQK94=;
        b=BxvS2wZ1tSkhbjBjvGOfofA8JCd3cwIuo4n5bqDqEGi6OKF6eE3FlonC0NxOatbkki
         no2Z+bUJEIF3zxBPK8MPH4knAXp2fCqQeEotEL761QWG2fXIufvaH6gWwb7ROH5prSxF
         wIa+yyDNy6X1fMq8KJmN37XRqYQTyQe78yeZAnN8qrzqOoqtUMDmnxaBi8uEsS0lTFJy
         34YGtAT+45fe+WRehUtjvMaffSdv3QkakAU7fv/zhPFuwSV2uh3+OaRCyZcH36KdXgVc
         R/HiM8CBLqjPML0hy2JzlT35OQWlZ5Wj0jQFvR3+riTIhoAjaRHqpr+C4rIHaBnn64UP
         /DTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7V3Ev/v+2FFxxewUfRHPUWu14klVnjTHhUzX1T6lFwvJ8C+OVdUEqTSH6Y4QM0fvVOoo3NAT8a+m4CFIB2vvj5vWOCCcObDI78CIy
X-Gm-Message-State: AOJu0Ywqhn9L6xHqjmOW+m5o49KyvEvEREEDxvBvBiu3kLTkOFZhZvno
	CC9XHhoOpvJz0QqkwnnOVyyTEOsXJO4PdVkGUVe8g2L0WdUzYcalEePQKQuyq48=
X-Google-Smtp-Source: AGHT+IEoQVgdK2bkmsXiS1d4mTtefIV7rHj4TW1pDs5MtgccfcO59X76nJJ3KtYzp7W9fGwE8bVGRg==
X-Received: by 2002:a5d:67c6:0:b0:35f:c8d:3a25 with SMTP id ffacd0b85a97d-35f0c8d3b63mr8979277f8f.30.1718136462904;
        Tue, 11 Jun 2024 13:07:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:38d:e428:e1bc:56b7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2f67b5b8sm1919562f8f.12.2024.06.11.13.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:07:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Corbet <corbet@lwn.net>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Davis <afd@ti.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: Re: [PATCH] gpiolib: Remove data-less gpiochip_add() function
Date: Tue, 11 Jun 2024 22:07:40 +0200
Message-ID: <171813645457.70902.8503975086996719219.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610135313.142571-1-afd@ti.com>
References: <20240610135313.142571-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 10 Jun 2024 08:53:13 -0500, Andrew Davis wrote:
> GPIO chips should be added with driver-private data associated with the
> chip. If none is needed, NULL can be used. All users already do this
> except one, fix that here. With no more users of the base gpiochip_add()
> we can drop this function so no more users show up later.
> 
> 

Applied, thanks!

[1/1] gpiolib: Remove data-less gpiochip_add() function
      commit: 3ff1180a39fbc43ae69d4238e6922c57e3278910

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

