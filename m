Return-Path: <linux-kernel+bounces-565598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A449A66B81
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92CA3BBF03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8628F1EF37C;
	Tue, 18 Mar 2025 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UGGPFr9C"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4C1EF369;
	Tue, 18 Mar 2025 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282425; cv=fail; b=hygQGbS8aoDlufFLrtzyaR6QMZKR8e1MVrw4d+PI5IYBdP+xqlFYtfa7PSkaQ/6tKmJyvPaknPYg5VIGWI7mV8EdtHEn+l4b52i0wixsPaELGxBrvitseAVdDj93mMMF+5m5GP93JUudfZ+GUKBQwcJSqQ2SY34iS7hzNrPTsnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282425; c=relaxed/simple;
	bh=U1ADTXSspRdGhlT4suaxsM8EmYwLdRKeWCuuZuE3pwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YvDzajH0WIChnEHIbYV9mXttbx2ONM7cIyXXN8yUe6hzotKV9wW83rgDUpgJeVZXqMCb5z/J4iTDihd8QolwOjX0E/dVlPDYqeKMT8DU8k/MG5E2enTrcqayJ8TwuqBZlpOU/MPR60qY9hltPRJGkzcU/+goPG/cgC8WRi/dmy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UGGPFr9C; arc=fail smtp.client-ip=40.107.249.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOAYx3xQ6BusZ4DWk1wEJW1jDZglxulQ+fR2gW/7Q5LPOc3jP1IxKcoPgo4f/3Tf0ULs6TMgIRnVML4XAmw43xBil3W75a+ffuti8ykFPHT/WimODpgdriHJJxqAcNRnNDEMcXBDlM6emEJptTtG/Wn1xRIYUc1UaOLq86mt3vVrgyXfBB7VHk1/+OCkiA6bAZ2cxgMQAANVPQWIvw3zbwFpO8h6yvD35sIq/D/24Uxgb+ub7nYsv3xfp2ps27bxc+MuGoyVctiUZLbv16LAfkc4T2qwHU+BUMB47Pp+3fwNtjbGXtyGRzOGWwnzAWQlIePI+1FnhW5fKpkNtxw9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBbJZvmC73v6IB6Qg6UErSsuCUHFV/Xl7/4GAe91Zjs=;
 b=teL3JSTsd4K+krlHcuxzqlLdeCBMwYFcPM+JQY8HKCXG57EZjsAr2ZPD7MP9FzgiEsQiLhO6DCJoE18X663GHCnIaSyKo3v+5u2q+v4cxkCA561z1DPNy8pSlRVER56vZH08uoSDyjRRNQZoN3rmdWl0dvHUEAgONf/ccdFF+wLFWdOJF9z+7XblzeP8aBHa+y4EWLSnbdQWdIMXuBBncEJOZmWU6FU2ZQ56SY6S1wRDxpXlkRszZFkGr+yGUTNoQB8GgRimtP64I6URQn9idaai0I2dwSxuWVfoEULKajKjXauhRr5HMjw8Av9DdF30INC8as3v9QACjupXVS+n5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBbJZvmC73v6IB6Qg6UErSsuCUHFV/Xl7/4GAe91Zjs=;
 b=UGGPFr9C8za4mtBmBzQO/BvYPaUYs+AOZcl4fYDaEkjVxaXTEaZ5C/fBEVyuFtCLezH6/58uctqwoW6AfujDQdkM1X1r3z5X0HK++BCsG8lyA8WxJC47BeprbCoKpoT8Lc0AXpOjGczpQcgOt8pXOI2646JL7Jq6fZZowqnt9zELh3cx7vFGWzegYAUQ5DOZBTOoyLyznl7szAOT0/8spUqtpA/XCvyx1bGSrdpvMfgYQLxbjGBczTPrI9F3d1jxHCbql4J1WQeiPJ80qZbwIhvCsqGunbF52havH71CnyWFXpZPtjuanQFE2P/yJWjPRNvPsFDyOYAqBaa7UTvpvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB9802.eurprd04.prod.outlook.com (2603:10a6:150:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 07:20:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 07:20:19 +0000
Date: Tue, 18 Mar 2025 16:28:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 0/7] firmware: scmi/imx: Add i.MX95 LMM/CPU Protocol
Message-ID: <20250318082804.GA1326@nxa18884-linux>
References: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c16a573-7ae1-437f-c431-08dd65ed56cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bbdI6Jr54Pm6g6Ie0Ro4oUW5SzfmQtX47mb/MfcgDbxwYQQzMe1TpXVzADg+?=
 =?us-ascii?Q?iS4bL7si8dvtwKfHKptUc1sGanZEvIWCcGLcyrkPGNSuct4XB9PAYqXalGdV?=
 =?us-ascii?Q?6cGuS9guWnKt5Uegl0aPuN17avE++e4EZoyD1YUPLKF/EH6zYnR7mxC/ocBq?=
 =?us-ascii?Q?yaLUkMIp4hKO5n4VeQ6tUfAWjvoFX+w90MNHBXZgAbC1nG9k3mlorRoZ/oVt?=
 =?us-ascii?Q?khYrhQw2mAe23nCm4YEEfpgFnJ+dMQTNZ5DyKmS1oEUmCfseNpHmTgI5LC1w?=
 =?us-ascii?Q?UvWwjAN2AO8ScAIxDflw53jpnNJmEDT1DscUiguSPmmaeidnOo4435CW/7t3?=
 =?us-ascii?Q?3WFoyOiKmgY2Ozb2wfV90nf71zbr0xgnKIvIrDiS6Yx4HXLED9weB50Kb4BU?=
 =?us-ascii?Q?g/KPPnMMfLcOFiAPoQB96IO/S+cX1E/yxMq3DSehvl8x9mo700d3cXVA0fgq?=
 =?us-ascii?Q?yKtBQCT+v4tBGpDwv2eQNxiEEyiCu6+tF9xTtbVzDuvVr1ieVP1J9OTFZT6G?=
 =?us-ascii?Q?neBqOEU+2SI8E4GM1RN6t3y/c2e0Ws1SQShAja34q5MFAaxFf2P31ziqH6RE?=
 =?us-ascii?Q?R/34e867cJ1MKi+WzFsankiyf5r/kcw7LkmgA61V+xk+CJnjhbvt6YSKoE89?=
 =?us-ascii?Q?LKYG5415vO8KxpB0wfWrzimKgPC95Kpgdlsuj5l734i7bWp19mjPemao4vVp?=
 =?us-ascii?Q?Sg9Pth2gN8cdv/FmNdqASc3ZO2GHp+Qo6ymJt3vVjyAAq5ronYlXhTJlzSyt?=
 =?us-ascii?Q?ay60utS5gK+/cwB1k79Hp445SSRkSuWU9SUOy+94c4Q/W/QSuHf9EcHHCgvn?=
 =?us-ascii?Q?zp/kW48XixU+unUXdoFyILXDW7DRhRJHIYNUFy5hm8nEjCFDOG04WVBFXyu+?=
 =?us-ascii?Q?hUuQv3N0fYFzZ0slbmKW+zHwZMDjWa5ojT0LD4h4/s/8ziO89iwAeK49LtrU?=
 =?us-ascii?Q?mMEzP0k6AWZR4lJI3aIOIZo2z5wGWjdwHW+Nsc4cbdHM1lkukfeGsyFVu50D?=
 =?us-ascii?Q?/NAzt0/fWUXrPWJEv3oDQFkxeY6SAdGW/pmvvGiK57hV5HBtSotDAy96TuR3?=
 =?us-ascii?Q?TXLkkRnYFo1vtDzbs4KVj0fXjH6aXxXEq0UfIROo47E5MnJFP9M16+3cVFOf?=
 =?us-ascii?Q?MQAb4gFy12lmuaWoyF/a3D48k/JyRU93QnNTGU5TucvD6COoC81/aVzZdjEv?=
 =?us-ascii?Q?+fKISt8CEFCtPDOfbTHcSgtbOi0meBeyX1834r8nJFjRzG2bHMVcpXTB3whZ?=
 =?us-ascii?Q?3hhLJNYUyGe9Scq5PL/4N3TpTKDEPYNTuDMBT8PIGNDOVCZhhAP5/ZkKGzvK?=
 =?us-ascii?Q?ZpTSOq2v186k6QkD34uh+xthJnI9fZ+dA2FcyFbEefUAWi/LXJtXWJGTn7r2?=
 =?us-ascii?Q?/ycf31oXCuQJAwaSCMPjQbrElTk0ThROQzA+sRUOlwF4lcYnvaJaa0Zg57sR?=
 =?us-ascii?Q?GJqK3lNohlP+5CtYTzlfalobe3jFi6VHrUPy2HR+n9SzBX7Y3C17cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SAjuMzLGLXEfKKf4meWxrspEuu3XOjJ30gmFGrWUS9b5/7uiGSQkoj4j+1Bj?=
 =?us-ascii?Q?E1SfGYkC1CAcwkS/bFUeiPoVGqEQwfZ6xNU2vXRCYDUKYyuGRH9LdccOFYW2?=
 =?us-ascii?Q?p27R9DKzuidyJW4XQSrKtLZZxOmD93uEWUksC6MnhhtWhUBa5cpV8Bmn46TZ?=
 =?us-ascii?Q?bhMOcvouayHked7fJwBwE76x7YBFWAdjujM7txTGYdukBq8Fc3WRTE5AQyfh?=
 =?us-ascii?Q?62awZfETliMCwN5s4k6jFDGK6Wh59puurPVNG4p+xe9noLxxtQrA25Vr4nN9?=
 =?us-ascii?Q?DmEx0IB2w0IUVsyDA4kUGdB0a2u3G1xsRFKEK+724vMGv2mgmn5cbxGvNkAP?=
 =?us-ascii?Q?TKGEwm4VJzpUyVn99fhctaPOQtBjZ7lajBqrIoAbKfGs2yR21pOT1a2VMgLb?=
 =?us-ascii?Q?f+cUHG+MsgjAEc8MwY1FlYAm1XuVdGeNA++KPpGBZBq1xxNn8INrcgba2Vpk?=
 =?us-ascii?Q?wmDulrw4WOU7lqbJXejy8/+xH0b7yY434v4U326mK7tHsv0rH8NKawUlMza9?=
 =?us-ascii?Q?XXYeHjPGrBj5TUEZoy7EJr+RKYvgpRbTqN2lseuHy5IdmN3DrPKL0d6wlPlJ?=
 =?us-ascii?Q?R65PVFAT1mCYBD8Vp4INVLtXMuwlDoZMSBqE1F6Oz0mzC0Wu3Lu2MzUGUcTz?=
 =?us-ascii?Q?v064ovvdnWLxsqS+ASajC0NyCDBTsYTPdo2ONQWyP7+uZQZtjVjxJVNV43of?=
 =?us-ascii?Q?1tz5olZh44hvDQFN769X2QDGTDAdWH4Xngiw9H7+hAaCI2SezBexmAK+PwWK?=
 =?us-ascii?Q?ZiHkJYf6cJEXpHsm1VTawYsrTTXco5GC/E9QRnX1mGK7iJpJTcwnBoZW1e3b?=
 =?us-ascii?Q?8/LfHN/QL3dDTA+r7uWxrvK4I6TT74qjJIsJPE+UYamRXBtYXzVtjXucPBpZ?=
 =?us-ascii?Q?rV8kTv7EPKPEoqFvIqRY5gYOkm9Lwk2sHxgfbUnEdaTsx91Lbe/cCGFuecUw?=
 =?us-ascii?Q?rQ3BKQQhF3Ud+Er2aOJlzQM1ZxnwIBGiE4xFlfxLpSIeAHB6ot1icaYMLM/z?=
 =?us-ascii?Q?dQ7ZtQmERKpq4Wz+NJhJt/aPdkS9637WlBc4FE7zZkwB1KcX10C2+1yFKEI9?=
 =?us-ascii?Q?jW0Zrp2jlVH2B96v0YjN59Uq9v+rL8M4AjcTz+VqNpsEzWjzxwxorw/+omaq?=
 =?us-ascii?Q?QtF7CYtbIpj9GJIR9/+U79r77XFrcOjwtn29Ng6TxNQGW+kKWk9Ded1E+C9O?=
 =?us-ascii?Q?3KkG7028cAEbgfAKm33kztw2LJmjC+uzV9Tcp8cveasX/QJ1hVcjOt3TWV/E?=
 =?us-ascii?Q?yb7uKwtsE/aBENCJjyu3iTcGOn+4mRkuJ95E9WQKJvw0WLo4Xzmd/lyv9/lF?=
 =?us-ascii?Q?Mf+u9zG35RXykUxuQdxzL81Ycd/pOyeyLtv6Uw7Sli27zapQVG5n6dT2ajOD?=
 =?us-ascii?Q?dOUUZIHhhQXTwMyxhv0NBUzGyLTncMKePNPKsZ3H/tu9khyfyzeiaq5sqoVd?=
 =?us-ascii?Q?WzyD0wwNiFW9FfqZPzWgqYnAuB2SzthILtnPlriMYIHY+mY6+ow5Ezo0snli?=
 =?us-ascii?Q?NUT/1wi6CZYWQJpk4OsQsaqF+y7/h/PN38i6KIH2MrF2SpYcE9f3M9xfHKv/?=
 =?us-ascii?Q?w2EtyA8l/i79RoCoNe9EHhXLAlaYSQEZtyv9/s2X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c16a573-7ae1-437f-c431-08dd65ed56cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 07:20:19.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q994YAwtrREu6ScvI6YpEGoRIQzkPYVjvoH/Z/2SdQ81bS0cYXSSSXov+8YYSpCWbTYAPIVZsFdE0E8MoO/UBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9802

