Return-Path: <linux-kernel+bounces-201491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248128FBF07
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446111C21C32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CF914B97A;
	Tue,  4 Jun 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KHypELY/"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A9A142634
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540567; cv=fail; b=AGsBVM7xoc7xYM36L6BnTfeXFiZg0KR79zgit0iCojH2Ii//zzE/koRmmkGa+3BILUs3+cLAXNWID4JS8u5yUaM7/dsudN+cd9yoEMrIXxMsR8ZLVgA3DdtkqTJuJRQq3RI84kyO88zMmuRWoQkSkioUY8X8fVSwBvqZ2HLZ8ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540567; c=relaxed/simple;
	bh=9+MBJCT9IkHMwyfDZBOF1G9PLC8G46JekM3JB+ITSjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LoJT+rbBz1GzKxJZ1hJl+OAJMeAjNoalo1exRwyMTCKZ2htDQ/1UjWYyjrTASDnFmn4NiRU0Tj6sidXU5eVgVxASaf/3V9tsxDBtXNtirJ80x8opHky2B1g+auqQgiOm26aVTXp4jXoqzulqaXrVE/YGKvkkk8M8rN0sIDzG6UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KHypELY/; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXCQCUJEII8xiZMVIMS7dGUbTANO0DyYgbzKE5U3XRKhZ9isAmSHvy8HJeCvSa8J6uNYSC2tI4Ga9Xn3qgiGrPo3jkzPCsjnnx0ASyG0QZpri6wWaD9NbhmHSdYGMcQGij6YMNmWqPnzs4SlzdnWQ7ALuuJQ8CbmmVsxkNhebbjcKZLFsGs1HfrEm5qmrK1au4Err/FxzEPs8sYPhMtnAQM/+dP4rFTIPRJccO/JVmxtAv5DQe4fEwzO7mWz0FwvV95u6RiiDsh/w37SwONnkxhGe1D403SWnhI9DOHjWACjDZuk81NH3aQwwAUXZVdf3f4Hsfbur985bWoUXK1zGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wh7yr5qmkngnA2wOlNuS8O0RBxhCpSvL9FIKZuqRL2M=;
 b=caiG++qqvFmDjzAbUmu8t+fGKpet/5w3kd1PNuphzzADgXWkOu38sp1IYiJ+0Gfe0dUpLcs97khh7cij5jmCQkPN0ZByR8ebyYUYZTR3DOutjdrfpcfKUqrVC+e+Bt68jMHW/bmD/P8ZlvnM68osgSrFGarVUQclnissVKYLKewar7G5uW1KYcn6Tt0d+jC4vSxrD9URasSHXexjD9fn2Q4GWb+a8CPp5X8gNoPs6eWceuTzDvYEv6veoGMdvSE+y4XnDX0VDLNfqymx9gY4mx0lnlmlOjs7NfrA2F6tB1tfFJE8DWp+Auv/60SxEdw86KlV092ZHSUZiE2pd59ryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh7yr5qmkngnA2wOlNuS8O0RBxhCpSvL9FIKZuqRL2M=;
 b=KHypELY/nU1CVlo9MarGdtiS4qGNGyxkwh298wSSG0I0rhHQ7wOLMtqBuckrRWVyi8+CAtIKE2KhZ449hDfdTZJYP2V46PInJnYbqFf3HiBxnUVL2aCFWAtrCxqDjWgtC4jaIjSjH2vFo7yaUS/YcNGp761zB++X6LJpJdYbs5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 22:36:01 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 22:36:01 +0000
