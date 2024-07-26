Return-Path: <linux-kernel+bounces-263740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BEE93D9FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61EAB21305
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DB4149E06;
	Fri, 26 Jul 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tn5T3kj2"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A42143C6C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026815; cv=none; b=EJLnZvXZ8slTMqQIxlr9pU6XiKbxwRfENH+R6A6n/q0pOVO1E/+/ltx63Wy6A+RXaKzn7imNy4ocrvzIFqJZ1UpxNLMnOFbixewBOiLDFvF2X79vwy6IUdAiUopLfYAzNZkatbjTOeml2QnJEkWP2vJmtlDisycnYKCTbjvusWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026815; c=relaxed/simple;
	bh=oVfdt+OymtZ54PYvBu9Sztkpm/XoiNvJu0aqy8PJ1Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndnmTvTSMbXmkd+8bG4rUB5NwTXTIsfWqJjQRihTo/VHw9d7S8HTodqzEFQ2uuU6BgznYLSlyjE5fRkPy9qmqHXvOcdS1ixMnSE2lC6LPWT/UoeGFi3RzVfIzSY1m4pF/6v/RJccFVtynOLHmyM3E2l7XpVtK/+AeEODQonMjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tn5T3kj2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2ed59200so19285491fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722026811; x=1722631611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZXkbU8q+Zt3SnwgAk8/hFQnwK7ueMI7bqu+1Re++d0=;
        b=tn5T3kj2s0euk7qoM09mmPjVmlZ9ftFyvOZ/JadAQOsJhRelD5wNusE7tf5I6D4vjV
         Zrb9LIbGyW4wiiHeJnVUpPLV/ljCuievLtxYK+Cg/XlFCU3xJX5Api01bNEhsbpnsmvl
         yzLd8PIqKotdChUd0wvAvHnRXxb4ZBWt0LlsMIStZD2vZs1E+fCy8WQeFASe/V+uhWSg
         fGugd5FpLFMW0arR3ytXRkrvWpMRSaGL5YkMu4QcyThZz//3Ls+BlQtb9jRude1a0Ib2
         /Nsj9YuxZG9CzYr7yAiY7y2MEXvd8zBmPBfdP/X/xA2z3dWPt3HqS2EUXzdOhGi0QvLQ
         YG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722026811; x=1722631611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZXkbU8q+Zt3SnwgAk8/hFQnwK7ueMI7bqu+1Re++d0=;
        b=aa7x1FMSaFVJ0GdBif44fJWkqfOrotXXKp5o/SNhI1MuP9ltIcH2GH24dbEf7M4n1M
         GTgdi+/ZQSUpCnVhclx6ijdkSQJrv8TsDScyRlI/LbRPeFsQVJGUVjpHANZZBgM5K64V
         PPbSJqrREMjRBlJEgqLWY5NO993G6bffNZj2TO7wKV0QSDpEIfySZbroEfpjiPdkI/Q/
         JSE4VWV2LuKv+Qw4toBdExTGELVnL6LB50Th0WTGWRbigvaVGPJNT/lWqHuwTp7cmalz
         RDVCsBTueE/EXXdZJ56qYXDfXXucImhsSm75dfpZKehCKUos8v17v7z8mESVTuGPEEyV
         mHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH2UH8qIAPyqW/+vQ23s5gLMbODT7ZS8IesPU7uxnE91W9UvDVca/pOfyIOKdf4WG6QvWnBVsEpILngASGguc+VuZdYq83F/VulZhu
X-Gm-Message-State: AOJu0Yza7G43+UhuzAfWM5FS862UQh91pUzEyeg1B5JT6famW6qFHHPZ
	xBtxBy6txqhmZXco4NV56S3WYkgHdZLs4D/ercvJRFKjXAvLjh/606vNVENtliTIdr3Ly5HescZ
	bvo8OGA6RAemv+pWIjI3qJERV0X0LI4itO3m3gA==
X-Google-Smtp-Source: AGHT+IGtk2Ynpj/GJYUcsbK8mhjqd1a3MpqdYpelqVYrMrT58LYio/Tlrul5HfHB3aAXXNe3R6YeSxbB+rKUCRNWpio=
X-Received: by 2002:a05:6512:3e0e:b0:52c:c9bb:2ba4 with SMTP id
 2adb3069b0e04-5309b2b6e87mr649721e87.46.1722026811406; Fri, 26 Jul 2024
 13:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722160022.454226-1-valentin.caron@foss.st.com> <20240722160022.454226-3-valentin.caron@foss.st.com>
In-Reply-To: <20240722160022.454226-3-valentin.caron@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 26 Jul 2024 22:46:40 +0200
Message-ID: <CACRpkdahF4uDux1Dh1XSh7nHusyGVD3sNu8TVB8HVu277vGLtg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rtc: stm32: add pinctrl and pinmux interfaces
To: Valentin Caron <valentin.caron@foss.st.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Amelie Delaunay <amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 6:02=E2=80=AFPM Valentin Caron
<valentin.caron@foss.st.com> wrote:

> STM32 RTC is capable to handle 3 specific pins of the soc.
> "out1, out2 and out2_rmp". To handle this, we use pinctrl framework.
> There is a single pin per group.
>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
(...)

> +/* STM32 RTC pinctrl helpers */
> +#define STM32_RTC_PINMUX(_name, _action, ...) { \
> +       .name =3D (_name), \
> +       .action =3D (_action), \
> +       .groups =3D ((const char *[]){ __VA_ARGS__ }), \
> +       .num_groups =3D ARRAY_SIZE(((const char *[]){ __VA_ARGS__ })), \
> +}

This is a very clever and clean macro.

We have PINCTRL_PINFUNCTION() in <linux/pinctrl/pinctrl.h> which isn't
smart enough to use VA_ARGS and ARRAY_SIZE.

Now you also need .action but if it wasn't for that I would have asked
for the macro to be made generic.

The implementation is clean and impeccable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

