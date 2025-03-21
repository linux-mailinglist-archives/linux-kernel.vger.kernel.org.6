Return-Path: <linux-kernel+bounces-571612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8EAA6BFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8FE7AC687
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F421DEFC5;
	Fri, 21 Mar 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q9Vi/rGS"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD01C5F14
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573966; cv=fail; b=YH9ZUl0ZjQ6VzGH2A7brotPEm+YyYZfRvyeAqfp7hThw7o9yAe9Z846FRIRl6yH7gu7dxIU1qObxH4Me0oSkM5jkGBu2Igggdg0D5YmHQhLZ1BTeDuXEPXM4im9r9aQUTYUB4ke31DQIFa+NsQPJc3fVH6m0N36o1FJmJ7NiAtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573966; c=relaxed/simple;
	bh=djadI+OCQP95eAHRdLjRYkvrD4OKsRPE9a53Og96F4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RtNH0Qn4yfHr67AcP9y2TskDAyQbLl5uzOrKnWozdSmSRtBvQn4FFsikUkIuHA0vHbvtNkGAeZvTRxN64G63efuLCNbVYlHiW5OiCnUNf/+FQYk0O53LefHGaT+X2kGlfNThnDVXx5yCeMzZ3FPyRrKcKXzD/oMt6TrKYpfipts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q9Vi/rGS; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpcqigKiMQgsnBSyvTy1/44VPODqkVsVYK8ZBnamWpMUzeQXSs6hBGX6pPPD1KIlhb4UihLyk8PVw/6Ho1Dy5o4yX/fO5uAxjpuLajWXEb98VqEMyPBZNQddqsVklx7AJlH8W+pCZpEjZa9I4n9S2RHMiovnU6CFYqiRHYLqiPlTOI2/ArZ5B8eqO2/DOfvvZ37SS294nb71OwIbBfwj72GXY4vT/RjJFO1zx8St12WtX9wiUR82bI3FqFrWWUuUxNS5JmPbf2V3CXjaRSjafM+G1i6zAmJTHxD97OL4w4G1F/6AThGhCFai3iepfWNJTPu7YPaFdDXOg/M1bph1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg0S78qAkWKw0NmbrFp9dGd6zj2l94AX5w04u6rLjOI=;
 b=kSBAs+2ah4vKJOwlkVTMoDPMqbQzzdEsQ1zbYRpkIcUKWRLXjnu1b5jgwTO5xkaXb0Rh+rBwNR0sClzErX+4KfzRm/yc+Ch/eB39ZK1vB7q7eZaS/j1pucrSWekKHximFJUq08gLcjZHm3bl4M2/VOw1oL07fPHP6hzJfMnHhFzHqnwRJEw+rTN4Woge7A+Ze1d463mOiQ2LrVOC5CVyb0dpyb2hD8368AlWBXsnM/4QRPZxVdzP+xNMDM+l0h9tatWl+PQAfUOMBI2h5/cIi1ntzOMpV6AZT783sVvCqtlf03S6JBiXwtozTOUqMMHKUSbBbTL707Svj+p+k09sZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg0S78qAkWKw0NmbrFp9dGd6zj2l94AX5w04u6rLjOI=;
 b=q9Vi/rGSI7caNSXEEFbgX9xBBxgHL/6MY5lbyB1kqPqmU4qyLchMEBKjbJv0dgnVkVJG9N2krUiue6DK9sDGYCR4LMpBX1ezo8OBRT1o0tcFuQwOGLtxSO5J5PEfeF87WV+wAeNUslSFIpRF2IQS/+LSjOzfQZ6wM5nKgShTDt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 16:19:22 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 16:19:22 +0000
