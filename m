Return-Path: <linux-kernel+bounces-565418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7627DA667B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4540421FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DCE17A2E0;
	Tue, 18 Mar 2025 03:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nth12hSN"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605D4A0F;
	Tue, 18 Mar 2025 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269668; cv=fail; b=e/n84U0MrRPVrLg2uSrYSQE3Q3rCWo3hXJN/a2/9uRJJ8gOlTN5ONF76Oo0U4UxumxTK/BCbbVZYdgv0z0J816mXTtHWFiwcS28hLI/P7iozN8pOxYdqApWvT11eTZQ3ha54Lcv2LwS5rmxvHBXqsGsSVELdl2Hl8/Z0TMx8OEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269668; c=relaxed/simple;
	bh=lJiKcRbNRzpZcz/Fj/EbD52J+z0Hk5G9/9AS+box9Es=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TNLaXAXKcc+4xZxsLIT5zG/pC7Yu2ErKAiZoWdP/Kkbp+5fmCt7MjzAS+syNy5Piu75iHQKGUjtLRFNj/NzjZMbXCDl12MSCZmLV1E6h8VjrJU4VNUU8x8+7Py+ygPN2AkBqd8ZqXOxmZ6E1cGxbnMQrmPk/G7MbpwV3fuOc6YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nth12hSN; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqECAGxaVuKVKCtv6rluaWBLp6OyikQgDHc4EfpsjGDBD9XCVEymVjCHhHQYEdMY//ESdWgi08dOyVR7h6tgs81j6yNPfn3web2IvvGLMwI5INUYsMG+Ge519IZlrakQTVd1qTMzknGi8sGr/EfvKEGW04bEnQOsrYi3ozcLoHi2e7GsAMSKQa+2YJtHBtFikGy9C0hfBC/9sCs8FdklBypfbQcM0SMhPFFvnxtWl7Q/oXS6jUBjw+iaxOrjIwEaI1gih2mkY/kJ5twl7mpuWEmhvcQv/t/RdxXN7iue5K1LaVzk+mIhE1+oIc+YBQzMf2knGXCJ093SJar06j30KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pv2nGEpvJP2WV8BoWFD2WbLP3TaLGsdfSlqoy7OirQ=;
 b=CKRxMvOLII9Hq6cX2pxyMke3HYHxIsSuN6wvnLUBqm6SdS2aIxhrPKVIvuTp+zlPYSE1+/KejXaRwdt5ksnEj7HMwRDPqA4smlmRMwGtaTvcP60t7hxSv5R8w7F2+AvC6cGVcC56douQtF5ov2LUA9cWEQKxodAyX/EpE9CYk9HBeH2EhZ6P077LuUnN5ALjY8bQ2Z+vo+fsYI1B5HiQdbOzUOHna1uhfves+47gsYvYrcd/QvsSU5X6qKTAmxh3AVNubDCa2s51iD6fTEiBLLuA32C34R7pNTyFlG0euf05rS6O3pkQXevMy37VmeSJ4fu1nD5wBj36OYOTieyaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pv2nGEpvJP2WV8BoWFD2WbLP3TaLGsdfSlqoy7OirQ=;
 b=nth12hSNHhZ758ZH7M4WEvW7P/S7R4Zvx5rcc17V1fRd1+wXd7kkoClKo6ont0hOdzeqRGSUqKiAgxLycm0bDoiCMIokthSN97MwjJUINj+Hh5AYbkmHWje5tgEJ+28vbPuwvURimpNwjnvfpj95vWhXhEzM2eqGb2L5HuQEt8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:47:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:47:43 +0000
Message-ID: <1cf0ffc7-5146-451b-ac79-3acba7edb1cd@amd.com>
Date: Mon, 17 Mar 2025 22:47:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/8] platform/x86: asus-armoury: move existing tunings
 to asus-armoury module
