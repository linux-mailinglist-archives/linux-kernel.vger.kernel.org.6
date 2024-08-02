Return-Path: <linux-kernel+bounces-273133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CEA9464D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500981C2188A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF70130AC8;
	Fri,  2 Aug 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjcRQXPi"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8A41304B7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632949; cv=none; b=SpiBNydTzFtE9RwqYPpRM4TKfoeFA1le0PEhfFtQFPoO3NXyj12yTq8CZ57esoVM44mRe8T9lRTIlHnkXpQiBTaNrbv6mQ0IpWgiU+GDDIQ6FlFAlN2uvGQJtUlj35VxsEetso8DHC7gVuPVcEYMaFd0mNJ3LSNCk7KcpUlDejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632949; c=relaxed/simple;
	bh=P7g9T+8YJ8GVeScpcyOp0pJaSiqtooOVaooHR4xFC30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCC/Pad6sP5xDlKzzVU9YGfHoq2eI4+OlZafaDweXBbaC0nIgngsF79hY45tFpzIphTbSQDqU0iGZbEODAkGuZlBlYjWI+rdL4l8XfJhezJIzLOooAFtuZPAbLPXUVwvHlFbM4ce6xDXAxsbA/I2QXB6kM0fE8YgnQq4wuEZ4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XjcRQXPi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ee920b0781so92289381fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632946; x=1723237746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7g9T+8YJ8GVeScpcyOp0pJaSiqtooOVaooHR4xFC30=;
        b=XjcRQXPi1ZQEHg8+qhOm4HA9811DDs8VTA49AZ4PpbOrhhHXLAWoBp4rP7msEFYGb9
         UYVnbYcCn0aWUShcL3Auzwr1abfxrpwPeWITlFKQU4PsF3Q+qO5/NhpwRlBMSBJaWlZC
         N9P1qFMg7cj27KCFsKJNYd2UnnP3olyGagZeXnXE9clWotwcXOHDMKaTmC2krIQEw4Cb
         Ei2FNiVcKC1Pm0aTApqt+NUw5y7S0wwaLdXq7epBXulVOQCQZzj1uzQo6XzkSqwLKUQu
         RPCRpx3TPm60bBD+PHQgnNM2IYdqqlfVsJADapEHF/zhzGxhTMKyCsuxBg+vIksLXo81
         A0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632946; x=1723237746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7g9T+8YJ8GVeScpcyOp0pJaSiqtooOVaooHR4xFC30=;
        b=oQs2MC2ReZ5lqfQcG00uSQnvP0TTI+lqWoBY8sI5JN3p+cUO86Izg15btvUTfbudjp
         pLU/ovKr9R0gEKMkNmRT4C+rybR/Sz7G8BY78QeY/Og+I0CfRjzGuWE9JcjwP8St3Kws
         BkZsqMPxk5aLM41lxWOaECHYWSLZDfBcbrkRPA0livwT0byUjtjEHsSM84TRatgVrOm/
         3D3xQD4Vk5BTV4JWw7aTPCEjAfFNPoS8AxkOAzLmp6anawRzPstWZ//J5B70BusTjfPI
         azECY6VuXNUTBp07hVrEFjT0aH4Q8HGjMb8ys7BuRAHI1ppXJkXL9o+uvlEX0yqvjYn5
         0GcA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ33Nqa02+uB+LLxAyIE6kEt6EV0V0VLxstLIX1RQqNMsItpBFDa9O3KnK40rO7FeypHqCFgrGQoSsiib2C3C45uYAnijE+3KFrYDV
X-Gm-Message-State: AOJu0YwROu/DdwYs6Fz4QDs1I9lPzMNPBdohzGbpUmiVeYkjaDzVE3+w
	9KtnBOQPbAWlVQFJ0OCGC/xspEyYSt+kaLCrbCt7h2Ii+28W/qGuopXKqyyo2Tp8JBksmAMJ1AU
	f7/0Fmwws7+vdBOosS1cNf8L+WVdGc7Jn8LhCQA==
X-Google-Smtp-Source: AGHT+IGQXPKOPq6mXlRxwa/OZvDGlY7D3/zXW+vcnsb9KdOGySiXKSQPIw353s/l9s+yQpPz9GFodXHeb3EwsMHAtYc=
X-Received: by 2002:a2e:9d87:0:b0:2ef:2b6e:f8c8 with SMTP id
 38308e7fff4ca-2f15ab35361mr30379221fa.42.1722632945768; Fri, 02 Aug 2024
 14:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-7-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-7-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 23:08:55 +0200
Message-ID: <CACRpkdb7Bw5WofEbzxYrDHnzEZv0Ekj+9Y_neHeJdiz5TiBDXw@mail.gmail.com>
Subject: Re: [PATCH net 6/6] net: phy: vitesse: repair vsc73xx autonegotiation
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

> When the vsc73xx mdio bus work properly, the generic autonegotiation
> configuration works well.
>
> Vsc73xx have auto MDI-X disabled by default in forced mode. This commit
> enables it.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Looks good to me, as Russell points out there are further improvements
we can make but this patch stands on its own as well.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

