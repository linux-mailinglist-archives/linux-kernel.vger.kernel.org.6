Return-Path: <linux-kernel+bounces-413397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE76E9D18A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3961F2121E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1051D0E04;
	Mon, 18 Nov 2024 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k8a8rMRl"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D221E505;
	Mon, 18 Nov 2024 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956695; cv=fail; b=QhzDpOELd03hrJgfnCpg1egpJ/kXydNgbGW1nsgo3vS44NQg1PxoXxCzD0mE/KX3JYHgHboV2YdOWukvN/HQEut53zMUukDzWlMjUhmymcxaeHvsbTqe+gPw+mOFiJOVZyaGqJ9lj0FF/uunRMSQdst3VH5JeKeP4/psGzKObJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956695; c=relaxed/simple;
	bh=SIKMUeDPpBLPuP50MuHboFs+wy2e4N07Sj7z7idxi0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SHY7XyIUIaKqWPNYArmIxj1UKRikLRAhNIA3AWaBFR/e4PQRmrcxo3KmrJJciA9VwmQRtk8aIX/EOqS5WrmbshiXR6qT4z/D7zXFeKrynBi1gVoeQGoEtYDBEPnK+zBybwerZUBUf3X3RYzw8evu5K75xLlKbTOCUwsqG5fs/8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k8a8rMRl; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ql2+3zEYXnKzjeR7qVidCPH1iNxXlhsV4+uK00dpyrswEMk7I2vW8o63qd+o+XRj8BZdK94Bowljr3fB/v2en/alhPkJyePZim91zVmKvigeBp3Q9LmvtG95zRiFaD5jPypiKcIufjZPQi7Bb0tNAzXqJ4tRqeGYLEJ139/EaUUjXCJeyMt4zODVCg+LLOn9B1eqMUKnpJ89HtRUoDZn8yZ3lM5EMXLvYe1j7OXKYyp1ZbDZk6qfMIibrdNOXHBu0f8DsSJ9BJub1xU9NXitluUMxOgP9BJogPiZwxE38pSbc0Ud94n6H+tUzi4PwzODDRGx5XhyRdvlPg69Q1vJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5u52LfAO9n1L8gGQjLW8tT0UV8yCyV3zrx277pYWv8=;
 b=b/aZIN9fxYGJn/Z78alapI+nv2RTmjVMrGzJgI9iz008so2i43vQLxsgZ1gNePaSb8pTln3YOfxxO0Uh5PH2KjEkzmfORqvjsR0skql0daMyoFx9jnfm/BMe/XJwvpNp3a6Kp9+coHwB6JDI03Yyh3xrprVQg21Sf8Dhl/7p3CQzVbdZkSvCDB5efOiYw2BYBuFy0lnJvDburGbtqy7li41fNO9ujJ6kjzPl4vEREtGZfNtEbg6AYdOiOWASl5dWoHAftxYRsUaRY3WGNeHUb1TWgFZ1tQBgeocn4XC4CSR0XbdEaRuFDRr2tIckQ5O32OoJT/60eg50Ybw/no0eiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5u52LfAO9n1L8gGQjLW8tT0UV8yCyV3zrx277pYWv8=;
 b=k8a8rMRloTIpoDL6J2w/vp5SaTFGLzZv1fuFiMHtDuNkqdIW0H0pZhO93cA/t91ej8gE1eK2i3tOTCCfuEqzkcvl5KkSHssm18VXCWaU6Q78FxQQytLIW5dP87UhkGoMfSy0GFmLLMhaJ+Z7eJfQR2WzKFZswdLL1Ajtkg3tESY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 19:04:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 19:04:50 +0000
