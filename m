Return-Path: <linux-kernel+bounces-241100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C578492770D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA3CB20D1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883D1AED39;
	Thu,  4 Jul 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SiJpcBEw"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4581AE859
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099287; cv=fail; b=h/sqjz1qbOY6X/1Zb6PziSXnzt7r1hQ3L6EMQz7ESpt6LDAcpt2DHIJ5Vnk4RSyEVpzwRZoM14tFFUTrP+6+H+EgAsTZfBVj3zgyjxSiuPupk/synlC7R1S+8qpsjrVE81MJnX3RcxyFlrbxS24gqwUxvCxlA1GDozkeWeZ9fcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099287; c=relaxed/simple;
	bh=WA3wpQYMiw+SuvwzzQm8hfOQzI2ldcitSNgjB50H6Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MFPwO1Eo8nyut0B2dT3C4eSLtElskHxGG8MRbc5cRJzNAdrcdiSGq5K1M8ZW+TVM8dUraCneVHXOMqYrSnPHBm2DH6OIevAXHrW/JkxdU2XNB3Btxb/jM++YrTQv+Ndwcn1MrBQqRgIjxpi6MAhYZjH/bt/7w96ZnzJ9FWoDpiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SiJpcBEw; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDDwk+4j49Ix0KOlMfDRB8AD2g+U+sUlzxfsKrHFykuhk0WzYzb0zbdQfSKbNdfKWpsef2mrktcBG0v35IGlMSC0ilXNM2JESKqFHjUQFdR8Rifhj3O1UaEN7TDQJOZ9ijq9p/6BTADV6BMQlolAJUtWVxyjiIRcaLwFCVnQiv+PIn+HFgA6XTGUm01HjAQkISmYp+2CkwSBoDRaDCLEy/9TAuJ3jxFMHcsejR+jF29M1IZ1zcaCnFjE1HSfIGwcBZx7kBhLd5dKX7hE7nYsqb6d3iW3/qU8B2s+dyGVYhPXvQRegwGlZieF415HSRQUjnwj7DhBa7AF2gyFPEAIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqXn2Spewu7hks/6PVU+Dt4N+nV0Zeg0eP7GR31+71M=;
 b=dRwIt4ZeXwzJn8aZoIkr17oa6XI2OAidqnws+z3tPw7NxUAaMaekn1foNApzc/JpJbEEe3uyiW6RXgc5r9NDzEVRyKId/IiRnndxSld1AsMk8l+y8kR6M+y/jpHP/r8ZjTR3z98mp/r5IlhvNfG1FyOpQOtcEXc29/B9JFvGMRqzzjm2ZfjmCxlzcy45f0Vag0JWApVEDE4rFObN8CebPeoaK4nxOaXYKZ8mopdKZ0bOhKo+jBrZvBFmVBEbJSK1/MxmllR2l/F9PYt/SD2djSO1TxwY7vSQzl1wFtkF+z7daIUlJDUppnxyWiX7UMK8PjXwNESNf4FRT4f0d6FoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqXn2Spewu7hks/6PVU+Dt4N+nV0Zeg0eP7GR31+71M=;
 b=SiJpcBEwoKeL4rjAKo0JRxE+muCw0pCPANCwNP64JF6Eg0P6coe12ZN/pPgmk7Pj9Zi2VtzGx+rxOKZp/OFLYiOYLkQJdPMgyZXGD2iXO3FxFs7Zwx6TjCxAyiMw8wwQlfCZQQ7F7rW9H0+tof8kYLYT/qw1pcivA4x9sh2L3KY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA2PR04MB10422.eurprd04.prod.outlook.com (2603:10a6:102:417::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 13:21:22 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:21:22 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 1/4] mmc: sdhci-esdhc-imx: disable card detect wake for S32G based platforms