Message-ID: <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com>
Date: Tue, 4 Jun 2024 17:35:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
 hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de,
 ardb@kernel.org, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com> <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org> <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com>
 <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0321.namprd03.prod.outlook.com (2603:10b6:8:2b::6)
 To SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 263b1ff9-cefc-43f3-19e9-08dc84e6b618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1dLUklKVDIzTHY2bW55QXNkQzFPTWU5aGh0TW5kTkw4aThhMTdUYkR1Ulhk?=
 =?utf-8?B?T09ZL3ZuV1k1d1ltQ2VLMk8zVzg1L1ZHV0x4dnNpTkxPM04wQXY2bTlEdUtH?=
 =?utf-8?B?aCtiZDA3MU41QlYwcHhMQzVaalg3a1RsOVBxMzl3YTBTRkFpeXdpY0w0TENt?=
 =?utf-8?B?a2N0OEFHWm5seUtvWWlEZWxBK0ZvN1VnRWJOeHNUTS9WWUZNbFkycGo5b3ky?=
 =?utf-8?B?OHNJZGxTSWc4TDlybHBiUUcxRGxnUG8wbVVCbnlldjJTR1VQQThSN0tFenkz?=
 =?utf-8?B?RGdLdEJGNEFwU0pqVEhtdUhYcSs2T1k5TWFLQ2plTXJKcHRaVGxuMy9MZlc5?=
 =?utf-8?B?WS94UFNPNmNWTmEwNDVzVldFaVdBVmtodi9YcXd4eUVXaGkyZlljaGtJOUR1?=
 =?utf-8?B?NHdvSm5TUFBOeklDV0dJcWY2N1dram16Ni9DSENoQTdlcll1T2luZ1VHaHRT?=
 =?utf-8?B?T2oySjJqVUo3aUt6MXFOcEY5YVhjMTE0bFhTY2lqZlFFTEVmUHZVazdBM0Rw?=
 =?utf-8?B?cHdDN3FEL3ZJdzZ6UVNURDRETWpKQzBNTmt4YWVPWVNnbmptZlVyV3pFSEdq?=
 =?utf-8?B?Wm51VTBYMFdjaVZMa3VmRzhOWUdEZXpwQk5JbGtMUUl6MnE5WHFDbyttNVB1?=
 =?utf-8?B?VEZKVXlPMnR0ZWJXc3I0L0RGZUxGaUNGUkppeEVDTGE2L0huRlZHNGZpRWRW?=
 =?utf-8?B?UzVNWkpFK3JGZVVKTUxCNHhUd3hzTERnekN6NXF3WVZaek1FckJPK2IzME5y?=
 =?utf-8?B?RzFkTDNldlJleGJMSXBSNGZmVnVyWUdudzVBTGdzMUFvakFTNVBwOXA2dERJ?=
 =?utf-8?B?b2hXdHUxWlJoRFZ2WExmbW0xY1FUZGJQczErVTZqbmJFdnZPTUhhZFNpYnNX?=
 =?utf-8?B?OEd0YlozNGRXbTdaK2pvRWIxRTNvVFMyd2Y5QzdsS2FkNXdMdHRqTTQyWWFH?=
 =?utf-8?B?QU1jYms3bkloZkpsUEV4OXp5MXY0dUg0cWptbWIxRVJ1aGxHNFFza3kvOXZU?=
 =?utf-8?B?REhDbjdIeG50elZFL3lZSkNkV0duZ2tWRzQ3eldKd1pCNmU1TWxJRGpDcEZN?=
 =?utf-8?B?UWpBckM0SjUzK01FQ3pDeW9ack5sOS85K0d0WGx5S1JlendlaTllSTZUcEhB?=
 =?utf-8?B?SnpqaHVZa2dBSmpMY1F0aGdOSjVwcmRhdEdXMHpxV0tydGd6YjZoOTc1RkhT?=
 =?utf-8?B?dnluQ01CYU9mb3MvWCtyTDZtWDVybEdNWkZKcGhTbm8vdGhDRlZlMWVFTVJQ?=
 =?utf-8?B?ZVBOSUZRSWJobEFVZjUwN2F5VHhDeHAyRjhsZTRlcDJHUXovQ01pdFRYbG9W?=
 =?utf-8?B?OHBLQkJ4NEVRRVVUcm1wR2NQQVVoU0JTNytqUTZWcmpENkJiNWloZTY0dTVB?=
 =?utf-8?B?Wi9CVjVRdnFjbkdES2twUWxFU1RpN0p4emNRdFFrMnYrcHZYN2VFUDdyK0sr?=
 =?utf-8?B?ZXZ5NWp2eXlOQnZzWWRYSW9NdktybDRtSWxITzcrWEp0M3A5RjBVQ01xTWRM?=
 =?utf-8?B?STVKRURkZ1JkOUJ2YUxySFVxbjgzY0J1RCtkTTNBUVY0VndoOHR4MlpRL3lw?=
 =?utf-8?B?b3JuVWxYaWtsOWRKdlMySVRMeDduZTlZbWJpNDRPUG1PTjdMbUdHR0pWTm9V?=
 =?utf-8?B?cHlUZjBFWU9RUmZIREIzbkU2ZkdXVHBMMWtiK3dna3hlb0lsM1RWRUlHdUM5?=
 =?utf-8?B?NjJrNHFEblBlK1BBcS9ETmg0UU85UWozZlRiQTE2bnp1KzBtV3JKZ3NucXFY?=
 =?utf-8?Q?q6N2re5fxyxGlW5Fd7315Yv6iQXYpF2qFXrtTMD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXhFRlU3aWx2R1J6VzhycWd4elUwODlmWmJWZmROczluZnEyWE95NXI1aFhi?=
 =?utf-8?B?UUtES0Y5STVNQVE5TjN2am03YS8vM3AvQ3Y1Q3lMeEZ1R3RwMVVtTGxFcVNm?=
 =?utf-8?B?NzNhSEFSakdIY1lyOVJMNWFxN3ltakFpSWRweUdCaTlOVFlKbGdMaXZKbEU3?=
 =?utf-8?B?d1RRMEw0d0lqSHRLS1A0U3ZzS3JMZW1mRkNrUDFUczM3aUFSMWxsc2paMFR1?=
 =?utf-8?B?dXlISTUwT2VQRWZrMVgrdzRvalNZMzRlMk0rUUxnVmhRZ3VidGpLUERVNHQy?=
 =?utf-8?B?U1ZyU2hNd0JBT1lHZnJoek1BMnVTd0svVTFZNlBXS2JqZloraWhSQmp2YVBh?=
 =?utf-8?B?TXJ3RUFkcGpudU9hN2M4NjRzREYyRUU4OUcwMTkyd0FrZXphOEhDdnZtOUxT?=
 =?utf-8?B?NGJlM29VRkZ1b00vN1FEWG9ZTnJkbkwwOTBPejN4cTVzNXU5aFE4eEZRbjI4?=
 =?utf-8?B?Z2dWMmxCRXBNb2g0ckRoOFlaaGp5NnRyZHQ2enVzUklTUHZYM0pBRFVleDBl?=
 =?utf-8?B?SHRWZG5HYWYxaDZ3U05RZ1cyUVZTZWZkZVJLWFdSaTZWNlZ4RlB6STNoUU1u?=
 =?utf-8?B?WE1BdEdESnFwcGU4eVYybCtxUnFMQitPYThMQUJHKzR6dHhYNUdiVVhNRlJq?=
 =?utf-8?B?UHUvWGR1UWpqd01ZQ1RUekROZ3lwcUdSeUZuZG9ILzhidytLSitZNFgvMHlP?=
 =?utf-8?B?YzM5a0c1TWxYK0pLRFVkT0h2NHBqWm9YUjkweXJBMW9aYnJTUmRqLy9EdHgw?=
 =?utf-8?B?ZlVhdTVBS1VCeFE2Y3lWWW9LWmJ0aHNxSzFYemo4OU9nOVBkNE13Vk1JSVNH?=
 =?utf-8?B?RXlPVVpmaUFSRHlYTzdSRTdqd0FrOHNZTE51ZUVIeW5ScXU1RXRiZGdNUkhO?=
 =?utf-8?B?MjlvdkNHU2ZjUzVDcittbjJ2L3FaV01Pc1JnVC9sWGJPUGROb1lpR0NTUXZL?=
 =?utf-8?B?VjV6RCsycmNQUmZhNVRiYXRqOU9JdXJBTHhtMXpMSDRjWTQ0WjRUWU1VaUpn?=
 =?utf-8?B?OTErZVNsdityeXdwUEsrRVFWQzA1b0JUTEJUbE9HMGpkanRLUisreXlNNFVq?=
 =?utf-8?B?d0ZhMlVHMTMxTWxwclhWbmZWeFpmYms2T3IwMEJpSlFDbUFzWjZ4Q2JGb0hO?=
 =?utf-8?B?Yko1cXllSXVYNDZWcVFoNm9kdUs2Syt5d2w0UjVEZmEwbU83VWZSSEJXNm11?=
 =?utf-8?B?SnpLRUQ1QW1YSnl2enB2SWVraG1FOFVUbEZwQ3FpN0IrVHo5U2s2L1pKMVBZ?=
 =?utf-8?B?RUd3djBoZFpLa2htY1g2UmhIayt2MHVVTld6VnFOZmt1ZzFlV1hBUGZZYjMz?=
 =?utf-8?B?VzhNdXZwcFNybHBIRTlUV2xuQURKQlJ3dE8rbU02T2t5dWlXUWRJOTcza2E4?=
 =?utf-8?B?Q0VhL0NuUHp6Zjh6YmMrK0o4YmVWUTRYM21OSXdGYmRCNElNeDBpR2pweU5I?=
 =?utf-8?B?NVNZME1TMm1ldktDSnlwbFlnYUpYZmIxRlBoaGU0L0VsOWN1YnZGODZuUkds?=
 =?utf-8?B?Tk5rVURxZzJoQ1hDVTVtb1pBYmo0Mk5LV3lBaDJGb0F1VklLQkxRVTFaNGlx?=
 =?utf-8?B?UjZNUnJLQm5RMUxPNFR0SkxOVlBOOXlVWXlxUGFqdjQrU2pOVEJ4ZHRKRUVF?=
 =?utf-8?B?RTQxbFREYWdRcVVEenZMamgxdkFsRGVHTlMzVVRXQUV2SmRoRVE3NStoaUFF?=
 =?utf-8?B?S3NPTmRQWEhENkZFV29ZYnV5c0pmU0ZEUlBDSm9ySHh3T3UydzhHaXZzQW1t?=
 =?utf-8?B?SEkzTnM2bUJ5bVkvVFlsVlFQM1BJd0Q4YVl5TkhnSllUdklTZmdFRHBUZUNH?=
 =?utf-8?B?UTcxNlR3dXRNOXl2ZnEzWjdGZVNCUzBvWTFTUUFDWGlGWm40UmJCb25FdUFx?=
 =?utf-8?B?KzlUWEpyS3lpSWRac055MlBFYkFzYnlkNi9FS2Q0S1FZQmxMUGFMSzBBWjNR?=
 =?utf-8?B?TmlPQmRVeGwxbUp2Ym1ac2RheHdQTVY5UDBIa2RVT3h1emV1VnlJdmtaSUZF?=
 =?utf-8?B?bXN5WVpnM1ZOblZyS0tJVDExYVFaY0FRVzNJdExsSHlKSFdBY1d2SlhuaUZi?=
 =?utf-8?B?UmQ3NG1nTk9CbVN1emNmN1I3TVMra1pkeE1neG1hazB2Q2pTQllxdnduTDNr?=
 =?utf-8?Q?kLDfqBarwmF1R+m0sFiPn96Ye?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263b1ff9-cefc-43f3-19e9-08dc84e6b618
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 22:36:01.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zskj1hgzg5uWah9pPCUa1Tw31Uck9645TaHWkgLhwCdLcNuCqFZhWSAk2wRlCfipBl4mJcGml16Jp7ERByxTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056

