Return-Path: <linux-kernel+bounces-197351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D078D699C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C581C24CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F19A17F515;
	Fri, 31 May 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J8Ez0Dsf"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FAB17F4EA
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182988; cv=fail; b=EGW3D1bS9g+o/5XxTwjqrRKlzSxcWSqKT0S6x3JoPoDDcX9XjB7YnkmXRhBIzNVebl6cYwHh5A/q+ZMW8dQOTqkPU0bWFmT013wUN6osTAt0MQm9cz9s1uNsUgUVuYil5PMjBDJUg/ryD1eAGTrjzeLjHhYW3ivN9Urt6NieW00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182988; c=relaxed/simple;
	bh=E8AaC8bmLUQntrPQKL4OwAithevBQkauDhjBXWIKanU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T91+ExYnBK4/g4S5QMI8rNz98aAC1HB41ZrXcGtM4cuq3iZYSbgQCkEzcqtynhgT6xbwCNMaO66m3jZkAzSolBoI/fTTLZhrkbdem/m/qGlA5wItyjqhWtbMb4KKX0fWt77VY8IoBieyp78xoLJ/Bcz9NmRZoe9lXT+KymtTCIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J8Ez0Dsf; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q08LFm6UG25jQUboanlSmRS6HPCiIAoHt7S0JwgNmbCh138SoqZwUtBX/RJiXRQ6koyw81Ra6qtHo2mDQEXYfBIPUzEWyA0XQhcXfGIAXL4RXrxdZ89SWfKQuFxgihyH1LKp29YQimf18Wf4cmKAIZUwaFMJBQAs6+DylflvDmpB0t5C7ihoxTXtFwW4pNDkLs8z9e9tmceijGcHcNAbvHmR+orGajccIPGP00oXhaS/BGF8VwhW7IOOusJbBZ3HFLIdivZj/ZpGEgnPndsFRV0xldXYKSZxBr/LpFNy/Kw5KlVfq/sWEY2WhGl6jN1fTrsfnbYnDfy28Ea9C0Z8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64Zqyj+CuOpU1hL4H8KFL0kyHt6ND4QzPMOm+ooAQ4I=;
 b=fNO0gkYyAyirQNd/8kThak410VO4x0CWT9EPCMrp1eM0DGX6DS3pA9tltHQva9vvsn3vcq7pv6KF4ZpY9GWNL/mp2LVigONtEd6/onW0I8mW5mtCnWaMXd2b9vSXpQy8a/2L2uI4326yVdosQsZ1UpM0l1+IMyhHE5+XdXDtNRDR3Uijw31kXDTi4vZ1EdsEcY+mPsSU/jAAgQJ5g+BG7eoKUMuPH8e1TbIL0kUhRbSm9w8KU7UrEpvONypQsfdzmEZPPDHOGr2oCw8+6nUA41ll/zPP71/barRYK3L7XTjUlz4hY16mMpouQtohZJgrGnjuchtQHAxIK9k6+YhUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64Zqyj+CuOpU1hL4H8KFL0kyHt6ND4QzPMOm+ooAQ4I=;
 b=J8Ez0DsfRYxVHu/zzbszKD7XOQL0SaPqCY/FZ3uzUsEPeE/snom+kk7XCSAZAlAiZUcmCswnzco0zW3R/GfHe7w3Jeq7HJLFe5OXR4h7gS5BIWrhaMhEGbwLmfq+ynU6lbEHSc9pejtMNattMRoolkSIFGGSImImounp8S7uLQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 19:16:23 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:16:23 +0000
