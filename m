Return-Path: <linux-kernel+bounces-575594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D487A70493
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F3C1889794
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C325BADC;
	Tue, 25 Mar 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="l0Z4S5SO"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16E25B687;
	Tue, 25 Mar 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915172; cv=fail; b=gUwfV6d58GHGdOG6WSar+krpy2ua/F8F5Wa0+AMq2JubkNEt4zjyunIixuNQclBIuei0Nieb6S8M1Mna47iuA5Nv8ZHJCjCuyd98NHeMM41scoK4E3851zQ4ekqpgwP6CBhXvWhPwn2Ta+wJFCewM550unE0oMFaxEdbd4UlfyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915172; c=relaxed/simple;
	bh=gPW+rlNZ6Aea6kKxDEMcfv9RW0W8eP+JOQ6GV6GrlyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K23PJ4QPbqm1tOiS5PwQW19ArmjmAku1adx9E1XWS7D8Ysuef6aRY+XWoE0FSDa8iTnjMTxbXdzP69jdoNJL45eTizYkoT9LNYyHCg3KptkrQhbcsXEMNMT48sa0tW2kBINwBy1psn4nufOgdNIWyn6V5KqPcctRY0nyEvnKEAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=l0Z4S5SO; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmL3nsheMvc7UAKLpdPE2nHDgCYTPnuTGqszumTsh7io1ioFKABjZDVuuGe9MJLmVIGxKl7gjoRqpN/xAvqPKV/wP57sPF30aSO2vNuQAFH/TFSMX7sPoINuAG0Z5hMTFI5zd8jrnjFzDQ1WwRau9QbUjlCEj8RJNmvER1Z5Q7LX1ag5/2/Gjrm2AFrx3cRRi1VGTCs63Uwsf0Eqk4miRjXpLvmXnHhnlCueobieTrA4q3qFXcTCjhGRmuu0XjskLzeSjMsG5Jm4/16PGoNfWwSulx71uIMTtrpAipN8h/Qn2WjsRAW2iUs8eDwEFwMUKcDnNgZnJt8d3dAfax4j/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Edha+6hYsE+urgD1f18Wv6vFKS3B2jZHR3FNNHQ8wfg=;
 b=qMgywXgWk710o67qr7CBm6nEDRK1Wr5vVutC6oxUMjiNS3WLOSVBaDKXH3A4MPnYPN6/y0mPPN+KIGwiAILJxxvZowT/xBK5bt61e/Ugw5VCmkHy4ZFFVyEi9cMHpmH5fQcxDQbO3EGJZ7vqRh0RIPNCurGG0Bd2Ui/TN7YS9nKcIMTf+ADeT3NDE6aEBB68geC2LMMoEIgYyFEKdEHsacnzJeFeKl+35DTZlBv3PcFMihV053FEZhjL9dkkqLLTCqS4DV/YQoZehi/hiprYXB3pZ9r5OAf5xK4BLOa+M4y7Ejq/Hb1TV+BZl4bK10ssr6PNKnejmhfbM/IEZmmO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edha+6hYsE+urgD1f18Wv6vFKS3B2jZHR3FNNHQ8wfg=;
 b=l0Z4S5SOx63FL1otkLEMMZbrPGaO8ZOVHULcbscqZuBZnOLKQEWBxwGS2foKCIZ2oO/D/6WBJC6pJOUEbU/ONBZStSD9e7mTNjq3PJVoy+WuRt3ZikM51zJjKPQGBdj5Hy0ApyCXO4w4qaNXwAVUPDOWP7cjP3X9r7VScskFJo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8120.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:06:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 15:06:02 +0000
Message-ID: <1a8ce12a-9335-444f-940a-bef3cf86318e@cherry.de>
Date: Tue, 25 Mar 2025 16:06:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add overlay for tiger-haikou
 video-demo adapter
