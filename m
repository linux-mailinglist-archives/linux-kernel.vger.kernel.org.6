Return-Path: <linux-kernel+bounces-170620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06BD8BD9CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF0E283B0A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B64087F;
	Tue,  7 May 2024 03:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IAyzpzx5"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137529CF2;
	Tue,  7 May 2024 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053297; cv=fail; b=u6JUYhOzWUssB/HoHczbLLhygsKMe6Fre7rUJc/Cf0UxwQq8BqXowEpMJbWbaxqEuu/+1rq5UmV/QWAW4YewKHbSkLynes6ZG29ltb0+IuqzE+n7knVdZgTi8gpgEmGuRm2BmQJ2f9WHZQz2RixBDq44D0+thmzEP28+ZOJRKNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053297; c=relaxed/simple;
	bh=PQ52G9lWV+w9eUcM2+qZPlLYwbBSOhBLY2ZgZ76qjUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HweRj63dDjocCAcyODJfqUT4nHrVlqBFh1lWS3WFOqVqXRsM0gpuJxeyCn69ENCsMIIzlJX7/hjMqJlToQbmG6ZykWoDwP3ZTiBZ7OiYJ3nNlqbFmzqC2w603GUZESQw9CG/XRyuUsByrtkH1CoijjGRH6+rZtPjQAfaFEfMZJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IAyzpzx5; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyInr7NQ8YPbGppI7cf65cJZAHvuP1WM49eYbqvfcKUTYf+JF6Bb7cehAYZrmjXblwxoLiu6ruPoeqD61evwJB/iZpDXlIDo46OHB/2xbxKDAYHP4EDGZrqK0CQ/c8DQEVEa9Z6RXYQ5le34fUdATORexrTIWciNeNK09ftncJqZk42qGqx7N9FhTmp6KhR7z5jgDd8Hzl0cnoIJS8hSASUf1h8nPqQjwluu1ThNFtDcOei5+LOeo+b1oeXS8IzUlBJw/E+Q3K2vmd8kuM3D+5mDhmVopB4EgfbKa+BPRYNzpYtd+DQWHXcwO+LexT21ZKVPZ5Kqecla+aNPHGIAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSxKNYVHIdZ/0mB2/qJz0wgpMqplCkimeFPDGs9PJb0=;
 b=l10Xv238tFomPiXnMZwW0XcMvjqa+d/XjzAzRp7qV3KIuI94AarJT+cKzxmSoXNNeQBTU1IFSFfbcZUCkIN7yiiCSlBXhuGYsoFnn3KzSJ3/LLyoLKC6oJUTE0dYvaldqVrEoxPYoVkzHfJDaE7Y+LzvlYfCJpMod1fVwTolYWCBoIcM6xxn2ilNF73PpOv/iKki/QODbMfo1+34wVClYAWSzWNtqq2diZ5z6mDg2BDj900cfcqT9Fy2v+Vb3ESog2EZdBjGYP3XpBntU/cVJ0WTMAR9wuxBYFFy/w+cPFhW3GIWqpKfiqSh24+eWKSsPrQRt1eeQ7ewaYLmz8dRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSxKNYVHIdZ/0mB2/qJz0wgpMqplCkimeFPDGs9PJb0=;
 b=IAyzpzx5p9TMNx/+rZj+S9StrEFj7zD644Vi7K5UyGbFG2C5AEzeJeTI0Damb8l9R9uVe73PDtxa72ui4RV+2oPkbG2ttWom8Ft6uqXDtJqJTVjWz7gEIVICeNLBrYi826MzZYAu0+YxlS5ZB6UyrCJqt9fP/S3sS0QTV41aBUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9444.eurprd04.prod.outlook.com (2603:10a6:10:35c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 03:41:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 03:41:31 +0000
Date: Mon, 6 May 2024 23:41:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: imx: imx8mp: Add delay after power up
Message-ID: <Zjmi4Qc3C3OYJU5n@lizhi-Precision-Tower-5810>
References: <1714966502-27784-1-git-send-email-shengjiu.wang@nxp.com>
 <Zjkftwr4/6KV39sD@lizhi-Precision-Tower-5810>
 <CAA+D8AN9kFdgojkrR0ORUyrtOW=JOn0AfbXFTJ70RE7JxgA2pA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AN9kFdgojkrR0ORUyrtOW=JOn0AfbXFTJ70RE7JxgA2pA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: e72950f2-a300-47ff-cfb2-08dc6e4795b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGdiU0R3NlRlV0E4YjltN0VpWWM4VCtKK2ZEaXZuUzExc0QzeGI1aXpkRHdV?=
 =?utf-8?B?Z01EZDYvelQ5UHBuWnZSOWZjRTBRT3FiMDkyOWI3TkcvK004Z095NitOY0Fr?=
 =?utf-8?B?QzFKaHFJVUh6eU8wVWN0dlFQYkZIdTQ4ZnBtZWExc29iUEl5eFNaRTk5M1Zv?=
 =?utf-8?B?UFRaQ0F1S1JXZE0wUGtBTFRkMWdYaFFsYUhtRm9BRzNabU9wK0gzQmFLK3Ar?=
 =?utf-8?B?Y2Y4N3V6VmFjd2pweFhaOVZYN01tN1lEdFZuM0JMUnRCbk11UVZoUS9yVWx6?=
 =?utf-8?B?TWRBTVROaUErT1JCMHVxaG1YQytLU0pZN3prMWZ0M0NYdUx4UTF5OVpTd2hR?=
 =?utf-8?B?MjZ6RHpnTU92SFJGSWE1TTk0VjJjU0NORzRucnBuSzhtVi8vYnBxWGN1R0ZV?=
 =?utf-8?B?ZTUrWHlublZkb3NmbVkrQTltcDhZcXRVQ05JZHA5ZTZoTGNWdUJKQVJ0SWhz?=
 =?utf-8?B?NDVpd2FzbDVNK0JBRkFCZzZ1c3U3U3BmdjFLc2o2ZDdIRTMvZjc4Nnd2L2Ro?=
 =?utf-8?B?cUVDSmFJQTBYdENtRXU5cmhHL0QxeDVIVzNFTUgwTTNVaytCRldtM2pUMW1E?=
 =?utf-8?B?RlhkUHk4VnFNWHJPd0FjMWp5cXl5eE5vNmtTS3EvWFVtSVcyZzFMTE8wUmFi?=
 =?utf-8?B?Q3BRSG1JWTZiMTRVN2pqK2Q5Ym1RRVpiMDl5VGFlZkR6TEFZUXdsdGFrK2hr?=
 =?utf-8?B?VFY5NTkybmRmZ2FlbW55alpjU3RSeDFHanoraC9ZWnBCWlhGdXFuTHVKS2l2?=
 =?utf-8?B?NVBaMSsvQkRtYTZDYm5uUS94Wk5XK2FmcE5zL0J2WFJWL2dTa3ZoOXpqem1L?=
 =?utf-8?B?cnRSNFNTMk5lOFdHcU1mT2VCdGRXQTg0c1pQaUZQY2VwQWVqS2JOUHVqL3hS?=
 =?utf-8?B?TmZ4ZFEva0NPQ3ZuM3lzUGx3MGZwbVFmTk1PR3FGbzc3eWpmTUFLWDh1bmI2?=
 =?utf-8?B?bzZocyttYURjd0pUYW5WK212QzFJeDJCN3JaZGFyMnZUWXNOR3JtTkpQTXpH?=
 =?utf-8?B?SWpIeDJkRDlXS1pGZjQva2RIVWRkNDNSa200YldCOVBpaWhKbjBsU1Vrcjli?=
 =?utf-8?B?RkgvaFU5d0hlRlV6VEl1eXRQaGhLRzFFajlIekpxYXVMYTJ4UWgrRmFGWm5m?=
 =?utf-8?B?eHpzd01zOTZxZDFaQkxDMUI2OVFkRlJka0pSSlUwYXE3TnFONmRrUFBORlN3?=
 =?utf-8?B?UDB5Zll0MFpMSUh5YUF1Z1lITEFka0NvRnMzSkR5a0poNDNOS0R6RTlaTDdZ?=
 =?utf-8?B?UWFBeU1US3ZWbW1oSlFsc3RKWkZac0tma1JpRFBZQ0hmMUl0Z0l5VmhwS2tp?=
 =?utf-8?B?d3MxOG9FaGdJc1RyWGxmbmUzZUVNaHBKVWdFL1hLR3pNdHZQY0hkaWN5SFk1?=
 =?utf-8?B?QUJSb1A1bnMxQWZERWVJSjRzLzV4YmJhMjAvRm03ZWZnOWFjR1VZKzBPYTBh?=
 =?utf-8?B?SjA3MkhiVTlmMmhoMi9yOTk2UEVtTjdmM2QrUFBDeDZKVXZ6ai96NWo2cEVp?=
 =?utf-8?B?SUVLb3dscXZMMllkSllDT0k2dlNOMmpDOVRMV3JjWU81eGs1dldJMWYxYS9l?=
 =?utf-8?B?K3lrUzN0dmpkRmc3bW52dmZSYm5lWGpaa3Q1ajV1VE1oUEZYNmJnVEdhUWV5?=
 =?utf-8?B?SWFweDBNMlhDbndhcnBiek5JaHZLb2xOZ3VqUkxoYkNDRkZEMm5BQ3ZQN3J6?=
 =?utf-8?B?azFiVmJsekZEZ1lteDg3NWF0azFJSzBSZzNlK0hiOXJ1ODdYQzlEams5Wi9S?=
 =?utf-8?B?UHdRejRsR0RWYmxNV1hmMlBPVWl6Z1NaKzAwd2NQc3RNNUorQXJQMXU3RWRZ?=
 =?utf-8?B?RU53WjV2eEN5K0lvT2N5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHZDSUZxUFNHSUt3T1FHd0ZReUNRSi9SKzhsQVRjZEo3bDcvR082dDV3eW1u?=
 =?utf-8?B?K3RPRXl1bHhydjJxeWZQVURoemhrblNaVVh5aFNHWFdjQithaG5qYjB1bmhZ?=
 =?utf-8?B?VlBFS1FjbW5VV2FscWswVXNzcTdkeWFNSUZjSVUybllzY0d2RXh6bHRGWWVS?=
 =?utf-8?B?L2J5UHM2UEdYSTVONmxyZFZVWEpiYnQ3T1puUEltdFdhYWxJVHR4cVBxUHJx?=
 =?utf-8?B?SUp1WHhOV2NmTSsxOTA4clM1REd6a0tPMitLa3lmS1pkRDNhYkk4UlpxTVRj?=
 =?utf-8?B?aXl3NlNtOUJvazEvT1VPZlBxQjZQRGhrSjIrU3FJM1RGSnQwR2xQWDVzWjRY?=
 =?utf-8?B?Ym9Ec0hheXBmd1NuQjhQY2gyZ2pUOGZOczZYZW9hRmtIYm5rWFZpa0t5NXl1?=
 =?utf-8?B?ZWJRWHdlSjFrRHZtclBmeEkxaEFZSGk5c0FkZDlzb0JPL3ZOVWNuSU4yRHBG?=
 =?utf-8?B?NVhLdzVhcTNSMFJ6d1AwSVJheUlubFQrTDBOTGhWMHRrZWpVajJyT0VuNVJr?=
 =?utf-8?B?VlhOQXVHYllBaDRIb05zb2x2ZmtVNmFQY0dQUXdJbUZCSUlZZGxHSFR4N2Vn?=
 =?utf-8?B?N0dhbTNGRVJIQ0d6b3hXc3didXMzU1dyTVJOUUZFMThIR2xYWExQOUlQQ0xh?=
 =?utf-8?B?dkV0YnlqZE1wQW41M1VibE15VFBMZEFiNmVDY3dGc2JuRm8yYVBncVJLWlFh?=
 =?utf-8?B?cS92UDBGY3BHMG04dm9NeWcyZWhrVXJHeFFRT1Fqb29zVXlSUnVIOHYxODd5?=
 =?utf-8?B?N3VwdlRkV1h2d1dLTnprNzdRVURwdjIvaExtWHlFZjMvc3JJaTYzM3U3a2R0?=
 =?utf-8?B?SWk5SXN1Mi9uTU9QYXhWZlJrT290b202dzhkWWFyZUhNZG9vNzJyNlFjUTE0?=
 =?utf-8?B?WVhDSXdBbCtZVGw5dFdHMGtacHFwTjZmTEVpUmdKY2hnSzdVcFZETk1xUFl2?=
 =?utf-8?B?UnlZK1k3VGhYdXlId1lIV1JwaWtjSitBcHZsTi90U2llRy80NlU0TGhQM0Z2?=
 =?utf-8?B?aFVjcTdvZUJXOWRLWS9QNW9IUWFYSHBGVkxtRnZuQS92Y3ZxdVNoUXBPaEtq?=
 =?utf-8?B?QTRuSDhQaTZ1UUYwd3J3SEVHekRaOHRKQ2dlSVdJcy90YkQxYUVSNGl6cUov?=
 =?utf-8?B?VzJoMGxDUE1zSE9MTlZ1Tk9OeWdDN1dHUE10V0dXV0p2YjJEZUVBcU0rc1Rw?=
 =?utf-8?B?aElOYkxjT3ZPbmdUUjFBL1hBNDJtRzFScG1mRGhVNnMzeXk2QitGa2szSmpZ?=
 =?utf-8?B?Z21rdjgrOXVqdWQxb0Y4TzQ5dDdVWW9lRUFzRGQ2SGE2YTFlTG1VWW5sZktC?=
 =?utf-8?B?emFXenV3dFpyelFCblJqQnJ0MGMrQjBXSlBEMnFBWHpuUktoVkRVTE82MlQx?=
 =?utf-8?B?L24rcldzSHRnQ3o0WkRIaUtYOFZkcDdpcVp6dXNxSzJkdlRkb3BraUFwb3lJ?=
 =?utf-8?B?RGhzRHh5TGFNa1hSQW1Fc05wb1Q4ZFVkc0FseE1jUkFpUm1BeENRdG9TK2xh?=
 =?utf-8?B?K24zTnlmRzB2RGJuVngzbjlYUis5elR4K3ArYnJJSURGbHE2UGtHUUtNYW9R?=
 =?utf-8?B?ZmRCWnZFMmZ0VjJBMjVJUTRXb3pVMFB3bkpkc2NBTEczQnYyWFNZdHc2c1c5?=
 =?utf-8?B?VkhpQUFMK1YybG1WaGFyZzNPbHZzV0NFYmRXeWhxT1pHcWx5aDhyOEJsUEwx?=
 =?utf-8?B?UGFocVZLQThIUWtWUVFnb3VOZGxjeDgraFpjKzIva0hBSHZlVlJwRGdpRFht?=
 =?utf-8?B?K0NnQjhlWE16cGY5OUdzbVZWYXRPTmh3eDVwdk5BNk1Qak9jcUwwSVZRMWtG?=
 =?utf-8?B?dTc2RVdzMGFOQXVnRU1VU3I0UUxoYVJ0M2Y5RGVweDNXZWZUeDlZVGlvbjdv?=
 =?utf-8?B?TUsvaWRIb1hjbjhOeDI1ckhyWm5jUUZYMmxVZ3YzaGdpYzNZZ0hOWmxmM3M4?=
 =?utf-8?B?dG5rQml0K0ljWm5rNkk2c1dQalJLanRCT2FjUlJtYWFsSXAwQ1ZzeEVFcE51?=
 =?utf-8?B?dGdOc1VrQitUZU1STFBlekkvTEpNRmlpSkJFWWM5ZytXNnVOenNFQlhocDF1?=
 =?utf-8?B?R21SQm9TSVNmMlhMdTJEZHl6ZmxrbUJscC9ZaW9NT2pMME1FUTM0R21oaitY?=
 =?utf-8?Q?idW8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72950f2-a300-47ff-cfb2-08dc6e4795b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 03:41:31.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DoVVXE4buX8ToFbjR1ucUIwHR3iOgNeM0C+PCDAIXP7m/WzUpTZgZ6K8AI9Zvdfs26uDVCZqnwnmxDR/TFm5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9444

On Tue, May 07, 2024 at 09:44:19AM +0800, Shengjiu Wang wrote:
> On Tue, May 7, 2024 at 2:22 AM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Mon, May 06, 2024 at 11:35:02AM +0800, Shengjiu Wang wrote:
> > > According to comments in drivers/pmdomain/imx/gpcv2.c:
> > >
> > >       /* request the ADB400 to power up */
> > >       if (domain->bits.hskreq) {
> > >               regmap_update_bits(domain->regmap, domain->regs->hsk,
> > >                                  domain->bits.hskreq, domain->bits.hskreq);
> > >
> > >               /*
> > >                * ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk, reg_val,
> > >                *                                (reg_val & domain->bits.hskack), 0,
> > >                *                                USEC_PER_MSEC);
> > >                * Technically we need the commented code to wait handshake. But that needs
> > >                * the BLK-CTL module BUS clk-en bit being set.
> > >                *
> > >                * There is a separate BLK-CTL module and we will have such a driver for it,
> > >                * that driver will set the BUS clk-en bit and handshake will be triggered
> > >                * automatically there. Just add a delay and suppose the handshake finish
> > >                * after that.
> > >                */
> > >       }
> > >
> > > The BLK-CTL module needs to add delay to wait for a handshake request finished
> > > before accessing registers, which is just after the enabling of the power domain.
> > >
> > > Otherwise there is error:
> > >
> > > [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
> > > [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> > > [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > > [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> > > [    2.181064] Call trace:
> > > [...]
> > > [    2.181142]  arm64_serror_panic+0x6c/0x78
> > > [    2.181149]  do_serror+0x3c/0x70
> > > [    2.181157]  el1h_64_error_handler+0x30/0x48
> > > [    2.181164]  el1h_64_error+0x64/0x68
> > > [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > > [    2.181183]  __genpd_runtime_resume+0x30/0x80
> > > [    2.181195]  genpd_runtime_resume+0x110/0x244
> > > [    2.181205]  __rpm_callback+0x48/0x1d8
> > > [    2.181213]  rpm_callback+0x68/0x74
> > > [    2.181224]  rpm_resume+0x468/0x6c0
> > > [    2.181234]  __pm_runtime_resume+0x50/0x94
> > > [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> > > [    2.181258]  __driver_probe_device+0x48/0x12c
> > > [    2.181268]  driver_probe_device+0xd8/0x15c
> > > [    2.181278]  __device_attach_driver+0xb8/0x134
> > > [    2.181290]  bus_for_each_drv+0x84/0xe0
> > > [    2.181302]  __device_attach+0x9c/0x188
> > > [    2.181312]  device_initial_probe+0x14/0x20
> > > [    2.181323]  bus_probe_device+0xac/0xb0
> > > [    2.181334]  deferred_probe_work_func+0x88/0xc0
> > > [    2.181344]  process_one_work+0x150/0x290
> > > [    2.181357]  worker_thread+0x2f8/0x408
> > > [    2.181370]  kthread+0x110/0x114
> > > [    2.181381]  ret_from_fork+0x10/0x20
> > > [    2.181391] SMP: stopping secondary CPUs
> > >
> > > Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
> > > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > Revewied-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > > changes in v2:
> > > - reduce size of panic log in commit message
> > >
> > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > index b381d6f784c8..ae2c0f254225 100644
> > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > @@ -6,6 +6,7 @@
> > >   */
> > >
> > >  #include <linux/clk-provider.h>
> > > +#include <linux/delay.h>
> > >  #include <linux/device.h>
> > >  #include <linux/io.h>
> > >  #include <linux/mod_devicetable.h>
> > > @@ -360,6 +361,12 @@ static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
> > >
> > >  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
> > >  {
> > > +     /*
> > > +      * According to the drivers/pmdomain/imx/gpcv2.c
> > > +      * need to wait for handshake request to propagate
> > > +      */
> > > +     udelay(5);
> > > +
> >
> > Did you address the issue I comments at v1?
> > It should not fix at here, I think it should be gpcv2.c to delay 5us.
> 
> Other BLK CTRL drivers already delay 5us in its own drivers, if
> add delay in gpcv2.c, for these drivers, it will delay 10us totally.

We should go forward as correct direction. If udelay should be gpcv2.c,
it should be there and remove other udelay in BLK CTRL drivers gradually.

If sometime found 5us is not enough, need change to 6us, we just need
change at one place.

Frank

> 
> Best regards
> Shengjiu Wang
> 
> 
> 
> >
> > Frank
> >
> > >       clk_imx8mp_audiomix_save_restore(dev, false);
> > >
> > >       return 0;
> > > --
> > > 2.34.1
> > >

