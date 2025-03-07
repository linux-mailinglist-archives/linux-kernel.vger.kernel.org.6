Return-Path: <linux-kernel+bounces-550324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E40AA55DF5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910EC188C53B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DAA140E3C;
	Fri,  7 Mar 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IJlNxyLh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58554673
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316419; cv=fail; b=mUQufg2jS8nmwcZWvNI0cwXaTB+2AZSGpD2qDrAa6MgS/y6112CynI+OFCqxVDlrkp3KnhDCpNqexmPBOmoLFbxlNZ0Zb9KoY/b7/q5HBMDJpUBxdpXsoMMeZpQSKDQRR5VgH4RuZrMLi8bkGnneY/kPSZ4DmaV4mRlVIeIV5IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316419; c=relaxed/simple;
	bh=QQuEAx4LmK7ItErHMT76pr3KNwZPGmuRfSRe70cOjRA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EQdvwWUJz+uGMJtprVIcS7lsldqjWCGmRRQ2WeBM16T5KN90ngBOV9beqeFOw0NUi5+PPtwA2VZ8gz2hCxqmLqTkzLKwAS1KL15t0TIeSkjvHkd/dbh7JzgxSxU2EtWBkQdD6pSgeRw6mLOjDhC9nmsC86YHcKtjraX2E6zUqAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IJlNxyLh; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyZNCAnc+tN7Z6TqoeSHigqJebRo6Jchje9b5fVRgvbh0s/yiwU4Z3cXvxQofzDJ7UVLMgw3PDdjKpaEWinC77D7ojEcxANmJnVbkJ8mEmqtsuSDkOL6O4nY+GHQW/qz+omS5PEfbPziUnB0i6/UagD++0Ee455etTOPWh6RyaxQnTXqDlRRi/v1rA36bK+SWk0HVN5bO9wcFqVDju9ubqcbI1oXbHpORiC2Ar+xCl+GdDSwah5gAIax4YFQViENduAVpVuSC78kWcw1Nj903NAUgTzi0NtnF9udh0wC8JjCVPWteHQFNKwPoTxZmwMj8c/pyEDJHQV344nLW9bPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1mY5Jx2urp3PM980gcqNCO+uw5J+kBPxnkSJpxOYNM=;
 b=TLcEMgtjgYvZD+T/gkg5scpQGlHrROUo7zxFD6Rg4xVw3Kc0i5FZCWxNgx/cIXhlcssUHyqUnLFnz5oJso1geNlz5POXCMPIowYLuZ4mV6AgMz4qprtzWLDHVg47BrkguZS+NXci1j1wPqjKLtY6Iz7/K8nB6Njp8DtGWB2k0Yo1qb2oK4cJVVaK17gbPHcupMEH96sM6dKU/cj931ShCHksKoUzlWS33t1JXffIoveRhJ3JQdDUczLUaEyrKcydseQqJ+ZwW4qilbYN/75rzW4JSxW98i3EJ1+DyG5j3zM9Ryld0daIEmhFQeRvEVfp+G3Of7JzpF4XL57m6UbSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1mY5Jx2urp3PM980gcqNCO+uw5J+kBPxnkSJpxOYNM=;
 b=IJlNxyLhOhP1qEaZEAspSEmTByPUpVmySOWwSW0HDm+XsmxsCVuMHdOBdpz9cjOAkyhcZV9aOXzFI13tPaTh233abyZChrdFG8Ok/cB/esKljqEGa9D7AzSa9SS7MaF+kEQFOiE6hTs7DH3RbKGvihVPdaIYpfCITTPE3pifC0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 03:00:15 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 03:00:15 +0000
