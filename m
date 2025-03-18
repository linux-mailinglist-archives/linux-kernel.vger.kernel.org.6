Return-Path: <linux-kernel+bounces-566062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5442A672AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82768422198
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB8120AF64;
	Tue, 18 Mar 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q0hjCxh4"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437F205507
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297158; cv=fail; b=Sox2rzFVSb1jLfYsGBOoEWQZLvJtwQybJjsl93E+KJPACu0KxKCLLrpfHtEOe+R+yzGnXVJPeVdgLiNIyZsaKFMRPeSCYu01SxcMf4Hv8YnKhgy9DUG60laL5LTA+xG4YSlyltCbGcJJu/gaubKvSYBMzI51XtvXS/BJxwXpWhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297158; c=relaxed/simple;
	bh=6OeRATPAZrI3nJwskZ3mey/ngyR6Vyy8uW6kYyGXmyc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GOiQLZnOSif+WOzuwzjaORYOVGvn8xeus2AUybrr+hua5jTnqJBgfS+M+lgTAIJRBtGGfWcocGQmaVUArVDooHsQdie5niAGwnjNPDpKfHYcqtwQGOgMfjc3rdEMWev3UBFzI4X30UTHmQw4j/EXJXqx1DWUTf4dpatStLQW2LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q0hjCxh4; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJeuUwxaQTLEHQJ2YtG04YB9RfYGCtAI/fCBgw82eZ2hzFuXjoWlooB9MdYraqnKcWkCEUptN5pO3Vf9oDsr6eSQ4ik1mCUE2HwZGZgkwc6LE9wGE4sEuLSPzEJ4T6+QE3yA0Idv+JNNiDAO9avhp4tond7q9rNH/HtuWXqqNbks/fYv3Ww+4XCBplF2KWMH/+6hneqJGa8LJY9YXE3oRkVNPYcFYrc94yHMipYUwJYIwaKJSYKozCZ4otRESTRYaME3Q8lM0WwmiM0xTru8hJxM25DLoc/9tpCmGXWJmuAfE0kdlZS65vOUohMA61V6yKhlCgKMV545qxXLxGmNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUnQSru0XsLXzsMeozq0OPgVh8ujRfgKt2tLEjYLXDw=;
 b=OQbVuJTNxwUI3JfS3ChA50IAe0jH0bXPF7BRk2VrST1IvUap8DmYVg806rDGyuLa9jfaz+YbniS0WPIK0df0G+bxN2SOKI8mRYD3GugV0D99wr/sNV/7ykSc2MwrZGwR/Gl937YzSiEsDqksq2EyTdoweL5McXsGaVklH69CK+u+y4QQHR8MOP8Sf26RI6KSJcD5gh3nY7nqJjEV3tSq53XEk95NeKIXFRbvR9TP7i9h1lEEUSX0PZRLKpOJgk2ZIgtwbgz6aYr4po/5uX5EyAtwU5WoG01n6Tn56qcYICujv7lTZlyL8WQAj9NPF8zVvuOsftQBcXymEyCY8GZp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUnQSru0XsLXzsMeozq0OPgVh8ujRfgKt2tLEjYLXDw=;
 b=Q0hjCxh4AF8/gehB65A+pmRmj6aZV3+w3tijla6ci219vCcS3wXQmkwsa+g6Mx2TzpxMAnya61Uc6kDOn93kt3JP1evrYDjUU2NFc/6xLCWblu5IhQfXW11J9QCBP6HO9+qvOeN78Er5olNwsMWcTyyhGU9wZovhraTXr/OV8m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:25:54 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 11:25:53 +0000
