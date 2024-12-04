Return-Path: <linux-kernel+bounces-431898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC9F9E4275
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A3216993E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE743210196;
	Wed,  4 Dec 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZCvE1zp8"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FE2391B5;
	Wed,  4 Dec 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332491; cv=fail; b=Pd3c1iSUoyTw6Xud/OEtRvmPx1wVrGDcy5s8OaeUk0dVyP1uUKiTVCQylbzcFBH4vvJ6cwU1VXSZsMrF0Hi9rWU9hOBr5jnzAXZXeyD4inwN1HPd41TJVt58ipJZFO63iqPbMsrmuqKBuSMdboH0s5amltFA/iWXJCwp3uxX180=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332491; c=relaxed/simple;
	bh=3uOQvvpxTPVT1SBhUYaoJeskCHXd3TgZciZUzJKbwe0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PLA+4NAFNGXfbuafp14k9nGatBfgpDUUjl+Y7JAjF4F29DOltW4e8YU0V/cTXA2F3cMKbGUPuA/lLd2bX+RfhBTIkR4iuBVg/8u+qjBF61Ch/dY/OGby2BRBOUczB4o2dI0hkmLWbVDZzsodZVX0RyUt5y0GYFdpw4AVY1cuNBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZCvE1zp8; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUec/aDZ4G3dz2per6Na6Jm/gQ+exyMfFSMjX0RIAk49zsYOydA/LbbT4EFQkYJJTzQQQ4xp+7OHacI8ciNfpt2pnuDZu/uBPtv66jGpt7WndPOeaMHcjA6csyZ+uoC1gGn79eZMOQwf3PxmVlIM6VawqIFLJhL3XpsFTwVgKC+ZKE5rs4LgtTrtMnNylhFPoXql9HSB/2UDrBEJ379KNghpTJJWMNUKe4kn+we/mY9R/MCGnbwGGngxgFU9+08nPPAB0PheNHKKgRsqY1KjL8SsC63GhE9/JsiEY/HzCOlMOGPLPcdoFPoSuN2lQUMorJRNi3xbV4r2URQBtgyBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h758TcIHomTS2UMPU0Yysb8DymaAsQtLLBmi+etrGCM=;
 b=OkBtADWJdnQw3ZY/4RAFFzetkztrYXm7bFSWISdrYEO8a98X+Tu6e/UocFDyZ6fv32JRJOVMEoJys+L5jkuU8QiOXpFoDJ+Gf/cchwS6Bfa4mz6C8RV/5xcKzJrGk7C4+8USP3WNuspxZXn0ioTwG46IPq2VGjm71cr9Kav6HS2fl9lfW7O0xY97aLttfs+gmsj9YDeKahPIR8OL30dvJCl5NRTKxnRWFEhxADPLow31Rmo9UnwctvYQsvSPEnJYZA04zDY4BTPZaEeDhmAdYYxL+uso1VlsSY6PnnYcRhhyqF71WwzIGp5FUK9kEAXqJtqY6ztOWX9l2xkmaAPWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h758TcIHomTS2UMPU0Yysb8DymaAsQtLLBmi+etrGCM=;
 b=ZCvE1zp8HSrIDbrVaez7cs3BuYjdc5ECLQ3hE9ECLfp6705dbtMbp8mZk1uBUXmNCXFoIuBgIEZtghyOi1xVEPsFmUOBYMa+5AMEycvuMP+1YshMESy2uiWIioEFFLMHcaBhEfhuA3lYzQBzZkSnvTDPTzt8G78vTaEk751W6Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 17:14:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 17:14:46 +0000
