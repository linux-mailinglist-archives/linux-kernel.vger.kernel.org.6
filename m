Return-Path: <linux-kernel+bounces-559910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C64A5FAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE3A1897972
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38926AA96;
	Thu, 13 Mar 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VdhNtIBC"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2050.outbound.protection.outlook.com [40.107.103.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401226A1A8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881776; cv=fail; b=kc5dXwxfUF5enHDdTEzOW3hRjHRMsNBoOov6I0UU2fcqvlc+azWipYHaGDv9POOl0pRM3/whQvB1Ye8jXDEefsFeYiBYwKSl2vZd6oZlzcw5gz/5KQlW0DrkI6zNVgM6eaWfNOSIErbbpkolCmGOx6OzeIdSp6VV00bdkzpQgAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881776; c=relaxed/simple;
	bh=e/cBZuRaQcl9nR1VbqHt+PsDIEqmZW8Png/PoEmQREk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WKqMMLmcwyZfc8Fzl0zqfbT3AxF0Vena9wvhdyOV/a9VRWCgTEJ4vmCtJZc4aL3ap64xlixCJpHoiAZ6VLbUPINCjnnCTKKJHcUi8gA7suvUkQePH8tE9iz+nOrQn9YyBWdvR0LIbN2OdhJvw1ocpr6/H/cG0IDV8VPdm7u7TBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VdhNtIBC; arc=fail smtp.client-ip=40.107.103.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlZ7bjSmZjMOcPt/GBb3hBvtiNKsJM5FZLhvlEl6l5UEG1PSyWgXJl9tD7xm3XeIe0fKS5NGhDIP1Vi354uGacDs8oHUMPoFmel44ynlSYp43ZYq90+89p51e/7KjbtHQ4y+lKi8btUx4ucrCyWZwR0w2HIiNYjXBL5GLVOLlRql6duiS9qnmFuhH5/jTGmbDUPVPcHZEVoC2MPiZQl164SlYA2uuN2S7DMy2mveNgA8t2dCgnwTJIW+0XK2279vQ4IcX4Jpwh/P0QwCxE4pQtZQehc94dkEI7l47PogyFhQPyMd5L20Ufll9l7EV6wCb8GBHKMkCoWNJIta0hi97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T59SezVk84Qtj0n1iP2wRpzfTobdo8CXqFd9u2aD7KY=;
 b=ry9kSx55/inG8388Gh+Kqut245sakYaKSeuWR81K/h5CXtAaWIe/mn6DBNm5ivsWQBNTbbepJOmAzpzKqehv2T8emU/a4J7vxvUwT+A8cfL89AUCeIWRdoJqlVnBFwFw+C5OCC/CIPI7/Isn4HNTpPFeak5JFIIauLMqQQrk5eZHD0qzLaFTAL/HipDaaWSg6roh7HYERMA6tetxkzHwRjOx9PgDuVQkeOiZxvG0W3ZRQcBRdW5hkHKKuiIgTYbtAIqiOxW3p8P5UFUM6XpDqwKEk1aoMtsvCs+SRscJwTi9kKYdAHqcryDZEBXJ2NRbUEQ2T9pADS9az/1XkmO9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T59SezVk84Qtj0n1iP2wRpzfTobdo8CXqFd9u2aD7KY=;
 b=VdhNtIBCLEbYfMzGDFXnDc8vcv2+tJ+2NasT4AEKw6EhxqapFIEyBw7r1HQoCLQewal8SnkrGUajkaL72XwyhYHrNX+7et80MYaFjWQQyaNWL3VABWdGkIeYqYRnGQE/X+b26K+i6g+QT5iCszk2CJCMm7hrx77340S3g8kIIjRot4vlT5ohKiml1MQpGRqeopYEwUNymaSPnudbZ11oZJghw8vEkRbkFJ144Dq24OIPUws4jNtLtzcBlNbvVp14Azis1n25lNqx9D313oFyFaD3jqV4bA6mTDJOOnsVOtruZd/o3CTY+KlxjymPM/dh57RvsjkNTnVuHm/9NJ+xWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9990.eurprd04.prod.outlook.com (2603:10a6:10:4ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 16:02:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 16:02:50 +0000
Date: Thu, 13 Mar 2025 12:02:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Message-ID: <Z9MBpEvOqqsVkCwt@lizhi-Precision-Tower-5810>
References: <20250224031754.1001101-1-manjunatha.venkatesh@nxp.com>
 <Z8Ha+T9Vc8Bhz25A@lizhi-Precision-Tower-5810>
 <VI1PR04MB100498A9CFBB48DF250CC73B98FCA2@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z8m/zE9JvyiNq1HG@lizhi-Precision-Tower-5810>
 <VI1PR04MB10049E260B10FD83E57B2DCB78FD52@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z8sOKZSjHeeP2mY5@lizhi-Precision-Tower-5810>
 <VI1PR04MB10049C80F0A1990551F97E25C8FD32@VI1PR04MB10049.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB10049C80F0A1990551F97E25C8FD32@VI1PR04MB10049.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BY5PR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:a03:167::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9990:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d1cf57-99af-4cfd-d9c0-08dd6248815c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJFQYi8jbfTeoMHCIGGaq7Wbllq+xkF00YwusEaBeYHMBqdbTMqlOekfFujF?=
 =?us-ascii?Q?3NeNL3vC7Ye+7TgD1bQu1cNTGTJG/AgHEtrLljFEILSuFs6NDdJCrQsKmfIR?=
 =?us-ascii?Q?7fAiFU/Dlmh0lkrbtOpMiicaIBiiot6v6wlc4gCf9K1kfE1hvFs3r0FMI51+?=
 =?us-ascii?Q?EOjw354JyQB2yVFLOw0goSXoZvNOF5CJ63Wj+1ptfifjsyKJICrFZlVfnZ9q?=
 =?us-ascii?Q?6/K98/RYo6DfKC0HhqDZWIR5sVl0eJoaJ7UGXjahVWCfXQ5Rrew7IgjfCXKo?=
 =?us-ascii?Q?7wsmaHl31Q62uPCK0mAoL6Y4BC2W1ABIpSM8fh94Vsb/0+OIONeOGwUHfwIO?=
 =?us-ascii?Q?6xMp5t/eg160lwCXIPJ6ipwaPVcQeUJ0BRilQBejjKlBAE+hXZ5QfHHqRxt2?=
 =?us-ascii?Q?qGbbPXKo/y/rlMIRvtZ8p8rjYb5nH7LwZKoG9zmhhf6MsO8fgMqjapIS9C1T?=
 =?us-ascii?Q?smF8hS/t6GnCXUo1J2JvNNq1B7GNY9Z5+2ei3qX4NufY2PC9tkGLVTVCJbDZ?=
 =?us-ascii?Q?t7zSVNmhTrZVr0dd6Bn83lkTzN/v2o9g+x33cV3uNEOjMlQdwrewJiSLnuR/?=
 =?us-ascii?Q?FjNMhkE91lMscxS0tJZWpYQp1ae2Tj8g3yxRemM2gA0GCsDdzPgKmA+jFsjt?=
 =?us-ascii?Q?hYKRDknoR8GFmvL1snu1zje48YEwnv12aMf/P6aRzqKZwIzKEzheiv564LvU?=
 =?us-ascii?Q?zGx5KV5hylCH97nn2jDhxLgLSwwLJL5xUoBA82/14ip4o3pv5CddIySYxlaE?=
 =?us-ascii?Q?4RspZT1ObCNXjishiNBIYhx5SRsvn0tEsKd8DzV8xDlotfPF0zT3BzWm/4X4?=
 =?us-ascii?Q?FfeL7xTujNSI6RPfGnG7za11lgCVPmIVenrxv2ypcYKqvWjwCvW/1MwIy1rX?=
 =?us-ascii?Q?U1qx6CHfgdx2F/PSUyIUsr3gZfxAT0Pc1QN3jt1H5HIfbNUHL5y2zeYSax3P?=
 =?us-ascii?Q?c2ftTB3ZGSyTcffs2dF7eQAuCGZSWuZ4JChn39eNfbELos+vaIyoV4FLayzX?=
 =?us-ascii?Q?NZPukNEM6uZ+7g+5fouVN0aUQhQwTfbHZivY8qD5dTQHPMlfpoKiEPg1RnUn?=
 =?us-ascii?Q?+bAFc7ehI+SQuNkscG6mSa6CguLrXAEgjbJ86PY1ZLeKS+qsTG5J1MJmt8fq?=
 =?us-ascii?Q?FRzJkpYQS260JCFq+d4iof1Hb0Dud7vlEUgB2tmMx9CSSmW0gpPviobjCHJa?=
 =?us-ascii?Q?oOMXgY28g6lZbL0OsAQWQ7yL3gPpNXhpBQZ9WpMA81WZuvRLaqZi9wN9OMKF?=
 =?us-ascii?Q?0VKS7++KpD2dxN554Tm03il985spzpeJZtr9PjmSjjP/4uoJK6yZ8i86IqSM?=
 =?us-ascii?Q?Bb47Ok2nAVh6eX1z5F+yUnxEvTg6k4cKFVyWbrvTZJRZ3FSXGLqtC+EphMY2?=
 =?us-ascii?Q?1vA/Hjawm0v1FeDMPu8OwVKmKBw6Hh2lVEH4t3zMl3EHvdztNY/nwwoJuawN?=
 =?us-ascii?Q?7NlRcM2fQ0BR8b+j9kcol9h+WZB9Vj/A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kh9n8MB47lYX7IusQZRuqrHbv/hjOKHLDKgesictS9o1PtOpIYGcGlRRa3ME?=
 =?us-ascii?Q?6gVUkXdcOwE8Rp/NxWS8dYWkJ9R02URZtAICaOZ7sv+mrKZ8dV/LTFOmeJ0b?=
 =?us-ascii?Q?a2pxGkRtuHXIJwxxyXpyNWUUv9jkzbKet7DHridTTBrza87uv/ELb3FRiDBW?=
 =?us-ascii?Q?kJBFFpwvwKFudyb8S8dYyohlxVR0DEx7top2MDncR8HqW2SH1eSbggnEYlEH?=
 =?us-ascii?Q?QAqgi9fc0LyvqCugvZ88LZ4QMj69wHqzG/rssRXGANzPCbgdhm++T0JrerVW?=
 =?us-ascii?Q?yWixAtXqdhPxLhzIY5fLpnexSHw6MR304gT+/theybcP4RLL3ubAVK+GQZkJ?=
 =?us-ascii?Q?YBGGj8tcMvMxo2DqgNdRuqc/O4w5J4Xepg8imLMCAKQ+N1XEQAAVX5pvVXlG?=
 =?us-ascii?Q?h0V8Go0Tge+8rppJas8pZn8bR0bsTi8yYXGMn2RglypsX/YMAZMkxSkl0BQA?=
 =?us-ascii?Q?m+8nEhjElZmNsLbxaEqFAxWRUQfFC62Y3vjaLOGNOL8pZF+3nl3fwZygo81Z?=
 =?us-ascii?Q?GSsuQ+cajvf0A6EtWdYzzV5DxsmqCOrEA7NE2gJ16ywVF6beCP+UftCaJ82Y?=
 =?us-ascii?Q?QBIqG136bHLcRU1EwHMhhPMWUwl8VvWJtS77U9nxx/JTy6CFvYww/uq36mSO?=
 =?us-ascii?Q?Fj1hygOB5b415kWg0NiXojJtZeVn1s5csNYCmCDRul3e6nSzrcz1G2hDw+Yl?=
 =?us-ascii?Q?IpPCfRWkctgI8jBFoM8TChDMuIGt2Xx4QU0zEfdcuj/cV9R2UKCJ/CCz7Bq3?=
 =?us-ascii?Q?FY/Yonq9A7hYLXuiwV97Vu1fcWAv2Jo3CZDJmlJPXOSonu/W7Sq/awnDL4VS?=
 =?us-ascii?Q?a78D+z9I7JZ70ZUe4uR7FsnlQfuGIhXdH9uyOSnHpbbksLwrJwYz7vjpCHqo?=
 =?us-ascii?Q?mgGImN5kXUzt/7sS784H3ldoaTvCXXRQhwE1aFfz6D+1xwp9xbQO5Jlv5JmD?=
 =?us-ascii?Q?Y4kCWp2BV6i9aRaH9IhGu4tCmYBmTBdk6PoHJQzRZMD02yj5/osMUgxX3czU?=
 =?us-ascii?Q?mvogqYapttTnLe3ovMO9DPS6e8tN6Xqwf/fRdjP8+V2jfa0KPzUqcKVWpBfn?=
 =?us-ascii?Q?zjVY3IhZyjOLshim2ESgJMAl0q34eH1IYhu/80oKfQwncs+eG2Mlefy+V+L3?=
 =?us-ascii?Q?0zFMRg7YmpxjMA8S11joVa8vcipgjOY7g6Gbg8Sxduh4ybq9IsTrHSzHv5xO?=
 =?us-ascii?Q?uIXfX1zuNqUFHtF/i35ZQGV6SBg7qnZZPUkZHxQOPBEU/yQC4rWp2hpOuZgd?=
 =?us-ascii?Q?eiSP7OAzJe9Go4l3JBD0K2cS0HVAj+vQDuwhT/JXFTe4N64P/rUB144TiUDZ?=
 =?us-ascii?Q?9KcFdTorR3b7UI3mVLR7tbMwopAjdFA4zvEffS0rf2Cvl/YUARc3gjFkG7A+?=
 =?us-ascii?Q?dZX/lS7VTthVC4oPKFwbHSrbxG8DUMjp8TyYPEA9tQ+/bXpLK9MyYlNgwEi6?=
 =?us-ascii?Q?LSFWLl9pg7spmD5OIKImgFpLenA0wXKXNteo8ET05vXGj1KQtHcFIWQnMKln?=
 =?us-ascii?Q?696ibnkyz7itSjGhyleAlJH5NZY203evuEVIEVzGxswRElYNzGE0BtazynRI?=
 =?us-ascii?Q?1ge2OOnatT0JNf7oZNo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d1cf57-99af-4cfd-d9c0-08dd6248815c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:02:50.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlEwbGxMQpgrjt4G4G5Y/PVdyDdLqLe0//N9HtRXoNwQUIiKiumtbx0qjBRXgPdRuwQi1u/NacI6JNmSd2t06Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9990

On Thu, Mar 13, 2025 at 05:03:54AM +0000, Manjunatha Venkatesh wrote:
>
>
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: Friday, March 7, 2025 8:48 PM
> > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > kernel@vger.kernel.org; rvmanjumce@gmail.com
> > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
> >
> > On Fri, Mar 07, 2025 at 12:34:53PM +0000, Manjunatha Venkatesh wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <frank.li@nxp.com>
> > > > Sent: Thursday, March 6, 2025 9:01 PM
> > > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org; rvmanjumce@gmail.com
> > > > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue
> > > > fixed
> > > >
> > > > On Thu, Mar 06, 2025 at 08:31:29AM +0000, Manjunatha Venkatesh
> > wrote:
> > > > > Hi Frank,
> > > > >
> > > > > Please find my inline comments.
> > > > >
> > > > > Regards,
> > > > > Manju
> > > >
> > > > Avoid top post for linux kernel mail list.
> > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Frank Li <frank.li@nxp.com>
> > > > > > Sent: Friday, February 28, 2025 9:19 PM
> > > > > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > > > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > > > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> > > > > > linux- kernel@vger.kernel.org; rvmanjumce@gmail.com
> > > > > > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue
> > > > > > fixed
> > > > > >
> > > > > > Subject should be "Fix read from unreadable memory at
> > > > > > svc_i3c_master_ibi_work()"
> > > > > > Or like below pattern:
> > > > > > 	Do ... to fix ...
> > > > > >
> > > > > [Manjunatha Venkatesh] Tittle updated as per the review comment.
> > > > > > On Mon, Feb 24, 2025 at 08:47:54AM +0530, Manjunatha Venkatesh
> > > > wrote:
> > > > > > > I3C Master driver svc-i3c-master
> > > > > >
> > > > > > Needn't this line.
> > > > > >
> > > > > [Manjunatha Venkatesh] Removed this line and submitted the new
> > > > > patch
> > > > > > >
> > > > > > > As part of I3C driver probing sequence for particular device
> > > > > > > instance, While adding to queue it is trying to access ibi
> > > > > > > variable of dev which is not yet initialized causing "Unable
> > > > > > > to handle kernel read from unreadable memory" resulting in kernel
> > panic.
> > > > > >
> > > > > > Can you provide more detail information why/how this happen?
> > > > > > which varible read cause this problem?
> > > > > >
> > > > > [Manjunatha Venkatesh] : Below is the sequence where this issue
> > > > happened.
> > > > > 1. During boot up sequence IBI is received at host  from the slave
> > > > > device
> > > > before requesting for IBI, Usually will request IBI by calling
> > > > i3c_device_request_ibi() during probe of slave driver.
> > > > > 2. Since master code trying to access IBI Variable for the
> > > > > particular device
> > > > instance before actually it initialized by slave driver, due to this
> > > > randomly accessing the address and causing kernel panic.
> > > > > 3. i3c_device_request_ibi() function invoked by the slave driver
> > > > >where dev- ibi = ibi; assigned as part of function call
> > i3c_dev_request_ibi_locked().
> > > > > 4. But when IBI request sent by slave device, master code  trying
> > > > >to access
> > > > this variable before its initialized due to this race condition
> > > > situation kernel panic happened.
> > > >
> > > > Write above reproduce steps to commit message.
> > > >
> > > [Manjunatha Venkatesh] : Next commit will update this description.
> > > > I think it is common problem for i3c framework.
> > > >
> > > > You'd better change i3c_master_queue_ibi()
> > > >
> > > > void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct
> > > > i3c_ibi_slot *slot) {
> > > > 	if (!slot)
> > > > 		return;
> > > >
> > > >         atomic_inc(&dev->ibi->pending_ibis);
> > > >         queue_work(dev->ibi->wq, &slot->work); }
> > > >
> > > [Manjunatha Venkatesh] : Actual issue we have faced with respect to 'dev-
> > >ibi' variable.
> >
> > How about
> > if (!dev->ibi || !slot) {
> > 	dev_warning("...");
> > 	return;
> > }
> >
> [Manjunatha Venkatesh] : dev->ibi is not initialized to null, might be some random value be there.
> If it initialized to null at the right place then this check can be added.

