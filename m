Return-Path: <linux-kernel+bounces-252948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E4931A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078E11C2092D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8C373440;
	Mon, 15 Jul 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jF6tQqlm"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405D17BA4;
	Mon, 15 Jul 2024 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068603; cv=fail; b=kvYP3FMisEeijziPTWi43lW23pb1272P4+5VreoOP1YPKm5+CXbXnxf5p63FRmV6dGIQ7kVjxhN2SQTq0fLO/VuGlAcTTZuA55N4Mml0OMxJ9Yy9wc9IBBVMN9s8CrFNKUe+AIbBKkDVBZF3gtVe3N+NID7BQn1l8MDCyX9q6B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068603; c=relaxed/simple;
	bh=+Qsi2hWpC64KvFfiaSICL9ONGrDdR+R2/DrEN5D9JvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ot6xiy2yZ/z//lJJm2sgPyoy+xdupWjbpfbo6XqWuVQQ5TCS+gEETZgFIlbb5gkj7Ic7JMiRIyxB3xbG0K7+GPJkvqEySVT9BQWvp5RUSgyiO7PBItzdfpSblqxcgbnR5EuzrFEgtXyKXFCQX2rxpr7bet0Ue3PCdt7kc65aXgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jF6tQqlm; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbSDXlRoYJ2nDTO0XXbRJLltdVZsqXPVTrMW+56FstOZq0lcAsmmz6FeyfN7WoxQpSQc6IQEq00qe0BeN5aOpY703+8+3DNUi0aPhMaPx5zk8E6IiTmxASvfcExx86UttmoVAizJLaw2szxDpzZsYiqHS5q2mGzTF6m5eUA6DSmP4YEScgbCrMCSaxaZXB+eHIYGPpSvDGkjpiL4R7mX5oh5iCibN228jI6y1uJVZWTnHonQlArL99tSXzbKxGfi/SEPid815vwH+saOlewSJLjxv48xtG76LjgwdkvftAXcOqN6ItAhI6Zh1SUlQvBf5kgrZ87/ijhEq7CWwhb2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKk26PqQqQ8dkuoNuyIfU0VU5X0w9RDit8NDznTJDcQ=;
 b=uPhZGkU47JTv420dLqh5mJ86Fo7Wnl3DFSpCJcdFkNgj0G/Uj2V7BpLwD3q7H83HUigGARwn5j8eQJr7sTgM/RyDwTJkHMjor6x8jWBQ7VujaHhFFY4OiFwUiWMRvCG1b+V+Oebh+9fuHHpSeVWfNaseczoL2abBOTR7DXhtriv6cesl+0cwfzMybA7nCm2oQ5i6gq1weESMtp+MF2fc1s7pqTdzfpoIDM1UI9q1D5c12mk4JkW1h+zccx/VkMpds7Inn2TArs+Fm7jgyN2Ud/XYkicK/o8BPnaoos6TGH0eDaxIHEZhogBpNfH3SjaG2g8az3XO9vk+d9L+kheVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKk26PqQqQ8dkuoNuyIfU0VU5X0w9RDit8NDznTJDcQ=;
 b=jF6tQqlmeyYwVKcpKqU69b8ZPbsH6YY2wYJnoMbdddrwbLxtKa41Mg86MyaobUdIkf/SBjXYlrtm+C4lbctowv6pdEb7b8hVBnNFZTB8j4XVTFvi360L5tMHQnR+84l5oTKvGzoSLg1Zs/i3QpSmys63jFlLYoMzqksXOkgtjo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 18:36:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 18:36:38 +0000
