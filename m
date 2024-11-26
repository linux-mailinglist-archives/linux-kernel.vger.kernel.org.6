Return-Path: <linux-kernel+bounces-422898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1619D9FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E17165D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491731DF992;
	Tue, 26 Nov 2024 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HwP5N152"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4380817591;
	Tue, 26 Nov 2024 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732663896; cv=fail; b=Y2KtNAH616AkK2uoq25im+BTqLLg4PanbLq4scDsxam+7vOxrFENOkwEnFMYuVB03Z0tg//61Jsp8sFr4k29RRlCS5NljrpiChMFtoUmV8V9AQ2TP9JNqtToELaV3grBBXxDjXo7GZDB7O91xn4SSVyu2wt34vTo2wcWeK69zk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732663896; c=relaxed/simple;
	bh=F1rPV6YyY0l/eorS1rKiQWBJZLHNKeiyHIlPaY+8J7M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=stWSoRgpbzcXp31OU0xIql+tq5PMdVVRUmWeEK6dkKHQ47b1sHANeOmjMncy8UYnb6NXdD6Skuy8H3SS34ZKA9233g2+IPEHU+oigBAWprSZ1TYhm2qpIva1Za3xutBmjKWa8d0JEidM2SoRArKLpgS8+NUnipUOFb7OCh5TO8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HwP5N152; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSUMJMQuwlVzsiif+WBOPhy0uiIVQ6U5su7pq1oamXikqXDOUJh9ejVMdGzFmYudn53cCbPJjKTT6mht7nKPy7NrX+qWuiNnqdVQaVMcVsiNsQtD6RIlYgh7q8zTspz4linI3zipT3+WTkRb861UrHj30rEy7bIX/2qYuaylk6F+ApTlb45SGn/BPsGD5srx2JqH67PiPeWliae5Qg/HIZVErr168tQu6JxGuWlgr74kc1Oqd3xBmS1qtgZB7APEdunm9A7rIsKEFsgtfzqggDJXWWgKwq5z4tFmIlTBh0iriOtXQBkl3BiWtaZiWJUm6ZAVxzJ6P/2fI82rVNgMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h63KJZAJCZZZ1NG9ekzYHO2AvSFQGy5m4cG5jUoVDTM=;
 b=yH7Sac7vfUE3gB2NfEIPDuVsSwQV+DMaIbjtmT/QwpCTzJl8q78tlBWhCjZcl7tXQzIA48pBN8PmFF4dB0zChFiaDjPV3LI851OdEEq2jh2RbbAqfV8osAWHE7WCrz/ZEcu38DhqwEJOjdPMTWMVkema3WZt49nRRlPCd+JhbHz9Y4hXJi6kGJuZDAEKQ+eZUrKn4E/W9zbnnAieHYQpfu/lp5Yfgzx4nN2yGWNvlW7ntntVX1vypcqZiHBLbVYDwHIAeVrv44yqvgiL6xNNUANGmyxyVTBVaPSQ6lPSbKdjETXgI5BZfTcj6KJY2SgzCm8x0YZc5IWLD60YsBDR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h63KJZAJCZZZ1NG9ekzYHO2AvSFQGy5m4cG5jUoVDTM=;
 b=HwP5N152s2jTtz6cBEUK1SKKaXgopKONLFsen7jo1nDqJhx8nGJdVek72xpwRryqZi9fy+kUD6alD6nDpCr6dD3/PDN5RzGPDL08dTqEBwOyB7/v7FTtVIWeq+B4jUKruVdwrpTEHPXEW6B4fQU5kuYgrKpIlwViB3bDHc0mMJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 23:31:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 23:31:27 +0000
