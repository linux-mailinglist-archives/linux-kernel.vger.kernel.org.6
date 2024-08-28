Return-Path: <linux-kernel+bounces-305533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682B963021
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA49B1F21890
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4ED1A7AF0;
	Wed, 28 Aug 2024 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ndR3/zj7"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013010.outbound.protection.outlook.com [52.101.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97B328DB;
	Wed, 28 Aug 2024 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870158; cv=fail; b=bLC2WASgiTNFRR8aE1T9R8TNkVE/E6VZJz5cZSVY40Vnk2C/+HmJbUu7yGzQMrJC9jy88n0h8VmVC9UHfyFHALbdlIRWMbxky46Tc7kcaxPVmejlxgFVkWo/nb9A15D2WaXO0Pl1O5XFf5QSH15yKT2bQeLccbhhRwui5Cu3jns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870158; c=relaxed/simple;
	bh=HkUEzBL0KqB8r6c041QzroOHgg6PVyrl95ORtOM3UQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vnv2/QCgQFzdpZMEvqydBgpKmHazW/DeJda9g/X8dzi0QNSkWaX2mQpYD43zWb3kqbAn2x69Ayo0qT1rKpishx/U+QmvyRMzYXl1A8Mldagc9DR3odEK0rFZlOY0rkxEnZJG/Ez3ebVysbYCuBYt4EQSJGesHx39ic6vynk38OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ndR3/zj7; arc=fail smtp.client-ip=52.101.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD8EUi+uuMZPnopE8qxRqaoEMVSnnt8+tofzC6qzlz1JGmUV3NV2IlCOnRRPtZB37Lq0QMsm900FKqKLe23FimM98VtHniMuyForXWOEJAcLzT5625agP3+b1+VOotMhHk3Ha5R6La4RjGCxWwClmwvNYWVo10zglow8/ZfXxhgnSH7V3fKjkx/dplc4cuN+SzWoC1HwvwVH3UNWtcVZ3vLq+s11RGEbmO/rwnpd3gEpc2Yi9ANJsfElkHrN5bQrGs6tVTLbx53oiyZRKPFlIvVgwkfBExaViG65zrezp+hQPctLQhmR6yqFGBOkVb67oX5ZIuHrPq15emce5YT7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1PoNo34cistJmalBIFLkbacTllp7l8t5fNA8md8H2Q=;
 b=meEyZijk82sL1zR3nCCQliDRlEjiA8Fw/b3PLeKMqkhU/mnbrjW0Vulx4m5sciHmrDIlyRIILp9/WfQz4SRSK2dF9/nj2jQqOBsH7DLvFu7p2Zs2nnX92XENGG5EcRti+3HgvQYk/PQ7d4gBwof00xVLC+tmGMZ1lm7GrvFMqC3IpqOankjqoNQmlQPDoUkzuNgJl4HnfUxmkZKRPoToLV/IchGHk0u4ibs2Qx3FVLOHsy5ZImObYwEd2HxeTTr6IHyDevuoUoZRaMjMgj1IyyB/KxsBgnVyQ9rIfKFYkDBvxOt/kDXBlcX7DFPZiY65iATH23tN3CR2XHPxtn9T/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1PoNo34cistJmalBIFLkbacTllp7l8t5fNA8md8H2Q=;
 b=ndR3/zj7dgog280yorKVl+LcNuNwV+MWNGJz9lJ/MzI4GKwjtLh6i8yoI5An3DUuEGpMmgGyBFkEyzhViYkLJOYG39gy608RC0ABZGk6cp2ZqpgbUqcUyr+p8ldML3qBWOQjxdtkIo+aDbs0DJgmx2k2o4Sf0DUs39GdT08G98UX6T2awwcVLKoNknllk005XH1z+x9zRyjUItmWqVbEkQUZd1h+NyXq9cfGcatNhWNrQpcB1/PS4oHDgj5fCY1sEg6Y+ZNix9VEiZTz3NGDJJ7UMH1kGVUfv0zMSv8+2ljifyj23WSEcW9JHr7Apbz7/ZsmzMi2gtkyT0PbNlio7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9748.eurprd04.prod.outlook.com (2603:10a6:10:4e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 18:35:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 18:35:52 +0000
Date: Wed, 28 Aug 2024 14:35:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: robh@kernel.org, broonie@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev, jdelvare@suse.com,
	krzk+dt@kernel.org, lgirdwood@gmail.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] dt-bindings: hwmon: Convert ltc2978.txt to yaml
