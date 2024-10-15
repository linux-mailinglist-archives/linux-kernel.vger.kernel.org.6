Return-Path: <linux-kernel+bounces-366179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BDE99F1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0898B22D80
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F071F4FBB;
	Tue, 15 Oct 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M402sJ8c"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A531EF092;
	Tue, 15 Oct 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007029; cv=fail; b=Vtf5ebd5YJZKqeSRXjugu7VUe1+CiJxhW9BI1R1s4GNzZIJ21qSpb41RzZItu9SSh1ahZh2YpI7Axb6oaQwkf7OCgh4qGydm8lGKBmoN3bd8M8xmXC1fWSp0f5jyXCoONVrH9VREEXUGLp5ndRVVnD7ibXD28ybTMac9JPAOtA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007029; c=relaxed/simple;
	bh=TgEt33vRkgXNwBvj7poIBIbyh7ibrhW/hY1jiEsey9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EUSXBDZ2k9+QvhC64tSVCXs68DNCl9QdARjvQMcs5iR5+1CkczUOeT4ko9EwYacU1I7+5HpfBIkm+cxAM1twvQiIrpL9GigYZtFNnDtnRZtWV47uTqjA/KRpn0QbSaauzjcYa6YDtGpejCx7YowGKSMX/RreJkpbql02MOApF4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M402sJ8c; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vy1mUQUuNzSGTvupvFvHt81aGW9jh88MFdIO4kVS8cq66q4hIoF2E9GqaF0H3RSP658D449gWa7Xv1SoNI9k9lKptFYGt5bSaMLuxmrxSUtN5D7rINDVQVJl3r49oWfy8fNzJOe53cdy96lwdPanJxOUAuQR/aDzFCzrDEaHocQUlMs6nYK7K35lWjasGBruiiLr7X5jqdBNHQLJEfm/qjIEKHUXbv9sK0P4NLG6AidP0z9KQQgW0YMr76u8yuDAMPgbG6O8Z/iJ1xqOI/qKW1Gv/KMmqTJI+yr8R4eytdG/9Ed1C6NNjWU6OFQU+AS6wnQRloiuuKkXZKAVklDMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atDCYGSM7CLg8F9Sk0DwS4RYr0L9G4p0N7KE4Oh7atY=;
 b=eBSHrcwyKYDVxxK2geMXltZ5OG7uukakW9IJiF+c+HIV7EAUNi9a/u/7P1Igu3SALKkY9yw5++jD8V7VGZziZZNc+o585brLWusd5qJxc90ccIRpmRqi05uwEtYbFYUdolWix/2MDv+rhNX8XFeSbWdLUNnSJPvSFg11UaBRMBWVGxiin5f3y1+kejNitYkPIdXvYDk+8S1K5+lJ8FKXSn/olgAJCRNnpvpRnLump+b8FkmKB8vbxd3aoTtlDDGBXzw4pKkRjLbqIx4XefINmuXezPxHHxU7iBPm3jOfedfUSQ4kmUCUkOxMryGhY+q1prFJoah0JypXk4pZIXYARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atDCYGSM7CLg8F9Sk0DwS4RYr0L9G4p0N7KE4Oh7atY=;
 b=M402sJ8cm0SWqWLztEYgUWwESiM0rTmcvMvhKdHmlYGPfSIbPhVDf2iTPCv4hyRMeiC7wtH+0EJiA/9HNfmOfAk4TYkrgNJ/mlx9jzHnX6PhcU7IRFslSNx3wjJlkPqgMvQB0IAxXsQSJEF3Yse4TFp5svC8GbSvC30XQnn6AdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 15:43:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.029; Tue, 15 Oct 2024
 15:43:43 +0000
