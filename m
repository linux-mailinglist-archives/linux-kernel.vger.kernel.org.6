Return-Path: <linux-kernel+bounces-169786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DBD8BCD9F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D525B1C22C41
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187F3143C5A;
	Mon,  6 May 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iJT/bv3h"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2093.outbound.protection.outlook.com [40.92.19.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FA14262C;
	Mon,  6 May 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997823; cv=fail; b=o/26dWcjTuod9Z/QvI/XRFQ8fd4kSmxmCleMHeDBcNyk3qq83bF6n03XoYheYxrZk88LRtgZ8HRGKyuakeQkXOtY66s/m6wk+jB5J/zETWhYkyvnxQkdL+dPjvO1Gvj3TkxvF+nNfyE0OYu5iL+WnmxMTgpzzioyY9Ld11fSWRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997823; c=relaxed/simple;
	bh=Fklr0JklGU/pWAie21wiSaqolArnjV63su2LDgS1X3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jop96HbeLfWaXyKKQWnF7Zc57iXpEzUt+JVJnXRbevnhaKd5SNpD77GjyjoFaeuX2gkuIK8g8d77Fd7LFWG6tLakc4OxRn4MaMj8hYlhKr8b15NB4PG0+7gzBRKXudXOOyqN6A0MdzCPG/cFm/+p6o0c81ViP8iu9Xh3ZwNOrDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iJT/bv3h; arc=fail smtp.client-ip=40.92.19.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+wMyE6IzTfU/uy0nCisbCmIkKbF4V1zVspPcAvnzT87XI8dLag4GWTboSowhzodQjdrPjeQmwYmaW0FpDVsEviumk0K8MFgOMY2Vaq0ufHb4ww8JDGK1QVEdHu54bJ2+9upWCSbiNDmbZe30XS1u7W8jnAEpcIgX2LYkQcEIuJv2Zz2lxUQJP5v+9AuisOVMQd2twgWAr3yaeNS3VcV8O7DpsmxjAsh6ml3yFPB45XSfvuhTdirKqf2PaVTVqoQEaAnvF4QJExMctOaKXat0+h1IM4bjxG91phhFzbkas7ItIYBDQR/nMTkFVqB677BRl7GAtk83QI3Ffr3qzKwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5Vw7qDRO3DwIkhmABNHwWKRQWu1slVAGXoHqCpXiDQ=;
 b=jvFz3z4ee62AKiS0JohEoNcAwHS+cZ752zn9+Xr/MBkO7mnuPzJU4ViXPVVV+1gJkl4+J88sNLN+i/DFvtVd0aM3HC0ZeyKCKELaNv4QQM5OxKiJ2PuFXo3cpERJnyccSmkxy9t5xCdiBdeN8F6lKVjZba3SJUM8XHAlhywEHw6R4Vpmzz68VlQoqisR04EbnjyWl0nhaZs+Vpu5kfhk0qeVg+epjuGV1HS76zd3ztWziKFrXmvvrCxKHZzqupzdPae+cgRcddL424khdnYG0ypF9TQv/+yfbJJ2DE2llADABIWy7qSy/LuSVlGWWHZjIiuzn0ilAO/4LN01AxegHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5Vw7qDRO3DwIkhmABNHwWKRQWu1slVAGXoHqCpXiDQ=;
 b=iJT/bv3h4WrDjzqbre8udTdF0cxFdx9W7f4FgJoo9pCOZpeuTc1yh7J1qyZlHuzHoP/Vak0YHfdZVCuRkSYzZsrDkdADI515cub9RqBo40/MQtZs3ZNM0TQ9ZBQK2Z0O6WRcq2i5Zck7yeRVIj1vZXBNVtoSPr+DF8gN3mjYwMSqiqXaHvWmoSPFifQP5kseHGsjIURhMQsYI91gswXeE+yUNQ316MCjcgz9AkMrta6T6SmeRjK0sPAHdGxfh/e7KFofWU72O5eWKM+yd+g/8V2eUAwqZ+MdHIzJ2t/5r5WmOvRcDhqw7HKBp6c+WnV9qCgmF0ArwSoufHXqDe0jzQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7351.namprd20.prod.outlook.com (2603:10b6:610:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 12:16:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 12:16:59 +0000
Date: Mon, 6 May 2024 20:17:30 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID:
 <IA1PR20MB4953FC99B680A3040D4CB611BB1C2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953612130BFC78A8E92F6C5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <595f76bf-5e89-4027-87e5-ff316c699669@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595f76bf-5e89-4027-87e5-ff316c699669@kernel.org>
X-TMN: [pjn4YZIL4c90QZdlmFTr+H4VGHmnxlMjVVmTw37iEkE=]
X-ClientProxiedBy: TYCP286CA0083.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::11) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <4bge7lyhkdhp72udsgjw5gefkzwrlovukqgzl4qdjsxohadh4k@nrc53w2z2f7r>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4c7545-3481-4a54-d9ac-08dc6dc66dd6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	7JOnrRGG/0fQtRlRiGpQJhk1kn6Ln7tcsA4oVm6tNfexodxezdVmt370TVydLS7ScabVC0Tf/xLJM5dlJ2KivnrzwdF3fTZLRBGCWK075ZDOndg5ROXnMJ/WFeWUoeHEVSnii0cSLh61tBK3hCWGSzHbejzbnb1GFSXBrkHCjaDSLfVVC8ihhGpkcsP4oNOe93d3M9yhGBzSzGxZEq9HAc5bTrCqZJB6AKYNlbrdkzq+rcb4VRb99q6cXuBYLYYewbfaEeswcbARjYp1p+Kh/f1YWaRMlV/eq6CTMH3dA/udOzAb5NzfVi/Kr0125FBmYunw14Rki0N8ePaG6plgsfb1convxCGhg103vNaRll+Nm6B7MdIjcbW2UvLz1dSr/LXwyMZ2BiMdrRsuAYaXFzBvvUbWg7lMMqhfGmTJ2tklhskezZCZlSxzyNfIiuy6M2WkoiX1EGxwflGTKBfx/683vjX0YFJPkWR2iueGPgkFyDcQOppDNdBXIF2lb6qmBdC9/YI8mRtkfgKvvCh+dCHwyJx/dg2WAqoasV2RJXhGjvbsTJiOiffk/MQ1GYbp7uES0+l7UV9AsynFv7BmG6tCGqXF3f/qJ9IggZCE6jR2OECOyYFGIkyAByXGg0OM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FP5ll0T7JaPH+K2tNK45wKDLtPkbcil4uHS1pQrXzGHluvEynvK7O5/zWfhA?=
 =?us-ascii?Q?MnkjiV3NgUMvhLLhmAMSjbBHd3IjsZJ1x5HV6veVQb5cSbyXtEteFStMLzzG?=
 =?us-ascii?Q?2dWfDsVJXALPIv8U3F4s8fOouGBjHxNy9NG2dWhq3wQJEhAZy90ehJssMoM/?=
 =?us-ascii?Q?pC18Vu4vcgJTNIIiQ7ySt/9mcY8XTwHOmeYklRP3NOI7ULKeSmCN691SYgBE?=
 =?us-ascii?Q?x3/g5D7mGdLPF5seBYaaj+UhoEWcYKZeIujjdxJzFKq3RxOWUFMdTZ5FGIYc?=
 =?us-ascii?Q?j7HJDQXi0VacAiDvaP/91wn2KzxiBGylfLFHkyG1Aiw19xAXp/hiLgWvYiND?=
 =?us-ascii?Q?YEEt7+rdbu1O0rgqxBICRloD6f+Va2FSj+iU2DvROTag64CU2q0CDaYoygzO?=
 =?us-ascii?Q?a3+hpBaZzp/6mglLeQ9tw64zaK2IjYAk8MIifA3S3c3co09rJ5JgyWTTuZAx?=
 =?us-ascii?Q?F2qCx9k47Q7FsitRJCEI65EC5WYz7aaIOtNp8jLirNYj2DWMMdwnkXr9FWDA?=
 =?us-ascii?Q?Ez/z5/kZU4VlKv/4GQvUXx9bi23yv1KRDIwWI9gKHge6Ix5Vk62coKfVfc+P?=
 =?us-ascii?Q?YPOYMF4U/MKgXksq3Ipa3HK2cKONNaQqEfkXbiUxpRsd3tBw40nHzcHZRHGd?=
 =?us-ascii?Q?wbdVuEbxJJWmC4ig7M2sdZaIS+1R1LrKhm5x4+h3LEJZ4StO0RkBCpF2rAW8?=
 =?us-ascii?Q?2W0EZBTxneTus6DeCd7jAFUW3hD48H1c3DeI7pwy1kq5eXU4Xqcs1DXkfrtV?=
 =?us-ascii?Q?fdBVqLHI53EGgD/ND9N4id4Ct2uoli/sVIsPsyp0jwYe6q1ZN32ZjNPAw0vY?=
 =?us-ascii?Q?YRpVcVb7ftnyypy8nEtmHBwj60R9zaLz66qMTDZXGIKUMaOcFZGyHXqBB7Py?=
 =?us-ascii?Q?eO+7EXtkfg39Ks6mPJaxF4jmqwj9uupCtVfb6HJ6An3C2FBDb1wGxoR6ewPd?=
 =?us-ascii?Q?M20OqWqFzT83s6eOjy6UUGiDHTEtVYsmMWYCo9purlW6VBhUU+L0TsisoEPO?=
 =?us-ascii?Q?2OZmTq900wwCyPuwp4hHr25YlG8fOYrRpl8WIPHsbnxU3odAwhAPJvbtf5Ff?=
 =?us-ascii?Q?bmDnkK8+jcPSRIa7utSj3gkxWoiI5M6WpGSHzjJbDBbtD9miwyYHL/zQvEqu?=
 =?us-ascii?Q?354Lm4fXxuwS5xdZ+EXSoGTX82OsMAbhGB8Gv2Q3hf0m7Zg1O83Vd6lvW86X?=
 =?us-ascii?Q?+DMeszLlWMlv2ONT5G5sNv3cXbdJP8fcSt0gZkT7UI7FBiYli48tn7l2i9f1?=
 =?us-ascii?Q?9I0TBWm2s17M9Prb6XE7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4c7545-3481-4a54-d9ac-08dc6dc66dd6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 12:16:59.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7351

