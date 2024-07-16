Return-Path: <linux-kernel+bounces-254012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80F5932A24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8452888BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA2A19DF92;
	Tue, 16 Jul 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sgfExpUn"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536154BD4;
	Tue, 16 Jul 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142814; cv=fail; b=SKRQKhIgnkimVFu3BCi34RsixdwXaV/1RMxI3iyyCRFV0ARGRSmuaPy0yS5jE0g0y7Y0j13bTB+BThKGBDUeT4PKvREwml2piMWEuKPxXrp71Pnj9dmHWaKfUOhbG89l7npy2GbhdliUvt23iMw4RPgq+Id5V2ipLmIKl3LYWyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142814; c=relaxed/simple;
	bh=4uMJRZQ0gqxOiqor0HC4VdytZv5nRw4ZXQK2g0gu9xw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TmYzFX7dsqGuN0ARvj4mYe7vjXVdXRC14wybx2obCJ/O7zkdCUwyQ679ajj1qkLZ0VgIuYeG2NQEYeY18mBiqpXn1eduBEfkbNz/052a9/kjKlQZO5++C+pPCoJ28mt8nT9V/sBzPiVv7anfAgQCH/QqMWLvFCCUHwEBvfKRXSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sgfExpUn; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0JIqpDrQT6D8GIH8Ar9bPdW4ni+zOJygt9ArfI/irkaAxu2lu5PsBUZ/OXRlW0CG2lGuM+DBCqiUBXlA7/h7IjkREI11pjsOPAGgnnVxcsJcFcIGwfQiPgpLUfpHFu/LEeWKi6PZMaZI5rjFiEWagUf9KJR/DzMoXkDU60HGjp6K632fQLWODd/VPw8gRWpYPPQv+diIlCm/k+3zTog8N0pv5u2excPXtFguTKrIOPK8Ve2HegcRFlVL8Roo/aJyiNuKi60p5o2kU4i25wU+UhWL8A4XfOEI4SkR93gghXHX7YKVKr+LnO71mpA0I3BGzz+oAJrzQ0pV4lSA+8sQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UleHPjWapXSHdXLDq8IzRdWjRwvbR7F3Kt5zwKhX6E=;
 b=jhQrXeDHVhi1QMK5G1oDS8RfBsIjnIge+vqZsxuzx+gCwcwfL7j5N2b3edWfpKZvl4vY4k4JlTrN2VmtkKNP4GQJBP5YYNh0CN5egY4GG+pMgZQKOPrwCKWrRAiwhfFlH1jleua7iCARM7MSeJcJoj1M/PfpsHRgjwqcC3MuZUGwTJz6tSWC/HZKt4tjCPxs2Y0DvUvwgAfT7pRJCjS0OVEV7MXc5peY5cl2f8dGEvWdACMat12rwweGSediFrSrnbPXiVGkGiWk6dThdyaTM+2tR3RclLb665aZUCCN+ClEtekb1lz8xZBRzPorrBbxnDmis59Q34wZtwImi1/exA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UleHPjWapXSHdXLDq8IzRdWjRwvbR7F3Kt5zwKhX6E=;
 b=sgfExpUnz+WtWa+e4yyqJdmgLBTU2m54a9Mz3hlyIXNm4T2Q6nCpzG7Jx7g3RWJWyFNdyxy6/1ZDdYRnM0UEZfDLoIzGSz9qLxpS3rflCPCl0yGv6Ape10hdZUaMeWYde8R10ZI2XR4JgJ6A1vT1wP7szt3soEpq8mKsrg4lgpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 15:13:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 15:13:27 +0000
