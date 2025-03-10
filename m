Return-Path: <linux-kernel+bounces-554588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF33AA59A36
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DF93A9297
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D522D4FA;
	Mon, 10 Mar 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pv2moFoA"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020073.outbound.protection.outlook.com [52.101.189.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978951E519
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621310; cv=fail; b=VLLdeWW3IITp2UxALBOFkSDkkLBWBRQ2gVjrBNLKVQ3UuwOaZap9TeApfHprq1OoYlPUQ5zcKvyWt/5dBCWN8KFLHGwRUvzkF7OKln84QSPnzO8FmPp0m0xd26DSecQIdCrs6HW4XekRGLkL9ZJAihtEsI8IZwQDKHQT6ShTux4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621310; c=relaxed/simple;
	bh=wCu/Cc/dH3nt0/RIMBPHWH6PvDKZSo+8j8DWwp1/dyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oJ5Oj2lSBTPC33n0+4sWhqVzgDtjIOo0x+IzOcGvxBT7l2I20PEvH8R+qCC6bTHtwks/J1mCataaWWo+5cYDTdwzevWoG+mudn6a3jB/KkwX3XiFf3G2IuKvoUmk82933qUry+Tw0HBA9iItQWuYNTJDHoOHSfh2juXPvcs+q4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pv2moFoA; arc=fail smtp.client-ip=52.101.189.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qq2Gyq+wBVSRjbpeVn+Bi9RKvh16E7aw013hp19fjuJuTXL37OxRxQhGCELF4qcEz+3wiTkkYMybc9Ss09vfnD1/ScOAqNNHJMe0Ee9oMAXTkYlejzMxawIzei+in2+IweQksT23cQsvkgRkpbpaompBBqt5oP0xbKjUCqYjazUNgVdDISX8saLPOnSZYC/pBO5pDWR6cGeUHHObhKL+BXyOK7ALNrZUb0jDQ5o2RfP3KmS47UgWFQljbsrv1LRm+Zcet8/kz1DNTc+Vkz+pm51xkAjBuvzFtXhjMELcE6xRu537IS4XyMu11vYMxBuKyu7od95gn/lwMOwkXsGuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNgeoTFVWFBJJEluv9GE+0jcWxOazNYGsPnP638PRTg=;
 b=A2djBS93wy5uRIeIGyh/t4CFpycbbSlzkvcJPMd8steJetq40LXxfhGns7zheVBn5Rxlg8ftZgN6s9xTiFyoxI2N7salwi/nMHVwE+UcOdvMVl5lK8RgiOOcHlx3q2nggzPLstg72Ov5Szu3TPLHaZHmGnb0ta527/CQM+GHp5WFwcVs0Qb9k5WBI0RuQXPM/uKuQTyubvHSXJki/mCvKDYK6dECsRhzNvb/3m1eszdhHovypCXPsBXWTQ7e4nNj37aipH6deYFIx4XknHRT7jIse54p9jZH5HL0DVWpuIESfNiAvma8/eXysU/scXW9pkmdDs0BKE1eeqouXAvWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNgeoTFVWFBJJEluv9GE+0jcWxOazNYGsPnP638PRTg=;
 b=pv2moFoARDSpdZogKxSo3CjqrRmSEq7b1yeb8rPaeaLXjxV6uG8PHwLCVu7xQAYMiMDIoYC8/nTdDn2J2oZOg1VBj26+DDP5asEDzSMurOHk9teEP5mUC6kZI5zujv4GUM/1E+cnFIWztQkQhnciIWbGjQo+Z1B02NhqskdXoIvG+rZxN+0lgGK5GegzleiHB/1Mz5VF8+8NIfoz7TR7VCUuPFRYLPgBKn2VI+STfbI6r/NIfDntShGcy5l8ZaFB6c5HFtw43kgVI/I2mJnzl4AmTolHu1GbhFK+DQmJZVY/dUEfcOl+vYHDyxlObD5VIeBvbqCb86MppqsXCzpwPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YQBPR0101MB6198.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 15:41:44 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:41:44 +0000
