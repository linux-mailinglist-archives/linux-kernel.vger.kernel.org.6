Return-Path: <linux-kernel+bounces-350259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DB99024F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6A328486D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4415B54A;
	Fri,  4 Oct 2024 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjR8GugK"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947DD15A842
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042304; cv=none; b=maGZuD+KksXdAyHWetETiOxUqsxMo/FmFaw45VsqJ2b49/hCk9SV4TqE494FPsfgSWfZUTyS1UgXGnJJFTR6NzKz7GegRjXG+F8u4KOLf0tsSxeNPutvBSYV0gVUodjQEXnBLqythRf5gYaDpOhzXiXDE+M31mZIFB4jgUy4NPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042304; c=relaxed/simple;
	bh=ddGvXf1L/Fq3c4RMPyxrOA14cqgWI9P90J4zJ4pJs4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQ+lOvrNxltrMwXA3zrehqgvIrUbx+qvvjs5aPwLKlRieD8Q9Z0AMfjLJ456fprGvGo2t3PtwA0kr9zIwdA2dr6hrIlpOSU7RZZh6FV1zH/bCEEPCRoXzEELyFIkiiPKAZns80+yx869nvczDpen5pK9rSSKzXERGgONPKBvBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HjR8GugK; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2faccada15bso20988851fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728042299; x=1728647099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Khwkr05lsMPVSpq7TCjaX0gPVi7sWovxm4CAOdt4/3s=;
        b=HjR8GugKRCDjLPeodO8HloyjgQ1OLPxVoLDlQlXKO2iSZOkvjJy0DTvLv2+4rxk8A2
         9QtantMsXz4bxkjCWgpec8Nhg9JuUgDOeTjdVEFVgGtnNqcOMvwq36OgW1nPFYPT2760
         H7fUVJRbq7EXeYfn7sEZMaTr1OYR5cJZuYS+tpPdlNKEtALPfKBeh9XkJ/e0Ta61XMXh
         c6QGKeRXtjX5gB1uBpNfUrarXzxpsKiV52MAsiv86aduOF4HO7FMIT67lAttqYVjp6Ak
         EoeC3GBL1oqtoKOPwM9D7toIcqNiuokz8gBOFcgK6dl/x0Xsbosk7zgOdMuVK+3hc5uu
         If+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728042299; x=1728647099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Khwkr05lsMPVSpq7TCjaX0gPVi7sWovxm4CAOdt4/3s=;
        b=Wp7Xuo/jplAG6ZtNjVN2sdIMef2wR4nxfAJKR1Ye4Vudh1V/BB7JVkh1TRcLi+4skh
         nYGm9JxFjlW+x9Qara5jxn+buwiBHCzIi8208lMkClKTbUcQy3vmGCr2pVrOClmHofGJ
         3LkNaGhSDqdwk85Z9IKOXD9awL/3Y5XOXbtYKnZmHSoeL0MYFhIvqv2ITNvqhP4JkQIw
         fAl5K6TsXsKYj/CUNmK6GNXgU/7NEWRA4fu8qZkQZt1XsarJEVHunGG2zWG2A80VyvQi
         bD4V96rFH9eSE+SywHhqy00Qb4JFlqB8KvyOm4BqYpyTCUyRuPPvFudScee+343Qu4q3
         CAtg==
X-Forwarded-Encrypted: i=1; AJvYcCVTXFO3Qc7BuCffEOIeyTWbITthqSyJQsXEuW9UFdecqH3JYro0HxOA4ozC8PZYia7ShYPLm0O0JWdGXYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQWbq6gjct0vUnQ6v3bFAak9ZrYm8G4fapI/k2D60cfzwWntJ
	4JxyQcJcEafQsh2njukr9pBZ2PULEuh7pxnLlGl/bpSFC8piOuHodxUUe5sTYjLQicmoRmiIxJ5
	vFnuE79p7yvCYxGtprFPUKWcnttQLPUaG5zE+dg==
X-Google-Smtp-Source: AGHT+IGiTQzYERLjm/jzUGh/crV6ATYuQpv4nXIEVrS7JrXOOcQzJB/z1NXK08Yox/oqqZ9WwDQ8tFMFsN0Zrte3h1I=
X-Received: by 2002:a05:651c:b22:b0:2fa:d4c1:3b6b with SMTP id
 38308e7fff4ca-2faf3d74e2cmr12168961fa.33.1728042299452; Fri, 04 Oct 2024
 04:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002232804.3867-1-exxxxkc@getgoogleoff.me> <20241002232804.3867-5-exxxxkc@getgoogleoff.me>
In-Reply-To: <20241002232804.3867-5-exxxxkc@getgoogleoff.me>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Oct 2024 13:44:47 +0200
Message-ID: <CACRpkdZnBBAEgHZ=HShwvaXaN-6icC5hzwHqDNWWy_PKJDh+Fw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] pinctrl: qcom: ipq5018: allow it to be bulid on arm32
To: Karl Chan <exxxxkc@getgoogleoff.me>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 1:29=E2=80=AFAM Karl Chan <exxxxkc@getgoogleoff.me> =
wrote:

> There are some ipq5018 based device's firmware only can able to boot
> arm32 but the pinctrl driver dont allow it to be compiled on
> arm32.Therefore this patch needed for those devices.
>
> Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
(...)
> -       depends on ARM64 || COMPILE_TEST
> +       depends on ARM || ARM64 || COMPILE_TEST

Can we get some more context for this?

Is this another one of those cases where the SoC is actually a
64bit core but vendors just choose to run it in 32bit mode because
that is what they want or what is the reason here? AFAIK
IPQ5018 is always Cortex-A53?

I just want to know if this is something we should encourage
or leave out-of-tree.

Yours,
Linus Walleij

