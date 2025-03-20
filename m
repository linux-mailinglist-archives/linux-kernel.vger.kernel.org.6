Return-Path: <linux-kernel+bounces-569823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C09A6A7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904A216B79A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB7F221579;
	Thu, 20 Mar 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HqzlrUSL"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F1170A11
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479554; cv=fail; b=QuPpBUGhR8ZYdbHjtpR2nJ0a9LNdg/n7lAai8dxW/ijwoS8jDOlYx/q2C6Gu8lwCnBNS1ZGLWeho0A+3LaxxN9vxdmQmLcV73VJ5WXLZ0keEhJherB6BHvXpgBIuIENnIX5iU06aff7J1am1bvT/SPsZ+fQEb3ZJIZOmaTzXMxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479554; c=relaxed/simple;
	bh=l43U1hao4xyuDxiupXInZxnLiY7837pOl456rH9f+0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tWxOPKgpFnqG3NRUtJdqImS0bFrf3VmJEmix6UmTzNMcDKRIhHGJCxnlumIb5Lx1A/taw+5DUJgkyA1fS6GSHpm0hkFlvM2MV1VagXmW4K6gMRLCvvtD48ndn+mNe/Ob8yKou+/JFP52rLNJU/rBkMe1UrBaeV/St0jiZv5DkdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HqzlrUSL; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6YZWpi4TO4o+3zCeKcdRbUR6RnQz6dWt3so/AhwkF3V4JLyqYjlhZbdkJ3id9nfEF6vxJZUWfzkO/4dCKXDXJBqPk8MwFtjgsnbQ3KmiuqKR6gJWIDKOWAHuqB00/qo0X1lPRlducLfKKRrjHtGwA8Y/tBDXiqHjLVo9eOvMDiNGDxbTTmYhnVwdkqXUBwJbXhkPCIHhO1oCt5oXC1AQYpR/ICOyY3iJhY12vYsrPKX4aVSUPuQS0d9faYqNwZD2WTZ9wHv7L+M1WODQJKUXFP/jCEYBe41kSXN3n3mTReBJkOCMNMVB7/27QBhM4VNBAVPDkwrHe7K45WREAOgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNrFgejyRIKaYBFEtyPFKjEKd/QxXJH5AQ3WqlRu3aA=;
 b=lJWIC00cO3Pv5RajC9wxCq2t7TyStww6AidrdzvbbkJXgroEPnE7Ke2mnrTMHZJREzmO/R3P2LUX9RqUVtkt0JYmFzgJ+jrLHkfBiurIvYHlzMz/uvH3S0RkMJVnsjZ+U4hHXmaXLWNWv+mihYwv3dNzOdKWyXXhPnNF1mq0ZsUIZWWFX9RsvXrM50SNM+cPraARuOrPAlvtBIlVpjTkgERuC0fMM/vtUjWUu+HN8+rlwDNuEb9fMHpTVTBYDAcjOG7xPMV0jT4uS4fnLsKEPAO5ip7AHFTV47uSoKseOnXk+66pwRfqFDoPU309Is2GvqczyhpPjsUs0ENvyYK4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNrFgejyRIKaYBFEtyPFKjEKd/QxXJH5AQ3WqlRu3aA=;
 b=HqzlrUSLiG520zP/ZvrNG3tpkcUK0jEgAqhgjwhN+GJKxw91LZWiab6IsVw8T8RNIB6itTViPbAh/jgFWTebSBPjtfd1NckrjrdXE8VQ9b00k8C7vhWEOHqe+Ao1vyKUHGhjhZ9496U+2wUs7wrlKcf10AIi5ADnTCYN9lWNxcvnyjSXE1clQdZtWINhOz+XLDVNzM3fsySDTP+fcEL/P1B4zgVxCaYxCX2Ti8qmFYkHtF6mc+T1Glcqw9tySTlxoi/DP4o7qIdFUa3NvjWtvkgSqyoYGhfDLYuFrLYw012cbsX9WZ1O3eMq/as+QBIhJHU2pRWBr+Y0j9lfracJrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:05:47 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 14:05:47 +0000
