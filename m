Return-Path: <linux-kernel+bounces-366026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1C99EFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3C51C22B11
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144B91C4A1D;
	Tue, 15 Oct 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fM5+nWPD"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55881C4A12
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003240; cv=none; b=o+l7CpsqjzpsQGTuuttPgrqu8Z6TFFYKIRF65a3HOlN8UPXe6RKE+Yq6/lhBQp7I1hbpgU+gPrOKA+c7nm7ORrwZbX6w8Ju/KIWjhrRru7Yqo0ow7aZkAD+Z9PjuFeqvWFQvHQVupB+ACjqR1CrQizdKOEHpFS66CCL0Xsdsbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003240; c=relaxed/simple;
	bh=9RHFt59eWSwg6rR5umFEHG7c8+TVXjMCAAUxqgpUrHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZIAzixi5FDL51D8PZXCNQfzLRGUfqW6sECT7NRNSc2ftUEiTLPZZicTIwBXmBJe+/T7zBVOMioQbMzhqtHA1F8gOGLDJz6LfXlP7IRz9rZtlxUqr9BzmMq64HyKY0/4VoeNB3Hc4bsWcuF51+titup1cPpLYSnt0lPpV0CTEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fM5+nWPD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb49510250so19749151fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729003237; x=1729608037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RHFt59eWSwg6rR5umFEHG7c8+TVXjMCAAUxqgpUrHk=;
        b=fM5+nWPDJ9bWImWKkfKgZcfDhOc29o5rSJ0DTQ4z9zpP5qa2hFWxZRnOjpk4IPiKSd
         p1pVaLLZpXSbGj9iVPUo6mrRPh4ogDBerAhID/U7agqFLKwqv2GbjdAfJWoLfWEzxVWk
         x1cqR1nxQkZSYJ+sNepBk7Yyzldcf7jPRe49wWVr+P7gr5pp7sN/UGZlhizphMIutLdz
         HtXtwFljsmxog0eG2Jnt/NUqCpRGEH8tkrR0SNtHshGY8x/h8JGGckiZxTwUSZ0hed/7
         br4KZjGFZbVXwcCb7aPPfEv6mnBr2DJAfOjlg/OaUqHIlExhysPY5Tzm9Pkojsqhqx7j
         7QqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003237; x=1729608037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RHFt59eWSwg6rR5umFEHG7c8+TVXjMCAAUxqgpUrHk=;
        b=te2nQVji2kmGXNS/0ACrzO/OtInZUiV8BUCGlRiciYO5Vh3GBj3WlonybXd63y03mo
         A75Y9yk2x3KE4Wj50eeKIesOSf8lZw1LI2TOWBnV3PDvD9DjPosIKVkPOoDAcZPpFrwW
         c96VHlNSHb6/ZmyGzWtdFZLCSssnQRvL3VbqMy3yPymRGBBfP0BoDsDMjznlS7KDiCo9
         TbZJWFljy4X9h71EBzJ/s47ocBE1vksWyDPWweZO8pd/FhaqiRhRTwPqeZUk9h9+NfhD
         a883/RKJYx9xH1dAFdJ2KlEY1qChCBeIhklfhotgcmcq+K7jSjy5e5VrVzwKVjewMF8j
         psYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGB88deuVbJ/OrCh1EZXqHxplupqLlJxndTbGXMVb/Thpp+BOUtKTNHews3pDAEo1GdUnhGyhswXvXGNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmc8h70k0rie4omypPMnQ1iYns0h9eZbVgM5DjzU+qsTirmUVC
	FDY0wBsV7HpbmGkzwHloAkW6u58qd5eoGihmvNk5R94kK1P+NREugt4JB+PZv6QtsnmI7l+xhNn
	JKJGIEtpMzvF/jvPOTWU/pgcUOHUCLUwfNofqfA==
X-Google-Smtp-Source: AGHT+IFBD/NpUBNASpm9Pm02Y0xd1N3oLFXF15F3qVTflCwTdMvk9untezG2ykmjZkunqlCq32Td6LIqj3nEL+bSZ54=
X-Received: by 2002:a2e:4e1a:0:b0:2fa:e896:3191 with SMTP id
 38308e7fff4ca-2fb329b428bmr58373511fa.23.1729003236800; Tue, 15 Oct 2024
 07:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3> <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 16:40:24 +0200
Message-ID: <CACRpkda-Hey3PJe1SuCLZs35QNT22dnMc1HWd1UnZ-iec5xXGw@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Mark Rutland <mark.rutland@arm.com>
Cc: Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:00=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:

> > I am trying to reproduce it and failing :/
> > (Using Torvald's HEAD)
(...)
> I used a config per Clement's instructions, i.e.
>
> | [mark@lakrids:~/src/linux]% git checkout v6.12-rc3
> | HEAD is now at 8e929cb546ee4 Linux 6.12-rc3
> | [mark@lakrids:~/src/linux]% git clean -qfdx
> | [mark@lakrids:~/src/linux]% echo 'CONFIG_KASAN=3Dy' > arch/arm/configs/=
fragment-kasan.config
> | [mark@lakrids:~/src/linux]% usekorg 14.2.0 make ARCH=3Darm CROSS_COMPIL=
E=3Darm-linux-gnueabi- vexpress_defconfig fragment-kasan.config

OK I got the crash, now also with my build scripts.

Dunno what I did wrong...

Yours,
Linus Walleij

