Return-Path: <linux-kernel+bounces-518270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6186FA38CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251CC1893CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E1D236A8E;
	Mon, 17 Feb 2025 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VYCDEA//"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021134.outbound.protection.outlook.com [40.107.192.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B71714A5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821577; cv=fail; b=WSG+5UpjdWcqB+30fYcn1z6CoUUCNirN1nC5nyzusumFJnpI+KtIlbTTHQ5x8pRP0/7G2K5iVxec5ivLsRU676keLTCGa1aBIF9/auwBd8/H2JxAAOcR9HQDut6Q73OODj5OaFweqX9Hk2KGUJJ+kWUV1m3R3JJMHLW+7A3lcgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821577; c=relaxed/simple;
	bh=Jb8GPGcSWk1yAE3rPNV13v9HLsxDFZzry1aIVlbg20E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZwGQD9prQEkWOhgSuDNysV+vjthPkHdih05GompC8M4o5JevJ/SQL1hptVB2JmPzuTMdXFBiDcSf8gVwS8dIWYO8EAkshKK34VPI2i28vQYzzfSQgQ1BJ+gIZQmIU70HyqyR/3DJzwh8JD6NxlvD+LNlJySA70OIW708myCmZNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VYCDEA//; arc=fail smtp.client-ip=40.107.192.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQZmNVNQzYzXquJWygVzw81hp0OgKkzMbhtNnO8R/kNBlYQ34Ikdo1qstzwtWq/wHDzmZ3SOMY7JQjBny49bY5xi6g34D2W095nHcyQeGOu1hgzYPVmHc0EExsWoG40Gbg2d6N2OjDU4dWe7VhBeaKJEuaaVl0LnIzG48kDaFjSgRDdOY6Jy5mcCZRIUUPVsLPIfWjHkY64SqR1DZLns0VtoPFj2ZDYsjCu9H8Qvk1q75DdJV/r8wNIRAgq2KMfk26KD7l78/TZQibhBRUjf6c1QnoyXaQhT6Iv3RrLmTjm8zy8XUDaK28jWjWzo/95eLIWinLI12mAeiwOXHxruUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpUQoiZI9uW6eRQDmtNm88ybGpJzlkHR2Uxbk5HS+pU=;
 b=MMtH/EbqfWf9yvWlaocViwYUicpn5fqOGdGABm5IULrNEWT1eim2L8XEHnhKWXCHDQa21vrICj9HiXyIsMLginDmFx1Wuv3ObODMdJeytaHFgaQihFwUe36JTbY6gFLejdN9+i2riYUCEvmTkQwn73ZahA8Vk6d94Et1CPdJ1yzu/cotrmV+M0Nr4kp6FdZgMuLGTGub89r/rlhu6Dpg02CgijzxoiBMlDj3nNX8xQZXiC5HsEHwkRWgFDv6xrJUfFggF/Id3Ipnl68Oyj4lthF39AvsBvH6QwE75q2iojes5KOtoAg1RvBnXaFC1QV06TkEdfYOSKpAf2I5/waJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpUQoiZI9uW6eRQDmtNm88ybGpJzlkHR2Uxbk5HS+pU=;
 b=VYCDEA//24AwFzw0GtpQBAaPrHlYjeZ2+HxNA9uJx5VYb9EhNK+7ADlS1eO3B0S6RbAJBFXZn2DUbR9+oHp5IWSMGe1UkeHPkW0uqw01JSPAMjt4VTHuizb2eqG11rioTp7hKrDqlTWUqa3dq0VBTAGktQ/FZahIhkjxzlCD4l8Vn7465wiHCw8T/oRBMQFpOfDrUaK/wvhZ4erFyIQsJNFMPvlHaJSdg7lp6kflbin5QiSDcxeWBhn9pUFqpH6e/FREhqkH0zApshLm5Xe95TUkHpd36cZXlbFqh6VyI8/exjPSKdTXg5d65YOhWRy12ew+9BHGfe6AwSITyw8ozA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPFC07946807.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::581) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Mon, 17 Feb
 2025 19:46:12 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 19:46:12 +0000
