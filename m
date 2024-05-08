Return-Path: <linux-kernel+bounces-173789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B86458C055B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9381F220B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA833130AC7;
	Wed,  8 May 2024 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PKICXTfM"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C6130AE6
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715198954; cv=fail; b=ThGxB+KJwpX0LAOAQRzn5daBZLOaH2xIuqNVs9sb9Xd39Zya0sP0omJD52ZslO1hQzF0lou8LLLCUdVp+fVRVUdIwxlirwkzaQmEt4zQ+0vPmQhFWM+dFEQ8kzi+JWfZyN+RFWhHdplWsKplAoqdU+rhybxLYq1JZ+9KZVrTjPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715198954; c=relaxed/simple;
	bh=bIjmME8ZIBdUG+WigxTPZYhR3iL7XZOYcshAshtIeqE=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=FZuLcUoekWqqOuVvhxsBQGrNeSCA5baG45Nzcg+jJke9HtUtolM4hwrDGDgzMEXminKNu40TDsttdBZ/N801Nn/L1zLAxx2/LsF79X8gEdRtosniJhh3ohKhvvc2lYxhUzNZ/Cb9ch+vTfhOZBH5iZ8N9m1ieWET9aq9oOxfPMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PKICXTfM; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6PyJW7o0mlhBCZHXpt381WSFKkOnHZXr2L84zlBfIhrKg2o+EE/54A1Co3e2k7RkZHNTzrsuLpHtTeFLsC0+YpvcLS++PSSBmbm+qeb9ipxNl3B5luLqmNluAE1jIvHYrlCs+ZX0azQ2h6ndDd+rXf8hv5osuGRdnG8LsJ2I42mpDm3x2BVfT7eovg1smO4TbgnEzsuJYRBi9UVPPuhkDOlBFcLxzzbyWHIqJR8/k3yjefMQ4zT/Ap0v0+ilzuABa4lSIIWyoj0xKP6m2XzD/zgoqc4pub+XkHq3xDDuyVRre0eo7T48cxBCeGUfkw35gQn6svg++5qIzm7BWNt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moyDe9WUoXzCNjGYvs041/i1I+Z8FRGciDZwanAxVcQ=;
 b=VfM+e8MoaTbJIqwg1uQ90g4GVJ+LeUaD9q3NMlp/QacpyLwGTZccpiVTerruvRjExpTs9NDgnVDZOd7JHWo+WkPDnA5rSnDI/wdUwpNAVrl1FKSqzMdB8YO+FtZWWXD6+YSnRNdgW35Chr0j5TOv4a3dltEsXzgiLyZpcai40iTdnoLXD7V1o0bg7j5qirehe7+aB4flBA8xbHw92qWU7KbzbiBTSrYK7AvDJipvvm30iHYLr7NpwHIUllmftdmmg1B1S3zDN4NLPHvxUoqEzTR3XC5J8uMpySG/MUodLNxFX7hRMq4WPO9ccuamogr6k7E2hUeDf/81v+M+/IpQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moyDe9WUoXzCNjGYvs041/i1I+Z8FRGciDZwanAxVcQ=;
 b=PKICXTfMJMNdV1GPKYadkzt9+mIWBJgxco7tay3olYbzQiRU2X0tvvr8GBpG2lwMAXbUuPPnRlBsnorgSKT5b3PPMrjrYHm9kHzzg0gGVsCLl7XmTr73x31sNwlW0g5lt4b3KWbU8tWen00qowDsjFeFi7Fgfm8tFRXmDXtOEqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 20:09:06 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 20:09:05 +0000
Message-ID: <d3b59450-fdbd-2813-bbc0-58f9dc2ba817@amd.com>
Date: Wed, 8 May 2024 15:09:02 -0500
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
 <22dc9ceb-4b16-be68-ed8e-c6a222619032@amd.com>
 <20240508195842.GIZjvZcpRz0bdkiPWA@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 05/15] x86/sev: Use kernel provided SVSM Calling Areas
