Return-Path: <linux-kernel+bounces-524365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CC2A3E22E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7411614A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F11FECD1;
	Thu, 20 Feb 2025 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bRoc1TPD"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB831C1F02;
	Thu, 20 Feb 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071883; cv=fail; b=tHLSohCFctFA9QITI6b+ZmQUMu53AGFB0xDX+iPSSPfXBdtSYT0ZcS89vDu9ZWaspnxEiw3UG7JFPSv28dyGpFznDyQgBjjWHE6Z2T53ENa3y0xcqWptVIJjqVcUz2fEJHcvuk6DVgCbJHsf2V56KYJO7N1NS0jIUXQXEOPSKXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071883; c=relaxed/simple;
	bh=S2jPpHrnopNoZ+Rm3PeLJGloNv23Y6sqStkdnN/azP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C2nL+2zHw7OcHMHtQTEDLW5oXFJtIt28fwmlBrKSxeUgWzjtKY82jpDVUuz1Dv9zBn/u7q4eBtB7cwgXaFce69B0viGo73VeDMahsNzThklF6d2c+mCLBbKKofRcifHQ7bIJwpOhRdiD9gM3n9xDDSlp6PeMtuRDY0nklJ6Fx3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bRoc1TPD; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4Do5hMXQIadjJxf5jGiODtZIHkERSaJ772fepjzwudwRc12lTv8WtpoHZ9pPIF2rrBk3GjV0hMQejDDZh12swb5GN7MeXuiILIzyGrcIB9a56OHXWNm1OX92y+ZeE4o4aYuo9Ct2C42GneN5568ANIjVenH0Eti16kLM9f6Oi9hygWYCQ0nSGRtrLRap1vn+r67HQ/Sc0vnm4GasZ6hqB32wR2CDbHgPkc7Fdc2LA+uXQYmPG9Ud8CtqjOdE/alFgKR28cCjIxjGLN7seZ5lyngYFYdh2GRcf/1P0tuN+gou5Z3WS+Z8IOkevRZIPYvVUO5JIMer0xSPEtEJMrSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=229YRbu/Oj3G8g78OTkzpLjouVK3/gjfeDxEW5h3pig=;
 b=wWvccTpnLpg3DBgG5EMPD9Herb1x0IrvxS8X9w4CxKqm05eeLuCH+m22CJ4fueq+dqmQ4grT5lLVNd2JzqKVZcnObBlrRAzVkuWeUyrwA1xGNzqBFsAgM91CICtgvHBS58mSZi61RPPyVa3J5td9aYIM3ipPLv7bJDT0Qofq1QUNNpKlRmdnQgxKydGEQW3bqnYQBcZUyWaVABDqy8LQL8/DgS4S8yNllY+LPFINtf1lFmZTM5dRp3dv5wD+t5g6Vu4P6LPfzTGX3gLWmQ2jxee7+c67UNXNW0WmZo241pypFp0klSkYVs16HbJpnfMxzpk1aE+p2F9v45ZNIp6dsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=229YRbu/Oj3G8g78OTkzpLjouVK3/gjfeDxEW5h3pig=;
 b=bRoc1TPDuOar/ot07k3w8h9IoEExE6h3RvSgp+OQcBYTpaMOEz2A9NBRkIEu/tId55SJg4Wzev57UKyLlzqEoBeMGAEMr1djH70QBfgG9iVBk2032kPXv5RFJa6toCkBhDg8sqVkiNPnG6uVqV3o6ihTFZrymbPgIELErxZWLM4FkuEEhC+xgU8G5EEqETd6e51EKdUH07X7jD3U91Vuoc5vWqysSS36NCMlFZGUvsfVJBzJ1gB+QOXv2EtQPoHTBQkyakx9mDg687QuuVHcxAXjz4JYYD3J+jb0iebRMdohkcgZlQUsR/YyTwPMDGKmEPFztS5K9Y6vP+HdB61ZUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10225.eurprd04.prod.outlook.com (2603:10a6:102:467::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 17:17:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 17:17:58 +0000
Date: Thu, 20 Feb 2025 12:17:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, robh@kernel.org,
	shawnguo@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org, shengjiu.wang@nxp.com, peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Subject: Re: [PATCH v2 2/8] dt-bindings: dsp: fsl,dsp: Add resets property
Message-ID: <Z7djvOCrHD7pVBj3@lizhi-Precision-Tower-5810>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-3-daniel.baluta@nxp.com>
 <f69d6076f5b41bcf56ddbf24a72a600fa51466dc.camel@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69d6076f5b41bcf56ddbf24a72a600fa51466dc.camel@pengutronix.de>
X-ClientProxiedBy: BYAPR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8390553d-2b26-407a-7b92-08dd51d285b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgZKhDmqvOvZ5Skkt/dFYRyPeYhULo7DKAMwFi9Iqn0/TaX6c3RFaVsaIvzg?=
 =?us-ascii?Q?QrvhbUkw1ECf5uV50W07/7t5ytx98obtwyIOvml48tWl+0z0zL0HW8GqYIQ2?=
 =?us-ascii?Q?7BG+KtYLfmPf+8T15k7aszPNWvQ5BTnBTeI1oHRA2z97Jav8TsgMphAru6QV?=
 =?us-ascii?Q?ykjFw4fskN9YkPP33NN5vS2djaJ0UVzX2oRJMwcVn6rqyx6E80Pbh6rjxVwV?=
 =?us-ascii?Q?bgD67ryW5htMAGeJvj8vCRWr0VvLXARZ68cllsP9TZWZbhjFg6Yj7tV78b0f?=
 =?us-ascii?Q?5kkHcSXic/mlP9awSJaQ5bWIxZngthd83qzpbnUTSO15qZldFTtG8twpWc6P?=
 =?us-ascii?Q?eC8Sl38GwkKbOV5RK4inw6hPTaTn4/lI7cGXkXTqY66MSehdENdiuoKa8q/T?=
 =?us-ascii?Q?tI5f+GnDWu5XjhrEh3IyHxDUr3nstrEOq/sIXhcu7OeEV/mktNtLoyTSYIBf?=
 =?us-ascii?Q?W9bIpnHCFWl6FC/LyIBP/DHjiOrc+4ODqRxKT3qjQEgj11CCIN58+7ksdlWa?=
 =?us-ascii?Q?LKGTb+q1QYaTCbAujPus6JVmmPOZaNTgk7zUXHG/VYtq3Sll5mjbtLBC4D44?=
 =?us-ascii?Q?2SPiUYL9rXzEjUzFPN5SNUkjOBbp+Ndv39oF/M1oD7Uq0iNTdEkj7GI/YlYM?=
 =?us-ascii?Q?7l0r+c454q7UI6csn/KbpM+75hT7gzP9XzUU2nM7VQKVj9NDcYAOv9LY1j0a?=
 =?us-ascii?Q?/b+tPcrsCBepcxx0LwoSZBLSY8UFU8owGU7nvkXDv+C4boNhYcvL9xUPvQrK?=
 =?us-ascii?Q?pTVJKX255J2q+BibaGaIQPsR2DGnpCirYbgqvMVYwVTGTcD174/gJPEWRlAS?=
 =?us-ascii?Q?wTZnS1Z+0oZeLdU+SuYm+MegybmIeW5KqhQTKq4mLxEMIpQg4e7uOppfckfT?=
 =?us-ascii?Q?MjWwSPGUbCKDrhHrpzVm4jSX4a7A6GmSw4aUj4gvqHtX0mEn3Lq/4ahiThxW?=
 =?us-ascii?Q?j8b8HMLjtiHQ/1tOIqqJA6S1k9loALoXGHD0lxRe6v0aXEYxvVvkfYYi0SO3?=
 =?us-ascii?Q?7x2B478QWRju4Hgus2Kl0nc+HEZa2QFBhidWbnPmCNvCHK7FlI+hvlGTIDHc?=
 =?us-ascii?Q?DtWSLxQEeyHGRDd6SB653KoNFkF7tC8h9IAOEnNEmaO10Bv8M6oUfVCpUf05?=
 =?us-ascii?Q?0BE9KX+68PCeuuYAca5v18aVWPoF0a/6FaxD3cvxyaxUxw7kB/n8rbw7UvXm?=
 =?us-ascii?Q?j0MMX/vXTNnAi/g9RC4xtYAzViQptiFtF9kxxzkUvBszWdCTABReCXLk+9+M?=
 =?us-ascii?Q?vpiyoQs53W5WlfjU+InovA7x+nJzpuc+/PIxGCf8ryw+q8i3myRZfXNchFfC?=
 =?us-ascii?Q?kM4O4nH4tfX6C/S2bxwrymn50nWckormDj9qL8xZqEZ9KE99KBvCS2bFaKaZ?=
 =?us-ascii?Q?tPrYQpOQYnWhdfvxez02+DRwsbNFRTFvPJpSG5KF4d97G/8ij+fUjLEnBinc?=
 =?us-ascii?Q?dUBaGxrVD6Hl+oR2boz6v4CwIVOigait?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OyaFUiV2rCecHEd4HltJW1TCdCFo0k9y6/nBage8RF20uZtSLXCi84VMNd9d?=
 =?us-ascii?Q?s+SVnKCWjYFRZtxTUyuZHMJDEzYGOeW5awDbvPRGwkzrxTG7TfiC3HHKuMwE?=
 =?us-ascii?Q?aSGDW06gdInru9ppo6t3nNyOy4qk2ZJ5HrIIpeIfYnI6Zu2VeXx4Ndheikye?=
 =?us-ascii?Q?K5wnL4sOwCQTwYrsr4i0O4wd95m0ledJvNd7K4ccbsGFYVZoX1iAuz/FcGlE?=
 =?us-ascii?Q?A1hu3LrUN77vzpdfO/nTwc9kslu1NyiAu/Sr48MnmQc9jxf7RMYk4QHxaIK+?=
 =?us-ascii?Q?875o9sZP9SzK3tsJ6fFrETrG35Issx3+fwEqsb2110GmgyhFQ3TPb7l9pg1/?=
 =?us-ascii?Q?4cxGGzOwmyI7oZglsp6tGvTH6ScKisDhhP/1E/XvWgljjpqk82Cyu0jaun0K?=
 =?us-ascii?Q?pwtjs0for+TmnuEcFU2PXRG7RqSCpQiZQ/yx/VngA5uM74bj4jKLtGua1WTq?=
 =?us-ascii?Q?SPPvdAm5YU0uUBQKlUqhFoHp0RB2XqEg8P29A27x+K/kFC68MCHoUZyZqvra?=
 =?us-ascii?Q?FohzFkk4SenfYDzqPyNyHotHbtJBWKdaJEgKS/86vxmqkE2gaKGcIUGGW8zg?=
 =?us-ascii?Q?amE0Zxo+n9k24glHu4bqIPfL91kuay5ySbQqI3vh7x47MFltUfYMo6HBMuhZ?=
 =?us-ascii?Q?zdLyGqRfqM0tzilcrLtAEsKVav6+ek1KLwho8z9Dvzc2Q/OGFmbtVzY6oU5y?=
 =?us-ascii?Q?Uj07mJNyzQ/k95lJRDkAiKuoJwlNegYIIMbLhsjXRFwbDv75tIDzcwDurrSG?=
 =?us-ascii?Q?U5kLzCU9z/jdpyyzmeYKvLvAhD9F2HuJiu8CkNk80D2HpaQiLF89Vz3UuQM3?=
 =?us-ascii?Q?YRF+3+bDqm0G5WKSVI3D1F2mcH2+totQU/UouXhLxj44iHZEmxr0qgMWbCwb?=
 =?us-ascii?Q?L4a656YwzmAMORfQKaC5RsWQcv+iFqoHykyDhxZCEO7dFXcx/fsVQbfVUuAt?=
 =?us-ascii?Q?n9f+1tWZfzS+edd9frXTeYQIT4kAVSq839rp6GIXuPwmRmGa6SKG8x2UYm80?=
 =?us-ascii?Q?b3YlcS370cEorHaH3a/cBhdv3rA2QqGoYE4kJILuLQXHUDVvsvxu3Fi/OX6+?=
 =?us-ascii?Q?sznuP81WMHY678BMYV7o5BIa3eC8kmuJUaCK96tvDdzoGIc/igdqHudmIJoB?=
 =?us-ascii?Q?tYwqCsQQEc9HjVIAM0hS6bTt/1Ch9H+ngsLYd762heAn8mqHMemp4OL2HMU+?=
 =?us-ascii?Q?4H8WcjnEgC9iIehz3RaIrNnM1W7hhhzxj0bnmVmFBtluhsKIVjgp8s78Py4k?=
 =?us-ascii?Q?jTXNzpF67DwDc0S3F9yt0T0HrzJPCTRt5uFn2k027FbTzC1jUkmwiGHnrweY?=
 =?us-ascii?Q?N5dv5L5wUneJkFvLz+TgPT9OUgNcAYlMpF5wr54DjxPzEfipnLPsbRoXwu8m?=
 =?us-ascii?Q?QyR8LepIQNxLVf7LvrikgQlK7uYv64+nO95AgDMLiUMBhnzm7OYXoKqQCfos?=
 =?us-ascii?Q?TsSmti8N6NPo7dpI4bDVanKwmQZpSRqL9V0+321Woyw97aUORr95EmbosncC?=
 =?us-ascii?Q?1RmMTrphkyVVHFqqRU+nz+u20g8ezBDKOhVB5wJJxF5m5WDKDVVLYSGL/B6t?=
 =?us-ascii?Q?/MMMLwBTgeOjOWqIyBA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8390553d-2b26-407a-7b92-08dd51d285b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:17:58.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnGEAKPc1tItBFakB1TOT7oa3C1cLKEOf07O1iO5YWil3gqNapRZWALbm8tY8C630CTecfJR4ueqGqOh4gORMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10225

On Thu, Feb 20, 2025 at 04:45:42PM +0100, Philipp Zabel wrote:
> On Mi, 2025-02-19 at 21:20 +0200, Daniel Baluta wrote:
> > On i.MX8MP we introduced support for using a reset controller
> > to control DSP operation.
> >
> > This patch adds reset property which is required for i.MX8MP.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > index ab93ffd3d2e5..923e7f079f1b 100644
> > --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > @@ -82,6 +82,13 @@ properties:
> >      description:
> >        Phandle to syscon block which provide access for processor enablement
> >
> > +  resets:
> > +    description:
> > +      A pair consisting of phandle to audio-blk-control and an index referencing
> > +      the DSP Run/Stall bit in audiomix registers.
> > +      See include/dt-bindings/reset/imx8mp-reset-audiomix.h for each index meaning.
> > +    maxItems: 1
>
> This is going to be confusing when there is an actual (undocumented?)
> DSP core reset that is not described in the device tree bindings, see
> patch 8.
>
> To me this looks like a bit of a gray zone, as I don't know how the
> hardware actually works, but if you wouldn't call the Run/Stall bit a
> reset, it probably shouldn't be described as such in the device tree
> bindings.

According to some hardware common sense for cpu core. Generally release
RESET Pin to let core runnings. Difference system use difference signal
name. Spec/RM generally copy from hardware sign name. The functionaltiy
is work as core reset.  Release 'reset' let core go. The module is abstract
layer for the function.

>
> I'm not sure. Should both core and runstall reset be described in the
> device tree? Or only the core reset, or neither? Either way we should
> try not to lie about the hardware here.

Not lie about hardware. Try match hardware behavior to existed abstract
module. Hardware is back box, which we often only observe it from outside.
But I can assume hardware implement like

	swtich(state) {
		...
		state = new state;
		...
		case RUNSTALL:
		state = state;
	}

Of course, hardware may use simple gate a input clock to run/stall a core.

Frank

>
> regards
> Philipp

