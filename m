Return-Path: <linux-kernel+bounces-384804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F021F9B2EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496B0B245E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC34F1DCB1F;
	Mon, 28 Oct 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bP0CfYnM"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AC1D86E6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114021; cv=none; b=C4IamVKl1tpWdhHHVa9EQNBlrEVlHPk2H0hZyjCqCCkwxVzc1mZhTvLGxJDZHDJ/uuuUY9Zm9w7QiPDXjfJ+CR9nGmNgxuc+ceyPJJGQrPp2yEfhVSMvT3JKYOY/dhm3Ut1v9wsacs1npRfMqe98FV798P30YklzGpgYeq5JNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114021; c=relaxed/simple;
	bh=67sSyJJi9WY1L30HSgX3jBgORDysaAJJpImWjA7Myno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTQTjLtYSTx5dn/Gd8eCAhdk79USKQKjEAImKStteStaBsY3kixDclnDjGnReLDoWXv4xFPRxSOn8rGh+LoXr8MuSjw+fnKMuCkm9vKS9UcMaLj0shZocl/JPOk3u7IqlBcjfYIB4XTrcQDtlZGCjuwWJlK69W2ioEyaJNwLl3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bP0CfYnM; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4a487a7519fso1402597137.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730114017; x=1730718817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdHIuXNcRTp7WeqJ7Dz3GAtmBDa+RGbotWoT8FSQELk=;
        b=bP0CfYnMUXLRpwqwSTqK/ay3NZ56zcZ4XAYHiGKE460Asw91BEGFTCkqJEGc743Ecn
         s3JF0WYSqMrH6qsyF2fk1X+ZGoAAoAy+vNCPhqin+hbKsZvV3Fd15ntFP5jAI4Sm2ujM
         3dAuVCkLBO2NcmTyyLTM8zTdJio43Pz2R3DNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730114017; x=1730718817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdHIuXNcRTp7WeqJ7Dz3GAtmBDa+RGbotWoT8FSQELk=;
        b=kIuVIdJk5HAYHmrPSCnYerEDsnpO6R8ynglQ8+/zF/gzfUnso/KV+4AT54RW0HgD3T
         uXiJIE2/UkLI/4N5G6iCGFbW+sj5buuZATHg6aaKY2LPr73B1RoAE62Zq9c0EqmjXPwD
         leLlRa0MEkH3yJH7SQHiL1XBqcJ7y5Nts1KBrlW8XfKXeRPm5I9zE0t48NgzSkKFu3yj
         r4XmjvJf8uD0cJLVDjSmzsh9rLgcRBCtkkXtlg7qHNQHNyMSqmiv12o4e5fValAFgdUK
         UM/SXzOZtSwl8oSdSVMoPLfQvwMkB3ybjB6Q4L5UBJtmQ2Ed38TOJzB1s+3p8rwnWYB/
         91KA==
X-Forwarded-Encrypted: i=1; AJvYcCUxHgQv5n+AT//r50L9uGV4aArd9eZh8lhhprdrVsZ5wSsHhYEtX7ivVHYGDOasN16Y9Igb3ad4TkQ2VcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC66uJbe4ZiS6NnbeYkU0Cua9HxNmldNOorpTmQEklKTmtVUyw
	Trv8YQaZTg6NvQFzRUmW9ga92Furj+mh8XR1VySQGoSXZG1AYLAtZXbj9rSx785FOqCZRdXHofo
	=
X-Google-Smtp-Source: AGHT+IG9pBkpXgS7RPVjNLC4u4V8OxFa8jHui2VzFdK2lA83fDazLKBp2oTclXikDvf44DCr/mOFig==
X-Received: by 2002:a05:6102:41a2:b0:4a7:4642:8b67 with SMTP id ada2fe7eead31-4a8cfb61726mr5607831137.17.1730114017500;
        Mon, 28 Oct 2024 04:13:37 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a8c526784dsm1021670137.18.2024.10.28.04.13.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 04:13:36 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d2d300718so1129026e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:13:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWphxyyDr5iPQHcohzFSyD/KXYx/uTDn6/GWfY0ch2zr1C7rXd2GzygnhzT76sAwfkf1l9t2CNN0wHpVWU=@vger.kernel.org
