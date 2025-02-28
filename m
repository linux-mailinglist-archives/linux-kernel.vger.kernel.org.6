Return-Path: <linux-kernel+bounces-537669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BDBA48EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F31D16CC07
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980681724;
	Fri, 28 Feb 2025 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Uoms+j36"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022097.outbound.protection.outlook.com [40.107.193.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A29D322E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740711809; cv=fail; b=GvIbmUty64MQbsCVNBo+hWxBoy30ucfIy9zlr0wn7xhCLk8Z3sGU2afT9MwKK5hdE8aXr7nv23NKUsPvEiv10cu4S6Bfn2kt14wn6ZZcRyEWAzGNg4pHWn6dfxOcnqUvBbyhgh/LhOyX6fUz+m8oWttktuOFXBXaMl/GZWNkv1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740711809; c=relaxed/simple;
	bh=YCuEZL6e75klD4D7FSztgw5mCxh84Fw0l3S4HfR0LCA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XhE6reMJbAEPOENoHl81QjF2xC9h+nkt0s2uUXh6OligdTHS9vRZbUZhdMd69QXckh03ai7fBMlyDFDud0w9KXbcnVJiHSdMxn66ww9u8gpjFIwhBAcJ2Ud0TUt+ALcUpMZPR4SEfDKRyYKmpuZdS7NpweoOyCuS0OyppCMVSqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Uoms+j36; arc=fail smtp.client-ip=40.107.193.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnZvkdwago0YaaLUikJ1eqL84xX95iC61d7kmgcuSSGS6NdXGSSehwkMXoNTiDBDPfMhxx3QMHDt1fI9e1yZ8EvwPHu1oQ0RXuwXg0RwE+0JnzSUPjyQn7gmi3lIR2UBwXdWWnjl9+T/xr+o8Z7JwFLHDBtC8/l/6tE932NLWQ+OcEnznTDLG45b+wXWCUaQfAkD1cy6gcrJsKzSwSKKfmRL4c2nvZWX1Y4dhT16fZbvnsnrgWYgdcuiNFN3nw/e5P15xmYNoBe7koqZX29ZzzGXowe3raeBy4i468vIcScQde25jHQcGtAuTDS0XycRywkQ6lbyELMuPW4COGkpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0v+NZNqWwSGtMmG7W2J4Yq8rIgzEoiLJz7lDMBXrOgs=;
 b=m2vNg4FAUdDzjCj6DgYEXx0YsT3WdI+LfIX6q4W13dzILQYc8LYzk0hPCOB4GCnN6R0yOCB/QbVVYzxLR/1Uk1bQCWYxdoQryqDN6W3RnFxdcCeK5tfoBVcVws0XjaqpoqC8knv2vHCYl4avluE2Ue3VScxLu5JH8vvIBnBTyfd97j3ghcgmNyJRamimZb5K6/V6psLnLaBp7z7+ujrgXMDCnrKeRbK788rDHhK8/44ryy70fBvPIGJsZCJKvv800XMjOYSJYH8gW25I+MwA5zwDCR2/54ebLEP+BapaHmDqeZHVdDIvb2tDNKC65PFrS0+GQwSBwWXSba0kd/bjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0v+NZNqWwSGtMmG7W2J4Yq8rIgzEoiLJz7lDMBXrOgs=;
 b=Uoms+j36NloSyATFG1I/4r/ZFi+du3mzUqn4kTH6o9YJ6lyW7CdHvzQ73nipGj2Rvx0MGz44ww/LfhkQfrE1bCEOYBdl7mprh1joSSmC96UAj4sqQD8yea9SO0HKRFTAZG4xwQzouOXc4+i2JYhyvMI2DF7y1uRzjOJUvMxP7RXRWiblz95Ru9K1hsrB+wQ2g7vWVThj5543SCwXJa5QUfAITsAZmpyJXvYpO+1Z7/d6cflsk/s4gCEbT0a+89MP07A6LA/Tj+bzVdH+OWrb+xO6wnvL3xRWQVWy3vGWfozkpkm4iyeoQ7JuF96iwrPuGh9jUE/WXiDFMU8h1rrIfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10777.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 03:03:25 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 03:03:25 +0000
