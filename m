Return-Path: <linux-kernel+bounces-224800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AD09126FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC7E288FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB94688;
	Fri, 21 Jun 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P0/Ocgao"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62818631
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977857; cv=fail; b=W1/lr6PcLojz9YEud6GmRbyYOs3n1+TTmoidex08WP1keyB4RZlGbutVRMAMf6gbc4AMC9+9Vby2KBULZ6XSruQZagFb7EYIYmlO/XCsdAiDWqMu1L4XWn0ZMGmFw4noXqnCoIbpTHrBVjlzNY/oGEvfQjZDcrWaEybxhFYbMUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977857; c=relaxed/simple;
	bh=f4YWEf1oGi5hU8N/9Y/va1Lc0x7h1yIkDY62L+/rnCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N1KjGSVftzLRrhuKi9KOFF0HEPdlX3qgLX4H3ieU9NNq8nX24KA3TQ8Cyl/AR47ogt8yy1+lWWIbnVAoQa0fsUenJ5jERUMBuf8dHBsoR+Gz2grMqEQUYoSYyVSR8dY3NskL87s4y+IqOYHioCsmSAFevadGU4vEQQvc/OOafWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P0/Ocgao; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuQCc7KvSXtlTayyr4mJfVbi69ImdxuUMy1M7WOI+yxpr6t/U5QVldcr0dQM4LaHLZ0ekzq0OkX9zzUFrH7zXII/Bi/IIg7YaqPZxb4ge4lqSXID3dlWXmJUsP+gm/S/o+58mjI+BQd50TFbLlWwyMp9oBBVc1lkSSg/hDlMZV0cG7/YDGMSEGovpELdoh32YnrlXawJx+f7sudNl+F6wDYT8KCGUe/zxboF9tTwe8zyvfeJcujqDMH8sjZr3NmQ85RG8PRNVSyHydMAjzORCr9nii6YUlKP1hEYiGHLUpm1Z3hEEsVHPutcpTpAYaSrOkX2uiwKp+xrDgRShvtClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMujnvx2qrBFNVFO6JUlM5EavgCY84W0uuQhxq7fSaU=;
 b=eVXgYtwrYYqeHR41Rze6pjxzLkrA6sEADltYGqo7c94lf2AXzMomJU4lVaKUoI/7o9i9rnDEaNTexbojLplH/LMgbOeoKFGW9AsM/o4WyCtVAZ57bTVxjdQWNrWiZtdQXr9l7e/qLRaxkMto3AgPL3VfgDRr5995XjL1wofQxAvII9a6hUIzL051oNPIqei0d6oDLhsnWOhDhQW76DkkWaOJzteJP7RZaMgjqWmXI9htnAzgcbCsjOlLeJEYlhIFiq9sFZ6PC8NZcquKYfWVQTlkps5u2eWJyCEIdjIe2SioA9TpsamcNv4FWV++Tm26910xSbEzg/+JhETtOetdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMujnvx2qrBFNVFO6JUlM5EavgCY84W0uuQhxq7fSaU=;
 b=P0/OcgaopREPBDizJ5civ8sgU3DA0gBcLZ5dcnCyq2bB3K3BpmM0/U3+HkiXZLVSwBOb4EPpm1+iGJ/FCr9xdcwDrR8Z42ZTaUxjc2o/JDdQqaff1CJ/lCe7UMP44g0LBkZ0r5pKD6E9NUxQVrALzE3hovybLsOh+/yI3RsyPa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 13:50:51 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 13:50:51 +0000
