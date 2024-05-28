Return-Path: <linux-kernel+bounces-193104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AAE8D26D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF492878D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB82180A78;
	Tue, 28 May 2024 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GQ2qDn6+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487817F376
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930524; cv=fail; b=BGJlRgYmN32yUWh1QYsH1IDtmXCj4Nvkmkovv8fdx2p0nemH/QVV6zODsGfD6wSxmegULVn4LXwDuX1Fxae+rjN6u6A0sE3R8mRHgmJg2kE3Ne62D2bRDFMhRXBrjmrDYXANksnK02U91I9o1jjUnWoMoQ76Dakv7yOwkvvygic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930524; c=relaxed/simple;
	bh=JFo7WgkUrCFnpsLRdviCP9LXr35w+BU4LBFbAGqq3+U=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=YMKdVbnBYkiXT5ys27VTS9QY1rOECvW/WPZ9KbnXE25sk58nvKqYZ7tYXckBFPB5MhXPYcn/JOjfonXE9dZ1cwkhzxA7XsLz09oH1nYZrooVuwA61hcyUNyfb7Ty3yGeNhmgNMHxU3kgR7IMlE8Oq5IDINGrWctxkaP1j4QnGOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GQ2qDn6+; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqKIWppDCY1wLunO7acSVCocwBYGOmL0KVrwbHDEx+hVibUS6PbO8vK9RuSOYU+dPzmLhGvmrR+xAf8kNu6Zf1cyUEa6u3WM062inlt3mywNT6nZpv3Aa+erlR7L322sFYlXymLolA8A6NCEBgNumfHkd7geTXGdA54WwmGDhzOQXUHrmY20mH0UUFuJN6vtY/6ihlrlGZzTZ1uD47YPtLCRq9Oug5g4o0qs0Ul/9wVTJiIyXV3iDx0nLM5xUv+7hoss0cmf6VHTVlErsXSupEmHIYZcenFt6Xn1znNSXFwmYSpJan/eCWTtaktNcjvI6QAenfcsZ6uYlSs5lCZwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+t/iE+uMtVJibx6k6FpKgetzh5oAEDtExhsjYNv6lA=;
 b=BZuhpUDiXhgbH8ZPdMcXNrrU6x7UvF0yyf1B+V98oDKhGHe/nzNBcYw1QOjxJnFSd4kovY3boLAv7SRjd235sXySk6iztW+8MkzxJjP6O1GsiPhJgvG4gBYRymun1ZJdd7eTPd5Apgdlgfw9hK2QA95ja3iLivb+9r4n9GHm6UR37mhg17E2v8VB1ga0aaThqE9js6QOGCQzPvzCdY5740v9duI9a27eh1+9RSZ12+/CHhi2rji5IBx/wMXCT4xSnJlb9vNM71joIiPWlNuL70FS4nmua6wPvY+bxXHG0reqy0Lvzg4L+Az/vWbBSzM4/vy6XQ4Wbah4XOd2I8TzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+t/iE+uMtVJibx6k6FpKgetzh5oAEDtExhsjYNv6lA=;
 b=GQ2qDn6+X+2FNJ1c+cA9H/8sPCYq1IwdKJX/99caknugkoGv45eN2YuM5sfh6IIKrG+dCu+hQuo5O4Pr0kO+oNk4jjJt7AzAe82a1Fuefol+au0g9jTQ/MQuRvxORA1KDLZlzzrTDJ/dFgilwg5UnHQkPi4h2uVxAHcXEIpjutk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Tue, 28 May
 2024 21:08:39 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 21:08:38 +0000
Message-ID: <e7c24be1-dbea-0efd-2661-b626fd655478@amd.com>
Date: Tue, 28 May 2024 16:08:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <435f78e07c76e25d2d857138724098bc2a729b0a.1713974291.git.thomas.lendacky@amd.com>
 <20240527135101.GBZlSPxQ6iBSlMDefY@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 09/15] x86/sev: Provide guest VMPL level to userspace
