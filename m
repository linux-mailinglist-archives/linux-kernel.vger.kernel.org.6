Return-Path: <linux-kernel+bounces-413893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110D19D2044
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F03281C63
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0783156F55;
	Tue, 19 Nov 2024 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="en+5E0Pi"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE11465A1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998135; cv=none; b=lZDlnk4orsSB7bAQ8Cm2XrH9xp7cLFoTiSTuO7/RyH9u7Fj6cQkAwZVh/EYORy0Xw/Q2zTYu0BCglsIDSf6V16TCu+h3v8Ol1IhVPSUBTpJYK5aFTy2yiYZ6BP8EUwhriNsJ1c66xxJFbw08cCuYacoyvCfIucN2Ns/JA0VCgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998135; c=relaxed/simple;
	bh=zNZYHo5AjgwQKszUv3ztHfv1oGJtqmjUz1revEZlEUc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jhRdtURoXkW0n1jMc6uit9Jx/iaWrcQNPhf3ZRycGLMYnx9UuKsRKP1F+vqSUZL/3N7zYq67eZhxa3Z9N9Eum2yKcfet/tbNgkF9XHw1lmImYWVHmQ/GYSdAlBdRa92TvG5+QUkQwfHUKvD9k4zGwlPbMmxultvgWjfrKYMiuHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=en+5E0Pi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3823e45339bso430505f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731998132; x=1732602932; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zNZYHo5AjgwQKszUv3ztHfv1oGJtqmjUz1revEZlEUc=;
        b=en+5E0PizarLkz6mDI4OKoyplEYhnIY/n9RJ+Ch4pqnVYeijZEiLJBPoa2nE4rhUY4
         cgf5/tLfNZVqU3GmZNiQXjCOGCq89k5xB28bMGmbLnMtCfhitaMQunBDzV3Yt+5dLJ9K
         z1r6sM/jT2CZiSPokZUYXaPbV4hgvCHfO50LRD7GwOfp6ZyMRXbOWYYwfeNa4x4yc1/u
         /tRWolssFbVDzka5+gb8N50Z4EV2I46B6MUMYUBbX4KZN79uGzmhkIPm9AgcE/7033rH
         5cl6UOGk+xYJ7ILzY23PrmfJNJsv9XG7oby9bq4S7cIAN3FYs/Qn0Q2oNeiHT9/Ro9r5
         Roiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731998132; x=1732602932;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNZYHo5AjgwQKszUv3ztHfv1oGJtqmjUz1revEZlEUc=;
        b=ET/oQJ5JBsVVCFb8nlzYxGhR07gXYi0HQKcqGLnYMOLm6Puwe4h4cXsBVy44sObG6M
         +D6VUub3VncaxUNPepbT/GPmcOa5NlnEXUSfU3mE67xHWmf9zdFWaY9ATWK/pDIdjqh1
         czTFfgMqU1QEp6yyWIkNXQI+UIqNccn9lIHgVAKOD3pbcHdsJ+3BIdVmcu/8D1vI/3YF
         oa5ngIl1enzQ4wJ/x1eO0HKBDBhYquEM1xK13Ye1IsQDIMhnNO1DtX8lCVPT87OyPyZK
         IGmdkz0ic6osYhS8mLCIK7tefIgis8A70IwwyUehM43Q7pt9L6Xiop00H6sqOzI+zfb6
         Frsg==
X-Gm-Message-State: AOJu0YzJYEOYpsdph50aYX6zKvP2UmCrH9zJW3jedF+GFS6A8fDAH3Vr
	eOjVOAh9aRmgDqzbVpwrVTX27pibHcPM/zl4UIONgqR1s++BtRIr6EW8cXt00Gw=
X-Google-Smtp-Source: AGHT+IHzG2/enHhdlPAuToRJeBEJCmXUH0svKHMarp1l6IkpQ01Im2PyZbGkMtinAJk9lLigLM7j+g==
X-Received: by 2002:a05:6000:1882:b0:382:2cbd:9a4b with SMTP id ffacd0b85a97d-3822cbda266mr10043080f8f.24.1731998131536;
        Mon, 18 Nov 2024 22:35:31 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78918sm177862585e9.17.2024.11.18.22.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 22:35:31 -0800 (PST)
Message-ID: <0cc57d5746de472129b3fa7ba02e1289fab91069.camel@linaro.org>
Subject: Re: [PATCH] pinctrl: samsung: Fix irq handling if an error occurs
 in exynos_irq_demux_eint16_31()
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Krzysztof Kozlowski
 <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar
 <alim.akhtar@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org
Date: Tue, 19 Nov 2024 06:35:29 +0000
In-Reply-To: <c8358dc9-24e0-40f9-b559-18cf7b93f5c3@wanadoo.fr>
References: 
	<f148d823acfb3326a115bd49a0eed60f2345f909.1731844995.git.christophe.jaillet@wanadoo.fr>
	 <939800a57d356771b405de49bc198d33327b4fe8.camel@linaro.org>
	 <c8358dc9-24e0-40f9-b559-18cf7b93f5c3@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Christophe,

On Mon, 2024-11-18 at 21:40 +0100, Christophe JAILLET wrote:
> Also wondering if it is needed in exynos_irq_release_resources() if=20
> clk_enable() fails and we early return.
>=20
> I don't know how these callbacks are used and if we could dead-lock in=
=20
> such a situation.
>=20
> What do you think?

This was pointed out indeed in
https://lore.kernel.org/all/9a960401-f41f-4902-bcbd-8f30f318ba98@kernel.org=
/
but irq_chip::irq_release_resources() is not expected to fail.

_mask(), _unmask(), and _ack() have a similar issue. In practice, I don't
think the enable has ever failed in our usecase - it's just a simple bit
flip after all.

There are two options, update the callback signatures (and all users...), o=
r
keep the clock on for the whole duration. Given the clock really is needed
for register access only, we didn't do the latter originally:
https://lore.kernel.org/all/0106b6f58ce19752c2c685d128e5a480103ee91c.camel@=
linaro.org/

Not sure what the preference would be, 2nd option is likely easier to do an=
d
it would be surprising if _mask() etc. suddenly could fail.


Cheers,
Andre'


