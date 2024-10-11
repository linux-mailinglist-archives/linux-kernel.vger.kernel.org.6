Return-Path: <linux-kernel+bounces-361451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20C99A870
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5936D285A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D517197A9F;
	Fri, 11 Oct 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Val36qhq"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AD1957FD;
	Fri, 11 Oct 2024 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662118; cv=fail; b=QflLXXswY63yUowFUdfCy6Q3nRyruLAf+Jbfbj2tC6zzuds7DmPoTJGGKE3V5uOE1UmYq3/RhBrMMKqsntmgeQy1ZHxDluMBpUKoZM2FCEfxAncbIgoTwy5khLYoB2MDb72fZG6tQ/r8KUme2/qo32yfAmvtI5lJekJcJ2A3VwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662118; c=relaxed/simple;
	bh=Ab+caCa53yB0xRK3GV2D6WFfSREGWHYbKUPFOruJ9F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ko5i31KIR3Ujnae4wiXemrAasvOrCSuL1iyJxYxW5aCls9tXyAjMWt305TUugQK8FxnlJYkfdDNsVDTDNSPUys7OMMydqB3Q7vcLTBSeqeieHZWqV+hmRkx8TUHLDMMF0tQcSy/v2MrdOlLbzFUJlqbYNmX6vaRGipNnZc/JY9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Val36qhq; arc=fail smtp.client-ip=40.107.104.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW5uGZp8cXk6A+AKxNj5siYQrf1Qms3v0OLcORsNc/dDhln31nmHBJQHEasmAdayfFxsQrVXeGtrxbUJc+8PSXdmujyvtcDeAn4pj4mn/l4fLfxkefAq5nQ1+aaLUN9EFG88qZD18x+dr+JnCCZE8xbUpj/iGBi0mUlHX1QtfjrJDTGJLy/QOiaDA0lEZ0uyYEH5hDIC05kMHK50DhXo7KvAFE+hMhriaGdXB/vu2Kupvp3yahojijmVfnaP8RYngG0F+d+fnOxxMCKJvLO3ZZ4AURog87XXep7zX/nCzAUSiHITFXKMdjaTJ85isw3e1cK4Rtn4Ywdp0lF6hPWeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khbKrjtK4xaYJ64f04FIzqpa8ImvcK9EtezZCoyXgxA=;
 b=IdP+WyV816mxV7wWIoQ9ZZLCmE2FMG+qXsmdn1x8OG1hRhXt7csYgQHmuhX71k1FD5pSsyfDyjZxNNAuyDajqLyr8187ab6HML1qEgW7TJG4KazA8xFEznLRHmVKEqfhI3niWw3ySKXffNmJoaWNSwuVK5g0cduPtEH7prif+l8iS2dr6JISBG7VUBLYkILZAPr3xwVCbcA36oGYU6Yq6gTSusDonEEaiRPhXnOrL+Do0yVzdBI7O8cCw6im2goU9OmtpS/FA0tx14QDNS3xAlN6q5QFPgfsy6MozvbbK/sEf4fx64Cs/9B8KIWDKMw2JsL92gslRGskBGQghWIVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khbKrjtK4xaYJ64f04FIzqpa8ImvcK9EtezZCoyXgxA=;
 b=Val36qhqHYbmqz8f0BSkAQWfeX8k0KT/LD6vVWHghF82UPqv5VjA8SDG6VTkcyYJnYWgURS8H8DaqJPjrD+cK6QlHwEx00xF2dtNTS0RzI10XByfTksfW+OjbHF0qBl5UViC5FmjRKnlh1e/kCbrfZrwuWOuRU1dGSz7Abb5Hm0A9Df5HIMTBcs0mV1md+28viRCqCBflpup2mtxXwfCZFOySERh746icPFvhPwfB+mJVSA0fdLU/F/WJ4KYI5HmdK3PheWgq/+ql+mPCsPpgSewr/jwpMmFdVQhV52SGSvk5OFcAp3IKoBgm35IssEXypB/xc5nHO1gn59EhMO6Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7434.eurprd04.prod.outlook.com (2603:10a6:102:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:55:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:55:14 +0000
Date: Fri, 11 Oct 2024 11:55:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/6] arm64: dts: imx8qm: add node for VPU dsp
Message-ID: <ZwlKWcTN7DBsvdD2@lizhi-Precision-Tower-5810>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
 <20241011150439.4027-6-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011150439.4027-6-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c8232b-3f9c-493f-a093-08dcea0d1835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pm6YMO0vS0sRHbQWxgpeKtLJhTQ8iWQbz2z7sWAt0hwTpo4GgnHpNiqgawbf?=
 =?us-ascii?Q?XL68hVoWvnEMfNMcCy+evXKNt2hAHRFmVgsl/EgdIq16U8/dPis1diiLkeZs?=
 =?us-ascii?Q?k1h8wmwri49r/SwgcjuSryEkuThgLQcwAvNn0FUTiBDgFqkRxK91MmK3T0xh?=
 =?us-ascii?Q?8OfZ02tZieJ4ahc9lFmi5rvhe6XCjnaCOxCFDcqIx//icNUWv25etweDgJlZ?=
 =?us-ascii?Q?A4hsP7vlef+Dn1gh5Trp1BwsAX8g/eGNi8Qv0fj76XBiRVzhR3TMhQu5AUCw?=
 =?us-ascii?Q?v28cwtfnQzka6838LhrCufjThhSJ1Uao2Sv4pv41mhQqwaLOy9kjhvC20mhT?=
 =?us-ascii?Q?1/exXVfW4phQwBPubOpDDmlaso/zhk7oM14Bcs2gqEWGXGc4Tn0+tOGnn64s?=
 =?us-ascii?Q?WvYFumjiYVQgd6zMnI4t20zDa2A2mCGYw1/p/vBQOfeokDzEJ3McU2QzumxT?=
 =?us-ascii?Q?p1Py0zJs+fy6iLXh32SXMdN3VEzyOGqPN3G5l9+Pv0N7j+GpjUyC6i15VBKp?=
 =?us-ascii?Q?2vAvhd/LsHp8w9fPdk0dOJumCoSnd7YqpVefMRZd3wetNteGNcRXksgVPYSc?=
 =?us-ascii?Q?1zaO6FbAHaXp7VKkBl+LQbe9sHtSWokFgc/uakSW/tSmHUddeEa61rvjy07w?=
 =?us-ascii?Q?/IFDuaS5E2NuBPHYt8n1KeaNIDVnayfAe05hlB/Tlcqbt8S4whPVuxC2j2ap?=
 =?us-ascii?Q?kt372rgRyslJP1IkpB1QXc/+NGvsoAafyOMgpJXLI0hvBxxfG32+xjjBBg9n?=
 =?us-ascii?Q?mHN/ZG0p0mWX5LQwW/fEXle2NS0ot2MdAsbBgfu23E7oKXVFO6UyRS6I6fpW?=
 =?us-ascii?Q?NURfGkZCjyoV1Jt4aVh6MWTfSIoctW0q+b4UH1zRZIM5pTXnRo7vCRPP/+/J?=
 =?us-ascii?Q?1nTJKvzuHkcLzm5aBywqG8GsjDdoxRt1x1WAifknHTgvarN0HasICwWSlijU?=
 =?us-ascii?Q?RIrgwtZjVit7tkMnJ4oethBK9pqHXlJifgWMT2cGoZcStr28Ku8M/YVEgv/f?=
 =?us-ascii?Q?YDwcXvyjT57z16LfLSWepRStCY3x0r2ikxPstgPld8iwq4T1jCvQ0rAgvp3X?=
 =?us-ascii?Q?hM8QrW2xtkhJHOWh1bRkbesK/GPORYcUGjo9k3N6j6Ovyg8OI7v0Feo16rka?=
 =?us-ascii?Q?YuuTbqew9Fysd9ofmv0+iiw7MgVADBcbo2/qHybl4byYONKOXPk5K+f/+h9+?=
 =?us-ascii?Q?Jo8ciL9xAM5/gcD6D3UvZobUg0UwnqT9tQkVnUYijyWqrbxKVZpiiWUA1lvJ?=
 =?us-ascii?Q?6+jbnmyVp6nWXVghn9YEOte0Cq/w5kdKTnO+Tn2OveMNl0J1bqDjESOEqtWt?=
 =?us-ascii?Q?22NgbjM/HXCGmZ4OKORhRPBHmfc4ZyvK2o107nT4rNC2RQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MjR07u9qQWBgodiBVl8rQLPw8Grxs8jv4MTR/2KDIJL7yNNdzwkdGgqWs4iX?=
 =?us-ascii?Q?SMYwgrIYjzU/BzpZOr50UoiBiTwGfQKbveJqRlA5sYIV7VjbvD0lPvGyH1OS?=
 =?us-ascii?Q?bkq6g2Vm9jtVWMu5o7/jJilfhptHA5iYhVVP+bnk3DFqGxr89M1n70Qmq0K8?=
 =?us-ascii?Q?vDsfjSiV2F2NA8hAPYa9eQvq7w1+Ujn4Q7iY26Ob1n2wO9CpkgpyBjExmZw2?=
 =?us-ascii?Q?WjvZh0ggFFxARzgb1ArovrAyYzTlGI6wKKx95um3rlG0yvbKRGGkvIlaphDC?=
 =?us-ascii?Q?+SecF2b2pHlG23ejCltdEtWaGCa+cnCBZEq7AFMUcDqlLAkPEtqD7Ht1Iadz?=
 =?us-ascii?Q?oaNHUhfzWDuwaaat6OR1XsgobnvZ/cV5oy4/cj+OAEcGEqeGv5k5BmPEJDfy?=
 =?us-ascii?Q?qo2d0xx8ZYhC36zyfT6t1qE0bjljSgQsHzdJqcGR65oMSTPAH/IDNI1ksJ3l?=
 =?us-ascii?Q?PaNmpo7KeCvQJCpmfASYh2v7nw1NDm1T0VrwaiTu1FOqrEo+eTwhjEq3fc76?=
 =?us-ascii?Q?QwpqZSd4zKspw8Abjh/lwnJYiGzw6cfBrmcJpbvqD027QFXrsLkpVaVrzbDr?=
 =?us-ascii?Q?3VPqi15qvhD2iupUyOl1nSgyCCEvYngPY5QxMoZCMUgYLuZYg7LxNOHWKr4u?=
 =?us-ascii?Q?3MGGPZDXKyOHS8ckJRU8UX0DUCzr2ceKwQ0R8EJPqDGC9Pbe14dTXhNjHFC3?=
 =?us-ascii?Q?G1ZZ16p5V1hzB6Fb85eSUltMWmPldoEAjNDA80ZdXi6IVi6yjis44fyCZl8X?=
 =?us-ascii?Q?HXxds9Xf9dkStZKmLZIf0kev9yuFyNvqsqyyxpjORudO1Mxxf+qoq1GoBXyz?=
 =?us-ascii?Q?NuOJ+/lYQbppK7p8KVNEYr7g6AEE8HNOZPzWIk/ww/0wb4wVBQVZFFhBZrZk?=
 =?us-ascii?Q?iuyxCPtKpqtpVRg//MSAsGCap8og+a1/RsULMbDYHF4n7vPucZpMiOnkePMN?=
 =?us-ascii?Q?HIw6wi+fdIu8BjxFhgoJBAVnOYdJYU/0Gj+BSRfLnmweuYXmW50g9nlUX+eC?=
 =?us-ascii?Q?bTS6WWrJNm9WYknUQ5aQ0H4P5gebQr1EqiWAoVSxBUTtfvKfJ4JooMMDbJcl?=
 =?us-ascii?Q?88Krl+JQFhItfVvfkyRcVraxzckSbmHM9yxS1n27guh1jzVJ7iE8g+aoDckr?=
 =?us-ascii?Q?rqzS8wfX7m4zn0SsyfO4UF4y30TyJfRUIy2Fqnj+wt8NunFW4qZbGU0fDGLc?=
 =?us-ascii?Q?JRCeCvh3m4wAdhhBX2cZZz/Lk34IZsvBsIq+mEMj6Y7vmOEiXBjEmkfb9cBY?=
 =?us-ascii?Q?PS+dUEZ1KHH67dHIJiIMB+M12PXdreoO+9tcDQqli8r91KTyqVFrkG042aAA?=
 =?us-ascii?Q?pvg9mF+izGJtiRJ2QyyxjWMAMoM2cLGpMBnWaONB7l+gnCfT/aLtGXKURTcD?=
 =?us-ascii?Q?4sL59iFWr4PwO8Og83FBRCP9iLghKI1yysI4ZPQej0wUHRjecEW/42olQYuQ?=
 =?us-ascii?Q?uoKaTiGGoJBO0zM4CQn8gvtWxMdvia4ip1U5E7Aw+5OD/KYXilGYN07fQUKN?=
 =?us-ascii?Q?kJDrMUQMBrZdG74tTqzmIKpvaCVWprsG+uNSeYLFk7Z3AOQ5nRCJPtIdK5a/?=
 =?us-ascii?Q?alaIvQVuX5cKVRIcgvI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c8232b-3f9c-493f-a093-08dcea0d1835
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:55:14.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwtF1GGB65iJ71o5a87MVx2apcOse61M6YluMoMfjBrR3TvpqPvS9hP+onWBbmPXTRPeGAk6hxhMlhcx96HL9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7434

