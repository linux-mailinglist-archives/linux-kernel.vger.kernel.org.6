Return-Path: <linux-kernel+bounces-395166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0955F9BB9C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2B31C21F37
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49661C07E5;
	Mon,  4 Nov 2024 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KxXQFgGL"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16593208A7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736210; cv=fail; b=qC0SdMDX54G8WXBf0RC4VxGtCVQ0DwJlotUsOKSVrqS4JcKILisfA63JejEOk/ro6aIIRk0WKZ5aTkD2V8O2es0HTo8mLrLfO+qm6V2Aw1T14snIxYhgPxrRHYx7evBXzQUaRmqBNpk2zqZXehbCwHvZEYfxes30OLlcd5wj/iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736210; c=relaxed/simple;
	bh=cqi8gRsAf+9AabBLPptowzu3O5yGhhM26kWn0eD/1y0=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=YiaR/S8zYyNqpoKqnsL1UbAo7aUrpu8q7W+KXsGvf07GVtmcVAh3nwzdLvZYznPb1U6A4ASZFUiGu6YhvoXTwc846ZlZz7aOMphvnmqPFW1Jj4Ro67+fyiXXyak2g0v6KymtlSZzllG86sr5uroD37ATErVd9qcjpjPltm/LqMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KxXQFgGL; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/4q3w+XbLrbbbDBhhKiHpuTMfSk5e0RgGKWt5X8EE7xeUGQr0yRJ9/40qpDfup7JOj/k/yCYOYgYmDe6x2xR1nGZDtPnga08C15XJuStVKZrU54wmwRd8HvGL76Stm4XR4kYiMGPyIc7+j1dijHp33wfWM1la4NDeOsJ6y9EoLPiGk6NnhnEAYnuzNzbaQ/r6rnZzGLMKt5v//D4SG5+1D1YQdZykvyM+a/pYhXMTN8tcs6tAEGYixo8kh5baK7/lAlXx4ddtgeJPbq0AEk0xcGnK0ciI5t6zpeL5uCAo9MKUZ6ciTeLkX8a992bm+hW/mKCuq7ctjfKDDquPPD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjC+cRYSAAwa9IF5FMjPPh22ALCrlFoPh4yKqPlsW8o=;
 b=dUxx9Dg78MBZe2VWG/jzQ44/oOMPdIvblWIy/3GVUXQotPiv0dFD+3JErk4S2qro/O0nNZsCb7OY/L1uOc3P2CS0NjmldLlWpvb+NJdWUQsa9Y4csSQmqvkO1Z+5I1GvNN9iWAFqoPFKWLMDSJFzKvZFmPS+ZddgBxbmiEALF7bEiQe2NmY/pt2AjcQ39cxABsQb+9tYLXL29qPhT+C/slcnX3e7QvoULP0yDl1dhHntcmmmcj8XR08z5yeS+Y3eCRv7HWZFbqChmlIOvNKtmWp06JCJYJj4B7hYStpWdTxPwQWrfgeyJ2ER0gJTvlrZ8Of1cpNgRhrp2Uvfhld3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjC+cRYSAAwa9IF5FMjPPh22ALCrlFoPh4yKqPlsW8o=;
 b=KxXQFgGL/OA9b9HKta/VAzQIONTxjTyvznPHM7KBePHawehC6oLvDl3XWNe+ypv8pnW3ImwXxgUahWeTTR0Br7MLkXYAN4Y2/yXHgMFdk/ZKEb9Z8ltfd1vCJrIj9Y0I6xXFLz4ni490pem1fHyNu5kFmnzaUYdEkIMt3HVpb7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 16:03:24 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 16:03:24 +0000
Message-ID: <79be2e29-6487-dd60-9b6f-3daa48a2e93f@amd.com>
Date: Mon, 4 Nov 2024 10:03:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
 <6118c46de2b2260b72dd3ed4421e5e08713fd47a.1730143962.git.thomas.lendacky@amd.com>
 <20241104103353.GQZyijEalUocS_yG5r@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v5 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