In-Reply-To: <20240527135101.GBZlSPxQ6iBSlMDefY@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0084.namprd07.prod.outlook.com
 (2603:10b6:4:ad::49) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 1800786c-2229-4338-d0d1-08dc7f5a5831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzEybnMrS0lHSGhMUjhkU2xqZ0dqQ3ovcWNXQWlETTNCNlNCTWVjR0xZWlgz?=
 =?utf-8?B?alhVeXcvRkxnL3pKYktzWDMvWDZIVzlRY3plaVJXNnFXdUcveGVtL2EvYVhL?=
 =?utf-8?B?TVpJaXBzZzRHdm5hb3VQWjcvcVl5RWhlYkRHalRBTDhpVWEwdG9tM2NtKzFQ?=
 =?utf-8?B?SnVCSW9WbTNTVDVCUHl5dmVIT3h4TmdNbm1oZ0d1cXNSWmpRVFZTd3owSkdS?=
 =?utf-8?B?ekZEWXZjbjloVkVvdVhmQ0c0a1FnMU4wOGRlV0hnWUhneW8wbWx2djhjVS9O?=
 =?utf-8?B?aGNvbXZaSFhOSFEwK3czbHorMElRRXNETlRHamQ2anJZd2JnN2FMT3J2dVVQ?=
 =?utf-8?B?b0U3V0hKbHFBTWNuMFJlRm12SDdQS0kxMGo2MHdjQmJkVVJ1UTZOb2M1NG9D?=
 =?utf-8?B?SEtqVkYrU2w1aXE0VWNKUDY2eG1KVTJWWVpiTm0vc1FhejVEY1pKTG1HMnFQ?=
 =?utf-8?B?cytBNC95WTNUMnUzcDVwd0k0SmRqSXZYUHZiS1FGUm1FZGxKVjBBY1hVNzUx?=
 =?utf-8?B?UzllcWFrYXUyWWpuRVlJc1lEcDZ4Ti9udS9WTUcwQmo3bFFvY2QxQ0RBKzVK?=
 =?utf-8?B?UmpPNjFKN2NEWDJYVVhraU1Yd3M0TnJxWkFQbWZOcWxVRVJEaVhqWVJIQ3R2?=
 =?utf-8?B?VTJxNVpwVjBSNEVJSEtZbHZmUWxmOThLSGdrOWNqTWJmTHNiVEJUMGw3L1BL?=
 =?utf-8?B?eFk1anUzK0ZhQXZDL2J5akx1bDMvYVdUc3ZlTTQycmJieFpRVFVMMG1NbzJY?=
 =?utf-8?B?eUxLZzNER3h2UlN4UDZBRlI0VVN2VlNvT1lzNlpIc0dDLzNERnFnOG4rQmdM?=
 =?utf-8?B?REpDdVJPaHFTWnk4aFU1bDVVd0hBTS81d0tGWml5ZUxhVjVWQUN3bkpTZVA2?=
 =?utf-8?B?ajd3Vy9ZZjRuQ0VzRklsNWNrMDNrVTRmK2g5S0ZBbkhoYzBKdDBGcU90NStF?=
 =?utf-8?B?dXprcHBiMTE5NUI4WUY0Q0M1aWJyT2IxQ2puQ05hRU1JdEI3dFBNUjhoM3di?=
 =?utf-8?B?WGZXNHJYQmRsa2p0dUVBVTUvbENUa0lQWHFWbExhTTExU3pFVUdZVlpqMmhW?=
 =?utf-8?B?am5xUSszOHdwQThSRVE4Z3pKMnQ1WHE2bjZzNTV1RmZtRENGNWNFV2I2RmpG?=
 =?utf-8?B?YkFSa2IxNjA2clRyOGlQVlo5U3BBd2lHczZqdGlybldrL1IrdXJxN2loUnIz?=
 =?utf-8?B?NWozbXJFTGhHZVpiK2F6alUxU2ZnV3J3ZHpnOE5CWjZtd2ZtTXIreFhBK3hK?=
 =?utf-8?B?cVhhNERRWE5icWFESlI5M0w3U1g3ODNrNDNmZkJxRFpqaExtUnhoeENMdkdl?=
 =?utf-8?B?dnd1Z1ZJd1pGVVpZeU5FZnd3ZXZnbm90K01lbk5wUWRJVUpJU0lSS3hEbFVR?=
 =?utf-8?B?eTdyTE04UCtqaHlZNmdHT1BpaEFXYi9iWkhGYStWRS9FWitXcnBMMkZtSWJz?=
 =?utf-8?B?WnRZaSt5V3JIMUFHUzV1eEtKdGR0dktCRUxoQUdwSVJ3REhQWXE4YWk0Nld5?=
 =?utf-8?B?WUY4OWNmK2JKSEtrOGxiUE0yN0ErUWpMN0F1d2hBMTVLZmJza1lZTG16engy?=
 =?utf-8?B?TU9XZkJsWGhjU1E1T09hNkZDK1Y2Zi80Z1ZuZUQ0VTlqdXdmNGJTYTFXV2pM?=
 =?utf-8?B?dkZsSmlJZittcWxlMGozSnNyWUJqL0N0dkJ2V01vY2ZuVVVOUklrVlVCa2J4?=
 =?utf-8?B?dkRnaEtORzlBTzdNdUFKSnBSeEZvK1VjTE14SHpvNWRoMzBOM3dRekVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVVYallySWFFc3JvUWpuNzlXVHA4aUFsZHd5UWc5NjgrNHRsVURQN21IWHZ6?=
 =?utf-8?B?N3ZvUmJkdE93YkZzN3BBQkZpSmVNVHM5NXFJWU03aXlPOGdtdzF4RzRKWUM2?=
 =?utf-8?B?ZEdHamdvNDh6bGR6MW50a2hkTkRxdFVwb1djSmdmOFlwMm96b2ZKV0lkMU50?=
 =?utf-8?B?QVNiSjR0VTdyY3h4V2RZZkRwRVQyUVY5dW9sZWZIMWVSeEtjL21la0xqTVl4?=
 =?utf-8?B?WXE5R1BQTloweDZtc2NORUR3QTkvRDNyZTdrL0l3ZXdGbmc0UEt3U3QrdnZH?=
 =?utf-8?B?clNHckJhV21DbDdzZFZuemF5ajMwVlp3Ui8zQXZzK1FmaDBDZlJRaHpQYjhE?=
 =?utf-8?B?M0V4Zzg3bXVETm5CWnBGTUhYMVFLdVc5TDNBNGMwNDFrWXRHc3VGdHE4cUY5?=
 =?utf-8?B?YVkrTWEzRXY4ZlA1ZWViZit5dTh6RVlaMzM3UzJkK0c0bWtQRzJlZW1XdWZE?=
 =?utf-8?B?V3JuWlkwZmUyWnBicXM1ZWJYZmkyRVFyZE8yZlRKazRodTg3cWtwQUVWK202?=
 =?utf-8?B?bTlpelpqQkFoakhFL1g1cWZGaE9MOGZTdkQ3YTRPNkpXZlZDMDlqViswanZV?=
 =?utf-8?B?V2JFQ0lkdjZUa1JUcy82OWJuOXE1SjZURzJHa3BXYXNYS3FwbEF3WUlnU0Yx?=
 =?utf-8?B?MmR1MEl6ZmhSRERUa2dnaUxiSSs1M0ZXVGU4UERDUENRZWhrcGJoSTQra0pr?=
 =?utf-8?B?N2hralN3Q010WW1Sbkk0QkFNZm83aXFMbnk0N25HWlNsd2RPZzBQZW5aamRG?=
 =?utf-8?B?eXdjQjhuRDhmWUhtV0F1L2p4dHNIZXBOQzRieXZwSW9KWEl3enRaT3Y3clFh?=
 =?utf-8?B?RHMwZHplSmdMQi9XaEhsejltWkxWRjg2N3pCWlA2WDJYb1dCeXJFYUt0SFJx?=
 =?utf-8?B?R0VjTmVieDNiMm1ValBrYlo2MjhoN3hkVVJiSSs3VlVpUElBbzdyZWhKRHJq?=
 =?utf-8?B?OUJJK3FUdEhDZGtFMlVxMDdhV3pYRjFwamN6NDU4b3pyMXNFUXFHUDhsRkFw?=
 =?utf-8?B?WHBsQnpKcDFiekhqRVVzSEFYbGVnRllwZlB4eVNpZENrcDZoZk5UQnNlTDQ0?=
 =?utf-8?B?RG80NVBmVUd2SU4xS2dnYlA2eU42a3ZVT05qQTZqMitub0F5d2Z0UXVCV2Mz?=
 =?utf-8?B?V1hVajZKRmpXUkNSNC9OckE3eVIra1FGWC9ycjN4UHBuZ0ZUN2d3NHV5ZVB1?=
 =?utf-8?B?ZWxpMnMwVEdLbitLWlhmVzhTQzQ1QzcxTS9sb0FvYjBZd0tsUTN1UVl3Q3l0?=
 =?utf-8?B?NmV2WVRpZDJQUmMwZ2pyWm5XenM0cVNUVmdtMmtsSHh3NzNOUnE1UjV1aHBW?=
 =?utf-8?B?dkFWUGd3T0ExOUdVdTlyYnBQVk1TNVV0dThwMkx4c09GaWZaMFVHM3VtMy8z?=
 =?utf-8?B?TUx3UWlpeFVPdkkvc2s0UVdJTU9QcEtSaVU5MGo4dUo3VjJBbTRTUFBTY3po?=
 =?utf-8?B?cG5kV0ZCV3ZYOE1mVk5MMGUzK0tlNURXYVZ6S2VGUzhERit3WVBnTTFYenAw?=
 =?utf-8?B?dkFjdmFlei8vdUhLY0o4ZDRJRjhaK0VKM2kzREFHbHp1bTdSQURWOGFvZ0JE?=
 =?utf-8?B?YWN0WUJYSWcvbzM1Umhrbzh4M1A3aU4xUU43eHlCWkNNdThLTFdKakR3a3Q0?=
 =?utf-8?B?S2xQOURVa1Z3eDdJekZYaEg4QTIwa1NyZ3R0Q0JoQ1hiTlN3UUs4Uk5NVitv?=
 =?utf-8?B?dng4R1lFTEVrVTY2WXhLOHRzaGtZMjRXdmtSY3ZOZ0ptcXJNMTNYQW9Udjds?=
 =?utf-8?B?ZmV3Y05GcUp5NVJ3QmJOM2N5bjlzeUwxUE4yQjVQVzdEQUpydkwzZlJ3czNy?=
 =?utf-8?B?YlZRUnBtajJMZjdacnlVd3N6R0x3OE15NEZhU08xWnM1d2kzLzhzSnVZZ2ta?=
 =?utf-8?B?amE5SENEUG01STYyU0RqQUh4dllKR1NJM0o0dVFFT2ZMWWRIWjBrbE1LNW9m?=
 =?utf-8?B?dk9MRklYQUo3cWMxcytjZm9mR3UyNVd2WUJJUitKWDE2UCtVSHRSR0pWbzhR?=
 =?utf-8?B?WVUvTW5SU3QxS3dzeVBTWE1zTWlOSFBQTXd3akRjcGdmQW1IVlRlSXJpMGJZ?=
 =?utf-8?B?WmZOdld5VXZzaWNWMG1kbU1EUWxra1pzdlFyY1pSQnQrMFNoUWZySWpibVJ4?=
 =?utf-8?Q?AOfLBMvbrOxJVgl9Gmclw4Ux7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1800786c-2229-4338-d0d1-08dc7f5a5831
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 21:08:38.4342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUqAM+sqPId/DLCi72gE5QfVlQyqbvcDfA0q+XxnwPUzp5o6QzTMDk9PrB4nL58bu7qyRvLru3KpOaWmt0Rtpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849

