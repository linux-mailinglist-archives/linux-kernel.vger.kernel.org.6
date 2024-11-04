Return-Path: <linux-kernel+bounces-395300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0119BBBF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6280DB223BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82931BF7FC;
	Mon,  4 Nov 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LyPi9aov"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864518E29;
	Mon,  4 Nov 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741479; cv=fail; b=Vsm2LAegIvM6ECHLzrYL+oUEs+p4pT4FzNmXDmiEFfHAlg/k2BTQq36Tt57lY9GnjZAOIE46ZU68vXJn8yHlekrZ3kdrj3XilRZgEaEL/sJnUpCIPXxCS1o0T+hdkeZnp6jZURkgL6rVSvcsObGk6jS/GFz4igtTNtyuDJ45DTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741479; c=relaxed/simple;
	bh=vbnJtfDoce37i/sGPUbtjVxsmBw8uxLcOoaA5SHJBIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KGW4kAHpozPocCQTM8y5hzVXmxuqNWVAk01pcgfxg7FmBvE2wZfTjyNNPDhVKuiMKsCtyayl21Kadt4a0gXgNHeX4UmSbtD57bLxJ2W57K5fScSBAMKym2FnJ/89zcC1j0vJwHLRiUnzFV79/bIPEC8zDabc48jvbVsY+8iKXd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LyPi9aov; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8sJVnB9+zpZn5R3iWtV79TZsreh6llIyBYky7utkfeRvJweqUaQUzq2oaHKynRQERvrpn5jusgrQIMVdzx01xHAbI7VsBvrtHvkeO1I+SxEamzBZFdv0EF7V73N7NucJvRnF4+ECDBMAfEEC/Ycw85/cLKDjTga5/hSelwWi7JDWz6IBLK5VJCo45oUIBMBOAzXk9efu5zf6Wgq8G69l72epx4ahnnSlx1ONKN0II6ZWBoWV7vI0c+vcgptM/eswnr/GA5V7CgSYlepeeiiqIWV5NuRQwrY9gUtOCjGPyRqe4Zg6tmxE0+fEBlzdATVYKmu5mRJ8I+H+FmYC+mBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaSjbDfqcw9gHHYvM1luTVVy27OnO1wsda4Kfgzgnd4=;
 b=YtEUJj7c9Y86GDCTfUxmorL+EGuNR531q+fBfQer2PZ0KFYWI3fwLJxMJbDPr1vczTr2Tj5YF/LTzmJo+yInosGiatDeyIFRW/T5ReoS8q0z550E6Kio80GSSh5oC8Kzgt+SVt0rClFbIO9JU8LwTvLcqmOywdO1Fh+43qSPKAA55k9Crvxkh3KxH27dA3wkaneIccWGWWMUrRLGFVrcIrSec0MNzyX46+yA+xKTfoRNdkbk6B8VFfxTCHwi0VD3PsR79UyFrvKSiPezR8+v6oJ7VnSExrjVAxEc+4ribawDeJNZceMQTZ+nPRgrN1HHr2Z014/nYv0SqdxYacwOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaSjbDfqcw9gHHYvM1luTVVy27OnO1wsda4Kfgzgnd4=;
 b=LyPi9aov9yHzAlPZBQ9veGcdaWo/FYx844kFGmLByYXXf7JW++79FhE7Ld+menY/ELx0zvUuH5VjXfN7TZ2zIQid2xfzPULjPdBeUm6lgkA7Fd8ScWI/bwNvHs48Rk2lDOp0TePXl5bLmr/Mw7qvB75a7xyPKrH9i2LTMPXFxvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:31:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8114.031; Mon, 4 Nov 2024
 17:31:14 +0000
