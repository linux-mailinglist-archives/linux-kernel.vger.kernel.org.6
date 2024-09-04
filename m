Return-Path: <linux-kernel+bounces-314350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F9E96B22A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1F4282249
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2360013AD3F;
	Wed,  4 Sep 2024 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ym1XgMXb"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575A84A5B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432808; cv=fail; b=X4oJkqGzsN4v0Y2V/oVv8WYKq59Xs561Ud4goC+qf7FlBdJOCxewWeb0W9kQ4JkQPm9MjwWHCamUGHGhYOI5owKi8ASN7TsVjOmI/Gwn0B2A0m02EgQz2/EO/fcpkr/JhMPdP4s83CBJYBUZ0BdJ8nwholiMW52u9qAu/6YGZdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432808; c=relaxed/simple;
	bh=7YniIb2Khi8+KIVn19nJbN00sp+XzNjv2/QfQp+x4tw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uOAGIdRgZxXi/ia34707cWhZBvdPrppJgfyymhlEBPrZm8dk7slbonHlqelBrb2pYVIR11v7p6XGMpDoiuXaftSo4kZ6b2uE0H3VrFglZDxwg1x3O/MELXrg4wyQ0RJHmMWRjMSshqhLg4hv8WgSfLQOs6oLmzY2oN3couXizMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ym1XgMXb; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gV+mMMRmjQ2NQTuEugb8Mk0uA1gBMmMw3sI7tpNX9wEOlpxtmyJGKyY7ttXItr2ObeYZuNPpbu8BRRgGtHg6H+b23ng3aUXh0fQXJCXFgIjzVkfw59829T+i8IyTcDZhgBrYrLKBhVOfYqhmTCyknDHnUBX6TOKuDKSN1bpkN5GwXbhfPfEQOlqGMDtnVGFR5P0C8oVc4U7kM3kkwMTEv/1DoOQXUM6yYKN7++b5mb58tqQ+TwFUFiRxCgR93Q1veg8YlQCrCHVi6Hvd0wL/+0AFdEdkiCaN0qY4+sovc9wxcokf7c3m4A7dWAhDgyLlg2AqX57hM+cEyPKlM24CyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqwVeU/PLWtK1ipp7tKh+cQcpoih+uc1o6tG7M5LbqY=;
 b=XaUahTLQSLPZj8upbs+++Dbmpdeeb+3AiSC8wtEJN1b0vr8YmcBfxHVzXuSQ8OTPRsGyuYmPharTwBSa9K8tYp8+wG0dfyuUONkBGoV5Xu1LAH+UXkgPAYjZ9xswGglKE/JfdyE7q+T+uP+fcwKkaUxLqvjmlfkub1824QYm3ZXxCxBQcXmcnyAP+lDY+NSW+5kUapVv36IVwhMl58dZN8CO9ZOn3DbJ98F2R4lVGf8MiNTcw09xDxQrqwBDtcKEJOhCLJSxvWMyC1euwCtzbIyWpLRa76hE4cIl9ePE8V546IvWN1g3bb2zbJQg5VPkNISw0IgHx5ecCp1IH4htdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqwVeU/PLWtK1ipp7tKh+cQcpoih+uc1o6tG7M5LbqY=;
 b=Ym1XgMXbFKy4Icx6FkdeWky8Z7hkYBfqN4WP/kive4YMOyhfs8i3AlR9HTD/gBRkNVI+Wil98aV6TnW7WAAaZ/pJ+IaepKaC/p1Yiw+QuWy1hBrisem18hRhG7e1Z83QxBMKv3bZVlAvSL7efskoxxo2Ya+Bu2ESbN/SYZ4hbzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 06:53:22 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 06:53:22 +0000
Message-ID: <f3d3c4a7-7651-41cd-8abb-4417a3dabc6d@amd.com>
Date: Wed, 4 Sep 2024 12:23:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH 4/4] perf/x86: Relax privilege filter restriction on
 AMD IBS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
