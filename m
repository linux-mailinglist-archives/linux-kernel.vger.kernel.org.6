Return-Path: <linux-kernel+bounces-538864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12CA49E04
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFF91670C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A8270EC9;
	Fri, 28 Feb 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z09pCXru"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012035.outbound.protection.outlook.com [52.101.71.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B45189B80
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757766; cv=fail; b=RclgkaqT9GXUgsgY/4yIEerBF0sFFtwxDSdigNRKm6+pV88f2Kd1ZjCIRsVRLCXBNCiDm25znfjETPtOsvXrlYEVlA8F9QhhqTni14zhmX4tnRGm4bwflKXkD91UJrQi5jhUtDcNtSBdY2AvVzCX5M0tmuVSs6PrThzSUSGDuvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757766; c=relaxed/simple;
	bh=8nhncFK8TVfUNjjx7+LTOFLzpKmW9HBl6J0TF1jUsJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CSKLTgp8fImOvz/sdTBCeY5oEfvJ9bg0X2QJP1d+CDrrS0a7qoqXiw/hNZ+A67L8Ed/TXLR535jsTRMb9ioymJN2SO/V6bepKPnXLX8t/cZBsG5r7ye9nH0Y44XjOIUuhyuhNcsVK3Ksf5X4cSSyFZhTDye0b8um+GTTuFCB38U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z09pCXru; arc=fail smtp.client-ip=52.101.71.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paWk/nfLYVvWDXKRENHNPQQVvcxwNaMiqShwcEBid2XA6dVBB2DmEhe86lM2iG5UlBZ31/IDPAdPHhpRTzXOx6f6+ajxlVUj4/E6YHZ32taqJ+jq8APjz+xHbNLGjsTtplVWsMr9DNLR+l0uJBoD1aTG9kXCtMp3beFSHOUkn4h9WqMkO6kKDacIf0o7jziB4/u6CzUh5eEA7DqKBWtNmfO2xuCz8GiBTGEBVdbZMsfGvjSH8YWqXnpHnJrhg8GU5Lj6T3rRpfy+Sxvb9phRkEw7TgNQ5S1pO6nLv/GyYLXpNbmr3Dj5RhUKd1hAxK2z4QGxNTdfSIMR5VfTdhmH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz5fe+RwBUMh3U3Ed4nX3yt410Tfdhz2uZUnZRQLxic=;
 b=Hal0cYms5r2w+NBiFSY9l/Qu6TvTGPd6/LcQP6BRn1P0ux5Kmpk7JTr/4C9oUNrGet85QC7gFnBux01HOhGgr1Clw7tzkneHlM6L94BP4WqWeP/hG0PYtYqAs6Qak7hqk1SK241c5WxQYfBFUuJdjom5H7+X725jy4T0P8zXmwbBwK42L5eT5uzqyt+b1yvwRO8xMD2bIqAcFbr7qdK8aSsGhIhs80v1phqsMSMkRdR7USu7R5ZOggqaCrjJyVKf96Na5ZxP8BXKiEt2o/T4nZg5j1jCVc1YY46GrtzSzlYuAZPHbVjo2XWmafkvW1EwcsJllKaU73UsTSwMrZNTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz5fe+RwBUMh3U3Ed4nX3yt410Tfdhz2uZUnZRQLxic=;
 b=Z09pCXruip4SqbKN1d1EIoR8ncFw0onjxnJOaa6hRXSpCmAVuu87AKdel1tpA4YiYyDBvHHme5+VVgZz8U+kSBemY5Q3SCI4rvhWvDzbVgyq7RWURMudKYewXMWzVoEzTehFDC7xyXTuRDdJ8lCt+RWLMmh6OqzCoj1yTFBXWsshrGLG4biG55OMwGgx1rjikZV1fTqAhNuNafP6OeyBHse2rOnmZQ+DXgrm2VdE5weiERw4xa2AzyomvwTJiffpH2YzSN4XFr/4W0VkIDRsd/OXPVUR0o7Rz8/nAQKcCLOkhfM7zf+o/2vmTpSKQ7LvUAygFozszg+m6YrB17AHZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 15:49:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 15:49:21 +0000
