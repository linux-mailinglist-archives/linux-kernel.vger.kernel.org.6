Return-Path: <linux-kernel+bounces-210655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2141B9046CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE3A1F2264C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC978155312;
	Tue, 11 Jun 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvr7QjPA"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C971527B3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144052; cv=none; b=Ilc00SCiXAbMtW4QE6bpb4W1YmXhokd6JTYFVWlXXIwpAvSZVl8d/p9RZNRdqYCrRu0QLAOnBopMIqliYEB2FW87veo1sbXGvY8RNQ2KE7lUf0NVGyoRGWcAbbrnXn5ee95ZaPOqjSqVC69EJtzRn6GSckOjKaOUJrjG0UR6Yxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144052; c=relaxed/simple;
	bh=dgd2gxREMu5XUau4oavqQoWlbsTO40tosBCUZXfMJAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7lYrqSxILKv4Opp/+1dbB0MYPsrbIL2Us6oZWQpw4ZqzKyszK6qaqCP0PLbfhR3VMxLorM3r7XxatSSu867N8hJHybmucRMO7qHidNZUqBLkKmsta5X7sJ3cfrojCbL91A9ii+Jy1Ex/uwByAtJRTlaeoVnvRynWiHyaAhuXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uvr7QjPA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso5026827e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718144048; x=1718748848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgd2gxREMu5XUau4oavqQoWlbsTO40tosBCUZXfMJAM=;
        b=uvr7QjPAzlrSuyUCmdjVvR4RdXDaxjnoDH9u/5LDJIB511mGNgdwo+8PiEO169Sne8
         8ztxkx7eDKQvReRNA6hxOc7SL4eHLPP3MdEQExCLh1p0JbLRiUrIcfLkxVUoCgYmyqwX
         1CjZOrggoOMvV7oup9r4G0Z4lNp4TKcuQlCHECtJepbPTB+pB2RVjnMUQjcXCMNcBZm2
         kGAd5AdQw9a71efMlH1wBLJN/GE+fa7yQemdOL78tdttQRZeuUTM4csKwwN8MjoaBz3y
         dgKImG5Hqrt4mzjwIAjRwcTHDAPTHPMB7uELhRhbHKDqrE30o1egZR7wG+tQyoRPT0yD
         45qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718144048; x=1718748848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgd2gxREMu5XUau4oavqQoWlbsTO40tosBCUZXfMJAM=;
        b=nrwbLxBBbiLpWTcDaZSrRKPb2ZKwfEPD+typqH6XuJRWpr3Dj6m8a8DWAS/hZT8J5p
         moYrz3gn4fpyNFgiR25wMT+Txp5X3qPeG+LglWf1oSzWMKstsniZcj5VKzbEo/84M3YQ
         KGH/eBfWmn4rb8KKYm5WwkG1Y4lTw3yP6htxkjJ3AmxuE9Hevgnrsfb95CAAW1qHrBR8
         iO+0TWrsYGBlV6CsjK0YwRG07KiMEbpmz0zHwIHSV001lksCaxH6HVNFIjNTSDP4YzvW
         HHkeJKIBUHxyIPlcpTe76hUTb+/4J/1+Z/dnjB76uTnClDOgOgoPJ4dDekBaViyRWS9j
         EVDA==
X-Forwarded-Encrypted: i=1; AJvYcCUUPfgZR/QVFaeHqwja1c2qmQlti4oU79bq5kGLh3wi2TDMDsnM5C7WnL/ofNFg7DL2DHlJNWX3HweNbmMLVXWp6R2XLAzUdnyh1XI7
X-Gm-Message-State: AOJu0YyGf5QWFFG1e/M6nKEJEKiZrGlZCGWiJJOilCltdqlfsvAETcD7
	wGuzXwnxC3kLz5TPOLfdbQmSW8V1zJEivKmadzY77BZxYSK1TA6M9ZlysjH5VudcdQqfTcWpql+
	t2C+XGClMNWdv4jYzG/s2Qp+G3xQyq0hc+pf1aQ==
X-Google-Smtp-Source: AGHT+IHfY/q/cePfsrmUdvmQzxhTsMhZ1rs7ja/Ex9eG+8XjJ1a29geG+XyIqLfctsaWD+jBjjaECZomaXufChgbzk0=
X-Received: by 2002:ac2:4850:0:b0:52c:8023:aa9 with SMTP id
 2adb3069b0e04-52c9a3dfb4emr29645e87.36.1718144048216; Tue, 11 Jun 2024
 15:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528120424.3353880-1-arnd@kernel.org>
In-Reply-To: <20240528120424.3353880-1-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Jun 2024 00:13:56 +0200
Message-ID: <CACRpkdYOb3S8=EffjE8BpP1GTu5SWSEyorJ7i9HA2u7GQexwzg@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: add LEDS_CLASS dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 2:04=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver fails to link when LED support is disabled:
>
> ERROR: modpost: "led_init_default_state_get" [drivers/net/dsa/realtek/rtl=
8366.ko] undefined!
> ERROR: modpost: "devm_led_classdev_register_ext" [drivers/net/dsa/realtek=
/rtl8366.ko] undefined!
>
> Add a dependency that prevents this configuration.
>
> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I tried to create a separate .c file for the leds and stubbed functions
for the LED stuff, but it ended up having to create a set of headers
just to share things between the different parts of the drivers and
it was so messy that it's not worth it.

Yours,
Linus Walleij

