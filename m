Return-Path: <linux-kernel+bounces-335247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FA697E30E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 21:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23801C20DB9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB34482D8;
	Sun, 22 Sep 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="VJApq0HD"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2F7E1;
	Sun, 22 Sep 2024 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727034594; cv=fail; b=KltY2fqsKf+39P4MlDAVGi3+j4vo4HMB/lFwvZz27e1EpATdisDTltbq+gB6aGqAgrMvDSBkIt2MoLUbwXWiOvHz4fdWUBXIAyErMueZ9c48T4zjW454LuC/wTOML0Os6ZuRZ0/QbfmwhM8YgxiGBYgQhDKAJMndqoU2PGdYqHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727034594; c=relaxed/simple;
	bh=LxNDRH89YpE/QNB+iNpWMrFUwOvHDKwgvS0MjtypFC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kZouiCIJNjGy/wbGtPqYRBZNeksp2E/LBBsI3Lewew+fbJHCwTw2n8JExuF9L1tatLSIdJ5mgmojo8GDeX9zET3cr6EeGJHWIynqv6KC0B/tBAyG4z3CDVsOaqRPvg4dEyj5oLhPIRFBRPv/r0BXKB5mhmtbZiqDr4QhLZgP+xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=VJApq0HD; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MJgtiQ025962;
	Sun, 22 Sep 2024 12:49:02 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41sugnvpp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Sep 2024 12:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJYXqpUWwsSFU53HcRcuFAOePveRTiqKoRsbOaA+kC8JfEJvH3kGrEqPaAh9zCWrJjpeODgkHY0VVsyC+PgeflaXvtLTRSWzc29jW47b2mTh3ZckNDYInI7RlqPlxdeQkHZllZT7e4yIJ/F0WdR8LoGY+rLjZtn67/XXkqk7HkFAS0VMiI2QJzk4pwRu6ekoQLgKdte2//cwT/2M+r2g6etYL1ZurBuy9HX1cZ/HEkVoCKhif3qcn8qoWTxRG9KfXHZqatEQu6AiCPOXbdt+XbM39wWeDM+tEMStwQq+OJCvwQsBBciC0sunsbLxeMa+wZ2H5VPUcRx5rZDJ/H1TrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyBOR9wQ6c1V7qNvNoYePbgckfKDRGcmK9CaFdqXAH0=;
 b=tBOQqkxqbqvU7KZcJ7XTwXgEYkPmq6zyRqrbkc+gmFBNj3j8+TSYl0QE1C55jLhPAbIc57WNBDwP9HzAyvKHvqAqu8LPU9ROQV8dRoP0lmBZFxIFe2pCbFQk4b/X1ehAhaWQ8kn0T2dsSZK8KFAv5L8Uoa6uL8WTPkuFgK3UfHIi7iLopcMjXE39WjKY+/RsshwCFa9zUaTuz1rey0lMFbuSzSdb0kbWPx19ZOAafHR09Ll1TT70CUAnDcSS1pr241K1lgbaSvyo4idMLiRl9Aa7HfxvI2W1D6rs2f3zchi4fF0Z7g2Whq0IJCOqOR2mhaXRd51tTRo+sQh6e3qEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyBOR9wQ6c1V7qNvNoYePbgckfKDRGcmK9CaFdqXAH0=;
 b=VJApq0HD1iNiC9hD+05TLuvKu+BDf9A7Z3oNzTuQMvmHH/hJOdVU0/aveDPTzNisPeLZyRZY8/UrAl1nv3pJCNlF1kMZ/oPuCCTrddq7rIbXwCOB4wDLIJZ29ATL7hXrPg91xTZ6MLe6FM0sj6nzMHXpyYwlCqm+qT0jVzlgDFI=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by SA1PR18MB4712.namprd18.prod.outlook.com (2603:10b6:806:1db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 19:48:57 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7982.022; Sun, 22 Sep 2024
 19:48:57 +0000
Message-ID: <9245120b-9901-45c3-9a6e-600653f94bba@marvell.com>
Date: Mon, 23 Sep 2024 01:19:03 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 2/2] mtd: rawnand: nuvoton: add new driver for the Nuvoton
 MA35 SoC
