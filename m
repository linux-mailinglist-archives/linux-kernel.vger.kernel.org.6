Return-Path: <linux-kernel+bounces-517164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB146A37D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E86E1894450
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE6B1A00F2;
	Mon, 17 Feb 2025 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bLT7Pe3z"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555C192B63
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780713; cv=fail; b=aZEtRfqbIrPeT1FrAovDza1qTJDzZYGyTc7Fxc15R4+EXUN9JbTuu8Om0tfemSpxK58SVEzBFHVgXJinHG+Qdd85l5cYHBgOiMzpd40nkCx3Lv/ll3gGryUFrjmwt8PnhGrpRNKyZ2zNoB4oymMbPItSp370sBMDOK2IfD45LuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780713; c=relaxed/simple;
	bh=UOnukGuKj6Four+e+oMUBiZ5LxFGNlOqVvI2hB8zP9o=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CMUQ+TBe9SrTcWj4EQXiR83veAPS6H9imCssNOfwHBZ6eStGzS5QrGYIQler3ERjGm+KKdFz8btVq7n0ztYev69JmfejuzqnAEyrJTJFWmfqxqShyECt8oHgaFBuiaZGYLPlhYaVm2SPt2t4Q4bm6UPS1kYE+NUqr3r3p7Me6y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bLT7Pe3z; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRU/491dZ8nvOql34pflGHKdZuNc7jeFNe+5JV143NRiqXHoP/DZ1ihFggtPfeWLbKNpI8B0jfFIxHPtF8C+Axo11zhsg4h9eDDpd1VAgVb6V3HL4jjXIZDAtq9R5VdnilVf9eASw1gs02oao5ziDqieIj//ZJwWewaCv8eKvjwN49e+8Se75/5A8fL2OmVtw+waMIkUl4uDlSg3cYvLS6dc01ajE5pW2cTc1ZzmGQTNz/vsZruOR3ZJDUNx52oGeTUQo1vj5XE62KxQtS4gmwp3KcPqriB8tpc+uR//0nCdpdLKQie4VO8+m6yVlcvl2qQKj27nQYwOFXiPu1xBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKXTsqTj8M1OmDHb87UMhfIQFUvvrOOYT42ckup3zoI=;
 b=j89aVDjvGYR8vWL2TNupBMqltNgL0KU2VuZPvoI6vfMITgc/AYtApuQkls70UW8Jj22scO3ocX9cNAe9dT9tMchDdPXWJ26E2s7r5Qp6gJMtlNVWeUdb4qeXb2IxMBVX2WVIQy2/Tn76YjI1ws82QDbsugKqdHF3ZPwIUxq7w+OrjQS5f1ie9s8J8bZoesNzQGBDTN6qT6CyuigYPxN31dAfCncB4EQFXowvjgZ55dMOzroazMOug4uc+RKvwK6uMkqQcQGpLBOszga/Ov0MnqP599c42Bd2MFASWoI3+13izytM8F8f/PSzv0SjdJ/XboEFO6FXudM7W1VLqBwf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKXTsqTj8M1OmDHb87UMhfIQFUvvrOOYT42ckup3zoI=;
 b=bLT7Pe3zlWLmxPyc0NQWwJT5AH0d7gjw+JXqI71LuxqhHFrYMWNC5UTJV8SemJJ7sC531xCIW1k09TEpkFBlxkVt9QZ8VlISzTQTslLxPpvbAiCq/qF0YXs/4GMQZfxD9sLoqjbjd2Shb371wyVOPbWSK9dLfP9JKAr0Pf7yasg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 08:25:08 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 08:25:08 +0000
