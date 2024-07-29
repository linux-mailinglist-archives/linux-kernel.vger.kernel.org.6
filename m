Return-Path: <linux-kernel+bounces-265326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD0693EF90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CACD283B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435A313B295;
	Mon, 29 Jul 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TyGFGQ/Z"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4E12C46D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240763; cv=none; b=nQCP+eBMYLi0X7jNP1EYeJq3PUshpZR1m2P2nwUs9YBFq8bz9TVkNZXIerWxqpzhNC40iAn3DOjhsmRM/QwEfUCAoz7HJox9Lb/ueQn261yTd7q7kVNM2Kl8AQSypZ+uUadZSxRD1ZXEkyn3ePObq6WP1HeVttLIUDHro3DNjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240763; c=relaxed/simple;
	bh=vmbCOUmKZ1dFjF8DwS4l7Dx84hYJKYmzgXMywQQNOdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftn8c52kwtySHUNjCaLlcslPeRkOtjfqZhXN5aVzijYNoMOFcrGEKXzo5CNK32W2BPlImhvnnpkh7AiNvg3EKbaUEo9/cHYxpGZUNp92q0G9P1z0fJf2dAYxkwQtiwhV7CgsYoMs9aQ5z+8lmk7OH89HGyPozfyvfSkcD/MpIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TyGFGQ/Z; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52fcc56c882so2287707e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722240759; x=1722845559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgbLi1WuzrWYkt+kvg6tYyooxYHTBlvpYn0Wnr6oVFM=;
        b=TyGFGQ/ZcGpOSXwZb+5zdr1hjNZtCMyGR6bVXN8St4b2J7PJ/NbwTkjbIAHE9wLyCH
         DQ9/irDa+4IKrTV0SGoa7fUa6i9XMoivJ27aJNTgtFgw4fqHLp8NlxMt7WcMOt96EiGL
         TUtou8NZ3GHs+VBg8AdUy5DwT8CSFbDq0tvFZaxMc9LKi0571xEEOC3XZPZ6zvmNH3rH
         wAqREpBivm4GLboWAsacuygmvM06McLLRQEVx7XPhwYW9WVAFAEkqu2FFJ+5pGU+I/8E
         UZS4KvY6io79902C5YSO7J7hfq2Ij5fZgjyIH9YPEAG6vSSend0ab9ppIO5ihLDaiqB/
         8rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240759; x=1722845559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgbLi1WuzrWYkt+kvg6tYyooxYHTBlvpYn0Wnr6oVFM=;
        b=GA72gzEwtOP++ciSSgn+xeso/Tc8dxiema/QXWffslPeLrRw0a0QUOVhB7oL+tmQod
         wzZWxemo86z2cHD2m/kB6OJdukmP6jHFudD2eE7xZo9RaqPz8QWmDvrVTNAwRLIhhoOD
         Pg6LG06aAkzNxKLh44VezsrH3X+wn4rOQ1Ezu7KGSLjglwFS23SDhvcfbvmV4DQeEfkc
         8pk50T0wT9SFQWFskvM+36LhHMwKYoXVJCd+aah5dhiGq1mbPhZgHQ7xRHq1m0h+bhJj
         jlAidBEUJEBKGMUpPYd3Oo7kL5OV97CZNESsbP9KyDVm1fQsZTR6w0CPuuyUKqD1bLjl
         ppNg==
X-Forwarded-Encrypted: i=1; AJvYcCUjIjymU7DnWQNhJpZW+eGsi2RfutqVAolp752b68wUv052hO5LQK1E1VfweXtOeD+n5AeAfgQZ0W87zTvErPAuJ9Q6oTl1I9qjVYPx
X-Gm-Message-State: AOJu0YwYfrDuGPJncP5THA1gJuay3ScazELoKnHz0bVTrEXq5CxxL1Fj
	ARZtYSIv3hj2bd5azWkquHaNjR7YFF6HDTssMGS4jKG6PeHD0MyxGVQAxZ0wUyPiJssXncenrL6
	HQEhWDLcIB15wdTZSGzvJMaBBtWrigrwHkk56Jewiv5kf0uxd
X-Google-Smtp-Source: AGHT+IEpYgo+6X9lNxr1Sp8ZEgqfjm0yra5DVMaSzynDm065fn1Hei1MMr6+kuuUK8+GhzuRQj4R6RUR/dmGI8kwNY4=
X-Received: by 2002:ac2:46e9:0:b0:52c:d7d9:9ba4 with SMTP id
 2adb3069b0e04-5309b720abfmr1414105e87.31.1722240758621; Mon, 29 Jul 2024
 01:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-pwrseq-wcn-config-v1-1-021dce9f2513@redhat.com>
In-Reply-To: <20240725-pwrseq-wcn-config-v1-1-021dce9f2513@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 29 Jul 2024 10:12:27 +0200
Message-ID: <CAMRc=Mcop3+00G3kZo+dazpemuj0PjXNc_3+EiyFukLevBGd_A@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pwrseq-qcom-wcn: Depend on WCN36XX
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:28=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> This driver does sequencing for the hardware driven by WCN36XX, let's
> make it depend on that. Without WCN36XX, we're sequencing power for
> nothing.
>
> Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on t=
he QCom WCN chipsets")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> I *think* this makes sense, but if you disagree please let me know. I
> was sorting out configs in fedora and noticed this was being asked for
> builds that didn't have WCN36XX enabled, which seems odd to me at least.
> ---
>  drivers/power/sequencing/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/=
Kconfig
> index c9f1cdb665248..a4765cb33a80e 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -16,6 +16,7 @@ if POWER_SEQUENCING
>  config POWER_SEQUENCING_QCOM_WCN
>         tristate "Qualcomm WCN family PMU driver"
>         default m if ARCH_QCOM
> +       depends on WCN36XX
>         help
>           Say Y here to enable the power sequencing driver for Qualcomm
>           WCN Bluetooth/WLAN chipsets.
>
> ---
> base-commit: 2347b4c79f5e6cd3f4996e80c2d3c15f53006bf5
> change-id: 20240725-pwrseq-wcn-config-0b6668b5c620
>
> Best regards,
> --
> Andrew Halaney <ahalaney@redhat.com>
>

What if we want to disable the WLAN driver but keep the Bluetooth
driver enabled?

Bart

