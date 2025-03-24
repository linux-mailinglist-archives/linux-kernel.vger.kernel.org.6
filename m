Return-Path: <linux-kernel+bounces-573848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913E4A6DD18
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45A43A1C44
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550D225E44B;
	Mon, 24 Mar 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rIQEPHj7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBF25C6FE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826885; cv=fail; b=RmJRyh7fvMHqbJ6dqTFeebDc+Znj02YTXMlrPlCSC1obBwCIBuYz8hWDnyQeF790LeH9KI2/KzsxXOhf44FwhYAbpm0z9bLuZy+4HyHVP+IobRw0d84z1TfIlfc2DFZbvX7BmQtRrv4JYrYO579I4tAnrrJ++UrmvIFo9H6mrmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826885; c=relaxed/simple;
	bh=a0xft8cimlh3l6cYHLoQgruDrji8gYbqRdbJcXwe6E0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=THCDu+EUn6PtndRj5NlN6BBldSgE6rwTHfKUb1gPgowYmdHzi5MUGQfC0glBQBYU8jjepefQv7sbJ7buErundYHFz67ityLszie6FRRf+uc7N9oB2C9kwozWxxd1QPmY5ke9ZD1d5cBzQ/LdOhd4sqXFXdNRF1+Iv7+ladDl7cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rIQEPHj7; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PATTXPi9I4xpr6EYAHKSLXkJMoyYYoSgRNIdH/34umcfU6mUAAzT5QRcJeX9ywwwBemVDQpZQiDq6Kj7K7r3DSQR96GSEs1+ePMML+bePeKJVsEmQils4pHl9IJPQ94lL4FjPhCpukgUHh00M/Ru4L735py6RTtejWsyPqh5yr6JMbdVvlwB6LPPuQeeqfVjhUHTlJsJ7+Dg8XJDyxh8RxavV+EigjHXrHKzCham+/O8jtOh4VK82dJkpyVeHlW3e1w6Srda3jnjgU0FOn5aGhS6S6haYwC1jOrk/J4aIme8tiHg4A0oPjUwhnXQBAdlZFam4UST18OoxBebZ164Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3flQYr0fDvX5saIg+q1D29nXCHOzVr1gno++yrjgYQ=;
 b=Ncfk8r6Vt4oULNPBjRA7/e29BuxRd2Sfdiex791F/Y1y7ayc1eP87B0oEvq2uaN5p8bspr9CIs3Wo5y37pEg5r1mr+3X0ep1v422l0QliXcp8hDksk46dUbWsIQ/+k74G1KWcValq2Qass/B6DwRSEkBRFmidAOVvPV+51RPPNg6Cfxew2nmYdmZaejCBh0wKE3+X0MnJKDfH0/tqqUs6yHHvyJ5XhkBsy+tDsuoo2mgxeYx15Tvaw76I//e4HOW+/jFXoeWge4eO1W4BalVUDjYyektdkcbTdjSHb+k0Hgaz1CJw6P/oX+okm2HFpk+C5jM/IuGRqK8r45O0qhduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3flQYr0fDvX5saIg+q1D29nXCHOzVr1gno++yrjgYQ=;
 b=rIQEPHj7UCOAzaGSnwTbfxyDaJLtVsJdck/PDWU9wlqziX7wkYi7yunkef2smcyZ2LskUDj+5cA6JFRQQH5W2ou0DzQ4eTI46G7aumwWWHrWFk51MEX0122KDQw7fOLDTQowegz4MxS1w1oASo/taq6nLWdxZfY7wsBi/2z9T4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:34:41 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 14:34:41 +0000
