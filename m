Return-Path: <linux-kernel+bounces-259407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14376939571
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D581C21749
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5F23EA69;
	Mon, 22 Jul 2024 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzUbgGMf"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C309381A4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683620; cv=none; b=Tn7G9CXHffRZUEydU1jrPg2fNayVo6BQquScfq1Ez2656pxQhwVjSo4A6AY1uZmudmHdE8RKcoDRRyCNNPMgwNPsoy6sW4fhVDs7K9jr60rmrmjj8yNpa33SF75r/PaUdywhkIL/Y4hWCuhpzlUkvdfuL4bD3eOzUz1awDWHhBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683620; c=relaxed/simple;
	bh=sCJG3bWH3eDtbjb5D5X4+uFiGPj+jwOyLufNrBNFIjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBw2kbE9s/QpEp7opor7h4X4Ibdg/qlWZUKMPOfH9i/WcIfmsaWPRUQFUls9fwNCeAyFFRcuWH3PfTf+S40V2PR8JNf5sNWrK4wrnPX5x09C6paBBAbVf1eLE+58RFE1MGe7eV8KFhOuWQyJGYeGLjNgPW7Fs8rT8G/zex3EotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lzUbgGMf; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6687f2f0986so46280427b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721683618; x=1722288418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irn655mCRXY5mqdwBo1lh7DDX2toQETaPWSZms/YpXA=;
        b=lzUbgGMfRKe/vuzbqfjYWS2SvAR+CdIWVaibqZX9dn6fC97KlJck7BUstJVDVYAD3w
         xZOWKvIMAcRQvTyBjCLQg/HhIwy2b4KOHCTGVECIPZc8uwNXeAlwbt2M/LDbeXQGBWTM
         JOfrlZg1qoAyZ6iWTdKdcW1QW9v5gR/Dv4uuM7zxrPehzfItJBbbVLfsdGuNseRiju7S
         8fsnlXBrQfS5Q/UvPestuZQSdrxs7o0NKlAb5JhQHFS05kEJElJ3jInUkk/sP8kH5vo4
         zxoJ3a3ZtJwrxt+ROm6h9ZFzrcE948UY5UTDCqZTjkfjnLk1aBhOyNDTyCnVebidAC67
         iwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721683618; x=1722288418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Irn655mCRXY5mqdwBo1lh7DDX2toQETaPWSZms/YpXA=;
        b=WTbxBveWn/2hhkd9K/zrmJFwoZnqLXorx+oyEHBRxIN6Kci2WKwQDVVBQAtA/2Dc0e
         f4sX1edzCitDYtaGhU2LiyiQyOsSWkphnb+Fx3Kv3gmoYIcpdUylPH8smLOODiL39CbG
         UWIM7xvQTFauGD3F3fnZWWK+BvTd4X3XW82iuEBIedpMhGo6BlLBU45E41T/NiPQYsEE
         mYOP23+SCGc86dy9+Gfj5BJKule1bXVpw+6mR1Cmqug2KXBHZpDfdJh4ZzxdE+zE4uUp
         QYOPw/GArp6CxMVyiRT995lqtGsyBySWKt+lu7fsThTlflFFDwTWJXiOmbjn9boPTRzE
         2nDg==
X-Forwarded-Encrypted: i=1; AJvYcCWyZ962RmrwVyma1c/iNLFuzroa8sdtTSpG/QDGxHFnNcg8vjJGvQaeQA/6jjl42keCsOPL/9yfFZh6uhBd2xYwdkSDutLpAGcmfIgI
X-Gm-Message-State: AOJu0Yx+n1Ms15Lxb2enZdrtxtwe7sW8/HgJFqmELMXkqqlkC1c5JPVn
	KASlOfeBCb/q4hBfQurSB9H+OQoM4rrO4MGiDtgyqju9erXvCkYAwL5z/8wbSFcQLfSMkbkgo1W
	2vYLIq/YUse8KI0DUpvfFdJfI4MdadvNBPo7hng==
X-Google-Smtp-Source: AGHT+IHvJp11LN5ee6Tk7UlnQDxVoVyWHR++Sg/eVWFbC4d3fcFZdmIiD/WbWCUKGQdz8BjtsebP2EEPCwOFuv3YIlQ=
X-Received: by 2002:a05:690c:2f0f:b0:64a:4728:ef8 with SMTP id
 00721157ae682-66a688a5b7dmr106293807b3.44.1721683617937; Mon, 22 Jul 2024
 14:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240719120947eucas1p1344134823e100feaf49238de0e226431@eucas1p1.samsung.com>
 <20240719120853.1924771-1-m.majewski2@samsung.com> <20240719120853.1924771-5-m.majewski2@samsung.com>
In-Reply-To: <20240719120853.1924771-5-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 22 Jul 2024 16:26:47 -0500
Message-ID: <CAPLW+4mY_n21iFbS_jLf9xY4E0f3iB8o6mwV_GyYSPRPn1WA5A@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: thermal: samsung,exynos: add
 exynos850-tmu string
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 7:10=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> Note that unlike others, Exynos 850 does not require clocks, hence we

From the TRM and from the downstream kernel [1] I can see that there
exists at least this clock:

    GOUT_BLK_PERI_UID_BUSIF_TMU_IPCLKPORT_PCLK

Isn't that the TMU bus clock (needed to interface the TMU registers)?
Of course, it's not present in the clock driver right now, but it can
be added.

[1] https://gitlab.com/Linaro/96boards/e850-96/kernel/-/blob/android-exynos=
-5.10-linaro/drivers/soc/samsung/cal-if/s5e3830/cmucal-node.c?ref_type=3Dhe=
ads#L1196

> have to be a little be more specific about when the related properties
> are required.
>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
>  .../thermal/samsung,exynos-thermal.yaml       | 26 +++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-the=
rmal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-therma=
l.yaml
> index 29a08b0729ee..4363ee625339 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.ya=
ml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.ya=
ml
> @@ -27,6 +27,7 @@ properties:
>        - samsung,exynos5420-tmu-ext-triminfo
>        - samsung,exynos5433-tmu
>        - samsung,exynos7-tmu
> +      - samsung,exynos850-tmu
>
>    clocks:
>      minItems: 1
> @@ -69,8 +70,6 @@ properties:
>
>  required:
>    - compatible
> -  - clocks
> -  - clock-names
>    - interrupts
>    - reg
>
> @@ -82,6 +81,9 @@ allOf:
>            contains:
>              const: samsung,exynos5420-tmu-ext-triminfo
>      then:
> +      required:
> +        - clocks
> +        - clock-names
>        properties:
>          clocks:
>            items:
> @@ -105,6 +107,9 @@ allOf:
>                - samsung,exynos5433-tmu
>                - samsung,exynos7-tmu
>      then:
> +      required:
> +        - clocks
> +        - clock-names
>        properties:
>          clocks:
>            items:
> @@ -132,6 +137,9 @@ allOf:
>                - samsung,exynos5260-tmu
>                - samsung,exynos5420-tmu
>      then:
> +      required:
> +        - clocks
> +        - clock-names
>        properties:
>          clocks:
>            minItems: 1
> @@ -140,6 +148,20 @@ allOf:
>            minItems: 1
>            maxItems: 1
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos850-tmu
> +    then:
> +      properties:
> +        clocks: false
> +        clock-names: false
> +        reg:
> +          minItems: 1
> +          maxItems: 1
> +
>  additionalProperties: false
>
>  examples:
> --
> 2.45.1
>
>

