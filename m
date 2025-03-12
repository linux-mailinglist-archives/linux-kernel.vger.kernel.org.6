Return-Path: <linux-kernel+bounces-557597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44045A5DB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE7E189ADB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0868A241129;
	Wed, 12 Mar 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TW04dLOY"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013423F39F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778700; cv=none; b=QsTa0vcLXi3skLh2mqVVnqddwaH6V5dZdAm/IrObWgql+r0kZnR8r/vCWfrKTAxpsSRYD4TsllK/OWQ+Vi79A7hmnT27gVQwoOGZnXZBEWALtZigtFt9arshjHTusHC0t7EcCYrqUI7dAD2ZEMiY7EHvT4ymQuU99tjQYd0l788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778700; c=relaxed/simple;
	bh=EyLOE0jVe6Ot5eLlgUxopazARR5tkTAv5HgZzzFVFuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AguM1AwklFkYKTQ8ms6CIe7Sd6qWwaxWlCao+zVfH9ImXQGDuovQikLfi4yQO50IVNJkh7jCrL3lKhWgW/Hy6bRdtUhzWH5yoCIeqRBNDJ1hPnsKXfXtKwzm/nTg80IqulFUscdUevEINGdLjXmRCamrjqr9apTImq+mM9iX+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TW04dLOY; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ef7c9e9592so55522467b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778698; x=1742383498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ESIBsTzEIcUZ/ECc1taqnCKMBy5hYudFtIt6EODPkzM=;
        b=TW04dLOYqmJcdFVfoD1FwNrpW6qBAaxIMLsDcy86bev1MD0l/2dia6uIyiG90guYeL
         Z1NWmiPuAfk+cg1pjWJGKQR0j4CyDec5iy3i8eqhqg+hRoz5pcQv7+4V9iAzS6ZsKy56
         kA33yT9zhgGkrcw8wGF1jLioE9MOLf8m813ZM0YHpqpBd3CC3Vqk7SLOKsbe+0iq1G7P
         oxxr1o9bpUIi+HOgOFWRAKT919GPnpwwXUjSmsotCwreJnfCDTv4otYoh7OMkdx0pf8p
         +72Ix1x0aNydFTV9UXKVaJob4sTsk2Ivq4L4/WE2G55mi6uNL/BYLYag2oF7hKemDybx
         fvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778698; x=1742383498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESIBsTzEIcUZ/ECc1taqnCKMBy5hYudFtIt6EODPkzM=;
        b=SzIIKHBWzYW629vIWHIHo7iQYvEZrxZebAO4tvOv9hpEXSRNBIyAi7Om1No8Hz/Mnz
         KEIe+27m6pPEMKR5VFx94/dttQ76MXji0Wm9yQi/3vM7qij3p8QwVC9IrN2GxTc+eESp
         TqIj6CPy3yE6dsWmuKIH36B3WgOXyRAyMsmLzSe1RtUxekEl9JLI//kBVjW+hNOZQuRx
         XTwxiS1ckl3ILsgzkUhkEgdm9bj0XjrkOOQih07AXzew4KK0xNhjAox5B05qSxHKqxhJ
         nrAGpSKepNWhRymReuzFm1UoKvv4joe4vavzGPxKsGW9ieSbek6MJK1lYh4cUYgEZy9V
         gsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS5jel5oGVqLRz84rtsJuzAW7XiHx3JcXqeVn+wEz98pHVug1xMc9Pafocj/7vsIPG7BprLTXY9zHoRSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyCbzqhY5xHPHbMHDF+Yt1DC+fgFxUJr4PMZNDKsaTIzEcLMN
	lcwCiycguF+llAy9UF6MkPUfkhvbIQXMmqA70uoxaBPexjwwZGJvQowkkTGPl78Ckw1NHsHVF54
	voWGt3LK0c+7A1Hk9mXSKTD6t8LayE3P3P8ONkklz0QNUCNSq
X-Gm-Gg: ASbGncvxKfB+PO71haSfw7Zkp/wvxftRYTvoAqZD8Kri1HCk95bX28hgqfcyMBcCSig
	JYhyyfHPAWnJzR2djbYTUx1E5yKhkH8yiDzM+enDm2gqvt10tMk7cFRHZ2DM0rY+9EBIRCR0vVr
	wWK3nQxrKMDJ5he3NUV/bAX1BSnGo=
X-Google-Smtp-Source: AGHT+IHtmnbXh+/xWHNRtVc/+e25TtwDya77gAG3BQFWZJv3xY+g85qmMUghOraOvNz9vB+GjgG9TqOZpEeA4ZqkZEA=
X-Received: by 2002:a05:690c:30e:b0:6f9:8436:3d2a with SMTP id
 00721157ae682-6febf3f7f61mr306802797b3.32.1741778697916; Wed, 12 Mar 2025
 04:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220164655.2081224-1-Frank.Li@nxp.com>
In-Reply-To: <20250220164655.2081224-1-Frank.Li@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:22 +0100
X-Gm-Features: AQ5f1Jo7KEKuskQ_5cOeKngtf3fN-L7jwpx8y4RoWNvAYB-ewPO61CKAdCrGxr0
Message-ID: <CAPDyKFrxGzyNsr5vQjcxPRzyQMTpoR5sZjreYbO_8ZA6i_-XkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: Change to additionalProperties to
 fix fail detect Unevaluated property
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev, shawnguo@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 17:47, Frank Li <Frank.Li@nxp.com> wrote:
>
> mmc-controller.yaml is common schema file. According to writing-schema.rst,
>
> * additionalProperties: true
>    Rare case, used for schemas implementing common set of properties. Such
>    schemas are supposed to be referenced by other schemas, which then use
>    'unevaluatedProperties: false'.  Typically bus or common-part schemas.
>
> Reproduce steps:
> 1. Add unevaluated property 'abc' at example of fsl-imx-esdhc.yaml
> 2. Run make dt_binding_check DT_SCHEMA_FILES=fsl-imx-esdhc.yaml
>
> No any warning report. But suppose report below warning:
> mmc@70004000: Unevaluated properties are not allowed ('abc' was unexpected)
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 9d7a1298c4554..26e4f0f8dc1ce 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -24,7 +24,7 @@ properties:
>    $nodename:
>      pattern: "^mmc(@.*)?$"
>
> -unevaluatedProperties: true
> +additionalProperties: true
>
>  examples:
>    - |
> --
> 2.34.1
>

