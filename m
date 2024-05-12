Return-Path: <linux-kernel+bounces-176965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912FD8C37DD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12041C20B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FCA4EB3F;
	Sun, 12 May 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vBJYo8zJ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539F5024E;
	Sun, 12 May 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536717; cv=fail; b=kH41zZx2NJclhCf3f2+GUbkjHjgI+FBxJRDR5nPh93qnwI3k4cwBLWY5C5rCPs+7xvNYlFeo13UKSfYbes6z61JUqggGaCDPUec2TEi1s61GbR55gt9HPV8m4ebua6jk9R562NVmWHeT1pkCPywMDmWZ49ydDEHpHIwkTBLgQgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536717; c=relaxed/simple;
	bh=EqcB120A93YR6HDgtmj+Sr9ZZjUCBuX/G5NODxlmvc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q9swkSxp6MvR1ZJ6/6Ldb5jXzgIssS1rZGUtJqZ17+fDX3HZC0lgfbS/Opi6IWxDpQcCk0RzarLubcy2HGZFpk8nCaQky/DBmKUFUBgJZzSd0iM46AuCIyNwSkBVOwsGXKAwaGAIRGG0ygHYWt8mxAP/FxRRTI/X9xT4Pv+Fq18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vBJYo8zJ; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/nYW39b4ZQMkkvMrnR5Qu7fwRYu91ZNs71N9UxjXbDAaxCBTwPhJS8Ep7WVjoKXZYFw5rCIWoavq95qnuPFl4eHsEtjIVZ3djbnoyhPVGpqwn64YS5U1/2T+wHnmWNN1N5xoBHemOQR8gurbazUihPzcvMU5Pm8aoKvSnmYcHCuoskoTitucVWxmWDlNhF95HFOCQUJrJnGFwf/pq0GPrvQMMJX9aQ/GOGlfeZRb78VDqJNMZsme/J5CxJqYoCr+vil4BHWFysEpLpj54wZWVM0xdgQS4W3Cz5pqLXoC0FkpNndj9Ylw/Q8Mo6bNMxscn1WLSVanMuvrOHuzGAMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA8q9iDjmbznYdjKA0gMruZ/kYSnzOJq7jm2IJhty4U=;
 b=WGzUw1U5MrmocrQ4RnACvN/8rIhcNay93DOuIJrDBVCSwtZIr8grDOXKo2S041Duq2il8kKkWLdAFFgWYEQgK9vXvEAjCCAty+GpgUFCctNIJ6Nuf9IP8DEW3pkbjZrMm0zhq1kMqxCqw/FX5P2/jBuGOxsOVslISWmDXk0bCyQsJA7B3rFT3RHM1ig8dVEcp257beI4yLTOJeGilJog1lOz/tsABowTlLqWoTXRiefSW5wD+vgoPQCNFKA7jqSEKrkI3siUMmIwklF+tnmJ6OleFqvYxVmxTNsx1/bRYbCiupHUPc/W3MrCRiVZrUQMXTz+/nJEWBUZqrl0z9d6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA8q9iDjmbznYdjKA0gMruZ/kYSnzOJq7jm2IJhty4U=;
 b=vBJYo8zJeV9BnGuLuIIlG49cU3nmxK7p/Qx5+FJawtmc80UJAqKGBWofbFCliefdN2Tj+zKPl4EhmW0upuCiLmW/QUz18UWi1LcUnfcbW/KTDDpSCxN+QUukZL1lyEpnY8gYv8lqcPY/vzm4NUXYDZssMSuwvBFrAM6L9iF2XPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 17:58:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 17:58:31 +0000
Message-ID: <d38043cd-7fc2-4255-a795-23e64ee4a8c2@amd.com>
Date: Sun, 12 May 2024 12:58:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: Armin Wolf <W_Armin@gmx.de>, "Shen, Yijun" <Yijun.Shen@dell.com>,
 Lyndon Sanche <lsanche@lyndeno.ca>
