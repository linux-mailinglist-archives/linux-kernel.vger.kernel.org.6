Return-Path: <linux-kernel+bounces-215202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E21908FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C004B266B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9519B3E6;
	Fri, 14 Jun 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GFfkQLxx"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9310F195F2D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381338; cv=fail; b=sygD9q2Y+sYxWAzVCGhNs6qRG7gfXyzcZXKmdPf4qmJ55tKUfyN8LecE5Msc6UR6W//klDcM+FrmjcdFEtqg+kMFdIgFgM7yJ14KGxL5L+d9zhBQiGknhg8eVbc8CEk6rhSS3uLQfv2zfQYxG+2uAzI5fSunbGp6SQ3ntIuVkdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381338; c=relaxed/simple;
	bh=MNMouv0Auf9fsOaoWO5hwwUkAJa0JmanDq99qQ3Du3s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ejBizA+B/ICs19Q3PnE/9c1JccBdzfG4K6KljRaU4wYgWjAigeTvwDsWIez341QjWXnOHCZ/EayUEqOGbCMfsQUfYLmL7RxgNX0e4ppb+uT5l2xNGxaewHaECNuR+dSlQvWCk6bWoPLlhn3m6lK3MwkK77ZJAc3F8gHzvSJ1nbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GFfkQLxx; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zkvl1cqhnyES5mJ4vV3UaYLsgl9LoicRfMElySEkIQfJp/ZuKmnD5oiVLbK4Joh8g5+JAPWKiTTAJEV5Wsq1coM/JNL+9Ke0RYFBdQANBrF+uSNWVB5bdtIbvAAlVKYXjNoEpLCro7TDYZm+iDO1T0xxnGHODlcs16MdxhAiVPDA3JpzE4uylBNsEkC2HA+lPXW6E06+JljEHBGG4wbhuBzZ22HORU+uM1Zn33wAPxZCqFI4TBQkaEuWgeuy7jGLG7E7PAB5ru4vpfOTpN7qt4hx/CKJq/9Eg5l17PysV7V76jtNyEh2LwsyIS7xrg/W5Mn0dAHapu2Oj/4lBVygqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZwkv++j/6MR+qBMBo6S5oJRGzKMdLbU0zWWY77bwKk=;
 b=LwmVNbYqNtioI6QNL2xUyl9MYxJGi9Rq45+1USIpe7YwsWCRFm6PeBfgqzoOK7OUuVj2QvBxzvWS9+Nga8T9zX6AgZgC70J2q1+LR/ThYhgyROQVk+xaOs5bk6rLJjclEg6qTB0DQ2ISuBQ7Gwl9VSTFVnU9TA29MFEDT15aSDv87lrZ/WBKCeY4TFJlyH/q+gHZJmZ+MH8F/VsTp2NTzOJLqmZeXV6UsOZK1rq6fD/j15jSsyFDrNpyOn8GFfqX1VoxHFVdFe+4hFvGSXYZxSGKUKGtcARnLjJDUt0wFb73FBg/G/hUFx/UXKfLX4OFmFdwHXIias90umTjeMZK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZwkv++j/6MR+qBMBo6S5oJRGzKMdLbU0zWWY77bwKk=;
 b=GFfkQLxxi10/fXZ4wMcj84t87mB2saXsTUjkU6qmaC83SYNf7wxvINEsvFQi0qx1S6kbRvgxOKwOWE1rEMh4kuAyNO5aJPzb4B8jlopXc56uNCj2RCGKa2NDloQfDpwDDcV+kYPQ4bcREMfM5Dk2LuY50kxPTUi0zYlIXDEp6vE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 16:08:53 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 16:08:53 +0000
Message-ID: <a5326e77-bb19-a92f-6beb-7d2c64866891@amd.com>
Date: Fri, 14 Jun 2024 11:08:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] virt/coco/sev-guest: Don't free decrypted memory
Content-Language: en-US
To: Li RongQing <lirongqing@baidu.com>, dan.j.williams@intel.com,
 bp@alien8.de, linux-kernel@vger.kernel.org
