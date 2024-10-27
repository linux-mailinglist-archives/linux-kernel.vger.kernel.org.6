Return-Path: <linux-kernel+bounces-383572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2939B1D80
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036AB1F21055
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03179154430;
	Sun, 27 Oct 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dOZ8QE9I"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1556F2FE;
	Sun, 27 Oct 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730029804; cv=fail; b=J6DoqktSCisVIWfBz8Vn8N9qK0altl4yv3zjt8kL8Hnj7DAlyTb2rV8X3OPB7tF93dn3x78C1/2Y4bDpwFS7/sc+mI+ckSubq9e/yFf9r7tS3EQQIRk6nUR/XtOsrF26AewjHssKoF6zyI7z5JasTLnjI3dqgKIojLG2oba5+1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730029804; c=relaxed/simple;
	bh=+TM44h+DCvmaUzZNIZXMeATrzW/B9WHhTVbV/vxMtH8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PzWXIes8qQrh2PKdJINjaZ55TthZg4mwTQ62TXIX4K9gbLFJJEkTCBg25SkXH9FQNApeNELu6wg4/r1walDNn5WbZhhzlT2M489xDxMRUFSm2KZ5EYmnmqe1XjgyEa0gj6IjLvROapcXijPwf1cuPY6VpliJtyhaCIYGHrUxkGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dOZ8QE9I; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tba3uQTb4Ja4D/jd7OEiXYbSKv3okSR6zDaxR3exbaX778xFSp2Gdg2IrQn0z7hFxTMphEqc7Nr/lkW3zMpRa53DiAVh47RB/slj0I6HAuoKXcej6CweSrsLHphUfQ28vfPqjVmJyXtVl50OkYD5TtGvAZiNosU1ylNGKEMZtTz2E+y4YMgY1iwEMyvKw3NrzhmB1Hp5/Xmn7cB5qtY/KS4wDFstWqEHjp1Hc0r6/lrywfp6dQFgfxldNAWOIO+SH1sNs92vBiINS5i87R7622T/z2l71f1iqTDR9LoH/FWZ2ZqM3los1Mha9AdCO/2f+iFDi6fD4ORblMU53Sl3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6oO6oxZCisTPteVhKtnaHxvciX+hYQIPRyTTGo1gZA=;
 b=FCTz2jfEGG6Ic2qHf2R73nvuZ1RFSCHMBlBf04/+AOQJwVUSECC/jGiAI34pppRkvl+4vppkE9cq/vVp1CpUOOncnrwAXtQUXZn6siFOp2zHezn6T5zKycMiLw0whAJ7IqwNsOAx50vzNY3WiEju6299r34aO1lu9ANaAVBGvQ147ldT4jMF28/R9h+a/EDCsW6KvAEupmbuh3XGDf9TJdJW/HzmmuFn2tdrUla1Q1aV7Pvx+04Z1ElJ5KZQCot4Lx+I7AeIw07IhuICg+/odQDtZhygfI8X+ktPcKjBivO6IQ3vpmi+qp2YwfOzEG5/5uC4Y2jMS8kc7IuaPb6Onw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6oO6oxZCisTPteVhKtnaHxvciX+hYQIPRyTTGo1gZA=;
 b=dOZ8QE9IP2v3+Z8YuSQjSeMrTxlh8XVpIxs3K9km5064w/KKOcRd2+vcWWTLOvyy0moCZlf26rs4IY2Epkz5z7V5aH4uXfF8VEbzAVub3lwxsUzXz2X5iGCd9dW5MMwKbQ8PSNax1aP4S9D3hpzIlR1fk6g9yc2JVJ78OIs2Uc9LHVo3c/1CmoBDeeiQQhKnLx15imduXv9V9JuqcP+NZsk9bWhG2SvBP83AS2hfBA280HUBOB6mFgzjwpah1gq+kb+lFk+Ebs9yF7yRKByvC0WQ79ul95S77R8+PUZ/WHNqIwV7x2XgwyxbT/pH7Hmpu5kUpRx9VV5ONFhDIfgm8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sun, 27 Oct
 2024 11:49:57 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8069.016; Sun, 27 Oct 2024
 11:49:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/5] clk: imx: scu and fracn pll update
