Return-Path: <linux-kernel+bounces-554430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF17A59799
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D22C188834A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DB417A2E3;
	Mon, 10 Mar 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VyDWjMf4"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022099.outbound.protection.outlook.com [40.107.193.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92891386DA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617069; cv=fail; b=rk4MJK0oS2t2aIoIVbWsr2ndEVjbRE2Dq00o11KoQ5r1dFH8ovAZC+WIbsZEULHTXQOfhNZbGyrHKth+Niu0eADAU5LA0MPVHKw9eXRk9HnweG4khoBle6DhfDqLSsMvV8/r2fHCZ1H5h6fIzMmzBmvC4Fo4Iwf3q54/Bb56JSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617069; c=relaxed/simple;
	bh=Ovr+QECZtjqilrieUcro/AymNldCSq357zcOBmswyTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ByoiPw47CKd1sf903PM+V2Z9/L5m2GArueq6SkrFaYbYRczjP1hnNPS1CeuTiWRY6vAreSKE+BXrRYX/3M7jgPcJ+Ip8vmSknt9KkFBJP/rm0l3PzRZHPVNc2cfqrwbNCdEPxg1GTMw7OGjQ0Uw1PSiyn7huiFm257W/ZoA8Zlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VyDWjMf4; arc=fail smtp.client-ip=40.107.193.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3y3nLgtJNxbYBcj1lQw19YufKIH62oVZ9GiJqaAgXBzGHXajvMIbLOIXfKspiKnOimJxl5VZsuLsUZfxdeV84J5r0AEdbAqg8PdinbEoQuH8EKtAGJJ1BfRiw6Dj2FRn/1hCMZyc7uHYH7MTE9te47l6gcO7tOVwB6OqWWcQKnbrJ7pAaIS+gsgZeiaxM7yQpZtu2iUvKGuxjcKY2bnKDUAM6oce5UgcWp54zxPpkc3Rwn42UgSib+GFZs7m2w/JlFthcMQknzwXX59e7j9eh0cNIf5Ot7ZhvfrnysE60kGOKAARCroD3XCWiWtqtL/Ttd3sW5cyvX4xHqmeMZABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Drhq8sYj+vOAm4tk2eDn95GUEKyjz+CSSvQj1T4I9Ek=;
 b=ymgZiw5cfw2InQ/va8dS7+gUxSbVzr7pQaMhD5N4Ij/iAcwAxIoN790ss6hT0VacAkkRrmuYIHx3zmXZompAhBcg3KIz6WAqlL5g3atzZ3+Ew4hxkvEH2LgOo+JusVLYqvn92OOgjqe5FtAUHBODetKyaYwhuOWfs2SH32hpLU3D1Ug2Wmwmn8CdK7+xRHj92XAvXe/NAhx9io9e2qwSpSMxjODdn8B7k5NAjEgAzdEobBI1vUMH93cc9HddXiwRreADRziYNPFX+L5FfEuELzO2RWupNC1RQpfNHQ9IivTkpbOIQzWP2nZtMWsIrzr0Xm2jyvNb4gM6ta2NcOoA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Drhq8sYj+vOAm4tk2eDn95GUEKyjz+CSSvQj1T4I9Ek=;
 b=VyDWjMf43MEtl+CE6TAHMkym/96baYHsw4pkGg7GWfdLAl8S7wkjDp7a50ieZ7e7JXcRSJ5LxSWNjY2MpPDJzD8nSdgO9bRZx7db6DV7fSoBFPhTcwBQOfO/y8W8BGC5i648RsW1lFcA9ZwhqSubiFd8emsI+zVKzOS7grR7ibZ2KAmsZvRIEEPN/Y6tV9toFXmPJVvYO8JzZn3CQlBbK4oyUNt14+aAnhlSddFyQCknzQUVGG5CjdYDLx99y9+ib4HkoakILt0lt5JHdcUrwMrnepzD0vMz7La4tE2oUEurTE9ASwt8/2YVcLQt1qMHyhT3GmkKwfPd0aWJk3lZvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YQBPR0101MB9983.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:7b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:31:05 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:31:03 +0000
