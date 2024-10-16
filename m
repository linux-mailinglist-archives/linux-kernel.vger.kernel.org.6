Return-Path: <linux-kernel+bounces-367397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFAD9A01BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A6E282C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6199C193409;
	Wed, 16 Oct 2024 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKD815g7"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7A18C32E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061440; cv=none; b=Zluv67IpegYSji/zDC40DsZlhwfQUYTpYmD9eG3/SoLy0fx/1pGf8oDfq847st4MEpMFVziEI42sRRI0FOhJ2wfiIpKxg9bqnIKJjWCMGzTreSmGFMruRF17ESWUdcO+sF0USs+1nrFlmM/COGFqdz6+LXhE9lCWpL9tl2NX1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061440; c=relaxed/simple;
	bh=kZswAza2PaQnbvZYVyEwZWse7xDVepCu2DFnj0/mZvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8ZLLhJrVXnfzkAYW6m6CHbk89zVZY7ljWhB3vjptGAK0gZlAnTDKlZ4QEyxMDd+EP9aorCoVc+GbE9Rbw3JjOLppjpsZhFIWKR/MSxDpfQy3KcIIeu3zslu30SO38V5h/q5v/HaeRa1J7guwCoho84eef6f6/Wx4N/lhzKSvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKD815g7; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5eb61089e7cso9410eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729061437; x=1729666237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TO59C4XZYRdTYQJuScmu2mLEcBL9KTSKA3Aj17XZnXs=;
        b=CKD815g70jNb+FRI5gR38z3DvpZkEWXdnp9FnwPWFOXB35+E1cxJL0G0na/mYM7Oak
         cjAVD0zQ7yhlUsNr84UY29WJ2i76chuUbbmcsUrhK4nJR8cy4xEzXZ4ARSy4dZWgPb93
         WoGMFBCaiLBOkOLKmpj08tIomlbxVqnRZr+dL1Ye8wzXUItBq4A7ZzoYQIMRqt3mxP0J
         u3MMiD2vLjDQBQKgPpdDy0z/td5z4hlLs+OlBdWpM6LtdxLicrY6M+/rgFTlziM/d50t
         U6cyEwzCI3q0+TuNQ2JZGedR5fjdv/5lcCyJGp4rdpM0U3aBpZ3M145IL/upxbu3P1fv
         ueMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061437; x=1729666237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO59C4XZYRdTYQJuScmu2mLEcBL9KTSKA3Aj17XZnXs=;
        b=CaS5splWu+mE4AxVHNzfSBCXMpKBl09KmQDOJAGb2TB1WBVH2K+ErOIS4xDuJpv/pq
         pAADn554g+Z2sKv4XqvjxA6sja/gocmaAxPKogu313TSnWN8XOg6cx6BmzoB5aJtMN6m
         WvZ8mfiGRrH+IKzihFnFHLN9Yv0jB+WcUlnCPEqKmJQfPaLwIE5F4bHeXQ+s04oxTNXg
         GZnBpumMZil2BePnWp+HFZb+X+oyd9of1NKnr5nl9Q4StkC1vf1X9X4oF49laezbQM1N
         U+NKwaOpUONkniONS6KVEJNwIQokZfJ0STyxd//5xdswBpK6v9S8yRuE3gTwzVmo6Lzx
         6G0A==
X-Forwarded-Encrypted: i=1; AJvYcCUggoBFzu3NjqNo9ILiK9iXbGsj7fqq0qTcjGVmFbRGZF0MBzc6F0jxQirgJlhTk0uAje93Fd/GDkTnRH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQ5PChy6ppuX8zg+0dHAIhLhMoKeyt4Tt4w9zwtiQW4reRJX0
	SgFUQB9Y8l5eC5i6eB02XcFzaVslCVF1fyMtaZJylVrNszwB8qKeECv7tix9jcKz7n1Bw5f8gnD
	4tons26lx1ztotmMLWTudIs5IuDEz5triXunP0g==
X-Google-Smtp-Source: AGHT+IGiy4dUwz9Pj2nWJ8Pq6IB3QUE4cA66e4zLDPayeTK7oE28UFMNPT48jIBPfI0w4Wc00qU0WdFD7Xz2C4EsOKU=
X-Received: by 2002:a05:6870:700b:b0:27b:9f8b:277e with SMTP id
 586e51a60fabf-2886e041fbfmr3125221fac.13.1729061437077; Tue, 15 Oct 2024
 23:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015122608.24569-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <172900161180.733089.8963543745385219831.robh@kernel.org>
