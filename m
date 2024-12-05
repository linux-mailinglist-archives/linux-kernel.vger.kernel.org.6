Return-Path: <linux-kernel+bounces-433483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FCC9E5903
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C7F282F26
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947A221C197;
	Thu,  5 Dec 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="W27HlKES"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D29219A7E;
	Thu,  5 Dec 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410712; cv=fail; b=DwQH59bQfyriLQNnbLbIZGUbhWIzz+8o7dODt+6gYZJ9l0kITGz/rk8enYyNd2QnWED2+CcL4oedpoAajOCLX5Lu/dfodTQDJMFCk8wQ+Cj2KvwKu19T2MwjNvLhKwMijAvZ6YDa6QHFMWwLhwkLcgmp3Yr9bwrMnH60Bn9WnZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410712; c=relaxed/simple;
	bh=5sjBzI5Rvj2OrNN2dUKx3p94jdhQk7/tVbzHo+4pXkw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQ8UH182zaeqUKubEt4onwpAFI8bS+pkdXc6B2tLU0gaxGFgAeYgxaj2jkfwHhznWPgQJpa6UUh1WluDeZwvZGuwNd2cl7kRKzgiHIVPE4qZ4PAn/7RDNY509B673pLu1lDN5iwSi+cvwNB7olBDCr49yXFwQSeEQeEO0lM1ua0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=W27HlKES; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5DYmsV018033;
	Thu, 5 Dec 2024 14:39:55 GMT
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010007.outbound.protection.outlook.com [40.93.131.7])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 437ru2jtg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 14:39:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi1TK9nrVr63oY0q9QhTbtIPR5Z7aGY7xiQ2OeXeVhRhi1sSw/aLq5Au6SIoOVYhspaIZM07chV7kt0UYTPuoeDQHZy2fbeEMAEvURKUnUdAewp8tFHsQQH9Ra0uY3xgfIrRj7y7pjMXHzJIQUXQ9sD75JLSjq8ExlcuLIgzwiALj7uRvromXZCw2TeYL5JfKsqrJEkmuMsMDraFqPf8RhLa2GCTcDsPJCw8m17qMMbwfe+JAjltftuBmLfvnzmwGpIIWuYFCo2EnOhTeeLRlHnjBspBWestkEqx3kCzMfjb5AOWmzD8WPl/GaZ3/ahFM0RpvTad00hPjRfQL+/oFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+9zBYJJndepS8UkyS6tR+fa5cOomGqvRTdR7wj8OR4=;
 b=anaxm+sVisi9CCkCrh2iZ9H3ofI1BbhYNJXMpuzF07mY++3XyRItjhgeA/Hhc8+13xZIiMzMQmSjwJDiuCYe5CjXq2a5yqsWBuvQl5waocZE90oMQvEbPMxZnetfTRJ1kNWTMR01foKWXbqpQn3Dext8bkYLmRhskVJg5pbTfgFyr9x/VBz9ZBW2HDzPdcPRv/AA0ztfurYl2a9eSVuLI6ittT4uqLHvJeV5PnLHtEXe7V1W/BMzFslc9bcu14qSjaXYOX4oY/8IdZUNgFatVQhP1WaWqEmwMPtVgsouS3txlMQAmg7YBEoYzX5cXQRZIEfG0OkiN5jAKiToqPVAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+9zBYJJndepS8UkyS6tR+fa5cOomGqvRTdR7wj8OR4=;
 b=W27HlKES1VavhB7v/ZYamW3T6BBuDwp0wdvLuo3e5NdL77IycWlpgJTGq6XfH0A0boWDYlBnul1ktTPe/BVZX8P36wiKonVLA3U0RdoNwXAgTxrBrZ7U5Kb7e5xa35YKL0TV9z0Yz5rxaHe+LTf+6XJUsAVtZuSC8bCpzc5iDB4=
Received: from BMXPR01MB4501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:7::7) by
 PN3PPF79C418DDA.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Thu, 5 Dec
 2024 14:39:48 +0000