Message-ID: <28358cb6-135b-4126-ab80-f2e2d0cb4389@efficios.com>
Date: Mon, 10 Mar 2025 10:31:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740664852.git.dvyukov@google.com>
 <e534910c51271eebf4055a92f3b1c5ac998988bc.1740664852.git.dvyukov@google.com>
 <CACT4Y+bxV-keWg6-NGnA2k039gzMf_9COCe+zQWpcup8bMhToQ@mail.gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CACT4Y+bxV-keWg6-NGnA2k039gzMf_9COCe+zQWpcup8bMhToQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0222.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::33) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YQBPR0101MB9983:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb45d14-8296-43c2-09cd-08dd5fe02fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVGWnh5NGpqelErNHZ4K0NieWxyMUppaVZTK2svYkFCLzE3eDdmT0ZDSXBF?=
 =?utf-8?B?dm95TG5xd2gxSXRSeG1DcFZRREprdERMWHhodThBZ1RQaklWUEhkVmFHRG1T?=
 =?utf-8?B?ZTNxTTFLUitCaFMzTUthdFhlM1ZyYUR6UHZnOUcyeEsxTlZ3bGlhOWxVVDh6?=
 =?utf-8?B?akczcWxHdDErVzBqdFgrVDBoUjlzNDdtcEU4a3JhakZ2elZPNE9jd0ZyM0NF?=
 =?utf-8?B?ODdyMFRQM3FDVGY3OHBJUk5IUnpXRG11TU85ejNTaGdGK29RWlBmb0MvcTY3?=
 =?utf-8?B?VEVEZDd5WWxBTVJ6TFkwblhrS0JBNU5pZ2UyT3lzSkN0T3F3cUpWV0YwdTND?=
 =?utf-8?B?TVhPdTZXTWJlNUlXVEhMcmx1K05EejJZditKTjRuQ0RwKzJFaFJuRTR5cXZL?=
 =?utf-8?B?Nmd5NDUrR21rU2xiclVPTkxRY3h6a0hSUGMzb054emR5T1VGYnl4SXZQcVpZ?=
 =?utf-8?B?T0xMUDZzQ2FIbXYrbWVwUEh4MkE5THA4SExxNUFlbmR1MjVsTWJQeGFuaHFK?=
 =?utf-8?B?N0xDU3lYQ0laeHExcDBEQnRBT3NjUGM5RmlMMXM3UjY0QUpLZVBhZ1A5L3pS?=
 =?utf-8?B?VS9Wa1I2amN2bjFwU3M4d29DbWM3eTIrQjdtOW4zZGlIZ0dESXlUU3I5Nncr?=
 =?utf-8?B?Mmhic0Nod3NQdXBOTzArY0tYeG9hOHRDMVdqM0JadmF5aXAwK1ZjeWpsSTV5?=
 =?utf-8?B?T21PdlY4RHgwczRxT0FPTDFWNWJhM0ZVbG5zS3JOUUVBVWVRdVFKcTdwb1ZZ?=
 =?utf-8?B?YVVGVjlVeGFnZGJGSDY2bnB6SFdiTG5ITURjVGlwRmdWL1MydWZ5OERadnp4?=
 =?utf-8?B?WXJEMU9Pc1Q5QVJER0wyLzdVNDJKcHRCc09wY3ZQdFVBaTEyakdZY2l3VG1r?=
 =?utf-8?B?UU00RDF3UEFZVWIwRjhwODV3STdrWDRRRmIrR3BtWm01RncwMXAvbVZSZ0c5?=
 =?utf-8?B?c213aHpKQ0tBcXhFZjBkZXp2Zzd1SzE4VHByUG0yMTZTTjNpOW01UjdyN3NC?=
 =?utf-8?B?UnRhTnRITTdYUmpuM2huWk1vUE5YVmV4K1R5cVJONXowYzdwNWFNUW9SSk5S?=
 =?utf-8?B?bUhVaHFCTmhjQnZsdHhnZml3UEtOcHR3UWJHaDgzZkNMdk1WeXJrR0cyb2lv?=
 =?utf-8?B?dEU3L0dRamtqOTJSNHZGendKbXc0TkZzek1MbnQzb3Jkc3k5WkVvMkRHOEE0?=
 =?utf-8?B?cEpidnJEQW1wWFovKyszZ1B3cWwxUURONTY1eTRUdVVCUTRZTUdVNjNCSUdB?=
 =?utf-8?B?R0RObHppNnoycnpsOWxNRWJiYnh4RldmRDBhaWMwTlNFMTUwZmhJMFgybkVo?=
 =?utf-8?B?RHl3NW1MV2lHbjBwZDJnWGJaMGlocFlXSHQvcmJ1RjRFOFhqTXUxRm9nWTBV?=
 =?utf-8?B?MVQ0bWk0WmNwR3RDRUlMZFhJVXFxay9MTVlFMm9INWpVQklGeDNvSkQyU25H?=
 =?utf-8?B?U0tpWU1qbzcvSWl4RE1vbnF0N0p4QXpwbkVPQTB3dTloeXZGc25LaStiZTNn?=
 =?utf-8?B?OXFSbXFUUmJtK3k5OTFwZkQ5OHJ2TlJsdytNVUFXaUhRMTBVTzcrV0o1NHhB?=
 =?utf-8?B?WmNtclJlL2FxeSs0YWpNYXZWZjRoazlLMThaK01HbHFKaVlTTDRGTG44TjND?=
 =?utf-8?B?c0dIcjBTZ2k0dDNVVmtxZ0ZQU3I5VnlXSlllam1hb05KdSs1KzJlTnpHVGFh?=
 =?utf-8?B?ZXc1SGR2YjhJWENYL1hJUHlhenI0SDM1OHBWL0x0b3hPdFV4dzFlcjA1NzBp?=
 =?utf-8?B?TXhURzl6Yi9KaXlkUHd6Z3ZwTlFZQnRtNkYrTHppb1dwY1NBQzc3V0RmaENJ?=
 =?utf-8?Q?dfGPfmQg3Dn2Z0Q4La+oi0jvFv0g7vUTji6bg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjZQbXZldkZHcDd5OSs1dkFjUFo0WjVBcExTdGE0UjlJOHFxN2RVWXJ0RnhM?=
 =?utf-8?B?cU9Rb1ZkUFptU1hlUnJOa1AyS2pHUDNiYWxSOVZWMVRZN25SaGFOUy8xZExr?=
 =?utf-8?B?WU9ZOU5HQnRDRlJGeFBxazNYbnpXVDVadTZwRnBaaC9oaFduSTNEYzBmZ1Uw?=
 =?utf-8?B?Y24vUDdUL1J0MTJSUjVLUytqZ0ZwYWhnSVNwU2ZLVkM3MmNMTFQ4VDYrQmdk?=
 =?utf-8?B?UFdtbFc2OUY4TzVreGdiVUs4SXd4bTU3YVl2Q0ptaXhBUDlhajBGZElHL3BO?=
 =?utf-8?B?ZFU0NVI4cFRIbVRxbGJQcUY3SHpFbjVKTzJQZ2V4R0ZKYUJpSFhTYTArL3lR?=
 =?utf-8?B?cDBUaGRibXZzclBpVHRYQUdKOGFuSE9ab3ZIdEdPSGJicWhGc0dYOHk2ZnBs?=
 =?utf-8?B?Tk9RVWVSTFlrcTMzQ2xvTnRDbVltb2xaLzYwZkZzL3YycE5HZktWTXYvcW1a?=
 =?utf-8?B?N0dFODFZUWVvM1QwREh0eW85YnRsZG9LSEV2dGszMXRsL1pvRGV4VGlKdjBa?=
 =?utf-8?B?MW9Qa0JLbWNESi84cFlCOVg5Mzl4Rm5EaWVwSWtzb29ZelFwa1BheE1VVk1X?=
 =?utf-8?B?U1lOT2VUa0RnSG1DN0wvOThnU01GQVVqejlidVZ2Q1dGMnhiNlp0N0xCQWsr?=
 =?utf-8?B?NDhtODN3em9ZMVNnd0lwVkcwQ2d5MmYyUlVjcjFXditUWDdtTjBPQm1GSzA5?=
 =?utf-8?B?eFVMVXM3SFc4RWZ1VHZGaEhTQXd0dXc1aU9WZVRmUDZjbFd2M3M2ZGJacGdU?=
 =?utf-8?B?VWZEeG5tZFpIYzl3VU8wWWFRWUJuU2t3WWpuM0tzVXpOSnZIMjhtRXk1ZkJa?=
 =?utf-8?B?TWo5cy9GV2NpSEd1WitOMEVVemU1OEhjVkFTQkw5bkNrWm9BSkhobjFVV1Ar?=
 =?utf-8?B?U1ZvTVN0ODhJS2UxVEQ1R0xDblhXSmxUbCtjNWlSVHd4Q1o4QkhNU0ZHWTVs?=
 =?utf-8?B?NjY1Y1hDWEVaWXZ4YXdCSDVKWllheUpPdG95U21aTmFHMFJ6bU8yei9JQXNh?=
 =?utf-8?B?c3J2OUZzNzRJV0JyY05QQ1Y2LzNBVDJmL3R0UmwyVDN0dWF3dmladjlXdlEy?=
 =?utf-8?B?Tmw2WEpVSXNtOFVQaXIzU2JFbHZlTVN6NFhYSHQ5QWdQZGE4dW5xM2x1T284?=
 =?utf-8?B?Q3g2Mk5DMlhpaWgySk9uUGdiZkdYbnVPWWlmS1NkYlNjMUNQMXRzc3lsczhE?=
 =?utf-8?B?RFl4NmhMbW81MStqa3RzZDVBc2Z5OXNGS3FHMVI3MzhGZ3Q4c3dtR092U2c3?=
 =?utf-8?B?OTdmTEVYK2J3UVFNYi9mcGx1TzYvcG1XN1VZWDlBSlJ3SmgxWW10VFc0d2pU?=
 =?utf-8?B?MzEzTCtNZi9BYnV6aW5IKzEzcDY0RUEydmc5VVY2a0hWbm1lOERvN1RuZUly?=
 =?utf-8?B?MkZhUDJnekx1bFNTNnhJaEk5VnhSUm0zSG5YNEQ1aWpOKy9mM3Y0YlNuUHJh?=
 =?utf-8?B?enlIdG1mNjI1dFF1K0pUcStDemY4aVBOcG1yV3E2cU45RTBPVWhpeTJOMVRJ?=
 =?utf-8?B?Qk9NMWlSQllveE1EUTRWMnJVdU9KN2k5RW1SVlA3OFhIc2dtRUFtNDFVY2hT?=
 =?utf-8?B?SkNFSWRMcHJOeDZ4bUVQNjJldUZMNHhRN0FycmpwbFBzTWV0QU9CcXhGSk1V?=
 =?utf-8?B?b3lLRkwzZnB1THJDR2duaG9WdFdDUDh3S2tNNi9jaStlM21SWG5wdjBBRitV?=
 =?utf-8?B?WHVxVjRGVDgyVjZXLzB0N0xFcTN2bnR1OUdTdGxRTWhhRHl1NkFpWVkzTXNI?=
 =?utf-8?B?TVdNbHNhWkZ3RGlmcEtUTExXVW4weVF5eVBaQW83MmNoRjdiL0RZTnpDUmJW?=
 =?utf-8?B?M0V3RDZRcTNZKzcrSEdBSU9IOXN5dWxYbHJKS2tWaWhkUlFOWFUvZnR5WEtk?=
 =?utf-8?B?blJiQ0U0ZktWa2tRWVUrcXRCSWp1NmdTSFpZak5ydXpsK29KQUhhSWVxV0du?=
 =?utf-8?B?blQ1RVMwb1hMektuNTNoVm02bVVnRmUxWS9qUGFYSVFsSGtJOWtKT0xGbWJo?=
 =?utf-8?B?MHR3dXI3TXgzSjBabUhBaVhvT3hqY1ZmYkI3dWlzT3NtUDBVN1FjQi9CYTNh?=
 =?utf-8?B?Rnd6QUJFanNvaUxaWWlacWtEd2pNTUhTY2V5SEdTUXluak83eUxlbHhRaVdF?=
 =?utf-8?B?eUdBelV2MEVTNHk2bUtaMmNsc213L0UzYlRnOEdVWGxuYUI5UUpqNVArMHNC?=
 =?utf-8?Q?84u/317gADzSH/h8UsNyD+o=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb45d14-8296-43c2-09cd-08dd5fe02fcd
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:31:03.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPN/9Sz/ePD0OvY9/Jj5zNTdR0ead8Tf+JNc21QO9xEbIqCHr9uO16ZjQoP4kLYwUshu229wl0NieIaRszIp7MaXUvGyWzVJhUThTWOOCNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9983

