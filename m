Return-Path: <linux-kernel+bounces-345032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B9698B14B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5C0B227B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A083211;
	Tue,  1 Oct 2024 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KHYB4+K3"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8C28F4;
	Tue,  1 Oct 2024 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727741391; cv=fail; b=YFhucVfvvwdT+/5V/lrxpNngF0egXfgKog2PmglmTbXm5s62zC8rWpuZL4PwpUP3ILLXvVqGw9V747D2c+dc7E+R7BmKIQd6yRss5RyWhYuWxJSAjobo7OXLcTk5gsOBNuAWIdXDSe61BeY3eYu8KYMeEtDEmD+rMl4MLk+p3tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727741391; c=relaxed/simple;
	bh=A0AESAOp7vOLFjRHES9OmNxk99sP6ivNAFJeHOsI6QQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bmdgQByCOLbu/zyZ8ehrQOeHeWvFSVTPzXGReXFYm5edin5PtPT8bLaZsNODNEtj4XR9MOqHEb48YvDkfr5+S1M/SJ8C6zzdXdhECs3R75DlsTWb+7PQcKiWYJIdEgXsSjO4YOjYT4amWpudD3Cuv1+5fzCnaDWiuuP/ULZAmv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KHYB4+K3; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sbx0E5DtBtGZTpXuSk6TJ8PMTAuYuaFSuGCXvyZcFXlqrYMB8P3HTtqo8d83O/pLgVxbevIfkT279EN3pkvwhhtjzFPE4bdXdTY21j4AsqIX1DMct8aAIwGXcg5W6oTXnvodfimbpuJpZgLfaN41eA8corSOxbxtPJ9eXmlU82AlUDJVOH2jlczUmoDnAT1FlRYSJGSysSHWrNHW/+pJ42o4ohOv4Ha10qHULc2icFVB0REqopOSKfGE58XhM0bQ76cgat0Z0DhM8Vj2SWh+C+o5/1ek2h1I4Dl5iSKY+5n+Y7WDPq56SKlZ1vgrii6b9icTIuljKYuvJj87fcoIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L+Et1KayAjQ5UzsQ3GOUjv8+ByXpPQcHvCH5TVj3is=;
 b=aUQNe5qIgcpUCzX1aIr8dIVUXlbe3pEBQoVPkrv+BN0/jk3lhq+/ThaOmbY6hp/61kYswJEj3P2cdx+E2lMwdTUctZ3JcGzBcB6gcVhqpzA1vsIaOGPZfUUeqfyHK7KLP61/06eaPSaEmKLXa+RezsJPuFC/VagqsLib5ymg1LZN6DO54o5GRroJGBLfV9dbB2kFx/SS88Zi5SfruuBSp5wnkqtk7PXUE8utPfL8QLcPlEtmNlNNVv6glyiA94Wwxtsd23YAz7CX1Iy8y1s2lQgk/cWMLWTFzrRNxXDzoQPf7/0B7UMZ2fu04ziW3znqov24UZI2I5afYhLUmx5BCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L+Et1KayAjQ5UzsQ3GOUjv8+ByXpPQcHvCH5TVj3is=;
 b=KHYB4+K38kVTKMFkK/pncNBUMwPNSF91mZpZfv1JSAxOCKSQ+/PVksPp0N5txAruC7o3pcCUo4H7pVJrecFpyIdnOzw8tlJIpqk2ajnYB1cP2VdzCrhTaiZySbVRXKO+/PrPgJIQ69E8BCYI7ZncHgLI0+WqXXU3oIJaozT7uDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Tue, 1 Oct
 2024 00:09:46 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 00:09:46 +0000
Message-ID: <90493ac2-e1c5-f03e-9428-f6a147f37088@amd.com>
Date: Mon, 30 Sep 2024 19:09:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/2] nosnp sev command line support
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paluri, PavanKumar (Pavan Kumar)" <pavankumar.paluri@amd.com>
References: <20240930231102.123403-1-papaluri@amd.com>
 <f751ffe7-9900-4d91-9e7a-e560777725e1@intel.com>
