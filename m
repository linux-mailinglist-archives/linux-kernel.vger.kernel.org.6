Return-Path: <linux-kernel+bounces-256567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DF93504D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F521B23681
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE49F145347;
	Thu, 18 Jul 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6MkYYW6"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919DA144D22
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318276; cv=none; b=MBrsc56AJjJH1N5gNUeTkYoG5HNxdYkTqJ/wxl6svi22Z+qsr5xk/03QOtNygBcY/fh0lr4FM9eDlBc1FXt9BezIZtCbDGPuDWbX5mDmE4rEVwCr97h3wOEdVEJB6IHrpH3U3+ABoSOvtH3+qmQSdh54ErB0SdEtRJH9AoFnjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318276; c=relaxed/simple;
	bh=pEoCcyP8SmbTARKtqj+yZyS8c0B/jW2B05S8wHRAb/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=II/TdHSAULE6l94pCfP0xlYQSG4MFJmW0POz7lhUmN2WGQ0LarfqfEXZBdMTGMEVcojpRrCJ83g9WWcwxJ32hz8KTeLzugEosEMtv7x9SroirQV+BV7q1kT2rkTITxNcCwlJxNOoC0jDnTpjExLVWWvGkyIl9xcFxwIXr0u5o5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w6MkYYW6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b3c0a00f2so711526b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721318274; x=1721923074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aMIVUi1+XtyWiv2jSx6v0C/sfNX/sBiBYCcujxRlArQ=;
        b=w6MkYYW6Pj5AJaHc7GRDubgJkaYhQIbJLJEb662r1mPe5WPmspO6ItGRMKylIeATA7
         MAEfl1JSxgOs9ZVqP+bJuYLQj05Il7CU6P6jDJOUdEqqe70+MEHXroz/oDBAvv+WlJIK
         inphK7/VA8/D6DY1HpBlFrE3ZcTH1vSS9TEVB14DoQiTGl352a4fPxyu0LszHoOq5X5g
         gj1JhtCbjT6x6zI5LSVlm8L337duQ+1NzbjdqGAhE1xCBVk6Tp1FhS1W5azo4kf4A0dZ
         3y8yLDwbG6A95gb70wx6P9yF2W7EtLx52YB03GXvcOuCFA/iYhJsGDri5VQtGrDpNB9F
         Xe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721318274; x=1721923074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMIVUi1+XtyWiv2jSx6v0C/sfNX/sBiBYCcujxRlArQ=;
        b=SCy5EU8kWrySr+VP3JlInt8ScEMVSuhsnt2xCq7oOz0n5ngS84hniNi3htt8dnmYH0
         yhXtqPN0d7/q0fCoMK/Vr61T8hXrWhgWImP4f4oCJ1hPW2qeRZSF8hBzOnzq8XAebKoV
         M5B+SpwxL5f0/tpd5QSuqyBCjY1XgkNvAQnoqdhXmPAns9rH/j7EkwwSaCmqfbEAp+m6
         S2L4VELASSiw3egWzCnf7HO0xh5x/bthaBHmEgDwBXlZelzkz6rsiaehEPx8KVaYyDyp
         NHaY9fD7v7irDFJgfoHx+A4wZJsF15wHgI5u2fKox/IQhceIlndSmzKsINk+gQ3yCxx8
         rhJw==
X-Forwarded-Encrypted: i=1; AJvYcCX7/y3sQa6BaTxBgO9+lOCDRjhmNhzJvnnsQLA44/gEFdEmLL7KuBJs/vqIdJsNalMEVrFs+xChUGEUCCfRLs1aMbBrGXSEwySpqqRr
X-Gm-Message-State: AOJu0YxIzB+S7KZ2GHlEA+1/XISXE4WVcrDW33+Yn97ujf4MYYw1BxM8
	OAqvxYzirwcr/MzQ+TK+OdJUkvbKctKXwVArCfAQyDfsNS0ZMtLMgzU7/ruMVvKGd/EdVOD8dzh
	KVMo2gBEUkrmG4FMaecb5p2BUUqdnbR8aQrfMsg==
X-Google-Smtp-Source: AGHT+IEpHrWCkUrpjxLliS2sFNiblUo99rdj9g5ppHtWWSZUzyR/mtO39VJ9j9yZKVcVcLEtg/ErSmtMwZdr3DV6WDM=
X-Received: by 2002:a05:6a00:3e10:b0:70a:ffa5:41dc with SMTP id
 d2e1a72fcca58-70ce507b90bmr6287948b3a.24.1721318273873; Thu, 18 Jul 2024
 08:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626060724.28862-1-quic_jinlmao@quicinc.com> <20240626060724.28862-2-quic_jinlmao@quicinc.com>
In-Reply-To: <20240626060724.28862-2-quic_jinlmao@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 16:57:43 +0100
Message-ID: <CAJ9a7ViUyr5YiGT_KfM0LjaifJ9RysfkLZER64z36CPy_fEPJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: Add arm,trace-id for coresight
 dummy source
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Tingwei Zhang <quic_tingweiz@quicinc.com>, Yuanfang Zhang <quic_yuanfang@quicinc.com>, 
	Tao Zhang <quic_taozha@quicinc.com>, songchai <quic_songchai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 26 Jun 2024 at 07:07, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Some dummy source HW has static trace id which cannot be changed via
> software programming. Add arm,trace-id for static id support to
> coresight dummy source.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
> index 6745b4cc8f1c..b18cfd8e137e 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
> @@ -38,6 +38,12 @@ properties:
>      enum:
>        - arm,coresight-dummy-source
>
> +  arm,trace-id:

Could we name this:-

  arm,static-trace-id

This is then consistent with the terminology used in the comments.

Thanks

Mike


> +    description: If dummy source needs static id support, use this to set trace id.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 111
> +
>    out-ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>
> --
> 2.41.0
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

