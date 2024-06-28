Return-Path: <linux-kernel+bounces-234576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 511C591C830
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31C81F23951
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819B78C9D;
	Fri, 28 Jun 2024 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F08qfOQq"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599677441F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610585; cv=fail; b=R9muEEOvwRNx4FRWVO74PR0DxRgb2SOonHl8orWK+2NtyIgtpe2/kNmfuT9LGizRlvpcLDJEQTY1645j2Rl4ie1BVoMXi+IxE2JLsKJ4+tBRwb2MRu2658fJNOAdNCr7lsUdzPvwXqAAsKRy1z9slZ6rEQ+cDAHHPlxPxmA7E34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610585; c=relaxed/simple;
	bh=Bsk0oP3AX5FCk/8UixkB9ywtgzEzT3t1w5ojlzuFPHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nYA2fSIYB3uFvYwxmYCXbgAEQ8YPkBIqw1YPUGU9NyRENDM3BBR424bhe5IPVZyG9OidjFMFTXVkX6wSh37kHc3o3BuUtGWDjedrA6hV4/uu2L0mGNQo7jao96wyPg4dbox82mJ3OgPhHVBEhdQHfSahblVLHX6OdTbUquA515w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F08qfOQq; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4A6OFbVRMN2rM2c8P+40b2dVEdkUrBDiZEHhFDyGfw5ll0ohvA6lztn3tV0Ue6XfeFoHXsnZA3Fw/cMOq05+QgJd16L962xiFyKX0LgpMae64BgiHOpQhxwgr7cNiRqUIg9pUbWhFdARPzc8BrRk0kjmf7Z3FCUB93tmJVhZ/H+Ypa7KhkpuNWB7FaiShU9QS+2fYId8babCAOiRgXRjGDgR6m1nDRPy8HK1+/cnnR6kQsiS9fK6WXkpDDucuCCjSqunBflocuwXpG4QT/OcrxfR5PzChxOGX9wkdQFFhVx/jqIlMVCI0pr6dGb6FnwIm3xYjUOUBY734xZMo1G8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBj0+8jSD2wWhYXD+QW3F6Gf0I9Z8KZKVwjy4dRjQRk=;
 b=NYEY4wm9kUIHZ/W7cPwtsQ3U9N6ICK5IzHWwqp/Ue2eaTVValnsJnOx/cbitNNlnvMgmyXw3c/Ffl0tsviEj/gc2r7yNMDBrL+YwTvqqNVwZgr+UkWFuXH0rnEFtMyARRy5Xexoaz66Guoc2T0MGtEAM+p3ijoz4Z4901Dlvt9SRgF4aBCjYXAYWJeQPLqfmvBtWaCE05GA6A6BYFzuCl9Ti7hkKbz2RvUsh0uisWHmIz7uyf3fJFufkSPEd9hd6grgDr6PS89Ev7gqFvcyORHBAGKPV2qyshmlXQEgJ4Z3OmnsHV2BCLOd2IOh4ieAlc5t9MUNg7Q6CL6/jXOL8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBj0+8jSD2wWhYXD+QW3F6Gf0I9Z8KZKVwjy4dRjQRk=;
 b=F08qfOQq5ebGKPT32XrzaeCt1plXqRfhdeMpA+pc7heWOmHpSV/yS6GuNXe0KYQsD9caJOqcYVw22/U5DyrWeOyyb0QnjGfwl6HdSyrIAen5NxsjdL8ZMXN/kCvjj3kxx3zIPbf/Wz1TUrQqsjoKQLOsvv9jsU2SOAnBs5yYXk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 21:36:21 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 21:36:21 +0000
