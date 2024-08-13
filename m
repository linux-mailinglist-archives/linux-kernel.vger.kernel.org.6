Return-Path: <linux-kernel+bounces-283980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F1A94FB70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C4B1F21AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE02134A8;
	Tue, 13 Aug 2024 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EsWgVExh"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2080.outbound.protection.outlook.com [40.92.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB5848C;
	Tue, 13 Aug 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723514064; cv=fail; b=H6NvyxRTQtukQzkdcO1MEEhTScAJ8rEHXD9p/QP8wxRfVYFwGlvQXyBwGsVcexWxxq2hOFa7kD2hK+eB3+uSdoHHfYKbNFukE1ZzGWooBZfQ+34hM7pnoKSjT0v7KBrcYPAeZP6IQBOTFtgzPqWvv8RUtgf+u1tM0rqN3SRcGWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723514064; c=relaxed/simple;
	bh=8+hOMiUwe20sh/CTHbUXmhRPkpP37Pqv0gDG2rSak5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ced/SWDlnFZ6jKQjRujwS/t637DzzoaNk39uz7AhwzL+c+2ZmujcaWTwCrrHALTe2PpdRTKjFmOVgIF+XAw3vRdAPjmY0J17CO4+HXBuFnDoGEw/h1ek7tueLIhlvKMJVKj1GappNcpG7pHC4bYleOjXTlArHpLI2B2Z9pAOSDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EsWgVExh; arc=fail smtp.client-ip=40.92.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU0INWhSOWbES5urTqZESA5QeRQedi4K3+4FJhgAgfcvMAH/J/QWFnjodysJ9o/AkVRhDOvsWQaU9dko2kWCmtEdA4l/spITIElxTMI8bP5UjVe9RHxfSzpB5/hn5dZFidHtTkyHyjccZtkgzD9YZocRrm2Ou7Su6FaO5p2Z1q7i72NlWRYIvA+4zPP+PLzo2KjqNQ8Ke87WZgUBxGmVZ+0wEwC7josWCBUKYrnbkRY+etSyQnAxT+s/a22aSbeqHlVG1xSdyxpG11R3Dx8LpPOuceUuIG4LvS2hPs9f4R0GTFI9sJTUpsGU7V7n/ykgaPz2ZzLC+NmZQ4AKlY801g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCqct+paTakFTJN7VMApzz4B9iZNaECOGP9FcOC9HG4=;
 b=B49TbPb3iArNjWDAQqS444QnprzMa96SkYb2IBKRAY7NwdYj564HteN1AzL1tVQLOap+cwVFFsqwV+Xt4JvuwoGqp+c5Xf6kNlsTYI/xm3lWQckIiFQyXLvZKjqVCj6NaO6cuXcPs+la59G2jhDtotOTE+kPubR80Cv2ztPrV0gJbECo1gwG2X0yirS59vX64jgm9WAka/DWUw9H45ssMeQ1hEGWiF/oM6ngD5e52FJnBHeL4zYLM4Oaaz9FtiZ/z/IfFZS03j0j6+GffjbSLRlgRhiRDt/gOFVuL/tN2oshyCEmGLfUUMXeYMwqiFJP1JYmJxVd6SqO2y9xpMKS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCqct+paTakFTJN7VMApzz4B9iZNaECOGP9FcOC9HG4=;
 b=EsWgVExh57iQJhQBTSNU9v5oF8gMCu/m2PYRy1ZKB33SHZblKzQ8UZ/t0TZl9PtwqqJ53Lm8qlwAJVe+a29yUHwmCZEYQEtYBVY81L309IblryrGQCj/49ZxiOPMksvFG1j1FdPA8pkZbAgac1gphsOZD8i67CzPJc9zNW1VdFp9vjbTPaKYqljy6q9ISa0kgNYcTf0yv0qwTK8U8DTTpjUwC3yg37RZgRs2HFbVuaoHQJkqNc512dZQLM4UvB4zN3hxhfjpzpmJQnDhy8pNl4jdzvzj4z5G9W5/k8J0hwPdWB/VeVgB1/hYZvph3KOCyAeKqC3bjIaBH5idI4sOPA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7303.namprd20.prod.outlook.com (2603:10b6:610:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 01:54:18 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 01:54:17 +0000
Date: Tue, 13 Aug 2024 09:53:31 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Chao Wei <chao.wei@sophgo.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Drew Fustini <dfustini@baylibre.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 0/4] riscv: sophgo: Add SG2042 external hardware
 monitor support
Message-ID:
 <IA1PR20MB4953751ABC2CBB8747A3ABDCBB862@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <PN0P287MB283050511BECD88076E8252EFE862@PN0P287MB2830.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0P287MB283050511BECD88076E8252EFE862@PN0P287MB2830.INDP287.PROD.OUTLOOK.COM>
