Return-Path: <linux-kernel+bounces-207781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4724B901BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C31C21ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D912C87A;
	Mon, 10 Jun 2024 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QaGW9w0W"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2042.outbound.protection.outlook.com [40.92.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F926286;
	Mon, 10 Jun 2024 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005143; cv=fail; b=WQT7EOKMfE8X2Q2X2rQ3AgRq0as4wu2yYMJ4nRoGzaq0Urz+OLPlVVAyZEfI9Lgwfqk1ErxA11kjbQEK3pqx/gjqLwjJ0KgXraYZwb/w9UFj1kb0jhHCNBPjwNNHIBDu0B+PtlIeFxHMi44rFbuXLhSbcPX/2x4QMe8yfq32pfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005143; c=relaxed/simple;
	bh=VZw8fQQhT5HtuPFjlVCPz8BwJ+f2WCbMcKQHY+DGJjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KEbBo7sQpvaCaLNb+eZ0yJX4niNxIwDZv60Od5XsnrNj+jFy3aohOo5p9roa0PlGjBCSyC4OVm5fiNDBzNh10DRXhga0QpRj0cxmfmYk7aX2AHS3szPp5k+BaupUMRJhIqSRbcpUJH8EIRUTB26Nz5xi6fMh5IKV/yhs6hwL6zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QaGW9w0W; arc=fail smtp.client-ip=40.92.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EssEv6tBEyahPcfllSzYlim0I2ldB5VfG7CWNvTMAVDBdMjrEonoQ/iXZ8uvvSQ0PnwWNw/DNTSQWlNg5IQY+7eSWCH7s0CPzLVi20+w2tDG2Qn4Gkdj2/znTkG5T3TRtEL/aT8OQrY3J5FTSy8ZH0WwuOFQqHJnAljctVI/SpzkNZQKCYucSW6H295fDzxG+vOxQvdHi3NSVzFjdcoEUOOD8fvtpIppUixMmSeAZO3xux/WZDFo+v+Cg/ij4se0ymnwZnznC//xaP5QoMNuS5n2rszjc/J+CqDSz1/omn+O/V42tJipxGl3hsUnFomeuvBmYBCkV/0hZ52CQnnu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctbHFlyv/VHUn6Ql/pEFBlSLXZHLrYr5yElG5/qIGFs=;
 b=mgAIj8RGPzREC4/iTPk4eQhCZthSZWj05KGKfLkCF/S7Z+WuTRTGgwJvAZy2QrTG2h9LPS1b7/CMOPPd1ccU5KKd5HDiEu3g1CAB5kDcpUaIf4DbV28PhtnI43DIWKODdANEmQXEHKFZd4TRcz/4IIbVg5mV57kFzNZbAe8CyHuAGAhYnqmyt4ZgbxRrPcHs6Ac/uv+1IWJDpjrWSznTKnObq3ZK9pi8ox2C3S3bXgbFNgxU1fXFPtE9j+KBZ30Q99hakcHBPsFbFHzjvmE04R+JLYY/wM32p+9E9zfVBusCsQk2teS6R839jvcJrR9eqcFitmgsBkYT2LwSC0Bfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctbHFlyv/VHUn6Ql/pEFBlSLXZHLrYr5yElG5/qIGFs=;
 b=QaGW9w0W5to5c4oPcYFVwmtPDs2hc6mY4bnXKMMlTqKQ57mQTzMHi4dKs5XMc+zr6b2rkfXe/4CwwmUb3l+2ceyr7Y5yCqdqyNOhU7yUgJyes0gPzGFLnFxNTZuYRZLDQo/vSih4CfbU+P7lp4Nb9Fb89eN24b1Xfoy+5A+rv0m6m6LACgjgj/YaBnlkgR6SLq8zX/cCNdc0U/zNpW/7SgFtb3Jl5jbdDaC2xoMUVo+JIcgo2+OgQAvkIQdGLi2VmjvKlJgN+UXNMFPtLS2oUWJXooGIFt1G3xiharNe1YQpLiLqDRgsynI6QFfvtVRUyMPjozuio0p10mQfSqyYzQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by PH8PR20MB5440.namprd20.prod.outlook.com (2603:10b6:510:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 10 Jun
 2024 07:38:58 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::b5de:b82:43d9:4e8c]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::b5de:b82:43d9:4e8c%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 07:38:58 +0000