Message-ID: <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
Date: Thu, 27 Feb 2025 22:03:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10777:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d09f3d3-3527-4ac2-23dc-08dd57a47790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXZWL0FGRTFCZnp2aHJNa2wzcjc2ei9mZ0NWNzk4WmxRbzkxbXhpZ2RObGpk?=
 =?utf-8?B?blRBcFlzQ0t4UE4vWHJUdWZ3UFJVK1J6K3hNM0h5TDlZTTNKcGVic1ZXUmFj?=
 =?utf-8?B?bmdOdDB1OFZmQTFpWDBma1BzQkxwbG45SFI2amlTYklNcDV4Q3lMVFVhb2JR?=
 =?utf-8?B?VExIUUFoM2RtdU5TNmJUYnB6NVdlWHhvRlRFY1M2NlFac1JmWjFXQWRMUUJp?=
 =?utf-8?B?MnI2VHZWSmx0YUpraVdrUjFnMlJPdFloSWp5TmpKK25xcWV3aVVTdWliWVZ0?=
 =?utf-8?B?Uk5udEdtUXh3UmNrc0tHMFZqM045U0E2MFU4c09yN01QSUhybWE5ZlUyOHh3?=
 =?utf-8?B?VW5TanVEczRYZVUwdkw5dE8vSXp0ZXFmS0xHVWZoSHdXR3hGM3E0TlFGUHpT?=
 =?utf-8?B?R0x0UEhYUGsrRjRiVEFmYllzRnhXQWw2YnNpYjIvVGs0VTJRd0xIZVdTVVVx?=
 =?utf-8?B?QVFQaGdqQjRiNDJIQWZ5Z0RwZG9NWUt6ODJMeDFobHkyQjh6NFFyYWM5WWE2?=
 =?utf-8?B?L3hoNTdyK25hRk0xaDVPTWsrdWxqMlY1d0hkREltdDlDb3ErdFJFdHNGejNN?=
 =?utf-8?B?SC9XWnhPaDBIWXZZVUtXMmNvUzdOY0NERDBFaUJJWkNHeVYvUjhiNkNGdWdt?=
 =?utf-8?B?QWtsMjRlZGZnN2Q2cW45Y2I1MmhSbE9YcmFUWEZkVklQMFRLQVQ2cGg2MHJ4?=
 =?utf-8?B?TmFRK2xaVTI3ZGI0U1dvQnhuVmo4RTdLekplVWR3WUJKb3lVUTBHY2xlRkdX?=
 =?utf-8?B?K1UrSWhVR0lDbjZReUp6TStWWkJMWHhQSVY3cWJRZ0xCL1JLbUR4VHhCeFdn?=
 =?utf-8?B?OTRYNDlnL0VNOXVQQ1JhZ0gvQzFpSUJ0SlVIdnd1WTVrdjhKWVlxMXc1UjZo?=
 =?utf-8?B?UmxVOU45M2lMUldPLzg0d2RpcXRpOXNYN0tyQXlkbVdJczhvSHhyYUJWaFVU?=
 =?utf-8?B?UHVCdU1jM0gxN1ZaNUkyOTBQaHUycWtDM01CZ1MxRWgxc2RYQTQrVEVIRkJL?=
 =?utf-8?B?NllKOWp1dTc0RkxZckl5aGFucGxjSUVtckpCMSt4My9QbEl0MmNCQmIzU2dw?=
 =?utf-8?B?QWVmdUFxZW01dDBLVEZCUmJkUFhzVEFzMEFhNkMwSENoT0RGcjQ2L2RYOXBR?=
 =?utf-8?B?RzIrSVlUV2tvdDNNaDNoNjhwblN3TUg0WkZkWFJFekJZMjZ5MlFxczVhWmVw?=
 =?utf-8?B?QjN6cDFOMWlaNGh4OEErdVFnQmk1b3Vyb21vM2JmTDg1MUFicXJ5UGpIUCs2?=
 =?utf-8?B?bGJyOC9NbGw5NXd1VXZjRjFHSzB6MnhBci9QKzFZWXRFaE5QYy9pU2RaN09j?=
 =?utf-8?B?eEtVc3dXVG5nKytwRThVTWFmdGtlRm5BUnNBSXJ4QmlEZ2svdERoWTI2d2hh?=
 =?utf-8?B?YnJnM1UvbTZLYTRMYy9meTh0a1dQN1dJWmQ5N2Q5QUprZlRtQ3lOYmtZWWtD?=
 =?utf-8?B?QkdQdE5JRm1uRGdHSmxPMUxwc2ZHRThzM2FSTkRpcjZIOUM0UithTmQrbi95?=
 =?utf-8?B?Rk1tL2o2RiszUTAwMWZQcm9PamRuTm54dmw2SGh1RkZzT3AxRjZJaTB2THNu?=
 =?utf-8?B?UVJzMnVDWUR5a3I3RzdEUHJOeDFtc3JOdllBR040TXAwM1FtWkhwbzRnN3lj?=
 =?utf-8?B?cEY1bFk2dW9DS1B6SzhjRWs2TSthdEpHd1cwZ2lFRDRyaDlBYWRoeTVpMWw4?=
 =?utf-8?B?aENvZkxYWnVGNHZFSEFkck8zWW80anZ3SUU2bzFVamx6TW1zV1dsQ3I0QnFu?=
 =?utf-8?Q?JAR5NvFcL5pbNeHpXzzebU7t0QavrYkByACeGlM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWpjYlprQlRTVEkyZ3F2WDhjeFE3OWN6R2pCMXBYOU51M1pGc3d0cWZEKzBY?=
 =?utf-8?B?Qi9vZ3l0azNtM0NmUG0zNDEzYXVIaFNOaXN0Q25nS1M2Uk84SDkrSCtvK24r?=
 =?utf-8?B?dXNjTlF4bWxHWW00QkczUGhBVE1sa0tKU3pPa1l4RFF0bjRmTkI4UUxNNEhU?=
 =?utf-8?B?TGp2OFczanBDdFhMdjRXM09qblpYdHhvaXNWTCtjOHpmdlBhd0dOeVlJZ1g4?=
 =?utf-8?B?b25JUTBWY3VSOVdUZ2dnQWpEbUVvS01UZjk0M0J2Vnk0UWR4eTZob1ZzY0Nq?=
 =?utf-8?B?Mk5sbHdxVHRNOHJQTW5wc3lNR1NlVkVGWFZWVmo4ZXduRUo2ZENVOEEwcHRN?=
 =?utf-8?B?b1B3TXVlMUEzeExrUWV5TjUyRDVjVTJuVzA1S2tRT3hYaHhvblZhNUtxUzhG?=
 =?utf-8?B?cTNGVVN6bWFLeTJTL2cwemhJbHAzayt4cnRxYjVqRGdKaG91TEVjejErS2k5?=
 =?utf-8?B?MjhDYXFsUTR4ditlUjNSM0ljNXloOUdnVzBObzY1aXgxcGtWQ0RPOE1XRVhH?=
 =?utf-8?B?eDZVeFdqM2xMWEt3RXZuZUJkcTQvbGlhZ0Y3Qm9SakhPU1h3UFcybC9XTVBZ?=
 =?utf-8?B?V2MrcktvaisvazJET0RqbzI1dkpYTjRPQis0dWE5THQySGxZWlRjUHM4Z3Jv?=
 =?utf-8?B?UWhDTFpiQzJzUi9XQW01eHM4RU5QSURESWozSUxWL1dOWU4zTlF4RlBUVUtT?=
 =?utf-8?B?aGVzaWxBRDhDWW9PN3lWeUtTbHlSQ2ZBQTVITzZXUnh4WlBqcDhiYTc1NGRV?=
 =?utf-8?B?QWE0b05aT3Arc2FBQ0hYRkN0azFkRXJGNUZBTFkwV0ZCY01TckFhdXJOZkRn?=
 =?utf-8?B?WXRVL3Z6ZTBTSlArZUxIQzIrblhLMnV4SktZUDZRZnZCWGZRZjlWM0FaVGho?=
 =?utf-8?B?UnZ1cHFtdC9XVVZ2NG4za29mbkdOalJwMTlraVFVbTBEZ3BGci9iSHd5TlpS?=
 =?utf-8?B?dGtjYk52aW1XNWRwRXhaWHljRUkwd2IzdUZvRjdpMEt1N1UwYXZ3N1V1VjlN?=
 =?utf-8?B?ck00LzhDWWU3Zjk3SXdCblJENEpBSEFiQ2JOalFzOHAxNklmNXNWVzFJbnJh?=
 =?utf-8?B?UXVZSVBEcVpIeU84M05pUURBQjR6SU5MVnpoU282d1o5Ri9TMWdISHd0bWRY?=
 =?utf-8?B?Ty9DblRFSjhyNGVuZzA2S0tOUmpKS1VpSjJiWkhwU01uRmlXcmdDcmFnTFR0?=
 =?utf-8?B?ZHIzRDJDZmxKR2taajFVRUtxZ3FWcXhnSE9LUThMekUvWjhBMGUyVm5RMWlZ?=
 =?utf-8?B?dVk2SFpIbnlhY1VqQVFETWFWRmF4UDJSZmsrYS9IS1VUZDQ0MkEzeCtZOE5X?=
 =?utf-8?B?NDRDMmNNZ1R2SDNBSTNySThGbVc5T3YxZGVLY0NvbjlaYTJic3NpblZoeDRz?=
 =?utf-8?B?ZDIvc3k4azVKNUwxbmZONFJwWXR6bFJLb21Ka3NTRk9uTHdZTS9tcUsxdXZ1?=
 =?utf-8?B?MlpCNU41QnlZY0F6ckpWeFFzdk9BSld4dUJuNTB6WlBHTmc0Zmp0MTBtaWVx?=
 =?utf-8?B?OC8zK2hFUWx5YVlOdlltbmp2VXVNWmsyZ2FhUkNPVnNKeC8yZlFxSVdRYjEv?=
 =?utf-8?B?K2F3NE9nYVBOVkNCd2xaZHBWWWwrQlBUaWdTNFBWT2d2UUdYTHF2RDhyaGpZ?=
 =?utf-8?B?TmROZUsva0Y5SUtjMW1SclJvYWlKcHdSYnVQUHRiY0xmcVlITVZTZGlFZ0JZ?=
 =?utf-8?B?b2Z6L044ZWxpckQ1SWZIREdkc3pYN2VIOWxiWldvSm1lR3NPOEZyRVcyMEFR?=
 =?utf-8?B?RkZKUkFmYjc2dW1sc0JCMUl5S3FmS3ppc1RMVHlSSHFOeHRpbTR3bEFKaEUx?=
 =?utf-8?B?MlZHTG9DcUpZaFlzdVkxQk1nVGVCMHo2SzRLVWovTUVuQmRlL0cvcGZjVHQ5?=
 =?utf-8?B?RUVjY3FVMU5TQW1PWlF2dkIralBkTXFwdGdMcS9UWGs4aFVJdGZHbGc3aWpT?=
 =?utf-8?B?M2VmOHlBQVB3TUZENzl3ZmpaT2RMdWFEcjIraWJlVVdrM3dtTUZ2VmRqbGZC?=
 =?utf-8?B?akpFREhuRlBqa05sWGUxUWRjU0V1U1dXZXZHV0ZPR0dBelMzbjBVNzZwdkNn?=
 =?utf-8?B?ckM0TlduNkF2RlpqRmRTclFpeVVTaC9uWVRkbmxwNUk1WHArbW5GQ3ovUzVZ?=
 =?utf-8?B?aGpHandoMDVzSzl0V1VvZStjK3RlSjFjd1hhRitwY1lRc0doejU3T2szcVNZ?=
 =?utf-8?B?KzBpMnpvMzUvbTJ6VEVMY0V1aUw0aDRQQ1VvWSt0Tjh2YkdjK3N1bE91Q01U?=
 =?utf-8?Q?zengiywB0+hNZW2tUB4DHDfkCB3k5qQCQo/4ep9QNg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d09f3d3-3527-4ac2-23dc-08dd57a47790
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:03:25.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yt+FB6kluEw/RIEIgMX+RiGeN0fAxB+siFT93RHm93gk6A5OMktItyFJMrsvSQWX3oxTIEQzBclf+DpeCndZAfIxoqdEeEUaJYFfp33SlSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10777

