Return-Path: <linux-kernel+bounces-546032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0FA4F562
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5414D3A991F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48D01624EB;
	Wed,  5 Mar 2025 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oeO6CjKn"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DF39FD9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145317; cv=fail; b=MhE5b/ldysCfW+JfECdmiHS1Uyl1oTXt6XzKlCwn2jsmjVJ9lgqjBmFqvOT/WfOBt+uprVSKKVeBEpCHOSyVlohVgcLio3IP/wDMHvzBUkoTisT4g136KSCE/233o+lmg1p78M/orYcJ+1XX9mLC3G+o59uz+oKM3R2OutAyLR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145317; c=relaxed/simple;
	bh=T5S3h9UTV9ULOGC/bYU983izcZzB/hLPvwEd+13MIjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=skb0yMnwC/EXXfd7wHNdavcu6DdWJGuW5YaREG1HIgBXvfqzs7FF8BFw3zc1b6FgIMpthByDXgDSOabl0Q5/ecEcWPdVvG3FAgeAacbd2IUjEwTMVX/Af/t19oq8H5HkrYU391kOlVdcRGXOACNoTQ4YB3XKXI/LD19xE6lqxZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oeO6CjKn; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DudWce59l3b8x7Vy19CRuNcHHrzSozWNORcBRk7Jr0CIg7lvRQxmJWKmFiUpcDOYdhSIy4VTXuPUrqQ4yYnOoZsAUlzbVlWJZtvzDbxcokjlOAcRXEtsAOVX4SaX9hhj080n1x8HIwbhF1UtHHJ2Jqm9jmz6wwMVx6whFWEOqt42CiBeFtaWJNuabAtSEIWHcnEq0vkSR4+xT3x4hYHIDE19lPDGmVkAV1Fc7dq91lylaAeVPNVHCS28+/QN9M77uc9q0hHJ2pVQagmXdgVUNWetIA+UJiuWIcQTmTPNA3LIkrWc7Y8wPMZdOVMom3QrXVXI31obXPLCvcJESJE8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMxy4iKUu189m0GGyHJuCa4xONXLRcuoZ+mCBLLjMUQ=;
 b=InCVxyWGvJJNjY5iv5prKDOEMXJO/W48Lca9KfXyMYt0NXdTDjGJpDrXyylt8fwIMynJcjZZIytMN2g2FRjlcxk1rAAF2iZr6CccZkI3bnt01JG01nKtaVfJBjKcYdy+I6t/Q7GUFsfRa8wdTkdjClKWrfYcvXKBt0dAHWiFVfkDZRaPWGknpfCFpVIT1AEoQGxm+789cfJ5OcYp6wMCAkpolI72KSxvGXS7XqiD0NGvLsKseLGt7mUvXprQ/aQjYiIeuQPc5e5sU9dLxd1TTySHp9kouPtJ/rZ0T5ojYrTndHI7Lt5ljNxOKxm5pjBe4kAKr80UMGRI3g+mxKX9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMxy4iKUu189m0GGyHJuCa4xONXLRcuoZ+mCBLLjMUQ=;
 b=oeO6CjKnTtVIxo/H6L/kQi8gKgy7j0QuSXsEYt/gU/1mUgGT4MftlHOIHIkjeUk2qpiq+IBdQLbonAix8dkAmiLm+i2i60t4QM+U8OlvDs4X9mk2e9pMy0XHwvRW/+LDu6TM8OGo0buhU5Q2Ob5TKB/Uhd8w6uZqaF3Wg04Xv44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.29; Wed, 5 Mar 2025 03:28:34 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f%7]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 03:28:34 +0000
Message-ID: <174083df-94e6-4133-9087-b5d55dec7baa@amd.com>
Date: Wed, 5 Mar 2025 08:58:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1] ktest: Fix Test Failures Due to Missing
 LOG_FILE Directories
To: Steven Rostedt <rostedt@goodmis.org>, Ayush Jain <Ayush.jain3@amd.com>
Cc: warthog9@eaglescrag.net, linux-kernel@vger.kernel.org,
 srikanth.aithal@amd.com, kalpana.shetty@amd.com
References: <20250128051427.405808-1-Ayush.jain3@amd.com>
 <20250304133457.7e8f82a1@gandalf.local.home>