This is abnormal. Where do you find it is not initalized to null.

i3c_master_alloc_i3c_dev(struct i3c_master_controller *master,
                         const struct i3c_device_info *info)
{
        struct i3c_dev_desc *dev;

        dev = kzalloc(sizeof(*dev), GFP_KERNEL);
	      ^^^^^^^
		whole i3c_dev_desc is zero by default.
}

Frank

>
> > Frank
> >
> > > Pointer variable 'slot' is with respect IBI received from slave device context
> > and 'dev->ibi' is with respect to initialization of slave driver these 2 are
> > asynchronous events.
> > > dev->ibi = ibi; is initialized at i3c_dev_request_ibi_locked(), this is invoked as
> > part of slave driver IBI init sequence, this is what we want to check before
> > processing the IBI request from the Slave device.
> > > master->ibi.slots[i] this is where all device ibi instance list are saved, so here
> > our slave driver init IBI stored with respect dev->ibi index.
> > > So adding 'if (!slot)' will not help to resolve this issue.
> >
> >
> > Please wrap around at 80 char to read easily.
> >
> >
> > >
> > > > Frank
> > > > >
> > > > >
> > > > > > Need fix tags and cc stable.
> > > > > >
> > > > > [Manjunatha Venkatesh] : fix tags and cc stable updated in the
> > > > > commit
> > > > message.
> > > > >
> > > [Manjunatha Venkatesh] : Last commit message missed to update fix tags
> > and cc stable.
> > > Will update that information as part of next commit message.
> > > > > > Frank
> > > > > > >
> > > > > > > Signed-off-by: Manjunatha Venkatesh
> > > > <manjunatha.venkatesh@nxp.com>
> > > > > > > ---
> > > > > > >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > > > > index d6057d8c7dec..98c4d2e5cd8d 100644
> > > > > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > > > > @@ -534,8 +534,11 @@ static void
> > > > > > > svc_i3c_master_ibi_work(struct
> > > > > > work_struct *work)
> > > > > > >  	switch (ibitype) {
> > > > > > >  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > > > > > >  		if (dev) {
> > > > > > > -			i3c_master_queue_ibi(dev, master-
> > >ibi.tbq_slot);
> > > > > > > -			master->ibi.tbq_slot = NULL;
> > > > > > > +			data = i3c_dev_get_master_data(dev);
> > > > > > > +			if (master->ibi.slots[data->ibi]) {
> > > > > > > +				i3c_master_queue_ibi(dev, master-
> > > > > > >ibi.tbq_slot);
> > > > > > > +				master->ibi.tbq_slot = NULL;
> > > > > > > +			}
> > > > > > >  		}
> > > > > > >  		svc_i3c_master_emit_stop(master);
> > > > > > >  		break;
> > > > > > > --
> > > > > > > 2.46.1
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > linux-i3c mailing list
> > > > > > > linux-i3c@lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-i3c

