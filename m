Return-Path: <linux-kernel+bounces-416038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 627349D3F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD8D1F23E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B7143C63;
	Wed, 20 Nov 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0q1FJrQr"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DBC13BACC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118053; cv=fail; b=C4XhGSfRglfLDpr0upFMCDs+D7fY8RGmXOgKImokMZW85Nju0aKrxw2Bgo4/bbE0ketioJ/QCA6KU1naAVUbAyWIFSbjJKlwlrhBVSL2bf0gCo4zlyx4LgsWdPrXnq9LJrjHW6cCKN7xeGE0Zm+mBmgkVzIBgZhOeaZK4Qlh3Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118053; c=relaxed/simple;
	bh=p0WeM5I/A8qgd/91sCjDOmcOZ65fqMjf5CcnvTa9kZ0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iUCgJgsYUzCedj98T+xyqZD2Dkp1z+/SVJG9vS9T95rhz2gTQMrNMQGjHuRjPKcD9IXOjNGC8vUfTRFtVB7/r5AWlMSWn/bPCKe9giVBvVGzgcsrtWexkDtdxQQkGD2OBOE0wy47HIybKLd5cQ4/BaBsU30rKXGdzZ6rn/Dp+RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0q1FJrQr; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgQRiZuON+AQ7ofCv7QqDBDsEzjlU6GC/QIm+osOSwiR8k1gy0RhX2hP+mv9vCfJjeG3tOcacsve6XDcnPBL8x/A4XxwOobOIcDnoa0nLGMjN5AnSjPxjA+VfEyGoa4j54ovYl96CQs3fkw4lYB2N3GUnMrP5qrICl60fZxsXK23pzPjuWFYQpBWNDg58qlRZKBTRB0xM90NHMuEm4mqQFSDsPsbhlBaLGCDH5fk4K2q2+Ks/z2cT09f50lyDrqnOMM48BuaY6qU0/MeA/LLJwvai3wHwDGjrRQxXUE7pXg3lOmbcYJsOgjOlQne8vkff7jB6xoxVlwdnPUe3UnwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlvCp8quyGuU6kgKhuR9zyXRJ8Y8lW/SEijua9/ELHU=;
 b=rnyWVnKly7m8YhcjfZN6xGdqG/ZMwy6SZZGDuRrx+FMeCAdbTR8up3W6VPKHqZkCv1wsqHXE9NdO/rudaA+4SJMm1FBfXQ7tZgHTm1FzjLGWCWMOoeivnB5Bv/RthonOUaTnlbQtjWF56P2YJbIoCvtWevreL4AwTGtsszBfWM9DilstG7kSKhbYIf7qK3WCMpvEg6mrkhWgst2aMob8TsdB2EV8Kp2adimPpNBwoWm1e7K803EklqdjcritWLufvU5BptCsDW8MBUuNZs3sfvKWgT1ao5F9lX7SddY2CL9ukfxspCt4NI8sCPkjMxIy9xVJ4PpLFuGbuF26F8SLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlvCp8quyGuU6kgKhuR9zyXRJ8Y8lW/SEijua9/ELHU=;
 b=0q1FJrQr+rv8PhrJCVQ5tJ3eLx0/u+40nzjCnpUL73R33Fu0SCVBh5p3CdXFHRS87xBuaDdGoQOQsmNyMUs051m9417YMwaMvp24PbzvEF4eHEWVZAjzbYReVjgRsBVfd6pgEG4/VFmfqNQHDUNr5ZB6YtvUz7TBV7mIc2Y6wDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Wed, 20 Nov
 2024 15:54:06 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 15:54:06 +0000
