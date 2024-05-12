Return-Path: <linux-kernel+bounces-177036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2758C38FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 00:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3D0281663
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3294C55C1A;
	Sun, 12 May 2024 22:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="exAZ4nR/"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880B381DA;
	Sun, 12 May 2024 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715552088; cv=fail; b=V1FAC6q62S8PtfQL3Dcsfz1IxmI2oNeN5iM7/7uqBG1QziH9D4SKTLcs4ASxDdyV3WiUXuaOnGz+IeSzTxCkG2ety3/ul0ohaQlGwCCALC9Id86IJ+XnwpO4jPy31TFL7u4aL6FaEzj8z+vs4XbmC/4JeLAnsbYBDblfCwNG0eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715552088; c=relaxed/simple;
	bh=Ch8ssiVIffVEGHVT9pyoYkudr4PqYXQ0zpBwZBbEfS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTkRzZ03A8k9czxRs56epKAxxnopGgHWwY4+lcPme1hvvbAMhccrkn3tQSP4wO7nFkPmDARZ1IOvtaVrUrfhEPd28GqmipBt9bbZ2WfQfTlJqmkhLogNCgCVZxVNIGhial6qhihe1kASen+kiDzDGWD0i1Hqu8k8MI+jQ8PWLdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=exAZ4nR/; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsrnWG3dRFinzh0A3F4ePWgD1pHeMZjPwFJyuqJ4ukDk4ta2Lvj49dNJz9UH1bbY6y5syTwMokHDNFUNMEtqNeLKC/8HAHyh2ho3HKe5ieFoOZ8Eqv5AL1g63VIgp0xgF9SPkTNpjnonODkZzZV3e6BW3juDKGXjlupgFNXboBNxz/qejBxXIyPw0gd2aqJdAG0/0rxYgE8YcMNsJly6FL29ZyTKuMasy6upslIr0+cjXe/qlxip4W6P8fVrjzahOxNMZ2mDdAVQgV8A8IB2Y3XhtFkeh6RVjg5E0ZbeHmFIWSCcQPdvf3jbQq6KCG5RDTKzeUlpl6+hd44So1zuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OHREHkZu/9FryuqS8AdNnC3XpDCeSBwJ3aRdpCqegA=;
 b=V/OP7buQoIowMhbEjjJX+P0gZ15++NWd9e6E6GIg07lF8Hre6uMfqDaauXHdteY0AsR/xRi4Jad3yFenqjcW3lGI3qsjDb0CDDlCbOiwVyzHczJZ3+mx7QMiklFvdU/pqieNZb1I4QpgjObtvO6f/FV0YBMn4BuPj989sFbDTTOzVckZt3vFrQHdIBprtMthQXoCpImwcRTiY3vqRtrjFm8BeZkMXkhu+8KtJ9bBVASIDzxkSkI4SGiPETjWrTYpAMioEU0fzWH+NPzedKXtyeYE9XL3Z+mT/jKDc3amwVe7mmHNgmTf0RxIlHwZE0C4zfJSFwZjSIbdnf6Csnxt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OHREHkZu/9FryuqS8AdNnC3XpDCeSBwJ3aRdpCqegA=;
 b=exAZ4nR/qAcmxwwoSEnRLLN0f3Wg/H9LKP8na1nw3WSv0CyZztyG8yUxLmIrCDVOm2doLM6EMBrPBzPr897pTQUB6gDGoGMnjRBoxsVM9ZB5EKVqxXo/P7W8KQcxWkbql2r/FshEbMKL04xbA7RRwS58BkcZM2rCa6pIby0iB5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 22:14:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 22:14:44 +0000
Message-ID: <24fa8cdd-4c7b-4ec2-bffd-ff80e190f5fa@amd.com>
Date: Sun, 12 May 2024 17:14:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: Armin Wolf <W_Armin@gmx.de>, "Shen, Yijun" <Yijun.Shen@dell.com>,
 Lyndon Sanche <lsanche@lyndeno.ca>