To: Luke Jones <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org
References: <20250316230724.100165-1-luke@ljones.dev>
 <20250316230724.100165-3-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250316230724.100165-3-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0073.namprd12.prod.outlook.com
 (2603:10b6:802:20::44) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 5735a367-25ab-4b5f-3f34-08dd65cfa3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3BjM0NSTEJURkpZN0F5Z2M3ZkZsRExZODJmUVdPbktpN1VMTGVBZDBVcThB?=
 =?utf-8?B?VnVMSzVyRnJPM1htditFSzdwSHRXS00vWnhIQ2JXVHNoNERUSWhFaUdFVTQ3?=
 =?utf-8?B?cUFnckJZOFRJM3hRVjNFRUd6OWQ5M2c4VDk2SmxqM1NBNzRPd0kveDBEcTNz?=
 =?utf-8?B?TGF4VVYycjk0VHVPcW5vckdTS0ppQXJWSXNCK1FXSWpOWUJubkcwN2lzTjVq?=
 =?utf-8?B?dS9lRnROVExoaXNhbWFXTzdnTGRGNy92clE0eWgxckdSSCtNK2FMRWx5VDZX?=
 =?utf-8?B?UDJ4azk3cEtycDV2cFlKajd4RmhBUDhLeFNiaEI0VVg4OGtpSjVGdG5zY1hy?=
 =?utf-8?B?UmxIellGcTdlZzF1M2NxamZJOFA5Y3FKVGVVeUVyeDBJR1VZVFBPTVgzcThv?=
 =?utf-8?B?WEVkVDgwQnJTejdJUjhneVRzcFJrM05MS29PMkxheXl1ZlFKNDh5WHo1NlFB?=
 =?utf-8?B?U09DME51TlYyMEsyL3A3TEhHUmFmbkozU3dPY1VzY1ByVXZTSHg5ZU1VNnRo?=
 =?utf-8?B?RHVucGtBOTkycjVMK0QwYWNqYmpWdnFLa0xUZnNFcjI2N0pNNFY2d1JhZ09C?=
 =?utf-8?B?amt5WnhlWDg5a1dEbTVrR0UxaWxQT0t4QWs3cWtQRkJxTFAwMVRXaEMvSXkz?=
 =?utf-8?B?Tk1RTDE3aENiWmVWYUZUM2lFZGNYZ05BQnI3UmtNV2dJQWM2VG1US01qOXFS?=
 =?utf-8?B?ZTM5TTRVYnNGVDE0NXBTRWxkS1dyaTQvVkkrM2pJYjBxUVl2WjYxenVBcHVx?=
 =?utf-8?B?ZE9NNHRqdURvbnZ6UVRDVW5rNGZLT3Q3MkZvYk1teGdydjZpcDVlNkRWejNO?=
 =?utf-8?B?eHp6REdEWEc1RlpIbWJMNWJNaFhUdUI1RS82cFAraVo5MHo3Tmt2MnBXdVlX?=
 =?utf-8?B?SnVOdm5waDJsd3luQmlmMEI4cDU1R3RNek0vTWswKzFpNFR6eDZLNTN4VVJj?=
 =?utf-8?B?TXBpbXJVYjlKemtGVUU0SSs1bzUwVG03RlJhYWJaRk84bmJnODg1U2g3bUc4?=
 =?utf-8?B?OWp5SGFPUWxzZXU0Z2hiMFRYY29UVlQwL1VDM3AralNuSHBzNlRQdGVlVEcx?=
 =?utf-8?B?cFhwNlBXdFdsdldnczdSLytCVTVYbGdTVjVrd2tnbUNQYzNwYW1jMFJsNUd6?=
 =?utf-8?B?elFJd2wwdmRUY3BTVkFKMVkyekQ5M0Z0Rk9TR2ZpOGFjVUV3dXRlTjNaekdL?=
 =?utf-8?B?MGs5UXhXSDBlajZnVzJNRnduUlA5aXhBMlNIN1lOamM4cUR4YVNmcXVFcURO?=
 =?utf-8?B?OFVOZmtXOEdUR3Y2K1JQZTBKTGdkT2FkYi9sRnV1aGtOZ1dsYkZtTmtYSEtB?=
 =?utf-8?B?UWpvQ2kyMkdKMmYxSlh5dTBQcjBXS0ZPMEc2N3N2T01ZMjliem5ub3VqT3J2?=
 =?utf-8?B?RURxREt3eFpVcThFcmN4Y0wxbnp1M0ZCUlJrdnRvTmp1OGx0MkZxMXNFdEtt?=
 =?utf-8?B?WU5rN2l2MlVNTXNKNi9vOU9VaGJMdHc4d01kNFU3a1NwTkpJaS9sbWdBY1B2?=
 =?utf-8?B?WEFKc2N6aFgzbzY5bzNFa1ppRVNwWWZsVFlERjlyVFR1NnZWaTdWRnpNaW5I?=
 =?utf-8?B?VElOdmYzbzRTUDdhVTVuRUV5TlVtWGdpeGRRaDUwTGhZaGtIZ0ZHK3ZieUda?=
 =?utf-8?B?QW1GUk4veThvd3hqTzVmMzY5Zm9RR3hYZ2s1Wm9pK0NNaEpCRGFwb1owMXNY?=
 =?utf-8?B?MVFweDY5MzBTbStHd1cwS0lXVXZ6MVZIQS91ZTl4aHJPZG1DNXdIeG5ITmRI?=
 =?utf-8?B?WUoyWi9MM05tWDZyV3QyMzI0MFc0N0ZzazJ1VUZHdWQ1bmZVSDl1Tjd2NGFY?=
 =?utf-8?B?T3pndVlrQkl2cjIwLysreXBtQTlQbERiWEpCaFlqS0lDdDhFRW10cmNWcHZr?=
 =?utf-8?Q?lH76l4GoDzxNF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWVoK2NBenFoekpXYTNlNEJ6SXNuRGFXT0tSbXFjRUVzT0czZWd0dlEwVCtJ?=
 =?utf-8?B?a3hnQ0t4V1N2VjBtL2NWYXRSaS9KUEdYKzRrWTZ2S3ErcEY1YnRwVUx3MHRG?=
 =?utf-8?B?L2FMQ3g2RkFjS3FyYUtBTVhyNVBxZnEzbEM4SFZXeldScVJvU2tsY1lGUllv?=
 =?utf-8?B?TDVIb01heEY0SGpvTGxFZmcweEU4QTRnZ2ZDWlZiTVk1SmpqMGdmQWIvUzRX?=
 =?utf-8?B?a2FoTmJSLzhyMW8rRWtBdG9EaXIwR0c3cDM0RHd3SElCQ296Vjl6ZERsUUtS?=
 =?utf-8?B?eDdFRkxjN0M3b2lIRVdPUjQ2WjBOQnBVOWR2cTR6K1dkTkJGcFpjN3lVSTd2?=
 =?utf-8?B?Sms3Vmc2VFZMSDc4SFcza3NIV3RkYWRmcjBRcEhIdjU0RFc2YjYxMEd3YlBi?=
 =?utf-8?B?QWJKUjVTZjRzRTk2NlhmdFY2dWpveXZHRzVWREFNcmJMUFFDeXZzZUJob0h1?=
 =?utf-8?B?ZEpScTJNeW5aMTVjVXB4ZUtmQmpuVzkrN0x0REsrTFBucWtKeTFqT29Ud2pa?=
 =?utf-8?B?MUkrb1gyYlFNTk1TQXhvYjBhVjZEdFljZnNBK2tVNkdWdGxBSjhDRElGdUtY?=
 =?utf-8?B?N0M4RE5xdWV6dWQxM0VsV0l1SEZWRkZxUk5reGNSZ0pqRWlYMWdiUDNUYUlM?=
 =?utf-8?B?SUdVbG11cUR6RFRRV2paSWNIejhQdGlteHArZzd4RlNYcFh5ZWRiYTBrYS9x?=
 =?utf-8?B?OXRZOUtTMDl4dGlValVFTlBiQURNRjhxa1gxYjF1WHpZRFZNc2tBaXRWYWlD?=
 =?utf-8?B?cXhpWkE5MlpFSGlpQzBMN0xZcDUzVDBvbzE5OUxBZG5SYlk1a0tic1JyV2lE?=
 =?utf-8?B?YllrL2x2c2ZXK0xaVGQ3U3hNSXB2eDdTUWIxR0R5T0ZCaGw2WGcycDk0OGw5?=
 =?utf-8?B?TzBISkpSVENDOGVOVzl0eXdFbkpuZm9BOHltQUJDS3U3Rnc1alU1L2U5bTJR?=
 =?utf-8?B?SGZ5aTBvTS9lVGRkWGRINjJwU3VzalhxaUVaR29panBPL3g3b2FBWkZ0QVlm?=
 =?utf-8?B?YUQvUXN6Z2xld0ppVG9ydTBQWGtuTVFlczhKZGhianBadG9FMDREQ0c3SUVn?=
 =?utf-8?B?OUhBN1M5NUp5WVZDdWcxNXNYYjhlWVdHZU9iaGRMV3lXOFFVT0I0V2ZaSE9J?=
 =?utf-8?B?ZzJjSWtiSmFERWIrUTlJcm8wWU8rTmY4aitTbks5VlpOOUh0SitMeVVzeXZD?=
 =?utf-8?B?cVROeVdianRmc2NlMDlFcVZOcVVCQUIrMDlvN1NiWkl6eEtyRyt1a1hWZ3NU?=
 =?utf-8?B?OU5ZTk1QVy81TlkwQ3QxUGhZSzFoQ3k0UGZmQWtmR2NDd2NtbXFpYzJnZURJ?=
 =?utf-8?B?bVBkckNEOVl2US80eXdkeU80eVZWdWZZV1dya3lGTW5uQVE4eGdTVlJqcHRi?=
 =?utf-8?B?Q0U4K2Q5UnA3RCtOenNqZzQ0bkMrbDZ6aStnT3FnVHYxZ0hvRVRlUWZhU3NQ?=
 =?utf-8?B?RE95UmZzK2ZEcHVyNXVQLzVQd2xvWGc4ZHUyNlpWQnlWR1NpckM1bm81S0k2?=
 =?utf-8?B?ZHQxZFFJUzE2OGlUNXNWanRFMjhMWWV0dkFNUG9EL1ltRUNQcENvUUdBRVQr?=
 =?utf-8?B?Qk5KcEdsWW9aT2lkRXlEYjFYL2U4eGU1blVteEZjY3pqTUdHUndWSlRYc3N4?=
 =?utf-8?B?dEZRUy82cm5JTGpoZ0FVREtHbWg4a204UTVHelA4Y3J2NmRjOFd3UVVpL1ov?=
 =?utf-8?B?alhzOXk1MHVTVnZxZmIzem8yRjd6UmREcVZHSjcvTXdpbzZ3S05zTkxCcFlt?=
 =?utf-8?B?VTRQblU2OXppMXlJU2lOODVXNFpUN280RzlSQmw1T2lLLytzMzlFZHRnYWlB?=
 =?utf-8?B?RjFaLy80ckNSY2dFSllQZkRUSjNxelpXTlRrL3VnLzdkaTJsNFphblQwOEth?=
 =?utf-8?B?b1JTSWRWUThRVWhtNUk5MzMvVThlRis3YUxwTFNlVWtzS1RVMmxrNHhOL2Jp?=
 =?utf-8?B?Z3g2b2lpcTkvNFpsYXhDMW5scXZDc1RyTElFNllGK0pMZU8ySHB6UDBVNVI2?=
 =?utf-8?B?YUo2MEZtT0JNcVVMQlRySXlNV0ZvZGFpWXp3YXZyK1pRUTF6cXVhUzNuVU0v?=
 =?utf-8?B?SmE2b2YxajBoODZpWk03TmYrMDljUGhiVHNOTnIxeEtsbHBYZFFPK1U4VFBT?=
 =?utf-8?Q?OK8gRmopixuYhqyR3UJDqAd5e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5735a367-25ab-4b5f-3f34-08dd65cfa3ba
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 03:47:43.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DThl/t+ya+QoYkOm21gaHnNdBYKlC9xoiPqzQJg41wsqL2XxhPC05j/uTset1Q0vB5Sbh3kr6dH1VxWpIA+sNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680