Message-ID: <e633c592-5513-bf5e-800d-b92fece86c33@amd.com>
Date: Fri, 28 Jun 2024 16:36:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>
Cc: "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
 "Rodel, Jorg" <jroedel@suse.de>, "mhklinux@outlook.com"
 <mhklinux@outlook.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
 <fcb19e22678d126f9c4223d1e80f8c7d27e22692.camel@intel.com>
 <d24f7bae-9581-4d1a-ae05-2fede38b5e1f@amd.com>
 <0226cae0f31c4e1143bbe1e3ac49b67bf101576d.camel@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <0226cae0f31c4e1143bbe1e3ac49b67bf101576d.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0176.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::31) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: e5420a07-fc59-4ff3-f380-08dc97ba5a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTNYVHJkSHBaNHJXZEdYOTNodnBjYXZ6UGFkcVB6RjI3MU9EMkJ5cXNiZUFs?=
 =?utf-8?B?bjJSRVlHb2oyZ2hteTdMUkJJd2dsSGJhcFpIb0cxTlQ0N2JVZWJGbFE1Nnpo?=
 =?utf-8?B?Sm5TLy9Hcm5wL2U1ck1BemtrTnpmaXVJWVhSUlJUa1diK2RKNGJYc1N1YWdF?=
 =?utf-8?B?VkFpSnJTR1hUcmNxajJ3NG5CbC92SWZVQ2hPS1ZlcERoaXJkMUJEeEkxR01F?=
 =?utf-8?B?MG9BdDBIMWh2SHhRU0sxTWFidUdrT3J2S2hRQ2JqRDJLRFdCQThaZFZwblZl?=
 =?utf-8?B?Q1dqVkpTd0VGYmR0R2RHOHVuSVV2YzVPUEttSG9oaFZPK2h6LzBOeEJSOW5o?=
 =?utf-8?B?VDU4RXlVSTZjc3lnYmU3eU81cngrZTRzaVBPOWk5SlRDOVh2ZUZQUndxMkJa?=
 =?utf-8?B?ZDhkNzdmTHA5WjRUMWVpY245dHJDNkRBMUFrZjYzUUNtemlBY1pncTZwYlhX?=
 =?utf-8?B?SW5rM1NnWUtxVEh5NDkwdkJTOUJkVDZiOWpxQTZ4REh0MUlib29sZ1VkRUwv?=
 =?utf-8?B?ZFZpSGc2QzBMRE5VQ0p4Ti9XaTBaVDVVYk5QcnJDSjhqeDVoQ1FBaVd2V09N?=
 =?utf-8?B?c1VtZFp5WkpTVXlsUDIwK0pNS08zQ0trQ3JHZ3VjamxsUERqWW5WQkNjREVp?=
 =?utf-8?B?RjE5eFVBc0h3OVJxQjNIQlhZelp2THlQU0pabmE0Z1hobGdzTG1vRjJBcWx1?=
 =?utf-8?B?UVJDeVVMNER3U0x6ME1qMXRub3AxU3hBYm44aEk1aVRQaVFFTEhuT3dRWmxT?=
 =?utf-8?B?NGpnTzh5MUxQTTFCMDlNY3pnVFZ3WkJVVCsyTHhsTERQSnZYRllHckRlSnls?=
 =?utf-8?B?bzV3QkRJSG54MnNtN0E4ZERMYWV5TXVReFcrazdKeWlxQnZkTEcxVkFSemxi?=
 =?utf-8?B?bW1RaU9LS0ovV3dQK05qR2hINHBpQ0VRL2E5eWJUcTBuNzVweVh6N1ZEdUsx?=
 =?utf-8?B?MmhGSjlrckhKajlPbml5VjBSRTlMV2VkbFdBc0FMOWxORzFrM2dXWEJhRzFy?=
 =?utf-8?B?WWtNV0czUVUzZHBqU1dGYWpKL3VlblVDbnFSVmdLcDQyYXlRaHllQVh4dUkr?=
 =?utf-8?B?eGZ1VGxmaGJqd0JESUZ1YUExZk1lOG91dlkyenh2OWhyUGQzS0NuN3Jnc1A5?=
 =?utf-8?B?VUhwdXNkYmVDZmtUVUZ6RXBlMUc0d1dWbm84SGx1YWk1UmdDSWhWS3pydXZ4?=
 =?utf-8?B?YjJTSkg1dlRUand6U0xuRGlVRDBmUy9GTDRCaTNoQSs5VWhKVGdoMFpoTlE2?=
 =?utf-8?B?aHFuZjZxVExFeUhmQVFkbHJMa09IQkhrRk5wY1N6aTYyM2c3TThuN3AzS2pL?=
 =?utf-8?B?Q0duYnRGNDlmRURDRXlDb0tUM3kvTVhkWEh0eWlWa3lKQU8xODBCVk5IeWdW?=
 =?utf-8?B?YW4xRm9qQktid3d1Vkl1NlI3UVFQTWs0elU5TlkzL3MvWFpxc2FYb1N6dUZD?=
 =?utf-8?B?ZVcyV293UU92NGtzUUkzYUQyUTVHZzcwSmJMK2UwSGlBR3ZWeW1DRHF1T2RK?=
 =?utf-8?B?ZHRTOUdseFMrTFA3dE9HRFpmbGtVRS8wQ2RtajJLYVNrSXdQSitJa3ZsL3Uv?=
 =?utf-8?B?QjU1K3JieUFpZ3RCT084UzFZRFFFRGdub3ZVQW11ejNFZHJnUHIyWTNZK0FW?=
 =?utf-8?B?M2ZHZXZKWjJzbW1sbWlYb3Q1azU2OC92Z0E1UTlHeFlGQWpVZjFWclMwWTdV?=
 =?utf-8?B?S0ZrQTVFYnZTLytUTnJ2TnF2cHpnVUZoTFY3Q3ZSbFZJOFVYNkRlSnplNHRj?=
 =?utf-8?Q?toxWsd7UQcEbvUm6o8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFBOK1prSEs2ZmFOZ2VRTy93bkFjQW5QZ2JQODNaWUtxQVVRVitkWUt5ZFZn?=
 =?utf-8?B?SUUzZEhXcndLQ0IyWThvODZneEVMQ3BHb3FVVXo2UW1mRTVIT25rN1FzcXhl?=
 =?utf-8?B?c3dvdDliNjA4bUJqVVFhM1drTlZqZ3g0TUpHNmJuMUZnQUZ3Z1pUekhXdG5P?=
 =?utf-8?B?L3Q3OXBvekE2SE4ra3BnSDRIVDJEZVNxbzgvYnFKTWZxWXZETXFPV1hPUjh0?=
 =?utf-8?B?RTU5SHcxR2JJbHlndE5sUitjWkh2aXl1a2E0VUQrb3NlUUNweUM2US9SNklU?=
 =?utf-8?B?ZGVHUTdCVUhYV3BWcnVNckpTNmhIRHRha1RTZWtVQkUvc1ZNU05lN1JYeG1D?=
 =?utf-8?B?OTg4TGtrQzBtYXpiMElFVXhZUGhuaW5oNzU5bklXQm5TckN1S3I2TVduQTJ4?=
 =?utf-8?B?RDkvd1ppcUMyMzVEbjdRdVRFSWY4TzJJQ0RuZGFSVjhhZFBrVWhHbXh5aUh0?=
 =?utf-8?B?U09TOTB1YS82WEZXQVhyQnpCczBRN3NhVHZGekYwTTREanFkOWFVVzNGcTBt?=
 =?utf-8?B?cUxXeXpHZHZYQytDVFdWdWNsSGk0WkxWZWsxL3BGakh5QlZLN3I5TGMxSnht?=
 =?utf-8?B?WU5UZGNIaDdnNVM1ZlpHVnU0WUcyTHg5NzhWTkN1OGtpTWg4N1VGenByNlNp?=
 =?utf-8?B?clJncnN3ZFhpdkg2NXZFWUFlazNKMXpYNkZzaTZZZ05hVTJadTh3aTZ4ZlJM?=
 =?utf-8?B?R21uWWJuc09lRFFRZmRDNnBJRlBiNTNXbXN4SU1aSWIremJIaHRnREgvRmJs?=
 =?utf-8?B?ZkdCMkdzNEdlVlNha3FRaEpYV0xDckZZRHptckJQUVRYMjJLeUN6ZHZ0TGZD?=
 =?utf-8?B?VHFxQUJrbVVHOEZPZ3JLaHBwaDZFNW5iZm9nVTdLRVp1ZkRNNUxvTHdQL0Mv?=
 =?utf-8?B?a0FQUkFrb1N3Ym5sRDNHRTBWTGRqQnNCS2txdGQ2RklDdWpGeUc1N012bHU3?=
 =?utf-8?B?c0lwTnlIdXFQeS9KeFkyWTVlZ3ljMXJuME5jMGprVFlLVkRwcmF4d1loUUFY?=
 =?utf-8?B?Q0txaTdzU3ZJZTJvTndObk5qL1E5UXgzMDZxUk1ZWU9wSUZxeTlUdFoveFFo?=
 =?utf-8?B?Q2hRMWl0Vm9sMGhJSFBhTnlzTFdPQTRnM3BBQmN2WEJTZ0IvdzV6U1dVN1NC?=
 =?utf-8?B?N0prZmxSa2owNEcwOHR0SXR6eTB3cTVjbUNSQVZBZlF4MEZRSWEvWUN0eVly?=
 =?utf-8?B?YmRVb2xUdEV4WWhQQ3c3eGVtN1FZaXRhYUJSTXBRZlZXbE1YTTQvQVp5TVUv?=
 =?utf-8?B?SUpBQWp4di83SXZldnFjaFhvb0xmVTN5Njg4cG4xN0J5N3NXb1NaeVVZN2lH?=
 =?utf-8?B?M05UcUc2Qm8rS0dCaCtJTXEraDE4d2NTMENDejhPTER2T3Fqdjk5NmlrYis1?=
 =?utf-8?B?c1NybVBzK09rdlc5NEhrVTladDEwcnRJWEMyTDBVeEtBSFc3eExRMUZnN2Qw?=
 =?utf-8?B?a1F1YTRUa3d3Y0xNbEE2TWlxblFuMHZDVWxQVUU4b3VRT052b0UwdGQrbGF6?=
 =?utf-8?B?RVBhL3YxRXFEZi92bUpLcXZTQ2VRN0JBd2NyTmJIZWZvYmhrc1R4eUc0aGp1?=
 =?utf-8?B?N3h0UzJ3aWl5WE5nNUU3dHFEWHlGS2lEQWdGaWdlcjdPbzlWdDlEUzR0VzlR?=
 =?utf-8?B?aFFYRXY0c1RNSitTN0NnQlAvdzd5bzZFK0hjMCt4TDl0bkR2d1dLM21rZWk1?=
 =?utf-8?B?VkxlK0FncHZnci83emtiSTN0cnhLWmlDVHB4c21CZ3FhcU9OSlNHQkc1T3BJ?=
 =?utf-8?B?MWFmbUNLWEZMVWZrQytvaU1SVEdQWTdtV2xMYVBTdmNZT0NiR1Yvd1lDN0sy?=
 =?utf-8?B?R0ZJR1ZXcjI2d1lpVUhZbDRUY2ZKbnpUcS94MVdlekZBWnBMQnJwYlBubTc3?=
 =?utf-8?B?UDlzLzkvaE12bDd2dGFtd1h1UFh1cVhMM05iaEVUbWQ3UTFZSi9iVnl3V1l5?=
 =?utf-8?B?WkJDMGlWUm1CVEVwYjN0R3UxU0l6RWp1MlNvcFRuWFJ4VUxIamtDOGhYcE1I?=
 =?utf-8?B?LzBXQnZVZFoycTYyQVFsbVJjalZURUgzNTFnTmp0MXJ6SFZsWW9zcWF4bXd1?=
 =?utf-8?B?eHpCOHp2QWVCeGV3K2JHOU4wbmkyMy9FeG12RG9OOUhLcnNkSWZYMWJLUlFL?=
 =?utf-8?Q?5Cdew/EwaGVAUrTrZ15hBAp2A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5420a07-fc59-4ff3-f380-08dc97ba5a5a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 21:36:21.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs8EHglQJMVtTPAGiYg7ssolr2yATagbMCC3pFw6Ah30/Z8148kbZ8CjCMEtxVfxnwuuHPpYN0XERr3Tlysg+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885

