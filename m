Return-Path: <linux-kernel+bounces-176599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991CA8C3211
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1B41C20CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837D35646D;
	Sat, 11 May 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dc+oU/Cf"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F44437C;
	Sat, 11 May 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715440624; cv=fail; b=khQdlkwSUqw39O+AGcocyvcPltAQ8UNGfJHKrCg2fQKETw65WQdFkolFGnKgTtlbK5YPyfJR6GMRQx8zwKOrbVyHvwvTHAs6UpYhEAOVjmiGpi0DTeNiUJkW+6/PevBAiRvnrlvyGCUeUOZwgJdOIDlE1TO7shxJBfynUZ0+ing=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715440624; c=relaxed/simple;
	bh=OLzHlt1owpULLIhRKn30kR1sxYhvnmEA0st/eBV7rV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cl+unJWQexcM+Om74ICJiYDDZUM89/lN2ap4HTkiN3VI/HX69at1v2ik/AM8jySus5OjDe0+3TnCh/MyzlFn7AkvjsLskVh7/u7pX3N2/7BtBs9TjeHYu1vWtDCY02lH2hqAyj728h/TqDu3Zzi3H31+YNHfr2Gu28VX7zu+I/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dc+oU/Cf; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTnpX2OzjuVrFmIIZCNaSX7QWrP6welaCbaUBztnOPAiebuob1dAYF6chwQZcLd2qtKbmrZFnqbGUVVhFjcgmAgvPtTMbCYf3RJ6r5pt5YlBrILylufM90F07qlKnxi15o24KpCsmK6AEoN0Kjnc9GSKa9oxkR54XybshvpEWSoAPO6WsRGs8o3Bq9SQiDI4xM41VZgo5dlfrxlVMlPcjRLmwXC58wTdkVqX/7AffFPT/WBJ3jOmwWwVuUc0Eljtcu/SaiM11IuA0zxBmue/bm2tbEx0N5XN54wEMwRx9GFv3UgnUvFfu75R5q2UnovLOzMELuFh6KzPol3reZkUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSBEhUGvzX1u5t6KCB/uO7PngrXEeHuXUfZ9X1cDHG4=;
 b=FtMDETR9YwHFvHo7b8BKIDSoDkq2wo0nbwnkWvtko3evUcBvQPcmlKaxxedroeclDkYpJV83KaaWC2V+zlxXDtiFVmtCfX36TLbUUu/gZHhxOrvC8PYVfg3sYga8Da3XloLtgs1W8YvaV1sWqhGAgnSobYIN7yyaFb/yIgrbLST93J/kS8na3EPEkAgfGhTlqrsan0cyO+d5Dg0cZOsK8SkqsSxwB+mtDExa8HJjmqiiYghSkIVSxtc5vOo71o+meqK66sQ2SmAE/TVj9EXVGASr9U4FL93JAW0pMpKo93mjZq2wORqdb3qKsk6KEWJwoHJ1AfL9IbSBxjuK3/Qs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSBEhUGvzX1u5t6KCB/uO7PngrXEeHuXUfZ9X1cDHG4=;
 b=Dc+oU/CfqRQCR7rgBIkVLEUzG8p7iDnHT/o+vSTFOy5XLiqNWmY0DT5OlwEn31xTjnuzTZdfLnptAl80/0JqoHgkjrzKdk2x55wzZOypc8955lgWpo/BvJWkY6zinYscPJxcxuaViDkisZ/hVA+KBgqogsDUXRP2SoRow1PPE3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 15:16:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 15:16:59 +0000