Message-ID: <706a061d-c9bf-48d5-834c-67ae1ba4729d@amd.com>
Date: Tue, 16 Jul 2024 10:13:20 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 06/20] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <ed24fa5b599d6f0abe53a72613f7afd2dc9aeb1c.1720043311.git.babu.moger@amd.com>
 <ca8c5934-c531-4d5c-a765-8722e0eae5ba@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ca8c5934-c531-4d5c-a765-8722e0eae5ba@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:f2::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e79ff81-77be-488e-ff86-08dca5a9d828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmtiNWErdlNONXpSQmozYzRVRG42MEpoSnJTTnVjSDFDa0JmUGdqMSs1NlJw?=
 =?utf-8?B?eHlieHB6aTlnd043M2dtK3FsdzdYTjBTREQvaXpkZkRpYzFCdlBwdmRheDZs?=
 =?utf-8?B?a2ZwN0g3MVorTTM3Rjczb3ZFZWQrYWRlOC9xQlJXUitFNE1ld2JaaGNxZGZm?=
 =?utf-8?B?ZUZFb0hqQ25aL0IxODlEN054Z25Va2VEWmtucHhiM1dibEV5M29nNU9qbHlQ?=
 =?utf-8?B?MTF3MnJreUpNcjlGVjI3b20xUjRXaHcwQ0FNbXFIR3hRQTU0RFhyT3ZHaWJp?=
 =?utf-8?B?NERpaDNNbWJvU3pOMGRhSFdESHlwbXArVERvVXFCSzA0a2k0eGZkYjFOVkZU?=
 =?utf-8?B?V250WlNsOWF5UmdIcUNnQVJWRmRBQnZEOE9UUE9CbzJuWHowZlhUblZUMS9m?=
 =?utf-8?B?RnB4TmtIeHRZbER2MkdBaEZ2T0dxaXlEUnNIR3lVUkxBMUFOQ2Q1S0lSZHJ6?=
 =?utf-8?B?QUlBTUUyTjh1a2x4bkFMSVhYMzRkZW9pdWtVaHpKamp0UEkwNGxIclpPSXdz?=
 =?utf-8?B?djFjMmZpK2o1MVVpcDZOV1g2SmZTdWdia0x0V3B3VFhqQmZRVDBuMS9BSHRv?=
 =?utf-8?B?Z1NGT1h4TkZ6MGozV1V3UXZML3QyaCtyVGNqN1ZzdUducnFuZnFlb3BKa2hq?=
 =?utf-8?B?TExVZDF2REZIVE95OFU1VHUvTElaMGJvcC9LT3ROVloxNWNlSW9vbytOVE9k?=
 =?utf-8?B?OVFucmhsS1FKRVlqaFZia29nK2FQdEg2ZzNmQ1A5V3dHSmoxamdlY2ZIM2tV?=
 =?utf-8?B?d2oxOFptNUo1VUhEQk1XV0k1dDVBV2ZRdlhJZ01NbUVicFIxQ1hWU2F2WnRh?=
 =?utf-8?B?S3FXZjN6UlAreHFCaWc3TUsxOHRmdVNrVVgrNWhXZ1lZMzhUUkNiSTZtQ0Nk?=
 =?utf-8?B?ZUY1dGEwMkc2MEcwdVBwS1Q0MTZtOWdjcXUvWUFuYk5hcUJTcVkwdzR1T2hj?=
 =?utf-8?B?Nk9pdGxQdDBkckc3amNDRjhsMk9ZVjMralIxZXZTeEEvK1d0bVcybEM5d1JY?=
 =?utf-8?B?U0QycjBXaWNXWndoVUwrK3NRdHFPYXd3V0E5UGlYWDEweTQ3R0FmaFdWUDF4?=
 =?utf-8?B?TUhCdFQ5QkpDS1RtVEROU3hzMjVUSHA5Z3BjaDhmdXFzdXA3UzMvdzJpRWMy?=
 =?utf-8?B?ZnhNVXg4bTNZODBJUGpXMVV2UzhJcHZ3cm9YRDd1a2NaRlRXN0RmUWYwdGhF?=
 =?utf-8?B?ZE52cElZQUx5YVdxVmdPSHEwVTRyWCt1dDkxRTdNL2ZJNUtDY0g3cTQ0Rmlj?=
 =?utf-8?B?RzEvMXRmVDQ2VkRjN3JocGYyVWhuWk1yVllSYVUxZVBJVjd6emJiQlRTUkVB?=
 =?utf-8?B?TEdiQXpGV0NNNDZCZFZRTnA3SkV5cTh3VnpnL1hLTXhIVHhlTmU4Y0tGM3pu?=
 =?utf-8?B?WFhqYnVscUpHQ1dPQVRNVE9sV2dCaHpVQjkyUTFmYVJCS0xNNVBVcnZXMXpE?=
 =?utf-8?B?VThYV1I1dklUUWZUaHMrNncrN1NrTzg3dmlVcDJtYkN4aU50WWIwMjlkd0hV?=
 =?utf-8?B?NDRzNUtJczFrUDFFTjBmZDNteXZyYzU4cFU0RUV2dXBwUkVzVnVkcm5aL0Fa?=
 =?utf-8?B?QXRFc2tnSG1vZGt2SlJCRVZnUTJJNE9jb0tEcnl1WUsyYTdUZjhIVkgzeG9C?=
 =?utf-8?B?YUdvZUxUd0IrMTZTc0lSUno1T1dyL0g5TTFrbURLMkxhdkk2SmNtQ2RFTkxP?=
 =?utf-8?B?cTVlcHV4YUYyOEoxSmIxZTZ2N2hvWTN5MCtjK3hJWVdIck11OU1lZjRmU3JQ?=
 =?utf-8?Q?suLtJgKpBoZ0oWv530=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alg5UGdBam8xR2RPakl1aGxTNlB1L1lKL3RNbHNxUVd6Y29jamdMT282UnpH?=
 =?utf-8?B?NzNzVWIxYUNvdjRFMjF3ait0WjFCTnNhNUNJTTB1M0lrZmxnbU1MWlZ1UFZr?=
 =?utf-8?B?TngxR3JEdGUvbjZUdkRJdGFtWlZwTlpXN00xc1p3Z01sM2U4RGU3TVJ1Q3hH?=
 =?utf-8?B?UllrTFNzSkFnU2ExNzRDcmVpRnl5UW93M3VMWXJDSWJqbVBGVlVNUWxKOVV4?=
 =?utf-8?B?UDRDTDNrdS81MjdsNTE3Z3Z6MXVha0VEYVNQOUtHS290azU1bkI1ZmdjbDdV?=
 =?utf-8?B?OHdjTzRjdGQ5WFkxYk5US3NmZFp3YnRiSUkzQjVwUUZmWXdqSkRNTWliSTNE?=
 =?utf-8?B?QUI2dkx2TW1hbVZzT2J0bmRSbmF1ME5lSDFxVHdPU1FHbDNweUoweGZHaDdv?=
 =?utf-8?B?SDFLclc4UElpT3pOeEhGTXZMbUozdEdybEVOb3hKSXpNTURLdWNpREM0c1hY?=
 =?utf-8?B?dnFpbVI3SXMzLyt4MEtCckw4VmtJR1R5QVlnemVCbVExenlQeS8xTkdJZDZP?=
 =?utf-8?B?eXduaGxVaHlBZWJvRXZPOHF0SUloOFgvS0txdEt4V3UvUkJYLytCWXlacnB2?=
 =?utf-8?B?bTBRT2dYaEdVNmNqbnlyUGZQWUpnZ2hCRU9RRFo4U2RHdUtEMnFzcmM5M0Vh?=
 =?utf-8?B?TjFrUEZpVkdYQkliL0tXem9Pdnd2c0dLc2pTQ1NWVjdBQ3BqRVpLcHo2ZzFk?=
 =?utf-8?B?Y0RrY1RJYXc4emZiaUFnN1BROTFsblExZmZLUituYVdKR0FnQWd1bElZYUJ0?=
 =?utf-8?B?ZVI1N1Y4QnVScnJvbUFoeHFEMnpPYjRWWTUxOVZ2Q0Y2b3hEZDBpSmNtZEYr?=
 =?utf-8?B?L3d1a1U1dGZLVU03Vll2c0RaZng5TEZQaTRXckRRRjZvN1NpeHY5cjk5Y2VF?=
 =?utf-8?B?OVkrYUpMUGlMVy9DSU85V1RLYnVSOVVJV1JHbk1YRUd5ejNXcXcwWHJZT0pE?=
 =?utf-8?B?bit3bGFDaE5JYURzaHgxc05CM0hnQzV3OHlyTGc4djVuc1lFL3UwWmxWNGZk?=
 =?utf-8?B?OW41eTBuQ05DbU1meXNxYWxiTnNHOWtmaGtOb3FWZktlWWJ5VENVSWJyVmtk?=
 =?utf-8?B?V3hIeVNsSXlTbTdscWdORTF5dXhDRUYrSHVieHdYT0JSdzNZZlUwSTBKeFp1?=
 =?utf-8?B?ZDRRRDFTQnFrS240RFZmWFFvK1ZjTkMyZ1h3dDFGSnB3VTZoVEsvbEw2Z3lQ?=
 =?utf-8?B?VjdUbzBybU1jaWtzcnpHeWRZY0ZWNzMxYVZxbTJ6T3YzRFNQQ0xMeGVmU0d4?=
 =?utf-8?B?UHZpWWZ5T3VnN0xxblVUQ2R6WTdEeXlZZjlhNmxEREVDSnpaMTZITnhOLzNr?=
 =?utf-8?B?VkpLaXZmeVQ3c0xrMFBJL2diWkJRU1l2VGNlUTQxdDNJQzdodUU2T3J3MzQ0?=
 =?utf-8?B?V3MxUjR2Nk5HMG9pb3BHTnlRVCtuWnhJZmRSaTVadndIRE5JeWNpcUxxUXE0?=
 =?utf-8?B?VVFXMzBmajQ3WjBVdHdhc05RSVVxWXMwOUd3SlNpS0tuMzdBVjhMZUlmbWZH?=
 =?utf-8?B?eUcrY1dlSGZ2S3BnNjRuc1lPMkRDMWF3SXd2UWxlMFE5bTVsK3V4ZmJ0dVlh?=
 =?utf-8?B?MFBwZ2VURE1mdVQ2LzRNQzl1d3pmV1dQbml2SnJIc2NEZFlDZUdDMUlPeWl6?=
 =?utf-8?B?MEE1c0tRa1hlUFBmMVFCUkFybjdwK1NSNEo2T0pQaTJmZzVrVHZCMmxyN0lQ?=
 =?utf-8?B?b2MrR0drWkhMY1dvbWc3aFJjaFMveGoyMnU4aVhYYVJyOTFzZDRpd0swcWc1?=
 =?utf-8?B?SVBTUUJOa2grQ1RsZGJXdzZjTFN0NzFIcXdpa2d5L2hNT0JmMlU5NkhGUTZa?=
 =?utf-8?B?ZWIwbTRNVFlpTEdXN2FJdU9YNm1BMXpVS0dCWUc4LzFoam8zWDkzaFFjNk1r?=
 =?utf-8?B?VUxqK1h6K1Z6VXk3ZHJhRHNhd1ZhQXN6SmRRR2I2NWxtNDNnRWYvblZtNzM2?=
 =?utf-8?B?dXRqaVZNNVZBMm16VlpaNHprWDJXMlNKZHFxOTJVWHNJYXVsSUU5aXY3MnR1?=
 =?utf-8?B?T1FVcG94eXhudnJ5M2ZnWFVuSlZaUmhJZWhtSUxTNjRWeDZ1UkhQS3lmNkJX?=
 =?utf-8?B?R2JIMGpNeUhmTGxEZzVEeURBR21RdmtPVjR1dlBqWVBIeGsyTU4yODVjdkpv?=
 =?utf-8?Q?E9dU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e79ff81-77be-488e-ff86-08dca5a9d828
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:13:27.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9YPV4HEUMjHC5nQZwNRiDPK5ZBe0mu2nxcjB1HBH24K3UzypdyAEwpeegLwK76a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467