Cc: "pali@kernel.org" <pali@kernel.org>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "lkp@intel.com" <lkp@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dell Client Kernel <Dell.Client.Kernel@dell.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
 <63894ef1-c482-4646-8351-4d6cfc6c528f@amd.com>
 <BY5PR19MB392299916A85FF06387DC9C19AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
 <a1306ffa-c0ea-4ce6-8692-76bf37850e8a@amd.com>
 <BY5PR19MB3922A117E489A55C3C7FAC789AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
 <4d8de625-9018-4926-9519-37f5a90a96e5@gmx.de>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <4d8de625-9018-4926-9519-37f5a90a96e5@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 34493899-cb82-48d7-5a4d-08dc72ad2272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmRyL2pacEhmYW8zZUNEN0JRNVNoTy9uN01vUkZBck5TTk1sQmhxdkdYZjg2?=
 =?utf-8?B?ZlcxQzA2VGFwcWxwOXYrRit2RVE1dXNlTGszUHdFNVhkYlJxbGpMdWlYL1o0?=
 =?utf-8?B?c3FFeit2RnhXMUlaeWFoL2JDcmhZQ3g3aDJVZGhGQkZ6aTV5Y3hpSk1KL2Zm?=
 =?utf-8?B?SnJFTVF4OXg3MkJKb2U4dG5ndUNNcU1CWnVKN0V2ZUJPUnNiNEtYZlVaSkRN?=
 =?utf-8?B?Y0l0ZENxM3FUWm9oTFpUREVSZ2dCZjNhL3hmYzFFRDZrR2tYS2JjV0pZb0lj?=
 =?utf-8?B?bGRPQ3I3TTRoaFJueWhZQ3RIeGpZclg5NjZyNXpncFR1eVFpd2wzNDBVMXFj?=
 =?utf-8?B?bTdTQ2JjMVMybUZRcHp1ODdGODNUSk83elN5cm9mWkpOYUlBbVBtaGV3T1Zs?=
 =?utf-8?B?STA1YzBpS1N1ZzJaci9zK0JEcm1GRm9NUnpJcE8rRDNjMFRiRld2TC9LWlBx?=
 =?utf-8?B?UWNzTVpYTlZsTnppYzYrN3p5T2xUT2VBemdaOHJ2dXJ0ci9CazZZUHlWaXZj?=
 =?utf-8?B?c1gvYVFlUTkvbzE4OXpOU1kyYWV4Wkh2czVGNXFPVEk1R3VvNVdPUS9Dek0z?=
 =?utf-8?B?YVdMYjdxSGplTFR1MmRHZm1xbHpFVzBFU0FqZkRGc2x0Y3BJVS91TkFWQ29u?=
 =?utf-8?B?TDd1Uitlc3JvQ0hocGxYbUtUSmhuZUpwY0ExR3RsSzdoS1RSbGQ4YWNXTVQr?=
 =?utf-8?B?NTF4TUY1QjM5NjdYTTVQemFYZkpjcDM3TFdCSzZzMk5vUmQ3L0lqN09rbG5E?=
 =?utf-8?B?cjR3TDZSeWNiN0g4MVU5aTNRZlF4NlJ1NFV5OWhTd2RBL3NPbmkycEhZcGEv?=
 =?utf-8?B?RE9OOVUwNURrdE5vNmdrNFhWOVVuR0FhYmx3eERSTkRVYVB6Y0NhMERzejRB?=
 =?utf-8?B?bjJveE83Y2hmWXBZbklqS0Y3Y0pJN1I0TUZmUkxGVXZVbkFTK3c1MjZueVVJ?=
 =?utf-8?B?R1E5K2MzVFI5R2h2OTBzNWdjcEJPeTlDb0FVS0ZBVGpheXBVZDYvNEhJNURj?=
 =?utf-8?B?RGU3S0dKQ1l3WG8zNVVuTU94VzdOZVJ2OUFqQ0hpYUx3eHAxemRmWE53Z2NP?=
 =?utf-8?B?SjhxVU1KN0tkKzVDUGl0UWJaSmdSMDNjNnlXM1RrS1lEUHhpUTA1b0lWK0M3?=
 =?utf-8?B?Q21TWDBLUCtLdHZ4dzN0eEYzSUJIa3ZGcUZlN3pxYms1amlrK0RpY3ZEVzdL?=
 =?utf-8?B?Wk1COE96VGQzYTBrakc3UkwzaERURStLUE13V2g1bk1VeHNzY1h2czhIU0Ji?=
 =?utf-8?B?VWJ1ZExmWkp4Tm5JVHlyZHZuYlZlcFYyaDBXRmxyVzRVM3lyYldSMnNnUC82?=
 =?utf-8?B?eDFSNFovd1BxSjY3bDdxNVdidnVkQ3VMUlljNS9Sb1BqUlovZVRnenlvU1RH?=
 =?utf-8?B?UW9jNnV2RXkzS1grdDY0T1BuWDZTOFBzVGhzVzJCWUZQaDUveVN0S2l6djEx?=
 =?utf-8?B?eUxOMm1OY09iaHZZQVJEZnVBeGR3Q0ZYblorUW11WldKd1FGRGFVOVY1cUxP?=
 =?utf-8?B?WkZuQzFqTjVieWRXN1hYLytvUlpuYnBwZzJ0YkVLNVlrTkpvT0w1cXdkL0Ji?=
 =?utf-8?B?M04rcGNSSnY0R2Z6K2RWU0lPbmVVT1huWkx3WVZqcHM5d1JKcUxPVXpIbkxC?=
 =?utf-8?Q?Zhk2KUdidf4up/KO9nxJXiyJsmkGTaZ2HWuSZLjgCweg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1BCSzQyTDBPZFoxZDYzNlRhejJXSmg4Mm9qVDUwTTBuOFpidEFQQWRQb29m?=
 =?utf-8?B?b2w0Y0U0VktBZnN1QVJSMTQ1bHFhTnBvQTZva3JZKzVOYlIzcW96N096bUN1?=
 =?utf-8?B?d2YybWtkeVlxK1pjNHNqUHpTOUU0RHI0bVNpMzZucG1MelpHc3hCUHhpSmpy?=
 =?utf-8?B?bHc4cVBJZXR1Y3IwWHpHc2VIUWJhMyttZ1hOZUFXTmxVRXRWaFltY292N0ZY?=
 =?utf-8?B?NmZWSXVCdlZvSndTZVhWREppcmd1NVpGZGh4c2hzOHpMQk9DdkM3RFJCSzRJ?=
 =?utf-8?B?amRtMEFMRGFsVllVSVI1M1dHcGEvbHhaRHl6Ty9RdEFya2xrWFhPSzZEQWtn?=
 =?utf-8?B?cTBUSUdXNjY0blhlbFN3TFNnd201VVZpTEZJL2FPVDJpa2hrZTYvNDd0Mm0x?=
 =?utf-8?B?aTZnR0l1TUd3WlBuWGhaVFIwK25vRlIyNDNqUFhuK05LR0Y3MHJQSklBY3Zy?=
 =?utf-8?B?K3NlamJJeFlFSEZJWkRBUXFTbTNwR3RpWHA5SGtVWm9ZZzFIalYvVy9Pbnpk?=
 =?utf-8?B?WU9WN1dCNHlUdmNHcFdqeGhvcjRLQ0V6YTFLeGgvY3llZU5QZERHR20yM0lL?=
 =?utf-8?B?eVRlQURpRUpwMzJpUFFGeXhYL2Z6S0wveVl1ZENvKzZmQmZzd2ZGMTc1ek90?=
 =?utf-8?B?MnJuRTNWVWtIQlZnemhlS25OdDZnaTArOW50YXFFNHc0Q3pzUWxOcDJkcU1I?=
 =?utf-8?B?TUtzMllST1kxdVJnam9HVFhaYWwxbU8yQ1lhZTloaHpEc0JadXpoWjR1T084?=
 =?utf-8?B?bFJXZVgzMFN2REtkRHU2eGRvMnBBMHJleUpSMXF5QU9IQ29nbTZmZ0ZPQkM3?=
 =?utf-8?B?SzdNbmhLeWEyRlAwZDhHd2VGb0EvWmd6QTU4OEVCYmhwTTJwRXpSOURWY3RR?=
 =?utf-8?B?YTVwbU1lM1RzdW85VThPQ2hld3p4QzRJbHdjWGtqVnFhNXFJQU5kUm5uN0xU?=
 =?utf-8?B?MDlvZ2JGQ1lyUkhCT3ZrVGk4MTlNTmJiZEtSNDRReGFXa3dXZ1YvRVVoRUQ0?=
 =?utf-8?B?NkhNY2NzK1NVL1pXRHQrRTh3eXZlWWRIbGRLMHdzM1o0V2tpWXZvRE1WY1Zn?=
 =?utf-8?B?dHFUNkxtMDVvb0w4dzE4bWFsQ3U5eEw0R1cvSlpVRDZCcElnTkZ2bG9jUWlT?=
 =?utf-8?B?K3ptWWpiWWRSamZ0d094Y1F4RzNSalhUendsYUhDUWhpejUrM3M4SGxnV0Fm?=
 =?utf-8?B?ZE91Y1E0NUFFbmY5dFRXcXNVU3V2NU9ac3VuR1B4VDkzMkdtd0ZFdTQ4S0Zu?=
 =?utf-8?B?MHNtWlpiN09qdElvVE9jNW5jZGFrZmhpS1FyclI3RzhkMU52LzNGanVza3Rm?=
 =?utf-8?B?dDhiMTFSLzdScVZuQ2RVT1ozUEJ2enc4cytnaWt6NHpLQm40TUM1T3lvZ2FT?=
 =?utf-8?B?ODg2UTIwYlFoV09qaUdLTmpybXlOdE15RTJLYWtudldOMXlXZ0V2WDRveWhW?=
 =?utf-8?B?RTJmOWI1cGZTMXAvd0pVOEt2Tmp4b1YwZTB4NGEzTFhQNlptbEp2QnF0YlJ6?=
 =?utf-8?B?MnI0QXNnOWptWnZmNTFsNjVyRStqK1JlRHB6K2xzbHUyUElzbkdqZTVNNGpF?=
 =?utf-8?B?V2srU1NpL25xelNQK3BVd01sYVNjSldMUXVwVUdRb1VrNmV2eW5QeXE0Wkk0?=
 =?utf-8?B?V1U5c1hmRDJiVXJkMzN6UW5BYUlyS2NROHBTdzBndTdPdHRMMDdycDU5b0hZ?=
 =?utf-8?B?dVlrb3FvdCt0VDBOWkY2alpiaHNpeVloY1Bxc0svUThsSVJQNkhXbEFzWVJl?=
 =?utf-8?B?OHN5YWszV2MvQzV5ZWluNXhYZmdHVTd2S1FJNnZNUWVrZ2NvU1J1QXpqaDdT?=
 =?utf-8?B?T1pYTnhhazMveWdhNGRuVmc0MERiTmtvbXJmTjJEY1ZuMjh2RnBYdTZVamVG?=
 =?utf-8?B?Y256RTFpNzFCSmU3VWw1UFFDU3ZJb2Y5blpoNHJENjBNcjVRd0dvdVFVamla?=
 =?utf-8?B?UTR4Z25JRnJHQW05Vmd0ZlJjN3NVTU5pNG5sOWJsaVZHd05Pcjd6OUY5Y3dM?=
 =?utf-8?B?Zi9VUGFQS3Y4TFdDa20va2ViSm5Na2FlK3JkalBVeURZM2tUR0g5NngzRExQ?=
 =?utf-8?B?SkttUEZXRzRHb1czUnVwdUlaL29CSExZbHEzNGpURFhFcFpmaWg5TGhlRFQr?=
 =?utf-8?Q?jgCseg2gWizkUYDlaeIKZFRo9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34493899-cb82-48d7-5a4d-08dc72ad2272
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 17:58:31.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3guPlT4WYk7jxdJQChQccaOosqNUufHClAJIP91OV5s8iT+6Pq1bxFVdDBN5jSCEAU1bSMhQvdmCPqdz7wX7QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715



