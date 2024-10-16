Return-Path: <linux-kernel+bounces-368379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B011E9A0F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348BE1F22D28
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23E20F5B1;
	Wed, 16 Oct 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KKk6wiUs"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6820E021;
	Wed, 16 Oct 2024 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094277; cv=fail; b=BB/sMnNW86ZvytIQinIlz9tqv6S6kdupHRR00XMe38nNj4VI8ty3gM4GpBZuYLAriUsFhsX9na7O4KNVpufc53QjT3rEv7U1oOXPCzLg6IdNw30uqIuA2Y1uY1nsawu/HB92w2730MtOJuEDw6zQtNsfhWdqRk5U6PcZ9+/+YYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094277; c=relaxed/simple;
	bh=izcMjV77uIHdeuLE0BnSLK46phI72Z0/AVAW+Gk4rNI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=avpAOGujjKy1m9RJPxpcXLD2ZGzy4OU3d+yVmc998YHZyGmVeEdYRsMWi18h1nL6k2bvL0L6ps7+D2RoTlkUIVLKt7Gytvpk4I7yUugbJZ6/uoL8aitfTH2Tgk9dNjKpZ603ynRBfmf+79AlnAIeEfVd1APoxvQ+a7s5kLEAH/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KKk6wiUs; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgJZNhCDQg0p/e1becsh/MFM9OOd5QQqPZu+xx9gpLkwGnURYLZD/BR0CBN3Igem70Nn634Pp5cyNWrS9gZdyPLaxRsf0BFfX0nxPhZQB2kC/8qhGh8sDSMq2k9PatptVOUBOCBNYksjxxyn1XthhBrzHGzg2Zb41GDs/x1gkjhyXyY3FabeF6nJOcDt0/k0v8BQ5KrAWk/LczzpQdbNPqkxYQpGCKlZpLJGLMWrQBh43HPzLTJiwLGaA6z3CfkkwoRC/dk9ijsT+aqQED7WJNRGMstAymAPUeKzoR2IRrmKPDoRwQZqtljmrtIrzEv7CPK2vrwm7uCc955B7hqYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2BFq/82+tLh2GKm4UK2aXp3Dt9SFuPr65yzmcK/YmI=;
 b=ZfAF0afgB4TuYyXxRHqrFwyp8YCqa9hzYAuLXFL9yyCawZER8WlsR97gqbi1s12r29N1IZ5Un9MUvw7q4Jy096hI5EH/YWuHXuhGj8XzZnPW3LfmaTV4oYX514B1qHovTsMeecpHyGZPl7R+TdxOUOr/683pDD4ZKiQcx8l1Q8N6RGIUw7KkrBvRHZZw9fA0o9BIAh8GYop9EKZ77mN0NYE0owsVVYgzt2Uf8JdAHi6kpCMWmLuSPCrJM0IbWNnDpDuucpBphTngmmBJntlBRcXHjm5TlcedqpwhWn7Tuw4jc5AQoROla7mDa0VMw12beBryGaE4AhAGaPyhiI2iCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2BFq/82+tLh2GKm4UK2aXp3Dt9SFuPr65yzmcK/YmI=;
 b=KKk6wiUsdgN2A9cm6cBvooHqc8ZhaFye22M14yDkix7QD08/NmT/U4oB38LSn/J7BFWTg5VrB5DDj05bpU4CYeGSDKuvfuFKsTjz5d/R+ivUdUxGQvt+xsV18K3Jqtl7R9mOu7ewsvEojA5EnPaq+eXqtPzZei1ApjbkuPeUUIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 15:57:51 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.029; Wed, 16 Oct 2024
 15:57:51 +0000
