Return-Path: <linux-kernel+bounces-268931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2518C942B46
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485B21C21780
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD71A8C19;
	Wed, 31 Jul 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iwave-global.com header.i=@iwave-global.com header.b="FX0azrpr"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2117.outbound.protection.outlook.com [40.107.239.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF616D307
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419589; cv=fail; b=YjVevEKcR/wkREsrk4j3COZWM5cTbBULi99m9qmKIkn5kZqO2UzS1vKQd5zv2912aaMiYIhr5rdwIsFRhjA6BazVyzk3mX1Bhzw668nZHQi7SAXDh3llBSoU+WCA7UZLZEABn2hlbfAsYarRdbEIpQ18fGWjy4lHwIqqjkmLdD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419589; c=relaxed/simple;
	bh=c8OuY9hH5R13b1xSwaz73bKUUwu3t8gVCVhd0Xk4gQI=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Nyoi3lfoHpBA+Vk4ARkF+rGqiNJPBXou6ZTYQZqWdhB5r0hq4HnUpGGjr/ggXtplfaW5N2NKp4T/S7C0SJ0UYdHZW7Y5jAZ0gcco9a4xhi2ML/66DkmYe0C0NchCCH24jlAuYHxJ2J5wv5WWrtepEXacPmak/ipXAcFNqwD0L2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iwave-global.com; spf=pass smtp.mailfrom=iwave-global.com; dkim=pass (2048-bit key) header.d=iwave-global.com header.i=@iwave-global.com header.b=FX0azrpr; arc=fail smtp.client-ip=40.107.239.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iwave-global.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwave-global.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB9jtacU8kmMFuTc1yhPGpQaxXeloT0bxTJ7xYta1JweUt5BP60aO0JYWb7UiiCgtK3XBduCBIf0FlX6KYC2m6NghMttmHUwZ8lh7srGuqXZlNi1BYmVvODZNfGHbyKP/m3xiF/sk3M6TLdG6eZpQ9OsWsSF0EoIXGpLmcbynEES75FoY0ClHliKDJImHVUe8SwkZmWxv1xaoWoJVMTZqkBPNCRzEQkDN4mu5BJpI7KBuDkGjG/gH8waBFJgzuHkUO4Blt8tGoEByuLhMpykNu6GEoZB7lSNLSWjjmAL0qdlQXdq8LO9PchXkpi+lntxix2ae0s9VshsLg3T+wDuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyZFZvEuZGHmsb6hGSVp6RM7XN5sdENCm4vsEvL9BOc=;
 b=eSxNCR3whJdoz6zJWAe3/5fXiB+QEHnLtdRxCdta8Q0mlu/oazp7y1DKkcl94AaWCm0DqN+ictH9qMpUoiydwv79/BFaYUSkEk7G5QLK+VQItV7fVo2oCgnd3P/Dslb1UVpaUq3TnDxfIffJNBX7q1DTR1LFs6e+0vs93tmAoII7eOeXHDD2L/EcRsvmbLbzGUIDTW9jWaG9l1fvl+OtpUfZOdLZeAzHkvF1ukdJf2+KpDC1rmbsNoATZo2uONbSali2aHRHqDEDAOp2kJZ1EJzJVJCTWPdOo8OiyF1qP21OkG0Z62wEUelyodwczx8/09fCo/E7bT8vSvYE7fnEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyZFZvEuZGHmsb6hGSVp6RM7XN5sdENCm4vsEvL9BOc=;
 b=FX0azrprtwyjRFa1rIwpv8/OtyOhC+pYRyvJVFtEc6lhDj7Rv+z/nywTBBzLmh+4BEtOBhYkAkj4V3a1G3y8Bu30MbZduiUtgj4xi9MItgH60KyZNCMtVTEl6HVl0vpoNE54Uj08b2KevRBtKaCUmqJMzPIJMHUeE7jKhpuBgRI33QGjxJ7z7/+jUOxcf+VYQbqX0+gIM8+WxaNjJ4C5Az2pNWBn48Ra14zZ4ZkVFrDj6x8ny7bg0cU5hMkqg04S6LMfRr2rJMfz7kmP6tm0jYbWCW6LBenlU2P/4sAlXN0egrn/l2pLgJrh7nHqE4guslHGBKXTwgqwegqj04X43g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
Received: from PN2P287MB3056.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:231::17)
 by MA0P287MB1089.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:108::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 09:53:03 +0000