Message-ID: <b4d9b572-4df3-4758-a40b-cb48fde0b595@amd.com>
Date: Tue, 15 Oct 2024 10:43:39 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: Reinette Chatre <reinette.chatre@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
 "kim.phillips@amd.com" <kim.phillips@amd.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
 <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
 <SJ1PR11MB60838F3FFF40AE2718ED7833FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <43654ae1-c894-409b-bcb8-065940644906@amd.com>
 <SJ1PR11MB6083379F790967B379C4232DFC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a972dfe9-341b-416c-a245-0834583c6620@amd.com>
 <567bd687-a69f-46fb-ab19-3f8d95c5e798@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <567bd687-a69f-46fb-ab19-3f8d95c5e798@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:806:28::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f993298-bc9c-4bc6-c9c0-08dced30264b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0huUVdwbmh4bjhsdTNMYzgza2QycjlMcGo3M0o0aEJkc3BqbGtXUm5FcEpB?=
 =?utf-8?B?N3ViLzhyY1ZQS2srcTVDakpvRXBrbE9FazZSRlhRd3lBeEc2VUMreDVDNWdO?=
 =?utf-8?B?d1lOR3RKY1h5ZEhXODl4NDgxdVBMMUQ4MVBwNlhyWE1qQ1pybzhYL09ROW1D?=
 =?utf-8?B?czRGcU9yY2Fob1Z5eFdoNkZmWkN1bkxNVHZxRHhwMzZMNDlrVE5CNXhuOWN2?=
 =?utf-8?B?NkZZbXE3RmNkT2EveVcwMTE2WnVDOU9wOEhzY3JsZXVIdG94K0VhY3c1R1Zo?=
 =?utf-8?B?RjVHcjVETmpRRWkwTzlHS2hNbXJhRUptSG84dnVJT0RTcFRza1ZNZ0tNQ2x5?=
 =?utf-8?B?OWhDRUpHWDF4RXZnSlJmN2xONmMvZFRxZ2RzeGorK0drVU8ycWxEek1WR2Zr?=
 =?utf-8?B?dnRxTzJLSlJKNXBFb0FSNGhCa3FMWWNpSEZEbnBSeWpNdDVoZ3c1WC8wTm4v?=
 =?utf-8?B?cTlWQVlNTCswZCtKYU5YdUYzMEFJQzhlWkY1V2JhcmlHcHMrdXhTVExJSlRn?=
 =?utf-8?B?aEpVU3ZsUkwzQXBLWHJLTkgvMi8rTnl2NzhXYWpmdVE0czdUTXhvbkdPOXR0?=
 =?utf-8?B?aU93M3VweDh6YnUzSW5kWW9IWjBqcWZJR2xSM0NyK095UzRxTVo0WkhSZDJK?=
 =?utf-8?B?U0F1dXBLMjBkeUdvMmlXZ0pTRCtSK1Jwci9tdE1ocE42dVlMS016bUgySGJ0?=
 =?utf-8?B?YUJsWlVNaWZCd1Urd0xyUEpQYURXakprSktraVdaUndxcG9VQmhKZGN5bUpx?=
 =?utf-8?B?blNRbDhlWU1KWTR4eU9iQ2NsaDVDZ0VEeXJqNTQ5b0l2eERMSW5RVjNWMUls?=
 =?utf-8?B?NnZ4MXRwOXRYRFZ0azNwZlBqUHU1Q2lxazhydzdTSFFEc21IK0QrMkFZakdV?=
 =?utf-8?B?TGFmNVFLazhLSVdGUXlPalI0UllDcCtxY0FESDhxUzlqTlBpSFRuZnFEQ0c5?=
 =?utf-8?B?ay9kTS9UaUM5Vnc5aHhBQnZZd3ZFME10RmxXbTBSYXd0UkdCTmtVcnZJUlF3?=
 =?utf-8?B?bE1ucUtsbllpTFNucXdSWDhONXNKb0pCM2Y0WkhsWHRtdU9IekxjS083ekhE?=
 =?utf-8?B?MTdQbkJJN2MyNUdwQWZiV2RvUnAvK1YxSVBId2dYdjZhQXRhOXp1K1JsMndN?=
 =?utf-8?B?UDhCR3V5OENNUnZPWDNVWVFUTmtLUkpwY0EwaDhPZU0zSkFZRVF1eXZlaDR4?=
 =?utf-8?B?cUtlMVVyVzR1Ty84ZFRxeHlCVklycnZybWxkQ1RIaHNwVUtnaEVaait6K1R2?=
 =?utf-8?B?K2N2UkhzSUZmRHlkcHArQ3lqcFhDRHF3TVd1dFpOd2l4V0tiVVVUQWo2UmFV?=
 =?utf-8?B?L25PeWZhd2swblFxK0JENnlPc1psNTFLY2phcXc1cWxMRkl0eitUbjE3NXAv?=
 =?utf-8?B?cmN4cVRYZHJLZjZHZkxnd2MyYmVtS20zVWZQZlFWZWM5Qmt1SzQxMXRDTTdh?=
 =?utf-8?B?UExMOS9vRWZJRlVsUHhOQ2xYTkk0YnZWcnhnc0ZKRXJpNFV1TXJxM2N2bkxV?=
 =?utf-8?B?Q0ZzaUE4WHlyVVlqSDJpaU51YWs4RU5WNkVGS0dQc1NFT0RHcmtsMDhJVXE3?=
 =?utf-8?B?eUNzZkU1WTNsakdyZkI5STNGeU55N0VtQnlQL085b1RrZm9TcUtMb2NmOUIr?=
 =?utf-8?B?UEtLbVV1QlpiOCtOdmpNNjFXRmlSeUI5MVg4YURCWU5qMWtEWUJrbmdtQ3F5?=
 =?utf-8?B?dmllbzJaNUV6ekFwK2FtNENveDlxaVZvdXlHMUFMQ3RIY1c5a3Arc0lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azMwT2VOUm03bkdQTTdmZUF4bmpRMllwN05UZGRTTUIwZWplaktGUmsxbDVS?=
 =?utf-8?B?Q2NXN1dZS3l3c3pQVW0veHU0cXI3aldZWnNGeGlpSG1LT0pFYmxlL3hHRjIv?=
 =?utf-8?B?dk9FK21ZYTk0dzl4SkRTQUd3eWQySENUeDVxa0FwOUFMMVk4OEkwbnMydHlE?=
 =?utf-8?B?eFJzTEhHNUJtemEzdUxUUFFzeHFsbmwzMmoxekpJU0kxcFpaaU91bXRnTE41?=
 =?utf-8?B?YVkvcSt5aGlYcHNmWmtKLzBqRytvU2k3cUFnSVdXTmxjU09jVVJ6b1BFVlZo?=
 =?utf-8?B?WGdzQStnSlR0NWVMR2xqOVdvYnZvV2dhQ2hCS01LY0JwNm5SVU4xcnYydmJz?=
 =?utf-8?B?RzVQZ29lTFpBN3Z4SGlFbStlT05MUyttWFN5UDE1ZFJ5REIzaUlhV094M2I0?=
 =?utf-8?B?bTZxVnBuZWsyZW5PU1dxMk4vR3RwK2xEWmF4dmxpUFNPL0lQdWExb3p5b0Rw?=
 =?utf-8?B?T0kyV1ZRaFVNN3FXdVJuVllXcWJFZTYyT3B4c0JSSVFvWlErb3JCQzV4QWpo?=
 =?utf-8?B?cm5hUERsc0hncUdvWlR5dEN4Uk5EWFZaSllWckFUbldCWjFaQ0NUOEZEWDk1?=
 =?utf-8?B?TU1rNG1BT3FxSVRjaXdleDcwSmZOeFdIZFhXbEhYOVRJcFRqOXczQ1ZhYktw?=
 =?utf-8?B?d2llRDdoRWxTVFRWeGN3aHNPZ3E4RlN1T3FrUFlIMXcvZjlQUDU0L0pyR3hp?=
 =?utf-8?B?c0lOaEJKWENzRlZpakNLQnNIekdEMnl3QnVNdEtiU2lRVVFIWVNYaTBWZllE?=
 =?utf-8?B?K0xXMmM3K05WRDFheU10U3psMmxxU1JPbEc3U1pzYXlVY2tPS1dXeW1XNVBG?=
 =?utf-8?B?MzYzV0ZMUGVrZUQvVnlFb0lhcUloVGhjcUVHSWpHZUw4ZVhPWFFML0x0R2Nh?=
 =?utf-8?B?ck9ZSTlHQ29tUWd1QkgvTXNnbERKc3FBWnZIZUs1WHBxbGd2ZndsanFHS2ty?=
 =?utf-8?B?S2ZQYUxkUWxaUVJ4NE5IdnJYMTN0OHdSdDFrblJaSzRNUFh1OXVSdjIzQm9P?=
 =?utf-8?B?R1VIV05RY2tNbnFKSlpkcmdaOFFzemlGanlMdmhleENvZXd4MW1zWHcvWkRD?=
 =?utf-8?B?cVhoMW9jejlzQ3JmRk5walpYYzBURE04THZVaGMyZXkrZVpQQ3YxRmk3a3J6?=
 =?utf-8?B?R3pjS1FQcG4reUpoUWdXMW1mSm9mT1NJSmprQlp1azBubGdObmdBbDhOREJO?=
 =?utf-8?B?M0ZIOUsxTjB2c0kxaE5hL3plWWNmVXI4Y3dMVU9NV1kyait5WTRpU0gycUoy?=
 =?utf-8?B?WDlJNzk1SGp4cHZ0TVM1SzB6REVId2tTUjRITnFpSzBwZGxwdGdkSkIyOElr?=
 =?utf-8?B?NVJPTUpJazFKZCt3Qk1qR0RxWHVoK0FNMFp5VnE2V1pXM1VOVnp5V3RHSnMv?=
 =?utf-8?B?YmwwTzEwTm5wb1R5Y21GZDJZNWUzZnBna0RuLzluN3k1M3F6b0l3WjBYemUw?=
 =?utf-8?B?ZWkzcmM3VkkxSGxEdVdDdFhYS2ZCOUFSZXpXbG9NNHVYRmJIMUtaSXNENGFJ?=
 =?utf-8?B?bkdtQXZwTE9xRExEVFF1dS9EUHFTNHZuL0t0OHpFM0VCREJkZnlXQy9kV1ow?=
 =?utf-8?B?Zkw3RjZWb3ZScjhPNjA5VWNRMUcvY0NjTGhMUEJnOEY2MlNmUHVHdDFTT2VW?=
 =?utf-8?B?SmdLNnVYbUExVWZNSFIzbWpNMmhUYVdSK0RpRWpWMVZFVTdpWGhNaWxqRVZo?=
 =?utf-8?B?T1BFTUJFc1lIU0grWS95QjVNZjNGM2FIWkVJazRKN0J0L1lDd0NHcldHYktM?=
 =?utf-8?B?QUd6d2hWT2w0L2ZPZElwcXRnaWg4R1gwdnJ4R3JPLzdaMjRzUVRHSWhNTmhh?=
 =?utf-8?B?ditvaTlDM0tSQ1VEZXJ5V0hWNGxCQmI1dlVJQjQ1M2Z2NlpMWlhlckk4TFYy?=
 =?utf-8?B?bmJBcUFMWUtHb1JjZjQreGxiTFNFUVRRUTVPWU9MSEpuZWx6ZitPRXJvOWNH?=
 =?utf-8?B?anN6QkVnQzU4SStzZW1kcm5MeDlJb040YmVtODZRM0IxMnVOVit5QTl3TlR1?=
 =?utf-8?B?UHVGbUJTd1BUSUJBeTNRelFWb3B1Q0tDTEE5dThkL1JzbFh4bUlSZFE2UjRs?=
 =?utf-8?B?KzNtYWZiUU9XQXR5OUhUWEhOUnZDZlZIMVcwVnRHR3FaYWt5aHlDT1hNSXMy?=
 =?utf-8?Q?a44k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f993298-bc9c-4bc6-c9c0-08dced30264b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:43:43.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V45Bd7KrRhHq39fBKCM/fb54Ne8HrsJfrsdVXylJ6RpL46by2tb/w7+WFA1oBFdi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254

