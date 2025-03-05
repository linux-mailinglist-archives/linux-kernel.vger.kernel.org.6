Return-Path: <linux-kernel+bounces-547729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B991DA50CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69ABF168BDC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65DD252912;
	Wed,  5 Mar 2025 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eVKFXZ+w"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C218DF73
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207686; cv=fail; b=YnQnlfVXFTSJrN2CGjakypI4keeS+xGaq6+PjPjtyUOGbr5TOYPogMYUp6n8ug845OBnDC+Kw5NGXFrzyEcpx9hRxcmByF+eTWI3/os8efpqCAkqUWEJtQeWttyaAAW/29I5GK/IHpEdyx3YSj9EWjR2642nkIQ/pqRQP7xxJyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207686; c=relaxed/simple;
	bh=vsK/vAwOWCiPSqHgzUSIKrjP0W8FMrah/2lm/3di3+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bFNDIvtJnr3qZTvoQMs/B2VkSx7LTFOqsTiYR7MUJtF3UGGg764740uiH5eqGyNMAr55VQTS/4fgls+8I1oQdnFlmkN8uFlCiwRobvbrjjNYhjoa9dWIJhMC9rwjCHFLypnQgViuxm0iijXoq32unTLQHZPuObB+0/QLqOw8HDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eVKFXZ+w; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sS30/enFkXW3+TobUOazxemk0V/GKy7Olbj45HK0Hnff3UPmlaKvqAaDjNnCqnCZOXhWytIMYA5vCXLRIcEoOECUWoYDNIQ6byQXbVdrTvQIetANzuQvL0D7U1ZdIOi3dBQbE1zj217Kje7HdJRR4IVbPEVCFnjFt7Eexu5PP/cOVwsVF+t/74n2FjT7zeTm3DsmxSWLDnbJyd2ule2pzezB6kwzfyhVXFwCSFTqLU1vEdTQnaZsT2VSLMi+dZ4G5Bgn0jHATMjOM13coPyjEeeyRhoj3dVoNxWaA4FNvRz1drrN9KkjXni1MuvPOMDlfysNrM6qjgEOIl/M9CqmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xipwz1vWxzCwrZKPmmHCU5RBc0BdTn/vt5VxyjDQptU=;
 b=mxZc4G0Yht4+smdWYGu6ga5aAUnC06M9bJ67Pa37vvUs0dKPQRnKpmBv/RTDQyHNiXUeKLXRYUvquOoEeC5/7H6SpDMs5BAXlk3h5JNHPSj2O6XFiH0X9vRh8KPRZ2Be7mLAs4tlHgZ4otEyaUc6fV5rORsf/P8k8/E2y/J+XhFSypmjqQicMTEjakCy9wuauRXAxP7nf0Qv/UFoYnklmZN/qREIyA+tG/gSL3+iPCzn5YgzBKT1E7CWW2/OaGImTqjkg2HDa+jeEvvtFl/Nr4/aOIv65nNPmV8FwomUWUIAr04DNsENdv+79zXbvTPPYfF/TslNVj7t7rq/Ikb/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xipwz1vWxzCwrZKPmmHCU5RBc0BdTn/vt5VxyjDQptU=;
 b=eVKFXZ+w90RH44cnb632DZs9UuZ1I5odwhloAEA2/8kmJbMrGh4EHrRyo2WXbUQjsJ4t2PWlT77NbDRiMMiU9fIIY12SA0oalkiTLKcFt8yAmf+3ptbwX3RwNSs3XybcG39RnJGYedHk8RQqFk/D5OqqI3052JFjHOclvdUMejw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB9525.namprd12.prod.outlook.com (2603:10b6:8:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 20:48:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 20:48:01 +0000
Message-ID: <806c0b95-afcc-4f31-a677-64b68b36282d@amd.com>
Date: Wed, 5 Mar 2025 14:47:57 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Reinette Chatre <reinette.chatre@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <Z8d1AjhSVuS4wRP5@agluck-desk3>
 <372da3ca-c11c-47c7-bf9e-c2fa0a91a1b3@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <372da3ca-c11c-47c7-bf9e-c2fa0a91a1b3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB9525:EE_
X-MS-Office365-Filtering-Correlation-Id: 2baa3d59-dd54-4742-602b-08dd5c2704a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clhuUFp6bHg0dE5ySFMxSVBHb0dOcFcvRzZGNFBZay9vSDR2a0IrMDZhSjNF?=
 =?utf-8?B?V1RjZzhxTE9GakswY3ZpUVE4NVdXaTZtN1Qva3ZaNHk2OGlNQnB6aXp3Qitn?=
 =?utf-8?B?MmhYUVJOMUgrbVBVWWVIZDJKcVBTazBFZ2tVQmFrWGJEbm5Ddkl5d29MVXg2?=
 =?utf-8?B?MXRGYndObWVVckR2a0FJK0toOHRWVDl1SjFoQmJmRGcveGNIMkloRzFSTm56?=
 =?utf-8?B?a2xvRy9IVzJPZ2JkS1lOelNwR2RhS0k5MlNCbFlSdmhNbzRnZzFwa0ovaDc3?=
 =?utf-8?B?ZGJOYXdWcElNNTErV3ExYkZwbmJTUFl6VEZDRzVJRkhkS0paWnFQUU9rZkY1?=
 =?utf-8?B?dVhvbUdiTlJVZFBoN2xaNUcxR2hXNXBmWlJNQ0tRaFZDNnppOUE4SGM2K2pV?=
 =?utf-8?B?MW5NUTB1ZkNnNS9HaTlZQTZRQk4yT3FGS29jLzBPSy9vbTBuQ3F3SjBub1Ni?=
 =?utf-8?B?WS9JZ3gxdUdySmlSeG1hZkhtSUtHMnhwdlhrdjJyajRRTUZqbmhvZ0VYbzRJ?=
 =?utf-8?B?SjNxdnhQRjV2R1JTa3FRL3lFTE1HQTlZcDJ4VWthU2lYTTkybVhwNC80SXQw?=
 =?utf-8?B?QWQvRTZGbUxwZ0s3cmlrSXJ6cHdadGlGVS81WFBINnhBUEhkckFNNGR4dzMv?=
 =?utf-8?B?Kzg0dWJkVlhsbW43QnFQL0Q2VFI2NWQzblRyd0pWZW55VTZVM0EwNElOM0dt?=
 =?utf-8?B?M3VmQ0VROFl6eDZRUlZZenFEaEs0bkdQQjNYODBVcEtXS1hYUVRCNjFNcWhD?=
 =?utf-8?B?ZFA3dXJrVmdOWEhTcHViaXZKZDlmWlBNZzBnYkxTem0rc1RUQjV3c3dDUEhB?=
 =?utf-8?B?YUkxd0ROdzJuSEgwOFVGZjZlOTBrQVp2NDBGcmx0eDkzcmhHbncyV1ZYeTZN?=
 =?utf-8?B?WC9zS2ZpSTlQVXBFMndpb1h6WFE4eG95R2lZTGhhOHBiRVpsYnB1a2dYTVFo?=
 =?utf-8?B?WTdvQSttUHlXbU5vd1F0V1RKU0dvK3hkQ0I3QklnanlZdmJzSTRUR01nZ3Mv?=
 =?utf-8?B?YmpiLzFxK2crMXBxbkRuRGdpc1lsOENYeUpYblZ2SkJMYkw4SnZWTHdUKzAv?=
 =?utf-8?B?K0pxOEd5ZDE1R3pXMlowNkNRZnpIeVNMZFRjQjN5ZXZ1T2lFaVBNNUtWT1Fk?=
 =?utf-8?B?U01DSzM4ZFFOdFdYU0w4R3RiODVxOFAvYkdtK1FsQkVnWFFMVkpoOGZLNjFO?=
 =?utf-8?B?TWRsQXlFMlRMQmpxTEhzUWUvL0I4ellWck15YzA1RXpRemRlbmlBck5Qd1lS?=
 =?utf-8?B?OEV3eXlmN2I3c08xREVrNFdha0F0ejBUOVRuRlFMeXUxMlVwYkZ2K2JObjBD?=
 =?utf-8?B?NytLK2tSbGhKajRQWHU3M05JdHVwSlRUOWViRmdHZFZuRy9LRlJHUXhDWm0x?=
 =?utf-8?B?ZURoWVJpaC9TOTlrb0t4NjVva1JSQkd4VDZUNVora3R6MjFlUWV1N0FsOTIv?=
 =?utf-8?B?ZEV6OHZXV1FmTndoRVN5OFI1UTFFb2poeFdmdm1yY1Nwb1JBNWVjbzB4a2I1?=
 =?utf-8?B?K3FQck1hN1pYOVB4Zjlva05HQmc2d0lYOGswNWZ6RDBBV1h0QkIzbTlEczdo?=
 =?utf-8?B?Z0YxUXloVWo3d1h2bHdMdmRvUDFYcWQ3R0VwbjFtazF0RGFuc3ZUcEMvTVZY?=
 =?utf-8?B?SjJ4eWcrTDdMWTdJUU5Pckt5Qk9qRytWZVdWdnF3eHVWOVlvQmpaTm1HamhP?=
 =?utf-8?B?T1VOTEFzc20vL2RCQS81TW1UVEV1V3BOTlQ2NDJhZGdmVXJyRU56NjBFVnox?=
 =?utf-8?B?TGF5eSt6WnZNeFAxTTIvNGVUWVFEcHVJWk01ZGlkckhramZBa1BjRVlMNUdn?=
 =?utf-8?B?TW9Kc3VnbUl6aXprNW5YdlBVZUt5Mk5sd3RFY2R6anF6VFpOUkZuU1RmblFM?=
 =?utf-8?Q?UNqQoxiHApr4P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OStqUG5vUGJ6UTRMaVhTM1Q2UHNncmg2WGFhUi9OUlUyR2FEU0xFL01CWDVt?=
 =?utf-8?B?WE81THp1MzZ0UUtJYkY1T1VLV3JoY01sb2lZV3dwYnNTSnZlclFYd25vbjRS?=
 =?utf-8?B?b0x3aXNKZEhqd3JKYkYrK0sxeThyQWtXSy9hT3kzNThZcmQ3RzBwTWJEMWVN?=
 =?utf-8?B?STU2N0JPb0JPQVpCVzJlYVc3UktsQXRmNHlLM2hvRGMxTHQzZjh6RGFsbDN3?=
 =?utf-8?B?Uk5veW9wNzZsWFFJdytkb0twSzREQXR1SUNjK01RcGphekRzMkl4TFo2d2d1?=
 =?utf-8?B?em5XYkh2bjdHYVhNV0srMmNTS3o0amlrb0lsbWRieC9taEZ2RG9hTTROVVhs?=
 =?utf-8?B?emd1M0dDUTJlam5idWJpVVBMdTZ4STJTV2twWGZhNlUrNi9uYWc4ZVlNRjNY?=
 =?utf-8?B?UUNuM2M5NHpHQjVycCt3SkRCMGZRdzMxRXQ4UzU3WXZRaVd5N2lhTkxOdUVn?=
 =?utf-8?B?eXRydnF1SmQ2ZEkvZm5ZcmN0eDhPakEyZjhXNUdCNlBQbXY1VVRNMEwxVUpX?=
 =?utf-8?B?ZzZoYk4rRUxyN3dyOHhwQXFXQWp6V1FjYnUvdWoxTHVVSjJsWlhlTDlrOUJo?=
 =?utf-8?B?R2ZrOWU5WkVUQU1DL1lodWYvaXFISVNVbkthVFlHNE0wZUlFQVhaeThjclNk?=
 =?utf-8?B?clVtYTNzUjk3cDRrdExYS0d2ZGFOLzF1STlTUVVoSk14V0pUa0RiNlBGT3Rt?=
 =?utf-8?B?VzNlR2ZLVXEyeWxZY2hrNnpna1crcGZmOE5zZXNSamlHYjRreXBvTEN4Umhm?=
 =?utf-8?B?U3J5ZDM3VnY2Qy9icW05SFJCVkRLM0ZLdW1oSi9oTXdxejNNV1dMZ0ZBV2dT?=
 =?utf-8?B?YyswZUdXK1RQWGNNTTNFMUhGU250ZzNWM1IvOHVmMzc0VHNLN0F5YkFwbWpP?=
 =?utf-8?B?cjFoNHllSGVlMkdPdmtCZUs3TzE4S3lvTzlhY1JnY1BleHJuOGNaSktTN2ZB?=
 =?utf-8?B?ZWhzVWJmVDU2dCtycS8zN2lDeWpuSHdHQXlMV1BRaXhZQWJLYUVpOEFkeGhM?=
 =?utf-8?B?RzJIWkg0VzF4WWJHSnZzY3ZyTTRuNFhoVVc5U2ZVei9qYlZFY1JGRTYvWUJL?=
 =?utf-8?B?d1loaTI3YjQyeG9icmhyUGdlelRqdmxHVmszRDQwQm5EYWd6WFFtaHdjelBq?=
 =?utf-8?B?OE8wLytYMlkvVlRUL3ZuWHVZR293QlRRU2dJYWw3L0RoVE41OXJ6dkNpeWdB?=
 =?utf-8?B?U0ZGY3c5RmxXMUgvbUhhUm0xS0ZiMmduU1FzTUFOV29iYko2N095Ty82UWEx?=
 =?utf-8?B?dFBVSEF5ZzY0OWpvSVJRclQ0bXY2V3BwRjV6ckQyZVNRVnduVWZvbWJxRkR1?=
 =?utf-8?B?djZuM2x2RXJXeXN6WFNIS2lYT3hZeSs4SkVrY2NDWTZjTXczN2R6T0dPcjkx?=
 =?utf-8?B?TTBUNDJ6NVF2eFFBdk1weXpuSEVoZHNid2t6RFdPNWlLSk43QUw3dXhxb1NM?=
 =?utf-8?B?TXdwd0tFWHgwbXdrZEFXRWsvVkVoSkhPekpXSis0cTh3NmFwTW1jS1lXT2hK?=
 =?utf-8?B?VXFsMVBsUXNhWTJpSytuNEdIYWZIOUlsK0lSbGdlaWMySjh5QUlKNFRLRXJH?=
 =?utf-8?B?Zzd5YnlEMmFXdWd5MEtOWEdiOGJrMkd0Z2dsYmJzUVJEMHBERlgwdGYwWFFs?=
 =?utf-8?B?ZTcvN3V2NXE5emtINFZnd1V3bDBmTXAxVVJoOGpVd2Z6THIyQjR4QWtyTWI1?=
 =?utf-8?B?bkErOHc2UmZqMWNHeXBIRGtML0pBZGtNK2dueFZoaW83Vy8vOHlVVTdRNU5u?=
 =?utf-8?B?bmJxREMrYlhoSkplMkV3YnhDMy8wb3BCV1JlMFBSNm15M2ZkNGoxMW4veWhS?=
 =?utf-8?B?NEVHRkp5VGlOakU1Y1ozdE9saFVZckp2aUFhUUpFbDF3NXBrU3JOVTRUTDFO?=
 =?utf-8?B?ZHFLVkFSbXNiV25MMFQ4M2k3dHQycUVoMmtrRFdJcHFKKzRMNS9lZXlMZ0N4?=
 =?utf-8?B?NGx1RXVRUGVPSW5McXFpTXBIMzk1RGM0SUtrL215eXN1bGpHRFhHK2RDNmFF?=
 =?utf-8?B?R2hMZ01rMGhyVE14NGlueGV3SXNQd3NReXJ3aVFJYS9ta05nNldMSm5rd2Nk?=
 =?utf-8?B?SXRmTGhXaTNrRVQzNk1tdS92QlorRzdFNWFpb0xVelZXVFRya1FVM2gwWkZ3?=
 =?utf-8?Q?StTs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baa3d59-dd54-4742-602b-08dd5c2704a8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:48:01.0005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nsRFynyrLGeTT88VO6Zx4htPBSxlpchY5XCm5ADiLsbGv5pov07GYB/hvXiei1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9525



On 3/5/25 10:35, Reinette Chatre wrote:
> 
> 
> On 3/4/25 1:47 PM, Luck, Tony wrote:
>> On Fri, Feb 28, 2025 at 07:58:24PM +0000, James Morse wrote:
>>> Changes since v6?:
>>>  * All the excitement is in patch 37, turns out there are two rmdir() paths
>>>    that don't join up.
>>> The last eight patches are new:
>>>  * The python script has been replaced with the patch that it generates, see
>>>    the bare branch below if you want to regenerate it.
>>>  * There have been comments on the followup to the generated patch, those are
>>>    included here - I suggest they be squashed into the generated patch.
>>>  * This version includes some checkpatch linting from Dave.
>>>
>>> ---
>>> This series renames functions and moves code around. With the
>>> exception of invalid configurations for the configurable-events, there should
>>> be no changes in behaviour caused by this series. It is now possible for
>>> throttle_mode to report 'undefined', but no known platform will do this.
>>>
>>> The driving pattern is to make things like struct rdtgroup private to resctrl.
>>> Features like pseudo-lock aren't going to work on arm64, the ability to disable
>>> it at compile time is added.
>>>
>>> After this, I can start posting the MPAM driver to make use of resctrl on arm64.
>>> (What's MPAM? See the cover letter of the first series. [1])
>>>
>>> This series is based on v6.14-rc3 and can be retrieved from:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7
>>> or for those who want to regnerate the patch that moves all the code:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7_bare
>>>
>>>
>>> As ever - bugs welcome,
>>> Thanks,
>>>
>>> James
>>
>> Upstream is at -rc5, so it's time to pick what to ask Boris to
>> apply to tip for the upcoming v6.15 merge window.
>>
>> There are several open issues for Babu's ABMC series. So it
>> isn't ready at this time.

I agree. ABMC series is not ready yet.

This series should merge first.  I have tested on couple of AMD systems
and everything looks good. I will respond with Tested-by and reviewed-by.

>>
>> Also several against this MPAM series from James ... but IMHO the
>> first bunch of patches look to be in good shape with a
>> full set of Reviewed-by and Tested-by tags on parts 1-7,9-11,13-17
>> (things get murkier in the 20's and maybe more likely to have
>> issues due to skipping patches that don't have all their tags).
>>
>> So I applied those patches on top of v6.14-rc5 (all but one applied
>> automatically, patch 10 had two line "fuzz" due to skipping patch 8).
>>
>> Resulting kernel builds (with W=1), boots, and passes the tests
>> in tools/tests/selftests/resctrl.
>>
>> In the interests of making forward progress, should we ask Boris
>> to take this subset of the MPAM series?
>>
> 
> Sounds like there may have only been about a five minute window for
> clarifying questions about v6 before the door was shut on it.
> Since I missed that window by a couple of hours I'll move to 
> v7 where the MPAM pressure has so promptly shifted.
> 
> I'd be happy to work with Boris and other x86 maintainers on
> any mechanism they prefer.
> 

Sure. Please go ahead.
-- 
Thanks
Babu Moger