Message-ID: <33cd0cc0-4f81-4a2d-a327-0c976219996a@amd.com>
Date: Mon, 18 Nov 2024 13:04:45 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 08/26] x86/resctrl: Introduce the interface to display
 monitor mode
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
 <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
 <fe518638-a82e-4136-ae77-fa6a7abb4b2e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <fe518638-a82e-4136-ae77-fa6a7abb4b2e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:806:120::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c05298-6f77-46dd-d2c4-08dd0803e068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk90ZEk4SmdlancxUWx3NEE1ZWo1T0p3S2p5VDdBeEs2UnJNWDl2UWt1Rm9Y?=
 =?utf-8?B?R2dhdWt6ZU1rMEg5a0xDOTRuVko1OElTOHlKekRPTW1CZ3NsdE5zRm9uUHFk?=
 =?utf-8?B?VmVCQzRXZ1BmYWdXRXNCRkxvLzd5Q3VxWm83NERNVS91NXhsTHk5bkRNamwv?=
 =?utf-8?B?RE8rUkk5UmFxTndtVVkwalhVVU9OdmtiUzM1Y1ZGWjlHUVRKVDFPWWc2OER3?=
 =?utf-8?B?S0VpT1phVlhtVVgyNnFNU3dubFp4MmZoNGJLQk9hVk4rSWxkMVI4eDYrRFR4?=
 =?utf-8?B?YmtPTlIza0RNa2Q5VkhzUGFtamZ2Y3ZFQUVwR2tDNTAvWENDU2FPR09mdVBM?=
 =?utf-8?B?Q21NaTNxaStnVHNoR0dINEZXMUV3azZGMytzQjNJa1U4ejhOTy9qOVRhSTJL?=
 =?utf-8?B?RStiTkxUM1dlK1VJbVFHS1J5TWhxbWJrT3V1eU9aS0VWa05uUTljU0diSENa?=
 =?utf-8?B?YUo0djZCR01qVFFBZ3ltSFd1RFJ1S2FzZVpSQzE1dGV0N1JaclJ3Mm1QNXRi?=
 =?utf-8?B?cHJpM29zUjdHMmJEVTVXUXFIM3pxeVBaY2FzMXhOYXExL21Fb3hucnByQTRQ?=
 =?utf-8?B?T1RMMUxhVnEyWi8wU2I0WCtmb05ISTR4NnIxTCtnYXdnRnhRWWZBaDhPbENW?=
 =?utf-8?B?bGtmYnpsL25oVjlET1FHT3E4UGFVc1ArRzBOMFRPU0t4M0pwb2R0dXNZbHdu?=
 =?utf-8?B?OWF2UjZBNWZXaDl3S0c4UmUvR1F1cjQ3TDM5YlhpU2luekdtcSt0b2ZUbitY?=
 =?utf-8?B?TFljZVR0Y0lVOEVleHBaYzlUbWVzQWhTakpWY25iWjFtYWNWcTlZd3d5K0lX?=
 =?utf-8?B?cVBmZG93bGZaTU13TGJKWjVrSGtDbHR2ejhnMHF3TjRxWktJaUVrZlhUVHNq?=
 =?utf-8?B?ODBZODIrNXdDejE0VW4vNkdBMG5CRWVaNG9wMGxYeWxCenV6N3pOV2k4clVv?=
 =?utf-8?B?RE1vSUJ6T3poaXQrdHdNaHBYRklIM0hPR2JsZ1RxMUI2TlpIMVBEODZJdmZi?=
 =?utf-8?B?bU55T08rakZrYllTT3RQYS9IRG9TZlFMTzRybEJueU1BTEt2Wjk4OGEyOGFZ?=
 =?utf-8?B?NFRrL3BTdlBCRElNN0ZKZkpPZEhOd3FvVzhQWmJiODFMTjNyUXVzVmF1OENQ?=
 =?utf-8?B?VVlSRVFCalZuZkRGSDZtaGozOGYyVWJpWTU1WitSdmMzK1VSRks3VUFWUWpJ?=
 =?utf-8?B?L3IvVG9scVZyVW9FblNnNkpXUWlCc2FvbDR5YS8vT3RLUkNQUU9NSTBSa1lz?=
 =?utf-8?B?UTU5YU5jSUd6eERaVEFhRFJ0WnBUNmlIUWwwZEJYcks3STRmeGJBdEdUQWZt?=
 =?utf-8?B?dlhSTEVxSGc3dytDOUJiUS9BZndkb2hlZFZFdTQ5Z05ucHVvcGEwL3JMclhR?=
 =?utf-8?B?QUZOdFpaVGxpbDl1WGRNWDE5N0l5Y0xkcXNBeUQ3NlBtQWM3RGw4OWpEdFhx?=
 =?utf-8?B?eTF3YW14U0xVL1lGdHg4VnI5K25MWmhiTnNMSFdiSXNPMWt1ZDU1VmdMWm1j?=
 =?utf-8?B?T3RqUm5RZDdsdTZxeDlweFJnaDFLV2ZXVU9sSHZnTjRINWxyTDFXTEJIbkRF?=
 =?utf-8?B?dUpXNzc1N2haa3NCVmxmaVh3eElvT1l2L2o4K0ExQzVkdkJ2L2Y1QlRLRnVp?=
 =?utf-8?B?Vzg4VFVKVTFRTEJPa0xVY3BOUzFhWUVVQXJDVGI2dFBQdHhYZ2VJQlU3Zndm?=
 =?utf-8?B?SEtOSU13ZzFESG5iZHFMRFc2bDZ5ZE1uajVQRkZBWlphVm11QzhSVStiM2dS?=
 =?utf-8?Q?2zoqVbIYkOxeNQyhX80T2yZli1XPKRpzB/UK6x7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3M3aW02aEtWM0JkYkdZT2tpUzBVUDhzMFJhN21RTzRiQmd3RXRURlJtaFdr?=
 =?utf-8?B?dnRCN1ZERUlrbE5QRmMrN3kxcjltUWUrQUFTK2lqeWtjWEZRL0htazc5WDJq?=
 =?utf-8?B?MkhSTFNUWW5pbEtoK2hLVW9qQWtVVHF3SXhteEdhZkYzVWRuZkVLTlE5Q1Rh?=
 =?utf-8?B?MHYyemJRZ25aYndzNUh2VklzZGJjTGVRSjJrclpxN0VJYXhQRi95TFNjYXRt?=
 =?utf-8?B?Q2R4YkIxV2VGL2cwcTVUcEJ0blVEbHB2U2MyM2o3QmU0N25UMmtMVEdTTXEz?=
 =?utf-8?B?WjBCZjN1Ymx2ZHAxMy90b25RcE9SYytMUkpRdDg3c0hSMlYrc3Z3Nk1zcHl4?=
 =?utf-8?B?RE5xVEZtNE1vZENScXBJY2l3RnJ1YlJhM2xxQ2M5ZEpScmFUdExrbmdnVHcy?=
 =?utf-8?B?YnpseDh1SmhzOGMxWG5MQ01HbkNjWGNZZDYwZEZmWkwwZUtwbG5YYzFRWXdo?=
 =?utf-8?B?QTZrNTJDUmRFSTZDK1NOdUhITi94d1p2SUlLM29jLzMxY1p2RHhEVzRUWkM4?=
 =?utf-8?B?dlQwS3d1RERmbXJnRVp4Szl0Q0tOYnhwTG85YlRIM1dPdWRvd0o0d0s2Smtn?=
 =?utf-8?B?dVhQVkU5MHYvVytwR2ZCWEU0ZnZPMExnNUJxbFZYZHlkUnhwRXNPWTA4TjVr?=
 =?utf-8?B?T0lEdlZQbjQzZTV1L1FGZC9rZTZDRjlheS9CZlhCWFp0V3lyV0VrSTc1OHVu?=
 =?utf-8?B?akhQVjVtczhONVN2VndhY1dRSHVCS3VuRGxoMkRUenpmdU51RmpMdGNKRHg2?=
 =?utf-8?B?UlhVbXJXdHpmd0lhcXNXOGMwWGFkUXhJdmg3Q0VuN1U1MmZkVmloMUhjWDBl?=
 =?utf-8?B?YVo2ekRkSHJlNWFhM3JDZ283YXBURmw1RkdGdk94VHBiWlgyRVgzaWJjTVE4?=
 =?utf-8?B?OUMvQ0JxU2dDbksxZzVxRkMzYUkxOTZYSWZ2SmJJOGExaUtkNkR0TFZrTW9K?=
 =?utf-8?B?WGhub1V4TTV4QXREbGVuZkhjSFFMOWd1RzZzMUpuaENyOWYyVk8wbklZc2pI?=
 =?utf-8?B?emIzWlJIN0ZPTm9ZL0M0bjhQSHJMV1hJMWJwWlpNbHJHWnRsMFpZajVYb25H?=
 =?utf-8?B?cmpaNEtkL3FKd3I4TDJibFB1dkY0ZXlMblZxZkFwMUYyOHJWMUtmT1JxU1E2?=
 =?utf-8?B?ODVOcEtSTVdhajVxN05kdWxMcVlZTFMzUlBEWkVjVkQ3THNnVDJWM3RyOVVC?=
 =?utf-8?B?aFJTdEJZbXV0c0p2R3pmcWV6Q2NtU2hxV1lFVFZoZHQ2RCs1dDJ0OTNQVHRO?=
 =?utf-8?B?cHBxakc5MGRwWGwzVE9lMGIrbWN4TXp0c28yWGFRWGtPSmxOaXlBVVdBcWkw?=
 =?utf-8?B?c3ZseDBZZjg1NHRQS2JIdndqbUVoUHhmSjZUR2hBbFk4eDAreDdQOVVieVdx?=
 =?utf-8?B?ZEtvMFNleVF2VFl2bUpENVZ2QVk3RDAwckVKLzZYQ1EzQ1hEak5UUnBZWWtS?=
 =?utf-8?B?ajE1SEdjazc1L2VUUllGbmdCOTB6YTN3U2VaditUSmEvVm02eU9qMDIweXJm?=
 =?utf-8?B?Njk4bDhBR0lmSy9SVCtUVTJhV0lWUVlTQTFqV1FhNzMrdG1tWmptYnNNdVox?=
 =?utf-8?B?NkNBelJsWHlxeHFmcE16S1pBUzhFVkFHSU5oUk1ndlVQY25aV25YeXVNWFll?=
 =?utf-8?B?VWI1Z2dGV1hoYzN6eThhZTZnazB3YVBHZHB1SmJEWGxmajd0OE92eWxqS3cy?=
 =?utf-8?B?SCtxSG0yZWhhMVo4SzR0NDNuV2pYUTRJd3RocnBsWEZPbGY1aHp6cmwrT0Qv?=
 =?utf-8?B?TTl6UVMyTTk4MndnZ3ZXaks4ZUxwZ0tLaVNWSngxd3F2aFZLZFJQelI4R1VM?=
 =?utf-8?B?cmVCdkRTWWphTDNJcmUra0M3TmxxR1M1dktkdy9iaCtNNHJLSmxEcldRQ3gv?=
 =?utf-8?B?STdQVXp4T3JXakJUNXlPRS8rVXJXenAzTWwxRlJMc2h0U2NEeFczN0swSjAr?=
 =?utf-8?B?WTdQczl2cTBLVW8wblg5T2taeTRpV1VFdlZKVWtEWW9iVm9nbjFhazR4Q0c2?=
 =?utf-8?B?SlI3a1JtM2JzcElnbDQ5YXQvdEVXYVova2VJdHBjcVFQS05UL2VWbzBmMmxD?=
 =?utf-8?B?ZDNDUWczaXpKbXA0a3I2MnZHU0RzbVRQYWVzNHdPdUZPY09jRDh0dEZiTUlw?=
 =?utf-8?Q?+KQA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c05298-6f77-46dd-d2c4-08dd0803e068
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 19:04:50.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zS95FQ+iNWOLfh1H97AN2rOkfLzAnnjJEqW7XTAt57aPBCxARFNuPTESMuD1pdRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