On 5/27/24 08:51, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 10:58:05AM -0500, Tom Lendacky wrote:
>> Requesting an attestation report from userspace involves providing the
>> VMPL level for the report. Currently any value from 0-3 is valid because
>> Linux enforces running at VMPL0.
>>
>> When an SVSM is present, though, Linux will not be running at VMPL0 and
>> only VMPL values starting at the VMPL level Linux is running at to 3 are
>> valid. In order to allow userspace to determine the minimum VMPL value
>> that can be supplied to an attestation report, create a sysfs entry that
>> can be used to retrieve the current VMPL level of Linux.
> 
> So what is the use case here: you create the attestation report *on* the
> running guest and as part of that, the script which does that should do
> 
> cat /sys/.../sev/vmpl
> 
> ?
> 
> But then sev-guest does some VMPL including into some report:
> 
> struct snp_report_req {
>          /* user data that should be included in the report */
>          __u8 user_data[SNP_REPORT_USER_DATA_SIZE];
> 
>          /* The vmpl level to be included in the report */
>          __u32 vmpl;
> 
> Why do you need this and can't use sev-guest?

The vmpl value is input from user-space.

The SNP spec allows the VMPL that is put in the attestation report to be 
numerically equal to or higher than the current VMPL (which is 
determined based on the VMPCK key that is used). So this is to let 
userspace know that it shouldn't request a value numerically smaller 
than what is reported in sysfs in order to avoid failure of the request.

> 
>> +static int __init sev_sysfs_init(void)
>> +{
>> +	struct kobject *sev_kobj;
>> +	int ret;
>> +
>> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>> +		return -ENODEV;
>> +
>> +	sev_kobj = kobject_create_and_add("sev", kernel_kobj);
> 
> In the main hierarchy?!
> 
> This is a x86 CPU thing, so if anything, it should be under
> /sys/devices/system/cpu/

I can move it there. Or what about creating a coco folder under 
/sys/kernel/? This would then create /sys/kernel/coco/sev/?

Thanks,
Tom

> 

