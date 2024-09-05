Return-Path: <linux-kernel+bounces-317403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C9F96DDAE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4831F21CA5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C36C1A00FE;
	Thu,  5 Sep 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JtEAV/UT"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD520328
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549188; cv=fail; b=KVNRxNPZsOolYFCdMMKRLW/41PC3uJ5D7F0RP6kszc/DqMy9ivIjdFVvZWKv0zF26ZAevi6GEEWsH75P8e057sbu9PpZNhv2b8dVBLWm3ccXG5OvoGlxyYrJc2LFu9GV5OA4ZWbTuOiLzsiXGJ8wGblLE/Wpy5q+W5GUmJdoN80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549188; c=relaxed/simple;
	bh=8n37Oaloq+RFMtKpuFru9pzzjeDMygY/VijFqQMgWCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gNtCH14HsKpMsEDdyMxFAmWsbv/REd9MXl2kbqHqcepo66XA3qgI6VgXaj1cooEuEnVMCRqY7hixpbi45hDq34iXfKQbnljyxBhTPzzrxCZS4JB6ap7pCsyKJCWp0IZmKYXe7oOx4b6o0QXiyiF3nhEJVUDeIIXikguNynjw8ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JtEAV/UT; arc=fail smtp.client-ip=40.107.104.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sntfBjQBW7BozjOcG+nu9v2/XuUZsL+Qa3WoGhYYBXWJ5KB5WqaeQ0hEorpIGSF0ml1nH5i+BW43WSxDRJDSoD0hnO2yYhGMGMiLIaqn51emdyrAWsz6meeGVrLZr5k4Hsj6mRk1u2ix6bCkBFlQFS3rcfo4oaJntHCgxluhsgWlpDDMbq//clF+e+Th0cmBmvZq48dFlG2a86GkKKq1vcmLk9vy7g5LqIyio6pt5evp9JZ4/+Um8AQEyzJBoEksXvQgyl5284+pPI5JZM6tplrAn738fGd7jgZnf7aCeYbCOxMpDrZipSKgRzhQwRZcUcridfy0v0LgnywovNHPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjSFdqFTyVHcUqe805VB5aON9/Df/pxL3Gh81WT9FzE=;
 b=WbdiC5d1EArDSeeBCqwhjGWvaqEH2LdEsxWjlJTOknV3LnZzSAV7KfCSPFw/ogKAOPHKgM1lBly1jHF+Qig/IDljQfDxLp4oveWYEHc2bC3l32u9vHNqrK3pEyoZLBKGb4j8U+xpmPYERqmvp0USwliXd78Wgvp4PUgIjL9SI4HMtLrdtNX7kOSxHyXDk/GW6q8Fy2UZFTp44ntSxNaAkl0gYcDti2KmIFMrc1ppeUzLjFdl8eLZgfsxEvLCxcjUoSH3NYIvTFE50u9Wip2+X5iLsF05LnQej4rjUzuPFj1oHZa+rMXwvW7Lws7e/3mhum1BsBe96ZqzAFzO8U6trg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjSFdqFTyVHcUqe805VB5aON9/Df/pxL3Gh81WT9FzE=;
 b=JtEAV/UTKPc6WuFux7qtNMgmXCxJaXwsRPVzvOw83VUw/Y6oxZvg7gvbIsj1c6Q1sAJ3QNmJqpCVlqOkiO5tUWj2e404MejDP4lIn8MhIskF+PSyb4oDGnMf6T+Rlf9+mRGL0WvAJJd7OM0kupUJ05KxdGVicUSFX7dBQOd7fVQ1me/ZNAHl69SEA7Hyvpote3Gm14EZTFpBzIrM5J5fK09MyjFEMk0lGIEVARlg3ssYRCL6kudpLCNqXVY21xJP0jsmug82rGAIVdM2D1D4/bckhjZJXClLzP1IzswPzbuP/qfPR/IvU/03Bh9owmeN3MrQhASTH6HGr/N7TuYDCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7276.eurprd04.prod.outlook.com (2603:10a6:102:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:13:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:13:03 +0000
Date: Thu, 5 Sep 2024 11:12:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH V4 2/2] i3c: master: svc: use slow speed for first
 broadcast address
Message-ID: <ZtnKeMpmKDo9ykXz@lizhi-Precision-Tower-5810>
References: <20240905074557.3810026-1-carlos.song@nxp.com>
 <20240905074557.3810026-2-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905074557.3810026-2-carlos.song@nxp.com>