On 2025-03-08 05:02, Dmitry Vyukov wrote:
> On Thu, 27 Feb 2025 at 15:03, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> If an application registers rseq, and ever switches to another pkey
>> protection (such that the rseq becomes inaccessible), then any
>> context switch will cause failure in __rseq_handle_notify_resume()
>> attempting to read/write struct rseq and/or rseq_cs. Since context
>> switches are asynchronous and are outside of the application control
>> (not part of the restricted code scope), temporarily switch to
>> pkey value that allows access to the 0 (default) PKEY.
>>
>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
>> Cc: x86@kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> 
> Any remaining concerns with this series?
> 
> What tree should it go into?

Usually the rseq bits go through the -tip tree.

Thanks,

Mathieu

> 
>> ---
>> Changes in v6:
>>   - Added a comment to struct rseq with MPK rules
>>
>> Changes in v4:
>>   - Added Fixes tag
>>
>> Changes in v3:
>>   - simplify control flow to always enable access to 0 pkey
>>
>> Changes in v2:
>>   - fixed typos and reworded the comment
>> ---
>>   include/uapi/linux/rseq.h |  4 ++++
>>   kernel/rseq.c             | 11 +++++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
>> index c233aae5eac90..019fd248cf749 100644
>> --- a/include/uapi/linux/rseq.h
>> +++ b/include/uapi/linux/rseq.h
>> @@ -58,6 +58,10 @@ struct rseq_cs {
>>    * contained within a single cache-line.
>>    *
>>    * A single struct rseq per thread is allowed.
>> + *
>> + * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
>> + * then the assigned pkey should either be accessible whenever these structs
>> + * are registered/installed, or they should be protected with pkey 0.
>>    */
>>   struct rseq {
>>          /*
>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>> index 2cb16091ec0ae..9d9c976d3b78c 100644
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -10,6 +10,7 @@
>>
>>   #include <linux/sched.h>
>>   #include <linux/uaccess.h>
>> +#include <linux/pkeys.h>
>>   #include <linux/syscalls.h>
>>   #include <linux/rseq.h>
>>   #include <linux/types.h>
>> @@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>>   void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>>   {
>>          struct task_struct *t = current;
>> +       pkey_reg_t saved_pkey;
>>          int ret, sig;
>>
>>          if (unlikely(t->flags & PF_EXITING))
>>                  return;
>>
>> +       /*
>> +        * Enable access to the default (0) pkey in case the thread has
>> +        * currently disabled access to it and struct rseq/rseq_cs has
>> +        * 0 pkey assigned (the only supported value for now).
>> +        */
>> +       saved_pkey = enable_zero_pkey_val();
>> +
>>          /*
>>           * regs is NULL if and only if the caller is in a syscall path.  Skip
>>           * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
>> @@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>>          }
>>          if (unlikely(rseq_update_cpu_node_id(t)))
>>                  goto error;
>> +       write_pkey_val(saved_pkey);
>>          return;
>>
>>   error:
>> +       write_pkey_val(saved_pkey);
>>          sig = ksig ? ksig->sig : 0;
>>          force_sigsegv(sig);
>>   }
>> --
>> 2.48.1.658.g4767266eb4-goog
>>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