Message-ID: <df9b3513-1a83-474f-8772-f10cf96c14f1@amd.com>
Date: Wed, 16 Oct 2024 10:57:47 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
 <6b63542e-0ffb-4612-838e-5f3dba8469cd@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6b63542e-0ffb-4612-838e-5f3dba8469cd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c70f21-8357-4a00-7170-08dcedfb49c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGZETC9yaXhvM0FvK21Ha2hsbWlod0R2QnBBT1RYVThFSlpqUENUSE5TREF2?=
 =?utf-8?B?OFZGZXBxVGZVNnRhNUYza0ZIOTVPSzZzNXZhUWhkYy9KV0JpN0RIT0tMRk00?=
 =?utf-8?B?Q1gyNmFySlFtb0ZDVGNMZTlEY0QvTHBjeFIzSE85OTQ0UngwWU13SFJESk5P?=
 =?utf-8?B?WlA1OEZxd0l2NjBBZUFuM00vS2pEL2luR25ZRThOTUcvRnMrbUJRTEFrbXd0?=
 =?utf-8?B?MUUxUmFOKzZiL3haUnR2eFlQVXgwNVhpV3o1a0xsWCtodHhPcHlzQzdrOHNT?=
 =?utf-8?B?V2FjL1FYckdWWTVUcm5Vdnl2cVV5YnlRdTlQOGx4aXJpdkRSMkJSYVZKRDhj?=
 =?utf-8?B?YU5RK0YzYURCZ2VKSm14L0NyRFpOcDZBTVFlaHZ5UUp3Z3VibGc1aTJxNHEy?=
 =?utf-8?B?bHNTb3ZmMEtjeHRSbDU5TisxSjQ4NWtpeTkvOFZGbEhqNkhPOXhpK1hyajZj?=
 =?utf-8?B?QkF4RFEzU0k3NDVyRTN5dUt6N3UyaHB6akFuUCtoTXZ1RXRMN3dmWXZiMUdP?=
 =?utf-8?B?cWdkWStITVVzYWp2a1F2UDRWd0Z5ZzBlKzNPVEgxSStpTHZjdjFLQWl6MjNO?=
 =?utf-8?B?NmJFdTNtZVFJQmZJWVFPZE4wK280ZndZQm9VL3NlbU9uV3plSHIrWmRRUWUy?=
 =?utf-8?B?SlNPS3dXeEVMak5OdTk4L3hPQjdDWjd5K096Q2JLK1B3eTZaa2dsbnFkRWpB?=
 =?utf-8?B?SlNXQzhadXF0Lzh5bDhuSXJ6SnlTUGc0ejNxZDN6b1poaG45cTBJbzZNaUFG?=
 =?utf-8?B?enQzNUJEZHB4R0FvUW5BS09XV1lMenZFcnRqMlVsYnpIVkZmVzFLQnYvejJF?=
 =?utf-8?B?WjF6N1cwYmJWTG1FNWNSbWduN3BlTVlldHpqcjRYRnNSZVZIUHlPZ1RvaGth?=
 =?utf-8?B?SWdvWVN6bmpoVXc3R2xGRmtFY0ZVTkozbTR6YWJRRXVpOUVESGpqM1pCNGNm?=
 =?utf-8?B?QU11ZTV2ZkwxcDdrNXFJWG90NzVpYk01M3E3aVpYM0hlM3E3cjlZNENOS29W?=
 =?utf-8?B?cFRITzdCaEJGTTZlWlN5Q1BMNjB0OFY1ckUxZzVVbW5WczVub1VxckFNUVhM?=
 =?utf-8?B?cmVrQU1QWVNCTGRmUy9LWENacjl3QWlqUHhCR2ltRVNaTVl1ZlZLd1hObE9I?=
 =?utf-8?B?UUV4UmVsMkFBOWxKUEN0azVPQld2bEl4a1VpaEhhK25rOWZwMDJmckUwTmtO?=
 =?utf-8?B?V3FUbVhIaFdwdjRJMnkyczJFNXBkSzk2TUdjdnF1TURUQ2Y5OEZnbXh1a2Rz?=
 =?utf-8?B?TjNLNEg4TEx2aXIrM1UxQjU4YUZJMmlVNStPeGtlTmc3UzYrSStPUExJc29J?=
 =?utf-8?B?ZTRuc1NjYUMzSWR4UXhaN0lyOWhjVURxT0gvbFhIWGhFbUQxVU5hU1ZaOGV6?=
 =?utf-8?B?ckx6ek9ZV3p3TTlWNjYxanBnc21qYVZPYzl6SVE2dE95NFo4cTVDNFFpbitC?=
 =?utf-8?B?ZUxjZFllV1UzT1cyR1ZnOGM0KzFZaHpVVVQyenI4Z3dVaTl6R1c5TnoyNjFp?=
 =?utf-8?B?UFU4ZmNVWGd2Y3FPYkJDK0dDTWRibitEbncyQ09CN3kzR3NjV05XZVA4eXpB?=
 =?utf-8?B?MVdTcU9FNCtvT29tdjZNZTVhRFBOTVR0OVZXWnpyOEsyQzd3RytDeDlYWTBl?=
 =?utf-8?B?K0toS2ZiUWpxcit5YUFOSVkxQWVRNzIyYTlnZ1pseEpsZjVXQlBxTzArUmVw?=
 =?utf-8?B?eEEyUWdNNy82UWlaWTg3TDJ0RUhuTXZPbHgrZlR1T2RlUE5pMk0ybXB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVVDMlBrTXpwWVl0Y3hPalhZRW5YM0dDbk90ZUNXZXF5Ti9sa21sdDUzWDZN?=
 =?utf-8?B?alF6U2xrdE9ZTW5NOXVoaXJudkN4MUFuVStoNEtxVzZqK01UdGpZM2xBUDJr?=
 =?utf-8?B?QjBsS0tydXNoWFZINnQzTnZIaVg3ZUhrQTh0dzlHMmlKVUZLb3dHTENMa205?=
 =?utf-8?B?eXVYYWI4dVFQV2E5VlprMGdNZmN2VEFxZ1h1WTk0OXdxeGNKbXA0aVVHL2Rq?=
 =?utf-8?B?eDhLMFRtYTZWcU9kMzA4Ty9LcFloczFpU1ZlaFdodUxReTl5dU5xb1YyZm8z?=
 =?utf-8?B?c2t6WGMzVXhVUCtBSG1WYkMrMEFGMTl6Q1NKTWlUQk1jV1BwK3N3dlVtR3Rh?=
 =?utf-8?B?TmxEMEk1bFlPMFBqQlhnbHZDV1ZXa2RkUHpXM2RLWWNuZ3NWcGRUSUtsWUdM?=
 =?utf-8?B?b2hObXRhUHllNFVwWnZSY0c1U3hRRytoalpqb21qd01yM0syOXZyU2NsTjNH?=
 =?utf-8?B?OHZnUTEvc2p0ZXpNTGF1bGN1elNrZEQ5NkpaN0dmckxnSUlQcFR1aHUvSGU5?=
 =?utf-8?B?b20weHdTWnVqWDlCQ3hLUU93azJrMFlUSUhSUVUzZDcxRlo0dVRxTHkvSjNV?=
 =?utf-8?B?WWhPUG55U2NtRndRUERCWUUzdzZzbW55L054blV2WXF5NGdTNW1UWmhHRjFk?=
 =?utf-8?B?UHNxYkF1Nk4waHFnWExQT0hmektlZVJmU3FUdnJQTjlyMlpUTEZDQnNvSG43?=
 =?utf-8?B?QWlYRWU4eUtzdzdmZ0xnYkdzY2dOc1Q2WUJZeTl3RFFqMWVHRFphTlBzUUVj?=
 =?utf-8?B?KzNWZXJod3hNdURjWVNWN1FXWUJXbjUwVGVPYUxWMmYyODdEejZSZjRuTnFZ?=
 =?utf-8?B?V3h1YzRrbFdJS25ydlVYa2k3emRLeEtRN25OWDRmbHFZY1lMUHV1cmo3YkZH?=
 =?utf-8?B?T3JXN3pOUStDU2h5d0pGSFgwOUMzWlVKRUdBSTR1VVlZdnJ4aEtLQ2ZHTURs?=
 =?utf-8?B?UnE0NHllUGQ2WlBoTDBod09LcEl6UEtLMGJIVzg5c0dtVExFd1pkakxGQW9K?=
 =?utf-8?B?cjM4MndyaVg0TldDWjZiUkNVWlFkN2pKcGdZYkRMM1hkSlFGdjJFN0hZS01o?=
 =?utf-8?B?L3QxT25Bc1dkS3A5dTVRS2hqVG1WN29rbDhNMXhuOGQ1a3VEKytlanRCZ0Jq?=
 =?utf-8?B?Sm81RnUwTTAwRklTRnNkYTJqa1k4TUFaZXJ1emR6ckM1RWpFWkNrdUZCcFhP?=
 =?utf-8?B?ZldHeUFsa0FHemxFUUdkVXMwS2ZxRzhwOVNud3oyYWNYVVJwYU14ZEp1a1lG?=
 =?utf-8?B?K2lZcG1aY2pua0ZHeEdHUGpoZFducWVPRlZ0SjF3bVRaam8vN3k2UGVNTHNT?=
 =?utf-8?B?VjlyUHJWUVNrdUFWM3g3b1lKNS9CVzJxZEgvQTlGODhab3BMdUFYN3FoWStE?=
 =?utf-8?B?U3Rma0kyYTkxemdqQm95NU1Zb0U1eUVacDNDMlJrUkhVZk5yUFRKVk03ZW9J?=
 =?utf-8?B?TmkreWp5VFNIMjVmMXd6d080VW43NGhHRDBYanlMTHRxSTUvcmZOejNmZzRB?=
 =?utf-8?B?TlBtL2swaXVGWWRmZkdyQktVa2RNaEl1b1hkUWdQK1hhVWJTWW1ZcVM3amxs?=
 =?utf-8?B?RmE5YUlYLzZvNGZqazQyaTROZEpHY1Y0ZThJTHBWRW42QUNtWldubnJVMDJQ?=
 =?utf-8?B?MHRIQ0lXZTZqdVM2RGp4YWZKbTJHOUZzM3lrNjNEdjVsSWMwM09xMXk4emNV?=
 =?utf-8?B?UExZRGx6dDRBeGJHa3VkNjhRelp1QVQ5YnNLWXVab3c5WmJrRjZHT1RJcXdz?=
 =?utf-8?B?SFF0TG55WmFpNEd5R0Zjek03emRNa1IyaDczSVRQL1ZXeGgrdTJZbHpKOUkw?=
 =?utf-8?B?Wi9ub2VSZmdTbG4rN3JsaWtlV0g4eDFCS3cwZDdLMHdWbEZHdFZsRjMreFF6?=
 =?utf-8?B?M3E1ZGhncUo1UFNuMjMvaXZjM1d1THFvbmQ2dDFTcC9yMng5MzJBaHN2bC94?=
 =?utf-8?B?dDVrdStGbVRjM3prNllpeHRCMnZKc3VoRlB0MTU5Y0FiSEFzRVpQR3RndnB4?=
 =?utf-8?B?czFaTS9qYjdINkJqSFZwdHcxa1FHNCsrQ0k4Z1ZKME84aHVpd2gwMVhBdGI2?=
 =?utf-8?B?OUlvdkUwUGF5L2dIaEpEUlFDTW1qaXlmZnBZUHFTekh6OUs4eGVnaHphRm5r?=
 =?utf-8?Q?ZeXQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c70f21-8357-4a00-7170-08dcedfb49c6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 15:57:51.1896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3G2Oyy4p/9wiulk/9v0VzcVfyP+o93E4Mg5vG6B6c8T0l0/Bo1rjtAOjhOxPtgcV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472

