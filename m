Return-Path: <linux-kernel+bounces-219138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC7090CA53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C159290722
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2405213A27D;
	Tue, 18 Jun 2024 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvimlsKv"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375E139D11
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710074; cv=none; b=BP2ugtmXdgaqwXxvw3VRDmghiQ02SD/l/qOr/B74zxJCqxXAG978HwoxLfVuT+IcT1hcZvotRBkQqcYh+Irpz1xWkQH08LjwGSATYAixTFfuioPhBinAQZ4eTsS+iLG7yInMl+bflV//BM95h+oN4emNO2o81SVbO9JFE8DOFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710074; c=relaxed/simple;
	bh=Ef1LVa5cSagrsVKfv8LfYeQroHfw40K2Rz/BJEMjG54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Evbvy5SkZK1XJ9C0NUmbnq8xHmU3h9mgl5YHGqG5ZvIaKhMUODIZzAmjfHxfjldYieVMDl8nTHvlmv3GbfVBzK3v5DOcqer7869Vw9BaISZwBYYWezDbu4im2NTpFD7yqK4a2a7+jWBJilaXeO3QJ5PTjNZuvquaGLDsG7ZFDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvimlsKv; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52bc3130ae6so5783526e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718710071; x=1719314871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef1LVa5cSagrsVKfv8LfYeQroHfw40K2Rz/BJEMjG54=;
        b=UvimlsKvC4G9N4sDg60LnqolqVWcDSglSy8A7lt2+kzADxJI00W9hh4HLcoCwczXAc
         tepPNjKQ1W9VQTEPmqMG4Z+bacEVuA8XrzPW2dwHqVM4jp8Lw2ldwVlpJEHMfEms2hhl
         2IPNAv5a7QCBYnbajyEHb/BeZtiuE8IL0bTVCdWQNupsZYziMOXZdgalAtNmDCZIB/f+
         MwNTIpFaJsY1pY3PHFQ5ePJOZcYhHtX+beKSgG9+/iUI+crTlmYZMbSS5ukO9nSmacZE
         oNv8nFbFLHCES9CjqpGoW4ArPGptlRaw6o8AFnR8UvbGmHnqEvedkYNuwsOHqyi98jK/
         6eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718710071; x=1719314871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef1LVa5cSagrsVKfv8LfYeQroHfw40K2Rz/BJEMjG54=;
        b=l3YR0GeV+pC6v5eJnTrxQdGY/RG51gJdNJ7pGdlQ25FleCTfycNo5jFQFvTexTGvYk
         eYbyrxczxcuAJyeopwpgxNBfdTQzZJXlHSqWqE671e8LJmG77+zGkK3WPtzeNEi+pwjX
         nOTT9YNEA9H08urTq6FCyyK+eS9/EmI2DBa1YzuPOLNpfwgUcUQrqWyqkNvy41oD5L5+
         wmWj0ySIzUQUqUYEmNKut6s/4It2gfl0xohUfJfjJI/75XSzX9wdjoEnp+RxlGta3wB5
         N/DeeQopkLVKTzIPmDGSo8HV8seTZKW21Bu5jkzMAvD00c1TDAundOOLZUHFbJW4tT5Z
         RFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs57g7DHjcpWOVP2UxUeLFm1qy9Tv8Q80cZtsRQrFYV9PwhiUIB8koLQxdAQNQWi/TiqMrZs1bHSE1WjaHXqhhDJad/Hfqn02RmouT
X-Gm-Message-State: AOJu0Ywv7bal1cwcandMSII2AM/ag6ZnfCyR+Fe86+983Ntq0O1Hh4up
	MU6gLnrxZ+OJKpu1j+GzUw+3J3OVe6xwGzWYQ8QBcYEClCMhdbNJc9v3hKbyZ8pui4FmJek8VsL
	L9V+taJE2v96Wq1U2bqYvw8VyPIeS0UXNB2LD6A==
X-Google-Smtp-Source: AGHT+IEheZl1XJd07/I4c76ZX9172EIYDaxyOcwKiMvq82AVziwBWADH7Hsssc7rmmZWrFAeHWGnfitV87kFwI5z6s4=
X-Received: by 2002:a05:6512:3ee:b0:52c:8a14:6777 with SMTP id
 2adb3069b0e04-52ca6e55c9dmr6891062e87.10.1718710068957; Tue, 18 Jun 2024
 04:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618111824.15593-1-brgl@bgdev.pl>
In-Reply-To: <20240618111824.15593-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Jun 2024 13:27:38 +0200
Message-ID: <CACRpkdYWqsV+2a_L-dzyvGiV4WYAdS2B7WvOkKMyZh6tGT39Mw@mail.gmail.com>
Subject: Re: [PATCH RFT] pinctrl: da9062: replace gpiochip_get_desc() with gpio_device_get_desc()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Support Opensource <support.opensource@diasemi.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:18=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> In order to finally confine the unsafe gpiochip_get_desc() to
> drivers/gpio/, let's convert this driver to using the safer alternative
> that takes the gpio_device as argument.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess you will apply this to the GPIO tree, else tell me what to do!

Yours,
Linus Walleij

