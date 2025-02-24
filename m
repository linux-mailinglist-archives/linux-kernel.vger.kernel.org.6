Return-Path: <linux-kernel+bounces-529494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFC7A42706
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6957B3B39F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0690F261585;
	Mon, 24 Feb 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k1n+RuJd"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449BA261575;
	Mon, 24 Feb 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412178; cv=fail; b=cNMekN4C6QqM+IPx5rSQWZB82nT3dJqfnw48308fc5ORTS8rOG7fEMUqXHTdCnQfrD8N2wYE+xDSY96hASLaipbt7ufzy0wQdBXpP9lL58LsPVSrcGTJ2PGUCfRXxvB5rGqyls8rijHXypIkmLvPN14SWayRRbhlycGmdxa8r7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412178; c=relaxed/simple;
	bh=46lGqpOGWFOVRxMbUMBWz3FEpw8oxLF7Q6xx1otIvrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WoOhtiWlstYvF/hg1GYi47cb92Gga9lZoSQWAcQUtmknr/w82Kv/leepp1JpNzU3fZtE3xwDcMRYUSitpr55zNGMVDuHZcBRv5RhtYfQ92We/xHoDLWmc8cm74HpMt+0Ezs+uT2ZUGzV67l5/NBgdQNHcZQP0Aj17OhcsM/+3bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k1n+RuJd; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH4pVX9Jes6l5PVzGx2nNiY+s/TXfYriY0Sf3NzyPhlJCvfpbjQfBBxu7Vf2aDKouslJxCt6teN54WI6mGZv8KfcovpwEC9wWpUufpYu2c+K03g/HIxgwFqf9iM+ThoRlO/5y6+NV8JTapFb20V4bFAt3uv5vaEjqs6DBD3cPAAgarMr45UOAqDknR7C8brrniA5072SGV8eU9nonROQ0SZkHYKPRBhf1AnNxGimT1HTZdw6mfWujCOYA4/Z4wHvYGfjtWM+gekeJ13aTAwJKWtuqK6mFC8bmADNUJ17V6pCjVsVZCjWK4N06oYMesfLxZIBT0V1GtD/MxrGxqtm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVRQepcuPar0if+twwmIw2g6Rq1tPz6/4L2Rb7/QoPs=;
 b=ewXkq8j4QKjXAsmaCfa2BxvsUbsy1sNsu/jMfh8s+s/OfWBNIrv57fpQwwMemd+VpYYClFvxBayzox8eX51PdWh5XmCFpjN63yxDviSEqwyJFYwIJICn9/0q2veJrIduPaAiaMHEP9Wu/PdUkX4V+Qi/4OTNOxtkl81hwEd3z1yLB2bvrlCR087V9X8XSYFiWW5Md8SegDs2y4mbbseD11oyibC4OMJMPlIERNzSdnUDPjtWkgKSGrZK5P3fwy08jWgqACze25IfoU5cq76/nPFhZx3IABQdXLverEcZzjJk+rVx1B4xuQYNLS/ktGTWu/RjmFDyGoMcNd90MhwRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVRQepcuPar0if+twwmIw2g6Rq1tPz6/4L2Rb7/QoPs=;
 b=k1n+RuJdlfF+ZHK+BNhGeGku6f07DSomJw9vofyOIdXQfAgvv8mimEJQnwkZDYAkZh/ifSYEyniHqTy1C+GBLhWv0XXqlbRZ+KE2g5U2hJSTLUuim+CAtia0yDYbYpZM86OFwt9PDVOx1kOhc+Rm8WTV10mgeuybRY3b8VhsYok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:49:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 15:49:30 +0000
Message-ID: <7b3d18e3-1f7d-42cd-bc32-fda4a81dfc82@amd.com>
Date: Mon, 24 Feb 2025 09:49:26 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 20/23] x86/resctrl: Configure mbm_cntr_assign mode if
 supported