Message-ID: <04f0a3b5-6665-40f7-a19f-f3ed36aece52@amd.com>
Date: Fri, 21 Mar 2025 21:49:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/x86: Check data address for IBS software filter
To: Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Matteo Rizzo <matteorizzo@google.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250317163755.1842589-1-namhyung@kernel.org>
 <0eb55fa1-3b03-4550-bdd7-c7c50294dcbe@amd.com> <Z9m20YMkMfUDBxgv@google.com>
 <d1dec8b8-10c8-4da0-920a-d1f744543253@amd.com> <Z9spTE_M47M4qpCR@google.com>
 <Z9tCyVkqCzbulODv@gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Z9tCyVkqCzbulODv@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fbde20-2b51-4c41-682f-08dd68942379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzVrMlNRd0dKaC9IcEFwN2JHSEd6dWJOU1E3VE1LTFQrWTRBdWI2eGtvM01k?=
 =?utf-8?B?cnY4blUxaysvUkF1MzJoR0t5aU5XOExBOUVnU0Y0aHlGOGRqVnlVQy9KLzhn?=
 =?utf-8?B?UmViV3JIV1dZNkd4bXhveWJpdGc0cC9hQkdldXJYZkJISDdrWGZYRFFQV2dY?=
 =?utf-8?B?d0pnVzV0eUs5ZXloa0czak4zazJZdEF2Z3RXWTNqcTBERld3YjdpTkE3ZCtu?=
 =?utf-8?B?THNBNWZXMkRuaHEvT0NXQmsvc1ZqN1lHMXZCYUxhK3Y1Z2E2ckcxYTEzY3pl?=
 =?utf-8?B?YnA5VnNPM1EyUnRFbUNnaTNMZzMyKzdObFl0YmRkd2I4UXgvZXFtMUNYT2Y5?=
 =?utf-8?B?SndpWXRKQ3BibXVaVDlBZm84R0tFVHROcnlUaWlqcDFOcFhkQWx4emEvTzkx?=
 =?utf-8?B?R0J2MGpSRCtKRkUzK3o0eFdGQ25hVllYZk5zRzNRdHYvWGNLM0V2K1BESzMy?=
 =?utf-8?B?MU5XVE5kVHFaNlAyWS9VSlZ3c2ZvMjRLK3huWU9WUjJ5UFZMQm1Sc3ptRmRC?=
 =?utf-8?B?d1F2Z2wySlZIZUl3YTN6OURzcnFiR3M4cVI4TGMxYjNBMDVqeWhmamJUbHph?=
 =?utf-8?B?cTMreVVSS1dxU2h4L2tsS0pyY1diVGdseXphL2wzNzJRbkk0MEYySjc0cWRh?=
 =?utf-8?B?d3VkRHRkS20xNkxLTlJKek01YmhzRElBOU9kakhvZjNiL2tZNHNRTjRDTmgy?=
 =?utf-8?B?SFo4YmUzK3Q2UzJ4bDBOOHBRYkNRd2FYcUQyTVpwT1pVdnNCeTlxWWkybHBW?=
 =?utf-8?B?SW43b2prQTN6N3RLZXhSVU1WYXQwcHF6dmc4NjA4N1pvekEyTXpqSkZ0TGN2?=
 =?utf-8?B?b256SHYyd0J6Z1IzMVVob3dSYVFOdmxhc29sSGlGWnBVMitNVVJBK0JsdXVs?=
 =?utf-8?B?RUJzRFNQaG90UVV0OXl4RVRPZWVWMmNMbzJnR21TQlVndXFFUnRDYUovYU9n?=
 =?utf-8?B?dGRUbDB4cWZ1OTVVZ01lNnVYWWhrQzhnMGtkRlJNbk42dis3UDNWbjJJbkhQ?=
 =?utf-8?B?dUlIWk5hYkZwZ09JTkRQSFFmTFhmNDN3QjFRM0t6UXpISEV6YWU0NUpabUVY?=
 =?utf-8?B?b0QxNDB2bXJ0SW5KYTM0WnNhODR6Vmh2bzVyVWl4c3dBYmxmdStMeGgxb1dR?=
 =?utf-8?B?U1lnUjBTNFNWSGt5U3AxZWxFdDlqN2RxQ1VzSk9UcU1KN2pKWDhLakdESjEr?=
 =?utf-8?B?dlRDSmtTbG5QaTJ0ancxa3RTZVNZWTg5YlZPU3lmYlRNd1JKcE4xOEFTMjFl?=
 =?utf-8?B?M1Ztd1A4eE9nMmt5byswZ09uRzdkbUgzREtlOU9PSWpCRWdpSC9BOWZva3RQ?=
 =?utf-8?B?SkptdVhmNHEyTmRIZ25PaWZZV2VlV0UxbVVvQ2VwMzlMeUJkVnp3d3U2dFhm?=
 =?utf-8?B?MFNGT2o2RThJYm9oa0xhd3lZckVMeE9OZE4rUnF2bXR0ai9mQXVHc2JTM0pB?=
 =?utf-8?B?NWtqeUswTzdENFdYRnBNcmsxRS9rRFhTT3BkZVRYVXdzakxhNlkzdCswN3Ns?=
 =?utf-8?B?clhvclpCbXg1U0FvUzlIODlaUUljejFWKzQvVXVkY0wzWC9wdEhYbis4aDJt?=
 =?utf-8?B?d0dRcXpmMkg0ZFNTK0x0N3FYNG1Cd2xsbkdDVHVsaTBZTTRNTXMwR1JzUXcy?=
 =?utf-8?B?NjM1dktoMCtINnZCZHEySEZPNTY1a2w5bXBIVTgzajZFSE1nRXhudGpMNVB4?=
 =?utf-8?B?REVtNXJQcS9IUitaYXpOSklmWDNib0RrKzhBMVpPNCtUSDA0UGI2eHVuRXJW?=
 =?utf-8?B?dGZKM2Y5VDVGS1E2NU9LZzcwSzRObElia21TTVpyQjZKMUF2WlhIR0pnWE1l?=
 =?utf-8?B?bHdtNGNxZEc0dVA3VUU3R3VBQmxJVXZoZWgxUktqa1kvbkE2SjZCWWtXVkN0?=
 =?utf-8?Q?IW0NsE0tOpRCi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3QrOUIzWG1GdnliRHVTZm5haGxMRzdKcXREZ3Nvc1BNSS9RSWNhNWo2TC9s?=
 =?utf-8?B?b1hwY3dVVmg0aTN4UVk3MUpLSXBwSDJpblg3UEpjRnlUemRST21JdXFiRC8v?=
 =?utf-8?B?blU5dHR5OGEySDNYV0xvd3p1T3NmN1NFZWY1b054d01RQjB3dFNlMTlIZHUr?=
 =?utf-8?B?eERybkVVOW53MEV4cHNaMm1vZ216eHNteWFwRndSZmNiTzVTSVdnVWJvRklQ?=
 =?utf-8?B?YnJGa1dQRmMzL2trblFPdGxKOEI3K3pBamI4TE5VU3JkWURIYklySkNIRVV4?=
 =?utf-8?B?RWhTTVlIR2FIWnpOUk55ZnJmZnVGaTc3V3NKeDRKTTBHYW9SWjdUQ2VLbnlC?=
 =?utf-8?B?QjV5VzBSSGxUZFBYSmFldC9HYW5KN2ZzVGNFZWU1Z2tndVVWM0lqTHNmNkJa?=
 =?utf-8?B?K2FjZXVrMmVjbGdhdEJJUG54bnkxSzhLMWcrNWQ1b2Nzb0dEMjdmTy9Idi94?=
 =?utf-8?B?bXJzL3Z4OXlPOEI1TUFDVFROODZYMlhHZG03RkN1enBSdkVPR2xkSE5KQUpp?=
 =?utf-8?B?c2NZdGpaV2ZzQkpqQzY1NWw1T01wYVZiNEYyRy8xN2dZbWNlQXZOQUkyNlRU?=
 =?utf-8?B?L3FPbHVRRC83bGpGRDMrSFA1S0JMSlRTMFBmbmE1amo4S0ZPeWliQmdPcTZS?=
 =?utf-8?B?bThBV0tTRjNpTGNVbHVjUmRBbllyVnBBb1UzSW9jbU9rK3NYSkpSbkVVbkVw?=
 =?utf-8?B?bENYemVZNU1yZmhDVFZHWSt5UEFMYzY2dkdtLzZFeU50cFNSQStjQ1owdGVF?=
 =?utf-8?B?UzFJZWIwVDdZSWk5c0xab1ZrdXlxNmNVZFp3MDYrRGRCdGRVYmY2UDlzV1Jr?=
 =?utf-8?B?dDYvWGhXSDhHQXg3N1NObnRzcmQyN3c0REhPR0JwOHNiMGJzbllRaG5NTGJj?=
 =?utf-8?B?c2ZqeTdwUFdkWGRrVWZPTEhrSWFPbFNxQWxvbHRWeDAvMm1HekpXczhXbDFY?=
 =?utf-8?B?aitXUkRXRmdQTUNYMmh4WThOcy9haUhpK20yTkV0cm5Ua1hQQlBnZGNMRXlJ?=
 =?utf-8?B?UDBIRUdJQ0o0Z2NacmtNeDFTc3lVUUJEb09WMUdJamdrRE92cW54dXc1SmFy?=
 =?utf-8?B?M3UvU3pGbFlRWWZuNGgxc3Z2bDloanp0YlRoRzhSOHJsekMzN3M1aTVqcjFV?=
 =?utf-8?B?bWxiN1Uyb2VwSDd2aE1tVU43YWVJUjJyQXFSOWV5aDZIZTZYVEJUZzlKV0VF?=
 =?utf-8?B?ZldhQ1QycEZINU80Tlp3cUlZMnZPYjBBR3AwK1NNTDhic01hUTFob3ZjU2VI?=
 =?utf-8?B?bXpRN2NzcjBHWG8zUU5IN2lyRWJnYTU0SlBMY0paOGFTLzdRbjBObkF0RHBE?=
 =?utf-8?B?OUNRRS9HdUhFOHBiS1FnQnl2Q0FoNERRRG1jUGhscGtJMTRaRWJoaTNoVzVO?=
 =?utf-8?B?cmYwMXA0L0IzNlkwbWVXcXdSTkpBK0xITnQ4NmpCT0NmK29kTTdMTkhTV0wy?=
 =?utf-8?B?bmRzTlBMblRrNEtyZzI1VExkQ1pNMUd5WWhOQ3dmTE9uQXAzaXIwcms0ZVBh?=
 =?utf-8?B?RXVIZHJZcDR5TXByL2p1NUh0ZnV5U2xhcEI3c20zaCtlN2tySTNlMWZKajA2?=
 =?utf-8?B?MkNOY0NvVDlqVGVGKzJJY3VYOHVXSnNxQWVQSUtiZDRoTU9vRFdsd1RqWlky?=
 =?utf-8?B?eS9OdVg3bXF1MWg1aWtNNWdkTExIelZvUkNCQXJJWkU5cnZZQkNkQ2tNamhk?=
 =?utf-8?B?L1BGOUw1dFZnTS9sQU1Fc0Nia1Y3STFMOVNRZ2ZSdkxHTlAyMERnRDZEbXBo?=
 =?utf-8?B?SUV5a2k5YStmbzl3QlZzcEMybVZjQ25pSDdsZDdkMkNsN3JiMm92VUVkUjFq?=
 =?utf-8?B?cEg5S0x3STZkZ2ttWFliWHZBOG1GU09sbDhHeko3RVlKVmw0bldBZ29WM0Ji?=
 =?utf-8?B?MXVVNHlENzdUeWFFU3BLRkVDVDh4ZEVza2o2RWFCVW5aQVlSL1BxUUlUeG5s?=
 =?utf-8?B?R3A5WEFxVmFCWjYzM0R1N1ZzLzVxU3BUd05ZTytsYk9SVnhHaXNVNGtKc3ln?=
 =?utf-8?B?TVR2NnhmWklVbmhLTXdxNFJnTXB5VnphZXd3THlSZFRMb3JETm5YV3g2WDB2?=
 =?utf-8?B?Vk9qdWZZNFVQY3YzTlZPMzlodFBYZGZ4di9vcnI4cElQNHJVYWs1Tmw1bnpm?=
 =?utf-8?Q?Jfbq0PjD9fRHVikWItRNw16S6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fbde20-2b51-4c41-682f-08dd68942379
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 16:19:21.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Y60hhYJ8mAvaWROvQN4f6i0RF1Wxrt9Ymr1hAIEbaj1llxI3isdzT79Cx0dj+hUdDixOAKdwHfz5x21nuBemQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

Hi Namhyung, Ingo,

>>> We have two options:
>>> 1) Restrict IBS + PERF_SAMPLE_RAW to privilege users.
>>> 2) Remove all sensitive information from raw register dump before
>>>    passing it to userspace. (Kernel data addresses and all physical
>>>    addresses are the only sensitive info I suppose?).
>>>
>>> 2 is better IMO since it will allow unprivileged user to use IBS
>>> with full potential. wdyt?
>>
>> I'm slightly inclined to #1 for simplicity and safety, but #2 is fine 
>> to me as well.
> 
> I'd prefer #2 for superior usability, if it doesn't get too 
> complicated.

Thank you for your opinion.

I've posted a v3 based on 2nd option:
https://lore.kernel.org/r/20250321161251.1033-1-ravi.bangoria@amd.com 

@Ingo, can you please revert v2 and apply v3? (provided @Namhyung is okay
with it).

Thanks,
Ravi

