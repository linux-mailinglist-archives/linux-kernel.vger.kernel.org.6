Return-Path: <linux-kernel+bounces-510767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FDCA321A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6847F18897DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D83205AA3;
	Wed, 12 Feb 2025 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FLGNpVa1"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE061E7C07
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350968; cv=none; b=XfvYkrvE6WVVDw8c8gPs94E7oEZBtaGeEKHJd6R8C4K135pxuSvzr4PhmPfft13CR1jrQ8il1QmmNRlWiThcDw3cJHya8t2F2KfxZ4mHSyFBwZCBzm67VEr282iFigFPwl7xyxYAjdXw44N/mEcv99HFI7bGX4YSumTJ1qiBvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350968; c=relaxed/simple;
	bh=bjupXERTNnxWN8Rzu7+1ntmtPDezv/on4BH1aBU3yKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZE58II6QIQY0/43oiH1Wky7t+i6PwTJdWytkjlbABKPZzBJGq4rqqB8eT99or/OYWnI/AWXT/ZATeLUFroKHWwFIzhqw+zJP7OmDWGnuZaI+GlgQATnssMKUNHJTsxo3jFa5oWi1yLs82sjrvcXC/IIQsQMe7FiReKPWsg7csCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FLGNpVa1; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-309025ec288so9563621fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739350965; x=1739955765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f16dueEN6EAXOszY3Uq+eQwKmeyE3XKAbudGP1w2udw=;
        b=FLGNpVa13HDBv29M1vUNoNVtLFEFJ3UPNDazvM7rY6Pcwlqnox+wZNoLSgH161KY+c
         bYi1mvo7adK2M+bgYeamAJsuv5b3qSWQpIGTHt7LksV6P4IWL3QojOJPWQP/hLFttV0w
         ztPFNq/ksFnbHQ0VMqmt/on3IRSUco/L2PKl8Sljt63U2QBnaO6cTxzSSTXb5rTTs+0F
         +k8LlHhhcKhanK+BceCduEEN9EJ5AyT+/N8rZq4bJEsGcD4r7RwLRBiy9JRSk8V6XUa4
         wW/GQollHOqcW5gmR9Z2Lkda7i24ozDgkbBbJjtrOnYHaKzt49urk3xXn6BCNtl8aash
         78xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739350965; x=1739955765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f16dueEN6EAXOszY3Uq+eQwKmeyE3XKAbudGP1w2udw=;
        b=tpXySw/XuLHYvjXCOX5OSiC3awEmAMbSUtS+zy2Yq4NiQbHt9dqHm1/1VjpEmDFM1v
         VVwgrP4QcdS14MikWbcGxUrQuEHrVsY0lHehAdWSF8ilqztZJaQ9NFBNXKeGYH9WXTHk
         8n4ORvAef4xvvkvd0Q0NE7Bvr328orSd2cSAMIdylUy3VkxaaXPTCpBNVWxqR0gLATnN
         ymO/1MoVz6G0blGjW7L+fVhUCCQNarUH/zJiDPRulQ2sIKlWZPybFP3K/MRqKgwxMT5l
         eAJeMOxr3ktvr08G+T30FdpSYRgPzm4peX8LmqRRTSuxPpzTHdsJ/Pp3KxrAJF/bIx7H
         FcIA==
X-Forwarded-Encrypted: i=1; AJvYcCUqBUbDpAgOL8xp+WlqVH/N0aETQqFPcOx3jzPdttIAMt6fZ4WmLkVyJZRr7DAmIBVqisA+iD9XKY+0QUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzNLfguY6Uiaj0nlhxGNUbXokl/4PKbu6EOdliqy0JX6Yqetzx
	El95IHunf3TP0Ep8dQrAJ/GGVMABE2LFx9kOwPqD2IMCY+J5HizogFi9m/gL+1DaN3/ca45xogP
	wbU97BCimUOpUX97Qes3BToBF8TU5kQjmzbKCKcryokDSXAVNGhs=
X-Gm-Gg: ASbGnctztToe8LR1TWwNt7wDaMiH0MMkvn0La4uUWLoL/b3UqpLBgo/viwfk0uVugQj
	zkqxXU40E7WHnYawhN1b/d2XS54UG4YgXtTqeqggvm6WStoqh4pHr2V4MkZyP9M66DgRsuH8kTH
	Jd5ONgzFyzhlVU4AfkMPtRuIEyxsUk
X-Google-Smtp-Source: AGHT+IGyt9LAYXtY0vl7YRuakFNZNHFEFcX3+aygjTndiNf8GdUnYyRJTUcNhdM3AW4HKXb8eBW/OlEvBJQgal4A5ok=
X-Received: by 2002:a2e:b887:0:b0:2ff:d49f:dd4b with SMTP id
 38308e7fff4ca-309037c13c9mr8178331fa.15.1739350964874; Wed, 12 Feb 2025
 01:02:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212085918.6902-1-brgl@bgdev.pl>
In-Reply-To: <20250212085918.6902-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Feb 2025 10:02:33 +0100
X-Gm-Features: AWEUYZk42gdDxUmeHlnhGyrIolknPsut41eqkbz6n5Iee392aw8-WxpqAAXVDIo
Message-ID: <CAMRc=MdFwe2onYhwY__n-kAOSrXKKDWJ38hpbYb0711Nx60DHw@mail.gmail.com>
Subject: Re: [PATCH] leds: aw200xx: don't use return with gpiod_set_value() variants
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 9:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> While it now returns void, it will soon be converted to return an
> integer instead. Don't do `return gpiod_set...`.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502121512.CmoMg9Q7-lkp@i=
ntel.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/leds/leds-aw200xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
> index 08cca128458c..fe223d363a5d 100644
> --- a/drivers/leds/leds-aw200xx.c
> +++ b/drivers/leds/leds-aw200xx.c
> @@ -379,7 +379,7 @@ static void aw200xx_enable(const struct aw200xx *cons=
t chip)
>
>  static void aw200xx_disable(const struct aw200xx *const chip)
>  {
> -       return gpiod_set_value_cansleep(chip->hwen, 0);
> +       gpiod_set_value_cansleep(chip->hwen, 0);
>  }
>
>  static int aw200xx_probe_get_display_rows(struct device *dev,
> --
> 2.45.2
>

Lee, Pavel:

If this is OK for you, can you please provide me with an immutable
branch so that I can pull it into the GPIO tree? It seems it's the
only such use-case in the tree apart from the gpio.h header that I can
fix locally. Alternatively you can just Ack this and let me take it
through the GPIO tree.

Bartosz

