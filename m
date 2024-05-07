Return-Path: <linux-kernel+bounces-171580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E660D8BE5ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152C61C21860
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720315F415;
	Tue,  7 May 2024 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D3ETEDlF"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17C15EFD2;
	Tue,  7 May 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092219; cv=fail; b=A8XmLP5p0b5V0Lf2zPx2ADRLABngCPi18KY+PcmfhjV2lO1dW6rVExw5NUUugkq8ePx7Vuod2MHIdPOYp0+MAY+G7/7R6cXNa1Z8rXw4qP9BWcCJbFuZELZYKnCTOfy+7215O7v3TVx3IRb/Snedq24iQefgAuBuBTVriuENiQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092219; c=relaxed/simple;
	bh=USmL7DWlVA7O2h1kPDiL6GE9gwHJvvtTyIb6SAtGCnM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gcaWBJCuEwMzmnVL4pqgyI4H6K3/83jET2ByWn2aj34lR/UmBVYW3iwkBgk61hWha+iqvC1ZQMPk4PC8BflU/JUrwD3/VcXit0cKiOQWNNqfh2hh2EQUJYaDTgEWDvlwR4mHYgHF732VGl9KsVkwFQ8CPtsqGKZ/vxtyOQ/0JKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D3ETEDlF; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrWT6gi41kWWmcxjOF+8VtlkyhuuStj+hCACPRwiXmCg97LxdMt9XRwj5y7rC/RjKdaOa/hHNZ85X3vK97cl9JNx7s1Q5GS2sMW28Cv4RXPvOTPoseI0UJSI0+UW2usrr+scO0r1zUdHuEpgB/8TneQabvxxpT1cWAEWtLIYaX5FK3YuDyAKDfQkoYDBFnFIvAUBh5Yx/PLOajYElxgpUUJ/3QrcX+pTrOAlQqTq38WFRumhbR7N/JToNMYA6RcZRXhCwNCS8x/hnvbgimAPI0Plve8+/89faz2yekQM3JY4+xvhqHiJvA/XZsnI1ETpGGrWxvxOot7B/VldOnHOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx4TcrXk7dtN/r1KaW1uT8ANm7/7ENlnW9/+2XWFZ/Q=;
 b=iuPoLeq4Xd+cXOBhFRb7RSUrcFExcCDTXkrx2HNDSgWRmQcAwFGQJawqAEXhLmPC9dtpC/OH7K9ovhHddFJUNuUg+Sjfb2N8hWSa8p/B/98NwmZ/2+rgjcHSvh743nC4dh9SBE+Yhkf7LkNy4MznMpNK0HmrK1KJHqkJdI0tXisnoLg9H/qQJdDcmQCeTruOE5JgyDnZHSSV8uy2BzHR1obUCdXtaV8B4gFouadftR78YiinOPTpB3jAYymhC0pvJJPzBSIB1hWdOuup2+Cz615PMcGhh4etbuAiih2NTP1Zrq0832LnU4LjDXZCHdvdTy24qyCk00Pc8tuXk3zwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx4TcrXk7dtN/r1KaW1uT8ANm7/7ENlnW9/+2XWFZ/Q=;
 b=D3ETEDlFHdBte7UKJuzTNzcjsEedhCBpzcxgKErCt2huvmDHZJUHv4P3xrCOjBCzkkTF41LynWJDSkdFxTya/uwvv4UTTjS3uVoAvvg7YgbFbzwv3ZeCs4B6bnkp8qF4WUK4NopoQVMFpB0tRQ8JPsn7Pqy59pq7ypIcE6mG7qQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 14:30:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:30:07 +0000
Message-ID: <0595e183-e724-4162-902e-298bf41b09ed@amd.com>
Date: Tue, 7 May 2024 09:30:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hwmon: add ChromeOS EC driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev,
 Dustin Howett <dustin@howett.net>, Moritz Fischer <mdf@kernel.org>
