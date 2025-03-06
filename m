Return-Path: <linux-kernel+bounces-549176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7777A54E93
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D44E1894E95
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8433020764A;
	Thu,  6 Mar 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OcKBMeSM"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE02066FF;
	Thu,  6 Mar 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273712; cv=fail; b=ry7e9AgQaW1lcAPdpKe7D9MVBxrZikWONm4aHp5+XWg0agD46NMTui6FmeHCMmRaXPo273cpQAbTLX2JB23dJFtGoPybVOz/usYCxuqxBkDmIpr8ZZbC2wE0XyfYPv0VJiwyaUT5YgvHXAaFp8Iz88tUf3mdDRkd28sA8uFf5/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273712; c=relaxed/simple;
	bh=of9R1pW0l9mbQEPWzDghGHOgkcxaNxooLHeNwjwHpR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I/ylG0edvurwMJV+SFAT+cpyIpK01tycDy4XSkUcDtx0NecWIu88XPPNWvjUyZHEZ15N1JlL4s5Yo9Zft10IJURQmrN79r/XhncjoP3KtvawE7Rrr7oIm5XQJ6oP++dy8No8198wgz+mv8lHAVLjvdJ37khYZ/ubMbNeQHTU14A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OcKBMeSM; arc=fail smtp.client-ip=40.107.247.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2wei1H4otnTTFMOCnY+KSaDdDIGCYD6bC25hB68EJ1aErEfYa2FXxhnIP/dAQjnE0108ClfxUdsoXe2ZaBZMgyDu3xe+CUTC/tU0ip2JreMSW54z90+I+3wwpBqURU3CdJurKepMMESF2H/NtwZSVFrLHuVU+NcBQ0ozlkvbc8WXQrPCDjhnwWaeq8M31bnw/J/LhXUVFloOPOQFIOqJ4EMf/v0nVj4ztC5UBegYMg9JQ6O34EXEtCi56Gk3Fk5XPaaFjUppm2K8H4fCb4+sg9pCntuq1baDDdEUJdLqn49AjJSEub9+qCFtIPsTzYIPytA6zk3s08qVqOzpCIpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/YlibP91ZOe99y7wmZa+zc6MfsV83mbRs6PjoTEEfM=;
 b=jbyPoOLoLVnPkXOG7u1DxqxxMrcIPUIV7rszlUp838mopx/7XQRW5Kd7kwwkV/Ha+7Q/FMBDVA0axvJr+yQYdlm8g/+qCy3eC87psTWNCxLAOXEBjLzCgvo12mdXxddF7ojchooNLjRELecohV3uW5MbLapUjyoVmrDp1knTDMqJEsp0jDGEXI8R5RBfvHTpL5zb4Bn6ss5phKtXfhHUDn51ZoQFL47db38Q9Zh3eY6Wyw+xvKCmBQT5ngDQ/iC9EzNjw4ywrY0c1N3DmcSJFkXWLk1bWgUvTgf+0s/1djotvkcpN+1gTEnOJCE4+7O1LqeGyHEBqr0iMpgXzbAKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/YlibP91ZOe99y7wmZa+zc6MfsV83mbRs6PjoTEEfM=;
 b=OcKBMeSMggRSGb8LnV6X45uH2wfUSRT1WZ3S+Yswjky4gsROQ+nxGaIKLmd97tcPzosrcx3SJazdNziq1vouLBLPxWwDv5o8SQj6032kT0HkSwxSOwY86LaWHlKK6y/HyCE7zYZoPwkYtnr/rEjhDjGie9NaKcINWI1GcHk/ECu10tuDsfcScsBYKetJweciCRGJP3JRF03amnhJrHvLRrv+ooUqhEXuUyN5wxj7jemu+C1YY4F9GqeR0fVBrOTLfQVXnCMwMqdqUYMPTW1gikufv+OdMaOcsshY9PD+cpdZLPJkTtCPPttIThkyQUaOdILsVK7FkfInq1JEiXJtiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8892.eurprd04.prod.outlook.com (2603:10a6:20b:40b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 15:08:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 15:08:26 +0000
Date: Thu, 6 Mar 2025 10:08:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v7 2/5] i3c: master: svc: Add support for Nuvoton npcm845
 i3c