Message-ID: <85cc9764-1140-4c08-8ced-c2654f7775ab@amd.com>
Date: Wed, 4 Dec 2024 11:14:41 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 20/26] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: Fenghua Yu <fenghua.yu@intel.com>, corbet@lwn.net,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, thuth@redhat.com, paulmck@kernel.org,
 rostedt@goodmis.org, akpm@linux-foundation.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, seanjc@google.com, jithu.joseph@intel.com,
 brijesh.singh@amd.com, xin3.li@intel.com, ebiggers@google.com,
 andrew.cooper3@citrix.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, tony.luck@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com,
 maciej.wieczor-retman@intel.com, eranian@google.com, jpoimboe@kernel.org,
 thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
 <3061ec99-c418-b1a3-7975-8a6b9d0bdd14@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <3061ec99-c418-b1a3-7975-8a6b9d0bdd14@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:20::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: d0feee9a-5a2f-4a17-0621-08dd148726ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUNyNEs4Ylc1a2JEdC9UMms0YmVLdnFtMmV5cGZqL0s3WDdpMEZpRWpjbTg3?=
 =?utf-8?B?TUFSTmwwd2k2YXZManAwYUU5alowbDZuZVBXSmJyakVqRVpJWXc0SkJSL3or?=
 =?utf-8?B?MlFLelU4WmxRM3BkOWZaSE84M2NkdXUzd3puR1gyWXpCdDF3dndrTUR5S2dF?=
 =?utf-8?B?S25wQmh2S1dLUUlrVitoRm9ld0VLalJ2ZUhDd1NTRTFjb1RJamlVOUZORkJD?=
 =?utf-8?B?WEwyZXRrL1ZrOXEySVlBYW5QZXlYY2w3a0ZCOXhaQ3NSQVZIS1R5bEpIVGhl?=
 =?utf-8?B?TmNJL0pKMzloZ2p1OVlPTm5nQmRGUDI2S0ROcmROeUVqY1ZCK0JmRE5yekxr?=
 =?utf-8?B?emE0bHYvUTY0dDNtZ3lrTFRVS3ZKTm1kZTdoMzZFRzRtc0RjdXArZ2I5NXhs?=
 =?utf-8?B?RWI4djZkSlZSSFJHNGlpNGNZNFJQMTNlU0phK01ZZFMzeUR3Mjg5R3NYVkN6?=
 =?utf-8?B?MFhWR0VPVFJyRVY0WDBGYWcrSG1pd2VrZWdYSndzMWE4bEtmMWsvb3NUM3l3?=
 =?utf-8?B?bGkrQUNXTEhvWmdiZ0FIWEw2eFVtUFJmVFVOSlgyZm1odmNGMFRhVlo4cEti?=
 =?utf-8?B?akJWQkRnK0pHMVdobE85WGdXWGhhNjRTSmpvRVhIOWtDc1RVQkd3bW1mcldV?=
 =?utf-8?B?RE9aY1RnWml4akpFbXNHYnZMV0pRa3dIcStNaVliQ2dDdmszUGsxTm8zU1BJ?=
 =?utf-8?B?MjNuRy84WE5qTUIreURQMGRmM0FUTlV5Y3hiaHFzRjdwRVVXVEZ4RlFqNmJM?=
 =?utf-8?B?TG9nN0FQLzdSdGJPcWpyYlpJL2s5b3U3bUVlNFo0QVA3T1lKSnduZGtKZ3VK?=
 =?utf-8?B?d0wwbzhhVmdvaXN5Y0lKUkdoWTFKaGhYa2ZDMHE0SE5IWEI4VHFSWk14MVQw?=
 =?utf-8?B?clliUTc0SndraW5vRU96cDBaU05nWmpVaVRwZzdiL0liMEVpam5uSXowdmZr?=
 =?utf-8?B?UWdXaGxmZ1B2aWN6WWNUVXpaMjFOamJIdjhjZ05IWlM2TStkc0xubGhuUXZB?=
 =?utf-8?B?VlVjdzhHNnBsS1o0RDJiUklsNWk4R0JaTEtMRGo4VXVvRjVaeUlUcFBHbUdz?=
 =?utf-8?B?ckdZZk00V2RzRm5kWWxOZEJPdnhBY09ldXFtbCtKUEcvWDU5czNqQ1NYaTJW?=
 =?utf-8?B?bUR4NE96R1U1RGhhcEloZWRYY3pDdDMvekdIV01CMDB2TGNBMk9wc0ZYQzc1?=
 =?utf-8?B?ZmNlc2l2S2ZVS0VCcE9CdzFHZnpDTU01ZGEzUW5ndFRIRDJSa2hnM2NPdlZs?=
 =?utf-8?B?MTJPMk1yRmFvSGhKeEVEQzRhWGMwSXlJZ0YrNFI5cDRBRVpUNXYvekVKSHhE?=
 =?utf-8?B?aVkzQm1EMWttVzhWbnd5VW4rbGY5VTlxU2RDOXJONU9nMzRTWTdqeE4raEhE?=
 =?utf-8?B?NFZ0THRXK0htN3BINmd4RmM0SFpkQ01lV3JORjJ1cmFBWExKV25PWTR6eSts?=
 =?utf-8?B?dC9oK2wyR1JXTGpLMjJIKzJFNWI3ajd4a0dyak9YV3dMSGU2OGw4UTZQSFNz?=
 =?utf-8?B?Z3JxN3UrR1RhSjBldnZKdGVoMmlzQmk4YmsyWDlqVnUzbnhzUmpXY2dOU2Ji?=
 =?utf-8?B?bUNTcG5DOVExUVZHUXVYYk9DMWdSMEhmYWd1TFFBL1RhT0FQQWJNdkpCYWEv?=
 =?utf-8?B?bm5KVHNVd2FmK0VOa29NUnJERE5VREs3enpjcS9sN1U2ODlVUlNxdWZXNUZK?=
 =?utf-8?B?VFdiZ1RQanFCbDkzZTBubFdKb3V6ZzFDajdjdmpXUjhxOEE2MUpzZVdpSUlX?=
 =?utf-8?B?b2t2TnU3NDdPbTRCa3lMcUQ0VXFXbHNmdjk3VjBNS3JsbERzUFRmMEl3TktI?=
 =?utf-8?B?bEdVMlpvdEZGU1hhMW5lUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVFja1FNNFNJWEVhTXRZTE9SMUZ2NGVQYzBNRHlwSlN4OEpxMlJDcjJBcGNX?=
 =?utf-8?B?b0c2bE1waWZ2U2YvYjZ6UkU0NkFIQU04NW5jeUZ6ZWxmenVmUHdNNlFFbDhY?=
 =?utf-8?B?MytKRUxmaUZodHZScUZ2c2d2djRsNnFGTVNXcmJJNkFwbE5GelpSRTBCcmRL?=
 =?utf-8?B?K3h5MzNFQnM2M2xLTW42U1VTeTJ4M1BLQkFkU1N2akh6aDhHUklVMjhYN2pr?=
 =?utf-8?B?Z3M0RGg4YkhIQnFKYTJQdHZyeXFFOS9PZ25tRGxZbmNER0xtU2NjVm5oaW5a?=
 =?utf-8?B?WkdBdVFuZENGUUduc1NGRUlIVHRJVnlwbVh4bHRzWGpISVNvYUcvUXRtMlh1?=
 =?utf-8?B?US85VDRBeDhLOE52Sm5MekJwMWFzdXJTSXltcHd6dVU5LzdDdEN6azJ2anRK?=
 =?utf-8?B?K2doWngwVVp0cFFBNGw1VmVxa3BoM29mRkdWU2dPdzVhd0QreVlza0Y3Z3la?=
 =?utf-8?B?SHNnWjBEZXNTdmErUExZSUlQTUczS1pZUk9DajNMbElGcnBNT1YxTTEzMmVQ?=
 =?utf-8?B?dWgwNkVkVWgrNjhzUGdBRmdlaVVzc28rSldyVnl3a2FRWEp3QWE1UjBVNFBB?=
 =?utf-8?B?TW5KRXlHem5SdllXbzRCM29Tc2lkSTZkK2dvdktOb1ZMeXRaZms2RUFabHdv?=
 =?utf-8?B?Y2ZDdjd1UHBtTTdjMVdXMEFOenVzU3lOdGU3bXZvVTFGNWdRWW9uY1JXVlJu?=
 =?utf-8?B?cFFWVTJucXFvaStSV2d0SGpGcUU4TjVxV3oxMllBWUxuNi95VGhxWmREZnFw?=
 =?utf-8?B?SEtVY0oxNUxkbmR2N1h5NE91NTViaFV0QVBlS2dFVUVjUnFnaFVVbkErdFBy?=
 =?utf-8?B?ak1RUmlkSEdNT0huT3RxUUtzRlA3dDFyNnIvTTVPY3V4UmpzZmw4V3VUS3dl?=
 =?utf-8?B?L1ZJYWkxQVc5c2dkeDlkWFF1a0h5d0cyM1ZyZHRubTlHUFZ4RXlUakdhMGNu?=
 =?utf-8?B?VVlGajZJTEZsaTJVcjFUcnpCdFdWWkcrQzFTWDV4SVFlbWgrQkVXTHd4NzNJ?=
 =?utf-8?B?eE9XZVVZb1ZpbUt1MzV2d3EwWGo1bG1KUkRnOGIvRUlYS2NoOWt6K2NkNXJ5?=
 =?utf-8?B?WHpBTGYvQ21CK1FrcUhVK29BOU1ML1N3WDNKVStKcHo0S2Z0WG1pakpEWndN?=
 =?utf-8?B?K3U5SFVNUGtXdjZkbFFJM2tuVFlzWFlvVG1HZXIwWFJsUzhXbVZ2RVYzc2U0?=
 =?utf-8?B?YUcrM3pFeFpRdXIwSHk0N3huMVpEZEtESE45a3B5Y29ZalFZYnY0dVFTVmRS?=
 =?utf-8?B?UmQ0MlFIZGZJY25jWlpGZXJvdVBFL2w0VjNoZ1p2UXFtQW8yaDZSVEtXelBS?=
 =?utf-8?B?U3NTaDIzVUN3dU5CMzMwUVpINEM5cDBMZ1Q2SDR3V2RvM1RRdW5OOXRVWXZN?=
 =?utf-8?B?YWJoUlBzZXY1bUo1NVg5NHgyL05FN2VsWDBLN0J6MFFIZXcwcW5wZWRqOExv?=
 =?utf-8?B?NlF6dkVqMm9WcWhKQ3ZoM2dsN2oyT0o1SmVPTkl5UHdTU3hPb0lXMDNsZE1W?=
 =?utf-8?B?azV1YWRra2E2OGtoS25LMnZPc2lHWXFCNzZsQ1JJVjR1NjN1UjFmQUEvY0xr?=
 =?utf-8?B?enlQNmdMbVZtT0ZYVTZJc2x4WFUxVUg5cm9TK2dYTmthZmtvbWd1OVNnSjVO?=
 =?utf-8?B?cnpBOS90ZjBFNlFQdWNNbjg2cjlmK2NxQlV5NkRHVVlxb2d1Zmk0anNvTWVE?=
 =?utf-8?B?SU1NL2Z5NWF5OWt5YktRK0V2Z0ZRcnFKOTl0aFptME9Db3AzeitrdHd0K05R?=
 =?utf-8?B?ZkFveDFERUdESityYWROVTBEUmIxWkZ4cEhsUDNLMWNzeWRzVW11UzRWUjAr?=
 =?utf-8?B?V21Da2VYbkxSK1k0aHgyZFVxY0xLTi9JUWdzOG42ek1UT3RkNVYxQVowZW5n?=
 =?utf-8?B?ZEpJcUZpU2R5YnZ4a2U1Y1VrZkxSYW56QlZRazgyb0Z4NERtbTNmb25va3RM?=
 =?utf-8?B?YWlhblZDcEdHVWxIYzRFN1IyV2FSbjVEa3I3TlJBcU5GcUdCa2ZmcUEzaXZI?=
 =?utf-8?B?ZmsvbGRoWnRtb1gvNllya01KZnhlVHg3L3pjWHNxM2hMamo2YTVjaUhrcEtZ?=
 =?utf-8?B?L3J4WFh2SUkrK3ViRkdBcEJ4OHFOL3UvM2hoVWZZTzFvRUVCWFlXKy9qdytD?=
 =?utf-8?Q?YIaQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0feee9a-5a2f-4a17-0621-08dd148726ab
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:14:46.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXTN1OYIuMqqh+DxjnZLHFo1WdYDX/OjWspGD8THdoap9Iuvzm2TfMoUuJKMpSwY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402

