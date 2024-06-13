Return-Path: <linux-kernel+bounces-214085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDF907F33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA8D1C22161
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B014D6ED;
	Thu, 13 Jun 2024 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Yx45KYQx"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2093.outbound.protection.outlook.com [40.107.220.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D161369AF;
	Thu, 13 Jun 2024 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320066; cv=fail; b=nzmcz2izqXyba0tJiRtgl4arzKn+Vk8rDWZB9jI8bLQFQoPIHrAlGcK5r5yyI7dVsVY2TQvRkvnfuDvy4O2x+x16LD5Ub1Wu80HETXntT6RR5E8djK4pyAFee6TxMTNeZaEjxaBeguHeJWlJaA7ReCQ/lyKqPQ56WojE3Ui7i04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320066; c=relaxed/simple;
	bh=wlh+XMSZTo0s1gZEiSWLq79c45whT/kOpNTLan/7oo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GJBiOPPHKM2FpZnuWLTtTy+lSdXdXWgoxIVUoL7nndymRbVeVJJfFnIE7hFLyJ9i96/1GcOURuo/CA9xEmaq7s2LzrC38gyVT23QwXED7PhYnO/1m9K3J7mZCgoTK+1pChs1zA7mpgOdpi7nFhHP3dZggm/+auZThtcWVwP4IgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Yx45KYQx; arc=fail smtp.client-ip=40.107.220.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW6V2BH0iS6UYOZwJe2njHILLaE5swMG4rijO1Mz4dkYHtfdfJjIHrx765N3ovcz1mMWbV0XGyZeWyDshpL8NL43Ju50rQZ6LjPA2GwKLUDqGKPffngwn9iQOAJcMnuRrHxojkh/CdmBQ0scgLSdim4RInwRwBQjwKVnVS9p92ZjlRMhibCNyLpiACHzllyGtgufbwVTRHLR3xAYp2iV+MKHMlOWhSx0wzNrL0NVIy6vNmw2ehL6SWikTBMdEslkIdourL40jkwkgXuuDLYM7OWbYARimoAlIaZa56nrWjGxG6j/XcvhlTQNC+TdE/YFIJV28+nPAg7inofpCYnfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylKtLziXH2zUErDKeNErDDjXvofiqsA9++J/5tNMS7I=;
 b=CwRJycecOh698LrHZ7FdjQ/rZ7BESiSQ9gQVl+a3QUf3nGBnH5vBOxWhQVjnj5/KFt6pcPFnUsREts7h2x/AdcWIv7lCu8n7OO42sOGkiKsroWYfpQ3L2CQwLzluNkURGH6mAM4oeXV8G8cwjpKn4S5GnDdg1awDh5mNX2otrf+Z2ruH37vwzkNLKf6O2aFV7jA1JXi6Eg0XqUBSEHkYxRG69ZJczqNpBMZN7eYL0Jy65tD0+CVeUjOrrxqmAfQz+MUO8w3L9UEY07P8NzLWm82ePXQqroXTaDsBUy2H/RuD6gCIMqSVgI4grx2zdO0A0YeH5RBpN6eJGIbPILHWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylKtLziXH2zUErDKeNErDDjXvofiqsA9++J/5tNMS7I=;
 b=Yx45KYQxna8dvyXy6365vH00SpldWtI2gJgEQVGNcEJUCD0QDG83poWd1Kyw/JtA8cL5pqVYtTK+vf/CNe2242HUf1Whde7gDcUaFhU9ERn7dE+W340oiFZX7HPS1U5MuXXqibvlxM7ePndEI0TacIq765hp8LhSrxjJA5zFQqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by CO3PR22MB3245.namprd22.prod.outlook.com (2603:10b6:303:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 23:07:41 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 23:07:41 +0000
Message-ID: <d57e27cc-3d9b-40da-a2a5-23c28b17a005@phytec.com>
Date: Thu, 13 Jun 2024 16:07:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add overlays to disable optional hardware in
 k3-am6xx-phycore-som boards
To: Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com, kristo@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de, w.egorov@phytec.de
References: <20240528225137.3629698-1-nmorrisson@phytec.com>
 <4ac40139-eda0-4f6a-8bbe-99110605f91e@ti.com>
 <5a773641-73a6-416e-8c52-eccc136f11ef@phytec.com>
 <629a95ac-3f40-412f-b983-312f434bfb2f@ti.com>
Content-Language: en-US
From: Nathan Morrisson <nmorrisson@phytec.com>
In-Reply-To: <629a95ac-3f40-412f-b983-312f434bfb2f@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::19) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|CO3PR22MB3245:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c009d15-9994-4e72-4ae8-08dc8bfda077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|7416009|376009|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnBONlR6NjI2T3VRYzRRM2U1bXlFWUxtZTQzMFYwdjFIQkN4UnRwbGZTeHNM?=
 =?utf-8?B?ajRzYU1WLzE2SncrbzZKVUV1THZya2F6VHVGWG8zMnpoSytzK0wwY3RBZHhG?=
 =?utf-8?B?bXpOQkNEbHlwZFRxL3loNE85REZGWENyRnlEQlpTRVNjazlyUkhpT0V0K01R?=
 =?utf-8?B?dFozYVhwZ3VmcU9rV1p2cGw2ZDFTYk1ldEVNSitwSUlhd0UzQ2o1dC9KMjE3?=
 =?utf-8?B?N0luelNDTGxQdDJnYi9VSTdsOTNhcGZmUGg5L3h5UkpuZDJFUDA1dVpRT05s?=
 =?utf-8?B?S3RFZThqMEdXSjJhUEFCZWpGUkRwbm00VzV4VDYzUDEyR0xDTEIxZWRPU0RH?=
 =?utf-8?B?aFRBS214WlgvYkt2ZUtvUFZ3M2NQSGlKcE95NCtOaEVVNVpxOWh6b0VpdnVk?=
 =?utf-8?B?MURrTWszL2YveUduUlFMbFdoL25uVVVJeW42QTdOZVdtek02N0hrbklVMEtJ?=
 =?utf-8?B?cDNWUnZraHhxUnhaYnUyL0FHdFQ1UHZHMmFNcFRNRmZkeko4UXk3MDNoS2Mw?=
 =?utf-8?B?RXF2USt3T1pMZjFRcGJPL3dWRmVXRjFXTWhJNGdOYlJWZjR1Z2JsN2pXZ1Jm?=
 =?utf-8?B?eHoxQWozVlBYUWZqWkJPRW8yWHBueklJL2V2ajZtNk95UmF5d0xLSU1lUUdF?=
 =?utf-8?B?SzRMcWs3SklaVWllVmtETmdrdHVYcmtlQ2t0VklId1lqS1RQOTlxL1JMcURF?=
 =?utf-8?B?U254Q3pXRE81S1FPQ3R1T1VaU2hkd0dzcjFlQ1ZvMEx2aU9UQjdCdStjUmZ4?=
 =?utf-8?B?T0VBVFlyaEc3c2E1RmJZbkhXUEtuN0c3Q2tXeDdpNTFKaTBSVEhLclFUY05J?=
 =?utf-8?B?OXd5RVZPY1locmZ1bmE1K3VsYVVHZlF3VE9QYUJkaEZEUlYyM3dOcW4xeXA5?=
 =?utf-8?B?a01pRWQzTXJWVENoWmx1SUhlR3Q3OWVkTVpXL24yNHJDaktTV3k0UVNIR3M4?=
 =?utf-8?B?Qk5VSWVKdW1NUVBzY0llbktDa1NWU0JPY0xpVVVOaHNhRTh6THVubjV3ZXNa?=
 =?utf-8?B?NzZKT1hlS1k3WWIzY0crc1hscU5zVnVYSXNiK1YxVll6UUtMMHBtRWJ0YnI4?=
 =?utf-8?B?Wkl0Y0pTR1ZqcVJ4cmFoNGlnczhTWTlFWStvWXpYZHNBeXhkdmVXNWM2b2ZT?=
 =?utf-8?B?YitLNmNOb0hLZlpBSjlNeW0zYU9nSXVVQXA0eVpQMFFIQ2I1WWF3YmdlZm1h?=
 =?utf-8?B?eC9pYlVNaUJxUExqRHluWklHSWFxT3hqV3ZkZEs1RExySWZ2RDZkbTBNNGlG?=
 =?utf-8?B?TS9lTTJZcG1wMzFqc05jRkVqZUxyMW9MalBFekM2UW1mNHgxcUV5bmxjMEpJ?=
 =?utf-8?B?Ly9RYi9MS3E2Y1JTbFBPTWZ5bStyeDVKci93UjhQZGFZc0ZYWWtyRkVxUFJI?=
 =?utf-8?B?ckpwWkZqenFZbXBQUFJwM2prTUcxSkMvYWRBS0FxVDRVNmtENlpEc21QRlVN?=
 =?utf-8?B?ckQyYURaRWhnRHFHb1ZwcWxJZGtJQ2dFV3NXdjJ0akV5ZHk0d1dLKzJDY1dJ?=
 =?utf-8?B?N3VJS2hub2hYY1pXaCtxb2JPckVjWmovdXQ1L211VUhqOERhVHUyanRRU2Zu?=
 =?utf-8?B?Z1dnS2loa1NHSk84QUVaNlBPTEVjUFhtTGxPMUc5NXUwSklCOXYxQTMrZFNJ?=
 =?utf-8?B?VHBob05mVVY4V043akwwTVRFZlRPMHBzWTUwZFYwcXZ1NGZOd0YwUjhCaGVZ?=
 =?utf-8?B?UW9iakJ6VFFncWF1d2s2UU1pc2x2NGlwUTlJakI4VFR6eHhsYk5FRzQvaGRJ?=
 =?utf-8?Q?ZJeQ28S2FiRSXat0g4Ve0xWCS937fC5qq5o/4Wu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(7416009)(376009)(366011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnJSbExFNFZocVZSbWdPaWVoWm5maXRFMjcwR3o1YXptejc2Q243dXlkazJ4?=
 =?utf-8?B?WWZpTTVSOVZRV3JRMWVZTkExamp1cUkrRElFMGpWVjFPZ3RIUFlmWlJ4elFP?=
 =?utf-8?B?bWQ2LzJUMDR5RU5zcmFhSE1ZYXNHUzVOeTFweXVkZVozK1prcVdXWSs2K3Av?=
 =?utf-8?B?a1dGcGw5M0VXc3EzbFZ5TU5pQmVMNWdQSTBWai84VVNNZjRpQ0VGOVZvNEIr?=
 =?utf-8?B?aDUwNjM3VjUwamI4cEd4ZHlhaDJjaTJQMm4xVEVzd0YzWGhqdHhESCtMOXF4?=
 =?utf-8?B?d1V6elF0UjlmMlBHaTkvcDhnd1F1M3dqRmRpM3NxOTFPdFRYbGtKTmxNUWdh?=
 =?utf-8?B?NjJlcHN0ZlZLWTVmd1dNb01kZ2RzVjkvMWVLVWZsYmF0OHR2eWdHOWpTYS9o?=
 =?utf-8?B?aXU3Q2Z3TUowSU9JSXZyR3hvYkh3aUtDTlhtQXJrK2ZDWEpEdk9UZGJadlBy?=
 =?utf-8?B?WHJqaFlZa0YrbzU0RloyaVRaRHdsaFJnUnhiL3owaHRDSWNuR0JLZTFadDd4?=
 =?utf-8?B?ZVVTMGFDTjkyZGJHeXh3Q21iLzlKM3pWTnhqZ0NNRUtaY1MyQjdyY0xxMjFl?=
 =?utf-8?B?UWhTS0pLR2JpTVZZNHhtbzRXTHJ6QytJMndhakl3dmxkYTBQRnUxVGJnTUNT?=
 =?utf-8?B?U1ErVVlzTmNmbUZ0RzJleVRrSWxsd2xqZDRQenpqQlI0ZG02Lzl6dzlpeWth?=
 =?utf-8?B?akgxMks1MDRlU09Lcjl3c2w1WW9IWXVVTWhZcWtmUXRwdGluN1YrVnN3NFNY?=
 =?utf-8?B?d0Z2c3VQSDlteU9TK3pzR05qK0JSWEtzTjBIa3dHSWRQY2FuMHFlUzhoOTBL?=
 =?utf-8?B?cCtKY2IwQU0xVVU2VFpuWFIzZVRjN2ZoVTNOTWZkNDJ5UHhLOEhsWnhMR2pi?=
 =?utf-8?B?RU9YaUIrckh1UVZFNVIrZGFhSXRtQU9LUWNPaytUM2hRQm5tenFSM09PZzAr?=
 =?utf-8?B?cEFKd1VvaTFueXlXN0lBbk5MTUVrSHBaVC9mNE14ZEFzUjZFa29XcVZRNzVY?=
 =?utf-8?B?b0JWa24vZkV2ZlY3UHF0aEIxMnVuUWpmdm9FOTA4R3BxSU1vRFp4V044NENK?=
 =?utf-8?B?NU5GTFowMmJBQkpib2xXaldlYWlzNldyS1B3bEM3VTdYc21CRTlmWWc5bzZx?=
 =?utf-8?B?OUs3K3ZoOXVIVzZwc28ya0Vhbys0VVZtcEVKbUU2QmR0V2dmSTBDT0lmWGFm?=
 =?utf-8?B?Q2lVclh2dS9TL0syemx1UFB3Zlg0TUdsQnNLWEc0cU1VMVN3WHFSYTJrdUVs?=
 =?utf-8?B?bko0M0RUamwrNWErSDE1NHN1WE51Rjh3Z0FZSU5rQ0VOdGlzQkhvQWtGaHp1?=
 =?utf-8?B?S0ZocFo3UlllQnV6SmM0TjU5R2xEL21LSW1NMXdBcUtuUUVRcXd2VE1vYXkw?=
 =?utf-8?B?aDBJY3JxMUFYdVVuMG1GTUxwTndnTUk1Z01qYlVQRURHU01XYnhybk1JZUZV?=
 =?utf-8?B?dkdFRndNNklhSnQ4R2V1NHgrRDNIVHFMY2w3c0JZdXNFS1YzWlVIT0wrbE9K?=
 =?utf-8?B?UzdqYVhUazJTL1JZQkU1UkxOajNkZndQVlZOVy8ycTNOWTkwTkJndEp3a2RI?=
 =?utf-8?B?cEZ0ektWaS9MZVgzWm80RzluZFVkNGxXWHZVTXR2R09BSkQraFl6dTZWWENQ?=
 =?utf-8?B?YTNQQXloZFYvYTB6L3hVWnM1cFoxKzFoL0xkL3hkQ0lRRDkrNEhsZG92VklQ?=
 =?utf-8?B?bU9XM3R6R1ZQVzhOS05BVTRzdDVWSHRSeFJqNFR3a2h0N2dhT3FEdVJYaHFo?=
 =?utf-8?B?ZUlBMmxWL3dsZnBvUm1KR2FtUnY5THk3MFltOGxxSXV0WTdZMnlDMkk3L3ow?=
 =?utf-8?B?aGExK3ZPU2xpaHd3b2xyQWdTOVdabTUzUWtwOVc5azdNSXZHQWNZRGJrMG5x?=
 =?utf-8?B?bCsvYzY0ckI0MG56Qk1QU1FQZzZVM3VMbWg2RCs4cFM5VkNxNzJuNDJLTlpo?=
 =?utf-8?B?Mkd4Y3hHV3l6Z01MUVhIV0dHVEQ2dHMrdEVPTzM1a25HQmVTQUQwdjNaMnJI?=
 =?utf-8?B?R1FkSDdYYm5IYTB2akFjUURPRWROOHI3dHRJeWpYUzNYeU1jTnMzWHdRK3BB?=
 =?utf-8?B?UHpwSzVMbExkYzhFWHJVUEtSMDhjU1JUQ21keDVOWGszK0t5MWxzVnZySEcw?=
 =?utf-8?Q?P2ApHJ+5ELh55eaT8/s/A0beG?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c009d15-9994-4e72-4ae8-08dc8bfda077
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 23:07:41.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbX1TqLecznWx0oCryB3Ca9ZJqyQTes39btQvYkbT9124Dpfgba12J03DtqkeskXwNjoh9F9+eZe+Cnn7qCsqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR22MB3245


On 6/12/24 3:19 AM, Vignesh Raghavendra wrote:
>
> On 05/06/24 04:45, Nathan Morrisson wrote:
>> Hi Vignesh,
>>
>> On 6/3/24 10:41 AM, Vignesh Raghavendra wrote:
>>> Hi Nathan,
>>>
>>> On 29/05/24 04:21, Nathan Morrisson wrote:
>>>> Add three overlays to disable the eth phy, rtc, and spi nor. These
>>>> overlays will be used to disable device tree nodes for components
>>>> that are optionally not populated.
>>>>
>>>> v2:
>>>>     - Add build time tests in makefile
>>>>
>>>> Nathan Morrisson (4):
>>>>     arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
>>>>     arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
>>>>     arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
>>>>     arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disabl spi nor
>>>>
>>>>    arch/arm64/boot/dts/ti/Makefile               | 17 +++++++++++++++++
>>>>    .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  2 +-
>>>>    .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
>>>>    .../dts/ti/k3-am6xx-phycore-disable-rtc.dtso  | 15 +++++++++++++++
>>>>    .../ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
>>>>    5 files changed, 67 insertions(+), 1 deletion(-)
>>>>    create mode 100644
>>>> arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
>>>>    create mode 100644
>>>> arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
>>>>    create mode 100644
>>>> arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
>>>>
>>> I am not sure if this a common practice to have overlays to disable
>>> missing components (at least I dont see such dtso in kernel). I would
>>> like to see an what DT maintainers feel as such dtsos can explode in
>>> numbers.
>>>
>>> Is this something that U-Boot can detect and fix up for the Linux DT?
>> We have an EEPROM on our board with information on what is populated on
>> that particular board. We will apply these overlays based on that EEPROM
>> data.
> Typical usage of overlay is to keep the minimum in baseboard and enable
> optional components in the overlay. But it would also depend on whats
> information is present in the EEPROM.
>
> Could you provide bit more color on whats in EEPROM and how each overlay
> would be applied? Please add the same to commit message and respin.

The EEPROM contains information about the configuration of the board. 
The standard configuration has an ethernet phy, rtc, and spi nor. These 
components can be left out to save cost, and that configuration 
information is what is stored in the EEPROM. If these components are not 
used, then we would use these overlays to change the device tree 
appropriately.

I will send a new version with this in the commit, and there is also a 
more detailed explanation at [1].

[1] 
https://lore.kernel.org/lkml/4e7dd467-20be-43ce-936d-200ede6d511b@phytec.de/

Regards,

Nathan

>
>>> Unpopulated SPI flash and RTC should ideally not be an issue as drivers
>>> would gracefully fail albeit with some sort of error msg.
>>> Not so sure about Eth PHYs though.
>>>
>>> Also, Are these dtso's mutually exclusive? ie can SoM have SPI flash but
>>> not RTC, have RTC and SPI Flash but no ETH PHY?
>> They are not mutually exclusive, you could have any combination of
>> overlays applied.
>>
>>
>> Regards,
>>
>> Nathan
>>

