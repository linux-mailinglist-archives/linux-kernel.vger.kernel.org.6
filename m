Return-Path: <linux-kernel+bounces-254525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD0D933452
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA10B22BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEC13D262;
	Tue, 16 Jul 2024 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bXR6d+WA"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967D13CFA3;
	Tue, 16 Jul 2024 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721169815; cv=fail; b=N3Osgnm2GN0Za9AvUDDjtq6cFs0lFN1KbmiCUErhDimvJ6x/pHsTSTodmrZexplzLCeMOcx0yUiZjoww6cAYl2nAokmbYx0rm4czTR0gMEoq2MW1Ykx30BtqVdH0muPyuCvT/vKWfPYwt4/eA/QoO/C6SJK2WFtm7Ybwa6FfdfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721169815; c=relaxed/simple;
	bh=BC5KX45R5Hnsn6KPMfXDYsKKtsZGrnDeFwG/l8GvTSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NVmPgaJyGxDeX5t8QbT3aZqZvprBb4f/kcxvul0+cuN2Y9v0+LMV8q8ebuYFhSo4+Z0GWmQrKFXwQdiFH+mTh4Pi/nPupsVfr/25vHG9u/0DiNqOZ5GZQkeIPbi5sEn7i4mBXdqSGliJ3VKNfGNOP+Sa5+ffUB9M4cIU9tVEwm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bXR6d+WA; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oq5qjeyJ53qkTL7ChxU3BdtdlNTQaCW8Ud/rOQW0eHPqgNJoKqm9uAf9yaKZFm+QkrLX71ahXpXCMAHQht3UjjtQFxLEIOn04Rzoy5bD5j0vSGbFqwbX3qed6/nO34AJoxWKdQLPORw64LQSrouxSMrbJ8rxmG679zQe66v3Y/FQphhPI6DEFNIPc6gCNqHst5bH+hmYUENYDZ7PDxZf0kEkE+REOQM89ol+K6xFM7E8zc1EqXNdgT3lXeZBGoNNg2J6VvU+hIfTkPaniCxqJrSv8VykznVfOeBAIVID+H7YVHqHQTeEYDKxgW6KXDgjFHz7aL1xFTWRtswvP3iU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evYZ0s/dtkYdYLeCfJ++45KYO5dISUnQpV5n8bo9NWo=;
 b=ypINjNIZalyOPRYNPfEARUA2WeYdgyuLxfjARyVHgeU4pag3C8J5Wj2SJdpbY24HPZIPOGWTBScxP0VoIcwyo3rkuKyIJ+VXtc3D7X1ZHqvUmuliukUIDj0P1Rnos2gxrqV9GTdzpBRJDY7vNZxuayKKDnczXz6UfIujz5aTFV1p2PBzWQ1iFWGIS+Gm67kGjOotcw5B5n38wdeYbJ+XUwn5n+nKFsyynzk2VfYJy3u21dJf0csoYrXS8B2WR9uvUt7J8Vu8J6Nsx87Nb8AeDRtLzgFFQJdhF91Q2ZeZhZErdxDW9v7MeWpsh+/NCLb/pzSJrUU0JnuutCmsJK69Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evYZ0s/dtkYdYLeCfJ++45KYO5dISUnQpV5n8bo9NWo=;
 b=bXR6d+WA/eSQWXlDjC3GoNZlLgoyRrtin4FvRskKoXz0L2/dKXjS/QGgnG62vPH+8egZvn/2UkxhUSFvt9xOTb4l2w9gMxgmridd3LdUI3WZ/ocUwLS1l/TFbhj8VX4im3ciMcloiMlsK1wdBLe5+Qh+t9Tutdu0t28JQuT/XL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Tue, 16 Jul
 2024 22:43:30 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%7]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 22:43:30 +0000
