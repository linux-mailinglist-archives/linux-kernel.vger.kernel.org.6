Return-Path: <linux-kernel+bounces-524102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDA3A3DF32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A417517F119
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B4E1FECCE;
	Thu, 20 Feb 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gXug/uja"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020113.outbound.protection.outlook.com [52.101.189.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4761DE3D9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066432; cv=fail; b=Pmv2fW2J6wqP3Glxj/qyyrfVcJJDMnX3LqAhm0y6OWl0Snx1MwgYH6yhIoOf429fjcYVMGtRjwm7W3Nb+p/Zb/Ccy5vNeS0BupaG2RUoKxECMXcitJ3wL8Sml5Uj8W7xta3Lnui9T2J0JiTdqySKUQTEayHT/COWLf/4Q90jtO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066432; c=relaxed/simple;
	bh=DYp9pPqUAERr3z+ZPKE23pIkwIT8Lj732YZ9xA6gDfc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ao03TlpkVOUXVpkA8nEGTiFiskXCaCCoyawAWa4tTN+Ye7kocE6ORwWeTFm12JbzZB2UbRWDLiG4JWRFNd8lqhVzHL8qJxPL4escM7ViMq9xfIjTzQgxYgtOLpRIj1Py/kVorK0I83sK0kz523mcx1MRgdSH08hfYaQexrRwrDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=gXug/uja; arc=fail smtp.client-ip=52.101.189.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSkPsTMzTL+G5Don520wGvwgGyCOB3RgrYy9e3IBfW5xJjg1EIM7IklPLzzbIPSHNffGR00/UmVRb32UeN+N5p5LhYQclg/yBlxMSrJyW5s4EDdi0FdeAFvujYVQYPhMlol8Cy+5X4ZexUyUxN4pX2zKuYAQ0qUkVmy56cqSEK+bBnfY2vZwLaCG9GrC/FWQktLaGiRfS7xhdmDspX9aOwgBs8/7zo14QYv4Kutkt7UuPlWUta9X6lcL+6wnzHx9YtRH2YDSvAs0g7F2f24GwaNz2eG7QgSH/+66DZJ9//hFMh2Ahqmd1HNxEl0r1Gin4q+BncLypL+ziVG8ZbcNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJK/XpRoDRiNnfgaoyMfOv0KhhtleLuxwHBDQ5M4DmI=;
 b=Wx0mcRIngx3iESFlP8gYhjf5i3L49mDzvyHp8ooNdxaiaLeTckrcFr/x/esw4PxMlHkpzDb0k0BB+gU379WRNCuMvwfRGthX2zNa7VBaftx4y8N84oU+hy9aA2uV2WOpv3DNMHlXZ8LN71HkLCka7MyPWcq8f4lG9JGlxzLnoCwKbtuaMwq/3ZMjasA5AijOqGyV0C8Ev9wH9Inna3Jt3+ELh+CHueYXg62IBRZubB2gR7eiO/TdVc8n9ySsNtFblanxt6S9PRvKM0cI8rRIx9/BgkN4ueyX6mtsoF/UNumJkt34o11z3CuxFmRHVe1MReJ+sXsrtp67qElD+JGXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJK/XpRoDRiNnfgaoyMfOv0KhhtleLuxwHBDQ5M4DmI=;
 b=gXug/ujafYWtFgLLZ6LofBsPC0kXnWiBpVbD9bXSntdsHq4SOuJJTKFwqmilQcnHtBJ8GmlB+Ng+W56yTkJcH1cgwSNpRuMQqrt+8cUJyyu7bhDrQBJHS5vC79ZU4sMInrNO2h6Re+x3kBXKBD/rGHRfr7ATtTd+5wXiq4nsw6EwI/gK4zCkXIdLweago+b99FblGWmvV+HA4grJvnfz7Q7F6a8jAMvf32v8gi7mAzrYDa4PwVQP1uCuqML8DmiNSe28OZXVaYgGHsKZ7loYNxkVSHke1NSLG3m8xudjFdsF6VAPKrQgP6WC4NGu8zzQ4tjFrcBH9FyVbIHzEO36fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPFF9B425E0D.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::5ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 15:47:07 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 15:47:07 +0000
