Return-Path: <linux-kernel+bounces-449046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA1B9F48F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8014E1624AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C6F1E32A0;
	Tue, 17 Dec 2024 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qpahYA3U"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818991DF965;
	Tue, 17 Dec 2024 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431696; cv=fail; b=b+qnSB5zQKxhvlf9lmoCCoHk+UrwYqrF+bLtzUoGJ+t9qTOatAN89fhRR4swtcVWaYs/8ygKPjd6kplI7iV5VvGAwaMdSU0zNv0Zw0BXQAnIirwQ1FVuuIPY7Bl5OXCA69xkn6YKnVc/hm3AgF/ZucBke/S9GQORgJAfqfMx2TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431696; c=relaxed/simple;
	bh=XNs4tJ/XSTnzkJffoWaIUCx0/o/10SwV0EjIv94Uabg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=utVfzwE1Rkk1AgrrOvkBo7MMwn9mXZ7WSk9TFV/rRZg8L597mS2YF9EGEYnsLmihb/cLTF+c20bZgyhYWPJ29MwQ+HEqbA5kHlWT1d/KWA4GrjRp5pO9G67bMrKoKqWEPCoUufeDwpOgCrFLF+0ytF9iUAf5EUwbmPQ79zhoUYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qpahYA3U; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYPywgD0Ii8yOWdBe+PVazNimlGfZjLVeW4WXnjFubHezfeeww5hLDwpQWryFOT0Qq7eBmKziYS7gSf0BDnmoK8R5LlfRBUe/wNyQhb2wlD8jPbLbockWMgWoerpdpXIjGVTQQqm27CVFiGQ9pvYxA0G6YPhTYfTsu0fBZN3yXyERV/bl5QAHm5iQmBegeRnw8lH/BRR1G3MtwPUJOPNhP+yKa4VBB3HOu623sDXtNY9RlT4fT+eLIDwxm1Wwb+x/oYrAkZB5kkKmF7D9p1lhxFU1B4VuaG7J3a6zwVNx0px0GPZOZEeVl16RzTxpkbIuqI1IcS1Cu7ROwCX7R5+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebaSw/e/hJmvfPAIfBvzIXnMg5uZXGxZ83nIquny6EI=;
 b=T4TvHlkNbW8puChWxsUtjlUu+t6eLElw/p3KN4RUo2NGU/2xMe3NWvKV4+lMdz390kmtKePvVJ+8A51+wB3csVfvbLTKICeKphJvnFWIbK7upX98306kFMmyVNZJSGEDyKudDmZL+g9IHlIixrUwf+J7KKBvFoB5nFOR1JeEDIn3YwY9RFiYCzKTADKPz/5jZ7kaVSSGqH8gpKzpHOBZC+1ezIvAaEOfdNH68WgShgbtmNXIFwf+e8stKMMGd6K4nKwZnhRg1D9IFEhqhOqIch79Ijk51V3ZZdJ7Te8G7ZljeS0EUMxV2XGlNDViwYheA7Y+1oiEN+V9W0JK8kItNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebaSw/e/hJmvfPAIfBvzIXnMg5uZXGxZ83nIquny6EI=;
 b=qpahYA3UacZ+GnN/UoClh2EwKyXqIZ4OYZf7IjyMDq4hBO5N29M2KV32YTLqDgOpSLCR358cGex2R8/G5bwnZokA+HiTvAjmEbQGuDL07Jykjcy3Uwskb5dYvSyLU6k9AraNPJKESN/o5zPgA4INXXtKr2JgUsTUS9hov+XpwRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 10:34:50 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::df88:d99:3cf3:dec0]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::df88:d99:3cf3:dec0%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 10:34:49 +0000
Message-ID: <e5a42dbb-ff8e-486d-ab2c-66798af1fd80@amd.com>
Date: Tue, 17 Dec 2024 16:04:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: amd: yc: Fix the wrong return value
Content-Language: en-US
To: "..." <end.to.start@mail.ru>, Mark Brown <broonie@kernel.org>
Cc: Vijendar.Mukunda@amd.com, mario.limonciello@amd.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 syed.sabakareem@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jiawei Wang <me@jwang.link>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 alsa-devel@alsa-project.org
References: <20241210091026.996860-1-venkataprasad.potturu@amd.com>
 <173384228352.64342.12647978237032666087.b4-ty@kernel.org>
 <1734430927.112015823@f318.i.mail.ru>
