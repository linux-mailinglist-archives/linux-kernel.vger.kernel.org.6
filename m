Return-Path: <linux-kernel+bounces-186484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269A8CC4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4411F232AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09012E1F1;
	Wed, 22 May 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1/xw7hjW"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C71CD23
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394536; cv=fail; b=U7mHsbhOOq3tDhDzgB7Ham5aq1i7dINE6fE6kbDrob6b+cQzD9VMV4oW3DlWxATwK+OljilHNnUBj6/MM4koB/CNBY7hkG2bqP9yQznjQ519TUI/AUma6bK7S2amtK/B2Q4jxQ419cbCPmfXg8qyTTS22iY8gOrXVZHM4D4pA2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394536; c=relaxed/simple;
	bh=i39Y3EYpQBL+a8/bsValSX3EhhUZc2ixssRJ2VdbJ6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dgBV82CdPTdNqApDZmGFcsS7EbwdCQWyPUUOD+2uEEvmzQDMiYys9FDaLumbaj2T2oTfOMna7uxwAfJ/YwhzkjALtpdWNhT10Cu5cOP61JdAmIiuVoVu3CNi8RQCGbDHAZ8zUfTkwvNBKAVx/AH0e5OGQndHu6SzrYDQQ9kXcBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1/xw7hjW; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpOlyh96A4zTA0BvrtLF5+Y4+6qvp2MEVu7WRa33BX8VF9fJpl4SkN9Ig+oP1x5/dFoPnMZeIOIz6QnQamcKUolT4AQ5qvUjXScePoIEBEm55ioBCLklClAkHOMYNWCBnxgxu2j31bNzHxrmHnmK9SzGDPf+ZXVIk7Q8qHROfM71G0WtKQnL982McN6XHRTDwiS6a1xHymMWkw7tLyWyyK5vImsQa5UCPvKPHjF4EkIvp0JzM4bLzCJcZoThyH9++lNKLB5v8HUYGnVORS6gajixNThTwAn8yJS64PtG/EZFf9NvZ1pI5K2/+99a5mru8KJN4pkUfb/483+oK3/bJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsDPNCNeoiLC7+YGRBbV+a3I1N7vxT/g8Zru/cMwnmA=;
 b=ASskevHoiYqRWg5YQB2p4LJWOVp7EMCeyBtlkV9KXS3S5Ooj3/fa8UnCzEfQkD7grVxOomBk9D8gThcrn+lesS4BlJdJrMrBErKknIyaZMeU3HBbZW88V9GpG9DD7cG93f4X3WX0/Y7w2jU5VdOWia3CB0WuMByGt5Ng31mlCsi4US5mUlcU6gry5W0ltn1sJ2IpCg36OlKlgMn4dAHStWZ9QqrTPLknIDoXgwn1wQMm3Y8NC8/PFeaO2+Jw2QdyDMn2LtoNcxS2pQIOd+toIYdj1qc3WBRLDnxoj8yl8naHIox8VLxOCScAPU7ZuNf9K97nUmfinuiv8BZvUtIojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsDPNCNeoiLC7+YGRBbV+a3I1N7vxT/g8Zru/cMwnmA=;
 b=1/xw7hjW8cJ97mv/MgePMo5WB2CFwD/CFSoC3O0AU95csHe/hKyuNdAmDJivqVeEVsp0jGQMC7AgE1vJHrYksC4JvB8ZHUI2Zodh3cKTdWLnBAZXE31Yph9hjw1JOUqfRmka/ySy9Faib9x+CvNxNF5O8Vjrrbs7GP/rW6MnjtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 16:15:30 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 16:15:30 +0000
