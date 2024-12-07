Return-Path: <linux-kernel+bounces-436047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2AE9E8071
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D109F166337
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9617C1487DD;
	Sat,  7 Dec 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JuNs2Lyz"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021114.outbound.protection.outlook.com [40.107.192.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE522C6C5
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733585511; cv=fail; b=i6zUH+zh31MCRusUZKglxWWGU/ymGJSYfji1rU6tknxJEn9M7Td5fPToRYNs7f72XSO5kjaVjFNS9lysX4ek+w0VKGZUxyF4Z6QBCapZHHiU7vzManlA7ax80ntMpZUJs2bc1b3a/PvQh/xup1q47OlaRGZxPs2phnt4/Q9R4S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733585511; c=relaxed/simple;
	bh=jbiuVSkmnRcl52V6aKezfNQVM3Vq8WMa4xSVGsZ8tsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uq3rZWiiIs+1xAMLM7qFUl/GlJlQVYNm0OOt551hOXHHrmE/kQeh4jq/UyGBTEkswlMV04O8C4KOx+pOOzbbRGH41m5FFU4bxGQSyXxYQpNNwq4J3Yrs9VLuQ20ZazysPLo6C2OslAmI4jM3I+zvrO/tnpClac+ptOO1tcfmMLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JuNs2Lyz; arc=fail smtp.client-ip=40.107.192.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBg1JSMLKzo1wz6OlNoUvLySmQoSznNgeyz0MvvWBEjnXaj6RqRNbDyMV20/D/XDvNy8nxprLY6LvtJm96QjcnCjA46i5dkmMPH++LckJbSiGnkogowcXmFpmvF6dXkQdJk1w1albX5abL6nd4yC62PaSgkcV20BAo2/McBQOn3ytHzEze58yYV50vyBmETrNHWTvscSbsd7gsEyBvsihhUd/GeJNyhQ4TONM2lqXAa7WDUJ7hxQz+s041OLH3iS/WBeBQP4DhaCjFv3INVYEuOGkDkn6QvZ4awVx8EglR+AxYfKqXa4i5tMU3/nGM7tnygVuC+oydve8ph8zHPZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHO6V5COfibbazAgBLZFAXLbLonaIz/tb5MCxjwHdxM=;
 b=A21RAucxwXpEcLSOZgpExLn+1yMgPRpNr+V92c7blyL2X9ry+flLT9BdgjgPnPiJb8ICBwo8DIjQhrm3BL6YWMYF/Vw8MDAWn8DzTxbuAylyeAlWiH6hZ9K4G/07B042jVqPCCtHeZl7EgR6fnKCE9uKA/9CN1MIe6mXYmtbXtlw600/gG6Nk9o2GEpzMvylJK98ZBUPgmcvMriC3uf6Mo6uumFs7dmZOP8uBwayV81JRYJ6cJ++lZk5KPbd9VOScaacKxMrJO+MKE6ki4kYnEu4AaKwT25dWcL1bfwMTzrs3fFB8IWFIC0V3oRpJB2x008Q2gasy2kav2p49h+vJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHO6V5COfibbazAgBLZFAXLbLonaIz/tb5MCxjwHdxM=;
 b=JuNs2LyzcYEKW9cFy8JICF2UTmS18FkOGiDoccJ5Mq8ZpRnXn6BLJFUs8wBaKg7uJaQp8uTathdLBPJMVGO+B1kjNcsrexXjYkOUPr0iUb//MFoFOVqRH15bzIc2XU89r7Ym4TKhY5WJeqRGw7wdS/OHe4KAA9iD73HKPZta42KyLtC94lYfou8QgeK6dnxka01LxLPjZOkW1vv7JzFL0hhPpbslOC8X9b72Cc+GA7BfmKoE1VriO3gXkMfSPDrKnekyQP4za5N+9L9Z9OUzOqx1zB/2MJvf+FMzy+tp6dEGoze6uHKoLCN3DZh+lvoXJ3QQZ02sFrZ3WIf2igPgnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT6PR01MB11284.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sat, 7 Dec
 2024 15:31:46 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 15:31:46 +0000
