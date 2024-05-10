Return-Path: <linux-kernel+bounces-175973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2EC8C2811
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2480B1F224F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB06171676;
	Fri, 10 May 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B7rTT8Lq"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFB171647
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355813; cv=none; b=Hc8lqyJeEha6fgp7fJMYV0cGccF8ywcFpQhb+306DLMCLbZdR4SZTQg9YBQ6sr7YT36ZuCPd11pIQAoFzNPrx/ejwBnnYCcu/PrGdjN1H+dXfjTzdm3dRBA1v6PlkAH474Gsf+Od4Yzg6l0cava9xRjLAaw2Tf4XXI5/NLRn12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355813; c=relaxed/simple;
	bh=8ge9OcAQpy02pxdSG6GJDLs1Otucti+5yTOjo1VilHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzelh4YcXnfm+5htKSjGcnhQ+kGAvQDRkV4G5fFNqu0CU//SUG+b+grsm3vimLexwQ2qX9u+xbdEH2U7HobavLLFugBAFwGtCVtQAXuDNb7WTb+tVlRsPcMky+33Ig6+lfuCy6/iyANtkorXeCLYIKc28eVxeV8c34BsgljUC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B7rTT8Lq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e3b1b6e9d1so26362231fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715355810; x=1715960610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yoyvh8Rxn6zCgMfa/t+tG3yD/3CbcjfLHaveMJsT484=;
        b=B7rTT8LqcOCJHX9ytnmJOyTQ+SgfiLRuAmcVlrMgOpILI6tRM9rYej0arbsceV69mb
         p+mwm13Q2184HW42HpTDfQi9MAb4pHWFYb2lWTwescDjisly41ozHU8XXXIRbigUqbIP
         X+Xgp1O5hMzcN00u9mfLh30o4WfTe0olMiL2n5QsmPCbAPF5u66KCZoBiIruLHeJtiAh
         XYzWVdUV+Q2G4Ib9kpDwj7vWtmD8+BpEcUDd4xygUbCuORWFjySOY1UDy78wUgLQWGk3
         NmPC03xaYHltNhYgXZKySKJvfs/gc9nnLZWgt9r98Y2pUrYXPlmooX1dZNmXt0621YMq
         vyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715355810; x=1715960610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yoyvh8Rxn6zCgMfa/t+tG3yD/3CbcjfLHaveMJsT484=;
        b=cflZYnkqme97Zfi9WjigF95bHu8tIK3JzG42YjxJgvH2+sMC6Yh6ggsYmJZPoTKaYs
         1/By0XdZxrol5buLzWpqQNlfZCl0ayMtXvaAAw0r0B5GDiYj5PfW88eyiB9Z/11jr/lL
         EGJQfP/No/VDH56govo+ndIUrK6shkUoqnbYTnetNi1NFa4NoA4ul5wsv2m5IAHIK5GI
         i4pEUF7yuAs4nSeQ+TboN5otR6rMwN0Da0m8Yf3hK2zsvKcRzt2ub8Pk7L8QKJFqULy4
         nA72ev1iE4K/tof/OgCXstWlBVACeG+heCCGxWKZRyb+JND4mXQsEMNsWLrEyX3m5z0D
         JfdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq4pIot3hpItHSRRLKGb/AKIGhhWINu/fDUitpEZ4veFHhrpmACgvwEHf+sgEXAGw+EbqnqTZZTB0pDdbJqT5R3ipnk/jauwScy9E4
X-Gm-Message-State: AOJu0YwdCK/bu+B7zNamR2s1qRr+5MOHWGadjYrqFKrz+SCqH9dtGrfl
	oOHBywNd/haT2q9jTQjh45botiEkncGJBPd0Tu9WnkTtHH7j7m+Y4Jc6xDkd7gbLrcAbIcPMg3w
	TWcfWwvwyEQMAzihNJoOczjI9U4O7LhbKXSQi2w==
X-Google-Smtp-Source: AGHT+IG+a4LbocG+hZ2AszaZJTTWlZVoiSxMJlQjan5IizbCYWOINZG5FzwoAQRRO1D9Cg10+5o0fcjEP+y4hd/N74M=
X-Received: by 2002:a2e:934b:0:b0:2df:d071:76ed with SMTP id
 38308e7fff4ca-2e51fd4ae06mr18913471fa.10.1715355810234; Fri, 10 May 2024
 08:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510141836.1624009-1-adureghello@baylibre.org> <20240510141836.1624009-3-adureghello@baylibre.org>
In-Reply-To: <20240510141836.1624009-3-adureghello@baylibre.org>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 May 2024 10:43:18 -0500
Message-ID: <CAMknhBGU8bXg7obzyjzb7a4AUbjnw_0b+mqEAYJJekAK2CB-CQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: iio: dac: fix ad3552r gain parameter names
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 9:19=E2=80=AFAM Angelo Dureghello
<adureghello@baylibre.com> wrote:
>
> From: Angelo Dureghello <adureghello@baylibre.com>
>
> The adi,gain-scaling-p/n values are an inverted log2,
> so initial naiming was set correct, but the driver uses just
> adi,gain-scaling-p/n, so uniforming documentation, that seems
> a less-risk fix for future rebases, and still conformant to datasheet.
>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> index 17442cdfbe27..9e3dbf890bfa 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> @@ -94,13 +94,13 @@ patternProperties:
>              maximum: 511
>              minimum: -511
>
> -          adi,gain-scaling-p-inv-log2:
> -            description: GainP =3D 1 / ( 2 ^ adi,gain-scaling-p-inv-log2=
)
> +          adi,gain-scaling-p:
> +            description: GainP =3D 1 / ( 2 ^ adi,gain-scaling-p)
>              $ref: /schemas/types.yaml#/definitions/uint32
>              enum: [0, 1, 2, 3]
>
> -          adi,gain-scaling-n-inv-log2:
> -            description: GainN =3D 1 / ( 2 ^ adi,gain-scaling-n-inv-log2=
)
> +          adi,gain-scaling-n:
> +            description: GainN =3D 1 / ( 2 ^ adi,gain-scaling-n)
>              $ref: /schemas/types.yaml#/definitions/uint32
>              enum: [0, 1, 2, 3]
>
> @@ -109,8 +109,8 @@ patternProperties:
>
>          required:
>            - adi,gain-offset
> -          - adi,gain-scaling-p-inv-log2
> -          - adi,gain-scaling-n-inv-log2
> +          - adi,gain-scaling-p
> +          - adi,gain-scaling-n
>            - adi,rfb-ohms
>
>      required:
> @@ -214,8 +214,8 @@ examples:
>                  reg =3D <1>;
>                  custom-output-range-config {
>                      adi,gain-offset =3D <5>;
> -                    adi,gain-scaling-p-inv-log2 =3D <1>;
> -                    adi,gain-scaling-n-inv-log2 =3D <2>;
> +                    adi,gain-scaling-p =3D <1>;
> +                    adi,gain-scaling-n =3D <2>;
>                      adi,rfb-ohms =3D <1>;
>                  };
>              };
> --
> 2.45.0.rc1
>
>

The DT bindings are generally considered immutable. So unless we can
prove that no one has ever put adi,gain-scaling-n-inv-log2 in a .dtb
file, we probably need to fix this in the driver rather than in the
bindings. (The driver can still handle adi,gain-scaling-p in the
driver for backwards compatibility but the official binding should be
what was already accepted in the .yaml file)