Message-ID: <197f9c0e-e057-41d4-8492-8e49adc45d18@amd.com>
Date: Wed, 20 Nov 2024 21:23:56 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 06/19] perf: Simplify perf_pmu_register()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241104133909.669111662@infradead.org>
 <20241104135518.198937277@infradead.org>
 <d64ebfba-49db-4b04-9a84-b9ecd26e6c76@amd.com>
 <20241120144603.GG19989@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20241120144603.GG19989@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::35) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e45a9dd-24b6-441c-c4c7-08dd097b9042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU5oRE51ZFNYOFBrcllFcUhUNWI0bHgyYWp3S1JXSUtjckcxMi83WmFPSmdl?=
 =?utf-8?B?cU93MW02N25GZEgxd0licjhvSVNSUk1WSHY2ajJKRkZOUmZ1MExSRE84a0Ja?=
 =?utf-8?B?Qzd4akhyUmZaMXhmeWtYeWcrRVU0cy9lOTFyVjBOQnRuMkxQcHUwUU5XLyti?=
 =?utf-8?B?b3o3MlFaa0RkL29BQXlCbjgrY1JCRU5vcEcyVEU1SUpIRWFQMDU5R3pGUDd4?=
 =?utf-8?B?UzRzQlJXUkxLZDhiUXFEdnkrcDNDREZtM0hvOXFEaWZNYy9HcUV3MEt0VURS?=
 =?utf-8?B?WVJPeVpVYktpR3F2TnVVaUFqcmZqY002Ry9TZXFJSzFCN0Y4dlZGanpNTTQ2?=
 =?utf-8?B?Y2QvQ1UvcGlzNGEwZks0cnlkMXN5MGdnNEU2ODdnTlpscVRTK1YxT0VxN3Vk?=
 =?utf-8?B?a3lOTmxLNllRMDZCRmgySWJsdXlMNHNDamRWMEdkVENyNzJmWnIzV3N3cEU1?=
 =?utf-8?B?d3NxUmwrc0ZDV1ptTGZFZGYvdXB2czZHWUpXVGY4ODZXWjdUR2ZaejJkUjVk?=
 =?utf-8?B?VE5PL1VLQTY1MTNJN3lBcGdETHEzWmpOdXk3QzRBMHZFcVpPbm9qU1FpcnR6?=
 =?utf-8?B?anYrK2lYMWhxd1FyUWp6TC9FT0ZZNU43a1RucFpVWVU2aTZnTTBKc1ZaMEFr?=
 =?utf-8?B?dFphcFAwQ1JFdGYvV29BLzFJQ0xubGRld05KYUJQZEhjV1U5aUI5dEw4ZXhl?=
 =?utf-8?B?ckF3d3Q3UnhaSDNmRU82MWxSTGhCR0grNEMzN3dGRHVEaU9sWDlwS3pUejVV?=
 =?utf-8?B?OUV4a2pQWDMxRWZHblFYdlJidTgraGZsc3lLZko0V04rVHJzdGp1S3A0NkJL?=
 =?utf-8?B?bnp0M2E2VlAyZVpRLzIvRDkxQXJ6SUZHblFTb3JtRGUyUXkyeVRodVU5WSsr?=
 =?utf-8?B?ZlVRbDdoNDhOczUxeVlJaEdHNVp0bFdJdnhJUDc5NStUeG9XZkdiT1k4dkxo?=
 =?utf-8?B?VHo0bmF6WWRGb2RtZFpNZzlwejZXYmxGZHJDN3dRa2h6VmUrNVNGMDVXNElq?=
 =?utf-8?B?TmZjRzNaWWZzd1BEalEwSDlVVGM1eEx5U09ub1JtaGIrTVE5M08wWnBva01K?=
 =?utf-8?B?YS9UWFJKNzI0a3FpdU5sdFBpTCtNZ0RpbkFjSmNrajd3RndXZzlXcVJlMU1o?=
 =?utf-8?B?NmM2bXBtUTY0NlZndUdqSm83UkliKzdMNVNUNXJDNXZPaG83K1JRYUxDMzQ3?=
 =?utf-8?B?MVlXYXB1b1dkcFRKM0dScVRDZzdvYnFDeG4vYzVoS3RmbUFXN0JkOXcwSThD?=
 =?utf-8?B?Yi8xMWFhZTFtZGVIaHhPUEN6RHhJakNFVzVhMkhJUnBRY3ROREdPdUJpZkww?=
 =?utf-8?B?UUxqR1ZqeGNRbHR4dHVqZmVIc2xLLzFmcm5icTI4RVZPa1ZoaGJwV3lIa3dv?=
 =?utf-8?B?a3YyQlhGeEtlMCsxeGhvdTV4c1E1Nm1mbGtVdEhXcWdrSmlMb0E2a0hoSzI0?=
 =?utf-8?B?bHRwcWJmNSthNnI2UzNkRU5UYnU5SFVQaTQyTCt5bTRqSGV2SEllaVExK1Za?=
 =?utf-8?B?dFpMMithSkMvL3Z2S2JKWWQxYzFTMUcyWk44bW41OFFrc1FKNGNPUkRZRm5D?=
 =?utf-8?B?WEpSZmhWSGtQcm43b2hLV2hqczlpLzJuZTBaMTNhdC9xMFk0ems1R2gzRDJv?=
 =?utf-8?B?WFBhYmsyQXFTWUpQdXRnaXdTOUJzc0VIVmJkdit2d2pxVlVGMEEyUnY5dktN?=
 =?utf-8?B?bzg3VzhRcEVvS0JVK3dSd3hENjFkNGQ0M3JxOHV5VkpaaW9oVVpVRW5HZVZi?=
 =?utf-8?Q?GQovpHaCiDVdbiOOeucxD5SLNdR4HME8Xl5lwa/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2N6VTdRQ1ZFdkQzMHE1S0tqK2VYWnFTT3k3TUJJNWY0eEdQMUFiWGxxbGNM?=
 =?utf-8?B?ek4ybkdQcjdTcWFOUStNRnJScllBMzk2M2dpZUlUL1VrdFBOK3dMdDdDalhD?=
 =?utf-8?B?TXlUSkR1WEQ3RlVyWStYYVAyVHRkcVFuaVVRTHBrQmxONXVCazBYcnJIMnBR?=
 =?utf-8?B?STNidTVTazlYVGd1ZlJCMTcrdHl6WDlYNmsxaHNwWGgyb25uU1JBa2djVzlP?=
 =?utf-8?B?YkxFSklRRVhjYU96QnROTGF2ZXVsT2dOM1FkZ2xYZzhQL0RaalZqVDJIYWI4?=
 =?utf-8?B?ZDUwRTZ4NVExNkd3TTRYVFhNZnJhaWErU2h1Y0NMTk9MUlFmU01rOG11OXJY?=
 =?utf-8?B?dnRHUFVEOVlzelNZbkd2d05hZjV3S2tzai9wN2plRm9Od1FiY3ZWcWV5bXpK?=
 =?utf-8?B?RmtOT1pZQVp5dFpvTXp1WXp6MEJxYTlxbU9HdHRKU3JYSDZ1YmRGeDVjSUVo?=
 =?utf-8?B?bmxaKy93dVBGOHlkcTJpTGI3TmpoUFFOaitJdzJWcmFwc0dKU1VUTjhBYjFY?=
 =?utf-8?B?OUpIeTZpZ1lCTTBqWExSRjkxUFFJM0hkeGZXU1JHR0dTQ0lrMXZ2Y1B0d3lH?=
 =?utf-8?B?VDVxQkkzWFExSW1wOUZTMDFySzkrd0svdEFLcVdFYWNBMFZPMXd5RWRSSzBH?=
 =?utf-8?B?dVFVZmJ4M2NtMW13Z01KYy81U0N0bCtPZkQvMEhrTUlLR3F2TUFSWFA2bThU?=
 =?utf-8?B?OEIzdlhhMG5QSmNIbHdpYlA4WmRBYVRKQmMwZGRXenAycThqQXdEUC9mUEFh?=
 =?utf-8?B?VndnMFMwYmcrVzU5U2JZL2RScExFZTJSTEJ2YU84bVNyMm5DOXovOVV6ajdr?=
 =?utf-8?B?SnY5dTZxQUhEakE5Lzh6cU9oSmx5V3ZTeHp0eGQ3Y3dLbE9xSFkxN3J4TFp5?=
 =?utf-8?B?a3Y1WHplVkRvSFhRN05OUDZmMnI2UWp5UEdtTHJXVDBSSVNud0d1dEo3dGNv?=
 =?utf-8?B?TUZ2RWQveVlSb25Dc0ZVTkVsNHlhZUFURjZDZ0FpaWplWVhwL24wTVJjc0VM?=
 =?utf-8?B?Wnp3eW5YS2l2cTFIbWFuaDlYcUQxb2tvMmU5Skp6S3lJTVkxSVAzSUtvenRD?=
 =?utf-8?B?eVY1VUtCbndhS2h3THhpNWlEZ0tOV01TUC9ab3VteXprQVU1QkYrdW9UbHow?=
 =?utf-8?B?YlVEM1lCNHdnQzhhc2R0eGJ5VUNISW4rSFJ2Ym16RW5JM3htTmRhMDFaOTNF?=
 =?utf-8?B?Umk3K0UzbXpBUTlpRVdxb2tMY2FNZkFSSzR1SjV1VHhOZzZpM2trekx2eldO?=
 =?utf-8?B?VmM2UlZ2cjFGZ3YxTEFhOFh0ZHN4eHl5QmlEdXE5RFZhemo1SmJuQXpkQUJV?=
 =?utf-8?B?akhPSEdGK2FMK2ZhUTFOQkRjWVQxNFo5dTY0S2ExWk1uNlRoQU9vcWxIcEtY?=
 =?utf-8?B?VHJPNGxhYUV4L05rMmtqVFZEMlZoczdKTCtIU0ptcXdrS1JqdFl5akRsaXZs?=
 =?utf-8?B?TDV0NjJMOUhqQ0FMUG4yZXRXNmVEcDJGb2Y5NitKdWNPUXQ2UTFKeFF6a3JO?=
 =?utf-8?B?bHpVK1BQUHhVWGhCUlp3NC9tbmxib25QVm5yQ05uVU5sajhIS3hWMyt0cDNM?=
 =?utf-8?B?ZE1GdTJhZEJGbnErMTdWMW1nQzJRdUp0VGtpU3pTbHN3ZHNlVmJLNXF5elpT?=
 =?utf-8?B?SGFaazVlcHppUG0zNW9HaWhhV2VxaCtRL3h0TWIyZjhibGI4VEtIbE1tYmY5?=
 =?utf-8?B?SVNQeUc3ZDluWjU1M3lJWXdCU3hSM1FxTDR3TnpCOFVLbGpjdHZ6Tit3THhE?=
 =?utf-8?B?UktTVjVScE8wbks5U2wwOHBMTGtSblZXUHhMNXlTTndXYmRuVU03OWhLZTVt?=
 =?utf-8?B?UzN0ZUpubnYrNG1aOEdHN1VrN1hEdHJaYldQSXpybTZrc1hSb1p2L2sxWDlt?=
 =?utf-8?B?SGxSS3dVbnhuZ0E5aGhGTVRmNzR1U245UjJ1d044a2drQUMwb3lEaGwzQytW?=
 =?utf-8?B?bTEvakQ3WkpnaEY3NkpYdU00UXZWcSt5aFhZaGxHK2puSFZDakVxZnV2bi8w?=
 =?utf-8?B?Sk96MHpJZlcrQmR5STNkQXdSN2xCYWdtKzZsV2FwMjdPdllvdDNBcUNNSjly?=
 =?utf-8?B?MWFtQzZOS1E5L0VnUUs1VUk3a29HVU9xSEI5TUlSclpQeU0xS0xmVWVSV1ZW?=
 =?utf-8?Q?Anwidm5JcGW0aohptXzbiIsoo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e45a9dd-24b6-441c-c4c7-08dd097b9042
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 15:54:06.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcC5Rl4X9LrGshsk1+aqGZVJ0jt8m7u/enaKcT12t7bId3QPDoHgjLjpJO5QA+rE3iDsidZLu6wY74qpqo0tjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429

