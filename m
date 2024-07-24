Return-Path: <linux-kernel+bounces-261011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EB793B18D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30944285B15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEDE158D7F;
	Wed, 24 Jul 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CZD7J24S"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A6155731;
	Wed, 24 Jul 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827495; cv=fail; b=tyjLeomUqlt0nb6fdKkJiClKW0ZT+LxXOTYr0Z9U0+X4wAHhALTxWWYklI0umzVuEAp3UVjGx9BBh8A812cQKapC2qm/NJ9+iqqfmL1cfx3MI/Xa3irAQ4djIp8wnX3AC5EwL2DFpp7gLWfVDsk5OpbsL5508QJEjaYhxRC27FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827495; c=relaxed/simple;
	bh=5hobGSPnLQ9g787oqD3FJb3qUWcYKFEiWWIavo1pImU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ykd+qexqL1CyPpwtYYGMamjFui7bQismiaQzEy4GQqwhTTz9V8gLSwQ98Zp4DDbEli62XNC5Uxrk6zapbqJwVh3BeBajtLJia9a9KqsAgHRfK6J+ugphiSBbOhoy5qEjUMJ39i4pYPx8g1lluU8Oea5Q2b6sn/azdCt+jmaIAtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CZD7J24S; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxIabgsZIi00qpkQ2wz8LvhA/7JVjWT8mvloKAH7I7mnao98ndk1evBpv10J9af4afr0909IO6kHgDEe1bne2g21GvYQZ6Rns5f+r5pb0dSwJ8UUB8OQPoE0Gw7FOP89JaBMrChqYcHkXR0gxZVMR1J0zUnG+Ujr/Dq1MA30Ux+ekkIHugj0pyn0Q9U92T2mRDoLmMu/KuyyLchMN4F7tV23s4Q0mTbG4tNS+1TAK3dri9PKN0+IWaV77rtZEpp5fI1D7kDW+oX5vA0AwnJIFVhNmiHuTxODNDvH9iZ6G3OYCXDWPGoQbjHRkMEqJORIdENfTOI6efVOzZqDOih9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO/U7fWduLRshbpwerqO5uzduPDDHvvJmy3zgcsOBBw=;
 b=BiO/5HgtszvjvKZpPwqKH4HrzkBh+i+gRaKxwdqQA5oI3TMuZvETMT0NUh9agM8T0PuNHIzyp+lZva9wlckCx6mjUyoage4kHjwuGTeIJwFQugTuWkKMV19onezq+R9RrVRADSZzisUXL1RbxvGkSrR40fjPRk5Rg3j87FlFmn8VjzXti816g11922K8M/paqKByo57xOnidVwpfTfvB5LAssiqTOF72SlkIaLYIrx6DeVR9POHy3fmT3phSjAb3anpy4r1+rkw76vPPNbACD0CJM7W4Y2E+8vZecc+grHUzaaDM6zIMXAKaJvvNRRqOfWs0hdFrJr/mdixpT47UDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO/U7fWduLRshbpwerqO5uzduPDDHvvJmy3zgcsOBBw=;
 b=CZD7J24Sm1ZVKNUoY48XKzvruNoVTuS2m8yq6mDzv6mz9e1ahj0oTpYpkYOyNN0j3onOZgtXNqV25V+YvR4FNW9tYqjUAWdteBjawXnSBQY7M7ngdh1ULwm9e5WdIKS//oIMQpA3vwkcdROMDWeM7+v1r4yD97ewbbdGGzfjox57S0PFJw0y+QD2l0NcXr6+RkwaPPnWLjqKFeCVv7f+/upG9fyR5dBGwOciX/VU49U/SWze7O3yLgUSQpGVYNI5szQC7JrCXeQVa7p6TnwVyyKNrtkdY1hcmvO78anGIo4wvk/K3qSdQs3HJM6VwaTWwQd+AkmfEXhesSdDWRX+Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by PA4PR04MB7998.eurprd04.prod.outlook.com (2603:10a6:102:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 13:24:49 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::6d7a:8d2:f020:455]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::6d7a:8d2:f020:455%5]) with mapi id 15.20.7784.013; Wed, 24 Jul 2024
 13:24:49 +0000
