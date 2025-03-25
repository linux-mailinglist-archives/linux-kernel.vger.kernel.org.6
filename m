Return-Path: <linux-kernel+bounces-575348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10298A7006D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A45E17BCCA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AC126A0AF;
	Tue, 25 Mar 2025 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mld9Q/IE"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681325BABC;
	Tue, 25 Mar 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906149; cv=fail; b=TkrXds00/a76ns0rSYcfltUeUA+jtFekEjYIdLwaYW5jOuV7Lq+94Q0e9nFo14t1VIYPHdAkuMxmomsvNicoQGt63cZc4U/INn57oUPnxawhiiQp9hcqBcUI31843q9tuDpx9RvvtW2am/lhc3PHOjcaQF4qOcPNN/zDjMTW/BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906149; c=relaxed/simple;
	bh=ud6UVnutVD4qIUT22JrPrWBBax/PtgtRtvHToxFtAho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QiTp8PqEjEVzUv2WNm5Yd7UFkV/BPjNT0w0lIriRb3EzO3W6S+/OsEQdG4auVxFTr3znUGB9BnUhO6mVGOd0/CUB47ycam0V8dAwd2vxfW6ZGXSrRzjseBfs8sbOnTUbOhFYdFNZAzae8CXG/m1nL7ouu5oa1JTxMlXh5St8oWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mld9Q/IE; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwQQRbvaI13+j910ycsTRLGErB5136uAf10TN+dwxAqrRO0uYZeHRBfethSKHr7em77XiVs5MJA0hFlz1r0xmQ4/op0R+Nz+ENkORazD8qpTlnJhAu3vYxnjmDu28Ly1qllg1kaj+5j2Z1ftXzaB4feLZOmVnNCDtTjC5WjdvP/hKpPE86kcI+UJAXyDeYQd2FP+BwyZ0I2TiZp5r4RhC8T7vybIes91X0tUspdUPN1iRSk9x4wDcRSYJjDEGUrsrWW9wluT0AHgGMM9UvjAmy2lGBkDtJbdgbrX+LfXE8MUTomrKjHTLDjoLBFEa32lH4rxavFNsCuHhNz+VMkwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhcIp7nOfLnYSxM0DjFov1bOpCZ7HRgFZfLZX8n22/E=;
 b=gNXn2Oz2fP4lbmEwmnIKezPw41WkAyt08ufRbHgZ9SFJRVQbUWHC2iiLJ9bQZCw9DOhZ3J15QDXPC2n8gsbH6iHlz+7W4rWGTQGz1QiaT+hvPQGifxq5MMRuR68BkzD9MCsRNa0v8lNfcRtQI7JbO86wFF3kZsp+gIuu9QLBQBCkCYlCtu7ekcH0XqmQlT7facOuBF44yMuL1os3XFzAQqtt+LA+er0rmTG/fcqyWcoQBN1aU4BA4HFOTlKqr7BFdWEMTKCnJo8N6reh9T3sRGI9Ra5xFt6N6vgO+U7xySBCvVTkiB4kooet/kcHI1+bVdz6AXZ0qKGybgv79lxvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhcIp7nOfLnYSxM0DjFov1bOpCZ7HRgFZfLZX8n22/E=;
 b=mld9Q/IEZdj1VSS8zgC3EiGhwU2c1hyA2ZBP60z6xhuRhckv8IfI4k9Ra6lUXjf+ZOLSc2et7E+J8SaNc1Yy73k9LkqAfiZfHEVg6siQ9HAs9V+7ABZ4hmId52k+J04EOGIyj3ppLHfju3BfOVXEem2e5SLqgru0qy5ZmWHNHis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 12:35:45 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 12:35:45 +0000
