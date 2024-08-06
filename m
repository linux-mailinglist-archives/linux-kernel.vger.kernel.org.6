Return-Path: <linux-kernel+bounces-276552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA77949526
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE371C217C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A352B7BB15;
	Tue,  6 Aug 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TlaTZbbr"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAC51C3E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960137; cv=fail; b=iK8mV1+/Pxv/CYqFMfUmWvLI4MGHDVjEIBsh9fVbwhX6DI0U/bx4njQJnVtZOVNUgFnDmpTcjsOKmSeXOqjJJJEIyqXnd5ZHoh2TbSVm4gG5evwxT7P6LZ6BYtkz052/vG91OOZAz2Ls6o3RxjQotIrr2yDNmNcnX8BXDQwPZvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960137; c=relaxed/simple;
	bh=o1agC8WZi9lNPMDXixgYbd2WCZuLdOFxatBQMadKx5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jIprKdCJ730IcLRQ/TNqzElOsFbI7k+2SA1nrWaTt8SdOiQOQizJPMlyT75j5nXcBEaI+kH5t2yXbXj1cA7YDab1qtXZU/lOTnqVTezLo2MN2crRtcjmpHocjFzyUhfp2lAIFTDGER3EyfWMcfgCOmHG5mWh5Tjhf0tMudAAZWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TlaTZbbr; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRMm+87QgazLZ7YX3HnkR+njd8YZb9ZA4Ez/yejSb2fEXWUhW8MCgDDaXOLT38ItqFpn9bI/NdJWwr/oFUCax09JmkJoE00yBXzjo+1+07k+sIEMpS5e/y3fDyBQ5AGxUOcfvmvHSC8jHAmmzQR/Zyd38lNHI6JLkTm3eIUte0XJqP3rty6cnyjMG/Lnhb4N7q61qqRU0IjG6Brt9YMN7p6yjQry0pN4Gf+FSlGvL/AC09kr9SN08pR4GGYKhLkOnIE/PBj0xQP5CrqUwSdBighIqNPlcRz23nO582lh5cvoFAECdt248clGmxfGlmXmZgXiZC7rrt5h/3Fy0m4/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScI6UJR251Q9VZMxz78214ko3oWLOnQmGDlBgaZg0Hc=;
 b=jirWpVryH+ybbjJkwzXdCnZsSLVCraIjH0+Bl5WcR7HkN4SySsOr3Q+cr9KvksHN1+nhX/SoW/L1F0ik9Dip+lHr/QcxRawF4QvBwpT9zqvVQ8EbUOrCqOZMu+F7xUEp/y8wcRtdAjiFi679RGkGmwTSXSumKivhYkUInjKSTIEbD1M6mnYBXrJTC+HQH6BRCdNvUngZ0EsD2tI4SNHLkAflVWs1R80RLXFNk9Il8DM6WMis+3zVW314/M0tgrKsVqHuFZGJ0h5/v1lMSffT9w4Tkzy8mF1D9XS5L3vQB+9mkAFIThyadxkT+7/u3UjbU/wZs2cnWkKcGy52MDTBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScI6UJR251Q9VZMxz78214ko3oWLOnQmGDlBgaZg0Hc=;
 b=TlaTZbbrPqQUK1d/RFDMo83c+xbm84YlDH6Q+vX5NUUNkU97m2BfWbBnbW+w/eD7h0GHzb5H8j5Bee0mKTtV0muiFMeLN9xbXtnxKJeNHZsw+nd0SO5RWNuOD2qYc5pF2EajV6AnmUfNHdM5bvrabVjfD+Go4OGRthrJV5JJnYIzIMOY5IFt6kosi17erb02cchKHZXXj7tqFiWGyNRtx09cv5kuWq5gdZrONFU0Vu/r4Xu7UKqH3JlsWM7LlXQf88A0tfpoJ74+lruzhhIP0XSaB518L1LBvUGuPTwha8s4rZbZO6Y1rvAlUcKHHaFNNvuwnhgW2+dSFfEdFnjmWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10793.eurprd04.prod.outlook.com (2603:10a6:102:485::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Tue, 6 Aug
 2024 16:02:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 16:02:12 +0000
Date: Tue, 6 Aug 2024 12:02:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: carlos.song@nxp.com
Cc: alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: Re: [PATCH 2/2] i3c: master: svc: use slow speed for first broadcast
 address
Message-ID: <ZrJI/aa1O4/WDl4+@lizhi-Precision-Tower-5810>
References: <20240806064851.2425797-1-carlos.song@nxp.com>
 <20240806064851.2425797-2-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806064851.2425797-2-carlos.song@nxp.com>
X-ClientProxiedBy: BYAPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10793:EE_
X-MS-Office365-Filtering-Correlation-Id: 299b913e-74a6-49ed-a805-08dcb6312271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H0UiCsTm8RAr7JIvwi2V9L0FxqPpZqAa7IviWUrusnvaq3CqyVVdr8Y3ySUI?=
 =?us-ascii?Q?zgCBeAm2kmwfUCHuUq+JicEiiiEMKlFvwaw+vN6cFCN2vaWoKHWG52bB4tRF?=
 =?us-ascii?Q?JwAG2yeHjPoZSjsgQuXmy58v449lpwPnZ0NiRHaLHnBvrBx9xJUr+ISFGWjj?=
 =?us-ascii?Q?YjN2U0/XsD+G4xh2MNiIERsrYiSViqw0CzU2KZSFl6pyxwhhRAHUq+eaGsJd?=
 =?us-ascii?Q?4dHEfuuFUDibduCfPnM9OsiUK0oHI3osQBfGTwrULGwoHTezB3aaD6FFacai?=
 =?us-ascii?Q?EoDDOl/AQ2/4g3ZeOJL7EKoow89KxarB84WbEmjcJ4cwZeVQcRZLO+4UxrKt?=
 =?us-ascii?Q?VPdcG9EDGripjy6WcByeH86WBSR/Ky7FYj4AkN8zCE5GMs1AZhnv7YHbzEqM?=
 =?us-ascii?Q?DTpxc56KvhVRowHTTh/89EwZwfXxX97inEGKcERDHGcidFrb7Yr+bWOfcEdu?=
 =?us-ascii?Q?jZMAy2NsjoyyaL68vwALrM4f3JIhke+onA2UuJt0V5SrDcJEV2QaDonr+i7P?=
 =?us-ascii?Q?G/zm4zrJ22j6QzCz4yGaa+9W6BIdqmw6J7Bx4wr2BkqCeRJcDHBXDpqORI82?=
 =?us-ascii?Q?J1aBRFvJJOuUmVFI+yBPMUWtA68FmX5gn7Ep+8m7ry6vVQsePHu29ocQUxXR?=
 =?us-ascii?Q?25z9BtIkkQuSWriTadgLBKdYynjGqRSKaIztCPNIZCamYrejyykvsaCjuak4?=
 =?us-ascii?Q?qNR6Jhzh7i4CBgehXyjOQhuSMF5Dz0c+4pdRk1QZsANeKEJ9tHvqy3PvxWrx?=
 =?us-ascii?Q?Q4HQ3qYOTB31jwpyTgjs9N6cwWtho0OoKWZx76rn3HV0oNgQ0EbrTL1ZxoAD?=
 =?us-ascii?Q?wE0m9zk3nQEPSuvAysrPOXbRucAeXV0muSdc4J1prYg+T9m2TLKonAg5zDTU?=
 =?us-ascii?Q?YdbV1a2B1Wfd3aGloL9pmMF4QKwpUN63qQqGCcPCS7Q/zEbo1vTIdbjmGchb?=
 =?us-ascii?Q?BYzEGGqkiIMTNyif/+74QPnVRLdb71kasLygvsbNR/Mx8cw5Z8Hq0QPSo+1h?=
 =?us-ascii?Q?ZF9MicNHjuSlMiLT64Sq3eKi3i8vU43HM0uuSBkt56asGPZ0GyPUKG9agdKk?=
 =?us-ascii?Q?48G6fi0CXVBsWMtW++1jvPnN0gQ1aB1TRiD48Q3uD5v63KSBZfVuExvCiHKu?=
 =?us-ascii?Q?Uknra6QifMJrkqHBv5thraV9/dWFmvFt9HNacRxN8Ms5P0L8Qa57thzRfQRc?=
 =?us-ascii?Q?R5ARlnJu/ojtfmorxpE0zNhMlIGTRec9JW1DLPxLYgArKTCpRC8y3tsbxaPZ?=
 =?us-ascii?Q?qpucL48MWyIbjwTbSVuTjQ2gn75Dic/hP0nJ6JD9vLv9XayocdeSGNKVA8Iq?=
 =?us-ascii?Q?3gSCjkAG9vZuTzgxyTvioB5sZGbMG8LaoCF3KVrrJTvLp/kXVow7VYBB7uav?=
 =?us-ascii?Q?sOwVpw71itpQJw/Gojlz+LOmg6h7yLqsPebwauXGBj8h0FgKYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HG2GAg2tm/mCxYTRmH1Ki/UXbOE5FLzCUZUML+6ROKdo5Hi031ZxRGFjNcNr?=
 =?us-ascii?Q?1AY/X1l55n4IUc0cM+0vG/quKOYRtMWQJIwH6Pfg9aKVMAVOnJqVNn0R05H5?=
 =?us-ascii?Q?jl8xj5xUjydDf5e0sO7iaRUmurgjV7gSq5RYPN/FYVpqc5PxEHH0xfXciDHt?=
 =?us-ascii?Q?MVWrXEpFWiyBxb5t1PK2Ok/fVWu29IpUXz1mOBnZry9+oxU6pD0adqXb/LN2?=
 =?us-ascii?Q?hF8bYb68/d2ufRgnQbXzzeABVH1KKWPLLd8bqs23GAVMNuXju8t3TW2XjlrZ?=
 =?us-ascii?Q?O30290ckCcITwtzz2UI8yNdvpo7BBG1CCtzeYtm6OUghyingK/wvAaabk4dL?=
 =?us-ascii?Q?2BwA3Fti/HNZfyj9B9R+n8Xh0G1B3A2j6RuTkWLX8sLWrTG370zs6GVNnLWB?=
 =?us-ascii?Q?PdPb3A9zDLQfMC2sp44TJ4ib2NJMkLP08lUea3ZTFxV0qF6fi1s5fjFpKWiH?=
 =?us-ascii?Q?aG9EK+f+FgFHvb/nK0V1fe0i6y+ce2udPF3RdihbglFStncRjYTzVlOlyDj7?=
 =?us-ascii?Q?TZ6scOhKqHI7l4kr2FRFi/ZnjT66gDPf+bqZtBSm6XDLRocaqzaX4Co7brVe?=
 =?us-ascii?Q?Csb2E+po9sjW1y3kroaPklgeKXgbM//fWlBaTX0wTWMUMTts5UDfDfU+Ana2?=
 =?us-ascii?Q?nKPvFuvAMdI+tPbE4V+L96ZOhUZ0JW8a1aMzYaa7nTiKLXOMFxO7372bixfj?=
 =?us-ascii?Q?cZrYtYTno1w10aRlPGyyf6p0b6fREcny1I3w5bD+4jXjXov//YCKexG1gW9C?=
 =?us-ascii?Q?oNAavE56IaelZg4r1uSjSwsHzeDTulRuCk/ngpc+tlEq392jBT9DOIE6h9MK?=
 =?us-ascii?Q?RERX7jm2xuhTMNOxrUtjPI4IyAr2JMrzdP/p23slN2HzTpYvJXhljFbgFjUn?=
 =?us-ascii?Q?usfOJyitDkRYiFMIuuHxKW6/oGSzbb0nFHdVoHDZyR8Q1axrf47u5QmLt2pw?=
 =?us-ascii?Q?w/KIOQIJ/rPoW1lBj4e7NxsBJp9WjZxO/8lY8GJt7/+B/K/P5hYMMubT+vOG?=
 =?us-ascii?Q?Fzz73ycwSkKPCXhJ7zVXf1fxlfSMbyncAfvUoUGyH6yw2rWToIx48UPkLHqN?=
 =?us-ascii?Q?7tIb9+ld11DOh8Z8I7lOzB9TLkDiyWaS+0VG3ertz8cvCErPKfncXnZMv2Oa?=
 =?us-ascii?Q?SCPf26svVgdBY7BKdMz8qMoUt4kThSdzabxkaRORQtf2hjQGYKSyfkRDzBnr?=
 =?us-ascii?Q?x+88Y9cYZtqKMUiApHsnXxf1T6G8LkvQE+OYseVcMzPQudtZFHtUomLGPE5P?=
 =?us-ascii?Q?XQ2RQv41ohn7SlKD+8b8SoobVgnd4LH0MWfuNC4q9tnQ01w7t4n4nCW3McSb?=
 =?us-ascii?Q?pJHzpTaGQzECPyAC5wP4slqxdIV8g4yX1PljIZw+T3RBeJVNO4n57mkJbF/D?=
 =?us-ascii?Q?cJpdPkWyvPqJNJSns/0kTemG47mOZd+3lygWNIEIMCpk47k8qUHkJb37GMfR?=
 =?us-ascii?Q?ctbl0QKlJ4gbUFDPS/4YO6RLn9RCVb4yCZYmt9Q62BP98oWbC1lXR0nZyPGo?=
 =?us-ascii?Q?0+6Ri9PLgOCyNSooFVBkmZN5Yasbu8sSH/pUr23SNTJ8Jn0Zv35V6coYpxO2?=
 =?us-ascii?Q?5Xir3eyNeALCXRDZr+Ic3g5kGaJ3bcypeG9xjVTz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299b913e-74a6-49ed-a805-08dcb6312271
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 16:02:12.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgTMNvypVLtCwelWeCLiJQ+3/WEe2AWWJoKswbiu6tiAlrbaXSaPa29ysbdAr7QqK0noGlrZfxO4zhaZaCuKuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10793

On Tue, Aug 06, 2024 at 02:48:51PM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> I3C controller should support adjusting open drain timing for the first
> broadcast address to make I3C device working as a i2c device can see slow
> broadcast address to close its Spike Filter to change working at i3c mode.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

A small nik below.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/i3c/master/svc-i3c-master.c | 51 +++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 0a68fd1b81d4..4cdce25c5cf7 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -212,6 +212,7 @@ struct svc_i3c_master {
>  	} ibi;
>  	struct mutex lock;
>  	int enabled_events;
> +	u32 mctrl_config;
>  };
>
>  /**
> @@ -529,6 +530,54 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>
> +static int svc_i3c_master_set_speed(struct i3c_master_controller *m,
> +				     enum i3c_open_drain_speed speed)
> +{
> +	struct svc_i3c_master *master = to_svc_i3c_master(m);
> +	struct i3c_bus *bus = i3c_master_get_bus(&master->base);
> +	unsigned long fclk_rate;
> +	u32 ppbaud, odbaud, odhpp, mconfig;
> +	int ret;

try keep reverse christmas tree order.

> +
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0) {
> +		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
> +		return ret;
> +	}
> +
> +	switch (speed) {
> +	case I3C_OPEN_DRAIN_SLOW_SPEED:
> +		fclk_rate = clk_get_rate(master->fclk);
> +		if (!fclk_rate) {
> +			ret = -EINVAL;
> +			goto rpm_out;
> +		}
> +		/*
> +		 * Set 50% duty-cycle I2C speed to I3C OPEN-DRAIN mode, so the first
> +		 * broadcast address is visible to all I2C/I3C devices on the I3C bus.
> +		 * I3C device working as a I2C device will turn off its 50ns Spike
> +		 * Filter to change to I3C mode.
> +		 */
> +		mconfig = master->mctrl_config;
> +		ppbaud = FIELD_GET(GENMASK(11, 8), mconfig);
> +		odhpp = 0;
> +		odbaud = DIV_ROUND_UP(fclk_rate, bus->scl_rate.i2c * (2 + 2 * ppbaud)) - 1;
> +		mconfig &= ~GENMASK(24, 16);
> +		mconfig |= SVC_I3C_MCONFIG_ODBAUD(odbaud) | SVC_I3C_MCONFIG_ODHPP(odhpp);
> +		writel(mconfig, master->regs + SVC_I3C_MCONFIG);
> +		break;
> +	case I3C_OPEN_DRAIN_NORMAL_SPEED:
> +		writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
> +		break;
> +	}
> +
> +rpm_out:
> +	pm_runtime_mark_last_busy(master->dev);
> +	pm_runtime_put_autosuspend(master->dev);
> +
> +	return ret;
> +}
> +
>  static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  {
>  	struct svc_i3c_master *master = to_svc_i3c_master(m);
> @@ -611,6 +660,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
>  	writel(reg, master->regs + SVC_I3C_MCONFIG);
>
> +	master->mctrl_config = reg;
>  	/* Master core's registration */
>  	ret = i3c_master_get_free_addr(m, 0);
>  	if (ret < 0)
> @@ -1645,6 +1695,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
>  	.disable_ibi = svc_i3c_master_disable_ibi,
>  	.enable_hotjoin = svc_i3c_master_enable_hotjoin,
>  	.disable_hotjoin = svc_i3c_master_disable_hotjoin,
> +	.set_speed = svc_i3c_master_set_speed,
>  };
>
>  static int svc_i3c_master_prepare_clks(struct svc_i3c_master *master)
> --
> 2.34.1
>