Message-ID: <9ba4a500-9d88-4630-bd94-99f07dd51abe@amd.com>
Date: Sat, 11 May 2024 10:16:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] platform/x86: dell-laptop: Implement
 platform_profile
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, lkp@intel.com, hdegoede@redhat.com,
 Yijun.Shen@dell.com, Matthew Garrett <mjg59@srcf.ucam.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240511023726.7408-4-lsanche@lyndeno.ca>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20240511023726.7408-4-lsanche@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:610:38::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 8645e396-95bb-4d28-0110-08dc71cd6751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjljMGJKdFM5UzFtYlNrdGVJNGRwZHRYdFJCVmN1amdaUExzQWZnNWdNUXFB?=
 =?utf-8?B?dkdiRStWVmRwRGtLWFZCYmtTa0hBeHIvS2h2UmFPVnB6MyttSmt4REdFVEp1?=
 =?utf-8?B?RURqR0tBbXJ1REI3ZW1pbWVDb2Z0cDlxdEpFRGtMWUxMRVVFNGgwOHNQRnA1?=
 =?utf-8?B?QXJQMnFxdTdaY2hYaWFra093cE1LRC9MaEVwNGpZSnZGTk9DM3lKOG9ZcEw4?=
 =?utf-8?B?Rko4Ullka0lhN1krQno5WWl5Ym9scW5CYlZ0cFRJMzdRUWZrLzRyVGFDMGNr?=
 =?utf-8?B?Q0M0TWlMblpERk5lOHVvM2JWV2hkWlNVYlgrTWZWRkZMeEZ5YlB3b25BaTBq?=
 =?utf-8?B?WnZKSU04SWJLc3lEcGRpUVBpaFMycThDYkw5M05UcWE5T0VDa2cyVlhBUDZk?=
 =?utf-8?B?a2hhWG5KVU5wMDVRSzZGVmJPNzB5RVlnMkVZd0dqRFoyOUVzdlFQT0xZU0ZM?=
 =?utf-8?B?cGMvVmdYSElMQWtZNkVVOFhmU0p4VlY2dm5UelBLdDEwdWdpQ1FiV2t0UGpK?=
 =?utf-8?B?ckFSRUJKNTFnVEQ0aHZPSjZSN2dIL29sZUQ0RG5uVE4xMms2eXNZcGFuYVhp?=
 =?utf-8?B?NmV2cTlJL2Iyb2wxVEFXVjNVQmpESXJ2djQzME9lTW1GTEFzNHlqYzV3ZEZ0?=
 =?utf-8?B?YnJ3V0pLWktKS3RsMjRRSkZOQmlzRjNBYlN5a1VxWmk4YlhSN29BcGlMT01Q?=
 =?utf-8?B?K0d4QXNUMXlOOEc5S0drR09CeHp3aVdJVUtYQ0VHSm1Kb1FTNFZ6eVZHakN3?=
 =?utf-8?B?NUFJZkx2dVk5YjlpZm9aczZ4U1RMbDRrUVo2Q1VaQVB2THlEb3cxZ3R4dUta?=
 =?utf-8?B?cUFKbDNkK2U1UVpWakZMYktoQmh6SHVYcDFySTZMMzYwME9FSmxBVVVaUnA0?=
 =?utf-8?B?VjR0QzhIdVN4QVdNd1huNmFKaTJlS1Q2alNCbGhvZzFNVmx0aXpWMCtzczJC?=
 =?utf-8?B?MlQzQmw0NW5OL3pBWklValJKaXA2Z09ERXlWckp4QnlZenVGQ2lWSjFpcGpE?=
 =?utf-8?B?ZlRGYjh2NDV0MUFWNXlmZVJHaHFHZ0tBdXJtUHNNY1FVYnFtK045N1grMm1R?=
 =?utf-8?B?U0tLUG9PaXRQTDlaQXNNVTVHQ09ZUkZNNFJlZ0VVMTVJZ2RZdHRaNlFDNFVS?=
 =?utf-8?B?NkR0emo3enNNNDcrYUdKRS9udkIvT3l5bXRESkoyRnRLdVdSc0JNazlQSFVy?=
 =?utf-8?B?OUF6WjNEWjgzby9uR2VWV3BJbnhucnI4bHFoOWFSelNZZVZ0UEUveWlMWTFt?=
 =?utf-8?B?R2dLVTJJQlhDaDlYQzN1dnU3WHByOGJHczZKMXNhZU5IblJxVVYzUU03M0lF?=
 =?utf-8?B?QU9PTkFkNDF6WllucmFEN0xEc1RYbzg1ZTliVW5YREhIQ1pmM0pUTXUzSTR0?=
 =?utf-8?B?MVc0YjJxYmRieS96dlpmVXErc0FEQ0N4bUJDS3RzYzlta0pIb0c2bno4bENv?=
 =?utf-8?B?bW1yODZWckFSM29HTHIrZndZWC8yUnB6WTBFTXI4T2FoUjRCQTNaM05ocHdE?=
 =?utf-8?B?L0FkQVNjdUh2RVJCb0VYdzhMK3JBbEZ6VFQ5ODNocmNidHVQOWorZGVTblM0?=
 =?utf-8?B?VjM3eHJzNFlCRnV4dGoxc1BrRkhGVC9SRXFVdGZRSkNGRWZxRms4NEl2dEpP?=
 =?utf-8?B?NG9iWDhXWm9ZbVBiMXJQUVNTcG1mNUlSeHpoZlpsMjkxTGp0Tm8za1pUYUR4?=
 =?utf-8?B?ZFpPT0JZUkxpMkdETFozeDJvekdDZWR0T0ZjWW9ONzFrZTdyK3ZrbjFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk9HQXhZTjFjaXZSYXgvK1RjTXpRRzBrVy95S211Vm5hV2dobVNFeTVTeWpQ?=
 =?utf-8?B?cTdPdUNja3lJbXFjL0pLYmhrWlNKbzN3dEM3Sm14enpaazYrSEFjTmZxQkhz?=
 =?utf-8?B?OHMwaDhGWHRETXgrS1RnQ3ZWeWhGcURBS2hXZ3ZwYXdpUklhVUpkNHRMaFFI?=
 =?utf-8?B?eFNNNnV1SGtrcWtPVDFSaWgyR1Bya1NtZlUrZmlnRG5UMmYwbnNicUZTVFkv?=
 =?utf-8?B?WTl3bXUxYlNxYXBIeHpkV2JsMHRnRVVjSjNuUnQ5aktGR3VaeElQZHNjY2dN?=
 =?utf-8?B?TENVemR0NU5XdzlzTnp6Wmc1eEp1bTk1c2thbjBINzhBbWdidjgvdkF1cHk4?=
 =?utf-8?B?SUdnbk1FZVBhcjkvS0JFUzdIc2lKTlNpZU9FeC9RV1FkMkR0U1pnL1BLRXBH?=
 =?utf-8?B?a3ZXRFdnRktsUkhwckNYYldXdXZxV1ZLVUNHNUdEamxDVndEMTNTZHBJK2Fl?=
 =?utf-8?B?akY0SkxzN1FDZmZXQWNsa2wwUis2d2dRdHprWHUvb2xvdmxwdnJDWHo5Zlhm?=
 =?utf-8?B?alhqb0ZOTGhJNjlTRDJVVnEyeWZVQmdzd0oxbW8xK1ZZZ05XMUhac004MWg0?=
 =?utf-8?B?QUpkdnNzb1g0OXRMajFVQTg1SDRTSDNYVml1RjJIYStycWhiWUhGNTVSN2Va?=
 =?utf-8?B?NVk1eFJ1TVVwYlBLeGN4MkU2N0tJTFV6U0ViUzFZY3ovcVFWQUYzZDZvQ0I1?=
 =?utf-8?B?WElKUGliVXlITFpTMENJbkdLN2UyeWFDOEY0SkhNN0M1bjFESEdMajI0dEcw?=
 =?utf-8?B?aEdLbWgyQXdKa0l6QkNXVmVYZmpJanRCQktaM2ZPKzNDYmJ4MlFveFRSUE5X?=
 =?utf-8?B?TGxPbnliSDN6Q2Y5TzR6NHdBSVA2WXlJMG1ucFpLNFBEL2M4ZFRkOTdkOU5M?=
 =?utf-8?B?alhWWGZsRE0vUHVYNTBiTE44ZHpYMC9SdDIvaFJMS0Z2WkMvNWVNd1orTXBt?=
 =?utf-8?B?TWorVU1ES0hmWXc5eEFpVjZzMzc4NjRGdWQ4bkR5dVlpRTFVdDVqMkdRTEhv?=
 =?utf-8?B?VFViaENmM1dlR21xZk1RbVJHem0yVGZEcTRFd2tJOC94cSsrUk16T2hlWmRH?=
 =?utf-8?B?d1VJL0pmVXRVcWtVREFRbGpyL1R1SUppazVGS0trZ0VUbFVCUUVzaFdQR0R6?=
 =?utf-8?B?NUZmK1g4aXVINVhMdEs1NlFVdEE2N25BOFVVN3BRRnRSSFVqYkYvS0ZnYlBR?=
 =?utf-8?B?RUpiY0xFbHVVd3JFb1NvK200V3FGMkk3YlY2dlRlN1BzbXZJamR1aDlyS3lG?=
 =?utf-8?B?Z1Y3SlhwU2lOd2NmcStGTHJsWDk3bEIrRXBObWR2VmlVcFZON0xNSVFNd1Ey?=
 =?utf-8?B?VmtxeWhnOUZaN0IzUFgrQis1OTZLaDVFT213UUR0M0QyNFpSa2N2QXRFa3Nw?=
 =?utf-8?B?OUdlRXZ0WGVITUZpQWdVZGdEYjNQTnFMeXIzTlVSZXJySFg2dHo2emVOZHhR?=
 =?utf-8?B?NkxZRDRpUTNyblpONW5YcWR1WFZuMEdFZGxsQnoyWnlnZnU2V2dIa3VSQjE3?=
 =?utf-8?B?MDhsWkdIQ2JucGc0MHo1aU5hQU1OUEUzUXpRVVprZFdEeW1nTXNPeXlaM0dq?=
 =?utf-8?B?MHFlcXZjcFVzNHhzemZlcjVyR0haSVQ5YTdrVFRKWko4N1BQQm5SMStCbXdT?=
 =?utf-8?B?R0ZoSHRPWEEwbnV4MzNPRkY4SUFkOTROVzFUTjM2RW80K0RLalNDTjhpSlBD?=
 =?utf-8?B?MlZMUStKU0VQeVNwbTZlK1dXRmx6REpvV3JZUkx3cHhoQmIvWnJ2Nm9aTWlK?=
 =?utf-8?B?eEp5a2JrS3BTQ0UvazBwb0VIQ2xzOVJhNUViZmtDbTJNNjNEZC94TTFFQndO?=
 =?utf-8?B?QkVGZWlUNGZHWTNLblN6WXVVd05sc1FLdDZhV1Q4MjB4VFVUTTdaZmdsWnQr?=
 =?utf-8?B?TGxESE1ySWxIK20wUmlDRjd5VXV4TmUxQy9uVTc0QXM1S1hjaTZjdUNEZ0Za?=
 =?utf-8?B?TzFZNWh3eVRiODFRTlE2M2dUOFhXd2tZMGk5aTJkUStjTkNSZ2tiY2p3eWhM?=
 =?utf-8?B?bkh2S0N1ZnJxZWx3SUJ5ZnliOWhhaUk3SWwxQldYYVdkbk9uKy82OVRBL2xR?=
 =?utf-8?B?V243WWM5R0hLUjAxNmpEN2lLUG95cWhTdTJ3NE11bm5xaXFLRVNVajJCbkdV?=
 =?utf-8?Q?QazqoDZH8+X9LLBl741TctuDm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8645e396-95bb-4d28-0110-08dc71cd6751
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 15:16:59.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQiURIixCIE4sv/zu4b+ahpGB4NbwKRUGGSbuIColXPtnUHDs42dEql3fiWKGrRgE/oiFswJeR/nPZ5wd9pf7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706



