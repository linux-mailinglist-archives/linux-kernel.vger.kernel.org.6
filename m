Return-Path: <linux-kernel+bounces-564840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C52A65BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801FB189C95B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14D1B043E;
	Mon, 17 Mar 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="G0c5w5P1"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020113.outbound.protection.outlook.com [52.101.85.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F91A38E3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234236; cv=fail; b=PTgfSKIBXy9qewe4JsYjwOft4749SDgUo1SJdSEHDcnaABLI1/oi26OxzU4+LnRqp0IYjguybxwVQ04WOAJXhdNSyiJ3NKlt8rrVggBXdIy1svSFcgE9ruV00kLHzks82ix58WZwno/i2tGHHXK368dZzSeRn/NfucrBbftxal4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234236; c=relaxed/simple;
	bh=RimO/f5jgUiEd3u0g6mg8vNQ+0zL4KZM4L7uLUPsPBQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PP+9D/d0gkCVwJ2KNa02ttWOEIG51GG7RkvfxJGFMUxrra49jeuKdbUCZN7pOWGV3hSUOxDI98cZg1i828DQXcjqq+vEcG7NmUqY/Xn4qkgcP8gISUPil/FPOPW6EjOgUI31OJ98wvV/P39PM32my8Aqktb50fSCyahQ89quK5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=G0c5w5P1; arc=fail smtp.client-ip=52.101.85.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hy/5QEwaXDKcMMYxpOghGo2ZmzSX3n5SLjc+anBJi3RxPm1HiQtJyJ0MnD8TW8xkK37uusOXEWU1kV0KjdKTXAlxlr1q94DQCM0bkhjLuslCGceKRaG0uMaVZ1HJr6Bquzlo+6PzzjfeB/CSupi+R/CaeG95G9i5u22cLWOz0YV7qN5UC7N3Vh/ZTIeMx7m6nAvBM5rVG7slF4KD0VIJKK9Mv7f/lrvjxu3/GaLOpc3JqIuPM3MGqBrJkenlmez5Jubj0on1UVbclUqp6v8dJsR9igH98M/akvxMdr6Dem9oVy28RM2HEjavctb58+UUPJLYdrhb4/pd4s8JG3sW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZy6Xn6V8oUuUiCOk02r4zsnOuRdvuB5aRmenU9MbXY=;
 b=NXIm2YtR6Ja2PyS6MRej5AQxy+Ag7aju4nkh1SS8wjrC/uLop0gG214Vl75GeY/zf3fquEZshOhP03RfXQOhDAbyqyCIzYz3g5JOCaF9mXRs9W1WaQnijuPIUtPLUr5kSwue63Rohf0xRe53BQPS8xnPaLtpnMwNPhcVOj+BRu0+9t6NM8K4u9IUwx7fFLAW7wOPTY1r5f7ozDuywzgg3Zl0BEDjMxyKkYejTYYNLetKiSo5/BkMFSYw7vZMAP+uTVbSAQLz7cb4ffMZMeqilaWlTzp/9hDhpCY9CdazVs09wDwF6mMawUFcPPB/t4MdNZU0ik4aKqvPdEI7S9gAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZy6Xn6V8oUuUiCOk02r4zsnOuRdvuB5aRmenU9MbXY=;
 b=G0c5w5P1DRDUnuCMdB1XqJS0AymMpsYLwdxPqPkis3z/deVINFyUAZti9nJAm5bg/pTS5kC6L+nLXK8QKMo9E9dGx6a6kXicgM7HujAK31AXaVX9hLvSQMUdMDl5MZYeHBuzUC3h6sqkd7vDMSIRGl4d3PYclla6HhX/AV0XB6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6586.prod.exchangelabs.com (2603:10b6:510:95::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 17:57:09 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:57:09 +0000
Message-ID: <2745296a-9d39-4f77-8eb4-735920d35375@os.amperecomputing.com>
Date: Mon, 17 Mar 2025 10:57:04 -0700
User-Agent: Mozilla Thunderbird
From: Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [v3 PATCH 4/6] arm64: mm: support large block mapping when
 rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
 <20250304222018.615808-5-yang@os.amperecomputing.com>
 <f745ab79-55e7-406a-a3cb-9f85fa461444@arm.com>
Content-Language: en-US
In-Reply-To: <f745ab79-55e7-406a-a3cb-9f85fa461444@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:930:49::24) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc36e01-f32f-429c-8f0e-08dd657d22b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0hXcUpnbFdEQ3hDYzRJMnlITGgzTVR5L1VsSjhSWUJaOW12dDlFU3JGb1pJ?=
 =?utf-8?B?SnRtRDVXOU1MVzdVekw3blZaMmpvTVZWVFVWWmxjWFRKQkZJYzJQM0F0alov?=
 =?utf-8?B?RytDQWV4bUh0OU9XMnVmZXlqZFZXQzNEU29nQWJFbXF0MU5HeEl6RUIvN25X?=
 =?utf-8?B?bmdnT0JMRW9obC9lWGx6bm5LZU51dnk0c0tabGdVb29OQUFYSTNDL3U5MWp3?=
 =?utf-8?B?VkkyTFJLQWpTODdmVUtDVHdmM1JBV2MybjNwQnhUWUF2aWl2TXpUQ0hhQTlS?=
 =?utf-8?B?QlVqZk1hVFhlWTRLWXhrNTJaRlAxeXVZSjhzYmZUU2pXK01vNlU5RVFQMzF3?=
 =?utf-8?B?TXBwUU5NOFBQTjR4SC9qc25yem5NVjVHeExYTldoUUxFVzJ0MGhkR1JhWHVG?=
 =?utf-8?B?UjZhVXBXcC92MXY3RkpRWTVMTTBrYUdFUmFwVnMvNmdGQzVzaEZSdGxLNFZK?=
 =?utf-8?B?NExNL0doQStCbmRCclZSK0I0MnZ0cVdUVS9IRHVpR2E3OU9QcVc4MGVtOXRl?=
 =?utf-8?B?SU9KY0poRGNYZnNxM29DTmMyc3NBSkNUbGQ3TUxLeG43TWFKa3p0RTVCR0p5?=
 =?utf-8?B?OHNWS1gvSGl6NWNZQnVFemFZdWlWaFZCY0MrUXN6YmNRL1g0eVFSQ3l5SVhp?=
 =?utf-8?B?T0NWWHZvWVUwVW10cFJYQkZoSjBPeFIzVEVkR09UcnA2L1FRKzRHZDQxQ2s2?=
 =?utf-8?B?aitwUlNhSitVNHJPL2VPRVYvWEsvUDBwMzR5Z1hIY3JaUGo3WkFzZmc4YkNy?=
 =?utf-8?B?ZXhHRkRacDcvQ09SR3RKV3ZZbXpPeWt0QllIbDMwR1huSWg0Ni9WZzhGWGNK?=
 =?utf-8?B?ZWZJUmRKQkdGeVk1UHB1YzhtSlRzSFVVVmg0M0I5Tm85ZnJ1T08zak52YmZw?=
 =?utf-8?B?MXY3L0lYOXNrNkVWdnhFNFdNNGdmU2gzK2JTdnR1Uis5eStwWkxrQ2ViR2pB?=
 =?utf-8?B?UnB0dXJ4ZWlpOW8xaTc0YzdxQm5CK1RhNG5mT1VSanNhR3I1OVZHcFBBQ2hx?=
 =?utf-8?B?c2U5Ly9STTFwU2NmMWc3UHBPWlc5MnBOYTRRQUpSQzA2cDBsRlhQcGMwL0l2?=
 =?utf-8?B?MXl1VUwwWFdTMzJPYkRERFJMWDZaQW9XNzNUR0x3TXJFZmd0N2VSc2wvTTEz?=
 =?utf-8?B?RGZ3Q29zWWZ1ZjVxaTBtWmMremJ2VmZKREpHUWJwOGlZUy9LV2dWSWZ5b0dN?=
 =?utf-8?B?QnN4aGFnbytsSnZiNEZ0RnZrODc1QUN1MmZhcnYydEVSTGxzVlZnRlloTXYy?=
 =?utf-8?B?ZTI3VG5ZWmpxNGpGSWZDM2FkT0xaTDBLaGhZMml6blpGaG5UdWV3K1ZWdFd3?=
 =?utf-8?B?aEZ3ZW9RbmFoZjhtL2pjOGptemEvb0xqYnpncWxGbi9jSFl6MXlacGthZzdi?=
 =?utf-8?B?YmxZRWo3RUpMMUZlcWZkSi9GdFJONkxPajZIUzJlc0c0N1RDaHZ0RzJxQ080?=
 =?utf-8?B?cjgyZnQwbGg2eW9rdEhoZ0NDQmhyTDk5ZzFQSGpsbTBGcUFYeUNMMmZaSnMz?=
 =?utf-8?B?NXdsN3YxSFplcGhKaFQrMDZFZTc2NFM4MWhjVGovNGwzNS92eFBwS3pBdFpv?=
 =?utf-8?B?bFBvS054T3M4dksyNkJhd2xjR0JCRFZUdnpFVGQ4MWljOWV2THo4c2N6aE5a?=
 =?utf-8?B?ZzhPTkdod2Y4MzNzeDBtNndmbzdFeHNEN1JuVWdqT1E5RUZxdEtFbnFOVWE1?=
 =?utf-8?B?cWVZbzRSK1RVZWtxVUlyMjI3MkRDM3pvNmpnYTZ3ZmIyaWxLUXlEejMwMWoy?=
 =?utf-8?B?VFIyUGZ3YWpHZ20rQ2xIZTBIQTZHTSs5TUU0bnlRQmtVbERLQ3g3TjBwQmJF?=
 =?utf-8?B?ajlJakJEckpGRWdHbDNnc2thNWx5bkdJcXR6K09qL2Z3UFNKTTF5ZFpFZU5y?=
 =?utf-8?Q?He9a1KkmEhhVq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHNjdUdJMkFxekg1cmdoUklIZVlBbzdESDBma3VhZXNKYi9JaVdYZGNKdHo3?=
 =?utf-8?B?dWVHQXFJY0I3RFlvbHEvWGNMSEVRU21ENVZtQ3dGbUtwY2QwZ0FncHJ4T3B4?=
 =?utf-8?B?Vllmdk9tTVJWa1JSQ2NCVTViWWk5eVQ3NXJmTWxjNnJQQkxPNWhEYmRqVTBX?=
 =?utf-8?B?N1UvSWNpQzB4RERFTjU2SWV3WlRYZHp2d0M3WVZRYVBoakxuMUk3NjNocVBQ?=
 =?utf-8?B?MGNmU3lDSFpmTlNQdkQ3UHFVYWRoSnAxOEN5eHpLSUlvYmhKYzAreEc2SkRL?=
 =?utf-8?B?bFlUUDJHbjBNeXM0ZndjQU9iblgxSk9GNW4vcmFNeitScVQ0U1pmOTkrQUlo?=
 =?utf-8?B?NDJuSjl6OFg3TVRrYmNkRGl4ODU2Y1BjMDBEYnZhVjlHMEsrZWJtYWQwNzk1?=
 =?utf-8?B?RjZXQXpPaUs5S2lVUG55TnVlMlB1VHI3QVlGSXdwK2s4VlprY2hvRjl1WlFn?=
 =?utf-8?B?ZWdwcFpPTnphTTdvUEg1ZllOMDJaalc5N1pBVHJVOVIvOFlYUXBmZ1o2U0l3?=
 =?utf-8?B?MHZLckVoUlFZZHZRTjlHK2M4YWI1NFA0MVFKRTlqdUJBL0J1UXBEMlhybGI3?=
 =?utf-8?B?N3FOdXVaczRmRVFFR3dROC94TUw2SldQNitRUEVHV09lMFJXa1haZDlQWWpz?=
 =?utf-8?B?Z2o0djhEanhZS2phQzVkMnlKOElKN2xCSk9LdzJWc1MyenBVSW1nUW9oK3VZ?=
 =?utf-8?B?ZUFxWDA3aWJlQzVIYy9TYlVvdmh4S0F1eTFYTXpUY09JL2t3N29FUHZKQUtR?=
 =?utf-8?B?L3p2UFZzV3pvY1NYOG5TeEY4RzFJdUw2WjlCUjNrWXBJbW5SZWNSbkd2SzVa?=
 =?utf-8?B?cFZNbzJSSTlWUUxoc3RQczNNcE5ZRHlwT1BsU0h4NHJNd2sxQ2lrU0VQWVJ0?=
 =?utf-8?B?bDI1SEwzaEVnMXNTa2p2c2IydGR2Q2k4RGxuZmFGenZMQmYzNkJqRnEzeVdS?=
 =?utf-8?B?R244Um00VlptWVltbVoxM2JIWlNjV1lFMGVvMXBvVEE3K1hDK242ZWxHSVhQ?=
 =?utf-8?B?RHBvbHYzeXduNWpySTVJb0kzOUZHTlRvM0FhNXlrQlVWbks0Y2VEdFNsWkxQ?=
 =?utf-8?B?VlozbjhmM09pR3J4Q0lGVG5oYXlhbzNqeitjTW1tWTVBS2tjL05hdlBiK1Fi?=
 =?utf-8?B?WmZVdjFSMEFTY25iZUpJdWFVTVg3UEtWTUxHWTUzVmV4enZycTMzNnU0dCtB?=
 =?utf-8?B?S1B3V01jQjlpbHNRVjBOUFM5bGNZTXlhVVpDM3NLUmthWWIxR2srTFlGNmlh?=
 =?utf-8?B?clhiaU5ZaUZ2b0FibjI1Y1RBY0lHV0ROWWNDcSs2eTFRd2tiUkdYUXV5ZmVh?=
 =?utf-8?B?b2g2eWExQkNuS1cvaHkwYU1yZUZWbUVCQWtGQTYvaE1tM05YSWREMEJieFBr?=
 =?utf-8?B?R0Z6L21DTk1HRzdMY002NTh3VDN6Q0VoVTgyUmUyR3Z2cURja2NyeTZOaXFk?=
 =?utf-8?B?ZHZMczlVNDZib2tmSHlKeSt2M294UmZrTFJ4V0lFcHBsMWkrSlpBQm5QZEFt?=
 =?utf-8?B?US9LWDJ5enY5dnNPUTU2YjVmSitpNG51cVhDTUZVZ1lWRUh4NW50d3dhVGZZ?=
 =?utf-8?B?VXNodXJieFVqcXZyUXYxdkdjNklkYWNHanpWbXN5ODNRZWprMEk1bEhRK2ta?=
 =?utf-8?B?b3d6OFlXRVlRN1dDQm9YZ09vUUpKWUR6amx2dHR1TkVvNjBpTkZiZVYyWFZT?=
 =?utf-8?B?VXNwd29yZnBzNUZPaGxWdW02MS9JMS94ZGI4QU5qUWpYclZsa3JNS001cGQv?=
 =?utf-8?B?SVpRQitTVVF1c1crTW5sOU1BVTNaSiszcGtzWWt4ZjNDbkZTZ0lXT1FaNEF4?=
 =?utf-8?B?dmVidy9VQ24zMlpQT216TXZybVY4N29UUXREeHRUWFcvc2lodjRaekp6ZnVw?=
 =?utf-8?B?OEpyR2gybDB0V1dSVnNKT2lmQjIvazMxTDQvR0NhOGZHUUJPZnFqWlpnVlVk?=
 =?utf-8?B?cnQ0RHhmMjYweUZ5VlJmQndZbWpkMi95bVU0bVd2QU0rQTAyZjZLYzlPVEhL?=
 =?utf-8?B?eThBdkpUWTY4bEg2SWplaUNYZ1JnQXJCMjYyWU8rVlNodm5QOGhkQVgvbmxZ?=
 =?utf-8?B?WGkvcjI4cnhBUFFDQzRrU3lLYzdRRG10eU82b0llbmpxeXlzeVdpSlhHekhv?=
 =?utf-8?B?eS8zdk1zeXdyc2RMODVuRyswUzdzenA3MWEzTWE4bmNiZExtc2MydFc4c3Iv?=
 =?utf-8?Q?wGcpefCU5CjD6blgG2eAFY8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc36e01-f32f-429c-8f0e-08dd657d22b3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:57:08.9577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WbPZKGD3wCriaEVlJh7T/lGG7BwXQd8P8Z24sgcYvSZRS186c7sgMVximYwiEcF62c/bW17PmIFRBN6s4iQM+yX4Cqf9Pqw/LQxcJV+foQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6586



On 3/14/25 6:29 AM, Ryan Roberts wrote:
> On 04/03/2025 22:19, Yang Shi wrote:
>> When rodata=full is specified, kernel linear mapping has to be mapped at
>> PTE level since large page table can't be split due to break-before-make
>> rule on ARM64.
>>
>> This resulted in a couple of problems:
>>    - performance degradation
>>    - more TLB pressure
>>    - memory waste for kernel page table
>>
>> With FEAT_BBM level 2 support, splitting large block page table to
>> smaller ones doesn't need to make the page table entry invalid anymore.
>> This allows kernel split large block mapping on the fly.
>>
>> Add kernel page table split support and use large block mapping by
>> default when FEAT_BBM level 2 is supported for rodata=full.  When
>> changing permissions for kernel linear mapping, the page table will be
>> split to PTE level.
>>
>> The machine without FEAT_BBM level 2 will fallback to have kernel linear
>> mapping PTE-mapped when rodata=full.
>>
>> With this we saw significant performance boost with some benchmarks and
>> much less memory consumption on my AmpereOne machine (192 cores, 1P) with
>> 256GB memory.
>>
>> * Memory use after boot
>> Before:
>> MemTotal:       258988984 kB
>> MemFree:        254821700 kB
>>
>> After:
>> MemTotal:       259505132 kB
>> MemFree:        255410264 kB
>>
>> Around 500MB more memory are free to use.  The larger the machine, the
>> more memory saved.
>>
>> * Memcached
>> We saw performance degradation when running Memcached benchmark with
>> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
>> With this patchset we saw ops/sec is increased by around 3.5%, P99
>> latency is reduced by around 9.6%.
>> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
>> MPKI is reduced by 28.5%.
>>
>> The benchmark data is now on par with rodata=on too.
>>
>> * Disk encryption (dm-crypt) benchmark
>> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
>> encryption (by dm-crypt).
>> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>>      --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>>      --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>>      --name=iops-test-job --eta-newline=1 --size 100G
>>
>> The IOPS is increased by 90% - 150% (the variance is high, but the worst
>> number of good case is around 90% more than the best number of bad case).
>> The bandwidth is increased and the avg clat is reduced proportionally.
>>
>> * Sequential file read
>> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
>> The bandwidth is increased by 150%.
>>
>> Signed-off-by: Yang Shi<yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h |  10 ++
>>   arch/arm64/include/asm/mmu.h        |   1 +
>>   arch/arm64/include/asm/pgtable.h    |   7 +-
>>   arch/arm64/kernel/cpufeature.c      |   2 +-
>>   arch/arm64/mm/mmu.c                 | 169 +++++++++++++++++++++++++++-
>>   arch/arm64/mm/pageattr.c            |  35 +++++-
>>   6 files changed, 211 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 108ef3fbbc00..e24edc32b0bd 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -871,6 +871,16 @@ static inline bool system_supports_bbml2_noabort(void)
>>   	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
>>   }
>>   
>> +bool cpu_has_bbml2_noabort(unsigned int cpu_midr);
>> +/*
>> + * Called at early boot stage on boot CPU before cpu info and cpu feature
>> + * are ready.
>> + */
>> +static inline bool bbml2_noabort_available(void)
>> +{
>> +	return cpu_has_bbml2_noabort(read_cpuid_id());
> You'll want to incorporate the IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT) and
> arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2) checks from
> Miko's new series to avoid block mappings when BBML2 is disabled. (that second
> check will change a bit based on Maz's feedback against Miko's v3).

