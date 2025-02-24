Return-Path: <linux-kernel+bounces-529924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3975DA42C97
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470F7175A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B31FDA6A;
	Mon, 24 Feb 2025 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LQ48gqHf"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020084.outbound.protection.outlook.com [52.101.191.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA11CBE8C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424693; cv=fail; b=Q9wgY8cOo0LtDq3HCbyEsy+x+Kuq0VpIod3EEpq7lhe8WgvZiF+IA+wVNCmtlsXUEZSYk2oIwwIlpg1WSTS1B0EG8hB4/taZNVriL7fL4FN4ib2P1IM41MNzQYWfg81tflCC26UrO/MnvQc9XgITwA/ZFsHr4ei2BfRDDOPGcSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424693; c=relaxed/simple;
	bh=GJLF2a88T1ZV7+Dejmk5vdOSztumUYw0lPN/vOvirok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nj3n30avWujl8xVbe+Q4FwsLE/sDOkLNpRwzhBnMtcQlzXJCPQnxnrUdVMUJwJyyHWxuLoWMO8oi+V0J1zGOBy+bljxWZzxj7UoEldBteppF1e70aS8TYuGkVj9sftpVYiEbAvag5moCVFLbcY/fsdxRTBouwuGUF8fJo3qH6Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LQ48gqHf; arc=fail smtp.client-ip=52.101.191.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5kQ9SsRnbf/Ezex9Y4sS2l2rRoAEED0/MgqVhA62v2R8hX4gdZgvzK1eCJ485irCii85j/Il7SlW1VJ9MOqNUpPPyR50uuVjyPGAyapeYRyeuYslnlHCvTcm8QcXBGmgy/cqWvitfvWVGnqDTBgqyQJ8lf5n+Wxd4KN8r0OtOybHGVspUI580tYA4V+MuJcGui7axV6+Dj8cYkcdtgQNDNIFGpKRlhRIgqtSDxyYLdI1Gppu3OprsC2KMZDu+VYSIetqQu46AQTgkSbDHqmqUSqeSTlmH+5smEaVQXbattHhwWFiw5l456Pnt1eeC0QoMm0lJ5S6znDI8pM1Y6QPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k73JqtUI02z+r4fNaMaC3BKLlzSFxs5OZ9ypN5Diq0Q=;
 b=w9dHtpqO+/YD+CbQ2vNnObHXcbQSHEf37ifBI1Vog6zRWc2slEyco6rFxSTcotHz0XdfF6P1bN+flasVQJJmI8r1aZWT/mryyuCJLcLvnKPMcKpqYT0l8wow6Z+aIf+DXXA2GOFNlt3tNhvRYh9qIY15S2WaPiDfnQ6+MdZ0nDfAh7FzVXrm6kPFhb0jNjUB6k9m1MuMibNsCWYVTddPcXVgJvk/Vgip98uzM2POO3CfWOB+ri1BBfZA0/62NlKCL+TnARqDRjubQzWLjDrL7aoMkVZrSbx11eHXKCnvMHWvq3ShiIPXdPtPXdZKbe26blaRYapxQ3Lb6uBacPQe6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k73JqtUI02z+r4fNaMaC3BKLlzSFxs5OZ9ypN5Diq0Q=;
 b=LQ48gqHfm1/H3hypF0jurCZurq7C7x4mbLSsrQyhcpz4SMAn8O4ZCPUvURmFl0rR0zZYB2yunqRcqNoJUogNQbWb2AmXjRGxZp3R3lb9Sq76vaEO7S7Lb1I5DXgTtJv4GY0STYreBa7RRJL7QImxZLxBZQ8nrnjS9Nj7Bw0ztYPqKHKSBkIGh0qp0kb/kQPuNOA33rZdwM+XWDxrVTCHwhtmkMlfDHogjNQASDQs16UZx91Rgt/EnSITDzavbPuGFspoKn1lcW0M1sBPO39a1jgNAg1WTW/r9mvhvO8DIjvEWACLRib8KDKasF2ohBLxRqH7xCSkOnhcHsSeYWhltQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT5PR01MB11195.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 19:18:06 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:18:06 +0000
