Return-Path: <linux-kernel+bounces-295730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF195A0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB396285561
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD027405A;
	Wed, 21 Aug 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZGRlk63y"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47879F4;
	Wed, 21 Aug 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252697; cv=fail; b=nQ+RVwc0vWcalFYOmzqSDoRn4TOwIp1f5APM5xGDYvGJBySX1pMhpeor2j9VLiOfdw/m+LawKligAwbgz0vrJbxl28SXtIsKvd0WxMvhlgbYMRLuc9EqWiPbLNeFc4LD5MWAuS0yk3DnysWbWshsvhy7k8hk4nIO5S+dENWfI/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252697; c=relaxed/simple;
	bh=nGiLUexhFHhx4LKxo8DaZwmFSrypUvF58tjof+JPdiA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ub6fAOonbcwaF+6LYb87v6tRgPM81kmEcKSQplmatNN+MtfKC3YjCLisemf4L06wmlf0B6FXtsBc6F5mBw0Oig9f25LQuu46vRXxSYZtIApXMmLE3/W2GDahktA+vogvSKNkum6t5nVgkOWE8zezgOUUz8CfNE84xctNktaBWhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZGRlk63y; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jseBhFY6xyoZTelvvEVS/bxHdKolvdRFF47VPKruPUn2GCzq2KSJp0BMuhy8kjBKvNxUp5UZ0tOGGV7tL3VjvXUMTZuiuCQfTaPp0Rq1kI2IbZGkZV0/vIH6IlcpFdRsK8BuZNDDO0KAwbfYQpFS9Od43P/WofPfjaCv/1Q+Vx5iuyaWShxIyKokJuirQ5Khdo8x2UfRzTQ72QhCXeBDK7DrvKv0WD1vsAwbz1lpZivjoiesWurwWCwiBSwbKqpYPrr50NBlncQiXv792anQBK7Hgvb7q5mDaE7xves1rACSlw8tZI5GNbyGA6gCTGeMIPpeXFy5E9Ycxoso1OAaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXkzxZpv5HAXtxZzuKJLl90pkEgRpSK1srHas5VxKw0=;
 b=u6lLSpK+0Xs0neHqQ3mblTDTopbSJONOsxuNMrY+uPcxfy9x7lCQuLV88HtRiyl3OOSLIOw1PwPKMGI6vug5AdJm+Zx/QuUA/a47Qjq3fcKcta8qpelA/Qr1zHwq0BQ225+MLjuvVqQIEh4qBrsl81PNJeQSz8rSW85FZwmPmZgJOc27/gHgIwo4lQFsOZgQa86RmlDO5X4XlpCMHAW1BrvwKABp/OjBvT1YwNxSa3bLTB3whSU8kqZQXiPWFUVVmBPdSxop27uYbOUPNgo4uJ9mmgSoHTQwq1wv4hq2lzrJ28M82pZmKv8dcA48wgck9e/5ike3LCwhvTYysWOzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXkzxZpv5HAXtxZzuKJLl90pkEgRpSK1srHas5VxKw0=;
 b=ZGRlk63yB5DsI4I/Pv1fRyKAa9o3e2Es1HMxB9W8AzwAHEBBwxkOGSupPqOBDSpKFrdmtktDUF+ESUBtyHMDfvlpgsamMhDp+kNXVnYMPOvYPcxTWSdtFWUdqj3zsWC4AtD4Oq70gRVZ9LZh1cvurryNlUTqfiZ8hzp7XhMTE5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 15:04:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 15:04:52 +0000
Message-ID: <04fe3163-3a7c-4eef-b267-4da6e178e427@amd.com>
Date: Wed, 21 Aug 2024 10:04:48 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v6 15/22] x86/resctrl: Add the interface to assign a
 hardware counter
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <099ecbbe678dd44387a8962d0cb81e61500cd2fa.1722981659.git.babu.moger@amd.com>
 <aa118320-72eb-4dd6-8826-0f3f7287becc@intel.com>
