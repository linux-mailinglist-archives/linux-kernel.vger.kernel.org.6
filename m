Return-Path: <linux-kernel+bounces-433486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30869E590D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82099169F70
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442321C190;
	Thu,  5 Dec 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZcnhmhbI"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021091.outbound.protection.outlook.com [40.107.192.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16821CA09
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410774; cv=fail; b=oWKZakY9+MJrZkVbx+26IQr0enabW7dctb76bCtJQrDrzYa+tC3JnSBhCXRY7Wohphrtc27rb9WL1oyEoEbxtJQhCMmZ/cQDadSgxfs9DZi0BqQJvbtO1c8vQlOHGZYIot5wniSZjyHtS1lHtkzbMvq9cpXM9cKN7ekuoh8aF4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410774; c=relaxed/simple;
	bh=ZeGjmokfv2m5zKOV5IU0cmezLTzspfzH8fIxjmfKPJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MEoURJaRMcIZ+wfNJ8TfjSMXkNLjHdCXrlftRFA5km6vYzPuU3RtF7KT3dW+oiVnkn0FhGaglM4aKLfDh1iRgpc2dZKz+ruo8P0TSc1XmcCXPGckyo17jGZ9bL+m6J3Mtz7un64TXcCqVC5oiSZCWaJbteGrFd40/4qa7Ps+06w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ZcnhmhbI; arc=fail smtp.client-ip=40.107.192.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoFn6X2220WuledZdY7E7QUqv99a1D/iF7+y0CaJmDqfjYPNK9tNTkLo730c+kfsBUgDHOeUjqyfiavWXno4BnVMDFwx3ZkLYlcJlGDev2awuHfTeQlDUTDujjvDh8FuxX6/NyGqPc3VQmDcoANcZ0gs2rmy6wNLFV5lapzPv7J7TrVG8hBEyMJp6jndD2bP3yKqBLB1iR8wREMYyJesaXntvM+AU75f1mLW8OUm/v1jAR6uLg0wur1qKFvaiCORxgXj2DrQMIiNo89FV94dK3mpyShU4ME2ZLVG8UO8IP6Iwj43zJ5dNxQwNpnQKfMf+YZ/tsHB2xhAxt8tJpAuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUDLK3TccASJHDYnTsLpwzmskvibwV8P3CJu7Z7oQ2U=;
 b=ilLxzAoVa7nFBBZS3lACmlooA/9iybjUYJQY7Fq7AFDC/q3b7hw6Ux8gl0qXuBN69dW5LCfBTfd8pxyx+zZEBJJSCNjuZTWOeaKJHNPfEOYF8Tq9VAlH8Q/nvlSxo1lOqunlrH/Oxw4LoAZyTkTq03hJ2D8cqMox0yu6NUpR1VoOWA1G9A0KVEA9jqTlMIE5KfU/oP/QdCQLiDUOYUtOTeOFqWB8b6NHIr9o9HfoaKI6M2CZ3zpqBKWxLy4YbaPS67xqSFi8LJ/qtTyzY952bl4wNMXkbSu30KX678GKqQ71fc67FFgQLrbIWDt4s0VORTlrH8JQyFwJ3DebEj1FfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUDLK3TccASJHDYnTsLpwzmskvibwV8P3CJu7Z7oQ2U=;
 b=ZcnhmhbIgL5WuoC7EGcvW95/AWziQUEN2PWG69D3UiyppMw7lNSIPhKzERzxbaUMOX0AU3kDIazmxHemBcYQq/RROT8ddPZ6uqGzHmKz521l6mCnwK+pXumK+N0f6t27GmwIrCT50tJmkbnTYXUTzDNjRlr1ALkl06WjulxGr3VjHQ+iiqkH3SCnBtP2p8K+4K1Elmv0iL9ieV0UzX2la58czWe8XNmVsnZaiRDhwNZ6aQIqH+6auISkZ2HOXiydcQH9Pg8zJNZsInRoOwZJCp36pQl3wfmNPcXqRalfo7JaPlvqXPIMQ2bASRZFm5ELZnchd2XPwZMmXDZiN8iizQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8205.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 5 Dec
 2024 14:59:28 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 14:59:28 +0000
Message-ID: <0a5255db-5455-4317-979c-191cae3ff42b@efficios.com>
Date: Thu, 5 Dec 2024 09:59:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smp: Evaluate local cond_func() before IPI side-effects
To: Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman
 <mgorman@suse.de>, x86@kernel.org
