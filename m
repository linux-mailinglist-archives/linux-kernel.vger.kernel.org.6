Return-Path: <linux-kernel+bounces-330847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DA797A52A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF831C256E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC0158862;
	Mon, 16 Sep 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hcto0sI/"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A10158D80
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500057; cv=fail; b=qxNnVOBgu2wPhriNzmxMh+I0WYvDghRSC7YOO6+sqnHzGLEKwukXysPhqFeH9SBivEeJAEnjvCiNDDf9OKnB6jAb+lmYHe/rH4zqifgAw4WK2doIdAqzQDh+FWjYCk7/t1EcM45dkKfHb40ZKQjSp6kTZ74M1vU0pBj/GbfYP4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500057; c=relaxed/simple;
	bh=i+Gs3mOLvMInOOQnWpJHbkeDHA4VDr/TKTxwCIX94do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mrerVEzdctgV+XF4MPYIbvSvtFFKgapSPbxs5M2X1QhRA7/CGHj3E/rOoNF4dK0PSop+tXOhgz+F3V/aKAeiADmsLj5fhQGamOSyWSu1Z9JdjMmisYiVglYFoTKNPyvXAtIUuxAhEwKn7IBk7vlpq5pZNizFQQLHv+hM7uQ5Q0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hcto0sI/; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RImO0/Wn6B0xUoGwwQDUdrMYWtdB/vzk0W57472C+bWmPx3wwexdvljl7MQLTw6wnvizy6Pv7x6PbNt4/K4g2uCTAs85aA0XALdZCzt+3VYE2eO9U4znj0Mhs2FZ3SZ4ileOO6X01gLhObbNZvcPGi/p02a164WkqhIsdcZTz7LAee7LTKnZdYo+l+XjpTReOkDTnHNmlOxwba8E8M41+1HLtl+gLFN8zI96uwqVeoUc5iAvpdbi/qEDfgzfPA0Q9zXlC1lQA/f90y4BArdj8dH/IvUk9r84JcyrJZ31cdJAXCxe8vC2Ns5SWmhQJGZ5twaTxILDXC9DS16RZIbdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRkG5LGUW91vpNjSStcgx8l/OJnfBjrw9Cis84KiKbw=;
 b=emOtsOb6RkDzvCWwEofMNCJ4kFT9XW8HbXLRDjNcLZbdz5YA+I50G2FR4Fh7HyhEptqJ0d9ngVMJ1hwlhiHVQ6cW9WkMG6BT54RRrcz/ChaNGBkgkND9TSMDRRkEYpDEZAtZGQ6OB+lHBgvJrp3vKzz3cs3F1L8TItLPFwF1Nq/BMxpXz7GwhlQIwptcVAAJ9xiswypDgVQvwBGmBkLnxk3BG19FYvtZ/wTMS7RuM5Mys8tUg/OQwPYT19CDr7uIV7h+Dl4EhJQVPPfsCml7OrsTOOgvxxGSQ3DZP2Zn+IrpZvby0O5rvYq/q8pU+iw6wiVU5mCS4l+l9plKY/FGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRkG5LGUW91vpNjSStcgx8l/OJnfBjrw9Cis84KiKbw=;
 b=Hcto0sI/hI4/Mmqk6RGUPbXX7K86HwiV3mNr0VXUjZ6bT6MMTO6D3rQRhA6ta1a+jYrYN5isJNqTiOpFt9aXfBYIqmwokzDTmVgfaoGHzIrS71AVTzT0SsFaE5F9U7SUgjCqF29kAHNFXif8ADk3n8cz0eeVeqGw5W8H1FvPHvPyNB8eOIuEkHLN31fSSZvojN2mXsm2VGcKAI2F61gYZZ3amdatuTGHiGDF2p4mgOF+xP5TI3VnLltlmmmD2v22wrNCDxPwHi2Av/AaCHsru6h+Zk9KxF3iQrYG5whTOOJh7IauZTMRoX2wPg0ubBPDKqEgwgRG27vTTq+r+Ie5aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9557.eurprd04.prod.outlook.com (2603:10a6:20b:481::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 15:20:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 15:20:50 +0000
Date: Mon, 16 Sep 2024 11:20:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: carlos.song@nxp.com, alexandre.belloni@bootlin.com
Cc: miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: Re: [PATCH v3] i3c: master: svc: adjust SDR according to i3c spec
Message-ID: <ZuhMy9G+Xp5ySgC5@lizhi-Precision-Tower-5810>
References: <20240719080233.842771-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719080233.842771-1-carlos.song@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: e68c6a79-caaa-451a-bff9-08dcd66325c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5UQjztIelkjmpSPQDptLUJEYBh4q3jqacth70BLmxT2NKLuknaYt1zTEAnF9?=
 =?us-ascii?Q?g0UEmOCcTdSWXLkXyydxUkHy2+CIOQl+JL66ev87dSImKokjdmiF0D2LpKY5?=
 =?us-ascii?Q?DlUPZGQUisL8su6MJ05b4lNqn/6OrO648UtopHSBw+d+0nhT6pZN3Qi5FgK+?=
 =?us-ascii?Q?2WI5wv8/vAvTXu+Ws73SXZUUvlmkrIqcMKvB4bFRVPspwgGf4JFaRLNHjDn2?=
 =?us-ascii?Q?9JX4fPwxbiePnddDTtrK1kc0IKYRK3PVAtGQwcpUQAF+R2lA07WrJ947Kxtu?=
 =?us-ascii?Q?na88GDV+i304bT/dKwfCiprI9DgMtAYVZV+mTuddt8dmkIZ/s8qiUOqUaFs2?=
 =?us-ascii?Q?bDA9lX7pcTZOCSDXlPxINwZHAS/R6RI6pEh1rQN4uGUBM90+VXw2u6oo5AXr?=
 =?us-ascii?Q?MYPOp2x99OEoV1o41G12qZVAkBMK3cd7h47Z69NMkbQjnsAoCwgMFaVDwfP4?=
 =?us-ascii?Q?al2vvXRZ1qspH2MS2FE1nx0b8x4vV3M0NVDdqCnpLvb+eb0dMkzkbE5CZKrm?=
 =?us-ascii?Q?+7LfcvVqhdMUjV37Q8FWUXtUTQpR+GFcOxB3QtgEziu7tJIV6WVteYg+D79o?=
 =?us-ascii?Q?5n74uBx+iM1DiS1evhbIMomA3oxD7KRwZZT0pdr7FzOI7GE0o5ECC6cx4MfN?=
 =?us-ascii?Q?t8o7M4sXLEZh3Abhsu3oKf5rqyS+krixzVoeAPrsG6ZBXYc2JdKZ0OH5/+xv?=
 =?us-ascii?Q?5JJSlN0b48YrA/1dfuDa16sp6XKbdXgWYj0nc7VOTTv0ROVdQXxqI0D0lJbQ?=
 =?us-ascii?Q?Pboae3L4LewclV6YiXAshMsyfi8i56isZM4YNOwXFU9UhRzCppllmJ+39dZM?=
 =?us-ascii?Q?j1uYUTkdCMXO6m7kV/MNNWX5xI9JWt59VXnZpAPCamWhsMAVgBeGF9cAkoEM?=
 =?us-ascii?Q?QN8akaj0Duffigv6UQjsqsVlCXdvAKofR6yQInXSU586BlWb+V4T2cPgJxM3?=
 =?us-ascii?Q?v9k4XZNgYttfui1YmvOLg1Ts0EOI+jy89l5vi2sgPi21Z1Hkl1sDCLWW+sjK?=
 =?us-ascii?Q?Ozk0qcjAJFuyehrueY6jtfqtzrbZDSIb7b9PL7rCwP8oL5Tp3VEw1P+FjfYg?=
 =?us-ascii?Q?qH4VZQFwo9JkW9lt4yHTuLk/DGGnRcKLDnGf29kZfaOPkiqn9VKfHMov6ETq?=
 =?us-ascii?Q?uT1z+FIHt9wXu+ERzJia1w71pAe7F6b/s6grKVtNlQtgGDV0nOCC3vDgJJoL?=
 =?us-ascii?Q?8ozc9+96wMqBTIpp7omtyHAqCCV8/cjWLBJAEdf49L3BKsuuvaDBG1wwtAUN?=
 =?us-ascii?Q?6ya1caDs7y+LBcrAu0jevLHBYRzfd9XfdY+PJwfTZsP5Su+kj3kuxWPiJvIP?=
 =?us-ascii?Q?wUUiVJ1mnT13xAN50JrZFgR5E0Zoz6xbWFeGnEekveAxGE5d2sipoTqlcsBH?=
 =?us-ascii?Q?b8c1k6WY5xzK6I2N2CD8qcDwi6XIWk2M1czchFTASTmHmT5sHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fX18ukNqLc/OoWXdGJVeZIxlUJhtrD4C+T9JVzzwpB/EWx4ZH5X8efDvzu9M?=
 =?us-ascii?Q?fS5Xmx1yVb/pSeMMto/kCd8Z9Yn5AVE4RCBmmZpdfv4ZVDIK2BlfHfuJPdym?=
 =?us-ascii?Q?L4CbtiPbBZRfmTQmY0mOZvzug5FoJE/bUVGj9v0Nt/j+dZMSsCzuuA5tzORL?=
 =?us-ascii?Q?UsQVFYP8bIJSpsPvfSADNFyfkQcYXxRAumiJFOs6geffTBKvFn8pCDBj95xb?=
 =?us-ascii?Q?mXGAI6L3ysH8HozhQ2uWnD6HJX0u97mi1t0DKviH46JhanaqMM5YvvPZYJ0e?=
 =?us-ascii?Q?7RmyhOCmFbm4bD1PtPPQyzFLViAQukKTFFETq4guGqzWWFFQl0i6wK3+LXb1?=
 =?us-ascii?Q?3OkI7HP2KWoOKSdP0DXa47AZ/fn3Bl1iIFudZ7zyU6/PIJ/GaZa2+pMJp467?=
 =?us-ascii?Q?61aNQtu/zY8UUDmJhe1t10l9gEgzubeZk+ZOIk1Gk2tL3GtQDqBBKuYblHx2?=
 =?us-ascii?Q?Kmj3zkMnpNRhmLt0RQ4hLj/WW3DW1ZAHB5Z4nnPaTQAT2xQ5o2xC9CGX4pBM?=
 =?us-ascii?Q?h/mnsLzwRlUDFKQ2ttWQOfcnsKv49q4xzrHz/MucUTenOOZLyJQa7fksceQ2?=
 =?us-ascii?Q?UvFti8Dte4dsWiAeCwJOzNLw3nqwgU1+xFG9mYxCHptoNvtWvbTHgU+q6sUr?=
 =?us-ascii?Q?mXUy/+U5YBqy6yrR0eJdaueAqQ+ms5zEZrBUba/r7w1JHgVqt81+f377ltIC?=
 =?us-ascii?Q?JxpJdUkuD8jt3KM0jV4410a+gbN978m2ugY09f6ylM1O/khiYtFQejKFm4N4?=
 =?us-ascii?Q?f7+706LOrESff9bLsAMR5/OXG+S/z57vLbHtJPNJs1R+vxKyFQqbLRGx6Y6y?=
 =?us-ascii?Q?Zm5yb3nTu+/ik2UK9eoETExjbTMS6ouWy9AIycDomCp0GAV2+C6fDiLSsu5A?=
 =?us-ascii?Q?3ncS2N+GX/CZUjUOHvyJkEqA26KQ2KtWQEUZHDm4cI3gFXs2jodw5N4OnunV?=
 =?us-ascii?Q?16hjmf6YZlr4KmUxeuP1fEwYFvbcVJV4ybKKsjPkrVfu1i02uU6Mx2Go/D6N?=
 =?us-ascii?Q?2pnnad3caqo+On/ukz9UJNlzcfB6HZNwAcF1b7ZsApDOu4Pqu31dRNW0YaVU?=
 =?us-ascii?Q?F+bCjQrmvqXVCUIuH0KnlQIy4EytALEAzau7yUnxt5g4d+aFkFjqbqDsWhpA?=
 =?us-ascii?Q?2MIwLQjnzuTFOdZrmWbJmAC4LirSzOSph+8NrzT8ZYqb3MhlAhRZ3KSziFNq?=
 =?us-ascii?Q?9gkBwdmBUPJ+/R4+eqbqXnQnF26CnOWAjN1WdU+LDbQeZLpYgXrAAm6TPGS7?=
 =?us-ascii?Q?cSVGIUv9kNBBVxwPwn/PkAzBt/TXvCyeS+ZI1VXRW4dBZYER+VAjjAPHEZtX?=
 =?us-ascii?Q?A/Mzq9A9AyvXkbrg7QksnpNQcNiXtvbjum+W3LuMdY/WY17tp93eg1gL/lok?=
 =?us-ascii?Q?z2t/Jzz6Cd7yEi5KZ/619WIPcByZ/J3l4pCg1dWPg4t/t2n09M5H/dxTxTFf?=
 =?us-ascii?Q?46KTTYbAOxYryF7XUAw+/1UXBM6rpBsbIVCmaj22BHuKZVY3Hd20lYhXu4kl?=
 =?us-ascii?Q?weS0pHPTkzSwtYwsJBJA34eh7GBOPoh9zAXP78xvBVaFsG6FRx+HEE9Q4b2j?=
 =?us-ascii?Q?lguJlGXj+C+6Z9jmARQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68c6a79-caaa-451a-bff9-08dcd66325c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 15:20:50.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqe6zpJ99RP0iow5DDNpOdUZj4LiCbvMKUVmvQ72x33kO5ilIJGAsVnaqq25j1p4KWexWYgC6Hez9ntsWLYyHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9557

On Fri, Jul 19, 2024 at 04:02:33PM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> According to I3C Specification(Version 1.1) 5.1.2.4 "Use of Clock
> Speed to Prevent Legacy I2C Devices From Seeing I3C traffic", when
> slow i2c devices(FM/FM+ rate i2c frequency without 50ns filter)
> works on i3c bus, i3c SDR should work at FM/FM+ rate.
>
> Adjust timing for difference mode.
>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Frank Li <frank.li@nxp.com>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Alex:

I saw v6.11 tag, This patch is critical for imx93-9x9-evk boards. without
this patch, all i3c devices can't be proble. I am not sure if there still
have chance to get merged for 6.12.

Frank

> Change for V3:
> - Add back: Signed-off-by: Frank Li <frank.li@nxp.com>
> - Add back: Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Change for V2:
> - Correct I3C clk configuration and simplify the code:
>   Pure I3C mode and MIXED-FAST I3C mode just use the same i3c clk configuration:
>   1. i3c push-pull timing is 40ns high and 40ns low at 12.5Mhz
>   2. i3c open-darin timing is 40ns high and 200ns low at ~4Mhz
>   3. i2cbaud should be different between Pure I3C mode and MIXED-FAST
>      I3C mode.
> ---
>  drivers/i3c/master/svc-i3c-master.c | 31 ++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index e80c002991f7..78116530f431 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -127,6 +127,8 @@
>
>  /* This parameter depends on the implementation and may be tuned */
>  #define SVC_I3C_FIFO_SIZE 16
> +#define SVC_I3C_PPBAUD_MAX 15
> +#define SVC_I3C_QUICK_I2C_CLK 4170000
>
>  #define SVC_I3C_EVENT_IBI	BIT(0)
>  #define SVC_I3C_EVENT_HOTJOIN	BIT(1)
> @@ -535,6 +537,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	struct i3c_bus *bus = i3c_master_get_bus(m);
>  	struct i3c_device_info info = {};
>  	unsigned long fclk_rate, fclk_period_ns;
> +	unsigned long i2c_period_ns, i2c_scl_rate, i3c_scl_rate;
>  	unsigned int high_period_ns, od_low_period_ns;
>  	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
>  	int ret;
> @@ -555,12 +558,15 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	}
>
>  	fclk_period_ns = DIV_ROUND_UP(1000000000, fclk_rate);
> +	i2c_period_ns = DIV_ROUND_UP(1000000000, bus->scl_rate.i2c);
> +	i2c_scl_rate = bus->scl_rate.i2c;
> +	i3c_scl_rate = bus->scl_rate.i3c;
>
>  	/*
>  	 * Using I3C Push-Pull mode, target is 12.5MHz/80ns period.
>  	 * Simplest configuration is using a 50% duty-cycle of 40ns.
>  	 */
> -	ppbaud = DIV_ROUND_UP(40, fclk_period_ns) - 1;
> +	ppbaud = DIV_ROUND_UP(fclk_rate / 2, i3c_scl_rate) - 1;
>  	pplow = 0;
>
>  	/*
> @@ -570,7 +576,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	 */
>  	odhpp = 1;
>  	high_period_ns = (ppbaud + 1) * fclk_period_ns;
> -	odbaud = DIV_ROUND_UP(240 - high_period_ns, high_period_ns) - 1;
> +	odbaud = DIV_ROUND_UP(fclk_rate, SVC_I3C_QUICK_I2C_CLK * (1 + ppbaud)) - 2;
>  	od_low_period_ns = (odbaud + 1) * high_period_ns;
>
>  	switch (bus->mode) {
> @@ -579,20 +585,27 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  		odstop = 0;
>  		break;
>  	case I3C_BUS_MODE_MIXED_FAST:
> -	case I3C_BUS_MODE_MIXED_LIMITED:
>  		/*
>  		 * Using I2C Fm+ mode, target is 1MHz/1000ns, the difference
>  		 * between the high and low period does not really matter.
>  		 */
> -		i2cbaud = DIV_ROUND_UP(1000, od_low_period_ns) - 2;
> +		i2cbaud = DIV_ROUND_UP(i2c_period_ns, od_low_period_ns) - 2;
>  		odstop = 1;
>  		break;
> +	case I3C_BUS_MODE_MIXED_LIMITED:
>  	case I3C_BUS_MODE_MIXED_SLOW:
> -		/*
> -		 * Using I2C Fm mode, target is 0.4MHz/2500ns, with the same
> -		 * constraints as the FM+ mode.
> -		 */
> -		i2cbaud = DIV_ROUND_UP(2500, od_low_period_ns) - 2;
> +		/* I3C PP + I3C OP + I2C OP both use i2c clk rate */
> +		if (ppbaud > SVC_I3C_PPBAUD_MAX) {
> +			ppbaud = SVC_I3C_PPBAUD_MAX;
> +			pplow =  DIV_ROUND_UP(fclk_rate, i3c_scl_rate) - (2 + 2 * ppbaud);
> +		}
> +
> +		high_period_ns = (ppbaud + 1) * fclk_period_ns;
> +		odhpp = 0;
> +		odbaud = DIV_ROUND_UP(fclk_rate, i2c_scl_rate * (2 + 2 * ppbaud)) - 1;
> +
> +		od_low_period_ns = (odbaud + 1) * high_period_ns;
> +		i2cbaud = DIV_ROUND_UP(i2c_period_ns, od_low_period_ns) - 2;
>  		odstop = 1;
>  		break;
>  	default:
> --
> 2.34.1
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