Hi Reinette,

On 11/15/24 18:00, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> Introduce the interface file "mbm_assign_mode" to list monitor modes
>> supported.
>>
>> The "mbm_cntr_assign" mode provides the option to assign a counter to
>> an RMID, event pair and monitor the bandwidth as long as it is assigned.
>>
>> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
>> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
>>
>> The "default" mode is the existing monitoring mode that works without the
>> explicit counter assignment, instead relying on dynamic counter assignment
>> by hardware that may result in hardware not dedicating a counter resulting
>> in monitoring data reads returning "Unavailable".
>>
>> Provide an interface to display the monitor mode on the system.
>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> [mbm_cntr_assign]
>> default
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v9: Updated user documentation based on comments.
>>
>> v8: Commit message update.
>>
>> v7: Updated the descriptions/commit log in resctrl.rst to generic text.
>>     Thanks to James and Reinette.
>>     Rename mbm_mode to mbm_assign_mode.
>>     Introduced mutex lock in rdtgroup_mbm_mode_show().
>>
>> v6: Added documentation for mbm_cntr_assign and legacy mode.
>>     Moved mbm_mode fflags initialization to static initialization.
>>
>> v5: Changed interface name to mbm_mode.
>>     It will be always available even if ABMC feature is not supported.
>>     Added description in resctrl.rst about ABMC mode.
>>     Fixed display abmc and legacy consistantly.
>>
>> v4: Fixed the checks for legacy and abmc mode. Default it ABMC.
>>
>> v3: New patch to display ABMC capability.
>> ---
>>  Documentation/arch/x86/resctrl.rst     | 33 ++++++++++++++++++++++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 31 ++++++++++++++++++++++++
>>  2 files changed, 64 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 30586728a4cd..a93d7980e25f 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -257,6 +257,39 @@ with the following files:
>>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>  	    0=0x30;1=0x30;3=0x15;4=0x15
>>  
>> +"mbm_assign_mode":
>> +	Reports the list of monitoring modes supported. The enclosed brackets
>> +	indicate which mode is enabled.
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +	  [mbm_cntr_assign]
>> +	  default
>> +
>> +	"mbm_cntr_assign":
>> +
>> +	In mbm_cntr_assign mode user-space is able to specify which of the
>> +	events in CTRL_MON or MON groups should have a counter assigned using the
>> +	"mbm_assign_control" file. The number of counters available is described
>> +	in the "num_mbm_cntrs" file. Changing the mode may cause all counters on
>> +	a resource to reset.
>> +
>> +	The mode is useful on platforms which support more CTRL_MON and MON
>> +	groups than the hardware counters, meaning 'unassigned' events on CTRL_MON or
> 
> " than the hardware counters" -> " than hardware counters"?

