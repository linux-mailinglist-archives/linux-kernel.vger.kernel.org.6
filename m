Return-Path: <linux-kernel+bounces-233049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A1491B18E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDFC1F28302
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163FC1A072B;
	Thu, 27 Jun 2024 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I8fW0/HS"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191413FF9;
	Thu, 27 Jun 2024 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523604; cv=fail; b=PhTksElcgBCq4Drkhsi0gn8EO23f96kqwNgBUZrbgHNytI1sgLGqNvtsG0Tf+ExfBHdVjSh32d9Mzn15qXIw/3lH9VlgqvkjgB0b3w+6dDwil+n39StOXSUYLnWR2n1r/Fs1nJJe8EU/PCLVCu8Llft+Al2e9W5waZHTclmqB/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523604; c=relaxed/simple;
	bh=GyFr6ebPisVPzkFHTOrY+wnIAeZR8Z7jM3nuukrKizI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HjRRgZUZzWaHRAy5AP+xixkw+Dz44Pc1G2r0IdkI9uWzGKYFq/f6y+3hRGhJfoSbEaM6jmYXr9pSBM3bx8p7g9BSzMoBnDhBI1QbQxP71mG0IWLNp2kKh4jtgrvajjpzKjBT6Q0Sw8NGxA6qmJF5zbEGHHE4FrMtfAOg/cucNPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I8fW0/HS; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr6hIDEmB7HW2y5kCeR6tspWwfrJpmSa9sm3soxcsRbOWHgY/I2NhV9n7oz3qQYWw0qpshpCHNCfhJCk2dQWHSMVf2BRRv0bixU/R9kLSwbYaD3rA/C+D8v8ovzEnYEQwcLFy1sYy9eDmnXLP8mvbTCuUu3fbhd8tTizvWxJ2RtI3kat/gSHzbtZYiXeDpBkEprxW47ha7CHSWQwuQ+gLHb38JojPvmlGG/Md2zLM6KRHbCId9BPRA++wiAkejsvn4kC7OxCvxP831RQDUUVtWR3rJNbybszXpGG88QMmbQx1IG4gqzmwLNhTS5G/O97CUFEYWrI6MGAP29mNQX/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjcWzVotqMVs8xu5XhYaM9kg9G3meEbMjtCGh6WW2a4=;
 b=ElO3Z7l0H8JgwAXtERaZzCg00qH7nQQY2BDNB2/Q5t+hs9E3IVOMZDIfOKBGJPhsXEwisjz3FJelv9tKrD6I9bkA9oifvqeNq4xhte41TCCq3MKy0Qq7pEineT57sZeKPnOcK9a1Owx4TuUvi9MQY3U4+V0PZMKg6Ja60owmPgEvrnfK/wlDZTFIjVOjzuaD5boJ3W9folzCCw02lno1xGPaf/j6tXn6h6KFQSCxERrsV9cndZq2PjF90cYD2YRy5h4AuwRz3KoT3am9YcDeO2VmyRr0p8hPQ/FmmxCcj/yoe3z0DOYxbjgAwvUW8BpZCtkdPaer+RUN8jyCsRsOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjcWzVotqMVs8xu5XhYaM9kg9G3meEbMjtCGh6WW2a4=;
 b=I8fW0/HSmGpF1hm0/a6FSXAEfDH4NX1KbSsEsv6RhHuQhtptob0IDURRjnnHIcV3H8t5RI2C1rNxyDcQZu9BE1vG/M4i7Is5OTsPIwaXdJfw15Y3PcZtl2NIvBvXQ/vOaCuLjVLN4t+rB/BEN+X0HKr1QEky4b8ByXX+DXeE+B0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 21:26:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Thu, 27 Jun 2024
 21:26:39 +0000