In-Reply-To: <20241104103353.GQZyijEalUocS_yG5r@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:806:27::14) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ca8198-cb8e-4251-45e9-08dcfcea3666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3FGN1BBbFJPOWZlOTdzQTRSNjUzQldsVk9WWmRTYjJSOGt0ZlVPWjE0RFhF?=
 =?utf-8?B?Y3hQZTQ4a3VpcUtFcUdkQXd5YVFMOXdzY2JlSmQwVW83cHp0Z0dWOWJ3RXh0?=
 =?utf-8?B?NnYwcnk3RGlNdGc5QVJ3amNJZVhnaFJEdGxHdzV0bHFab092K1Y3WDhPcjA2?=
 =?utf-8?B?NkdEMTFKWGk3b3VwYkVOaVh4WFYyNVRxNG1BdHpQTGtwUEtGVlZUT21jYjl5?=
 =?utf-8?B?NEdnYUE0Q3F0dVkrTlNsTGUyK3RBREJjN0Z5UzdISWZrK2dJS290dE9vUTVE?=
 =?utf-8?B?dVJzUmdMQmZqZXZ2NEhWTkl3N0E1amxLTHBXa0M4Nm5UU3FyT2RpQVNia0ZW?=
 =?utf-8?B?RXlWc2FJZmNHbUY3K0NGamVoNkhOTHVmQTdNbm5wcnF1ay9tNUdscjhkbTZ1?=
 =?utf-8?B?TW1jVzJqWHZlOWdOcWJxMDl1RUo3bTJZTlNJdlBqZEpnR01ObThFN25hOThW?=
 =?utf-8?B?K3Q1WHloVmErUXNkL25uQTh4VWlwY1VBR0hPM3BhaGIvNi9JOGpENkM2N1o0?=
 =?utf-8?B?SGdITWREMWZhaGNhTFhVNUdtZHEraFlCVW82aDVIamJ2aWtGZGdEaTZaNjkw?=
 =?utf-8?B?U29VeCt6eHA3bkFvNk91T3lCQjJUY1ZKQkwwanVvSE9YSmo3aVZGVFBEckhD?=
 =?utf-8?B?a1JnQ0Z1aEt5azlsYXFlOWpSMXlLdkJoMEpzdm9vSWE1K2x6L05Wd0F4a2k2?=
 =?utf-8?B?RXhoVEVFY013VG9PbE45anhrWWlPUUc3Y3l6V0tnemtCUHNqQVh0aXprc0Mz?=
 =?utf-8?B?RWRBYlBXZi9UL08xMTM2a0pZOEhYelUyT01tUHZyQ0sybkNVRzlSU1kzUkZT?=
 =?utf-8?B?amtIZ1Q0VTZ0RGIrV3ZnZVd1cnREamxDZkZ1QTEvTDVudzhFRkhubjJvNzJR?=
 =?utf-8?B?OUV5R1ZQVm9oNmIxRUkrVlU3NGx2MjhvWGFEbFMxbXczYTZ0cnA0MlF1QnhX?=
 =?utf-8?B?dGRILzQ1STZJQWRGUGVkQlV3Z2xQLzJNVHFNa3VmaENML1NVRVpoL0ZNRjRW?=
 =?utf-8?B?czk3d0s4T0lHelNsNUJUQ1lNYkIxZTNWSEJpWFJtenVra0xhOCt2U0VoamNB?=
 =?utf-8?B?enJwRDhCUlAvUzA1RmJtREZna05YQTIraXA5NUw2Y2dybmNsd3l4YXphUFJp?=
 =?utf-8?B?U3R0WnBuTnpyVzMyUEJ5TEEzNzFVTXZKZEw0Wi9BdTh1OURmQ0k3a2o3NVVk?=
 =?utf-8?B?aGlibmdaZm8xbVhUN0tpWXdzV2JhVE5PODVITFhNMUtETTl6Y1lXSW5WNXE1?=
 =?utf-8?B?WjFjc1hTbGJHY3krQ2dVQklnaCs4Y1UzZ1BBTk9obWNBUUxhcmE1ZS9UenF0?=
 =?utf-8?B?KzM4Q3lEbkRNb3ZZSUpYZ1E2d1R4UUdLcFkxUm52WjVSeHR5RFhvd0lLdzhv?=
 =?utf-8?B?Nm10T25pN2tmSUtPRmdndCtGQnZBUEt3cnNEMDdSTkY3MHdjYzJFd3lHV3pZ?=
 =?utf-8?B?eDdNSUduaGt0MGtrZGk3NVEyMXp2NGRuM0ZNYi9vYTliUU1GZU9kdCtkQVUw?=
 =?utf-8?B?a2VpTXhXV2lJcnM2WTc5ZGR4dWttS24xcDRSdDJXVjJWWjc4eXE1MTRJVGpQ?=
 =?utf-8?B?TGJtTXp4aGVUTlNVQU9veHFkMmdtdUVJNDFiK21DYnN4VkREYUFuTzdaU0Ux?=
 =?utf-8?B?OUZ2NXNLWXBIcER6aTArN1h2SHBsT0V1TzNEMmxWcGhtMTVjR1c4a2pHbFRa?=
 =?utf-8?B?RmRXUW5wWTlVRWlreU5sVE5UYURIMFN5S1A5K0F0eWMrNFlHNzVIN0lTUmV4?=
 =?utf-8?Q?dw+DGLQ88zQDECCa0Uo477pZ6d0A2/UJKPDYa+8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXI5c3ZlZ2llWjlQWWxlRzVlcjFBaTJSQjVUamJ2dENuSDd0bHhKY3RZSzBR?=
 =?utf-8?B?aWQwYktpcnFLVEdXeVpuM3d6VWlHQk9GbEFTbENZM3Y2Vy8yMVMyeDFzVCtz?=
 =?utf-8?B?QkR0aHVZa3BHVHhxRHVTZlV1bTdDY1FOdEhVdXh1RG5RVGRyODNWVXZuS3F2?=
 =?utf-8?B?Nmo1amE5QUV3REdKdnUyRUVETzhUeGd2Y2pKUmlWM1E2NmpxTEZlbnJqbThi?=
 =?utf-8?B?TGNGM0ZNS2VCcXVYM29OVzZaVTJXVFFINHc1d2x5MU8yODAwYXlPOXdZV2JZ?=
 =?utf-8?B?Ymw1NXZlQ1dpQnNxYWJkbkc5Wnk0cXlkSy95U3dveXhxb2FRcFY1c3Z0bWJw?=
 =?utf-8?B?Wmo5cTZTWmI0SjZoNkxGYkJJak1VeUg4ejRNVysvWTJUUmM4UjV4YVhxV1dR?=
 =?utf-8?B?NW01Z2diYnlwNFlNR1hVR3FaclFWMzYvdnFGZzNjNHNGQkUyZ2hTUnJCQUFx?=
 =?utf-8?B?TTRnRExGdXQxREJnT21GZXl0WFFUb2RXeGRibWJGYUQ1QWtxNUVHdW5zWFVN?=
 =?utf-8?B?eGRlMTJqbTNxaGtuOSs1S2FFbVNNUFVmZXdqRHJRVEIrVEptRFZsS3BmWk15?=
 =?utf-8?B?VVNScWUxSjJJTzdsSWxtNG45MG5CVVJPdERKeUhRa0p3Z3JHRXpGTTNQeW1U?=
 =?utf-8?B?N3RXUE8zSDE5c1AzczZKWkN3dWdRR2JPdFpmamVYWTZzUS9leDF3azlQM0JO?=
 =?utf-8?B?UUFqR3l3bmVHdG40akw2S3NvMzQwRzByQmtaMWdWek9IRzA5NEJDeUdPTmFi?=
 =?utf-8?B?bXZabG15SFV3SXdMVzlXRjVoeXcySW5hRm1udkVyMlQzNUUvVXpLdEp3SmFF?=
 =?utf-8?B?bGpxVU5HVzA2Y0haOURvSkhoY2lUTDdNYlZUeFY2SWJ4aTN5bFBCQ2RUOVQ4?=
 =?utf-8?B?WE0zMVY1ZFd5VU9LRjB4UjVXNUNaQ0QwOFMvdm5NaSt3OVRhTmltZXlmdVVw?=
 =?utf-8?B?RGh3TnhIRGVGQVI2dEhYcnBQTFh4a3pETmplRXAvdkcvNDdzT2poYTRiOEFm?=
 =?utf-8?B?eHNSdGpLdGFIR1kvbHU2bUgrbzVWMEdtaWkyd215aE1HemkxdXBwUW1vNlVE?=
 =?utf-8?B?V2VoaVdqMGg5czJXWGtmeDIrd3d1eExYeVF0TUh5c2VaWkdRc1RWNGRqWDI1?=
 =?utf-8?B?KzY3RS8rQnhPbC9NYVFvTkxTL2Y5eXZuTW1pbDVQZnhhOEI3T3Y1M2h1bXZl?=
 =?utf-8?B?eE94Yldvc2hsVmgvMjJDSjdtbjRkNVhJcFdPeWp1SUpHZTMyYWRnNUNLUDI5?=
 =?utf-8?B?aENUN2pHVjhnSDZlanZ0aVE3SjJDNzBBc1NDL1BsMXBZR0Q0aDdUTTllOHYz?=
 =?utf-8?B?M0l3ek1SeTJpSit4Q2JHd0lMMCtGNWVBZCs5SEVqcnMyM1VBVldDcVRncmNu?=
 =?utf-8?B?YU5TYWR3TXp4aGs5K0xORVh3U1V6cjZ4MXdWQk01Ull4ZFl4WUZuV0xBVEdH?=
 =?utf-8?B?a1RBK25nQWloc1ZIaGtpdVdKUDZvWXJHRmM5WVdCQ3NwRlk3dXUvdmh3aUxQ?=
 =?utf-8?B?amo3azVjTWlESDgrYlhmT0pXY0VrSUs0RFI5b0dEMlByZ1dFZ0lWUnVTcnFr?=
 =?utf-8?B?R3F5UWIzbUc0ZzBhRURoSklsaXI1Q2Zzd1ArSlN6SXNZNWdzM2lvODdDaG1h?=
 =?utf-8?B?RXFPSVplTVFpVUtFWGgvSlo5c3I1VE9NVm9oMkRReEZZbHp3c05TNU1xdkgz?=
 =?utf-8?B?RFQwSVV4YWJGRzRoSy8zV0xEbEhHK0o5czdHNzNoWFBJTjhGNW83My9qUE4r?=
 =?utf-8?B?NkRRVTlzUlpBdms0TjhnTUhaOFE2dUZFM2R3ZlR3djdtbFJFWUdwamtENkJL?=
 =?utf-8?B?LzFiNFhkNHRSR0d1R0hsZ29BV1V1NGZYRjY4K25oVzFGNWVoUlFzSEdLV3RE?=
 =?utf-8?B?eDQ4dGdZVit2WjVXZ1kzemYzK0Y5MkVMT2Q0c1UxUDAzWDFHaVZrRWtFNGJv?=
 =?utf-8?B?UVRlMTdOM0twUGtkWHpPNndZMTJVNkordEpqaURWNHNyR3B6WnJQUTFoNmQ3?=
 =?utf-8?B?dEllUEk3dEhJLzVCeDJXUUJ3cERtanZEeDllbGR1NTZtTG1yS3JCR1pzQ0h3?=
 =?utf-8?B?QzR6UDRuRW1Zb0x3c0tzSlZyaW1UbXRkbG9CQ25HSkM2Zjd0T2VRb0ZmclM5?=
 =?utf-8?Q?p+Ddr7eFeGUyneMSzFG+4xFRR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ca8198-cb8e-4251-45e9-08dcfcea3666
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 16:03:24.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWH+hg2OH2F8DdClxXkCMccQHS5etNpm/vnLjV6RZ4B0jYgddANrzxYTKbDtc9zr5HdsqxHha95BK+FmhybVPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571