X-ClientProxiedBy: BYAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa5ad49-9c25-4f37-5a39-08dccdbd3ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VmIxO26QqRLrAq9XH78l0T1U7kfjrZefyX5ljMYy6D1dJjtrqQbC0wdHdx7e?=
 =?us-ascii?Q?4slLFqjIkKK9JfLYzGJIOv7wP1tjFaiuujXpX76iMvhiZKRaIbeFTORAAjpd?=
 =?us-ascii?Q?W2NxCcUwHutfxWggKgg1rjvHMcn0BrLYTe5O8IGEUMkI5sVUMTAYRssBzlZc?=
 =?us-ascii?Q?z4GP/eVrHCydJERe6YHV5PdJ8KBGi9P1AzZb+n5JuVGM6rTl2l6fCSfwqJLI?=
 =?us-ascii?Q?ldUBp/9+EavA4PEJFpyJi1JbKD50luWcncm+5+FVSBmx4omKXaNqIQIPzVu2?=
 =?us-ascii?Q?usf47qmCkACkbMnKTSo7NxAzK0fZgfI3UC0hhNXxpBRdYhBA6wl7gfobsI21?=
 =?us-ascii?Q?+akE6eVXd93ftMdyRlsdEU1OrIHb1AbL+ouDW+Cvjz5SrC3NbGLXJ0IzpDMY?=
 =?us-ascii?Q?Pcmx2WmxGZnory+sokI9/w1/YrKugFHHajS5KmvlXiJ/tCeBXM5Sc6qNqReO?=
 =?us-ascii?Q?zT6KagLaFLPdUmySqCi7DNT9SfxqlxccfIuQwFvjOtcDYVmBb/u2EXwwb5SM?=
 =?us-ascii?Q?rHmCuN7XVHgPMb00CIl28FPX32wVheO9c3/RUw2k2sc02nz8+Tdz9IbVE/7o?=
 =?us-ascii?Q?/CAaoHKwvxK0W+XZMRjZbBAtowNYht9ymLgkZ/y8z2NsQDiu7XiwH+lcgP+a?=
 =?us-ascii?Q?RKQwJzl+biaPO/OfohFtgwb0frL3fLj108NeJgIwveYYk7wqTtCAqU8rgUF4?=
 =?us-ascii?Q?FURzL/AG9cd6/dXtUuWNV00QNUjG5triL/jpWW8ehDEPb5Cn+ZJ6poPBMQ7+?=
 =?us-ascii?Q?Txix7/ALhDWM5EbGanRp0T8tsj4+p2/JPCEbKJjmqy2ZbTWWDJmF70MdZ/MW?=
 =?us-ascii?Q?l8JNAHNlxMGjwwx6QxKezZG6mRzsbqL8z9AxWfkv4E66jdY6PxwySLWxB1r6?=
 =?us-ascii?Q?y9zEu525e2tZX1+YnUxjjzCk+ZcxbR62+fIGdXFcdLcx/6Ah1TJ2J4oHrJcu?=
 =?us-ascii?Q?F4LqA9puFUNk0V8Nnyf14XSw2ONCmKd5pJB13XDXoRhrFKh8qd3+mXCtExSf?=
 =?us-ascii?Q?PFTN9VWWXtWnr8mTbuySJTTx0R+3bHTfrX5W/zy5SgjnwB9T1VgIth3F4p38?=
 =?us-ascii?Q?VzhuEFhTgPGNSGez/zm5Jc7iffdMPl2jcLs2bSw1Mg0t9NGLvlMKbFrV43pm?=
 =?us-ascii?Q?OQAXhozVkUJyqun9vn09FVpnXiN6z7B8jOs4du2BZNf0p8HzlcinprVtd7c2?=
 =?us-ascii?Q?YDE+bAfnralD8I7g1HDYA4jVl/Qj6akicEfRvhuA8pW7WC19QWFj7xKJp9E3?=
 =?us-ascii?Q?PkWyYooP0GFzjGSH6fI8GbTUMw5X2lsOZxCsgzrP2C8h5RPlVY84GRkMUuFH?=
 =?us-ascii?Q?ou3xxb2Vyhv7/Jnnt89SwXMvHMtTZOQ/MOYeqj+ZrARoEPmz4JdkDwQfLbsR?=
 =?us-ascii?Q?q44QzfbTZsB4s7OWUTQTf4+62kwnf/HWyS2KJBUqMfcF1H+ghA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jp9/C5dHvKGPa/9L4SHwFQnlTDWaUsR7pTWHXwzRSfXOLH9O2eFpAfc0kWbe?=
 =?us-ascii?Q?UTJFUFyOlnr7A3W6DmUidkyVAT66sxZT/1cOv7H5f6SapcZxrj5i+rNFAOEk?=
 =?us-ascii?Q?u0rS7XT5hFh9kSds15Y0VG4xRTio7JXLxaj95+xO3TJ3OdE9DGUnTUIztDI4?=
 =?us-ascii?Q?w13UIY5Aj3OVrPyLGxjgRPBNwJHIBThiQ5DSjic1UY5kjPfNWEdFdBamBiFp?=
 =?us-ascii?Q?FJnAbbxJ3GIm1nVCw7BVEG+DLyJ9PqS0EyroUMYjzVUlSDZl9yZP/wT1mGH4?=
 =?us-ascii?Q?7BEj5rdz855PzmKrIeDxoetLOEEIyRvWaf2Q11UqPRtb3RGZbHq5ShAx9hi2?=
 =?us-ascii?Q?4hggziXOo/eaPi43mzCtliZXR1A7OsG4HlBw5mfr22PwbR3WkmIiHZahjjQ8?=
 =?us-ascii?Q?awnZz6C2yXhBwJW274h3ncD6jsEoUDhEUO1kCc57lAxTHZdgHh7+QLBRCCgr?=
 =?us-ascii?Q?BNKIoa4TlAqePjt1rj1RdJAY7a1Xkx6JaE6jwbh7uOeZOydJdzaj+51UHUXB?=
 =?us-ascii?Q?hIl5rXVVHHFHphGbEDj7i0QMa6v8eZUVM43TtLD+hBEWBpNYM6FGMbs5sxMs?=
 =?us-ascii?Q?Tz7jh08BayhFEEeMikqjqVIRaz54GRwNxjpxZctl7KTNWgadlIBSyri7SDi7?=
 =?us-ascii?Q?M/UlsZvWLuT2R4Q6bY6mdCMRfT4a+9gtEHz158u74X3H0unRii3fHgtzPyB+?=
 =?us-ascii?Q?qhDrDU4Wsvs3Nsiey/dg0fUAia407+bXOw6qwubY+kIJZiL798ab5gdy5X+P?=
 =?us-ascii?Q?3figdMpBRueJnBxILLqWDMirQV2U/lLfbPCZPP6FM5ejht4IRRKouBJd69sD?=
 =?us-ascii?Q?GJScHD7wTqu/yY9ywINBaf0dNPYAbi3o15Ens3glgElecen6tQuRksfGcSb9?=
 =?us-ascii?Q?AbrTUPSdrejplqo2PbkaulP7eTaj4L/DaRSTYFl8p7gc4uzDL6KAnlwit+rc?=
 =?us-ascii?Q?mAw3B6+mOUguuaEETRQq+rimg0hgOQHXzKMo7+mnUtYDPxvNclK/CoOUFmH9?=
 =?us-ascii?Q?F80mqgIPqQb197YSycDK8TYagatO7JaKzurIKgCZRfWkin3O2Gyxn45JRXaQ?=
 =?us-ascii?Q?rYOvFIl2ZbNlj+3FR5PJUVq+nNEpo7Y4T4+oxfO26raIh3ovaaFgy7p7HokQ?=
 =?us-ascii?Q?pvsn+AnUAtdZiMATlOH1bXFnaimW/WGD+3GffMX8/sAKzpLcEFg+oUWFTENv?=
 =?us-ascii?Q?r6aZJVeilApVw4b8ENR0UzFot1erfl22x30EQR2Dav9yH+nWfDcC/fbNsoVE?=
 =?us-ascii?Q?z9hnL4hUewF696UEQX+e6MNmocUpSuq8Hqj3r1IbCeV+YKETXkHNHKW5uSTz?=
 =?us-ascii?Q?1Fm0IvskBCgqmkMqXNH28BXQ61Xx3un76RrjflA76fvleIMHBHmVopS+nkPU?=
 =?us-ascii?Q?iq6ao6gkF7Kl6Z96F2Py7DRb7EkjmpF8Rjhabbh0s1meAXOt3Snd1yfn6sU4?=
 =?us-ascii?Q?OFyKjCaba+qAyyRvCXERuYnYomg7y/cbfCKTXMCWM4wF1KQOjPdKmR9AkUMq?=
 =?us-ascii?Q?x9/a5ppcxuE268QraYGAzRJwSt1OPgKN9p/p7sBxuNByTpFBzL+Xe34+al5w?=
 =?us-ascii?Q?VDyw9SngyzS7NiMUOuVvyLyA62Ejtd1aKIXOmeTX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa5ad49-9c25-4f37-5a39-08dccdbd3ce4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:13:03.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ6q1RzJw0OvZa4yoE5VAFmjjpaKnBU+cuZMHHbkAibvxMKp3epUY+Pl9YmFk38zLHEtdQoOXkcoNnZ6PM85Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7276

