Return-Path: <linux-kernel+bounces-273129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730E39464CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF7028326F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358CD73176;
	Fri,  2 Aug 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRR1SkjC"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47801ABEB9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632858; cv=none; b=IQG+kX0/z3pnXIveZE2bpEPZLAJpHfNX+9Fa0RTaRzPWmSkoWWKey1CgHfG5r3VxE7p/NKYAswjKY16kSTrvP5tLn9ttEHKBulI+TsG4HpdmKqruYEKUKY7924ptlSTN2ZdSB8CuHz1KK39bIJq3DXrF0gqiq5CExNq5xhqaBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632858; c=relaxed/simple;
	bh=3IBCpDKASkgUWXZNH96TfA1Kg5XghuUUJPGzs/5NcVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OswEqkh3Pn1Kn0Yb3x8W8S/ah1bSJB/oJ376Bjy+QgXDmu+trR2dr+XAh9yuW9zraTTdY/59u8bJxhnspTlBROm8eZ6EmYX23KLjhHY7cHmXBrtsDBsdnxSI1NhYDdNm4Y4rFQDmflE4ZcPnfn34XtdkHGIKPB2uzPcG5mDRa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GRR1SkjC; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so98884481fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632855; x=1723237655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IBCpDKASkgUWXZNH96TfA1Kg5XghuUUJPGzs/5NcVI=;
        b=GRR1SkjCbLOKnkKxlw8gTbVc9A5PgBDM5OpLmYWFaEfm6FI1g5z/JodvRnnIug6KqV
         wk+JwgUN7LPJpSkLXKaIh2OPSsKUh+Q9G9erwU/7By41fWJ92ycTgDNY9tzQsCM8+dmA
         cwmZl/sZicr645+gi2Eb4jPboyeiJIn/J36dbx78g/smPXduDknh8iHnLJQYpNV5Uj5l
         MRLTEflrr7uKkvSz7zsmlJ4UbCEyLeYD47NPepLH1PU1rPEziWlvCVAVEkwpJ2BlCvV1
         mBBhtjycH2KTWiKiYMwAm/ycTnDGP0NfpgiwLUm9ZBElbjkffl7BCtrUSFwYl/qkYgNA
         XqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632855; x=1723237655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IBCpDKASkgUWXZNH96TfA1Kg5XghuUUJPGzs/5NcVI=;
        b=aGeOnb7QUg05o3v+8gvJajaXDhNFirq5CjRnai9Cg6Zm1cVNtOBsFhIWNM3jDu6qAy
         YX62uwwZNaTLoO/uH+UIR+KoYdjmEgAbCmJ0H7bHcVlciCSrWd/vQpnpgT7SL91PNStH
         LFMC1sjRcfuOYD/Qvoh5hCAH4BU6t2U9xC3JlzzfibpXzr3+RdU41rISkP4FvyYUflA9
         VvpxmiGDUJ+saPQxeJjepq2IOarNXXZvV6oxAJDZlDFous2zq7hn5BKGhvwMN18A9GXA
         5IYVkZtkbMKD4daAi32WYWCh2mqnHpTKkSdk0J8Dq/3Xbp/wp+tTDUym8OrRMbCTvnLc
         ktNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJip1CwiqPwbH2e+G8LhyT1LWb1jJv+DE18VxJIYsmHtw/+kJPr1dDcZaZvT6Jy+aSgw5Ox4Nv1GZQpjx8tVCp8LoTvfcewUBbWkAu
X-Gm-Message-State: AOJu0Yz/lvuLhcg0skE2BCNCmMy+d0YA81KJcTV+TPRwaQjfiHQlRW8U
	eJ9SPf8j1nyPw4lf5F9QhUfRAXaAkkZ/Gt6FVY50JiGQNm+MR0NJrLZRBFyJQ7V3FVXvTV1LYpX
	cGm4d+vIefCITDbQvTTIBgZOw5GR8HhOaJ5xrhQ==
X-Google-Smtp-Source: AGHT+IE7hFc1H/dZ8sBI7S/rf48tDmVRYcqd9lHO9wKK7clV7JzcwwqMIYpfn4V27LAhBUoFoLlkKUr2/Q26nLL9qPc=
X-Received: by 2002:a2e:91d0:0:b0:2f0:32f1:896d with SMTP id
 38308e7fff4ca-2f15aabce68mr35889961fa.23.1722632854934; Fri, 02 Aug 2024
 14:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-6-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-6-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 23:07:24 +0200
Message-ID: <CACRpkdbY1V3Kw-Otrp=dHH6Q4ABnyHY8aP2bSF1UNHKRmDzRnA@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net: dsa: vsc73xx: allow phy resetting
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

> Now, phy reset isn't a problem for vsc73xx switches.
> 'soft_reset' can be done normally.
>
> This commit removes the reset blockade in the 'vsc73xx_phy_write'
> function.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Like Russell says, it needs an explanation.

I think it worked because since the phy write operations were
not properly implemented, the PHY relied on power-on
or firmware defaults before, so things just happened to work
on some systems. We were just lucky things worked if we didn't
reset the PHY.

With some explanation like that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