X-TMN: [NbtRrglltd9Snd3q/6oSpUtVc6d5ydgLgnD1CPc3TXU=]
X-ClientProxiedBy: PUZP153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:301:c2::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <akmegdy4kjag7uwtano7536ymxpsunho23hovb6f4jhdroo6nf@5af327l7qxbf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fd2133-a019-4958-28d5-08dcbb3ad75d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799003|5072599009|19110799003|8060799006|4302099013|3412199025|440099028|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	pmXzMQJYhRFEDmHTt8Qc5VWoNYzZ8oT9hVQ32pRjdHuoN6Fxzyum2M4uH8QnAPxRVMhBcX4dqFX9eD8+U17PnsaUq+i1cwHqokdMKuUcedTEv78UrTJwF0PsckEIoyDwGFR7fg2F9guq2oD+upr7vV/UqraLLE3sw2NGqCQYAf7M1lstc9KMK954/+PIg7EeeG0A/OrkfMhroGKPxa0OTnt+c4pzo6WrznffG1nkevL5BtjQ6Jt7eGeiF0j89ErW13WF/4hECzOT9PR/BBAUT4y3pxd6dSlLD37AZf8Vk/MkUmeWGP3WwSKnGhL26d2c+AeiXHHgtuRRBvAmp5NN7OZIbqlgYaHAB9mK/SHZHhPROJA923/WGB+weUx4Kd8jevaZw+qsoA34qlw3AcD9WUj/yA+LtElK+9I4799zG4fG6qPBM+dxkIVhLbcwHZhPpvukjRQ9CkFR6b2pzqDuCidMk9x/wy4PAmmD3hKVX709VjzxQNJnLWLtHE1+OMW26Db4yfM/IRiJFMoSxUmgPuBCAqWxocyBPmXGYuQ5Zg8gM5Yl39Ww+CJasNB3kaplq5XAyJduF8NAp00FY6Tg42s5rnC8gBWLAIADEs0KVSKdWy9XrqF/yIbDIDJwV7a6UmoMzXXwBlkzXbTTLKtwYdhoy+DfKh/nrTrkgSQ84GTADkbmRgUvtrPGjVfzPY0TljDJiYwov5AE8qJCuAAZTE3ZmptmRNAXw5P4okc5afhgRlfAomvUQ59Tk0v0Q3VDXRavKp0+z6+GnEXBaIolM96eG0oT+2fnOBtUeajN/q2yfRS7zKFJOJeZ6s004h6Piu5cIyBDtouuP9lpoGo97Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AREAI6ydWxQFhshLVMqzcq5o742Crzihete07x/C7BJEsoczcD7VhpvfvYcE?=
 =?us-ascii?Q?dUKc0Rf6EBFDreIJMjbc3Lqnu6aZDhhJyaUN77944XWEFswiuACgzX32S0+E?=
 =?us-ascii?Q?5rz4+IZUxbSuP86cVIx+KTJ1JHykekm2WL4shu1M2mzpcSlXHlT6CV2jGteO?=
 =?us-ascii?Q?bD1dGraEa/3YoT2YO6Pv0Jvsqr3NB13/lv9UQFVvzMQpP1Lk5FQ1Iv7sXfTl?=
 =?us-ascii?Q?9EoySyAzuH95sfCD3gNS/CNMG1OU5Lta5NcYts3IgKguWFqOb2MtIxDFAIVX?=
 =?us-ascii?Q?onrTKh+bBU1KRU1TLuuxOX90cArkIJ0dVDUyWvO27rtvE+sSSBruADTn+voM?=
 =?us-ascii?Q?6beMwS6jCPaUFj7kNdPEJDAosH6/P0ailmxPU5ypBafx+2DeAYhYX67oPhxW?=
 =?us-ascii?Q?1oR47m6NlqPFj10Y+1H3YESG4aS0SPg5srRMmoBuV6dpPpjs0VKsjJcEIcZ2?=
 =?us-ascii?Q?xCub1VczseUwEF+1H2no+Ph28194ohWSmP4V1lA+oIj8+6/P/ohdGWzjK4QU?=
 =?us-ascii?Q?fQ24nEixlKluYIf61SzFkmH863SPtMPwuYGnn/5E5vkjRRfQQcMSs0NsKSzN?=
 =?us-ascii?Q?KWxqgu5iN5mYYdCsLEEXreq0zHQyNbw8TfkWVQz38MBpndi5vJIYjh3zP2u9?=
 =?us-ascii?Q?YW66C/nGRdEfGDaLonwIIeB1xogl1KqhxZv5saWREujPrXsfE9xmHLQ2NHEi?=
 =?us-ascii?Q?E9Z0VxBFb6NGBwdvZkef1CckR1QQJg+qSbt+ZXY42EQ/yZUk4rXYt4LjrH02?=
 =?us-ascii?Q?IqjTRyNLaFyDiAXwITl53WD7PoVx6Fd8Xy+Sl2Tx2hygzed93LkdQahFw/9k?=
 =?us-ascii?Q?wHBAsItn1L5+93pfEjbBoxOxHP+D9+lKagmz42d4Nqu4muCOtme9U1VctCxM?=
 =?us-ascii?Q?59xh8EooH0mkFvIyNQgvKiOF2clN7xMNJsO6/uJa97YMH6VSkG88dL7KP7UB?=
 =?us-ascii?Q?kzgQDSZ5412rwURF2/59evkTFj2jzTEIXUn+aeFxxoBtm15prybB20cSa5Nu?=
 =?us-ascii?Q?HjVICA1l8WmeMK4IelhTzkAcgFUujOV+Cmkduw3L2nG7RGUTP/ZP5pDev/ee?=
 =?us-ascii?Q?vn1XAn1dDQbdhKvdjPH8hWugu0CU1gOYM3ET0FblLTxIHU98snv7wIsIQ6Mf?=
 =?us-ascii?Q?orLitggvAgjLAAMwR15/QqKfd26LlXL/ylf0Iz6Xmg/DkjuKIKsFX4C57SaV?=
 =?us-ascii?Q?nQSaxZg4s0uEVeTOQB78EU8+DitWxqwuQw2bifDe4guhv820hCFToJYsYjhF?=
 =?us-ascii?Q?uz+QZvb/m+SYcOffeURY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fd2133-a019-4958-28d5-08dcbb3ad75d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 01:54:17.7593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7303