Sure

> Hopefully we can factor out into a common helper that is used by Miko's stuff too?

I think checking the kernel config and 
arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2) can be 
consolidated into a helper?

>> +}
>> +
>>   int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>>   bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>>   
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 662471cfc536..d658a33df266 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -71,6 +71,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>>   			       pgprot_t prot, bool page_mappings_only);
>>   extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>>   extern void mark_linear_text_alias_ro(void);
>> +extern int split_linear_mapping(unsigned long start, unsigned long end);
>>   
>>   /*
>>    * This check is triggered during the early boot before the cpufeature
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 0b2a2ad1b9e8..ed2fc1dcf7ae 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -749,7 +749,7 @@ static inline bool in_swapper_pgdir(void *addr)
>>   	        ((unsigned long)swapper_pg_dir & PAGE_MASK);
>>   }
>>   
>> -static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>> +static inline void __set_pmd_nosync(pmd_t *pmdp, pmd_t pmd)
>>   {
>>   #ifdef __PAGETABLE_PMD_FOLDED
>>   	if (in_swapper_pgdir(pmdp)) {
>> @@ -759,6 +759,11 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>   #endif /* __PAGETABLE_PMD_FOLDED */
>>   
>>   	WRITE_ONCE(*pmdp, pmd);
>> +}
>> +
>> +static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>> +{
>> +	__set_pmd_nosync(pmdp, pmd);
>>   
>>   	if (pmd_valid(pmd)) {
>>   		dsb(ishst);
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index bf3df8407ca3..d39637d5aeab 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2176,7 +2176,7 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>>   	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>>   }
>>   
>> -static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
>> +bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
>>   {
>>   	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
>>   	 * as possible. This list is therefore an allow-list of known-good
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index dccf0877285b..ad0f1cc55e3a 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -45,6 +45,7 @@
>>   #define NO_BLOCK_MAPPINGS	BIT(0)
>>   #define NO_CONT_MAPPINGS	BIT(1)
>>   #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>> +#define SPLIT_MAPPINGS		BIT(3)
>>   
>>   u64 kimage_voffset __ro_after_init;
>>   EXPORT_SYMBOL(kimage_voffset);
>> @@ -166,6 +167,73 @@ static void init_clear_pgtable(void *table)
>>   	dsb(ishst);
>>   }
>>   
>> +static int split_pmd(pmd_t *pmdp, pmd_t pmdval,
>> +		     phys_addr_t (*pgtable_alloc)(int))
>> +{
>> +	unsigned long pfn;
>> +	pgprot_t prot;
>> +	phys_addr_t pte_phys;
>> +	pte_t *ptep;
>> +
>> +	if (!pmd_leaf(pmdval))
>> +		return 0;
>> +
>> +	pfn = pmd_pfn(pmdval);
>> +	prot = pmd_pgprot(pmdval);
>> +
>> +	pte_phys = pgtable_alloc(PAGE_SHIFT);
>> +	if (!pte_phys)
>> +		return -ENOMEM;
>> +
>> +	ptep = (pte_t *)phys_to_virt(pte_phys);
>> +	init_clear_pgtable(ptep);
> No need for this, you're about to fill the table with ptes so clearing it is a
> waste of time.

OK

>> +	prot = __pgprot(pgprot_val(prot) | PTE_TYPE_PAGE);
> This happen to work for D64 pgtables because of the way the bits are arranged.
> But it won't work for D128 (when we get there). We are in the process of
> cleaning up the code base to make it D128 ready. So let's fix this now:
>
> 	prot = __pgprot(pgprot_val(prot) & ~PMD_TYPE_MASK) | PTE_TYPE_PAGE);
>
> nit: I'd move this up, next to the "prot = pmd_pgprot(pmdval);" line.

OK

>> +	for (int i = 0; i < PTRS_PER_PTE; i++, ptep++)
>> +		__set_pte_nosync(ptep, pfn_pte(pfn + i, prot));
> nit: you're incrementing ptep but adding i to pfn. Why not just increment pfn too?

Sure, pfn++ works too.

>> +
>> +	dsb(ishst);
>> +
>> +	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(pte_phys),
>> +		__pgprot(PMD_TYPE_TABLE)));
> You're missing some required pgprot flags and it would be better to follow what
> alloc_init_cont_pte() does in general. Something like:
>
> 	pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
> 	if (flags & NO_EXEC_MAPPINGS)
> 		pmdval |= PMD_TABLE_PXN;
> 	__pmd_populate(pmdp, pte_phys, pmdval);