Message-ID: <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
Date: Tue, 26 Nov 2024 17:31:19 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::44) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a21fb8f-b677-4203-d486-08dd0e7272f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC84RldROHdEUk9Ldy9GK3BDN2lWU3FMNzRERGdlaTBOa2lmdG9JOW9Oam9U?=
 =?utf-8?B?WkRmeC84RmlHdUw1Uk9Fb013czJFQ1lCYW9sc0pKeFVySVZyUWNsb2hVYWJL?=
 =?utf-8?B?Z2h4YUliR3NUOXNwTWkwT3VJTWlPSWE0ZUdGTDJsUTdNVlRVRi9XT081Y0Na?=
 =?utf-8?B?Um5FZmpzTnR3dkF3enYvWmVyZmc2Z2NiTkp1YnU0QlByWS9MNkFXYVh3NXVk?=
 =?utf-8?B?ZnlqVXBFOUw3OXY2VE14c0xhTmRmT3FCcm9aYlZGdXJOVUVDdzRKK3hvWWdM?=
 =?utf-8?B?R2w2SzBDTmxDdE5ZYjhCamJEd1YwRTMyNUVVSGlYRFR1L0RpZ1NGbWl2VWZL?=
 =?utf-8?B?UGl4LzQxWkJvY1U4bWh3ejFxZzBXV0I5NWRoMURXZTJpMEJEeHpmQ1RtMFRP?=
 =?utf-8?B?emlZcmhzR091NHdiTDNTMEFFdzViSmRiK2tyVnhCMmRxeHYrN2hCakFBUFgy?=
 =?utf-8?B?aEcrQlZTQ3diNE1rSUlYTnh5VW9Mb2ZwbHNMU1k3L0hnWEd5aWk5UCtsZlpL?=
 =?utf-8?B?TklsWEtKbEpDdm1tTVZSQ201YWxyQ1RDaUwwaStDc3ZkMjBwY3YwTDk5Vzho?=
 =?utf-8?B?elI4cW9EWXUwZmh5bFl0SUQvWDJKV2ZyLyt5RnRvQ2Zvd1dLbk5aSUxHUFRX?=
 =?utf-8?B?K2lMMTZsTEJDaEdOVXZUR2NYTW1HS29OS0JvVTJ2NTVKMElZVHpPd1MrMTJK?=
 =?utf-8?B?V1AycXI2T01WMlhjSzlCdmlHaWZtUExsNnJrc2hzeEhlSzBSbHgxaTNmS0NS?=
 =?utf-8?B?MVVYZnZKUm5uQU9wNkV2OXZxd1A5eHB3QlYvRGRzdEUrbUREbkVIRzN6dW9m?=
 =?utf-8?B?dlEwMWxMZnhETW0yamk0VnVzU2czeGNwVWxpZktTdm84WCtUbVQ3ZHN0MUZv?=
 =?utf-8?B?RmUrOURVZmM2eWUxNU8rZWFQa1VPRDc0eEhzRkxjNW5PMGViWVFicDUzalFz?=
 =?utf-8?B?b0V3RFJVTHRxRUFqRm1jYXl4M2wwMDNpTk5NQVpSbm83YTJOdG1JM08va0xt?=
 =?utf-8?B?SHBSV2R5a0dHKzNDUmxqTHlEc1E0QU1nWGs1cGRKcXFhekhvMXhja2ZJUXNF?=
 =?utf-8?B?VWxzb1IyRk9Rd1JUQ296RnoxakVXOFY2Mk1vQ3R6SUp4OURsRVVBRFVZaUt1?=
 =?utf-8?B?R29rdEpBUkJHN0RUL2FWVjJCaG1VKzdoTUJRcklBSVhBSlh6S09EaE11WlRt?=
 =?utf-8?B?am9GT2JINnQ2TnUwOHViVG4yS1pXczRRTmUydlk3eGZ3cmowTm1kdkI2cjVx?=
 =?utf-8?B?QkgwaWpyR3dxbkVWL2t2L0hnaEh3YWtUcUlSdEd5cHZNNTFtdjZ2T2hBc256?=
 =?utf-8?B?U3l1Uis4eEhzdHFtM3RZdTBnK0l5QXE0NFFkYVlyN0lDenVmZUpxMlhNbVZu?=
 =?utf-8?B?d2pMblhWWkxraEp2NXNJdGZvblVZYUZGYXcxV3lrSlNkQnY0Rms2bFJJVzUw?=
 =?utf-8?B?eXRiRU1uMXJNZ2hEY1pybE1SdGVUREQ3cUR6eWhsOXFDWUlwUEw0Q3MzVVhy?=
 =?utf-8?B?alZsWGFpUUV6WThHVmNjMGVkMEVWWkJSVDZLL2JpL2UweEVzUmMyVUhUdk1B?=
 =?utf-8?B?ZWg2RFAxeDZCSmRqSE9jWGZnY0pIOEVGaTlOdGhmYlVEdExtV3lBTHZLbWVQ?=
 =?utf-8?B?amdnUXo3RUdBWHg1Y0xac2xMN3Z1VW5YV2U3cEczWHI1MjZiWG9CZUw4NXZo?=
 =?utf-8?B?QmtTNzNzRjNOaGNEMnU5ZUdoZXVSYmhSTE8rWHZLVUc3dTFpdmNiTTN4cURX?=
 =?utf-8?B?VlRheStwUzAybFhMSFhGbFhjSyt3cmJoYXE4cncyNHhIZFh4N21IVGhzVnpm?=
 =?utf-8?B?SnJ4TjU3VEhmL1hxQi9MUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmhFaGczZ09GY1lwZ1daU3l3Q255TzNQV0J1WURlUDNhdlA2ZEZ2T2VQWWUx?=
 =?utf-8?B?bFJwczdMajdGSFZML0xvOXp2czhkeWVmWmgxOER2N2VsV1JPQlRZMG5GT2d2?=
 =?utf-8?B?NFhXNjhjT3JrYTJhQ1h4czd3WWhUNW5PT0VHSWsxdHhBczB5UGYrM1VLTkFx?=
 =?utf-8?B?UXdHMm5nRFhWcGR0WHFmYXVFaXE0Q1Z1WjF3SGpLS1FweitDUnBmWEkyOTJH?=
 =?utf-8?B?YUJLK051MlpGQkVxUU5TcUJzbUlHUjBLQi9aUVZhdFVQWnRqM0ZORjJRdE5i?=
 =?utf-8?B?RmtUOC9md1FEWmlmbHMrVmlmS1pLRmV5YVpzV0lWOURiWllzdi96VVdFOWdk?=
 =?utf-8?B?VXJwWEk3K1lMRTdrOXdnWnZ6K2JHR3NNZkIxbHd1eXdKYTFCcUNSU0wxeFF3?=
 =?utf-8?B?Rks4V0h2b0piUklJK3FEeWhGNnRtbjN6THVKSENZcWVKM09YNmVnTUpQR25V?=
 =?utf-8?B?YnA1aWdpV05rNXF1LytPUUJNV3JzLysxczNDY2R6L2pPTnFBeFhOOU1aWE5L?=
 =?utf-8?B?STRZT3JYSGpWS2lOWHdodGJ4L1hFYkdYbmFjWHc3NXg2QldNZTlwZDVOTytr?=
 =?utf-8?B?TlpXajBIVDY1VjI3NVZ3L1l1VWJNaHllbWlkWnFoQ1ZrQXoyb1BwWURtTnN2?=
 =?utf-8?B?aENkZkFFOUZTQmdFM2RWbXJxOEpCVU1jWk9yellLUkNuRnB2ZVFObHNEeVlU?=
 =?utf-8?B?Snd2NENGWjBBMm1SeTJHQzFzY2FsQXMzMDZ0Y3ZtM1lWWGhiL3BBQnpkSnUz?=
 =?utf-8?B?eGtyV0M3cFFyRjA0SzgwS21xbjNLZHY1S0ltZ3JLVmZtT2VlcW55VGlQeXFH?=
 =?utf-8?B?SFd4T0MvUjNHVnZpOGFzRnB0M0hCRlJ1dTgzRDNWajgyVVhrTitDb2prempD?=
 =?utf-8?B?bjU5WlZZV2sydW04ajNPeVhEVTBIdk9QNTdNTEE4RzNJd2UyVVFKUjNubldN?=
 =?utf-8?B?UmR2bDF6Sm8rZk9hQTE0Z2l4c0k4cHZLU2NHaXFwWjVFdXpHS3NKemVzRXdv?=
 =?utf-8?B?OTljdmdQdXFjTWhLN3RDcFB4SWVGL3FCVm9pZ0lxSmZPM3ZyWVBqcnJwZUJi?=
 =?utf-8?B?K1NRZDNHUGRIMzZ0TG5ZdENWM1NEclh0UE5pN2Nxa3JFdlhUYVVGVTBPUm4w?=
 =?utf-8?B?ZTQ4dDhDTmxXOTRRTGdGTXEzVmN4WDhLb0laeG9NaytlN3FYTXJTVzBaV3dv?=
 =?utf-8?B?NzA5aTl0VHFMZDZBdGpGT2NKWnBCWDc4NUtqZllCdmNYZ3JQNFp3YWxYNVFR?=
 =?utf-8?B?SkJMUklKdzJ0NWIzUDYxNmQzUHF4ZUpYTjFUK01BbGIxMDUxYmltMDR1Z3Bv?=
 =?utf-8?B?RU5xSzhQL0JnVnhsa1lxMURJbXhrZTJ2UjZTOWNiV3JQWk53SUZaN1NuRXh2?=
 =?utf-8?B?WUZpZEZhZkVjbUdBTHlaRGZycnhpL0doWDcwTUpvZldNa2pUZkd3ZmY0T3Zn?=
 =?utf-8?B?a3p3bkx0TXR0VExjL1lHOVNCMzdjaXh0OU1lQ3hGT0IzNmYzc3ZKWE9RRy95?=
 =?utf-8?B?RlBGVlZCcnFldENFcVZubU5JeG1EZ2hBQ1VQQjAxZFhHdnF3K2JRdStNNWc2?=
 =?utf-8?B?WXZzR21kVHd3TWpyUUdkeTRJOWt0UTFuQ0JvbDlIS29HVUFjeG41WmF3TlFv?=
 =?utf-8?B?aXRPYVdCQkZTT0VqdG9yRkp6MkJUZWtmcG9aZGdESmZuakYwaWtKVnRTdmRL?=
 =?utf-8?B?eGVlWUNpMXlOaTh6Tm1MYzdUNEthbVZtdzErSFVQWGgyWTNUS2VLdlRJZzZ3?=
 =?utf-8?B?RFRZb3VxL2ZoRWYyN1liM0Q5Um5icWgrdkp4NStoKy9EaHhkbzZpZmpIaFZl?=
 =?utf-8?B?REJDU2tBTHlPQXRxSitqNlJieEdjNjBuU3E5dWtEQ2diKzdRMTUrdzNxWjVX?=
 =?utf-8?B?Q2hMU2NPUVVWZ1F2Ukw2TkZKdDJOYUlUMmpLYXg4NlFnYWhScmVSL2N1MitW?=
 =?utf-8?B?cmp1S1ZZVW95QWJxQkVXN2o0bGNZKzcxQUt5eUtnVUVnd0xaZFAvelJ3aUlo?=
 =?utf-8?B?b2UxeXZDSUlpRlVTSHpOb3FuV043THlrM3pEZVZDSTRBZXJXOWRXaU90eUR1?=
 =?utf-8?B?YTZNMEluS2g4eDFtdWkyejdPa3NqM1UzL0FCRTRDZkVlY1RCTzNyeW1SZ094?=
 =?utf-8?Q?lVQ0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a21fb8f-b677-4203-d486-08dd0e7272f0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 23:31:27.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xc5qeRcsxwM4QXQuKf3L+5rK63JOMZrHBlvspDT7dSpMFeIRKJjmuZcvjyRIpn8v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

