Return-Path: <linux-kernel+bounces-244086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E0A929EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0CDB23BA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC74558B7;
	Mon,  8 Jul 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dP6oIHKP"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2050.outbound.protection.outlook.com [40.107.117.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A363D0AD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430667; cv=fail; b=HcKN0n/Z8TN4Epp2wazJ6BggHPeXjH3QQV5yTRhcPlat4QLROjPF4R4I05DOO5ZhyJbevdNUD4AasdgmBTAbbe08X1QLn7CeQeYumcEoi1T/rkz5iUoyirj6TX7Ocig8S9tatA89OM+vtAdaYOiH6QhV/nzeztEk522X6BpvHmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430667; c=relaxed/simple;
	bh=aizNVzdvLOjiU7T8/eMgK1merkNAbujEJT+5VVtATz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bFLvIT/i4/U5Dr3fsxGY0iix1hy5TulhAzevuI2UFRT4Cvb/eRU98pDTm2NAaBI2yOWyPlSY7QXF0e4BLlJJYDJiTWE0NVTwOCAEIBcBEGOiKav+nunMglxdTZCNDcGsiBhdC4qBh7lhPFOvJDZhYNjOXtfo+sfmEDVq4W70sDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dP6oIHKP; arc=fail smtp.client-ip=40.107.117.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW8k7ag5YByIBwoTT6sTK2Ql4IrnPe2NGIUWH9arx4khzv8wBaxBXlEKLWxiWIUKoT5vcst+Z04sbBu1UP5cASoX6Ga3rVEwYrZEtxco5WPvtiDq7CG1Ry43dfB0hinYFWojJfMPgYyrnhwfossYntFS0M0Ac3g5sQiBRRbry9NTWcOlPq46+Zkz6pExjYPt8G+Uils2Virgx0qGwinhw0V4nJrq78B9IzoC2xCvDzkS8au/0FQL0UPwht/JJabcIG4UzJn5NcyZMOTi5Ta9YZXXkrqBEsgpq62tcnvufjxsXvOus7yqa6ZE8spsZBQsN7nrwvj7+njTNHTwPj7DyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUTOTHvoeiYggfJfozPnTmDuaLy0h2zb1uJtJZhquTM=;
 b=DJm7GEXgzXIEshGiE7jbh5lRtpr7IdcQCRH5Y7aXldk+ZtI814NXOD9gyRnFkazXH1d/gWCgHbqucVBNHQQ+1rcO/ES4HbsaBEGSbXtEnFPTg2hrsgVYxfIb4NujFIbWqTFc7iu5LpOfJZsKFK/vsPX8iScePVm/MvXJKpRVeU6HZXC7jyIN27WYqUSeNyyHCVzs55DCpENWLRpcahfipX+CrFyvLCFHtnI64nDdw/jY0Ary0KqAv0SDgvoIL2m+ONEzqJg7FwUNfWdxR87nUiroRxaUDjNJbAOZIESxLqfPCxT4MFqpvymbp7HfW9xlokC82vAGW54TzE8XIWmvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUTOTHvoeiYggfJfozPnTmDuaLy0h2zb1uJtJZhquTM=;
 b=dP6oIHKPavRClevGpTePisuyfnu/iQvd5zvnGVAU1B/QP9TLNA0CiL7SFvDKqrbhYBsoRxBrbMof+p0IC1lZk0b1AUUkQrVoF4pCyVgYS4BvMPL6C6slMgGb9o8tqhdCO/IMNUvdVCWtUuank9PeBOaRyZcKR/z2vYihUxqCEcrigQnDZPeaW7OrOeRaa0yynLk1q0cuq1Nbs2Xl23mgmTjUQFvBoUI7LbrUwtdTV8rjaWU93Rfwp3vcSqm7Mghv6IXT2V/jxQc3traSdMhsgaGgHu2LyLwbDZi8gMKbbLCIwX3fDDqMwfL/BLvDc7JCSdWDYNpSJ86BcGRo1oogsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Mon, 8 Jul
 2024 09:24:21 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:24:21 +0000
