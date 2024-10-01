Return-Path: <linux-kernel+bounces-346400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ED298C44B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBC3282E77
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE741CB508;
	Tue,  1 Oct 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d1Sdt/NW"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D281CB305
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803059; cv=fail; b=b9rBWYqDMvqhe1uFcNskvsGuXsZq/UF+2mi8qxUz5PVVnUddpN3kPJVZHEl9wqcaYO7Q6AUIDoFtlP597L9Q6pk/miFh8IigXmIkTWBtwiFI76Hb31+hjNUEr+GgUu+lPjgTBxujah2YhyyNQKJPWzGETo2l1hXLwEEDHVdzdAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803059; c=relaxed/simple;
	bh=BAc6obUFCUnd9390rJvkTnQF3fpmg9C/CdqIqvzD2kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RZW6sj1C+9pqi5YbWebtDMShUy9arN9zv+1BIDyxR1p3dHMpzXpb+m6bW7D4f5QJDJitmQKNdIIsfCV6rGeE285zaz2ArUvg5NcyirgA8ipF00QMWQ2gt0myJh4/YgVGYUJFW5MlzSQf9EmGJP4NRlQ61LgU9JC5YQbdRMv8H0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d1Sdt/NW; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWPUcXwe7Gwi4KsShgTiQbijTQoJmcr7S9nlcFNq5Rq1bJtrQeKwvMigBWb7+tAdqwrgIWUTYbSNiMTCRbM59O4tCIahHFNGnyba0UGvBErv7zl/QvMqQmCDTcNSboC4hmyPceJZmmf+W+Nc6vj9DdS6u1jkQhJsNxCdvvpARL6oyrLSX/+f0lL7Q7hqLALwSfRYVoIBvSLKbWJ+NfQ2bM8IxZ7heRJQP3Q9lmqc4O9DGzUFBN3zIpv1XYMC6sEt2sHEyGVcIDiOrCU5xx4S8PBXdQH8laNTXjbjabOVAplI2HHN+InVBOFH+FXKfoJ66fLlvKwiFoz1Z9VWnbJKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnWgU/OJemYmKwCyunUKB0s4kqCxeRT3mKH86uyUVQU=;
 b=Do7KcLFZKaU3XcYfXoqtxUPoX/WUKP3Rnwubor/Yr206FRgZu3DwH7TphRlZ78+Qfqa9o0kSugpsMRYQFUPThE1YScaFN2Sj2DrND4WR55ZFuSR78rSycsz5LfM1SmPyx7fhxqiix/rKozLMtYQ8qCCpNHirdGbdPotddkh5UfbtDW33JdzBu0K61RA/i4hl38/RNQHa6wHgLdGeFUFU0I/9ktLAtSawiVUYbguE4VH3uowkR1HNcCh9ByUD5nAQX+ZtslAAaFbOf/4AeXP4qyZHnVcGSXFWBTqdIYQdzaraTblfZmkZE9OfAYJ2jlwKvOgsVm9XFN1vULMCX003mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnWgU/OJemYmKwCyunUKB0s4kqCxeRT3mKH86uyUVQU=;
 b=d1Sdt/NWxWQVdiE+O2caC5SN3IafTlklXTpit+OVyoHpiI1E9TYK0AcAlJ54C1WAZeF/VEnNMDHStlK+wcq67PwYkm8fYJWVwBq8NlC//i1badP71ldodJA6yCWDRv7KM9ACE/vbvA6bgkYs6uN0KNRoaqjz6SkhQZ/mWe8p3Y7BWYXRJHRk19NVYSKecxNtqBBiTTdAsnZnYhi/ou70t6kVhHHWQq1X4vJziByecwBVycozT+lSY3nYiOjGN6u/FCTm6DC4dAeLAMsgMC6oTp7ziNxGVZYnTGiJxreq8HsuPgi44M+FOqYfOgIQnMXrj9bMTSEK5HbdtkVV8IreSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 17:17:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 17:17:34 +0000
