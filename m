Return-Path: <linux-kernel+bounces-369205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227AA9A1A47
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5381C22E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDFF16DEB4;
	Thu, 17 Oct 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ZZm8pGdo"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011024.outbound.protection.outlook.com [40.107.74.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470221388;
	Thu, 17 Oct 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144518; cv=fail; b=pRBB744fv8k6VYychuaeg6I92vV70UDB5u/lSlfwF33LvZyri97Oest31sZw1wzVrqUjp9Z+giK06EDLqAe+kMwugVMn+m3LZsSGvjhzl7+LPGMn/YuMpNZ7/gnjKqHVGd6eEawayEhMjBYuHAmd3YN7MjcHOb1vza8/57ioyew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144518; c=relaxed/simple;
	bh=ehBk1JzjesCKUG3Fr0DyhVANHOXpNxNR1kB/d3Q7o50=;
	h=Message-ID:From:Subject:To:Cc:Content-Type:Date:MIME-Version; b=TMlZOEPQICvLHqalF3X2dFYAvxvqfmrKGjaXhlVAOqddKC9ldZxNlp7lWu+KLZv8eZEnTc3GmCOOJIshqup2yd8e8vC+qJ5pDt1S/KmxHQFKGYDkF+i4Rym0nM60KWQaqCrdnX/TPL2YydRNWoYsEejBSZT1hJM0zNAi0blaJsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ZZm8pGdo; arc=fail smtp.client-ip=40.107.74.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOEZQUk2m6OC7/wcB8B7cdTNj/odKlN8mDi2bJuiJVVR5Vv1uzGKS3drv/QHbwGlMjyT+PMCVFGBqEFsXc6Q4Bd93MYWaW+UktqW3cK+BW0ActIrov3zbxVtJHyxUaa7xeO0C7Qgm1ZyttAeCcPoPU1JxdQG1VV4abvXMX+bHjFeczdCenjhwpvUEfAxRhU48WOo8pk3iINcyCpVU6/hS9uw9u0gzmtmmg0M5agMcNpNGV4ryeu0a/RXo6ip3NEAV6qHPeVPfukPXSQPVM+KBcqsmb4IHfPROXA67fVcQirV30DygBX3el+q6LiBWPnr/Iy9/2dFmeHtWM04og3fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NLBqTtHqfYUr/MtP1x+YTI6sXXbwsxCzCWo+YblGH8=;
 b=QqOWkVCheg+NkoL/G50P3LT0Xm/HjG+j6bfMRVGFPX5SpCZtd8azLKijq5XEiKbK5Ox9K2YllHPF++FPtH3KD1AHg9ymTW2xJps2wM389qXDNj4V8bX5I4Wg0YRgMl8VX9k+/u3Rl6XAwJ+WwiGgRIjuvlZb2llrJZUjrGUrkCTZKi1J1T8jTyo58wUeDZx4X5NEIGbDkVxz0Xlitewyd8YaksPnlZt2J7vK/vuRPRwMuxegmGBGEoQgFtFHu3G8j+4pnkslGcQrcwshL0Lw2kZBH0OL89H296j2/eZG42/eWnzDFC+o1jT+bizDuGvdzS9q1/Edb79j5XE5hC8j/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NLBqTtHqfYUr/MtP1x+YTI6sXXbwsxCzCWo+YblGH8=;
 b=ZZm8pGdolfr+qhDjyYr+yx0Va5gvrF2qfkFXimE+0N9iVryFnWx1jATNOOvJUxrYXkgDd0fVwYICHoctAhkNpWWzBKNBWkBGX8LkR5MQr1pATMr9ggV7O5HWETq6ZqR+2zjwKC/zUROg7YRjiSPElsuTj3z0NKwX6lHc+2B/AeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYTPR01MB11091.jpnprd01.prod.outlook.com
 (2603:1096:400:39a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 05:55:10 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 05:55:10 +0000
Message-ID: <878quns282.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] MAINTAINERS: Generic Sound Card section
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Oct 2024 05:55:10 +0000
X-ClientProxiedBy: TYCP286CA0276.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::13) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYTPR01MB11091:EE_
X-MS-Office365-Filtering-Correlation-Id: 183b1326-4a11-4e59-b4c7-08dcee7042b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3NvW7LafmGqOOA8+vtmKUzdsm6hX4RoOXqL0ck9XK8WbJc4egQvjX6qq7YWV?=
 =?us-ascii?Q?FDgdRyhxzS3BzGFfGoI0CFSaK2xi4cvGb2KRoCwUM7msecAXt12o9iCL6uWP?=
 =?us-ascii?Q?q5ohg5Vh9CdKyT5Dup8vj24tXCdJXRemO3sAhRkxZbsXRMrk6n6IMmye+y6J?=
 =?us-ascii?Q?uvIElP9QhSw3A8MUhQx4yAlanDIPZNxcQGbbgZRbtgu4Ovpa9RoI+2CQkamJ?=
 =?us-ascii?Q?ER4/3Fo/foJ3yigUYxGmpO0Yvw/T9d02F17Hg78+tZ1uhWv1bFdaFrqHpq3J?=
 =?us-ascii?Q?mdIaWPF2R/MIHWU/BcPpWMJSK1RkeblNwGfoEiMOCcpse0cuPKEPE1DQuN9b?=
 =?us-ascii?Q?NC8zAnpVcZTUNECqlq8M2gy3z2GaV1wM83RoldTY0shREMd+2gYA7GihCLEO?=
 =?us-ascii?Q?/Rntj4KkV0H7MjS3tiwkuqozucgWaBIu306r960wyIoBjqab90u3c+dwHgY2?=
 =?us-ascii?Q?6gStAks3209wPlIXsdFXK9//H74I7kZye8RmsDPNx/Y07zXi1YtKzSW9bYRU?=
 =?us-ascii?Q?+yjkpQWQ2QJFR94XgiTkQvriDdLEjDOk4Gwgksc4f+uDLRlQ2wh0UYpWD0d6?=
 =?us-ascii?Q?rPaUr6R4N03UYcSdGaWHIeiMqsmlXBQSqDfetSmOO1tsfRAG2K+RjWOnpCzS?=
 =?us-ascii?Q?VzEFN/Ft36Xz0kVft7imYHpjzNlTOnBP+z4HN1ytX3XxnQdMvsEUpyXjXdVk?=
 =?us-ascii?Q?QyihaCjrxeJUWU4T3HPzxcULcQ/QMyC4QAT0iPNxeNFhfMmzOPGkLwDTfLJ8?=
 =?us-ascii?Q?oflOuRkdiiRydq8iY37rtwUw/TrmCygxpEEkiap7C1FYRbwDlSq9vgR9VhDk?=
 =?us-ascii?Q?zqNTRZLiuC53CJn8+YAMMhPDiZsXpR6T2N1U8bhQk3ArNYpsgP+KQQeZryXn?=
 =?us-ascii?Q?vNnaXS+z3/iXd4lDwOUp8tktRIxCnUEt4Md52yW0MoDRP90UleuTlVS38Sdl?=
 =?us-ascii?Q?iQInnj96Zu+prZtpygZy+Fzw5qkXEewfyKBETuRqIxF1TxE6/fwnswd2rRPl?=
 =?us-ascii?Q?vBumn9Wb3PeqVql3T/vOBpjCQf/dKMwXbHoZzSiAwYA0ZHJOyyyrG2OoMWVR?=
 =?us-ascii?Q?NjXiAxe+DQwr8BsJ5mApUYA/Nu82a57SLS4MD0E+GBe9ofK4JkhLTXzVj5RY?=
 =?us-ascii?Q?9DRcWiVH3MsMPAo9rqk00g3AhogyRX4KPFRtUjs3HvcMH4095RXoailG8QNB?=
 =?us-ascii?Q?OwOIY6ZHadwpI8TAUEhGkwXrQ+Etaz1MaFkA0Uqfh5OdiUZUy9xY6NtjXM3V?=
 =?us-ascii?Q?4EC31XVEVvNyBMXJsiW5IVcHM8PAlZmsWODMsfP/VO5I+YWnn2zVqxfhwWqW?=
 =?us-ascii?Q?dTG9upyr+QB6kMfoiD7DO0AvlfuH+NC/xAfz6x5aYq0fNwy1gfav7fl97NPh?=
 =?us-ascii?Q?AmOvosOc+wYNHEcG0jZE5k2F/E0x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sPJthS4Lqp+ylamleR/Mk6IsaietxR8IjVz0u2AZg+gdNxStxIgx5fScX9Uj?=
 =?us-ascii?Q?gzQH/uqftNVNmHcYNkfrApvgvzUm7dl2a9Cn0x0ke0rhm1BSrKgFAJmQCfgV?=
 =?us-ascii?Q?DId+Ie/Vle5zLNM35ftqsF3cbHPs1zZk97qysel7BgNTwlFXyQRzhYQPVIiD?=
 =?us-ascii?Q?fuwOSzi1meCGmtcVsr+E2NVRxPCMnI1KVuqDVMLAZ3BzAdIqDn2GABIZgEGI?=
 =?us-ascii?Q?cq9+N+J1Pyy5RZihaYQyyxkPrymLC8xl/lU3PoYNBIDzPOlX01PYdFe71rES?=
 =?us-ascii?Q?OX6w+W5BSYcUvgEqyTbcbIkGndXYEocWIwewNh1hYCSUCDhrxrggeHSPjvbW?=
 =?us-ascii?Q?cFoVks9Qh2pFQC2Kz+ZJ7lO0dlfQYMcHJZVnnz2AGDs+8oHiSCai2HHlF+Hb?=
 =?us-ascii?Q?XgcECyBzJQ1BwYG4kuNYwf6hHyMGXvaWXfM5BiqCsvoIUlBOGc4TS64vKJKx?=
 =?us-ascii?Q?ykUbLwuxnvjIlci5MH6B1z4rcMhzDUfzGAKpXtKTze/DTSkOHJSUWdNHXvPG?=
 =?us-ascii?Q?2pNLFHffCnAhWpPSzp4NXQfXnsoGOkNhc2mZbDIOwwHettk2ipVWv2zNVbKH?=
 =?us-ascii?Q?d0zDNr5SyO03fcBsatAGA7DLhKcLpL/sf+5ms6gw8wj46J/y3Vnn0mpBfebD?=
 =?us-ascii?Q?/7V7rhtXJMJ9L3dloMQr7qmxA++H84MNzaIpIEBZpaJgvQ+sUj4cHiXJB/y/?=
 =?us-ascii?Q?acyQsUsPLF6Mg9njpmaV+IuTvoTUHJYdDw+qP02DkHZ9Rl0sfu9ZgaYdKser?=
 =?us-ascii?Q?R7sRc/F350PtOMJVwDTdWoblMD3sLl3QW5H3Cid72/0KjiFSILgRmGSERCFS?=
 =?us-ascii?Q?9AzQ6G9kIx8FdY+cB9UAUeIWrq8Kpwv38yjfRKGq1vJSwPAlHG2wZ2ENeGkE?=
 =?us-ascii?Q?/HWwPrVbg1AtjIq5JgFebEBng6yXdu8v+Rfu6/t0CQd36XXmfmhge0yY3SYp?=
 =?us-ascii?Q?NgxK+1ZCfrCUhlgzC3INEAMz51OLQbCOfNNzXCBoxM96HVi2IkTnIXS9Isbr?=
 =?us-ascii?Q?GNzwFAAE0PL0UjzQGiGIXaCrrsZ05qq5CAIGNfpkYwkVlZo5fnYQ4UWrOQLn?=
 =?us-ascii?Q?m/BWPZWMQcuI0N3nOIym1AUJizA3Vw+ZPjgnAUnw4lM5Tq1rfpvJH+JHxZAw?=
 =?us-ascii?Q?o8Um2lPVV3tMaYA4f7fhzYbYsTQf+hhKb+oCEB/ZZPphDtmx4qZ4R/CUboJT?=
 =?us-ascii?Q?c9hpt8WQ3WljvvgP+Pt7DYnyNCDefoo45NVn1KM45iuJ95Q5FkiapAMBs4IU?=
 =?us-ascii?Q?EVos3fyJ5DM8IsUcxoQWR7LvHtpibJbrNgBpz+f9Gp1amzfNW24VUgyGBv6p?=
 =?us-ascii?Q?RGQYxny7gVErBMzJrcbtObcYZ8LxrAkhMNyJ5RoY5lAXydADXDROC/Fo+9Ud?=
 =?us-ascii?Q?NVyFD5ikLTOGO7LGM57XPwlgdCHK9L9hrMLuXl9mP0gNf7RnHscnHRUUPYOm?=
 =?us-ascii?Q?vzNblV/evQuFsA4SeP69ZXRHxpL965qTMxfXz9cG9XtViEE2ag1r/8HVELVn?=
 =?us-ascii?Q?qNFuCrIS34iPpVFBstrBZElhezyBkE52KiU+kgkqpbAC6/qBftE7piNyTief?=
 =?us-ascii?Q?BeYGHAEsuycEyrI0edzF+JGMFE9rGgmnGLwNa1xqs8NK7ynXmClCg+NV0sWK?=
 =?us-ascii?Q?Np9z36atLqvb7FvOQx155Sc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183b1326-4a11-4e59-b4c7-08dcee7042b2
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 05:55:10.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ichraqcEeII2IUz4l7oXa3NNXqAH8zuQzafi7sJjWRxqxQKBbB1pOlvtu/NCgYKGMLrfwz61LqQskbI0DIACmKNWkgGb7NhVa3HnEagEQgq6FeH9BA5CDeVo4h8bVy4q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11091

ALSA SoC Sound has Generic Sound Card (Simple-Card, Audio-Graph-Card,
Audio-Graph-Card2). Adds its Maintainer/Reviewer.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..878c23d58c9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21694,6 +21694,15 @@ S:	Supported
 W:	https://github.com/thesofproject/linux/
 F:	sound/soc/sof/
 
+SOUND - GENERIC SOUND CARD (Simple-Audio-Card, Audio-Graph-Card)
+M:	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+S:	Supported
+L:	linux-sound@vger.kernel.org
+F:	sound/soc/generic/
+F:	include/sound/simple_card*
+F:	Documentation/devicetree/bindings/sound/simple-card.yaml
+F:	Documentation/devicetree/bindings/sound/audio-graph*.yaml
+
 SOUNDWIRE SUBSYSTEM
 M:	Vinod Koul <vkoul@kernel.org>
 M:	Bard Liao <yung-chuan.liao@linux.intel.com>
-- 
2.43.0