Message-ID: <6a86f095-4f3b-46e8-8a42-51bff3d03405@efficios.com>
Date: Mon, 17 Feb 2025 14:46:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched: Compact RSEQ concurrency IDs in batches
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20250217112317.258716-1-gmonaco@redhat.com>
 <20250217112317.258716-2-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250217112317.258716-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPFC07946807:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c46d9e-7f02-42f1-0169-08dd4f8bbb54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3ZmUmdONHBSRE9BdDRIRmpQcnBmM3FGNkpUdVdEdjcvV0NBNmtRbGMxMHhx?=
 =?utf-8?B?eXJHSy9zeVBQWVNESHB1aE1wTDNkV0pFQVhhbkVJajVXbzIwVktzN2QvY1Vl?=
 =?utf-8?B?aDNvbG5JRzdlSVhPaXlUZVVubHpuMjRKMjdzbUlJNzBxNSsvVWROajVnUUZP?=
 =?utf-8?B?SHFobjZRUFIvWFFJSlI1R1ZzRnd1eHpnUDF5MG1qeUZjRkRlSkdhaUtHbU91?=
 =?utf-8?B?RHh3Rm1zeGdYTWRhbFhpMFBSRWNPaEtiWFkyS0FqZkJxeEh0QzJubnlrLy9Y?=
 =?utf-8?B?b1NTOEl3a1gybDRNQlJoazR0S2xLMThvcmx5L0ROcUdlR21ROGpoNWN4Q2kx?=
 =?utf-8?B?ZGdhdzRVQXZBcW4yTTltYzNHRko3anBwVTQxa0NJQjB4R2tSdEtnTUZ6SHh1?=
 =?utf-8?B?NHJsMkZZM25OL01nSDREbjdKWS9ZMnlObnRLb3ZabmVLUElxbld0dE5ZNGEz?=
 =?utf-8?B?Y09aY3hFZFBsZXNXOGhsL2VLdUppeFRMSm9DQWlkZlYwd2dUdElVOFFKVjgw?=
 =?utf-8?B?ME8xcG11ZXJQQzJLMFZFUmlkN1FKS1pRVkNMTzFrR3lYSWpPZmtPWWp2dUd2?=
 =?utf-8?B?NC9FRDZFZDRZVGpGTHY0OHZMSHpSMVI5STZldUhsUCtVRllFd2FaTGhqMThW?=
 =?utf-8?B?OE5aUS9ydi9VVzJ6dEM3MHpqbGtkcjFCS3VubGZYSktqeTA1ZlhlVHpYcUl6?=
 =?utf-8?B?SE82eWVyZnFldlgyeklRNGo4UjRTOHlQMGVqd3BSaWkvV3dqYzlYVS9NOWcy?=
 =?utf-8?B?WmJvd0M0NllMVmZsUTlXZEN3eWJoUFhnQ21kY2dNWThTdXl3U1pkZkxyREZG?=
 =?utf-8?B?czd1ejFBWjkwVCtvVmh5T0d1eVhtWldQczNwUEVVYk01ZFMzMGhtbmRpYUMz?=
 =?utf-8?B?TzdKN0RBakw0RFFMZ29rcm9iOXYrSi82N292ajVOeUMwUWN0MTJOZEhDWStq?=
 =?utf-8?B?NFNmeTVTbXlVbnE0MDB5TCtWNjdsK3E1NjdMcW9HMlI4ZlZRT1BjK1IwZy9l?=
 =?utf-8?B?dWxwNFYxb2FHY3RHdjJnbWtXcGlaUXRabXBOL3hMSVFoMWtaeG9yR1kvbzVm?=
 =?utf-8?B?c2FsMEJ2VHAweTNubEVNaS9jTnByQmQ5eXkyb3V6M0JJTWxKUmNiUE5IL1pD?=
 =?utf-8?B?a05vVWVKditEUEpVdEZrc3dldjg2bElZZFphejZ2aVc5Q3ZFK05IRDlsN09H?=
 =?utf-8?B?dVV0NnVRSmJXMUFHcGVWZmh0YjgzenNCZ051MXczR2ZrZFhsM3QvTTNrQ1NB?=
 =?utf-8?B?QUd4VEovUUtBUzFoSW9rZU80RHgrVURLR1dTRnFHR3NPdUNnRlFTOUNSVXM5?=
 =?utf-8?B?UHlSVFlVbVcwVE53azZzNjNJVUsyU09td01qQTVhUk1IdG9BZXFQV21nL0lL?=
 =?utf-8?B?a0grajErTERwZmRsaVdLSmxQUktJdkhnT21WVWNUa0x3OThsN2Ewc1BSOVRh?=
 =?utf-8?B?Qi8vRWxTMjVXUm10OXBIK2pPd0d3OVpQQVZ4WCtqb2ttRnNhK3FGbnNFN1Ba?=
 =?utf-8?B?b3NoVXJmZHVsanBBUFp3TUFWcWxXUWRzNE8zYktmOHJwRWRWSXZDVzZzV1Vz?=
 =?utf-8?B?WUtNSGVQQmJkTkh0aTRrUFZEMFZWaTFZUld2TUJIVUc1OEN0VmZwZXVzZlhU?=
 =?utf-8?B?TnpyWE90d0hlUTFndERRQ3Vhb0ZUQ3ZPTFZDdDYwVzBveFV2SzZKOEp4OVk4?=
 =?utf-8?B?d1RlakJiRStyODlta2tWSnZuMlFPdnk4WEVyQnBrZlBHaUwxdmp6UHlvcVhW?=
 =?utf-8?Q?SqE47d8t2Ec5Sw4Sfu1gADHvA0Urcuqqrb6hEoG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkltTGxmbDZweUxZUGFRNnV6SFRFT00rVE1uenp4MG5zcGlmaW5JbGNPNXJn?=
 =?utf-8?B?LzlmZGRvTWpMRy9VWHdwKzNNYUUreUtReUpQL3V3WTBEVnRNc29tSk1seVFj?=
 =?utf-8?B?OGk5YzhxL0NjWWtmczNPNXYxZE5OQlpGMzNXYXBPTUo4bGhGTzlrcmNmYjBP?=
 =?utf-8?B?VmNCY1dka3dOOUNZYVpxOTFkT0xhUGZBSkJxbDB2MU90UmEveU1GY2pkM0dP?=
 =?utf-8?B?cXc5TDVHNm1rbzZoaEtneHdaZnU1NVNOSi9JY1FzNEcvTjJLMkpYRHFtOFVD?=
 =?utf-8?B?WkQ1OWFWNmhsc0s3WGFGeTBuV0NYUkNCd0UzaFpiMlUya0xUMkF3RXRWNW9E?=
 =?utf-8?B?TWwwOHdBQkVFUnFTVVdLL0RnSWRoTmUwUFNBU1FjbzFLK1FzTGZFZ3pHWDF0?=
 =?utf-8?B?NC9LN1lGYU5OSUdCbXgzQ2lMUkZEYnIrSTg0RUtzUWVndjgwUkdBODBPTWZi?=
 =?utf-8?B?UXAvVm9pVzAvZEZJSVJNR29nSm1yTjlHK2VZdUNQdmQvWWcrY1FsajA0bHlD?=
 =?utf-8?B?UUhJcEtCSklXS1VneDc3WnNMbEkwVTEvNkM5YThiemRxVVdIazRRaGZtci9v?=
 =?utf-8?B?OFNQbVpPb0gwbFkvTE81M1JjSWZMY0tCRllZY2xpa3I1QTgzbVJTVUg1RWI2?=
 =?utf-8?B?bE1TRnAwU25hZUd5T1Q0WFpEOWdONUhtQVZiVEhRajg1V2hUdHkwZ1hQRjZV?=
 =?utf-8?B?TGE1Z0x0b0JNVGFqYjU1c2xrRWl5bjZqYTgzdHFSYStTcE1ubDlZK2lhTmNL?=
 =?utf-8?B?YThhakZYWUhEaUVHZmI0ZVdCU1pWSDNEYjhQcCs4dUhNUXd6d2pqbWZZYzE2?=
 =?utf-8?B?QkRvS2pvMVRETk4wYTFNTXdjR3A4YW0zTFJMZjJmRkpWUGRCTVhJNC9abEVI?=
 =?utf-8?B?aHFsVXdLRGtXdVVLZUREZk1kdVp6ZW1xNnJ3MlA3bmYyeXdLeE54TEZDbCtK?=
 =?utf-8?B?dFBYdzR4dmZGMEJPTUFhTXFVSXpQWUxMbHFiWHk3SVRRcWt4TVBGRityRld2?=
 =?utf-8?B?WFlIK1JIbEhRd1FPRjArVHFEMDJyWGMvaWpSWUExVmJCWFJWL3dyQldRbklx?=
 =?utf-8?B?NlBKUUhIKzEwVm9BdWxib28yOHNLcG92a05RQmpaQUJhelNQZEw3NDN3RFBD?=
 =?utf-8?B?R3FaUkY3b0d0cnFwSXp4ZTJIeHZIZUpSQW8rRnBPOFNMQ0RUdmlTODgyN29q?=
 =?utf-8?B?MitpWUlsS2YxYjBhM0IzVnZSTE80Ym1ERW93TkV2YTAyWXQ1QlVKaHBlRnFK?=
 =?utf-8?B?cWhLS01ZdENSVjdyalJ5UVE4d0JKWE50QU9ycTJrY2Z6M2JuK1BYcTBFR0hI?=
 =?utf-8?B?aUl2WWdpYVFlNFlqcTZoMVM3T3lWUll4ejFSNUtSUzB3aUEwdkh2TWZRYjA0?=
 =?utf-8?B?VzlqQjlzSnJMZERZTE9TTjFZZFpQTzkwOFllRGs5dVRya2prYmxlUzZUUjhy?=
 =?utf-8?B?RkZUT2p3SU9EMitsYTNPcXFyZXA0Wkd6Vy8yYVJka0ZzWG9SZXYrOFYzR3Fr?=
 =?utf-8?B?RDV3a3RHTkcyRUZtRHR0b0t0Uk96aUhCdVk3OGl3YmRxWVBVcktjbFVEMVF0?=
 =?utf-8?B?TEFrcnhMZkFUWmU1dFFHSUVpbmYrNWIxeExrR0xRK3c4ZHd0eUpXYXRzL1dn?=
 =?utf-8?B?QklMV1cwWTJBMnh4U0VVSk1lL0s4VDNMWFlLbVAzdFoxVWR3LzJsOURYZSt4?=
 =?utf-8?B?enFwV2xBWUo2SlpnQmFsL05oMVpoRkUyU0p3Tnl3VXFjV0NDcUdPRzVBZFI3?=
 =?utf-8?B?cDhncEFDU21FUGhpS1pxa21hNkRxNDQwZldJS0pRSFMvOWpCUUk0dnJHdXVP?=
 =?utf-8?B?blV1blNOY3ovUnhGTHl5TWtVN1hSMFc4ZnJReVRlR003Q3VxN0FyTEV1QVlU?=
 =?utf-8?B?VXhib3ZSTzdRZFVYZGVqU01nQXFWVmFPa3lsaUV1aGxsUDdrM2RUNHQ0bXI2?=
 =?utf-8?B?TnlyRzJGZTdIUnlkSW9wV1NuS3FGVFluYU90TS9zcm0wMDB0SmJHWHAwMkNI?=
 =?utf-8?B?SE53ZUFwUndMNktSU3YvMWVscU9ia241WEp2YklNQURzc1pLek5yeFBaZ3M3?=
 =?utf-8?B?cEhncnRNNURvOU5aL1pQeHBmRjJ4OUlZYUFocHVLVlhoYkFpQXBoVmxZWHZ1?=
 =?utf-8?B?TnJUN1JldmhGNUVsT2hOa2N3WlUrL00zVUNzL0hRRHByU1hKVVpqNTlNUGRx?=
 =?utf-8?Q?Jh9Nsln5pZEW37Md5zP+kCA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c46d9e-7f02-42f1-0169-08dd4f8bbb54
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 19:46:12.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrvcUWQsUHOWATQLU7uB+FNh9ids3+fFmaejIUn9xnWidHfCixU2frZbWu7m9sATq3BpyCDFZFQZ16RsXcbURzqv7R82IwSyVABz6NbW5VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFC07946807

