Return-Path: <linux-kernel+bounces-285252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19DE950B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584121F23115
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69681A08CB;
	Tue, 13 Aug 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="TQZrSouc"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA35198A3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569056; cv=none; b=e3OBx722j+w117gwbZrNIMuK2iC+KBZUsklG/GzAYAamen+YCfJRNe3pU9y5+N+20j7l7S6cUExZRC3LEMy0lbBPo3BsJVxCUEcvaQKve90hewQQZc+DDX+tp+ACMHRhEtMGftUJX8IfjzSJXETXA4yP2BI6Q/L+QK+hp+D0D9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569056; c=relaxed/simple;
	bh=7ympOJZpNt6WSAnm/Uh1NWzgl3X3DNcEPRJW0FlCpH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3UBshIlfUlc6pW9vc3F3dmf9oExav+rh/SHMokeZP06AFHwMr97bbJlQDeRV50YOFka8JhVFTZ3Mli2T8Vur+6J5iF7jHgAV2KzL+BxUkOL3AJV7AiPocAnvvGr7WPowagRY7dbf76AK9iyj0B+TW6BoqX5TXZeUhBFFQuOgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=TQZrSouc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a94478a4eso10343666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1723569053; x=1724173853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhtBUgLnrDhhdGzlxz/BjFJWhCixCkk0gwuIiyZNKtA=;
        b=TQZrSoucQrjeY7jtGNp4htRYvEgfiZVuQ0YjK4seJ4LfWF+D2gkZgqek7FFuBnQ9Oi
         joQHyot/0WW3CQSmVyFAwnSTPo5aIIzmGXoX6RLydCbP/ZgmYBhzKSogH+kplaFKcPML
         CW0vGLgpZZwqKH4Se8x4KmXvPTmlGpw/jMJOT+wssNoUN/F/2RKzy1KAPLDqu5vnJP7x
         m7tMuPJhu5Gk6RTTU8iTfioav52Nu85EHYcEPvG9UmKIqqbYVShGv5wiuIh7rtAG0aRa
         X2ej4zvW7klyFSaCv1zDCPocen8aY2iUBlAOJ+b7qDWDS0aLFN+c/mVJ35vGksQb5K2O
         7Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723569053; x=1724173853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhtBUgLnrDhhdGzlxz/BjFJWhCixCkk0gwuIiyZNKtA=;
        b=wStRiC9OT8tUyv+CDk7ULdfAZYmUBb/F4wSf8BXmDLeJ1SfC2nBli2xtEHaAr4ZjEp
         sY6sN6624oV05TRFuCRPCAbVAx9IIA9oS7QzP1riZSwzpTund6F6ZhXuBYfeaFGdk30I
         QK88LifRJPT6Y8X2wPt+81itzZ+BgzxDMjYfiFhLfMcIEdv6RGQgMY+QFI7dJgeVZEXl
         aFIjrGEb6SL50iOBYhdP9JOQuMrPIBrC5fFh3DusLNYkZ2dze4/qJyiFllYdCBzPweJV
         tCSKL4Hsw6GF2ug5+IeCoMCJU3mHYpQV/9Yo7RSM9Rf9J+j1X1qcHJlQ8dIhdxkQ/0JG
         gyBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUINYWAiYuAi3vkBhjs3RScZFNoNF1sGFvtcBV0OZCVpEz9h4+JrK1Gj69Gc85lv1ZBLecZOHjEYX7OX3SjFa7rpBNLHFw8PZ8wsEbb
X-Gm-Message-State: AOJu0YxuzFXiRbHNNDdw4LkwlU4lZZ3NdMQIVz619v4asH0LRpzzT4uL
	YAX9ufGd4oV2L07caQMMBn1v6kTPFy5qTdifnEb9Wd7zUBDngL0/Fo2KLj90QHIcGIXeMPW7x9F
	oRcdpSBaArDYCqbtiU+B33D67Mu+JNdkGBFklNQ==
X-Google-Smtp-Source: AGHT+IHfrLoNeAHUzX9iSp5yG/DmHNHyvEWlECdWd2S20k6QEuCIF2JQ1mr7dl/AjYpPPWLrA6gS9nYLsHONqns987s=
X-Received: by 2002:a17:907:f729:b0:a7d:c352:c502 with SMTP id
 a640c23a62f3a-a8362d64c1emr33673666b.30.1723569052201; Tue, 13 Aug 2024
 10:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522215043.3747651-1-tharvey@gateworks.com>
 <CAL_JsqKtc_65tDMFWT0WroNPmW2R0Dd-4Jw101PnyJcPb=7tJA@mail.gmail.com>
 <CAJ+vNU0LBEET=y40BT4OE0zWsu6DxT-SYOrx7qD-h=HH2zENzA@mail.gmail.com> <4faa6881-8828-44de-92fd-6e55495cefb2@linaro.org>
In-Reply-To: <4faa6881-8828-44de-92fd-6e55495cefb2@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 13 Aug 2024 10:10:40 -0700
Message-ID: <CAJ+vNU1ff0c=wJoVTENGSV5Y3Yh_w5mTU-xoA9XgOX-x744=EQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 9:34=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/08/2024 18:22, Tim Harvey wrote:
> > On Fri, May 31, 2024 at 7:13=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> >>
> >> On Wed, May 22, 2024 at 4:50=E2=80=AFPM Tim Harvey <tharvey@gateworks.=
com> wrote:
> >>>
> >>> The GW7905 was renamed to GW7500 before production release.
> >>
> >> Maybe some summary of the discussion and how this changed from one-off
> >> to wider availability.
> >>
> >>>
> >>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Hi Rob,
> >
> > What is the status of this patch? I'm not clear what tree the
> > Documentation/devicetree/bindings go through.
>
> Always via given subsystem. Which subsystem is here? Maintainers should
> tell you - ARM Freescale/NXP.
>
> See also:
> https://elixir.bootlin.com/linux/v6.11-rc3/source/Documentation/devicetre=
e/bindings/submitting-patches.rst#L79
>
> Best regards,
> Krzysztof
>

Krzysztof, thanks - that makes sense.

Shawn, what is the status of this series [1]

Best Regards,

Tim
1 - https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=3D85=
5146&state=3D%2A&archive=3Dboth

