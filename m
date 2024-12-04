Return-Path: <linux-kernel+bounces-431907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F8A9E4527
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B646BE170D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE920DD74;
	Wed,  4 Dec 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LSKG2vqp"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C4215F74
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333174; cv=none; b=XlNw6Wp/IP2cd1YFJihDni9GevnbNC8JYzxgwoqaj8WdvJxJBTkm7GKRydVFvvYdamlrMOrIH9c6Sg6N0CP8R2V8yKg5XPx9ULWq90Hseku5hX7lKUtJjci2hOxg0WKdIhVQ75JsNjiFGXR5PIejdCX8MzvXUda5QNswJN8kF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333174; c=relaxed/simple;
	bh=3XOKyfOtCe+byiVNEcWIU0XMb6iWf0YuG2kDOBxGSKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfBHCgosiFVfiX5Vr2xoLeoo+yts9IryjClTmaGiXlqxAJxVwYzBbumo6dNkkpfirGoo2WgxzGr/YV2NH52/sj4/agp0c9v8SkdVhK2SRZZRAEhGP9xNyO28JwUAHoIvgRcuEeoGWx/KvLgK8Ldycck9CqujPRUyfLXaIjz4eB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LSKG2vqp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso49047e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733333169; x=1733937969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcxUVGNwDSHYT0cP1lB+JvbULa6oEpjDSAOsUsCsW1c=;
        b=LSKG2vqprD3CCsdcM8jWHqrbrOpbuAGhAlFzg/M4LGr9jIQ2EBeekSdY8OU7LUL/2q
         QGfDRQQdYikv6OWWcgp1Qjso/q0Uxjqti+wqhT2Sk/eGIIt21TVLvYwOWj0g93FjI6+E
         3Hz3pNUf+i9ca7bS5qmDB/j1gKcQwjjgYfaYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733333169; x=1733937969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcxUVGNwDSHYT0cP1lB+JvbULa6oEpjDSAOsUsCsW1c=;
        b=VSmzZkwpbieSkmvVnVItrswXF1vcge59ExINCJQ3uFV/osXVQ6DuSFyq/57ieKI+6G
         QNI+Pta+GfEsw1qNBRfyGLRJsMOf+jufmO4XmbfsQ8EhQ0NayolAjE+OW+Ilu2L+SbDz
         5AvX3aEbotblL9xQUf/NcahPjxuoYscQrd2R57SXr4d+6eEtYytYLzixjVDiJMPlps16
         xG6OL2gKNbOqChhFdJqX5Zw1yrb8NtCi8MtzGXgyt5+i6jvdvx6xcPbwSAjnIw5nahkz
         dSNeHNwIpCXzk7WO4HV9tsKzlM+BzVZviLiLaxYyF/b6CiPuI1RfuJqKCxrF5aRQLPQd
         lNHA==
X-Forwarded-Encrypted: i=1; AJvYcCWBFnahNyn9yc2EymycZNf26RyQomjIs3DOm31KzuZZVslITj7TyMu3aop+JV8ukeChF2VJBJerLs1uIts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXn6zghkemUeOFyXhGH+xblFGK9Yexp+kJla8PFRMi76CoNLjt
	D+hvSvc9Kv9iMXL619AR9gl8wxlVOi/mUWNl8AHysMrZCyNhnnG03LjdW7ylOAzw7AyfHdiX9rA
	/zQ==
X-Gm-Gg: ASbGncvEiICdCfYo3AuEm4F+kD0knm8rubfxldOdmG5rgTooYk6mIQHn3KyJc2SM6ax
	54Ttm044l90OmTGGFZ4VlAMCJYie0tXGauJYOTlXfPTADJdAmS5fmsD9j9xwclwvP/250OMQZdf
	3GqPP3NEhkTCcO4yjY+Dp/txVrepdruHo4Tib5nkKr9s5V32Yy1wSiMsY9XJtfCBax87HQ1qUTX
	T0EhQsC8wbLCiX7cpqpJ56FF5/FlX2flPWkrsjX99SPxJsmZnByXFe7yH5ijrzVFIu6IsWNBAGP
	1bE6DoVqaZW66wzGcA==
X-Google-Smtp-Source: AGHT+IE3X4lRdeWq5AnZBdCWeKWJOcH0jFdRb9vysgf6LryjYAfzkoFTPlVXEyntdyEytKcWDbHCJg==
X-Received: by 2002:a05:6512:b8d:b0:53d:d5be:4bd9 with SMTP id 2adb3069b0e04-53e129fdd7emr2803937e87.22.1733333168898;
        Wed, 04 Dec 2024 09:26:08 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e15ccd908sm630207e87.157.2024.12.04.09.26.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 09:26:08 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso64916701fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:26:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV20EgJb4VWcRgfuvdkIFafc4Ty+cPfw/FtM0APA4R6+u1MO7/gx9jnh5GYH8TQVz/yjVDKYVaOnmR9A9g=@vger.kernel.org
X-Received: by 2002:a2e:a108:0:b0:2ff:c027:cf5c with SMTP id
 38308e7fff4ca-30009c3f871mr30428561fa.16.1733333166812; Wed, 04 Dec 2024
 09:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com> <20241204150326.1470749-2-quic_vdadhani@quicinc.com>
In-Reply-To: <20241204150326.1470749-2-quic_vdadhani@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Dec 2024 09:25:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
Message-ID: <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: i2c: qcom,i2c-geni: Document DT
 properties for QUP firmware loading
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, =quic_msavaliy@quicinc.com, 
	quic_anupkulk@quicinc.com, Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 4, 2024 at 7:03=E2=80=AFAM Viken Dadhaniya
<quic_vdadhani@quicinc.com> wrote:
>
> Document the 'qcom,load-firmware' and 'qcom,xfer-mode' properties to
> support SE(Serial Engine) firmware loading from the protocol driver and t=
o
> select the data transfer mode, either GPI DMA (Generic Packet Interface)
> or non-GPI mode (PIO/CPU DMA).
>
> I2C controller can operate in one of two modes based on the
> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
>
> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>  .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml   | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yam=
l b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> index 9f66a3bb1f80..a26f34fce1bb 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> @@ -66,6 +66,15 @@ properties:
>    required-opps:
>      maxItems: 1
>
> +  qcom,load-firmware:
> +    type: boolean
> +    description: Optional property to load SE (serial engine) Firmware f=
rom protocol driver.
> +
> +  qcom,xfer-mode:
> +    description: Value 1,2 and 3 represents FIFO, CPU DMA and GSI DMA mo=
de respectively.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3]

I'm a little confused about this. I'll admit I haven't fully analyzed
your patch with actual code in it, but in the past "CPU DMA" mode and
"FIFO" mode were compatible with each other and then it was up to the
driver to decide which of the two modes made sense in any given
situation. For instance, last I looked at the i2c driver it tried to
use DMA for large transfers and FIFO for small transfers. The SPI
driver also has some cases where it will use DMA mode and then
fallback to FIFO mode.

...so what exactly is the point of differentiating between "FIFO" and
"CPU DMA" mode here?

Then when it comes to "GSI DMA" mode, my understanding is that the
firmware for "GSI DMA" mode is always loaded by Trustzone because the
whole point is that the GSI mode arbitrates between multiple clients.
Presumably if the firmware already loaded the GSI firmware then the
code would just detect that case. ...so there shouldn't need to be any
reason to specify GSI mode here either, right?

-Doug