Hi Reinette

On 10/15/24 22:12, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> Introduce the interface file "mbm_assign_mode" to list monitor modes
>> supported.
>>
>> The "mbm_cntr_assign" mode provides the option to assign a counter to
>> an RMID, event pair and monitor the bandwidth as long as it is assigned.
>>
>> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
>> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
>>
>> The "default" mode is the existing monitoring mode that works without the
>> explicit counter assignment, instead relying on dynamic counter assignment
>> by hardware that may result in hardware not dedicating a counter resulting
>> in monitoring data reads returning "Unavailable".
>>
>> Provide an interface to display the monitor mode on the system.
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> [mbm_cntr_assign]
>> default
>>
>> Switching the mbm_assign_mode will reset all the MBM counters of all
>> resctrl groups.
> 
> Please note that this now contradicts the documentation. Perhaps this sentence
> can just be dropped since there is the documentation within the patch.	

Sure. Will drop it.

> 
> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 30586728a4cd..e4a7d6e815f6 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -257,6 +257,40 @@ with the following files:
>>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>  	    0=0x30;1=0x30;3=0x15;4=0x15
>>  
>> +"mbm_assign_mode":
>> +	Reports the list of monitoring modes supported. The enclosed brackets
>> +	indicate which mode is enabled.
>> +	::
>> +
>> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +	  [mbm_cntr_assign]
>> +	  default
>> +
>> +	"mbm_cntr_assign":
>> +
>> +	In mbm_cntr_assign mode user-space is able to specify which control
>> +	or monitor groups in resctrl should have a counter assigned using the
> 
> Counters cannot be assigned to control groups. How about replacing all instances
> of "control and monitor groups" with "CTRL_MON and MON groups", similarly
> "control or monitor groups" with "CTRL_MON or MON groups".