Sure

>> +
>> +	return 0;
>> +}
>> +
>> +static int split_pud(pud_t *pudp, pud_t pudval,
>> +		     phys_addr_t (*pgtable_alloc)(int))
> All the same comments for split_pmd() apply here too.
>
>> +{
>> +	unsigned long pfn;
>> +	pgprot_t prot;
>> +	pmd_t *pmdp;
>> +	phys_addr_t pmd_phys;
>> +	unsigned int step;
>> +
>> +	if (!pud_leaf(pudval))
>> +		return 0;
>> +
>> +	pfn = pud_pfn(pudval);
>> +	prot = pud_pgprot(pudval);
>> +	step = PMD_SIZE >> PAGE_SHIFT;
>> +
>> +	pmd_phys = pgtable_alloc(PMD_SHIFT);
>> +	if (!pmd_phys)
>> +		return -ENOMEM;
>> +
>> +	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
>> +	init_clear_pgtable(pmdp);
>> +	for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
>> +		__set_pmd_nosync(pmdp, pfn_pmd(pfn, prot));
>> +		pfn += step;
>> +	}
>> +
>> +	dsb(ishst);
>> +
>> +	set_pud(pudp, pfn_pud(__phys_to_pfn(pmd_phys),
>> +		__pgprot(PUD_TYPE_TABLE)));
>> +
>> +	return 0;
>> +}
>> +
>>   static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>>   		     phys_addr_t phys, pgprot_t prot)
>>   {
>> @@ -251,12 +319,21 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>>   {
>>   	unsigned long next;
>>   	int ret = 0;
>> +	bool split = flags & SPLIT_MAPPINGS;
>>   
>>   	do {
>>   		pmd_t old_pmd = READ_ONCE(*pmdp);
>>   
>>   		next = pmd_addr_end(addr, end);
>>   
>> +		if (split) {
> I think this should be:
>
> 		if (flags & SPLIT_MAPPINGS &&
> 		    pmd_leaf(old_pmd) &&
> 		    next < addr + PMD_SIZE) {
>
> So we only attempt a split if its a leaf and the leaf is not fully contained by
> the range. Your current code is always splitting even if the block mapping is
> fully contained which seems a waste. And if the pmd is not a leaf (either not
> present or a table) split_pmd will currently do nothing and return 0, so there
> is no opportunity to install mappings or visit the ptes.

Yes, it splits the PMD even though the block mapping is fully contained. 
It is because the current user (change_memory_common()) just manipulates 
the page permission on PAGE_SIZE granularity IIRC. But I agree with you 
not splitting when it is fully contained is better and more flexible. We 
don't have to change the code if change_memory_common() is enhanced to 
handle contiguous pages. However the related code would be untested due 
to no usecase at the moment.

If the PMD is non-leaf it will do nothing because this patch doesn't 
handle CONT_PTE, if the PMD is table it means it already points to a PTE 
so we don't need do anything. The later patch handles CONT_PTE.

>> +			ret = split_pmd(pmdp, old_pmd, pgtable_alloc);
> But... do we need the special split_pmd() and split_pud() functions at all?
> Can't we just allocate a new table here, then let the existing code populate it,
> then replace the block mapping with the table mapping? Same goes for huge puds.
> If you take this approach, I think a lot of the code below will significantly
> simplify.

Actually I thought about this. The existing code populates page table in 
the range of size@addr, if the size is, for example, pud size, the 
existing code can populate the page table as you suggested. But as I 
mentioned above change_memory_common() is called on PAGE_SIZE 
granularity, If we just allocate a page table then let the existing code 
populate it, we will end up populating just one PMD and PTE entry for 
the specified address. For example, we a module is loaded, its text 
segment may just use one page, so kernel just need change the permission 
for that page.

So we still need populate other PMD entries and PTE entries other than 
the specified address. That would need the most code in split_pud() and 
split_pmd().

To make your suggestion work I think we can set addr and end used by the 
walker to the start boundary and end boundary of PUD (P4D doesn't 
support block mapping yet) respectively. For example:

@@ -441,8 +441,14 @@ static void __create_pgd_mapping_locked(pgd_t 
*pgdir, phys_addr_t phys,
                 return;

         phys &= PAGE_MASK;
-       addr = virt & PAGE_MASK;
-       end = PAGE_ALIGN(virt + size);
+       if (split) {
+               addr = virt & PAGE_MASK;
+               end = PAGE_ALIGN(virt + size);
+       else {
+               addr = start_pud_boundary;
+               end = end_pud_boundary;
+               phys = __pa(start_boundary);
+       }

         do {
                 next = pgd_addr_end(addr, end);

But we may need to add a dedicated parameter for the start boundary of 
page table if we want to do split and permission change in one pass as 
you suggested below since we need to know which PTE permission need to 
be changed. However this may make detecting fully contained range 
harder, the range passed in from caller needs to be preserved so that we 
can know what PUD or PMD permission need to be changed. CONT mappings 
will make it more complicated.

So it sounds like we need much more parameters. We may need put all the 
parameters into a struct, for example, something like below off the top 
of my head:

struct walk_param {
     unsigned long start;
     unsigned long end;
     unsigned long addr;
     unsigned long orig_start;
     unsigned long orig_end;
     pgprot_t clear_prot;
     pgprot_t set_prot;
     pgprot_t prot;
}

So I'm not sure whether the code can be significantly simplified or not.

>> +			if (ret)
>> +				break;
>> +
>> +			continue;
>> +		}
>> +
>>   		/* try section mapping first */
>>   		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
>>   		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> You'll want to modify this last bit to avoid setting up a block mapping if we
> are trying to split?
>
> 		    (flags & (NO_BLOCK_MAPPINGS | SPLIT_MAPPINGS) == 0) {

The specified address can't have block mapping, but the surrounding 
address can have. For example, when splitting a PUD, the PMD containing 
the specified address will be table, but all other 511 PMDs still can be 
block mappings.

> Or perhaps it's an error to call this without NO_BLOCK_MAPPINGS if
> SPLIT_MAPPINGS is specified? Or perhaps we don't even need SPLIT_MAPPINGS, and
> NO_BLOCK_MAPPINGS means we will split if we find any block mappings? (similarly
> for NO_CONT_MAPPINGS)?

As I said above we still can have block mappings, so using 
NO_BLOCK_MAPPINGS may cause some confusion?

>> @@ -292,11 +369,19 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>>   	int ret = 0;
>>   	pud_t pud = READ_ONCE(*pudp);
>>   	pmd_t *pmdp;
>> +	bool split = flags & SPLIT_MAPPINGS;
>>   
>>   	/*
>>   	 * Check for initial section mappings in the pgd/pud.
>>   	 */
>>   	BUG_ON(pud_sect(pud));
>> +
>> +	if (split) {
>> +		BUG_ON(pud_none(pud));
>> +		pmdp = pmd_offset(pudp, addr);
>> +		goto split_pgtable;
>> +	}
>> +
>>   	if (pud_none(pud)) {
>>   		pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
>>   		phys_addr_t pmd_phys;
>> @@ -316,6 +401,7 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>>   		pmdp = pmd_set_fixmap_offset(pudp, addr);
>>   	}
>>   
>> +split_pgtable:
>>   	do {
>>   		pgprot_t __prot = prot;
>>   
>> @@ -334,7 +420,8 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>>   		phys += next - addr;
>>   	} while (addr = next, addr != end);
>>   
>> -	pmd_clear_fixmap();
>> +	if (!split)
>> +		pmd_clear_fixmap();
>>   
>>   	return ret;
>>   }
>> @@ -348,6 +435,13 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>   	int ret = 0;
>>   	p4d_t p4d = READ_ONCE(*p4dp);
>>   	pud_t *pudp;
>> +	bool split = flags & SPLIT_MAPPINGS;
>> +
>> +	if (split) {
>> +		BUG_ON(p4d_none(p4d));
>> +		pudp = pud_offset(p4dp, addr);
>> +		goto split_pgtable;
>> +	}
>>   
>>   	if (p4d_none(p4d)) {
>>   		p4dval_t p4dval = P4D_TYPE_TABLE | P4D_TABLE_UXN | P4D_TABLE_AF;
>> @@ -368,11 +462,25 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>   		pudp = pud_set_fixmap_offset(p4dp, addr);
>>   	}
>>   
>> +split_pgtable:
>>   	do {
>>   		pud_t old_pud = READ_ONCE(*pudp);
>>   
>>   		next = pud_addr_end(addr, end);
>>   
>> +		if (split) {
>> +			ret = split_pud(pudp, old_pud, pgtable_alloc);
>> +			if (ret)
>> +				break;
>> +
>> +			ret = alloc_init_cont_pmd(pudp, addr, next, phys, prot,
>> +						  pgtable_alloc, flags);
>> +			if (ret)
>> +				break;
>> +
>> +			continue;
>> +		}
>> +
>>   		/*
>>   		 * For 4K granule only, attempt to put down a 1GB block
>>   		 */
>> @@ -399,7 +507,8 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>   		phys += next - addr;
>>   	} while (pudp++, addr = next, addr != end);
>>   
>> -	pud_clear_fixmap();
>> +	if (!split)
>> +		pud_clear_fixmap();
>>   
>>   	return ret;
>>   }
>> @@ -413,6 +522,13 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>   	int ret = 0;
>>   	pgd_t pgd = READ_ONCE(*pgdp);
>>   	p4d_t *p4dp;
>> +	bool split = flags & SPLIT_MAPPINGS;
>> +
>> +	if (split) {
>> +		BUG_ON(pgd_none(pgd));
>> +		p4dp = p4d_offset(pgdp, addr);
>> +		goto split_pgtable;
>> +	}
>>   
>>   	if (pgd_none(pgd)) {
>>   		pgdval_t pgdval = PGD_TYPE_TABLE | PGD_TABLE_UXN | PGD_TABLE_AF;
>> @@ -433,6 +549,7 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>   		p4dp = p4d_set_fixmap_offset(pgdp, addr);
>>   	}
>>   
>> +split_pgtable:
>>   	do {
>>   		p4d_t old_p4d = READ_ONCE(*p4dp);
>>   
>> @@ -449,7 +566,8 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>   		phys += next - addr;
>>   	} while (p4dp++, addr = next, addr != end);
>>   
>> -	p4d_clear_fixmap();
>> +	if (!split)
>> +		p4d_clear_fixmap();
>>   
>>   	return ret;
>>   }
>> @@ -546,6 +664,23 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
>>   	return pa;
>>   }
>>   
>> +int split_linear_mapping(unsigned long start, unsigned long end)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!system_supports_bbml2_noabort())
>> +		return 0;
>> +
>> +	mmap_write_lock(&init_mm);
>> +	ret = __create_pgd_mapping_locked(init_mm.pgd, virt_to_phys((void *)start),
>> +					  start, (end - start), __pgprot(0),
>> +					  __pgd_pgtable_alloc, SPLIT_MAPPINGS);
>> +	mmap_write_unlock(&init_mm);
>> +	flush_tlb_kernel_range(start, end);
>> +
>> +	return ret;
>> +}
>> +
>>   /*
>>    * This function can only be used to modify existing table entries,
>>    * without allocating new levels of table. Note that this permits the
>> @@ -665,6 +800,24 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>>   
>>   #endif /* CONFIG_KFENCE */
>>   
>> +static inline bool force_pte_mapping(void)
>> +{
>> +	/*
>> +	 * Can't use cpufeature API to determine whether BBML2 supported
>> +	 * or not since cpufeature have not been finalized yet.
>> +	 *
>> +	 * Checking the boot CPU only for now.  If the boot CPU has
>> +	 * BBML2, paint linear mapping with block mapping.  If it turns
>> +	 * out the secondary CPUs don't support BBML2 once cpufeature is
>> +	 * fininalized, the linear mapping will be repainted with PTE
>> +	 * mapping.
>> +	 */
>> +	return (rodata_full && !bbml2_noabort_available()) ||
>> +		debug_pagealloc_enabled() ||
>> +		arm64_kfence_can_set_direct_map() ||
>> +		is_realm_world();
>> +}
>> +
>>   static void __init map_mem(pgd_t *pgdp)
>>   {
>>   	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>> @@ -690,9 +843,12 @@ static void __init map_mem(pgd_t *pgdp)
>>   
>>   	early_kfence_pool = arm64_kfence_alloc_pool();
>>   
>> -	if (can_set_direct_map())
>> +	if (force_pte_mapping())
>>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>   
>> +	if (rodata_full)
>> +		flags |= NO_CONT_MAPPINGS;
>> +
>>   	/*
>>   	 * Take care not to create a writable alias for the
>>   	 * read-only text and rodata sections of the kernel image.
>> @@ -1388,9 +1544,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>   
>>   	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>   
>> -	if (can_set_direct_map())
>> +	if (force_pte_mapping())
>>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>   
>> +	if (rodata_full)
>> +		flags |= NO_CONT_MAPPINGS;
>> +
>>   	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>>   			     size, params->pgprot, __pgd_pgtable_alloc,
>>   			     flags);
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 39fd1f7ff02a..5d42d87ea7e1 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/vmalloc.h>
>>   
>>   #include <asm/cacheflush.h>
>> +#include <asm/mmu.h>
>>   #include <asm/pgtable-prot.h>
>>   #include <asm/set_memory.h>
>>   #include <asm/tlbflush.h>
>> @@ -80,8 +81,9 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	unsigned long start = addr;
>>   	unsigned long size = PAGE_SIZE * numpages;
>>   	unsigned long end = start + size;
>> +	unsigned long l_start;
>>   	struct vm_struct *area;
>> -	int i;
>> +	int i, ret;
>>   
>>   	if (!PAGE_ALIGNED(addr)) {
>>   		start &= PAGE_MASK;
>> @@ -118,7 +120,12 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>   			    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>   		for (i = 0; i < area->nr_pages; i++) {
>> -			__change_memory_common((u64)page_address(area->pages[i]),
>> +			l_start = (u64)page_address(area->pages[i]);
>> +			ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
> This isn't quite aligned with how I was thinking about it. You still have 2
> passes here; one to split the range to base pages, then another to modify the
> permissions.
>
> I was thinking we could use the table walker in mmu.c to achieve 2 benefits:
>
>    - Do both operations in a single pass (a bit like how calling
> update_mapping_prot() will update the protections on an existing mapping, and
> the table walker will split when it comes across a huge page)
>
>    - Only split when needed; if the whole huge page is contained within the
> range, then there is no need to split in the first place.
>
> We could then split vmalloc regions for free using this infrastructure too.
>
> Although there is a wrinkle that the mmu.c table walker only accepts a pgprot
> and can't currently handle a set_mask/clear_mask. I guess that could be added,
> but it starts to get a bit busy. I think this generic infra would be useful
> though. What do you think?

Yes, we need to add another pgprot parameter (maybe more) to tell the 
walker what is going to be set and what is going to be cleared. I agree 
the generic infra is useful. Would you prefer implement it in this 
patchset or in a separate following patchset?

Thanks,
Yang

> [...]
>
> Thanks,
> Ryan
>