Message-ID: <6b542d40-8163-4156-93af-b3f26c397010@efficios.com>
Date: Thu, 20 Feb 2025 10:47:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] sched: Move task_mm_cid_work to mm work_struct
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250220102639.141314-1-gmonaco@redhat.com>
 <20250220102639.141314-2-gmonaco@redhat.com>
 <c9026605-da1b-4631-b0dd-68ae0700ec87@efficios.com>
 <ebc70e9e9ad4a7055286d0db93085536ed070a6f.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ebc70e9e9ad4a7055286d0db93085536ed070a6f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPFF9B425E0D:EE_
X-MS-Office365-Filtering-Correlation-Id: 082a0f3d-22a3-49fd-c735-08dd51c5d4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk9ldFpiNHlqcTdWOWxCdDJoRlBFenBjT2ZhTXNHWXpqdjR0MTlDV01XWWpu?=
 =?utf-8?B?ckJVeXpZUEdZbks4L215NWc0ZkJYc01iSmpaRXAzaFlSdk9ELzRLN2JWM1ph?=
 =?utf-8?B?TVNUazFldTJzekFUV0p1Ly9kOWZSbVRnUXhVSWNPRWE3WDRaL1JKSFpSZmo3?=
 =?utf-8?B?WmxETmN1Z3BndE84MXpJaUxyL0JJUUc0TVBnR29XZkl0L3o3YjdjZzNySUM2?=
 =?utf-8?B?TUUvYlpaZ0FXOFhGb041SVdSRkllVDZNWU5WVjVUQ0VGcDFUZzBYTTZsS09y?=
 =?utf-8?B?U1FpajVPaFhMWnRRQWV4TVEyKzF5cU9UaHMvUjFLYkdpN0ZzMHZZa1RTK09Q?=
 =?utf-8?B?eTdXbHBGMzFWQ29UdnVxUnc0aFFZNTFobGpjeVVyM20ra3ZqT2Jjb2MxclRk?=
 =?utf-8?B?S0VRak1EclppT2NZRnkxVkJidnFTT2E3NXZ0V2FuYnF0aWxBUS9PZkZoS251?=
 =?utf-8?B?anZZbGpHOXRpSmhyeHNMQUFUVTlQbFRPVDBodjNBM2JHbjl1Y2NGbzZJOTQw?=
 =?utf-8?B?MWJQaWluTkNoWTRNakM3UGNQYjNONU9vaGhyQ0pyYjNVWEpiMlpUVnkwd1Y3?=
 =?utf-8?B?aVJ4NGJyNnMydWFhKzJrQ3pwV1h6Vk1URXgyUDV0MVdCT2hyTWR0QmpKVUFk?=
 =?utf-8?B?ajM2RS9Bb2JPaU9VMlF0VUQ1SEZSZ3Vuc1FkenRWc2hnSW9MWjJsVzBheWtP?=
 =?utf-8?B?MHRuZnE3WlFlajdSdmR2VUFsRHBXenBwaDNVSkEybDhnQVNHaEpqN0MwaWo4?=
 =?utf-8?B?R0QvUFVSWjRHODFQRGxrdE1wTWtJY0UyU1dOSlZnVXpNbWU4WHJHL0s0VkFF?=
 =?utf-8?B?VmJuZG44ZitYbExVZTZHL2lYa0JBWGI1aHJLV201WGJyZDc1U1pDNy9MeXRr?=
 =?utf-8?B?aGh3WDJOaW95Ky9xa3pWeW5SVHMvQUMzVndpRnhCQ2Y3blo0T0NkcWRFUURn?=
 =?utf-8?B?bUN3bzFFUEFhTXVRU0ZFbTY5QWFhTFlkT2gvci9lK09yaURHRWJ1UTFTQkZl?=
 =?utf-8?B?K3NHaUJSTExrbHd3VENrcXcxRjQ3MEszQ0tnR2ZvU1grQlM0UHczSzJhcUlL?=
 =?utf-8?B?cmlKdmZVTGxPTEM5Z0JKTVg4ekxoUFZwYkJ0RnM5Q3k1dGJtWmJsZWZ0dEtz?=
 =?utf-8?B?cTRwWjZ6SjE3aE9mekFSL2tGT1lKMkRhTVMrT2NLcDFvbGpzaUFqZGlGRVFz?=
 =?utf-8?B?Z3JIMnRvY096azV4S1RHTzJDUTJBZnBBN0hWbWJYd0dIQkFoREVFbGhTcTQw?=
 =?utf-8?B?bURldnpiUHNld2lhMGVUa0hCYlhic2ZBNG10NHdXeldOM05Gd1dCNmtpaTVV?=
 =?utf-8?B?Y0Z5Zy9maHhoQ1hTaXhkbmtGRGdwTkIzQ0duOWJBazdwWFV5Nm9qS3pNSGt5?=
 =?utf-8?B?NEQ3QS92ODNBTFllRWhDWDZZZW1zd1MydWJnNzFadC9ScVlmckJ4RncweHFD?=
 =?utf-8?B?aytZczJwa0dCOE9JZ1UzaFJUZjZCV0h4akx4NHk2NkZ5UWxvb2lxSTR4TWdV?=
 =?utf-8?B?SlZTd1kyMTNwZnZsYjV0UGJhZ0ttNHlIdWNTVE12d2pkZ2lSdjdJVWV5ZHhS?=
 =?utf-8?B?OWIzZ0lOdFgxUURpWTduRVNxVk5RRUZsYjJVeDg5VnM3YmdtVGtNcUoraXBY?=
 =?utf-8?B?WWdPOFFZRjM2RDFWWFIzMjNHM2d6bitPejlQUGg0enBPbzNrb3Z1QnNmcEU1?=
 =?utf-8?B?NGNZa1Nta2FNZUU5ZnFQMjdJZlNLSjVqYW9EWVpGQTJBaGNIQkNzZzkySndR?=
 =?utf-8?Q?ch/rJ3QwIclBlC8s2binDIfhO9TD40deVb5TRjh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L05CWGFHUk1PSWgyc1piZGZZY1k5SXpNRG9tS1MwenN3YW9jRlliQU1YaE9D?=
 =?utf-8?B?dnFBcmtMb1dwSnFtak55ZEsxQ1hoQjZRSmlmU3lDM1BUcEJaaUFranVya0pj?=
 =?utf-8?B?WlNaTGZCbC9QeWxka0NhZEtEV3BPNmprc2ZnNlE2cWtxVTg1UHlveDhMNE1F?=
 =?utf-8?B?M1hPT3pWV3BTdmlTZlNYbjlacEUwUTJuZVRJWVd4OGlKYU5mMTNCSms4V0Ex?=
 =?utf-8?B?ZHE2d0R3b2lST082ODdNSHdkZXZwYmN2eFlTZHFhSXVPSSt3ZjFER05zemtx?=
 =?utf-8?B?YVNXdHBOTnR6cVIvYUY2NW1zVVpta2xValRBS2wvWm0rcGkyUFVsK1hZOEJr?=
 =?utf-8?B?MWdydUhqU0ZZelBKOCtDbnRYUitxWG91RDZGdlhYQjUyMXZpNWI0UTk2RUlo?=
 =?utf-8?B?ZlFiVThzUEo1ZnQ2N202OC84dnhCWWpzVjZ1VG1ta0RqOEZHNmNkMEc1eVJj?=
 =?utf-8?B?ZjlhREVRNkttM3lqR3Z4c01Dbk5pTCs5SWVqTHpORDRzSUsxcDI0dkdzVUxY?=
 =?utf-8?B?ZmFxYmJxbnNqRTV3N2VlTmREMk5yWVFVenhaVFh5c1BBejE0bXQvZHk3M2tN?=
 =?utf-8?B?TnpvMkdIK3BLbW00TExKSmlvNEhnVkx4M05GYS9CbGdFOWx3MkIzampiZzUr?=
 =?utf-8?B?V2JZcXJCUkh0bWQvZkViRFdhMDN4bUE1WlNFVWFUN0REQm1JdjM3S09KQmE1?=
 =?utf-8?B?dHJEVW51SGZISkdDWTFDdURTMXFSRXprT3l5QjNqM09YZG9mcTJsb0NVM045?=
 =?utf-8?B?dVYwVGpORFVPbFZkeTAwUkIyb0FEbXF3Y3FsZmZ6dUE0YWFIVVpxbWU3dUNv?=
 =?utf-8?B?RHlZYitReEZuTGJZaXVkRlhCdUhlYlZaTXlsSjE3WWtscGErT1Z2Y21kQ0d5?=
 =?utf-8?B?S0NvaE8wUjdncEc2Y2J4SGJUT3JiMDYxWXpENTNtOWZTZ0IwYlIzUWJ1Q3g5?=
 =?utf-8?B?bnFQSzhZMVBvcXQxSW1pYjloUWs5cUpDZCtNVFZldmwrL1lkL2s4RkxXcVlv?=
 =?utf-8?B?UEgwZTBCSG1tTW9kVGtoZXNub3BVbVNNcmZzeGV4VHR3ejFub1Fqd3Y1VVpR?=
 =?utf-8?B?OTM4MVlFMzlTM0RsMlZ4TlVXRjhBZVBJcXJRV3p2cHBrYzJEZ3p2VDcrZkxR?=
 =?utf-8?B?a2RRKzlqcXdlR2VGY0RaZTFCVVVhUi9iYkpNYzNNckdBanBvcTdrQXYvMm01?=
 =?utf-8?B?c1oyeU1ZZzZ3VGJweUkzejhOdUdsbnlyRlFRVnRsN2JnaEplOTBTMEpXWnhS?=
 =?utf-8?B?dTJWbWh1ZmpOS1AwbG41UllXd3J6S04vQlNyT29CSjR0UEwzVGdmaDAvK2ZL?=
 =?utf-8?B?Rmo3eGdnVUQ4UmsveXY0V2ViRjRnS3ZZRXYxUVVOUm4xSHkzNHp6ckdkbHYw?=
 =?utf-8?B?K3RZaHVCb3FVVTNFK0h5UG5yT1g2dUwvaktxSWNhSDFhVHoxeEw1cVZLNGFC?=
 =?utf-8?B?Y0ZmSDZhNlIwWTVMS0hLQkNFZkZ1M2ZEQitUSnBhWEh1c1ROSkYySlg5UHJr?=
 =?utf-8?B?Yy9vWEswbkNCT1oySGpRNXl3T2d4N0Z0aGFGbStoeFB1TUFZU0xZSkViTzJ5?=
 =?utf-8?B?aXFuOHVJa3FXQ09OUDRTdFZTV1dSU3NKMERIQTlIUnY0eWg0WnZDeGdpZFBS?=
 =?utf-8?B?MDgxaG1mUEliT0hoMk9rWVdkRURyYytadHNrYUNITTlUL0F3OHgvRHpMNWZ1?=
 =?utf-8?B?aEtOLzBHdDZnR2JHQWloZ2x5d3QwTTgzbTlkOGRLL25IcjlLSFFFM011ZHJS?=
 =?utf-8?B?eHV5UUZzdm5sRGo3Ny9RWDlqQUlEY2FKK2ZVWTdyaFN2LzE4TzhweFdJb2V6?=
 =?utf-8?B?N0ttdTF2eVFEdEV4aFl5azh1VGhjK2dKb1IxUHVlZ21pTFJjMmd0K0Fvamw4?=
 =?utf-8?B?bjdZeVYzTkNHblk0Y2hqLzRReDVGR0JGYkt5aVQ3YlVWeWVkMzJROTh3MTMy?=
 =?utf-8?B?MEFRS1BXdjE2Q3NRckR2NElxZ213Q0hsL29xQjFoV3p5VFh5dFZ2MGh6aGth?=
 =?utf-8?B?WnBkRDI4RFhzTDhaMFNyRktLTVorU1hMOFVmdWp4MkhiNjl0UXJWSHd4akVE?=
 =?utf-8?B?S09tMk1lWFYwZ3hWc2lxVkZHL1orYXJxSVhiYjR0eWlYMUNVelJ2WHQ4Y0I2?=
 =?utf-8?B?dTZCUGhPbUVnbGd0TjhDWmVHbHNTTTNEYlNKdFBDVWN4MWdpTHFpN1J3TmM2?=
 =?utf-8?Q?xmnDzk11CgorX/pl9QwAGxI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082a0f3d-22a3-49fd-c735-08dd51c5d4c9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:47:07.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogypEdZgRIJbhI13KzmDi/CFIcvdSpNYd1sZ7uAxVO/viXVzy5TSGU2fcxEXT0n2shE3gY4UXPgHR/we5oXUwxoIIifTLJ0U4tFww4XFNCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFF9B425E0D