References: <20240614051036.41983-1-lirongqing@baidu.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240614051036.41983-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:806:125::31) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e385109-db04-4196-daa7-08dc8c8c493a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3REZ2FFdjRTNE5EYlJlS3NXekRBQ0MrV25wd0hBbko4NnQzRDJpTDNLRmN3?=
 =?utf-8?B?ZnR0bERWU3hPS0UyMnZ6WlJma2VJVFU0Z0ZqcldxWXc1Nk4zbUI4VlFsNVdH?=
 =?utf-8?B?VG5zMnlnNm9XN1FXN25uNy9lQWE4SlY2bjY4S3paMURieS9iN05BaU5VR3Fj?=
 =?utf-8?B?U3ZtNTcyWHp0RlRHTU0xZUVoMFFUWUlaVWZsLzUrQW44WlE0SDg4VEh5RDZ1?=
 =?utf-8?B?QVFmdi9pZEk1Nm9aNnoyWkk1Qm4wSjBld0NMQmpHc1hUZTFlRkt5YmhHNG1K?=
 =?utf-8?B?ZDl2azlRaVAyYlhjblZIK1VrMCtEVW5Fd1hHem5VWXY1NitSVnJGS0VJYzUz?=
 =?utf-8?B?aXFmZUlkSEhsUFRqZys2L2cxZTRkR3pVd2hrVGVDdkJsalBDalZLQWh4eElt?=
 =?utf-8?B?eTdRUWVXV24xNCt6dElxaVN2RW5GbGoxKytiY1JuZjlFRG4vT2l6SGU2Umlt?=
 =?utf-8?B?UExIMUlOQmR6RmtCVWNwY2lpYTF3R2JTbGxJUXlIYllRelR6TDhHQ2F1NUJC?=
 =?utf-8?B?TUlCYWZzYUlMeGM2ZmJpa2hzdzlSL0FDdC8rYWlpaHM5OWd4ZWZyMDR0MWZF?=
 =?utf-8?B?MjZGZmlaR0dOaTVJRStBcFJqdHUzazEwZndEVWRlMm43WHJqL2hWK1hhQmRZ?=
 =?utf-8?B?RnVkQlNuOWhaMFZhRzFraFdxZ2dmd0hHaGV4Q1JKZ01oWldjNGtzSWlwZDlr?=
 =?utf-8?B?QUNqdkhVSUgzaHR6UndVN0xhNndxYzI1MC9USzE0ZklVWHJjMDVKUjRlMFN0?=
 =?utf-8?B?TXY0RmdKNUhjV2IyeXUzU1Z2bmpicE4rQ01lNUUvS2NvRjlMeENZQjIxWVhG?=
 =?utf-8?B?WjZaKzFFVVBFNWZvekNGZVBZUmM2RUVsMGNWYnlQUkNDdGZLRXhLL0czVmRZ?=
 =?utf-8?B?eFMwTk90dmVrNkRqakRpdWNPcUZ1aEhsQzQ4OFdxK3h1eUVGV2h6dENCNDlo?=
 =?utf-8?B?L1lVVXRnZ3I3SXBvQXg0Y3d5Y2RuQ05ONFowWTFSTXdDVG8rblNKRFMvSlEr?=
 =?utf-8?B?WmRGRkMwVXo2MTlyTjRiTW1maUdLL3VMQnpCTHl3T3BsK2NpTzRtTWgvcmFS?=
 =?utf-8?B?RHFBMElTYVVBZm5QMjlmSCt1MFR6SmRUUGVmQjlZc0VmdnlrVCtGTWdiZUpt?=
 =?utf-8?B?TVA1Y0FPQzVqQjE4Tm1uL2xNeG0zZnFZUFFHNGM0WTRBam90ZDRrTG50eUUx?=
 =?utf-8?B?UjF5UnVLNSt4UGtLMlN1QlZEOUczVUk4RFBjRWtKS20rNGJ0cGJ6TG0vWlBp?=
 =?utf-8?B?dU91TXIrb0RwdS9wZFhHMjFYL3c5TTQxL2E3Q1YrbE52T1J4MUx4d3RkK2M4?=
 =?utf-8?B?R01hc2VmdW95cURXQTFGaXVGaGMxMzh2cktqRld3VVRDVTh0UThtMEQ1aU8w?=
 =?utf-8?B?MlhiV2c2T0FaUnNPMXVBWFcxVVhYOER5VDlvTHVKbDBGVzR3TXpKUEl2ZUdx?=
 =?utf-8?B?eXJ2Q3lDZUEyRzNIcUJMRjQ0QXNrajNDc2c1R3VLazJMYU9sbXZxNjA5NnRF?=
 =?utf-8?B?bGNWSWlMSWJLVkRkSGFRUGk0am5zOCtQTWF4Ym4vcldEUkFNR3pyekN2b0di?=
 =?utf-8?B?alpKVWErc1orMldnOVo1SFViUEd5QTdkMG50bFhSaG05TmZ2OFRpRCs0L0g0?=
 =?utf-8?B?OFRFN0c1ZjVCQkxwcTBDSHhMRG5iT0lGK3VNWTQzUVJXNDZYUEh3YmNOcERv?=
 =?utf-8?B?eGNZOC9YZWNpekN5cUpSeGJTR0J4UmRaKzlGQmRqM3dsczhLNlN4N1hIYys3?=
 =?utf-8?Q?pcaeCIYPPJE5iRkIKRtgO/GM9CuOqXt8MkSwZ8e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHVVUGRKdnZyZ2NKMTIzclJSemRBMWxRN2ZEekxudjRHcTJWeHZGVjg5UjlL?=
 =?utf-8?B?WENycVg1ZGxnSXBMMzlUTXRMejBId2tmTTJnM2Z4dGhnSjYzWWozOFJGK3JI?=
 =?utf-8?B?YlA0N0tpdGE2NTJJRTY1aHN5blVIaGlwM0NuS3JIVmI3S1U5YmI4RzBvQU1M?=
 =?utf-8?B?WWZsY044NWFXQy9WU0JTQVJGbFlPelBzSU9QSDZLN1BFT01RSzNyUTB3NmVD?=
 =?utf-8?B?Ui9vcTlDalRHS3B2eVhrbk9oVTFCYmJBWXdudTFuZ2E5YjFRQlNLbjVyOTRq?=
 =?utf-8?B?aFQvcG9VRDR6S1VEUXgvREk1YkFjQ3NPa2JiMjZsa2hVd2xNclA4MGRxR0lx?=
 =?utf-8?B?ejFxVUZqcy9YQWUvemQ5dTJ0VEQvMStncWsrWFFYRk91Tk5MK2d0aUY4RXJ2?=
 =?utf-8?B?MzIzV1NhM3g3QStmNWlmelNxNDVld0QxbUJrVXZZek1QRENBbjVkdi9pRFJz?=
 =?utf-8?B?RG1HcXA1UW95NjRMbEZzekJYdFdEcnlocmNqdDdVZ095UVp5Wjdxa2ord21s?=
 =?utf-8?B?QUQ0WGhQS0N0Q2J0dml3SXhEa05SbHkzRXdGZldCSzNwODl0TDV1dzhIOW5N?=
 =?utf-8?B?ZitYS0FRU2Urc1BnMVVUL01HSUhzVGdOL3l1QWZjMzNvVnlsdnorOTVoc0p0?=
 =?utf-8?B?SXZXdlNWRldrUE54MHlXRlJlbTBDQ1J3QkkyUlJUT2JqT1JXN0xSS21TVDh3?=
 =?utf-8?B?MXBLdUJmNEFETG5zMXNKSXJTZnhtZW41dllqbzB4QTRnZHRIb1ZkRFNPbE5C?=
 =?utf-8?B?U3RzcHFwVHJOSlhSWUI4dDhBN21BcU5TQ2laRko4ZlhIZ0htcGN6dmFKekRT?=
 =?utf-8?B?cWxwL1B0SUI5SUJjSE5iK0xpUFpHemdhU0Mzd25ETEliTFFPcXdMKzlLUzA4?=
 =?utf-8?B?WkppcXV6cmFYOU9PT0Z4V0RyOW9jdVNEMDBtUXZWR1JKendUZDBFVUFPeEY3?=
 =?utf-8?B?aUpRakZleFR6bzA1b3dWQXBqTUJoM1VWQlV4Rk9jdmtMcTFGZ0NOa3JJSHVi?=
 =?utf-8?B?aHA0YmtZRUR1a3p1bDBWWlJMamR6Z0RSbDd3a1Z3Z1NNQSszT01PdVgyMDIx?=
 =?utf-8?B?VjM1ZWVsOWk4QzMwYTJnbkJXYVFpeHd1dEVLbHdXM3ZCN2RkSlpvYURMUTdv?=
 =?utf-8?B?N0ZGbEJ5TFhnbFRNQVdhaWpaa0I4UFFpRmRpTTloVE5pczk0WXMzeGg0cG5v?=
 =?utf-8?B?YUVVMnIxK2h4TkdHNWczcVlFVW1yTTZUc3VmVVpMUHpURGkxWXVBU3NLb1NS?=
 =?utf-8?B?Y2lRVUJOR3BQOVdWOXlEalRRU0pVYXVQaFUxck9vK3lKRlhyeGhQMnZQRDBR?=
 =?utf-8?B?NjVHWUxoRTZubDJPb2d4c28rR251dUdGNWQwVkl3Y0JGMVZubWtSc2RZdGJ2?=
 =?utf-8?B?aFN1cmFnTWJaNHNHUHdHSk04SUc3TWc5eU1KNlVML29RSDdDWnRMYnRvZ3di?=
 =?utf-8?B?NmwzSDlTcENzVW5qSkNxU0w4OFZrTm9ISDNKSXdNaXZ6d2VoVFIvZmkrQ2tU?=
 =?utf-8?B?anhrR0ZGMWgvVjM4bmJ2ekdObk8xUzR3TDB0dC9qQTNDRXRwc1BxZVFmWExD?=
 =?utf-8?B?NW1objFyWEVUNVNjVHRvRzZKbzROaU9mWXJmSllRR0tXZms1aFU2N1U4VkdG?=
 =?utf-8?B?VXhnQkxWQXNQNjhzK1ZMeENvcHkvTnZoSDA1SDFXTW81cDdNMmwrT1QvbWdv?=
 =?utf-8?B?bXNVem5mR1Mrbi8rbjVaK3NuQ3l6SEI5T0NrbjJPUzZJMUhzaHZGSDNFdGJQ?=
 =?utf-8?B?SEFNck1sNVJuNVltc2twYmpQN3MrbnYzT0hrVklNVTNWbkd0T1N1TVg2L2sv?=
 =?utf-8?B?WHNRYlowbll1aVJZb3k5S2xvcThFSkJxU3pxbkhYbzhjbTBHZTkvU2JGa1Fj?=
 =?utf-8?B?cVV2TklWdXhlRmI0Skw0MUVFeXgwU2FxWEsxRzQ4S2JRYXhXYWVzeC9BZDA5?=
 =?utf-8?B?ODk0ckE1NjFBVktJVjNtZDAzSDkxZUR1UzJ6eUN2U0Z5MTYrY3JkMEY1dGd2?=
 =?utf-8?B?dkwreXZsTXQrWEZSck9JTVhjd0h3UVdpOXZ6SGV1T0FkcExqR1hYMXR1TENk?=
 =?utf-8?B?c0VxWVQxdVcwM1dpWUFqSEtPc2N1K29KRE5MelhPSUhPYjVHN1ErQ3VtQnds?=
 =?utf-8?Q?+3l9CaMPi1em9us2JkB+m3eW2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e385109-db04-4196-daa7-08dc8c8c493a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 16:08:53.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HEugkZgc0yLRw4LkaMRYS5aRuAXlLgeGSMnHG6rN8ezz1lCtHGYlDLM7TN9we1BNX5kbaeaxohuDlGq5WdEHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430

