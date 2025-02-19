Return-Path: <linux-kernel+bounces-521974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D23EA3C480
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269C83B5FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8FA1FDE24;
	Wed, 19 Feb 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="jvoY4w7y"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE231FDE09
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981230; cv=fail; b=FukBn1wuIRM0h3aKVlzNefqIZqnWFonMC+rtV2TaepXMEcQg2bWhqFR6/y4LyxjjH4sI/GmN9DydzeBoi14yimKTXX0DrHqPbLMfWegj8jYete5qLEF977/tf8nHNFSbRUTiq/27uzu9b8NhzVfssPqmKItTJ3x+9W2VgkiWBCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981230; c=relaxed/simple;
	bh=lLDSw7GN29H9tn6AwHwQ4+muqUAtOLcgTtXi6yKan5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zsy13wqmaLejtQ2fbSZtxvtRD1U+WuWdXrESdRmrfEZZyfdWnyZajH6kz9+m+aHbxcq3t7OwQwwUi5Zr1/QxYscBsdBfReZ2FRBFJ7RwNEz8Nt6TFi7mBPmlexJepjNWAiWA/4hEpMVlP8IcDUj3OBe/b5dCwbPpKjtffRi+TWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=jvoY4w7y; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqt3bXF3+yKemOWVtUeQzudYi0eKBgGi/xI8NBQTPHZfcxbAVcQFiSo0J31VUjmkgAu2XpSNUoqfcSKy4v14x5Nmnb16W2NA1pUrPb0N8YfXoz3wndAQtvcONnfZAXfY88/E4puSY7rU/l4b0nqjhB7jnGrkBV1TOTBT8jsPPMYPgQprvWFS2CjI5fMlkvB+J786lECkxXT97UB7wqFXJQAZrmEPt/OrOYEAicO3Huv5755syM97pWLS8wU1ifRNykkXnO9rRwvnDJ6lA8IEV54DoGi00XkhLBl4B6BKZlytteSNEXSVyLs0bPX5thMg/ARdsICQvynAsVRGWk/WJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGI4FT1K/Zrdr3UeF4yAGP3ydqXH95UEPl4FfyiRg+A=;
 b=oNU4gypWiBUH9cD+Fng0OE+e373khH6qrzpStMKtbtDl2o8qj+DPT4e6hHIAfsu8AwzwnijtcWHR55ls5bbvV/wuF9TAwQ1WPtmCsHQS0Zl/LJJwgcfKmR1HXTaN3ONZ4T4s5sBJTIwxSGapvNnt4WPh2V+WAYond3jzI/gfFIvqCPFCFeFLO9ZfMUkCQ1vM1oNThfMCxJNe/54BRJU/Rkw4l4SzeFd43nTO8KyNuK70/pHtVO/jZ/iQ9vjcCzJxN3x9nuDDRiZbxWNGFmEuvAmZaJaohyWmCYDZvHGEuSmD6bow/GXgiyZHc2Ls8WXs1BuhMMTNbMnUZSClbDtdGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGI4FT1K/Zrdr3UeF4yAGP3ydqXH95UEPl4FfyiRg+A=;
 b=jvoY4w7yXirJ/vf6PW5OCdCKX/KWdjlE6ZNa20yzSm57fWg7RU8CFhW0t5uitDdKRFg2+q+YwjxLQfE0M5gWceL86junDBZw+7N7H4hbFRDGqNfKYag+qxwP6EwdAhhscMBgVUz9TAtSVVeWzWtsuuvizTkc11jImwT85EI8lvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7075.eurprd04.prod.outlook.com (2603:10a6:208:19e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 16:07:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Wed, 19 Feb 2025
 16:07:05 +0000
Message-ID: <f4ef19f1-d1e6-4f06-a81d-c7e7e10605e6@cherry.de>
Date: Wed, 19 Feb 2025 17:07:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: remove supports-cqe from rk3588
 tiger
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, lukasz.czechowski@thaumatec.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250219093303.2320517-1-heiko@sntech.de>
 <20250219093303.2320517-2-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250219093303.2320517-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 65057695-6964-4ece-2168-08dd50ff7419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEcyclZsaDliUCsycVFaOW5OaHVWcWRRci83UHl4dWd1NUpsU3VzanJ4cHdw?=
 =?utf-8?B?WmJrWXNiTnVSc2RLNnZoMytSOE5VaXh3WG1VQWxHYWNWZVRYOTFWdXliNUxy?=
 =?utf-8?B?bmZOVVNIZ1RwUjlkR2RadzNmcGlDdGZoa0UwK3FPQXpVRlZmLzBCbXNVcUEv?=
 =?utf-8?B?dlN1a1k1clN0QWpYb2I2dXJOdkR1Y2lHVGtlaWw1Yjk5SFJteDBaSVRNemhX?=
 =?utf-8?B?TE84b290c3JuU2NiUDhDWXpyM2Q3c1lTY3JvNGNFTXJIN2xZc3h2dEc5eW9F?=
 =?utf-8?B?Z2Rkd2lPVlV6N0hMeFduMmF0dFN1ZDlSV3ZXenhRY0xoMGw5TmVQMCs2bDN4?=
 =?utf-8?B?ZmRoSWwrU3BaRWRlWmNLdGkxcGh1TWxIMGppd1BNbStmTWphQ0hsTjhnMU93?=
 =?utf-8?B?NHJ1YytHM0dXRnNWT1U4bnFDUFBnYk9tTklZeXRxNEVqQzRNRkhZNFozR0tJ?=
 =?utf-8?B?a0d5dXh4UW9nL2FaaU02RVYxWmRnaUdZYk5wTzBoSXJnRVNnWTBFTjNCMmxa?=
 =?utf-8?B?QmJnUnZ6cjR6T2t5d3hyWGVJVmpSemQrUEdwaXZZT0pNdnM2MWw3R21hU3pO?=
 =?utf-8?B?a21TaXhZNU5wV3FnemVYczlHc2RhRnlnemF4MFdBUVBrMHBWbTRMd1Z3NENU?=
 =?utf-8?B?UE5meENSbW5aVnd2SUJydGxkV21xQXF5QVdwUG9kTHB0QVhXbWpHOE0yMk1u?=
 =?utf-8?B?T2VnZ2xnN0dxK0crbUx3ZHJTeU1BdDJQT0dOWEtqT00xdkFmeFBTaXYwbjVr?=
 =?utf-8?B?R0lBWmlGbzZWdjhVWWlhRVF4Mm92QlNIRHhRNGdEUTlqTHZCdnV0VFRhNUM1?=
 =?utf-8?B?dkd1b0ZYQUYwMlZNSHVPdHZGWWQ2VTU4NUZFZjMrUlAxN2NWVXFOL1BYSldS?=
 =?utf-8?B?V0dwN0RraDVublpvcjhxWUpFbGl3SU1vd3dCSzB2REQzSkw3VCtOMm5jMUI2?=
 =?utf-8?B?TGRMd3VRY3B3eWdtc1FXazFHdEl2RkFoSmphRHpxYmZYb0kwcFZHVmowK2s2?=
 =?utf-8?B?RlBxak1pVS9EVDBqeXVJTDc1ZFBPeHljb3VOTERUK1VOaUcxZW5aMEpsYnFP?=
 =?utf-8?B?MEhPNEFFQldHdW5KZzRvTGduK3FvY2NWOW0zSnFkQnh3L0VGVTZ6bTV1cjZF?=
 =?utf-8?B?RFRJRGlNTS96ZmpRakh5bU1LbHBHSnR5V3czb1FMcDM5OENBU1FBV2RwSWY3?=
 =?utf-8?B?eTdVM3B4bXR1a0ZNVWhuMGEveXo1YVJwY1dBYUZvZHNsb3ptK1RzaklmQngw?=
 =?utf-8?B?WGw2WVdMcGlhVkw2OTIrUGV0VFJQVnM3UzU0b1pLN1FtT2JaMWMxTWt5MGFH?=
 =?utf-8?B?UUROS1FxVjByRGJSU1VzS1RDczRvY3lZWmNOK0JuN3ZlOElKdWNiRkZXVlBQ?=
 =?utf-8?B?aVZON2Q4QkxScWFXWFR3eitoV2F4ek4rcEJmNktVazFOeElsNWMxWW16dnVZ?=
 =?utf-8?B?S1pteU9mTTQ4ZjNlWkF0QldLMWxqK213T1R2UjNVa0duMDV6b0M1cEpoN0VJ?=
 =?utf-8?B?cE1JLzllSStaL1N3cWhqV2h2d3FjbFJwQWRHQkRsYlhWWm9abDgrUG0yOHRu?=
 =?utf-8?B?ZitOM3I2MmUxbzI3VGdVbTlRVDFBTWx3TUFQc0NDOE9jQkljYzBJb0ZWR3U0?=
 =?utf-8?B?S2hQamN4MVJMNE5KK2Z4RFVsS29TMEpYTHMrRVdFajArb2g4a0FEMmNNd1RX?=
 =?utf-8?B?UUNTeExOaEFxaUNjbXc1NkR2dllSVDJ3NnRhTGxCblJqalVPRUY3Y1RXMFpp?=
 =?utf-8?B?a0xqQXhEcC84NThmbk13dWUvNllldlFIdlhBKzFJTTJwc2pENXBuYzk3Y0J4?=
 =?utf-8?B?UEFXc0l0aDhpak1JZEZxeDlMVjBNU2hQSWw1MHo4NHF1UFVtNnNNZHNSMWU0?=
 =?utf-8?Q?tPyNBqz2xOsN/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0dOMUFlSVcrMGlIL0xZWUJwa2o1ZnRTcDQ5SHA1N3gwKzZMUEFYK0x4VDl4?=
 =?utf-8?B?aWlVZDlmKzR3WWlyYk0rL1EvMUhKL2RCbnRzYnpoVVArYzRoTmpoSXR4NThk?=
 =?utf-8?B?NGU4ZUY4cGZkSkJlUFY0VFZuSWhXOXBCYWl4ZmNpYThwMS9zay9zckorbGh4?=
 =?utf-8?B?ZzE5c0hpZHEwMjhnL00wSG1xU1VVUzN2SG5OV0dZR3BqVVBBSVNjYVYwZFlU?=
 =?utf-8?B?aUhCTGpmclgrZWpYL3NkSitZSGR2ZkVKUUs1aktzUVg4b2RZTHovVm53cndR?=
 =?utf-8?B?dU10MnhzT29udnM1anQ1cTc3dGhwbkxrQ2J2T2QzUG1BQ0JZZ2w3SEE3S1Vz?=
 =?utf-8?B?c2tJOXZqRmZUTnFqa3JXS25oL2xpaWJITDUzMnNpYWI4amNSSHF5c1dodDk1?=
 =?utf-8?B?UEJEdXhUMmhubUFaSGI1SkJ3QmRXcTZ2cUxOSGRmMHkwUHRNdTNjc0lLTEd3?=
 =?utf-8?B?ak5iUkJrcHJla0lWUHdlbzVNSTVDRllBMGtFQ3V2c1h4TmRjbDlLdGoyMnNZ?=
 =?utf-8?B?eFF1QXh3L0kxQ00zWGJLTFA5N3F3SFZuSnhraTBZTHJweUFXL01CdzhFRlVF?=
 =?utf-8?B?VFJyQW92eWw3WG4xL3dmc1U4L29WMzFrS3FnTVI1SEtLSGI3OUcxcVFhNkQ5?=
 =?utf-8?B?emNLNGVSa25JMjlEeTlHZUgzcStyRlQxMWVobDFidU1FWjk5cUVJbGRkaTEv?=
 =?utf-8?B?cUpWRExDaHM5NTBGcWtTcXQ2ZjhGVCs0MFk0RlorU0dHWFBweml5ZjV5bCtz?=
 =?utf-8?B?MkorbE1VOXUycGh6NWlha2owbXQ2TEd3cUJTWjRlMXVUU2dTRXJtTGVucVgz?=
 =?utf-8?B?Nld0ei9CSGwzcEVJckU2Y3dsekx5blVOSm9FVU1wR0N6NjZYbFY1YUFGa2I1?=
 =?utf-8?B?VTFQSnhaRWYwQkVGdS9DN20zN2NIRi9qOVBOMkphdXNwZWNvOFVrNEhPZnNo?=
 =?utf-8?B?eHZ0TGQxQ1orTHZOci8zdVdvZ01qdXkyL1N0TUJ1cnp6ckxwRm5YZ1l3RDNU?=
 =?utf-8?B?Wi9wdnVWU1FiWlJ4UmRDVVprOTZsRUY5NDNBeHd6S0ZLYlVkRWk4TnFoVjFs?=
 =?utf-8?B?ZVRuVHdjalM1VWdVU3J2anpCUlU4dlJINHErRVZuU3RTdHhMMzNQdEhXa3Bw?=
 =?utf-8?B?a0dySFVPWmVnRzNlSmFENVErNm9lU3R2TFhwOEdQRFltL1JVRythOVRHMTBX?=
 =?utf-8?B?NlJtc1pJUE5XNm1JOUVaQ3hpczZVek1GZkNKYkhiNjd2UzFpK09HZ1lRZWVS?=
 =?utf-8?B?WnVUSGIrL0FMb1F3dTZVaUprSTRISTE4ZnMvbDBaWi9lQ05qelZScWozUXFw?=
 =?utf-8?B?S2t1eUJZSENvNmU2MFZCU0psOHpjOFdYTVFLNFNiL0w1aWNWQVNBL3NwYTNp?=
 =?utf-8?B?aXRvNkN5RUx4TUY1dW5nZS9CeFNLUWh1cXFkT3RHRVpQWUZtb0RGdmFGQ1J4?=
 =?utf-8?B?VGtHRjJRblNubEtKQkw3Mi83blEySzNtSUtDY2EzdEl1R1N6eC9GUTE1WjJz?=
 =?utf-8?B?cHhZeXFxK1NldkdMdS9XSy8wanFXZ3ArSUo0QTF2VmpTWjBSVFV5dUdxMGx5?=
 =?utf-8?B?eHdGWERHVE4vNUNjSHo4amI4SHN1YlZIWWlxU1MxUDdZbGlIYUdndU44YmJ4?=
 =?utf-8?B?emVxdXB6eXJzOThaSHpwOFFzWmpYeFFuRHVLbTJzWDZMOGFTS1VrbUlaYzhs?=
 =?utf-8?B?TXhtM1BzNWJEK08zdmhWN0hONGgzbVBaQmNiSFg5RVJxeGtHMEwySVE3cVpD?=
 =?utf-8?B?RklIYklhUXZUaC9hWWpLd0J2QUl5ZGdhdnFZcW5PRzBlZEo5VWdKV3A3RVhE?=
 =?utf-8?B?UEpxamk4WlJ6V0hUTlg2Mm8yZHdrKzM5Yi9iR2V1TExpM3YyN3FTMW9xUGh4?=
 =?utf-8?B?YUNwSExEdlk1dVRlcjZLOUF0ZWJ1K28vU2k5UVRMckxOeGx0Smd2UVZUaktp?=
 =?utf-8?B?L2ZpcCtRWndwT1BYb1piQzYyQkdnV2c5ajl3bmpScTMxSWl6cC9SR1FPYTM1?=
 =?utf-8?B?RHVybUJsU29GdW9Wa1dTbEMzNkViNE1lRjh0ZExJcHNqSlR5VTZHdVN2a2FT?=
 =?utf-8?B?YS9nc1JLODdrN2F5UUlPbUlXQlFXOFdKVGxrWjdDRjBNTmVUTzliazdvTDFj?=
 =?utf-8?B?dkJ6WTVwWWpsZXZPcXZmK1dwK2dUME43ZFRuelQ3anZXZWRZczA3Y3M3Wmlu?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65057695-6964-4ece-2168-08dd50ff7419
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:07:05.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kX5t1q5sSzTOX0CO7Yihiw6Rsjca8STXvJJuwlS0RkQVX6efWYB0GeBNXJpLFK/qSe6d0jnlvBBNNb3RunqTSBMG0Lfyq3fMVfh9P9LqYac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7075

Hi Heiko,

On 2/19/25 10:33 AM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The sdhci controller supports cqe it seems and necessary code also is in
> place - in theory.
> 
> At this point Jaguar and Tiger are the only boards enabling cqe support
> on the rk3588 and we are seeing reliability issues under load.
> 
> This can be caused by either a controller-, hw- or driver-issue and
> definitly needs more investigation to work properly it seems.
> 
> So disable cqe support on Tiger for now.
> 
> Fixes: 6173ef24b35b ("arm64: dts: rockchip: add RK3588-Q7 (Tiger) SoM")
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

