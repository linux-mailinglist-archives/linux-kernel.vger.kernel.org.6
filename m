Return-Path: <linux-kernel+bounces-423602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D98E9DAA37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0C8166ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F41FF7A7;
	Wed, 27 Nov 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yj/IQ6Ek"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA96B652;
	Wed, 27 Nov 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719481; cv=fail; b=fKTZsCgKUXEc3FFi8fGbHd5A1pOQ0rb+npoGHgZSrCpnMbmBqz83k5CH7USLX5Gu5Sq8Kgu3idgSqLcMo0cwGBM+TOSI1CpdQJCBIFKVKCeRnDFct7MgAw1R2kXYBmSXZErtA9sZP3XSBqYIRwoQGJPL7w6cajS0am0bWWIYaxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719481; c=relaxed/simple;
	bh=96dxP34h6JLdmY3OCLb7qkeX7YDB6+C4kVlPyR8CSD0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f0Oz8HBPrT+0BtTk6wDFXMays6fHkoPZzBpaDO4nWC1aF4YwbO1lHDaD77alIJMAheNA1uI4Wcuqh/kM/WZyLmMcUb1vkOUblzsUZCTvwr5flxScnKQIAxyuYkpiStuuuhkQ3QPmTO6xJv5eaFrl9P/Y5i0psUtYqsQ445foNpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yj/IQ6Ek; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cn/iTW0pg68on8Q9cvlxy/v9LMI/E0HNDNAVunOMUiu7GS6Kh+ExAZ08GEaLZcQd0FUtkmh6Mw3jImrRmHCbED2+6spR4tglIAZFhtdF0eyEL01c4aJLY22dNSOqMJFgWkE1IC8bqZeFr90SMt8kcVgxkoMvlZZQzKCaRBbV8LY/COnHkC47bpOKYM8BHeQdVJoZY0LhbxGDvP6DXWa6sV9HCIJw/nkL4IE1t+TSzYJHAPJIJz7K8hwoLjj40rqNNxMloy6EnI5uAjz+PUiVAuyrXQF8konpv6EaIna9RtVDSTGGdqK0mBEE8+EvNIzFk3S30yYv9EE0J5WaDwYgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP8kfHtwopbrvHx96TdusMHrOON2PQeY7qZf1KqcJFg=;
 b=c2WUn72rqQlmC5VOcvCF9HlOJ3X8puOVD7NEaceJW2z8vZZuHZivksUnMNNzn6ejCOvp/AjWd4+coHZWFJrgOALsH9ENqxNtXoqnOYwYmc2Olsqrcl8D4z3D+yHhzO3f9Wezni73TPcbzw0Tq9VWfrSiTQRRqP36/R7VCt6j+NcMiJ/LlKBU0FlyHaEbXrmvy/+uoiNG3dPQJyV/qpXvfj8hP7gfwpqoGQD8A+pHdfWndCpbSIwRRUYIE7ToZ3UJeT7WTec8crPcZZxQW9qv2sdGKRag3ltAQJuOCIoVFyGw2YGRx29ZDOiZZcpIsHPMp0kAzKdCd5rPZXgmhgMVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP8kfHtwopbrvHx96TdusMHrOON2PQeY7qZf1KqcJFg=;
 b=yj/IQ6EkO2wGXWz/I600qC2hkDwtVnf2ZEVoSJCXZdpBi1a0dWjgzJ9oHDgzf2R8gCvL4hR/pJoMgmPheYY1lsso1QDIegMtpS3SK2eQlq3/fzPEmpWX/rrOTwLS6ZkcAHDdLFeo3FQG7JncbEZQ/8ABkPdFU8iLFvoqu83IHjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Wed, 27 Nov
 2024 14:57:55 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 14:57:55 +0000
