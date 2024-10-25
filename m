Return-Path: <linux-kernel+bounces-381626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9741A9B01B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D8B2827D5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3EE1F8F0E;
	Fri, 25 Oct 2024 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VjPb/gok"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3DA1B6D1E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857120; cv=fail; b=FVMA8ttgQESEvMexPWsz28J6JBzh7MY8gnNlTKpQTYOw3e1lgDlXHN4EMBpa5CGZLHIfp1Pci0tUBcXgeSmzyuoEY91HblB6SSMZV4E6XREGj2CusXjvKI4a/ifvAxB3GE5EmhDvzJzWDn2Bx832QkPw4FOSHhqvitZN9dpRPwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857120; c=relaxed/simple;
	bh=0C0PxZju/OKq5GhRgxCh4H9YCNx6R8UpJj6Jxz18WcE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mdT3VXNHT0SoALeO6HrYRgYB9tJAYFfO2hLg95QmOVUnYviApwzIrurp07RHX00dxJfiKQ5WD7HQ4ukgQF5qUmRtrwVFGoaWazq7HoUk8o/J3XVB8nB2GEgi08fzxiD6alDdVT8fjp1lyNb7xCO8USqQjH8pNizAuBsxMKuuGaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VjPb/gok; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9tsLO1KBcCh32nBAouLCzTSX4PcHhH/uxJeFQTv1Zmo432QEdc9ZlgClKMlv3gDg2xaMTz5QCiMvpvEm9eLZfvTRSyXkhip/+Al7FHAcc10a8q6ZGLHxYLKuNBkjvpniVZxak+yETUzw8wzLXNshx4yi7P8M7yfEqwqoPwopFgLHLdaj6/qnkGx7PE76Z7t5sGNSWKd0Pmug3/Lwg8OVg5YBMaT+KfQqfTOGh+6mR53IKXMdmWEJJzE43dJK+FKLrhpLkIZdirKf0QgycC6T2mrXB8FHtRoU+ztB9y8UbUD283+yGFs+nBFD0cI+jj/G8rUWMAlxkS4JLTEUUHMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQVzknJpX9uGexMryEM+QUgOkKW8fydQZdVdSobe38k=;
 b=BDamNOzzLIsiCfEfgUs1b1HnlNOOviguMcNfIYs1iY76fv/xXETBWETpg7okDMo2PcSOxfN2tBCBnnfF0fxnpp2LHBtqG6n6tCOucJhdE3i+QVL+VXY/6Xw0vowShy5go9y3SKUbym4VWUkP2OBygyO4yX3EYxTHEzGVmg2k28c5hp2Xug+82UHyP4fs+GHAKVlDSWvjrw+mlxz34SFX+GyNbnduMXdOqcYnf/sclZyzsH03F7tIBu5Ywcq9jZVD9Vs4d0ID0+43umGKj+RDS48pJBGU237bRIixW2nOk2jDUHFX8TMCmCftr0Ocp549B4PiB99sOzMpOkttvMnECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQVzknJpX9uGexMryEM+QUgOkKW8fydQZdVdSobe38k=;
 b=VjPb/gok6XEyLqoRtubCyfBcMDsyr19V+ov4F/mdY4XVotACOymwaasLKqhfNpScL7cAGGAeduF8ac4mNX7Uk8vHokp1ym5+uBR9EzFTma+b1SBqDki+lsMpt3kQp1B4vZImbaJri6Qp9ZnZEjWP0ZLkYvepCqAD/YTq4SR+k2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 11:51:55 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 11:51:54 +0000
