Return-Path: <linux-kernel+bounces-514806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF19A35BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454327A38AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99341262D30;
	Fri, 14 Feb 2025 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxWn3r/m"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA6261566
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530269; cv=none; b=fZcH/DnXkw5SopF4bdLmolLwuMZOtfRo+2DUypolaJzDo3/+dK4HckBqSjylAShWKNOAARP6SRwsZ2YFB304YCdNj/eM/ieRJLC03eyWNQtYlidohqWD0nVfnq2vBIx8vEzNIcJKXkPzsh2UaBpIyw+9iin7O7dn5UfXuUN6Dbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530269; c=relaxed/simple;
	bh=alJg2WcD9iQM6fGzOSqq88snKNzolPtLioHOdfwRkxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8Q0YEHFzu5nLIHycJpEFK8e8WaFKksCn+PKFsk6oWwsEBBQw8cVqBy5XuRqtSO2ABdt5TvoNg6UKBRU19BgkpwCMcMclXAnEwP+KEI7lB1G7bol2S1FgH5pd+/TMGL6VIQ4DO+wZ3lt/JhQKd3DBiXgqYTpbR1MudOHgz5XySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HxWn3r/m; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so199778276.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739530266; x=1740135066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBduhfyrGl1orMroy4bKyOiFO3o97dU6DIccqVmntUw=;
        b=HxWn3r/m9to9U7l0DB1D+HQ38tPwiXr10r9KQjrYqXuTD7EkwMaZ/6FjVUjV7ZR1Uo
         Do942nQJs8P1GwokrV9Vmc1LhwflIDBdyOkllr0kmKqM8Mn+AWaUb4EvYEMI0UVquGrm
         3Tcz6VcndL9jmiAJnnktCwsrtjJ2XiqoguoZN7INDFvkvTZ8RPQ8f9AAijLZaLDmkcOH
         8ThFfP3iE8ZYeRWFE7zrIaz5gM1o12pfIxegQ7PNFaPrjG69YZPit/iQ0VlCxN3b82x0
         69cPE0UX++0i6p0+4mNFnyN0dxqe4ISFLHtrTY/1biKTJInegBuG9GmBGXGda626LHyu
         ktig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739530266; x=1740135066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBduhfyrGl1orMroy4bKyOiFO3o97dU6DIccqVmntUw=;
        b=OVWY03qPE9QlHrmG3KauTwlnd6cOmqefGRqFle26k/mj7laWua78iXKXDx4ajA0GgZ
         nFxYtll9nNmxeeEGdN5o2at7aGtjOX76ULTbkBGqnyRXj+X/eYj0pFsZ2oMYVP9T+Amc
         cmkuHsyWTIiAzpMIqeTaRZc9qCkxs95JrztjqeLZchUcqxGN9gJ0mT+OAbXoNXJkCg5j
         NMezjs6QX99y0KzJIcydCejt4DIZ2pUGFtK+nBlamii5iGKw/ws6mv0tB7nCKX1G49+Q
         jQAy0ABDQOFr14p9MQ45i/VJKApOeLsX7IQhIn9S5rsGKD0pSO75vXqifPhIstllchqC
         y4IA==
X-Forwarded-Encrypted: i=1; AJvYcCVSquT5Sn24LdJCXiiuHunjgEmEXZdgmnA65g6pbSzdA21yQddGehs67Y98gxCKZdGU/6KokqbCwxX02l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vI/3c6SpcJSo6hernw7PugxqkNjQfwow6RvaaX8YPRIAcYRD
	5vRXZ+QLsFFcFBnU0hCMblZ5zQjMk4GEPwVgaIsr3ILBKR74DA6/Kxzpgmj8UsV6XTtGs/9qUY6
	Z/CSnj9c5WRDMjXI7qjZ0aNAteGZmMN3RUOTzpg==
X-Gm-Gg: ASbGncvcrYp5RqHzFhPFFvPD79CbjhUuVeFrS4rc4WOa/OU94xDGcmSthrkcHOd8AEE
	5M2yMR8tmtsM/voPoXsQj3Kct0VxU3UT6e8LKyqP2CLzWB1eC4KNRW0P/5vugCT1k5z5VRd/S
X-Google-Smtp-Source: AGHT+IHidm/OUIrPoTNLFfoXmDjCrIHe165QqBxdPohnxcxXbfU4pkw1WYa0Wj7VC34edtxzM/mKMMh7Fkc5qKhmOG4=
X-Received: by 2002:a05:6902:248f:b0:e5b:1805:36b9 with SMTP id
 3f1490d57ef6-e5d9f0cf5f5mr11331525276.5.1739530266311; Fri, 14 Feb 2025
 02:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213195621.3133406-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250213195621.3133406-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 11:50:53 +0100
X-Gm-Features: AWEUYZm_fywgHZuf6Chn0j2bDWPXTXWiYJbQTiIjd_fKw2ukXp9mOnuyypUOJCk
Message-ID: <CACRpkdao27pu+9qFH2LBYNwYkBbWq1B-hE9nZGfTTCnQxhTiAQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] gpio: regmap: Make use of 'ngpios' property
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Walle <mwalle@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, athieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:56=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It appears that regmap GPIO doesn't take into account 'ngpios' property
> and requires hard coded values or duplication of the parsing the same
> outside of GPIO library. This miniseries addresses that.
>
> For the record, I have checked all bgpio_init() users and haven't seen
> the suspicious code that this series might break, e.g., an equivalent of
> something like this:
>
> static int foo_probe(struct device *dev)
> {
>         struct gpio_chip *gc =3D devm_kzalloc(...);
>         struct fwnode_handle *fwnode =3D ...; // NOT dev_fwnode(dev)!
>
>         ...
>         gc->parent =3D dev;
>         gc->fwnode =3D fwnode;
>
>         ret =3D bgpio_init(gc, dev, ...);
>         ...
> }
>
> Reported-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Thanks for fixing this Andy!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

