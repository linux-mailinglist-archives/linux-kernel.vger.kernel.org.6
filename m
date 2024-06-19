Return-Path: <linux-kernel+bounces-221260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE0590F0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A3A1C22C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1671DA4C;
	Wed, 19 Jun 2024 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXf7SWnx"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F681F95E;
	Wed, 19 Jun 2024 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808159; cv=none; b=DEBOQ0skX+L9LbAunrnzHWDrODoi1NaKOgIgcERKzU+9HbqdNNJllm8fz3Vj9dYclfC4D66aFX7AzoSpC6EwKT9uKQLQmCkHOh/0cMXJmO8fPZ+FkYF1ceEw03h148kQuhDCVVwc6j957J542zaT+qbFNgKLcBHh2rm+9fX4wqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808159; c=relaxed/simple;
	bh=utiApLSzMutmu7OEF/8rt22Sk3ytdrDytRDP7uyu6+Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RGYxl0dWfUQsGxxKQFMDIQzAKVAwgI92kRQ2VpJDD9hH2ho4SRtIyrPPPcRG6RIuhh21NJ9bj4GvQMLF1H9lr6ZLr/R7LWGZbd/bbenL/cZfSMlb2ndAefPTY1wi9+CmAzaOg5BMw8F5xoVQnA08m2+DBVf+a310QZPd90LmBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXf7SWnx; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so118859781fa.0;
        Wed, 19 Jun 2024 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718808156; x=1719412956; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrNaD0zVW3DChvXbXhKCNiu4238wS0EYPxxc2VaoSyQ=;
        b=jXf7SWnxLTGEYdOEiS6KiH6dBzWVRYDlULRreJ1Yvxp0oYOCOTjX8PF1oRkzkemtJE
         LG6e4JCoidUqFH7YfymU8VswfNt8cSkTD4FWG2fpmy2HOXNgiINoeHwoASj7K2lPYmWM
         KHvDzp8Mn5xhv3ffJ6mK4xmioTQ78f5USPpe97D3begAMZ3kCfypC/y3/UwceFeIZ1mA
         /h/MlwMaki8rsFyYpl+j1I6wv7JolPA8a/DLvoDqlSCcRUTxsHtg+17z/DK0aqkiiIMc
         F5lyfT5xl6mxol07PgbWx3+0cJflpbE0oVK7Hy5YY2uhfr7/J+ghzc/BqfAyULtaR3JL
         4nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718808156; x=1719412956;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrNaD0zVW3DChvXbXhKCNiu4238wS0EYPxxc2VaoSyQ=;
        b=KOgCdpV1M2JgNM6KRpMgh3sRoY/MtmzvoTva/yAEfhosYxFKn2VHPJ4QO+2OnEZIFO
         OdVbbv8FsaaehoRTjwTK78CbvUNVmC5gZ8WdYT10Wx0lk0/24dtKIkyQoWeX+FPeN1iR
         v4E8iveH6Bj7tdCIdz0+OBJt9czlwsZD0HMID/5DSlejFP4hq+Oo0omDABABgj5BjsFd
         OV0TWOfU+feIUAXEDG5AyhQ5yiQHbwxJTXDJWK0zdNrJzCDdhnnwiv0D1ufXPz6cMxwc
         hamg7oOZ3qMQsNkh10+R4UPa04fajTp3uhZ4+eHaWrCWJt6Ux5T0gX+SG+PjFW3YxQcf
         Aoow==
X-Forwarded-Encrypted: i=1; AJvYcCUpkH2Y1TPmc2vrURLYHP3oM4Ef82orF5B4qNCv55nxdS3Yjnoq+vs29jVf50fJoqq0nTU0SDTDF6nYSHc+NB8S5drQqOp254Mfsmh2m0URNHQZ/PQcy9fACmyE4fKnokqIZIcx1Q7wNw==
X-Gm-Message-State: AOJu0Yw7KeSZ88vk6UIdiusirJdY7dEjzt6lVceNQSQY54pzIsT4FU7H
	op8YlO/Mjf9p0Xzc7wvm64gvoDaZyBDDl0CQdiX1b+oBHSMGTGjW
