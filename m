Return-Path: <linux-kernel+bounces-563248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B5A63B35
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB32C3A9A03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3799B1519A3;
	Mon, 17 Mar 2025 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LNnFqTI+"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2061.outbound.protection.outlook.com [40.107.215.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E114B945
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742177554; cv=fail; b=m8qsjbrtWltjfx89rETEflXzzAY9Qo18/yFmwjVsGyRGeFbPh6Euyu2HFlcJQeWYRM86rGbB4ubhXtMcCR/dD42FYfysqvwjyDXGEKonmGYVsPifhVYfkyi7d9Mx6KRBSbsvUT9N4TSowSqcLoTWzqrgQfaUNYirf4EVBarT3Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742177554; c=relaxed/simple;
	bh=DfGM5EhLM3aaRRdWJh3Tp3orwleozUNygvUnKg3HpI8=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r56ktWf0lewp0IzkY0CDjtJf4aerPylubNJH51i4LHu2N0/++HA4+r1La04TlhEil1c7RrTNYICKLe2o06tCLXzmAom3tz6073jJZ2XXKP4Y117wIyS0xpihZdCaGX5D6K9sYgBy2Tpnutuc5lysMr9r4Og7shAwOvk2RXYvpqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LNnFqTI+; arc=fail smtp.client-ip=40.107.215.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1fHv/XnlFXGRYeC1g5sXtxmiWI0RWxuUDPxe/5q399P8oXQxrhrkC5KZuyn7xhd2HlcDA9smmHI1MQFCH5/QbaC1eLd+W3J3X+m1ulMwIJOTQ70hTb+4CP3rn8chOLnY5lrKBdkodBkylmvirDudtmSyhSpW38bA/ayLUk1MHK/HPmqY354lFzbWLH1AReI+Q7r4iSOoDV9tsHcINWulS8iAcE7QU1LUBECB/CSjs2toGhLLDvkVVkS6FuvOZO4yPtPNM3HGHMolc3wSLhcNQ+XCrlJ2F2NR3LDRVjwNLBNd8IMsjhWdFn8ozUeCWkx3KwHAK0xXyu9JAYd4i6HUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBEcJjrhSnUdofhyAYDuu6mXdvoBE9+CHufq+Xkgq7M=;
 b=boO1gkdg8zbsTIQFO0VPCQvP11SDURmez/i+JykBRBuwEf/ceyTCSSinpjA2Pm7EqVfBuroOnfsY5fvSGOzWZIPFo0giVZxYkKwejW/0LgppXsjYPvxSGKBYZuyTozGIYiS9JBQajqZn0x+dmH3NY1Zttrf9rADOMTwE6HzVJoeQopmenAu2QUFt4s+//8itskJpWIeWCB0gN/4coa2m1PRatkOJ3OayEBqO6GufRyO+dAFsy8ic3Yp55iEju30tj79CPtsup3X35IoX2NoyESPJcFMkThK8ix7hpg7YKTK2mVokljePjFWHD65nbLTy+30egxgMdvnzrbd9BX551g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBEcJjrhSnUdofhyAYDuu6mXdvoBE9+CHufq+Xkgq7M=;
 b=LNnFqTI+xaqU9HeuKdX8LIrzDtlMjViHL7Mp3PwBXq5FXyOM9sutWtTGq2Hi/QQMIMzvnrQzNQKdJY+qc5RBDRO11HWvcRMXjzdXx7OCfQSQir8Be6MBkjSUZKibcRN/UoT/Db6Up2lX1Angvp5rs35b4o2sV3QBFBuB/sQURb8nDVDyzPihmnXVuDK8OpM3mXq5LOkMDgwmyNdrMmR9wRqxpEWKDoOfYtBL4aBf+F3gh2/dK0Ro+tAQ/rLogUcoU8mZi95JzQ6AnmkfDK6CIRhZXXqyZD4Ht9lw4XIUZ3W16TkAiZ52LuXKKjy5O+TokpMaP99FdPz8y3X/6x+jiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB5813.apcprd06.prod.outlook.com (2603:1096:101:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 02:12:27 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 02:12:26 +0000
Message-ID: <339b0c1f-ce90-449f-a1fc-2656d5a1115c@vivo.com>
Date: Mon, 17 Mar 2025 10:12:20 +0800
User-Agent: Mozilla Thunderbird
To: hch@lst.de
Cc: akpm@linux-foundation.org, bingbu.cao@linux.intel.com, link@vivo.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com, rppt@kernel.org,
 ryan.roberts@arm.com, urezki@gmail.com, ziy@nvidia.com
References: <20250312061836.GA12841@lst.de>
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
From: Huan Yang <link@vivo.com>
In-Reply-To: <20250312061836.GA12841@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0085.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::7) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: a427b528-6785-40d7-3213-08dd64f92988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkxYTUNCbldiWDJlU2cvN05kbDlLVG9kWVYvdVBBWFh0YnVvTjdqYmE1U00w?=
 =?utf-8?B?cVZGZjFMekR4YnNuK29zUjVJSlVvZ1oyRjVwUnp3Q1pPdnYzUTJnSEJVYXMr?=
 =?utf-8?B?NStrbzh5VU5DWGpRdjJSS2twQXBhcjJCZVQ3dmdkNVNvYlpldTN3K0haa3pn?=
 =?utf-8?B?anRDdmFZR2tJdGJ6RHZ3Q1YySnpVd0tCdG5GaGljWnRRZzJ2MHJCMUc2YUpJ?=
 =?utf-8?B?MzRMc0ZsQUo5cUNxYjkyZHk0WjlnT1c1L0tLMy84Ti9OZSs3WkNmZnBsWWFJ?=
 =?utf-8?B?VlBvNTMxMENPOUNYd3FBUmdPR0p2UUZpZEErMmZUQ29IdUpyWVBmK0dJQUFN?=
 =?utf-8?B?eFhQK25pMWNMZTJQak9YbERrMlZFeWVQZ2E5SXFSWG55cTdDWjJJOXFtY0hY?=
 =?utf-8?B?MGNGNElZRlRNUlZaRSsxUnRySW9yUUtmcUxvcjRzNkZQOXZaOVJJQXR4VjhJ?=
 =?utf-8?B?emMwNjdpaUY3d1pNbE02ZTN6d0NYL2JnWkFEL2pPNVA5OXNMYWZWOWVLYVFL?=
 =?utf-8?B?cEVoalFRU1Z4dWJOUGw2NTFRbDQ2YkxhcHdRc1B4YnROV1BpRXMrUXhRekJ0?=
 =?utf-8?B?OGFraHNTL01aUi8wQmRkY2ZzSklIcEx5T3RNVkhMZXBnM2NlMlpkQXBQS0U2?=
 =?utf-8?B?MjJKMVYxNmhjSzU2TE1VUFR2MGNQUTRxVGIzcXlzSnpvU2hScTM1VzlYWVpi?=
 =?utf-8?B?bmxpWUFMYXFNM0N4eGxWUks2ckJMNFFqUVZFOUNZaUFRVTYzYVBmcFU1TFd5?=
 =?utf-8?B?S1JINHAwcW9ZdXl6THkvZ3VQYVFWNERqSGtSRGdmOEJiL2xMaWZ6SFZ6RVZp?=
 =?utf-8?B?SDlkSnNiZ0JpM0NUbzJHenBMWVZqQUo1NEdoMFl4MHpvTGlQSFo4R2k4SXZN?=
 =?utf-8?B?QlVON2Zuclo0M1pWZDN3TVNMZXM0V2hRb3ZSNXA4dnRhb21wL1JGTzl6Z1Jr?=
 =?utf-8?B?SFl6ZnN1Z1BYRnkxNjhScWJwa1U3czFKTFVua0ZYc3puRnFaV3hZYkFLd3V3?=
 =?utf-8?B?Si85Y1JPY3gyWHpFZWNvN0pjd3ZaT1NFR2YwRG1XZGRLVzdBZDBTa25WMysw?=
 =?utf-8?B?R1lTa0JZcU9RaFFDbnJUa2E3b3MxVmN0eUlDRXNibklYRHpOdUx5OXA4ekVy?=
 =?utf-8?B?TFFESTJQdHU0bHArZ0I2TTFuVm5PRGh3cUVNK1RZRjBmR3ZMUkNkRnVuSWNR?=
 =?utf-8?B?c1Nyb1dYaVdGZVZVYStBRVZXYXVoSjFrQUJNTGpySnB6bWhKdVVBa01jMmtF?=
 =?utf-8?B?UmVZUURrNFY3ZkVDVzhNemgwUUtmRHV2OVB2VVJvZ1A5dG9zZ3FjWFRSa0ZY?=
 =?utf-8?B?LzdIS1ZqRXYwR01wQXI2UkY2d0dkbUlIZDdtSzVEM3pudzVvQXNVQmtuRFEx?=
 =?utf-8?B?d1JDS1NpUjlPSGV1OCtubXJDQng1ckZBVW50T1p5SlVMamZJemhmWndyVVAr?=
 =?utf-8?B?YWtYN09zRkhqVnVPSUoya2g1WWlWZ2pmQ1l6Tm9SUmFYODRyV3BqRDFhNko5?=
 =?utf-8?B?Z3Q2WDByaFVZTkVUY1VZN2tUM0hDamdNRm9XZ3hSUEJjdTRhYTRlMHE1RXBT?=
 =?utf-8?B?ODZHaW9YcVZ1OW8wUi9qdUxlVWVXVlY4SnFHMFQ3VEdoY3BPd2hnYlF3TkNG?=
 =?utf-8?B?MmVHeDZNMHFqWm5WNlRRM1VOeTduZzdqQW1nR0VXQ2xMRVRlK1h1TFBSSExq?=
 =?utf-8?B?NHU1bnJSZG5XU2IxejRrMW80bmJEM1poZ2g3K1hET2oxeW92T2cwR0dkVENU?=
 =?utf-8?B?SHV0dmJNUXhxTTBOSzRnOElxQmViL3A2WGt4dnBwV2dtQ29GQjd5MUU4YUJ2?=
 =?utf-8?B?Wmt0V1k5RHg1UzArczBqNW8yYnlpSCthUkJrbmFpQ2xzbVZqemhJTWVGdWhO?=
 =?utf-8?B?OVB6MmFxbkkxT3RFRXV4UVJucnI0dmVpeDlrc1V0cDRBSHVaalUwb1ZUSXJO?=
 =?utf-8?Q?rOWNuS5SAcdBxks/C/iVk9/2zgZoJv+y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEc3RjRUa0lCV3hONEc2WjZxdDdJM1ZYemVHRFVJcHFWdlhZN3doOXA0UjY1?=
 =?utf-8?B?VnA5bUlRYjd4NnRkbVUrcXF3RFFYY1RxWndEcEpXV1pnVTVWeVJuRmJvcWx0?=
 =?utf-8?B?SDZYSkVkdzNmN0tLM0VNY09lSmlqSWpGUWI3RWE0RjRiZVhsOFRXQnRnc0c1?=
 =?utf-8?B?UlRkcVI5NFowUXZVeFNhTHdRR1VCLzhDMVZWUFBUU2JqVVFsS2RCYUJwUlFN?=
 =?utf-8?B?a2NTait4SXd2VnIvOHBhcTJIc1pPaUZXdjNVNkd6RnVaVWlDTjRkd0ppbUxn?=
 =?utf-8?B?K1RIVHg4eUppbFlvZVRMdDU3T01jakxRZlBkYzRwZTNDNkJnYklRVjhoaFo4?=
 =?utf-8?B?V2lRNWczd25zV0JKNmZLNU05NzlMMUsxbEduTnZwSHZQYUNuNllLOUZsaXFz?=
 =?utf-8?B?UEpJRXJMa2JlNUQ3cDlhNkFieGJ2N1dTZFBOODUvZ05zUlpKWlMvVEN6ZzQz?=
 =?utf-8?B?cGlubFNpemNqd09aNTdDWUJoVUNrTzNCY3JKTStiUHdnK1VJeVJTNURTQ0pO?=
 =?utf-8?B?dlRVVlIwNmtWVnM1czF2TjJjdmhyMDduNlhtaXJrUFNqMTB6RUZRMFFTRk81?=
 =?utf-8?B?NnlDWHpObnFyZTdmSmk0OXVxa2paSngxREdBQTQ1YXhJejlZTFhvbDdWcERr?=
 =?utf-8?B?aTNYSEp1UHowaFdoaWZtMngzNFN4d1pZRXNBbjZwbTFqdmZwazRxQ2Yrb3NV?=
 =?utf-8?B?R20xc2I4cTVjelBDTFpuTVNtSk4xVWtNaGlmTGhPNXJtWDRtbGRCdnd0bndU?=
 =?utf-8?B?ZGs0eTEvbjdFdGdIdG1kVGhrZEU4QWs2TDlzWFNvYkQ1L3VOTHFEbzVRcFNm?=
 =?utf-8?B?c01UdndWcHNwaWtTcm5oZDlCdlJQblBwNHhHVzdHdS84d1d5RUhJUUNGV21K?=
 =?utf-8?B?cXBHdGkrUlhXaFhjOFJHVVg3RUc5cUJUeXFDSXFQZWFxNDh4RzJxTjRCbEtw?=
 =?utf-8?B?SnA1cGF1eTRLU0dvVHV5WTNEVDMxWk1Qc2t6QW1yMVQzZTNIQUliNW9UTEd6?=
 =?utf-8?B?WFFETEczNUpwYzBqcVpEZnRHWlhQRFFNcUMzblR2dG4wV29ueGpIWW9JeEJy?=
 =?utf-8?B?b3d1NkxZNTJUcUF3dkJVRy9URGhrQng3aFdNbnZmM1I1N1pDOEo5a29RbnNq?=
 =?utf-8?B?MHpZRGlkRmNuYVZ5c3pyZ0NoQXpLVWpCZDA3ZkZkbnN4MHdmYkZpTHE4RGcw?=
 =?utf-8?B?L1VyYTcxdGwyVFQ0TExzekxEZ25FOUl2MFYwd1BLVThXTFFMaHhycWlQdko1?=
 =?utf-8?B?Vk85TExSalVqRGxrYm9pemdTMGsweHZNczRDVFdZUnh0NlgvYXFvTlJtV3BJ?=
 =?utf-8?B?TkdaNVZUMEI4Mk5xamhEZUd5Q00zcmJ1ekZsWXBNOEdPR21oam1iak5XRXdz?=
 =?utf-8?B?cWhWVjh4TVpuNlpSS09ScnRwR2UyU3BPSnF3dkFtOXljNWRweHNpdGZ1RUJR?=
 =?utf-8?B?bWdTMXUvbTZPaUJaMHBwSTFjRHp2b3BwQzRtK0FpeHlqUThzZ2hDR2FqN01Y?=
 =?utf-8?B?NmErb0tTdFdraUl4ZitDUDUxMSsrQ25yV1RZK0QvNHA4cmgvWHhyR2hFK1cx?=
 =?utf-8?B?dGZZNmpQL1FXSDRjaWMvQit3QXFJeWZ5RjF6eHRPU1l0N1JNWjBmakxCYnVC?=
 =?utf-8?B?QXZDenltOC9OTlgvV1dmTVlROG16bGp3SWtEb3ZvbGNyWXFCVnB1MnRQK0JI?=
 =?utf-8?B?TVllNlFJRExIcnp2dEkyc3RMNkcwOHRLQWphUUxOdjA3U2NLTVU2YjE0TmZh?=
 =?utf-8?B?NTBhc3NjM3M2dnM5UE15bDVycU5pSGpSVm9MNGxJdm1PcmVTRnZBbmZzUEVj?=
 =?utf-8?B?NkVmY01BNG1hTDJhelQyTVFYUWRickdPenhNVTF1MXlYR2hlT3JkU2t4WUVE?=
 =?utf-8?B?bEx6eUxmd1IxR0FkSEpmdzBXNVM5L0VkM0k4NjlFdFdsdEhiQ0FnTSttdG1q?=
 =?utf-8?B?VXNHQ1ZTZ2N0WlIzVWVKV0FqcWh6N0VDcDFLSDBTT2R0QVArS0hsVUlyZmFi?=
 =?utf-8?B?S0I3aHZYWVBhYm1maUtzUEVJTlBMcDdnRjEyblNCR0N5WWNHUmY3emRQUVJZ?=
 =?utf-8?B?YmVQTC8wUytLZ01UaStRWWZuYXVoeWpqY3VOQXIzRzhqeEtxb05GYk5YT0VT?=
 =?utf-8?Q?v+5aGCmCMq9aBCzZCz/8aBI//?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a427b528-6785-40d7-3213-08dd64f92988
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 02:12:26.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elJ71WWXK1/r0Gb/A9GDnlfxM55sYv6c4urFfE34LXjqgjBpIIhvsCjcfqVe6yTLO+SMZ9z0e58dKjtgJ0fDnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5813

