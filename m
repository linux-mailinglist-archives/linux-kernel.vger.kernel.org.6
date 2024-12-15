Return-Path: <linux-kernel+bounces-444677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA969F0ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB82832A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166F1DE8BF;
	Fri, 13 Dec 2024 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="XC08qcs/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2FE1DE3C2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089078; cv=none; b=czcWDDhy4JO5SMZv4qJJDW4kGml5Cqg4OpQDW59iptX9EqU3DDJKg6QFLTECk5oVFTmmSN96BxHuivTc9n7RZntH+nPRj2EE6r7gY2QH6ingUkLfvU9QDD+8VzjCP7Czvz7gdL4H2Zvh6YZ/RkyPvapcHbU3U5Brm+LuC0Y9Q0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089078; c=relaxed/simple;
	bh=snnh96pafNFzlEpT/qqdrFsTpjfx5iGzHzQONIqPb+E=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Bi5pDEUJx06YY9C40KU3JfStIjh4qiKS/nNHoQX6G8J6heuHCJFo4TQBNzaUpBodxXi6EFzziYJz1uoNMubEZp32xgaLCG2AdBrAkqV1FRM5eG3u2hLDMmRoULyZfF5Vz9fdy0fFx9b5CsDKpHwaPn1bnxsdZjrMIGlXyAgzTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=XC08qcs/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso2986915a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1734089073; x=1734693873; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cnpyzu6lv8YqeO3d0+ja8kODHWMWdakay6mWzpL+xrc=;
        b=XC08qcs/GnkR6q930WQaHaIhGb0T6vC357d9JhitFZj0PPNRuVvLwMIXZr51ZiXlPl
         Yww46o/PxEenLWZ0S9Tkx/mgK/jk2carse48+LjINOZ5OVgDU7OAw96FpAdlZn9bVEIk
         Wixlx4SvS9J8IepeeShU98+UCnDhDD0pxaC87ThFpCPsIZ32M/yU0zm/g5s20q1aRbH1
         ih0VdN6k7ktxyp6rHgdYGBPxIaBqESHOrhQxOFSqHYB+c+iST6crJaDY9wtpPrMz6Dfp
         6cXn7Wfkee6xjYK9jaNCH//tXvY7e2zGSDd/ozFf2WTRrWRTNBTy+HzEJBE8TafoUv4b
         LmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734089073; x=1734693873;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cnpyzu6lv8YqeO3d0+ja8kODHWMWdakay6mWzpL+xrc=;
        b=dZWHa/BojxSr3uZCAD+oGADFOX+xZDKaF4qeXSGxT1vcS2S/FYAXteE6AjYubGIFBy
         zmRGEshpnaCKVI5tIXv6Y7+OKCuMh8+MUU3ZUBE3FqL0B21y9wWKCg2Q4UGh1dxvUWK0
         K38Lr1mz9i/G9TGEyY0twEmISVrF3PiySQwLnFT6tFqMQ9nXw6BgfYjxH8b0vk+YLNwo
         f7xladTV+15yoyZCvkoNKsT1JU/hY9iLFHB1Zpl/zmy8B+ggYnjLzT+uj7WX/y9i5Ezi
         WTO0DJLHsd28yAR4GRObBVuzUOudMTxqSWv3AS7fBZhl6UJH6QEW+GcTRnm648AT2h9w
         Y86g==
X-Forwarded-Encrypted: i=1; AJvYcCXg2LSZu849t3bLb1Xohox/T/VEo4ox2BVwzIv687j7LxQwOAaqLJhWLa27k4uyKkCReHlfg0B+xyOz3wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxUshPF34MfVLb6Bz6nfu0MFS8xrloB2cxe5e7I3+U3BIJLuMV
	2RPKUBDnpkExrLQvWSIH3Y2fYnB+TTAtONXxIuLuHifpjsaGpExbB5uw8Bs4KRw=
X-Gm-Gg: ASbGncslFyFri/TueITj8jCVKN2nDo0umX3/sLSUnHdxsUKCrb6+kgDW2d3mosnAIPy
	QmlVwu7NAvo28nfBVZsOzzaVoyjKf8AYG2kCj6L3+GX7P64KLsm1TqwiBBi13bOu9YE3V6zSMnW
	TYjcQ+Db78VDxcveiF8IHYHHVDUCBukD1YTN9roNigBxluFn200U65pDxUZa3pZuWzZb44FnTK9
	JRY4EF5zIZA9jJi+18Dc+R6N9x6Pm5M0zx7ygoTJBwRuFLZP3/0umQ3DK2vCBcJdGy6ZUXh0Zv5
	bH1WVVXQKhT4OGbkJxDsWEHU4Q==
