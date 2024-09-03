Return-Path: <linux-kernel+bounces-312306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FCE9694C8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356AD1F234EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD71D6799;
	Tue,  3 Sep 2024 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NXUxadaN"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C01DAC4E;
	Tue,  3 Sep 2024 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347353; cv=fail; b=cY/RKJm4wk/uVOQMUZ/luzYEp50Ky1dm/3PeDD//M9yB77pJSWl7fDLI+dDO6PmXYQdL3nKDXIJCGtalYGE6xUTvRxsKc+TZSKBwBM5WcUpXJlsXbn1vde5mHKqP/LZ8i5cl7dbofSC4U7X7kKqEPi/mcbwHMvpOyGjpeJ1gkbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347353; c=relaxed/simple;
	bh=T3ouo6JqrBl6gRPM1+ATPUjFrSg3pBlFk42i6jRn360=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jgglhxOh/xUvQG7vLrXQveEdYfYaed11epuHIrlr4c5qpDZIodY7aIHy35WhmsJv9NzGLgPI7galD4D6EBi2hg1/FzRNKXoIkFrK1NyOF3nRPmWyAiqT1jWBMB8s0Dt9l+sv4T/+Mjp7MoNm5vTnkb+RRivx4LqaMK7ygrI92So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NXUxadaN; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxDr9bpekZ500lflB3M6/9vvaIMS05yc2Hk712k+FYbyd+izx7gfzbW254uOPK+qK7kzufAK846pS/gQN0/okxGwZgql0u6Ndk7/huhFBmojkyVr1ieAPL7xnynRC+/ZiAEFvm53Js+iSrIDK0Jb0KsRqGXg4dBqoTLoWVHg++Pde4kTV6k3UlHjgtOtsCpheSRzW8aswytptjkAsu7IHkSPjbkQsHZ8lOuiTUtkZ6NMq7N+Bhpk8UxsPjBO/znnfuMB37u5+dq9J84qAHtXkPIo5zehrr2hnnSrLBtYslqtOJ90t7WdvqiSDnjhOuB56rh9pPfRHP9tdADHEr1tQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgRyZ4DuHtL7XpIdQEzc+Mi21S2zKMHIAFVlVqEyWfg=;
 b=ZuwM/OcqgSaLFjYJilDQ7q6E6PWvIwC1CIokz3fAyrFKeg5IuSD0HF39nVQ86K8ywBC9Ev9145b6/xp+7vUUW18AZ/YwcsyOyElTDkuB//DglubLqehOOr0lw3AYhnWGZ1eHSgwj1Rf783rUQe0BqWUPZMc4OpTCQppF41nR6eu45s2FIloZXAvnC3IOFVjVAzhDpZz2H/OSWqc+FR+lhUMtb8Mzb5coj/FgTJkHMhkwmMbUc6beDEZsv7Z+hP7KuQPvpFCbkA/V6Dg79ZGW0dCZzxO6qL2kelNqldcFRy0nY/MMdE9tAuRTy2cLlTfYL0rheivFed60dmM7PMaG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgRyZ4DuHtL7XpIdQEzc+Mi21S2zKMHIAFVlVqEyWfg=;
 b=NXUxadaNKvj6S6KgTtZfy9+khN1rwwzt+jFkmYplzb4fPL0Ps/UfIQydXVSL7zQKVkn4pDfeIlFmWFZ0AeucS8oW4JxNHiMSpo/yV9fjDZE0nlV0K3AHsovdkRtD8jtibH0II/o8HLDGYnTOcNSXFJCV1z4J9KpadARwvEdAL81dcmaO5LvevRRCiz1CyLsAAguNfZkaLjvxKajphzMrFvdU3jLQL5A7yQ6pK/LQ9RsdAKDewBn2Ik9dLmChxEvRr5J4kqdWIVlWhD6vGMYp87CGLrzIZxl+ZSoMkHtO73Pt4nw3HMdsGFb15X/3vpKUsAfjSzdFVyMwCuaoC5IscQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:09:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:09:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Sep 2024 15:17:48 +0800