X-Google-Smtp-Source: AGHT+IEa405I7Zca/4R1by2D1xir1eo+sByG2M6vyPFJq1gddTkxv9fbkpe26ZtAvIt4YYdQlBBtFQ==
X-Received: by 2002:a2e:9210:0:b0:2de:8697:e08b with SMTP id 38308e7fff4ca-2ec3ced12bdmr21232381fa.26.1718808155415;
        Wed, 19 Jun 2024 07:42:35 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fb282b057sm29603566b.31.2024.06.19.07.42.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2024 07:42:35 -0700 (PDT)
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
In-Reply-To: <39d1c5e1-e27b-4736-87e0-ca42ccf8885a@linaro.org>
Date: Wed, 19 Jun 2024 18:42:20 +0400
Cc: kernel test robot <lkp@intel.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 AML <linux-amlogic@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 oe-kbuild-all@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <893D54FC-6796-484C-B000-FE6DC185BA22@gmail.com>
References: <20240606094513.3949323-3-christianshewitt@gmail.com>
 <202406071527.fnfhnkUL-lkp@intel.com>
 <FB2C9481-FCA2-496D-B916-E429BB8C0C82@gmail.com>
 <39d1c5e1-e27b-4736-87e0-ca42ccf8885a@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: Apple Mail (2.3774.600.62)

> On 19 Jun 2024, at 6:06=E2=80=AFPM, Neil Armstrong =
<neil.armstrong@linaro.org> wrote:
>=20
> On 07/06/2024 10:31, Christian Hewitt wrote:
>>> On 7 Jun 2024, at 12:10=E2=80=AFPM, kernel test robot =
<lkp@intel.com> wrote:
>>>=20
>>> Hi Christian,
>>>=20
>>> kernel test robot noticed the following build warnings:
>>>=20
>>> [auto build test WARNING on robh/for-next]
>>> [also build test WARNING on krzk/for-next linus/master v6.10-rc2 =
next-20240606]
>>> [cannot apply to krzk-dt/for-next krzk-mem-ctrl/for-next]
>>> [If your patch is applied to the wrong git tree, kindly drop us a =
note.
>>> And when submitting patch, we suggest to use '--base' as documented =
in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>=20
>>> url:    =
https://github.com/intel-lab-lkp/linux/commits/Christian-Hewitt/dt-binding=
s-arm-amlogic-add-support-for-Dreambox-One-Two/20240606-175427
>>> base:   =
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
>>> patch link:    =
https://lore.kernel.org/r/20240606094513.3949323-3-christianshewitt%40gmai=
l.com
>>> patch subject: [PATCH 3/3] arm64: dts: meson: add initial support =
for Dreambox One/Two
>>> compiler: clang version 19.0.0git =
(https://github.com/llvm/llvm-project =
d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
>>> dtschema version: 2024.6.dev1+g833054f
>>> reproduce: =
(https://download.01.org/0day-ci/archive/20240607/202406071527.fnfhnkUL-lk=
p@intel.com/reproduce)
>>>=20
>>> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: =
https://lore.kernel.org/oe-kbuild-all/202406071527.fnfhnkUL-lkp@intel.com/=

>>>=20
>>> dtcheck warnings: (new ones prefixed by >>)
>>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: =
Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: =
node has a unit name, but no reg or ranges property
>>>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: =
Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: =
missing or empty reg/ranges property
>>>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6: =
Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: =
unnecessary #address-cells/#size-cells without "ranges" or child "reg" =
property
>>>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6
>>>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: =
/soc/bus@ff600000/bus@42000/clock-controller@0: failed to match any =
schema with compatible: ['amlogic,g12a-audio-clkc']
>>>   arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: =
/soc/bus@ff600000/bus@42000/audio-controller@744: failed to match any =
schema with compatible: ['amlogic,g12a-tohdmitx']
>>>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: =
sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any =
of the regexes: 'pinctrl-[0-9]+'
>>>    from schema $id: =
http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yam=
l#
>>> --
>>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: =
Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: =
node has a unit name, but no reg or ranges property
>>>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: =
Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: =
missing or empty reg/ranges property
>>>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6: =
Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: =
unnecessary #address-cells/#size-cells without "ranges" or child "reg" =
property
>>>     also defined at =
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6
>>>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: =
/soc/bus@ff600000/bus@42000/clock-controller@0: failed to match any =
schema with compatible: ['amlogic,g12a-audio-clkc']
>>>   arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: =
/soc/bus@ff600000/bus@42000/audio-controller@744: failed to match any =
schema with compatible: ['amlogic,g12a-tohdmitx']
>>>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: =
sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any =
of the regexes: 'pinctrl-[0-9]+'
>>>    from schema $id: =
http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yam=
l#
>> Nothing to fix. The patch just depends on Neil=E2=80=99s binding =
fixes here:
>> =
https://patchwork.kernel.org/project/linux-amlogic/cover/20240606-topic-am=
logic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org/
>=20
> Can you resent but keeping the assigned-clocks in the sound card node =
?
>=20
> BTW keep the reviewed-by.

Will do, thanks.

Christian=