On 2025-02-20 10:30, Gabriele Monaco wrote:
> 
> 
> On Thu, 2025-02-20 at 09:42 -0500, Mathieu Desnoyers wrote:
>> On 2025-02-20 05:26, Gabriele Monaco wrote:
>>> Currently, the task_mm_cid_work function is called in a task work
>>> triggered by a scheduler tick to frequently compact the mm_cids of
>>> each
>>> process. This can delay the execution of the corresponding thread
>>> for
>>> the entire duration of the function, negatively affecting the
>>> response
>>> in case of real time tasks. In practice, we observe
>>> task_mm_cid_work
>>> increasing the latency of 30-35us on a 128 cores system, this order
>>> of
>>> magnitude is meaningful under PREEMPT_RT.
>>>
>>> Run the task_mm_cid_work in a new work_struct connected to the
>>> mm_struct rather than in the task context before returning to
>>> userspace.
>>>
>>> This work_struct is initialised with the mm and disabled before
>>> freeing
>>> it. The queuing of the work happens while returning to userspace in
>>> __rseq_handle_notify_resume, maintaining the checks to avoid
>>> running
>>> more frequently than MM_CID_SCAN_DELAY.
>>> To make sure this happens predictably also on long running tasks,
>>> we
>>> trigger a call to __rseq_handle_notify_resume also from the
>>> scheduler
>>> tick (which in turn will also schedule the work item).
>>>
>>> The main advantage of this change is that the function can be
>>> offloaded
>>> to a different CPU and even preempted by RT tasks.
>>>
>>> Moreover, this new behaviour is more predictable with periodic
>>> tasks
>>> with short runtime, which may rarely run during a scheduler tick.
>>> Now, the work is always scheduled when the task returns to
>>> userspace.
>>>
>>> The work is disabled during mmdrop, since the function cannot sleep
>>> in
>>> all kernel configurations, we cannot wait for possibly running work
>>> items to terminate. We make sure the mm is valid in case the task
>>> is
>>> terminating by reserving it with mmgrab/mmdrop, returning
>>> prematurely if
>>> we are really the last user while the work gets to run.
>>> This situation is unlikely since we don't schedule the work for
>>> exiting
>>> tasks, but we cannot rule it out.
>>>
>>> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced
>>> by mm_cid")
>>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>> ---
>> [...]
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 9aecd914ac691..363e51dd25175 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -5663,7 +5663,7 @@ void sched_tick(void)
>>>    		resched_latency = cpu_resched_latency(rq);
>>>    	calc_global_load_tick(rq);
>>>    	sched_core_tick(rq);
>>> -	task_tick_mm_cid(rq, donor);
>>> +	rseq_preempt(donor);
>>>    	scx_tick(rq);
>>>    
>>>    	rq_unlock(rq, &rf);
>>
>> There is one tiny important detail worth discussing here: I wonder if
>> executing a __rseq_handle_notify_resume() on return to userspace on
>> every scheduler tick will cause noticeable performance degradation ?
>>
>> I think we can mitigate the impact if we can quickly compute the
>> amount
>> of contiguous unpreempted runtime since last preemption, then we
>> could
>> use this as a way to only issue rseq_preempt() when there has been a
>> minimum amount of contiguous unpreempted execution. Otherwise the
>> rseq_preempt() already issued by preemption is enough.
>>
>> I'm not entirely sure how to compute this "unpreempted contiguous
>> runtime" value within sched_tick() though, any ideas ?
> 
> I was a bit concerned but, at least from the latency perspective, I
> didn't see any noticeable difference. This may also depend on the
> system under test, though.