On 3/16/2025 18:07, Luke Jones wrote:
> From: "Luke D. Jones" <luke@ljones.dev>
> 
> The fw_attributes_class provides a much cleaner interface to all of the
> attributes introduced to asus-wmi. This patch moves all of these extra
> attributes over to fw_attributes_class, and shifts the bulk of these
> definitions to a new kernel module to reduce the clutter of asus-wmi
> with the intention of deprecating the asus-wmi attributes in future.
> 
> The work applies only to WMI methods which don't have a clearly defined
> place within the sysfs and as a result ended up lumped together in
> /sys/devices/platform/asus-nb-wmi/ with no standard API.
> 
> Where possible the fw attrs now implement defaults, min, max, scalar,
> choices, etc. As en example dgpu_disable becomes:
> 
> /sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disable/
> ├── current_value
> ├── display_name
> ├── possible_values
> └── type
> 
> as do other attributes.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Very minor comments in line.  You can add this to next version.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/platform/x86/Kconfig               |  12 +
>   drivers/platform/x86/Makefile              |   1 +
>   drivers/platform/x86/asus-armoury.c        | 545 +++++++++++++++++++++
>   drivers/platform/x86/asus-armoury.h        | 165 +++++++
>   drivers/platform/x86/asus-wmi.c            |   4 -
>   include/linux/platform_data/x86/asus-wmi.h |   3 +
>   6 files changed, 726 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/platform/x86/asus-armoury.c
>   create mode 100644 drivers/platform/x86/asus-armoury.h
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64..294364cc7478 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -267,6 +267,18 @@ config ASUS_WIRELESS
>   	  If you choose to compile this driver as a module the module will be
>   	  called asus-wireless.
>   
> +config ASUS_ARMOURY
> +	tristate "ASUS Armoury driver"
> +	depends on ASUS_WMI
> +	select FW_ATTR_CLASS
> +	help
> +	  Say Y here if you have a WMI aware Asus machine and would like to use the
> +	  firmware_attributes API to control various settings typically exposed in
> +	  the ASUS Armoury Crate application available on Windows.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called asus-armoury.
> +
>   config ASUS_WMI
>   	tristate "ASUS WMI Driver"
>   	depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index e1b142947067..fe3e7e7dede8 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
>   # ASUS
>   obj-$(CONFIG_ASUS_LAPTOP)	+= asus-laptop.o
>   obj-$(CONFIG_ASUS_WIRELESS)	+= asus-wireless.o
> +obj-$(CONFIG_ASUS_ARMOURY)	+= asus-armoury.o
>   obj-$(CONFIG_ASUS_WMI)		+= asus-wmi.o
>   obj-$(CONFIG_ASUS_NB_WMI)	+= asus-nb-wmi.o
>   obj-$(CONFIG_ASUS_TF103C_DOCK)	+= asus-tf103c-dock.o
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> new file mode 100644
> index 000000000000..46102cd0c00d
> --- /dev/null
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -0,0 +1,545 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Asus Armoury (WMI) attributes driver. This driver uses the fw_attributes
> + * class to expose the various WMI functions that many gaming and some
> + * non-gaming ASUS laptops have available.
> + * These typically don't fit anywhere else in the sysfs such as under LED class,
> + * hwmon or other, and are set in Windows using the ASUS Armoury Crate tool.
> + *
> + * Copyright(C) 2024 Luke Jones <luke@ljones.dev>
> + */
> +
> +#include "linux/cleanup.h"

