Return-Path: <linux-kernel+bounces-530097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F62CA42EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B76D164D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C191DAC81;
	Mon, 24 Feb 2025 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nw5xK0XD"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2A1DDC37;
	Mon, 24 Feb 2025 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431948; cv=fail; b=ILi5m27+p1pw0UiABrraOBnk2BuiGK3Fofe1aD6fD9qGH3r2/1EnHGqZA9FKWALwqFwLEzb4oWIaPWMhcEW72qQmSdFniaCosS8C6vIJwIIS3m5Uv2hgNcVeH4mTgZBLMAKpC/b0DO3OT5mBu8v2H4jUUUYCMdP5yPNcJzs9jmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431948; c=relaxed/simple;
	bh=hWekRJ+JulXamDNyXNAzZO3QmFk6MoNZ1ZxWxKIGJh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hq8qRaUWmWEiWYs7N2okdc26ENEDG12rYQ/edcgttuzVcOvqZ8QxOza3HErGst9kfd/y4r78P+O2FkFhdMhlkP5PKDAlW/BJYj5mja7ZPwxEEvTy8s+9gBdM80phsDrm2rh+Khg8/tX8+F1mahUQDC7j5YKu5CFGRrY/TW7pvbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nw5xK0XD; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7leJpl08vnBTQAuf0hT8UUVLuJP91/k4yWlE9AVsW0CHZBuO+A2rcUB93sFmR/O0xPvQCV0tp8+X5BL/BPwqLdv4Jj3dBKWZ7+WzoHwJa01sGx1z8uyRO6Q9LWakdIrjBtjO64ZTsJHuL2uPTVBCQonpFdDFR+dWPSAwCC9IkICtWuI3TqLcC1nCYfSljUlWRkFcr92CpRDTMhvte5eWjaZI1tHbYjGt2KtQlsC3H04s8NFOPoPtS8WHLuoOgCvtHf5+i6D5CqHxfxHhTpE1rGZSBD+b5klBnW6yp45lmV86lgrM3SLZ/cwMzcHoAuSlfnBpHtY/Nb8oDLRMXhJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwRjz5JG5ekhMgAagTzvUq8Atlh4cXmfATmIJ32HjqM=;
 b=fPeRqexwzaWumIN0h30bjVXFhcNmVnrSl/ijHFFbzH7DrgbxTzUVjAbQQaOltGMFSlJDuEAOt5o7w/HaXqN5W62UzcTLP8GKmAkqV1Wk0DOLwZXuluMYAYLKeuJF4D/iha3eDDsSCUl7AdLtM5CvoFhBxdRCcfWcE4xOizHffZpO9QiQzj3KcItlL/sov/Uzifmno1X1D5kYXyYNl+c1t9eqrYI9+aMRiWjkwkac89k3gQRjdpt8zP3FSshRG8B7rdB8xyZM2Kjyvdfoz5+GG4GGoNVQx2ntbUmokcbqMhPpAl00zzSXntbuHtCZz9xdZMmI0jW7shE2uj4tNJPZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwRjz5JG5ekhMgAagTzvUq8Atlh4cXmfATmIJ32HjqM=;
 b=nw5xK0XDXaKvXVME+aqDAo9Li3Jrc/2yrjN6UYsNaTQFyAB28v/Jvg/SRKXNr6DdR3Nuf/7pno4GSG4NAZwAXAeejH48MnRchuFdsQaoLPzK4I2pTt5mQ/qeYnXDhxd8ILlobi9xEgBlwRrqYI35cJD6agzvmWW1OHDltSKaLwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 21:18:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 21:18:59 +0000