Message-ID: <e7614b27-e9b4-49a8-831b-0acd33911336@amd.com>
Date: Tue, 18 Mar 2025 19:25:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] virtio-gpu api: add blob userptr resource
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250228053650.393646-1-honglei1.huang@amd.com>
 <20250228053650.393646-2-honglei1.huang@amd.com>
 <cd9f85a5-0d99-4007-bba2-d792ac9d84da@gmail.com>
 <c2d1334f-6f5a-493f-bbf0-3e92789f128a@amd.com>
 <CAAfnVBk-JJKxJXAstwmgL4=EM15RHfVm4NQST+p3nE4xi2220g@mail.gmail.com>
Content-Language: en-US
From: "Huang, Honglei1" <Honglei1.Huang@amd.com>
In-Reply-To: <CAAfnVBk-JJKxJXAstwmgL4=EM15RHfVm4NQST+p3nE4xi2220g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aec28c7-88d6-4770-e322-08dd660fa4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzgzUjVBTWVWazdnU2VnR3NEaVZoeVRaQzEwUGRhdHg3ZWdTaHZRYXhRQkZE?=
 =?utf-8?B?c0FJSno5UE9vc1REdVFpZEtjWkI5T3ovd25RRmpPbW1RMWdoYnN4QWxpM0RG?=
 =?utf-8?B?SEZNS3BlNUZjb3RReUdLakJLb05OWDZ6OE00Rno0SHBQNThHTzVrMUZQQkRs?=
 =?utf-8?B?RzhGMmI4V2JzZmtWdS9qUzhzMjAvTkQrbWVzK0RTdkhoa0J0eXd1QTZ3OHAv?=
 =?utf-8?B?UHlQWnhtcitmTzd0UXhBYTZHZWVaVmltTTV0cVNIWU1CSGE3L0R4Y0ovZTRk?=
 =?utf-8?B?U0EvNS9yQlJXRHZRdVRoMVh2bHJOUVJ4Ylg5c2RTank5YTllbXNaSnc5c0ZV?=
 =?utf-8?B?V25waWxzQkhHdU5kdGxQK0RIdnhEVWk3NEwzdnBvdTJmLzkyWHIzQTluU3Y1?=
 =?utf-8?B?a1EyQjFQd2psQUc5K055NUNzSE42em1SejNqZUplOGlnRGlDK0ZOWHY0aTBs?=
 =?utf-8?B?cU4xVFA2blFrZTlMMzBrSng4UHc2NmJlSDNadUtUM2NiV3BPR3VvV3RFTDdB?=
 =?utf-8?B?ZXlZOG9Edk1PLzBzVEszdUdnNmV5dTBQZFFIUE9xQlkzSUx0c3h0YmFiV1dE?=
 =?utf-8?B?c09xS3kxbHIwUFdwbEFDNkdaSmU3NTNmT1J3MTM3SVM4b2crUlJoNTdLNVFz?=
 =?utf-8?B?eHhCVlZTaG1IVGhxdjZEZHhJQWdFVTdvREg4QXlPMUhXL1AwcnFDOHZqOTlL?=
 =?utf-8?B?OVJYUGhSVXlNWHVqa3l3SnFZVm1lSTVvV2wybEFJNHpRVVJGc01va2FzaWpr?=
 =?utf-8?B?L2Y3cldaY2NuNnNGM2VUSk1udG4zSDNOc3pROXBucm5YVGhQTE9zclFxMWI5?=
 =?utf-8?B?MllyQytCcnZCNFMrcG54T0JyZGt1Y29kVTFqMkhqOGVoWFFSc2tHaTNxOWtw?=
 =?utf-8?B?d1FOS0JuM1ZMckNOYnNKTnBmVklOVFowblNWdnJ1bE1PTFlEWGx3ZUcwQUFB?=
 =?utf-8?B?QWltNG9QNGMwM3g5WmhpWjVIbnVpYVNNamQ2aFltMmhwV2dMczhjK0IxbTll?=
 =?utf-8?B?VjREUHFBbEpQTkVGTk5kS2FsS2hNdEZXNDZTV3dQeUw2QWpjbFEzWE53UHFG?=
 =?utf-8?B?UDRNTGhXRjFwZ0tFa0kwSUVEazJNQUlhQWlYTjBLZTBXOS9TTDJndkpYTmFn?=
 =?utf-8?B?WUFicTlRLzFZaE9QTkRUdVpGcW8zV2VRSTVqdGM1emloNjdhMERHN0RFYysw?=
 =?utf-8?B?eXVyYitIdlBJOC81dUxBNUlhUWx5YlYxdkllc2JLK2FNOTZZa0k5TndQczYy?=
 =?utf-8?B?aEpyZ2FlZmJzNnoyQUc2TllCRlEvU3QzT0tvRXNrMkRwdEUwQVZWRHpWUXRl?=
 =?utf-8?B?QVNra3hxRFJ1RmxtY1ROOEhOOHlHRjRya0V4a0d6RmNPZmR0SDRSZHdjNFZQ?=
 =?utf-8?B?eitvc01ac1dRbDlldG9xa29BYVJhU1lBUy8rd3Rld3hPblQwczBnQXpDUGly?=
 =?utf-8?B?L1hVQW1sTmxSRy9hYS9odmhBRlgyYVA4dTFWNktRTWtZOXY1RitKYk9yWXhB?=
 =?utf-8?B?bnF1d09DRU5ob3JqeWpxS1BwZ3BLbEEvR2paYmZrVVJKUjI1NmUzMFA5c3ZI?=
 =?utf-8?B?UmVObkJNeThBSUVudEJtaFV1ZGFnaDlzS252L3dnNm9aTlNEdUxQMkszUllD?=
 =?utf-8?B?ekpZNzVOYzRQY2g5SXYzVmVYQ2ZBR1BiVW05eE9KWlZ3Z0p4cHpubFZTZFZw?=
 =?utf-8?B?YUdzTjZabEtCMmZsdHRVUkxWd3VRak5sWTZ2L0h2eGRlOERNa0lNcFJqWnY3?=
 =?utf-8?B?K1F6SFJtZ0x6QW5xazNLUFB3QXRvaUpPQ3pELzFBbVkwK2prNWp6cURUUWRn?=
 =?utf-8?B?YVY4K3hCTEYveWZKWkFnN01zWWlhT0NUa2FLYnFuVHVlay9BM21ueStOaGVz?=
 =?utf-8?Q?D/x3OwEK/4Yhs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHZOdm1UdFRSaFJIM2cwSno5N3ZlN3QzRDJGOFpLUjJBOVVyYStjenhKQ1dC?=
 =?utf-8?B?RmxFcTNWLytReG9kR0JPcjRHVk9yRFRKVlpFbjd0OGRIRDdRNkNiRGNBTkFw?=
 =?utf-8?B?aEtOMHk5WVJPRFRROG1sZTNpMkx6RGl3bUFZckk3T3VRNkhrTVNONmM4dS9u?=
 =?utf-8?B?Skxla3VGakU5VXc1UGZpVWc4NmxvcTJ1WTlzRUdzUXVabHpvTDllYU9lckNj?=
 =?utf-8?B?YmFtZXNFZFIrSnlIUmswWmRvTEZ4b1MrZzcyMlJnWDFldDdhOEI0V05qRW1s?=
 =?utf-8?B?eFR5WDNqMlhYQytidHQwVWk4aVRoSldKclM0Q2RLc1Rja1ZPK2dTSG84alA3?=
 =?utf-8?B?UEM0RkRLd2x3L0U5RjRNYnVZbk1ZQW5VWlFFZjZUNkx2VzhtN090dXdsUkNw?=
 =?utf-8?B?MG9jTWMvYkQzNFlkTlNUOEppSXkwcFBZOFk4N0F0U1l3a1JjbWppK09EN1lF?=
 =?utf-8?B?TTNmNXliaE9PTkZtZWx0OWlRVm9vQmJlNU05cGFHQkxSNkUyWi9pYW04anhS?=
 =?utf-8?B?UXNhTU5qSDQ0akRJMU0yVzdETFlQQ2YzeWZkSCtCOC91NWp4M3h4SW8vSm9m?=
 =?utf-8?B?dmdrdWh6Z0FIYXo3WkhvK1A1UzRzU1RET08wWDlaQmlZREJNc3pVSTNXVnlI?=
 =?utf-8?B?dWNoYlpEQ25YUjBnN0tMbEwwMW96LzhMbHZ5Sm5ObnNoOEppYWtkNm1Lc2xF?=
 =?utf-8?B?cnkyR1U2M29XSC9Lb1dodVA5bnREOERCdXE4UTNsQ1JRaUZUUHIrdVhJTCtL?=
 =?utf-8?B?OWYvWGhmb2xwZUhPNXRYdDltbnJ4Y3ZjSzE0KzE5dEwyYW11R0dWa2x2ajZC?=
 =?utf-8?B?VDNpMEd5YUR4MzkzbmNHS2o5bnY1ZFdFSXFtd3FSdzQ5WWFpaSsxOHJnempm?=
 =?utf-8?B?TWpoL20yNHdTdGljT0Zvc0FPN0prT0kzKzR2REM4Y1MzTkpucThvS2M3dDNj?=
 =?utf-8?B?dk03TWQ3OEMvb3REODZBZTFOKzZsVWFLdFJrWGFkMHhRTHd1SXdjZDJFdndN?=
 =?utf-8?B?ZWFIZzVSdEZOQmthRjZ3dUlHTFFmem4xdHRJYSt6S3ZWVklmV3RoNFdMSUdN?=
 =?utf-8?B?c1ZJZy9YYStWT3EwdXFYY0NLOWxnTUlaalU4bUpoUlhhWmVpb1lCeDg2dGhj?=
 =?utf-8?B?b0ZYNzlRS1NHNHZrL1FFQzBHd1hUUU1NUHZ0bHMxODBobEczd2tWL1FPcEZn?=
 =?utf-8?B?bDlQZzkxZm50VUtiRVhDZFVmd25NdzBOa2lLenZqOU1wTW8vR1hFY0lFK2Vs?=
 =?utf-8?B?QlFCV1NQYm50TzY4MG1VQWR5UzV4T3VXRTA1MGtxNUFtWkVLeExjKy8wa1hS?=
 =?utf-8?B?NmlTeDZJanM1VFJhUkIrZWFYM3k0MU93QWlQT1dSQlg4WE42a2cxL25SYXpP?=
 =?utf-8?B?dk9SKzV1Q054VEVDNUNlK0VldkI2dTMwaXF2Mk52Mzh2d3VGRjZrd1JRSFBG?=
 =?utf-8?B?SlZyQnJ4UTlQRVFuSkJrYWxEQ21QUWhRbXUwZllNSTl0STRPK29VNDJaWHBJ?=
 =?utf-8?B?dVRaaERreHJmNVozNkVWSlpwdXN5U3NpQk1VaWtLNFg0Z2h6TXdpTzEwRmhm?=
 =?utf-8?B?M0hYS3lTbTI3cytlYUhrMHk3RkVVbUlEbFVrOHJCN0U2d2xPZ09jdkV0aXFh?=
 =?utf-8?B?YUdzZmZ5OXBPWUMvTXNQMktMZ0ZiNDNkWHpzYkNIb0p0SnVHMVovOHpUQXJa?=
 =?utf-8?B?cmxKV3JPemhXQ1p0QmE5eHpnR29lOW1SSmZJbmc0VEhMd0kvREJBRXJFQloz?=
 =?utf-8?B?SmVRR3dURWpxRm5xUFNLTTRhenNlOXBMTVlkd2t2OUNlSkMwZW5NZ2FmVUQr?=
 =?utf-8?B?QllDMTBiWExtcnZpR2JsVjNPLzNkYzFnczFhVTBsUUFyUEhVU2krcCtsOE03?=
 =?utf-8?B?VytYOGUyNkNVajRtcTVvY0I4VTFhWmR5cElDaWc5MWttMCtLNUFraC9USG1x?=
 =?utf-8?B?azRQRFFkc1ZkNmxrZU40OG5oS2lWZDlHT2NoM25sdkdnSHpBSkZvc0hiSTg0?=
 =?utf-8?B?VTgvTTRTbVU4SGFuQ2x1UGZFN1BQbkFWQm5uS3VXTDdOcVBQMWw1VzJMQmYz?=
 =?utf-8?B?cE1RMHRSTkxISkVMbUUzdnZtY0o5N2dqTlptdkl5N2l1WFZrSERIOTVlTHB1?=
 =?utf-8?Q?z8mlyaT7kfPO/pMkQL5ESi7b3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aec28c7-88d6-4770-e322-08dd660fa4ca
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 11:25:53.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzHB0O1XcaZkO0aVdDIBMqFb+hpdssAB9vNiLunW4ALEO0hYas9fbiMj14n0M946/U8b8E4v1wCZS2pYINZ0zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320



