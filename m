Return-Path: <linux-kernel+bounces-573115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DEEA6D32E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2F03ADADE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9A1411DE;
	Mon, 24 Mar 2025 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZOXkAs4"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD33B1A4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742784959; cv=fail; b=KKFOrAWEAwZzG7nVg9HD4UVt2lHun3WsTdCZX6v8EnNucyKT+gXq1Y+DdETVVe/rpMWPSfnQslaiBPqIav2gGW94v9lHcjLIVYPu/D62lEMLIb2Q+VxzOEzEUbW6bmKnxzMM55jLCh7JJt3oIP7jJO/GBOImUCVcpUWdIpjwmYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742784959; c=relaxed/simple;
	bh=ojkwJLUee3r+5gL51rV2/BhBikiuZtqSmYCU0rJg0ac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IhXWMzQGZUbun0KNL3pqT5CMLYBX9D+VZVD5/0CIbMxcdby5SsXtlqqXq4YZETW6ov56E17vTPJhCjfYdeKZ2vPLknBexQdCXc7KMR5qFYj2Byxej5iTBJCuco9DBE+hBwPNpjlMl/eQns4vScauOqr+BfPUruJwGT9g/uxpsg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XZOXkAs4; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Som0cpxzB3to6mWul2rUz5oh8NNOTOPVbeUkqxrlRLQujQ/Lll/10W4/KbnW7IOUBuhdKr5WTZ3pvajHQi5U/S9pisLKlqy+MMnVSNPuoMGUf8KNHgcc9rvWAqkd+BN7nzp7CiJzFTToieIkCZ+kKI8D2lAuXTgRMyaaSmIBrid5POiGaWDB8Y0hFSFJxsXF+VWwAkx+SXm23EwiLyS3SiYFZTi3FEFnYSGY+TxdOn5Du6AU5v6YCeUJ2pV66sh6BEnzwA8YwjItDd4Sb7VPlZRksS+dTgGhnWwrWA5cmjpOZV0fG8DIK0zkpF17UKNsPuj6X1NeEQA/cnokbUARwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ygfwz4afgFWwsPslHFE2lIsLiOf2VZMx5TGHQ8xcoEc=;
 b=B1mp0ASzGfLtN5lpL/pAFjOEu850OthYAVQZ7Z4IzYazEEJxwNm+GVSrjSxPhMPDmbMu1OfUKlbyNTGp8QR8K8OqO3JY4sRZFboK3NB7loED95rAm6dqq1ew3M8dkjAoTTeIJCIf5psEcjrTnIcbtPxmwbxQ9AyGLWmvnIOY2aWKhOcbaee6WmPI0kMU1/agCrlVTNnD8gW3YZIxVvI3HRjdouBfIgh3d3xdOxDiSNPItgOKA+O1eCLIuqRz8XkZqsNAMdoWIUGRHuBMpWmWUE8bgC0QTyBcJc1tvvJMTTMf2KNiXwCw98s9+9lzV8musQmcmnZPzQQ7Ngn3d2EJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ygfwz4afgFWwsPslHFE2lIsLiOf2VZMx5TGHQ8xcoEc=;
 b=XZOXkAs4BvS9EBE9+O5cgVXACegXPEk9e2dA/7JYHU/BMZlZSmBXnGSKPira6b6QCISjdaQpZcErj9C1Dl2gVbSSEM6ZLzO9QoCZzv7zoXVj5bSCqaLT8Gu2+6wA81RjbPFVeA5mJ4Pexyv5BmlU9GGgBTS6QE013Bxq2DJksma3mTeBjHCzAysAjtD2/RIMN4H/k0/FbaWHrv+ISZRpQvTAsCGc+vUvAeE7jlefMT/xWj4QeZWz54zMUblem9kvDNGD7ydnaklf3S3qeAlb9+cpOBFPGgcpaXfj9PDz8rV1gLQ3eaUd6s7kpWCyNI5l7OTTHbYtpx7qOivmFGpwBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 02:55:54 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Mon, 24 Mar 2025
 02:55:54 +0000
Message-ID: <82cb169b-15b1-46f9-9d8e-4c9483de1c77@nvidia.com>
Date: Mon, 24 Mar 2025 13:55:43 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm: migrate: Allow misplaced migration without
 VMA too
