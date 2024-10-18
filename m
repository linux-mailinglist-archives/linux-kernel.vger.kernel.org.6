Return-Path: <linux-kernel+bounces-371981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CA39A42EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCA51C25EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B873D2022C5;
	Fri, 18 Oct 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="10BFEsGb"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD451165EFC;
	Fri, 18 Oct 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266673; cv=fail; b=QQnuaF6mLuagj4lF5qRlH/sBMO+ET9nt0e2hnh6lyZy7UYZtt7vTyfyQFuQ3FWAjMxv6y2PUmfW8VbL1LcOdq2bNZ/lpybZo671tvs7dJe1lIw0/12r8s4VZ8VBNMDkboSWJ5s5QTkIVy9Q0buLA8eWoK0t1ddUocJB/jSXaQYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266673; c=relaxed/simple;
	bh=xlhwMagr14Rzm+LOcYp61mOIKgTN1sK7e8+t+Xoeeik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hdJ4fnWreTZHGupTGiCU0ft4ReTagiizjRsGhNXmrR62KsJbomrAKS68ES/u4l6VmFgDXceCFMGXdE8/ZjuT2dmt04RJHXp3ElCv44Mrfo+CXub06KU6LjU0x0YRVyjZ3XNmYOibVUEARJCv1P29Kg6c+2qF77fvNhxQaBR5eik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=10BFEsGb; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylrgyskbp5psqLICA9tZlBvziZORkcLgpn6D/hh0JSWmemWkcjdowB06ViowA2Wi2vTBZ5GeWBe3XNQlpLlRR3moEwdR5LAeXgL6P4P2zXi5vKXFtx3f5pCGZRDcmNkh4wgrm5mt8pED75vo1YLEuPQpL18cc96usDJ4wQC8OLKpjuVGUKsmUCODvzTjoBAXFw9VY42j9LS+rqRRg42xbzXn00B/K5yUaY5/4I8vsC60e3i6QWumljU2CkmofHJnRoV8EGngN/+RhN1yBqYiVem57Sumj2zaRoxO5SC5ms5cAn+KAXE1YAq8GvXqdKDEMLQOl3V8ucBA95Z2S7r9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a5Tha1iakzBKB4iW8fwtvDeFL62BFgi5bXX52GdTDw=;
 b=Iv3S6tnzm7wsBH59MbyymJx2jJrlHQcfO+9glViLRWGnmLUvRqoXjW2yPq2lOv2HIfjY/DMYgpQjWMQmlPacbn/oCqGhyHSRiDGUhhuNGD5nWEvA8xU8I/Jhrc5Dam1SgjM11oxTX7XnsMBHww5PlowNmkZKuvNby8mEu8UjDoyuewhHCcOmMrmrD1G/eJt2ah/Pa/XHWOR/FPDquTv/PY1Lj2eH3vyxX5EVu5padiUnGYhI2BD5frjVTYWQw1FpAFMl2JvcmomkI0/hYCClwXQ6+9TjbvNrE1cpTfXeWja3jBe6y5JWz8M7D4MVnidiMQXq+qED9AQhLJ7u8JiLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a5Tha1iakzBKB4iW8fwtvDeFL62BFgi5bXX52GdTDw=;
 b=10BFEsGbCMPQ2T/O3lZID8QhvO5BOdBnoNfuyyfLPrQnwo/5+dx34O/xb7tUVfGUzDW/uwqV3/+18bI/aEzQ6v91q0ghETJkKsRrryLPMdwNJwYYadJh57da9K0hklG2t+sSm9D+uk9mdnR448f4ttxbhD8IBbniONtoeNxZbaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 15:51:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 15:51:04 +0000
