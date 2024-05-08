Return-Path: <linux-kernel+bounces-173741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235758C04C2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E291F21561
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32090130A50;
	Wed,  8 May 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CWdT1WDv"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6D130A44
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715195607; cv=fail; b=DTXJJ3x0VXQRL9e0qZyD1epVchIgHMuClA5NwmWMhd3lVhtWX2xAxiAtAru2qxF4N7OnCD5C8nDs2ieFvhRt9sksM18Um+Y3Vi/gGFH/dG90GFurM8TErjXU2HO5swKSE1AEwut6wkYZtCN4DoM5g82g9ODsNpAZFd2Y34m5GOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715195607; c=relaxed/simple;
	bh=klpm4GedQA0hDDgYNdtkDjGzny+5aDFyBZeTSvbFtq0=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=KSMNGbfDspGi1ve4KvsjkhtWjvgJcA5HUveQVhnRZVZXMkt4dB4fo72d+m8+SlcRtqNv51TQj4SmtSJ/fDWzGOvIc+tRkCyyp600jTLi0kAKgZ/a6kAecLsK9FFRfpXQAWt2DDS2jIrrc5mUnXsI8SFJBfT58r45Ed4cXvE+qoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CWdT1WDv; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcyke8YTu3y18WCoyyO+/dhIUzyz/Avl3F6reBo9y9vIcZBaS08FKXTxWW8+A86Zoua1aN/6bCE51MIT2PzJDUWsyIYiNJB6G8QhBklLpTaLo7P4ER/fVMquiP4kO4ZXLsYLEusHrxuRnCDpWmxFx9kNJryJ1TorZvj4FmRkU+VeCd/3wM5tZgwdHHOXrM+x9l9nedP42eyVXQ6eGeOvlosIxyqV8+rOItVRlQAWxzNawIHPhExQdYuA5kzR7k0eeNhatjZmivip2Cde5DRlKNOw414KSayMKGXE8RSZ1xmNLP5rhuhqKtF5z9b8GtZS13nq0C67FG97L+ZkM3h1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cj/GCtxQ/2c89RrAnuRhNjIEky/KAlSIAJITkCFjv4=;
 b=Pew1OcUlEtkwaPOGMZ63ZFNUSLaFVRw5Nh4ejGfIZMjapZrvzFqNfTm3Tl6oBOdFD4CyWiCZ1TB0QcHU4kpsVVR6gy0MySvdSSYj9Lwll6mW9toko4CGDqXyClHBYqpj3pN4T+zbqAqH302x870sG1pfm3m5oLYbziMJZOWaBuEE2ogbpNTloo+6VM7NwT3YEYaRpIs5un7FWOUlCfSnZa2axqUCV8N7MUfkKzVJrkHSjQFMhyzeW+QCiTdm1qktqX5wz0zzqRXIiq+JI48/foCjNr6HHx/MsjAgGaz+ktGVJMwDb/EO/OLy64KU1GOo+af9wdkQ+EoIl4q1FHcgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cj/GCtxQ/2c89RrAnuRhNjIEky/KAlSIAJITkCFjv4=;
 b=CWdT1WDvI/2k8WSIR+ENQbx9Gq2ftDPy6YFGXwkwcsavJF4wYfnu4s3RfULDlZPGbzjX7H8CPoesDL0WFuDOi3vC+0r7Oha5OyIlMt/e+8wZUyuweQj5EVnwrLhs7xJwSxfuXs4Nn5GiQum6iQIiAQrnF9puBAFXbrYy1htZqJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 19:13:19 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 19:13:19 +0000
Message-ID: <22dc9ceb-4b16-be68-ed8e-c6a222619032@amd.com>
Date: Wed, 8 May 2024 14:13:17 -0500
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
 <07266b47e749267ef9a9ccbc9e8e9df78ed54857.1713974291.git.thomas.lendacky@amd.com>
 <20240508080509.GWZjsyNS0xBXUzKPUG@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 05/15] x86/sev: Use kernel provided SVSM Calling Areas