Content-Language: en-US
From: "Jain, Ayush" <ayushjai@amd.com>
In-Reply-To: <20250304133457.7e8f82a1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::8) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec8e8ad-0f69-47d2-88ef-08dd5b95cecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXV0U2IxZUxlNWphTytSU05xNmFHTWpYSXFOVEI2amJzdDFYMmlHRjBRODJh?=
 =?utf-8?B?QUVTeHIyNkp4ZzFGTllKNGV4UWlFdlJZK29xcGx0alRGMkFlRkp2UmV1NGQ3?=
 =?utf-8?B?Y3hXektEblhCdW80TzV2b2ZHUXZWYmV5RlE5Y1lUbUJ4TnArTGJwV1R3c2Y2?=
 =?utf-8?B?cVpraWRHUHhRUW5STmhLbnF3UzIwOGhGOGtBeVJ4THlQNmJ1YmQvQWxLaUd6?=
 =?utf-8?B?K2JtL3FjdUs0Z0FsVGdtVXFiNHFlOHlqelN0Y1NvU2pyRStTL25DRk11MDVQ?=
 =?utf-8?B?SU16MGdjMUhqelZoeUljdG5vR3Rwc0tkRWpZUXliT0c2UnJLaGthVDgwRmxF?=
 =?utf-8?B?SHJTWklsblg0bXpkNklWcmxhd3hHT1hreFRHVFdiT0dBa0gwRm1QSWlKcy84?=
 =?utf-8?B?Szh3K0xtSzJ2WnlBVG81NXpNSDd3SmxhRGZUelVrYk1MOWFPOE9rOGFqdE9W?=
 =?utf-8?B?aXJhVS9WUjV6WDRTY3lmamtrc244Z3B0cDJaS0twcVVTNXVTZnMxcDM0WVdv?=
 =?utf-8?B?dVVrOXFiaGJGWDdtcy9UcFlGODBxa28zVHc0MS82NnlHSEozUDFxclpYa1U3?=
 =?utf-8?B?bmRkY1QxbmdsY011ejliVnpBN3pGcFgxMW5Wb09CcGxjd3pQb2xlaEs0V1Bw?=
 =?utf-8?B?Rk1LYmEvb1dvcGpLZ2l2UnRoR0lITkl3ZmtQZW53WS9jU2ZKSlRMSzdGS0di?=
 =?utf-8?B?WEVjancrbk14OHRkODQxOHRhTHl1eXRQb296ODlvK3JtbXBaVHAvVEJNVXhz?=
 =?utf-8?B?NXpzMjNGZ01iaXlWY2pqUTNZa05tZmtkYlRINmhuM0JOQjVSWkJ3dGl0MVB6?=
 =?utf-8?B?RHZrWENIbEtHWU00aitEbjR3MzExOEk5aEdITHoxRDh0c2NpYVFuUXRYVjV0?=
 =?utf-8?B?M2xDQi9qeVFUTGtWbVpmL2dHdnRiSGhQbk5SNGNqbFRlUk5kOFdMTkZsU1ZU?=
 =?utf-8?B?TmNXa1BzRWJ3eHlVc2NXV2h5Y0Z0NlE4b0MycFM0N1BMWUwvb1NocTM2YzY3?=
 =?utf-8?B?VEduVHMrRzZTRFNtWTBSanExT0VWRUkrUWRyKzhQLzE1bGlMZDhLcXpDb2tu?=
 =?utf-8?B?dUJGRytZa0FHVFVBeEFvcmVkaDhHbysrOEcyb0s2R3o3T1Nhd1gxSjNFc2pW?=
 =?utf-8?B?QnR5eFllQVVOZlE4aXYxU20rZ0dRc3pCTFpidGczaVVpeGJzRGFTczFvWkZ1?=
 =?utf-8?B?ZmtaanM5bzdKeU9sK0VveGM2M0RPdERzbGVkbFV1SUlKZURkQlEzVHBCNDRu?=
 =?utf-8?B?VHJ2RE13UUYxTVkraXNyL3RlcVg4Q2JGS2d1SnFoK0U4M05sUjhpV2Y1S0N6?=
 =?utf-8?B?cFIwZVVNemI2a0QyTXk2NFFRSko4YUFlT1RDeWRYeG5nNG5CSVdlYnJCVHk3?=
 =?utf-8?B?Mk41R1NJTXd3eCtWd0RpNU1JU0szNnJTWHNNNmZCZnhqbDV2TVg0dGlmWVBz?=
 =?utf-8?B?Ui8rVStuZWxZSzZtenJTQm1DNXJEQXRPZFRCWUNOM2YxYzZNY0J3ekd0UUFT?=
 =?utf-8?B?K0I5VlVxMjRxZDVPMFViVkVVaHNFby9LYmYwcW1ueEJreEo1L01iYW90SjBq?=
 =?utf-8?B?Q3FoMnJXWEFONmR6MUJYM0gzSjlmazU1cnBsZHZqUWRub3pwSjdIR0VQOXUx?=
 =?utf-8?B?UnBTK0lHTHRTUGF3dWY5SjRZNVNlZjFmSGJ1M3JoYmQ2OTJHckJSVEJYT2Ix?=
 =?utf-8?B?dWRpMDlHd3NXczB2dDh1TnhpdnRBWUZiQXRrSzhSNVRZMCtUSkx4bnBXUFhk?=
 =?utf-8?B?SlJSMDhkYmVzUlRwSXZmcmJSR3VtY0JnUnE1a1hoVDhhZEtXY3FQTFVHTVlo?=
 =?utf-8?B?YklUU3N2TGJhMFR1Uk8wcStETWFVTkxtK1BEY1o3Wi9RN2R5emYzRjJGWUtC?=
 =?utf-8?Q?0CnJ2h9Iw4HD/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGh4RW93aW9qaVg1b09reHQ5MTJ4Vm9YT2NWMmMvZzhFbGJFbGlxQmZ5ZUN5?=
 =?utf-8?B?Sm1rVHdoRmRTaUZFUUpKL1FDQjRRSWFybExJSEMzU0hyWlU1NEZadC9zeWg2?=
 =?utf-8?B?b0g0bVlnbW0xVzVybGR2cjBjZm1XTEs2eVVBay9DcytUSEFMbWJDSkk2WjRr?=
 =?utf-8?B?aDNwSE9HNUFnc0V1MjhBUFhmYkJmTHZMUDV3Vk5pUWJwTUJyNnNOanovOU9p?=
 =?utf-8?B?NmZydHFwZGQ1L3p6NSt0TTVUY2kyOGFrS1N1ckVyeXdPOXN1ZEkrTCtVMzRO?=
 =?utf-8?B?UkZDb2hsQ1BqUXFNVktPK05XVkRJMzN5bEl4R3F2MTE5TzNndGc3S2JXZ1pZ?=
 =?utf-8?B?V1BnTE9TR0tRd2RqTGtYNE9FdFpzVXVEVHRUTGg2bjlKWVhtNE5ZZ3J0SURO?=
 =?utf-8?B?OFNKNHpORFRZWitxYnBtSmo1WUwwQ2ZVR0JrL2lGUEJLbG80aUoxY0dkd09H?=
 =?utf-8?B?NWhOOUtxdE45d2wrK052QXlnWVRCS1RSTTZ6L2c3NkRZSUJKMS9TQVh2czlj?=
 =?utf-8?B?dWFDUjAxL1hVRHVMRklnQ0wzbjZYTEdCQ2plOGcxZ3JZS281eEJ5TFBKTjE2?=
 =?utf-8?B?OVlMZ0xldWo0TjlYSkFGYTg5d3ZVSFc0cWovVlVWbWZibjd6SU1BWUptbENv?=
 =?utf-8?B?R1NEWSsxV25lc3ZUdXIva0FJUlR1ejJ0RE5wQ0M1K3BCYy9BcDNFd2RHQUFn?=
 =?utf-8?B?YU1UN2VZSU04ZDNxRExIM0Fzb1J0MWtVOEllNkx3NEhSWFNXN25Pejg0SVZy?=
 =?utf-8?B?N01zUEVvMHFUZ1BtWkd4aTFRaUxYUmUyVTdhdGpSbkI1SEJBSFVob1hmdVpY?=
 =?utf-8?B?STdBWEIxQkx2RnM5ZWl6eFhPTnM4QjdrdUx4anptaEJSZk9jWDh4VlVheE9w?=
 =?utf-8?B?M2cxK1RJMFUwMkEvWnQxYTNWK1RxUzY4QS9WckVBSUZDWWdOMExGTTFkckJk?=
 =?utf-8?B?djVhZTJzTWlobVRHR0hpbiswUS94c3pseGo2OEtqS3F6VXhxdnMvSWtvejUx?=
 =?utf-8?B?VE8reDJVQ04zT0d5Y0Ywdm9PaU92QnB2MDU2YmFSc0YwLy95UmRqQWxOcjNH?=
 =?utf-8?B?VjZXT0dZc3JBWktWaUNybU1Od3dTd2Qvbis1VDdLM1FIZEFzQmlubS9FdU41?=
 =?utf-8?B?ekc2TlcwTXZCRXpqK3QwL09xREh0ZVM1MEEvT1l4MTZrRVdNVFEvY253Q21L?=
 =?utf-8?B?SW84YlJ6SDZxQXdJVHh4WTdUOElVeGppRE1ZeWZLNklLdlhHT3llVStZS3FY?=
 =?utf-8?B?RGdxMmNWTDI3KzErWTJOQW1uMWdtdFZUY2FhMVpVb20xYitTY0tXdzNLSkFK?=
 =?utf-8?B?K0FnWWozS1Joa1VyY2RicE5XNkdTK2hKY3l5RmJjNVBPTkdCcVBXMEMwYjVp?=
 =?utf-8?B?KzhkdzNpUkliVHpDb3NIbDhRdVltcnNHTkwyVWM3TTRKYkpzT25PdWM5dEQx?=
 =?utf-8?B?Y3hUZ0J0M2YxN3A1K2FRbTBBM2xLSTJHYVl3c2ZkajUyNis0MW5iVjA4NEVv?=
 =?utf-8?B?bnN5aERadVBLSFRib3BFckpFbkhWeEJ5ZnlQSkxyZGdaVm1WN2l1cEZZMGRS?=
 =?utf-8?B?OEV4RDBOdTNnVTU5Q1c2TWp3QlJSZWw3aFBUamNHTUpkSlZ3YUtubVRtWnRI?=
 =?utf-8?B?RGZjSzBzeFcvcE5mSzJ4SUlqZnZVR2dvampTUlVmT285QU1za2dLZ2hvWmJo?=
 =?utf-8?B?c1FkSDBoNUxNeFJCcnJyQ3pudUU3dHdVOEZaYlZpaTg5UGtYMU8xVjRzdGlV?=
 =?utf-8?B?N1dPdEF5cjhEenJrcGhQNDJVS1ZiajNJZTFPVEYyUEJOVGNxYlZPTGhEcmlE?=
 =?utf-8?B?RmU2UEJleStKVXBNVkxGYUh2eG9jRjJIcWt6K2N4Rmk3cXJHQ09MNE5XWk9Z?=
 =?utf-8?B?dVpEQm8xUlR0THE2OEFjM0hpT1lkRzNUVTJ4TkdwR2pBWWVlNEtQZ2JaK1JI?=
 =?utf-8?B?YllMT01zNElIMjd3M3dmM3Y4Mno1UnBySTk1S01Fdm1zVXlBL3FoVHhTV3J0?=
 =?utf-8?B?WkZ6c2t3eHlKcWV5amFnWHJCUjFRakxVQWJGcW9ta1p3M2RlaE01a21lUHcx?=
 =?utf-8?B?eHRJYjNvbzdLTEdONVdZNDd6OEtYbGl0bXFpaWt2dHVDeStGUm5zVHBxQnlH?=
 =?utf-8?Q?o1KvNnakchEPlvhqPV1t70S0/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec8e8ad-0f69-47d2-88ef-08dd5b95cecb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:28:34.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79Ch4bAGXtOMVl9k23B00VtyLTq5qzRa/55MsHEAohKay1f5N1ZwRKqQT+7kjfsnJLRh9z8OL2nZ/OOLzJ3Tjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192

