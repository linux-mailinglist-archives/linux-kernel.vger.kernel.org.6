Return-Path: <linux-kernel+bounces-518308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A836A38D04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEA516AEDE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB623642E;
	Mon, 17 Feb 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="j9oI7UjR"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021094.outbound.protection.outlook.com [40.107.192.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22D13AA5D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822910; cv=fail; b=JBrnM7yxDVGs+3oKUxUC/Hyq+GvtxCNnzkh7b9eEKw9wZ5TH/u1MMHwhgzMf0ECvLnMr/G5uFD9vZ/7SsFY1vcts5xs3wkEZ691WMB/cmkDoZpAfnZgBmzVuSXeEs82ZLfwSCi5bh2179mQZ/hjM07Pne67WwcbEhsmI0Fx3tPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822910; c=relaxed/simple;
	bh=j8GKMuh5lT16HpBffvcqycsIYrq0mfKeCZ0t5xsZYfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDGyb/vuyRHjGnL2TgmskmdqDZyvJj3eKP75OpHPHwN32SsxD7FxRrJ8eTA6s5nD7xMqPEyCGbyZuPR2PQGGRFrdH4Fmw8HvPEFrFLd0e/YnPIux4MyPs3ME/x9KG54+xr6FdLtROZPqJ+m8STBSMVWEfUcA6jWoMe/XKVRufIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=j9oI7UjR; arc=fail smtp.client-ip=40.107.192.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDebeXApVrtQdGjBJcLsNLA8C/nygp9tsj4Ei7MC4fzCN7d3/KhQIykNBx8pUyEs8uEQCXwxXzj3F7NPnWIWkbzkbiC8moDm7mLXQk8IOn88qyMgqPjQM4A0xDOuvgCFI/PEP/lb2V3svTPRdoYW4w3l0Se8SQgRt2ZSq/mSiIF82/nJ+AD3gFgxczDgKJA2m/9K38SJvAjK5XLBiKCFs9GMwSKmnbf3PYkwlS97cq9waqzTX5An4pQbo7cqmcqI3PqQStuKOD9xm6pr2IwLUf/HZ3JXInn78H758Xt2uiqghnmmd2Kd1MrYLbzGz3lY0GR09Rvet/L3JGNT1XDEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SimtTL4h2mGzvCsoPvmjYDc3pe5kCMDROAMglQYvzBI=;
 b=RNmGxPxn23MydZ4LC3ROGv4F2A6Uf1iJbdwk6hLq8/ce7S+46Q5K0bMr17zU6Hr+vgwH6m1Y40dDDvtr0rQw4iIc5vvvBSJUIs/CpVtv+RwqShJblzM6fplN73scXwbYty4bi4wdmpzG5a4hCzi0bsTR4BqmQCxzekxklT7lWrzbzAa7Smdjo4q7FVaWOV4Nj7FzLgDjXoNCsBsexQhlEJ77mUhBp14+/ryzb8SqJqw/Y58Kl09NkCTN3wm3EamKqE8iLf9zpWQoebPovJqza6aYC23XatePeeE2JCbCv9NOrW/qLV8z6nok/7IwwmsFbriSD7k1D/6MIM3ooEtU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SimtTL4h2mGzvCsoPvmjYDc3pe5kCMDROAMglQYvzBI=;
 b=j9oI7UjRqmTqJj2Fx/gtxpOaWyEjA4QN8+swUIrsofDyS83JOQ38PwAqOSrg5XWomeZZdPK2hWukVbaE6hkzdvhfEYUZSL0gotd/50P54P0Va4vjkTcL2JgQHmzoiqNmm8cqUvEaxKjU5s3eTClBY7cPSc4pjcjLm17Rh2tf9oHbYKLh0Ay6uOTiW3Aa0xt/QAXiI08v4rSIZy8T/wcftoAApYpkJ5NQElQWiDXNtryS8C3EcyCm+3s8Kg6wHsByxlzm8ohnm+4Lr58I2yilL3w4+DNqdZJln+6HG0lEGDZwgpvBjC1hJKQC9nZro5FGmQzSERZ440KzwpS8oyxoZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10625.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 20:08:25 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 20:08:25 +0000
Message-ID: <9e866a2c-ef36-4008-a3f9-c476161f64c7@efficios.com>
Date: Mon, 17 Feb 2025 15:08:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] pkeys: add API to switch to permissive pkey register
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0258.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::35) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10625:EE_
X-MS-Office365-Filtering-Correlation-Id: e191cdd2-21c2-4776-e3bf-08dd4f8ed613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWd1Ym45S2MwUENWbXlOTHJWQ3hMdUxTaG16dURUNmxxNUFNU2k4RmI2dHUz?=
 =?utf-8?B?ZkIwbXRqdXVJa3lWeXVWT1lzazFHK1hnY091T2UveEdHeTNlVXF2dVBuZXlW?=
 =?utf-8?B?VEJyYVluMEFsazhtS2Zhc1NXT09QWFd2UHVxRlBWcSt4Tmxndkw3V1B0d3h6?=
 =?utf-8?B?K0hMOHEyenhxb3Z0TGxVZVp4bHpRV0ZrejRyU0p1YmE0NFhtUVZ3b2trTmZW?=
 =?utf-8?B?ZFMwY29rQ1lOeGJVL0FCS0pmeXBITnNuckFwbklGZi83bVZsTlJleklpL21y?=
 =?utf-8?B?VzlPM0dpbjBQN1YvaWNnckZiQXJEclMzUnVlRkJZNGZ0WFVyL0QrQ1padHhP?=
 =?utf-8?B?R1lSeVJOcUZaQVJ3bk1mbytSUTlJMGorMmNMazFWTmo3eTMvaUZKdC9qYWxx?=
 =?utf-8?B?d3JFdnJFdUczVWtQTTdnTmpXSnR0Y3FKR1JBYjR3R084bFIrTGJxRHhiak1Q?=
 =?utf-8?B?dUJRUkdCbCtwTlVXNnJXSnJ4LzVVRFV0QW9CTndGOWFsTTROUE9sVEdValNB?=
 =?utf-8?B?ZGV0NGMwUmZtY21DZUZibUYxcFNjUm9KZkw3UXQ5bVR2V3NzRyttSzZUdi9y?=
 =?utf-8?B?dVRvblYycFNQOFg2eEJXemdpcjdlSlg3dWxvWGJoVSs2WGpGemZBUTRyQi9m?=
 =?utf-8?B?WDdoUVRKc3ZKZkM2cE5oenZtWXBjUlBVSXhUUEFoYXBRbFU0amdvZEV1NjJq?=
 =?utf-8?B?QU5veTZBdnEwdCtBTjZwbm0yaDNwckQ1bEVQTXErYlpXMGloOU9lSllGNWRO?=
 =?utf-8?B?SjNZT3l1TkpSS0tBZFZjZWk4Vmx5L0RiMFdERFp4eVU0MmFpSDFTR3QyaWNN?=
 =?utf-8?B?YmV4M2NPNTRUcDUxUjgrSEdlYmxqZm9Hc3kwbVFRaVMzcFo5YldjVzQvRGRy?=
 =?utf-8?B?cndkL0tvVVlxU1JXLy9mdG9VMk94REQrbm1DbmpTekN5dVVJZk1yOWN4Tyti?=
 =?utf-8?B?Nmd2czNaUFZnV091RGo2SUJ5UnA1bTU2UEcwRVYrdXZ5d3VxMUhTZW5hVjR1?=
 =?utf-8?B?dnJzdnRYcldVMGFBVlhubkxPeVNSOUhGMGJXcHlxRjdPUDZGekJITnlxZmt3?=
 =?utf-8?B?WnpIYldUVE1vQXQraXgvZ3I0Tm8yYWMyQ3RDeXFSOFZpZThlbFM3RE9CTmZL?=
 =?utf-8?B?S0w1WTNjRk52SlY1Rm9uUVhlYnhuZ3JCYmdoQXVhVDNzYUxMMkdVdzRQeS9l?=
 =?utf-8?B?T1doUVd5eXBuekpSTU5MZE5VVU92dHVqOGxPOEpZNERLQ1JKUEdUbHFjejYv?=
 =?utf-8?B?Sy8xZXczSC9wekJqd2htVWUzanUvSC8yVDhzQnVqenZiUm1vNXpnaitDdFN6?=
 =?utf-8?B?dDhFcnY1a3ArZ1UrWkxsOUZmRG1VT0RESVQ0Vm1aeXp5OFN3TW9HUzV2Mlov?=
 =?utf-8?B?VTRScHVqTmhmQjBFa281MDlscFFEQXlxSGJMVnlqaDJBRGFzR0I0UjVDRnFp?=
 =?utf-8?B?T1FCODBnY01HbTZLRExkNUxRR1VUQnN0eXhUOXBKUVRteThMY3ZBRnUzdmN6?=
 =?utf-8?B?RFpwMWxNSndLWU9sZXpPZjlUUEl6VU1jbWgrOFMydGJEa1kzS3d4RDZsL01k?=
 =?utf-8?B?MmRRMVI4dVBaNFRaSjVFYWpVWkRGVUpWL1BEUFZDQVZCcDBsQkpRVUN6akUz?=
 =?utf-8?B?S3l4eWtNQ045azE4V0hSTTRsbnk0WFpMVEhLT0FSUDNqV290eWlRZnVPQmFV?=
 =?utf-8?B?R0JodXkrREFrM0lWL1pST3pOeUFhc2J5dDhSMXBmaEtQNmhhbldjSDVGUUF1?=
 =?utf-8?B?ZFRzZm4xYUQvS2QweWRQRG9VWmdPb3JJdFVOam9hVVU3ZWVJYlBHNlJEcVdk?=
 =?utf-8?B?NXQ1UlUwTEtlK21TWUZOQ29ycXZtdklmRGs4ZkxoV1R3aXN4MHcxcFNzM3ZH?=
 =?utf-8?Q?g3KQLP6Kv0Fui?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjNMM25uWmNJS25JWkhsZnFZL3g1dmVVaTlDK3RvcnhoeExDc0J5amF1ekpv?=
 =?utf-8?B?emtZWlRpQ2RtbXJrSmk3Q1RGTndRZUtLVk1uOUdDMGlxZ2pjVm41WURwcHNP?=
 =?utf-8?B?ZTFnaVRGaXEvOGQwdDRSVUdpSWdwdUh2TEFpR1huOXYxV1F3UjdxNDZqSjJO?=
 =?utf-8?B?MVB3UFRQLzNqWCtzM1hLd3NCa0lzSzZUa3I0VGpsZml0elN1QWxGTFNzYkJi?=
 =?utf-8?B?RW9oTkFnZ1llSzF2SzBXa0ZoM1BqUEVzQ2MzNHhtYVk4aVF0SGJxcWpqZXYv?=
 =?utf-8?B?MFZiMlphOHZnblV0bmRVRXlTNmZrLzMwa3BZWWRlOW5EZDJrQ3UyVXc5ZVN0?=
 =?utf-8?B?d3B5M0lLQzlWYmFhZ2tzQWlVRWJxVElSUDBsZ01KdlliU3hLWE1PSlAzcDJ4?=
 =?utf-8?B?UUpQdE9DRkRXeTBvTUtFWXh2bzIwUEVtYllpMlJ6R25EMHBleEd0ZXlqcVd6?=
 =?utf-8?B?Tm4zR2dSSlQzd1NjSlUrazZ6NXdSMUVsSWtUb0MxaFNuMTNvQkNmRXJTWHNY?=
 =?utf-8?B?UnFWVTZlQnZDYVlzNkIrSjdVRlMxMnFTVVBlZDZUc2lkbHNhL000ODlLV090?=
 =?utf-8?B?Mjk0YzRSTSt4RUd3S0VZZ00xZnRaUlBGQVJhSm5DbmVqSDE5TTF1R05aSkJV?=
 =?utf-8?B?YWluekpuMmVOSEpEczI3Y1h3UDlCbmxIK08rYVFkK0Z6L3F4RDgvZFZ5VytN?=
 =?utf-8?B?QTNoNFFNQ2pmajg1b0s4a1czc3RIYTJiZTJlQnVyZ1hmSldibnVLVHgwOVRB?=
 =?utf-8?B?TFFnUnA1ZlpkWUpUamlGeXczOXlqOVFDdThTR2VoQ2Fib1c3eTd0TkRZdlRq?=
 =?utf-8?B?TndKQUpDblg1Ui83TFBQRjFrMElTR2FUdlEzbmRzYU9mVkVpd1RBZDNBU1Nk?=
 =?utf-8?B?S1hLMm9ZT1pxdnM5VHVjSGlOYXllZ0RDNmJWZHYwOWhsR3VQbXFRU0JvRVB6?=
 =?utf-8?B?ckswVTdUckdhbGYzL09pVUNBS3pxTkNtZUtGZG9DVW5SYXV1REJmU3NkelRU?=
 =?utf-8?B?NUl4YUJYR2U1N1NaNVRKUXpZZXFQZXIwRG94YkZZTktKZkpEeFZJWDZrUCta?=
 =?utf-8?B?ZVVCQUNzbEF2Z2RqdU1KVzhUUWVUZWhNYVZScU5tdFkyWTV2a0JRaThUd212?=
 =?utf-8?B?Tkd1bjg1MTNSOHlyV1gzUmVPTWFvYVFkRHh0OWIxa3QzTjhuK1NQU0dEOE54?=
 =?utf-8?B?Vys2ZHU4REp3TnU0RytYY2pWZlVYT1RGblZBMVloazFUR2pUYUJDRjNJY01k?=
 =?utf-8?B?SkZhN1BaQmdSaDQyd0hRVHRYK0tqd1Vwb3pLUUFVMWk5SHlrcWl0cHp5WnFj?=
 =?utf-8?B?Ny9TK0RnTXUzV0lwWWUwbitoNjNtQUpOZEx6a1REZCtXV0c4NTUrNlRpQVV6?=
 =?utf-8?B?aTNaTFZoenNBVldIOWNMQ2lKTm45dnRsQy9sSDkzcGo4MDA2a1ZsZ3grV3Vz?=
 =?utf-8?B?MUltb2lhT1l0OXcwVUdZWnpkZm10cjhldjNNQVRQbHJiMXZTTjFueXE0VHVk?=
 =?utf-8?B?RGxzQ1p0UHlBRWF0ZFo5aEozejJuN0xxUVg2RXM0djZ6NHA3dDBvbnhscGY2?=
 =?utf-8?B?TTVpMVkvbUZiSkY3V1E2WWRxOEgrNWl0WWdib0czZXlRbVh1K3ZxWncyWUl2?=
 =?utf-8?B?STltSUJtS04yYks3SFNDUk91dXljWFlvUUY0citrVnNzYnVEWDBISGt4V09v?=
 =?utf-8?B?bVk2NzNPTXhmeWQ3cExYNFN0OGVXNTJkSjczNTA1WjFyYXFtcUxzYVk3SkNN?=
 =?utf-8?B?dVdEZUR2aVVId3ZRcDRlNzN6L216eU53QkN2NXNXZnA3ZisvdWlYekFEYUhL?=
 =?utf-8?B?cnlvOXluTTg1ckRnQXdmUmUycllXcWI1WGlraEhoTnRSREoyY28yQWxKc1BI?=
 =?utf-8?B?VHhacTRoTFg5aVYrbm9ONktUR3JDSy9qeXc2dzB3emUrd1RFVzhaNXF4T01M?=
 =?utf-8?B?T0xBZTIzVGhVd0JNQ05NeUlEMFA2OTdiL0pjckpvenlmajZla0sxcXJXQ1hu?=
 =?utf-8?B?dThPcG9Cd0RNbGdBN3EvaXBua1lscTBOK3duZFlRTStiSXcrbjJsK21mUDhG?=
 =?utf-8?B?Q1UydjJ5SFdFUXByV0xUZWNJYWNidTg3Q0ZXbFRpY3kwaVozYm5SZTVBdHZh?=
 =?utf-8?B?MVRTL0IwUXh1bGZ5Tnk4RGVvYjB5aW1mRkFBaDN2dlBLdlM5cHdBTDhtUngv?=
 =?utf-8?Q?mECBa+9bsBABvNZeZ6MsHu0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e191cdd2-21c2-4776-e3bf-08dd4f8ed613
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 20:08:25.3115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgKeThyWXXq2jxrQP+MOtM/MIX6nLzdot8wklT9YtFOiNlnDy963A5CZvbYOHGNqHTEdta5ejZC+BDx0GdZ7+WiHNFc7Dq98Ub1eeHEDVf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10625

