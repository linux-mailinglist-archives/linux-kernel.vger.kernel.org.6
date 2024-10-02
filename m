Return-Path: <linux-kernel+bounces-347370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3EA98D1C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA95B2877BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972CB1E7676;
	Wed,  2 Oct 2024 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IzWbk9TZ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA41E766B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866479; cv=fail; b=kZgxt3194mkGX8R3X8LdNvEWRvqwxFlwLM0Mo06zz85YZ58fIerQS6cqPN2dTdsLb8aFDlkutDlNgTGUshoFtoIfeLj9A4jHPviofQODb77AOw3KQEX9CjrQwyIiRj4n3iBG9CizlfZJO7Pkq6hcLtwcOODVNDcH0gnowQBdXRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866479; c=relaxed/simple;
	bh=NsBEGzEFIdfbZtboP3xI7UEDh8L93artKwxDu0qgOLk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fCMU9JI/oV48Pz7NCRsmA/i+37aSTI8WJJNEko2RZaaWrnja1AifRIIWVWCHg1zIR9VqKIT19cc5FfRISBYQ+zbxwY0DBNpycpifyPfbvfBxAkN2KvWKfzBlKqbHQKqzF0Tg7qCPyi7Lwra3SkUbpJv2y6bNHLU8k2eubZTNZpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IzWbk9TZ; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ50DBDGanxomnv4X252d6Y/y1MXJ6ikUmgH9YovoVj/NkNNEdkUeI9W2EVYi2I+UjzLEf++hfchWSVjcrh0oVMML85dK8JNdcpi+gy2UFFZpdM2ESAyKa6LSck/oDUGyN3wmh53xDNapzVFUnaioI7a1p+Ca/BQV5Kj6R7fOekVe82ny6v+mb+oGBZXEPTvDQnU16hCjKtQavpapF3do9wB1TCnFqDZSc9Csq8bXo7nC2tiZo8ZwDyI9hBznkWX8wAVixi1McEK4T9jfs+oqaIsEUmMpUvzNg9Yg2wtopQ9XOVbyrwh/b4ZLqhiyyoZOrTfTP1r5JZly55VTF1+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upIk5AKkBPyXRSk8pUBuzyUsd4ID6ku8thYiArGjAEE=;
 b=lEvtI4pHD/em7pjX21vT7TKGvdRnVz963YyWRT3oNplwRqnI0qIL9D/TodiaYu4qysQBVJ+ssD0+GYgTk1aaD2fJJ6mAFIRwIXhzkcgGxYAhmQB24HXLOTNi7bQI7fR0mCzaEaRTMnn4IywmANOlTzZq7oe6JNl9h3bzs9Z5/7HD4uZ1zIj8P3IYFcVhnHrqdUtmsOfW3ipsYCOKEQa31PmkffGSNbxDAnEvzyme6gjohya81Is/2qU/qnJNnhWwVMH+BT8ore6LmseQfZaaKTyDGVPXvigk6Oh3b4HySV6weo+ZY3NJv//TblkKNjlSnPA5eB6/yPKSsYnmNoypyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upIk5AKkBPyXRSk8pUBuzyUsd4ID6ku8thYiArGjAEE=;
 b=IzWbk9TZcNO3Olrpsq/ypj/xZvlIGCg3UMXwWkzxXpDARxNl98z2y5JvcyPc4VRWhLImzmYpWP0E/fUWOlzbuX3tKJwKm/Zbvitq7O5EwYOkJNYT/ssHzNcuGCu9v9pJS0n8yI4+2K2wKhu/Ttwlo86heyijDvhY4tP9XKXjysQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 10:54:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 10:54:35 +0000
Message-ID: <7bdbdd0e-9fcd-4f41-8352-18a98161f048@amd.com>
Date: Wed, 2 Oct 2024 12:54:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: xilinx: add a warning print for unsupported
 feature