Message-ID: <0bd9f76a-e2cc-4dc1-b694-4ea2d229785e@amd.com>
Date: Fri, 7 Mar 2025 08:30:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm: migrate: Allow misplaced migration without
 VMA too
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, feng.tang@intel.com, gourry@gourry.net,
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
 <20250306054532.221138-2-bharata@amd.com>
 <2ad7973b-9d92-4b34-8534-73ed1164a1c8@redhat.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <2ad7973b-9d92-4b34-8534-73ed1164a1c8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db0e85d-1bdb-45dc-60e8-08dd5d242f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2JmV1VlZ0o2SHNnYVhlY3YzNkNNakhtVVpLR0xVL3VOd0FUU1hDSHYzM055?=
 =?utf-8?B?cUxlUVRsLzZqL29CY3V6UVFuUjFVbEQvK2d5cUJMZDNqbm9OdWdtYlh1YTIx?=
 =?utf-8?B?aWw4U0hmakZ5SUllSWsyNXhNeGxIMWVqcGFMSjRiQWJneEZtS1piRUJJWWVK?=
 =?utf-8?B?RnMxMDBLVmdidVZqdGdVREVTUFhBZXIxMHpnSndSZ3JWNmpGVUlXZGpEQ28z?=
 =?utf-8?B?SEhVNnpaeDg4TWY5ZFFwcDNzcDRUN3FCQUxIQUlKZk40NUJnN2ZLSFBsQStm?=
 =?utf-8?B?OE83QmNYZDR5UlN3M2VDZG5TS0p0d2RJcjA2VEFUZXFuOEo4RnFuQklmOStP?=
 =?utf-8?B?WVNFaUprQ29FOFpZQzFoT1BKdFFvNUN6dlRqQ29zbzY1Tm5aanJJRVMxem8v?=
 =?utf-8?B?Y2RuOThwbGM0emdjWVdYWVRMTXVzU2pPY3BMSVA5c3BFNmZtMzRyRWxlcEZM?=
 =?utf-8?B?OUdNRlNCZUlZcnc4Yi91bUVCbWdhUXZPbGJpZTBSMWtwT1B3cjk3RkZESERV?=
 =?utf-8?B?QlhJWHdsN2FjWU4yY3Z6MDBiMWFMZlpnQVJHdW00akM3dWJlL3VSMzBpbnNO?=
 =?utf-8?B?eTV6eGpydDMxRzBiSllvTVBCTHkwb3dSOXp1c0lmVVg3a2krL3NMa0VVcm9k?=
 =?utf-8?B?elJTTk1aK1c0b1dqMmJMcWVmVzBGTXcxVml1TDV5L2FIbDhMS0tEbFpFUDJG?=
 =?utf-8?B?OUovaUpRYWJoZGpBSGdVYWZ0bmUxOWpGZmZqd0p2c1FHdjlGMTZycm9TOWhh?=
 =?utf-8?B?T3B4UDFmTXl5Z2xLYUhpVEcrbXBFYmhmb2IyRHRhOTFCN3JYeFdVOWMzTzNL?=
 =?utf-8?B?d1hOUHU0Z2MxZEVEazF0STNJdDdGUlVlRDBmdElaNmJROTdTbFBpOHk1eWVL?=
 =?utf-8?B?TU13RHE3MFJ4a2ZjQTlESTVxblI3aEYwa1o3cXVLYTdacjVUN21SOEwxQjJn?=
 =?utf-8?B?VzR2Ui9hcW9lMWJkRXdNTEFuU2xuZ2cvbGlITURaM1dzR3NYYUFmUzhmUVRa?=
 =?utf-8?B?UFBGWks1SGlVYllxZUR0ZU5odkZHU3I1cUZPK05oSWNwbFpJV1VhRWRpNVJ4?=
 =?utf-8?B?YUsyeEtKbkYvNHE1dm93S3I5MlBvUVJBSTNBem0zZmI4QUFiNFM5M1R0b0JP?=
 =?utf-8?B?Y3BSMWU1cUR3a2hNVHBjaWtSaHI1L0ZkcFh1N3BqTk5vS3lRL3RWWEkvWEtM?=
 =?utf-8?B?TEdRRzYwMUYyVGtUdWltbTgxUEJlcHg0TGtIaGg0aWN6QmV6RTJCem9UWXNH?=
 =?utf-8?B?b2FBcXVmS2lIMUoxQnFiLzYrNjl5YjY3eTVyU1JlUEJQUWp3MnNUWWwxR0ha?=
 =?utf-8?B?UFFjNWpZamI3RWdDUHpXR3g0SW1oT0dkL0xPb2IyVFh2aEtGUHdHUFhLMkVE?=
 =?utf-8?B?VjNlN29yc0NCU2ZhZHNPbTliNEljZER4Y3BrL0VwWldiTjcyK25aVWF2Vjhp?=
 =?utf-8?B?VnBhT1FPSHNPNEF2WE53VThENk9JY2tjSHAyejM0NW45aDVMeEZFQmVSYjdY?=
 =?utf-8?B?ZWFpSUROOUNLeWdMNXhmK2NpYnN6bktwV0ZZZXFHWitNY0dtMzRsWEFMVU1k?=
 =?utf-8?B?Mm9QYVVOcjA4Mjh4eFgzNjNQMjY2VXVpM2FBci9FZzFZdEdSVzBqYWQ5d2ts?=
 =?utf-8?B?cU1ZREFReHplY1ZIZVl0a00vUVBTakRkUU5BRnFxWnNMOFRramM4Qm1RcTNl?=
 =?utf-8?B?ZXRUbnVlN0VoTVA2b3BMM29iY24zVzhsWm5EMDl1R1I2d3NnRndJKzVGVkdy?=
 =?utf-8?B?d2lwY3hXZDEvMHpVT3VBL0JZdkU2MXJoRHA3RnFsZTR2TGc2QkZmT1BHMVh0?=
 =?utf-8?B?L3JaNGplL0I0bVNoV01WMTNLcGw4TU5aMzZ6aVAzanduSjd3dzU2ZnR6cmZ3?=
 =?utf-8?Q?XHQFfRjAAi0/B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjNTZnZuZWQyZTBQODRMUHhEMzVIYzc2TDUvRFJVNE5OWkRYNGtQUVhJWlky?=
 =?utf-8?B?NFNGOEM1cWlkQ1A3OG5BVGF1NHE0UjhkOEVNa3ppV3NjSDE2VEg4dWkrRngr?=
 =?utf-8?B?dFF1ZG4xTlJBdlRoRURpT1RXbnNVRm1XeEZHbXNtUldnU2VIdVhoODJCclJY?=
 =?utf-8?B?NkpPY285SDZRdXhCSmdOOGQ2SmEwUU1oYzVDUHcrMkdidGRCYXRBUVFuZFk2?=
 =?utf-8?B?WW9KbFNvdVNSZStiRUpCR0k3cWRLUUhlbkwxNWE2VFZPaVQ5NEVlMzBFQUI2?=
 =?utf-8?B?NkV4WGFrR1grUjZMWTA3a2c5eERCRUppVm5RTlpwZTg2Mm9sMmkxbmRpQ3Ar?=
 =?utf-8?B?STY0dGxIQXNtVzZCNG4xUDBmY2VwNDBzUWxETkJWQmtGN3N2OGErcEYzZy9z?=
 =?utf-8?B?dXNpWm9oTmcrUnAxbDFBTW1ZM2s2RGVaaGprWDJheEZHa2RQUDJ3cmRsTDJ3?=
 =?utf-8?B?MDZSeEh5Qjgvd3JUaFJXMVFjOUtXWjM4dmFjYUw4Tks2S2V3dUNrL0QyVVU1?=
 =?utf-8?B?bUsxLy9pZktBemM5Z0RYazhPREVtUW1XUTZVeWdmbHBtcFpFaFhTamZXTHZL?=
 =?utf-8?B?UVRhYVBkNmhKZU1PNjlWeTRDVjUweG9xenZrZDNwbVplUnlhSTBlSm5UMU1X?=
 =?utf-8?B?Z2NGNGYrVEtLSEVBK3pqeFlicHpOa0pNanl3emZjRld2Mm9CUVJQNDJCSWF5?=
 =?utf-8?B?T0dyMGl6SGlFc3ltYXcxY2xYQjFCVks2d2MyQ2xQNEJjQ3pmNzgvUzhxbXBa?=
 =?utf-8?B?RU1lb3pzYWpvalk1c2VBNFkvYU5lbEVZaE95Z3dpaWQ4RWdNTUJCUWFoU0hN?=
 =?utf-8?B?dlM3SEJ6VS9SNzQyUGFNVC93OHFTQktyalFQSTNtNEJYSG42SmU4UHdhNWlF?=
 =?utf-8?B?eFptakJpSHF5S3ZUcEwvaWQ2cGtOc1daZW5VNXZZUFFwbC9VYXFRdCtmalpK?=
 =?utf-8?B?NzlUUWsxWXIrQUtzZFl1Z3JEcE4zdXdQOUM0Zm9WZ2cxZk1CbDRJMDhONHJ3?=
 =?utf-8?B?ZXc1Mm5PMERLRG85em51Si9JQmExTTIvOHhPK3ZQQURpRG9CajArMjF1ZFE2?=
 =?utf-8?B?T3gwK21wL09hUkNrQ2plbUhrSG5raUEyS3p3RFgwRnd1RUtuK2JhZGhmQ283?=
 =?utf-8?B?RG5oN0c1VVFKU3pIdWl4RG15MUs3V0NLVjFYeUFKaCs2dnRDRC9MTHF1OUVK?=
 =?utf-8?B?eXlMVlV5MSs1ZmxHQTNJc2RxWGg2YkFZSlVzcEs0d0NxUmJOck5BeWIvVUND?=
 =?utf-8?B?d29iRkV0a05hU21yZGROYStKNWtZVDkxblZLczhNL1puaHdqM09WaWNKWGR4?=
 =?utf-8?B?RDVnYVVtaUZnb1diaUZNWmN3NzAvU3ZVSDJpSzJTUjR2Sy9Rc05Za0RwMXJx?=
 =?utf-8?B?UElrOXZBSGQrbUZ3K2hKcHdmNXA2TGxnZVNNNkcwV1p2dGxtWkU0bFJBWVR4?=
 =?utf-8?B?YWhXWFY1ZHVSamlaVVRtZXJuaGV6RXBDRXB6bzFPQWZyRW1pbXFRbUJjMkdV?=
 =?utf-8?B?NDYrMitDdTRxTkRPa1FZNkhjbVk2K0xvcEdVNjZDWkhVcWJPVlU1YVpqN2gr?=
 =?utf-8?B?Nnc3Q3p6TkxsWmFuenQvbDhEeEtKNnlzaThsdzI0WFRmOEFVMVYydGptdTdh?=
 =?utf-8?B?RU9tNVl3L0NSNjlrbjR4UVcyd1MxY1VTa2xsMDFxTm5zL21CdStHanhidFQw?=
 =?utf-8?B?aWt5VExWY3dWZ3VDRG1ic1pjeGkvU0w4ZXJkNm1kUThGV2xzYSt5emxRdUh5?=
 =?utf-8?B?eE0weUJvQXZCNEROZWdSanlPMkZHcVN5aFhJMkVJaTgzT3orbk1tSktYWkRD?=
 =?utf-8?B?NzgrYUtHOTdFYTY0RlZncGZ1UHY3QlZaVFVjc2s3dXFiRlR4Q3dpK0wvQUYr?=
 =?utf-8?B?VURzQlFkSkpsc0hHNmVzenduQVE2OTk5Z3lvVG5FNmFNeTZyQUZCUUdBbzdZ?=
 =?utf-8?B?QkU2Q1l5dTc3Vi9TemtXbUl2WlBTejhpU0dtb0ZVKzBCMnVVNVlwWThzVGwr?=
 =?utf-8?B?dFRhQVE4amQwT2ZHeEVGNnFEc1U1dHc1TENMVExVcFR6dEZiSUVOOXRlaUxs?=
 =?utf-8?B?d3FLTm4xSENRa3ZPOWxjNngxQWlLTEdYOG1LT080VjBOWTV2dDNxMzZZV1A4?=
 =?utf-8?Q?NMSIXlSs3fpRpU+lld3FMIQjM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db0e85d-1bdb-45dc-60e8-08dd5d242f08
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 03:00:15.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8N/AJcC9fknpfctVY+QSoc4hK8GJ38DLKMGDXzOqRcl8NxUFkfc1omCJIZMR1ASfIs6UcYCUAfGyYUIO2Uq3PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281

On 06-Mar-25 5:43 PM, David Hildenbrand wrote:
> On 06.03.25 06:45, Bharata B Rao wrote:
>> migrate_misplaced_folio_prepare() can be called from a
>> context where VMA isn't available. Allow the migration
>> to work from such contexts too.
> 
> I was initially confused about "can be called", because it can't
> 
> Consider phrasing it as "We want to make use of 
> alloc_misplaced_dst_folio() in context where we don't have VMA 
> information available. To prepare for that ..."

Yes, that would be the right wording.

Thanks,
Bharata.

