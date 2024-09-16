Return-Path: <linux-kernel+bounces-331042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36AD97A7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6381F219E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198FD15ADAF;
	Mon, 16 Sep 2024 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nxGv1FCG"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95F168DA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726513368; cv=fail; b=OEfqWGDjRBDT5fQ2Oz32y6lI+I16Eveo473nGutx424Pw597WHMj3Y3VI21CyAgWrfXMuqZSYLXZge1OfQiudQcsYRtYApBNizAQ7IT7bPP9cDib+bXdpsEdlzVIRx2k3XaPFnOZOUbakcIuFrZL6bA7HjNyCYfkfDbZbYBYftQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726513368; c=relaxed/simple;
	bh=9h6WN7Fctd14C46zp+OArqxLfTpcAa9Astbk3ACfLIQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q9Ig/oslsKVpJY0LBeQO2P3S6vaAqi+lZq537i9JD562AQi3vYHr9U2poKlfESKC6+rOuPKUJMYYM9PozhINBp23DY4+h4x9x7hyy0q1YdGBvCqeHUrF/biCQae9b9vXAHNJzmdSn66UJc/297wg2Z6Vl/nqPFUqGqFwh9hDZh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nxGv1FCG; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ65gbtHIA/KYleIbKagmztg6Vju4hWBXquFd6fIt9KLKwFqne/nU1TN+EhuBBPge9hF72MRy4WDx6ZzDHWfNSS2EJBOe6HZGFkJ3CbYUHsde80GUVR+jxWJNV4gHK1ZZhMJ3DwqwHkEyU1Ua3sGd6bZaII/hT6Vy3+1soWEUutPosIRUpcrKrE1vknALrkDAvUbodurbu7v/Oj9CsbtlIEGJ/U9WFdjG5JCt9ju1cxlXzy2h8RY82269b6E1vjOWdKNERu05h7SAi8dBjUmqJisloVFVrOLnoYk9IRvUwVB6CKvXHLstFrwvx+34OzwfnqW+80PIv0K9rZh/W37hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmds1C9L7TfUTWtgOa4bSus2LGdP2s5AyFE1jh0uH5k=;
 b=Dj1Qta4B1FCVSutVjlkLTkhJUl/tTWK54CzQ8KGqBoG+hlm+B0ukf0cYCaAd7WV6ct77L+S0vxLFhaN/nuyL2iCtBjzoiTpua6TJc6XN5IQweSIJ2S4izLA/+hyGdanXyY/Q5rTM1YtJDn4YhvHS8vlFflA387kvLUUzN6DB47ZO6BJQLIqbDHDR7Wd+KKOEFgognT/iJjiNwxYZ8K+bV853fJw6uGqY7ckuai63hrlpC1eIdtpuyGjlBqCYd0WlZ7Fd3OKlhIWNXeRi5jALq+RCBUFP2PBIU6valsxupB1RJsXyObW3YZpCRSQXGNyuBTBy9AFkVQxIdkFz5Ps2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmds1C9L7TfUTWtgOa4bSus2LGdP2s5AyFE1jh0uH5k=;
 b=nxGv1FCGP5zSA3tEiV79rCcgFq/Cz1UbWkn59+SmCQvq+QFfcVb3WDVhBQUYUyR+SfGj7zR/1jW7kNudPXahNAOFL+d2Z+Jh0di7+oibuYFCneFnyAAV9l3+h6SRvia8fJqQCcRJbM2JSbI94gbhLt4Ao4ZQv8K+cRPxyACGJFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 19:02:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 19:02:43 +0000
