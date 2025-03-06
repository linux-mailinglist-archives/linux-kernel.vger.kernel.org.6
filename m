Return-Path: <linux-kernel+bounces-549105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8A5A54D65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93687188BAEB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FDD1624C8;
	Thu,  6 Mar 2025 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="unASO8U5"
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010000.outbound.protection.outlook.com [52.103.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BF14EC46;
	Thu,  6 Mar 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270668; cv=fail; b=RVSgPwbZKwcF6OJTodIwyt6UJBSw2IQWhbQzYCZq1kuiQ39qqtR9LgYJCwjHX6I01wl24Hg3omSzAQdEWO2CQnKfoKiRl9ANCxBfNE0RvAGCKKQaWBZzbZqFKPRxoT+JGrQehNmADhwinio8GvX5mojDUobrsUqEzCXC1g9cyF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270668; c=relaxed/simple;
	bh=Q0Loyf0bSY0JK8NgbZa14IectrEK+y3k1QV/iTXUjjI=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gg7CbYYrBosqthJtGXGu1GIR1xfPFQXZmx5HazMHTXzcot+K+IwYqdqTmIDzmAJmzZ/VUrmQo4aap76ytmYhfN7CbQU/MbwqvrVQr6xPe8a+JmQtQEsuhY4tK88KK3Ne+cUGjylqQ/D/3d9cdUsGZHytr1jwoVNepKcK5qq0nMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=unASO8U5; arc=fail smtp.client-ip=52.103.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tw4vxrJa/jYreaiAa0fuDWnZw8Azl9rkwvSCkSGzDmAf0n53YDfqIR3w3jMre1xYYs6R2qaoFWQdAXEDWXvYNzpdZjWNAO9st51fm/BRRRMSESSfkPDSjXPQ55aFgCgJvVKrw+0iqIQ+JQcmJRh9Bm75G0Y7ox4CDNKwt0AURIey18DQLeUh2h8r0pEyKkTkZFSohgaBLfn/QL2Mt6bQ45+3fp4gU3FnubewuMQK2YBh33qsRqlpn+8B0DARfWXqafvOGn/TGkMO7sXy4pDL0XxEmGlQCL8iNRM5pEfXtPx0sgJHrSjgepynR4ZtF1evlj9TPTjt8GyPJ6jeT8N5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0Loyf0bSY0JK8NgbZa14IectrEK+y3k1QV/iTXUjjI=;
 b=qwwysWmyCHA3WqL2ON+mbf4F7w/kc4ZUFWsPnAC7htza6Mpzn6N7/TqTTOpv3ZtnY4k8YVgQRnoVkxToxrW8Yt5Gsvf9At999Sgkzr/Nwv15CHZSTrQLAUgx1tbhetOPdeFJSBZsTcyKE00q42fhpEkR1JzxwX3pXFUM3NFMamQ8tJ6ZBVXxgZDWGC2IbdhtoSy5H7K6ajJQq2qpDr/KOP1V1PXc7qkx2VgLL9exS2ODgR8f9dc4wvN/fdusFQO47BKgpXIHwLTN3NyeO17TevHSVRMG8whDa7Cgalfk/l1jtZMC/wEf74l5Zfu1+XUYYX5kdOOh0Kk/zTILg/j+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0Loyf0bSY0JK8NgbZa14IectrEK+y3k1QV/iTXUjjI=;
 b=unASO8U5FSF6Ayrxvt8hjvHD5Hv1/QV6NytJZffvUQ6kyWxb7e2mneO+442XU0vC/MlA7+FjKL7hivnZZOpmkL/ndWh52UtF0W0euDmkikYyx+Zec1lA85iIdst4eHIwk1OIWIjCpADjfJgqbfyGGT2u/2pusaB+INBLe/2xU58A2+0LqP4tnPt5yuPUWK4C2S1rkgl2WLJMGpLvkOpeoTXuOHe00ss3OE2W8qPebi8TUo5VZSYaQciPFc10RMkwJEdTg/8HiNOMMkr+DfMrK3KFaJt9uNNs6sunWkGC4PpZMsFSKOAv+9z3mWaztGfoURkO9UBJ/M62u9nTy4gwtA==
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::15)
 by SY8P300MB0359.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 14:17:42 +0000
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3]) by ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 14:17:42 +0000
Message-ID:
 <ME0P300MB0553FD455B51B2EFA38C61CEA6CA2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Date: Thu, 6 Mar 2025 22:17:30 +0800