X-Received: by 2002:a05:6122:1786:b0:509:e278:c28a with SMTP id
 71dfb90a1353d-5101504d301mr4253732e0c.7.1730114015383; Mon, 28 Oct 2024
 04:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025104548.1220076-1-fshao@chromium.org> <20241025104548.1220076-3-fshao@chromium.org>
 <j5qw52grlce63mccduvryx467h4hvcnqrxrova74d52izq3g5r@wjiflssmq6a5>
In-Reply-To: <j5qw52grlce63mccduvryx467h4hvcnqrxrova74d52izq3g5r@wjiflssmq6a5>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 28 Oct 2024 19:12:59 +0800
X-Gmail-Original-Message-ID: <CAC=S1ni-F_oudNyskSbxS1s2gZG7m4U4+nLxt0=dt5+DDkhV4Q@mail.gmail.com>
Message-ID: <CAC=S1ni-F_oudNyskSbxS1s2gZG7m4U4+nLxt0=dt5+DDkhV4Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: mediatek,mt8188-mt6359: Update DAI
 link node pattern
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Rob Herring <robh@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:56=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Fri, Oct 25, 2024 at 06:44:42PM +0800, Fei Shao wrote:
> > The associated machine driver is not dependent on the format of DAI lin=
k
> > node names. This means we are allowed to use more descriptive names
> > instead of indices without impacting functionality.
> >
> > Update the binding to accept arbitrary DAI link names with a "-dai-link=
"
> > suffix. This is the common pattern used by the target (MT8188) and othe=
r
> > (MT8195, MT8186 etc.) MediaTek-based Chromebooks.
>
> We do not want arbitrary names. Why for example green-batman-dai-link
> should be correct? The existing pattern looks wrong. Please read DT spec
> and chapter about recommended names.

At first I was thinking about regex like
`^[a-z-]+(-[a-z]+)*-dai-link$` based on the DTS coding style guide,
but your example is not suggesting that.
and the name like "hs-capture-dai-link" was rejected, so it's not just
about enumerating the names either.
Or "^dai-link@[0-9a-f]+$"? But they don't tie to particular register
addresses... or just for some pseudo indices?
I could miss something about DAI links under the sound documentation.
Still trying to figure it out.

>
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
> >  .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml     | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt=
6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.=
yaml
> > index 701cedfa38d2..2da34b66818f 100644
> > --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.ya=
ml
> > +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.ya=
ml
> > @@ -40,7 +40,7 @@ properties:
> >        name defined in the machine driver.
> >
> >  patternProperties:
> > -  "^dai-link-[0-9]+$":
> > +  ".*-dai-link$":
>
> This breaks existing users.

There's no existing users in upstream, and the only downstream user is
the MT8188 Chromebook DT that I'm trying to upstream, which I can fix.
This binding was upstreamed exclusively for that DT.
Even if we take a step back and assume someone has another DT already
following this pattern (and that would be a surprise), this wouldn't
break anything except a dtbs_check error, which would be trivial if
they don't run that or attempt upstreaming. The driver doesn't use
node names to distinguish DAI links.
I want to fix this pattern before any actual users are in the tree if
possible, but I'm also fine to stick with dai-link-0 to dai-link-10 in
the case that nothing is changed and the DT has to follow the existing
patterns.

Regards,
Fei

>
> >      type: object
> >      description:
> >        Container for dai-link level properties and CODEC sub-nodes.
> > @@ -112,7 +112,7 @@ examples:
> >              "Headphone", "Headphone L",
> >              "Headphone", "Headphone R",
> >              "AIN1", "Headset Mic";
> > -        dai-link-0 {
> > +        hdmi-dai-link {
>
> No. Not really justified.
>
> Best regards,
> Krzysztof
>