References: <20240507-cros_ec-hwmon-v1-0-2c47c5ce8e85@weissschuh.net>
 <20240507-cros_ec-hwmon-v1-1-2c47c5ce8e85@weissschuh.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240507-cros_ec-hwmon-v1-1-2c47c5ce8e85@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b82573-c217-4125-a836-08dc6ea23153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmU5WTduUVZrZnMwUFRQZXN3YVRPRjNTbjhqU2lOUUpNRnRNM3NDOExTN0Nn?=
 =?utf-8?B?dDNOS3Z3Rm1Idm1kQ0kwLzFUcUlNcE14aFJCSllwSUlVdUo5MXBjbkt3d3JT?=
 =?utf-8?B?QWV0b2hWMjh6aW9nN3JHaGJHbXVzZW9odXdRa0FNSkZHbC9PM2ZMNUxidEkr?=
 =?utf-8?B?aHN1TEJvYlNpVEdPV0gzMXJUcklMMFlkSE1uUG9ONFM4M0UxOUFYOFN1TElR?=
 =?utf-8?B?Z1pnbnBnZDQ3emJHNytpOGp4blluZUVGWEdxTnczdjVoWEJqN05EZjZXZGJ5?=
 =?utf-8?B?MDJmdHJDQVNPUzNLY1BWaFZSd041S3JzbXN1bVhsQ0hXSkV6Z281MzRod1BZ?=
 =?utf-8?B?RHdJb0NSV2NUbUZudHRYWVMyaEFwR1ZhcGpPNDF4TW5aaUxJYnduTVpMSW16?=
 =?utf-8?B?TlE4aW15aUFka0VETkFPN2hYSjZFT29UL1l3RS9Gbk1RMnJPeDh4YVY4YnEv?=
 =?utf-8?B?ZnZJYk9sWFV4cXVHZG5MdlUxUjI1QVA4T2dodVpJWEVaMVhuVDlYdmp5MGhB?=
 =?utf-8?B?RzRtaFJaMllFS3dBV3VrUXorYk1aZkMzVFQ3NzBHb2tiRGZRMEoyZmhTYVQ5?=
 =?utf-8?B?ZmFyMFUwS1lzazJhRnpoZnVmTFhEWkNTcFY4NGI5em4rSElPNmI1elhqQkhE?=
 =?utf-8?B?dEhwVEhod0pqc0JYRWVjSndIdlcralhJMjczNWJQZm9JeDkzZDBXNDI2WlFT?=
 =?utf-8?B?YUFmTjJRdVEwQWtxdmxZNHp5cFFzODExQWNIelBYcWxuZ0ZNbTVLdVhsU0RL?=
 =?utf-8?B?WTZ1Mi94aGJtYXZmVU9yUm83bEJYV2FnKzBoU0plYXFRYk9QYTdlb2pjUFVx?=
 =?utf-8?B?Mkx3aWhZK1ozOGM2VGVnYTFRZ1VKSVRHU2xRWWhleDVobDUvaU5SSVl2TllU?=
 =?utf-8?B?RGNSS21yS09hTUs3UkVTTlVwdHhXZ0Zia1NKeWpJQ3ZoTVY2aUhvRkswcXQz?=
 =?utf-8?B?N3E3a2hibjlDUXc2Sk9nVGo4UVpvU004eVphTzk3VjhPTERoVmFORlJ3MFZn?=
 =?utf-8?B?Tm9UckdRdkFpWkFVVTFGb1JnRFAxSTJ1aHIydFlWZEhaOEFiSmRmb2JIQ3JZ?=
 =?utf-8?B?Z01Rc2F0dXVLT0Y3b3NKZEJWUVJ2Q21uKzllNmRIaGc5TnhJU2dKNWNieUV4?=
 =?utf-8?B?M3NvbC9Uay81djg1cmdzaFJnektXTzdGdC8yeUN0YmNXaXZON2p6QkNzWXcy?=
 =?utf-8?B?eCtqMWkzd3dBN2hiaDV1Q2dtQkE3dGdoeVBkRitMZlFNYU56NU8xbnZwc0hF?=
 =?utf-8?B?d3JjOGhQMkVRVyt6cUlXMVk3MXdEZHBJK0srVEEvNUlXYXpLdGIzdzFVVGs1?=
 =?utf-8?B?VEkwdFN4MTZEKytFMlB5RTBxVE5QQmZUM0pLK1ZMM0hqeEhRb1hnV1lNRHlp?=
 =?utf-8?B?L212RkE2azZoT3M5VHMxRnBaOU5RU3hHMGx0KzMxZ1dZdDF2aVdCWXU5S2lS?=
 =?utf-8?B?VlpkNmF1YjRhUWJVeGw0QktYcGlpUlVqU0dsc1gyK05TM0E3QSthRzVWMXor?=
 =?utf-8?B?K1JKRHhKWXdwaTRtbTdzVkhVWkFZaGduYTVsaC9JUWV5cGtMSFpRTFRyOUhC?=
 =?utf-8?B?cXFCUkhMYklVM09uR0x5VjBaTkxCTkxiSFQzK1M5aEpkVVU2VmpHUER3SlZz?=
 =?utf-8?B?dloyc3lJcmQ4UTZ1U0h3RmI2eFk1OHpiS3E2Wk00bktkS2pIMmJrUDNrU0x0?=
 =?utf-8?B?N3lML0lndnRRdjZEcTFVSDYyMjg0QjNzcjFKWmZUTUpuSElGeGFtaGhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnhyL2xjeE40bmJibElGeHFKN21ZSUtrb2JIYmxsbUFya0x4dWo4bDJBd1Rm?=
 =?utf-8?B?ZTFNVVdveXVPejdxWEFQWG40UytUOU85YWI2WDZYcFRxRENpVjYzbGZkRGJY?=
 =?utf-8?B?UG00Y09TQ1diMVZWMGlxU2VZbjdJL2s4UW1Ebzg3VlYyWGp6WjhrSWovZXRw?=
 =?utf-8?B?NnFmWGlHSy8yZnRSMit6dEZpa2o4Zm9pWmFzN04walY2UHdOTGF6Mm55Ry9t?=
 =?utf-8?B?bGlETldCRDVBaW9NRVFFcmxYRjQ3V3BQbmg1SG1hZlRSRks1Q0NXTldxM3JL?=
 =?utf-8?B?NFhDZzlIUlhxYUJCMmQwL3NPTk51MTBCa2dFWGhPUFVyeGowM1B3THAvVUxm?=
 =?utf-8?B?YklNTjYvOE5aVlJpTS82UjhtSlVkY1RIRXVqZlQ5cjFkMHBpeWhJSnpiR1hx?=
 =?utf-8?B?TVZrQnNDZlVySWo4TzZJTzl6SjJzSzBsZEFBM0o2VS9tWGpqU25wYStQRC9s?=
 =?utf-8?B?Y3Y5MURvNW0vbFJnWHRXZDFqajBPd2RCTXRCOWs4a0hoQlY2YW91N1piRG0x?=
 =?utf-8?B?SHl0UjZnV21GTjRHSnNBR2FpN1Z3UFhyNTdaamtVZWNWMitPYXBJZ2ZUVWtP?=
 =?utf-8?B?NWtZZlo0alJncjdqbG5USGlWcWZMV1NlenBBSWhQYTRDQlEvckhRU2VxR1lx?=
 =?utf-8?B?UlZKNWVEKzVCQW4wU3diU2paTnVrUkZubG15Mml0eXRjMlFPcXhqNGQ4S2FO?=
 =?utf-8?B?UVM5RXA4Qlp3VS9Vc2Q4Tk1qbGx1MGRCRncwem4rRERwUUJrd0lESVBHRGdJ?=
 =?utf-8?B?M1piajUvTU5MTzFubWIvY3lpanJCcGVFNExFM24rQ2lwcHp5VFh3cE9zcGov?=
 =?utf-8?B?Uk5lM1pzSi8wbVpLQVZYMTVTVU1rd0tzQU1rekRWT09tSDZRd1I1NUtEZmFr?=
 =?utf-8?B?RDFESW9RdEl6Q3J3NXRjNW5Bd2hwVjY2VXRBR281Q1lmLy90aisrL3FvWHpC?=
 =?utf-8?B?VHdRZGpFaXFCc0pra0dCUkpqcmdWRnJpc0N1ZGlreXlvN3NtT1kvelBuejhD?=
 =?utf-8?B?ajkvRU85akpTT2huR0Z4d0dwSHEweHJZanlQcHRQS2lianpmNWtHN2diUTdD?=
 =?utf-8?B?RG82SVEydjg5NXJWSGVBcGpEZFBCNG1idmVGZVdDeHNXRHA3WDVwRzZhR1Bh?=
 =?utf-8?B?aHhlOTkwWUdDTFBEWjQ2QWlLaG1sM3ExR3Fyb1FnelF3NVZQbDlvclFMZjE5?=
 =?utf-8?B?WVJNaEVyaEFIUHQxb3h5TldyV0ZDNWkxWlo1YVovaEVadXlEOFBNcHZ6Q2tR?=
 =?utf-8?B?NWthR3hqUG45Q0U5a0NBdmlUQi96TkFYekpIRDdmNitacnFjMk85dThTeXd2?=
 =?utf-8?B?MTJlQ3ZNVU5PZk9BZmJraWJlMHFNUXUxVU5WY09HT2VIMVJQdFhxTjJXeWRL?=
 =?utf-8?B?b0FxWFJ5ZlB5eHlSMC9tUmNWL08vK29neWNrYTZIalpzdDdaRFFqalJzdWVr?=
 =?utf-8?B?dTVxZExJZ2JuVHVzcitVZkRCdHdaTHljd3ZyVFhJQXY1RkU3eHVIbS9UWEZr?=
 =?utf-8?B?YzVIaDcwdzlKSnI1SXpuNHFzRmdBUDMyanFyVVRVR2R1YlJydTlOR1ZDaDl1?=
 =?utf-8?B?SG0yL3RQRHJlZlBvaEFKblJwSURiblR0MmJuam5wTFI3ZTFyVnFGRmVFcktj?=
 =?utf-8?B?M0w0d3dtM1Rtb0VqeERHQmpMb3JWMWhGL3B5aVBLRlE4eERvSWFXK2ZIQmpF?=
 =?utf-8?B?M3hTdXI3ckpQYjRCWCtONUNwWkY4RkF4ZWtRMnB6VGZ1Rm9qYmVFbjNyTFRo?=
 =?utf-8?B?OUxudVJtUEZ6SVRaNitqTTJKc3RwNTRuaUp0amxhVEdHcHAzWnZRVFp0WHBv?=
 =?utf-8?B?YkhZZS9ZWU82MmczcDRvcWJET2FHN2lrR3dZREVVbDczU0dQMVA2L3VYNkFU?=
 =?utf-8?B?VDA4bUxsdnVDVU1GUkIrSHhJbUIzZnB3b1RQdGw4MmhrVFJURU1BYXhLKzVV?=
 =?utf-8?B?MXhDVjhqRUY5aUR6UitkeUM3b2JQL3BUUlZvZzJtQ1prV01yYzhoa0dGSFU5?=
 =?utf-8?B?eGZ5MHZXSG9EZFRncFNDT0NPZDB0a1RUbmR2ajdmQkZmbDFDMm5GdUZOYThB?=
 =?utf-8?B?VW9tOFZFQjZxU0hPbHlkcm9aMDFyWSs2ZFI4QW1OZlV3UTdFNlVILzNubWh1?=
 =?utf-8?Q?e6xJGOQkMOFwxwx75TkknMOHi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b82573-c217-4125-a836-08dc6ea23153
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:30:07.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkmKmlVsi8Q7J8UAAQh0LAoQTLS/RwEmWTQ7xB6btDH8+8IMV4jHXzRK1UDA+9+OTjLa9p9t/Bg9GI3nmb5rTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307