Hi Reinette,

On 11/25/2024 1:00 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/22/24 3:36 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 11/21/2024 3:12 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 11/19/24 11:20 AM, Moger, Babu wrote:
>>>> Hi Reinette,
>>>>
>>>> On 11/15/24 18:31, Reinette Chatre wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>>> Provide the interface to display the number of free monitoring counters
>>>>>> available for assignment in each doamin when mbm_cntr_assign is supported.
>>>>>>
>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>> ---
>>>>>> v9: New patch.
>>>>>> ---
>>>>>>    Documentation/arch/x86/resctrl.rst     |  4 ++++
>>>>>>    arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>>>>>    arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>>>>>>    3 files changed, 38 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>>> index 2f3a86278e84..2bc58d974934 100644
>>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>>> @@ -302,6 +302,10 @@ with the following files:
>>>>>>        memory bandwidth tracking to a single memory bandwidth event per
>>>>>>        monitoring group.
>>>>>>    +"available_mbm_cntrs":
>>>>>> +    The number of free monitoring counters available assignment in each domain
>>>>>
>>>>> "The number of free monitoring counters available assignment" -> "The number of monitoring
>>>>> counters available for assignment"?
>>>>>
>>>>> (not taking into account how text may change after addressing Peter's feedback)
>>>>
>>>> How about this?
>>>>
>>>> "The number of monitoring counters available for assignment in each domain
>>>> when the architecture supports mbm_cntr_assign mode. There are a total of
>>>> "num_mbm_cntrs" counters are available for assignment. Counters can be
>>>> assigned or unassigned individually in each domain. A counter is available
>>>> for new assignment if it is unassigned in all domains."
>>>
>>> Please consider the context of this paragraph. It follows right after the description
>>> of "num_mbm_cntrs" that states "Up to two counters can be assigned per monitoring group".
>>> I think it is confusing to follow that with a paragraph that states "Counters can be
>>> assigned or unassigned individually in each domain." I wonder if it may be helpful to
>>> use a different term ... for example a counter is *assigned* to an event of a monitoring
>>> group but this assignment may be to specified (not yet supported) or all (this work) domains while
>>> it is only *programmed*/*activated* to specified domains. Of course, all of this documentation
>>> needs to remain coherent if future work decides to indeed support per-domain assignment.
>>>
>>
>> Little bit lost here. Please help me.
> 
> I think this highlights the uncertainty this interface brings. How do you expect users
> to use this interface? At this time I think this interface can create a lot of confusion.
> For example, consider a hypothetical system with three domains and four counters that
> has the following state per mbm_assign_control:
> 
> //0=tl;1=_;2=l #default group uses counters 0 and 1 to monitor total and local MBM
> /m1/0=_;1=t;2=t #monitor group m1 uses counter 2, just for total MBM
> /m2/0=l;1=_;2=l #monitor group m2 uses counter 3, just for local MBM
> /m3/0=_;1=_;2=_
> 
> Since, in this system there are only four counters available, and
> they have all been assigned, then there are no new counters available for
> assignment.
> 
> If I understand correctly, available_mbm_cntrs will read:
> 0=1;1=3;2=1

Yes. Exactly. This causes confusion to the user.
> 
> How is a user to interpret the above numbers? It does not reflect
> that no counter can be assigned to m3, instead it reflects which of the
> already assigned counters still need to be activated on domains.
> If, for example, a user is expected to use this file to know how
> many counters can still be assigned, should it not reflect the actual
> available counters. In the above scenario it will then be:
> 0=0;1=0;2=0

We can also just print
#cat available_mbm_cntrs
0

The domain specific information is not important here.
That was my original idea. We can go back to that definition. That is 
more clear to the user.

> 
> Of course, when doing the above the user may get impression that a counter
> that has already been assigned, just not activated, is no longer available
> for use.
> 
>   
>> "available_mbm_cntrs":
>> "The number of monitoring counters available for assignment in each domain when the architecture supports "mbm_cntr_assign" mode. There are a total of "num_mbm_cntrs" counters are available for assignment.
>> A counter is assigned to an event within a monitoring group and is available for activation across all domains. Users have the flexibility to activate it selectively within specific domains."
>>
> 
> Once we understand how users are to use this file the documentation should be easier
> to create.
> 
> Reinette
> 
> 

-- 
- Babu Moger


