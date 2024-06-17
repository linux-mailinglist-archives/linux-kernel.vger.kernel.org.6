Return-Path: <linux-kernel+bounces-218201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2CD90BABA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BFA282934
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D91990C0;
	Mon, 17 Jun 2024 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1PtQ0k/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFD364BE;
	Mon, 17 Jun 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652003; cv=none; b=sEFQ7zm2EgidaQI6yBzls+XETLqybJevVlFpdWiAU7eM3IWF26KzYZEEXXr2mZmEg2wUq0HIyqOCVJdxrSwuK9UFVN5hpV5jwGkn/KdLWdQfwc6BqVn64nPjp+wyO1+NYJD3tAb9N0cc25ruwQIIBB75F32v0fLY3cWkdqcaHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652003; c=relaxed/simple;
	bh=kVGgfkd/8/BTrzjxqzEjPdes+GU/qKguUFWK0wn59tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP8oESgQs/WhZCl0KB5MfXdfQeGGU8MXk9wV2Agcm+6y4nXkYSyXTZeUB9W7/JjQjOhHP6oCZkCnI/yqUEuNaLESCW6fAXoYnYuST5AIeCjaOpcraznVMq28+yF550iPj8stCs+OjO+YIE0PSROZIdm1yT+u/RDLOcRpX2J0Uso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1PtQ0k/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718652002; x=1750188002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kVGgfkd/8/BTrzjxqzEjPdes+GU/qKguUFWK0wn59tM=;
  b=F1PtQ0k/zK0pvP3fr6KwXGQEoSUI7hkfzLEBt12+gwZmXT2tHN0t8QdD
   zNeJmDtAk86sZHoBlLtBrc59YkqU60ztJr4RapMjGNLfVz/IabOB8lWTS
   BRROIMp3ff+Gds2e25QaAugImWE9TNyJSRtbPplzombT9tpon2zPWfD2s
   wP2V+K74WZY2xgJBWrWTJj86TwAkc4jAF0QjRJXMmZa5ohcbWyHtoKtdy
   nocaPq1l03vXxp4Zm9ag0vH02GJ5Hs0PGuXPAOPeIipkPO+Q7XX7ZBc54
   0VEYZ8/Wh+bcHNmxkFALyoUKVtwqhxFyaVDgpLkFYOpVHV92iAajWLl3l
   g==;
X-CSE-ConnectionGUID: fi6RaKHrSlCIqigWy4OVqA==
X-CSE-MsgGUID: WRNnZ8f9TYuDgEq3zEiCQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15622402"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15622402"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 12:20:02 -0700
X-CSE-ConnectionGUID: mWzsj3dvSqSWWEM0IiYuvw==
X-CSE-MsgGUID: KrBWaktrSPiIi9BUQ+y2xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="78755907"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 17 Jun 2024 12:19:57 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJHtT-0004oP-1n;
	Mon, 17 Jun 2024 19:19:55 +0000
Date: Tue, 18 Jun 2024 03:18:59 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 6/7] ARM: dts: aspeed: Harma: remove multi-host
 property
Message-ID: <202406180305.hrffmKGn-lkp@intel.com>
References: <20240613152425.1582059-7-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240613152425.1582059-7-peteryin.openbmc@gmail.com>