Date: Tue, 1 Oct 2024 13:17:26 -0400
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
Message-ID: <ZvwupjAlaxZwGElB@lizhi-Precision-Tower-5810>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: aaae8fa1-f61d-4438-7746-08dce23cf076
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?iFB/M97WYvulc10lMJrQvaRubfV2BLH/Cv4+UuV/gXnxeYsjhA4qTwEk6Dbg?=
 =?us-ascii?Q?2POIOxkdZSNRw45xjpeD7825u9UKiuz04VtHSCsoIa/sqP94rQdfnESE/T8q?=
 =?us-ascii?Q?X3kcaNMia1yU1Fhze8fjPunWSXMV8TKXjwygjH+YGULxTuNscZdASZuAjvZ+?=
 =?us-ascii?Q?jSCusH5kPm6vdZmqfU3Gkhj4e42N0ikOFmzjjEVyiUrRX1rTqsuga2fYGJ6+?=
 =?us-ascii?Q?Rk5uVjcdjIoUWEbYLcLLoFrtlRVijQT3KRq7dyDyhIa69PqKBVO/f277HIj6?=
 =?us-ascii?Q?ySgkaU2wjwvER+tkNHMWm5dMG69SgvCsuqltxvvYDcLHsKq+jFWNOCmEbx6K?=
 =?us-ascii?Q?e29bIyAPBGZPPpiH6qxIBe2/3oezZbmwY9ePuit6EaypF315P3gDOUv4QjaM?=
 =?us-ascii?Q?mgIv6HUTFE1s73D0+d86dX861ZC9cZSEy39l1n2tyQGXSl2hs/3fnuUceDdC?=
 =?us-ascii?Q?mi6bLl6Hb/viohzYdV9TT7w2U+yPceMWuwxCI/s2iwIlu3uSTpuETN2V3MOX?=
 =?us-ascii?Q?/UCHtDieuCiumiRJY99esvHaQ5vGSVf2aGIuat46AnNkGjcTXgFJDc/Y1Lpn?=
 =?us-ascii?Q?cVtwC5jmgyPDAO3u+cwE+Qy7lYTXedRQitvFLtO0gcyHwTXPg/YlmDTZnLTx?=
 =?us-ascii?Q?eImTEv69xiUFjvjWHPuaYOwGJ4qY+LD/nk6GtzF3lpN/KZ60qgOUq6ewZwFx?=
 =?us-ascii?Q?s3egc2UsjhbDyZM2uveKXP9XLQ/cMKBQJX0mxdKxYb092+PBXods5H6cJRoH?=
 =?us-ascii?Q?C4IFVRTGujH746AvDIuEAjLDJk15tkXHGG0LvmNlgmdVb6aQkbL+3AYASyr/?=
 =?us-ascii?Q?vV9+n0kIoOFpho8G61VFMllluh5FSbCQn9KnHQ3Q0vvQJwdN0WLw3gtAuMIZ?=
 =?us-ascii?Q?VxCKmIXwxlPvhEsfCdIgmPJYK9P2bbXA2jC7CY9Za0CWn0KetwPurpSCIoVw?=
 =?us-ascii?Q?Ad71PCExDwYmQlefmbzQlGQ95jqaMaxn+RR0Vp3J86Kolzr8cUeAJtgjXT2n?=
 =?us-ascii?Q?3mriNr4CBnobGmxRDGExzguRw0zRPre+YeUHUYEqrnTNTZNh/rXAR0cT2+cr?=
 =?us-ascii?Q?tgy4pdBk2XyfPG5PEAo/WaYRbxLSj6YPRFhdML7S2dxjsHmfkspFmJFyt5+P?=
 =?us-ascii?Q?HufIku3xNosgZV4RL/p4C6z5qY1Xx0EXxW3QnIHlqujGiXJIz+TD02F6CRTl?=
 =?us-ascii?Q?ZZOvwt0lDwJCrXiKaIHawqezWfOZhyA7Gf9YMudQKnntYtspvuDfkgmrWR+d?=
 =?us-ascii?Q?+CUvlX5K2pcRgSWlrrpCRH1H0cIKuUWOJY35FDNW9yVJPzb6svSdzMOeWUwy?=
 =?us-ascii?Q?O7A=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?EOne9aMsgIoAT6z9WBOLQXpFC3tJ4crRxXcElthZb4FdK0S32DcWCQr7XWDe?=
 =?us-ascii?Q?gmI10ew2vHB7XtN5shRvRAjOhQijx/jFh9d9mZquKS3uS/U9loH7F4RXpOet?=
 =?us-ascii?Q?drbyXnTIETrJ3ciF8kuyV35ViyhNfhklF1KnMm2O27KER4OD76j0r0RQ1Be3?=
 =?us-ascii?Q?7aaaR5+SY9p1B2FJtOtGjMJGejhHOtxoXiEtVgY0OqMxJLYM0uUII47gUVw7?=
 =?us-ascii?Q?tTxeAigvZQ/03+Y6d6JI5yHTEWel7KKZEr885nuV78+WCRCT2AhPuxWW/C62?=
 =?us-ascii?Q?A19H0bgTfUP5aGT91YFDb3Jxw0Ono1k6qZYX8STvRBoc7QAUOCBHVRt9fUcT?=
 =?us-ascii?Q?n0fq6fVE3HHzCK+xsjN3fM3n/r/WTF3f5ZvrrzKxOjlmoI2JhQWg1hy6qAEl?=
 =?us-ascii?Q?COGhPxd6nhjglj03tMyxpYMDAOibH8tAKV3GKiSOCRGbFr3uQjnCJ4OhqlI5?=
 =?us-ascii?Q?qvTg7wqepG6FulSDvqr7HcokJ9w993kCQCALEH2tCR5Nv/RGR7CNDJXIgCYE?=
 =?us-ascii?Q?vG+QIhINx2jszpNz+khJ8i4BVZuCpzZ8+Q67QZYYiPH2ITFs76EuLPqC86E6?=
 =?us-ascii?Q?US2WPc+3KTD2EMIinVVTmtrTAjcN0mMHGBfzeg7Vy+Rf+m/uGPmrb62Uii9l?=
 =?us-ascii?Q?U3HSg0QLCrD4RWXDO81HEH/w6vNFq8SVm8fKsY5Mv88kedz80DowxLR7G9/J?=
 =?us-ascii?Q?OsgFoKm37MnpWRy02e7Tl/YemLpjZltEIZf6MrVg1qTrlQYdZQ7g9Y3YSF+V?=
 =?us-ascii?Q?iOLL9Q6iG6eaD8TW6UOePND/GRUlxdYMAX1VzhPWHhvPExs0WfO/GGcEFURK?=
 =?us-ascii?Q?rltp0U085zBBMh+u5TYOIsVi62cCJ3XhUNzdbViwN7LdJ+2zDfz8ZfbFOPfX?=
 =?us-ascii?Q?OcczjVoFH3IfWtQAivIk44qiue0s18q7S6smQj0CNX70R0MMW/9qk1IRYyZD?=
 =?us-ascii?Q?694NjAn0y4ggHATn6wuRJQvFTk76wKpVuVNW73u8VjGRBE63FYWbQwjmcFW/?=
 =?us-ascii?Q?AicUzBAV3hPae/cbZP5gJgZ/8RPb65nUAvKWjYUg6qvSMcDNQtGS8b7FAbA6?=
 =?us-ascii?Q?t3HRaQ5NhDsIwBtkyADWP6TZYe/5Dvb0LMaPLNA0ILCyIOEGhI94QGvVoxDe?=
 =?us-ascii?Q?/db+VpY9sjh+2na0bmzgnHcJW/rtQdzJiSLhi4hPBUk1n3qoNmG9zv1aAmo1?=
 =?us-ascii?Q?vKR2Phbp9zZH5+5RBTqaAU/mPhKoKAGOFAGXdaaprcXlRZowt/C/MucujcIb?=
 =?us-ascii?Q?s6xF3fLhF3m9gqd+TjkT4FMw1U2mCiqq+m5EooCrR2KYHIAxCNj9iQJNr1V9?=
 =?us-ascii?Q?mmxG4DTNEkjcf8mGcmgPmZwd0Ogrcz+UUzTRsdOFy41VKf+urhCfhQ1BrUCw?=
 =?us-ascii?Q?z8in0S7sqh5hVMekLMQxxgy2US9qaT9AtEPVuvOjEcQdmc5HYzrsSsBDiTCx?=
 =?us-ascii?Q?SzoO9ggJpDY00UGpl7X36hSIeKl9Scah1khmcjdjA0SRrDubWuYVar/T37XH?=
 =?us-ascii?Q?Xxsek5NQqOIv58mWDZEiivMXQIJLu03N6/Zui9DW25KfAW6ziB5/VhXtDO02?=
 =?us-ascii?Q?tLRKCEjjJMKAk8CzXfc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaae8fa1-f61d-4438-7746-08dce23cf076
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:17:34.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vNCM8rXfnmUfVi/ju/KLGaFEhSddoX7tvjJylPFc8FewNxU23X+OqbJ73NhrcO7aJ0VthuqpCPtieViVpX/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

On Thu, Aug 29, 2024 at 05:13:57PM -0400, Frank Li wrote:
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Alex:

    you can superseded this serie. According to mirquel's suggestion,

I splitted into 4 parts:
	1. svc driver fix patches: https://lore.kernel.org/imx/ZvwpMBWzNjTXpPZF@lizhi-Precision-Tower-5810/T/#t
	2. i3c master fix patches with miquel's ack
	   a: https://lore.kernel.org/imx/20241001162608.224039-1-Frank.Li@nxp.com/T/#u
	   b: https://lore.kernel.org/imx/20241001162232.223724-1-Frank.Li@nxp.com/T/#u
	3. ongoing discussion on about dt assigne address:
	   https://lore.kernel.org/imx/20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com/T/#t

    I hope above help you manage these patches.

Frank

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