Message-ID: <b0609437-28df-4773-8058-d68d01030cfb@amd.com>
Date: Mon, 24 Mar 2025 20:04:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 yuanchu@google.com, hyeonggon.yoo@sk.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
 <Z-Fhl6rLJH2wweGC@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <Z-Fhl6rLJH2wweGC@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 45708e41-94f7-4504-4ee5-08dd6ae10345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXQ2aFdla3JHRUtYS3FxbG5XRGZBdWxBNk5ydVZERmtYRlNNTnZyazdySU5t?=
 =?utf-8?B?SkFsRWU3OEg1V2lUb0xaZGpHdWg5UUY4VkNkSko2TmdZYTExMms4dkVKOUJk?=
 =?utf-8?B?SzFqdUhxTi96Z3RrNHVVNnFUak90ZjVxSUVROUt2RzBmUGdKc1d2SDBOZGhM?=
 =?utf-8?B?Y0xYdlpIdGt2UjBCZWYwYWxJRy9YYzFicUxtanpUcE1rOC9MVDZjaHBTOFZT?=
 =?utf-8?B?UmZ3Sm5WbkxrNzB5eXE2THBEeWQzTjBZdXA3Mit0RmpqSEQzenlhVnF5bGs0?=
 =?utf-8?B?VU05enRzVzF6M1Z1emErREdrZ3d3MzllZGZjYldEMkN4V2pKdHVWT3BaVjN2?=
 =?utf-8?B?Nmc2dmYwUmJhQXhiVDRoeGpNQ3BrbDdhd3N1RjV2OGVYY0M3REZBL0ZKSkFD?=
 =?utf-8?B?N09QVmoxdTZtTzdOTjRYb3VyN1hGUDN3UjVLM1FlbitqaTRDcURvVTZieExN?=
 =?utf-8?B?ZjU5WGJYaGIzZDJmSUpqRExWL2RUTFRFNDNFdHI3UWVZN0dRYkZYZjhEZ0Zv?=
 =?utf-8?B?QVhKTU9XSll4ZmdJa1loSFE2VFloTjBKbTE5eG0xcDU0d05kUFJiNnk2UlhM?=
 =?utf-8?B?SllTYzNBdHNzODY4emRGdEhFMFB0RG9XWFJxMjdrdGZxNDJzYlhVVzB6ZSt3?=
 =?utf-8?B?T2pYREgxQ0E2QnZmVlI2VmdUUUw5NmZJSGRNNGd2cytVQ295bFBnWGhvUW1H?=
 =?utf-8?B?Wlg2SnAzK2c3dHU5YVJHUEp4NU5MeG1ZVGRCblBBeldPeGQwOVVKSlVrNGJP?=
 =?utf-8?B?am1YT1IyMmNFTVBCck91L1RDTWx4NWxOd2dMeVVTZ0ZuRm9idEhIckY2bVhm?=
 =?utf-8?B?SXB3cmtPTUdvY0FhcE0zWVFHM0Z1a0VqNy9UekZ5UklQclF1bm53azRFSEVi?=
 =?utf-8?B?V0M1K1JnaHozMGZvbGQySkxYZW45SXRvTGxQZ0NHYmFsWWxrd1BhUUNBcUtL?=
 =?utf-8?B?RmZxS0p0ckNOZHdoTnAvV3ZpUXhNRjU2QjRIaVh2SWxyNDkwZnUvS05LSHZM?=
 =?utf-8?B?eXlFcHpLaFB1N0dsbTdZRlFVZ0dkalFWeXZ4Q0hqSGtQZkpBK0NFa3Rpc1py?=
 =?utf-8?B?MjRoZHZZdk1Sd2pnZ2RkOGpUQlBxKzc2OGJsWEFScmcxYmJHWXdJUmc4RkxV?=
 =?utf-8?B?VkZqeGRRcERFSXRrUWFZSTFpQlY1ZHB1bG5yNnhLTmRsTnE0RDRaeVptZzdN?=
 =?utf-8?B?bHVUeTUwNE1hTHNTdGNWV2cyc1hXZnhGcVhVbTFzN2dUNHVodXFQZFZvVFRT?=
 =?utf-8?B?RnNMZEIyU1ZEWTdBZTU0WGk5cGJOKzFqTU83dVRSL3ZYbWFhQUsvTUdrUlRG?=
 =?utf-8?B?TUd2TEphV3BhQjVYakwyd0J4MDNDTjVWTmk5YnhsdHVvcTdjVkp0Q3BQM1RY?=
 =?utf-8?B?V3FrVlorY1RjMUdjOFNVWFpyWTNrSjhjMjRpbTJVMVRzVDVJZ1hGUnA5SGc3?=
 =?utf-8?B?UUZ3Ny9oS0I5WXJoc2FXZ0E4WmJ5ckFuY1Q2SUhOK01GQUJRdjNTSUZMaFVl?=
 =?utf-8?B?ZXZIaGNDbjhzK3JJQUdYa0x2T1ZuNmRPTlI1cVBOK3JiNExZZEFuSnd0WVA0?=
 =?utf-8?B?NEVMckpZeEFlaVdiVmdTZ0hOSi9VSjJZQU1VSHIyeWpJRnYrc0ZULzhyaE9Y?=
 =?utf-8?B?WHpzTjl3dXNZNUJObzVHWXJpOWM0SzVCWVhWOHYvSVBudWsxM09HZ2JnNlJL?=
 =?utf-8?B?RjBkRkJkU01jTlhRenl6cnJ1RGR1eE5kejRxbUxOUHduL3N2OHBzb2R3aUFL?=
 =?utf-8?B?R1V1YjE5cEowNEdFMThzc0tMNVprNVlESWJyUE5HLzNSVzBOcG1NaXBuclZE?=
 =?utf-8?B?ZzhwVEdma1N6V3ZxcUd5cis0d09MOENtWWZrb0FmVzgwcnhKR0swTDJVS29y?=
 =?utf-8?Q?RfjwooB717a6x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a09KVFRiZmFGZlBHUVJkL3c5YUJpTVdMMUNRNThOUEhUNjA5RlNGNXFobVBG?=
 =?utf-8?B?S3Rkb1JnUjVQTmlCS1JESFJXL1NQMEZDSVEvcHA2OHd5RldEbWR3bDNLOE56?=
 =?utf-8?B?NUQ3STllaDg3NGpXYXNDTkNjSkkxNG9WUmNVbHdSY2l5RkVvZlZjakhxa0to?=
 =?utf-8?B?OHdUdDF5U1VmUnpodU9WeGtkNm1yVUtzSis1dlFvK0FxNnZqSENPbG1mUzV1?=
 =?utf-8?B?WDYwT2NNcnJ4c3h2Ni9HanRUTk5sTXVsbUZzcXovbUlhMlRkdVhqdVNxdnVu?=
 =?utf-8?B?eFlIbm9pcVY3ekNKNkp6NEZlU0g4SFZkYVBUMkpXbVA1N2NOckdrYVU1VWdz?=
 =?utf-8?B?NDFwVUNuYmsvRTJ5aXd2K2x1U1hkY3RTUklvMGVjVlBHQlZQenhPcXBhOGp5?=
 =?utf-8?B?K0dCSW1TQktIR29IYlZNNWgvdXd5L1p3UWg4Nmk2SENLakVzakdDbGxNdlRo?=
 =?utf-8?B?Kzd4UFo4MTZ2VDNkY1dIQy9EdWJHYmdXaXJubEJvZVJPMWhhUTl1S1VYazN5?=
 =?utf-8?B?TEFTUm1QNU1WR25MNkRHWkpGWTJyRk4vNmdxUS9WS2tNbHBqS2o5VlY3ZmZO?=
 =?utf-8?B?Y0thK0lIelFnVGgvU1BPYWlrTVRjaDdiOEdQOVd0TjRhQ2xLeEl0eWZjdjZR?=
 =?utf-8?B?U1R3MVF0Q1YyVDgxWHVSd1l1NDN5eEI0eFd4OExISmYrNXFjQ0ljZ2dXa3RW?=
 =?utf-8?B?SGV3Zk5nRUtRb2dmNjFzU0llRGRsMjJEU3FENWNnT3h0dzV2bUJBTW1qenln?=
 =?utf-8?B?VU5tbW93VVk3ekJNejZKUVpmU0NSM1duRWlEMnJmUGRVbFBMSFFsNDJrOW4y?=
 =?utf-8?B?SFZOSmhEQnF0R3g2MXpUelJremd6MzdVTG4yRGk1OEJCNEFTZmhJMnh1NWdl?=
 =?utf-8?B?TDZoSDVLdStGMnlvTjl2OEkwQm5VSmZyNVYvWmtnNVhFQ1pKWGxPbVVxS3F0?=
 =?utf-8?B?ZjZUUkJqeUZxRmlUZnh1VE1mbzl6bDlpTloxUk1zUm5TcGJJYUJIbDVldnVj?=
 =?utf-8?B?VGJISG9pRG44REpJajVubkM1dmlab0Y4NWQvRm81b3daYndaeDgxNVV2SERS?=
 =?utf-8?B?VGFJb3E4KzBpN2ZaUHZCSzRQTEpCeTZybHNGUDJoSXkvQXRXckREZ1ZHL2li?=
 =?utf-8?B?UFltYWFHNGkzYldDVDNLdkR1Rlp5K1VMWDNRc2xZWU1LU0V1R1lLbnVjbUYv?=
 =?utf-8?B?N0VXMHNCNmpKcDFpaHpQUXNjTW1QN09BL09TMEc1dWY1bFBZb2dLeXpWTkZW?=
 =?utf-8?B?ZkVROHhVU08yVk1oZmtyNFNNencxQXY0T0FDVUdUZnFsOHpkMWRsSDFDbWNF?=
 =?utf-8?B?RVJHdkhnZW94L1lzbEhZN0NUOTF5WVJRbDgxcjRQQ1FMVzVEL2pBazVLUGpO?=
 =?utf-8?B?QlpLWjFiSTBxbis0b0hJdmZDUDRnRU5GN2J3WkZPUWhjSzFHeXM5R3RMVmtC?=
 =?utf-8?B?Nzd6Rzc3MG5hVSsyeVJyYzRtL1FKQ1RCejZRaExuM21NalFVcVlKQ3J3bnk2?=
 =?utf-8?B?QjIrdmgzYmFHU21Rbk1yWU03TWVMWUZ2SjZjSEVvZmpFMzNyRThTREJNT2xR?=
 =?utf-8?B?aStQeGRIamF6N0Q4Zk55T2NZYjBVQVRtWE5PYmRLZmRRbCt2TlVHWkxwQ0ZI?=
 =?utf-8?B?UFJBa0RTcTJuLzh2a3V1ZnRiZzVmRGZQYk9FMklnejluMWVNdHpTdjB6Vm9E?=
 =?utf-8?B?VzROV0pRRGZ3RzBlOHBwQThCeW5yczAwWWxKMFdIQlNLWE1XS1l5WE8xd2p0?=
 =?utf-8?B?dm0vc252bzBJOEVMb2xpZXJCNUNlY202VXR5MmFKVUxnaGVrc0xxandUM0R1?=
 =?utf-8?B?aERZQzRJeXdUOXc2UWV5N2VXZE9FY3NNdE9lRllNcmVpa21NV2FOejkva3Js?=
 =?utf-8?B?WHZjNHN1aTcrQ3pDUkRESWZzMnpwVDhGYXlvZDVmaUVQZmltVjZJU0xGYVh1?=
 =?utf-8?B?NzMxZVMxVnhlcTZyeWlFL1RwRHNVemM0dWhJZXZuK2NWaEd4SUxSZHRReDFC?=
 =?utf-8?B?K0Z1N1g2b1V5eWpET0dseXNRUFJKL1F3MlBIY0xwSXRFOU9GUEFud1I0L1p5?=
 =?utf-8?B?U1IrS1dBWmUwajNweGw4eksxcXpXS3Q1N0VWSloxVmFBdHU3Q0piS1lBTFgy?=
 =?utf-8?Q?vAZf5TI9mqRiEYpZBsNWbHGJ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45708e41-94f7-4504-4ee5-08dd6ae10345
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:34:41.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2TOf8L4nuMhzr5gkmB8uTMMi6H2hgswAhsnSkiuLZcNVTljAhlgrG3ZqAdJGJjIM8YKRZUlzBmiMjvgwstZbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181

