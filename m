Return-Path: <linux-kernel+bounces-447477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D242B9F3315
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321A1188AC66
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11201DFDE;
	Mon, 16 Dec 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iTya2jZI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6514205AA5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358878; cv=fail; b=OVqDeKWa5fX9945G0X9Cap0ud/46jn3693BgxJVJC8sMe/XxITjrlW/OvcGIeTJbUCuErWGwxJKmK9sRBnuw6Sq+CDDyP8EfRkvCwGKwf7ewPSWLVzJm2gt7BF8XLce1sd9JceSpp3FCQ3vvsckgOvDQruHtb2mpBkgSImzix/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358878; c=relaxed/simple;
	bh=ui6qg7GmWFDtoy/OxZOzqDygHodJLX/gBS4CdbaTY4w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pctkOMMvYDgg1uCaOu6z+GwGVXAYufqQLt0WoQA4EwAwRVZRwlTf+ZezAK8NCvtIsgl5vTyURH9hWYTOXF0wiwgXmFJtnlbBvsDPAOb2v/nPUsMRfs8HKCJaCuNb05tLWHkN6cZH8tL78VSWSEhwRFndaijjyVHLbbQIvb/kUZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iTya2jZI; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryx4im1Yt4Rhwq+HrFWCiMjCXZNPk7ewP9cCHhjlYkQ+ieJJnK+uY4+uKrH6FqKnjOuxJ5QpxI0g5FQh+6gi9kTXBuvazFhaAuEb5vnXSb2fU/lBTmeDhDwRw7fZt9cy1ZUrK3/eN/bJVFgBAyBkTVHYHYQyrb+2Zz4qRJQ4nN4XSgjkpLgYv8UP17gR2rQlFhiIVDEMSDVc5q3o7hVryobsV0HIR9FSkgRvV9+Tv2jlx4DmgJXu8cuh3KXuP+Hr/dBJlAve4QQQM1B0/6W+WfPvQQY0Uab6T+6GF2kH3IwxbLP6f58QrVspLPB7QJia31lLbN8cnPjfTxds89YGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui6qg7GmWFDtoy/OxZOzqDygHodJLX/gBS4CdbaTY4w=;
 b=YHmC/pRePjpFhOZzWoo1b6oxdSvhYpSboNxCbvNZBdDmKE/gZSRdehiWej6ivM600OuZ879VNDNqQXp47eNf4QSX0UxlVzF+0ZG+/DC3R1ikuKmQu8kT8ivjQCJqIUrTBtkrGaGJ4Imp31msbPeqQdJ+S/epQKUCBAg3nYBlfco81cXV5db/u2mA+A2hI+05w8yK7MIR+M6WHGFTAydWnCJKBvw7U9W7u0gEK4T7c5a0hKKSlChnzn+TbJbOHzRLNM5BD3xW8ShaYoU2DdWN7Hdi3WE9njhfPoK8P/6zs9ijxz+DTRRRouBcTSAASUxWIIf50dUq4zV4Rs9rQcWFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui6qg7GmWFDtoy/OxZOzqDygHodJLX/gBS4CdbaTY4w=;
 b=iTya2jZIzwWZw4/CVRsmaQFzR71urdeM1Xp7Xi6xBMCHG9WoZ2Jh+f4yj0Av4UA78eq2n7eeqjAwnC5H5gF9rwdQgtlIOb2haYaBmZ4tkuXsju1EV3rCDOeESNqIdX6y9tj4ak1N6ckx4aPdQqPF/E13k0EuFD2zfhJLNzbGow8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 14:21:14 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:21:14 +0000
