Return-Path: <linux-kernel+bounces-537271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7879A489D8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97493B02DB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33440270ED0;
	Thu, 27 Feb 2025 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oYJbm0RU"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815126F465
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687980; cv=fail; b=WaT9NISEHHHv8PCo3eilkz4zk6ay1JLEza0o9xiP1/OwdU2sAiRP1amf/FH2CdMjgiD3pECxd7a3D3kAHcxUO4F9iH8lDIIZeF0JeLTt0szFFtZsdj4gMMA1OlRdR/KtftlXcOn8hlgAkfiPJ0XWgOTlI+3zMReX/QCsAA4Gpv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687980; c=relaxed/simple;
	bh=J3g/ZstnLQ7iQNfQBpjBJRRM6F0rFHWXAP5Rtc1QTR0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uOG9KmztKvqns7BKjLYC+0L1j053TvPJ4BFIxj1kNsJJtYMOPNe1e7CpPX+ffoPBH+pbxUSpoK9Xpjjm7xBlxpTQ187DS0rtalVGPv7+QnDyCY1GUXHmfayc0Rj8p9oRe6jS7W73oLJlQiXXmjN0owjaYuxh0H3HBrLYTGRe868=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oYJbm0RU; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puca1FnXD8zt8c5JwtSG2fiClP0/BTpyKeykYf/Ak0EJ4V5QfpIghwWOajQ7IcjNf/R6XIDricAYWs++VAYysFpOCS2+9MZOZAYxvfA3SsT3X9k/UuBCVYOszlyxmXGIj4X9kGI9SKmUm1oK7nJmyczmZiNJfDVKujECtHTll+ubatdMNtFqwbCnjjaPKJAq2DOXBB0vtaLL+hapqPz6OVxT/QNqRNVf0++IEq+L/v2oWA5bFSVHQLLoa20whgFEMzdHdW1Rj+YMoP0AZOWMGycKkMKDfk6iRIEaXtRwSnWIa3FBTmX4WU+FfUADtZw9KrsuiD4lRpO9WHePxo+iUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rH4Sjq9jn9vBxKLroKlbAuVJqjvNtsoYzR7KvyvISY=;
 b=JV7VoA/B4NOaF8L3D1wK0QNBzme4/a+BDv93CiT44U5DASIleq1pOcB0QdgtXMhcTYQcmv+B2qDmic5FxOrWKM4ZFIWyXH7Y/GSPXJ8JsLQ47ao7O/Po6APjx5YQoa2lqyzO23nZ7S8PwC75/izQpOgLvYT7cosqDP+3HosEPVTd/tFGY3ahscB0lKfrEXYFb1BrfFxALtyPDLIcAZfnv7s4ymaq0ImX5BrQWQN0rqnqeztzo738n0KdkrtJY2J5y3HBNzLKGxjARO1bVEeu9M/GcI3iXudIRRsVoWb4hy+72NVmnQFX1NA5EXIxxsY1+S6acZpeADp7LkdU0vLbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rH4Sjq9jn9vBxKLroKlbAuVJqjvNtsoYzR7KvyvISY=;
 b=oYJbm0RUTAxbNLel/oV6J8+//tKQNOuI6cyGYljsJy76II+CDlK+Xh/wvvAV/GQjb/XJWBQ3VulGfExf54EIV36WLP/LTQBv4BUHXCXVZ5RMccPs4bWy6nkH6kA6Q0e/UASps525JoM2HIDSNy/+50MaNTGzEHFYhI15ocLtmWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 20:26:15 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Thu, 27 Feb 2025
 20:26:15 +0000
