Return-Path: <linux-kernel+bounces-175646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F68C230A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118B71C21AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605AD17279C;
	Fri, 10 May 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IsPcL8Ep"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2038.outbound.protection.outlook.com [40.92.21.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639B317166E;
	Fri, 10 May 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339959; cv=fail; b=MdjgWP/pJ35Yi63L3LA/fNVAiH25Yqkhqz0rEYA83umRgNdzI7FJFJakVDeln0+ut5wt8ADDpqnMw7rNNTFkHmq+ro+HcuhOl7qRg6heKr5GHOREA0LgCtR8fz29NVz648U/+MxhPDAoxfpXbeQMACmDIDOEILt9xj2b36IUmqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339959; c=relaxed/simple;
	bh=kmJSQsSBkdCBdmaA7SdwIoYUdwlDcSu60ylU7SQrlQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TrDC7PKwRskQ4asZv5NHU+RglkM0OR9BHnOpU6i3x/Qt3+T29Qhlx0Sf6kIMzPs2pTU1fEZ1pCfwudi5O8+cG3swPIQI6z1J9ggGnAZwjqWNQc4662X7oiJRovq+rTLohBYGqOd6Fv2KNchlvNf05zHa586LWIy5SQM7tumyOi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IsPcL8Ep; arc=fail smtp.client-ip=40.92.21.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWjsxFbHyApjgLIJQSfs+qkuPr83zZ902m4+BHvtbE51K12kKS6x8KmUcVEBJf1ZEzmr01ekDc24zEsO4nNlg8I6+m848nBbR1yUNmPHxK9M8FMa9yc/Q1Ut7cOBetKUjcH1B+VZWnPFelc2BdKMsDqfuk8Cv3hSmZawMwTC4Rro0zkB0TuWlpWcUxoOFxN/6Ur1iogp2j2QESIw9G+SyKLCv+pq6b01r5koi+eNOQxVUhqKxFKoEGVGi9EQCDFIN2VSAYWEyG7uNwWENcJQt7M089sIT3aV5FB+jPwLxXAv6JMnRtmkoie80bvW9Hgv+A24GSTxY7lOjenH18Q1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfWGaUcSRRWSWw05uLPcxxQ+yQsyAQNti7HMc/5AqQw=;
 b=lqIcBtEEw43kM9ZoDhgkyh9SBxYQ13vMmxtytdN8D8HZYO+TgHaW0HdQNjYMfAXV1CgRXSyn2ikpRFrEuy2J2IKkp+M5ThLzyEKAYTFQmosT59amPNVsIcU9RLtd+jd96KuDrBhkVqns1YFtJADZB6QiBGRsMBUGTK1fNH/d7y5CCv7bg7jiodmyTpbSuLW9FTwYajSR1k/WxFSswXc06/cMS68StHUtgwet9lLyzLaHh8cxaiAOI3QpXuGWnYVMpK0xi8jnuaP4xgQsVsE9/IwPFtp3dQmLyw34TDsG4joP0MkD1OBngmXI9Cb1dmd+7dlBKYD1FDdov5H046yTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfWGaUcSRRWSWw05uLPcxxQ+yQsyAQNti7HMc/5AqQw=;
 b=IsPcL8EpxynLuA+pHjcGECRZiMAZ7Y1MWJhw5eP7nkdR9WtJ9QoVhPEzgryTJxhTmF9uscnmfC938XS7CZAXaO5aIhhJhQ+dpVZXf6YUPSd5K6R2i9uxOsaVOG36la6iaeHA5rslH+qAksqQKdyImlfRCA3S5a1OOAZTyUE2HwMvBzbA5spvNvIojhZjkqLZzLcb9zfwf53yFuztNYmr0cHm4pfFr1i4a7Uz/UTrMXLFGIZUQaf7mh3/prfaZP1RdNnSdgj7usGBNnq+08o6I07ogElTPdyZvxxAxQU8k+BQtTUqcY0o+ehGElhUFF/bO/2Hj+r6tZ4dkoVojK+8zA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5381.namprd20.prod.outlook.com (2603:10b6:806:29f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Fri, 10 May
 2024 11:19:14 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 11:19:14 +0000
Date: Fri, 10 May 2024 19:19:49 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, 
	Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID:
 <IA1PR20MB49539EF552099FD466E38D6ABBE72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953612130BFC78A8E92F6C5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <595f76bf-5e89-4027-87e5-ff316c699669@kernel.org>
 <IA1PR20MB4953FC99B680A3040D4CB611BB1C2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240507190829.GA880949-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507190829.GA880949-robh@kernel.org>
X-TMN: [nZ7tJRFVOE5xmGk5ICvokVfvQWqfyzBa6MRo8dsYjzM=]
X-ClientProxiedBy: PS2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:300:5c::33) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <q6qvjikuuks6xetgugq5nev3igqe7lkghasqkkubu6ljvhxjpc@x2d2l6u7uzuu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e204bf3-1010-49c0-254c-08dc70e30641
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	397BYGW3MPki85gX6w09oUqR2bdOB0IQ8pm0EQQh7NPZK7RXMWPnsgIfmH3NeBlgJm+CmwJQ+9yOWBaGp7TwKDzRdGAtoH8JXrNl4Fma1n+/igTnbu3EZ9jkq45w1fnQlkaI7/3NqA3nBKtqGYZ/0IxkBiaY9rSE9vZr4H9XGnDh52hLi65iYxzpGIYrb74cbxK/6zpDjo/xfJY4xa03hW37AZeDxU/nI1XyfEINFVlsxnAaiUUtevuF0e5W1JZuT2HF2syTG9iNh1H7e4+V9FRF88FQK7AmixpIyVhGrVt7sBYTu9ir9E7/AfP+BpxbbVMu0lKiGRQuS4v11VftYxTIrEV7YY2t5eDL+MCyX4LwSSpxce5zFFVwh8CeseB8D8Orn2PMTEqcnPnfq2uwt4LcsFsp4i4m0L1A22xuLtSMqrXJgBbaeFS+j42FiQvkNvfehC9M54sbSiICLrpwZqZzey3oW0JjHSs5sLQk/x8YZuwGkQS87NyyKdM2gkf1RHGdmZe7LATP3ZLxp02yCXQypif/tx3I+BMQ1K8UVYsgdyjFPbCvVRAY/0VCdltwcJKT+Ah+lYg0f2lF6mvRLwN35apGdPOi3WZBwE/hM8UBF8o2HjHbzbOmKdPF1whp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J5227mN+ycQYzNfIQJb6hp796eazxfKO7zIu8ciFStekeHEvSlBv33FSYtvk?=
 =?us-ascii?Q?linHogCXt0qi9dN9xHwaW7B5YPcmzYIUL1e5o+CXf1v6FNwFAKA7tWfzwnLJ?=
 =?us-ascii?Q?hdn7WU7dzzXNEHgrPbNKP/P5NmmMu6V9zHoVz6iWKJaGVYAc5WkWvn1+WuDk?=
 =?us-ascii?Q?QWjAJNzDuMJUVXuhFz8bPrahgB9UOZVDB9aeI9kbcc8zSGco3AIcdpmGlwFz?=
 =?us-ascii?Q?NYuhlvk8MQYI/i0k8b63wqyz/SIrriyOtcyuftaqiBleGTH58L5JuDc5juAg?=
 =?us-ascii?Q?c4D7JpN2iJaGGQeQIHTyuVGIuzL2oNaCgq/xIXz041rU7D219wp8cLXUL5Zm?=
 =?us-ascii?Q?9qYitr1MxgD+fUqI2QISXlMc9a4zzneEA27zvuj8g90gYSdoXez/+u5EuI+x?=
 =?us-ascii?Q?A8chD6/RGWgo9xVwDzLG5OyEMnk/rht1X17fZdQprL5jDvESFFjdL7BBgzEE?=
 =?us-ascii?Q?xE3w3XLYCBFD1HEXRg2wcFk6ORA4eyGrhfl/L5r3KOm5QfnP6H8HrVVmktTr?=
 =?us-ascii?Q?hT1D/09ml34YL/Tx6cvGYCYALU6Nis1HLGKe6QIMbn5DYs3l0c+KSwf9IeJl?=
 =?us-ascii?Q?7mHyECbBQzVkdTV+OM9Bm5NNYTUIzT+9s0vPaS6v2K9VmvPZK52tALoVbZmM?=
 =?us-ascii?Q?5mwcl8gc+/LNE7rhM1ASI2JpPS/m5yUiHwHnptyQ4wPz8P77OLoMfyzvUucA?=
 =?us-ascii?Q?K0xemqij2qzWyWqEaVmIrRbhqbf2836HPgaRT7Au+h87es2njNSuCfgizDxM?=
 =?us-ascii?Q?RDpNzRGZoO9cYCeNiM3z39tezi+WaaVxhUsnA2bl6Ud9eaiFuzUHrnkG+hbb?=
 =?us-ascii?Q?MdfWJpvabY3K0PPfIpDSlPN8fkG0ELv99yg3oDryyaEWHD7yCzY26vMWR8Am?=
 =?us-ascii?Q?Jq1xuz6b/D/F1Ptob46X5N/P7yZT/+KuuHZcNOG+OjfSErbStJBn7DuhVO9t?=
 =?us-ascii?Q?fcYZeNVKbiCjK+tc36ElhLwwkDGyv0sjHWuu71xoDB2NCJ5IFBLxxid32ndp?=
 =?us-ascii?Q?BZxfn1lF6cyHvyLWZrx8dlVjBQTAETmBFDyCr+aTYgrHpQEZmQInu/ZGyszK?=
 =?us-ascii?Q?a77JJQ0mBab82TMr5MhFbjVCtLeh7rsBwFG8n46bw5fBfw3HuTUzfRVhtxv0?=
 =?us-ascii?Q?Juhgadr+xDgeAd0pbHBFS0ZmiTQ+0MYQDuRQ51H2tRUvk798gaNS59pyySzi?=
 =?us-ascii?Q?qFa5WV0ABkiayeEdAqAeHJj4ITRkIg6Z7ONXBNfWAdI2zw3p3Er7t7PLIXor?=
 =?us-ascii?Q?eYJcN/4KCiv/oQj16iJM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e204bf3-1010-49c0-254c-08dc70e30641
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 11:19:14.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5381