To: James Morse <james.morse@arm.com>, corbet@lwn.net,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, tony.luck@intel.com,
 peternewman@google.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <4a48aabf502897bec1e015305d7b0b826bb20841.1737577229.git.babu.moger@amd.com>
 <b3dc2fc5-4ee6-414d-90bb-97baa0d67dc5@arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b3dc2fc5-4ee6-414d-90bb-97baa0d67dc5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0031.namprd05.prod.outlook.com
 (2603:10b6:803:40::44) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 931a16e2-7903-4bce-d268-08dd54ead36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WldVclNUbElLNGpGOG5pL0w2ZEVpeXFjMnNzbm1SbzFGek1ES1p0SzlZbk1E?=
 =?utf-8?B?Y0d6WTFZMEloMFRiSWpvdGZ5WXBHbnNwOXFTTjNxUngwN0JEMXczNHlrYjkv?=
 =?utf-8?B?S20rSEJoTlhwazEweTk1TUhCVUdHVU5Za214YTFyRzI5blZESDRPeHlIRUNY?=
 =?utf-8?B?cllQaHlTTVp2NmgyWUpidmVIOEZRUi9wOU9yc21yeVViS1ZxTFc0Q2FkdGJM?=
 =?utf-8?B?QVdPeXRQaVRhQW5zVW4vblh0Ym85YldDQ1pLK1UvSmExcDdwd3FuMEg2ZzZx?=
 =?utf-8?B?MDdOeWpwVnFTTm9sL1RyK2NJMWhvUXpTOHMyNkh6NGRZUE9BVDlGRWtOQVE2?=
 =?utf-8?B?bVB5SWFnb3VMTkVNVUhNTE1rU3VxeU0vSXBkaDlFUjBiYWoxZ3pLRlZqZ2tL?=
 =?utf-8?B?dkhGQU1SNTlvc3FSZWhXVWh3YmdZQVhVSmtsbEJPVkNLcVJGdCtLZkMzR2w3?=
 =?utf-8?B?K0kvL2IwaHhic0dzcGxWcmxUSlFvMkRTQjV1OVpvWU1mamhCV3RqNjVReDFm?=
 =?utf-8?B?WEVBYTB1QWNXYU9hSHpLOUl3QkZUNHBBMkttWFR0cTdYRCtSZmtRNjlwN00y?=
 =?utf-8?B?d1NSVk5idkovajhFNFQ4ZXYvYi9IeTBGYU5ZOFQ3dlJIdTFGbktOTUY0dEZE?=
 =?utf-8?B?V0JWd01nazZmblh0bHNmVytXSzdXSk11QlJ1WDZBR3I2YU5YeEF3Z0hyVDV5?=
 =?utf-8?B?VEx0M2R2aXpGSXhVeHZnM1B4K0U0RUdaU2FDV0VQYXhXTXZsOElnbThjQzRx?=
 =?utf-8?B?aWh4WUgwS2lxZW9YY1JsVEtkaHNjNzMwd3JRRVhWbUJKNCt5bXJ1Skw4VGcw?=
 =?utf-8?B?NTFEWkVOOFZUOGhzdHQ2NlRwa1IyTCs1b0hGdU83cUF1VFd3SEY1T2NTQStr?=
 =?utf-8?B?SlRRVFl5cDA2MWU1Zk52TzRTZkQzeHJzQlNyQUxzcld1K091Sk5ZSVA4b1VK?=
 =?utf-8?B?anBQYmx1SitaaGVNQU1nbmpBYW5rbmNXcDlJaEk1MkptM0o4TWpycklxZW5Z?=
 =?utf-8?B?MEhZT0xoWktVakRNRWtNYVJYbXo3RXZMcC9ac01KRXV5UmpZVjc5Ym5obmJM?=
 =?utf-8?B?LzdQbytwVkszMTdQTXNUUWVndC9CYm4zMm13aWFWMDdkZDFrclYrQ3VQbXh2?=
 =?utf-8?B?MVpIZC9zVDkwK09VKzZ0Q0NDcXB6VXVTNUtnY05kRFdQUWM0TVc3elVBRlhR?=
 =?utf-8?B?UmhxQS9Beml3YlBRQlpyL1Mzb0xUT3grUlpjNjlXdm5LUjZ4VndCRmFZUi80?=
 =?utf-8?B?QzIrVFlmaW80SDBjd3k4WWxGYmVPY1BpeE5pVnpWclltNHkxZHBMZXBVKzlq?=
 =?utf-8?B?Ly9GaHAxczNTWUdzYmRZWEd5OFM2eEhsQ0l3bHZVZ0NXNG56R0Y2cmZFMXZE?=
 =?utf-8?B?Y0JCRkMyRS9Lb3JORGNsMlFlUFBXcHFraTVFWTdKZmxBazFVTnozZk5GWTRU?=
 =?utf-8?B?VWpkWVR2MVh2UUZYOFNSSmZDMm8yclB0UmhlZjdsRjVBOFlQTU13bEwrZ2ZH?=
 =?utf-8?B?bUk4QlIxNmZuRVRkblNkdDR6ZGlGUHBvSXhvNWNsZGdsSU9WZFdPRndZMVN1?=
 =?utf-8?B?VmdleXVKR0syNzBIdjlzYkcxcGVMUy8zNzZpWm02ZXU4UExRcWpLTVFOSHVp?=
 =?utf-8?B?djhTcW1FN25LdXFSV2RMeTJFeG43TXFLaEdKcXJxdi9BeXhlSVlLYlhmem1q?=
 =?utf-8?B?MjRzUWtNZkJGOVA4L2NZY0VUbHNzek5SWUlQVm5xdFFlbUtFRVRHc3VTVjlp?=
 =?utf-8?B?dDl6d2p2WDdhcGJOZ0tsNXVsemdKUFV0S1hJc0Jyc04zeENHdHdhQWtMcmQy?=
 =?utf-8?B?V0lRb3hnUVErQXo5OXVRMkhaN0paaHVnUFdwV3NtdDNYZ2JJV3Uza05sZE42?=
 =?utf-8?Q?RWsb1c0lCSICm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2d6dnMyRGx6MXBTL2ZDaTRiOGF3NTV4eFM3WVltdFVsdkhrMlhsR0xVb0pT?=
 =?utf-8?B?Ynk5WDNvVDZsMGIvL2Q3ZGZ6Y0xEMUpVVjJ5SkFGbDhIQlZFUUY3NC9ZRFdi?=
 =?utf-8?B?cExzS3kvbHpvVExpU3I4SnZJbklPWCtFT1FtSTdpY2NqREZteDZSZVJSWlIr?=
 =?utf-8?B?RWliQ0lnampIYkhHYVJMcXNuaW9iYlU2NDFjWjhQZDhrT2NkVFJNWDJUZjd4?=
 =?utf-8?B?Vmk0ZTBoSmtRSWk3MVJ0WjlTWXNodnRCckhQZXNZVzR3ZVVaSlZOSzNzV3RE?=
 =?utf-8?B?ZUNlYUE5WGhISkhtRmk2M0NFS1hTSGM0WU5qWlpjUVJJcWFnbjJYOHRxTU10?=
 =?utf-8?B?VWgxaFFKRnd1dUZSZXNPT0dpMEwycStVejJEbVcxaDNrbWVRek1vMmVEa3lF?=
 =?utf-8?B?SjM1emRrY3ZQdVRTbFBJT0w0d2pDRTU4NTJBLzBwZUgvdis3OTBhR0o1WUU5?=
 =?utf-8?B?NmRadWcxS0xaQUpMcFJybVZ6amNTM3EvS1ByRXZ1Yjl3VDI4L2RnM2RCcTlK?=
 =?utf-8?B?OXQvbWtTME1UTGhHenRtaHVaVmdldjNvSGM4OThseGZvSW1DOEg4UERDZ0xp?=
 =?utf-8?B?bk16OEpKZGZPeTI1d3gzSWpjWVNPVU9ZV25pWndNbFJ3WDFHTzZueThZZ2do?=
 =?utf-8?B?ZE9YUHhKZnFweUlJTk9ma2Y3TXlFSkFCYXRxZFkveHJoY3daV1F3Vld6ejRY?=
 =?utf-8?B?c21CQitlK3lGaUt4Rm5vQkZ1WTdJRmptS3B1a2NTUWk3SEpyK0xZV0NiUGI5?=
 =?utf-8?B?aVYveFRjOVVMaHBHRnQwcld3R0kzeUZVYk5OakdyVFJxcDF5ZVVHWUFEQ0FN?=
 =?utf-8?B?NDB1YTJSeC9sK1R2N0JiTUZXcTdqTVA2RktHWkt1cGVnSkRmZElPVGdldDla?=
 =?utf-8?B?cHJ1RUh0NUhKRFFJQVJkcGhYWUJYdHFmemkxOXI5bHZXYkRic0FsMHlyYm5T?=
 =?utf-8?B?OHZPN1dMcmtFTm9vbTJBWjQyRDlWdzJzbkFRVGVCWFRSYkhSUVlDV2lwOExP?=
 =?utf-8?B?OFByZWRGS042SFVNMnlRNFhqWUVVKytrZGZPQ2RkSTZINW9ZZXRuVlhidFNG?=
 =?utf-8?B?dTR3TWowc2V0RmJ6a055REVjc3pxWlJUbnlRZ0FxT1VzcWYyZzFydzJWRlE2?=
 =?utf-8?B?VjdqclRJVDVNR0hZWkNhU0FUYW9vUkNBb0J6L1RZLy96NVJVLzVoSitTRnVK?=
 =?utf-8?B?MGhwb3BDcWhSNjBMNGxPZDIyTmpyVGhxOFdLL0RPeThPNkVkdk4vZlNMZDRh?=
 =?utf-8?B?UWllSFJTV3FnOThpbnJMWVVUYStycU5HdGRTRlFQZGIzYnF1Sm9saFdUS0N0?=
 =?utf-8?B?WTllN0dZQldxbFJzdHNsOWFtMFFGRThaZUw0Nk1NRTUyWnEyZlRneVlyUUxW?=
 =?utf-8?B?U0xpMW5nenl4SU1LZzh2MEZmcTM5ZVg1b1Y2ZFg2Qk8vMDRNQi9UblY2bXZ1?=
 =?utf-8?B?cFNaemtCckluM1JNSFppakE4VTd6QllXSXVtSjFnalAyWmFmck9MbG1BVEVT?=
 =?utf-8?B?WjlybnppK0xISUF5b2Jpa21QNlAvcXRlQklmZUZGb0doYnZpaTd2d1pBWUR4?=
 =?utf-8?B?RkV1dkZKSDZLK3k3YThGU09Cc3p0dGVQT0lYbEdCNytLQW80UC9EY3NvV3NU?=
 =?utf-8?B?VXdMQ3VkSC9scU5tdFJWSWVIVkd0MlBEYU43Ym55bS85cC9vZHR3MGd5WmI4?=
 =?utf-8?B?UkxSbGJnclovUUFyZHQwUVhUelF6Q0JkRjA2T2J6TkZrR2llV0VTRHVQNVpC?=
 =?utf-8?B?a2VQWDRDTkZNQWNILytYMDhyZGhkV2luK0crYllhcy9xbmlIcU9HRy91KzJ5?=
 =?utf-8?B?eXk0aWxDVkF1V2ZKMUxmbEVCT2VWWk56V1JOdFZvTEZmY0pSSkJLdEdDWmd6?=
 =?utf-8?B?cE1pTEZXaHVNaStTMkw3d0JnSzZqUkZkY0xDbUQvdmowbXhYbUJyQ21rOEZz?=
 =?utf-8?B?TUsydzBLbTVkc0R4amk5UDJhNmhDY1Z0aHpLWnRndm9WMW1NZzNSRFFyeFRB?=
 =?utf-8?B?US9kMFIyOXh1MjdGSGNvdXVoQ1p0d3RWUmFIMnoxTUJWNHNXYmovejE3Q0p2?=
 =?utf-8?B?L3FmMUNCNXBSY2Nka3BhbzdxcWtUQkFEMng3WUViRlc0Z3dWM0dQR1Q1ZkhB?=
 =?utf-8?Q?3nnk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931a16e2-7903-4bce-d268-08dd54ead36c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:49:30.4587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwRriV9kp+hjBMtnASlvtapM3f2D96aQbKpsPZTfvE0gxqxHjpoSrf2i8sCUrT9C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