On 24-Mar-25 7:13 PM, Gregory Price wrote:
> On Thu, Mar 06, 2025 at 11:15:30AM +0530, Bharata B Rao wrote:
>> kpromoted is a kernel daemon that accumulates hot page info
>> from different sources and tries to promote pages from slow
>> tiers to top tiers. One instance of this thread runs on each
>> node that has CPUs.
>>
> 
> Hot take: This sounds more like ktieringd not kpromoted

:-)

> 
> Is it reasonable to split the tracking a promotion logic into separate
> interfaces?  This would let us manage, for example, rate-limiting in the
> movement interface cleanly without having to care about the tiering
> system(s) associated with it.
> 
>      my_tiering_magic():
>          ... identify hot things ...
>          promote(batch_folios, optional_data);
>              -> kick daemon thread to wake up and do the promotion
> 	... continue async things ...
> 
> Optional data could be anything from target nodes or accessor info, but
> not hotness information.
> 
> Then users at least get a clean interface for things like rate-limiting,
> and everyone proposing their own take on tiering can consume it.  This
> may also be useful for existing users (TPP, reclaim?, etc).

Yes, Makes sense to split tracking and promotion logic into separate 
parts. There is no need for the promotion part to work with the hot page 
list that belongs to the tracking part as I have done in this RFC.

Raghu and I already saw that migration part is kind of duplicated in our 
patchsets(kmmscand and this) and were thinking of unifying them. Having 
clean separation as you suggest will be good.

Regards,
Bharata.