On 20-Nov-24 8:16 PM, Peter Zijlstra wrote:
> On Wed, Nov 20, 2024 at 06:36:55PM +0530, Ravi Bangoria wrote:
>> Hi Peter,
>>
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -11778,52 +11778,49 @@ static void perf_pmu_free(struct pmu *pm
>>>  	free_percpu(pmu->cpu_pmu_context);
>>>  }
>>>  
>>> -int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>>> +DEFINE_FREE(pmu_unregister, struct pmu *, if (_T) perf_pmu_free(_T))
>>> +
>>> +int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
>>>  {
>>> -	int cpu, ret, max = PERF_TYPE_MAX;
>>> +	int cpu, max = PERF_TYPE_MAX;
>>>  
>>> -	pmu->type = -1;
>>> +	struct pmu *pmu __free(pmu_unregister) = _pmu;
>>> +	guard(mutex)(&pmus_lock);
>>>  
>>> -	mutex_lock(&pmus_lock);
>>> -	ret = -ENOMEM;
>>>  	pmu->pmu_disable_count = alloc_percpu(int);
>>>  	if (!pmu->pmu_disable_count)
>>> -		goto unlock;
>>> +		return -ENOMEM;
>>>  
>>> -	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
>>> -		ret = -EINVAL;
>>> -		goto free;
>>> -	}
>>> +	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n"))
>>> +		return -EINVAL;
>>>  
>>> -	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE, "Can not register a pmu with an invalid scope.\n")) {
>>> -		ret = -EINVAL;
>>> -		goto free;
>>> -	}
>>> +	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE,
>>> +		      "Can not register a pmu with an invalid scope.\n"))
>>> +		return -EINVAL;
>>>  
>>>  	pmu->name = name;
>>>  
>>>  	if (type >= 0)
>>>  		max = type;
>>>  
>>> -	ret = idr_alloc(&pmu_idr, NULL, max, 0, GFP_KERNEL);
>>> -	if (ret < 0)
>>> -		goto free;
>>> +	CLASS(idr_alloc, pmu_type)(&pmu_idr, NULL, max, 0, GFP_KERNEL);
>>> +	if (pmu_type.id < 0)
>>> +		return pmu_type.id;
>>>  
>>> -	WARN_ON(type >= 0 && ret != type);
>>> +	WARN_ON(type >= 0 && pmu_type.id != type);
>>>  
>>> -	pmu->type = ret;
>>> +	pmu->type = pmu_type.id;
>>>  	atomic_set(&pmu->exclusive_cnt, 0);
>>>  
>>>  	if (pmu_bus_running && !pmu->dev) {
>>> -		ret = pmu_dev_alloc(pmu);
>>> +		int ret = pmu_dev_alloc(pmu);
>>>  		if (ret)
>>> -			goto free;
>>> +			return ret;
>>
>> pmu_dev_alloc() can fail before or in device_add(). perf_pmu_free() should
>> not call device_del() for such cases. No?
> 
> Right you are -- but is this not introduced in the previous patch?

I didn't notice that.

> Also, this should cure things, no?
> 
> ---
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11810,6 +11810,7 @@ static int pmu_dev_alloc(struct pmu *pmu
>  
>  free_dev:
>  	put_device(pmu->dev);
> +	pmu->dev = NULL;
>  	goto out;
>  }
>  

Yes, this should fix it.

Thanks,
Ravi

