Return-Path: <linux-kernel+bounces-294289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB28958BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1096A1F22FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDAC19414E;
	Tue, 20 Aug 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tcx9IzPT"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1C1429A;
	Tue, 20 Aug 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169380; cv=fail; b=i3GH1VsfbQYQqgpsYMGsOs0HxZ4vb1e+wiJ5zBjr6qSLRpGcDZzR84RyZlL85/rnfMBOsdix18R9rBdY36U6CYv1myyQDOdIHbOy/INBx2RTGerNPhPR37JeYp5llzapfPfSIWY1+6tRvUwLtvGJgz1+KmOgE9GIacA1U2y1CNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169380; c=relaxed/simple;
	bh=oGrmXDfNLNOriB5KG3eId5UNZmKr4wuxFtcpo6KX7NQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=puhG9315ZSTM4b7LU2fwJr8n4QgHIf2c5hCwfRZQdENbFrttxwrhP1BN1h8JpaiIQ6yjGh8mtYo3mBbVcaXL38sEqWqlOKF/RuXY7TmBxxRJrLfkK7hbTMcmfCEyNLm6t8rlMtGvIWdzk4Q0wIXmjVk3UaGWnG5885JorUtASus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tcx9IzPT; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3m9Z2aOQsuA7dLgBYlypO93GwgePDV7N53rp3iTSF/N7+xxPQfn3O6Tn/iT+oGCK7zLmz+nF1T8qTQHETTOOE86pT/9FtdTtoDiS8WGNa1u1fduNBHNd0l4NfWbLi8ZdyqpZg1G0T7JgYsfmNSL7QQMiFcukf9G1nQClJdtL56K7u6IPD7N6i93xivWDhS4kSxi3jcPactCdsf3Kf+9p8l1HgmLV4FzkAdlD4QBOQwbFrMnGcFKAYnG1O1nr+nRxgHa4Yagh2zrS7tncydluwHSKENczr23qpZUF1O9xE7JRdcJN2nNnqHTv5Ekjz5/t6/4KACBTgQjTq5LP7U/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM7AyvVDXtWJD8BEpmtI+pp+jH4eYqU65xwV0eA6PV4=;
 b=mULBcUkxZapkbNX9QvTuH5XNcNBf8Ag0deDdj8Mu/q3hxvM/ScHAfwlMBsOhC3fa5E1tuO+1bvl9wXMafhVr3g1PvDktXWmqWcq4iBaOlhO/MfoRkTHOsaogSjMdELDCfj6q/f+gl8dLqvZd0AyHbE0fIEbk1NRNP8pSY9wHwoiKzaHsps1/ggYvN14D4mT09LYo88z+aJ+SncS32SIE/me0MdFH1fup/AsDTYWUcEVf6gPNEejY7HX32amiTfqXouJ6t7XXP2X5wI376ve2GTfELDidQQyPh4NZMZ0AfIblmpzhHUjIfxLXp0hnpKlcpMItvilQES4wvnEXOO15iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM7AyvVDXtWJD8BEpmtI+pp+jH4eYqU65xwV0eA6PV4=;
 b=tcx9IzPTw0911zvExJZ+e+3GQG2tGc1H3SF/eLsrqKovwQ/KCem7o+wCEj3bqrHNQH9Q1hFBmHW2CxDgKyWeOJn/usSZpBUk6sxasFAm856QRH0nILh+NmzM3QthdswLJMhem1oqiuzrt86MzRYTJldqAV3B2IQDWdZov4IJNqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 15:56:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 15:56:07 +0000
Message-ID: <807d4e97-67e1-4644-ab99-caccd328eb62@amd.com>
Date: Tue, 20 Aug 2024 10:56:04 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 08/22] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <da3c2f99c07987d59d9df1db0a0a85ec323cd67f.1722981659.git.babu.moger@amd.com>
 <6c1305ae-caa3-4da1-a0c2-3948cac976be@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6c1305ae-caa3-4da1-a0c2-3948cac976be@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:806:120::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: e17a92ea-be5e-45aa-77a2-08dcc1309a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWpwNUI4OHZTWjdvaFJMeXA5SHVWZmYrRG95YUEvT29Qc0FwWXhiai96WHZi?=
 =?utf-8?B?dmFCTlBEaUFydGdXZStCMDlYRjJoTUFUNDg4bU1UcEIvODlOaHNWVVkzVGJF?=
 =?utf-8?B?ZnVRVGJHTCtpR3FaOUxZQktEZ3dxcHFSSTVqY2VJVlQvMGYvcitUN200L3pC?=
 =?utf-8?B?WEpUSitxalVzS25vdWJ1MTB3a0hFMEp2RUZIVHEzVFlWWlV0T0t6RmpXeFNl?=
 =?utf-8?B?bTFydWx2RjhxNVA0Y3RlN0V1RElZL0RpZDVEZVlPcXMvYXdQSmVpNEVLSmdO?=
 =?utf-8?B?RFI0WU9DRlFZWVdTeTRNdWxSQUFnZXIxRW9qWXROa3JOQ0hDcnpFZUJmYVg1?=
 =?utf-8?B?T1JwWFNGUm1rZ0UxSENkdG1kS1VWT3h0NUttTzJHbTlYRm0zMkNPSHJTd3Vs?=
 =?utf-8?B?QlJxeHltK29FMWRYTDNleit0TmJheXgxN1FQMVdnT050MmozRmw2MXZTejRH?=
 =?utf-8?B?YjFXcTE3NGxmbnB0NUR6M29kN05yRm92NEFDWlBZYWsveTRSYUhGQ0pDM3lH?=
 =?utf-8?B?Mm5DV3ZBekUvaFI5MCtKNFRjR2oxdXhpeXBpbTJKRDFUOTczdDBlTmRTRWdW?=
 =?utf-8?B?eHR2ZUtYWWtNcldnaWtOcUxFWE1YZzdQRVVnUEZXUi9hWmhsM3RoUXNpWm1P?=
 =?utf-8?B?Y2hCRVpUdUxXOTlocjlJNDk0M3N2d0srV1BpQkJNY3lNRDhXTW9ObHJLejdG?=
 =?utf-8?B?cjJ1Y09rMkNyMWxtU0J1M1VtQzNkRWhUU1BCWjN6RjBlNGR3eEtmSFBFSGt0?=
 =?utf-8?B?akhvT1lLa1d2cWxuZG5keWZBYUpMVjNMUjlOVDhsRElkNWlmS3FCeWwzaFFh?=
 =?utf-8?B?eEVjb3lSYTNUaDV3T0FGVHoraXUxSmIxZi9ERHpVeTJCZ3lHYkNBMCtYeHFY?=
 =?utf-8?B?MGdWZFV2d0pVRngwWjNjRkN4MzA4dUJtUkxvZWtOVVF4b2R4RzNYaXhIdldz?=
 =?utf-8?B?ZVM5L0hwY0ZqNHoxZ3B0RzU2TWxBSUphNFowd1RMN0hwcnBXQWUyaFk0WHFr?=
 =?utf-8?B?czROQmJKdVk2ZTJpT2Q0eit6K1ZubjRCcm9wa2lqME15UUw3eTZvUVJDQWYv?=
 =?utf-8?B?VCtqZzNaWU12VlgzdnNvVmxzb2pWSUFOaFI5Q1p3TXhwdUpmUFNEaEtHRTZz?=
 =?utf-8?B?UEtUVFRoU013ektCWHhMcnJ2OGs2YW1takVTRkZlSEVVMndZMU9xc1NZTlp5?=
 =?utf-8?B?SlYxVy9oR1ZRUUJOZG1QTGxOWEpTNHRhTitMdnYwNkVWb3lHcFZZU2xFVjNH?=
 =?utf-8?B?Q2FZZ0pPRklXbUpRZk90NW92cHk4V25XTlNxY3YxSlBIVGJqZXBjdzdzTUNB?=
 =?utf-8?B?QzZpOWJDY3lhSHltK3RqTjlwV0MyVlNCU2N6dCtKQUM1d2hZTFBZdzhYL01G?=
 =?utf-8?B?eEwra1M4NjF0dnlwR2dteW1vMUo1YlEwNStHRVNuU0pMdFhqcW9JODN1dGMv?=
 =?utf-8?B?TWp3UFA2UG1tM1p6cTVYYzJDTWIva0ZTUE81emt1ZEM2TytrRldSZk5tU3Nv?=
 =?utf-8?B?d1o5eDNTN1dqclo4Yzl0RmFWcVZDTytsbk02YXg2L0wxODBxcUhneitSZklo?=
 =?utf-8?B?WHYzWkMxakZWMG9UNzQ3eDVkK0thTlV2elk1bm5TQ2NGaUk4QUdYZ0xXbjVa?=
 =?utf-8?B?TVh5Rkx1VXMwdGJMYllnQzBoOXpLVnFLRVFiZ3dwaVM2Qi9ZOENjelFaaE9U?=
 =?utf-8?B?T0F1Q0cweTVsWkg4bnNIVEtMT3MreGw4NzBaTjU2aGYxams0V0d5TGZvQlJp?=
 =?utf-8?B?NDByOGFEYkRZZTZuaEwyeEs0dDJ2UlV6V25WZWlrOWt2Ym5HdmpCeG8vN3RR?=
 =?utf-8?Q?+5FHatU/tCuWfuaUApjKLQSLXqfwWphFcQfUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhhbHVkY3c5L2EzQW1GTzVGY1JrOEZzMHZ2U1V5YldjRkw3WDFIR3ZRZlh6?=
 =?utf-8?B?Tlp1Tjh5TUZSRXpqYTU2YnZ0VDlXaWJZR3djS1lkbHRCR0QvTEhwTGhqdlM0?=
 =?utf-8?B?aFVCZHZwbEVDbVNoZVhXaEh0cVNTb25uaTBmRnpiUU0vd1FMOVB1VEIxMmtP?=
 =?utf-8?B?elJESWZKdEtMQ2dJQUQwb3RZemlVd01yUW1kMzlseGs3Mk0zSGVraFU0ZC9y?=
 =?utf-8?B?eTdOMWNoT2pnYU51dWo1bk82V0g2SWNORDBmZmlualZBZklzb01OZllzTjZp?=
 =?utf-8?B?MGJxNXFsNTZWOU4zRXRqaHl6VmZHTWZwM3NoYUZWcFdpN09IM0tMbklHWVpT?=
 =?utf-8?B?WnB4QnMwM1dxNnc5Y01QSDA3aDVNVk9lOHZPK3RneWtQa0NaNXEzWVVaZmRX?=
 =?utf-8?B?Nm8xRlZuWjQ2YXJKWnpaeXVxZEpQOGNxbEtua0ltWDRhREx4aklDVGFCdUdY?=
 =?utf-8?B?djNwQ0xCZGtab0IzRktLQlRVNXh2Tk5KZUFHSW14U3FyVjV3bDhHd3V1ekdK?=
 =?utf-8?B?c0dORFkvSHJLZ3VKV2taR2dGelp3L29TcndaRGs2SS9oQTlHUCtIbWxROWxt?=
 =?utf-8?B?cnZzVGhraGk5b2hWOTh0Mlg3NXdPNG1yQk9YeGt0Qi9pVVF5N094YWFKMWFD?=
 =?utf-8?B?NkkzSHh5bEYvSm1IZnhxR3BGMHlyTTUwcjhFTlJ2R1NZcUpMb2NFRXZObW02?=
 =?utf-8?B?UEk5UkpxYjU2MjMyZlBHWjJxbmNHeWpFUWRIcTh4U28zTFhzN1hpTXVWZmY1?=
 =?utf-8?B?eTBldnZ0bCt5bDNxM2k3S0R3Um80M0RIN2NDaWJqYnVwcmRSbWt3bXF1Ym1N?=
 =?utf-8?B?dlhuWUZQN1dnTGwwdHBLMTB3YjV1bm9XNHcvdW4yN3NCdEdUNXFuN0J0WmFX?=
 =?utf-8?B?SWdGRFBhVDhmV3E3b3ZKL3dGMkZpa2VNSUJiUW91TzVkRXgxb0dTUXlyM2FI?=
 =?utf-8?B?TnI3K3BBNFdRZUpCMXVLeXRBa0JTVEF4SHJCeEpock9waytqRFZvVWgzM1k1?=
 =?utf-8?B?M0s1SGlVS0pJU1JWenY2bU56cDU4OVhleDRmaG1Qam1TL1R0WmhWOTNzUjJT?=
 =?utf-8?B?UnlTTSs0Y0h2NGdqNGpuRE41MUVwdHlKZlEyUk4yTERVNlI5YWJldjE1cXd2?=
 =?utf-8?B?S1RtdlhiQWlqY0YwL05VL2xPODVZNXRhd0xiRUtBTVJIUnlIaWhVUHJZZUND?=
 =?utf-8?B?SjJXeWx6N2U4YXQrVjJMaFZSYmFia3VUNmpzSXN0bjhGL2dZRHpnRXpXQjg3?=
 =?utf-8?B?VTFiNXNSL1JINXJsYUIwODBHWnRWMWpRL2RVRHdleXMzL2NnY3BqbXZyRzNU?=
 =?utf-8?B?b1NsWmlySkhDaWFXc3ROR2I4bUVoM3JOZzAyaFF5cjJTSVJhRUN3S21rQUE3?=
 =?utf-8?B?V0twa2hjeEdkZGtYS2x0Rm5WbDBvVmo1Nm1TZnpPdGtUeFN1VTY0eG1iUi9K?=
 =?utf-8?B?NzlHbEJsVys3emVxek85czJtbGhmenJWek44dVBYWVVrZXhEVzgrcWNUS1U2?=
 =?utf-8?B?K2xtTi9jWEdGWGo3YWhXTUJrR0dSd3RnMU0rVk55L2htVWtsbUQzSmNsbmpD?=
 =?utf-8?B?cDRtN2ZSWTBFOVI5Y1U4YkVuTFhGVzhvYVp4YUVoS3I5TUNNc29sZTZJdmdj?=
 =?utf-8?B?LzZIN3UxUTVhekM2Y3NTQjJZb0svRCtvWXgyUVNpTHJzMGdmRFRLdWMzSFBL?=
 =?utf-8?B?aGNOVzl0cjdXRlE2K0NBbDJiRXdKVDE1NkdMUlZZYWx4TCtwSEtHK2pueXFu?=
 =?utf-8?B?b0dBVm85M2E4QTlIcDJDQ3JVUTU1dnp5Tlc5WEd5bUtmbGpkdTZIQXh3d1Vy?=
 =?utf-8?B?QmxoaVBRLzFlTENJYXE0SnFFdVFpdU1RL3RhN3lOVk54MS9BQ241S3lXcWlY?=
 =?utf-8?B?QjVacEx4cjFrMy9MbkVtUlVQZXBrN1JreHNDaVhjV25RSFNjYk8raDNjY3Fp?=
 =?utf-8?B?V1RmU1BvSUhEVXowdkU2SFFsd2tXSmVUT29vTDhOc0VMbWdWQjg0bmpqWGk0?=
 =?utf-8?B?VVp4LzVxcGlmYVhvb2F3NEhjdHEwUit4cjBuY3I3S0w5eWk5SVByWS85RmQ2?=
 =?utf-8?B?d0Exb0dOSFlRMTdMbTZRQ2QycG0rODYvWjV4RDlXbEVaR29SRnpjc1dieC9Z?=
 =?utf-8?Q?t91M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17a92ea-be5e-45aa-77a2-08dcc1309a94
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:56:07.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIhyg3NvotWtY8lBq0zXrXq3CZGXt9n58Wr0amYbi5ZKd1mDEqSr/VkxXE6aXjlf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437