Hi Reinette/Tony,

On 10/14/24 21:39,  wrote:
> Hi Babu,
> 
> On 10/14/24 9:35 AM, Moger, Babu wrote:
>> On 12/31/69 18:00, Luck, Tony wrote:
>  
>>>
>>> It is still the case that callers don't care about the return value.
>>
>> That is correct.
>>
> 
> Are you planning to change this? I think Tony has a good point that since
> assignment failures do not matter it unnecessarily complicates the code to
> have rdtgroup_assign_cntrs() return failure.
> 
> I also think the internals of rdtgroup_assign_cntrs() deserve a closer look.
> I assume that error handling within rdtgroup_assign_cntrs() was created with
> ABMC in mind. When only considering ABMC then the only reason why
> rdtgroup_assign_cntr_event() could fail is if the system ran out of counters
> and then indeed it makes no sense to attempt another call to rdtgroup_assign_cntr_event().
> 
> Now that the resctrl fs/arch split is clear the implementation does indeed expose
> another opportunity for failure ... if the arch callback, resctrl_arch_config_cntr()
> fails. It could thus be possible for the first rdtgroup_assign_cntr_event() to fail
> while the second succeeds. Earlier [1], Tony suggested to, within rdtgroup_assign_cntrs(),
> remove the local ret variable and have it return void. This sounds good to me.
> When doing so a function comment explaining the usage will be helpful.
> 
> I also think that rdtgroup_unassign_cntrs() deserves similar scrutiny. Even more
> so since I do not think that the second rdtgroup_unassign_cntr_event()
> should be prevented from running if the first rdtgroup_unassign_cntr_event() fails.


Sounds fine with me. Now it will look like this below.


static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
{
  struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;

 if (!resctrl_arch_mbm_cntr_assign_enabled(r))
      return;

 if (is_mbm_total_enabled())
   rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);

 if (is_mbm_local_enabled())
   rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);

}

/*
 * Called when a group is deleted. Counters are unassigned if it was in
 * assigned state.
 */
static void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
{
  struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;

  if (!resctrl_arch_mbm_cntr_assign_enabled(r))
       return;

 if (is_mbm_total_enabled())
 rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);

 if (is_mbm_local_enabled())
 rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);

}


> 
> Reinette
> 
> [1] https://lore.kernel.org/all/ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com/
> 

-- 
Thanks
Babu Moger

