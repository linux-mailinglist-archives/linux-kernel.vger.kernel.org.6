Return-Path: <linux-kernel+bounces-172030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0298BEC35
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25151C21E06
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C0F16D9B7;
	Tue,  7 May 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SHlKDB+/"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A016D9A7;
	Tue,  7 May 2024 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108636; cv=fail; b=PphK3HBGgEK7k55xRs2xnAzHb7RK1LisVe8AAv4wUhUBupWXzwYZI/WsCjb1untpZK7SpYHg9s05PKowhy04M58gkIP0n2HJjPbeYUQ5D31QZgT43e/J9LO1LFQw3pxLwqwVx5NVCE0kGMdHdn+d+Gfbe/7idgeZ55c12HmjFZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108636; c=relaxed/simple;
	bh=PusG0mtMgdxlbzbsAnVv0ZBqjp7audVkORpoK4o/3qI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PbrCrRk7p0dq6JoMi3lRhefjbZWQA7zVqMtlO3s5ijzQMw0xlwOIsfaY12BUAK7aDqOkHVcE1lCYbnK28O6kNldRWUI+Kc/t/71tfmJfpBa1q2OAELfDm/F+/sRe9GRQCM5Qiq1vkm4Ry8KFtmZF9DZyv9/keOpms5YfjXhRV4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SHlKDB+/; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grYIE/8aMctNPYvKvgYLPBvJlWzeASwh/dwzZ4Jacf//LvnAl/TltyKMwKLp/CvXU86ijfpZdp8XTETNY2CT0MzZ9ClLCxu2eUn9CfFW2WfRxUresW1aqdSCvyxrBcOFqcbXMsfE6lN7Wy8WrCJgDn2xIidIzCkut8ugmImOaatFDUiKxqWvrRqExIEph1lNEgQhFH7AfzcDSoH5huxflpg0oBpLwmw/BqGaqF+dx5on2seG+a3W2IdPalyRHnML16CvIOmDZENzjBP0AYS6CMCBYi8w7UDKulTvNBT9Q7G9/tE4V9L0HjCrxJ3VTTCFchdDLQASVz7nFAG/Dk5PdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/BVC/4aknTx7gPKhcYgQtiCdWoKwWEynWL+QAihIQI=;
 b=O9Po1Z2nIa6+1vMMRibi0ZqTRG0pPj708s1w1fGaUBOnBMwBNT4c2HgHoKJIhl/qDzmvxFfz724q0ggVBvtb0JicbjR/rntQD5MZRSY7MyLv4dWJw5fI9zc/SH/q2ZHgHCMqUMbFFhk1K0bHYhTtRJvjmnhCyCrLoJsooq8jHrrDSDa5UQPeCstZf7BuHUXO9Lm9I+CvrKqX9ADcGL2xGg4k0HzN5NPdftlgTL3Ke8QT1+lNOA/JSNMSE6KZTzkc0l5u1dxo7YysNhuD4d1ogm5pYxQtxwgOHFnppeoMLz/vZRHr3nP2h5IrddzOhOgyIcMvg/oy6wzewWVU6GFcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/BVC/4aknTx7gPKhcYgQtiCdWoKwWEynWL+QAihIQI=;
 b=SHlKDB+/uFIWonSBLC/hIhyM6ZqghDAylootKOiWsGg5V5Rvi895D6qdpAzqNPBs5A1nQsXePNJzNf0V+vSf4t4w7EFDzb4PKSpf80A+ovXdKN7itogaaTz4Orxty17nT7JiMK9J3rsPW3Rk8H/Ek4GlPgZxGIYJSIpiK2Ip0es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 19:03:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 19:03:49 +0000
Message-ID: <65d58c4a-46e4-4012-8342-ee93b12dd68f@amd.com>
Date: Tue, 7 May 2024 14:03:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ChromeOS Embedded controller hwmon driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev,
 Dustin Howett <dustin@howett.net>, Moritz Fischer <mdf@kernel.org>