Subject: [PATCH v2 3/7] arm64: dts: freescale: imx95: update a55 thermal
 trip points
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-imx95-dts-new-v2-3-8ed795d61358@nxp.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
In-Reply-To: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725347874; l=869;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=vnDFkfL6Fc7H3M7/D9xgaTW6JKdWqVWqPpFMwXxRAQQ=;
 b=5VnO8xh6crJ1xmyFf3Sk/s8GgSdIIQy7w8T6qoqxdV/BwDLlfw48sad157j7b+o1LyOAaTZuw
 iYM7EXAhIikBsAJZ193HmMMTM/7n9aywSp8lkjDF1nL7Q3ZYHJh/If3
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: c1169dee-51fe-41f0-95c4-08dccbe74daf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDJKKzNmT2h3M0tIaVNwSWFDdW5CZVlmLzV1ekxJU05qQ0FxckJjc24zZ2kv?=
 =?utf-8?B?QzNIZmtlZWsrZmlNbWl3eWUwRzFuT2NtU0swNmQyQTkzZ0JkYlJpOFYwbUgr?=
 =?utf-8?B?WCtRMUJXZk9PaGRnU3JoTmFBbDJCNXJWZWtkWEs2dXpiTmxyeGlHTkNBVDRi?=
 =?utf-8?B?ZmUvT3pjRnlLSjRJOFhJcXJnRzhiZ3NVbWcrVWlwbWd0QlBxb01OVmRnenVa?=
 =?utf-8?B?L0k0UmU4WnlYTVpZdWorb3ZIMHV3S0ZHekNhNW9JVEJPSTc3emI2VkZqUzhT?=
 =?utf-8?B?N3Y1dW8vcWVxNDAwMEpZeVAvekRpM1RuNkZRY3JweGpkVE1QNUFJKy9kYXZN?=
 =?utf-8?B?anBmQk1JL1dMdGFaRTQ4ZUs5NmpSV2VxWk5QclA2K0xrd0wrYlAvQVhkK25q?=
 =?utf-8?B?cVpaenV3emdzZFg4VWhGd2xhWnlRcFhwYWwvZjV0by9FdHk4S0pnNk83THpx?=
 =?utf-8?B?bldXV1BQYWNrYm9GNjdPa2FFaTcvV25USlo5b1NlTUY2ZlNXNVBuTlRFbklp?=
 =?utf-8?B?bXFtUlFNR20rbjk1TWJPMCtwWnRMK2NybWwwWVF4dUZIckQ0R1hIYXJwaXlp?=
 =?utf-8?B?Y1ZNWVFFbDV2UUtkZmVEekNScTBtazNaR2tsaUlMcnFCbkMyYy9oOVpxK2hv?=
 =?utf-8?B?c20yY0tLdHZiNWc0bzZMcHJZVWRtV3Z5YnVDZUdUU1ppOVV4L3ljSkwreVlJ?=
 =?utf-8?B?ZDBlR2kwbHFmdE5tYWNCNm5RZVFiZUUxam1LTzZ5eUN1U2VhYjNTUldzaEFT?=
 =?utf-8?B?eG5IeVdRRGRmYWhacWJxQk1pM1pwWGJ0SVFoQnJLaUJKWU9ybVY4SUV5M0wx?=
 =?utf-8?B?bFR4RE9aMnpYeUN6WU5hdzBoaG9taFZnLzhvVEV5MzZnYy9IeU0xdU83RGdB?=
 =?utf-8?B?NUMybnBvWDI2WFhwaG9aaHFxUGNFTEJlTVYrUVZURmY0eGlpcXdzLzA2Yitn?=
 =?utf-8?B?TXdyWHViakxVTVYwVDhCZVZpcE0zZ3hSckVjVXo1UzZ0cXVmVHcwdzBpeXZP?=
 =?utf-8?B?Z2VUVU05NWRpQzByVmE1WkdNdXAyczNUdktGSnRLdU9EQnV1Wnl2T0xEL1Mw?=
 =?utf-8?B?aXZld0NpQytaSFZyblFMSkwySzVRcGV5Uy9nblZYVGtFN05JdjlsTmJrRUwy?=
 =?utf-8?B?N1kvc2hucW5xWEYvbEQwUTA5TlBsajRvUkowVnlBQSszVnBoSHZ1OExkMkt3?=
 =?utf-8?B?Z3NwTkFKQ3l0THRVT1VjVzRveVVydzVScUtvL1FWWjFUYkRtb1pDUkVuanRM?=
 =?utf-8?B?OWtnK1V3d2kvbDVlekZXZDlTYnNtbUNCVVRCRWJTYlpZeDQ2cDMrQVpnOGh1?=
 =?utf-8?B?QnByMTJ6c2RqNk5hMXFZWHUzUXdpdEwzU1FQQzBSa3E3emtMbTAxVUYzTzZL?=
 =?utf-8?B?SGFlU0VzK3lSVkxTbFZBM3FGL2piYjdYUUx5QUhnZkRJTjRrVWd5UXVwS29Q?=
 =?utf-8?B?ZmJ2MlpSd3BCSTRYMCtxeDRiZkRQcjFKOUw0bTdWblV3TkZtY0hFdzJ3SGVw?=
 =?utf-8?B?VjQ4djU3MWpYVmthaEFsMGFpY3d1SUJQWWtHWkxiTVJPMEFrOXhQZmhuT2xL?=
 =?utf-8?B?RnU4YW5KZml2Q2FHMWJJK2N0S3BCNTNVVzJXZ05IUURpOEV6L29paHN2Tmt2?=
 =?utf-8?B?VndEcFRwMWF4R0NMSDMyVC9oV2V1TGM3WnZXbS82bkloMWMvdnluNFZEUGZl?=
 =?utf-8?B?Y2F3dGV6SS9OWHpqM3RBcjJNTElzNzYxRmNyWldVek9uUzcrejZGMC9CTFJj?=
 =?utf-8?B?d1JBcFVQdUdpTk9iVldlZVhpQ0lMZnQ3SXQ0cTY0WUo5WGxEN3ZBOUtoSWVl?=
 =?utf-8?B?TE9XWVUrZG9ZWkJJVkJQS1hrZHRQMzgycTUvdWIwZnE2VVJXcEl5eEIxTDdm?=
 =?utf-8?B?aTduZ05kcGpsK0NXeFlDNk8rYlJ3N0ExelFxM2ZOUnkwaWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nlk1UVJrL2x2WHBEODY4SHdYNU91WDhUKzdMbnpud2FwdUpma013aTlvem5z?=
 =?utf-8?B?OWZMSm1aaEtzYmNzeVkxd3pxMmhKcEw5Y1d3Q202V2dUQ2ozTHQ2TStRVXJS?=
 =?utf-8?B?cTBWQ2tFc0NHMG5ObFliNnBadUxRYmRXUnQ5MHhkQ3ZHSmlpZWJ0aXNUMnpG?=
 =?utf-8?B?MXZRVDA1MTZndjdlZ0Z4bk1RL1NPNSttUTNpMFNsTHNlT3pQSXc2RllPVGZw?=
 =?utf-8?B?NWxqVVBjbGwrejdUS0l3VitSRENENkVMcmxjZHNIQlhvdUtQZGNXdG9BYm91?=
 =?utf-8?B?N0x6dDdWUXJPc0lFSktNU3I1bnUrOGY2Y1p2bmt0MW9XMGJIT3E2RnN3YUhK?=
 =?utf-8?B?WFdDSjBYU0Vxb0IrN09BNGpXU3ovSGhuMVVCcDNRaXNJcm1ka2VIbDdQNjBm?=
 =?utf-8?B?WGN4Y0M1aVlFYy9POVpNczR6M24vZEIxRngrRkI0cktHZjZtOW14eXlXV3RW?=
 =?utf-8?B?NS9SRlZraUVmUDZUMzFCYnFkbGQxZmt3WkQ1WnhyMHIwRk9kQk1Ta0VpeUlr?=
 =?utf-8?B?TDI0Si9SMlNyTFRnZ1gxQkRzNDNtelF3cCt2eFVrNGZzNTdiVDEzVEhFT2dJ?=
 =?utf-8?B?LzhnZHhmejNmMVBVaWRzZkJrUE00N3FjMWNhUXBrelVWbmwxbm9icXpTeDlD?=
 =?utf-8?B?bTRQUDJRWGcxczhpWno5ZUxFV1NDamxqQWFNSGhZemE5eVEwa1R4dlgrSmhI?=
 =?utf-8?B?MzlONWhvTlJnOVo1NVU4c1IvL1hOMGZkc0o4ZWdNeCtOZnVERVovV1dPVmJw?=
 =?utf-8?B?WmZXOVU2Zk5kclRjSlBvSVNkRDFleTA5S2NkczY1Nk1kWXpzaThYODRpTFBL?=
 =?utf-8?B?RExwZHdJV0xvbEh4VVcrS3NEbnEyZmRNb3BFSzRQdjg0S3FoamtpbVVDbHh4?=
 =?utf-8?B?NTBRa2I0Sm1aY1RQUTRUM0FmczZBMDg0MnhqZTNLSWdjOXd5dGFDQ3NWRzU0?=
 =?utf-8?B?M0N4N0locFMzSEhqczF3SStLamczVkozUDI4NzVqdFllWVQ1UnVxeitJb2hz?=
 =?utf-8?B?a05VUlppOVN3L0pzV1RnV2pTQThBU3ljcDhhUStLYUhHMW5jczU5QzRLZmFX?=
 =?utf-8?B?TnQ1YXZmNUprVmVXVVE1b0VSYm8zSVhzL3ZocGdkdXRCRW5KSUpPTUE4U3hI?=
 =?utf-8?B?NjJIbU1zd2E3RE0yczY1RUJPM3dxQXk4bm5WeDhHSllXdFRndGRzQ2JEcTNv?=
 =?utf-8?B?WUhHUUdHb0lxRGtuVS9CRzhYY1lXczl5WnZVUDJFMlA3Q29vZVBYcE1ZQWNi?=
 =?utf-8?B?aFB4a3JOMWZDTEtoVW04TW9iVlRYTHlmZ0h0WWhkamw2YkJucFg0Nk9YY3I5?=
 =?utf-8?B?bktiQ1A3NW9ldUJMcks5K2ozc3dKd2hySGlhSU5GL0ZzNWdSdk4wdVdOOXBx?=
 =?utf-8?B?RGYvam5sNVdtRGtwUHh6Q1h3ZVJtMmEzbWpSNTZJUlFlcUZFcGxOVHZzdDMr?=
 =?utf-8?B?L0p6UXpON1hNK0tuMjI4ZXlzNHBxemhJVHkvSFZqMzlUMEkzazhGRmRzTlRP?=
 =?utf-8?B?V2toaTdyTnF6OHE0dkY2dnk0Vmt6b1V2dnFJRjhoU29QVWFqQ1dWWUJZa1E4?=
 =?utf-8?B?emk1Q05sdGRYN0oydVBZL0UyUkQ1dXNvNGVvSk02dUZLczdBMUlnY3NrUEJQ?=
 =?utf-8?B?V2I5bEdVeUhOMExpcE9nZTNLK1kvWU1wVEJ5b25kWlBBRU5CMlJWWVR2d3BJ?=
 =?utf-8?B?bHBzT0xiQVYzT3BUQkxobkZqVG1JWTcyaGhOSDJaalE5OFIxMUkybUEza3pu?=
 =?utf-8?B?RGdrd2F1c2RQcjNSRWpTb0xUd1haTkhDcHVMOWNlWUI2VTg4ajJMNkVVOTF6?=
 =?utf-8?B?WmpmQlVRUUYwamlxTTdyOFh6dUZiYUVSZ1pXQ29TMnl3aGRTckY1VVZFQzhm?=
 =?utf-8?B?Q1M1b3BnUjNSL3poM2ZhbHZjMXlsNDNQVDJDelZ1a0ZRTHA5eTBYdkdpd1V1?=
 =?utf-8?B?UDJQOTB5SkJPOHBzcFl2MHZHd2dzVnJCVkJlVUZySmt1K1dFd2lYOUt1Mkdh?=
 =?utf-8?B?a1NtVDZGWFl2MXA0b01lYXYyNzZDVUdkbzZhd0JBRzVSV1Q5d1NYSjhEcjhV?=
 =?utf-8?B?MDhtSHYrTlFRNWNNR3JVam4vdDRjSlpSaXNmN09oYnpEak95cUNXS1NQM3E2?=
 =?utf-8?Q?PIeap4PQRKsYGOAj/Jl/YNRLZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1169dee-51fe-41f0-95c4-08dccbe74daf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:09:08.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llvKNAHTuNU96EwaA2dXGx8J0CUPMlEeNkEBVM3ck770/xwwRjN4CmAm9mNQEAbMnatdaIKBfv6ikiMKCv4fjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

From: Peng Fan <peng.fan@nxp.com>

Update the thermal trip points for automotive and extended industrial
temperature qualification processors.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 314a45e82c38..2cba7a889030 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -347,13 +347,13 @@ a55-thermal {
 
 			trips {
 				cpu_alert0: trip0 {
-					temperature = <85000>;
+					temperature = <105000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu_crit0: trip1 {
-					temperature = <95000>;
+					temperature = <125000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};

-- 
2.37.1