Date: Thu,  4 Jul 2024 16:21:13 +0300
Message-ID: <20240704132116.2865864-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704132116.2865864-1-ciprianmarian.costea@oss.nxp.com>
References: <20240704132116.2865864-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::6) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA2PR04MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: 991377b0-c2b1-4253-9550-08dc9c2c32bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDN5Wm5UR3hycG9JWk5ZZFpvbVd5VjVkMHJXWkpoNmYrRGhONWJUcEo5R3d6?=
 =?utf-8?B?VWVlb0Nsc3JZbjhucWhGZFFtcS9hc0d5WCs3QmltQW1IblVVUU5vUS9MNDN4?=
 =?utf-8?B?d3BnMHZsT3MwZVlKajl0V2lPNzBkTUY4V3JGTEtDTkdXcnk1RWtYY2d3Ukdz?=
 =?utf-8?B?VEtubjk1VkRhMWNMem0ycDhWYVpha2R6UjdFdmNORmFvWDIxTWtwQUNyd1pi?=
 =?utf-8?B?eUxrSmQrTHBWWVF2RjhkTmp2NjZWQmVYcWxvQ25Qc1VsNk9EZ2hxVURxYXVT?=
 =?utf-8?B?cjZBZjJvNTdNSlgzT1JRWTc0OTZBUXJmbXcxZlJPNk9DR2d3aGE1ekNDRzA1?=
 =?utf-8?B?WVlVazR2QmZnRWdWdWY2blpZenIwL0FjVTZzZTJ1SHM2M0ppRVVEYlN6SGo0?=
 =?utf-8?B?blorYWhRRTc3ckNvWUpmZnFBYTZUSWMwY1JaSDZ6WDk5SXJkS25vR3d0dm5I?=
 =?utf-8?B?dnNGYTFLaFFYWWxtcUlBM0ZkSmNwSFhiVUR1TVpiMVVnL0xVSWJwZWVOSkc5?=
 =?utf-8?B?Nm0vSHVqSGtRS0R4R05BanJhOHMzMktzMGhWWXdVRGRTQXJIUU5LR1Fmait4?=
 =?utf-8?B?VzlVSVdNbDg3dXl6L1ErbkFHUWc0a3VXcFhTTEt1VkdQakc3VmI2YVpPWDJn?=
 =?utf-8?B?VEx6N1R6d0xMaCtOTkRxNEVmQmlqOHE2ZlkxZ3BxL200OHNZalBNV3VsaTE4?=
 =?utf-8?B?UUlNQ3dqcFBxOFZ6T1BaSE1RUkdLaEJYNmNtcEsrZTZKZ1diUWtVMEtvU0tG?=
 =?utf-8?B?bVZ1Z292U3RyTWc2cHVvMnZQN3huQ08vWldtYWJUL1BEV3FFNHlNU282NmQw?=
 =?utf-8?B?TjRtS01SdEgvTTZOK2k1b1J6eXcxaFA3WnprVE1FMEg3SkgweUxjTkZodFRJ?=
 =?utf-8?B?cnNnNXV0cDBBUnRFWmJ0eHgvNmZML0dGbnNPREV0Wi9uVzJBdjVHSmFlZlVh?=
 =?utf-8?B?eWRKbjJrNzNwTWNNYTJuWnZKWEE0QlhJMDZ1cTBKOXNpM0FzbFdhbDNac1RE?=
 =?utf-8?B?ZnNZM3lJMzU2a28rWWJGcVB4R2ZrazV3b096dlFHYm8vMWdaU2p1VzNyV3VH?=
 =?utf-8?B?WEpQWWxpelIvUzVzMWNnLzhpTUJjUnVFVDVkOWpjdWRsM0dWYjNnL2FTcTFV?=
 =?utf-8?B?UG1YV24yb3VwNW1SaHpEVkFIdHBNVlUyeFNOVnA3UnozeG5aR1JzVkxFMXRX?=
 =?utf-8?B?SG1mb0RySHl6b3FkV1R4SHF2ckw1Q2hqMEsyd1NuSUU3QXQ0VnFGMHVzellT?=
 =?utf-8?B?UDU3eVNtbXFtRk1tVjY1NUE2cUpRNngxZ0JCZFMrSlMwc0ZBU2NqaVdiUFY0?=
 =?utf-8?B?TjYrUDVTUm16TFJUWndnQjI1YXlkdnlENlduZ1kweTZVbnV3eWlkS0pGcnN1?=
 =?utf-8?B?U0dIRlY5VnNFZStxNml3MCtoYnU2RmJQd2l2dG1pQUwzQk92R2NKVzZMemZ1?=
 =?utf-8?B?Mm9JOFRCQ3E0OStIclVHSEhyNWVYTTBwRGRQVVpHZ01QWHhVUWZGQ255K1RW?=
 =?utf-8?B?dktMd3N4T2ZiZVNab04rNFlOM243cktRSnJhdlFFS0RtU3J4NnltRzYyYmhE?=
 =?utf-8?B?aG5KbmVhN2NEZDZSbkFQWEd4UTF0ZC9wb1czMUszQURzZFovQ0g2bFZxMzdk?=
 =?utf-8?B?YXYzaE1wUGFDZVBsSzVqYzB6QUxYS0xHcDJQUXJsYzg5NWpKVjI2UjVUSVYx?=
 =?utf-8?B?UVZjUWFib1lrdUI4ZjRzSFpqUlFKZjdWd2Q2YlUva0tCeTZPaCtjcXNXVldy?=
 =?utf-8?B?aFJaaThTaDlFbXdxMG0rc2JvWXdSU0d2b2VsQ0FrWDJDVS9rYkdiSE1SK29z?=
 =?utf-8?B?Mi9NV2FwRWIvRDNrZEhsdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkJBc2Vkc25mSG9LVkpUc0NaQnNVQ2xwVlpqNkJZL0dlZk92RXFsUDJLQmtY?=
 =?utf-8?B?b2dvaGxQYy9HZ0VJM0lzRm9OUUhaQ1JVUnVrY00yeE5jMGEzRTFidkVTZDlo?=
 =?utf-8?B?L21sMzNTZkc3aDF4RVZDamd5U0J5VXRxL0RvY3pCeXlkL3pXQTdacVpMZGRE?=
 =?utf-8?B?a0FaOHlVczdGdlYzenA1M2htdVV0YUtXQ0xkeTZCQkUyZjdpVDV5UGJwOTRW?=
 =?utf-8?B?clNLSW9kRlZqcXJJZTdiRnNseExDNFNrRjVYMDZ4dkRIdW5HZjRNTWFuMjNX?=
 =?utf-8?B?QXBoK3VwV3ZjS2pqelYxam5NRmZLOFlKaXFYUFhva3llcnRUY0dEVEVPdTZZ?=
 =?utf-8?B?WGFMcWV3MFBDV1lPRHVmdVlPOFY4UW5UVkM1OEV0NmZJc1ptbTBBR1dQaTZ1?=
 =?utf-8?B?Vi9xVzhpcDI3QWJVNVF3T0xuRGdWZUgxeFdtK25MMG4zTkVxTFJkTFBIYTh2?=
 =?utf-8?B?V2VZK3pBTDZaUUZlS29Sd09TYUdqUk9ES0lpSHZhdFBNaHNVNDhSc0hNd1NL?=
 =?utf-8?B?OEg3ZUowVzk1WkE5VzlDdFlHanMxbkZOaFlVeFNJQmVtdXYxc05nRUMybnJk?=
 =?utf-8?B?VnlNdU1OT1dQQlJNYnprVnRXQ1Y0RGcwODRvdThrVDlBLzBFa0ZWbVI2aU82?=
 =?utf-8?B?ZlU4VnF5ajNQdVB1ZWdFdzhlc0V0WTNYaW5KOUVXS0Y2RS9EWkJuTm5maWlt?=
 =?utf-8?B?clRtQS8yRi9NNGNZTWJ2VGZCT1A2Q2xJdzM0Z1Bwc212bFlIYzgzKzgvVTFQ?=
 =?utf-8?B?RkxkMTNhcUw3S1RXc2dnQ2xhRmRUM2U2UUJtU0JQZkI3SCtORTdBQkI3aXZJ?=
 =?utf-8?B?ZWxhdWdZMFRLWXMyUk9Kb2pTY0VpM2hHR3ZVb1p3S1I2cXNDS3RLTk5ta3lM?=
 =?utf-8?B?Q0wvTjY5ZVJhNW11WG42dTN5N1lmWFJtdDVwUStNemF4SlRDeG1HZmR1OU5w?=
 =?utf-8?B?SU1WWnVicEhoOFVWSHpvclppYzJJa1lvbmZUUGw5S0hra2FIYk43T2U5YVFJ?=
 =?utf-8?B?YlNuQlF0RnFWNW0vUDd4Y0ZmRTRieDZ3c0YvN29aTFFDejhwVXdkVGlWNldC?=
 =?utf-8?B?TWRQZkZRRXhDVXVHVTA3LzNqQkcwSGUvbFZEbTh5ZmRQWmtNalhrY3pTd2Nv?=
 =?utf-8?B?eXBhdGFXeExkNkNCbFR6VnljU0pTbm5vWXVFNEZyWE1tMmIyOTFNcHI5L25W?=
 =?utf-8?B?MnQxd3Y0S1ppRk9EWDZWcDRhTzlxR3B5K3FVUE5Cem9tWkJYMTNlemVpNHpE?=
 =?utf-8?B?cHNtY1prUkc4MTBLUHkwSEwvVDMzbzduNmo5MytnN05EL3FVbHFzQzdBdFJ5?=
 =?utf-8?B?QktsbU1hQkFVWTFiMGpWckhVb1VHT2VKNWJuNkJiYmN0S0NyeUpkeG1jcWlL?=
 =?utf-8?B?OU81eXBIVkFIVy9CbkZENVhGWFBVWlNYeGdtY1RPQ0NMeU03UXRwTU1uTjdi?=
 =?utf-8?B?YzQvSk1WendKOVUyTUhrUnR5YVY1OFQ2bndlQ3h3d2l4b3I5NG5aRzVkaUxO?=
 =?utf-8?B?YzZCb3ZXREJZZ0JnWFFlSzVTY1VwNUtJbG9ZdUhaSmFJVGUzSEhJYjVySER1?=
 =?utf-8?B?YktvZUhwdDZlUHRBNDM2WnliQ0JmWjBpSVZmYjJaak5wRWZFN1d5UGJDcjBK?=
 =?utf-8?B?cnBQN3dpSXZ2RWx6QjdyamREeGx6NHlVTGJqQ3Vwek5ZUDJTMW1sM3JZc0s1?=
 =?utf-8?B?eitzSE9yUC9OWktSUmtKZjdsU2pCZENKenYxeE5oaUFlSkdhTHFtdG5HT1VI?=
 =?utf-8?B?TGJGUHNsZUtmSG1uSDZWQlN1RHQ1YXNEbGpHRkhLM09oSCtla2EyNmxPK01u?=
 =?utf-8?B?eFc0Mk4xWGdNNm9oajBBZnQ3U2YwVWF2Y2dGaEkrSlphRUkrb0dOcEF0cE5N?=
 =?utf-8?B?QmdnTHBhWVVjbWkvejJvVXZ4RExGc1RDVmdaTFJ3UFhCRVNiTDZWRkhTVVFs?=
 =?utf-8?B?d2RsRnk1WndYR3VEdWJDY1dpTmw1Y1VDRDYySlZ2bWZqL2VBZENzalV3bTZx?=
 =?utf-8?B?VGlkeUVIM01UZWhEUVdUZmNaWCtDbkFFeEdxd3hTL0pVUDh4QVlBZG1SOUpY?=
 =?utf-8?B?am83WVB4QUtSdVBBaEpGeW1BUXM5Q1J2NVdsU1NybmdublhFQWFaMGdvN2xv?=
 =?utf-8?B?K1ByNVhXSzNTMlpWek5sNEVlMFY3TmtGM1FOMlkyOWxlakd1QkV0YWJpbjBP?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991377b0-c2b1-4253-9550-08dc9c2c32bf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:21:22.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkiPjsADlbPiyanqKOQOWerqApOoZsQurix2CyF3FJ+qyFioFu8AXeDj+bMtnsAs4HB3CXW+mQf7XT3Vej4HM/RDz5yTwR6uWf8nNemwPB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10422

In case of S32G based platforms, GPIO CD used for card detect
wake mechanism is not available.

For this scenario the newly introduced flag
'ESDHC_FLAG_SKIP_CD_WAKE' is used.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 40a6e2f8145a..21d984a77be8 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -201,6 +201,9 @@
 /* ERR004536 is not applicable for the IP  */
 #define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
 
+/* The IP does not have GPIO CD wake capabilities */
+#define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
+
 enum wp_types {
 	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
 	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
@@ -298,7 +301,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
-			| ESDHC_FLAG_SKIP_ERR004536,
+			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
@@ -1726,7 +1729,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 
 		/* GPIO CD can be set as a wakeup source */
-		host->mmc->caps |= MMC_CAP_CD_WAKE;
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_CD_WAKE))
+			host->mmc->caps |= MMC_CAP_CD_WAKE;
 
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
-- 
2.45.2