To: Ronak Jain <ronak.jain@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920055410.2658465-1-ronak.jain@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240920055410.2658465-1-ronak.jain@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0126.eurprd09.prod.outlook.com
 (2603:10a6:803:78::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7f0920-f353-4f56-b239-08dce2d09a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3Y2cVdaL256UnhKc2ZuUkdQa3M5enBaTkRkVlZkU0hZZ3NNczh3WnBHR0g2?=
 =?utf-8?B?dWgvWjBhTVowOUVuVlBwOHB2Ynd3OVRyck5KUmlhVnRhcVJXZkpUbUZKUFNL?=
 =?utf-8?B?bzZreGc2eksrcmVNTktJRE9USEZZb0JydHZwSmI0YStiSnFaSnUybFRzaUhx?=
 =?utf-8?B?dHhYQUp4L2c4TElMTk1MaUN0TUpnRHdNenAwZjdseFh4aU9hQnF3amZIemsy?=
 =?utf-8?B?bHk0QmFkS21ZcnFrbm5HRnptZGp6Z2pKY3F3bE1ibExEQ1VNclA3NWhrSkVl?=
 =?utf-8?B?MU9peHd1S1F2bGk1bXF6Z2F1SEpDNGgvY1dva1cwVHJpaGMrUUNGa2NodzlF?=
 =?utf-8?B?NFJrM1hJemlUU3dsMWtNNzczYUk2RUpaVG1GcS8yaUgxWDdiRVhuc2dzY3JV?=
 =?utf-8?B?MEFPWGdKNExGN3BiMDNDdFNHT3UrZkRvNzhsRzNtSmMvQUUwVEVxa0ZpK3NC?=
 =?utf-8?B?a3ByV1c3QTBpQXFyQ0E1NWpTY2ZGa3I3Y2VVZTJTYVZ1MVlHS3h6eTlWdFdQ?=
 =?utf-8?B?Zkh0ZFRMUXJVcm5jMVZ6UC9ITG8rdW1ZN0FTcTRYVDk2MC9hMXFsSG03RlE4?=
 =?utf-8?B?Y0pvVWNyekUxZjJqNUw5TmNER01oMWdYMFpBTlJtWmk1RlVldWkzcm9ZVlNm?=
 =?utf-8?B?NGlqeTIwK2YzV1NONVl2SXJqZ3ViVkFrT1lIZDMwSUlHNGdBS0E1bUxVU1RO?=
 =?utf-8?B?VnpkYmVZSmpjYW9GT1NmTDNTQzFESDNhWFpBK3FuRUtsVS82U0tFd0tNZ2VZ?=
 =?utf-8?B?VzB0WVNWQWhpdWprOEZvV01LNzAxUHovOHFtQjNlSTNMZXViV1Y0bHAxaG5y?=
 =?utf-8?B?Nk1wK1VYZmlVK1pGcEZKTmFzaE5rRkFzQmRMdmxQM1FINXp3anNoWmhmSHZZ?=
 =?utf-8?B?UkUyUTBhbGJscmJFU09odzVRWEMrK3JOTzEwUHIvb0NHREg4WW9tWEh5d1po?=
 =?utf-8?B?Wlo1dkt4OUJNZGpyNFYxZjNreExQbzM1aXNRN1BYOXZJaUcyamJYS2s4NEFa?=
 =?utf-8?B?NjE4YWlDT2U4MXV3TTFoRUpGTG1nZXR2cklhMkU5L0pkRkkxRU5HMnY0QzdE?=
 =?utf-8?B?cHZGdytaQ2pNV0VLYUMzRFhlaEk4aDdab3EyM3pORG9PQ0crb0FLQ2orVzdx?=
 =?utf-8?B?cHFXWStRa1ZCbmM0TDBuaXNhV3pHQ2Q0d3YvMDk0MkVabGtRZDVJeFpRU3FQ?=
 =?utf-8?B?dWk5VzlXUjNKNzBpWE9ab1dCdGpPaC9nMGwxVENyWTZ6cXlHbGhscWxOMzlG?=
 =?utf-8?B?RXJYdnVUVEdRZzQ4NXNrMys3alR0VjFRZ1ltaGF4bWsvSndLMW01ajdZeXor?=
 =?utf-8?B?dG9VU3l5VmI5Y1l3SlplMzFBQmcrWXNpTVl4dTZPVVhiVnN0ZGhDYStFZEox?=
 =?utf-8?B?Ly9LSmk2WTFabnZHbUVrczRNSWx4b2IwUVJEaVhJWHZ6emRCSFk2SjZyRlVJ?=
 =?utf-8?B?VUFGZG9DZDRGM2h5SFg3cWtpRGUxaWtkL01NV3UyUHg2L09FMEljV2YxbE9B?=
 =?utf-8?B?czRjb3FvTmk0Nnk1L0ZUcTVYS0tpMWZoSjdGY3ByRjVwOVpwMHB4a1NUbkRI?=
 =?utf-8?B?T3ZMalZqMXRGdU1TY0cyZ0JndS9pbVhYZ0pvV3g5c3JLdXMrb2tpRnZXVWFm?=
 =?utf-8?B?dy9SRXZCTG1MN3Z3M1FIdkVmWXBuRWhCSWVBb3RuQTkzS3g5dTh4bW50bXhD?=
 =?utf-8?B?UjkzVWRjbThyNDByTXpCdDdRMlhIQWk1RTUzNEJoTCs1dmpYS3dOS0NBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlJEdzRMc0crWksxMzVRZHNuckhGNGMxL09YdXBvZmUyYWcvb214K1JzWkJW?=
 =?utf-8?B?WldiaUNXSHhIbjVGVDc3WnN0SWk5V0xBUmJaVDhZU2Mwc1QyeTlnL3p5cmtZ?=
 =?utf-8?B?NnlDaXFMd0swcTB2bWdEUzFhSVl2Y0FyaDNvRjY2eDU2bEVHSFp4STl1bXQ3?=
 =?utf-8?B?L0tqeWE0dzN3cjhlV2JCd3VacVArOFJtV1JTRk5MSEpJZFdRdkZmVHZvV3JQ?=
 =?utf-8?B?YnFyMFFIeEZJL29XNU5paW9jM1IrK1Z2d3hNRWh1WVE5UjNiZEM4UEVxZWJU?=
 =?utf-8?B?b1JNU3FESFVqTHBmeVExLy9SLzYzbHI3WStsUlBpVlhCajVHNXE3bndKeWtl?=
 =?utf-8?B?VVZUa05ab2FzeUg5SlYzcnpUa0VPWE9yUCs0NXJnVjhFVzIrT0szWWRBUmpP?=
 =?utf-8?B?ckFkdG5IdjBQTXdKYWN0cXA4b2lUZjJiQ3lMbCtReVFSTDgwRUhVMG5SVVo5?=
 =?utf-8?B?NUdpU1hPZzlrYnZNaTdzVWcxY3M0clBCcXYzaklocmtsMVdiSWJTUk1oU0lW?=
 =?utf-8?B?Q00zNzhsdFRBSUxURitYZW8vbUJ5Rmt4N0JuVEx4elhWNVpPVEhpOFpJdWdY?=
 =?utf-8?B?TERGRU5QVUREQnlyVDIyNXVCU3B3NEhuV05BWTNnOVUxa2M4Y1hmUWdNQ1dF?=
 =?utf-8?B?Z0p0OExZZUYyMlNzOWJxNGlBN3pNSU1hOU9YMGpnbGNmbVEvV0E3OXk4TXRZ?=
 =?utf-8?B?WHBOT3RpS09naStqOFVLclNBd09iSTExbDd0dG93L0ttQXpQbm1kQ2hPZ212?=
 =?utf-8?B?L0VncG13VGoxR25oeDBVRFZSYy9RL0I2dHJpZEorTWF5NmdIejVsaWFXOS9w?=
 =?utf-8?B?NjNUZDY0REJlK2YwcjFLcUk0Sk1KQVppY08vV0licmJCcGRUdVhjd1QrQlhW?=
 =?utf-8?B?VDBUK3RYWmNIQmVzbGk1bDRZaERFQmtaL0gvYm5NNUxCYUg3SXp2cnd4SFRk?=
 =?utf-8?B?ZkQ1OVAzTm4ycFcrOUV0RWdnaG1rdU5kWGlDWmk5ZEUxcERyMjFNRktIa2c2?=
 =?utf-8?B?V3IrdWJXVmhKc3lsV0ErcW1zMG9RVCtJM1EzVllJMmIvL3VuRGhNU3d0azZK?=
 =?utf-8?B?SHF3aEVWYXBxakJ5aTJMNUh4R3E0SDduOEZzUXNXMFY5a3RTSDZheE8vMmVL?=
 =?utf-8?B?Q1MxKzQvMWtqbXA3WWg5WWU5RXBuZy9NTEV1QlpCZk9mRUxjZTNyQnVDd3JF?=
 =?utf-8?B?OUJYeFkrR2w1eDc2cyttUkFrT2Q4Y1Zhamh0a0NKdm41a2JRaUFNRXZqc01S?=
 =?utf-8?B?WFBvdTZoVmNkQVREYVNkUEtjR0FySURucEg2MzNrMkJPeWZrdjM5WmZ0b1JK?=
 =?utf-8?B?bWMwRFBiVjNYUUFRQkZFZlU3UFVaaU1qQkdmaGJwb2VOYWdIaVFUNVJGczBZ?=
 =?utf-8?B?RlI1bXNNdDFRWkVXTTVzd3JTNkppdFdrNmx6bGlBRHZwNDEvaFFER1JtWnBL?=
 =?utf-8?B?WjlyRk9CdVBYSDM4aytmOFRCeW5Od01pS0JuSnY4TCtNS28xNjZDK1Z3Wk0w?=
 =?utf-8?B?VkR3TldmWFpCVTlMUGVEanFTYmNSUTB1Y0l0dTVwZE0yeXg2aHRhcVdZclRj?=
 =?utf-8?B?bGNjV2UwL25WWC9JNVJOMmpiUkRFU054TWNMb3lkVTIxSnd2QVZFSlIwVXRI?=
 =?utf-8?B?TGtic2owQmVWaU4wbWJ2b1VJWUNwUU5sbWlER0Q0WHZHRDQxSHY1MWZXRkRx?=
 =?utf-8?B?SG03MW80MXM4ekdoemhkaGphc0FtUDQvZDFNcmV5ZUZSa2lxanpvcDJad3Q4?=
 =?utf-8?B?WmtYaUIwTERIZmNqVjBvMCtPVjEzWjl4TDZwQTF6U2dtbEpyQjRuWVNONkI4?=
 =?utf-8?B?eEZQeEp4ZDliMHk5NTRvOWk3Y3RMemFmNW5wZjhaanp0QVRGYi9rSzA5Z1VR?=
 =?utf-8?B?aTRxdDUvWStTcUd5Y2huMDUwYi9OMElFd1FZdUR5ZTBpY2VOc2tqNDdKZkFW?=
 =?utf-8?B?YTNLSXI1UTQ2bDhMeUZkT3NXQVZLejhqR3k5UHVHZ1JEdmJ6MGtmZndETWc1?=
 =?utf-8?B?MmQ2cWhDNzBTNDNMdytmaHh4QVNyblZVSlBDalEvbU5uclQwaHErOTNOVXl6?=
 =?utf-8?B?K0Nock41eE9rTFp2NjhSNFQ0VVMrZG5Rcm9hTEh5QU5vREFVWjhBN2RXaUlz?=
 =?utf-8?Q?uv+mPFuJTZ2r5by7P9f4QUryU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7f0920-f353-4f56-b239-08dce2d09a38
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 10:54:35.0964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jazugzyCBZLaFsZTPLI0Nrjka+bG8KmcLw/l9QkAO7TYgxVVLqeM4lR2+tqOdhHb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876



On 9/20/24 07:54, Ronak Jain wrote:
> As per the current code base, feature check API is used to check the
> version in zynqmp_pm_pinctrl_set_config() before requesting the
> firmware, and if the expected version is not found then it will
> return an error. So now when the latest kernel tries to access the
> tri-state functionality with older firmware, observe failure prints
> during booting.
> 
> The failure prints,
> [    1.204850] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: failed to set: pin 37 param 2 value 0
> [    2.699455] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: failed to set: pin 44 param 2 value 0
> [    2.708424] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: failed to set: pin 46 param 2 value 0
> [    2.717387] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: failed to set: pin 48 param 2 value 0
> 
> Now, these error prints mislead the user whether it is an actual
> failure or the feature itself is not there in the firmware. So, just
> to avoid confusion around this, add some debug prints before
> returning an error code. With that, it is easier to know whether it is
> an actual failure or the feature is unsupported.
> 
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 0b2ad46c8bce..cdb565c41119 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1245,8 +1245,11 @@ int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
>   	if (pm_family_code == ZYNQMP_FAMILY_CODE &&
>   	    param == PM_PINCTRL_CONFIG_TRI_STATE) {
>   		ret = zynqmp_pm_feature(PM_PINCTRL_CONFIG_PARAM_SET);
> -		if (ret < PM_PINCTRL_PARAM_SET_VERSION)
> +		if (ret < PM_PINCTRL_PARAM_SET_VERSION) {
> +			pr_warn("The requested pinctrl feature is not supported in the current firmware.\n"
> +				"Expected firmware version is 2023.1 and above for this feature to work.\r\n");
>   			return -EOPNOTSUPP;
> +		}
>   	}
>   
>   	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, NULL, 3, pin, param, value);

Applied.
M