Message-ID: <Z8m6Y8WTevsCUMZX@lizhi-Precision-Tower-5810>
References: <20250306075429.2265183-1-yschu@nuvoton.com>
 <20250306075429.2265183-3-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306075429.2265183-3-yschu@nuvoton.com>
X-ClientProxiedBy: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce6a958-2a7d-47fe-87c5-08dd5cc0bf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iI+SRWp/cSTztSNynguYADy0QC0tZi4je0CiilotBOvn6JVMUbd6qBDN9sfu?=
 =?us-ascii?Q?rbO4W/Ml8F4mohr/giKr08ctYWiKuCFlG1bgDUMQpvFtSjD7eaBfK7TMkHuk?=
 =?us-ascii?Q?ZmKgGiDoiN/IoZVaX6z07S5Q5LGPdAZu6hnqqS8F3dHIdX2eSwFe3exDTK2P?=
 =?us-ascii?Q?vB7m8AS4q9OA+z9RFuxCv6f/Njvin2LO5K5iZyNO+VmBDPDYfJzDjC7hcvjP?=
 =?us-ascii?Q?fm/NP4D+SkZEQ3jkCX3nqBbh1VN5np4it78doKTyt7FUZSS1mKM8sult7+47?=
 =?us-ascii?Q?s/6UWPCa4mQG0tbYoWkBICI/uVS3BEffvUjr4oXnEHqbvRSnqfpCYQTx9K79?=
 =?us-ascii?Q?9LsOk4GcTNMx5jeBr8qXNY818M0f9Fqx8jlkRZB3xP1NMEa1Q1WV7WGshgRQ?=
 =?us-ascii?Q?j6O6L0o1kOwizwUtoG5KPmJmj36et/xTgAWKBQU0r3pi0j7SWztQKOaj+OUb?=
 =?us-ascii?Q?WvGo2o7D/yy9sfVPmZBERI8lOc20HYHBXqilYAmANa6z7MMkYJ3rbbp91JgY?=
 =?us-ascii?Q?ufBAZ8jETeCFjwfLoK/VbVSAu+fLv+31bh//jPL+FDit65+n7azXZHarh1jx?=
 =?us-ascii?Q?Z/SYGAX2CUPiFw+mVwVZ2joKAJy6UD7FZoOZqG60ptOKcWdFBs3yl6SvzGiY?=
 =?us-ascii?Q?eLmx3oZcdKvXQCK2fKninEjDY2FdLj6luZNRFeqvT0neC4tH01RkgRjfRDdq?=
 =?us-ascii?Q?ohlFBBzJWIhsUhwauATWlUspEyswkA/FpUaTkkwY5pFWrKrqcurtiD+yJi5B?=
 =?us-ascii?Q?JTjj8YPUvSHL9k9BrcBRhhTGlQvMC4YH8EJ5OOyeW7AlkHyaX8rDGA3Kcn2t?=
 =?us-ascii?Q?rUnZKpp0HaanFLfk174kwaFtflMAzB7LnpCys1Dd3HrDIEDIvcGl+ff3b8ak?=
 =?us-ascii?Q?VTLp1HaPP0O4DLDGjaE9wrTX2xaXTC2rNZa8cA2gB4Bxx6so4reQEluh6iKk?=
 =?us-ascii?Q?MhyFL7Gzm/bGp2rvRK5fwk5RpuBvTcv3C+/838Cy2SdcGiD/Uo8sMYxk9yG7?=
 =?us-ascii?Q?wyObJ+uKi4HnFYcQHgg4q4AGSSC04DV4cubPVA7MYmkTxC9Oxk9ahFVhJrkb?=
 =?us-ascii?Q?wLr92KgBickHGOrCDZ8jI6efNZT4l6y+lep8nPdVyUcUcJ3JQTwCNdHuUjB3?=
 =?us-ascii?Q?2JHCiPeOGQJrQslou13reiGZPZ2wErKZ8NFBUscFTIAdvFReSqiBnvbuZkv+?=
 =?us-ascii?Q?aHrCW00JRj20u8XjsT6l7uLlhFwtRAChEZ9c5jUAA9N2QQM60gXeJS7e9G0v?=
 =?us-ascii?Q?9UHkvR4MT8CSE6pKthtgSJqLbwshyrVAjJRmhP3nFX6g7MsI5+hJQj0Hg7Tk?=
 =?us-ascii?Q?jLP03GmPT4wu75NKBTrCxsgI44SH3GNj8VzBct7L9604n5QTkRwffa6IsHDK?=
 =?us-ascii?Q?A4jymgiBRNqkJbwowXVQwB+RlXTl9QHR3YizN5G/aM/V+M2FKPhF4EEyjt4k?=
 =?us-ascii?Q?9QCNAGqZbE53ATtfNTAztcbxjmxKU1RjWqwFuUCrWZXNugvl/GOiRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/Ox/Xjq9vSHcXkCQD09W1E2rR0Yyvrz5QlZ6hmh1Zn3JuGcvGWwUYOyvdnh?=
 =?us-ascii?Q?UrJ7AGwnmDZIbipKZLzTqhWaecj5iy3Ycn6el7pGobmlMX43zrM0g/nGGdjZ?=
 =?us-ascii?Q?/JxpNeE/BOT13NVmPUuJwCDfXJv12sDY6MtIilAnvVTrUA2dJOx7nxKHO4Ve?=
 =?us-ascii?Q?8ldWv8gcV51yN4eFR2FXop5r3c7/3dQmL9gIknIiQ8j+8vzhXE0acqNc2ZXl?=
 =?us-ascii?Q?FTXBBZFkaFzSww/hsHBMGGKx6+uI7JOYa1tHli0rimTmmAH/lm2Knzu6Gm2R?=
 =?us-ascii?Q?EkXp1jPA9u5ZU7zrQRfk/zQAs2MEyY+Zs8JJyKA4/U+norEOxxR8cx2AN7J9?=
 =?us-ascii?Q?hvOlwxSTZaLy0YEIAr+thsEcqNkkMSHneeG9RLoEaa1A+CrHK30qsGoLE6lp?=
 =?us-ascii?Q?5uQw0W19NBTbtEV5r2jWNxclCfKghFKdv4+1id4yn7mA7eubHYFRWX0/J7Dl?=
 =?us-ascii?Q?2yMpS9dmQTofNftMIow6E55vIZLKSJDkvpmYbEuP7s+kChSoyAdisy8qd2ln?=
 =?us-ascii?Q?RHiR0ufaOMAFbW4zRJMrt5eYD0n4jsYhzWXexhT0vyr9xJu1F7bD63PaKaam?=
 =?us-ascii?Q?CUEKGZlEarENfjVUqVYf/Sf2TkoS8RHvDWDXlzerEVJlzRywgJyKo0o8K5T9?=
 =?us-ascii?Q?XYEzyHddj2yz4FUUA3WClXIlT/+M6lFGsJek2/qgJa9li4dehOfWWSsQBytt?=
 =?us-ascii?Q?p+6+u2BFO1a0RS5egd0EVN21tD+Kf8kKB7uakdXccdFJ0ms2Bmr9fMAh5f82?=
 =?us-ascii?Q?xxY/ZMRZMrMg7xjSGSp5w82bTOiHglhLlulA16eBYXiIoetjzkO+lfM3orkz?=
 =?us-ascii?Q?fjYaDDCr3o4pdT/tZyFzNmJwIPi9aekkBHset9CKmR7+X5+Ev6MZs0GEHpa+?=
 =?us-ascii?Q?F+3hQIo4U5sF6UUnn9qPKOsd1mxqW2i1gKHD7f/insa8OR8Yz+tjzkGljNYb?=
 =?us-ascii?Q?kfYZRtcHWx/10p2okqTXGH/AtaSPLBfVsPDfDwY2Jpf0Mtz1xaDsS8y0aaHF?=
 =?us-ascii?Q?5kXMXnsXO+Q0UWlgvI6LQxoTxY7sZj/N9kMlylRssy04f2opnCtog8AxjWmi?=
 =?us-ascii?Q?qrAe+EQbXR+aGG3Xki726fA0HUrSECS2inw5RQxTkZM7No1qDh0ZEHmnCfgq?=
 =?us-ascii?Q?Q2ZZb27utdg6v+m49Xmi10skFATik5Zvezq0+MuACxhf9TJ7FhIjxdmPucDw?=
 =?us-ascii?Q?N4HbzDHA1ley9oaqsGueQ5Js9ToP2zoClkb68LcmIr+QPfdNdaR+AA8CcoDx?=
 =?us-ascii?Q?lHJwIkGTzSevPqwmBYBH+oeq/I8IUUwwWH4T00pPdyTVeu1BAu/8L/777Yly?=
 =?us-ascii?Q?t5rps3HcIo/hLzePgJ1K5/8YRX3iuFz2+i3d9OQnFM9ukxJfgdZPgt9tU4kO?=
 =?us-ascii?Q?90kLjVH8IMEEAsqSjCe+fqlEza42yIOOfTH8T2/u1jdDFM2uuVbtAjyl4Jzz?=
 =?us-ascii?Q?zL3J4fSvvRPXqDBZUy8A4Kt0kud5s5Uz4r7Ooz8cFgOKQ0m8XuMjbAR6sthb?=
 =?us-ascii?Q?DYpbX/yBaFE+xoG6yOV6tSj1J1YHamrTRQ7oAI87SCd+LvLFhVFILNbs5IrD?=
 =?us-ascii?Q?f9y/tdSnRuuEekjfndAP5GZ7cOGKSxcJqyqopa/H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce6a958-2a7d-47fe-87c5-08dd5cc0bf24
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:08:26.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZLHPZeujfDLo95r3V/swGsJ/uhT47r1kl+yhI+PnyC1G0fbkDNya6NPs/gCb3+aumI2Fxa+HZ9I2eqYedIXGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8892