Message-ID: <c866ffa5-0a4e-49a2-bd11-86c94360b7bf@amd.com>
Date: Mon, 24 Feb 2025 15:18:55 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 20/23] x86/resctrl: Configure mbm_cntr_assign mode if
 supported
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, corbet@lwn.net, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, peternewman@google.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <4a48aabf502897bec1e015305d7b0b826bb20841.1737577229.git.babu.moger@amd.com>
 <b3dc2fc5-4ee6-414d-90bb-97baa0d67dc5@arm.com>
 <7b3d18e3-1f7d-42cd-bc32-fda4a81dfc82@amd.com>
 <3fb20135-1b8a-42df-b670-5fbf29acfa85@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <3fb20135-1b8a-42df-b670-5fbf29acfa85@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:806:24::32) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: abcdc6ea-0711-4e9d-b05e-08dd5518da9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3lldjdHSTNtam45YjRlZkxiMFV6R0x0YVZoeHQwUGZqSWFIQzBzOTFTUEpQ?=
 =?utf-8?B?cVd4bjZHbVpnMkZJOWp0MlZPck8xbmppTzZhSW1sYW5IaEwxZzRGYmVPQTM1?=
 =?utf-8?B?TzBjRXhHLzBnbkJMQVkyVW5Ga1RpZkEycjdDYUNZN09LSzZ1NitWZ1EveUo3?=
 =?utf-8?B?UmxyNkJzU21sUzFEaE9hQ2lTMXNraWV6c2tYRWdvVmYwaXV1ay8yMk05QXVj?=
 =?utf-8?B?OHg0MHhpVEtyVnJ5aHFEZW9TdWxYaFBtbFR6YjZWS1hvZjVoSXFMb0gvYXcx?=
 =?utf-8?B?MUMyNktwVGt1QWVvNWJrUExuN0xDRjJKZUxycStybnF1bklEZGtDdFpHdWtJ?=
 =?utf-8?B?dlkzVld5WlVENnJOVDNXOHA2YlFjSHF3ckY0L1k4QXVBZTlGaCszenZYaXNM?=
 =?utf-8?B?L1lLeUd1K0ErdTBwVTZhbjh5c052c2lhekQ0ZVdYbkZxcVBDR2JRNnQ1VzFS?=
 =?utf-8?B?Rk1RdVN2MCtUVjJUa0Q4MTlOa0lSay9hdWUvQzBPbCt4eEJmWU5VQ0ZlMkNS?=
 =?utf-8?B?Q3ptVVBsdzV3SS9mbGpyTmpSMnhBajU2dFVQdTZ2TG5iYXpybVVYQ1poM2RI?=
 =?utf-8?B?UWp0WDlzUTlXM2UvKyszK0pueWNHVXl1ME9mNVJab29WUDZuYlVER1k3bVE5?=
 =?utf-8?B?Rkx5V3dnSSs5SEYwUWpHZHFMTEJ2Ukp2NkNQWkVaS2s5cWVUMXBBU24wUEM2?=
 =?utf-8?B?cy9zMy95RTJuanQ2RmV3MUM3QjlGVWJNS3NsMXBiUXlWMEJEOFFRNm9sOFlR?=
 =?utf-8?B?Z0JXZXhYUUgySFprNWJFQis4MlUyWUx0c0VRNkg2Vi9nV21Xc05Ra2cyUi9U?=
 =?utf-8?B?TDBJa1NIN21uQ1hqR2pwcGlDalRTLzA4L0xZaFM3QlJDV0JPNjNOWGRHSUw4?=
 =?utf-8?B?UXBUdUppMXZ3UnFuRnhNcEYzd0svZ2ZONVppcGxoM2pmWDdsUnNKRDdBUXZB?=
 =?utf-8?B?bmptVVArcFFtWXJOZEFkTVNmbzZzbDdkbmdoK3ArOHlEa2hwb2RRN21lclVr?=
 =?utf-8?B?Y28zbVNUVTVaU09SUHg2TmxKNHpQazY4QUc3TzFkWWZvOVhLenhOWE5rWTVB?=
 =?utf-8?B?TVZRWjBMcmJ0S3pTcW1BbERjVXBWblpLRUJYTnBGT1AxMGVIR2JsQkxaRTVM?=
 =?utf-8?B?SUZlK0hPbEVKclJWdmh6SWVMTWROWnFwUG9rdFR0eWdkYUxYSGdtbXZEQ2Q5?=
 =?utf-8?B?cHhSeSswUzg5NXZPd2VNdFVTYU96Rk1SK1B5Nitya3RLS2svai90Q1VMTG1J?=
 =?utf-8?B?MWE2NDR4TzIzTVREMU44V05XSkg3OTVnV2dmWk1DNXB2NTR4YWNhOG8xTmxs?=
 =?utf-8?B?bm1HQUFiTDhZWjY5emo3QlBJU0J1NENNVVYvYjZsVnVWeWRKeFZMRXA2U3hW?=
 =?utf-8?B?c2lCaFhRcVdnaC9jakwxWVRnVTNoamgvM1dXNTlrc0hGQ0MzYWpmNFdidFJY?=
 =?utf-8?B?U1ppcmNxMEZkVlhKUXNPYStPVW1RQkxpS20rdCtWM1VzZ3hkL2F2NGtldHpW?=
 =?utf-8?B?MSt6SEc2TmFITnN3NDN5U3R3eFBrQkx1N1BSZldPTHp2d3V0YTdycjVxbkdC?=
 =?utf-8?B?RlRneWxxUkRHdUZWRHR5bk5MNnVCVlUrcmRqMStZMXQzeXN4TjRzSXYrQUZG?=
 =?utf-8?B?K0ZXQkU5NnBKYUNleVNSM3lvNE52ZXYvSVM5OGVLSDg1OXBNNktZZUFTUUFp?=
 =?utf-8?B?ODBmVHFHdTg5MHRidDIzMXc5dHM4RUUvVmxiUVFheGxuN0R0ck1tYjRkY2Ro?=
 =?utf-8?B?WnpZZml6eFZBaXFZQjB0WldKVENvbVZtY0VCcmU2Vml3YWNsMTBwS0VyWEpM?=
 =?utf-8?B?U0V3NkluUmlzUzAyUU5WVnFtNXU1em95OCtRZTFENTBvUTZZRE5iKzlONHJZ?=
 =?utf-8?Q?CaBaapgQDN5sE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk04bzhsTzlPMkx1anpWQnZ3c1l2ak81VS90RzlYbk5RNHpIdXhVcGlqK1Ba?=
 =?utf-8?B?Yk4yYWFDMWFVYnR6NVE0MlcwVkgyT3h1K0JxMFFSMFo5S2UvR0tLWnNPWEl6?=
 =?utf-8?B?SnJFNWh2YUtxcUppK2pGbHBaNmIxS2MyUUJ5bWZKVGM4aW1vaGx2MVVJR2pL?=
 =?utf-8?B?THZNZlk5YVRFYy9maHJ1d3FXdzZycGMySjN6TmxrTVhJNDQ4MThjT1ZCeDZP?=
 =?utf-8?B?OFBnVGRlNkp0aXlWSy9ZbFdkM2FuUldKWnR6ZU1uTFhBUVVlbHhCWUpYbHIx?=
 =?utf-8?B?bDFmYzNEY3lrNVN2Z0lPdmpmVmJoZEJiaDlYbXlzQVdzMGEvNTY4NzgvUVZ3?=
 =?utf-8?B?MFI0QjZ1V3dsQWJsL2tMWmRmSk1OMC9scVJFcEtxZmtTSTFzUEtnaitITzNG?=
 =?utf-8?B?amZvZkR3eXN0aUpCRHh3aytsemNvczhqUVN6U20zK0liZnVoQjVXYjY5ckZE?=
 =?utf-8?B?QVhJeEpQUFI2OWlhdmFNeFVRU21UTWlWRTI3YVZnUHI0eFNnaHFjR1lNdDZ0?=
 =?utf-8?B?TnB5V2c3VkN4ZGhUbFlUVTFFaXhqQlM2SmlvWDRuZlVsb1Z0ZnlBRDI1YU1w?=
 =?utf-8?B?RURzTU1TeHU3QzZhdlhkZHVqSExQb1ZJMG5yaTBhWFJ5SWFSUEpvcjJ6WTFU?=
 =?utf-8?B?bndmQ1QrdGNVNGVQYmRhelE3N0J6d3BaQWFPeU9KSjZsVENPa1M0YXlGTENW?=
 =?utf-8?B?R1paSVdsUkpMcnRaNEpVWi85enJxWHdRUXgwWjZ3NDU1TnNjcFVmKzN1T3U2?=
 =?utf-8?B?Q0V3T1Q3MTFuSDRJTVA0dGdTWU90K3dDNnhvTzZqaU43b3hSQy9sYVRYT2hk?=
 =?utf-8?B?eUJSYk05Ui9NMTFLbU5Eby9BQjVodWV1OG9tTU9jaHQ1ODM3N0wvVjdNZHhX?=
 =?utf-8?B?aUhKYnpaa1VxSWRqckh2T0RDdlpQc25mcUxXT0lXZGdSUlJTVFNpeUtycFdn?=
 =?utf-8?B?VVhGeXZDWVVtSnVwVXc5WWtjbDEvMk9GOFg1azZUWDlncmR6QUsybjVSUXE2?=
 =?utf-8?B?RkxrdURIMjFMRGdiakFHck5yc09nMXB1NlRzWU9sQ0Y0dFR3ZmtSZGNwNzgr?=
 =?utf-8?B?T0V4TzhPQXZ6TnhpN1FNOElteHg5aElIQi9SeHRlVWFTVUdaS0NCZU1IQUtT?=
 =?utf-8?B?NmowamFja0lXU3duUFRQQWx6dFl6SXoxSTRPRzI0L2tSWGZ6RzRhVUdkbXhm?=
 =?utf-8?B?RlBlRGJiam5UcWlBTy92R0ZCYUVSZWJGSGpMUk1VcWtjY29vdGhONlpEQzQr?=
 =?utf-8?B?SlZ1VFdKdTVQY0xqVkFuQ3hKR2tkQk9BSnNCU2lSeWxIbGI3VEJrU20vUkxi?=
 =?utf-8?B?YjBMZWM4enhPTmZpUzFLK1pnSlYxd1QxL1liL0NkT3VKZzJuQzNiRG9lTjlw?=
 =?utf-8?B?OTdHWktDVjc1UU1vSHhRcXRMUXc0eEgxV2NHY2w4T2VOYk0wdFFLWlMrcGh4?=
 =?utf-8?B?MTlJeGdpdmZJbG1YYzVFajhaa3ltK1pUMGNTdUN3ZnVzUVp2MnpxdHIvSEt0?=
 =?utf-8?B?bmNBbWVsb0JuNVowNk1QVCtNdHd0eHJIWkdiUUQ3Y2R4NXVJVlIva1dpKzJF?=
 =?utf-8?B?ZFArT0lHc1R3eFJmWlpOSlJQcFBvQjhXZjZoWmNJMW1jblV6TlQrZWFzSVpi?=
 =?utf-8?B?R1BwOXBTMzkxcjlMZkMrbXNBcUZ3OGg4Wlk3K0JMSzFqUHFzbHd1VHVCREVU?=
 =?utf-8?B?cktlSE11Q1BTR2RvYjIxOXNGL0I4VFlOTVhiTS9wNHdKcyt1QkdJVTV0TC9T?=
 =?utf-8?B?ME1Ibmg1aHE1d2I5RFdYTFBMeXQrYjZqSWhLQ1dqeU1DUUJYRTZJUDBUUlhM?=
 =?utf-8?B?YWxQOVN0dUlDWDB3MVU0UHo1VHpuanB5amhvUFQ4MmgwWm1qcG0xT3pBaXJ6?=
 =?utf-8?B?L3FibXBRTmhHaXZsdHdPVTZZaGNxMVNIWWhlZkZUWStvYnV3aW53UVFkb0Iw?=
 =?utf-8?B?Vkl4K2VOSlBwOFh5NkFrRVczaTgwWXRtQUZTc1BiK2hWQ01UeTJXOW91QkNL?=
 =?utf-8?B?R1ZueGdCakFFcGdwc2xrN2tLQkdjeWpOTHVYVHhvdElPWEZPRktvVmRDeWgz?=
 =?utf-8?B?OHl4eGxGT3pOZlFFV2U4UUdHaVZOWU5yek40TXpIVXlrY3UwdHFnQWUyK2Nw?=
 =?utf-8?Q?ouA4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcdc6ea-0711-4e9d-b05e-08dd5518da9f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:18:59.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/tWCH15x0iU10ldazisy5/m0qcLg8vLx3+kNxxq24g6nZfvFZX0CShRa24rc2hP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882