From: Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>
Subject: [PATCH v2] arm64: dts: s32g: add the pinctrl node
Date: Wed, 24 Jul 2024 16:24:15 +0300
Message-ID: <20240724132415.1700386-1-andrei.stefanescu@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::16) To AM9PR04MB8487.eurprd04.prod.outlook.com
 (2603:10a6:20b:41a::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8487:EE_|PA4PR04MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b473be-853c-4ecb-affd-08dcabe3fe65
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YytieGNWMWtIY3B4L2ljTDV1b0RkZTZla2o0aFBpN1MwZzVMR01sOEpFWTho?=
 =?utf-8?B?MUVHZmZ2dGtwYXZacC9QSjdSK08zbzU1b2hWWVltRGhrdEMySkpJVDVrZ2hl?=
 =?utf-8?B?eml2d09SQlhKTDNoTkFSYkZTRkQ3YUFEek16V1hhWWd6L0FMNmdyS1VzQmk1?=
 =?utf-8?B?RlVYYVMzY2pDRlVoZG9LQ09menFkQjFhVlVvOUJHc0xmN3VYTGJvbFZEbkhP?=
 =?utf-8?B?UE5HNWhXUUJGa1VPeExlT09WTVBvZllpa09pVVRMZlI5SmwySzBGSDg3MmxI?=
 =?utf-8?B?VlcyVng1SlVnN0pxZnA5VzYydHJaYXlWcEpFNHYyajNJQW8ycG5TNGtsb0JB?=
 =?utf-8?B?eDVEM00wb1d6Ny85YkJRSzZHOFRDeTIyalZDajRzbVVNak1GekIybkd5TWFn?=
 =?utf-8?B?ZDd3ZmU0eUtRTGhIeU9FbnQ3ZzE0VHJHVVdzZXZHeWViUjliR3I5WXVzb0Zj?=
 =?utf-8?B?RlBDdEJITGJqWVZXbi9sNXR4dDk4a0U2Yk9wSXd6eEpkZkZxNWlwV3gvYUFF?=
 =?utf-8?B?cTFXeURjTkV5cEd2dkV1VkhHakYwVVFQVVhyYkVZc2k0dG5jZ215a3h6cGk3?=
 =?utf-8?B?eVdmWndpK2hiUENPejhiemhOV3RDeHJ1cU81dFoxODJGeVFKbk5GZ2ZpVXRk?=
 =?utf-8?B?V2NXRXNCYWMzYjIwSm1HMnRGYkQ5cm5mNmY3NzVOQkRmeWsrblJXOVhZVlZO?=
 =?utf-8?B?bE5iZDhleUx4bjFaei8vZkVlZ1IyZzNQTHZIbmJEZTNkMndvWi9aQVRxZ3pD?=
 =?utf-8?B?eXc2YXZWMEdSVkZhT0c2V1JsNXdoSEV1YTBLdFdmWU9YdWJBYklXSjBCZENG?=
 =?utf-8?B?amsyM0dUVXJINm5YUTJxa2UrZ0N6Z1NLN04reGVmT3Exa2tkQ3lEVW9QS3ls?=
 =?utf-8?B?WWdlWERlZXczYjVOTnZHTFJUZ0Ewakt5bThXUkNOOWJ6aUdlOUcrdHcyVG5D?=
 =?utf-8?B?WHlOTm94ZmRDU21zL2krYndYOVI2VGY0b2hSaEZFU3did0kyazZIUWhNaFF6?=
 =?utf-8?B?U0sxSTBFakhiUEdQSWxwTzNnQ2cxRHVaTmNSanRHc1VwcHk2N09UL1FlbndT?=
 =?utf-8?B?RWhOUGhGZ1YwRlA4cHJqQ1hqY3VMVHpsNWFhMHpEZTVZV0Z6bmpRUjNNZjl1?=
 =?utf-8?B?TjhkbzJDeDVrYTVqM2tLMTBONCtSTHhwaHhVc0tpV0U4bGVIald1YmFBQlZQ?=
 =?utf-8?B?RHlLRUNMb1lmWDhhN2pkV2hOYWtXdjdaSkRqYjdqcElsV2czd1BJVW1oWlRw?=
 =?utf-8?B?bmFSaU10TlJRcWFFZms5c2JDNEphQXZnZkxpZEFrb0E4VzI5SEoyYUJoRnNv?=
 =?utf-8?B?Q2JQSW0zbVRGbFBEY0VEVG05cStZVHRMcSsyUTNDRko0NzJrcitCMHRFOVhO?=
 =?utf-8?B?SkxKNVNxcDNIMjNRdnExa256M25FbmNFT2FxSndIOHYxbWJ0YXVwYlBYdk1J?=
 =?utf-8?B?emxSck1mRk9wRHNIMEJ1S0ZMSzBkMGdJa2VlU0VwRGhtSWhNeFptbzJCcmNp?=
 =?utf-8?B?a0FBQ29XMVFjMjJaSndLMVlRQXBicVRPclF1cWVoak51d2hMaWNsODgwMW8y?=
 =?utf-8?B?MlR6N1daZjRxTDJ3UEpXMHJ4eDFnSlcyakM0RVZ6OTdkWTg3eWRlWHIrU2p6?=
 =?utf-8?B?bkpyMFdqOXhZOEZsbzVUTTFmM1hqeTZmUUtoaDFZVGNuOE1oYXlUYWZPTkd5?=
 =?utf-8?B?cXlXeStKVUdTbVZkQWN3Yit5YjhjeitLNGxUTVoxbnBEZFkyaStLUVM0cWRw?=
 =?utf-8?B?dVFaclZudE1HREc4NWVIcmo4TEIxVDZSbFBJUjRPTHJjMkpDc0dnRUpRV0l1?=
 =?utf-8?B?VGNBM2ZONUdGV1h0VWNRMEVYelFnMi8yc0psSlJoL1Nrc0kxWVJMNWt1YlNp?=
 =?utf-8?B?a2VwVW9Qa1pjRXoxY1RPWjJhNVJUbWZFY1kwMFdKdUFMNHE4U1JrTE05bHlT?=
 =?utf-8?Q?DWSJnmLbIik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8487.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjF1c1lYR0dKR1U1UWM3cjVOYnRJeEhrc3EwZkpoeVE0YU1TaFVIa3hoem80?=
 =?utf-8?B?a3NsQ2Q5QlBlbEVVY2NtNS9nSWdJMTAza09lTExNbExxOFQyeDN3MzRvMGlL?=
 =?utf-8?B?dlVRQmZYNTNmUnpUTnRVNlpjTHZqWm5tTDdaNlB0NDJTcFZSREEzZ1ltWSto?=
 =?utf-8?B?ZVdlRWt5NXJqdFpjakFpMFBLeVNnWVdXcVpha0pUQndNWTQrVkhDSDNNOGdH?=
 =?utf-8?B?T0tPQjRSRWZlRTMzVFg3bEFjMS9peVY2R2swRWhSWFluSEhRbU1SZEE4cG85?=
 =?utf-8?B?QXRqTkxBRHVaVU1SUmNlQkxsNG9PYjBsdkM0QWJZdlZlWXI1dkdIc1M4UGwv?=
 =?utf-8?B?ZHpjVE16Zko4WXJMWERmSXRiMFRDVFRFRTJkTlcwd2hNOXFYSTQ1RE1rcDl3?=
 =?utf-8?B?T2pzN0tVSUNiQW44MGUzd0g5VndUUDZzb3FDdmdFbkZYaWpuQ09uaEFiQUF6?=
 =?utf-8?B?NXl1Ky9TVGFMcmo2SDBMV3lGU0RPd2xqSTZIaXdOYmNrdnF6c3Jmdmx2U2xJ?=
 =?utf-8?B?L29BQ3JpYThiQjlnd3VJNFZzVVZCY29yU2xDOFhHbWgrdWNzYmlReXc5T1Rk?=
 =?utf-8?B?Rm8xMyt0NUlsekJ1Y1hNOCswNWNhOE1PZDczMU43dVo2eVZKdnV1dnh5WVNK?=
 =?utf-8?B?RWVCUGQ2U0FTMjR4Z3JRRDRST1lkd1cxN0NDWEVBRElTUWVWd0NrTnNUdDBU?=
 =?utf-8?B?Q0ZsN3dUWFlOVjR6Yi9iQTRtMHZQZDlQTFV3L1pOaTJNWlEvVDJaNHJudVQv?=
 =?utf-8?B?N05OYVFKNXRxNnMyemdHblVRVlV3VE4xNW92ank1ZkNzQ3ZuaENhRGVuNkpO?=
 =?utf-8?B?YlZidUgrTi9xcXVuVjNkN3pRWFlveG9FZDNxNTJieVlVM1JtSUJxMHd0U0to?=
 =?utf-8?B?Wnc5T0pEYWJneWVYM0w0c0h2QTVCd0ZzVjI2QUNwbkJXVUZacmt2T2cxTnZI?=
 =?utf-8?B?Q0FGeXA0TUdZTkFrTkZ0RUFMeUZNTzV1Wk5HbU9Fdk5HRHY1OUpjbDZ2b0NN?=
 =?utf-8?B?VExGQlQxR0U1VmNGL00rNWZhdnVLbXZlV2Y4NGdYNU1icTkwTGRzd3J1REFz?=
 =?utf-8?B?MGVoWi9JNDJNdnFra0F5dm55OHdCZXMzNkV6c091OTY5MFRTTzZWTUxsVCty?=
 =?utf-8?B?WW5sdUJKb2NMRmY3SllHcVhZRDRVYmRtTVNIVzVjeWowRnQ4cEZCbkFRM28r?=
 =?utf-8?B?cjVqQzBObVhTbiswaHN0eDBLMlRaWXgvQmxuS2hmd0dUSkUzaEhXWEdLbng2?=
 =?utf-8?B?bjRkbWlyMmd4MDF0czc3OHVvTXpYMmZmZXUrckNOSkppRVNveDRaMDQ1SmV4?=
 =?utf-8?B?eVhTTTgvVTAxOE5VTzgvbTFqK3ZyVTc1QjJ5WUt4UTdYS2ZMM0V6ODRCSllo?=
 =?utf-8?B?clhCYkNBUEVVdEVtS1VYdWVHaXJMYVJCaTNQdWlKQVk5dEROQ1lPVzJrVUpC?=
 =?utf-8?B?ekhrNVh5NEpCV21Ca1BQRmIvK0tydVUvSHVWY1ZqYkJqbjdhWTg4Q29GWWVD?=
 =?utf-8?B?dzdkbU9lRHBJMEhOM0drVkZEVEM3SmJCOHNIR2FRZkdITm5na3BOcllTVG5J?=
 =?utf-8?B?RmpiZUI4QTJ3KzdVRGNtczgreGVyd2dBQ2xDR1ZqZ2xYM3BiYldicnR1Y1pC?=
 =?utf-8?B?eThWdzBrZDY4OSs4UERGby9aQ0hYbFAzSWp3MEM2SEl1WXpmd1FoY0NCSHJ0?=
 =?utf-8?B?RGtyS1h2S1VJYWRkelpQMHBLVDdVaGJXUElIWUhvUjVWNVlBeW56N1dLRDU2?=
 =?utf-8?B?SlJ2S2Q5MHBIQkgzd1lkQ0JWWWVkZkZCRjBxeDNXOUQrQytKdERGdWF5SUw5?=
 =?utf-8?B?RThEc3l2M3huN01tNUR5RkUrSWVFVnRLT0FJQmhOSHdoUU5sZTM4eXNLamwz?=
 =?utf-8?B?bkxVUm1yVDN2Z2w2K2hBdG5RSEdVek0wc3AxRk9DN3NOZzZzR04zSFJYUmxI?=
 =?utf-8?B?ZzNYZkNia0hvRXZ2bGZ4WXpLM25iTDl5ZWFzdHRENHVNUjBnU05Mam85UHho?=
 =?utf-8?B?TE9qR2tFaWRsTHhDVVFhcmQ5SThUQjdoVlkrNzlqd2RydWRHQkFVZGUxVm5k?=
 =?utf-8?B?UzFTT1hmV0RqV2d3SkhZK21wd1ZMeFN2eFhPNitndzNFVTZJUExXNGdnVW5m?=
 =?utf-8?B?SXdXc2lodjZxeXJ1dUlYTXp4LzlybHdvcmpmY0NvcDI3M2prcmhrdUU5RXVx?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b473be-853c-4ecb-affd-08dcabe3fe65
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 13:24:49.5755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSNh+qWOmrHSKJOLQ8NsHksu/jUbaRmr5nNL9MVkmtg4+ZKcDiavAtD0x1UWRTp85tnAaoAok3+XOM6R2kAQwjRMj6hjj88uekuy8J4TT64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7998

Add the pinctrl node in the device tree in order to enable the
S32G2/S32G3 pinctrl driver to probe.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>
---
V2 -> V1: moved the pinctrl node before the uart1 one to sort based
	  on the reg value, removed the status property, renamed the
	  jtag_pins node and jtag_grp* subnodes

 arch/arm64/boot/dts/freescale/s32g2.dtsi | 50 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 52 +++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index fc19ae2e8d3b..fa054bfe7d5c 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -114,6 +114,56 @@ soc@0 {
 		#size-cells = <1>;
 		ranges = <0 0 0 0x80000000>;
 
+		pinctrl: pinctrl@4009c240 {
+			compatible = "nxp,s32g2-siul2-pinctrl";
+				/* MSCR0-MSCR101 registers on siul2_0 */
+			reg = <0x4009c240 0x198>,
+				/* MSCR112-MSCR122 registers on siul2_1 */
+			      <0x44010400 0x2c>,
+				/* MSCR144-MSCR190 registers on siul2_1 */
+			      <0x44010480 0xbc>,
+				/* IMCR0-IMCR83 registers on siul2_0 */
+			      <0x4009ca40 0x150>,
+				/* IMCR119-IMCR397 registers on siul2_1 */
+			      <0x44010c1c 0x45c>,
+				/* IMCR430-IMCR495 registers on siul2_1 */
+			      <0x440110f8 0x108>;
+
+			jtag_pins: jtag-pins {
+				jtag-grp0 {
+					pinmux = <0x0>;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <166>;
+				};
+
+				jtag-grp1 {
+					pinmux = <0x11>;
+					slew-rate = <166>;
+				};
+
+				jtag-grp2 {
+					pinmux = <0x40>;
+					input-enable;
+					bias-pull-down;
+					slew-rate = <166>;
+				};
+
+				jtag-grp3 {
+					pinmux = <0x23c0>,
+						 <0x23d0>,
+						 <0x2320>;
+				};
+
+				jtag-grp4 {
+					pinmux = <0x51>;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <166>;
+				};
+			};
+		};
+
 		uart0: serial@401c8000 {
 			compatible = "nxp,s32g2-linflexuart",
 				     "fsl,s32v234-linflexuart";
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index c1b08992754b..b4226a9143c8 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright 2021-2023 NXP
+ * Copyright 2021-2024 NXP
  *
  * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
  *          Ciprian Costea <ciprianmarian.costea@nxp.com>
@@ -171,6 +171,56 @@ soc@0 {
 		#size-cells = <1>;
 		ranges = <0 0 0 0x80000000>;
 
+		pinctrl: pinctrl@4009c240 {
+			compatible = "nxp,s32g2-siul2-pinctrl";
+				/* MSCR0-MSCR101 registers on siul2_0 */
+			reg = <0x4009c240 0x198>,
+				/* MSCR112-MSCR122 registers on siul2_1 */
+			      <0x44010400 0x2c>,
+				/* MSCR144-MSCR190 registers on siul2_1 */
+			      <0x44010480 0xbc>,
+				/* IMCR0-IMCR83 registers on siul2_0 */
+			      <0x4009ca40 0x150>,
+				/* IMCR119-IMCR397 registers on siul2_1 */
+			      <0x44010c1c 0x45c>,
+				/* IMCR430-IMCR495 registers on siul2_1 */
+			      <0x440110f8 0x108>;
+
+			jtag_pins: jtag-pins {
+				jtag-grp0 {
+					pinmux = <0x0>;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <166>;
+				};
+
+				jtag-grp1 {
+					pinmux = <0x11>;
+					slew-rate = <166>;
+				};
+
+				jtag-grp2 {
+					pinmux = <0x40>;
+					input-enable;
+					bias-pull-down;
+					slew-rate = <166>;
+				};
+
+				jtag-grp3 {
+					pinmux = <0x23c0>,
+						 <0x23d0>,
+						 <0x2320>;
+				};
+
+				jtag-grp4 {
+					pinmux = <0x51>;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <166>;
+				};
+			};
+		};
+
 		uart0: serial@401c8000 {
 			compatible = "nxp,s32g3-linflexuart",
 				     "fsl,s32v234-linflexuart";
-- 
2.45.2