Message-ID: <b18e6478-ef4b-42b3-8cc4-42467b3a0a7f@efficios.com>
Date: Mon, 24 Feb 2025 14:18:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740403209.git.dvyukov@google.com>
 <4e93f7da6dfa450d488fafa3599306349e6e34e8.1740403209.git.dvyukov@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <4e93f7da6dfa450d488fafa3599306349e6e34e8.1740403209.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT5PR01MB11195:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b86273e-5c37-4495-4861-08dd5507f7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0l5bno2UGNwVWJ4VFZmbG40OWhPQWEvSTVETmJvZUp3d3phYVFhZlBhMEZH?=
 =?utf-8?B?RFk4NmJUdVFXcGRQcEdMZVhyWFZZVXJlbXV1c2lkaEdOUGNFMW5vdTRRMHdw?=
 =?utf-8?B?eUJQZ0JIa3VwUUEya0VPK2U5VWRZR0d6Sk5KQ29hRFlnLzM2cG1YeEpOaEpC?=
 =?utf-8?B?Z25XQXZkdXZSWmd6bmM1WGpuckhSOGJEMHZQR3h1MFZtVXJSNFFlaERiTUhW?=
 =?utf-8?B?M3FJQkpPSU9rV1A3MkVPTTNFTTdjeXFzMUU0TWo5OFZPTUd4VWo4alE5eFFl?=
 =?utf-8?B?TG9FWHo3d0pYYm9nYjVMT3NESk1XR3prVUZkc3BNSXJUY0NGak1OMEM2d3hw?=
 =?utf-8?B?MzUyYTFacmVLanpZODM4MXNvbjl4Vko4TjNrc3hyRFlHc2VZc28wZDd5YjE3?=
 =?utf-8?B?eHdIejJ0MnlBTXc2VHVjTUNWL2VJU0ZPbE5QZXRmT241TTdtYWtQMzFOaGV3?=
 =?utf-8?B?TWhPYzRyaUU4Q1dRVXFQcndCaE1Xc282YUZwRTAzQ2V4RUczRE5MZDFmcEFP?=
 =?utf-8?B?QnFneWJyNnYzUzN0djZoSG9YTTE4Ykd5aUdYNTdIRFNhR3dUdHJwWFFmR254?=
 =?utf-8?B?Rjk5aEtqQ3ErazBxN3RqWmVGOHIxN3dCUFUzV0FSbUNRWk9uTE1tcjZTcjZL?=
 =?utf-8?B?S3R1NEdOa21xdWZKSk1HanFHWnVaZmp4ZGVKaUQrNnZYVEszYi9FR2o3MUdR?=
 =?utf-8?B?WEFwQkxnbzY2R3N0ZTJOaTlWRVM4b2ZQcmVKZSs1UG5nbDB4TkI3d2x4a0pH?=
 =?utf-8?B?cmgwZlJXMkNMS1RzaXllTUFVa2FxQ1BVSGlJQVh0eGFacUdRSFM2THJsdUpz?=
 =?utf-8?B?VEp6MVhra2ZPL1VLa05JaWZvcjBvUE1jeUQrZXk2bWZHcGpzbEx2Nlo0V1Q0?=
 =?utf-8?B?NXh0Z3ZjNGxEeXJmamVpMEpsN0svb1VjN1FTYlFFL1lYRDJhOFY1WHNXb1Fo?=
 =?utf-8?B?L3VNaFZoWnpMMVVnT0tUYmxHY255NnE1cUZUMjdyZ3AvUkJIQ1BPVCtSSllC?=
 =?utf-8?B?ekI0UWlnWmY5YW94dnUwRFJJeTdFRjgyL1V2d1hsajc3TVJ1a05rSERYeUor?=
 =?utf-8?B?RUkybVhCY2taVnNQbTJhaG8yZ0psbzgvSUllYlBlQnY2Q3lBMzZmVnYvZ1pD?=
 =?utf-8?B?S0tzejBOZ3FpZTQzVU1TZXFhN2o2YTNYcFJKVlpsSHp6eGNFRE5GMTZ4eFhK?=
 =?utf-8?B?MU5WemFUc0NqVzJiNW12dEJTTVBpRDcwNFlGQW83MEZhLzV5YytXMEdqVHFK?=
 =?utf-8?B?Y3lySlRsREdlWEV1M09xWjI2OG9pVmlnSmpsUmFqZi9PYWRiVlo5UFFCajdD?=
 =?utf-8?B?ZjBwWDAySFM4Q2hJanI5OFdKSnVNWUhzcnVXNFBEOHZURmFlOWdNRVk5RFdE?=
 =?utf-8?B?RXQvczJxUGpldVVqM2ZpQ2N3cXErSk1uRmoyU0M1Z0JQQzAzMmFMMzVMOWNZ?=
 =?utf-8?B?NmhoV2ZjOEYzc2RGdDdOZ3M5b05rK3JONTY3SUhvZzBNK3FYZC8vd2xlKzBi?=
 =?utf-8?B?K2JtekliS09mQVpZQTRtRzRWRkZBeC9WbnIyMWZVOTJRK2RUZ0NydlJYU2FJ?=
 =?utf-8?B?bXUxV29oalZ2MElVYnk0alJuRERGdGsrOHJBTTRoN2tPS1FPZWs2dUR2MTc0?=
 =?utf-8?B?TjE5SFpldXFPRmxTbmRxL0EwcXZnakNIM2x5SHNZN2srU2JDY2gvbnFTUkh2?=
 =?utf-8?B?OFhSWUgya1FvOXA2Ny8zWjhXMGljTVBWRis3ajVBWXdHV3pZU2dZQVJTdm11?=
 =?utf-8?B?TlF4OEZQOWt4L3hmMVFVRHloQW43YUlHZ1JaOTZPOXNxNFNwblcvRTVGUG1l?=
 =?utf-8?B?bnRFZEgvb1NVSWlaMUpETjcvUzltc0dhWFVOeExjazNxbW5VMlY5R3dLU0pK?=
 =?utf-8?Q?QC9tfejxaiPO4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1N2bm5ZTlRjOTZkMTAwRUVaa1g5UDMrRU14RUl5LzZ1YTB1eElZWmNRRW1I?=
 =?utf-8?B?MkdqRUVmZ1FDZC93NHBlOVY4VEJLWlpDelFZS0lLdzRVZnBpbFNWSWh4V0l0?=
 =?utf-8?B?cmdTMFdmZUhtT1V4OW9zdlpjWmhVWTM4citxZTlpeHF6dWJQUlhZRUNzTE5u?=
 =?utf-8?B?elUvaUdmNEtjaUhwc0RxTm5LTEQ3Ni9mTHJuZzhZZmN0UDBDYnZwbWgweEE4?=
 =?utf-8?B?SzlrWDB3R25IQUxQUkkvR0hrSHdkYldsUmFURXZQVERzMnhrYkQyYkdBRTZs?=
 =?utf-8?B?NTZIVk9SNTVJK25NNndWOXd2R05KZENWa2FKd2dUSFM1MjR2N1VlaXd0ZGMv?=
 =?utf-8?B?N21rc0RFK0pNdC9saDErUmJvWkpBQjhLQWhIZHdzcFVyZXhadlYwQTJzSzZu?=
 =?utf-8?B?Y2syODQzQUNIM0NSY1I5UVpOTVdwdVgySU1zMEtPT0pXT0VqL1FaWGwrenVp?=
 =?utf-8?B?QVo4azRKTkNBWENWK1JXTVEvckJTQ3RzL01wdkpOaGNZT2RISnI3cU03REc1?=
 =?utf-8?B?Sm9aS2ZrbklqYXBtc1JDK01CY3pQVktURDdpNzVxU0k5MzNseVV2eVpqNURs?=
 =?utf-8?B?SFFKa3RKWmliVlpFQWxzK2YvTlE2cWNYdE01RzlzWE05cExGZTk4SmFiYS9R?=
 =?utf-8?B?UlQ5cnAySW9HeFA2M1ZzK2t0Vng5cmVaLzBBZkRGTHB3RFNUY3lCVjZFcjlr?=
 =?utf-8?B?MEk0N0ZKeFhuUnVzbFRYV1Z0c0VidGVtazVzWHhQZFVvMER3Nkh6ZGp1NVN4?=
 =?utf-8?B?OFFvbWVkeHJVSHpEemNCdkYrNlF1YlRLVi9NTnBCVnl2blp6aVZVNkEySkxh?=
 =?utf-8?B?QUtRZk9relFWYXRLYWVpeHg4K2NRNlBwM2g0ek1VMUZBK1E1ZE9Xb0lZTCty?=
 =?utf-8?B?UWZsaVlnNHRJc3FHYjN1V3pqVFBEZkxnZGoxZlFUMmhwcUpMMmt2QS9jcTVR?=
 =?utf-8?B?YkEyRjlTSis5UWJ0QWRuOWFrd20xc1FQUU5mSEZvRVNpRzRlWTc3WlgyWlNM?=
 =?utf-8?B?VWo1ZGtTcHFYL25TbExVcGxKakhPMGRVS21ndGhiU2lreFFRNlBseGt5ZExB?=
 =?utf-8?B?T3IwL0RSbzJvVXYvTytoK1FjSXY1VDBGN25yRGZTTEdiUHRodGlmcU5xTWVJ?=
 =?utf-8?B?S3ltMmJXWndnOURobkl0aEcyOW9SRmtQY2Qyc1JML3RCbW1SVW9NbmJQcDNE?=
 =?utf-8?B?MzY4WjIrc2V6eWRIR0U5TmtURDNzTG45VXY5MktLWU1SUUxoZW1nK0hSVHVH?=
 =?utf-8?B?Q0VYWURpekduc2R4bE1KZ1JpdlFxQ0p1dm5KRU9zQUhXcHJESC9CK0c1dGxZ?=
 =?utf-8?B?YnJaSWN1YW5paGR0cmtIZDZqbFZZOFhMSDVVOHBLN25yOFgyMmtQSjNxN3NZ?=
 =?utf-8?B?NkswS05RcUw1NkVmTmtTR0VXb2ZPR0h3OERmL0Rwd0xzNTFRV0VhMVF6Z1Vw?=
 =?utf-8?B?TnEwck9pRzBncGpWZHhqSWkvM1l5cUo4SVVlOTYrYXdGMHhNbjl1MkRWSTR0?=
 =?utf-8?B?N2V1b3ZBSnNhV2VQRVBjN05VU20wSTFldlVwdVBIUVo5b0Y0OWpnMDQrN2p4?=
 =?utf-8?B?Q0RqVzlUSmxjR25PeEUxZ2doMGZLOXZFM2xuYWpkdUYrV01Mb3FKeFB2NWlv?=
 =?utf-8?B?RWxSOGtYcEV5ZzlyVkZYRXJ2akx4cng0ZnlUUVVyQVhHY1Z5VjdzYWdpblBZ?=
 =?utf-8?B?ZFIwanpnNTFqeGpPMTYzT2lPTjlKZ21ZY0U0NTk0NWJmK29TQ1A5MW04ZkEw?=
 =?utf-8?B?YmtyRjFtdG9YSzNuc1JFTkw5WDViT3BCZXl2OVduUVB6QXdXcGloSC9hZ1ZJ?=
 =?utf-8?B?KzFBUktpQWdhY2NSVGpKWGxSMEE1eTY0aGdpdU9SMWRDWXI1aUJnUFpHbzVq?=
 =?utf-8?B?RGlJRVp1bjRRY2lWRWRxVGtlQ2sxMGJTWG9IZXVnZGdqYU03MWVqYUpMSVRT?=
 =?utf-8?B?bFpRejFFbVhVTFU4YnlrSXAxdVIzRytQUUxwYlN2U0w2T2xCM3IrcHg5NVBz?=
 =?utf-8?B?d21NUFZFZXQ1V0ZTZ3FxcGFxa2hSVzV3TmJPVmhPeSs0SUhLcllZTXplT3I1?=
 =?utf-8?B?RGNOZWVleG5NMEtPT205MTlhZ045VUE0ZnM0MnB4RVVOdGVsVVJVZHowa3NK?=
 =?utf-8?B?QWFtVFUxSVJvY25iOU5IL281dVM2RlJHWmJWR2hsbllLenl5R1BzSlBQUmhE?=
 =?utf-8?Q?3qlACFK3w39c95Qp//ERLAA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b86273e-5c37-4495-4861-08dd5507f7a2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:18:06.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXyYVUeAGp2xCcVAv34glBUdnBtFGSPLbLU5/z5J7HtA7uptMgQdeeN65Sp2syL7mjwNSDGu/NK+LMvpXCv+2AVNKRnuOIhir4qmrWsrreM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB11195