Message-ID: <778d935f-ef77-4bac-aeff-1bafa91b825e@nvidia.com>
Date: Thu, 20 Mar 2025 15:05:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v5 sched_ext/for-6.15] sched_ext: Enhance built-in idle
 selection with allowed CPUs
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
References: <20250320073927.216147-1-arighi@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250320073927.216147-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e782905-2b2f-4ec0-5d58-08dd67b85040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUpsNUlWM1VzRFlPM3MzUmJMYURnM1dYMlRrQUtBRDllMy9ZSDhRSXJMV3dC?=
 =?utf-8?B?UjBzelYzZEorczliNXdENWN4QXVkdllsb01FaWFtV2p4NVUwb0NWVEQzMjJi?=
 =?utf-8?B?L3pwRkRHNU5YRU5PQXpmN0pGUThLZlduUzVhU1JFRFRIOWdUdy9idXZseGxt?=
 =?utf-8?B?SkEvMHFSTVZDVHhqUzhQdHYzUTNEbjgrdWlwRVp4UUxmWElCOWNiZzFkblkz?=
 =?utf-8?B?eU1TaUdNTFAzRWpPMGRKK1RTaFVFbGhFR2ZRQk1DcnlDYVFYdk5GU2VGczdL?=
 =?utf-8?B?a3JuOXdLNlR1dytMdFJVRHlXWDZDc0FDRG51ZVRkd1A2Z2cxeEFBc3R3T0Zv?=
 =?utf-8?B?bVNVSW1WN0cyYWd4ZVBuZ21teUIzOHZxaTZEM1lNMjFBb3B5QjZTS0duZytr?=
 =?utf-8?B?SGtNdDRESzZ2MmRQeE12UDVBK3U5SCt6d2pkbUxmcC93c1JQZW9QM29kZzhz?=
 =?utf-8?B?Tlk4R0Nacngvdkk3QmoyclRrTWUrWXpoVEw5dUh1Z1BsUzNnRG1MbWczSDd2?=
 =?utf-8?B?UEcxR1RRcmQ5MlFYa3Y0bmxrcFhUd2N4dXluWG5Ob3l5dVkyejExSWJteE9O?=
 =?utf-8?B?Nk9ja2MvV01OMXdweUVKWGJZVDlRUXp1RTVaaTdrQmNBU1NWS3FINE4vVGZm?=
 =?utf-8?B?eExCdjYvazVDWU5NTFU5bER2Q2FtaFlwNzVHYmVYZmlDeUV1SGhucHpVYzAw?=
 =?utf-8?B?TjhlQU9YcDZMSDc3QWVzYkZEK3JjdnREcHV3SlNlUCtRa3UweHdaNFdvaGFB?=
 =?utf-8?B?LzRsY0I5SkZzVzl3YS9teGtJOFE0b214SzJRZWFNOUxkdXlGNGlqNlVJelpj?=
 =?utf-8?B?bk5TZ2tGRlRTdkd2TytIYXNHNXRvcE9nM0R2OTk1YXZBb1FPdEhJbEtUOHgx?=
 =?utf-8?B?SFVHYmU5T1hUWnRaVnQ3UzRMaHFXaEdSdCsvVkxiWEUySlFqYzBTeVBoeHBo?=
 =?utf-8?B?OXlNaGJHdk9TRzFZc25QWGVkbXNRNjI4RWFkUytNMGVmNVpRajJ4ZUdyeWVq?=
 =?utf-8?B?TG11SkhXaE1kZDIzZFFrVCtGeVQvM3F4SHl5aFMvNVEvSU5laWlsRTh1NkZG?=
 =?utf-8?B?T085ZWxhUmt2QXBOMXVURm43QzJGRGh5enpzU0VkeDJWYWpMSFA0OFFxZlYw?=
 =?utf-8?B?a1pQVFVUeERzS0tqTXdHZXBHT29SeVVkRXZ3SHN0Y0o2UE90azRVOVFhVVJV?=
 =?utf-8?B?bUtnY21sT1plbEJXVHcvaUlDbHY0dFFER2JuQ0M5WVpFQStrWlduVlp4dWJG?=
 =?utf-8?B?aTh1ZGlwOVNsOURUaDF2RUlMa2s0NmFvelZ5RlA0a2VMMjAxYUNNY21tU2xj?=
 =?utf-8?B?Vmx4dHh6Y0prVXU5YjE4SXFIMCsrTmZkWDBnTllaOXBVVHVZaHZGZkZXSXE5?=
 =?utf-8?B?SS9JVm1zbjdLbWtWMTR0VkkyUG1CSUlyT21MQ2NNVlBIKzJmblNidHFjV1Yz?=
 =?utf-8?B?Zjg3MkQ2ekVEdGt5Yjc2eUk2eGVSR2NOWUsxc1kzK3FBZFRqNnJkeWVGZkNh?=
 =?utf-8?B?UG04bzVJeUtXU3hEQTJNRTZwbE5XTXRScHhJS21vYkVYcldRbHhmZ3RkN2la?=
 =?utf-8?B?ckZrSTV2azZzSXRDa0tIUk5yZzZGMkpBRHBQc1M3d28vNUErazduNXhENmU2?=
 =?utf-8?B?Nk53ZWJUUlVaSnZKYUxxOVZWa1RySjNrZXdFdzI2Uk5wWHNNNTBEdjFJY3Fk?=
 =?utf-8?B?MGJOMXM1ajM0SU45VlpmRyt6VWRZMDkxa0Zzd1BLQ2MzdGRqNXFFZld4YS94?=
 =?utf-8?B?QzBtQ05ETEtuSkRFV3I4cCtNZU4zNUxmRFhwOC91aG5DakwxOTI1UkJEU3Vu?=
 =?utf-8?B?VU9ZRVNIZlNnRkRYR0FwZ0pZbWUwMC8rVE13R1hKYnFxVm03bUNrTmZRRXpw?=
 =?utf-8?Q?1nqefqBUn/Kqy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cStrcGdJNE94d2dkMURPUUtYQkYwUTZpS29kbVR4dnNRWjVwTzhnSUdpUkRp?=
 =?utf-8?B?c3l0bStINVdrZmREVGlEcnVxV3U5UEk1aGNOSHhwcjNmTVI0cHRCZTdMZTBF?=
 =?utf-8?B?dFFsQVdVTzVQbGZrdDVBWTFXRURRclJBNjFGKzAvMkJMaVlPeDdxQlhmNUli?=
 =?utf-8?B?VlhtWmxSdjZmakwyVnovKzg0ZlFlVUExNnlja0JHbDkvSnQyVU9QcXRFYU5V?=
 =?utf-8?B?SnA5b2RwMVdtV1cvcEpsWHFJdUtDZWh1ZEhYdlhrSkFjdzNDbW16c251OGZ0?=
 =?utf-8?B?YjJOQkpwNThZWFQ5N1ovY2pjUEFRTVJIMTJJN2lJSXk1dWd4a1RPelRUL2J1?=
 =?utf-8?B?Q2JJWEdGQ3lnamQxbjVlckEzb284WFZQa01XdlRGRHk2VjhrWWEvZDhVYzRx?=
 =?utf-8?B?YXQ2QlRwS3ByTlNoZGh1YlVFeWVvNXdhMVphc2U1WklQbWNWdldONlU0TzJv?=
 =?utf-8?B?aW9YbjdjczY3cEhVbk1JcHhFWjZIVTIyYU4yM3QzMEw4MnpBWUFxeXFHR05n?=
 =?utf-8?B?b1BQd0V3VHRkalVlNFFZTWdVZkpDVEFMQU5wei9zSTBPUk9yRUpOUzNkMGM4?=
 =?utf-8?B?czB5NVpvM3J1QmtoUmFpSlJhaFp2UmtLN0hxZm5hTVd2TWJ5VjN0bkt4azFl?=
 =?utf-8?B?N0FjOHh5NkZSY08zalZiV1FuTTdBRy83Q2lTV01RWFpWS1pna2FxdTYwaVdz?=
 =?utf-8?B?OVo4U2lwR2R4VXlvS3V4R2NaT0tDaU1IbzhVTUl6eFdocWNGYitQNEI4aXRl?=
 =?utf-8?B?ZnRydGpmdVJ1V09wSnhyWUtqK2VkUzNXQ3REa0tkZlNnaHJiNkI1RjZ1d3Bk?=
 =?utf-8?B?WHV5VzNic2FNQS9QenZqVGVTMUo0NFVGaERoUEFFRExVbUUvMklCdWVLMHN2?=
 =?utf-8?B?YVNIZW1CaDhPVTNIemIwOXljcnNCNUV4Qmtaa0dteUtjV2hNZndXc1hLQzgz?=
 =?utf-8?B?QVNLdU5ZZU5ScTRFZ2N6cU9oQUkxMjNDSGkybFBxRlo3QTBGZ3Zib2JYMzBn?=
 =?utf-8?B?bmdxQ2Y4QlBtaHQybDNMMmVyTXZJSjRkZnAybVhGYStEUk16dEI3NDdxUGJ2?=
 =?utf-8?B?OFRZQ3orc05uRmt5TGdBdFk3MGhSSFczTC8yd2hqYzRPZHNRRU1od1U1c0d5?=
 =?utf-8?B?Q2JjTVcyTldIOEpXTElsSDdId25ocFZGbUVpRm5uSE9iTXhNL0F1S2pTeE9J?=
 =?utf-8?B?SE5lQXJ3TmFPa0VWQVZFV0tkY2Z2MUwrdlN3WXJZSHp1cmgrcTMwOWJ3ZlNt?=
 =?utf-8?B?QXFCZVZJUnZwejFDQkRBWVNPYVBPTllKbzlNcnN6UlZ2MmwzSDhvMGpxZlBu?=
 =?utf-8?B?d21jcXA1TmNVY1A3VHR3U2NienFzY29hSHd0S0ZKWUFXcnF3WSt2MlVXR0pi?=
 =?utf-8?B?VHk4NlJReEtIRUszYWh1T04rcDkyYVFUR0IxS0pOQlhOd1hvVzlBU0FCQS9K?=
 =?utf-8?B?V1B6VWdCd3RZVmRRS0pjNmVIdGJDWHpzRXV2ZkpVY3dOcTZCMThNYXZGL2pP?=
 =?utf-8?B?ZGNsc25kbHlVenFHTnN1eHVqU3Nkb0VNMDRDdEZMNzZuR3lQQ0gyVGtsRVll?=
 =?utf-8?B?U3dHNjkwSTU5V1Fuc1ZWdkczNitvenNPUUxDeHRSd1h3ZEx2Q2EwcHZYZ1l1?=
 =?utf-8?B?MmVnTTU5dVV3Q0JpWEhSQ09rbXAyMEZBRnFKSzdRdjdsK2srTGhPR3NXdm91?=
 =?utf-8?B?MkwvaVZQZTBuamxvRkVLL0k5N0xSUGljaWpZNU1hZm9yaXZqQVA3MG0wYkkw?=
 =?utf-8?B?Q2tWcE5XZnY2UFYyeU1Ga0pBNitvaGM5ZnZVWDhkN3c4UHg2V0w1TWVQeFlu?=
 =?utf-8?B?TUJjUFNVdUlXK2dsODhyT2ZhZGpZNEw4c0V6ek14cktTdFNLR3M0VW1hdjg5?=
 =?utf-8?B?Vm5pVmNUUGhVM1ZSTnJ2ZC90bjNaWlYvZTROeVNYSXcrQmROcDNOQ0NuVzVF?=
 =?utf-8?B?bjlzUDc4QWJGZ0l1N1RRalQxcWt1WmlzNysvQUpCQVNXN0RoZXI0MXNxRlJz?=
 =?utf-8?B?MVFTTlE3Rm9NYkxGTllzbHdKakVlOUZtaGpLaWY0UnQxZ0Z6TzU2bzN4czFV?=
 =?utf-8?B?akh1bjY3MmxNdGc3WVlrQTh6SE96RE14VjUrWE1OcnV6MkdqT2FuZ0M4ZE85?=
 =?utf-8?Q?RWqBYw3YAvR57HRQ26NTKGVWG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e782905-2b2f-4ec0-5d58-08dd67b85040
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:05:47.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hh4o62Y5sqz8tRhT1QGI9x54+ZCOXwI3OTXru1bb11jKb/RP+zTyww880rOSsgABootDuTbD8x6bAc+H3cOkVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018