On 2025-02-27 21:51, Linus Torvalds wrote:
> On Thu, 27 Feb 2025 at 18:31, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> This series introduces SKSM, a new page deduplication ABI,
>> aiming to fix the limitations inherent to the KSM ABI.
> 
> So I'm not interested in seeing *another* KSM version.
> 
> Because I absolutely do *NOT* want a new chapter in the saga of SLUB
> vs SLAB vs SLOB.
> 
> However, if the feeling is that this can *replace* the current horror
> that is KSM, I'm a lot more interested. I suspect our current KSM
> model has largely been a failure, and this might be "good enough".
I'd be fine with SKSM replacing KSM entirely. However, I don't
think we should try to re-implement the existing KSM userspace ABIs
over SKSM. I suspect that much of the problems KSM has today are
caused by the semantic of the ABI it exposes, which were targeted
solely for a host deduplicating guest VMs memory use-case.

KSM tracks memory meant to be mergeable on an ongoing
basis with a worker thread:

   madvise(2) MADV_{UN,}MERGEABLE
   prctl(2) PR_{SET,GET}_MEMORY_MERGE (security concern)
   ~2.5k LOC exclusing ksm-common code
   requires parameter fine-tuning from sysadmin

SKSM gets the hint from userspace that memory is a good
candidate for merging in its current state and is expected
to stay invariant:

   madvise(2) MADV_MERGE
   ~100 LOC exclusing ksm-common code

The main reason why SKSM could be implemented without all the
scanning complexity is because of this simpler ABI.

Thanks for the feedback!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

