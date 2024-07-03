Return-Path: <linux-kernel+bounces-239864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51998926633
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B97280E4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCC1822F8;
	Wed,  3 Jul 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l63O/Frs"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42833282E1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024386; cv=fail; b=TEtaM/xYPvw+nF0DabMJAhzrXlLvKqLxNmuZKl77DaDlDJyHnJt9k7eS+R4Grou2qC3wwKQGpFUqNL5qdxKLT8Jb1xlmiXZSsfeN47DyNCjJSEjB+RXsL2/j/ou30ADsceMJB62x5omAiifS+9iCkKAL0nDQnQMBE+nRyFHyoG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024386; c=relaxed/simple;
	bh=Gs7wXChJqaTLzE5lh0TEaSZRZKEc1pkI59kk7LP1ze8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nSeFFwk6cGONC15VBCmu3tuwlltxJnsQjwHo1GRwDY+5wADit15qMt9iYb+z9f0Cj5zejuQnl1Q6K0uwIKF2jq8hX9V3j7QgdExovc9KxUIXuNGZfNY+mdWuXyioiLXV7fPPNfvIXGQ/QRmDacqN21cQ09xCsvt20VCE+Or0HO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l63O/Frs; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7FJ/6lfYsJ/58lNbUhoNWBgpx7G1LlSLNHTLY4jYsYcfMN0JHZtyV43S9t9NWU2zeRsB+PKk8Sl3cbrd18f3l0AyMpzX4bFeo0j7r5RgNHZdkdcxRmtENF84g9p2oWTMQHJFlRWxOF4ieLElXQO5V43qJg6TmM/vNqF4ZzUBoGO3UEopFUWBsynyvBelVwZ/owjXIzNE7XbpzfsxIEjbCQNwU6lmsRXbiBbolz0Rud9slY413aBuxwLwPMuX8XPfkW6p3sB4fy7aOFCWeHxg9d+lkNGCgFrLIO4iAAMvl5cpbJuE4sT1AjaiHqkhw9qBiBPfzZcSn+i+5URo/dDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiMGaSdwi8CrmbPKBdzCI3wWPztvyWNa9svQfeECg48=;
 b=dgUuRZBqBFyQeDVW4OG/1Gsj+SdDtFRTTYOhQdZnMApsdtNff0cPwcL87UevnQgVedz3KwBTzym1Hrop5Kh6jLjrB7venRj8zjwCCxfyss92b2Ci7UyWZszMVuzHQMDYvacv9iDOuQVqwsp5IG1lWOjY2goRSdNVJPlxdmix97gLby70aKd7M9v2XgHKuxw6UVnbpJbWOQbFQ9O6+KywMUWggru130THWD5c+9u5oVFJW4NmwTc78A4AP8vq60B8i6xWOHbtffvPRlgatQz1k9q8KA6gT+qjaP9PyV/IAfFmvwboStdh4THfSmiFdW1OxYshtpxkiD+kGbXMUIjBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiMGaSdwi8CrmbPKBdzCI3wWPztvyWNa9svQfeECg48=;
 b=l63O/Frs6sUHOQMDiruV35Uw/W7t5PkTHpxYuoJrh2VsJ39qRwtFF1lggK3zCG7WUqLV+PCiAPSvzbf88z+c066OV4LeO4SfDicopXQyOthKshNUBxq6ItBgez3VwnVY+AfXLwIOQMKlY9b2wh5RvU5NBKq76+09MsWiUOlHfsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 16:33:01 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%2]) with mapi id 15.20.7698.025; Wed, 3 Jul 2024
 16:33:01 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-imx@nxp.com,
	Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH] irqchip/imx-irqsteer: Add irq_bus_lock/sync_unlock handlers