Received: from PN2P287MB3056.INDP287.PROD.OUTLOOK.COM
 ([fe80::fb1a:8ba7:3b03:f4ed]) by PN2P287MB3056.INDP287.PROD.OUTLOOK.COM
 ([fe80::fb1a:8ba7:3b03:f4ed%7]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 09:53:03 +0000
Message-ID: <17c0f7e8-5e16-41e1-9b11-a6fa00169856@iwave-global.com>
Date: Wed, 31 Jul 2024 15:23:00 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
From: Nikhil Kashyap H R <nikhil.kashyap@iwave-global.com>
Subject: Investigation Request - Strange PEB Reservation Behavior in UBI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::31) To PN2P287MB3056.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:231::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2P287MB3056:EE_|MA0P287MB1089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8020ba-014b-4043-65d2-08dcb14691b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVdIekFTUEpzdWwvdytjWDUwTHd4Q1NnckNPbDEvRGtOclRueS9hOGNjalo3?=
 =?utf-8?B?bXNsMkNXZUVydDNBL0RES3pLTGpXRnRIcVdxbzVaeVlqeUtXa3NIQWlYbzBF?=
 =?utf-8?B?Q0JzUnlFaDE0ZkllUXZUTmIyc2NISHFhL09KVG5kNE40WFM5Y0E5bERnbStE?=
 =?utf-8?B?K0NPWlduZ2ZkVDRLc1I0L0VBZlhjN24yT0IyaG8zUlRJUGQzTVQxdFA4YW9a?=
 =?utf-8?B?bWwzUUsxc2o3TjZFb09ia3FEekpPYnRVa29SbEpURWM5RkV1cnhTMHJJTkxj?=
 =?utf-8?B?MzZCMGI0UTVHU3BGcnYxVVpNanovbXhZeUN5cFVVVllkd1V2cFFjTjROUDli?=
 =?utf-8?B?UnIySkoyV1JKcEIwK3NJbS9kbFVwKzRHM1NmQW1rSkF0dU9NU0QyQ0ZkVnFU?=
 =?utf-8?B?Yy9hQjBkTm9lSUJrYmg0NDlMckFCVTEwN0ZqN2ptTkZMWnlkLzNjNUR1bWd4?=
 =?utf-8?B?b0dPU3lIU3Y2bTYvRThNWVQ2UllmbFk1RERCRW9Oa0V3SDEwQzhrNUM5akhJ?=
 =?utf-8?B?ZHZ0OVhJWlZIRE9zSWlIbkh3Q250dDZVN1EzL0orRW90YmpWeTQyeXhXamxX?=
 =?utf-8?B?NFN3MnpIcVYzZjlkaStMOE81VTlFTmtlQVVMNkh4dEpudEk2dkRUVTVzQ2Np?=
 =?utf-8?B?Z1ZkUUR1bUhyVys0Tkp5dUtIOEYwTVBjcHozQlZCYnpLYTY4dXZuOHNTMFBy?=
 =?utf-8?B?Uy9RMm1VclFyVTBJN3RhQ2JyZjNpaEx4YXc1bFJ3NXovNVoyOCtUOWhFQVBY?=
 =?utf-8?B?SCtHdkdZRVhERGdCRkRITzYwc080aTdqT21zbEc0Y2dWSDdWdTIzVDdHaXRE?=
 =?utf-8?B?TlNJTmx0YjIxaWE3a0xQN3hqZjdEV3NsQ0lmTmR4N05remxiU1ZNUUdCUE4x?=
 =?utf-8?B?MXVZSVNRalRrWVIzeHpMeElnQm5JOUNySkkzUVFZOE9QOGcxR000dSs4S1Z2?=
 =?utf-8?B?UzNZVkJRbWpPbnFNTlRudktpRmU0Ym1OYkhyNkgySjUvdzcraElab1NSWEwz?=
 =?utf-8?B?YmJPdDNBbHZQR1FSTVNHdE9oa29rYjFsV0V1K0Y1R1A3eXlkVjFLdTFQSGNs?=
 =?utf-8?B?cFkxajlnSTRtVW1oWlJXVEpCYmxXa2NySHZDUlpkM3JRRytUak1ZbHdBQkNO?=
 =?utf-8?B?KzNOZkVFbi9hWkFXQmR0ZFMwWk5YZVdCbFEvWFdyK0FEWXdhays1cFRTUUFV?=
 =?utf-8?B?Z09ITlQ4U082QlIyU0JqVnlidG1QWlQ2clB6cVFPdTU0R2ZnWXdjS25XNms2?=
 =?utf-8?B?NXJHRnFVdVR0c1QrbmFkL0hnblJITm5wOGpyZDJqZ3BSNk9BOW1FaDArelh1?=
 =?utf-8?B?NWwyRlBuUHBFRC9NUlZrQUM3UmloMmQyWS9zOHA5b3VTcHdadmZKNWlSaUlR?=
 =?utf-8?B?ZFdEcXRrc1VlTXFNbXdoYnFIK21DVW9wWU9kVEZybVg2dlcxbGVGYTQwNk16?=
 =?utf-8?B?MUs4SklJTURaK3M5NjVWeWk0L21BWXdXajFTenorQjFrazhNVHVXK1ArUFdh?=
 =?utf-8?B?dEJKeFREWTZibEtQQnEya1daVUJYSTlkVW1hOSs2Wm9YR1NjSGNyTjRYTWZl?=
 =?utf-8?B?bGQ4ZWVoYjRId01WQXhZOERKSFlYSnJlN0wxTGtiOHE3UzFLZERkSzd2eXNC?=
 =?utf-8?B?bTVyUHBobncvQjVZbmVML0JqY2huWHpmL0srSzgydFhPN1MzcTlBOW9yRzNy?=
 =?utf-8?B?Y2F6QzQzaHNzcnpDWGpEUGYza3dQejhEZUdpcUFQR3E2L1NsaktFbmZpNXc1?=
 =?utf-8?B?bTBGdDJJeHBDSGUyKytjNGJyMlVPUm1PZWJnTFNLQXlLVnlrdWx6RjcyNEFW?=
 =?utf-8?B?UjRWQ1QwSW11Snh3U0RGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB3056.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG4wZjBOSXhieHlPNVFYenlsNFRKYkw1dUxKYXFiWGNmdjRJUERRME9YSnpY?=
 =?utf-8?B?d21KeHc2d2xJV09VaTdHZGQ0dHpvblFrM0RJVzBDODFBRjdwb2wzbU81Qkd1?=
 =?utf-8?B?aVpNaWEwMlJ6RzAyNUJmdS92R25ucXZZb0pIZHpicU5iOUpVRUZCeGdXa3ly?=
 =?utf-8?B?VzJqb2ZEeStjRHowc1phbE80MnNaOWV0RkVoM0xlRnp2c091LzlObHhkVGVl?=
 =?utf-8?B?RUdUSHZnOWg3alh2TzZIODhWRkliU3MyeW8wNWV4alMzQlhSbGRjWXZlNnIz?=
 =?utf-8?B?OGNLYmlKTEdHUXY4YU43MERVYWNkWXJ3dmo1RnI0TElSWHZxV1RRMlJaL2V1?=
 =?utf-8?B?MjdNU3ZuUzRFd1paRHljalloR1p4NTJCOXBLeWY0UlZWaGV6UXAzZExaMDhs?=
 =?utf-8?B?cHBSOVMwaWxNc0RNcUpDM1VSLzZvN0JiRnVPeUsrOXd1ZFRDanFIWnVhRlNO?=
 =?utf-8?B?cGdnZTdIaVRjUytieHJERks1VzhNMnNpWXVGZjk1TkN6RmN5czJ2L0hFcW8r?=
 =?utf-8?B?UmlSRHFaZktuYW94dXFMaGV2L3RYUUtqdmt6Q09RUjkyUjFyeGlLUmhkbnkw?=
 =?utf-8?B?L05xQzNxaldUODRlYTVVYlpTeTZIUENONlRhUERtWG1NcDZMNVA3Y2dBajli?=
 =?utf-8?B?aGlNbDJLdjczNDFFZFhIeHk5ODJ3aCtaK2dQVWgxTWo0TmFNV1VvOHErK1FJ?=
 =?utf-8?B?U1NoeEhJRWhIdlVzTVB4VWR4eG1KVlFCcERqNDRUMVRoeUtZT25BV1ltRzRD?=
 =?utf-8?B?NEx0OG9yT1BLQ2ZkS1JnS1psTVkzMTFNbFh0TDF4dzFSam9hdXYyY0VNb0pX?=
 =?utf-8?B?cGdncVVTUGt1T1F3RHdEQkxYK09DZFp4bWdYcXhJbEZMeFpBb1ludjRTN3kv?=
 =?utf-8?B?QS9Gd0xWQzhLUWNOWDNDQmdteHlNOU5LczlRZi9BNFBYeEZ6VkFOMVFSbXg3?=
 =?utf-8?B?Z29vY01XVEp1STZTWVlEM0dSYzhuTksvRE0vWHhnREwxRTFycVVGTXA0dDh2?=
 =?utf-8?B?VCt1dDJzZDVNbWM0dFlITkpRd1RYVkNQaU5hSGdoQUhQb1BKM0haRkI4d1pt?=
 =?utf-8?B?KzZjOVUyVkJ2aFZRSlNjd3A4OXBwRDNGLzh1VmZlUDM2QXZ4K21uMENMUG9X?=
 =?utf-8?B?YThiQis0THZMbXZEWEJXUHNFM29VU3JYMkhwZTczSFR4MjFFL001K0s5cmt4?=
 =?utf-8?B?NC8rRkoyZnlrbFcvL3Voak15bEJNdG9GK0lrYUc4a0hwYTczU0NyWWE0MCtj?=
 =?utf-8?B?cy9RdWlrYk9jd0V0QUkyKzZlcW8yTGRvZkJIMjQ5YzRDTDByN2NQMitoSXBM?=
 =?utf-8?B?N05ycXhTVDBIaHpDY0RTRnNpaHBTQ3hBODI1RHpKeHBGenhSYjFQSWhrWng4?=
 =?utf-8?B?YTAvQUhjV0xLRFNPQzBER2NXTENEcHR6YzNYem9YV2xrak5tRDI2NUx3UjBV?=
 =?utf-8?B?UFFEMzVtcnFpeVlQVm56UHUweXJoaE00L3M0QmF4dXBMMkxJWDBlamhVSXNU?=
 =?utf-8?B?L2JxRjhRY1BrcVNRU1RwcVhYV2xuOWMvRHZ3RHZ0bGNEK1FUTThWMjZoTDdR?=
 =?utf-8?B?RytmdVcrZmMwSFFFUVY4alc5MkZBUFNQVFZqdkp6OFhNQUdiMVphakFIK1py?=
 =?utf-8?B?MFlmQVF5SGhPWGZzdWZhSXNYckI1NGlnOHJab1I5LzJXUnVRKzl3T1dxOFkv?=
 =?utf-8?B?NUtJUFZYczFpNlg1THJXQnFBb1NVODBEL2hQMzhOdXpwMjk4dFBMUDMwTVR5?=
 =?utf-8?B?WkVEclF2QTEzVkJ4VnVmcXlLbFZndi9PZTFMM3hjTTZuOXAySFNXbFJ4OEhh?=
 =?utf-8?B?VHJnMnlVTlJCSXk2eXdWZ21OeFM4N04wb0NxSG5SbWRERFkrNFRiK0dETUJs?=
 =?utf-8?B?OU13U2tsbmdMMXlRTVhpTTdZRkNxWlk4d0lDQldnZkI5cFVNaGFHNnU5MHpp?=
 =?utf-8?B?bDU0NG0zODhKL3loU3c4VUoyREkveTI5VERNQUIvSDhJc0xOM3k5bmp0N1lK?=
 =?utf-8?B?RHYxUDZXSU1PTXVQUzlwNUlOTVdSOVZ3UWViRmFtd2Z5OHFHdTdSYTZUSGh4?=
 =?utf-8?B?NFBWd3hjS3NNODgyWFFlb0JRMEp4N1F3UUh1UDlYNCt6aDFPK3YxdksyQkt1?=
 =?utf-8?B?UXNOc1BKOVdYUXl4cTdGd1pBZEdhYVI3YWkwZC93NXBVTnRURnRKMVlWQW1E?=
 =?utf-8?Q?2Cx2NyU3EXB5GmlV4NgkSK8=3D?=
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8020ba-014b-4043-65d2-08dcb14691b2
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB3056.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:53:03.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HY4bZ3UFz0MnhRpsj9sjsbmjPZ5reIU9q0YCu+M9f4R5t+DS67i0LxBwEIxHghd8q9WPJBxWJPCUMrTdhYV1JoJG9X03R9NqZOK8Uck/tPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1089