Message-ID: <11f0276d-56d6-2977-49f8-1d50e7246382@amd.com>
Date: Tue, 16 Jul 2024 17:43:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 10/20] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
 <f3f03d4c3518474d3e8a591c22d965ba5b934361.1720043311.git.babu.moger@amd.com>
 <6a68fabd-9a37-4183-8234-36ab8fab9b5e@intel.com>
 <b10fbeb9-6ab8-4cc1-a786-9a62faa27946@amd.com>
 <fbdccb3a-031c-44ba-aea9-36d22096a28a@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <fbdccb3a-031c-44ba-aea9-36d22096a28a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:805:f2::27) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: bf402937-57cc-4c7c-3363-08dca5e8b695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3lqaEtrYUNSck5KU0pCeVJhdW9HeUt6UVhvZnZwZlE0R1FQVUd5MHp4MTd3?=
 =?utf-8?B?WnovR1QrR2FjQ29vQTZFS3hTOWs5WEVzazJTV2tjSFlQRVk0VHVrZDBtMGEy?=
 =?utf-8?B?QmtwdWx1QlRHSnFDVmMyd1JTcXZ4alpXd2NKV3hsMzJNbkJYaGpDZkFkTXZW?=
 =?utf-8?B?aHMraTIwd2tPQzhJUkxqSEF3OUZPWVVWK0J0WkcvaUE0NXd4a1ROZHQ4V202?=
 =?utf-8?B?Y1A2b2VIa3dpQ3lEUmluQlNUWkpvMkl4bmd3emhGWkRycVRBRjFvUGRnTmRO?=
 =?utf-8?B?L1lobzNqV3RvNUtMbGo4d2dCZjM2eCtuVjVUV243NEVtOVkyVGtxc2ROY0l6?=
 =?utf-8?B?TVI0RlhnVlJlSlc2YnV6NTMxLy9XZmJXaW5Md2VFUU84SVVxNlB2MGFBZjVY?=
 =?utf-8?B?Zy8za3Vqc1NrSE1xaW0xUmIrQWs1Q3BMWjNPUVcrcjBSeElBU3ZscXFSaTJZ?=
 =?utf-8?B?R05XdXpwbFN1MkdhU3BBSllHUGlVV0J6Tk4wUWkrMGxoQ1ZPdzlaaXV3aC9Y?=
 =?utf-8?B?TXFvWVFwVXJ4bXNtRlhFU2xqTDgwVzNhVmN2cUx3U0xqbVVGU1VpU1I5WVY1?=
 =?utf-8?B?VjNwNWd0ZU43WDV0dUNLbU5LbnI4bVRKQXdkeHpBSGZ4Y05yREFpTVZKSGc2?=
 =?utf-8?B?bDJqeXFzdXZieHQ5RWFKTHhnTDdUNnMyWHlKTkVLeVdIdWE5Y2xzemhWNzNr?=
 =?utf-8?B?MXpVUndpQ2FITUpacUJmTUV3Ry9lVW5VenFaZHZVU1ZqR1l5SFlOTGNvbHR4?=
 =?utf-8?B?ZkRFZGZmckd2dFkwWnpjMm5aRlhhd1hrM0FZQTdmdmdETy9heW1JejQybzV6?=
 =?utf-8?B?ZFFLS0p4b0NmY09FaFpnNWFmU1I2b1M0OWtmdkhWeVg1QnJuOFEzRVFPZ1lY?=
 =?utf-8?B?b3I5TEx0N0FJaVNtNjRtR3gwNUpoMEJ4TVdqcjRzWWIwYWJ2MEdaV0xINzJs?=
 =?utf-8?B?MG05d2hyc1BtMmpOcnR1amNKR2FxYnhWZEJ1dUFLb0orZjNPVXRUTUJZSnNj?=
 =?utf-8?B?K1dIVEorY0pSUEJMUGRvZGNKK0ZXSTFhdXpsSk1PK2FPWFlGK1RTQjl6NHVt?=
 =?utf-8?B?bXF4K0NWVWlkdnlIcFJVWDZYSDhqM1JIcFNYa3BhUmZKdHo1QW5SQ016bkJ5?=
 =?utf-8?B?WVFJRWY2b0tUZTZRN1NUTm9UZzl6SnZLK3VwdmVZWnYxOU45Mm5RaUMxYVBP?=
 =?utf-8?B?VlpwSVRlZVk4bUgvWTZmRUZjbFpsVjdURU01cFlJSWhuUnhpUU9NYVJBbGpu?=
 =?utf-8?B?bTBUdGd6MGpFUjVzWUFhakN5Ry9NRGZRTExpU3JVdVd6UDJCU2Z6VTFzUi92?=
 =?utf-8?B?WUg4ZUl6R1NzWEN0SWtsMWxEWE55S0xCaTVTRDNCYzV0NjNFeTVXTnQyVlNL?=
 =?utf-8?B?dmNkQXRValRwT0N1d2Ewd3R0NHJrdHhlTXQ0bGxyU3BGTWVhZ3dYUm5pSXl2?=
 =?utf-8?B?MXRSM2VUL1NoU0JCeU15VDNFWllVNTU4VzVPbSs5Nmo1eG5CRUptK3BRdHlJ?=
 =?utf-8?B?YWVVYlFBUlRadG1Zc2pyLzZ4QWZCTzAzZW5jYVZqaTMxdHJMdW4zQVVNZ2pD?=
 =?utf-8?B?NS91SzVqRDBYWjdaR3hrcXU4bGdKZEhyd0JGR3JrQW5lTkh2Mm5VZGZRWEY4?=
 =?utf-8?B?cjNvKzRDZnVUTUdvZUFzMG5GZXZmd1VmWVhjY1hyUGxLY0pVejNIK1NPU3ZG?=
 =?utf-8?B?TFVueHBvN0FTckRITk5PenZWY3RPNDRicWg1djJLUFRRWnFDZVdud2cwWVdO?=
 =?utf-8?B?a2JGUEl5UVMyS0hLcWZ0MkpXenpWSGZJNkZJRHowN0dXTE95dUZpU3pHZ0Zn?=
 =?utf-8?B?eXJ1ZDJCdUVRWEVsUkhDZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVF2N3B5VkwvMmxtNU1IODdrNlJnOHZKSlkrK3hFOUNpcDFZYnROVEdOeXpq?=
 =?utf-8?B?UWxDTWUyS3E5M0pKc0JSN0s1c0JaYW51S2YxYUZCWkNxTCttY05JZDZyU1ln?=
 =?utf-8?B?dG02cU1ma3RySnFIUjE2cHJ3ZmR0K1VoZTNGTWxZc1FtZkFSb0RqbHlVa3ZC?=
 =?utf-8?B?a1R5NWNHZEtsNjkrVW5NdDNHNUpNUXN6eU9ZMHBubVZIZVYyZFNvWUoyejNK?=
 =?utf-8?B?MXVqSkJwdFk4dzNHSXlCQjJMQStUN3NSbTNEWHMrRVpRN0NoMGlZVFB1bDhq?=
 =?utf-8?B?a0FKU1F2Ry9SdEQ2dFV3MFRMTy81bUQrWWc2VllHU2tEcnU1T1FrbFgvUWd0?=
 =?utf-8?B?MXIwYjc2Ris1aUxrY1hSekdNZDFwVVF1NENXTjdRcWlIZFBac1NWYjM2VHFl?=
 =?utf-8?B?cXVNcTJVaS81UTJEakRQTGJCdkZYeG12N3hXVlVHWEU4dENIdkRsSElHVC9G?=
 =?utf-8?B?c1lCaE9wUFhzbWU1TzFLM2lDV2YveDVadnFDWTIwaWFwUWJHRmFyRTJyR1pI?=
 =?utf-8?B?Q0ZSOUltaldEUmFYRnp6b1VNakJQdEJCZGwxc0tzVWJ1aDUzTnU5MWdZZ0tn?=
 =?utf-8?B?c2dKN21nR2JndExZN1JFbVlZeUVFN2xKek1rcUVsRXRSRVNnQ3VyaTBEd3h0?=
 =?utf-8?B?cnVJVkJCUXBOWGh1RHdyemJBU2NGVUlTZG5sQi9EWG54RlBiZGM1cGttVCsz?=
 =?utf-8?B?b29lb0hEcEFkcFFhN3lxRjV2cDl3UXRvTHNqRXdoazFRdmtHUWZQVVh1MXFC?=
 =?utf-8?B?SEdyZTZHSGNQb21RSjMwdlI2Q3FJdXpReVJ5ZUVyWExDU08zWWdQWFFma0Ex?=
 =?utf-8?B?QjMrcmlwdzJ0Q1hGYVY0MkFIVkY4eitIZndWTmZGWDdCMGQ0WDduanhua3E0?=
 =?utf-8?B?VjVKc3A5dStTd1UxTGJmWVhaZjdxUGR4d252Q20zb0xzR3pTbzJUNHpsdVA3?=
 =?utf-8?B?THhwK2xHSlhDQzlvbXVJajcwaVNENUo5TGk4NFRCSWtpRlZFUUx4YkRWdWwv?=
 =?utf-8?B?ZEtIajgveUdTWkkxVDJUbzhKNy82Z0RjVWRCNDlVT3pEdFprTUw5RStrYVFT?=
 =?utf-8?B?UXdTaVNpT1Q1U0RkejdrOGxGMm1JVkhIUENLaUZNVU5zeEg4V2gxb3JWcmRB?=
 =?utf-8?B?L21IL3ZMbjNaa3pvQXJlaWpWbnlhUTJsUmRxMGQ4NG0zTmpSZThvelljVGtz?=
 =?utf-8?B?UlZQTll2R0VIaG1CUmJ4MkVUN1dRVnZEeUk3MGp5MVFqREM0bEV5L1VnVGFp?=
 =?utf-8?B?R2pOelRkbklDQ2E0R2RXL1dFNmNQZC9nbkJmZk0wOHBOWURBYkR1ektkd1Vp?=
 =?utf-8?B?Z2FiTDVtbzBLbHU0QTk5bHNPclc5NFVKQTluZWUyTytjd1kzd0dpNWVDakVP?=
 =?utf-8?B?c2FZalVvM3pBQ0VHcGhLWEcyUWR2MjZsdmtoTk5jRXpOWEUvWWVZSGZDSEZq?=
 =?utf-8?B?djFFUm82ZVhLQ3dLYy9PMXJ2YjdQanhJaU9yVVJ1TEZHVHNmWGNyTEJtY2ly?=
 =?utf-8?B?dG5yNkFiamVHdzNkakU0Vy9XT3BETkNBanJnemh6WmZVbGZGYUNHVC9ra2JP?=
 =?utf-8?B?bTQzVEJBVXhyK3VwandkUWgxL00wL1BDMi82ZDFTSDNYQ1IvY2JrYXRWRXJw?=
 =?utf-8?B?ZnNaRTdLWlFDeHRROEx6Y3d1NGdPMW1jeFo3WktHa3J4WmExbzVpOG5DdERW?=
 =?utf-8?B?WVJNN2NVQ1N6dVFWemxNSDB5TG9VTUltZ3VGZVFJY0thV1RyNU5KblZVRStn?=
 =?utf-8?B?T2pYaE9IKzNaNGtTVys4Zy9BZitoWlZ2MWZObXhrU3R1T0RES3ZMM0lUVVBr?=
 =?utf-8?B?V0ZkNHRWQkNGME1iZnZKQWtlQnpUL213TS9TTkF2ajVQTjNKb3V3Zk02T2hM?=
 =?utf-8?B?UkxETVhhMnovWGhveDV3NDN3NTNTeXhibHJZeEpGZlB1NFdTSlJZVHNmZmli?=
 =?utf-8?B?MDk2cG5LSjFxNTdlTXM2RWxMd1pkSVd5SjBNT1FRUUd4NnVxM25MZFNLd2l5?=
 =?utf-8?B?aDVsMjRwOCttNGVjdHhOa0ZRNDJxKzF2MCtTQjhWZ1NKLzZRYjh5Zld2NURs?=
 =?utf-8?B?Nk9nRVdlWnhrSmN3YlNXRVEzVWEweXZvc3RIeG5KYXU2NzhWdVBGbUdpc1Bl?=
 =?utf-8?Q?6kes5MY0uHGTDy2WqSDvUa0c8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf402937-57cc-4c7c-3363-08dca5e8b695
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 22:43:30.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDUyLxAW3kODPOgjoJIQueKdgVa5mpu49mDqBtu8PPGrSgEhYsKIVtkDWa3Fhl2H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284