On 5/10/2024 9:36 PM, Lyndon Sanche wrote:
> Some Dell laptops support configuration of preset fan modes through
> smbios tables.
> 
> If the platform supports these fan modes, set up platform_profile to
> change these modes. If not supported, skip enabling platform_profile.
> 
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---
>   drivers/platform/x86/dell/Kconfig            |   2 +
>   drivers/platform/x86/dell/dell-laptop.c      | 242 +++++++++++++++++++
>   drivers/platform/x86/dell/dell-smbios-base.c |   1 +
>   drivers/platform/x86/dell/dell-smbios.h      |   1 +
>   4 files changed, 246 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index bd9f445974cc..26679f22733c 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -47,6 +47,7 @@ config DCDBAS
>   config DELL_LAPTOP
>   	tristate "Dell Laptop Extras"
>   	default m
> +	depends on ACPI
>   	depends on DMI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	depends on ACPI_VIDEO || ACPI_VIDEO = n
> @@ -57,6 +58,7 @@ config DELL_LAPTOP
>   	select POWER_SUPPLY
>   	select LEDS_CLASS
>   	select NEW_LEDS
> +	select ACPI_PLATFORM_PROFILE
>   	help
>   	This driver adds support for rfkill and backlight control to Dell
>   	laptops (except for some models covered by the Compal driver).
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 42f7de2b4522..07f54f1cbac5 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -27,6 +27,9 @@
>   #include <linux/i8042.h>
>   #include <linux/debugfs.h>
>   #include <linux/seq_file.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/platform_profile.h>
>   #include <acpi/video.h>
>   #include "dell-rbtn.h"
>   #include "dell-smbios.h"
> @@ -95,6 +98,7 @@ static struct backlight_device *dell_backlight_device;
>   static struct rfkill *wifi_rfkill;
>   static struct rfkill *bluetooth_rfkill;
>   static struct rfkill *wwan_rfkill;
> +static struct platform_profile_handler *thermal_handler;
>   static bool force_rfkill;
>   static bool micmute_led_registered;
>   static bool mute_led_registered;
> @@ -2199,6 +2203,236 @@ static int mute_led_set(struct led_classdev *led_cdev,
>   	return 0;
>   }
>   
> +/* Derived from smbios-thermal-ctl
> + *
> + * cbClass 17
> + * cbSelect 19
> + * User Selectable Thermal Tables(USTT)
> + * cbArg1 determines the function to be performed
> + * cbArg1 0x0 = Get Thermal Information
> + *  cbRES1         Standard return codes (0, -1, -2)
> + *  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is supported if
> + *                  its bit is set to 1
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC) modes.
> + *                 Each mode corresponds to the supported thermal modes in
> + *                  byte 0. A mode is supported if its bit is set to 1.
> + *     Bit 0 AAC (Balanced)
> + *     Bit 1 AAC (Cool Bottom
> + *     Bit 2 AAC (Quiet)
> + *     Bit 3 AAC (Performance)
> + *  cbRes3, byte 0 Current Thermal Mode
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performanc
> + *  cbRes3, byte 1  AAC Configuration type
> + *          0       Global (AAC enable/disable applies to all supported USTT modes)
> + *          1       USTT mode specific
> + *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
> + *     If AAC Configuration Type is Global,
> + *          0       AAC mode disabled
> + *          1       AAC mode enabled
> + *     If AAC Configuration Type is USTT mode specific (multiple bits may be set),
> + *          Bit 0 AAC (Balanced)
> + *          Bit 1 AAC (Cool Bottom
> + *          Bit 2 AAC (Quiet)
> + *          Bit 3 AAC (Performance)
> + *  cbRes3, byte 3  Current Fan Failure Mode
> + *     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan working)
> + *     Bit 1 Catastrophic Fan Failure (all fans have failed)
> + *
> + * cbArg1 0x1   (Set Thermal Information), both desired thermal mode and
> + *               desired AAC mode shall be applied
> + * cbArg2, byte 0  Desired Thermal Mode to set
> + *                  (only one bit may be set for this parameter)
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + * cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
> + *     If AAC Configuration Type is Global,
> + *         0  AAC mode disabled
> + *         1  AAC mode enabled
> + *     If AAC Configuration Type is USTT mode specific
> + *     (multiple bits may be set for this parameter),
> + *         Bit 0 AAC (Balanced)
> + *         Bit 1 AAC (Cool Bottom
> + *         Bit 2 AAC (Quiet)
> + *         Bit 3 AAC (Performance)
> + */
> +
> +#define DELL_ACC_GET_FIELD		GENMASK(19, 16)
> +#define DELL_ACC_SET_FIELD		GENMASK(11, 8)
> +#define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
> +
> +enum thermal_mode_bits {
> +	DELL_BALANCED = BIT(0),
> +	DELL_COOL_BOTTOM = BIT(1),
> +	DELL_QUIET = BIT(2),
> +	DELL_PERFORMANCE = BIT(3),
> +};
> +
> +static int thermal_get_mode(void)
> +{
> +	struct calling_interface_buffer buffer;
> +	int state;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	state = buffer.output[2];
> +	if (state & DELL_BALANCED)
> +		return DELL_BALANCED;
> +	else if (state & DELL_COOL_BOTTOM)
> +		return DELL_COOL_BOTTOM;
> +	else if (state & DELL_QUIET)
> +		return DELL_QUIET;
> +	else if (state & DELL_PERFORMANCE)
> +		return DELL_PERFORMANCE;
> +	else
> +		return -ENXIO;
> +}
> +
> +static int thermal_get_supported_modes(int *supported_bits)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*supported_bits = FIELD_GET(DELL_THERMAL_SUPPORTED, buffer.output[1]);
> +	return 0;
> +}
> +
> +static int thermal_get_acc_mode(int *acc_mode)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*acc_mode = FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
> +	return 0;
> +}
> +
> +static int thermal_set_mode(enum thermal_mode_bits state)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +	int acc_mode;
> +
> +	ret = thermal_get_acc_mode(&acc_mode);
> +	if (ret)
> +		return ret;
> +
> +	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mode) | state, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> +					enum platform_profile_option profile)
> +{
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		return thermal_set_mode(DELL_BALANCED);
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		return thermal_set_mode(DELL_PERFORMANCE);
> +	case PLATFORM_PROFILE_QUIET:
> +		return thermal_set_mode(DELL_QUIET);
> +	case PLATFORM_PROFILE_COOL:
> +		return thermal_set_mode(DELL_COOL_BOTTOM);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> +					enum platform_profile_option *profile)
> +{
> +	int ret;
> +
> +	ret = thermal_get_mode();
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case DELL_BALANCED:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case DELL_PERFORMANCE:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case DELL_COOL_BOTTOM:
> +		*profile = PLATFORM_PROFILE_COOL;
> +		break;
> +	case DELL_QUIET:
> +		*profile = PLATFORM_PROFILE_QUIET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	/* If thermal commands not supported, exit without error */
> +	if (!dell_laptop_check_supported_cmds(CLASS_INFO))
> +		return 0;
> +
> +	/* If thermal modes not supported, exit without error */
> +	ret = thermal_get_supported_modes(&supported_modes);
> +	if (ret < 0)
> +		return ret;
> +	if (!supported_modes)
> +		return 0;
> +
> +	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> +	if (!thermal_handler)
> +		return -ENOMEM;
> +	thermal_handler->profile_get = thermal_platform_profile_get;
> +	thermal_handler->profile_set = thermal_platform_profile_set;
> +
> +	if (supported_modes & DELL_QUIET)
> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> +	if (supported_modes & DELL_COOL_BOTTOM)
> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> +	if (supported_modes & DELL_BALANCED)
> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> +	if (supported_modes & DELL_PERFORMANCE)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> +
> +	/* Clean up if failed */
> +	ret = platform_profile_register(thermal_handler);
> +	if (ret)
> +		kfree(thermal_handler);
> +
> +	return ret;
> +}
> +
> +static void thermal_cleanup(void)
> +{
> +	if (thermal_handler) {
> +		platform_profile_remove();
> +		kfree(thermal_handler);
> +	}
> +}
> +
>   static struct led_classdev mute_led_cdev = {
>   	.name = "platform::mute",
>   	.max_brightness = 1,
> @@ -2238,6 +2472,11 @@ static int __init dell_init(void)
>   		goto fail_rfkill;
>   	}
>   
> +	/* Do not fail module if thermal modes not supported, just skip */
> +	ret = thermal_init();
> +	if (ret)
> +		goto fail_thermal;
> +
>   	if (quirks && quirks->touchpad_led)
>   		touchpad_led_init(&platform_device->dev);
>   
> @@ -2317,6 +2556,8 @@ static int __init dell_init(void)
>   		led_classdev_unregister(&mute_led_cdev);
>   fail_led:
>   	dell_cleanup_rfkill();
> +fail_thermal:
> +	thermal_cleanup();
>   fail_rfkill:
>   	platform_device_del(platform_device);
>   fail_platform_device2:
> @@ -2344,6 +2585,7 @@ static void __exit dell_exit(void)
>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}
> +	thermal_cleanup();
>   }
>   
>   /* dell-rbtn.c driver export functions which will not work correctly (and could
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index 6ae09d7f76fb..387fa5618f7a 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -71,6 +71,7 @@ static struct smbios_call call_blacklist[] = {
>   	/* handled by kernel: dell-laptop */
>   	{0x0000, CLASS_INFO, SELECT_RFKILL},
>   	{0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT},
> +	{0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT},
>   };

So when Alex checked on v5 that this doesn't load on workstations, it 
has made me realize that doing this will block the interface totally 
even on workstations.

So I think there are a few ways to go to handle this:

1) Rename dell-laptop to dell-client or dell-pc and let dell-laptop load 
on more form factors.  This would require some internal handling in the 
module for which features make sense for different form factors.

2) Add a new module just for the thermal handling and put all this code 
into it instead.

I don't have a strong opinion, but I do think one of them should be done 
to ensure there aren't problems on workstations losing access to thermal 
control.

>   
>   struct token_range {
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index 63116671eada..5d7178df80c6 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -19,6 +19,7 @@
>   /* Classes and selects used only in kernel drivers */
>   #define CLASS_KBD_BACKLIGHT 4
>   #define SELECT_KBD_BACKLIGHT 11
> +#define SELECT_THERMAL_MANAGEMENT 19
>   
>   /* Tokens used in kernel drivers, any of these
>    * should be filtered from userspace access

