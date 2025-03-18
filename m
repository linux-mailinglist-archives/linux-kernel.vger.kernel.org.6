Return-Path: <linux-kernel+bounces-565554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F043A66A89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D256717CBA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC21A08A8;
	Tue, 18 Mar 2025 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qdRZnztj"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196CF1DE8B7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279660; cv=fail; b=VpA7MEllHbdX969ZkLFCE2+bA9pcm9D7E5Kv39nL4H1ZYLEx2U3cOEow83kp1czwodStqvE3TpcnBIj5gEnU8C3pFw5FxI4IL5oKki15bB0Wa4LVmU0faLcvcfHpxqG2M1BfMwiQUIYpr/PVITaM+lLt/Ypq11jvuHN82l3qfi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279660; c=relaxed/simple;
	bh=0ZcF9xGGbKK+qCPrImijNkZBYcPG5Iy5J7UJY3galFk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hxwDLZtGjDu102LJv7aXvw8Xf6USag7vdQe5yrPWSoyrEn6S5T3qetpY98k8YI0hqJ8e3jFVKZcBij2ExbXtTChKjKbcqw6tSCbKFwPRuUy69k9wnyBJ+EBTq9ManfUGbU6RnhFeRhBP7ZpOF0WL3lOrE5pawkcairRM/5tEQQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qdRZnztj; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=On+RyJIJBS3QzQSxyZELQHquOzbqd5N80yjg0BOUqzOUhoUcnHm9YBCZIa8OckWZ57vRV9+TO8KzJ0F5R1ajrMZ0sX6x9I71oIO/iEz6oO523tmnLSggALF93JzRe8hKKGeS/X7VCimw3d3YrTlT203bWH/nhSpUryyRC77boy8V3Ldq019UyAXHAOPDnD91UrvCbp0Nt/Ktrl1bqH3nAfzsvaQ2kzJqYlOyBbVvSRWgUO6p4xvG/R6CGpDBjhY6+hwbub/Buj6Ahv21W9f9svqcPFT2IgJZ5YOw8BZcA/Fp5AGvL+8Jntk27WOY3dW1Utv7vQ05YXOHEUH+B/YoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn1p5iSsvMH37WYhUNKQXfAQBUcBdR4z4gE/oIopV3Q=;
 b=Iyby9AtRqCNg6+vKNFIT249z/Bw3sfn7QxaopDsgcJvs1SdVTTRJNHc+ACzpMtZaRW4OtiOke0bo7xOLMBiRZR+sfoM0hl1uVdwO2JizsY0U2COLlv/6ID7a7VhZB+ysJmGLSIvA7RzLSj9ej0lg7am0jAQLnyvXoR4EsQJ5M7U3EzbCI6uR9b7JFjs89jA9zh6gQxwEc/lgbAGdBoESsjOWbgH2x7UzBbQHongGN2tyI8IOIVzljku1yrESG6WDnjK4EWPW/1ReIMKwP1s7ZaYEeppIDj9ejcK/7Vn3i0h6TqeRnSx3k3wdWk/B2cdr6GHw6BmqXK+qIB8eB6h8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn1p5iSsvMH37WYhUNKQXfAQBUcBdR4z4gE/oIopV3Q=;
 b=qdRZnztjYsjmUMV2LGqkzMgBDvQ0Kmhuu5pvWXtkpwHDE27B8s+N80XUmoCBtfXu/AcUEXveUTMUbhNf/b3PUypzRTgMtf8d5eOY5D6B3NgHh7ZZ+0f6hHwjv1v9/OTFR1f+YUTYMTuzNTZdKNvQvBYYfEV6h3+TselViKdpGmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:34:16 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 06:34:16 +0000
Message-ID: <1afff957-4e53-4c86-a6de-a1075ec13d50@amd.com>
Date: Tue, 18 Mar 2025 12:03:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Kernel daemon for detecting and promoting hot
 pages
To: SeongJae Park <sj@kernel.org>, Bharata B Rao <bharata@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 riel@surriel.com, rientjes@google.com, rppt@kernel.org, shivankg@amd.com,
 shy828301@gmail.com, vbabka@suse.cz, weixugc@google.com,
 willy@infradead.org, ying.huang@linux.alibaba.com, ziy@nvidia.com,
 dave@stgolabs.net, yuanchu@google.com, hyeonggon.yoo@sk.com,
 Harry Yoo <harry.yoo@oracle.com>
