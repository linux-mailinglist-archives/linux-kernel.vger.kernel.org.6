Return-Path: <linux-kernel+bounces-368513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD2E9A10AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB1D1C22128
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C877718B48F;
	Wed, 16 Oct 2024 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qMDB/Cd+"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278A17B425;
	Wed, 16 Oct 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099962; cv=fail; b=brQIPNqFh7XMS0mPXj/F0Lf3GtGQRGtSweeFR3uoZ6+RG0VbQm3z6aw+4Po1qTesaBBcb+nXdgv9cuJNpERx5RPCA3B2hinZmIUrmu4QnkzpfPE0VNvNzqMWTA0FfjzbQnPVe6fENUtKVHQDZfHHB6BudbqHvPe9XEEs/4nDOYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099962; c=relaxed/simple;
	bh=MJnlqwHT7qGx/Z0uAXBE3I/9l1MGLKMnpjPvjuG62Os=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CMNIXWZwp3SHWy5RM13eW8xHYXlkT5tlc4P93JSHITSE6jDqZjSRAVHnHGiUREfLKVgMk7YsKU8rSt4ayzNIO9T70tJTk8QG5F3TRJEupJt0NZR1b/gu9L3T4pR02yAi0fwHuM1Dp/RvhyYrq8FILtSGVc4LTXf1+bdqTLpevso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qMDB/Cd+; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtBU+TYR2blO50LEBmWv+T7scovy0N/jre6ucVfkXuuZWSO1XiCA3RT5zwU+KlXU1yyO/6kVQ4q3gJFPVluuKHi+RzGysDUuy2tZr5pBdeR+jLJ0W8ZZAF55GxMJ4n35DEJ9lYSTedYiRHOvokMreB31vLkt3Q5YL889Gp661ubOsgWhfnGcP0zj4H+dSjYmBmY3fcTzffrTV/bDLE4zZgUThBLPbCl7H3uL270rnCzaePxwOhpyQ6oWRTrucictx/cAR0ShGRVEufDsFacJIBDiVK22sm/HjoWV8MjyszwwlVoB4ABW6ZZufy6IJBkK5AmzKjNN6XFly19NAxQkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cR/1AbJ/aKSczR1hlU+ZRbDgVjXkyOrmICkEL4sejX4=;
 b=P1oKbSYSjY7gWTQtxTLXAcNTisaOm1+XBG9trohPDWfvE0YkbdlipkkoYr4CCY9NnG9ZGSvLP7GDuaaGvazH/ADfBzSxqYIonWH2k4lJU3JpwM6sSsu+JoxIHqItMSX//GwVLfDAWBOWCoKAbyjJ4/ZANw9NTv5gki5go/H12yDfoQSmpPOEFvpZdfU8D7niN+xPbc/Ej3ZNwPodFzI2FN/GuroOeDm8stF8zRzLKDCziW2IbeoJ7aBQkbVM3p9QEEZS5sZNzjNcoPyRVYgtm5sP55hd1rz5q4rzY0fvwAQCUBfLN/yq6Jz6+XgfLTPv/pNwlYdk7YHlryPzF8cbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR/1AbJ/aKSczR1hlU+ZRbDgVjXkyOrmICkEL4sejX4=;
 b=qMDB/Cd+WHj1tnXtDSGffoIoftQylgpHO6xZA7zFGE6HeHDih+25cDs0lJwKeI0S+naIRwYe40mQRcHji6/rPk9XwKRBvTA/0Cx/pVgNOrSasPdN6qCfkSXurQGWBwfj/36RlJLA/uY32tb3yjrVrsM53Z6c5QkePt04a3kdrk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Wed, 16 Oct
 2024 17:32:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.029; Wed, 16 Oct 2024
 17:32:36 +0000