Message-ID: <3c45a374-804f-4a9f-8885-5ef1bfc8676f@efficios.com>
Date: Mon, 10 Mar 2025 11:41:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] selftests/rseq: Add test for rseq+pkeys
To: Dmitry Vyukov <dvyukov@google.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740664852.git.dvyukov@google.com>
 <9a98ed5d655e9a0d66027779c75c3ba67601e1bf.1740664852.git.dvyukov@google.com>
 <26b779d4-0478-4926-ba5c-e71449e92020@efficios.com>
 <CACT4Y+aT9z8qjY-66wiOR0Wiep2BoTN7QJYxj-QK_KRXLmgiLA@mail.gmail.com>
 <c3781655-b667-4477-9337-445d8250fb4e@efficios.com>
 <CACT4Y+YpnCfm6xjdwnUJ-3ND_YPNdAqReffueF1dWGfxmJLWEQ@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+YpnCfm6xjdwnUJ-3ND_YPNdAqReffueF1dWGfxmJLWEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YQBPR0101MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d2f7d4-afd5-4104-6948-08dd5fea0f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Umx2eUJXOThqSkREVUtBUDU1UEhaYVpISVZlOThEcXRPQWU4WUdobThKeHB1?=
 =?utf-8?B?NDMzKzJ0bUgxbDFwUEpNSDZ4dzFNNXBIM3A2V0cvVTI2RlgvNU9KMmpsUUpu?=
 =?utf-8?B?ZVVJdjZ5SWRlV2FLN0RLVzJWTjg2RHBuWTJmWlpZb0ZoMU5DanVaRThFcUIz?=
 =?utf-8?B?TUZwMjM1Q1drMVRXMWp0WmlyL2U5aWFjZFhvVGpxRk5Kb3U0aFVLSlNISStY?=
 =?utf-8?B?V2pHNjd6NEFUNGhqUjVJSWt5T3RGRWNjRmVGVkRzVjUxMUgxSGxPREo2VkRC?=
 =?utf-8?B?RjdJUXg5VzlaWExramhnb09FZEZ6YWV1eExLREtjcUVsNkFQVm5aYkZLYnkw?=
 =?utf-8?B?Rmx6TXV0ZGd6NHR4dkFPOUh1RU15c3FlZHB5bFg0Ym9YSURmY1EzWXdvNW9v?=
 =?utf-8?B?OTR0V3ViVXJvZUcrNkdyZFpDbEZMbU9vQktDRXl3eGhORkg1UlpqVDlreVpX?=
 =?utf-8?B?QlhEWTQ0aGdsZnJLZUxUeXdPYkZpMGR4RTZpd0JNTDNVRU1JaVh1VDh1eXAz?=
 =?utf-8?B?MDV5UllueHN2Rmp3ODVSWFNuYzV0SW1wckZ3RmRQbDlrcEJEeE5peDR6L0lq?=
 =?utf-8?B?ZnN0WlRueFE4S2RGVitQTlUvOHFNWFh0ajlvcEtnTGNTSW9LZDhycUFlMURW?=
 =?utf-8?B?ckhLUkVaNG81NFRIRStGSnR6UXdGc2RWMEZKOVFpMFFWMlN6dThBWFhtbWx2?=
 =?utf-8?B?WngrV3pkcVVJckwrTkZFamlkVEV3WVNHQ2VuUUNpNWxpa3NLUlVYeXJJUUdH?=
 =?utf-8?B?WEdwaEJ5N1hzb1dYRkRxdmRQTEdvTVcwYldyTHk4MlhRbGRUd0x3WE1LSFc0?=
 =?utf-8?B?Y0lrOWx4dlRKU2hCYWJuWW5DSkdMTzNMU1gzdDZvMU43elIxN2lCdFd5Znht?=
 =?utf-8?B?a1RGV1hwTVNyc3JMMGd5Mm9VTnNCMXdidnpQYWZ5ZkppUDRDMGxNcjZNRjlr?=
 =?utf-8?B?Q3ZDMHAweGsxZDNjbjhUc3M2WFROOU5TZzdUR0d0WEZ0aWkzMklmZEljMGdB?=
 =?utf-8?B?ZzRzTGJpeDRoRWZKeUhGbCszZmdVRDRqblBZbldzR0toS1A3S28reU9ZSVda?=
 =?utf-8?B?SFNoV0dpMHBkekU5YTc3aU8rUUpTcGRIZWFCSk5CcFM0WlBDM0JxUU5UUGdO?=
 =?utf-8?B?VGlSZHJWSXBlMWkyNHNJR1FBSWxHNGdBRzlDTWZ5YVRrSUFnOEZhdDV1WmRI?=
 =?utf-8?B?VVp5OE9VcmpzMjlhQUJibml0QVVaUy9yNFk1REM5UDQzTy9JZVZ4Tml2TDEr?=
 =?utf-8?B?djBsTFdCdDV1MzBtaW0ycnRyVTVpU21CdW5BYnVYVnZTWTJtaHFMYjBoVWxm?=
 =?utf-8?B?Ly9mKy9FMENNdDI2L2FjR1ZNMUJmdmFmblBtV3F6SUx6NmtzOG1NVzJraWhq?=
 =?utf-8?B?cXA5SUJ4SVBRNlRvclU5TVR1YVVaeHkxMVp5MVQvZ3lYY3VnUzJBSjN5RWJI?=
 =?utf-8?B?RitWRUtBVVhZUk1weUtGZGUwZVEzYk5XK1QyS2lDUFo2cGZieUdqbThMeXVF?=
 =?utf-8?B?M09GdmpoUFRmRWlSZ1RNcTBBYlpGVnBURWV3TFhtWVRxUXhsL0U3QzhvSVdw?=
 =?utf-8?B?eFV1TWRRWE1TdGk1NHVRUEJqNE5IdWxHbW54VkQxQkY2THFBS1c2dDBEa0g0?=
 =?utf-8?B?WXhDNS9mUWJiOUxXck9UWHRKbGtXTHgwK2xSdG80Qk1FTWx1eEo3YkNiejRl?=
 =?utf-8?B?UjJrMkE1YkZteUpOTnRZZVVRdmlqVFNBa0RqMGRjQUhxQ3JBSmtzdUVpR3Q1?=
 =?utf-8?Q?QYzPVFbnZRAizuyaBNvnjEaCF7rnYme1688vXxf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnNQeXE1c3BHUUQ3aTcxSW5XRGZQbFJVbmFmQlRlRE9BVytzMEdnV25Dd1ZG?=
 =?utf-8?B?Ykx4ajUrcjR1elhLUUhJZWVVWlkxeWJqSWp5bHREZ1JNbmhpVDZxR3ZRbVRC?=
 =?utf-8?B?RUp2bGtsWnRDQkFTM1RyZHJvZUt6SEVqZ1VuWUIvdU0xd3JuUDlNczJMZXdF?=
 =?utf-8?B?SUFNTlMvM0M4OUEyWTQvS0FmQXJ1SXJxdFhtS1hEWTJaNmFqdVBJb2RxM1Uy?=
 =?utf-8?B?SUFDN1Yyb0JpUEozUWdrS0dQT2pGakpQYk9pdDF6c0JTZmJXVDdqTGJUY201?=
 =?utf-8?B?bDIxSWo2dzZrbThjamJhU3BUQ0ZhTGt5Q0gwdTIvT0czS21KaHhlc3JJQ3RS?=
 =?utf-8?B?V3dNMURZaGQ2L2pvcTdUZ2Vwa2p4REo4YllkY2ZBU0x4WWJmMXRPVDZxaVVV?=
 =?utf-8?B?SUJ0NFVXUFBPUHNPZE15d1BqTnVaaCt0TzVaTEN2NFhlbk1FVFkzSlRIM1pU?=
 =?utf-8?B?eUYwdkxwd0s0NHBySkcvMzNQV0hGd1Y5VUxpdG5WUENUV21tdkJOUUJrSHAx?=
 =?utf-8?B?dXZ0SjBISzVDZzJ3YUltMGVEWWMrSDRnQStLMTE5QnpuUGNBUUJTWitrRHJi?=
 =?utf-8?B?K3ZLMVRsWTBEeGRvUlRXT2xvc0lQZHQ1cytyanllT051RTZKV3Z4T3pRWlFE?=
 =?utf-8?B?NHZGMG8ySEx2UnFPdzBLWllBMUJlQ3k1aW1KQkt2OVVYbFl5d0NqQUtyNlBU?=
 =?utf-8?B?WjlLS2xiTnZTbjAvK01RdHVOVU9qRE9PSUhJdWllZHZrc1M5UnRoNDlGK05D?=
 =?utf-8?B?c3dGODlya1VxN0h5ZjcwaGQ5dmNSRUVLK09HRjM3L29FckcwdjRaR3R3d1N3?=
 =?utf-8?B?d3N4QmVURHhPRExGOXQ4eHJ2YkJiZXVzTkpDRm5saGJlWG9MVVRDajBwb1lr?=
 =?utf-8?B?SFljZjM0SnIrQ2FUUXpWYkNYcGNYK1g1bHA0clBjZldwMFE1Mlp4SkNNdWg5?=
 =?utf-8?B?cWhWMDVHTkx6OE96Z2E5Qyt6bzI2L0YvYVF2UUx0UFJRVGoreHRYQ0xabk03?=
 =?utf-8?B?aGpPVGI2QUhzQ1kxTUgyenZTMHZYblc1dEFjL3RhZzhxNUMrUGVpaS9DdU5K?=
 =?utf-8?B?Q0lycFU4b255UE9wZG5VckxTSTZoUEhKeEhVL2tlVmtsa1ZGN09ldW8rdkVz?=
 =?utf-8?B?c3pxQWNaVTZVWnVOdEdRSk9HTW1ZWmF4NkdITzlHYTNtSW5hVm1CZDIzYWow?=
 =?utf-8?B?aWJ4SXdTWGw4U2UvSUJZM2FCVGRVM0dlUmZ4YVAzK2loaDFML1QrajJ1OEY5?=
 =?utf-8?B?RXo0bXVzbExUb3Y4emdmQlVsbmFiQ0psYXZseTdTeFZZZ3Y5bWMveUZmalEz?=
 =?utf-8?B?TmtMVm51WU9sajd1a3plMFY1SFYxaHpsNzdiQWdhZW1uMW1IOGpNQXNDUkcw?=
 =?utf-8?B?dG5Vd2FUbmV5VklKWkpvSFJIUXgyczhnNWhDRDNVRTBnTFhlY1hhUWNrUjl0?=
 =?utf-8?B?dWJENENnRVQ3Unp3bmZhVmFSbmdkYTRwcnAwYUh2WDh0VVUzTjNCd1RVelND?=
 =?utf-8?B?Qm5kTTRkaEM2RE1WRW42bldzeHJKMmZzTG44WFE5dkQra29abVlEdUNUYmhX?=
 =?utf-8?B?WjN5dlAxZUVWLzhUcWFpK0syUS9Pa3FRQk5ZTU5kSlM0bmRuOGU2enYvenZh?=
 =?utf-8?B?bDJqbGJ1aXY5ZHFaSVBDOWNUUzBLeGNzUmJtVXZvcFBoeFdlRmVxeGFsSHMw?=
 =?utf-8?B?OHg2cldGZlF1a0RCOWtmYjRFY1BWSWE0NXVPc3ErYSt4OVRPMTVlRDlRbk90?=
 =?utf-8?B?UHZidFRVSDN0RG1Ebjh5WDlnSmhkcWVZbHpIcHVWQ0NqVm41U0wxWXZ3TWpC?=
 =?utf-8?B?SmNLa0pGeXc3L3BRS01lbkFtd1FJT0twb0ZxNUpiT0FFejhPNUtNSytxY1Ro?=
 =?utf-8?B?Rk52VUhuZWoxbmZiTXJoRGNtWlRBUzBnS011Y2oxZkZZVXBRWHRLMU9DTCtx?=
 =?utf-8?B?bitwVnFSM1Zxejdyc3hUKzcrWVlkanpMZXUwa3JTb3grc1NUaVZ2ckZUcHJq?=
 =?utf-8?B?dnYvVFNCWVdFdU9PSDVHenN2ZUh1OVhSclFYRnZBUFBQUkJoN0tWUEY5SEVp?=
 =?utf-8?B?L212M0UwVXNSaVlQZGZqNngrSWNNNUJyem9ERFZmcnVBaU53U3RpcnhwenJh?=
 =?utf-8?B?UnpNS0JWcVhWK2FEWVh6cXNpZ216aU96QlhJdXJpWlF0NVNaQVFaTE4xZ1Zw?=
 =?utf-8?Q?WeNR3x+LUYlm2CFgCWjGbVI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d2f7d4-afd5-4104-6948-08dd5fea0f82
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:41:44.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bysk1BfgNxmrvtziRN5hFSovJ/xoBQdr1dGCnIgNsNN4a2TxaqoxDaLvcYSkQ4kFDMrzlIwkHRW6ENfx2im0ly0zu6O0DSodzlXMnn+SHNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6198