Hi Sudeep, Cristian

On Mon, Mar 03, 2025 at 10:53:21AM +0800, Peng Fan (OSS) wrote:
>i.MX95 System Manager(SM) implements Logical Machine Management(LMM) and
>CPU protocol to manage Logical Machine(LM) and CPUs(eg, M7).

Any comments?
I am thinking to address comments and post v4 after 6.15 merge window close.

Thanks,
Peng

>
>To manage M7 in a separate LM or in same LM as Linux itself. LMM APIs
>and CPU APIs are needed.
>
>When M7 is in LM 'lm-m7', and this LM is managable by 'linux-lm',
>linux could use LMM_BOOT, LMM_SHUTDOWN and etc to manage 'lm-m7'.
>
>If in same LM, use CPU_START, CPU_STOP, CPU_RESET_VECTOR_SET and etc to
>manage M7.
>
>Both LMM/CPU APIs will be used by remoteproc driver. The remoteproc
>patchset will be posted out after this patchset gets reviewed or in
>good shape per Maitainer's view.
>
>Build pass with COMPILE_TEST
>Tested with remoteproc on i.MX95
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
>Changes in v3:
>Patch 1: Correct LMM_ATTRIBUTE return values
>        Update the return status of LM_BOOT/RESET/SHUTDOWN/WAKE
>        clarify sync/async in the Introduction chapter of LMM
>        Update the Origin entry in LMM_RESET_REASON
>        Clarify CPU run/sleep mode
>        Add note for CPU protocol to indicate AP using PSCI, non-AP use OS.
>        Specify mandatory for each command in LMM/CPU per firmware owner.
>        For BBM/MISC which have optional command, I will update doc in separate patch later
>Patch 2: Add description in binding doc
>Patch 3: Unify scmi_imx_lmm_[boot,power_on], Use le32_get_bits
>Patch 4: Unify scmi_imx_cpu_[start,stop], Use le32_encode_bits
>	 Add pointer check in scmi_imx_cpu_started
>	 correct nr_cpus calculation
>Patch 5: Unify lmm shutdown,boot/power_on, update kconfig to avoid build bot issue
>         Add R-b
>Patch 6: Unity cpu start/stop, update Kconfig to avoid build bot issue.
>         Add R-b
>
>Ran smatch as below, no issue found.
>~/smatch/smatch_scripts/kchecker drivers/firmware/arm_scmi/vendors/imx/
>~/smatch/smatch_scripts/kchecker drivers/firmware/imx/
>
>- Link to v2: https://lore.kernel.org/r/20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com
>
>Changes in v2:
>- Add dt-bindings patch 2
>- Add a maintainer entry with patch 7
>- Update doc to address various questions and make it clear
>- Use strscpy to use scmi server returned string
>- Drop extra blank line
>- Shrink scmi_imx_cpu_attributes_get function args.
>- Typo fixes
>- Add LMM_RESET_VECTOR_SET
>- Link to v1: https://lore.kernel.org/r/20250121-imx-lmm-cpu-v1-0-0eab7e073e4e@nxp.com
>
>---
>Peng Fan (7):
>      firmware: arm_scmi: imx: Add LMM and CPU documentation
>      dt-bindings: firmware: Add i.MX95 SCMI LMM and CPU protocol
>      firmware: arm_scmi: imx: Add i.MX95 LMM protocol
>      firmware: arm_scmi: imx: Add i.MX95 CPU Protocol
>      firmware: imx: Add i.MX95 SCMI LMM driver
>      firmware: imx: Add i.MX95 SCMI CPU driver
>      MAINTAINERS: add entry for i.MX SCMI extensions
>
> .../bindings/firmware/nxp,imx95-scmi.yaml          |  23 +
> MAINTAINERS                                        |   9 +
> drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  24 +
> drivers/firmware/arm_scmi/vendors/imx/Makefile     |   2 +
> drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c | 276 +++++++
> drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c | 257 +++++++
> drivers/firmware/arm_scmi/vendors/imx/imx95.rst    | 801 +++++++++++++++++++++
> drivers/firmware/imx/Kconfig                       |  22 +
> drivers/firmware/imx/Makefile                      |   2 +
> drivers/firmware/imx/sm-cpu.c                      |  85 +++
> drivers/firmware/imx/sm-lmm.c                      |  91 +++
> include/linux/firmware/imx/sm.h                    |  19 +
> include/linux/scmi_imx_protocol.h                  |  42 ++
> 13 files changed, 1653 insertions(+)
>---
>base-commit: fb2b3e3bd74b8a3f742eaade06f6565323cf4bdf
>change-id: 20250120-imx-lmm-cpu-418daaa257e2
>
>Best regards,
>-- 
>Peng Fan <peng.fan@nxp.com>
>