Message-ID: <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
Date: Wed, 27 Nov 2024 08:57:50 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
Content-Language: en-US
In-Reply-To: <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:806:d3::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 60aaefd4-6fe9-4fe2-a873-08dd0ef3dfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDlmUjF4N2tBNDF1TmM2RWFDc0I3ZFQ4Y2JUc3B5U2pET3pNS2lGUUFhcUh1?=
 =?utf-8?B?d1FxWURRYVpwSVlPT1FVSFZkTzJLYk5CTFQzejI2emZqWDhha3FwMEhpS1d2?=
 =?utf-8?B?L0dSNmZmR3lnQzUxcmtoWUdnQmlFQ3ZvV1BCU3N4enZvcUh4SjR3blVhWGFK?=
 =?utf-8?B?d0RBamtDVFVJYjh3TW92aThFYk0zMnc4c1JEMUJETHpkMHhxckw1TTlYTXpN?=
 =?utf-8?B?a2k1TzlCVElZT3E4aHNIeExUNExsWEh0QmIvdlRWOWJQdDFacXFFODI2TEZ5?=
 =?utf-8?B?bVhlM21sdVVMSEV6aXFVLzQ3aG0rbFVSaDlJQTBDb2svRWlNcVh5bjViN2cx?=
 =?utf-8?B?Y2hqS0RiZ3hWeXh4RHZEQ1gwREthMlJNV3Z4Zk1xWkNJN2Vyc2FqdTNCMHJO?=
 =?utf-8?B?dlhxWWdxT3dOQk1xQnMzY1ZFZVB0UzEwaXNjR0RuT1IrTEVwb3R0cWlBYUtF?=
 =?utf-8?B?TC90cWsrY1RSVHNNMnBJQk9ZU29PSGtaNFRKTno1SG93ZGszYVllK3ZxeUUz?=
 =?utf-8?B?dDk2NEJQZWhTNE5vOW43NEFmblA5VEZNQnN5cW5lK3pNSzFUUWF3d2cxNzNL?=
 =?utf-8?B?dEVXR2FXYUJXa0RtQ0hwSkJHa0Fnayt5UHdKZWlBMnpJVUFHcVhvY0xxSUdj?=
 =?utf-8?B?TVhEa1RjNERveis1c2RkaFh2eWltS0I5Vk1SWW9wVkRmbVQyUUZBRXowTThY?=
 =?utf-8?B?RWZtNkNVOXo2RHBZS1NhM1IyUkdOME9BZVlwZWVadmg4SG1OWk9BSVovS3pw?=
 =?utf-8?B?Z0hFYnp2c2FwSGxoSHczQlRvN3VMeXk3WWFvM2d3WEowbm84czNNaWFpMnho?=
 =?utf-8?B?c2xCdFhDRjBjZEdFblJPWHRZa3pzNmVzZDhSV0prT09TVDB4ZGpvaDlKWHdW?=
 =?utf-8?B?UythL3I4Q1RTdjFBODYwSCtHRnNscHVlZmVMUjk1Y0VKUGxuVGhSZmRyNVhn?=
 =?utf-8?B?RFcrV1VNWm9CYVpWMGQvL3Fac0tsd2Zpb2laMzY0U2U4TGd0blp2eVVKYXNx?=
 =?utf-8?B?NUZnYWtNWE5LRUZ6NjVZUmM0M0hOZUh4VTdrSXRybno1cGwybDVlOXVuQllh?=
 =?utf-8?B?dHlqZzM1MStBNXMxZjgyK09SMERtWGVTRWk5SlErN1BoOHVNTjZiTkhDTzNh?=
 =?utf-8?B?MnhMeDFLSVJGRnc0M3pkb3pWSm95RUE1NVlsK2ZlZWova3Rlc0pqUnVFVFJK?=
 =?utf-8?B?UVZxcVlIN0s3ZkJyU0pOZlZoTWt3NlYzd08vUjNoNHNMdVNtc2lCQjFpNWd4?=
 =?utf-8?B?d0J1cTRUanNpOFBoR3ZMYzVwWjlEVzI4cDdFMEY2SXJ3MkhyODluVU50TG95?=
 =?utf-8?B?d2poZitGcjBRSERHNXpwRytrVXFPMEVIOVdkSUpOajFSTlZtUkNoNDhBc1JB?=
 =?utf-8?B?UExhYjRKNEpSRzNxdThyenN5aDhPY2lRNTMreW5USnRNZUFRc1NmeG1nSmd2?=
 =?utf-8?B?aWl3SFJKZkpDYTRlRVpWTkMvOGVIRWJPRkdLL0dFdFd5dXkva1IyTktnenFF?=
 =?utf-8?B?a2xCRGFzRmtITTg5Lys3cHlEa1JHR2M5RmhGVGdoZ0owSld0VHdXR1ZmVTFl?=
 =?utf-8?B?Q2VaSktIT01Td3BTVkt2WWJINURDNzY1ZFFHZTREeUlXakFsc2V2ZUJTQy9m?=
 =?utf-8?B?TE9VT3pVU09DNmRPODlKaDBkZ0JabU5TazZnK2lMMERkSS9wMG1aSjdpL2hQ?=
 =?utf-8?B?MFRLNkxNSDdoelFRRjdOWVNNWTBzZDVPR3I3SFZuNjhOTGRKb0RpNW1FUzBD?=
 =?utf-8?Q?B99ZSa0ng87cO+H5qGmnldgw9K5vF+s7ija+oFX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVJUVDFxNmpPSVVGMUswM2tORlhCZ2Y5LzVqdzcvSGozT25yQlhmODhURFZG?=
 =?utf-8?B?VXZrcFFmSUZLZzNaSFlmUldWVmkrMWZiN3FrZExVV29hT2RQR1ZaeXlZNEdx?=
 =?utf-8?B?U3k0NTJpbGc1UzZMMlVsL0MzcVZaY2l5emtUeTRXUUxLUXdLNkNZTkZoUDNO?=
 =?utf-8?B?TDlBb2ZhdU82aFNXbndPdzNremgyZWk1aVY5RkcyT255dXEzTzArKzQzQTNt?=
 =?utf-8?B?SFo2ZFp2dmxNUStvVVRXdDMvMkRSanZrZzQyNXpLdjdMSEV1eCt6MWdXSGMv?=
 =?utf-8?B?YzNzcHpXcUlMVjlIV1NkTnNkSElla3FQR0lZTzBOQkxDaU10TUpYYUhlR1g1?=
 =?utf-8?B?WmIza3VadFQ3VjY3V21rcWt3NEI4S2cxWFNzR0VMTDljZDVLV0JYSC9oeFU4?=
 =?utf-8?B?R3U0YXBLcGRrTjJNdHl0NmRkM3lGYWt0TWZOb2V0WXZmOGJ4ZDRrYUpRVWxZ?=
 =?utf-8?B?Zm4yaHMwZkVTS3l5dFNheGYrMjNaUFhydW02eXNMUHpRT2kyYndYTWk5aldu?=
 =?utf-8?B?LytiZlp1REhNUXdKZzVnR2VSRDdpWnN5WDlaVC8xN3Z2bzFLM0QxblRmMVE2?=
 =?utf-8?B?MUhxa3JUV0VReWRsS0VLSkY2dzZTSCtHYnRLRmVIaHpzbDN0SG9MSFRjUmIv?=
 =?utf-8?B?SlZ4ankxLy9hK0xZTUEyZlViWE5HajJXVE9GTndIaDczLzN1aEN4Rlh5dlZW?=
 =?utf-8?B?S3dscWVZczRmMnV4c2dCUWpOcmpNZ0NkSnJEOHhMWEFBaW1ldE5iMkViRVBn?=
 =?utf-8?B?NlpMRXBVYUNrTGd1V0RvWERmeUpuM1hORGplMHF0M2lqTjJoZXh6K1JyaVIy?=
 =?utf-8?B?bFN3UGhmSGk4OUxKOWNKWU8wMU02NGZnakx3VUZHeENuOW1VbExmSDFUejVi?=
 =?utf-8?B?UVRGMXZ3R1hFOUg3bjZUWmp1ZVB4UWRtSTRIMDhVUU9sQmtuczFOWHYvRGMw?=
 =?utf-8?B?UUhJZkZoSCtyTXAxaUlhb0RSaGpCdk0zM0ZMc2ZDN0x5dnRwaEt3bnFBUVA3?=
 =?utf-8?B?MHFQNytnL0xCUU12bTVqRUQzQWpCaXYrenc0dzNTQzhOV0MxcUJ1OFRKU2xr?=
 =?utf-8?B?WHZRVVlsb1FLZEZ5UUJmT0g2SFpvZjV6YjBLc0s2SUJ1UVU0V2o3ZGhOVG5T?=
 =?utf-8?B?QnluOHMwWkZxZ215eEk0UFMzLzQwenFRSUZUYXUyNmVuVThqM2xkZDdSalh1?=
 =?utf-8?B?THJUYkNnNG4xL1FRRzZwNkVlRVUxaVZaTEN0c2x4a2FHcjkycjNTcVJQSzR2?=
 =?utf-8?B?SXBiSWIzNGxjK2VPaUtJdmRZNUE2Y0VGWmxuc3c0R1VrYlpVYngzbFFEcDZm?=
 =?utf-8?B?WFZJclVsMHhnTDRTR0RDMXh5QmFsRE9IRkcxUytxWWtYVG03aEJtQS9IVzZ2?=
 =?utf-8?B?SE9JandlSVNqdkxValN3Um5aUE8rQ01HeW0wNUNjVUQ3anlFaGNBL3g5ZUhw?=
 =?utf-8?B?VEwvRlJVMFhBQTRwa2FKbG5zYzNnM3oxWEpwSXZwU1BXRk1JZk4zQWJld254?=
 =?utf-8?B?b2FsT29XWmhHeDc0d0tKa3V5a1ZXN0RUa2hDVERPUDRqVXFmbmpiUHB3Nmdz?=
 =?utf-8?B?c2t4cnRsd2RIOXdXL1hyZFZ5aEQvTTl1SVBlcHVvSTlqa2ZDQ3FzcjlnenVi?=
 =?utf-8?B?dkJ4NVpQdjJESzJnWEdwUlBWM1Q3N3RyQmVNeWZSL0FZVmNWOXBjOGdFdk5E?=
 =?utf-8?B?eWJNSGcvR2IwUFpQK2xHL0lsUUJVNUlGbTJMVFV4RUZINktuZTI5QnJzY3NB?=
 =?utf-8?B?bmw4dmFhSm1ZSmVYVS9JaTJmc1hSbFhzZDBrYXZEczN2SWt2bDB4R1EzQWtY?=
 =?utf-8?B?YXBhaVJZZXArcXJLcUoxUnRFUDRzcTdvdktIbkF6bmpudCtSYW03aUxpZ01O?=
 =?utf-8?B?ZmlrejlTSEhoV09GSElCeng1Rm4vYUN4ZjZwTTV6WmN5VWQ1L0FPKzd2bXN3?=
 =?utf-8?B?NGxxMG0yYThKRnNVSzlvZG85ODg4L1hoYm9PanFKMUdoWGltcE4yNlpuRlcv?=
 =?utf-8?B?UmsyNHlkRlpLNnhheCtVNi9aSVYrdDVQR01OcXNReUJxR1FsWWpKYlBDZjdF?=
 =?utf-8?B?SmRwNWR3aHpPTVJ1eUdkWnI4bjFTdlFTT0VUYjNadGNCa3ZFSVFIMW5seGJQ?=
 =?utf-8?Q?s1KI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aaefd4-6fe9-4fe2-a873-08dd0ef3dfb8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 14:57:55.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH5L+ci3tFKhRJuKxJIDQvD2EYXIv9tycn9q8r/nrHmTHAYEEcwmrFUWOb8b1LSd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831

