Return-Path: <linux-kernel+bounces-311139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591B7968550
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC9284FE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1C1170A03;
	Mon,  2 Sep 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="EYInuWL1"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBFC56B7C;
	Mon,  2 Sep 2024 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274296; cv=fail; b=KH87RkLCKjPqS2OqSCjMEgos3yzvk1a12crVQ6XaCFEQ5MlsWrKAQ2h7TvTiQx6dmaFUTva6mHOgFgA1fSz/U9+GSVyEqHjJAGr+oq0aSYDvoq5bAZ3ntQAvxLwMb2YjR7nYf1VmHAxjWUvxD2+tSSf3xsB6IcB9fkrA48Xp+Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274296; c=relaxed/simple;
	bh=5urlK2BQBr0UfFkXSdkFUuXooI2cXt7DdC8suIfLYMw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/O0VuetyrZU/2cq/Qn7TisShlCPzf/RG9+kQd85vw6EATYUoKtICE8uS7S4BWW2QKPF1FQBA0dd1b7sXDz8ZkiQfnq/bUIDZoBaNkNSeKkblGhaopEXEA6+6GkggSBFNWTLuj6hBiKcG9pDyPbMnhnufPKZBjv0wlqUii5Kjl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=EYInuWL1; arc=fail smtp.client-ip=40.107.215.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tos/+o1yCsv9uboQZa1/0Qy6hyeCpP1H/S7S/9eXauTNxindqAaWRl99Of4VpZFu1p3tUdxaNqhaQHsJzr44OveDUHBh8446IdBHf7wFA3AWniQw9q+IuhFjDInLHBajLNENT2G5vhmBu1dhK+1/Hy9jpyasa6RX4A09Qx8YTCOnKTAcUHhEDiBgQ6k+yhzaUG8StMQ/Ghm7Fvf7LgbwLRb2P2Na5WJXt7RgRyp6DveaW9pokuLvlM8lZ2JspIejwKC4FGPph6FK5NNG0aopyj8R+Lb5GGAqRi2Mv7yLMZqqHirqnRQIZPN0jeQd0D4eR9wclqmzSpVO+ZIDU5pPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8/UMEButdOK1F4MiNXTKGhB6O3r1Ztkvad/lj6GGbk=;
 b=sxJtl9RZjb62psfzGOAM2tFMAktCr/UAccfH8lcuLulvZkBg+2c9vL/dIjs0/qNePTi1rwNoMarM110e3g7UkI91NiS1WdKWZxqxWk8ZbvgN2IxJ7v2MTnjPOgBv0Q/d8S8sY8/HLqcpWiEcaLvLbqj/bkbYzoomKy+ifuY+HG7k2YkOwGD1gd8vvJDfgeykNCEw5STjtTM/KCmOmF0d3YyVC/r0Xp0ZDJ+e38K/kJ8Tp8J86h9Dif2H/udrbsu3uSKIYcBv2JN2gIVws0pH2uP9GFIWRkxTiR8qB3YWp5u5r3iK9KRiwSOwV2qTEEC/wvevN+WtXArAaaC+1n5aOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8/UMEButdOK1F4MiNXTKGhB6O3r1Ztkvad/lj6GGbk=;
 b=EYInuWL1k2gUJ2WzNnDTG3BjFBV1Yw+moRAvJyp+8iPGJrepPtd7nFGXcLoviASzA11kKnb+8j0p+KJ02IzlG0HSpOoTYKMxzDyNpSlPG+k1dPBso4k8Ch11bbZBGZf8fw/oO0efB9QT4nNVcK48OECpKcloVN1KajJ3LCs+uXD8ZDI8x2+qSHka5OZbt9r6hw226OKjQCjjY7YaMmouPYxQXqpMlBKivOgu4a5l9kxO9xgwikEK59KvfSvwGM9SD2hKv+ZiONHzt/hyMEL3xU39/LpccEJaiH/HDXSP3gIGmCjE00Uc5i6gXL9gi9xWc1drpDyFcKt/14vtUfifRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TY0PR03MB7240.apcprd03.prod.outlook.com (2603:1096:400:276::8)
 by SEZPR03MB7376.apcprd03.prod.outlook.com (2603:1096:101:127::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 10:51:30 +0000
Received: from TY0PR03MB7240.apcprd03.prod.outlook.com
 ([fe80::a51:b6f1:1090:757a]) by TY0PR03MB7240.apcprd03.prod.outlook.com
 ([fe80::a51:b6f1:1090:757a%2]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:51:28 +0000
Message-ID: <a0342c08-9c91-77a7-105c-af91af49d5fa@amlogic.com>
Date: Mon, 2 Sep 2024 18:50:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/3] Add support for Amlogic T7 reset controller
To: Philipp Zabel <p.zabel@pengutronix.de>, kelvin.zhang@amlogic.com,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
 <d00b9c940d5b6156c846b8e513adff1eba0993aa.camel@pengutronix.de>
From: Zelong Dong <Zelong.Dong@amlogic.com>
In-Reply-To: <d00b9c940d5b6156c846b8e513adff1eba0993aa.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To TY0PR03MB7240.apcprd03.prod.outlook.com
 (2603:1096:400:276::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR03MB7240:EE_|SEZPR03MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 32882398-8c33-4faf-f530-08dccb3d32c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2ZuenowckhUTFFiT2I5STRPODVQVzM3bkg3MEFHYWRwZ2Yrb2dqNEdXRTJq?=
 =?utf-8?B?TjFNR1hqS3JFTWdaK1BxaHRPZ2JoV3o1Ly9pUkdzaG5iaVdlZG4rSEVCUFYv?=
 =?utf-8?B?UTNRa0pCckxybWxSREpDK3FPU3ZHeDR2b3FQZFNpdWJRaXdTVVRaWUZsNzQx?=
 =?utf-8?B?SDg4aTNGbnlJZFRBVTN4WmQwUU1WbGVWSiswb2NwTU5OQVAzNWlrVHc4MHZT?=
 =?utf-8?B?UzZFSXV2eXhwZVp4VmJSWEFFUWFGbllXMkt0WWwyam9HMTRwalg1bjZ3ZjlI?=
 =?utf-8?B?K2hIUFZFclZ2bW5NYkpHV2FIVHNaSmdqU1RhNHZpV3FNN1Q5QVhad2tNVS95?=
 =?utf-8?B?TEdXYWZ0cU5WV0xWSXgwdXlYZlZOSmR1TUVlTEJ5MUxoNW1pUGRlZ2NGbDhh?=
 =?utf-8?B?dHNyRGNzWVRkWTEyZTgzVE1YOXkrWGRrVlBFdWl6dGlzQ0d6aDRRUUZHL0hN?=
 =?utf-8?B?dlViKzNJQWxhNXRNamM0OXBKYTRwNmRyVFRlRXRHVVB4ZmFtbDRsblVkaEFJ?=
 =?utf-8?B?Q1ZFbzJsUUgvRXpkMDI2bFcxQm00Q0pML1J0bFRpSGJINHNMc3NMYkE5TE4y?=
 =?utf-8?B?V1ByOEJKR2xLQnhEanZwTXBTMlJ6Ym5NWllrR1ptWkpTR1NZbWl6NVREcWMv?=
 =?utf-8?B?YU81WGZoWWZKbVNLSXpoQ0JIOTNFNmcrSlR5OWl0aDRnVS9FeDNSeXp1aUdz?=
 =?utf-8?B?TGUwNnlreXFHWnZCWTlsN0ptR3k3K3dpN2w2ZHN2RzY4RVVUQzNoWVplalRK?=
 =?utf-8?B?NWk2c3RWZnUveDF0NzFlTVlkbzNuMSt2T05KVStrakUrS0M3ZzZseW5od0RC?=
 =?utf-8?B?K1hkdUhvcmZHbGVITFpBRXI4RlpTcTI0M0ZFRjBEZDlMMUxaSDExRzhoS25H?=
 =?utf-8?B?NUUwcGtOTnlUUzVudHlrU1doYTR5cXBLZXg3WDVtQk5EdWlMdktVSEUxcmpL?=
 =?utf-8?B?N1FWNk1sRXhxTm1RNDZZSE1sZXdOSk4rWUFZZUQycFRKTVlqVU05NnFPTTVX?=
 =?utf-8?B?SXlOWHhsaUNHOGhYSnB0UEhzMW5sODVDMXgzTS8xQkZzajFSSEFJMnZpUlZG?=
 =?utf-8?B?T1FRN3ZLOVpWbHI2SEhHYXhJTkEzcGFFbnd3S2FWSUM5c282c3l4bFo5eWsw?=
 =?utf-8?B?cFNrMGlJS05kTmR2U21hWFBYMXd5TWJXNU9VY2g4a0hyUDJFZ0xFdEJZU1ZO?=
 =?utf-8?B?ZnN5Vmhyb0sxdlJNUTAzUU14OVpXN1B3Y2JiRWd3TmFuNGxWSkZPWE1HVEJr?=
 =?utf-8?B?UUh0NGZhc2JwSkxxOUwvWFlkR3pkKzlHcDNNYjhVY0lhUmcvK2pxdjBuRE83?=
 =?utf-8?B?UUdTMnlWbWlONHFLL0p2YnZmNHJxY3FQei95MmpsQlhndlZwbHowSFEvYzJG?=
 =?utf-8?B?cHZnNERXR2U5MTVndXdqOEdmLzlaZTFZZVlrSlBKbW8wbjJTaWVmY3p5VFZ3?=
 =?utf-8?B?dHg1NUhIZGtXSjFCaVBRVGNiWUtGUGRGbWJkd2ljeUZ3L1RtbHJScUdUcWty?=
 =?utf-8?B?NnE3UWdnSVpjM2NDbkJ2ZGxacmZybWJzMk4raG5LeTg1MUZlenNWMkZBUVBX?=
 =?utf-8?B?WkVHOWxPRTRHSVFwOTJvSUVmVW43Q1FsUm9IcUtDRXBjQklLelNvZFRQUzNk?=
 =?utf-8?B?RC9DdlpRbzJnbk5VdGtjYjgyTWZ1TUZaTXlJeTd3aitqbUJwRVJCR1lUOUNk?=
 =?utf-8?B?c1dKQXBIQmZQaVIrcVUzZzJkVVlJbHR0U0dlb2I0eUowNTc4ODJ4bDN1NU9B?=
 =?utf-8?B?SFREcG4zbkhyM21YOUNlWWlvTy92Y2drYlFpYmNncmMwbVFZcDZXMGNUMkVN?=
 =?utf-8?B?N25FK0N6ejBiSlJWS0laQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB7240.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG1rUk9hSU05Vk1LeEhuNHJTbkVNdnBObjNrVS90dzA3Q2ZMVDFhQXYyaExa?=
 =?utf-8?B?Tlp3bXl2M29tcm1ydTBCTXZoMDl1TUtMVW5TWVJLYVpOSmQvK0U3WVVWbGpQ?=
 =?utf-8?B?MHFPSHZQOTNLTjBtSjF4ckRkdklCT3RoU250bUx2alpnSUQzeWNMQ3lKazh0?=
 =?utf-8?B?M0Z5alhkdkZzK0J4dDdmWUNOT29GQzZwM1JLKzQzUlI5bFlrWFAra0c2NnRv?=
 =?utf-8?B?bzAxT3NWMzZxamZ6TkFac1kyQWJFSVZsZ3IxcXlPUERncHc1NnRwVzFlTzZP?=
 =?utf-8?B?d3JyTGNueGgyNU03Q0tYbWNXOE9GNFd4OFRBbSsrSndLck5HYmV1UG1HNjg5?=
 =?utf-8?B?cjVmZHZhYzBwb0ZoYTVyc00zVDVsTmRCMlU0NWRnN1p4bUUybnJ3ajBBdEg1?=
 =?utf-8?B?TVFvSXZJQUNtV2dQbk0wdnB1ZFNISVEzR0dHTlNWT3ZCdjB6Yi9YeGF0bEFz?=
 =?utf-8?B?Zk16aVdBVkxSNnEyTExwN2hmTXZpQXJEQmJGanBpQ2JqcjFseFpZb3hIcDJn?=
 =?utf-8?B?ZU1ody9OOUxNeE05bnlUQTlRTGNxWTRNbWFQbkZsVjJKdlo0ZFpndHp4M29S?=
 =?utf-8?B?eXFlU3V5dWlIRzBwbkVwVlRHS05xa3dCSGhNa0VMWUVtcWVkeUxsNG1GY0tk?=
 =?utf-8?B?emlpYWdtL1dMSDE0WEl0VFJNdEZudmlPNDZic0pmakxhS0lVMmM1ZDJhYmlJ?=
 =?utf-8?B?V2VReGgvMEIzL2s2K3o0N1lSMmxwd091cU9NLzRqUDJPa1dOa2FXYzNuYjVj?=
 =?utf-8?B?andWcWkvMld5SldCaXIzT3VuMFIxbDZIRnFUdHd6cnNudU1qbUI3bExVTkxm?=
 =?utf-8?B?NGtLSDZ6eHgyLzFEenhGeHBSb1J3TDVPUXJxQ0J6NFRNYkNFeEw5NWdKUXYv?=
 =?utf-8?B?UFlENHo3Z0F4bE5CUktVdGVKdjdvV1BTK2NaWWxmOERFZk8yUkxSTkRyWGN4?=
 =?utf-8?B?djJ5ekk2TW90bWRDRklJMWlJNnAyT1RBWm56elkwTHFtNkM3cEhvVU5nSHV5?=
 =?utf-8?B?UXl3ckk1SVNMazh1MnMrczAwSHNCYjM5OG9IemRJLy9EUUt5YlJzaWNheW5G?=
 =?utf-8?B?MWZ1a3ZUYldYTTJxMlR2bGxzc3NmR1FYYWRYUGRrYUNyK3Z5RHpJVFE5MEZq?=
 =?utf-8?B?SUJZVkgzQnFVNyt3VVQ5YU0xNWltcWhrd1VvaEljWHdWOUEvNGp3RGc5UUFo?=
 =?utf-8?B?Tld2VU5ITnNRZldlMHg0NVgvQ2hEcFIzbzBDRVJkWm52U2tVK2lPUm0va0tJ?=
 =?utf-8?B?eTZVc0hoUjRKQ2htT1BUeTFjU29kbTRlKzlKZlJDeGUrOUUzOXIrNmk1Vkdh?=
 =?utf-8?B?Wm1mVTAvREJvWmhqdkVCQ01pWHE2cml2ZEZySkxzU2RLR0w2cStENnk3Yk15?=
 =?utf-8?B?SzU0TGRjVVg1L0xncVRxV045TjQ1UXhLd21BVDEzRTAzYytLUWNtZ3J6R3FK?=
 =?utf-8?B?V3h6bzErUHBBWkd4UExwaFkzREhyd0JwOEFHWkFjSUJsUHNPa0t1K2hlSEdO?=
 =?utf-8?B?b3h4TXowRi9TUkM2MFFPWVlUYnNVQ01tQlNFeUpETzQ2MWtKQ0dmamtzSmYr?=
 =?utf-8?B?ZXJoODk2R2gvcFVnK0gxZUtXYTF6OVk2K1lZTVQycy9lMnZtWmJta3lzYkNq?=
 =?utf-8?B?RXdybFZhbUk0SnlzbVNKYkREZEdOWEoxMm9jTWxUQzRBVXFmSmc5MVh5eWNK?=
 =?utf-8?B?aERzTm85dGVxU3RLWGVCN3gvZ3lld252YjdpTUw4UWROZkVUZVJqbXVIaDV5?=
 =?utf-8?B?K0I3WUltNFg3Q3FyZHNUSExMdUVBZkIrK3U1MW1zcEpTeC9zTEZyYmhmczZl?=
 =?utf-8?B?MFo0WndWUGc5UVZxelpNYWlhREY1eU5WSzZrRGlvbGVndlRyeVBNRFpoTVFi?=
 =?utf-8?B?SG1WQWtNR1k3MzZqQmxsRlg2OUVrVERXdnpQUm9XcGNOcXFIL1R2cWo4UGFM?=
 =?utf-8?B?ZGpPSEVJaGlVNUsrR3l0NnQxVldMbFUyYWl6K3d0SDk3UHRZQlpFOFdPamRs?=
 =?utf-8?B?dExNSnFOVnpwYmJ4NFh4ek94RndMSE1JbkZRbXpCaVVKb3N2SEh0L1Bpdmhp?=
 =?utf-8?B?TWJCUGhqeGp6cW90V0VlSVBNUVVjcGcxemgwdjJpVXM0Rm95VXhTMGE4bjNq?=
 =?utf-8?B?a0hWU2tjRnFKS3Ura1BxVy9WZm1EVFRHbURPQjIya0VMUUx0WTdpNEZIZVpV?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32882398-8c33-4faf-f530-08dccb3d32c9
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB7240.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:51:28.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlDZ33b6X8GwESP17uRcm5uUKSU4JpN/itOll+HsCvq9uVIWzfsA4YCVCC7PmqDlNJQdRrIFYlP+HPTv6Jnv4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7376

Hi Philipp,

Thank, please let me know if you have any comments.

在 2024/9/2 18:10, Philipp Zabel 写道:
> 
> On Mo, 2024-04-22 at 19:11 +0800, Kelvin Zhang via B4 Relay wrote:
>> Add a new compatible and device node for Amlogic T7 reset controller.
>> And modify the driver accordingly.
>>
>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> 
> Thank you, applied patches 1-2 to reset/next.
> 
> regards
> Philipp