References: <20250316220034.38121-1-sj@kernel.org>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250316220034.38121-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::13) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 47865251-a553-43f0-750e-08dd65e6e773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlBwK1V2MHEvMGQ5QUhrK05hUDQwSDlmS2w5alV0WC9JajRzTjRpMW5CMXYw?=
 =?utf-8?B?TXhCS2k0SXY2T3UxblNGZ1dtSkNCZElBUlRwcXhLNlJqaXFuekF0Zm1jaFpW?=
 =?utf-8?B?V1RlRlpLeEl4Zlc5bXhVOXpZYUZGaGZrRy9udlA1cnZvOEFFV1haYXZrNStM?=
 =?utf-8?B?SmpzL1JWL1V2c0doQ0dFeFNXeU9lcHduN1BHRVhacWtvRDhBSk5KcU1UWHJx?=
 =?utf-8?B?cXBEWExZckhuSHo1bmFobEdWWXVranpSTEFCM2pBdWU0d1Nwb3kxaUNmditB?=
 =?utf-8?B?RFc5aFBDaE9uZytGNTRRaE1IeFFodHpuZkIwTDZ1ZHBUZk9IUXZYTnMrMTlS?=
 =?utf-8?B?T3k1d1NDdkRlZVhyVlpFWFFTanpTTTdCazNLMzhUOHQyYllSKzNLbjZ5V0My?=
 =?utf-8?B?T1NnOVcwZDc3SEorc3dtb3JOQXZyc09ia3ptVlFxQXdKY205R0puaGdUbHNt?=
 =?utf-8?B?ald1eXBieDBGY0Q0YXRya1pTb0FkMDBTTC9yTk1KaFp4bThGMC9DTkZRb1Nh?=
 =?utf-8?B?NmVyTEdHNyt3Uzlwd1UrYlJkR0NKMU5YRi9ObzNoRFQvRndZdTZsaURsaXpm?=
 =?utf-8?B?Vi8vckVBN0lTeVE5WDVFMlVDM2JsSnlxR1J5Z3pKbFBsbkFZczZWRWJXb0lt?=
 =?utf-8?B?djdkSDZvdS9HT2tQc2VicjBvSDFyNTRmSzRJS0FXc040U2J6cldPaXAvS2l1?=
 =?utf-8?B?aE15Y1hTYlpVVEtRNEZaUTZxNkRZeE1wNllYd1oxV0lEMTJtWCtxN2hYaHl5?=
 =?utf-8?B?UnJORjJQMjFRWjFSKzBJYnJQRk9qMmNRSGNEYUJpcDZLeUFuVTI1MWhFRE5n?=
 =?utf-8?B?anlvdFRGQmtRWEd6L1VCL0JSK2drRkx4NUpDM2d2ZVdtN05ydUhOd2liNjBU?=
 =?utf-8?B?NjQ0QWJmTkFhZ2phNjNybEpmSzVvM2VoZW03UHZwbUQ2eUhDRWhwN0hiamx3?=
 =?utf-8?B?azNoSlhCNGNkVjYyZjdpRklKWlpaYWEvMFJrREFBeDZiK3pxdElYSVdRcXFz?=
 =?utf-8?B?V1B3Y3VHNkYxRHVQR2FWY09aaVRVaC9sS0paZG05WjhXd1ZpOVc3cHBFRmJw?=
 =?utf-8?B?aCszVjMxTmlzcW0yZnB1S0xSQ2xUYzVZRmltOTF1YXlwVE5OaW9JTEthbnJP?=
 =?utf-8?B?azZuZjl5YXA3TGxMVkJDbXBPd3FuUlZIUHM4RFRqQUhxODVpTUlVdk5MK0pw?=
 =?utf-8?B?Y0lWWHBGOGpxUUJsL0M2dXFmUkc4TWkzMVVLNXJQaGE4aUozVktDK0dBMFNn?=
 =?utf-8?B?VEN5U3ZHTWd2b0svT1o5eWRNbnZxSmM3MlBkZlZFQ3FiQnNaK1FLd3oxK1NN?=
 =?utf-8?B?MEdpcFVSUnJubnh5c1RxVkVhajJoQklRVjBJaE1NSkNYN2lWQi9xczJFTVpr?=
 =?utf-8?B?d3dpc0E3YUYrL1hsSWJDOGszdnREeERnMlJjdnBoMXBKajRGRHJhQktJS2FU?=
 =?utf-8?B?eURKQmhhcVhsOGJzY2FZU1Jra0VXdFRZTVBQK0p5VXkwSnJ4bTRnZzNTam0y?=
 =?utf-8?B?Ni9GR0lsSzZ3dXQ0TFQzWHR4cXBrdGZ0ZWl3M295WWxHakVhdnc2ODBSUzBS?=
 =?utf-8?B?a3NYTThaeFQzWWZvV0RLZ1hZYnNnWmJhd0FnQnNqQVpKSXNEdzRkOUFHbHdu?=
 =?utf-8?B?TlAzTDVMT0h0RU8xNDJDSEhMUU94V25sMmZpV1JvdGcrc1cyTjFzWHlXYmpX?=
 =?utf-8?B?WUludThiSG8zVXpxY3VlSjc5Tm9WRWVGSlVTNy9IWmxXVlljTmpJdHp1c0dM?=
 =?utf-8?B?MVhVVGRGSnd6d0tyWnViVzIzWXR1emluTHNpSXI4ZUNNNndzbmZyWUU5YW45?=
 =?utf-8?B?NitKWTdNSTdHSCsvUFZaQnRhWEM4TG1wY0FGbG9pWVVHbmx1OTJiYkY4c1VH?=
 =?utf-8?Q?QX10HqDSYfbJY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU1ZcVI1L25vTENVaXg1eG1rZ3kvUEJVQUpUTGl6WXFXK09jVDV1U1lKU2VV?=
 =?utf-8?B?M3dFTmgva1BtNnNQeTI4ZFJaMDRrWVR0d0FTZ2dkN1NRN3JhaGlTUW1HOU5P?=
 =?utf-8?B?NDVOOVVVT3kxTHRRclhPVjJEMjhEcXkzR21RMGdKb2hDdS9TVkI1S251VlNv?=
 =?utf-8?B?aHR1NVZ3SG81dWhpV0lxSVRVMjdld05WclNNa0RSV2FvaWRFZnVsYThUNmI2?=
 =?utf-8?B?T3Y3VFZOSmdRcmxvbDhYL3lad2NUVWJtMVJlNTBkaXp3ZkFqaTZXRDhHZis1?=
 =?utf-8?B?TDVyWGNmdkRyK3VDVzM5dFNWNklSSW55ZS9uKzBvRXlUMThhYkwwYUhxZWhE?=
 =?utf-8?B?aTdmM3JYUlFSMXVZMWw4VWpQbUVXamdmZUN2U1FqMjNzb0oyWllUMXNjelZQ?=
 =?utf-8?B?S0VvZnlTYzAycU1XQXVpRHN6MGx3Rk5aTDFPOUtFazRsWVJvQ1dIZnpQZk5K?=
 =?utf-8?B?QU83QlNFb3NQa3hqS1JtaUNXeDBZVy9jZHlzZkJJNko5bUxnbTFydFpuRzVN?=
 =?utf-8?B?RnppeHI1ZzYwUXBxTkFSU252UlZYaU1hM2l3d2hRaWNHMDJJWVA4SnVyMUpY?=
 =?utf-8?B?a0d0NlJyK0szQi9MS1JwMGc0bE9rMzVWMHBzYU1iRjFPMjcwc0tJRmtLdytF?=
 =?utf-8?B?TCtibXQxK0J4cFkyN1ltUmZoWTZpRWdPVElSMjNkbndqNmQ1S0x1Nkpkb0lu?=
 =?utf-8?B?N3VBRWgwbFRJSjZiY2FmNm5FYUlBb2pWdUh6YjROZmdqZVZJWmFUQ3BwS2xy?=
 =?utf-8?B?N1RqSEpPcDBheXFJVDJ1MUtzVGVaTW0xNW1LMmVPV291OG84RTgyU2EwelBW?=
 =?utf-8?B?Z0dEeWNXU3ljOUVwWTFtSm9USWQwc0dzU0dmZkxUeXRCeFVEVXR2L20wREkz?=
 =?utf-8?B?cTFXKytoc21CQTVLbGpHeDRNVkhQY1Q5OGd0WmVDWTQrR2tIR0VuTGloN1dv?=
 =?utf-8?B?aXE0STFVM0pnTUZXdTIxdUI5Umt6aGRQTHFJY0hxc0Q4STNGRnR6SWxPckhG?=
 =?utf-8?B?Q3hKQzkwZjQyS0d0VERvdk5LUHFYSjdqTXpvTXNnSXZyVUNwRzBJY0Z4MkZm?=
 =?utf-8?B?eDRVQU1VcElNai83MmpmQUVTRzY4MlR3YzJFcjBxSHRpTjV4KzBhRDUzcFgz?=
 =?utf-8?B?RmNJN3ZuV0JQMVRCK0IrY0J2ck8xNlRJOVRERFNhMlhNMmdjcDNPNGNLMlBN?=
 =?utf-8?B?cmFKU2luWTNzZHdiNThicHBaaUl0NVBybE9jNXJGWWtieWIzMDdSWGNRT2Er?=
 =?utf-8?B?dFBzSnh6eWtDSytYaTdOcklndjhjbi85RFF2RGs5YjQxaks5TjhqL2JzUk92?=
 =?utf-8?B?SG9ya2xuR3ByVENGa1B5SDVlU3RLMkJtaWpLVHVkUG93dWdRTTE2dFRPekhi?=
 =?utf-8?B?bmxnNnRvMmRWM2hEQ0FCVHA2M05wTHNiUm9hQnV6elJ1bko3S21FYXVlMDY3?=
 =?utf-8?B?emVOUFhQRE5PRmN2V1ZrVkI1LytwYlRIVyszQXVRakxsQ0syQkxDWEZqOU03?=
 =?utf-8?B?S005Q3kwcExZUC93Qyt1QjZLbWxZNW5ZVHdXMXpsaTFLbjNEOTc2Zi82dGkx?=
 =?utf-8?B?L2Z1dXZZaDAwWWNnUmJmM0NnbVlMbGl3ZzAyUHdGOXV0V1kxcitmSlpWSFhq?=
 =?utf-8?B?ZDU3SDVGVnRDYUh3MFJwOFE3TGdyMXFwcitkUUsyVjRkQXhCNVp1dXgwTmNr?=
 =?utf-8?B?WW5lTTI1YzZRTEw5RC9tbGFjVnBjTG0yU3JLSWhJSXpiUkxLUmRHR2h0Q2cw?=
 =?utf-8?B?QXdxMnN1blNhNkZQb3NYSmZUS3ZpcTgvcEJZNVJSWVV3RDdxZ2NmekY1T1pO?=
 =?utf-8?B?bE03RURzQmZXZWtsZGNPZ1ROMytWUkZuM0F5SVdUSlFyWkF2R2lTelRBZkxu?=
 =?utf-8?B?c2hMcDNabytvTHZQUFRuL2NjbllRakFWVkQ1RlpwRldUVngwUkljaE91ODlo?=
 =?utf-8?B?Tjlwek1Pd0p1Tk1IMjJYcGN4YnJ4K3NybVcwaGVIT05PbDFmbEs2NU9DUS90?=
 =?utf-8?B?NUNiNEZ5M3g2N0h1RjZGREFVR0krWG5LYzhhQkR4TGpwbElwNlUwU2NPNlhJ?=
 =?utf-8?B?RnBlcFBzbFRyeUU2cGphdW5ldjNWN1RGQWtWMDRDUG1HbkZ5dFdDOVhCK0Mr?=
 =?utf-8?Q?h+Ux3h2hy9YyzM99mBMj17UHP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47865251-a553-43f0-750e-08dd65e6e773
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:34:16.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI231n6Wq6RJSNVmV1d4wXavwGxS6FxO0iHEM6j9cDl3qliMENAn/MuSsJdAW8tHFmFy7wNSFRiImPnOlesfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802



On 3/17/2025 3:30 AM, SeongJae Park wrote:
> + Harry, who was called Hyeonggon before.
>>
>> I am also working with Raghu to integrate his kmmdscan [3] as the
>> hotness source and use kpromoted for migration.
> 
> Raghu also mentioned he would try to take a time to look into DAMON if there is
> anything that he could reuse for the purpose.  I'm curious if he was able to
> find something there.
> 
[...]
Hello SJ,

I did take a look at DAMON vaddr and paddr implementation. Also
wondering how can I optimize hotness data collected by kmmscand.

DAMON regions should be very helpful here, But I am not there yet.

will surely need help brainstorming session post my next RFC.

Thanks and Regards
- Raghu