On 6/28/24 16:33, Edgecombe, Rick P wrote:
> On Fri, 2024-06-28 at 16:22 -0500, Kalra, Ashish wrote:
>>>> @@ -717,7 +718,11 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd,
>>>> unsigned
>>>> long address,
>>>>         *nx |= pmd_flags(*pmd) & _PAGE_NX;
>>>>         *rw &= pmd_flags(*pmd) & _PAGE_RW;
>>>>  
>>>> -       return pte_offset_kernel(pmd, address);
>>>> +       pte = pte_offset_kernel(pmd, address);
>>>> +       if (pte_none(*pte))
>>>> +               return NULL;
>>>> +
>>>> +       return pte;
>>> The other levels check for pXX_none() before adjusting *level. Not sure what
>>> the
>>> effect would be, but I think it should be the same behavior for all.
>>
>> If we are returning NULL, why should adjusting *level matter.
> 
> Well, I think symmetry is enough of a reason, but actually it should be ok.
> 
> I was looking at this diff compared to my working tree, but this tip commit

Ditto for me.

Thanks,
Tom

> (which is about that scenario) makes it set *level before checking none for all
> of them:
> https://lore.kernel.org/lkml/171871930159.10875.16081839197437299007.tip-bot2@tip-bot2/
> 
> So sorry, nevermind.

