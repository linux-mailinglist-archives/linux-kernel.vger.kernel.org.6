Return-Path: <linux-kernel+bounces-263116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8959993D141
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28221F222A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F3413A240;
	Fri, 26 Jul 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu2MNGAI"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA6178372;
	Fri, 26 Jul 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990311; cv=none; b=dBthEE8ao1PKZ/l3PR1s+hp40W7/lasADCeLBwHMU9WVTPKBdsah0cp+gnyUbfaqh7cswQFqdzuG/J2f5CQPVhoEwbPcmeqkL6W4OIwJPf+/3efpPxFGBmzos8WUiqV7XOeSJ0bwG/pX9i/WoLJNTWG0kHjJBIx6dzKjTRh/hvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990311; c=relaxed/simple;
	bh=Aeq0bQgc8JMb6qYrtZopYFvSQq92J7Xb8mRp/5EFBOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5o0vxxbwz+MlGpEZWlR0SIJ8Y/VOgjSqH7l32hvQMxHDRgvEZBkgen50wgKVrEr9jhjdrFTa0hyOYeZmQmktb4IcmMBNlMyHvCqPt8at3RqnNtXuqNNPrJBXkOYW+iJqZxkFQz493cKurpY8dvdtJSJM5UaKCUU1qTpDBHptEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu2MNGAI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so1720496e87.1;
        Fri, 26 Jul 2024 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721990306; x=1722595106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0OaS0paPYhFO0t77yCq8rfIjJPFMslvhkVqEseloHs=;
        b=cu2MNGAIfTvrYGMopGkADZEYDSDDeeIyaui8RfOnbaiT6hUtodpWDinhW5OagOuU0s
         YNLu/mp42LSupqqFNda8AKX7YfbsmIQNOWr8HFZ0s4qd6SzGQ52H2owluzJn7ONyBwiM
         VQxh5ohhU3X/KvldTELX6R4DFvgcrD9HqYWgXnK8AbWms0gTfKPa9UefM40txNp9hRX7
         DNnH4N+f25U74bYqHtxd2eEgtV9em2wwux1nG9KZlZ/Ga5DdPnml+zWTHWn/9wou+30Y
         +BSlV6WzatLb1ICl4Anzuvi0deF4oSvS88rJYCpP3cooMYqvbyeih1DBkHtLBPRXUlsh
         5NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721990306; x=1722595106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0OaS0paPYhFO0t77yCq8rfIjJPFMslvhkVqEseloHs=;
        b=Q1cDzaM9YhgnCFWnBsZewXdlyzkf5S+eJfgT7J+qsCuT7hj96EINDZaDsUFiW76dOm
         0S+SeKySKw9Ki1PpPPtalUnHH/kJxNn4VEt2dkGr7vHY2J/3jy0LTwlbgYQUgCYKMk8j
         0Ll3tFIAdcIiOk+k4hFeGXIhwJl/0FRpzKhAqD9ic8u/syBUK5NywVILjaSRUm/PS7d1
         TDDLIWMCDzQn5JmI2x0EabcMV5mYjfuXPvrEQ+k0hu9e0dM5+CVJouUgkCmstBGZ8VSL
         cfmLRDTNZSv0nMSsJFCY1sUF3udpIBKBJQ90/lANwLjhJAc3PNwMR3J5H/hhwFoJBxLY
         XBqA==
X-Forwarded-Encrypted: i=1; AJvYcCVS5qgTWdaQB60O9r/KSzMOsOYBH8GJ7UU+/AzqeFqrCtIsN8jGDH7VN4IZOPwru9PRP4lkWlljUaSiQY3LV39IBXm2+D6gnlWPVE+AqAHPZvB5PIvj69wzlSDEWoKgJOD7tFZJbBa6Cg==
X-Gm-Message-State: AOJu0Ywlh6h5a/qBfj8Hv5uBwpkBo3bAUDony5sIZE0r3TuB1vdwWV9j
	yMHXnHac8qG0tKsVfFh9nchqNAZqkW1jCnP12DvgDgcT/GDE3OYCjtHbww4vMQ5je0erCGKUXD2
	Cpki17jsFO2pW6K7SMF2/XySlfEw=
X-Google-Smtp-Source: AGHT+IHOrnXHGO1rzKe+sJlrvmpQR0SEA5YUiuEBEXcIeaAjmZ6rlsRAHqi+lUZKHd4hV+GVeu1lbaNlV63k8HW88V8=
X-Received: by 2002:a05:6512:39d3:b0:52d:b0a5:cf3c with SMTP id
 2adb3069b0e04-52fd60843d1mr3684046e87.40.1721990305709; Fri, 26 Jul 2024
 03:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-potin-catalina-dts-v4-0-aa6f235a2e78@gmail.com>
 <172194566710.4001436.1410948302471443496.robh@kernel.org> <64131f6cd5ca03bb9cb52b6caa6a4416b825241b.camel@codeconstruct.com.au>
In-Reply-To: <64131f6cd5ca03bb9cb52b6caa6a4416b825241b.camel@codeconstruct.com.au>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 26 Jul 2024 18:38:14 +0800
Message-ID: <CAGfYmwX7cz_WDiOoX2QUmDJ2UwReqk+WZy-AL26hX6pmg-cE7g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Patrick Williams <patrick@stwcx.xyz>, 
	Cosmo Chou <cosmo.chou@quantatw.com>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Joel Stanley <joel@jms.id.au>, Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:11=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Potin,