In-Reply-To: <20240508080509.GWZjsyNS0xBXUzKPUG@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0040.namprd05.prod.outlook.com
 (2603:10b6:803:41::17) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee68ae4-487a-4a91-013e-08dc6f92ebeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFdHaXIzZ0lOYkpYeDVSS1BFS0tWNFVkdk1XZ0Y5dHozT0NKWjBjN0JUMFNn?=
 =?utf-8?B?NGdReVVuV3lVZCtzZUdKc0t0U3kwUEJqOEkxc296QXYxbzF0b0hKSW4wQTdN?=
 =?utf-8?B?TXpwbzNMelZXb29QRTAydkNNcG5hcjlEQWlRSjFkQXY1cmN3dGc2VkQ0MExy?=
 =?utf-8?B?aVVTazV0NFpsaVE4MzdLSFFzR2NsYSt6U2s3YS9DWEhieGphQnpYSUhua1RV?=
 =?utf-8?B?VjNhbi9mWXV4SEU2ZUR4TDY0S2w2TFpFSlNVSHpIWVozckNJRXphT1p3SDZi?=
 =?utf-8?B?QzdpNG01Vmhjd0NhRzV2YmY3Z1BSdXdDam85ZTRXK2sxTGRuR0VqOWJzRDBN?=
 =?utf-8?B?MHFFLy9waDd4TGdHbUZRUlRRd0pLU1dqWWZZQ2pZUWp1QVJhdWlZZnVOVFRl?=
 =?utf-8?B?UFRlSnNZYkdoYmMybnhHY2M2eXBWbnd0YUh1ZVgrZkFNNnh0QjIzcE5hNWdV?=
 =?utf-8?B?MFlJVmI1OW16Z0toWlFHZXpRTTA3M3dVTVUzOEEzQlU5UlZNUVl5UGxEK2Nn?=
 =?utf-8?B?ZzRxTG4yU1BtS1NELy9HU2liTXFqQkVoTXJrUFFtTkYvRzgwbjJXUW9iM1Fp?=
 =?utf-8?B?ZngvTTB6SEcrREdHOWRoT0tBZ0tSbEI5ZGh1MnVYVVp2d0tJQys4ZWhrODB4?=
 =?utf-8?B?UzVpK0VBd0QvNzFvNFZUR3Jpb1hqd25PZmY0aFpqOFA2Wmx4MjlkUkVLREd3?=
 =?utf-8?B?U3Bab1htVVNJNXgxQTV3a2pPMGRSam9XMlZpU0xoYTlHR1d4RVh0ajBJYXJs?=
 =?utf-8?B?emR6SmxwaTQrMFFMNTNLK0luS3lIaEhNQTQ0eDVPM1VSWk9Lazg3blpUb1A5?=
 =?utf-8?B?MlhQWUIvbkRTY2Fxd1JzNlJPblhabFBlODRNckFjKzhJbU9wWnZvTnIrSUhM?=
 =?utf-8?B?VWJXbHFncnpWd1RDZEVwL3M3a2ZOTHdWeTRKQjZxajhDOGdITDdiblVVVFBk?=
 =?utf-8?B?ZmRMaDZ4VVNsMjM5NnYrQWI3dVVvTDhxUFNibFFlSCtWMFBDL0JaU1JwU2Fi?=
 =?utf-8?B?eHRpV3VzOVZjN0JKRGhwc2lHNGFjN3NTdzhSYXZWUzdaUi9LZmhsNUF3c1Vz?=
 =?utf-8?B?b3pSOVM4aXAxcUNiMENmWUovcXdCTUF0bld0SXZ4bUs4SWhTaXIvdC9PVEZp?=
 =?utf-8?B?MCt6WDBiYmZhN3Fwa1hFRjJKUERLSkNhVDFFcWN5MjlSbHFkYVkrcndscmpt?=
 =?utf-8?B?ZUY3aUdJRjRyQlpiTDV2TS9JenRvcFRPQVkvbEdPcFhadU1jQzNoWFdhcDZT?=
 =?utf-8?B?SHZQSFpFemdBMzdkcm9yUUhTVW1lc1VlT2tRMGhiVWQxdXAwcGNwZ2hXZ0pv?=
 =?utf-8?B?NWpYbkJ2UVhvdmNFc0pRM1hwd2tYUTNYT3YyWkhMaFNUekllcWh2ZEYxWWJK?=
 =?utf-8?B?Y21HM3VoeWZmQWEzcG9tU3NQank3Q1dISG9OMGVBNmFwbDQ1b29oZ0Y3UG9i?=
 =?utf-8?B?OGFjazNVZGN4WTZWbU1WVlJBVVZ2YjZNSHVueWs5bXRNTjV4ck1ha3Z6clda?=
 =?utf-8?B?ODN3NnQ5R2FMU3F1VUFXS2E5bStqL0pFNWdvT0VzNWJpUkRXTVRwN3FoZm5m?=
 =?utf-8?B?cFMzc0xPc0pyMEFTdFVKTWVicnVWdjB3anRpR1RzOC9vZTl1SDRpTnZwMnF1?=
 =?utf-8?B?ekJGTHVPTElUMHdXSjE4RERKdkU5OFpOa3QvT3JHUjRsNk0xbTFqMmdrSzlm?=
 =?utf-8?B?R25BZkFoM01pU2N4YVYycDBiWE5SeENwc1hkTDJnS25HUlpwQmYyL2lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkN3MEZxVUMyWGM0N3B1Zno2Y1IrSVZSalQydTRIUU9OcXVuc0Y5ZTNEdzZY?=
 =?utf-8?B?WjFHVzc4VG9aQkRNa1hFNFBOTHJzZUJaREdlTjlKWVJhRlZKZU03MDI2QW1V?=
 =?utf-8?B?YzFJMGNLZHFwOEpXTGdFNi9jcG9qeDdjT0RETTVxV3dmcHF0U2NUS0hhVmdj?=
 =?utf-8?B?d2llZVFqa3dHZEg0WGJMTU9XVXRUbUJaOHY3RlZ0cHZ5T1l6WTAvNDR3ZHVq?=
 =?utf-8?B?L3daYlhCMkI3UnZQZXRhZTZWbHl0OXpjNy9zbVRaTEtBNkpVVXJTeTBITmFv?=
 =?utf-8?B?S1gvQnBHS1pGZ0lTODFYRG5SM2ZuWFNLcWpVUWc2ZnhOVUU5Qzk0NEhseDZZ?=
 =?utf-8?B?U2c5Q29WZjNmYzEzb2szbzRBMkJQYjBwM08rYnczZml4c3EzZTAyY2NuWXJx?=
 =?utf-8?B?NmNEaWlQQnlpUGlLc080R0R4WUpyNXR3YTFKbjdrQnpFWkdaY2Nha1BMMHlo?=
 =?utf-8?B?SDlwWFl1WVBJYjhTRXEzSHdHUEdHWVN1VldoMm94a3dBN0IzRzVtWG5YbDl6?=
 =?utf-8?B?RXFjdmNMSlRuRHdIbjRaemhhQ2QzNHZzclFpZVExMFkvL1cwZHhJNDI3aSta?=
 =?utf-8?B?ZkgvbkdTY2FMdFYxSzluYXBROG44UC95eTdjTm1naVA3TkVjT2owMGpaQmkv?=
 =?utf-8?B?d2pmYTB0c013cjdvcWs3R1BtemNmQm5rMXdlLzVqV0l1MlpDMHhQMDhoUmVM?=
 =?utf-8?B?c3drSFAwSXBPRnBIb2Rmbm1nYWJtaEhFd2dMVEM0SEpJYXgyVWhJOGtWc1o0?=
 =?utf-8?B?N1V4dXJjdU9lYUJuaGt5R25EelhMbzJGRjl5YU1JbDU5dkE0WitGdzJzYWQ5?=
 =?utf-8?B?ZXRnQlRUdmVlMXRFeDZITU1wSzNQSjhibzJtS25vaUZBUW1hZmJqMml3RGdG?=
 =?utf-8?B?RDNjRUUvZ1ZISXRudlZPZm90QWM0WmI1dHU1MXV1Vno0d2I5ZkNjNGdnYkcw?=
 =?utf-8?B?NDlKRDJaRjdvNUpGNTVCc3VUWmtULzNRR2ZjUldCL2t1bkM3Q3BheUZNMEow?=
 =?utf-8?B?U3VvVWthRmk0WmlzUFM4bkJ6WXNMck9TUHNmMi9pb3VFeXZobTQ0c1B3bFFU?=
 =?utf-8?B?MzhWOGRNT3hLeGJydlNxUjc5WlZOdnJ1NjR3c0g1MWMzdE16MVY3aG1kM1RL?=
 =?utf-8?B?QmlhVmpZY29RNTdHSnQ2VCtYamJ4eGVDR0Vpd2RiVis5MFJGa21vYkdxN1J0?=
 =?utf-8?B?SjJNY0xBY29NK3dzWDBqUEd0bjZtbXM3a0YrWno3QWlTUFRkS2lhRTZ2MXFw?=
 =?utf-8?B?Um9vWG4rWWdNbVFHSzZNb3dpVHlSNmw0V2FzQlpKUGN5T0NaeVBaT0JkbmZJ?=
 =?utf-8?B?ckNZT3R2UnUwTCt4UzQzbENaQnJiWFEvTDVxRWcrR0JQc242eFQ3cUFDWDFN?=
 =?utf-8?B?a1p1UEhUNnpVaFQ5djFPaWJteXlLcnFaREt4V2JZam9hRzFVTlBVRmR2RWI1?=
 =?utf-8?B?OTRqbVRtMFlWZXJRSjZBZExRV09FR3RtZldlakswSE1wcm0zbUtzVkRJNHBT?=
 =?utf-8?B?RXlUdXpXMFg1NzZQRnppWHdNS3c0aExFZ0RxMFpNMU5hR2JEdjRObzFiMm1r?=
 =?utf-8?B?VVU2d1AxdWJES0o3WEY5Rmh3bjRMMGxUQk9KWUZjTkdmOGswMS9BWGZEZ3g1?=
 =?utf-8?B?cUdraWxPbGVSeFdWRDNUQnZocFVCN3JHUEZRL1pocWpxdTlJZEc1M3doUW9t?=
 =?utf-8?B?bEt3MmZoM3FWM3NnZmxRTTFZZ015MENxV3dsRGp5WFpRTUQ0ZXBmenlpdFpS?=
 =?utf-8?B?bmhEaVorSG0zd2Q1elh4dkg1aG1iNGVESm0vbWFBMDZ6cnF1bUx3S2VWVzhH?=
 =?utf-8?B?UE9mc2d1dDZkZk9IbUtTeDNPOFlVaERsWmsvdHg5VmtiZkpkUVpOOWlGMGU2?=
 =?utf-8?B?MU5WaWlwa2E3QVh2dURFYndCSGpta2pjZVB0RWpCaGRib0Q0QVYwV2hFUjBn?=
 =?utf-8?B?UHNEbTljWUZ2ZEhUa0ZTaGZGT2Q3dmFGbTBkSHZTdjBISkJrbGJxU29mb3Mz?=
 =?utf-8?B?QThyQyt1OGVJeHU1VmdoME43UVdsQWl4NXhOZGdSQWRZOHNkY0FwbzBtcW5i?=
 =?utf-8?B?YUdGNHdzMUkrUDVDTXRJZWF3cDgzSkY4cTZjZjFqUnJ0eUx2SzVHUXIyTjhU?=
 =?utf-8?Q?6EaPj6LVtNtXAe6EkuwmYPWrM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee68ae4-487a-4a91-013e-08dc6f92ebeb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 19:13:19.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XY9IndBSVnhyz9hPW/BOKTQTFEgmBy5/UyJmLtwhmOjGqubA7OChHwmC/lCTq/KrfMdh9TrgxHqnwYzi6Abug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777