Received: from BMXPR01MB4501.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::be1e:370b:bafc:28f8]) by BMXPR01MB4501.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::be1e:370b:bafc:28f8%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 14:39:48 +0000
Message-ID: <5ea81796-b871-4a4b-8984-6095d3e06d4c@blaize.com>
Date: Thu, 5 Dec 2024 14:39:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] MAINTAINER: Add entry for Blaize SoC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        James Cowgill
 <james.cowgill@blaize.com>,
        Matt Redfearn <matt.redfearn@blaize.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@lists.linux.dev
References: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
 <20241204-blaize-blzp1600_init_board_support-v5-6-b642bcc49307@blaize.com>
 <h5awakp52e6pxnnfrclhtlhhs3i66twvmqwlf5vmnfwk2xhbwr@marp6wti72ti>
Content-Language: en-US
From: Neil Jones <neil.jones@blaize.com>
In-Reply-To: <h5awakp52e6pxnnfrclhtlhhs3i66twvmqwlf5vmnfwk2xhbwr@marp6wti72ti>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To BMXPR01MB4501.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:7::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BMXPR01MB4501:EE_|PN3PPF79C418DDA:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed2a286-35f5-45e1-2e16-08dd153aab47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnNZSXlXMDAvZm5henJZdXNFQlpQcUtzVTFGRis0dTNQamJFd2NDYnkxR3JU?=
 =?utf-8?B?UFZSTkFHTjNrWE1IMWdZc2RCN0IxQUIyc2VWbXN3NkpkY29xck1HV3dWWWl6?=
 =?utf-8?B?T254TVc5NmQ4YTRaa1drMmNTYU9rTXE1aENrVHJKUFpRSzNqWkpENkJCQ2k5?=
 =?utf-8?B?LzNDUVFwQWRIQzZCNWp4ZXJ4MWM3N2Q0MnR0cm9HdVkyZG5XMWNvTHpBYTNX?=
 =?utf-8?B?VHdRRWRNZ2VEQUdlWkVIL045b0NXUUFNdUFhcWdudVBwT0xRc2dmb3RtYXVu?=
 =?utf-8?B?Y1d0SytWOVZzcy9jdm9xNGc2Qm1xSkg4cG5PMThySTJsMEhjeGIyYkV4Y2tN?=
 =?utf-8?B?WEhsSFJlM3BwaWJyeUVZTHlDRklCMmpiNXdodFJyYVM1Y2FXRk00eVVkRlkr?=
 =?utf-8?B?eGtUdTdUc0ZEbTJCVENRKy9KR3F0VFFIYXgyMjJWbzdPallIcU5XMEZtUzgr?=
 =?utf-8?B?QmptTlVuQ2R3cm9lWnNISDZ2cnI0Z3VZeHNpVXhRUkpwUS9mNjh4YkFDc1Bk?=
 =?utf-8?B?djRKbXhoMnFMMXNGSnNna1NEWXFuMGt0Q3YrNDNMZDhYN3dSd1Zhdis1Mk56?=
 =?utf-8?B?dkZ3NmwvRmtaaHlFWG9xVXZmWHdkOTEyY3Y2M1o3TVdpTWJzQnpyUXRsS3NC?=
 =?utf-8?B?bWJycHFHVkl3MG1OaFFDUmdGd0M5dGVkV3g3blBmY2FMU1RLbFVrYjFXalBL?=
 =?utf-8?B?Mms0V05USmJ4OTRSYktOaHdWWU1sN1lVeUVkV1BiYXd5WERRajNpWDdJS2wy?=
 =?utf-8?B?d3JoTjlsWVVRY0VNYURjS0tPNWNyMEQwSE5LUXhONHVpSENobnFJRGUySGJ1?=
 =?utf-8?B?d3F0TE1BTmpiY2FNUFMxUWJETm9lWUcyQUZ0L3BSQlA1VFBub2k2U081enFs?=
 =?utf-8?B?eE1TdTZObnlnVmswZ0NzTlUva3F3dVk3ZXdETlpSa09ndEZmQ2ZDZzVvWFg2?=
 =?utf-8?B?dWNSM3MxbEVoZUtsOWRVRUZhREZhL29Ba3VDNXBHSzBQdnd3cVd1SzBjRWIy?=
 =?utf-8?B?REV5V0ViK2tIREg1emwxSXZPRE9yZm9qUXoySG1HS01pSTJDNGsvaDVOU2Jo?=
 =?utf-8?B?aDArNks1MmdhcWZhd0FyNDl2aS9Jd2gyc3RURUxEZlFLRGQ2R2haRjlBTCtv?=
 =?utf-8?B?elRtZEJ1UlBwRTdvM2FkSUtBUHNkanhQZHVuaXo4ZVR5V2NYNy83R2ptcmpN?=
 =?utf-8?B?TVNldUZtVkkrdXlFdlhWRTZXSU5LS3pTd0FBb0VybHl4dC9ZcDcvbE9rRlFj?=
 =?utf-8?B?ejBQRG5LbW5GL0ZlZjMrbmFjdkw4eHFPTDdLVFM4UjJ5YjVvRitsYldiaWFL?=
 =?utf-8?B?RFdpQ0pScHRIUXJuSG9ITndXQm5JdnkvTzk0SWtuU1YvQlRuNnVXaFVBcFFl?=
 =?utf-8?B?SmJQWU9sTGZFVFpGcmttWEJFL2NkOFpGMlJMdW9MNWIyYm5BSmUwQnhSWnBZ?=
 =?utf-8?B?UXBFWEVyNHNkMHR5ZkY5OUZDZ2NsYVNnTkJpWkFsc1ZNeWxaVVFaVTVTeDdZ?=
 =?utf-8?B?MWtaeGNRNndObXplMlZLYURHamhLbTdtNkRCVS9GS3FKdm1tRVJNcGxZUG5x?=
 =?utf-8?B?T3oyWHFqR1QrT0k5bUFHOG5lV1huc3RKa2lOYm5KVjhoVjRRR0xFdU1BR1ZP?=
 =?utf-8?B?bHhURURKdE1CaWw3aEx5NEhOL0thTEI1ZVJ2NkVEMCtJVm16eVRSOUVzbW5k?=
 =?utf-8?B?MmRRLzBIMG96WTUyZmc4cG5pblZrK3h1S1FiUUc1ajBXVGpBTTR6T0dxQi94?=
 =?utf-8?B?MnIzemVqSWt1NktVeXIzRHVYeXVUY1pVNCtwd0FBZDRCVjBFdVBsL1RMUDh4?=
 =?utf-8?B?aDVqdlB5Q2ZXL2xNQ3MrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BMXPR01MB4501.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RndyVGxBck0reVVnKzFKbU16SkFlNllYUGk3WlVBSkUvRTZzKytjTkxJU2J2?=
 =?utf-8?B?Q0x0NUpaTFVtNFc4ejVtNHVRVmRGWDZwZGRDYzZ4dG5CUkN3amF5emliVy9C?=
 =?utf-8?B?VmJIQjBtYXJua0VUTS9VRzZFVms0M1ZIazFIU3pqdDUzZ0kvWW5QVE8wNndG?=
 =?utf-8?B?ZThkY05GUTcxYzZoQ1JKY29BMHlLTlVkUXRYUmMvVzFaSnlxYkJOdDBQNC9S?=
 =?utf-8?B?Q29QWVBZQ3R4SHp2b1V4cE5uUGRpRDBBZzR1UnFKYzhJcFoyZ3R5U29GaG05?=
 =?utf-8?B?eTJSZjRPaVI2dkVBb3ZmazZXMzBTL0l2V1V3amttQXJjNHpsUUdiWkVYWFVl?=
 =?utf-8?B?dXFleTBpL1dzcmFyVkxsNjNHSkNsb2tsb2IzaGdYR2NKZThpNzhqZTl6V3Ev?=
 =?utf-8?B?Y3ZyeXhXQlRoKzg2MnNBdjZLMDhDTEkzdWhTNE1CWHo2WldEZVVOL3N4cEly?=
 =?utf-8?B?QzNTR1RENjVvMGc2QWZXMmJWLzlYOGp4bXdRVWM5SERMU3NUVlh6OCszV01W?=
 =?utf-8?B?SG83aTUwQXBPb0lSQ2pQUFJvWXZ5RzlRbVQ2TnQ0RTcrMU9CUnJ5RThTWGNO?=
 =?utf-8?B?c3VOUFZ4cDlqQUdwNEhCMXZJczk2SnU5WXBCcG1jRGxQNmhabENuZ0I0d001?=
 =?utf-8?B?Qkc2a2p4SnlrTk4valhFQjVPd3FScUVKZGQrODNiam05a3Y4VmVHaURjSlc5?=
 =?utf-8?B?Mm0vMFErNnVjbUdkc3JpQmV0U0xyZVpwb0lvVzRKYVdzZjVMNXlKRTJVVW1W?=
 =?utf-8?B?T2VVRGlLQnVnS0VUbkRoc3hIQlcvVHJpS3RKZm1EQzlkUWVyZS96ZlBwTzdX?=
 =?utf-8?B?d09yL21vMGFVbWZvY1lyNXNjUG1IOEh2UHkvWklkeDJwbnVMUDZvS0NGaUFh?=
 =?utf-8?B?c1M1TnJvZTFlRmRWREhhOG56RWx6R29tMTVkY3gxNGZlZnkwdFFSV3BhbUhP?=
 =?utf-8?B?a0NPeGZ6TFNIM3J2UHE4M2xmTTJpazAxbUxFamtMVGd1dkxzQzEyRWpNR3hW?=
 =?utf-8?B?NDhrOFNWN2lObkwxaFk4cnY4OHczRFdydHQzV3NtTFd1WWhBZCs2NUJaZlJM?=
 =?utf-8?B?VCtCUFB2emQ0S0NUemVkTytVT1VzNGRzSVJKaW9qNHJBNGVodzFoS01wOEVP?=
 =?utf-8?B?VjJvTTlYSVZCZ3YzYzE5cTBDUGlKMi9tWHQvc2hLb3k2U2h3UUYzRENMOWk4?=
 =?utf-8?B?ZEdpeGxRbC9UcldpSmxkaVl1d2laeFNXL0tVcm5FN1BCblljcGFNTXpMRGIx?=
 =?utf-8?B?c1BucUwzVkRKZ2FOYlIxN2duOFhQY0hqYjBzanJpMEgwbFZPQmJNSTNUckI1?=
 =?utf-8?B?aEE1RlpMOTdGV3h6djhVZ0VuelNHalo2M0dHQTBLS3V1ZWhRbFgzN1FVRlZp?=
 =?utf-8?B?SWpQckoxVHd3dnRmUmZwcG9rSUdSeUE2blpEbXFyZWllQUdvb1RDa1hOcUpW?=
 =?utf-8?B?UVN5UVVEeHNQUWVIZmlUUVpqV1BjMGJKOGoxNnU4dWw1OFlJS2RpU3F1WXVn?=
 =?utf-8?B?Zkk1Tm8wZUJJUjFwVVpwYVAyLzl3UFJtdnRtUFcrYnphdG93UGFpOVpsVGlD?=
 =?utf-8?B?REgwaTg4RXZWL2dXSUxKNVMvUXQyd3FBWVdtdWQvWjBMWWtiZzVndVdpKzZN?=
 =?utf-8?B?d0VETDBzNVJpUndkM1hXeWdkNXFhOUVQeG0xVDFFTTF3RlBoNmZralB5cDRn?=
 =?utf-8?B?VEE5WjgxTDBMc1l6OHJiWUZlNW4vNEpxU1BER3M3WjRTZk5ueDVaZzRhVEVn?=
 =?utf-8?B?a2FCYUhwME42dE9RakdlV2FXZW5YcDMxeHVJbWNrR0t3Z1RBTGdaMllCZGV3?=
 =?utf-8?B?V0UvNXhqNGQ0ZVI2RFN0T1VqeGJVcmlFQ3VwRHk2MXpkTFhCbTdWcXhzQmQr?=
 =?utf-8?B?WWZhd1prZkVQVGtVOFppOVdtcXZZQmRNN1MwSFRkK3FoNDVFY2wrZWxiS2tz?=
 =?utf-8?B?N2hyREgxejMva0ZXUHVZUndncjh3WnRmbjM2aTZwMG1RV3A3dnFYeUZNanR5?=
 =?utf-8?B?UWNHZktocXB0bmtZSGhCSENhZFBuSjVXTzFrZUxVQTVzM0NtN1ZheXZYWjlj?=
 =?utf-8?B?eE1BMFN6dWNwZDBaTzhkMjVqNjBUNlBoblV5d1kzbkdVaVI0QXJTNXpwaUxK?=
 =?utf-8?Q?MnaH8Eml6XZx0DW3GEOhoorl+?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed2a286-35f5-45e1-2e16-08dd153aab47
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB4501.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:39:48.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuE1W0HegHUOkzA8jOCh1al0Z68/CDc+mtTjwF7gb98DAFahVzBafDKwk3/uhQGAeqBihjN+HrK9W/IWnMKovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPF79C418DDA
X-Authority-Analysis: v=2.4 cv=PZ4Fhjhd c=1 sm=1 tr=0 ts=6751bb3b cx=c_pps a=FFLylZiDLwIlbiPAFpMsJw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=KKAkSRfTAAAA:8 a=PCyhmlMXcn13G0RJ0bQA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jSLomjjLqcxd-fcomEz-FqNiVVXkYkbo
X-Proofpoint-GUID: jSLomjjLqcxd-fcomEz-FqNiVVXkYkbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_12,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Reason: orgsafe