Message-ID: <de69eefa-0da3-4142-bcd0-257248c403f1@amd.com>
Date: Fri, 25 Oct 2024 06:51:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <e4ad82d80e8a484f1d0a46ec94b7c9fccf91d13e.1729708922.git.thomas.lendacky@amd.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <e4ad82d80e8a484f1d0a46ec94b7c9fccf91d13e.1729708922.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::10) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 753ecb94-035d-4c7b-065c-08dcf4eb6adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3B0NmplMDNVdmZOOVhRbERzUGw4akhuMGRKS0hlTTJoREtacWZ3ejZYYk9C?=
 =?utf-8?B?Z0NjUC9XbzBESkpRaWNrbEl5L0RmbmZRTFJEY1QzU0JReWhLSmNQdlpLWERy?=
 =?utf-8?B?eTlFREpzOStYb0lEVTVUK2pPdkpFaWJmaGNVWjJkSC8yRG5PQU5Dc01kcHVR?=
 =?utf-8?B?aG1qUUd0TUgvZGhEWXlVUDc4eE5RSFVTVzZSaC9QbGdCMHBueXF0WmkzN0RP?=
 =?utf-8?B?TXZ0UWRzNVg5ekdETjRweFFMNnB0bjRqM3M4S1dFUjcrejNYTGlaYTVtdmpz?=
 =?utf-8?B?OFE5NUdiS0wvYkVDR0RYZmZHTHFZci9yUFdTdnRlL3U2WWRBZm9WVnJ6NU5C?=
 =?utf-8?B?a0ovcWI2K3RROWtaNW9USDU2SWRENGVBSU1taDl2NlNVVXdrUklsTm1YYWJs?=
 =?utf-8?B?MHB5VU54cVY3MDRuRjlaT0oyeXFBZVlmcUNRdC9oL2FiZG81TDdFQU03VmdQ?=
 =?utf-8?B?dnU5NVhXaHFxV1hFUmlicjY2ZmxMcGVrVlU4L0sreHBxMEY5RFV4azBNVXJZ?=
 =?utf-8?B?UWpURERqbWdjVVQ0aGtMK21XNExFdjRZc1J4OEJGMWpVeGxSRWc2cWxKNGQz?=
 =?utf-8?B?SGhNMUtYc1kwcFV0SFhpRDBCSFcrMzVobEN0N21pNkRxb3ROWlF4amZZVlQ3?=
 =?utf-8?B?Vjh2MlA3dkIzeU9Jd3BJMlBSZEViNHpsMkR2THFxbGwrNGxmUFdjODRITXhl?=
 =?utf-8?B?T1RqMkthWWEyelNFeVBwTzU4WUxHaFoxRkxVektEaFEzUXB4YklleDJTaWNs?=
 =?utf-8?B?S3pYc05xZDRCTjVvajdlQlJQNTdaNDY2TUZySCtUTk1jVWIvemFCOUVDN0Fp?=
 =?utf-8?B?czVyQVZ2SjdhRHNVWVFkaGRJR3VyTWNyYkRHU3AzbDBrMzRFcU44Vk8wcFVH?=
 =?utf-8?B?blloVGJ6emVOYWZaZ3J4OGVyN3ZrSS9ZQlBSRitiMXloYXV6RndRNHZvZ3Qz?=
 =?utf-8?B?VXAzU3BGVWdQMnBIZFg0NHhSemdJa3JWemNUOHJCWmFFelVHaXRBMjNDK2VE?=
 =?utf-8?B?c2NnMVhOSDBIS3lvRjU4cTZxUzJzZ1IwTDhEdVFkNXdWRHVXNTE0MW9nUzBT?=
 =?utf-8?B?MWhydzN6Tisza0JVNnltd2Yxa0RFbndMbGJXWkZibkJ4VUN0RGcvVUZrZHUw?=
 =?utf-8?B?MVk1Q1ZOdTlxRUNjVHBROTFkemdpZjRkeHYxY1p2QUR1aHlNV01CdjNQaEFH?=
 =?utf-8?B?Wlg5S3pxZENPcENDamJhRzZpSm8wQlVYa0RIclNFWUMwK3FDVEM4Z0tSTE5N?=
 =?utf-8?B?d2l6VlpONUJkdU9rdUk5TlRhVEdxQTZ3THlMNHB2eklYSnlFdGx1cDZFUXFi?=
 =?utf-8?B?UVZxZzRicmFpeDlDQkJlbEdGTEVydVovWDI4Wk96MkZieExWRHpNWUxtMDdZ?=
 =?utf-8?B?R3B0dmNyKzZhMVkxVHJlcE13dUpsSytXQjBXaVhFR0NKMFl2Tytra25GSzk5?=
 =?utf-8?B?MGhKTExaSHVwckxUNEFBeVZGUllyNk5SR1JqVXdLZTl1M2dWUnM4a3QxZUY2?=
 =?utf-8?B?Y3hwaS9LbGxMNmRWNEpQdHU3a0FOTUNEN1ptVE10aUF3Nyt2cFVCRXk2UmFB?=
 =?utf-8?B?SUFWaFB1dmdLa25qY1ZNOVZBUzltY1ppakVIdGhKSUhITnNIWWU4VHJuUkc4?=
 =?utf-8?B?N2NqaksrZzJqdzR5ZTY2aXF3ZFhIK1dDRC80aEFVYmpmemVoSWRVMWhUOW5Q?=
 =?utf-8?B?bzU0Z2JUeFlJWGdLNzFqb1pseWRKalNnVHdVSytmWGRnU2V5bVJyVlVJaERs?=
 =?utf-8?Q?haSpcTO+/zRXdODfTE5afgBp7QOJhVAse9zzCzq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzFuR0F3L0pFVmM4U0l3cUZsTlNSa3liaCs4TnFqNk5Xb2kwREhrblA0MGZq?=
 =?utf-8?B?UndrNzE5eGo4UXc2OWZYUHBWREhjTGtBaDFVVXJyWkZqdVIyYlFsZ1FMK2lv?=
 =?utf-8?B?NkpGeENhN0wrVHh6aUJna0dVNDZ3aXZlTEFnREFGeXA0VjdWejMva2dleENG?=
 =?utf-8?B?WU4wcndVNHdQR01wRDhZR05LQVlIMmNncVdIZGhTZU1YQldvbUNzMUdrYklo?=
 =?utf-8?B?R1VjNUZjZEVPYUs1aHQ2K1E2UmwxdWRZdXVWMll5QjdvMzZ3endwdjBvNndo?=
 =?utf-8?B?bGsvL1YzOWpSN1J4YzRrRUdHLzFTNTZjcWxiR3Y0L0hGY1BMREtaU2RJOG9D?=
 =?utf-8?B?NjFLcHRJVnZHcFVFb0FRczRnbW9yenhTSVFjbEhXSFg3Z3NjWEJuVXZmOGZr?=
 =?utf-8?B?eUxuMWlMQmp6R1lGRElSdzJ1REN6dU9xMkJobVB6WlREbUVaNGtnUmRjNklS?=
 =?utf-8?B?OStMa0J1Z2VwRks1dzRMVkU5dk50c3BsNVAxeUl6bUdkaGQ5d2ZKTGl1T05m?=
 =?utf-8?B?NC9pZm1PaWZ2UmZUaU10ekl3TC9RMkxsSG9TNVo1bTdldE1QZWVZb2o5S2pD?=
 =?utf-8?B?LzF4VEhoSkxKYmdxa3lzZ3hJRHZ4NDRpZEErU0tYOUhqb3llb0UzWXNWZVJ2?=
 =?utf-8?B?K25ROUJKbFlrYkxhcXNSd0xYMUpoY2h3Y0gwQ3VTczBjZVArdHovUTJBYzln?=
 =?utf-8?B?N3BGRVorNXZ0UDZHU1c1Y21JRDVWTFJoajRreldNZFhWNVVKOGZjMU41cmtn?=
 =?utf-8?B?eTd5TU1yRGd4b293MnVjNWVhME1DMDR5TXFBUjZjWkdZamsrd0hxL3cyK2xN?=
 =?utf-8?B?WTA1WURIMVY3YmJoSEtrbllleCtLVW9vUmNHVzhsYUJyU1YyVkttcC9aRERL?=
 =?utf-8?B?OCtvU1c0YnZwNEJmdVhBOFIxd2ZGdTlMNE1zVmZmNFhZRm5mWDJ4QkNsc0Fq?=
 =?utf-8?B?eGtpYU9qZHpNcVQxdG5BRUtvSDlNQTN4Y1EzTEI2TmtUbk9kaTArMzk1cUFU?=
 =?utf-8?B?d2hDUG9jZUp6S1VXTWdxak5XU1YxY2lFd3Y5VmJQNUlGNG9tb1k5Zm1Rc29y?=
 =?utf-8?B?ZnhLQkZiUS9LS0RZVmZORmFlendPMHB1NUNaK0ZaSXZzMHJsSDI4TzVCK2wy?=
 =?utf-8?B?dmRLc2VaKzk2TzU2NVF0dHlJbk12bDlnTUZqYnIvREtLblhJMVBmb1FyV0RD?=
 =?utf-8?B?NUtTOU1JaWRWRVBZN2lZbW00cDM2bVViZmlxSzVvRVRLN3RMVUlpbnJPT2NY?=
 =?utf-8?B?QmR6T1RFdVlGS0l2c3lsaE40TmlkUmRRdHBEZVY3Q3ZXSjgxUThBNDZtSk1k?=
 =?utf-8?B?TE1jUVRZNWhCWGsrOStlQkpZWmg1UjFjd1hvalZ1MWQ2YlNwY1B4MVRmcjVp?=
 =?utf-8?B?SlhobUdwM2djbktDdHRHckx6eG5GQmJtSVlGT1Y0bEJwZGczK1pXLzJkcXlV?=
 =?utf-8?B?UXk4OWh4STM5YTlkMENSbjY0bE51bUxtR0E2SXYvNSsrVXF3KzFGajBmT0lE?=
 =?utf-8?B?UUNmVjR2MTlCUkRvMWFvbzZXc21CUnVhZURaRTMxS2VpUktpUkt2YVZTSWli?=
 =?utf-8?B?aFJxQnNzenpybTQzVmdTci9uTmdDR2RKWHdiN2xQV054bzlvVzYyRWtNNmNs?=
 =?utf-8?B?VkJ4VWxkZXYzUGNhbnY5OVpkSlpobkdaYzFoV1Irb24ySU8wVnd6eHErbjdK?=
 =?utf-8?B?cHdIS1Z3dDh5MkdFdlYva0JmWHBiUmlUZmIycERDNkNEZXVPZHZHbHc2UWFp?=
 =?utf-8?B?aC94ZUFsdWZocUY2bkFUc1ptVTQyaWpSdEJra1RRZkZWT0g4ZEpmZFRROENP?=
 =?utf-8?B?U09Fb0xIQjJKZnowVGl6R0p0OGM1VU5ITWFkWFI4ZlFqZDNJQitIT0l3RWgy?=
 =?utf-8?B?QU9VWGU0QTFORGZ6Yy94ZUdJUGJOMzBOejRPbUZDcVRXY011d21EeDFRYVFM?=
 =?utf-8?B?TERWOFY2Q2dRYnA4UmVUSENzNzkxR24wYlFkenU4Y1RucTBVckhadFJTVHNa?=
 =?utf-8?B?a3kwcmZ1VmhuRTRNaGtQeHVtT05UTHV0YTBrV0pGdEk0eEl2UExYNHo4Y08z?=
 =?utf-8?B?dWtJa1RRK1NDV3NDV3BQSm9vWTYrblZKZWRhNjQ2bURjVEFNeWR2U1paTTBv?=
 =?utf-8?Q?mNCHPTNhSS3yzHuk6gS0mRZ7x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753ecb94-035d-4c7b-065c-08dcf4eb6adc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:51:54.1727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAnXlUnTRHAJ0toKe4+9jRUSk/yvwoQrwkz7/IbTjG5bLw3tXZOrlQ0+ios6ETDMfClqxUInYoVgGayywoK4LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794


