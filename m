Return-Path: <linux-kernel+bounces-380533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94D39AF1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA1F286B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1671A21D645;
	Thu, 24 Oct 2024 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Mlz2NRvl"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70E21D64F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796927; cv=none; b=GhfMADOjRRAgRhfWrDXNC6f4Se8HDJsFQyUhiKvo/BPggczMWT2m/UaV8pyaZCVsclDNoVQHx5PpYKeRKWPu0eG918gJsaMPm3yoxQscvFDaYbz2vVAU8goT9KGPT5bdeWVAVY4bVQcSbOQYldXboOaybo3/HAIqUg5hJ6izQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796927; c=relaxed/simple;
	bh=1oBV9MFa74bMGZX2o5AX9rmJzxmvBtX4Am+9AipdS5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Blt5qxZLTic0nBVoECu6qQtFjr0HsoHb4vin31mgKE83zwo7nrpc+3Fpz3/LQwtrx/bVPFDLDey5to4KOVPblmdy84SWCalyJP3j5FWmoRXy9QHWGT1seREHNIO1eNc13bbCmw3V15ZxbYKNvN+/zDDZXtS41uSNQbl0T3zaVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Mlz2NRvl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1675328e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729796923; x=1730401723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r645Qxnyl2Ex1Oix5kiD2YpnuoJIjXTatXG75DVzH5o=;
        b=Mlz2NRvlHM+Zri8o0JP177o2CxI7P4wbNnLTPEv5ZRMvutENhyUF+8EZTFelTA3p6Y
         paYZE2CNE+sUFrp6HUXgrdSEc3y0o1gpZsIMLqab74W2NeFBIXNnFuLNG9c2WPCljB1K
         2xQtkf8Tm4JcYRXVqccGDCtSdwdRzo/6CKYeijkny3kYaPCAM5pD036GXFeVm09dqYp0
         wHWNs8XrBlfKRoQdN7d9FV288iWx0e/0fpiUS2LfakW9pZBtElNQwgvDd8luWyhJPl9l
         816et8o9xAkylTJrs6F5vq+l4SNwAq3VGAQntncqHTSu6u8k0i/yeB+7wmG/2xlCzTj9
         k/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796923; x=1730401723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r645Qxnyl2Ex1Oix5kiD2YpnuoJIjXTatXG75DVzH5o=;
        b=R5I7Tpvw00SNSp3RSRxsQ5/63ftpATEtUeWOhq5vUykHyvkfEUZCF6FOXdRp91bh+8
         dY2KB4qyl3j5q9h78prQzIZF79/hOHog9CohMYCVQzj4pKNoKSIB4IO9qkycdjENKAeV
         fRrsEm3xo8J6M3WHgXbi5BYIYYfa3rBA4HUNekImPjv5CVQjV8yL0FNsql1j/QayJwbx
         a8IS8CA/UxQCayP3Zmbo+697fxX/dMuPWu+QWsbvMU55EWdFyD9xg+ucOkA3KzM8AW52
         nuUEckaybeOe0Z3aLhP0p0leQmGcxzLf2FpptIRepq2dwXyKh3XaUa+e9zmqwqdwCKA2
         yQOQ==
X-Gm-Message-State: AOJu0Yye9gGFYNu6gzB5LJvB84nLQSaBDjB6PkKLwpcIv2W6cyn1Y7GL
	I7qCBfDxc1vkB49wq9jtwFZPsnB7rRszlcmlUzw+stVoBUhkRVLTGhvz6HTchmsMRBY2AZt6smS
	F9EEhh3nubKKBDYqH217eCohZNv2PVDuPUtLz6g==
X-Google-Smtp-Source: AGHT+IGiDkvMxZ32UFq5bOQeVAkZAs22E8/HAZ8pt0J+rDCSFQs8zuairVI8ForBhpHFvP1kbFDyBaqDrMrogcbokC4=
X-Received: by 2002:a05:6512:3da3:b0:539:ebb6:7b36 with SMTP id
 2adb3069b0e04-53b23e18b53mr1654982e87.25.1729796923387; Thu, 24 Oct 2024
 12:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014122551.116491-1-brgl@bgdev.pl>
In-Reply-To: <20241014122551.116491-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 24 Oct 2024 21:08:32 +0200
Message-ID: <CAMRc=MfscDCr8mdxSiC8zWUgdzdqLCo3=PKhuWhWueGoq_c82w@mail.gmail.com>
Subject: Re: [PATCH] mux: constify mux class
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 2:25=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> All class functions used here take a const pointer to the class
> structure so we can make the struct itself constant.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/mux/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 78c0022697ec..02be4ba37257 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -42,7 +42,7 @@ struct mux_state {
>         unsigned int state;
>  };
>
> -static struct class mux_class =3D {
> +static const struct class mux_class =3D {
>         .name =3D "mux",
>  };
>
> --
> 2.43.0
>

Gentle ping.

Bart