Message-ID: <5ecfe64b-d455-4291-b956-db5a47f83f4a@amd.com>
Date: Thu, 27 Feb 2025 14:26:10 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 20/42] x86/resctrl: Change
 mon_event_config_{read,write}() to be arch helpers
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-21-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-21-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:408:fc::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a5e7b3-94e0-4c11-7340-08dd576cfbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTJHUGdqV2twTjZqTkVsQWhCKzRVeHpiR0N2Vys1WTF5eExrSFprYU15VU1S?=
 =?utf-8?B?MFBaWnVsaWdTM25VZjUvRU16L2x2bG92T0phdmdtWUNka1hUS255bkoySm9K?=
 =?utf-8?B?dFlNbnh1QXljbE5LTTVRNVdNS3J4UHY4dmlFdlZXbHBjVy83M21lU2ZKQU1V?=
 =?utf-8?B?V1dzZlB5MWNMdjFaeWFqUXF0OHdzT2d5ZlpqTHh0c3NhanFmMnZHYUZkMmJY?=
 =?utf-8?B?UkF3Snd2VTU0dUFEN1Q4UzZrM3F0TTdlTHM4bGZBQ3dtV0duaEFWcEhuSEhD?=
 =?utf-8?B?eFAvb04vbmNOQStRZVlzSXJENElscURwbTFFQUZqdTBxRXkxNlNUL1VqcW5a?=
 =?utf-8?B?dno2Z242ZUY3ZmhkZjFSQWl0TnFaeUwvSTNsaWI3RkRRZUlURS9Ocy9xSGdW?=
 =?utf-8?B?dXd1NnUxMUhySklHTUhrajNrSmJDRWx5N3V3VVBFVnNpZXAzaVcxSDZTZ2lM?=
 =?utf-8?B?TkdxTWlDeVZKdndhZXdlYnpJR0lXdnM4ZjlKMUdGRE5XUGJaMHdXdlNEWDlh?=
 =?utf-8?B?VlJTS1BaVVRFSEhrK3dFeU11cTNPak1TTHpLUzdueC8xZk9NUnNPWU1ITzc1?=
 =?utf-8?B?NStOTEZsc3lZY0FWZEZZY0tIa3ZYLy9ocitqRDJ5NFBmQVlTbUtVU0pmOXcr?=
 =?utf-8?B?OWJ3dmVWWVh2Mkw2QWNiYVZqT1E1czJJVlNVU1dULzVhVDc0SzZGTE41SGkr?=
 =?utf-8?B?TVNjT2xkSDUyTDRlWElaWW9QbHFqaExHenhTZ0tocGxEcVplbmN2WVRabklh?=
 =?utf-8?B?TFA1YjV0ZXZsNnplOWdJWVdGU2xxZ1g2eDJtcm4yaUdocUZOUjZVSlZPQTU5?=
 =?utf-8?B?Y25peTFidlprRTZlZWIzTGc1VW13eWFFMFplbDIxOWQyYlhWbzI4d1BoemR5?=
 =?utf-8?B?NHA2UE93T2tDeSszZ1ozZWtWeFRVak5KSGp5YkhBOHlCOUFKcy80ZGpkdUdv?=
 =?utf-8?B?Q2FxcVAxb2g3dCs4cmJlWDV6ZldDc2JSdGhkVXRIRXlkTERyRUQya0lQTEhW?=
 =?utf-8?B?aUVqYjluR0RzcjNzYW1USmdUK2NoM2tzSnBCVVF3dEJIWGsrN2d1YXJkYUpV?=
 =?utf-8?B?K0lhSWJJVjVTNGN1VE9Da0QrTVZkN2RBSzBlM0lTeTlNSmxObnVlTUJNcy9H?=
 =?utf-8?B?YUthNW1uVGdNQUtmU0tNRkNuYmFSN05VR0VabGtJUjVreGJUK1oyM3FqOXcr?=
 =?utf-8?B?L1JkWmRJSCt1UU54WE9LRzR6L1lsUldnaDRWMmh6QVkwVDF6TUYxRWJHNFQw?=
 =?utf-8?B?Slc4bTIrbkxuVWI1STI1Y25uRGRXOUNqNDdNcE9xZWdrVlZ1THhPa08relNh?=
 =?utf-8?B?R0N5NTRxeUZROWZuM1AzMkQ0MnRFWmgrcjIrMHVSUHcrZm5RbTdvU2NXd0Np?=
 =?utf-8?B?ZWtyZ1ZmZU8wSFdEdnhTUGtWd2JGYndYenllN1JZb081a012ZlVvRElBTi9Z?=
 =?utf-8?B?dHMyMWNOamVUQmNySkRuQU9qdTNJV24rSU41WlZpeGN4b1FKTWRCbzZLd3lk?=
 =?utf-8?B?K05CNmh2azBqN1A4OVZ6aVFRL0crM3ZQd3Y4TU1YeG5kUXlVVEo2ajc3SFlk?=
 =?utf-8?B?eHdtNjJlY25ST0FMVVhlL3RpaEthMkdSd1pVcXArcm8yNWRNcGEvbkJpdTAy?=
 =?utf-8?B?RnlOM3RQUHdJbW5CdDlTK2ZPaSt3SnI1eDRYZ0pzOWh4SDRVRUpsSU5YUHZY?=
 =?utf-8?B?TnZiVFZLSVI1MnBwWVN1M0tDVHR4ZEx3VERuRnYwdHM5KzNWbjVwb0Y0ZG1t?=
 =?utf-8?B?d3pOSTJScXZmbnNKT3NHZUhub0ZVdmRQeTUzWDgyd0I2enRtdW5obUZOL3lo?=
 =?utf-8?B?NDhmRTBocW1TdzNyUmZwNE1XMTZwMUhLQXNWTGFqY0hzV1R0WVZRcFdHeFp6?=
 =?utf-8?Q?O8AwhBSqYs6ns?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2NsaWk1L1pmWXc4c0lYTjRMbEJOK0VTTnc2V1dMYlZsS3FMb0hlTFBwa1VB?=
 =?utf-8?B?Z3hMOEpVUGlXSXI5L0dEOWdpQWNTNEtVOEtsK0JqY2pNZi83VnJCZEVjbXNp?=
 =?utf-8?B?VEIvTE0yZ3JOQ3dMR0dlRGcrV0U1T0t0cGVwUzI1cHQ3b1pLb0dMYW0vMG9u?=
 =?utf-8?B?enN1dHVhMjhzRkM2M2lJMUI5VnFNcExuemVHRHBZMGFRT29PNHp1SjJNQWNy?=
 =?utf-8?B?dmE4QkNOejJNTFYvRklueDBnY0hnZGlidDF6cU1sZksyaC9kTkMyY3B3T1BS?=
 =?utf-8?B?ODJDRnAyVUdRV1hMelFBUlcyT0tkd0xvU3RzdEhTNGtvb09VUDVHU3dEWFY1?=
 =?utf-8?B?TmQ4ZXQ2cWRVcU1JNzhuUTFsSXc3RVJINkVBVWVNUWJ5QUJYUlBGMTZZa3pX?=
 =?utf-8?B?Z0Jha1dwOXhXVy93dzVKdkdLWEpKWklzNmUvdjNGUFhyN2dpUUpwa2ZUakZq?=
 =?utf-8?B?eW5FQ3VSdVViOVJ0VklHVldoeThRbjBQblgyQWFJK005aSs1QzhuU2lhaDFh?=
 =?utf-8?B?ajA4ZFRXN1YyeHNTYmV6K2kxRTRtMzRsZlBYZ1FtTXM5OCtReXBJRlZHNHla?=
 =?utf-8?B?VUhpWjRrRThSUW16M0QzWm94Z2xvZ084U2pUYU95cVorSmlxeGtBWnh2RUg2?=
 =?utf-8?B?V2xnMlVYWTVkeHY5emllSzVZU3d6ampZc3FNSHV3UTNQamdpcWpGb1JyRC80?=
 =?utf-8?B?dkdLRzdVajZnWTVOL1VDMEp4Z053NU1jVWJML1lBVXFGUWJTSjhCdnpDRVdu?=
 =?utf-8?B?RC9NdjliaGRvWjZxQ1didGZWM1NZYWxldFdQcWtaSUxzWitjWXRjcWRhYW5M?=
 =?utf-8?B?M09BSHZpcEJQajI5ZG01d1phMUJZL0NSaXBVbElNTHlUZStFRVZtVjdHb004?=
 =?utf-8?B?Nm5vdDRQZXJJYVJ3ejRJRGhBT2Jub1JsUGUwemNUTDdJVkQyMzdNcnZYb0xa?=
 =?utf-8?B?VTJYblpRdGRxK0tCQkw1RkJqY1pBLzJiL3BtdEd0KzFIY0VvZ1pKbDBMa3Q1?=
 =?utf-8?B?R2xwOUNKZjIrN21WTUFoOUhSYnI4VDJHTXFTMDBqbFRvYmFJQklqNUVxZEho?=
 =?utf-8?B?dUtpUjB4YTdiclhUNG9ydDM1OXlvSTBjdy9XbFBZbXhBTERZWU1iVmlKWXRC?=
 =?utf-8?B?aUNjSFMxK3NkSWVBcXAzSmRtU0RaQ3BxZFBZZWtVRUNWd0RGZ1F4eHFVNVpI?=
 =?utf-8?B?RDVIMXpEbWZNU3FBZ0tobmw1ZWRzRjdoNmhjRGdTN05oOUFOanU4MkhZUVB3?=
 =?utf-8?B?N3FOQUh4YjV6R1RXOTBJN1RvbFNXdGZBcWVWbWhnamF3SXlSZ0hDZDEyRUtF?=
 =?utf-8?B?bW9DajBBZE9IV05UQ0hKVkxQVjNEVG8zZEdLRDV5a1g1YWFUa2Q5OFRvYytB?=
 =?utf-8?B?RnhaZ243MVpzRGtMVjlVNnRHVmJkNGdYZks1NDZsRkVzbmpsYmNPVEpmakdB?=
 =?utf-8?B?eUExRXdXOHMyTTNKK080WE4yeXpYMU15YUdPV2ovSEZsK2ltVEZpdDBrN0Fa?=
 =?utf-8?B?VmVIK3NxSWlzemYreklrZ2FUc0w3UXNRbkJBcUMwa0R2QTc0RHJoSG1NWXc3?=
 =?utf-8?B?TitPRkt2Ylhoa0RVMWZ2TUhvVDdpWUVnUUlJeDdGTW5VemNyNm92aDA2dUFB?=
 =?utf-8?B?bDhjYWJFbTV2cXBSUUZaNXpObkpsYWNldi84WEI5MXpTdnQvWmVqUElIMTFP?=
 =?utf-8?B?TUJUS1MwYTFDWUZSUnRHekRmMnJHcFhMT0l6QzFZNnNWeC9QaVg5QkpFWEcr?=
 =?utf-8?B?UUdnWG9mS0VuN2t1KzFRQWdDWDducHFEYy85Y25wbklTSE9XWlJwSW0zVk40?=
 =?utf-8?B?UzlnL2tVa0N2V2N0b3FlNTV3dHI2eWw2SHhsakQza3hnVllEbk5FZFhwZzVG?=
 =?utf-8?B?WnpNNHk3TTVRbmJjeTE3UnRFWmNORHJEeGtzMHRTempFMGVWV09CUlNHdGxh?=
 =?utf-8?B?TGVRdlVLRFppeVEweC9mbEhWN1M4RHJrNnZ4QkZ0YnB1SzBYZzlrcjhEb0g0?=
 =?utf-8?B?NzRKTHhwRGNWdWtHNk1vOTQwaDllUHR2R1o5TGFpZTZDQy9Hbkg4WmV2TnJT?=
 =?utf-8?B?MnQ3dk1yRENxOUtVbWI1eUJlVE9HeDE1bkxrVHoydXo1TmprdUFXeGZ0QjJo?=
 =?utf-8?Q?AyPI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a5e7b3-94e0-4c11-7340-08dd576cfbd2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:26:15.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1zOMQMyAyExEDoWPGycNcOjQoFuXe/T+L5cPO49phs7baTfVoJQSXlD+If9QDIB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242