Hi Reinette,

On 7/12/24 17:05, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> Add the functionality to enable/disable AMD ABMC feature.
>>
>> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
>> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
>> to be updated on all the logical processors in the QOS Domain.
>>
>> Hardware counters will reset when ABMC state is changed. Reset the
>> architectural state so that reading of hardware counter is not considered
>> as an overflow in next update.
>>
>> The ABMC feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>> v5: Renamed resctrl_abmc_enable to resctrl_arch_abmc_enable.
>>      Renamed resctrl_abmc_disable to resctrl_arch_abmc_disable.
>>      Introduced resctrl_arch_get_abmc_enabled to get abmc state from
>>      non-arch code.
>>      Renamed resctrl_abmc_set_all to _resctrl_abmc_enable().
>>      Modified commit log to make it clear about AMD ABMC feature.
>>
>> v3: No changes.
>>
>> v2: Few text changes in commit message.
>> ---
>>   arch/x86/include/asm/msr-index.h       |  1 +
>>   arch/x86/kernel/cpu/resctrl/internal.h | 13 +++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 66 ++++++++++++++++++++++++++
>>   3 files changed, 80 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h
>> b/arch/x86/include/asm/msr-index.h
>> index 01342963011e..263b2d9d00ed 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1174,6 +1174,7 @@
>>   #define MSR_IA32_MBA_BW_BASE        0xc0000200
>>   #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>>   #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>> +#define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>>     /* MSR_IA32_VMX_MISC bits */
>>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 2bd207624eec..0ce9797f80fe 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -97,6 +97,9 @@ cpumask_any_housekeeping(const struct cpumask *mask,
>> int exclude_cpu)
>>       return cpu;
>>   }
>>   +/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */
> 
> Please be consistent throughout series to have sentences end with period.

