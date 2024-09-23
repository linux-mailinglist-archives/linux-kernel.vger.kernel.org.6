Return-Path: <linux-kernel+bounces-336024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEC197EE39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9F91C2163C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684738F6E;
	Mon, 23 Sep 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XP9YCwwz"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB916FB0;
	Mon, 23 Sep 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105469; cv=fail; b=Ohk/OZ439rowF77jo3oC66f2uaeqaml9IwobXkG00FRZhbiwBClP3n4++M0fC2bOe3fxbkxc22DRnX71nau59tK4ic1uyE0inWn3nL8t3MbXEVQ+lLnKU9s8wuRlmn/yH8koT86P1f2wxzt/bbYjo4JoHD0D2a00BI9UyHlddjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105469; c=relaxed/simple;
	bh=svdxI0Gi+/VS40nsbbGUB/LwwHpLjhYj4QQIt9a6JSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mCE5o8sd6FKln+kiFUFGkDEU54r3aVz43GZEujiuCVQZ3WQN6DHIgNs6S8La90gLd6l6fcKfe9gpEfKysPem3ZIBXGKlKvEfQ71Pg59yF3p03cLUVtP4AXeISB32ikBpuhd8FPY3V4F5gvMPe2whc+vGDObln/+CNujKHUPgMvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XP9YCwwz; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxbU0OASo8FxUeZ0mp8EEqcAKt4wjqwfZ3ILNiWckDBSe+1EtpKj5Ggvpc0NDEv51/LEjvuR0fy3mVofIEiIWU8CT05bNmOaFkHGAE1VgeTI8qwN88b7yPjzzaLUCewYR5Ya5Aiv9iyCXF0Y9nGoW6sJDyYNqQq/IxxtKYAulzNhr+QLEhvGogAloI5r8cSivQlZq9/WhwkowJNpgSy1MiSzndemXTMrltpiaQMjFIWSGmLw02dEqW25orit/sD7ZXjva7R/sXUcBDzk4SjFCsDjxEVnuf730lCUnJA2aL2m9HJEnz5nxkvKy1O1frpS6CeaB5enE3hcH8cKqOVW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E72oN8gDBmRHBIy7FJ1ZCu8APBvOqi6x0q8mamFxZLk=;
 b=cpMby1lhxxHRQO7Qc2OKsv7F9OCwNENLBqA2jxNvPQGbh1/pwWzbKMbcP3kJ7WzKlaYNj1VAG0oVO7iu/WaqGxmMWRUm2eXa9IcwNVVSzKAzbFUg/EDBSu5NtrMcG4Cw3n+Gq7sg704P4B2JK59HcmT7RqZzSXKT8FT1iFLf8Oi9atUDTmLnBLTMYdQCLTXAC+4zLMPgwTNQuu3KZMAYRqOr9WmvGqLP6sjw3mgR8w0GH63b/DhymMMNdsWoG7vIaBQAtojq377KNuRu/ArUdGTSJtwoCgsQdKVKx20FPa1wVvateOxm+Ss1BuXSX8iEc6uTA73NKwoBI3x7GieXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E72oN8gDBmRHBIy7FJ1ZCu8APBvOqi6x0q8mamFxZLk=;
 b=XP9YCwwz9FDgTq9DiPDtXaQngWd++vaMBU0pw/qc8h0Tg52bq8fuemJoYDVXg6I/VxIOJwuO3wGFXyYaYbdNpe1ASJpooXAvY+hofGhIi2tstBW0vRan0Tao8sv5GIq+K79yi+wt+J9laPdmZ3W6T/wxLKkDdSNBZwDPWXumZbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 23 Sep
 2024 15:31:02 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 15:31:02 +0000