Message-ID: <00965028-b754-4959-b711-58ccb2e5e940@vivo.com>
Date: Mon, 8 Jul 2024 17:24:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shrink skip folio mapped by an exiting task
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240221114904.1849-1-justinjiang@vivo.com>
 <CAGsJ_4ytMMbPo4EuNSQ-A75T+5h3O+nM127xcMg+QpKjf5D8Sg@mail.gmail.com>
 <7964fa25-0ba6-43b5-b215-4e381a355a08@vivo.com>
 <CAGsJ_4wik+oagod+WKJviavabqKQTDDWxPxUQJ1kS1JSPpA2Qw@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4wik+oagod+WKJviavabqKQTDDWxPxUQJ1kS1JSPpA2Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 43df2da6-8c43-4415-cf96-08dc9f2fbfd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S09HU0tSWWxkNmM5NWFTdVhwZkVlVDY5NVZSVSs0UE5UNmZOWEwrZFlGSHRE?=
 =?utf-8?B?QVhJU3MwR1U2OFlvNzZ0dGhDekNHbkhxUUl2a09xODVGZkQwdlBiZ3FIbXIr?=
 =?utf-8?B?NXU0WkRSdDVDWGRRMVVJZjg3RWhQbHc0UHdqV0dLdDN4eVpYUHhSejJIMC9H?=
 =?utf-8?B?Z2xUR3JJa01MN2RiQVBxOFI1a3VXb293d0djNk1HZndjZXE3dG01dU02MkJO?=
 =?utf-8?B?TklUR3FaMEhHdzBOdlZuUDR3cUhKSEl6RGxCNVhTbHovcHI3c0RSd2JVejJG?=
 =?utf-8?B?b1p0SjhVcEthRm8rMkZTVWg0NjNjOUdlRERMRGdkT0xNTldPNWxkVVpMMWRk?=
 =?utf-8?B?SjN5a0FMaDFBVVJYdGdabHd3RG5XNGVTcWN3bU9ibnd1MXBrM2tUK01na2xL?=
 =?utf-8?B?SEJ0NUMyOHJaZUIwTWtiZDFzRU9zK0FCVGFCaEMrY2tQaU5vRjc2TFRsek1L?=
 =?utf-8?B?eTlRVkdYRVhkRWJFaXE0NG11clFSU3ArS0NVOS9XbDFNNktXZlBFVFRuNWdJ?=
 =?utf-8?B?bW5jVFM0WnVCMDh2RytGcjZWYlI3MjN0RSszaHZ5NmJyOHY4N1BIaUFkZmgw?=
 =?utf-8?B?aW96dktHOWRSczRhUHNZT2NXZUs4eFZ0ZDlFZS9oWGplNm5DVFVYemRraDZt?=
 =?utf-8?B?NjhBOEIxdzk4QzdnUCs0RWI0eEMrNS9PZHVwdmNWeWdXczVTbk9TVHFoTnpI?=
 =?utf-8?B?QjhYSTJOSm5SR2duTEQvdEV5dVRTbVhlVlordy9neGhHeGpTbFZ0VFE5cWF1?=
 =?utf-8?B?YTdaV2NmOVd1bzc0Y1U0S1UzaURkeWNjZmNFQWs5ZlpoV2YzZ2dZa2d3YmZ6?=
 =?utf-8?B?NVlXdVhjemFTWVNhU2dxWUxxYXR2VUZEaSs2Z21JZG1kRGI5Sk9heU81K1FQ?=
 =?utf-8?B?RWxNZ1FqNHkzTjgwWktibzhyY05mQm5nTUJESEFoRExGMjJmam5JVDlYeGNP?=
 =?utf-8?B?MldoSWlyalpLMitEbUVrRGFPQ0krS004L1drSXg4ZFg4T2lUdE1HOG9vZzhZ?=
 =?utf-8?B?NjJ3VXMvNkdXa00yRER2bk9OeFVHSUw1Y0Y1QU1hQXBwWlQzSFFMU3FOYlc3?=
 =?utf-8?B?MzVaTGlXQytwcVRoL0FyN0Y0VzFxdlBLNjFYTldNSUV6KzR4VitkSUU3NFZL?=
 =?utf-8?B?ck1veWE4NmRyaXUvbkgwTWxPS1VpVm1DVkxTWGUzMUR1MXNKZWNEams4c0FX?=
 =?utf-8?B?Z21GSTlibjBNdnNLZ0NQTkhEU0cvbm52azZjVy9SYlpsOHM3VDBROHBiQ2hN?=
 =?utf-8?B?d2w1dlpDM2srWWFsSXNiYjM4NzhCUzg1S2NtV1NqLzJtTHhQWXRjVThkK0g4?=
 =?utf-8?B?ZkdhTXZMTnErZjdYL2RpVmRoVXczVUgxbmpTNXJ2WWRtOU1CblpBS1ladWxL?=
 =?utf-8?B?bXIwNG5aYzQ1aEMzT1k3MEZyZnJSN3NVekJNSXk1R2UwWEpwajFFWUhNaDBJ?=
 =?utf-8?B?U294Q2MwL2x0a0tjYUdPQWtENmZMbUFuWFBuN0R3azVEWDVBT1dEY0R0dXIw?=
 =?utf-8?B?bjNJbi9xSm5GL28vTG9xSDJVcWtmNWY2WnYrNldBME9QbTJiZ3kySUI0ZUcv?=
 =?utf-8?B?T3ZJM1pKV2hDd2Vvcjk3QXNPdVNPUjQ2cE52OFkydFpTQUk5NVQwMXppKzY3?=
 =?utf-8?B?QjV3RVdzWWdUbjBBUk1xWTBvb1dtdWlpMEUyR3JBcFh1bUZWNUlrTVA3Yy9i?=
 =?utf-8?B?OXdQRkxpSmZKT1RNTTJXUGdpYWMrbjZmNDFiLzczRU5NcTdRelI5cCtHZ01m?=
 =?utf-8?B?dkhSVmp3dGdvbWpRRGFpYS9QV1FTS1U5VWNEbGRCS1JTbjAreldIZXUvUHB3?=
 =?utf-8?B?ME9KeDc5eS9leXE1cXJLMS9pN1NNRzd3THhuc0tRYTdBU0NwSllSSmRLSndC?=
 =?utf-8?Q?yDeA7l8wVk7cG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUJSR1BSNUhuZEpyeHdUeVBKWUI2UU1qeFA1TW1SbWhBM01GYWR0MkFFbThY?=
 =?utf-8?B?cVVMQzBRRzR3RDMyNmR3aGk1UDYyR2NRMkU5VFNjWkRKSUVNbG96YnBMSUhL?=
 =?utf-8?B?VnZBdHFuSXdVSWpzUEFoM3VKRU5WbWZDeGtMQzMrS2dYUlJKaEVzd0pMemQz?=
 =?utf-8?B?T1kwVndiOE5OUENHY2ZnTlZBd20zZDFiWWxFemk4TnJmMU1FekdCeVI1MUp2?=
 =?utf-8?B?b0ZLQ2FlUXk1Uno0QXJtRnBXRkxCSFkzd3BybU4wSzYxaCtKMU5IeCtYVXBS?=
 =?utf-8?B?dk5DbHlRU1d2S3piSVRLdmdIZEMvU0lLNUlJMmVGRWNlbkxoZ0YwUU8wVHVs?=
 =?utf-8?B?MUtyRjhHTDUvVTFTcnFKOXZBRUVKa3pkd0VwcU5oT2EwRy9VeWxRUE9lNnND?=
 =?utf-8?B?Vjhtd1FLak9IS0o3R3FoUDNQS2RvS2kxeGZiTW1UTkloSElhM3ZJbHBVSmhM?=
 =?utf-8?B?bmdrdnJ3M3hxeTZvS211ZVFHczdlODQ0aExMNkJQbGtQWEw0bS9aQ1o2L0kw?=
 =?utf-8?B?bzVnNlNLUVpsZFg0TmNnSTBQeGpmcnNScnc3Y2lnV2hIbG5RVWIycFN2SUJz?=
 =?utf-8?B?bDRpb1c1VW1TamlCNTZUYllZcGhBcWF6SUJqYm1NOThEWTJHT0xhTW8rZnFn?=
 =?utf-8?B?YXFJSmRKZkZwUkplQStBMkE2WElPbkkxaTQwckNVQklsK1JqWDdZQXdaQ0hl?=
 =?utf-8?B?N3AyVmg4bUtqMHlxNHVMSlgra0Nnb2xyY1kzK1l1RU0rTWFUYVJZUzdzV0Qy?=
 =?utf-8?B?MWx1eUpNUVVYcW4wSHNCZ2s1ejc3cDZZSmVXQ3VReW5pWml2ckViczg3bUQz?=
 =?utf-8?B?UFp5ZXd4OHNTRVhSOEMreHV2TFIxcnRCb1dWTnROQThMQ2ZDZGc1TlE1ZUM1?=
 =?utf-8?B?WkNhTlhLV01HcU1MeklMZDRHNjNwUEp5MnR2MWJvR3Z6aE54ZEpRdXNLeGM0?=
 =?utf-8?B?ejZObERtNmZJOUdyL25XWStLTWQ4Q3Q4YlF2MFBsUlhZREZ5dDJEcU80cVJj?=
 =?utf-8?B?akJMb1RIS1hjQWNBOUtPdHNxQ3RSaWZON2xBNDVPUlZTTk94eFBXTzl4TC9p?=
 =?utf-8?B?UU00WTFPNmdYalJsSkpVZDdKUE9IWW5mcUtvZlhncUFwWjRuOGxPUGZaWWE0?=
 =?utf-8?B?aTBQYXZPem9oc2xYNU4xQmpBNTdKajRhWGwwQmhzY1lGcy9qb1lsSnVvRXpz?=
 =?utf-8?B?dHhROURUK2dPK3ZrTUhwazdCUHJkMXlrL3VqcklRdURKV3JFcmwyVXN0d2JE?=
 =?utf-8?B?YkZDK0ZnZzVoWjdxVlVCeXl3dUU3RWFhUVF1QUptYlRqbjd4THoyVWdvTVBC?=
 =?utf-8?B?ZFVrd2tHTm4xRHZxUUkySDZLb3lNa2ZYaFJFQWt2bzZYaGdMZGI2dEphV1dr?=
 =?utf-8?B?U1o1a2Z6VWJaZkhSVkdSSmp2MmFnTDZhVm5hVTdGT1E2alJ3cXI1ZVhhakll?=
 =?utf-8?B?eUFmRjBvdkdtMEdXNGpuWm5TdzhHam0rR3pHOXpwS0tSQlJUWVJ6OFVibXMy?=
 =?utf-8?B?SjZNNU5CZkZMWFZ1bC9neEdjOGpJRy8ya3ZERkNuL3J4aDdmdmZxQjM5bHNU?=
 =?utf-8?B?TUIzSUpkVng5enc2bWh5cm1CRGd6MEZRays3eVVRTkJwbEs1TU8yNUFLNnhO?=
 =?utf-8?B?YzgwNEQ0WmZHYzRWUmRrQnd2KzF6bEdjcW1LU2NzSDNuZjQwVzN6YkJwZS9l?=
 =?utf-8?B?d2NUS1hxT0NuV1BYYUlSQS9OemRSSHlQOUZNck5aQ1NZZWhnS2Jtd3dHSHJi?=
 =?utf-8?B?dE5sckpVUVJ6dVRUWFVPY3NZN2tPU1gxRE5oakJQaVlmQ3RGZHBHSGoxRFBY?=
 =?utf-8?B?TEJOZmh2bTliV0NTRmRVV250ODZlUzNjV3pOUjhYTThPcTFPcUduY3NZUzZK?=
 =?utf-8?B?bCtTVE55OG9OSm1EN2EwTndVTFhpZ0MzMTVBSkNyUG9VSkRlcTI5RkZSd0lX?=
 =?utf-8?B?OUZNeGRHRTVRNDE4YkQzY0lWN3VhU0ordDRnSk9BK3JIWXFPSUF0Qmw2eHVI?=
 =?utf-8?B?ZjRMVmpia3pzY2xaTkJGaytOQ0tZc0Z1ZlRvNGdnSFFUU0VRMjdmWXgvR2tZ?=
 =?utf-8?B?RUphMU9oZHdENkp1clVjRzdnalY4QU5VWGF4azY2OU9OMG1OM1NnY1RKSUhP?=
 =?utf-8?Q?uERZUfJW0a1W5sTyn0DkBgtA9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43df2da6-8c43-4415-cf96-08dc9f2fbfd6
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:24:21.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjuGrXdPAZ3VZv0pfUQVW5uPhJ7Iys7kJpbsUNACOs300HLHYeJkUMNJfbp4H3UAN+lmntpHU+Frclo3grd1gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253