User-Agent: Mozilla Thunderbird
To: panjunzhong@outlook.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, michal.simek@amd.com, peter.chen@kernel.org,
 piyush.mehta@xilinx.com, radhey.shyam.pandey@amd.com,
 siva.durga.prasad.paladugu@amd.com
References: <ME0P300MB05533B11B123B7C9188B699EA6CA2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Subject: Re: [PATCH V2] usb: chipidea: udc: Add revision check of
 2.20[CI_REVISION_22]
Content-Language: en-US
From: Junzhong Pan <panjunzhong@outlook.com>
In-Reply-To: <ME0P300MB05533B11B123B7C9188B699EA6CA2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:208:236::11) To ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::15)
X-Microsoft-Original-Message-ID:
 <a2fdd3b1-950e-4799-8690-c588ace969d7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0553:EE_|SY8P300MB0359:EE_
X-MS-Office365-Filtering-Correlation-Id: a497727a-32b6-41af-39d3-08dd5cb9a817
X-MS-Exchange-SLBlob-MailProps:
	4VtScROZs21tclTogOA+uPwo1G7ulZ+nB+5wwgy4qhXgrpuUPq7lMHm5zI8tDkg9tnE8CjKDfI/p8DMnaB/bH5hdg2bP3P15BVmMuoUTbElKdXovaCkP4YLNvtGN5ewntJ2NWp26CU8rjgqTobUq6+wVv3WRhlPHiTFiNc/v7bSKw8hb7srYoaXk+YsrARql3/pYJOQ4CeivEgr4DdrWVYtSBe2ytoKxaU19j/OC0Y2MhV9h+o6eL3gESNbLyugeO7EEgJrgYtdCOseDay8d9aEQIdmirABOYxpudvLClSJ/S4BegQ8Gr9Awdgl19MTdGS8rBJk7eC5pJCQzaBKQHDOeHmBiJ9bKcrNDacIBMWEK4wawMutYAaW/2DGCf4fguFs6q34s5Gx6clc1j2mxRaU9i82dS7VofKyZZqLssuEWOkz3ysRoX1M5Qg7ycj4RNPb2uyLSDAv7xAbxUTkMmB1rO1K+Lo1YrbjbINA59qaXWM+hVzfwtkeAx67hnHmJ+rHv4TBcMURGazHmakIPrOBE1nDOHi2ucAIaUd4zwvfz19Lk/dciksWds/315wpXbyNFG5kpEifm8fsgc3Zk63k6R6AcMfRwmyuwu+oHyoG47L42vTRvfHmEujKWwynnekSid8mB1u4yt63v3LhQyUu5ihysm5/LYFkz399o7hTr7ClDeSTh4w==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|6090799003|5072599009|7092599003|15080799006|440099028|3412199025|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WW9UY0tsMUxKMGRTQ3lGUGt6NkJPcmFqUE1zZ1JTUytlaDNwY3lzbjRCY21B?=
 =?utf-8?B?T0RINmU4a1U5RWZJUUk4Sk44N1l2SnFrbkpsWjY2VVBwUzE1OWlsb2JWdTVv?=
 =?utf-8?B?TXlUU0FqU21NeC9QNENDYWZmS203WU9YSksyMHRhM0ovYTk5QThFbWpBb3VM?=
 =?utf-8?B?WWRPdGlIbGlwaWsxUS9UTE16VWhLZFlkQ3ljMVlwNVVjMWpraCtJQ2VKOUFL?=
 =?utf-8?B?VXFaWGZPdlMwWXpOdXJyaVBUbnVsem9hdmZrdEF0QndEYmhPUGR2Tll0V3Jm?=
 =?utf-8?B?citEdHM1L3dzU1lZMzFYQ0xRSnRBYVdBOTZGV25ZUGI2NVowMTZUejB2UUgy?=
 =?utf-8?B?anNOWXN6dGRwTFkxdUxMS25vVUxjcytLb09DRi8xaWRoSlN6ZG5WVzFraG9G?=
 =?utf-8?B?L25lQyt4MUNZRWF2MWFzays0bWxzbmcwWFJ2MmtjRnVPdzN2YzRuOFkra3hJ?=
 =?utf-8?B?U3k3Q1RTdXk1clZsRS8zcjJWN2hTOXJkTkk5V0k3ZTh0T3BUNmM2cG1oVXo2?=
 =?utf-8?B?VlVUdXVaNzhMMXlDaDVHMVdDVHlVOXQ1d1Q5R3ZKVnptb0NXNHVERjNKSnhN?=
 =?utf-8?B?US9FZEwrMHFZRCtqaTVKZStPWUtQV2hScnFLeC9WQVhBQ2dHdHI0STBDNnZ3?=
 =?utf-8?B?WlVIVWlJMHpYVVB5UmRHNjUreldoVlhLMExwOXBoMnlyeVNEcHhOeGc1RklW?=
 =?utf-8?B?UlVkMllRY1U0WG43L0pRWnFiVm84RytMVENlR093WGZkM3hSaFpQbVhXUFJ0?=
 =?utf-8?B?OFFjd3U3YlR3VER5VW5NTWp0Z2JLZ2VvWkxRS0VhbHJTY2wvNVk4OUhIUUYr?=
 =?utf-8?B?eHplSmFhWTJSaXRzS2xwb1M3NVdzeHlUYzA5TVVFVTVzV0h3NDBsbUlLNnlF?=
 =?utf-8?B?V3FUVVFIT2dZb3FHcXA4R3RjUFRWZHNnVXJRMytMN1RwVW0rM1hwR1doZzJF?=
 =?utf-8?B?aXI2akpsNzV3VWlOWGhpNzJBRS9UalU0WGRHNnpITWFUMnlMUGtwNUppRlBW?=
 =?utf-8?B?bytwYngzcU51aGdLekh3NFpCV2dDQXh1T29YdFBWRFREMmtSaVhmMUYxM0hj?=
 =?utf-8?B?UCtuMnhEZTV2NmtnSDljVlY0bXNvQ2M1d3p3d2lTN2k1SGdEdExsS2JFbGV0?=
 =?utf-8?B?K3dCSzVLVU5EbWI1UlVZOTVLVGJLYURXRmFqVWV4eXZVTElLbVpSSjc1MWl6?=
 =?utf-8?B?OHM2Wkt5MHV3Mi9nSlRWK3FhR3FjY0pYR0taZXQ1K3FRenZOZFV6OHl3a2N3?=
 =?utf-8?B?QUl6NktVMkRnaEFFR0s5VUJpZjZPNWNsTFA3YVN0UTBIWk1qb2xuUy9vL2hO?=
 =?utf-8?B?T1p4M0JSSE1kRUdTUVBzdUwxTFNWMWhxYWpUMk1vbXlEWnVycUR2cGg2WVdp?=
 =?utf-8?B?clFKd0ppcFJQSWsxS0pzalVxUm5NT1Z5L3h1L08wT3FGVmpaMVVlQitjcUVy?=
 =?utf-8?B?eWpWZmhkdG5aRkZ6S0c1R3dGaGczMzhFTExEcXZYY2dMUTg4MVlxQmZBV28r?=
 =?utf-8?B?SCtHYTIxYnlOYlp0dUNyYTdqRzF4TzU1QkZRcCt4QWFQWHRFWnI4YjVpT0pu?=
 =?utf-8?Q?gmOqfXp2IR+onAzRyOmwHE6lU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnFQYmxjaTIvNXRhUm5oWWwvWGc0UFhxclRIUG5LbWdzRGVsRFhhSzg3dmJH?=
 =?utf-8?B?cXRxZ0hiT0h3Z3M3L1dBZVREaTZjUE5lZkN0KzkwREFyV1phVDc3ZE9kN1pX?=
 =?utf-8?B?a1l4VjluZmtWQXUwQTE1RjZrb1VMc05iOTh1MXVYUWdHc2NBZEo2TGZQY2Jo?=
 =?utf-8?B?YVA4ek1WSjl2NWVpbWE1S0s5Z3NiNy9yS25yN29zR1lIZVhId0xBMWRtRW1S?=
 =?utf-8?B?VUNZSXVDQ1lobStKcTRIaldMbHdGdkJjazdXaVZaZ1pZaFpKamM5Zkt6UWVO?=
 =?utf-8?B?ejI4OC9kVFR5U2lDRm44VGhRdDNpSmNCcVZFT09LeWg0aUtzT3EvZFBtSW1o?=
 =?utf-8?B?RTBCUmIyUUluckdOUWFueTd4bk5GdTdZejNWeEJZY1JOcFZKNCtxeTJYUlFk?=
 =?utf-8?B?eUZ2UUIrMGU2aXlpZXZ5aUt4eTMvWnlEWmt0TzVvZHM3dFVmYSs5dGlqRHBn?=
 =?utf-8?B?MDNZNjRKY29heHVtNUh2Yy9VbGtnUGc0eDhjZ2N6djJUdGovWWUwemRDajY5?=
 =?utf-8?B?T1k3bGdTUkFsRDNxczlwNE9vdEN2M1FpbzZWVlpCeit2QlJGYWFRMlFRaGta?=
 =?utf-8?B?VWo2QVZvZUE1THpRcjE2VERZUWcrcGUxM0loT01tM242eW9TaWo5azh4V1M5?=
 =?utf-8?B?TE5zNjRUWFBBZmFrek1OMEFjTjd6N1pyQlJ0N3FQZ01CdFdsY21EUWNKSXk1?=
 =?utf-8?B?ODBHUk5BNlNBdWJ1T3NLOWd3N3ZISzFXSmlzbDFqU0ZLLzJmSkIrY1ZWbVAr?=
 =?utf-8?B?WFhMSlROMXY1QTFlUWx0cGpKK29DWmdMUTdSckZLZ0RYdndpeVpaanFpVkJn?=
 =?utf-8?B?NHQ4WHJ4d2VYTzNHN1Y4dmZwTkV6WFlHTitKTVhqdmkycCtndWJIQ3B2Q2Q0?=
 =?utf-8?B?MVgrZEZvNnpza210eTd5US9sOW5nYm80NWtxZVphZjNYZXJBb1lEME1SOXBY?=
 =?utf-8?B?U2poZzdER2FHNDNNNmxHRUZKQVI5eE9ETklVSmlPZmxjNUd5YUFMUjZVNXNL?=
 =?utf-8?B?QTg2eDlDNXc5TDAwZ1BxSGJ2N3B6RExkeFk5bXJEUXpPVUo1RnpCMDFOVmJu?=
 =?utf-8?B?Z2VwWlV5SlNWRStFL2JHZGVBSzNGTjl0ck8wVHNPRm13RFhzdU9YS081LzNu?=
 =?utf-8?B?S0hidTVnWlRDLzBQZnV3U1JvU1V6MGxxVytvTzN2eWhDRWdQV1pDV0p0M2dq?=
 =?utf-8?B?OU15YllTMFVhUm9aRXVNYUVjT0hOdEE1clVjZWNoNk9FQmJCR2FudmRheldl?=
 =?utf-8?B?WmNSMG9GV0tCUlJ1bWpJZkIzUENpVDhPOE9YbzVMS296amZXME1SNXVYdEJK?=
 =?utf-8?B?QTlZdzRMeHpGcXgrK1NGYlk4ZUV1SWVqVmxCblVSWTF0eFowbWd3QW5aSTR0?=
 =?utf-8?B?Ukx3U3hXMVJtaTRaZXBtdElNSzNaejRTWDVQQWNBYUdGem5CTEljRFFadlR2?=
 =?utf-8?B?UkdKTEYrQ1N0Qy9RSXJ0S0J1UDBkOW9uZ2RvRU1ET2VEbUV5WEdLWjZCTGdi?=
 =?utf-8?B?Y3J1dXVUWjVERHNWMmxOQ1J6OUhnMm04WUhLcUtjQWZHMmZ0NHRqUHY3b2Vr?=
 =?utf-8?B?Z3c3VGpTK2xlWURPaHFTbFBhTjQ0R0hRQVFDRXBZcEcvVExIWUF4aXowWnBk?=
 =?utf-8?B?alUyRURvUGZvNWl3aHArSFBnK3JULys3M0lSM2RWdVdwem43U0RiYnV0TXpo?=
 =?utf-8?Q?rCIS4lqUYG+xMm8d3Mzf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a497727a-32b6-41af-39d3-08dd5cb9a817
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:17:42.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0359

-piyush.mehta@amd.com for undeliverable address
+piyush.mehta@xilinx.com