Content-Language: en-US
In-Reply-To: <aa118320-72eb-4dd6-8826-0f3f7287becc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: b172ad7d-ee60-46f5-9445-08dcc1f29bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW5mRStOd1ljSk1VWjExdjJMMVhXTHZUOENMdmtPbS9NZEZOeWVnUjlaVUov?=
 =?utf-8?B?MTVyMXlKV3c3WHd0bWdsa2dDa0pLRDcwNGdObngxeGJLK2R1OEtVQzlaYzBH?=
 =?utf-8?B?UGRoa2wyNVREcUtJMUc1ckdxZjJVNUYvN1ArSVphblNsS1RmU29HQWlEeWhr?=
 =?utf-8?B?N3F0TGRjcTVvRUtUckVtbEtDMmwxNU9vM1BQeFVadjQ5UEowcVdQTE5yRGo1?=
 =?utf-8?B?d1U1cjJqN2tyRVlXWEIwdFJiSTJueTZiVE93STArUFRGU2ZQQzIxNHNiNnV6?=
 =?utf-8?B?UlRId0g0YXVYQUQ3R3Z0NW0rVHRVTUJlbHNuendoSlNOY1ZESWhEZGFUU3R6?=
 =?utf-8?B?L0pmNC8xSzcxcVBZN2x3Yldmb3hSTGFSdUJhTHVDekQ0ekdKWG9sbEtZNncz?=
 =?utf-8?B?dXloMEpKQUZrQldhTVdRcTU2MVlaOU9oVXlEZUk3N1pZNW5TNHRMcE9QT3d0?=
 =?utf-8?B?RkFHc1VyMnpiaXpORnpjM09id1BMODNPaDRTS2E4L2kzVE8vUVRZZWZXYXhL?=
 =?utf-8?B?NE42eXhHOGlRbFpYR2R1RXd5ZVM4bzc3VXlGd2N6TTZlM29sQnVJQ2h5UXN3?=
 =?utf-8?B?enhKRWJDKys0R0N3b09FSkdzSmhiY1p1N2dYNHFLbmt5Q05vS2FwYkFQWmlS?=
 =?utf-8?B?dzFBNDdWQUo4dVIwUkV2Zk1KQ3VoQ1J2WUg1Ly9QQ21SSVpEZlNuK0tYWFZO?=
 =?utf-8?B?Z1RvZnQ3aWxUbmU3bHErTmUxZ3R4NncyWnNXa2VwZzdSaFpyb2lBbE8rcmxI?=
 =?utf-8?B?WUtwbklWdHJ2R0pWV3pPNEZZUWtqc2RjdnF3NWVtVzE2N0grbHdvZWpGK21E?=
 =?utf-8?B?U0JCS0g4bFNoSW9RQ0ZwS3hna0p2Y2FFa3lScndVRVpvTG82bktkS2pDRjU3?=
 =?utf-8?B?MFVOb0ZqWHF1aHIvMUV1RHo1V1NGZXNhN2tKc1JOek05THVKYzd1QXpkbzBx?=
 =?utf-8?B?MFFaOFBha1Q1RERhYWYzWVZ3bmZjSnEvamtTSEg1M0pyUFYyS2pNWUlOZ3Rw?=
 =?utf-8?B?aG8vR2wrZmJ0MTBlbW1BK2F4YjBSQTR1YzNrMXdJcHFtREpOdzMvODRsbkh0?=
 =?utf-8?B?d0NXRldQVGE4M1R2WHdOMUliRSs5b255QWtIeGRoRkx6VVJ6bTMzV0FVbUh2?=
 =?utf-8?B?cGJMQzkrVU9peFVGa0Y4cHB2d29rbG1rUDk0Vlh0KytOeW9HZkRlL1NhdEZp?=
 =?utf-8?B?b0p0YnI0UjJYUThrcWJMakVTVks4N2JnTFNuWHFSdkhna09obEtoUU9zNVJP?=
 =?utf-8?B?cjB2STJUTGFxeTJpWFVxU0NrOWJ3TEt3MnltaytqaUNVOEJUK29adUZZK3k3?=
 =?utf-8?B?NDJ4U1NDTUhkTExBbFZaTWtJbXBKT1BOa0xrME52VzFPcVY3clg3d0g0aFhy?=
 =?utf-8?B?UWNoWkxVWGF0L2lsL1IzM3hvd2FEUkIzY3ZZS2FWYVppTHlBU1VuTjZwUGxp?=
 =?utf-8?B?citXTjlKUHlvNyt0cmlNRkVUNGxEMzFXUWNRL0E0ZnFWMExja3pQb092L0Va?=
 =?utf-8?B?Yjd0RllndjJ2dUdZVzVlUFJ3TktuRDdha3ZFYWVQMTZ6ZEdkL2tlbVFzU1Zy?=
 =?utf-8?B?Y29DaWRRdEJFR0NQUisvdVJkdXhPNFdmTlo2ekNkQUliNGxKZTdOdlNkVDFu?=
 =?utf-8?B?dXg1eE1kS2lsUTY5ZnA4eVBsM0E0Wk9kM25kY0FMZHJDRStqVTlJSlY2VTkz?=
 =?utf-8?B?YTJZZFNuNHJSM2NDcExvcGxUOE9BelljTytQN1NNUkRnZnQweWZTcXlJbXNZ?=
 =?utf-8?B?akpYYkU3M29ydjNQeEd1UHUvazJiNTRmbTZuNW1LclArbFZvOG5WM1Q3azN3?=
 =?utf-8?Q?xN5J8O9KeWNv9sXHSZPCqzOuZbX5s7hYvHPMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVowVkxUOXVaNlZmd2hTZnprL1NtUHJkSmJUYVB5RDhzZDdFMkpjdXlCeEdN?=
 =?utf-8?B?MEJnUHZFaVlZbGlSVUdyVjR5dDMzaHE0TVg2MjZFa0VRc1JqYlU2b3dEN25W?=
 =?utf-8?B?dkxyaTcwZE42QkNhdXVoWGI0aXlET3BFcVZTRkpONjBBdGg1ZGl2OFJXRVdR?=
 =?utf-8?B?S3dKQ01naGMrRjdEQmRGUjdBcGJkUUQzTjVYSm9rSm5MTndTS2lHeW9DOGdZ?=
 =?utf-8?B?dGhIY29PeVQzbDNyTXE4cmM3S1B1dzI0MmRJVXE4UDBiUWR6L1pMbUtJZDFz?=
 =?utf-8?B?aENza1UydUtaVVlhb0dxQTRpallheURZY3c4MFRKZ0piRVpyZGlTUlorZURP?=
 =?utf-8?B?N29yRnZCM1Vjc0djYjFqZmJJOFFXTUF2NGNGOFBoMFpoV2I0MmJiS2t6UW00?=
 =?utf-8?B?N01RQnhsbkwzNXdjaHk2amd6WHd4Yk9yQ2pZL1pRRDlyZHJiaWtuNEZ4bWJy?=
 =?utf-8?B?bFg1YUh2MkpzM3pNS0x1Rjg1L21vYk5vYlZPWEZqWCtZY0RiOExJdU1PMnln?=
 =?utf-8?B?NDlFOUFtbE9EeHhzait4dE9GSklBbitTNE5CR3FocmZXTklhZHlIeFFzWGRX?=
 =?utf-8?B?V3FvWTJMUGt3Sm1HRVhnMGVBbjBOeU9mZ0liRFZtbkc3NDFySXAvZG9lNytu?=
 =?utf-8?B?djd2ZFRiVjVDTm9XUFFFMkMyRlQ1ckhZeEY3OGZSaW1zVmJkc0k2SlpKeU1H?=
 =?utf-8?B?eklUTU1LL04zSGhodFVRaGN3eFc5YWNPN1dNS1NIOXhJSGFGaWNEakJEYThQ?=
 =?utf-8?B?RjNHQVVJa1cyWGxXQXN2OFBpSFdiNGpxUitOSGhFMitzbEtKTlk4a1RYeEdk?=
 =?utf-8?B?YURTTVk5cHVGOWIwR25mNVVodEw3MERyVjRra3BEWkd2OFlHUHk3UXd1Ujkv?=
 =?utf-8?B?UHV5RHpjWW56V2t1MmVCb2dzT0VVdTE2dmJqSUtIMVcvYVk4R0pJNjg4TUs2?=
 =?utf-8?B?R0wzQVNQNGxVNEdzWWp6OWJvbDdXVVlHMGE0MTJwa2hLTUFCb2IzczI3Um1l?=
 =?utf-8?B?SEZGVTBzaFlaVXRsTFJwVDY5c3JxK01iYnpGenlNT29LVGdzZmRFMmVWL09t?=
 =?utf-8?B?MENCSlBDL3VUaks1bW1SWVR3dXlydWlGcnRDeDdHK1RiZ2pEemt0c1RvLzJm?=
 =?utf-8?B?NGZ6cEdqbXoxaVFkVVI3S2lWaDRQM3dqQVI0b2xkNHpaUEhtM2tGbGJvYW1W?=
 =?utf-8?B?QitzUDNTRFRtb2d5TlJSVkJHMGViUU5wck16c09wamJxcW9SZkwvV3Q1ZlFx?=
 =?utf-8?B?NHU3WmhHcm8xZ3h3dzZQVGkxeTJ1ZUsySVhjYVQyRU9zLzF2dEpMaWFGMHc4?=
 =?utf-8?B?VTg4NE9CMHp0UGpicTNLbE9BMERNb1JLcE9MRmFWWDVBVktWZTR5L0t5bVVj?=
 =?utf-8?B?azdoL3NzSUROejc3U3RQd0I4RGZYSWpvaGRDMWxhaitnN0pqUmlVcTlMUjVK?=
 =?utf-8?B?MmxqTXJIdTN5Y20yeXF0ZnBaVmJMVVQ1MFozWThqeW5zaC9RQWFEMzIvYjJs?=
 =?utf-8?B?OU90TUNtNHEwQjRGbUJ1Nk5DQ1phc0tISkg0aWNrME41WTJNcndxa1BTU0tF?=
 =?utf-8?B?R2hTZThlNHpIWmpYVjZPdk41V3FpWHNSVlk0Y0ZCVnZ6UFRORXc3S1RDZThV?=
 =?utf-8?B?d3UwOUFXZjJxTm5nL0xPSUNNc2QwLzU4WklUSTY3VENMMnlmdFBYOS9NTkZ5?=
 =?utf-8?B?VFhCMTdydlU3T2J0MUcreDFNZTJjRmZXTk5WRGd4bmtWeEpXb0JycENXYTd2?=
 =?utf-8?B?OEdFaGZXS0JPOFZnR2FNZzZUMkhzTUlMUGE2Umo1aldEY0ZjRmFKUU1FMmtp?=
 =?utf-8?B?VWExSjkrTnlrcXRmTEZXODZ6c3lqaThSdGZyTlRpRXlRUGN6dHFVQnhCRzNq?=
 =?utf-8?B?eXBtNDhBM3hGUzZPb3MwSEp5VzZ6NCs0cHBYTkZpalpUVy93V2lReFlXR1lj?=
 =?utf-8?B?SjVWZHdUVHhjZ2t3QkJsSUNlZEJNazZxYThybUluMUlLTllvOER4NHFRcUhI?=
 =?utf-8?B?a2xOVWFWSVpDSE5ER1JUdG92NDJYTVpzWHllSmxWcFhvZmRlb2c5bllMcVU0?=
 =?utf-8?B?ZGtZUWszem94ckpGRTBUSVJzcVZOaWRNRElXRUpnMnpqRm5vQjROam4zcCto?=
 =?utf-8?Q?3wPc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b172ad7d-ee60-46f5-9445-08dcc1f29bd3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 15:04:52.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcFhrjNv8A50rp2mqIpSLXzsFDCF2J29+uO5yYEHC9/STeAr+t0Wy3JSAQ8nnnzP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964

