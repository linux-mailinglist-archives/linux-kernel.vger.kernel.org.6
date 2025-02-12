Return-Path: <linux-kernel+bounces-511176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB96A3274C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274A81888035
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8520E715;
	Wed, 12 Feb 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="u3eew65Y"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7A20AF89
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367693; cv=none; b=Bj+1IhjKGcACpmXMC/WcwLQ92szmP7Mujvu2tKSPTVGGBeJDNCHt4jb4wIlSC6KaBXqodbiQZBZFVae1RvCZ7wD8s3Vf/4XFObg91MC1lxP5Tyr94i1gXd4ZLeQEuEs5m+UnhMwjPiOAn2XpID5bSkLeMwVTMbTi1nGTUL8E52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367693; c=relaxed/simple;
	bh=2CTLfdBdfTu0vH8KNTtXTuFNXRv7qZT8sUXi/tpcPmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNvdDFi9KKFFAnwgd7HaOOS4LR/RUa7xRZt9CO8foY4kmMSkF+fN+g+eOYJvu+z3SzKiLIS+r8pEO+XZpVaUvo/BxkD5yPs4OQiPs4wReGnR/R7jfA2+gkFhuS4cgIxWyV2gfFsYqs5UPU6nb6wdpVeY39/dS3eeegQb+adUkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=u3eew65Y; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5450475df18so4674387e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739367688; x=1739972488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFW7Zf/G9aYLbYdFAgCdEU0qw4fsxOkvthrfUHE9V4g=;
        b=u3eew65Y3NlzcFP7XCtU7J3F8An42gJHBlvusFbQpjLD3baXR+M/hH6TQ61cdIEFYs
         j3R40ZOqaRLXKov83edYD1GQEkwNhg+pNIC3fwPEwPQtO6aWL8V76XdtHgFuRf5CLuQJ
         gAbmy0OcBmD6d0kc73WBPAAVAv3cudgreNooNpy5cQuWug54jK8MQl8J4/hIuE9THy2r
         EYkSYO2zt2O9BRkodNPHaCIw1wOh5USJ5ezZXaVVAzv1jKBXR2gJ7hAFHp1CZVvEhvIC
         39M0fTPdfWzVf9Shcxw8OPbJH5zurLKMrlAaCVnU1VM5upuDwgkkUMzP7B1h0v4OhynU
         yhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367688; x=1739972488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFW7Zf/G9aYLbYdFAgCdEU0qw4fsxOkvthrfUHE9V4g=;
        b=MtaZmngiRXPt7LoqPzv2Goo4YojEBxVjW6doLpoDjh1pzewwSpDZ/M8BxiPnFwtVLz
         Q1L9JvW0ghhyyaLRWfPhSvzvkSaBOdpq3kq0N5wIc61IAX1Jz8/y8tHWnQnbz1JbFMpk
         Qz1u58ANDt+D0MksLnKG6RomaN6HJebRxVPybZ1co51HIfEpUug12GzsFYj7jiW+ml6i
         tyolRmu85s8KR9K/rUm1rdHRiIIAE+U4WbuRHhDTc2V54ZCPSnIBk1tulIqVIpaKnL0M
         g8KK+wu/9VSAQ5PUaxcH1gLzRLixcWvurkvNKw1z9PdGUQ0t6QO/p6O0egpLJuBdvsJH
         bWWg==
X-Forwarded-Encrypted: i=1; AJvYcCXF/rOVsMkhoE7rawEtyGaWIheADbYYXLzhaikNbpaaLT9YqpoA62qoclmMpF/fBAqEliqogg4kW2UNYGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWw40tYXWa0I1dcwXRkS3lYYmDY6RZK9HRljhryvNo6e/xZNwK
	KpsSS45KNejof0jJxTWhlAadcTCSdgUuwcXITrZ6E6IjZgwuhFRCG0QmnHMdqBu52qeT+gWnRNX
	ThlpQSl8DGn9byw/L1WKao5/pzTeNeAgEQEOt9QBplVYB7A0rb2A=
X-Gm-Gg: ASbGncsP8K3dcCwmby8l+WLq6dvuQDsxraAWXx85MT1samoPp8gdDp2fuv6ZQ6C9xAC
	YXHamICtP8iT4L5Td/3OQweGmnAy/9sslYQMfIRJ+D3Sc2l0AZzc0rd8oiGITCwmsjmy1LMR2GL
	odIEaYQTiMJG1sH5H6RUIKbVbpraYI
X-Google-Smtp-Source: AGHT+IGUG4BxYF8PfiDJLuPEPwUA/0Cj1U6h+A36XHcqDet0ky/ms2/iEljBU5tRlJ7+cCE69odWLx46YJvzJDTyeZA=
X-Received: by 2002:a05:6512:159d:b0:545:ee3:f3c7 with SMTP id
 2adb3069b0e04-54518116604mr1078573e87.30.1739367687512; Wed, 12 Feb 2025
 05:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207151149.2119765-1-andriy.shevchenko@linux.intel.com> <20250207151149.2119765-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250207151149.2119765-4-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Feb 2025 14:41:16 +0100
X-Gm-Features: AWEUYZkgSVoql_Wb24JaohMVS1BV24troUxuieR-cx43nm9CPoG_I9p7yv1dJkU
Message-ID: <CAMRc=MdDXY4vLSO0+ubanGxO3=wE+MEvcUM96X-0UsS=q1MDbA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpiolib: Switch to use for_each_if() helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 4:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The for_each_*() APIs that are conditional can be written shorter and
> less error prone with for_each_if() helper in use. Switch them to use
> this helper.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/gpio/driver.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index ae93f75170f2..a7e9c1d3df71 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -532,6 +532,7 @@ struct gpio_chip {
>
>  char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)=
;
>
> +#define for_each_if(condition) if (!(condition)) {} else

This is already defined in drm/drm_util.h. Please move it out of there
and make it available globally instead of duplicating.

Bart

