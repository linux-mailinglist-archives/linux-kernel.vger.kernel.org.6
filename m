Return-Path: <linux-kernel+bounces-539497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A50CA4A525
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9BA7A3F79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732251D8E12;
	Fri, 28 Feb 2025 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VveVhFpr"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021074.outbound.protection.outlook.com [40.107.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB323F38A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778689; cv=fail; b=Sog/uTlmeacs2XQ5lBXU/dsIWRnIW+erPpOBPjUmT1/dPClU/NvGsHDxaUjIdrXLqsv0+uGvSifZiVXZoEznUQ4VI9XwlTYrZz374OdFUWUpsDNQxr4TjOYz8nKvnfQW8Dz76DYKnVAkV2c6GTzRGNb8aVyiHaND2wm7l5LBZOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778689; c=relaxed/simple;
	bh=3b8NLwtW06PekU1n4y9uPPTM53P/TdvpAyYgUa5sego=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBOwO3gbrZ7bZWO2nHJ6u4EkSCgk/mIXYhcPE2ba1M6qaU+KmiNv6yKTmwRURGtsJ/bKJaYExFDgpTMkdDOn7Hax4KjOtFIe8MhsNeb0hJDD/7xWXrVd7+OV/DialyLgb+0DziIUPM8jw3AER3BaLMBW1jyo2hWDz365OqRsPEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VveVhFpr; arc=fail smtp.client-ip=40.107.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARf1gBkyxP+Fcv1XhC7Pa2D9oWFzCF6pZsAE55JGP5ZKcB/v6OqC2ewTuthawvxxUnqREvF6DuTBPAxgC7jDEpEVUro80B9sejn6XhHVAgs+9Q2V4BOaeYmIsMjkvr6I3wCUAjW5VE9+0oRu9aeq5ie9TrPhxSZ3oSQdb9utu2nAcvrrTulaq6fJBeyM2CiX7nLYMnFtxjOG2xFBbubX9STTKM1wW9PyF2jhEJWv/rGnlr1BxCeCrGI+NBMHlEuBuvGWEJQX2MWgO4Elzr9wNZW71q4CH2PtdUNruALbcNUsBhHIDrN7YhpLwhSV0nNos3kQmzpGfkOXPL6qK+MqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3cItW8sdTdqxDfCVIgWST880iZPCO+9I3CpqU04BhM=;
 b=Xses9q5KU10w3JzYxgN78JwQmTMIMjV1b03QBSgZvN6I5P3Cx0R9s//kP5+g+/0YUq28N2UcQQnnM1DyR8StT6yidp0u0g0V6/DVShOUtvwpcn2Ii/2io0UWBz7WxY5DL3aBozqh9p4M2J9p5GDjcOrhsNbs3ribnFbqlsYBDRdoHW8lsfDpVuzXxYoVQDsRRtMeit9BiMkrSSAZ0TcayNyCI3xNC7TuK/UGJiii871HyFoP01B+4Qv4FnMp6fQes7Ythw1eVSqBarC83EwCNwNRAPhmtYnmKapWFf6rPPzn3yETPJytd+Iim9zfLDWLqsiMA5qJz2e7aiAUuKPfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3cItW8sdTdqxDfCVIgWST880iZPCO+9I3CpqU04BhM=;
 b=VveVhFprlpJf7VEeJ3plHWofsyPFGKLHm1Sdrl7ol1t2DAILpvJYjxqzMKI3y8PKnovDKr776D2QBnWGdQ7YCjWx04RUVevAHc+j90uKnZ5iIwHATVyWlG/bjEPFkdoDu5kaafYZY3UWVoMBhSGrnflpikGOTHZoaGQDmlLm3dJJZcg1zilUrG4sY0PWLm30pRP11FZZPCjSk9W1UyFKIWTUXCFU8hd4+YLeJHFKDYiC0DgESiqFYxpD0+pxc8aOPoAkJGgTa3+h3kBB9yy9ukPdn/E4xFTb5RHGBgbCuvDw/ZUjJzQFPrQcB+iO66ZpxTv653Mlhigply+/2CrLsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5363.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:46::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 21:38:03 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 21:38:03 +0000