Message-ID: <db4d1dee-b25e-f28e-e8dc-9c9bcce68dd4@amd.com>
Date: Wed, 22 May 2024 11:15:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 04/15] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
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
 <6cf54cac47f212f4c2b59b123855d8c183989022.1713974291.git.thomas.lendacky@amd.com>
 <20240502093520.GRZjNeWLXU5j2UMOAM@fat_crate.local>
 <66928741-aa5c-4bbb-9155-dc3a0609c50a@amd.com>
 <20240517155858.GDZkd-wkWmYegos-eT@fat_crate.local>
 <f8a92b19-9090-40ea-c2cf-707005f583a5@amd.com>
 <20240522152712.GBZk4O0LIl2r0dH--H@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240522152712.GBZk4O0LIl2r0dH--H@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0012.prod.exchangelabs.com (2603:10b6:805:b6::25)
 To BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e049f16-6134-4553-00e3-08dc7a7a66a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU5NZ0FNbHF5ZFFmZGltSEsvUjZaYlFkK3RTVnRoTXU2MDhhQjE1ek9WVXNq?=
 =?utf-8?B?dXU2QXNNcU0wWC9SR2hVYUg3b2ZsdG5RdFlIa1FIRVVheG5BNlFJWnNRUDJM?=
 =?utf-8?B?VFdpamx6cWJ0K1UrclAyWmFGckxRRUExTlR3ZTZJNElOU1NpTGRyd2hqTkNB?=
 =?utf-8?B?MlZqNnMwcnJwMkZRamNvb0JyV0F1aHNkUDVVeVNwT2ZleFEvQ1crY1V1a2l5?=
 =?utf-8?B?RWc5c3NoRFBta1NUZVhybmk1RjVBdWV1djV2Q3ZvWkQ3bFMzdHZHUCtSOTA0?=
 =?utf-8?B?dUIwdUdsMlpVbWF6Q09tL2ttUnljUE1uaC9JVENTTFlYaVQyU0drV1JSUnpl?=
 =?utf-8?B?NndlcTNydDhmbm5iZlhlK2hzNmNsc1hzQWVhN3ZaTWFTOWNodGxIMGlLdzV3?=
 =?utf-8?B?bFhsWVp0dE1VTXhqNnZrTzRCM1BMM1VKWFQya3ZuWC9FcWRwVmt2UnZmR0hV?=
 =?utf-8?B?UG9IM3NpalZlSUVxWElyaEJuUmV4YkRzTEdnQVIra3dQSVNVWHhpbWxENVB0?=
 =?utf-8?B?ZGtYcHhobHdJMnJJeHVhSllxcVRHNDRQNjROZ0RBbk5yYWdDSUkyY0tlLzRV?=
 =?utf-8?B?WFNZeXBJQTdhbmdyZkNNS2p4d0paYjRNSXE0K1BKS3dDRXJvdGFnOWRrSVV2?=
 =?utf-8?B?bGJ3dEJuODYvK2d2Y2l5Zy80YktLRExOSzJBb2hrKzZwZ2V3c2p1MFFlbVhQ?=
 =?utf-8?B?ZWZpcGIwZzdzMUNaSEVlZ081c3VacVl4SVNwR3ZDSGtlam9heWpTOUdpZEk1?=
 =?utf-8?B?azZiNUg2UnltclJrVCtUVGV0QnB4SG9FZDhrY2FNdEpJd2ovUmg3MEhxTnFU?=
 =?utf-8?B?RzN4ZC8rbkFzWklmUDVPMklmTktXWVdkalZPUTlibVRRTC85RW8vQktTemN0?=
 =?utf-8?B?S3dJd3NMN0YrOTMvTTREdEc0bk1YRE5ra0tBK1ZIcWUrVEc2WGNIdUZobnhO?=
 =?utf-8?B?dm4wbklmYzJYV2p4cVRqR0RXQlM2THlOa1JDaG5qNHlMK3ZtOFBhZlc0bjJI?=
 =?utf-8?B?aWxBeWNTQ29ISTc4ZFk3MEVpSlNheEU5d0x2YVN0Z1lyVWxaU0ZtQ21IRkdD?=
 =?utf-8?B?bGhFdmRhV3YvSlgzNGhodGpWQTVQeEQ3eVk5UDhic3Nha2JqSXN6T0FYOW1V?=
 =?utf-8?B?anJlVXVMV0ZCdldFMTdqclQzM0piZWh5L01CZklqZy8vc3JJYlFpZnpQSVNB?=
 =?utf-8?B?UkNqYzgrczhLd1diNWdLVU1raHNLYjkrQ25uVlA1NGs3Vzd2QjdFSXZGSVZx?=
 =?utf-8?B?VVhERDE4OVhoK05oQ0o1M3FrS0ZuWmJPVmVQb3VvUnJ2MFdYVEllQjVpUXZQ?=
 =?utf-8?B?YzZLWXJlL0hkSWx0K1c5UWU3VzI1RzBKKzZPTGM4S3BSYnpacVh6b2VFWk9t?=
 =?utf-8?B?Tm9xNXdybmxybTNLUUNwZW9UOGNyMC9mTVZoMjl2TkhTdEYrL3Q1RDNSQXFi?=
 =?utf-8?B?V1o2R2FMQUJIa2NvUTh4V1dvOWd1c0ozN0Nyditxd1VFVitDTjdXM3lmbDBP?=
 =?utf-8?B?VjRVYjNNMXFoV1U2M1d3ajZHaVh4QUFMOGV3c0JCNyt3ejVTNkZTUHhJUVpU?=
 =?utf-8?B?clRVeXpHME05S1F6WjVVYlhkZnY5OFFYQzJkSVBsVDhjSFpYNXdVeXQzaWpl?=
 =?utf-8?B?TlcrejFXZHNKVGNwU29NWm95c3RiakpTVEIvQ242MWNzRmNLNGorRzRUTjMw?=
 =?utf-8?B?UE85RVZydUdrVmMxVnpOTUdrbXdPZENLVHBmZDBqRWxEeHJhZlhCeFdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzYzRGQxRGNpNGFRS3ByMlF3OHcva09MNDhrT0p5eHFDZ2lMODVWNVZKM3hm?=
 =?utf-8?B?V0FiOGpVRXMyWjFNOXh3dlRkNnpQMkxHT01QS2p0dm1BZDlKV2VleHlGNWht?=
 =?utf-8?B?ZWRDbkpxV0ZpdU81RkZrbXkySjA1T0VJd3FxSVBSRmVrTDBGUEdEVXlyWnpJ?=
 =?utf-8?B?Q1Jzbm9kYzVYNXB3YW12MFMzZ2F1YVhzR2piRU96b0tUNi8xdWpDUXhMbHlY?=
 =?utf-8?B?ZlV0WlFBdEZRMXNDa0RwM3ZBNDV5alVtSTRDdmcvaFJFMEdKV1hEenN3akRz?=
 =?utf-8?B?S0FDb3BuWmJEZGxJTU9XbHErUFpEWFoweVowb2J0YlJxbXYxZCs0Y1Rvd3hn?=
 =?utf-8?B?VzBWR0pPeHo2WnY0S0JzQ29LVXZyNjN5SzB2TnNkcXF3LzJPdzZnRDM1d3Qy?=
 =?utf-8?B?cXJQMDdXTnVPUlBGaU1IaGhEWG9Ec2ZvR0JDUHcxUFkvaW01NDNUWTJXWFNy?=
 =?utf-8?B?OG9EaXRjL3pMZUtOUVN1a21pSitlUEJVM2JEL1BJcXlYbkpZTGxpWTZJZnRj?=
 =?utf-8?B?WjBjSnBtQUgya3Z4KzBJYjdXa0ZNRHBZSlJkQUVaMkJWVUszRHdrZitWWnJD?=
 =?utf-8?B?VVZ2cW5Yc05HcHpGbHlDV3BDNi9KVms5R3diRWhUazNIaFdWYnJ1b1doMDZE?=
 =?utf-8?B?TXo4Mk5hZk5QRFc2ODZVTU1tZEttcXZzSm5QTUVDYTZ6bXF1VWJOZzBQNFVK?=
 =?utf-8?B?SG9FZDlKQ1V3MDdFSWhhTG5ZVGxoeEE3TlJTUngzSWV4WVJkV3NJWm9NTi9N?=
 =?utf-8?B?bHUrem9obHVqaEYydGR2MGRrU2xVL2NnR0Z4QjV6U0VRMERJZWU3T1lHMEJE?=
 =?utf-8?B?R2ZrUUxldFhDUzU4dzVWTGIrSkpDYzVlY3lXUlpNWnNicEZpemRpMHozcTZ6?=
 =?utf-8?B?bmhRTU1YZVJhRUJPNkJqc1k3QmV6TllBbnhzclp0cXU5RnVMeUh6M1ZNQXFx?=
 =?utf-8?B?MHhoTzk2NWRqek1OSGxVbnpFckNXVlJuUmxmUnQ1QThoWGM1OTdyYmgySUkz?=
 =?utf-8?B?azcwdk91Zk1VeWhjdEdCR3NtNk9DV0NNb2IrK0RnTXFiN3pWL3JjVEVWODYy?=
 =?utf-8?B?OEVnU1ZtejdxL252cVNyTFZOcjFsUVRVNllKQ2VBQkNlZHZwZW55UjdWcHpn?=
 =?utf-8?B?MTZLc0d6WVphd1V2aUFNN1BXMGQ1Q04yK0pvMitNQzQzNlZYaGFoTGxGR2ts?=
 =?utf-8?B?MWRWUXhTTnBEUTNMaVFCVnllTHZuS0xnT2ZjSEVmc01YbzVTWWVqSXliVFhq?=
 =?utf-8?B?Tm1naTRjeDVLMmZ6SU9KYytoRjIvMlhpVEl4eUVkdTF1cWQvaXJIWWZYWnlj?=
 =?utf-8?B?YWVnVSt6ZVlLZ01QN2tVSEF5eDBWZkRYTlVtcWRQd2NyckdwQ2R2YWpjZmtq?=
 =?utf-8?B?VGZzTExqaWVSLzF4WWdrT2U0K3RIVHF3eEpCVU5EdS9vdnk3OWRtNjhiRjBp?=
 =?utf-8?B?WElxTkIwVWhwKy9ZQjJLOThoL2lnWGhZWVp5bXR2R25OMkFEVUlFQjllNFh2?=
 =?utf-8?B?UWtGck5BN2ErYUQ1ME0yK2ZudkJBcjArZUp4a2l6YTRWZ2pmRjJIQ21TYXlr?=
 =?utf-8?B?SHIzc1N6aFB6dHdSay9RR0NtL21OeFU4V1pKSmEzUVhJVjlGR0pESkl1THUx?=
 =?utf-8?B?WnJwSVZ5YTR3bzFJYThHNUVPNXVHdmlhdXRLaEdqQTJXNVptUWF3a1l4R0Zw?=
 =?utf-8?B?UEtGSERScW9wYWpab2ZST1RFbE9YT0Z2ZmFPbnRkd2VIakNDdWVqVmF3T3Jr?=
 =?utf-8?B?YWxrcllkbmo1QUM4QU9Ja09iQmhNM09NODdYNFBLbEdWbldOcVkraVRhUzFk?=
 =?utf-8?B?QkJFeHdLUXZ2UmY5c0RudDFCMENiL2xzVjRONFFvWnRrRlV2VEkxQ2lvQVU3?=
 =?utf-8?B?RFJRbGJaVXloQmp3bTRlNFE0aUJHbTF2NzZSSWNVeFZMcmR2Rnkrb0pHSlBj?=
 =?utf-8?B?WFliQm5CbWdCQU0wK05WdzU2REtnMk55S1VIUmhlc3BiU3VzY0d6NXZBREdD?=
 =?utf-8?B?MlNpR1QweHA2cnJBTld6WWwwRU9BaUFuUTJmWWU4aXRkVkoxRG0vUlU2azlk?=
 =?utf-8?B?SGRNTFlmS1haN2pjU2gwNTdVTTVMdmROV3NMSVNpY29QNko5ZTNCUk5sZFBn?=
 =?utf-8?Q?0Ba0h2ptyANlLmRpcZGoPjA5Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e049f16-6134-4553-00e3-08dc7a7a66a9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:15:30.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+XeHwJBtZ8lbn4IdE/bHcMyRyBgLCgwyQTH+8SxTOnrtti9m016CZARyCJfrmWPSaPWA9fqQFOsf6sNgGRW0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888

