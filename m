Return-Path: <linux-kernel+bounces-277178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54C8949D84
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F26D1F22EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E1518FDAB;
	Wed,  7 Aug 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="zNB/tttj"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020140.outbound.protection.outlook.com [52.101.128.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E3BE4E;
	Wed,  7 Aug 2024 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722995719; cv=fail; b=LjpuTTVrU4xZucgpg8NrP2TpZUM463DCYp1TsaWeMHJLj6uiacfT6PMKHd8wY3ZkMH6jEsBIsIFS6umDOZyoqeMtp6+wqVYT/NfVObnZF+sts1dwz7R3Byf1xeLNRMcwFFooErPMj6Z9daNGRVSjFy1vY2CVu99RxBNttGBZfuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722995719; c=relaxed/simple;
	bh=vdK1tmHIJhxnwghyziHkdqTOX2XvBMUJdWw1ESG4Ik8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkGrLRB+4TtCgGReyTieDQLysW5MRcsOLAha+GeSYTvmFGJL5nBhllCUDdzXoNuvmwJg3BaTEVQLwWcyjaQm+QY+21tnkXEnwX82yagn3rAZvnQ8JVnNtvV1gExrKVB0pll1ZSjW/WVZcEhJ4qEgGdRtpij3nT28nBI5rZtcxvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=zNB/tttj; arc=fail smtp.client-ip=52.101.128.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9YWVi0nBGerTVkAkU9j7EXffjSLIbDp4W5C/P6TKuYcrwwMa42BSFTtuDODbAyuF/vRCEG1l1ZAJB11+kCYc3TvTTCncnv3CV+bWduBelAv7PuDod6bWqGFw8qYTxlNjvhf87VC5xvauVr90j8gibeCU4wZZvGvzQ+XhRFpPJKFbPVzdU4pRZNX96qgAu+xHS/G1VLPO25rCnzYy2bBs5KTUmwJjZFJloMgkpD7u1tCFeK9pxLUKDA3e72mdKOFlaFZcj9h3KzHFR4osqR8nszh6+7qCZrzxHR85WpfIhxNUOiH5/QRWZAHLj8VlletldT6rJGIhgvCo4ChWGNICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV62snHnlgYlcgdEWyzMbq4TlMRVc9D0o01xUVRz3PI=;
 b=JS00LI2dDjqoB+sodqzdW68x7nP511iCiHFN1tRAr9rXtk5X/9mYVY4mtNPMattuje6EaJwBiu+CFPuZNDu4MwImLKD+YyGdeIIDiA2lL3zfo9l/IQRp6tn9z4Dtx1SxOB0BDK7bhvs52xTkpF0NXvRgIE9NSHtiGG+klpZRTNs1F+mUv1E0ACLiJMFiBJ2X4X8R9brzu6MWBEa4zunMc3MM2sSht+yy05ks9dGGmJwI4JHLPLZJw1oawk3cmpJpUJjSVuOe4d/qn9TbH8ldUnDKUyUZ/l/OgbFDW4ALzYKVmGNsb8BamEhL8WY4GbE1wvUB3XhCIcykBvIZFzq94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV62snHnlgYlcgdEWyzMbq4TlMRVc9D0o01xUVRz3PI=;
 b=zNB/tttjsqLM7TevErvSXhtxmyMpGq+U+jzg6/EP4fzYU50X03yXEAFBzDsUpHi4SduLmfNQ497JaMB4mzyQe1SqrQlauW33361AhmfyqBAqE33ha38CBfmXE5Y8GQZWijhJMdIRX/RnhozO8/R1jFt059xmWqbYbvxSYQ8tVb5S22UY2kVFz31OZdnD0XqB2Xi+RD+VTZWZdHs2bGoKl/N9Y44a5jrKrFh9gw11dF90qpwcvzkiZLvTHwFqKjnVWGEybHdM6B/toaYtQQk08Nje7avSwNaZRqWslSn0jeyzTVs3tw2dJ0pbpd6JQeGEGsFlMhdcPSrYL35EiSFXFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB8615.apcprd03.prod.outlook.com (2603:1096:405:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 01:55:11 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 01:55:11 +0000
Message-ID: <86b01ecb-6ca8-496e-b3a8-0b21bb951a60@amlogic.com>
Date: Wed, 7 Aug 2024 09:55:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clock: fix C3 PLL input parameter
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240806-c3_add_node-v1-0-c0de41341632@amlogic.com>
 <20240806-c3_add_node-v1-1-c0de41341632@amlogic.com>
 <b63fe216-ee29-489e-a175-e1525ac12722@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <b63fe216-ee29-489e-a175-e1525ac12722@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::6) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: afcfbab2-ea27-43f1-2b1a-08dcb683f903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTNNK21Zc09QZWxnaDdZQkcwT2hZV2pGQ1dMNFBZcEtYUlpNYytodG44L1Vm?=
 =?utf-8?B?eWpsbDhJUTRqd0trRjhpZTQ4RlF4NnExNVZWS2dnV1hpMVZLOTVXODlWaEVE?=
 =?utf-8?B?bUQ1VkhqeUJKZCtrSXphVjljWmc3b1FJK2srYVhrNjl4V0dSMWFvbDdYSThY?=
 =?utf-8?B?cTJlWEZXaWlyYjVpeEpYeUY5TklPVVpkRjVXdTByd2szS0xJOFRjbS9Yc1JM?=
 =?utf-8?B?a1ZrR2hEeTZEMmpYaEJPQUJuaVhSZlNFWUF2dTRKMmdKeU12ZVpSRWQzYVNu?=
 =?utf-8?B?b3dJUS9BU1kydUNYVUxkRENLK0VSTnc1dHpUekZ0bnM0RzQ5OHBaL2JtUWMv?=
 =?utf-8?B?V25KU1JMZ3N5QW5teGdTZ3VtWkE2ZHd0aGhSYUVkVVF5bXpueDJWZy9YTG11?=
 =?utf-8?B?RkdCNW4wVzIwZndmYXdLbnpNd1VOOVhuUzFENUloUytHT2RTZjVTamFUeUVU?=
 =?utf-8?B?bVVJRFVmWHNUTjM0WDdTZlVnRmRxa2tlNEU4UU1GV3NOUnJaaVlDV3pTOFgr?=
 =?utf-8?B?bU1ZUjlzdjJkL2RjNlVLS0N6RCtvSjY0eVN0cC96TDlvcVpLeUxxajNlRUVQ?=
 =?utf-8?B?b244Sm9HakYyKzFJTHp5TlZSTHVjekhvSHRwUnB2VHBRckxKZmJKNk8xbjVj?=
 =?utf-8?B?bDhoMTc3YjJlcG1LVFFoUWs3eWsraXNzcjdlbUhsVjZVOVJ0RDZBSDlzcUd0?=
 =?utf-8?B?aVJWYUk0SFNUU3NMRldjQ0ZxQXpsNzdUWGpLU212UmdRUDJYUG5yTHRrRFpa?=
 =?utf-8?B?cmE5Rk4vb0U0NlEvcUpDdjBJbitWcHNsY096Q1FsbGFEUVVlQWw4bC9vL2I2?=
 =?utf-8?B?dGJvR3p1K3J2KzBRSXJyQXBDMHVzWUxKZU1BcUJPUjRHMVpFU21keThUbVAv?=
 =?utf-8?B?aXloSVpQb0wrT2FMYjlCNWlVSUZVckdqOVhmaUV4d3dqQnlFd2RUZ0dEN1ht?=
 =?utf-8?B?S1NJUjIrSWlYVncxaDZ5RHBqa29HdFZmRXNTVUs5QjJmK1IyUG9CM3VJWVVa?=
 =?utf-8?B?clpYdEM1SGJLdk81NmRSSng0SWtXYjZ1M3E0ODFEQnNpWEhtRGp1RmpLWG9I?=
 =?utf-8?B?U3Q0Zjg5cFUzR3Fuam1sVkpxWnhla3pKT09oM3FMelZ1ZVpwNzFaSExZZ1Rw?=
 =?utf-8?B?QmhNZDk1RXZNdnhEOCt6WXlvZ0FIcWxkM1RFVlRBNG9ZdG1zNWh2bXArL1Z2?=
 =?utf-8?B?QUhzdXZudTdaRDB3SWFOSzJZNHcvaVZGeWx5RllHS015Q0RvOGZpNXJjbFZ3?=
 =?utf-8?B?K3dLLytiT0dkdjhYVWFjVTY1cWt2V0ZCaUR6dlQ5WmZ3TlZHSDJxVzhKbzEw?=
 =?utf-8?B?TWNnaEJ3SGUrNklubkxDQ3kzNnNJU29VajEwdVZHR1U4ZTd1N2NDMWJMTlpZ?=
 =?utf-8?B?NmdmRFRrNDVLK3FZN0phcnpyZHdtZ1RGNGdqYW02MnFXYmNlMDVVZkJkRVlI?=
 =?utf-8?B?djJHMXdodWhSdllwTUp3YUV0T3ZqRHRDWHJnS2lGMGtBVUlWejBDc0dhQjY2?=
 =?utf-8?B?dnc0VEdVTWpKT3Y3K1FUZUlJdnBaeXcxT1ltcGF2NHpsK1NsTVJMUHM3OGlp?=
 =?utf-8?B?Um4vREJYMG9YVnJOWGdqMGsxTWFTbk5HS2FBa0Rwei9KT3JYd0p4T1VDVDJ3?=
 =?utf-8?B?VGptQWsvdlBpZ3M5clo4cmxVTlZmR093RHdTVUhRL2x4Z1dtOVRkSkpSazlh?=
 =?utf-8?B?SVJyeTdQR3drd3JyMm83d3pONHJqUjFWMWwrZWlkREt3Y25MdzQraVJudzVL?=
 =?utf-8?B?QVRxSXR4UC8rVlZsWnFxaUhoc2RnMnN2ajdnZ05SZHdnK2s2WGh4RmxrSWpv?=
 =?utf-8?B?SjFhSUJvM3Z4Tm1LYzRtYVVNZGpvNVpwejQ3WkJYSklLdXpSMFFGTXI4dkxO?=
 =?utf-8?Q?2jUm3n5kvSsRI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnZCSzc2WkwxQjFYOHMranpTcG5IL0NpYjVYRjFiQXFlSmlnM01yM2xEaldJ?=
 =?utf-8?B?ek1XMWhpaFhTNXVIdnMvTW9hNjVSdWZBZStHSXJqcUQzRE55SHlSUjJOdnNz?=
 =?utf-8?B?OHh5MHBMSHR2c3k5Mm5KZm0vVmxYNzBQdnREN1dMQzVCNENpTEJhU1ZIYjIw?=
 =?utf-8?B?a1VOY1F1QlhtSldoNzlOTWZzQ3BKb2U4aEVoMXdBRTNLeitnL00vcXlnZUJl?=
 =?utf-8?B?MFhMMmlqUzVOZmZiY0k4ZG9FcjVmT0VReW1TV25leTJ3ZEZMSkg1TS9tWHZx?=
 =?utf-8?B?MkFlZkdmUExDTHl6QUh5YmNqU3RlWkV3OEZva2Z6Uzd2K3FNMU9XRGxZQ1Zz?=
 =?utf-8?B?R2JVVkxtRFp1RzJ6MmNUWlkrNTVUL2Q5dlRaVUxsODh4VTlvT0Npdm1naWJS?=
 =?utf-8?B?Q01hMVBUMHc5bitGNlhoRmI1QUVaK1VLZjdoMjR2VWVOaTFnR05GM1g1Smlo?=
 =?utf-8?B?SFZza2FnSUtucUpTZlZCRWJadFg0VTVrOFNlOEZmOXAzL2d5eHNuRUZaM2tH?=
 =?utf-8?B?ekRKV2ZnMm9qSHF0Unp4eFRiM2NZU1BjSzBDejdKY3FNdFNSU2s3UW53anZs?=
 =?utf-8?B?Qms0VWZ5K0ZZNjlqZjlMb1FzRXhzSXBRbGtyWEl2Y2I0RkpyUHRTd09Hb21L?=
 =?utf-8?B?bmltSHRaMEswS2hOM3Vib2Q1YnpxUHB1aXhndkU2K3dIalNTQVVMeCtid2x2?=
 =?utf-8?B?akcrWlZhaHkrbzJnOHFDNUJ3cVEwR0t2dzdCbDRzUm1nVW1STGhKK3VqSm1B?=
 =?utf-8?B?Qm9VRXJHREM3ZUptclFtZzgvWEloZWQrMnFsT3dRbDdmM21MS01GVlNtMDg4?=
 =?utf-8?B?N2M4bXpJM3dpRzZqQkNZRHNRMHlycUZBRVpZT1R3UXNPWjluaDJsSTF6S292?=
 =?utf-8?B?b2hheFgvaXFmd1VxWFhhVzlLbldaWVZrRHpwckdhMHhNajhLbElWVmYvNkRk?=
 =?utf-8?B?WU1TaHgzKzFONDBwUjFmMk9mNHAyUkdlRzhPRU0yQkZZZVR1cnc5eS9mNURE?=
 =?utf-8?B?bU9JNXVIVGtiWU1vYzRZNFhrV25vRzNRbFZXVE1GQThLWjZDMU1ZVjY4L2dx?=
 =?utf-8?B?OXNlQ1c0YnpBa1ZUSmx1QzRicHRMelliSXdEa2pEV09QYUJDZ0pjdHgvL2NN?=
 =?utf-8?B?NWFVWVhCUkF5NFBpTU5XNkxJdW5ySzFIOGpMWUhzcnhMdlh1SklXNUJxMEdB?=
 =?utf-8?B?WlowNDlBSEhPMzZ0aHBUMlVXZ2g5WlR5VEs1b1hLU2RIMVlJZlJCWXBJNGVu?=
 =?utf-8?B?WTVpUm9PWFZscmViTXlzVCtaY1Bicjc3Z24zRzJRWmkvMktPWHorbWtwWnBD?=
 =?utf-8?B?WWdDKzJQSmNaMUdLcExWcGtDNjhIZDhyZUxxM0pkNGFFY1VwakozcjdqdS93?=
 =?utf-8?B?dTRZV1NIWjM1dTIxajRJZ2hpcGNyVVhFWDY3eU5aeHNtMVYwK3NobWs5OE0z?=
 =?utf-8?B?VkJyd3dQREFva1J1RXJ2NS9OUExuWW1QTEJ0Zm8xNUNVd3ZzQmhDb3BUME5p?=
 =?utf-8?B?RURMOTI1WjNXMm0xUlpCQk9xK0R2Wnl4aUxsUDU0MnZvdkNIR1VXdHdUdHpw?=
 =?utf-8?B?SkhkWmFFVC9PZzcxOWNaRktRMWl0M3NzaVlUTVVQMVBhQlNUVDlOTkVabzNI?=
 =?utf-8?B?aytpMS8xampYU1JlSmd2ZFd5a2hhdDFwWTltSFVqczNtM01GSGNnYWhqeHdU?=
 =?utf-8?B?eDdBRVo0Rm5XR3lpSGcvN0oxL1RuSjhvbGptcEF0Wmx3c2J0eUVuTno5b0Z5?=
 =?utf-8?B?YTRldFhLMnA3ekdqWi9ac1dyWWFZMWlYTjF0aSt3T0dKcmpPbitwcGIzY0cw?=
 =?utf-8?B?UityYTFqbDNXV0pjY1huK0lzdWFwOE1VdG9lbmRtQldGVndMMmhRQ0d5OTda?=
 =?utf-8?B?Nk1yeHZDZkRHMDRySURESHJXNkthMFpOQk5OdWNRd1FaY2krQ2gzOFRBNlFL?=
 =?utf-8?B?VDVJZDY1MCtFM0F3djZLZW5YY3JkRUQ3RFhMN1h6N0FRU3k3WG05eGlKekU2?=
 =?utf-8?B?YVZTOUFUOVdNTmhCVVlYR1FwSzhvRUdHaGFBKzRuN0ZmeUExK2xGaUFaanpE?=
 =?utf-8?B?N0xvS1gySURRdW9uRGVENjNPcHM0RXNsZndFUmlrN041bUw3Q0ZST1hNQ3ZL?=
 =?utf-8?B?eUZ5aXFGVmtBWVNCeWpFQ0FqdHJJMUZoM2dCOFB1L052SWhzYng4UjZCS3dn?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcfbab2-ea27-43f1-2b1a-08dcb683f903
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 01:55:11.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vE8q8fUri7YsgT+PPbX2QiVAOOIEI65ayXlsQ88ox/EN7bJzUj5P2B18qz19GZScAkpowyfUT6RQaNqzqDhHTyvAvdepClcBeiq0JWkh7yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8615

Hi Krzysztof,
     Thanks for your review.

On 2024/8/6 21:10, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 06/08/2024 12:27, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add C3 PLL controller input clock parameters "fix".
> 
> What is "parameters" here? Why you are adding it? Is it missing?
> Something is not working?
> 
Yes. The previous submission was lost.

>>
>> Fixes: 0e6be855a96d ("dt-bindings: clock: add Amlogic C3 PLL clock controller")
> 
> Why? What bug are you fixing?

The input clock of PLL clock controller need the clock whose fw_name is 
called "fix".
> 
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>> index 43de3c6fc1cf..700865cc9792 100644
>> --- a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>> @@ -24,11 +24,13 @@ properties:
>>       items:
>>         - description: input top pll
>>         - description: input mclk pll
>> +      - description: input fix pll
>>
>>     clock-names:
>>       items:
>>         - const: top
>>         - const: mclk
>> +      - const: fix
> 
> and that's not an ABI break because?
This is "fixed" clock.
I will modify "fix" to "fixed",in next version.
> 
> Best regards,
> Krzysztof
> 