On Thu, Sep 05, 2024 at 03:45:57PM +0800, Carlos Song wrote:
> I3C controller should support adjusting open drain timing for the first
> broadcast address to make I3C device working as a i2c device can see slow
> broadcast address to close its Spike Filter to change working at i3c mode.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>

Tested with https://lore.kernel.org/linux-i3c/20240719080233.842771-1-carlos.song@nxp.com/
The patch of i3c: master: svc: adjust SDR according to i3c spec is critial
at imx93-9x9-qsb boards.

Frank

> ---
> Change for V4:
> - No change. Send out together with I3C master.c fix patch.
> Change for V3:
> - No change. But miss sending it with I3C master.c fix patch.
> Change for V2:
> - Adjust variable definition order
> - Add mctrl_config description to fix build warning
> ---
>  drivers/i3c/master/svc-i3c-master.c | 52 +++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 7c30f58e344b..423db3dca257 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -184,6 +184,7 @@ struct svc_i3c_regs_save {
>   * @ibi.lock: IBI lock
>   * @lock: Transfer lock, protect between IBI work thread and callbacks from master
>   * @enabled_events: Bit masks for enable events (IBI, HotJoin).
> + * @mctrl_config: Configuration value in SVC_I3C_MCTRL for setting speed back.
>   */
>  struct svc_i3c_master {
>  	struct i3c_master_controller base;
> @@ -214,6 +215,7 @@ struct svc_i3c_master {
>  	} ibi;
>  	struct mutex lock;
>  	int enabled_events;
> +	u32 mctrl_config;
>  };
>
>  /**
> @@ -531,6 +533,54 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>
> +static int svc_i3c_master_set_speed(struct i3c_master_controller *m,
> +				     enum i3c_open_drain_speed speed)
> +{
> +	struct svc_i3c_master *master = to_svc_i3c_master(m);
> +	struct i3c_bus *bus = i3c_master_get_bus(&master->base);
> +	u32 ppbaud, odbaud, odhpp, mconfig;
> +	unsigned long fclk_rate;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0) {
> +		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
> +		return ret;
> +	}
> +
> +	switch (speed) {
> +	case I3C_OPEN_DRAIN_SLOW_SPEED:
> +		fclk_rate = clk_get_rate(master->fclk);
> +		if (!fclk_rate) {
> +			ret = -EINVAL;
> +			goto rpm_out;
> +		}
> +		/*
> +		 * Set 50% duty-cycle I2C speed to I3C OPEN-DRAIN mode, so the first
> +		 * broadcast address is visible to all I2C/I3C devices on the I3C bus.
> +		 * I3C device working as a I2C device will turn off its 50ns Spike
> +		 * Filter to change to I3C mode.
> +		 */
> +		mconfig = master->mctrl_config;
> +		ppbaud = FIELD_GET(GENMASK(11, 8), mconfig);
> +		odhpp = 0;
> +		odbaud = DIV_ROUND_UP(fclk_rate, bus->scl_rate.i2c * (2 + 2 * ppbaud)) - 1;
> +		mconfig &= ~GENMASK(24, 16);
> +		mconfig |= SVC_I3C_MCONFIG_ODBAUD(odbaud) | SVC_I3C_MCONFIG_ODHPP(odhpp);
> +		writel(mconfig, master->regs + SVC_I3C_MCONFIG);
> +		break;
> +	case I3C_OPEN_DRAIN_NORMAL_SPEED:
> +		writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
> +		break;
> +	}
> +
> +rpm_out:
> +	pm_runtime_mark_last_busy(master->dev);
> +	pm_runtime_put_autosuspend(master->dev);
> +
> +	return ret;
> +}
> +
>  static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  {
>  	struct svc_i3c_master *master = to_svc_i3c_master(m);
> @@ -624,6 +674,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
>  	writel(reg, master->regs + SVC_I3C_MCONFIG);
>
> +	master->mctrl_config = reg;
>  	/* Master core's registration */
>  	ret = i3c_master_get_free_addr(m, 0);
>  	if (ret < 0)
> @@ -1658,6 +1709,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
>  	.disable_ibi = svc_i3c_master_disable_ibi,
>  	.enable_hotjoin = svc_i3c_master_enable_hotjoin,
>  	.disable_hotjoin = svc_i3c_master_disable_hotjoin,
> +	.set_speed = svc_i3c_master_set_speed,
>  };
>
>  static int svc_i3c_master_prepare_clks(struct svc_i3c_master *master)
> --
> 2.34.1
>