On 2025/3/18 9:37, Gurchetan Singh wrote:
> 
> 
> On Thu, Mar 6, 2025 at 2:52 AM Huang, Honglei1 <Honglei1.Huang@amd.com 
> <mailto:Honglei1.Huang@amd.com>> wrote:
> 
> 
>     On 2025/3/1 5:21, Demi Marie Obenour wrote:
>      > On 2/28/25 12:36 AM, Honglei Huang wrote:
>      >> From: Honglei Huang <Honglei1.Huang@amd.com
>     <mailto:Honglei1.Huang@amd.com>>
>      >>
>      >> Add a new resource for blob resource, called userptr, used for let
>      >> host access guest user space memory, to acquire buffer based userptr
>      >> feature in virtio GPU.
>      >>
>      >> - The capset VIRTIO_GPU_CAPSET_HSAKMT used for context init,
>      >> in this series patches only HSAKMT context can use the userptr
>      >> feature. HSAKMT is a GPU compute library in HSA stack, like
>      >> the role libdrm in mesa stack.
>      >
>      > Userptr should not be limited to HSMKMT contexts.  Userptr can
>      > accelerate shm buffers by avoiding a copy from guest to host, and
>      > it can be implemented using grant tables on Xen.
> 
>     Yes, I totally agree userptr can accelerate shm buffers, but I currently
>     don't know if there are any other projects working on similar features,
>     or if maintainers have any opinions or better ways to implement them, so
>     I temporarily limit this feature to HSAKMT context only.
> 
>     I am waiting for everyone's opinions, please provide your thoughts.
> 
> 
> I wonder if you can emulate userptr using udmabuf on the host-side?
> 
> Essentially for the guest, it'll be a malloc'ed memory, which means a 
> guest sg list.  We can convert the guest sg-list to udmabuf using well- 
> known mechanisms on the host side.  I hope amdkfd can operate on dma- 
> bufs too?
> 
> I do such a feature that would have a more generic utility outside of 
> HSAKMT contexts and not rely on Xen-specific grant tables  ... 
> checkout VIRTIO_GPU_BLOB_FLAG_CREATE_GUEST_HANDLE in crosvm for an example.

I think userptr can be emulated by udmabuf if the sg list is from guest 
user sapce and not moveable, amdkfd can operate dma-buf, and the userptr 
feature can be achieved by partial functions of dma-buf as far as I can see.

But the udmabuf need managed by UMD, this will result in some 
performance loss, and we are planning to implement virtio GPU userptr 
using hmm_rang_fault, udmabuf solution may be completely different from 
this one.

I saw the feature VIRTIO_GPU_BLOB_FLAG_CREATE_GUEST_HANDLE is used by 
the crosvm in beta branch, but I can not find the kernel virtio gpu 
part, how to access it? Maybe I can try or help.

> 
> 
> 
>     Regards,
>     Honglei
> 