To: Hui-Ping Chen <hpchen0nvt@gmail.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, esben@geanix.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240920063749.475604-1-hpchen0nvt@gmail.com>
 <20240920063749.475604-3-hpchen0nvt@gmail.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240920063749.475604-3-hpchen0nvt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::11) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|SA1PR18MB4712:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb3de9d-5edc-4419-e7a5-08dcdb3f98db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nmx2czZEbjFXUmxsb012T25VZTExY3pMWi8vZXYrVXFWZHhCK0h0b2dvUVBa?=
 =?utf-8?B?bEM0QXVENWFHc3JTL3I0a0hMWGJiWU9PTG1yQ3p3M0JVajhhUGhKSDlaSW9w?=
 =?utf-8?B?ejFQNUVtd3plcDBjRDh5WnJkZHBmK0c0T3RKcDVIM1Z3SHpJU2dHT0sxU3Vr?=
 =?utf-8?B?eVgzZy9YUnJsdkZqWEJkZjN5bWkwMjBqUHdhMFl1MXlDKzZOQ3E1T2crQmR6?=
 =?utf-8?B?aEZlaGorMHBYZDQraHFQMURBTS90TXlvZ3Fwei9iK2V4Q1JlSGpFekl2M0lq?=
 =?utf-8?B?TllUb2pWcEdBMVEwRGtjYnlaU1NxaWFwaU54L0plbGUyOEhLUjhhVys3S084?=
 =?utf-8?B?Q1FhM2o0RmVKYWZXVHdZKzNySnBRa0kzOG5hbDZoZkVnRWRna3Y5bThERFh0?=
 =?utf-8?B?cWpBMFphL1NYNEZ6VXhEWFBaTSsydG1rZDF6Wlk2NHMxMlIxQWoyR2xYZC9M?=
 =?utf-8?B?SWNoL1NZakVqaEVkd2hQSVZiSGpkY081VnlLVHhNWS9wbXU4cUdmT0U5bVRW?=
 =?utf-8?B?SXZybEQwZnBTNlBpSlZiZE5yQ2psS3JSSEJtWE9MUG9INzJTOEYxVW92L2ln?=
 =?utf-8?B?Sk9mMmU4MngzcUNCK0x3a2JtSVNvUW4xUVZEemo3VWw0M1J5UzBqR2N0M1kx?=
 =?utf-8?B?a2dTNytJdmErd2g1aUhmN1RwSXhrb2NJMzJsbUwrNElOUTdyQW9SU2s3QXRw?=
 =?utf-8?B?RHFuS0ZBZkR5WE1Rdmw0bVUzbVIrYUxaelVqZjRrc1ZXSVpocFBCZnc4Nm5J?=
 =?utf-8?B?NlFTRE96YlNpZTVYOVErN0NWV01xQWhwM3BGbjZHNjhNRTcyci91dXpnMmVl?=
 =?utf-8?B?Z1lVZzVwTG5wS1A2cldHcUExcGVMaEc1QWI2Y09XQmk5NEloaktVRmpReEZD?=
 =?utf-8?B?TUdmb0ZHa3JDQ2lOTVc1RjdGeWExMUZzSjhJSnUzcjE1KzRlRnpScmg4L1RW?=
 =?utf-8?B?MnlwTWsvYlE3SXZJd0s2MjZ1TzFMNHNIM3NEQXJLa0FKR1RMZUpuUERORnBO?=
 =?utf-8?B?dFhsTytXdFJnYnZURzVLY1RGSEkwYitacitkMkYycG1lZWc4QTg3UENsWFFM?=
 =?utf-8?B?UDNhMTJ5N1doUG5TeFlzcDU5ZnpabXdTQjVhZmU1emZadHBwbWpTRHlNQkJt?=
 =?utf-8?B?WXlwVVBSNjd6WGp5dFZJcHlVbEFRMEpVZ2c5WGJlaEpWODAvNmloenhuTzhU?=
 =?utf-8?B?R3lpU1N4dm8wQnVtYnpQVjZvQWFMcjlJcVNuUk83WnU3NVluM3Erc0g2U0Nk?=
 =?utf-8?B?V2lTMXNTeG94NDgwamRDRHRVaXdDUW54L2RvMkRCZFVLYWlpMkJOUmZXWFk5?=
 =?utf-8?B?dlpuczNnK1BJSkM3R09FRXZCUE9lQ0hlZmJJOXFMTERnTUxZb1daZkFUN2VB?=
 =?utf-8?B?V2xaREhMUnA1Qk5JZUVwTGd3VzNCc0dPWXFRVnFYQjViSjRGSVdXeTFyVnU5?=
 =?utf-8?B?dU0rbm5MRjJMazFNQlBvOE0zVk1wOVYvNGs0WlFxdndmZXh2a2tsb3VUSFBq?=
 =?utf-8?B?TndhYkxYMjQ0c0RIZGVlNlRVbzBvd1NLMmxYTUNNa1pVRk5peG9zbXNEaFBT?=
 =?utf-8?B?Q09DQUR4TVNPT1FFZ3laSmRnRE50aG5CYldPZnUrQzFPckNGSzBnY0J2ZUR1?=
 =?utf-8?B?T3dIS1NJMXZoaDFxdUg1MnpkeXdRaWREZjBGSUZuNHJYRlhDRVhFSjBJU3ht?=
 =?utf-8?B?cmFmaThXTmtKSlNzVFB4RWZXUFFnRDNjNVpveWNDOVJIR1lUeVk4eWdSV09S?=
 =?utf-8?B?OTNLNjdoekxDcUcxdk43WDVkS3VadjgvdnRnZkRSSG9TR0JwVmtPcThCSWNn?=
 =?utf-8?B?RnYwT0Zzdlg5ZW10aVdOZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXVVUFJJVnR5eFdIMC9VN2o4MzJnR04wK01mZk5xb3Ezb0oyOU9ITmtPYVU0?=
 =?utf-8?B?M2JvNzBmTkgvWFE4dGFONVhkTW90Sit1TFRCWG1CTmt2MURzMFVYdzNTQ0NP?=
 =?utf-8?B?TVROL0tDRjVxNzJHZ1JYSHhuUngyZEdjd3E5RVBYSVZYNXdPbm81TWQ3aEkz?=
 =?utf-8?B?bGIzNWg0Yk1uaVFqbmR2Sm9mb1prMk9lSWJZalBGRWxNRDhRdW1TMGNHeWY4?=
 =?utf-8?B?Q0k4TnBLVzNlVCtNam81WnBFRWs1K0ZETEllbmVqRTNmbGh0R3lLTWJlUlJS?=
 =?utf-8?B?LzZkemhVbzJJRWdoMHJiVk9GSWlQMUxUditvcnlYaTZqaEFuL0w4dk5oem1h?=
 =?utf-8?B?OVZMcUNzUzdCa01rcTQvcFNWcEYxY3FycVVuemdEMWtFZUZqZWRhQ1pWb1g0?=
 =?utf-8?B?WDAvNkhFaVRLWDMxR20wQUxoVUR6OTNRaXQ0RkpvWVNvcGcvUDhGcERmeFJn?=
 =?utf-8?B?OEwvdk96VXU2azZzUElackJvbkpPQ0lnRW02Z2YyU05CZ21kSUhCem1BVW9n?=
 =?utf-8?B?MUgrT1NhdEY5QzlqVTBwMEFNN1EzeC9Qc3ZkditORjBVOXJOSVpkeGlVNjdl?=
 =?utf-8?B?TEpuRFlHam5FMVdTN2J2blFhU3FWdVU0TXczZVE1NjBPVmNqbjZxYTBuTmhX?=
 =?utf-8?B?S05MVTlzYU9KakE4dmJBYUxSZnlibjBVeXkyMmhRSjBUVGRCSGVNUFozTVlD?=
 =?utf-8?B?U1IvZUwveDU3YW5OYktWbDdMdksxaEVGNGZhNFl1OEpaUVpud3d2SzZ2K3BQ?=
 =?utf-8?B?cFhZZ1pjV2E5V0QxckVUMm1TdmFCb3B2TjdIQ0tkTGNOOWU4MEFRSVpTSEND?=
 =?utf-8?B?NjUzZmU4QzdTVVdQZEhSUWFJckVSa0hpRmx6WW5CdmpWZ0hQWS80NlRyZ3Nv?=
 =?utf-8?B?b3U1R29KdklXKytraHQwaFpmZzBSY3R0OG5hUmNRQWpBdFdMTWpHRlNiSnU0?=
 =?utf-8?B?cFgxNUx0c0x6ZTVvWHZ2MDdpZTlNL1BxbkxpY0JRT2hvSjh5NFZXaVhrYXkz?=
 =?utf-8?B?Myt2NWs5R2UxTFcxQkVtdzNZSTJLN0R4ZXd0YUJ5RytvMThvaWYvb1B3OGc5?=
 =?utf-8?B?ZnI1WUw3QUgzVUNWcHpJd1JYTlVIK2NIL3ExVXliM3RyR094K3NPSUdieXVq?=
 =?utf-8?B?STBCL3lkMlJiU0NjREl6NkJCWlVZTUhmbXNQMlJCMlVTRTQ2cytGeGZqbHRy?=
 =?utf-8?B?WUhuS3QxMzFMeWdpNHR1ZWNqYjJ4K084WTQ0SUc5T2xVS2d1VG54K0wwaEhW?=
 =?utf-8?B?bGFLditwL2Z3N3FVcHRQQnd6Y0ppdjVvSngrUkwxVEFpVVNUNzZubXFrRVky?=
 =?utf-8?B?MWZpU3VNY291ZUprMm1hclNIY0ZRR2RnNDNWZVVJSE45LzZFNnNOUWtZQmR1?=
 =?utf-8?B?eHZnWXFlNHJ3UjZHTEFCNFErMERWZVp3V2xTTzlVYk1JQ0RERFkyRUd5cXlw?=
 =?utf-8?B?RjRjem9GeWtKNndubG9oNktBODc4THh0MnJRMG9oc3NUQkxlbkl5VjkzNmk1?=
 =?utf-8?B?R0VmUTFTUXNJZGZJQXc3WXlOQ2VIWG9FZE5UR3FIVW43bkwyaGUxcGIwOG1w?=
 =?utf-8?B?RE0rL05TVWloNEVCRWR0ZHNDUEw2TFZZQnhjSnhWSHN0REZ3RUhFaEx5enRz?=
 =?utf-8?B?OWEyV1dhTjRCMHBSRXd4bzFjTkFZZUZ6OFdodEFSTnVqaFU2SFhQQXYrL05I?=
 =?utf-8?B?aEI2RXpEV1ViZHo2YWE4TzNUd2lPb08zSFVnQml2bmp1OWtFUUEybThCMzdo?=
 =?utf-8?B?blBQN3lZeFBuOW9sOS9lVkRtK3ZQaDk0eVQ0RlE0MjMrYW83dkV4a2JqSVJI?=
 =?utf-8?B?YmwrbHlVU1c0bG5HUGdvTWpBTnVoOWZza3phQUlId1FhNlJRcE5FdzJ6aVRa?=
 =?utf-8?B?OVA0TUtTNWFtZGFSRWpJNktIaFFqSCtIbkZZWjBCNHNaV3p5bFJtb3RKbHlW?=
 =?utf-8?B?TDUzZ0d1K0k4aWJvdDRTQVhpTWJtNnQ1citsUENZZXN2THduVjNpWmZ1MmtV?=
 =?utf-8?B?OFdJMGY5RU9KRVlEOFVGN2oxS1lINWhrb0VKRkRxaWFOMjFvbDhnODIxblUz?=
 =?utf-8?B?dmNBWmhISUdTUXVMclV6ejJuVjJyL2NkL0ZLUVMybGFSaGV5anNmaXVYY01j?=
 =?utf-8?Q?5dObnYU7prS3c0eFnI0S0Jws2?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb3de9d-5edc-4419-e7a5-08dcdb3f98db
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 19:48:57.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8w+XfT/ckn537DfOf/ohdvn9ETlYrTUvNr1IM91wsEL/MCmdV5ArM/RLQRZDqoGhlduOrE7RLAhsYj83dDLwnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4712
X-Proofpoint-ORIG-GUID: hsp4Kc7oJCVkvXK80Pz2u-WI6OuYtzCO
X-Proofpoint-GUID: hsp4Kc7oJCVkvXK80Pz2u-WI6OuYtzCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

