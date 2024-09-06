Return-Path: <linux-kernel+bounces-318434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4B596EDD0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65E82872F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9998315749A;
	Fri,  6 Sep 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="FlKIdxUh"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF5157476;
	Fri,  6 Sep 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611103; cv=fail; b=h0K+mVoSMdL5pRJHQYegm/NIk2q3lAiabKMLqM4qk6KCWyv9JpB/IVXIrXnro7Mmlb+ufDJMbjwolf24CAhMvdWsuudLdPWuJWC6sIreDKWL8IuFmIZQHwfb+3pxsrwZEeVYq13xJLDR4iYfLH80RvROIO1n/m6IHds+hDUq8kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611103; c=relaxed/simple;
	bh=Iz9ZjSXAtQ87H65TXbY5YqFch2+8bBCRW+BrfAvk0HY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aY1JsQqHYwsejKwzIYg9JNUfFh5EnCM3ojz6zjBFlmLSYWa6Xf4wzCniANc/VcoLSG5OyJlZavdzsX59V/AzQwKYR0gBUqlCs2VTms/IiENDdWw+if0h++06zxlj75ggM8QKY8abGeVapyYYeBR0Qm462aotymqgdrjzHs1Llc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=FlKIdxUh; arc=fail smtp.client-ip=40.107.255.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPA/+SpST0nLD9khyMTbNkjzUlPntWjt4c/3rUftVhogRK/M3ESZ9gY4fy/A9YHDnBzpAU6tiVyenDjgmhk8np4YLnHDtRFPA5mtK8ptinGnKtbR6RgZcdTHUIRXM8R+NkdnPVN3hXZeG6H9j199dfbCZZLqkJDu9orZCka94mcXLB3Wa3O+aQa5wxzSmBbLoWRaiXJlqs0a1DWDIyWqfer2T+Ue9Qxiw7psA/SQGr1tgghG4Lk4Cg8Dfhb9PZ6ITe8mN+4arNPsM1mTEPoOQPLmKBGaNtPMQCObBDUuD5sfEPI5PhCZcNMgUMr+Zq43ak1iLkEOFvvPFcxe/GPpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9KDTtncxMAN8/LOeVVGp9boXs/ea3jrl051OSrbifM=;
 b=EPgDZlcaNDwshpleKMwoH9/SISZxjuFfqWz/uSneTJ/OBoATkOsGLL2sWdilUDr+VUw6nyvMlgVbDmg9HwQFkGaW85nBa1TehKoYQunERDLS3ht3lXa9FzCH2b5Ib0Z3yvc8RIGmN3pt6ypSBaNhkpPq9jnlIuHkeRWURzdq6LB5cwqWvAeDojudQjb2uSPnUUHfII2cFBJlTbRzbd0Si2Q1SyUzwz9Bk/cni//epGAVC/UZoMb3xEeac7p5uSBKWUUbpGFhW0478Xi4RZxEFMxSBouf5t8I3HdNFjEy/uw8V7JQ+rUz44HmoB3R3aBDdV/VqZI7ZP0DJHkbp4MbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9KDTtncxMAN8/LOeVVGp9boXs/ea3jrl051OSrbifM=;
 b=FlKIdxUhoXhR6grVAgqv7/pAzq/kB7OrrZwdlsOsmntCaW5loElpEad7bcudXuy9yRIGJPr0+Ezpazd+KOOorFb0nqaIIFCbMwDdc5zNZBpyWziEGK3Z/0vmwgnvZFp/nifvBhm4v7urG7SfRNrm0RNLQEyI9ITxk/isdFYK3rwTB+TOeyhuxGXHuEtPPOAD9y5XpPFJRq/U9yCLaNGd+5RTQLsv/PakEIEEoilqhxtwPxFss/frVZlNTd2TuM1teRXjp4xs1/Ihe43ISSSuvTvT5ZawoU+E70vVthBxg/SP1nPBAs3gWjqdpQ4dOYDV/eXtZBXll8O03ngm7WuG8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by JH0PR03MB8023.apcprd03.prod.outlook.com (2603:1096:990:36::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 08:24:58 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 08:24:58 +0000
Message-ID: <9ef42da8-ac90-43de-8630-04cc8dc50783@amlogic.com>
Date: Fri, 6 Sep 2024 16:24:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk: meson: Support PLL with fixed fractional
 denominators
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
 <20240906-fix_clk-v1-1-2977ef0d72e7@amlogic.com>
 <1j34mds2ak.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1j34mds2ak.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|JH0PR03MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c704cb-355b-4a12-2967-08dcce4d6516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWhvMW0xMXZ6QzZOYW13YmVlUDR3UDcyV0ZEVWtXMjJ4VjlxWVgvbnRveVN4?=
 =?utf-8?B?ZUhYaVN2ckNCaTQwTkxOb1F5aWdURndpNWhUMlNtMUdYdm5adHAzSjJWbTRy?=
 =?utf-8?B?RGh5enc1Z0YwQ3lSZkVZeUVqbitBRTVGZDVUZU5uYXJZbnB4QVBTQmVQKy9m?=
 =?utf-8?B?ZzJQZWMwbk9UM0dyWTVBWEhPS1duUDUxY2lUcXVPbzgzVVFnTytyQ1RUdUk5?=
 =?utf-8?B?b2xnaDNQMXlLK3VyT1RCWWt2UkdrRFo1ZWJUdUlud3Iyd1U2YW9rR1NIV3JL?=
 =?utf-8?B?cmpiL0FTVDdDMkwrbm8wVFFUdVFGclZ1Z2ZaLzNmTWZDZ2dISXIrRmtlZzdn?=
 =?utf-8?B?YzIrdmc5UU9NazA4NVZkOFJCZXd6NXVlVDJvZnZEa3FtNmgxQ3ExZm1xSUwx?=
 =?utf-8?B?TlVNa2RvenVzRERFU00ySTB5b2wvK1Q5ZWx4Z3lrdUZRVGVud0Nnb1VyajNv?=
 =?utf-8?B?bmVsMFpRRkdsVnJpWjFPdm9YdFpXY3RXSjNGYmlEVXIzb1lZMCtQalRUOGVV?=
 =?utf-8?B?SERJMENFRUNUYkdialRZYXlqRFE3M1d2emVpVTVXdEM4K2NQNmNyNFpNT0gy?=
 =?utf-8?B?Q0x1RUQ2QVdrYXpuc2VranV6aGMzM3ZwSHVlY09hSzRLTWFQUlFmdXhQbmV3?=
 =?utf-8?B?NHVJZDdqVWxiTlpnSzB5MVNvVGEzNVhlcjNnOG1Jekx0KzNGcXJDQWtJNmlB?=
 =?utf-8?B?TVcxLzFLdm5CVy9mR0E1bGZvVWhsOXBVbElsZHNrZnVUTFE5RC9XU3ZDSkI0?=
 =?utf-8?B?dkxkUENuUFVuTjZ4UHlKajhJc1hmYTdqcDhYb2pKSitZVGtTYUhtMEFndkl4?=
 =?utf-8?B?MVJMWFBFTi9mUVVrTU1oZzVucE53dTEwR0M3NUtZYUkzQ2phT1RacUJNNGJy?=
 =?utf-8?B?RHUzaER6WUtYOWhmeDE5T2hla2JJREV1Yk5uMVp5RXFZczc3dnZpNi84ZjJK?=
 =?utf-8?B?anBmVnBVc1BTODJERFZMbHQzWkpURVI5czdOSWwxdlEzVDk5OUhXY2lzdGdD?=
 =?utf-8?B?cGlESnlMa0NXL2R5NmMxTlQ1eEFPQlgyUU9qb0ZmSXVGdTljcTQrTnRGY3F3?=
 =?utf-8?B?WkRuc2hLUjFKWTBaMXBtR2JobDgyckxMWnFoa1NPdWhKditoWVVEVUpCOW1n?=
 =?utf-8?B?eUNjVDI0SXY0cTVJYmhaelFuYStCWDhnWDZtQzlzT1hVVFRrL0ordXViT3Ux?=
 =?utf-8?B?Mjd6eVdOU1NZMU9NWGtoQ25CK3FwTzlVSlF0Z1hteUJ3K0ljQ1BMeUVNS09k?=
 =?utf-8?B?Wm4vWDZpSzBUNGYwWkxtVEp6bVJTMkhoWXJob1FjQTN3bWNoeGNiMlZPQ2Qr?=
 =?utf-8?B?Z3RSL05GVTQvYkVubVZIMVI0bXNjRUdpTDhNdmRBT0hsYXZmbGNZSXFUQlA4?=
 =?utf-8?B?dHYxYlFXaXlNcGZkMTlxWERIbTcyUTY5ZTkyL0JvLzVvVWZyNnVxeE9SZXAr?=
 =?utf-8?B?SG1seWswUlFqZElENGZSeHFySWpVQ0d3ZG9qR1A2aG1Ia0dlNlA0ZnNUT0dL?=
 =?utf-8?B?UE5yemx2NG5FYzB6TXFZeG5LN2QvNWJmc2xkblNMU0svTFhxWE0rRWEzck1o?=
 =?utf-8?B?MG9wN2R0WHVSVWIvL0RuR2IvWkNkMGR3T29Ma0xsWG9zcE5IVEVLRDl0QldS?=
 =?utf-8?B?UmxFOUxKRmZjRWJQdFoxRGozSFhuMmU3TFF4cDZhT0VDYkprQzhUTjVzSUxE?=
 =?utf-8?B?VVdJUDhqRmNwNDFaQmtPcWJuVWQyV3c2b1BYWlNBeVdZWlBtd3JPK2E1blM4?=
 =?utf-8?B?K0dZWGJ5WUdJWjBnc3BYVW0yVHhZajE0d0FzenJJdmFXS1Ivb0FzTkYzcmRy?=
 =?utf-8?B?b0VQdzZOS1lUeXc0QXM0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3lEVmFmbmZ0UG9GYldHbmdRY21uUnowdjIzTDlmbmhKNlE4VldLdGR0SVRP?=
 =?utf-8?B?cmxDMEVmZ2pmSDdOVjRzVDdpb3paOFdETmFXS0JLbDFGVGQyeDFFSlp2bktH?=
 =?utf-8?B?VDFmZFQ2ZkNwU2l0T3pJbVo2RWlPcTRwVExUQkVub1JKRnVCVTBpY1FnTU5h?=
 =?utf-8?B?aDNLdzc2L3VHZnNLTEJ5V3Z3MGFLQnpiUnJ3dFFDTGwydG5vM0dMVHVSSlVF?=
 =?utf-8?B?QlFWRkppZ1hhNExsVGU3R29XaEdDZDlvTnViTVY4QWVGSHJzRURvZ2tMa1VH?=
 =?utf-8?B?eHpVbzRvZjlHY2JsbTMzMmxtVFFETVA2UDRVQVN2dVdTZXBLVFdrWHBFMmdD?=
 =?utf-8?B?VnR4ZEFJTm90UmkxM3BEaXVrNXl3TGN1ck53eVh1Y2RzempRWjdNeDBFaWdm?=
 =?utf-8?B?Vkx3dFdvRWFPaDNMb09qWlEzWDg5alhraXhZazg0bnJwZHpBaUxwaDRQSGpE?=
 =?utf-8?B?aVA1RHh1amY4Um1BVkdhenEzNll2WWdGOTU1QTVKS1VhZEw2MS9janB1alVY?=
 =?utf-8?B?cWlkUVN4dWNobWMxZDAxYitXd0U5NWFoQnpSaXE3eDFKd0VZZmszeUNKcWc0?=
 =?utf-8?B?THE0eFJ0djExRUNQUThYWE1zeXpFTTVnMlU3SXJvU0FXTW5GN1NGYlAxQXJ2?=
 =?utf-8?B?dldQTzJrWmo2Zzd2V0xMNmE0eitIMi91UGkxRmZlaS9XT1VjcXpNQjE1V3Qy?=
 =?utf-8?B?bkxZemI1WG0zOVo0MzBUUzJOb0s5ZkpPUTduZUNYNHBvazNDQTVyeEVRMGsy?=
 =?utf-8?B?WTFlT1dmZk9yTmpLdHp2TG9kSUVDYXNMRGV2YXYva2tFQld6K09MUGxJc0ty?=
 =?utf-8?B?aWI3VnluK1JuNGMzbjEzbDRTcjJacjBUWEJRSTVHU3NJWHN5ZzMra0k4QVNC?=
 =?utf-8?B?dzV5cUttYlJoWVJyUjlsV2lrYkdvbnE1dlJHUW5FRGlpSFNjZk9vN3ZrMmtv?=
 =?utf-8?B?bUpaNFBaa0w4RlJuQndMV2ltM1FncDJXZE5FTERKcXowTE81VGh2WUlWWFNn?=
 =?utf-8?B?cnMwZExObUtlZnp1YXp5dVhLZ0l3TU9uazJoSit1MnMvZnJvUUx5dEVuMzJ4?=
 =?utf-8?B?ejRPQ1dia2NiWXhudWd3TVJTY2xJVFI1UHNhVWljTUJBWXlhbVREanRneFlr?=
 =?utf-8?B?VlI3eUdEUnI3RUpmUFhWbGIzK2VzdWNKdzVIZnIxQVRZeWJUalMzZ0tyVFZo?=
 =?utf-8?B?MVNxbWdKcVMzcEpzcEt1VUpTTlQ3M3dsR2hQZ3U0RWl6L3ZmeVBMbTZTUUxD?=
 =?utf-8?B?dDZMdW45R3FrZnNDMytxUTVvejNjbHByeEZEZEQ5UlFDZnhydXJVaE51OXl4?=
 =?utf-8?B?dE0rdU9TdkRnZXBjV0NYaUVLa3V2eHczMnBBa0RpVkUvVzhGWEIxSW5WRlE2?=
 =?utf-8?B?ZDczc2NSa1dkcVovT0UzMXUwMjArZzJZYlVZams5SFpCdEtld2VFUDFCbUlH?=
 =?utf-8?B?ZWNTZnZYTDdWcC9zSHdqaXczK2VEdDNTWVZkMVhDRkVnN0VCUCtxSU92RWR2?=
 =?utf-8?B?ZjlZMVhjTXlyYVpkanBBWGp5RWtUYnZLUjFQLytVb09GV21ZeFhqQmRDek5m?=
 =?utf-8?B?enlLMytnazdQdGJsTlEzeXUzQUdxS2FnY3BmazRwZTdXMzA5T2xadTRNSHNl?=
 =?utf-8?B?YnluaStZRmVnMyt5Q3hYT3RNMnNId0RpUzNxVmN0am41VnlRNVU4eStYcXMv?=
 =?utf-8?B?SHpNTXFyL1dLU0dhbzIrV3E0bmhCTXdmUUlkb284Q1ZBWC9pY090dDdVTll2?=
 =?utf-8?B?RldVQkt1UkdFUlhITVhQL2pkbGxaeEQxY3M3bXBNTXlVWXFNNzlnTlpzbGhT?=
 =?utf-8?B?SUJBOUFVMlRmUTcrMmN5eVI1WTRZc28xVkg1VnZMdGFmWm85UnZQWFBrUjFx?=
 =?utf-8?B?VFBSZVFpMjZBenBjcVhjS2JKaFd5RkN2RlhDKzcwZ2FtY21QVjVOcVNLalp5?=
 =?utf-8?B?RU5jUS9tNzhRSmRGRUJqODFFNUFoMUs4QXprUWk4MXQrZVpUZXlkYjVTcjVQ?=
 =?utf-8?B?NlVoUGl2SHVPbDZLUGlkSnNSUS96UmQydjBoc1pxL0Z5NlgrL25QamhQMVkv?=
 =?utf-8?B?YmlMWlM0V3l4NkE4ZXB3SGlSVmpVa3JTNy91eGZkMWNiUFJUejMxSGlSdTJm?=
 =?utf-8?Q?2MtyvFTHMO5ib47NRI2x/6FuB?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c704cb-355b-4a12-2967-08dcce4d6516
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 08:24:58.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y38ZgKzI2uc0cQ0i3FM+fVNd7dvUFbvPpf4vnEabHhwp8PcHw1ex1ePEfyLvhP+LlFr4c/Q7uHkCO1yweTGFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8023


On 2024/9/6 14:51, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Fri 06 Sep 2024 at 13:52, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> Some PLLs with fractional multipliers have fractional denominators that
>> are fixed to "100000" instead of the previous "(1 << pll->frac.width)".
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/meson/clk-pll.c | 22 +++++++++++++++++++---
>>   drivers/clk/meson/clk-pll.h |  1 +
>>   2 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> index bc570a2ff3a3..f0009c174564 100644
>> --- a/drivers/clk/meson/clk-pll.c
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -36,6 +36,12 @@
>>   #include "clk-regmap.h"
>>   #include "clk-pll.h"
>>
>> +/*
>> + * Some PLLs with fractional multipliers have fractional denominators that
>> + * are fixed to "100000" instead of the previous "(1 << pll->frac.width)".
>> + */
>> +#define FIXED_FRAC_MAX                       100000
> When the next arbitrary limit comes around, this will get very ugly.
> Instead, please add frac_max to the pll parameter


I also had this consideration before, and after confirmation, the
hifi_pll of the subsequent chip design will continue to be this value,
and the hifi_pll of the chip in recent years is also this value. So
let's define it here.

In the next version I replaced it with a member inside the structure
member of meson_clk_pll_data.


>
>> +
>>   static inline struct meson_clk_pll_data *
>>   meson_clk_pll_data(struct clk_regmap *clk)
>>   {
>> @@ -57,12 +63,17 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
>>                                          struct meson_clk_pll_data *pll)
>>   {
>>        u64 rate = (u64)parent_rate * m;
>> +     unsigned int frac_max;
>>
>>        if (frac && MESON_PARM_APPLICABLE(&pll->frac)) {
>>                u64 frac_rate = (u64)parent_rate * frac;
>>
>> -             rate += DIV_ROUND_UP_ULL(frac_rate,
>> -                                      (1 << pll->frac.width));
>> +             if (pll->flags & CLK_MESON_PLL_FIXED_FRAC_MAX)
>> +                     frac_max = FIXED_FRAC_MAX;
>> +             else
>> +                     frac_max = (1 << pll->frac.width);
>> +
>> +             rate += DIV_ROUND_UP_ULL(frac_rate, frac_max);
>>        }
>>
>>        return DIV_ROUND_UP_ULL(rate, n);
>> @@ -100,13 +111,18 @@ static unsigned int __pll_params_with_frac(unsigned long rate,
>>                                           unsigned int n,
>>                                           struct meson_clk_pll_data *pll)
>>   {
>> -     unsigned int frac_max = (1 << pll->frac.width);
>> +     unsigned int frac_max;
>>        u64 val = (u64)rate * n;
>>
>>        /* Bail out if we are already over the requested rate */
>>        if (rate < parent_rate * m / n)
>>                return 0;
>>
>> +     if (pll->flags & CLK_MESON_PLL_FIXED_FRAC_MAX)
> Certainly don't need a flag for that. Use a parameter and default to (1
> << pll->frac.width) if unset.
Okay
>
>> +             frac_max = FIXED_FRAC_MAX;
>> +     else
>> +             frac_max = (1 << pll->frac.width);
>> +
>>        if (pll->flags & CLK_MESON_PLL_ROUND_CLOSEST)
>>                val = DIV_ROUND_CLOSEST_ULL(val * frac_max, parent_rate);
>>        else
>> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
>> index 7b6b87274073..e996d3727eb1 100644
>> --- a/drivers/clk/meson/clk-pll.h
>> +++ b/drivers/clk/meson/clk-pll.h
>> @@ -29,6 +29,7 @@ struct pll_mult_range {
>>
>>   #define CLK_MESON_PLL_ROUND_CLOSEST  BIT(0)
>>   #define CLK_MESON_PLL_NOINIT_ENABLED BIT(1)
>> +#define CLK_MESON_PLL_FIXED_FRAC_MAX BIT(2)
> Remove this.
>
>>   struct meson_clk_pll_data {
>>        struct parm en;
> --
> Jerome

