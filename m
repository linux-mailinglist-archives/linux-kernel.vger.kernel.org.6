Return-Path: <linux-kernel+bounces-300275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED595E1CD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDD71F21D9B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85A72BAE5;
	Sun, 25 Aug 2024 05:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MGmL6s4L"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2058.outbound.protection.outlook.com [40.107.117.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54814A2C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724562418; cv=fail; b=Y/IpgSfyooA3VTMMH10FqxmO6AowSmGqZGIXBLsaE951llcIFFMUeR+yFWsiqk/XnI2XT7je1k9HrwtTjsYBaYYOG2DajsMK9/QXLflHmhFL/1xWPqit0pa3ZHjgEesstHCUpy6On+07kLkZ1ZcZl9h3rTq18VeOeG1SC3UlLD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724562418; c=relaxed/simple;
	bh=9O7fyAfWOS2C/LjV3it3lNC9qzxydYxw/iE48NvmH6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J0F/OmExvE30YDRe5qRxUtURYIDuikpIohouu6tK8J47K6Aqz0gfwryTVZUeEdy5ECIXnQuvCDW6RA78WpIq63QArwooc44ldp6+7c/Ep1+dZarZjGUstkiesNBT+Efj4264Sk2aMfiHE+m+8+lNXygLRdv19QamZS9Ed5UImng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MGmL6s4L; arc=fail smtp.client-ip=40.107.117.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9sBChEeFwn63YWV3GFmE4XdOQLgEywiHt9lQXot/hn7YcC8M7x9YJdb+hQRoJGhNDUpe7N0cqVZlWHAduniMP7g77RC5Rs4024Q9FvAdEZ39lMlmfosDxXsBg0mSaoIFORsjTioOXTqneExtCpoNVmJa0AdH+9+Ut1ZgQVCPjD7FpqZGDtHafR4wpTFPysZtlRN6PJvyvjGCk2msfUzswZTCNyZbVbUp/ObM3jsne3jKsnJJAN+tpzo0OauQOLWTPVnSILVKIlxa5reu/fFIhn+j853cVHxZlS3fPlfLGBVWm1GwTwRNmnQoYCVfq5qrYRB7+7W3h9dRBB7snczrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoKN4kwR4RVTQnHywIhg33bX0rPzaN0k8rFo35pjB98=;
 b=avlXyurubET1qFUfxPE5m5SYHPOUu5TsoFKUjxEHLf4U7QW3LlfW6FhgyqLoX7w3I2FcAnb+lpqbn67y0pa73oVfOZtbUKZVDAbAyNI/B61wjfeXpHTBe19fRoDH7F2AtAzxmaiA2/OUC7OoLCsFQ1DINR8AqaIuahmyQBx4q/7a/35w+RJdjPBr/e33Ct7S6FQ8mAbvLA5Af5Cyrm86plFfRGTUAsyEzCqYlqhBXSHZ68Ci9/C9f/2i2V/zRsC+2/IaQWcWYGvjHvb9qZcFz7tAyFax8/Mo2oVOSexXkqJpA3GiBEo/dOZ3CNmtABQ/09C01cjbjZ/SXGAvtO1wcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoKN4kwR4RVTQnHywIhg33bX0rPzaN0k8rFo35pjB98=;
 b=MGmL6s4L+qfUBJTaQB+KqmCnmCUtD98BN/i83ahLJXUki8XO+c643ztCZAB04pMHp64TWtzyy6exp6+ur4jgprZfYNEapa8e1Zrq1ac0wrlS5RzTyXNr4to6VxLi96rkcxjqMZ56O1qz+tbuUXIqSJLrXIWdAkk2hJLbWsu7wmrQFT4BZbCqz7Q8di3JVmkgNDjT4WDo3bQJoldOrd3kFVlTGOCRfs89RLcP7mWGGK4TT5J/X0m5tRUWDznPNXMV+7JuJ8dkvpcFOO0ET9Z1wIBCOIuPWoVpu7gLpF5M5gvHNqnFZXU4KtGz5CzUX0K8uc+tM2ZEKsjq7uzPjepQxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYUPR06MB6195.apcprd06.prod.outlook.com (2603:1096:400:352::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Sun, 25 Aug
 2024 05:06:45 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7875.019; Sun, 25 Aug 2024
 05:06:43 +0000
Message-ID: <4dd13a4c-e968-4a3a-98e5-97f28036deff@vivo.com>
Date: Sun, 25 Aug 2024 13:06:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 opensource.kernel@vivo.com
References: <20240823150206.565-1-justinjiang@vivo.com>
 <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0080.apcprd02.prod.outlook.com
 (2603:1096:4:90::20) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYUPR06MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: d8be9d51-3d01-4865-e5c0-08dcc4c3b5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2h3c1JiZHd2MXA3L01JRlVSWTl0bEtJZ2xqVVZCSnRrWWpvWXk2am5vQ08x?=
 =?utf-8?B?c0tXVW9WdUx5eW94eGpsQmw3c1lTTWdIWDVFbStIa2pqTmdnbFBHVHJES3RO?=
 =?utf-8?B?dUxtQzdZV0tTR1l2MTd0bzJoRm1NLzhsMk9mNzd5M3F0YmJhTTZGT05DYThn?=
 =?utf-8?B?Z1RvZmN0VFgyZmUwWUhicFZJWVorYjhVNml2Y2w3b245SGRYN0RoM3FKOU9I?=
 =?utf-8?B?T1kxTGkwb09wVWRWSGwvVThrTzNiZHUvOW9ZVWZEREJLR0lvSTFvVElidmpv?=
 =?utf-8?B?b3F4TU9Tdm5vUUVXSFpwTDllQU1TWUhtNDZyVXlTYjFNWHlLTXBmeWI0NGRu?=
 =?utf-8?B?RVJ0YllwSHRJU1pvNjNGZCsrdG12RWp6NC9wN1lRdDFsZUR6cmJwL0dQRmV0?=
 =?utf-8?B?MjJ2MGhyMFUwSXVrTzJLeURIcmhmNWhxZXZaUHhJaTE1U2N5alk4MUxiRmpB?=
 =?utf-8?B?RTlPUFAyaXBjRXNDSlNPSUpyeFJlODdWWVVzWXNiQVRlQmVielhlbndad1ls?=
 =?utf-8?B?Uyt5UjNnTDRoUUZGcFlTUGlCY0xaYlRmQ2F5VU9helJsWjM5VXpDN1VvamZB?=
 =?utf-8?B?ZEpnQWNqZXdzY3paQkJQU0JsSHovZnMwSEQ4MmpxVDd4Z2t3S0JrNXB2WC9B?=
 =?utf-8?B?Mi9IQVdzdFFtR3FVV2E3MUU3WFUvdHZuWXZaMDRHMDNZbm1va2VLQzIyOWlm?=
 =?utf-8?B?OGE2SWp2ck0xdEJUNWdsK01ZVXFmb0xUOVdZVXJpa0dSdmFFV09iVFlzQlMv?=
 =?utf-8?B?ZFVRUG5RbTJBQXh5VUhOSlhsWTBWd0lBUUJxUTd1U2I4YVlieVlBc2E5d2Qy?=
 =?utf-8?B?TFAyMTZKR1BNTmp3NkR6RTFVd1paV1VrY1ZiRWhnd2RJcVJJWVdKOTRaMnh4?=
 =?utf-8?B?bGp5OUovZmpUVm9QeGgyc2NFR3Z2YWxSTC9aQ21Bdkw3b2M4aENUTEhkR0tK?=
 =?utf-8?B?QlpJZkUrWlVVRDJrR056TFlTWXF6WXZ3eGtkMGJOcVhlR25sWUd2bFBMU21s?=
 =?utf-8?B?NVdtUU4vZEloUk9BK0ZQK01ZbDVUOTMwRWhCR2U0QnBtcHFOQ2tFMWxaenNX?=
 =?utf-8?B?OVljN3pkc3JOVTV2RDFwNVBBdEFoQU5WNzFISDhEczVYbTFYWDVhYm1EcnBm?=
 =?utf-8?B?dVRtNGg2a010ZUlSdWgxSkkvZTc4aUxHRTVoY1QwSlRKaUIrWDFoZGsrbWU2?=
 =?utf-8?B?TG00TDJaanFBTVBwazg4c2MrQTY0K1lWUjNOK01ic0hyMVM2R1U3QnFKUHUy?=
 =?utf-8?B?SnUwZHVTd0NPaENtYjA4UzI3YWdpWHFWSDZQbVRtRnZoMnNUQjZ5dXBUbTRO?=
 =?utf-8?B?S1B0Q2kzM3F2cjNqcnZIaGhoT0h1WkJpTEFXdEZmNEtIQWp6eTUxb1VWSDBm?=
 =?utf-8?B?YU9mM0IxS29adEF1aFNLUUxvWEtlZkdtVE1qNE5PRGExNGRmZDFzQmRUN0J0?=
 =?utf-8?B?aFUyc3lvR3JUd3Y1R1Q1d094YVlwejdzYnM0RTFDVjh5VEZvNXo4TXZNd0hm?=
 =?utf-8?B?WStSSGRtOEhQMXFuZVVIUS82RzlCTkdoWWVhZWVxUlBQSWZrdTBvK0hLVjJs?=
 =?utf-8?B?Zkt1Z0k5alJrTTZlTTlKQkxWbEVpMVhUVDlMNUhsSXdWbkpyZ1JZT3lML2Uv?=
 =?utf-8?B?TzZkSGdkNFFFemxwbHZncW5abXBscnRaQ3V2V3ZMWEdZVkpUd2d0bjgxQkdG?=
 =?utf-8?B?MkxidnN0VlZzdWNMb09XamJkVndWMDRrVlYyT241eEw4dkpmdjBLY0kyLzRT?=
 =?utf-8?B?REY1V3JmRE5oS1gwRmcxTjN0dWFOVXJBeHlzWGdyaVBmSVJXbjBPQ0NvTmc0?=
 =?utf-8?B?OExCb1VESkdwMm1oWE0yQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlNqNDJqeEt0UDNRSUVrbnFTalJHRFBqcDZSNE9xTjdSbUR5cFBHMmYvbGsw?=
 =?utf-8?B?VEFZM0ZuWG8vU1kxL2R6YWNXRWI1MStxNlIzSkNVR29GeVY0UTZmUFpNR3hh?=
 =?utf-8?B?Q3NWaTZvSHVGSWZzNWFiUkRHaWE5NlFnVU9MSis3Q1BQUjNxZlhPR1BiVy9Z?=
 =?utf-8?B?cWpmc09JaVFOM3NJajRNZzJvQkJiUnZ4bDllOWk4WW9iYzFWZkg2NUx1SGhv?=
 =?utf-8?B?Z1ErNnlxSFNKclBwY3VRQ1kxWGFSQWRSVTc1d0JwelVQcWxyY2R4VWlCb1Ba?=
 =?utf-8?B?MTg3U0hRK1lvcWhsanlYdGQ5T0ZFYjNzeXpjSWxKSWlaY3ptNjBFUFJMVHVG?=
 =?utf-8?B?QUtvSW1zZ1J3cTBUUEpXU1JicFI3d0t4Rk1CbTZCRTQ3UGVxa09VUmoyaGFF?=
 =?utf-8?B?NWxUWEVWV3dBSVFFaU01cC9SUkdlaWlBbURSN3JSWXBFdkYwRHp3Rm5kdjdW?=
 =?utf-8?B?YWJtVzlITGVQTG1xU0JKTXE0QmpsUXB4VjRBWFY4eFJLQ2hXZUI3VUpZMjB1?=
 =?utf-8?B?bHFSNW1HM0pqVy9KRy9PTlA2Y3VraDl6NXhvM1JnTFFRTUp5QzlhRUpTODNk?=
 =?utf-8?B?YU50OU5ZV0toVGF5dFo5TnVtNklZK0VFRzB4OVFDcHpDOGg4bE1RREozalln?=
 =?utf-8?B?bSs3V1ZlRXg5RUhtdE1iOVkwR25CTzROanFMUUdCbk1ucmcwclFtRjNsVk5B?=
 =?utf-8?B?MzZuYjhMNnpoUUhJS0FNVURpbTBVczZNVzBTdU5ab1pGbThuSnhvTU5jc1B3?=
 =?utf-8?B?K3Zad0gzUFZLbjFpTHpmYmFNb3pHWFk0d0FYcXM4UXBLZ3VsTzRnUnUzVzBV?=
 =?utf-8?B?ckNuQVRGcVRhUVlnTzNUTTJRSlRlRnVRMUZJTE1KRm9lNE1ibDJCZlViZ1Zv?=
 =?utf-8?B?QmhrcGo2bFEvcldZZjJsRHFxLzl3bTFvZFB0YzZEcG5QVE1va2lyWmlNT0NZ?=
 =?utf-8?B?SktGVno5c3hXWEUxODZGVkdTVFAyVlh0WGprVjhxM3AzTG90UG1hRWZyQUlz?=
 =?utf-8?B?cnc3bU5FTnVIUWlmd0JnQklyMTNMM3lUdG9rb2xqZnRGSXNrZ1BHWnlzK29u?=
 =?utf-8?B?VUxhekxsd2x2R09HRUtaUDNtYmQwQU52UHBTN1BRbjdTM2NhL2RVem5pYnV2?=
 =?utf-8?B?SkF3Q0ZaSWtmNHJ5Y3YvLzIvWWFJRGEzVmc3SlVSR3hhUXJrdnVUbHlISU9I?=
 =?utf-8?B?SkdDNFR6OFFHbGw4bnNxdWFxeVJWamViZGh2UVBMRXFFU01wZkRGZ3VnVUVw?=
 =?utf-8?B?Z1dBSWZzVHlZdGxOYmErV2Q3OVBtaHhoZ1hGc1pjWkkvTzB3QTJCUGhxOUFn?=
 =?utf-8?B?Q2tHTzZCbDkxbUJNMGVibVEwV2JIdXZNQmplUjA5dmR4SHN3TUZndG9UbXNR?=
 =?utf-8?B?OUVqZDY5RjB1aC9SNXhqWlNYalhwdTBIOGdsMFdQcjVXNFpxOE4vODdsalRC?=
 =?utf-8?B?M3JLTFdkMmhlUWhhSjc1aDBVTEJuWWxmRFFzeE15aXg2YjltbHBycnl0N3lS?=
 =?utf-8?B?cXpON3V6ZUdZL3BnSjRFMEI2cVJvNzV1OHZaL0UrazBLUU5Hd0Fha1hHM1VG?=
 =?utf-8?B?aUwvNzJod2pybHp1YW95U210cTRYNnhKMGJwNlFOWkRmVjlhc1hKVkJmRnVi?=
 =?utf-8?B?L3BLNDRsaUVFaG5Gc29oakxCUVRBM2N4TVdNRDdJd1UyTGtpNDYrdHV1R2pH?=
 =?utf-8?B?U0dSU0habzJXTGUvKzJqUlVMSS9qK2VnMWoxZlZUcEFHcTNpOWFkRjFMS3Vs?=
 =?utf-8?B?LytHTm9MUzNJeWowMC9XOG1IWE9SbE83ZWVVTDNJVUY2ZHNvdHlYSnVKdHNN?=
 =?utf-8?B?WHVCNVBkK3lYTTUzbytCRGhwVzQvQWRyRmFtODlxTkg2ciswaEJpbDlLS3gy?=
 =?utf-8?B?SEdqWEF2L2hpZ25kRldSYzlja3BTeTlXVmw5b3lSbGI3R21uY2YxTURjSTUw?=
 =?utf-8?B?eWJQS0JEVHo0aHR5eUxMZkRmRDFqNzZuWXk2bDEyZlZTSmtnUHBzZ2JkTldF?=
 =?utf-8?B?blZKdWcrc0wwbHRMSXpUVXd6d2s4Tk9RSk1WTWZ4UXBPZ2hMdFV1NWRXSUZR?=
 =?utf-8?B?eGdBK1U4aElzV29iNkNxSWFjQzM5cWZEWndYREFBeEloYmV3TWFWMm9OWHR3?=
 =?utf-8?Q?1INCZp4OGQLTb8bxmV8kfzn8b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8be9d51-3d01-4865-e5c0-08dcc4c3b5b5
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 05:06:43.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xClAbUFG12yWwNTcA1rUtKBa2UtmjKatXpEhma8vreqKFC37HyyR/+TK+gml0T0pRSk1aEzp7gaOLoH51gsWew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6195



在 2024/8/25 0:26, Lorenzo Stoakes 写道:
> [Some people who received this message don't often get email from lorenzo.stoakes@oracle.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Fri, Aug 23, 2024 at 11:02:06PM GMT, Zhiguo Jiang wrote:
>> After CoWed by do_wp_page, the vma established a new mapping relationship
>> with the CoWed folio instead of the non-CoWed folio. However, regarding
>> the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
>> not same, the avc binding relationship between them will no longer be
>> needed, so it is issue for the avc binding relationship still existing
>> between them.
>>
>> This patch will remove the avc binding relationship between vma and the
>> non-CoWed folio's anon_vma, which each has their own independent
>> anon_vma. It can also alleviates rmap overhead simultaneously.
>>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>
> NACK (until fixed). This is broken (see below).
>
Hi Lorenzo Stoakes,

Thank you for your comments.
> I'm not seeing any numbers to back anything up here as to why we want to
> make changes to this incredibly sensitive code?
I added a debug trace log (as follows) in wp_page_copy() and observed
that a large number of these orphan avc-objects still exist. I believe
this will have a certain redundant overhead impact on anonymous folios'
rmap avcs, so I want to remove it, which is also the most essential
value of this patch.

-- the vital part of debug trace patch:
diff --git a/mm/memory.c b/mm/memory.c
index 3bf1943a4..8cd8e8349
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -83,6 +83,7 @@

  #undef CREATE_TRACE_POINTS
  #include <trace/hooks/mm.h>
+#include <trace/events/vmscan.h>

  #include <asm/io.h>
  #include <asm/mmu_context.h>
@@ -3412,6 +3421,38 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
                 folio_put(old_folio);
         }

+       if (old_folio && old_folio->mapping) {
+               struct anon_vma *parent_anon_vma = 
folio_anon_vma(old_folio);
+               struct vm_area_struct *child_vma = vma;
+               pgoff_t pgoff_start, pgoff_end;
+               struct anon_vma_chain *avc;
+               bool is_same_folio_av;
+               bool is_same_avc_av;
+
+               if (!parent_anon_vma)
+                       goto exit;
+
+               pgoff_start = folio_pgoff(old_folio);
+               pgoff_end = pgoff_start + folio_nr_pages(old_folio) - 1;
+
+               if (!anon_vma_trylock_read(parent_anon_vma))
+                       goto exit;
+
+               anon_vma_interval_tree_foreach(avc, 
&parent_anon_vma->rb_root,
+                               pgoff_start, pgoff_end) {
+                       if (avc->vma != child_vma || parent_anon_vma == 
child_vma->anon_vma)
+                               continue;
+
+                       is_same_folio_av = parent_anon_vma == 
child_vma->anon_vma;
+                       is_same_avc_av = avc->anon_vma == 
child_vma->anon_vma;
+
+                       trace_mm_wp_page_copy(is_same_folio_av, 
is_same_avc_av);
+                       break;
+               }
+               anon_vma_unlock_read(parent_anon_vma);
+       }
+
+exit:
         delayacct_wpcopy_end();
         return 0;
  oom:

-- debug trace log:
RAM 16GB machine, boot trace log:
             init-8122    [005] .....    58.937307: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             init-8122    [005] .....    58.937325: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             init-8122    [005] .....    58.937330: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  processor-excep-3331    [000] .....    60.042006: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  processor-excep-3331    [000] .....    60.042864: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  processor-excep-3331    [000] .....    60.042893: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  processor-excep-3331    [000] .....    60.042933: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  processor-excep-3331    [000] .....    60.042979: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  processor-excep-3331    [004] .....    60.156496: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  processor-excep-3331    [004] .....    60.156628: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    Profile Saver-4298    [000] .....    60.311901: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [000] .....    60.825851: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [000] .....    60.826154: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [000] .....    60.826450: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [000] .....    60.826519: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [002] .....    60.837051: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   binder:1720_1A-3281    [001] .....    60.843870: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   SnapshotWindow-1952    [007] .....    60.848054: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [005] .....    60.849531: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [005] .....    60.849676: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [005] .....    60.849711: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [005] .....    60.849759: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [005] .....    60.849801: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [005] .....    60.849812: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [005] .....    60.849818: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  PowerManagerSer-1856    [007] .....    60.850114: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  PowerManagerSer-1856    [007] .....    60.850308: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   SnapshotWindow-1952    [002] .....    60.850765: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   SnapshotWindow-1952    [002] .....    60.850770: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7919    [005] .....    60.851695: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   SnapshotWindow-1952    [002] .....    60.852102: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   SnapshotWindow-1952    [002] .....    60.852120: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   SnapshotWindow-1952    [002] .....    60.852124: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   SnapshotWindow-1952    [002] .....    60.852129: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   SnapshotWindow-1952    [002] .....    60.852136: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ReferenceQueueD-7920    [004] .....    60.852299: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   SnapshotWindow-1952    [003] .....    60.855833: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   SnapshotWindow-1952    [003] .....    60.856436: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  PowerManagerSer-1856    [000] .....    60.860096: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  PowerManagerSer-1856    [000] .....    60.863771: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  PowerManagerSer-1856    [000] .....    60.864041: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    mali-compiler-8132    [005] .....    60.864255: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    mali-compiler-8132    [005] .....    60.864261: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    mali-compiler-8132    [005] .....    60.864373: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    mali-compiler-8132    [005] .....    60.864376: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    mali-compiler-8132    [005] .....    60.864379: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    mali-compiler-8132    [005] .....    60.864381: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    mali-compiler-8132    [005] .....    60.864384: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    mali-compiler-8132    [005] .....    60.864386: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    mali-compiler-8132    [005] .....    60.864388: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    mali-compiler-8132    [005] .....    60.864390: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  PowerManagerSer-1856    [004] .....    60.864668: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  PowerManagerSer-1856    [004] .....    60.864841: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  PowerManagerSer-1856    [004] .....    60.871942: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  PowerManagerSer-1856    [004] .....    60.871960: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  PowerManagerSer-1856    [004] .....    60.872276: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [000] .....    60.898670: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [000] .....    60.898816: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [000] .....    60.898894: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [000] .....    60.898975: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [000] .....    60.899023: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [002] .....    60.908909: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [002] .....    60.909095: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.920062: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.920174: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.920227: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.920356: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.920419: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.920426: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.920438: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.920449: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.920525: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.921085: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7982    [003] .....    60.925772: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152644: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152708: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152720: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152729: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152738: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152746: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152755: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152761: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152770: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152780: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152787: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152843: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152852: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152865: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152872: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152879: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152885: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152892: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152899: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152906: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152913: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152920: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152925: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152932: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152938: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152944: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152950: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152956: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152964: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152972: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152979: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152985: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152991: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.152997: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.153004: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.153010: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.153017: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.153024: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.153030: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.153037: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7235    [001] .....    61.153044: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201692: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201741: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201752: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201761: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201771: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201779: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201785: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201792: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201802: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201811: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201818: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201862: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201871: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201877: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201886: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201892: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201898: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201905: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201911: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201917: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201923: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201928: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201934: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201941: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201947: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201953: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201958: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201964: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201971: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201978: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201984: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201989: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.201996: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.202002: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.202008: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.202013: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.202020: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.202025: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   HeapTaskDaemon-7723    [001] .....    61.202033: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  m.bbk.launcher2-2470    [007] .....    61.256512: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:1720_C-2875    [000] .....    61.263076: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:2757_2-2792    [005] .....    61.273692: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:2562_A-4454    [002] .....    61.273713: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:4905_3-6219    [003] .....    61.274793: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:5103_4-5352    [000] .....    61.275539: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:2562_A-4454    [005] .....    61.278025: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
           NormHT-3019    [003] .....    61.278292: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  UsageAppPidMana-6780    [005] .....    61.281626: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  UsageAppPidMana-6780    [005] .....    61.281633: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.283432: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.283453: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.285153: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.285185: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.285190: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.285197: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.285205: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  m.bbk.launcher2-2470    [006] .....    61.286188: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  m.bbk.launcher2-2470    [006] .....    61.286296: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.288272: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ndroid.systemui-2504    [007] .....    61.289578: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290225: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290255: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290289: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290320: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290336: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290344: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290347: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290422: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290431: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290435: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290444: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290454: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290805: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290839: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290851: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.290859: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.291183: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.291208: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  bluetoothgnssco-3134    [004] .....    61.291217: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.292149: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.292170: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.292190: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.292247: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:7783_4-8143    [003] .....    61.292877: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.297263: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.301792: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.301833: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.301852: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.301862: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.301895: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304695: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304699: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304701: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304704: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304707: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304709: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304712: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304715: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304719: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304722: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304725: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304728: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304731: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304734: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304737: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304740: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304743: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304794: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304798: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304800: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304804: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304806: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304809: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-2778    [000] .....    61.304813: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
           Poller-3115    [000] .....    61.334540: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
           Poller-3115    [000] .....    61.334649: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
           Poller-3115    [000] .....    61.334895: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
           Poller-3115    [000] .....    61.335042: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
          battery-3131    [001] .....    61.346283: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
        pie_modem-4828    [000] .....    61.357512: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    Profile Saver-3264    [005] .....    61.369759: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    Profile Saver-3264    [005] .....    61.369774: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.389873: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.389979: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.391443: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.393149: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.394116: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  NightPearlSubTh-3741    [002] .....    61.394121: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.394384: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.394699: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.394738: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.394846: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.395038: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.395207: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.396856: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  NightPearlSubTh-3741    [000] .....    61.397907: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.399286: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.399814: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.400471: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.400583: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.402722: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.404684: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.404783: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  NightPearlSubTh-3741    [005] .....    61.405408: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.406521: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-2714    [003] .....    61.408788: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.409364: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-2714    [005] .....    61.410221: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-2714    [005] .....    61.410270: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.412004: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.412914: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-2714    [005] .....    61.414456: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  VivoDisplayOver-2453    [005] .....    61.414679: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  VivoDisplayOver-2453    [005] .....    61.414775: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.416500: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.416678: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.425169: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.428085: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.439897: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.479768: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.479860: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:7783_4-8143    [002] .....    61.484606: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.487507: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.487731: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.491316: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.495249: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.495260: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.495301: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.495378: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.496233: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.496395: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.496958: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.496977: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.498412: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.499505: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [000] .....    61.501465: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [000] .....    61.501479: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [000] .....    61.501538: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.501563: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501675: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501692: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501698: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501704: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501707: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501711: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501722: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501727: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501729: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501734: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501738: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501744: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501747: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501749: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501757: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501759: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501763: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .n...    61.501766: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501772: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  martmultiwindow-2687    [004] .....    61.501783: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  martmultiwindow-2687    [004] .....    61.501836: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501840: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501847: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501852: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501854: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501857: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501860: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501866: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501874: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  martmultiwindow-2687    [004] .....    61.501898: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  martmultiwindow-2687    [004] .....    61.501907: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  martmultiwindow-2687    [004] .....    61.501911: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  martmultiwindow-2687    [004] .....    61.501915: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
               sh-8169    [005] .....    61.501984: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  o.secure:remote-4982    [000] .....    61.503007: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-7918    [005] .....    61.509140: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.511729: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.511737: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
         Single_1-5255    [000] .....    61.521244: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524405: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524428: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524449: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524509: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524541: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524549: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524559: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524575: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524580: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524601: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524605: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524614: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524618: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524622: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524627: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524645: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524657: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524665: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524724: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.524740: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525124: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525143: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525148: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525152: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525156: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525162: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525219: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525261: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525279: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525285: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525304: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525322: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525373: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525454: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525458: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525471: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525475: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525478: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525482: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525488: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525493: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525497: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525527: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525542: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525545: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525765: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525791: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525847: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525903: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.525954: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526025: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526035: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526284: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526317: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526322: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526331: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526336: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526347: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526351: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526416: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526438: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526505: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526533: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526556: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526560: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526572: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.526682: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.527702: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.527767: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.527881: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.528018: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.529450: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.530086: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.530576: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [005] .....    61.531608: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.532191: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.532250: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.532256: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.532263: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.532268: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.532333: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.532541: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.532563: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [007] .....    61.532755: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.532832: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [001] .....    61.532856: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [007] .....    61.533662: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [007] .....    61.534509: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [007] .....    61.534640: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
             main-8182    [007] .....    61.534722: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.534774: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.534806: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.534818: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.534839: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.534867: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535202: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535212: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535250: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535260: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535264: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535269: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535312: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535315: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535318: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535433: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535436: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535438: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535457: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535461: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535491: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535504: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535508: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535518: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535526: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535533: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535540: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535544: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535549: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535552: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535558: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535567: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535572: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535577: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535584: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535587: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535592: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535595: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535609: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535614: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535618: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535625: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535631: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535635: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535644: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535647: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535650: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535663: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535667: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535670: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535680: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535687: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535692: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535705: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535732: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535772: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.535788: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   Signal Catcher-8189    [004] .....    61.535946: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   Signal Catcher-8189    [004] .....    61.535955: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.536181: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.536234: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.536257: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.536311: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.536393: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.536410: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  perfetto_hprof_-8190    [000] .....    61.536467: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.536490: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.537091: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.537096: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.537148: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.537175: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.537189: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.537205: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.537222: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.537332: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.537482: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537540: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537546: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537606: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537681: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537733: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537742: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537799: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537809: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537842: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537857: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537909: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537938: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537965: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537971: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537974: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537989: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537993: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.537999: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538003: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538008: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538014: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538018: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538053: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538056: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538111: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538122: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538142: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538164: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538177: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538189: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538195: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538255: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538262: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538268: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538276: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538281: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538289: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538292: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538312: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538348: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538466: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538483: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538508: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538523: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538533: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538546: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538549: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538562: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538575: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538617: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538629: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538633: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538635: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538727: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538739: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538791: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538794: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538796: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538861: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538921: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538954: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538969: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.538981: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539005: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539032: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539054: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539072: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539100: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539168: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539309: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539375: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539382: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539386: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539389: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539398: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539401: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539405: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539415: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539421: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_1-8196    [005] .....    61.539432: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_1-8196    [005] .....    61.539440: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_1-8196    [005] .....    61.539452: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_1-8196    [005] .....    61.539456: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539526: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539577: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539586: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-7791    [002] .....    61.539617: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539629: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539640: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_1-8197    [000] .....    61.539658: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539664: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539679: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539685: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539689: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539693: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539700: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539709: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_1-8197    [000] .....    61.539711: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539713: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539733: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.539759: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540008: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540028: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540033: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540056: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540059: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540061: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540065: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540077: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540082: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540101: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540104: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540128: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540132: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540152: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540173: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540178: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540198: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540201: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540214: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540221: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540239: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540265: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540339: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540352: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540359: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540371: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540374: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540377: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540457: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540511: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540623: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540636: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540641: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540756: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540788: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540805: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540824: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540828: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540836: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540852: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.540961: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.541017: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541025: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541053: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541071: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541094: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541161: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541213: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541224: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541237: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541241: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541288: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541295: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541303: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541341: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541367: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541373: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541387: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541409: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541426: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541463: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541705: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541727: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541736: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541768: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541773: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541829: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541843: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541848: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541882: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541892: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541900: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541962: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.541972: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.542128: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.542152: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.542357: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.542514: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.542529: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.542550: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.542554: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.542600: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.542631: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.542653: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.543529: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.543592: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.543600: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.543606: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.543611: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.543621: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.543720: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.543752: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.543804: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.543809: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [003] .....    61.543814: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.543879: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [004] .....    61.543920: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.544478: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.544719: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.544916: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.544923: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.545118: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.545375: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.545925: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [000] .....    61.546508: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.548130: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.548269: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.548972: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.549254: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.549279: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.549485: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.549501: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.549793: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.549840: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.549883: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.549912: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.549937: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.549973: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.549986: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.550008: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.550027: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.550042: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.550052: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.550062: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.550069: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.550077: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.550124: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.550133: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [003] .....    61.550229: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.550328: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.550390: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.550397: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [002] .....    61.550483: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [004] .....    61.550619: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [004] .....    61.550669: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [004] .....    61.550718: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [004] .....    61.550789: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [004] .....    61.550798: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [004] .....    61.550808: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [005] .....    61.551001: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [005] .....    61.551121: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_3-8199    [006] .....    61.551161: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_3-8199    [006] .....    61.551196: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [005] .....    61.551318: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [005] .....    61.551425: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [005] .....    61.551430: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [005] .....    61.551435: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [005] .....    61.551442: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [005] .....    61.551491: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [005] .....    61.551612: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  re-initialized>-8182    [005] .....    61.551620: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.551827: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.551834: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.551861: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.551917: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.551931: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.551944: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.551975: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.551978: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.551997: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552055: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552083: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552125: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552209: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552219: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552225: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552232: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552251: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552255: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552266: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552336: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552362: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552369: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552398: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552407: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552412: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552418: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552428: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552433: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552447: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552455: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552480: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552494: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552512: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552557: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552571: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552652: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552664: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552753: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552788: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552817: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552842: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.552854: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.553004: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.553295: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.553912: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.553955: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554006: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554017: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554069: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554072: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554079: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554095: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554133: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554152: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554167: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554170: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554179: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554216: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554223: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554230: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554246: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554253: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554264: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.554269: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.554455: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.554482: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.554504: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.554898: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555004: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [001] .....    61.555011: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555343: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [001] .....    61.555361: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555398: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555439: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555459: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555464: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555569: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555580: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555595: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555601: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555604: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [001] .....    61.555623: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555624: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555658: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555672: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555831: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555902: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.555985: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.556106: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.556144: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.556157: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [001] .....    61.556428: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.556560: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.556707: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.556763: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.556767: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.556787: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557010: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557022: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557115: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557193: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557208: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557258: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557355: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557385: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557450: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557456: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557459: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.557596: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [001] .....    61.557725: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558069: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558101: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558107: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558322: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558341: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558345: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558348: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558351: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558388: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558391: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558546: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558549: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558627: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.558875: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559037: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559153: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559196: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559199: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559202: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559207: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559212: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559217: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559220: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559224: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559242: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559268: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559293: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559454: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559946: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559950: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559956: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559972: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.559976: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560014: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560071: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560095: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560124: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560153: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560170: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560187: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560191: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560206: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560395: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560407: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560429: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560446: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560454: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560460: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560466: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560469: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560476: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560485: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [001] .....    61.560505: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560577: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560588: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560593: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560596: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560600: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560603: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560608: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560610: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560621: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560625: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560632: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560639: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560656: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560660: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.560686: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [001] .....    61.560705: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [001] .....    61.560825: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.561067: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.561186: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.561227: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [003] .....    61.561266: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.561306: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [003] .....    61.561310: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.561326: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [003] .....    61.561331: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.nightpearl-7783    [002] .....    61.561338: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.561355: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.561359: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.561370: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.561733: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.561759: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [003] .....    61.562023: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.562462: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.562470: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.562488: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.562496: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.562513: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.562524: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.562531: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.562757: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [003] .....    61.562800: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [003] .....    61.562814: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  vivo.PerfThread-8206    [004] .....    61.562976: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563140: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563256: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563272: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563276: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563280: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563283: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563288: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563321: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563348: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563353: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563364: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563370: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563373: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563378: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563386: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563395: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563415: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563462: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563479: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563487: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563502: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563509: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563516: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563526: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563552: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563565: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563580: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563584: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563589: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563613: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563620: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563625: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563693: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [001] .....    61.563768: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [001] .....    61.563775: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [001] .....    61.563781: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [001] .....    61.563785: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [001] .....    61.563790: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [001] .....    61.563794: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8205    [001] .....    61.563800: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.563879: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564234: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564501: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564630: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564654: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564663: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564810: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564842: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564855: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564869: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564887: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564894: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564898: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.564908: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.565128: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.565415: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.565457: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.565462: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.565467: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.565564: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.565664: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.566328: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.567005: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [001] .....    61.567168: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [001] .....    61.568012: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.568845: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.570162: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.570174: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [003] .....    61.570286: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.570520: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [003] .....    61.571810: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [003] .....    61.572348: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     RenderThread-8167    [003] .....    61.572457: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.574653: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.577148: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.577176: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.582914: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.582923: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.583285: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.583812: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.585169: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8214    [003] .....    61.585181: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.585275: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.585302: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
         Thread-2-8214    [003] .....    61.585494: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.585860: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.586393: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.588550: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.588553: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.588978: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.588992: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.589069: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.589243: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.589250: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.589254: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [004] .....    61.589259: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.589294: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.589311: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.589324: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   CrashCollector-8215    [006] .....    61.591261: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   CrashCollector-8215    [006] .....    61.591423: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
   CrashCollector-8215    [006] .....    61.591466: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.594138: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.594172: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.594277: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.594344: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.594361: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.594366: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.594370: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.594443: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.594447: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8219    [003] .....    61.594843: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.595427: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.596552: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.596557: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.596742: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8224    [007] .....    61.596834: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  SharedPreferenc-8224    [007] .....    61.596880: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  SharedPreferenc-8224    [005] .....    61.597093: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  SharedPreferenc-8224    [005] .....    61.597102: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.597188: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    SqlWorkThread-8223    [007] .....    61.597231: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.597912: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.598073: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.598090: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.598135: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.598252: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.598280: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.598284: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.599089: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.599144: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    SqlWorkThread-8223    [002] .....    61.599328: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    SqlWorkThread-8223    [002] .....    61.599384: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [000] .....    61.600943: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.601528: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.601534: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.601559: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.601625: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.601683: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [006] .....    61.603507: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [006] .....    61.603512: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [006] .....    61.603518: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [006] .....    61.603745: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.604983: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.605058: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [007] .....    61.605065: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.605135: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.605155: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.605159: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.605165: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.605171: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.605176: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.605179: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.605182: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.605260: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.606762: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.606887: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.606928: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [006] .....    61.607469: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_2-8197    [006] .....    61.608228: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.608703: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.608813: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.608822: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.608831: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.608863: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.608913: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.608975: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.608979: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.608986: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.608999: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.609007: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.609024: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.609078: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.609082: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.609107: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [004] .....    61.609152: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
         AiPool_1-8229    [002] .....    61.609778: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613231: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613244: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613249: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613257: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613261: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613269: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613273: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613277: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613281: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613286: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613290: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613296: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613301: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613304: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613308: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613313: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613317: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613368: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613372: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613377: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613381: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613385: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613389: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.613393: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.615399: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.615458: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.615574: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.615592: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [007] .....    61.615880: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [007] .....    61.615976: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [007] .....    61.616001: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.616801: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.616824: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  Jit thread pool-8191    [003] .....    61.617197: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.617936: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618230: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618247: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618270: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618274: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618280: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618341: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618413: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618416: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618464: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618929: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618934: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.618975: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.619049: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.619056: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.619316: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.619555: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.620097: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.620104: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.620143: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.620661: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.620691: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8217    [005] .....    61.620738: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    TrackerCore-1-8234    [000] .....    61.625835: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
  ivo.ai.gptagent-8182    [005] .....    61.626662: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_4-8230    [006] .....    61.629081: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
    binder:8182_4-8230    [006] .....    61.629092: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     AsyncHandler-8239    [005] .....    61.629296: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     AsyncHandler-8239    [005] .....    61.629366: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
     AsyncHandler-8239    [006] .....    61.629971: mm_wp_page_copy: 
is_same_folio_av=0 is_same_avc_av=0
>
> Also anon_vma logic is very complicated and confusing, this commit message
> feels about 3 paragraphs too light.
>
> Under what circumstances will vma->anon_vma be different from
> folio_anon_vma(non_cowed_folio)? etc.
In anon_vma_fork() --> anon_vma_clone(), child vma is bound with parent
vma's anon_vma firstly.
     /*
      * First, attach the new VMA to the parent VMA's anon_vmas,
      * so rmap can find non-COWed pages in child processes.
      */
     error = anon_vma_clone(vma, pvma);

When child vma->anon_vma is NULL in anon_vma_fork(),
     /* An existing anon_vma has been reused, all done then. */
     if (vma->anon_vma)
         return 0;

     /* Then add our own anon_vma. */
     anon_vma = anon_vma_alloc();

new anon_vma will be alloced and filled in this child vma->anon_vma.
Then during CoWed in do_wp_page() --> wp_page_copy(), this child vma's
new anon_vma will be different from folio_anon_vma(non_cowed_folio).
> Confusing topics strongly require explanations that help (somewhat)
> compensate. This is one of them.
>
>> ---
>>
>> -v2:
>>   * Solve the kernel test robot noticed "WARNING"
>>     Reported-by: kernel test robot <oliver.sang@intel.com>
>>     Closes: https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
> It doesn't.
>
> Saw a bunch of warning output in dmesg when running in qemu, bisected it to
> this commit. The below assert is being fired (did you build this kernel
> with CONFIG_DEBUG_VM?):
>
>          VM_WARN_ON(anon_vma->num_children);
>
>  From what I saw, these appear to all be cases where anon_vma->num_children == 0...
>
>
> [    1.905603] ------------[ cut here ]------------
> [    1.905604] WARNING: CPU: 2 PID: 231 at mm/rmap.c:443 unlink_anon_vmas+0x181/0x1c0
> [    1.905605] Modules linked in:
> [    1.905605] CPU: 2 UID: 1000 PID: 231 Comm: zsh Tainted: G        W          6.11.0-rc4+ #49
> [    1.905606] Tainted: [W]=WARN
> [    1.905606] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [    1.905607] RIP: 0010:unlink_anon_vmas+0x181/0x1c0
> [    1.905608] Code: 48 83 7f 40 00 75 1c f0 ff 4f 30 75 ab e8 d7 fd ff ff eb a4 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 0f 0b 90 eb de 90 <0f> 0b 90 eb d1 90 0f 0b 90 48 83 c7 08 e8 4d 7c ea ff e9 fc fe ff
> [    1.905608] RSP: 0018:ffffc90000547cb0 EFLAGS: 00010286
> [    1.905609] RAX: ffff88817b265390 RBX: ffff88817b265380 RCX: ffff88817b2cb790
> [    1.905609] RDX: ffff88817b265380 RSI: ffff88817b2cb790 RDI: ffff888179e08888
> [    1.905610] RBP: dead000000000122 R08: 000000000000000c R09: 0000000000000010
> [    1.905610] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88817b2cb790
> [    1.905611] R13: dead000000000100 R14: ffff88817b2cb780 R15: ffff888179e08888
> 00000000000
> [    1.905613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.905613] CR2: 0000555bc5d97390 CR3: 000000017c12c000 CR4: 0000000000750ef0
> [    1.905614] PKRU: 55555554
> [    1.905614] Call Trace:
> [    1.905614]  <TASK>
> [    1.905615]  ? unlink_anon_vmas+0x181/0x1c0
> [    1.905615]  ? __warn.cold+0x8e/0xe8
> [    1.905616]  ? unlink_anon_vmas+0x181/0x1c0
> [    1.905617]  ? report_bug+0xff/0x140
> [    1.905618]  ? handle_bug+0x3b/0x70
> [    1.905619]  ? exc_invalid_op+0x17/0x70
> [    1.905620]  ? asm_exc_invalid_op+0x1a/0x20
> [    1.905621]  ? unlink_anon_vmas+0x181/0x1c0
> [    1.905622]  free_pgtables+0x11f/0x250
> [    1.905622]  exit_mmap+0x15e/0x380
> [    1.905624]  mmput+0x54/0x110
> [    1.905625]  do_exit+0x27e/0xa10
> [    1.905626]  ? __x64_sys_close+0x37/0x80
> [    1.905626]  do_group_exit+0x2b/0x80
> [    1.905628]  __x64_sys_exit_group+0x13/0x20
> [    1.905629]  x64_sys_call+0x14af/0x14b0
> [    1.905630]  do_syscall_64+0x9e/0x1a0
> [    1.905630]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [    1.905631] RIP: 0033:0x7f4416ae33ad
> [    1.905632] Code: Unable to access opcode bytes at 0x7f4416ae3383.
> 000e7
> [    1.905633] RAX: ffffffffffffffda RBX: 00007f4416d5e3c0 RCX: 00007f4416ae33ad
> [    1.905633] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
> [    1.905633] RBP: 0000555b8eed1378 R08: 0000000000000000 R09: 0000000000000007
> [    1.905634] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [    1.905634] R13: 0000000000000000 R14: 00007ffe7dbe9190 R15: 00007ffe7dbe9110
> [    1.905635]  </TASK>
> [    1.905635] ---[ end trace 0000000000000000 ]---
> [    1.905638] ------------[ cut here ]------------
>
>
>>   * Update comments to more accurately describe this patch.
>>
>> -v1:
>>   https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/
>>
>>   include/linux/rmap.h |  1 +
>>   mm/memory.c          |  8 +++++++
>>   mm/rmap.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 62 insertions(+)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 91b5935e8485..8607d28a3146
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
>>        folio_remove_rmap_ptes(folio, page, 1, vma)
>>   void folio_remove_rmap_pmd(struct folio *, struct page *,
>>                struct vm_area_struct *);
>> +void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
>>
>>   void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>>                unsigned long address, rmap_t flags);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 93c0c25433d0..4c89cb1cb73e
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>>                         * old page will be flushed before it can be reused.
>>                         */
>>                        folio_remove_rmap_pte(old_folio, vmf->page, vma);
>> +
>> +                     /*
>> +                      * If the new_folio's anon_vma is different from the
>> +                      * old_folio's anon_vma, the avc binding relationship
>> +                      * between vma and the old_folio's anon_vma is removed,
>> +                      * avoiding rmap redundant overhead.
> What overhead? Worth spelling out for instance if it's unnecessary to
> traverse avc's.
I think this will have a certain redundant overhead impact on anonymous
folios rmap traverse avcs process.
>
>> +                      */
>> +                     folio_remove_anon_avc(old_folio, vma);
>>                }
>>
>>                /* Free the old page.. */
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 1103a536e474..56fc16fcf2a9
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1522,6 +1522,59 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>>   #endif
>>   }
>>
>> +/**
>> + * folio_remove_anon_avc - remove the avc binding relationship between
>> + * folio and vma with different anon_vmas.
>> + * @folio:   The folio with anon_vma to remove the binded avc from
>> + * @vma:     The vm area to remove the binded avc with folio's anon_vma
>> + *
>> + * The caller is currently used for CoWed scene.
> Strange turn of phrase,
>
>> + */
>> +void folio_remove_anon_avc(struct folio *folio,
> I think this should be 'oldfolio'. You're not looking at the copied folio,
> but the unCoW'd original folio.
Yes, thanks.
>
>> +             struct vm_area_struct *vma)
>> +{
>> +     struct anon_vma *anon_vma = folio_anon_vma(folio);
>> +     pgoff_t pgoff_start, pgoff_end;
>> +     struct anon_vma_chain *avc;
>> +
>> +     /*
>> +      * Ensure that the vma's anon_vma and the folio's
>> +      * anon_vma exist and are not same.
>> +      */
>> +     if (!folio_test_anon(folio) || unlikely(!anon_vma) ||
> The folio_test_anon() is already implied by folio_anon_vma() != NULL and
> doesn't preclude KSM.
>
>> +         anon_vma == vma->anon_vma)
>> +             return;
> This is all super confusing, the 'parent' is actually anon_vma
> (oldfolio). The newly created 'child' anon_vma is vma->anon_vma. Should
> probably rename each accordingly.
OK.
>
>
>> +
>> +     pgoff_start = folio_pgoff(folio);
>> +     pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
>> +
>> +     if (!anon_vma_trylock_write(anon_vma))
>> +             return;
>> +
>> +     anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
>> +                     pgoff_start, pgoff_end) {
>> +             /*
>> +              * Find the avc associated with vma from the folio's
>> +              * anon_vma and remove it.
>> +              */
> This is a meaningless comment.
>
> This should be something like 'anon_vma_chain objects bind VMAs and
> anon_vma's. Find the avc binding the unCoW'd folio's anon_vma to the new
> VMA, and remove it, as it is now redundant.'
>
>> +             if (avc->vma == vma) {
> In testing I found that a lot of the time this isn't found at all... is
> that expected?
>
>> +                     anon_vma_interval_tree_remove(avc, &anon_vma->rb_root);
>> +                     /*
>> +                      * When removing the avc with anon_vma that is
>> +                      * different from the parent anon_vma from parent
>> +                      * anon_vma->rb_root, the parent num_children
>> +                      * count value is needed to reduce one.
>> +                      */
> This is a really confusing comment. You're not explaining the 'why' you're
> just essentially asserting that you need to do this, and clearly this is
> broken.
>
>> +                     anon_vma->num_children--;
> So we know this is broken to start due to VM_WARN_ON() failures.
>
> As per above dmesg analysis, sometimes this is zero, so you're
> underflowing. We definitely need a:
>
>          VM_WARN_ON(anon_vma->num_children == 0);
>
> At least.
>
> But also the naming is broken here too, anon_vma is actually the parent
> (oldfolio's) anon_vma...
>
>
> This is also just not correct on any level - the anon_vma->num_children
> field indicates how many child anon_vma objects point at it via
> anon_vma->parent, NOT avc.
>
> You're removing an avc, not disconnecting an anon_vma.
>
> So it seems to me you should have logic to remove the avc AND logic to
> disconnect vma->anon_vma from (parent) anon_vma if it points to it.
>
> You'll need to be careful about locking when you do that too, as anon_vma's
> lock on the root anon_vma, but in isolating the child anon_vma you'd lose
> this lock.
>
> I've tried to write code to fix this but haven't been able to yet, this is
> fiddly stuff.
>
> (I think this might have seemed to work at some point in testing because
> unlink_anon_vmas() uses the avc list to determine what to unlink, rather
> than looking at individual anon_vma's but still).
>
>> +
>> +                     list_del(&avc->same_vma);
>> +                     anon_vma_chain_free(avc);
>> +                     break;
>> +             }
>> +     }
>> +     anon_vma_unlock_write(anon_vma);
>> +}
>> +
>>   static __always_inline void __folio_remove_rmap(struct folio *folio,
>>                struct page *page, int nr_pages, struct vm_area_struct *vma,
>>                enum rmap_level level)
>> --
>> 2.39.0
>>
> Again I question the value of this change. Are we REALLY seeing a big
> problem due to unneeded avc's hanging around? This is very sensitive,
> fiddly, confusing code, do we REALLY want to be playing with it?
Thank you for helping to identify mang issues with this patch. However,
I think this will have a certain benefits for anonymous folio rmap
traverse avc overhead.
>
> It'd be good to get some tests though unless you move this to vma.c with
> its userland testing (probably a good idea actually as Andrew suggested)
> this might be tricky.
This patch belongs to anon_vma rmap's content, and it seems more
appropriate in mm/rmap.c?
>
> NACK until the issues are fixed and the approach at least seems more
> correct.
Thanks
Zhiguo


