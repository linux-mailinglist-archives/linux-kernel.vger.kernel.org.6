Return-Path: <linux-kernel+bounces-273222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F389465FA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71882820B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F54013AA2D;
	Fri,  2 Aug 2024 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7MjmMOO"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88B49658
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722638830; cv=none; b=DjjFWHha2pq2ZgBQnVxdJJqporJ8Z9jXgw9p9hUvxkXOOwf0q0Fbc1xXWnAGZSx9vcN1OzUGdF7CIz6tPD2mUXSzz26/AP3oSLzNdOqH1fl7LDGUgwAYta8gbfaNX4gpOAHo5A+bbyZDYrk4abbBSlXTVJERylveiEyiUKX1i6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722638830; c=relaxed/simple;
	bh=THbTUedfPNKqjs96TIhUgzsZRFAOtZ7uuHKn4O5aN+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gibwyonYn9sk5CLyIsZZvivHUZB9AykbmtliirA2Lxj3ukrFW03h/QELLX6z3UY9IJPxD/D9bfQM/bZhfyMUp7KMpJDIbyg75HgEwflNtBOFsS98YTdoXVSsQdJYabi6QicB8SKIZvxFFEQyrnRE7YPWvkr9qqGati31MDfqV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R7MjmMOO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52fc4388a64so14143797e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722638827; x=1723243627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THbTUedfPNKqjs96TIhUgzsZRFAOtZ7uuHKn4O5aN+w=;
        b=R7MjmMOOKwoGcyWXPdAKmjHimBgssKNjw9vulms0y4bUDk887y2Dyb3sQSOuwk8n+4
         nkRd0SSX+k9hauZhvhv1Mu4ObP3m1+X4RZwAhg2fw2DUkztNmV8zdxC3/RzTPae9ZNwf
         enPSuIApxI0Mjdj41YsVXVvIrAuOMnOIhuXrruG1fg60AC4/S8IbK4ZYjs+5dUDlGqSw
         54Ae0Dj8dOowo5KFG0HSoCxb5mVpKyDdXSxWj0d8H8Em/Ydc4tnQ0xR5GlkLBpIrZxXB
         SKX7i7bgd/MqeNhde8RRxpW7zASaN+hZpJe+jTmaIlQ4Cxh/3GEhnVf5ZLgqxrrVozmX
         7Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722638827; x=1723243627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THbTUedfPNKqjs96TIhUgzsZRFAOtZ7uuHKn4O5aN+w=;
        b=Ze++Yvk9IqJwvf1wpUAfDe8PM2sbBQY1cH6kLSQXQ3HCDNHq9IfodxdxOv8Dnv1eAc
         rDraTX0vO/Aj41njWIm3lyFD6Lt5X+j4e0OvjNhqb7S1/MuXMPYxmIfHm4fcD97HaCG5
         lmH+Fykk+UaneJqW4cWlxZuFYv3PpYMv1DlH4IA3K64DuR/HhVHhZ97vQQP4mm3ZjX7H
         aUaOUJ+xE9AgPv2MnlVOTnv/oNAp7t/P7oSSdjyHEs/o97f0t986/y/xKzTMK05LJoax
         /s0S/HycDBrqEbrFPYcpozCa59TfDjaIEM9M8CjxcE090Z78wgeBGOe7zTJPCVK2aiAM
         aX1w==
X-Forwarded-Encrypted: i=1; AJvYcCXFHUoft7S/JmdSqaYyXuEgObsBzzP8wmTZIoS9cUmMBjwQtZm4gbiDRQ0M/rcwKundOJ24w5cSLHRvkyeihs7Wsnf8PqH2SK/pfj1x
X-Gm-Message-State: AOJu0YxbpTIXJ8Jqzjn5rcdIPxn7xGpEg/Tm7ApPcl9rPmPJf+acxiFO
	Yko2pz43E7uJ6GG0OFLMmmKXXesbqj3R3hHYJ2En5qqPufTLaIid+ruRbdZVPb3fC0t4yjMSgdB
	6gNkgsL4bg82/6pzupHgJ5iMq/I+lTl9UrHidpA==
X-Google-Smtp-Source: AGHT+IHaxphvvVOqZtyqFT8jtOs3FeykDhzmXg4r2inKAxkSbJwEECQUJ7Z9cz9h3d+4wk/yzyUeMpDU1gIrN18B/T4=
X-Received: by 2002:a05:6512:128f:b0:52f:c24b:175f with SMTP id
 2adb3069b0e04-530bb374350mr2990086e87.20.1722638826801; Fri, 02 Aug 2024
 15:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729210200.279798-1-paweldembicki@gmail.com> <20240729210200.279798-2-paweldembicki@gmail.com>
In-Reply-To: <20240729210200.279798-2-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 3 Aug 2024 00:46:55 +0200
Message-ID: <CACRpkdb_7R=B6Ud_PdbrPA4JQViMBLeyAqSbga7-Ljkq0T3M8A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] dt-bindings: net: dsa: vsc73xx: add {rx,tx}-internal-delay-ps
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:02=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

> Add a schema validator to vitesse,vsc73xx.yaml for MAC-level RGMII delays
> in the CPU port. Additionally, valid values for VSC73XX were defined,
> and a common definition for the RX and TX valid range was created.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Elegant!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