In-Reply-To: <20240508195842.GIZjvZcpRz0bdkiPWA@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::25) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: b3205069-08ef-4e68-f2cf-08dc6f9ab60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3JDSFVyOEZZaUpnTTlRMHR2RzVZOUVqNjk3ZjJEc1gzdDZSOFduOFJVNkdr?=
 =?utf-8?B?WDFoeWlaeXhCeFducHI5MERybGc4VVgyKzZLRy8rTUtYbUl5ZnBpeXRCU2xx?=
 =?utf-8?B?a3M0dDQ3MjJUOFBodFE3dHI5N01ZdGZpODJaVWg3T2R2NUtlaDQ3bURmdDc1?=
 =?utf-8?B?R3o4M3NOTkNobHQ2K1dMUjFRalRsaG13ZUNCLzg0aEdQYWI1Y3BpeDd1RitD?=
 =?utf-8?B?UFpHa3BWMHJrVDlDaEQ0d0gva0VESVZnTE5tbjZ5NmJEVzc2VkRmcnZ3eHRS?=
 =?utf-8?B?RG5YUm5xbkRCRTlVaG1tWnA4cHFSdzN5ZG5UbXdkRWJ0aDk5VTFDU3o5ZGdu?=
 =?utf-8?B?MTV0YU1RT01pWmdXSlphR3JsYlZQQVlSaUdSQ21XVlkydmpqVFg3T3U5clNp?=
 =?utf-8?B?Y0lMVVdBTkJPRDloREx3OS9Ub29sQ0dqbHRwazdtT1lReFNyUFhFR1owclFq?=
 =?utf-8?B?SWdSb2RYZ1dadWZFZWFkWUZyakp0LzdMNHBLSGh4bVpoSkN5emJtNysra3Zr?=
 =?utf-8?B?T0p6UFBhVFEwOUg1QjFKcDRSS3VkeFJXZDd4aGg1ZExMUmxjM0tPR3hvQmpK?=
 =?utf-8?B?S1RVamdaQU9zZEkzU3k0cGxtK1JDc0JVWGtnK1Y5ZzVXYncxcUNJM0pqeHJs?=
 =?utf-8?B?MDZaa3ArbUNRRnFqQ0g1UU9xQTBKbmRRcjNlc1RKcjM4RlJYMVQ0YXFYUjNV?=
 =?utf-8?B?MHFvS0x3aElyc2hvVy84MFZpMm1uV1cvUzdDWEoxT2I2NWxJN3p4OVBTN1B0?=
 =?utf-8?B?bXdxNmJYMHF3VVhQaUV3TkFCM3ZsNEpnUkNIcGJUd1g4b254OEVsN3l6ZHBo?=
 =?utf-8?B?RnlUcWt3ZWdtUG5OaGlFZmRjQ254MEx5V3lHNHBuTS95TW1rbEJYWDBWNGl1?=
 =?utf-8?B?UnFvSVFERDdFcEx0SStuTm1pOURTb0ZKMTRPSmR5Sm1MMDJZTVlkSnV3MUlD?=
 =?utf-8?B?SldVRHhhQWpUeFlldHorT2dtVFVtVVNGQ0RTTUV1S3ZaSnlYcDZjK2FsSUJD?=
 =?utf-8?B?aGRIVEVicUVScVBJWVdRY05sbEk5SDVSZ2FDVHpYZGNVbVUyS2tsaUN0Skhh?=
 =?utf-8?B?NlphbGJXd1pNNVJBK3dLaW5VYXlLMmxHb2JqK1loZll1UmtwV0ZyOC9FamFi?=
 =?utf-8?B?WFdIbTJYTGxKRnZYK0srcnJsTEpDQUdTNDdPQysrMkptK0h2dnBRYnNMMGVt?=
 =?utf-8?B?T2ZaQWdjcmRNSmc1ZFZmbWZBT2k1K29CeG1XOC9jbnFVcjIwSDJvdmNHdWpq?=
 =?utf-8?B?eXAvVG9uM3NiRkR2d0REcWR2ZEJhWExMVWptdFVwWTdRWXF0L1RMNWJ1RlNn?=
 =?utf-8?B?bVAwMkYxZmdhT0hLVUdweDhLcFRkRjc0WkIrWXpWSmtyeDdSQ09NRkloRmtm?=
 =?utf-8?B?T01xNkxXVm11RldIMHhGYjc1M2I0VE94Uk44Vi85ejJ3Z3dSdmdBcHlDMnZQ?=
 =?utf-8?B?QWFEVjdrOVRyUEhSS0owRTN3MnVJZlUzR3Z2a2VXVm1hMGMzOHp4aTU1bWd6?=
 =?utf-8?B?QUJBN3dWTlFDNEJkem9qRUtPM0d6NXRDRzBDazRZS05uaGZNYTdOWGVQVWFl?=
 =?utf-8?B?RlM1eU5XOGxzbHpEcmdscE1QQVJmK0EvQk4wNkw1MUpqTkRJVGRVRlNMOFR6?=
 =?utf-8?B?aXZkWm9WSjhRUXJrSVlMQ2NjS2pqRHFQSVNvTEdEUE1FS09idlhsYlRwVzNF?=
 =?utf-8?B?UXRuWGlISU12aFk5VHdOcGQyaWg4Y014QWVpcFl3eEpjSE1pcVhmNnF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVppYldrU3lmVnQ1UEluR2lEUy80NDJZbVNSeGtaZm5wdGZjODd4ZksrQlBt?=
 =?utf-8?B?Wm9iQW1hQmNoWXhuOWxoNzlCZ2JXU1JJNlRxSmV3WENVTEZNYWhhUWFRd21V?=
 =?utf-8?B?bXBYWFVmUEdoL0VvSXA3cDZ6dXdNRDBWRjFsYzh5Y1BMOXZFQ3pKeEFma3p5?=
 =?utf-8?B?TkV5S0kyUHA0T0NvMmREMnVjTnZsZEp4cWxtN1MrSW0zQm1tSW1aN1ZIZmk2?=
 =?utf-8?B?RVVzVGNaOXhDdEhON01wNjNMY1BwS2swUXdjOU1ud2xISlFNUGMvM1puWDZ6?=
 =?utf-8?B?czdhQ29McHpFTlFUWTRlc2JINUFGRXJ0WjlnV2ViQ3Z5ejQyUGREWlhEMUJl?=
 =?utf-8?B?QVNhTG05SG8rZFBJZ0VPcEJhOXBBK0NIaUl4OE5BclRMNG4rTTM1Z21OaXVN?=
 =?utf-8?B?SERlTHZsZ0ZuQjUrK3JLWWsrR09JYWtsSXpHSHJhNVhYOVJmR29qa0QwNGRj?=
 =?utf-8?B?eHFsQ0czeXI3RG5uZjFJaTJyT2xjODNwWDF0NXBWbW5CMHFrODZ1QndkMWQx?=
 =?utf-8?B?QmJLcmlGSUlOS0dwR3ZHaVRwendGYjduSXN5ZGZlK0I5Q0R1bEs2b29obGhE?=
 =?utf-8?B?aUx2UDhoRU9oSXVIWlN6ak9MZ3cyb0NPSHRtUUdHV2dWK0NoU1RGaUFiMllv?=
 =?utf-8?B?OXFJSEliQytBZVpPQmw1SkdUSmYzU1NIbUYzNXBHbVYydDdNVmZoRGlPdG1U?=
 =?utf-8?B?OFl0ZU1JMDkvejVZdFR4TzFCRHE1ZUNUM2N0cEQ0emZUNm5qQVg3TWNoUWhV?=
 =?utf-8?B?TUgzVHFEdlRtUnVZNlhNOStTeUtHM2gyM1R5elA4eGFQYlRnUTJ1MW83RC9K?=
 =?utf-8?B?VEEyb0ZsRlpKQ3BQeWhZZTFRdFBNUnNwWTdDWFJSbllRQXFxK0hjN0JsSmFq?=
 =?utf-8?B?MGc4OUtkVUZWTW9kekRFeDRjaWhZVXQraHNER1U0L280TXF2QVpQMkNrc2dx?=
 =?utf-8?B?RVhUZC9wSnJDcThlUHhxRitaTno3dGlER1MrT2pXYlhOVkhQNk9QTll2cHRj?=
 =?utf-8?B?RTlBME1qZVBhOEtqTTRBMHRFM08zSVNxWVg2aTFmQnVaZWVCdXlLYmtXOFky?=
 =?utf-8?B?TGp2QjNFdnFxcXdQalE0UnlIdFdnK0dVTDAwdjhxMlZucGViWkNjbUpWSnM4?=
 =?utf-8?B?Ynlsd1Z0RjJSL29XTW9xbHpFbjJ1eVYrMU1ncERCNHZNcDY1cEdvUHRVSGhV?=
 =?utf-8?B?alFmejJZeSszVnFEM2twckttQjdaZm5YY0RXei9MMi8zQkNSTzVqbU5LTnZ0?=
 =?utf-8?B?QUg1NFp1U2VoK0toc1h4SWxQZVkzY3UrK3JVWUJ2SStJL3IyNktiTkpDTDg5?=
 =?utf-8?B?b25oTVMxRVNENGYvSE1DM1VHWjZReFBqM05nSWxpYkgxVHZ0TTY4TkQ0eGpi?=
 =?utf-8?B?SEF5QWVzS29jbmpra0laUWhqZmc1cG5Vd2JUOEJKQlJVWlByYnQ3MjhXMHV1?=
 =?utf-8?B?Zm1NZjZvaitoY05JTHhEQmlKTExTVlRuSWU5UG9zbnFBSWxIaEthNUhuQ2pj?=
 =?utf-8?B?SVI3UUorSWZIYkYzb1BZTVo1bWYvZVI4ejMwTmwwRGxjWXNOR1UwVlJiQWdh?=
 =?utf-8?B?Y2k0VitoNlpUMGJ2bUJTWmhEdUU2ZmM2OGhSUFQwOHY5b1c3bHl0Z3pUKzRQ?=
 =?utf-8?B?dDdOLzJrak5aVmRiWk5IMXFHQTcybTh4MDhNR1ZiNkE4TU5uSFBDN2dEMDZu?=
 =?utf-8?B?djl6VWp5VE5ZNGFCY21FekJSQlExcEJnM3hjWkwyY0hVRHpDOGIzblVVaVM3?=
 =?utf-8?B?MVNYY2R2T1N2a2FndTlnSm9oaGpkQVF1VVVXbkVKd0ZoUzg2V0NEek1ZUysz?=
 =?utf-8?B?TXZaaVo5b253bG96c1M1U1VUR1JTckE3TGh2djFrektUMkxqcnM0YjBsREJC?=
 =?utf-8?B?ZDVILy92Z3Bnak5EU3VlWkc0cjRJZm1vbklGMXhwZnNwYTFxQnBQcDFPUFpl?=
 =?utf-8?B?VGloeWtpMEhWR1psTVlrNW05Z3hsNHlLSHpTd3k5VjZEdmQ0VE5oTXdBcW5M?=
 =?utf-8?B?Y0hiaFJtUW5aT3AyU3RqMHNPZFNWd2E2cnM0TExLUUNDUm85RjRPYmpHQnhw?=
 =?utf-8?B?bmdMVy9SWkYzZkpwNGZ2a3kzbE5HeGtUbjF3WEFOU3JFOStnK0tBTnBQWlFZ?=
 =?utf-8?Q?MdCcOdPibU2hyQ7Y3CzEhRex5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3205069-08ef-4e68-f2cf-08dc6f9ab60f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:09:05.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cPhO3wV7UjBn1q6DLatU+AsgJTCmpCkjPgl8S80UuMj2oBfF9yOW6QujUasiQGcyIwqD+9QeBRsr/qugRuF1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004

