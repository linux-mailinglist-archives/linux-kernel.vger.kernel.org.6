Return-Path: <linux-kernel+bounces-371743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA89A3FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169CC1F228EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F99476;
	Fri, 18 Oct 2024 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="asK72DRr"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E542ABD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258323; cv=fail; b=XuHfYxtWxdt1S7t1hzAvSFQozQ3a1F3AiB3PkD9yE13c7PMHCSJ4YXlcgBba8bOjNugZxXGi+Fk9UZIQZupELX7iEsolwTPjLTP5/OXl+nzqKp4tlsZTC6TyUh4aFHulS5LKrA6SGslK6ohdnD96LjfowcOHdzXBt2b41PfQBUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258323; c=relaxed/simple;
	bh=73p2g6KII3gjtLUiK5B4q1pl5JVHZpLGClooT6CckY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9EVAmr7yhOkPcTUnjuVg8L+5iPAETNSQww2p8wQr5mIorzYY8Ck/xrS7XPF7cXkxzEyr6MdMaMH6I82ZT1SxuAiOZiCyTO5Bw/uUVo/wCz2DXWxgIqiU0FpPu6XGVF8IPp/gbfCfKj0D7K7kZ7ne5vr4bfnY9uLRbIAPsJQlWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=asK72DRr; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIwrladgOAdbcvxOqCetkLBQy0wEvuq81CLNeeNvfk+EUw0l4GlScJs1WfZEeO7PPO9vdgekj6yJogcRGXdpLf5wVj83BUSYSxW++8GM0TI0XyyBWDU3wi8lyRxnacCsmoOeCrG995+3Mcoy46aGve1sgm/5CylsYZNHIDgsDBjpiLzpKCrBjG5ctPkuli1hJf4zf9+uRphoqUY4GBOksRCfaLhtCuBb7bMQzuAHwC8NL9JJvmRB/B9V9Y0yTUq0BoUIyqYwKKg4lFURnIakIJztC24LyvVJ64kVN5VsgJl2ytCiR9fVxWVF0yOKMM9HSwoYFPND3CxFpwM6jnAS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II1Xp2oSb82T/RFoWnZw9Laylaig+xDdWth2zXtywY4=;
 b=CxQEL1KGh5fL6SFM3MbarTSqr6cqB2au2lYnyvRiTlELcyx5ffTKAxqu4j4zyhym5Iyg3TDIZ7ZCEz07NelHHyJ1UMGe9C4Wd4M+kRFet4f5MIK4q1rhLAgcfKKB6f28SJCOelNqgtASZ3gd8ATDja6JLsLDVhCL0s5GIQAAQvTGQftAhCbyoZO2n4ySXFhmtqAYeX9t1iXNcreAJyGs62OZXt7QYlTZMuDMZ3lyblMIUaF0WMEw3cNoKLCmcdWXdq4kDC+w6kaq+ZWXyPKXrFDd0epmEOEoGs8rkGwFVIZUk2XDrIPUKMoghVTB3Qs7KMAtbgUr/o7OmrF7mgfiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II1Xp2oSb82T/RFoWnZw9Laylaig+xDdWth2zXtywY4=;
 b=asK72DRr42FhVZBD0TCxiZGK2d5OZKxetl4iynJZZN8lMecJowMGmtgkasN44/V5vE+zF/h0YiIfjL+mGsWi4VqCjm1Ifb8bLd5qOLOFi9yekoBK3OhXuR/y0zQRb+TrLwj4jxrt4av6CoNupAscz8DszT5Ou2UWXkJsdvQ3L/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.23; Fri, 18 Oct 2024 13:31:58 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 13:31:58 +0000
