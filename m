Return-Path: <linux-kernel+bounces-340805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD9987815
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0AAAB23D13
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEF615A4B0;
	Thu, 26 Sep 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AuLgDpTu"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0573A157A41
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370144; cv=fail; b=O245d07q1ah26BfK4IyDJhCOZCrjVcAhef0Qb249ljw22DQfRrveTJUlmXHZ0bFCdvqUZuXVymGDmnfzEmDxP3z6yr2ddhjp7odI64rGpZaX7bgNOo+1nVwXIj0eFLShkiamrZNi3njodZpJ+elF1oTruhJkK2B0ohuOenzXk2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370144; c=relaxed/simple;
	bh=/umabdU29187tcibJUkOBk/jHXOt1YZ2XRUlnnlXhpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rOwLWfTsEQr7NuY9gp/Ax3dUjwm4FhRMzEKxxOhhSYLyW48MLECWlRrNzxwZrkUt+pd2mxhXuq72937r1UeXrqAH+5/11hF2OuLDib52SL7BA1qQRFGgRjzoxv93fIr2LEEYQCC55BpxqwE930tiDx7h6EkIZKcMJaJKGJqcwA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AuLgDpTu; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6JKj8uhZW0fwNU0jXsmoLG7q5QLKbkXrKqTzV8O4OXu40fyrvhoPpYsQpEIMMObwJrzJigthKf+asjLRZVEOZw8m5oBt3qfPXfA8Mq0WMKILkKzhiTI9DxU/VdTRICl6mTxrREGRrorQscoR3XPByagio/dqaFNpSUHKzKCMLPTDIQ6p/+Ge1f48ugGLF9rg/BUZUcBEkTlXE58dqit2mOyu3R8GTY7nyBRlR4ExzJ/VCUf2zDNzbVWoaoUrKGyYmzIlU2hpvzfuR4+0vWiWdyk0vJUqz87ysCkTQdqSKRsCLcrqzHXS2/UKPM4n3u0YTueojIaI/DlQdZx+f2VNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xOIUQ8u8uHJqEbGLKzK7E4Elj4ClTv0DcMYjJrWySc=;
 b=AvK/HsFKhvEMTCgbkgf/KFDT23ctHe5ezzm2Eq8JkOpJ7Ih8I+km0CGe7PiU5QyheGRNRTKRy/gVpR9iqk4UWglhIyA775IsJ/tTcREUVPVuQbohObi1c23vqS0HfLr5+j/kfEPMtZ2X5QfhpHiBULf2g8UmQ8V/NnHjLnxnn81blfXKk2xpoTsZ6AQgha3zVmoR+3AFBJU4Arwojq4NzVpnWFgiwJzux5VGsLVLwYfQiSkAepywogcRD2TOorthkVrc/Ej6TLFneVOUiRnaRqJOF4j5FOQhqzHoWkf3QAJxQs/t6Qm0Ab52Kslw8wtWBRZyEO25Y6/Y4goGDJIysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xOIUQ8u8uHJqEbGLKzK7E4Elj4ClTv0DcMYjJrWySc=;
 b=AuLgDpTuBsbUuDkP+IBrU6BcqlRM7lRF7y37FlPi2tTk1iVA+//IsYeZnRdzmeg4iqvrWtr2TMPq30+fLd1ydip7Hf1irCUw96hOyDLDFjjZ7qFcQUS03JJupuCdaGykvefAHDesa3n4q0eKx14lTlZmEbTJ3vVNQ9hxzgWoXKUPjquPmb7G6tJAn3ucszj+WpN7OIv66tXGjJQSFiTMvaY8+ie5eyTLliosNJ2Lxg79XoLkfwjtDvjGSIyPYobsDwhaLObi5RhNH8RmAa0lD/wQsbsPqAtOzJiEDm+5QOOJxjEnvG0SXcUnW0nuRGQjKBop22Wp+Mj6zEj/PM+bAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9646.eurprd04.prod.outlook.com (2603:10a6:10:30a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 17:02:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 17:02:14 +0000
Date: Thu, 26 Sep 2024 13:02:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>,
	stable@kernel.org
