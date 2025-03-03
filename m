Return-Path: <linux-kernel+bounces-540929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4744A4B686
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2441890C87
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBCF1CDFD4;
	Mon,  3 Mar 2025 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xD4iZ3+I"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A45AD27;
	Mon,  3 Mar 2025 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972512; cv=fail; b=V58RE68HGnWQmPONeJYKGJzKs6SPRICHHVv5L1GCzpd4DqeR3yYdFK94d9fjjcEsGWOKG97YFqIicIf068G18kgxzNA3goOXWScDdV+UGAzOG6vuBVUrEQEZGD8c+fd0npGEhxv9T45wab5yYsS0HPl0eiqyK9/NHrlmKzCH7Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972512; c=relaxed/simple;
	bh=XMGvxyvzSxS8zJMU0Nl5DTqvGIgs3LiY/gK/dYawxs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PDQeLDONYbK+Sagw5dyxGilWlPhu7+/OuqjJwbeZD16yiidd1A8X3feErPDhyuXcXAxIqlzzqV5v8KYj9iy2BmeAx2p3qwUrQnUsQTvbhXjQxPQMxkWnquISDnrSiJGFu+FNNDD6SbYpdmmfxbc1MeacoJLDgxURFg5j3+wB4Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xD4iZ3+I; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/Z1Ln1E3mCWxHmoPmxAH0f1wmS01tnLVQ1CFNVIjYv5UqdbdSICH9M/51rnG/PHdl7lffHV1LdPvbeLDe6Ccor5mGZUkEFflwC7WLUauFWBaZBPV5TolP59Tnqo457qWctjScJiQNqwVoGa6UeKma5CUs28VXHoEU1Gmt5cBae1IkqnIhcgPmvMvrTbXE1nbBT6HupWimh+bJydi320s1j4H9Agy+LBU/lCv3hLkqqkAWJBHCqxVUxNy1yEQlK6j7N8G9TS0dogLXuhTC7IGxdhG3/xR3MHReVVJrMvb6ZDomN2S4goETeIhhhSoVwq7RC1Tzj6mgdY00TVhIq0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMGvxyvzSxS8zJMU0Nl5DTqvGIgs3LiY/gK/dYawxs8=;
 b=pylmwsjZ2MM5+CHja7VOyQ6jMowsLUqc0idqqtfRVDdksqFv4oaxCmaz6rzcidB4EQaVfFdbyQWb71WuEZHYxBmvQDg0eJVu4/kJrCssfCz6p27NKqS8f0KjHdPzo8NdPz3VwIjBdeNKjfn2gySWB6DO0Bdnduh18uOtA3jqrV7QPhSuCf2NCYc0g1orOn9HBmI56ANWkpRfXLFjEZBZfalhCROuQkIKKtYuc0zNqwBhFa3ZaIGEw9KHboMjlFPVSNAOem3yr6ybJPTUEtLlb54Ve9PdgrhT+Vs9bNSibb/pNL+1g+rVvcAu0kV7kCXneJ48mFzeRQJEFG6YEDQwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMGvxyvzSxS8zJMU0Nl5DTqvGIgs3LiY/gK/dYawxs8=;
 b=xD4iZ3+ISH7bklImlv3LrCdXOg+qLoQm4pSRMVWaXCK3SsZy9UCwu0m9hHWwxo8LCvqhL3x1HxgbseX0lsLBtcKgWVlN+sR4Y/6XbXrxgfp8xPnEL1G4mQQ1lSNaxU5j0zNJsRZNc0AInjmTkjJTHVKAEiHt5hRF21KEQ6kfOaHQ6trQleZSAhlUsNFTwibyxbT3eehCQfYErDK63NVC4HPAA7uA0nb1ZoGSnsZRxhOQxKqn9W09exOG/HESJwx5gLMZRLfPB+mH+uM6ljRtukcPdRTndfzoPDFD+6xENGTNpEp27/j0pBNNIxpxeqPKKU+zp3nx3ktxHIkzlkqQmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 03:28:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 03:28:26 +0000
Date: Mon, 3 Mar 2025 12:35:51 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, saravanak@google.com,
	cristian.marussi@arm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] dt-bindings: firmware: scmi: Introduce compatible string