Date: Wed,  3 Jul 2024 11:32:50 -0500
Message-Id: <20240703163250.47887-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS8PR04MB8676:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e48531-021c-4db6-685d-08dc9b7dce13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uPOohj3JHFDIZyvU0HElcRBpv4yUoeTM5sMKx+WxreDLLjADAgpnQlaShQov?=
 =?us-ascii?Q?/T+jdjNVDH81hpzujerN3odRd/kT/vvD98BSk6/oDIINZOnsLCSpUqcNj3sT?=
 =?us-ascii?Q?ANJl4bZxHIhTqF6+k72aGMMQoyWHRj5tVbT2mre9YIlzljCHrmb4lm7X2w6D?=
 =?us-ascii?Q?1gl/fiD87T6JgBLfJTbF1QRiKcj576JoNR2AqnOYTNJggHYIOmbfh5vkb87e?=
 =?us-ascii?Q?7+TUfy76lFXMdNBQ2QpU+29+U4HeO2xD9t0s5zUQBaVxSiaq+SAGw6NKqWTt?=
 =?us-ascii?Q?nGOgF9hI/+cBEW4riV3FmSwwOtv1SqyXeKrP0N1cJ71qAoLc5Nj3yakUaEs9?=
 =?us-ascii?Q?MWi29Snz1MIRpOO3+EKIwfvhGbrSOxboaDttY3+yDwQ2pMfAl/WebCqznCxk?=
 =?us-ascii?Q?6whEEvIt5sVJei2eApiK2XySnNN1nIsSlRDBtR/dYF4yWQH8Auq3EH/WxYsc?=
 =?us-ascii?Q?wkegxUb7+RQ5eFODTZLsavzcuaRsEMXldRN3/DPdB0yUXaDlZwgqD1XMU7Sw?=
 =?us-ascii?Q?i1jNujF0Hls9MoIWfbcfymiIoXDDuD7uvYadi9hrjqbBhPzhnsR3FcAqQkGl?=
 =?us-ascii?Q?OuPS5TM0W2/eppOBBBi42B7VU2eowejxSr7PCGyEiWazr0INfdyY/iqMmgm5?=
 =?us-ascii?Q?8hCuYVGMnDGzIKm16EH1SY3+m+KTqvX8jzJ8Ra1ZajTyH3XOx8olq+o2SrfF?=
 =?us-ascii?Q?6K0fSmFR9HDuCVJ1+cbYakKE3y6AzT2ozWhmATd+uWtpUVu8ICWh7j+G32+a?=
 =?us-ascii?Q?7NwnbEak4u7BtkjNoTrp2eIflMKqlh+agLaseh1bWSRhJzZRALeNG4XhTR8Z?=
 =?us-ascii?Q?b+fqGiGVi+2t/QrQ7iCe9nPlKHYCjksxMmxIMl7H40dKyXvguvgXHP/4AAYX?=
 =?us-ascii?Q?sItROfmAXUD+aB5l5uWJjAJwZTW9H0eFX86PswciOgdnfJ+EMzawpoLxITTS?=
 =?us-ascii?Q?7/Y05V2hSTrTXglmwJfMxnXoaMcRGrT3S056d9VidECfiO3mPr83uEa3Dx58?=
 =?us-ascii?Q?cUaeljiQtqJtNgm0anHPLwspdE0iSecBzZJjaBGLvVWqpgCscMUJwidvqYXb?=
 =?us-ascii?Q?1muuJA5dFWMueWgMWsEj7SPQwSvIEG4vRyk7cFjEbj4Q43qtDKPVSQXXR68Z?=
 =?us-ascii?Q?iCE1pGrjlLUeVyYjpek2XwML6Eqg5jWgKugZxUCYwiCo+WSdB8jLxFkXnPSo?=
 =?us-ascii?Q?FheHBNpxekR5f0snpFailb/9Z5WUQzYsLnt//vI47c33zfS1MRPDMjY2dMCp?=
 =?us-ascii?Q?KhDjjYGO//yLsnJwpqEyuySyA5l7jwJOmlcsI0TveWoPkqnrvFbnDz/d+YIi?=
 =?us-ascii?Q?axHjcZrTpuioRrQ1k3aUBcdupTLJ3JscTr/uvKfIY0AZDpcmGJqRuFgkPa24?=
 =?us-ascii?Q?Eow62vIw6A1WzXK2GSxH+LoIJ7JbfQpy8kX3lwYHhR/QWXAmIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ThQ+NKcp/ZdAgCge06KPMWyI5iEgDCb/14fIXLuCbnoecvVn1CM05Jha8iS0?=
 =?us-ascii?Q?CFaZgT4QMUiXWzmt6qq/mZYDq9TmhCwqe0LStWsXIUJYgBkHanKK+0Hxhq1k?=
 =?us-ascii?Q?8LI4tv4UusMZaJtmPOnpuOjfP9AvEP89ia8o9B6SCyvBCM6h+JFohFvYvrdU?=
 =?us-ascii?Q?2LygGDLNTO4U95XIxLtpCjo0R4/sUU7dCxDPrSH63JF5mBiv6Eh5A/QUjJPc?=
 =?us-ascii?Q?M5aU1ojCfusl2faSui2k+IomuAs76O8hr6sUBDoawC3q51DmeEnfIa96ivmL?=
 =?us-ascii?Q?hnQtrGOem7hXuRREjCn2qvl7rMbDWMJukykIUhe7rJ4B0m3kNRDa4GmtWfnZ?=
 =?us-ascii?Q?AI+qxUFEzQVutNPjY4UQp+MM8k4LpM3rBm8T86EkDFeT0PFKkPUt1Xl5uGFx?=
 =?us-ascii?Q?st1WeNdwRPHQ69KGN66ocdg87O8W3JrhQ9MMeQigtru4pNzvGBNYhfTTE+t+?=
 =?us-ascii?Q?EHMpQeNNIfHhFjvmPOh/bGQ66gLw8MxX80ELBrlLv7JJLL/IQ5eQnn4OVUbx?=
 =?us-ascii?Q?Bky8ZPqyxHtn4Jgn9FwmKRW9aX3gno6Lc6xIDKTmCoxzgghgtfw2xJNuXElJ?=
 =?us-ascii?Q?fna82pJ1z+4Ztf7/z9EdMnCTmFBFGfJI88znH5SC3wj9GvhTdLGV4sCb74MZ?=
 =?us-ascii?Q?dMH/8jN0s2LKS+DiX47WMasF+n7Z7TSPAn42HMzecUas1muWSd90LKhqMesP?=
 =?us-ascii?Q?Evk7V+xOPqiT/2Mg7eJzxA470K50a8mSiS5fEVUCPZCrJVWT0FiNt5CxosZ1?=
 =?us-ascii?Q?7UNLUVoXy4zXYN9rtDRdY02yL4Dy+w8ZfkILPwzzikK0GjrBxnpTiiKpB2WP?=
 =?us-ascii?Q?j7h/B8abQo+18YPDf80btfseHGMa4URjUCGMi1OOBU0Yer6e0OnYP5SzO+sl?=
 =?us-ascii?Q?QXQ0NkeGYviz3OcDf3xXmF7RsMJOa6X43cJolhAGEF5okIE7B+X0ZxLoXeZI?=
 =?us-ascii?Q?ZMl4S/T2f4T4F+PMx5ojzahC8qfMAWk8IxTWvj6qywg/iO/zcA4H770pgqkw?=
 =?us-ascii?Q?j9QEZ6jZX6fBDy/2MV23u/qBYQyncpV0yH0g3MFPwM16y7jtPv5cOkjpCzQ4?=
 =?us-ascii?Q?zIArAfyM83Tzf46oVWZDBZ9T0H+nMPz95yXr+vMi3c+9x6bxlTuofgL2OF/j?=
 =?us-ascii?Q?nKNJWRPw1lAX1CtN7wFjIc2UQnbpCqORvk/niyBRUAPP8/56KKNH7nlclTLh?=
 =?us-ascii?Q?XNt/vuvusKey+7oqwL0rR5uHFGVH7zIiYYO6q5Z0uEbxQK2ZwwiszZNcK3bv?=
 =?us-ascii?Q?xYx17xTBQyDdNLSlbaESWbnpabXZ2b4SVGQ4V8G3kUcQOFkR83XTkwDnezcz?=
 =?us-ascii?Q?amUXG6iT3gb3IX1MAiSqPE1i2bZLsPAqBTDi5eq0kdvJ+NljDyHpyv3U5gDc?=
 =?us-ascii?Q?hv1bbPq7nRyKUUPMC6EPlbJfQ4azDAQ24IEfoa3xhSpm4lmbjvsOkfyNMJev?=
 =?us-ascii?Q?dllgDUFkSNgcZyyoutAaYQmNXwdkVV6vpROW9g1P2rPZTcOMqp98fN4nlTvz?=
 =?us-ascii?Q?OAEAEqjgovbPaiJawCTSWLEOYPDDaqQ0c86JR1K03GvN6rc43IODcZw8IjTm?=
 =?us-ascii?Q?8hGihSWyagZcAOCLhWM0Bmh2C38nvOGKTdWm92ms?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e48531-021c-4db6-685d-08dc9b7dce13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 16:33:01.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUNNy58FfxLHjgCfww8YVPrwTuxKbA7GM4lqOg7XAI43VXsagghroYecmMYt+A31N/4UdR770/Cf5GrwsdAvhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8676