Cc: "pali@kernel.org" <pali@kernel.org>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "lkp@intel.com" <lkp@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dell Client Kernel <Dell.Client.Kernel@dell.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
 <63894ef1-c482-4646-8351-4d6cfc6c528f@amd.com>
 <BY5PR19MB392299916A85FF06387DC9C19AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
 <a1306ffa-c0ea-4ce6-8692-76bf37850e8a@amd.com>
 <BY5PR19MB3922A117E489A55C3C7FAC789AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
 <4d8de625-9018-4926-9519-37f5a90a96e5@gmx.de>
 <d38043cd-7fc2-4255-a795-23e64ee4a8c2@amd.com>
 <e583ccb0-b0be-4fb6-8e70-e4cd6921d77d@gmx.de>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <e583ccb0-b0be-4fb6-8e70-e4cd6921d77d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:610:e7::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1083d9-b5a3-46f7-2c02-08dc72d0ed33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkx2TnJydjF1RWJac3lTdk1kc3JDazhxd1ROM0p3RjlBUVlvSzNhaDloeFo1?=
 =?utf-8?B?V2lQT0MraTVlVGRhcml5RVo1N2FaRWpDUDJ5N0k5RmtSK1dVYkRwKzRxUXpq?=
 =?utf-8?B?SUZPYTc0eDlhQnc2b1ZlMG1rTmlrSXJUb1lhRmgyRm1zSE5PWE5HMU5ZclMr?=
 =?utf-8?B?b1VVVHlQS3g0M1k0dEJMMHBoZ3ozSTA2T1dhSFRmWWNFcU1qcVpzelFUMWJa?=
 =?utf-8?B?RmQvVmtEbFkvSVhZeTVyZ1JaMlYvRmY3eVhoSTE2WHBUNUd3K3lsTDkrTXhn?=
 =?utf-8?B?L1hYLzl6L0VMSTFDUklsNDBKVkFOajZ5bktnWlNEQkc3djdWcTRIWmEzOHZh?=
 =?utf-8?B?eVEybXZGZDI5MGVtMCtkb3pnWUduN3dGamZzVU5XcEVWUXlKNTRVdTROeTBC?=
 =?utf-8?B?YW8yS1lMdEo0ZFVtT2pLSlZHVG5NcjdVUFFUd1d5aWZ4QzRBMlFEbC9RVjl2?=
 =?utf-8?B?SFFIMGNjU2JmOUd2amFTN1dUcmdDbHRXb2VqWkY1TnJ0ZlRyUWtna2tSYTFY?=
 =?utf-8?B?V291bS9sWEx3a29ZT1BwSGNzR0Z3YzI1anJEaE91V29DYlpkck0yOGFrL1RX?=
 =?utf-8?B?c2pxOXc3VWEzR2ZNODNpVjVtUFo2a0JhWDdlSXdzdis5bGg1Q1h3dlMyKzNJ?=
 =?utf-8?B?MHV6MWpXNWlsRFJQZThpcnIzSzM3aVpaOUxtZlY2UXRzREF3NnJoWDNrUnI1?=
 =?utf-8?B?cG1obmRTVVE4R0wzOEJDQ1NueWZMZDdPZmNiSEgxbXUyOVgxYThiUkphSGtM?=
 =?utf-8?B?OWxFVlFQL2VETnlqTklEZEtZeHFvZGNDSnJNZ3pLWDVERWczYjZPeEF3U04y?=
 =?utf-8?B?a0lxakZQeTYxRHA5RkpXQ0RBMHhXTXFUdGlYbmg3a1UyY2VNdlJDelQ4ZlZr?=
 =?utf-8?B?YW1Cd3VyZVZqSkJnV1RFSlo0OS9xS3R5TjBKKzEwVTUxc0JyYW8va2FHZVZP?=
 =?utf-8?B?ZFJNeW5BMVgxbS9jbW1BcXdSWkZ0RjZlRDNqbzBWUTQxRUlQc2pzdnVlbjIw?=
 =?utf-8?B?MW5FdDcyMG83ZS9qeTVuV2JWK05XRi92Wk1MeE5leWV2SUUwLzEvWFJvNkVy?=
 =?utf-8?B?bmMwaFFacTE4dEp5NDVYeW81QVhIcmJpVVhXQVcwN090QXlrL1l5ZXlTSEFq?=
 =?utf-8?B?ZnBQWGdiVGh3Ym5WeEMyZGRmRDVXSGFhZThJOHVHUEQvSXFya2hZQnd0MENC?=
 =?utf-8?B?YkRndXFpYlhiRjVYaUV5QW94VXRscWV2dUZqZ1F1R0R2Y1FsYnVkcTBBbFA5?=
 =?utf-8?B?REthS1dqOUZFeEF6OThMRmpUcUMrK0dCR3QzZmgrYjZVY3F1a2paNk5BU09n?=
 =?utf-8?B?T01YYm5SUmtsSXZxc2FjaWpPVE5IMDg2cDhwWTFYd3lEdXgrbTZsMW00UG5T?=
 =?utf-8?B?M0RZVTExU0k4WUtRTXYyUmdoTXdOZW1jUmdlMU80aXFJeGoya3NKVVlKeWRS?=
 =?utf-8?B?dEtEWk1GVmJoTTRtR0lOUmFSc2Z4NlJ4YXMrRFRGZXN4VzU2OGY5RUg2SFFm?=
 =?utf-8?B?OGZwUjhMV1lCUURGNTZRcmlRcDZtTnlWK1NBaTB0bTA3bVRGMi9MV1l5dVBz?=
 =?utf-8?B?M3pTZFB5Rk51TDNRSndTUjZaQ0NkRFhFMk02OTJCd2pkQlBuNmJXWEZVNjUx?=
 =?utf-8?B?d0F3QnoxV1BBZ2hoMGFtQUVMczZOaStUT05WZFlxZGxjSHBRR2RWaDd0ODAv?=
 =?utf-8?B?SCtjYzN5ZkVxTnJTOG40WEJnYzVCNzZZNWIyaThpQW5CUm0vVFVaZWJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXFYSVJZN1RGcCsxTzF1Qy9ralhtb0RtVzJhYjNuK3c2K0p0bGhadkhCUlg1?=
 =?utf-8?B?QjBTNUJkWW5MWW5XV2VTTkN1ME9odS9xdHJ1TWhXYmtWdERnTzRwVTBRTkpX?=
 =?utf-8?B?OE56WlRkbzBVR1FXVmFTOCtaU1ZMdXFlSGJDNkRyWndDa01YTFpySk00alJp?=
 =?utf-8?B?Z2o1ekZ2ay9WSnpydlFkUzcxa2ZaZ2lEQ2c0N2dpZ2VRZjdWb2p6V1lGT0Rm?=
 =?utf-8?B?aG5pSjBqWkZFTVN1QkRhbHFHdnkwZituMG9neG1jYlltbTJFSXNJa3BrdFRC?=
 =?utf-8?B?TmZESmp4bmJkcUl5QzQzd2lsOHBCM1c1R1B2T1BKZm9aNlpGai9oUEwveUxk?=
 =?utf-8?B?dzdtUlQ3N1ZLcDNXMEtHOVV5RkFaaDc5bEQ4aG9XSmFxT0h0NzhsQkRiZVB2?=
 =?utf-8?B?d0lxN0pmdEw0Q3U1TnBBVUFadVduWE1VK0FCUE9xOVRucTlWbVJsQWpnQysr?=
 =?utf-8?B?K1hEWHpHQkNMc2l2NVp5Ylp6bmNVY3lSWUllUklZZ0x6anEyOUd6VDdPMlgz?=
 =?utf-8?B?RFdvYVU4TFQyV3I5ZFd0emxNV1BWV2NuMkdlaWFOV09rZUVQZVJrOW9xbnRH?=
 =?utf-8?B?QkUwZVJqRzlBcFcwRVZBMkJHOXVGUzNsM2ozclFFZnU1K3JWT1kyU0pkVDZx?=
 =?utf-8?B?RVp4RVUzdjBIaGlpMEFmNVdZeUZoUGtHTGJvcUsrWHl2TUhVQ3R2a3Bia09l?=
 =?utf-8?B?czJwYmUrTFp2dmZtdS9IaTFBU1EvZmx3TUVPbm8zOVlGV0JONXQ5TFhnOERn?=
 =?utf-8?B?SHZGempXVDJzdGpmcWtsVFE2bkhQWXRjdnFNalNsU0ZmWVJLQ1N2eTF2aUlT?=
 =?utf-8?B?VnYxVGNlVk83cGVZaXYxcys2a2JzaWhCQkhIRUJuRGMvYUV2TkdMeFNQYjFT?=
 =?utf-8?B?RXN5MXFPMUt3Y29pM3poRmZZVGNSQVNJWWs3bHR5RGErZjhvMUMxSnNLT1Jh?=
 =?utf-8?B?RHdpRDJwakdNT1V1Q3F1aGd2dExuQmN1RndqTEUyVDY1WDhNSk92MjQ3bGpk?=
 =?utf-8?B?RGdXYU9hL0ZLb2FrNzBNOGJlSHhBZjBpU0JJOUZhY3hXaUZ2RnQ1K04vcjJM?=
 =?utf-8?B?ZW5SQ3JrU09SbUI2MWd6bnNtNm5UNjdLQjlNYm1kSnY1Y254d1RaVlAzc1lO?=
 =?utf-8?B?MnBzV1J1dUNBb0YvTTlXbnJseWxqWCtEWnZLRE00dnJwVVNCM2JGazFXSWlr?=
 =?utf-8?B?TWQxWmdxYUp1ZTFFQWI4SGZ5VXBOQlA5TkdkanBxK1VLRWV6RVRPcm5UUjM5?=
 =?utf-8?B?eWRpS2hlV1krMmFTVmVlTSt3dkxiRDVIQ2ZVcnIvOGlUSFlnVlg1ZnptcGpH?=
 =?utf-8?B?M3dvMjJJOFZHYjAra0UwKysyaWowVEVneHRCOUhvTWhUWEVJRUtIQVk0TVlw?=
 =?utf-8?B?NGJkRHRwdnFha2FZWktmTVU1RnVLaGtrY2wzdzlmalVqQXNxUHY2RWRWZ3l2?=
 =?utf-8?B?UlIwc0xEai9Vd2k2ZktzSFFzcENaYXo3ak9jdXNtdVg5WCt4ZVlRSGxqVG12?=
 =?utf-8?B?dFFjN2hFZkNIZWNHMmdsajM2QXBVVnhPN3llendsYzZqdzRpZzROZy9SZG5E?=
 =?utf-8?B?bHd3SGhGWVkvdzNXQWw2dXA3czVBQmNwMm5mb0hxZG95cFNsU0dMOGcvTXRP?=
 =?utf-8?B?T3hhbFFXbks1RERzd1RBNE5JdmhMU3BYa2xWQ0hZN1hBMFpXbnBIQVFxKzBh?=
 =?utf-8?B?ZGhtMHRCdnhUT0hUVDI0aVUxUGpDVkQvdU1tVUtleUVWM3hhd1YrNFF0Zkt3?=
 =?utf-8?B?M1BvNVpySE1NN2xUK2NXRmsxVXQ2Uy9tODZYb05weE5ydmxRKzFZdHR5bHJt?=
 =?utf-8?B?MnZHeUxsMTliY1pzVENZUnBFYm5DNVdDZEJCejU2Sm9JZUhjWVI2VVZCdGxU?=
 =?utf-8?B?SjZOMWRVczBQcnpjY0RiR3hNc0xodktMeTFMN3BTUHZwMHNiUUttRjFwR1d0?=
 =?utf-8?B?eHZ1NFdhMmd1REd6RkZ2cnpiMm5VelROTVZJMHFObjBENktmY0crOEdtdXN0?=
 =?utf-8?B?dm8rNjF4K0dvcnpXQy9wa3B6d1BMMjlxQjRIREhaVUsyNExtUHN6ak5rRHZN?=
 =?utf-8?B?Vjc3SDcxYXBrY3B0eFdDcnhIaGFVS2QyU0RXV1B3OWVRUTFtYXlMUWt0cG0w?=
 =?utf-8?Q?bsRX0yduXy3DBMTWWRJfaFuxw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1083d9-b5a3-46f7-2c02-08dc72d0ed33
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 22:14:43.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkW0enjMDpkv1rWqgfTTwrKaRlmAhTsagK/hDpA7DxdlGm1wUBPILhvQNwYzOoJ+dhCh+7YocVhnOE9MB2VxeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406

On 5/12/2024 1:47 PM, Armin Wolf wrote:
>> Why?  Windows also does ACPI-WMI differently than Linux.  It's not as
>> easy to check both from a Windows utility due to that.
> 
> Actually, it is quite easy to check both interfaces from a Windows 
> utility. Both ACPI-WMI objects can be accessed by
> Windows applications, the utility just has to interact with an 
> additional WMI object, but they decided to not do it.
> 

Ah I didn't realize that they're actually instanciable from the WMI 
repository in an application, but that makes perfect sense with how easy 
it is to do from PowerShell.

> Also the original smbios-thermal-ctl utility was created by Dell itself 
> (i think?), so they likely would have implemented this
> if it really was necessary.
> 

It was created at a time that the ACPI WMI BIOS attributes interface 
didn't exist.  I've understood that the general direction is to use the 
WMI BIOS attributes interface in the future.

That's why I was suggesting using both, if such a transition happens 
then this driver would be ready for it.

> As Dell likely only tests their machines with Windows (if at all), i 
> propose that we try to match the Windows behavior.

I don't have a strong horse in this game, but I see what you mean in 
terms of general compatibility.

