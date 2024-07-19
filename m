Return-Path: <linux-kernel+bounces-257051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B2937490
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBA2B213BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAFA5820E;
	Fri, 19 Jul 2024 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R82ZM7YF"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE222C80
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721375529; cv=none; b=P9XbvhgMQS9A8e31b6TR/Ou9TeXT9Vu4XkIf6iOwlzITHHcx1Zic3art9vrnRGsmV9DQhgxJMwPYuC81VgyPvK4W+fdFlWrh9aL5kuyQevgcPrZpmBtTcw14IGFRmWZVkfJbucvvqhfxzV6S/59YUHMPbeQHeTJXYxQqqZTDLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721375529; c=relaxed/simple;
	bh=LKAiCiA/dFPOV5JfdYDFRY7Pm2EA15pBOnSNdRFyjBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYshj4a/v9C5dFTBR7DGzxuQrbWuuMqZ11XhOOCUAVJbR2xvr7bjQPQl0gz+DVVuP2p2gH1YR9/ivzrGPofbDPXJ26OETcFnm8jxEe7+YdNT5TBqp0BspkbPVC3Bk5iR3rpvm18qTkjZPc6Exy2RzlCt7wJWQGBZNZCG/RI9OxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R82ZM7YF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee910d6a9eso13780521fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721375525; x=1721980325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+y5yIpCdEbqniHO1UZtJ2OddYwwRySHmKdPncfIHis=;
        b=R82ZM7YFHnKYXnlmOcmUWNr3Am9SPnfXlBv1KVN/idMDIMqEpwNsVril/RYI84PlFh
         iIJwoWlLeS47a7X7NQmkIuKezsyBVHTBWcB4qm3gaBOmojPy5zJYcCtYgJjH4SyVGTS4
         mdrndWwCI+uw7iWzgUrm97E42kivtVqApn1utQ8sV7oMB4aVbrlWAm1nY4u8hiPzbstK
         P+/ndKCaSQDm3sEhayLyjwwhNuE8N3Xq80vulfK98QhzNNf6mPUPEbUyVfEkY6VAD2vi
         YAH6m7Lvwco+o1UCOlv5aSBn85TAlHM8Ra6QdG0pxof39kOJ1GokYkVvW256iAxi5clo
         0vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721375525; x=1721980325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+y5yIpCdEbqniHO1UZtJ2OddYwwRySHmKdPncfIHis=;
        b=PIpWwvFPMHS2J8qWUZ+oXPYRfQA0W0Ep9oUwkj05pyLqjLkZoxFwtlUtPRZYuukVUM
         9q7ZnAo530gvXWSNKsMQhOWbwK9qJyJJmIPkiXZsbFddfglLbZcRpxXGuRVNnjWa7XYI
         TEFr5iS9ZfklTOk354FvVrQzNjNSdckgU/zlMljEwYGQZpwgO9wF7gaEgE2Th6xuCfHe
         8g2E3LMyEW3Y2SiS5pYS3QU48Rp3QH3xg2Ul9J2BBRZr6yHpCf89Av3B4LVccvfo6kUU
         3B455oKhPwxYvYGgn9Ea1EmZCQWFO1D+AYLHMYHj5jS4wvEKWv9sn2rQFz7AcaoAqhxs
         UbQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyTojDrsHXKZ6X7b4EFrD3fEl6ckPOaHpfNMaCPAQgfL/gW7wDjgrvdG5RvhCZl/EsHxSgnrFHaPBZMymgIwDjvEYFRCw/pqKoWDMV
X-Gm-Message-State: AOJu0YwmFuyiQ7cyQ5vV5CPjt2caJms3sOhwAGESYO0df+rX5PGYTD5r
	eqQHQ2D1Fm6RBAgTSAEfcDPQTrepZZxFg1GJerGbbZCtn7p5KFusPc6rryhNLckWP2PNxkc1cuD
	VoE9ZJ/nDgi80DOIAY41izRXaZSDz2/59qqicFA==
X-Google-Smtp-Source: AGHT+IHSqV1WxRx2XX73sp9ZCMmPfQMeb8/GMzOthRSfqwOVAwI5qeyO6RU4d70KEH3IvQBTkJ7gBEQEr2HhCcat5M0=
X-Received: by 2002:a2e:878c:0:b0:2ee:7af7:ac21 with SMTP id
 38308e7fff4ca-2ef06350d32mr15071081fa.7.1721375525022; Fri, 19 Jul 2024
 00:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719072813.1844151-1-arnd@kernel.org>
In-Reply-To: <20240719072813.1844151-1-arnd@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 19 Jul 2024 09:51:53 +0200
Message-ID: <CAMRc=Me3SWwh6aS=0c7tD0EeA=Wxs8Y6e-ZREvJErHdPdJBKuA@mail.gmail.com>
Subject: Re: [PATCH] arm64: qcom: don't select HAVE_PWRCTL when PCI=n
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:28=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The new HAVE_PWRCTL option is defined in the PCI subsystem, so
> selecting it unconditionally when PCI is disabled causes a harmless
> warning:
>
> WARNING: unmet direct dependencies detected for HAVE_PWRCTL
>   Depends on [n]: PCI [=3Dn]
>   Selected by [y]:
>   - ARCH_QCOM [=3Dy]
>
> Add 'if PCI' in the qualcomm platform to hide the warning.
>
> Fixes: ed70aaac7c35 ("Kconfig: reduce the amount of power sequencing nois=
e")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig.platforms | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 9b62c63781ec..6c6d11536b42 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -266,7 +266,7 @@ config ARCH_QCOM
>         bool "Qualcomm Platforms"
>         select GPIOLIB
>         select PINCTRL
> -       select HAVE_PWRCTL
> +       select HAVE_PWRCTL if PCI
>         help
>           This enables support for the ARMv8 based Qualcomm chipsets.
>
> --
> 2.39.2
>
>

I applied it manually. For some reason b4 cannot grab this from lore.

Bartosz