On Tue, Aug 13, 2024 at 09:24:19AM GMT, Chen Wang wrote:
> 
> On 2024/8/10 16:03, Inochi Amaoto wrote:
> > Add support for the onboard hardware monitor for SG2042.
> > Can be tested with OpenSBI v1.5.
> > 
> > The patch require the following i2c patch:
> > https://lore.kernel.org/all/IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com/
> > 
> > Changed from v9:
> > 1. remove missed wrong return value.
> > 2. add documentation for the other interface of the driver.
> > 3. rename repower_action to repower_policy.
> > 4. use break to unify "return 0" in is_visible function.
> > 
> > Changed from v8:
> > 1. rename critical_action to repower_action, and add some comment
> > 2. remove unnecessary wrap function
> > 3. use guard macro to simplify mutex process.
> > 
> > Changed from v7:
> > 1. add mutex protected and fix the return value when writing
> > "critical_action"
> > 
> > Changed from v6:
> > 1. restore the driver name to sg2042-mcu
> > 2. remove unnecessary wrap function and check in the driver.
> > 3. add dts and config entry.
> > 
> > Changed from v5:
> > 1. rename driver name to sgmcu as it will support more sophgo chip.
> > 2. move some attr to debugfs.
> > 3. add standard crit_hyst support
> > 4. add documentation
> > 
> > Changed from v4:
> > 1. use fix patch for binding ref.
> > 2. use unevaluatedProperties instead of additionalProperties for binding
> > 
> > Changed from v3:
> > 1. add thermal-sensor check.
> > 2. change node type from syscon to hwmon
> > 
> > Changed from v2:
> > 1. fix bindings id path.
> > 
> > Changed from v1:
> > 1. Move patch from soc to hwmon.
> > 2. Fix typo.
> > 
> > Inochi Amaoto (4):
> >    dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor
> >      support
> >    drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
> >    riscv: dts: sophgo: Add mcu device for Milk-V Pioneer
> >    riscv: defconfig: Enable MCU support for SG2042
> > 
> >   .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        |  43 ++
> >   Documentation/hwmon/index.rst                 |   1 +
> >   Documentation/hwmon/sg2042-mcu.rst            |  77 ++++
> >   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  60 +++
> >   arch/riscv/configs/defconfig                  |   1 +
> >   drivers/hwmon/Kconfig                         |  11 +
> >   drivers/hwmon/Makefile                        |   1 +
> >   drivers/hwmon/sg2042-mcu.c                    | 388 ++++++++++++++++++
> >   8 files changed, 582 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> >   create mode 100644 Documentation/hwmon/sg2042-mcu.rst
> >   create mode 100644 drivers/hwmon/sg2042-mcu.c
> > 
> > 
> > base-commit: d2d190621b60d77496d36659e1621b20c897b25d
> > prerequisite-patch-id: 5e7221ed1c63bb4d68e4a2a0141440e32d29e397
> In fact, I did not find these two commit ids on master or sophgo/for-next.
> When testing, I applied this patchset based on the latest sophgo/for-next.

This two id comes from my tree, not the sophgo one. But I
think it should be recognized by the git. For testing, you 
can just pick the sophgo/for-next tree and test it.

Regards,
Inochi.

