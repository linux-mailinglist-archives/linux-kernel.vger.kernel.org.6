Return-Path: <linux-kernel+bounces-414567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2A29D2A15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFEB282BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C7C1CF7C7;
	Tue, 19 Nov 2024 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KBVVIOLU"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55010146A9F;
	Tue, 19 Nov 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031159; cv=fail; b=B9MdKKhFWH3GY9iRhdSmPf4D7VVHtloFpJlWtA21zbZjAcPZSCvoTobUypBaTmsaQ9gcfjoF1MWaNWLeJYzc8W6eZfJAHo7K8bwKuyqbOCWTRqGIf+xw5MJkNzNyDyesh22Re1mH3pdftvPdfMM9BHCh4qWY2dXSajoMe0iukGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031159; c=relaxed/simple;
	bh=nn+XIuH4netS7yU0TwWDkNZimp2jHuTDtwxmtXglEbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XXgFZgVvU38SgvWnSq1xmAu6dvClAR+lJjtHz0vjOzicJUpk1mLlMJ4vPSsKJLiTIruJN9VIwJME6eyklJdatZXNnNJ5sM1PYmYNEfT1NKzW3F+dU9ektbKuGxJLfrzvhsjQz/T86lEvNGwy9lLgRc2HsDAeg8UfjZoqqy6KaME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KBVVIOLU; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQqvMJd/uf1sO+Gv7Zt1YUYLieRRw7WjzgMqQl39QQL84VDuEsE31tERSzeV4gkPbCgA/O/DHU94P7eTMMUNdBllLvkrUjN7oeihZenBEKjBoMCq0v8OambCLlE6HGd6CXKcKq9Zn+xJxSra1FD1fqU/tAqeuPeMJuOXF5aPa/xvXKZOXM83RhdCHtwOFvxmwq1LSoUbnHz0qwoRqw7ArH0O4p6NYyZj7ZKSkdccYA/uqYrJy+bx7Pqao90c1d6VZXJ2mfbt8CdvoQ8vkDWlT4aqLCOdOhmcnUHwZAZFS4JwQSKKScXsf9txjncf8fLeMbWqegPN2zlav0xEyVK46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPSw5zQRJF1O4eh5FTSdSKI/87qOwfARL5yLcJ+1aIU=;
 b=hpKo/SLtDojcYP1lY8yQ7HtIc/r3XjWTXrVfqAjjiZTMjMlIGVrPvL7FxNT68IX3AGNoBIGnXyNjtIzkQ7xq5SL4utFzZyVKvdsvdrPIv0rDXRj0cClQZiNchToXjrVnzsG1DCKQZDi+ltjSXE/HnXz9iKXxhHn3LTZJI9fvChzhoS1pSkoF1DfdjH6OdgfA8NxaVbxEv+Qwabs6xGcbD3/W79oGcym3XJW1UjCIHcVidvsVIeygQ0laXmFyG7ZYMjEo6kJNge7LXeh+mn741vCyFpTdP+lAnmYKEn/zTv9BHYiBb9HLTihOd7kKuxttimjdMyNteWgPs9Hxd0st/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPSw5zQRJF1O4eh5FTSdSKI/87qOwfARL5yLcJ+1aIU=;
 b=KBVVIOLUtxi4dM0ONpHNN2jbWMQS0F21GopbaV3CFDD29vmGKx/x1PgCS/s/pcrVkXrI3QZJp7kNkTgNkL+ShpYcLgoQ9N6Z4YgeYzzdCdd90diuY60e2Bek1Ncpy/HW5wzT+/QUkELeoidcv1B9jENPgev+PNczZ6cWsJK9crk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 15:45:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 15:45:50 +0000
