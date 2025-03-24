Return-Path: <linux-kernel+bounces-573270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D19AA6D516
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E092316573A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5743250C17;
	Mon, 24 Mar 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBC7nYxi"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FADF175D48
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801425; cv=none; b=RKbzzi+QUFaCGCLGsjKDzxJKDvlHCnABhsShy69GAekY6CVyumqbzAlwp7Fd5v708CRiMvgLc2QDd90Yo498RGLy7VcwaIqOUIehIGKAF3QQszcS4qrp2dH9jQxPvowWzkaRWZByq+mjvNywjTvq4Wn4porIEu8lgf7hbSq4sC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801425; c=relaxed/simple;
	bh=lwS7fGyY3ghDEpokPLpMM0HJbUP8WS4SiI9P4rR2lGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NE/N13/nt3FSHXb7RgF6SDmfgMHKvHe0KfyCJUxvgt1nn5/IS24aUTYvSNHgPU7q38o1cD+OX5pe45hF3I+l64DbJja3mHxuk+arLr6RDp3UdCGtSwZ25nls8VEJRO/ZOCWRrV0cFgN+KAN+3JdJ1i9wvFwjlS3BBy6sNH9X5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XBC7nYxi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a6bso42912701fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742801421; x=1743406221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NU2FVsh97m7TP1y3tfx9WOUJoAfHylfE9LhCzm81iVg=;
        b=XBC7nYxixEpGkdQEk1CarDA23eFeP3hhNPALtj/79IGhZfdG/WZqb/O+OcvDs8AWOT
         JImPnpBeQxipOwB8UqIZmkW8GGgemZGiMjpdg/ftg3QLL9w44/C7BS9vYZS4RlMdPJj7
         5EVmG9Io3vIk5h7RpP39kDVnAaHpckTCBAoQsKbLmCy9jj91kXYODrLMTIdjwX/8VmvU
         Y5aPydeYBpvv7zIQYAewVkGuDtk7bqL9RSFlA55cEVehR3pK5JFvKP89yDw8IQVKS+lJ
         FtlmSnv4fx8yjV7F5bKSUy2OZbYhJ7lZt6scHGutTXBtfl7GHaGLSDGXmZePLhvO8iuZ
         cXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742801421; x=1743406221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NU2FVsh97m7TP1y3tfx9WOUJoAfHylfE9LhCzm81iVg=;
        b=SB8uQBnUhDZvXq5f4CqI54FbVUvSQqaAjN5S9bkSODXd++yK104Gk2c2E7YI8mC7sE
         1hJ/EA3f/duUA8NarketEGoO81Y0zC4BnO2DU+qK91hocc9xSL2HLuesL1hXJU6XcNnS
         cPAhrYjMY+/uZ2fJ93OGgEk2WBVdVtHBXlruSPRtw6x7qCAnJ6g0RzkVJivTuU+uqFiL
         6+4yNEkXULM8C5lIOnBc2rb5Neb/hFUSBWCwrZbaUMLwEmFPT4bP0Mw4aD48f4SBORbe
         d2VKJngm9MOE/9TAnyi72xnO/3nlF5vgEmKgQtX2euU9Iy01xfHdvKq11A4O6dHXjDtL
         dqcA==
X-Forwarded-Encrypted: i=1; AJvYcCXupQIhylYq0oTEbTNk4laUjoGF/7RXQOQd/PR4U4PkpXeiEjt3fyl43NyjX/nNcKO7J+Si9TSdPjeq6RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+7bLOCP4Mf94zMp6BQwsjHWZlZbtAHsamY9hJ4lgzOd0b3Sp
	oV1ErSBdW4zgeqg9wW12HZWalymehiE2Fo0eWJE11YzG6MO5MHHP/agOI6NF+4bmJkoFjEQUSWB
	g980hMuyKl5HpeWHqkwWGqBZvyZkED7Y6CD9AkA==
X-Gm-Gg: ASbGncunSLtQude1wubvmegPdmNX0qQyEsKKHJ8T5TV/zTq4jAYADT3G2t+FRaLuUcW
	P4iXSHwoSYj3qGwptzs/ahJEf6cvkQwVliJkF2pyne9rytAdXimq4tNdgVmqFLl5VqrmkuPJHvH
	XjViWEBqeV86UzpQThHQiYY7o=
X-Google-Smtp-Source: AGHT+IE7ElI0Wie88BjvIx4/nAvhgrv4C9qAG+SVDsK5xNXRaCwIrYfp4uSH7h+9tbFwPhfRFVhl7PG+FIJIC44x9zQ=
X-Received: by 2002:a05:6512:318c:b0:549:8f06:8225 with SMTP id
 2adb3069b0e04-54ad6512f29mr3163266e87.53.1742801421294; Mon, 24 Mar 2025
 00:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-wcd-gpiod-v1-0-27afa472e331@nxp.com> <20250324-wcd-gpiod-v1-1-27afa472e331@nxp.com>
In-Reply-To: <20250324-wcd-gpiod-v1-1-27afa472e331@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Mar 2025 08:30:09 +0100
X-Gm-Features: AQ5f1Jp89LHUfGV1BvkWIJcCi8kryB-sXnI19w6Nw7WZk7DWQ3yMLvoYji6l6JQ
Message-ID: <CACRpkda=gb=u94CqYC8LuBtqg7x0eUVyJnuixLuyNonZ0=X3Kg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: codec: wcd939x: Convert to GPIO descriptors
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng,

thanks for your patch, and thanks a *LOT* for working on the gpio descripto=
r
task!!

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

The patch as such is perfect:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

However we need to watch out for users:
$ git grep qcom,wcd939
arch/arm64/boot/dts/qcom/sm8650-hdk.dts:                compatible =3D
"qcom,wcd9395-codec", "qcom,wcd9390-codec";
arch/arm64/boot/dts/qcom/sm8650-hdk.dts:                compatible =3D
"qcom,wcd9395-usbss", "qcom,wcd9390-usbss";

reset-gpios =3D <&tlmm 107 GPIO_ACTIVE_LOW>;

arch/arm64/boot/dts/qcom/sm8650-qrd.dts:                compatible =3D
"qcom,wcd9395-codec", "qcom,wcd9390-codec";
arch/arm64/boot/dts/qcom/sm8650-qrd.dts:                compatible =3D
"qcom,wcd9395-usbss", "qcom,wcd9390-usbss";

reset-gpios =3D <&tlmm 107 GPIO_ACTIVE_LOW>;

Mention in the commit message that the in-tree DTS files have the right
polarity set up already so we can expect this to "just work".

I would also mention that the current code in the driver is quite ugly:
it doesn't even request the GPIO before starting to use it :/

Yours,
Linus Walleij