Message-ID: <2ef3c008-81db-a3b1-19bb-6f60c6aa617c@amd.com>
Date: Fri, 18 Oct 2024 10:50:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 23/25] x86/resctrl: Update assignments on event
 configuration changes
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <715b84c29f4ec849a79698ad43218d4a486422d3.1728495588.git.babu.moger@amd.com>
 <03b278b5-6c15-4d09-9ab7-3317e84a409e@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <03b278b5-6c15-4d09-9ab7-3317e84a409e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0077.namprd13.prod.outlook.com
 (2603:10b6:806:23::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: e85f4740-7b14-49dd-c76b-08dcef8cabeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUNBRC9vTzZzTWdzU0g1M2hlYjdnZlZaclk4eXBGTThHM0lHOU0rbk5uY0U5?=
 =?utf-8?B?WmVZYTh1bllEcGptMjd5ZW9xUWNjbUFZdWFnS2RsTHNlVEtMcTluWTA3U2ds?=
 =?utf-8?B?RjZ0YkhQM3hrSTB4dWVxMmdjLzFHWVZwUEFmTXJkNDl6YURCNmxNeTM5SlJk?=
 =?utf-8?B?VjRueUI2OVdQczdYT0EvYkVaaHNrZzNiK20ycVhwMGZPcCtkUkc3VHJrNVdo?=
 =?utf-8?B?cndGRFRsYnkvY2dCcWFpZXNjQWxTcXpQYlRwN1Q2K3IxVjdOaXRjSTJiMzdu?=
 =?utf-8?B?dlhTVmp3K3ppeUJ5WFYxWGRMeWY0QXFkWnZFaGkrQnZIbEFZUVJHQ0hvbjR0?=
 =?utf-8?B?a3hlZ2dBcGhRQldoSU5NSU5ZT0htRThCZnFRczFON2xFQU52S3htK2FqNGZH?=
 =?utf-8?B?SGZZemdtcGZCMnYyM0lQaHNkTlIxcE1mQTM2bUcwZkJGRTd4dE8vL2xFZzR1?=
 =?utf-8?B?VFlJOC9PY2ZHR2dnN285U3pvcGhRL1ZGY0hMYVFOZEQrbEJsenJPVnlkdHMv?=
 =?utf-8?B?c1J1QngyTFpsNmVPOHZzTnVCMWRRdFRFZ2tjYndEMGFZcXFzUkxiRTZCUGpt?=
 =?utf-8?B?ZnhmTHpxWXR2aElRK0lBc2YyNWJGWE1HSThIQnRjLzNyNjZmeWlZbTI4OE5o?=
 =?utf-8?B?VTZPU3Y1bWF0M3NUckVxWHFJaVRCYy92dlBJeVFjTDBIbkNwcG1hTlFubHRR?=
 =?utf-8?B?S3psWVdiSTBCd0hHWGU3L0xsNDFvTmQyZFNQTXNwaGtVSk96UjZtVHBOd3Zl?=
 =?utf-8?B?Y1lxQWpRWG9uM1ArbXlsaTBmaGMxOFpJNWQycHNmaDVhNStNQXpYM2c0TVJE?=
 =?utf-8?B?NVczVFhrbzVoVk1ObUZyV3pJaHZrTndmWmI5UnJHNHNLdzVaOUwzeVdHdjln?=
 =?utf-8?B?R3EzeG5KWmdqTEFhNllHTkxPczZyOFoyWU10Q0JyaXp3ZWJ3Z0FkRkpTdWx6?=
 =?utf-8?B?SjltSTAzUHRTTTNzWGFLcDREclhZdUtOcHNLcXBxdVFacDFSdmZMZkNSenp2?=
 =?utf-8?B?ZkxEbnl4WEJQRGM3bTljUmdEaEdtd3dSN1E5QWNuR0ZvRzlNcTFWczBrSVVO?=
 =?utf-8?B?enFMZGNGb01QZUtGSFNxZ0lObWo3dlFOOUEzMXI2SnBJVElERENYTVdoVTF6?=
 =?utf-8?B?enRYOGQ1TG0rSTJsYjQ3cEM5YVlqS3FFK3VDWENQNytwRXZwZzJuNUN3Q2p1?=
 =?utf-8?B?UWR0S1VtTWU3bHd2by9ma2hHYmhUc3FCTlNHVTJ5NUs3NHF5V3YrUmRod2ln?=
 =?utf-8?B?RUxONWVhUlBJazlwZVhiaHpTMm9VTTI1dUZhUERicmpBS2FPRjRhSjY1N0Ev?=
 =?utf-8?B?NmRvclpveVpOZXlRRjRCNTVvVFA5eGZIZXRMbldFSzJmZzByR0x1WmFsMU9q?=
 =?utf-8?B?eDFHUFJONHlmMDBtcnFKbmFuc1hEZW8vZXBYZzIyYWVBRHJxSW9hekY4amUz?=
 =?utf-8?B?aGVpM3FsRDdkQkpkVWNITFRmcHlUMUFSazJIajZNeGpqN1A4TXd6RzVYWHpw?=
 =?utf-8?B?V1B3enZKWkIyVDVUN3FUS09PdTc3NmdFVDZPVVNZOVpJZXpraTBhL3BWOFJn?=
 =?utf-8?B?OUZHWU84RXNqM0hpZVIzbTBqbGUvVERVNWpxTG12eklRcVltZG1VRWhNbmIw?=
 =?utf-8?B?eXFYVlJsblNJc3ZYNVlsbUdmbkFheVZKakQ5WjVOM1FneWplaHNhQlY0S1hu?=
 =?utf-8?B?Um5FbXBrbDNDeUtKbms3dGsvTUxIWjE3VHVwck5YdGUxblVQdnlUa0VMYS9s?=
 =?utf-8?Q?i0KZN+wzu+XFXavSYgzB9eY5Cn09LHBQbIyIgGr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDI3U0JJK0k5MmU1enZ2bjBTUXc4U2p6R1UvNjh3TjRGTk5rTFFuM2I5Q1Z6?=
 =?utf-8?B?elRtKy9xQ25PZWx1bXpJb05NVXR6RGZvUTA5azR2RnY3TldoQTl2ZU4zbXli?=
 =?utf-8?B?QnM4UVlRdWNscEU5S2VNdUxMVFhmeTB2Vng0R051N1VINWVkYlJvNXFWWmxY?=
 =?utf-8?B?QXRwMHhwcDJJdkY1TzhWZk5KR2Zhd2lPUXBuKzVlUjFheUk2Z2RESEhQK0pk?=
 =?utf-8?B?akpjVk5QT2NPSlpTOXVzUXF3TnE1VXVOZVRGQ2thYWN4L3NpcGI1dGVMbjRZ?=
 =?utf-8?B?VW1oWGZpdWtuSEpoSmxJQ0VMMU9nVG94TXpURDdYOERkdU5LMUJWVUxLVDda?=
 =?utf-8?B?QnpQc0Q3UXBzNEtxZGR5YklnSEdmazZyT1QwUm9uL3RaTFFpVVNlRTRGbFJ5?=
 =?utf-8?B?ZW5YaGM5YjF2dnZvZTVUcTF5WkRlNU5jRWhqK1lwV1NBL0pOR0krRnJiTGRt?=
 =?utf-8?B?ak9HU2puck1XMGpNVmx5WkVENzJzdEFjSG5GbVRacTByRGxRcHp4WXYxTFE3?=
 =?utf-8?B?S1VRUVJSeDdrd3hWa1poaHkyZElzbHZ2Z2ZsOTh6SHFtamM3b3l4UDJOYTBq?=
 =?utf-8?B?QnRYanpCdFA0T3RYbjc0bHAvbnBucG5udjFwQnIzY25ZVk1WMjN4NGFHeXVq?=
 =?utf-8?B?OEMrWnQwQWt0UVplRlNWMit3OU5kR25naUdhczZFcGZzVkFLbDY4RS9RMEZi?=
 =?utf-8?B?K3NZYnc2dVg0bUZldFhHcnVUdG5ZeHI0UjQ1US92OFNtWTkvdmh5UWNMVHY3?=
 =?utf-8?B?K0ZRamdKQWtjalBnVDdvVGM5L3JnWld1V0NPa05FTlhZQ3EvY3VodWNTVmtm?=
 =?utf-8?B?dmkvL3RkTDR2dk16S3FQbHlaSVBncmI5emVVa1MyU21mTnJEeHA5Nkx4T2VD?=
 =?utf-8?B?L3J1RW1MTCt2T0tCZGtXRUlOekhkMklDNnFRQnRzUFM1SE04Q0xZa1ZyQ0Zl?=
 =?utf-8?B?UDB4NmQra2ZUUXdGRzJJWjQ3dEE5K1l4V3M2TTl0Yk54UmdBb2k4Z0JhZmRk?=
 =?utf-8?B?a2pmaFVoSTZNcUpiTXZ3NmJQR0hzUGlhRVRJOGg5d3ExSEJaaS9hRGU2ekRP?=
 =?utf-8?B?NVN4SHAwTnFxU05BaSt3M1NOQWlsanE3UkgyL0N3elkvWHpjT1BNUi9wTDRm?=
 =?utf-8?B?K2d6WnMrZ0pTenFWVTJkQUJSenloTlJic2xDL2tZL0F4ckd4ZmVvbWdEanZw?=
 =?utf-8?B?TVlPeThyQ1lSVzFTV21NRVNDSWdyYXphTlY0V0daVFRKR0NPSHg3dXlYc0Rz?=
 =?utf-8?B?eUEreXNjU1RvNVNHQnlDVGJaOFhqWmxRbjdoMEpwUDU3dm9wUXlCa3dvL0Vh?=
 =?utf-8?B?dlEyUmQ1dnhQSDFobkRFazhhWmE2c1AvMVN4UFpjUlhDOGtVRXlid1VkZlFU?=
 =?utf-8?B?T3ZHK1hhTFpHbWJLTndsZXQ1K24zbnNyd2VEOTVkNWRVRDcwWWMvNVNwdVF6?=
 =?utf-8?B?cWFja3piTVBpN240RUxxQU1LM0o4UzRNVnI2R0FCc3dvSnBPRTg3NE9mWmow?=
 =?utf-8?B?UjV3NFhXZ2NvejM0U0xHc0lCd0hyRTh3V1JNUTcwYkJNRlkxUUE0aWRRZjNs?=
 =?utf-8?B?bXZxNVpvdHZ4YWZMNG5WR0Z6NG9TVEpkaUEyMFRrTi82SkpkWGxtREZjbmJv?=
 =?utf-8?B?WHJNV3VyMG9QOUNvcG9EdFM5dmpHdzRyeFBaaHBPcFBpcDB3MmJucllMNDc0?=
 =?utf-8?B?YlkyYXhMQkdRUkFhUDR4VHZQQzBYTllUU3RBazZkZlRnT3k4UXlpWHFxN0la?=
 =?utf-8?B?bm0xNHRvRUpFS0pBSnhPR1RvWDNtQXN0R3NIcSszdHFXcHBuL28yd2l2NzA4?=
 =?utf-8?B?SU92KzJDYzRQMlAvVklMUXRYZ1Y3RUJpeWdmM2NHT29iRENnNFc3akpTNmVy?=
 =?utf-8?B?K2NaV3QyNStERFFXNlJpd0VVVFhGU2VrSWM5NkY5cjBFcHB3NVQrSE9lZW1O?=
 =?utf-8?B?YmhIdkRaZDlNdkZTZ0RUdWZUbUdIMHJSZVhZMEgxYTRjWWlXbWR2MFpJVmxP?=
 =?utf-8?B?TFRTY3M3RHZGRThQUlpNcjEvOWkrZmVrNURGQ0ltazIwYjhxZk1jWHpXY1Uy?=
 =?utf-8?B?VUFTdVlSV3M4ZnZFc3hXUXlwRVA3clZybUlBdVNXOXlHN2RzWTNqM01OVlVa?=
 =?utf-8?Q?n4XKCm0PeTnB+I6mwivsYUlE+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85f4740-7b14-49dd-c76b-08dcef8cabeb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:51:04.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myFhXy46FuT+J7dt3l2vcnNGmFQk9VzOMJb+MbVdsqKlgOmdyq5JpcHJiwqLZNp3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180

Hi Reinette,

On 10/15/2024 10:40 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> Users can modify the configuration of assignable events. Whenever the
>> event configuration is updated, MBM assignments must be revised across
>> all monitor groups within the impacted domains.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
> 
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 49 ++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index f890d294e002..cf2e0ad0e4f4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1669,6 +1669,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>>   }
>>   
>>   struct mon_config_info {
>> +	struct rdt_resource *r;
>>   	struct rdt_mon_domain *d;
>>   	u32 evtid;
>>   	u32 mon_config;
>> @@ -1694,11 +1695,46 @@ u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
>>   	return INVALID_CONFIG_VALUE;
>>   }
>>   
>> +static void mbm_cntr_event_update(int cntr_id, unsigned int index, u32 val)
>> +{
>> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +	struct rdtgroup *prgrp, *crgrp;
>> +	int update = 0;
>> +
>> +	/* Check if the cntr_id is associated to the event type updated */
>> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>> +		if (prgrp->mon.cntr_id[index] == cntr_id) {
>> +			abmc_cfg.split.bw_src = prgrp->mon.rmid;
>> +			update = 1;
>> +			goto out_update;
>> +		}
>> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
>> +			if (crgrp->mon.cntr_id[index] == cntr_id) {
>> +				abmc_cfg.split.bw_src = crgrp->mon.rmid;
>> +				update = 1;
>> +				goto out_update;
>> +			}
>> +		}
> 
> This code looks like it is better suited for resctrl fs. Note that
> after the arch fs split struct rdtgroup is private to resctrl fs.

