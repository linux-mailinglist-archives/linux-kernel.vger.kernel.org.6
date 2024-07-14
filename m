Return-Path: <linux-kernel+bounces-251707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6842293087E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 06:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAB5281CDA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 04:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2AFBFC;
	Sun, 14 Jul 2024 04:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg0W/paq"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B6EDF4D;
	Sun, 14 Jul 2024 04:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720932195; cv=none; b=fXPsp++QCuwI9twMsJvbMbkLFbUYXaoWy3Gp8W0Jev9eD7v+vJ3oP1klHvttbe0QLLpXZ8OSHVVeBkExiGGnSyz/71A3lp4hdtXE7ALpelbHMEwPSd/fUsx4lpqdXrkt+9DAOYXNTeYHC29esRDZhy1D6IfiNNhvPk3B5XU3lq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720932195; c=relaxed/simple;
	bh=aseRciaC/UFHkMfMjIsAPgwhwbsuQ1IeyE9cQiTqS48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5iudSGWacM9FFHPkxeTq9LXNJkm+4568bYqqY1riwO1sARwLhcAX/0FnL46c8JreD14PS3e9SvhOBUIjNhg1N28+habhe2YlmhDPWMVmAzT+cOG0o5zsWNzpUU6w4MPpzLi9zjjkm8OiSuPVZ0jRknAacaxO7Mw7GuQmfQNk/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg0W/paq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea7d2a039so3389697e87.3;
        Sat, 13 Jul 2024 21:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720932192; x=1721536992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lJVLYi+pE04YOrrCFHXVXYXIWButASzCZnzKDh4ZGOU=;
        b=fg0W/paqTjWmC/z42/c0HJReaJV9Oq838MaxzinuYkm1CgfNTV3j0lqKGFbs37xMKd
         Km7nVNVjGBBYCGl8HcKuVl1LdRdMNZImsnpvGItpvctcvnH3DWQvjl3PJdpUFXuluu2I
         COItI78Vbvfo+Dsm6vquEnRW/rC1Kh5VkkoxvrxFC4aFs1ITyPP7HfgMS5qSlDNYB3FC
         fw1cCLToa27fSi3QKXnjIgRCYiDDy6jQbxrPlGpIjBBTaRjy+rJ3jMwxltlgn6TgZxJt
         75VPbnAgLOMqYa+CLl/oYF3/klxBh62JZYd0CdLcVqz4Sm23ZvisbizNsctZy9x1rRWr
         +/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720932192; x=1721536992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJVLYi+pE04YOrrCFHXVXYXIWButASzCZnzKDh4ZGOU=;
        b=h6eVhGr2tD6dEeBj7wqi9rFuwZP2V4AL0w2jhysTAguwuQwbwTMgIfOvtza3cnUSO3
         WxbT3eZXh98UBxnR/ISS4v3dMm9XAYTUqdbWQmdtZF2ijwWpDC5Na1mdOt+f0Nfk31yi
         f0uI9TcUh9iofBjuqCKvFK5xD8wKoQw4I5Ot5c3CC45uxCyiPhSOG1av9k6sJaqPZJ6L
         LsxBz3p7vvgjwbZrGGe+ZYRA8l3rg1CfzDi2DWhP6R5JrJqUS66J8gKLXci2dvlIxFSo
         X8CKzNIOkikFO2ooHplpdJdjBzSXYCNdJ09osVn7gKAacbBUWu2A32iKC1y/nDk8kzTx
         3Xaw==
X-Forwarded-Encrypted: i=1; AJvYcCU9KradyVtUXHDdLk/fHksKfQ6QYviX4KMtKU+usK/fEu+2G2KKeIQ0Fd3PwkNdn4iPBmsdf4yGDxWRru8PflLhmiYY34+xjmnEoZAOxtjmEDTBA5EvKZMei7hiQZvHM1HvwteeSN2QdA==
X-Gm-Message-State: AOJu0YzPQgkPOz+ZPa/3LQdNR1/UDtw/KhhtQmRaNNFZOuwTFIYoT4LU
	H2Cnu2Px3BzFzShn6m/6OTiSJNtV5Kue0gWaDWoRxswooRQfQPO8EHrB2Ll5lErHj/QuzQZE66B
	kosrgDJ+EZXYoEaKZmAIM+bieF6Q=
X-Google-Smtp-Source: AGHT+IEveCVlfZLVXJBHR90dZnmVx2pwSADMUlIbtkIq79k5uJZENwwhysMVMYxHLsknIe9g0lDKWihmS5z1YbEu5Z4=
X-Received: by 2002:a05:6512:2810:b0:52c:e326:f4cf with SMTP id
 2adb3069b0e04-52eb999125amr12348016e87.3.1720932191396; Sat, 13 Jul 2024
 21:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621130903.2572986-1-net147@gmail.com> <202406282049.ZRM6qCDn-lkp@intel.com>
In-Reply-To: <202406282049.ZRM6qCDn-lkp@intel.com>
From: Jonathan Liu <net147@gmail.com>
Date: Sun, 14 Jul 2024 14:43:00 +1000
Message-ID: <CANwerB3oAuTcwmy4FdjmH-XRa5M3raHAt4DKLspThC-ryQmagw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Enable RK809 audio codec for Radxa
 ROCK 4C+
To: kernel test robot <lkp@intel.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Conor Dooley <conor.dooley@microchip.com>, FUKAUMI Naoki <naoki@radxa.com>, 
	Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, 28 Jun 2024 at 23:07, kernel test robot <lkp@intel.com> wrote:
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on rockchip/for-next]
> [also build test WARNING on krzk/for-next krzk-dt/for-next linus/master v6.10-rc5 next-20240627]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Liu/arm64-dts-rockchip-Enable-RK809-audio-codec-for-Radxa-ROCK-4C/20240625-210156
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
> patch link:    https://lore.kernel.org/r/20240621130903.2572986-1-net147%40gmail.com
> patch subject: [PATCH] arm64: dts: rockchip: Enable RK809 audio codec for Radxa ROCK 4C+
> config: arm64-randconfig-051-20240628 (https://download.01.org/0day-ci/archive/20240628/202406282049.ZRM6qCDn-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> dtschema version: 2024.6.dev3+g650bf2d
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406282049.ZRM6qCDn-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406282049.ZRM6qCDn-lkp@intel.com/
>
> dtcheck warnings: (new ones prefixed by >>)
>    arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
>    arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>    arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>    arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('snps,txpbl' was unexpected)
>         from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>    arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: usb@fe800000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
>    arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']

> >> arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: pmic@20: '#sound-dai-cells', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

The new dtcheck warnings are resolved by "dt-bindings: mfd: rk817:
Merge support for RK809" in linux-next so this patch should be applied
after that commit.

>         from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
>    arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: regulator@40: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/fcs,fan53555.yaml#
>    arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: regulator@41: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/fcs,fan53555.yaml#
>    arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
>    arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
>    arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
>    arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
>    arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: pmic: vsel1-gpio: {'rockchip,pins': [[1, 17, 0, 194]], 'phandle': [[138]]} is not of type 'array'
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Regards,
Jonathan