Ok.

> 
>> +	'mbm_assign_control' file. The number of counters available is described
> 
> Looking at the rest of the doc it seems that the custom is actually to place
> filenames in double quotes, like "mbm_assign_control".

Sure.

> 
>> +	in the 'num_mbm_cntrs' file. Changing the mode may cause all counters on
>> +	a resource to reset.
>> +
>> +	The mode is useful on platforms which support more control and monitor
>> +	groups than hardware counters, meaning 'unassigned' control or monitor
>> +	groups will report 'Unavailable' or count the traffic in an unpredictable
>> +	way.
> 
> Note two more instances of "control groups" above.
> 
> Please note that the above description implies that counter assignment is per-group. For
> example, "specify which control	or monitor groups in resctrl should have a counter
> assigned" and "useful on platforms which support more control and monitor groups
> than hardware counters". This needs to be reworked to reflect that counters
> are assigned to events.

How about this?

The mode is useful on platforms which support more CTRL_MON and MON groups
than the hardware counters, meaning 'unassigned' events on CTRL_MON or MON
groups will report 'Unavailable' or count the traffic in an unpredictable
way.


> 
>> +
>> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>> +	enable this mode by default so that counters remain assigned even when the
>> +	corresponding RMID is not in use by any processor.
> 
> I assume this should remain RMID since this specifically talks about an x86 system?

This was a suggestion from James. Let me know if you want me to change.

> 
>> +
>> +	"default":
>> +
>> +	By default resctrl assumes each control and monitor group has a hardware
>> +	counter. Hardware that does not support 'mbm_cntr_assign' mode will still
>> +	allow more control or monitor groups than 'num_rmids' to be created. In
>> +	that case reading the mbm_total_bytes and mbm_local_bytes may report
>> +	'Unavailable' if there is no counter associated with that group.
>> +
> 
> I reconsidered my earlier suggestion and I believe it needs a correction since
> counter assignment is not per group:
> 
> 	In default mode resctrl assumes there is a hardware counter for each
> 	event within every CTRL_MON and MON group. Reading mbm_total_bytes or
> 	mbm_local_bytes may report 'Unavailable' if there is no counter associated
> 	with that event.
> 
> Please feel free to improve.

Looks good.

> 
>>  "max_threshold_occupancy":
>>  		Read/write file provides the largest value (in
>>  		bytes) at which a previously used LLC_occupancy
> 
> The code change looks good to me.

-- 
Thanks
Babu Moger