On 05/12/2024 08:16, Krzysztof Kozlowski wrote:

> On Wed, Dec 04, 2024 at 04:05:29PM +0000, Nikolaos Pasaloukos wrote:
>> Add MAINTAINERS entry for Blaize SoC platform with a list of
>> maintainers.
>>
>> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
>> ---
>>   MAINTAINERS | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 273a84483b74543b510de7b08804bbd1f6514358..43846a23f9d990ae9fe066e65ed2bdd36376e327 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2238,6 +2238,15 @@ F:	arch/arm64/boot/dts/bitmain/
>>   F:	drivers/clk/clk-bm1880.c
>>   F:	drivers/pinctrl/pinctrl-bm1880.c
>>   
>> +ARM/BLAIZE ARCHITECTURE
>> +M:	James Cowgill <james.cowgill@blaize.com>
>> +M:	Matt Redfearn <matt.redfearn@blaize.com>
>> +M:	Neil Jones <neil.jones@blaize.com>
>> +M:	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> Just to be clear: this is list of active maintainers, so all above are
> supposed to perform reviews or maintainer duties. This is not
> credits/managers/I-need-to-please-someone list.
>
> With the assumption these are active maintainers:
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> They should also ack it to confirm they understand the burden.
>
> Best regards,
> Krzysztof
>
Acked-by: Neil Jones <neil.jones@blaize.com>