On 5/22/24 10:27, Borislav Petkov wrote:
> On Mon, May 20, 2024 at 08:57:43AM -0500, Tom Lendacky wrote:
>> So this will be a new shared directory in the top level include directory
>> (as PAGE_ALIGNED is defined in include/linux/mm.h), not just in the
>> arch/x86/include directory like the others (io.h, msr.h and tdx.h). Is that
>> what you want?
> 
> You can actually do this - it is a lot easier and still clean:
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index cb771b380a6b..5ee53a7a060e 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -12,7 +12,6 @@
>    */
>   #include "misc.h"
>   
> -#include <linux/mm.h>
>   #include <asm/bootparam.h>
>   #include <asm/pgtable_types.h>
>   #include <asm/sev.h>
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 46ea4e5e118a..bd4bbb30ef0c 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -1329,7 +1329,12 @@ static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
>   	vmpl = secrets_page->svsm_guest_vmpl;
>   
>   	caa = secrets_page->svsm_caa;
> -	if (!PAGE_ALIGNED(caa))
> +
> +	/*
> +	 * Open-code PAGE_ALIGNED() to avoid pulling in the world and
> +	 * more by including linux/mm.h.
> +	 */
> +	if (caa & (PAGE_SIZE - 1))

Or what I originally proposed:

	if (!IS_ALIGNED(caa, PAGE_SIZE))

Which also works without including mm.h.

Thanks,
Tom

>   		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
>   
>   	/*
> 