Hi Reinette,

On 11/26/2024 5:56 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/26/24 3:31 PM, Moger, Babu wrote:
>> On 11/25/2024 1:00 PM, Reinette Chatre wrote:
>>> On 11/22/24 3:36 PM, Moger, Babu wrote:
>>>> On 11/21/2024 3:12 PM, Reinette Chatre wrote:
>>>>> On 11/19/24 11:20 AM, Moger, Babu wrote:
>>>>>> On 11/15/24 18:31, Reinette Chatre wrote:
>>>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>>>>> Provide the interface to display the number of free monitoring counters
>>>>>>>> available for assignment in each doamin when mbm_cntr_assign is supported.
>>>>>>>>
>>>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>>>> ---
>>>>>>>> v9: New patch.
>>>>>>>> ---
>>>>>>>>     Documentation/arch/x86/resctrl.rst     |  4 ++++
>>>>>>>>     arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>>>>>>>     arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>>>>>>>>     3 files changed, 38 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>>>>> index 2f3a86278e84..2bc58d974934 100644
>>>>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>>>>> @@ -302,6 +302,10 @@ with the following files:
>>>>>>>>         memory bandwidth tracking to a single memory bandwidth event per
>>>>>>>>         monitoring group.
>>>>>>>>     +"available_mbm_cntrs":
>>>>>>>> +    The number of free monitoring counters available assignment in each domain
>>>>>>>
>>>>>>> "The number of free monitoring counters available assignment" -> "The number of monitoring
>>>>>>> counters available for assignment"?
>>>>>>>
>>>>>>> (not taking into account how text may change after addressing Peter's feedback)
>>>>>>
>>>>>> How about this?
>>>>>>
>>>>>> "The number of monitoring counters available for assignment in each domain
>>>>>> when the architecture supports mbm_cntr_assign mode. There are a total of
>>>>>> "num_mbm_cntrs" counters are available for assignment. Counters can be
>>>>>> assigned or unassigned individually in each domain. A counter is available
>>>>>> for new assignment if it is unassigned in all domains."
>>>>>
>>>>> Please consider the context of this paragraph. It follows right after the description
>>>>> of "num_mbm_cntrs" that states "Up to two counters can be assigned per monitoring group".
>>>>> I think it is confusing to follow that with a paragraph that states "Counters can be
>>>>> assigned or unassigned individually in each domain." I wonder if it may be helpful to
>>>>> use a different term ... for example a counter is *assigned* to an event of a monitoring
>>>>> group but this assignment may be to specified (not yet supported) or all (this work) domains while
>>>>> it is only *programmed*/*activated* to specified domains. Of course, all of this documentation
>>>>> needs to remain coherent if future work decides to indeed support per-domain assignment.
>>>>>
>>>>
>>>> Little bit lost here. Please help me.
>>>
>>> I think this highlights the uncertainty this interface brings. How do you expect users
>>> to use this interface? At this time I think this interface can create a lot of confusion.
>>> For example, consider a hypothetical system with three domains and four counters that
>>> has the following state per mbm_assign_control:
>>>
>>> //0=tl;1=_;2=l #default group uses counters 0 and 1 to monitor total and local MBM
>>> /m1/0=_;1=t;2=t #monitor group m1 uses counter 2, just for total MBM
>>> /m2/0=l;1=_;2=l #monitor group m2 uses counter 3, just for local MBM
>>> /m3/0=_;1=_;2=_
>>>
>>> Since, in this system there are only four counters available, and
>>> they have all been assigned, then there are no new counters available for
>>> assignment.
>>>
>>> If I understand correctly, available_mbm_cntrs will read:
>>> 0=1;1=3;2=1
>>
>> Yes. Exactly. This causes confusion to the user.
>>>
>>> How is a user to interpret the above numbers? It does not reflect
>>> that no counter can be assigned to m3, instead it reflects which of the
>>> already assigned counters still need to be activated on domains.
>>> If, for example, a user is expected to use this file to know how
>>> many counters can still be assigned, should it not reflect the actual
>>> available counters. In the above scenario it will then be:
>>> 0=0;1=0;2=0
>>
>> We can also just print
>> #cat available_mbm_cntrs
>> 0
>>
>> The domain specific information is not important here.
>> That was my original idea. We can go back to that definition. That is more clear to the user.
> 
> Tony's response [1] still applies.
> 
> I believe Tony's suggestion [2] considered that the available counters will be the
> same for every domain for this implementation. That is why my example noted:
> "0=0;1=0;2=0"

yes. We can keep it like this.

> 
> The confusion surrounding the global allocator seems to be prevalent ([3], [4]) as folks
> familiar with resctrl attempt to digest the work. The struggle to make this documentation clear
> makes me more concerned how this feature will be perceived by users who are not as familiar with
> resctrl internals. I think that it may be worth it to take a moment and investigate what it will take
> to implement a per-domain counter allocator. The hardware supports it and I suspect that the upfront
> work to do the enabling will make it easier for users to adopt and understand the feature.
> 
> What do you think?

It adds more complexity for sure.

1. Each group needs to remember counter ids in each domain for each event.
   For example:
   Resctrl group mon1
    Total event
    dom 0 cntr_id 1,
    dom 1 cntr_id 10
    dom 2 cntr_id 11

   Local event
    dom 0 cntr_id 2,
    dom 1 cntr_id 15
    dom 2 cntr_id 10


2. We should have a bitmap of "available counters" in each domain. We have
this already. But allocation method changes.

3. Dynamic allocation/free of the counters

There could be some more things which I can't think right now. It might
come up when we start working on it.

It is doable. But, is it worth adding this complexity? I am not sure.

Peter mentioned earlier that he was not interested in domain specific
assignments. He was only interested in all domain ("*") implementation.

We can add the support but not sure if it is going to drastically help the
user.

Yes, We should keep the options open for supporting domain level
allocation for future.

For now,  we can go ahead with the current implementation.


> 
> Reinette
> 
> [1] https://lore.kernel.org/all/SJ1PR11MB6083DC9EA6D323356E957A87FC4E2@SJ1PR11MB6083.namprd11.prod.outlook.com/
> [2] https://lore.kernel.org/all/SJ1PR11MB6083583A24FA3B3B7C2DCD64FC442@SJ1PR11MB6083.namprd11.prod.outlook.com/
> [3] https://lore.kernel.org/all/ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com/
> [4] https://lore.kernel.org/all/CALPaoCh1BWdWww8Kztd13GBaY9mMeZX268fOQgECRytiKm-nPQ@mail.gmail.com/
> 

-- 
- Babu Moger