Message-ID: <7749600f-f281-4cb8-b909-382a69dac56b@amd.com>
Date: Wed, 16 Oct 2024 12:32:31 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 09/25] x86/resctrl: Add __init attribute to
 dom_data_init()
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <03077cf67cea1b3ebb00495fd40d1535db27ff8c.1728495588.git.babu.moger@amd.com>
 <b19af235-7ad5-4897-8082-1eabfee849e8@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b19af235-7ad5-4897-8082-1eabfee849e8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0114.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: f1476663-e874-4bd6-86fc-08dcee088649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDNWdTBjZXNNNnU0VTlrS3oxMTlMZDFDUTZ1NVJ6VGh6cXJPTVREelRMSzBE?=
 =?utf-8?B?UjdDRktYL3ZpeEkzZnJkdDliTERhQlF6eG16UDFaclFWc0ZlVEcrRk5JS0sw?=
 =?utf-8?B?NHZOaE9JRThDeXB4OEI0bzRSNEJZSWgxNkJmdGRQTDFvcC9vMlR4Qk15bTd3?=
 =?utf-8?B?Zk9HNk1mbEROSG01NEFSYjU2VUxoNkg0WFQ1elc4UlhseTlyMUVvbmdBV2Vq?=
 =?utf-8?B?eGNOZm5VYm85OEFGY3hSOEZrbkcrU2lwU1NTdFEraDVEMmdScSs4eitaSWoz?=
 =?utf-8?B?R1BEZEdIRkRGNkMvUzlCWDJnT1ZOeUVqQlgyL3pXS0RqaXpXRk84R25ueHJi?=
 =?utf-8?B?VittaXpyVGVEYmRyaWpVMzh5MlJXS0VVTlhrUGNscHg4cGpEUWpObFZ0MzRh?=
 =?utf-8?B?NndiWEgyR3R6MXBRMmM5WTBZTmUwWmwzVkFOM0ZmTC84NEZlL21CMno2WEdG?=
 =?utf-8?B?WU1JaXBXcklGL2pCalNyU01taWdaNXNwRzV6elR3VmZuc0hMaU1YZTZVa3Jh?=
 =?utf-8?B?MU03UXNEZGc2YklaUUVUVlhPdTVRQVdJZVphS2ZtY0lkSS8yK1Rxd25nVStZ?=
 =?utf-8?B?dWRvT2ovTVFRVW85RE9HTlU3UTg5eW9rbldmaS9tVGhSZENqMnRNdUh3Uk80?=
 =?utf-8?B?ZksrNlc2L1J3QVduNm5QVWxXK0d5QzFucTM1MTV0N0FadXZ1dHJYMS9ZSTZ2?=
 =?utf-8?B?MjE1RjhmQkE5MmZOa2laMUNQelFlRUloY3RQTkN1VFUrRU5ldGQ0dXBDS1Bv?=
 =?utf-8?B?RGVwUnc4aVRtTEI1bis4bnAxVllyQjQ1bFpNMHBDV3RMdC9qNCtibG1kRCsz?=
 =?utf-8?B?eGhnYUYvaDVzQVRySDFJakVMdDhaS3pWSnR0RElJWDlhVTNkOEprS1lBdFhT?=
 =?utf-8?B?c2NvbzQzS29rSUZEM0pkaEpBNStEM0lvZ0RtNkl0WCs0R3NDbmpGVk1FcmVH?=
 =?utf-8?B?cEZzaGRkNVJaT2IrVnUvelYrVDgzWFdFL3QyZU84Yk9YU3BKc2FsSDZrWWMx?=
 =?utf-8?B?RFZSdy9JSDNwcCt1Z29jc1dNSjcyaXZOTFRLclRnRDRvVEdtUDc3NUhKWnZW?=
 =?utf-8?B?OVBzN3VSdkJ4TEVEY3RxeDNnZG9TNmVZcDNxc2ZMQ0RCanN5TzdoSFVXVDNM?=
 =?utf-8?B?SFhEeEZNVkhod1kvZ0VZZzRxME8rSEgrNC9SOEIxcmZWQWo3emlRY0tBSlF2?=
 =?utf-8?B?aW53OWM0anFkUCtUZ0RtaUlPL1lkMWpSaFN1dGxyKzhCMEhGK1hobjBBQ25s?=
 =?utf-8?B?eG1HellqTW5ueHBhanZ3MndYY3NIOFQzRG5TQlVyc0k4MEdQVFh3ZmYxU1ZO?=
 =?utf-8?B?U2s3dXBLU1U4ZDJ4K0QrbHlBWUEzSWRYakQwdU9taXE0Tmd5Mys5N0ovMnFQ?=
 =?utf-8?B?anpMcnF2cCtJcHU5amdqL0JuTnVKM294TWhFaStEdFhySGcvdVFiMXJzR3Rn?=
 =?utf-8?B?bWhsU2lNU0ptK0VhZXRzRFZBSkpFZVFXUmxHcGx2TjJ2T0hDRjlLR3VLQkxJ?=
 =?utf-8?B?aW5heHJhNkhHcklGbUVvNVlBRVQ0QlNKSFFGdk9WbjhDU3pFeVdocGEyR2xi?=
 =?utf-8?B?NDJlZ29TNFJlZ2gzWmJkcERKejRGRzh4V0JuSVdEWDdadk9wN0dYdFpCOUdD?=
 =?utf-8?B?aWx0a0hOaW1wYUVoOEZkMWgxSXpORHVWVmwxcEM4eTVRRFFzbjBaMXErWWNQ?=
 =?utf-8?B?OFpVQ3B0bWdKeW1BT1k4a2twWHhFZjVFbUg3ZjNRVEtRMkMwbFRVaW1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEVsRmRMbklQNmo5SlVJM1psWnNuN3dXdmFrNWtSdDN1dmpYSEhzTFFnRnFN?=
 =?utf-8?B?Z2tyL0I2UHo4dkZVV3l3Ui9NWEZKTTNUOHgrSUVuK29sL3VNK3Q3Vzh1ampU?=
 =?utf-8?B?anhaTjdvUXVFSHhDVXlSM3M4WElsaDI4NDRZazRBWXhlT1kycEdQcXlHMzVT?=
 =?utf-8?B?R2pvTlJXL1RMRG5oMVoxL09FQUJvOExZK00vMER5d0dzd1U3RnM0VStiOGtw?=
 =?utf-8?B?SHdsQWYzOFRSNFlHdjFOWkc4VTFrUUE4bWg0SS84N1VqbGUzL3NVUCt6bTFZ?=
 =?utf-8?B?LzY1RkRvaEpZMWRaSHdxa1lqdmV1Zy9EamlpVWdWVTVFWGNZSkE3NWlkVjgz?=
 =?utf-8?B?LzdZOU15NlJZR3c0T3R6bG9Id2hoN1Ntak05NHh6RzN4VC9FbS9YdE54aEpU?=
 =?utf-8?B?anJheGFjdUhrMU05SytHODFnYnFtS0U1ZTlBdlVrdXdNQzh2TFVNZEQvV29G?=
 =?utf-8?B?RVk2eE5idjQzS3dNdUhBdmlxNy8vUHVmOG5RUi9DTWJpeWtKaG9wOTRkbWpo?=
 =?utf-8?B?ZFRsY1pxOWN4L1UxWktNQjZGUllKWHdCOHZkNW1pL3BSM2pxWFM4aVFid0Nl?=
 =?utf-8?B?L2NxNnF0NTJFY0dXV1Qzb2ppWDBZalJoZ0NNZTJFVldyMFhTMU1Rc2l4bVRo?=
 =?utf-8?B?a1YvVkRLSDg4MFdLYThvOXBZWDg4R0hzcE4wN2hOVUZTWURqSGZpOEI2MkFO?=
 =?utf-8?B?OFIwTXhJMFJKY3VnWnlaV0hvQzVPcjMrNnNuY3Jya3V4TmZWR3Q2M3NjYy9V?=
 =?utf-8?B?T1dWNHE2TlpuSTg4V1NFU2VOOXhGMFJLQzVCbzEzeG9ZczJvakI4b0xRVjhT?=
 =?utf-8?B?K0hiNDJIZEVqa3JsZDhUWS9IZ0NGbUlFNmtGRzZpUDlyVzFDNE02OSt6T2NF?=
 =?utf-8?B?QnVmYlVNM1Z0enZkbTZlQ2V0OTFyMCtBZFYyREJWelErZTE1Z2UvaXpIckI0?=
 =?utf-8?B?VEVYUFdQQ1QzT0UvLzBkdEZpYWc2SHZEc3hYNjA0MUJja1dJQ3haYW8zK2Z4?=
 =?utf-8?B?c2VmTG9ISUFzMlB0VXBuTHNZNUo1eFY5REl3OHVGZi9Qb1Z3eVpNcVRzcnAx?=
 =?utf-8?B?R0ZLdmxic1U2YVhlUVdqTXVWWEFEM0N5UldrLzdhNlgrSVE3Qm5tN29lbHJj?=
 =?utf-8?B?WmJUQnFvMlRsaG5ER01jOUo0ZG1LeHZ5NkZxVitOdzNNOFhET0tqS0QzeWFF?=
 =?utf-8?B?djFxdk9jdkN2MkVQckFYNW8wZTVidW0wZ2pFRTlhNTkxL00waXBiekVvQWo3?=
 =?utf-8?B?a2tqVlBNcm82YnZ3b1VkaHBUejhBSHM0UThpMVIzUjR1a284MlQxanpybTNJ?=
 =?utf-8?B?NkdsMjFnZFpLYy9iOFplWU10My93NitiTWRzVkg0QytQYUVzM01qWmlXbThz?=
 =?utf-8?B?R3pLYjhacVdKVHV2OVpWcUVPbVlMNmZ5U09OZzNJeStIZmJmMXh2Z1JQajll?=
 =?utf-8?B?RnlGTTZwbWhhY2VVMWdsY3Y5NjI2T0ZyZ0hNT3NVYWhrQklkbjMxeDVUdTZq?=
 =?utf-8?B?dmpPSURXanhBdFBjSzlEY0NIQ2tNczN1S05VLzlvdC9MRFpKTnlVWWhNV0xP?=
 =?utf-8?B?L2Jrc21lUHA0UStaUEV6Z0ZZYWk3SkIrVE5vY0tTam52aE1UUXRSd3E1VG5h?=
 =?utf-8?B?Ym1MdjI4aXBBQ0oxNW9mcitQNGdPM0RjUEVtSHZEd3ptVjh4OENTL2NqWG55?=
 =?utf-8?B?Z1g3ZStnU3VIek5mdjZJYXkxK2w0Yko3MHRONy9ZOGZCV2thbU91V3JkZEMy?=
 =?utf-8?B?YjhDb1h2N09SelpZVWc5N1lLbU5vNkxNcUJ3a3pIN0hWcjZRSXdmUlZsVis3?=
 =?utf-8?B?V21hOS9vV1NqazlyeWw4dCthWE5IZFBCZWlTZzJvNE95OGw1d0hHOVZlMi9O?=
 =?utf-8?B?WGVLd0FCUjczbnR5TmxUczNaMmROWERWVmIwS281UmNmc3dGbW1LcWlqRjJp?=
 =?utf-8?B?UjhydVpoTXA4S2YxL0dvaWh5SjZxU0dKSDI5NGRRSWNOWnR6NVBYL1hja1Jj?=
 =?utf-8?B?NXcxZ2pXRkoybkk0cTQvaXh6ZW5UeWxTTFA5QlgwZjliTG16eE12S3E2VlpQ?=
 =?utf-8?B?MUk5MDB1MjNQVnkyUG1weEtCVE1PSnEyaXM1aUZBN240SEtFZXJzV2ZocU4w?=
 =?utf-8?Q?nTT8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1476663-e874-4bd6-86fc-08dcee088649
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:32:36.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dAkziP3eYGMEMV49Oa+spuagDY3aZblqalPgaKlzQKRGCG9sViP8LOYfCiwFlTJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121