在 2024/7/8 11:54, Barry Song 写道:
> [Some people who received this message don't often get email from baohua@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Mon, Jul 8, 2024 at 3:40 PM zhiguojiang <justinjiang@vivo.com> wrote:
>>
>>
>> 在 2024/6/30 17:35, Barry Song 写道:
>>> [Some people who received this message don't often get email from baohua@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Thu, Feb 22, 2024 at 12:49 AM Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>> This is clearly version 3, as you previously sent version 2, correct?
>> Hi Barry,
>>
>> Yes, patchs are as follows:
>> v3:
>> https://lore.kernel.org/linux-mm/20240221114904.1849-1-justinjiang@vivo.com/
>> v2:
>> https://lore.kernel.org/linux-mm/20240202012251.1aa5afbfdf2f8b3a862bced3@linux-foundation.org/
>> v1:
>> https://lore.kernel.org/linux-mm/20240124124308.461-1-justinjiang@vivo.com/
>>>> If an anon folio reclaimed by shrink_inactive_list is mapped by an
>>>> exiting task, this anon folio will be firstly swaped-out into
>>>> swapspace in shrink flow and then this swap folio is freed in task
>>>> exit flow. But if this folio mapped by an exiting task can skip
>>>> shrink and be freed directly in task exiting flow, which will save
>>>> swap-out time and alleviate the load of the tasks exiting process.
>>>> The file folio is also similar.
>>>>
>>> Could you please describe the specific impact on users, including user
>>> experience and power consumption? How serious is this problem?
>> 1.At present, I do not have a suitable method to accurately measure the
>> optimization benefit datas of this modifications, but I believe it
>> theoretically
>> has some benefits.
>> 2.Launching large memory app (for example, starting the camera) in multiple
>> backend scenes may result in the high cpu load of exiting processes.
>>>> And when system is low memory, it more likely to occur, because more
>>>> backend applidatuions will be killed.
>>> Applications?
>> Yes.
>>>> This patch can alleviate the load of the tasks exiting process.
>>> I'm not completely convinced this patch is correct, but it appears to be
>>> heading in the right direction. Therefore, I expect to see new versions
>>> rather than it being dead.
>>>
>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>> ---
>>>>    mm/rmap.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>    mode change 100644 => 100755 mm/rmap.c
>>> You changed the file mode to 755, which is incorrect.
>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 3746a5531018..146e5f4ec069
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -840,6 +840,13 @@ static bool folio_referenced_one(struct folio *folio,
>>>>           int referenced = 0;
>>>>           unsigned long start = address, ptes = 0;
>>>>
>>>> +       /* Skip this folio if it's mapped by an exiting task */
>>>> +       if (unlikely(!atomic_read(&vma->vm_mm->mm_users)) ||
>>>> +               unlikely(test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags))) {
>>>> +               pra->referenced = -1;
>>> Why use -1? Is this meant to simulate lock contention to keep the folio without
>>> activating it?
>>>
>>>           /* rmap lock contention: rotate */
>>>           if (referenced_ptes == -1)
>>>                   return FOLIOREF_KEEP;
>>>
>>> Please do have some comments to explain why.
>>>
>>> I'm not convinced this change is appropriate for shared folios. It seems
>>> more suitable for exclusive folios used solely by the exiting process.
>> 1.The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacase
>> the folios will be freed soon in the exiting process flow.
> This requires an explicit comment in the code. The expression
> referenced_ptes == -1
> implies "rmap lock contention: rotate", but it appears that this is
> not the case here. You
> should either update the original comment to reflect the current logic
> or use a different
> value.
Ok, this has been updated in patch v5.
https://lore.kernel.org/linux-mm/20240708090413.888-1-justinjiang@vivo.com/
Thanks
>
>> 2.Yes, the shared folios can not be simply skipped. I have made relevant
>> modifications in patch v4 and please help to further review.
>> https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.com/
>>
>> Thanks
>> Zhiguo
>>>
>>>> +               return false;
>>>> +       }
>>>> +
>>>>           while (page_vma_mapped_walk(&pvmw)) {
>>>>                   address = pvmw.address;
>>>>
>>>> --
>>>> 2.39.0
>>>>
>>> Thanks
>>> Barry