Message-ID: <b26e9abc-10bb-46a0-be05-d0cd2ce835bd@amd.com>
Date: Tue, 25 Mar 2025 18:05:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] misc: amd-sbi: Add support for AMD_SBI IOCTL
To: Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, shyam-sundar.s-k@amd.com,
 gautham.shenoy@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 naveenkrishna.chatradhi@amd.com, anand.umarji@amd.com
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
 <20250324145815.1026314-7-akshay.gupta@amd.com>
 <c9138dd3-6a09-47a2-a8fe-716c8894042e@app.fastmail.com>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <c9138dd3-6a09-47a2-a8fe-716c8894042e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::11) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 2faed266-70db-4e26-432e-08dd6b999033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cS9XWkRUWkdoNGNUQnB1VytLU0liN3k3dzQ0L0k4b3VFNUxhSVBpdkJOdUpG?=
 =?utf-8?B?VlFvVjlJZzJ0NWxvelVTbzViS0srUFFXZUkvRmMzZmRCQ25hMmw2SkZYVXZJ?=
 =?utf-8?B?dTdtYzFXdlQyMVBQUXQ3UmFiQzI2dEtvOTJGQjFPWGJSOEtYVkIxK0szVmNN?=
 =?utf-8?B?Z1hQZGVRSFFWZU9GQWg1elBjUlpjVm9GTzNSQjdlK0dFQ1FERGhvQkVoQlFw?=
 =?utf-8?B?N1VvS3MvVDNDS2xyeTVXbmxpc3FtRHhmQmkvT3JTNjRQUk9zcXRjWmZwcGxo?=
 =?utf-8?B?ZTRRNEVvMmZKVVZBUDZwampnN29Nc3QvR3ErUzZOcVBLNWZEVmtqTEpOT3Nw?=
 =?utf-8?B?cEd5WHh1aklocGc3Mmt1Y2VDOUVwQVJ5eWNlV3N3bFFDYS91R1p5bjNubE9P?=
 =?utf-8?B?OVhXZE1LbFI2UnVBc0hKc3llS3JPcWE5QWVYOVlMVmMzdjZ2aDBEY3I4L0pX?=
 =?utf-8?B?TzdDUjg1UTIwcXhKT3lZYXNQYTJldmNsU1NZR2pKQWs4bE1BWUxaYzVtUzc0?=
 =?utf-8?B?VUJ6VTdFclFzR25QSGo0UVp4VmJ0WC9CZ2E2SXFCVjczZW5yL1F4MmRFeHFY?=
 =?utf-8?B?YUpPSmRxNzhiZUZUZ0wvbXZieWZCV1VJbk9haHVSQk1aZWFpOWErZnAzWGZG?=
 =?utf-8?B?cEwxWkZYcnQydFE5NW9oeTJ2b0c3cTdUaks3QWxvYmFXVjB2dGxHaHpQUTFs?=
 =?utf-8?B?aHc4c0x6WXZYUGVmTEtvMnYxVFIrVjd2VUgrWnJPOEF1eTE1NGZUSDZMa3Vp?=
 =?utf-8?B?ZmtXdDczaThtQXpwbWhRWHc3WlJCQ1lDa0V5bWtGVTJNaVdCRWkyaHByMi9r?=
 =?utf-8?B?VERFWTRIYWRldm9EbjBNT0NxRXhtVHo3Nko3WmZJeUNxLzVDZ0szL3ZTY3dN?=
 =?utf-8?B?bVdjTm1KbnlDQzgvNlhoU3lrNUZPcFVHRm9lSjlPbS9xbk5rSlNibmhQRHZ6?=
 =?utf-8?B?RUpjdkN2VWRiQmxBRUFPWDNpbU9QUkN3RDR6MEd3R2tkU3gxeTRGRVZ6c1Ux?=
 =?utf-8?B?UnpMbHdJcmZ6R3lpVUhYY2Qya2Jtd3BGRWZxYXpmYzV0WVhOWVkwcElvbHBj?=
 =?utf-8?B?S2RpWnJOcTZHVEhaeHd5czh4MHNFVk9WYXg3VVprWUpvRE5XelovL0FkbHA1?=
 =?utf-8?B?TDlWbkdJd0l0WExxNmJGZFpBaEdIVEl2bURKWUQxSy9Zdy9Rbk9NZzNnbVhR?=
 =?utf-8?B?cjRwMnI4b096dHM1dlk3Rm5RaERaM2JuZkNmbHo5Y05xbHhOME5MVWIvTGxO?=
 =?utf-8?B?dUdrRXdNQnJRV1FlVHVxZ2drblF5V3hSRlprM2NKQjVuRndORUlqNDE5WkI2?=
 =?utf-8?B?YjVVZ0lDNnBxN1NwcGx1bm0yaWR2RHNmcW5pbjEveHRHbEJwZDlqS3llQzdJ?=
 =?utf-8?B?YjBCbWZTRlNEYjE5eFNra2xDNmhydm9lVWJpeHh2aTFuUysvUWFmMkZnSWl5?=
 =?utf-8?B?eXZScDErd1p3WXExNUxGYTlYdnBzVldQMlNyZUpDazFFamtSSjVPQVV1OXVH?=
 =?utf-8?B?bm1nakVDNHdoamZBbU5kQ09iMlpSVnQ1SGNieUpmajFnKy9UOVBkQnhwNHRa?=
 =?utf-8?B?NTRnUE9mc2l6eUJkeU4yQjU1enlJZDVMalVFdVUvQklCTlFkQ1pjZ1lROEQ0?=
 =?utf-8?B?ek1JWjJzbWpGQVlLVFh3TWIvRGVmTkFOZjZjNmxBOUlvM21LT0ZHLzBCVjR3?=
 =?utf-8?B?bHdpLy96L1Avd0xPZTVJOWZaMlJGZDl5Mk8zVDhza0IrRkxVV3p6a1BRZVVm?=
 =?utf-8?B?anJLRXdmNVNXTW1MMmZnMlZWL21JcDNNYlUwVzlHNDdmWGtUOG80ODB1WjU2?=
 =?utf-8?B?YVU3SEd5M0FhVHZSZmdVV0ZkTDN6NzNxeFBrVC9BcUZUczQ3Y1BScDJMU0x1?=
 =?utf-8?Q?zW8gJBbq1fn5/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b21nN3FJS2N0aU56QVg4TkhNTzNTMElaRUVwNWo2UWhOQmM3SnZwbStLR1Br?=
 =?utf-8?B?K1N1V2ZyWlROUGx2U3FWVSs4MThKQjFRNTc1akFIdjF5aThXdWpUa3pCV1Fx?=
 =?utf-8?B?TU1pRzJkcVlkZDlWc3EzR3VIcHR3TnJmeDR2NmZyNmpGVW1SQ1J2b1lxdFp6?=
 =?utf-8?B?S1VZWXJRRXplWjBVcC95UmxPZGRYT2R5NjNqSEVUMTBJRDlKcFVoSWxvRUF1?=
 =?utf-8?B?Z0NuTmI1RUhJRjJEUXRCYVIyOEtMeG9rS2dOMHlzQzNLUDFpcHY1akRFa09j?=
 =?utf-8?B?WWxUVmpHNEhsNHN2K0RoNTFOWnhlNWc0NHpmNnF1Y0pxS2xuSFh6TGhFZFAv?=
 =?utf-8?B?QjVaWVVHSDBxT0tkTW9kb2haNHl3aExVZlJDMUtERVRLdTgreTl0b21RZnBw?=
 =?utf-8?B?QXRQb1JabnBDL1VQZlNXU2hzM205VHg5Yi8raVNUbC85SHNlYWRlZGFQdzZO?=
 =?utf-8?B?dmxuV0JjWU53LzZieEtLQWVVUzJaSWkxZndNbHZqaCtIeDlKeExVcEkySkZt?=
 =?utf-8?B?M0p0TTVta1kzcngwaWExc2hrZkhQbWJuekpyUjlWQmpYSStCU2RzRXF2ZnFw?=
 =?utf-8?B?cXNxOHF1MnBIZzVaZFV3WVU5dWZubWlmN1N6UUp6SGpTMWRWaXJGNWErdmhK?=
 =?utf-8?B?UWIvcEgzU0gxWFA5RTVwMFhEcGtmMW90WlVNN1FmLzJjaVdkYkFObU01Wmo5?=
 =?utf-8?B?ZzY0Mk5LbTJzcWRUSGJuanFlR2g4dTF2RzZNSkcyM2kyVTBrWU8rampZZHV1?=
 =?utf-8?B?d01UV1VPZFAvWEUvVmphUVFBWkxWSEVOREU1MytCcER2NGc3clg2blNrSXVp?=
 =?utf-8?B?VHFLbnZuRW1BaDd6QlhFM2pyQzF6eGE1LzRlL0lpNlAwaFJNek1EcmIxRWJW?=
 =?utf-8?B?cmJUVGhrTlNteCs2WjFBck1qTGFQeE04d0ZTcG5kYnBDd3BOWjRXeWFpWG53?=
 =?utf-8?B?RVJ0Y0t1NEdaenB6RTQ0cmF5aXJvT00wcUhKM2E3R3BDQ3pZZDdyYmNrZTNt?=
 =?utf-8?B?cGNRZHZIWll3Slc2QWZJbmZ6bHg3dlRpNTk3d1dwTktHK1VDQ0xEQ2Noc0NI?=
 =?utf-8?B?REt6V1JQNHdXRTZ2Y1dCOVJEbjJvYXZMb2ZKUDB0YkF4ZFo1RkhFeHpNMFpK?=
 =?utf-8?B?cTBSakxxblMrdG9xYVFiNjI0TnR6Uy92VEZQdTl1VzNuczB0eDk5cUlVcXIx?=
 =?utf-8?B?RzI4WkFtelVvaUtad1owaGZNNG1RN0NOa0Zlb3VZVDlZODFIMGtPYlhkazBG?=
 =?utf-8?B?dUV3NStCT0tDcGNqU1dQbXBLcFNKaFkzcHhQYlc1TVB5YjR5N2MwN09hUDlY?=
 =?utf-8?B?Ynd3NklLcDZYQktoZWVaaVVmRHFKYllvS1hYY3o2MU12amM0cTl6ZU9SNHUy?=
 =?utf-8?B?bE8zRVZKMUpIclNTSVVYeE5xbDlORnZjT3RYSE1TbXFyUDVnQ2NRTXFpSVFS?=
 =?utf-8?B?K2NnbTQwaHBMSmtqdzA1TFJFL0pTNk9ZMWh6V1cwdm1XMStOVkpEY3NScisv?=
 =?utf-8?B?YUZOaG9tQjZzU1g2bThRS2NvT0pWNlFKQmtOYlg1MzR6ckVsQWxPakdrSmlS?=
 =?utf-8?B?bWFORkx1aWRpWXdVMk9mNDA5VU9JNXVPYVdGUzl1dFFmQjc1MnE4TkVZc0Jh?=
 =?utf-8?B?eXRNT2hvTThaREtHak5aVVVCOTlPVitWaUJzWm51YzRHelVaQlYzVldPd2NO?=
 =?utf-8?B?WjBGa1ZxdG9CSktlQXdmLytrbVNrQ0dXMkcxRHhCcUM0dHhvS0Q5NUcvRmUr?=
 =?utf-8?B?QWU2K2xaRUFSV2wzelo4SXcycGt2SllSK0owZlVNS25RSU50TDgvcXp3QTRa?=
 =?utf-8?B?cG5yNGdzdi9ESXJSQ0pVWGwzZnhvMENkMW5ZUDF3UklVSXM0TEtSSzZTUVVk?=
 =?utf-8?B?dktQUVY5T3hBdzFJSjFHeWFNcFcyY2JzV01HNXZRdGM0NFdQOXp1L0NLSldm?=
 =?utf-8?B?SWZ1N0xYMWdlM3dOdFhNZmphcXh0M0dZMTZlbjdrRWUrL0NyRXhWVFRBOVhl?=
 =?utf-8?B?a0ZZZ3Q1UUZ5V0xleVpxWXpnSDloendDb21aYVZkWGlRSDhNYWlHNkN5aGFC?=
 =?utf-8?B?bWVIT0VkNDIyWk9JQ1UvL3EyWWVDZ1pBQXFzUXIxWFpiNVlYdXQxK0Nlc3FS?=
 =?utf-8?Q?CfBoRPqej7rnrkMfYb7xeEqlR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faed266-70db-4e26-432e-08dd6b999033
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 12:35:45.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3bywudPgqAfeG021x8pKi/HZBLTUB1sW4DmyGBmubGLagoDGWhaCr0pvOd0Wn/38cMpuALOUPVDruu28ioDPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446


