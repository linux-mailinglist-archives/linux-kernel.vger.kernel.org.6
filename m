Return-Path: <linux-kernel+bounces-288492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE3953AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B69283F07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BAD6BFC7;
	Thu, 15 Aug 2024 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YJR8R7oT"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020133.outbound.protection.outlook.com [52.101.51.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98F3214
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749360; cv=fail; b=NMHWeDie3D3Eq2cqeL2+HpgexCTfibN3taiRUW/780k+8kKe+boTPich3paOgQQveqSWDVndMeVTbIR0XcKK1D5s3SCWgExKk/I55GQCmDMpidEVs4LpM5DrRn7wGe/S6/e2fW2gqnES0kRy0QLQnrSkmAS0STds5H/Hm7VsVyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749360; c=relaxed/simple;
	bh=1sw9HdPQpnYyoLUnk78XzA17YkJ6XLs1OPkbB/b4t9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e0RmPQGk34sVwkDmrVaFxDuzpLntSMNp9bXbhx99PMQ06ezHiPjbK4CK8bJ+Ox8u3LnFgmswYv7dO8NbbaAQrRwF4m94UDRgbYk9vyQ7MPHbzHUFpAM/rQyuGha5zou/ai4L4afP+fikUCo+nhgeqgnXICEAQ+msBf5Hd9kE63U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YJR8R7oT; arc=fail smtp.client-ip=52.101.51.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4t3lLVFKMJM37kXAow7qq7LWoWjNFXPL4WEhUnEmrJMn+GblXj0WdxlJNXl71a591IHqOCbwHeKTxJUdype6yv+lobkDFsYTKAWyE8Vb+lJR6GjavMAx8k1mIH0Fu6IFE8yeSu8cB1FR3wIlylHANzlUb+mjfG7fXeK8bZ1Y/GJ8g5hmX1MiP06mmgnfOLYHDcRyedmLZubYhmyS15FLatIf9VxUnxBTYeZlENw+Mny+TnUNUrMYlWKZu7deTTVSYWFWWNr18npOiAxgwA12/PVBok2+y+OPYp69SWtfEPE6AmsLsrJ9cn8uZeDszJFb8lf/SsiO8jfPKlIlHJB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbxCeyeXiUu5FTp2ZQyZiowLQgY0aKFvWDnigBwAsxw=;
 b=p3wg0hD33KK4KSHnOcJe8oTfnscb/2Dc2u5+4MUelURsBcaxjTbMOcpeF+DurMTUn95SaK9SAZ1XgQL5wVI9UrGOwulrBBKw8s6wt1SUmktvoTO+NJRodL+JJjOTayTyLRn0744jMkPKXogRkYwPQpFhY6f4+sfF1f9vx9xarNG1ULKThPHablsyP+nASOx+rjvKRsHH6GZ8sWZXYfUNYPneB4h/eH1f1/DvCvIunEChElwC8YMVjc65naADom0vDXEBEscq3D5p3fkeJpbSDnVv9Jm4sGsW/YY1/Qcbp3TsTwEccOtr6Bc8DymnjQqalHDZpJ20k9F/QGj04jDSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbxCeyeXiUu5FTp2ZQyZiowLQgY0aKFvWDnigBwAsxw=;
 b=YJR8R7oTYeja/BaPBkIOWm+5jyCRR/f/7pdPJdA4QO5EMVwAvXcadyhSpKoqUMKVDiLaFiQgH3M9ei5RLiwGomvxoLi0irSCRyMJF/31tGNGn+gn0j7zjJC/m/55m+GSkuPXZBCxbuHzl09XQtJdekbiXr2gvyJ6++y3sr8YE3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA6PR01MB8951.prod.exchangelabs.com (2603:10b6:806:42f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.23; Thu, 15 Aug 2024 19:15:56 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 19:15:55 +0000
Message-ID: <a63b8bb1-1b83-48cf-8f3f-9d26c8a33ae5@os.amperecomputing.com>
Date: Thu, 15 Aug 2024 12:15:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hugetlbfs: add MTE support
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com>
 <7a4a60af-e471-484b-a4a3-ed31daaca30b@os.amperecomputing.com>
 <546bf8d4-3680-4af3-8d4d-af2d7c192d04@os.amperecomputing.com>
 <ZoanN7hkWDBjCTu3@arm.com>
 <b140e3e1-cbf7-4b07-8239-abfe8b85d14c@os.amperecomputing.com>
 <Zr3ZFmRqtkbrOJq7@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zr3ZFmRqtkbrOJq7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA6PR01MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: f95280f8-5f0b-4d56-ea17-08dcbd5eaff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDdNd1JRdzMyWWc2aUNaZVdsd1Fka1NuOFFjeW9UTjFmRWFMSVBkZ2w3VWpr?=
 =?utf-8?B?TDNKUCtDeVhxN1hUbUxGMHN5WWJFb1RVUnVnUU0xNlhPU2ZzSGFTNHBhZFdH?=
 =?utf-8?B?UjMvWTd6QTVtamM4NFZoZkdwZkhGMTNnYW5CNlpGSlpMQ3Y5dldkRUVMQVM0?=
 =?utf-8?B?OTBvb3lVMWNUeWZpZUU5WkdaRDdGaGNCa3hob2VWUUJsUDBwNVh1aDNvdUcy?=
 =?utf-8?B?SGRUWEZQT013UW9XTnEzeklRUUhNSHVxRVNxandjSExzNW1heGYrRDJyejFL?=
 =?utf-8?B?Vkczd3U4N2ZnK0NJRjluM3E2UEtSVGFpd3FLajhMQUZ3bHpLZ3AzTWhETVZW?=
 =?utf-8?B?WHNDWnp1TDEzdjg2ZzJDZ3ErY21LcWFmWDVaeVdHd0lNMVdtOHRpZFg4bERk?=
 =?utf-8?B?N2h2UFpTQng0LzR6ZHBISVoycGNKb0ZZN2IzMko3U28vUHI1T1VrdkVOZXJR?=
 =?utf-8?B?eFFMdDZ5dHMzUTROU1U0VldNUW1LSFB0NDZBdDIrb25Zc1paL1BmbEhlN2Ez?=
 =?utf-8?B?WWJGWkFmTjBDOVJRVzIrdlhod1d1ZFVHbmhkUEJFT1FqeERoR2xjazZHQk5V?=
 =?utf-8?B?YkpZYldDc2hIQWxaT3A2WU5xZVpzSlFkSDlORU1ucmJyMC9HMHNWaVl4TXhE?=
 =?utf-8?B?QU91Q0xBQktjWUZremd3YkxZeWxTalkvd2xKdVhzSVFoWUcxaFVlRDRpV0Nq?=
 =?utf-8?B?bW8zYjFOY0VoY3dJMXg1WnhXc3N2ck43eXZrUWdhOE0xK1hLV094dGJURUh6?=
 =?utf-8?B?NTlWSTJWRlJhRWZBZzVlWVNnOVpSVHpXdkg0dUpTeDdmSDR1Smo0WWZvUUFJ?=
 =?utf-8?B?VWdiZWNqMXFYN2FLMEc2cVY1MUNKK3J6NFJMdVZkcmRLM1N5T1hDQ3dqdVo5?=
 =?utf-8?B?ZXMwaEZtYVBweXM5dGxueWF6UGRPS1IxenhuVXdZbHRZcHFHaFZyVW0rL09t?=
 =?utf-8?B?MnNhVHF0WUhBZUNWR2tsc1M1L3lrdXQ3VG1kcmFSQzgvbzJ1QVdDZDRPK0Uy?=
 =?utf-8?B?WkJJQ2l1ZTVMUHNuU2NCUmtlL2RxZjZLdHNBd2dlSDBxQWNmYjUzOUJ4bVN1?=
 =?utf-8?B?dWgwUElpbnJpaFF4L2F2T1ZJdkNFU05OREt1VEc5ZFpOTytXK2Fyak1MaDc0?=
 =?utf-8?B?d0RNK2NNQWpMb1d1b1RvbkhqSHprNmNqUGNwdHFEWWQ1MFRuTmVPS0lodG5J?=
 =?utf-8?B?NEdFazM2TmV6dHF1UmwyN0NnY1N4MFFjUTVXdDUwTDZDV3lGc0oxcHpZTmVa?=
 =?utf-8?B?dm1UeW1GYnltOGtOcVUvOFdGVHQ3NUN4TDBFSDM1aWQweHhRbEdraERacndY?=
 =?utf-8?B?Zm12dFhhSVFQcytWZVZqK204RlcvRWFrT2NUcWRyeEVaUHlyb0pxUHkyV203?=
 =?utf-8?B?Q1MvSWluTm1Cc2lUUDNVMCtCN2xzK0tCRDdRUXBTQUQzT0c3K1FiaG5iTVJF?=
 =?utf-8?B?WFNWcng0Y3hRRWJuSjFJdmQ3S3IrSERDUlJ3SjJtcE5aUmdwUUFKZTVOUEEz?=
 =?utf-8?B?dUgrWVNCSGR1MGFUVW1EOXNvK0tSdmFKeGRlc2h0aWVJYjlLZEVMNXd0eHpp?=
 =?utf-8?B?dmp3UFZkQnVSMTE5YzVxOE5zc1NVNTE4TU5yYmwvd0l6UDBYcG9WVFB0Mk9z?=
 =?utf-8?B?dy8rYkNKSUlLQkFsNTE5SFJ0STFuK3RvVjBuWHZPaVFCZUk1RS9seG1xaE9W?=
 =?utf-8?B?azV6YnVhZDZYWlFFRHM4TFVyQXFLZVRRVHBIeVluSzg2bmdLS2V5cWRKdGFS?=
 =?utf-8?B?UkNja25Ra1NzMUxFUmNSMlppU205QlpLSU4zQjROV2lFRjBOSmNhYUFaeXRp?=
 =?utf-8?B?b0VMQWlnbXJXU0RsSHpKdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFRwN01xZjhnc2FzOWVoTVNhZ0E2MEE4dWo1by9wR3Yra2J0ZWs3QkE2bGdO?=
 =?utf-8?B?anRXZWhtZXg5VHBxUzh2Y2pUWFdncmxwcm1Cenp0MWZ2K2U4NmdpM2puSTM0?=
 =?utf-8?B?Wkp4U2YvU2Z3RC9Yb3JPZ3daOXJOM2RkYUxXKzlRS1RMUmpuK0xIZHlLd1Az?=
 =?utf-8?B?dGMySWMzN2ZQdTg5ZkJ1cTB4SWpqUzg5OHlVRy9rTWdWbUlFU2tvd1MwbU1Z?=
 =?utf-8?B?cjljQ25mR0lpbko5d3JhVmhEMHdObzRnUGJJS3FOR0RHbFpnTlJtM2I3WnZE?=
 =?utf-8?B?Y2ovbDBlK3pBRTY0cUs5UG9PaEZWL1p0MXJyWXRQNG9xTnp4VWJ4SDg3K3hl?=
 =?utf-8?B?dER1WnBkRkU2S3F6SHBGU0IyblE3bFhXck8rNy9WOXVRdTJjeW56cmtuN0lv?=
 =?utf-8?B?bjRSMFJFakJ6RXhBTmZ4Y1Q2OTJpTzBraXVGcktONEVrRFJRQXZBZkk2ckdp?=
 =?utf-8?B?VXc4RjRJS3pRZGFZTlZUUzZZbGxwVDlJajArSnhvWjJVQWNRWlJ5MUkvQWk0?=
 =?utf-8?B?R0prK1lKV0FhWTI2NUlmLzY0TXpmLzk5RzJwbjg3NFc2VkxuNENHTW9TaGNN?=
 =?utf-8?B?a01aYXFhYmQwN3pIcjBGVjhKbm5nVjVEUWg3VXMwTm5CTjVMWFMyMHUrVWN5?=
 =?utf-8?B?OWVQMlVPbk9oZHBnSlZiUWNwYm53WTdYMnNuRGNBaFlDNWwrVHhCMkRwWmN3?=
 =?utf-8?B?NzhGS1VrdVNMaHE1eW1haGsyWitET2t5VU14YlZ4czZZTkVrQU1DdHNjbWVt?=
 =?utf-8?B?M21rczNYNXVnUDhOWmNwbDBtOTRqRXdHb3lFU0lqUjZpTkMxOG93dExsR1RJ?=
 =?utf-8?B?UU9Ycy9CSjlNcHJpWlRoYUJjN09vaDVobEZZL0JHV2dHQUVpSkpLbkthYmd3?=
 =?utf-8?B?akhRVEQzaTVVZWp0Yis5bGdJYW9GeTBKQ0hzRElkRkk0bjFvTFEyL3JEWVVu?=
 =?utf-8?B?L01TZ3VIN2lHWjJ2cWZyamM4OFIzUi9yMXhkSW9SUG9vNWRqTnpVMFBqRXJR?=
 =?utf-8?B?Y3JOdWxHTTJPcjVlZ3VNL3NKMjBQazNiM09VOXl5YlQxZlBaM3JvQ1FDRzk3?=
 =?utf-8?B?UnNLNEhqRVMvTSt3cE9keHhTV2szVjBkNjBFbjZrSmlsaW9ScGZwSlF4ZVgv?=
 =?utf-8?B?MGhFdHF2cEpLUnZTb3U2ZDhFeU1RVkVvTWt5QXRRa1oxMGtZS3dCQXhhMjVa?=
 =?utf-8?B?VkN4eGVhY01Ka1pKWmNkamhQNERLYXE4Snhwb3A3NlZ6c0phRkU2dnZzcEo3?=
 =?utf-8?B?Um96WUFEa3ZleVFDYjQrT1Q4K09MWTR0VUdSY1UwT1krdzRsME1mZGdTZVdw?=
 =?utf-8?B?WU1FOWZGWlA5ZDV2cEdBb2J2U1VTTWwzUklWeUszdUQ0WFJiMEdwMzZyWStp?=
 =?utf-8?B?Q1IrcDlWdmZmRTBSQ0dYanNldUtydWdiblhicDZSaUN3bE9vV1k2MlNyUXB1?=
 =?utf-8?B?WFIzcVErNzZ5VituZTBsLzVtYTU5c1lrRTRYNVhjZGJxUG40bmVUUkJvL3ZZ?=
 =?utf-8?B?N1hCZFpJWnkxeEZwN2RIQ29FbXBmUGhYdmJUcnJRVGg4UW0rV25TOFZZSG96?=
 =?utf-8?B?VWVSNVkwcE0ybUFFOFFQTlhId24ydmhGZkxOWEx0QnR5UG5FK1lWcVFKMkZT?=
 =?utf-8?B?YlJsZ2pXWUxhUWpVM056NjVpVVN0NWQydlY0Nk95QXQ1OXJuMnViN2VqSXVr?=
 =?utf-8?B?TFVQV0RrVVBrenBwK1ZsVzRWdzdaallqdStKdHlKREFIVTkrVmoyQ1VQRVRU?=
 =?utf-8?B?cjVBVWZxdFhNYVNpaEgwNGpjQlV4TWxtMVhMOTdKamg2MUtKS253NXo3S2ND?=
 =?utf-8?B?dzRmL3lLODAyZ1dLWlpXbTV2aHMwcE9WT1lXR1Q5TU9Ld0ZNb0RVbWVxaERY?=
 =?utf-8?B?S1E3VVEvNVFva0VaSHBHbFh4T09MYzVkRUt1djhyRzI1ZWEwa2V2dVFCZmdQ?=
 =?utf-8?B?QkthWTdIMWxYR1VHSCs2Q1FuRFFTMEt1QjhVR1gzd0V0OWFlZTN0c3RyWkpn?=
 =?utf-8?B?Q2RITkJSbFYyY3FITWRWdmdPN3lacWh4Y21tSklISmZGbm1XVExBaUZxcWcw?=
 =?utf-8?B?NnBNTGowNW9oWEVXVjVGd1E1RmFOQm80cWpXMTB4UFM1MW1tYnBlSExibCtS?=
 =?utf-8?B?Y0JpbmtPTVR0eHFHOG9FMHJIOGRaZVNMU1JnUVpNc0tIM2VxYUVzTVFYOU9a?=
 =?utf-8?Q?lY3KwYZe4KnQvkOydCzpuDM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95280f8-5f0b-4d56-ea17-08dcbd5eaff7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 19:15:55.8227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENCzS1sWCZ4/l7gyFP7GVXbeSKyr9FmDn1GzBsgeW4+Jyx+R1CIQ+TS84A2ZYb4tBbupU60VqTUbrGXsGtHLOGYfXAdVmmsAfZlt2O4gP+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8951



On 8/15/24 3:31 AM, Catalin Marinas wrote:
> Sorry for the delay (holidays etc.)
>
> On Tue, Jul 09, 2024 at 10:42:58AM -0700, Yang Shi wrote:
>> On 7/4/24 6:44 AM, Catalin Marinas wrote:
>>> It might be better to convert those page flag checks to only happen on
>>> the head page. My stashed changes from over a year ago (before we had
>>> more folio conversions) below. However, as I mentioned, I got stuck on
>>> folio_copy() which also does a cond_resched() between copy_highpage().
>> We can have the page flags set for head only for hugetlb page. For
>> copy_highpage(), we should be able to do something like the below:
>>
>> if  page_is_head && page_is_hugetlb && page_has_mte_tagged
>>      set page_mte_tagged flags
>>      copy tags for all sub pages
>> else // <-- tail page or non-hugetlb page
>>      current copy_highpage implementation
> Ah, so you want in the first copy_highpage() for the head page to
> populate the tags for the tail pages. I guess this would work.

Yes, because we know the order of hugetlb page so we know how many tail 
pages we need populate tags for.

A deeper look showed this may be the only way to do it (if we want to 
have mte page flag for head only) because process_huge_page() may 
starting copy from the middle of huge page to have hot sub pages in 
cache. The process_huge_page() is used by hugetlb fork and COW. I think 
it is safe to do so in fork and COW path too since the destination 
hugetlb page won't be seen by the users until fork or COW fault is done.

>
>> The hugetlb folio can't go away under us since migration path should pin it
>> so the status of folio is stable. The preemption caused by cond_resched()
>> should be fine too due to the pin and the page table entry keeps being
>> migration entry until migration is done, so every one should just see
>> migration entry and wait for migration is done.
> Yeah, I don't see those pages going away, otherwise folio_copy() would
> corrupt data.
>
>> The other concerned user of copy_highpage() is uprobe, but it also pins the
>> page then doing copy and it is called with holding write mmap_lock.
>>
>> IIUC, it should work if I don't miss something. This also should have no
>> impact on HVO. The overhead for other users of copy_highpage() should be
>> also acceptable.
> I also think so. We also have the copy_user_highpage() on arm64 that
> calls copy_highpage() but I think that's also safe.

Yes, it is used by fork and COW fault by hugetlb.

>