On 5/8/24 14:58, Borislav Petkov wrote:
> On Wed, May 08, 2024 at 02:13:17PM -0500, Tom Lendacky wrote:
>> ok, maybe __perform_svsm_msr_protocol or such.
> 
> We'll bikeshed it in the coming weeks.

:)

> 
>> There's quite a bit of interaction so I'll make sure to prefix everything.
> 
> Ack.
> 
>> The paravirt versions of local_irq_save and local_irq_restore can't be used
>> as early as this routine is called.
> 
> tglx says you should do native_local_irq_save()/.._restore() helpers
> just like the arch_local_irq_save()/..._restore() ones but use only
> native_ functions without the paravirt gunk.
> 
> In a prepatch pls.

Will do.

> 
>>>> +	struct svsm_call call = {};
>>>> +	int ret;
>>>> +	u64 pa;
>>>> +
>>>> +	/*
>>>> +	 * Record the SVSM Calling Area address (CAA) if the guest is not
>>>> +	 * running at VMPL0. The CA will be used to communicate with the
>>>> +	 * SVSM to perform the SVSM services.
>>>> +	 */
>>>> +	setup_svsm_ca(cc_info);
>>>> +
>>>> +	/* Nothing to do if not running under an SVSM. */
>>>> +	if (!vmpl)
>>>> +		return;
>>>
>>> You set up stuff above and now you bail out?
>>
>> setup_svsm_ca() is what sets the vmpl variable. So nothing will have been
>> setup if the VMPL is zero, in which case we don't continue on.
> 
> You still assign
> 
>          /*
>           * The CA is identity mapped when this routine is called, both by the
>           * decompressor code and the early kernel code.
>           */
>          boot_svsm_caa = (struct svsm_ca *)caa;
>          boot_svsm_caa_pa = caa;
> 
> regardless of vmpl.

