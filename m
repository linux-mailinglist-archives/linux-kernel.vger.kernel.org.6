Return-Path: <linux-kernel+bounces-331063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C633897A7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2041F26395
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA815DBAE;
	Mon, 16 Sep 2024 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QbK7rgrn"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3915DBDD
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515928; cv=none; b=EcSv60/ySfiLAYBlF6e+O4Fu7s2uVU9mVsGQzFqgYPntYSVKtBOS16RtqdZmYmZBsElcoQfq7S9WrhD14lsLoSLCLtQslUovSrwVaeYAwi5g32N/9kxJcQmrvmxYRGTznph5+bnt0kcBMG09l8kRuXAhRLjjpNds+IogVJZAjcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515928; c=relaxed/simple;
	bh=86FkMyQ/G+8VD02/whrVHHkVIlcKpQjBLC52Gq1S/Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEPklb5rys8Fc7xqxwvpGSdbHsx2RGlXROpuGa44sOt6oAmxR6DicWxUpGsDy/EnwhM0FgLqBofguC8jgYuRhbWFVLUrwUsb7QUbXxjwWFgObmo+iikEFp6965BYrK4/01BSwdYySA0wdIM68onwRVwZjKWmfZXvy4CXvxxAUpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QbK7rgrn; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e05a5f21afso2727917b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726515924; x=1727120724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7hgMVwljI+22DdDn+2KiS5sYn8c5xk9LzhXAy8Fwus=;
        b=QbK7rgrnMxI+6EpxS7ZLgRdxOrguiFtoWRbhXFsFa0FrV9hL2jPWzTxrWVUyPqoG48
         O+1BO+Gq/ZDhORKg61K296/MzFeEgAoc+rywRIzVYTa5TjInHgqyAvF4YZXs6EC/30Ru
         yYcQc8OgstQdXm4x9JP7p6OyNvk6g5zAiTmhMzr0h0/cl1jprFZemQUVpOajySzUanVz
         oMpx0ethAMsVK9pZ2da8g6oFFou10l2bOphT79+i1z+8RGtozHnPaPCFdNoa4Nt2cDGZ
         dSe+9GHPmm50LXuT4mjf3uI/XFKIA4DknC0ckj8Ktt9tGgmHtdtIWtNUWsVmpYuxR2N+
         poYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726515924; x=1727120724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7hgMVwljI+22DdDn+2KiS5sYn8c5xk9LzhXAy8Fwus=;
        b=gzVpB2FHfM+2Re9DHLD+/uk4T5mUhFlFuzYHX6iRIFniSOFOs5jDGpua3Mi6+bF2Hr
         E/CP1NyQ34uqMu/xmvcBOxYJYDXy0zVtQuupl+Kprmh1YmgRLlAAgLgbh0pJhWyWUqyN
         VWsSIBofoWBOok0fdzKRH7Gr6zsCn+dkcV/svkhU4fcYt4PYfJn5u1sp3wPcnNVhQpc3
         0XMs3qTQTh7JMde0Nq8mlKAaROcfPgkpc4p0coE5CSt9mwUvenCHTJynjMrJu5g9HnZn
         Wnb5YuOEd8JLRAjy2aBGmTeuXqzJZYxPJ0pRDEvwMNwvkDEsk+3V7gj1IFVLajszPewe
         xSKA==
X-Forwarded-Encrypted: i=1; AJvYcCWAMCYEk0XYecuWSfZfgdXZV8XxopiDswi248DyhjqoyZcyTVF6jsJEWQ/P+f/fmWvJMEQyYeTF01Uu8TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAoOfp55c/ZEHUdNxVMzdNMtHAFnpkhAY2cJdiWGfn7VNHpyl
	3HbvZYLr4aJRFf/tM2ayTJI2N0us8LtLhyTTFikYIldyhSZ7YrA80zh6GDGJ2moNyY5eIas5oPl
	zRLNgiEEx9+6PuNbwm0o9851jBLGvT/fDoH1gBA==
X-Google-Smtp-Source: AGHT+IH3OZJ7Dfh/L28GaVIFfHELZkTBoO/heaD4KN599aOPnL1NQjJea+s0cJl9iKsEMo5848K/h/romXt4JwpU1rg=
X-Received: by 2002:a05:6808:1290:b0:3e0:41ca:1443 with SMTP id
 5614622812f47-3e071a9a491mr14060081b6e.16.1726515924309; Mon, 16 Sep 2024
 12:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916-max20339-dts-v1-0-2f7ed7c24e83@linaro.org> <20240916-max20339-dts-v1-1-2f7ed7c24e83@linaro.org>
In-Reply-To: <20240916-max20339-dts-v1-1-2f7ed7c24e83@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 16 Sep 2024 20:45:13 +0100
Message-ID: <CADrjBPq0D1q4f7CxVpvdEs20uxkagsGfFLCNHeAQzm7L5CMaGg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: defconfig: enable Maxim max20339
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Sept 2024 at 17:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org=
> wrote:
>
> Enable the Maxim max20339 as this is used by the gs101-oriole (Google
> Pixel 6) board.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>

[..]

regards,

Peter