> 
> Nuvoton MA35 SoCs NAND Flash Interface Controller
> supports 2kiB, 4kiB and 8kiB page size, and up to
> 8-bit, 12-bit, and 24-bit hardware ECC calculation
> circuit to protect data.
> 
> Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
> ---
>    drivers/mtd/nand/raw/Kconfig               |   8 +
>    drivers/mtd/nand/raw/Makefile              |   1 +
>    drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c | 886 +++++++++++++++++++++
>    3 files changed, 895 insertions(+)
>    create mode 100644 drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 614257308516..a95d91e61c42 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -448,6 +448,14 @@ config MTD_NAND_RENESAS
>    	  Enables support for the NAND controller found on Renesas R-Car
>    	  Gen3 and RZ/N1 SoC families.
>    
> +config MTD_NAND_NUVOTON_MA35
> +	tristate "Nuvoton MA35 SoC NAND controller"
> +	depends on ARCH_MA35 || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Enables support for the NAND controller found on
> +	  the Nuvoton MA35 series SoCs.
> +
>    comment "Misc"
>    
>    config MTD_SM_COMMON
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index 25120a4afada..b8e1b3af6942 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_MTD_NAND_INTEL_LGM)	+= intel-nand-controller.o
>    obj-$(CONFIG_MTD_NAND_ROCKCHIP)		+= rockchip-nand-controller.o
>    obj-$(CONFIG_MTD_NAND_PL35X)		+= pl35x-nand-controller.o
>    obj-$(CONFIG_MTD_NAND_RENESAS)		+= renesas-nand-controller.o
> +obj-$(CONFIG_MTD_NAND_NUVOTON_MA35)	+= nuvoton_ma35d1_nand.o
>    
>    nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_ids.o
>    nand-objs += nand_onfi.o
> diff --git a/drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c b/drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c
> new file mode 100644
> index 000000000000..5b53b7f0b9cb
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c
> @@ -0,0 +1,886 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Nuvoton Technology Corp.
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +
nit: Unnecessary new line.
> +/* NFI Registers */
> +#define MA35_NFI_REG_DMACTL		0x400
> +#define   DMA_EN				BIT(0)
> +#define   DMA_RST				BIT(1)
> +#define   DMA_BUSY				BIT(9)
> +
> +#define MA35_NFI_REG_DMASA		0x408
> +#define MA35_NFI_REG_GCTL		0x800
> +#define   NAND_EN				BIT(3)
> +
> +#define MA35_NFI_REG_NANDCTL		0x8A0
> +#define   SWRST				BIT(0)
> +#define   DMA_R_EN				BIT(1)
> +#define   DMA_W_EN				BIT(2)
> +#define   ECC_CHK				BIT(7)
> +#define   PROT3BEN				BIT(8)
> +#define   PSIZE_2K				BIT(16)
> +#define   PSIZE_4K				BIT(17)
> +#define   PSIZE_8K				GENMASK(17, 16)
> +#define   PSIZE_MASK				GENMASK(17, 16)
> +#define   BCH_T24				BIT(18)
> +#define   BCH_T8				BIT(20)
> +#define   BCH_T12				BIT(21)
> +#define   BCH_NONE				(0x0)
> +#define   BCH_MASK				GENMASK(22, 18)
> +#define   ECC_EN				BIT(23)
> +#define   DISABLE_CS0				BIT(25)
> +
> +#define MA35_NFI_REG_NANDINTEN	0x8A8
> +#define MA35_NFI_REG_NANDINTSTS	0x8AC
> +#define   INT_DMA				BIT(0)
> +#define   INT_ECC				BIT(2)
> +#define   INT_RB0				BIT(10)
> +#define   INT_RB0_STS				BIT(18)
> +
> +#define MA35_NFI_REG_NANDCMD		0x8B0
> +#define MA35_NFI_REG_NANDADDR		0x8B4
> +#define   ENDADDR				BIT(31)
> +
> +#define MA35_NFI_REG_NANDDATA		0x8B8
> +#define MA35_NFI_REG_NANDRACTL	0x8BC
> +#define MA35_NFI_REG_NANDECTL		0x8C0
> +#define   ENABLE_WP				0x0
> +#define   DISABLE_WP				BIT(0)
> +
> +#define MA35_NFI_REG_NANDECCES0	0x8D0
> +#define   ECC_STATUS_MASK			GENMASK(1, 0)
> +#define   ECC_ERR_CNT_MASK			GENMASK(4, 0)
> +
> +#define MA35_NFI_REG_NANDECCEA0	0x900
> +#define MA35_NFI_REG_NANDECCED0	0x960
> +#define MA35_NFI_REG_NANDRA0		0xA00
> +
> +
nit: Unnecessary new line.
> +/* Define for the BCH hardware ECC engine */
> +/* define the total padding bytes for 512/1024 data segment */
> +#define MA35_BCH_PADDING_512	32
> +#define MA35_BCH_PADDING_1024	64
> +/* define the BCH parity code length for 512 bytes data pattern */
> +#define MA35_PARITY_BCH8	15
> +#define MA35_PARITY_BCH12	23
> +/* define the BCH parity code length for 1024 bytes data pattern */
> +#define MA35_PARITY_BCH24	45
> +
> +
nit: Unnecessary new line.
> +struct ma35_nand_info {
> +	struct nand_controller controller;
> +	struct nand_chip chip;
> +	struct device *dev;
> +	void __iomem *regs;
> +	int irq;
> +	struct clk *clk;
> +	struct completion complete;
> +
> +	u32 bch;
> +	u32 bitflips;
> +	u8 *ecc_buf;
> +};
> +
> +static int ma35_ooblayout_ecc(struct mtd_info *mtd, int section,
> +			      struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->length = chip->ecc.total;
> +	oobregion->offset = mtd->oobsize - oobregion->length;
> +
> +	return 0;
> +}
> +
> +static int ma35_ooblayout_free(struct mtd_info *mtd, int section,
> +			       struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->length = mtd->oobsize - chip->ecc.total - 2;
> +	oobregion->offset = 2;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops ma35_ooblayout_ops = {
> +	.free = ma35_ooblayout_free,
> +	.ecc = ma35_ooblayout_ecc,
> +};
> +
> +static inline void ma35_clear_spare(struct nand_chip *chip, int size)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	int i;
> +
> +	for (i = 0; i < size/4; i++)
> +		writel(0xff, nand->regs + MA35_NFI_REG_NANDRA0);
> +}
> +
> +static inline void read_remaining_bytes(struct ma35_nand_info *nand, u32 *buf,
> +						u32 offset, int size)
> +{
> +	u32 value = readl(nand->regs + MA35_NFI_REG_NANDRA0 + offset);
> +	u8 *ptr = (u8 *)buf;
> +	int i;
> +
> +	for (i = 0; i < size; i++)
> +		ptr[i] = (value >> (i * 8)) & 0xff;
> +}
> +
> +
> +static inline void ma35_read_spare(struct nand_chip *chip, int size, u32 *buf, u32 offset)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	int i, j;
> +
> +	if ((offset % 4) == 0) {
> +		for (i = 0, j = 0; i < size / 4; i++, j += 4)
> +			*buf++ = readl(nand->regs + MA35_NFI_REG_NANDRA0 + offset + j);
> +
> +		read_remaining_bytes(nand, buf, offset + j, size % 4);
> +	} else {
> +		read_remaining_bytes(nand, buf, offset, 4 - (offset % 4));
> +		offset += 4;
> +		size -= (4 - (offset % 4));
> +
> +		for (i = 0, j = 0; i < size / 4; i++, j += 4)
> +			*buf++ = readl(nand->regs + MA35_NFI_REG_NANDRA0 + offset + j);
> +
> +		read_remaining_bytes(nand, buf, offset + j, size % 4);
> +	}
> +}
> +
> +static inline void ma35_write_spare(struct nand_chip *chip, int size, u32 *buf)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	u32 value;
> +	int i, j;
> +	u8 *ptr;
> +
> +	for (i = 0, j = 0; i < size / 4; i++, j += 4)
> +		writel(*buf++, nand->regs + MA35_NFI_REG_NANDRA0 + j);
> +
> +	ptr = (u8 *)buf;
> +	switch (size % 4) {
> +	case 1:
> +		writel(*ptr, nand->regs + MA35_NFI_REG_NANDRA0 + j);
> +		break;
> +	case 2:
> +		value = *ptr | (*(ptr+1) << 8);
> +		writel(value, nand->regs + MA35_NFI_REG_NANDRA0 + j);
> +		break;
> +	case 3:
> +		value = *ptr | (*(ptr+1) << 8) | (*(ptr+2) << 16);
> +		writel(value, nand->regs + MA35_NFI_REG_NANDRA0 + j);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static inline void ma35_nand_target_enable(struct ma35_nand_info *nand)
> +{
> +	writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~DISABLE_CS0),
> +		nand->regs+MA35_NFI_REG_NANDCTL);
> +}
> +
> +static inline void ma35_nand_target_disable(struct ma35_nand_info *nand)
> +{
> +	writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | DISABLE_CS0,
> +		nand->regs + MA35_NFI_REG_NANDCTL);
> +}
> +
> +
> +static void ma35_nand_hwecc_init(struct ma35_nand_info *nand)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(&nand->chip);
> +	u32 reg;
> +
> +	/* resets the internal state machine and counters */
> +	reg = readl(nand->regs + MA35_NFI_REG_NANDCTL);
> +	reg |= SWRST;
> +	writel(reg, nand->regs + MA35_NFI_REG_NANDCTL);
> +	while (readl(nand->regs + MA35_NFI_REG_NANDCTL) & SWRST)
> +		;
Shouldn't there be a timeout?
> +
> +	/* Redundant area size */
> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
> +
> +	/* Protect redundant 3 bytes */
> +	reg = readl(nand->regs + MA35_NFI_REG_NANDCTL);
> +	reg |= (PROT3BEN | ECC_CHK);
> +	writel(reg, nand->regs + MA35_NFI_REG_NANDCTL);
> +
> +	if (nand->bch == BCH_NONE) {
> +		/* Disable H/W ECC, ECC parity check enable bit during read page */
> +		writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~ECC_EN),
> +			nand->regs + MA35_NFI_REG_NANDCTL);
> +	} else {
> +		/* Set BCH algorithm */
> +		writel((readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~BCH_MASK)) |
> +			nand->bch, nand->regs + MA35_NFI_REG_NANDCTL);
> +
> +		/* Enable H/W ECC, ECC parity check enable bit during read page */
> +		writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | ECC_EN,
> +			nand->regs + MA35_NFI_REG_NANDCTL);
> +	}
> +}
> +
> +
nit: Unnecessary new line.
> +/* Correct data by BCH alrogithm */
> +static void ma35_nfi_correct(struct ma35_nand_info *nand, u8 index,
> +				 u8 err_cnt, u8 *addr)
> +{
> +	u32 temp_data[24], temp_addr[24];
> +	u32 padding_len, parity_len;
> +	u32 value, offset, remain;
> +	u32 err_data[6];
> +	u8  i, j;
> +
> +	/* configurations */
> +	switch (nand->bch) {
> +	case BCH_T24:
> +		parity_len = MA35_PARITY_BCH24;
> +		padding_len = MA35_BCH_PADDING_1024;
> +		break;
> +	case BCH_T12:
> +		parity_len = MA35_PARITY_BCH12;
> +		padding_len = MA35_BCH_PADDING_512;
> +		break;
> +	case BCH_T8:
> +		parity_len = MA35_PARITY_BCH8;
> +		padding_len = MA35_BCH_PADDING_512;
> +		break;
> +	default:
> +		dev_warn(nand->dev, "NAND ERROR: invalid SMCR_BCH_TSEL = 0x%08X\n",
> +			(u32)(readl(nand->regs + MA35_NFI_REG_NANDCTL) & BCH_MASK));
> +		return;
> +	}
> +
> +	/* got valid BCH_ECC_DATAx and parse them to temp_data[]
> +	 * got the valid register number of BCH_ECC_DATAx since
> +	 * one register include 4 error bytes
> +	 */
> +	j = (err_cnt + 3) / 4;
> +	j = (j > 6) ? 6 : j;
> +	for (i = 0; i < j; i++)
> +		err_data[i] = readl(nand->regs + MA35_NFI_REG_NANDECCED0 + i * 4);
> +
> +	for (i = 0; i < j; i++) {
> +		temp_data[i*4+0] = err_data[i] & 0xff;
> +		temp_data[i*4+1] = (err_data[i] >> 8) & 0xff;
> +		temp_data[i*4+2] = (err_data[i] >> 16) & 0xff;
> +		temp_data[i*4+3] = (err_data[i] >> 24) & 0xff;
> +	}
> +
> +	/* got valid REG_BCH_ECC_ADDRx and parse them to temp_addr[]
> +	 * got the valid register number of REG_BCH_ECC_ADDRx since
> +	 * one register include 2 error addresses
> +	 */
> +	j = (err_cnt + 1) / 2;
> +	j = (j > 12) ? 12 : j;
> +	for (i = 0; i < j; i++) {
> +		temp_addr[i*2+0] = readl(nand->regs + MA35_NFI_REG_NANDECCEA0 + i * 4)
> +					& 0x07ff;
> +		temp_addr[i*2+1] = (readl(nand->regs + MA35_NFI_REG_NANDECCEA0 + i * 4)
> +					>> 16) & 0x07ff;
> +	}
> +
> +	/* pointer to begin address of field that with data error */
> +	addr += index * nand->chip.ecc.steps;
> +
> +	/* correct each error bytes */
> +	for (i = 0; i < err_cnt; i++) {
> +		u32 corrected_index = temp_addr[i];
> +
> +		/* for wrong data in field */
> +		if (corrected_index < nand->chip.ecc.steps)
> +			*(addr + corrected_index) ^= temp_data[i];
> +
> +		/* for wrong first-3-bytes in redundancy area */
> +		else if (corrected_index < (nand->chip.ecc.steps + 3)) {
> +			corrected_index -= nand->chip.ecc.steps;
> +			temp_addr[i] += (parity_len * index);	/* field offset */
> +
> +			value = readl(nand->regs + MA35_NFI_REG_NANDRA0);
> +			value ^= temp_data[i] << (8 * corrected_index);
> +			writel(value, nand->regs + MA35_NFI_REG_NANDRA0);
> +		}
> +		/* for wrong parity code in redundancy area
> +		 * BCH_ERR_ADDRx = [data in field] + [3 bytes] + [xx] + [parity code]
> +		 *                                   |<--     padding bytes      -->|
> +		 * The BCH_ERR_ADDRx for last parity code always = field size + padding size.
> +		 * So, the first parity code = field size + padding size - parity code length.
> +		 * For example, for BCH T12, the first parity code = 512 + 32 - 23 = 521.
> +		 * That is, error byte address offset within field is
> +		 */
> +		else {
> +			corrected_index -= (nand->chip.ecc.steps + padding_len - parity_len);
> +
> +			/* final address = first parity code of first field +
> +			 *                 offset of fields +
> +			 *                 offset within field
> +			 */
> +			offset = (readl(nand->regs + MA35_NFI_REG_NANDRACTL) & 0x1ff) -
> +				(parity_len * nand->chip.ecc.steps) +
> +				(parity_len * index) + corrected_index;
> +
> +			remain = offset % 4;
> +			value = readl(nand->regs + MA35_NFI_REG_NANDRA0 + offset - remain);
> +			value ^= temp_data[i] << (8 * remain);
> +			writel(value, nand->regs + MA35_NFI_REG_NANDRA0 + offset - remain);
> +		}
> +	}
> +}
> +
> +static int ma35_nfi_ecc_check(struct nand_chip *chip, u8 *addr)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	int i, j, nchunks = 0;
> +	int report_err = 0;
> +	int err_cnt = 0;
> +	u32 status;
> +
> +	nchunks = mtd->writesize / chip->ecc.steps;
> +	if (nchunks < 4)
> +		nchunks = 1;
> +	else
> +		nchunks /= 4;
> +
> +	for (j = 0; j < nchunks; j++) {
> +		status = readl(nand->regs + MA35_NFI_REG_NANDECCES0 + j * 4);
> +		if (!status)
> +			continue;
> +
> +		for (i = 0; i < 4; i++) {
> +			if (!(status & ECC_STATUS_MASK)) {
> +				/* No error */
> +				status >>= 8;
> +				continue;
> +
> +			} else if ((status & ECC_STATUS_MASK) == 0x01) {
> +				/* Correctable error */
> +				err_cnt = (status >> 2) & ECC_ERR_CNT_MASK;
> +				ma35_nfi_correct(nand, j*4+i, err_cnt, addr);
> +				report_err += err_cnt;
> +
> +			} else {
> +				/* uncorrectable error */
> +				dev_warn(nand->dev, "uncorrectable error! 0x%4x\n", status);
> +				return -1;
> +			}
> +			status >>= 8;
> +		}
> +	}
> +	return report_err;
> +}
> +
> +
> +static void ma35_nand_dmac_init(struct ma35_nand_info *nand)
> +{
> +	/* DMAC reset and enable */
> +	writel(DMA_RST | DMA_EN, nand->regs + MA35_NFI_REG_DMACTL);
> +	writel(DMA_EN, nand->regs + MA35_NFI_REG_DMACTL);
> +
> +	/* Clear DMA finished flag */
> +	writel(INT_DMA | INT_ECC, nand->regs + MA35_NFI_REG_NANDINTSTS);
> +
> +	init_completion(&nand->complete);
> +}
> +
> +
> +static int ma35_nand_do_write(struct nand_chip *chip, const u8 *addr, u32 len)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	dma_addr_t dma_addr;
> +	int ret = 0, i;
> +	u32 reg;
> +
> +	if (len != mtd->writesize) {
> +		for (i = 0; i < len; i++)
> +			writel(addr[i], nand->regs + MA35_NFI_REG_NANDDATA);
> +		return 0;
> +	}
> +
> +	ma35_nand_dmac_init(nand);
> +
> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
> +
> +	writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTEN);
> +	/* To mark this page as dirty. */
> +	reg = readl(nand->regs + MA35_NFI_REG_NANDRA0);
> +	if (reg & 0xffff0000)
> +		writel(reg & 0xffff, nand->regs + MA35_NFI_REG_NANDRA0);
> +
> +	dma_addr = dma_map_single(nand->dev, (void *)addr, len, DMA_TO_DEVICE);
> +	ret = dma_mapping_error(nand->dev, dma_addr);
> +	if (ret) {
> +		dev_err(nand->dev, "dma mapping error\n");
> +		return -EINVAL;
Shouldn't this return -ENOMEM or simply ret when there's an error? Also, 
should we consider unmapping the page with dma_unmap_single in that case?
> +	}
> +	dma_sync_single_for_device(nand->dev, dma_addr, len, DMA_TO_DEVICE);
> +
> +	writel((unsigned long)dma_addr, nand->regs + MA35_NFI_REG_DMASA);
> +	writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | DMA_W_EN,
> +		nand->regs + MA35_NFI_REG_NANDCTL);
> +	ret = wait_for_completion_timeout(&nand->complete, msecs_to_jiffies(1000));
> +	if (!ret) {
> +		dev_err(nand->dev, "write timeout\n");
> +		ret = -ETIMEDOUT;
> +	}
> +
> +	dma_unmap_single(nand->dev, dma_addr, len, DMA_TO_DEVICE);
> +
> +	return ret;
> +}
> +
> +static int ma35_nand_do_read(struct nand_chip *chip, u8 *addr, u32 len)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	int ret = 0, cnt = 0, i;
> +	dma_addr_t dma_addr;
> +	u32 reg;
> +
> +	if (len != mtd->writesize) {
> +		for (i = 0; i < len; i++)
> +			*(addr+i) = (u8)readl(nand->regs + MA35_NFI_REG_NANDDATA);
> +		return 0;
> +	}
> +
> +	ma35_nand_dmac_init(nand);
> +
> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
> +
> +	/* setup and start DMA using dma_addr */
> +	dma_addr = dma_map_single(nand->dev, (void *)addr, len, DMA_FROM_DEVICE);
> +	ret = dma_mapping_error(nand->dev, dma_addr);
> +	if (ret) {
> +		dev_err(nand->dev, "dma mapping error\n");
> +		return -EINVAL;
Same as above.
> +	}
> +
> +	writel((unsigned long)dma_addr, nand->regs + MA35_NFI_REG_DMASA);
> +	writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | DMA_R_EN,
> +		nand->regs + MA35_NFI_REG_NANDCTL);
> +	ret = wait_for_completion_timeout(&nand->complete, msecs_to_jiffies(1000));
> +	if (!ret) {
> +		dev_err(nand->dev, "read timeout\n");
> +		ret = -ETIMEDOUT;
> +	}
> +
> +	dma_unmap_single(nand->dev, dma_addr, len, DMA_FROM_DEVICE);
> +
> +	reg = readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
> +	if (reg & INT_ECC) {
> +		cnt = ma35_nfi_ecc_check(&nand->chip, addr);
> +		if (cnt < 0) {
> +			mtd->ecc_stats.failed++;
> +			writel(DMA_RST | DMA_EN, nand->regs + MA35_NFI_REG_DMACTL);
> +			writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | SWRST,
> +				nand->regs + MA35_NFI_REG_NANDCTL);
> +		} else {
> +			mtd->ecc_stats.corrected += cnt;
> +			nand->bitflips = cnt;
> +		}
> +		writel(INT_ECC, nand->regs + MA35_NFI_REG_NANDINTSTS);
> +	}
> +
> +	return ret;
> +}
> +
> +
> +static int ma35_nand_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
> +				      int oob_required, int page)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	void *ecc_calc = chip->ecc.calc_buf;
> +
> +	ma35_clear_spare(chip, mtd->oobsize);
> +	ma35_write_spare(chip, mtd->oobsize - chip->ecc.total,
> +			(u32 *)chip->oob_poi);
> +
> +	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
> +	nand_prog_page_end_op(chip);
> +
> +	/* Copy parity code in NANDRA to calc */
> +	ma35_read_spare(chip, chip->ecc.total, (u32 *)ecc_calc,
> +			mtd->oobsize - chip->ecc.total);
> +
> +	/* Copy parity code in calc to oob_poi */
> +	memcpy(chip->oob_poi + (mtd->oobsize - chip->ecc.total),
> +		ecc_calc, chip->ecc.total);
> +
> +	return 0;
> +}
> +
> +static int ma35_nand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
> +					int oob_required, int page)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	u32 reg;
> +
> +	/* read the OOB area  */
> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
> +	nand->bitflips = 0;
> +
> +	/* copy OOB data to NANDRA for page read */
> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
> +
> +	reg = readl(nand->regs + MA35_NFI_REG_NANDRA0);
> +	if (reg & 0xffff0000)
> +		memset((void *)buf, 0xff, mtd->writesize);
If only one branch of a conditional statement contains a single 
statement, you should use braces in both branches.