Content-Language: en-US
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <f751ffe7-9900-4d91-9e7a-e560777725e1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0189.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::14) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d445cd9-8b5a-4965-bcfc-08dce1ad5bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck1GK3RmRmZKMk5SMEplNEw1MVNDdUZrcHA4elp2bzVnUzJEMk9KNmdCSjVl?=
 =?utf-8?B?SCtNRTA0Y0FFY2pHT1dnWnNTKzV3a1Vha1cza2Nlayt6Ym5sY0s4UmpLNVYw?=
 =?utf-8?B?SzdFVEhVWEVzY0UvN2tITlgxaEtyWHhNR1l1cGx2cXFzWkYrOEZKMFVUZEFC?=
 =?utf-8?B?VitEMmZQcTNlVE9Qc3JlUkJYRUJFUVlaM1JDVzdLVkhrNWRia1k2amxocncw?=
 =?utf-8?B?R3hxWEszNjRJaFR2aTNja2R4YkhIaXpabUxKY1hFbVA4Qm0zYVpGdUFqdUg0?=
 =?utf-8?B?VEpoSjZqME9SczJQYVlKMTFjb3JQaEtoOExjclo0ZlRjNnl1bklqbURxamFL?=
 =?utf-8?B?RHRnRDhxTlpHYWJJaTVtWitRb3dDeHRJVWo3SVFQS1RmcEJvc0NLOG5Od09o?=
 =?utf-8?B?aWxnbis2WDVHR0RpZGpUWDhyaFZPZTQ5dEI0My9uMndiTVQzaVpNbkEzOU5D?=
 =?utf-8?B?NU02ZUF5WGNRMzJ0SVp4TUEzMXhhSmVDWlpLK2xNNXE3ZDEvcmFFamE2V01P?=
 =?utf-8?B?VWJpOWZibitnVHMrNEE2VGtoRVJlOHdzVzVUOHF1Qlcrajl2cmUvSzN6R2hp?=
 =?utf-8?B?RlNvc2tJcHBBcUxvUnpLU04zamc5MkJSazJrd0tCRWJCSmVSWUt2cWRoTkFv?=
 =?utf-8?B?RndwRzJWVFRoTlBGRVJIT3VKUm5ydGJsQlZKamVZWUlNM2dOMmw3MngvVFJr?=
 =?utf-8?B?MlNHaGlmU0EyQ1JEQkNvb2xNVmQ3bmsySVhGdnEvcS9aSHhZVkJjODRYTk95?=
 =?utf-8?B?Nkl6SndCU1RxZzFrU0s4SHBCYXZ0LzRQbUd3OGlyMFlnWktNd2xiVG1WZkNw?=
 =?utf-8?B?NTVNQ3pYbWMzbWRqWTlubVA4MXRqTGE4aysyanE4NDZxRDh3SGFSUnlnUUhT?=
 =?utf-8?B?QWtuYWRGVEw1Zm9SclZlWkhzT3lOeDlpWlNYalZTbzFZMVEwU2JDTk1JZGJh?=
 =?utf-8?B?NDZ2VVArbDdSeitXUjRWZC9GUFlrYTYzTitaL0tLbytzcy9UUXIxWTM4QTlo?=
 =?utf-8?B?SDM0bEl6WjdhcE1ZTXI2R3czZEF1WnRtdkY5cmdZUzMvczRET0pYRHdmM3VQ?=
 =?utf-8?B?aTVzdldFWEcrdWI4Y0ZmSWRWb1lYYU5RUWs3cEtRSFRyWW8wZkRzZ1ZBSCtw?=
 =?utf-8?B?bWNrNXdOaDhZVWxGdzc3aDcvT0RyNmFhVkNYVFJiNEZmZ2ZCK2VEWlVCTld6?=
 =?utf-8?B?aHFTRERCVjlpWFJOQU1LUVJJREhLTmFPaEdMWWlWNEgyb2p5TytiL05VNC9s?=
 =?utf-8?B?WUllZGl4L1NNdkcyUVpXZGJDS1ZPWUxmNXJZcEdPZ01Yd05wcUpQa2txd2tv?=
 =?utf-8?B?REtPaE9YL3ZVRWhEbDBQdGtBYXZsdDVNVUVpdFZrRWVuWnZuU3pIcm94dEc5?=
 =?utf-8?B?eTBobVluWUVud3cxSWgwQWN2WjQvbm1EajBUamdNbHJyVEIvck9KVXBTTlI0?=
 =?utf-8?B?TUFQUGRwMEk5alJidFpUYk9DS002aGNwZGdjdE04cGxIaENTaEw2U1pRQ3o4?=
 =?utf-8?B?V1czL1c5K2hNVHhTSFhMM3FxdjhxcGE0b3hQbnVMSDVVMTlFRmV5YXdkd3dP?=
 =?utf-8?B?ajZxbm9YL20rSlZhdnpLUFlWSW5sdjdOTThna0NmTVlyZVBMVkVneXJEN2ln?=
 =?utf-8?B?dHZiYUFVSzB2ZVNHSU01MVZyYzNNK2tIVFB2MHYyNlJJdDArMTlvN3RDTjU2?=
 =?utf-8?B?MUdUL1ZPWVovMENlbUE1RjZJQVNlUy92bi8wWXN6aUhtSE8zYXU1c1QwWGp5?=
 =?utf-8?B?aDcwN2w4ZlhZekRQZXpkSlB0czhaK1VQTnl0UW8rTEZjRElsVXlxTGgzY3d1?=
 =?utf-8?B?cDZrZW80OFhHdHgxTFBUQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3J3ZTVvUGpwNzhkQnB2a3Z1RGhqdnU4YnJCWFkrQUNBREtubGRaY1BJVmFV?=
 =?utf-8?B?S1hRTU5mY2RYblJMMk9iby9mVzFZckp3NlZHSVJPdDh3aFpyZi8yUWREM2lO?=
 =?utf-8?B?N09WSjlGcVF0RlA4R3JBS1R1eEZNQ2FwYmJVa0ZwblpQYVhLOWoybTF3bm5V?=
 =?utf-8?B?WmFaaTgxNEc2RmhKZ01yS1dkMXFFYmtET0lKWTlncUZlSVk1SDNVLzRMRWg3?=
 =?utf-8?B?Z3VkQzN2ZkdtbDFjNWVLcDAwaFJNZk1zdEZRRzhNTHlaSG5Id3h3VWJJL21F?=
 =?utf-8?B?ZUZHTUFZSWtKQVZQdCtMV0tvQU9FVDl5SytseUlRR3djK1l6akVqdDRGV2JC?=
 =?utf-8?B?eDY2NEp6NTM4ci9kMXlmUlF4VVZxa3pXRlhINElLUys4cXZRZW9iWFl0djgy?=
 =?utf-8?B?SlZxNVpneXdWSEMrdUNCSllPcjYvdzJZcXhGQnVKUkcwMUd3eTZRSzNadkxU?=
 =?utf-8?B?cUdycnJmekg4M3g2aVQva1pNdlg0TFp4NmpJZTU2ZWZyM1BiRXN1MkM3WWhG?=
 =?utf-8?B?ZVFaZmQxaE11RGUyTEFvVmNVbkRrRzFvVFFrMkcyMEIxQ2hVTTF6NGF2b2Q4?=
 =?utf-8?B?QTZLTkpZMm1SK09yV3ExaXQ4R3BYUFhJUDY5cXJsTXdFUTdKK3Rzc2dSK244?=
 =?utf-8?B?YVlLRnRjTlRCNE9lQVRqVVZuTU9tTFNYTmE3a3d2cXlXYkR1cWNmMTJxYVF0?=
 =?utf-8?B?YVErRnNta3ppUVFMVkJZVXFlRUp1M2E3QndMQjB4M1h1bVpURVNaR1VkSGhL?=
 =?utf-8?B?SVpFUHAzeEZTdkR4L0xCS2V0Sk9qWHVSY2pycVo4WkdUdU1lVGN1ZDgxNlZZ?=
 =?utf-8?B?T0VnTHFRdWw2cTNQdUVoNWh2QTdlTmhGb0VKbkUrTllGaFBCajkwVlNhZWlo?=
 =?utf-8?B?U3dTSk5mRDdreE93WmlJdlRjV1JjWE1yRXllRzdubFRXQkRQd1RGb2QrSlpB?=
 =?utf-8?B?QmpyYVIzQkZzaE81eGpjL1YrN28rZ1UzM09LVXpLRi95cmJKbnVmTGl5Q21L?=
 =?utf-8?B?NlFTWHQ5K1dvdUcyRk8rQkZkRG0rN2Z6blVXRkJoY1d0b0ZMK2JXMjBMR3kv?=
 =?utf-8?B?S0hucGxScWRiUFhLcjJLYUFDVkJhbStVeFg5bVBHT2krUDE5RUpsR2xiZFZ4?=
 =?utf-8?B?MTdsN053QUVXNi9kemxGSElJalNXZS96NzcvY3Nuc1F5WXJsQW5mbjc4VHVO?=
 =?utf-8?B?enJ5WDJKMXJtUnJUalF4L0hUZzlFZ2lYZFZhb0grc2FvWUUwZ2RNT084a3lM?=
 =?utf-8?B?RUFuYk40R0gvK1NaZGlXelhLbWYwKy9MSGxwWlNNRWlhdmlqN0dNdmZkZGlz?=
 =?utf-8?B?NTJjeVZkVk5yNXg2TzZVeEhwRVJ4UXc5dVVEWGd6MjR1aDQvdEF0eVBPbUk2?=
 =?utf-8?B?bksxN3V3SFc4NFJ1dHBKNCtJMnltRHJaVTFOWnNGbVBMN1FPUStUcU5seXBT?=
 =?utf-8?B?K0ZzdDNncE40N2ErSTlpYkNlbWtOajIzYjhWTzluQTRyTmNJZmRDbStIa0Nh?=
 =?utf-8?B?ZllRS0VCanBCOWMyaGFzUHFjZWRtYTd2d245bUJhZGJkM2JEaGtLR2VrekN0?=
 =?utf-8?B?MWcrLzRRdmlmQjhvdTNWTFdEdThUQVNpOElwRjAxWDJIdVVsRXkxampaaFRK?=
 =?utf-8?B?ZHNYTHMvK3pCejlXQ0xlVTk1STV5S3lOUzEySmkyYW9kVUlmbThidHZCVUd0?=
 =?utf-8?B?TjRheVBZcTdOQ01HdzFnVGNRQk5ybWRxUGFEOFhpR0R1R0ZEbDgySUJyelF5?=
 =?utf-8?B?SGhGMHp6dEQvMzBxZnNEQVE5YnFscXdtSURrZ3JaU3VZeFQzRUoxQXQybXBW?=
 =?utf-8?B?MExiWHc3NVBtbDIwWU1TM1l2MmZFc1ZjVzNMUkU5MUxZQmJXa2FvVkZzNlp0?=
 =?utf-8?B?UDVZTE5JSzVYV0g1SVhqVkd5QlFEeGtUbEQ4Mk1zZTczOHBudDU1TXJmMG51?=
 =?utf-8?B?c0JJdjgvekZRY0Z6anNhVmFoWVV2dngvcWVQQlVEclhyNUhhUEhFbG9DVThi?=
 =?utf-8?B?N09HN1lPN1hIbzVjcS9ES2JJbjlnUmxTaXpJNUJjczVhdG5IRlRlRy9rZHlS?=
 =?utf-8?B?Smc4bXVPUlZSck1lZGx4ZjFFMFNmbGd5ckF5ZXVpdTUvamlscXlQeVB3YmRF?=
 =?utf-8?Q?1unk60gMaTbbFkLq9JZHjPf+M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d445cd9-8b5a-4965-bcfc-08dce1ad5bc5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 00:09:46.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAzF16BaMxZ6Fi3Q+ObxHiObktBRBbw3dCZxQqsnlapeBd+2/LQ61Q/zdAsHUIOyb2/iUFsPZukZgsm7Vu3xZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685

Hello Dave,

On 9/30/2024 6:25 PM, Dave Hansen wrote:
> On 9/30/24 16:11, Pavan Kumar Paluri wrote:
>> Provide "nosnp" boot option via "sev=nosnp" kernel command line to
>> prevent SEV-SNP[1] capable host kernel from enabling SEV-SNP and
>> initializing Reverse Map Table (RMP) [1].
>>
>> On providing sev=nosnp via kernel command line:
>> cat /sys/module/kvm_amd/parameters/sev_snp should be "N".
> 
> I don't see any mention in the changelog, cover letter or Documentation/
> about why someone would want to do this.
> 
> I assume it's because of performance (walking the RMP table is non-zero
> cost).
> 
> The BIOS allocates the RMP table, right?  So this option presumably gets
> the performance back, but not the memory.  That's probably also worth
> mentioning ... somewhere.

Yes, that is correct. RMP is BIOS-allocated, so there is a performance
gain but not memory.

Besides, having a 'nosnp' command line option would benefit customers to
be able to set the BIOS option to allocate RMP, but not actually enable
it just yet. This way, they can avoid overhead incurred from RMP checks,
for when they do not want to run SEV-SNP guests.

I will include this information in the cover-letter.

Thanks,
Pavan