Hi Reinette,

On 8/16/2024 4:41 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
> 
> This patch is a mix of resctrl fs and arch code, could each piece please
> be desribed clearly?

I will separate them. That is probably better.

> 
>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>> The assigned RMID will be tracked by the hardware until the user 
>> unassigns
>> it manually.
>>
>> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
>> specifying the counter id, bandwidth source, and bandwidth types.
>>
>> Provide the interface to assign the counter ids to RMID.
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable 
>> Bandwidth
>>      Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: Removed mbm_cntr_alloc() from this patch to keep fs and arch code
>>      separate.
>>      Added code to update the counter assignment at domain level.
>>
>> v5: Few name changes to match cntr_id.
>>      Changed the function names to
>>        rdtgroup_assign_cntr
>>        resctr_arch_assign_cntr
>>        More comments on commit log.
>>        Added function summary.
>>
>> v4: Commit message update.
>>        User bitmap APIs where applicable.
>>        Changed the interfaces considering MPAM(arm).
>>        Added domain specific assignment.
>>
>> v3: Removed the static from the prototype of rdtgroup_assign_abmc.
>>        The function is not called directly from user anymore. These
>>        changes are related to global assignment interface.
>>
>> v2: Minor text changes in commit message.
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  4 ++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 97 ++++++++++++++++++++++++++
>>   2 files changed, 101 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h 
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index d93082b65d69..4e8109dee174 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -685,6 +685,10 @@ int mbm_cntr_alloc(struct rdt_resource *r);
>>   void mbm_cntr_free(u32 cntr_id);
>>   void resctrl_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
>>   unsigned int mon_event_config_index_get(u32 evtid);
>> +int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum 
>> resctrl_event_id evtid,
>> +                 u32 rmid, u32 cntr_id, u32 closid, bool assign);
>> +int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum 
>> resctrl_event_id evtid);
>> +int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 60696b248b56..1ee91a7293a8 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1864,6 +1864,103 @@ static ssize_t 
>> mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>       return ret ?: nbytes;
>>   }
>> +static void rdtgroup_abmc_cfg(void *info)
> 
> This has nothing to do with a resctrl group (arch code has no insight 
> into the groups anyway).
> Maybe an arch specific name like "resctrl_abmc_config_one_amd()" to 
> match earlier
> "resctrl_abmc_set_one_amd()"?
> 

