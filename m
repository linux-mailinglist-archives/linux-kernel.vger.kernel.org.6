Return-Path: <linux-kernel+bounces-370918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B88F69A33BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA481F23481
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CDA16F0CF;
	Fri, 18 Oct 2024 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XYayS4Mk"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF220E32F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225308; cv=fail; b=oqeBLu3p8Axr49uaQRauN+/MDN+SmYf2L1QS9bAF/+3DjsRl08x/mOcjO9+/SYRnTrZjTwSqZpciJBP7Ovpk+PvUDC/OjIAngSRTv9BOIAzDPgNNU6BFwTMxRpwsIPW3t5yB0j8YM4Q2vsVFS+GQC3xCyXNf/8EeZKBo3Y+qoqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225308; c=relaxed/simple;
	bh=Ve8br7SSXsxlQ4VFYTt1K/XpJOtK5fWqnBGneimWjRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c6No6nTICJ7wnYUlhW1nICUwDDa5tJvv/OIoarNMk5xPjnt9J/JZ0U74/4hlOWyl3Ydosy3eXE/6bEuEqhRGE1UmSY4/hDENYvL52YAOdLVvWgrKW1lCMu7PhpBkls/RAFSx1hHudhvWr1fjSnM2bQa1CVUSbDGQfBIO4tGDDXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XYayS4Mk; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhZxj4WJaUts+VhXpnhQpmNah4xeRzcxc73KTvEBAzrkmY8Hm7UDaxWo+1U8DNeRKo4U9krc/W8gGDLmABYaYmhIDaI9JhD2y8C+YPyFBXayS8h4iaRiJBbgaLDuCNN7yyPMU4fjkj+1MnaBYfXr5cHdKTi0D5/SrFQlpjU7hMLxjQNrRB+792tBfFsYY1s1Id0kzXqHwQd7/ZZLmGteQZlI7SY4fSCPuz6yuRCYt4z6+K12hdzJsa0R51x7HVserTZKZVeAy0OFi8YGq+Y6H2E1p87l98EARZ43RGYEkVSxdiuad4JZOWGOxoFUniqVQTUoVY3mvRkBvYlMUrycwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGEMWi9xVlLCtrS7vOIPZ99fsJL63XICeAR9LdJb1ZY=;
 b=jX/onfeRa69Mxi2hYWH2pNb+ekficjdmROvk2LpggpwqiPBOTpR0vCiJlgGVfcw6rcBP3Y9vmKXPdnKCY764lwpg0bIhIutDBIzdvQmncXmxVXR2fNaV0xWdv4HYIuEQ+Pr6bqUXfRQltAWCWLREiXhCoIAr528jlDGNAuLu/Td/AWyvt0sz6cMQl9WiLxHg7tfRQOPiPUYiVJ+fKAfTAyvulOLjGZhRks6LqAokfpER4GCEnv/EGaGVn362/5OPbW3AVfDJuZWMyW4RdbdFEk5DV8jBKZ+Gv4cZoxEwEf07HejMz/dIUEnEi0d9ekSv37J39gzihgqaT6KgZG7smg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGEMWi9xVlLCtrS7vOIPZ99fsJL63XICeAR9LdJb1ZY=;
 b=XYayS4Mkk1CYXxNIfUg9/bFHcj1DblpkXvcKbXdaZmh2turDnXhRfO1sMOSt4ug2CH8Kyd5hK/4UQmaH85g/JbokRMZ+6RAnYkruJeH5Ow6O97SerLxBhaZJSLyZUDae/WU1TjF1qCNEefyqQj6l/vqnz2DEL3UXPnvXT5MM48g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.23; Fri, 18 Oct 2024 04:21:44 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 04:21:44 +0000
