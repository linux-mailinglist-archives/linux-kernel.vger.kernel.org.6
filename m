Return-Path: <linux-kernel+bounces-244943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F75C92AC03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB9D1C220BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CF315098A;
	Mon,  8 Jul 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iMBLaqfs"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2012.outbound.protection.outlook.com [40.92.19.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE476C76;
	Mon,  8 Jul 2024 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477480; cv=fail; b=tcJ2fO9W2fLO4NO/sLF7UESceSv3y5n87z9MkxiUhzX6m9Dhkn18eDobWPBoNBVGJQrjFMMOy0LEfxKNIY3/KKUPTsz21kPeIpaBVF38Zb4SIfVEUAZ7/WYb3o99cXB1o2qnjS53sfKFzUE1GqwkYrPyLeZXWfQq/H/9TNB3SeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477480; c=relaxed/simple;
	bh=ae76434uJbzVP5iifW0FhRnOlnH97ybAG06jOTtMDxU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SdmTLzsF3AvciLxV+kYh+diECRZc1Tx6AXspWg/RbYi2VDjLh68saMIgY8ndQTZuGUcLQWHyjuHsIQQCvBc/lmpzaEuxH0MprlzqbWC5WOECJ2lq3gekP0AhMgoEHfORFwl2FDje3rYhjuqBsppwGyClvjRPYWeheTAz+UsxoCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iMBLaqfs; arc=fail smtp.client-ip=40.92.19.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFinciJghSpAUF5ya4tM3VtLsl7EBWWYn+vtrMCsr2PpyZ5B0sfj8CoGEftpoC4NNDCaUTb0aZi//gcBYagVJFBgY7lZU4mm7yBo0Cm0ZWRyCCBlVROz6czL5B1sELolfwcwvs2S+B/lFYZ1yIkNop+1e7ObDb2Wi3fxx5Z2pNwi3gzn1ZpDxyakj5W9rT9SzVlY0tozhI/EEV8P5fXEKTX+yXCm6XrbVSBB04Ns1dJ+MOic5xgmVRjDQ4A2Z+LkHwhhWX/3LXlHs3tIEiGkOySWt7qiFRNPx6/noqfvvfZB44a/KroEkkY2cH1VKxFbAdZQzu6h/8eW8ri8xgxUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/iE06B6ozTxoMdoZzpIotCyn1Fq/glHCaC7+0o8UZ0=;
 b=Wd1No5zslS5pdW8wewVuPOUMchPosShJ4RXlmhGvueHkixxuYlgYzH0NtWXHRS8Shu2u1N5iDgGmIjUZfxO9m2qOLKyrfQ1MqpYO63NzUIv5EBQpQ8maH8Bbh6a00/7Ms7HYKDGzpjJgtj2ehSfgXQ3edDmMfMztdugzx9LmBTd8CZFAg4wqnrIw1Th3zZ2kM4cm+agoq9a+YkTHwuVoT/lbp8q574SYpxf/VKzHBAlwstB6C1cr9KwiWCOrF3cLmuTNUYac1lnMpZkFcajlIu4rZ9gIsNooniri6E5iZUAcXQ81d8XBW+39nZyLpBylHusH26KMU4AJa+4ukeYpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/iE06B6ozTxoMdoZzpIotCyn1Fq/glHCaC7+0o8UZ0=;
 b=iMBLaqfsZLzP9SZudx7cPvdCBaecBsMNwZQhPKCuZ+ZWTFwFDUxSGfvIUSqNylv8JEgR3JxskCgihDS6z2QFVAMW/IFRPuBHNb1tkrGkPJfOrsYBkhbQMMPjvNG2ANN+tQymhShWM18e7FlKfPtTIg/jc4t7QYrsmFnFjG93dnvSCvDB3MiT/TLcg9yBSYLGelXGpGbcEu9Y+fjTQJJmvxlM5C5H4Be7FB+6pAYg0Ob67E4o4KfHgCXor3qcFnib0NhsXXA4i7V1vasuAqaQYqw+fQxcySznNraYaoCt6wNpqsQs7Tmbb/G4TUs4pXaQ/z4W4EBNWPMUIJSVCZuHnQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ1PR20MB4787.namprd20.prod.outlook.com (2603:10b6:a03:45a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 22:24:35 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 22:24:35 +0000
Date: Tue, 9 Jul 2024 06:23:58 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Yao Zi <ziyao@disroot.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: add YAML schema for cv1800-usb-phy
 driver bindings
Message-ID:
 <IA1PR20MB495304D471AE08F75D97C25FBBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240708120830.5785-1-ziyao@disroot.org>
 <20240708120830.5785-2-ziyao@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708120830.5785-2-ziyao@disroot.org>
X-TMN: [ATuWioSIl7GUUxY2bYXCYjh7Ae0HBja9+VhAOxpWdkM=]
X-ClientProxiedBy: PS2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:300:41::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <sx54i2cgq35efwwgxzykyuyvtwpqli6zezp6octdvhqz5njwup@kiooj3x63vck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ1PR20MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7f64fc-d3ed-42be-0081-08dc9f9cbf72
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|1602099012|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	tqwxrgSgutrqfmZ1gJtOGInZN5+eWOMHOeG+KyJSZUPsBMQpKiZhrX7aKlUNmd0oCEW6aW0TyV9W4iwA6ddDUEy7a91pT/T9AxZ1aUpSXJawRgw760Jq853lUa2V3UN7JxecdfBW/fdWiTj1evWq+1tp82Li13si2gdssbA/AtyMXKQCUCOw1L5K9cmlB4yLEo4MOrswFbxf4wApzbobaM0NeY4x5gHDlz9YERlCaGqaIMrvXWZresWE0jpMDEcgL1UFIUjCXT6v1cbQzp1vbt8OmqXyc5Ba2p42KXKhqwdnKdi6Fe99h6Nd41N08Zzwl43PJQ4g1x/zThEDqi5c3Bg6F9VgHfbc7OXUsb3AjK+M29RNQ7hSfUtVEz/RfVpAZwSIOBro3rOntl9aGmI9pVw2ahK551yioZLgHGQhgtSh3+9cDJmQxnILoZRJ81eFeFO53ySNk3/AIdD5bW4aTUpz5e5qKD3uAdIENuTdzdWK6tIXv7vYlZ8Vv8qVBy6gWnPzAHdLxlYEfOrq7x0x7mx5Wlfrs7/4jRfnleCBD+syjygkxDE15hick+MoHNbGAVnGQtDHE+ZoH0nps8alOMMxDOFXMyXSBuOSopxRGbUn0euIR8yVEIJxooOmXjOWWNNYgnCgDdJIWgGor4EKZG41Pm/yQDKyD2TgXh1KPp3l/c+iDyNjV51I3vBkMdtii/5Dbdg29oodz+eT+bKTpT3/vJhZf3vaHg/ixxTPKkmhrCvclj/Fzl3ZslTHdun9a5anCdUsQu4rB2O/m81JzxKlbRAjUQbOuhfDr3o21Xc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9iKCZbQLq2m0fZAD27JrhXtgAHn4gOc5tenXLyuVXmgw7DO2IruV77vLhFR9?=
 =?us-ascii?Q?qfu+cabq8jlV4qKdw0cw2mJG/Wa0x3usRlOKde5+8b1MYC9ZSrpd8ELnsLxp?=
 =?us-ascii?Q?MoL81TFPhN9FCCV77ZOaBMdlpElMrE7W3AeZotwG5s61m0+26hQviW+++Rl6?=
 =?us-ascii?Q?VbMDLPpS7RB+AGk265GoHdoVhFaSVbJZvcKcK2JuHqLmLIIhIYcnT8mV6uCS?=
 =?us-ascii?Q?ZwYEC0nsVX77evBTrpHCgusVWQPS9I6E2Pkkr+Wyd7Dcm4JpEiaVsyYqYNYK?=
 =?us-ascii?Q?mRqazgq37qHyvstWjjUiL9Yg9yV6StRHUMHwJAD0YdZ8DRsrzhEHlgK+vnSD?=
 =?us-ascii?Q?GZlINrEgyJLCJaZRGSy91pPbwwzqG3oWFJDDG1ohiP9XCuzTQ/1fCxB8Bbr7?=
 =?us-ascii?Q?U82RTFTRJzD8xgMA1//jFa8QMiPOuSdC78CQKIb/MnevQAjuox5ypV8NuMnv?=
 =?us-ascii?Q?GBkOhF3a9+YrhQ791laUsMYATDaSIOjEZYSF45rKnvfCxk8Q3u/lEjMbh8Sg?=
 =?us-ascii?Q?tc/o42WgKf+6q9ESqn/VC98brLa3JH7a5xS7qyD/D5+p4zmcpsnclM7xw4py?=
 =?us-ascii?Q?DHiGchqtobI9DOl4Go7Lch2k3aXAqa9NK5iDfyhJcjlLbKlvZforukimRBin?=
 =?us-ascii?Q?BT0ap7+YZL7eyVq557d6s2dwAvxyiCaUtjuxZDfGk1QyW5asexxNzSWVjipp?=
 =?us-ascii?Q?HtayuIRthPi52zTEISK348VTqBCK2sXHepHcFO8EnA28qOaQk1gUW+OEfLW7?=
 =?us-ascii?Q?czC5UUxg1mzjM1PgSENz9GYpwB3nvfFjL8KWgogWaKlBwCtXErx/C2zKNuoF?=
 =?us-ascii?Q?7Lq6WNUM514HlTUEsRnk8q0hWAW3JGwxolnL3AA6CBCwLU46V04xi0wF3b35?=
 =?us-ascii?Q?EcvJlJO5vmJGYY1fjGCU+fl23PWOui6G64YzGbliKnkLOqVTHaEJ0NvznOyl?=
 =?us-ascii?Q?hSqLryCsY8tEXQI1LHob5RW40D6Hti6m0+F6+1bPzqGxYO2QSX1aQ3kNPrJF?=
 =?us-ascii?Q?Wg6hk8+oo1EjuKcZ4C/jLvE2n0nv+uPH6BmNr4E++8i52HqcghQWBhRE+Gki?=
 =?us-ascii?Q?lZENp2UKUrsD+p9ks624I2ornwd6GX6GbYp7xlSVzav662J4A+vbIw72CydE?=
 =?us-ascii?Q?weZH4IPIhXdnFV/T7vdu8igX3zjfbxnOd7yCycScvICaLYtbE+KsKTAQCfHh?=
 =?us-ascii?Q?3e/SwNX3eGjhVv//RbghZ9+kSspaUqHnCcs6scWqcjLosMV67Q67V7UHbimq?=
 =?us-ascii?Q?CmUQ/y7GysFVKgNkeXu4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7f64fc-d3ed-42be-0081-08dc9f9cbf72
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 22:24:35.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR20MB4787

On Mon, Jul 08, 2024 at 12:08:28PM GMT, Yao Zi wrote:
> cv1800-usb-phy driver supports USB 2.0 phys integrated in Sophgo
> Cv1800/SG200x SoCs. Add YAML schema for its binding.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> new file mode 100644
> index 000000000000..0403d899e23b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/sophgo,cv1800-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV1800 USB PHY
> +
> +maintainers:
> +  - Yao Zi <ziyao@disroot.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sophgo,cv1800-usb-phy
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: phy
> +      - const: pin

drop pin, cv1800 series does not support this.

> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: 125m
> +      - const: 33k
> +      - const: 12m
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  dr_role:
> +    enum:
> +      - host
> +      - device

cv181x series have otg support. For board with OTG,
it should be properly handled.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sophgo,cv1800.h>
> +    usb_phy: usb-phy@3006000 {
> +        compatible = "sophgo,cv1800-usb-phy";
> +        reg = <0x300600 0x60>, <0x3000048 0x4>;
> +        reg-names = "phy", "pin";
> +        clocks = <&clk CLK_APB_USB>,
> +                 <&clk CLK_USB_125M>,
> +                 <&clk CLK_USB_33K>,
> +                 <&clk CLK_USB_12M>;
> +        clock-names = "apb", "125m", "33k", "12m";
> +        #phy-cells = <0>;
> +    };
> -- 
> 2.45.2
> 

You patch is duplicated, I have sumbitted patches 
month ago and still needs some time to figure out 
the best topology. Phy driver belongs to syscon,
which make things kind of complex.

https://lore.kernel.org/all/IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com/#t

Regards,
Inochi