Sure.

> 
>> +{
>> +    u64 *msrval = info;
>> +
>> +    wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
>> +}
>> +
>> +/*
>> + * Send an IPI to the domain to assign the counter id to RMID.
>> + */
>> +int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum 
>> resctrl_event_id evtid,
>> +                 u32 rmid, u32 cntr_id, u32 closid, bool assign)
>> +{
>> +    struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +    union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +    struct arch_mbm_state *arch_mbm;
>> +
>> +    abmc_cfg.split.cfg_en = 1;
>> +    abmc_cfg.split.cntr_en = assign ? 1 : 0;
>> +    abmc_cfg.split.cntr_id = cntr_id;
>> +    abmc_cfg.split.bw_src = rmid;
>> +
>> +    /* Update the event configuration from the domain */
>> +    if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>> +        abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
>> +        arch_mbm = &hw_dom->arch_mbm_total[rmid];
>> +    } else {
>> +        abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
>> +        arch_mbm = &hw_dom->arch_mbm_local[rmid];
>> +    }
>> +
>> +    smp_call_function_any(&d->hdr.cpu_mask, rdtgroup_abmc_cfg, 
>> &abmc_cfg, 1);
>> +
>> +    /*
>> +     * Reset the architectural state so that reading of hardware
>> +     * counter is not considered as an overflow in next update.
>> +     */
>> +    if (arch_mbm)
>> +        memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
>> +
>> +    return 0;
>> +}
>> +
>> +/* Allocate a new counter id if the event is unassigned */
>> +int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index)
>> +{
>> +    struct rdt_resource *r = 
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    int cntr_id;
>> +
>> +    /* Nothing to do if event has been assigned already */
>> +    if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET) {
>> +        rdt_last_cmd_puts("ABMC counter is assigned already\n");
> 
> This is resctrl fs code. Please replace the arch specific messages
> ("ABMC") with resctrl fs terms.

Sure.

> 
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * Allocate a new counter id and update domains
>> +     */
>> +    cntr_id = mbm_cntr_alloc(r);
>> +    if (cntr_id < 0) {
>> +        rdt_last_cmd_puts("Out of ABMC counters\n");
> 
> here also.

Sure.

> 
>> +        return -ENOSPC;
>> +    }
>> +
>> +    rdtgrp->mon.cntr_id[index] = cntr_id;
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Assign a hardware counter to the group and assign the counter
>> + * all the domains in the group. It will try to allocate the mbm
>> + * counter if the counter is available.
>> + */
>> +int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum 
>> resctrl_event_id evtid)
>> +{
>> +    struct rdt_resource *r = 
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    struct rdt_mon_domain *d;
>> +    int index;
>> +
>> +    index = mon_event_config_index_get(evtid);
> 
> After going through MPAM series this no longer looks correct. As the 
> name of this
> function implies this is an index unique to the monitor event 
> configuration feature
> and as the MPAM series highlights, it is unique to the architecture, not 
> something
> that is visible to resctrl fs. resctrl fs uses the event IDs and it is 
> only when the
> fs makes a request to the architecture that this translation comes into 
> play.
> 
> With this change, what is the architecture specific "mon event config 
> index" now
> becomes part of resctrl fs used for something totally different from mon 
> event
> configuration.
> 
> I think we should separate this to make sure we distinguish between an 
> architectural
> translation and a resctrl fs translation, the array index is not the 
> same as the architecture
> specific "mov event config index".
> 
> How about we start with something simple that is defined by resctrl fs? 
> for example:
> #define MBM_EVENT_ARRAY_INDEX(_event) (_event  - 2)

Yes. Good point. We can do that.

> 
> 
>> +    if (index == INVALID_CONFIG_INDEX)
>> +        return -EINVAL;
>> +
>> +    if (rdtgroup_alloc_cntr(rdtgrp, index))
>> +        return -EINVAL;
>> +
> 
> hmmm ... so rdtgroup_alloc_cntr() returns 0 if the counter is assigned 
> already, and
> in this case the configuration is done again even if counter was already 
> assigned.
> Is this intended?

I didn't think thru this. Yea. It is not required as far as I can see.
Will address it.

> 
> rdtgroup_assign_cntr() seems to be almost identical to 
> rdtgroup_assign_update()
> that has protection against the above from happening. It looks like 
> these two
> functions can be merged into one?

Yes. We can do that.

> 
>> +    list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +        resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
>> +                     rdtgrp->mon.cntr_id[index],
> 
> There currently seems to be a mismatch between functions needing to
> access this ID directly as above in some cases while also needing to
> use helpers like rdtgroup_alloc_cntr().

I think I need to merge rdtgroup_assign_cntr(), rdtgroup_assign_update()
and rdtgroup_alloc_cntr. It will probably make it clear.
> 
> Also, as James indicated, resctrl_arch_assign_cntr() may fail on Arm
> so this needs error checking even though the x86 implementation always
> returns success.

Sure. Will do.

> 
>> +                     rdtgrp->closid, true);
>> +        set_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>       {
> 
> Reinette
> 
Thanks
- Babu Moger

