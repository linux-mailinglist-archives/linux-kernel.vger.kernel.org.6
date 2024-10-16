Return-Path: <linux-kernel+bounces-368236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9639A0D14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5321C24467
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D4D20CCEA;
	Wed, 16 Oct 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ney6hatI"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F01208D63
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089843; cv=fail; b=o+AopnXvGzGAAsjELrZAhg5yFlDPia5D+s9jh8/t527xtX4JNNODnDeJuJpoXoDSdB1h6k6hNP4Laex2A9MdY9UG3f12uCbAvRfNq17ThA8AcDMq5x81LkmUAwd+ch+gLnV2uV/mOF9SrXlcLG6wivlR1plVYKl2wCeWAUKj26Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089843; c=relaxed/simple;
	bh=h+ekcJtvcNh3uZfqGzgGQ3HDhG9wQugIsmLwxFi8SGQ=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=szV8tJyueExuNuThIzc8XZkLHp6CHyMSdR3oK9TfV+vE+hVvXqJN7pgYp9avZZupU13/KPgxAfmJrmpwH9bW4T2l3cWv2nxH7HazdqO/wZ4F3p4Kmp3jG5n+ZifCUSV2/zjlA7wURtmw9lNaACEVF8QuHhUcVdHIsrXSbmCBwlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ney6hatI; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6F1l8bTSMToO78zOJkoqORcSMVltfX9bVVg3coHYkVugzT7ddtLnjUy06DLEbRYFDDG1eHp3fsPDS56PjjoRVCbNOlF16g5QgCUSdxRjUcvVcq7lBP1MfrT++gpgXMpTaRQrelKMdMd5cuuUqXaOuhmPdKA1x1oyS5UBDV716XkKWtYrbyRNOAXr3qaJnsKsuDpqRWGJ+i+4FEJ+cR3kpE/ZuWJ/+0V/65s9mJZbkN7C0eNcmXwBquEq2U3+tq9Dp8mDZSU5gsDIxoVPyLW3HGzugzWBb9FF4xvY4fGx83avMaJIhNtPJPNdzAnMkuNRkbWyxSo7Q8tNkTrwh9etw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EeWWovLr1F+jfakxRfBk40Vb9/ODIIkAeAU3ly0c4U=;
 b=pbrOPjOzUQZDMV3COdKlq2/f8oxDafM2AO8TMJS5dF6J6RWBIotkxY0yoLda9W9DbFEVwNZM8YLhamsCFKpkxXz59HOtWbyirTP2AxsjZ477x61nuTfG89yGOfSOl0Ku+v5GbSEF8Da0zN94aEjX1H0XCjuikxj2DuGrDSG4ykjCqiFZSpilW6aWuz3Tgt0BYXjeQeiYS+nHrD0l2u6YDlSH/ocUhZ/FvQV0NQsbf85rFYJ2HcvT717NEuP6tBNve/cmZEn8ZW4Te4M7pgQkxJpo4+rWiaIttBk2T9Brx96VjR4H3pR72/oZKR8gIb1jOZhL1kdz9BDkA+tPDYvmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EeWWovLr1F+jfakxRfBk40Vb9/ODIIkAeAU3ly0c4U=;
 b=ney6hatI0rsY4Wo0vxjG6WqOBedBCTBw++8lfZZajpnmM73PTqnn+11EUhfhL7cunaVj7DMSPnitamLjuqMCr/7XVfGSvI0I4yqXRKUFCLUS3lbbbRLlfH5UfSyLlt4f5X0Ch+MXM0HniWYrP8w3pqCf28Z1vkdvYgYb3wQdwwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.25; Wed, 16 Oct 2024 14:43:58 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 14:43:58 +0000
Message-ID: <9fb4543c-c876-3f82-f1a9-306e4f35d8dc@amd.com>
Date: Wed, 16 Oct 2024 09:43:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Nikunj A. Dadhania" <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4d62cc503d1e3278c3830f24462e3956233760ac.1727709735.git.thomas.lendacky@amd.com>
 <85583be0-5e8a-82ce-a134-95fe9d85a2a7@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 1/8] x86/sev: Prepare for using the RMPREAD instruction
 to access the RMP