Sure.

> 
>> +#define ABMC_ENABLE            BIT(0)
>> +
>>   struct rdt_fs_context {
>>       struct kernfs_fs_context    kfc;
>>       bool                enable_cdpl2;
>> @@ -477,6 +480,7 @@ struct rdt_parse_data {
>>    * @mbm_cfg_mask:    Bandwidth sources that can be tracked when Bandwidth
>>    *            Monitoring Event Configuration (BMEC) is supported.
>>    * @cdp_enabled:    CDP state of this resource
>> + * @abmc_enabled:    ABMC feature is enabled
>>    *
>>    * Members of this structure are either private to the architecture
>>    * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
>> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>>       unsigned int        mbm_width;
>>       unsigned int        mbm_cfg_mask;
>>       bool            cdp_enabled;
>> +    bool            abmc_enabled;
>>   };
> 
> mbm_cntr_enabled? This is architecture specific code so there is more
> flexibility
> here, but it may make implementation easier to understand if consistent
> naming is used
> between fs and arch code.

How about "mbm_cntr_assign_enabled" or "cntr_assign_enabled" ?

> 
>>     static inline struct rdt_hw_resource *resctrl_to_arch_res(struct
>> rdt_resource *r)
>> @@ -536,6 +541,14 @@ int resctrl_arch_set_cdp_enabled(enum
>> resctrl_res_level l, bool enable);
>>     void arch_mon_domain_online(struct rdt_resource *r, struct
>> rdt_mon_domain *d);
>>   +static inline bool resctrl_arch_get_abmc_enabled(void)
>> +{
>> +    return rdt_resources_all[RDT_RESOURCE_L3].abmc_enabled;
>> +}
>> +
>> +int resctrl_arch_abmc_enable(void);
>> +void resctrl_arch_abmc_disable(void);
>> +
>>   /*
>>    * To return the common struct rdt_resource, which is contained in struct
>>    * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 7e76f8d839fc..471fc0dbd7c3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2402,6 +2402,72 @@ int resctrl_arch_set_cdp_enabled(enum
>> resctrl_res_level l, bool enable)
>>       return 0;
>>   }
>>   +/*
>> + * Update L3_QOS_EXT_CFG MSR on all the CPUs associated with the resource.
>> + */
>> +static void resctrl_abmc_set_one_amd(void *arg)
>> +{
>> +    bool *enable = arg;
>> +    u64 msrval;
>> +
>> +    rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
>> +
>> +    if (*enable)
>> +        msrval |= ABMC_ENABLE;
>> +    else
>> +        msrval &= ~ABMC_ENABLE;
>> +
>> +    wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
>> +}
> 
> msr_set_bit() and msr_clear_bit() can be used here.

Sure.

> 
>> +
>> +static int _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
>> +{
>> +    struct rdt_mon_domain *d;
>> +
>> +    /*
>> +     * Hardware counters will reset after switching the monitor mode.
>> +     * Reset the architectural state so that reading of hardware
>> +     * counter is not considered as an overflow in the next update.
>> +     */
>> +    list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +        on_each_cpu_mask(&d->hdr.cpu_mask,
>> +                 resctrl_abmc_set_one_amd, &enable, 1);
>> +        resctrl_arch_reset_rmid_all(r, d);
>> +    }
>> +
>> +    return 0;
>> +}
> 
> Seems like _resctrl_abmc_enable() can just return void.

Sure.
> 
>> +
>> +int resctrl_arch_abmc_enable(void)
> 
> resctrl_arch_mbm_cntr_enable()? I'll no longer point all these out.

Sure.

> 
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +    int ret = 0;
>> +
>> +    lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +    if (r->mon.abmc_capable && !hw_res->abmc_enabled) {
>> +        ret = _resctrl_abmc_enable(r, true);
>> +        if (!ret)
>> +            hw_res->abmc_enabled = true;
> 
> The above error handling seems unnecessary.

Sure.

> 
>> +    }
>> +
>> +    return ret;
> 
> resctrl_arch_abmc_enable() should probably keep returning an int even though
> this implementation does not need it since other archs may indeed return
> error.

Yea. Sure.

> 
>> +}
>> +
>> +void resctrl_arch_abmc_disable(void)
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +
>> +    lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +    if (hw_res->abmc_enabled) {
>> +        _resctrl_abmc_enable(r, false);
>> +        hw_res->abmc_enabled = false;
>> +    }
>> +}
>> +
>>   /*
>>    * We don't allow rdtgroup directories to be created anywhere
>>    * except the root directory. Thus when looking for the rdtgroup
> 
> Reinette
> 

-- 
Thanks
Babu Moger

