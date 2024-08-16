Return-Path: <linux-kernel+bounces-290292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D004C9551E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EB82863FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD991C3F1C;
	Fri, 16 Aug 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z6rR7YkE"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC724B664;
	Fri, 16 Aug 2024 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840693; cv=fail; b=m0gjmxeRCoY14RipQEauptZDm05C9Ov9cOviLL/+jOhOhRC5Ei5lkmeO0u6nrSMiipMXs0euB6+pEIZf+jRZqIWyit4slw/Tq0iCvFcoatdzSRFISP+xpOLlBl1FhbKEEqCJSS80KbVjChaZnDAfl5OME9B9Dbhb6//qeLQUzG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840693; c=relaxed/simple;
	bh=y8/axZ+98u5spoovyq9dK1qShb8HUnT+Oh9mRAelBt8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mrYlM6MOgW3PusKtjCKOKx1iNeZZ7AlM0Io9btzhFhaXfB08LoE6VI9B1k5yzACEOLNayJUiKDSDnWDHA4Soj5VkUEirBq5eHRgejX7bDxamqsTW+OiZRzU1kBouYBV/sPa7M9ZZYmdZ9IfXDJsa0Tq1oEoz0ugN/FoU5dHTows=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z6rR7YkE; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQxdWKIEhfOBrKt+Bkg/s+yX6GMdrngbVNu5lx6qwzKi8O1c86uGv2jwOwo9k0nA/l+e05L495REPBw5ry9wQqeCmMm7BF+tXXCubEuvkGWTH5BB4E27aEWl2hK3A403qomBS8gJ32aml22A16BLP1AWtOryIugYP0Q6OO0FS0iy+B4Egq0iAmVy9iOSxoZagpqM350+0OJVItzh8F6NbbTIQle4EaCdIS18vjnGRFr5sQIzd/KdyLRE8yQYPmqqJiGXrOpeIr5/Z+hcK2t2M1Ov72F5jOBHV17juH76MdXPwnDkUS95HVw/wr1UMHeMaTscGiV+S6W0MidD84h58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgTeXTDiyfEEXMG9nVGyIAB8b/oYqzsby8aN3fiwMHk=;
 b=IRF7cmhYvGjhajlI/lIpIori5x7ly5VqKASE9sSp8hJ/0D0c5xvx7l6VPb3zxExgXK1X7KyZQX2AQwpWCxHlQ8mBAId07ukTwLKW9CLPEtEgFGIInjN5+L4BV7MH9ziyp0Gg995K0t1ucxvlsNVtkE1pKjDDjB/XxkAf/KLy0ugxM6CDZfwDYRZvDzKVXrC/SLi/482ZVxEuu2eAQjgrv9dbtmUsUknAec+WCZcYBp37TIehsm4l98lkYV5qyBv05YYy0Ad1AQMunCPonCj5rL9hZk6vO1JCEl5Fb26OX3v6mYZUhtMNJ9lr0O3tExAGq8YKTN87StGWCk2g4uXblQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgTeXTDiyfEEXMG9nVGyIAB8b/oYqzsby8aN3fiwMHk=;
 b=z6rR7YkEtBlECUj6T+QbkhyC9q+WMbSV0UhOTLhzfOEcPNYPybMLGKlTe/sSGOBLCEkxiTVAJLwxHrTJ3yC6WVOhwNtakg5lsJxzQlNACqvoghgdl9G6DP/6WYFsXgBF7gwHx4lWQ03+gicUYxQDzVhkWgQ78EgcJIkmXFV8/Yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 20:38:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 20:38:08 +0000
Message-ID: <8157a684-9855-4085-9e76-72d3e5a7b1eb@amd.com>
Date: Fri, 16 Aug 2024 15:38:04 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 06/22] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com, corbet@lwn.net,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com,
 dave.hansen@linux.intel.com, reinette.chatre@intel.com, mingo@redhat.com,
 fenghua.yu@intel.com, tglx@linutronix.de, bp@alien8.de
References: <cover.1722981659.git.babu.moger@amd.com>
 <140e4e7bb26db9bbad3e37d910c0cea0060e99e2.1722981659.git.babu.moger@amd.com>
 <20500833-44a0-4fd4-ae6a-729bb906abda@arm.com>