Hi Peter,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc4 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Yin/ARM-dts-as=
peed-Harma-revise-hsc-chip/20240613-232915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-=
next
patch link:    https://lore.kernel.org/r/20240613152425.1582059-7-peteryin.=
openbmc%40gmail.com
patch subject: [PATCH v1 6/7] ARM: dts: aspeed: Harma: remove multi-host pr=
operty
config: arm-randconfig-051-20240614 (https://download.01.org/0day-ci/archiv=
e/20240618/202406180305.hrffmKGn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20240618/202406180305.hrffmKGn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406180305.hrffmKGn-lkp@i=
ntel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: bus@1e600000: co=
mpatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
   	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.=
yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac@1e660000:=
 $nodename:0: 'ftgmac@1e660000' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.ya=
ml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac@1e680000:=
 $nodename:0: 'ftgmac@1e680000' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.ya=
ml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac@1e670000:=
 $nodename:0: 'ftgmac@1e670000' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.ya=
ml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac@1e690000:=
 $nodename:0: 'ftgmac@1e690000' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.ya=
ml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac@1e690000:=
 Unevaluated properties are not allowed ('#address-cells', '#size-cells' we=
re unexpected)
   	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.ya=
ml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: syscon@1e6e2000:=
 'smp-memram@180' does not match any of the regexes: '^interrupt-controller=
@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^silico=
n-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.y=
aml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: pinctrl: i3c2_de=
fault:function:0: 'I3C2' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', '=
ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', =
'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2'=
, 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GP=
IT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3=
', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12', '=
I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', =
'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'L=
HSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', '=
MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCT=
S1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1'=
, 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'N=
RI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE=
', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15', 'P=
WM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1', 'RG=
MII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD=
2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SALT1=
4', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7=
', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIO=
ONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIO=
SCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2',=
 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH1=
5', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9',=
 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART1=
0', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', 'USBA=
D', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB2BH', 'VB', 'VGAHS', 'VGAV=
S', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
   	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-p=
inctrl.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: pinctrl: i3c2_de=
fault:groups:0: 'I3C2' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'AD=
C12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'A=
DC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMCG1', 'EMMCG4', 'EMMCG8', 'ESPI', 'ESPI=
ALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', '=
GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPI=
U1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'HVI3C3', 'HVI3C=
4', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', =
'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3=
C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'L=
PCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', =
'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'ND=
CD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1=
', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRT=
S2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10G0', 'PWM1=
0G1', 'PWM11G0', 'PWM11G1', 'PWM12G0', 'PWM12G1', 'PWM13G0', 'PWM13G1', 'PW=
M14G0', 'PWM14G1', 'PWM15G0', 'PWM15G1', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'P=
WM6', 'PWM7', 'PWM8G0', 'PWM8G1', 'PWM9G0', 'PWM9G1', 'QSPI1', 'QSPI2', 'RG=
MII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'R=
XD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10G0', 'SALT10G1', 'SALT11G0', =
'SALT11G1', 'SALT12G0', 'SALT12G1', 'SALT13G0', 'SALT13G1', 'SALT14G0', 'SA=
LT14G1', 'SALT15G0', 'SALT15G1', 'SALT16G0', 'SALT16G1', 'SALT2', 'SALT3', =
'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9G0', 'SALT9G1', 'SD1', '=
SD2', 'SD3', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SI=
OPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR=
', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TA=
CH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3', =
'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'TH=
RU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12G=
0', 'UART12G1', 'UART13G0', 'UART13G1', 'UART6', 'UART7', 'UART8', 'UART9',=
 'USBA', 'USBB', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', '=
WDTRST4']
   	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-p=
inctrl.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: pinctrl: usb11bh=
id_default:function:0: 'USB11BHID' is not one of ['ADC0', 'ADC1', 'ADC10', =
'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5'=
, 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI=
1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'G=
PIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU=
2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', =
'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5'=
, 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', =
'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MA=
CLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MD=
IO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4=
', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', =
'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK=
', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', '=
PWM15', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RG=
MII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'R=
XD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT1=
3', 'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT=
6', 'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SG=
PS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SI=
OS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', =
'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH1=
4', 'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8'=
, 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD=
4', 'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UAR=
T9', 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB2BH', 'VB', 'VGA=
HS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
   	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-p=
inctrl.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: pinctrl: usb2ad_=
default:function:0: 'USB2AD' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11=
', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC=
6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'F=
SI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2',=
 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'G=
PIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12=
', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C=
6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD'=
, 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1=
', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', =
'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'ND=
SR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1'=
, 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PE=
WAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15'=
, 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1',=
 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', =
'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'S=
ALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'S=
ALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', =
'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', =
'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2C=
S2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'T=
ACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TAC=
H9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'U=
ART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', '=
USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB2BH', 'VB', 'VGAHS', '=
VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

