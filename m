Return-Path: <linux-kernel+bounces-526565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A558A40059
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C1A7AC4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE9250BF6;
	Fri, 21 Feb 2025 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TpkmDfUB"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020102.outbound.protection.outlook.com [52.101.189.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7145948
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168367; cv=fail; b=ikifE3iHO87tF3uAIMB1AaGZJxjZMCHEjMa4DLfpeY8+l0LP/6DJYdUxBqIFJagPmuKYxrvtCy8XhcoyG/wnS0R0ql4el6LbHSzh8FQ2qoh02z+Vjp0QHpCeYZddH60726xxrLnzeIUvaIcjyYg/i7J5d3yN4XK75f0Z/TieIQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168367; c=relaxed/simple;
	bh=BI3SB4VwqRmEa/74PawHT3Vx6+jPetrlX5rqRQL5Xrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0lPFqPPchLKWFbC7p8JtAKez+nJ89SPRpOkW4Tmn93r8yhB696b5kxxYsVNd6Ts7rWLR+L0zh/iThY513Zgc4qLQMnaoKGQVHqaw2SesRcNub8Gc+g7evlQazBCw40b4hJ+MxCvaouSCu5KwHC4CZ+7P0ImT+sxiBVcIsVpFTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=TpkmDfUB; arc=fail smtp.client-ip=52.101.189.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQyvrjPIU4F8+KIqp892dotyikGKZVhXw2TS+ytEbLnqQyh5e65xecpmxHYYUKybgV3o1KPywO7TaRL+3eHBfVvnvZjBKdUB6/YdkKeRW7LyEEpPD+Juvqzu41etpfMaDxGwHe/7GsNy3WzOKKlzVhKln39sX6Hy/QN1DwjFMrFE84wf8ZveDqD0Vv84UbvochwtST6YaN4wcG7gDNBXvyluxudsMHshMzjO9xd683c/vWuYMwcvmOdKpbXkr5oLJjgnd9YJn7bY+EwKruoimEnDh7nmkJL9QgklanCU8YGIrQS1zut6VgTPgs7pPM3e9xmtj/Cul5RsThOix1ydsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ft0RDqsPDVokFXPM0JmYlTnYB4/zFtIb9EtTnYGDWhw=;
 b=hs/FlbWysj0yw31T3nX7XdkonyPwMqVnxsPHCPxxUp+JDQLOmwd70uafGFz2HGV28gXte9RTa8jxhH92X5fonVd14r+WYD0Pc/rp2SLFtLFPb7FxMoh4qXg8ZO11igzWmGjUkzzt/5UdRZWfn0Be8dhnLp+t18MLp+poL3704CswzCWcWF9+/9bZouyV6hqCJ+gAvHKb+MBeRri5NirFESyXVYGcA1fBUye2NpTvXrUiw2EvvNpqLO3RrQHoDsw45V1pzIQgXVGRbPdYrclBa5z5JtCR++EX5AX1cZqwHEpWaPIbClTR6ZyS5SKca1t+2ktcqE429HYUtH1XBETPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ft0RDqsPDVokFXPM0JmYlTnYB4/zFtIb9EtTnYGDWhw=;
 b=TpkmDfUBPTQlG86WpPUIBvItwfqJ0hW1iQIxU2dKZzlnlu1rRktHOexQVZNE19kmeEZGM7d/qwkwzzVzzIC+Ny6BvQpEl0Zg1bDSQzYXRhSUlQFaNM+Cqkur43shFmnx6lXL3x2T+VLshHwp58g8+y5PxMQo6mTC+YRDgj00WZi/QcJgrhGZ6BvoY9MOpMm0/4sG+EUhxjND1X6OBo5B2q13BEQBVo3HdXXysLS/9AbwEVaID+Ao1bBIz9GThcdxX+YKx57jpFeMSo51ZN2+1f+hE6UBlQ0vA7z70IGHdjwmeoez+27FxMNwUT0f1eoMZ0XB0QtSPehjwcscU6htKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB10664.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 20:05:59 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 20:05:59 +0000
Message-ID: <6ad30642-c3b5-4ab8-9ed6-1fa8c56a8995@efficios.com>
Date: Fri, 21 Feb 2025 15:05:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Dave Hansen <dave.hansen@intel.com>, Dmitry Vyukov <dvyukov@google.com>,
 peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <81d94ec3-16af-45a7-87c6-ef76570953f8@intel.com>
 <6ada635e-973d-4e32-ab47-1fda12ee7ce7@efficios.com>
 <90a36a64-8ea5-4ea1-965f-bcec604c7d5b@intel.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <90a36a64-8ea5-4ea1-965f-bcec604c7d5b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB10664:EE_