On 10/23/2024 1:42 PM, Tom Lendacky wrote:
> In preparation for support of a segmented RMP table, treat the contiguous
> RMP table as a segmented RMP table with a single segment covering all
> of memory. By treating a contiguous RMP table as a single segment, much
> of the code that initializes and accesses the RMP can be re-used.
> 
> Segmented RMP tables can have up to 512 segment entries. Each segment
> will have metadata associated with it to identify the segment location,
> the segment size, etc. The segment data and the physical address are used
> to determine the index of the segment within the table and then the RMP
> entry within the segment. For an actual segmented RMP table environment,
> much of the segment information will come from a configuration MSR. For
> the contiguous RMP, though, much of the information will be statically
> defined.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/virt/svm/sev.c | 193 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 174 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index dd256e76e443..043b2582e10e 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -18,6 +18,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/iommu.h>
>  #include <linux/amd-iommu.h>
> +#include <linux/nospec.h>
>  
>  #include <asm/sev.h>
>  #include <asm/processor.h>
> @@ -74,12 +75,42 @@ struct rmpentry {
>   */
>  #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
>  
> +/*
> + * For a non-segmented RMP table, use the maximum physical addressing as the
> + * segment size in order to always arrive at index 0 in the table.
> + */
> +#define RMPTABLE_NON_SEGMENTED_SHIFT	52
> +
> +struct rmp_segment_desc {
> +	struct rmpentry *rmp_entry;
> +	u64 max_index;
> +	u64 size;
> +};
> +
> +/*
> + * Segmented RMP Table support.
> + *   - The segment size is used for two purposes:
> + *     - Identify the amount of memory covered by an RMP segment
> + *     - Quickly locate an RMP segment table entry for a physical address
> + *
> + *   - The RMP segment table contains pointers to an RMP table that covers
> + *     a specific portion of memory. There can be up to 512 8-byte entries,
> + *     one pages worth.
> + */
> +static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
> +static unsigned int rst_max_index __ro_after_init = 512;
> +
> +static u64 rmp_segment_size_max;
> +static unsigned int rmp_segment_coverage_shift;
> +static u64 rmp_segment_coverage_size;
> +static u64 rmp_segment_coverage_mask;
> +#define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
> +#define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_coverage_mask)))
> +
>  /* Mask to apply to a PFN to get the first PFN of a 2MB page */
>  #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
>  
>  static u64 probed_rmp_base, probed_rmp_size;
> -static struct rmpentry *rmptable __ro_after_init;
> -static u64 rmptable_max_pfn __ro_after_init;
>  
>  static LIST_HEAD(snp_leaked_pages_list);
>  static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
> @@ -185,6 +216,92 @@ static bool __init init_rmptable_bookkeeping(void)
>  	return true;
>  }
>  
> +static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
> +{
> +	struct rmp_segment_desc *desc;
> +	void *rmp_segment;
> +	u64 rst_index;
> +
> +	/* Validate the RMP segment size */
> +	if (segment_size > rmp_segment_size_max) {
> +		pr_err("Invalid RMP size (%#llx) for configured segment size (%#llx)\n",
> +		       segment_size, rmp_segment_size_max);
> +		return false;
> +	}
> +
> +	/* Validate the RMP segment table index */
> +	rst_index = RST_ENTRY_INDEX(pa);
> +	if (rst_index >= rst_max_index) {
> +		pr_err("Invalid RMP segment base address (%#llx) for configured segment size (%#llx)\n",
> +		       pa, rmp_segment_coverage_size);
> +		return false;
> +	}
> +	rst_index = array_index_nospec(rst_index, rst_max_index);
> +
> +	if (rmp_segment_table[rst_index]) {
> +		pr_err("RMP segment descriptor already exists at index %llu\n", rst_index);
> +		return false;
> +	}
> +
> +	/* Map the RMP entries */
> +	rmp_segment = memremap(segment_pa, segment_size, MEMREMAP_WB);
> +	if (!rmp_segment) {
> +		pr_err("Failed to map RMP segment addr 0x%llx size 0x%llx\n",
> +		       segment_pa, segment_size);
> +		return false;
> +	}
> +
> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> +	if (!desc) {
> +		memunmap(rmp_segment);
> +		return false;
> +	}
> +
> +	desc->rmp_entry = rmp_segment;
> +	desc->max_index = segment_size / sizeof(*desc->rmp_entry);
> +	desc->size = segment_size;
> +
> +	/* Add the segment descriptor to the table */
> +	rmp_segment_table[rst_index] = desc;
> +
> +	return true;
> +}
> +
> +static void __init free_rmp_segment_table(void)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < rst_max_index; i++) {
> +		struct rmp_segment_desc *desc;
> +
> +		desc = rmp_segment_table[i];
> +		if (!desc)
> +			continue;
> +
> +		memunmap(desc->rmp_entry);
> +
> +		kfree(desc);
> +	}
> +
> +	free_page((unsigned long)rmp_segment_table);
> +
> +	rmp_segment_table = NULL;
> +}
> +
> +static bool __init alloc_rmp_segment_table(void)
> +{
> +	struct page *page;
> +
> +	/* Allocate the table used to index into the RMP segments */
> +	page = alloc_page(__GFP_ZERO);
> +	if (!page)
> +		return false;
> +
> +	rmp_segment_table = page_address(page);
> +
> +	return true;
> +}
> +
>  /*
>   * Do the necessary preparations which are verified by the firmware as
>   * described in the SNP_INIT_EX firmware command description in the SNP
> @@ -192,8 +309,8 @@ static bool __init init_rmptable_bookkeeping(void)
>   */
>  static int __init snp_rmptable_init(void)
>  {
> -	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, rmp_end, val;
> -	void *rmptable_start;
> +	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
> +	unsigned int i;
>  
>  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>  		return 0;
> @@ -222,17 +339,18 @@ static int __init snp_rmptable_init(void)
>  		goto nosnp;
>  	}
>  
> +	if (!alloc_rmp_segment_table())
> +		goto nosnp;
> +
>  	/* Map only the RMP entries */
> -	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
> -				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
> -				  MEMREMAP_WB);
> -	if (!rmptable_start) {
> -		pr_err("Failed to map RMP table\n");
> +	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
> +	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> +
> +	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
> +		free_rmp_segment_table();
>  		goto nosnp;
>  	}
>  
> -	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> -
>  	/*
>  	 * Check if SEV-SNP is already enabled, this can happen in case of
>  	 * kexec boot.
> @@ -243,12 +361,20 @@ static int __init snp_rmptable_init(void)
>  
>  	/* Zero out the RMP bookkeeping area */
>  	if (!init_rmptable_bookkeeping()) {
> -		memunmap(rmptable_start);
> +		free_rmp_segment_table();
>  		goto nosnp;
>  	}
>  
>  	/* Zero out the RMP entries */
> -	memset(rmptable_start, 0, rmptable_size);
> +	for (i = 0; i < rst_max_index; i++) {
> +		struct rmp_segment_desc *desc;
> +
> +		desc = rmp_segment_table[i];
> +		if (!desc)
> +			continue;
> +
> +		memset(desc->rmp_entry, 0, desc->size);
> +	}
>  
>  	/* Flush the caches to ensure that data is written before SNP is enabled. */
>  	wbinvd_on_all_cpus();
> @@ -259,9 +385,6 @@ static int __init snp_rmptable_init(void)
>  	on_each_cpu(snp_enable, NULL, 1);
>  
>  skip_enable:
> -	rmptable = (struct rmpentry *)rmptable_start;
> -	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry) - 1;
> -
>  	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
>  
>  	/*
> @@ -282,6 +405,17 @@ static int __init snp_rmptable_init(void)
>   */
>  device_initcall(snp_rmptable_init);
>  
> +static void set_rmp_segment_info(unsigned int segment_shift)
> +{
> +	rmp_segment_coverage_shift = segment_shift;
> +	rmp_segment_coverage_size  = 1ULL << rmp_segment_coverage_shift;
> +	rmp_segment_coverage_mask  = rmp_segment_coverage_size - 1;
> +
> +	/* Calculate the maximum size an RMP can be (16 bytes/page mapped) */
> +	rmp_segment_size_max = PHYS_PFN(rmp_segment_coverage_size);
> +	rmp_segment_size_max <<= 4;
> +}
> +
>  #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
>  
>  bool snp_probe_rmptable_info(void)
> @@ -303,6 +437,11 @@ bool snp_probe_rmptable_info(void)
>  
>  	rmp_sz = rmp_end - rmp_base + 1;
>  
> +	/* Treat the contiguous RMP table as a single segment */
> +	rst_max_index = 1;
> +
> +	set_rmp_segment_info(RMPTABLE_NON_SEGMENTED_SHIFT);
> +
>  	probed_rmp_base = rmp_base;
>  	probed_rmp_size = rmp_sz;
>  
> @@ -314,13 +453,29 @@ bool snp_probe_rmptable_info(void)
>  
>  static struct rmpentry *__get_rmpentry(u64 pfn)
>  {
> -	if (!rmptable)
> +	struct rmp_segment_desc *desc;
> +	u64 paddr, rst_index, segment_index;
> +
> +	if (!rmp_segment_table)
>  		return ERR_PTR(-ENODEV);
>  
> -	if (unlikely(pfn > rmptable_max_pfn))
> +	paddr = pfn << PAGE_SHIFT;
> +
> +	rst_index = RST_ENTRY_INDEX(paddr);
> +	if (unlikely(rst_index >= rst_max_index))
> +		return ERR_PTR(-EFAULT);
> +	rst_index = array_index_nospec(rst_index, rst_max_index);
> +
> +	desc = rmp_segment_table[rst_index];
> +	if (unlikely(!desc))
>  		return ERR_PTR(-EFAULT);
>  
> -	return rmptable + pfn;
> +	segment_index = RMP_ENTRY_INDEX(paddr);
> +	if (unlikely(segment_index >= desc->max_index))
> +		return ERR_PTR(-EFAULT);
> +	segment_index = array_index_nospec(segment_index, desc->max_index);
> +
> +	return desc->rmp_entry + segment_index;
>  }
>  

Ah ok, __get_rmpentry() is finalized here in this patch and rmptable & rmptable_max_pfn 
are removed as part of this patch, so probably my comments on patch #1 are not relevant. 

This is somewhat confusing, maybe some comments can be added in patch #1 to explain that
__get_rmpentry() will be finalized in this patch ?

My confusion results from the following : 

Patch #1: 
__get_rmpentry() 
--- refers to rmptable.

Patch #5:
rmptable initialized here.

Patch #6:
rmptable not required and removed in this patch.
do final cleanup for __get_rmpentry(). 

Thanks,
Ashish

>  static int get_rmpentry(u64 pfn, struct rmpread *entry)

