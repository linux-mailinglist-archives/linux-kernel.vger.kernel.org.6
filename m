Return-Path: <linux-kernel+bounces-361782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FA499ACEF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1245F1C24601
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7A1D14EE;
	Fri, 11 Oct 2024 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDYKxiEq"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F381D14E0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675784; cv=none; b=BdvpxIjyLi5v06rh+qr9PfxtZVc6kkDgzkPu64xCIRgldIaXB3GHCGUhhPE/MqTncnIPXA38iwfmjgRJAhnBmKJyUsLcgQdWOo2aGnH3zMMgWMoEVXzEm4YLbunyKyY62yoQBJ2xq27xJLwEaq//lMosma3QjxyxEZUlBeb2ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675784; c=relaxed/simple;
	bh=Z4mGyKRuHwJSE7Pu35pcjWjsO3tQ4Kmt6VPPAU76NaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5pRQkpuJ5E9EXz+DVmG6e8PRaoJG5a7BNVCCRvFxPKCoJgZUoo5Zh55z+cnoJx4IvDvbRklT1tqLsBnudGdOfXy7KGAgr9bx/DB5fvjOkyqE6cGYUpRvXtiYB/9K0rNMQeQlEY+XGg8F7OTg+ZXrq9jPMO3FYSmn+2pfArxuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hDYKxiEq; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2facf48157dso26547161fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675780; x=1729280580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4mGyKRuHwJSE7Pu35pcjWjsO3tQ4Kmt6VPPAU76NaM=;
        b=hDYKxiEqN9yOQcKHC5VT7uinwoM5wHKV95q+R92SSVKEZ/eEVlmX01JnD/LS/XS0FT
         l1qTLaX4d8w0teSkJKCwX3uW+8LvRWJCCEKHXWgMizQqb0WQSVQOkZsPqwPcUHOQods1
         A853NEVTpd3YWe/XGLvxIoHoNH+UM8EMSjRdbw2+t12vvcmK8tSdq29/spq8sRHA9cX/
         ze7Z8EeIVslPFTCOVzlGR6kJRrnTtrxQVPcj+0FOntO6oQTl55cKbqJNqJbchMhFOq1a
         ZEWLv5Df3hYctegTNeo27GwkwptuSp9k11RhwvDgeSFpwgVxHIliDLDJQU2BqLVJif0O
         9UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675780; x=1729280580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4mGyKRuHwJSE7Pu35pcjWjsO3tQ4Kmt6VPPAU76NaM=;
        b=BEe7XtLRObJH+TI57F2TfeJH3ciXlFM8AJBFbRtUbhQ5xd7SITzXfZegln+Gt9rzbQ
         YzYiHb+HrQIKsaWazMCRsvHS8Q2KCjnygZBS1UFRpjcs015w7rnuCOtuC703LQ1RyuSB
         pE4OJqyXGBJiyOctKo7rL3QGKp5DRs4RfwsoJgaBgtQnTtX4o5GbryMF6P9J0x4SR616
         ueQtjsfux6TjQCSkAOt4aSvFNMOY7idW92YEYzMrL/LMkoo4Ipfs6yp1K9+vNgINmsw1
         gGeeyXskbV4fQ7I4AoDeZP5zWNNi5ibDE5421pJdX+A/qZPlCBMPFtXMPcJO131uUq8j
         W/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD/QebKFXKUjfNN4zxQzeIhu8y+b1LyoGZAxmMkzr5+dfUxCvkyOarCtvUhK2NtWt2nNH2C0BhAs66dKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4EAvvDdlpAhEqzk4TYB9TqWE2Sj7fXQlczygnR/AQXEx3KZf3
	FGH1Y7ajra01W1hrJlDEEXoPjOggedjehxxwljXAUHBc2e7Ed8YhQuFM+7h4bYS3zDt/Khene8j
	o1vbRZTpwosaePjhGwDH5MOBZbKmq/elnCsEEZQ==
X-Google-Smtp-Source: AGHT+IHRGAZsA+c1JXEg3W3KPXi0hIwPisQdkgCI+x9zqe4NPFOofTaKNVlDEm43Unh6AnUT1JuS+cEBd8UuORylf0g=
X-Received: by 2002:a2e:a9a7:0:b0:2fa:ccae:d1c5 with SMTP id
 38308e7fff4ca-2fb32718b5bmr18751141fa.10.1728675780464; Fri, 11 Oct 2024
 12:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007102859.35602-1-brgl@bgdev.pl>
In-Reply-To: <20241007102859.35602-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:42:49 +0200
Message-ID: <CACRpkdY1RdECagx-TrE3t7dsgqKcUiVY8B5OKTzmMupnYrHVAA@mail.gmail.com>
Subject: Re: [PATCH] gpio: eic-sprd: use generic device_get_match_data()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There's no need to use the OF-specific variant to get the match data.
> Switch to using device_get_match_data() instead.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