On 2025-02-24 08:20, Dmitry Vyukov wrote:
> If an application registers rseq, and ever switches to another pkey
> protection (such that the rseq becomes inaccessible), then any
> context switch will cause failure in __rseq_handle_notify_resume()
> attempting to read/write struct rseq and/or rseq_cs. Since context
> switches are asynchronous and are outside of the application control
> (not part of the restricted code scope), temporarily switch to
> pkey value that allows access to the 0 (default) PKEY.

This is a good start, but the plan Dave and I discussed went further
than this. Those additions are needed:

1) Add validation at rseq registration that the struct rseq is indeed
    pkey-0 memory (return failure if not).

2) The pkey-0 requirement is only for struct rseq, which we can check
    for at rseq registration, and happens to be the fast path. For struct
    rseq_cs, this is not the same tradeoff: we cannot easily check its
    associated pkey because the rseq_cs pointer is updated by userspace
    when entering a critical section. But the good news is that reading
    the content of struct rseq_cs is *not* a fast-path: it's only done
    when preempting/delivering a signal over a thread which has a
    non-NULL rseq_cs pointer.

    Therefore reading the struct rseq_cs content should be done with
    write_permissive_pkey_val(), giving access to all pkeys.

Thanks,

Mathieu

> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> 
> ---
> Changes in v4:
>   - Added Fixes tag
> 
> Changes in v3:
>   - simplify control flow to always enable access to 0 pkey
> 
> Changes in v2:
>   - fixed typos and reworded the comment
> ---
>   kernel/rseq.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 2cb16091ec0ae..9d9c976d3b78c 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -10,6 +10,7 @@
>   
>   #include <linux/sched.h>
>   #include <linux/uaccess.h>
> +#include <linux/pkeys.h>
>   #include <linux/syscalls.h>
>   #include <linux/rseq.h>
>   #include <linux/types.h>
> @@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>   void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   {
>   	struct task_struct *t = current;
> +	pkey_reg_t saved_pkey;
>   	int ret, sig;
>   
>   	if (unlikely(t->flags & PF_EXITING))
>   		return;
>   
> +	/*
> +	 * Enable access to the default (0) pkey in case the thread has
> +	 * currently disabled access to it and struct rseq/rseq_cs has
> +	 * 0 pkey assigned (the only supported value for now).
> +	 */
> +	saved_pkey = enable_zero_pkey_val();
> +
>   	/*
>   	 * regs is NULL if and only if the caller is in a syscall path.  Skip
>   	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> @@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   	}
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
> +	write_pkey_val(saved_pkey);
>   	return;
>   
>   error:
> +	write_pkey_val(saved_pkey);
>   	sig = ksig ? ksig->sig : 0;
>   	force_sigsegv(sig);
>   }


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