Message-ID: <0b27ecfc-af5e-49e4-82d4-ab36060ff5c7@amd.com>
Date: Tue, 19 Nov 2024 09:45:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: Fix build dependencies for `SND_SOC_AMD_PS`
To: Mario Limonciello <superm1@kernel.org>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
References: <20241118025527.3318493-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241118025527.3318493-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:806:d0::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3261cdb0-7c89-4165-9fa9-08dd08b13e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czF0b1M5dXNYWStMaGkwVzB5YUlJQjFZUENPRUprMUNHMlpJYTBIR2FTZWtu?=
 =?utf-8?B?WlJISVZZR0xHQ0NZd09kc1UrZzQ4aDdZLy9oWXUycCs1b0hibE9VYzV5UytS?=
 =?utf-8?B?RENSeXpBN0NXQzh1R29yeDVRY0RHZXRIdFZTQjBJY1k1Wnh3T2ZtanFJN3hM?=
 =?utf-8?B?RVBGZGw4bTNqN3Q3Z0gyZUdqTEg0M01DYitiaEg0M1VoMzArOS9HZHRvT2Fj?=
 =?utf-8?B?ZVY0dlpJSHJKN2xIYlpUeG5RNW1XR0Iva3hGQ1ErM0ZOaC9ocTNXM2dlcVU3?=
 =?utf-8?B?bHRhTm91V0xUdkJoY3RKY3hvRThWZkpvYXYzekM3c2xQODgxd0lTZUpZcmZR?=
 =?utf-8?B?NUNFSXlpd0hiRWI2c2hROTVyMmRKWDN0aU1mR2FiRjdBV0Q0WGE2TXZuQit2?=
 =?utf-8?B?NmtuQVJJQmlpNjdkRjkvdDNYZDJyYWl3TCtBVU1kbWxWZDdtQS9RdmQxVmg1?=
 =?utf-8?B?M0NycUlzV1plS0FvWGxySldrWC83QWJZNkV0S2JsL0VpU1p5TXVjbUROWk9s?=
 =?utf-8?B?SzhXZWdNVk5rSzJxOHBabjhWS2VZSk1IS2FFZWpsZytTK05UQjNhYTNYWUI4?=
 =?utf-8?B?SElvQ293R25yWTYwTUVsVnBiSU9EWjVLaVhBL0wzMTZhWWZxMStlclA3STZm?=
 =?utf-8?B?S1U3TDlNOWF5czhRc3ErWHRsVXlvN3piRFVxSExkRUZsWkJyQWlZRS9aY0Vx?=
 =?utf-8?B?aXQ5ckRUM1haVTVuSUpZaEp3dzRxUjZZVm4zMUZxdlNVRkRJYUVtQkNnVVkz?=
 =?utf-8?B?dFBoeHZodmRsNGdWS1VnYkdueEY1TG84MlRLSWNRbGh1SisxL2JSTUFGdzZu?=
 =?utf-8?B?TUFLb1dCbmxLdGpUdjFxeHBhdUhTUE1BVUdTcE1iS2JTZXpFQ3VOZDd3ZXkz?=
 =?utf-8?B?RzU4Y2VTWThET1o2MUsra0hlZ1R4VWc2R0lONkp1eThnNmk1YUFQUjVlbnZY?=
 =?utf-8?B?RDRxcmJVMUk5U05iMXZsTjdncDZlVXZlRXJ3eXZ3NUlIMzZLc1ZXaFdtNHNu?=
 =?utf-8?B?dWFDc1VKdGw0L0RqaWVYQTN4Q0pCNEJnNThlR2oxN3BKKzJadVJZQkViaGJN?=
 =?utf-8?B?NXJ5dzBjZXYwcDN6RmtVV2tpUk02R3hxZHpqT3lic0FYbXNVQTdjQUVDU2ZV?=
 =?utf-8?B?WXdaTVdjV25aMXp6ZGRqS3RHWWtZeElTa2RlQ3J4WGVQUzBWbmV6SW83UUQv?=
 =?utf-8?B?Q0NxcURkdmhaWTRDMHZIRjdwcmkvNzl3WElWYnlVTE01Q1YwU0VBOURHblcx?=
 =?utf-8?B?aHhCYUlyVEZnYlRwbldvRUtySW1iWFFkUVNQNEZxaXBvM1NtZnhWREQwd3U0?=
 =?utf-8?B?MEtoaFRXOUpXZzJyNnQzc0hSdG9SYjBZWkRlYWZraG14Rm0zRS9FY1ZsYXFH?=
 =?utf-8?B?ZmszNlIvazJBbnVaYVV2RGN1YnRKOFJPVDQwbk5xWGdsVUh1enBNZ3NySmg4?=
 =?utf-8?B?cUxqMUpwUGM2Q0hRSDV2eEhCNDQ1ZzQ1bmVMbzRDalpha1pTa3I5QnM0dEVO?=
 =?utf-8?B?Qm5rclQwNFV3bTk5SHdldG84WE02THMwbzU4QXA3VUtOWWxOZ3lTT3ZhRGV3?=
 =?utf-8?B?blFqQm5ERkZYL0MzMjRDOWpFcFdIN0t3bHBpT0FpQmgwS3VZRUpENWFoQ2Q0?=
 =?utf-8?B?WmdMdGRzcXFjK3IwNnBKeWJmK1BUZ0oxbS93VGluSlVwQUk1TkZhb2MvL21I?=
 =?utf-8?B?OC9WWFoxeWtLdFBsakhhSzFJNXZ1Mm4vYUpwRmZKWG1RbWxWWWlFRitEdDVH?=
 =?utf-8?Q?c1z8ICwmJmQWy6uMCuxp6ZrAzqPlqTgGGSQGI7L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0Z1UG80UWVWLzlKY0hZak5jN3RXN2ZubGFXRjZ5RUpjZlNvenNFeGtJM0hl?=
 =?utf-8?B?L2piUEVtWjhWRWRPdFpOdmxLTXlSN2FZNDdiZEZ1a0JNaDl5WnlRKzZEazVV?=
 =?utf-8?B?RzNXVTQrSVVkNFYyNlAzZVd1U2s2UFdhSjllRzQ2U1RXRlNJYjlyVU4zL3Zz?=
 =?utf-8?B?SHA2djlCWTdQNElVNDB5dDJPZ1hFZEUxcTNLZWFBOFFUb2F4bVA4OENTRFR6?=
 =?utf-8?B?TUZEeTRuZGNXZ25TS0FLd3hxTVEzaHFVeVB0aUN3dURqR0JEWVhkdjlDVkZN?=
 =?utf-8?B?TlNzUy9qODJ5clNjUVljQWtYVG12aURpVTgyQmh3NVZyVnR1V3RnaklRVEEx?=
 =?utf-8?B?a2JDRjRMVzRvUVo5S0FrQUF5ek5weFdtNWs0aUVwOUVPeXpQYmxQakFlc1JE?=
 =?utf-8?B?bHVoNnJaS3FzWjdqVUNvQ1NaT0YxNlBhdWJ1SjNnenBMRXVVSkUzNEdOdEQ5?=
 =?utf-8?B?ZUxlUFZEeHg1VnQrYzdKWEIvcnU5M2JrbEJVazVidzMzWGdtbmxsUG9NcXBQ?=
 =?utf-8?B?a3BKTVEwSmxGb2NyMHAxN0NQNXVRR0psdVRaanphbnE0NFBPQWRBcm0rRGtU?=
 =?utf-8?B?NVNFRWkrbGlOSXN2MnFsbnpSOVJBRU1neVROQVZCRUVCcXNRWjBFdjFob2ph?=
 =?utf-8?B?QjFoQU9LaGlnWDQrVnlGTGkzTVdISUp1cVZOQ1BLNUJxZnFrb2JVNnlnK2h6?=
 =?utf-8?B?YnlEOXVVakY3bVR0VmY3YlVGZ1NaazBHclBSeTdvNENyZFdBRFBvN3Y0RU41?=
 =?utf-8?B?T245TnpHQmhPTUc1NXM0R1NLTkg5VDZHa3c3ZERLYy84b01tZ3BWaTRLWEd5?=
 =?utf-8?B?cmc5bVIvM0ZsaitXQm0xN09kT2c0eXdYN2lqVW9YV3Q2OW1BZnhFeU9VbTNH?=
 =?utf-8?B?UWRzQUdjZitiRHl4ejFwMXliWHBtZ3VUMXU1ak8wVTYyMFppTVFVYTFTZXJD?=
 =?utf-8?B?VGJaQjc0VmdYNitTVUlNb2RqR3h3ZEtRdGJzVHhLcnI4dVBsSlh0bXFiVDFZ?=
 =?utf-8?B?WmN4K01XckROQVg0TVEwVjkwbnQxbTBtUUNQdzVHQndZc3hGeGUzSm95c2Rh?=
 =?utf-8?B?a2VMaDFqL2VTQTA5TVF4MU54SEppdlVKTVlPQVBRWFNLTURhZDFlRit1anp1?=
 =?utf-8?B?b1VhTlEvQWlHbk0yS0plSGJCeGpNNXBlY3Nqam1CMEFsQXVxYmk1OEdqZWVi?=
 =?utf-8?B?VHNKWkZqQ1d6Mm91aHZISlovL2o2UndYNEl3RUZpUmh1a2NDTFU5amlwVXYz?=
 =?utf-8?B?SDMwMDFJdUNYK1FKRVBoeUFYSGswTjA2alB1d0s1dnZRVms0V3ZpL1VYK0V1?=
 =?utf-8?B?MEQxUDdoK2RoVk81bW5GWWN2ZFlsY0V4OVlmMjRUWWNQakhKZzJIVXNKZE1Z?=
 =?utf-8?B?M0g4OEtIVnd1VWFTMlVyc0pGbkphVkNJUmk5dkZ1VDExSER6YUpYd2EwcEM1?=
 =?utf-8?B?VXBlS29hSUdjUHVnOXhId2I4NmRYMmtyL2NGamhmL3d3RUd0bkVUd2pkeVFZ?=
 =?utf-8?B?dTY4Nk1SV1JxNDVML2NLMDhHc1ErTGlyLy9XbzhsUHA4T0ZFd0c0MmxrT0Mx?=
 =?utf-8?B?ZmdVcUo4Qnd1RVdyNlNWaWUrNzBqTXB0RUhwbitYbHVyQytSRGpjbE54bXJ4?=
 =?utf-8?B?S3lVaEJTaVdHRWxFMXR2TStCZGpzeUhrQlorSVV1Y2w4TXg3ZnJUbGx5SVEv?=
 =?utf-8?B?VlRoY3Nremc5UnNjU05rQnUvK01kdmlSR1YydnF2OGhSc1EvYWNHQiszanJE?=
 =?utf-8?B?V3VlWldtM0JtUkpRZitua1dubkN3U3V5TDlER0QyMDdFVFRYaFJiVC9hS3NE?=
 =?utf-8?B?c1BmNnJtV1o3Uk5lSGpRNXBsV0h0U3M3ek5tRzRZaUx6S0RSRGN1WXdGbEhG?=
 =?utf-8?B?bGZBL0lkOGs1UkhjN0lWTDNsUlFMOVVieVlGTWoxYWNDQlgzTEtsV0p5b1NI?=
 =?utf-8?B?SzYwc0dHeUQ4Z24yZUl4SmhzbWo4MWdIOE1pSUt0WHNpdGJLOG9PaWE1ZFNP?=
 =?utf-8?B?TTRPNDFGWGQ3WUJtSWZPbThkQ0hKWDYyVEM0MllFWGt0Q0N0bnhDajBYakdr?=
 =?utf-8?B?djhySEEzOUptOXd2cWVWZjVwbGxrTkVhYk5DcWJyclF1WkhTMHpOM0ZWWlNI?=
 =?utf-8?Q?B9ztfltPJkqDoyEm3zJ3wsk+W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3261cdb0-7c89-4165-9fa9-08dd08b13e51
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 15:45:50.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7gUAr44U65J8qyDDR4+wBPynp0seAsBOHOzFJeMd3d1n7EtqjMZBPXGUJmUzGxpnTnww2vMmwCi1YM3ypogcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819

On 11/17/2024 20:55, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The pci-ps module now must have `SND_SOC_ACPI_AMD_MATCH` selected
> to reference the `snd_soc_acpi_amd_acp63_sdw_machines` symbol.
> 
> Fixes: 56d540befd59 ("ASoC: amd: ps: add soundwire machines for acp6.3 platform")
> Cc: Vijendar.Mukunda@amd.com
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411180658.mIeWje2V-lkp@intel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

LKP robot reported again, so one more tag to add.

Closes: 
https://lore.kernel.org/oe-kbuild-all/202411191418.xjxcQBNJ-lkp@intel.com/

> ---
>   sound/soc/amd/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index 6dec44f516c13..c7590d4989bba 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -163,6 +163,7 @@ config SND_SOC_AMD_SOUNDWIRE
>   config SND_SOC_AMD_PS
>           tristate "AMD Audio Coprocessor-v6.3 Pink Sardine support"
>   	select SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
> +	select SND_SOC_ACPI_AMD_MATCH
>           depends on X86 && PCI && ACPI
>           help
>             This option enables Audio Coprocessor i.e ACP v6.3 support on