In-Reply-To: <172900161180.733089.8963543745385219831.robh@kernel.org>
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Date: Wed, 16 Oct 2024 14:50:26 +0800
Message-ID: <CADYyEwRpn7afZ98ttQbBp1Dkm-SQB82_5tY0D61cBW3vkC28Gg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add MT8186 Chinchou Chromebooks
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: wenst@chromium.org, rafal@milecki.pl, linux-mediatek@lists.infradead.org, 
	angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, 
	sean.wang@mediatek.com, devicetree@vger.kernel.org, macpaul.lin@mediatek.com, 
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, hsinyi@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,
  I am so sorry that I didn't check dts, I have some questions.

Rob Herring (Arm) <robh@kernel.org> =E4=BA=8E2024=E5=B9=B410=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C 22:17=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On Tue, 15 Oct 2024 20:26:05 +0800, Zhengqiao Xia wrote:
> > MT8186 chinchou, known as ASUS Chromebook CZ12 Flip, is a
> > MT8186 based laptop. It is based on the "corsola" design.
> > It includes chinchou and chinchou360, including LTE, stylus,
> > touchscreen combinations.
> >
> > Zhengqiao Xia (3):
> >   dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
> >   arm64: dts: mediatek: Add MT8186 Chinchou Chromebooks
> >   arm64: dts: mediatek: Add exton node for DP bridge
> >
> >  .../devicetree/bindings/arm/mediatek.yaml     |  26 ++
> >  arch/arm64/boot/dts/mediatek/Makefile         |   3 +
> >  .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 ++
> >  .../mediatek/mt8186-corsola-chinchou-sku1.dts |  34 ++
> >  .../mt8186-corsola-chinchou-sku16.dts         |  28 ++
> >  .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 296 ++++++++++++++++++
> >  .../boot/dts/mediatek/mt8186-corsola.dtsi     |   6 +
> >  7 files changed, 411 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chincho=
u-sku0.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chincho=
u-sku1.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chincho=
u-sku16.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chincho=
u.dtsi
> >
> > --
> > 2.17.1
> >
> >
> >
>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=3Dy mediatek/mt8186-corsola-chincho=
u-sku0.dtb mediatek/mt8186-corsola-chinchou-sku1.dtb mediatek/mt8186-corsol=
a-chinchou-sku16.dtb' for 20241015122608.24569-1-xiazhengqiao@huaqin.corp-p=
artner.google.com:
>
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: /: compati=
ble: 'oneOf' conditional failed, one must be fixed:
>         ['google,chinchou-sku1', 'google,chinchou-sku17', 'google,chincho=
u-sku3', 'google,chinchou-sku6', 'google,chinchou-sku7', 'google,chinchou-s=
ku20', 'google,chinchou-sku22', 'google,chinchou-sku23', 'mediatek,mt8186']=
 is too long
>         'google,chinchou-sku1' is not one of ['mediatek,mt2701-evb']
>         'google,chinchou-sku1' is not one of ['mediatek,mt2712-evb']
>         'google,chinchou-sku1' is not one of ['mediatek,mt6580-evbp1']
>         'google,chinchou-sku1' is not one of ['prestigio,pmt5008-3g']
>         'google,chinchou-sku1' is not one of ['fairphone,fp1', 'mundoread=
er,bq-aquaris5']
>         'google,chinchou-sku1' is not one of ['mediatek,mt6592-evb']
>         'google,chinchou-sku1' is not one of ['mediatek,mt6755-evb']
>         'google,chinchou-sku1' is not one of ['mediatek,mt6765-evb']
>         'google,chinchou-sku1' is not one of ['mediatek,mt6779-evb']
>         'google,chinchou-sku1' is not one of ['mediatek,mt6795-evb', 'son=
y,xperia-m5']
>         'google,chinchou-sku1' is not one of ['archermind,mt6797-x20-dev'=
, 'mediatek,mt6797-evb']
>         'google,chinchou-sku1' is not one of ['bananapi,bpi-r64', 'mediat=
ek,mt7622-rfb1']
>         'google,chinchou-sku1' is not one of ['mediatek,mt7623a-rfb-emmc'=
, 'mediatek,mt7623a-rfb-nand', 'mediatek,mt7623n-rfb-emmc', 'bananapi,bpi-r=
2']
>         'google,chinchou-sku1' is not one of ['mediatek,mt7629-rfb']
>         'google,chinchou-sku1' is not one of ['cudy,wr3000-v1', 'openwrt,=
one', 'xiaomi,ax3000t']
>         'google,chinchou-sku1' is not one of ['acelink,ew-7886cax', 'bana=
napi,bpi-r3', 'bananapi,bpi-r3mini', 'mediatek,mt7986a-rfb']
>         'google,chinchou-sku1' is not one of ['mediatek,mt7986b-rfb']
>         'google,chinchou-sku1' is not one of ['bananapi,bpi-r4']
>         'google,chinchou-sku1' is not one of ['mediatek,mt8127-moose']
>         'google,chinchou-sku1' is not one of ['mediatek,mt8135-evbp1']
>         'google,chinchou-sku1' is not one of ['mediatek,mt8167-pumpkin']
>         'google,elm-rev8' was expected
>         'google,hana-rev6' was expected
>         'google,hana-rev7' was expected
>         'google,chinchou-sku1' is not one of ['mediatek,mt8173-evb']
>         'google,burnet' was expected
>         'google,cozmo' was expected
>         'google,damu' was expected
>         'google,chinchou-sku1' is not one of ['google,fennel-sku0', 'goog=
le,fennel-sku1', 'google,fennel-sku2', 'google,fennel-sku6', 'google,fennel=
-sku7']
>         'google,chinchou-sku1' is not one of ['google,juniper-sku16', 'go=
ogle,juniper-sku17']
>         'google,kakadu-rev3' was expected
>         'google,kakadu-rev3-sku22' was expected
>         'google,kappa' was expected
>         'google,chinchou-sku1' is not one of ['google,katsu-sku32', 'goog=
le,katsu-sku38']
>         'google,chinchou-sku1' is not one of ['google,kodama-sku16', 'goo=
gle,kodama-sku272', 'google,kodama-sku288', 'google,kodama-sku32']
>         'google,chinchou-sku1' is not one of ['google,krane-sku0', 'googl=
e,krane-sku176']
>         'google,chinchou-sku1' is not one of ['google,makomo-sku0', 'goog=
le,makomo-sku1']
>         'google,chinchou-sku1' is not one of ['google,pico-sku1', 'google=
,pico-sku2']
>         'google,chinchou-sku1' is not one of ['google,willow-sku0', 'goog=
le,willow-sku1']
>         'google,chinchou-sku1' is not one of ['mediatek,mt8183-evb']
>         'google,chinchou-sku1' is not one of ['mediatek,mt8183-pumpkin']
>         'google,chinchou-sku0' was expected
>         'google,chinchou-sku16' was expected
>         'google,steelix-sku393219' was expected
>         'google,steelix-sku393220' was expected
>         'google,steelix-sku393221' was expected
>         'google,steelix-sku196609' was expected
>         'google,chinchou-sku1' is not one of ['google,steelix-sku131072',=
 'google,steelix-sku131073']
>         'google,tentacruel-sku262147' was expected
>         'google,tentacruel-sku262151' was expected
>         'google,tentacruel-sku327681' was expected
>         'google,tentacruel-sku327683' was expected
>         'google,chinchou-sku1' is not one of ['google,voltorb-sku589824',=
 'google,voltorb-sku589825']
>         'google,chinchou-sku1' is not one of ['mediatek,mt8186-evb']
>         'google,chinchou-sku1' is not one of ['mediatek,mt8188-evb']
>         'google,hayato-rev1' was expected
>         'google,hayato-rev5-sku2' was expected
>         'google,spherion-rev3' was expected
>         'google,spherion-rev4' was expected
>         'google,chinchou-sku1' is not one of ['mediatek,mt8192-evb']
>         'google,chinchou-sku1' is not one of ['google,tomato-rev2', 'goog=
le,tomato-rev1']
>         'google,tomato-rev4' was expected
>         'google,dojo-sku7' was expected
>         'google,chinchou-sku1' is not one of ['mediatek,mt8195-demo', 'me=
diatek,mt8195-evb']
>         'google,chinchou-sku1' is not one of ['mediatek,mt8365-evk']
>         'google,chinchou-sku1' is not one of ['mediatek,mt8390-evk']
>         'google,chinchou-sku1' is not one of ['kontron,3-5-sbc-i1200', 'm=
ediatek,mt8395-evk', 'radxa,nio-12l']
>         'google,chinchou-sku1' is not one of ['mediatek,mt8516-pumpkin']
>         'mediatek,mt2701' was expected
>         'mediatek,mt2712' was expected
>         'mediatek,mt6580' was expected
>         'mediatek,mt6582' was expected
>         'mediatek,mt6589' was expected
>         'mediatek,mt6592' was expected
>         'mediatek,mt6755' was expected
>         'mediatek,mt6765' was expected
>         'mediatek,mt6779' was expected
>         'mediatek,mt6795' was expected
>         'mediatek,mt6797' was expected
>         'mediatek,mt7622' was expected
>         'mediatek,mt7623' was expected
>         'mediatek,mt7629' was expected
>         'mediatek,mt7981b' was expected
>         'mediatek,mt7986a' was expected
>         'mediatek,mt7986b' was expected
>         'mediatek,mt7988a' was expected
>         'mediatek,mt8127' was expected
>         'mediatek,mt8135' was expected
>         'mediatek,mt8167' was expected
>         'google,elm-rev7' was expected
>         'google,hana-rev5' was expected
>         'mediatek,mt8173' was expected
>         'mediatek,mt8183' was expected
>         'google,fennel' was expected
>         'google,juniper' was expected
>         'google,kakadu-rev2' was expected
>         'google,kakadu-rev2-sku22' was expected
>         'google,katsu' was expected
>         'google,kodama' was expected
>         'google,krane' was expected
>         'google,makomo' was expected
>         'google,pico' was expected
>         'google,willow' was expected
>         'google,chinchou-sku2' was expected
>         'google,chinchou-sku3' was expected
>         'google,chinchou-sku18' was expected
>         'google,steelix-sku393216' was expected
>         'google,steelix-sku393217' was expected
>         'google,steelix-sku393218' was expected
>         'google,steelix-sku196608' was expected
>         'google,steelix' was expected
>         'google,tentacruel-sku262146' was expected
>         'google,tentacruel-sku262150' was expected
>         'google,tentacruel' was expected
>         'google,voltorb' was expected
>         'mediatek,mt8186' was expected
>         'mediatek,mt8188' was expected
>         'google,hayato' was expected
>         'google,hayato-sku2' was expected
>         'google,spherion-rev2' was expected
>         'google,spherion' was expected
>         'mediatek,mt8192' was expected
>         'google,tomato' was expected
>         'google,tomato-rev3' was expected
>         'google,dojo-sku5' was expected
>         'mediatek,mt8195' was expected
>         'mediatek,mt8365' was expected
>         'mediatek,mt8390' was expected
>         'mediatek,mt8395' was expected
>         'mediatek,mt8516' was expected
>         'google,elm-rev6' was expected
>         'google,hana-rev4' was expected
>         'google,kakadu' was expected
>         'google,chinchou-sku4' was expected
>         'google,chinchou-sku6' was expected
>         'google,chinchou-sku19' was expected
>         'google,tentacruel-sku262145' was expected
>         'google,tentacruel-sku262149' was expected
>         'google,spherion-rev1' was expected
>         'google,dojo-sku3' was expected
>         'google,elm-rev5' was expected
>         'google,hana-rev3' was expected
>         'google,chinchou-sku5' was expected
>         'google,chinchou-sku7' was expected
>         'google,chinchou-sku21' was expected
>         'google,tentacruel-sku262144' was expected
>         'google,tentacruel-sku262148' was expected
>         'google,spherion-rev0' was expected
>         'google,dojo-sku1' was expected
>         'google,elm-rev4' was expected
>         'google,hana' was expected
>         'google,chinchou' was expected
>         'google,chinchou-sku17' was expected
>         'google,dojo' was expected
>         'google,elm-rev3' was expected
>         'google,elm' was expected

I don't know how to solve this, there are so many skus in chinchou, I
can't remove that.

>         from schema $id: http://devicetree.org/schemas/arm/mediatek.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: pinctrl@1=
0005000: 'pin-report' does not match any of the regexes: '-pins$', 'pinctrl=
-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,m=
t8186-pinctrl.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: pinctrl@10=
005000: 'pin-report' does not match any of the regexes: '-pins$', 'pinctrl-=
[0-9]+'
>         from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,m=
t8186-pinctrl.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: pinctrl@10=
005000: 'pin-report' does not match any of the regexes: '-pins$', 'pinctrl-=
[0-9]+'
>         from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,m=
t8186-pinctrl.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: /soc/pwra=
p@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6=
366', 'mediatek,mt6358']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: /soc/pwra=
p@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6=
366', 'mediatek,mt6358']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: /soc/pwra=
p@1000d000/pmic/codec: failed to match any schema with compatible: ['mediat=
ek,mt6366-sound', 'mediatek,mt6358-sound']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: /soc/pwra=
p@1000d000/pmic/codec: failed to match any schema with compatible: ['mediat=
ek,mt6366-sound', 'mediatek,mt6358-sound']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: /soc/pwrap=
@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt63=
66', 'mediatek,mt6358']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: /soc/pwrap=
@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt63=
66', 'mediatek,mt6358']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: /soc/pwrap=
@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt63=
66', 'mediatek,mt6358']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: /soc/pwrap=
@1000d000/pmic/codec: failed to match any schema with compatible: ['mediate=
k,mt6366-sound', 'mediatek,mt6358-sound']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: /soc/pwrap=
@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt63=
66', 'mediatek,mt6358']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: /soc/pwrap=
@1000d000/pmic/codec: failed to match any schema with compatible: ['mediate=
k,mt6366-sound', 'mediatek,mt6358-sound']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: /soc/pwrap=
@1000d000/pmic/codec: failed to match any schema with compatible: ['mediate=
k,mt6366-sound', 'mediatek,mt6358-sound']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: /soc/pwrap=
@1000d000/pmic/codec: failed to match any schema with compatible: ['mediate=
k,mt6366-sound', 'mediatek,mt6358-sound']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: /soc/pwra=
p@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek=
,mt6366-rtc', 'mediatek,mt6358-rtc']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: /soc/pwra=
p@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek=
,mt6366-rtc', 'mediatek,mt6358-rtc']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: /soc/pwrap=
@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,=
mt6366-rtc', 'mediatek,mt6358-rtc']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: /soc/pwrap=
@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,=
mt6366-rtc', 'mediatek,mt6358-rtc']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: /soc/pwrap=
@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,=
mt6366-rtc', 'mediatek,mt6358-rtc']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: /soc/pwrap=
@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,=
mt6366-rtc', 'mediatek,mt6358-rtc']

These errors are not caused by me, do I need to add them?

> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: touchscre=
en@41: 'vcc33-supply' is a required property
>         from schema $id: http://devicetree.org/schemas/input/ilitek,ili29=
01.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: touchscree=
n@41: 'vcc33-supply' is a required property
>         from schema $id: http://devicetree.org/schemas/input/ilitek,ili29=
01.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: rt5650@1a=
: 'cpvdd-supply' is a required property
>         from schema $id: http://devicetree.org/schemas/sound/realtek,rt56=
45.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: rt5650@1a=
: Unevaluated properties are not allowed ('cbj-sleeve-gpio' was unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/realtek,rt56=
45.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: rt5650@1a:=
 'cpvdd-supply' is a required property
>         from schema $id: http://devicetree.org/schemas/sound/realtek,rt56=
45.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: rt5650@1a:=
 Unevaluated properties are not allowed ('cbj-sleeve-gpio' was unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/realtek,rt56=
45.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: rt5650@1a:=
 'cpvdd-supply' is a required property
>         from schema $id: http://devicetree.org/schemas/sound/realtek,rt56=
45.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: rt5650@1a:=
 Unevaluated properties are not allowed ('cbj-sleeve-gpio' was unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/realtek,rt56=
45.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: sound: 'm=
odel' is a required property
>         from schema $id: http://devicetree.org/schemas/sound/mt8186-mt636=
6-rt1019-rt5682s.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: sound: pl=
ayback-codecs:sound-dai: [[183]] is too short
>         from schema $id: http://devicetree.org/schemas/sound/mt8186-mt636=
6-rt1019-rt5682s.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: sound: Un=
evaluated properties are not allowed ('playback-codecs' was unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/mt8186-mt636=
6-rt1019-rt5682s.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: sound: 'mo=
del' is a required property
>         from schema $id: http://devicetree.org/schemas/sound/mt8186-mt636=
6-rt1019-rt5682s.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: sound: pla=
yback-codecs:sound-dai: [[183]] is too short
>         from schema $id: http://devicetree.org/schemas/sound/mt8186-mt636=
6-rt1019-rt5682s.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: sound: Une=
valuated properties are not allowed ('playback-codecs' was unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/mt8186-mt636=
6-rt1019-rt5682s.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: sound: 'mo=
del' is a required property
>         from schema $id: http://devicetree.org/schemas/sound/mt8186-mt636=
6-rt1019-rt5682s.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: sound: pla=
yback-codecs:sound-dai: [[181]] is too short
>         from schema $id: http://devicetree.org/schemas/sound/mt8186-mt636=
6-rt1019-rt5682s.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: sound: Une=
valuated properties are not allowed ('playback-codecs' was unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/mt8186-mt636=
6-rt1019-rt5682s.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: regulator=
-pp1800-tchscr-report-disable: Unevaluated properties are not allowed ('ena=
ble-active-low' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/fixed-re=
gulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: regulator-=
pp1800-tchscr-report-disable: Unevaluated properties are not allowed ('enab=
le-active-low' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/fixed-re=
gulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: regulator-=
pp1800-tchscr-report-disable: Unevaluated properties are not allowed ('enab=
le-active-low' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/fixed-re=
gulator.yaml#
>
>
>
>
>

