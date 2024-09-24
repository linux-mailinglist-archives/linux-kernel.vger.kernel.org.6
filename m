Return-Path: <linux-kernel+bounces-336639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ACA983D62
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96531F23701
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51C7E574;
	Tue, 24 Sep 2024 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hr+1qbKD"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013050.outbound.protection.outlook.com [52.101.67.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E38BF0;
	Tue, 24 Sep 2024 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160788; cv=fail; b=ohcop7T6bYIA/m5VVNKuEBAkKQwop/xomdZbSzqfO4hQiPG9z2WomPhEgwO7bdV4mjZa0+rZdfMuUa12LUHW/fpjD02egkraTqyJQ85I4Y/GCdKs6zVspI53BTm/bOPBUnJm4tY3Zu4wp1wsyrgt7OLbJKgGtZDAZOPNa8r385g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160788; c=relaxed/simple;
	bh=nN81CRRJaC4Qot1nFZzZZrf+oWYkF59YgflD3Gw6iLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vdox7SOtVLrYblFSq/pvVLY50ujpk+ddgH1M1zkoWaQBIwWEUGgnTu2IANIQlspT8ayamZDCZwXzvBGGZ0Z1djqm0+uN5SRQno+9mFlWvt7xn20PLXTMmfC56LD/DQM+OsUZlUvOvsOE0ubWMhZj3FGPvaejQ02REspCV92etOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hr+1qbKD; arc=fail smtp.client-ip=52.101.67.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnKympaHi2FRqhZo75i7QrkMK8bW8PTqeItgOOt6OEOOyVZ3y3XYODv8HpZ0EZ+OczDFoZoctrm/eaZWkqfzVPHVXgEgIzra5SQxzRu03rdDNCGC55aS6REDEFIAnfG2LWJ5adenEP/MFH3bkveUdxfMapKEnpjYsDSR8TJrkicOB8bkY7Q3Y/LYHMH8Py69WncJrPykq6vgMnaL8MP7yC6ndGueevuHGRDvHjXvuEsjxHuGGo4JSoa1gQHdMIoZU91xtb4BnTAVAQFoCQ1mMxXP1pS7KCBtbQutw36DCV2m/ufBuv3TC4Kd7iyydfMZXTxWk5R0KhhhobLeZLOs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbGhPS9jDlj5NqHkF3QPwjov8u203ZdxkDgcTb+mgaA=;
 b=xktpzX6PW1Dxr91EmsQiXWGHbFO7C06u+x6hFHd4YtinA6J8RsTrEkTnDJhny1QqnzfyTgGyYEhKOtyWhY/NMMqFOJB9b4ViVU6c75KGzZr3hTaU6OA0tvIg0b347SeVxzdqL3XEaDaxe9CDd9TEcwoDygzCh6n4hSc8vvqAF6bUW6K0MAC5ECXeypw1GG9he0mnsKrulHN311UxRNH27hAFITNPOY5eVqCbJMoyfyqhwz7avhCDfQuIcEnqF/4TzyFyBN3B0lur/6wdj7cgaJ8c0q72tYZ6hpnHqU93UeCu053If9uPzqiaskWQVjNSeYLPrfAZzaif7kLOphUbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbGhPS9jDlj5NqHkF3QPwjov8u203ZdxkDgcTb+mgaA=;
 b=hr+1qbKD6S+S+gXGWd9XHEND/xSBQg9803ejHJ32EWzmurjs3cJH4PaBQQLPLfKiq/0K2PSw8p9yN8ayd2XGl0nQgUc6+xH1qhMUsEQ7M227lSlKonuLdyYoRe2cxoaUHVpgA3v5jcLi9jrrLAN/WrhC6FcV3s+2b7KHop2YY01Lm8C68svPxBfhc75WVmnXZ3mYhDmPv8Iod7h7JbnBvpqAcuI/pQqqpDCTfL0KSAYZq+bghphDLKojhcE32yajPvzbsAj1IqDPkXr6w47PFRuDgM7mgkZmLft752H2dPtA4nxxZm4zbuwxeVrygzxKJhIGZWpYbrubzoeI3StQdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 06:52:52 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:52:51 +0000
Date: Tue, 24 Sep 2024 15:54:58 -0700
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, ping.bai@nxp.com,
	ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: imx93: Move IMX93_CLK_END macro to clk driver
Message-ID: <ZvNDQhzuBrs/CO+k@pengfei-OptiPlex-Tower-Plus-7010>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
 <20240627082426.394937-2-pengfei.li_1@nxp.com>
 <60f9e733-f5bd-4bfc-9bd5-94ae18bb3901@kernel.org>
 <Zn92TX9ZsHde7g2f@pengfei-OptiPlex-Tower-Plus-7010>
 <ZpoCxmvgKNgvx4Kw@pengfei-OptiPlex-Tower-Plus-7010>
 <0cddd005-6997-4159-8841-beb837957f0c@kernel.org>
 <ZrHgpuvoXqsoqTJj@pengfei-OptiPlex-Tower-Plus-7010>
 <3e0ea78a-f4d4-47d5-b3f4-622e6da475fb@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e0ea78a-f4d4-47d5-b3f4-622e6da475fb@kernel.org>
