Return-Path: <linux-kernel+bounces-566233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE3A6753A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E313AA6BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB31C20D4FF;
	Tue, 18 Mar 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Who8M5Lw"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1E2080E3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304921; cv=fail; b=hwC/M2IdTDaBV5NHot2cLI+dwJXUGDMRozOHLQc9+6nBPRxweWRe1zGGdPA7Xk8eWKmmrGqag9Gr3fmp8I7owIN50L4xZuTIKFqSuuvpWAP0K06qlHNjTqWfxfRnrwOZvTsDzso5U6/dEUxFsP+KxJzwrq9Z2/8cSJ1JFbYPec0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304921; c=relaxed/simple;
	bh=pEJZ7NY529Q4Q78wbyFF99NKUbcr89fBBknjCJNv9Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uXzJg6cxo2N63n3LEaccZvQVVImBduCXUIf9579es/ikKiatfQUhF0Kw1O0frKMyuNBdXmLI94JwEH+6zVEuTYXanwoRytqw6Ov8uXSaZh30NqiuEeZYZVwS/Ee0L1fDYZH3fKOZ7M/Mf2beH5loRvy5LniJgqoFqpGTTXxnbgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Who8M5Lw; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBrkvfsmV+S/yyK56tR/6F6Nr859Bg5qjvfHlVuLMYtolM5e+7g0g+agJO+T6eqvQIIaLcgzq5PnzzxyFaDvXhkOqLYjQMTiQd4YvJ9b5SRKS0gHPW55T5DfS3Muu+sXZD4sRJ/8UF0ireA7lDfqI6/SFsnX70NalpfmwXe0VDYJv/X6j9rgCuX+WQUn9GjsK+fb0e1eZZVE8Zjkq2TgmiPMoxEKJ0Iy5Pb3bSJWsT0I89W3Wz0IHO5Rk/6iN47bkZdWycP3UrxJhpNDKZOvFNsye1zorZpi2taCYkQWAkEtAbDRidutxpy6X/hO67E4YiW9YDBvXjxVxW3f2xQThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYcHTy9CKuNp7wujYfdeESdTaqdeXkGZ4yxDUFtxsIE=;
 b=F5FtaiOzE9/MaJ8A2l/SwvIiHp7qFIEu89+pGGFDxb54uY8H30FtEmyBpGbrpD05ABtUbFmbZXc9FGlfsBVozEK+xTb2iCawJAgZVJPXxsOVJquPCXTQZJXZ8nLDm5H/pRK+4u6ZvKB/EVJetbkAHt6/LJFbgfx3qqD7DAivksABzzG6b3rTK/kN7wvyQsDgdOH82SfoI2wo7JW2fjqgqRfkGJOYw0d4YIkud5iwRTgSuHYv2sl10i0e+2kF0V6B4HH9NTpofKkCIrS5T2yLYzxUcweasFCccej50/dj9qRF5mIhHo5KId/TGTNanJvA/vePAXgUB5uNIsaFe1O61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYcHTy9CKuNp7wujYfdeESdTaqdeXkGZ4yxDUFtxsIE=;
 b=Who8M5LwPYzBgtbccFi92/3UIdTk/x0paEQtpMx+R1M15ockV3z+/79N8+LT1GjDkJfuVCC6b8BEFy3d7vc7ryGZ5tGvPBuu2DHVWOQFek0AC4ww46hE1koO5PtImV/Yaa0B0OvWmx3Fvm6623D9tvxYDBq9538jBfti1Fx47UCC2i+Vp4m2TK7PQK3J/uRlIWmeDgVaaYe/WBb5dA8CXG1ors7mkbr+eM9bmiGb2cNAN/PvQrFi9x4gukTvBEspUjNp6CCaAqzTHDMLqbxAhjKRpgQfLkVtvb8vPRMU8XzLiHJ+6bTG1xM23f6zguXoH0rehQKja1w5uCOWfEyeow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10374.eurprd04.prod.outlook.com (2603:10a6:102:41e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:35:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:35:16 +0000
Date: Tue, 18 Mar 2025 09:35:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v2 3/3] i3c: master: svc: Fix missing STOP for master
 request
