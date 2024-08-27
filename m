Return-Path: <linux-kernel+bounces-303522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6506A960D56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66381F23B44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21B1C4ED4;
	Tue, 27 Aug 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jkwQO+wb"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677C1C3F2A;
	Tue, 27 Aug 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768106; cv=fail; b=YmK1bJGY2BpLVZr2AP/i3gdJH+bxNx0AegHM1KGtMb6ooec9TBmQUixXnJNf3yHJi82qk/LEAiAFMdjTT+HTpmRjhgxWeQqmGH8YO5YF4MrR5gu6kuUU0x+/+eQieO9B7PO/0rjLUvq7HwToeb7hwxvrws6u2Prs5T+U9vyyZd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768106; c=relaxed/simple;
	bh=zoAqpeDKmrDGpOafA19bSo7HhtCY35GhSt4nCc9OBxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ll1i38zJld8dGumm6/N9wycQKg3VJrSJVSXSvoWzvPoKVN/KG0OHIGD+66adJrwfeCAjnMUOxgyvkhHvmHnV24MNIXm8LeL+86p/I9yvLI66c4lMWH9tejwHjmS7927syjAepnN/PiiyVGVvrTpbuxPmGQwGJWuKVr9k94VjDBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jkwQO+wb; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOW+nwyuxIdibfnfqPp977YL5UvHkCaSf9RZzU2oMbLY9zPaw05/bOZvxKEIe2lXm9EoNCqf0UnKymChkYZ3r6TmfsHxf54PnDs0bzAGipayMCZsQ2NL7kxnVKy6hnTMrl767CQ2hayslW9kN5lDVlnOw5zVQxRy32J+MBxiiBse8eIcM980WBLuG0uBQmsolOsV2srLdjz+Moj7yDk1ehHbog0guAmPddXSgDlfF8BRaXVNIAW0jFZnC5Z/N6C2ynKIRCO+X8gz/dKrQwLRD6Fhx2TbceptRJrXHlMHxsEm2bkrlmWIQ/s9MpDgT9WpYlxF6/ilF3KDhGo6G20ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfBL9E9yk0tk/46GLa0GADf5BYhtOyad19cWA/Tngpo=;
 b=ICejMFv94U4Ef4Z4zTkoP+PmFXh+/TC0jvOZ53rY2QNtuTrD608emCgo234WZ4ekbI5N5MYySYEIkDCoMYRNNh+/Y5f0h2id2Fu/H2QQQga4SH6Pvht75WdUOzKd51nxVkOPautsxCQUbtJEWgLLik9J+2fKzei4LEB3+DmJtdZJ5LY1OEtVlWKDTjxmn0yPsXHjjRmVnO6rZiBm3sghOzj1BYesrHclhUYN+rsPjbEnF298g8e0rAP+bjsDSE4Kx23BIuR9Hap7Ddymz7PaaI98VaN5f62dmjgqLszjvdYxfYYEc0E+vRz3qPFo4JB5SSguSAs0apZDRtOPr3cklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfBL9E9yk0tk/46GLa0GADf5BYhtOyad19cWA/Tngpo=;
 b=jkwQO+wbhwvt1Qhw+BePwu945mfRl/TaMEgm6Q//oFA6Ws9TaOMDRmgFfUNZXmp6+0y1TKzFWO4jdM9VFe2FR2K+Z+aE4gxtZiymV6MHirg5bM5nGyR1l1KtiApMDc4BVx57HrntXsoex185hXzd4AQa6p4a2wo/TBef20WBArqFHgkeEMWbgDCchh8qd1ormABNMUFawkt6Ns0QGQO1RN/q7y1hxVkopgQcsq7jYe/TI+qolNpGI6Mu7aWWhc4UQlPCGWbsL3YkQFhjvC0LD35IEi/odFXXdZfox7LNRJ5g4JcEK8gMT4HFcLylCLmf8WSl9S4H+G8tMHTiwLyW0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 14:15:00 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:15:00 +0000