On Tue, May 07, 2024 at 02:08:29PM GMT, Rob Herring wrote:
> On Mon, May 06, 2024 at 08:17:30PM +0800, Inochi Amaoto wrote:
> > On Mon, May 06, 2024 at 08:51:59AM GMT, Krzysztof Kozlowski wrote:
> > > On 05/05/2024 03:52, Inochi Amaoto wrote:
> > > > The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> > > > "VBUS_DET" to get the right operation mode. If this pin is not
> > > > connected, it only supports setting the mode manually.
> > > > 
> > > > Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
> > > 
> > > ...
> > > 
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: phy
> > > > +      - const: app
> > > > +      - const: stb
> > > > +      - const: lpm
> > > > +
> > > > +  vbus_det-gpios:
> > > 
> > > No underscores.
> > > 
> > 
> > Thanks.
> > 
> > > > +    description: GPIO to the USB OTG VBUS detect pin. This should not be
> > > > +      defined if vbus_det pin and switch pin are connected, which may
> > > > +      break the VBUS detection.
> > > 
> > > Why is this property of the PHY? VBUS pin goes to the connector, doesn't
> > > it? It looks like you combined two or three (!!!) bindings into one.
> > > 
> > 
> > Yes, but I am not sure which is the best to write this bindings.
> > The topology of USB likes this:
> > 
> > controller -- phy -- switch --> (host) port/hub
> >                             --> (device) port
> > 
> > The vbus-detect connect to the device port, but it will change the mode for
> > both phy and switch. And the switch is just a switching circuit.
> > I am pretty confused on how to split this binding. I think it may like the 
> > following:
> > 
> > phy {
> > 	switch {
> > 		/* This is the switch in the follows */
> > 		connector1 {
> > 			/* host port */
> > 		};
> > 		connector2 {
> > 			/* device port*/
> > 			/* the vbus pin is here */
> > 		};
> > 	};
> > };
> > 
> > Could you share some suggestion on this?
> 
> Something like the above assuming 2 physical connectors, but probably 
> should be a child of the USB controller or on its own. PHYs usually 
> aren't put into a parent/child hierarchy, but are out of band.
> 

Yes, your are right. I should add port definition under the controller.

> Is this switch implemented on the board level? If so, you should create 
> something that would work on any platform with a GPIO controlled USB 
> switch like this. 
> 
> Rob

Yes, the switch is FSUSB30UMX. If I understand you correctly, I need to
add a driver to control this switch, right?


Regards,
Inochi