>
> On Thu, 2024-07-25 at 17:20 -0500, Rob Herring (Arm) wrote:
> > On Thu, 25 Jul 2024 00:48:16 +0800, Potin Lai wrote:
> > > Add Linux device tree entry related to Meta(Facebook) Catalina specif=
ic
> > > devices connected to BMC(AST2600) SoC.
> > >
> > > Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> > > ---
> > > Changes in v4:
> > > - change back io_expanderX due to parser error, build passed in v4 ve=
rsion.
> > > - Link to v3: https://lore.kernel.org/r/20240725-potin-catalina-dts-v=
3-0-3a5b5d9e6dbc@gmail.com
> > >
> > > Changes in v3:
> > > - rename tmp75 nodes to temperature-sensor
> > > - rename tmp421 nodes to temperature-sensor
> > > - rename ina230 nodes to power-sensor
> > > - rename io_expanderX nodes to io-expanderX
> > > - Link to v2: https://lore.kernel.org/r/20240724-potin-catalina-dts-v=
2-0-ba8d475c4073@gmail.com
> > >
> > > Changes in v2:
> > > - drop commented code in dts
> > > - rename i2c-mux channel nodes as i2c1muxXchY
> > > - rename gpio expander as io_expanderX
> > > - use "stdout-path" instead of "bootargs"
> > > - Link to v1: https://lore.kernel.org/all/20240722145857.2131100-1-po=
tin.lai.pt@gmail.com/
> > >
> > > ---
> > > Potin Lai (2):
> > >       dt-bindings: arm: aspeed: add Meta Catalina board
> > >       ARM: dts: aspeed: catalina: add Meta Catalina BMC
> > >
> > >  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
> > >  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
> > >  .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 1020 ++++++++++=
++++++++++
> > >  3 files changed, 1022 insertions(+)
> > > ---
> > > base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> > > change-id: 20240724-potin-catalina-dts-fda1ea3297b1
> > >
> > > Best regards,
> > > --
> > > Potin Lai <potin.lai.pt@gmail.com>
> > >
> > >
> > >
> >
> >
> > My bot found new DTB warnings on the .dts files added or changed in thi=
s
> > series.
> >
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warning=
s
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to rep=
ly
> > unless the platform maintainer has comments.
> >
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> >
> >   pip3 install dtschema --upgrade
> >
> >
> > New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-ca=
talina.dtb' for 20240725-potin-catalina-dts-v4-0-aa6f235a2e78@gmail.com:
> >
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /: spi1-gpio=
: {'compatible': ['spi-gpio'], '#address-cells': 1, '#size-cells': 0, 'gpio=
-sck': [44, 203, 0], 'gpio-mosi': [44, 204, 0], 'gpio-miso': [44, 205, 0], =
'num-chipselects': 1, 'cs-gpios': [[44, 200, 1]], 'tpm@0': {'compatible': [=
'infineon,slb9670', 'tcg,tpm_tis-spi'], 'spi-max-frequency': 33000000, 'reg=
': [[0]]}} is not of type 'array'
> >       from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: timer: 'cloc=
ks' does not match any of the regexes: 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/timer/arm,arch_tim=
er.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /sdram@1e6e0=
000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-eda=
c', 'syscon']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: bus@1e600000=
: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
> >       from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600=
-ahbc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e660=
000: $nodename:0: 'ftgmac@1e660000' does not match '^ethernet(@.*)?$'
> >       from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac=
100.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e680=
000: $nodename:0: 'ftgmac@1e680000' does not match '^ethernet(@.*)?$'
> >       from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac=
100.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e670=
000: $nodename:0: 'ftgmac@1e670000' does not match '^ethernet(@.*)?$'
> >       from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac=
100.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e690=
000: $nodename:0: 'ftgmac@1e690000' does not match '^ethernet(@.*)?$'
> >       from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac=
100.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e690=
000: Unevaluated properties are not allowed ('#address-cells', '#size-cells=
', 'ncsi-ctrl,start-redo-probe', 'ncsi-package' were unexpected)
> >       from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac=
100.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e690=
000: 'ncsi-ctrl,start-redo-probe' does not match any of the regexes: '^#.*'=
, '^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|h=
dmi|i2c-gpio),.*', '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*', '^(pin=
ctrl-single|#pinctrl-single|PowerPC),.*', '^(pl022|pxa-mmc|rcar_sound|rotar=
y-encoder|s5m8767|sdhci),.*', '^(simple-audio-card|st-plgpio|st-spics|ts),.=
*', '^100ask,.*', '^70mai,.*', '^8dev,.*', '^GEFanuc,.*', '^IBM,.*', '^ORCL=
,.*', '^SUNW,.*', '^[a-zA-Z0-9#_][a-zA-Z0-9+\-._@]{0,63}$', '^[a-zA-Z0-9+\-=
._]*@[0-9a-zA-Z,]*$', '^abb,.*', '^abilis,.*', '^abracon,.*', '^abt,.*', '^=
acbel,.*', '^acelink,.*', '^acer,.*', '^acme,.*', '^actions,.*', '^active-s=
emi,.*', '^ad,.*', '^adafruit,.*', '^adapteva,.*', '^adaptrum,.*', '^adh,.*=
', '^adi,.*', '^adieng,.*', '^admatec,.*', '^advantech,.*', '^aeroflexgaisl=
er,.*', '^aesop,.*', '^airoha,.*', '^al,.*', '^alcatel,.*', '^aldec,.*', '^=
alfa-network,.*', '^allegro
> >  ,.*', '^alliedvision,.*', '^allo,.*', '^allwinner,.*', '^alphascale,.*=
', '^alps,.*', '^alt,.*', '^altr,.*', '^amarula,.*', '^amazon,.*', '^amcc,.=
*', '^amd,.*', '^amediatech,.*', '^amlogic,.*', '^ampere,.*', '^amphenol,.*=
', '^ampire,.*', '^ams,.*', '^amstaos,.*', '^analogix,.*', '^anbernic,.*', =
'^andestech,.*', '^anvo,.*', '^aosong,.*', '^apm,.*', '^apple,.*', '^aptina=
,.*', '^arasan,.*', '^archermind,.*', '^arcom,.*', '^arctic,.*', '^arcx,.*'=
, '^aries,.*', '^arm,.*', '^armadeus,.*', '^armsom,.*', '^arrow,.*', '^arte=
syn,.*', '^asahi-kasei,.*', '^asc,.*', '^asix,.*', '^aspeed,.*', '^asrock,.=
*', '^asteralabs,.*', '^asus,.*', '^atheros,.*', '^atlas,.*', '^atmel,.*', =
'^auo,.*', '^auvidea,.*', '^avago,.*', '^avia,.*', '^avic,.*', '^avnet,.*',=
 '^awinic,.*', '^axentia,.*', '^axis,.*', '^azoteq,.*', '^azw,.*', '^baikal=
,.*', '^bananapi,.*', '^beacon,.*', '^beagle,.*', '^belling,.*', '^bhf,.*',=
 '^bigtreetech,.*', '^bitmain,.*', '^blutek,.*', '^boe,.*', '^bosch,.*', '^=
boundary,.*', '^brcm,.*', '
> >  ^broadmobi,.*', '^bsh,.*', '^bticino,.*', '^buffalo,.*', '^bur,.*', '^=
bytedance,.*', '^calamp,.*', '^calao,.*', '^calaosystems,.*', '^calxeda,.*'=
, '^cameo,.*', '^canaan,.*', '^caninos,.*', '^capella,.*', '^cascoda,.*', '=
^catalyst,.*', '^cavium,.*', '^cct,.*', '^cdns,.*', '^cdtech,.*', '^cellwis=
e,.*', '^ceva,.*', '^chargebyte,.*', '^checkpoint,.*', '^chefree,.*', '^chi=
pidea,.*', '^chipone,.*', '^chipspark,.*', '^chongzhou,.*', '^chrontel,.*',=
 '^chrp,.*', '^chunghwa,.*', '^chuwi,.*', '^ciaa,.*', '^cirrus,.*', '^cisco=
,.*', '^clockwork,.*', '^cloos,.*', '^cloudengines,.*', '^cnm,.*', '^cnxt,.=
*', '^colorfly,.*', '^compulab,.*', '^congatec,.*', '^coolpi,.*', '^coreriv=
er,.*', '^corpro,.*', '^cortina,.*', '^cosmic,.*', '^crane,.*', '^creative,=
.*', '^crystalfontz,.*', '^csky,.*', '^csq,.*', '^ctera,.*', '^ctu,.*', '^c=
ubietech,.*', '^cudy,.*', '^cui,.*', '^cypress,.*', '^cyx,.*', '^cznic,.*',=
 '^dallas,.*', '^dataimage,.*', '^davicom,.*', '^dell,.*', '^delta,.*', '^d=
ensitron,.*', '^denx,.*', '
> >  ^devantech,.*', '^dfi,.*', '^dh,.*', '^difrnce,.*', '^digi,.*', '^digi=
lent,.*', '^dimonoff,.*', '^diodes,.*', '^dioo,.*', '^dlc,.*', '^dlg,.*', '=
^dlink,.*', '^dmo,.*', '^domintech,.*', '^dongwoon,.*', '^dptechnics,.*', '=
^dragino,.*', '^dream,.*', '^ds,.*', '^dserve,.*', '^dynaimage,.*', '^ea,.*=
', '^ebang,.*', '^ebbg,.*', '^ebs-systart,.*', '^ebv,.*', '^eckelmann,.*', =
'^edgeble,.*', '^edimax,.*', '^edt,.*', '^ees,.*', '^eeti,.*', '^einfochips=
,.*', '^eink,.*', '^elan,.*', '^element14,.*', '^elgin,.*', '^elida,.*', '^=
elimo,.*', '^elpida,.*', '^embedfire,.*', '^embest,.*', '^emcraft,.*', '^em=
lid,.*', '^emmicro,.*', '^empire-electronix,.*', '^emtrion,.*', '^enclustra=
,.*', '^endless,.*', '^ene,.*', '^energymicro,.*', '^engicam,.*', '^englede=
r,.*', '^epcos,.*', '^epfl,.*', '^epson,.*', '^esp,.*', '^est,.*', '^ettus,=
.*', '^eukrea,.*', '^everest,.*', '^everspin,.*', '^evervision,.*', '^exar,=
.*', '^excito,.*', '^exegin,.*', '^ezchip,.*', '^facebook,.*', '^fairchild,=
.*', '^fairphone,.*', '^far
> >  aday,.*', '^fascontek,.*', '^fastrax,.*', '^fcs,.*', '^feixin,.*', '^f=
eiyang,.*', '^fii,.*', '^firefly,.*', '^focaltech,.*', '^forlinx,.*', '^fre=
ebox,.*', '^freecom,.*', '^frida,.*', '^friendlyarm,.*', '^fsl,.*', '^fujit=
su,.*', '^fxtec,.*', '^galaxycore,.*', '^gameforce,.*', '^gardena,.*', '^ga=
teway,.*', '^gateworks,.*', '^gcw,.*', '^ge,.*', '^geekbuying,.*', '^gef,.*=
', '^gemei,.*', '^gemtek,.*', '^genesys,.*', '^geniatech,.*', '^giantec,.*'=
, '^giantplus,.*', '^glinet,.*', '^globalscale,.*', '^globaltop,.*', '^gmt,=
.*', '^goldelico,.*', '^goodix,.*', '^google,.*', '^goramo,.*', '^gplus,.*'=
, '^grinn,.*', '^grmn,.*', '^gumstix,.*', '^gw,.*', '^hannstar,.*', '^haoch=
uangyi,.*', '^haoyu,.*', '^hardkernel,.*', '^hechuang,.*', '^hideep,.*', '^=
himax,.*', '^hirschmann,.*', '^hisi,.*', '^hisilicon,.*', '^hit,.*', '^hite=
x,.*', '^holt,.*', '^holtek,.*', '^honestar,.*', '^honeywell,.*', '^hoperf,=
.*', '^hoperun,.*', '^hp,.*', '^hpe,.*', '^hsg,.*', '^htc,.*', '^huawei,.*'=
, '^hugsun,.*', '^hwacom,.*
> >  ', '^hxt,.*', '^hycon,.*', '^hydis,.*', '^hynitron,.*', '^hynix,.*', '=
^hyundai,.*', '^i2se,.*', '^ibm,.*', '^icplus,.*', '^idt,.*', '^iei,.*', '^=
ifi,.*', '^ilitek,.*', '^imagis,.*', '^img,.*', '^imi,.*', '^inanbo,.*', '^=
incircuit,.*', '^indiedroid,.*', '^inet-tek,.*', '^infineon,.*', '^inforce,=
.*', '^ingenic,.*', '^ingrasys,.*', '^injoinic,.*', '^innocomm,.*', '^innol=
ux,.*', '^inside-secure,.*', '^insignal,.*', '^inspur,.*', '^intel,.*', '^i=
ntercontrol,.*', '^invensense,.*', '^inventec,.*', '^inversepath,.*', '^iom=
,.*', '^irondevice,.*', '^isee,.*', '^isil,.*', '^issi,.*', '^ite,.*', '^it=
ead,.*', '^itian,.*', '^ivo,.*', '^iwave,.*', '^jadard,.*', '^jasonic,.*', =
'^jdi,.*', '^jedec,.*', '^jesurun,.*', '^jethome,.*', '^jianda,.*', '^jide,=
.*', '^joz,.*', '^kam,.*', '^karo,.*', '^keithkoep,.*', '^keymile,.*', '^kh=
adas,.*', '^kiebackpeter,.*', '^kinetic,.*', '^kingdisplay,.*', '^kingnovel=
,.*', '^kionix,.*', '^kobo,.*', '^kobol,.*', '^koe,.*', '^kontron,.*', '^ko=
sagi,.*', '^kvg,.*', '^kyo,
> >  .*', '^lacie,.*', '^laird,.*', '^lamobo,.*', '^lantiq,.*', '^lattice,.=
*', '^lctech,.*', '^leadtek,.*', '^leez,.*', '^lego,.*', '^lemaker,.*', '^l=
enovo,.*', '^lg,.*', '^lgphilips,.*', '^libretech,.*', '^licheepi,.*', '^li=
naro,.*', '^lincolntech,.*', '^lineartechnology,.*', '^linksprite,.*', '^li=
nksys,.*', '^linutronix,.*', '^linux,.*', '^linx,.*', '^liteon,.*', '^litex=
,.*', '^lltc,.*', '^logicpd,.*', '^logictechno,.*', '^longcheer,.*', '^lont=
ium,.*', '^loongmasses,.*', '^loongson,.*', '^lsi,.*', '^lunzn,.*', '^luxul=
,.*', '^lwn,.*', '^lxa,.*', '^m5stack,.*', '^macnica,.*', '^mantix,.*', '^m=
apleboard,.*', '^marantec,.*', '^marvell,.*', '^maxbotix,.*', '^maxim,.*', =
'^maxlinear,.*', '^mbvl,.*', '^mcube,.*', '^meas,.*', '^mecer,.*', '^mediat=
ek,.*', '^megachips,.*', '^mele,.*', '^melexis,.*', '^melfas,.*', '^mellano=
x,.*', '^memsensing,.*', '^memsic,.*', '^menlo,.*', '^mentor,.*', '^meraki,=
.*', '^merrii,.*', '^methode,.*', '^micrel,.*', '^microchip,.*', '^microcry=
stal,.*', '^micron,.*', '^m
> >  icrosoft,.*', '^microsys,.*', '^microtips,.*', '^mikroe,.*', '^mikroti=
k,.*', '^milkv,.*', '^miniand,.*', '^minix,.*', '^mips,.*', '^miramems,.*',=
 '^mitsubishi,.*', '^mitsumi,.*', '^mixel,.*', '^miyoo,.*', '^mntre,.*', '^=
mobileye,.*', '^modtronix,.*', '^moortec,.*', '^mosaixtech,.*', '^motorcomm=
,.*', '^motorola,.*', '^moxa,.*', '^mpl,.*', '^mps,.*', '^mqmaker,.*', '^mr=
vl,.*', '^mscc,.*', '^msi,.*', '^mstar,.*', '^mti,.*', '^multi-inno,.*', '^=
mundoreader,.*', '^murata,.*', '^mxic,.*', '^mxicy,.*', '^myir,.*', '^natio=
nal,.*', '^neardi,.*', '^nec,.*', '^neonode,.*', '^netgear,.*', '^netlogic,=
.*', '^netron-dy,.*', '^netronix,.*', '^netxeon,.*', '^neweast,.*', '^newha=
ven,.*', '^newvision,.*', '^nexbox,.*', '^nextthing,.*', '^ni,.*', '^ninten=
do,.*', '^nlt,.*', '^nokia,.*', '^nordic,.*', '^novatek,.*', '^novtech,.*',=
 '^numonyx,.*', '^nutsboard,.*', '^nuvoton,.*', '^nvd,.*', '^nvidia,.*', '^=
nxp,.*', '^oceanic,.*', '^ocs,.*', '^oct,.*', '^okaya,.*', '^oki,.*', '^oli=
mex,.*', '^olpc,.*', '^onep
> >  lus,.*', '^onie,.*', '^onion,.*', '^onnn,.*', '^ontat,.*', '^opalkelly=
,.*', '^openailab,.*', '^opencores,.*', '^openembed,.*', '^openpandora,.*',=
 '^openrisc,.*', '^openwrt,.*', '^option,.*', '^oranth,.*', '^orisetech,.*'=
, '^ortustech,.*', '^osddisplays,.*', '^osmc,.*', '^ouya,.*', '^overkiz,.*'=
, '^ovti,.*', '^oxsemi,.*', '^ozzmaker,.*', '^panasonic,.*', '^parade,.*', =
'^parallax,.*', '^pda,.*', '^pericom,.*', '^pervasive,.*', '^phicomm,.*', '=
^phytec,.*', '^picochip,.*', '^pine64,.*', '^pineriver,.*', '^pixcir,.*', '=
^plantower,.*', '^plathome,.*', '^plda,.*', '^plx,.*', '^ply,.*', '^pni,.*'=
, '^pocketbook,.*', '^polaroid,.*', '^polyhex,.*', '^portwell,.*', '^poslab=
,.*', '^pov,.*', '^powertip,.*', '^powervr,.*', '^powkiddy,.*', '^primeview=
,.*', '^primux,.*', '^probox2,.*', '^prt,.*', '^pulsedlight,.*', '^purism,.=
*', '^qca,.*', '^qcom,.*', '^qemu,.*', '^qi,.*', '^qiaodian,.*', '^qihua,.*=
', '^qishenglong,.*', '^qnap,.*', '^quanta,.*', '^radxa,.*', '^raidsonic,.*=
', '^ralink,.*', '^ramtron,
> >  .*', '^raspberrypi,.*', '^raydium,.*', '^rda,.*', '^realtek,.*', '^rem=
arkable,.*', '^renesas,.*', '^rervision,.*', '^revotics,.*', '^rex,.*', '^r=
ichtek,.*', '^ricoh,.*', '^rikomagic,.*', '^riot,.*', '^riscv,.*', '^rockch=
ip,.*', '^rocktech,.*', '^rohm,.*', '^ronbo,.*', '^roofull,.*', '^roseapple=
pi,.*', '^rve,.*', '^saef,.*', '^samsung,.*', '^samtec,.*', '^sancloud,.*',=
 '^sandisk,.*', '^satoz,.*', '^sbs,.*', '^schindler,.*', '^schneider,.*', '=
^sciosense,.*', '^seagate,.*', '^seeed,.*', '^seirobotics,.*', '^semtech,.*=
', '^senseair,.*', '^sensirion,.*', '^sensortek,.*', '^sercomm,.*', '^sff,.=
*', '^sgd,.*', '^sgmicro,.*', '^sgx,.*', '^sharp,.*', '^shift,.*', '^shimaf=
uji,.*', '^shineworld,.*', '^shiratech,.*', '^si-en,.*', '^si-linux,.*', '^=
siemens,.*', '^sifive,.*', '^sigma,.*', '^sii,.*', '^sil,.*', '^silabs,.*',=
 '^silan,.*', '^silead,.*', '^silergy,.*', '^silex-insight,.*', '^siliconfi=
le,.*', '^siliconmitus,.*', '^silvaco,.*', '^simtek,.*', '^sinlinx,.*', '^s=
inovoip,.*', '^sinowealth,.
> >  *', '^sipeed,.*', '^sirf,.*', '^sis,.*', '^sitronix,.*', '^skov,.*', '=
^skyworks,.*', '^smartlabs,.*', '^smartrg,.*', '^smi,.*', '^smsc,.*', '^snp=
s,.*', '^sochip,.*', '^socionext,.*', '^solidrun,.*', '^solomon,.*', '^sony=
,.*', '^sophgo,.*', '^sourceparts,.*', '^spansion,.*', '^sparkfun,.*', '^sp=
inalhdl,.*', '^sprd,.*', '^square,.*', '^ssi,.*', '^sst,.*', '^sstar,.*', '=
^st,.*', '^st-ericsson,.*', '^starfive,.*', '^starry,.*', '^startek,.*', '^=
starterkit,.*', '^ste,.*', '^stericsson,.*', '^storlink,.*', '^storm,.*', '=
^storopack,.*', '^summit,.*', '^sunchip,.*', '^sundance,.*', '^sunplus,.*',=
 '^supermicro,.*', '^swir,.*', '^syna,.*', '^synology,.*', '^synopsys,.*', =
'^tbs,.*', '^tbs-biometrics,.*', '^tcg,.*', '^tcl,.*', '^tcs,.*', '^tdo,.*'=
, '^team-source-display,.*', '^technexion,.*', '^technologic,.*', '^techsta=
r,.*', '^techwell,.*', '^teejet,.*', '^teltonika,.*', '^tempo,.*', '^terasi=
c,.*', '^tesla,.*', '^tfc,.*', '^thead,.*', '^thine,.*', '^thingyjp,.*', '^=
thundercomm,.*', '^thwc,.*'
> >  , '^ti,.*', '^tianma,.*', '^tlm,.*', '^tmt,.*', '^topeet,.*', '^topic,=
.*', '^toppoly,.*', '^topwise,.*', '^toradex,.*', '^toshiba,.*', '^toumaz,.=
*', '^tpk,.*', '^tplink,.*', '^tpo,.*', '^tq,.*', '^transpeed,.*', '^traver=
se,.*', '^tronfy,.*', '^tronsmart,.*', '^truly,.*', '^tsd,.*', '^turing,.*'=
, '^tyan,.*', '^u-blox,.*', '^u-boot,.*', '^ubnt,.*', '^ucrobotics,.*', '^u=
doo,.*', '^ufispace,.*', '^ugoos,.*', '^uni-t,.*', '^uniwest,.*', '^upisemi=
,.*', '^urt,.*', '^usi,.*', '^usr,.*', '^utoo,.*', '^v3,.*', '^vaisala,.*',=
 '^vamrs,.*', '^variscite,.*', '^vdl,.*', '^vertexcom,.*', '^via,.*', '^via=
lab,.*', '^vicor,.*', '^videostrong,.*', '^virtio,.*', '^virtual,.*', '^vis=
hay,.*', '^visionox,.*', '^vitesse,.*', '^vivante,.*', '^vivax,.*', '^vocor=
e,.*', '^voipac,.*', '^voltafield,.*', '^vot,.*', '^vscom,.*', '^vxt,.*', '=
^wacom,.*', '^wanchanglong,.*', '^wand,.*', '^waveshare,.*', '^wd,.*', '^we=
,.*', '^welltech,.*', '^wetek,.*', '^wexler,.*', '^whwave,.*', '^wi2wi,.*',=
 '^widora,.*', '^wiligear,.
> >  *', '^willsemi,.*', '^winbond,.*', '^wingtech,.*', '^winlink,.*', '^wi=
nstar,.*', '^wirelesstag,.*', '^wits,.*', '^wlf,.*', '^wm,.*', '^wobo,.*', =
'^wolfvision,.*', '^x-powers,.*', '^xen,.*', '^xes,.*', '^xiaomi,.*', '^xil=
lybus,.*', '^xingbangda,.*', '^xinpeng,.*', '^xiphera,.*', '^xlnx,.*', '^xn=
ano,.*', '^xunlong,.*', '^xylon,.*', '^yadro,.*', '^yamaha,.*', '^yes-optoe=
lectronics,.*', '^yic,.*', '^yiming,.*', '^ylm,.*', '^yna,.*', '^yones-topt=
ech,.*', '^ys,.*', '^ysoft,.*', '^zarlink,.*', '^zealz,.*', '^zeitec,.*', '=
^zidoo,.*', '^zii,.*', '^zinitix,.*', '^zkmagic,.*', '^zte,.*', '^zyxel,.*'=
, 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/vendor-prefixes.ya=
ml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: syscon@1e6e2=
000: 'smp-memram@180' does not match any of the regexes: '^interrupt-contro=
ller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^si=
licon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00=
-scu.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sys=
con@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['=
aspeed,ast2600-smpmem']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sys=
con@1e6e2000/interrupt-controller@560: failed to match any schema with comp=
atible: ['aspeed,ast2600-scu-ic0']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sys=
con@1e6e2000/interrupt-controller@570: failed to match any schema with comp=
atible: ['aspeed,ast2600-scu-ic1']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/dis=
play@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600=
-gfx', 'syscon']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/xdm=
a@1e6e7000: failed to match any schema with compatible: ['aspeed,ast2600-xd=
ma']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: adc@1e6e9000=
: 'interrupts', 'vref' do not match any of the regexes: 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast=
2600-adc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: adc@1e6e9100=
: 'interrupts', 'vref' do not match any of the regexes: 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast=
2600-adc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: crypto@1e6fa=
000: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2=
600-acry.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/vid=
eo@1e700000: failed to match any schema with compatible: ['aspeed,ast2600-v=
ideo-engine']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: gpio@1e78000=
0: 'pinctrl-0' is a dependency of 'pinctrl-names'
> >       from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-co=
nsumer.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/tim=
er@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-t=
imer']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: lpc@1e789000=
: lpc-snoop@80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+=
'
> >       from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yam=
l#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: lpc@1e789000=
: reg-io-width: 4 is not of type 'object'
> >       from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yam=
l#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs@24: 'clo=
cks' does not match any of the regexes: 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast240=
0-kcs-bmc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs@28: 'clo=
cks' does not match any of the regexes: 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast240=
0-kcs-bmc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs@2c: 'clo=
cks' does not match any of the regexes: 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast240=
0-kcs-bmc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs@114: 'cl=
ocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast240=
0-kcs-bmc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/lpc=
@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2=
600-lhc']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/lpc=
@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast=
2600-ibt-bmc']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: sdc@1e740000=
: sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> >       from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.y=
aml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: sdc@1e740000=
: sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> >       from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.y=
aml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sdc=
@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['asp=
eed,ast2600-sdhci', 'sdhci']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sdc=
@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['asp=
eed,ast2600-sdhci', 'sdhci']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@100/i2c-mux@70/i2c@2/pwm@21: failed to match any schema with =
compatible: ['maxim,max31790']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@100/i2c-mux@70/i2c@2/pwm@27: failed to match any schema with =
compatible: ['maxim,max31790']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@60: failed to match any schema with =
compatible: ['isil,raa228004']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@61: failed to match any schema with =
compatible: ['isil,raa228004']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@62: failed to match any schema with =
compatible: ['isil,raa228004']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: i2c@400: Une=
valuated properties are not allowed ('aspeed,hw-timeout-ms' was unexpected)
> >       from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yam=
l#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus=
@1e78a000/i2c@400/ipmb@10: failed to match any schema with compatible: ['ip=
mb-dev']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ssif-bmc@10:=
 'arm-sbmr,skip-bootprogress-response' does not match any of the regexes: '=
pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/ipmi/ssif-bmc.yaml=
#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ssif-bmc@10:=
 'arm-sbmr,skip-bootprogress-response' does not match any of the regexes: '=
^#.*', '^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|g=
pmc|hdmi|i2c-gpio),.*', '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*', '=
^(pinctrl-single|#pinctrl-single|PowerPC),.*', '^(pl022|pxa-mmc|rcar_sound|=
rotary-encoder|s5m8767|sdhci),.*', '^(simple-audio-card|st-plgpio|st-spics|=
ts),.*', '^100ask,.*', '^70mai,.*', '^8dev,.*', '^GEFanuc,.*', '^IBM,.*', '=
^ORCL,.*', '^SUNW,.*', '^[a-zA-Z0-9#_][a-zA-Z0-9+\-._@]{0,63}$', '^[a-zA-Z0=
-9+\-._]*@[0-9a-zA-Z,]*$', '^abb,.*', '^abilis,.*', '^abracon,.*', '^abt,.*=
', '^acbel,.*', '^acelink,.*', '^acer,.*', '^acme,.*', '^actions,.*', '^act=
ive-semi,.*', '^ad,.*', '^adafruit,.*', '^adapteva,.*', '^adaptrum,.*', '^a=
dh,.*', '^adi,.*', '^adieng,.*', '^admatec,.*', '^advantech,.*', '^aeroflex=
gaisler,.*', '^aesop,.*', '^airoha,.*', '^al,.*', '^alcatel,.*', '^aldec,.*=
', '^alfa-network,.*', '^al
> >  legro,.*', '^alliedvision,.*', '^allo,.*', '^allwinner,.*', '^alphasca=
le,.*', '^alps,.*', '^alt,.*', '^altr,.*', '^amarula,.*', '^amazon,.*', '^a=
mcc,.*', '^amd,.*', '^amediatech,.*', '^amlogic,.*', '^ampere,.*', '^amphen=
ol,.*', '^ampire,.*', '^ams,.*', '^amstaos,.*', '^analogix,.*', '^anbernic,=
.*', '^andestech,.*', '^anvo,.*', '^aosong,.*', '^apm,.*', '^apple,.*', '^a=
ptina,.*', '^arasan,.*', '^archermind,.*', '^arcom,.*', '^arctic,.*', '^arc=
x,.*', '^aries,.*', '^arm,.*', '^armadeus,.*', '^armsom,.*', '^arrow,.*', '=
^artesyn,.*', '^asahi-kasei,.*', '^asc,.*', '^asix,.*', '^aspeed,.*', '^asr=
ock,.*', '^asteralabs,.*', '^asus,.*', '^atheros,.*', '^atlas,.*', '^atmel,=
.*', '^auo,.*', '^auvidea,.*', '^avago,.*', '^avia,.*', '^avic,.*', '^avnet=
,.*', '^awinic,.*', '^axentia,.*', '^axis,.*', '^azoteq,.*', '^azw,.*', '^b=
aikal,.*', '^bananapi,.*', '^beacon,.*', '^beagle,.*', '^belling,.*', '^bhf=
,.*', '^bigtreetech,.*', '^bitmain,.*', '^blutek,.*', '^boe,.*', '^bosch,.*=
', '^boundary,.*', '^brcm,.
> >  *', '^broadmobi,.*', '^bsh,.*', '^bticino,.*', '^buffalo,.*', '^bur,.*=
', '^bytedance,.*', '^calamp,.*', '^calao,.*', '^calaosystems,.*', '^calxed=
a,.*', '^cameo,.*', '^canaan,.*', '^caninos,.*', '^capella,.*', '^cascoda,.=
*', '^catalyst,.*', '^cavium,.*', '^cct,.*', '^cdns,.*', '^cdtech,.*', '^ce=
llwise,.*', '^ceva,.*', '^chargebyte,.*', '^checkpoint,.*', '^chefree,.*', =
'^chipidea,.*', '^chipone,.*', '^chipspark,.*', '^chongzhou,.*', '^chrontel=
,.*', '^chrp,.*', '^chunghwa,.*', '^chuwi,.*', '^ciaa,.*', '^cirrus,.*', '^=
cisco,.*', '^clockwork,.*', '^cloos,.*', '^cloudengines,.*', '^cnm,.*', '^c=
nxt,.*', '^colorfly,.*', '^compulab,.*', '^congatec,.*', '^coolpi,.*', '^co=
reriver,.*', '^corpro,.*', '^cortina,.*', '^cosmic,.*', '^crane,.*', '^crea=
tive,.*', '^crystalfontz,.*', '^csky,.*', '^csq,.*', '^ctera,.*', '^ctu,.*'=
, '^cubietech,.*', '^cudy,.*', '^cui,.*', '^cypress,.*', '^cyx,.*', '^cznic=
,.*', '^dallas,.*', '^dataimage,.*', '^davicom,.*', '^dell,.*', '^delta,.*'=
, '^densitron,.*', '^denx,.
> >  *', '^devantech,.*', '^dfi,.*', '^dh,.*', '^difrnce,.*', '^digi,.*', '=
^digilent,.*', '^dimonoff,.*', '^diodes,.*', '^dioo,.*', '^dlc,.*', '^dlg,.=
*', '^dlink,.*', '^dmo,.*', '^domintech,.*', '^dongwoon,.*', '^dptechnics,.=
*', '^dragino,.*', '^dream,.*', '^ds,.*', '^dserve,.*', '^dynaimage,.*', '^=
ea,.*', '^ebang,.*', '^ebbg,.*', '^ebs-systart,.*', '^ebv,.*', '^eckelmann,=
.*', '^edgeble,.*', '^edimax,.*', '^edt,.*', '^ees,.*', '^eeti,.*', '^einfo=
chips,.*', '^eink,.*', '^elan,.*', '^element14,.*', '^elgin,.*', '^elida,.*=
', '^elimo,.*', '^elpida,.*', '^embedfire,.*', '^embest,.*', '^emcraft,.*',=
 '^emlid,.*', '^emmicro,.*', '^empire-electronix,.*', '^emtrion,.*', '^encl=
ustra,.*', '^endless,.*', '^ene,.*', '^energymicro,.*', '^engicam,.*', '^en=
gleder,.*', '^epcos,.*', '^epfl,.*', '^epson,.*', '^esp,.*', '^est,.*', '^e=
ttus,.*', '^eukrea,.*', '^everest,.*', '^everspin,.*', '^evervision,.*', '^=
exar,.*', '^excito,.*', '^exegin,.*', '^ezchip,.*', '^facebook,.*', '^fairc=
hild,.*', '^fairphone,.*',
> >  '^faraday,.*', '^fascontek,.*', '^fastrax,.*', '^fcs,.*', '^feixin,.*'=
, '^feiyang,.*', '^fii,.*', '^firefly,.*', '^focaltech,.*', '^forlinx,.*', =
'^freebox,.*', '^freecom,.*', '^frida,.*', '^friendlyarm,.*', '^fsl,.*', '^=
fujitsu,.*', '^fxtec,.*', '^galaxycore,.*', '^gameforce,.*', '^gardena,.*',=
 '^gateway,.*', '^gateworks,.*', '^gcw,.*', '^ge,.*', '^geekbuying,.*', '^g=
ef,.*', '^gemei,.*', '^gemtek,.*', '^genesys,.*', '^geniatech,.*', '^giante=
c,.*', '^giantplus,.*', '^glinet,.*', '^globalscale,.*', '^globaltop,.*', '=
^gmt,.*', '^goldelico,.*', '^goodix,.*', '^google,.*', '^goramo,.*', '^gplu=
s,.*', '^grinn,.*', '^grmn,.*', '^gumstix,.*', '^gw,.*', '^hannstar,.*', '^=
haochuangyi,.*', '^haoyu,.*', '^hardkernel,.*', '^hechuang,.*', '^hideep,.*=
', '^himax,.*', '^hirschmann,.*', '^hisi,.*', '^hisilicon,.*', '^hit,.*', '=
^hitex,.*', '^holt,.*', '^holtek,.*', '^honestar,.*', '^honeywell,.*', '^ho=
perf,.*', '^hoperun,.*', '^hp,.*', '^hpe,.*', '^hsg,.*', '^htc,.*', '^huawe=
i,.*', '^hugsun,.*', '^hwac
> >  om,.*', '^hxt,.*', '^hycon,.*', '^hydis,.*', '^hynitron,.*', '^hynix,.=
*', '^hyundai,.*', '^i2se,.*', '^ibm,.*', '^icplus,.*', '^idt,.*', '^iei,.*=
', '^ifi,.*', '^ilitek,.*', '^imagis,.*', '^img,.*', '^imi,.*', '^inanbo,.*=
', '^incircuit,.*', '^indiedroid,.*', '^inet-tek,.*', '^infineon,.*', '^inf=
orce,.*', '^ingenic,.*', '^ingrasys,.*', '^injoinic,.*', '^innocomm,.*', '^=
innolux,.*', '^inside-secure,.*', '^insignal,.*', '^inspur,.*', '^intel,.*'=
, '^intercontrol,.*', '^invensense,.*', '^inventec,.*', '^inversepath,.*', =
'^iom,.*', '^irondevice,.*', '^isee,.*', '^isil,.*', '^issi,.*', '^ite,.*',=
 '^itead,.*', '^itian,.*', '^ivo,.*', '^iwave,.*', '^jadard,.*', '^jasonic,=
.*', '^jdi,.*', '^jedec,.*', '^jesurun,.*', '^jethome,.*', '^jianda,.*', '^=
jide,.*', '^joz,.*', '^kam,.*', '^karo,.*', '^keithkoep,.*', '^keymile,.*',=
 '^khadas,.*', '^kiebackpeter,.*', '^kinetic,.*', '^kingdisplay,.*', '^king=
novel,.*', '^kionix,.*', '^kobo,.*', '^kobol,.*', '^koe,.*', '^kontron,.*',=
 '^kosagi,.*', '^kvg,.*', '
> >  ^kyo,.*', '^lacie,.*', '^laird,.*', '^lamobo,.*', '^lantiq,.*', '^latt=
ice,.*', '^lctech,.*', '^leadtek,.*', '^leez,.*', '^lego,.*', '^lemaker,.*'=
, '^lenovo,.*', '^lg,.*', '^lgphilips,.*', '^libretech,.*', '^licheepi,.*',=
 '^linaro,.*', '^lincolntech,.*', '^lineartechnology,.*', '^linksprite,.*',=
 '^linksys,.*', '^linutronix,.*', '^linux,.*', '^linx,.*', '^liteon,.*', '^=
litex,.*', '^lltc,.*', '^logicpd,.*', '^logictechno,.*', '^longcheer,.*', '=
^lontium,.*', '^loongmasses,.*', '^loongson,.*', '^lsi,.*', '^lunzn,.*', '^=
luxul,.*', '^lwn,.*', '^lxa,.*', '^m5stack,.*', '^macnica,.*', '^mantix,.*'=
, '^mapleboard,.*', '^marantec,.*', '^marvell,.*', '^maxbotix,.*', '^maxim,=
.*', '^maxlinear,.*', '^mbvl,.*', '^mcube,.*', '^meas,.*', '^mecer,.*', '^m=
ediatek,.*', '^megachips,.*', '^mele,.*', '^melexis,.*', '^melfas,.*', '^me=
llanox,.*', '^memsensing,.*', '^memsic,.*', '^menlo,.*', '^mentor,.*', '^me=
raki,.*', '^merrii,.*', '^methode,.*', '^micrel,.*', '^microchip,.*', '^mic=
rocrystal,.*', '^micron,.*'
> >  , '^microsoft,.*', '^microsys,.*', '^microtips,.*', '^mikroe,.*', '^mi=
krotik,.*', '^milkv,.*', '^miniand,.*', '^minix,.*', '^mips,.*', '^miramems=
,.*', '^mitsubishi,.*', '^mitsumi,.*', '^mixel,.*', '^miyoo,.*', '^mntre,.*=
', '^mobileye,.*', '^modtronix,.*', '^moortec,.*', '^mosaixtech,.*', '^moto=
rcomm,.*', '^motorola,.*', '^moxa,.*', '^mpl,.*', '^mps,.*', '^mqmaker,.*',=
 '^mrvl,.*', '^mscc,.*', '^msi,.*', '^mstar,.*', '^mti,.*', '^multi-inno,.*=
', '^mundoreader,.*', '^murata,.*', '^mxic,.*', '^mxicy,.*', '^myir,.*', '^=
national,.*', '^neardi,.*', '^nec,.*', '^neonode,.*', '^netgear,.*', '^netl=
ogic,.*', '^netron-dy,.*', '^netronix,.*', '^netxeon,.*', '^neweast,.*', '^=
newhaven,.*', '^newvision,.*', '^nexbox,.*', '^nextthing,.*', '^ni,.*', '^n=
intendo,.*', '^nlt,.*', '^nokia,.*', '^nordic,.*', '^novatek,.*', '^novtech=
,.*', '^numonyx,.*', '^nutsboard,.*', '^nuvoton,.*', '^nvd,.*', '^nvidia,.*=
', '^nxp,.*', '^oceanic,.*', '^ocs,.*', '^oct,.*', '^okaya,.*', '^oki,.*', =
'^olimex,.*', '^olpc,.*', '
> >  ^oneplus,.*', '^onie,.*', '^onion,.*', '^onnn,.*', '^ontat,.*', '^opal=
kelly,.*', '^openailab,.*', '^opencores,.*', '^openembed,.*', '^openpandora=
,.*', '^openrisc,.*', '^openwrt,.*', '^option,.*', '^oranth,.*', '^orisetec=
h,.*', '^ortustech,.*', '^osddisplays,.*', '^osmc,.*', '^ouya,.*', '^overki=
z,.*', '^ovti,.*', '^oxsemi,.*', '^ozzmaker,.*', '^panasonic,.*', '^parade,=
.*', '^parallax,.*', '^pda,.*', '^pericom,.*', '^pervasive,.*', '^phicomm,.=
*', '^phytec,.*', '^picochip,.*', '^pine64,.*', '^pineriver,.*', '^pixcir,.=
*', '^plantower,.*', '^plathome,.*', '^plda,.*', '^plx,.*', '^ply,.*', '^pn=
i,.*', '^pocketbook,.*', '^polaroid,.*', '^polyhex,.*', '^portwell,.*', '^p=
oslab,.*', '^pov,.*', '^powertip,.*', '^powervr,.*', '^powkiddy,.*', '^prim=
eview,.*', '^primux,.*', '^probox2,.*', '^prt,.*', '^pulsedlight,.*', '^pur=
ism,.*', '^qca,.*', '^qcom,.*', '^qemu,.*', '^qi,.*', '^qiaodian,.*', '^qih=
ua,.*', '^qishenglong,.*', '^qnap,.*', '^quanta,.*', '^radxa,.*', '^raidson=
ic,.*', '^ralink,.*', '^ram
> >  tron,.*', '^raspberrypi,.*', '^raydium,.*', '^rda,.*', '^realtek,.*', =
'^remarkable,.*', '^renesas,.*', '^rervision,.*', '^revotics,.*', '^rex,.*'=
, '^richtek,.*', '^ricoh,.*', '^rikomagic,.*', '^riot,.*', '^riscv,.*', '^r=
ockchip,.*', '^rocktech,.*', '^rohm,.*', '^ronbo,.*', '^roofull,.*', '^rose=
applepi,.*', '^rve,.*', '^saef,.*', '^samsung,.*', '^samtec,.*', '^sancloud=
,.*', '^sandisk,.*', '^satoz,.*', '^sbs,.*', '^schindler,.*', '^schneider,.=
*', '^sciosense,.*', '^seagate,.*', '^seeed,.*', '^seirobotics,.*', '^semte=
ch,.*', '^senseair,.*', '^sensirion,.*', '^sensortek,.*', '^sercomm,.*', '^=
sff,.*', '^sgd,.*', '^sgmicro,.*', '^sgx,.*', '^sharp,.*', '^shift,.*', '^s=
himafuji,.*', '^shineworld,.*', '^shiratech,.*', '^si-en,.*', '^si-linux,.*=
', '^siemens,.*', '^sifive,.*', '^sigma,.*', '^sii,.*', '^sil,.*', '^silabs=
,.*', '^silan,.*', '^silead,.*', '^silergy,.*', '^silex-insight,.*', '^sili=
confile,.*', '^siliconmitus,.*', '^silvaco,.*', '^simtek,.*', '^sinlinx,.*'=
, '^sinovoip,.*', '^sinowea
> >  lth,.*', '^sipeed,.*', '^sirf,.*', '^sis,.*', '^sitronix,.*', '^skov,.=
*', '^skyworks,.*', '^smartlabs,.*', '^smartrg,.*', '^smi,.*', '^smsc,.*', =
'^snps,.*', '^sochip,.*', '^socionext,.*', '^solidrun,.*', '^solomon,.*', '=
^sony,.*', '^sophgo,.*', '^sourceparts,.*', '^spansion,.*', '^sparkfun,.*',=
 '^spinalhdl,.*', '^sprd,.*', '^square,.*', '^ssi,.*', '^sst,.*', '^sstar,.=
*', '^st,.*', '^st-ericsson,.*', '^starfive,.*', '^starry,.*', '^startek,.*=
', '^starterkit,.*', '^ste,.*', '^stericsson,.*', '^storlink,.*', '^storm,.=
*', '^storopack,.*', '^summit,.*', '^sunchip,.*', '^sundance,.*', '^sunplus=
,.*', '^supermicro,.*', '^swir,.*', '^syna,.*', '^synology,.*', '^synopsys,=
.*', '^tbs,.*', '^tbs-biometrics,.*', '^tcg,.*', '^tcl,.*', '^tcs,.*', '^td=
o,.*', '^team-source-display,.*', '^technexion,.*', '^technologic,.*', '^te=
chstar,.*', '^techwell,.*', '^teejet,.*', '^teltonika,.*', '^tempo,.*', '^t=
erasic,.*', '^tesla,.*', '^tfc,.*', '^thead,.*', '^thine,.*', '^thingyjp,.*=
', '^thundercomm,.*', '^thw
> >  c,.*', '^ti,.*', '^tianma,.*', '^tlm,.*', '^tmt,.*', '^topeet,.*', '^t=
opic,.*', '^toppoly,.*', '^topwise,.*', '^toradex,.*', '^toshiba,.*', '^tou=
maz,.*', '^tpk,.*', '^tplink,.*', '^tpo,.*', '^tq,.*', '^transpeed,.*', '^t=
raverse,.*', '^tronfy,.*', '^tronsmart,.*', '^truly,.*', '^tsd,.*', '^turin=
g,.*', '^tyan,.*', '^u-blox,.*', '^u-boot,.*', '^ubnt,.*', '^ucrobotics,.*'=
, '^udoo,.*', '^ufispace,.*', '^ugoos,.*', '^uni-t,.*', '^uniwest,.*', '^up=
isemi,.*', '^urt,.*', '^usi,.*', '^usr,.*', '^utoo,.*', '^v3,.*', '^vaisala=
,.*', '^vamrs,.*', '^variscite,.*', '^vdl,.*', '^vertexcom,.*', '^via,.*', =
'^vialab,.*', '^vicor,.*', '^videostrong,.*', '^virtio,.*', '^virtual,.*', =
'^vishay,.*', '^visionox,.*', '^vitesse,.*', '^vivante,.*', '^vivax,.*', '^=
vocore,.*', '^voipac,.*', '^voltafield,.*', '^vot,.*', '^vscom,.*', '^vxt,.=
*', '^wacom,.*', '^wanchanglong,.*', '^wand,.*', '^waveshare,.*', '^wd,.*',=
 '^we,.*', '^welltech,.*', '^wetek,.*', '^wexler,.*', '^whwave,.*', '^wi2wi=
,.*', '^widora,.*', '^wilig
> >  ear,.*', '^willsemi,.*', '^winbond,.*', '^wingtech,.*', '^winlink,.*',=
 '^winstar,.*', '^wirelesstag,.*', '^wits,.*', '^wlf,.*', '^wm,.*', '^wobo,=
.*', '^wolfvision,.*', '^x-powers,.*', '^xen,.*', '^xes,.*', '^xiaomi,.*', =
'^xillybus,.*', '^xingbangda,.*', '^xinpeng,.*', '^xiphera,.*', '^xlnx,.*',=
 '^xnano,.*', '^xunlong,.*', '^xylon,.*', '^yadro,.*', '^yamaha,.*', '^yes-=
optoelectronics,.*', '^yic,.*', '^yiming,.*', '^ylm,.*', '^yna,.*', '^yones=
-toptech,.*', '^ys,.*', '^ysoft,.*', '^zarlink,.*', '^zealz,.*', '^zeitec,.=
*', '^zidoo,.*', '^zii,.*', '^zinitix,.*', '^zkmagic,.*', '^zte,.*', '^zyxe=
l,.*', 'pinctrl-[0-9]+'
> >       from schema $id: http://devicetree.org/schemas/vendor-prefixes.ya=
ml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: fsi@1e79b000=
: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
> >       from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600=
-fsi-master.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/fsi=
@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi=
-master', 'fsi-master']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: fsi@1e79b100=
: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
> >       from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600=
-fsi-master.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/fsi=
@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi=
-master', 'fsi-master']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/dma=
-controller@1e79e000: failed to match any schema with compatible: ['aspeed,=
ast2600-udma']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: $=
nodename:0: 'spi1-gpio' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
> >       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: g=
pio-sck: False schema does not allow [44, 203, 0]
> >       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: g=
pio-miso: False schema does not allow [44, 205, 0]
> >       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: g=
pio-mosi: False schema does not allow [44, 204, 0]
> >       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: '=
sck-gpios' is a required property
> >       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: U=
nevaluated properties are not allowed ('#address-cells', '#size-cells', 'gp=
io-miso', 'gpio-mosi', 'gpio-sck', 'tpm@0' were unexpected)
> >       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
>
> Can you please clean these up as best you can?
>
> Andrew

Hi Andrew,

I have corrected the error in "aspeed-bmc-facebook-catalina.dts" in v5.
https://lore.kernel.org/all/20240726-potin-catalina-dts-v5-2-8f02305af527@g=
mail.com/

It looks like most of the errors are from "aspeed-g6.dtsi".

Best regards,
Potin