To: Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
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
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250306054532.221138-2-bharata@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fe3093-cdee-4084-ae1b-08dd6a7f64fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1l6bjhTM3htMWJERHloZXE3MTByZEdXYzhHTHFsQnhGRDhkOW9CSStjZU92?=
 =?utf-8?B?bDcxa1l0aVJSaUVqMHdmMjVmdHpUTm40U3ZRRXFmYmM2KzgvVkxnL1p2a296?=
 =?utf-8?B?elZjbkJwR0NjRTM0M3ovZmYxejhHTWF1N1YyUzAxSnNwS1VHWStNNy9TSWRy?=
 =?utf-8?B?c3dvTTZ5T3NKYUZ5eWg2T1FJeElTQng1WjI2WFhoK01iYUQ3S2hMRTBqQzFQ?=
 =?utf-8?B?V20xekdoaFJObWVJWGVDZUhNWmQ2NE5RaHB1QTljbFVhQTVmU0VHYTZ3alRv?=
 =?utf-8?B?RXIvbzFPdWFWRzFOb2JtSWVZcGorME9FUngzT0xMejU3ZlJrcm1aVG91SjJT?=
 =?utf-8?B?cVVUNWR2VzI4dVFtYnk1YXlQNmFFZHJCdFRacXdYSHhkM1BmNGUzUHlXZ2ZB?=
 =?utf-8?B?TWEzdWVxUjFBM1IyYUhiOCtHKzAvajErNWFRNVdFYkRmQTl2REhrWXZQSDJL?=
 =?utf-8?B?TkdsZ3JPblB0aGRpQnFqWDdKeFo5cTNkVlAyZXBwaUJZVlB1TFJGWE55Z2J0?=
 =?utf-8?B?TnRZUFhYNDc4T1pDTHZzU2JSVDI4RzRkMVhtVzlsZy9XNVlHVFN4YTV6ckpB?=
 =?utf-8?B?M3VOL0xlV1hsYmZwNnBIV01XcmRtcm5MNm9RSW5qckpObnk3Z1E0TXc2NGtl?=
 =?utf-8?B?b0FBU3dHeGIrMUV4S2JOV0FpTXhoWWQ4a2wxZHdLNDZKUUgzNHBXWW02ZVFV?=
 =?utf-8?B?VnM0OThUN2UvUDdabml6ZnUrYlFJQkhqWUFwSkpDZUtsRnJxSTlDYzdlQk8w?=
 =?utf-8?B?M0dxeGZmbSs4WGZTM2R4TlQ3VkJpQmlCclR4NkZMc1IxZXFHQjJCK2Z2eCto?=
 =?utf-8?B?Szh3b0paalVzK2dVR0J1TEVNYVNWQ3B6TXoxZEFmRjZnOEh6NnNFTlg4VWVZ?=
 =?utf-8?B?dzA0MVFQQ0R1TUxsS0dWU2ZFSCtMNEVkd1hGdG9UL1BDU09hWFl5ZUdRL0F2?=
 =?utf-8?B?cEdQQVJoeVo3YTFqREc4OW1EUm1wNldtUWVkdEZkNEVJcmprRm83NVFyWG5n?=
 =?utf-8?B?UUp4OW9LRWZXbXh5RWdnbGd5YXhrdUwrMnpJaVBzandjRi8ybGp2RkZEMllk?=
 =?utf-8?B?ZWk3NGpKeDZnTThMNlNKemJXRG40b3VET3psTXhjOUpHcnZyd09hSGc5NWJj?=
 =?utf-8?B?d2JPWENnMEkwUlBWdWFEMmF1SG0ybkRDckRDSzdYc2N0MWFxQkZBb1hvNGJ6?=
 =?utf-8?B?SDRJbEE3L215VkZKZWdjdUtVTHFyem93bHhCKzVpMi9BUGpXVG5venJMdHIy?=
 =?utf-8?B?dldIZ3gyZHEzUEpaSE9QZDU1Y2NBVXJrNHJqOWlWaUlVS0NFemtibnpBQi9F?=
 =?utf-8?B?M1FXMTZoT2dVcUtUQWliQ0FQaDVRTkZyNUpzQU1xbkdrd1haMXhGaThHQjJI?=
 =?utf-8?B?a1VtZUMxeUgxaGwyUFNLdzlZMlYwajNYM1FYb09tam1iQnJabGFxQUhVUENk?=
 =?utf-8?B?TVBSOE5DZDVVbUhrekVhTytKUFhDUTFYVkhwcDU2K2krMjZ3aG5qWXAwanlw?=
 =?utf-8?B?NGEyNll3SGowb3dRNUNGT1hZSThXNWgxUUlFakhmMVBQM0U2c01zZFlVcUZK?=
 =?utf-8?B?bWhUaTFrMXRkbVl3WktvL1U0R3JidkVFMGhPR1VzcVpFemExZEtIYTdhVzhS?=
 =?utf-8?B?OC96Z1RrNDRTL3hQdnJoYmdPOVpqcVRkdXA0RDdSVkk4Qm16VERpWlNDNnM4?=
 =?utf-8?B?bTVrTUU5YmNITEJvVHZCWExRVWpBSkNqWlhSRitSdkx4OGZkQ0M5TFdPelJs?=
 =?utf-8?B?ak5pcjdlMEk1dUNkU3JxWkZzdThuVit5QWJZZFIzRTVFamFLY2QxWVBpVzZo?=
 =?utf-8?B?eDJMTXJkNDV3KzBFaWxUSXAreVY0RTRYQnlzVFBsK0YyOHFKNmVLcXh5ZThS?=
 =?utf-8?Q?DoTacAdmCexzC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1NLNUlvdnNIclgxbGhrUmNlK0tyT3VqM0l4aDFJdUJSYlM5TSszTDJHaTJI?=
 =?utf-8?B?YnBVUDdsWHYwQ2lrbmFWdG9iQkg2akJTZitONW44MWUvTzRJTXlhVStSelBw?=
 =?utf-8?B?aDJ3WVNOM3B4RU5nS1FpbEZILzJaQzJCL2dtdUtVQytiUHFCcFhaQlNQYjJF?=
 =?utf-8?B?UXZXc3pCNjFMVitMcmNjc3R3QktWbnRmaHJ2WkJJbnlZN3FRdFQ5ZGJ1enp4?=
 =?utf-8?B?VzdDTHdFSHhLQTEvNnRPRUhIQXgyMGpMc25RRmlxVnBkUXgzamUwTXVtUlBJ?=
 =?utf-8?B?ZWwvczZwUHhicEhBZmQ5c1YzOVQ0cS84cGpuSlZDN1EwNXRlVmkzblZCNTYz?=
 =?utf-8?B?dFIxTFN1TTl0U3FTNVJsMHJ3RmR4STA0RWRuS01xc1h4YVkxNm5vNTl3VVZR?=
 =?utf-8?B?QS9UZTlJaFpWNWRRSG13QlF1RDRSL1dsNTBoR0d6TUY5UXdKRVc1S3VhN05p?=
 =?utf-8?B?YWhnOEQxR2xmVEdBenYyYXFiTnBKQkxPUWFmRURoSDU2b2F1TTVxRjl1M3ZI?=
 =?utf-8?B?aUhaakF0eEg5dldsRy9tVjlPaXdIUlVHMVFPdlp6ekNTcGNYLzRFYU1HWit2?=
 =?utf-8?B?NkpTeXpxOE9UYzVUY3pCaWkrdS95UGtWVHU5TUVOK3FuR0o3cmRTUXNLT21R?=
 =?utf-8?B?UFNmeFlqazdMSVVWT1VpRCt2dkEzNmE4V2FTSWxnU2JTSFNjSFNFbmd4VERI?=
 =?utf-8?B?QkhVWXBBRStBWmpXendmTzE1VHlINDRrZnZobXY3RDZtV3NsNC8zM0RpbkJo?=
 =?utf-8?B?NFdYcTJ6SG9Calc1MXlPaWRkV3JwdFk3THRnNUp2VmpCSVNRU2JjUlo0elNh?=
 =?utf-8?B?SGZrUXpDNE9iU2xOUCtTVklOZ2pLTUNZR3RPYkZCTDdwZnhYWXYzM2U3djRE?=
 =?utf-8?B?eHM2anRsRnZQVitITTZ1bnhud1JUc2Jod09IcThCd0FWSXM4SVR3cXA1TVZL?=
 =?utf-8?B?cEhVOXFpN2xGd0xBdDhLNmdWa2llUjJtcHVnRE9BeG5vY1NobVo2L0s4R212?=
 =?utf-8?B?c2o1dXhxK3hhRHFHOUFpcUlpRXA5VE9EK1c1NU1Cd2xIamZucHM3cU0yUWJa?=
 =?utf-8?B?ZGdaMUswRGdhTWlYTnVXZG1BQ0xqdVpqbjVYUjBrYWkrM2Z5UlVjdUh1b0tB?=
 =?utf-8?B?N1FhQUtMcVdYVmlvZkNEQnUyTDJPWmdCQitid1A3Q2RFMFkzcDhHUzlBM3B6?=
 =?utf-8?B?VTdXenMxY3h4T1NRdUdYVkh5MlkvVnZhTTlzNzBKSkdFU3RkZ2thVTNZbG1o?=
 =?utf-8?B?VmdKNTZBTjRIOHRrek8zdjRoQXRWNmJkZFhkcUxGYWY5dURVR1pBUm9ZeFEy?=
 =?utf-8?B?VCtCUzFuTDdXcCtTV0d6OTNPMXc2R2ZVa2dVcjN6QW43dEdzWEg4WitjUjFX?=
 =?utf-8?B?Ym5xMUZWbHBIdW5hOFl1NG9UV3M3OWUraGVFcERJWFcyaDBiNktwM3pLZXBy?=
 =?utf-8?B?OGJlb2VoQTZpWmczb3Q5Ujc3MG12NEptZlBvbHpGRWIvWEJTRzEvWU5ZUTRN?=
 =?utf-8?B?U0xPVm1IV2hkOFdiZzlSbDkxNFE1VFlkaW8rTkJRKzdQZW5LTTZQR0twU3Fw?=
 =?utf-8?B?L0RHOG9QRUZnYlJRTWp4blIydnYrUEhVa2VQV0RRKzE3REhaQmlubHpUR1Nu?=
 =?utf-8?B?WHB6T3kxdjVoV2dJZGl6SU5FMXArMXVFN2VOWEwwejEzMTJXVWZHajRUTC9y?=
 =?utf-8?B?MGg4ZE9TM2I1SVJ0Tk9mNGdLM0o2VlRnOTRpc2Y5czV4WSswdUFmalgwS1Rs?=
 =?utf-8?B?MklPUko1QlBqZGIxdjBLSjczSmlkSmR2TjFoS3NGZktDTHBJaHAxZ29sVDdJ?=
 =?utf-8?B?TzZTbi9ZTnVWaGxQU3diSE5hdXllR2FpSG9FZlMzNU1Fck50dDQ0dURxbXlE?=
 =?utf-8?B?YmpQNkxDU093dW1hOUtma08xRE5FM1JsY3lqbDRuS21MbGZFU2J4YzJ5N3ZJ?=
 =?utf-8?B?d1E2RmgwT243Z2RaL2FjM1d0NTJ1K2o0SEl5Sm9nSjIyVlA3UnRWZ25YVmhT?=
 =?utf-8?B?MlZBV1p6YjVkSVVHcHYzS3VwSGJuRTZrUWV3cWdvaEQ1K2ZSVFFKVkUzZ3Zh?=
 =?utf-8?B?cWE1VkJpMEdOYzNpME5FYUlBa2o4N0dqdXkrM2wvWGl6b1lyMVpZQkFiSjZh?=
 =?utf-8?Q?oIbK5zTlJGNuu5YiDY62261FF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fe3093-cdee-4084-ae1b-08dd6a7f64fb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 02:55:54.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thlMZ0WHJPp0Pq5GY61kROKVcAB6ejHhrR9LNlwc34sbbUaOMX2jesoUAlrBXYLryDXAxLv2Ti2TEdIrrYeHzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

On 3/6/25 16:45, Bharata B Rao wrote:
> migrate_misplaced_folio_prepare() can be called from a
> context where VMA isn't available. Allow the migration
> to work from such contexts too.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>  mm/migrate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fb19a18892c8..5b21856a0dd0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2639,7 +2639,8 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
>  
>  /*
>   * Prepare for calling migrate_misplaced_folio() by isolating the folio if
> - * permitted. Must be called with the PTL still held.
> + * permitted. Must be called with the PTL still held if called with a non-NULL
> + * vma.
>   */
>  int migrate_misplaced_folio_prepare(struct folio *folio,
>  		struct vm_area_struct *vma, int node)
> @@ -2656,7 +2657,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
>  		 * See folio_likely_mapped_shared() on possible imprecision
>  		 * when we cannot easily detect if a folio is shared.
>  		 */
> -		if ((vma->vm_flags & VM_EXEC) &&
> +		if (vma && (vma->vm_flags & VM_EXEC) &&
>  		    folio_likely_mapped_shared(folio))
>  			return -EACCES;
>  

In the worst case, the absence of the vma would mean that we try to isolate
and migrate a shared folio with executable pages. Are those a key target for the
hot page migration?

Balbir