On Thu, Mar 06, 2025 at 03:54:26PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> Nuvoton npcm845 SoC uses an older IP version, which has specific
> hardware issues that need to be addressed with a different compatible
> string.
>
> Add driver data for different compatible strings to define platform
> specific quirks.
> Add compatible string for npcm845 to define its own driver data.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503061400.GGr64rkR-lkp@intel.com/

Needn't these for new version. Need such tags only when seperated patch
that fix this issue.

I think alex can drop these when apply. If need respin patches, remove it.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index d6057d8c7dec..40269b692aa8 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -158,6 +158,10 @@ struct svc_i3c_regs_save {
>  	u32 mdynaddr;
>  };
>
> +struct svc_i3c_drvdata {
> +	u32 quirks;
> +};
> +
>  /**
>   * struct svc_i3c_master - Silvaco I3C Master structure
>   * @base: I3C master controller
> @@ -183,6 +187,7 @@ struct svc_i3c_regs_save {
>   * @ibi.tbq_slot: To be queued IBI slot
>   * @ibi.lock: IBI lock
>   * @lock: Transfer lock, protect between IBI work thread and callbacks from master
> + * @drvdata: Driver data
>   * @enabled_events: Bit masks for enable events (IBI, HotJoin).
>   * @mctrl_config: Configuration value in SVC_I3C_MCTRL for setting speed back.
>   */
> @@ -214,6 +219,7 @@ struct svc_i3c_master {
>  		spinlock_t lock;
>  	} ibi;
>  	struct mutex lock;
> +	const struct svc_i3c_drvdata *drvdata;
>  	u32 enabled_events;
>  	u32 mctrl_config;
>  };
> @@ -1817,6 +1823,10 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	if (!master)
>  		return -ENOMEM;
>
> +	master->drvdata = of_device_get_match_data(dev);
> +	if (!master->drvdata)
> +		return -EINVAL;
> +
>  	master->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(master->regs))
>  		return PTR_ERR(master->regs);
> @@ -1958,8 +1968,13 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
>  			   svc_i3c_runtime_resume, NULL)
>  };
>
> +static const struct svc_i3c_drvdata npcm845_drvdata = {};
> +
> +static const struct svc_i3c_drvdata svc_default_drvdata = {};
> +
>  static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
> -	{ .compatible = "silvaco,i3c-master-v1"},
> +	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
> +	{ .compatible = "silvaco,i3c-master-v1", .data = &svc_default_drvdata },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
> --
> 2.34.1
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