Hi Fenghua,

Thanks for the review.

On 12/3/24 22:16, Fenghua Yu wrote:
> Hi, Babu,
> 
> On 10/29/24 16:21, Babu Moger wrote:
>> Assign/unassign counters on resctrl group creation/deletion. Two counters
>> are required per group, one for MBM total event and one for MBM local
>> event.
>>
>> There are a limited number of counters available for assignment. If these
>> counters are exhausted, the kernel will display the error message: "Out of
>> MBM assignable counters". However, it is not necessary to fail the
>> creation of a group due to assignment failures. Users have the flexibility
>> to modify the assignments at a later time.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v9: Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to
>> return void.
>>      Updated couple of rdtgroup_unassign_cntrs() calls properly.
>>      Updated function comments.
>>
>> v8: Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
>>      Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
>>      Fixed the problem with unassigning the child MON groups of CTRL_MON
>> group.
>>
>> v7: Reworded the commit message.
>>      Removed the reference of ABMC with mbm_cntr_assign.
>>      Renamed the function rdtgroup_assign_cntrs to rdtgroup_assign_grp.
>>
>> v6: Removed the redundant comments on all the calls of
>>      rdtgroup_assign_cntrs. Updated the commit message.
>>      Dropped printing error message on every call of rdtgroup_assign_cntrs.
>>
>> v5: Removed the code to enable/disable ABMC during the mount.
>>      That will be another patch.
>>      Added arch callers to get the arch specific data.
>>      Renamed fuctions to match the other abmc function.
>>      Added code comments for assignment failures.
>>
>> v4: Few name changes based on the upstream discussion.
>>      Commit message update.
>>
>> v3: This is a new patch. Patch addresses the upstream comment to enable
>>      ABMC feature by default if the feature is available.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 +++++++++++++++++++++++++-
>>   1 file changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index b0cce3dfd062..a8d21b0b2054 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2932,6 +2932,46 @@ static void schemata_list_destroy(void)
>>       }
>>   }
>>   +/*
>> + * Called when a new group is created. If "mbm_cntr_assign" mode is
>> enabled,
>> + * counters are automatically assigned. Each group can accommodate two
>> counters:
>> + * one for the total event and one for the local event. Assignments may
>> fail
>> + * due to the limited number of counters. However, it is not necessary
>> to fail
>> + * the group creation and thus no failure is returned. Users have the
>> option
>> + * to modify the counter assignments after the group has been created.
>> + */
>> +static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +        return;
>> +
>> +    if (is_mbm_total_enabled())
>> +        rdtgroup_assign_cntr_event(r, rdtgrp, NULL,
>> QOS_L3_MBM_TOTAL_EVENT_ID);
> 
> In this code path,
> resctrl_mkdir()->resctrl_mkdir_ctrl_mon()->rdtgroup_assign_cntrs()->rdtgroup_assign_cntr_event()
> 
> CPUs are not protected by read lock while rdtgroup_assign_cntr_event()
> walks r->mon_domains and run assing counters code on CPUs in the domains.
> Without CPU protection, r->mon_domains may race with CPU hotplug.
> 
> In another patch (i.e. rdt_get_tree()), rdtgroup_assign_cntrs() is
> protected by cpus_read_lock()/unlock().
> 
> So maybe define two helpers:
> 
> // Called when caller takes cpus_read_lock()
> rdtgroup_assign_cntrs_locked()
> {
>     lockdep_assert_cpus_held();
> 
>     then the current rdtgroup_assign_cntrs() code
> }
> 
> // Called when caller doesn't take cpus_read_lock()
> rdtgroup_assign_cntrs()
> {
>     cpus_read_lock();
>     rdtgroup_assign_cntrs_locked();
>     cpus_read_unlock();
> }
> 