Content-Language: en-US
In-Reply-To: <20500833-44a0-4fd4-ae6a-729bb906abda@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: bb144c84-e602-439f-353e-08dcbe335664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWkrcUFmTU5rNUZBalJ1YXh2V2hyOUIxbi9hS3pZNkVDUXNwbGI0eWgyaDVw?=
 =?utf-8?B?amd5MFlsYU4xOEo3YmJYUGtkWUl3bnZURFNwQzAzaUUxTnk3M0U2L2hoVHFv?=
 =?utf-8?B?ZUhxaWJwOVZGN3o5L3d3UHdrQWtteHVqWlh2dmFqWnVnSnJWOWh2bGR6bUNF?=
 =?utf-8?B?YjFOWDZKTUVNSUViZEt2blQxL0MxQmFBaHFYaS96aWhlOTFwUmxUcHVwa01u?=
 =?utf-8?B?bllUMDlDcU1rK0pJc3cvSVVPYXUvUUFvZlAzaTFlM0VjRGhyd3BaelVzZ2tG?=
 =?utf-8?B?VjNrYmtwYVU0ZkZRaUYwOElxcDhCQ2t0OGJPMHdHWHhVOVdkWlNhMVdhaVZy?=
 =?utf-8?B?WGt2T3VKZGovVEpYODRlbnNyQ1h3eUgwemtuM00yYlRuRks2eUJhT3Uxb2g0?=
 =?utf-8?B?dTVrZEtwUVJuTk00MG50Tjh0ZnlnNjNtQlA5Tkw4VEpTVUluY2ZMaUgzcVB4?=
 =?utf-8?B?RlhUWUdMci9qdFFZMklRY1RkNFIwNkc4Q0NuYk9FbE5FdFU3TWxhQXFHMDhh?=
 =?utf-8?B?WHhPd0NaV25CSEZ4YmhBT3dPVXlQTzEya1FuMmVkSTVvcDh6RUwxRFgzRFJh?=
 =?utf-8?B?RlVsMWdGUTBiZnNCVjY2T0pWd2xOVkpjZXlENVFiZEd0ampWcEFhajVQMFBE?=
 =?utf-8?B?WlFvbks0c2dKNDdGbXJUNGRqTEwzRERZdTExSDU3NTB6K05mMzNiL2NXNFNy?=
 =?utf-8?B?UXphREVRYm43cXVEakF5OEozbzdGdDdIOG9wT1NkNGtmWWZGaGlWazRrbGJU?=
 =?utf-8?B?bXpUbUNRQ1R3UjdQdW4vb3BMUFdqbVFmaDRXRTlmN1hEZ2V5aW1wd0RleEJO?=
 =?utf-8?B?V1BpSWptSmJFdUZBdjRPV3BsUFFZQTRHQzV4dVZFZExEMnFOaGVHMVRXNGRk?=
 =?utf-8?B?VWNOc2VUK2ZkMFpFYWVVZW1MVkZrQ0VBZGhBbmxJM3JGdmZJS0oxdnNWbWZX?=
 =?utf-8?B?UjUrMXNrekFFek9SRUlPN1E5aHVGMk9SQWJMT0IzcDRYVzVPMk1acXVzK0pv?=
 =?utf-8?B?aEhBeEpmOEVnZExHK0xNelJhQTZsVjJxT3ZGanhObEVvbUJlUyszWkp4WE9h?=
 =?utf-8?B?dm9YSEVRTXpBYTFnOXpPSlVYWVRsNFdUOEprYWMyNlVMeGhobEN0UGNYYnZu?=
 =?utf-8?B?MlgyRXdrSHUzNDZVb01vTGRBY0NrYTZhUjBKYURDOUh0dDhVeEYvQkc1cHhX?=
 =?utf-8?B?YXlKazZ3cjI4amRRMzFhQzBHaXFEUEgxa1JNSFMwdng3czBqZU1NTVR3MjNj?=
 =?utf-8?B?U2w0aEdQTE1Pd0FGTWY1Z2pYaUN3UjN2bTBCYkM2VnlUZ2R2TjUzdjhhenZi?=
 =?utf-8?B?V1ZvbEJDL09Gakw5Uk1manVPd04vTDBJM3E3aU5hNVpVUEo0QS9acVlxcWw2?=
 =?utf-8?B?QWszenFNeTRoOXM1dmFJSHZwVEFHRTBjd1NNb3ZOR3BlaFRBYjVKdmZXelZ2?=
 =?utf-8?B?eGd0V0haUE1uZ3hUYTAvRTZ6TjdJenNVRVVkSmJuRmZjSkdtWFM5OEFjRUdv?=
 =?utf-8?B?Y0ljYzZhTU1HbGZRcG1CZW1nMGU5d3BhUVpuamhKL2g4Y3ZDL2phanVBYjBu?=
 =?utf-8?B?bmZpcDBVQThoT3RFb1MycWxnSnBKK20rTDFEdFBBMTZVR3dJd0dQcHBSMDlJ?=
 =?utf-8?B?T3ZhN3VBSmNZK3l4OEtaWlV4ZC9Tek5NVTJZa21Ra3psczFOLzRMZmUvSHdU?=
 =?utf-8?B?RFpCcnJuR20xejJaYTVkVGZRcnNSWlBYbUlwbS92TUxVVDFBOWdEQkF5OFpI?=
 =?utf-8?B?SlMrSi9uZUxIWFd4ZEM2eWhadlFNYzFoYnZsS2xsRjNFOWltQm8rNHVGVHNh?=
 =?utf-8?B?bEdpWjQ2TjNYWHZ1bURkUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU5Qb2U3RjlMYUcrc0FCYUFvQXFWbmlhTSt6RU1iSzdralhKLy9nUFpad0ZE?=
 =?utf-8?B?MjZkVmF2eG5wTGNvaXJTOFlaRnl5ekptNmtoZUxsSW9MbmVoSUVybzRtS1Z5?=
 =?utf-8?B?TFE2RmhLM0gyV1c2MFdDWVJ2TDR3VUdqZ2ttWktUOHJOQUVWc3IwcmdJV20r?=
 =?utf-8?B?VXgrY28ycU1PbGhuaXh6WEoyT0pWSmJaYTlrY1hGOXpUUjBWWUUxbHZjNjRY?=
 =?utf-8?B?ZFdWcDU4eXpBUjNrS3ExbzNHOWdicE10TTdyRVVCWnJuWnlhOXJpUFF4ZUtC?=
 =?utf-8?B?TXB4S21pNEFKMGFCcDF5SUtJV2RERTZ1eUZIclVaWHZjRDBvdXJVVlIwU2tZ?=
 =?utf-8?B?Mm1yd2NLbzVWclB4YW9QcGQ4L05McFc3QlVYVE9iblRFRlB4cjh0VllZVGtK?=
 =?utf-8?B?ZDVFMUxXSTFOU1ZldXdsZVJKUUhmYUp1Z1NJenI0c3gyYUVVR2NaNngxSSt0?=
 =?utf-8?B?bUQ4VDYvaTBjUmF3anMyWjNPTXV4b0ZDb29pZmR3djFyN0wvV0M2aFhVaS81?=
 =?utf-8?B?ckR0b2t4WnhGQXdLS3lkRng3UG92WGk4NFE5cTJxSmlGU3oyMXF3Z3FxdVJv?=
 =?utf-8?B?Z3ZBZENLSzUyUlEzYldlZFpVTysrS2lhTVVmaGxmYXBXcUQrS1VZdmtkYTJM?=
 =?utf-8?B?RjcrSnhYK3V6RWVGbDA2S05BMUNXWWtWVWRTakRnVmw3Z3IvSDUzODFwQWNL?=
 =?utf-8?B?Z2g3d0RzVm5tLzgzQWFxMEowWGpxTEozbVR1RDlqcjE1UUlnM3FMdVQ0Z2Zi?=
 =?utf-8?B?SXNwVVVZZFc1VU84STYyNngrbWdiR1k1MzBzTDd3UDBqcUlBNU1DK3JBcWVP?=
 =?utf-8?B?VmxBRnBkQ0RyZjZLWHZvNUlRL0daOVdHVGdJNXNmaHN3YWxuaS9EYkw1Ukow?=
 =?utf-8?B?LzU0S1Y4c2N0Znl0N0NML0NSVnJQMU56cko0b3Y1a3FLQnFQOVE1NDFKSGhJ?=
 =?utf-8?B?WENoM2FyWkQ0TTdTWmIxU3V5RGVaTGlUNkJTN0tqSG1PTUR3OHpKUHJjMkp3?=
 =?utf-8?B?M3JTUW5VeHl4MmlaQWZpdEphQVlXaVQ0VHlvQS9OMk9zWXYzSzdkRGFqb256?=
 =?utf-8?B?eGloWTVRd1BPSVlSNU9iVWlpTHp1ZVlVb0FEV0pmN2Q1NGtHcFhsWktNek1m?=
 =?utf-8?B?RnMzU3lZblU4V1hYdkNkN05hTk1sTTlRR0hlRW8wYThldU5USU84RDJjMWQv?=
 =?utf-8?B?UkswY2xFejd5SWlUamFGa203enJ5ZGxzc0pVQXBjWWYzV0RFbTVySXQ4QnpG?=
 =?utf-8?B?UnpVKzUwd012N2o3aC9jZmIxVEJnaWJyTTdVa3JVZ0tBc2V6czFKN2VVWFZ0?=
 =?utf-8?B?UlFHUVVLbXNna2ZjU21wT1NPcjBhVFg0VmpoYmVIU0t0ZXFMcTNVcUdCRm1C?=
 =?utf-8?B?cjQ1YlRMRlR1cmJpMHFtb1ZrU1dGMEZZSWloclE0T1FtNm1Id3FjTFg1eWRx?=
 =?utf-8?B?bCtDNWw1YTI4dFhwaE1rOWlSbFJsSEFPUVo5YUpQS0EwYU52NlZsNVFzRVF4?=
 =?utf-8?B?bjkwdlZCYTh3RWVJRzJiNjVPTTkwaFdkRm5BbFBwN1d5OHVGeXZZdXd2dWEx?=
 =?utf-8?B?ZUk2ZW93d3RiR0VERm1kUERvenVvd0JpcHFpdjF1eGp3SWRDT0FWQnhTMGxC?=
 =?utf-8?B?MU5ITzE5MnBnZk1MZ2lwUUJzN096NENnT08yYjRkVHkxWnE5K3RmbUx5RS9x?=
 =?utf-8?B?Q3MraDA1VFB0TnNOeDRZRDU0OVdoYVRZNURlYnRjeDFMYjV2ZXBwMVpLcEp5?=
 =?utf-8?B?RDZrejdmUHBQS29aT2g2bzBTZnRnMWpId1E1a21XdWVkQUhudXZqdlk0TlZH?=
 =?utf-8?B?a3FsUG9CUUxZMFBoSVBpWkZqdHFXY0E2bFB4Tmx5ZW11cGlQV0tFTlJMR1pv?=
 =?utf-8?B?UXZucHRTV0REOVIxZE1QWWVpYlphemVnZiswL2g0T0ExZW45OTFpRWgyR0ty?=
 =?utf-8?B?OHJ4akx6K3BLNE5pWG9LaUlaWWl3cHE2TklQNkNKR1VlSytkOGMxamgwNUxN?=
 =?utf-8?B?WlJKKzlhYjkzN1YwSnpHNWVONXZLT1dqd0ZidzF5Q3B3Mm9JZmxhRisrUjFN?=
 =?utf-8?B?cGlZMEw4MFhWSUdwNnBwcUI0aVN1RjN3ZXM2azk0R3hhamt1Y2w1OGx4T3ln?=
 =?utf-8?Q?00Xg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb144c84-e602-439f-353e-08dcbe335664
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:38:08.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAxGj6d0oqN4dUshOvOc4aTOwJJmxM+DLVhhrI9MwV5kA67ClYFz1VrlVUL/fI0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