Hi Reinette,


On 2/24/25 11:01, Reinette Chatre wrote:
> Hi James and Babu,
> 
> On 2/24/25 7:49 AM, Moger, Babu wrote:
>> Hi James,
>>
>> On 2/21/25 12:06, James Morse wrote:
>>> Hi Babu,
>>>
>>> On 22/01/2025 20:20, Babu Moger wrote:
> 
>>> This sequence has me confused:
>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> index 3d748fdbcb5f..a9a5dc626a1e 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> @@ -1233,6 +1233,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>>>  			r->mon.mbm_cntr_assignable = true;
>>>>  			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>>>>  			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
>>>
>>>> +			hw_res->mbm_cntr_assign_enabled = true;
>>>
>>> Here the arch code sets ABMC to be enabled by default at boot.
>>>
>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 6922173c4f8f..515969c5f64f 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -4302,9 +4302,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
>>>>  
>>>>  void resctrl_online_cpu(unsigned int cpu)
>>>>  {
>>>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>> +
>>>>  	mutex_lock(&rdtgroup_mutex);
>>>>  	/* The CPU is set in default rdtgroup after online. */
>>>>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>>>> +	if (r->mon_capable && r->mon.mbm_cntr_assignable)
>>>> +		resctrl_arch_mbm_cntr_assign_set_one(r);
>>>>  	mutex_unlock(&rdtgroup_mutex);
>>>>  }
>>>
>>> But here, resctrl has to call back to the arch code to make sure the hardware is in the
>>> same state as hw_res->mbm_cntr_assign_enabled.
> 
> Another scenario needing to be supported by this flow is when CPUs come online later ...
> after resctrl is mounted and potentially after the user modified the assignable counter
> mode.