On 5/8/24 03:05, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 10:58:01AM -0500, Tom Lendacky wrote:
>> +static int __svsm_msr_protocol(struct svsm_call *call)
> 
> All those protocol functions need a verb in the name:
> 
> __svsm_do_msr_protocol
> __svsm_do_ghcb_protocol
> 
> or something slicker than the silly "do".

ok, maybe __perform_svsm_msr_protocol or such.

> 
>> +{
>> +	u64 val, resp;
>> +	u8 pending;
>> +
>> +	val = sev_es_rd_ghcb_msr();
>> +
>> +	sev_es_wr_ghcb_msr(GHCB_MSR_VMPL_REQ_LEVEL(0));
>> +
>> +	pending = 0;
> 
> Do that assignment above, at declaration.

Ok

> 
>> +	issue_svsm_call(call, &pending);
>> +
>> +	resp = sev_es_rd_ghcb_msr();
>> +
>> +	sev_es_wr_ghcb_msr(val);
> 
> The MSR SVSM protocol is supposed to restore the MSR? A comment pls.

Ok, I'll put it above the read where val is assigned.

> 
>> +
>> +	if (pending)
>> +		return -EINVAL;
>> +
>> +	if (GHCB_RESP_CODE(resp) != GHCB_MSR_VMPL_RESP)
>> +		return -EINVAL;
>> +
>> +	if (GHCB_MSR_VMPL_RESP_VAL(resp) != 0)
> 
> s/ != 0//

Ok

> 
>> +		return -EINVAL;
>> +
>> +	return call->rax_out;
> 
> rax_out is u64, your function returns int because of the negative
> values. But then it'll truncate the u64 in the success case.

I'll fix that and return 0 here and check the rax_out value on the return.

> 
>> +}
>> +
>> +static int __svsm_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
>> +{
>> +	struct es_em_ctxt ctxt;
>> +	u8 pending;
>> +
>> +	vc_ghcb_invalidate(ghcb);
>> +
>> +	/* Fill in protocol and format specifiers */
>> +	ghcb->protocol_version = ghcb_version;
>> +	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
>> +
>> +	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
>> +	ghcb_set_sw_exit_info_1(ghcb, 0);
>> +	ghcb_set_sw_exit_info_2(ghcb, 0);
>> +
>> +	sev_es_wr_ghcb_msr(__pa(ghcb));
>> +
>> +	pending = 0;
> 
> As above.

Yep

> 
>> +	issue_svsm_call(call, &pending);
>> +
>> +	if (pending)
>> +		return -EINVAL;
>> +
>> +	switch (verify_exception_info(ghcb, &ctxt)) {
>> +	case ES_OK:
>> +		break;
>> +	case ES_EXCEPTION:
>> +		vc_forward_exception(&ctxt);
>> +		fallthrough;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return call->rax_out;
> 
> As above.

Ditto.

> 
>> +}
>> +
>>   static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>>   					  struct es_em_ctxt *ctxt,
>>   					  u64 exit_code, u64 exit_info_1,
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index a500df807e79..21f3cc40d662 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -133,8 +133,13 @@ struct ghcb_state {
>>   	struct ghcb *ghcb;
>>   };
>>   
>> +/* For early boot SVSM communication */
>> +static struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
>> +
>>   static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>>   static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>> +static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
>> +static DEFINE_PER_CPU(u64, svsm_caa_pa);
>>   
>>   struct sev_config {
>>   	__u64 debug		: 1,
>> @@ -150,6 +155,15 @@ struct sev_config {
>>   	       */
>>   	      ghcbs_initialized	: 1,
>>   
>> +	      /*
>> +	       * A flag used to indicate when the per-CPU SVSM CA is to be
> 
> s/A flag used //
> 
> and above.

Sure

> 
>> +	       * used instead of the boot SVSM CA.
>> +	       *
>> +	       * For APs, the per-CPU SVSM CA is created as part of the AP
>> +	       * bringup, so this flag can be used globally for the BSP and APs.
>> +	       */
>> +	      cas_initialized	: 1,
>> +
>>   	      __reserved	: 62;
>>   };
>>   
>> @@ -572,9 +586,42 @@ static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t si
>>   	return ES_EXCEPTION;
>>   }
>>   
>> +static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
>> +{
>> +	long error_code = ctxt->fi.error_code;
>> +	int trapnr = ctxt->fi.vector;
>> +
>> +	ctxt->regs->orig_ax = ctxt->fi.error_code;
>> +
>> +	switch (trapnr) {
>> +	case X86_TRAP_GP:
>> +		exc_general_protection(ctxt->regs, error_code);
>> +		break;
>> +	case X86_TRAP_UD:
>> +		exc_invalid_op(ctxt->regs);
>> +		break;
>> +	case X86_TRAP_PF:
>> +		write_cr2(ctxt->fi.cr2);
>> +		exc_page_fault(ctxt->regs, error_code);
>> +		break;
>> +	case X86_TRAP_AC:
>> +		exc_alignment_check(ctxt->regs, error_code);
>> +		break;
>> +	default:
>> +		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
>> +		BUG();
>> +	}
>> +}
>> +
>>   /* Include code shared with pre-decompression boot stage */
>>   #include "sev-shared.c"
>>   
>> +static struct svsm_ca *__svsm_get_caa(void)
> 
> Why the "__" prefix?
> 
> I gon't see a svsm_get_caa() variant...

There probably was at one point and I missed removing the "__" prefix. 
I'll take care of that.

> 
>> +{
>> +	return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa)
>> +				       : boot_svsm_caa;
>> +}
>> +
>>   static noinstr void __sev_put_ghcb(struct ghcb_state *state)
>>   {
>>   	struct sev_es_runtime_data *data;
>> @@ -600,6 +647,42 @@ static noinstr void __sev_put_ghcb(struct ghcb_state *state)
>>   	}
>>   }
>>   
>> +static int svsm_protocol(struct svsm_call *call)
> 
> svsm_issue_protocol_call() or whatnot...
> 
> Btw, can all this svsm guest gunk live simply in a separate file? Or is
> it going to need a lot of sev.c stuff exported through an internal.h
> header?
> 
> Either that or prefix all SVSM handling functions with "svsm_" so that
> there's at least some visibility which is which.

