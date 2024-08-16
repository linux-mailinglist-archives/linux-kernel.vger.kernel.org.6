Return-Path: <linux-kernel+bounces-290295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB569551EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1373E286B86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFDC1C4607;
	Fri, 16 Aug 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j6Id2wzC"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409EB10E4;
	Fri, 16 Aug 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840792; cv=fail; b=PRFdoFnPG6Ech604TVPq2zgLgHHGWS2ESQ2VGPDQzRjQmRvruPe8vpiydduErPvv2RlcX/wGjdKMrxLik1XhoDBWIsWevTtgKFrkTzlZEcyn+yqsx+HtG1XGm39tddy2wQZLMBD9TYIb1OPSmfNiL36BodKx2ECZksG9pj1WZo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840792; c=relaxed/simple;
	bh=8Jbsdc4AtasXWd0VX1XL7245GeyU3JR9cweFkesypfM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y3MNZNV4irxx13A9FfBm+2JYgnwMZhniKczuiHwk46Ay829mc6aRxqwOgbTs494KWRxQfdKBGRG6ICBmUr2R8KCA8Hz4jMkZD/sWrOd7KNt95aGKrVl9ZdvUQwhwQu4pwN2lxybDMYH/9X81+LKAOPz691CW/KICZmZh5v8+QQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j6Id2wzC; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9cYZ3KC79+nN572Oaa8MQ+ees+MYwWcpKTLfZfyKIJ8VcrVGfOKZ6bhoIpPI7AkngdoPHAbTYM0SKRfTwi88xpRcaDimlsqqUWHKjHML8E21LVVIyF/BOURFAUPbzVs545WAD4KWWgh1uxIm86O74oMZpQgyTtrgmNpjXqPhAXyPXWN3imdWelxEcIyDfTDc/vd6rUHo3PCHk3BAswkW+8AAQlcRY7LP51npqZ3cGjENtnV0dWTzu5aGYJgF/CEbRraSOJPNm5gtFqBFbmc9/AZdjrRsIt5+Ql8w3f7Qb65pvt6S+G4EDfZB5rX7IGtgaZ0sRwBDHu5209bVXgnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEChM7PCLg/DutZat9TCJNFFmfOYf+B+WyOTrSDyV/M=;
 b=LvQ2VA6TCh05Nk97E46wn2CulszFn0f2xifebfy2/zYDrX6AB7bp4bGr3u9lGO0R+losT73i3KQG3/zOAxnqsdqxdd4GlM/B2QGkc7SbHzAhZrWMm2G8wXnjQpm2yEht1ALbROFrzCB0Sj85QqVd7RRb8Uney8QYgntybEnnngQRQXqundaXUv34GZ9NEy5cqhgBXqjWZRvUvqJeGYs5WHmyWLSHodfhtcZU7DaAjZ+jcjXA6f62KWN9iWW+qDm9c1LgwQdSFuDgZFBzoDdFGL3nmMEoKuFd9mi+wxNCytNF+hDXQrSzcr0ayn5iYl9X/9ThMB1E19uRjNctnbWVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEChM7PCLg/DutZat9TCJNFFmfOYf+B+WyOTrSDyV/M=;
 b=j6Id2wzCKBS8KXBHxIHrjCjltyJnWvmK3h6Td/lctMMRTMNJbEr/xqD+mt9tLrwPKKaIvHMMimovzCTmLvkmrVadSbdpwUaUixuqO2bt6xg4AvpOjAqDLYkQTM4WVykX81wAEKMGnTXUdhp5wxmQfm3QoQuAUwgiwBJB4XmGZMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 20:39:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 20:39:46 +0000
Message-ID: <4bac083a-1d51-41c3-992f-c09235db8a73@amd.com>
Date: Fri, 16 Aug 2024 15:39:41 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 15/22] x86/resctrl: Add the interface to assign a
 hardware counter
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com,
 dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <099ecbbe678dd44387a8962d0cb81e61500cd2fa.1722981659.git.babu.moger@amd.com>
 <63bdd436-7bc3-4ccb-a182-5ae596fefd5a@arm.com>
