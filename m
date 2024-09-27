Return-Path: <linux-kernel+bounces-342274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F22988D01
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B891C210A3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9231B2515;
	Fri, 27 Sep 2024 23:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="dfqTDqOF"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2110.outbound.protection.outlook.com [40.107.102.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23801EEAA;
	Fri, 27 Sep 2024 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727480014; cv=fail; b=s78/KnblhrxKdeY5gD+zIkxpjyKQguayalMmlNPkdaXv+239/0h6AiM/1SfuWt5F7RXaKl/mSEg1ne0TvwXhH3Ybzc/eYg6HcCLIwys4KT64f97Ckj/owsg+8nLkGTqiNmIerAIu6Cvc2R7nfIADOnkqpFZjJGo1GFbLLpRZmHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727480014; c=relaxed/simple;
	bh=IOqgk0h/LNnsaFua+vP48UoiW53g+A/SidSZQixR+QI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cojLZTuMJerfaNspFHatDMaw0xYKdjtp9wjDLaAEjS/8CGgjiyFg0nWu0vb4L6yB2db8GrJdMxdZX8KdqbuoCyYluqSib4Zsc+QWBeH+xcOJXl6hBiB0YR+RGOle9qC5Whs6J792rBQY8W2CRgse4r5l5L5tT/Ah+hTBB+iBKgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=dfqTDqOF; arc=fail smtp.client-ip=40.107.102.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs3RxVZBGbi6Lujhu7oVLjSb4dT3ZftujkmqiCnZMgbZU8SxRSEyjOssc543s6bMnE4JcVfe0AxjSrl6+vCog6mvRBfEVncD1SZlO44NCLdGFrsopASBw4o2tWsznd0yJk47dVcY3qaoeMLLVdwPwUW1Pwx9vuW6ijK8Sw0dB2Hr5S8q385H8HEGlAe/gJPd3iZU0M3yh2BuvQqnCdEe+e/9JWN8o4irCOImTngx7Frl25k0fqKB/9H8v7v0ZiIttcEQXYGQa4nkNuleVsMhy5Z0GHYPT8zGM1khot379A39IjTON3QBA5Nvl3zabeOZpbupDqXmLfCVHHfH6MzX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyjNvd8M/2lae61xTa9xAYZ9jL2jLFYCHVSHlEIF46w=;
 b=L4S2zuHnQEuwdaxivZsjIoR0RYjB5wGs189kCI6wZMLeqa5dAeRDKbxtSwPzvPHm4mBOhpJzc5pPYpB5jq/8wOU+OQ2qn4s0LW8CebpasDzasxdABmYf5v5CE+on42dasxi9yu7CvRezbkqXsfQ1jKfE7Jor6cYKLorwzr/UHU6PlL6DeXqoPWl1MkwBH7IILdJtDz0jav2xAeoJEJqI5X1zbmAjkhfPRBjtWr8uQJQmIEOw3MHx5C+ABqb9WlO+MNuwDDkLMZ0hyzF4lQVUVlM43uVa/NXK9TeFIwwziQU3u/sHoxVAM0EzN9D8R4+CHvG50CLMu6ggIRjWq98umA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyjNvd8M/2lae61xTa9xAYZ9jL2jLFYCHVSHlEIF46w=;
 b=dfqTDqOFAZoWnUqbKw77H45hxE1wtN4STne4lo4PqLI90ftN3oof+vK1e+rgbYywORHDr1IR5NTo9CzApP6ROFLU0jPt4/iREzW4U4Gdeu8nxJBdaO7dVyuHbzBV0qYk5CEgWVdGmF4xfPoMleNgrJ/tLdkR4BstrLf2vAOCkyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by CO3PR22MB3278.namprd22.prod.outlook.com (2603:10b6:303:178::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 23:33:29 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 23:33:28 +0000
Message-ID: <bf3ea670-4759-462b-8694-87db180ee4b8@phytec.com>
Date: Fri, 27 Sep 2024 16:33:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: am62-phycore-som: Increase cpu
 frequency to 1.4 GHz
To: Nishanth Menon <nm@ti.com>
Cc: vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, w.egorov@phytec.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de
References: <20240913175625.3190757-1-ggiordano@phytec.com>
 <20240913175625.3190757-2-ggiordano@phytec.com>
 <20240913180949.dlw3k6epqmzlpuu5@studied>
Content-Language: en-US
From: Garrett Giordano <ggiordano@phytec.com>
In-Reply-To: <20240913180949.dlw3k6epqmzlpuu5@studied>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0206.namprd04.prod.outlook.com
 (2603:10b6:303:86::31) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|CO3PR22MB3278:EE_
X-MS-Office365-Filtering-Correlation-Id: 753cccdb-e8ad-4579-cd38-08dcdf4cca7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDZpK2dEalVnQks0ZzFxdUs3enhjRmhjb2FVQzAwVm1XVmxDK1lNcFNJcE9v?=
 =?utf-8?B?S1QvbHBUaHhaMHQ5OWZuZnVlWHFYRmxMczkrTHcwdWFqZnZNYUhzOHp6NkpB?=
 =?utf-8?B?OFMyZUpsdDROQjFSNVFFTTBRWUhKcExydU5NeVJoWEloRGZ1OGUwSE1rSmhY?=
 =?utf-8?B?VjN3S0ZhQ3lNQjd0RmdWc1dVN2JVZHl1ZlBSNHh3SjBJYUVqSUV3M0VaSW1u?=
 =?utf-8?B?RlNreTE2VlFJTzZIdDRIeWlsWlg3QUw5ZjRDTUFIMDA0N2hNOEpqK0s1NXlV?=
 =?utf-8?B?YjlwZjEyQUVFRFZzNmxaaUgrZlNiYzE3ckIvL2d2cTAza0hIZFVsbWlRanp3?=
 =?utf-8?B?QTVqU2gzQnVmNnY0TTRiM2R0aVBsMTVpR3ByOXNaS1ZpbVRhRFh0OHBZRFBl?=
 =?utf-8?B?bVJ4NnplazRlM3dicnRMQ2F2S3JJdnhZUldqU2kyQjNuZmFhbmNxRm5jWmJy?=
 =?utf-8?B?UUl3S3hzTnFCaEYveDJndWt3aEdqdVQ1SWRMZ2ovbklMLzlUYkxqdFdyZTJv?=
 =?utf-8?B?R2Z6V2hKOXRtN09SWEZUMm5kN1VWcTRvd3VIdkhPU1Brb1QxNW94WVh6UmVY?=
 =?utf-8?B?Wmh4bzh5Nk9CTWhkWjV0VHRhakFWMXc0RkZ3bytGOXVBbkFXc01NWWo4Ti9i?=
 =?utf-8?B?Nk9iUFB5amtjZEgwenVqdktoWWxpM1BDcS9CVjRoRE5GQUdRRVpBdE1ZVFdG?=
 =?utf-8?B?NWx5Q3Vwd0ppSXlUSC9qR0N3K3ZmU3RCTVJZMk0wRXFaQWo3SVZ2QkV5cVhQ?=
 =?utf-8?B?amNUaWRySmErWnA1clJ3YnVDRFBLTnUzMCtOdWVDRUlWdWtaczBZdGkrQUV4?=
 =?utf-8?B?YWFQSVFQN0VhREJLNXZMT085UDNINGRtQVFFM3pxUGp5ejUwUWl1V2xCMEFL?=
 =?utf-8?B?bUR0QWVQaTIvUGxwcjdncTdVVXhsMnhnQXRTa1NYOHQvTzlQUENscVl1cFJE?=
 =?utf-8?B?dXZhRVpwQnR0TkE2Yjl0cmp4Z2R6Qmtlb2NDOXNaK2l5N1prWVAxVW1kbXEw?=
 =?utf-8?B?T2kzSEg5dVBsMkhvYXErc2NhT1pZQ2dvYTI0N3l3aUhQMldGMVhKdzR6am1Y?=
 =?utf-8?B?OTl5ekFJMGZSL0lnOUExU0NGeTdETExvV1ZlMDl3QkVkMW9lOVFDTE9MelBV?=
 =?utf-8?B?T1EzaytXOHp0cVFGenJOQzBaVVFlNG9mUG5RSllIZm9JeExjTWFxSm1iQ2s4?=
 =?utf-8?B?bnNseFI5bkdDaU1VeVlieDdWVVcxWjl3aGJxZzdNUmtPWXB5WFZqNEF3SzVi?=
 =?utf-8?B?MlNPYmd5MExVQmRTZk0wNXpDeWxxSy8zTjRIaWl1dXRvbG8yMW5vQ0JkRDN6?=
 =?utf-8?B?NHJwOWRpM2lhNGNSQlVPNDE3dGs3Tmc4Y0JXcC9VTXFjYklTc3dkVWNnS0NU?=
 =?utf-8?B?TkZUanUxc0swM3RUcnpQRlBaWVFZc2VteUJzcGJiS2F5VmdyMlhabm9uQmxH?=
 =?utf-8?B?UERzSGd3a3NrellLdFkxSzRaUmpYRXpRN1AwNjZRTS95cVNBRmh2a3dZRmIr?=
 =?utf-8?B?dkhaZEx4empVbDcwVVZ0bkticEsyVnVxZlNzNHhHZEZjaFlGVUNjWENBZVFq?=
 =?utf-8?B?cXpnRUVFZWNSUzR5RUwwL0lTUGFlU0s3QzJ6QllGYUkxb2t0c1ZiYUR0dXc3?=
 =?utf-8?B?T1h4U2JVR1pSNmVXdlBsdXVIYnBob2lESDBVNEJadklrajR0dWpTZXNnM1NG?=
 =?utf-8?B?SE5sZmM2dVN0eHYzWkZtejl4Y3ZhaEt6YzZVbXB4YWU3Q1RaNVhYUGF4SXZZ?=
 =?utf-8?B?MFMyVTN1SlUwMUE0Y1l6Zkk3YnBuOE5qSElldm1ReWVNRzJ0UFlxdnRWSmQ2?=
 =?utf-8?B?ZU9LS3k1MmhiWkxrMk9lUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW41ckovSkJReUlqUlBNcnpFQ2FtSGZBOFU4dUtBaDBxcTZLaVFoYUZpWkdn?=
 =?utf-8?B?NVExODhubkpMVzhVNDU2SUR1TWRDR2t0bmE4L1QwdjBtdnN3SFFQSXF1MUxG?=
 =?utf-8?B?Y1FKZWRzT1R3WUdxZFZNMzk3b01hTGFUWUk1SFRZNWNrSDR6dkpCY2pEMEpC?=
 =?utf-8?B?cW5uMTBzYTZKUE5YYWRRMjFWNitNYzl2TmFWOFUvSkRrRnAxTkc2U0NKRS8y?=
 =?utf-8?B?QnRwc2hsRlpVd0xFeFkwMHlXQlJJVDk2cXBSY0JDWHAvb21NWXhENFFTMFFX?=
 =?utf-8?B?YkE1YitZL3UwSTdLMmFRTDduUThsQ21KMjBIVkh6UkJoVGZqSmE2b1VKWmJX?=
 =?utf-8?B?bXBsZGNNQkZnV2FZUXZrMGtqdVdVaDRJVmpEQTRKa20rTjl3azlDRGVRS1F5?=
 =?utf-8?B?WG1ZbUY1NStKNW0xakRmYi9BWDU1b0V1TDkzakVLdzBBbDA4ZGFoY0t1RCtP?=
 =?utf-8?B?SnVYbG8yczQ0RWNncmxUeE5waEx2eXZ5Nkk3WURPRjU2amQ2cVI2T0Y1VDRu?=
 =?utf-8?B?ek1RZnJjdHJjNzliU0xPcFpRcERlMm43T2dYcnQrYnZCY2l3ZFdVWUZ2K1V6?=
 =?utf-8?B?VmZ6Rm04Q3NqU3NpRWcxTVA5WndpUmh4NUdXbFBwMFNoZGZYcktTVUcxSHY2?=
 =?utf-8?B?UlVaOTYrSGdMaTFVVWhLZWVVa0pMU2M2ZnExY3E0T0FZeUxiQ20wRWExNWZH?=
 =?utf-8?B?bm55SHZmc1NEdUxNdVFBTlJTM2c4NTNCZFVnOTlMQ1pKaGxSNGtQTE1EdzVt?=
 =?utf-8?B?NHV2eG1sTXRTb2VOejJ6QTYrRG1IQ0trYW5udmRnZ3JwTGwxYkp0WWhTaXlR?=
 =?utf-8?B?cVlxTWdLejVJQkdZVzhINW8yQS9GZUpvZzIwMFBWOTJpOU5SZWl2NzdYNW1q?=
 =?utf-8?B?NEpWaUxmbVc3ZnRhdlBQVkV3Mmp5RzlWMk0xaFI3VDhsUDdoa0doeGh5RG9w?=
 =?utf-8?B?RTM1M1cyL1ZzSlc3cndjTDN2eEpPbk1Nci9tQk04TDRsTHU5dU9nYnN6M1ZJ?=
 =?utf-8?B?M0doVmhoT0RxTEhkakI3Y0xaV2lrWWFrTnYyMTZMeDQzZkRZWW5QbUo2YnRl?=
 =?utf-8?B?QnByalJyNkxpYUxsUFlXZUpZalRYQ21NQjBaSXF1RkFtc2JVYVZFb0JNN3F5?=
 =?utf-8?B?VkZxSkQwTFFSY1ArYTNtNkpsUGNHdkZsVm1EaHg5aG1NRXRSVDVLTjNUajU1?=
 =?utf-8?B?NzRZb2xrRGhyU25yOXJ4ZVNrbGpHamJ0Mk95TW9uQWJMcUczajl4NjBDYXh2?=
 =?utf-8?B?SHU4N3hpenVGZFpqc2ZLL1RaVldkUGx0S0dNbldtTWRCSS9BVzlZMUNhbnpM?=
 =?utf-8?B?TWt4d0Y0Tnh5aDM3UVNPaXZZNGZkaVRSbnBIbXdaT09ibU41Vy82ZlZkd1Zn?=
 =?utf-8?B?ZVlKTnFJVzZiaHVPYTVRTkFoU2Z6WVB5aElpdDVmZ3ZpeDEwOUxYQjEyWjlV?=
 =?utf-8?B?RzhzdERLRHBtOXZMUkdmc0E2MCtyRk5WaXlDaHhYb2NFWGlrV0ZRamE4MTE0?=
 =?utf-8?B?QzBvVVNKOW80WlZNRTlYYzJRYTdNRzl6MURyMTBsc0h3M2M5OVRrQnJDMmM1?=
 =?utf-8?B?MXN1SWZrV1o1TURzVTJwTkJ1a2tUdmZ4NlREcDJSSStyamlhaGd1bGtKQzFU?=
 =?utf-8?B?S2MvMVBpN2djUG5OMVBmd0Y3QkRabzhXR09kZ3duV2JCNHZLbUVUamZBYkFR?=
 =?utf-8?B?WFhHWWJKcGExWWkwdkdsTnhycXlsZXVnY2tQVXdpYnpCNUJ4VlpQancxNXBj?=
 =?utf-8?B?RmVLRlFXeHBBQm1kY2FlMGl5L1BJMjYzRUZ1TTJkcDlNRFJXcWxWYjFpLzFk?=
 =?utf-8?B?Witja0gxNnZCTmozVkhFQTVhaE1BRjdTMlVkRm9GUGpRd0xNeHNrc0VBOUxF?=
 =?utf-8?B?ZXJtSU5MM3dnYVpDTjRteUJqNDlKcjREYXEwVnhUSTRYUmZkbzU4MUJKOE1k?=
 =?utf-8?B?dFRiVGRMSGlEbTBVZ2Qva2o4MXJNRG5RY3dYSGxCeSttU0tvN29uTW5PeDds?=
 =?utf-8?B?S1hsM0dHRHZ5UlBjK0VNaE5qUkVOeTVtVmNPR1RzRnY1SHBOM0pJa2J4ZnBV?=
 =?utf-8?B?cFptdlA0MHdLdjZBR2h4WHFtOGtaY1JoTDUvQlpFc2V5SEtXMGdGQjY0NThM?=
 =?utf-8?B?NUNndzVUenozOFNrekEzc2RnaGc4aStDZmJWQlkzME03MjhYcHF5WTlLUEc2?=
 =?utf-8?Q?B0UuHBzZFRytRC7/xju3JWHN6YhFkjUFrUiStMjQ6KRb?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753cccdb-e8ad-4579-cd38-08dcdf4cca7b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 23:33:28.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7b51l8snIQFhYl/EkhJc2lIi7WqvfLj7rTR43PB+IMjLebRdQ6ryaD7BjLZ5liJD2LcmxyCiztA+avTT60+PcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR22MB3278

Hey Nishanth,

On 9/13/24 11:09, Nishanth Menon wrote:
> On 10:56-20240913, Garrett Giordano wrote:
>> The am625 is capable of running at 1.4 GHz when VDD_CORE is increased
>> from 0.75V to 0.85V. Here we add a 1.4 GHz node to the a53_opp_table and
>> increase the VDD_CORE voltage accordingly.
> The entire argument in introducing the 1.4Ghz overlay seems to have been
> to let users have the choice. What has changed since then?

I talked with the team and we came back with the following:

- Our default PMIC configuration changed for 850000 uV / 1.4 GHz operations

- All available users will receive a PCN on update with instructions 
towards 850000 uV / 1.4 GHz operations

These changes make this overlay obsolete.

>
> Ref: commit 7a5775a3da906dab059b8de60a2b88f6016cb4b8
>
> btw, instead of putting a patch to delete the dtso, you should
> probably consider a revert patch instead.

Thank you, I will send a v2 Monday reverting this patch instead. This 
will also address the Makefile edits.

Regards,

Garrett

>> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
>> index ac8959f3d953..8acbd4facf37 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
>> @@ -205,6 +205,13 @@ AM62X_IOPAD(0x01f4, PIN_INPUT, 0) /* (D16) EXTINTn */
>>   	};
>>   };
>>   
>> +&a53_opp_table {
>> +	opp-1400000000 {
>> +		opp-hz = /bits/ 64 <1400000000>;
>> +		opp-supported-hw = <0x01 0x0004>;
>> +	};
>> +};
>> +
>>   &mcu_m4fss {
>>   	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
>>   	memory-region = <&mcu_m4fss_dma_memory_region>,
>> @@ -265,8 +272,8 @@ pmic@30 {
>>   		regulators {
>>   			vdd_core: buck1 {
>>   				regulator-name = "VDD_CORE";
>> -				regulator-min-microvolt = <750000>;
>> -				regulator-max-microvolt = <750000>;
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <850000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>> -- 
>> 2.25.1
>>
>

