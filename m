Return-Path: <linux-kernel+bounces-524748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360DA3E69B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C76D4239BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5655E2676DC;
	Thu, 20 Feb 2025 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3UzOGc0K"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAA02676C6;
	Thu, 20 Feb 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086967; cv=fail; b=oI+jIRFl0w93BezmyUViHPhKgJd9ZfhKvf8+GssURlRL48P+JBRw9znJwCZL5KQoX17u1kfILA+xq+zHvk951670lZ8KwXCYqn9QPj64vmg30ezqddC21X+QuToYZauaFGPxo8eH4ISuC6pU92WMZcBWtj2DyAu0pFMKTdd/fcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086967; c=relaxed/simple;
	bh=KJ4fzedpmAnPlTn/k62Uo4VVY29qr0OkFjPMDMtWSC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S6gwYl4jPPCdtuuM8aC7KBiYed0+d7fXL7oce76GVRWe0KBK/frf6VKhl9E6BTmjoD5nq5LamvMjYHD1JWmPn2KAtV4b5D1VAyRNEgpbEw1w33WQBcis/GvjDXpff86t0tNE1KKgMcgRcAStMZXDMTbcnvrv+QZGIHTbcW19gdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3UzOGc0K; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfA2LS/XL9hf4M3f5trlhk5/StOa5HPm58LvClzKzcz2f+4jPkko4s3cCTOzXXiBfCPyifqs1yNeyj+k/fZD26hqTd1g4LgDej3GmzoAs8ae7yrV5/VZz2PcY0BypGmtjDWjs+Uy2vsAIzn5s76TX6AMPhOysgHv19DJZidFc7Phgh9LiuZGTvnagzP3Wjbv53Gni7eGiuwR03plI7z498LTqqP77XOjdvynwPsUtTg7zsaLeTdIkmCio4Ps6rdSInR0UkhdIPaLB04JFKIh2701spVrHdbTMtLS+081FuBMLcupY7NC2165oorx57w29P3V1pFm6rHRNofP5getEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmaOhPhs8/0PaH6FoLYPcSPV9UmY+CVH1lvg6Qr7Jvo=;
 b=O6xFyIe1GVolt3cQpYpQXCJW6NBVDZn98bfyNLhpSe5Z5OsEvBkbDl40ytc0gPT0oupWWyYSbcuGlF5qtlKlM0uAXsJr3LWNKmrLmdqEytBAR9CTgn79sKVApxIqrHX1YE4Piae5tgnaxuTnaoFqV5Ec1BFJsXvHahTQpKRXAjQFbEBqGtrWkI66xz1NtbcjmDTeAvAYK/TrD3soGC5pt9xHMNOFwoqMLsbr4U7j04DiRTiU3BrXpPYE9lTGOCGIAov4weWDV1N7YxHWdxvPzQrMPIbTT6pdTdVvSJy7BBGyy+Y/+xhcK3FLMgxDbAN+YZNWM8bEUVJny/WCdiNfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmaOhPhs8/0PaH6FoLYPcSPV9UmY+CVH1lvg6Qr7Jvo=;
 b=3UzOGc0K/ecNuKI0by1flsO88ZG4w4vZRtYMOWF+ylvogfNzucWfJvT08S+V2JbXitYVep6pRmKyeBayy+0JooKWENrHpFVAPn9eAUwjg0j7Uz0SKlBZ+4wBmfKq3cegBGU0wvBnOB/MGJUD9ZsqTmah9FiPMkumcEscCrGOYnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 21:29:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 21:29:16 +0000
