Return-Path: <linux-kernel+bounces-572614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3AA6CC32
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761CB189B8E4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA22343D4;
	Sat, 22 Mar 2025 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VI9R0HNn"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D48D1D47AD
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675243; cv=none; b=th2V1DKbzaGxK5tA51q9xvVdm7FcHL/mk+HdQvFp2ow7h6PSGgPX2GkYTQa04ac2jvU3XQU3d9ISNKc02+ciQZANQJT72lYDKSZnaAt8zN1fPDcNHUf/Cacoedjii047u8qSp7csbFYlfk7wt89liBfejW0CY5x5F0y0FutxldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675243; c=relaxed/simple;
	bh=HUP3DQjJ/dXe89wrBZFX6Om6Xaapd86HWCqzQXLuZT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMl6OP6tza6Z7CJXkbHNNYhYqCjXFVtMdGeCdVkc1SJ//54nx6lu6/UEa7ZybEhR/N0IkA5xuKWrmRZUv3l93bOihe1jKn6mQ4jkjb1n/jHlsMJ0XX+mATl2xDxfCY2WU52nHGsRl4ksUZE7JvqXKSy17IF7pWe9cx3s8p57fbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VI9R0HNn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so3241108e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742675240; x=1743280040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUP3DQjJ/dXe89wrBZFX6Om6Xaapd86HWCqzQXLuZT0=;
        b=VI9R0HNni0QwfSl7TzyO0BOwG957jKEEzQVrItjGMtKK2Kmof6RIbRlxVV8Y93kDk7
         w4bkMF0fiHJpm4vRtlC16PK6evq1Iz86RxnIC7GsExCjqpl03gcNkSM9Q7zX3joW0MU7
         kTDQXKGXo/RUdqnZNcNCbaAIJRWjmK49o8kJu4OIID27DZm/tytor8LzCPx+KJ3f+mvr
         0EaVfWTcXQFyx1XRjo388JtiQlQvHQZ0Q6BxLaT3pVLk6YvoYSfuId5LV7/TjdZTRaLQ
         oFwndxLsVHoJ3+bTudIsec6pbIAkOIZtTBTZogAUGlrgWK8tv5XCahPkGU/oyeY17jB/
         w54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675240; x=1743280040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUP3DQjJ/dXe89wrBZFX6Om6Xaapd86HWCqzQXLuZT0=;
        b=ptMi8KqPKHgK7SkKVJgOYRkv8iQ0gGPvHefv3ubIdo7rasCKtIG5pglsweRZk75M8g
         v5T2klOKVO81Lyp7bSv+p2/z244Ve2C6dgldeu/gJUA+12cWiEhDei4o/cyaYgXNDPEP
         UvmvGkhex8V2ScNsigV2nPFc9gUvXpvpSVoJc3K3+0Bn450xN4ycgwdN1IsnDW2/WJXn
         EHLF21WV2nJbI1H287mvImTACJAde7FF26yqNRanIuOfIK+CSaGZuOyD+hjPtjcUrcl+
         RpnnZMWZbugYEEUJfb2Y2mImtF3YcbFQQ7VD55pHn3d07Jw3U9sUTM9Lzygx28Ckcbht
         2JHg==
X-Forwarded-Encrypted: i=1; AJvYcCXzObPdesPxluY2aIs+M9LgS6NGSKwTb9Q7y45QOjRsEJiJryP1ZlLyjvwx9Jtn+Td1BPfPfB9C+GJJnhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRjheNH7T+3fWxMNuxH5IJvTu/2FHkDvTtBt6JCa5An7n+s09
	fgROuPEOfWYaEluveH7t6pdtmQpaVTbIF74HRMUq/8/Vxwj6x7eXfuskUw19uSGC14PbD4wImda
	zmDFHqcTrtU+RgwjEC9UUYY3qXdIbHyAXWpdtcw==
X-Gm-Gg: ASbGncvM5j1pXD0PUi05wLlUUs0ld0vwUNb6uastdQl+bxROB727BqJP0uNeuVaV6n6
	ju81CQ2+c1uaSBye4g9PYdzrw9ZKg2bfBp/4zenVm0anLKkP9m10uCA/BUiLY3r0MLs+5Q9v3q4
	JFIozar181vaUpcXIPf9YmAYg=
X-Google-Smtp-Source: AGHT+IGjs1lPcfmsitI77IbFAv4/GOnlr9+rewkeZo6AtC1o9mj0yakxKkYZaayMrFUUwHvQ6Srt4iPmLjUSmKV75us=
X-Received: by 2002:a05:6512:32c1:b0:545:2a7f:8f79 with SMTP id
 2adb3069b0e04-54ad647f35dmr3155212e87.16.1742675240122; Sat, 22 Mar 2025
 13:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org> <20250321-gpio-todo-updates-v1-2-7b38f07110ee@linaro.org>
In-Reply-To: <20250321-gpio-todo-updates-v1-2-7b38f07110ee@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 22 Mar 2025 21:27:09 +0100
X-Gm-Features: AQ5f1JqNlso5uZmHyOD1DDqIoLojJa8I_dLEIDR5fwiXTSIa0XHLO3jhIkY98MQ
Message-ID: <CACRpkdaNix1mGkYcMURT24_9NRtEUtoKPAqXf4W-jL_0CrxB8w@mail.gmail.com>
Subject: Re: [PATCH 2/6] gpio: TODO: remove task duplication
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 4:49=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The removal of linux/gpio.h is already tracked by the item about
> converting drivers to using the descriptor-based API. Remove the
> duplicate.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

