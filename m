Return-Path: <linux-kernel+bounces-236618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0DB91E506
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 727BEB216ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B33116D4FF;
	Mon,  1 Jul 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="N7jxd3f4"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2112.outbound.protection.outlook.com [40.107.104.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695616D31E;
	Mon,  1 Jul 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850449; cv=fail; b=BPBQO46ElJqLur+puQMPQzjjYhSyG58WSzZuFGKJclHbHO6ZcXgApWI+Jyk5pg6SFfubIvSJUMSPTs7r1ssJvzWGP+q0e5RxuId6PGGl2CyqZ8smCM/2XF6RGBBX8hZ9HezGkzfrCKF2m8XY7mGQlIL41LyX3FiJanMHPzjk814=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850449; c=relaxed/simple;
	bh=MbfMqxO7OEosWa7yEHD4R0gsVuUcI4Xpc1NXNriZjVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gLhAt1qDmN6sNZQgAvkMbZhsTl3yiBfB3Q5Z+6qEAEQCg3G9XE6i5L4mjTsXmDCCvOHRHpj8F4hA9H3pQhzTPMzn5+XZZS56RROEBmj8ZyuZY7t1TkghyIvt94xjX9g/007RqJawllM3Rqso60Ev+UydeUd+irEsxa+sAKDv8pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=N7jxd3f4; arc=fail smtp.client-ip=40.107.104.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAGRW5eReVeTIZzL3HK0l+4b0aEDGqFUslVnGByWJ1a+FhIcI8rybtRo6s0O5vPwdbpsxx7I4e0zyi6r8RpB6bMs2C30FcHxdsWGWN60kppLeufoDdj/jX22wQYr3D5NCcdyF5ZQ2iyn4BWAPiiNMokylkBq3OylznyUKfaJNXpBMZ8oZnBLbuiYBdpkLKJrCsfAaSadj4IGOXqH2NnfH4PXufZs2HhhV3yYpOIB3MwtudItPGl68CnP4wkREc2ufhB7Qwp08ltYYV1nlofnVi/ghZpTXFdVUwmPTCKxdznCOSuHjedvC0HGaFdzklXL3H6RUozKI670LJLnTNN2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOXc9N/YDlIV8rIfW0DXdy0HTqWkUnhqzV4LK7iVpXc=;
 b=XWM+logmYs0umvbrMM6GrfqeVfCmYvdiNbvlbzrQUeYJNXUN0XKSXlFyqMutVDmkzB/Ena/Vrw5XAnkhTl3jK8j1t29HQoFCnwfwoeUJ6VDgdeBNEt8iC3DhcCJEHxnpIFM+opQjls/MuRL3rccrqaxVCZfh7J7OHeK10E5Yt12NZ+M0qlbmI/YJnasUGUl9/WquhtZSE7iVNQmGhi/dELgfuB9p4PSX8gb4h5dOjrOtuwxMzMgCWhMsPw/AxUYrhiAKHf1cywAzdA/HrMTcVRVucrpMMp9J5a9m94PCDeAhQpu9MKC2bJbOIIgvG8Pmi4XD5sJtKL/825qi1BuEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOXc9N/YDlIV8rIfW0DXdy0HTqWkUnhqzV4LK7iVpXc=;
 b=N7jxd3f4x2XTDQZ6bmsxPyWAoYsdW6MKeoId+1joESTMhh8zTUYcgOXSlTPIGfh7e/F2yzFuGGD9q+slrS21Cb3GyRlkbyeM0RmWYihHX51JIENqv+c36VVC99Y8q/DMxJjxb+1xSOuVnxTx7GS2JaRiiBH1e155f201DhSJm80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VE1PR04MB7309.eurprd04.prod.outlook.com (2603:10a6:800:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 16:14:01 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 16:14:01 +0000
Message-ID: <535f3381-2fa9-41a3-896a-8d5879546ac9@cherry.de>
Date: Mon, 1 Jul 2024 18:13:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hwmon: (amc6821) Make reading and writing fan speed
 limits consistent
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-3-linux@roeck-us.net>
 <615377cf-99bb-4159-b072-7992ccddf09d@cherry.de>
 <9fce6789-edc8-4c44-89c0-ae4ca3ec3315@roeck-us.net>
 <80a7f733-655e-4b00-a802-825d3acaafcb@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <80a7f733-655e-4b00-a802-825d3acaafcb@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VE1PR04MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a11ab8-c6b3-486c-2643-08dc99e8d1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTZCK29RQWk0K0QwVThnODNLQWFqVUl6WElVbTlFdDV6SzFNN2ZyK01RS0Vn?=
 =?utf-8?B?SldUMVZ2UDFGNXFhMTVYRWxlMEw0UVpMRDVSYUZqS1laYXNBbTZBTUt6YWFp?=
 =?utf-8?B?QllwZDArMCs3VlkyNVR5TTB2UjViYTFWQWE2ejhlb3U4cVhjZk5xdks5OER1?=
 =?utf-8?B?M3hNYTZ2UGhNNTU0VXJiOVNjMTViQ29rQU16NnB3L3VPRy95eUM2RGkvK0p0?=
 =?utf-8?B?QkI3dFdNdTk2YS9Rem5CQVkxa0RtdmE5Y1RKdml1ZVgwWjVFdFZuRCsrc1hV?=
 =?utf-8?B?WTFVZTRMMWlHTHp5TUg0M3FQZStmVlFKdWhNdWdycUZ0WmlaVVIxcEh2UHRv?=
 =?utf-8?B?MkwxQnZBODFOeGVEUWk0dGQ3TjljMFhVT2Z1c3lHc0hhYnZDMGVHcWVpSGN3?=
 =?utf-8?B?aFpaenJ2bW82ZlpBWTBPRG9sUWJHcFhtSXU5dnpadnU1TmF0SjVPdE9FSUNy?=
 =?utf-8?B?bXA3OFlXMEltdXE3dWlyeWJ4blEzeDJtV2J6VFJ6d2srNmNqZi9nQUd0TWly?=
 =?utf-8?B?OFRCbEdIeThlNzRUNkZsYWRqT1Y1UUV1WlNxOG5nYlZ4VENuYzZKYm1CdkFm?=
 =?utf-8?B?dlhXNUtyTlVQTDkyWWRtdFc3STA1MmtybnpJUCtZekRSZzdMSG1acVhEOHVP?=
 =?utf-8?B?LzgxTjNpSlB4UVVod0RqUzk1UFJKYkRuWTBZNFBpS05lanFYczZ1U0FTdmll?=
 =?utf-8?B?QklYRDRGZkJNL2JJZEltTWlWUGEramlXOERYcXlkU3ppSHMwRkUxU3lIZkoy?=
 =?utf-8?B?L1JGTUl0czlEcndxVDhwdVp5QWFtQTk4djNxQkJwa29rbUM0MERnZlJZd1lD?=
 =?utf-8?B?TW1FaXZjZEJZS3kweDlER25DVGRSU0YwaS9sZys1alFNbzloemI0U2Vla1k0?=
 =?utf-8?B?SnVYNHZpNUUxVXFCUTQxKzJMd3ZveHJsRGhublkwMkZoRFJsZjRMaFdpNlFL?=
 =?utf-8?B?YjJzR0YyQklEZVZscy8rMjgrUFU4eFNJamhiODhucGpYbTlZK0FkV1AxVkFk?=
 =?utf-8?B?YnlJRkFyelcycmlvMFlYcFk4cmRjV0xlN0ZnMFV2dm5DQm5JUE1aOUVFMmZr?=
 =?utf-8?B?eUdLMjF3TWh0dGxaamJiZHZvWE5EQ0tyTHI0cDR6MDRxd1lDN2NIQkFrRnpm?=
 =?utf-8?B?NEg5TUZseHlsNWNZUVU5cDM5QzZldzdwamo0Vlk4VWJmcm1nK0h1ZUs1Uk5Y?=
 =?utf-8?B?NVZaOEpYRTJZUnVKQjZCdENPZFVNL3NZTWN6MVcxaE01OGpJbmRkNHRad2xP?=
 =?utf-8?B?TzIzV2VFam5VSStiRFQzajF1RCtRbHJ0elBzWURXdWJnSmFxK0VzMGxRSWFP?=
 =?utf-8?B?U0Z5Ym5wblZzYkFJQ2F6biswcWgwMjRMZFJ6R2ZWNXV5aFlVWXFCZHZ6aUlt?=
 =?utf-8?B?dUswM3FXWUZueWJlOEtKQTZtbjl6b25tb0RzV3UrQTlyaHVMUW5iaTdFQnpm?=
 =?utf-8?B?ckNNamNiSysyMEpHZmVlVzl1L29OeE90U0tLNGdpMGgzU1NlYmVLSXhrVk1z?=
 =?utf-8?B?NzFCclRLNVFOSE5Ua2libHYwcVNoL0pDenk2THd2N1pCUG5ldURoL3N4VHN3?=
 =?utf-8?B?N0MzQ2lpK2ZJS0pSSktPR1poTnNRMnhSZEVHelRKUTZCak9ySzEwWi9pWnBT?=
 =?utf-8?B?N2RkWWZ5YWV4KzYwZkpJUGNjVUlZUVA0aXVhYU9yQUo5VWdBK000WFNZRTRo?=
 =?utf-8?B?YnJOZkZxQzRsWFlZcWFQYXMxQ3R0WjhsNWtBK29lcDkvcnlwa0huVVFXZGVm?=
 =?utf-8?B?NFpSZFJSbTI4NTk5bmJxZVZ0eURPL0hpRkhpWVplMlk0U0JaWkdDbUkyUEF2?=
 =?utf-8?B?MkJndGQxODBtVzJtWFlVZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXZ6aHNMdG15OHNQNFZ0bG1hSUM0bllQYnhUVUQxMEFGR3dxeEFBeGtUQUpp?=
 =?utf-8?B?MXJXZFlGZEJhQ21kam82YjBqK2Z1Nkd3M28vZzlZOXQ3NjU4REJsbWdnWk13?=
 =?utf-8?B?V1lXS0VGczhxcjlXUVJtOFFoNVhWb0laaDArRHRkWmJ6Tkk0bFhuTFQxNjVt?=
 =?utf-8?B?bkpGbGZ5Q081S0NEbEFBOUUvUm9LS2ZZNEhzU0tsUlFWWXZaVG1ISmVBSHVM?=
 =?utf-8?B?cG1ONWFJS0pEZnFRRUIrR3ZZdFJubzhCRURKMkxhVVNpV2dEYlllQy8zZGRa?=
 =?utf-8?B?dWFrYVBKMEwxcTN2OVVvV1pqTWNkRWFBWEs3UmMyNXRhcUZWVkxNeHRMWXFQ?=
 =?utf-8?B?Q3NUNllIamlVZmRqR2loWisvQXNISHllUm41cTMvNkN2NkVDeDRTRFNUcVJp?=
 =?utf-8?B?V1RyS3pmQlU3TkpCYnNRNkNSaExHNjBiTG82Q0dIdWlZczNma0JvZlQ2bWVK?=
 =?utf-8?B?SVpneHpuR1RqZG5CS3lNdFIyV2pHeDVTTUl0MHdFOVZRMWxhQWJ6K01rQldM?=
 =?utf-8?B?UGxlWW1yenFDcGJvdzlhdkg4YkI4NXFKUVFQclZnYXZHL3gwTkJpSFk4LzY5?=
 =?utf-8?B?ZUsyNUQ4RlZRemV6QVVOMzU0SWFuVG85YXlZWkh5c0pXSnB1aUdUV3hlQXly?=
 =?utf-8?B?QW1UZjk2UTc0WFBUMHJnM2NBTk9yYjVrZU52dXJ6WklEL3dTNHlSQXR6Smd6?=
 =?utf-8?B?NkhlT3dqNThTYURhWnplcjJFYktnOXNJTlhxR1JIRllpR2x6Y1FrWUJvS0Zh?=
 =?utf-8?B?VFhzQkNJRnJ5RDBFd2xlL0l0YkRkZllSNDhCNzlYaFpNUHd3Si9GS3VDbTJP?=
 =?utf-8?B?VlhnWnJDRmJORFZMeU51STA5T3ZlcXF4aW5rdEZobXJ4TkdJdjFSRHN5STBp?=
 =?utf-8?B?NmNIVjB2citWSGdwcjJMTklZSE9ieWJmbjRaemtGV3F0Q0N1Qi9UVlVnTUVu?=
 =?utf-8?B?cjMyRE5XaitML2dwdFgrRmFlTkFnOFJTSzZQVmdZOEdNU0NsVEVBVjJUNnBD?=
 =?utf-8?B?dnFRQytVd3FWaU8xQ3o3bFZDWlYrUnJxTlNFQWxwaVlnazErMmpublVJQ0VX?=
 =?utf-8?B?Y1JOY2VkWmNVb3hTYWRaM1RPT1hMNWt3Q2xOMGVVelM0cmtod2k2ZU1Jc0g0?=
 =?utf-8?B?UFJkZFZlOGo5OUV3TzRPcW85UjE5cFZYKzZxWEhTOXQ0elVERTVIUHdRRVph?=
 =?utf-8?B?ZloyMktGaWpWUVA1bWpZVW9GdmlyYy9VNXNHWDI3UjU3Q1ViUlQ0dlhSaVRS?=
 =?utf-8?B?QnlqRDhmbGNwUjNWY3N0TlpxdEJ2MmdEcjh2NEJyOWtZMkcwR2huVEJqQzlq?=
 =?utf-8?B?ZGhIa0FkWi9mVGNxWWlYOHpIU3pVUjNTQjlQRlhuVkpKZk5kTHg3aEEwemo2?=
 =?utf-8?B?c2liL2YzbEltVDNrMDViUWVYdUVyN0htOFVjM0U1Yzk3WkppdFVlcDFtZ2RE?=
 =?utf-8?B?OTFZYVJTdzNhaHF6Ym43Zk9QK1BiSGtXM1Z3SnY0cGU5SG5La3JsdWs4Y0dR?=
 =?utf-8?B?dU5mOWJNbllzYkFkUUtjVnJ6bU1rdUJ6SFc4QXZvMlg0andUR3Z4cmNGbU84?=
 =?utf-8?B?aDNRLzd6emF5dUJxMG9IYStXM0pma0ttZ003N0pQUVFGNDJJSHhaMytxWTFP?=
 =?utf-8?B?RE5RSElTaWU2cGhTSGlxNDVaTFBNajhvQjM4VGdWQ25zcmwyYzlXTWpPOEJl?=
 =?utf-8?B?amFreVRxL3hOVU55U0NrdFdpOTRZSmRna1JtaldjZi85TjlFbWg4V2FCWm01?=
 =?utf-8?B?MEVEUG5DVkN1VGkxQWViN0hBS05UYll5dlNrYWNVWjhGaUY3TytzaHljTmE3?=
 =?utf-8?B?Ry9WOHNudDVQbEg4eU43VjJKT0xZSkhMLzYxV1RTV2ExcXhWVkphWjZVQzk0?=
 =?utf-8?B?cUVPZ0RNYk9vOGpKbW9rYS9DKzcwbkxOWXlYWVVidXZES2NLbVBhOTZIRU9G?=
 =?utf-8?B?Qm9sY2NqY3I2Umd5REdFZTEva3RtNVdOQXJYNVVOY0E3RkZmNVVKamRIa0hJ?=
 =?utf-8?B?RWlNT0svU2t5WmRLTWh5bFgyVmlIUEYzeDZ4VHBpQVdjSVJBVmt2dmxqcHl0?=
 =?utf-8?B?M2VwVnpybDlzbnZCVTVrQ0FETEJWNjJvek9GdzJ5dlV6UjBLUHQ4TEwzNGFY?=
 =?utf-8?B?OUNxVFRrNjZWeHJJUmZidSthR3BEcW9YTnFqb3BQNHNoc3N5VU1GZDI5cDQ5?=
 =?utf-8?Q?6c3cND3F4Z1jfW6Tyf79+bU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a11ab8-c6b3-486c-2643-08dc99e8d1e6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:14:01.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZEOdw4dQc2G4I+ivbSxA+vSpBs88frs5+ZoWjivPyrRRWv2CPSj6+lxIsuNfJtMqz1l01WgAYgp8XQOr8b4X438/v+kriQ4tlNdF3Z2WwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7309

Hi Guenter,

On 7/1/24 4:37 PM, Guenter Roeck wrote:
> On 7/1/24 07:11, Guenter Roeck wrote:
>> On 7/1/24 04:05, Quentin Schulz wrote:
>>> Hi Guenter,
>>>
>>> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>>>> The default value of the maximum fan speed limit register is 0,
>>>> essentially translating to an unlimited fan speed. When reading
>>>> the limit, a value of 0 is reported in this case. However, writing
>>>> a value of 0 results in writing a value of 0xffff into the register,
>>>> which is inconsistent.
>>>>  > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>>   drivers/hwmon/amc6821.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>>>> index 3c614a0bd192..e37257ae1a6b 100644
>>>> --- a/drivers/hwmon/amc6821.c
>>>> +++ b/drivers/hwmon/amc6821.c
>>>> @@ -601,7 +601,7 @@ static ssize_t fan_show(struct device *dev, 
>>>> struct device_attribute *devattr,
>>>>       struct amc6821_data *data = amc6821_update_device(dev);
>>>>       int ix = to_sensor_dev_attr(devattr)->index;
>>>>       if (0 == data->fan[ix])
>>>> -        return sprintf(buf, "0");
>>>> +        return sprintf(buf, "6000000");
>>>>       return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
>>>>   }
>>>> @@ -625,10 +625,10 @@ static ssize_t fan_store(struct device *dev, 
>>>> struct device_attribute *attr,
>>>>       int ret = kstrtol(buf, 10, &val);
>>>>       if (ret)
>>>>           return ret;
>>>> -    val = 1 > val ? 0xFFFF : 6000000/val;
>>>> +    val = val < 1 ? 0xFFFF : 6000000 / val;
>>>>       mutex_lock(&data->update_lock);
>>>> -    data->fan[ix] = (u16) clamp_val(val, 1, 0xFFFF);
>>>> +    data->fan[ix] = (u16)clamp_val(val, 0, 0xFFFF);
>>>
>>> This is an unrelated change I believe and I would therefore have this 
>>> in its own commit with proper documentation in the commit log. Indeed:
>>>
>>> 1- Change in fan_show handles the default 0x0 register value (which 
>>> can only currently be achieved via the default value of the registers)
>>> 2- Allow (re-)setting unlimited fan speed by allowing the user to 
>>> pass 6000001+ instead of clamping it to 6000000 RPM.
>>>
>>
>> Both changes are related.
>>
>> The whole point of this commit is to report and permit consistent 
>> values when
>> the register value is 0. But you do have a point - reading it after my 
>> changes
>> returns 6000000, but writing the same value sets the register to 1. So 
>> I think
>> the proper change would be to display 6000001 as speed if the register 
>> value is
>> 0, and provide a more detailed explanation. Would that address your 
>> concerns ?
>>
> 
> Ah, never  mind, I'll do it differently:
> 
> - If the register value is 0, keep reporting 0.

Or...... maybe UINT_MAX?

> - If the value written is 0, write 0, otherwise limit the range to 
> 1..6000000
>    and write clamp_val(6000000 / val, 1, 0xffff)
> 

Mmmm... I'm a bit worried about the implication of writing 0 in 
TACH-Low-Limit, what is actually going to happen in that scenario? I 
assume **every** possible RPM returned by TACH-DATA will be deemed 
invalid/below the limit then? Reading `Fan Spin-Up` section, if FSPD bit 
from register 0x20 (which we don't write to yet I think?) is set to 0, a 
spin-up is started whenever the fan is detected to be running at too low 
speed. And we would also be getting an interrupt for that too-low event.

Basically, wondering if we shouldn't gate the writing of 0 to only the 
MAX setting?

> This minimizes user visibility of the changes, and also ensures that
> the reported fan speed is 0 if the register value is 0 when reading the fan
> speed.
> 

But didn't you say this means the fan is running at unknown 60 000 000+ 
RPMs? Do we really want to return 0 even if the fan is actually running? 
In which case max < current (possibly) but with no event happening 
(which I would expect, reading the datasheet).

Quentin