References: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0083.namprd11.prod.outlook.com
 (2603:10b6:806:d2::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 168b6129-418a-4556-5165-08dc6ec86dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDJhcmxYWlZiRHRtSjA0WWJOUnlJNmdJeURaTDFOWHArNzFvY3hnckhtR0dF?=
 =?utf-8?B?SS9RdE93N1Mrdk5vWTFSOFAzdHMrOWZGNzNkczFxQ09tWlFWY0Rsay9rTE1m?=
 =?utf-8?B?NGh4d1FFL2g4MVRPamJmWkRtd1pncm15RnZaazJ6Y3ExdFcxeUw2a3Q5MlZ5?=
 =?utf-8?B?cm5qZHpXQnM5V1RJQ1ZRSm5nMXNwZHVBYm5sdVExY0lKT3FXTVhDaFVoUXhn?=
 =?utf-8?B?ci9oZ2ltWCthNmpOMDZEUG1xOS9EV2UzRjZUQk9YYVN2RUVwNExpZ3l5bS9y?=
 =?utf-8?B?RmxiSXB0RUtBSUZXaVBSVE52NkI0VCtIODJyYVFDMC9DVmtqOFVYaFhoQ0Ns?=
 =?utf-8?B?TGE4V0ZQMTl6YmZCQXdCWDBjZ3c1NjBlL1NJRFo4YVAvdGU4bU5UYWxoQzBm?=
 =?utf-8?B?TDh6ZEY5aWZzS1pqTFpVN3ZQaW5iTTBwdzRoNUxtb2F5dlU0T1NXUW10MC9N?=
 =?utf-8?B?K2NGeEFuREpaRTVOcjh3VE9rdGYwK2pKbzdKaUl6M3RwMUxnbWd5d3FFcmFz?=
 =?utf-8?B?SGJpbHpSL1VhRnpSd3RLSlRiRGJWQW9aR2F0UktBV01sYzlweEkvTnVGakJq?=
 =?utf-8?B?WEpZM3NIVW5jTDBmdGppWDhxbm9Sa1hiRGdDTUFxZnp1QmZvQmtscWZVWDNx?=
 =?utf-8?B?VHBicUhhSWdiTjJWV2dZYVVSYkhsbzcrWDd6TlE5YS8wejFyK3lOU2hETHRJ?=
 =?utf-8?B?UjQ2Y1FtVmhlWHJsNGVrNzUxNW92VW53dlk1enlJZ2pvVmtxdzY0YVh2MUt1?=
 =?utf-8?B?dUhkVUhKWko3ejlMWFFTSGI5VDNXLzNBdGdIRFA3ZytxVlRST3lkT2ZhVjlZ?=
 =?utf-8?B?RVN3N3d4Qnk3UW1CRWR1eTYrZ2MzOVNSTjU1MGpJQzRYN1JSeVozOWRmWmRa?=
 =?utf-8?B?UkhQbWtoeHZ2TThZOHZZZGZNQitZT3MxZGhJbW9xVyszcmhPd3NCVEVJQ1lQ?=
 =?utf-8?B?T3Q2RVVVN0hjUUhpdElSNGJmVlJWMlYrdEFSbVJJaTQzbloxOVZWUUtjRnIz?=
 =?utf-8?B?TloyMC9LVTh2WEN6d3NHR0ZhdXY1MzVpbUhDK2daaUJEdUZPSitQZGJKTk1X?=
 =?utf-8?B?VExvM0lrOG0zeW1PdVg1WXlzVkJOVncxU1J6d3kvWTBCR2M5YmhoVEk3SmEw?=
 =?utf-8?B?V2VBdXJudW12UG5hdGhtS0VvQlk0cGtRWVRpMXhNemVIVUVybHlDRXliVi9u?=
 =?utf-8?B?Q0tQaG01S2RON255NDZ0bSt0NXhBcGlMSVgrQnVXa3RzMEZ0RHdnZ0VHMEl3?=
 =?utf-8?B?T0d6ZStlb2NPcHg5Z0hYUGxFanZDQnFsUE85R3hOdVdBcDN4ZXU5VzZTRGhy?=
 =?utf-8?B?NkVSSjJsMzFLSWwyVjZlM3pUV1NFRlVSOTJCZXBCMHdLay8xOFV6Qml2dXlv?=
 =?utf-8?B?N29lN2hUeUV1RzhocC9wSmdIdUlCUlh4cEZWQU1VS05WRmJ0R0ZTWVd4dlcv?=
 =?utf-8?B?U2d1OWxlU1VDVk9PZHRlYzRrOVBKMmlZU0xnZmFQMFZFZ0N3S3ZKUWFyWlVW?=
 =?utf-8?B?dXB3R3lkblR2OTBoMWJqVWt5ZkJCZmxYV296WjBDdm5HTXdGd1QzcWNaRERv?=
 =?utf-8?B?YlFBQjlXSm9keVM3TGdUTTdEaThkNFhYbS9YRWdSR0F3YlRFVVpCWkV5aGhW?=
 =?utf-8?Q?DrFzPTOLGdzmBP8IoUJrej3Ccfq/UODiBm41Pawb3Xs0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFJUQ0xzWG5kWENwYU5XRGVRSXVVN05sZHhCUmhIRCtOZkNGa04xYnRyM3NI?=
 =?utf-8?B?TFVGcWZuREF1ZnNIYzNzcTAvTjc1MEN6eHBDdUloTFE2bUdtd2tuQmhrZVoz?=
 =?utf-8?B?YjFkd2gzSHNCMTlENDlDRnRtTXBjbXdHRkpmQ0hTeHVoS3hvZk10NGhXV0k5?=
 =?utf-8?B?WklNMWZ3S2lkcUc1Y2t2MERjeWNXemp1RWdRR2I0WmRkbnRkaEFrWWg2dDhh?=
 =?utf-8?B?NDE1ekxrR1RtZlNMKzBsREpMcXZlRWQ0dUh1NC94UlFNenlTdi9ndFBGY21u?=
 =?utf-8?B?QkpRbGlVSEpJWjN5bWc0VE9ueFVhbVRXYTU0T0FtYXNTdEh4S3Vwb1hIQWJr?=
 =?utf-8?B?eGZhNjEvV3VNVWZHMEVZOHFmekY4YzdQaU8yaUowc1kzOE9RNjRIREMrTGNq?=
 =?utf-8?B?ZlVnd3hsVmo5SkNNNk5OclJNYURQalpITUZoRUh0dVFZZnJvRitqYUJlamJv?=
 =?utf-8?B?VDhHQXNlQWtMNEZlNmdpSXJ0TmZ6RzRJaTl5dDRad0NNamV6cTBmeGtiZjdO?=
 =?utf-8?B?eFJzRlZXK3Z3eHFZMzNyelQ5TzA3RTRoU3lUZ0JjdlExMUlXWldIdXhMdDF0?=
 =?utf-8?B?WlFid0VmdTZIaDFLMTgyRmtOR0ZNcmcwM1RxR0VTTGUrczVmbDY2YTdoOG1P?=
 =?utf-8?B?b0N5TGQ3czMrb05Qb3BiK1RJUkY5UHl1U3JTQ0MrZEpNTHVyajRIRTltcGth?=
 =?utf-8?B?QVRMWnBTSFY3WGdJNEJ5aUg1M3lsa3NhUE0zZ3NCNEY2V2hPODY1VTVpYjZY?=
 =?utf-8?B?MTF5czB3TzAwdXY5Vlc4clBmTTJYR3hWbUtkR2FaWmROOU9kRVFkL1BORUZ2?=
 =?utf-8?B?MnZTRWtHRDZCbW1GR2V0K21Ia21LeDdSbzBhckZaRXFLbERwV1ZZMHMralhK?=
 =?utf-8?B?SXBPeEtuWHJtcFpJOUR0Zm9kc1VJTW1tRnhGWkwxSlFTcHcxQm84bVFBWFUw?=
 =?utf-8?B?QWcrY2RBUXNwQjlsSldIRC9LUDgyLzJ4K202QVlQK1U2aG9FUW9vbVBSa1g1?=
 =?utf-8?B?Yjg4N2Q5dlA5SUx5T2RjVUdtYUhyNTZhbGo1ZW82d0Z4clRqZEhGT1VQOU1z?=
 =?utf-8?B?Szl0aUNJejh0SjU0R3JMSEJra2ZodUh5Yi94TlpORE16Ui9UWE5WK3B2MFIw?=
 =?utf-8?B?bXdHRCtBa1huZ0Niendmc25RMFJMbXFiRVdkbUduckQxdkY4YXBhZEh5Ukp0?=
 =?utf-8?B?OFhOMGgrczR0UXZVY2FpaFVrTFV2a0dtdTFYU1NMSzRvaHo5YUtMSHhIU1pS?=
 =?utf-8?B?bEYvQ1RLTTM4SFNoS2JWVHh1c2YrV1cxRzN6VjlGSjkwUk05d0RpVHRFMXpR?=
 =?utf-8?B?Unp1MEJNU1BCemJhWTBHYUZvTSt1dzNvcU1Rd1RzbW1HNXVDMWlPTlFvY011?=
 =?utf-8?B?LzdoMFhibTZHT2drWnBTWW1GZXFtS0tFRnFKZzNRRTVOajA3ODIzd0JuYWdQ?=
 =?utf-8?B?N1VQNlJYbDIyZjNtSXhVNzhMRkY0c3hOU3o1MzFhOWxLUWJjTUloZGRxRWEr?=
 =?utf-8?B?R0Z6aVQ0NHNBVlNuVEN5YUc3WFRrNFVQOWtkTW5oT1VEVDFzS29HbjhtYkFi?=
 =?utf-8?B?KzZNZEVEenEyNWIxWUtOQ3ErR0RhRzA0eGtXT05GSnh3c05KdWc1SmR0dUFP?=
 =?utf-8?B?VW5TU3JQMThhMWpJa0tEekR4Q0NuK2ZXWnpua29OK2ZxOVBnVkd6Q2U4SGV2?=
 =?utf-8?B?OTN1eUVmdG9MSnd4b0d5S3RoSmw0YzE1OW0zK01RZGMrUmVmblFZNitpWGR3?=
 =?utf-8?B?RUF6b1N0UytGQmw4WTJXc0VMTUFxKzROT1FaU2pMOUdPRDRVL01sa2pTVlZp?=
 =?utf-8?B?R3ZjU21IRXYyenljbE9BSEh6U25jaVgzYld2TTB0MllZUmFubUxYL1VrZjJi?=
 =?utf-8?B?RlhBNTdHTS80b01ON3J5bGJQL2xhbUFRMlFpQmUrK2FUb2dpc0Foa3NDbUZh?=
 =?utf-8?B?RWw0bHpoK0p6MDdpYmFGL2x1c25mVk9GKzlBc1Rsb0xST3B5aGpvQ2ZNV3gy?=
 =?utf-8?B?NklScmpqOGJrRnIzY21SZzMrZ0dBbFgyYjl1MDdQOTR5QXNJY3ZCWlMyVytp?=
 =?utf-8?B?VFVGSFJ3V1B6RTgxanZSS2VOQTV4aSs4WEJhY3FWNDl5dXVUdmg5RzI4c2RP?=
 =?utf-8?Q?L+nk1cN6mGtrnM48QeobdINqi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168b6129-418a-4556-5165-08dc6ec86dc5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 19:03:49.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK0NPi8j7xj7Lf6XDLW+tSKFt7EEi496BwB0XNxsWFPigR8Wd+hrHGgeaMGrlwt/usuIrZzN+FG+cf4a8tCsrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484

On 5/7/2024 11:29, Thomas Weißschuh wrote:
> Add a hwmon driver that reports fan and temperature readings from the
> ChromeOS Embedded controller.
> 
> There was an earlier effort in 2017 to add such a driver [0], but there
> was no followup after v1.
> The new driver is complete reimplementation based on newer APIs and with
> more features (temp sensor names).
> 
> It only works on LPC-connected ECs, as only those implement direct
> memory-map access.
> For other busses the data would need to be read with a command.
> Adding some helpers was discussed in the previous patchset [1].
> 
> The EC protocols also support reading and writing fan curves but that is
> not implemented.
> 
> Tested on a Framework 13 AMD, Firmware 3.05.
> 
> [0] https://lore.kernel.org/all/1491602410-31518-1-git-send-email-moritz.fischer@ettus.com/
> [1] https://lore.kernel.org/all/ac61bfca-bfa0-143b-c9ca-365b8026ce8d@roeck-us.net/
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - drop unnecessary range checks (Guenter)
> - only validate thermal_version during probing
> - reorder some variable declarations
> - validate thermal_version directly in cros_ec_hwmon_probe (Mario)
> - drop return value from probe_temp_sensors as it can't fail anymore
> - fail with -ENODEV if cmd_readmem is missing to avoid spurious warnings
> - Link to v1: https://lore.kernel.org/r/20240507-cros_ec-hwmon-v1-0-2c47c5ce8e85@weissschuh.net
> 
> ---
> Thomas Weißschuh (2):
>        hwmon: add ChromeOS EC driver
>        mfd: cros_ec: Register hardware monitoring subdevice
> 
>   Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
>   Documentation/hwmon/index.rst         |   1 +
>   MAINTAINERS                           |   8 +
>   drivers/hwmon/Kconfig                 |  11 ++
>   drivers/hwmon/Makefile                |   1 +
>   drivers/hwmon/cros_ec_hwmon.c         | 269 ++++++++++++++++++++++++++++++++++
>   drivers/mfd/cros_ec_dev.c             |   1 +
>   7 files changed, 317 insertions(+)
> ---
> base-commit: 2fbe479c0024e1c6b992184a799055e19932aa48
> change-id: 20240506-cros_ec-hwmon-24634b07cf6f
> 
> Best regards,

That was fast!  The series looks good to me, thanks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

