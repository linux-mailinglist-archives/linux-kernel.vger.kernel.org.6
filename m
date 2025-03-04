Return-Path: <linux-kernel+bounces-544959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C90A4E943
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F158C25AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7B298CB3;
	Tue,  4 Mar 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pc7hDbZL"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1102517A1;
	Tue,  4 Mar 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105691; cv=fail; b=gvOrgsEBJn/bo5Deu30H1nHhU3ETCgYb42tRJETUx7ZRBKxDKg3XiHXf1MLTTnDexZ1RsTzjv9ETPqD5yZTnyHO/DzArMQPDCQROlUxSqzqAbgERXZKP9/FHiCc8iJ1MfEIILo+taLc/rUeOViWrFlTd4eXpJnFBVHDvY+FFIz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105691; c=relaxed/simple;
	bh=YWfV4wxFrlXETdJcva1srojF671dNkPgJAZCyH/YkeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=btru/FCs2oP/q2D7bBSsJ7MGFlUbKl99yFJnUy29fB4nnH6p2LE5Q8RxY+WJVZ6ubmntE9GFQIZouGlCKTwd6D1TQ4DJdwxTLhcDlxt/mDlrsYMHccQF9tFEBQRQJKI6vkL9FoDS0GL7Ujcrug+8mFdKSTplk1xYLxTnJHH+7hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pc7hDbZL; arc=fail smtp.client-ip=40.107.105.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwdNx0bC7uKtw++k4AAbhhq0LDNt5sZUNgMckjiQpc4OOoCMOtqRcyS1XcmcxFB3PE1NXNslC/i5mrTDdsmzJyuGgpFiowbuG0JD0+Cqnc0CkklIC9rZRVeNMccBWYmy+yWjfC1ddMtc0MfvMcE503TsqDsOoRX7IPqRgN6i7GXpG9cFkHaNz0bIrwcGn/Cnqdrz4ddSacrP4jRGSyo/bZ5uXjv3yW8CH5OP1RJlR+2Xsn5z+p0NIvHmpzG1GUO/VVs8VpQZD2UtTf4urtM+rjCHMDqc33nb9WjWh7Jd5STKnpYKRtagxfrUGoZA0XU5D+D3Jl3TK5O0/+OgBQRznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqEbh1zBiBNt8NdsoYTqTKOzmKC9LHXRBGQQfwx4jtA=;
 b=DoxvJ07dDFP1MjnPxRJmULgUWzXzkUSiKAct3JodzLxpOcAfQa+knvnwFG3U76ibwz3HwSoZwngSxqQWJUr/Dlv1FW7fQCA7cDAC9wMZ79fLnRWdtKfp/WhHgF82qTvsQkmdWIhJ/nkSxLCZu48XowdsL+4LNIBTbpq7rJw2T9+mLAovV4JXfbDrv4fUbi52LohCni1DMORSyiLo/L8Q3cnWT5Z9EGW/bO65MwqBsad85Z4ipsjy+W0H4RCnasdgQzTvlPTrN7BgTL6XBAJ1IYaIUinzTIkN04NFhP/QjIfw612ELveAFhvDQRXhlxcSsVqR/ztUHwfJ1hFj6eAc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqEbh1zBiBNt8NdsoYTqTKOzmKC9LHXRBGQQfwx4jtA=;
 b=Pc7hDbZLwR25SdZfJtYys59XckCOA+m+KSbIoKoDL2XhHLTUJwgIw/4cI71SELKEhH1+vA/kKe4n2cO5qIaiG3ffFyPavca3rQyDDhWriJEL4RNmKSzE6MR5GlJXTy4rPw1j1TMgh4Q3lixCgZw4QgM9m+CfJFrK7A+UtjMyJ/+PZuVeJQLG+zrvhopzASSYYdtvT3wsgZV9RAT3o3KKor0Pv7hElMyFRUwvC+nwKPYhu/mc8XmAZ+oz0eUev1Hk8EYfpaPfE7/OhpTBlb9LeWtm7wtKOdHB+I3cEKGMkonjkhJL2rn60+K0CrfG0zq3+pjlI/UhAnxMdBFDWFLfuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU7PR04MB11137.eurprd04.prod.outlook.com (2603:10a6:10:5b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Mar
 2025 16:28:06 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:28:06 +0000
Date: Tue, 4 Mar 2025 11:27:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	viorel.suman@nxp.com, carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>
Subject: Re: [PATCH v3 2/3] hwmon: emc2305: Add OF support
Message-ID: <Z8cqBtDCtylWkmWJ@lizhi-Precision-Tower-5810>
References: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
 <20250304162136.1963384-3-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304162136.1963384-3-florin.leotescu@oss.nxp.com>
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU7PR04MB11137:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f734bb-3a37-4000-9162-08dd5b398af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5c6l0+aGi4Ghe3kvLCwOchWxiBbicjtGnRKFAdMcBXtdemsF2PoJQuqBrWh9?=
 =?us-ascii?Q?PiaJh/UkPAF8Za26xDFlrm4w21a9ENVssRn63CmRrf1ctbMbT5xcQAYx0S8J?=
 =?us-ascii?Q?6WNc64hdcg3ST3uJx+m5Rd0fPZ7XSjJYP+ZU4oS2xHygkc2+jCvquZD+UKk9?=
 =?us-ascii?Q?uXsaHODnmhMARSOZl3xRvCCXQvGLgaVqz2b+C/bnk9/NytaY75jxEOq7wIpY?=
 =?us-ascii?Q?lGlJM1KZcCfXy87T5SyNg30OuWRnvyixxqDjrOa6Ee4MdE7RbhnQt12rgyQr?=
 =?us-ascii?Q?HcOtGhLX00NJxsGrWp919WvpeW3alcEOiVsxir8Of1KWS/ehLm8Ghjh5Yl1H?=
 =?us-ascii?Q?pRQi4G6TMBeCukLId8IxQSgxT3ANPVXEDmfGuapUGh9XjfcmjTbVxPpEJbUh?=
 =?us-ascii?Q?Ckk3pyAwnfRgn9CzGnegLEsboK63W7EVxGIgn5EOJJYMMywgyjiHWzxAS7qY?=
 =?us-ascii?Q?ztThJC+u612r+1Er5ZRadVrqDnOgPrHyXO4Z+gRiQr7gqHllEZSGm1I8DgTm?=
 =?us-ascii?Q?c2WiwdTC28Izeal2u2juJDrtPCm9i4sz99GZ+B2tn7Rjrs5zbb1OC+Yr/peB?=
 =?us-ascii?Q?6JL5a1T6a9qAXVwmxdv5+EfDFRkRYdzJv2CWrquuWCjF9a7R0TnAaLXzQTP1?=
 =?us-ascii?Q?mcAO3cteWnYyTpJfoNm4sd4UtaGxqKurkZtO0dEjAczgO1iY0hqW8W4ODxiY?=
 =?us-ascii?Q?WhxTxK5iigxGOcAgd/7XtAkt9EgqLPIwmQcByQNzRtIy3+x4xoi1yy9BOCmg?=
 =?us-ascii?Q?YfhGtUDHkUJHsYZWqEOUuEtmX6BmT36wSjKgHE1infpPMwL5b0FCgVX4u1kN?=
 =?us-ascii?Q?ON0KR/8YpepOl0hBDCsMXd+Yi3OC72DhVNxh/Htgc+BkErmObUhauNybP+PO?=
 =?us-ascii?Q?dM6249XjOc7UqY4bppYsPKlNVaVbcrSLVbBCToBkVZK7xKQtrwbjs0c1gHuK?=
 =?us-ascii?Q?zbGQL3caoqebC6lhaGDnqHlePjlgi0OAV8AAuvRi570BrbnOO89sQ8B8k419?=
 =?us-ascii?Q?JNV6U3DOqYlxjy9XrasIx6d+9mhCeQsEWz/La0zpcYtVn/1xVnyNpA6ILWri?=
 =?us-ascii?Q?cg4TseuAYwOTERH9vkdEoIFvocJlfxjR8SjxWN4LKRLvQW0GsxLuaZQgDaoh?=
 =?us-ascii?Q?AivrYpVP9fMHr0ZziGnIruMoJQB+LcoBLmuA4pY9pGL8/jL5d/rTxgUfZOWI?=
 =?us-ascii?Q?0qKmKGR1zU+Cmoc/B/eberkpHciOzn8tHJoNxGNA7OZdG8PP/hU0NmtNjEb4?=
 =?us-ascii?Q?Q+4aQLQxvgJygoMjM5E9u3rXd4MCfeV1zKUE7rzJthE7B374yjv+HvdCzhSt?=
 =?us-ascii?Q?jml1VCVrI0NwA4rxr/qOsbZsz9aliW2NO+is13/2mnQYVI+RRlinf+Gy/e3m?=
 =?us-ascii?Q?cwIRG/M+CfUVlj0it/M27KlCosy+aee4OV4H3WqZJJQl0xyVkuMlf3DU+BeY?=
 =?us-ascii?Q?sQ7GIEl0aCXq6GRyQ3r3SvUnn0wBvFd2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgvVL3vIDGNc/hWB9keEujAVhNU4cHz2jeISer+OnivAmMsnOS0MLjyCjVtl?=
 =?us-ascii?Q?/jgi3w4CDBRBv5RWzdCsCXWzpL5+tjKN7wd3u8z+RkKmR7y9EBVX+i7P2XyT?=
 =?us-ascii?Q?JicHw6AnhP+BitAw+12ezTX0iBABooWwh5W+hr7Ema5ebuPsC7HKBBCa+b82?=
 =?us-ascii?Q?72LUyJ5kf/ETAqxv+uZnoMJgchRWYRPJJrc3mUdParZo8TsikzCl41fAwGcu?=
 =?us-ascii?Q?Bf7hl/sdFmobrFQsyBW971SnTmeGiG09a0NeX9kd0E6uVglLQS3kQ1I+/k0j?=
 =?us-ascii?Q?dzSPeIyqO9WMsAo6ysoVImsUAM4+9QOUWVBxAhnUL6gthQ1yyUQt3yW2GY6K?=
 =?us-ascii?Q?HpuS3+32YIGeBfPKp+i0QHKvWy9rrXcHBAhFyLt7Yb3zJAr2kDm6TCjRJITl?=
 =?us-ascii?Q?3suLx6wxMFboUB1/6N+Rndw4H+ReieL2LYs9PtY8MnQNkTbyR9spXTmdfV+y?=
 =?us-ascii?Q?Ksbum1g0GC3IRmUfRbZ/QWEgg6+Wb+9RzIUj6s0/R81/dA7QdPuLhR/mxo53?=
 =?us-ascii?Q?TDqKeS+kKliV8DVcAaRsPugStrnj46CWXTwT+RqQPBIVRN7lfn/IMpeirJm7?=
 =?us-ascii?Q?LFhtcRYtqIjQi8eAr9RnW/72xhw3g9SocVwucu/kjB3ImJXPcx9bgmjgc4y7?=
 =?us-ascii?Q?nOti2aYnU0ncPYJlRZ6Uxs/VpDSZFjiXpfeAUf/F9m7lR9dSuSbdsebuxM/m?=
 =?us-ascii?Q?Tpq4At/i6GxrfU+UlV9z0YBlKXmub0iUWeb8SAUWNAyEXJtoKHqQrcZ0LBrM?=
 =?us-ascii?Q?9AU7Eidcfy413Loz1Qaqr0b42/67MkEwItMtGN+LQzPEiKhjLTod435FMIVI?=
 =?us-ascii?Q?h+qcYbSWd36GNByMs7Ga+rNoZL7tHhwQL18mEL2nyRlOFq4hLf7lrfxLpcsa?=
 =?us-ascii?Q?fL2ZJnLsgX53Qr/dt+OJs0P51UsFKUb+FErbdx2HDCowdXoWh/1178zCDNPO?=
 =?us-ascii?Q?WHNZgxKP//X5SEbWZgFu+3h09NdXJKzIL3QuY9oz1G082fQ2/tOnE3gSBy7J?=
 =?us-ascii?Q?+sadHa7cBouMtgPDoQ9IdPKxEl5eygrRJfuKvaGt7OhPq07CgLSu8LFgQ9bP?=
 =?us-ascii?Q?jXSsAm+KrtAvnYM8Cok4z4l/+gjw0KcZ0Ras8JRp2Tr7MHESe8vJQdxLkwaZ?=
 =?us-ascii?Q?jXZg5AnMbp7tSzdHpsylcVoNpPeU3fqEPQxWLUYZWD42gN+iKnU6rmL3200D?=
 =?us-ascii?Q?X3HFlliNo+6Z+VwAdhpbndumZmWPfkxEl96lugLxEwmHJQlY6xPzGyn5VlkE?=
 =?us-ascii?Q?K6cBAL4slcEopTGHDCRFa5ImO3RcXcpkTKM20Gnd4CNadrqx3ZAMGHxJdtWU?=
 =?us-ascii?Q?tClQvdEyH0hHp4kGFILc3wGaF/R+IO/b7wFpJqFiKgtu3jyL9BRmpvKmSXPi?=
 =?us-ascii?Q?TGV/fMjnRTeH0o2Uuzgtk8g6apOZA0CFsaRpcjnSvUgkAVLBIDmsjzf79nxt?=
 =?us-ascii?Q?IEStQfFKKFQazhvLW72QesO5NJlCkqDCxevVsAy0fMzeVDObKWtXt3Ww6viC?=
 =?us-ascii?Q?mjG0beHqNLsp5X+C1ONEfRNNvFeTYIqbDJMKwK4vxcyIEEwcr17EW9tEoMyB?=
 =?us-ascii?Q?3MFV5ASvzEnB7DqVq4GdGwf9QAO5O58X3m0GxM4s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f734bb-3a37-4000-9162-08dd5b398af0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:28:06.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ewv5FktsG9vCz1IGuaRQUmBJuxB/gUzJr57Hcb3JW9R4ThMQEelbsT4FJA+2OmFxIZk9f99nZWMFaxpwVvmVuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11137

On Tue, Mar 04, 2025 at 06:21:35PM +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
>
> Introduce OF support for Microchip emc2301/2/3/5 pwm fan controller.
>
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/hwmon/emc2305.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
> index 4d39fbd83769..a236f27c75bc 100644
> --- a/drivers/hwmon/emc2305.c
> +++ b/drivers/hwmon/emc2305.c
> @@ -607,9 +607,19 @@ static void emc2305_remove(struct i2c_client *client)
>  		emc2305_unset_tz(dev);
>  }
>
> +static const struct of_device_id of_emc2305_match_table[] = {
> +	{ .compatible = "microchip,emc2301", },
> +	{ .compatible = "microchip,emc2302", },
> +	{ .compatible = "microchip,emc2303", },
> +	{ .compatible = "microchip,emc2305", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_emc2305_match_table);
> +
>  static struct i2c_driver emc2305_driver = {
>  	.driver = {
>  		.name = "emc2305",
> +		.of_match_table = of_emc2305_match_table,
>  	},
>  	.probe = emc2305_probe,
>  	.remove	  = emc2305_remove,
> --
> 2.34.1
>

