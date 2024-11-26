Return-Path: <linux-kernel+bounces-421862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1E29D910E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA67B237C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5A13BAE3;
	Tue, 26 Nov 2024 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRO0XKyB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FF2260C;
	Tue, 26 Nov 2024 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732595783; cv=none; b=fOjduOHJbBJ9+3KDhuzp5hnNvWRw8YaSfdxPH2ZoAGD+BGw3JYGrtUE5WeAcZzCTLosihdObZae6PCI0JAF77u4F64g8428cQ83duLTXUTre5wULBzc+l5jLmNud9MZVa7u/bPKRACYLQCKvcEM/F4iEIRQWKV6wgUgqCDzrY18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732595783; c=relaxed/simple;
	bh=n248E6cQcbmvG8TJRwSTTgSI3ENxL08+73ZTFK+rZTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgV0RZDzH8dPo/ZR+OWYqkQB7tnelMMpG7TB1ozMrh6pVcEU/BZkjkXn1i1CZulDLrICQ2Om5RqZB7tr+eZC0mOJ+lDfqyStHrrnhIElkbB5qGsZZH8AQLg4ZglNDxxGXf3k/ikqtAFkK3oUxKaM49LxvfEWaDhsSdinfL8MTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRO0XKyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE223C4CEDD;
	Tue, 26 Nov 2024 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732595782;
	bh=n248E6cQcbmvG8TJRwSTTgSI3ENxL08+73ZTFK+rZTc=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=dRO0XKyBjn5Sm3VWOtwEUo+mqxF3CJpxJhf7SGeFt3aAk0EY1RLRSSLYDcV4UFsqa
	 DQbM3IKx+Zh1bZb5C99QSgnqGNG6HFZ+zkcHa0aWVGnSu9mZW9yses0V9y5LpQ9x+d
	 H6qZFutUXdVT0TyU/A1nxrNzHhMhXjyqsV4s2lPnXsV2/c0cS8yPD+EiZfCgYN7PTl
	 kDT29DR1x3H7PmDXixZxEOplD1Y6m6TaNHPhsSZd/BN6NgDnelC9wOaaC38z5ivMTL
	 8D6M99i+s6d6EXL2pGV9QDalRNAGgfJFkD1RbLpxmaQJGDf5qwqitKLRBROHcdY5/T
	 kn4+2MCFbgxUQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffc016f301so19627291fa.1;
        Mon, 25 Nov 2024 20:36:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4uJ3hiT3BEVVL/ZVkbFJQ2rqbhB4fYwPFnML7dFzOU9SCcz9T00EzrAO0C51CZle95Xe1FukJNDua@vger.kernel.org, AJvYcCXgrd6T5sKkbARnZjAqVdtvDOtQs/V91//hPFbbfgLe+4mZz5KZ3WWM34EbA04b5qrgGdPmtjTShXGpz+Kf@vger.kernel.org
X-Gm-Message-State: AOJu0YxRmeFJ5UO9BRcD7bc++ZDsUuNbttwureOGRaCtEfsA+61CRq7f
	XSIzWfha3FRuPwiW+nJvPcF0FpIKKb+gUyHbNmm9ye6ckql6ZT6+Za7sEYLkibMxXmpXjv74SuM
	4ZOuEugaHY8ZdgNPy6YY+kjgCN/w=
X-Google-Smtp-Source: AGHT+IHMAT53tm+g3nrPUDVGLRawbIHJgSk3HrbNUkSwnVRCsvyn/bk3pAQYfMYGomGQd/Wz+5r8KSfUblsBUM7L9ck=
X-Received: by 2002:a05:651c:1987:b0:2ff:bae5:90fe with SMTP id
 38308e7fff4ca-2ffbae5952bmr34535991fa.13.1732595781097; Mon, 25 Nov 2024
 20:36:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125082130.2390310-1-wmacek@chromium.org> <20241125082130.2390310-2-wmacek@chromium.org>
 <20241125-snowcap-sulphate-34944bd70cf3@spud>
In-Reply-To: <20241125-snowcap-sulphate-34944bd70cf3@spud>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 26 Nov 2024 12:36:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v655Bfx44XBPH24FKuEFTJ3ngjbAPEpNBn5vyLZfNGKt+Q@mail.gmail.com>
Message-ID: <CAGb2v655Bfx44XBPH24FKuEFTJ3ngjbAPEpNBn5vyLZfNGKt+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8186 Starmie Chromebooks
To: Conor Dooley <conor@kernel.org>
Cc: Wojciech Macek <wmacek@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Rafal Milecki <rafal@milecki.pl>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 2:34=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Nov 25, 2024 at 08:21:28AM +0000, Wojciech Macek wrote:
> > Add an entry for the MT8186 based Starmie Chromebooks, also known as th=
e
> > ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
> > a tablet style chromebook.
> >
> > Signed-off-by: Wojciech Macek <wmacek@chromium.org>
> > ---
> >
> > Changelog v2-v1:
> >  - Fixed items/const bidings description in mediatek.yaml
> >
> >  Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docu=
mentation/devicetree/bindings/arm/mediatek.yaml
> > index 1d4bb50fcd8d9..6191a5320c148 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > @@ -263,6 +263,19 @@ properties:
> >            - const: google,steelix-sku196608
> >            - const: google,steelix
> >            - const: mediatek,mt8186
> > +      - description: Google Starmie (ASUS Chromebook Enterprise CM30 (=
CM3001))
> > +        items:
> > +          - const: google,starmie-sku0
> > +          - const: google,starmie-sku2
> > +          - const: google,starmie-sku3
>
> Compatible order here is back to making little sense. Why is the oldest
> SKU, in both cases, appearing first?

FWIW the SKU number has no particular ordering. They were released together=
.
SKU denotes different configurations (memory, storage, touchscreen and othe=
r
component options). OOTH revisions would actually have chronological meanin=
g.


ChenYu

> > +          - const: google,starmie
> > +          - const: mediatek,mt8186
> > +      - description: Google Starmie (ASUS Chromebook Enterprise CM30 (=
CM3001))
> > +        items:
> > +          - const: google,starmie-sku1
> > +          - const: google,starmie-sku4
> > +          - const: google,starmie
> > +          - const: mediatek,mt8186
> >        - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4=
)
> >          items:
> >            - enum:
> > --
> > 2.47.0.371.ga323438b13-goog
> >