Message-ID: <9a536685-d0e8-4c0a-b3d7-b0cdc3553903@amd.com>
Date: Mon, 4 Nov 2024 11:31:10 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com, jpoimboe@kernel.org,
 thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <CALPaoCjLn8CZtPjTtd1ojj3RxNwpmmpUD-bb6nfsXcYTezEceQ@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCjLn8CZtPjTtd1ojj3RxNwpmmpUD-bb6nfsXcYTezEceQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:806:21::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 217dd5ea-211b-44d5-54b2-08dcfcf67b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amtzUVhtQitkY08rcG9rZGI4WkhCT2VoYUNpanFNMXE1YXp3SitXZ01odVBD?=
 =?utf-8?B?SU1ZS3poM3VHQklZTzJndlEyYXgyOTc5d1NLK3dWczdoOXlVSUxPSHcyZUh5?=
 =?utf-8?B?Sno3MTlGUDhKeStHVzVaTXRQdTFIUGN3M3huL2RXS0ZCKzhwM0VySk80NDZZ?=
 =?utf-8?B?SHRFOW14ZmwwWWFZME0zZytzQkYyY0FGVHdqTk9QRXVOQ1ZMRGY4bjVzaHN3?=
 =?utf-8?B?ZTBtLzZmWXdaRXNGVnc0czY4WnJiVTBWb3RZTmRVVFFYSUpSbHArY3hOd2xW?=
 =?utf-8?B?dldOZHBHRUxGODZ6MElwcUVyU1RwR2R1Wi96dlU1TmEvdzBmYXVjVUg5TXl6?=
 =?utf-8?B?Y2RJc3JoMk1NT2theTJwdFM4UDV6UUdBQXJLK25KbHRPYXpQYk9sK2lLZjFC?=
 =?utf-8?B?U2dzSnl5Qk9JVzUxV3FYMU5ocjhlWTJKWDgybTZLTUg0bll5Vnl2aGxiZVEx?=
 =?utf-8?B?bVpxcUYwVnVmZDJJcTRIa01jdlJxbmNpQldoUGlMaTFyeVNrSGhJYUxodC9P?=
 =?utf-8?B?cDd3dWp0cUxGdHRKTE5mVkZDRCthcmJxUXpGKzg5MTFVYmNvWk0ycXdwaWZq?=
 =?utf-8?B?dVQyMXl5bHh0MFUvclJmQ0Y2R1gyQk85cExRSHB0TW5vR1V5MkFqZFc3cktv?=
 =?utf-8?B?dWlyNlFSbVpLSWFWeS9XSmlGeDRyd2dmMzlxWTRjVDIyS3diZ3hhQkhnd0Er?=
 =?utf-8?B?cXVLeTZ2dklHSWdqa2swQW1LanVML0xCQllkYXVQOUZRNURvdGdFUUN0eUNJ?=
 =?utf-8?B?WFRuajJIOVZEWkVIaHNUUndxT2NZNGJyTWFlSHhDeE1JcjlYSWVIci9RMDFB?=
 =?utf-8?B?VFVoanVUZU1UeUwrVzdNSmU1OWloaHpBK1U1YWZ2T0NvU0dma2Nha1hyNFFi?=
 =?utf-8?B?dkFoZE9jSHdkUyt3WEQzSGVFMytwMXZpZFRBY1RWTE9VNFZvdVRxZ3hOaXFE?=
 =?utf-8?B?NEVUOW9HY3ZwR3BDSEZwWUw4Zk9EY3pSQ1RqZlZvMzAwNVNDUlp5aXlBT1Rp?=
 =?utf-8?B?UDBSdnIzOE5WSFJrVUFJK2JtMTdvMzAvQkpNMHZXYm9PU1F0K015TVhDMHZP?=
 =?utf-8?B?YVVRbHh1S0VpYWxqaGhXZ2M1dUZCZURxa2JQY2NqQWYxajZ6VEkvcWpiUVo1?=
 =?utf-8?B?ZFBZY3FKb1BUZVFHSjZwSGVVKzZETkFIU1EvczdBZXZ2U3hiVXcyL053cldo?=
 =?utf-8?B?T21BZUJ3TXNwamZjTVVkRnVaZUFHY2wrTnl5V0JpQjNxWlNWNjVNTFlJaDhu?=
 =?utf-8?B?VUxEYkVkenJiUmVrcVV4ZnlZQ25oS1lWam4xWXhUWlRBMThhSjBHRmtNUnRo?=
 =?utf-8?B?dk0xNVI5dGJ0Q1VrdXg0TnVSRktqYXFSNnZNeHBBazFTSjVtNmVnRXpBR25t?=
 =?utf-8?B?MnNuaE9sWmxobzZqWTRxQlhWVHZjN2dNK1RGVDJnS2J0cmtidzhPc1hKM1Er?=
 =?utf-8?B?eXNLSEN3cW5saDZZZG5hcHFUYVdxd056dFVCTmRkRnlWeFRYT3VFUkVkMlJE?=
 =?utf-8?B?NEQ5M0dNTUY4bllSbDNBYlFhNVFVb1BsSEZBVDZ5YUFNelkwSndUcHhFVHlK?=
 =?utf-8?B?UVhOcW8vK3JuVTBZU25ZdVNmcDR3OVRibXRFREpabS9qZWUyUXNWZytES0RP?=
 =?utf-8?B?dXhhUVFtKzUvVk81NmNFc1F3QUJUYkRIWFBEZ0VsSDk2M0JDalZtRGdZL09G?=
 =?utf-8?B?ZDZPTXJXaGVVcHF6aHZmV0p4QnV4ejlTNFIyckY3enRCVm5iZFcxSVBybi9y?=
 =?utf-8?Q?bLJ8Ohilpm27glLzngYhMNpVFRn/wi+DLfFuELK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFM5YjVxM2xDQU5ZaGtFWlI4bjVhQVhKMElodHIwWHcxKzE4ZXBWR2RCZ1VF?=
 =?utf-8?B?MGJmR1VuMElqd2txdzNpZ3hDYXcyNG5rSGs4bENvRGJZdm1hbjZFZXZkcUNV?=
 =?utf-8?B?TFhUOVpzR01XTHBwVU9NWGl2cmJLV0tOamxaenc1L0c1Q3Y2NWc5VXA5a01J?=
 =?utf-8?B?MVArd3kyUVllbkpwU0xSNGZSL090VC9wc2liNWd6MFFNY3p2eGN0ejVsV3NB?=
 =?utf-8?B?ZldGOGtPVHpybmlrc3MvbHZsQ21oK245aGtRVWVGMXdSTXNiazREcGVYY1NN?=
 =?utf-8?B?K2NRZzcyODlJa1RZNmRsNTRVQllQbjYvbmJUeCtVSDZyT2czczV0SWNXSHh0?=
 =?utf-8?B?RzJZbzlkM0RrS1RGcE1oWHBwSlU3MWhLdDN2TEwzUTUwRkI0OUFMSHlhb21z?=
 =?utf-8?B?SHlMTUxNcWVGZ3VobWZ5YVdQT2t4Qy8zZGZkRjY3YUhOUW5nS1AxWWYwL1Y2?=
 =?utf-8?B?bjhNQVJjTUorRUZ4TUxKdzYyY1FyNjR1MmM1U09mUnB0dHJ4SjRmbmUzM20y?=
 =?utf-8?B?N3pKMGl0TlVjSXNzV1RnckNacnAxajhJVXJrUHhyZzZjLzhteTJ5Q2tCR1R6?=
 =?utf-8?B?K1cybjUvNEF1SlpkNldLVkNvamtHaTRXQWJ3em51WndJT1RoVTZjYk1PS1h5?=
 =?utf-8?B?SXZ3SW05eThkZnZnbmdkbWp6cjdFdDBRczh3d0FRMi9UWnZnOWpnRVpKVmZW?=
 =?utf-8?B?dU4xc3pCSTY5K3lQZmVhaUtXZ3l0UENoRDVyUFhMNytwSVdvSmV6WnhUb3JS?=
 =?utf-8?B?Z0djWnY1aUt3d09Dd3RUeHpZVWFQS3I2dTdpVkZjcGJzZUxpOS9HWXdSN0F0?=
 =?utf-8?B?UllzUUV3R2wzNXZDcFZNSHk1ZnZRa2dRb0ExMWpVZDJyRFhadjhZT04vUHR3?=
 =?utf-8?B?UFZ1akxFTEJjTmI5NTBMczc2NmRkVzlMRit2R1hnRms0c2o3dThEaFM5dmgx?=
 =?utf-8?B?SlF0azBYNW1oeVhBQkNFTUVjeFczWkxQWkV1R2djK2R1MHlGMkJLWXlnS2w4?=
 =?utf-8?B?VXE2TTFDT3VtZk1oZHYydUQ3VitlQ0ZRSEZVSktreUg1aVdraXZnc09DbzJn?=
 =?utf-8?B?b0tZYmhNNDduaEpOalcxVHdCZW41RFhWRGV3L0dsSFhFOHVEcStMbFdNUmE1?=
 =?utf-8?B?Ymt6QnVyUWdKckEzTWZOYjNNNUxValpLVWVsTmpzV010UXBIakY0RzFXSUFz?=
 =?utf-8?B?aFVzM2dWcVUvZTBHUmJtakI1Q2p2V0tjSDFPUVdpRDQ5aGl3NlRXRmt1ekNZ?=
 =?utf-8?B?UVB2UXdaV0REb3dKSkEyT3hYQUF6azJ5N0JLenovcGFZTnY0bGRaV3dTSjgw?=
 =?utf-8?B?N0dBdUVPRGdUd3dlVjhLRlJKV3hXWVM3a2xNZjNRWUJLbHMvcHd5eUZJVDdB?=
 =?utf-8?B?ZnRyb2Y0RDdqNzMvTXVxQXZHcDlQQVRNdThSS3F3SEljM0JoYmR1SEx0SWYy?=
 =?utf-8?B?VXFwR1ZUbWtqZDJvV2tMUjBNQitheHpldGpJUmU3SVVzekY0UThSY2RVaGEw?=
 =?utf-8?B?d0Q1Nm45VUxVc3Vramp5dG9OcjN4dTdESURCQ00wOElNMzdZMWdHRCtjK0ti?=
 =?utf-8?B?WVJ4NmJTYVFRQm5WWUR3dGNVMkNtbkhpZE9ha2NSdHVEUlphckF2enRsOWJo?=
 =?utf-8?B?WVYyYjYvR0N0eVlacnlPZFI2dDA3YU5DMUFXVnk5dzZROGo2RUtobUZZUk8r?=
 =?utf-8?B?Ri90cEFKeTd0N0JkaDBTRTJJTTl0QWlJQ1JxTkJPdklwMFBVNE9CeVk5Nzdo?=
 =?utf-8?B?VXJ1TGFnQzdEUjhUUDkrM2RSc3dhQ2ovdmRBQnpxSVlxUU9wVDNsdjlJSm9D?=
 =?utf-8?B?cjQwVTRuNm5GdGRKMkM4dDBWZ1dDbGRtR1hvSzdVMTV3M2ZERGNkVk9vMU1l?=
 =?utf-8?B?ak5jRWN1RXA1THJVZm1QOWN1eGpxTW13QzdSL0Y3TE00REFxRXAvdXZJTkE0?=
 =?utf-8?B?RkNTb2JNZzhmSDRsWFBsRWVQNGZ5Smg5ekpLb0pyVTlGVHl2Sld5NEpwNlJ1?=
 =?utf-8?B?UUZTVzhocWQwL0RVYUtNUTJuOGo0dFJwaWJCT25GemRrb1dMRUZxaXVpYW5s?=
 =?utf-8?B?WGZxYldieUpDUmVqZDBLcEg2VlVjdGUvUFpZUjFlVzhMZmNrbFVsem53cmM2?=
 =?utf-8?Q?O6Og=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217dd5ea-211b-44d5-54b2-08dcfcf67b44
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:31:14.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Niz8U6rqPU7oqyy6Td1+dd4YqhYEbHbbFzxLcp6N+IYrKLpH1mU+miTiPQ+OOY3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976