Date: Mon, 10 Jun 2024 15:38:16 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Chao Wei <chao.wei@sophgo.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 5/5] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
Message-ID:
 <IA1PR20MB495357DF7A4299ADC96819BCBBC62@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>
 <IA1PR20MB49535CBF66DB31C2059C291ABBF02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <addbe5b3-04bc-4f02-be44-bdfe3aeba319@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addbe5b3-04bc-4f02-be44-bdfe3aeba319@bootlin.com>
X-TMN: [0KndTJtK7AR2jh6zdp1S632ilQhSLVhOjjEJHXAbikU=]
X-ClientProxiedBy: PUZP153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:301:c2::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <fju44wtyrv7puo5pozv3c72mnx2safrn4ycfx2hvpciqu46fw2@evcovqahcius>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|PH8PR20MB5440:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a299cf-0962-4c9d-5147-08dc89205b08
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	KFeXJezF6Xfv1wGR822Iduwp6KYsyRbLtMj0KmxBKjW6t6P688zwhFQn4qmWQMbHpocMRXtLHT0Gbg72JkDujmPBLnqa+jDC08phM72g1P/mEwklUuLRmR0EA93CIF1/N+Dx55CHc9KWhS7YiBLeHERLRcYwO3otFiQimhGZ5XXqTLvVwpYrcw9IKpSW1vgdTf1mo+Fx+tEcm/3ZxwWOWK1bDUDNiwvTaMUwGaHbv0/bTdozKjSBZiikc3YyudmF754d4ArfR5qrBujnDNoFFoll1t68mrHcmI1yQBviDDxr4o/l0GYTCPlG7O8vP/tV0XZEqQeRvcIU5+E3OiBrtes2b0qIbNZ0xn0WdoJxu2dp8ETJHmco9Zwond32A5M1m609RWR8U1Hgnsrvoq8y0rBO33b6pwTCRKd6PZEGlfDCsS0nPeoVhmI1mwzbAeMoZc46zGii5YuawiJ3b2J7Q+dPdhl8JNE76YWC2gtOxyeHV/x/SftXdB/OYzxj9U5nUwtBQZJo6E/coUmYuvVtugGdaVSbIggWH8RWOfWtalgo3FeFXlj7y4720wZJJb6y8cxwcBVsA/nmlN4ufr3geDgRTslcQQ9BrbZcReu+BsA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yvW7o4XFXkSHyvG8B8w00kR82jXdJTdh91JHEDTeVR+18cBYt45QC6umLKFe?=
 =?us-ascii?Q?qPQSa/7wMV3peUzSSenafy48NwbdtyP4vTI0BhUJyn4/8C8YNy245BAWPp+A?=
 =?us-ascii?Q?twbbKi3vv1Jmd/wRrpk/CNOAVi8hapMAgjG9lC50j6nWGdHXvExbv3YO6tfM?=
 =?us-ascii?Q?MvWcieHWoAHKxel7Vy1XIrydC8ZhBsYuOo0EbVqqCgXSfP3uRR4QUEZZcDw6?=
 =?us-ascii?Q?3q1hv0UR1NVT8UXh1EJVLq0z5zRtlr0DThLlPPfCFkSHnf5rYVUDf3KKVKyT?=
 =?us-ascii?Q?QwLrnt+UU5ltOy78BBK1uUT6IlF038YaQWvxwqLR202bBhy4qTohOg3+c+cI?=
 =?us-ascii?Q?ppB88be7ExTy/K7nRy+hCwSWDVHOruc+Waxn+sInIzb7CawI/2KFUxSouVpX?=
 =?us-ascii?Q?l1COp81C5qadUeFlXCfLY+wtYQECho6y7NAeF8fITSyAYLk9VutBOc9Aptak?=
 =?us-ascii?Q?kqUTdEcpv3gkt51QjQcgLGf3V/M1SkXAJt2uBahRRUnZwszgka3kDt9egnmW?=
 =?us-ascii?Q?hZliZ7pY+KIyQmf6foLAF9u+TjeMTb8I3m/R2/mhJ1mC1YV2fGkl7n03+Xwv?=
 =?us-ascii?Q?UPE4gCFAYV4ig/mrs2uD5z0y9fwNgcERLqkxtBj0q8LrpvwmO4s5TDu7Il9W?=
 =?us-ascii?Q?oyZclAohkvj4Cv6kLvVBMN4jvNV3o2Z/oejzUsP2QHfjHYcldHyFU0hsKOGC?=
 =?us-ascii?Q?dzvwhKNByHuAftIfymy6XXFDdZ4tjbXGZXLmG8MtPA1KbCPuvL7Y7vWqjDzV?=
 =?us-ascii?Q?FnAx4dstA2YgciuT53qATrTePl+G7qrWWfyeRbbG2aIn0xrAhOUXCwBbU2Wk?=
 =?us-ascii?Q?+JbXi2Hg+rhj6J1JHSeI0WTq8Cp13Hhk0OSioU0c0w/fhfl6C92SdzxmxAJ1?=
 =?us-ascii?Q?GD7IHMl5TflwrxHZ8iGpoRF3sGTi+JsrNjaO64aluJXFPqF+46VC2Sx01tEb?=
 =?us-ascii?Q?dgWn2kHDLXYmjgiav5084GlLOANTpcdfHvZzJS1BxTlnoMN47hC5jkzPmsvg?=
 =?us-ascii?Q?hUY5sCBgKwv9/TeIzXK/aM0koRfpIaj1jAa5p2U0Xew5fwSZ2wIgUC2KjIoT?=
 =?us-ascii?Q?Q5k9SeEWt+E39Jv7UKCCYwjqPt6OwXl7b+6FGRUlow+TJVG+ZFwuGxw4E+1r?=
 =?us-ascii?Q?SLq+hk+WYRVl3tb4VAxfhQJkXmvPtQuoMZI+LdxQexDwkDdPdVFmNTm7xhf5?=
 =?us-ascii?Q?xgAjDnLiWLEM4wD2umpa8bFoU0ilkx6M5ERJo6WM7Wy6Es8H9H76jTNW+HGJ?=
 =?us-ascii?Q?SeGOrzGjGGA6qpO+qsEr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a299cf-0962-4c9d-5147-08dc89205b08
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 07:38:58.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5440

On Mon, Jun 10, 2024 at 09:30:55AM GMT, Thomas Bonnefille wrote:
> Thank you for your answer :)
> 
> On 5/28/24 12:25 AM, Inochi Amaoto wrote:
> 
> > > +
> > > +	aliases {
> > > +		serial0 = &uart0;
> > > +	};
> > > +
> > > +	chosen {
> > > +		stdout-path = "serial0:115200n8";
> > > +	};
> > 
> > It is also better to add all already support nodes, such as gpio,
> > other uart port.
> 
> I'm importing, cv18xx.dtsi through sg2002.dtsi, so GPIOs are already
> configured and activated by default.
> For the other peripherals, all of them are, with the default pinctrl, set to
> function that haven't any driver yet (ADC, MIPI, PWM...).
> 

You forgot sdhci, which is already support the SD.

> Based on what I just said, I'm not sure to understand what you mean, can you
> be more specific about the changes you want?

I suggest adding aliases for all gpio and uart node. You can check 
cv1800b-milkv-duo.dts as an example.

