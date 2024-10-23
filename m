Return-Path: <linux-kernel+bounces-378278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 474D39ACD80
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0361B1F21E09
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0981D0F77;
	Wed, 23 Oct 2024 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7jGJCf5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320B1CB51D;
	Wed, 23 Oct 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694322; cv=none; b=pRzpRM1j5PO0Ctx09Zb7Hmf7jo8Eo38fJJVYgqxX9MTTwlDd0Zm8uaYtrtclBibRVgPprjP68dwojvvXc0lgms/nj/MgXSO2dz/SvLbaSSX0qls46PkN+cqNFeNXa9O6sebMB60jhAFYyx/Obd2nEOX8i5ICNlEGiQMCUZNgc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694322; c=relaxed/simple;
	bh=0JqvrPoAl0IeTaLk4IwiVcZMi7aNs5KY80Y/mwm0Ihs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJ5IcCN7nPsQKWtOI6gnuJrs064+KH6AQTHAHJakFmIA0ZBZ4trVngA9awmyfRuwB7QUcUxdXi3f517ZL1ouuVtgmLRk0a4gbQ3pd0aMJTcqlmw0H1Jk421/wrRKQ1UUMfCaXx3399VsbkwLUk6+szJ93wEA0FhGBECnjXmxiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7jGJCf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14F4C4CEE5;
	Wed, 23 Oct 2024 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729694321;
	bh=0JqvrPoAl0IeTaLk4IwiVcZMi7aNs5KY80Y/mwm0Ihs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y7jGJCf5XPlg6FhMcZZxHnU43XGMqCWy0zgJZiTZw3LmL9uIaoEggURVp2ODsOpdo
	 +300kakIpAx0/GKN3TnxZyh5oEhjHgtwTuMtIqsGukcF6Zndd49LtkNXg1gbGYx0vj
	 5DGX4Dh1AZTC26GNlCEWSzsgFWMxRuV8kJFELNuCzSUcnWlNL2t+ac8d7WNbUeknf6
	 gRz6eUNoXkcuOIN6xMWt4etfHrdyk/bG4MaA6a0DtuyUQ6tseUKopwP3cPdIzako4Y
	 CN/903JmCJLvpQokdP3vjoykoEMq9kWDubY2Kpn9uW1DKHPuc++54KNYjkTH1GY53F
	 +2S2JKwAzjB/g==
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e74900866so4661757b3a.1;
        Wed, 23 Oct 2024 07:38:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtUflVdBbYdHSear5cTOyLuDfiaE4OJlQEVsp/tpBM0z4n1ksLqQUIiTj3L6MkW5U/Rt68yFntUBAJ@vger.kernel.org, AJvYcCVtdL+PwCS7UnMzgeWI537R+HiJaftoNciRyGzhEsqu0C5JoF9y2L6tvc/j7tnQrghA8haTYlS55FAhKJDs@vger.kernel.org
X-Gm-Message-State: AOJu0YxEb0r2rD34aiP7owUhkDIrVSaAl6SbB8jPKH3KTMXMeMjdisBx
	bUq58nUmrp5q7TNVofAdAJ6TYW/Qyivt/3ehvjzuFZBYy8xRLVvBZjeYtRAIsQ5kqgrxBbN3qa3
	WDe0A3C/waLjnM3SwFQtM+7MH/w==
X-Google-Smtp-Source: AGHT+IG/RdVxY7RG85NyF0P3I6XAtxRrRLMBLPXslpGReJZYhGUeFy1bxVKhKy/eGSVOAqET/hE7xY0gvgcONdeUlT4=
X-Received: by 2002:a05:6a00:ccf:b0:71e:795f:92e4 with SMTP id
 d2e1a72fcca58-72030a61bccmr4130356b3a.2.1729694321137; Wed, 23 Oct 2024
 07:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019052935.553886-1-fshao@chromium.org>
In-Reply-To: <20241019052935.553886-1-fshao@chromium.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 23 Oct 2024 22:39:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9qjcZoQS3KqEqbhKNw9nza+1ggXN44snwThzjLLJ2KNw@mail.gmail.com>
Message-ID: <CAAOTY_9qjcZoQS3KqEqbhKNw9nza+1ggXN44snwThzjLLJ2KNw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: mediatek: dpi: Update device list
 with power-domains
To: Fei Shao <fshao@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, CK Hu <ck.hu@mediatek.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Fei:

Fei Shao <fshao@chromium.org> =E6=96=BC 2024=E5=B9=B410=E6=9C=8819=E6=97=A5=
 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=881:30=E5=AF=AB=E9=81=93=EF=BC=9A
>
> There are two kinds of MediaTek DPI devices in the tree: the ones with a
> power domain and those without (or missing). The former are the majority
> and are more common in newer DTs. Only three older DTs fall into the
> latter category: MT2701, MT7623 and MT8192.
>
> However, the current binding only allows particular DPI devices to have
> power domains, which results in spurious binding check errors against
> existing and new DTs.
>
> Instead of diligently maintaining the allowed list, let's do it the
> other way around - create an exception list for devices that are fine
> not specifying a power domain. This list is expected to be fixed, and it
> encourages new MTK DPI devices to describe their power domain whenever
> possible; if not, those should be listed with proper rationale.

I've applied patch [1]. I think that patch fix the same problem with this p=
atch.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
commit/?h=3Dmediatek-drm-fixes&id=3Daf6ab107ce2c338790c6629fe0edc0333e708be=
8

Regards,
Chun-Kuang.

>
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
>
>  .../bindings/display/mediatek/mediatek,dpi.yaml   | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index 3a82aec9021c..c464642bbfb6 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> @@ -81,14 +81,13 @@ required:
>
>  allOf:
>    - if:
> -      not:
> -        properties:
> -          compatible:
> -            contains:
> -              enum:
> -                - mediatek,mt6795-dpi
> -                - mediatek,mt8173-dpi
> -                - mediatek,mt8186-dpi
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt2701-dpi
> +              - mediatek,mt7623-dpi
> +              - mediatek,mt8192-dpi
>      then:
>        properties:
>          power-domains: false
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