Hi Peter,

On 11/4/24 08:14, Peter Newman wrote:
> Hi Babu,
> 
> On Wed, Oct 30, 2024 at 12:24 AM Babu Moger <babu.moger@amd.com> wrote:
>>
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
>>         memory bandwidth tracking to a single memory bandwidth event per
>>         monitoring group.
>>
>> +"available_mbm_cntrs":
>> +       The number of free monitoring counters available assignment in each domain
>> +       when the architecture supports mbm_cntr_assign mode.
> 
> It seems you need to clarify that counters are only available to a
> domain when they're available in all domains:

Yes. Makes sense.

> 
> resctrl# for i in `seq 100`; do
>> mkdir mon_groups/m${i}
>> done
> resctrl# cat info/L3_MON/available_mbm_cntrs
> 0=0;1=0;2=0;3=0;4=0;5=0;6=0;7=0;8=0;9=0;10=0;11=0;12=0;16=0;17=0;18=0;19=0;20=0;21=0;22=0;23=0;24=0;25=0;26=0;27=0;28=0
> 
> resctrl# cd info/L3_MON/
> L3_MON# echo '/m1/0=_' > mbm_assign_control
> L3_MON# cat available_mbm_cntrs
> 0=2;1=0;2=0;3=0;4=0;5=0;6=0;7=0;8=0;9=0;10=0;11=0;12=0;16=0;17=0;18=0;19=0;20=0;21=0;22=0;23=0;24=0;25=0;26=0;27=0;28=0
> L3_MON# echo '/m16/0+t' > mbm_assign_control
> -bash: echo: write error: Invalid argument
> L3_MON# cat ../last_cmd_status
> Out of MBM assignable counters
> Assign operation '+t' failed on the group /m16/
> 
> L3_MON# rmdir ../../mon_groups/m1
> L3_MON# cat available_mbm_cntrs
> 0=2;1=2;2=2;3=2;4=2;5=2;6=2;7=2;8=2;9=2;10=2;11=2;12=2;16=2;17=2;18=2;19=2;20=2;21=2;22=2;23=2;24=2;25=2;26=2;27=2;28=2
> L3_MON# echo '/m16/0+t' > mbm_assign_control
> L3_MON#
> 

Test case looks good to me. Thanks for trying out.

-- 
Thanks
Babu Moger