Message-ID: <6e597167-7e29-175d-4e69-0ccf74dedf3e@amd.com>
Date: Fri, 31 May 2024 14:16:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 15/15] x86/sev: Allow non-VMPL0 execution when an SVSM
 is present
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
 <e377d148acac799f6905fc544fbb8bf2ed76e078.1713974291.git.thomas.lendacky@amd.com>
 <20240531145423.GLZlnkn4JHSyh4-G8P@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240531145423.GLZlnkn4JHSyh4-G8P@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::14) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 2034b25f-63ee-4e86-8d6f-08dc81a628c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmFMKzRWZUVPdTVCcmZBUXUwTEkrc2U5WnpGUDFoL1Ftdkp5QUk5ZFRqWlJk?=
 =?utf-8?B?Y1NYTnYzZldnbzZvVEQ1czE4T1oxVS9Zb0doZzREcSt2L1JlUkREYW5aL0hu?=
 =?utf-8?B?b1pLQ1JuNXgvb1R0SC8vYnN3NGdjbC9vUXovVUxxVU9qWDNkTUFRblRlNGVI?=
 =?utf-8?B?WDBTYnZNNk42YlVsN1RzaUYwdkdiU0FieExpOUh2RDdGa2ZiQUUyRHpvNjhE?=
 =?utf-8?B?RUMzWXR2VGhZTmxQZlBUaXFOSXNjSis5QzVBcnNkSTg1Uktsd3RQeE1aekFJ?=
 =?utf-8?B?Yk0zTm1qR1RQTmMrQ3FlLzZUbWhlaXNwdGQxSjdWYmovSHJqaWw5WEVVc0M5?=
 =?utf-8?B?amhxaDNpaEx4dk5qdmJ4MEVWdVFXbzRpU1V6clVBajNVZTBqc2ZRMk1ScFNv?=
 =?utf-8?B?TGpLSVJBcldabFF6Tm4wM0FXNENEbHZucm9JMGZOVVRNUVVkdXBldXBVSm04?=
 =?utf-8?B?aldMaklYNS9CdHkyYzVUdExwbnFSak90cHNVaUpraUxRWlF5cEVDMDlqby9D?=
 =?utf-8?B?dmtHS0hobXVST0d3Wjd4bXcxOWZ1dGw3RW01Z2hwcmFxZlk4cUNCU28yaklO?=
 =?utf-8?B?Vms2eTZSOG1OL0VPeWs0NWgyeEVhdndyc3RBVEtrQ0ZlaWJpZThNblcvY2Ra?=
 =?utf-8?B?bm5Wd1pWT2M0NUNXYkNvcVdhdG5xNTNWcWZFSitNNzVpRmhrQ1plblpNSzdS?=
 =?utf-8?B?RHYvL1kvQXlqWWQ1U1NYRHdHNzhYK08zbVdYVkNMUGVmdzJrMFhNbUZ6Qndl?=
 =?utf-8?B?RHppeERTSEJ2empUSE1XVTZ1YVcvejlpQjhoU0tXa3RVdzNOQisxUXIrNUhz?=
 =?utf-8?B?VEhYYjh2VVVrWE9SblNOOXhPRC8xdHJYSzZiY25HRVZEdnR1eDFDbWFURlNq?=
 =?utf-8?B?ZllWaUI3QmFONTZvcVRwaEViZnd0RUZraDl3NmRwa3J0ZHVuay9HZVdvQ2M3?=
 =?utf-8?B?MTU4bWEzai84Zm1iL0lxR1gwSmhPMW5MckpMYzR1YWVHUk0rZ1BGUkwrZXdK?=
 =?utf-8?B?OS9YU2ppNW5ZVmhueUxQck8xeFh1MnhUcEZFU0w4dXZPYjVsVHI2bW01eDFF?=
 =?utf-8?B?dVBnQWw3RWpxbjNKSnA4aFdvcmFnRWo5Ti9EZ3o5TUp1QStmMUNEMkNiTStK?=
 =?utf-8?B?Z0ZaN2J3NXhLQ3pLUEYyQTBkRTlyWk1qTW5TOU9YL0IvSDZvN2hlZnI5TXJ5?=
 =?utf-8?B?dElqLzBqNE92eEU1OGUwRzhna2MxbzBKUE12VWtHbEt2bCt5cEU5c015UEEz?=
 =?utf-8?B?V1d0L0NNWko2NkhoRjY5SENibzBWdHhmODZIZzA2MUtYT3pGVmtKbFM0ZEpk?=
 =?utf-8?B?V2hUY3IvTjREMXdUQjN2aEJ2NEsrVjR4dDRqcmpYaFFmUzJSZEZNa0EzNjN6?=
 =?utf-8?B?TmRsUDhFZlowaFQ2eEpwUXgwUjVhaHpYUlF6MGV5aUpYVzBkR2t5ZHNmVmhI?=
 =?utf-8?B?V1dnVEhoYjlZN2Q0My9WVjFZeVpVU0pRREExUEZpaGpyNVRZZ2ptWk1kVnJn?=
 =?utf-8?B?cXo4WGh1U1hDZEpPdnlHL2RCSkxTVTZZbm1UZ2RDaGVydnpxZ1V1M1YyR0Jw?=
 =?utf-8?B?WHdka1VLaU1tamdIU1BBWTVMeXFoSUxYME5CLzlxdytJemJlOXltZjA2YXNE?=
 =?utf-8?B?andYaldHZlZWL004ZE96SEdJNHlzcXEydzlJeW5wMmtRY1ZGRDhjMkZVN2xu?=
 =?utf-8?B?ZHJ0TVZqV1lMUnZ0VS9zSzF6NGQ4eUJXTlFDQ2s0aDU4RXIrMlpJZEpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1VNczlndW9zUjNPL3NjbkI3akxkVlVuRTNjWmd3MjllWUxiMmlIK3ZreHJk?=
 =?utf-8?B?cko5YXc3QWZySW5ZRHkzYjFMV2JDMnU2bmFFZHprQW9Nb3dZcGVFOElybXB1?=
 =?utf-8?B?WXJPaWRKSUduRk1tVGU1Mlgvc3NIWTFYeVpIc01EekdEdzR4Yk9iZjE0L0V2?=
 =?utf-8?B?M3JSVGRoU25yaGhhR0NNL0NvRDZPZFB5bzAwaFNzY01sejFCbER1OFZWR25J?=
 =?utf-8?B?blpqTlZMYytKU21RMmdxbzlMZDZheVE4cTBrQlRRVXh0a0JBK2pnakJ0VE85?=
 =?utf-8?B?a2cra3Fxc3RsTUs5d1k2NGlpWEJOQWNBMTdYZGFhWCtLVHBpT292QWNkWkxB?=
 =?utf-8?B?K1R1VXRBQUlGM2M0RnFHVWhMZEJrVWFVNVowNXpLL3BrRjhFdCs3R1U4Z3F5?=
 =?utf-8?B?SU0wSW5uZkxrZXR5RExHWk5FMnpKbDBORkkrc1cyU0hqNXVrd1d6UEVqNzFq?=
 =?utf-8?B?OFNwVndNYytwUlQ1V1VBcVFON0phcXdLUy8vVkxQWnEwcjNpS0YrQ052NjVC?=
 =?utf-8?B?bGtyN3hQL1JxME9TcXlzdGl0S1V4Vk9PNTJyYTRkeVNaZEcvYkhBOEVwV2Ru?=
 =?utf-8?B?Z2t6RGp0U3B6VHo1WlJXY2JQb0UxRTRXZThBbEh6Si82RUFaWWFkWnBJMnVL?=
 =?utf-8?B?YnFad3BDekhTY0phTnV1aG1tNUNDdHFvdGFHRndyUC9VR0EyZi9wbkxNSWxP?=
 =?utf-8?B?MkVDb2xWUTlIeXllMGhrQXhwVWtTN3Uyd1laMUlFUVlkaENxNktGRk0zZzk0?=
 =?utf-8?B?Ynp5WTFiRU83QUlOYXY5dENRU2M5WmNNK3BuNWVDQllWY2lXOFNjTy9ldTU3?=
 =?utf-8?B?VVB1N2hEMHJRN2ZxQWd5K0IvUnIybFVyTlJYL3cxV2lUSWhwd1A4N0gwNWtO?=
 =?utf-8?B?aVlCZTZhT0VFaUIxaWxXdDduVlhGLzJmZ09Ba0pYSk5SZ3d5d2pON1Y0UGhm?=
 =?utf-8?B?dERYSStreUJJNkw4b0cyZFFtd0hvRXZKNDFHTzd5TDhMUk8rbFNzbEJ2UWJ3?=
 =?utf-8?B?Vk1kUVYyeWkydG1wT2ZpbVJ0T2hDTXlweHMxSWtodElzSHlDdWgwWE8wMUJ2?=
 =?utf-8?B?TGtOYVp3T1JBa2QvbE8weHZuTmxEY1lHTTZFcDRhNTBNZFdoT2pwWVFCRjFQ?=
 =?utf-8?B?VFE2TWIxUU9QaEd4Z3FoTzlTNGNQbXVVRXpmaEZ0Q2x5UFAwVEIzVDhpbWZr?=
 =?utf-8?B?QVBjOEpwUVQ2UmZvcHZoOWFEaXpJS2VlQXFhMGkzdkNTT1FrMFVwMXJFRGZZ?=
 =?utf-8?B?aVRjRE5TbUhpMlJKR1puOXlWaWt3K25SZWtUWVMyQjRaL0YxMlkxa2xGL2U2?=
 =?utf-8?B?UUJDdVRVdlRBMnBUTHFxRXNuUEV3dEhsVjFYTEEyd21SaHRadzFPM2VkTjVX?=
 =?utf-8?B?c0pVTW9XUGZUQy9kdU1QTXJSRnphMWc1Nkc4Tzk3Tkg0YWU3K00xTk1nTXFG?=
 =?utf-8?B?azNiKzJ1TlRkeGhnVm04Nk1NY2J6OWV2dWZDMElEblFUVTJzWGNlSVI4Q2Vr?=
 =?utf-8?B?VjB0QTRPRDFURlQxbW5LbCtFNmtzdTFYK1hNRmRKMTdBZFpudjJ0M3E0cFBy?=
 =?utf-8?B?dTJpVWdXcXg4TGJaNkE3Ry95WCtyS1JaNUJQOGJjYksvdjQ3bnpnZXAybVov?=
 =?utf-8?B?NzdER0pheCs3b2FzeUZmQ3NyazhDZG4rVmp6bmJ5Ky9vZGFKOEtnOUhHRXJr?=
 =?utf-8?B?Qmx4L1crajJReGFnVUpIQ1lSNU42SjIyY3MxR3hqZjFkZnczb1c1U3hwRDdq?=
 =?utf-8?B?TjQ2eS9CWStXM05rTTRUQVU1SVRGZmpXR0thVy9ydGptbG53bWpuZll0K2Nv?=
 =?utf-8?B?Rkl6NDF6cGJzRXZ2d3V4U0hIc21HRnpKNGRtQVFTMFE2eFNYTVZYZzE3a0VY?=
 =?utf-8?B?dUgvYndmSDIwTzNVb3VzTENTNlQwd3ArakpYZ3NaVEZxb1laZ0RjbVgzUmd5?=
 =?utf-8?B?Unk3NmxBZEl1NUlCei9ack1nK1FTbXVyVkVHY3R5L2xhWWIvY2QxM2RQZ0N0?=
 =?utf-8?B?U3BIZUt5anlZeDRJNFVYLzVmRXlwSGpORTlJejdxMURhUVdSVW1PTnNWRHRG?=
 =?utf-8?B?SGE0aWlXcS8wMGZKR04yN2hoYkRlUzkvYkxOL2ZsUnRGekJyTDBEQXlLMXVW?=
 =?utf-8?Q?0Cf8cY+Qf3k4ffHShz7fVcdBi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2034b25f-63ee-4e86-8d6f-08dc81a628c1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:16:22.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RBI/haEewjvOD88yqRQGsSjgw9TbKrhmVAyApEzDgepxLK8WM++26KEAB1ZiUuJdDVspmyjPYKxFUmUFJD5/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287