On 2025-02-17 06:07, Dmitry Vyukov wrote:
> The API allows to switch to permissive pkey register that allows accesses
> to all PKEYs. This is functionality is already used in x86 signal delivery,
> and will be needed for rseq.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

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
> ---
>   arch/x86/Kconfig             |  1 +
>   arch/x86/include/asm/pkeys.h | 14 ++++++++++++++
>   arch/x86/include/asm/pkru.h  | 10 +++++++---
>   include/linux/pkeys.h        | 22 ++++++++++++++++++++++
>   mm/Kconfig                   |  2 ++
>   5 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index be2c311f5118d..43af2840d098f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1881,6 +1881,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
>   	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
>   	select ARCH_USES_HIGH_VMA_FLAGS
>   	select ARCH_HAS_PKEYS
> +	select ARCH_HAS_PERMISSIVE_PKEY
>   	help
>   	  Memory Protection Keys provides a mechanism for enforcing
>   	  page-based protections, but without requiring modification of the
> diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
> index 2e6c04d8a45b4..1cacfe184b9d4 100644
> --- a/arch/x86/include/asm/pkeys.h
> +++ b/arch/x86/include/asm/pkeys.h
> @@ -2,6 +2,8 @@
>   #ifndef _ASM_X86_PKEYS_H
>   #define _ASM_X86_PKEYS_H
>   
> +#include "pkru.h"
> +
>   /*
>    * If more than 16 keys are ever supported, a thorough audit
>    * will be necessary to ensure that the types that store key
> @@ -123,4 +125,16 @@ static inline int vma_pkey(struct vm_area_struct *vma)
>   	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
>   }
>   
> +typedef u32 pkey_reg_t;
> +
> +static inline pkey_reg_t switch_to_permissive_pkey_reg(void)
> +{
> +	return write_pkru(0);
> +}
> +
> +static inline void write_pkey_reg(pkey_reg_t val)
> +{
> +	write_pkru(val);
> +}
> +
>   #endif /*_ASM_X86_PKEYS_H */
> diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
> index 74f0a2d34ffdd..b9bf9b7f2753b 100644
> --- a/arch/x86/include/asm/pkru.h
> +++ b/arch/x86/include/asm/pkru.h
> @@ -39,16 +39,20 @@ static inline u32 read_pkru(void)
>   	return 0;
>   }
>   
> -static inline void write_pkru(u32 pkru)
> +static inline u32 write_pkru(u32 pkru)
>   {
> +	u32 old_pkru;
> +
>   	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
> -		return;
> +		return 0;
>   	/*
>   	 * WRPKRU is relatively expensive compared to RDPKRU.
>   	 * Avoid WRPKRU when it would not change the value.
>   	 */
> -	if (pkru != rdpkru())
> +	old_pkru = rdpkru();
> +	if (pkru != old_pkru)
>   		wrpkru(pkru);
> +	return old_pkru;
>   }
>   
>   static inline void pkru_write_default(void)
> diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> index 86be8bf27b41b..d94a0ae7a784b 100644
> --- a/include/linux/pkeys.h
> +++ b/include/linux/pkeys.h
> @@ -48,4 +48,26 @@ static inline bool arch_pkeys_enabled(void)
>   
>   #endif /* ! CONFIG_ARCH_HAS_PKEYS */
>   
> +#ifndef CONFIG_ARCH_HAS_PERMISSIVE_PKEY
> +
> +/*
> + * Common name for value of the register that controls access to PKEYs
> + * (called differently on different arches: PKRU, POR, AMR).
> + */
> +typedef int pkey_reg_t;
> +
> +/*
> + * Sets PKEY access register to the most permissive value that allows
> + * accesses to all PKEYs. Returns the current value of PKEY register.
> + * Code should generally arrange switching back to the old value
> + * using write_pkey_reg(old_value).
> + */
> +static inline pkey_reg_t switch_to_permissive_pkey_reg(void)
> +{
> +	return 0;
> +}
> +
> +static inline void write_pkey_reg(pkey_reg_t val) {}
> +#endif /* ! CONFIG_ARCH_HAS_PERMISSIVE_PKEY */
> +
>   #endif /* _LINUX_PKEYS_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 1b501db064172..9e874f7713a2b 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1147,6 +1147,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
>   	bool
>   config ARCH_HAS_PKEYS
>   	bool
> +config ARCH_HAS_PERMISSIVE_PKEY
> +	bool
>   
>   config ARCH_USES_PG_ARCH_2
>   	bool


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

