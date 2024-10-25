Return-Path: <linux-kernel+bounces-381367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93749AFE24
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F552879C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCC31D5141;
	Fri, 25 Oct 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="myL1n4T3"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E81D4610
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848365; cv=fail; b=hXWUXBzPz8tgdH8l7ndnSz5ra5dR7KNGSjyCX6zunx2tZ5+7ZV30Ofq8jX5SCeWAhUqHPmOqmeJnVXyxeiPNT/47lLofFvLU3tBJWV4uhrKDKIp4fdug4hsXfgDSUQxNBDNP//Jpev5pS3QlGC5Aa1ATaH9q+ArM6MZnrrmPj6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848365; c=relaxed/simple;
	bh=xW3Cnxm0AVInVOfknqdvMYT9VF8hon43ao77Vp/d3Z8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVBhHXlbvxRjwN+W4kE3r7QoI6lfZSIrlyvYna6veWPX4O0pMHbX/jVZWs2SYx3JJduYW1/TByyzuuyutyRVHCr3smaspoJDsEEMfmFl4qVTdPvuM7kSVtspQ2THPHCCdJW3Qpovh8uOsHr3R07CRRgpk+3pKjpxzc/QfhwDsBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=myL1n4T3; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xr1rac08Fr2c3XtqgmgR5GB09JkLZge5Y0CIaU72TbKge9W5fJtQcnj4K2/GcdZnR53KjaK6dALsF4RM50RWig5Pit3DWadnBJxQLxkNmgUGHyr1oMzVaBGEr7xfOxs9YKDC6uqUaUTvvwoxrr8eK1fP3vtcziomv4PwiyYKcLnUA5iYRakat4ReKY+jnJCf8xVzMDRc1XkgRR7bQ9+UXIunbeseu/+sfbKg3FPP3cG6q3O4Nr5VpjAYP58bU1xyZ8MUsz7Qr5cjVRdQ3EZFGLwV31unoheFH/zEn760q5AYz2sIc7/l2L1s6+mcAU4jKSKCni6DmuAPhGPVetX/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veC3KObaMFSrjCnRxnJ5ou+bLKqx4NVwdJTj8a7NHlM=;
 b=gLXwpV25Hoq8C86qXusKC+ckHb9HSVMWQX5ojRHwozcmeO1fI5r8u701U6nVCGBBlVijZ6eiukmBbfx0v1eMmBkxFw/9GI9hkPkhAUfa90JKTnhERk+IjDR1d99yUW3+U+MUI7jYY7ZXpzhMfp9+OeSXkQUC+YWHyz99AGVUgC/X0pmJYOFXGfUdChIPtcrwers9sI9OHfuAPEkXQO7F6VWNLIvaGesXZgqZRP+iVVkiQOcGAKBReCQA8aeqD6WPPO6gAWN7XWIMW8EIee/F18b1CvmXwWhKYqp+mf7t15o1Z4PjTWIRSU/CV93pzGGVbeb0f2VjTs62Ls82FvRzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veC3KObaMFSrjCnRxnJ5ou+bLKqx4NVwdJTj8a7NHlM=;
 b=myL1n4T3f1ezqwLLlDjzLit7Jmq2XCaeaKnPPABseYJKBfChGcLt/bgCk5qEfN/28gqfMM35ipvQnAi9WC0GXAoAZtnD8Uo8o79HlV1PuMtaNKPOxX19QPRPnNAuhREA7pQT17QDegP74XL5dEwZA9BQuopJJ2mOD8Df06oxpoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 09:26:00 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:26:00 +0000