Date: Sun, 27 Oct 2024 20:00:06 +0800
Message-Id: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEcrHmcC/22MQQ6CMBBFr0JmbU07YAuuvIdxgWWQiUJJaxoM4
 e4WNmpi8jfvJ+/NEMgzBThmM3iKHNgNCfJdBrarhxsJbhIDSiyUVIXgfhL2cRdRCSwsatvWqjE
 VJGH01PK0xc6XxB2Hp/OvrR3V+v7NpElBZA6l0U2uJJ6Gadxb18Maifgtlj8iJrFCK69a27oy8
 iMuy/IGEzV7j9sAAAA=
X-Change-ID: 20241014-imx-clk-v1-24c26cfa1d79
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730030419; l=1529;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+TM44h+DCvmaUzZNIZXMeATrzW/B9WHhTVbV/vxMtH8=;
 b=WuNlMMd3fCiXlydkEDcs/X8JDU/KpdX7iGq4bx8/p2lMSkCPPf5fgSiI9Jd8mQN3PcAGyFj2O
 SzXM6Ka89MtA8pAUHet/NdsU9XsOGWe3B6Kwr6XNY1f6OgYQdpPqJKS
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daedc51-6549-4d31-1728-08dcf67d7ae3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTdnSkNRV01JcXppd2xoTUc0dG9qV0t0QnBNOHdtSUZXWTE2Ukk1UlRhbkE0?=
 =?utf-8?B?QXRHcFRFMlhCMmFha2lXTWVEeDA1eFJBb2ZBWmVFazZKL25zQlVnOXN0dDQz?=
 =?utf-8?B?YlJLVVNQeWRZcWVwcWFwcVdQdUpodmR4VFpyZkE2RFJWajJRcXZ1OEJBNnJh?=
 =?utf-8?B?d0hFZndJcnNYVHhWQ25LWHBOQ2hPMjZpVzVibTA1MWRRcE4wSVRmV3I3S2NS?=
 =?utf-8?B?VWZobCsvcWI1SkswVnIxU0grSmVyMzJONldBNkFqWXBNNVZoYXpRQUJuWWJ6?=
 =?utf-8?B?Y0RkRFJyTjJoQW13NHNjTmhMKytsdk9IK1c2TEdlQk5XRVJyTkZjVTUrVEx5?=
 =?utf-8?B?T2NYcGpHcVRiVjhSZ0t1QVBZaU9NSHc3SUJreW9laWhNbnVnekxVQVVPZ0Jx?=
 =?utf-8?B?RTRnTTlKRmRTbVYzdlMrYmJZNFJxbkx5VCtrTmRPbmRDamx1ckxENTBQc1Zt?=
 =?utf-8?B?VFBRV3JDR1I5U1NuWnZuTFB0SEZHUDVvMnRTNitIcFZKZFRBczlPbGorZTg2?=
 =?utf-8?B?V1VYalhUSjlKTkZRMHBBTENVOVUxUjRCSjcyTWpZY2pHTlpYRVhQeGxTYlQ3?=
 =?utf-8?B?c25sVzhRak1aMzJYOXJyUmJ1RWUrZ2JUR0JWaDJ1Mm9HcHhhSmJMNzF4dlcw?=
 =?utf-8?B?R1J2WUkyLzBEQWFQSVdXcjNIdG9VSnVyd1R6WFdqY2o5dU9kMWtNZUxXeWFo?=
 =?utf-8?B?ZnpzeDhwNE05Ni9BM0dZZzM2Y3lKVnpOU3Qvd3RDUi9NRHZNWUwrZmZmK0hF?=
 =?utf-8?B?WDMyMmh1MHlSMGgwV1BORDU0NXlEYmhRQkZuSXI1b3ZHUWFYZXErUW42Tjc4?=
 =?utf-8?B?czZCMFBpS3VZbjE2N2dENC9NcGFwVCtySGJqSkFHYThQNU03VlZYaVVGTlAz?=
 =?utf-8?B?TW90bmMxQ2RHVlY5UTBFeXVqL3dsd3RkWCs2OEQ0OXJ2Sm5WYytER2sveEJu?=
 =?utf-8?B?ZktEVjBmSE1qWEg4YnordldlVVF3WmZwYlRUc0dOSkxBOFNpQWZGdUZ0bklH?=
 =?utf-8?B?OUszY3NHakxWNjl5Y1h4QTNGd0IzalhPN3dxTlpwZWtHSEUwQ0hsSXduMzNt?=
 =?utf-8?B?bUlFRGRTZXF5SFBTOUlXSmtJZ1ZCMkgwM0NhbjdpaXFIN0QxcTRxUFU0WHJT?=
 =?utf-8?B?Q0lLR05ZaFl6bWFyNE1IOERtOUJ4MHo3ZkNLZXpxLzBYeDBWOFJEWHV2OUUv?=
 =?utf-8?B?TVkwOHU3SlBDSm9lc1hUK01ZVkU1a0JqS0xqRTk0dWQ4RmFIRnJ3WG5qTmV2?=
 =?utf-8?B?TEZEVWdGZ0F3TXR4RG1Cb2VTS041ZFdXcW5vSEgzQ2IxNE9jeTJHRWF0TTBh?=
 =?utf-8?B?QnhtVCswcjU3dXl2QzdZdkJ3THh4SG5VVURPRU9mOHBlckJ3MHdrSGdtT2JZ?=
 =?utf-8?B?YUpTLzZYTUx2S25haFNNVDFXV0ljOVhtVExsYTNYRXc1SnJ4QkxMT1pZcW04?=
 =?utf-8?B?Y0VyNVQ3ZWErczhXWWt3VFFUVDUwYWZVTCszdEE3Q1lqVi91RmY1cUxScmdo?=
 =?utf-8?B?dmVJazZ4V2VkbTRtM2FWczdLSDZ6QXNqSnEvVWlRTUVEd1hPSzcwUHAyN2lT?=
 =?utf-8?B?Nm5xZVBpVi9uYUZ3Ujd0L2VsYThXWWNVNGNUZDdIalRpVXJ3YzgyeUp1eUFp?=
 =?utf-8?B?S1l3WVdocU1seGswL1M5UkpRU254NFZNSURMTDR5THQ4OVptNlhxbTFsY0hF?=
 =?utf-8?B?YzBMZEswT1lqRTd0QWFhR01wNlBnQ2w5YktJQ3FhMDVlOUg5M3BGaWtuSnJl?=
 =?utf-8?B?dXlKZDQ1YjdtRFdhWUdaRjJ0blRYNTVtL2ZzMURhRjVRQTUxVnZ1ZllqL2J6?=
 =?utf-8?B?bWh0M2tlK0ZQUWozZ3o4Sm9CQ0ZTckE3S0xSbkRra0YzVmp5MXJhV2NrYW5B?=
 =?utf-8?Q?YKrIqIZuSzBCE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1ZUSEVzWk42UDhVaGVVTmpSNkNobzNRUHJ0QzhUd3FLaVVNLytCdkpRMkw3?=
 =?utf-8?B?ODNRSGFHOS9ITkVxOWU2aThiaHVJUWdqRDNBRG0zMUlqS3lRZTJ5MW41Ylo1?=
 =?utf-8?B?T0s3UTEzbWZyTUxnQzNQYlhlU0QwWkNRNWRSbWw0R2QraWM5TnN6UEVmRXpv?=
 =?utf-8?B?dTFaZThqVm5DQy9jektzSEZUWmpQMlJYNXVjVE5icXNlYzdpbi9DVlloNmdz?=
 =?utf-8?B?VkhWaFpWQkpLa2Q3UlYwZTR4clBqeTZYN04vZjJmQ2lBNGdnKzB5V09TQUd4?=
 =?utf-8?B?K2J2Y3NIalNHbHVpa3pDaGRLRU9ISFJ6T215TFFJZDFxZThkMU9tdzNsM1da?=
 =?utf-8?B?Ri84Uy9pM0ZrL3ZBZEFyV0RucEs1VDB6QWs2Wk1Bcy9ac01VNGwvWGdLUzNY?=
 =?utf-8?B?d0svTjhIR2Q2UlUvWGxpYmt3dmxwOGdXakZNTW5zVDVmWG1pMU9MM1BvcDlL?=
 =?utf-8?B?L1J3QTlEcmdaUFFXenFMR1lvUFplYXRYQjRreWpQaTlRSjA0L0VaV1VCMUdS?=
 =?utf-8?B?WjY1MkEwZkNmS3MzaGMzRE9OK0s3MDZEYTh3UXNDbDBjb0xLdWlteU14OFlK?=
 =?utf-8?B?ZTdqQUpmNkFweTZSV1JlMHVqQURiUEFCU2dMYnd1WW52bzJmVEpXNUd6TlFU?=
 =?utf-8?B?RXkxNHRyNFFkZnVVWXd4VThGSjZsa3YzL2pLR0dQRGJzTllTZE56REg2RjVF?=
 =?utf-8?B?M0RxYU52VnIvOE9nTFl1RWU3YmJxVnorOGRFamd1a1l1WkZoTGlBcjA2NjZh?=
 =?utf-8?B?Tm4vVVBnRmxGQWRWY1FzZDNMamR6TzVrVUR1TVJPOGZOREh3REc1bU1uRU5q?=
 =?utf-8?B?bG5HUWdueE9BcUJJeE14ZzRqVnR5K0dJcW9kYW1qSCtuUHJCUnNJblV6ZE5O?=
 =?utf-8?B?eFpmUmdYY20xaGFxNXAyQmhsSXhzQ3pGdlBPVzJjU0ovZ1F2L3VNZDlvYi9z?=
 =?utf-8?B?aENvaHhtc2YrVC8rZGErdk9pbDluc09RQXFwc0xvSGlzS0ZxRkJjMDZGbjJR?=
 =?utf-8?B?UXNXYkR6WWJVb2NBUy9qSERVRFB5NzY2enN3ZDVrVC95MGpSOTUwQ05MSmFP?=
 =?utf-8?B?ejJoWkQ3dHlCM3V3RjFvUm9DMGtDZ1dNQUk4T1pYOFpqem5FMm5VWjB5TU0x?=
 =?utf-8?B?ODdNbDFKRThsOEY4dkZ0TzAvd1A3VU0ycVdOUm5sM1ZoVi94SUJ0Um1nakRI?=
 =?utf-8?B?NWZ4WTNGT2g5Ukk2ajZoc0RIU3N6Yk5xaWpvdVRzTFlBTmNQOEZwMmdsK2dV?=
 =?utf-8?B?WGxvNitEdnNKdUdJYStOa0pybHJsTmN0WDdra3ZBa2ZDNGMxbldSNFN6U3l0?=
 =?utf-8?B?d1liTFlXUzgzeWdHaUd4U1lKTG00UGV3Qjl2QzRjaE4za0w3MTJkQVdCdStl?=
 =?utf-8?B?Rzh6aFJNUGx0a2cwRFB3MlUvUjY0NHNiODdCd3JjTDY3R25UaEt3YXlqNEo0?=
 =?utf-8?B?U29NZjRmcHBPVGloeFUxbFJlNUNnSGMxMWZHbHlQcFhDa2cxSU5yNHZRMjYy?=
 =?utf-8?B?cTFwOGlBek1STDZCT2szLzFGaVJaT1BKWXhZMC9xZU4zNWpaMHYrZnlLOGhH?=
 =?utf-8?B?Mkp1NWU1OGExMGtQVkxhV1RmSXVqWHpmWnUwRkVrUzkwSTlXQTFEc2FRZEo5?=
 =?utf-8?B?U0tZVzM0N0VUQ2JacGRhSU8vTUZYSEZlemxaSy9ob01jeURrTVhqUGZFMGtP?=
 =?utf-8?B?aEEyK0kzeS9sYTNaYi9PbHRIZDl5TEs0YUVqM0Q3bS8vVFppS2wwOWttcStr?=
 =?utf-8?B?OElnL2RBd0JSa1hMdXhyajBaWHVseHBNcU1saS9ScjlzYlE1U3BwN3RKdFZi?=
 =?utf-8?B?S0hEQkY2YTl0dU1RNW05cVB3blNBbHBZc09BQ1FuaHdMUkFwT3M2OVMxemU5?=
 =?utf-8?B?UUJ6cnBWNGUva2JCUU1TM1BFNHlqanFlRVZJOElmRkVuSEI4WDhuMjl1aDdu?=
 =?utf-8?B?QmlzdTg1WVBlWldFaHI5UnNuUEdBenoxRGJIQ01xM1hxY1RzZUxzMlp3RDZi?=
 =?utf-8?B?NFdKRnFLQmlKQnNGbTBVRlIzZ1NrU3czOHZIWGt4b0hMOFhpSmloblpmbmNC?=
 =?utf-8?B?MHJBRVVNTzFjNWtJSnNvcDFyUmYwVjlkMGtyTWlCNDMxeThuajRoTmRWV013?=
 =?utf-8?Q?uGyGdZISjLhmWvfpgv4wc/osv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daedc51-6549-4d31-1728-08dcf67d7ae3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 11:49:57.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tJEK+elmwGW9TwabzX+sJuCCe/mvCrfFFGnj+PzBxh2XMnTdq5uJBh2YiuqXdm4oFXCau3zlol06uCQ6Cy/OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689