Message-ID: <4ab74f69-ecd7-4dea-ac92-adcd9923b0bd@amd.com>
Date: Mon, 15 Jul 2024 13:36:34 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 01/20] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <724d0234ca56d71f9d8d893806870181d027f556.1720043311.git.babu.moger@amd.com>
 <1c51aa93-5b86-4361-87d5-3d5d48fac4e6@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <1c51aa93-5b86-4361-87d5-3d5d48fac4e6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd2ea5a-96c6-4e41-c123-08dca4fd103d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d21jQ1UzZFZCWlJKaVJMbjlMNHRBcWtEcTB0N2o0cWltWUJlT0sxL0FnVTdM?=
 =?utf-8?B?WHJ6cDBqd3Y2TFJ3S25LMkRaZjBxVzZwUytpK2loR3NwUHlkdGIxWGo5SFpQ?=
 =?utf-8?B?dHMyTS9ud1VwTi9CRnp3TnI5eTMvcmpmQWhKTFJQbStCajVOTVVzUWpQUitq?=
 =?utf-8?B?WkZrNU53cThKU2wva1ZIS1FFR0pDS1U4MC9XZ0VkTk9HQlh0NzZIa0hDajJG?=
 =?utf-8?B?WlQ0Q1VkODM4Y3MwZTZsT0xqY1RxWXdWejlkRnkrMVo1OGNpdktIVlFHR2Uy?=
 =?utf-8?B?dEJObHRISkJnNWF0amoreVFQQ3haUElkTy80NkhCT0NKbXJPT3RzRDhQMDJp?=
 =?utf-8?B?R1creHI1SFY4VWppWjZUNDJZekg4c3k4UXhkSVhCUDNCQ0tXOFp1V1dpOHVI?=
 =?utf-8?B?Z0xFaXNWc1QxS2VYcHRYMGYvUlR0cFlucjZ1WVlrUm1nd0dlblBtaEFDM1Ra?=
 =?utf-8?B?NWtvbDdtdnB3Qi9kb0dzTHR6OWF6OFo0ZjZMRVdJUHBtMHNrZ0IyNXltNmE3?=
 =?utf-8?B?ZFNCQ1VHSFBvWXRPQ0VUemp3enlnMlBNM2xFek1NR1lsZ3VkQjM2eDFFRmI1?=
 =?utf-8?B?VnFjeSttbWRZZzNpNm1nUTZjdGZhRHROZWpCQnVBbjUzMW45cjR3VWpXZmxW?=
 =?utf-8?B?QSt6NGV3RkEyWVpiaXVhMHNMZFFmVit5RUN3MjVlZ3N1MjZXOHdiK1lhNG91?=
 =?utf-8?B?bjFHRjVyL01XeUJ0QW81dnZ2ajM1elI1bklxZE5xWmcvU290c0Mrc09WRWFG?=
 =?utf-8?B?dDRoc2cvWkQ4azNlbVh4c2orL3lhcnJsUzJBQ0kwMVF4SkNMRHUxb0I4bmUy?=
 =?utf-8?B?RXpPcWlDSmlaYlRkUENpLzRuZEdjR0ZEYm9HZExvb1grWDNBZnd5TklkZ2x5?=
 =?utf-8?B?azI1cytYUkV1emVicDBiNi9MOTFsVHRoVGF0M3I5UVJ3SGZpbHFtQU1LSHVh?=
 =?utf-8?B?UmN3L01PM1FubkNTa0Rha1p0K2VmNVgrak0yMVBUd0FBc0ZuWmx5UjNQWWFN?=
 =?utf-8?B?S0lsdm8vMlBiSHoxM0p6dVphOGthQk1zclNWUmI5S3JKZndjS1JFY212SlN3?=
 =?utf-8?B?ZktTYTR2eUpaaVNmT1BnVDE1Tnk0MzR2UEwwZlljRW01dldCVnUxWUNpWW9u?=
 =?utf-8?B?Z3Z5RzdFLy8rdGpQTEV1TkNqZ0x2c1dnQ1hXV2w5MTRlcDVhREI3RFd0UjVB?=
 =?utf-8?B?OWJKY0V4bGJ0djZMMDcraUhERU90Ym85ZWc5b1FjeEhOcVRKYnhpaXVrbk0r?=
 =?utf-8?B?Z2VXeUNxaXZsblJYRk5SeHZLYVhtbHVmd09RRTBYZ3U0UGxpSzA0T1ZRaWEx?=
 =?utf-8?B?M1A1V2NEcG80akdiT1dUTE5CYzBhZE14M0U3dmh1OFJJZHNWeURhemMxZ1l2?=
 =?utf-8?B?aUNPenRkdmNjcnVjQkYycktlRkZUVEVrcENWMGtRN3ZkL2Vtekd6RzRTcW1I?=
 =?utf-8?B?d1lwbllSMTJUK3ZyRVBRTXBjRThyRVJ2TTJyY3VLZDU1ampkZmdDK0tYbkp1?=
 =?utf-8?B?TFgvWGt5ZXZxMEVKVXNCNFFFKzZtWUdhNkNaL3piQWlHVkZ5cU9Wc29icWVP?=
 =?utf-8?B?ZmZweEV1R3FRZnJTMm1vN3g4ckE1bXBHOG1FQkxhK3ozRU11M3ZCdnZXalpZ?=
 =?utf-8?B?VDlkSFVDQ3F4allscVY2OW9SRCszVXJBTjVhT2xPcnkvdFZ6MXRPd09MQlFX?=
 =?utf-8?B?M2JSWE9BNzNNVkFGMjFIQ1NEQll1eStOSjZTdGErQjh2YkFCZk8xMXczZXF6?=
 =?utf-8?Q?/zeZIoox/c/QV2PUYk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHRWSmp6NlE1TW94MCtZM2Uwa3hwVnZSK0toa1ZBWEVlYmd1c0JPYldNQVd2?=
 =?utf-8?B?VjRpelFHMjlkZnBzSjlhbUwxbnI4NmVPOEVoSnJHTHE0OVM1eDI5VjR2WjRJ?=
 =?utf-8?B?WElDbnJabkVHUUFOUjd1N0dZRzc3Wm1KcjBoR1NUQVQ3NWIvVzNNYlh4YjVY?=
 =?utf-8?B?TThDdzJNK1QrS01wOSttYWxVcGgvbzdtM2FkZHdTbGtEdkR2N0FsSWRWeFpM?=
 =?utf-8?B?d1Y1Ukduckc4Vm9PcjF6cGNxRkI3WnhXZGpUcVU5cHBVRkhwcXplcTJjUE5L?=
 =?utf-8?B?SjN1YzRLOVFLa3I5bG0yVk8yNmNncHc3U0NqSmZWTnY1bGZtZ0xXc2dOeEJv?=
 =?utf-8?B?eXEyZXRKWGdPa2dTMGIxOWsxZFA5c0NTa0VLaFd5OVhNZlZ2UG8zaVpXZ1Qr?=
 =?utf-8?B?bHZRUldOZlQrQ1NDeHpNSFM2NXgrOG5rMXBEbG5XTjZjYk1IMGp5MlJmQWRn?=
 =?utf-8?B?c1FCM3RmSEJ2QlVuNjRnV0FqZjg3OEwvRXorbW41T28wR0xzYjMzeERwVVpZ?=
 =?utf-8?B?V2l6M2hpNXZNaG9Ca2lTamRaa0hjU1grYkJ0VnNrNWJzaXpmUVBsa1p2ZExP?=
 =?utf-8?B?NnkyZHZXaERlTENaa3Y3YkxEMDBHN1pWUFVGOFI1Umo4ZDErRjhFQnlxcFJr?=
 =?utf-8?B?L2xWek5qZURaSlNsWWh2MS9WNVI3aTM0cjBGQ0RtM1FUNC9MZ3Vjd0k0TjU1?=
 =?utf-8?B?NmFrSjVkMTJheEg3R1A5VEh0RXJMdldkZnhJbU4zNCt2L0dBQTE5bmR1QlQ5?=
 =?utf-8?B?U2ozTnlVRlZEdXVGOUp2RDlOeVpDQ0JPN2d5aGxxUmY0TTI0ZkIyZHY0bjRz?=
 =?utf-8?B?MVNZTmpuY1ExM0crdGF4V1BudDRmQXVaUTE4UTV6b2VZY0lJdFZJQkJrck1q?=
 =?utf-8?B?bUVjQjdFWEF5T3hpcENQWTg2RUM0Nk5tbmtRTWJCalNvWWNSeWdMK04vcVoy?=
 =?utf-8?B?ODM3TWZqU1dWVGJCL053a0VsTXZtcExQY1M2UmhzUnpXU1R4UGhMeGdtNHBu?=
 =?utf-8?B?NjNKWjlkdzEyd0xaMHkyL3lzbmJUYVpzTmlHR2VTbEVQMlY1VEl6QVB3S0xR?=
 =?utf-8?B?YkdJUHpDalVPTnFGLzR1dTRoOEMwdmxCMUQ5Mk82dmNxbDVLQ0hlYkVTelRm?=
 =?utf-8?B?dW5wVmNxamNQSUV6d0hnclZyTkNuQVA0OXFBYk9jYXNMUnMvVXIxOWx0NUF3?=
 =?utf-8?B?NzJjU1FXeENCRnZKaW1jbkE2RktpZ2hoRjNLQUt3SmhNcC9PdjkweDBiK2ZJ?=
 =?utf-8?B?VEpFdVcxdVNKODNEaXNtdWlKNWd3N1ZpRzV4bXA0eWdEelhPNmRSSWtXSk95?=
 =?utf-8?B?RHR6bmtmZ25rNW9KaENNWk95Y3ZpM29TTnY1a2RhUmsyOHRNRVRoNUZlMUpY?=
 =?utf-8?B?cGhSdHBsbkl4TlFxSzNSeTJid2Y2UkRXSmN6cTRqZy9BVTNDZitXMzNETTRX?=
 =?utf-8?B?Ryt6cnJ4TzRmaDhwL2wzYWllYWQzZEVSSndNeDdPUk8rMVJtS25aUGFNblZO?=
 =?utf-8?B?T0tEN3gwYWdzMEZ3TTdHZ2JoM21aOU1XOHo2SjhCblBPYnpMT0N3NWVRNTBD?=
 =?utf-8?B?T2tlTHdRbnRjamhiSGtrSE1wbEFoOE5yRnVneTV3RGx5TGhRRndrZTFFaDZK?=
 =?utf-8?B?ejFzR1JOb1VucVloeGlPYkdYa2xQdWpyaDBjWnVsNEU1ZHlSc0lPVlZTTEx0?=
 =?utf-8?B?N2xSNVRPRW9lOEZHckhaQmd3WTNUaDg2amhPL0FrUkJwZFBLMTlINElVUncz?=
 =?utf-8?B?Y2RwdVJWeENtU2JpcGRFd1N5eU1EQUpmOEx6YWQvbFhqSStwWVNLd3FDck9t?=
 =?utf-8?B?V3BmUE1GMXYzTmdrOFNGbDdpMkt4Z1huUTJOU1kweVNKb1EwTlRmSGlXcmgx?=
 =?utf-8?B?MTlmWkdmbUxjTUwwaExxckJpMDdwMGZPa1lic29JWWV6cDc0aFZWRWp1YUpW?=
 =?utf-8?B?blZ3R2RTN3J6bWg5YU9HMzlKajQwRWo3bEZHc3d1K3hvNStDdXhNMzQ2aE1u?=
 =?utf-8?B?ZG85Tnl6c2xFTmlnYmNRclNEUmRUZW02Sm8yQzJXemVNa2JUTk40b0dYUHZp?=
 =?utf-8?B?WnUwZWNDY3pvZ2F1MUlRNXhvT3lNWXpSbjU1K1pqU2ZMU1JTMHg1S2pVSGpL?=
 =?utf-8?Q?hDOY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd2ea5a-96c6-4e41-c123-08dca4fd103d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 18:36:38.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifJb+LbNEsGMzsSOTn3uRW8alpXDw5BwjQT8j/CCKVDYeVVdczma4cIBSP9rrwUp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