On Mon, May 06, 2024 at 08:51:59AM GMT, Krzysztof Kozlowski wrote:
> On 05/05/2024 03:52, Inochi Amaoto wrote:
> > The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> > "VBUS_DET" to get the right operation mode. If this pin is not
> > connected, it only supports setting the mode manually.
> > 
> > Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
> 
> ...
> 
> > +
> > +  clock-names:
> > +    items:
> > +      - const: phy
> > +      - const: app
> > +      - const: stb
> > +      - const: lpm
> > +
> > +  vbus_det-gpios:
> 
> No underscores.
> 

Thanks.

> > +    description: GPIO to the USB OTG VBUS detect pin. This should not be
> > +      defined if vbus_det pin and switch pin are connected, which may
> > +      break the VBUS detection.
> 
> Why is this property of the PHY? VBUS pin goes to the connector, doesn't
> it? It looks like you combined two or three (!!!) bindings into one.
> 

Yes, but I am not sure which is the best to write this bindings.
The topology of USB likes this:

controller -- phy -- switch --> (host) port/hub
                            --> (device) port

The vbus-detect connect to the device port, but it will change the mode for
both phy and switch. And the switch is just a switching circuit.
I am pretty confused on how to split this binding. I think it may like the 
following:

phy {
	switch {
		/* This is the switch in the follows */
		connector1 {
			/* host port */
		};
		connector2 {
			/* device port*/
			/* the vbus pin is here */
		};
	};
};

