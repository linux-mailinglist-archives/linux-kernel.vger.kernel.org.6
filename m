Return-Path: <linux-kernel+bounces-186258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6928CC1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCCF1C21BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3513E027;
	Wed, 22 May 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XHhWAFA5"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583413DDC4
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383345; cv=none; b=uvwIiCJEggQn49H66Z4mFuDJUJExTEI1IGPZJ7M6Twfcz2UHosVFgNl/6wZZW4fEygAnZgA6YzmcRa6+1EsGkc/gVFldMjdTAfCfNbz0LDMnvpCw7qo8AbAU3RA8L6SvZiQ9G8d5AW6AajDIzcrcC8sdlE3/J6FAkbJ4/tY0qvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383345; c=relaxed/simple;
	bh=WS7882mzHgfs2gNdKan30wkPOWoctxrHpnRRZJBBj+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJpd9I3K4KXCTYRrI//WEeBhKYsQOP7htZpZuPd8HkpPeWjYOsr7FZEC6wyYKs33M6/GS8KxzIUiZfeE53O0qyRgWylCIlDLn+qCcJVgUbKFrDUEhrJVbJQWX1KnfQs9Ms0ykv0oia3TzVziMM3FnM8j686I9reIgaUwluqeWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XHhWAFA5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b9fe8fc695so2084947a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716383344; x=1716988144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjQG+ZVRqA/OwyUtRk8c53CTAn1WGq4lEjgouxEuyEA=;
        b=XHhWAFA5VoeY691VBB15vt0nyBEvac353DKTQrz7n6s9H0Yb1cAP1CCAGubtXINYkS
         P/hSlL1atErlOqv1MXnOCMe/bkXhHEgGaJoqsLLC6tcAyH6eUuJcWXMD+oYsl5X5lmve
         RElVEjw/kWn6q8qKD/1fMsVvOfFynRmtpZGga5FWeMf/MAfL9CbXD4urvUxUA/8pghdQ
         2J19Bm9IczyDUmdxD+zZz0CtPBkkezbrdILM1eNCncA/2DFJAVb6dl4sc1NNIjbmCkD2
         u24pNHQ4aXJ2EQ7GQtdQXDe173vYELAmeIdKyFJaJAIm/ZjV+kSFNBh3qzN02j1+qyU/
         ptww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716383344; x=1716988144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjQG+ZVRqA/OwyUtRk8c53CTAn1WGq4lEjgouxEuyEA=;
        b=YOj2GTaE42LrJHQTq43e62q/8xgG4+bfUBCnybty8E5HcemE96a94Wm5bX+d66+yEn
         HK4S09Ov+UleIhSsIVK1qN4GfjBdLRjNycCxHbPzOvNujNVFKfddgrX5xFYO+leQIetR
         12ressWyQWDkmhgP1bbC5oxIxWXxi2a28YYxC2qQArtmzkOhx37SzxR7hCjoGyzTQKcz
         vGklgDg0zEZnRTXnZdjt4ZQlDra01QuQKEp6xDq8K+OhuBuidPL50c6dj2/5zFTrBhpy
         fO/HbNwfRZ6QP+1FmP8jVnCro99PWFNdOAzL5Oz3Sn2MBMjHn9/obCU76H2qWWJfveS6
         HeHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtUrzqTapjagk7K3ReiuHJv2F6BRvRbw1vATZ/g/V9t5IBp6DGPHGem/X/LLWRPPYJRdc4MXmFf/RtvsQodVkEsKTU2Q07tEnoeVmz
X-Gm-Message-State: AOJu0YwWI0iCfl2A8zBrdnF/Bvl7hgiYWmSmcmxeNRC+uyFrYFMUOM92
	5LAIoqd/vsHaphs6TyfH62S0gFjqyHyBZecTxvP2a6Qt/Rdt2E3StDnkeZHv8Dd5ouEXE92ZLhs
	vEtzmAt5rItIersy47/3EXMEAzMTnvwBb0L4krA==
X-Google-Smtp-Source: AGHT+IGGteJsHxgR3EWxIPX4ekmF8FFLzH3yrNtdNkSNiZJoTME0Oi9hJJmhsEioHBJpUK2qncr9PxTJchD7QRrbI6c=
X-Received: by 2002:a17:90a:5982:b0:2bd:8aed:740a with SMTP id
 98e67ed59e1d1-2bd9f483e65mr1871328a91.23.1716383343671; Wed, 22 May 2024
 06:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522-topic-lemans-iot-remoteproc-v1-0-af9fab7b27f0@linaro.org>
 <20240522-topic-lemans-iot-remoteproc-v1-1-af9fab7b27f0@linaro.org>
 <e89c3270-e51f-4d5b-87db-09ff8f0961e6@linaro.org> <CAMRc=MczvfcXnEae__LJh47T=vCTbCz9EHOrNP+QmpTDvdarZw@mail.gmail.com>
 <42ba8472-9d63-4125-b538-39d8090203b4@linaro.org>
In-Reply-To: <42ba8472-9d63-4125-b538-39d8090203b4@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 May 2024 15:08:49 +0200
Message-ID: <CAMRc=Mcd4qoF-BtHdpHSy5DEDDKYV7RK2hCgegf7_63eRoahTQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: remoteproc: qcom,sm8550-pas: Document
 the SA8775p ADSP, CDSP and GPDSP
