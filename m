Return-Path: <linux-kernel+bounces-547326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD71A505E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BB73AC612
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159E71A7253;
	Wed,  5 Mar 2025 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGv32Ptk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF013E40F;
	Wed,  5 Mar 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194149; cv=none; b=OnSUm226B5Tz4mmqPae78kLViL9fQtv6+apm9JF87H0s1Y7ua/qZrgx/7b77gssqUfPJLGOnZFj59JGSGT1+tJ+AzBuvgLrQ7+Bukjugs2bTp3Y7n87Kulg8lrTb6WJ9QfjAnaAKIJU+YTZvsKQbdNlpT2aVPus+fPkWTvT0LzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194149; c=relaxed/simple;
	bh=GRy1WbTNuxUAPrFOSZ3eMza5+pjAFHcCZGMDO9Bw9vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUuRkOGQZH26dm4Y9FBGb/afLUobEWi5nraJQ+1axuB5vJHdauM7+lS05RQUaFZNIIv1bfqurjeztzD386oku7n/ZDjvVCxd4cWq0H8y0qNnqVa3fZ1I32jQCFsPpm9/SY6zc9kAh0LH88HenH5AE/l2P8HoxvtgA19pvyE3m2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGv32Ptk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E1EC4CEEA;
	Wed,  5 Mar 2025 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741194148;
	bh=GRy1WbTNuxUAPrFOSZ3eMza5+pjAFHcCZGMDO9Bw9vQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YGv32PtkJgm3ELN9DsvogEvf25HQQdh19VAtxk9MeKcEX07HdRv1VUwjvDAwOacAt
	 XIBGgVsYzxCbcIK0NhgcTHmg7K6O54DnMjucpil/6OIq7+xQBDcoIF2HeAnyKCjDXJ
	 ySp5r3cYfqNtF/Usd2mNYcbn980NQlqoO9mYJiKFww0rhoAdgEEp0kktOMb5tJxSl4
	 PTcjcO60lL9HC2S6iXHVpY9Y1AiHB3EXXIS5R5jxRzPDqKBWkmns8XhfsJtwGictb+
	 7ebKt6bQmAWBQt7BOz8oyuO27LRg1Xx8aMotoH7XtVvWhfep83HwR5kCeCaBDbnc9p
	 MwUDiITjc15Hw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso12377928a12.1;
        Wed, 05 Mar 2025 09:02:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWdhDiCdMCKZ5oUp5gwbsYHD58p9vT2iAG8DvnSuu16ju+V0Kpy67cSpZrNTrM7TTtSDkSLh1uB72D@vger.kernel.org, AJvYcCVs7xtTcKtymWmgVUg5LTQe9CXXA4ZckWh6+sY0TvlZsEADWZr378n5MceD2FYcUJeWRC2VuvIKHo3XT29s@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsDiwqXPj0kN0mK0w3ghWzsf6mvGIOXITWoLi8G8+RA8RjhYs
	QQQs4f/QeyzYWgrzy+6GsIri7MAPZRNHFRwtciRYdtr2JaF1Il4CHOQdopFLfwr+HYixWt0eON/
	vNmkwSrRwf1JS+XhO/tvPzbi98Q==
X-Google-Smtp-Source: AGHT+IGgLAXSRBzU5AFRd6PnX3IZuDCdN73sQ42dh8wgaaV3t/YCusLdNXk4zX5F2wbX8qIW+4J5KdoX4FTJoiz98Cw=
X-Received: by 2002:a17:906:6a02:b0:abf:40a2:40c5 with SMTP id
 a640c23a62f3a-ac20d92d651mr402225066b.27.1741194147152; Wed, 05 Mar 2025
 09:02:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
 <20250304-bcm59054-v6-2-ae8302358443@gmail.com> <20250304141933.GA2543583-robh@kernel.org>
 <51cefa7f-df05-49d4-9006-59ed216915a4@gmail.com>
In-Reply-To: <51cefa7f-df05-49d4-9006-59ed216915a4@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Mar 2025 11:02:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Qsu-6Z72uXYKwc62idq2K169S1t0nUrrgNOyezgfYsA@mail.gmail.com>
X-Gm-Features: AQ5f1JoahPq2cFHn8OS3F1s4Px9gSAx0Gtyla8PqP28TC3Lr84PnEf8as25lYMw
Message-ID: <CAL_Jsq+Qsu-6Z72uXYKwc62idq2K169S1t0nUrrgNOyezgfYsA@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] dt-bindings: mfd: brcm,bcm59056: Add compatible
 for BCM59054
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 10:52=E2=80=AFAM Artur Weber <aweber.kernel@gmail.co=
m> wrote:
>
> On 4.03.2025 15:19, Rob Herring wrote:
> > On Tue, Mar 04, 2025 at 07:20:33AM +0100, Artur Weber wrote:
> >> The BCM59054 MFD is fairly similar to the BCM59056, and will use
> >> the same driver. Add compatible and specify the allowed regulator
> >> nodes.
> >>
> >> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> >> ...
> > And drop the allOf below.
> >
> >>
> >>   required:
> >>     - compatible
> >> @@ -30,6 +31,27 @@ required:
> >>
> >>   additionalProperties: false
> >>
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: brcm,bcm59054
> >> +    then:
> >> +      properties:
> >> +        regulators:
> >> +          $ref: /schemas/regulator/brcm,bcm59054.yaml#
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: brcm,bcm59056
> >> +    then:
> >> +      properties:
> >> +        regulators:
> >> +          $ref: /schemas/regulator/brcm,bcm59056.yaml#
> >> +
> >>   examples:
> >>     - |
> >>       #include <dt-bindings/interrupt-controller/arm-gic.h>
>
> "Drop the allOf" as in, drop just the "allOf" line or the entire block
> with "if" statements? If it's the latter - wouldn't that break the
> bindings for the "regulators" subnode?

Uh, I misread this thinking the regulators node had a compatible... Never m=
ind.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

