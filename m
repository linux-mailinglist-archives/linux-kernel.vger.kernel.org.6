Return-Path: <linux-kernel+bounces-205605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53138FFE0A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516CC284242
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC7F15B117;
	Fri,  7 Jun 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK9AJaZ5"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE1152DFA;
	Fri,  7 Jun 2024 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749083; cv=none; b=miYYF0FwgeKJfQj3VjxHtBb+8lYtTOS0qTegMzETqpkyp5bF7OkIsQa8k5eXbnZyyeR1uJbZSAyLlsbC0/B5fshuTobw61Yv5Da6SQ4+7bh3qF5/0AIeu+IjSIvTIiqBFFTiNy03oWEh+DQRKhPFFQeLn4iup6uNCJL5RcXrwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749083; c=relaxed/simple;
	bh=UmVEOr6PldRB4UQj7PFbWh0cEkA1HnWZKAihYWYYAVQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l8MPWn3WXzMzp9gpXfrrFjuAHB44qa0aQ1axH3AUbQlTA9ETtqDh6LE9218Yqtn0o5TmEQGC7GNWqR2FKZJNIyT17fqd3MCt0PS3S6qZeNNAxLyBBDBxNFUQePvsDHjLKhADafrOjxXZ0zHVQ/FnrBeFZ/cGLUWEdR70JYO3+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK9AJaZ5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e724bc466fso22877101fa.3;
        Fri, 07 Jun 2024 01:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717749080; x=1718353880; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DuO23jZ0yNpZDQlXy4KWuQ3OqB8VX+2cVKHM/HssMw=;
        b=RK9AJaZ5nZtqRRg6MXSe470jBrOLUIae4TOg6818kwkOsfvySLD8H9HW9CJ/KyHm1t
         b8SpSiQ45Nz+oEvtz5XQvM8JW8R0d4MM2tXeuqmKk2az0+kdNX5J0shecK9wG3cPy3VT
         EgYd21bcHeb7Xau0FeMgf+Xu6PMEMfAMgs9v5rM1l1oZnUZD6RH6sJDFabCLSUYffkuo
         u+Vws5DznoINmBii+gtxOQC1OPAr45PNFqlhK9OXREResIo0uI5qB4FI/uEBPp4pUv6z
         V5tkumI/8CKfq+tkNUpo9qIovcl1/sj0j3BRTYOcGni8cnxL2BzqlcnwLX34himebV79
         5MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749080; x=1718353880;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DuO23jZ0yNpZDQlXy4KWuQ3OqB8VX+2cVKHM/HssMw=;
        b=ELVcjKPxTFHBTdO2EWoBivI6hN7bhV3gVvlWDGUAONOKWekmbIJvode8KPWc66JmT3
         Df1WqRHMLjfYjU5IZCXtQZXJmEuV+QJ+cuprvqbRkjRTqwBv9LXwJ6MHN6QcPti9/Q2F
         jgS8FkPaGnJeBIF7nBpIjEuXH7hXpY6H8kuQ4Xb288EE4niMkGDBoGrFM3ZgGNiSiJ+7
         Em/gsT0XXnWuoCDadxYQxuQuQUyvxDoXB0sOITnDcyFYIhm/rtmN2Wkl3XnUQd4taB84
         gjUDBIAK3Ee60YsPHYYjZcv6CFibzzAfLcIJtPl6NjmVtctwYgsQYt8kGyW7ItUR+Vuo
         PB6w==
X-Forwarded-Encrypted: i=1; AJvYcCWetqR62Ii0LCPa2E1yLpBpZsDenY4Pw0QY3e51406jXYrkFE9pdOsoy9/3WErriQaQ3pbbn3cqAmab1hhVKXT/eEmWDQGaQxdMcZIG7IU5CCF1z7x46u12ICknG8pgfw+9wrpnpMwnlQ==
X-Gm-Message-State: AOJu0YzV4KRMQnTYSLQBhZDHZ4A9SV5wB2D5Vz0oj1hdFFy3ouYEkRBG
	6z1p/OJGjD2LCi/eerDdkDEXbmckRN9A6YFSnhofOC8DAiyyKrQU