Hi James,

On 2/7/25 12:18, James Morse wrote:
> mon_event_config_{read,write}() are called via IPI and access model
> specific registers to do their work.
> 
> To support another architecture, this needs abstracting.
> 
> Rename mon_event_config_{read,write}() to have a "resctrl_arch_"
> prefix, and move their struct mon_config_info parameter into
> <linux/resctrl.h>.  This allows another architecture to supply an
> implementation of these.
> 
> As struct mon_config_info is now exposed globally, give it a 'resctrl_'
> prefix. MPAM systems need access to the domain to do this work, add
> the resource and domain to struct resctrl_mon_config_info.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v5:
>  * Renamed info to config_info.
>  * Added description of which fields are read and written in the structure.
>  * Clarified comment about which CPU this is called on for both kinds of
>    reader.
> 
> Changes since v3:
>  * Added comments over the read/write helper to explain the type of the void
>    pointer.
> 
> Changes since v1:
>  * [Whitespace only] Re-tabbed struct resctrl_mon_config_info in
>    <linux/resctrl.h> to fit the prevailing style.
> 
>    Non-functional change.
> 
>  * [Commit message only] Reword to align with the actual naming of the
>    definitions and destination header file.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 46 +++++++++++++-------------
>  include/linux/resctrl.h                | 31 +++++++++++++++++
>  2 files changed, 54 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index eb32fbc3abea..e7d1d8b6983d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1580,11 +1580,6 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> -struct mon_config_info {
> -	u32 evtid;
> -	u32 mon_config;
> -};
> -
>  #define INVALID_CONFIG_INDEX   UINT_MAX
>  
>  /**
> @@ -1609,31 +1604,32 @@ static inline unsigned int mon_event_config_index_get(u32 evtid)
>  	}
>  }
>  
> -static void mon_event_config_read(void *info)
> +void resctrl_arch_mon_event_config_read(void *_config_info)
>  {
> -	struct mon_config_info *mon_info = info;
> +	struct resctrl_mon_config_info *config_info = _config_info;
>  	unsigned int index;
>  	u64 msrval;
>  
> -	index = mon_event_config_index_get(mon_info->evtid);
> +	index = mon_event_config_index_get(config_info->evtid);
>  	if (index == INVALID_CONFIG_INDEX) {
> -		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> +		pr_warn_once("Invalid event id %d\n", config_info->evtid);
>  		return;
>  	}
>  	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>  
>  	/* Report only the valid event configuration bits */
> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
> +	config_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>  }
>  
> -static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info *mon_info)
> +static void mondata_config_read(struct resctrl_mon_config_info *mon_info)
>  {
> -	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
> +	smp_call_function_any(&mon_info->d->hdr.cpu_mask,
> +			      resctrl_arch_mon_event_config_read, mon_info, 1);
>  }
>  
>  static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
>  {
> -	struct mon_config_info mon_info;
> +	struct resctrl_mon_config_info mon_info;
>  	struct rdt_mon_domain *dom;
>  	bool sep = false;
>  
> @@ -1644,9 +1640,11 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>  		if (sep)
>  			seq_puts(s, ";");
>  
> -		memset(&mon_info, 0, sizeof(struct mon_config_info));
> +		memset(&mon_info, 0, sizeof(struct resctrl_mon_config_info));
> +		mon_info.r = r;
> +		mon_info.d = dom;
>  		mon_info.evtid = evtid;
> -		mondata_config_read(dom, &mon_info);
> +		mondata_config_read(&mon_info);
>  
>  		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
>  		sep = true;
> @@ -1679,30 +1677,32 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> -static void mon_event_config_write(void *info)
> +void resctrl_arch_mon_event_config_write(void *_config_info)
>  {
> -	struct mon_config_info *mon_info = info;
> +	struct resctrl_mon_config_info *config_info = _config_info;
>  	unsigned int index;
>  
> -	index = mon_event_config_index_get(mon_info->evtid);
> +	index = mon_event_config_index_get(config_info->evtid);
>  	if (index == INVALID_CONFIG_INDEX) {
> -		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> +		pr_warn_once("Invalid event id %d\n", config_info->evtid);
>  		return;
>  	}
> -	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
> +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, config_info->mon_config, 0);
>  }
>  
>  static void mbm_config_write_domain(struct rdt_resource *r,
>  				    struct rdt_mon_domain *d, u32 evtid, u32 val)
>  {
> -	struct mon_config_info mon_info = {0};
> +	struct resctrl_mon_config_info mon_info = {0};
>  
>  	/*
>  	 * Read the current config value first. If both are the same then
>  	 * no need to write it again.
>  	 */
> +	mon_info.r = r;
> +	mon_info.d = d;
>  	mon_info.evtid = evtid;
> -	mondata_config_read(d, &mon_info);
> +	mondata_config_read(&mon_info);
>  	if (mon_info.mon_config == val)
>  		return;
>  
> @@ -1714,7 +1714,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
>  	 * are scoped at the domain level. Writing any of these MSRs
>  	 * on one CPU is observed by all the CPUs in the domain.
>  	 */
> -	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
> +	smp_call_function_any(&d->hdr.cpu_mask, resctrl_arch_mon_event_config_write,
>  			      &mon_info, 1);
>  
>  	/*
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 5c7b9760b63a..59d944e139f8 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -270,6 +270,13 @@ struct resctrl_cpu_defaults {
>  	u32 rmid;
>  };
>  
> +struct resctrl_mon_config_info {
> +	struct rdt_resource	*r;
> +	struct rdt_mon_domain	*d;
> +	u32			evtid;
> +	u32			mon_config;
> +};

Isn't this architecture specific definition?  Why is this in common
resctrl.h file.

> +
>  /**
>   * resctrl_arch_sync_cpu_closid_rmid() - Refresh this CPU's CLOSID and RMID.
>   *					 Call via IPI.
> @@ -311,6 +318,30 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
>  
>  bool __init resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
>  
> +/**
> + * resctrl_arch_mon_event_config_write() - Write the config for an event.
> + * @config_info: struct resctrl_mon_config_info describing the resource, domain
> + *		 and event.
> + *
> + * Reads resource, domain and eventid from @config_info and writes the
> + * event config_info->mon_config into hardware.
> + *
> + * Called via IPI to reach a CPU that is a member of the specified domain.
> + */
> +void resctrl_arch_mon_event_config_write(void *config_info);
> +
> +/**
> + * resctrl_arch_mon_event_config_read() - Read the config for an event.
> + * @config_info: struct resctrl_mon_config_info describing the resource, domain
> + *		 and event.
> + *
> + * Reads resource, domain and eventid from @config_info and reads the
> + * hardware config value into config_info->mon_config.
> + *
> + * Called via IPI to reach a CPU that is a member of the specified domain.
> + */
> +void resctrl_arch_mon_event_config_read(void *config_info);
> +
>  /*
>   * Update the ctrl_val and apply this config right now.
>   * Must be called on one of the domain's CPUs.

-- 
Thanks
Babu Moger

