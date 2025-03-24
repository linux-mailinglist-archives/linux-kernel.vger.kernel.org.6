Return-Path: <linux-kernel+bounces-573271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980D1A6D51B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EFD3A7EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D14019644B;
	Mon, 24 Mar 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMS8LhNq"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56F175D48
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801464; cv=none; b=ezGU3h6NpbpztVz6Ffymc6violMI8SI21X8cILgFbITJMsBg6mv59zHeD1D6CrqiRsoId7strpKnWE5UnLlkaqo+Qd9KzFbxEXceZuJwGNeSuuOWO6kQL7yqN8qscrVrGvUtJt1TitIQeRjX35n8TLNXtVYN+odRjSeqjlCfclE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801464; c=relaxed/simple;
	bh=wFVPP9vrm/IpUuXPozdTr3WZBrU9bbE4t2LjemtCNYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQbSt3YPvjKhQQX8BZeCRpd3/3G63R78gW4z61biAtQd7ULiUSVzQIN4nq8VfX6ezW8D7COjQ2w2SQpAhwBK3jjNbkyxJ2aOMVN4YRJvHT7lX9Vw/4tDGsXajuQ+RehO6AqY0X9yS8zgrwKRzkfZMuNWPSbZVrhrs6J0IwI0XLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PMS8LhNq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549644ae382so5122798e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742801460; x=1743406260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LADn1kANv9yfbuyperCIqqOS/gvroECf2fXmlFm+UsU=;
        b=PMS8LhNq7rRUO385P4lXW0rU9qKg8qHy7iNAP14PbUvuYpHdJwsPafAvU7mBZkAt74
         oZ63my8crKLFLangHhp2bbcP1ZbXRVFz/gcX8kqTttN1DJMS47ItXCAvv5dJBgvyJB+W
         xp36pG1IoP1D/qW0HQOt7rq/Ept4rYSUHshiI069ahdLD7t0GQcg6XuzfzIj5zE1rtJH
         CX6lLcnrUJAGd0RSkFU0nPcO5VF9EVsYnUjx9of1q4Hy5fT2Ex4WcUWyC1zMvARoJzpm
         c1GCCMbcLYyQn5RO+ki9PI7byFYbfPZFCIkmmB9yIsVIkKkmbbETnfzLTr1c8wa10tLv
         aqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742801460; x=1743406260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LADn1kANv9yfbuyperCIqqOS/gvroECf2fXmlFm+UsU=;
        b=Hm/t2uelgKkYeGyqUNXVdIMr6G5vjhYBjNdr8PHzz/qISsjZX2zC/PN41GaAr4kKS4
         +Tzr1wW0/7Mbq2Z8l0GJMoUk4g5Hsr492g8ys9CM05C90AIb8I5wa+oJqpEwY/pnHyVk
         hqgMCqrEfeNCd2dCL0lhskv2vcaOqpoTI0ex+GBM41h5v5pUmPfaTJg+zSkwJrIX5ji5
         tHzbDIYvmKYCaAZNPcLZH788L9rIQvE5J41Ad+HaGME7pm3zy3g6HCyPJf3iw0LlHuTM
         6h9cM7Xc1ZT4JMQEJ9rodwI/EtKYWSYtP2GkcNOoIw/tsl8HqK4hi+zxZOeOkLDpi6sw
         uoBg==
X-Forwarded-Encrypted: i=1; AJvYcCW33KCeyXb0JAeouhTJgTsP1PS9072zjU39kesYdTdfhwf4XQCwFLX3d1uCV0JA+BjGVitfsWaw9rk4No4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9c7Pgw+TWpXmbev8kA2RkpEz7K1EQp84acYG1quIHtkXaW/me
	afuK1pgwCuJ0S4t5DSdcdYtOvUF1JfM/5sYuqpnG2N1BwqCNWT3ZNlqAGi2VEocYTxleQkCzVsS
	7jSiCrwN8gp6rd123bF0Chz5gPH2RF1ya1n0b1A==
X-Gm-Gg: ASbGncutJeuiL9egpbIobLl1M6ufw3wdrxYGpI9mCO42YTIa5N7EzKP/NPOyMFrjZpf
	/8iHRiPMyVFVKJZR0mcX2GK899vhBRqF9ng4F0LVhy5/AtUtCz8KmnYzFvH847j5qjBrSfYUqq9
	1NrBIjDNgEGoz+oirK0TJKBuQ=
X-Google-Smtp-Source: AGHT+IFfY75E83XPsnnpR4d1GJLdT3BEM1cMFJPNDF5onGmESgudM5Wglz+nZtIx6LfxsWNWpFn+XfQWwGmynVuCBtU=
X-Received: by 2002:a05:6512:b99:b0:549:6460:6b6a with SMTP id
 2adb3069b0e04-54ad64fbfbamr3771531e87.46.1742801460181; Mon, 24 Mar 2025
 00:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-wcd-gpiod-v1-0-27afa472e331@nxp.com> <20250324-wcd-gpiod-v1-2-27afa472e331@nxp.com>
In-Reply-To: <20250324-wcd-gpiod-v1-2-27afa472e331@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Mar 2025 08:30:49 +0100
X-Gm-Features: AQ5f1JotataG0hZSkN3AGVCpQIszAGWu_3pPzj94x551CNQv3UQ4vd0DTWvGPVg
Message-ID: <CACRpkdZmaAg-CMp1PhR69-VPnP43DigtaEy8aAd0MhUJ0gcWOQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: codec: wcd938x: Convert to GPIO descriptors
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:28=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> of_gpio.h is deprecated, update the driver to use GPIO descriptors.
>  - Use dev_gpiod_get to get GPIO descriptor.
>  - Use gpiod_set_value to configure output value.
>
> With legacy of_gpio API, the driver set gpio value 0 to assert reset,
> and 1 to deassert reset. And the reset-gpios use GPIO_ACTIVE_LOW flag in
> DTS, so set GPIOD_ASIS when get GPIO descriptors, and set value 1 means
> output low, set value 0 means output high with gpiod API.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