Message-ID: <20250303043551.GE13236@nxa18884-linux>
References: <20250226094456.2351571-1-peng.fan@oss.nxp.com>
 <20250226160945.GA2505223-robh@kernel.org>
 <20250227030924.GB11411@nxa18884-linux>
 <CAL_JsqJOqKeDRuASWxCT=EA5LJbONpCX=Re8=XxKUbPToWy2Dg@mail.gmail.com>
 <Z8HCZQQLofaiGtpG@bogus>
 <CAL_JsqLePri5m_dE989poUV4auasAxFvgAiYuXVuZHqLcOBGMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLePri5m_dE989poUV4auasAxFvgAiYuXVuZHqLcOBGMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: babc3737-6ba1-4229-6591-08dd5a0375e0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qnpzd1dzZWt5Unh2aWZKdkNlZHkwenVWUVhBL0ZmOGVxbnVwWm92SGpVTjA5?=
 =?utf-8?B?V2RzU2QyVS9zaWo0d2w1VVJkVFkzRUhBL1FOcTJQQkxxVzQyRnJ0NXZ5dExy?=
 =?utf-8?B?emo2cWJsRHIwOVVtWXNSekdWTFJFNjAxOUkyeFRsTUhZVWQ4cTlhempiZEZ5?=
 =?utf-8?B?TXc2dmRLb3p1STAyTGZCakFsTXJUdXM4TmllL25uK0dPN05zS3N0RHAzQlhQ?=
 =?utf-8?B?WEJkOC9CQUxGamp4NXpVaDhQL3d4QzVualc2cDU4RWhLKzdTd0hPVmVKWEJ2?=
 =?utf-8?B?ZVA4cjdGSWNRdEVlVS8vOW8xTENuRnNCRzdjcXFSMGpNNzhTd1NCOWZRNjJu?=
 =?utf-8?B?WHhnMDdvUlVFaVM2akRLZTFVeENCTWJLM1Q0WDM1UE5kK2pNb0FnalFmQ0lE?=
 =?utf-8?B?RzhjbmtEWWYzUmdWY1lIRGhkV2NQWlQ1Q2dEOElvRHRkUEJ4Q0tIc2lRVU9Y?=
 =?utf-8?B?L28zU2liMUF6UzRoRHEvYWlkWnlFYnJPMzZibE8vbXVvcTR4RjlYMmxIRlJ4?=
 =?utf-8?B?TFI5UTN2OGM4L1BVeEV2bTJnWkY1SVd3VWt1eTRyOWlZb08rZk82UUhkTTZu?=
 =?utf-8?B?aGRxK3J6WkdPb3l6Vkl0aGpxRE1yOFIvUDhTaE91NGMvTW5PVnJIeFNDYS8x?=
 =?utf-8?B?R21Fa3I1RHluZlBYZ1JMdWVXN3E2aEdOVUpxc25HUHVFZmx1NW1DNnlWMEpP?=
 =?utf-8?B?WXlJRXJXZVBOTXdrMHR1cS83c3AyMTRGcHdQVW9XUHB5Ukt5U0pkQ2lQUUF2?=
 =?utf-8?B?ekJZRTFnUytpcWZ2QThoakdEaFNic0FuSGtXRmpMS082Z0JzanQ1Si9pS3hK?=
 =?utf-8?B?VnJZKy9XK3IxZEpIRGoxSHA0YjNQSDVpRUsxMDR1ejhtbDlhdDNsdU5RbEI5?=
 =?utf-8?B?VTBXK0JEdEYzTDNxYkdZalpSL01lM3hZbGJ1TnUzODMxdG5WTzQ1Q21rN2NZ?=
 =?utf-8?B?a0E4UHhCUk1mMUpNLzljYnZNNUlKdm5wRDk5ckxtYmJQdU5oMEE3K0dZY0FG?=
 =?utf-8?B?aC9WTCtURU82RzlVK3ArWVpVd3lHeDJ5Z1BlVXMvUnZyOVp2bDR6cXVDNHBG?=
 =?utf-8?B?QUYrZ1JQOFlpWVdpSHVoWVM5clAvY2lvN2ZMMjErcWdWb0RmVTRHdjRyMXdW?=
 =?utf-8?B?Y0lkbjJBcW1BRVA4eWdwbTlwbDRDMERPaXlKT1FReGU2blQ3bjZRWlE3Q0lU?=
 =?utf-8?B?RlVFK2l2NVpqN1lsZmROTXB4RTNWQTBVKytMSDFZUHpCUk5xSEo5YThwd1ZG?=
 =?utf-8?B?YkhJZitFYmc4d1d0VTY0RDVtSWltWVQvM1RlNStDZW5vTHl0R2Y3TGhwUVg0?=
 =?utf-8?B?YmNhOC8wdis0NytKeXI2T3RZNEJpYTFBbkxXVHBvdkVGZUZqZHN2ck9JWGxG?=
 =?utf-8?B?RU5Nc1oycnJPVXAwQzQ5K0NzQ2d5bUU4RTFsL0lZWHJZS2FFeTRMam5XRm15?=
 =?utf-8?B?MG9HTjAzSDRXSXhObmdQLzQybncyZFZ5MUVaY3A3U0VUZGpiUU10MTVVeDla?=
 =?utf-8?B?QXlPTENtc1UyYUZ3Q3RKYW14alRhN2dDd2Y3WEhRQ282ZzRiZ2EzMllDZ2Na?=
 =?utf-8?B?ekRTVWRBYmJybjN1ZUV4c2tkN2NZMjRvWm5WbWFJUDRjdGtmdWtkdW9mSm5n?=
 =?utf-8?B?ZEJtRDlFK0pVT1lQb2FuODdhMzFnZ3dzYVNHWFhDbmU5dlNHR01ucGprckNB?=
 =?utf-8?B?b3E5T1o4ZU5sb0xObHh4YjRabjhRK29wN2J4VVdIZVpHVVpHbm9XYkNENDFp?=
 =?utf-8?B?ejhSNUNDSnorYmVFZUhlMjBMeE55N01aOS9ZRVJVY3o4b0U2dTI0WnBkbStD?=
 =?utf-8?B?WlE3R2JPS05SM0lKdTJzMXI1OXZtVlJKWFQ3QUlxcE5BWXZOSW9qeDFOWmd6?=
 =?utf-8?B?YkNHZHdLNW8zRDFlL1BITlF5cEFkVEtxMXBRL3ZEY1M5dytjaERyNHNZVEdC?=
 =?utf-8?Q?NAt9vADbwI11fwqU//Cn+Kkn4QLPY8ho?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU9uMFVGckFZbUs1Z2FTNXNGNmxxNFNneXdFUkJmdE9XbU5qbkZ3VlN6b3dZ?=
 =?utf-8?B?UzlPNVFGSXgrZXkvK3pNYmJMSEowTnMrajhkK3FpWHZzUjZVb0xPR1ZVeFls?=
 =?utf-8?B?QWpPdXdxMk16dkptQmRHbXd3a2JxZCtvZGlSamRDNzlUaWxXN0pvTHIrNk1Y?=
 =?utf-8?B?MFlEY2owREFoUXBnMzE4Y2pnMXZtUGlla1NCYzlQS2RMN2xzcWQ1OXJBRVRu?=
 =?utf-8?B?N0FPVDJ4ZnZVTG4wa2pXMk1QY0ZzbzNvUWExWUpzdWQ1V3gvdUFWc3o1UWN3?=
 =?utf-8?B?L1NGZTNoWXhHVFEweVRQR0s4Wm9ucUtkalowZ0c5alF0Y0tLSlhxTWcvNnho?=
 =?utf-8?B?MnhrV3VTZE1nMXJTeW5QTTIxT0lBTVhVd3FmM25VVkRoNWNyYi9zOTNvRTFO?=
 =?utf-8?B?U3Z5MGlHZ2tab1B6ekY1Ni9vQ2p5MlRSZXQ0WkdEbzAxZWJYTlNlbVFVSFBy?=
 =?utf-8?B?SFRSaVRyamRabGF5TFE3dlBIWmxZVDY1YmNRaGFCM053enJDbjg0UWNXdlFD?=
 =?utf-8?B?NWt4Y1lmb2l4Rm1xZEpxbTBiWlB3cmpJT3JxTFJXU3gxSUlFTmdmay85ZzIx?=
 =?utf-8?B?QTEvZEVmV3J0bFBISkc0SGJ0U05uaGtGeTRuNi9LQ0tOc0t0UzBQL1FIRmky?=
 =?utf-8?B?eXZGZC92cmRSQm9RMWxXTHFnM0xMUlFTZzlrMDNMN0NqQ25XVGJ2Ynk0NnBv?=
 =?utf-8?B?ZUNNNnNiZ0x1SHZjYk9wUFY0RjFmSkNWYytTV1psWlFzZzI1TFdDR0hrZTNU?=
 =?utf-8?B?bnErQW9BWGRGcGdDelI3OHc2dm0yb3J2WFQrZEJDVktUdXVKSndUUDFxblgr?=
 =?utf-8?B?bDdHQlR2VWRqWmhSWmNvbkppWHM5UXh6RUhwWUt6OTdPdERyMUxyMDFZU3hR?=
 =?utf-8?B?U3Y4emxZKzQvbkIvQzY5bGdMMW9jU3JJQ216SVo5dmlERDVuRC9LT29xd0Fv?=
 =?utf-8?B?bDFwOXpJRElsRkNnQUs3dExIWjFWaHl1M1JwdTVEdDR5bXI5b3FnU0kvMno2?=
 =?utf-8?B?Vk1GWDZuQnpZaXQwTG41dzJ5UXZYYkpDWWJQUVZnaDJBSW56d3RxVHllV1Ew?=
 =?utf-8?B?WXF3bkhPcUdpaVZIRE9WV21GSFVGS3VpMUZCTTRpRHJKQlhqMTZrSldBOVFG?=
 =?utf-8?B?c0pyMldYRjltWE52V3o4Tjh0U2o1amV5V3huV0VxSUMwd2t0WURhenZUT3BH?=
 =?utf-8?B?YVk2cTFCeWZaSGx6Zmg0dThiY0IyMUo3QSt0VE5xVkNhekJjVHhtSmpLTDR4?=
 =?utf-8?B?andBYWxBdkIxQmJJcXJvTkFJRUZMVVJyUzVvNmNoMDVQcXVGalZnV01aK3JW?=
 =?utf-8?B?ZmVHSTZZU1Q0SjQyZHU2b1ltVWswRDMvci8wMWpSOEUraTFaN2VkTkR4YU5K?=
 =?utf-8?B?TWRuTUdxeWc2RWk5ZVJFSmtEbld6SjNNRys3Vm1Qb0ZhTUYwdCszdHc1ZWtF?=
 =?utf-8?B?M3JkeTg1WDcyZFQxNStCM1dJamlhUmxTOU50YmpoQnZpWk1iaitROHU3aDBw?=
 =?utf-8?B?NjBlRHA4OEFpRzlkQy9UUFdtVlFhbER1eTEybDlxcXdBdnZiWVNMc1ExeDhH?=
 =?utf-8?B?THovenUyeGdrTmhBZ0tkTVErUlU4VDJpZmFROVoyTDFmVDdESVBZZVNsOSt6?=
 =?utf-8?B?TGJXK251RGU2TkhTMk1UTktlcVpTMjJjRGp2Q3J3MXAxeDgzdkp2YWlZVnp3?=
 =?utf-8?B?V2V0c3FReFpCNFlUTEMyeHY3RzVyTzhmTzFjOE5sbTNheXFPQWZKN2J5UGE0?=
 =?utf-8?B?QXJJT2FNRXoxVG9HTWJWUHlJcjNKNzVhRG9LVVN6Z3lDSmNzMU1iV1BEL041?=
 =?utf-8?B?dXJrWUJxUFNNZldSUEJsaVc2YmFtZUZ3UkpmU0JBMEd5VVpSM0RITWR6Ym5Y?=
 =?utf-8?B?SmtDZVJoZU5DOFJBNHU2bzVuWlYyRU4rbkFLTVJ3ZVd6TlB0eWxLSURteHpL?=
 =?utf-8?B?QzdFZ3YrNGc0a01MQXJERkpsVTZhbkFEalZyeVVkcVM1aStmYUxKc1Y3OHlG?=
 =?utf-8?B?RXpYckZqaGVXaXNBenpoQWQ2RHI1YlhBV2MxVVZMVTZaZlVOakh2TlV2VlFs?=
 =?utf-8?B?dmJ4aVVKMHowVVJPYnNCVWV1Q3Z0SXdKNlEyeER4Ni80cEJKOU8zdG8rWk55?=
 =?utf-8?Q?zBiqk7hwgHLnTi/I5TPqyyQ6I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babc3737-6ba1-4229-6591-08dd5a0375e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 03:28:26.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBV10tNVmW+Pe2zxVrgqtfgcXKEoL/kOk17VAM9NMlmCIInq9+W/5V7eCwI01VfZxrKsgtBDlJSNgVZT7QdvWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Hi Rob,
