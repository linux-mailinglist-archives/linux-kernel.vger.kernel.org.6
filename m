Return-Path: <linux-kernel+bounces-549225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18B0A54F31
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E66177AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354C42101AB;
	Thu,  6 Mar 2025 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GmDJHkWA"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013006.outbound.protection.outlook.com [52.101.67.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3C20FA97
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275098; cv=fail; b=GNM67qRKIvusKpxULWTiL8N4p4LYZwRtYYhYy0rFQZJNjFsxcBd+VAGg7rInG6/IbHt9MlbY6sC95/OwChOlgfjSeFB5zLSg1qNr+BPlHh0fFwGX62n2ODGCI+m1YP4m44uMrjUZOb7QVvgHrFAINq/RxtXni6XEogvCt6Hwn6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275098; c=relaxed/simple;
	bh=qqlj+KSZcy1v9a05J52aNV8+Whs+T9LnR0oaZ4LfXIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pp5Dnjiq1iPyBtmVybeltaoQW527KldAfczis11Bi6c4kp6xpmmv70al5Ex7sLIjb00eZ0kP2N92BKVvUBkb52FFiRYl8Fx7WHXyi/a6Enfyy/YkINZhMusb+D/x9PhMcF5MSirlw3/YH30d5tugtK1689QYvBLEGCbywdQVrbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GmDJHkWA; arc=fail smtp.client-ip=52.101.67.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NARwLB+2+vpaqhx0n04W1HQM98aKNncJ1zchYQu6G5rR2Q1yl5gpTzYcs+OpFOxGmUbkN6TUYEWV2EOfe7iUCUw/fE1XXXGeL2C0AoqX8uSJ5yZUo873vpoKqMOaxCrcUl2g1xWbijEaFvS/7mM4lugpTxfybZYw/FiUQ+KNvdvpz4Vvz2gTvkMiiQSaJf6tjw/ohz4Ws8uqnxraJg3KLyhjOcugfxLuED4+qmxUm70sktMKdXpeEyvn2K/DhLjgCu5UqYjbmGXgj3dGZz0L9kOGvvT778My+9xM9KNC32o3GdY2g+mOejjCJzyeiHFVuS9RCrwjvFTMkNB19/gbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL5SsCYEVZ3SBMzz9T10ISbHLoRF09YozpS5TQuvoII=;
 b=VmHeQD8hB+GTiLGusVmwLDojBKISUOrNfUMdvhCPj0RdGp75cniShtpqRsYWJPjwhKYMsHcff76hG1w4exTcA/eKdCEN0mTe/B8jY7IWkMUbKvMmaTZ+kx2Eaeo1L/+xtullAC+E33EWElAt/YZDz3WTAHi8z7Hcgl+pC2pN1Q4e+5tgw94QQ3dDvJtAXVS6trUJFTsQAOG6Ij5VFC+0cHwMj762V8oGUmaQpH9kLpP7+AUcopOxqMebiHnuBE5QXvBqKpmqd+jQOkIBF2D+vP+w25V1wdK80zWsbs7d5Bxu9xj+UFuGtMXONnVrzbFm0/xIbUSNv7yBGUQBRSiixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL5SsCYEVZ3SBMzz9T10ISbHLoRF09YozpS5TQuvoII=;
 b=GmDJHkWAurACetWNs6ks5yq2N3uNdEyxv6yda+L9HXD5tltprIC30WUkoDyJ0jaZVX8LYeqpEIuYxO6lpHkHvxXVsbMnzpBQZZczUSCgeatMhmmkFnnpApUEmo7rcFlbI8xadboKf5b8V5mqhYt5XMW+hetqpx5QuO70lSnjvpNMxbN4FLMEEXPAV8N1Uk3CiS/YhHol6a2Qv7Gd0C7jsMTtpZNsHxkyPeJr0H35dCx6JP+52Hl68E8cqBb3NNJyqMkSZnwOFZHrBQKCdKcRuEJIJ3+XwsoJ7nzUNR80DXZ43cfuVfAe/fmn+BiheCFWWSNvGdQLHDX8M1SpL8LRXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11042.eurprd04.prod.outlook.com (2603:10a6:150:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 15:31:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 15:31:31 +0000
Date: Thu, 6 Mar 2025 10:31:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Message-ID: <Z8m/zE9JvyiNq1HG@lizhi-Precision-Tower-5810>
References: <20250224031754.1001101-1-manjunatha.venkatesh@nxp.com>
 <Z8Ha+T9Vc8Bhz25A@lizhi-Precision-Tower-5810>
 <VI1PR04MB100498A9CFBB48DF250CC73B98FCA2@VI1PR04MB10049.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB100498A9CFBB48DF250CC73B98FCA2@VI1PR04MB10049.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11042:EE_
X-MS-Office365-Filtering-Correlation-Id: 768344fa-9e1d-4bbd-54bc-08dd5cc3f879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7jJYeKm9mLU58pER85gLEhNGXgWLRawKQV2ZMIcopj1KISwRaKnH3S+eSEND?=
 =?us-ascii?Q?aMdoCl3+3LFiLnO+TELj42+vLYDg8VpdipxlO2B2EJTnxvOFQMdgBSWo3cuz?=
 =?us-ascii?Q?2HFy7WmY5tgUMOErd2obcsB5fdTTSXodUClPRv/cTWbh3iQQDmRD8Axe43Wu?=
 =?us-ascii?Q?uIa8qQP1r04pyI2XqSETU230FJZhmhJn7cZkFePY56uyIJme+QSK6PhJReUO?=
 =?us-ascii?Q?uUovaU8BgZneIayYQV79LOYVAP+PYS3dS5P8MhYDjfPRwD0BC7pLJMeBMzfK?=
 =?us-ascii?Q?Q7nwwI8zW+dzQIK7pYMgluGQVeiGpbeUmW5VfpNRjCptV0EurfVVWx0OolxW?=
 =?us-ascii?Q?JiBe1Y8axx9vb8Xojyk1ZLScPHOW1gp+tRla0TralUwXaX2e5n+1Hi5c2Hgm?=
 =?us-ascii?Q?opXk0W5QYUbyGiFgYv6WC70IOefxGk3eafERbDHD46bIpMcRulY9t/cj3ENk?=
 =?us-ascii?Q?OCnpA7Wo1a3fYl3tu0i6enW+zBW3swM2jnSzVRxf7P80xA25B7wGKrgTSwrM?=
 =?us-ascii?Q?leTKYkYoBZ8GwGiK9lQiVSmpD9OmYno7xX+JuwxBefIhErX++eDooAWK4bgn?=
 =?us-ascii?Q?5HV5NUV3Xls6MWflzt2ZLSw59uCqx9gc1nNU1Prrac6A6MoxrFAkh3FNINDD?=
 =?us-ascii?Q?7QBK/ZTpRQfF7FlcsoY/sWUfcgso/5aQS6HC+e0hKFe3V9M3YiaAorUUcCDq?=
 =?us-ascii?Q?I5IASt1XyvliXyl2QQUQr0vGJXJTWjjP/JYMV48IQzs0HV18zciTqp4IPy45?=
 =?us-ascii?Q?xc8mMYHa9kqKFU6GYTOOhmLXQSgMDnooGZij5AY/NpyDX2F0iWuPxL7WzXzn?=
 =?us-ascii?Q?lDghdZlIRFYpNRyvcrAh1hnGs7yAnzp0L/Q+ES0KAVO1mqC9V8WczYMsIWbS?=
 =?us-ascii?Q?MwA+n86g26ZDsVknlXZM90b5OXDdlUORngqNVz9uK5y6QGHbhtCIwZ4V5nTQ?=
 =?us-ascii?Q?Z8Jq750FQX/xNrEtNNqwXzK6XQh7wyW3E64KSxLWliXtsKosnXZ85XItO0yO?=
 =?us-ascii?Q?zxAuUYE+s4Cu+eKICH6LxIXeHsoUg1zj76QJKmi9x/FdUfkkvY0ms3pevuDN?=
 =?us-ascii?Q?p900l0UaqWpSki6g2sxmjo0TWqvst5ZxfWDTFmusslVLRGzlwsaDMiLlOM7d?=
 =?us-ascii?Q?UFG1O20FnDnNNslked/nSf1qZuKo38sVoKHmAgWmKemAbSTg1DliWlnx+w++?=
 =?us-ascii?Q?SuNGcu2SpKIcHs29FHBOaDBcNR3WKFGq/PP0UKosz+sJfvR0fitJOiE1rv3v?=
 =?us-ascii?Q?LMhYEgHIb/p4tK9JrQilY2X4b15yEaV5mcigsTbEP03kUI5mFikn4XRo1XqI?=
 =?us-ascii?Q?jpSPPKhzSio+w1O0UmNMszeThhNJ0syMZDuozMDWAy2bO4G/3at2yaVu6GwR?=
 =?us-ascii?Q?4hYLeziPQVX/in0ph/I5rcrftCYFmIDw0tHhE2VDoXOi/sk+RSdFquNXQZvS?=
 =?us-ascii?Q?ANE9rI0PMA6jm08zDclgHAIgYv3/nav4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wa30K+7anL8DMAbVmgO/7dxo81CruKujE615yjt+w4uWphSCBDICUbcaBhre?=
 =?us-ascii?Q?Ml8wEuk6s4/+lYkpSlo5x+nFHScJJLRB4aybmVG1JI4+YrtbKY7FHFE7eyU5?=
 =?us-ascii?Q?EqfEywwOvbM4UaOjUDYaaO2A1HLuIu0VYjuoQe+kH0XzzDMreZK1Ai0BazOF?=
 =?us-ascii?Q?lCR3ZHIHGypjXOXABTsOyIRRni4dfAbsrey5M3cw1jiz3Z5xgSO9CBfpsGRF?=
 =?us-ascii?Q?jPAQiexPSdYE2BssPBS5Nue5uQFcAq+Cu66zNDO5enAu0gdboSnxx4MIiF/c?=
 =?us-ascii?Q?odAsAnbG51opR8C4gVf3YanpBVxK7S+vBg2l/Sr+gOcrdIghXdZdJke44mls?=
 =?us-ascii?Q?V7wPzxIOAaZNYS6ae4FPZmQK2hZDhC+O7Djd1YkCDRq/uJ0Gxo0ygzG/WiCS?=
 =?us-ascii?Q?jJ7c3ykmWzRdeAf3OaSLtv676lJONbYBvvdvZ+g4w+q72yz0qnjdQH0UrvWn?=
 =?us-ascii?Q?Hq9gZy8xNYjb4zUllKbSHxuDfCLv1nl49rqZ/0SR2LQd92ogdldnL+gUDqg4?=
 =?us-ascii?Q?0H09NGU+mhFeDUac1+j5zw7WCIspdVW17VsTtTHyXNg1SnYHQdZ2aNFMJvRM?=
 =?us-ascii?Q?7hmq85Ool+tSYE0KGSdAsjPvox72MwHzhliHKAGv0bth48UWhWlL46ZXFtTh?=
 =?us-ascii?Q?FmV90Gvuv7S0oaCWrakTT4qRGltloK5RhbZn5BIr7Nu8j2Y2Zbg5NxmG/k4U?=
 =?us-ascii?Q?TuDG3O1fvfugKrsShCWgq8m3+lpr67QLencZ7olcAB5KcDZwwWNunqnx9iWS?=
 =?us-ascii?Q?vcvtLEB7UwnleLPRnWHQ5ytss4ZLPgRJuU9ktgrIJIkslVj+pwkkpq7tOiYs?=
 =?us-ascii?Q?pwamfWxCwiM4nreBAOvCBFrb+XEBcVdd5jUh1IifSiJAZ4BARgZipLtyoLrD?=
 =?us-ascii?Q?lEeIbcpHq8L4NuaHRirSysaJYeBjfgBk1wiMpuLhiDHqwULseemrpJ4iw9rz?=
 =?us-ascii?Q?o9bEdx0p7OZFjDfsSw3z72fWl6Ujk24ct9dkjnHHNfAO/01U/jLSnH8ZC2sB?=
 =?us-ascii?Q?oqJVNXviWxsJlXNSjzk4Cz8UvylJ96clymBht/NWJjvT/GoT6PaMIifafoyF?=
 =?us-ascii?Q?dnPjjTUS4Bc6OK0Sv42L/XeWMo80TO7kTf1Q9Dh3Z01FGKuVrJmg7rPpEchS?=
 =?us-ascii?Q?pQpan1xfZe5Pnuoc+ibJ+5p59bn3Q6pwnhKKB3pCZqjUog7NG0G1Ldjqlor8?=
 =?us-ascii?Q?FE4+GX144jjEJQS2aTZz3JuX1dgogMSfC8kKdiIgVc9Cm8FOvbevGjSDuNDf?=
 =?us-ascii?Q?yt8X+yujzJO7JntkOg9eS7yAHNXEbqrsWsKXo2KoqfK1kQaOUcadyio8Ao97?=
 =?us-ascii?Q?kU4PjSeX0b7KMSifkiaj1iN0dt9CxFmug5t0glJJ0bOCdKoMWwAIxkUnYFpI?=
 =?us-ascii?Q?8Q+BHX1rsm6FXq+cyAiQ0IpzEKXqnf+e29235ghrKTdL83iNOnYzt82c/GFu?=
 =?us-ascii?Q?gsuF49hQy2zTHOKtoB8YqhYbkX7LlrMxBq+6HtL4gcY20rFEQSgQh9Is+U2B?=
 =?us-ascii?Q?1YiaOy210uEgu6eklYdEPHBOvP8QVoTP2am46MdSjkfTL6eqaUQjKA7e/D3G?=
 =?us-ascii?Q?lpJ0PWsk8HoK+jtmK1qcJ+CfIn+fshQzYZeVpV4K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768344fa-9e1d-4bbd-54bc-08dd5cc3f879
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:31:31.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDE74+lK+9I3D8RY/vh4wKBDGIKc1cj4ZDQUsPJS2ePlLMzR8GhvCHm8DEmjqY4ChrzPorPLS1ngJ8pIhQrvzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11042

On Thu, Mar 06, 2025 at 08:31:29AM +0000, Manjunatha Venkatesh wrote:
> Hi Frank,
>
> Please find my inline comments.
>
> Regards,
> Manju

Avoid top post for linux kernel mail list.

>
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: Friday, February 28, 2025 9:19 PM
> > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > kernel@vger.kernel.org; rvmanjumce@gmail.com
> > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
> >
> > Subject should be "Fix read from unreadable memory at
> > svc_i3c_master_ibi_work()"
> > Or like below pattern:
> > 	Do ... to fix ...
> >
> [Manjunatha Venkatesh] Tittle updated as per the review comment.
> > On Mon, Feb 24, 2025 at 08:47:54AM +0530, Manjunatha Venkatesh wrote:
> > > I3C Master driver svc-i3c-master
> >
> > Needn't this line.
> >
> [Manjunatha Venkatesh] Removed this line and submitted the new patch
> > >
> > > As part of I3C driver probing sequence for particular device instance,
> > > While adding to queue it is trying to access ibi variable of dev which
> > > is not yet initialized causing "Unable to handle kernel read from
> > > unreadable memory" resulting in kernel panic.
> >
> > Can you provide more detail information why/how this happen? which
> > varible read cause this problem?
> >
> [Manjunatha Venkatesh] : Below is the sequence where this issue happened.
> 1. During boot up sequence IBI is received at host  from the slave device before requesting for IBI, Usually will request IBI by calling i3c_device_request_ibi() during probe of slave driver.
> 2. Since master code trying to access IBI Variable for the particular device instance before actually it initialized by slave driver, due to this randomly accessing the address and causing kernel panic.
> 3. i3c_device_request_ibi() function invoked by the slave driver where dev->ibi = ibi; assigned as part of function call i3c_dev_request_ibi_locked().
> 4. But when IBI request sent by slave device, master code  trying to access this variable before its initialized due to this race condition situation kernel panic happened.

Write above reproduce steps to commit message.

I think it is common problem for i3c framework.

You'd better change i3c_master_queue_ibi()

void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
{
	if (!slot)
		return;

        atomic_inc(&dev->ibi->pending_ibis);
        queue_work(dev->ibi->wq, &slot->work);
}

Frank
>
>
> > Need fix tags and cc stable.
> >
> [Manjunatha Venkatesh] : fix tags and cc stable updated in the commit message.
>
> > Frank
> > >
> > > Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > ---
> > >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > b/drivers/i3c/master/svc-i3c-master.c
> > > index d6057d8c7dec..98c4d2e5cd8d 100644
> > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > @@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct
> > work_struct *work)
> > >  	switch (ibitype) {
> > >  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > >  		if (dev) {
> > > -			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> > > -			master->ibi.tbq_slot = NULL;
> > > +			data = i3c_dev_get_master_data(dev);
> > > +			if (master->ibi.slots[data->ibi]) {
> > > +				i3c_master_queue_ibi(dev, master-
> > >ibi.tbq_slot);
> > > +				master->ibi.tbq_slot = NULL;
> > > +			}
> > >  		}
> > >  		svc_i3c_master_emit_stop(master);
> > >  		break;
> > > --
> > > 2.46.1
> > >
> > >
> > > --
> > > linux-i3c mailing list
> > > linux-i3c@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-i3c

