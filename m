Return-Path: <linux-kernel+bounces-357434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516299712B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B535283AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718FA1E3DEA;
	Wed,  9 Oct 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4M/npAg"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689131E3780
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490241; cv=none; b=kXa3wM63SdachprCa427qSsy2YKPASZcdbaR813n27RD+RGAXIJEsZVxEHB7jgFICiC0ED00QP0fw0bIxc8YVq+rqea+4SrU/Cms1DCa/9VKmSFkUXB5oD7TuZeHro2c3xESeU4w3188wMXmOKpWGHQLl7vLmgwoZq2BLa+btgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490241; c=relaxed/simple;
	bh=WpPBiJG1FxgVYN0EzMa42iEUZ5HuJEObDWHpDzLify4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adV5KjjtQ4tWZIkBVYNni93RRFxHQPZg3BnLK9QMjZZOkzPIvcFL9FzWc5uYRkEVT1vnHaqvpOQWY/sOiorBc/BIva/a8U0W6tgDTM4mtXpiAILQ1e0/ZR2Vqy0/nD8nipzUPg0wQd/rjW6ewggG9hPb2VxBk4pEmhqw9U7xWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E4M/npAg; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28ee55190aso1785987276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728490239; x=1729095039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpPBiJG1FxgVYN0EzMa42iEUZ5HuJEObDWHpDzLify4=;
        b=E4M/npAgBXsh+b572PDy1dpFltu/dHdIkX8gig1NJIbH2nKL7k/1VJXUZkdJ47TbAP
         8nB66TpgWuxVy0vgvDsa9wbWtT80wnOvTeeVMQ6zZeeliYXHG1rNQaeZHAIMChsZzX4Q
         xLwkcS/kkAlsJTW92HYsW9IZYnc/0VhErBCTO5krnWcunKiatowazBCGKTAIE30EDw1q
         8QAvjLowEvJHWZm1HAa1Zv9MqKRoYnqoB+NwaoIur0gRpUgdB7nIkQ7SRK7qbg74btuI
         xl91rWVwB5o0RZZD18s8SZtR+JR0CRb2bDdb4mqoLnyQ+G4t/8pp7EBdDPnd6dhrLSfe
         J43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490239; x=1729095039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpPBiJG1FxgVYN0EzMa42iEUZ5HuJEObDWHpDzLify4=;
        b=FL/kuFBuLUtH9UbmpVQnUOcGDiwmThH2IQYttIuEFf72UWxWMedBhfLB4mgHavAxM7
         BVCBddGotUyrHN7P2Af+jcR0JIbMZsnJzn1QORtwYCo28oI6yQZ/fE094omhDxoDICQB
         EvqGfxiH4aLqFLnnSlEgNszSxQ9Ahzvw8NTx4cFtbkiCnDD9NsjreXcFDZ75zJ1d+9+e
         JIIxyXIWF6fY0ejwHgFkLp9A/O85eNEitXRuojTSZr7vs3+4xLM1MDQ/k6h0s2ggVM0X
         Tvjy4GDw7QfroRxE+x/JSR4YTU982W2I6RyVKqmd1aXIpaC0fA/dgiIcYz+yHwA9uzhW
         F68Q==
X-Forwarded-Encrypted: i=1; AJvYcCVS8Rr/YTtWI+xr23B59jdFlgDu6VdSby/07s8kVwx4Rh+tcgcil9dbIv7FPG7A9PVSP2lpsH7OuhClSPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJwJzOAFGLNWrd0SOmctBWVT834Sukk5ODcJmJRui5gVbtMDX
	X80uhvZk2gkAkButPGgk6uiNk5SnY8RMhOmm5Fjh4l2dErocE+0aQMrpVkB6RO2uLw1/A3X4C2I
	r47j8GpUxvGQ0rZOOCu4O/ce4MLx/CpXJtQ1ODg==
X-Google-Smtp-Source: AGHT+IEFBtpZ3WvYobxGDt8K8UtsEjGBDxxl67J4rgUcLmAq/lDuH7w1eKDsqRKmYjzTWAwbu3KplMgYow0uu5MiGE8=
X-Received: by 2002:a05:6902:168e:b0:e26:5b7:9f95 with SMTP id
 3f1490d57ef6-e28fe407701mr2803138276.35.1728490236507; Wed, 09 Oct 2024
 09:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004-gpio-notify-in-kernel-events-v1-0-8ac29e1df4fe@linaro.org>
 <20241004-gpio-notify-in-kernel-events-v1-3-8ac29e1df4fe@linaro.org>
In-Reply-To: <20241004-gpio-notify-in-kernel-events-v1-3-8ac29e1df4fe@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 18:10:24 +0200
Message-ID: <CACRpkdZpYLq3CH8yhfQhEwFPd88W2S-9ByfP+HsMZpEus0duhg@mail.gmail.com>
Subject: Re: [PATCH 3/5] gpio: cdev: update flags at once when reconfiguring
 from user-space
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:43=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Make updating the descriptor flags when reconfiguring from user-space
> consistent with the rest of the codebase: read the current state
> atomically, update it according to user's instructions and write it back
> atomically as well.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

