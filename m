Return-Path: <linux-kernel+bounces-173373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9918BFF99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D86289789
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498FD84D30;
	Wed,  8 May 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ptiBfmJO"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058647A5C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176617; cv=fail; b=m0/Gg+p6qE0lxR9qc8g1BFglLE/Wd48yi775eurnrbaDMsvGifmeScl+eOc8LPVdtLFHSzeorijVGkLC/+MGby9hf9Yz/2bnaFWdp6shH+P75A51ru5zXfxOrfkLDPfkgbWzLaYfubzjARrpSOsVyfrFy+PpKpUGo9gu6yWpkBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176617; c=relaxed/simple;
	bh=iWtY/Q9wvbdgL5kn7w637I3Bzcc51g81GSww8muCj5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQU6w/UfXSIc4FhmLGQY8h5aDgcYE7zlx7SpJV2dh3PBSn+QU5lAdmRRusqy45NL53sIgJvg0FiJWRV7pRlC6SsjIokeBbKh/b3HvuhFFVjgzqWyB66MVVWawE9r1YNH2Z3pJagE0bt9wIdhroanhG3qIEYi8YlQHkCELHal5zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ptiBfmJO; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4485JhhX003184;
	Wed, 8 May 2024 06:55:47 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xysfmkhes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 06:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzoW55eHyeJwWYrYx/q9k3PWh0437QCUz2CRbcss0Yh+wxqJuyl5KywDcV/6t2QCCMKtfd85H/JoQVEi826BbzqoQYILs2Lohy5djjlBFlLXNTENdWXn1S8dA4tP4y1E6ByvtD6LpdxooQjjuw3hhlWLYw3yWZjXjTaPFIS2hkkzYZi6PqvrJaBzUSimHrw2AH0Hxh+t5iFk3ZFUET23EMqeEPN9EXOVcdOlSyhQlIWtSwPvCnwrkoZ92WTUj+JQ/SdLoosuTO3jwj6XDFuGm36KWr82sTh/EGtnqZLdn+8+l/eJ3iZQdPQLIaQHaL7KR4D3WuZa2Ig4L3KR9DSm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dAtI9w9R00myZXV2DbGEGV5npMcfI6FFGBoD2KP2FU=;
 b=kVHAqoy/JzzFnTiXru6rqElmOkhOEqzNkER3RBi5Lj+fM0DQ6Vk8f35blmZzWjuWu0ZasWwnbdtr2j5rXc1srbZPKj/XxoRdiHwCQJ0hDcbPoATtvyKwHLift7ZDwBA0+hFnjBEZ64/Dzfu1sNHv+MolJmzhzsrMWDHo9nryoqR1rWOb79C7A384ihBVSXbRpoICdddujBSrHTMnKCmbliV+vNqi44Z3hEFAC6Jd9oWSC/Lpu4OKIZ5n97iPBSnRIm5YntVSuOmtA+SzyM73h4boScwz3bXHs+8Zlo7YyahrEAnmDN7gC7VhfGMDhaq5qnNIGQpJ19EZIm01RlHLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dAtI9w9R00myZXV2DbGEGV5npMcfI6FFGBoD2KP2FU=;
 b=ptiBfmJOwm6Pc81TKEqbujiI0YBKmgHCjHudZUQI0yf2hu32FzDvP3stoPb68zMcKL1H3XD5I4vOgVL55EUFTzaR+m+qkTJGbEb9sO+jWdtQQqT+w4jGxX0/Pvx7a55JzFcu4+HJKt4s39ASteXD5mviW9KGAJ63/2EEgsjT5sA=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by MW4PR18MB5208.namprd18.prod.outlook.com (2603:10b6:303:1bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 13:55:43 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 13:55:42 +0000
Message-ID: <c25073f0-5af2-42ca-bf61-e85df2711e3c@marvell.com>
Date: Wed, 8 May 2024 19:25:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/14] arm_mpam: Handle resource instances mapped to
 different controls