X-MS-Office365-Filtering-Correlation-Id: d9047200-b925-4bfc-08a9-08dd52b328d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0J5Mzk4ZS9GbWZPR1dsNzNialZKbytLYVVhRlpaV2dpK1BabWdHMTdySVRD?=
 =?utf-8?B?VTJkR3UvZEdCSmJTenZab0ZWdTI0ell3Z1pHSmUvWmx6dTRRRldocUtPOHBp?=
 =?utf-8?B?dTlmMmY4Z2Y5RVp2L0s5RTkwSE55SndObFJQN0tFN0VBSUFwcUVmaXBnLzFy?=
 =?utf-8?B?elVQbEZEckJxYnI0Mks1TU5ScVQ4MDEzTktnb29uV3VwYm1Ob0ltSnduRHNF?=
 =?utf-8?B?WDk3elFPWm1YK3IwNUZiZ0lxWndZc0oyUWM2V2JkQi9uQVltRmtWVlVJQ0s2?=
 =?utf-8?B?SXRvZjlhc3UxSjR0Umh0UVZGTEMvMXBGa2RyOUFIc1FsQTFwZnErQWdYWWYr?=
 =?utf-8?B?YURZTWgrbWxvZ1ZGVnBNVlBLemk0N3hLaFdkeGVIWEN3VXF6b3BUTW1haC9V?=
 =?utf-8?B?N2hIOFlqTG9NZ1VlaHQ4akM5VWVzN0c5NzkwQzRLdS9ETmNnYStwaDJnbEVB?=
 =?utf-8?B?TWJPT2VJV2hSOFBFVEk0K2pIZmdNYi9Yd2ZnSVFPVUU1enVtZUlBZ21taW9v?=
 =?utf-8?B?ZzEyQ2s0YVI5NDBvYTYwMnF2eHo5cWZwSGNBNjM5Y3gwcWFmaGhsQ3lBTWpE?=
 =?utf-8?B?YVFDYUhBUlBjdXUyeVNHU01VSDhYOTlYUmsyTE9jVnJyQVpBeVFkc1FqSzZp?=
 =?utf-8?B?ZHUzM2l1ODJLNEplb3lCT2NuQnRYalgwaThaUWNaZWwrb2IrL3h0Ynk5Wit0?=
 =?utf-8?B?R3V3N2lQclpZcWpoVkN5aW5Wb2VFZG02RTFPRi9NWERjN2lRZTFUQkJsSkdv?=
 =?utf-8?B?cnRJU3VBaytCV2lTR25rczhrT0dBMUJnbVFDcnc2RjNKbWVBWHc1dWJDdzFZ?=
 =?utf-8?B?a1ZnWlkremEzZVg0cUx6bFZnK2I4SGkvdUF3ZVUrRXp5Yy9ZQjVlWCtGZFdD?=
 =?utf-8?B?ODl4NXpmTVBQN1B2VmY5dW9aWmF3YXZBYndTVlJ0SmpqQmdDbUI4a1VqMVZC?=
 =?utf-8?B?bUJRZUlLMERReDAxTExaWGR0eHAyZmdIa1FNYmhQZWNBZjVpdEdPYVlPQ2k2?=
 =?utf-8?B?K2JDdmR0T0RNTStqTEN0YUZCV04rYU1jRFhvMGN6YTlYdnNVd2ZYZWh5am8x?=
 =?utf-8?B?dWJrNGVpelptSnAzSlhXd1dRVG9VYUdSZklrNm43QVlUMWY1ai9LMWlGUmxL?=
 =?utf-8?B?Y0JlRFlCbW5MemlCNG0rNHpSLzV2ZGM2SFFYS2lFc0dOekF4SGpOVlh6bno5?=
 =?utf-8?B?b2JzdE83Vk9qRmd6QlZONGFPRW1MaXEzR2VpMGtReThvcUorVkNaUkhaSEVG?=
 =?utf-8?B?REtVdW5xbjV1NE1wYTFzVitXZXp0NkV4TmYyUmhvVUZCNlQrbi94S2pGVGp5?=
 =?utf-8?B?dFIyUGhIaDFaNFBnSkZHSlJDNC85b0dwQ2xONFMyKy9BdkNNczB2WldvbWgz?=
 =?utf-8?B?VTlvb0lsZkd4cDkzYTdUcHlYd1JZdU1Ea2JBSWdyeXNRZFE3aGVMMXJSUjNE?=
 =?utf-8?B?bHZ1ZHBvdzRMZVltQm1WZ0EyWExEZXd4cXJwT0RZRmxNRzYvSzNia0tjNDBj?=
 =?utf-8?B?REVmZlZuRUhaVmlLb2U1NzhuRlltYkw3TkgzTDRLcXArRlhnYk5TQk1wbm5n?=
 =?utf-8?B?UExPVWltZyt5MUNDWjYxTndEODlhcUQ1M2twMjRkVnlLM1Z1TkpJT2g1dnJW?=
 =?utf-8?B?Nk96b21NckxHMEsvT2N6Qk5SbE1TRC9WUDRLa0h5dmx1UkdRT1ByV3diUVB3?=
 =?utf-8?B?OFdodEdWVDlXbWhBSmxBNWtGQnRuZm5HOW9KdjBVZWM3ZEFOSndhMG9MbmU1?=
 =?utf-8?B?SnpsZ2dhRDBrc0xKU1ZpY2l5NUE0VkpuT3pnQzFsWk93N2xHelQwSXNqNEkw?=
 =?utf-8?B?TFhZVlBYOG5rdG9TY2daTklpNVFsRWFJTEx1TnNTN1dmWklVaVdTL1ZveDlp?=
 =?utf-8?Q?P7G6Cj4sywWqN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkNiUUhIbEx6Zzkxd1A5RzZueFNxazVZQkhEeFZvNDl0UlBUT2g2U29WY1Y0?=
 =?utf-8?B?SDN5WG8zNmV5a2hKeHVFNWRHTmZucmJnUEdBY1FrQmE4UFJmRzRyb1ZsSzMy?=
 =?utf-8?B?alhvbk8zWHBReUlZclVRRWZBTmx3YkczbU5JTkg4RlJ0b2ZmT3JPeUpSMW5q?=
 =?utf-8?B?bUpyMEdmS3Y1WFc0SzdQRit5dnlZTHN3U3lZUlg5UGNWUTBMdnZGdlFaSmov?=
 =?utf-8?B?OFRQY2hTQ1RTSkJNVjJhcGRyU2JCdEVVNnQrdlZjUWdTTE5LQlNPV1BXUTRz?=
 =?utf-8?B?ZzdLRmJRRUdnZVdyeERCdnFvc2FZdmw2WGx3UmlnMXYveTV6WFlKUDE4NTNR?=
 =?utf-8?B?Zk56dGJlQmZDL0UvajhuMnBUaFRLY1NJdFFiQ1FsRjc3VW5vQUczRDdHL1g0?=
 =?utf-8?B?WFZaNkdGTVhueXc3UGZmS0UxMlJvb0d4UjE1SENaMm5Na05FSHhUT2tGN3dm?=
 =?utf-8?B?MlpTbzhvL2VqTFZKTENUblo4Zzd1bnhDbHY0S3V5emxIUTBHQ256NXRiS1R6?=
 =?utf-8?B?bStiNVFnUmhsY0gzblAxSDUzQUllMzArM2FwNzliTlhwK1NVQkwzRjB4Q3dQ?=
 =?utf-8?B?ZUdwQkJPSTM2WWliV25RTnpzc0ZIVERHTnpjODBDOFpLSzNXVXhPdEZtMHVD?=
 =?utf-8?B?d1pNRU5nMzBWOTdYZGNqWEFQRmwvT1ZhdlhDSHV1VHBJbkFoTUNjdWN0V205?=
 =?utf-8?B?OEVma1NORHExTnpmMnFUYkwwTjJCR1dlMEI3MjRoQU1wZXJyckxWc0pZa3pW?=
 =?utf-8?B?cU9mT2JLL3hWbnRFOTUvZ2oyeWRkWFRmU2Z2a1pLOFI2MTNHdTdhQ1ZYV2JO?=
 =?utf-8?B?VTduWHZPREVHaXFSRlg5MDhWODd3SkkxcGE3K1lKYmx1eE83NlJCbENpY2Vl?=
 =?utf-8?B?YlUveWQxVjRjektVM1AvelRWZklRb2hnYmx4YTROa2lxelJ4cnVNbnhjMTBX?=
 =?utf-8?B?WFFvOTRJcTFKanFmMGJhVWlvOGIwTzVxMzBsVEREamF4aEZ3REpWUnpMamp3?=
 =?utf-8?B?WUFqM3d6V1BUYm0zVGhjcmdHbWxwdXlPM2JlVVdkdXB0eEVGQm1hZjNjUXZi?=
 =?utf-8?B?TW53YWNKR3ZMbXg0L3hEYy9TTUhjRjlVZE1ZVjVHL01Pa2lBMndkMmtiaWdH?=
 =?utf-8?B?QkMydWhQWUhhUzE2WlpnQVUzZWxZNW1uQStVd25RbC9lNkI0TUYwTUVZYXl4?=
 =?utf-8?B?UThORjFlWHdpQVVCeUR0eGhDUlIxd2U1eTVLV01qZ2wrTTJuWlNvSXlPK3dR?=
 =?utf-8?B?Mm1aK1ZIQ0RMN0hpUnNtUEwyb3FTak9BOUVRaWRPVk9DVXY1RkFEUFJyQ3p4?=
 =?utf-8?B?NlprQVpML1U3bHd4RXkybUxJZFdvdUd6dlBlbzF1QWhTbnl0K3hXT2w5clA3?=
 =?utf-8?B?cWpJMGlZUTVmQ2FqRC8xV245dW45TzBoSGxuRXFIVzFsei9JaTd3VGVQS0tH?=
 =?utf-8?B?ZXllQ1FDeWNJNnQxTTMrbGxIRFJTZVhoeXMrd2p1UHVaNm92VWxRWkFrT0ZC?=
 =?utf-8?B?Y2NoOWlCdU14WDZFZFhsYlNzTXdKaW9iNXR3KzZkbTh2aEY5S0hIZzRrNHh0?=
 =?utf-8?B?VkFCUGt4bWhkV1NjWHRzaVNsV0ZCZlUwUzFhKytqSkdxQnQ4M21PVDF1bU1L?=
 =?utf-8?B?RFpEZ0RBcHUxUjRNRitETFlWQjZtd3lzQWtRUDB2MmJibVh0Zmc1Z0txV1VU?=
 =?utf-8?B?aTZseTZxVi9hVXA4OFgxUGJxaUxOT1JXMlN3QnlCU2Rnc1NmNFRpZEgxQ2Fm?=
 =?utf-8?B?QkI5ZFFaTU05R2dkbVNia0diYmpZdHd3c2Z4dVllRDNWTW9kS1RHcVhLcEhq?=
 =?utf-8?B?SVFoMUE5cFRYTU1lbHNwYThYTG1LVHBqNzF2NkdEUDNkbmw1L2lhTjRtU0Mw?=
 =?utf-8?B?a0tUOVBZeHpWL1RjVXg5UGNJTUUzL2dwN1FPRE5EVlNVTDREK0tWc05QTUZn?=
 =?utf-8?B?SXJjU0ZCY3V2U1RKd3I0OHl6d0JOY1Y1VjdPeEM4b2IyMWk5dElUSWNrMTUy?=
 =?utf-8?B?cTZ5T3k0MUh6N3ZqZjdmWExQTWxJaHlEdklUSEM1OFRoL0h0SERVc01NYjZs?=
 =?utf-8?B?bjdYWHBYem5sUmowU0d1Q0VWdXB1WW8xUmd6T3Jnb2diR1JLN094aE53NGtF?=
 =?utf-8?B?eWdNSlRhbVR6MDRuQUJwMHdOMVpaOGlJNVFBUGVhcWh5OGY2aGNoclg1VVFu?=
 =?utf-8?Q?C/XOru3JcFuTmWDoMG1jPew=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9047200-b925-4bfc-08a9-08dd52b328d5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 20:05:59.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xGXT1F91nbTYUeNiYFQJ+Nm6EnZIgIPzzwSqDN+588zZPxH6BipenloXoy/Bz8vBcK3qcbPjOtdt4ln7ccqMQUsa6Cfo2L93yXuJDluGnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10664

On 2025-02-21 14:48, Dave Hansen wrote:
> On 2/21/25 11:38, Mathieu Desnoyers wrote:
>> I agree that switching to permissive key in the fast path would be
>> simpler. AFAIU, the switch_to_permissive_pkey_reg() is only a pkey
>> read when the key is already permissive.
> 
> Unfortunately, on x86, PKRU is almost never in its permissive state. We
> chose a policy (stored in the global init_pkru_value variable) that
> allows R/W access to pkey 0, but disables access to everything else.
> It's 0xfffffff5, IIRC.
> 
> This ensures deny-by-default behavior and ensures that threads cloned
> off long ago don't have a dangerous PKRU value for newly-allocated and
> pkey-protected memory.
> 
> If I had a time machine, it'd be interesting to go back and try to make
> PKRU's default value be all 0's and also represent the logically most
> restrictive value.

Can we assume (or require) that struct rseq and struct rseq_cs reside in
pkey-0 memory ?

In that case, we could add something to the pkey API that switches to a
permissive state only if pkey 0 cannot be accessed.

Therefore it would only trigger a pkey read in the common case, and
issue a pkey write only if pkey 0 is not accessible.

Thoughts ?

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