References: <20241203183905.3477210-1-mathieu.desnoyers@efficios.com>
 <cc8e8ed4-0181-492a-aff4-71ce5841c891@intel.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <cc8e8ed4-0181-492a-aff4-71ce5841c891@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e482573-ab53-4b00-ed2a-08dd153d6abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzNZOHdkVWRkSVFaeHZFSWdwNjY0cjE1K2pRbjVCWUdFQXRPY1JZNWFnT1ZV?=
 =?utf-8?B?alV2cE04V0FUcjA4d3p6alVzeXFhUTc1TVo2STVXNnRQNzdnNzlLUnp0YzNW?=
 =?utf-8?B?TldwRHVpbFdhaWlGWFNUNnU1RnZnV0QycGZBdkJ0bCs5bTdjRDlhdU9EZm0z?=
 =?utf-8?B?YzgxRUNFQ1NVb0dhSGo2VWhleG5nS1VqVW44M1EzYlcvNDFmT0ZNOU5RQUNj?=
 =?utf-8?B?a1RzNlVyT003SFcwMmFNd1FEckhDeUluRDhma2Qwc1NXZzU1cnpnbkRvNkxw?=
 =?utf-8?B?Uk91WGZJWDR6RXlLY3FNSGRhMVhxY0F3cWhtME5NeEdQM0NpQ2poT2dHZ2Mz?=
 =?utf-8?B?UFRRbHg0S1NpM2tuakRHNUFxME9xL3BHb003SmZOSE9Dd1lXSWdwQUhqWFBv?=
 =?utf-8?B?Uis1S2NVaEVVb2ZOQlFsSXczWEtJa2FMMjNkUWZLNll4K05YbHJvaklJK21H?=
 =?utf-8?B?UC8vcXBRaWIrNm9aOVhIaFNZc2QxckFuOWNoZ1ZkbGd4WDRvMGJLaFdEK3cx?=
 =?utf-8?B?OGU0VldHelEwZlBXYTVtcW5JN3Z1azFhdGc0M3RvNEJTejRnRWFoUDBHczNS?=
 =?utf-8?B?aHh4eHY4K1dqQVVKY0ZLaGpJM1plL3d1UnlLNkhhVkE5cmRwdWdtcEx0ODlv?=
 =?utf-8?B?MDZDRmMwdHcvSDJCbEQxZ0ExQXlPdzloL1ZkMWMzNzJyaTRUaXFHL1I1Rnly?=
 =?utf-8?B?L0xLbXd1U0RjbElkaVRTN1dyYy9SVTd6ZnFRUU9TTnI2ZjBKcFJxVDJTTWhU?=
 =?utf-8?B?L00zUS9nT2hqUlVFQjQvZnBzOURsUmFEQ0JJYkJIek0xRGl0R1cwUldSeHE3?=
 =?utf-8?B?aGpRVzI0cUlaWWxIVWlQUGU4K3FCY25DRGxHV3Nya3hQbGl0Umx2SW9xSmpM?=
 =?utf-8?B?UW1ZcWdGTHVUcWEyaUVoemlkMTR4S3RYVlM2SzFwcmF5SEJDT1hBS3JIVmNw?=
 =?utf-8?B?R3JSQzNMRTIrYU5GbFgwYm10NWZCODBTcDNtNnE4L05XbEN1aWFZbFpiSTJT?=
 =?utf-8?B?TlNVdklwamlCeW1ta2JFcXlKQ3V1SmF5Y1pCNDljQVZiK2pUR3dBYi9NY3Aw?=
 =?utf-8?B?ekhoL0xpYXlIcXhMcXJvRHUxbExBTWdxM1V5bVdOak5TMXpMTzV3ekhhb3Mv?=
 =?utf-8?B?aE9GZ3diSHhjUkZranYvdTYxaVorMktzbmxiMXBwZ0ovR1J2ODgzYW0zYVBv?=
 =?utf-8?B?TkozOWxYYysxa1JoZGMySXY3eVhqTUgzTFNXY3I3TGw5dm1OYW9wZVN5aEZp?=
 =?utf-8?B?bGZQR1ROZzYyOGZ2bmVZL3lPMFFiUXBxUmU4QkhvRVNLT2syOWEzYUhGenlu?=
 =?utf-8?B?bitLVU1SUnNFYzYxMzBUbGd1aVZvUm0rZzF2VU1KSWlhSEExQUQrS0ZMVWkv?=
 =?utf-8?B?ckIzWXVvMytCWGRkMmVMK0hjekRYam9rOGNFS1hPbVpiUSs3VURxTVY1YlU4?=
 =?utf-8?B?SEFmUnBsSjNHY3ppZGdBclM3dGZXdTRaclFEY2ZWR0loSkpqU29kYld2NmhV?=
 =?utf-8?B?MG5iVHdhUFF1UTF4dEZNY2R0dlVodXpmbnBHYWxzUklsaVlzQUZkM0VoMVIv?=
 =?utf-8?B?UlByRldPVWN3bXd3RTlmcUM2NXpCUnA3UncwLzh1T2V0Qmo1eFJGTHVLOUNk?=
 =?utf-8?B?bGVJLzhFM2RRZUl3UWZFcGo5YUE4Qm1TOFBZVnVkek9penhYNUdUYzRUNU1U?=
 =?utf-8?B?blVxQmtsdG5rZzdxRDExeGNBcFJaNGpXWnErbEdsbGFhcE1FQUtBc1oyaERm?=
 =?utf-8?Q?wXYyDXeUm5qkK/O35A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2JaVUNIUHA3dk1hN3k2emd4eGpHNUkxZUI3T0h3dGdzVXhVY3FZcUFJdG9N?=
 =?utf-8?B?VnY1WkJCblA3NDhlRjhMZGhSSk05NnpZM0EwdU9lRjB4SHhKZTdjbkxabFFy?=
 =?utf-8?B?Vi80ZWdpRmRvTmtQRjJSUU9iVEFncUl5T3hDRENKVUNUakpSZERnOTNEdnNi?=
 =?utf-8?B?NWRuUVh1V3dLbnhTa2w5Q0NtK2ZTeVM1RkYzZGlqcTJjYXhhbGNvSm5JTTBl?=
 =?utf-8?B?OWl5TENyOVZQU2w2RXdYZmNrYldnalk4YkNta2tVTmIwcEdhVVBrSUlRcGcv?=
 =?utf-8?B?Y2JEM0ErVmhQblU1aU96a2hlTjJyV3JhY05BcVFNTzVEYzBvdk4vRDY3TVhF?=
 =?utf-8?B?a0JwcDFvUFRXM1JtZGkvVldXOWVlbGpwa2lXT1lNWWo3SC9QRG5kOGwyQTFr?=
 =?utf-8?B?RVJZbWVYa3gwanRmZG9rTFB0MG8reVFHQVgyczJHNVdBOVU0QTBZM01ncU1v?=
 =?utf-8?B?RlloS2pmcWZyV3g1NFRZY3JiNU9McW5lMnFTaUo4Q3ZRM0xpSjdBRFBYZVJK?=
 =?utf-8?B?NDNhWUdIek9iK2NVY3p5ZFp3cy8xSVAvb1RzQ0RVZngyNldKeW84cXRBL0sz?=
 =?utf-8?B?Z1JMdHlrTVpzZVBuaTYzUEZoOFFMSFVGSjBxc2Y4QUQ4UFZsMVZ1S29ReTJ4?=
 =?utf-8?B?aGRqN0VYZ1d6T3RlakM4ZTF4TmVIQlpBY1FmSEo0VXhSN1RnT3dtYytzbTVl?=
 =?utf-8?B?UTFYMVFWU01JdlZlUE82cTI4cld2ZkxwL0crRmI4R2JRUGVVUDgrNVZOVW1U?=
 =?utf-8?B?aWJhVGZOZHhRZ1gxSFdKWHdNZjJLUkVyQUdZL0VKV1B1YjRLc0ozRENHVFJY?=
 =?utf-8?B?MlpXQjFMUDZEdXZUNmRsdkJYNDVtNGVPYy9oOER4ZkUyL2dUeHhuUXk3aWpS?=
 =?utf-8?B?ZUZVUkZqR2VPY0RkanhWanBxRFQrNDg5WDN1K3hyS2VESXJYcjl4MG5qS3h5?=
 =?utf-8?B?eGlhMjFkK3JEeUZMY3g0YUFUdDJHcU50dTZzakhPOXNObkpvakVGdmRNM2xs?=
 =?utf-8?B?VGtzcmpSYnFDRzl1c0hHSlpSUkpSSjlMTnJLejNsZ0pQWEx5ZTd5dWpnczZv?=
 =?utf-8?B?SkpCWEFDQWErV2QyOUhYMmtoVW5QRGcvdDlyUDkzck84ZDN0S0VjTDdIV3pl?=
 =?utf-8?B?bThWTnFvNFFZQnFmMHg2ZnFQYy9CeXMvR0RSeWxFN2FpcHdrdW5oREZHQ0hD?=
 =?utf-8?B?OW95VmNsaE9NWFhTTTZKcTk0Ti8rV3NCeXNQQThPblBnTENwMk5VZjl3U2pM?=
 =?utf-8?B?N1FGN2QrdVBNcm9VVTBUTzVxTFMxelZXNjVMTWdDWWhrYzdaTUsrQXppZzND?=
 =?utf-8?B?STlYQU1LQWUxU0x6VmJpZ2pjbkFDdzBmamJsOG9hMU4za25IdWtnVUZHaGl2?=
 =?utf-8?B?SG9SRDd4eFYvV1VPWG0yU0JqekhZSEZpS3BaVHU1OEVNVmVCaWhmVjk1SHBK?=
 =?utf-8?B?YTYyVXBMMU1XMDhXSTBESHVNMmhmMXFvZUJtTmVhNTRhZXdCWENwd3p3Tmg0?=
 =?utf-8?B?YjlBRk9naWhYRWpZRG1KVVBmZGdzb2NGRWVibWtTK3EvbFpobmVjTEhYRmZ1?=
 =?utf-8?B?N0o0TGJ5UU5vUGJMNkNqaFUwbVpyZDhwZ3lwdm1xeTMvczR5dmI3TFBMT20r?=
 =?utf-8?B?ZkVnYWVSMTZhYmtYQ3FIU3loOWt4UDBuZ1RqTnhaS25xRjVkeitvcFB0b1c5?=
 =?utf-8?B?VHFUUXcvUTNScTU2T2ZxTzhib1ZqbVpwaTBaekpBNXV1eTdYYVlFenpYakd0?=
 =?utf-8?B?bnV3ZHpHaThQdEp0emFRVC9hWWxHdjZxK0crOG9wZWNKOUpUdjVtL3lhaWQ4?=
 =?utf-8?B?TTBRUzlMVHp0Q3RHR1dJbnF2bDUwNTZ1RUJ6YzZwWTErYWZWZXc4Qk5ZcXZD?=
 =?utf-8?B?SWpJY1FYTDVKM0lvNkVKckpPZDVRRzBHcVRlbitqRi80NTdZbHhEVSsxY1FK?=
 =?utf-8?B?TEZyOGtoMG5WK3JPU3NtekVsU1BUZXdlUVorKzZOdVZQQXZUU2kxK0dibFM5?=
 =?utf-8?B?a0pmazhhaDZXL2hqeWc2bEo2MHl4Q1ZrQ2tDNkZycHVxU3IxRE1NNEtERC9W?=
 =?utf-8?B?Y0hjVHQyYkt2UUk5Slo1WWo1NEY5UmZrYklzYXM5VjZqRytReVliUEErYnNK?=
 =?utf-8?B?N1oyb2tSOHp2VzJkMTZNWitvejEzYis4K1JPWUlLTXdkcHNuZnVGK2piQWZj?=
 =?utf-8?Q?g3N+bburOJGN2PHCaLxqrTA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e482573-ab53-4b00-ed2a-08dd153d6abd
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:59:28.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ez/gdkysApXptG1NuutSYZKpLbNlO80869cN7EzhBLctWdQD4KqdkMoZeHuYotcWqGVOScgO7iPfkQ5t6BQEMQI6N9qvxbKkTdQT6foGKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8205

On 2024-12-03 20:38, Dave Hansen wrote:
> On 12/3/24 10:39, Mathieu Desnoyers wrote:
>> If cond_func() depends on loading shared state updated by other CPU's
>> IPI handlers func(), then triggering execution of remote CPUs IPI before
>> evaluating cond_func() may have unexpected consequences.
> 
> I always thought this was on purpose so cond_func() can be executed in
> parallel with the remote work.
> 
> Could we double-check that this doesn't meaningfully slow down IPIs that
> have longer work to do?

I notice that this question was not answered. I did do extensive
benchmark of this effect, but I would not expect a significant
impact there, because the cond_func() I've seen (there are very
few users) are all really short, and should be much shorter than
doing the IPI, so I expect a negligible performance overhead.

But we'll see if any bot observe something unexpected.

Caller code:

fs/buffer.c
1530:	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);

#define BH_LRU_SIZE     16

bool has_bh_in_lru(int cpu, void *dummy)
{
         struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
         int i;
         
         for (i = 0; i < BH_LRU_SIZE; i++) {
                 if (b->bhs[i])
                         return true;
         }

         return false;
}

arch/x86/mm/tlb.c
932:		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,

^ this is the small function introduced by Rik's patches.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