X-ClientProxiedBy: AS4P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::27) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 946ceacf-87e0-4109-b1de-08dcdc658237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XOYjKu/Gok0VJ3zmB/AilcDTjqZHjEQVZG+6bG57YTD/meP8a6uNDKgYlXHQ?=
 =?us-ascii?Q?ctbKhZbLVCCdQJhSJQ0BdXqnxXN4UYfOJssnsRbiL8arxVMAXdwBtRiw/w+l?=
 =?us-ascii?Q?dU+ex+GJx3JS/SLmFaWrv5EQdOIC436to+VBn1g8SixNhHJnwGV4VJfOHVTz?=
 =?us-ascii?Q?mzcJYo+rLkvPck5FtsBDpvCdHJXWvcNJgqBjrbH0OPaZa7hSACLf3CNuY51o?=
 =?us-ascii?Q?ClfwCkkeN/mQSlmqLy35G5bbbkLtccBP0QHsGK/KTqyLrGjEKjwZOLnAF3pv?=
 =?us-ascii?Q?MIJ3fsNSuVEhQaSfRL/HeJRFFv3gGkKiXBgFNqvub2Zwq5Cmg4HDWa93+jV+?=
 =?us-ascii?Q?YgaQB/9G/zop+RkB/YTZATZNclsJTkmJ0gUQcN2Yzjm1Ge3yKiZKkSlg3XNm?=
 =?us-ascii?Q?PyQ9UNnr67+i7zf5A+ezXs8jDsPk0kL3zM85SbhX2qvaSjtmONFslc7kndP6?=
 =?us-ascii?Q?Xnze65Fuy3hzdo3RFbZTSwCbpvyUd66lnsJokXFWyOJxcd9SMIaKlfMoZz7S?=
 =?us-ascii?Q?ONNVbei4+3aRil7AJcbFhYvF87SC1L73fYfYps3QmqTt5KUevFSriRzagpDf?=
 =?us-ascii?Q?CoHvkFoSzGed61a5E/z3OgTZSWId28pW49eBwc1Kc7ZdKB/2tB7zmIbBmuYL?=
 =?us-ascii?Q?sWyLUsQ7+e0aRaqPwiP5UjqKzTy0veV6wgKphMXO7BYioavN87XpARpeO4+I?=
 =?us-ascii?Q?D1YfjQ0jQUpWe4alpbmGUV2bm6k2oBumeMEOcUhH74Dt1QCU0CW58dW2UhTH?=
 =?us-ascii?Q?q8PRv56FPW+1RNFyJwMeJqTkEU+JPfF8rbDde1tP9xqtEUtsylZ6gwyvzE/+?=
 =?us-ascii?Q?qES0Uz82FObwgjfmiR5deC82V/NBzS0ukQqYlsczpZncAlpkCzDmj1fd7hLE?=
 =?us-ascii?Q?Yu829ZElvlJXciFz4Fi64NWphQfrKJcC9xobETvARVcps6ZAAXC2BfVSp4I+?=
 =?us-ascii?Q?vHFFGBLE2otmbdfF37wLJDShnYgE8LDwVx9t93L1yPHL3GW+vw0LuiH7mKgu?=
 =?us-ascii?Q?722ykDzvF48iB3sE7jHFumolt/uGw9SdZFFCMatjeigoNLuixvI/WqbztZSg?=
 =?us-ascii?Q?8CJFGCYXgUuVQtOJolmEVJ/AzHMFW3By5+9QNh2Fj+250vaVIqKZNXBbWMom?=
 =?us-ascii?Q?uoMsfOaXPxs74FphGnXMWigjqE8hdPGQEKe+sfUXkL1/JSMgEMy6uSz+DkrQ?=
 =?us-ascii?Q?doI0bC9tqpNNwQCWi90YWBm+etncvUjy/DwSuPqUYgAN43B3+pQzG5tvf4W7?=
 =?us-ascii?Q?+58OR/3RT75diU0MSDuIRWI/ieeVbmcNEHfO82T6y6QZ92L9Vk9q9rG3Q7Gj?=
 =?us-ascii?Q?PU+X/xhBw3K1H8qjOHIrpiQIaG3OSOYNS0JqQ1TdEjyeWqyHm6RIG+BUJrWh?=
 =?us-ascii?Q?qHBkRLJTrJOoUJEJ1Ao22T7sXVkDf50CoIxR9a3ciBBfr7Bapw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/wbgSROPGN2p/GihQAOd69aAD8RPJztGP5iYJbzt3rsbdKNLoKIkhFHNQi8v?=
 =?us-ascii?Q?ycOnLSq1Ji2aURe4mFK/y8ahalEDSl1/EA8uMazC7lO+RplIOJA16lG9VOzv?=
 =?us-ascii?Q?mdleoB8RB+f55a5Wb2oWFrVpIil/jAIjsT+7XTTiIS0xxB9FS86kN8LCxkMb?=
 =?us-ascii?Q?qGYugPTNmA/bdz9Pe89zUonNh3YQo2Ohynq1QnKrl0dR+qEXK7FMhg00KCwl?=
 =?us-ascii?Q?hOBoKqrzWucqjPlmVPrN4pcsj1L/ZN7ZEppHg0GP9i2+Wn0KpnrYsp13SCmp?=
 =?us-ascii?Q?YGN9Xfa0b7R1pdH9tNMB3MtGzzcTPqvwNzIUEkezWr6C2PTl7ZmnbWlF4c/a?=
 =?us-ascii?Q?ZYa4NK2QH6m8acdOUMp+T/7cjK5EDjpxEYBdGojFCIJcsY6/kP+hh1AgLGHP?=
 =?us-ascii?Q?62rozr4TpNbcPJp1k3Yr8kqpCPZ/D6XZvYcVVFH9hBd12uWL403f4ztwENfl?=
 =?us-ascii?Q?5TI9qjR7niDlb00JImWs4/rrn4JtGXHr7gFOkDwwEGH4Urc2JPPsL+xAIb5n?=
 =?us-ascii?Q?GoHt5bZdzFFXBMB15rmsC+FdLsUECF669ad6wEvStjSwRJ3UVQSz/RJr6rRO?=
 =?us-ascii?Q?+j1UZFLeU2KBozgV1y1W8ymT48pg/r1Y8ZZHK+tpuFYwzxzUdYhHTSUwXtZ1?=
 =?us-ascii?Q?5lhq0nNsPeWRsxPgwrvK7gOjwkkgA9gAo3yEV+3DPzSOy7E9qoIh1F0rsiTS?=
 =?us-ascii?Q?PvmvlM8gWeyaDGnRtE4YTI3aG4ttXZ/FER0eLQzB/ji5V/9h+5SvB6I+986k?=
 =?us-ascii?Q?6tTveDZg4mT4inxmiGkLhvzb2lh7y10F84zoKT9kS8JDf3riYyttkVQMeRb/?=
 =?us-ascii?Q?i33KOZianQlanPAzj/ucb5IxYtFo69h0G9fB5KDmKpcOz2ZHt3HAuYkVvauL?=
 =?us-ascii?Q?Ioir20lfLKaAGtiqlNFOzkb5lwGYMYA3EKBj2twAEKPH91Dnsy/xa+CEUqQ2?=
 =?us-ascii?Q?wXpxCDBVZ+vYrBtiPpjucwX8tDClZ2c16L3Za7spCF6luBVnuzE3g6WwigpO?=
 =?us-ascii?Q?DqXfo9GeoapQ9slJNzgm49FVv9y55Z3kuj8MEXsDVZRwclpYRxzfCUsKYnmg?=
 =?us-ascii?Q?ZT7tLoleflZqtbDS6WNO14SZ2Q02lo94CwUJEZ/UPMBn45arb9rHTmPbUnfB?=
 =?us-ascii?Q?PS4RlkrmS0BP2ZeDxzkwmNgojazccTUj8EeoAD0bdA6GXx2t1bGD0egUMR8P?=
 =?us-ascii?Q?W+oXA7799yuEDtHZXGnFhLIkSgXf6bc9C0OlQPF/e5wwA8Dp0yL//vxyXcTJ?=
 =?us-ascii?Q?c9OXITSBijcfO1ahXwpx6zB2VrkewFpr/+r1Obq41FsHk5RWi1DSYUaTYKvV?=
 =?us-ascii?Q?T9vGThnGKx5EQTyhiq/tcVpaB4N9aq18zB9RFqL6W2/Lh+T6FMUB9OAfRFR3?=
 =?us-ascii?Q?YUfiB1Pp5z+ipAyLbLOn0VmtTuf0srdgg4NnbByhuGXv/XrKayNuA6ZzJbGv?=
 =?us-ascii?Q?QjTGmjqcv6M8HjGxergt4f2YiJ3q7T3PQ4SlDNI/m+K3vccV5S148R0Mxw3E?=
 =?us-ascii?Q?L1os19AtUCqdZeaUE9lkId9ECeoiPNfHqG2nLJ/LzodcJh8H2whN2AG9ZC/q?=
 =?us-ascii?Q?Dys9CwuCtIL/ZOzgJjExzUaNshZCHP/XEIlLGmXT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946ceacf-87e0-4109-b1de-08dcdc658237
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:52:51.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYgQB6GaOmTQXNL1wc2+ETTL16zr2c4hkDu6jN86ojxscKo3YHK6af4f9YndHlSRWDk36EDL85JRFPR4AK2hXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

On Tue, Aug 06, 2024 at 11:39:18AM +0200, Krzysztof Kozlowski wrote:
> On 06/08/2024 10:36, Pengfei Li wrote:
> > Hi Krzysztof,
> > 
> > If this patchset is ok, could you help merge it? Otherwise I won't be able to send subsequent patches.
> 
> Sure, let me apply it to my clk tree. Oh wait...
> 
> Best regards,
> Krzysztof
> 
> 
Hi Krzysztof,

These patches are still not merged into linux-next, can you help with that? Then I'll be able to send the subsequent patches!

BR,
Pengfei Li


