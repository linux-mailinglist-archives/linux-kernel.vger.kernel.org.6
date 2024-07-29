Return-Path: <linux-kernel+bounces-264931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00AB93EA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200C7281B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C03207;
	Mon, 29 Jul 2024 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nEp1GYJ/"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2037.outbound.protection.outlook.com [40.92.15.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A678F44;
	Mon, 29 Jul 2024 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722213244; cv=fail; b=tLjM4bamXL9WRdMZgSgwr9e18m49mEnfJRM/Jaj2nDmBny4py9AbacBI5ZiaQfYOPAlSWWLig5Z7Z8eiKo92MigXVKRjg9cBkId7xc64OwMsEmU5KiZIgfMWNUFFDhjos4IQM7RWCXU7mn89yfXLIoX8ICOT2eO1j9fuvP6VcOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722213244; c=relaxed/simple;
	bh=puL1RaichTGKSJ3ESQzUR7Tg3B8j6vD0dBhkpWPBmP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqhAXLJdP2/eoSEQhsrPoZ6TOXXvql8fSzPpB1K6Fyj7t5f8PyaRiot32gk7tPWKD1VZCcUQIBskL04r9xxLL+IAEuSZnicuIHR2G8JfVneq4XNosb9HAx6s/RCdgRam0z5Pcllo9JFQ2gEWgs6tZil+uUxOXv+dClZzwCNfUJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nEp1GYJ/; arc=fail smtp.client-ip=40.92.15.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkBGu8ZXb2JgrHs3RKCKBfGwItg3i/hqV7eZCbqyhmxZ5vZEBxOL5bDaSpShNvnLcST37nX0yYwS8WvZoVY9gX0YvoGs/Nwx9XtnMKR0hH8A4thIwH1dI/WlC8H77xahZvUWXx96IbDeRQuYGcp/zom/LszElcRcXG8Yijrs6NZWzcEIkV/bWydNN4p+yYHEWSlUCnitEM3ALBn5iUNptWb23ZOdbgMGZgVdmo8k/F8v4WWHALzY2nedH31+LzncqNRm/UhGelP/oPFKTNpqaK1yAzaQV1cRILaLVjyKf7FoscOMDpvMaFQhxLXV59ItMu3SS4VSoXk3RnByaa8C8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggGT/fZtzKodRRx1TSoNN+eBuCF29UfPUR3TSAw2GCo=;
 b=RdcM0nf5mLjWyInCm/m4qWqxqYsyTv8+ZwYp0vQVEYSypDgVCawajjGtONhEw54zBWWs13EOYNTEl6Z7q+Z6FsoL78+0IdWoTjpEgRGLqF8+iWMIlTgh5kUoX1ucH8ez+i5XUmz7NDw+f0q8n0plZcJw5N5vX4p/Yx2oop7KtIxBnY5dyhLp9OQ6k8YEdTSPRYccsj+/ORWLY8h1YwAsLzo3qxCmmwuLzzJsaVD3UBLXFXUXBoBsMRa19arJMnOs9U1DS7wHExJ47RokQOzBNzNYBj1iIl2oKU9qHe4gBoPcWJtCCE8Vchf4uW6mkY9Eis3bFgeSm5TxrcefSudx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggGT/fZtzKodRRx1TSoNN+eBuCF29UfPUR3TSAw2GCo=;
 b=nEp1GYJ/wLjSLtwxKhhrlUEYwTEoAI46FUt8LDuIqfyeyQzlb49uWgGYu0EwYL7NImhlDqnT99gYFhCcjBGIsM/ZT8PSP7+SQwD4Q8woDJesV5VRH+SX22v7xC/uhiSdp+uNT4TLGQHcDUqg3GHuwVad3YGJN3QOHOoJUEMDM9VDqBMkZDKS6Zdl32NJmXLiKBh0Z3eXSjlHOuPu/YPi08NwWID/7YaEg9//btbn8GBfLeVu3B/lMo8ISOMRo+H43+8GZQKSrHJ/heF8lM1fUviLpcPjz9F+sZdtcbMcqrlGifL9yDm4xgc2mHlIJFmi9JfbucxO+1RcAxWJekc0bA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5383.namprd20.prod.outlook.com (2603:10b6:806:29e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 00:33:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 00:33:59 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: Add sdhci0 configuration for Huanshan Pi