Sure.

> 
>> +	MON groups will report 'Unavailable' or count the traffic in an unpredictable
>> +	way.
> 
> I think the above can be confusing to users. It mentioned "*will* report Unavailable"
> and then "*or* count the traffic in an unpredictable way". It is not possible for
> counter to report "Unavailable" while also reporting unpredictable data.
> 
> My concern is that there is no way for a user to know if the platform supports more
> CTRL_MON and MON groups than hardware counters and the above seems to imply that counters
> may be unreliable ... so how does a user know if counters are unreliable or not?

That is correct. There is no definite way to find out if the counters are
unreliable.

> 
> Can this be made specific to help users know if their platforms are impacted? From
> what I know all AMD platforms are impacted so perhaps a straight-forward:
> 
> 	"The mode is useful on AMD platforms which support more CTRL_MON and MON ..."

Sure.

> 
> I'm concerned that users with Intel platforms may want to use the "mbm_cntr_assign" mode
> to make the event data "more predictable" and then be concerned when the mode does
> not exist.
> 
> As an alternative, is it possible to know the number of hardware counters on AMD systems
> without ABMC? I wonder if we could perhaps always expose num_mbm_cntrs as a way for
> users to know if their platform may be impacted by this type of "unpredictability" (by comparing 
> num_mbm_cntrs to num_rmids).

There is some round about(or hacky) way to find that out number of RMIDs
that can be active.

> 
>> +
>> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>> +	enable this mode by default so that counters remain assigned even when the
>> +	corresponding RMID is not in use by any processor.
>> +
>> +	"default":
>> +
>> +	In default mode resctrl assumes there is a hardware counter for each
>> +	event within every CTRL_MON and MON group. Reading mbm_total_bytes or
>> +	mbm_local_bytes may report 'Unavailable' if there is no counter associated
>> +	with that event.
> 
> If I understand correctly, on AMD platforms without ABMC the events only report
> "Unavailable" if there is no counter assigned at the time of the query. If a counter
> is unassigned and then reassigned then the event count will reset and the user
> will get some data back but it may thus be unpredictable (to match earlier language).
> Is this correct? Any AMD platform in "default" mode may thus be vulnerable to
> "unpredictable" event counts (not just "Unavailable") ... this gets complicated

Yes. All the AMD systems without ABMC are affected by this problem.

> because users should be steered to avoid "default" mode if mbm_assign_mode is
> available, while not be made concerned to use "default" mode on Intel where
> mbm_assign_mode is not available.

Can we add text to clarify this?

> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