On 3/24/2025 9:10 PM, Arnd Bergmann wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Mar 24, 2025, at 15:58, Akshay Gupta wrote:
>> ---
>> Changes since v5:
>> - Address review comment
>>   - Address Arnd comments
>>   - Add check for cmd in ioctl
> I think you missed one of my comments.
>
>> +static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned
>> long arg)
>> +{
>> +     struct apml_message msg = { 0 };
>> +     struct sbrmi_data *data;
>> +     bool read = false;
>> +     int ret;
>> +
>> +     if (cmd != SBRMI_IOCTL_CMD)
>> +             return -ENOTTY;
>> +
>> +     if (_IOC_SIZE(cmd) != sizeof(msg))
>> +             return -EINVAL;
> You are checking the 'cmd' argument to the function now, which
> is good. There is no need to also check _IOC_SIZE, since
> that is implied by the definition.
> rue;
Ack.
>
>> +
>> +     switch (msg.cmd) {
>> +     case 0 ... 0x999:
>> +             /* Mailbox protocol */
>> +             ret = rmi_mailbox_xfer(data, &msg);
>> +             break;
> What is however missing here is a specific check for the
> individual commands: I don't think it's a good idea to
> treat all 2458 mailbox commands the same way and just
> pass them through unfiltered here, and I would also not
> pass the specific 'cmd' as part of a multiplexer structure.
>
> Instead, I think there should be a separate ioctl command
> for each thing you can do with the mailbox. From the existing
> driver it appears that these are the commands currently
> supported:
>
> enum sbrmi_msg_id {
>          SBRMI_READ_PKG_PWR_CONSUMPTION = 0x1,
>          SBRMI_WRITE_PKG_PWR_LIMIT,
>          SBRMI_READ_PKG_PWR_LIMIT,
>          SBRMI_READ_PKG_MAX_PWR_LIMIT,
> };
>
> which is just the first four out of the 2458, and clearly small
> enough to justify one ioctl command each. I don't know what
> the command specific arguments would look like, so it's
> possible you may also want to define a separate structure
> for each one.
>
>         Arnd

Link for the documentation: 
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57883.zip 
<https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57883.zip>
You may refer to section: 5.4.2.2 SB-RMI Mailbox Service
At present, more than 70 mailbox commands ids are supported.
The number is increasing with each platforms.
however, the input and output for all mailbox commands are maintained as 
32 bit,
hence, we can use the same structure and differentiate the functionality.
As per current AMD's implementation the maximum can go up to 0xFF, I 
will update the
case to 0 ... 0XFF


