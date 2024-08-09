Return-Path: <linux-kernel+bounces-281043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB34F94D24A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050B71C21680
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3695519645C;
	Fri,  9 Aug 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tp24CoY8"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB9197543;
	Fri,  9 Aug 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214268; cv=fail; b=QiLABaS80Uai63nXub+YUjArkLrqGC0VFuAm1AsQDp3kYLEnsUZwaWAGukxiLksXZOyuuxbOCa6MqIGcYwH6VsDBOq/o/DWJctAagK2jKx9G3voVFUPTJKqPypNn89+FEjdLASPa8acSZAbfhNfxKWVeFikqbRLDGYY2A+fcDuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214268; c=relaxed/simple;
	bh=lAE3Bxinh3AExc3W/EwkltLCtK5GGptSS8F8Exe9LtQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hu3kVQ/sAGkHuzb58lUAHTWWxAv3HLLU+CURgb5qkjUtGWlMtbWpAvUxrrkVeshH/uDKIieo1tTMzNRdE5+Trsj90MvSxyc7RfA0WRNQ+aXF8wjH2PhYq3HWjVcGIrOYlQa96PNghEHkijoxBimQ+OEMLFLjT3G31AopcItdSms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tp24CoY8; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtXn6fPD1jRPBvWdxj2UX37yJGG/j69z7ftT64kRG/hqtmaqwt5Qzxq7TyUbHtI4Pxa5Zm23sGS1x/v8NBJFNCBqpX0wr9gf5n9ZETjh5FJlZ1An8eP1h5OC/rNhY9agfXWlGDz50P1PmZEe+dmF2cRm6lhr3X8gkSuJ/e+a/ioEO2rn8+lhARCG/WLdCqgAWMosnlMe/2k5oYv6ok1e7X5VwVBo8yFviTHiwa8ZqWZkCvH0hRPJdCrHer4QemCRxrnqyIJ+ydbWjLtthMP7NUKZFZxgX9xuyo3BcsMrmBjXPMBvzgmAaJXDRJ8LpHr16RTdyZCg6oRfO+86UOsdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo4HNsyGoYTW6SDmWH6DlHI0NxO/nUoECEB6bOrHAdM=;
 b=H989N7q7bxV7aPF2qUAGH7AKc+aN1bAJn7Q5yqdYK3QNKPHO6t+OYtKSZ+m9pbL3Ij0qqjAJ/ZuX37atIoDoY1J84iZs7Bbz4cJ4QhFGkbLZpH3LruaPqMCCvRioSqqmvKdbATpmWhUGrdJa1l1RVslJJ0ZD1mKdfBXkN/Hn4B6gDj/Z0/HIHMURdLlBtQ524O87JM+n9nnhefP1/b8S0te4VoYKufjniGwcTsNIt7vuK5DjkrKuE5qaFx2Q/xpbXK2SDABYSWReGN9TbCKGkI0/RjXG1uEhbMAIxfZ4gRV6/YfDOWTaycRj5Y6lqv24bzVuFjmYKhHwfQgyZETGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo4HNsyGoYTW6SDmWH6DlHI0NxO/nUoECEB6bOrHAdM=;
 b=Tp24CoY8MYEnGJe7+WM2C5Jj47k7W63OYqYxzZUP69i2uFSdSdC/AMLogYCcid9Ct/EKk/6/g1zT6gPUnAsnXqRnDsap1QEVSFnagibRMbEnYzdB2FHRdpRnnpaZlBOUHf9OaVI1xpTGmsF96wH8034juEfl+UH+h10vhK5SxmHlRt5PZ+aIXQfmlSuSuRyOrwDYTFk8kHmTB3yxxrHm8owFvVYP475CgbGtnKKloqLvaPGNSu1GUJ9arxoryDpAblUppN2zUjioolS8RW6JpWN3BJJkgE6eFdRWtBg3MaYVD4OB10Oco7AHj4tQxg6Yxz4lE8ffadq83NnukfC4HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7009.eurprd04.prod.outlook.com (2603:10a6:208:19b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 14:37:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 14:37:43 +0000
Date: Fri, 9 Aug 2024 10:37:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso node
Message-ID: <ZrYprqP25WXfYzj2@lizhi-Precision-Tower-5810>
References: <20240809143208.3447888-1-Frank.Li@nxp.com>
 <20240809143208.3447888-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809143208.3447888-2-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a210e0-4abb-47b1-57dd-08dcb880d3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eOsrenR36TWpRF5xLO5fSYHhRcoWyQjjTrMj9SfQb9S59IYVbDK198VaSCTB?=
 =?us-ascii?Q?31+mHs/2E4ilJQsFxn2S3KFfrZsPkaXbzT4O+N/i6Szs7yZ3DX5+rdptRBUS?=
 =?us-ascii?Q?L2xY2A0Bmzlb7kRjnTd4xIeuuGlKpsXwPOV4VyCbf/QTS+LfDZwgj1gGS0/F?=
 =?us-ascii?Q?HnMrCPRznNUW6TnDkYFWpL/cH0ght/I/3rO9fqo97MUImD7RWTjKi1YZlXti?=
 =?us-ascii?Q?Nq13zSXFhYWf1ZKxJ5ys6M7r80Kd/l2jALXcUWPnmPV4sUsWdCWkrMWWcE2m?=
 =?us-ascii?Q?eUSz50uMCK8TH9cYVlNLh12Lu3gGcW0ZH3fY0MnBy7uIqtPd4nPHqPyxEg09?=
 =?us-ascii?Q?R9fZC9LbpWdiaBQdLdqnQ/ZwB2ypou3mDf4QT9CWPkgKgts9f/HJo+h/3d09?=
 =?us-ascii?Q?Wfo9kKowjqcGevLyBFd8rL/LDtQoqKptd8Rxyybifw7Z1dy5OUBfLhRgdVdq?=
 =?us-ascii?Q?iWWDsCRI5dA9xULYYo8TSKqXqux2/lLWSHrq3M/PuREErRkMOeBIGSFZafZA?=
 =?us-ascii?Q?J6RYCqqth8xJeMSKOyZWNr2CQt7ysgBaNOrfC1+oaiXsnHjD/H05fmBHaqvW?=
 =?us-ascii?Q?0ip04s1o9zet2YaCFrwr2jW4/t0jsXPSISUjIGUz/4J0czwFXAZh7PcXPQq/?=
 =?us-ascii?Q?vzu9l8o2KE2RW8a7c9sINUq5Ya7a7W/zG1onwEtGhcChxvZK+4728usJfEYS?=
 =?us-ascii?Q?oAf6PTcjdMUUjtu/WBWvvYJ1Zq7AqezarKjuT08MvOwNoTqDJnngkteOUZso?=
 =?us-ascii?Q?1hYHtKjEuWwwHevufGYihdhju3HYIl7zo5/tR5kVyVg/EImPNXLwEnKNh9b5?=
 =?us-ascii?Q?2LXYRXDz/8SpeobkNLcWjY+ffwy5JArc58JSmfs/0rOnR7GXIUKbMErix/V1?=
 =?us-ascii?Q?tPaL7vGb1KtJGSrPE9kg8DLE+ucUksnIuHFQo1fy8rV5Ix4GgQo4Iymh0nR4?=
 =?us-ascii?Q?KzfMm6I7eVga2iHO/HiJ1bnk7Y6TNGMVuztflpHJP32YIrKGSEoTEASL1qQg?=
 =?us-ascii?Q?7G74sICK0NpcX829ANMLQm3sqCdNDWDGMpNNqC6MjXT1Tcw/nEg3bSaF938E?=
 =?us-ascii?Q?PFzJy3Y8hQZQwZ65kiIVF4AURHPSs9PmL6GfxXDCONCbNUZf0mFb7KB0JFZp?=
 =?us-ascii?Q?Z8FAEboW4i6ldGO82WBUp/dbtsGfXTfKOn0dJI/k7Tnb/FIAWy+eb8KBw27B?=
 =?us-ascii?Q?bZEZj5lSnsUIMMm7MweVxZoLW4KJ9dbbuAAo/9r3A0evzT+cMZbsVy+b/qKJ?=
 =?us-ascii?Q?MiSBkQowW1ncFhwRUIAFKI/HxqMjD16SaTxZqNvCLOZRqsvUPj2yIqCu0wls?=
 =?us-ascii?Q?H/m/vv+siM7rK3+dNs+BJWR8AhPoS6DochxUXVv9343iHyzJlCmyEaAZlacz?=
 =?us-ascii?Q?okQi8xLoaH4JDY1yTYBSukf82kWN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jxw9SlpVu0fTsv5pVpS/YVFkWiXLJFHmPYD3sNnDDi5o1ptGCL7lRzVGGVxt?=
 =?us-ascii?Q?Yx4KIhRijbBYtehxwFpkxoZ9xEfA4UYmAlPbBzcVl8ZdYcgkRQ93hvmButpb?=
 =?us-ascii?Q?aFYDSmXKUnIWoo+5hjZ6om2y10j5Y4L+/nZ67SIJmJcTG8jpEKIteVBgYQii?=
 =?us-ascii?Q?IvII7ageaahm2I+X/MNSm65LNGd0xs+OHpMkcKa/fKb2bBjIErscDi2mmMTB?=
 =?us-ascii?Q?/xc+hWSE9WnC1/Se8a02KDjUzGxY0qJGc2o6hMKvcXoGuvxySzFTnlhuWnQa?=
 =?us-ascii?Q?0TjiJnLGpfCQDamS8zIAmeFx2ujv4RTD6ZZ7SOCaZNDRd3uYizMAjGsz0D+l?=
 =?us-ascii?Q?k4sJ4HT+EjLgojFcSixEudYVLmRbk4WGExIl/b+zvCPfHVfWaQRi8baqoXzx?=
 =?us-ascii?Q?09ptTya956epc2Ft6RViSBUxbDznBXY45/HKyMQxrde7t9y5x3J4JIh6DBB2?=
 =?us-ascii?Q?4u4Bxw5XxELG/XMTZgHTMsyauV7ddbRsnqzyrVw9fUmYcruy8ZNeena9l2aQ?=
 =?us-ascii?Q?qNaS2N3FVMwHrL9szSCosLZKdw26UfgYS+2pRSC7kMi/ehzn7Tfi5xyYOZQa?=
 =?us-ascii?Q?jfBK7GFZlrL8HPb/Qn/3bqayUU5xn2tYhbYd4FGgyCeKOQEi2PhgpcB47tD1?=
 =?us-ascii?Q?XdDQ+K4jsugXj4RlprBlX+Of2KNwdU7lui4aK8Rj/b2OV/f5aFn9AGGsHpeS?=
 =?us-ascii?Q?KqOIL0/VGmTLVGoUubqDt97pi78FFK9PtfK1j6tJED/JH6y9Zvwi9fNuSqe4?=
 =?us-ascii?Q?gIcLBZKXrA0HRlt46mscy3eNfgeAF9Q67nIDPPVVbabPdVEf0Sjghmt69MuX?=
 =?us-ascii?Q?AEtysJzpkLX6iCXf3yIdVDo/fm13xJHFwLcnxfRtz418dHV6shDy5HFyhEuB?=
 =?us-ascii?Q?ABv/nglFrky1GD+GZEv08tVZpP1wpA2aeK7P+AHlXXsNXCk1hCjYbtMou1Qi?=
 =?us-ascii?Q?aoehj3DMvfCnn9nlaZ9Xzpv09QVtqwKQo/SmQ6GoId+wErVwOfA9Zbza5IR3?=
 =?us-ascii?Q?bDSmOQQEZE8duMO5YIOcDdzhuX9dpPUu+m6DsWGtoJxKfQ5HaJ4V8j7ofQM8?=
 =?us-ascii?Q?ociqLF6WbMrp5XDTOPrgXcvfn+wfAS5nGfdJ/AfX6930W+13NyrFiCfmJqDd?=
 =?us-ascii?Q?5Eyy5oU9VH+Df1vajcDonUx7NbADBro6r6sidWuY2bpE00rhlyvVFHgN9XFX?=
 =?us-ascii?Q?8ZAG+oa3MH/HUGkmv9qlL23fgOvWDT8bdEwMHAVGYqcVlA/dxmtEZd5Q7Jcj?=
 =?us-ascii?Q?XhAKkfjxXXAEYDfcB/HsAWjPWEAW6Y+ku62ZDjXRMMxYlH2024XlBwdGCVN8?=
 =?us-ascii?Q?kfIgtp9aoLjvqhwrc1mogwvlMQ8tNMPh4Lmuh0rxwKUNc0xGMl2Z6aSNeRWd?=
 =?us-ascii?Q?wegnqWpXHFqcnki6OLDdDce9jdxJMJlB99uyAceb8/RWux6vPCiJFS6F2ZHQ?=
 =?us-ascii?Q?OCFzLrx2XbybYJu08eECb9XtxgZQH8z+ievD0mCL1vpfrWRQrhvyeyRs+WPX?=
 =?us-ascii?Q?ue2P+rte12/6Oog6rqeUK6uEThexEbNnWglqXiN24w21dHZUvnPyhB8A3vRh?=
 =?us-ascii?Q?8ocCy38IKENAMi5kIzXoYjPnmMQ1OZtStNVQP8X5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a210e0-4abb-47b1-57dd-08dcb880d3df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:37:43.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOIsAwG6Xa4FHk34MHAioTTvrLb/MmC9k4HlteeZmIs0pPcpjA+0PM+pE32uCIxjzHDNmzl8r5PHFaFyz/xclA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7009

On Fri, Aug 09, 2024 at 10:32:07AM -0400, Frank Li wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> The i.MX93 11x11 EVK has a ST LSM6DSO connected to I2C, which a is 6-axis
> IMU (inertial measurement unit = accelerometer & gyroscope). So add the
> missing parts to the DTS file.
>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sorry, this one is sent out accidently at this thread. It already post at
https://lore.kernel.org/imx/20240808162157.3323811-1-Frank.Li@nxp.com/

Frank

> ---
> Change from v2 to v3
> - remove reduntant address-cell and size-cell
> Change from v1 to v2
> - update commit message.
> - use common node name.
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 2597c5b2eacb4..e845ad896abeb 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -145,6 +145,18 @@ ethphy2: ethernet-phy@2 {
>  	};
>  };
>
> +&lpi2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpi2c1>;
> +	status = "okay";
> +
> +	inertial-meter@6a {
> +		compatible = "st,lsm6dso";
> +		reg = <0x6a>;
> +	};
> +};
> +
>  &lpi2c2 {
>  	clock-frequency = <400000>;
>  	pinctrl-names = "default", "sleep";
> @@ -504,6 +516,13 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
>  		>;
>  	};
>
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins = <
> +			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
> +			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
> +		>;
> +	};
> +
>  	pinctrl_lpi2c2: lpi2c2grp {
>  		fsl,pins = <
>  			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
> --
> 2.34.1
>