Message-ID: <331ed532-eb98-4665-9d1b-b6b8bf46e396@efficios.com>
Date: Fri, 28 Feb 2025 16:38:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: David Hildenbrand <david@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <029759d4-f7b2-4ec6-b5d0-7c8a1c0fbd80@redhat.com>
 <Z8HPN5sAgInM4dN2@google.com>
 <e110e00f-9032-43ec-808e-45a912065fb0@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <e110e00f-9032-43ec-808e-45a912065fb0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd35d0b-6059-481d-b659-08dd58402e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWRDWDFUd2RmWWtERUdvZDlVdzViaUtQTi9kN2xKRFZFdk5GclJjRzhyWUtM?=
 =?utf-8?B?STA2d0Y5d0piNHp0c2l6ZlFhRUVSWDAvS1NEVnVzSHQzYUd5YkN2N0RYQVBT?=
 =?utf-8?B?anA0NXpuM24rVWp3V1E1dG5EUlBrUkFpc0lDSVhaMVkzRGdQS0FJVXVwbEZz?=
 =?utf-8?B?cUpWb0E0SVpWZGVVUkxKL2pnNlVyS2phSEhBZVhrZzN1cnlucG9udmMyWUYw?=
 =?utf-8?B?WDhud3h6a0JPdlczWHlNNDRkQTJpQWFjVFkxcnhaMDRvd1ZNTHZmc3ozcm5h?=
 =?utf-8?B?L013Z3dYd3M1bGlheDJmV0c4dEIwWTIzWkhzdlAxVkJuQ0JBTTZuK3kyeTF5?=
 =?utf-8?B?WitKTWwya3NYUE5NbWFrdzkyTEQ4STJvOEZiclNVTWt0WEFzYzIxcU95MnRa?=
 =?utf-8?B?VXo3ZkNXSVdqL3VEbmNqVTN3N2lDVEpLVWN6WHI0UE5jdlpia3Y0d0RrdWZ5?=
 =?utf-8?B?RGtjTmdIMVRxSG5tSWJOaDlwMU9SWUJoMEJzSHdYRm1YUzBTTnN1MHBidy9G?=
 =?utf-8?B?RlVkR0pqRitsbmwrRTBlbVhRVzNTa0g2cVMxcHVxSElrWDVYSUlXZklMdk1V?=
 =?utf-8?B?VkVhblZ6b3p3K2x4bnJGTjlFRFREMkNQMUpyWXg3WGNlVmp2YXUvTitva1Z1?=
 =?utf-8?B?Y2oxdEFVZ1dWSTFoQmJDOWhoOGlUaVZWb2NDeXlrRi96RzZXZnZ6WDRYUjVz?=
 =?utf-8?B?UHNxRHdDeVRjbWlsbm9EdG5wdW9rUitpam9BSXJXNzdOTVEvemZ4akV6czNu?=
 =?utf-8?B?cVBtbzhLTTlqY3R6d3F5SFVVQkIyM2JHcEN0QUM0OTJjZjFzNS9Gc2xTazdR?=
 =?utf-8?B?azN6cUI0dDY5dXg4Nmw2U25WcWluRnlGcTAwbVZnREtzRXo3VUh6S3AzRnpj?=
 =?utf-8?B?aC9UV01qaWNRWlJGY2tIM1BjL0R6UzJVMFN2SVA3QTd4VWVpQXJOc0tMZFZP?=
 =?utf-8?B?WnNNS01qU0tFWTg3cEFHUmZmSWtaV1EzdHRYVEhIOXZuYjBGSmpabFo5TUVz?=
 =?utf-8?B?ei9KcTdtN1p3UW9QaE0wYi8ycFZJZDV4YWgyZWVWemJUSUhqbmk4R0JqU09I?=
 =?utf-8?B?Z20wNmhPWU96MGFGVFU0UjNwTi9ZTjk1Y3diSndHMWdLVDVITCtjMVh0NWx3?=
 =?utf-8?B?K0kzNmFyNm96b2hQcTFVMjlHblJYUEdpclY0MkVwL0JWQTB1OENBSUo3d0pX?=
 =?utf-8?B?MDN6ODVZMzRreko4bnBCYVpIR3RCL1U1eDhFSE5sZTU3RCtycWJqWnMxRlo3?=
 =?utf-8?B?akU0SndtZm9neUlUUjZ4UFovVzQyM1pOV3lFcXRvU21Gd3VWU3VzWWxYT1gx?=
 =?utf-8?B?NXJ3WHV6dVorRisvRE1lWEhZUzBIZmwwWjN6RW5UblVZem5EcFFCaHI5R00v?=
 =?utf-8?B?RnZuMWsvMzZtb29HZ2QrTHd0ekN3czhhVmR5Mkh2anEvS0FBdTdWdHFZWXlx?=
 =?utf-8?B?WjVKaXpkV3hyVTFkZHk0VGRwT3lUbDhaVUZ4ZnNJQXpINHJuNjY0TDQxbVF1?=
 =?utf-8?B?ZzlvTHQ5Q2JDT3NTL0NyY1gyTjB2N2lkbmdFYzkvbUI1RWRTMkNwWDF0ZlRL?=
 =?utf-8?B?Lzd2OHhDWjJmdGJ1L2l1VSt0MEkzVU5xQjZRcVppMTdlUlFpZmpMQzVCdHlT?=
 =?utf-8?B?bkhFeldDeDVJVFYxcFVpeHZnNGtmOW9NY0xKT1RKb1hiZGJ0TE1ZYW41aXBt?=
 =?utf-8?B?MU5Wb09ncjRnS0s5YW1wNFpLWVBJdWViN0VINjBjeTJnd3Z2dG5qSWpRZzJG?=
 =?utf-8?Q?S/2jcC8kY/pFD9eJs6oL7uX2UJgcMIwTN2gsG0W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXJoVXU0R2lQakFGdEs4aVNHSXo0TWdicXJqeXE2Q0g2cE5vcHZkVFJrOW5q?=
 =?utf-8?B?bXZsek5TbTZVTERveWRHSnB6bmsvVWFMdE5oMkE1RW1wdnJpemRMUlBBaHI4?=
 =?utf-8?B?WUlyYXFQQTdOWEFSS1FmUXZTMmJ5SE1CZE9zbjBtWEVwcW81c1ZBbE84czg0?=
 =?utf-8?B?S3EwTEYwc2I5R3UxNkdVVHpSd1huYUkxNXVtUlJobXIrVDAxcU04ZTF0OGJ2?=
 =?utf-8?B?bUNSY1c5UlBMd05wU296dEl1NTJudm9tdG9Hb2VaWmJMYThrQTJUQVoyVDBW?=
 =?utf-8?B?d090dDJwdEU0cWVqN1BQQ2JMaGxQendoRDhObzN5cnd3ZVk0SVZvbGx4aW1B?=
 =?utf-8?B?VGFJeGJjWE0yRHhnNVU1YXUzZk0rbnVoaXJROG05WndCVHNFQ1dLMVl0ckh0?=
 =?utf-8?B?Znh2Tk9HODFMb09UVVlmYlVQNVNQZzE3T0plQ1lLZnBhNzFpaTErZ2d6N3Bp?=
 =?utf-8?B?TUx2ZmxaK0xPZjFkVm9pd3Z0dWFIeldVOWdRM2JVV04wODVyN2c4aHd2YkdE?=
 =?utf-8?B?b0s0LytPQXV0aUdFa0VUdFBBVlpubVdpcEVpNHlYVU1QTER1ZzNkSHQ1V3FT?=
 =?utf-8?B?OGV3MU96djBUZ2IyRThZL0NlaVo4b1R0TlNOY0l2NWtMZXUxSHV0N09SRXhH?=
 =?utf-8?B?WlhMeDdtREFCc2pZZTBOMDQ1bDhpREsycVZjbFFrZFRNMGVJdFNpL2NGNWs3?=
 =?utf-8?B?eXFaa0ZzWk81TWVVYlYwaE45SkNVQXIyVVcvT1ZrVnVLRXc4RHNIc0sxMnpT?=
 =?utf-8?B?c0U3ZFVMT09sdFFwWjFkNzMzRmNKdy81RERjR0g2VCt6U3JTcFFkV2xzTGV0?=
 =?utf-8?B?aEo0emRzQjlCZTVicEJSUmlsT05VdkpBcDNaaFFMVklmVTdWTVVvdE5LdHkz?=
 =?utf-8?B?K2RMd2RtZG5nNmN5dmtwU2VBeXpGc1dDSVpEekt1WC9OTEFCbnlteFovdVVt?=
 =?utf-8?B?UVRkYlRRa3BzU3I5dEh1bU9XdVRiSU9aallKbXhycXJzQ0JUeTdaYm1uQmVI?=
 =?utf-8?B?YlF4TVIxSmhaRTBCeXpnem1PMU5XMG9RQ01KM3JkREJlalZDVzN4WTJZaTBE?=
 =?utf-8?B?SkJmTVBlNzk0ZnQyclF0TkpkZzIxVjFFTlF5a2o4NnRTYlIwbmFMM0tBMnla?=
 =?utf-8?B?VXBVSjM4OXBYTm5HZC9VMjFZVVBFbHJ5b3FqNk5zRGkyQWVDcDN1MDU1UWlP?=
 =?utf-8?B?NHg1em1mc2x5UFlzc0dVUzJqNUJRckJQQkxINGJBNHVlOGxObnUvOUpIa3hU?=
 =?utf-8?B?YnNsdVNDUVA5MVQyNHQ3Q3NCUG9qY0lnUXluL291cmRDVDV4MlFiL2tQWEkv?=
 =?utf-8?B?Q1NjQ2NnSWJaTDBxSDU1NHR5WTlxdTg4bVdsUE95MGJmaGdjaUNLTHlkTEJt?=
 =?utf-8?B?UXpKTFoyb3J6enQ4S21FRS9UaGMvb0sxY1lPRHpVZWsyVERKVmxkS0dsTnpn?=
 =?utf-8?B?UzFid1ZHZlNiQlc4dGZKS2NEakIvNWxHZlFyNmtzc1g5UnpUTk14WnJQQUVr?=
 =?utf-8?B?SGpwY2xvWkpJLzJJYVZHWVA0MEJyeTE1ZHBwOUdZR2JyVkEwRWI1bHVDY3NT?=
 =?utf-8?B?MWNxSWVKMFlPWGN0L1c5S0xIRnJJYTBSL0kya0xWWkRHbEd2S3ROSk1Rd2Jj?=
 =?utf-8?B?MEMzSGQ3QkhCS1FoeGFUV3VENWF5K1EvWmpPUmZRNlU5MUdWTGVDR2lidWlN?=
 =?utf-8?B?Y0xBRzExaHhkRTNDdUIrVHNJS2tkRnpPcmROUi9BKzJIclEwc3NMMVNsYllk?=
 =?utf-8?B?RGQ5QU45YXhzUGJ2R3JGNWtiSnR3ZGlHY0hRdlc3bURUelFTOXJMUkxQc3hI?=
 =?utf-8?B?SkY2WjR2cWNxWW9wUVl3T1d5WlF2WDlicHA4R2R6cVlueENBdW41dWtiWWJl?=
 =?utf-8?B?WjFvMjgrQ3RsMWM3YXhQWnZGMFhmK2NEWUJ6bEZsTDNxZkJOa3FvLzlxSlh3?=
 =?utf-8?B?c08vMlZSeEd1T2FndjY0UktWb2VrYVBxTGlISDN3QUxoSmhub0tPWFdnaFVK?=
 =?utf-8?B?SzhBT1FxaWpwNTljdzdoUER2OHNiVHlBQmdLT3hUWGpFbGxrUkNDOUZyckRt?=
 =?utf-8?B?WGFUTDhwZjQ0VHM1UlR6eWNlTlN2emNjWWxPbjE0akhkSUpOYlNqeE9nR2Zy?=
 =?utf-8?B?WlJLRXdONEZCZjU0M2MrWnBnWEs1alUxR0FwOGI2Q29hR0xyUC9xNVRrajFK?=
 =?utf-8?Q?dvK0JOkUhjid0rPgbm6LZlU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd35d0b-6059-481d-b659-08dd58402e41
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 21:38:03.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahIxBGSc4D97vG3+50oxRYb7Jk2Ukjpus+GnEj4HTWlhAVa52itZhv5HePhhqwIT/4mAFuwTs+oCz1Qjdow3gcs8FAFa2GfS8/WvKNSshCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5363

On 2025-02-28 10:10, David Hildenbrand wrote:
[...]
> For example, QEMU will mark all guest memory is mergeable using MADV, to 
> limit the deduplicaton to guest RAM only.
> 

On a related note, I think the madvise(2) documentation is inaccurate.

It states:

        MADV_MERGEABLE (since Linux 2.6.32)
               Enable  Kernel Samepage Merging (KSM) for the pages in the range
               specified by addr and length. [...]

AFAIU, based on code review of ksm_madvise(), this is not strictly true.

The KSM implementation enables KSM for pages in the entire vma containing the range.
So if it so happens that two mmap areas with identical protection flags are merged,
both will be considered mergeable by KSM as soon as at least one page from any of
those areas is made mergeable.

This does not appear to be an issue in qemu because guard pages with different
protection are placed between distinct mappings, which should prevent combining
the vmas.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

