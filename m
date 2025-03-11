Return-Path: <linux-kernel+bounces-555564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D43A5B9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF6516E93B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C2122156F;
	Tue, 11 Mar 2025 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rgocwpJn"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A51F09AC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677598; cv=fail; b=AiAC0LCdxHN5nTxSP2RLLGfAS/W3XL+xmPgw5TS7Jh6VY5Hh+bgmFZzU8uZsjNwy6hPOkMrMNlR0IGbRtwpty1XeRrw9DKoktdMtIRFlaGrw0fwnyEsiCnm9zfpPuBZd/HB9baLMDOQE1V0eY8Vef7Dcat0ZQE3ppjDBAaK1iUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677598; c=relaxed/simple;
	bh=2dgY6RvZwlVlaeR7jlPFtGDWc8PJnncrbL8/o6mJg8I=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O9WonafNni3/QwPF9wKUN7s2Mss0dKQGeStVJS/YhCHyAGG6MnkAeWqHfF7gGlH4KFVgE/r90lrIsxswjqPQJXskWMe+CGHioq5CnLiJlh9q6/T+oRqQWYRoLj4oQH6MjnDzSBg3cQ4H7INFvy/+Z4ynEMdB/Fd9txlGqsliQLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rgocwpJn; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd1wBN88TKXI1q8jReUTUsGpKGZ4vaHFN9VZbopNky/CZAogkJax/R6jJ0kotzp1pM7lHefMlH484zpnmCO2bOrWjfL30qKLnYQpSF+nHced3hQdgwR00K+6M2jZ88shEoc0a0UI5sQWHj3Zfic11RG1yKS/6s7k07IoU7m7ace5qU+X66yPWM3cj2QrLokuLEznbrsXDilIyn3gj0N08Qq6JUzl9TXpqHgIj3VflAAnq1A9coba3BdD8KfHj84n37cqTLRH8bN7ovbFRWPjSoW5GIZQ/irdXYlEkuzbiiV+tTO1REz5H9J/xWH0sdeP+PH/IzPe7gm8c+G+jt4XKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jJAd4BYOB7qtKckWS8Yi4xJC4HPC6NEPnuP6efx5BA=;
 b=y8M9t9HrbCzboq2sRBq8PmCOVu44z5g8Sk4y88E7Dpfns9MWZV0OqmZYOsE7ftBQpT+GIQ/Vfkb53pFzgL/WcanpaS1/hShucInzaPMfUqtfq22tvinWCF3UKa+l5DXWvmoQ8SywSkiAFSAeoYfSApVsGT4uaehVqQ+fOkdMlde8PBeJ5VtqKwxFXMf1LHVJtJaqL86BCqQj8u/k6RNcWWxbUep+80S7YrQL5E0sTjp0yaeKWA3wRX/9lmx7QP5maK52jQyAAQ5mVwD+nT6+uuZ6bZOS1XDChX6v8ni+UrWZSksvsJBfR0WvzR0cCrzk68YOiisrDa+5Xhj+2zavPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jJAd4BYOB7qtKckWS8Yi4xJC4HPC6NEPnuP6efx5BA=;
 b=rgocwpJntRk3ZM+3mGBJB9Cqp+uYW5Xn+2XUH47XhvrrwKXQyrWuPBKqmIwlmOR5OXiKoXMb/6onsiEmAl7zpYPLLFKM/PjqKgfFRk1cgh4WWI7d0aQ0yNnZ34efvpIabRPhrNHfF5wiE2CPI4uUNvTlXQstJ0kSBgxUPlnSTMFuQDeFdDcLGLIscFuTvmTzagOITI8QTc7g7/k1Uijb3DFAFfHA2oHAhGlyZq/QwH43dwgeT2iEKTgTuDSVg5bh9C8p25gfx2nlPyR7Gupqz54P96kINWxN5qV8TDWmGDM5MC3Ogfygat8I2pueYLtGfZ7Jh420P/TbjVKBKirWxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:19:54 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:19:54 +0000
Message-ID: <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
Date: Tue, 11 Mar 2025 18:19:49 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Balbir Singh <balbirs@nvidia.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250310112206.4168-1-spasswolf@web.de>
 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