If the user modifies the assignable counter mode. It is recorded in
mbm_cntr_assign_enabled already. When the new CPU comes online, the
hotplug handler(resctrl_arch_online_cpu) is will update the CPU to the new
mode after checking mbm_cntr_assign_enabled.

Are you talking about different case here? Please elaborate.

> 
>>>
>>> Could this be done in resctrl_arch_online_cpu() instead? That way resctrl doesn't get CPUs
>>> in an inconsistent state that it has to fix up...
> 
> Could you please elaborate the inconsistent state that would need to be fixed up?
> 
>>>
>>
>> Sure. Here is the diff.
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index 22399f19810f..f48b298413bc 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -771,6 +771,12 @@ static int resctrl_arch_online_cpu(unsigned int cpu)
>>                 domain_add_cpu(cpu, r);
>>         mutex_unlock(&domain_list_lock);
>>
>> +       r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +       mutex_lock(&rdtgroup_mutex);
>> +       if (r->mon_capable && r->mon.mbm_cntr_assignable)
>> +               resctrl_arch_mbm_cntr_assign_set_one(r);
>> +       mutex_unlock(&rdtgroup_mutex);
>> +
>>         clear_closid_rmid(cpu);
>>         resctrl_online_cpu(cpu);
> 
> This would require every architecture to duplicate the above, no?
> 
> Also, please note there is more appropriate domain_add_cpu_mon().

Yes. This may be better place to add this code. Will wait once James
clarifies on "inconsistent state".
-- 
Thanks
Babu Moger

