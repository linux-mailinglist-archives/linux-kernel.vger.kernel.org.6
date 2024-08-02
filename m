Return-Path: <linux-kernel+bounces-273122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE89464BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49ED61F21BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE5A74040;
	Fri,  2 Aug 2024 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cdkx9Kt3"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D366A33F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632405; cv=none; b=Qi7o5znG+oZxvfNriDc8DzdEaumPTZRAFdHJSEfs0BOCg+ny40xb5jE7S4L1owl8yUKxwM2DABJnjfhO9MFWy373cFFXf2DgDGWiT7XxUePqKhscpjqAo3r1VfsfgUqjXLTG3YPEte9eJ5VH0geRjdCZnozIvJXzr8fMuZZG4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632405; c=relaxed/simple;
	bh=ur6PCk4noD2N+76JrhCMPAyiGFsnK3iW68h7iJXOdts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccd/9uTwUuDQHt+RGXuka+bUVevdlKFBu6muNjFDRTQHfCFP10kbejgVstXqiOo3V9M1+XZvnpg9x8iYiSEtmD5mg1KdX9yiuSo+UBQs927vAhe3hVsasmVWUQq+djV2bCtJo0gdDtxMRTlEldO8GqlHWXXpdfVZRPTaPUmP8rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cdkx9Kt3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso99072231fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632401; x=1723237201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur6PCk4noD2N+76JrhCMPAyiGFsnK3iW68h7iJXOdts=;
        b=Cdkx9Kt3cdHTw3s7AkRwmBj9o06PYxerRusRD2mShUs/bjkppJHwqrDuAgBqF6lmQ7
         5Fbpd64g2IWsAIJ7kmFaP0u/p7SI4XrDnlKvG8J5CxUd+py3e9+77CafnK/s45yfJ19f
         URQaXX9ClOhI51tbjIrQ38aXRI/77igvmhm4tY9sJX5Ek4tlzJpleduvpmHkXu67xXUA
         kqbT1QSQ758fZ6JR/l9p5D8BUTDCvuKTpz1MwFWSzPjhXgVyAu7YHsBCx/RC/MHYTGI7
         nHKKJsKlrPmnPlWD6Yw9UiiEoLpVoeEpzJ75np1Pz/obP3POHe1rkqJybbGlap3NjS3f
         Fv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632401; x=1723237201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ur6PCk4noD2N+76JrhCMPAyiGFsnK3iW68h7iJXOdts=;
        b=ekoQ38SVWboko/nXiaql87VrDBoCL391pA38OpQ1wDKn3eObeFu8NCBiMOZEEF5XbJ
         bho/kwbZOwTfZGy+Cm7WnBO3UHGQ495DmdyC0Bo4eMGKIvTMuyNo669SlcVKTtauJtZ/
         vwtj8U3+1jzM56om+5g/4lvqSHrez+xpIVFDR/2cRMoNBTgU1BSPPC+L+2Cjuk7hg3Z3
         IFmHYK/5rNBs/1VySxPJPDBm72aKH6VoOCjVQemB2OFlVJix461tQofNF20sC63PEUq4
         +QfmVt+oIN3l9wyWILZK3r80RA7eAwsRkYCqVoEg78WVPhywHLoj6Xz2ObrgTF3sbUQw
         moSw==
X-Forwarded-Encrypted: i=1; AJvYcCX21yygEdB0WwC3byR2OG7itckoQEWFKe4qyEy6f9oei2NIgvTzGJEhlBTLuOiE63B/+CQU5qBzqj6/rt8/Wr+kryjRh/vXJ7oIdQF4
X-Gm-Message-State: AOJu0YxKgyCJNfKnFAsdrb37eK/dHuROMeV+oz7NsS+KLctdTEc4QzsK
	7LD3Xg2EA4TGOOpKs8EkUc3l2dZFIvoJ/aOMX8QHzXTN2T+9Z9+yuYT7PJrQQEfC2/VevnTEbFI
	EyGMcVqzM+ZtEh53DEEforuPlBtGCaJsyWOQk/g==
X-Google-Smtp-Source: AGHT+IF5WfbIZF95CVQO81XJg+lvsexJOkUsD984b9B1TGK/MPMHFPTGd2W1SKk7KG1xx0cb7erDtRot9mLe6r8vGVY=
X-Received: by 2002:a2e:8187:0:b0:2f0:1c7d:1ee2 with SMTP id
 38308e7fff4ca-2f15ab27bf9mr31038641fa.41.1722632401226; Fri, 02 Aug 2024
 14:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-3-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-3-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 22:59:49 +0200
Message-ID: <CACRpkdZ9yB_12Vr_HJ1BUUENmKQXZUoZTLq=p_CLG1Ym93d7gQ@mail.gmail.com>
Subject: Re: [PATCH net 2/6] net: dsa: vsc73xx: pass value in phy_write operation
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> In the 'vsc73xx_phy_write' function, the register value is missing,
> and the phy write operation always sends zeros.
>
> This commit passes the value variable into the proper register.
>
> Fixes: 975ae7c69d51 ("net: phy: vitesse: Add support for VSC73xx")
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

It makes perfect sense and I have no idea how I managed
to write this bad code or why it worked so far.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