Re-sending as the earlier response got line-wrapped.

On 6/3/2024 12:12 PM, Borislav Petkov wrote:
> On Mon, Jun 03, 2024 at 12:08:48PM -0500, Kalra, Ashish wrote:
>> efi_arch_mem_reserve().
> Now it only remains for you to explain why...

Here is a detailed explanation of what is causing the EFI memory map corruption, with added debug logs and memblock debugging enabled:

Initially at boot, efi_memblock_x86_reserve_range() does early_memremap() of the EFI memory map passed as part of setup_data, as the following logs show:

...

[ 0.000000] efi: in efi_memblock_x86_reserve_range, phys map 0x27fff9110 
[ 0.000000] memblock_reserve: [0x000000027fff9110-0x000000027fffa12f] efi_memblock_x86_reserve_range+0x168/0x2a0

...

Later, efi_arch_mem_reserve() is invoked, which calls efi_memmap_alloc() which does memblock_phys_alloc() to insert new EFI memory descriptor into efi.memap:

...

[ 0.733263] memblock_reserve: [0x000000027ffcaf80-0x000000027ffcbfff] memblock_alloc_range_nid+0xf1/0x1b0 
[ 0.734787] efi: efi_arch_mem_reserve, efi phys map 0x27ffcaf80

...

Finally, at the end of boot, kexec_enter_virtual_mode() is called.