Message-ID: <acd263a4-824c-4c8d-a3e2-8b2f391fc775@efficios.com>
Date: Sat, 7 Dec 2024 10:31:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: use clear_user_(high)page() for arch with special
 user folio handling
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko
 <glider@google.com>, Kees Cook <keescook@chromium.org>,
 Vineet Gupta <vgupta@kernel.org>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20241206174246.2799715-1-ziy@nvidia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241206174246.2799715-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT6PR01MB11284:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c3d9b4-1ea2-4e6c-d593-08dd16d44276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1c0R2YwREgrWk9jYWd6Z0wwb2Z6dnBET2Q0UVZlakVMODR1dkpDam5FeHpP?=
 =?utf-8?B?TWs3MXlrb1d1VG81ckdHK2JUUWlyZDg1T0RUdnJveW9wTlZRYUpwQVVTU2NC?=
 =?utf-8?B?QTlQRG1wb0k5WDhOR2NJaDZvQU1lcmplM1M0empvdzdVdGVVVFNVazl6WU9h?=
 =?utf-8?B?RzU2enIwTUFoeWdzcDB6RERBT2VHS0RscmFvRVZpRnE5Y0cyai9YVWM5U2RH?=
 =?utf-8?B?OG41N0RFeFQ3aWhacENwdlpVWU15RVFMVzZPNVZZL21udlNwM0E1aWh3Uldy?=
 =?utf-8?B?K0FGVVVUOUYyaUFGcWJ3Z2M5dmc5em1rVmdIcVhUTERxMHltcER3emRoZGtn?=
 =?utf-8?B?WHNpYmhnblRaM3JWTEhJL2dRcXhZZnd0eEs3ZGpyUjU0emJUT2NONDdyWEdB?=
 =?utf-8?B?ZGs0RFAvb2ZVdFdqcStwOXRKNFRYTXV2M0R4Ym0zRDVuazZGeEQ4RTFTbklS?=
 =?utf-8?B?dnI0OXArVE00dUE0amdnSnQ3UFFacHBWamNnbUVPVm9pOXVNV0tNQ2RCNGRp?=
 =?utf-8?B?azE4RkxQcEx5ajFoMkxrVDN3ajFDbjdsMnVxZno0SmFuMy9iQ0UybVpQVmhy?=
 =?utf-8?B?a09lQlZVdWw4Y0Z6WXBPdUo3WGZWMkdXbzIvUG1RVVFPNlAxUS90U0J4WFJV?=
 =?utf-8?B?YnBtK1AvWUVrNHdQN0lSK3ZPOHFYeFhvaks3dTZwM240dGNkMXFGZzhXU0Nz?=
 =?utf-8?B?ZFhOdDZWa1VlNEpLZm9jZW00ZkdYbE1NRWZBWnhJaUVZak9yQTd0NTRzU0tU?=
 =?utf-8?B?RlVkdjlsQk5jcXJNcDB2RGZ0QXhiTTBldGIxUlh3WVBGa0tjSE1UTVUxbU4z?=
 =?utf-8?B?Szc2ZkNDR3dTeXhFeU5BQTZQaVpadFZqUnVhM0VvMy9BVzFDdTI3NXRBdlNj?=
 =?utf-8?B?TjZZbzZjTHBnRGVmTnRHcHNTQ1JhbEJDRDlxMXlwcjNoTGNKOFd2RUM4MWY2?=
 =?utf-8?B?RG9COU9KY1VvbzZoUXZobUl4YWxSMENmQkQyV3BxT21tTkZJU0NsMWk2aHhk?=
 =?utf-8?B?WnNRQWhZOWdXOUZXd3cra3Z0VGMwUFVHU1hkNzFjVGtQTjUydFRnU2t1dmlU?=
 =?utf-8?B?T3UyU1dzbVpCMDhnUy9ORGYxNlhHdE5qTU1iLzVCaktQZkU3ZU5KRFNieEdB?=
 =?utf-8?B?TFVGTGNta01GYjhFNGZPem51TUFwclVBQ1JESG1hN0FDZmhjeVZudnFMOEJj?=
 =?utf-8?B?ejVWTG02MmhXbVJLWlMzN2lnZHdLcSsyOUNpUWNGRGJBUzMzMHRVYVJuZEl4?=
 =?utf-8?B?N3ZXcFV1Q0N0SW5TdU8wUElvbnRqc0h0VzI2dGJoM3RQaWhjUU9QK0tCQTBx?=
 =?utf-8?B?ZDFZTWIxdFpXVTh6Sy9PVDNnZmhBL3FYOXdtU2pFbnZuMlZDcU53RnJvRWcx?=
 =?utf-8?B?WGZlL1RyQmJ4NElYeTdYR3NmK0RpS0RxNXJlZVp0NmZFbFdoN1NFSjY1YTNv?=
 =?utf-8?B?TW1QWUR2V0Vmb1VzNlREK1kwTml6cEN2dDdYRU1NTUVROFJHbVhtdFlXU25v?=
 =?utf-8?B?NEFxODg0V1F0VnJZR0d2cFRjM1hzbWZ6SXVzdUVFczdxRVl5MlhIempDN29t?=
 =?utf-8?B?TWNiOEttbklXNXl3dHhJYXRlbElwNXJzNTh3YUJobm9ZQVFmS0hVWnJLRk5Y?=
 =?utf-8?B?UHJPK2k2TTMyZTJxdXg3SWNEMitiYVZicXZDbVNBeHF1SDBSeWkxR21OVDdT?=
 =?utf-8?B?QXdLMWVoUUJ1ZmdZSkJPVDg1Qy8rWXJmdXl0LzlobGZKYnhpb2R3NG9PL1hu?=
 =?utf-8?Q?QQzRyBR/Q279R8wPQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ukhpd3kxRjlGNjl4Z2pwdnA2dGVsNUlhcnlsVkRQSE5pbEllUSt0Tm9PSTVZ?=
 =?utf-8?B?aWh5TFludkxFN090WWhBOENNbmxJU21NcFBncEZkZitWYzN0aG9IbUpFbjFy?=
 =?utf-8?B?V3BTRDZSVk1kN0FRckpMZFlEbUVidTd3UFNPZWdwUWpSTG5jNVB5Ylg1eEp5?=
 =?utf-8?B?WHBCakVOcDNMVElxUzdNU3RpbUFnY0tlUUVCOVNYU2xmN2N1WnAxYTNqYk1l?=
 =?utf-8?B?c0Vja3kwV1BqblpxS2RjSjdoK1JldXVxenFQRXg2LzRlM1pmYzF2eC9ZYmZh?=
 =?utf-8?B?dE5xVlZRYjhyS3ZoQWs3M216Mi9pSFk3OFRROGlpWXliZDVOcHFndktZSU4z?=
 =?utf-8?B?QTZ0eEsrZWFwb1AyNDBmanYyMUhQM05QUlZUQUR0Z244OTJ2YmVmeUt5MjJ5?=
 =?utf-8?B?QzVtcnpTbW1Ec0l3WnB0cUlnZWxKOUF2NzRvbjhBeitDQWxxTmtpUTdqTXQ3?=
 =?utf-8?B?Y29TTWUvQ3BLejZyNk11WFRDK2IwdU5sdXFPMEx5RnphLzZ1dksyVXdBa1g5?=
 =?utf-8?B?dUY1NVg1TERKaGdnRVRldlB6b2VrL0h0QW9MUzEzbXVoUmcwYXhKUW9xb2VS?=
 =?utf-8?B?QWIwOUJWU0hnVmdVMlhpT3psMFZQbXNoR0htWUNKd1N6eVVCRFQ3QUJRSDlP?=
 =?utf-8?B?aU4xUmNNaGRVUThROENYV2dOR3k2VjZBWHVaeG9PT1NUMzBwZEtlYnV4aU1D?=
 =?utf-8?B?OUhoMm9mblI0bTN0NmpWVVNkaDVMcVp3ZzhPMEZXOGJ5VG9nRzZwcU5LS2E1?=
 =?utf-8?B?bTlRTnZBT1ZOaXBWUG4vUkNRcnNrRGJLTW9iRjI2K05Hc2phR0NhMEdFcTVV?=
 =?utf-8?B?S3pzU0dlWlNBdzc5OU0xNTBVS3g4dkxzOCtGbGJ4Uy94SkdzUE9COEpWM2x2?=
 =?utf-8?B?dndEMTQzejBEZDRiWWhLa0JXSDk2QnhjU1VoNlYzRXdVV3lNNGcvKytSVHBL?=
 =?utf-8?B?aXpOS1BWeVBxN1FwcjhubUh1YjRuQ3dITnpyeEkrdG4xZkZCNFQ1VnA3VWtx?=
 =?utf-8?B?QWYxeXhtVEJxSGEzNmlqQk9iU01FMkR6QU5qUkNKa2hJeTloQkcwVXNaY2RW?=
 =?utf-8?B?SFAxWWNhWlFxR3lMa09ITWc3Y3JkZ285T09jbFZ0VWV1Q2FpQnFTN0pxVkk1?=
 =?utf-8?B?czl4dUJvT3VmeXJFbWc2SDhjMmltWnVBVWx4RXhPNExaa0MzVWtYQk5tM1RR?=
 =?utf-8?B?aEQ0ck9DemMraWZ2bWh5Y01SVklXaXVlOHFxcCtrR2puc29tZFhBQTZzdU84?=
 =?utf-8?B?Ni8vdzNNQjVuZnBCSDRUcGZnUzBYakVPdDQ2TTk3UnZZcGJtSzRCL0k0Wlpo?=
 =?utf-8?B?Y2lPb3JlQ3ZIRFZDaEFEOS9CYlVnR3pUUnFPaWt4OGJ1ODdtMmR1SEtQdVVN?=
 =?utf-8?B?aXFmbHBmKzZPVFFudU9MaXduR1V0UXVsR3NKdUJYUXJYLytqeUZNWTJ6aHBn?=
 =?utf-8?B?eTZzNFBSWUF4WnQrM3RnNnBiWWFSdWR6U043UmhGdisyRFRFbWNMQTV3Q24v?=
 =?utf-8?B?dCtORDE3dmZJSS9IRWRDTU9HMmxNSW9YU25DaktocldQcFdQWnNsM2xLSHdD?=
 =?utf-8?B?aHZsczVnWk12ZndWNGVCMnFjVW5oRFY4Q2NrdzJXbTBncFAyMVZBWVJwYngz?=
 =?utf-8?B?TlJRamhqUUJUNllkV2RGNzBScDRIVE5FNnlxL3ZZblpxWUFYSHdxYVlQalNr?=
 =?utf-8?B?bVNrKzBaamFRY1pQZEFhVm5SM0t6TW93dTl3c1lXOGh5VHY1R2JhczhMdDFM?=
 =?utf-8?B?K3hGZDVGZzVaejRMMmxvSlo5eGJGOHg4Q3BJSEhaTjgwb21IT1VReUx1cjVU?=
 =?utf-8?B?c09HS1MrbGw4cE03dTdzWnJuYmh0Z2VZdmhqcVI4OHYyN2dIQjkxUnoyMjZr?=
 =?utf-8?B?OEFob0RXMlM1K1BRbGtTdXhUQXpKcXhabk4xU21BSmEzcGRjRDY3UWR5dmNv?=
 =?utf-8?B?ZCtBYVExWnpMUkwyYnFZK1puaTJxRm0wMzI2aHo2RnRXQkwrQ2ZjOFl4U2RC?=
 =?utf-8?B?aVpWSDZVZXRMTWlCcGV6ZldBUjRmME9zeWppa0YrOUd2WEJYd3ZFMUVCMUpO?=
 =?utf-8?B?WHFMRnVseGtsazd4cytHeGJndVZxV3QzRzNTK1J2UHFWTVgzOFVpRkJmbnRD?=
 =?utf-8?B?aFZNZEdMV1UxcVZUeW51YUJQTHNsZTMzTDJZMjVTMEl5MU05Q1c4amxjOHR2?=
 =?utf-8?B?OE9kK2hQcDBVTmoxZU0xWDR0VWZjb0J1bXZRblJva3lpUlhLL3k3RXE3VFFL?=
 =?utf-8?Q?kEIkv8XcJbb4dSCZjL58xhEfIGPaeCglutMdv2UFwc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c3d9b4-1ea2-4e6c-d593-08dd16d44276
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 15:31:46.1489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e58r12BCRcMir4c2bjFdIZhtFGj2WfFNbMofnBsVU4oTUySC6gMA1VPZms4aMaxsl1PCbMlrIS1BWTuCC8FVIyXP20uAjmW95+mQpQkwPMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11284

