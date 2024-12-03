Return-Path: <linux-kernel+bounces-429818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5C9E2823
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676CAB65B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EACD1F76D7;
	Tue,  3 Dec 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t9yPMyfD"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09C1F76D1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242148; cv=fail; b=uRZRwPY7bUzP9QP4yWUD7hCPl75bn6azm33/m1u3STkOjniTBSd6MZPKr+7TatgJViD+Mq6QeDF+uv5XoglIK6fJQlXEUNfRjy4oj39S5shGdeybYNsWp8tQxxg1oFKk8QukH6NOP725gV34dXohg16XGo8UJREXh77j4nZbAh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242148; c=relaxed/simple;
	bh=taHvnctCYmUZGOksma479jAFJh2fSErEGUEwOJykdHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCkyhoNPE9j2INHzPYaNmDOl6SU/cwtpYJ+vh2XQWyXSq7pv1Ipu+sqVDoUTHxC2Ftyq1j9dzWmAm4jhP1ZfL0hZgyYvK5B+S2BXXex3PcpJJWvTFfWBNRYF66BtXVAYIsrz6ZYq7fYenhd2s5cZfHXb963NT2iHhcvBiETTZ38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t9yPMyfD; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlMjMVqVRLgyPUvmBE8vu6vYEA4UAeNptv0T0X1mhNRo01yARhuCD7yCPTameCeVvEoLWN55h//f162D20DXGRcgi+YNZ87lXRL37KkUc5lC0P0uQdaoXbDIb7MvI6DNPCV2kIYA/cgOhZAksHvjSfGK1kKh0+q5R5l+01oNQFvZKo2wGAAlCMMv28Rac4jaKxiMs2iXAcVJrVUUPJDCZyKqYsAei49IONyw3s0P42eXSZXepSBrLFBvtz56R9c5+9uB/jLg7j5GQR3dVQkThGoUjjXdB9vL/qmH169xr7w4LmsF4gfN8rVTlQ6sxsXOm+M9WboDAMMRW9uyk1sHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O05LRWdOhDi9K3ffLMbGQMg88oGWiQl8Ou/P5XFgSNM=;
 b=pdMbPcHkSjMkIUW/sS43S6fesmcUrKKcDpyWaFLudZqOTW6nSyv7nvqyY9+hXVx81L5AMyNwDJ2omHUuZwAidasvIml6Ykq/Eb3Vppu0nTI0uiDhYbwjB4bqgw+O8erbdtJc2c7zftcEqKB7danILPwyVUWdNnDOgBH1eiQ0bfJPsWu4YC7pwIt0nwFzkKPmOG0Kg8FC720UjM6E+LjFpY5OtBTUMrQN/YNswKrGVX3TN8F8vCM1LYKgqQ6dKOtI7krQ9yBcRj6PITPNc6mday5o370ZpmVv957uHZjtBLlA1XaS9dSsiIAKH9Mw+hq3JEVOgKD0/lekTXwpRBXwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O05LRWdOhDi9K3ffLMbGQMg88oGWiQl8Ou/P5XFgSNM=;
 b=t9yPMyfDsNNky33KQs/oyPeFJHipS56s4Z8HbvHwOC907fOknxBK9vdN5WhmBtrFI4HJvlY9W3ibuZIxhQdxb1FxBQeQzPdGGRh3EeKvekD+5IWbD2jvG2R8b8/pW6kIU8EauvLO4qj6mJ6OZFXRTCXh9UpGDvEsUB+TTtKgQYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 16:09:01 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 16:09:00 +0000
