Return-Path: <linux-kernel+bounces-323039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9469736DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9541F268F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9800219066E;
	Tue, 10 Sep 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OaVIx6w7"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2048.outbound.protection.outlook.com [40.92.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31103190074;
	Tue, 10 Sep 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970162; cv=fail; b=OonwA/jaTQKC0YVhJKMcLeC2D4Ja8XPUS1UDJII9B5waaZIv0aPe/Ni8BWWtv6CqfxQUfFH7Spib2ddcE9SXAHuLfI0wRkcZaDAcpsoYPrKGVex7ocVgJOJyrXMxcBv1k9GxD28IqlldoCGBIFxwu5Ajgd5MdB1tgkmyCed0NT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970162; c=relaxed/simple;
	bh=oS2YIBSV/VoVAidv1+7teC+Uz3XB1zvHzyYWOFiJDVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXWSIsDdiKeufM+tiO340KaeD4lDyAQdr0LsrP6uSDhLhEKw7fdD0CQJl+BXge7jlKAfPMtCWihwlvZHzhgQMXDvNJci+QV0rd+azDecR5hAje6ayHBBM56f/QqeouEiWoSMcvp9YjMDA0L2OGCU+mnTIW2WBCVwJF7+vsR0SWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OaVIx6w7; arc=fail smtp.client-ip=40.92.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGTjBZkZO0XHkXMeaNMdtpplMn1FRmqWPwWNz22/TL1/j24aBJKdBLl5gWT3BQiL1sJYZtvLkph/J87A1KlQYISyvYfIwZPl9hM55EfPEX0mpimLXqcFz+D0Ydk5rdIoxutSgL9E8A+7V1fHC4JOOGpuA4vHQIFnUwIbIY7yHaWGQu9nMzouBYAuG0lMCjvQXdUh+GuJBeUbvS64u2K/VByA2if+KM49fb/YyWSH2Dce4KoMGvW2H1LUnWP/L+LPvJMnbIpJYv/7Re1O2LCs7O5VdYLj2QN8RdXzwekp4fWu9Qweu0OzVo6g2zg1uVu9TrV+0jD2yqHBo/RKuyTwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kHgTK/9vX8CzIAkCyaso50L3XpXJ4RvID7MN19mSyM=;
 b=M3Tomfjen3UVQoI9sLV0kmoKedTFojOfGX4A2GHfAbO03rSTdWApP2DSlCivGk/iFLgEtZuP0CsZ6yQIjQZipg+xHrf7L78rl19UX2F9WWU1GZlNR8sAZGf6U8GPscnr5kDsMLeFoh6/DBoU9IHIq7kgmEz/Lm0zDeYJNEPTt0M/Fluquk2zFWRFqxqcwHYSk37N/JI985LQF/BKzVMwUMNcXs66ThOoVKYU3QjGIo0cXPw0uBW9l/x+UBv9d1pugHHBKxwMqCzj7sz6UUQk0F8bCsOJz+kmMUFK59u6GEgs8/ENorYwCKPOyNiFsan/MCZ0iGhTEOf6uacr5adtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kHgTK/9vX8CzIAkCyaso50L3XpXJ4RvID7MN19mSyM=;
 b=OaVIx6w7UiD0i+LL9Jnhn+FoY5n/0JwP/sq5DMqqPGI/cCAt6pAk0W1S1GrCEd3wkChnjGGLuIgkWgjZaijVdVlxMd0u4xt1t/PiP6rx2T0eaql/LMFj3TtAXXDELftBFiAQ1je/5WhT2dGS58uv6/ROG3TRDdcw1lhq4LuGc/S7C0I+v4Mi4+gKzrHB/t2P8yMtNCKRCuPDlkBcPyxiyx1Mbasi7MHq582mw0AOxLusuu7g3LHuJx0FbtYfWdEzMVaucMM4U3nfzhIsWwfHrkzSozrnsL7AAmcRonrXF4Vgx1Lx+TdpJrcSD6i6NrS6KO1/sXjCl3jI9I6tq5RGMQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA0PR20MB5658.namprd20.prod.outlook.com (2603:10b6:208:43c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 12:09:18 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 12:09:18 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] riscv: sophgo: Add pinctrl support for CV1800 series SoC