Message-ID: <Z9l2jeCB4hYiTmHk@lizhi-Precision-Tower-5810>
References: <20250318053606.3087121-1-yschu@nuvoton.com>
 <20250318053606.3087121-4-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318053606.3087121-4-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:334::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10374:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b31525-c2d9-4d89-83b9-08dd6621b7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P/CEiz0J+mi2wP6247aTmzWta1KIQIse0S++NQ5brh7PzY+GlH3jXUgV8yWh?=
 =?us-ascii?Q?BVbSAUEVuJcEIcxYDH0HTHy6kH+NRllPOP02CEbX+kTd5/r6mphASW1syZXb?=
 =?us-ascii?Q?nVdpckgWxLpe/JPirrhSigOv7eVkRDg3AmP4WytjF1s9Y0mbJoxLr5jfLvFU?=
 =?us-ascii?Q?ZLMJl6dwrjNUrzPG69V8ySnwEprbUpGcW0TRQ0ihiYb2Rmvbl0JUiylVcqXB?=
 =?us-ascii?Q?PGRkVK9IBxnNRxerma+pKKFR9DCPcdjYUW/vhWrSuC6wSYWnsEKv7DgFUJ9h?=
 =?us-ascii?Q?W9zJYw9Bmhvatg3Rnv076HIM5HXAyHbYBvQpG5xmROegssi8LA1OJ32leq3m?=
 =?us-ascii?Q?YPef2EycXstr/FYbfXr/RUM3gdzBmPMlaCN7poI9o90/xONfHcxXGAaZ8pmL?=
 =?us-ascii?Q?AC7+hYqt0ipbZJMwXR1xMYUM/EkRadA89SMsOTF/wZpYb8sNYG0S9cXqZNHb?=
 =?us-ascii?Q?2f9ZJNsrUksigsO1MVxR0BLj64cVMGmAOzdLoNcgeGWHxgFCyUYb8KfL6qX6?=
 =?us-ascii?Q?ENLqiM5XIDQcwhUdJ7/UhGLijB28tZfeszVg3dhg0ytNrE9TWrZlLbhkoOD7?=
 =?us-ascii?Q?YcTjKejxmdMKzEBlbTBvhItA6MSzvKMT1Ba4w48nK2uHpqgZv8VdWubuWAYW?=
 =?us-ascii?Q?whjKR0GQ3OwtkkdKFh3n27FsS8j6Hx5T7W0TukgVPk2gu2WQ8/DTtRjxjJ6A?=
 =?us-ascii?Q?CnO1KyBIytPdqK/qNqavyouZCAfPi9XRoY0dYd16TF9dVWCuJrHIL36EcPU/?=
 =?us-ascii?Q?fyDFgpg59+6cbUj60sSyHjZ5kRQcbQMpUIm45Zqacuqm2WJNuRyA12q3Mkgm?=
 =?us-ascii?Q?fW01dJFzEHKYVFlbHGP+1wO0QMy/Dt9rSIIuJn175JrmBRVwinhtM95Zz8r/?=
 =?us-ascii?Q?TBUmgLDF0Ik2cudz2zEVy6gl6WkqFRe816T54qrH5f4dcR9RdSDZGwuSakUl?=
 =?us-ascii?Q?GvJRDqSQtDQuWoNDu0rIXIc5Q5qfDJvgHhFbeZlB/rg9S9z01pipTCmdqlZl?=
 =?us-ascii?Q?uNYZb1TEjRYfc+EVGIbloacU2Mif7RA0niov60A0B/kKo5BwfabYM4zWP/Ih?=
 =?us-ascii?Q?2etuG0SXkUtUudWwQXpO6gUql2uuAJmq63K2vFC0+Neee46n/gWSZNWpCm3j?=
 =?us-ascii?Q?tkd8qZ1PTVktBDLO2mqX3fAyR9LlzD8DaDVW+WqdXQrez25HYu3up/ZBbHf/?=
 =?us-ascii?Q?eJ9kpE6RV8wM/Bs8Pdz7xgvNf0VOmuo19cSqyRgK+sw78/pSufltCyIlUt6q?=
 =?us-ascii?Q?pWvaqKqfZpMe6R26PeZp28mFWRjrEWwbUi4rJRSBoceFQETxRGaOc/9QHdm7?=
 =?us-ascii?Q?SrNrslOlFhiVWq9nQ4eTWLotM0ZTt3bByiNNBybELKd6pRODdX8kY+8H/Igx?=
 =?us-ascii?Q?i1XvUu4uCX0ejqf0VipUFjNWwc9JtDypwdRwUY94t947SdOaAymdabCvNaEb?=
 =?us-ascii?Q?p4PdXZEPKVZIpcR/HBKyGy1A7VwJrp6O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?txd8QUjwmfL2khN7rM67uwKzyZ3m4Ax9CELkvSWEWGphMYc8PiAxp+C2O6JL?=
 =?us-ascii?Q?Hlg3bPGoe+p2Ur/siG2Ay4m0kd/xr0RuZyCMLG4JHxtzGHd1RFn0htEX4PpE?=
 =?us-ascii?Q?SZNtZDWe9NSWuHGb6KBpsdQZrhd2HIzItmI+sJZPvEcvt2DRw4T2iO/Y3bcC?=
 =?us-ascii?Q?xV1daP6yN9xKCnsFeeJIcgQ9T4rBB5/sTuN002pPLMC2tIQ4RZdVqm1sPY3h?=
 =?us-ascii?Q?OKitVUYX9Q7uCz90SLX2GeS9XzLuqWxwrSEq4KvuSnCKagLHGSE01T4jMsCz?=
 =?us-ascii?Q?Zz03TLDv/O/v5F2bLDjnodFgtEkGa372nMcVadhPA6AMlDEpA58JqxG5XrKn?=
 =?us-ascii?Q?RbwLpglvBbFIWRd41GmIoc7cYhW+tJsYvEm7gxZPF9T16JdgMywhzXFY0k8j?=
 =?us-ascii?Q?n6DQcIbyf01EgG20wuGm6QWaXc3n1cz4+26afWoznWdX56yo/9tFasousCsU?=
 =?us-ascii?Q?28aZWZATMdLFqsS1iPvfTt3G27mPxZnJ5h06YEaILpIl+mT47fIMHT71EeMK?=
 =?us-ascii?Q?gEVLfD/hEG4nxu8rx+Ol66Sy/wwDOawqOsBc02vPqgY4H2hqDDIXBRK91LnG?=
 =?us-ascii?Q?EqZzMVRAVeicNdv9y8sGh8J/RZ5zZZkD0HhCtffZE5ftuzGVva3FOsdfDG4a?=
 =?us-ascii?Q?oz8pdpwY0J/LiImdgA0n7UXxHEKiOKHyRaW662qApbUUr/n0XZNyfiNzpwsJ?=
 =?us-ascii?Q?uXkhNKEoLpl4or+d2BMHhDjqPnMEe54MkM5mgjVBZ91DixVyGiJf/BKTQbY+?=
 =?us-ascii?Q?IzDNEsl+gZReCYtFP7UQLFSAQH84cUeB/9/p38c0BHLxaE9zShmbRuckkmQs?=
 =?us-ascii?Q?UK/oiqo+YHhBzhy1QJPcr/ylHBlDWLzeoj7E3/aUbGvMCZ0IM4xO9JpXzIgT?=
 =?us-ascii?Q?wtIU74/DAU0E+68gZlpZzcig7o8i/Jw9P5pSOenpCQcw7JHjudMgTfWCq6U3?=
 =?us-ascii?Q?smbTMNpQikmtlFJaZ2oAV/3nheCCrZSXvT+JURtcI6A0+/A+26Jz/FGPHoDX?=
 =?us-ascii?Q?aCdWVCO6i1lLC6zbjlmOAiJrBdurJkRGTp7LUm/ZRmKOZVjVFvG2VUViMlLb?=
 =?us-ascii?Q?nSabNIB+OOEoAaPO6AD3Iei5jTofeBoALpbxbgeoBnUaeinvO45c4/gU64Qj?=
 =?us-ascii?Q?QB7ZvhZ64J10yjpXnAYsHMmS7niV26/DupPzTChYPIDQPsVk6qyMLS1lcCwA?=
 =?us-ascii?Q?/WWaAUUIPTwKZmFb8V9tDAuFda2v/a7jIOZ0dwIW2UZ1iCO0LgyyOzf0188s?=
 =?us-ascii?Q?monL/Q7M35r9okjihLs67caRs+cudzyqhSRCIKOeVyXOvKjHKY8k/mq5BDqs?=
 =?us-ascii?Q?6QFf7Rm8kuAd4jaQzw+NaEbOFbwxqLJLb2K41FFoNYF5MxJufM+RBU3f4ryA?=
 =?us-ascii?Q?HfLzrpr+/Yptc6Gz1VYhxpHLZx9z0kTkWSfnW9PvUapgFDj1AZnTOUORgrbx?=
 =?us-ascii?Q?KOKwzzrquHBZvKK6NMvuI7lWWKBy4C59W05knN4p904ZdzgK31WizlbByy2v?=
 =?us-ascii?Q?SwnIfV/hLKE3XbbZR3MyTvTGosjJL52BYZAfNBA9+RCnud2tN5lLpZ93+5sK?=
 =?us-ascii?Q?cf9YMUpmpzKi2Mr27Pk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b31525-c2d9-4d89-83b9-08dd6621b7b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:35:16.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9l7C7D6hfs7VahaKPPnK0VmAqsrI+/pdq/Rx0hvgobQZVu32ADKpdRgn1vS/mh9YqqLpHV+QloJ/isZPGqCAxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10374

On Tue, Mar 18, 2025 at 01:36:06PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> The controller driver nacked the master request but didn't emit a
> STOP to end the transaction. The driver shall refuse the unsupported
> requests and return the controller state to IDLE by emitting a STOP.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/i3c/master/svc-i3c-master.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 57b9dec6b5a8..e0cd3ce28b7f 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -592,6 +592,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
>  			queue_work(master->base.wq, &master->hj_work);
>  		break;
>  	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
> +		svc_i3c_master_emit_stop(master);
>  	default:
>  		break;
>  	}
> --
> 2.34.1
>