Hi James,

On 8/16/24 11:29, James Morse wrote:
> Hi Babu,
> 
> Some boring comments about where the code goes...

No worries. Lets address it when we can.

> 
> On 06/08/2024 23:00, Babu Moger wrote:
>> Add the functionality to enable/disable AMD ABMC feature.
>>
>> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
>> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
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
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 2bd207624eec..154983a67646 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> 
>> @@ -536,6 +541,14 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>>  
>>  void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
>>  
>> +static inline bool resctrl_arch_get_abmc_enabled(void)
>> +{
>> +	return rdt_resources_all[RDT_RESOURCE_L3].mbm_cntr_assign_enabled;
>> +}
> 
> Once the filesystem code moves to /fs/resctrl, this can't be inlined from the
> architectures internal.h. Accessing rdt_resources_all[] from asm/resctrl.h isn't something
> that is done today... could you move this to be a non-inline function in core.c?

Sure.

> 
> (this saves me moving it later!)
> 
> 
>> +int resctrl_arch_mbm_cntr_assign_enable(void);
>> +void resctrl_arch_mbm_cntr_assign_disable(void);
> 
> Please add these in linux/resctrl.h - it saves me moving them later!
> 

Sure.

> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 7e76f8d839fc..6075b1e5bb77 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2402,6 +2402,63 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
> 
>> +static void _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
>> +{
>> +	struct rdt_mon_domain *d;
> 
> 
>> +	/*
>> +	 * Hardware counters will reset after switching the monitor mode.
>> +	 * Reset the architectural state so that reading of hardware
>> +	 * counter is not considered as an overflow in the next update.
>> +	 */
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		on_each_cpu_mask(&d->hdr.cpu_mask,
>> +				 resctrl_abmc_set_one_amd, &enable, 1);
>> +		resctrl_arch_reset_rmid_all(r, d);
>> +	}
> 
> Is there any mileage in getting resctrl_arch_mbm_cntr_assign_enable()'s caller to do this?
> Every architecture that supports this will have to do this, and neither x86 nor arm64 are
> able to do it atomically, or quicker than calling resctrl_arch_reset_rmid_all() for each
> domain.