On 2024-12-06 12:42, Zi Yan wrote:
> For architectures setting cpu_dcache_is_aliasing() to true, which require
> flushing cache, and arc, which changes folio->flags after clearing a user
> folio, __GFP_ZERO using only clear_page() is not enough to zero user
> folios and clear_user_(high)page() must be used. Otherwise, user data
> will be corrupted.
> 
> Fix it by always clearing user folios with clear_user_(high)page() when
> cpu_dcache_is_aliasing() is true or architecture is arc. Rename
> alloc_zeroed() to alloc_need_zeroing() and invert the logic to clarify its
> intend.
> 
> Fixes: 5708d96da20b ("mm: avoid zeroing user movable page twice with init_on_alloc=1")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Closes: https://lore.kernel.org/linux-mm/CAMuHMdV1hRp_NtR5YnJo=HsfgKQeH91J537Gh4gKk3PFZhSkbA@mail.gmail.com/
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/highmem.h |  8 +++++++-
>   include/linux/mm.h      | 17 +++++++++++++++++
>   mm/huge_memory.c        |  9 +++++----
>   mm/internal.h           |  6 ------
>   mm/memory.c             | 10 +++++-----
>   5 files changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 6e452bd8e7e3..d9beb8371daa 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -224,7 +224,13 @@ static inline
>   struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>   				   unsigned long vaddr)
>   {
> -	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr);
> +	struct folio *folio;
> +
> +	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
> +	if (folio && alloc_need_zeroing())
> +		clear_user_highpage(&folio->page, vaddr);
> +
> +	return folio;
>   }
>   #endif
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c39c4945946c..ca8df5871213 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -31,6 +31,7 @@
>   #include <linux/kasan.h>
>   #include <linux/memremap.h>
>   #include <linux/slab.h>
> +#include <linux/cacheinfo.h>
>   
>   struct mempolicy;
>   struct anon_vma;
> @@ -4175,6 +4176,22 @@ static inline int do_mseal(unsigned long start, size_t len_in, unsigned long fla
>   }
>   #endif
>   
> +/*
> + * alloc_need_zeroing checks if a user folio from page allocator needs to be
> + * zeroed or not.
> + */
> +static inline bool alloc_need_zeroing(void)
> +{
> +	/*
> +	 * for user folios, arch with cache aliasing requires cache flush and
> +	 * arc changes folio->flags, so always return false to make caller use
> +	 * clear_user_page()/clear_user_highpage()
> +	 */
> +	return (cpu_dcache_is_aliasing() || IS_ENABLED(CONFIG_ARC)) ||

Nack.

Can we please not go back to re-introducing arch-specific
conditionals in generic mm code after the cleanup I did when
introducing cpu_dcache_is_aliasing() in commit 8690bbcf3b70 ?

Based on commit eacd0e950dc2, AFAIU what you appear to need here
is to introduce a:

cpu_icache_is_aliasing() -> note the "i" for instruction cache

It would typically be directly set to

#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()

except on architecture like ARC when the icache vs dcache
is aliasing, but not dcache vs dcache.

So for ARC it would be defined as:

#define cpu_dcache_is_aliasing() false
#define cpu_icache_is_aliasing() true

And the Kconfig ARCH_HAS_CPU_CACHE_ALIASING=y would be set for ARC
again.

I'm not entirely sure if we want to go for the wording "is_aliasing"
or "is_incoherent" when talking about icache vs dcache, so I'm open
to ideas here.

Thanks,

Mathieu

> +	       !static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> +				   &init_on_alloc);
> +}
> +
>   int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
>   int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
>   int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ee335d96fc39..107130a5413a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1176,11 +1176,12 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>   	folio_throttle_swaprate(folio, gfp);
>   
>          /*
> -	* When a folio is not zeroed during allocation (__GFP_ZERO not used),
> -	* folio_zero_user() is used to make sure that the page corresponding
> -	* to the faulting address will be hot in the cache after zeroing.
> +	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
> +	* or user folios require special handling, folio_zero_user() is used to
> +	* make sure that the page corresponding to the faulting address will be
> +	* hot in the cache after zeroing.
>   	*/
> -	if (!alloc_zeroed())
> +	if (alloc_need_zeroing())
>   		folio_zero_user(folio, addr);
>   	/*
>   	 * The memory barrier inside __folio_mark_uptodate makes sure that
> diff --git a/mm/internal.h b/mm/internal.h
> index cb8d8e8e3ffa..3bd08bafad04 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1285,12 +1285,6 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
>   void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>   	       pmd_t *pmd, bool write);
>   
> -static inline bool alloc_zeroed(void)
> -{
> -	return static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> -			&init_on_alloc);
> -}
> -
>   /*
>    * Parses a string with mem suffixes into its order. Useful to parse kernel
>    * parameters.
> diff --git a/mm/memory.c b/mm/memory.c
> index 75c2dfd04f72..cf1611791856 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4733,12 +4733,12 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>   			folio_throttle_swaprate(folio, gfp);
>   			/*
>   			 * When a folio is not zeroed during allocation
> -			 * (__GFP_ZERO not used), folio_zero_user() is used
> -			 * to make sure that the page corresponding to the
> -			 * faulting address will be hot in the cache after
> -			 * zeroing.
> +			 * (__GFP_ZERO not used) or user folios require special
> +			 * handling, folio_zero_user() is used to make sure
> +			 * that the page corresponding to the faulting address
> +			 * will be hot in the cache after zeroing.
>   			 */
> -			if (!alloc_zeroed())
> +			if (alloc_need_zeroing())
>   				folio_zero_user(folio, vmf->address);
>   			return folio;
>   		}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


