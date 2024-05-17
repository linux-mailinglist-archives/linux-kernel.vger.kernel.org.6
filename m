Return-Path: <linux-kernel+bounces-182335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63358C89D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317F1B22636
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C112CD8A;
	Fri, 17 May 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YDAWlxxx"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41E12FB2C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962251; cv=fail; b=GllNSMzM1mXQxvG9Us3yMX7kdU2UoQLC63VeSMilSwfoWnLFqtY0K8/8ik31Ll26ux2aRxPJTOQc5Dzas2Mq+sSu9vSscvo+7dwmXP1HE5lKVmn987qOUSR+MRSeBrFRCxQh/f1V89AzVgoEPPImIf0rAgIfkVxhffk7IOVGqyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962251; c=relaxed/simple;
	bh=HGNP7H+3GY9PZxJ80CVy35fx0g2YnFaE3OzLuhfY0cQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X0slf6LhLSconIDd5lyn5D4yUU5PWfH6ra0IYAxZBOkvEengU6f93C7AJmPWS8fwNBAYbm8nq9GB7k8Lolzm2MJxnRs3fh5jsTrSkX/+Q6GVIs3ZFBABusGvah1U/JgecpDHL1BZOORrgkVN0x1fOI4oY/gXyeZYNAZZ1YvENtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YDAWlxxx; arc=fail smtp.client-ip=40.107.220.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+6KnGG5I7uxDTbJCD0JqEg/wwd9Hz7+fM+Ke2Qk593HPjqGwwatU+iM5lnK0ktm2i5zSW7mDV/SlMjrVNkHSOGjG+Stq3yrxRzjz/KVXAVldEgc4WrQ7AZvBAGBwFL7wX50LfFkVyjSKeuZVp32D7OjjYYCyx/IAaFRfhTqZ8GjEonaRuxlTVbD3OnMOd1bUZxwwVZRgSHViMJYW2F865T8JyyMwq4va81t/5ox2RPL7tiD2wzcCUUY+PInnlDtiOw2GOZnu5PEgwNxLdaovy/xhBkxXQRQFlXoiMudZUWwOmqYlqheyn8TioczPUkVJKTE3EfUEi1bqpiB/5q3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXVetSWuFWDLbGHJtJlxZSxCcPOGkZNnubLIdf9ckzc=;
 b=ZJQH9DtVo6Gm77V3oreiLzh5E3yow8qCJGoU2Zx/9olJRhR0Ctxj/StV7rBMsmfyOV1AdqeIuMzqTknLAjnSpEbF1DpOVXH/RgFS8FVDvYTUnfPleRjTPwrgtAZC+Tj9NiHvVLXkIhWbmfQAkBLOl2mNU92IHewzDZLn6PGw81reOqruuE+0bPkSgK9Rgj3q2gerSK3HrD+VdR6kc2zndt1ETu4MELmj84+4fltgggtT8ZsKkud/jtCD7WIChNE+YifOimdlNq6yZbnuq7tN2IouscuUraFee6Rx0mQmPokbrzEA+fVwZi4FHctpV1AxZRqXB2jFsVsPWZNwp6a5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXVetSWuFWDLbGHJtJlxZSxCcPOGkZNnubLIdf9ckzc=;
 b=YDAWlxxxh6WsywrCIeBMWv5TuxeerDNDbGAKVb+SpVN3fQctOz5CIiDPFUlIGqQOm4TlBqm7HA2iq5SspL3387ThYlWjzVL94aPLGCO7rdwIgPVWtXaJihs+uTte6SGw091nr+3K8FmHgf3h5jLeoFI2UfDhUgOkczihgKB1hNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 PH0PR01MB6683.prod.exchangelabs.com (2603:10b6:510:90::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.30; Fri, 17 May 2024 16:10:45 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 16:10:45 +0000
Message-ID: <dfc3f15d-e992-46a5-8b54-185f05ff6af1@os.amperecomputing.com>
Date: Fri, 17 May 2024 09:10:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <Zj4O8q9-bliXE435@arm.com>
 <f1049f13-53e4-470e-89e5-d99d7e171d39@os.amperecomputing.com>
 <ZkNCsT0dGwOyap7M@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZkNCsT0dGwOyap7M@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::11) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|PH0PR01MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: b1657c02-d61a-4b8e-45af-08dc768be864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2MrSXNLOG1rd0E3NTNnR24vRXVCSjNlR3RHWUFIL1phSGg0Nkl3enJ1TzBw?=
 =?utf-8?B?NXlNSWJqUFBJWUR6UnZidkhGQUhKbEtMQmZ2aUhEeHVMYm4vcXRXcnFqYnZi?=
 =?utf-8?B?bDh4UXoxTDhsUkcvdDFRUi82b2pWRjh0YmhIcG5xbnhwOEU0ZFAyMWt1NFZK?=
 =?utf-8?B?SDJiWGRSbG5LdDVkQXp3ckJNU01lT1AzZXltbXZCQ0cwMDFEZnFVTVJESW9V?=
 =?utf-8?B?RHI2emdWMDk3WEJpOFN5dm8vWEJMWStIWjJ5bG1pYUVZOC83MTVRRFN6QTha?=
 =?utf-8?B?VkZDbytTczlIVFUxYk5xMHhiR25waGhvQkNZYVR4cFJWRHl6QlJGRFJrcjJn?=
 =?utf-8?B?cnFQYnE1OXNaNUIwa2xTNUhNNFlNS2E4ZndvbFBPUnhWTFNLc1BPOHF5bDNw?=
 =?utf-8?B?STVJMWI4OG9icFF0MW1rNnNJSTYrZGsyUjZDUE0vTGdUQ0tQYzBrbDBVN3Vj?=
 =?utf-8?B?clg5UWJxTWJha0V2TU9HMURBbm9OYitEOWpFd1g3cXJoZm1DSmU0cEN3S0RG?=
 =?utf-8?B?MDVPKzRFTmJYMzFFVVpUeUEvK2ZwRytOaUJXQm9YUHQzeCs4ZzYrQVQvUFVx?=
 =?utf-8?B?TWFwbStKY3owVE01aFBoaFVIRFN6MmNiKzdMQTI3R2hlaktUaXVIRkx0Q3dv?=
 =?utf-8?B?c2VMVUZ1MFVaQkZndndLQzgrQTYwaCtlYXUrTVdWVTgwVkx6UTBlaFZQVTBj?=
 =?utf-8?B?aHpsdkFtMExVUEVBa0lRenVMZ0hZbGxYUVE5Ylg5WVphL0YxbWhONU5GaHZn?=
 =?utf-8?B?TlRkTmZmYnBTRlBhNFRlZlkwUWRhelRzN2lGNGJoaXNXalRpYVR6citoU3NW?=
 =?utf-8?B?TWw3SmJEd0FjamJJRlVqbHArYXpxSFMwVFp0SnBRK1VoSVRDbEZ3ZEs5LzRu?=
 =?utf-8?B?VkZycjZwWnk2Z25NVTJnRnFCQzloVmpSb1EwT2ZNWVZZNVd1L3VxaG50TEdq?=
 =?utf-8?B?d2FPZkVDc2NTenR6REgvcWdXMDkxcFMwcGZpRU9hcXYyWXU4OTcxam1NVTdW?=
 =?utf-8?B?Uit1bUtlNUdIZStJQXhaSjVrQ0ZSKzJxQWlWSG5INjNCQ3dxZjB5K1NYblJQ?=
 =?utf-8?B?YUV0UGRwYmxqMW5xWU9KS084RWxVeTdmZ3NDYWZWMk1JaGh0aW1qMnkrZVht?=
 =?utf-8?B?ZEkrTy9ITkZid1haY2ptSjQvdG93R1FNVk0wdGxOQ09xaE9KYTd3SmRvSnEw?=
 =?utf-8?B?bi9OaFdycHB2djJFbmQ2dldOZkpsWEhSSzdjemd0OG5pZi8vRFJTblFyT09E?=
 =?utf-8?B?TzZLc29MK0cvVjdrRDZUQmM3c3ZoSktySVB6Z3lpR3hTSzdEYlQwbndhVjhv?=
 =?utf-8?B?ZmFFcE8xYWJITkZlNXVYZWR3U0RMaUFCdjBwTzdBOW1QWHI0cy92NmZOR3pM?=
 =?utf-8?B?NHZqQ050Um9UM25qZ3RXOGFIMTFCcFhraWZMb0haaVhyZ3F3UElBOFFhcHc2?=
 =?utf-8?B?ZW1lTDJVT01Jb044UmxnOHhYRmFRWnZjb1NKVmRHREJaTkdCOHZNMHZIK3BE?=
 =?utf-8?B?RXBvbndyTDd5OTBqYzNZZWNWYzZrc2xwQ3FTVGliQUg1U28zbUlnZnVYZ01m?=
 =?utf-8?B?SUI4L0pSdU5JYVovYjJ3ci9qU0g2N1k2UUFDNXNpUnFBRmpKbEl4aGYzSzhx?=
 =?utf-8?B?YWMvSTd1RjZMQ2h4RlIvdW9McFR5VGpjRS9JSjM2MEo4MGh0ZTR5NHFvYmVi?=
 =?utf-8?B?SG9ZMTZiS0oreEpsNVdValFYMHRpMVhaTDYwSmRhYnQzZUU3MjFWSU5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkh1THZkOEVhNG5UOWRHUjZIeng5NElDQTRobTd2UVRwZzM0amVVTFFZZmly?=
 =?utf-8?B?VDUvYzU2R0d4c2luYUZMQ2lxTDFlRytnTkFaY2hBU2hQeDFNTWNycllpSXhl?=
 =?utf-8?B?TVpiT0t1NWQvcW1XMEZxYS94c1FVTDVjaEt6MmRJSWlDbFBxbUYvVlNmZGhE?=
 =?utf-8?B?TDVFVUFicEtIRyszZ0tGdS9kSnZ0VW9UbDVHeVZmRysyNmJqc015TXVBRWta?=
 =?utf-8?B?SldQNkNtWG0wSlFFSk1JWVBxLy9aQU5tZURweDZwS0E0Ymlzck9xK1JxWG9v?=
 =?utf-8?B?bFlrRkhCcFAyMzVvTExaSHlxMloxcHY1VURYb1ZzclQ3WG93MEw5WE9ES0VN?=
 =?utf-8?B?LzFKeGEwcGxEMzhYcUU1VXB1cEhEUkFLQU1DVDB5eXZPbEl4V2wyblRiUUlI?=
 =?utf-8?B?Q0NVMnFXSy94MzcvNUsrQXZybldsc1JkV0p1Y0thcVJSR1ppWHp2a3RMaitr?=
 =?utf-8?B?Qk9uais5V3hCeDlYVHNyclRSMUVteTBRMCt6VmdoelVCa1haSDdYN3gyVDZv?=
 =?utf-8?B?U1A2ZG1zT3ZHbW9kbGpsMmdpQ0liV0FQQWFDeURWbjBrNEw2TDBpWUw0eWxX?=
 =?utf-8?B?ZThhdHYxWGdwVmY3VDE1aVJQL2dlWUI0S2NIVFVyeVdSdjVZc0JtWm1SVmZi?=
 =?utf-8?B?b045NENZZWUwMjFhSVprY0hLaGYxZU1xY0V2OXM0emFBNTZRVVYraENwUkxB?=
 =?utf-8?B?MjRrTFZ1dXlPcHVLR0FMMXJNZjJ5dG5LMUxxR2QycE5ESTQzd3NibzdqVHhm?=
 =?utf-8?B?V2lHQXJUVkJPeVdobjA1ZUhoMFVMN0xXeTJLaDlWMXZjbmI0eFgzOFhZaE1M?=
 =?utf-8?B?Q3lCRnN3ZXZZV0cwdWRGS0Y1Mi9ndmtBeUdBNWtVRjFCbFRoOE1vY0pwcFE0?=
 =?utf-8?B?UGljRFArYUt2RW05UHdZMEVCcTdrOFpwaE11Sk9NQU9VbVpGNmRXYmpmdytP?=
 =?utf-8?B?d280RmFJZ21ENXp6blhKdW9hZ2d6ZDVaSmx1QVpEaHd0VGdlOFA3RVNOeTQ0?=
 =?utf-8?B?LzE5bFhVeUZKbTFQTTlWbUVJNTRiMHdlYUt6bUNaOWxRT2hUaFV1OXc1VVhX?=
 =?utf-8?B?ZHh3a1VkbHB2VVJndlZIZHlmZVhlcjI3NFdqK0ZXZTVNQXZ2c2Z0aWFXQjYv?=
 =?utf-8?B?eDFkRXdzcWVhVllhalBpZnNoTS9ZREszZmt3bXM0VHYrZlQ4SDh3OEpuZUZT?=
 =?utf-8?B?ZUFsdXJvbW9ad0RaNDJENklvVUFnQWs0SDR1WUxreGpERFRLdjlVdXNtSFJi?=
 =?utf-8?B?Q1Uya0d2R2xBQWFEaW9yZXZ2bXY1TzQyYU1IanVBZUE3SmN4dGtIc05hQ3Qx?=
 =?utf-8?B?WXNZalNIUERSVk9CV1RyNHpQcUlFQXRneW9Jb0VOMnA4dTJtdmtYUi9aMzVD?=
 =?utf-8?B?d1M3amg2a3kyVTlITzU5OHJtSGJkUHBGeUcxcjVVZGRGUEZrbW56UHVsblY5?=
 =?utf-8?B?NmVuanREOU8vNjJ4amM0SFpPQTh4a0phM0owTlRkZkQ2aEppUDkrWE5QYzJv?=
 =?utf-8?B?VllRY2p2SHltMHNhMzVIaFc0aVhRNU5TcjNoYzI1ZFpIVFJZVEJkM2ZuTWMw?=
 =?utf-8?B?QkV0QlM4dWdUdmFIdVlkVjUwWmVVZ09oVkxWeEwzNWUxTE4zTW9iWTJCM29M?=
 =?utf-8?B?b1ExWTlNbzdiTEtJYTdlUC9YV3diR1BtR04xS3hKcmhPL1E2eU5LdHI4SERp?=
 =?utf-8?B?OTNnM09lQU1LRGlWMDEwTDRwZi9YdFVTWGh3M3JGdkM1UkFqTVdXTGVqaDZ6?=
 =?utf-8?B?U3I2UC9temFCQkFad2lhVTZjWEtWbHYvaURmT01neTdTZ2RkQmllSVh4aUxJ?=
 =?utf-8?B?M1ZaSlhSeENoVWJtT3luL3VmZ3ZDSEJoTlNhVi9WWkJEQ1pRZ0x0cW9yK1Qw?=
 =?utf-8?B?MzdKUXdHcVI2ekVLM1BVK1FqeVRpYU93ZnNxYmNRais4UWJ1bFNDZk8wRUJ4?=
 =?utf-8?B?WEc0MjFZMWZRM0lkT0xrLzhISVJ4V1pmUSszcWIzdWo3VDlEYU45OXZhbmdw?=
 =?utf-8?B?ZzVzOGRnc0dINDY2OWpBODNSYU5KR01qRUlJb0xSdGVHeDQvS2IrY2FMRS81?=
 =?utf-8?B?VHQ4RHpENmVXVFRGOVhIRkxqTUNpUWVtZXR5c1hCRWU5OFB2UmZPNjJZaERH?=
 =?utf-8?B?bTBIUTA3dkIzWXJ0ZzRONmQyRnhTZHJnQ3ZDU3cyZ04zVUJsY0JRV3pVbEU0?=
 =?utf-8?Q?RyzgiisYONUjPwcQhp4HpXQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1657c02-d61a-4b8e-45af-08dc768be864
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:10:45.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8xH6v6YKoQ9JOSe1pbVekRcTJB0jtd0FAcCk4jvR3o7Yl+mW2Gj6E7ipjdqvN/xSUOwvjgjqPVh5AonkIUav1Fwa+8FZhTj0hvOzxIl1xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6683



On 5/14/24 3:53 AM, Catalin Marinas wrote:
> On Mon, May 13, 2024 at 09:19:39PM -0600, Yang Shi wrote:
>>> That said, I'm not keen on this kernel workaround. If openjdk decides to
>>> improve some security and goes for PROT_EXEC-only mappings of its text
>>> sections, the above trick will no longer work.
>> I noticed futex does replace insns. IIUC, the below sequence should
>> can do the trick for exec-only, right?
>>
>> disable privileged
>> read insn with ldxr
>> enable privileged
> Do you mean not using the unprivileged LDTR as in get_user()? You don't
> even need an LDXR, just plain LDR but with the extable entry etc.
>
> However, with PIE we got proper execute-only permission (not the kind of
> fake one where we disabled the PTE_USER bit while keeping PTE_UXN as 0).
> So the futex-style approach won't work unless we changed the PIE_E1
> entry for _PAGE_EXECONLY to be PIE_R by the kernel.

I see. Thanks. Yes, I did see this works without PIE. As you said in the 
earlier email, exec-only is not that popular yet. I think we can just 
ignore it for now.

>