If we're not running at VMPL0 (based on the RMPADJUST check) and if the 
SVSM doesn't advertise a non-zero VMPL value, we will self-terminate. So 
those values are only set if we are not running at VMPL0 and the SVSM 
has provided a non-zero value to us.

I'm going to turn the function into a bool function so that the call 
becomes:

	if (!svsm_setup_caa(cc_info))
		return;

> 
> I think you should assign those only when vmpl != 0.

I do. I think you're missing the RMPADJUST check that causes the 
function to return early if we're running at VMPL0.

> 
> Otherwise the code is confusing.
> 
>>> Judging by setup_svsm_ca() you don't really need that vmpl var but you
>>> can check
>>>
>>> 	if (!boot_svsm_caa)
>>> 		return;
>>>
>>> to determine whether a SVSM was detected.
>>
>> Yes, but the vmpl var will be used for attestation requests, sysfs, etc.
> 
> I guess that comes later in the patchset...
> 
>>> Huh, setup_svsm_ca() already assigned those...
>>
>> setup_svsm_ca() assigned the ones from the secrets page. The kernel now
>> switches to using its own CA.
> 
> Comment pls.

There's a block comment above it all, but maybe it isn't clear enough. 
I'll rework it.

Thanks,
Tom

> 
> Thx.
> 