To: neil.armstrong@linaro.org
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tengfei Fan <quic_tengfan@quicinc.com>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Alex Elder <elder@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 3:06=E2=80=AFPM <neil.armstrong@linaro.org> wrote:
>
> On 22/05/2024 15:04, Bartosz Golaszewski wrote:
> > On Wed, May 22, 2024 at 2:42=E2=80=AFPM <neil.armstrong@linaro.org> wro=
te:
> >>
> >> On 22/05/2024 14:08, Bartosz Golaszewski wrote:
> >>> From: Tengfei Fan <quic_tengfan@quicinc.com>
> >>>
> >>> Document the compatibles for the components used to boot the ADSP, CD=
SP0,
> >>> CDSP1, GPDSP0 and GPDSP1 on the SA8775p SoC.
> >>>
> >>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> >>> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> ---
> >>>    .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 76 ++++++++++=
+++++++++++-
> >>>    1 file changed, 75 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550=
-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.ya=
ml
> >>> index 73fda7565cd1..9d3a862c39e1 100644
> >>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.ya=
ml
> >>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.ya=
ml
> >>> @@ -16,6 +16,11 @@ description:
> >>>    properties:
> >>>      compatible:
> >>>        enum:
> >>> +      - qcom,sa8775p-adsp-pas
> >>> +      - qcom,sa8775p-cdsp0-pas
> >>> +      - qcom,sa8775p-cdsp1-pas
> >>> +      - qcom,sa8775p-gpdsp0-pas
> >>> +      - qcom,sa8775p-gpdsp1-pas
> >>>          - qcom,sm8550-adsp-pas
> >>>          - qcom,sm8550-cdsp-pas
> >>>          - qcom,sm8550-mpss-pas
> >>> @@ -44,12 +49,13 @@ properties:
> >>>
> >>>      firmware-name:
> >>>        $ref: /schemas/types.yaml#/definitions/string-array
> >>> +    minItems: 1
> >>
> >> This will allow a single firmware name for all compatible,
> >> which is wrong
> >>
> >
> > So increasing the limit from the default under allOf doesn't seem to
> > work, should I instead keep this and make the lower limit stricter for
> > all other models?
>
> Yes add minItems in all the allOf:if: and add the missing allOf:if: for
> the new compatibles to set the minItems, same for memory-region.
>
> Or you may simply spin off a new yaml, this one is getting quite large.
>

Yeah, maybe that's a better idea.

Bart

> Neil
>
> >
> > Bart
> >
> >>>        items:
> >>>          - description: Firmware name of the Hexagon core
> >>>          - description: Firmware name of the Hexagon Devicetree
> >>>
> >>>      memory-region:
> >>> -    minItems: 2
> >>> +    minItems: 1
> >>
> >> Same here
> >>
> >>>        items:
> >>>          - description: Memory region for main Firmware authenticatio=
n
> >>>          - description: Memory region for Devicetree Firmware authent=
ication
> >>> @@ -81,6 +87,21 @@ allOf:
> >>>              maxItems: 5
> >>>            memory-region:
> >>>              maxItems: 2
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          enum:
> >>> +            - qcom,sa8775p-adsp-pas
> >>> +            - qcom,sa8775p-cdsp0-pas
> >>> +            - qcom,sa8775p-cdsp1-pas
> >>> +            - qcom,sa8775p-gpdsp0-pas
> >>> +            - qcom,sa8775p-gpdsp1-pas
> >>> +    then:
> >>> +      properties:
> >>> +        interrupts:
> >>> +          maxItems: 5
> >>> +        interrupt-names:
> >>> +          maxItems: 5
> >>>      - if:
> >>>          properties:
> >>>            compatible:
> >>> @@ -128,6 +149,7 @@ allOf:
> >>>          properties:
> >>>            compatible:
> >>>              enum:
> >>> +            - qcom,sa8775p-adsp-pas
> >>>                - qcom,sm8550-adsp-pas
> >>>                - qcom,sm8650-adsp-pas
> >>>                - qcom,x1e80100-adsp-pas
> >>> @@ -177,6 +199,58 @@ allOf:
> >>>                - const: cx
> >>>                - const: mxc
> >>>                - const: nsp
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          enum:
> >>> +            - qcom,sa8775p-cdsp-pas
> >>> +    then:
> >>> +      properties:
> >>> +        power-domains:
> >>> +          items:
> >>> +            - description: CX power domain
> >>> +            - description: MXC power domain
> >>> +            - description: NSP0 power domain
> >>> +        power-domain-names:
> >>> +          items:
> >>> +            - const: cx
> >>> +            - const: mxc
> >>> +            - const: nsp0
> >>> +
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          enum:
> >>> +            - qcom,sa8775p-cdsp1-pas
> >>> +    then:
> >>> +      properties:
> >>> +        power-domains:
> >>> +          items:
> >>> +            - description: CX power domain
> >>> +            - description: MXC power domain
> >>> +            - description: NSP1 power domain
> >>> +        power-domain-names:
> >>> +          items:
> >>> +            - const: cx
> >>> +            - const: mxc
> >>> +            - const: nsp1
> >>> +
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          enum:
> >>> +            - qcom,sa8775p-gpdsp0-pas
> >>> +            - qcom,sa8775p-gpdsp1-pas
> >>> +    then:
> >>> +      properties:
> >>> +        power-domains:
> >>> +          items:
> >>> +            - description: CX power domain
> >>> +            - description: MXC power domain
> >>> +        power-domain-names:
> >>> +          items:
> >>> +            - const: cx
> >>> +            - const: mxc
> >>>
> >>>    unevaluatedProperties: false
> >>>
> >>>
> >>
>