HI Christoph,

Thanks for your reply, and I'm sorry for my late reply. Your response
didn't appear in my email client; I only saw it on the website.:(

>> On Wed, Mar 12, 2025 at 02:15:12PM +0800, Huan Yang wrote:
>> When invoke vmap_pfns, it call vmap_pfn_apply to set pfn into pte. >> It check pfn is valid, if true then warn and return. >> >> This is 
a mischeck, actually we need set a valid pfn into pte, not an >> invalid 
pfn. >
> As just discussed this is wrong.  vmap_pfn is for mapping non-page
Thank you for your explanation. I now understand that the design of vmap_pfn
is indeed intentional. It's design to do this.
> PFNs and the check is what enforces that.  What is the point of having
> that detailed discussion if you just send the broken patch anyway with
> a commit log not even acknowledging the facts?
Sorry for that.

We now have a new use case where, in udmabuf, memory is passed via memfd and can
be either shmem or hugetlb.
When the memory is hugetlb and HVO is enabled, the tail page's struct is no longer
reliable because it has been freed. Can't use vmap.
Therefore, when making modifications, I recorded the pfn of the folio base pfn + offset and called vmap_pfns.
And, these pfns are valid. So rejected by vmap_pfns.

Can we just remove pfn_valid check in vmap_pfns, so make it suit for both of they?
If you agree, I wanna send a new patch.

Thank you,
Huan Yang