On 6/14/24 00:10, Li RongQing wrote:
> In CoCo VMs, it is possible for the untrusted host to cause
> set_memory_decrypted() to fail such that an error is returned
> and the resulting memory is shared. Callers need to take care

Can you explain how it would fail or where in the call path it would fail? 
Are you referring to the the Page State Change being performed by the host 
but it returns a failure?

As long as the encryption bit hasn't been cleared in any of the guest 
pagetables for the page range, then there should not be an issue. When the 
page is referenced it will generate a #NPF and the host will have to make 
that page a private page in order for forward progress to be made. But, 
that page will already have been PVALIDATEd previously, so the resulting 
#VC for the page no longer being PVALIDATEd will allow the guest to detect 
the malicious hypervisor and terminate.

If we fail during the __change_page_attr_set_clr() call and we get a mix 
of pagetable entries that could be a problem, so leaking the pages would 
be best in that case.

And since the failure reason isn't clear after the call, leaking the pages 
is probably the safest thing.

Thanks,
Tom

> to handle these errors to avoid returning decrypted (shared)
> memory to the page allocator, which could lead to functional
> or security issues. so don't free decrypted memory
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 654290a8e..799563a 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -730,8 +730,7 @@ static void *alloc_shared_pages(struct device *dev, size_t sz)
>   
>   	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
>   	if (ret) {
> -		dev_err(dev, "failed to mark page shared, ret=%d\n", ret);
> -		__free_pages(page, get_order(sz));
> +		dev_err(dev, "failed to mark page shared, leak page, ret=%d\n", ret);
>   		return NULL;
>   	}
>   

