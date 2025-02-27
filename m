Return-Path: <linux-kernel+bounces-535221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D1AA47048
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE5F7A83A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1276B3A1B6;
	Thu, 27 Feb 2025 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pteHu9T6"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5715674E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616452; cv=none; b=b/36zSzn7MJPTwG5M5R+SPBHQYKV0OZGl5VxgL4JKjJqK7DT+A7IqwkjveOo5sr079dUkOpdpTLD0EP8c67tGHb3PP3FFbZ9hA98/d6/62EuuUJpxEVFChhuRbikYVsUA4t7leBVAgiKQzRwxgf2pvBb7FcB1056qXmRxThg+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616452; c=relaxed/simple;
	bh=e0m85e3y2dJr+vnbmMvuCtrUbcNjlRo6dsWIZjIM6OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJ+738DdEoTOfPOdLK+D6kkzlD6q/IXGSvd26i21ibBIfEbQIHsU+j+biq9shpfrqm5sxn80DyGvGK2IkqG6H7cZqLl0VxPywO7bZHzQ6Z1WMcMOww0h3kFJtzjuMvO+1SZFLdfvpwi1TeGy+cJWjOdwWcKE5Lw4xl5Ub15iI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pteHu9T6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5462ea9691cso343207e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740616449; x=1741221249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0m85e3y2dJr+vnbmMvuCtrUbcNjlRo6dsWIZjIM6OY=;
        b=pteHu9T6W2F7U+uLiMliilAnz6MddKVP31ABsypnOxNc/eaMJyRwMP0xTf6E0juMdw
         Kwin3Hg0Pk56Z5s7OBhk21xvT43B/MCbCV3owZQk/fgvCtIkOQ5Itz3rIcu3fdCqs/qZ
         hnS/y0BhmZqL0oo23m3IYT9GDzbYm59jQ6xoed+PIGHt7xAM6AZdBUhx00thfcsjP4BJ
         Adkcmt4LXu6sU3z293EO+XEQjKVCshBJUfTqCzv/zm1fT4irObEasWVeXXfJdm0YXqMM
         CvhA3pXQFAuRaCF63WaKWUziG/0gaPGsTbRB9deh+Q8HP4B4kx1LnbJ6YZGk9KIQMDLY
         wE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616449; x=1741221249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0m85e3y2dJr+vnbmMvuCtrUbcNjlRo6dsWIZjIM6OY=;
        b=v7FKS8vbCoGr+G2XgxhWcYMVggLq8o9n0pnZyx4cv67Qweo8isEfg08qL/XlbFLura
         VeCOCXatJjMFRRBdlYwU6J4j1wQ55OMXwpiDRuhVqoGlIjMTkV0qiVMTFn/hOuwoNRDh
         qd4bMIamkqGmSo/bKaesqkympdJCHLOFS+7UDQlqa5zR1bfdDMQbpCmS3ljDPv9Drodh
         FAVQccLPwQq7PJhztxxPJZtcNSqazn6wJXWzAlcbZ26AOjiMRMUVqP+FqjgPQysfdPLt
         wY7l+gCLV7LMhEEBd9Ng0akRq7gBZnT1m35zCKgXY6XzGRBeihWcVlJE43HbAhfR5Pac
         9P9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVY5J4WEWzWQLBGM3gmND8DoTEPpYkQ2HVo587yg3AoPbZ2TfRJX7CcZE0PazUp5584n9tlhWrPgaCHm9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ1Bw14X5pfXc65cdLicLPHA1Lgt9ySR8Rqmw0En7x3sCP5kKJ
	gBo5QeszYum/H30xJ2mqw+bJTRCZ0bE5tG0NP5kbLflxg3LuGj3zHSXPYCHzhBcIHrGJBUXlf5w
	gG2Ll/E4+nWcYi85m8AAUBQ2Tb1+fMxEonHaNCw==
X-Gm-Gg: ASbGncs+8AsluxfgSRmME8I7ACh93rSdoWI6EBC/MVAKKLdNCJOX5uYMDXoyOYHOQ0j
	9kiceEaYqb1x4lW6WvuJKltLv0b6zTDdOV43cXPMiw8of7qjb4l+JUUY92OZmfMsjeb+6XXbHAD
	/ItapvaDU=
X-Google-Smtp-Source: AGHT+IGk0bwizeRVbg8pZ8WmjGM8S00+LUG1kQZiLI2mX2EgJo48gbUR5HjgaprWg2ADtOmxLRe5adqlJ0n1Ufx5jUU=
X-Received: by 2002:a05:6512:39c9:b0:545:e2e:843a with SMTP id
 2adb3069b0e04-5493c5b85e0mr3233639e87.38.1740616448603; Wed, 26 Feb 2025
 16:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-for_upstream-v2-0-ec4eff3b3cd5@analog.com>
 <20250213-for_upstream-v2-2-ec4eff3b3cd5@analog.com> <CACRpkdZR8X17Bn-i2anqjxf0Gk60V175F7Xfwytkhy7_K+LsSA@mail.gmail.com>
 <880631da17a6d8ed4afe5a8c453fd4f7d0e4fca5.camel@gmail.com>
 <CACRpkda+CDRMYKmjw7kewenkteLhPYb040E4B=ZG6pgdy=65pg@mail.gmail.com> <PH0PR03MB71419BE3FCE2DAE8AB72B79EF9FB2@PH0PR03MB7141.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB71419BE3FCE2DAE8AB72B79EF9FB2@PH0PR03MB7141.namprd03.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Feb 2025 01:33:57 +0100
X-Gm-Features: AQ5f1JpLuJfZaZl_9L9BlB0RNZAYLUnV2bfevXjy2bS7H0GjQDbQCA5UMhow8GI
Message-ID: <CACRpkdaMBpUNHQu4kW0s0pDJSZ3M2GvNB7mY7DbnYuboebtgbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: gpio-adg1414: New driver
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 8:02=E2=80=AFAM Paller, Kim Seer
<KimSeer.Paller@analog.com> wrote:

> In my opinion, using the GPIO subsystem for the ADG1414 may be a better o=
ption
> given the intended use case. However, what do you suggest on how to proce=
ed?

I think it's best to proceed with a GPIO driver unless someone has
better ideas.

Address my comments on the regmap use please!

Yours,
Linus Walleij