Message-ID: <e04ade2c-eb3f-4180-878b-8b9384239571@oss.nxp.com>
Date: Tue, 27 Aug 2024 17:14:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: s32g: Add S32G2/S32G3 uSDHC pinmux
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chester Lin <chester62515@gmail.com>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Matthias Brugger <mbrugger@suse.com>, imx@lists.linux.dev,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, dl-S32 <S32@nxp.com>
References: <20240827084815.1931169-1-ciprianmarian.costea@oss.nxp.com>
 <172476183961.3553344.11483964192483268443.robh@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <172476183961.3553344.11483964192483268443.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::29) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: e81df3e9-e15b-4fb6-eb63-08dcc6a2a2cc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1hjQjBGZCszamhVTm81UFRaNzhvZzhYcWdFTWxVUnp0dHJLcytqc0FmdzZj?=
 =?utf-8?B?WTlYZUhwV1A1d2ROZytvRXhOOWpuTE9vR3BMa0dDbkg5UW9tdmVoMkM5dm5R?=
 =?utf-8?B?VHdLZHMyUGhGRkw0RWI0UWNKc2s0emE4QUJ0TnB0MlpnS0pUODYvcS9VNXNx?=
 =?utf-8?B?d1BpaTZIUXJJV1drbzhWUlJvOTU4VEFFeEdpR1hqZWx0YUhWc3haVFNVa2Ir?=
 =?utf-8?B?UGkybkNMMEY2dlQ0aDBXY3ZpeWRZMVgybXg4YlYrdXY0Rkl1RkJ5UkRIamln?=
 =?utf-8?B?VmxTdGRPbktZSlMremJrekt6NWUyOHlrQ1pJdFVVSVVzNGU2MmZsZnhQY1Jv?=
 =?utf-8?B?bmNYVXg1bTdBMFRnbEliSnprazFFZDNxNUx3aHp6VTlkcm5wcUY3NTVoQVh0?=
 =?utf-8?B?N3FlanZPTjYzUzFXMnIydDVhRnJkK3JNSm9Sd2d2Vys2eEp0K2srTHFUT3hB?=
 =?utf-8?B?YVJOcVBMMTVSWTZIK0NvaG1oMk9GbFZZQ1lrbHFESDNhTGpkdUJuSnViREk2?=
 =?utf-8?B?SEZRU0RBQ1lkYlFGWkIxclB1bDhSbVNmV080ck5yZ1NhdzA5eVZTOEJpVjZD?=
 =?utf-8?B?c2dUOTE3Rms3anVJSVBTelFhVWVub2ppTFVOQktCV3o4T25oSHZOR1hrNEZj?=
 =?utf-8?B?UkJFWWhxMndDV2ZFbXBWT1pkSHU1eFk5VlJQYWpoaXIvUndCNmZ4ZzBWSk9L?=
 =?utf-8?B?alRUNjdVZ0JkYWJTZk4yRE1HVEZpT2p6VmJLdldoZlFkQk1mdWszN1lhOXBJ?=
 =?utf-8?B?ZDdCQmdRL21lM1pGK0kyWXRlb1pvdE1NN1BUK3UyQTJhbkNyR1psME1wdGhZ?=
 =?utf-8?B?eUx5dTFLS0RWOEJaSTBpcmZ1NjdYWHRuMmFVUTQxRlQ5QmJzTlJaZmNucUp0?=
 =?utf-8?B?ZlJrN0JPNU9meDVmTmphYUZzaXJneEJueStiQmMzME80VzY4MnhYVDBWS2cz?=
 =?utf-8?B?WUVpanhGSGxvRGZ6bUE1dnNqWjhRNnlCNEVkVDJsaXM5bGo4czZtUlFTdFEv?=
 =?utf-8?B?aXYyd2ZQVzdYdFI2Nkd6dmZnbldQNlg2M0FVZWduaFBlWGo2c0FrNXhEQTVO?=
 =?utf-8?B?RXhZb3krVE9RQmhTQkVxM2JDWkxXQkcya3BqUUR2dk41c3VzOVlVYnJiTmph?=
 =?utf-8?B?allqcHBhMFZPNVRuTE9aR0dMM0cwUENiOHFiZ3pDdkJyMndVeGlFc2xiWEdG?=
 =?utf-8?B?L0dNcCt2VCtoV0hYOU9YdEwzcmp4T1dTOXhnY2srUmthTytjTTdsV1BLYjZ0?=
 =?utf-8?B?WmtocDJ1OTVEZ0JoN0pqWjd4ZUZOR2d5V2lPell0aHNmbkpsZG91NjVMRG9M?=
 =?utf-8?B?Qys1QjU1ZERpalFicXZjcU1ocW40YmlMaFBVL0tyN0dQczRhZUVRWFNTbzR2?=
 =?utf-8?B?Mm9wSGt0L0czb3FJemJWRC9KdUdqWUxiSEpSNEVwNUJvTTdQeGVkekhZODBv?=
 =?utf-8?B?Wmt5V2tFeE1SaXdiUTU4aTlXUE1jbVlOcGNjR3hWREdmTWdOOVJKVHdrT3lr?=
 =?utf-8?B?eGNuVDlGZkkreklGR0lGS2dONTIrYXVub3Q3cXZUM283NUZxbFhRTE1QT01l?=
 =?utf-8?B?dGNKWVJXM2ZlR21ZK0kxbFMxeUJLS0IzbTl6bzd3Sm9EcHZ5ZjlmVVBHNHZR?=
 =?utf-8?B?V2wxZ1MwWjBRckdWS0tJNDRpN3J5WGcwUkxPUHkzeVU0UDBKVmxELzhkSG14?=
 =?utf-8?B?QVUvRm9iY0RkSHAzL3ZJczRVbHcvQzNEQlBBMGJtVVdxQVdGbFhUUEYxMkxT?=
 =?utf-8?Q?obeYStCTdEdgHlQZ14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkRYUlVrQkVGTnlucW9tdmtFRFgxZHBYR1dUQ1FVeHNacGwvb0ZMUmlZUkVk?=
 =?utf-8?B?aEo2NHdNL0pTSktOdkZSeldjMTh0UGpHK2xjM21DTCtqdFZGbkUxSDJneFVz?=
 =?utf-8?B?VGJVeGZKd2ZxL2txbHVnUDRKVlJrZkp1cVhrQytjRkw3MjdBSUp5cE9kSUo1?=
 =?utf-8?B?bjNFUjRqYVFObm5LTitKTGZYVXFpY3RNMW5RY0E0NmRyazdJZW5YZFZoKzR2?=
 =?utf-8?B?eXg5QWlHUkcwcERuRVRKVmo0WUsvZmpNSEtGNzNNT2grNjA2dWFkTkJGeXA3?=
 =?utf-8?B?eU8wamlGN1FNMEdTeFpYaktwM1Y4ck5WWllqMG91L2htdThZVzd3RXNyZXhX?=
 =?utf-8?B?ZzdaQkZ3aGpQc0krT1ByVStESHVrYjRTd0p4eUVMRWxYcS9tZCtnL1ZNUFRH?=
 =?utf-8?B?TjYxY2NKbUkzSUVXZTVnY0V5MkxGUVV5dld1WjdJUXI2Y05zSGJwT3Z0UW02?=
 =?utf-8?B?MTZmQTBZTE9lbHJoMnArQ2gwekFqaUxIczFNUVQwQ2RXNjJjaGluK2pFc1lu?=
 =?utf-8?B?d0U4WjVoVTZ5OUllNUNRZGIvUElZS081MTFFNHVTd0V1WXhldXVoamZRM2xZ?=
 =?utf-8?B?bFpNUFpzUEhQdHhLaTJOV3V0MUY0L3RpRnRjM2hNVnowc0pIbDRtejAwYStD?=
 =?utf-8?B?UHE3VnFwemNZMGlXMnBtcGN4Y0JwbGgrTUhRRE1RMVJJRVhEVkNmRWtncEoz?=
 =?utf-8?B?Y3Faczc0S3dYampnbkhSNWdKVTAxNCt6K2xVTjloYUpHRDdpTlgwTmo2Qlhq?=
 =?utf-8?B?QUl5eW1iaEZwNUVJRXpBVjZmcEtIOGxZSzl3QVR5cDVUZnNPK3lnMEZqRUVC?=
 =?utf-8?B?eXIyUEs5K3ZERmdvUUNEdHFyNjM1L0FLRHNTQ21GcjVQQmsyNlNRK3I1NTJv?=
 =?utf-8?B?S2h0cXdtdkZFVHpQQW96NTFWOXBZM01la29mMjJnd0dJRVcvdFBHcWlweFZP?=
 =?utf-8?B?c1ZrRTNzZHdCeU1ZWEZSdXVQOU9ONS9vWjJJaWVnZ1V0dW1BUnNKcXRTeE1l?=
 =?utf-8?B?QVVTc3JmcWlMUDgvbzd6NUtyZlBRUCtSS3JaUFN5VXJJRHpia2hLYXFPc0pt?=
 =?utf-8?B?Ukx1anhjVm5aZzFldkFxcGFKeC9USEcwNitVdmdmMFovcnAvZ25qWTJtNkhZ?=
 =?utf-8?B?d1FDTkF1dzRUL01VbUhQVzhyaDhyMjZpSm53RmlRU0gwRnJRY0w1cG1pMDRM?=
 =?utf-8?B?OXBDQ0dkWWROM0F3UHBCUEEzTWhPZGM1cFMzT3lyVUVDa0lhcGhGU3cwcjVx?=
 =?utf-8?B?cXU5RmJlYTVjQ1VzU284Tm9VRmcrbjBtOFhvWWpVQ0kxWVpzY05mTHpQYmhz?=
 =?utf-8?B?RWtGUGFVcmlXWnZSRVJIRzZPSGs1WkpFNVpaRUhUMllkQ1hMNVp5MmM0VUxM?=
 =?utf-8?B?VnNkbHlyRlZHWUZXdklkckRHR3hWL1Z0alp0YVBLT0Erd0RwK0M4aEtLKzBx?=
 =?utf-8?B?aXE5YU1wNUg3ZzBUT3dJc2NoL2lLbjdCZVY0WGFmYWtXYkR2bmY5RkMyMGxa?=
 =?utf-8?B?R25PaEs1TXd0WkdJVVhOL3ZJUmE4dG1VZUFwODdBa3VScmU2eElybU04RU9L?=
 =?utf-8?B?dGlyN1JIVGV2ZFF1aldTbWFWTXZjc1RmSUtuZlVqblJwczVGK0JWSytDdmxR?=
 =?utf-8?B?ZHk1WXVzOTE0dS9vSWpZZkE4UUpUOU1BMFZsU0FGMVZzbVppbmgwQW45Vmxp?=
 =?utf-8?B?TUwwQ1dtSlBjUjBpRTFaUFlRN0UxTGozM0tIeWJ1cUIzVkpieFlraUtKRTFG?=
 =?utf-8?B?K2xRWnFSbUcrU29Rako3c3J2RjdZL1JKWDExem9sTnFna1dVZ3JYdHVmUjBs?=
 =?utf-8?B?T3dYcXd2ZmtjRklBN1l1Rjcvbm5tYkM1My8ydEd3MDRvaGdzc0o2THVkWWRX?=
 =?utf-8?B?QWovUDRSbnR1aTJxUmI2dUYzZjZWUFBKOEJQOXQxemV4MnJuR3o1N0ZReUF5?=
 =?utf-8?B?SkZmY2NleE96THozOE9vQ0NoQ2w0WFgrMVpVUHNoQ1lUYU1DcFc5U2M2ajJW?=
 =?utf-8?B?bEdkZ3FDdmdvUGpnU0xTa0x3bEtobU1oNmlGREU4SFZYakVWbVN3T1FzN3oy?=
 =?utf-8?B?VmtYVVpqT0ZieDdJNVBDVGwvRXFnc1JaaTAvVE12MUN1SVg4dVRTY2s1MUZu?=
 =?utf-8?B?Q0lreVpLRkhPWjBsOFl1Qi9zV040WVBTb2phc1RIbmwreFpWV3AwMEJKU2wz?=
 =?utf-8?Q?XEplbXRe/qTNPMjhBIby9+Y=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81df3e9-e15b-4fb6-eb63-08dcc6a2a2cc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:15:00.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xThjp34gEcKnwQyztkjYJKQBwHMN5eQIsfindIhSb7N0FuHZUe6/jHR15fLhTOqmGNh6+O+o2wyDCcemUj9ZY2Fp6ZNUvvTMcgZzekJ+Irw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8497