On 2025-02-17 06:23, Gabriele Monaco wrote:
> Currently, the task_mm_cid_work function is called in a task work
> triggered by a scheduler tick to frequently compact the mm_cids of each
> process for each core. This can delay the execution of the corresponding
> thread for the entire duration of the function, negatively affecting the
> response in case of real time tasks. In practice, we observe
> task_mm_cid_work increasing the latency of 30-35us on a 128 cores
> system, this order of magnitude is meaningful under PREEMPT_RT.
> 
> Run the task_mm_cid_work in batches of up to CONFIG_RSEQ_CID_SCAN_BATCH
> cpus, this contains the duration of the delay for each scan.
> Also improve the duration by iterating for all present cpus and not for
> all possible.

Iterating only on present cpus is not enough on CONFIG_HOTPLUG=y,
because ACPI can dynamically add/remove CPUs from the set. If we end
up iterating only on present cpus, then we need to add a cpu hotplug
callback to handle the removal case, and I'm not sure the added
complexity is worth it here.

> 
> The task_mm_cid_work already contains a mechanism to avoid running more
> frequently than every 100ms, considering the function runs at every
> tick, assuming ticks every 1ms (HZ=1000 is common on distros) and
> assuming an unfavorable scenario of 1/10 ticks during task T runtime, we
> can compact the CIDs for task T in about 130ms by setting
> CONFIG_RSEQ_CID_SCAN_BATCH to 10 on a 128 cores machine.
> This value also drastically reduces the task work duration and is a more
> acceptable latency for the aforementioned machine.
> 
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/linux/mm_types.h |  8 ++++++++
>   init/Kconfig             | 12 ++++++++++++
>   kernel/sched/core.c      | 27 ++++++++++++++++++++++++---
>   3 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0234f14f2aa6b..1e0e491d2c5c2 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -867,6 +867,13 @@ struct mm_struct {
>   		 * When the next mm_cid scan is due (in jiffies).
>   		 */
>   		unsigned long mm_cid_next_scan;
> +		/*
> +		 * @mm_cid_scan_cpu: Which cpu to start from in the next scan

Other similar comments have a "." at end of line.

> +		 *
> +		 * Scan in batches of CONFIG_RSEQ_CID_SCAN_BATCH after each scan
> +		 * save the next cpu index here (or 0 if we are done)

Suggested rewording:

Scan in batches of CONFIG_RSEQ_CID_SCAN_BATCH. This field holds
the next cpu index after each scan, or 0 if all batches are
done.


> +		 */
> +		unsigned int mm_cid_scan_cpu;
>   		/**
>   		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
>   		 *
> @@ -1249,6 +1256,7 @@ static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
>   	raw_spin_lock_init(&mm->cpus_allowed_lock);
>   	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
>   	cpumask_clear(mm_cidmask(mm));
> +	mm->mm_cid_scan_cpu = 0;
>   }
>   
>   static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b3..39f1d4c7980c0 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1813,6 +1813,18 @@ config DEBUG_RSEQ
>   
>   	  If unsure, say N.
>   
> +config RSEQ_CID_SCAN_BATCH
> +	int "Number of CPUs to scan every time we attempt mm_cid compaction"

Reword without "we".

> +	range 1 NR_CPUS
> +	default 10
> +	depends on SCHED_MM_CID
> +	help
> +	  CPUs are scanned pseudo-periodically to compact the CID of each task,
> +	  this operation can take a longer amount of time on systems with many
> +	  CPUs, resulting in higher scheduling latency for the current task.
> +	  A higher value means the CID is compacted faster, but results in
> +	  higher scheduling latency.
> +
>   config CACHESTAT_SYSCALL
>   	bool "Enable cachestat() system call" if EXPERT
>   	default y
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9aecd914ac691..8d1cce4ed62c6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10536,7 +10536,7 @@ static void task_mm_cid_work(struct callback_head *work)
>   	struct task_struct *t = current;
>   	struct cpumask *cidmask;
>   	struct mm_struct *mm;
> -	int weight, cpu;
> +	int weight, cpu, from_cpu, to_cpu;
>   
>   	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
>   
> @@ -10546,6 +10546,15 @@ static void task_mm_cid_work(struct callback_head *work)
>   	mm = t->mm;
>   	if (!mm)
>   		return;
> +	cpu = from_cpu = READ_ONCE(mm->mm_cid_scan_cpu);
> +	to_cpu = from_cpu + CONFIG_RSEQ_CID_SCAN_BATCH;
> +	if (from_cpu > cpumask_last(cpu_present_mask)) {

See explanation about using possible rather than present.

> +		from_cpu = 0;
> +		to_cpu = CONFIG_RSEQ_CID_SCAN_BATCH;

If the cpu_possible_mask is sparsely populated, this will end
up doing batches that hit very few cpus. Instead, we should
count how many cpus are handled within each
for_each_cpu_from(cpu, cpu_possible_mask) loops below and break
when reaching CONFIG_RSEQ_CID_SCAN_BATCH.

> +	}
> +	if (from_cpu != 0)
> +		/* Delay scan only if we are done with all cpus. */
> +		goto cid_compact;
>   	old_scan = READ_ONCE(mm->mm_cid_next_scan);
>   	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
>   	if (!old_scan) {
> @@ -10561,17 +10570,29 @@ static void task_mm_cid_work(struct callback_head *work)
>   		return;
>   	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
>   		return;
> +
> +cid_compact:
> +	if (!try_cmpxchg(&mm->mm_cid_scan_cpu, &cpu, to_cpu))
> +		return;
>   	cidmask = mm_cidmask(mm);
>   	/* Clear cids that were not recently used. */
> -	for_each_possible_cpu(cpu)
> +	cpu = from_cpu;
> +	for_each_cpu_from(cpu, cpu_present_mask) {
> +		if (cpu == to_cpu)
> +			break;
>   		sched_mm_cid_remote_clear_old(mm, cpu);
> +	}
>   	weight = cpumask_weight(cidmask);
>   	/*
>   	 * Clear cids that are greater or equal to the cidmask weight to
>   	 * recompact it.
>   	 */
> -	for_each_possible_cpu(cpu)
> +	cpu = from_cpu;
> +	for_each_cpu_from(cpu, cpu_present_mask) {
> +		if (cpu == to_cpu)
> +			break;
>   		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
> +	}

Here set mm->mm_cid_scan_cpu to the new next position which is
the result from the "for each" loop.

Thanks,

Mathieu

>   }
>   
>   void init_sched_mm_cid(struct task_struct *t)


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