On 11/4/24 04:33, Borislav Petkov wrote:
> On Mon, Oct 28, 2024 at 02:32:41PM -0500, Tom Lendacky wrote:
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 5871c924c0b2..37ff4f98e8d1 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/cpumask.h>
>>  #include <linux/iommu.h>
>>  #include <linux/amd-iommu.h>
>> +#include <linux/nospec.h>
> 
> What's that include for?
> 
> For array_index_nospec() below?
> 
> It builds without it or did you trigger a build error with some funky .config?

But the define is in linux/nospec.h, so I might only be a side effect of
another include.

> 
>>  #include <asm/sev.h>
>>  #include <asm/processor.h>
>> @@ -77,12 +78,42 @@ struct rmpentry_raw {
>>   */
>>  #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
>>  
>> +/*
>> + * For a non-segmented RMP table, use the maximum physical addressing as the
>> + * segment size in order to always arrive at index 0 in the table.
>> + */
>> +#define RMPTABLE_NON_SEGMENTED_SHIFT	52
>> +
>> +struct rmp_segment_desc {
>> +	struct rmpentry_raw *rmp_entry;
>> +	u64 max_index;
>> +	u64 size;
>> +};
>> +
>> +/*
>> + * Segmented RMP Table support.
>> + *   - The segment size is used for two purposes:
>> + *     - Identify the amount of memory covered by an RMP segment
>> + *     - Quickly locate an RMP segment table entry for a physical address
>> + *
>> + *   - The RMP segment table contains pointers to an RMP table that covers
>> + *     a specific portion of memory. There can be up to 512 8-byte entries,
>> + *     one pages worth.
>> + */
>> +static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
>> +static unsigned int rst_max_index __ro_after_init = 512;
>> +
>> +static u64 rmp_segment_size_max;
> 
> This one is used in a single function. Generate it there pls.

It's used in two functions, alloc_rmp_segment_desc() and
set_rmp_segment_info().

> 
>> +static unsigned int rmp_segment_coverage_shift;
>> +static u64 rmp_segment_coverage_size;
>> +static u64 rmp_segment_coverage_mask;
> 
> That "_coverage_" in there looks redundant to me and could go and make those
> variables shorter.

Sure, I can remove the _coverage_ portion.

> 
>> +#define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
>> +#define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_coverage_mask)))
>> +
>>  /* Mask to apply to a PFN to get the first PFN of a 2MB page */
>>  #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
>>  
>>  static u64 probed_rmp_base, probed_rmp_size;
>> -static struct rmpentry_raw *rmptable __ro_after_init;
>> -static u64 rmptable_max_pfn __ro_after_init;
>>  
>>  static LIST_HEAD(snp_leaked_pages_list);
>>  static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
>> @@ -190,6 +221,92 @@ static bool __init init_rmptable_bookkeeping(void)
>>  	return true;
>>  }
>>  
>> +static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
>> +{
>> +	struct rmp_segment_desc *desc;
>> +	void *rmp_segment;
>> +	u64 rst_index;
>> +
>> +	/* Validate the RMP segment size */
>> +	if (segment_size > rmp_segment_size_max) {
>> +		pr_err("Invalid RMP size (%#llx) for configured segment size (%#llx)\n",
>> +		       segment_size, rmp_segment_size_max);
>> +		return false;
>> +	}
>> +
>> +	/* Validate the RMP segment table index */
>> +	rst_index = RST_ENTRY_INDEX(pa);
>> +	if (rst_index >= rst_max_index) {
>> +		pr_err("Invalid RMP segment base address (%#llx) for configured segment size (%#llx)\n",
>> +		       pa, rmp_segment_coverage_size);
>> +		return false;
>> +	}
>> +	rst_index = array_index_nospec(rst_index, rst_max_index);
> 
> Why are we doing this here? Are you expecting some out-of-bounds
> user-controlled values here?
> 
> AFAICT, this is all read from the hw/fw so why are speculative accesses
> a problem?

Yeah, not needed here since this is before userspace has even started.

> 
>> +	if (rmp_segment_table[rst_index]) {
>> +		pr_err("RMP segment descriptor already exists at index %llu\n", rst_index);
>> +		return false;
>> +	}
>> +
>> +	/* Map the RMP entries */
> 
> Kinda obvious...
> 
>> +	rmp_segment = memremap(segment_pa, segment_size, MEMREMAP_WB);
>> +	if (!rmp_segment) {
>> +		pr_err("Failed to map RMP segment addr 0x%llx size 0x%llx\n",
>> +		       segment_pa, segment_size);
>> +		return false;
>> +	}
>> +
>> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> 
> 			sizeof(struct rmp_segment_desc)

Hmmm... I prefer to keep this as sizeof(*desc). If any changes are made
to the structure name, then this line doesn't need to be changed.

> 
> 
>> +	if (!desc) {
>> +		memunmap(rmp_segment);
>> +		return false;
>> +	}
>> +
>> +	desc->rmp_entry = rmp_segment;
>> +	desc->max_index = segment_size / sizeof(*desc->rmp_entry);
>> +	desc->size = segment_size;
>> +
>> +	/* Add the segment descriptor to the table */
>> +	rmp_segment_table[rst_index] = desc;
>> +
>> +	return true;
>> +}
> 
> ...
> 
>> @@ -248,12 +366,20 @@ static int __init snp_rmptable_init(void)
>>  
>>  	/* Zero out the RMP bookkeeping area */
>>  	if (!init_rmptable_bookkeeping()) {
>> -		memunmap(rmptable_start);
>> +		free_rmp_segment_table();
>>  		goto nosnp;
>>  	}
>>  
>>  	/* Zero out the RMP entries */
>> -	memset(rmptable_start, 0, rmptable_size);
>> +	for (i = 0; i < rst_max_index; i++) {
>> +		struct rmp_segment_desc *desc;
>> +
>> +		desc = rmp_segment_table[i];
>> +		if (!desc)
>> +			continue;
>> +
>> +		memset(desc->rmp_entry, 0, desc->size);
>> +	}
> 
> Why isn't this zeroing out part of alloc_rmp_segment_table()?