Message-ID: <1a3c5a5e-585c-a629-8700-f2e76694b0ee@amd.com>
Date: Tue, 3 Dec 2024 10:08:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 1/8] x86/sev: Prepare for using the RMPREAD instruction
 to access the RMP
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
 <da49d5af1eb7f9039f35f14a32ca091efb2dd818.1733172653.git.thomas.lendacky@amd.com>
 <20241203160146.GDZ08rahZMYc3vyoxq@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241203160146.GDZ08rahZMYc3vyoxq@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:806:f2::25) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d3b99e-72d9-4b2d-417b-08dd13b4ccc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU8wVlRYVEY0Q3NpTU9qQ00ycUUzREhxb21TWUZ2bXNxbWpnMVo4K1kxOFkv?=
 =?utf-8?B?bjVEdCs4eWdJVVVwS3dXQy9mSjVJVTZ5Qko3ZEQvcUliQ21GRXhkNUwrbUVk?=
 =?utf-8?B?UTFjSk1KQ3paMFMrMFlWVTk0SFVHZUpzKzk4Z2ZHMks1eVdJTHdZU1NyVk9a?=
 =?utf-8?B?aE5LWWFqeHVsc0R1aEo1NDBiQzY4OFZ6QmtKRTlHK21UUGYxaFBnQWo1aTBJ?=
 =?utf-8?B?NGpaRHVsODJsd2EwUXpqSzh6NmYwSGI1WkpFcjFkbTcvOW1LWjJvUGJMZGVX?=
 =?utf-8?B?dHEyN3hWTTFoZGUrV3QrZHJZam1IZXU2MjdUM1o2R3RoTXNOcWt6bS9pNEpM?=
 =?utf-8?B?WllFZ1c3NUY4d2E2d2xvb2x5Vmxvc2hzMXUrR1VUWERidTFiY1Z0ZzJzVFdO?=
 =?utf-8?B?UjZnbGZFaGdIVFZ1cW1HVUZjcVorZ09zdGFmRkV5bnVpZ3lpVDJyczhWeUt3?=
 =?utf-8?B?VExzV3RTS042VVM0QUhib2ZVR3diajVKSDdqNlpoWDJMSnhiVVUyMFVycWlQ?=
 =?utf-8?B?TDBJUzJsbU1xTlBqTnlGU2lQVjB5SkRhNHk1eUEweHk3Q0U0TitXUEJZTEdR?=
 =?utf-8?B?bnBEN0pBamkrUjV2ejZaL0U1WVlnK2t1TjAvRzVTbzUwMVczRzFUYmMxU1Ny?=
 =?utf-8?B?b0dwY2ZmbHdwK0lMZ3FqdXVhSExiU0cxN1V6NUg0elhWZDdDM2pIRGdORnFt?=
 =?utf-8?B?NURxVVRFc25ERkFvRGUxck9ZZHdJWVNmUHJXZEZOUlg3Z0x1V0ZseU9HcFU0?=
 =?utf-8?B?cm5tSko5MmcxRjZ0NVlFNm45Z2lxeEViOWIyUWtmdWIyT3NZNlRKT2pWVnJx?=
 =?utf-8?B?cDB6dVhteTVhUkJBaVBxWjBTbzZlTVA5cm43N0pPTVQ0dldPY2R2bExqbUtM?=
 =?utf-8?B?UHRjVmJmMk5UMTNlSFI5dFJFb3pqOEJ4YzFVcndWbkpoRWNrRnh6NGtiSExm?=
 =?utf-8?B?VkdaMXhIODJZRFVFOFNJNHJ6ODZwU3RnYWNTNlA3NWtlYlFHSDdqYjlsYzg3?=
 =?utf-8?B?ZWp2RnMzRDg2VGhWNWFUSnpBWU9LeTNleXU2QXNQZmhzRjJGYzJRZ21BSU5R?=
 =?utf-8?B?ZkxoUDA2TTh5NlR1eklBOTdjV2NXb091N2puMzVnUXN2RzQrK0pyNEE5a083?=
 =?utf-8?B?MkVlNW5ZUDhmdmhNUWxoakR0WURBTUNzMWJJMko0STRMUGwxdURFZ1JYNWIz?=
 =?utf-8?B?M00xOHZHU1NCMER3bzh2WHlIY25JTXJwYVFMUnZ1bUZ0TS9KeDFENnZyTjBB?=
 =?utf-8?B?TDQ0MVJWdVRwRmV5STNoRkQyTjRVT1E4dWhVSDNLSDBYSU41cm4wb05GSG5i?=
 =?utf-8?B?ZThLVDVDMCtVN2JrelUwREt5a2xob2pVUHUxd21GeFhWV0VnYkk4WnlpeW4r?=
 =?utf-8?B?R2dDeE1MbkRYaVVpUjQ2ZXVVL2h5cGc2UGxOd2h5Q0h0c0Rxa0lCR1dJY2sv?=
 =?utf-8?B?ZWl3NGNFVGZFbGREUGR5Zjd4djZrWTM4Qzk5MnYyT3FCWS9aeTZPT1JnYTB4?=
 =?utf-8?B?QzI3SnlwaGQ2aWdIb1ZSWUZSOVBLc3dWQ1FZNUE1YkNRT3JCVElsQVZINmFS?=
 =?utf-8?B?MGlUOURjVFlaVGpnSFZXSkhDS2JmaTVlYU5JcGU3SFphMmpobkFORnZWMStE?=
 =?utf-8?B?bzQ0QTZkYVdqSW9oRmEweUtjd3VGWGFIbFVEL3k5V01oSG96MVNmd0pWbGp4?=
 =?utf-8?B?WDRFQWxWRVllbTJnYndWQmpkcjZOdXRhdHFSVHY4T3VMTUpGQWtDallEYko0?=
 =?utf-8?B?KzIzZTg4bk1BM1dzR1E4MFNCNE9HcnpqVllpZkRjUWdJbmhES3BzSXNwSWVz?=
 =?utf-8?B?V3UrVitRbUZUTzk2REVHQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTlQOUdIOTU3ei8weDhHY0o2bkx6TlVoSzYxbmdzdTY4OUZUQ1RsbmxnNkNN?=
 =?utf-8?B?Wk5VZXJTWEJ2bm9adVpBU3cvNFp4b2NXNE5sbUxPK3BUaS9rUXcrT2x2MWo1?=
 =?utf-8?B?aGZvMXd5dy9TTVFmKzJlamR0MDFzY2pFV3IzK2FpSVZhMXV0UmZ4WEVydnUy?=
 =?utf-8?B?SFFaM1N4NHFtNXhTcmltOEJ5UWE3Mno5MndLeWlmTkpsbmNMcy9JT2t2Yisw?=
 =?utf-8?B?bGMzT3VNcHNOaC82ZkFDTUVvei9iVUFSZzNoOG1BeGRvZDVqZGhVNmpVYy9M?=
 =?utf-8?B?UzRERDc2WExJM3c3SWdiMEc2YlAzdkdXRS82Y3pvODY4T081VFdLVHdseVpP?=
 =?utf-8?B?ckhDU0NqQWN2RkJybUVsNE9tK04wcWw2eXhVK2c0dTEvbVBsekpXMjZIV1VJ?=
 =?utf-8?B?ektjT2h6QnRSNy9aZy9jTm82dVJDaGVISFhZaEx5WGJXS09POCtYdkg5VXZr?=
 =?utf-8?B?eEtFVUtIVW9XbWhzUExYOU5RMWVEWk9jZDlkbU83bU5qblBjd0E5Z3NZMWtt?=
 =?utf-8?B?S05SMmZabFI5dWdtTUd2MHlaZ0ZoeFJjUC9oN1NRd1BHNVBXWllaZmhlNlBk?=
 =?utf-8?B?Qjh4cjJLdE5CRGhiN015UnorZHpwdkNKYm1uSWJRSkNXeUtHWDBLWEZVNHd4?=
 =?utf-8?B?VnNoMFRQQ0JHdHpoSmVNbEJVV1ZmRHkyNk45UG95WnpoUWlaNU5BY05uVEIw?=
 =?utf-8?B?engxT0JGSGowSGJ6aWpsV1cxTHFhYmdLVzlscDRvd2xVUTBsYjhJRjlDWXF1?=
 =?utf-8?B?Ui8zdUJxN2ZPSS90ek4wVXk5UE9jV1NwQXNmWStVaWtaOWFlQUdVdS9QS0Jy?=
 =?utf-8?B?OGpVcWY0YXo4TU1hdTJhOFBHMitzL1M0dk1tTUtzcktFbE9mMGduem42YjBE?=
 =?utf-8?B?ZHd4U2JnRkVBKytRd0dha0tPOXVkNzJXRVRSTDlENWp2Q1pLZkZQckIwQ0I4?=
 =?utf-8?B?M1l0M0JjMFlZZi9pV1pJTEgzbmdpelcwV3ZDeWNJWXBUK21xMDBIOEZSbkk3?=
 =?utf-8?B?QlVabGlzVkd2Y0FZb2w5YURiVnhiQ3NCZkJRZENHU0k3Q0lYUkNabVFxdnZ1?=
 =?utf-8?B?YzArSjI3b292cVQwZWtWaUo2eDVHNCtuNzNkU0lxdUNLNkJaQ2ROMUdzZDRX?=
 =?utf-8?B?b2w3aW51dDZKeTNLbUpVNm5qYS9SdnJ2bGdpVVg2VmpmeDdJUlF5SG9yR3hH?=
 =?utf-8?B?VnFGOC9NUjlqN2x5TjExY0RkQWlsRFJ0ZEE1K2ZUeDgwQ3ovQm9sNDFIYVYz?=
 =?utf-8?B?NHpIUkdiZUpWTXlKWE9tVW5IeGMrRGtaR29NU09EZFpDZTFVMmRyVlhkcVpu?=
 =?utf-8?B?ZW80YTRHdWJ2dHJYdlhyY0F0VHBTNS9zZTMxcWR5b1VCNllKbFh3Z0wyME45?=
 =?utf-8?B?d2VqeEpQbE1qRFhTWUVIZnlmTkhxU3UrRnk1QitnamUxUzJpV1BJUWl1KzMx?=
 =?utf-8?B?eWU5M0pYRFRNYkw2eVQ5VkhoTmJkUWR2KytWNjdqYTNZWThWOUdveU5BTDhQ?=
 =?utf-8?B?cCtoa3MxWmNtc09kRmxkbkhwZkc2cGhlM093K0s5SnpPZmFVYmJOYlJRcWRS?=
 =?utf-8?B?R2lITGYzQ0VaZlMwUDMrQlY0NG5UU3VuUG85dWUvamZRaDJjS21OT2NmbDVG?=
 =?utf-8?B?d2NZVTcvZTUxNUU1Z1YwOGZ3R1BPajJJQkc3SE9KWG0xWENQNWZkaDM2YzRp?=
 =?utf-8?B?YXZacEhteWVlUDRDZGQ5Z1VyODdLOEpQQzJQeXBtRjdkNnlFTG91c0lzc0Yy?=
 =?utf-8?B?S1JEOVNBZXQrQk8yZzY2VXQ3K2NqUmRGWXl6QVhKOFJPd1RIZU1LMTgyVFJ2?=
 =?utf-8?B?anU0bzJQUm1wczZOMzBKWm1ocWhqTFd0RFNXUHFKVnd6REVTRm5paHlOMndJ?=
 =?utf-8?B?UVA1ZjVmcWdKUWRuMWlJVVIyTWhWTEM4MFZVd0VXeFdSKzVYTGNxeU82Rm9h?=
 =?utf-8?B?K2QwdysxcWszeVMxSkhPSDdPeGdkOVJtS3hvbGpPU1I2WFpscWJYT1A0TXNJ?=
 =?utf-8?B?MlJ4RnRmbUprNDYydXVlZmtCNklNK1FEbStZbFJCamFRNDg2OW5ZTjFqOTgr?=
 =?utf-8?B?YWVDYXU2eTlRUy9UVU5tWk1ZMUtGRFMzUVN0bmcyb2g5eE9TMi8xNlZjVzF0?=
 =?utf-8?Q?XeMz2i0efy43soMPMoAnQbkxk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d3b99e-72d9-4b2d-417b-08dd13b4ccc0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 16:09:00.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybj+xz8BP1/DnWRW5u45cnUYxK1QTlq1u8DQohj5qtTNxHK4qt/6M9QW1duONvYwueYj80EkeeyWhrQgB2RyWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979