To: Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dse@thaumatec.com, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250226140942.3825223-1-heiko@sntech.de>
 <20250226140942.3825223-4-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250226140942.3825223-4-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcc41c5-e5ee-4ab8-432f-08dd6bae8e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUd3ZzlBRlJpVGlJS3VyWEtRVFVUWGtJa25iR2Zld1FWMDE2MUJYK2xGZFdq?=
 =?utf-8?B?YkdOT0NFcUVVTS9mRW9RQzRJMlJ2TjI5UmMwa3JTSldsZDJobkFHVHkwUzhO?=
 =?utf-8?B?N0JXbEZEK2RIZ0tkazBHYW9wcENFakRVTUtJeHdvUjRYQWdvdGVFaVF6Rmhm?=
 =?utf-8?B?c003UEgxN1EvWllEaFNSdnlROW04MEJKalRsT3BBZk9SdjNuOW5QWXRKaEd6?=
 =?utf-8?B?SmRkRWo3cnlxSUcxN091TkxOK2dsUnZKT2dsRjN6Q2tTVWEwNzJHOTUwR0gr?=
 =?utf-8?B?aDh0TjJzZ2JNY1RTMFRSbjUwTmhjdTFYd3JWdTd6bU1aSGVKNDdOcnNGTXJz?=
 =?utf-8?B?elBjczBpR1FycVJuS2s0VmFaUHlXOGhnN2dWYjlEaEw5SnJBeFNTMVFRVW1y?=
 =?utf-8?B?TjdUZmtxQTI5cnByYXlDL0x0blFPRTA2RndwbG5rT2xObTlxVEsxckp6eUhG?=
 =?utf-8?B?am9oSFp5M1hKM256U05LcWJMNWNpdzlsOXBZeVRKckhWVnBDUk5wVGZuSEky?=
 =?utf-8?B?Vmh3VFlndVVOZDhJbHpQcWtUbi84Sk5Kbk02KzRKUEdqNjYxSUkrOEs4ajAy?=
 =?utf-8?B?R1o1ekZESmYydHBmVXZnUUpTUmhLc000RVRlRDZDOW4rT0hiOVowRkhUQ3B1?=
 =?utf-8?B?UENkM2hpNTRzNDlKcWN2R3dGVHhEZFQweVFWdzZ3Z3F2YmZaa3Q2UzZ4R3Zk?=
 =?utf-8?B?SGFHOTd4WnF2SFpxNEt3V3h2WHNSdUJpNHdPbSswVkRtQzY1QzdmdHpwMXhW?=
 =?utf-8?B?clgzOXAvV2J6cG9tYzdaRU54MU94VU5EUDdzUEZCRGJEenlWb3F5U2N1VFd4?=
 =?utf-8?B?V0FwaVh6eVNjdDRRQlNlbFVNUU9CekxDZW5jT0o4TEVzelJaQkoxTUhpQ21r?=
 =?utf-8?B?Nk5GRHV5VkpiTUYzSVJjZ1VKUU9veld2VWVLaGFHSSsxMlNVYW5YK2lNbjk4?=
 =?utf-8?B?SmN1VkIxVGkzV3ZCNjZROWJQdUNqUlZrTm9LSW9iV0l1bUE0Kzl1MGhNSDdx?=
 =?utf-8?B?cTg4eEozeWh5Zm9hUUdGVUlaS2xLUk1LcER6aXlTNlNPYmE0VTNjYUNIUzdT?=
 =?utf-8?B?VWFGcDdyVDFoZ0Zna2ZEN3E3SlVkaGsrRVc1R0cvSHFSUmFyRWJ6Wk4yUW10?=
 =?utf-8?B?M0VRUFBSYk9JanFCWEI2TVZIRllhUlVqZGU1TjBydkRuY2VkSnAzNDBjZ2tX?=
 =?utf-8?B?M0ZwaTYrWkltYktuN1hkVlZyeHFueXVmNWUzRUVySVdCUmFEZGZFNWZrY3Bq?=
 =?utf-8?B?VzZIZVB0L0U2b3gzQjU3cWtiRlExSGVROGpSTldWRGxEUkMrZ0p6VWxZYkdy?=
 =?utf-8?B?SVdhR3hWM2pOZ3JreEl4QXJCME5xZWJ5ZUltVGxHYmhkUGw0MGpmQVIyejU5?=
 =?utf-8?B?K1NOQ0lIQTNTWHJtNFBzdHJYdmo2QzJCYW9DM3pjT2xMZWhYWno4Z09YNU1z?=
 =?utf-8?B?bmRxQ0o0YXB0S1Fwa2xjelAvMG5mMStkZ0lPdGpBK2dpTDQwcFFvYXo2a0VU?=
 =?utf-8?B?U2k4S21qSjYvdTAxZHZRTHg0SEJOK3VCblY2Sm1JNlJjWHlHbFBZVXNoSGhX?=
 =?utf-8?B?eDlyTmU4NkNOUlRMUWxuK3JKRFQwc25IdWt6VU5zTTdCQWtGdS9EYnZoaldN?=
 =?utf-8?B?bytUVFN6RFJka2IvbUlkeFBBeFJLRGxCOXFpbWcrN2M4SGpjekJNOXdFajdY?=
 =?utf-8?B?WmtidWhnSnFWb0p2aUFVaW5zbTBhRGhteGJHTnpQbFk4cFNFK2hNcUNjdXBY?=
 =?utf-8?B?b2lHTEJzNWFLTGE2K1ExNHR6bURzSXlQMnpuY2p2R1JPMTVnNXBHY1hMRDRv?=
 =?utf-8?B?TnlzdnlBazdnUmduamd2QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDkzSUNFMmtxRVcrVmRIeld3ZFlkYStXdXB0U1FWb2pQMmcvUWlwendKSEFZ?=
 =?utf-8?B?ajY0ZXN2Q29VRUtqOFhGVzFLdXhuYlVnZGZPUUkzS1owZWNYdzBHdU9sRUlj?=
 =?utf-8?B?TUJxZmc1QStsc1Q1RzZCd3RGT012bVhiZ2xxR3FRR0dQSitZN0k4cFRrbkZB?=
 =?utf-8?B?YVhCRkY2TWlQbW4rbEkwMUw1ekNoWE92eDVWbjhxdVBKUC9JZXNDZjhnSXpm?=
 =?utf-8?B?NTdYZ3JNb3gwUFZNQkw5dzFLQndUdWZSZjJNeC9iUXEzVm5pT013VjA5TWE0?=
 =?utf-8?B?Y2poT1krL1Y4dmJzRHVjY2VIRDlHRW9JZlpaN3pUV1NOQm1aYmhjbWtTR0xs?=
 =?utf-8?B?d09TdGNHcExYS0Y5ZVAwL1hzejB4TU5sVlBzQ1hKaU4wK01zNXRUNDk3Ynlu?=
 =?utf-8?B?SDVrV1FzQkJNQkxxd0ovaVRZN3JQbHVsTVhZbk9KaVdjQ0IzSDNpZFVxZFk0?=
 =?utf-8?B?QlcvMitlUWxySjlNTUtxUU5ISUpyb2U1QkN3dEtRbk4xUzRNSkYyakFLWGw3?=
 =?utf-8?B?VDFiSUtaOWVFWWp3V2g4czJvanJkK2svZzVJdmJTNmUvSXR1SXhDd1YwWjBT?=
 =?utf-8?B?Y0ZaMlY3Wkl4MmFKSXh0Nmpnc25HV3puSFpQbkdmTWJjSWZoTHRMUVExcDA5?=
 =?utf-8?B?UHZEOU80Wit6ZCtTS1hqZERIR2h2T05NdjI2QnlCUVBjMyt4Q3pGVVlSWGxp?=
 =?utf-8?B?M2trWllBUnhmOHVuallkS3dVRUs4dlBCL3VhejBhVDVQUC9rb3ZPazF5Mk44?=
 =?utf-8?B?dGxlcGNjWVpIU2Y0NlMxZjZ2WWNGWXpBVjFjU2tqbk5KbXBsWHZzR0lMTytu?=
 =?utf-8?B?UEtsbmJxZ3RIcDdkbUVXcnpmZXd3bnB0OS80WGVuZkMzNU0vcGlQYnhhNTBa?=
 =?utf-8?B?SXhXQnExcjgwSnc5MXBjZWd5ZmZoSkREYjFxT3d2emxsckgyaERpSmVQZVpn?=
 =?utf-8?B?anJaK3lwdCtwdmNud3NGUmdGaGZKalZKeWkybzYrd2VmcmhzT0dkc0lRelZJ?=
 =?utf-8?B?c1ZGRzBpc3I4T2dzekdSQzhmVWZ3QkRNdlB5cG52RFJVZE1EWkJzSkZGMWdX?=
 =?utf-8?B?cXdpdUh3b0EzRHpWWG82SHRSWm94REpxQTI3TXJQdGdFVytuOXh4bGhxV1Vz?=
 =?utf-8?B?SVVCZUM5U0dseUIyd3JYYnRqby94bjRsaFJwek11Mzg2NmIxekl1SzFVazJp?=
 =?utf-8?B?YmhxNkJrU09QK00xcGhGbmlTWnYvbExlbU9kcUlpWkN6d3M5a0dmZzg2cVF2?=
 =?utf-8?B?c1gvM0lpWmlSTzZKRVlvOGVBcXE0WXlOS2xmSFFjZlJadEtVV2c0SWo2VTJV?=
 =?utf-8?B?Y0gwUDk1ME1IWUJUY0Z5M3BCMFdJd3RvYlExNERYUjJ3WmFxUWpTYzZqOFEz?=
 =?utf-8?B?dmEySE4xa1Zrckx2dHhOSm5RVFhpRjdzWUxiZUpRU3B0VWpkQ0FZOEN6NEMz?=
 =?utf-8?B?RSt1TUdmZ1IzVDllWGpCaWVTU2xEU3J5ZHRVVU00SGF4dUcxNTNZaU9VWWxq?=
 =?utf-8?B?T1VTYm95QXpMZ0ZNdDdkU25HS2lFa05lV2FOMGhKY0hPZkhqc0pGdUw4SWx3?=
 =?utf-8?B?cFE0OTV4b1h0WjV4ZVNzUXpXbXk4Qm95Vy9jV3dGZmlzZmpJbGRJQTBlcFNC?=
 =?utf-8?B?ZjVabjJxRUhud1dFVi9LOXpHWDRweENOZFpjZG9COGtDNHdNQktDS29ybnVD?=
 =?utf-8?B?NGxlc3ZhK21OT3NtWERHRit1Y1RBY1lURzgzVXIzOXRybkVtLzQrYjZuK2hN?=
 =?utf-8?B?VWJLVlQ5Mm1jWXRhdXptcXFpRHNOZitURC91cE1OWlF0d0U5MWpTZTVBQnZS?=
 =?utf-8?B?MkRpaEcrWll3OXVPWTNvZmZnZkwwb3JlWkl4RGRvYTBMRWcvYS9yNm5pRHJL?=
 =?utf-8?B?WFFLNWsvU0ZlbHp5ODFpdUd3UG5rbXhkMTIzWmR3WXNtYThaT0NHZzFHTmN6?=
 =?utf-8?B?b3h1L0dkeDBKQWp2R2JPU0NiaENZZTZRMXhtVTJFak5BVTZvMFFNWmg3MGFn?=
 =?utf-8?B?VjRMNWZ1MC83UnFMUllIcWliWXJob05HL1VVZjIwNlN2VkJtY2lRSG5ab3or?=
 =?utf-8?B?RG44Y1pwaFRlYmE4VEVvcE1LNDRyTXAwRlpuMWo2WStnaU1SeDZGcFBZQm5q?=
 =?utf-8?B?Q2tkVkt1K3RVcEpRalZYd3RBdlZxaFAvUWZGOFMvZU5SQWZCSU0wZ2Npbkt5?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcc41c5-e5ee-4ab8-432f-08dd6bae8e94
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:06:01.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kzzh7xq8uskyvc0rrTa+hy8UxjI/5WWqV78jIBcCigSN3hEaJAO8AwGUSdtm3DvQ3nTc5c8CUV99PMKpSYK58nGb4ZIBl2nr/V550uS9db4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8120