There's quite a bit of interaction so I'll make sure to prefix everything.

> 
>> +{
>> +	struct ghcb_state state;
>> +	unsigned long flags;
>> +	struct ghcb *ghcb;
>> +	int ret;
>> +
>> +	/*
>> +	 * This can be called very early in the boot, use native functions in
>> +	 * order to avoid paravirt issues.
>> +	 */
>> +	flags = native_save_fl();
>> +	if (flags & X86_EFLAGS_IF)
>> +		native_irq_disable();
> 
> Uff, conditional locking.
> 
> What's wrong with using local_irq_save/local_irq_restore?

The paravirt versions of local_irq_save and local_irq_restore can't be 
used as early as this routine is called.

> 
>> +
>> +	if (sev_cfg.ghcbs_initialized)
>> +		ghcb = __sev_get_ghcb(&state);
>> +	else if (boot_ghcb)
>> +		ghcb = boot_ghcb;
>> +	else
>> +		ghcb = NULL;
>> +
>> +	do {
>> +		ret = ghcb ? __svsm_ghcb_protocol(ghcb, call)
>> +			   : __svsm_msr_protocol(call);
>> +	} while (ret == SVSM_ERR_BUSY);
>> +
>> +	if (sev_cfg.ghcbs_initialized)
>> +		__sev_put_ghcb(&state);
>> +
>> +	if (flags & X86_EFLAGS_IF)
>> +		native_irq_enable();
>> +
>> +	return ret;
>> +}
> 
> ...
> 
>> @@ -2095,6 +2188,50 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
>>   	return cc_info;
>>   }
>>   
>> +static __head void setup_svsm(struct cc_blob_sev_info *cc_info)
> 
> svsm_setup