Message-ID: <011efaeb-42fb-f8de-56fa-1bc936f241a7@amd.com>
Date: Thu, 27 Jun 2024 16:26:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 11/19] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <a02dd2b9fa06f360eabe923c5c6d17fa4036aa9a.1716552602.git.babu.moger@amd.com>
 <48e0d78c-5ed8-4b93-8f12-3ce3fd74116c@intel.com>
 <68e861f9-245d-4496-a72e-46fc57d19c62@amd.com>
 <81f3bdb1-ebb8-4a90-9cf0-6a2d09ff13e9@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <81f3bdb1-ebb8-4a90-9cf0-6a2d09ff13e9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0167.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 81355e98-3b3e-4948-501c-08dc96efd48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVZtMTlVSFhKMFRlQlJMZ0pNV1JzMnlYbEpudkVUSno1SUJYRStqS3RXTWNx?=
 =?utf-8?B?MWlJNW9VdlBoMGRlb1RvaGNOT2lVSUxWUmNYdGFzVVlqbzBsYUh4Q1NHeVdr?=
 =?utf-8?B?RUNhMVRmODJIUFpHaUxEaTN0ZVljUnVDSjExeUVNN2N1eVRoKzJnMUoyM3FO?=
 =?utf-8?B?aGZiUlBvOFppSWVlcXNBRzRCNm1ERjU0ZW4zeTJ1dHpHa3MrZkxLcVNBNHlm?=
 =?utf-8?B?RGhoRFZLVm8ycmhObmMvekRpZGIxbm51WVJSQy9PVG01QlljZzM2Y2VwaXZT?=
 =?utf-8?B?Y0tBdzBxSXhZbUsvR09leTR1MjNpOVRsYko3cWRaYkVqdnhIUDlQSFFMd2FO?=
 =?utf-8?B?TEtobWE5RUZhMHVjRjI3ODY5RkZGZHZMQkpPdFZHd1FzQWZSMjZETzI2TGNt?=
 =?utf-8?B?bUg2ZDhxbWo5S1pvaHRMbjVHbjZVTWMvRUZlUXU4MkVzK1JQeGxPY3puNklL?=
 =?utf-8?B?NXNmNm9BTVBpcFZFdG5oQ05adjZsaU1OSDA4ZTgxMXFBejJRc0Fia010amZu?=
 =?utf-8?B?ckVLM01UbzI2cHpIOEttOWwyVGRDTTRKQzJqbDc5RkVjV3g1eFlOTm04Z1pv?=
 =?utf-8?B?aEVoRzVjeTZPQTcvL2FiSmdSblRIbEl6cWN4NWV3VjJxbTh4R1R2dEFFaGtF?=
 =?utf-8?B?YmIwOWVPZjZKc0IvdDVIRVJ0V0pGak9QMGtSQXc5aXhsYlFWejNubGZmVG9R?=
 =?utf-8?B?ei9kTXcwbUZWdEhJQm5wS3NwNk9aa2pKL2xyVnJkYllPdm9oUnN6ZDRVaU5D?=
 =?utf-8?B?TURpdFR1Q0Yrcy9zMUF3bDVyeS9WdGtaY1hZRENITWw0eU5SUmJmd0NJSWx3?=
 =?utf-8?B?Tll6bEFyNXdMTUYzM3BjK21LK3JaekUvNUZlRTk1UmwyTzFKN3VEWU5lRktK?=
 =?utf-8?B?NUpFNkxlV0IyeWpsL1NUNWFCVzg5YmdsOUd4azRub3piYjNRYlNrTmV4MDJo?=
 =?utf-8?B?czdoaWlOYU5jRnB4bjk2MTRBUFFPdHFvN2hKbHFIN0FSS2JhTklZUHFpTDAw?=
 =?utf-8?B?eW94R3RuVjJRQzhRcTRraVd1aUpmUnhIN1JRM3ZJYzNRc3kveThJRXZ2SnJ6?=
 =?utf-8?B?aVJ6TTN3QTBWRHdvREVncWdJMFk2YTJoTGFBYUpDMnRGOElnd2tsYTVsZFB4?=
 =?utf-8?B?VVh3NnovR05MSkNldTRxd3J4VWxyM3hGamtiaWZBcE56OXN5Tlhud0FOb3NW?=
 =?utf-8?B?YVlkSW5BOVc1c1B0ck1PbFlFWTUvbkgrTE8zSUJRK2FDc1Bma29mdWNuVndQ?=
 =?utf-8?B?THNzQzNab2wxR3JaT0FkakRjS1VXKzZDU0hUbEppQmRnb1FHN3hpQW1tVHU0?=
 =?utf-8?B?NnI3OFpzbFJVR2ZJd3FWSi9rWUwwWGRKVXdRS0FDcHlqSzBjNG9ZWC84K3VR?=
 =?utf-8?B?bnJ2MGtJQzF2cldnYU42NWVCT1N5aEdnNkZOY1MreDFmYzc1bVFlbHI0N0xV?=
 =?utf-8?B?TWg3WHN4b1hpZHRzcnA0ajJPYmhnM1E1eSttNnhaUk5yVUREbXJUSDFFZE9I?=
 =?utf-8?B?OUZkd2hsNXpVajIrRXcxOGp0czdqZlkrMWM2aURvaXY0QUplT2ZGZkF1VUF1?=
 =?utf-8?B?bHJoR2taVFdWcUorWjRVR2pjTDZXMXIwanhJNlBwU0RRTXlTak5uOExJZ2Y5?=
 =?utf-8?B?UjBmd25aNXJyNkFsZENpZzFNZWovVVhPcTN6WjNJclVoK095WmwwQjJYaUt1?=
 =?utf-8?B?alpSbGxtaTROQ1pPdjR0L1lTWHhPV3FjVmp0MSsyeTJPeWlRdTQzdlN4Y1NK?=
 =?utf-8?Q?cmI5ZrYvjw+1MQoGdE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnFvZkl6c3FvZU9qNU9weVBreVJlaVo4T3N6eVJSZm1qd2dVMzNCaU04UTZp?=
 =?utf-8?B?VElBUS9qUDFJN3I3cDQ2ZnR3d21hL2gzNVcrQ21TeWZydDcrcDNrRE5XSzh3?=
 =?utf-8?B?dm1oNUVUdnJYVWR0Mm9PaXgyMks0YzdFcFBBRm1YdkJyZVNLa2NOejMrOVJz?=
 =?utf-8?B?bkQ2KzJ3Uzdrdng1b3BLdWlkRzRoVWpDS20wWlZYT0lJUGQxUFhDRHpOTE53?=
 =?utf-8?B?TGNXeGJBSkpMd2ZGZXJEMFNvTjB0RTVqQ0d3cDQ3Qkg5Qmk5bC9vNE5FWEN4?=
 =?utf-8?B?b1VEc040NjBvTHdpMDdzWmRHakpOTGN5V1FXSVcvYUlKY0JNdXNNUFdKZ2tI?=
 =?utf-8?B?ZHhxTUZ2VU0yVlJ6UHAyWWhJSm9Td01GMTQ0b0srY2ZjTURMTnlnUzZIdHFj?=
 =?utf-8?B?czR1MG9XY1JPY1g2eXo0TTZiRHFCbHNJdTVrSllrdHE2eFh5SThEZE5BTExh?=
 =?utf-8?B?STd4UFYxNTdtYVVad2ttWjROdElSS3gwQVJWOHI4ZHdSd2hxeTZqNjlhK01Q?=
 =?utf-8?B?YnlmTFB4RVJZcm13K1UrYnVlNHErZ2Y4QWlnSTkyWmQraCtNdHVzT2c0QjJt?=
 =?utf-8?B?eTVBaFc1WXJVUnpZWWxab0l2TG1wUGJpVVRUMU1hV3dVTGtlSzJvQVREV3NN?=
 =?utf-8?B?a2NoODhLMFdjbXpGQ2Fzb1pocGk5Skg5V0FoK01PQXN0QjFabmlnWTIwTTgr?=
 =?utf-8?B?M1RHQzA1OCs2SzBmaSs0bWZKeXpvdTZhMG81dU5rT3dISW50SjVtdnlYTWsx?=
 =?utf-8?B?a3gzS045ZndON1plS2U0VUtnWEo4TFBmN1NmMlByeDI5Mk9rOXJHUUo1aXZD?=
 =?utf-8?B?OGZCSTlRM2pzV3g4OVUyVnIvRmhMb0R0d0JCL1NJSTdBOVNLTjdZZ2svSGVV?=
 =?utf-8?B?NytwUXgreDg0UGN0L1Y0WCtNa0tGM3JwYXQxczFObll3TlNkR2lpVEIzRWpH?=
 =?utf-8?B?bFdDb1VXb05HcVVEMjJmL0ZMOUxmYkQwUGF2YnJoMnZsOEhqVFk2UTk3MjEw?=
 =?utf-8?B?QnluTnlZRFZGdjBZb3RYRnRtN2xBQWZCNE96RkZqMTVRTHZGM3FNc0V0T0Q2?=
 =?utf-8?B?T1VXUHJ3TUViQS80YUcxTnF2QVlLSkFGNktUVjg2UDIyNkVMcGRadlRFczNL?=
 =?utf-8?B?RWVxY2dYNEpRdHZRRUpWaFc2YVNEMWt2SlVBMFZOeG9VZW11d1E4T3NPSDZ2?=
 =?utf-8?B?M2toeTZ0UjM0Y21WbUlOa2pYaVg1S0hQSGZQRGN2TUNwNVdCWjFJMDA1NTEr?=
 =?utf-8?B?K0NOY2NlS1loV0NyYjhpUWd2bmlmeFRBVks2VU84YmpOK2JOMkJMYWZGd01Y?=
 =?utf-8?B?ZHgzalJWUWVjUTR6K3FKdXFFeUNUNjJaOEp0YVhaOWZTSlhHeXQ4ZFdVTVZQ?=
 =?utf-8?B?clVoMVJkQjNWK1NRVUZiVGZrR0FLSDEwazc3RXM1R3JGcDJEVzE4UXlobDFW?=
 =?utf-8?B?WlBXL3JYR29UR2FwWW1JV2FTR2x3RVRWUVUySTVjVWZJYjhveXBXc2xnS3Na?=
 =?utf-8?B?TGhoeUhIaDRDdWt0aERrN3RZZnBQaStoc2RvYmJkOUt2SnFtNURZemhvZk8y?=
 =?utf-8?B?V2dDK2F4YklLZ05pN1JwWTdZYkw3V3V6TUVSNTlEMnQybFpRS0NDQzF6WkpL?=
 =?utf-8?B?YUVMemcrc2JwUHFOL2pxazVBYmNzc3hmRTZHTHVpK2ZvSXM4TVF4ZDdiME5I?=
 =?utf-8?B?ZVhwU25jNVJLTGdLTTRqSTErZDJSeUxKTGE0NjNDQXU2aWdSUHhLblpLZ0dS?=
 =?utf-8?B?MHkxbVZIYzFMcG83Y0QySkJjRlNrNEJZdHU1c2hONnVRRXlPaWZnZlhBUWJ6?=
 =?utf-8?B?YkFGMnlxVHQ2cWRFclBuZEw0NmpqczlscjUvcFUwWGFld2lUaFpTa3RPSlFa?=
 =?utf-8?B?eU9rc0htSmdmVTdtcTZickYzcjN3Q3pGYUlzN3J1VEtCanI1VVgxcjNKMDFz?=
 =?utf-8?B?cXNtV00vdElURWl2bmtQdG94NWVvVUdxZDJaZ3FWZzczWUk2blZvUm9naUVX?=
 =?utf-8?B?ZlErbU41T05pTGVyRm8wb1pBbE9MTlRiOEZxaTFvWE1CZHZCNFBUNzNUcldo?=
 =?utf-8?B?dzNBUVBlY1VNb05xczRNNHZkOU5ROWkzMlAwcE1BQVVpUkViajFjNFRMZ0NR?=
 =?utf-8?Q?SxuM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81355e98-3b3e-4948-501c-08dc96efd48f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:26:38.9131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xI3/dEe0R114YA1hNBPyvo+hGRXR0XyOEJOEjDzNhXpkHznn0wydyB8OLYrC1fE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206