Message-ID: <9cb5b1ad-5a7c-42a4-8207-2890f1c32e0f@amd.com>
Date: Mon, 23 Sep 2024 10:30:58 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 06/24] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1725488488.git.babu.moger@amd.com>
 <556b3576ce076c8867795d4af1bcdaf883397304.1725488488.git.babu.moger@amd.com>
 <56f1396e-8a51-43d3-9dd0-dc55a1623b12@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <56f1396e-8a51-43d3-9dd0-dc55a1623b12@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0183.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5efe92-bd80-4923-193f-08dcdbe4bb73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEdCcmQ5TVZYNHBhUG9NMXY0RzZBSkRuNVl3Yk1vYWczWTEwbThiNW1tcGNL?=
 =?utf-8?B?eHZ3eTdtVEM3b3l1Y0lySXZVTENrOXNGbjJFNzc4TDJwVjI5ZllQSWordkhs?=
 =?utf-8?B?MUh0NWRQbzhXeW1leE1BL2lFcjFZWWhNTDlldlhxbDMwTER3Zms5elE5N3RJ?=
 =?utf-8?B?amhlOVM1TFF6NzNqMGY4WHpxVnllYlhNbit0MEVXZ2pGNFFWRS9Ib0ZCdnAz?=
 =?utf-8?B?MWR0R0V2ZzQxMU1wT1BZdGtBa1I1ci9xMWNGbHY3cTJUTVdKalo1NmhPZjV0?=
 =?utf-8?B?aUp6MElralNTdnExbEFIcmp5YWQ1YzdxTm15YUR4R0ZzN0M1b3ZOVkFabkIy?=
 =?utf-8?B?aU9PTGRkSENpUmpZZnZlVkZYbVBCaG1yNXFva0J3YWd1NTM0akNuS1J6RlAx?=
 =?utf-8?B?RERaRk9xcjdicDgrczhJNjhmSWVRTEs1WTQ3dXJ1bHRTZm1QL1hPaU5CbW42?=
 =?utf-8?B?N0pJdHl4TUNMVnk3YzlqalNXSmdUbTBWdEtYVE9KMitSdWdKdGZreXg1K3FV?=
 =?utf-8?B?cGQvdnY5M09JKzY5ZDg2eWNHMDhHbHlKcG9DU3NNblptQ2lRWEhRaW5ZZy9o?=
 =?utf-8?B?eVBKYUpjbysyZ1ViclN5a2pGdnlLWDZYT2VjL0N2aEZldmRwZUg1bWdwd0Yx?=
 =?utf-8?B?RzQ5U2FkL3ZxN1FydzJoZVl1T1I0UkV3R2tldys1ZkN3WExDMWpYa3V5YVFD?=
 =?utf-8?B?RDlPeXd6N0hNSnY5L2d6aVN5MmdiV0psRDlXaHF5SVVjMzRxM2JCeXM4N1F6?=
 =?utf-8?B?UmQ4Vmt2TXFNLzJzUDVwYTJzVkw3eHNCbWZlQjYzYVFHTHhYSGQ5UzdRTk1H?=
 =?utf-8?B?aXZyVldiWUFkZTdhME5XeWVzanZqTXRKV0hTcnRvWWhvampHVzljU00zdUxm?=
 =?utf-8?B?SXcwZDdFaFh0Z1orcGxkdy8zeFZnQkg2cDFJdzM0RmZ3NmYzRm5OMkErbU5q?=
 =?utf-8?B?QkY0TTQ2eFQ1RTBoQXU0MjljNlljak1QRXZUWEx3Z0RtdzEyQXAzenlVQ1pS?=
 =?utf-8?B?WVhaK0JVWFF0blRsMlBMWlFwZHBLOEVkMDJyMDMxL0FxS2x5MVc2NHRyNkM4?=
 =?utf-8?B?OHozMUg5UDRaREcwMHp5YUw4WDZGUmJLRERVNnVCSlBUbXVVdXFOLzl6OXk2?=
 =?utf-8?B?dUNLRW1Xd3ZaQWwzY01FNnFTaENlT25nb3J3emxIbDQwNkpORk84ZWExaHZX?=
 =?utf-8?B?U1VrQTdyalVEanRWYmpET0czRVgyaDlGNlR2VFJsVkJLNnNUc0dpQUdZN2Qy?=
 =?utf-8?B?ei9aU0tjMExZZnZTYm9HUDQwSmx3Y1pmQWVvSTRhVU9SSXJFT3phSnd2eTFu?=
 =?utf-8?B?cTEvcHY1aStTU1R2ZlozREc5Y2pkTXhtK2JIcW55WWJObnh3aXdYb0o3MEhP?=
 =?utf-8?B?aWl4ZEpudmttZTh0RjJRaHl5OC9ZTzIzU0xqM1NqbU90U3czZ2hvUGFVWk5V?=
 =?utf-8?B?ekhFN3ZSTDMxUTVhdDV1YWpNZ1VyMkdPai9mekxXSHRvWHBCWlBBMFFvNGFH?=
 =?utf-8?B?bGl0N0Z4b2RMeklSaFVMcUJMbFpmTk1NR09KYlRUN0lxakMvbDZEMWNtRzhJ?=
 =?utf-8?B?VFBsbnRQSmxvbDFiMGk1YWdyK082bHc3WFNmYTNScnFwQUJVVWd0bFNhVEhM?=
 =?utf-8?B?SHYrRCtnWmkvamUwQTNGVFBoVVZmUmc3RE5mMHJFUW1NeExlRUd1anFYcTNH?=
 =?utf-8?B?enlMYU1hZDZvYVRqQkhiakZRRzl4cG05WHBJekJ6V0FSeGthRHhPZU5pdmxu?=
 =?utf-8?B?cEIvOW42cVBjQXFYTlpjUWxtS1RxcER2YVYyeDNkL1I2QXVpSTJIaHUrcFVN?=
 =?utf-8?B?NHJWMEpxR1c3Q0xxb1Iwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2VqQjYycGt0K3AzZ2QyQXdFQ0hhZUxoMzVnSXVJdGVDeGhjVnhVUHVwMVpN?=
 =?utf-8?B?TzVtcXpTSlpLT29ybFFXRFFITnVXSGtKR1gyQkxwZzZOK3FaKy9vbXZUaTlo?=
 =?utf-8?B?NnEwRHZnZXRSSTVWWVJEUXJkaUxIck5wVTVPd2pidk5zeTd0VVpJNE5BQVVq?=
 =?utf-8?B?MkdUSUJnMWNZT0xhQmpuajIrTkNiaHJGZmZ3cnJEZDFuZTRPb2JsZXk2YS90?=
 =?utf-8?B?R1Y2TGpFdStjZUM4VEp5RVh1REN1TklWVXVxZWlreXo4aTByZm9NYzRNODM5?=
 =?utf-8?B?aW51M3BjNW5uNkRSd2EwVDYybjdQQ3NjOU8xdS9lcVNvZGRVVDBCYzJEMUEz?=
 =?utf-8?B?V0ZoaWY0UjByMXZIeGEvM0dFcFU3RXY3YTJ1Z0p0dXEzdGI3Vlk3Q0tScHdy?=
 =?utf-8?B?Q215eFlJcjNXWE1yYyt2eFo2dzRmMy9WV1dYam5NbjZKQ0d1d1NmejhxNFZJ?=
 =?utf-8?B?Z1RqSTN0c3I3OFN2ZlVBdjBLZTIvU1FQZW0yWTh1ZEdaNUtFSjhmZk9SVGUz?=
 =?utf-8?B?c3Vwek01bHJNeGJ1YTRMcWQ5TDAzd3djM2Y2bi96YkNpT1FKK0VyZVRNdGs5?=
 =?utf-8?B?elZYbi9OK2dzdDFFUUFTYTdhWnIrbFJ1ZmlMeVhxTkdEUVlWaG55bkN5YUpO?=
 =?utf-8?B?OVZLdHFVc0xSV1YyZjBESGZZK0ZURHVQd1l6eFB2Z2ZOT1VnVEtoVnN5WDB6?=
 =?utf-8?B?ZmFDMm9yeUtJbHpmblBXWG5SeHlRK1dOQS9WdEN5VzR6RFhiSnZxVEwxT0c2?=
 =?utf-8?B?SS96WEloVmhNQW5SUW13T2lnS2Ixd2pMcTRUMVF4TlpXK2hXMjl1LzQxMmU3?=
 =?utf-8?B?WkRXNmIyaTNhMkxVd2xvZWEyOFVrNTVrdTloQkV5NE1nbXVML2NReituRSs3?=
 =?utf-8?B?WCtaRDYyZWF4U01pbktnQThrQ0lIQzUvYmRlWG0yMEhhSmVmdW9nUk1DR2ky?=
 =?utf-8?B?Z1FEaUJQMVJWUUpGUXhIbE5naXdzZi9Rd2g3elRYaHRnYzV6a0tTbiswa2RQ?=
 =?utf-8?B?U0JrRm1iVzlwOFRKODc5bk1keTRxbWdFeFNTQlkvSmdvZG1KMUx3OXV5TVBs?=
 =?utf-8?B?NmdCZUIza25Ua2psQVIyNjhiRDRZWDBGSmowRXd4ZTgxZDRqVDhibVBJVXRl?=
 =?utf-8?B?TmRtMXlLNFc5T09Da0lDNWx3SzBHcGhiVW1SdHJYdFRGTVhmZkhOTWFYRUxh?=
 =?utf-8?B?YXNtQXhmMW10ZnBKeHRxbnNjbUxmYi9KbHdoRjYwV1NCcDhlbC91VUJFSjFO?=
 =?utf-8?B?MVhid280QUt1b1ZCSy9tWVU2K1BIRHVuY2lLMTVkc3ZTYVBoczR1bi94bW1Y?=
 =?utf-8?B?OGVZdmxPcWxiQkREWEpQeVhuOGxlUXkvakNhdGRGc0dMbGJUdHdJQUJraE1P?=
 =?utf-8?B?T3FPSElEdFFBdnhHUGVTQXU4OWc3Ukp3SEd0VTRwQTR0bU9pdTd1NnUzNmlM?=
 =?utf-8?B?TEhWNlNsbjV3R3F5WVcwcUo3ZktudFM1TEJZOTNIanhnL0djUzBHWUg1UVRZ?=
 =?utf-8?B?cy8ydll2YU5OYnpUdmVQK2FYSUROT0MvNGJ0elZXaWNaS0krOGx5V1Q4c0Fx?=
 =?utf-8?B?Y0RJNkxmTWEwOXFFVktXZC9zajdiamx4YzVwcGtNUmx6eVZTRVg3SXI1bEJZ?=
 =?utf-8?B?cVVpczIxZGNVSWFHQW5sc21rcXlyUkU2TGdxbForbkFQNTF4V2dhSkxGaUNM?=
 =?utf-8?B?S05MZm9vS0JwM0p6NU9uSUlMdG9zTDF2TnYzTnYwRS9Yd1BYdjZVdzFDYWh3?=
 =?utf-8?B?clFQQ2NmYW1Ib2JEOUpWR1BuNktFdC9Gdk50cU5nbkdtTDBJdDR0VktkeUd5?=
 =?utf-8?B?SmRqOXVtNEhMYVlIQklEUHIwckFPbVAzZVQyMTlYYTYrUDdNZGhoSzg3MGc4?=
 =?utf-8?B?b1dWbDZpdnBWUjJ6VWZXMW5mN0V1a29BYjJ3eXVWdHZtR1dmWVBodmg5V0Rq?=
 =?utf-8?B?ZnNITnM3c2xJK1RTYWo4VzE4ajZsOCt1WDhNbDZjQlRtNURocnZTSmc4blBY?=
 =?utf-8?B?RU1UNTFOSVkySTBWWHZMTlg2UUwyM0trOW5GWjdBakJrUmNLaDU3NTJzL1ZV?=
 =?utf-8?B?YXM3b1VRTklZL0lNUnhtVDhWdVVPSzZqT3UvN1dpaGRQQW85UHdFd25nMm00?=
 =?utf-8?Q?zbyc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5efe92-bd80-4923-193f-08dcdbe4bb73
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 15:31:02.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns+X4t7mFnpYmc8KuUCXghwBI5LcZdwPkqY9FUNNzj3YdtI+3J2xbjhgihg503s0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415

Hi Reinette,

On 9/19/24 11:22, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> Add the functionality to enable/disable AMD ABMC feature.
>>
>> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
>> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
>> to be updated on all the logical processors in the QOS Domain.
>>
>> Hardware counters will reset when ABMC state is changed. Reset the
>> architectural state maintained by resctrl so that reading of a hardware
>> counter is not considered as an overflow in next update.
> 
> Above mentions that architectural state is also reset, but that does
> not seem to form part of this patch? 

Yes. Correct. Will remove this text.

> 
>>
>> The ABMC feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>>  static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 7e76f8d839fc..0178555bf3f6 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2402,6 +2402,41 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Update L3_QOS_EXT_CFG MSR on all the CPUs associated with the resource.
> 
> This comment is not accurate since the function below only sets MSR on current CPU.

Sure. Will move this comment to the caller where "on_each_cpu_mask" is called.

> 
>> + */
>> +static void resctrl_abmc_set_one_amd(void *arg)
> 
> Reinette
> 

-- 
Thanks
Babu Moger