On Fri, Oct 11, 2024 at 11:04:38AM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add DT node for i.MX8QM's DSP, which is found in the VPU subsystem.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---

with below nit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index f8b577ebdbef..74857a94bcd3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -581,6 +581,32 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
>  		clock-output-names = "mipi_pll_div2_clk";
>  	};
>
> +	vpu_subsys_dsp: bus@55000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x55000000 0x0 0x55000000 0x1000000>;
> +
> +		vpu_dsp: dsp@556e8000 {
> +			compatible = "fsl,imx8qm-hifi4";
> +			reg = <0x556e8000 0x88000>;
> +			clocks = <&clk_dummy>,
> +				 <&clk_dummy>,
> +				 <&clk_dummy>;
> +			clock-names = "ipg", "ocram", "core";
> +			power-domains = <&pd IMX_SC_R_MU_13B>,
> +					<&pd IMX_SC_R_DSP>,
> +					<&pd IMX_SC_R_DSP_RAM>,
> +					<&pd IMX_SC_R_MU_2A>;
> +			mbox-names = "tx", "rx", "rxdb";
> +			mboxes = <&lsio_mu13 0 0>,
> +				 <&lsio_mu13 1 0>,
> +				 <&lsio_mu13 3 0>;

Nit: keep consisent with clock-names and clocks,
mbox-names after mboxes

> +			firmware-name = "imx/dsp/hifi4.bin";
> +			status = "disabled";
> +		};
> +	};
> +
>  	/* sorted in register address */
>  	#include "imx8-ss-cm41.dtsi"
>  	#include "imx8-ss-audio.dtsi"
> --
> 2.34.1
>

