Return-Path: <linux-kernel+bounces-334734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0212A97DB6F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 04:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E106A1C21271
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6B68489;
	Sat, 21 Sep 2024 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JBnhGGO+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C53201
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726885250; cv=fail; b=A+hakI0YoP42qZV0Ns8PYPaWg0iRzYYHPb07wtHMCfcb+tTAzbXHHapB9rNY0pEcL5OfSuzjd4zIxgf8v32Qr7p55azt9zUfVc5XPcBuoPlcVuHfSAg0EJAqosInhtHAPqH5rzZbTyBDJ136Yjl8V40PuxqXc4Y2khY2X5rfb0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726885250; c=relaxed/simple;
	bh=buD67ex/xMjmmweJUAMIbpV98/K7zdbz8sJesyZubig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=luWRyOuTA+8XD34Gr5Db6X59BfX9+vu5wNJk/85zIBSWgUMxrjQ1tAV7IkjnTe/0MPGv8JlYW4NcThrjQvdF1rYjldKJO6wxt/mNjsmxnL/089cupVLV/BFgNOjhxiw9ZXl/WnYx+nnpvTgpqf7AIPVOJ3gQpngEYelEeC9OBSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JBnhGGO+; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXEqpk78RGTRV9MpKiS56cSOxDO6nM81utPrLHtm3ziHUBFCwZdai75z/GPzFP8jOsIJ35Ozcwt9zKtKxGvZ7upbLaTKohOaGoLwIGwTvbXzGSl+COgzqI1Aw4J92Sqx89i8B2ALJ95v6CfyNBAr5rh5SfXYcKN7QJIrGV6Z3p3zZTBbKbv0cjQrxwo95TBHl6iGT9HBZy3OPTMDHAyE5aye6BBx487iDuhvB0quluAQ427Ja/Tz9p1UGunmKZFVOqmU5XaQQrwDq5VR8AEDukmqVC144hih2++4ioSVMGFcRTQY+3gKqUs9M/HnFw2655Gtn5VB1ZuBPuuSMJJXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOk8Y4iqxBTLuqst/VPgmdlllpEmZgIjN4uk9/byy/o=;
 b=C2M2a2q6xRTDzMr7PjAiNyvRJfHx27pavPsCr7V7YE2SwrghOIcAmeS5cjH7tMMzrZbTFOdUWodjMqUsJ83I9vjgPzRYvMS+sjK2E4vdE4kGbZjDrVQfpndEvYAfCI3G7Ue6zY2ftDC+V785hSVDxlw4qcspWR7jIAybJaDY4ZcXmj/SE+4tBjXk/FZR8XSPtG+DL7ivClS0XdGvwWm965LiM1UltLs2HsppfbZPobDOjLiFVNJQU1PS/MNx5ala1/6eeg01vhAjXToM5Zo1S7YRDPZr59PhjAUU/S/EaMvEGZinhnSxsBE7dTnmmGBq9+fYX85JhuQB19a75+0joA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOk8Y4iqxBTLuqst/VPgmdlllpEmZgIjN4uk9/byy/o=;
 b=JBnhGGO+5PVgBgk3zR56MYk367u2lIDulGMkhR3M3U+kZEy4njdb27eLrdCTZR4cJtAJWpAnQwCITFANpgwNUfRMw2kkXdfbQq66xz6lcv4y6w4csjvwJFj/Q/yG0zYbtNdM3E0Ywbr4dxNk4CMpDTRyjxlUUoMqgLhWxay9cXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Sat, 21 Sep
 2024 02:20:44 +0000
Received: from IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692]) by IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692%6]) with mapi id 15.20.7982.018; Sat, 21 Sep 2024
 02:20:43 +0000