Hi Reinette,

On 6/27/2024 3:56 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/27/24 11:51 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 6/13/24 20:43, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 5/24/24 5:23 AM, Babu Moger wrote:
>>>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>>>> supported, the bandwidth events can be configured to track specific
>>>> events. The event configuration is domain specific. ABMC (Assignable
>>>> Bandwidth Monitoring Counters) feature needs event configuration
>>>> information to assign hardware counter to an RMID. Event configurations
>>>> are not stored in resctrl but instead always read from or written to
>>>> hardware directly when prompted by user space.
>>>>
>>>> Read the event configuration from the hardware during the domain
>>>> initialization. Save the configuration information in the 
>>>> rdt_hw_domain,
>>>> so it can be used for counter assignment.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>> v4: Read the configuration information from the hardware to initialize.
>>>>       Added few commit messages.
>>>>       Fixed the tab spaces.
>>>>
>>>> v3: Minor changes related to rebase in mbm_config_write_domain.
>>>>
>>>> v2: No changes.
>>>> ---
>>>>    arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>>>    arch/x86/kernel/cpu/resctrl/internal.h |  5 +++++
>>>>    arch/x86/kernel/cpu/resctrl/monitor.c  | 21 +++++++++++++++++++++
>>>>    3 files changed, 28 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>>>> b/arch/x86/kernel/cpu/resctrl/core.c
>>>> index ec93f6a50308..856c46d12177 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>>> @@ -542,6 +542,8 @@ static void domain_add_cpu(int cpu, struct
>>>> rdt_resource *r)
>>>>            return;
>>>>        }
>>>>    +    arch_domain_mbm_evt_config(hw_dom);
>>>> +
>>>>        list_add_tail_rcu(&d->list, add_pos);
>>>>          err = resctrl_online_domain(r, d);
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index 5e7e76cd512f..60a1ca0a11a7 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -373,6 +373,8 @@ struct arch_mbm_state {
>>>>     * @ctrl_val:    array of cache or mem ctrl values (indexed by 
>>>> CLOSID)
>>>>     * @arch_mbm_total:    arch private state for MBM total bandwidth
>>>>     * @arch_mbm_local:    arch private state for MBM local bandwidth
>>>> + * @mbm_total_cfg:    MBM total bandwidth configuration
>>>> + * @mbm_local_cfg:    MBM local bandwidth configuration
>>>>     *
>>>>     * Members of this structure are accessed via helpers that provide
>>>> abstraction.
>>>>     */
>>>> @@ -381,6 +383,8 @@ struct rdt_hw_domain {
>>>>        u32                *ctrl_val;
>>>>        struct arch_mbm_state        *arch_mbm_total;
>>>>        struct arch_mbm_state        *arch_mbm_local;
>>>> +    u32                mbm_total_cfg;
>>>> +    u32                mbm_local_cfg;
>>>>    };
>>>
>>> Similar to the abmc_enabled member of rdt_hw_resource, these new
>>> members of rdt_hw_domain are architecture specific and should never be
>>> touched directly by resctrl fs code, for example, from 
>>> mbm_config_show().
>>
>> Need some clarification here.
>>
>> I am thinking you want to introduce architecture specific routines to get
>> and set mbm_total_config/mbm_local_config for the domain.
>> Something like this.
>>
>> +int arch_get_mbm_evt_cfg(struct rdt_domain *d, enum resctrl_event_id 
>> eventid)
> 
> The prefix for arch specific calls converged to "resctrl_arch_".
> 
>> +{
>> +       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>> +
>> +       switch (eventid) {
>> +       case QOS_L3_OCCUP_EVENT_ID:
>> +               break;
>> +       case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +               return hw_dom->mbm_total_cfg;
>> +       case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +               return hw_dom->mbm_local_cfg;
>> +       }
>> +
>> +       /* Never expect to get here */
>> +       WARN_ON_ONCE(1);
>> +
>> +       return -1;
>> +}
>> +
>> +void arch_set_mbm_evt_cfg(struct rdt_domain *d,
>> +                         enum resctrl_event_id eventid, u32 val)
>> +{
>> +       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>> +
>> +       switch (eventid) {
>> +       case QOS_L3_OCCUP_EVENT_ID:
>> +               break;
>> +       case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +               hw_dom->mbm_total_cfg = val;
>> +               break;
>> +       case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +               hw_dom->mbm_local_cfg = val;
>> +       }
>> +
>> +       return;
>> +}
>> +
> 
> I expected that a call to set the event configuration on an architecture to
> also interact with the hardware. Essentially what mon_event_config_write()
> does today, but in addition also sets the cached 
> mbm_total_cfg/mbm_local_cfg.

Yea. Understood.
> 
> Part of this is done by the new MPAM portion [1]. With that the post-ABMC
> implementation of resctrl_arch_mon_event_config_read() may be what you
> have as arch_get_mbm_evt_cfg() above and 
> resctrl_arch_mon_event_config_write()
> does the same as in [1] but with addition of updating the cached
> mbm_local_cfg/mbm_total_cfg within struct rdt_hw_domain. Would this work
> for ABMC?


Yes. It does work. I can keep the same name as well.
Thanks for the clarifications.

> 
> Reinette
> 
> [1] 
> https://lore.kernel.org/lkml/20240614150033.10454-21-james.morse@arm.com/
> 
> 

-- 
- Babu Moger