Hi James,

On 2/21/25 12:06, James Morse wrote:
> Hi Babu,
> 
> On 22/01/2025 20:20, Babu Moger wrote:
>> Configure mbm_cntr_assign mode on AMD platforms. On AMD platforms, it
>> is recommended to use mbm_cntr_assign mode if supported, because
>> reading "mbm_total_bytes" or "mbm_local_bytes" will report 'Unavailable'
>> if there is no counter associated with that event.
> 
> (If you agree with my comment on patch 7, it would be good to update this
> wording to match.)

Sure.

> 
> 
>> The mbm_cntr_assign mode, referred to as ABMC (Assignable Bandwidth
>> Monitoring Counters) on AMD, is enabled by default when supported by the
>> system.
>>
>> Update ABMC across all logical processors within the resctrl domain to
>> ensure proper functionality.
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index c006c4d8d6ff..2480698b643d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -734,4 +734,5 @@ int resctrl_unassign_cntr_event(struct rdt_resource *r, struct rdt_mon_domain *d
>>  void mbm_cntr_reset(struct rdt_resource *r);
>>  int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
>> +void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
>>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> 
> Could this be put in include/linux/resctrl.h, its where it needs to end up eventually.
> 

As Reinette already mentioned in  [1], Boris wanted this moved when
arch/fs code separation integrated. Lets keep it in resctrl/internal.h
for now.

[1]
https://lore.kernel.org/lkml/e524c376-9ef8-488e-8053-b49ccafd306d@intel.com/

> 
> 
> This sequence has me confused:
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 3d748fdbcb5f..a9a5dc626a1e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1233,6 +1233,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  			r->mon.mbm_cntr_assignable = true;
>>  			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>>  			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
> 
>> +			hw_res->mbm_cntr_assign_enabled = true;
> 
> Here the arch code sets ABMC to be enabled by default at boot.
> 
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 6922173c4f8f..515969c5f64f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -4302,9 +4302,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
>>  
>>  void resctrl_online_cpu(unsigned int cpu)
>>  {
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>>  	mutex_lock(&rdtgroup_mutex);
>>  	/* The CPU is set in default rdtgroup after online. */
>>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>> +	if (r->mon_capable && r->mon.mbm_cntr_assignable)
>> +		resctrl_arch_mbm_cntr_assign_set_one(r);
>>  	mutex_unlock(&rdtgroup_mutex);
>>  }
> 
> But here, resctrl has to call back to the arch code to make sure the hardware is in the
> same state as hw_res->mbm_cntr_assign_enabled.
> 
> Could this be done in resctrl_arch_online_cpu() instead? That way resctrl doesn't get CPUs
> in an inconsistent state that it has to fix up...
> 

Sure. Here is the diff.

diff --git a/arch/x86/kernel/cpu/resctrl/core.c
b/arch/x86/kernel/cpu/resctrl/core.c
index 22399f19810f..f48b298413bc 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -771,6 +771,12 @@ static int resctrl_arch_online_cpu(unsigned int cpu)
                domain_add_cpu(cpu, r);
        mutex_unlock(&domain_list_lock);

+       r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+       mutex_lock(&rdtgroup_mutex);
+       if (r->mon_capable && r->mon.mbm_cntr_assignable)
+               resctrl_arch_mbm_cntr_assign_set_one(r);
+       mutex_unlock(&rdtgroup_mutex);
+
        clear_closid_rmid(cpu);
        resctrl_online_cpu(cpu);


-- 
Thanks
Babu Moger

