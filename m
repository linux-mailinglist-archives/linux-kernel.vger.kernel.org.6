Return-Path: <linux-kernel+bounces-356618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8585099643C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A061F217E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A28518E03C;
	Wed,  9 Oct 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qly0dBCC"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A64518DF81
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464071; cv=none; b=E9ouV4KnElvOvo2guKFonY1upc7q+h77J47QUEit8Tl2p9hsIa3slD9B6b5ocu38Lqbl6knplrOwBPKdIPbrgqx7YP6O7h71piRpzyxoCr4mZ3VuQQjphz4xaaU3va2TN7zLa3Iwaf2yPQHEeOFY7kGCqa4JPkP1GXzkLn7hUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464071; c=relaxed/simple;
	bh=FFpBgRTSKsDxjFwRJ4STqSap+pHtBiqiKgJExfia4cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq/Gs9Mfsr/2zD3802hrmS+EmyD9Aq8T/NjFaJOID7iOfbJlwaO3QAUvMipUxwStkTZwInDAbL20T2dvnsmihX6aL4VNIhb0k449/u/PfTJt5KdJQlNIxawfLnJhV0meub/Y7S5+LzWeeQr1DCvFsMccmUT59S0ojZSWp05dtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qly0dBCC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so454124666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728464067; x=1729068867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dpIdKlGEx3HAehwqgbFbosdnXDUfWgAPKaA5vSiJ7Sg=;
        b=qly0dBCCgx/PKO8FM7kP3nfkfpTi1IYuzHKzpXG0GA3+Bstye7DQHR5ClxRAurhocE
         w5hTuxGeBEtoTkFrV/5S5CkCalr3GkffDanMybsoEIPwC78d003EkGafxdHhY6MIm8su
         4XI077YoehVFJXS5QPymPpxN81SAn5qx66SVCfE/DCQR4kwVE6WnAp3MkKg3XOYLhM4L
         wtyE81WsxWRvkw70/VdnMN8z6m2WKScIFeu/ypKeNnXc4PHdMqh/WZ3zpMRMXDiRT4zZ
         ZnicK17HZqog2VpCYEi2W8bxuQjAExqgSuXPLIGLgA8RbsGQ19YXhD20QG+jnMUlqlUV
         Rvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728464067; x=1729068867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpIdKlGEx3HAehwqgbFbosdnXDUfWgAPKaA5vSiJ7Sg=;
        b=YE+2RLBmg1zGZQ+JIm6CCW9qtp5gAtvKt3iAiX7Y0x5nRYyoaZGWJX2GVFHXXqyPAU
         MftCHmxDo7qsKLIaZTwJPJ9mwmoCVQC9GxG+UtOWbfnlVxBGEJvQXVenqjkJoFYQ7Yq6
         9WOKjbx2uzUUrTfjPsXIKhvDD5TiyRVO43TyPLlE4fNnDT07bxd5ns3j0P9GPiGdXniC
         fkRdjP2R478XCXoMlVtORDeGVHZZIe72oOrVCUlU9Mo7VeF+GE9Mm3Gkq5y2F0R5Dg6M
         /kpPX9A3G4j7/9ChX/9OXO9tylkhsQpepeuSaz/DxKlEXCrRYdXS3OT4bhzQix/+xD3p
         r76w==
X-Forwarded-Encrypted: i=1; AJvYcCWaGV8lMBaPyj+EOw3JarbaNT4ykp9GLooxZS0n3dNy4CZEqaQhMLq++LQao4AsV5HPO1orrWKZGQwnsVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCN/ys9I6LveMLa3HPiYNTSKUvWJYaLdKicw4pxh6xH+Kkwxkl
	+xFou9LFe9AOJ44E3C+sMwsgTuqpdfQNelr1J52Kq8hqJNjIgMwLQxQuL08Pprhex9ITwFAJEJy
	VnJmrBdFzBle9rZvP+Ir56gqNbHfqfItVEJN7RQ==
X-Google-Smtp-Source: AGHT+IF44BE8hthfETE7YKbsC6rLoLa1YTo/RGuFZV8OdBGOLSb3SfY5NiHb4he54Y0t/CrceLlKzYCcXMtLj21d6h0=
X-Received: by 2002:a17:907:3ea7:b0:a99:3ac1:2997 with SMTP id
 a640c23a62f3a-a998d199561mr127216166b.25.1728464067351; Wed, 09 Oct 2024
 01:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003211139.9296-1-alex.vinarskis@gmail.com>
 <20241003211139.9296-2-alex.vinarskis@gmail.com> <CAEvtbut-boW2nrbUTXFkvZ8N7qA_OtNz0dMPzRq0OYu4oF+jmg@mail.gmail.com>
 <7cfa0ccd-2fb3-41ed-ac4f-8ca9bf29514b@linaro.org>
In-Reply-To: <7cfa0ccd-2fb3-41ed-ac4f-8ca9bf29514b@linaro.org>
From: Stefan Schmidt <stefan.schmidt@linaro.org>
Date: Wed, 9 Oct 2024 10:54:15 +0200
Message-ID: <CAEvtbus6AK3-NHm98aO7O-PBYcaQ+VH_Mup5eViqMwCQrP1GFA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: arm: qcom: Add Dell XPS 13 9345
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, robdclark@gmail.com, 
	peterdekraker@umito.nl, Bryan.Kemp@dell.com, tudor.laurentiu.oss@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

On Wed, 9 Oct 2024 at 08:55, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/10/2024 23:07, Stefan Schmidt wrote:
> > Hello Aleksandrs,
> >
> > [Again in plain text]
> >
> > On Thu, 3 Oct 2024 at 23:12, Aleksandrs Vinarskis
> > <alex.vinarskis@gmail.com> wrote:
> >>
> >> Document the X1E80100-based Dell XPS 13 9345 laptop, platform
> >> codenamed 'Tributo'/'Tributo R'.
> >>
> >> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> index 5cb54d69af0b..7c01fe30dabc 100644
> >> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> @@ -1058,6 +1058,7 @@ properties:
> >>        - items:
> >>            - enum:
> >>                - asus,vivobook-s15
> >> +              - dell,xps13-9345
> >>                - lenovo,yoga-slim7x
> >>                - microsoft,romulus13
> >>                - microsoft,romulus15
> >> --
> >> 2.43.0
> >
> > Tested-by: Stefan Schmidt <stefan.schmidt@linaro.org>
>
> How do you test bindings? Running static checks in kernel tree is the
> same as compiling software and adding tested-by.

I took the whole patchset in when testing it on the actual hardware,
so I gave the tested-by for the whole series as well.
That being said, the binding patch here does indeed not benefit from
any on device testing. Feel free to drop it.

regards
Stefan Schmidt