Could you share some suggestion on this?

> > +    maxItems: 1
> > +
> > +  sophgo,switch-gpios:
> > +    description: GPIO array for the phy to control connected switch. For
> 
> Switch? This is a binding of the phy, not switch...
> 

You are right, I think this switch may be more like a pattern device.

> > +      host mode, the driver will set these GPIOs to low one by one. For
> 
> Yeah, you mention driver which further confirms this is a property for
> driver, not hardware.
> 
> Describe your hardware, not driver behavior.

OK, I will remove this.

> 
> 
> > +      device mode, the driver will set these GPIOs to high in reverse
> > +      order. For a reference design, see item description.
> > +    minItems: 1
> > +    items:
> > +      - description: USB switch operation mode
> > +      - description: USB switch host power control
> > +
> > +required:
> > +  - compatible
> > +  - "#phy-cells"
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    phy@48 {
> > +      compatible = "sophgo,cv1800-usb-phy";
> > +      reg = <0x48 0x4>;
> > +      #phy-cells = <0>;
> > +      clocks = <&clk 92>, <&clk 93>,
> > +               <&clk 94>, <&clk 95>;
> > +      clock-names = "phy", "app", "stb", "lpm";
> 
> Make the example complete.
> 
> 
> 
> Best regards,
> Krzysztof
> 