Message-ID: <516d8bcd-44d2-4fb3-b78f-d603bf474c3f@amd.com>
Date: Fri, 18 Oct 2024 19:01:48 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 8/8] x86/sev/docs: Document the SNP Reverse Map Table (RMP)
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <de767f29c86b201fa0f778e2cb786f971c155f6e.1727709735.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <de767f29c86b201fa0f778e2cb786f971c155f6e.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::23) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 2296c74b-052f-4ca4-0818-08dcef793d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjVLYjZYUkoyQzBrSTJvVFpkOGFrVVRBQWdGRWMxdExTQVQwZE9sTkhPd0R1?=
 =?utf-8?B?VFdLOVpuc3phU2w5VUVSMTNCQ251MTMrdlBEUWpOUTdFbHE0a2d1SytWc2dx?=
 =?utf-8?B?dFBnR0sxSElsSmhxZVBqMnBKTjlXWjJ6YXRPS3RUbHg1OGNjS3R4Zy9qVUpv?=
 =?utf-8?B?YXQybVlXNUJ0YnJMRyt4YUV1TGdGMmhvY0lvVzNkYUlBL3Vva0JPcyttc1RC?=
 =?utf-8?B?STl2MjVKeE11dDRRM1pGZTRwcnc2ZzdtTnpGcWU4cHVJOGg5TGdjUkFKZGxU?=
 =?utf-8?B?QUZwMSt2UGFzd0NUT2FDSTdFQml5RVNrZXg0VGxHYmtNRUxDMWNsMCs1SVhJ?=
 =?utf-8?B?WW5HNUtScGtUWU4vQXlZY0lHYXA5TmZiK0h3OUFUTUJ0ZzhYMFhBOEhlRW5J?=
 =?utf-8?B?NGtURldLZXJVVW5WdjRhKzVZWGZJcVlEZDROZWFoN2F3cTBySEJndy91N1pR?=
 =?utf-8?B?R0hVdGc2QnlUd1lYM3pDNzRBWUJudXNxVmNqdGhNQzF1c21URkM2YzlFZjkr?=
 =?utf-8?B?aFI0cjdHaStvOHpkVXIvZUxTYWw3cWw0ZWJ6bVZMdVFodXZ5OXdSQWwvNXBW?=
 =?utf-8?B?ODVHNS90ZzRlZlpzWjg2SG1iUVYxUHplOWQzdjA1U2RjY052dlhlVFUrQ1Vm?=
 =?utf-8?B?cEV3dzdKM2xETWY0bmpEK3JHRnVLNlZTRG5xZWlkaEhrVk84Nk1DZmZuMUtS?=
 =?utf-8?B?MmlwSWJhMEg4bjVzbklHOFdKSEZFelo2c2xLNCtGcURCY0IzNGFYUkR5SDc3?=
 =?utf-8?B?V2ZKQlJNVWJ4bFlpeFJwK3o4R252ZzlEU21ycEdKVDltVmZISGxsbks5VHZw?=
 =?utf-8?B?QmxkMjdhN2JOaUFNOE1LM1dnOFVWandsR2dUa1RnSFhrRHoxd2laMDJhdlBD?=
 =?utf-8?B?SHp6TUVHRmo3ZVhWU0VQTVJoTE0zN0hWc0xWd05aSnFiR1FCdERGbkxuRUtl?=
 =?utf-8?B?QUFiSC9tS0RVaHdHbTQ4a0JINDN6WWxwS3hCRzAvQ1NMOFNFZ0ZTRHpPNTFx?=
 =?utf-8?B?dnJiN0ZuMXJJTkd3ZkJtNFJPWVE2a3lWeStXMHBYaXorckd5OXEzZVBuTVNy?=
 =?utf-8?B?TW5kMHhFc0dJZGI3a0NWRFQ1ZGEyM2ZKc29yUFYvUTdsSmdnTmhrRDM3ZnlN?=
 =?utf-8?B?RnhtbE01aDVzVmVtZ0VSY00xWURNcHgxemJQYmhpendlYUZWV0pqRVN2SndB?=
 =?utf-8?B?ZFJMK01hM2xWbE9ZZHZWclFxajg0ZFlESzFYZ1BXeENlMVQyeWZqeVBYM2Jj?=
 =?utf-8?B?Y0xvTTM3OEE5ZHh0U3hXOHpaRktPK0tVa1RBK0NtdkZqUEsvN3hTRmJkQldn?=
 =?utf-8?B?bjhHSUlXMkRpbmozZmJGaHZCTXB5bEY1RUtCQWJSbG9yQWlGblpkbGptTFVO?=
 =?utf-8?B?b0h2akVvV2NidXEwZGllb1NWWWtEREpMUU42Y2NsaEFzV0ZvZzlvcW5kcFdy?=
 =?utf-8?B?YUM3bFV4WUUyMGFHOGdVd1FGSGRwUFhpLzJXclJnWVdtWTZ2ZVhZUW1nYW5H?=
 =?utf-8?B?M2tiWC8zVmlZakZ3QjRnbFQxSGxFMW9hM3dPU0xTSG40QkJkbEY5MHdpSld3?=
 =?utf-8?B?QkxlVmIvRUJFUDBOUnA4dnY2M3dQVkNidGsyRE13bE5JMlpKaHNScDJVUVNa?=
 =?utf-8?B?TnQzZUlVWnI5UHBTKzR6enlMRUEzZ0pFRnNIeHBqQVBFakNReDFnU05na0FK?=
 =?utf-8?B?YmJQVFRtYmoyQzNGaEFuOHhkRTRHZmRWNklHdnFCQVRQcGxkeGd0TjRIQmJs?=
 =?utf-8?Q?Gt7+2ATeanss/wqgZg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGU0VjhHdjdOUWM1c0lGcjVFWmdhUkppK01UWDlUSHpyejVxOW91NEFMOXNp?=
 =?utf-8?B?TWFZNHFoNmR1SEpVQzA4L2pPc0p2WmV0VndMVnJsS095QlRieEJ2TzNGZHBW?=
 =?utf-8?B?bXZRN0lsWGdIRzBMYXYrYTNMN1dmbE1uNnF2SW5JVzF4ZTJDd3JzWTl1eXRC?=
 =?utf-8?B?VFpBclc5MjJIZjJhMDl4elNiVjFmam9qZ0ZQT3Z2YkJDdGo0cVZyZ2tIZXRj?=
 =?utf-8?B?VkFRSjd5YlNXdHg1dkxiSnBPZGNMNlo3R1dCM1hMNTdQcVlZV252bVYwVmpR?=
 =?utf-8?B?b2pReHhqN2NKc1FpT3BMR1RJMG1ZMXRGRzhzV2tXM1c2M1VrRkFTbTdoWGh3?=
 =?utf-8?B?ZUZFVTJrT1NJaHY1T3pQQThxakZJeHpRYkNsMHZxQVhVajQ3QW4zYThtK2J3?=
 =?utf-8?B?WkdTVlNmeWFTMklUdE5CdmdPakZ0Q1lxdmhBYlpOUktqL2pERHU5ckNCUGJ5?=
 =?utf-8?B?MU9WMG41VW93S0hwTHc5U2ZZRzB1ci8vb05rZkdrZ0tIM1p3SU5waWFHYlFh?=
 =?utf-8?B?STVmSlV1T0J1RWExNUxWd284OWNUVTFKMXQ4eEkrNWhibmxTNEdCWXJvSEIv?=
 =?utf-8?B?Mkd2WXNpanJPZkdNLzlLNFF2eHh4T0JNQnR0cmg3VngraWdSaFlZRkl4MWln?=
 =?utf-8?B?b0k5YU82QnN0N0Y2UDhHYW90U2w1ZzYzcDFzQlFVbEkvemsrWFBtWm9KLy9P?=
 =?utf-8?B?UmQ4dURNQ1NRVUdhcWk3a294M29SdWxvSzlZVW5iUTZ6azBPcHExK3JqK1Z4?=
 =?utf-8?B?Q3BWSnhCTFNacHBsWDk5WGxhUDVLcVJGNTBTMURkL1daQ251Z2I5UHRlTm0v?=
 =?utf-8?B?TlZvbUNqOTI0TjVRQURubVROdnJ0NUUyV0wrTmUzMXZFemtnVW83VnF6M2U1?=
 =?utf-8?B?a3VUeXhqb1dscFdvelR3ZWUzWDRRVDh0KzBId3ppeW9OaFdYSVF4Y0Y5WWpI?=
 =?utf-8?B?UEhDNEdCRE55eW1PSmwvZGFOTW5VaWRHS0ZhWnFXK1RPZzFFTmlINk5XOEE0?=
 =?utf-8?B?S3hPSVhjeEtWZGxibFFjMFhTbEFUMHUyaWl3K0t2MHJYd2NJckdBdWtJTWxO?=
 =?utf-8?B?NEhTZVlUOXJGMXlrSnVuUjUrNzVjRUc5cU9IWm9Za2VCVlhLdmNiN1RNNTdC?=
 =?utf-8?B?VkZBQS90MWVJS1pJcE8zNjA3dTJhaWptOHVtUHlVcGdZeWV4NVQ3a0g4NXBP?=
 =?utf-8?B?c1F2SjZIMldBbGVGSmhFeDNHTG9mK1g3YXVCd2lpUC9lUTA3RW5pbldDbHhh?=
 =?utf-8?B?NDl3SDBhUjVDTEg0V2hXS2hRMUR0bTBpam94WFBWU0dJVVh5TlhDNHNMVlFh?=
 =?utf-8?B?TDR3ekV0OS9QQlI2ajlQWlcrY2ExUEM1Wkt0aFh3alhuR2lTaEs3eG5DQjBo?=
 =?utf-8?B?T2dBOWxaME1iSm9QY1VlUnR1RTI1VEdFN0VSRnYreEJKRnVkSzZQOVoyeUtG?=
 =?utf-8?B?ZGFGOFl5WUt1MjR5S0JpelQ4T1hCV01HKzdiY3FkeE5PYVZsUERsVzc4WUcr?=
 =?utf-8?B?eVV4b3FXak9obXBIWWkrdW1HejFQeTlvWFZNa3ZkMnVlZW0zWXdxUkJmc3M5?=
 =?utf-8?B?eWxqWWN5U29tSWlqeDZZQm9UMmNhaE5BdjJaTTZ2bnlaWXNiV2NpQ1FlUm0v?=
 =?utf-8?B?ekJwR0FLbVdwSlFPbGN6WFY3MjlHK2w4OHZUZW9HMmYwM2l1WUoxS0xuVStZ?=
 =?utf-8?B?RmhvQlc4MGUxeFFBd0VjZ05EbTVDMlRMK3lvd2xOdjE2cFhMdTdJcDRLd0c4?=
 =?utf-8?B?c2Fvb1pmK3FHV2ZqdnBzMHl4T1hrbnl3YitGVytvSzBXdUlkRFBFS3E2Wm5J?=
 =?utf-8?B?U1B4cDJrUStoZktORmJtV2RlNEVHMEhGUjNIajRvY09YRUFkSWI4T3diUC9N?=
 =?utf-8?B?azhXY0dOS2tSd28zVkRuNmttSWI2cFlmRUhZWWhpbUd2dndEVnZxTkt2TWty?=
 =?utf-8?B?eFU1NlBEbHh4THJZK0RmdFora2FnWFVXWHJKU3Z6Tk5yckFuVkVraGQwOXF0?=
 =?utf-8?B?RCtBWG9PT3luOENxd2JPVHBYR1FBMzAzb2NzM1gxU2YvL3dBOEZmSFR2OThu?=
 =?utf-8?B?WVV2NnFPZEJLenZZcy9MWG5jRzBGT0xZelJ4U1VjNG5tTVVpTjRBMmk5NGh0?=
 =?utf-8?Q?crmcxWxLOgGyVkRpeeBFxhdXv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2296c74b-052f-4ca4-0818-08dcef793d32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:31:58.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUslDvVRZztz9468rPastin3shoO0EuBC+VqXk27tFQjnIntwlWHJ3a8jdlhiTanA+ynna5AwKw9gypzqdf7jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952



On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> Update the AMD memory encryption documentation to include information on
> the Reverse Map Table (RMP) and the two table formats.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