Message-ID: <7802f9e9-9a63-463d-a51e-e9ad0e60f77f@amd.com>
Date: Thu, 20 Feb 2025 15:29:12 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
To: Dave Martin <Dave.Martin@arm.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, peternewman@google.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>
 <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
 <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>
 <Z7dN2KpsQjVUb3KR@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Z7dN2KpsQjVUb3KR@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: a500aefc-d044-4c19-f686-08dd51f5a09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWdhNzk5Vm13c0ViSWZueklJU2JNbm5ZOXlXc25HVzdVUGVUaGpZdWNzdDlS?=
 =?utf-8?B?M0xYZUJyU25BUExwN1dkUXZldzFGR2QyODQ5UWdOZWtCNWQ4NjBYRjMxekgr?=
 =?utf-8?B?Y1ZQajJ3bWxTS3NGMWJYcEtUcjRaeklaRlFtUFdFTERzRzV5amZTbjM4Z1NP?=
 =?utf-8?B?S2UrS2F6Vm1ndmdrMks4cFF5RE91ckJ6ZFpMUHFGcFhjSElpRHFRNjI1TzF3?=
 =?utf-8?B?cEplVEc4NlhJYkxkSTNtcjEvZGErMm83SkVzM3E1Y0JUbTR5am5wR3BpZmNt?=
 =?utf-8?B?aVRYc0NUTnZyK1FSek5HUVZLNUxQRk9YYkFCSXVUS0JlaFZzUGJlWmxmamUx?=
 =?utf-8?B?Q3FpY2JCZVZOTXVuNkZabWpNUHNYR09NMFlUTzlaaGNsdU8ySjEzcjBaVlRF?=
 =?utf-8?B?NXRSNE55VFczaVVhbE5ENU9lSmpRWjVYVDM3SDJsUm5JZ2ZJTGZzYzVwTGR1?=
 =?utf-8?B?Zmt4bVYrTno3eE9rbjRXWi9WRUU2bmhSWjA3T282VzZvcS9TOXhNVGVidlZL?=
 =?utf-8?B?REU1RXpJU0xBS0tnVFJLMFllbG02Wjgwamh5c1h6anlUS0ZXVDRibmw4VnRx?=
 =?utf-8?B?WCtuQjJUYkRXZkh0Ym5CNnU4cXJ0RDdxdnhhdDZocVFpVG83RlVmaDZsV21G?=
 =?utf-8?B?VVN2VWVjTXFLcVFwSU9GcmIvRXJFK20yemQ0SEZ6ekJXOVhxRDVXU1FIcUpL?=
 =?utf-8?B?UFV5MkxvZ0dvM1VGK2YvWjhkTDlDamZza1NYNEZ0VHcyZWxBOVUrTWFwWEZ3?=
 =?utf-8?B?SStia3RKWXlRMVBlNWdUaG1TdjhCK3lUQ2k4b2xTcEM1dnNERUcxR0V4K0s2?=
 =?utf-8?B?akU4WDFiN0lVL0swZGR6TitlSzl5Z21HNzNTQkx3MWpRd2JhQkRnOCtDd2NT?=
 =?utf-8?B?dGcxcEUrNkxGUUxTY0FHejBHeUpzWDRUcWQ4cmtJWndCL1h1SEVvSTRBRllM?=
 =?utf-8?B?TXVSSmtsTU9GbHVyR3NWWHEyQjk5K0hrQndjQ1JCZEtCa1lIL0dhY2pRY0R6?=
 =?utf-8?B?MW16TUUxRWMzbjRBTHVGU2pkeEFlVmJ1ekVyUFNDYis1ZC84eVViY0tPUitl?=
 =?utf-8?B?VlpVYXZHTTE2MUlVTEFWdU1Ma3dqNnlKOWpOMUFXNHp4RmVUR0lFaEgrMWM5?=
 =?utf-8?B?NFc5YStRMHdwY1Fid1NDaFhhcWJBVzBreFhvUDNUYWpKZ2dpMkdWM0pOZHp2?=
 =?utf-8?B?NkpwYS9mSGl0bnY3d3FWTUpxLys0b1V5cnZyRHB5RmcvZjlNTlB1TjZYS0Fy?=
 =?utf-8?B?bnovOE1PRUJQSmpKWm4xd0tJKzkxdEY1aUNreE9ZSzNIMEZmTVRtaEZCcE0v?=
 =?utf-8?B?WlNFZGt3dzhiaDV1K1JIajRweUJrYUowTTZmN0s0bE5EL1dpci9YN3JHUVh0?=
 =?utf-8?B?aWhWTlBFejBVc3ZQeEQwMDgzL282VWVTaEZZOGFKUlIyRFdXVEh0WHY3Y1Zt?=
 =?utf-8?B?cmZ2cEtLVENtRTcrM2I4K29EUHZHTllpaXpXN3FkdFdmSE5CS1hSZlBoSm5J?=
 =?utf-8?B?RStNRUdXQ1BBMmlGV3cvb3JtT1pLNVRTejB0b2ovekFYUDNyNTV3NlRjQW9I?=
 =?utf-8?B?bmVjZjB6Z0VvZkhhOHp1MFIwYlJyMzV1OXJqMzJJUHVadXJXOVZKZFRPV25E?=
 =?utf-8?B?blNiZmFtSVFlNjUrWS8wWTNqY0dTbnFhR3JIZzhqNm1mMHNTRkphOHlyQm15?=
 =?utf-8?B?a2tIbFE5ZTAwMm9xOFY1THk2RlFQd3ZBbmlHUmtxU29wRjBpdzAwTnU3cmhH?=
 =?utf-8?B?N21LbmplYzlFRTloaWNzM1Y4aW02Q0kzRUlxSk04SXIzM0F2ZUl1aThHeHZ0?=
 =?utf-8?B?NE5NTTN3MTZ3cVNCcU9BYWxiZGlxWVpxZStoVE9mODUycGQrdTNvakFwMk54?=
 =?utf-8?Q?/6KopeVJxrJ37?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0svM0pOcGtxQnVPRDNmYURZaHBOblZOUWp1eDNsVUJHcmpxOFozOHhJZHk4?=
 =?utf-8?B?aVlZM0NTTE9wZEtXTTRPbnBhSTk1MHRhMHhtaU1namttTy8yd3o0amNxdnZn?=
 =?utf-8?B?WFRUaDBVeHZHWTBhMnBFdHgvWmFKT3JxRUs5Q0xEeEduUmoxeXlHQ1BSdUhi?=
 =?utf-8?B?S1grNnFJSGdQYzJ4dWt4bUtyKytLQTJxQWNFam84L3NOZDJzL0tVelpNR01X?=
 =?utf-8?B?N09vVXpRQ1NudFpNbm1xVmkxTEZ0TGRhbi9BeGQzeEhOV2wxWmxFOUhqWmdo?=
 =?utf-8?B?blJpa1FqVEN4S1VnNmtCVHJoeDNPRFRLWU41d3Jzb0JoeTZDa1NtdzEwcDNy?=
 =?utf-8?B?YXpCQ0tSRzhFNXZhWC9LOC8wTGRvK0VkWld0cCthU1B5bkhwOFdyb1puZjh4?=
 =?utf-8?B?YWc4L2ZnQW8rYzFzN053N0Y2QmVzeUVLWUNiME1tWmsxdHdDUmF0ZjZONUQv?=
 =?utf-8?B?SEVLZWtrWEowT3I4Y3dtRFRTMURKRVorYzFkeVNTVC9PTUlxaS9BMTZHMWh1?=
 =?utf-8?B?ZmRmdVRmUDU2MFJYOENDaHNqdlB4NDhPOEU3SjdJZCswNUxta05oUy85SEhy?=
 =?utf-8?B?K21zcVllaTNGb0tTcit4Y0VqM3BnbHRVUjNlc0NYMFVRZ2w5KzFWU3VKYjdk?=
 =?utf-8?B?ZGZMN0NQVC9WZEFIYkFweHdZa3haUThVckJSdi9NdVdlVUdWblRjdW9Sc3Zt?=
 =?utf-8?B?MmttTnNpSW1WU1FxclR0bGlVaUhMS3d1M3JKajJ0dGVUcHlVTTBDblhjQ3BH?=
 =?utf-8?B?SVRFdmtqYVU3bW5ybE9zRnlxQmthaDBRZnpQdzJkWGlsR3ZYUmhJZVR4Y3pE?=
 =?utf-8?B?YnJYY1hpaGtPYVc4Vnh6VStGYVkwcXRyTmhkczRWR2xOWlJyL203RFYyUG53?=
 =?utf-8?B?TDhBT05SZGp3ZXJhYkxuOFUxdDluUzd5NVVhWlgzQVk3Y1ExbGtHRkpNai85?=
 =?utf-8?B?ZVBmeXVnNUpyaFExRnloZEtkV3N5bEFMTkZJVHlVUmFiYmtwZ2c0cDMyUWNW?=
 =?utf-8?B?cFVSYVp5UUhxS0NxWjFZVE9POFhCRkdGcWU3eFUxLzhDdnBEdWVJZitFWVpz?=
 =?utf-8?B?UWxwVmZ4Nm5MQjdPSmZ6UzdXS1N5eGV2ZTJwSER3N2sxUzFTTHJFK0txTDFB?=
 =?utf-8?B?SURlU05uS0hSbjNza3lIWHc3WkVLUXMyaG5zSnNJL0pQcTZRVVBha3lSVDNY?=
 =?utf-8?B?Yk80bStKSXdodHpmZDRmcVpZMERneGhsMW0zcnlaWWw3czBKVW9hN3V4MVJk?=
 =?utf-8?B?WElveGNTNldDcEZ4RW9mVnpDNU13QmhQRWREa0ViNVRaNlBJMitMQzZnZU90?=
 =?utf-8?B?UjlGalJXd3k3T1U4Ty9nM3V4ei9EeVhlYmpwQkJOMXpzeWZjQkE5dzVoRUt6?=
 =?utf-8?B?YkYxSnU0SUxJcGl3S3E0M0JxR2U3N3AyN3ZmZFF1U1QvekRjT0tJcGVSMjVB?=
 =?utf-8?B?cWtuK0JCWEpWTlNPVktpUU1CYWhRR0Fpa3ZhTmoxOEQvci9UL0Q2TEhBZHhy?=
 =?utf-8?B?VGxYaHQ4VGFWcGNHWHBRd1QrbDVsak9qK2RaQjlPd25XZkROMlRvOG1RaUJP?=
 =?utf-8?B?NjhEaXl4dC9LenZucVpiMHhBQlZSRWlxdGJoWWxOcUY1WEFnZnlRQ1BkVHRi?=
 =?utf-8?B?TFFMd28zV0pHNkRWRDdhZ0tpM1RWQlZ5Nms5Ulk2bWd3ZEJEaGEzOWRHdGtE?=
 =?utf-8?B?dk9vQWJRQnJialVCMlBkek9xdmVneUdoamhMR3hWZHI1S0dVQndmclBCdlIx?=
 =?utf-8?B?SkhZU1JpbW80aS9JdFJ0czBodVc1b1Nod3A0SjB0V3VlOTd6c3JxWEQzb2JK?=
 =?utf-8?B?dFhQRnpwWFRHeGZRVGFsakFzNG0ydi9ZWm9haFNBN2RIMm5RYU11UDZDV2hY?=
 =?utf-8?B?NVIyeDM1cnk2YnRZTnE1czN1bnQ1S0QvbDhIMldiUzZjOGRTOTUzcmFDamUv?=
 =?utf-8?B?cU40a2xjanpFUWMwOUYyQU9MMDFmTWNCaGxpejljODVSWW45bUJsYVA4SkFF?=
 =?utf-8?B?TEh1VlBCc1A3OEpMUnVaY3l3Ukt1U3daZUlaSXdjMkNoak95V3BWZDAxSk05?=
 =?utf-8?B?UGhYZWo5NjJFUU00WU0yQVNsUkwvVVBUTE5WSFgyM08wVGxoUGN6NHR0OVJ4?=
 =?utf-8?Q?hcfg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a500aefc-d044-4c19-f686-08dd51f5a09c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:29:16.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSvFUEv/Aq1rzEPjOP7r7Jur4eo5PWboPDkc91CH3mhsYLIW4xGr42B40wZwJ3dG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847