X-Google-Smtp-Source: AGHT+IGeg0s4qNRaUPzwDALdquV88wvtgMDBcH6o5c3axPun64tbEAiTsdkSUr1tnrXedXMx3+v/Kw==
X-Received: by 2002:a05:6402:3551:b0:5cf:f42f:de82 with SMTP id 4fb4d7f45d1cf-5d63c2e51b6mr1610106a12.7.1734089073267;
        Fri, 13 Dec 2024 03:24:33 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c74c3d5sm11349614a12.52.2024.12.13.03.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 03:24:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Dec 2024 12:24:31 +0100
Message-Id: <D6AJ9U23ANWI.1DLHNPU5A6HQ4@fairphone.com>
To: "Vladimir Zapolskiy" <vladimir.zapolskiy@linaro.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
Cc: "Robert Foss" <rfoss@kernel.org>, "Todor Tomov" <todor.too@gmail.com>,
 "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Barnabas Czeman" <barnabas.czeman@mainlining.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@somainline.org>, "Caleb Connolly"
 <caleb.connolly@linaro.org>, "David Heidelberg" <david@ixit.cz>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] media: dt-bindings: media: camss: Restrict bus-type
 property
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241209-camss-dphy-v1-0-5f1b6f25ed92@fairphone.com>
 <20241209-camss-dphy-v1-1-5f1b6f25ed92@fairphone.com>
 <nqggstwkytqxpxy3iuhkl6tup5elf45lqi3qlgyv6eaizvnfdr@2uy57umdzqfa>
 <e4bd515a-eb98-4ea1-8d73-4ba5e7c9b66e@linaro.org>
In-Reply-To: <e4bd515a-eb98-4ea1-8d73-4ba5e7c9b66e@linaro.org>

On Fri Dec 13, 2024 at 11:50 AM CET, Vladimir Zapolskiy wrote:
> On 12/13/24 11:34, Krzysztof Kozlowski wrote:
> > On Mon, Dec 09, 2024 at 01:01:05PM +0100, Luca Weiss wrote:
> >> The CSIPHY of Qualcomm SoCs support both D-PHY and C-PHY standards for
> >> CSI-2, but not any others so restrict the bus-type property describing
> >> this to the supported values.
> >>
> >> The only exception here is MSM8916 which only supports D-PHY. C-PHY wa=
s
> >> introduced with newer SoCs.
> >>
> >> Do note, that currently the Linux driver only supports D-PHY.
> >>
> >> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >> ---
> >>   .../bindings/media/qcom,msm8916-camss.yaml         |  8 ++++++
> >>   .../bindings/media/qcom,msm8953-camss.yaml         | 15 +++++++++++
> >>   .../bindings/media/qcom,msm8996-camss.yaml         | 20 ++++++++++++=
+++
> >>   .../bindings/media/qcom,sc8280xp-camss.yaml        | 20 ++++++++++++=
+++
> >>   .../bindings/media/qcom,sdm660-camss.yaml          | 20 ++++++++++++=
+++
> >>   .../bindings/media/qcom,sdm845-camss.yaml          | 20 ++++++++++++=
+++
> >>   .../bindings/media/qcom,sm8250-camss.yaml          | 30 ++++++++++++=
++++++++++
> >>   7 files changed, 133 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-cams=
s.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> >> index 9cc0a968a401836814560c1af3ee84d946500b4f..3de2a3d2b5b761106975aa=
b65ff614b2ef579ef5 100644
> >> --- a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> >> +++ b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> >> @@ -94,6 +94,10 @@ properties:
> >>                   minItems: 1
> >>                   maxItems: 4
> >>  =20
> >> +              bus-type:
> >> +                enum:
> >> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
> >> +
> >>               required:
> >>                 - data-lanes
> >>  =20
> >> @@ -113,6 +117,10 @@ properties:
> >>                   minItems: 1
> >>                   maxItems: 4
> >>  =20
> >> +              bus-type:
> >> +                enum:
> >> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
> >> +
>
> But is it really needed to specify the single supported bus-type?
>
> I believe it is not, at least it's not ever done for other media devices
> like sensors.

Through video-interfaces.yaml 'bus-type' is already allowed but not
restricted to the values that actually make any sense on such hardware,
so in my opinion this makes sense to have here.

>
> Here I would prefer to get a comment from Linux Media and/or DTB experts.

I'm far from either, so happy to get more comments on this!

Regards
Luca

>
> --
> Best wishes,
> Vladimir