Message-ID: <ef20092e-24e4-4d8d-8b1e-b07cfdf5a9a7@amd.com>
Date: Fri, 18 Oct 2024 09:51:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] x86/sev: Add support for the RMPREAD instruction
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::15) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM4PR12MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0337da-792c-4362-2c3e-08dcef2c5f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1BwQ2habmUzOUZUOGwvSnEwYTVDTWMwaTF6T2RCa1ZQRlRLYmRnMGpKUkF4?=
 =?utf-8?B?T3lJOHBqd3hkQWlja3NjUmNWcmxycUxrVVQ1OW5uaWdGUVczMVhLSDNGc3Vx?=
 =?utf-8?B?bDJ6QS9YcW12NjZDK09JQnozamMySlYyZlRVdnlEVGpxeDJZSkZsT0VscFdq?=
 =?utf-8?B?bUEyQ3c5YWdZR0ZuMzRsd2dSVDhPUFFka2dQYkc2SksyVWhTMjBuall5UTRh?=
 =?utf-8?B?bFFHNnFLR1gvaEVwMGdaTTNaeElRRS9selNSbmVnazVxYTdDMlBoWlpRSUg3?=
 =?utf-8?B?YU1uTmdsRGFQRGxtc0FYYUwvOVVINE1UdTFiOWdjSFV1Z0FzVVFTYWFjYllu?=
 =?utf-8?B?V3NJN2YvOWxxQ0F4cHJpTjI5ZmxEd2tjNjBiMUlIVGs0YXR1NnYxMjBpYlVR?=
 =?utf-8?B?NitlOWRHZjlmenplRE5KZFBSRjhucWxkSDZNREtkaDUzUHMrV3ZhZ2Y0a0ZO?=
 =?utf-8?B?bVZ0R0hoejdERForQjQvOU1wR0J5UnRVZThNL29JendqMEFHWjJjQ2dkK3FC?=
 =?utf-8?B?WVpHVXJ1b1FtTTRTM2JQTFRjWXl6NmNzSTZRU21kSi93UFVqZWRobHpqaTJX?=
 =?utf-8?B?TkxaeERNZW5nY2dFZ1llNFB3cnl4aTA3V01TWTN0SVBPMUZBWUl1MmJzNEVr?=
 =?utf-8?B?WVhmb05sZXF2TGhFYzVxVlpwZTYzTUtnKzAzR0NncWswT0VYRm1yWEdrS3d0?=
 =?utf-8?B?djhCOTdLUzJLSmduSTNkMnpGdVVjbGVJTDBtY3RTYmRWcDJ5cllsOXVHQW1D?=
 =?utf-8?B?cVhRMzFaeUw4WEhiY0ZMbmh6SGI4UjBKd1NDWVl0OEJIb3BDajMwVndXNjhW?=
 =?utf-8?B?WDN0VFVXR2Rvb3IrMExZQ285QWxXcEJTK3FyYkZQdUs1QU1wN1VFWDN0dHRs?=
 =?utf-8?B?Nm1PK0hiTXB2VFhGa1B1ZDA5eVpHa1JOaHVyS21nNlVQSlFMdEFGTkFWNllH?=
 =?utf-8?B?b2orcDZ6ZHBnd0YwU0Y3aS9hWWllN0pHbmdnOFIvc2JFcW80cW14NGcvY2g4?=
 =?utf-8?B?UDdtb3FCU2NXbVBkMVRvV3RBcS95TW1XczQxVUNHcU9rUml4NngzVlZlSzh5?=
 =?utf-8?B?RjVFV202cUpKV0FXeTV6Um9WNmFzd05tbEF0eHlIMGpidEhpTFhUaU9iMnph?=
 =?utf-8?B?VWtJRllVQ0FNQUxvWGppdTNVVGpnT3JrY3E0RDEwbVlKYW00b0ZzZXdscFI0?=
 =?utf-8?B?eWkySjdlL245RkR4bWgwKzBCcG5ScE5YU1JiMGg4d3hnZDRYRVg2bHYxVUZy?=
 =?utf-8?B?bzlNelRNSCtJbW84OU9Ecm4xWUY4T2pWUmdTQWhRVU1QZjMxSUhwOHNqampU?=
 =?utf-8?B?MTdJMExDbjBEemdXeThvZTVhNWczRWc0QnJXM1N1RmU4cXJMR3JNaHY3Y0pT?=
 =?utf-8?B?UUFIZU1GWjB1RUJ6dVZEYm1UdTB0bko4YTdMbllOdFdtTzQvWW5JZGp5UFlM?=
 =?utf-8?B?Q2Q1QTc5aVR6cUduczdOY3lnUi9JcmxVaU1uOEZRanhYUmtuUHFIK0dheEZi?=
 =?utf-8?B?RDl4YVZRWGlkcU9oVDUzbVd1WStCVkY5OWR2MnRtZ0FNRmtST0V0VlgrY09r?=
 =?utf-8?B?YkhQalNIZWN6TWV6bHBPTXVPd294WWFNVzMvYUl5NTRWYWs2RVNoSGJvK0Yy?=
 =?utf-8?B?UEVHY3g3eWwzVElaOG9adFZKSW9Bclc2QjliN0w4c050K3lCNjNUeHBpdUtM?=
 =?utf-8?B?MUNic2c1SGpmZHFVQjhrT1FDMjVzZEE1T3p3K2lwb242alMwanJoYStLTG1h?=
 =?utf-8?Q?Id7oDHUWjEbUlN1ygkmC5lkHGb+ljsk5+TdYHPW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlpDa0c4cERxZi9aZHdRMjFLQXJJU1pqZXNBOXJFaHZpM1hQbXA2aCs0ZHND?=
 =?utf-8?B?TExsZ28wVXFOczZiNTVwOWs2S1B1Q1JFaVFHUXhjbHhta1AvV1pYSFhmdFNj?=
 =?utf-8?B?RVhzS2Y2cUpBY000RVQxeVdSaDVWZXlzdUJFUkMzQmljd0d4NHFpd1RJeVpO?=
 =?utf-8?B?d2pOUjJGUEhLenBnWTRoekptYnhkL1d3YXYwRUsvZnRiWFpmTVZ0R2xlcUdT?=
 =?utf-8?B?QXBBWjlubGdkWWdQelQrRGQvOEMvR2xZeGMwTzhQZng2dUl4VGE1MEZtdzZn?=
 =?utf-8?B?aVhLd0ZFVjVUTnp6bjFzMURoME85UVNzTzBlTDI0cS90NCtLem1KcVk1Ritk?=
 =?utf-8?B?bWdBTXNtUis4c3ZaME9XeldZejRua3h6TmZjSkdSb29Pd2FMd1NDR0ZEb1g0?=
 =?utf-8?B?cnpBbCtacGVlR2lUZ0d6L2xMeWhMaUJyRlA3WWo0Mi85Wnl0RmxJN081OXhj?=
 =?utf-8?B?RHdYSm1ySkJtOVc0K3JXWnY1N20wTjVBRlVpbmdsYUN4NE1NQkNyeGhJS1Np?=
 =?utf-8?B?VjRoNmhXTzlsZHlnUlFtK1dFUmJIU1lTT2xwazlPY05ObGkrOVRYcC9pdnIw?=
 =?utf-8?B?RUpiWHNPQVhFek4zNGp6a0JMWUQrT09OSkUvQmlsVEFrVkRDaFJjc2JXaHNy?=
 =?utf-8?B?aDJoZnRCaUNXU093ZWxka1ZHRmdtemk4UWV1Qk8yL3g3d1ZiU1VWZUJDUXdW?=
 =?utf-8?B?TXYxelFPcFdYNlNTOTl5VGoxQzJVMmIrMGlvcTZnT0RlYkoxQTY2Zld1aW84?=
 =?utf-8?B?V0dVcUlOeW52YWhDMHJpc20zWGVTT0pTR2x3THp0OUhXYWRHMm1tS21nZUNP?=
 =?utf-8?B?RG9zVVhrR3VxeUNZNThZcUZROFFzNk0vMmoza3JPNW5zbjdTRHNqYnhIMm92?=
 =?utf-8?B?ZCsyMnoxM05sdlRqcjVRNEd2SG8zaUROTVJIcUF5VktKQUpJNStGak8xRmNo?=
 =?utf-8?B?ZWVxcG5yZkFmMkZ3TStXVUR3L2ptVmoxeXdaUUNGVXhFbzliYnZHdmxuTkw3?=
 =?utf-8?B?S0Qyc1p5Y0NDangrMkZGeHdnZFFya2Q2TGtxM1JDNlF1cU5MQzRPcU85NFcw?=
 =?utf-8?B?bnVMa05hVUxoTXRpUGNFcXhwS1FuVUNNYmpLa1d0bVMvQmdzUVdlV1lNZGE0?=
 =?utf-8?B?eDcxa0c4QjB0Q1JFMjI4KzdrVitPMTd3L2RDZGxIOTZJTUZHWU1rYW0wR3Nr?=
 =?utf-8?B?cVdvVWZBY1lhSW1aSHhSUFNIckZGL0pGUE9jeGRJdlgweVRSdjhTbG9jK0JO?=
 =?utf-8?B?WVhVWmZ3Q2dnenBSZ3RQekhBODFOL1BROU1WVkxlWW1GNndNU2wycDJwUm1Z?=
 =?utf-8?B?ZjcxZUV1dTZubTVNcDlaYjJEa2Q2SVoyM0lKckVLOWRNQnBnZUJGcTJSZS9B?=
 =?utf-8?B?VmFTeWxweWlLMnl0bDI3R2V3MDZ4bTl5VHN0M2NueFhOZVQ4ckMwNktVUzgx?=
 =?utf-8?B?Q1BtSlc4NXNEMUNySTllVlVtRWhoZ2lDVEFJSndjTUkvdDU5blJydXh4V0dt?=
 =?utf-8?B?R0ZjTVhTS1QxVm1yenlzdWowMEpaV3dNWHB3N05IZytJdTB1MFh6OElobUgx?=
 =?utf-8?B?bGV6c3l4TzEyOWxFOGxlSTRBTTBOTkxFaDI3MnRoWGd0WTRYMHBZVVRURzE5?=
 =?utf-8?B?eWJ1WFZjR0dxUFcxVXRpdTZNeWlrbWJzcVRJNzRLZ1ZuNUZxVkw4QXNmNjBl?=
 =?utf-8?B?L3ZibU5XWnBVd2lRalhGeVhCZVAyWG94L2ZNa0pxWTJ2eitaUS9uWjloVXdL?=
 =?utf-8?B?c05tQnN1VkF4bytpSWlRb3ZRWTVaOEVIdVd4UlYzcDBKUFlXZCt6VDNOUU4y?=
 =?utf-8?B?SHY3c05FRFBVN3pHaEJWUmJJZWpZZVNGTFVTVit2OHpCMFUzVncvcCtqbVYw?=
 =?utf-8?B?RGY2QVg4eUhjZFJ5alRSNW81d0x4TTF6dVpPSFRlaG5pQzR4TEFScFc5cXJ3?=
 =?utf-8?B?VjhJSVlDK2hGWFpNRlJ1WGFGTCtIWmNPTTByc3dqWmNiWWpuU2VsRmpZV0NJ?=
 =?utf-8?B?Sk9nQmI0ZC9FdjF1YnFOeEFDVDl4bUhoTWRBOXZoZjFQejBlcXNiUjh2eUNR?=
 =?utf-8?B?RTJpOFBCVjJZMjY3ZHUzREhHVkJxeEU1ZWZrTTVOYkEyeHNPTTRGYVI2cHBI?=
 =?utf-8?Q?QYkrTBIRRsaDagvjP/fQy13BN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0337da-792c-4362-2c3e-08dcef2c5f92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 04:21:44.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+cpNOqFkmx2FFigxikMWiZoAyQRGoShTu/eX5ZWXOkMePwI7OdAIsiBPMnB9GVnomTE8pZC9ltxYUSays59JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891



On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> The RMPREAD instruction returns an architecture defined format of an
> RMP table entry. This is the preferred method for examining RMP entries.
> 
> The instruction is advertised in CPUID 0x8000001f_EAX[21]. Use this
> instruction when available.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj

