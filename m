Return-Path: <linux-kernel+bounces-414880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FDC9D2EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14A51F23BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287571D1E7C;
	Tue, 19 Nov 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ViJIF11Y"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883D51448F2;
	Tue, 19 Nov 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044030; cv=fail; b=kpLQwVZB9VEUbPFYWgYFBtbweawddMUhFYJOySt0gorevBPxRGDepUuRz9mg7uvklWM/DHMmcZjBUO6Z1C6839QxO3j7DE5jM1Jg5tqIXdGe2U3BIeCEy1mV2MBDtZGoi20nyU+ZjwW864ykl1yr7qnMvhHjHYLY9VX5PFHMmUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044030; c=relaxed/simple;
	bh=UHJIUSCTww5gCffhnLx1Ang37Vm7Bg1Z6ojCAXFYta0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uCU0ZRFmU9mGm07U06QIuNj2B21SaeNFMDiWnv8BIM6Y6UHFB+/I7OLK54tzciUwKhwNcTX7vPGOTvdSgqrI1PeC6DYJ7SDvWgtADim06kNLZV1PZ8iaPmS1vwhPuAizLk7mI3B+AGKJH+Jv18x3H+hs10MjbHSAcm1qmVjpHKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ViJIF11Y; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf6T3j8E6OFL3JNdDU568hJ5Gt9jHCpCg542vdrIqMls7uUng8bA4vZgkPqT+P0lFFjwWr0FWY1HkSW5OCWOWbwLtEtStzEq875TKgifiJ1KKlHY9JcsdnJc+6j7U9ibAsuCnErrxOQrqsTrA8jouvE6DWx+jsMOQKWxxHe1n4NTDjpQgulow6ZCyBjpddGGkZ3vHao9tnupxsORyTo4dzk2Rtf7ZQKMgESrf1MoeFTY7tOwpPJ+cMbR4m6w5S82+cIK8VFGBT6juHvLXSeboUf/feQlV9JE/rLp9JToBfM3dC0WejcECMZX9IAIZzSEmKsDLvpiMhBpuary/Y5bXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqGyVJTh+J4jQcC4bKAdRgzo3qb8RBt+k1Afz3uB2HI=;
 b=ILcnSTjsgWBBKAwA1o30+r+qnhm2ltJ0vO+FP7FHzxVgglOxoyKlSfmK8G1mLVSZUFj9rjhCEPTI+Q83le7b/BJuxAP3+MBRS0vxW+9/sISTAMKz2Xw7UOjuzjoBPBHrDC9pfMaftuXvHNkCIAcWD/9Dw8HT4s3yn2Oglq3vGvRuOqlFS02HJ1l02j/UlQYOVEmhGNMrpF8CGUYNlH1tqzzeuHm4m0T56YguBrKNet1EcR7y1qw/6biAYm9QXTFq4SpT+FVsGSmcH/9FYdk/836wyDxZ4JXgIboIx38DziMW3WNafNwde1/GnjgZxMlVec9unguPofBu0lV4so9Tcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqGyVJTh+J4jQcC4bKAdRgzo3qb8RBt+k1Afz3uB2HI=;
 b=ViJIF11YTlku5u+Uc4SNaXXcuOKFXm19do+QME160azD+763z/bQQSxuQqxI1W5GngUpqhNX26r0yP3SqCOY+MKfCL8wQML/+M7avBcVmf3BSGD4x2gMEZjs7e76xx+HT/GHVmtzb8oqpIZPjxtpUOqnR00I54xVHXjRMABGJtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Tue, 19 Nov
 2024 19:20:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:20:23 +0000
Message-ID: <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
Date: Tue, 19 Nov 2024 13:20:19 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:806:d3::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbada60-2c01-4826-a191-08dd08cf36f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUsvWlo3VEpBRVJwaTN6czQ1NnJxRnJYY2NyOEJrdWJrTm5yZkJDdnBtUHZY?=
 =?utf-8?B?bFBBazczSVZ6MHRCZFpnNStNUzdvdG9vbmROMnUvejNPVGdsYXhoMUcycVdp?=
 =?utf-8?B?bHUxbkZEUE8rL2lleU4rZVdSa0xZT3VTVjdSZ2Y2QXpGckR3YTBiQlV1a3BF?=
 =?utf-8?B?UXBEQ2tFaFJEVkJVWk1WK3JycllzOG41Y2JheUt1M2plL2toZHdjSFd6RzUz?=
 =?utf-8?B?L0JVRFVIc0NHY0owa0hYNEVpK21oQ1k2eU8vUUUvVFZQSDNIWm5RSmJXcjFn?=
 =?utf-8?B?SVBXWkgzdnNPb1RaY2VSUDZQWldTNWJobENJVGhud0VLZFl1RWxWZTVpQVpY?=
 =?utf-8?B?MjZ0dUdmVk1aZStDMzRVY2hpcnZjbzd5RFNxYUtINTUva2RSUWZ1ZkIvZ21G?=
 =?utf-8?B?MExld2Y4NndScmJobzh4UTZxZ2RqUUZLbG9zNkxYRkRCZWZkTkNiMEZjWlZn?=
 =?utf-8?B?dS9JOEFIZ3NoVmNXMms4RGJ5MXJkaVl2VkNpWTRmL2VEVHdBQWQvY0M4d1J2?=
 =?utf-8?B?Z29GY3lodW82eXBOVzB5NzFpN3F5Nmt1bGFPeFNvK0ZMOUtkdVRyMEFJR09D?=
 =?utf-8?B?dExROURHWjFzZWxTV0ZBNU91aFhGRUszUWx5citlcUZPL2VWZkpWME9tSk52?=
 =?utf-8?B?UHNqMVhEY1pGNW9maTk5a3laczNLeVFORkM2dmNXN2RHVnR3aGp3NmtQaEFN?=
 =?utf-8?B?ZDM3YjFzdi9pV0g3amRwTGNGZzZyN0lxQjRKcTh3OG1DZlJVWFo1TVJGL2h0?=
 =?utf-8?B?NUIrMnhqWTVVTFdDNmZFdmdJY1BTemJNNUx1dkxGUmJSWXFpMUZ2YTEzNWp5?=
 =?utf-8?B?aVV6RTloa29TVmhyc2Q3WVN6YXJnWSs4SEJGcDAxWDdXY2JPcHQxL251c1ZS?=
 =?utf-8?B?NitZcVFsMEk2VnNrT2RTNERFT0lucHQxbFpnRG0vUzgrTjZMSkJwVHUyT01x?=
 =?utf-8?B?WHRUc3hvK29NYlBTVStnRy8rMmlob2xUV0ljcWJFQXFrRDlwVE04b29NaWc3?=
 =?utf-8?B?VzNpajZ4cndSNE9xNFZ3MXEwUTN1VGhFTVdSd0xQUk1WTitpY2o2LzJSYWkz?=
 =?utf-8?B?NHYyT2l2ZTJkR2tITnJTdkhXZXhiTDNsQ1dHVWdJMDgwNmVpTUhKeDFyL1JE?=
 =?utf-8?B?NlJ3UmgweTFRWjhhMTJ1WHFxcDNIcnluQWdwSUhjVTlUN3pwRjJBQXVnWXhQ?=
 =?utf-8?B?cHJQbnJIYnBwMzZzRnRyM2haL3kxK25yTFl2TzZhNHNTZEJ5QVNHV1FXV2p2?=
 =?utf-8?B?NEEvYmVzNVBSTDl6akdiZ1FKenFKMWJzWjI2N1JGME5MMEwzQWo3dnF2a1E5?=
 =?utf-8?B?Y1VCeWVnb1pSUGVsc3pab3pqZCtWeGY3Tmc3ZDN6b3B4Q1NnT0x3TXNIQ1Bj?=
 =?utf-8?B?cGtYTFhYSjJMeDg1OElzRmJKVzhEMUs4L2xHVCtnVGM5Z2plN3VQNUJ2cWFT?=
 =?utf-8?B?TzNNRk1HRk9OWUljbnZBQXZqRHFUcm1aQjhWcTR5eS9BVkZnZGU2M2RpU01Z?=
 =?utf-8?B?eFJJQUNCZTM3em45THN6MHQ2SFZacGMrOThEZzY5WkFtOXoySmNjNWdNV1B1?=
 =?utf-8?B?TE00OXJvRE8zTndKUTZ6clMycjdYdWJHRG9YVnhUU2IyZVc4a2lVOG5Dd2Yy?=
 =?utf-8?B?aUMvenM2YjRMSHpGb29ITkQ5SDBwaThqaVJVblpiZTJCZnk1VForaVVOVjhN?=
 =?utf-8?B?T2FlSUpxY2RQM0xuK0s0Q2ZvTy9Ebi94c1VESU54cThFSGZua3RsbnlUY2hT?=
 =?utf-8?Q?khRP3KKH64VdIdkTCSJt6cuNhhLU6l4Fkb5N0cs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHQ3YzFWMklUdVQvTEwzdGw0Ykp5b1dJN0IxQjl1R05nRndKRDlxcTd4S1Ja?=
 =?utf-8?B?Y1oyS2NjRzBRTUpwVWFZTnNOa1dON1hrOWxLRWlhREhtT01CYlVZU3BodzR0?=
 =?utf-8?B?aXRSM3h3cG53TkhZQ1RJSzJTTFIwTW5TUmlEd0dYZXZwZVNsamtPR3BtZDBl?=
 =?utf-8?B?SEpKeGQ0U05hanN5RTl3SmtoLzIyM2RUR05XTjBuVlk3UnFYRjZFK2d0dXFy?=
 =?utf-8?B?SUFzUzdXaXJDL2RIT2doK1BWNXFiM3JRYkwrckg4Wi9kZklyYlBWdG9WSDFk?=
 =?utf-8?B?YmxpTFRiNlBmN2pZdFR3Q2RHbHVYcUlJL090dUhHaUlSajFyRG1oS00zQlBi?=
 =?utf-8?B?Ky9oL1JSOFJZY3FhakZQSS9OUUNIOHlNK05XaWVUUlVXR2VrTmFEK083NVdz?=
 =?utf-8?B?RCtsSWRjbm13eDhVRm9NN2hkbFdsYWFyekR3NEYraXdQRlpyamYzMWNIUnlq?=
 =?utf-8?B?dkFOZzF2dnd5WlVWN2dBb0VvWUZpTWJaYm9PcUlqSk1qOFZJRFAzTDZrV05S?=
 =?utf-8?B?YUVQR1BGU21UelFPZnUrSnFsQWllQVV1T3RBai83aDIyN0pCRXlTS1JBa0VE?=
 =?utf-8?B?YThtTGhTaXFNZmU5YXErZUsvSHpucHFtZjlHVnVpL2VlenErVWFaMGw3U1JM?=
 =?utf-8?B?ODdHUDAvNk5xSmpHdmFWUHNCUDZ2V0xrLzhwekp3UFRYUjdwMDdkN0R6bm5q?=
 =?utf-8?B?YTBSTVJOQTErUVVLcXhIaXhRRGVjLzVCMGZ3cmRldVJUWEJ4Qk1wdUs2eWtJ?=
 =?utf-8?B?SFZjQm93c0k2NGNYbW4xc2RSVnU0M1g0WVMyWDF5aVBTVVZjUXplZkIrUjVI?=
 =?utf-8?B?RTlkYkZsRS94SE9wN0pqMU9DMkkybWZYYTVjVDg4b214elZlZDYrQS8zTTlR?=
 =?utf-8?B?NUZmUkxISnpBd0R3NFhUdjZ4NnFvVWF2TG92SzB3SVgyaGdLTDlQL3lxQm1n?=
 =?utf-8?B?NTNsZDlZU09jMXczeW9zUWpLcEF0N3N2MlZWeXpZUW9IMzl5cml5ODVSc202?=
 =?utf-8?B?ZXNJcEtwaFdGVmluRzFIR3ZkMm5wcXNLb2FvWlluVkxEQ2wrVnA5bzI3Nms3?=
 =?utf-8?B?UjVoVkIydGU2N3BzeFlucnZneGJXcy9PYnJqclBOT0I1OTVKWm1oTWFFbGZG?=
 =?utf-8?B?U3dVN3FCYW1RUTFTSlBwTFNyd3ZtMWxyb1VZcHhjdEVnS1M1ZVNXZlhsMGVo?=
 =?utf-8?B?dG5TYlJYbXhQaStTb3FvaklJYy9NNzlaZTJiWm0vek1jeUlhSXZERFRuL2xu?=
 =?utf-8?B?VkZHeDEwL0NSaUFleGJOUHYyV2d4dXA5R25KaW9XbEV3Vmk0TmRMRVBSejFs?=
 =?utf-8?B?Qmw0TW9iU2NKOHorVVFXRHR3ZFRDbXBzMExvc2ZyYWtxeFM3VHdZUS92dmh4?=
 =?utf-8?B?VDBHVlJycEgvQ25ubEwxYU9JZXNrWFN2MUpFWlJmaWxLT0N2N0QrNmw5dmFM?=
 =?utf-8?B?eTE0b2N6WDdvT1k0c0ZnaXhWSHBZQTNscFMvTTFwS01HTVhCSWxodzNYYStn?=
 =?utf-8?B?U1ROYzQxTC9EK2xHdHNCdFcrL240QU5remZkNXY3elE3RzFob2lPRFNoVFZ3?=
 =?utf-8?B?L0hlRlJuUnNMNEt0eHFpaU02TlRqYXJuMStUb0tIT0JKb1d1OXMrcnViNFpw?=
 =?utf-8?B?ZU1BcmNzamFyVmhLY2h2ckNITXVBWEE4SzB3cjZzY0tiZlR1SldFQit1Z0o4?=
 =?utf-8?B?am40bTF1UDgyY1RwWGxHTmZQOFI2blBGSXRvVEFjY09PWEY3U0RoUG9Kc2Z2?=
 =?utf-8?B?TEJjVzJ6S2JvUnM4Q2FmalpFTldSemsycnJoTUVQVDZDcjNqYmt6TDE4UGN4?=
 =?utf-8?B?VHoyWTJEVUpIQk5lMFNhaEF1U1Z0WGxoeVNscDJWZGxEM0duOVlteHhmNWg3?=
 =?utf-8?B?VWx0UjFiMTZUTy9HbSt1NjZ2dkdmTlRtT2c4cDBLeHIyM3p1TUk4eGR1YjJD?=
 =?utf-8?B?TVZBSW0wS3B2UnhsSHhMejNTRW9JaGgyK1ZKUnA2THJRVS90bldzOTlZbEFT?=
 =?utf-8?B?SmRFM2hTZVdHaWl4aUtIaCtMSjI1TDFPRG5Dbm9JVGJRaFdJS2RqNWVhdElY?=
 =?utf-8?B?NUhOSFBhV25WRzZ1clhGak81MU5lL0hkc2pLRVlMcS9zVGt5a2NsR3pxeGhz?=
 =?utf-8?Q?ibFo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbada60-2c01-4826-a191-08dd08cf36f8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:20:23.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V65QujrbXh7XNp6szXeOCiT59GQWfuzGUjWzjBqaOT4z80PS7AAmmVZqTHxQChae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496

Hi Reinette,

On 11/15/24 18:31, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> Provide the interface to display the number of free monitoring counters
>> available for assignment in each doamin when mbm_cntr_assign is supported.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v9: New patch.
>> ---
>>  Documentation/arch/x86/resctrl.rst     |  4 ++++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>>  3 files changed, 38 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 2f3a86278e84..2bc58d974934 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -302,6 +302,10 @@ with the following files:
>>  	memory bandwidth tracking to a single memory bandwidth event per
>>  	monitoring group.
>>  
>> +"available_mbm_cntrs":
>> +	The number of free monitoring counters available assignment in each domain
> 
> "The number of free monitoring counters available assignment" -> "The number of monitoring
> counters available for assignment"?
> 
> (not taking into account how text may change after addressing Peter's feedback)

How about this?

"The number of monitoring counters available for assignment in each domain
when the architecture supports mbm_cntr_assign mode. There are a total of
"num_mbm_cntrs" counters are available for assignment. Counters can be
assigned or unassigned individually in each domain. A counter is available
for new assignment if it is unassigned in all domains."

> 
>> +	when the architecture supports mbm_cntr_assign mode.
>> +
>>  "max_threshold_occupancy":
>>  		Read/write file provides the largest value (in
>>  		bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 3996f7528b66..e8d38a963f39 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1268,6 +1268,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>>  			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
>>  			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
>> +			resctrl_file_fflags_init("available_mbm_cntrs", RFTYPE_MON_INFO);
>>  		}
>>  	}
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 654cdfee1b00..ef0c1246fa2a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -898,6 +898,33 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static int rdtgroup_available_mbm_cntrs_show(struct kernfs_open_file *of,
>> +					     struct seq_file *s, void *v)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +	struct rdt_mon_domain *dom;
>> +	bool sep = false;
>> +	u32 val;
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>> +		if (sep)
>> +			seq_puts(s, ";");
>> +
>> +		val = r->mon.num_mbm_cntrs - hweight64(*dom->mbm_cntr_map);
> 
> This should probably be bitmap_weight() to address warnings like below that are
> encountered by build testing with various configs (32bit in this case). 0day does
> not seem to automatically pick up patches just based on submission but it sure will
> when these are merged to tip so this needs a clean slate.

Sure.

> 
>>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:916:32: warning: shift count >= width of type [-Wshift-count-overflow]
>      916 |                 val = r->mon.num_mbm_cntrs - hweight64(*dom->mbm_cntr_map);
>          |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from macro 'hweight64'
>       29 | #define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) : __arch_hweight64(w))
>          |                                                 ^~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/bitops/const_hweight.h:21:76: note: expanded from macro '__const_hweight64'
>       21 | #define __const_hweight64(w) (__const_hweight32(w) + __const_hweight32((w) >> 32))
>          |                                                                            ^  ~~
>    include/asm-generic/bitops/const_hweight.h:20:49: note: expanded from macro '__const_hweight32'
>       20 | #define __const_hweight32(w) (__const_hweight16(w) + __const_hweight16((w) >> 16))
>          |                                                 ^
>    include/asm-generic/bitops/const_hweight.h:19:48: note: expanded from macro '__const_hweight16'
>       19 | #define __const_hweight16(w) (__const_hweight8(w)  + __const_hweight8((w)  >> 8 ))
>          |                                                ^
>    include/asm-generic/bitops/const_hweight.h:10:9: note: expanded from macro '__const_hweight8'
>       10 |          ((!!((w) & (1ULL << 0))) +     \
>          |                ^
> 
> 
> Reinette
> 
> 
> 

-- 
Thanks
Babu Moger