On 3/20/2025 8:36 AM, Andrea Righi wrote:
> Many scx schedulers implement their own hard or soft-affinity rules to
> support topology characteristics, such as heterogeneous architectures
> (e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
> specific properties (e.g., running certain tasks only in a subset of CPUs).
> 
> Currently, there is no mechanism that allows to use the built-in idle CPU
> selection policy to an arbitrary subset of CPUs. As a result, schedulers
> often implement their own idle CPU selection policies, which are typically
> similar to one another, leading to a lot of code duplication.
> 
> To address this, extend the built-in idle CPU selection policy introducing
> the concept of allowed CPUs.
> 
> With this concept, BPF schedulers can apply the built-in idle CPU selection
> policy to a subset of allowed CPUs, allowing them to implement their own
> hard/soft-affinity rules while still using the topology optimizations of
> the built-in policy, preventing code duplication across different
> schedulers.
> 
> To implement this introduce a new helper kfunc scx_bpf_select_cpu_and()
> that accepts a cpumask of allowed CPUs:
> 
> s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu,
> 			   u64 wake_flags,
> 			   const struct cpumask *cpus_allowed, u64 flags);
> 
> Example usage
> =============
> 
> s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
> 		   s32 prev_cpu, u64 wake_flags)
> {
> 	const struct cpumask *cpus = task_allowed_cpus(p) ?: p->cpus_ptr;
> 	s32 cpu;

Andrea, I'm curious why cannot this expression simply be moved into the default
select implementation? And then for those that need a more custom mask, we can
do the scx_bpf_select_cpu_and() as a second step.

Also I think I am missing, what is the motivation in the existing code to not do
LLC/NUMA-only scans if the task is restrained? Thanks for clarifying.

thanks,

 - Joel



> 
> 	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, cpus, 0);
> 	if (cpu >= 0) {
> 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> 		return cpu;
> 	}
> 
> 	return prev_cpu;
> }
> 
> Results
> =======
> 
> Load distribution on a 4 sockets / 4 cores per socket system, simulated
> using virtme-ng, running a modified version of scx_bpfland that uses the
> new helper scx_bpf_select_cpu_and() and 0xff00 as allowed domain:
> 
>      $ vng --cpu 16,sockets=4,cores=4,threads=1
>      ...
>      $ stress-ng -c 16
>      ...
>      $ htop
>      ...
>        0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
>        1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
>        2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
>        3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
>        4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
>        5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
>        6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
>        7[                         0.0%]  15[||||||||||||||||||||||||100.0%]
> 
> With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across all
> the available CPUs.
> 
> ChangeLog v4 -> v5:
>  - simplify the code to compute (and) task's temporary cpumasks
> 
> ChangeLog v3 -> v4:
>  - keep p->nr_cpus_allowed optimizations (skip cpumask operations when the
>    task can run on all CPUs)
>  - allow to call scx_bpf_select_cpu_and() also from ops.enqueue() and
>    modify the kselftest to cover this case as well
>  - rebase to the latest sched_ext/for-6.15
> 
> ChangeLog v2 -> v3:
>  - incrementally refactor scx_select_cpu_dfl() to accept idle flags and an
>    arbitrary allowed cpumask
>  - build scx_bpf_select_cpu_and() on top of the existing logic
>  - re-arrange scx_select_cpu_dfl() prototype, aligning the first three
>    arguments with select_task_rq()
>  - do not use "domain" for the allowed cpumask to avoid potential ambiguity
>    with sched_domain
> 
> ChangeLog v1 -> v2:
>   - rename scx_bpf_select_cpu_pref() to scx_bpf_select_cpu_and() and always
>     select idle CPUs strictly within the allowed domain
>   - rename preferred CPUs -> allowed CPU
>   - drop %SCX_PICK_IDLE_IN_PREF (not required anymore)
>   - deprecate scx_bpf_select_cpu_dfl() in favor of scx_bpf_select_cpu_and()
>     and provide all the required backward compatibility boilerplate
> 
> Andrea Righi (6):
>       sched_ext: idle: Extend topology optimizations to all tasks
>       sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
>       sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
>       sched_ext: idle: Introduce scx_bpf_select_cpu_and()
>       selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
>       sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()
> 
>  Documentation/scheduler/sched-ext.rst              |  11 +-
>  kernel/sched/ext.c                                 |   6 +-
>  kernel/sched/ext_idle.c                            | 196 ++++++++++++++++-----
>  kernel/sched/ext_idle.h                            |   3 +-
>  tools/sched_ext/include/scx/common.bpf.h           |   5 +-
>  tools/sched_ext/include/scx/compat.bpf.h           |  37 ++++
>  tools/sched_ext/scx_flatcg.bpf.c                   |  12 +-
>  tools/sched_ext/scx_simple.bpf.c                   |   9 +-
>  tools/testing/selftests/sched_ext/Makefile         |   1 +
>  .../testing/selftests/sched_ext/allowed_cpus.bpf.c | 121 +++++++++++++
>  tools/testing/selftests/sched_ext/allowed_cpus.c   |  57 ++++++
>  .../selftests/sched_ext/enq_select_cpu_fails.bpf.c |  12 +-
>  .../selftests/sched_ext/enq_select_cpu_fails.c     |   2 +-
>  tools/testing/selftests/sched_ext/exit.bpf.c       |   6 +-
>  .../sched_ext/select_cpu_dfl_nodispatch.bpf.c      |  13 +-
>  .../sched_ext/select_cpu_dfl_nodispatch.c          |   2 +-
>  16 files changed, 404 insertions(+), 89 deletions(-)
>  create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c