Date: Mon, 29 Jul 2024 08:33:17 +0800
Message-ID:
 <IA1PR20MB4953F92B4B7EB5100F6D1DD3BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49538AC83C5DB314D10F7186BBA92@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538AC83C5DB314D10F7186BBA92@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [fhg/Tksc668N7PHuTfLCpxmLbKqsxeny6bZq8THRdhI=]
X-ClientProxiedBy: TY2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:404:e2::32) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <172221298391.524972.999277281936368855.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: 355f95fa-76cc-4b2c-8447-08dcaf6622f4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|5072599006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	kCh+qKexHnH+vnI9ZGyv+1AwJtzbqTh69p7DcmfzasbAw9X8svLDLeKOMV7JsyNj+yZHjGBUkAhRMiQ0HCxyEI7s2gBM5/DQe/DYYXx7RMypj7l8RQ7U/7ywbNjF3MnkugAg0ZIWMnTn1JZwZgXJadzm8Fxyyaycgn67dssXSYibxdzOjVDq4vKHCQSvwyOGG+Jl5/KvhvDrHySLP5WVGhP/ixrz+v5Xa8kWn2kYnGYQfDMKw49Q9StQXTWBt2bmDJhUNk4z/cPCbf6FLLHwkQ2wyDnBc3mqH7cBj3sCHLzG87sIATwzlqVVD4HOe3PRhurU9qV9+E9y0jKiEXKXv7AqYq3UVK8IvF6BI423leFC8daZbw1G4FAqMV19um0P8EqYcNynz6P4/MNuOlR+TAwJl4mJqsihtkv+HgDEq8d0Gt9tSmx5rYoIsavnofNVnU7P5XG/kEeAxrkIlxRxQcQp4ca/UGbHwHoGN0EY9hJKf6QL6wJpLN1jjPNy0UNCL6/W09CIMe6+IW3mS95CUTsQqgtDl7WoCP6J1B4LPa86QQlOB8FTxf/3I9CZdBc9IFbBuz+svicC1AdUPV+ODuGyg5vtjS+AzdvrjfEwlYfMze4pvh1zHTzS4j4Xo+eDZHFzcwrPjmrLasgSmoDqfpmeK9JCrRt4o6tsT6ZHiY94g0YEM6H0ESqBIwTx6U77jhXj8odYd/K72mak4yNoow==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDlBYmE5b0dHVXpzbXRBa01PWEpjV3pub3RudUNkN3NqZExjVXBkQURQczlZ?=
 =?utf-8?B?ZUZNSEN4U0xPakpWZmo4VFQ3SG00QlBKZGpVak5kSnZVWk9OZmNjOGVtUHhN?=
 =?utf-8?B?Lys3Yy9ZMmdabVp4UGt1TWlPenUyMm10UHNwTk5JaXFXdmhHL1E1ZWdEVWd2?=
 =?utf-8?B?UWFzbDBHeTBTbTRscUpYMTFoVVlHTXNkcE9NOHJXeTJFWFFCd2w3dDllY2pm?=
 =?utf-8?B?M0J3aUs5TERTQzZPdUU1M3IwK3pUUTM0YStwcGZSUmhKRWRVKzc5V0lBNkQ3?=
 =?utf-8?B?VG9HbDExdUFldjFKNmx6T1JhSW51M0dQWUVIZU16VUlackRjTjVpVVhwcENk?=
 =?utf-8?B?L1FvL0MvYVl2RW04K1c3bWNsM3F5K3NyYmdaeGlLTGZUR2ZNK2JaWjR3NmpE?=
 =?utf-8?B?RFBZMVUrQTJpY1YydlA5b1NqTzdnUUhRWHdHUG1ScmlrNEdJNXdDWUFja3My?=
 =?utf-8?B?aVE3cFRiOGNDSUQ0T0tSaWNCb1pwSWJ3eHY0eHVST3VKcDBQbnBtUjVkeHBJ?=
 =?utf-8?B?bVpOS0p2REhrSFlSVEpyekhqeDluc1FEakdBbHhEMmRBTHFrdTN2MEM5SHk5?=
 =?utf-8?B?OFZNcUZycXBMZU04Tjk3clk0eW1hWll0MTBFc0JwY3hmU0Z6bGxGa0pKenlZ?=
 =?utf-8?B?YzZSRUJSVE5yQWRCRUNXQVhMWW1ZWWltanA2Q2haTy9kcnhWQUo3dzk3aTBT?=
 =?utf-8?B?VzhUYTU1UUZBU1V6T3Z1VTQ0cVhQelBaMzZTbHV3bkJIL0FlcDdZMXNrTUMw?=
 =?utf-8?B?andsSXR0QkR3YUVGVGFDclFjMld5QXlrOHFEdVhpK0Nab01mcWJoNmk4WVlu?=
 =?utf-8?B?MER1cG5NUk14a1p2WmJFcW1mWDAzNkdFTUwwWHY0eC9oOXY1NVZkTTIyRFAw?=
 =?utf-8?B?UStoVFFMK1YrdE1SNmpLQ1JXZFU2Ump3MjNha3lITSt2SjJjcE5HeUVOYjJk?=
 =?utf-8?B?bDY0cmppWlZ5N3UvS1FabE9ySFBNTTllb1NPZkhrU2hJTVlMWW9ub2RwclR2?=
 =?utf-8?B?V2VyZE1iejhFSDh5dUhoNHJScEpPQjdSYjVGU3RzQXRxbVhQK0t6dTZuRkxS?=
 =?utf-8?B?WVBrMzdxcTI2aVdiZkpha0dwNGNlWGpmSEJOMGozY0psKy9HOXBiVE1QdmRa?=
 =?utf-8?B?ZVphZjlHRk84VGdhL3krZzdFclM3WWxSeHNwNTMzTnJSa1BvNnBVSndHTG1l?=
 =?utf-8?B?TjVQWUJiV2Z1Ty9jV2src3RxNHYzT3hVM1RXbUpTd1VkWUJSTU5NWEdnTkpU?=
 =?utf-8?B?UFZWdktFS1hhTnpqdFd0UVpjMHdYbXJheWMyckRHek1LZjVkZy9UdHVCM0Mx?=
 =?utf-8?B?VDYxSEdXY0loVFhzcllSNnJzMzBmZjVHb2JWU3p1Tk56QkZXbW5PWmFPY1FE?=
 =?utf-8?B?R2xIQis0S0VOT2dtOHhuWVQ1UTJKVHpaMm93TExSbEU0ZjN5TVYrcVVMcnlO?=
 =?utf-8?B?RHFIc2FRTkhZQ1NOR2s4NzRBd2lCdHN3Q1dmd01aU0I3TEwrMDRmblBWeVQ5?=
 =?utf-8?B?UGxDa2F6b2JmVkwybzMranRscVZZcWpOV3VxRVdTclQ4MjNBbkJ2aGU4Zk0z?=
 =?utf-8?B?OW02TExkNFBGMUo4c200aGRRM0dQbmpraDVaNXdlZzRzdmh3RTRYOUwyVDVJ?=
 =?utf-8?B?WWNkdDFXODNOM0t5T09kcVJtTWRzMFVmZUlMeHNJRG5aek5CZmp5VDNONDY2?=
 =?utf-8?Q?kVksH3kJgiP+ASlsXIc+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355f95fa-76cc-4b2c-8447-08dcaf6622f4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 00:33:58.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5383

On Tue, 23 Jul 2024 10:18:49 +0800, Inochi Amaoto wrote:
> Add configuration for sdhci0 for Huanshan Pi to support sd card.
> 
> 

Applied to sophgo/for-next, thanks!

[1/1] riscv: dts: sophgo: Add sdhci0 configuration for Huanshan Pi
      (no commit info)

Thanks,
Inochi