Hi Reinette,

On 7/16/2024 3:42 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/16/24 12:21 PM, Moger, Babu wrote:
>> On 7/12/24 17:08, Reinette Chatre wrote:
>>> On 7/3/24 2:48 PM, Babu Moger wrote:
> 
>>>> @@ -662,6 +666,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool
>>>> force_free);
>>>>    void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>>>    void __init resctrl_file_fflags_init(const char *config,
>>>>                         unsigned long fflags);
>>>> +void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
>>>> +unsigned int mon_event_config_index_get(u32 evtid);
>>>>    void rdt_staged_configs_clear(void);
>>>>    bool closid_allocated(unsigned int closid);
>>>>    int resctrl_find_cleanest_closid(void);
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> index 7a93a6d2b2de..b96b0a8bd7d3 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> @@ -1256,6 +1256,28 @@ int __init rdt_get_mon_l3_config(struct
>>>> rdt_resource *r)
>>>>        return 0;
>>>>    }
>>>>    +void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom)
>>>
>>> A function is expected to have a verb in its name and the verb here 
>>> seems
>>> to be
>>> "config", which does not seem appropriate and creates confusion with
>>> resctrl_arch_event_config_set(). How about 
>>> resctrl_arch_mbm_evt_config_init()
>>> with proper initializer of the config values to also cover case when
>>> events are
>>> not configurable (INVALID_CONFIG_VALUE introduced in next patch?) ?
>>
>> Sorry. I am not clear on this comment. Can you please elaborate?
> 
> This comment has two parts.
> 
> First, there is the naming of the function.
> The name of the function should reflect what the function does and I
> believe that resctrl_arch_mbm_evt_config() is close enough to
> resctrl_arch_event_config_set() to cause confusion while also lacking
> an expected verb in the function name (since "config" should not be
> considered a verb here) . I proposed resctrl_arch_mbm_evt_config_init()
> as a new function name that has the "init" verb to indicate that this
> function "init"ializes the MBM config values.

Yes. Make sense.
> 
> Second, there is the work done by the function.
> In this implementation the function initializes
> rdt_hw_mon_domain->mbm_total_cfg and rdt_hw_mon_domain->mbm_local_cfg
> when the events are configurable. I proposed that as an initializer
> the function can be expected to initialize rdt_hw_mon_domain->mbm_total_cfg
> and rdt_hw_mon_domain->mbm_local_cfg whether the events are configurable
> or not. In the latter case they can be initialized with 
> INVALID_CONFIG_VALUE?

Yes. Thanks for the clarifications.

-- 
- Babu Moger

