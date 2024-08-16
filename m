Return-Path: <linux-kernel+bounces-289645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C67B9548BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0652286239
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E3D1B32BF;
	Fri, 16 Aug 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g1ydmzpZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD5191F84
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811413; cv=none; b=fGDJ6ZHmh5vglI62fjwQXp46r2RoqLHhb8/3RmD74+UMd7F+DAbzAWYZuLyxMulhy0SXQFQ6BMcZxPcAzhcWsNGorBIfD2hBIHtK2XBj9Nbr3C2sJjiYUELobFgsyXMYvDGxmmkcgBd/MQFOFqJ2tqlJ+mcipM1oLEEe4Lf9OJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811413; c=relaxed/simple;
	bh=KEWMVxcu/NLQtr33F3tQHy3IBtqOb4ps9ENmIRZm+W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpIXZec1v0fgVYowB8EWAR5iKvmUExRx2JfeNnxZkOm/4BiWDgmvVr0FuAYlqKv3Xlm8VNy4N3npcjfuUeagr2OYd4GWzSOXLTQcZeUIN3mDJUJSJcJ17ojsqw6W+qKY+vZ2syl7RcQb2NtKiUTEYmM84Y9KJQAh9KqDNgoC9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g1ydmzpZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53301d46c54so2681298e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723811409; x=1724416209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w96eQaH+JFVwUc2NHdKcq4o8sWhYVnxpQd6m10yEznM=;
        b=g1ydmzpZlyIoAsEzBXBw3+psyCyndmGoztl8ZXN7uGBj7hwOEUkoFeBXh+bBeIR/TT
         Nk37KNPO1JhHyJgfr22aAMtI8Gjf692Pua98WGbchNLopYyAX+upK1RV/20nyH+wdGfJ
         ICzRciSIqNlIXtHtpGP4IFnXFu2mzNxZlxG391grEfPsu35kgnCWz/sD98zfVVsxilPU
         TidTK+bVnngIVG/JUUN9mijqm6NaNmRpo4CU3Ir4QpIoVmHalU2gfmrYXGs9agpW1sGd
         OCAYf/TkhTAZN7vBMLIWrRhd98pDYFKbQ/25qSE5Hh2zNphmf32Q3N7k7uO+0xq4JXq9
         mFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811409; x=1724416209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w96eQaH+JFVwUc2NHdKcq4o8sWhYVnxpQd6m10yEznM=;
        b=twCSucCdLYTKlsSMZiOR+VBs3YMqzY8eVmhJarWI8UBiYUVa3Vo+Ov3iXnx2mQhQVF
         VPCf6DGBgxSCOCM1aISrml2oAViQ1wi6qo0EZcwk+k5Y8dSIdlHfInv5vcsEMbFQi4fX
         EhXtg+8LLjmCb+NjlRANU9BRZnFzkKmYa6LSkCmp8ZFMw+HtIuq9O8O+rclnH9ULNBz4
         Sb+2dViwWRyrrC6h4ILgdSLQ87M2YBPQ3LvbhFiRu32lpk8PqOqnHsowINYfKujIZT6I
         GJIUcDf+0MtxnOVg1y9LfyjTMGaQh5+56qS/8rR2mk4jHFXcQntA8xgt+CxmYdxbW4XL
         AaTg==
X-Forwarded-Encrypted: i=1; AJvYcCWHgJAkvDTkTehzplsKNwmLMxBkIWoUsscaDDw2jB3ho2Jyh8LQxnoQC4CVNOzGd1CYugGBt0NXl0OufSd9mADg5+VbYh7W/2XUSeWU
X-Gm-Message-State: AOJu0YysRb++sf9nhdxtBiC2sOpKQgDBveriZqG8jL9vTklc+nERbocK
	zf+N5MzS2nfGiqWL2188AaWQ2SFHNJivUCGK/+NxGdDa/o7qrLEEo73D2WDNNd4GgsszQRdd8aC
	ifVX3yy4yxWJL18MoDFn7Yo5ykPE5DX2GqS2G+A==
X-Google-Smtp-Source: AGHT+IFZaK4vjw4Aem+81rYMCtAGdtY0O6D4wq9Y8v3rCLdzZcg4Vb5soplVtVkp/6l3JtM6+jGW1KtRA1lR1iP6gzQ=
X-Received: by 2002:a05:6512:3dab:b0:52c:c5c4:43d4 with SMTP id
 2adb3069b0e04-5331c6f0065mr1560017e87.53.1723811408941; Fri, 16 Aug 2024
 05:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816102345.16481-1-brgl@bgdev.pl> <c0af2eec-c289-4147-aca2-aac438451f5e@kernel.org>
In-Reply-To: <c0af2eec-c289-4147-aca2-aac438451f5e@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Aug 2024 14:29:56 +0200
Message-ID: <CAMRc=MdmgcRUfYGo25spPOKqjpebiaZUP34B7PuuoAxMAupAYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: misc: qcom,fastrpc: document new domain ID
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Tengfei Fan <quic_tengfan@quicinc.com>, Ling Xu <quic_lxu5@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 1:21=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 16/08/2024 12:23, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add "cdsp1" as the new supported label for the CDSP1 fastrpc domain.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b=
/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > index c27a8f33d8d7..2a5b18982804 100644
> > --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > @@ -26,6 +26,7 @@ properties:
> >        - mdsp
> >        - sdsp
> >        - cdsp
> > +      - cdsp1
>
> Are there more than one cdsp domains? Why adding suffixes? Driver source
> code does not have "cdsp1" domain, so this is confusing.
>
> Best regards,
> Krzysztof
>

It does, Srini picked up this patch earlier today. I'm not an expert
in fast RPC but it looks like the domain ID number matters here.

Bart

[1] https://lore.kernel.org/all/20240805-topic-sa8775p-iot-remoteproc-v4-4-=
86affdc72c04@linaro.org/