From: potturu venkata prasad <venkataprasad.potturu@amd.com>
In-Reply-To: <1734430927.112015823@f318.i.mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::6) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f727d7-4150-426f-bf95-08dd1e866ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTdJRUw4V1pnazcrVkt0TTM0U0RrTWsyVzlFWHFBVE9uZG94aFRsbWJMdG9K?=
 =?utf-8?B?UlJMQVhiZnJ6QWRvYkd2eDRqeUVmR1B1Vk55WFNqbGcySmxKWUgvMy9hd2Yr?=
 =?utf-8?B?MmxhQWpKSWo4WGJwNWswWXVnMTEyV1pYcHVlRzlqam5nYkNIUmRtWVdNUlY1?=
 =?utf-8?B?QUN0VWxXeHIxNVZmdkQwMjZLZ28yVi8xcENwNW5wSzBQb2RueEo1R2tYS1c2?=
 =?utf-8?B?djdSb3B1U2ZkSUpkWmlmalNWSWVzaWlDMFZjbVE5ODhwTHNid3pHSWJUaVRY?=
 =?utf-8?B?OXg2K2dGekU5bHM1WmoxYWYrR3RmMTV3WGVtVzZ6bC9tM0g3OUF0Um8xekVk?=
 =?utf-8?B?eXVDQkZaUVU4U2ZaUzJNVHR2L2lzM1U5cWJ5YTBwcFdrN05YM1Ird1VpZlYy?=
 =?utf-8?B?a2NVVFQwcTB4UVVCaWEvcUl6SmhOUmpXWFN3cFAyU2tRQ2RLYmgzN3JBbTNl?=
 =?utf-8?B?RU5ybmg4Z0IrL0x5bDVTVlk4WloyTldFOTFqQTZwK0krNUFjR0J3cFFIZjdw?=
 =?utf-8?B?R3lsUWg3eXg1NDdYK0xITTE2SlNFVmR3dUljaTgvdDkyQlRVbFNCaXdHeWRt?=
 =?utf-8?B?ZkV2SnNrd3h4THdEdW41ZnNlYjByRHR6YjBGV1BwcDRxWm85dFdWcVRjMSs3?=
 =?utf-8?B?NWdCa1AzRWZyd29OdGlTeFFyWVovRnhwSis2dEpTV2RGZnZoTWV2R2I0Q0p2?=
 =?utf-8?B?T2x0WEd1V3FPN1FVL29WRENpVkZDSnNHSnJoSkZ3Rm5Xa0Z4NVQ0dEt0ai9C?=
 =?utf-8?B?TWJ0R0lTcldINkk2aCtpdldob25hbk90TG11YkJLSVVmOFVMc3lwN3RxNy81?=
 =?utf-8?B?WnhSaDVUclhwaFVtUEZLdWFSTmRoc3hoKzdib2NwZi95RmtiUWt4WEsxUkZ2?=
 =?utf-8?B?SHArNlJmdTArM21pa2VTZXNjaStCWmgvYTBDUHhFNVVwR0U0UXhqaG1HcWIx?=
 =?utf-8?B?NXhuZmg1SXZ0ZDNBVU1TMUI3eWl1clAvWmF2b2RRZTFXWGUyYjNsWitsVU9W?=
 =?utf-8?B?dVVUTmMvUmVjbThLaHQxbWI3LytNbDcyWW5lR2NVMk1jQkZoaW1oeUhHQVRH?=
 =?utf-8?B?U0w2VFp5QkFROEh1bEV5YUxPSDBIOXNkWk16dU5CZGNyZEthczBqMHBVOXZh?=
 =?utf-8?B?blJRMzRNOEROOEdhQzNjQnNQZEVwT1lRNXMyM0F3N1pvRWs1OGVJOHRkVVhV?=
 =?utf-8?B?d0Y0QUlPL0dYQ2JZV3hrOS9xbDJ6MllmaSs0ZkNFNXI4blB0dHk4VVcxcGsy?=
 =?utf-8?B?bFloVjVMblBudUQxSTNiR21DZG9OT1ZYZzF1YzluNm9ML3BrWVlUa3p5MXpo?=
 =?utf-8?B?bjloQnp0WGhZVnNseSttK1pZS3ZrSVI5Z2FUT3E4Mm1wSHRCWDN5QnJSSXFD?=
 =?utf-8?B?b2cxdEk1RlovNkN2MTlxWXBhdCtZN2tpamZmMzkwME5WWnQ2OExRamhWWWJG?=
 =?utf-8?B?T1FLNFFodnoxNmV1VTJQRHFkbU1sNTJTaHU2cDRVSVRsRUY2SEt0MUJaM1JG?=
 =?utf-8?B?RTJnUDE5emVjcG5zcW50cHRNOEt2RVk0NTRRZEZtSkVZMmRxWjFKRzdUM1N6?=
 =?utf-8?B?RnB0cVdwbUNYZytCSWZzeVBjUzBRQUtCTlVFTkFhU1ozTVpKNEtQUTlUUWN1?=
 =?utf-8?B?ZHZKTHMxRnpESUgybUFEQjF5WUNEZ3dGNDd4S1VORmJzN3hhdVNlT2xKeDBW?=
 =?utf-8?B?ajVqL2FjWnRINUF2RzE3NUNWQWNVcXpJTXR0dm1ET0J5cjkxKy8rU1FzOGwv?=
 =?utf-8?B?WGgvQUxNMkVOak9qSDNPSWlIUGtDS3RRRDRzaUpPcU9wZGx3ckJlZktPR2tr?=
 =?utf-8?B?OEVoN2hRKytoTEUvNFc3NWI0V3YxaHJjaStsZGxnZytQamhGMDJhNjEwWkFI?=
 =?utf-8?Q?edGWCZqsuH3cL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2UyNEcwa1o2K1cyQUp3K0VaSEc0UjY3R2djNzExL29vVnIza1RvaVd5anBX?=
 =?utf-8?B?RHZBY0lqUmpHWUFiWE0wUStkdkxuODFhSnBWQ2t5N2pxMWZoQittUm9mM1Qy?=
 =?utf-8?B?MmFwanNsVnF4bVdvM3QzSE85TVFpaWZVWkw5VitMMnRoeGVFWEl1cisrMEgx?=
 =?utf-8?B?ZVVQYUdibGF2Z21KSFZLa2lkNERDVldJVDd0WXhYL3FGVGhzZk0vci9xZXlr?=
 =?utf-8?B?eTdzSzVrSU52SkhMUXIvMS9kTVZNbHdtSG9vY1E1TEpYekpIZHRHT0VJcm1W?=
 =?utf-8?B?RlR4YUhyVHo5L2ZNT1RTSEhFOTJpVE0zUUUvVStsZUhKQzNFTWxSK2xJaUh0?=
 =?utf-8?B?N1UwemVHWkEzTXZJSE96NVoxazRqSlE2L1ovOGNlRnpyb2NqcVZwS3JlOW9E?=
 =?utf-8?B?MjRvWjV6dGROTjJiOVhFaEZmMWluMW1XajRXTDBJMjlNUzRVWEE2cUVuekh5?=
 =?utf-8?B?OFpIM1hqR3RJZlZyVEMrTDdMUC91MjR3TEsxMmFDR0xPdUZoMmlERUZDZG5P?=
 =?utf-8?B?eDRiNzVtdTg2ZDdsM3h3NW1FUWJ4cmZzM3UwVkxxZDlialpjSEY2SFcwQmEy?=
 =?utf-8?B?bWdBT3BPWlp6WkVwdDRxNW5iRXUxL2RRV3NjMDB4T2QvZHZCZk51OUI1dXNa?=
 =?utf-8?B?MDBZTGtnN001cGFrUFovSk9sdkNHOGlZampNaURHNkpEandRbjBWVUQyb0xh?=
 =?utf-8?B?bk5xRDgvcUM5dlh2QXZqMFdWa3E4ZEoybFJDS3NqaCt2NWw3c1V2QzVGbGxF?=
 =?utf-8?B?OXdjTjJVNjlGd2tiZXRmTUVUd3ZQeE1BSE5aa0QzZ1NKYllHWkFDZDhRZkh1?=
 =?utf-8?B?YmJ3K1pjNnR2ajd2ZHptenhJYTEwbGpCbXFiUXdwK2l3bk5EdTJTdlRvNmVu?=
 =?utf-8?B?QTVjcWtGZlpYZEVmOG5PbEpSTiswbTh3bHZITTEwSktneEt3R3dRUUdnbWtR?=
 =?utf-8?B?dGZtZUtJZnR5Yzd5V1NpaWZGZnpHUEFLdEdiVCtaZCt6SGRINnMvUmpwTjlq?=
 =?utf-8?B?KzA3aGk4T3JremRiMXA4RWxyQXZQd1h3Qk01S29mS21DOHFlUEFnc01OejZ4?=
 =?utf-8?B?eXZYOW4zWG1MakIxNjEyemU3N1JPdUMzWVZNcVd1WjJnL3lHSGx5WEk4QWdv?=
 =?utf-8?B?OVZlQzZhQ090RHZmUXd4SEwwaDQzeE9nWU9MeFJTRVlFMHFEdm5Vek00OFUx?=
 =?utf-8?B?a2k0RGF3MEVVeGdlc2Z4bk5mV3pzMnAzT2FmMmY1RVZLSFVYSzFIYWVKQkZV?=
 =?utf-8?B?YUR6MGNOMGNuQTIyenIyUEJCZGFRU3puMk1TUEs2N3RSVjlqRGp1QU9hQVU3?=
 =?utf-8?B?MkJaZVY3Yi9ISXpBdWpGWXBta2NnVVlNN0ZZRTZraXFKbFJXVE1tUTFEUDF2?=
 =?utf-8?B?ZGtEdHN4MS9Bc0k0OTg1NVBaNG5VNjZFL1BCVklxYUZQZC8vMFZJU1BXWkto?=
 =?utf-8?B?Y3J0ZEphcTkrbzkrTmhubGhhbnVvVEZYZk5vSVZ1NStyNVJ5UUpDN1ZLQ2la?=
 =?utf-8?B?VDc0YmxiTVZ5aUc5cUdNODB0WC9JMmtPcTJsZ0xjRUpWa24rUmJkSzAvMFY2?=
 =?utf-8?B?U2JpenVlVXdGNlphcWwrTldncVNmMXlZd2h3UnlicGpRY0VpVUtWY25oU28y?=
 =?utf-8?B?cno2QWxRaXd3MHdxSDlqMlFoR2N3ZC93bEtZL0Y3Y2orM1JraFZmL0owTlpE?=
 =?utf-8?B?Rk9YVS9VYkNmU09GWVA0MFBySXBHVmw1c0NkUnNWMW5TMW9xM1NKZXFMejJ2?=
 =?utf-8?B?M1diMTFSMk8zcUhvYVBZNklINURmL3dINGY1dmNTRGVZeC9JWWVUTkpkRWN2?=
 =?utf-8?B?Q1I2YURUSDgxTSs4VGRHdTZrcDNSR1ppb0sxV2RRbW8wbmZPaTFIY2tSZ2Ur?=
 =?utf-8?B?TlZBM3NxZTlQT25CQVRtVmVyWFo0VklIazN3WXFoNytERWJmUlZCTUk1Q3JG?=
 =?utf-8?B?WmgwSTNnNCs0WmJnMU5IZGFaZlVIY1RTTEYvcHdJWVhVZ01rQ3kvR25ubitE?=
 =?utf-8?B?UDQvdkh2QmRjS2V1V3BuOUpUaHVlS2g3RzRHbVBXbENpMzMyK25uMUxhdEc4?=
 =?utf-8?B?alh2UlpIWVBUR3VEdnJlMTJVS0h3eXZER3VmSDNmRStsc0JrUTBmbTVGZGR4?=
 =?utf-8?Q?/EpLLt24WCAdvmEUyLsDWc8r0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f727d7-4150-426f-bf95-08dd1e866ecb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 10:34:49.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnJEZxSmz0mj63+kcWttmctjk34d5dzt7P5icyxJEWf5SmtecRqwsiLi3CPu1lsAXvZM3UNiVcGR2fCQ8A2LIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429

Hi,

On 12/17/24 15:52, ... wrote:
> the patch that has already been added to the kernel breaks the work of 
> acp6x and the microphone no longer works, so far I am looking for the 
> reason in this person's code, but it is obvious that this patch breaks 
> the work of acp6x.
We have tested this patch at our end, it's working fine.
Could you please share the dev_dbg logs.

With this patch if ACPI method read failure then jump to check dmi 
entry, if dmi entries also not found then driver won't register sound 
card it will return -ENODEV.

Could you please share more details on this issue.