Shouldn't this be <linux/cleanup.h>?

> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/dmi.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/kmod.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_data/x86/asus-wmi.h>
> +#include <linux/types.h>
> +#include <linux/acpi.h>

Alphabetical order?

> +
> +#include "asus-armoury.h"
> +#include "firmware_attributes_class.h"
> +
> +#define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"
> +
> +#define ASUS_MINI_LED_MODE_MASK   0x03
> +/* Standard modes for devices with only on/off */
> +#define ASUS_MINI_LED_OFF         0x00
> +#define ASUS_MINI_LED_ON          0x01
> +/* Like "on" but the effect is more vibrant or brighter */
> +#define ASUS_MINI_LED_STRONG_MODE 0x02
> +/* New modes for devices with 3 mini-led mode types */
> +#define ASUS_MINI_LED_2024_WEAK   0x00
> +#define ASUS_MINI_LED_2024_STRONG 0x01
> +#define ASUS_MINI_LED_2024_OFF    0x02
> +
> +static struct asus_armoury_priv {
> +	struct device *fw_attr_dev;
> +	struct kset *fw_attr_kset;
> +
> +	u32 mini_led_dev_id;
> +	u32 gpu_mux_dev_id;
> +} asus_armoury;
> +
> +struct fw_attrs_group {
> +	bool pending_reboot;
> +};
> +
> +static struct fw_attrs_group fw_attrs = {
> +	.pending_reboot = false,
> +};
> +
> +struct asus_attr_group {
> +	const struct attribute_group *attr_group;
> +	u32 wmi_devid;
> +};
> +
> +static bool asus_wmi_is_present(u32 dev_id)
> +{
> +	u32 retval;
> +	int status;
> +
> +	status = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, &retval);
> +	pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id, retval);
> +
> +	return status == 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
> +}
> +
> +static void asus_set_reboot_and_signal_event(void)
> +{
> +	fw_attrs.pending_reboot = true;
> +	kobject_uevent(&asus_armoury.fw_attr_dev->kobj, KOBJ_CHANGE);
> +}
> +
> +static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", fw_attrs.pending_reboot);
> +}
> +
> +static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
> +
> +static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> +{
> +	return !strcmp(attr->attr.name, "gpu_mux_mode");
> +}
> +
> +static int armoury_wmi_set_devstate(struct kobj_attribute *attr, u32 value, u32 wmi_dev)
> +{
> +	u32 result;
> +	int err;
> +
> +	err = asus_wmi_set_devstate(wmi_dev, value, &result);
> +	if (err) {
> +		pr_err("Failed to set %s: %d\n", attr->attr.name, err);
> +		return err;
> +	}
> +	/*
> +	 * !1 is usually considered a fail by ASUS, but some WMI methods do use > 1
> +	 * to return a status code or similar.
> +	 */
> +	if (result < 1) {
> +		pr_err("Failed to set %s: (result): 0x%x\n", attr->attr.name, result);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * attr_int_store() - Send an int to wmi method, checks if within min/max exclusive.
> + * @kobj: Pointer to the driver object.
> + * @attr: Pointer to the attribute calling this function.
> + * @buf: The buffer to read from, this is parsed to `int` type.
> + * @count: Required by sysfs attribute macros, pass in from the callee attr.
> + * @min: Minimum accepted value. Below this returns -EINVAL.
> + * @max: Maximum accepted value. Above this returns -EINVAL.
> + * @store_value: Pointer to where the parsed value should be stored.
> + * @wmi_dev: The WMI function ID to use.
> + *
> + * This function is intended to be generic so it can be called from any "_store"
> + * attribute which works only with integers. The integer to be sent to the WMI method
> + * is range checked and an error returned if out of range.
> + *
> + * If the value is valid and WMI is success, then the sysfs attribute is notified
> + * and if asus_bios_requires_reboot() is true then reboot attribute is also notified.
> + *
> + * Returns: Either count, or an error.
> + */
> +static ssize_t attr_uint_store(struct kobject *kobj, struct kobj_attribute *attr, const char *buf,
> +			      size_t count, u32 min, u32 max, u32 *store_value, u32 wmi_dev)
> +{
> +	u32 value;
> +	int err;
> +
> +	err = kstrtouint(buf, 10, &value);
> +	if (err)
> +		return err;
> +
> +	if (value < min || value > max)
> +		return -EINVAL;
> +
> +	err = armoury_wmi_set_devstate(attr, value, wmi_dev);
> +	if (err)
> +		return err;
> +
> +	if (store_value != NULL)
> +		*store_value = value;
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	if (asus_bios_requires_reboot(attr))
> +		asus_set_reboot_and_signal_event();
> +
> +	return count;
> +}
> +
> +static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			      char *buf)
> +{
> +	return sysfs_emit(buf, "enumeration\n");
> +}
> +
> +/* Mini-LED mode **************************************************************/
> +static ssize_t mini_led_mode_current_value_show(struct kobject *kobj,
> +						struct kobj_attribute *attr, char *buf)
> +{
> +	u32 value;
> +	int err;
> +
> +	err = asus_wmi_get_devstate_dsts(asus_armoury.mini_led_dev_id, &value);
> +	if (err)
> +		return err;
> +
> +	value &= ASUS_MINI_LED_MODE_MASK;
> +
> +	/*
> +	 * Remap the mode values to match previous generation mini-LED. The last gen
> +	 * WMI 0 == off, while on this version WMI 2 == off (flipped).
> +	 */
> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +		switch (value) {
> +		case ASUS_MINI_LED_2024_WEAK:
> +			value = ASUS_MINI_LED_ON;
> +			break;
> +		case ASUS_MINI_LED_2024_STRONG:
> +			value = ASUS_MINI_LED_STRONG_MODE;
> +			break;
> +		case ASUS_MINI_LED_2024_OFF:
> +			value = ASUS_MINI_LED_OFF;
> +			break;
> +		}
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", value);
> +}
> +
> +static ssize_t mini_led_mode_current_value_store(struct kobject *kobj,
> +						 struct kobj_attribute *attr,
> +						const char *buf, size_t count)
> +{
> +	u32 mode;
> +	int err;
> +
> +	err = kstrtou32(buf, 10, &mode);
> +	if (err)
> +		return err;
> +
> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE &&
> +	    mode > ASUS_MINI_LED_ON)
> +		return -EINVAL;
> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2 &&
> +	    mode > ASUS_MINI_LED_STRONG_MODE)
> +		return -EINVAL;
> +
> +	/*
> +	 * Remap the mode values so expected behaviour is the same as the last
> +	 * generation of mini-LED with 0 == off, 1 == on.
> +	 */
> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +		switch (mode) {
> +		case ASUS_MINI_LED_OFF:
> +			mode = ASUS_MINI_LED_2024_OFF;
> +			break;
> +		case ASUS_MINI_LED_ON:
> +			mode = ASUS_MINI_LED_2024_WEAK;
> +			break;
> +		case ASUS_MINI_LED_STRONG_MODE:
> +			mode = ASUS_MINI_LED_2024_STRONG;
> +			break;
> +		}
> +	}
> +
> +	err = armoury_wmi_set_devstate(attr, mode, asus_armoury.mini_led_dev_id);
> +	if (err)
> +		return err;
> +
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	return count;
> +}
> +
> +static ssize_t mini_led_mode_possible_values_show(struct kobject *kobj,
> +						  struct kobj_attribute *attr, char *buf)
> +{
> +	switch (asus_armoury.mini_led_dev_id) {
> +	case ASUS_WMI_DEVID_MINI_LED_MODE:
> +		return sysfs_emit(buf, "0;1\n");
> +	case ASUS_WMI_DEVID_MINI_LED_MODE2:
> +		return sysfs_emit(buf, "0;1;2\n");
> +	}
> +
> +	return sysfs_emit(buf, "0\n");
> +}
> +
> +ATTR_GROUP_ENUM_CUSTOM(mini_led_mode, "mini_led_mode", "Set the mini-LED backlight mode");
> +
> +static ssize_t gpu_mux_mode_current_value_store(struct kobject *kobj,
> +						struct kobj_attribute *attr, const char *buf,
> +						size_t count)
> +{
> +	int result, err;
> +	u32 optimus;
> +
> +	err = kstrtou32(buf, 10, &optimus);
> +	if (err)
> +		return err;
> +
> +	if (optimus > 1)
> +		return -EINVAL;
> +
> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
> +		err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_DGPU, &result);
> +		if (err)
> +			return err;
> +		if (result && !optimus) {
> +			pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled: %02X %02X\n",
> +				result, optimus);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
> +		err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
> +		if (err)
> +			return err;
> +		if (result && !optimus) {
> +			pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	err = armoury_wmi_set_devstate(attr, optimus, asus_armoury.gpu_mux_dev_id);
> +	if (err)
> +		return err;
> +
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +	asus_set_reboot_and_signal_event();
> +
> +	return count;
> +}
> +WMI_SHOW_INT(gpu_mux_mode_current_value, "%d\n", asus_armoury.gpu_mux_dev_id);
> +ATTR_GROUP_BOOL_CUSTOM(gpu_mux_mode, "gpu_mux_mode", "Set the GPU display MUX mode");
> +
> +/*
> + * A user may be required to store the value twice, typical store first, then
> + * rescan PCI bus to activate power, then store a second time to save correctly.
> + */
> +static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
> +						struct kobj_attribute *attr, const char *buf,
> +						size_t count)
> +{
> +	int result, err;
> +	u32 disable;
> +
> +	err = kstrtou32(buf, 10, &disable);
> +	if (err)
> +		return err;
> +
> +	if (disable > 1)
> +		return -EINVAL;
> +
> +	if (asus_armoury.gpu_mux_dev_id) {
> +		err = asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &result);
> +		if (err)
> +			return err;
> +		if (!result && disable) {
> +			pr_warn("Can not disable dGPU when the MUX is in dGPU mode\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	err = armoury_wmi_set_devstate(attr, disable, ASUS_WMI_DEVID_DGPU);
> +	if (err)
> +		return err;
> +
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	return count;
> +}
> +WMI_SHOW_INT(dgpu_disable_current_value, "%d\n", ASUS_WMI_DEVID_DGPU);
> +ATTR_GROUP_BOOL_CUSTOM(dgpu_disable, "dgpu_disable", "Disable the dGPU");
> +
> +/* The ACPI call to enable the eGPU also disables the internal dGPU */
> +static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
> +					       const char *buf, size_t count)
> +{
> +	int result, err;
> +	u32 enable;
> +
> +	err = kstrtou32(buf, 10, &enable);
> +	if (err)
> +		return err;
> +
> +	if (enable > 1)
> +		return -EINVAL;
> +
> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU_CONNECTED, &result);
> +	if (err) {
> +		pr_warn("Failed to get eGPU connection status: %d\n", err);
> +		return err;
> +	}
> +
> +	if (asus_armoury.gpu_mux_dev_id) {
> +		err = asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &result);
> +		if (err) {
> +			pr_warn("Failed to get GPU MUX status: %d\n", result);
> +			return result;
> +		}
> +		if (!result && enable) {
> +			pr_warn("Can not enable eGPU when the MUX is in dGPU mode\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	err = armoury_wmi_set_devstate(attr, enable, ASUS_WMI_DEVID_EGPU);
> +	if (err)
> +		return err;
> +
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	return count;
> +}
> +WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
> +ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
> +
> +/* Simple attribute creation */
> +ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
> +		       "Show the current mode of charging");
> +
> +ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SOUND,
> +		   "Set the boot POST sound");
> +ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_POWERSAVE,
> +		   "Set MCU powersaving mode");
> +ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
> +		   "Set the panel refresh overdrive");
> +ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
> +		   "Show the eGPU connection status");
> +
> +/* If an attribute does not require any special case handling add it here */
> +static const struct asus_attr_group armoury_attr_groups[] = {
> +	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
> +	{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
> +	{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
> +
> +	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
> +	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> +	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
> +	{ &panel_od_attr_group, ASUS_WMI_DEVID_PANEL_OD },
> +};
> +
> +static int asus_fw_attr_add(void)
> +{
> +	int err, i;
> +
> +	asus_armoury.fw_attr_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
> +						NULL, "%s", DRIVER_NAME);
> +	if (IS_ERR(asus_armoury.fw_attr_dev)) {
> +		err = PTR_ERR(asus_armoury.fw_attr_dev);
> +		goto fail_class_get;
> +	}
> +
> +	asus_armoury.fw_attr_kset = kset_create_and_add("attributes", NULL,
> +						&asus_armoury.fw_attr_dev->kobj);
> +	if (!asus_armoury.fw_attr_kset) {
> +		err = -ENOMEM;
> +		goto err_destroy_classdev;
> +	}
> +
> +	err = sysfs_create_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
> +	if (err) {
> +		pr_err("Failed to create sysfs level attributes\n");
> +		goto err_destroy_kset;
> +	}
> +
> +	asus_armoury.mini_led_dev_id = 0;
> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE))
> +		asus_armoury.mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
> +	else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2))
> +		asus_armoury.mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
> +
> +	if (asus_armoury.mini_led_dev_id) {
> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +					 &mini_led_mode_attr_group);
> +		if (err) {
> +			pr_err("Failed to create sysfs-group for mini_led\n");
> +			goto err_remove_file;
> +		}
> +	}
> +
> +	asus_armoury.gpu_mux_dev_id = 0;
> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX))
> +		asus_armoury.gpu_mux_dev_id = ASUS_WMI_DEVID_GPU_MUX;
> +	else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO))
> +		asus_armoury.gpu_mux_dev_id = ASUS_WMI_DEVID_GPU_MUX_VIVO;
> +
> +	if (asus_armoury.gpu_mux_dev_id) {
> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +					 &gpu_mux_mode_attr_group);
> +		if (err) {
> +			pr_err("Failed to create sysfs-group for gpu_mux\n");
> +			goto err_remove_mini_led_group;
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(armoury_attr_groups); i++) {
> +		if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
> +			continue;
> +
> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +					 armoury_attr_groups[i].attr_group);
> +		if (err) {
> +			pr_err("Failed to create sysfs-group for %s\n",
> +			       armoury_attr_groups[i].attr_group->name);
> +			goto err_remove_groups;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_remove_groups:
> +	while (--i >= 0) {
> +		if (asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
> +			sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj,
> +					   armoury_attr_groups[i].attr_group);
> +	}
> +	if (asus_armoury.gpu_mux_dev_id)
> +		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &gpu_mux_mode_attr_group);
> +err_remove_mini_led_group:
> +	if (asus_armoury.mini_led_dev_id)
> +		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &mini_led_mode_attr_group);
> +err_remove_file:
> +	sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
> +err_destroy_kset:
> +	kset_unregister(asus_armoury.fw_attr_kset);
> +err_destroy_classdev:
> +fail_class_get:
> +	device_destroy(&firmware_attributes_class, MKDEV(0, 0));
> +	return err;
> +}
> +
> +/* Init / exit ****************************************************************/
> +
> +static int __init asus_fw_init(void)
> +{
> +	char *wmi_uid;
> +	int err;
> +
> +	wmi_uid = wmi_get_acpi_device_uid(ASUS_WMI_MGMT_GUID);
> +	if (!wmi_uid)
> +		return -ENODEV;
> +
> +	/*
> +	 * if equal to "ASUSWMI" then it's DCTS that can't be used for this
> +	 * driver, DSTS is required.
> +	 */
> +	if (!strcmp(wmi_uid, ASUS_ACPI_UID_ASUSWMI))
> +		return -ENODEV;
> +
> +	err = asus_fw_attr_add();
> +	if (err)
> +		return err;
> +
> +	return 0;

If no plans to change asus_fw_init() in later patches this can just be

return asus_fw_attr_add();

and drop the err variable.

If planning to change asus_fw_init() this is fine as is.

> +}
> +
> +static void __exit asus_fw_exit(void)
> +{
> +	sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
> +	kset_unregister(asus_armoury.fw_attr_kset);
> +	device_destroy(&firmware_attributes_class, MKDEV(0, 0));
> +}
> +
> +module_init(asus_fw_init);
> +module_exit(asus_fw_exit);
> +
> +MODULE_IMPORT_NS("ASUS_WMI");
> +MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
> +MODULE_DESCRIPTION("ASUS BIOS Configuration Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("wmi:" ASUS_NB_WMI_EVENT_GUID);
> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
> new file mode 100644
> index 000000000000..42c8171e5d8a
> --- /dev/null
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -0,0 +1,165 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Definitions for kernel modules using asus-armoury driver
> + *
> + *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>
> + */
> +
> +#ifndef _ASUS_ARMOURY_H_
> +#define _ASUS_ARMOURY_H_
> +
> +#include <linux/types.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME "asus-armoury"
> +
> +#define __ASUS_ATTR_RO(_func, _name)					\
> +	{								\
> +		.attr = { .name = __stringify(_name), .mode = 0444 },	\
> +		.show = _func##_##_name##_show,				\
> +	}
> +
> +#define __ASUS_ATTR_RO_AS(_name, _show)					\
> +	{								\
> +		.attr = { .name = __stringify(_name), .mode = 0444 },	\
> +		.show = _show,						\
> +	}
> +
> +#define __ASUS_ATTR_RW(_func, _name) \
> +	__ATTR(_name, 0644, _func##_##_name##_show, _func##_##_name##_store)
> +
> +#define __WMI_STORE_INT(_attr, _min, _max, _wmi)			\
> +	static ssize_t _attr##_store(struct kobject *kobj,		\
> +				     struct kobj_attribute *attr,	\
> +				     const char *buf, size_t count)	\
> +	{								\
> +		return attr_uint_store(kobj, attr, buf, count, _min,	\
> +					_max, NULL, _wmi);		\
> +	}
> +
> +#define WMI_SHOW_INT(_attr, _fmt, _wmi)						\
> +	static ssize_t _attr##_show(struct kobject *kobj,			\
> +				    struct kobj_attribute *attr, char *buf)	\
> +	{									\
> +		u32 result;							\
> +		int err;							\
> +										\
> +		err = asus_wmi_get_devstate_dsts(_wmi, &result);		\
> +		if (err)							\
> +			return err;						\
> +		return sysfs_emit(buf, _fmt,					\
> +				  result & ~ASUS_WMI_DSTS_PRESENCE_BIT);	\
> +	}
> +
> +/* Create functions and attributes for use in other macros or on their own */
> +
> +/* Shows a formatted static variable */
> +#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)				\
> +	static ssize_t _attrname##_##_prop##_show(				\
> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
> +	{									\
> +		return sysfs_emit(buf, _fmt, _val);				\
> +	}									\
> +	static struct kobj_attribute attr_##_attrname##_##_prop =		\
> +		__ASUS_ATTR_RO(_attrname, _prop)
> +
> +
> +#define __ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispname)\
> +	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);			\
> +	static struct kobj_attribute attr_##_attrname##_current_value =		\
> +		__ASUS_ATTR_RO(_attrname, current_value);			\
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
> +	__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);		\
> +	static struct kobj_attribute attr_##_attrname##_type =			\
> +		__ASUS_ATTR_RO_AS(type, enum_type_show);			\
> +	static struct attribute *_attrname##_attrs[] = {			\
> +		&attr_##_attrname##_current_value.attr,				\
> +		&attr_##_attrname##_display_name.attr,				\
> +		&attr_##_attrname##_possible_values.attr,			\
> +		&attr_##_attrname##_type.attr,					\
> +		NULL								\
> +	};									\
> +	static const struct attribute_group _attrname##_attr_group = {		\
> +		.name = _fsname, .attrs = _attrname##_attrs			\
> +	}
> +
> +#define __ATTR_RW_INT_GROUP_ENUM(_attrname, _minv, _maxv, _wmi, _fsname,\
> +				 _possible, _dispname)			\
> +	__WMI_STORE_INT(_attrname##_current_value, _minv, _maxv, _wmi);	\
> +	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);		\
> +	static struct kobj_attribute attr_##_attrname##_current_value =	\
> +		__ASUS_ATTR_RW(_attrname, current_value);		\
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
> +	__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);	\
> +	static struct kobj_attribute attr_##_attrname##_type =		\
> +		__ASUS_ATTR_RO_AS(type, enum_type_show);		\
> +	static struct attribute *_attrname##_attrs[] = {		\
> +		&attr_##_attrname##_current_value.attr,			\
> +		&attr_##_attrname##_display_name.attr,			\
> +		&attr_##_attrname##_possible_values.attr,		\
> +		&attr_##_attrname##_type.attr,				\
> +		NULL							\
> +	};								\
> +	static const struct attribute_group _attrname##_attr_group = {	\
> +		.name = _fsname, .attrs = _attrname##_attrs		\
> +	}
> +
> +/* Boolean style enumeration, base macro. Requires adding show/store */
> +#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)	\
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
> +	__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);	\
> +	static struct kobj_attribute attr_##_attrname##_type =		\
> +		__ASUS_ATTR_RO_AS(type, enum_type_show);		\
> +	static struct attribute *_attrname##_attrs[] = {		\
> +		&attr_##_attrname##_current_value.attr,			\
> +		&attr_##_attrname##_display_name.attr,			\
> +		&attr_##_attrname##_possible_values.attr,		\
> +		&attr_##_attrname##_type.attr,				\
> +		NULL							\
> +	};								\
> +	static const struct attribute_group _attrname##_attr_group = {	\
> +		.name = _fsname, .attrs = _attrname##_attrs		\
> +	}
> +
> +#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname)	\
> +	__ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, "0;1", _dispname)
> +
> +
> +#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname)	\
> +	__ATTR_RW_INT_GROUP_ENUM(_attrname, 0, 1, _wmi, _fsname, "0;1", _dispname)
> +
> +#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible, _dispname)	\
> +	__ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispname)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + */
> +#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)		\
> +	static struct kobj_attribute attr_##_attrname##_current_value =	\
> +		__ASUS_ATTR_RW(_attrname, current_value);		\
> +	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + * and <name>_possible_values_show()
> + */
> +#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)			\
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
> +	static struct kobj_attribute attr_##_attrname##_current_value =		\
> +		__ASUS_ATTR_RW(_attrname, current_value);			\
> +	static struct kobj_attribute attr_##_attrname##_possible_values =	\
> +		__ASUS_ATTR_RO(_attrname, possible_values);			\
> +	static struct kobj_attribute attr_##_attrname##_type =			\
> +		__ASUS_ATTR_RO_AS(type, enum_type_show);			\
> +	static struct attribute *_attrname##_attrs[] = {			\
> +		&attr_##_attrname##_current_value.attr,				\
> +		&attr_##_attrname##_display_name.attr,				\
> +		&attr_##_attrname##_possible_values.attr,			\
> +		&attr_##_attrname##_type.attr,					\
> +		NULL								\
> +	};									\
> +	static const struct attribute_group _attrname##_attr_group = {		\
> +		.name = _fsname, .attrs = _attrname##_attrs			\
> +	}
> +
> +#endif /* _ASUS_ARMOURY_H_ */
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 2784b8e6514e..e2ac3f20760a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -55,8 +55,6 @@ module_param(fnlock_default, bool, 0444);
>   #define to_asus_wmi_driver(pdrv)					\
>   	(container_of((pdrv), struct asus_wmi_driver, platform_driver))
>   
> -#define ASUS_WMI_MGMT_GUID	"97845ED0-4E6D-11DE-8A39-0800200C9A66"
> -
>   #define NOTIFY_BRNUP_MIN		0x11
>   #define NOTIFY_BRNUP_MAX		0x1f
>   #define NOTIFY_BRNDOWN_MIN		0x20
> @@ -105,8 +103,6 @@ module_param(fnlock_default, bool, 0444);
>   #define USB_INTEL_XUSB2PR		0xD0
>   #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
>   
> -#define ASUS_ACPI_UID_ASUSWMI		"ASUSWMI"
> -
>   #define WMI_EVENT_MASK			0xFFFF
>   
>   #define FAN_CURVE_POINTS		8
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 96ff25b2b51b..4574e30c53fc 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -6,6 +6,9 @@
>   #include <linux/types.h>
>   #include <linux/dmi.h>
>   
> +#define ASUS_WMI_MGMT_GUID	"97845ED0-4E6D-11DE-8A39-0800200C9A66"
> +#define ASUS_ACPI_UID_ASUSWMI	"ASUSWMI"
> +
>   /* WMI Methods */
>   #define ASUS_WMI_METHODID_SPEC	        0x43455053 /* BIOS SPECification */
>   #define ASUS_WMI_METHODID_SFBD		0x44424653 /* Set First Boot Device */