Subject: Re: [PATCH v4 00/11] i3c: master: some fix and improvemnt for hotjoin
Message-ID: <ZvWTjjuRU26dTyKT@lizhi-Precision-Tower-5810>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
X-ClientProxiedBy: BYAPR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:a03:100::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2b6ae5-feea-40e0-9992-08dcde4cf7f1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?FIJoBS7uDZLRla7GQkWYqe5p8Jzf3sJxmksHXVJknXUhOa89ptzSANDMzNu1?=
 =?us-ascii?Q?k9j6iK7653z2grNqTho0JL1BYmTWctglFuabV2qvm5x7R8A0nn1gtteRMPck?=
 =?us-ascii?Q?Ix/PPWBwtuNXhxSJ5cWlStgtJBvoYbkokSmyBzI6HoeENIIUcxMIQdHxOn50?=
 =?us-ascii?Q?0CuZCuVQUB8AYSZwB6HpJOtHYyAyX+Fs/veSOmR8Pi6BNlWSPNPeDloxvC1/?=
 =?us-ascii?Q?SJO4MUtIPmkLxCAqk+nURQxwyjGtvFeh3puUYt9oiWjPCiw9/ehVGr9lYdZD?=
 =?us-ascii?Q?umnfa9MDqKGeDQYD9fhTaooKObI97tEtftg7g+VSeN42gwW3K7cyebyAF4Ne?=
 =?us-ascii?Q?5py/Pu1hDEE+h2odd3ef6l86qFnwx3zjynk9TAr00Q9GAkx9FOaou6ZLHnDH?=
 =?us-ascii?Q?12MDG/0qf4GGlewSMa6s9OYtcclthjNg0ZGIktTVww/IhtqTLxm+0UsnL0Cw?=
 =?us-ascii?Q?HfJOIfdIEHODLSW5cipgbT9UApONR9YdpykTMgE4UL3MBvRS7HOfK2subR0B?=
 =?us-ascii?Q?FqXD3BuwBIQj698zCmGX+G/OEJbRFQgKD1PBcIJo/N7Pg2nYnL9wzHR7n1nR?=
 =?us-ascii?Q?M3clA1T69YQiJ88JqvEkEhV+NUfjR4u5lp2q+wCrEZzKruDIh5/xZiTXVpMa?=
 =?us-ascii?Q?VEDcxyVo5bXwuhRKFtQYTOv0Rmckq09WtW5VAuojSOIKIPg+DiXvtwOJ0UPv?=
 =?us-ascii?Q?sPz+KCMqkU9XFv2j4/+vpg8frNOoIpMmXukl5D9SbFTL9HGa1DMWJjIMzFpC?=
 =?us-ascii?Q?JRCDnTl16QvqCY8R5wUg6+9xgo7BVgKnMQAv8dOgXozZDO8XftO73BfVzvlO?=
 =?us-ascii?Q?NLAxB2i5tUqD4R5/IA+tyaeofUqagbNZR5rbpvcBUaaBSuvzGlzgtc8qo/de?=
 =?us-ascii?Q?VJvXVyOsf21sq+5oXNKszuGVq8valGkx65edqEUdOlgDX1llO/p84eabh9gm?=
 =?us-ascii?Q?4ZF23hSCE+fO0OtD+Y57aUVs1DVBbHLPQyBmMSV2+0zHV1zZG9y1L3YS1zL9?=
 =?us-ascii?Q?s6/9XIEwbWC4Q9PiT6tdFfusSij/YnIRkf/R/3cG0KZwBZpCJD9b77MbiibM?=
 =?us-ascii?Q?aDbim9oVR+Nz1Digz6H8jqrPRHy6ZvNhnOOrpYVaOL0wfatCSK1KW2pDeCPM?=
 =?us-ascii?Q?IyD+RvotReLKEBqCB6HXMUSqVJcPSLcoQBJbV52ew79eQ9aa9BcVJZ3LqzWP?=
 =?us-ascii?Q?IakP6rctd+hofiMGHxStSGUqhtreqRXOeM9IcmrRIgN3er+TIrybKAq6AtZ0?=
 =?us-ascii?Q?R77oV9uCjI1lQs4v7IpPA0qDjBhGxow3/v7NxNBWFl1KshUoI/icpmK+Fs8q?=
 =?us-ascii?Q?tMmwhhPEkDLOFZ/q5f4LaRf9tlnRij7pyVX3IQmnxiQHtXNpKInBQFfDoQh/?=
 =?us-ascii?Q?Y2Nq5FQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?YuEZCOPEGyEIbzHPtKKXhSHMEhV6V2yck9oClIJ7Xu/oeQ1bGnQwi2LfWbj+?=
 =?us-ascii?Q?bwuO2fhV32O9fl1dPaGB6x8cDaIAiNUaqmIy7xGcYJJQz5QE96HPV29gN8LI?=
 =?us-ascii?Q?ON7y0v0z0qsjts+5fvAQJo1+J2bQ7FU7pFwgrqUub+DMwEIXkeklf/qht2SK?=
 =?us-ascii?Q?vq5UY+iI+tMxf83BLcWb6NdUX5+2/e+aJayAcLpm8wYlXArtjWeFZ4BNERyp?=
 =?us-ascii?Q?9LJGDznirb8TjktbFYar5QWGDJZMFIVzkvh1UID2w467r5yZ07kBzMwo81bx?=
 =?us-ascii?Q?0BbzafSnHoR3pj3qQKDV2mmmVy1QTeqJd8t6IZYQAFrTtzRHu8FjfO54qveG?=
 =?us-ascii?Q?jVtoFbzTjXSENczRvoyD2qJkTWV2lxpbYY08mowxBCU952UsMdq/m/Jq1Nfi?=
 =?us-ascii?Q?28xaC6CRnhq82VLOwEkeDcHSsYr1I24zxQ3o/fB9jQT6P9GBsJ6suu3vuPIy?=
 =?us-ascii?Q?vHJyxC5t6TCfidH8pohkJMoFIZDofz0BAAX27k/fGkjbutK6Jsq1yc/jxfZW?=
 =?us-ascii?Q?ReomKbVaItDpyrM3+jVBZP/MXqZSg8xi3Qg5/gj05bmPWM7I6T3LrZGEOXN6?=
 =?us-ascii?Q?YxU0Jd2m55Z4lkoOXi/V3wMzOTy0M4CUIhOroSvnt8UYM3jzz1flgAhNnF4K?=
 =?us-ascii?Q?Cna6KHngsPXmCpg2r7IzvO4oACKUqe74++gAHSuRFR5AsJ1rpq/1xI351Zdf?=
 =?us-ascii?Q?s4qVde8sLLbRv5ix2xy7UDxOBAbHoXaMKRRpEzCIKUcJqoSkXRkZ9IHtQVgn?=
 =?us-ascii?Q?I86dSd5Q9y74yH9W+OPmJv4J9h0ZdFiCMlItht8AmFzqDElTX5BUh6cb8yqa?=
 =?us-ascii?Q?QxmpIFrQsTdPGYBElRfyZL5Mf5+6Hk55fgK6HibC1wAnlF74i0DdkEpRVOM5?=
 =?us-ascii?Q?vUh7yA03vQeu40rGCP/B8d4yxn5t4eWv+8SYmF8MV8RbMHuSsLPAHyROjb53?=
 =?us-ascii?Q?Du7BQ9uQU4a7o3qwuEUi3uMhARSqNnkC4O3qGEvx8c15dvEFUG3212E0sVaT?=
 =?us-ascii?Q?QKxOWwxfB85bpkZorqs8nXCQI6WQc0kwIVf33VTQWOEn9GUcAVMIPW+qmS1I?=
 =?us-ascii?Q?o1GSwwzG4e/sgr4QV4A9Y++bJlVtwA1miRakyFTclYvrFUScqHd0vh8Kr9SC?=
 =?us-ascii?Q?7zUfhEpc4S6HBRH0A+kEV0Qr2N7MyqQsv9x9/fiJ/9V1KTNxqKzzlDX/nU2+?=
 =?us-ascii?Q?MZEUXu2RTV0Trp6WPRDCu/qOHNT4e81we4SnZhNUQ7C9h+BJvA0Vm0esGbHu?=
 =?us-ascii?Q?U/w+CJ9W+6dIbfYDa7xb2ZFI7guHUELp9425lrVrM29zysPNl3hpf2FOt3R1?=
 =?us-ascii?Q?kdbiQBYIwwOI2CmuAbRZcaS+545mvsQSRo2PwZunU9ixY+VB5p0FmdmG0W8P?=
 =?us-ascii?Q?x132dQ+CEGc2i/A1GNCaRB7k2Ga/E96uZoimBKf7tbjUnwEaDQWuv2ZucBSl?=
 =?us-ascii?Q?YYprwcn1Tv/Yk+JakkM8yb3uJtD2nQUIH+bpoFZS55dnCdbPOLtOfnkI1HQC?=
 =?us-ascii?Q?rDfBrwe+9n60gIqKdtb4+4cAxSGfGbnBdHtsPFYjW/OC32GYC87gCFTP8EXM?=
 =?us-ascii?Q?fjktjOPl+0RmOELPzLs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2b6ae5-feea-40e0-9992-08dcde4cf7f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 17:02:14.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /33v9PJBkffVSgHDOGQDjQzYDC5lp2tVLp3whtgVAqRg0CmKLzQ50fCPCz7o5R0LzN6Ixq8wfv20YffVeXfRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9646