I see this as an issue for performance-related workloads, not
specifically for latency: we'd be adding additional rseq notifiers
triggered by the tick in workloads that are CPU-heavy and would
otherwise not run it after tick. And we'd be adding this overhead
even in scenarios where there are relatively frequent preemptions
happening, because every tick would end up issuing rseq_preempt().

> We may not need to do that, what we are doing here is improperly
> calling rseq_preempt. What if we call an rseq_tick which sets a
> different bit in rseq_event_mask and take that into consideration while
> running __rseq_handle_notify_resume?

I'm not sure how much it would help. It may reduce the amount of
work to do, but we'd still be doing additional work at every tick.

See my other email about using

   se->sum_exec_runtime - se->prev_sum_exec_runtime

to only do rseq_preempt() when the last preemption was a certain amount
of consecutive runtime long ago. This is a better alternative I think.

> 
> We could follow the periodicity of the mm_cid compaction and, if the
> rseq event is a tick, only continue if it is time to compact (and we
> can return this value from task_queue_mm_cid to avoid checking twice).

Note that the mm_cid compaction delay is per-mm, and the fact that we
want to run __rseq_handle_notify_resume periodically to update the
mm_cid fields applies to all threads. Therefore, I don't think we can
use the mm_cid compaction delay (per-mm) for this.

