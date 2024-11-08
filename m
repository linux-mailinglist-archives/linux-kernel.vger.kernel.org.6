Return-Path: <linux-kernel+bounces-401231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1DD9C176F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BE2283733
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB891D271F;
	Fri,  8 Nov 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BF77jXdG"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7B1D0E0E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053217; cv=none; b=M4ANlMJrZx9wILdY9Lh8GYskR5xwETNaOuDio/jmnQQpIqJHjVQN6Fz1otTGEljr2waYAUf7bpHPMP2btc/zvBgbznXXcsji1wu2xOVgCG/SPWfygG4TtGnqcMnZ8mPyAirfgifR/qG87Vi0BUvwTZ6xfvl6k0kbxyszxUhs6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053217; c=relaxed/simple;
	bh=FcZP0o3PSmNumtKGO1ItgMWJ55M55pvygKyoPpk9axQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjC7XDzZ+Zb2FBtphtEqHnlQOIW5u/8zF0roapxtM3PLh/L0gXfsDgMsXdKJnYMU2B1uqeYUuVQgZC4ZJSNBEk1n0ZXbjnDA4LvEzcJgF9o049JnXzMlksJm27ZuqbTz6O2pcdRglKN1eitE25/N4+GgOdAc1N+vKAFO9rVCl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BF77jXdG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so17735911fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731053214; x=1731658014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcZP0o3PSmNumtKGO1ItgMWJ55M55pvygKyoPpk9axQ=;
        b=BF77jXdGM/E9hr4mO5nKkSms4Fo94BCnH2IZz7/p0h4MF18Kv0nxEegISeyKDw7o1e
         Px9JaeACwPK/hU10///qDmXOabcUQKJbgAHup6FkEGbFbVACyIhtoZPkYeq4R0giPfXs
         JSm+Ez3QRd8ewauj0TaHjFZwWQ6EpXCB8hypXkHF7P5nnQIrmNENdwUSUM/yGMBqwovN
         SYSXMA47nizkDYcW8JawnqYnUt1lH/mmVKvuvK7zkdxE+XpiX55qs7avtCy2MKD4BKn5
         4sQxG4r0Eit+MGdin/EgEhjQXwEHa/2dsfElz4KuRv4ZJhoN8+rlHSTFhCc4i/6TzA3C
         qFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053214; x=1731658014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcZP0o3PSmNumtKGO1ItgMWJ55M55pvygKyoPpk9axQ=;
        b=cNhbuLqT4e0y7F+Fy+htMV69MniDCX1ue5a4qelqsvooz+PnFt7uicM3XI12d2Y96P
         40QlU5E/gFCExxIgZ51BdJjiHrhv7qFyOLy5/n3aU71mmh5CjIRemQKUzfzsUxXvWuzu
         yN5t5g4cezLQGLPN3IRNNgImlH012gQb937SvcLW63N9garHE+bsdWZgyrYfTyXR7eaU
         MVJUBxq/fI56+nMiuhZty7q9NpwUt7rDASFLXoluPYqCILH9adC2XZNLY4P0AzU5L2S+
         KNGnEBkk0jxe0n58FKlfohAMl/kW5NoMwRgxvAkkQDe6xz49SqOOr2aelac5Tpi4hT69
         XbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9dCA2rCV4WDiZDs90vcIvgljuWentV+t4w1RRxkqOdkMKxbqk3uMy9Ka7zHqmP8xXEA7TrTJPZJnG4q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5IYjtq/o3dTo8D9qwWAU4Ve9ZDHxcnXUwwmE62CEkSknzmKEW
	WDGcSUKho8ghISx53qGWYvG3pXLgIAnyHLMeqeAAzKRDRaKPytOFUkAfADKa1KOcrgQyg9DIkP7
	9sjp0CFapa0Y0Jd2z1I6vPigk7exCretnjltzWg==
X-Google-Smtp-Source: AGHT+IHwi4PwmyQyG/lANiqFNPWg55NWKh714pI2y79atgBsJL4Lz22ORZxxpFfE7bWCRIAG4Z7yTBnCOgDUxjCiJmo=
X-Received: by 2002:a05:651c:991:b0:2fa:c4d4:ec44 with SMTP id
 38308e7fff4ca-2ff202230e0mr9679541fa.28.1731053213879; Fri, 08 Nov 2024
 00:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org> <20241031-msm8917-v2-1-8a075faa89b1@mainlining.org>
In-Reply-To: <20241031-msm8917-v2-1-8a075faa89b1@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:06:42 +0100
Message-ID: <CACRpkdbtNomOHe=Jd+0Xfm1sr9=DzvGSy6uS7jxZm4Mri8Bb3A@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8937
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:19=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> Document the 8 GPIOs found on PM8937. It has holes on
> 3,4 and 6 pins.
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied for v6.13.

(So we cut the patch pile and you will not have to reiterate this once you
rebase your work on v6.13-rc1...)

Yours,
Linus Walleij