Good observation. Agree. There is a problem.
Some of this code will change with earlier comments.

We know couple of paths are affected here. Why not just add the lock
before calling in affected paths instead of adding new helpers?

/*
 * Walking r->domains in rdtgroup_assign_cntrs, ensure it can't race
 * with cpuhp
 */
cpus_read_lock();
rdtgroup_assign_cntrs()
cpus_read_unlock();



>> +
>> +    if (is_mbm_local_enabled())
>> +        rdtgroup_assign_cntr_event(r, rdtgrp, NULL,
>> QOS_L3_MBM_LOCAL_EVENT_ID);
>> +}
>> +
>> +/*
>> + * Called when a group is deleted. Counters are unassigned if it was in
>> + * assigned state.
>> + */
>> +static void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +        return;
>> +
>> +    if (is_mbm_total_enabled())
>> +        rdtgroup_unassign_cntr_event(r, rdtgrp, NULL,
>> QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +    if (is_mbm_local_enabled())
>> +        rdtgroup_unassign_cntr_event(r, rdtgrp, NULL,
>> QOS_L3_MBM_LOCAL_EVENT_ID);
>> +}
>> +
> 
> Seems rdtgroup_unassign_cntrs() is always protected by
> cpus_read_lock()/unlock(). So it's good.