Yep

> 
>> +{
>> +	struct svsm_call call = {};
>> +	int ret;
>> +	u64 pa;
>> +
>> +	/*
>> +	 * Record the SVSM Calling Area address (CAA) if the guest is not
>> +	 * running at VMPL0. The CA will be used to communicate with the
>> +	 * SVSM to perform the SVSM services.
>> +	 */
>> +	setup_svsm_ca(cc_info);
>> +
>> +	/* Nothing to do if not running under an SVSM. */
>> +	if (!vmpl)
>> +		return;
> 
> You set up stuff above and now you bail out?

setup_svsm_ca() is what sets the vmpl variable. So nothing will have 
been setup if the VMPL is zero, in which case we don't continue on.

> 
> Judging by setup_svsm_ca() you don't really need that vmpl var but you
> can check
> 
> 	if (!boot_svsm_caa)
> 		return;
> 
> to determine whether a SVSM was detected.

Yes, but the vmpl var will be used for attestation requests, sysfs, etc.

> 
>> +
>> +	/*
>> +	 * It is very early in the boot and the kernel is running identity
>> +	 * mapped but without having adjusted the pagetables to where the
>> +	 * kernel was loaded (physbase), so the get the CA address using
> 
> s/the //

hmmm... CA is Calling Area, so

   "get the Calling Area address using RIP-relative"
   "get Calling Area address using RIP-relative..."

The first one sound more correct to me.

> 
>> +	 * RIP-relative addressing.
>> +	 */
>> +	pa = (u64)&RIP_REL_REF(boot_svsm_ca_page);
>> +
>> +	/*
>> +	 * Switch over to the boot SVSM CA while the current CA is still
>> +	 * addressable. There is no GHCB at this point so use the MSR protocol.
>> +	 *
>> +	 * SVSM_CORE_REMAP_CA call:
>> +	 *   RAX = 0 (Protocol=0, CallID=0)
>> +	 *   RCX = New CA GPA
>> +	 */
>> +	call.caa = __svsm_get_caa();
>> +	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
>> +	call.rcx = pa;
>> +	ret = svsm_protocol(&call);
>> +	if (ret != SVSM_SUCCESS)
>> +		panic("Can't remap the SVSM CA, ret=%#x (%d)\n", ret, ret);
>> +
>> +	boot_svsm_caa = (struct svsm_ca *)pa;
>> +	boot_svsm_caa_pa = pa;
> 
> Huh, setup_svsm_ca() already assigned those...

setup_svsm_ca() assigned the ones from the secrets page. The kernel now 
switches to using its own CA.

> 
>>   bool __head snp_init(struct boot_params *bp)
>>   {
>>   	struct cc_blob_sev_info *cc_info;
>> @@ -2108,12 +2245,7 @@ bool __head snp_init(struct boot_params *bp)
>>   
>>   	setup_cpuid_table(cc_info);
>>   
>> -	/*
>> -	 * Record the SVSM Calling Area address (CAA) if the guest is not
>> -	 * running at VMPL0. The CA will be used to communicate with the
>> -	 * SVSM to perform the SVSM services.
>> -	 */
>> -	setup_svsm_ca(cc_info);
>> +	setup_svsm(cc_info);
>>   
>>   	/*
>>   	 * The CC blob will be used later to access the secrets page. Cache
>> @@ -2306,3 +2438,12 @@ void sev_show_status(void)
>>   	}
>>   	pr_cont("\n");
>>   }
>> +
>> +void __init snp_remap_svsm_ca(void)
>> +{
>> +	if (!vmpl)
>> +		return;
>> +
>> +	/* Update the CAA to a proper kernel address */
>> +	boot_svsm_caa = &boot_svsm_ca_page;
>> +}
>> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
>> index 422602f6039b..6155020e4d2d 100644
>> --- a/arch/x86/mm/mem_encrypt_amd.c
>> +++ b/arch/x86/mm/mem_encrypt_amd.c
>> @@ -2,7 +2,7 @@
>>   /*
>>    * AMD Memory Encryption Support
>>    *
>> - * Copyright (C) 2016 Advanced Micro Devices, Inc.
>> + * Copyright (C) 2016-2024 Advanced Micro Devices, Inc.
> 
> Are we doing that now?

Looks like a leftover change... will remove it.

Thanks,
Tom

> 