X-Google-Smtp-Source: AGHT+IF35NHJkt0/GZ2wA+6lejpaPF/1YIbi+EiO5wykf6Binanla8DE0xf9gcQLDJuseJaz3OnbDg==
X-Received: by 2002:a2e:84d7:0:b0:2ea:8308:841b with SMTP id 38308e7fff4ca-2eadce4cf3dmr15806201fa.31.1717749079372;
        Fri, 07 Jun 2024 01:31:19 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d69867sm3485152f8f.57.2024.06.07.01.31.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2024 01:31:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 3/3] arm64: dts: meson: add initial support for Dreambox
 One/Two
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <202406071527.fnfhnkUL-lkp@intel.com>
Date: Fri, 7 Jun 2024 12:31:04 +0400
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 AML <linux-amlogic@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 oe-kbuild-all@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB2C9481-FCA2-496D-B916-E429BB8C0C82@gmail.com>
References: <20240606094513.3949323-3-christianshewitt@gmail.com>
 <202406071527.fnfhnkUL-lkp@intel.com>
To: kernel test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3774.600.62)

> On 7 Jun 2024, at 12:10=E2=80=AFPM, kernel test robot <lkp@intel.com> =
wrote:
>=20
> Hi Christian,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on krzk/for-next linus/master v6.10-rc2 =
next-20240606]
> [cannot apply to krzk-dt/for-next krzk-mem-ctrl/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a =
note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    =
https://github.com/intel-lab-lkp/linux/commits/Christian-Hewitt/dt-binding=
s-arm-amlogic-add-support-for-Dreambox-One-Two/20240606-175427
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git =
for-next
> patch link:    =
https://lore.kernel.org/r/20240606094513.3949323-3-christianshewitt%40gmai=
l.com
> patch subject: [PATCH 3/3] arm64: dts: meson: add initial support for =
Dreambox One/Two
> compiler: clang version 19.0.0git =
(https://github.com/llvm/llvm-project =
d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
> dtschema version: 2024.6.dev1+g833054f
> reproduce: =
(https://download.01.org/0day-ci/archive/20240607/202406071527.fnfhnkUL-lk=
p@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: =
https://lore.kernel.org/oe-kbuild-all/202406071527.fnfhnkUL-lkp@intel.com/=

>=20
> dtcheck warnings: (new ones prefixed by >>)
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: =
Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: =
node has a unit name, but no reg or ranges property
>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: =
Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: =
missing or empty reg/ranges property
>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6: =
Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: =
unnecessary #address-cells/#size-cells without "ranges" or child "reg" =
property
>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6
>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: =
/soc/bus@ff600000/bus@42000/clock-controller@0: failed to match any =
schema with compatible: ['amlogic,g12a-audio-clkc']
>   arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: =
/soc/bus@ff600000/bus@42000/audio-controller@744: failed to match any =
schema with compatible: ['amlogic,g12a-tohdmitx']
>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: sys-ctrl@0: =
'#address-cells', '#size-cells', 'ranges' do not match any of the =
regexes: 'pinctrl-[0-9]+'
>    from schema $id: =
http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yam=
l#
> --
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: =
Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: =
node has a unit name, but no reg or ranges property
>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: =
Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: =
missing or empty reg/ranges property
>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6: =
Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: =
unnecessary #address-cells/#size-cells without "ranges" or child "reg" =
property
>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6
>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: =
/soc/bus@ff600000/bus@42000/clock-controller@0: failed to match any =
schema with compatible: ['amlogic,g12a-audio-clkc']
>   arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: =
/soc/bus@ff600000/bus@42000/audio-controller@744: failed to match any =
schema with compatible: ['amlogic,g12a-tohdmitx']
>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: sys-ctrl@0: =
'#address-cells', '#size-cells', 'ranges' do not match any of the =
regexes: 'pinctrl-[0-9]+'
>    from schema $id: =
http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yam=
l#

Nothing to fix. The patch just depends on Neil=E2=80=99s binding fixes =
here:

=
https://patchwork.kernel.org/project/linux-amlogic/cover/20240606-topic-am=
logic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org/

Christian