Message-ID: <4bbf68fa-6ca2-47a0-9966-6971dabd7a0f@amd.com>
Date: Fri, 20 Sep 2024 20:20:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: AMDGPU 6.11.0 crash, 6.10.0 git bisect log
To: Bob Gill <gillb5@telus.net>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <c21b734a-1d3d-4286-a3c5-a6ae9b69d847@telus.net>
 <Zu3-nJ7LpVzoN5Bj@gallifrey> <1ab1991a-382f-4b59-9e07-76a696159631@amd.com>
 <894c29d5-0997-422c-9013-d1a17990b8a0@telus.net>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <894c29d5-0997-422c-9013-d1a17990b8a0@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::11) To IA1PR12MB8495.namprd12.prod.outlook.com
 (2603:10b6:208:44d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8495:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e038b6f-1f73-4ca2-0964-08dcd9e3fee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S203L3RRU2duT0pxN1pWZVp4cUtDRmNpcGdremxyL3ZOK1J1NFNGeElyckVW?=
 =?utf-8?B?MllaRGovLzdaYW5RTWJBTDRiY29hOEhiaG91RUg5UEliY0JBNkhvMGs1NExv?=
 =?utf-8?B?OEJoK1o3VzNKb3FyOU05S0RQMzhPYVNRZmZ2dHdPb1RmQjJJdks1cmtqUWhG?=
 =?utf-8?B?Yyt6dzUvRlhVZFFpQ29QdzltQkwwS3lFaXQxNmRqSVJSYXlVSmNNa3g5VjNQ?=
 =?utf-8?B?UWpUTEVnYmZEZWxOemxHSzhnN1F5VFlQQ1FSMWRaVUNFSFpQMEFDVUVhWkps?=
 =?utf-8?B?dzRGK0YwRE5uQktnYXc0Mm5pdStpS08zWUlDZXM0dElpZnpnWkRKby9HV0FM?=
 =?utf-8?B?NzVFLzdYRXlHcHFiNDhaSytkdHpmczB0Tlp0YjNLQWc0NC9yRHJaZVZBY2Nj?=
 =?utf-8?B?Nzl4T1lUeEZLeXM1cUgzQkg0ejNpL3VCcGZnQWErMTVSU2RyZ1p6a2xsb1Vt?=
 =?utf-8?B?YWNJYTFKdVdBWjJxNXNvVklMbnk2UlY3S0lXZnEwM2JONlBTUkNBWDdhNmVa?=
 =?utf-8?B?ekYxOWF0Q1VyTWVvamhnZkorSU5rSVRFK3VMKzJ2UmlXaW8xY3lKcFQ3c0dz?=
 =?utf-8?B?NFpKRm5zdlJzZk10ckFuWFFGRkJISUhFUGRNUHorSjZ0UFZORXFORHZnSkpk?=
 =?utf-8?B?b3hjMGVZMi82TGQ4TDNiWjI5SGFpc1N3RkhiMEpmM2R2aWR4UTJwUXBJVEY2?=
 =?utf-8?B?dkxBM094bUphSjF1T25pVlQ0QnlDV2RTNk11VExUTlRsTlVselpHdENIajkx?=
 =?utf-8?B?b3NkS1VMY1Z1RWxwZUJUa05sQ05xZlpBcTgyeTI1eVZWSGNyZGQySUlUbUJ2?=
 =?utf-8?B?dHBPbHpDT2J1TkZ3OWpTNGZ2dEN3dTJLQ09SVzQvaFhQNUg5c0hJeW9wNGVq?=
 =?utf-8?B?VXc4VlBFVnlHdXVieWNOU09DKzBJQnkxVjFMcGFPRm5mYWhtdDJWa3o1NnFt?=
 =?utf-8?B?T2h2K284THBIUjBtQVV5T2FnOVRHKzhsZ3Jkd1ZBVlJPKzJITlpqZnZxQ3g2?=
 =?utf-8?B?ckNESGdydEpQS0ZKSk81ZzRtV3UvUkZCRHhwSEQyOVRZS2J4MHhSTUN6cmlh?=
 =?utf-8?B?aGc0V0lMZ25qZEZsZmkxQlZ1cW9zTEh6anowSXo1Zm5rVE5ua1JGLzNhek9r?=
 =?utf-8?B?Tmh3a09NNnNQODdES3BVMFNNSzVhc0ZMSkc3SWlkcm9IeksyZ1RYUy82RSt2?=
 =?utf-8?B?ZCs3WUdhM3V0R1JROENCS1RPUUk3Y3dSZTZpcnZPYndQWjNSaHkwYXRNcG5M?=
 =?utf-8?B?bUJzNzRlVlhUbndqVk9QdzFDZGlOcVpPcnY0M3huVjNCVDkwMmtaajZEQzda?=
 =?utf-8?B?dmZ2TGUzQVNLMnkveTZpNVVhdGplM3BMN2JiVVhSUzA1bWJXT3puQkIxUzRH?=
 =?utf-8?B?VFUrZFhWQndxVVA5bzQ2ai9wYndkVHVXcXJKNkg2aVZQRG5QeE5oQTY2ZVk2?=
 =?utf-8?B?aXBtQU9rRVVwNUJHZ0UzcXpaeXBhVTlaRFNCVm1vNWlTRVlKWmpRaU1DZW9R?=
 =?utf-8?B?cmlkcElSN1Z4L1FXbWdLL0RaNi81MGNKZklKQ2YzVUVLTFpTb3hlVUs5bEd4?=
 =?utf-8?B?MFI5VjA0T2gyV1dXaU5ZT0Y4OTJWcm15cnRDUlpsYXdlV1BEanFrOWl3czZG?=
 =?utf-8?Q?FLcn6Rw4JjM/5nWmjO/fuIWtvcczwFKO4Chg4fNZuxrk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUp0OW84UERGd3I3OTlIaTFmd0hZNkUyMmRvTmI3dCtML1psc3RsNkJ2NlJ4?=
 =?utf-8?B?SjRiRFJrZTVCUStaM0RtWGtEd2lDaHNpMGZ1bzR2SUF2MnQrZHZ1NEo2aXlJ?=
 =?utf-8?B?WGt5WEx2NGw4VExHazVhR0lJR2o4eFN1ckVndGxaNGxENDlkV2VTcTdkblRJ?=
 =?utf-8?B?WS8xRWNTOGlHc0xoQmhacExXa1o5N2EwRUs3MUVnVjFyTWZLZ3JqaTFGUzdv?=
 =?utf-8?B?M1VZdGdBVUpZcDRaQStWYTlYUE5XbU51aXh6bGpsTFNYNE1hNlp4Qnp1QUF0?=
 =?utf-8?B?YmZ6U2V6a1ZVdkp6Vjl6WTNxd1Z1WXpkRGRZdzBOT1d3QnRRL2ErOGZrQ3BC?=
 =?utf-8?B?SDExQVJ1dFhsQVZaZzFlV3BaYnNlMWpzOUF6bzQxaTRKM3hXVjFPNEp3QWQx?=
 =?utf-8?B?aWJUNDBncDJrMzg4dUg4dUUxMnZheXJQNWNxeGl1V09jc2JiMkF4ZlZnUjFl?=
 =?utf-8?B?azVsaXlwdDl0ZVlCcXJQZ2VnTGJad3hiemFUOFNxUGtweTEzUzI4R0pJVkRi?=
 =?utf-8?B?Zkc2dmFVTFRlSjQzSllUUm1oN1VaNnErNmpCN1lqMTBnRVRrWjI3amo0ZjF3?=
 =?utf-8?B?aGZ1WTFWelEwQTdQS2RHd1Jha01LdnFRTHFjZ1pZN3ZOelVMbzhya2xmSlBW?=
 =?utf-8?B?YkhFYjQyenVmV3FUMTgwUG81TzV2UGJXOFVJM3JmYjVGUlhpcDNzNm5IeFR3?=
 =?utf-8?B?OTdySnB5aWhkeXp4Z3l4UjJySTdMUmVuRnYzei9DUE9ueXI2Z3RXWTBMditi?=
 =?utf-8?B?NXRwMVd5ZThGQklQSmJnSDFGeVhGbDJiODc3djlBVVZOd245Q3g5OHhKMkRO?=
 =?utf-8?B?SGVKSUJGbGZlR2lBeWEzMlVUcHhsUmZzbTF4ZER0aE9BSnlRcnp6U1AyWGZP?=
 =?utf-8?B?dGRUT1pCUmsrai8yTE11S2dPd2tIWStnOUVPTFF6QmJ2TCtZcE1pcndkRU5C?=
 =?utf-8?B?M0pHM3lBeUZPam1GWElGZnBHQ1dPbFlZU0prUUJhbWZZZ3pra0dObklMV1Jz?=
 =?utf-8?B?NmtpTWtIWlN5L1gveWxOanhuUzlPMzEyRHMyMG9LSE9YWWwvenVHNVNSeUI4?=
 =?utf-8?B?cjJESFk5UUlrQlR3VnJ5VlhRK3VOY2tNbXI3ZjliZnRhWEdLbDNzSW5kbXgw?=
 =?utf-8?B?eTVGNVlnWnJ0S04wdVdlbVBrSmJBRG15RFl3T3c4VmJjSzZhUWJCeWZRZXVq?=
 =?utf-8?B?YksxcTF0dkUwTXNXelhhMkxLZjN1N2JRMi9rOHY2UUFVQW4xbGpFSzczdjJl?=
 =?utf-8?B?eWwxTUl0NWFPUGlVYkx5MXpmUGxiOWlDQTloNExPTFN6YUFGdEEzTFR4bG5U?=
 =?utf-8?B?UHlrVW1rbEVzMStjRHdqbUQ4Q2FPdlZaaHpnVGFLQ0ZqVENjTjI3VTEzQURF?=
 =?utf-8?B?RTFDcUpVOCtpb3A0S2NjOG1Fa1pMUkQ3SkhVeGplVk1ONHQ4UVFVWis2UExY?=
 =?utf-8?B?cDZsZ0t4U3NKZ21mR214Sk1EcnQyT0NtRWtkUmpKR3ZhU2lXN0lkdTV2SFIv?=
 =?utf-8?B?OFp2T2dLcW1POG9tc2NJelY5K1loTmxqVHR0U2pSMU1hU1pDVUFwV0taaHFl?=
 =?utf-8?B?NUhFbHlONy8zaVdLUmwzRmZsSmNtRTNXVDAzZW1kS1BFS1ErN2F1MWRzN0NC?=
 =?utf-8?B?VjdJZFZWY24xekRpMWcvTWhlNmZQK0tiZ2JkemZkdmNDQW5IMGQ2alNuM3pH?=
 =?utf-8?B?ZVJKRUtQeFNHRlVvc1Rod0s0RnRkc0pqSjBWZ1U1RVVvL2EwZDk1RFd6YUhT?=
 =?utf-8?B?SzVXUEtRaHJnSmdhcHRSdWx1VXJvSDQrdU1Sb01sOHlBZUNlWWcxVG10bCsz?=
 =?utf-8?B?Njd1MFNXN2V4K3JSRlF5eDhhTVVDTm1IZU9mdjQ3NWJaditjUGdRZ1JNR25Y?=
 =?utf-8?B?SktaUGRPaUpVZDN2YVN3UitXQ1FTeHNqNEpWS2RKVGJya29NY1cyeXFDSG5I?=
 =?utf-8?B?djRtb3JJbUJubnd0VlA5S0JreTVyaHZIa3RVN0EzclJNN3Q1UmhLcEIxTUpC?=
 =?utf-8?B?dWpzbnF6Z2t6VG92eVJIZzZnSFhGTFZhZWNtSjIvY2ZaazlCeEFVL0dDNko2?=
 =?utf-8?B?cUFURGRPNWZudkhFVjkwanF5bUlPSVZtSzNtY2xkQlBiVkp1STl5RXczOU5B?=
 =?utf-8?Q?bHYiBgaosS3RjZM1OqBr1rSA9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e038b6f-1f73-4ca2-0964-08dcd9e3fee2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 02:20:43.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBoRKJk7bBtJ1bLg5X82oIhLxbRBla+stKizVD4/PDcDkpWVsbWBHUf5SfxWliprchdDSD9po1O+zVz8CmYa7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318



On 2024-09-20 18:20, Bob Gill wrote:
> Hi.  Sorry for the late reply.  My config has
> CONFIG_DEBUG_KERNEL_DC=y
> 
> I will set it to # CONFIG_DEBUG_KERNEL_DC is not set

Hi Bob,

It seems the below change in a171cce57792 causes the hang when 
CONFIG_DEBUG_KERNEL_DC is set.

--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -227,7 +227,8 @@ static void init_transmitter_control(struct 
bios_parser *bp)
         uint8_t frev;
         uint8_t crev = 0;

-       BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);
+       if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev))
+               BREAK_TO_DEBUGGER();