On 8/27/2024 3:31 PM, Rob Herring (Arm) wrote:
> 
> On Tue, 27 Aug 2024 11:48:15 +0300, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Adding 100mhz & 200mhz pinmux support for uSDHC helps to support
>> higher speed modes for SD (SDR50, DDR50, SDR104) and
>> eMMC (such as HS200, HS400/HS400ES).
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/s32g2.dtsi      | 153 ++++++++++++++++++
>>   .../arm64/boot/dts/freescale/s32g274a-evb.dts |   4 +
>>   .../boot/dts/freescale/s32g274a-rdb2.dts      |   4 +
>>   arch/arm64/boot/dts/freescale/s32g3.dtsi      | 153 ++++++++++++++++++
>>   .../boot/dts/freescale/s32g399a-rdb3.dts      |   4 +
>>   5 files changed, 318 insertions(+)
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>    pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y freescale/s32g274a-evb.dtb freescale/s32g274a-rdb2.dtb freescale/s32g399a-rdb3.dtb' for 20240827084815.1931169-1-ciprianmarian.costea@oss.nxp.com:
> 
> arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: pinctrl@4009c240: 'usdhc0-100mhzgrp', 'usdhc0-200mhzgrp', 'usdhc0grp' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
> arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: pinctrl@4009c240: 'usdhc0-100mhzgrp', 'usdhc0-200mhzgrp', 'usdhc0grp' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
> arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: pinctrl@4009c240: 'usdhc0-100mhzgrp', 'usdhc0-200mhzgrp', 'usdhc0grp' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
> 
> 
> 
> 
> 

Hello Rob,

Thanks for pointing out these warnings.
I will fix them in V2.

Best Regards,
Ciprian Costea


