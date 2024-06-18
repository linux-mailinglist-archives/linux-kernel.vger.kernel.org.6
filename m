Return-Path: <linux-kernel+bounces-219146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8476790CA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D83287B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0014EC5A;
	Tue, 18 Jun 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="N78y5zEG"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976414E2CF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710477; cv=none; b=ggz2HWxwFmBO5diPns3CLryaoI64vxEg4d24ETQIOP7TTjZxepZwGW2nY+kTi3ZFaEeHr1HI11KZrAZNzMh4jdPlZYdORBYBrodJt2FHry7G/TpU/R0RV1q1yX0/urYSeVu85JpyxMGDyD+Qq0lwI7WLlb2d+WtdAonzp+XZYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710477; c=relaxed/simple;
	bh=UMkfk1uz4OiFUzUfIWw8xL19AnVl0WWu88Rh0CNSYCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdhe4lvf+fBGvSJ/DUhSq5q3OGTvUl0oxHFgGFVFqah2GXf85F3DfdLGh0Qjuh1SrXhMCqOKVymmUOMd/mY9XrV7JSpMpkWvgZhqvGkUw4wCZFwcCjHTA7YQBdqMd451oGoTD6EKUuyCIWB1dH6CzOUz8IqTt0ejL3boYFNierw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=N78y5zEG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52caebc6137so2950277e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718710473; x=1719315273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMkfk1uz4OiFUzUfIWw8xL19AnVl0WWu88Rh0CNSYCo=;
        b=N78y5zEGOvRJHsoLLBFoZ+q8mHQ7IzQHxJD75rVsXiyYWDEkN1TsiKGQFlCLFk575s
         /hCii7YmfXLGkTnuSH56M3Z2lMxPynfUnKNv2VObGz2kLoooL+7KP9TBeMLmBpAsmHxh
         0TtsvdZHNIkOHJ9RAlvIt+xEO2wc06+NE1paEaHSTd3FlaF4IfTWzH1ZbVPNlmqM84Si
         HCdwi9WJlgI0S+GYOcY3651Vmq3Fru5bANNN8PLTbCBY7JWlkkEjtVEM8JeF+2e8/Xmo
         BkKaliOhD+hP5eOya5xpSM6IpNSAcKqe9O0csqVrhFPCSonCVsXC5hOo1iffYNmbul0D
         Yu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718710473; x=1719315273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMkfk1uz4OiFUzUfIWw8xL19AnVl0WWu88Rh0CNSYCo=;
        b=WiRQXUq4qew7RDFK8QBhgsCjG7/ayyfImjjacDscLxW8HB7VnV6aNL8a0FKBtvcHja
         1Ne/WlCydlVXnpS6OyEW12qtX0SLbR05VQPUMUpGBHmHTHzG9DH+SE0fJ+VVL2aFWzY1
         KwYYRso0oAhZqddJ63ZvBBa4J9yObdLulwLlCkqICySBhmCNETwsJkpGdUAjrWePLIe4
         bW1o6jvefFYokj6oZxxr7KGz6cX6DRCzvlVsSsStXzB3oUEXNOqnPRPZC7nBLlV3uSZq
         V2oEhz3Yll6hWPmEUyOR0BNrt+mFztcAQCAsO+/nygLUzD5AnEGobUxOm87AG+Ld/qLk
         KcOA==
X-Forwarded-Encrypted: i=1; AJvYcCUBZxotjMzBTqcKI45aWQiD6hHnaMpBuNn4thc3K3FcdtVhDDBk6oXYYem+u+DwDmhJbuV+9F9QiAltIgJe51ghBnX398MqDgztO0rk
X-Gm-Message-State: AOJu0YzJ76rj7xq7CfZw6LTzeooEmd0Ua+iDPvpvTFYRoL6/8V9nrOB3
	HpIiSsh58hBGbEZGzIxxcaEz7i7LGKDFAwZdKUW+bNsxiXdHKQQcA4GIRAAJnuzJcvfyYpDTnIB
	4xTOQFhqGmRoC5GG/n1jwB/yU6tQRGCaco125qQ==
X-Google-Smtp-Source: AGHT+IGyZn9ZxYOyqgLilSVSiYsQNPXHOBNuta8dqNri+uFDpDVvXJ/3px/0KeevQMRS1XyUFGcx9t0XkY+UWQx74Ag=
X-Received: by 2002:a05:6512:ad0:b0:52c:8210:13bc with SMTP id
 2adb3069b0e04-52ca6e98fe1mr9251684e87.64.1718710473025; Tue, 18 Jun 2024
 04:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618111824.15593-1-brgl@bgdev.pl> <CACRpkdYWqsV+2a_L-dzyvGiV4WYAdS2B7WvOkKMyZh6tGT39Mw@mail.gmail.com>
In-Reply-To: <CACRpkdYWqsV+2a_L-dzyvGiV4WYAdS2B7WvOkKMyZh6tGT39Mw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 18 Jun 2024 13:34:21 +0200
Message-ID: <CAMRc=MepWmLu5zW8G+T93H6Eunb81cJh+ng1SZN_aYK64yYP_Q@mail.gmail.com>
Subject: Re: [PATCH RFT] pinctrl: da9062: replace gpiochip_get_desc() with gpio_device_get_desc()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Support Opensource <support.opensource@diasemi.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:27=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Tue, Jun 18, 2024 at 1:18=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > In order to finally confine the unsafe gpiochip_get_desc() to
> > drivers/gpio/, let's convert this driver to using the safer alternative
> > that takes the gpio_device as argument.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I guess you will apply this to the GPIO tree, else tell me what to do!
>
> Yours,
> Linus Walleij

I can, yes. Thank you.

I'll give it some time to possibly get a Tested-by from Dialog.

Bart