On 2025-03-10 10:43, Dmitry Vyukov wrote:
> On Mon, 10 Mar 2025 at 15:38, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2025-03-10 10:36, Dmitry Vyukov wrote:
>>> On Mon, 10 Mar 2025 at 15:30, Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>> On 2025-02-27 09:03, Dmitry Vyukov wrote:
>>>>> Add a test that ensures that PKEY-protected struct rseq_cs
>>>>> works and does not lead to process kills.
>>>>>
>>>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>>> Cc: Borislav Petkov <bp@alien8.de>
>>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>>>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
>>>>> Cc: x86@kernel.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>>>>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
>>>>>
>>>>> ---
>>>>> Changes in v5:
>>>>>     - Use static for variables/functions
>>>>>     - Use RSEQ_READ/WRITE_ONCE instead of volatile
>>>>>
>>>>> Changes in v4:
>>>>>     - Added Fixes tag
>>>>>
>>>>> Changes in v3:
>>>>>     - added Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>>>>>     - rework the test to work when only pkey 0 is supported for rseq
>>>>>
>>>>> Changes in v2:
>>>>>     - change test to install protected rseq_cs instead of rseq
>>>>> ---
>>>>>     tools/testing/selftests/rseq/Makefile    |  2 +-
>>>>>     tools/testing/selftests/rseq/pkey_test.c | 98 ++++++++++++++++++++++++
>>>>>     tools/testing/selftests/rseq/rseq.h      |  1 +
>>>>>     3 files changed, 100 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
>>>>> index 5a3432fceb586..9111d25fea3af 100644
>>>>> --- a/tools/testing/selftests/rseq/Makefile
>>>>> +++ b/tools/testing/selftests/rseq/Makefile
>>>>> @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
>>>>>
>>>>>     TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
>>>>>                 param_test_benchmark param_test_compare_twice param_test_mm_cid \
>>>>> -             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
>>>>> +             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice pkey_test
>>>>>
>>>>>     TEST_GEN_PROGS_EXTENDED = librseq.so
>>>>>
>>>>> diff --git a/tools/testing/selftests/rseq/pkey_test.c b/tools/testing/selftests/rseq/pkey_test.c
>>>>> new file mode 100644
>>>>> index 0000000000000..cc4dd98190942
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/rseq/pkey_test.c
>>>>> @@ -0,0 +1,98 @@
>>>>> +// SPDX-License-Identifier: LGPL-2.1
>>>>> +/*
>>>>> + * Ensure that rseq works when rseq data is inaccessible due to PKEYs.
>>>>> + */
>>>>> +
>>>>> +#define _GNU_SOURCE
>>>>> +#include <err.h>
>>>>> +#include <errno.h>
>>>>> +#include <stdio.h>
>>>>> +#include <stdlib.h>
>>>>> +#include <string.h>
>>>>> +#include <sys/mman.h>
>>>>> +#include <sys/syscall.h>
>>>>> +#include <ucontext.h>
>>>>> +#include <unistd.h>
>>>>> +
>>>>> +#include "rseq.h"
>>>>> +#include "rseq-abi.h"
>>>>> +
>>>>> +static int pkey;
>>>>> +static ucontext_t ucp0, ucp1;
>>>>> +
>>>>> +static void coroutine(void)
>>>>> +{
>>>>> +     int i, orig_pk0, old_pk0, old_pk1, pk0, pk1;
>>>>> +     /*
>>>>> +      * When we disable access to pkey 0, globals and TLS become
>>>>> +      * inaccessible too, so we need to tread carefully.
>>>>> +      * Pkey is global so we need to copy it onto the stack.
>>>>> +      */
>>>>> +     int pk = RSEQ_READ_ONCE(pkey);
>>>>> +     struct timespec ts;
>>>>> +
>>>>> +     orig_pk0 = pkey_get(0);
>>>>> +     if (pkey_set(0, PKEY_DISABLE_ACCESS))
>>>>> +             err(1, "pkey_set failed");
>>>>> +     old_pk0 = pkey_get(0);
>>>>> +     old_pk1 = pkey_get(pk);
>>>>> +
>>>>> +     /*
>>>>> +      * Prevent compiler from initializing it by loading a 16-global.
>>>>> +      */
>>>>> +     RSEQ_WRITE_ONCE(ts.tv_sec, 0);
>>>>> +     RSEQ_WRITE_ONCE(ts.tv_nsec, 10 * 1000);
>>>>> +     /*
>>>>> +      * If the kernel misbehaves, context switches in the following loop
>>>>> +      * will terminate the process with SIGSEGV.
>>>>> +      * Trigger preemption w/o accessing TLS.
>>>>> +      * Note that glibc's usleep touches errno always.
>>>>> +      */
>>>>> +     for (i = 0; i < 10; i++)
>>>>> +             syscall(SYS_clock_nanosleep, CLOCK_MONOTONIC, 0, &ts, NULL);
>>>>> +
>>>>> +     pk0 = pkey_get(0);
>>>>> +     pk1 = pkey_get(pk);
>>>>> +     if (pkey_set(0, orig_pk0))
>>>>> +             err(1, "pkey_set failed");
>>>>> +
>>>>> +     /*
>>>>> +      * Ensure that the kernel has restored the previous value of pkeys
>>>>> +      * register after changing them.
>>>>> +      */
>>>>> +     if (old_pk0 != pk0)
>>>>> +             errx(1, "pkey 0 changed %d->%d", old_pk0, pk0);
>>>>> +     if (old_pk1 != pk1)
>>>>> +             errx(1, "pkey 1 changed %d->%d", old_pk1, pk1);
>>>>> +
>>>>> +     swapcontext(&ucp1, &ucp0);
>>>>> +     abort();
>>>>> +}
>>>>> +
>>>>> +int main(int argc, char **argv)
>>>>> +{
>>>>> +     pkey = pkey_alloc(0, 0);
>>>>> +     if (pkey == -1) {
>>>>> +             printf("[SKIP]\tKernel does not support PKEYs: %s\n",
>>>>> +                     strerror(errno));
>>>>> +             return 0;
>>>>> +     }
>>>>> +
>>>>> +     if (rseq_register_current_thread())
>>>>> +             err(1, "rseq_register_current_thread failed");
>>>>> +
>>>>> +     if (getcontext(&ucp1))
>>>>> +             err(1, "getcontext failed");
>>>>> +     ucp1.uc_stack.ss_size = getpagesize() * 4;
>>>>> +     ucp1.uc_stack.ss_sp = mmap(NULL, ucp1.uc_stack.ss_size,
>>>>> +             PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
>>>>> +     if (ucp1.uc_stack.ss_sp == MAP_FAILED)
>>>>> +             err(1, "mmap failed");
>>>>> +     if (pkey_mprotect(ucp1.uc_stack.ss_sp, ucp1.uc_stack.ss_size,
>>>>> +                     PROT_READ | PROT_WRITE, pkey))
>>>>> +             err(1, "pkey_mprotect failed");
>>>>> +     makecontext(&ucp1, coroutine, 0);
>>>>> +     if (swapcontext(&ucp0, &ucp1))
>>>>> +             err(1, "swapcontext failed");
>>>>
>>>> Should the rseq register be paired with a rseq unregister here ?
>>>
>>> I dunno. It's necessary for this test and in general. Tcmalloc won't
>>> unregister on thread exit. Even for a libc it may be a bad idea due to
>>> signals.
>>
>> The rseq register/unregister is only for the case where libc does not
>> support rseq. But if you want to use rseq_register_current_thread(),
>> then you'll want to pair it with unregister.
> 
> Why? Isn't it better to have tests more realitic?

If you use rseq.c rseq_register_current_thread without
rseq_unregister_current_thread, then you rely on implicit
unregistration done by the kernel at thread exit.

Then you need to ensure your userspace runtime keep the TLS
that holds the rseq area allocated for the entire execution
of the thread until it exits in the kernel. Note that
disabling signals is not sufficient to prevent the kernel
from accessing the rseq area.

GNU libc gets away with automatic unregistration at
thread exit because it completely controls the lifetime
of the registered rseq area, keeping it allocated for as
long as the thread is executing.

So in order to minimize the dependency on specific libc
behavior in the kernel sefltests, the selftests rseq.h
requires explicit registration *and* unregistration.

Thanks,

Mathieu


> 
> 
>> Thanks,
>>
>> Mathieu
>>
>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>>>
>>>>> +     return 0;
>>>>> +}
>>>>> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
>>>>> index ba424ce80a719..65da4a727c550 100644
>>>>> --- a/tools/testing/selftests/rseq/rseq.h
>>>>> +++ b/tools/testing/selftests/rseq/rseq.h
>>>>> @@ -8,6 +8,7 @@
>>>>>     #ifndef RSEQ_H
>>>>>     #define RSEQ_H
>>>>>
>>>>> +#include <assert.h>
>>>>>     #include <stdint.h>
>>>>>     #include <stdbool.h>
>>>>>     #include <pthread.h>
>>>>
>>>>
>>>> --
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> https://www.efficios.com
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