Date: Fri, 28 Feb 2025 10:49:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, rvmanjumce@gmail.com
Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Message-ID: <Z8Ha+T9Vc8Bhz25A@lizhi-Precision-Tower-5810>
References: <20250224031754.1001101-1-manjunatha.venkatesh@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224031754.1001101-1-manjunatha.venkatesh@nxp.com>
X-ClientProxiedBy: SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 314171e9-585c-4b7c-4f7e-08dd580f77b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4rnVE06SPvlVMPBoMvnJFcCdyQJk11y2rGDNdc4Ulg8zLKR5OUvefqMLNVs?=
 =?us-ascii?Q?YcuydJaJFsfH0EQPT288o6EPyvQ63UG2fFqUiuCEubuVfR5lOAQySJhCRQ2V?=
 =?us-ascii?Q?vTHVeO+5AacFwSuC5yi5PMIJFP/kbF4VaWXFJe7dJgxc8TtNZrX6MKrgq6Qa?=
 =?us-ascii?Q?OZVWEzK32iUUKwgzzetaRZ90FySCRMk5qbdob0oJduYRJ14lDCSZWzjoXR+P?=
 =?us-ascii?Q?LwmPQIrqTsAiCSRdk4sGk+XSGyAhajyx1P7YSwtSg7OtkGIwVswBOY6SYAsA?=
 =?us-ascii?Q?i2KjvweTqBlNREJ4oLm/AtmSLQFYI06wbLYPjXv3M86hAKXXHNy4w0pkinha?=
 =?us-ascii?Q?QJJB/OdyYlZlFRT5TqnQO1IXsX7pguDElUR4AeNGLZ1bxop9SQoP+2sk7XPq?=
 =?us-ascii?Q?71/FrWeQPDh7KL9plrvwi9s+Dt6zUA1jptFe9uzYvMMk6Rb3i0G13n6hBfiG?=
 =?us-ascii?Q?U8fEI4cWXbXiVNFBGSeiW+ZNJVQfO0dWZRlZP8QdPTZBgn47TynhuATSVlwQ?=
 =?us-ascii?Q?qpC9wJpdaFWkclCxCwlcwOsnTVX6qSlh5JnANt6T/9+jsn88WV/HO5hNh0es?=
 =?us-ascii?Q?2ssqmqqzxW3Ac//l+6Yx0x5eHaGvTMWBCq6pdmhiTdFyxcS62gtaJ4cSI33X?=
 =?us-ascii?Q?aIHeuhWO6ydf7jMRDrBCznSnks0wLeX9wIOUhFKYzOPMI/o9oIilyWnCMMB2?=
 =?us-ascii?Q?7WTVsjIciYJceeAfcCTOFM2WLd7hf+i8aiFK/SHPo/d2rac7vMJZkY0WTHfx?=
 =?us-ascii?Q?VmYgbq3S9viVvZVBV/jgHhuZ5nJrTnGUUY9rbByzbJAamjoPS9jD4pvGh2x8?=
 =?us-ascii?Q?8jiPh9n0DOOp7Hg2hNqRtQfpiLsQi7QFe8CKTxEBp2/qIz9VBR4U/RWxycBO?=
 =?us-ascii?Q?nAu5R3f0fKpiTISql1m6SBikxsKJAoy/PzkFsx6azXon5CI1mxFqNRIbNAk3?=
 =?us-ascii?Q?1ZLFpXz5SXwHTJxUuF0fQGYPzl7yUppDyahFWtN+hmhavdoA20bQSjIa7/d0?=
 =?us-ascii?Q?4YRA8Flauf6QB2UGppyvyacvLzzcQCq8W1ywTYezaQjscupj+4VUs3jpN4Cf?=
 =?us-ascii?Q?DaHZn6GD9JHfOQZe8zP7OkJdFN5hdaxMNe5rP/plNVcRtJ2e93KtXSPowwgI?=
 =?us-ascii?Q?e3svh5xjPldeEB3jk5h2Pp26Pq3DdfdTh2o2jNFkZFfqvuxJbFxpVzH9QT4D?=
 =?us-ascii?Q?F1BKemLFmlQNXKu+3IeR9x7JTmxNmAiwyT+9FnktIRj+1O+trF9dVK5uppNq?=
 =?us-ascii?Q?VTXu8fz7VVyep7U0rE/214MQUSrtubtYDHgeYBhnLDYu+s2ne7mX3nU94KjT?=
 =?us-ascii?Q?7FaKGqgoa9xM1DSVZMbRBeKjhaPwg874UxcwxqH7IxNWS1KIMTDF9V8vn+zH?=
 =?us-ascii?Q?6YpwL9Txngy00NNNoZq2acAYC13wUQRT8O92UMH0oYBR7OB2ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RF7HyY3Pv++NL2zyj1L5zV4sA5nvwt06f+58DlTbO5N+RCODcMKYr4fnA0Ae?=
 =?us-ascii?Q?T7zpsrNB0ov3QshYj8rjf2MuzaAdYbQ2/Rf0oGrEegKUWNL3pB7+9Ih079H7?=
 =?us-ascii?Q?7eUQ3jg7v5IAHa8QjUv1/X8Uxs5ekNwGMgmLP/7SePrPyM6B4mOxstTEfgMb?=
 =?us-ascii?Q?unj45iduIlRtmLpR/0zb0fagdukYjY442mSPcvQJUURLGmZtwxzKpnV1f1qh?=
 =?us-ascii?Q?goGpX+VfvZCnrEtcDqIc8f0OvRcFgaNwrhsIcUKlmRLZ+6OTXcUNrngna5bY?=
 =?us-ascii?Q?vA8PvVB3q3WHCZpM2RLqI+gkCCR+Js7pMo2teP3EFtSs8p09LsG0APUaJ/f4?=
 =?us-ascii?Q?zvcT51Ai37ftKcw1gMSO0lF7ltDOZx1G6blanLkgx88Eie2/5Docq4OdWe8l?=
 =?us-ascii?Q?/p/BO9IqNNZcmLbYBzSEe4PSnFlONxLqyEuadlnDDrr7T2C3+RYrCVfTP5tH?=
 =?us-ascii?Q?zuPgnh81Yt9V0en/t9YQlXGfpQUY8/N7SZa0tzUtEQck9fUDozZSFCB5ne6W?=
 =?us-ascii?Q?T59qN3vvlueyX60xXLLKOfIiq5mqBn6DWUUC9a2krANgLdhseVpJCYFT5xZO?=
 =?us-ascii?Q?hHM2r3DC0fsk69b0B7zQtCeePSSDntmasLAEau/zm50Z2woHVo0dBCjHOgZZ?=
 =?us-ascii?Q?8V6lkPfoYr9V0InEe9VONf3rIyhc8zQxknfh33wzYHlCjWvZufwcSTWl6m8F?=
 =?us-ascii?Q?AzgDX92SovNQlomWHGjnJtroDd0JI218RgAJzhiqPjOdgE/w7rNuCHDFr4t2?=
 =?us-ascii?Q?Na36JCvdduJ7qGNG4sQHvM9+zMlZw8NDt4U/oPqb2JKgf2Wx2qKiVAgh/7jj?=
 =?us-ascii?Q?L9ep+r6SoX/XDv8lcAvcATil/h2fm5UXJ52l4TZXd3S8gFw/cskZCENbWInS?=
 =?us-ascii?Q?sMTNXk5d19JES3qdU3QEOw2SBtTI7IGEF/+pzQAib7kf8A3uVlXOev9tfv7p?=
 =?us-ascii?Q?12NXOVdsJh85tY/hl6oQJFh6ipJLZeK9+uh2SsTFZmaW07uyhERHr/9GhTlH?=
 =?us-ascii?Q?xNxUujt6wDFwlbFjI93ywIosMV3VtCmPbNtK9fK7ul1bBbe6sH+0oVajNJft?=
 =?us-ascii?Q?GINGFzYhlVVK8fguAvjPy625O5HdNYF22kNwStP9Vg+S2/IYIpaBJ2E2vi9L?=
 =?us-ascii?Q?0saAb8UZVimCGi9/uJG07ZDdtF3t654uKugHi2VRH0nU27MxlDDeNCGckkY2?=
 =?us-ascii?Q?TdKM+s2oljPlmnYKud0PGi6hbam+hrNhSsxw1SRYGM/pdIeeiJFSenB9if0G?=
 =?us-ascii?Q?j4gRGlMJrNGYJD2C9Avhl3DG1p+evFNErWQQiApcjyo0+7HGoG36aItSijG5?=
 =?us-ascii?Q?/lFuicVJp03Qrkw2yOWHG0LnJEH+gJ25jqz8O6jZSwYJNxcoq5M3w8jw4+hm?=
 =?us-ascii?Q?sbHxhp15xvDtOMaOmccyi7vc5t/Wz8aOyLOjR339XnVBpS6LBkcLoip0rvYE?=
 =?us-ascii?Q?wsfSKooNHNoNS+C/PGuDLyp6nGr1fUuGXkSCi6ERnFLWMDXQzN8Hv0Ie5D+U?=
 =?us-ascii?Q?n0NTrEwmohTk414WP4B7heRC7qoQZEr4MFLw+0CbGQDwBW4GX/nbL6yj5dl9?=
 =?us-ascii?Q?QfQrMIb7ccpJJT951e2dtBkMKoQnYvcjMthiytoE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314171e9-585c-4b7c-4f7e-08dd580f77b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:49:21.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kr0FA0//YsvDx9nRfIkCNLjERUmE46snxzZHRxCXDM4p8H5x1Jdj8PLnLokOYeu/U+4O1O3YG09muVfq27p3xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783

Subject should be "Fix read from unreadable memory at svc_i3c_master_ibi_work()"
Or like below pattern:
	Do ... to fix ...

On Mon, Feb 24, 2025 at 08:47:54AM +0530, Manjunatha Venkatesh wrote:
> I3C Master driver svc-i3c-master

Needn't this line.

>
> As part of I3C driver probing sequence for particular device instance,
> While adding to queue it is trying to access ibi variable of dev which is
> not yet initialized causing "Unable to handle kernel read from unreadable
> memory" resulting in kernel panic.

Can you provide more detail information why/how this happen? which varible
read cause this problem?

Need fix tags and cc stable.

Frank
>
> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index d6057d8c7dec..98c4d2e5cd8d 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
>  	switch (ibitype) {
>  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
>  		if (dev) {
> -			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> -			master->ibi.tbq_slot = NULL;
> +			data = i3c_dev_get_master_data(dev);
> +			if (master->ibi.slots[data->ibi]) {
> +				i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> +				master->ibi.tbq_slot = NULL;
> +			}
>  		}
>  		svc_i3c_master_emit_stop(master);
>  		break;
> --
> 2.46.1
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

