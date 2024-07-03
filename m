Return-Path: <linux-kernel+bounces-239666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661BE9263B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DF71C212D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFA5172BCE;
	Wed,  3 Jul 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="jY2K7oHc"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2110.outbound.protection.outlook.com [40.107.22.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77F4409;
	Wed,  3 Jul 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017927; cv=fail; b=s6K/N26FgC7mBSgPTb6HYEF4JI8gRUKcVdCsO5uTOr1TakgvIlVD7WuqImqQ5SS5fjjFdrSXhehrGeUvxeckjgrr10XFuLu1ikKE6stM4qZHoUd/rYauYzf7LDQlb/eFfIEK0p+V9s0xfq1sl2t3+PEeZf/Ev3ZkKP0z83ZZ0ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017927; c=relaxed/simple;
	bh=kK6ZI9vb2xBZ+RAn++Wy2FP2U5E1bBY48508pYyg+Ms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EwjjmMBIQ1a+apfnv+tIhvqDEk6C+89e6cJnN4xvXooSQ2zYtEbbDsqD0Rrh20ivTLScvOWxxSz9jRbXwei8EWFH+r4E4zadGX0upy8nFEyunnnTWeUTAIM8ywyrMEtx3ul/xDISn9bDzpXthzn4zX92O6TB2vJ6XlhPbSW8sNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=jY2K7oHc; arc=fail smtp.client-ip=40.107.22.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLhd9u5lJIeJGMZ7B0HbnoDKiQD/+PUAK7g2Lupg5DB9+PpO15c6bREQ1Amn57Vwh/BLVxLDj/CdQmKn7VDjs1aFg8pbqu8c/XQkTeh4wye9sRh3n8HCbERF4aWV3AF8JpG62uxrGdgupQmDTi5rW7mc7WrAeiY1BnwyRRtjtz/h3e8d6XNILThL8t/7wlQLLUqJwm2sWpP862eMWwpaWQrUhF9uU7LG9NzkXseFG5wIJKTr+nyqvakZqlbXlr+cmpw75uMMRnzfB1/jhxULYKtfS5RgSUabc4BCP2ZiL+bFQpPzz5Erpe945Hd8frwwksr/zwhOabXRKAjWmSAKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bu9y3oGSJcTGETs8YBKPpUHzBc3Yr93WGVlWsPtLMMY=;
 b=T0O8rJ7GrQLSJnsoqf5Ji9xzS2uAuhKWJl7r1nWnoRCEgopLdU5zKqSgRM63C9EcfceBKWWvrBEV9oc17r1lEu2QRRvXTEL5Cp7uaEo5HtNfF1gsJltGuIVQREwjRtIMK0qntt5qqrMkWz4VJ9UM07A8Rfu2qbTY2wa8cRkm4X1z3dBz73IZXCQ1svYkzMU1dzGpZcDO5sijFm4V7VnlFV1hJHYTASWWNF7P0beBFS5GqSs4FABY0aqI3NEOs44iEhQH3r6gn2f5QXBpsth+9Q+YSY6Zwd4x1zhuaD1rrd1/Qd07TX6J7wy31uy+z+v5S2UqLXGzNSvIJlDHarHP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu9y3oGSJcTGETs8YBKPpUHzBc3Yr93WGVlWsPtLMMY=;
 b=jY2K7oHczLnntReizYXgJGmCzPxRqcCfcB1SicHN/1l6Jbzh8g9Gy2rKbaBYikiJiCb3TqwjWFrHUMTkNGg6KZ0Nvc1pHRz0cLZLmo0Mlf9ZElObnIt87wnp0UMthBUaOTZdFZ7RsrfJKgbtXTIUoWc8lKWwxtv6YKC9ITBnVz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM0PR04MB7187.eurprd04.prod.outlook.com (2603:10a6:208:196::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 14:45:22 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 14:45:21 +0000
Message-ID: <62bb269f-8348-4887-bc36-e9bb57810203@cherry.de>
Date: Wed, 3 Jul 2024 16:45:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] hwmon: (amc2821) Use BIT() and GENMASK()
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-8-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240701212348.1670617-8-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0046.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::15) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM0PR04MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b9e284-97d7-43dc-933d-08dc9b6ec3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjJYSmpuUTYxUFpzSjdVQmMxazhjWmoydVhKLzB2Q0xUSzhxZFBzVWxYbGlD?=
 =?utf-8?B?amhzeE1VdEdJWVNCWjMvSGlNdTFWQUkrV1gwM3ovUEdvVHRkSmdHZkpoczRP?=
 =?utf-8?B?ekc2K2ZYZEtjV20remh3OE51Mm53MHZBL04xRzVCZGpEYWdWUTVUa0JRcjJy?=
 =?utf-8?B?OVdYUS9raGVIaFNDUVpUTWdGR0NhWW54VDh3ZGlJcmdKUEZNdUhLanVERFVa?=
 =?utf-8?B?cnpXM3hoK0NBZGZTOWdRVkNqMmJCRkIrWFQzeDh1clduckhmcmQxR3JxR1Jo?=
 =?utf-8?B?R0ViNnRSUDZLejdRTmRycUJxMEM4S1RwV2tJaUNDdXpJZnlkVEN3cmorRi94?=
 =?utf-8?B?QlZpNnhRT1hKVVlmb00xeDhsaWI1N1NCVUpzK2t5NG15K3ErenhvU0tWd3hD?=
 =?utf-8?B?a3oxdkRneEszQ1RmTDVtRmJxcGhJTVJQdjFpRWRRNVBhUS82d3RuN1hPUU90?=
 =?utf-8?B?WFdFbXB1OG9KeDQ3U25WSE9Wb0lscnBLS1QrQWFqRjVBSFhEV0JwM3N1TW1z?=
 =?utf-8?B?SWtYNnIyWk9DdVZqZjBsb3BFQTdKWXVVNWFEOGw4ZHM1ai9NakM2TTZPcUZ1?=
 =?utf-8?B?UjR4VktLQkh2Mjg4U29Ecjd6NzU4czgyVWlINWxQRXNTM0ordUNBVEVNbzM2?=
 =?utf-8?B?UmQxZUZON3ExOTUvTmdtNHVGQ1Q4aE1tSGlJYy9uMFB3TDR3T3dnOVlIWjJi?=
 =?utf-8?B?U24rWnUwMldrSUhrQ3lIZDlhenMvSGJZUlI5US9meWY4NjlWUmZVMzRwbHQv?=
 =?utf-8?B?UWp1ZTNxakpxVjNyQllWVWdDeFFqeGJVQXUvVFFPMS9CM3MrbUs0NXVpZ0JB?=
 =?utf-8?B?YWxQK1lqNlB0MTZFaXdzZUR5OEZyK2tVckNKeDZ5TmgzQVQ5S2pETUxGK0Fm?=
 =?utf-8?B?a2ZjeVlaemRpb2JqczZXT3BkWHNOS2FqNGN0aHBjeExHamVveTZQemFlUnVv?=
 =?utf-8?B?dVdseDdzWlhXNnptZWtCTGFGbU0wL1hXMTF2TE50RzA4YmpOekIrUnhBS0lK?=
 =?utf-8?B?bWxYUnVTbFFyc1FLSEQwZ1FGclpNNmFibG5mWjBLYVBOT0RqcC8vMTFPZFlH?=
 =?utf-8?B?K3V4UkNkNFpGS1UxR1hDQ2RGYXA2ZUdBTEx2d2NqUzdzY2EvR2RjV2cvczJk?=
 =?utf-8?B?MzVDNWZlbERiMzJFT0p6R0s2RVNsYldDYU9VZnVZdytSSVUyTkkzdThtdkwr?=
 =?utf-8?B?QTNTU1pWblhiU1hTVitXZGdITm0vcFBuWFNzV1hIcys2Sk9lT2Z5VmpKZ2RU?=
 =?utf-8?B?aGpZaCt6OFg1Y3B1ajVvcmk5S25kcDYzYmZRMlFGNE5UK0gyUDRNOEE2N3RI?=
 =?utf-8?B?VjJLbnlKSGY2RWRIZzJKREdnUTBIck9nRTk4WmwwWURuMUhma2sxaGtnczJS?=
 =?utf-8?B?bFd2dEQzSUpyNWpId0tKYUNkdkpTRExSRW5NcHNvTGVVek5HcThxekpjZ1VF?=
 =?utf-8?B?RnR2WW9lL1pIMG1Xcyt6RkRuMUdJbVBja1dEZnJEUDd5R0o4ai91SUhDUUNq?=
 =?utf-8?B?NWYxN1VTdFFPT2VEbHA3ekpTaFR0YjhncTR4MWk4QlpUellwVWZkM25YTU1U?=
 =?utf-8?B?aXpoSktZV2h6LzFrUnV4dEVNNDBHdEhlR2phT29mQWVkcTdvQUwzQ2g5cDUz?=
 =?utf-8?B?WFFJTEgxazBOM1RHaGs2Rk1hdndpc2UvT1RqUjdldVFqM1Q5ZjRlcEJqY3Fa?=
 =?utf-8?B?TnJRTkZsMEpJNzNiU3NvaUt0NDFtK2xQN2FKb3pJWGRhTkMwVVlobjVaNUc2?=
 =?utf-8?B?akE3QUV0UzVseXJYQ1FGRXN1NHA3aTRpQ2huak4ra1ZlMFNOZWVTSlhldG5w?=
 =?utf-8?B?NlFQZVBtUmFGc1c3aE1zQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGozbXlPQVdGT2dtdEVSY2libXQyTEFqdzRKK0xWVWhJdHc4emEvLzY3a1dR?=
 =?utf-8?B?aHVadXFnYnlDQUVZeHpTNENZdW9LOCtreU5tcURyRDIwZUE3c1pwcHI2cnFC?=
 =?utf-8?B?ai9ycVo4aEFjeUtlcU56OER3eHFnK0cvVGNDMllnTGkrNGhicGhCM1F6Ukxl?=
 =?utf-8?B?QmNtalZrSXI0ZUkxc2FMaDl2M2xuYmpGc1IxdTMrbVlqc0xIa1prMGhYcHps?=
 =?utf-8?B?OVdObkV6NFNVOVlKaE53cUwzbEJWQndrN3BFZjZuaUcwVk1zVnB1S21qZ2N4?=
 =?utf-8?B?eDBPdW1iaGU0QWt4dnYxMHlMd0U2SjVZN0RPVTdMQkU0dkh4bzBiZGc0UWZr?=
 =?utf-8?B?TDhLa1JrYksxbkxiemNBai9KMVlSNExWZkJSZG0xY1MyNElkTkI3Q1BBNlNG?=
 =?utf-8?B?ajZkWUFIZ2V4WEtSYmFmRXNacHlleERqYjVIbmVvU2czOHdZV1ZJbHhMNFY0?=
 =?utf-8?B?YUlCS3krMUZWbStxZTBCNzdKL2ZvYll0RVhHenJVNkhOVTZKWUVOTmk5UHZs?=
 =?utf-8?B?MVlhZTVCYnprTWRtTTV6NWpCaDQwRkJ2M3FsNHRaa3ZzY2JBTDF3Mi96Y0dD?=
 =?utf-8?B?QWFXSkJvb2hlUkhvazllMkZFeVRjb1JqWS9IWXY0dndjd2dkNHVoR2luTHVO?=
 =?utf-8?B?eklJMzZETjVJQXp0UkFiVmJzbEw4aSswSlMxcVBmZXVxZWdteEg5S0lRQkt4?=
 =?utf-8?B?bjQwckZ0MHRvR01rTjY3N3FoY0JGYkJGZEhFdERIdjNuNWN2cktYQlU3OXk3?=
 =?utf-8?B?c1U0T1owOGUxU0VUL3kvZ056MHdBTkYwcXA1SWxMZS9TZW9jZll1RVA2cWxW?=
 =?utf-8?B?VlJMNVJHVVFRcDVnWVR1b3JTbWpjUnlzSDVQN1VGdTdCYjd1c0hFUEdING40?=
 =?utf-8?B?UGdrZmZwQVozc1F1bktLbFpJaDJvbTlGQXg1eitEWDk1UllwTTFaN0JyZTJ4?=
 =?utf-8?B?eEgwSG1pMnlvQU9YaUhzMjhMNjl4YnhRdkh2QzV3VU9udXlEUThFMENYUVli?=
 =?utf-8?B?TzNJU3E1bEpyQXdjUURadkd3VXdDS0JPL2dGUDB2b3dMeGsvUit3SDIxeVor?=
 =?utf-8?B?N2VnbTF2WlRCb0N3WTVmN2NwTWJsUUpZamFzd09YWkw1ZkpmaUJzTTd2VURR?=
 =?utf-8?B?QTE2R05nZWdRR0o5bWRJRmR0eWlXNHloOHFnb25wTld2NCtoRVpiNmFSR09N?=
 =?utf-8?B?N3ZmR1lyaWh4b0hjaGI2ajJTbnNkZnh4a0RSckJrZm1uQVI0N2dvc3A5TFFT?=
 =?utf-8?B?YjFVUjBMRmNVMnpvZFJ1Tk5pdkdJWHRqNXN0bHdYbEkvelFjYktxWkpNb2hI?=
 =?utf-8?B?VzBzSThIdE5nKzFFM3BseFZSQlBjQm5pczRKdmthUFpCOGxsMSsrYzVpaEEy?=
 =?utf-8?B?NG9BRUc1UHRHdlI2R2hwYnA2ZTV3SGNhck52djd5SEtkcXkycEpPUkVTVStW?=
 =?utf-8?B?L1krOVNLL3kzOXhoZVU3VVMrdmF0aDg2a1JyUkU4aFVva1Jjb3dZM2hEb1p0?=
 =?utf-8?B?d21Sb1hVblVnRmdiUW5mZUhBZytRUnpzWTJkdTEyeWlBUlA3ZVMxa1lCZFpS?=
 =?utf-8?B?WDdkcmYzT3VnS2tKd3VyVVdxTjl5UWNqSXprQnhVamFndC9aS05RSGc0MXdQ?=
 =?utf-8?B?VzNqWDdDakI0RlhPWTZ1U0syNVVRQjluM2tQM2xBeWEwZzN5NFFSZTRmNksv?=
 =?utf-8?B?SkN0bUZXaFZobXZhNDZVRkJrOGQrNGJ2ZjlpN2RBN3VBajF1V1VYcUtJekFr?=
 =?utf-8?B?bzZjTXM4ZkhjUC9PRjhOOWh4NHJXNG1LTHBIQnUyQUxFbUVVcXEzQVNDcUdH?=
 =?utf-8?B?enhaWUNFblFEbW8rK2g4TUk2N2J0ZnNqVTA3djNEOWk0Y0Jhd2pwY21yOHVJ?=
 =?utf-8?B?bml6S2JNZDZYd2FWWXdsZVFoRnJJNXZkRFZCZlQ4b1hSTXlCT0pGeWtIR0hP?=
 =?utf-8?B?dThwOWxoSTc4RWh4Rm0vb0srdWxpRmZFbjluZXpVck5qQ1pDOHFFSkluR092?=
 =?utf-8?B?L3V5ck1xQjhITUh5WklydUNqc28zd1Y0ZzZ2dXRPSFVodC9TdTl5YnVYb081?=
 =?utf-8?B?VnIrUVV2a3BreGF2QmdXcm5TVlRpTFZTZXdLaVh4dWhRZmVSVS91eDZzNGI2?=
 =?utf-8?B?bnhGelNtVjhITWhsVkpLWU9hRDNWZjB6c25GVXp6WlpVUHZJTUFzTkp6b3Mv?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b9e284-97d7-43dc-933d-08dc9b6ec3e4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:45:21.7103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHrlzc3ckmJDuOrEoSNtiN8SxbI+qJXCA9UbpBHAmYoOT9z+9J6COWPy0TBlSpPtwksGX8tQT8Gk/N0fBNs6kjOcoEvg60iuR1O3HYO0RyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7187

Hi Guenter,

On 7/1/24 11:23 PM, Guenter Roeck wrote:
> Use BIT() and GENMASK() for bit and mask definitions
> to help distinguish bit and mask definitions from other
> defines and to make the code easier to read.
> 
> No functional change intended.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