Content-Language: en-US
In-Reply-To: <63bdd436-7bc3-4ccb-a182-5ae596fefd5a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f91b44f-0ffb-45a9-8c1b-08dcbe3390fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1dTMUxiYXVBVG1pSk4rZFlLcDZWVTNEOThiUUExSDdWcER4KzFyTlRtSmh3?=
 =?utf-8?B?TGp1L3NuR0NUSE1NYVo2K1pVTHplbkNjS1JLbERTTFMvK0FUQXJxaktzWndU?=
 =?utf-8?B?cDJBVG5RWXJjaVBNbXAvQkcxSlpRSXJTb2tvdVp2QlpEUVN3K2J1d2czWXBt?=
 =?utf-8?B?YmVETUtYK1N6bXowTkVQTldTL1UxVUlTRWdER3hReWdPcWdLL0xEbnY3cnNL?=
 =?utf-8?B?Yml1eFhsL2VjNk0rRVViYnA0V3g5bUYreVVIeGUzbzlwUURkOEVNNVVOd1ll?=
 =?utf-8?B?ekU5UENQT1MwOVNQMGViM3dKZnZ1c0J2QnVkQ1FNN3pJR2NWODV4UVUwN0FK?=
 =?utf-8?B?Y2hFS1U4RGtGUUxYSU9YY0JJa2VYRFd4TjRkZGRyWE1ubUljZVBwRlpYWEN6?=
 =?utf-8?B?c1pGTVovTVZGOEVsSFNQL1pOVENsYXRTV0dBbkw4YTkyclQ4T01ENTM2M2tn?=
 =?utf-8?B?VDhmM1J5WVV1cmdtK1J5WFFxTlZNUDdhc2trbVN0SFo4MDZRVmZjOWtGdnZZ?=
 =?utf-8?B?N0EyNlRSZUtlNnNvUFZ2RThFdTUzck9BeGVRYmNIbjA3cGY0S2xmZGxxa2Jt?=
 =?utf-8?B?TVozMmRuYjU4RWtDTlB1cTJVT0ZRREkxWkhwVG9lSmVlcHBZRkxiS21IdFpv?=
 =?utf-8?B?QVlYekNuemprNXY0UDI5YWxWMjBFMGRpM1lYSHRtY3Fjam14d2hUSzJRbzAx?=
 =?utf-8?B?Q2lXNitoTWM3ZFI1RGIzNWs3Rkk1d3JXbmtTNTJWakRURnEyeWk4LzQxU21D?=
 =?utf-8?B?L1Z5cXZMK29qKzJwejMwNWtlekowZ29PYStaOUxaOFRkM0d4a01UUmpjNnh2?=
 =?utf-8?B?Zjhmdkc5TXpadTFRZm11S1VIazV1aTFYYkRrZnV0QXFrOFF5UTV2Y1JiZkVP?=
 =?utf-8?B?K0VZUDNvV1dzeTZTaEFwc3lIOUZmRENQSDh6TnNkcGxzNUtEVWQzQnFyT0Zy?=
 =?utf-8?B?V2lmU09hYTFLbzQxWU9hSldYckY1NXFiLzk3VVFlb3RPQjJhdmpHM004Y0pC?=
 =?utf-8?B?cEo4aHN5MnlFTkVIeHN4MmZROTFZK3BPSE0xZlNvdWRwVUYzU1JIWVFsZ1pY?=
 =?utf-8?B?VDJiMlFiUWFja3QyUFdITUNCQllsRDhWOG5vTEFNU3Y2b0RFR3U3NXM5c1lv?=
 =?utf-8?B?TjhFSE5JUlpjUmhibExLazlTZjBzWlIvT2lTMk9PM2tBNDBNOEJhNmlnOS9r?=
 =?utf-8?B?OFByOG5PcTkrbDJodXdISWdjSENkSEpud1JWTXhwQmJ5Q1pTazdVeVQ3Rnhu?=
 =?utf-8?B?UkNCT1RFdERFVWI1VWNVY0ZqZkpTL2RwU1YzVy80MkE4YkpxM3NQeld6QlVx?=
 =?utf-8?B?a2lOOGdwek03U0EvMzNsTFJiUUV3K081aUhLZFhRM3ZyWkV4RjZqN2hTcmw4?=
 =?utf-8?B?ZXVuQVVTSmxMYno4bnpHZFFBUHpJeUV1aXhWcmlocTR4WXM5RUp6ajJ0bzAr?=
 =?utf-8?B?WEt5NkhsU0MyRTgybm5USEZhb21TdncvVVVZWlp5enFQbG5lQ2lIU0x2L3JT?=
 =?utf-8?B?elVnTjYxdXBOdDNwSlVhZVA0Q2hLWDZZWjViMzI2YTRlREUyQXRZZnhDT21Y?=
 =?utf-8?B?MjF4MXdoR3lQYWNweHkxM3l1Y3V6VmgzRlBVVUdkbmZLeFNyMnd5UENYMm04?=
 =?utf-8?B?cVVkZjh2RTJadzJsK3Vqa2owajNhbW9CT3pmQ1lIMXdwTUFPS3lYUlNndnJj?=
 =?utf-8?B?bEhPaXRINUZ5QW40ekZqWW4vNU1sMkJXdXdSa253WUozaHlxVXlRRm1wYWRT?=
 =?utf-8?B?NmcvQmc5dWN5QUlKUyt6bEZVZWxVbzM0MGVDMTZpdmhmeUtIOUZzMG9PSGZk?=
 =?utf-8?B?MWxrNFZ5MFQ4Rm5WOC9jQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnR0QUx3S3VBMFV3T3dLb3Q4d21ZYmJ1V1pVamN3TE5CazR2cm9OTnpQRlY3?=
 =?utf-8?B?S3plQ1hZRTNtQjhjNHVkdFFXSzczcVpRNlVRR1JXLzVEZ2JKaVowc0Rsa3ZI?=
 =?utf-8?B?VVJidHQ1c2p6TE1sQVFLZGlnaE1KMFdVWGU0Z0pWdGhmVkZvUDV6YmdGNFJh?=
 =?utf-8?B?SnNSTlU4VmQxaFRyazRxM1hVSlJIeFU0aFRueEF2aEMzL3pzeHk3eEZmQWtj?=
 =?utf-8?B?bFkwamJHMXRiNWhDdzZtUUg3VVJwTytMbmJJR0YxZmo3SERpWkl4VUV0TDFL?=
 =?utf-8?B?VEw3MXB6c3RTZnR0VFRON29zUTY2dzRpZUdURTRYZXA5b3A5c0MvcWdpb0hJ?=
 =?utf-8?B?K0VoZ3pydnUrWEgwaFduVTZsYVFBRDhJMnJvTVNLUHIzVnZGbzVpaEsrZXBQ?=
 =?utf-8?B?MTR1R1R5eDRqWnUrUEVkN0hwWGtQcC9IYzRSUWlzSUlOYmp4VnpVeXE1ZzRU?=
 =?utf-8?B?aC9ocFVCdTdyZExCajlpWGlaU29lTHdyRW0rVkRWT0RObCt6Ym80SnpYVnVX?=
 =?utf-8?B?dHpOUitzS3ZyVXJQY1JTcGhyaHRHS2Fwc0U2ZDgxVWdQQzdIanpKMCtsWGpL?=
 =?utf-8?B?OWVOZ2I5d1p2OGU5YjBJQ1cxQmdVNzdoUCs5RXhVVEFYeDBHUy9IZ216cS9H?=
 =?utf-8?B?RlIrT2NnenkxSWVZOXZVTEg2amdzejYxTkVuNTRlcDYwb0FJRlRzQ1JUK3F3?=
 =?utf-8?B?YlpSeUxJZG1KVFFBT3ZiOU92UHVDYjU1TVRsK3JaRXFSeWNnN3dqcEtHTFU2?=
 =?utf-8?B?S3dpMitTOHU4RklueURsOHJjVkYxcVYxS01sVENzL3hOVEV0R3ptZUdGK2xR?=
 =?utf-8?B?ZncwaUMwMkRwRDhKbGhZYWZrQjJobUh0dVd4a0tnRWorcnFKZ0N4azFFSEhk?=
 =?utf-8?B?SENKbE5NYk1vckJCSzMzMCtySitWeVZ5aTNvN0pZdnB5TW5mMjFrcEJRWHA3?=
 =?utf-8?B?NXBRUjJVNjg3Y1pCOWxDb1FmYVBkaFZ5akFzRGUwbEdTY3YvZGZWM2FYWnQ4?=
 =?utf-8?B?TWVKRnZvMWl1Szd4aTIvaUdxN01tRVNFTVVKSTFOUWNtYm0rb1htcktiVi9E?=
 =?utf-8?B?eEN3a21nU2lzZnNteXhSN2hLTVd0YjhOVTQ4Z1djSGhoeDFNcHVTa1RvNm5Q?=
 =?utf-8?B?SExEMHBqcEh0VFpENCtWRndHek41YWZpUGh3UVZkQjFBQ1lBbVRuUCt2RU9P?=
 =?utf-8?B?OTRwQ2Z4amRZN3N0aVgra205d1lxeEJUblZvdXNwYnZsVVIycHEvQUI1U3pY?=
 =?utf-8?B?UHpUUFRob3hZVzdyajFacXhxaG1mb085YmM0ZjBnSWFsOXRIeExRcmQ1S290?=
 =?utf-8?B?SnVBUitqa3h0em9mUjBDa05jQWxCanJkUW5aRHRrRUFhYTl1NU9uQnYvcy9j?=
 =?utf-8?B?bjM3WUVMcFlTRWZEZzRPY1lGVUUyU0lJdCtwK2VtWTA2TFFqR3JxT0FFWHo3?=
 =?utf-8?B?T1A3cWUyS1h0cFRmZHpCcGMwS2lOZXlzQTBtM2VGWW5RbXl2aXByMGdROXpQ?=
 =?utf-8?B?Um5aSFlhczlPclE0OXlCMzM3NWRPNUZBNjVsOGVEWnFCb2FtSTRVelZjZXVh?=
 =?utf-8?B?VE1CUVpLTUIwdWQ1alFwU1cvaWkvTDk4UTJKcG5obExwM0tGcVBiY3ZhWUNL?=
 =?utf-8?B?TU5JY3JpOEdoOXgvVmc5YzFkSHpkc2Z0aHdSK0p4NVhsUFhBblhVMG9GalBz?=
 =?utf-8?B?R0UvYlk1VlpoVTZVZ1hGT0x3UWJCVmFNNmpneVgxTk5pVjNieHU0aElKa2RY?=
 =?utf-8?B?VFJYV1BXY2c3NnFkVHV3RDc2RGY4c2tKa2NWS01Hc3JyR1lySHZsY0M0V09r?=
 =?utf-8?B?VVpyQnNvMEhQeWdXSDFnY3VycWk3Q3hSSHdoTmNwQ0p4UG4rNndBbk9yTGU0?=
 =?utf-8?B?ZDd6VTduRDBhenQ0d3VoSUxPOGFycmdEYXRBWllyeVJNSERqRlQ4dE05eTNF?=
 =?utf-8?B?MjNZVng4Sk5BQUJFeGpPcXBmY1RqeFRxZlBGK200V3hhUGllVHNEUUo3bXNl?=
 =?utf-8?B?VERGSlFtVXFRMmVxU2luOUpWaWE0VEl5YUc2VGxEcnFyN0EweW05bDI0WHJu?=
 =?utf-8?B?TUN0bmh6UE8vbEVra05wc3JIeEJzS1ZjaDlYWGtuay9lNkJlSUZYaldqZXVZ?=
 =?utf-8?Q?hGrA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f91b44f-0ffb-45a9-8c1b-08dcbe3390fa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:39:46.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgRXpFPUEIZ1DPPdH3r5/3Kit+VF2p/rBKXPvZLhVHy+q7mlUg/2fBc82L+KPx+x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247