Message-ID: <cc92836d-3d29-52e5-f28e-f177153ed688@amd.com>
Date: Fri, 21 Jun 2024 08:50:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Move SEV compilation units
Content-Language: en-US
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, Ashish Kalra <Ashish.Kalra@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Michael Roth <michael.roth@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>
References: <20240619093014.17962-1-bp@kernel.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240619093014.17962-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:805:de::38) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5ddf2e-498b-4b2e-10fe-08dc91f929b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2FCcGtUQWZBYzlYVnllc2hLUWoyR1RGSUhBSWZ1T0sxeGNKQ2Y3a0JkaGt4?=
 =?utf-8?B?RVdmb2FoNTNRU0trajlMK1BDYUx2bEJ1Qm9pSnBkWEVBQzFFUDdDNnV5RlVz?=
 =?utf-8?B?M1RrMmQyNjV6dWYzMWdnTUE4ZG1ZUmdPS2pRTFRFQUsyRHVnai93cmFEcWRI?=
 =?utf-8?B?elhES1FZQmd3TlNrR29OS1lWZjNnWWN0YjYwL21XTDNUR3dkbStVajVHbGpz?=
 =?utf-8?B?Z0puRjBEdUxjelVLc3ZBK1NBK3ordEtvaXVIeEhRYzNKRG8xK1ZLQkFkMWk1?=
 =?utf-8?B?YWpzY1JDTUp2TjdjWVVEbDNBRGczdmdFOC8rK0oxSWdyODZpZWE3ZngzZ3Vw?=
 =?utf-8?B?QXVYNzZKZzRFU0s5SnNEQ1BsOE96UWZUUVdnTmhjOXVmN3ZydDNQdmNWTTc5?=
 =?utf-8?B?NWkvZUd3L3VFYnNzNU9naEY1VzY5T3ZKOXpTQ1UwaTNIRmZaRG41WWVXOXpC?=
 =?utf-8?B?R2E4V3oybGhUNnNqYkRNRHJqRG9FdlZnOWRJUHhPTkZha3E0cFdXTE5SWHVL?=
 =?utf-8?B?YlBGSFRDd0Z6Nk90TEZsM1hZaDRhU1B5cC9XRlRXMzdBQUw0UVF6UW1yRHdC?=
 =?utf-8?B?QnQvdCsxZXkvWDlVaitLM1ZQbWFWSVNPeTBhUDFQVWJUTkdiWUhsTWhqM2w4?=
 =?utf-8?B?ckZVOXN0aTRiUml4VXhhQnRyeHJXYU5UeFJPVGZWcldTc0tLY2dlNEdQVWVU?=
 =?utf-8?B?aTJ2ZDF2MVBQejdnTFI1TUkwbjNqTjE5Y3ErRXZXa0VIUmFnRm1pQjhUUy9z?=
 =?utf-8?B?ajhacndacS9TUmE4SW8rZFRoY0t1WTBqdjhUeEdONVdZbjJ0dnR6Slk0MzZx?=
 =?utf-8?B?QmV4N3Z1KzJ2a1VmeGV3RnU5QkM2WXZvUGFNUWd3Z1JraHVoWmhvajRBUFNa?=
 =?utf-8?B?cVFlWGk4ZDNVRUxIL3NnT1hxMkNJaUVSVE1DNmlob3hEd0VIUHNJYzNWeVRl?=
 =?utf-8?B?bFlkYVN0Rk5BcTFhbGM2alJ4ZThoZkNzVWc4NlE2SkdrYzByckVjR2tOUFFE?=
 =?utf-8?B?ZmV5bCsvUExrUzFtQXM4QlpQa2VPWkpYZFlOTWRlOCtranhiYy9FR1J4a0Fx?=
 =?utf-8?B?M1M2dFRYVFZza2dqbGZ5K3c2ckZwZjJwQ2FUZ3poMG1FU3d0WDBpdnZ2eTMr?=
 =?utf-8?B?VDVKNVdtWTh5aUVaUElEV2s1UGtGREhQdklhZ3BHYU1tekp2VjgybDhOYzFo?=
 =?utf-8?B?UmZwbnltaWZhUjQvaGg1cEpyakRlNm5yV1JzdSthNFZzY1ZQc2d5R21lcnNo?=
 =?utf-8?B?S2dZTmdlRHlJZWFIRlJzN2RCVnlmdjR5c25EUlNSTVpLc1N4NEdUMFMwVklM?=
 =?utf-8?B?TkJvTXVtOTNTOTZyOVNaUTBsQW0zUGd6SkRZNndweWw0RWVXLzBVMmc2azM1?=
 =?utf-8?B?N0Y4Z3c2MVR1TGNneURtOTk0M2V0N3U1azhycXFSRC8zbG1CeXlVMkxMbjZm?=
 =?utf-8?B?M0w5Z24ydE1wVkJKNWt3Y0ZEb21UQ3h3REp3cmhuMDdUeHR3UjJoNlhZR0Rh?=
 =?utf-8?B?MGl3dzk3TWFoR3NDR3U5U0xuamx0b0cvbjhyRDBhMU1nd3pWWk5JYlh4OFRn?=
 =?utf-8?B?anl3UXRHeGtWR2gyQ1dRd0IyUU5UYXA5K1ZSN3p4Ykl1V0hvU2tlNVkvQ3lq?=
 =?utf-8?B?cFBLMW1NRTU1MWlSNDJxZkFTbUpPRWtDYkJaS1dKOTVNeFQzOGhTWjdOdUZ5?=
 =?utf-8?Q?tc2z8AjzzMYzfQTtIJKW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG5tYUh3VjFUVUp2YU1jd0lZWFVOa2dMZGdWVWwzUGVnRnRLL1dBMUJiSVRk?=
 =?utf-8?B?aHoxZWZCL1pBNjhhRklWUEtpS1hmNTVCNS85NndHSEhHSTNoU2tHR2x1bTln?=
 =?utf-8?B?dDBhNVF4VGV4WDFUSTYzZEYyZXJNNjBZRE10UWhqNk5Wb25aYWZtcC9CTzZZ?=
 =?utf-8?B?bEx3TWRKN0llRnpheElMUUkvTGErNnlMTnRtbGV6OUJCZ0VIYUE2dVVlak8v?=
 =?utf-8?B?all5dkpmU3I3c2VVcjFHSFJGd0RhNkp4OFlOOUJOZCtpNkk4YzZETWZkaUIr?=
 =?utf-8?B?Zkt1a1pUYmlLNzdGNGJhNEdLM2xSN1BKeGh6dmxEekgwZllzTTlITkZXaDVj?=
 =?utf-8?B?ZWNWWlpxalg3OGlwQ1pDblhWaW5keWZ5Snc4R1RjL29jVHVTY0hRNTJGc1dj?=
 =?utf-8?B?RlBKSTUvbFBrTzFPa3Z0RFZSWDZ0NlVhRXcrZ1lmbGJGcDlDWkZjZnBJNnZU?=
 =?utf-8?B?MzRXZFFMR2NDeVltenhkOGwvampXMExGT0U0RTQrWmhPSWVEUHhxUjJJNkhZ?=
 =?utf-8?B?TS90Ty9HTlplZTVEeUdLRWNIK053TnBoR0w0RUltdnc3elN3OTlSNWlSRkNN?=
 =?utf-8?B?UlR0cHFlY1V4U0ZyTWZ3VUs2VXhybTQ3cEh5QmRZaHo4RkxxQXpuQ3c1aXZs?=
 =?utf-8?B?RjczRVVBRFIydnV4RmVlQ3RLTjVLcy9scGI4R2tpcXhRK29hUmVoakpQTld3?=
 =?utf-8?B?eStuekxST3hyNDhnK3JVYVgrWWdPUHMxWnBDd3h4ZVhwSWQrN2lFSFJGYnFk?=
 =?utf-8?B?Wk9RUGh2MTdvRzhGUzZHNlVxaTlHOTYvVEwwdm11T1l0RVoyTGtiTjhiMlBn?=
 =?utf-8?B?d3BqazdqY21HNUpaOTFseVJtWmE0RUtwSk1OU1BlK2VPeUdXZkJmcXl1YW9t?=
 =?utf-8?B?ZkdkbnZzNEFtVDhpTlF1YjhvYXNabFBWR0RnalhzV2RJTWtyQm8zY1dQK3I2?=
 =?utf-8?B?WDhhY1ppUUdDeC85NUNObHhOU1hWZU1SL1NkWkxOR3BqL0xycmFXajl5d2xH?=
 =?utf-8?B?bW9LTUhQN1EwWWRiY3VqRHYzRStvSzBvYkZ3b0ZrSGNUdDJiSytrcXZJRm9z?=
 =?utf-8?B?Tkl3RzF4YnlIL0RvSFpPL1o1enZUUlU1bk1URm5tTmNIUnc2MkIyZGZmV2F2?=
 =?utf-8?B?OW84cFZVNHErc21PVE0zN3M4NE1kUlNmTWE5NzIrdm91YXkvc3h4MDV4UWZJ?=
 =?utf-8?B?Z2tNenpXTW5ReWxMSHBYWVZiVTBHTU0ydGYwR2hlODI4RzF6aVdpVnJ6ei9z?=
 =?utf-8?B?cC9aczlwK0p5dWFlUFVmNnJrcFlRVGNvek5HSTdZL0R6RU1zWDBVNUhwY2VV?=
 =?utf-8?B?SEhabWNOOFVHU05wTXhTcEVmT24wM1JTM0xMZFRPeEh3SG1KTnJMN1MrTUZs?=
 =?utf-8?B?QmQvYzJ6YnZzcVYwYVU0UWdxTDVIaElTZGtVOUh3RWhnNFAyU3ZYTUt2d2Iz?=
 =?utf-8?B?TkhRTnljNlhoUStuVG1hTUZXcjJmU04wOXUvczNlYUoxSm1qS3JTY200eUlh?=
 =?utf-8?B?bWhneWlpbURjU2Z2SndjdEFCMjlkbGhYY280YlVJMGZWdDVFVndMZStzZFM0?=
 =?utf-8?B?QUZma2FpSUV0V21WMkNxSVRja3VoQ01uNjJ3MFVPM0FoYlZOWHJPbjFMVkk2?=
 =?utf-8?B?NEhCSXlVRlBTKzhPblgrOHZKNkNxakYyNElxTVJiSlhBaU16M0xUdEcydjh4?=
 =?utf-8?B?TmszenNwZE51OWxxbVN2TmtOeFpSSnBPRWRJek5DQkxtTENIbjMzWVBsa01G?=
 =?utf-8?B?WWlUNFFGY29sTjIrKzBMdStwRFFFYUx3aE9qNW4vcHpRTVQ0VU1iLzRxSE1X?=
 =?utf-8?B?MDNvM0JkVjdRY2xKMlhNazhjd2FsN2laSWlVaE81SGhmNlJ5dDhXQjhrbUlX?=
 =?utf-8?B?Vnorc0RpUzhwYVVDWDZjUHNGcm1ZZDVpMS9mZE5pWGxKVExrU0tMSVRMUE1M?=
 =?utf-8?B?NUhkeStMaGZvL0VSN1VPb1krUDRBaEMwcklmU3h5R29WeUxhRGdEWHZ3UXBB?=
 =?utf-8?B?UFFVQkxsWFVNeTJKanhvdTh2TGs4QjdVNG9XYTM5OUUyb0w3QnlPWW1TcklD?=
 =?utf-8?B?b3NLNnFMSFVCdU9RTkJuL1pUYUNCMVZCK040MEVhVUc4R0ZGNUtsS2J6QVNN?=
 =?utf-8?Q?XHEthgEa+/MBLiouga409dlRI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5ddf2e-498b-4b2e-10fe-08dc91f929b8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 13:50:51.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6K59Bgp4weuzUgOohO8A1zoK0plgQkmtaMkZVkBwjoEZw3e5rKdXqsEumwOBwhwKdZOtw2ONGXyPUsgN1Vnow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781

On 6/19/24 04:30, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> A long time ago we said that we're going to move the coco stuff where it
> belongs
> 
>   https://lore.kernel.org/all/Yg5nh1RknPRwIrb8@zn.tnic
> 
> and not keep it in arch/x86/kernel. TDX did that and SEV can't find time
> to do so. So lemme do it. If people have trouble converting their
> ongoing featuritis patches, ask me for a sed script.
> 
> No functional changes.
> 
> Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Nikunj A Dadhania <nikunj@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/boot/compressed/sev.c                      | 2 +-
>  arch/x86/coco/Makefile                              | 1 +
>  arch/x86/coco/sev/Makefile                          | 3 +++
>  arch/x86/{kernel/sev.c => coco/sev/core.c}          | 2 +-
>  arch/x86/{kernel/sev-shared.c => coco/sev/shared.c} | 0
>  arch/x86/kernel/Makefile                            | 2 --
>  6 files changed, 6 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/coco/sev/Makefile
>  rename arch/x86/{kernel/sev.c => coco/sev/core.c} (99%)
>  rename arch/x86/{kernel/sev-shared.c => coco/sev/shared.c} (100%)
> 