Add irq_bus_lock/sync_unlock handlers.

Without these handlers, the power domain is automatically activated during
clk_prepare. However, on certain platforms like i.MX8QM and i.MX8QXP, the
power-on phase may involve sleep function calls, which can lead to random
system dumps during driver probes at system boot.

By adding these handlers, the actual power-on actions are moved to occur
before clk_prepare, thus resolving the system dump issue.

The following is the example of system dump on i.MX8QM MEK.

[    3.135799] BUG: scheduling while atomic: kworker/u13:1/48/0x00000002
[    3.142270] Modules linked in:
[    3.145349] CPU: 0 PID: 48 Comm: kworker/u13:1 Not tainted 6.6.3-lts-next-g5a913c7fc95d #1
[    3.153616] Hardware name: Freescale i.MX8QM MEK (DT)
[    3.158678] Workqueue: events_unbound deferred_probe_work_func
[    3.164529] Call trace:
[    3.166981]  dump_backtrace+0x90/0xe8
[    3.170652]  show_stack+0x18/0x24
[    3.173971]  dump_stack_lvl+0x48/0x60
[    3.177644]  dump_stack+0x18/0x24
[    3.180964]  __schedule_bug+0x54/0x6c
[    3.184628]  __schedule+0x7f0/0xa94
[    3.188121]  schedule+0x5c/0xc4
[    3.191266]  schedule_preempt_disabled+0x24/0x40
[    3.195887]  __mutex_lock.constprop.0+0x2c0/0x540
[    3.200596]  __mutex_lock_slowpath+0x14/0x20
[    3.204870]  mutex_lock+0x48/0x54
[    3.208189]  clk_prepare_lock+0x44/0xa0
[    3.212040]  clk_prepare+0x20/0x44
[    3.215452]  imx_irqsteer_resume+0x28/0xe0
[    3.219552]  pm_generic_runtime_resume+0x2c/0x44
[    3.224174]  __genpd_runtime_resume+0x30/0x80
[    3.228535]  genpd_runtime_resume+0xc8/0x2c0
[    3.232809]  __rpm_callback+0x48/0x1d8
[    3.236562]  rpm_callback+0x6c/0x78
[    3.240055]  rpm_resume+0x490/0x6b4
[    3.243549]  __pm_runtime_resume+0x50/0x94
[    3.247648]  irq_chip_pm_get+0x2c/0xa0
[    3.251401]  __irq_do_set_handler+0x178/0x24c
[    3.255762]  irq_set_chained_handler_and_data+0x60/0xa4
[    3.260992]  mxc_gpio_probe+0x160/0x4b0
[    3.264840]  platform_probe+0x68/0xc8
[    3.268506]  really_probe+0x148/0x2b0
[    3.272172]  __driver_probe_device+0x78/0x12c
[    3.276536]  driver_probe_device+0xd8/0x15c
[    3.280721]  __device_attach_driver+0xb8/0x134
[    3.285169]  bus_for_each_drv+0x88/0xe8
[    3.289009]  __device_attach+0xa0/0x190
[    3.292849]  device_initial_probe+0x14/0x20
[    3.297036]  bus_probe_device+0xac/0xb0
[    3.300876]  deferred_probe_work_func+0x80/0xb8
[    3.305411]  process_one_work+0x138/0x248
[    3.309427]  worker_thread+0x320/0x438
[    3.313177]  kthread+0x110/0x114
[    3.316409]  ret_from_fork+0x10/0x20

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/irqchip/irq-imx-irqsteer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 20cf7a9e9ece..f81e4ff3aec3 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -36,6 +36,7 @@ struct irqsteer_data {
 	int			channel;
 	struct irq_domain	*domain;
 	u32			*saved_reg;
+	struct device		*dev;
 };
 
 static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
@@ -72,10 +73,26 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
+static void imx_irqsteer_irq_bus_lock(struct irq_data *d)
+{
+	struct irqsteer_data *data = d->chip_data;
+
+	pm_runtime_get_sync(data->dev);
+}
+
+static void imx_irqsteer_irq_bus_sync_unlock(struct irq_data *d)
+{
+	struct irqsteer_data *data = d->chip_data;
+
+	pm_runtime_put_autosuspend(data->dev);
+}
+
 static const struct irq_chip imx_irqsteer_irq_chip = {
 	.name		= "irqsteer",
 	.irq_mask	= imx_irqsteer_irq_mask,
 	.irq_unmask	= imx_irqsteer_irq_unmask,
+	.irq_bus_lock		= imx_irqsteer_irq_bus_lock,
+	.irq_bus_sync_unlock	= imx_irqsteer_irq_bus_sync_unlock,
 };
 
 static int imx_irqsteer_irq_map(struct irq_domain *h, unsigned int irq,
@@ -150,6 +167,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->dev = &pdev->dev;
 	data->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->regs)) {
 		dev_err(&pdev->dev, "failed to initialize reg\n");
-- 
2.34.1