In-Reply-To: <85583be0-5e8a-82ce-a134-95fe9d85a2a7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:6e::18) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e8a9ee-da32-4247-8b70-08dcedf0f7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2lRVUNxK1F3THo2bkFnNmpwT05BdlN2WlQ0ejZQK0xIaXhvZnFId1FqOGlD?=
 =?utf-8?B?aloxWUUxN3AzeFhIdmg0KzFBYUNTWWNZNjZLcXRxS2oybVZPVml5UlI0cnly?=
 =?utf-8?B?YVdRR2I5S2hveHhiTDBkUXl2ZEF5VjU4anBkaVFFaElHcGRJUDQ3QWcrT3pt?=
 =?utf-8?B?VU01by9jWWFPMlVpTC9UN215OXlKRFEzZmp0V25weWk1RDFlSzY2ZjZSdlhN?=
 =?utf-8?B?T2YyeFpqWHMzeDF2SXJndlNRNkxMOElEY08xT1ViVlBzT1pDcG9aRXFwZVhK?=
 =?utf-8?B?czZzSFN0NjR2VVYxVVBYNDJhQXVWOTlFbm5xQ0NmWENrOC9hTE9qM2l1eWZk?=
 =?utf-8?B?WEhGSHd4dk94SWVjU2JHcHlEWlZnby81cFhqYU85Y3pORFdZK2VMMzBtaUt6?=
 =?utf-8?B?VGltemVsekJocXBHdzZEVUtINTlGN2ptNktaVUp6ajY0ak9sRXVPY0d4bkpp?=
 =?utf-8?B?NjgyTzFaYXdyWjQxdnBYa01ZRDZLRjJmWTA4Z0hEcTJJLzVVY1FYUUVaM0Ro?=
 =?utf-8?B?V252ZFlHRlJRaHpmU1lXWnVHQ3Y0dU1UM3ZHUFZ0Zjl5dWpQSngzemFIZzBh?=
 =?utf-8?B?MUtLZHhQNEZKVE02UmMrWW1JN0s0eWZPRk9NL21WenpGOEtkaW41aVp6WEFW?=
 =?utf-8?B?VFBpWlFBU3dWcjVzeFpxaWUwQ1QxanJGM3JGbzNNRm52cWY3Q2VnNHFVQXE4?=
 =?utf-8?B?ZU12cExmNHVsMnNCTlY1bkVDWlA0UEg2NVVic3lVaDJpN3pTWGFLdUFRSS9j?=
 =?utf-8?B?YUVXb3RVZXQ2KzFhejgvbThlR09ya1h2cWRheDJERUFkSjZxcExLU1pNNVh3?=
 =?utf-8?B?WWRCYUZ1MGVQU0tMU0ZQaDA1NExzRkxxcWdCMWZ4Vkl2M2YzSm1mTWRqZTVB?=
 =?utf-8?B?T3FxVmFsYjNlUFA0Z0c0c3BiejNzMmlIVzBiLzRZamFIWTRldC9Gb2h6dDZo?=
 =?utf-8?B?c2k0bHNVcm5zZ25RMzBPTHNXUjljcTJRSTJXaVRYOEpZT1FQcnZlZTh2VmJX?=
 =?utf-8?B?bnFuYmVUTHdsUFhFbnZHYmR6SGdDRGFzejZ2Ujc0OEJSeXJxM1pXMldhMzFi?=
 =?utf-8?B?RklXa1hHaWwySzk5VGZGN2xJY3V0bHhqSW84cTZYL0RTQlVPNWxrNkV6aFJr?=
 =?utf-8?B?VTVWeFhLQVZzNGpHTGI2eFcxdnN1OW55cEVJVmloNHI2SUdCaUlBM1prWE9q?=
 =?utf-8?B?UFB1VXR1amU5dFRVeTFDNGZJM0JiOFQrL1lJdk5lQkEyd1hzRWlBNmh4UXVn?=
 =?utf-8?B?RnBIaC9Ic1Y5eTgrZjB0T1JuVmRSNWlBYXB2S21FQ3BpUkZEVWhFVjZvOWVh?=
 =?utf-8?B?SnBzeTdVeXdOYUtJVG9rNEtCdDZuNGxqRjh5VENNWDR5bmM0b2Jpakwwa1pT?=
 =?utf-8?B?MEp3elFsMkFkZkNxWjFjdkxVSVgrZzdtVVNhV3pldlk0L2YwZHFSalFqaVlE?=
 =?utf-8?B?eVFuMVJsdDN3TTBMdnVOZU8xK2sxQnl5cXhwazlpMTZud05HcmVRMlJ3LzYz?=
 =?utf-8?B?bWQrcHJhMUFFcHl6NzhCVi9Yc2M2TEJ1c0Z2SU9nWVNUbGFWV1dTalhGZEFZ?=
 =?utf-8?B?RDRsRzl6bjBaRG84b1ZsRHBOL3YvbnZIUWhOR0s4MGU2M0tsV3MvTXJHMHgx?=
 =?utf-8?B?MTFsVjRlK3dUdGMwN2JmQk0vTE5sc1dEU21OZGRRTkhrNkVXY0RaNXJFWmFN?=
 =?utf-8?B?amhZNUovNWxDL2MvdDZUTW54T00xSE10WVhnV051d1Z4elNSMno3Qk93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVRoMDVyZzhpUHlrdlVWU2ZyaGNPQUpES3ArR3N6ZzNML0YzaVJBM29Iam8w?=
 =?utf-8?B?YktxOHpoS3UzaXVnOHhxRXNEeWN2VGgza2FZWXhQNnVVY0REYk1paFhDckph?=
 =?utf-8?B?QnFIRU9aNTVQekdiNlNLUGtMMGgzeGVLbGFRY2xWVndiYVFrZkhjMWlhVjlJ?=
 =?utf-8?B?anhPYURYS0dXeXhzeVZKOEtUSDBIVUhxUlhxaTdEZnl6dVdkUGJLWXRPeTZZ?=
 =?utf-8?B?S0dOTzVORlBSUU0xQkJYbWxMSHFTcTV5NndUQ2czLzFDVDUwQUlmSjdTL1Zk?=
 =?utf-8?B?K1ZaY3NHVERlSjZjVk91K2FnK0I5dTdlZXVEMktFZEQ2c0M5bWdLNmxxdTZr?=
 =?utf-8?B?enJiSFB1bWFJbDFLc1RwanB1TDkvVXBnendhbURVT3pZZUg3UWFZa1pJeWV5?=
 =?utf-8?B?UlJQQ3B4MUdlcmpmU1RyNkdWVmFJSUFFYUY3dm1rNFVBdk5qR2liKzVNcXp4?=
 =?utf-8?B?K2l2Yk43a01GZmpnaWlYU0JsVDhDUDFOeFgyVzNmSHhQb3BuYjMrQnM5Wmpx?=
 =?utf-8?B?TGVFVHVmYlFvSS9VMUZKYUd6VjQxTjNZTjIzaGQ2N1JKd3hhcXVQaGd2bjFR?=
 =?utf-8?B?dGNuaVV3N2RFQ01vUXJ0dW54UkNGK0t6RUtUT01KYlAxSHkzMkROQnpETklu?=
 =?utf-8?B?WjF3RUdqMFlsUy82c25wams0b2Z6Y2d5azI5bHZiTWhLUi9OTmVYOGgvd3dR?=
 =?utf-8?B?enB3M0NiN1lRVUx6QmVqSGQyRGpLK2hVS2JxTmhWV29TOG9pTlFxbXI0NE5z?=
 =?utf-8?B?TGJHaE0xMnZncGtjQk5rNzlWdC9LUzdzMVFvdGRURFFiUXJBblY5bGgwQ2Fw?=
 =?utf-8?B?U3RzT0RsWktrazlONDN1ai9UU0hobVdJK2pvLzcwUFZBWXJRalBUOG40ZUxh?=
 =?utf-8?B?a1RvbWZZNHVXS0dBSDllclh4eXVIM2pkUGxobmlFbEw5T0VUL3dJbWIwZ09r?=
 =?utf-8?B?aUx3MmVmc056V0RaaVZXUWtUMnFyd2RrR2RtU3J5VXA2T0ZtZmVaNFpaemwz?=
 =?utf-8?B?bktZb1FEMXZ3Z0EzVFhHVTZYNUZHZ0tqZ1UvZWEzdmxYekpBemJDUkJhQW1j?=
 =?utf-8?B?VjlnUnNEaEFTN00yMldBcWlMSUJrU2V6bmNMWmZ6MDI5VWZITTJGc1kyRFZL?=
 =?utf-8?B?NFZNNXgxVFNoUDAxbGdOZTFGZGVyTW1sSHRJbHhOZkJhbFZ1dElzaTd4VFFR?=
 =?utf-8?B?RkNDK1JVd1BsRlIrUTMvOGN1ZVozUldiaWZRdGNyZ3pxVyt2Qzd1Y1Q4Mlcv?=
 =?utf-8?B?Mi9lalRqRm40anl0Y0tvV3pKNmFqQ2hveng5czNQN1hFeldRT1hmeStIcHJF?=
 =?utf-8?B?L3pmaHczYUdaSUEzMHdYUUtzdG9RYk9kLzM1MmJOLzVjazJzMGo5MGZkcys0?=
 =?utf-8?B?U2cyOG03M3o1bytuWENmTUY5d1UxWTdVTHB4OEpSTktWMVVUSFBDdWxrcUxB?=
 =?utf-8?B?bGtZY1MrWnNLckg2aUJJeFozQWNzRGxFc1k3cEF0eVlLNk1YbytONE1CWVM0?=
 =?utf-8?B?Q01QcDdJcC9FeVM2amc3SWhaY01EMEo3N0NPcm5mcnhWMVl3OU52NHFzaFYw?=
 =?utf-8?B?VWNoclY5U1VzRmpqRmZMUTBRMmVhV2cxMXMxcjRPd0doTHJrNlpnOE5pUmpX?=
 =?utf-8?B?QXJha0JadERCZFpybXJkb2lScVZkUk1PTXlYS3ZCM3VNOWNHMFZnYnhBNUtl?=
 =?utf-8?B?VXhoMWprdWQzVjVCSUtSYVlCWHlCQ3ltaWY1cE1YQWxNUUdseFB5SzlTeHVp?=
 =?utf-8?B?WHpwUFBBakQxR3NQbkNGK1ZaM3puRWpTQzU2S0haSERXWkxyOE5lWEwxcVBq?=
 =?utf-8?B?MUtZeU5Uc2t4UG5YM2VSS0J5UnJBdnp0WDI5VW1XNGxIMGs5SHpmWWRPUzBx?=
 =?utf-8?B?a3F1WHpJT0d1TEdKM2JveWR6dmQ3RktRdmlkWWZ0ZUNaYUhnN2JCR0pHNHZK?=
 =?utf-8?B?OHR5ZlVWbGZ5V0ZOUHpEUFptdlpFaGZkeFlCeUJUSDJUbHBkbjVEcmdLUWZn?=
 =?utf-8?B?MkhQeXlWaHRqYUlGSGtYMHZaSXMvUjRWMndJUSt5Q293bCtDRlZmMFk0MGxG?=
 =?utf-8?B?TzFibGlCVFVVcVlQd29BN1VYbkpSMTlFaEE4Zlk0cW1oYlFoS25nb0RSR3M5?=
 =?utf-8?Q?Dr03piPENxCxiixVr/IxriuMg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e8a9ee-da32-4247-8b70-08dcedf0f7ce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:43:58.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj5qWx7ct4M26qWJxQu7YDg5ct0ifwhgvVZllglK+WyjWK8c5yctSQ54nkVfngb4BG8hWxeLiNMbpLlMtkaLCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343