Hello Steven,

Thank you for reviewing,

On 3/5/2025 12:04 AM, Steven Rostedt wrote:
> On Tue, 28 Jan 2025 05:14:27 +0000
> Ayush Jain <Ayush.jain3@amd.com> wrote:
>
>> Handle missing parent directories for LOG_FILE path to prevent test
>> failures. If the parent directories don't exist, create them to ensure
>> the tests proceed successfully.
>>
> Sorry for the late reply. This got lost in my inbox.
>
>> Signed-off-by: Ayush Jain <Ayush.jain3@amd.com>
>> ---
>>  tools/testing/ktest/ktest.pl | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
>> index 8c8da966c641..be707cbc56a7 100755
>> --- a/tools/testing/ktest/ktest.pl
>> +++ b/tools/testing/ktest/ktest.pl
>> @@ -4303,6 +4303,13 @@ if (defined($opt{"LOG_FILE"})) {
>>      if ($opt{"CLEAR_LOG"}) {
>>  	unlink $opt{"LOG_FILE"};
>>      }
>> +	if (! -e $opt{"LOG_FILE"}) {
> First, please use the same indentation as the file. This isn't kernel code
> and doesn't use the kernel indentation.

Sure, will take care of it.

>> +		my ($dir) = $opt{"LOG_FILE"} =~ m|^(.*/)|;
> The above has a lot of Perl shortcuts that a normal C programmer would not
> understand. Please convert this to:
>
> 	if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
> 		my $dir = $1;
>
>
> 		if (! -d $dir) {

Sure, will update this in next version

> 		
> Thanks,
>
> -- Steve
>
>
>> +		if ($dir && !-d $dir) {
>> +			mkpath($dir) or die "Failed to create directories '$dir': $!";
>> +			print "\nThe log directory $dir did not exist, so it was created.\n";
>> +		}
>> +	}
>>      open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
>>      LOG->autoflush(1);
>>  }

Thanks,
Ayush Jain