On 5/7/2024 08:57, Thomas Weißschuh wrote:
> The ChromeOS Embedded Controller exposes fan speed and temperature
> readings.
> Expose this data through the hwmon subsystem.
> 
> The driver is designed to be probed via the cros_ec mfd device.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
>   Documentation/hwmon/index.rst         |   1 +
>   MAINTAINERS                           |   8 +
>   drivers/hwmon/Kconfig                 |  11 ++
>   drivers/hwmon/Makefile                |   1 +
>   drivers/hwmon/cros_ec_hwmon.c         | 279 ++++++++++++++++++++++++++++++++++
>   6 files changed, 326 insertions(+)
> 
> diff --git a/Documentation/hwmon/cros_ec_hwmon.rst b/Documentation/hwmon/cros_ec_hwmon.rst
> new file mode 100644
> index 000000000000..aeb88c79d11b
> --- /dev/null
> +++ b/Documentation/hwmon/cros_ec_hwmon.rst
> @@ -0,0 +1,26 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver cros_ec_hwmon
> +===========================
> +
> +Supported chips:
> +
> +  * ChromeOS embedded controllers connected via LPC
> +
> +    Prefix: 'cros_ec'
> +
> +    Addresses scanned: -
> +
> +Author:
> +
> +  - Thomas Weißschuh <linux@weissschuh.net>
> +
> +Description
> +-----------
> +
> +This driver implements support for hardware monitoring commands exposed by the
> +ChromeOS embedded controller used in Chromebooks and other devices.
> +
> +The channel labels exposed via hwmon are retrieved from the EC itself.
> +
> +Fan and temperature readings are supported.
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 1ca7a4fe1f8f..355a83e66928 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -57,6 +57,7 @@ Hardware Monitoring Kernel Drivers
>      coretemp
>      corsair-cpro
>      corsair-psu
> +   cros_ec_hwmon
>      da9052
>      da9055
>      dell-smm-hwmon
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c23fda1aa1f0..aa5689169eca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4988,6 +4988,14 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
>   F:	sound/soc/codecs/cros_ec_codec.*
>   
> +CHROMEOS EC HARDWARE MONITORING
> +M:	Thomas Weißschuh <thomas@weissschuh.net>
> +L:	chrome-platform@lists.linux.dev
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/chros_ec_hwmon.rst
> +F:	drivers/hwmon/cros_ec_hwmon.c
> +
>   CHROMEOS EC SUBDRIVERS
>   M:	Benson Leung <bleung@chromium.org>
>   R:	Guenter Roeck <groeck@chromium.org>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 83945397b6eb..c1284d42697f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -506,6 +506,17 @@ config SENSORS_CORSAIR_PSU
>   	  This driver can also be built as a module. If so, the module
>   	  will be called corsair-psu.
>   
> +config SENSORS_CROS_EC
> +	tristate "ChromeOS Embedded Controller sensors"
> +	depends on MFD_CROS_EC_DEV
> +	default MFD_CROS_EC_DEV
> +	help
> +	  If you say yes here you get support for ChromeOS Embedded Controller
> +	  sensors.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called cros_ec_hwmon.
> +
>   config SENSORS_DRIVETEMP
>   	tristate "Hard disk drives with temperature sensors"
>   	depends on SCSI && ATA
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 5c31808f6378..8519a6b36c00 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_SENSORS_CHIPCAP2) += chipcap2.o
>   obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
>   obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
>   obj-$(CONFIG_SENSORS_CORSAIR_PSU) += corsair-psu.o
> +obj-$(CONFIG_SENSORS_CROS_EC)	+= cros_ec_hwmon.o
>   obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
>   obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
>   obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> new file mode 100644
> index 000000000000..9588df202a74
> --- /dev/null
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  ChromesOS EC driver for hwmon
> + *
> + *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/units.h>
> +
> +#define DRV_NAME	"cros-ec-hwmon"
> +
> +struct cros_ec_hwmon_priv {
> +	struct cros_ec_device *cros_ec;
> +	u8 thermal_version;
> +	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
> +};
> +
> +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> +{
> +	int ret;
> +	u16 data;
> +
> +	if (index >= EC_FAN_SPEED_ENTRIES)
> +		return -ENODEV;

I could see an argument that this should be -EINVAL as 
EC_FAN_SPEED_ENTRIES is hardcoded in the driver and "index" was passed 
into the function.

> +
> +	ret = cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data = le16_to_cpu(data);
> +
> +	if (data == EC_FAN_SPEED_NOT_PRESENT)
> +		return -ENODEV;
> +
> +	*speed = data;

For safety purposes I think you should either do

if (speed)
	*speed = data;

Or have a check at the start of the function and return -EINVAL and 
throw up a warning if speed was NULL.

> +	return 0;
> +}
> +
> +static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 thermal_version,
> +				   u8 index, u8 *data)
> +{
> +	unsigned int offset;
> +	int ret;
> +
> +	if (thermal_version < 2 && index >= EC_TEMP_SENSOR_ENTRIES)
> +		return -ENODEV;
> +
> +	if (index >= EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES)
> +		return -ENODEV;

Like cros_ec_hwmon_read_fan_speed I have an opinion these should be -EINVAL.

> +
> +	if (index < EC_TEMP_SENSOR_ENTRIES)
> +		offset = EC_MEMMAP_TEMP_SENSOR + index;
> +	else
> +		offset = EC_MEMMAP_TEMP_SENSOR_B + index - EC_TEMP_SENSOR_ENTRIES;
> +
> +	ret = cros_ec->cmd_readmem(cros_ec, offset, 1, data);
> +	if (ret < 0)
> +		return ret;
> +

You should make sure that data isn't NULL before doing these checks:

> +	if (*data == EC_TEMP_SENSOR_NOT_PRESENT ||
> +	    *data == EC_TEMP_SENSOR_ERROR ||
> +	    *data == EC_TEMP_SENSOR_NOT_POWERED ||
> +	    *data == EC_TEMP_SENSOR_NOT_CALIBRATED)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long *val)
> +{
> +	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
> +	u16 speed;
> +	u8 temp;
> +	int ret = -ENODATA;

I feel it is better practice to add this as a 3rd clause than initialize 
the variable at the start of the function.

switch (type) {
case hwmon_fan:
	//do stuff
	break;
case hwmon_temp:
	// dot stuff
	break;
default:
	ret = -ENODATA;
}

return ret;

> +
> +	if (type == hwmon_fan) {
> +		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
> +		if (ret == 0)
> +			*val = speed;
> +	} else if (type == hwmon_temp) {
> +		ret = cros_ec_hwmon_read_temp(priv->cros_ec, priv->thermal_version, channel, &temp);
> +		if (ret == 0)
> +			*val = kelvin_to_millicelsius((((long)temp) + EC_TEMP_SENSOR_OFFSET));
> +	}
> +
> +	return ret;
> +}
> +
> +static int cros_ec_hwmon_get_temp_sensor_info(struct cros_ec_device *cros_ec, u8 id,
> +					      struct ec_response_temp_sensor_get_info *resp)
> +{
> +	int ret;
> +	struct {
> +		struct cros_ec_command msg;
> +		union {
> +			struct ec_params_temp_sensor_get_info req;
> +			struct ec_response_temp_sensor_get_info resp;
> +		} __packed data;
> +	} __packed buf = {
> +		.msg = {
> +			.version = 0,
> +			.command = EC_CMD_TEMP_SENSOR_GET_INFO,
> +			.insize  = sizeof(buf.data.resp),
> +			.outsize = sizeof(buf.data.req),
> +		},
> +		.data.req.id = id,
> +	};
> +
> +	ret = cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	*resp = buf.data.resp;

Make sure that resp isn't NULL.

> +	return 0;
> +}
> +
> +static int cros_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> +				     u32 attr, int channel, const char **str)
> +{
> +	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
> +	int ret = -ENODATA;

How about just drop the variable and then do below two comments:

> +
> +	if (type == hwmon_temp && attr == hwmon_temp_label) {
> +		*str = priv->temp_sensor_names[channel];
> +		ret = 0;
		return 0;
> +	}
> +
> +	return ret;
	return -ENODATA;
> +}
> +
> +static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> +					u32 attr, int channel)
> +{
> +	const struct cros_ec_hwmon_priv *priv = data;
> +	u16 speed;
> +
> +	if (type == hwmon_fan) {
> +		if (cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed) == 0)
> +			return 0444;
> +	} else if (type == hwmon_temp) {
> +		if (priv->temp_sensor_names[channel])
> +			return 0444;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_ops cros_ec_hwmon_ops = {
> +	.read = cros_ec_hwmon_read,
> +	.read_string = cros_ec_hwmon_read_string,
> +	.is_visible = cros_ec_hwmon_is_visible,
> +};
> +
> +static const struct hwmon_chip_info cros_ec_hwmon_chip_info = {
> +	.ops = &cros_ec_hwmon_ops,
> +	.info = cros_ec_hwmon_info,
> +};
> +
> +static int cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct cros_ec_hwmon_priv *priv)
> +{
> +	struct ec_response_temp_sensor_get_info info;
> +	size_t i;
> +	u8 temp;
> +	int ret;
> +
> +	ret = priv->cros_ec->cmd_readmem(priv->cros_ec, EC_MEMMAP_THERMAL_VERSION,
> +					 1, &priv->thermal_version);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!priv->thermal_version)
> +		return 0;