if (condition) {
          do_this();
          do_that();
} else {
          otherwise();
}

> +	else {
> +		/* read data from nand */
> +		nand_read_page_op(chip, page, 0, buf, mtd->writesize);
> +
> +		/* restore OOB data from SMRA */
> +		ma35_read_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi, 0);
> +	}
> +
> +	return nand->bitflips;
> +}
> +
> +
> +static int ma35_nand_read_oob_hwecc(struct nand_chip *chip, int page)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	u32 reg;
> +
> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
> +
> +	/* copy OOB data to NANDRA for page read */
> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
> +
> +	reg = readl(nand->regs + MA35_NFI_REG_NANDRA0);
> +	if (reg & 0xffff0000)
> +		memset((void *)chip->oob_poi, 0xff, mtd->oobsize);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t ma35_nand_irq(int irq, void *id)
> +{
> +	struct ma35_nand_info *nand = (struct ma35_nand_info *)id;
> +	u32 isr;
> +
> +	isr = readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
> +	if (isr & INT_DMA) {
> +		writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTSTS);
> +		complete(&nand->complete);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ma35_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	unsigned int reg;
> +
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		dev_err(nand->dev, "16 bits bus width not supported");
> +		return -EINVAL;
> +	}
> +
> +	/* support only ecc hw mode */
> +	if (chip->ecc.engine_type != NAND_ECC_ENGINE_TYPE_ON_HOST) {
> +		dev_err(nand->dev, "ecc.engine_type not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	nand->ecc_buf = devm_kzalloc(nand->dev, mtd->writesize + mtd->oobsize,
> +					GFP_KERNEL);
> +	if (!nand->ecc_buf)
> +		return  -ENOMEM;
> +	chip->ecc.calc_buf = nand->ecc_buf;
> +
> +	/* Set PSize */
> +	reg = readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~PSIZE_MASK);
> +	if (mtd->writesize == 2048)
> +		writel(reg | PSIZE_2K, nand->regs + MA35_NFI_REG_NANDCTL);
> +	else if (mtd->writesize == 4096)
> +		writel(reg | PSIZE_4K, nand->regs + MA35_NFI_REG_NANDCTL);
> +	else if (mtd->writesize == 8192)
> +		writel(reg | PSIZE_8K, nand->regs + MA35_NFI_REG_NANDCTL);
> +
> +	chip->ecc.steps = mtd->writesize / chip->ecc.size;
> +	if (chip->ecc.strength == 0) {
> +		nand->bch = BCH_NONE; /* No ECC */
> +		chip->ecc.total = 0;
> +
nit: New line is not really needed here.
> +	} else if (chip->ecc.strength <= 8) {
> +		nand->bch = BCH_T8; /* T8 */
> +		chip->ecc.total = chip->ecc.steps * MA35_PARITY_BCH8;
> +
> +	} else if (chip->ecc.strength <= 12) {
> +		nand->bch = BCH_T12; /* T12 */
> +		chip->ecc.total = chip->ecc.steps * MA35_PARITY_BCH12;
> +
> +	} else if (chip->ecc.strength <= 24) {
> +		nand->bch = BCH_T24; /* T24 */
> +		chip->ecc.total = chip->ecc.steps * MA35_PARITY_BCH24;
> +
> +	} else {
> +		dev_warn(nand->dev, "NAND Controller is not support this flash. (%d, %d)\n",
> +			mtd->writesize, mtd->oobsize);
> +	}
> +
> +	chip->ecc.bytes = chip->ecc.total / chip->ecc.steps;
> +	mtd_set_ooblayout(mtd, &ma35_ooblayout_ops);
> +
> +	/* add mtd-id. The string should same as uboot definition */
> +	mtd->name = "nand0";
> +
> +	ma35_nand_hwecc_init(nand);
> +
> +	writel(DISABLE_WP, nand->regs + MA35_NFI_REG_NANDECTL);
> +
> +	return 0;
> +}
> +
> +
> +static int ma35_nfc_exec_instr(struct nand_chip *chip,
> +			      const struct nand_op_instr *instr)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	unsigned int i;
> +	u32 status;
> +
> +	switch (instr->type) {
> +	case NAND_OP_CMD_INSTR:
> +		writel(instr->ctx.cmd.opcode, nand->regs + MA35_NFI_REG_NANDCMD);
> +		return 0;
> +
> +	case NAND_OP_ADDR_INSTR:
> +		for (i = 0; i < instr->ctx.addr.naddrs; i++) {
> +			if (i == (instr->ctx.addr.naddrs - 1))
> +				writel(instr->ctx.addr.addrs[i] | ENDADDR,
> +					nand->regs + MA35_NFI_REG_NANDADDR);
> +			else
> +				writel(instr->ctx.addr.addrs[i],
> +					nand->regs + MA35_NFI_REG_NANDADDR);
> +		}
> +		return 0;
> +
nit: New line is not really needed after return statement.
> +	case NAND_OP_DATA_IN_INSTR:
> +		ma35_nand_do_read(chip, instr->ctx.data.buf.in, instr->ctx.data.len);
> +		return 0;
> +
> +	case NAND_OP_DATA_OUT_INSTR:
> +		ma35_nand_do_write(chip, instr->ctx.data.buf.out, instr->ctx.data.len);
> +		return 0;
> +
> +	case NAND_OP_WAITRDY_INSTR:
> +		return readl_poll_timeout(nand->regs + MA35_NFI_REG_NANDINTSTS, status,
> +					  status & INT_RB0, 20,
> +					  instr->ctx.waitrdy.timeout_ms * 1000);
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +
> +static int ma35_nfc_exec_op(struct nand_chip *chip,
> +			  const struct nand_operation *op,
> +			  bool check_only)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	u32 i, reg;
> +	int ret = 0;
> +
> +	if (check_only)
> +		return 0;
> +
> +	ma35_nand_target_enable(nand);
> +
> +	reg = readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
> +	reg |= INT_RB0;
> +	writel(reg, nand->regs + MA35_NFI_REG_NANDINTSTS);
> +
> +	for (i = 0; i < op->ninstrs; i++) {
> +		ret = ma35_nfc_exec_instr(chip, &op->instrs[i]);
> +		if (ret)
> +			break;
> +	}
> +
> +	ma35_nand_target_disable(nand);
> +
> +	return ret;
> +}
> +
> +
> +static const struct nand_controller_ops ma35_nfc_ops = {
> +	.attach_chip = ma35_nand_attach_chip,
> +	.exec_op = ma35_nfc_exec_op,
> +};
> +
> +static int ma35_nand_probe(struct platform_device *pdev)
> +{
> +	struct ma35_nand_info *nand;
> +	struct nand_chip *chip;
> +	struct mtd_info *mtd;
> +	int ret = 0;
> +
> +	nand = devm_kzalloc(&pdev->dev, sizeof(*nand), GFP_KERNEL);
> +	if (!nand)
> +		return -ENOMEM;
> +
> +	nand_controller_init(&nand->controller);
> +	nand->controller.ops = &ma35_nfc_ops;
> +
> +	nand->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(nand->regs))
> +		return PTR_ERR(nand->regs);
> +
> +	nand->dev = &pdev->dev;
> +	chip = &nand->chip;
> +	nand_set_controller_data(chip, nand);
> +	nand_set_flash_node(chip, pdev->dev.of_node);
> +
> +	nand->clk = devm_clk_get_enabled(&pdev->dev, "nand_gate");
> +	if (IS_ERR(nand->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(nand->clk),
> +				     "failed to find nand clock\n");
> +
> +	nand->irq = platform_get_irq(pdev, 0);
> +	if (nand->irq < 0)
> +		return dev_err_probe(&pdev->dev, nand->irq,
> +				     "failed to get platform irq\n");
> +
> +	ret = devm_request_irq(&pdev->dev, nand->irq, ma35_nand_irq,
> +				  IRQF_TRIGGER_HIGH, "ma35d1-nand", nand);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request NAND irq\n");
> +		return -ENXIO;
> +	}
> +
> +	nand->chip.controller = &nand->controller;
> +	platform_set_drvdata(pdev, nand);
> +
> +	chip->options |= NAND_NO_SUBPAGE_WRITE | NAND_USES_DMA;
> +
> +	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
> +	chip->ecc.write_page = ma35_nand_write_page_hwecc;
> +	chip->ecc.read_page  = ma35_nand_read_page_hwecc;
> +	chip->ecc.read_oob   = ma35_nand_read_oob_hwecc;
> +
> +	mtd = nand_to_mtd(chip);
> +	mtd->priv = chip;
> +	mtd->owner = THIS_MODULE;
> +	mtd->dev.parent = &pdev->dev;
> +
> +	writel(NAND_EN, nand->regs + MA35_NFI_REG_GCTL);
> +
> +	ret = nand_scan(chip, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		nand_cleanup(chip);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static void ma35_nand_remove(struct platform_device *pdev)
> +{
> +	struct ma35_nand_info *nand = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = mtd_device_unregister(nand_to_mtd(&nand->chip));
> +	WARN_ON(ret);
> +	nand_cleanup(&nand->chip);
> +}
> +
> +/* PM Support */
> +#ifdef CONFIG_PM
> +static int ma35_nand_suspend(struct platform_device *pdev, pm_message_t pm)
> +{
> +	struct ma35_nand_info *nand = platform_get_drvdata(pdev);
> +	int ret = 0;
> +	u32 val;
> +
> +	/* wait DMAC to ready */
> +	ret = readl_poll_timeout(nand->regs + MA35_NFI_REG_DMACTL, val,
> +				 !(val & DMA_BUSY), 50, HZ/2);
> +	if (ret)
> +		dev_warn(&pdev->dev, "dma busy\n");
> +
> +	clk_disable(nand->clk);
> +
> +	return ret;
> +}
> +
> +static int ma35_nand_resume(struct platform_device *pdev)
> +{
> +	struct ma35_nand_info *nand = platform_get_drvdata(pdev);
> +
> +	clk_enable(nand->clk);
> +	ma35_nand_hwecc_init(nand);
> +	ma35_nand_dmac_init(nand);
> +
> +	return 0;
> +}
> +
> +#else
> +#define ma35_nand_suspend NULL
> +#define ma35_nand_resume NULL
> +#endif
> +
> +static const struct of_device_id ma35_nfi_of_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-nand" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ma35_nfi_of_match);
> +
> +static struct platform_driver ma35_nand_driver = {
> +	.driver = {
> +		.name = "ma35d1-nand",
> +		.of_match_table = ma35_nfi_of_match,
> +	},
> +	.probe = ma35_nand_probe,
> +	.remove = ma35_nand_remove,
> +	.suspend = ma35_nand_suspend,
> +	.resume = ma35_nand_resume,
> +};
> +
> +module_platform_driver(ma35_nand_driver);
> +
> +MODULE_DESCRIPTION("Nuvoton ma35 NAND driver");
> +MODULE_AUTHOR("Hui-Ping Chen <hpchen0nvt@gmail.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
> 