References: <20240830232910.1839548-1-namhyung@kernel.org>
 <20240830232910.1839548-5-namhyung@kernel.org>
 <20240902091232.GB4723@noisy.programming.kicks-ass.net>
 <CAM9d7cg-7USE-Ofusc1VDpr3qtviX4xZmoKmBjmEfBDw9XJ+nw@mail.gmail.com>
 <20240903085454.GR4723@noisy.programming.kicks-ass.net>
 <CAM9d7ch8fwk-o7W6KrTgtJ5n8-oVMGqzxvW_zd_hrcWFoE2AHg@mail.gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7ch8fwk-o7W6KrTgtJ5n8-oVMGqzxvW_zd_hrcWFoE2AHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::22) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1c79bc-c2b4-44df-69bc-08dcccae4464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWFHcmYvejdTUkZ0WmUzYVZBcDBOOEcrdEd1cmRLcjhkbE0ySWR1UERWZlRE?=
 =?utf-8?B?bTZwTmVaaXdLS1lISDN3M2dVRngzbzRMRXBheFhZUWtnSCtRRi9FVHdDbU5m?=
 =?utf-8?B?aFhnR01BMXFUSExoVFkyUjlHYnR0YXdma1JJYlc0US80cXAwK1QrVTAvcXpy?=
 =?utf-8?B?dTF3UUR0KzBMSmdLRkVRTXpUTzMrUHB3eVdqR0ZYRHRlYXNINVRQT0lLSmIx?=
 =?utf-8?B?YUN5Rkdmci9kbG54a3BVWlJLeG5YbjJzbFRUdWllbVROYUx6Q0tyTGoyQ2Fh?=
 =?utf-8?B?eUtjRUlnM2dKL0VaM2syMzQ3bzZoakpldUNyK0k2VHR2TE5CYVlFOFRVWUEr?=
 =?utf-8?B?dHBiSDd3SE1pdFRHQnphbWRWOWZqY0lORjZRb2lKWHFUYUY5ekNrdFBmRkps?=
 =?utf-8?B?aEUrbmJBYXljbkFPOGI0VkYzTmNORW9RdVVrbmp5STM0WUFaa1lDbHFnZnE2?=
 =?utf-8?B?MzF3WE5YZHRrYUJLVWdrQVU2RXFpTHgvek9MZHJmNkl1LzJaT2x2cUpYUW4w?=
 =?utf-8?B?QVdDamF1aFZSMnpreVRUOEpKZzBJd29tNkNSSG9sZ1hLbEw1YXk4eXlocmhX?=
 =?utf-8?B?SHlNcUJjamxya1VRV0lUbE5hekdRVU9wR1dFdnBhRUhQdTAvZHhtcG5zVE9u?=
 =?utf-8?B?WXhzczFlREh0QldmUmVXZHNSTDBrOWg3bWpDckNCT243cTFTd3YxVEhTS2ww?=
 =?utf-8?B?ZnBTMlo1OVBBWUVlZWtpakJHS3pRbXIxdmRwS2dVVGdsbk51NmFjOE9hcGdC?=
 =?utf-8?B?bXVoTTI4M2JhS0JYSzl2Z3NyR1dIMGdkUDBQUWtreDdxMEQ3Tmw0NVJ4UEtT?=
 =?utf-8?B?MERZSUQxa2pMWmE3KzZIRGI1K3hJbThnVlg3N3h3MnlIVjZ2Yk9MR1hqU1Iy?=
 =?utf-8?B?N21FUTc5amdTVzF5SDFwV0V6bnlPM0VVZTcvNUE5OC9sWjJzNllkeHJMYmhh?=
 =?utf-8?B?aWp2cHN1N0ttdFZzOE4yQ2FtekduTmVpalEzZDJoZTB0aUJTcDNnNytxTGtB?=
 =?utf-8?B?dERoYWExT2JtdGwySWxjaWptRy94Q0lZYXQ1ZCtsa205NWYvY3c4Y0loSldT?=
 =?utf-8?B?MlV6R2pDWEsrNEdDaEFtMFhlaFJJai9wbFMyWjRMWWp2TjVaMThPdXNOZGdU?=
 =?utf-8?B?TWdHeEdkNTdxcWFwN2FwTnI4ZXZsVjdYdUpjQ2lLc0Y4ZDVhZFk3NDFsZTk4?=
 =?utf-8?B?cHRKWXNxaE1qbVF6TnBKRTd1Ykw2MnJwQ2hHSnZSekpHaGFqd1pmSS83VFg2?=
 =?utf-8?B?N09ORWZCcTlwTTZjNG9vYy9tRmNZUDBZQnhOQWlSVXVpd3VVRHRVQ2RLWEZu?=
 =?utf-8?B?Lzk1RmU0QzBPdmRMcWREcjVGaXV5c3BLcGpScHljdDNwaVlUSzZ5bGpUdXhW?=
 =?utf-8?B?ZnUxS0J6OHBmZUlWMmdnQVRXRUZJdXRBL2N2VEJjVHVrclBXRlJHTEpOYmJ0?=
 =?utf-8?B?MzJqK0haOFlHNWZoNEwvT2orVyswNDdVNnQrWnF3YVVZV1JjV2JSOUZyY1o2?=
 =?utf-8?B?R0I3NmxJcmNlZkFTLy85ZHU2NmhTNDlHeS9RK0dUOTJFd3FCVms1T1JTUVJQ?=
 =?utf-8?B?eHRqUmJQVk84Wkl5K0Z4d3BEM1dENlJybUNMdE91c2JmeEM2OGUzR1cxa0Q3?=
 =?utf-8?B?T0hrV0ZrRGtwNnlsQmN2Y3pXR1ZUbFdPQXIrUTQrNjFEU1lvbnBMT2J2K0RS?=
 =?utf-8?B?YUZHSVV2NzJjd09lMnk4SWtORlVLanBRUkJhNFVKYUYvSDhUUnJTenh2M1Rr?=
 =?utf-8?B?amVFTW5mUWdhK2V2YkhmRGJ3a3liZDFyb2xsZHRCcVZPbUhpS3dST3AvS0hW?=
 =?utf-8?B?T1IyLy9Zd1Q3VlArNFNFZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUVMNW9HS3p3RHhXWFJkN1EzM0tRbCtoeGV3RGVONlQrMEFiMDZLTkRpZm9o?=
 =?utf-8?B?b3pWM0xOQVdWekdJY2hpaEM3b1V4Ly9SdzJFOXdqZTlBaXl4VktoNFZSZHJ2?=
 =?utf-8?B?OEdabk5XMGRBUlBmUy9MV0pLamw4a3I3YnNpVEtwMzhzLzZ3MUJ0cHBHdDJp?=
 =?utf-8?B?RENBL1FCcG1ib2ZaaDJGWFlxUU5iTnllNFNEbzhNR0VkTVBJRlU0NEVKVUpU?=
 =?utf-8?B?N3ZJZXREa1JtM1RNTHp1SHRVdzk3UVFrZ3ZPMVBQTDVjeDIxZlhqb3Y5YTc4?=
 =?utf-8?B?ays4Q3BtcitHNVpldFA0TmFQV2tWUXlCR3FBRHFKTDJQVnRTMlY5S0Eyc1dz?=
 =?utf-8?B?Zm9ZMGJSWjhQUko4bm95VWJlZjVUM1lseGlEb2VuemdFK2sxNEJ2YmllOHVU?=
 =?utf-8?B?WkgrTU5qNlRmZnZZS1N6aTJDVUdqS09tVVlhYUZZK0F3Q3F5aUw4b2I5YkZa?=
 =?utf-8?B?TlFZNnAzNjRZL2QrdlhaUVBHUFZXWVE3QVdzSUZEZ0ZpcTBDMVdvdmNtMjUw?=
 =?utf-8?B?OFA0N2JFeVFvWExYdHJ6dGlmVjNNVHR1bkJkTktaZDllR25Xd09Wa3BKNHlj?=
 =?utf-8?B?Y3hqamVOTlZDcjV0VDVqNzM5cGF3bTErcWg0REZCR21BR0o0ZjNtVGttVDNU?=
 =?utf-8?B?ZG5GUWw5ODdqcmVub1JaQkpmYlRsRktJVWx4V2Z4RHBTVlIyUEZYQjJMcDFu?=
 =?utf-8?B?cTJiK2wwNTJnbjRKRUFPRVdXTG1LbzQxcVZubFk3UUhkTmc5aXozWGE1WDJ6?=
 =?utf-8?B?WUFwMkdOV3Z6SWNndTFIeVZmNnoxYjFsK0QwbFhmTXBuQks5TldWZk0zK0Ir?=
 =?utf-8?B?UmwrT0tSTTUzTEVrVnNod0xIZzIzVWIxTW85U1p3cldwZVh1eEJyS2h3WUN3?=
 =?utf-8?B?TXR3ekhRZmViU1ZPNHJDV2ZNbkpLUzlDckl0Vmk2b2c4YTExVXNLZlgxWnRs?=
 =?utf-8?B?Y0FwU1ZBYVpwdmhqV0ZBbnhrQUUvemZvUjJhNE5IL2YwR0h6dmt3WU1rend6?=
 =?utf-8?B?Z3dDcU1EOXBZdy9HVUJCY3RmeHdVaTduNHFQT0gvTkZzVUJIc2hzRzE0dkZX?=
 =?utf-8?B?ajJhQ1VXODF5QjZ5ajFhUUVJV0VMRTZKM1k3NXpvclk1NC93MU9Hem4zb055?=
 =?utf-8?B?aEtKZU81a3dqY1ovOXFTZ0k5dldCcTIrOHA4TThVWVlnSjRCQkY4M0RwbWNZ?=
 =?utf-8?B?MnpLSEVsOXBzWjhFdDkzZG9FYzU5UlFWZkVhT2VIOEtERVJVWnFzSks1V2Iw?=
 =?utf-8?B?V2tvN1FxcVNObVNUNXJXRGVQWC9kRFZLZE9kdGdXckZRUVV3c3l6NVNoRzFT?=
 =?utf-8?B?eXlibXVHV21vZmFUU1lTV0gzS0w2OXd0SlExTHNpZUtQNFlEMGZ3dTRXU0Nu?=
 =?utf-8?B?N1YwbUk2SUkyRzRac3lKUGF3d2ZobnI4VFZJQndsT3RYK29ZdjNLTFNpa2I3?=
 =?utf-8?B?Q09hb1ozOWFSUHRvcGQvV1FVQ0I4WFpuQjFXWEJTckViT0ltT01PL2lsTk9N?=
 =?utf-8?B?MXc2RjlwNSthUTJOaFhHbUZWRUFSVXBVUW44NGd4WjFKR2VrRWdLNEF4TlNQ?=
 =?utf-8?B?QldOVEtXQnV0SDR1ajQ1VklScVJoOFNIcWV1T0JyME50OHdSZDFsTWkrWnlK?=
 =?utf-8?B?N3RLYWNUTU1JenZmbElLc2Vpb1ZvRU1nYkZpVU9TUnF5dmdPaWpOd25pbUVo?=
 =?utf-8?B?ak8yZUhOQzc5MjdNL1hqdnRVTnpxakFRWWlCTlJMZ3BQMzFzSEtCd2dKVllx?=
 =?utf-8?B?RnNGOG5WWEdpc2x4dXd0TnhnVHl2bTNLbmJrZlA3WXBrY0llWjYwbml0UGZ1?=
 =?utf-8?B?SGt5R1VkOXI4RDlvNUZVNUovSVp4TnJtSnRGTDVYLzFSR3JWb1ZNNzBtM2Jp?=
 =?utf-8?B?dnJ2NmJCK3BoVW1mTWlHMFFkdUxpWWJDckgwL2Z4dUNUcVUzUGtlNTJFY1lL?=
 =?utf-8?B?ektML1dEcVZMbHpYY3VqcFo5RUNsaERXeE54a3k3UWhDUURvdllYT0tJWlc5?=
 =?utf-8?B?U1JVVkg5ZDlvUmZPbnllak94NmszSEZmckdjNnhZeHFlOUtJT0NLUUtna3JB?=
 =?utf-8?B?TnVlbWtKdmxMT3ZHSi9KRUV2Z0hMaFJIN0ExMUZON3JJNm8rdG5BSUl3U0Yy?=
 =?utf-8?Q?CERc8r4PJuzA4DWi3TZGLnmap?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1c79bc-c2b4-44df-69bc-08dcccae4464
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 06:53:22.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4HHRXLz88+ghnYjegfylCQGEr5hfftPxtT1o0tJE126Z1YHJYwCiU1GTnC98ueJ3f8bRGJhsjnV0luD9GVN2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488