Message-ID: <6410fdbe-77a7-4930-9dff-dbedbaa1d050@amd.com>
Date: Mon, 16 Sep 2024 21:02:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: drm/sched: Add new maintainers
To: Philipp Stanner <pstanner@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240916185159.35727-3-pstanner@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240916185159.35727-3-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cb15a4-6948-4ff0-7f92-08dcd6822511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEw0Q0tVcWVua0ZPUVNrZmF4VW9qVUk0WjA2bzRpV1dQSmJhOVRXY3FvbW4x?=
 =?utf-8?B?OGxHZENNM1VDeTkrMXlQcVhMclY2Ym55RFM4VEQvQkdwTVhhT25MQ1MxVm9v?=
 =?utf-8?B?bmRzVmEvbklXaEpIczNrd21BWjIvdFdrWnlVWGxtQVhuS0N6WjlBUHRKNnMw?=
 =?utf-8?B?WEhObHZXdXdUODMwSmZTSkR6eXlnWHordDJJd204Skk1b2lUeUxCZXJuay9j?=
 =?utf-8?B?RUdsS3U4Ylg5NFZUS3dBMXA5M2pJc3N3aGpXejNzK3FWY0xOaHQvSUY3SVph?=
 =?utf-8?B?SzFvZWhGSUxTTS9MK3l4NklRSmFsN1lHd2hiS0M3U1hXRWRhNXJEbXZOK0Yr?=
 =?utf-8?B?S3FiWHlGSm01VDdMUVpWSm80OUhOaVlHWVRqQ0s5TVNaeVhUV1NwNVpxTFZP?=
 =?utf-8?B?SzU4MVRHbW82MC9pb29UK2czOVZpZ2dub1RhbEhGL2dkVXYyK3Vmb3NZWkZ2?=
 =?utf-8?B?ZEJDaHBVaW1HOGJ4d1Y1NDdhN2lxdGRQaXo3czc4WVVKQUlkOW9oVE9pSUpZ?=
 =?utf-8?B?bk5Ba2tkc3NWazdDSDZMSjVmb2JHT0RHbGVuT1Axd0RKVkI3NEt1TGU0NTll?=
 =?utf-8?B?YjVDZkpJV0xXNFJUY2ROYmM5SWROWEROTllKWkNYZmVrNERiQW5YMmx3ME1h?=
 =?utf-8?B?OS9EbXdWWi9IUlMzODNydHpBK3c1SUVXdjNVMVRHeGZTOU9tN1dPUW5YS01B?=
 =?utf-8?B?YjhaKzV4KzBsTlpSeDFjZCtTQkdzd1RWV29WeUNFdFJiRlM4SW14cldkc0NY?=
 =?utf-8?B?QXVLQnNrNUJ5eUd2SzJ3akFlNWlNaDl6Mm5QZFVzdHE1UjlHODRNelNSTDVX?=
 =?utf-8?B?b3dHMk1rZ3V5eDViUGFneE9ZeFdSMXNLYUI4QXMxQyt5bEJNZFRXdllYaGZE?=
 =?utf-8?B?ZkxnMERWa3o1WGFNWTJ6SVBYb21TSHJkazZERHRhNmVINTR3ZmRpeWtneGxQ?=
 =?utf-8?B?RVhzS2FCNTM3TTJWM2Q2RVVISFpxM3diK2VYWWZSQm9uQVRNYXFWT1lqWEdC?=
 =?utf-8?B?TWFVZzViWEd5S0N2ak1MQnM2ZXZMQjJxdVNJNEpBTnJ4NXdBRFNWWmhoLzU4?=
 =?utf-8?B?UDBjSjdHNk0yb3JhYkZYd2l3UDJkTXN4Q3VlSERrOWdtVzdpV1NaVG1KZUlo?=
 =?utf-8?B?Nnl5NzJqd1A3UzNQekhudEEvbjRDTlRuNkx1NGJLWGRXcnRaUFhYc3hPSU9h?=
 =?utf-8?B?Y0Y3b3lHYjVmb2FJamMvL2hCRW9aRit4YzY1SkIra3JkV2htV2lIQXlEaXhG?=
 =?utf-8?B?eUp0UDJVUmEwVFppdTdySWV4UEtPMnJoenR3dGZLbFdxL0tRS1pMMjd4cXYv?=
 =?utf-8?B?ZXpxUGZYMEErVTVRc2FLNW5zSnRjaTRGTHR2SWxQZzhDU00yckMwQ2tVUkVH?=
 =?utf-8?B?TTluR25SMTg1SU8wU1BtYitvYUJpRlRsRTdjWWZzY3NObkxPdEpKQWMxZUFz?=
 =?utf-8?B?NDI2d0ZtOW5HRnRIWVNEMnNMUHhhSXZYY0UzZDRRY3pQL0tTMHgvbUtHOXg0?=
 =?utf-8?B?WGY1eTJ2a1FZVUlpYXhrTGZWZXlCWVA0K3N1OGozZ2FqRUFnQm1Pd0NQYmpD?=
 =?utf-8?B?bkdkS21YWWNnVDI0MEErL3p2N092Rm1aNnVjYmNyTi9lbDMydWs5THBVQzFx?=
 =?utf-8?B?cTQybHN3UFIvYlBzOGdZSkdCQ29YQUlERkJ5Rmpma1ByNGhWNm1xa1k2aWgv?=
 =?utf-8?B?YUVTMXA5TDExak84bXcwZlpEakJ2ak5GRVZnYTNyR1M5dTBaNW94T0dHZFBS?=
 =?utf-8?Q?P4vT4C1mphnsQJQKxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk91L2hoc0VjMmpYZE82TlVMMVpwNEVMK1ZyYTZ4ODl1dGU2Z3IxRGRIYVhK?=
 =?utf-8?B?NEg2OXR5cXNVb0NzV1pkak5idjQ1NE8rVUFYWXladnJWcWI0RzZtVmhOdFhI?=
 =?utf-8?B?TzhEY20valB1bXh2alBLZGxZcEFKT0tGUjI3S1RxZE5XVUJkd1ZUV2hJSU5m?=
 =?utf-8?B?S081Vk9HYStWaUVNVGxxWHNHNUg1ck9jZkxCMHZKelp1RkE4NzBDeUVzT2FB?=
 =?utf-8?B?bWsvSGdidXA4YWtmcEYxN1VPeThpT3hnNWRlUFIyclAyRDFHRkdyb215Ni9P?=
 =?utf-8?B?L0RRVk54T2p3Z0N4ZzUvaUtkWnpLQUY5T2o1UjAxbVBCOEJPYnVuNlJBY0Qy?=
 =?utf-8?B?R0MvM1JPK3dISHhPTlNpV3J4blpZK0I0ZnJOZ2RNTVBxL0xZQ2dGUWp1bFgx?=
 =?utf-8?B?bjRPYnlKVzRBV3EvMHVVbWRhUFJyVERQdW5INUJVcU50TWg3K2RjTGhWaXk3?=
 =?utf-8?B?dHJ4bTJJcE9zenUzYjlrQ3R4dC8zM0VFOHYrVFZlNVg1QUJ1QmlJVmx0ZFA2?=
 =?utf-8?B?cTB0QVgrc1hwY0VIVm5UcDNhenM0clltZXl5WHp3VDZyQXpGdGxVeHZJcnJw?=
 =?utf-8?B?SGJkT0ZFL25pRDNuV3l1NmhMbFVwQnY3bTRqVU9sL2N0Z3RnVy95Yi9tYVU4?=
 =?utf-8?B?ZzZyTjV1MU8zSkc3WDB1QitHQlRlMElRMHFMWk9ZUVdybjhTQm8vMnJDcG5k?=
 =?utf-8?B?TmxWdngxWld1WnFRbWRkakxnSGtLMk42Nnp4clRpaFpVK2oxcG45SnNSM2ph?=
 =?utf-8?B?c0dZRS93MjRNaGIva2w0Zm9ad3c1SkpVVExkT0tBNUtBaHlxcnBleGxGKzlN?=
 =?utf-8?B?ZCs5ZzFBc01IMFNhREZUejFoV0JqSlJiZnVRVDJNa3VKNWJvRXp0RGZXZ3hM?=
 =?utf-8?B?ZEp0OEJhd2R5cDFPY2Ryd2tDTlhKZ1JJSnRrQWlvUk1odXFHc3p6TmVkOTFm?=
 =?utf-8?B?L05RNHdaWE5laktLeUl0Y1p3YnI1NFNZOXJaMkxsanRreTk0ZWlrQ2JJOTB3?=
 =?utf-8?B?ZGJiUHZRYzNUUERsWUVmaGF1dkViUHhMVGJxN0dlSUJaZnorSWp2a3dHZUxI?=
 =?utf-8?B?d0J1QW9JOGUyQUcwUmloM0tYRFhqd1l5OHJTbnJpRUNpZEFueWdSWWJZMTZa?=
 =?utf-8?B?UTZ3OTRueDZIQk1tVDlCcWsvb1d1VEJwU2NZM0ZhRzFtQWIyempiWS9DSHZm?=
 =?utf-8?B?MWpMT0JhSTNMYnlFUUhnYXhUc2ZMZEV6WGsvVEV2UnZWbC9nSzNkd1FNWUNv?=
 =?utf-8?B?MEJKazZsSHI3aG0wTmtYOGdZcGI3SHVVWFkyYmtLRDRPWkE3a05qNHR5OGxC?=
 =?utf-8?B?ai96RWxTUFB3MEFlQ2R2YzBmRzVoaXh5UUpWZEx5bHVvcXJYM09xbnh3UzY1?=
 =?utf-8?B?TVlqRml0SXJCUnc2RXB0M1RUVWJlWDVhRTE2TFJaNXJnZ0JvVFp5VU9ueVQ1?=
 =?utf-8?B?RGFlb2tqeHpCWDNFUzlmVThiU0F1alJVcis3S1pnWkRhM3NjUnhsS1ZrdVpl?=
 =?utf-8?B?RzhoODhmajVzVEp1RFlwWFR0YmdpWHpZeGI5TzNYcDE3Q3ZBK0JrNGNVT1FY?=
 =?utf-8?B?K3NCdXY0cXRuVzkyTUZYcHhiRzI1ckRKSHN5M0NZNkhiVGVPQjhKZVRIb0NO?=
 =?utf-8?B?WXE2Qk56TE1JL08rT2JkNnBORitKSXFWeU5ZQUEwMjFPQmFRampKVlNqNG8y?=
 =?utf-8?B?ejVyY2JxemFtZU1ScDBzZTl2Y0RVZUN5UEx5NGhpajd1NUJBQWhPZE5xZkp4?=
 =?utf-8?B?RTdNN3lvMkVVUFdCK2RzbGFkeHh3b0R4UHlkckxsaHZLVDhUR0x4VG5pYTZW?=
 =?utf-8?B?RjdjMHZqb0s4dndiMXNlQVBMOS9CcVFObHh5RGlVTXkyMnozUHEvcE5QVmJV?=
 =?utf-8?B?VUVwdzEyZmFJcUNGSG12QjhiMGhxSEZ0YzF5elFIa1UwYXk5M2h1NC9JMlVt?=
 =?utf-8?B?LzUzajRtVHpBdzU4eFhvRndpcVdNZmMwMldCQkt6allrWHhaR2xGbGtmeEVr?=
 =?utf-8?B?dEgrMDdzNjJMSlA3NlFnaExhV0tWWlE2bStWMllLRis4K0svV1o5ZVFuVURh?=
 =?utf-8?B?SWU3bU5SZDFIWEw1N3VxWXBRZDFlYWRadWwxK0lVd2NSemVaMzh6bGRKVTBG?=
 =?utf-8?Q?OOys=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cb15a4-6948-4ff0-7f92-08dcd6822511
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 19:02:43.8984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sb/K13ZA+bOMFNmutsZQLwqx+mczxUhp9Kt9p24pz7WFoRmBBg/3BLLmO5e3/sid
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492

Am 16.09.24 um 20:52 schrieb Philipp Stanner:
> DRM's GPU scheduler is arguably in need of more intensive maintenance.
> Danilo and Philipp volunteer to help with the maintainership.
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Acked-by: Christian König <christian.koenig@amd.com>

>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10430778c998..fc2d8bf3ee74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7710,6 +7710,8 @@ F:	drivers/gpu/drm/xlnx/
>   DRM GPU SCHEDULER
>   M:	Luben Tuikov <ltuikov89@gmail.com>
>   M:	Matthew Brost <matthew.brost@intel.com>
> +M:	Danilo Krummrich <dakr@kernel.org>
> +M:	Philipp Stanner <pstanner@redhat.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git