On 12/3/24 10:01, Borislav Petkov wrote:
> On Mon, Dec 02, 2024 at 02:50:46PM -0600, Tom Lendacky wrote:
>> +static int __snp_lookup_rmpentry(u64 pfn, struct rmpentry *e, int *level)
>> +{
>> +	struct rmpentry e_large;
>> +	int ret;
>> +
>> +	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> 
> Btw, just a side note: this is AMD-specific and x86 code so we probably should
> use:
> 
> 	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> 
> For another series.
> 
>> +		return -ENODEV;
>> +
>> +	ret = get_rmpentry(pfn, e);
>> +	if (ret)
>> +		return ret;
>>  
>>  	/*
>>  	 * Find the authoritative RMP entry for a PFN. This can be either a 4K
>>  	 * RMP entry or a special large RMP entry that is authoritative for a
>>  	 * whole 2M area.
>>  	 */
>> -	large_entry = get_rmpentry(pfn & PFN_PMD_MASK);
>> -	if (IS_ERR(large_entry))
>> -		return large_entry;
>> +	ret = get_rmpentry(pfn & PFN_PMD_MASK, &e_large);
>> +	if (ret)
>> +		return ret;
>>  
>> -	*level = RMP_TO_PG_LEVEL(large_entry->pagesize);
>> +	*level = RMP_TO_PG_LEVEL(e_large.pagesize);
>>  
>> -	return entry;
>> +	return 0;
>>  }
> 
> ...
> 
>>  static void dump_rmpentry(u64 pfn)
>>  {
>> +	struct rmpentry_raw *e_raw;
>>  	u64 pfn_i, pfn_end;
>> -	struct rmpentry *e;
>> -	int level;
>> +	struct rmpentry e;
>> +	int level, ret;
>>  
>> -	e = __snp_lookup_rmpentry(pfn, &level);
>> -	if (IS_ERR(e)) {
>> -		pr_err("Failed to read RMP entry for PFN 0x%llx, error %ld\n",
>> -		       pfn, PTR_ERR(e));
>> +	ret = __snp_lookup_rmpentry(pfn, &e, &level);
>> +	if (ret) {
>> +		pr_err("Failed to read RMP entry for PFN 0x%llx, error %d\n",
>> +		       pfn, ret);
>>  		return;
>>  	}
>>  
>> -	if (e->assigned) {
>> +	if (e.assigned) {
>> +		e_raw = get_raw_rmpentry(pfn);
>> +		if (IS_ERR(e_raw)) {
>> +			pr_err("Failed to read RMP contents for PFN 0x%llx, error %ld\n",
>> +			       pfn, PTR_ERR(e_raw));
>> +			return;
>> +		}
>> +
>>  		pr_info("PFN 0x%llx, RMP entry: [0x%016llx - 0x%016llx]\n",
>> -			pfn, e->lo, e->hi);
>> +			pfn, e_raw->lo, e_raw->hi);
>>  		return;
>>  	}
> 
> Do I see it correctly that we don't really need to call that
> get_raw_rmpentry() again for that @pfn because __snp_lookup_rmpentry()
> returned the whole thing in @e already?

The idea is to dump the actual RMP contents that exist in memory. The @e
value only contains what the RMPREAD instruction chooses to expose.

Thanks,
Tom

> 
> IOW:
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index cf64e9384ea0..2e1833426b08 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -387,15 +387,8 @@ static void dump_rmpentry(u64 pfn)
>  	}
>  
>  	if (e.assigned) {
> -		e_raw = get_raw_rmpentry(pfn);
> -		if (IS_ERR(e_raw)) {
> -			pr_err("Failed to read RMP contents for PFN 0x%llx, error %ld\n",
> -			       pfn, PTR_ERR(e_raw));
> -			return;
> -		}
> -
> -		pr_info("PFN 0x%llx, RMP entry: [0x%016llx - 0x%016llx]\n",
> -			pfn, e_raw->lo, e_raw->hi);
> +		pr_info("PFN 0x%llx, RMP entry: [ASID: 0x%x, pagesize: 0x%x, immutable: %d]\n",
> +			e.gpa, e.asid, e.pagesize, e.immutable);
>  		return;
>  	}
>  