On Thu, Aug 29, 2024 at 05:13:57PM -0400, Frank Li wrote:
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Alex:

https://lore.kernel.org/linux-i3c/20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com/T/#m16fa9bb875b0ae9d37c5f6e91f90e375551c6366

There is some discuss about assiged address, I already explain the reason
and ping 3 times,

These patch are actual fixed hot join issues.

How move forward?

best regard
Frank Li

> Changes in v4:
> - See each patch
> - Link to v3: https://lore.kernel.org/r/20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com
>
> Changes in v3:
> - Fix build warning
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-master-Remove-i3c_dev_disable_ibi_locked-olddev-on-device-hotjoin/20240814-234209
> base:   41c196e567fb1ea97f68a2ffb7faab451cd90854
> patch link:    https://lore.kernel.org/r/20240813-i3c_fix-v2-10-68fe4a050188%40nxp.com
> patch subject: [PATCH v2 10/11] i3c: master: svc: wait for Manual ACK/NACK Done before next step
> config: x86_64-randconfig-161-20240817 (https://download.01.org/0day-ci/archive/20240818/202408180012.ifcIOjgX-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202408180012.ifcIOjgX-lkp@intel.com/
>
> - Link to v2: https://lore.kernel.org/r/20240813-i3c_fix-v2-0-68fe4a050188@nxp.com
>
> Changes in v2:
> - add help function at i3c: master: svc: manually emit NACK/ACK for hotjoin F
> Add below new fix patch
> i3c: master: svc: fix possible assignment of the same address to two devices
> i3c: master: svc: wait for Manual ACK/NACK Done before next step
> i3c: master: svc: use spinlock_saveirq at svc_i3c_master_ibi_work()
> i3c: master: svc: need check IBIWON for dynamtica address assign
>
> - Link to v1: https://lore.kernel.org/r/20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com
>
> ---
> Frank Li (11):
>       i3c: master: Remove i3c_dev_disable_ibi_locked(olddev) on device hotjoin
>       i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
>       i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_INIT
>       i3c: master: Fix dynamic address leak when 'assigned-address' is present
>       i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()
>       i3c: master: svc: use repeat start when IBI WIN happens
>       i3c: master: svc: manually emit NACK/ACK for hotjoin
>       i3c: master: svc: need check IBIWON for dynamtica address assign
>       i3c: master: svc: use spin_lock_irqsave at svc_i3c_master_ibi_work()
>       i3c: master: svc: wait for Manual ACK/NACK Done before next step
>       i3c: master: svc: fix possible assignment of the same address to two devices
>
>  drivers/i3c/master.c                | 100 +++++++++++++++++++++--------
>  drivers/i3c/master/svc-i3c-master.c | 122 +++++++++++++++++++++++++++---------
>  include/linux/i3c/master.h          |   9 ++-
>  3 files changed, 175 insertions(+), 56 deletions(-)
> ---
> base-commit: f2b9f0aeff2b3bb0446c955f0d8fac7659644c75
> change-id: 20240724-i3c_fix-371bf8fa9e00
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