Hi Dave,

On 2/20/25 09:44, Dave Martin wrote:
> Hi,
> 
> On Wed, Feb 19, 2025 at 03:09:51PM -0600, Moger, Babu wrote:
>> Hi Dave,
>>
>> On 2/19/25 07:53, Dave Martin wrote:
>>> On Wed, Jan 22, 2025 at 02:20:30PM -0600, Babu Moger wrote:
>>>> Provide the interface to list the assignment states of all the resctrl
>>>> groups in mbm_cntr_assign mode.
> 
> [...]
> 
>>>> +static int resctrl_mbm_assign_control_show(struct kernfs_open_file *of,
>>>> +					   struct seq_file *s, void *v)
>>>> +{
> 
> [...]
> 
>>> Unlike the other resctrl files, it looks like the total size of this
>>> data will scale up with the number of existing monitoring groups
>>> and the lengths of the group names (in addition to the number of
>>> monitoring domains).
>>>
>>> So, this can easily be more than a page, overflowing internal limits
>>> in the seq_file and kernfs code.
>>>
>>> Do we need to track some state between read() calls?  This can be done
>>> by overriding the kernfs .open() and .release() methods and hanging
>>> some state data (or an rdtgroup_file pointer) on of->priv.
>>>
>>> Also, if we allow the data to be read out in chunks, then we would
>>> either have to snapshot all the data in one go and stash the unread
>>> tail in the kernel, or we would need to move over to RCU-based
>>> enumeration or similar -- otherwise releasing rdtgroup_mutex in the
>>> middle of the enumeration in order to return data to userspace is going
>>> to be a problem...
>>
>> Good catch.
>>
>> I see similar buffer overflow is handled by calling seq_buf_clear()
>> (look at process_durations() or in show_user_instructions()).
>>
>> How about handling this by calling rdt_last_cmd_clear() before printing
>> each group?
> 
> Does this work?
> 
> Once seq_buf_has_overflowed() returns nonzero, data has been lost, no?
> So far as I can see, show_user_instructions() just gives up on printing
> the affected line, while process_durations() tries to anticipate
> overflow and prints out the accumulated text to dmesg before clearing
> the buffer.

Yea. Agree,

> 
> In our case, we cannot send more data to userspace than was requested
> in the read() call, so we might have nowhere to drain the seq_buf
> contents to in order to free up space.
> 
> sysfs "expects" userspace to do a big enough read() that this problem
> doesn't happen.  In practice this is OK because people usually read
> through a buffered I/O layer like stdio, and in realistic
> implementations the user-side I/O buffer is large enough to hide this
> issue.
> 
> But mbm_assign_control data is dynamically generated and potentially
> much bigger than a typical sysfs file.

I have no idea how to handle this case. We may have to live with this
problem. Let us know if there are any ideas.

> 
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 484d6009869f..1828f59eb723 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1026,6 +1026,7 @@ static int resctrl_mbm_assign_control_show(struct
>> kernfs_open_file *of,
>>         }
>>
>>         list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +               rdt_last_cmd_clear();
>>                 seq_printf(s, "%s//", rdtg->kn->name);
>>
>>                 sep = false;
>> @@ -1041,6 +1042,7 @@ static int resctrl_mbm_assign_control_show(struct
>> kernfs_open_file *of,
>>                 seq_putc(s, '\n');
>>
>>                 list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>> mon.crdtgrp_list) {
>> +                       rdt_last_cmd_clear();
> 
> I don't see how this helps.
> 
> Surely last_cmd_status has nothing to do with s?

Correct. Clearly, I misunderstood the problem.

> 
> [...]
> 
> Cheers
> ---Dave
> 

-- 
Thanks
Babu Moger