Content-Language: en-US
In-Reply-To: <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: f55b4928-b887-498f-48ce-08dd606d1eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkJwR0IyeWpCSXZWZXhubGMzcE1SYmFnM3BYbjRDR2l3Rlh6SXhuU24vQXll?=
 =?utf-8?B?cEFmNlFwQ3pjbUNvUDdrU21Fd1ZHVGMyY2dtYXhKMjVCSk5ERVdUYjB2cFF5?=
 =?utf-8?B?aHRTRHFLR2NUdDBjTTZjckNIcFFBMkpVNy9UaG9sYnZYMlJCWTd6MjYxUUY2?=
 =?utf-8?B?dklDcFB0YUFNL1pGcjY3WkNiaVJzM1RXVWh4elBoVzZBZWFGRW1EVFBaN1NF?=
 =?utf-8?B?eHNtcXdReXE4UkxwV1lldUhtRHFxdm80UTZvMWRiWUFmZUpLKzhNMTV4RjR2?=
 =?utf-8?B?U29CdnJieFNPL1lrb2k5TWd1NjRheU5kV1RxUDNIVFJxQjlYUXE5V0gvaEx3?=
 =?utf-8?B?cU52NGlCYkNNYWhTV3NMYmcvcWQwVDZqRXVxYTZyWFVnc2RwZnlRL0t5c2Ux?=
 =?utf-8?B?Vmxab2NLbG5KZ0J0M2Vnd1VHeXZ6cnN4R2c0YmJhZUFuUGdzRm1iOFhzOHFl?=
 =?utf-8?B?OVRqV2VRZlZENDMxcENsaHdUYnYxZWQ0VTFPYm9uQmEyU2R2S0d0L3ljMFhX?=
 =?utf-8?B?Q05LVGtiMU42ZUF2N1NaTW1Sd0VnVlJIcDV4WklicXhna21pTnZlZjk2alcz?=
 =?utf-8?B?M0hBZXVwWlVQOG1tQUxLcFVnTXpWSXYwV2w0TUlSU1lNeTUwNzYrRmh4WG9w?=
 =?utf-8?B?VGtKSjJrN3lZOWFMUmhyYS85Ym1ncVpZcDEwaTkzZktpM1lDaTJTWGp2cU9m?=
 =?utf-8?B?ZHBvOUdNbXJGQm9DSTREQlpuSVNVZXJMb0Y0RnBJVlZsanhaaG1zNFNEMExQ?=
 =?utf-8?B?U3RiZ1U5eXF4NUJqM1YrenFkRWM4ejZQOXh0UWdpMi9IYU93ZTE2cDNjNitl?=
 =?utf-8?B?eFdpWms2Vm0zZFhoRFM5R2NHUHB1YTU2aWVZQktzeFJDRXRHS3hHMmdyZWxK?=
 =?utf-8?B?UWhpQTc0WUVIV3F5M3FhZEgvb3dpZHQxekNHQmdTK2oxOFRCOHNBRXRWc01i?=
 =?utf-8?B?aEtWNUU5cFNUbWt1TitjdzgvRXgxSGc4RmpORDVqTWlsTUNtN0hwZmFKeHFW?=
 =?utf-8?B?Y3MrSTJ1eW5uNWUzdDFLQWt0SEpwd1hEcVZDbmNCdW8xclpZVXpJZnptSnht?=
 =?utf-8?B?VitLckVTbWk0bWNENkd1VkN3Rkg2bFBRTnhZMXlYQnFjMEJsR0N0MUM5djBw?=
 =?utf-8?B?bzlSZmtZR2ZCUGthMTFnQ2xDMTdOSzY0bVFqTUQ1QlUvSFpxdHczdElNSFFH?=
 =?utf-8?B?Z0o1Y25pRVdqZUp5L1hrMTBaVmpSMVhZY0cwOWViTmdOaFFkZndXeVRlVnky?=
 =?utf-8?B?RVd0dnJURitjTFgxckZFSW5MUUQrNFd5OHUyZElPSHVoTkZjbFV4RkFvMUZH?=
 =?utf-8?B?WjBuUE1KeFpiMzhWcGlkanNOT3RMb2lYYTJkelF4VUIrb1ZjTnY0MHU1VE80?=
 =?utf-8?B?OHpWVG1FeVJqNlBMQzFjaXEwQ3hFdUhnMWVHUkF1bmV2czErWFhoVmdBSEFG?=
 =?utf-8?B?OTArbDVtNndxRjFyemlvTTFEU09GellLMXZXSHl4ZTN3eEs3bDZpb0V5VVIr?=
 =?utf-8?B?ZkFzUW9OY2wwdEdpbEZPNFlqZGFET3N5MnpMOXltellOdTNBOGlwNGxsUDVx?=
 =?utf-8?B?cEtWNU5vRGZDdmwyaDcrc0c5RjJMMnR2MTRYUnRhOGtRSUNZOHZ3bmtlL1pM?=
 =?utf-8?B?UTlsbFpjeEJ6b2puTXRSRU10WmlvVnVPalIzUGU3em5Tc2RZRnplOCtkS1Jn?=
 =?utf-8?B?cTgrQkpKek5HUGd6M1BOOU9NU2wxZjlnNDVPRXBwR2VhZWU5aTNNYVhWL3hK?=
 =?utf-8?B?Tkg4Q0VRNDVWRmRreDJOREVzRnVFVElsSktmNWVpd21jaHZiMjlLRUFIRU4z?=
 =?utf-8?B?bkJON3RWeFdzeGNNZ1FyNmE4ZTJtbmdJUWFCdDBHMk42M2hsRmw4RE5YOGNn?=
 =?utf-8?Q?IREc3lm/Ykha3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHNxU1ZTS1BjdmNyUkhqZDZGNWZwSG1ETjluWk1KbnAwalhqVkF6cWJYQzd4?=
 =?utf-8?B?UnZkUklpTlBQVVJxZnpCUGlQRnI4MjFhbkEzNWNTQWNwYUppR0tqRnh1ZEE0?=
 =?utf-8?B?L2ZIeXM5eTlrQVFORFpkalVXT25OTFBGK1Y4Q09zRkZ0aHpFeVZkQzg0UEll?=
 =?utf-8?B?d0NQSTNBRUR5OUREMXZYNnRCWXFwa1dWbkRFeDBqZGkrUmhzaWNjWEQ1d3dh?=
 =?utf-8?B?TmFwVzNyL1QwMUZSVjVsL2hIdFkwMUcydlI4VEcveXpTYWRPS2RCQTRPWVNo?=
 =?utf-8?B?azV5R2lGN2psdDFQVWZXeGRQY3FaOTJCMWd6aTJoVmFSbjJ0M21FcG41Wldi?=
 =?utf-8?B?Y2xIbHFJNXNkV3E1RzBmN09PNFkzL1VobEVBNGhYaUV0dmZrWXJJNUVoeFRi?=
 =?utf-8?B?RG55THMvVHY0OURxcmhzN0VSdi9NZ0VoL2hqbnNmOUJkaVROVllLME95bzBB?=
 =?utf-8?B?UElGOWE5eityNHJuNk4xa2xLSWF0WVQ4SS9jc3Y4MCt3QjZWcjR4VnNrSmVi?=
 =?utf-8?B?UENGZGJFSkxWSFlpeFErQzVjS2VrTmpucVlTcU1zRXZZeTJSZmZnRFp0dUxG?=
 =?utf-8?B?cnhMUFRGMEQrNmFlWDk2M0NLcWpIR29oL3c5Ry9qRDhHR0VPVG5vS2xPRGtZ?=
 =?utf-8?B?aE9xdE4vQWNUbVNtRU8xU3ZjUFZWL2RBSGg0R0p3cDE1OHBzSGtIVE41VTVw?=
 =?utf-8?B?VGRYS1NwMEJVb0JLTEpnTzZ3aWVKeXZWYUdTSm9tcTZzMm9SMVdYMU5lenJB?=
 =?utf-8?B?UFJPWlMwL0ZFRGMrL3FvQTJxc1duWlZLZzZVanVNM0hKdis1M1FmeEQ2VUdp?=
 =?utf-8?B?bXE1Umk3VkRRRGtLb2FTVzdCK2dEZ09NZmJMekpkQXJ5SEt6YTVJN2RpeDEv?=
 =?utf-8?B?ZlVYc1o4V0tla0ptOVpzTkNTdTRpOEIwNHVKNG9FMlZWQXdZT1VuTzEwQ1JH?=
 =?utf-8?B?OUlySWxhamhzR3Q5cFA0czZDbDZmamNKMGROZEJQdFRlZm1wZmxkalYxNlIv?=
 =?utf-8?B?NUY1enRFcGhLKzM5YTVMUm1kNWJjWmJoaGdlMWJCQUQ1ZVlianlQTW9Uam5m?=
 =?utf-8?B?V01zY2RZOVI4bU5pQzNSc3VpcGJDQUF0NjdFQ0lOaDFHVjFsMjgyNHg5a0Uv?=
 =?utf-8?B?Y3YzaE5CRFJ1MWZzOXJNRDhpdFlrOXVobGNkRkRleFlUSTVnZG1TZ2J0alkz?=
 =?utf-8?B?SGJmTE5KRVJLTkNFais2S1NHN3Bkai9MY2NRcTRzMGxIR3RiT0dHeVVTcWls?=
 =?utf-8?B?VE1YWktrWUJLUStTSjNiRGFDN0RQOURodTAxckxwVHkvaUUySUxHV1BlbnlB?=
 =?utf-8?B?c1ZVbFlWSVNMSU1ocVlMTTFORVl2ZUZ6a3YyNjhMNVR4cU81MVJpQUhNOXFW?=
 =?utf-8?B?REttWldFQ2M3Tm9td3lyRVhiZWt1S3ZIelNJNk5rZ0NnbkR6WkwxazdZUDJN?=
 =?utf-8?B?bDdXSktGeE1FSHQrRlY2M3l2ekZiZEM5b291N01aM3h4cEY5WDYwM2V3b1dn?=
 =?utf-8?B?ZkhETzlSazRObHBBZXFRbzVyMjhpVktoeGNMSHRiLzVlNFkvaGdxQXlFbWV1?=
 =?utf-8?B?VHA4Sk43cWF2akhTSjJkcFBwUzY1M1FDR2YxYlcxSGhwZlp1WkN5eHN6OElt?=
 =?utf-8?B?cFg5MDlTMjFINUp2VUpqMnM3OTFJM1JRUnhXOHZFbFFEVTlKVzVna0Z1MjVw?=
 =?utf-8?B?QVpXOGdGUkF5bFdTZGtLVHowZy9GcFdOTkRwRThMNXEzOWdHcW5mRVp2aVNq?=
 =?utf-8?B?VHlxVngvWlIzYSsreWZEMHFRdW9Rc3pPWmpYMTYvaGVaWVVna21uQnVkanJU?=
 =?utf-8?B?aTZ1QTI5UzVJQ0s3bmFTYkFNaHVQY29LZG5CT3Z0b3k3cDd5M2JaWVRuZ1Y4?=
 =?utf-8?B?enpSTlAwU2U1c01ENlZXWVRBaWluNWhGbWV5NUFWd1gwdzVNMWI4MEt3SEFK?=
 =?utf-8?B?cXFxcVVMVU9QcjVDSnFtNEEycW92U0dXZ2ZXcGV6MG1mWEdZUm9Sa2ZrRUVo?=
 =?utf-8?B?REphYUxYVHkyZVZxYlFsL2czUjBLYkFCS3dPeDFWQ284SlJicU96eGhhNnZW?=
 =?utf-8?B?NUcwUGgyd0hiaFQwTURZNmZxYVB3SzcwcEl3anBDcFpzV3l1M05BT2xVQ0J4?=
 =?utf-8?Q?drTRGEzr2rI4Q+tcbR9Xzz/R7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55b4928-b887-498f-48ce-08dd606d1eae
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 07:19:54.0322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69euAwq5AYYooQty9iVBpayMoQF93VxyJmsLAWviIaZgAIqs/atf8WnSv/3zf3LNDLfLHleL3rIpN2DYtMAUZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066