Message-ID: <Zs9uAbUPRqkcRdxL@lizhi-Precision-Tower-5810>
References: <20240828164133.1131959-1-Frank.Li@nxp.com>
 <54243e7d-2b54-4934-a530-173ac06180ef@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54243e7d-2b54-4934-a530-173ac06180ef@roeck-us.net>
X-ClientProxiedBy: SA9PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:806:24::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: b98fa86f-e20b-4dd2-b57b-08dcc7903e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bgrH93lIPIbqUtCm7E7cx6bZdULKLHZBojILb7+wlXZtvGK8a3ZOWIPW0yqD?=
 =?us-ascii?Q?twfEvn+r3DVB4MCXAybxZYjyR+pjDRWwJzMj1CY+ZzbHOYHaG+iyJ/jLk6ME?=
 =?us-ascii?Q?7tyB24wcF+dXTqy6LE5B12AZuCFyghPTvc3v4gTW5WyxS1IpSID6duhDTJkH?=
 =?us-ascii?Q?zCO2oJHNIyVK+4m9yQHEwYt4i3cY8cGAfaRybn5dyQLgE9+1q8SeNBvaDQAN?=
 =?us-ascii?Q?gUtjvd3VZoWIUmQcsaHQfVS3rggA6T82V5GAgFJ01RwjhtsvNKCVhhTEIubY?=
 =?us-ascii?Q?8DuLsXom8EkkfngFxEKQEkkKlIDiRQWJx9jBEUqnCnAvr7z2r8blz+1884MZ?=
 =?us-ascii?Q?LzkbGY9zG7lXqJDT21xAgfEImXF1AET9G7uQ8Z760QTnk4hUyEpaxprbN9io?=
 =?us-ascii?Q?0f5AitxpR1cRm/IMRdtE3BgZ6sm1zzF4TmOIs05t8ZTMuDn8JnvbW6pjTaj1?=
 =?us-ascii?Q?JNQProv8SOfugMnDiLxxTMz4EAcJJ7QFBxQv083DpZ9wEz0SMbHe8UuWWgkS?=
 =?us-ascii?Q?38cOvA43IrigSlyH39s/1rsG/V9Hg2/vKJg63eNJ0ffz8XxAo/ajDO2t5S84?=
 =?us-ascii?Q?z3IVtmtx+lzPj+cPNcBDmguW9vNWME3ErWknl48OLHdFW7mcpL4xhXixQCEm?=
 =?us-ascii?Q?e7LZdW2+pY7jrLZcTnbAoybfRoLU38E7OfaI9OQ7vXG1qQ5ml0QW2BT9ZWxj?=
 =?us-ascii?Q?JPrbUstsNUSQ1M/AR7BKH7tWzHsFo3yA/TLE0O1uGneXuHmEKbKRAEfQVHR1?=
 =?us-ascii?Q?/B1wSr0jqUJojnygbSc1LbZvmOGB2hukQhQdb6OFraPZFQRdiLO+/GAaxy39?=
 =?us-ascii?Q?VW3y2KBk7OJq4Mx8IKa+qPjywh755d32sfW0Wg0YkpgjjpfuLhZr9RpecP58?=
 =?us-ascii?Q?FuIfRzoZbW4Gk82rg4pEBiqmg/oDSvsANtNbZh4kM0eKHDZl9JAZ06eYMGO2?=
 =?us-ascii?Q?I10wP1d5fDbyLoE6dymuDVP1S7iBV+FYM8LDdDveA6Obk/0WTrXXMmpe9qFI?=
 =?us-ascii?Q?N6DDpeScYFqb8+MsLmFqeZBjf9j1MS1dmbqyaI8bZ/wwHSkJz1sGkRuzu4PQ?=
 =?us-ascii?Q?EVmybESdlID7mzU7BQ9yS3Y6Wq3Lrop24lMczN60Hohybj3L3Nf3qnzqqtut?=
 =?us-ascii?Q?16w5FkRSsSxGyhE2140MWkLb+0eeLZf9yiHYrvFhjoZQjBBB+PsVVcQT7QzO?=
 =?us-ascii?Q?Ph9jVpg7KL5x1ZaK6UGWWoU78GonlU8cJYVquO09YqZi7wsiMl9uEVsSJVu0?=
 =?us-ascii?Q?629/NkyxIFgEmPuw89FbeF1vAL2SUxGXcHYGhJgTNqdLHZYcYsN1IFVJxREq?=
 =?us-ascii?Q?/O58uvCpk+pEY5b+zx6B8Vh4xIGC22ZbNsLT3W2SmCERMjt3bpkrxkC+Evq4?=
 =?us-ascii?Q?lSVmviQbqjHnicbXC4afWqKqyxlJC1npapMW7K/+v1fOWyPmag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/vSzNM6gAoPrJ9YaAQaujzSbSGrNrxhsOIIEx+PNY+wNY+wOAvntfr3EI1E2?=
 =?us-ascii?Q?Ap+kbpQCK/ta/hdQjJ0XwvrvJSh7xnRqWmzpMhUq7RHUI1P0xWjn5xCp/xKC?=
 =?us-ascii?Q?Kqhoorg8/ZE35+vpd8Aic23yHWsn0zuYUu3Dzl2yWwuL5Ly1j7RfmHI2GuLR?=
 =?us-ascii?Q?jCaJIahR7nuvRo6qbX5KTIQUdrYgM2meFap583lWYw9kKiJ+/Lq8TJQ+Ju3W?=
 =?us-ascii?Q?fMn5wB4vJEysewj1vE2wl96rSw7w8AedABaYqjZDo2rNXsoE8BxV2h8yiGes?=
 =?us-ascii?Q?VgUB/KON9LjNnD0eum8t0g1dRamXHKVrvYX7E2YHgto+/zxKw7ZOXhgDbmvX?=
 =?us-ascii?Q?RjN31si5c+BzOyza68zC66JhXXhy5F1lNU3bfeH1fAIqo46DeAigdtxNhDkp?=
 =?us-ascii?Q?Imbxrsc9x0w5G8M2IUSLhOTLC3HrfISEkZOfl6UiriODOZvSinXXt0gAeZzM?=
 =?us-ascii?Q?kvCQmCxS0af5qPIXzI8Vqulm9mwCPokCjfh5iNGdfu6NJbYjibvJRE//36v+?=
 =?us-ascii?Q?6IVT0OUAPvkznAtU5uCwHTQm8W6LTJbf5DKAR01OcUbzX9Kv81l+Qfwqh0rJ?=
 =?us-ascii?Q?CTsn8XkTM/bq5XX1WfrSma8pXTbCG/ZnAV377mQIiZ+TXNJLtoIPeDt2fp0L?=
 =?us-ascii?Q?lyHTZQPzDZf7DeZNHZA2GdEikXWKdWpPawqyPFpy0LPS+jSykOgPgWdbzc2x?=
 =?us-ascii?Q?i6eYm2Z+/WOWtXGv3gJhKmpgQ/IzmVAJgGLwFoKVPHW+DYBDh5xfwjELxe3d?=
 =?us-ascii?Q?ARvtQciFN7rOxRQkWg31FxS0YafVwUUmpNnAH5HkJMz7yI5+20BG91ZGNWeM?=
 =?us-ascii?Q?HHTwsnhsbDke0nTPBGsDMrEl5XPnOYhDtTFacVf3LUBvT0a6VOuk+g+n3CPj?=
 =?us-ascii?Q?oW1p7IJU1j2V8szl4QTbVxxqtgMY3tN6bkzjHvGSPS0oTxaEyWTIP4n6wewb?=
 =?us-ascii?Q?yBKXbNXW4b3X1aWG810e0BIluJAR1q8rGrblu3gutDOBGKmt2E1+o8db3SDS?=
 =?us-ascii?Q?UmH2WKhTGEGaI3w0lg95lgSG9duAJbGRseZ9WeF6p6H9jpc68ZWCbVg14/gE?=
 =?us-ascii?Q?hfhWT2ezNF7R2ZrvbofujtCMVrdDU1mhqy3+niL3ixBPSYtWIjeFMH7dqR19?=
 =?us-ascii?Q?k+1lVxypIzFTTv67ykRM2t5lanNezvUCwcGuCVVaszZX//1dx44h/ZFma8e+?=
 =?us-ascii?Q?PJmL2hjQBPLYCPu9FcqaqWZOl4hNzdC/bfd4XobXbTwX6YmW1h/kbhQRHRj3?=
 =?us-ascii?Q?kJOktOLYkiAJigT05OKSt+0cTfqd3RjVAij/dvMQvO3bfUeeLEp6gtDiplfa?=
 =?us-ascii?Q?oZgSlwvBKzz5tTJUCKH86j1djNNTLSIvuv3FwrzoDR/tWx1ZGPgG/2UzgSxJ?=
 =?us-ascii?Q?Zs5yN8nrzIySP6zHPb38ujb7RTippEkeXAK7GXogIsGfG142tdWh5QJ6dvHw?=
 =?us-ascii?Q?Ts8c86tf1BQy/lmBmaUI8SM+BPYIr3+N2kXx5QCSbRIod5M5XD780Br4xiX6?=
 =?us-ascii?Q?gRmt/9f0EYeqqoRx0zFd3l3zfAiAhzpdR3GhlQnXvBo8cS2GllmEe9I6vldb?=
 =?us-ascii?Q?pkzQJ9VIXlLQtpvVtU45HuSFTpllWxebbkmvSzRz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98fa86f-e20b-4dd2-b57b-08dcc7903e9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 18:35:52.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5ghmog4Zr7ww05gPMlKRPR97X7n9bHhCtLQ5+xTkBmrXrcyj67oj/PLZcgD8oiBL6mFub+/HL6MdNwrzWrupg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9748