On 5/12/2024 12:53 PM, Armin Wolf wrote:
> Am 11.05.24 um 17:56 schrieb Shen, Yijun:
> 
>> Internal Use - Confidential
>>> -----Original Message-----
>>> From: Limonciello, Mario <mario.limonciello@amd.com>
>>> Sent: Saturday, May 11, 2024 11:13 PM
>>> To: Shen, Yijun <Yijun_Shen@Dell.com>; Lyndon Sanche
>>> <lsanche@lyndeno.ca>
>>> Cc: pali@kernel.org; W_Armin@gmx.de;
>>> srinivas.pandruvada@linux.intel.com; ilpo.jarvinen@linux.intel.com;
>>> lkp@intel.com; Hans de Goede <hdegoede@redhat.com>; Matthew Garrett
>>> <mjg59@srcf.ucam.org>; Jonathan Corbet <corbet@lwn.net>; Heiner Kallweit
>>> <hkallweit1@gmail.com>; Vegard Nossum <vegard.nossum@oracle.com>;
>>> platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; 
>>> Dell Client
>>> Kernel <Dell.Client.Kernel@dell.com>
>>> Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement 
>>> platform_profile
>>>
>>>
>>> [EXTERNAL EMAIL]
>>>
>>>
>>>
>>> On 5/11/2024 10:05 AM, Shen, Yijun wrote:
>>>> Internal Use - Confidential
>>>>> -----Original Message-----
>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>> Sent: Wednesday, May 8, 2024 11:53 PM
>>>>> To: Shen, Yijun <Yijun_Shen@Dell.com>; Lyndon Sanche
>>>>> <lsanche@lyndeno.ca>
>>>>> Cc: pali@kernel.org; W_Armin@gmx.de;
>>>>> srinivas.pandruvada@linux.intel.com; ilpo.jarvinen@linux.intel.com;
>>>>> lkp@intel.com; Hans de Goede <hdegoede@redhat.com>; Matthew
>>> Garrett
>>>>> <mjg59@srcf.ucam.org>; Jonathan Corbet <corbet@lwn.net>; Heiner
>>>>> Kallweit <hkallweit1@gmail.com>; Vegard Nossum
>>>>> <vegard.nossum@oracle.com>; platform-driver-x86@vger.kernel.org;
>>>>> linux-kernel@vger.kernel.org; Dell Client Kernel
>>>>> <Dell.Client.Kernel@dell.com>
>>>>> Subject: Re: RE: [PATCH v5] platform/x86: dell-laptop: Implement
>>>>> platform_profile
>>>>>
>>>>>
>>>>> [EXTERNAL EMAIL]
>>>>>
>>>>> On 5/8/2024 09:24, Shen, Yijun wrote:
>>>>>> Hi Lyndon,
>>>>>>
>>>>>>     Thanks for working on this patch.
>>>>>>
>>>>>>     Dell side has an initial testing with this patch on some laptops,
>>>>>> it looks
>>>>> good. While changing the platform profile:
>>>>>> 1. The corresponding USTT option in BIOS will be changed.
>>>>>> 2. thermald will not be impacted. The related PSVT and ITMT will be
>>> loaded.
>>>>>>     Some Dell DTs does not have the USTT, Dell'll have a check if
>>>>>> nothing is
>>>>> broken.
>>>>>
>>>>> Hi Alex!
>>>>>
>>>>> Have you had a check both on both your AMD laptops and workstations
>>>>> too, or just the Intel ones?  I think it would be good to make sure
>>>>> it's getting the correct experience in both cases.
>>>>>
>>>> Hi Mario,
>>>>
>>>>    I've a check for this, for both laptop and workstation, the 
>>>> dell_laptop
>>> module will not be loaded. So, AMD platform will not be impacted by this
>>> patch series.
>>>> Follow is one example output with workstation.
>>>>    #lsmod | grep dell
>>>>      dell_wmi               28672  0
>>>>      dell_smbios            32768  1 dell_wmi
>>>>      dcdbas                 20480  1 dell_smbios
>>>>      dell_wmi_descriptor    20480  2 dell_wmi,dell_smbios
>>>>      sparse_keymap          12288  1 dell_wmi
>>>>      ledtrig_audio          12288  3 
>>>> snd_ctl_led,snd_hda_codec_generic,dell_wmi
>>>>      video                  73728  2 dell_wmi,nvidia_modeset
>>>>      wmi                    40960  5
>>> video,dell_wmi,wmi_bmof,dell_smbios,dell_wmi_descriptor
>>> Ah; right that makes sense.  In that case, is dell-laptop even the 
>>> right place for
>>> this patch series?  I would think the same policies for the platform 
>>> profile
>>> should be able to apply to desktop/workstation.
>>>
>>> The v6 of this series would block smbios-thermal-ctl from working on a
>>> workstation too.
>>>
>>>>>>      Additional, with this patch, follow behavior is found:
>>>>>>     1. For example, the platform profile is quiet.
>>>>>>     2. Reboot the system and change the USTT to performance.
>>>>>>     3. Boot to desktop, the platform profile is "quiet", the USTT
>>>>>> will be
>>>>> changed back to "quiet".
>>>>>>     This looks like not a proper user experience. The platform
>>>>>> profile should
>>>>> honor the BIOS setting, aka, the platform profile should be switched
>>>>> to "performance".
>>>>> I agree, this sounds like the initial profile needs to be read from
>>>>> the BIOS settings too.
>>>>>
>>>>> Furthermore I wanted to ask is there also a WMI setting that
>>>>> corresponds to this that dell-wmi-sysman offers?
>>>>    Yes, Mario, you're right. This thermal setting could also be 
>>>> toggled by dell-
>>> wmi-sysman.
>>>> But, for the Dell consumer AMD laptops, like Alienware, the BIOS is 
>>>> another
>>> variant which is different with the workstation one.
>>>> With this variant BIOS, there is no USTT and also no dell_wmi/dell-wmi-
>>> sysman.
>>>>> I'm wondering if both should be probed in case the SMBIOS one goes
>>> away one day.
>>>>    Yep, I think this is a good suggestion.
>>>>
>>> Great! Although something I wonder is if the policy when changed with 
>>> dell-
>>> wmi-sysman is immediate or requires a reboot.  A lot of the settings 
>>> in there
>>> aren't effective until after a reboot.
>>>
>>> If this is one of them then it might not be a good idea to make it 
>>> work for
>>> both.
>> Hi Mario,
>>
>>   Just have a check, the check steps are:
>> 1. stop the thermald
>> 2. run the stress test
>> 3. Toggle the thermal setting between UltraPerformance and Quiet via 
>> dell-wmi-sysman
>> 4. Check the CPU FAN speed
>>   The system reboot is not needed, the CPU fan speed changes immediately.
>>   A screen recorder here: 
>> https://dell.box.com/s/p2bhd2b6cv8z5buk9eao3bosgrrp1lf9
>>
>> Thanks
>>
> Hi,
> 
> i believe it should be the responsibility of the manufacturer (in this 
> case Dell) that
> the thermal state remains consistent across both interfaces.
> 
> I think that the official Windows utility only checks the thermal state 
> reported by
> the USTT interface, so we should match this behavior.
> 
> Thanks,
> Armin Wolf
> 

Why?  Windows also does ACPI-WMI differently than Linux.  It's not as 
easy to check both from a Windows utility due to that.