On 5/31/24 09:54, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 10:58:11AM -0500, Tom Lendacky wrote:
>> @@ -624,8 +626,12 @@ void sev_enable(struct boot_params *bp)
>>   		 * modifies permission bits, it is still ok to do so currently because Linux
>>   		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
>>   		 * permission mask changes are a don't-care.
>> +		 *
>> +		 * Running at VMPL0 is not required if an SVSM is present and the hypervisor
>> +		 * supports the required SVSM GHCB events.
>>   		 */
>> -		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
>> +		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1) &&
>> +		    !(vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
>>   			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
>>   	}
> 
> Let's make that more readable:

Will do.

> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index fb1e60165cd1..157f749faba0 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -610,8 +610,10 @@ void sev_enable(struct boot_params *bp)
>   	 * features.
>   	 */
>   	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
> -		u64 hv_features = get_hv_features();
> +		u64 hv_features;
> +		int rmpadj_ret;

But I'll probably just call this 'ret'.

>   
> +		hv_features = get_hv_features();
>   		if (!(hv_features & GHCB_HV_FT_SNP))
>   			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>   
> @@ -626,11 +628,15 @@ void sev_enable(struct boot_params *bp)
>   		 * modifies permission bits, it is still ok to do so currently because Linux
>   		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
>   		 * permission mask changes are a don't-care.
> -		 *
> +		 */
> +		rmpadj_ret = rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1);
> +
> +		/*
>   		 * Running at VMPL0 is not required if an SVSM is present and the hypervisor
>   		 * supports the required SVSM GHCB events.
>   		 */
> -		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1) &&
> +
> +		if (rmpadj_ret &&
>   		    !(vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
>   			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
>   	}
> 
>> -static int __init report_cpuid_table(void)
>> +static void __init report_cpuid_table(void)
>>   {
>>   	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
>>   
>>   	if (!cpuid_table->count)
>> -		return 0;
>> +		return;
>>   
>>   	pr_info("Using SNP CPUID table, %d entries present.\n",
>>   		cpuid_table->count);
>>   
>>   	if (sev_cfg.debug)
>>   		dump_cpuid_table();
>> +}
>> +
>> +static void __init report_vmpl_level(void)
>> +{
>> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>> +		return;
>> +
>> +	pr_info("SNP running at VMPL%u.\n", vmpl);
>> +}
>> +
>> +static int __init report_snp_info(void)
>> +{
>> +	report_vmpl_level();
>> +	report_cpuid_table();
>>   
>>   	return 0;
>>   }
>> -arch_initcall(report_cpuid_table);
>> +arch_initcall(report_snp_info);
> 
> Zap one more silly helper:
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 7955c024d5d7..ff5a32b0b21c 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2356,32 +2356,23 @@ static void dump_cpuid_table(void)
>    * sort of indicator, and there's not really any other good place to do it,
>    * so do it here.
>    */
> -static void __init report_cpuid_table(void)
> +static int __init report_snp_info(void)
>   {
>   	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
>   
>   	if (!cpuid_table->count)
> -		return;
> +		return 0;

Well you can't return in this case, just not report/dump the CPUID info. 
So I'll remove the helpers and adjust accordingly.

Thanks,
Tom

>   
>   	pr_info("Using SNP CPUID table, %d entries present.\n",
>   		cpuid_table->count);
>   
>   	if (sev_cfg.debug)
>   		dump_cpuid_table();
> -}
>   
> -static void __init report_vmpl_level(void)
> -{
>   	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> -		return;
> +		return 0;
>   
>   	pr_info("SNP running at VMPL%u.\n", vmpl);
> -}
> -
> -static int __init report_snp_info(void)
> -{
> -	report_vmpl_level();
> -	report_cpuid_table();
>   
>   	return 0;
>   }
> 