Dear Team,
I am writing to request an investigation into a strange issue we have 
observed regarding PEB reservation for bad block management in UBI. For 
context, our system uses MT29FxxG NAND flash chips with a minimum of 
4016 valid blocks (NVB) per LUN out of a total of 4096 blocks.
We have noticed that when using the CONFIG_MTD_UBI_BEB_LIMIT parameter, 
which is typically calculated as 1024 * (1 - MinNVB / TotalNVB) = 20 
PEBs, UBI is reserving significantly more PEBs than expected. Instead of 
the expected 20 PEBs, UBI is reserving around 160 PEBs per LUN, which is 
approximately 8 times more than it should be.
To work around this issue, we have set the CONFIG_MTD_UBI_BEB_LIMIT 
parameter to 3, which corresponds to ~91 reserved PEBs per LUN. However, 
this strange 8x multiplier effect is concerning and requires further 
investigation. Additionally, we have observed crashes in our system and 
suspect that the over-reservation of PEBs for bad block handling may be 
related to these issues.
We would like to understand the root cause of the crashes and how the 
excessive PEB reservation might be contributing to the problem. We have 
some similar questions related to the PEB's usage in UBI operations:
Why is UBI reserving significantly more PEBs for bad block handling than 
expected when using the CONFIG_MTD_UBI_BEB_LIMIT parameter?
1A) The typical calculation suggests reserving 20 PEBs, but UBI is 
reserving 8 times more, around 160 PEBs per LUN. What is causing this 8x 
multiplier effect?
Does the issue of over-reserving PEBs only occur when multiple NAND 
partitions are grouped under the same parent MTD device, as is the case 
with the custom driver? Or can it also happen with a single NAND 
partition per MTD device?
Is the over-reservation of PEBs for bad block handling related to the 
crashes observed in the system? If so, what is the root cause of the 
crashes and how does the excessive PEB reservation contribute to the issue?
What is the expected behavior of UBI when reserving PEBs for bad block 
management based on the CONFIG_MTD_UBI_BEB_LIMIT parameter? Why is UBI 
not following the typical calculation in this case?
Are there any known bugs, issues or unexpected behaviors in the UBI 
subsystem or NAND flash drivers that could explain the observed PEB 
reservation problem? If so, are there any workarounds or fixes available?
We would greatly appreciate if you could investigate this issue and 
provide us with your findings and recommendations.
Thank you for your assistance.
Best regards,
Nikhil Kashyap H R