Date: Tue, 10 Sep 2024 20:08:02 +0800
Message-ID:
 <IA1PR20MB495301A1A08224486DD0239BBB9A2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB49538E389C866882FAF35B8CBB992@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538E389C866882FAF35B8CBB992@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [zUey2GpE5HzI2XN0YNUk+XFkAW/fmGzg8LX0yQyMHYE=]
X-ClientProxiedBy: TYCPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:2::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <172597007255.997162.8447593891786696370.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA0PR20MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2e7e44-c61c-4e26-3f88-08dcd1916582
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|19110799003|5072599009|6090799003|4302099013|3412199025|440099028|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	sAS5MEwuu7RtLcyxzsevG2a6ReEWb0Dvc4ovx+NKDsSxUrObaTi99YT4GgvqFcZOMg/AKdaUU/I7EEe9zbQRkEKwt4HTkQuAIPrcIQt3zxAbJ4sJbKKINA2BwtRExHzyS6NmeCpZvMCLxv9QnSF6Tfb8kcC4pps36pObUK2zu4Hx3zd9Fzlb13dwL1JDFNG5GVQW8/JxRwDAGbKRckJuf39t2Sdcw56ei3OkPRdjYEkd67WjAjXVGvGpvO8f8/1gn665drxA0/gX23ZC17Er18nXvYhf+jHFQBeI6UPkJOUiTmXsIDv/xauVoXHdnVKmhoATBDPEcCuMv+sDOsy6TMrNTexm4Xvldj4h5cMYVnd2SK/5yEiH/VFi+YIhLb46va/8vcK+P/Kw+ISwshPEgr/DVxMjyBLPAZJsm/sf+4nP5q2YFVmTewXPtuqTpXB0Zo9qkG5QInf+Xw5sgLrldRAv7e3owpypnZiVikowxrTMzwDEpnqfLQHjUtFOlhoCyo7hW7eL0N3hwSRjUWENhzSpXBwUHaghN54eSBtwXK7aK+aZ0l7ZSSHldZM9yrT4xgswJu6mfRLFCc6G8DYb74xWsY3oD3kI6pD1Ja2qzYm7CQxE8KnwPr2MyFPlNWnLmBm1bSnldUxXBfLkfmqlrcK4xSncK2tfCyyO7A1lVXfoNTwkawmZjobEx3QWo0DDOMNnuD7jzgjbMZ5yz5GuIqhMntP4QGuXZHIiH9lGPrz0wh8zGLFcPdu+ZZKE5JvALSOJTPu5N7f7LACZJcVftGS39NN1Mx45zU5G4Qre69jhmXwnh4qT3SuQUAMn4oaEUz/bMYcdRi8rqFJ0nk1IefZg474VPcZKw8PwZ9HF53lwC7zKf5SwzzkMAZvrHq+m
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2laTVl0MVI5TEVmRWNFK3VmVGJ4bFpMcXJtanhFRERCeXl3dXhYOEF2VHpP?=
 =?utf-8?B?OWVMY2JtVlQ1OXVBTVJ6SUVlNnJoREJXK0FENTZYV1dpV1puR3R0U0R4VU5R?=
 =?utf-8?B?cXRFMGI0SlhCYWZyYWk5Mkt4Rk9uYkJvT0N1S3ROZFNZL1JKblp6c25wdmlt?=
 =?utf-8?B?UEY1enNOZC9nZ0pMczZ3K3hicWJJbmZxZkR5Nkpjc1ZpZnpPaXF4L2pCL0FJ?=
 =?utf-8?B?S0VSM1hNUnFWQ3pyM25WbWVmcFZqM2NHVlRsNXJlc0k1TTJBSDA3c0cwd1Jk?=
 =?utf-8?B?YTNvSkFUZmVpQnhHdWlmVUM4dEdDbWxRTmsxRWh3ajY2V1R3a0NpNEhKRjhG?=
 =?utf-8?B?NmJXeVpUSTRpQ040ZWRXaURLYlhwcGFwWXgxYVpuZDBDUkhUSXlQM1ZCTGxy?=
 =?utf-8?B?cVZrQ3Y1bFlxdFRjcWtVSWprVEN5VTVZK3JDdllWVlErUWR4aDFrK0lDckhX?=
 =?utf-8?B?VVg5eXJGZEt4V0oyeU1LdzdYdFVaUzMySllwcGtzYURSNTI1bVJCOUQ1cEtv?=
 =?utf-8?B?dVF6Vk9hWGdLUE1pVjVtQ3BKREtwYThKVDdLYU1PRmpNcDh2WWtZazZRZ2s5?=
 =?utf-8?B?NVRnb3hxYkQyZWl2alIvVkF6L2I2NUpWTldnM3g2UjN2OUdKdzM2U1NWcWh4?=
 =?utf-8?B?OHRuZC8vblBDNXNMNlVsWmJNNEFSNUdIQ3ROQUVnc0N4MlRNWWxUU1NjcTRy?=
 =?utf-8?B?aHVHek5abUxwTXA4cERGSTBjeWxCd3ByVExFMjA4bEpVL252T0JDUUx5WHpU?=
 =?utf-8?B?R2VnWXdld2w5OWw2VmNBaEoyWnY1Q28xMzZmRDl4dllzOEFUc0ZTdDNNdFJG?=
 =?utf-8?B?M0s5ZGFEK1RmUnFlQVhLWC9MZEZEeFpKRkEwdlVhSlpRei9VMk9pQlBkRTY3?=
 =?utf-8?B?b2tTZ3poK3JZK056WXVuS0VsS3JZNm9Wc0NPcC9CQmswdU1uTDNDdXpidnl3?=
 =?utf-8?B?TGVycVduWDZZQlhycTZPaDlQZzdFSHppN2VOQWhvWUdOcjlYME0zSWZvSVMr?=
 =?utf-8?B?dVYzN210VUJxbXMvNzFOOEpqTVg1cStDT2tjdVhhd2JzRTRYelVxaCtMZXdn?=
 =?utf-8?B?Y1pVTFJ3Nk5UcFVLaDIvamRNWEVTcldaWTNhazhzeGJoZ2NubXkzcWhBbnRM?=
 =?utf-8?B?ajFXaFEzWG1BQkt6VVVEcnBRWnFlN2NOUFl0dWYzNUFTQ2d6YUYxSWcrVWlL?=
 =?utf-8?B?ZDR0SE9sUncybmYwV2lyRFhFbmUwNHorc2FhSFZlMGQ5c0s0YzRLaW5YTHly?=
 =?utf-8?B?VHhlbDcxQm5GZ25Bd2xERnY4YVFqSHVRdUpUeXM5MHprZEtSRzdGQlJFNXpl?=
 =?utf-8?B?bVkwTFU1a0dWbStrZmRBTHJyeUw3NGNiR1hOd3YzenZUR2xOekRIaWorTWJk?=
 =?utf-8?B?cHA4WThvV0g3Z2l4d1V5cHk3aU5iWWVtZTlVZk9DTTlMcEhwMHMveWc1Ly9i?=
 =?utf-8?B?TnZNcFJNVDNacUd2ZWF1WDkwbG5QZVFOdm1zOWlMNFRVaEVMUHNtcURrR0hW?=
 =?utf-8?B?VmRLbkZJUGpJL2N0TElvcXJSNitrNU9PVVNLV1pQaUJNNGlyYlNsdno2T00z?=
 =?utf-8?B?L2lINlZGZ2cvNUQwaHAvSlI1alh1VW9BazIvVkFycVJWNjBGblVsbTRaem5I?=
 =?utf-8?B?QkpjSlVqTlJDT1FYRWc5VVg2WnFiOS9GNVRkYlc5N1JjbVVOdWVxWGdJQ28r?=
 =?utf-8?Q?6+wpmRiTKjuXPDISgP9Q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2e7e44-c61c-4e26-3f88-08dcd1916582
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 12:09:18.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB5658

On Tue, 10 Sep 2024 06:34:27 +0800, Inochi Amaoto wrote:
> Add basic pinctrl driver for Sophgo CV1800 series SoCs.
> This patch series aims to replace the previous patch from Jisheng [1].
> Since the pinctrl of cv1800 has nested mux and its pin definination
> is discrete, it is not suitable to use "pinctrl-single" to cover the
> pinctrl device.
> 
> This patch require another patch [2] that provides standard attribute
> "input-schmitt-microvolt"
> 
> [...]

Applied to for-next, thanks!

[1/2] riscv: dts: sophgo: cv1800b: add pinctrl support
      https://github.com/sophgo/linux/commit/f093225b6ca367e632fb962671965906eaa08e8e
[2/2] riscv: dts: sophgo: cv1812h: add pinctrl support
      https://github.com/sophgo/linux/commit/4ea8511c034b203136234649baed2093efdd7504

Thanks,
Inochi


