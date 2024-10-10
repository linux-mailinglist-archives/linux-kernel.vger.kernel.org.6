Return-Path: <linux-kernel+bounces-359975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD3499932A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE871C24186
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565491EF941;
	Thu, 10 Oct 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nxYefYcj"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAA1EF0BC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589729; cv=none; b=mUZseJ8z8RINKkLfRyk64e4GWBwpoUyVVYByvOcKMhsfBszCR6Y4FOXW2+ZZOLOJ02hhC/A/rb2t4D/hhkHrnxp8r+bQXgY+46pxInIazldVfrn3Mmcfkcuou2fmSXIB0/qkrZgHRVpbkFo+qlr0WHLy4nHPHsfb0iZG1JQe3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589729; c=relaxed/simple;
	bh=JQl4nr5XimfNaCyJy1JJbcPwGYBNhM8jVGMULOks3t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SI0S3ee89WyEdcCbcEkngjREYc9fPQVgN05+0aZ0FMeRuDgHtllPPy9Zundi3pXr9w1pzMsczAMwPXtPAKGV0JImQPBg/GM2Nmbf9FwgdJdIun2xZuIPVJvMT2S/c0dl3/1WEV9PmTwVucThYNmPvCoyADNIS14lHUAsNUTS54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nxYefYcj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso12549721fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728589726; x=1729194526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQl4nr5XimfNaCyJy1JJbcPwGYBNhM8jVGMULOks3t0=;
        b=nxYefYcjLq5AYNKDzmXEcTbUDrXVZVwoOy6SpuaGmyq70UDKQWf6In6l1MjaP8qAL/
         u7iYp2l6ZFFExjlIH0JjDvGrY4mtFj3wLzGN2T6bBpl2FQkjNEMGgqk/D/wBVYMLVnvA
         TA/4IX2HKkgjF8U+bNcIEWo3EDE4QwTtR6NzvO7oMTi6UhvjMY0TMIB3eS4U+sqXQkLi
         TULEnYHGl/YDcu48a0uZEVvKS7vadQ68jiXO/zkMNzikvHob7OcXmcjzxPpCeOU0oyYN
         zu/0lqnEIirSHJ0xTa9kX49/U2Z9IIdMD0do2XhZcAx5cnPYD3VQQItuZdF83oG/iSgG
         UMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589726; x=1729194526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQl4nr5XimfNaCyJy1JJbcPwGYBNhM8jVGMULOks3t0=;
        b=d2zqKkT+1iN1UARWhq1/zsuoD6ftby4fSKXdhN3n3SfyPTuPOdGw639C5H1WnHLn0a
         Llg/8nuLOAaqlG3ys4M/gpojTrm69Aikfrpd66TvUwf9pWSONB7io0nwxlKI8UnLMx6z
         JadYmLUy29m79Dit3tY5bTjdlbEO51d/6PajHa6yTHBWbEmXPRAEpt4pZomChZrpzWJa
         CKXqbqku7ZocylaNBmFLiw03bheUSWPnqn+dJ/qchq9ejD6gtb7VKVsfzFVlq5YbMMk2
         1iLmYoNiR2fbrbf/JVLsU5mxJigNceLGcpvaWjgpQ4YHeiAc2mqGrx6JGGjiCDe7rFTR
         zd8w==
X-Forwarded-Encrypted: i=1; AJvYcCXS4seauxcouGid+kdYCBnC5uz8rwGuNbag0m9p9lYZmlHLKCdgRcnKD/79Sjmh4aivgIqOOlsPNYpHW0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YybIaMDoPmPN0vDtqK6EEncquRhLNNeYaqZkmNgM83i8uUkn+Hr
	B69K/pdiQ1pXe432DLQpZHMIQoVhAuqQII9JV9YT+BgxiYZktqRS7ZuvZDIOKW9ifcmMdnF0Ad0
	3XwH3cuyEOfScfjjxhOHWR61yhsiQFjh/sR59Lg==
X-Google-Smtp-Source: AGHT+IGf0dM1WdwOxyQ8A3S4ILGbdKKzM2JFU6HjgbDv5v9ONYKpi21B+BClHB+QQReWoMXs66LsZAqcQm7rnOD+QH8=
X-Received: by 2002:a2e:be26:0:b0:2fa:d354:1435 with SMTP id
 38308e7fff4ca-2fb2f225ce9mr3907701fa.0.1728589725621; Thu, 10 Oct 2024
 12:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010080432.7781-1-brgl@bgdev.pl>
In-Reply-To: <20241010080432.7781-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 21:48:34 +0200
Message-ID: <CACRpkdYz1_pMNkqJJFWRo-v4LP2MDQGr6yJVD3xn809nQAfRfA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: zynqmp: drop excess struct member description
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Michal Simek <michal.simek@amd.com>, 
	Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:04=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The 'node' member has never been part of this structure so drop its
> description.
>
> Fixes: 8b242ca700f8 ("pinctrl: Add Xilinx ZynqMP pinctrl driver support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patch applied!

Yours,
Linus Walleij