To: Peter Newman <peternewman@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        Tony Luck <tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>
References: <20240117141405.3063506-1-amitsinght@marvell.com>
 <20240117141405.3063506-14-amitsinght@marvell.com>
 <CALPaoCjf_A5SOr8L+0WMePW02Pzj9nnPT0JLZ_+232vvfEzGCQ@mail.gmail.com>
 <MW4PR18MB508449310648615886A8113BC6702@MW4PR18MB5084.namprd18.prod.outlook.com>
 <CALPaoCi1xABN+7LL4Xyi4Se87f8PM8769KiyZkzTESurZSyDqg@mail.gmail.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <CALPaoCi1xABN+7LL4Xyi4Se87f8PM8769KiyZkzTESurZSyDqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::25) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|MW4PR18MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de417cc-e647-4a8a-5c39-08dc6f668d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RFJwWEhPNitBVThpWlgvSlI5bGgyRmxYKzVxaHAyZEZyOXBpMXA3dFJtYVNi?=
 =?utf-8?B?MHFXNkw1Qkpva3VvcWRMQUdTb3Q2SzVHVXpIcndoUGJ1Yzk3MHBpT3g4eUlr?=
 =?utf-8?B?UnJhblRiWlFTWFljWDJOSUo3bHAyL0ZZSkVEdDRMK2ZjeXBxUlFId09iMmxi?=
 =?utf-8?B?REhwbTJRZTcyd2x5YklKcjJGYWpiT0wrZ2ZzUitNaEw3eGhNWlVObFAyMXNp?=
 =?utf-8?B?d0ViVjN3aFZINjI2ZUhkR3JoaWxGZ0kyVzB4dXk5Wll6dFZWU3hteHlNU0lU?=
 =?utf-8?B?ajArZlFCNTcxYVNwWGp2TWhXbXN4MmZjcEpsVTJXMmwzTHdBdmFTeHZzQ1lo?=
 =?utf-8?B?UVdtWFd2MU9CQi95SnM1VTdlMU5XWXdMdDBXSXQwcXg2QitrTEZaVFcyK1Bu?=
 =?utf-8?B?UCtzM2lVeU1NZnhrYzlRM3VqOTk2MGZTUnhlczR3a3B0RWVxeUZrd0lCTDYz?=
 =?utf-8?B?WDg3Nkt2M3dxZm1Ob3kyYjJJRjI4T0R2anlYM3pEbjV6V05STnZTNzJkN0xp?=
 =?utf-8?B?TE0rSFQwemFoc21WZHhVRFphWXZhWWpKNDcyemExQmdITHRYNVg1eENiQmVr?=
 =?utf-8?B?NjNLdlJ6MUxrTmxyeDJheUR2VTVDSnpWWlhacmt6T2ZGRzl1M0xkVEMxYmc3?=
 =?utf-8?B?aFk2dlV6M2YvRGlWbDlRdjhvQURLMzZTb053dXlpQVhHMUtSeThXczQwWS8y?=
 =?utf-8?B?bXplWTFVSVZpQmJKTXFBbm5PZnRwRlArV1Q4TUpEc3VpUlc5ajdYZVl0bk1j?=
 =?utf-8?B?SkNrQVB2U1hJcFpHKzhJVm1xdjdmTG43c1VXa1ZHUllJdm5ONnkyRnRZV3gw?=
 =?utf-8?B?VGZSOU9tdjVEenBKaEtKUmNVMjdJKzNZb2xTR1ljZkVoZ0N6dmhhYyszM1dN?=
 =?utf-8?B?ejM4dUNPVXpGVmlOS0FoeFhLY3h4THljSFpTajZURGJhMFo2U2ZBeVlveGlr?=
 =?utf-8?B?eEFwVTZXcEJGTzQ3SVhxZjZjZUJJSjd2eGUzUzF6SVBKTGhLcW11eUkwMGpk?=
 =?utf-8?B?N0tJdFJMckNsaDBVRVpodTU0RVJzeGI2OUFhVHVUZVZERnFmZ0ZkQkozczZP?=
 =?utf-8?B?Z1BWeTZibituZkNGTVBsNnFPMkdRSDU2TFlscUltQVRCV2dscm43MS91bUlS?=
 =?utf-8?B?aUxiOXVpM3d2aWN0b09MdzBraCtaMUM1V2lHcHRWTmVTcXo2V1M0aG1vOUFN?=
 =?utf-8?B?alBjem5PM2R0c3J6aWRDY2xDYWJJYzhLaGJuTGs1UjZwakhzdlY2bktyOHR5?=
 =?utf-8?B?dTlYRzlEMHVKa1JQOGVaNzJzMkw5NmNXRVgxYmdkaXU4YVQ1emRpRUU4Y1N5?=
 =?utf-8?B?MittVGFTZGprOThJdXZtTm15WnRMUE45STUvbW5ZNXpTd0sxVEFwalZlQzUz?=
 =?utf-8?B?dk4xZkgzc0hlNlMvSFRVWUwzRkNTUnZwMkw5NjBiOEtvc0liMml0aTYxTEdR?=
 =?utf-8?B?dVg3ZERFRFBPOEovTHMzT015NDZ6ODhuTFlOTmNpbDBGNzdCbTdZZnpmNDZx?=
 =?utf-8?B?MU1MZzlJcTZNZHNSNkdicUFDTW9XWlJRRklObEhWVVRRclBXL3hIb2NiQ0FK?=
 =?utf-8?B?cHVRbWIrYi9xK1VtR0R3dEFFV2FxM2Q2d0w2UitTRkNXZzMvRE5WNzBkOWRG?=
 =?utf-8?B?b3ZQRldFMllSYkNCRkJQWDYxYjhBY2gxWkZ1eVd6eFI3c3gxVVV6b2NkbUUr?=
 =?utf-8?B?SFcyVXhmR0lyT1krSThud3JycmxtMXMvb1ZVMnJpTjFNWFRWcDRCL1dnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V3NFRnoza2p3aW9WS2tvZHhvYXRaeFZuNFpmd0owMjg0NkxKcjR3VU0xQWxH?=
 =?utf-8?B?NHBIdFhCbzdzbTlWVHUrdlRnTXdTenN3bTZPY0Mra1I5Nk1vczI4TmNhMDRU?=
 =?utf-8?B?aHFwWENTWjN4ZWFEb2pjZGRYMTJyWkltVkJYcUkwUDZ3R3lxY045dHJXdGdS?=
 =?utf-8?B?K1VjRXV1NWYwNU9Da3dWNXgyV0ZHZlY2Tk5yOW14dmpGeDJpd1Z4OW4rQmtR?=
 =?utf-8?B?QkRkbTZxMEtFcWhlYklKUVRxSERvcTY0aGZ6TEJ6Z0c5NjdmVTV6TkppZnUv?=
 =?utf-8?B?S1JOTnhPc0I4cStGUFlpMmxlQlIrbE5CTkczSHhkK3RPSENTaHU2K3N5YWFM?=
 =?utf-8?B?MTZXa2QxWHQ0SUJCYlJHdlhWeGFKT0g1a2xtY2xzU3hlcEdoT01YU0pMU2VY?=
 =?utf-8?B?Vk12RFBtN0phQzRGTktuYzArR0w3ZFJhUlFMR0kwYjE1akh3RENEV1BLbGRz?=
 =?utf-8?B?ejRSVTI5NE1LYlM5dElnMmpVSWMxN2pIclJpOFlFZlVKZnFSUXFhZTVhdmpw?=
 =?utf-8?B?akNyRlBxNGdZQnZJNFB5ZFFCYTdrSmN1VnlRQWVNOGRxZjRKTUd4QzQzNUZ1?=
 =?utf-8?B?R0srUHBpNWI4VmdHWGFWanY0ZG9SYWc3L1dhK1REa0d4RGlBbVE1ZmdOYVhr?=
 =?utf-8?B?d0ZtQXZHR05rQU95WFoxZjRUSmNjb1QzSzE2R0FuSnk1M2Y5RU56bUdnaWZM?=
 =?utf-8?B?K3FPK1M1SkZuUm1McHp4S1lxYjd0L0dVYkVjdnpHUGg5UHprODhEbHowOFFq?=
 =?utf-8?B?MlRrelFhaFJpLzNqKzhoTkhiOXlzQnJRdkNrajFhUXZ1dVhpdVZuM0Z3RnR4?=
 =?utf-8?B?Y2VobGh6WXhnb0E2NTcxa2phQWkwZC83d0hmSktacm1ZUU9ENzJzS2pPa20v?=
 =?utf-8?B?cHJFYVBYa0VXOGorYXp2UEFUN2tGOW9IU2o2Z0tGRzNUZy9ja2h5b3U4NUJ0?=
 =?utf-8?B?OVR6TUJvLyt4ZXl0QWZLSk9yYUt1cU1QSW5BT21pQkdweUN5bWwxTGNEb1hq?=
 =?utf-8?B?cUVuTFRpVlNTSXdJeWlhRVl4alJvZU1teE9TZytQbGQ4cElQMWhYeUQ4VG01?=
 =?utf-8?B?eXpCVk1jb2xraXJTR2tVbG5zbUtETzc4V3NweG9aNHp3cmxTb1JmTWJ3YkhG?=
 =?utf-8?B?VGhyM3E2U1NIZ2xZckVHanJ3S3Z3THVGTTE5LzhKZTBvSG9TRm9Kd1psMlVI?=
 =?utf-8?B?YktPd3FCNVk5ZXRKdlZLd0YyWXVYZC9FNEp5K3FubkVEYkNkYzZrbkZGbGZ1?=
 =?utf-8?B?M0Fad3ZNY1FXSHZJcHBUbkRvVnRHUEJrb0QrQWdGaThnR1JWQ1lWRzV6dFA5?=
 =?utf-8?B?SGZpbDZZQW9XSWxMNTZTaVI3STQyZDJMeEhuQWxGdzN2ZWtIdFFZNDlkL2dT?=
 =?utf-8?B?Y0M3eEZKRTNsaENHa0hoZ1grNDR3d2JLbUJkYUxSNWRGemdHSTg5dThaOXIx?=
 =?utf-8?B?Yy93RFJOSHdUQ08vcHNyWDZRRHVwYlFqME45eC8xWjFUbjNoUnNiRkN2OXRs?=
 =?utf-8?B?VWgvWXpINkJqaEVZUGtrcnVEcEovbEhzT0dXQUxpTFE3Y2E4c0tBUEVnK1dq?=
 =?utf-8?B?VWJTdXV2L1djOVhpTzNYWERwd050MEMvckpxMVVkOCtmWjIyeVgyZG4vOGMy?=
 =?utf-8?B?M243bWZtOU11eHFjOFZXOW9HR3dwM3F1L1ZTN0ZJWXJYc0FPYUF1WnpUdmNx?=
 =?utf-8?B?RERQRy9iUGRWSzZ3NlZScXlOOTg4T0F3VDdYNVRHUDZoNjdpWUZaeWQ5MzZK?=
 =?utf-8?B?by94RkduYlpIQ2hrVmhtMXpHNHlaUDI2eGNLSHo0bmV0MFF1NFJyM2s1LzBo?=
 =?utf-8?B?UUxGUURvQmw2Q25rVWNwZnQ0ODZWODNsbUdhVm5SUzMzU3FjOEZyU0Y2dUZZ?=
 =?utf-8?B?UkQxbDVTeCs3M1ZNR2tnUDRJcVJMT1F6T3hIL0xRUTF6c3lZOXN0TGJnd0oy?=
 =?utf-8?B?T2RCTzQ0eGxqSHQ5cXRwV0Y0b1A1UmJMenhZWW5aU0w0TWdoVlh1dkp4OC9j?=
 =?utf-8?B?Vy9QcGlXNUxrYWRsVzFBaXRsN0VQUnVZNndkUzc3cFU3QSs5Qm9HNHZqMDRp?=
 =?utf-8?B?eDg3NytkNGNLa1ZVelplVWh1akFKQ1BNMUZDUk1ZTlc3RlB5UzlyUlFMamtx?=
 =?utf-8?Q?rlySNXVivAPnTnB5VTC8Ztqff?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de417cc-e647-4a8a-5c39-08dc6f668d1b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 13:55:42.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WgcqsZ43ZQD8O79nNmMscHiXgai6eTHw4DL0zqSxO75HGzHtGCyfkVlHplYCaq1+I5c4UPb3ip5qrgXO/TfeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5208
