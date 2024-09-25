Return-Path: <linux-kernel+bounces-338298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41F198560F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559B41F228CD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E645213D291;
	Wed, 25 Sep 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMeJsReF"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146815B0FF
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255229; cv=none; b=B/iMbj3kpguyK6fiVRboidBOBV14wI5bPNPsKsn6c1Us5gIGYlHpjwPFjn3UMuNsT6Hqd+89nErwRevyOaEqvUbVfrPcXlJ5oPZu87DPQNY6+vlN2gE34KtW8bwrg2LT4ep6FSVguWKywIxPCw/T5QsaUb9VcH7x4xrNX01A8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255229; c=relaxed/simple;
	bh=0+5X/NfbYD2dkRK1zy5X4k/dPkx9lpuT3S65Jov3390=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7J1RkTBhO5h1/omOtPXJZ2q1LJTJsRw2ba0Kxh2RoniZekImzUBiVDktcrSE45A6a0RbZA59BtfLR6mtW7dQ4X/w/OCbY+AS+UM+zw+vKo7d9OU47vHATPbBNjFubKD4JpORNZXtfEvF89oI7VSYcvJ5Qo3FgdxXjjn27PP6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMeJsReF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ddcd0b4c59so60881617b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727255226; x=1727860026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UlnD+34HrIONho00Da4MJk+qHahTYRxRnGls87oH0N4=;
        b=mMeJsReFsbd/ZwLf5WoMFbZ3gUouhcYRFMKeGNWbV5Sh0/51TmM9eCRNlZOGynth3o
         8twXaL1Fo2EkK2GTinEQPTqgN10Iki/hnuQcAxNyQFl2asaBYq4ppSIh2WQKdFDhqs0x
         qgkeE1yf2M18Y4+dZCJqMClA9CTWJG3Sjev7zQO7qxGj7VWVA26oewWmNWWVYMzJ5BqK
         ijGn8D5/E23niq7YQ9dCA3NNbskuvDfLXI0mOnkZ2nMh+ldIcIIWGN+IjlNHUr3gaOsk
         9i5hnBVagTgh3EWPFZXN3Zi/falN7z+g0Zef50eeyEdPeN9CrSp6Bwre2T3FPEc/8ns+
         yARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727255226; x=1727860026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlnD+34HrIONho00Da4MJk+qHahTYRxRnGls87oH0N4=;
        b=byVOoml6WexC8k/RYxPE3uRM2WJo35EdZG6PS+CKpBYftlLqvhXHO8tcF/5hERxyuO
         fVOqrbMuX29I40bS3yfkEESYgVELQGAl8ALFoYx3UMR+120i0tO8xMOtdH/usQEN7aEc
         p7X9I0FN7hAGyoQAES3ZoUDSiJ6v/7EavmLfZ+zR9olO/m2kj5GvgpR6ODcmPl+c/yOQ
         4B7J/xYrSrh9daWeclYq8W7zECDC41O5B31gxdUfXJ+bIOJv8QeYAZV9ApwufEdy45QQ
         5xxPv2Xh3jsvd8Au/j7+VpAio2PJ2NNpfxRYycJ63CxjYuOhlolWK6HiqldCj88+gZiL
         XtHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI+BEttmyXLhekj1NDY5wHKOLJ07Z2P0Ci9yTgDXZrqR6Rebyn0bJp41lnpwkZCNMVuTO0uZrDEAFl/Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWi6twq7pel4UTz+5jUc1WSMvvl77d3/SySbnyROh0FI9IbQ3U
	RqKLQMXgy2xWbNO140nUMjAyveBUarxyVEUEbNvlJFM4MESXd0foxdQyYKWSM3HN376g4dR+FZm
	10PFEGsl1i4JqY5Ty9T5B/6iAMmF1LcZFajOeAw==
X-Google-Smtp-Source: AGHT+IEackEoo1TjB/e4cAQVTNwDplB4aHvCPwpjjiyPZWQErysw0w+VWgPSUxQpxc+bmK5wVaAi2heln1+aKexMIf8=
X-Received: by 2002:a05:690c:dd4:b0:65f:a0e5:8324 with SMTP id
 00721157ae682-6e21d6e4276mr17740177b3.4.1727255226216; Wed, 25 Sep 2024
 02:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925-qcs8300_remoteproc_binding-v3-1-21b0c52b142b@quicinc.com>
 <bxkkqezsvvgf7xi6nhxjdpxhr76lrcjp65gtk56x45nhkygdmh@z3lzuz6honcg> <2144d060-7454-46a3-96ed-6173e1ba2523@quicinc.com>
