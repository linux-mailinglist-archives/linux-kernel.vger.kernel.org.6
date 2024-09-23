Return-Path: <linux-kernel+bounces-335627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C834097E842
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AADB21B39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685191946CA;
	Mon, 23 Sep 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+MHGuHo"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902944C8C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082686; cv=none; b=hiFGzOkrUEctCpSrIYir66ONJElM/Xqb9fLGRwep9KYT5N4hn+pO6fThtEXM/PPkwHw8s9rgi3uvGHa0/UsMi2kEfqHuasXQaud0nHOcMP7iajYtmmms4NvjVcXk/WaJN3NnzfedtNc0VSdLxD0UI/GCXrpKqshuXaULDTmaaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082686; c=relaxed/simple;
	bh=AZIx9rKTUGdByF4WZiCX+zfX4iJ35Q+2Es4AqueXfFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inmcRj2qDAs6oaV9lwY2RufMHP7V8QCxHnJeS6SfHHlMMACIuAE+hRpYEsUsC0A9kLuGoaW30Ru8fs6BdpBvRFywSXO6qE15W4iXKStqOwd8mRIt39SbAnZEUzNzAXNdwOZVXvZGJ/u7S+rbIbM+naYJfmkq53btX0d6SmdANHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+MHGuHo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5356bb55224so5370902e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727082683; x=1727687483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZIx9rKTUGdByF4WZiCX+zfX4iJ35Q+2Es4AqueXfFo=;
        b=A+MHGuHo/D5c1tZ6z/NGX1aKrtJEDGJMXKp5QUqvVpcQ4ew8lNs6Yng9R/JtWCa/pl
         hXRwegG8MBWu5n2nd5+Gd9n1WSZUl+V2RUeOvwFZ4GT7bCtmwndFkApNXgm8mTj05CYr
         F1Oc8MU4tfpJsEkpUpemHQ0zFY86wdAVeauI8YEo8D99HoMSasEUS3Qdbfl9RYWQEtAJ
         cpIttVYCzfTnxX5ZftDxhOqo8ghxYD6SzADEgjznwXNSHCoJvv/Dv++C7uRWhRB8W9W0
         L+icxyDN5hwad8lb4BTfr5dI5Pjh/vQ9AEhUuJav/s7LJo7LTQZeDwPNqHhGfk6q1ECA
         wzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082683; x=1727687483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZIx9rKTUGdByF4WZiCX+zfX4iJ35Q+2Es4AqueXfFo=;
        b=Jou+sebLvYv4qFRfXxrifNZY/5o1ReW/Ut26c1sU4hPcwMGMhskXHvD3DcASK/lkUz
         hKSYLH4rW+K9t7U70foR+yvyOrAt9RRf/ZcGEiIkpHeWcmaiKlj+yf5pyt/Sa+/UYxV+
         QdCj9IV5HPFkUjFpytgs5fWKS/cSOjP0wn0KFgo2S8YEsmwtbbkNFEs9JhL8/XAJzk1f
         3AG/imK1LwLB8ITCgT9ziMGwrWX9V+zvnAL0WwBcItaBOKpSSBgwZvDpfqzLY0RHW4OF
         Ibc6h9ZAdPew57S84/jYqb80IjFTS/4Z3Z9N66MR5Wjet9sUjiSku54tKlYhVkq3IxTR
         n0OA==
X-Forwarded-Encrypted: i=1; AJvYcCXXivbIjxvVbYVeXfwenO4CSccft72wSSFqkYUC4EiBIMRml3KN2T667yORubSRaVcKHpdxrSKAZqujgyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCSzLI6lvxxt0d/9PPUUR742NNVh2cgapHkNXRl1EfHwr+oGe
	03otUHreLWT9gBityzlIdoz2QeIKwcxfJuZBXzfg6KsicX5WyjXzz2ociaYOY2aLbp5i09KFPJt
	3GKd1HeLz5CjXTISZBKiqQGHRczDIZADRZ1l0Kg==
X-Google-Smtp-Source: AGHT+IFQ1qZsOpowt2+/QP1S8b71xK3Uq94t223hw3YVn5ZVtdCs3Yx7HoofZwcgwTqF8uKwMUrbu6KUKVE2A2dhKyo=
X-Received: by 2002:a05:6512:3e29:b0:533:901:e441 with SMTP id
 2adb3069b0e04-536acf6accamr5421955e87.10.1727082683190; Mon, 23 Sep 2024
 02:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826095723.1421065-1-andriy.shevchenko@linux.intel.com> <ZtmqdP6Q92vRWh_I@smile.fi.intel.com>
In-Reply-To: <ZtmqdP6Q92vRWh_I@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Sep 2024 11:11:12 +0200
Message-ID: <CACRpkdYSPGsQt_FQDurtwmyaLtB3=gaay-hLN2QdOj25e3sK8A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: nomadik: Use string_choices API instead
 of ternary operator
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:56=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Aug 26, 2024 at 12:57:23PM +0300, Andy Shevchenko wrote:

> > Use modern string_choices API instead of manually determining the
> > output using ternary operator.
>
> Linus, do you have any comment on this?
>
> I had sent two patches of similar changes (different drivers, thoug),
> one got applied and this is not. Anything should I do about it?

Sorry for late reply :(

I thought it looks weird to replace just one string choice
in the middle of everything and it will be confusing for readers?
They will be "but what is this now, this looks weird".

Yours,
Linus Walleij