Hi Heiko,

On 2/26/25 3:09 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> This adds support for the video-demo-adapter DEVKIT ADDON CAM-TS-A01
> (https://embedded.cherry.de/product/development-kit/) for the Haikou
> devkit with Tiger RK3588 SoM.
> 
> The Video Demo adapter is an adapter connected to the fake PCIe slot
> labeled "Video Connector" on the Haikou devkit.
> 
> It's main feature is a Leadtek DSI-display with touchscreen and a camera
> (that is not supported yet). To drive these components a number of
> additional regulators are grouped on the adapter as well as a PCA9670
> gpio-expander to provide the needed additional gpio-lines.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |   5 +
>   .../rk3588-tiger-haikou-video-demo.dtso       | 153 ++++++++++++++++++
>   2 files changed, 158 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index db6017272ff1..4cddb5d2807d 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -158,6 +158,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou-video-demo.dtbo
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-coolpi-4b.dtb
> @@ -214,3 +215,7 @@ rk3588-rock-5b-pcie-ep-dtbs := rk3588-rock-5b.dtb \
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtb
>   rk3588-rock-5b-pcie-srns-dtbs := rk3588-rock-5b.dtb \
>   	rk3588-rock-5b-pcie-srns.dtbo
> +
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou-video-demo.dtb
> +rk3588-tiger-haikou-video-demo-dtbs := rk3588-tiger-haikou.dtb \
> +	rk3588-tiger-haikou-video-demo.dtbo

For consistency with RK3399 Puma and PX30 Ringneck, maybe we want the 
.dtb to be rk3588-tiger-haikou-haikou-video-demo.dtb (haikou + 
haikou-video-demo)?

The name for the dtbo is fine though!

Cheers,
Quentin