Hi James,


On 8/16/24 11:30, James Morse wrote:
> Hi Babu,
> 
> On 06/08/2024 23:00, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>> The assigned RMID will be tracked by the hardware until the user unassigns
>> it manually.
>>
>> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
>> specifying the counter id, bandwidth source, and bandwidth types.
>>
>> Provide the interface to assign the counter ids to RMID.
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>     Monitoring (ABMC).
> 
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 60696b248b56..1ee91a7293a8 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1864,6 +1864,103 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
> 
>> +/*
>> + * Send an IPI to the domain to assign the counter id to RMID.
>> + */
>> +int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum resctrl_event_id evtid,
>> +			     u32 rmid, u32 cntr_id, u32 closid, bool assign)
> 
> MPAM ends up with a per-resource array of monitor-ids that it uses to map cntr_id
> allocated by resctrl to the underlying hardware id. Could this function pass the struct
> rdt_resource too?
> (this saves me having to assume its the L3 - adding to the technical debt in this area)

Yes. We can pass rdt_resource. It will be 7 parameters for this function.
Hope that is fine.

> 
> Nit: could closid and rmid appear next to each other, and in that order ... just to fit
> with other helpers that take both.

Sure.

> 
> 
>> +{
>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +	struct arch_mbm_state *arch_mbm;
>> +
>> +	abmc_cfg.split.cfg_en = 1;
>> +	abmc_cfg.split.cntr_en = assign ? 1 : 0;
>> +	abmc_cfg.split.cntr_id = cntr_id;
>> +	abmc_cfg.split.bw_src = rmid;
>> +
>> +	/* Update the event configuration from the domain */
>> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
>> +		arch_mbm = &hw_dom->arch_mbm_total[rmid];
>> +	} else {
>> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
>> +		arch_mbm = &hw_dom->arch_mbm_local[rmid];
>> +	}
>> +
>> +	smp_call_function_any(&d->hdr.cpu_mask, rdtgroup_abmc_cfg, &abmc_cfg, 1);
>> +
>> +	/*
>> +	 * Reset the architectural state so that reading of hardware
>> +	 * counter is not considered as an overflow in next update.
>> +	 */
>> +	if (arch_mbm)
>> +		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
>> +
>> +	return 0;
>> +}
> 
> 
> Thanks,
> 
> James
> 

-- 
Thanks
Babu Moger

