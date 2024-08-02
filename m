Return-Path: <linux-kernel+bounces-273120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F4D9464B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA971F21B99
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB99B56440;
	Fri,  2 Aug 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ff1++IQt"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A04C61B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632315; cv=none; b=aAgQ5vvSpBJUFMrfPU4lB7tzvlxbifWijjBAwtPloBNgZ+VX25PAAvb1TtKowvLjNXEKnJzxVqBEHQS/Uh1E25TvBrF3ok31w8/PYqKWAikeVZtJdE6l4gBfz0sBjzeZc+2y11BSBfnbJwFWKNZzKUwqU94PGf7mmQp26iWm+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632315; c=relaxed/simple;
	bh=O+Tilim3KrHmSHorua8YjAEFRiWBTprbGtThLXeCT40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6ou20UKDxxcA2nJXRwtnOtmx/2hC0RD1PQFw8LGkY3++tDwx/OB4qGCgwsU0P1qWtnl3kiI8bB8agg7eo0oHy6SGwE4///R2XVA5VUj3s7nUA/37Wr4keSKuSI44g+4m5e4i9VK2HSzylLF7nKcIZ+sW2OcOPNHS6GlmQeqNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ff1++IQt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so13409237e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632311; x=1723237111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+Tilim3KrHmSHorua8YjAEFRiWBTprbGtThLXeCT40=;
        b=Ff1++IQtefS2vQx5N6vsf1zr6pZ+mZsyzFGKbf2e29saEGW2Sv2GdPFm0v07YfdRZm
         eOSpv8qE4bF3iFyR44AZdS1HFIebqJweX9ghdpAgP0Cf9NHO5bfMat/uDoV2Z2kcnEMd
         CPSLUcChEDppfV/Jxxq6j7BxJboq7heyI2no3kbvmdqDvALZ2TqmO65kAWbU9T9nX/QM
         WSIlK3Blvi4isr85XcKIcJd/X9Qg2AcZUTE4eTXZ77Fxs5iIrGBTb6g+dbI8fM6gzPfw
         NDwjvicpyyfXBPXOkX3rVWwW9XfsaBgyJXvi+KX+WO4QqGMt8oKdD8EzMs/4i0albdsP
         h4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632311; x=1723237111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+Tilim3KrHmSHorua8YjAEFRiWBTprbGtThLXeCT40=;
        b=ex4HIviXtkIlG7NbHoOHAw5w0xqmIkApRWxmkzWHOtEodiWHgvvA3R8dFuPEic2/Bc
         gwqnBPghJ2SfhhNa9VFl4X68YDEaD8c4puHr/lBvyDNlIASpljAMLKRFMplF24fZXUvO
         WHBNPBGesoPxAeeiBX/80GkeydTiNH8I1C/sUS95JKWAA1zd63sLL1EDuFiC2eFJschj
         3xeJtwv52HhYVtQhZ+XpVBAc7VJDGMrI1hAiCmRugJ1CC18DoaqBgdLImptrAjbMZ/eu
         Jq5/Dcm0lx5yjzyySOJCHK5URNJFpMeb89qAhBdWyzp0D6Yt/55IAgymcThXm9EAiPRE
         +mpg==
X-Forwarded-Encrypted: i=1; AJvYcCUavc4876Ue0l9+8Rccl1C/4XCPc/aE3EwGIJG6hXPVoRdKk1rUKwhGM+ods9xww59+25WU8XjpbSQ5a6z5W7EfxVG00snnvEG31u/F
X-Gm-Message-State: AOJu0YwmckILabTYpVs98LSi60MEpYdq68IhCA4oxfCkiHksQBkctuXX
	qGrx6VPwAs3hXWAJ5YRE/Ke1yn1Df5uaTLF/k2PM6JkFIuStf4+tnO3e1KMD4r9VN7eD7VJ55Nq
	kUw4O6JCnAz4iXIcayIrtDBRsCY8CM+dkm99gLg==
X-Google-Smtp-Source: AGHT+IGEPkWYjQyyOhvXhyRwGwgS8w8GFCtqhBPUgnWMvIErW7bGpVsQpPodZajzWUnVBZudUqQ/mS1GChG1h+2Tc8c=
X-Received: by 2002:a05:6512:ba3:b0:52e:bdfc:1d09 with SMTP id
 2adb3069b0e04-530bb36f0b1mr3129076e87.18.1722632311380; Fri, 02 Aug 2024
 13:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-2-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-2-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 22:58:20 +0200
Message-ID: <CACRpkdYwCNSj_A9FwinwW6kf6DOKEjM6jY9ur+REF+Yuv2yP2Q@mail.gmail.com>
Subject: Re: [PATCH net 1/6] net: dsa: vsc73xx: fix port MAC configuration in
 full duplex mode
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

> According to the datasheet description ("Port Mode Procedure" in 5.6.2),
> the VSC73XX_MAC_CFG_WEXC_DIS bit is configured only for half duplex mode.
>
> The WEXC_DIS bit is responsible for MAC behavior after an excessive
> collision. Let's set it as described in the datasheet.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