Yes. I think it is better to it at at higher level(at
rdtgroup_mbm_mode_write). That way it is common across all the architectures.

> 
>> +}
> 
> 
>> +int resctrl_arch_mbm_cntr_assign_enable(void)
> 
> Could we pass the struct rdt_resource in - instead of hard coding it to be the L3 - you
> already check hw_res->mbm_cntr_assign_enabled so no additional check is needed...
> 
> Background: I'd like to reduce the amount of "I magically know its the L3" to reduce the
> work for whoever has to add monitor support for something other than the L3.
> (I've currently no plans - but someone is going to build it!)

Yes. We can pass struct rdt_resource.
> 
> 
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> 
>> +	lockdep_assert_held(&rdtgroup_mutex);
> 
> After the split between the architecture and filesystem code - this lock is private to the
> filesystem. If you need to prevent concurrent enable/disable calls the architecture should
> take its own mutex.
> 
> | static DEFINE_MUTEX(abmc_lock);
> ?

These calls are originated from filesystem (in this case
rdtgroup_mbm_mode_write) which holds the mutex already. I don't think we
need a separate lock here. Let me know If I am missing something here.

> 
> 
>> +	if (r->mon.mbm_cntr_assignable && !hw_res->mbm_cntr_assign_enabled) {
>> +		_resctrl_abmc_enable(r, true);
>> +		hw_res->mbm_cntr_assign_enabled = true;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void resctrl_arch_mbm_cntr_assign_disable(void)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
> 
> (same plea for passing the resource in, and not referring to the filesystem's locks)

Sure.

> 
> 
>> +	if (hw_res->mbm_cntr_assign_enabled) {
>> +		_resctrl_abmc_enable(r, false);
>> +		hw_res->mbm_cntr_assign_enabled = false;
>> +	}
>> +}
> 
> 
> The work you do in these functions is pretty symmetric. Is it worth combining them into:
> | resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable) {
> |	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> |
> |	if (hw_res->mbm_cntr_assign_enabled != enable) {
> |		_resctrl_abmc_enable(r, enable
> |		hw_res->mbm_cntr_assign_enabled = enable;
> |	}
> | }

Yes. We can do it.

> 
> I think you need a resctrl_arch_mbm_cntr_assign_test() too - I'll comment on that patch...
> 
> 
> Thanks,
> 
> James
> 

-- 
Thanks
Babu Moger