> We would be off by one period (commit the rseq happens before we
> schedule the next compaction), but it should be acceptable:
> 
>      __rseq_handle_notify_resume()
>      {
>          should_queue = task_queue_mm_cid();
>          if (!should_queue && test_bit(RSEQ_EVENT_TICK, &t-
>> rseq_event_mask))
>              return;
>          /* go on with __rseq_handle_notify_resume */
>      }
> 
> Does it sound like an acceptable solution?

I'm not convinced your approach works due to the reasons explained
above. However the prev_sum_exec_runtime approach should work fine.

> 
> Another doubt about this case, here we are worrying about this
> hypothetical long-running task, I'm assuming this can happen only for:
> 1. isolated cpus with nohz_full and 1 task (the approach wouldn't work)

The prev_sum_exec_runtime approach would work for this case.

>    or
> 2. tasks with RT priority mostly starving the cpu

Likewise.

> 
> In 1. I'm not sure the user would really need rseq in the first place,

Not sure, but I'd prefer to keep this option available unless we have a
strong reason for not being able to support this.

> in 2., assuming nothing like stalld/sched rt throttling is in place, we
> will probably also never run the kworker doing mm_cid compaction (I'm
> using the system_wq), for this reason it's probably wiser to use the
> system_unbound_wq, which as far as I could understand is the only one
> that would allow the work to run on any other CPU.
> 
> I might be missing something trivial here, what do you think though?

Good point. I suspect using the system_unbound_wq would be preferable
here, especially given that we're iterating over possible CPUs anyway,
so I don't expect much gain from running in a system_wq over
system_unbound_wq. Or am I missing something ?

Thanks,

Mathieu

> 
> Thanks,
> Gabriele
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