I'm a bit confused; why isn't this -ENODEV?  I would think that you 
don't want to have probe succeed and make devices if there isn't thermal 
support in the EC.

> +
> +	for (i = 0; i < ARRAY_SIZE(priv->temp_sensor_names); i++) {
> +		if (cros_ec_hwmon_read_temp(priv->cros_ec, priv->thermal_version, i, &temp) != 0)
> +			continue;
> +
> +		ret = cros_ec_hwmon_get_temp_sensor_info(priv->cros_ec, i, &info);
> +		if (ret < 0)
> +			continue;
> +
> +		priv->temp_sensor_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%*s",
> +							    (int)sizeof(info.sensor_name),
> +							    info.sensor_name);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_ec_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
> +	struct cros_ec_hwmon_priv *priv;
> +	struct device *hwmon_dev;
> +	int ret;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(priv->temp_sensor_names) != 24);
> +
> +	/* Not every platform supports direct reads */
> +	if (!cros_ec->cmd_readmem)
> +		return -ENOTTY;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->cros_ec = cros_ec;
> +
> +	ret = cros_ec_hwmon_probe_temp_sensors(dev, priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
> +							 &cros_ec_hwmon_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct platform_device_id cros_ec_hwmon_id[] = {
> +	{ DRV_NAME, 0 },
> +	{ }
> +};
> +
> +static struct platform_driver cros_ec_hwmon_driver = {
> +	.driver.name	= DRV_NAME,
> +	.probe		= cros_ec_hwmon_probe,
> +	.id_table	= cros_ec_hwmon_id,
> +};
> +module_platform_driver(cros_ec_hwmon_driver);
> +
> +MODULE_DEVICE_TABLE(platform, cros_ec_hwmon_id);
> +MODULE_DESCRIPTION("ChromeOS EC Hardware Monitoring Driver");
> +MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net");
> +MODULE_LICENSE("GPL");
> 