Message-ID: <28d98245-e6fc-4f04-876e-366a353ee6ce@amd.com>
Date: Fri, 25 Oct 2024 04:25:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] x86/sev: Add support for the RMPREAD instruction
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <cacc1a3e63a790450e342d08457b52b2d471cca2.1729708922.git.thomas.lendacky@amd.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <cacc1a3e63a790450e342d08457b52b2d471cca2.1729708922.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cd0499-2f09-477e-4863-08dcf4d709c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk9IUG9ac09PSDNmamtNSkg1SVg1K2thRmN0d1NhVFQ1WWcrV1hHeVpCcm91?=
 =?utf-8?B?NElyb0lVQVo1ekpEQy9wdjNTQk5TTFRaNU9ieTMyekRIZ0ZpcU45a2xhYzJR?=
 =?utf-8?B?ek9CV1RUYlVIZFBySGtNdjhzQVZrNXF5ODl3L3Q0MVVPWnZqdnZwWTlxMzlD?=
 =?utf-8?B?Y0U3Wml5YUxqanBvT2JjcVYzTUxzVUdXV2wwb2MvTW0wbmoyZnY3a2xsR3Ix?=
 =?utf-8?B?ZkFvaHpkZGVDdFhGOUpCYnA3bEF6V253NU16S1puNHZ1dWdmRDJVbmZhSnZF?=
 =?utf-8?B?V2dQc2NNUHg2NGF4eWV5UUFzS3dySTYzcEErSkY1dnJPbUhJTlVac1Rua20w?=
 =?utf-8?B?KzE4MklnRHFRd2hkRjN4UUNVK3BUNFdibUxZOGI3VitPQm1taW5DRlpSZDZL?=
 =?utf-8?B?dHJIaE1VdjZnZjdXc2NWUTRNZTBEY1dPNlpwK2tmb0hYVWF5Mlh0dzR0dFRN?=
 =?utf-8?B?YjFiNGtBZENpazFYc0NUVDFETXZHdXNaWHdZQnh4TUFDUmJNY09iaWVpSjYr?=
 =?utf-8?B?ZHFadXFhZDF1UGcwOHZhQzlRNGJUcXA2M2MvWWc0eUNRNml6R3ZqZ0dEblNW?=
 =?utf-8?B?SlByOXpXTHV1cmhiVDlUeUtWT1ZFUG8xd1lpRWtjWmRQZXdMMFdSckp3QzYx?=
 =?utf-8?B?WVdJcEFKTlhhR0lhVzB6VDBpVFQ4bkU2R2d5M0ZSOHNpck5zaXl1WDRQK3dZ?=
 =?utf-8?B?anNBNU41dlVYUU9ZUWJ3STAveVljcUVpTVpHUXE2YXpSVEEvSHRsRTlJYWo3?=
 =?utf-8?B?eS9KanJzWk9KaEhQUmdPZVlOdjZsOXBUZGZtTy9uN2lGZ3JMZUpaV1BEeGRz?=
 =?utf-8?B?UmYvcVBsWUJ3UENKVURwR1ViMHBvK1NabjE2VDYxYmw3bkpYZEFZY1VVZ09J?=
 =?utf-8?B?ekVLRmR0d2JtbHBUZE94bExBSVFBbHRJS3hqMC9FQXBTNjlyek1hbkVNbGRE?=
 =?utf-8?B?Y2dUY01tUGNoSnpvcGV3YUwrcEJHeU1kVUdqd2k5S3ZoTWxybCtGMUdRNkFR?=
 =?utf-8?B?Qi9XK0Q5V01OTkNPclpud0plUStwM1UwTmw2U28ySk1qQXNGTnp2c21YdkZF?=
 =?utf-8?B?N0YwSnVnM2J3L29URXYxUTZFblBsT0FvZTdDOHk4UkdwWjhyWno3NVlXU1Vi?=
 =?utf-8?B?bkpqNEd2QnBwVWlCeEZTL1ZUU0F3cldEbDhkU2NmUmRmWm9Tb083eGRwWUJC?=
 =?utf-8?B?YXVjQkludFBLVjY2V2xPY1hRVnlYK1kxNHJBQkVpWkV5bm9tbityTXRHWlRS?=
 =?utf-8?B?N0VQWVovU0VkWlg2dThyQnJOcERuOUx4bmwyVGFjVHlkMnVreVROZTAvbUcz?=
 =?utf-8?B?dDdCa0czdkh5YVROMEdpa29uNHBLVk52QnFOSXRHcnhRdW1ZenlEelNGY21O?=
 =?utf-8?B?SDJsdk1HSWxuWDQvaWU3eEpvWTFNeFkyMzRHWEVSWWpVbGh1b0Q3WVdGcVJP?=
 =?utf-8?B?NUxaU1VwT2Mxa0lPQTVuOEQrUHBtR1ZFcHh1RjRRamt5S2drTlNvemZ6Y2Nq?=
 =?utf-8?B?S0laSEJHeTlwd2huUGUyWVFBNXo1cEloamFDUy9ESDRWNlg0TFBHWGZYSG5q?=
 =?utf-8?B?VmlsNzVaQUNCYTUrNWNGeFUzcmtNNmxCK1JBYmNBOHlyY0lDR2dQOUNrckJs?=
 =?utf-8?B?ai9tODN0T1UycTEvS0IycnFwUi9MK290OFBBNnBELzVzaWRiTVY2NTZYQldF?=
 =?utf-8?B?QVZlRWMvR3RqNjZDUE1MbXNJN1EvLzkrRnFZUHZ3TUtFRWZRMDM1Q2xQSytU?=
 =?utf-8?Q?up7FC+ekDeiSDEe3uCUS/Tc4pDVQGuwnJhbiDXH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVhnTlY0TXFEVm0vT3cycHpOVkVCZUZheWE1YWxJaXc2S1dMcDdqZmN4K2J5?=
 =?utf-8?B?Z0ZiVjdVRnNJVWM3VUJmV0E0Sjdnall3ZnlkcktrcGJON0ZlWXg1SjZNeXpD?=
 =?utf-8?B?b0c3NzBXVWdaeWdIaGRGR20vZHdQWEprNXJNZC95QzJrdUhPQUNpaGdMTGhS?=
 =?utf-8?B?V0RrcnBtV3NMeE0rckIxK0Yxa1NEeDBhd0hrNGhQN2w3NFlxcEVoT29MNGc5?=
 =?utf-8?B?OEdjMHJqbGwxVlMwUHBpWENMRXNYeUtIemlkRFZueHNNeGlrQXBnUzJQMk1O?=
 =?utf-8?B?SXZUM05iVk1NckxqYjhpZjdVTTQ2MDljVENmbXFpenhVUXBCd2phbDlvY2RK?=
 =?utf-8?B?SFU1V2ErT0NHUXAyNURlU3pOUEJ4UDd5eFduSDRLV1o0bWFCWUJ2b0RiZXRj?=
 =?utf-8?B?OGxlTmxvYTc3V0MzM0kwYnZjQW1WK3pUanJGN2NjN0NPeWJiWEV2cHBGR2U3?=
 =?utf-8?B?bDFNemJ5RFV2VW5ZWW82UkNPMlVNSlU0T2tNRis5dVVLMEtTbU9sSEVzU29U?=
 =?utf-8?B?MldQUTBFMG1ORmdhRkVYYURua0FGeTNmWmlWYzJ6bDUweXlqQmMwQ1d3TGkv?=
 =?utf-8?B?bGdJMVFwOXpSUndRZXpDZVZQZGVWRUZYUFh0bmFESjF5eVR0WG9TWE0zRmRW?=
 =?utf-8?B?TW9KZ05NUXlmdnZmWW1aQ29zZ1B0bGgvazAwMDMyZ3pTM0h5NjFodUFJK3FU?=
 =?utf-8?B?L3lGUG4vUlMrYXBsbDJOSHdZL0YzV0J1UzhGODZ1Z0QwUEhmeEwwazlpVHdV?=
 =?utf-8?B?aFRQRFJXdG9TaUc2bEt6dTNpTVVQdXJtb0JQakdvNDFYTW9NejQxYmJPY2V5?=
 =?utf-8?B?RkVPKzZaL043Rk9aMGRhUWlNY0pUVlB5TzRhRXVMbkc1K0FZYll3Z0ZHd0ZP?=
 =?utf-8?B?d0lid1JLWExRY21KeXVzelJDV3VsTm9rS2dDdjBIVnJuOHN1THlCZ3NkUVFB?=
 =?utf-8?B?Tms3MnpiUmZNMTR6ZldNRTlTK1J5aVpvVHU3RUVvUWVWdWxMVmd4cmhCdnho?=
 =?utf-8?B?SWtVRjdvM1lyYTZyRFFOSEd3QU9wcGNZUnB3MnVGQ09TSXZlaVVLZ0t0Qzdz?=
 =?utf-8?B?VVBuTVF1WEEvcG1kSjFEbmJlQmhLb2c5MVJML0lXR2FOUnFPNzFVMGsvaGVs?=
 =?utf-8?B?NjB6Mzc4cmpvRFNVVmphZkYvcytBb280Rm5FVVdEUEo1SVI5aXY2Z3dsK3VY?=
 =?utf-8?B?eS9JQ1ZEZFEycytrK0tuai9kTGsyMDdZS0U2am1PTi8veHRJVVo4Vk1qb3pQ?=
 =?utf-8?B?ZCtJVkU4bXJKbCtCRFQxN3NJcENnZzAyK1BoeDArckFRaHlOZkFQbmJVbGM4?=
 =?utf-8?B?KzRMMzhFeUsvYlRqNkRPVlRBYmhqdkk1U0ZrNDlCTDFmbjBmSWtHcEZTSVNa?=
 =?utf-8?B?ZmhWdlJGS1NxVXl1SktCOWlONENkcGkyZ0h5MnJNUDRlcWs1Y3NQWmplL3hP?=
 =?utf-8?B?RmtlNWNPTmFacUZsSHdIRExCZk5pK3dIc2J4S1ordmJKdkphaTAzemNWT2NE?=
 =?utf-8?B?RUVQMFZjRjlNbnZmbnVNYVgvQks3aHdpR1JEbjBZWnE3b2VzRUJnMGVBZmdr?=
 =?utf-8?B?VkdxakN5SWs5UnRLdTBzKzRoeElqZFY5R2FQMHc1azV4RVFGYXdCNlc5KzQ0?=
 =?utf-8?B?c25BTEl3c09ndWo3czZQVDdZR2pFUzVScDJDMUcrRDd1MFdJWjRvT0RaUll2?=
 =?utf-8?B?SEtXaVgzc20yT3U3QnFFemNpVzM1RTBLSndHQjRDS3pDWnFmS1VMeEhuZ1F0?=
 =?utf-8?B?c3NHdGF0eWNYVW5jd2tNVFl6MXBYeTFQOFNEd3JTS1JPVUE3TVc4aThOUWNa?=
 =?utf-8?B?VFZENW1FUkRmbXRVK1o4bjl3Y01zNk12bVhKWTc5WmJxc2t3NjhTZFIvdnk5?=
 =?utf-8?B?eXBReGpnWS9FUlkxWW5Hd3FTK3E4Ynl2QlV3akczYUFsMkd0MHZtTHRqUVEy?=
 =?utf-8?B?SmNOTXRTZ1NHcklvY2FjVTdvcGlDcm4zTzlqa2ZWNDJzdWlHai9PY1djRlEy?=
 =?utf-8?B?emU4QXBoakQ2bVRhcnNBVFBFZVlqU0Y4eVREeVZXZHY3SFE1T1FBa0U4RVlL?=
 =?utf-8?B?OHdwMjh5b0g5TTVOS0l1dE9Rd2Q3Q0lrTFRObDdKV1U0RjVQMkJIUkk5R0V2?=
 =?utf-8?Q?IbObtMEA82rKyi5qMIPDnZeY9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cd0499-2f09-477e-4863-08dcf4d709c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:26:00.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HybUggCczQFpTmIECbw56FiCRR0vF1ieuFNViE94E78DJe28s1xg0s53S1Kog2tEUmTR6yc5LhfNNatHDhpC9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273


On 10/23/2024 1:41 PM, Tom Lendacky wrote:
> The RMPREAD instruction returns an architecture defined format of an
> RMP table entry. This is the preferred method for examining RMP entries.
> 
> The instruction is advertised in CPUID 0x8000001f_EAX[21]. Use this
> instruction when available.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/virt/svm/sev.c            | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 913fd3a7bac6..89c1308cdf54 10064
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -448,6 +448,7 @@
>  #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
>  #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
>  #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
> +#define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
>  #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
>  
>  /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 4d095affdb4d..e197610b4eed 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -301,6 +301,17 @@ static int get_rmpentry(u64 pfn, struct rmpread *entry)
>  {
>  	struct rmpentry *e;
>  
> +	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
> +		int ret;
> +
> +		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
> +			     : "=a" (ret)
> +			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
> +			     : "memory", "cc");
> +
> +		return ret;
> +	}
> +
>  	e = __get_rmpentry(pfn);
>  	if (IS_ERR(e))
>  		return PTR_ERR(e);

Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>

Thanks,
Ashish