On Fri, Feb 28, 2025 at 08:17:03AM -0600, Rob Herring wrote:
>On Fri, Feb 28, 2025 at 8:04 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On Fri, Feb 28, 2025 at 07:34:09AM -0600, Rob Herring wrote:
>> >
>> > - The parent driver creates child devices. The child devices can
>> > either reuse the parent DT node (i.e. set dev.of_node) or just get it
>> > from the parent device if needed.
>> >
>>
>> This is exactly what I was thinking to deal with the issue since this
>> discussion started. I will give this a go. I believe this must solve
>> the issue, but I didn't want to spit it out loud until I tried to hack
>> and check.
>

>The issue with fw_devlink is that it only checks the dependency of the
>parent which won't be enough. When the parent's probe creates the
>child device, that doesn't mean the child has probed. The child driver
>might not be loaded and/or probe is async. I don't think there's
>anyway for the parent probe to wait for child drivers to be probed and

Please forgive if my understanding is wrong.
Based on device tree, there is fwnode link created using fwnode_link_add,
then in device_add, the fw_devlink_link_device will do the device supplier
and consumer link. It is just device level link, not related to child's probe.

So if child device(work as supplier) is created only when a prarent's probe
done, the consumer of the child device will not have link ready and consumer
device's driver will not probe until the child device created and probe done.

Thanks,
Peng

>ready. I think there's similar issues with the DWC3 wrapper and core
>driver split.
>
>Rob