Message-ID: <12d538e8-45ab-81db-896c-8047f299532a@amd.com>
Date: Mon, 16 Dec 2024 08:21:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 0/8] Provide support for RMPREAD and a segmented RMP
From: Tom Lendacky <thomas.lendacky@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
Content-Language: en-US
In-Reply-To: <cover.1733172653.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:805:ca::40) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: c5999d11-ff76-4603-87ef-08dd1ddce5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWZvcDI4OXdVSWVUcTc3cnJUQ0IvV0owQXphc0QyaHZyVFd1VTQxQnZRakF5?=
 =?utf-8?B?NWFZQ1F1SERhVmRXWEtzaFJOS0p6Z0RDb255U29DUGEyN0ZBWUs0aENtMDYv?=
 =?utf-8?B?a24vOU54ZDUvb2h6eDhMamxQa1lzeEJMVTN1TlRoalpyRkp3aVdxcVNDYUZG?=
 =?utf-8?B?OU1hQzhoWW1SNFBHTzVWSVVGaXpSQTdQaENtYnZVZnhMUExyc0UvUmhQYnh3?=
 =?utf-8?B?a1pxZEVCQ20zWnJ0T3dVNVdLYmRRaWgybVBoVW1TMjc2MmJLV1I0L3NJTk1p?=
 =?utf-8?B?emZCbzMrRjlZMGVEZEdUazlJYmlxci9rbEVubmNYSm9iNWNIdXBHcmFpVjNi?=
 =?utf-8?B?TkRtNGZSWG1xNXN4dGE4cXVaU3pWeW5aQjBWT3NWV3ZUQkkvdVB5enhTUTdU?=
 =?utf-8?B?VHAxUXJwMjJodS8vck5uaFV1anF5MkRTdGhMWlVpNUY4dkhRazN4Y0dkbEtm?=
 =?utf-8?B?WndEU09LRHlMekFHNCtrZkhHLzZqVXo0blhLRzNzdStqelBKUFZPcCtpTG5P?=
 =?utf-8?B?UFA0emwvTEtqaE90ZG5kNHlGdGVHL2swWmlUbk05dW1wNEFHWDdtRzhha0Q2?=
 =?utf-8?B?ZFd6R2hqc0VPS08yRzFMcXRYRVhTenVKUDNxMFI0WlNTZWRsNVRHNG1DUTVh?=
 =?utf-8?B?TlVkekUrYVhJa0xMMWhHSjUvRytvTys4dkpxTGo0ZHNoTHBPbTVBVmNTK1Va?=
 =?utf-8?B?NVR4Rk9IMWJ0MFhYdTlwZDgyQ05ZcVp3cG1QTUpRZ3ROWGthUFNZYUk1YlE2?=
 =?utf-8?B?TTdvMTg2QTYxU2FDMGFFMzdTQ0FJeW1mV2czR2hYanpiRkRSbWJVMnVUK3A1?=
 =?utf-8?B?ckNJZG1mcnJnSzUzbjBpTkxYc2dMT2V2bmdLa2NOcWRLQUQ0Q013MkJOZVZh?=
 =?utf-8?B?eG5LRm9oUEtJMmozNGd0VHFmeTk0L3FOdFdhOHhrYVgvWWlBR2ZhTktrZFZy?=
 =?utf-8?B?b1pvK282SWhlZ3hRTTF4YVVhSzl4d1VlRmJEZ1R0MnkyRmt3YjNoMW1BRytT?=
 =?utf-8?B?U0NDNkFYTmV6MjhIY25oVFZMZ3cwWkFUbld4bGlvMmhSSDFEc2s5UE9rZlBZ?=
 =?utf-8?B?Y2ZZekFQdzhnclBHSDkzL0kyb1k2S0h6QXFhQWh1Vzd2N3Z1d01IOTZ1R3Fj?=
 =?utf-8?B?QzFtRW1Ic1phVG5UdHQxUjBoSUpTbVV4a3FqR0ovUEhlS3RSYmd6VmlzZk4y?=
 =?utf-8?B?cWJJL3dSY0pPbXU4cUF5MGVYaWw4RGtPM3cyWWFITEI1QnBxekZIdW1xdzZL?=
 =?utf-8?B?eHlGZCtuSGZKZHhSNDJ1R1dpeXoxYWp2a0FlQmg3SU5makZxV0RYSnlsR0hv?=
 =?utf-8?B?a0V1TXhhWWIxRE9kYnk5ZE5SQ05tU3Nhb0ZjV3Z3QWpuMUxqNExFekVIaGpT?=
 =?utf-8?B?b2lUT0Z0eVNoU2h6dlV3bjBtSkJvcXdVbmFnY0p1ajJJUWl6M3l1SEZTVkhW?=
 =?utf-8?B?bXllSHUyUk0xZGJGcDJvNUZJVThscjhOQnIwL09qUmhWQWJ4eW4ydVgrRE44?=
 =?utf-8?B?WjlEa3lPclhkRk9oK3ZkdVY4M3NQYkVPc3JBWlhaN29zakJMN1ZlbEl3aG5z?=
 =?utf-8?B?SW1taVhEWFRuV3VDaFlnTjBYZlpnR3pSV1dva25Dc09MaGxYWHY5VjFMR3lG?=
 =?utf-8?B?TXo3TVFWNWxXb29qTW5vMW5zWnVOVGlnSEc1VGRtbTF5RFFJZjhpaHhCaHYy?=
 =?utf-8?B?eDBXSi8va3pBWmhNRDhmUUFhSUh4RDdyT2hwQVEwNVBQTnpaRy8yMFhYL1ND?=
 =?utf-8?B?R0VuTzFPbHlsVVJaaUFXL3R1WWlaRGJERDhTQ0hPeitHOTJNZVY1QUw1TUV6?=
 =?utf-8?B?TXZQSTFRaFRiNWZDSDNWZC9ZQ2FkOVAxR3NWVFNjeHJHbDcyTWJ3YjdhcE9H?=
 =?utf-8?Q?xAnKlmZFBCQOg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXFXRlZjRy9kdHpEeGpqc1ZMNzh5SzlWZHlZVXlLTG5YdURNcjZjb0xQZlNu?=
 =?utf-8?B?VnVjSzJUaEVLSTlqdFRrZjdkdTZrYXJVS21tODM3ZzhpcmVlVURIaDNRT0V2?=
 =?utf-8?B?WnBzV3BxVklNMzUvcVpTUVJBNTAxUVFQdFc4a2ZxaXZDb1dwUHJPREJTamxQ?=
 =?utf-8?B?VTZxZWJUcFFmVkdJaVhkN1g5VEJnVi90STZnWm9rRXZLK1BoV3VSbGZvSDlV?=
 =?utf-8?B?TTBxd1lMVVJNL0lMbzBOdFFhTndVblR0YkRmQXRyaUQ1Wk9ZeUtRVEw1d3B2?=
 =?utf-8?B?M09WblQyNVN3eEhJWkFvcXFYdm5mZGtrQnp0c25NaWpCdjNwTjFoMVZ2UmVK?=
 =?utf-8?B?WGNvYnIrRFU2d1p3T3FMUWoyVzdRRWhqdnN2TGdJNDhHYVhoMnpLblFtWWNN?=
 =?utf-8?B?T1I3TzliT3Fjais5REFtV0gvdkorQVdtZ21VR3UrTURxUVptODd5czZCc01G?=
 =?utf-8?B?ZFZQSjg4eVk0R1VTd01BQkdVeDNHR1FhMWlBTWZZL1BPS3JUNUQ1ekFWaDJE?=
 =?utf-8?B?RTZRZzVGVlNkRFdvcmN4VlRMRmcwdHBQcUVNclVieHVEbkwxcFhDcGY1cWFN?=
 =?utf-8?B?cUdxN1ZpWHhBN0FPTzM0Y3RQdzdmWEROalBZeVFFZHZsVTlnd29QNWhyQkc0?=
 =?utf-8?B?UWR0dFMwbkF0SGtvbDA3R25xa0ZNa0FvNlJNcDIzVHBXUEZxKzNMVHFzN3Uy?=
 =?utf-8?B?T1JNb0RMSkhtZ2dEMHRFRDllRFBaZDEwUGZrNElPYjlHYm9xSE0wYW1xaXlK?=
 =?utf-8?B?eGFKYTg1QUV1cEVZa1RibmZjazFYQWVEbkF0SDl5YUttQk04RXBkampqcS9G?=
 =?utf-8?B?M1hteVd1bTBYN21RbVdrdk56VTJyaThORG1URVFGWER1UkljTzVGcEZvOG5n?=
 =?utf-8?B?WDR3cFR5ejRIdHBXMDI2Z2ZvMXRQa0ROdXBtYVh6RzR0WWZZUG1tWkRIcC93?=
 =?utf-8?B?ZHRWd0xzVDRobElZNWZJRmQ0OGRWVW9NSThudHRGd0hnUGdlRldpbFRGZjlw?=
 =?utf-8?B?UjA5Z2NKWFF1RStKWS8zcXZBaVFxUzc0OTVGZmljZmZhdXR1aHV3OUJwbzFI?=
 =?utf-8?B?VjY3bUJNaXBGbmNCdms1bFJPbHYwczVmSGdwSnpSUTRkKzY0TVhZU1E1KzdP?=
 =?utf-8?B?VFlQdmo1V3hTeEhreDZUYmNhNkxrL0hJWFY2dEpZcGU2Rmh4QVFuVlpyampF?=
 =?utf-8?B?UnpaaXRZYjl5WEU0VXV5Zm9VVFZ0VndWZkdBbHJVSVFteDRiYjBWTHMvTVZX?=
 =?utf-8?B?SFB5c2pEMDJyVFY3MEl4eVFBNzFSb0VpQnhUcWtudFR1M2RGQlEwN0FEWTFo?=
 =?utf-8?B?MEdhOFlNbllOUGVDK0QvWXRiWmhuVnU0djZnRTV3NG9jN3IzWE5VOXZRV2V3?=
 =?utf-8?B?MUVyWTN1aVN3QXU0elhnMXhlVC81aEVPT3JoVSs0dDUyK3YwZEo1OUxQK0xi?=
 =?utf-8?B?VGxpbUE0WS9EcmI0Mzg2NlRnQ2J3TFhnbkw5bWJtRjRvQmxyZzBhbWR6RjQ2?=
 =?utf-8?B?b1I3bXRYNFBuREtBZGV2T0NwbGpKTDV6c1orN1hMaCtrS3RMeXhHUmRsWnN5?=
 =?utf-8?B?VkM5azc5WGtJNTVORFJaQUg0dVpmcmJ4ZXEweUs0SlNmSTVYdy8yNVYxNFZE?=
 =?utf-8?B?b0IrT3VHTlVtZ0MzeTVhRVV3VkFNeHhvSXVtR2pHNWZQZ0xPcDRlN3dRdWkx?=
 =?utf-8?B?cGE4K1VGai9XL1puem5RZzUvM2ZCZWNncnVkdkhXKzlMV2pOeG1KMk5Sb1RM?=
 =?utf-8?B?ZWM1dmdPVVVsNTJMTk9zNkxvTitoV2l4TGN0NTdPbmhYN3F4amVCZ3FJU01E?=
 =?utf-8?B?Q0RUdVJ6a01jY1Z6cWZBMy9SU1B3Vm9JYUVCcTg1c1JHaGhBdzhGVnRQRXll?=
 =?utf-8?B?NjFWSTV3Z1FBelB6VndPR0JuQUpvWldMYjJnbm5GWmkveE03ME9BTkV4L0V1?=
 =?utf-8?B?ZTkxUjFiQWZ0NnRSMDQyOXVveWhVdHpzZno4UUxVZkliTHZ3eTVDQ05hYlVI?=
 =?utf-8?B?V2VNVFZNL3dqaTFhWk0vZXIvRC9WR0I5NjdUQndVZGF5Z1VkVGI3aVJYeW4y?=
 =?utf-8?B?M1pWUlh4WTB2d0VGQ1l5SWJwYW1qbU9WMzA1d1l6YTh1cmJjRTRQQnlnVFhC?=
 =?utf-8?Q?Pxdj0HCfsJveXf9TVNBK4gOWQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5999d11-ff76-4603-87ef-08dd1ddce5b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:21:14.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /I7qrH/HnxZm+/HY3psldtXxx4nFdiPbfElGGRh8CCy+nkYejr+7b/GhBpfAUV+B1vyuiSZLJ+g6499fuTL3WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671

On 12/2/24 14:50, Tom Lendacky wrote:
> This series adds SEV-SNP support for a new instruction to read an RMP
> entry and for a segmented RMP table.

Thanks, Boris!

Tom