If you can help confirm thefollowing fix the hang, I will prepare a 
revert patch next week:

* Set CONFIG_DEBUG_KERNEL_DC and revert the above change, i.e.

--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -227,8 +227,7 @@ static void init_transmitter_control(struct 
bios_parser *bp)
         uint8_t frev;
         uint8_t crev = 0;

-       if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev))
-               BREAK_TO_DEBUGGER();
+       BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);


Thanks a lot

> 
> also,
> 
> cat /var/log/kern.log | grep VBIOS       gives
> 
> Sep 15 11:53:43 freedom kernel: [   16.372684] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 15 13:58:04 freedom kernel: [   16.705182] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 15 14:20:05 freedom kernel: [   17.043288] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 15 14:38:23 freedom kernel: [   16.625105] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 16 09:40:52 freedom kernel: [   16.780135] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 16 09:52:39 freedom kernel: [   15.764412] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 16 14:59:23 freedom kernel: [   16.077181] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 16 19:03:50 freedom kernel: [   16.613359] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 16 19:18:13 freedom kernel: [   15.895630] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 16 22:01:53 freedom kernel: [   15.768717] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 17 09:48:50 freedom kernel: [   15.758361] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 17 10:31:23 freedom kernel: [   15.762467] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 18 09:43:12 freedom kernel: [   16.086531] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 19 09:32:07 freedom kernel: [   16.034418] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 19 12:04:46 freedom kernel: [   15.771447] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 19 13:54:41 freedom kernel: [   15.791940] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 19 15:37:35 freedom kernel: [   15.749058] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 19 17:25:04 freedom kernel: [   16.449671] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 19 19:43:06 freedom kernel: [   16.312367] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 19 21:31:28 freedom kernel: [   15.864131] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 20 09:12:39 freedom kernel: [   15.764786] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 20 11:31:36 freedom kernel: [   17.332211] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 20 13:23:19 freedom kernel: [   15.759616] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 20 13:45:07 freedom kernel: [   16.557215] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 20 14:01:17 freedom kernel: [   16.433437] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 20 14:24:14 freedom kernel: [   15.770057] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 20 14:47:27 freedom kernel: [   15.725150] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 20 15:02:31 freedom kernel: [   16.591276] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> Sep 20 15:19:44 freedom kernel: [   15.863542] amdgpu 0000:04:00.0: 
> amdgpu: Fetched VBIOS from ROM BAR
> 
> so not what quite what you were looking for, but when I run cat kern.log 
> | grep Failed :
> 
> Sep 15 11:53:43 freedom kernel: [   25.730013] uvcvideo 1-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 15 13:58:04 freedom kernel: [   26.025432] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 15 14:38:23 freedom kernel: [   25.883820] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 16 09:40:52 freedom kernel: [   27.204539] uvcvideo 1-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 16 14:41:22 freedom kernel: [   28.985885] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 16 19:03:50 freedom kernel: [   26.510748] uvcvideo 1-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 17 09:48:50 freedom kernel: [   25.682372] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 17 10:31:23 freedom kernel: [   25.547899] uvcvideo 1-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 18 09:43:12 freedom kernel: [   26.243232] uvcvideo 1-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 19 09:32:07 freedom kernel: [   25.267332] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 19 12:04:46 freedom kernel: [   25.269450] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 19 15:37:35 freedom kernel: [   25.494803] uvcvideo 1-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 19 19:43:06 freedom kernel: [   26.288598] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 20 09:12:39 freedom kernel: [   25.291743] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 20 13:23:19 freedom kernel: [   25.884358] uvcvideo 1-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 20 14:24:14 freedom kernel: [   25.312379] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 20 14:47:27 freedom kernel: [   25.352905] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> Sep 20 15:19:44 freedom kernel: [   25.297893] uvcvideo 2-5.2:1.1: 
> Failed to set UVC probe control : -32 (exp. 26).
> 
> 
> Hopefully this helps.  Please mail me if you for more information.  I 
> have changed my .config and set
> 
> # CONFIG_DEBUG_KERNEL_DC is not set
> 
> I am attempting to build 6.11.0.
> 
> Thanks,
> 
> Bob
> 
> 
> On 2024-09-20 17:34, Alex Hung wrote:
>>
>>
>> On 2024-09-20 17:00, Dr. David Alan Gilbert wrote:
>>> * Bob Gill (gillb5@telus.net) wrote:
>>>> Hello.  Kernel 6.11.0 crashes.  6.10.0 builds.  Al Viro and Dr. 
>>>> David Alan
>>>> Gilbert have been helpful, and asked that I
>>>>
>>>> post a git bisect log.  The last log step seems odd, but the second 
>>>> last
>>>> step "Remove useless function call" might be what broke.
>>>
>>> Thank you for doing this!
>>>
>>> My reading is that's fine, I think the next one:
>>>
>>> tree: git bisect bad
>>> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check and 
>>> log for
>>> function error codes
>>>
>>> or the one after it is the culprit?
>>>
>>> Adding the two Alex's from AMD back onto the thread.
>>> (Also added the [REGRESSION] marker the notes tell us to add)
>>
>> The commit triggers debugger in case of in case of errors.
>>
>> Is the config CONFIG_DEBUG_KERNEL_DC (Enable kgdb break in DC) enabled 
>> in .config, i.e. can you check "grep CONFIG_DEBUG_KERNEL_DC .config"?
>>
>> If so, can you also try to disable it and check whether you can see 
>> error messages "Failed to execute VBIOS command table" in kernel log?
>>
>>>
>>>> My hardware is old corei7 quad core/8 thread Tylersberg/Nehalem with 
>>>> an AMD
>>>> RX 6500XT.  That's the odd combination.
>>>>
>>>> Thanks in advance,
>>>
>>> Thanks again for the bisect.
>>>
>>> Dave
>>>
>>>> Bob
>>>>
>>>> Config:  (.config)
>>>> /data/kernel/bobtest6.10-64
>>>>
>>>> Build line: (last command tells me the job is finished)
>>>> make menuconfig && make -j $(nproc) && make modules && make 
>>>> modules_install
>>>> && make install && /data/music/pl.sh
>>>>
>>>> Rule 1: Do not modify ANYTHING in the source tree
>>>>
>>>> git bisect start
>>>> git bisect bad
>>>> git bisect good v6.10
>>>>
>>>> Bisecting: 11273 revisions left to test after this (roughly 14 steps)
>>>> [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' of
>>>> git://git.kernel.org/pub/scm/virt/kvm/kvm
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0+
>>>>
>>>> RESULT:  boot 6.10.0+ fails
>>>>           screen black for more than 2 minutes,
>>>>           (caps lock key unresponsive, reset, power
>>>>           buttons on computer case do nothing).  Reset with power bar.
>>>>
>>>> tree: git bisect bad
>>>> Bisecting: 5677 revisions left to test after this (roughly 13 steps)
>>>> [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0+
>>>>
>>>> RESULT: boot 6.10.0+ successful
>>>> tree: git bisect good
>>>> Bisecting: 2855 revisions left to test after this (roughly 12 steps)
>>>> [dde1a0e1625c08cf4f958348a83434b2ddecf449] Merge tag 
>>>> 'x86-percpu-2024-07-17'
>>>> of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0+
>>>>
>>>> RESULT: boot 6.10.0+ fails
>>>>          screen black for more than 2 minutes,
>>>>          (caps lock key unresponsive, reset, power
>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>
>>>> tree: git bisect bad
>>>> Bisecting: 1478 revisions left to test after this (roughly 11 steps)
>>>> [32a120f52a4c0121bca8f2328d4680d283693d60] drm/i915/mtl: Skip PLL state
>>>> verification in TBT mode
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0-rc3+
>>>>
>>>> RESULT: boot 6.10.0-rc3+ successful
>>>> tree: git bisect good
>>>> Bisecting: 739 revisions left to test after this (roughly 10 steps)
>>>> [b6a343df46d69070a7073405e470e6348180ea34] drm/amdgpu: initialize GC IP
>>>> v11.5.2
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0-rc3+
>>>>
>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>          screen black for more than 2 minutes,
>>>>          (caps lock key unresponsive, reset, power
>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>
>>>> tree: git bisect bad
>>>> Bisecting: 369 revisions left to test after this (roughly 9 steps)
>>>> [cf1d06ac53a15b83c0a63225606cfe175e33a8a0] accel/ivpu: Increase 
>>>> autosuspend
>>>> delay to 100ms on 40xx
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0-rc1+
>>>>
>>>> RESULT: boot 6.10.0-rc1+ successful
>>>> tree: git bisect good
>>>> Bisecting: 184 revisions left to test after this (roughly 8 steps)
>>>> [0ca9f757a0e27a076395ec1b2002661bcf5c25e8] drm/amd/pm: powerplay: Add
>>>> `__counted_by` attribute for flexible arrays
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.9.0-rc5+
>>>>
>>>> RESULT: boot 6.9.0-rc5+ successful
>>>> tree: git bisect good
>>>> Bisecting: 92 revisions left to test after this (roughly 7 steps)
>>>> [9862ef7bae47b9292a38a0a1b30bff7f56d7815b] drm/amd/display: Use 
>>>> periodic
>>>> detection for ipx/headless
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0-rc3+
>>>>
>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>          screen black for more than 2 minutes,
>>>>          (caps lock key unresponsive, reset, power
>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>
>>>> tree: git bisect bad
>>>> Bisecting: 44 revisions left to test after this (roughly 6 steps)
>>>> [a78313bb206e0c456a989f380c4cbd8af8af7c76] Merge tag
>>>> 'drm-intel-gt-next-2024-06-12' of
>>>> https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0-rc3+
>>>>
>>>> RESULT: boot 6.10.0-rc3+ successful
>>>> tree: git bisect good
>>>> Bisecting: 22 revisions left to test after this (roughly 5 steps)
>>>> [51dbe0239b1fc7c435867ce28e5eb4394b6641e1] drm/amd/display: Fix 
>>>> cursor size
>>>> issues
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0-rc3+
>>>>
>>>> RESULT: boot 6.10.0-rc3+ successful
>>>> tree: git bisect good
>>>> Bisecting: 11 revisions left to test after this (roughly 4 steps)
>>>> [871512e36f9c1c2cb4e62eb860ca0438800e4d63] drm/amd/display: Add 
>>>> workaround
>>>> to restrict max frac urgent for DPM0
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0-rc3+
>>>>
>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>          screen black for more than 2 minutes,
>>>>          (caps lock key unresponsive, reset, power
>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>
>>>> tree: git bisect bad
>>>> Bisecting: 5 revisions left to test after this (roughly 3 steps)
>>>> [5d93060d430b359e16e7c555c8f151ead1ac614b] drm/amd/display: Check HDCP
>>>> returned status
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0-rc3+
>>>>
>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>          screen black for more than 2 minutes,
>>>>          (caps lock key unresponsive, reset, power
>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>
>>>> tree: git bisect bad
>>>> Bisecting: 2 revisions left to test after this (roughly 1 step)
>>>> [e094992bd1caa1fbd42221c7c305fc3b54172b5c] drm/amd/display: Remove 
>>>> useless
>>>> function call
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0-rc3+
>>>>
>>>> RESULT: boot 6.10.0-rc3+ successful
>>>>
>>>> tree: git bisect good
>>>> [2c2ee1d1329881d8e6bb23c3b9f3b41df8a8055c] drm/amd/display: Check 
>>>> and log
>>>> for function error codes
>>>>
>>>> latest kernel:
>>>> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
>>>> 6.10.0-rc3+
>>>>
>>>> RESULT: boot 6.10.0-rc3+ fails
>>>>          screen black for more than 2 minutes,
>>>>          (caps lock key unresponsive, reset, power
>>>>          buttons on computer case do nothing).  Reset with power bar.
>>>>
>>>> tree: git bisect bad
>>>> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check 
>>>> and log
>>>> for function error codes
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>