It does mapping of efi regions which were passed via setup_data.

So it unregisters the early mem-remapped EFI memmap and installs the new EFI memory map as below:

( Because of efi_arch_mem_reserve() getting invoked, the new EFI memmap phys base being remapped now is the memblock allocation done in efi_arch_mem_reserve()).

[ 4.042160] efi: efi memmap phys map 0x27ffcaf80

So, kexec_enter_virtual_mode() does the following :

	if (efi_memmap_init_late(efi.memmap.phys_map, <- refers to the new EFI memmap phys base allocated via memblock in efi_arch_mem_reserve().
	 	efi.memmap.desc_size * efi.memmap.nr_map)) { ...

This late init, does a memremap() on this memblock-allocated memory, but then immediately frees it :

drivers/firmware/efi/memmap.c:

int __init __efi_memmap_init(struct efi_memory_map_data *data) 
{

	..

	phys_map = data->phys_map; <- refers to the new EFI memmap phys base allocated via memblock in efi_arch_mem_reserve().

	if (data->flags & EFI_MEMMAP_LATE) 
		map.map = memremap(phys_map, data->size, MEMREMAP_WB);
	... 
	... 
	if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) { 
		__efi_memmap_free(efi.memmap.phys_map, 
				efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags); 
	}

	...
	map.phys_map = data->phys_map;

	...

	efi.memmap = map;

	...

This happens as kexec_enter_virtual_mode() can only handle the early mapped EFI memmap and not the one which is memblock allocated by efi_arch_mem_reserve(). As seen above this memblock allocated (EFI_MEMMAP_MEMBLOCK tagged) memory gets freed.

This is confirmed by memblock debugging:

[ 4.044057] memblock_free_late: [0x000000027ffcaf80-0x000000027ffcbfff] __efi_memmap_free+0x66/0x80

So while this memory is memremapped, it has also been freed and then it gets into a use-after-free condition and subsequently gets corrupted.

This corruption is seen just before kexec-ing into the new kernel:

...
[   11.045522] PEFILE: Unsigned PE binary^M
[   11.060801] kexec-bzImage64: efi memmap phys map 0x27ffcaf80^M
...
[   11.061220] kexec-bzImage64: mmap entry, type = 11, va = 0xfffffffeffc00000, pa = 0xffc00000, np = 0x400, attr = 0x8000000000000001^M
[   11.061225] kexec-bzImage64: mmap entry, type = 6, va = 0xfffffffeffb04000, pa = 0x7f704000, np = 0x84, attr = 0x800000000000000f^M
[   11.061228] kexec-bzImage64: mmap entry, type = 4, va = 0xfffffffeff700000, pa = 0x7f100000, np = 0x300, attr = 0x0^M
[   11.061231] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M <- CORRUPTION!!!
[   11.061234] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061236] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061239] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061241] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061243] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061245] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061248] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061250] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061252] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061255] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061257] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061259] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061262] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061264] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061266] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061268] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061271] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061273] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061275] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061278] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061280] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061282] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061284] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061287] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061289] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061291] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061294] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061296] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061298] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061301] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061303] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061305] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061307] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061310] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061312] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
[   11.061314] kexec-bzImage64: mmap entry, type = 14080, va = 0x14f29, pa = 0x36c0, np = 0x0, attr = 0x0^M
[   11.061317] kexec-bzImage64: mmap entry, type = 85808, va = 0x0, pa = 0x0, np = 0x72, attr = 0x14f40^M
[   11.061320] kexec-bzImage64: mmap entry, type = 0, va = 0x14f4b, pa = 0x65, np = 0x1, attr = 0x0^M
[   11.061323] kexec-bzImage64: mmap entry, type = 85840, va = 0x0, pa = 0x2, np = 0x69, attr = 0x14f59^M
[   11.061325] kexec-bzImage64: mmap entry, type = 0, va = 0x14f65, pa = 0x6c, np = 0x0, attr = 0x0^M
[   11.061328] kexec-bzImage64: mmap entry, type = 85871, va = 0x0, pa = 0x0, np = 0x7a, attr = 0x14f7f^M


...

This EFI phys map address 0x27ffcaf80 is being mem-remapped and also getting freed and then in use after free condition (while setting up the EFI memory map for the next kernel with kexec -s) in the above logs confirm the use-after-free case.

Looking at the above code flow, it makes sense to skip efi_arch_mem_reserve() to fix this issue, as it anyway needs to be skipped for kexec case.

Thanks, Ashish


