Return-Path: <linux-kernel+bounces-332878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB497C033
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9454F1F22271
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D10D1C9EC3;
	Wed, 18 Sep 2024 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B/R0R6F9"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013024.outbound.protection.outlook.com [52.101.67.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27161A2D;
	Wed, 18 Sep 2024 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726685385; cv=fail; b=oXTuE5jtDbaOhlrjVdYKliJWwQ4JW68T1U15mCInK0MrA4fyDp0FDrOcErPuw7KEbvNDCkoofjkMss7narbMxGtTmV9KBq7DmWBFEy4f5m6y1n3X/ZZA0556UC4VMVyRLLWR8qWe2vIXhFveReQ6h6gbU4fpWvNwo71UQ9VObRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726685385; c=relaxed/simple;
	bh=mQm/qOSZL+E04K0dwvitSqyVEcGKriu8Gn7kJ3nvXKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=glsdT86ROhqzlGekRRTvdQudxB9i/Dhs1HGJxX1wDmnegcb0nT+GSOlwEgCZPVhERu7pyPlJnUFl+Aub0HtMV3yPaSl7mUdSW3KwoSQu/DGsNIxK3+4jjvYXNToTvvFdi+8vtGeQhbGukweE3On2lWWaSbbgLEgdinWBYnVRzCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B/R0R6F9; arc=fail smtp.client-ip=52.101.67.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMej9DG0xAMHo4JzH69vfH3A1ys/I3X1ltE1kNfcUu0uMAHNcb1J7cc1Puxpczm224yw/dImqK1TPbOWLBL4eGna4ceth/6cQpIietHcKeemLMN4GankYgiMgjCcqBZaqRGKFvsXvt9eSi8xYbI+40I30s61sFhFS8oM5cxy2j0uavUO3/onDWrxDLZtwY8z1SQuU4CuyTFeCTx/AAhsG84KI6cX77qPGVSwPi1YELj1qlj8iBUJJ1xg+5BQ+UeCu5aaD9MigooCZJwIVCRJcCgjUoO913zFuhQpwyHQy6M3KPzoPIm3iziElqFpAOHbZPUUuwhjwwi4/xiWTBQAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6SgqfLBvlzKRpcCAshK3mc4iOE9yKTQGroAgWF1Dlg=;
 b=M9FTgJ7Z96b0qNkWJUqLAxwBs8COqqqs+F+aWlRCeh2Q5Z5bNDInMHE0Pn9iO600Ns6fy+XffV5Rh/N1FSeIqkJVJhzNEVPV8BPNhwrFWOZoUJxIGwhOhzfZYXZ3dc5sWATgPSR6siFYN6hYyhwtXDlSjyIMTg7gPkkcR1GW8T4Hf7NTlOH4TycsjiogMr05Y4BdXxiWV86bVUxF/wVG/0dELgdX9tZCmmMyVJung0PGNzVcperoYAbMYTqypz7FdCbPnWbe6ateSWz2fVfwnxqEwZtAPNijs/CogmvcpVRnHet1LfLuK8a5/nZF4KhRRc2E7yL9tX/s9STg649uRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6SgqfLBvlzKRpcCAshK3mc4iOE9yKTQGroAgWF1Dlg=;
 b=B/R0R6F99LFm0rvoUvv5lEgBCCBjAu+KvnDvApqovGfAcXcAYKCuG3yGWmhNpi4WTxRHjRkSqlZ860vBMEqa+lNfj8umMMh9844cb5IyQK8urLM9VkPRlw0N8QovLBpEzymfQ5VhcaKax/1/ZriZKxucYJNXBQ0PPnMySg0z9Yxg9T8wM0OsBmJGO8OcdIGccZ6nmUKgiPoS2nO3kaBiEBFpA0vlkgjdVPmq8M8GKY2+YSHADQ+L/pRyka5MykuF0VrqQsSg4QK0+yMQbUHwwcTbqjWpA7THshX1IRkL9k8VMbH+MiWN8O3L+XdrwINLRsTu9CS8NFMYY2mrycAGqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7808.eurprd04.prod.outlook.com (2603:10a6:102:c8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Wed, 18 Sep
 2024 18:49:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 18:49:40 +0000
Date: Wed, 18 Sep 2024 14:49:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: dsp: fix power domain count
Message-ID: <Zusguvhu+pld8UOi@lizhi-Precision-Tower-5810>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-2-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918182117.86221-2-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: db209284-2279-478a-f5d8-08dcd812a6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DH2j5Qks56t3iPbf9h4VvMWBnI3JJMk9O6goOxIdm4CDIklsbIqDB8fpMrwX?=
 =?us-ascii?Q?PRlhH0t8yFyJA9SbDZ8d4cjDpKYrhVvXHGwK5AmadMKhhL4X3Fx0JC2fpWBa?=
 =?us-ascii?Q?Uk6QYnlgKanGmCTNi82l8fwpUD0ZiTbt23fV9oFIB5haCYPWWtJFkz6CwN9Q?=
 =?us-ascii?Q?89Rq/W42nnVNIpdVqqqau4zWdw8wVSIPWkwfrvpDFu78H5eis80Rzek9jr37?=
 =?us-ascii?Q?1dB1/7at+dUJh9oaCt5Jt28G1U5YldukxpKOAoLeFi8GrgZ9ypYZeiQNQi75?=
 =?us-ascii?Q?KERuU/RmvBtnASK9cygnY2E2Q16bZNSho721P+3XIuf5eo/AjWdr0ewdVZqU?=
 =?us-ascii?Q?xKL3ybhSm4gm6S6jo7zrWrobZBHm7ocNJ7lEsei860db/ony2fd06plWIo+1?=
 =?us-ascii?Q?jv5/KYJCRd7LiXxuMHzQd/8Cgg4acoG6/Agqyh3dxAjtoSleR+pK6MS1X5Ap?=
 =?us-ascii?Q?2EbyP/ziPD19e0R72sHaVTA1cVCaQQPvRSnY/nsEJcrq+wc4YAKj9pQeNFHS?=
 =?us-ascii?Q?2cxlee0vhgcqxxO65/N3C/wGB0aLDyzdYq8lKSYI06KmtE9I+N5oZ6gv30gz?=
 =?us-ascii?Q?uMIHh3bV9BJwwGR9Q/UvCXdoSH3fX62Tu6qXnOTL2CqvpmSs7d3aV3CJrFkz?=
 =?us-ascii?Q?hsogTOZg2bky0l+ZkbHA2CYpyo8NbzvZlVY+YhSiLA2cDDG94dQuvJdMQA7T?=
 =?us-ascii?Q?B7o4jDYri1c0Ntalrsy/qqoCxQocPutL/HldfNej6q8NzHbouEptgpcooRmV?=
 =?us-ascii?Q?kzQaAN6W/UeGI+0dc3ZenxNnBx51b08+LTK7KtarocgPxCcEZL7yURo7a+ip?=
 =?us-ascii?Q?q/7hC66hfOg7urlAES+AG4ObZd2lLCe2CjL+AsYds/mFVkaU75ag0aHvU02Q?=
 =?us-ascii?Q?hav4xmCiqQiDWVk3U3ZpKerTAO4QOw0Cxe4g96q+Dy0r/+ehagBHWle/M/Rj?=
 =?us-ascii?Q?OG33+CYZj6+Xl3C8cAJ3nm/c7IYZeQ1j3g6Qh9tY/I0to5klS83cp9GLnUu/?=
 =?us-ascii?Q?+XhZmngIu08pTqUvyxKHoefN9JMLXAzEK7Qe9BGrZTCmbiI0fUe4z0M058LY?=
 =?us-ascii?Q?oo1cdAwDX54+dgW8H+NVCwYrkS7RvDgFp5vW+GYm8Yp268Yk9TkNjolD9ibW?=
 =?us-ascii?Q?aqwlmOxgUYbAyuTrFC5KuZOKEyUYV2NLp7o4zmYBuAoHaQe/h8zMU1zssSj9?=
 =?us-ascii?Q?1fXUn+jJyqHub/UES3A3BxaBxf4T+otPqwoWMdzNZU5iHO9gkiyWizlBscRU?=
 =?us-ascii?Q?d9JLyS+Y1SkGl6KMKYEFsTRcn8l5jOuReoBXEx0Z2prXHgf/ABnmiNSanMIJ?=
 =?us-ascii?Q?nrG4DelqwidiYMwS2J8NvAHPGayeIqFJfLsal20MuR6BmVtEgUCgkzXGpRym?=
 =?us-ascii?Q?t0Io5hQIm2jhK1Td95aEvojW06mpiA3qAo3dDlYZ4OSMQypwkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OPPHqmzV0zoUbd49fZTk5FFYciAFB0s7mrcjt6IPptJsZSI/0GzKitIfpJc5?=
 =?us-ascii?Q?FqvoHP32IRdNgJeMVxymeiHxf+IpQeo0GwVrkipIg7n5zQNcDtqVhmkAtisN?=
 =?us-ascii?Q?pSavi/Tj8bootGT9xko2pmuzhZokq601vrVUh24IIKTmL2NRzLswo47hHutv?=
 =?us-ascii?Q?6sCcSNuOVcsIh39Gr8Ci9W4UUNY6japFFX3bJYBXuwl/Z6Nz/TFyt5KyVykJ?=
 =?us-ascii?Q?vDawGMqioT6oBNKCylVDoq0m4yzt/1J5cHdIYAoa1o0ormpWKTi0AkjfnlFe?=
 =?us-ascii?Q?mVzrYSdiMBRhtA/uUE5rtdhkjYmOJlk2Hx9h8Ve/tgX3euheXoXEwR+rjh4y?=
 =?us-ascii?Q?W+g4CwbGBbrN7eZsvq+O7XdRfluwpidebLP3RSBXyVzspvtqYZOgPCs77/AH?=
 =?us-ascii?Q?z3ScRAznt/pvkyx+udfBmQyvPNVDLeaMkMRthxz/YYF6m39kLC5zCuB8+Tw5?=
 =?us-ascii?Q?MyO6FqIms3jesUMjfHBUcqmJfSAM46zJ+GJ0vADTZU6iN0v2h2TJQKOVxpLU?=
 =?us-ascii?Q?iM30ZgB83bdME+QAe4v1WF0sz+HPWhJ2bWO4/wBDT4UXIVdzZWMrqsQXIAqJ?=
 =?us-ascii?Q?Auor1NuZrHcGbcNc3So8oAHpc9QqtGDazX8iuh0+QDmF6AkErOTDB1uwDJDx?=
 =?us-ascii?Q?yxtSk1QO3gCE/GJCetUpnA+dcKCrf/fzTg/wLBMvnbK8hfH2Qum8OaA1TNeT?=
 =?us-ascii?Q?IUmMJM7g3bpXVxrCfGfZlCa5kdY/QN9YnZT8GUJ0/MvMeSKgWSWZnmRSVk0a?=
 =?us-ascii?Q?gWLeb7xy7XbwZ1J02/ok7ku5dZ9NUt5opmgiS5lCgpOY4ZYtzZpKHcFi2D7w?=
 =?us-ascii?Q?rcqXd+O6vuApphdo/tYdtiQtzP6NgRd0pwvB5DzbxBpNprfbwGI9gd53G0mP?=
 =?us-ascii?Q?7jRwYV5DuT5ynUVxnbPBsiweOq8I52imlXG0C/trzguE05IQ8FMWGjEoj6ir?=
 =?us-ascii?Q?7+L3f/HA/T5wM7+V1CdVr0AgmL+yNyBngqf/614vZM92PTW7+BicOPhjhYn7?=
 =?us-ascii?Q?IsluZN0C2eVerRsATh8qrdzPH+HWdClo+fHoJjC0vDA2miDvh8qlsDF4bLTo?=
 =?us-ascii?Q?1iLaAyrSNOuuozr+U/DLhwy7IECtfMwAng47zPiFvocw++Ox/kBslsITe/Kc?=
 =?us-ascii?Q?+j6Kaypu9qXOB1xKgQRP4MZc4IQ8hWKgDM+qeelTsoMFygyxz0ZPo1jMuQH8?=
 =?us-ascii?Q?o4qNJMGgT4yz1gvMZmsSXa9dlIjmkHK84PSLN7DNDEli4e1NNOhZTK9JWENJ?=
 =?us-ascii?Q?81OuDn9k62RyjAvUvY0DgKBuAsSso7F1gCLLbV/CQZYiYAhxowGJNZlNq/m1?=
 =?us-ascii?Q?V5tCqh1i7hGKE9wfZWsj48xXIaQw/KJYDyzvfHcwTYDyTac2b/Xs4kB6iNe/?=
 =?us-ascii?Q?XWcnVz8ZgIdmSnbvTjuqp4IvwIJ4UraGw8Y+uyUyA1tPh2pKzm1MGY6aY4rM?=
 =?us-ascii?Q?GbjkWtS6oNxTCSN2uO/KFoEwYPPExth8FuzJwqit9IEc2lSAZGjLLmu/8asa?=
 =?us-ascii?Q?w3aq7v5QHCoep9uWrhqjN+IHhH28SluMyMS7M4D1h2bW6nskkU3MIWFP/J4a?=
 =?us-ascii?Q?3aioB+gwKqz1yxYo/Ig=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db209284-2279-478a-f5d8-08dcd812a6e8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 18:49:40.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iS7NAKhn/N4Nw8ph+222Kfy5/bH7TY0PhN+pY3ngT1/W5Dq2DkwHAEdbiVtWW0xR33+7bbPaczg72PabvBwXBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7808

On Wed, Sep 18, 2024 at 02:21:13PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Per the current binding, QM/QXP DSPs are supposed
> to have 4 power domains, while the rest just 1.
> For QM/QXP, the 4 power domains are: DSP, DSP_RAM,
> MU13A, MU13B.
>
> First off, drop MU13A from the count. This is attached
> to the platform device of lsio_mu13. This decreases the
> count to 3.
>
> Secondly, drop DSP and DSP_RAM from the count for QXP.
> These are attached to the platform devices of the lpcgs
> (used as clock providers for the DSP).
>
> With this in mind, the number of required power domains for
> QXP is 1 (MU13B), while for QM it's 3 (MU13B, DSP, DSP_RAM).
>
> Additionally, two extra power domains may be required in the
> case of QM/QXP DSPs. These are IRQSTR_DSP and MU2A. For the nodes
> using the "-hifi4" compatibles these PDs are optional, while for
> nodes using the "-dsp" compatibles these are mandatory.
>
> These changes reflect all of this information.

Can you wrap message to 75 char?

>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 62 +++++++++++++++----
>  1 file changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> index 9af40da5688e..e2f016af1048 100644
> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -51,8 +51,6 @@ properties:
>      description:
>        List of phandle and PM domain specifier as documented in
>        Documentation/devicetree/bindings/power/power_domain.txt
> -    minItems: 1
> -    maxItems: 4
>
>    mboxes:
>      description:
> @@ -97,16 +95,55 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            enum:
> -              - fsl,imx8qxp-dsp
> -              - fsl,imx8qm-dsp
> -              - fsl,imx8qxp-hifi4
> -              - fsl,imx8qm-hifi4
> +            const: fsl,imx8qxp-hifi4
>      then:
>        properties:
>          power-domains:
> -          minItems: 4
> -    else:
> +          maxItems: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qxp-dsp
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 3
> +          maxItems: 3

I remember only need maxItems, if minItems == maxItems.

Frank
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qm-dsp
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 5
> +          maxItems: 5
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qm-hifi4
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 3
> +          maxItems: 5
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8mp-dsp
> +              - fsl,imx8mp-hifi4
> +              - fsl,imx8ulp-dsp
> +              - fsl,imx8ulp-hifi4
> +    then:
>        properties:
>          power-domains:
>            maxItems: 1
> @@ -157,10 +194,9 @@ examples:
>                   <&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
>                   <&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
>          clock-names = "ipg", "ocram", "core";
> -        power-domains = <&pd IMX_SC_R_MU_13A>,
> -                        <&pd IMX_SC_R_MU_13B>,
> -                        <&pd IMX_SC_R_DSP>,
> -                        <&pd IMX_SC_R_DSP_RAM>;
> +        power-domains = <&pd IMX_SC_R_MU_13B>,
> +                        <&pd IMX_SC_R_IRQSTR_DSP>,
> +                        <&pd IMX_SC_R_MU_2A>;
>          mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
>          mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
>          memory-region = <&dsp_reserved>;
> --
> 2.34.1
>