Message-ID: <a3b1a1fb-03a4-4f67-9f44-9157ee421913@amd.com>
Date: Mon, 17 Feb 2025 13:54:59 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v2 24/24] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
 "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "irogers@google.com" <irogers@google.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "Bangoria, Ravikumar" <ravi.bangoria@amd.com>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.888979808@infradead.org>
 <1f4e4bb1-ba5e-4e5f-b6e3-e7603e3d6b0e@amd.com>
 <20250212124945.GH19118@noisy.programming.kicks-ass.net>
 <57fa247d-9c85-4f20-9723-d568272651f9@amd.com>
 <20250214202438.GB2198@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20250214202438.GB2198@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: ab053c04-8dde-44d7-1b8b-08dd4f2c96be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGVWQ0hmWWpGVkRjN2lvTjFwZEdMYXhrMzdneHozZnZRU3RnR0g3KzlWNVhZ?=
 =?utf-8?B?TGRlZjBFSjd1Z3BFTDl2YjlrYUlBL0p5MWk3Zk5SZVVPV0xCYUdCTG8raFJO?=
 =?utf-8?B?SUdLYnN4TndYZ25pdnNMZzdTdUpDN1dNclRzZkNMdXkyZXp4VjlmS2grUXg0?=
 =?utf-8?B?NU5LZVpaYnMrcDI2MnBjS3JUVENJKzhSbHhTanVINnE5eUs5ZGp2dyt4akVQ?=
 =?utf-8?B?M3NtZFo2QWJ3aEowT3QwOVV5RXd6STZMYmFvNUt3UDRXRXJTMTNHK1lyOVE1?=
 =?utf-8?B?R1dhcHZKdlRzdWZPRDNTWnVubkFRYnFCRE1vSXRWektPakJmUWlNbjlRRHk2?=
 =?utf-8?B?dFl5SVRxRWpZdHlCVlpTbDNmS0NmU20zRGl4RkExY1c0ZTR1Vi94WGZFQzdQ?=
 =?utf-8?B?Qy9XT2dLRFI4LzZJVUdUaGc3YzZISnVsQ1JlK0pyK24zMWVvVUMrRnk4R2Vi?=
 =?utf-8?B?SWNtQS9uYWRZSGNoc1FRdFd2eTRRQjU1N092TVpuY1hMYXRHaVFxQk9wY3Ry?=
 =?utf-8?B?QVVRbzc0REhpbnFaMEVYSW1tam9JZXRnQVZubmlhSVFxQ0toa1hZVVNFY1Nl?=
 =?utf-8?B?RkNWdTN6YnozTzdlVzhKd3BKME9CRjc2aWdnU2xYckJiZ013VUNVbnRBbktw?=
 =?utf-8?B?T2lOOU8ranhoTWd3YkZtRlkzdWFhQmlFRmU0WjltSnBBUm54MkN3dlg2RmlF?=
 =?utf-8?B?QVZhN29zTXhiWFJmb2hPWDAwT3UydndacWtHZ0RrR0F3endrMzBtM3FMTmh3?=
 =?utf-8?B?R1JiU0lQaUlIQWhPQ3FNWnhjTFFMSHVPZG12STNVWUVGajZSSm03SkdEa1BJ?=
 =?utf-8?B?Q09pU2dJcmFMK1ZPcEpNbThMUUM5TUJnNEcxSHBscTBSTEJ3cUZYeFVWTWV5?=
 =?utf-8?B?djhMRVJNeHIwVkswTjlHeTFaeFhxZDRIb0VvR1dsc0tZSFpKcUVXdDFIeXZX?=
 =?utf-8?B?MHB3dW0wNGR1ZlpHVFVjVWVjUUxTNHBlbldCQmlFZ3RJTWg1YWg2TVNHVFVq?=
 =?utf-8?B?cElGWUo4MlJLTXF1SkhFSDVjcCsrMzZrcitkL1E4dk5Qa3NSQzBpRFQ0MGFs?=
 =?utf-8?B?cVNONTl4RnFTU0tFSXhDWWtSOU9LMTZwSTBpK1dHdS9DNXNQcW5LSGVBbDhJ?=
 =?utf-8?B?djZYdEF1cy9RdWVSOHJXZm93RmhsbGF1cUF2YTBtS3JOSlF1dkdyUXlReFBJ?=
 =?utf-8?B?T004SUZaK0tzV3hGUjZGU0phSHlmMHJRMkVsMkFFNWZvNmQvOFpRK1NDK1lX?=
 =?utf-8?B?alBTY1NoK0tOODd6dlBwWW9JWnRCK0dXREwrZ2FEaHpraDFHMUxubUV5d2pk?=
 =?utf-8?B?Q3d0WDNwTnFFc1E0bm4wcm1rdG1mRk5GZHgrK1JpSHZMaS9mMmJQTFY0NUJp?=
 =?utf-8?B?MWF0Z0NxODlDQk4zU1ExazlYNndHT0xDQ1M5b3IzUjBZd2Z3ZmZmUGRQUUxa?=
 =?utf-8?B?dVdvV2xraUFCSWNQMXpKcmQ5cVpmSEtueVpQdVZiNzQyU0Zld3dlZlB4Q01M?=
 =?utf-8?B?Q3ptcnpYcThHczJZN2FPOS9KVTFjak5ZOGZ0R0h5bEFjaldQWDlpc0ZhVWxx?=
 =?utf-8?B?OUhTRmhFSkpmZk1pTmNOb1R5cXV5RjkvMXJna1ZKU2d1NnlKTFltdHhINUZi?=
 =?utf-8?B?bER3MHVoWVBBY25qaC81dkc2YnVaMlQydmNtaFR5bjNBek1KQWRoU2cyY3pt?=
 =?utf-8?B?YkVGRlE3SitpenhPTm5GbytxOUcvL29TeGVoZDlZUkgwZEZ5TGMvTkE3MlQw?=
 =?utf-8?B?ZThUcHU2dWNGMWNPZ3l4enFXdVNkK2U0NFlFdGFqZy94NVl6OEZuRXNoOUNp?=
 =?utf-8?B?WUdPTmxlRHkzSW44aFYrMTBvTG5QMmVKbW9uMDZoUkE5cGIrajFpbTNQTzc4?=
 =?utf-8?Q?9YpiXVCNbLoRw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlBuNzhvOXBnOFZIeTVNblpvRWFDK3krMFU1Z0t0RG9qdW9CL0dTNk1yL3Y3?=
 =?utf-8?B?UU9FUEE4Zm1vY0lxbVE2d3BzUmZOaEVjRlp2Rk9IM0dYdWtNbmpEMjFiS1ZI?=
 =?utf-8?B?amZTbHZrOHgyV1c2eW12ZnAwVFViYm03VnlkZXJxeGlyQmxONVJJeGtEZUlJ?=
 =?utf-8?B?cXlCcDdWOUhCQlNOQ2o2eXE3cncrNzNETjJTNWd3cVRaTnZqeEg0UDhjWG1I?=
 =?utf-8?B?dkJxaWhXSnhBejlReGZUL1Q3LzYvc2pMQzJYMmRkZUJ4OTBSdUhRY3Y3Tjhm?=
 =?utf-8?B?Y1NwRHV6OWIvWlRzTmRJcjJnQVk5a2tLbnVoT3pYdDgvQjR2OFExT09pZGt3?=
 =?utf-8?B?bnVVdFVxYTFyV2JzRmtsckVuQlpxblQvREtCT1pKaWhWNWJGbUdGMFlkSHFn?=
 =?utf-8?B?dTBldFk4dncvNUkxZGZyZnBCMmNtWWNwMU9VWEFBLzJwQnRVTnFIUFNzU003?=
 =?utf-8?B?Qml5djI2UE1WV1B2UjlDVVNnSDJiMHhGdDN6Y3dnYXIwcmFXY1JRdHNYeTNq?=
 =?utf-8?B?bFVPNGxGaXZQak92aUhFcXJnVi90cTVEbUkvSFpRRjRxdUJiaDhZaXcxbzlC?=
 =?utf-8?B?b24rM3ExeGc2ODdrSXVqOVk5Y08zSUlYcEJXWTZ6M1lzYVV1TkF4WmFoTjJj?=
 =?utf-8?B?UEhxV2MzcDB0SUNLdkZDdHFCdUpDK0JnUkxiQ1dPN2tER052SGlXV1p4cTZj?=
 =?utf-8?B?TjF2amV4MnNLN2JkMVNhK3dFMkg4cDJIUm1YMUdHV2h5SktUTHE1aEtaTk1D?=
 =?utf-8?B?dUhENXVPOXRzL1lrVmFPUUJsQXBNMThPaG1Ec25GRFNSQ2dwcWwwdFZlbk5I?=
 =?utf-8?B?anRCZmxoUENwT0FKb1JUanRuUERJU0ZtTFdJQnFpSU1qb1BKV0p1cU5BdHZB?=
 =?utf-8?B?cUhxUy9JbzBJdzBPME5CSnZqOTBIblBibmM1dDJ1V0FXdGhTTFNPMXlnc0Jt?=
 =?utf-8?B?QURmcDA2eUF1LzdXb0h4MmxWWDlZdjR2V0FYbWxHaEl4QkxrckFBTm1UV0F0?=
 =?utf-8?B?UGhNeG1jZ2tLc3RodCs4S0VZaWdZZUxqWW5ZVWt4THN2OXoxZDZiaVU0c0tk?=
 =?utf-8?B?TmxmYUdjOXozeTB3cVRvRUMySEwrZ0Y2UlNtYmdRQ2I0djA5MDJmTzFqVFl0?=
 =?utf-8?B?b3AwdGs1elhIZGZpYWJzRFpEOGFiNWhYK3NpaDZvelJtM2xJMmQwamxnTURT?=
 =?utf-8?B?d0hOZ21iKzFNTmgzcDF1MFliOEJud3JvdkdOVGJIanFPZ3NLUGlpaWRqUndp?=
 =?utf-8?B?QXYrbjF4SElSbm9CaG9uUWp2SFRpWGk5c2ZvVTlTMy9JSE1RdU1ibmpUcFZK?=
 =?utf-8?B?VWUya1dadmpYR2loTDR5cUpPRFR0UDhscnd5MGxPaUZlS1dScWdVdnY2NjI2?=
 =?utf-8?B?ZXA5UFRBenNZdDMrNXdqbm9uK3ovRm5vUDNDSVVTS2hrd3RucTgvd1l5SXM3?=
 =?utf-8?B?SS9wSVcrS1BSM3p0cFFWdzNEV2lOeFVvZy84MTZ1K1JwQVp4ZDVIZ2Z0Sytv?=
 =?utf-8?B?cUt5azg4SVVpZXdKWGNpV0NFNDc5N0MycDZNelJRamo3dnNGa1RodGFpSS9l?=
 =?utf-8?B?U0RqODNiTFcrUFNrTEFtZHNvUUROR0hpU1piTzc2ZXdWOXhYQnV6TmxDY1Zj?=
 =?utf-8?B?ZDhQbHVHeHU2Z0lNNElONldVVXN2UGlWRG1Mb0drcy9SM3BzcXdyVkw4Nncz?=
 =?utf-8?B?TXd0UDZtT3E5SklSaHdkdmY2WVhVdTlTbCtTSjRMb29FalJ6dHQxeTZnN2Jj?=
 =?utf-8?B?V1g0MUc0bnhUK3ZXL3NlUTJYMk03QVhkekRnMm1qS3FjT1ZGVmdvL2ZWOE96?=
 =?utf-8?B?TG9QdXJmRnZiN2xtNnBuWnNFTDVlMEtJV0VZTUlCL0tEWitRVmF6UUJKbWZO?=
 =?utf-8?B?WTNFbnhFQklSRGJqS0U4cnNJcGt0TW1rT2NNR3cwTXJVU2l4QmRVbDR3UEJi?=
 =?utf-8?B?L2JOM1NOQkxXL04vc3o2d0o2TUNqcUN3UUIwZG9XV3NhajBENTdaMmx3NnRJ?=
 =?utf-8?B?blhqUkpGVUxxeHhwL1kxcFNCb2tud01YbWlZZTkycmU3RXMyVFFvQUFEWjgx?=
 =?utf-8?B?VFUrZzJpdWU1RFhLZ05kY2pQZkNoSVZ3SlI0cGxjRTNvS3lmNlJpZ2g2eVRp?=
 =?utf-8?Q?lelH4vMISk3iNIEcYhf2V8oxs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab053c04-8dde-44d7-1b8b-08dd4f2c96be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 08:25:08.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvLxiD3aev8Xy8CfQ492043QqPGIOpfn+qa+AF5upAkaOWTxAT3jKdFh3r3v/iWAy2WmTWnfytBBx+/ovx9Eug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492

Hi Peter,

>> Apparently not, it ends up with:
>>
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:281 event_function+0xd2/0xf0
>>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:286 event_function+0xd6/0xf0
> 
>>    remote_function+0x4f/0x70
>>    generic_exec_single+0x7f/0x160
>>    smp_call_function_single+0x110/0x160
>>    event_function_call+0x98/0x1d0
>>    _perf_event_disable+0x41/0x70
>>    perf_event_for_each_child+0x40/0x90
>>    _perf_ioctl+0xac/0xb00
>>    perf_ioctl+0x45/0x80
> 
> Took me a long while trying to blame this on the 'event->parent =
> NULL;', but AFAICT this is a new, unrelated issue.
> 
> What I think happens is this perf_ioctl(DISABLE) vs pmu_detach_events()
> race, where the crux is that perf_ioctl() path does not take
> event2->mutex which allows the following interleave:

This one was only with perf_fuzzer, so pmu_detach_events() code path was
not invoked.

Thanks,
Ravi