In-Reply-To: <2144d060-7454-46a3-96ed-6173e1ba2523@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 25 Sep 2024 11:06:57 +0200
Message-ID: <CAA8EJpoFpiyBC9eTY8tLyaV5Lqr-YjxckK22Twxae0kGYOWz4A@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: remoteproc: qcom,sa8775p-pas: Document
 QCS8300 remoteproc
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, quic_tengfan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xin Liu <quic_liuxin@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 10:35, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
>
>
>
> On 9/25/2024 4:01 PM, Dmitry Baryshkov wrote:
> > On Wed, Sep 25, 2024 at 03:21:37PM GMT, Jingyi Wang wrote:
> >> Document the components used to boot the ADSP, CDSP and GPDSP on the
> >> Qualcomm QCS8300 SoC. Use fallback to indicate the compatibility of the
> >> remoteproc on the QCS8300 with that on the SA8775P.
>
> Hi Dmitry,
>
> >
> > Are there any SoC-specific quirks that demand a separate compat string?
> >
> > In other similar cases (sm8250 vs qrb5165, sc7280 vs qcm6490 vs qcs6490
> > we are adding new compatibles only if it is expected that the hardware
> > (or firmware) is actually different.
> >
>
> This case is different from the cases above as qcs8300 and sa8775p are
> different SoCs.(sm8250 and qrb5165 are different variants for the same
> SoC). QCS8300 has one cdsp&gpdsp while SA8775P has 2, but they share the
> same driver data, we used to discuss with Krzysztof how to deal case
> like this and got the following suggestion to use fallback in yaml:
> https://lore.kernel.org/all/6652a08e-7143-4214-a864-9f27c10d7571@kernel.org/

Ack, excuse me. I got confused by qcs8300 vs qcs9100.

>
> >> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
> >> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> >> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> >> ---
> >> Changes in v3:
> >> - add "contains" and remove redundant compatible.
> >> - Link to v2: https://lore.kernel.org/r/20240911-qcs8300_remoteproc_binding-v2-1-01921b110532@quicinc.com
> >>
> >> Changes in v2:
> >> - decoupled from the original series.
> >> - Use fallback to indicate compatibility with SA8775P.
> >> - Link to v1: https://lore.kernel.org/r/20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com
> >> ---
> >>  .../bindings/remoteproc/qcom,sa8775p-pas.yaml      | 44 +++++++++++++++-------
> >>  1 file changed, 30 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml
> >> index 7fe401a06805..a66007951d58 100644
> >> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml
> >> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml
> >> @@ -15,12 +15,25 @@ description:
> >>
> >>  properties:
> >>    compatible:
> >> -    enum:
> >> -      - qcom,sa8775p-adsp-pas
> >> -      - qcom,sa8775p-cdsp0-pas
> >> -      - qcom,sa8775p-cdsp1-pas
> >> -      - qcom,sa8775p-gpdsp0-pas
> >> -      - qcom,sa8775p-gpdsp1-pas
> >> +    oneOf:
> >> +      - items:
> >> +          - enum:
> >> +              - qcom,qcs8300-adsp-pas
> >> +          - const: qcom,sa8775p-adsp-pas
> >> +      - items:
> >> +          - enum:
> >> +              - qcom,qcs8300-cdsp-pas
> >> +          - const: qcom,sa8775p-cdsp0-pas
> >> +      - items:
> >> +          - enum:
> >> +              - qcom,qcs8300-gpdsp-pas
> >> +          - const: qcom,sa8775p-gpdsp0-pas
> >> +      - enum:
> >> +          - qcom,sa8775p-adsp-pas
> >> +          - qcom,sa8775p-cdsp0-pas
> >> +          - qcom,sa8775p-cdsp1-pas
> >> +          - qcom,sa8775p-gpdsp0-pas
> >> +          - qcom,sa8775p-gpdsp1-pas
> >>
> >>    reg:
> >>      maxItems: 1
> >> @@ -63,8 +76,9 @@ allOf:
> >>    - if:
> >>        properties:
> >>          compatible:
> >> -          enum:
> >> -            - qcom,sa8775p-adsp-pas
> >> +          contains:
> >> +            enum:
> >> +              - qcom,sa8775p-adsp-pas
> >>      then:
> >>        properties:
> >>          power-domains:
> >> @@ -79,9 +93,10 @@ allOf:
> >>    - if:
> >>        properties:
> >>          compatible:
> >> -          enum:
> >> -            - qcom,sa8775p-cdsp0-pas
> >> -            - qcom,sa8775p-cdsp1-pas
> >> +          contains:
> >> +            enum:
> >> +              - qcom,sa8775p-cdsp0-pas
> >> +              - qcom,sa8775p-cdsp1-pas
> >>      then:
> >>        properties:
> >>          power-domains:
> >> @@ -98,9 +113,10 @@ allOf:
> >>    - if:
> >>        properties:
> >>          compatible:
> >> -          enum:
> >> -            - qcom,sa8775p-gpdsp0-pas
> >> -            - qcom,sa8775p-gpdsp1-pas
> >> +          contains:
> >> +            enum:
> >> +              - qcom,sa8775p-gpdsp0-pas
> >> +              - qcom,sa8775p-gpdsp1-pas
> >>      then:
> >>        properties:
> >>          power-domains:
> >>
> >> ---
> >> base-commit: 4d0326b60bb753627437fff0f76bf1525bcda422
> >> change-id: 20240925-qcs8300_remoteproc_binding-a2837bab2150
> >>
> >> Best regards,
> >> --
> >> Jingyi Wang <quic_jingyw@quicinc.com>
> >>
> >
> Thanks,
> Jingyi
>


-- 
With best wishes
Dmitry