Hi Reinette,

On 8/16/24 16:34, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
> 
> Here and in all patches, when referring to resctrl fs please use the more
> generic "mbm_assign_cntr" mode to distinguish it from the
> hardware/architecture
> specific code that involves ABMC. Something like
> 
> "The ABMC feature provides" -> ""mbm_cntr_assign" mode provides"

Sure.

> 
> I also think that being explicit with this separation will help us to see
> gaps in interface between resctrl fs and arch.

Yes.
> 
>> counter to an RMID and monitor the bandwidth as long as the counter is
> 
> Please clarify the scope of this feature. Above mentions that a counter is
> assigned to an RMID but later it is mentioned that the counter is assigned
> to an event. Perhaps consistently mention that a counter is assigned to
> a RMID,event pair?

Yes.
"a counter is assigned to an RMID,event pair" gives more clarity.
Will changes it.

> 
>> assigned. Number of assignments depend on number of monitoring counters
>> available.
>>
>> Provide the interface to display the number of monitoring counters
>> supported.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: No changes.
>>
>> v5: Changed the display name from num_cntrs to num_mbm_cntrs.
>>      Updated the commit message.
>>      Moved the patch after mbm_mode is introduced.
>>
>> v4: Changed the counter name to num_cntrs. And few text changes.
>>
>> v3: Changed the field name to mbm_assign_cntrs.
>>
>> v2: Changed the field name to mbm_assignable_counters from abmc_counte
>> ---
>>   Documentation/arch/x86/resctrl.rst     |  3 +++
>>   arch/x86/kernel/cpu/resctrl/monitor.c  |  2 ++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index d4ec605b200a..fe9f10766c4f 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -291,6 +291,9 @@ with the following files:
>>           as long as there are enough RMID counters available to support
>> number
>>           of monitoring groups.
>>   +"num_mbm_cntrs":
>> +    The number of monitoring counters available for assignment.
>> +
>>   "max_threshold_occupancy":
>>           Read/write file provides the largest value (in
>>           bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 5e8706ab6361..83329cefebf7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1242,6 +1242,8 @@ int __init rdt_get_mon_l3_config(struct
>> rdt_resource *r)
>>               r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
>>               if (WARN_ON(r->mon.num_mbm_cntrs > 64))
>>                   r->mon.num_mbm_cntrs = 64;
>> +
>> +            resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
> 
> The arch code should not access the resctrl file flags. This should be
> moved to make
> the MPAM support easier. With the arch code setting
> r->mon.mbm_cntr_assignable the
> fs code can use that to set the flags. Something similar to below patch is
> needed:
> https://lore.kernel.org/lkml/20240802172853.22529-27-james.morse@arm.com/

It is just moving the calls resctrl_file_fflags_init() to resctrl_init().
The  rdt_resource fields are already setup here. Something like
https://lore.kernel.org/lkml/20240802172853.22529-20-james.morse@arm.com/

I feel it is better done when MBAM fs/arch separation.
-- 
Thanks
Babu Moger