Hi Namhyung,

On 03-Sep-24 10:04 PM, Namhyung Kim wrote:
> On Tue, Sep 3, 2024 at 1:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Mon, Sep 02, 2024 at 10:30:19AM -0700, Namhyung Kim wrote:
>>> On Mon, Sep 2, 2024 at 2:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>> On Fri, Aug 30, 2024 at 04:29:10PM -0700, Namhyung Kim wrote:
>>>>> While IBS is available for per-thread profiling, still regular users
>>>>> cannot open an event due to the default paranoid setting (2) which
>>>>> doesn't allow unprivileged users to get kernel samples.  That means
>>>>> it needs to set exclude_kernel bit in the attribute but IBS driver
>>>>> would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
>>>>> we want and I've been getting requests to fix this issue.
>>>>>
>>>>> This should be done in the hardware, but until we get the HW fix we may
>>>>> allow exclude_{kernel,user} in the attribute and silently drop the
>>>>> samples in the PMU IRQ handler.  It won't guarantee the sampling
>>>>> frequency or even it'd miss some with fixed period too.  Not ideal,
>>>>> but that'd still be helpful to regular users.
>>>>
>>>> Urgh.... this is really rather bad. And I'm sure a bunch of people are
>>>> going to be spending a lot of time trying to figure out why their
>>>> results don't make sense.
>>>
>>> I agree it can be confusing but there are use cases where regular users
>>> want IBS information like memory data source, data address and so on.
>>
>> Sure, but I'm a bit worried about users not being aware of this
>> trickery. This makes IBS events that have exclude_kernel=1 behave
>> significantly different from those that don't have it.
>>
>> At the very least you should kill the IBS forward in amd_pmu_hw_config()
>> when this is active. But perhaps we should also emit a one time
>> KERN_INFO message when such an event gets created?
> 
> What about adding a pseudo config or format for a special event that
> allows exclude_kernel=1 and drops samples?  Maybe we could use
> attr.config = 0xffffffff or attr.config=1 or something.

attr.config is directly mapped to bitmaps of IBS_OP_CTL. We can't abuse
reserved bits also since they might become valid control bits in future.

Maybe use config2 or config3 which are ignored by IBS driver currently.

Thanks,
Ravi