On Wed, Aug 28, 2024 at 10:06:25AM -0700, Guenter Roeck wrote:
> On 8/28/24 09:41, Frank Li wrote:
> > Convert binding doc ltc2978.txt to yaml format.
> > Additional change:
> > - add i2c node.
> > - basic it is regulator according to example, move it under regulator.
> >
> > Fix below warning:
> > arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
> > 	failed to match any schema with compatible: ['lltc,ltc3882']
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v3 to v4
> > - keep under hwmon directory.
> > Change from v2 to v3
> > - put my name into maintainers.
> > change from v1 to v2
> > - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
> > - update title to (from ltc2978 data sheet).
> > octal, digital power-supply monitor, supervisor, sequencer, and margin controller.
> > ---
> >   .../bindings/hwmon/lltc,ltc2972.yaml          | 94 +++++++++++++++++++
> >   .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
>
> I still fail to understand the rationale for renaming the file from ltc2978
> to ltc2972. I can see that 2972 is currently the alphabetically first supported
> chip, but that is, in my opinion, irrelevant, and it will change.

Conor suggest use one of compatbile string as filename. I random pick one.
I am not care about filename. If you like, I can use lltc,ltc2978.yaml
or other filename.

Frank
>
> If/when support for LTC2971 is added to the file and to the driver, do you plan
> to rename the file again ?
>
> Thanks,
> Guenter
>