ok

> 
>> +	}
>> +
>> +out_update:
>> +	if (update) {
>> +		abmc_cfg.split.cfg_en = 1;
>> +		abmc_cfg.split.cntr_en = 1;
>> +		abmc_cfg.split.cntr_id = cntr_id;
>> +		abmc_cfg.split.bw_type = val;
>> +		wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg.full);
>> +	}
>> +}
>> +
>>   void resctrl_arch_mon_event_config_set(void *info)
>>   {
>>   	struct mon_config_info *mon_info = info;
>> +	struct rdt_mon_domain *d = mon_info->d;
>> +	struct rdt_resource *r = mon_info->r;
>>   	struct rdt_hw_mon_domain *hw_dom;
>>   	unsigned int index;
>> +	int cntr_id;
>>   
>>   	index = mon_event_config_index_get(mon_info->evtid);
>>   	if (index == INVALID_CONFIG_INDEX)
>> @@ -1718,6 +1754,18 @@ void resctrl_arch_mon_event_config_set(void *info)
>>   		hw_dom->mbm_local_cfg =  mon_info->mon_config;
>>   		break;
>>   	}
>> +
>> +	/*
>> +	 * Update the assignment if the domain has the cntr_id's assigned
>> +	 * to event type updated.
>> +	 */
>> +	if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
>> +			if (test_bit(cntr_id, d->mbm_cntr_map))
>> +				mbm_cntr_event_update(cntr_id, index,
>> +						      mon_info->mon_config);
>> +		}
>> +	}
>>   }
>>   
>>   /**
>> @@ -1805,6 +1853,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
>>   	mon_info.d = d;
>>   	mon_info.evtid = evtid;
>>   	mon_info.mon_config = val;
>> +	mon_info.r = r;
>>   
>>   	/*
>>   	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
> 
> If I understand correctly, mbm_config_write_domain() paints itself into a corner by
> calling arch code via IPI. As seen above it needs resctrl help to get all the information
> and doing so from the arch helper is not appropriate.
> 
> How about calling a resctrl fs helper via IPI instead? For example:
> 
> resctrl_mon_event_config_set() {
> 
> 	resctrl_arch_mon_event_config_set();
> 
> 	if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
> 		for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
> 			if (test_bit(cntr_id, d->mbm_cntr_map)) {
> 				/* determine rmid */
> 				resctrl_arch_config_cntr()

The call resctrl_arch_config_cntr() requires both RMID and CLOSID. So, 
we will have to find the rdtgroup here (not just RMID, we need CLOSID also).

Yea. I think it can be done. Let me try.


> 			}
> 		}
> 	}
> }
> 
> 
> mbm_config_write_domain() {
> 
> 	...
> 	smp_call_function_any(&d->hdr.cpu_mask, resctrl_mon_event_config_set, ...)
> 	...
> 
> }
> 
> By removing reset of arch state from resctrl_arch_config_cntr() this works well with the
> resctrl_arch_reset_rmid_all() that is done from mbm_config_write_domain().
> Even though resctrl_arch_config_cntr() contains a smp_call_function_any() it should
> already be running on CPU in mask and thus should just run on local CPU.

Ok.
-- 
- Babu Moger