Patch 1 is to resubmit [1] with comments addressed.
Patch 2 and Patch 3 are for i.MX93 Fracn PLL fix.
Patch 4 is for clk scu fix
Patch 5 is for hdmi. Fix tag not needed.

Detailed information is in commit log of each patch.

[1] https://lore.kernel.org/lkml/20240228082649.1633083-1-peng.fan@oss.nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Drop some comments in patch 1 per Abel
- Address build warning per kernel robot in patch 1
- Add a new patch, patch 4
- Link to v2: https://lore.kernel.org/r/20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com

Changes in v2:
- Patch 1: use HZ_PER_MHZ, use unsigned long, add errata link
- Patch 4: Drop fence_write, just use readl
- Link to v1: https://lore.kernel.org/r/20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com

---
Dong Aisheng (1):
      clk: imx: clk-scu: fix clk enable state save and restore

Peng Fan (4):
      clk: imx: lpcg-scu: SW workaround for errata (e10858)
      clk: imx: fracn-gppll: correct PLL initialization flow
      clk: imx: fracn-gppll: fix pll power up
      clk: imx: lpcg-scu: Skip HDMI LPCG clock save/restore

 drivers/clk/imx/clk-fracn-gppll.c | 10 +++++++---
 drivers/clk/imx/clk-lpcg-scu.c    | 41 ++++++++++++++++++++++++++++++++-------
 drivers/clk/imx/clk-scu.c         |  2 +-
 3 files changed, 42 insertions(+), 11 deletions(-)
---
base-commit: 099aca1fb909cf2295ae6eac3c2fa34026f1047d
change-id: 20241014-imx-clk-v1-24c26cfa1d79

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