If the SNP_EN bit is set in the SYSCFG MSR, the code needs to skip the
zeroing of the RMP table since it no longer has write access to the
table (this happens with kexec).

This keeps the code consistent with the prior code as to where the
zeroing occurs. I can add another argument to alloc_rmp_segment_desc()
that tells it whether to clear it or not, if you prefer.

> 
>> @@ -319,13 +458,29 @@ bool snp_probe_rmptable_info(void)
>>  
>>  static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
>>  {
>> -	if (!rmptable)
>> +	struct rmp_segment_desc *desc;
>> +	u64 paddr, rst_index, segment_index;
> 
> Reverse xmas tree order pls.

Right.

> 
>> +	if (!rmp_segment_table)
>>  		return ERR_PTR(-ENODEV);
>>  
>> -	if (unlikely(pfn > rmptable_max_pfn))
>> +	paddr = pfn << PAGE_SHIFT;
>> +
>> +	rst_index = RST_ENTRY_INDEX(paddr);
>> +	if (unlikely(rst_index >= rst_max_index))
>> +		return ERR_PTR(-EFAULT);
>> +	rst_index = array_index_nospec(rst_index, rst_max_index);
> 
> Same question as above.

This is where I was worried about the VMM/guest being able to get into
this routine with a bad PFN value.

This function is invoked from dump_rmpentry(), which can be invoked from:

rmpupdate() - I think this is safe because the adjust_direct_map() will
fail if the PFN isn't valid, before the RMP is accessed.

snp_leak_pages() - I think this is safe because the PFN is based on an
actual allocation.

snp_dump_hva_rmpentry() - This is called from the page fault handler. I
think this invocation is safe for now because because it is only called
if the fault type is an RMP fault type, which implies that the RMP is
involved. But as an external function, there's no guarantee as to the
situation it can be called from in the future.

I can remove it for now if you think it will be safe going forward.

Thanks,
Tom

> 
>> +
>> +	desc = rmp_segment_table[rst_index];
>> +	if (unlikely(!desc))
>>  		return ERR_PTR(-EFAULT);
>>  
>> -	return rmptable + pfn;
>> +	segment_index = RMP_ENTRY_INDEX(paddr);
>> +	if (unlikely(segment_index >= desc->max_index))
>> +		return ERR_PTR(-EFAULT);
>> +	segment_index = array_index_nospec(segment_index, desc->max_index);
>> +
>> +	return desc->rmp_entry + segment_index;
>>  }
> 