ok

> 
>>   static int rdt_get_tree(struct fs_context *fc)
>>   {
>>       struct rdt_fs_context *ctx = rdt_fc2context(fc);
>> @@ -2991,6 +3031,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>           if (ret < 0)
>>               goto out_mongrp;
>>           rdtgroup_default.mon.mon_data_kn = kn_mondata;
>> +
>> +        rdtgroup_assign_cntrs(&rdtgroup_default);
> 
> In this case, cpus_read_lock() was called earlier. Change to
> rdtgroup_assign_cntrs_locked().
> 
>>       }
>>         ret = rdt_pseudo_lock_init();
>> @@ -3021,8 +3063,10 @@ static int rdt_get_tree(struct fs_context *fc)
>>   out_psl:
>>       rdt_pseudo_lock_release();
>>   out_mondata:
>> -    if (resctrl_arch_mon_capable())
>> +    if (resctrl_arch_mon_capable()) {
>> +        rdtgroup_unassign_cntrs(&rdtgroup_default);
>>           kernfs_remove(kn_mondata);
>> +    }
>>   out_mongrp:
>>       if (resctrl_arch_mon_capable())
>>           kernfs_remove(kn_mongrp);
>> @@ -3201,6 +3245,7 @@ static void free_all_child_rdtgrp(struct rdtgroup
>> *rdtgrp)
>>         head = &rdtgrp->mon.crdtgrp_list;
>>       list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
>> +        rdtgroup_unassign_cntrs(sentry);
>>           free_rmid(sentry->closid, sentry->mon.rmid);
>>           list_del(&sentry->mon.crdtgrp_list);
>>   @@ -3241,6 +3286,8 @@ static void rmdir_all_sub(void)
>>           cpumask_or(&rdtgroup_default.cpu_mask,
>>                  &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>>   +        rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>           free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>             kernfs_remove(rdtgrp->kn);
>> @@ -3272,6 +3319,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>       for_each_alloc_capable_rdt_resource(r)
>>           reset_all_ctrls(r);
>>       rmdir_all_sub();
>> +    rdtgroup_unassign_cntrs(&rdtgroup_default);
>>       rdt_pseudo_lock_release();
>>       rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>>       schemata_list_destroy();
>> @@ -3280,6 +3328,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>           resctrl_arch_disable_alloc();
>>       if (resctrl_arch_mon_capable())
>>           resctrl_arch_disable_mon();
>> +
> 
> Unnecessary change.

ok.

> 
>>       resctrl_mounted = false;
>>       kernfs_kill_sb(sb);
>>       mutex_unlock(&rdtgroup_mutex);
>> @@ -3871,6 +3920,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node
>> *parent_kn,
>>           goto out_unlock;
>>       }
>>   +    rdtgroup_assign_cntrs(rdtgrp);
>> + >       kernfs_activate(rdtgrp->kn);
>>         /*
>> @@ -3915,6 +3966,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct
>> kernfs_node *parent_kn,
>>       if (ret)
>>           goto out_closid_free;
>>   +    rdtgroup_assign_cntrs(rdtgrp);
>> +
>>       kernfs_activate(rdtgrp->kn);
>>         ret = rdtgroup_init_alloc(rdtgrp);
>> @@ -3940,6 +3993,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct
>> kernfs_node *parent_kn,
>>   out_del_list:
>>       list_del(&rdtgrp->rdtgroup_list);
>>   out_rmid_free:
>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>       mkdir_rdt_prepare_rmid_free(rdtgrp);
>>   out_closid_free:
>>       closid_free(closid);
>> @@ -4010,6 +4064,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup
>> *rdtgrp, cpumask_var_t tmpmask)
>>       update_closid_rmid(tmpmask, NULL);
>>         rdtgrp->flags = RDT_DELETED;
>> +
>> +    rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>         /*
>> @@ -4056,6 +4113,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup
>> *rdtgrp, cpumask_var_t tmpmask)
>>       cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>>       update_closid_rmid(tmpmask, NULL);
>>   +    rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>       closid_free(rdtgrp->closid);
>>   
> 
> Thanks.
> 
> -Fenghua
> 

-- 
Thanks
Babu Moger