Cheers,

Neil

On 05/12/2024 08:16, Krzysztof Kozlowski wrote:
> On Wed, Dec 04, 2024 at 04:05:29PM +0000, Nikolaos Pasaloukos wrote:
>> Add MAINTAINERS entry for Blaize SoC platform with a list of
>> maintainers.
>>
>> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
>> ---
>>   MAINTAINERS | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 273a84483b74543b510de7b08804bbd1f6514358..43846a23f9d990ae9fe066e65ed2bdd36376e327 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2238,6 +2238,15 @@ F:	arch/arm64/boot/dts/bitmain/
>>   F:	drivers/clk/clk-bm1880.c
>>   F:	drivers/pinctrl/pinctrl-bm1880.c
>>   
>> +ARM/BLAIZE ARCHITECTURE
>> +M:	James Cowgill <james.cowgill@blaize.com>
>> +M:	Matt Redfearn <matt.redfearn@blaize.com>
>> +M:	Neil Jones <neil.jones@blaize.com>
>> +M:	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> Just to be clear: this is list of active maintainers, so all above are
> supposed to perform reviews or maintainer duties. This is not
> credits/managers/I-need-to-please-someone list.
>
> With the assumption these are active maintainers:
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> They should also ack it to confirm they understand the burden.
>
> Best regards,
> Krzysztof
>