Hi Reinette,

On 7/12/24 16:55, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> Users can create as many monitor groups as RMIDs supported by the hardware.
>> However, bandwidth monitoring feature on AMD system only guarantees that
>> RMIDs currently assigned to a processor will be tracked by hardware. The
>> counters of any other RMIDs which are no longer being tracked will be
>> reset to zero. The MBM event counters return "Unavailable" for the RMIDs
>> that are not tracked by hardware. So, there can be only limited number of
>> groups that can give guaranteed monitoring numbers. With ever changing
>> configurations there is no way to definitely know which of these groups
>> are being tracked for certain point of time. Users do not have the option
>> to monitor a group or set of groups for certain period of time without
>> worrying about RMID being reset in between.
>>
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>> The assigned RMID will be tracked by the hardware until the user unassigns
>> it manually. There is no need to worry about counters being reset during
>> this period. Additionally, the user can specify a bitmask identifying the
>> specific bandwidth types from the given source to track with the counter.
>>
>> Without ABMC enabled, monitoring will work in current mode without
>> assignment option.
>>
>> Linux resctrl subsystem provides the interface to count maximum of two
>> memory bandwidth events per group, from a combination of available total
>> and local events. Keeping the current interface, users can enable a maximum
>> of 2 ABMC counters per group. User will also have the option to enable only
>> one counter to the group. If the system runs out of assignable ABMC
>> counters, kernel will display an error. Users need to disable an already
>> enabled counter to make space for new assignments.
>>
>> The feature can be detected via CPUID_Fn80000020_EBX_x00 bit 5.
>> Bits Description
>> 5    ABMC (Assignable Bandwidth Monitoring Counters)
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Note: Checkpatch checks/warnings are ignored to maintain coding style.
> 
> This note may be more appropriate below the '---' separator line.

Sure.

> 
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

-- 
Thanks
Babu Moger