On 10/16/24 03:52, Nikunj A. Dadhania wrote:
> On 9/30/2024 8:52 PM, Tom Lendacky wrote:
>> The RMPREAD instruction returns an architecture defined format of an
>> RMP entry. This is the preferred method for examining RMP entries.
>>
>> In preparation for using the RMPREAD instruction, convert the existing
>> code that directly accesses the RMP to map the raw RMP information into
>> the architecture defined format.
>>
>> RMPREAD output returns a status bit for the 2MB region status. If the
>> input page address is 2MB aligned and any other pages within the 2MB
>> region are assigned, then 2MB region status will be set to 1. Otherwise,
>> the 2MB region status will be set to 0. For systems that do not support
>> RMPREAD, calculating this value would require looping over all of the RMP
>> table entries within that range until one is found with the assigned bit
>> set. Since this bit is not defined in the current format, and so not used
>> today, do not incur the overhead associated with calculating it.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/virt/svm/sev.c | 141 ++++++++++++++++++++++++++++------------
>>  1 file changed, 98 insertions(+), 43 deletions(-)
>>

>> -static struct rmpentry *get_rmpentry(u64 pfn)
>> +static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)
> 
> pfn type has changed from u64 => unsigned long, is this intentional ?

No, not intentional, I'm just used to pfn's being unsigned longs... good
catch.

> 

>> +static int __snp_lookup_rmpentry(u64 pfn, struct rmpentry *entry, int *level)
>> +{
>> +	struct rmpentry large_entry;
>> +	int ret;
>> +
>> +	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>> +		return -ENODEV;
> 
> Can we rely on rmp_table check in __get_rmpentry() and remove the above check ?
> If rmp_table is NULL, CC_ATTR_HOST_SEV_SNP is always cleared.

I'm trying to not change the logic and just add the new struct usage.
Once RMPREAD is used there is no checking of the table address and if
SNP is not enabled in the SYSCFG MSR the instruction will #UD.

The table address check is just to ensure we don't accidentally call
this function without checking CC_ATTR_HOST_SEV_SNP in the future to
avoid a possible crash. If anything, I can remove the table address
check that I added here, but I would like to keep it just to be safe.

Thanks,
Tom

> 
>> +
>> +	ret = get_rmpentry(pfn, entry);
>> +	if (ret)
>> +		return ret;
> 
> Regards
> Nikunj