On 10/15/24 22:13, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> dom_data_init() is only called during the __init sequence.
>> Add __init attribute like the rest of call sequence.
>>
>> While at it, pass 'struct rdt_resource' to dom_data_init() and
>> dom_data_exit() which will be used for mbm counter __init and__exit
>> call sequence.
> 
> This patch needs to be split. Please move fixes to beginning of series and
> move the addition of the parameter to the patch where it is first used/needed.

Sure. Will move the fixes to the beginning.

> 
>>
>> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")
> 
> For this change I think the following Fixes tag would be more accurate:
> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
> 
> I think for a complete fix of the above commit it also needs to add __init
> storage class to l3_mon_evt_init().

Yes. Sure.

> 
> The __init storage class is also missing from rdt_get_mon_l3_config() ...

1 internal.h _int rdt_get_mon_l3_config(struct rdt_resource *r);
2 monitor.c  int __init rdt_get_mon_l3_config(struct rdt_resource *r)

rdt_get_mon_l3_config() has __init attribute already. But prototype in
internal.h does not add the '__init'. Looks like that is ok.


> fixing that would indeed need the Fixes tag below:
> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()"

How about addressing both dom_data_init() and l3_mon_evt_init() in a
single patch and adding 2 fixes flags?

Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to
rdt_get_mon_l3_config()")
-- 
Thanks
Babu Moger