On 3/11/25 08:48, Balbir Singh wrote:
> On 3/10/25 22:22, Bert Karwatzki wrote:
>> Using linux next-20250307 to play the game stellaris via steam I noticed that
>> loading the game gets sluggish with the progress bar getting stuck at 100%.
>> In this situation mouse and keyboard inputs don't work properly anymore.
>> Switching to a VT and killing stellaris somewhat fixes the situation though in
>> one instance the touchpad did not work after that. I bisected this between
>> v6.14-rc5 and next-20250307 and got this as the first bad commit:
>>
>> 7ffb791423c7c518269a9aad35039ef824a40adb is the first bad commit
>> commit 7ffb791423c7c518269a9aad35039ef824a40adb (HEAD)
>> Author: Balbir Singh <balbirs@nvidia.com>
>> Date:   Fri Feb 7 10:42:34 2025 +1100
>>
>>     x86/kaslr: Reduce KASLR entropy on most x86 systems
>>
>> Reverting commit 7ffb791423c7 in next-20250307 fixes the issue for me.
>>
> 
> Thanks for the report! Could you also share the dmesg? Do you have any proprietary
> modules loaded? Could you also share the output of /proc/iomem (captured as sudo)?
> The lspci output is useful, lspci -vvv (captured with sudo) would help see where
> the BAR regions are, specifically before and after the patch. Could you also share
> the kernel config?
> 
> I assume your config has CONFIG_PCI_P2PDMA enabled. Did the system ever work with
> nokaslr for you?
> 
> I am a little surprised that reducing the entropy causes these issues and having
> a larger direct map causes these issues.

Hi, Bert

I tried to reproduce the issue at my end, but could not. I am new to Steam and my
hardware/games are also different. From what I could gather, Steam is a 32 bit
application that uses SDL. For my testing I used Xorg, not wayland

In addition to the above?

1. Could you confirm if the mouse/keyboard work outside of Steam?
2. Does evtest /dev/input/<mouse device> show anything?
3. We could run the kernel with nokaslr and see if the issue reproduces?
4. As a test, we could try disabling CONFIG_PCI_P2PDMA in the kernel config,
build boot and test, this has the same effect has not having the patch

Balbir