X-Proofpoint-GUID: XRJ849u9Xpkd_-pKGo87d9XIay1BniWn
X-Proofpoint-ORIG-GUID: XRJ849u9Xpkd_-pKGo87d9XIay1BniWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02

Hi Peter,

>>
>> It looks like "club" is used as a synonym to "class" here to evade the bigger issue that mpam_classes are not defined correctly as DSPRI resources should not be in the same mpam_class as the L3 CPOR and CSU features.
>>
>> This hardware makes it clear that the definition of mpam_class as all resources in a (level x {memory,cache}) needs to be revised.
>>
>> On Marvell platform, DSPRI control register (MPAMCFG_PRI_NS), and Identification Register (MPAMF_PRI_IDR_NS)  are implemented within the LLC MPAM block (the address range contains control and identification registers for CPOR, and DSPRI), and therefore we treat DSPRI as one of the L3 resource. However, suppose we approach it as totally different standalone resource type (PRI) other than Cache storage resource type (CPOR, and CCAP), and define a new MPAM class type for it, there is no standard way to discover this new resource type (PRI) from ACPI tables.
>>
>> I'm concerned about accessing DSPRI related registers, if we are going to tide it to new MPAM class (as we discover whole L3 MPAM block using firmware tables, and tide it's resources to L3 MPAM class).
> 
> This is becoming more of a discussion of MPAM (and resctrl) in
> general, so I hope James can participate. Also I should point out that
> when discussing MPAM, "resource" refers to a non-RIS MSC or a single
> RIS-index on a RIS-enabled MSC, while the "mpam_class" structure in
> the code is the counterpart to what RDT (and resctrl) call a resource.
> 
>  From my reading of the code, the consequence of (RIS) resources being
> in the same mpam_class is that they can be programmed uniformly
> through a single schema line in the schemata file, so
> __resource_props_mismatch() goes to work on eliminating any resources
> (and extra control granularity) which are not programmed exactly the
> same way. This function seems more geared toward big.LITTLE systems
> where the cache controls on one cluster are dissimilar from those on
> the peer cluster and would need to be normalized (James, can you
> confirm?). But in this situation, it seems like a better idea to
> present a separate schema for one cluster's controls from the others.
> For example, "L2P" and "L2E", with non-overlapping domains.
> 
> In the case of an MSC implementing RIS, the controls are independent
> by definition, 
This greatly relies on the implementation.

For an MSC, identical control may be situated at two separate indexes, 
each with different attributes. For instance, let's take an example
of MARVELL implementation, There are three different resources at index 
0,1,2. These are enumerated in TAD_CMN_MPAM_RIS_E:

0: MSC
1: LTG
2: DTG

LLC MSC, resource at index 1, and 2 possesses cache portion partitioning 
feature, i.e., If MPAMCFG_PART_SEL_NS[RIS] is set to 1 (LTG) or to 2 
(DTG), then MPAMF_IDR_NS[HAS_CPOR_PART] is set to 1. LTG resource has 16 
portion bitmap, and DTG has 18 portion bitmap (mapped to same CPOR 
control), and only one can be configured.

so I can't see why the work done in
> __resource_props_mismatch() would be applicable.
>
IMHO, __resource_props_mismatch would be needed for such cases.

Thanks
-Amit





