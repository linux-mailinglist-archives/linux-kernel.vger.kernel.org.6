Return-Path: <linux-kernel+bounces-337300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA93984861
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A631F23371
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B31AB53F;
	Tue, 24 Sep 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HzhKGcd2"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC69182C3;
	Tue, 24 Sep 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190929; cv=fail; b=mnpYSmP0OLMtSq8UtVB3FFYjUOupECwMU0FB3yWFDJxkrkE4EfYBQLIL8TvhriUj0jjvO4bA7IfrPUqyiNh6IJ6yC6uwovvcZDrqY3UikEcaIhOIrq80FTE+lZNXocrbSodo+zoyHEhnAq+iabZTHefT5TkqnMPYptw0I+hUh4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190929; c=relaxed/simple;
	bh=uGnE0VRZ2WPPtVs0MMxnRGmXZ6WAKnKHHOXJoir3tcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XonXR/ly6PDrbguvLtwM3slQW+jA+NgIpn6L37t2n7o2TAJLSN85qqwUhM+EZqrmGcmKeSkwOqeMnw895qRPAKaEH49tNcVrRGTSZ9zpve9mZqaN09dKGiqILTpvuzGEtXp/CuEgr4v2Rz0ycNfX6DhgjfSu7PVuGQrUYgp3VKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HzhKGcd2; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldxfDYY1ChND+06GqkvuUbDchODJ+WcgPoLpB4MRgX3cc0brHBfuomRO8fRriw769vkrtHADZ3FwnI/+wyVupRGLnxKSehFAyvLYZs9Bzcr+l4AJSZaBQ6rDizxH583IzFb+rFdwjVYRhLKYcOSOCpUumbtFrM0rOIHBaS5WP3enmkZl8+Cylz8fTQkBj8BtF5Q0BecZhljRJUCGxKe7MuK1cR+qHOBx6KIOjDU6wKj+Y1D8b5d49p61IuRA/85+Grj1v8XSv9+feAv/bcXCYvcSD+As97LlXW/59PJr/g6Heoz6Jg+0fw9lbj6wPuFEyCRHQ+Gr5uD8Obh+5WKl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7d1iC9gZYr7jE1cK8XjADKDcKhh3bqNgNXZiMO2TJo=;
 b=l4PZlbiqz5v42NtwT9iuRkLAVXsG48zfq8rORPaetLPHf1cspv51z8FmQlmEPs6T3BIVvI36qsUxl3wH33CkUrHC6DRGbqYefxTBt5GKXFMCuPpLyKzTUMNuGErlHGrrZ7tMur1yNgwx9eVpD5HiR3vD+Bfj97s4d0gfEGTG9DM4ZdoQYTVgYfm9wdufLF/UPu+FM1LrJe7b67ooGWwsiD7rnkU/tSxncXG/9uP+CCW4UnQvr46Yu4zN9K/rQipIV+r7mphqwB302WxLtqXhl+Nu7n2ExaXModMFuMG9Gjzh/OL9wi6KT0XufpJgsrK+2gD+GCaF2XPP2FJxmf7tGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7d1iC9gZYr7jE1cK8XjADKDcKhh3bqNgNXZiMO2TJo=;
 b=HzhKGcd2dfLhyhstZc0PdTW6i9lToVxKWakZetO8oBUrxG5Aq/cLvwAJgYP/uU0Z50hLdl4+uKEIxg4nglYHroGgbNW5qvTvmyBKfau8gNJoPhFGJgtMrnD0Bg3mlyHyiWV6xzzOpgvM9rzzMCT3/ZQUf7PXSPcaiArbIIvq3/hNj/kncCWWupprl2NMkOrtwCJeJUlZtFLKxni66d/w1ElSBkDdLkvMuUztX5TpdC1augv7/dEywplbk0O8hCn3krqw6v5zwe/gCUOVavGpJbIkRZWCh6j9HvarOiKG0r2oeIq0Zs57o1Yyv9pMZ+tibP+8v/09cLz3aw18U9eTSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9064.eurprd04.prod.outlook.com (2603:10a6:20b:447::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 15:15:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:15:17 +0000
Date: Tue, 24 Sep 2024 11:15:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Michael Walle <mwalle@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] arm64: dts: imx: Add imx8mp-iota2-lumpy board
Message-ID: <ZvLXenqG/++AR4We@lizhi-Precision-Tower-5810>
References: <20240924103941.1729061-1-michal.vokac@ysoft.com>
 <20240924103941.1729061-3-michal.vokac@ysoft.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924103941.1729061-3-michal.vokac@ysoft.com>
X-ClientProxiedBy: SJ0PR03CA0363.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9c9165-742d-4fd4-7680-08dcdcabb269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elFLK1NJVStMN25ETjB4U3BPOXNVSXdXMklGQUhFNEZyN0d2UGpOOW9TVDdI?=
 =?utf-8?B?aU1rcmVFODBURUxSZkdPU0xveGZ2d2hFei9wRHgrbVV0TUd5U0hjaHhNTE9N?=
 =?utf-8?B?RktuTSsweTlGaUZkV3oyT283T2ZwRHUxOXNGNlBGTE9BYUhWUXVyRzlFQS9Q?=
 =?utf-8?B?S0VSVGRRZzFveHpYZWJkSUM0YkMza0RCcjBaSWZSNkJGKzRIWldmTUd0eVpW?=
 =?utf-8?B?TmJGYkpBN0MwMWhDMkxiSFlZbmgrU3FUbkNhNzAyZWZwdW1nRHdLa1BtdnNi?=
 =?utf-8?B?K1pWNHRwQmZJV1Q4VEc2NXplclRtbzlNK1IrOXdqOHdFKzV5VzFBdVE2L1FL?=
 =?utf-8?B?NUliREhZNUZHQk0rVitlakR0b1ZzMGY3SlZ5KzZrRUQrbmFONmtmTmtac0dC?=
 =?utf-8?B?Zy9QN2ZHSjVTbjZkOFNTck1Sa2NHdzVTSVR6SnZML3pIMXdkR0dKRFJ4cGFx?=
 =?utf-8?B?NUFzS2owYkJIYjZFbWEzM0MyTDlEejN4S1hVL2FROXQ2dEpxUHZ0bVQvVGo0?=
 =?utf-8?B?elRON0xFMUhyS3Y1NUVwTmpwZ29tVVg2SFpFV3ErUmRPQzNFaVl3amNCN0Jl?=
 =?utf-8?B?VUFaSGtSYkFpUWZhTzZ6T2NvSjVFYTFLclFJcWhTSFlpRnFiYytVOWRrc2V4?=
 =?utf-8?B?VmF2clBzc25Pb3dyTC9jLzZ2cTZhMlViNnE2L2xDUXBkS2xEZDU4bjRVQThB?=
 =?utf-8?B?bEhQZUlpUlJtQmlXZlJGcGhibnA4Q3BvRlkwaUJvemozU3A5SzJWUzFjVEVY?=
 =?utf-8?B?NGxRcVpKU2s5MXgvVEgzeGJ1R0VMeHpmOW9RdmRPSWhycGVhSGppd1lHeW1C?=
 =?utf-8?B?VGlEamNZQ01ZN2o3RXFMRmRFNjdaTDk4L0JpK0w0K1VER0NFdjJFWjIxOVBa?=
 =?utf-8?B?SzBDRnpZdWdzbkwxS3gzbVA3aXNBdk8rNUdxRXJINVVtNlFJL1cxY0NWSk11?=
 =?utf-8?B?OXo0cjRHR0JpcTMyenNxRkE0WHk2bXNaeUg2aE16NTlDdkRSNWk4QUZ2L0VE?=
 =?utf-8?B?RDlhMm5wY0JBNHdVMTc4RUpSNTdndCt1ZGtON0IxeDJqdE1aOEdPTXBya2Rw?=
 =?utf-8?B?MlExWGlzbkhNcXZkT3dOR1M0aHNOak96alhDUzIzdGVjaXlSd1BzYXo1dCs2?=
 =?utf-8?B?dEZZajRCZTAvRUo1elc0U0M4dE1oNUZVVzVrYVozK25TTGh5Mm4vVVMwYzIy?=
 =?utf-8?B?TWpySlVNY2swQkJ5d0E1NXlWamhHWEVsZ2lSd3BSK2Z1T2R2QWJQZDQzSkQ4?=
 =?utf-8?B?RHdiSE44ZUovQUlrZEdwYktoTzlCeEl0NHhXN2lvRVlxYkNHaVdFOVlmMmts?=
 =?utf-8?B?elpXRGE5Q3ZmZnF3M1dvbmtYWVBxbERHNkptRmpjWTJEa3BIbHFna3dlNGhv?=
 =?utf-8?B?M3hRU0hIVHYyejZqN0NIQWlMcStjMjNKZ09JMUxTemlOYWJ4R0V2aldJQ1JX?=
 =?utf-8?B?UTRLWDIxeXNEcDg2RmEzU0VaYTlPOVdIU1krWnJERmxVV1RCMkk3OEhDd0sy?=
 =?utf-8?B?eFNQYlVGRHEzMjU3T3FuWGJRVnhtU09NNVhoNzhUNWVLczJrbjdVNS9PeXFi?=
 =?utf-8?B?TjNGNGw1RHY2cU1rY1VsQW9tTWNSMnVhamtHaURMQUVyV09PTlV3enVhRkNX?=
 =?utf-8?B?RkpGVld3WnJGN2VIUzdMWk1mREdYb242dXBRcTZlYUpWQThJY3FnYmNCeHYv?=
 =?utf-8?B?VEhDVEZwTTRUY3RCZTQzb1BqZ3I1eFB2Tzl2Wm9FcGN1aW5YT0kzM0YxNFkz?=
 =?utf-8?B?WmQ3VGNiQjdad2hadXJhMFFkc1dXUnA3QUZZMmV5eTl1RktHUTdDYnVFRVNq?=
 =?utf-8?B?Tm1NSWp5em1EVEx4WFI5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlRRaUlPdjQ0M3FqdEE1TytVT2pnQUhOSk50WGUvRHFGSndndUhHTGk0dlNQ?=
 =?utf-8?B?TXFVa3pBLzFQd3lsWmF6SnRIbkxBNVFxdW9ldU9IY0lRU2wwd2xXWGprdCtY?=
 =?utf-8?B?VTkwVGt2aGxVN1JFMENvemNkS0VpeHl6NW8yajVxVjZDVnVEL2h0SjljMUdB?=
 =?utf-8?B?WHdIVnV6RUN5c2l1REhhTjhWOUhyVmY4RzdhZWN1SHBwNDBlZDRRS1lGK0xG?=
 =?utf-8?B?YXJBVnNwNmhzK00rbTluWGVteFhWand3alFrcmEvbU94cEdXZ3cwQU5vaWtE?=
 =?utf-8?B?M0luZTVka3lXb1pmN2Mram9iU2puTk5CVGtScWR5cjhZKzFTa1dVSzJjbXVI?=
 =?utf-8?B?UC9KaVNKZjBnZjJTcmlmU1p0dDBneGxDQW80YWJlZmpoMWFjY0NodW5Yc2Rm?=
 =?utf-8?B?L0l6QVZhTEZscDBpWVA5cVhQaklEMFcvWTN3ZXp0a1ZPVnovck0yOXZVR203?=
 =?utf-8?B?VzR5bHNQSmdtMFZkc05LWjRkV3RTSFJGSHlUMVJpWDkrcjE3VFhaM2lqYzVn?=
 =?utf-8?B?Z091eEx0enVFRU5aVTZQTHBiQ2RrR2p3TllIZVRpZVo1Y1loRTd2OUlEQ1Zi?=
 =?utf-8?B?b1RaZUVFTDA4MDhFenU2dHlUaDgya2lIQ2d2d1N0YzNMQ3ZTYmtTTFlsZ2Iz?=
 =?utf-8?B?T0xLWVMycVA3bFhKblVlcWdIT0FTbE10MlZ6dHFWdDBnZElMUFlRcXI0THox?=
 =?utf-8?B?ay9ReS9JbFdPY2dXOHlnY2dYWWJCemsybW1BVXdHUXhPT2RkRU5JbE5zdWtV?=
 =?utf-8?B?T2Y3U2pucE5CL1c1R3dKbXJjL20rS282UWIybE5tK2xwVnZqMldCcjdxUmQw?=
 =?utf-8?B?eGViSS9nVFluSnRGZHA4c3pLb3hmRmplS0RLWW1jcGxwekd6YjhhbXpmNnp2?=
 =?utf-8?B?NUZNLzhRUXdlUmZiQ1ljLzFIaXNJclk5QTJPeDVOMVFZMlhlZzRVeDdJVVdX?=
 =?utf-8?B?dHJTVzZockFzNkVId1VKQlZpd2laaDBOSXdqdm5UdnR3R29PSWZkc29yR1Nu?=
 =?utf-8?B?MGxaa0E5ZGlucCtDcWdIeWRSMmlJYmhNaUsxOWxBNHc5V3E4bFZSU21rYVNV?=
 =?utf-8?B?MEdYZzZkNVFudGFJNVF1bUxZamFMNy9VTm91dGQwNllHUDU1eWJPTENUV0gx?=
 =?utf-8?B?U3BmbUpROUFjQS82UXlFRFozM25HdEZJZytRTHBJOUpCK1JpQ05qRWFPMitM?=
 =?utf-8?B?WTU1R2NMdXNUMGE1L1V2bEYzSDVxSVhsNjFyakVyNDhlZ2NlMlk2djFqTkVB?=
 =?utf-8?B?TytPUlJDV2xEOUJTdzNvVUdIM2F6Slg0OUg1R1dhdUsvZTJpL01pVGF4VDVZ?=
 =?utf-8?B?YnhzdEYyODExVlFFTDd1RWZXZGlzTldtSUtndFNaeEUwQU1TZjFxU0djRmRG?=
 =?utf-8?B?WWN1ZG5NWXM2a0I3MHhLZzA4UU9nRlA2dkpudjA0eGlMMU1QaDQ5cCtMQU02?=
 =?utf-8?B?NFU3blJGdjFoQjVuWm9JRUNOTmhncjhvdEJBd2h4dms3Qk5LYzk4VFg3clpk?=
 =?utf-8?B?ODFGUmU5Uis1WHdxYXBwaUZMaDNRaGN1Q2NGNjBwR05aWmZ6eVpzMW5Za2No?=
 =?utf-8?B?bGNGWndkU0x2OEdHWVJHMmY0aE9mc0lmNTRNeFNZM0lrUTNBVDl5eDJ3am5T?=
 =?utf-8?B?OFowWkFBNmZ5WjREdC9Kbml0OGxWYlFtZ2p6c3NKTVEwaUxTUUJiUnB4ZndF?=
 =?utf-8?B?S0g3Rit5SjdQc0hEVVFzeEN2U2hDN2Z0WmlyZDNXa3k2K0NMeWZlZ1RJcGtP?=
 =?utf-8?B?SFl5RDB0SkhDNVgraGxPN1ZIOUNOR0ljVCtuNGM3QU9tekM4S0ZRYXZWRjQ2?=
 =?utf-8?B?NzJnekFHUHhYdGlQdUNEdzFmbVhmS055NHhZTGl3dVlteUdTY0JhVjFtZ1lh?=
 =?utf-8?B?TEhjLzhQS000aU9rdFhqcExBbmJUWWJKdk5ZaUx2YmFOMXh4Tk9Zb3hFd2l5?=
 =?utf-8?B?ZU9aV3F5b01qQXArOXVrK3dNelpGa0d5RWFIOWFjWXgyK1JpckdIUGoxWjJG?=
 =?utf-8?B?eUlvYmc3UWJ6OHkwNEdlWU5IeS91M0JrbW94YlNLYUlqVFJ2a1FWK1ZUWmZ2?=
 =?utf-8?B?ZHBHUTNoWWpPU09BZXVxVXVSZUxOeGwvVWxjRVR3cElXV2ROWnBCU09iWWxp?=
 =?utf-8?Q?rjRQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9c9165-742d-4fd4-7680-08dcdcabb269
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:15:17.2923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyTMn4mQp6CBD02W4NTPdrn4BP2+0wljV9pVKtKHcwU7yE+gbBuH2ghNohk0VRZAeFoJsR8l43DZg9K8LP7DyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9064

On Tue, Sep 24, 2024 at 12:39:41PM +0200, Michal Vokáč wrote:
> The IOTA2 Lumpy board is based on the i.MX8MPlus EVK.
>
> Basic features are:
> - 4GB LPDDR4
> - 64GB eMMC
> - 2x 1GB Ethernet
> - USB 3.0 Type-C dual role port, without power delivery
> - USB 3.0 Type-A host port
> - RGB LED - PWM driven
> - speaker - PWM driven
> - RTC with super capacitor backup
>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> v4:
> - Moved the iomuxc node to the end of the file.
> - Moved the bus-width and non-removeable properties below
>   the pinctrl-* properties in &usdhc3 node.
> - Moved the fsl,ext-reset-output below the pinctrl-* properties
>   in &wdog1 node.
> v3:
> - Dropped pinctrl-names property from &usb_dwc3_1 node.
> v2:
> - Dropped unused property from pwm4 node.
> - Sorted all nodes and properties using dt-format tool from Frank.
>
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 423 ++++++++++++++++++

Suggest use https://github.com/lznuaa/dt-format
sort node. any issue, let me know.

Frank

>  2 files changed, 424 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 9d3df8b218a2..aa26a50b7bb4 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -171,6 +171,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> new file mode 100644
> index 000000000000..9eb58e818dc7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Y Soft
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp.dtsi"
> +
> +/ {
> +	compatible = "ysoft,imx8mp-iota2-lumpy", "fsl,imx8mp";
> +	model = "Y Soft i.MX8MPlus IOTA2 Lumpy board";
> +
> +	beeper {
> +		compatible = "pwm-beeper";
> +		pwms = <&pwm4 0 500000 0>;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +		pinctrl-names = "default";
> +
> +		button-reset {
> +			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +			label = "Factory RESET";
> +			linux,code = <BTN_0>;
> +		};
> +	};
> +
> +	reg_usb_host: regulator-usb-host {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&pinctrl_usb_host_vbus>;
> +		pinctrl-names = "default";
> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-name = "usb-host";
> +	};
> +
> +	memory@40000000 {
> +		reg = <0x0 0x40000000 0 0x80000000>,
> +		      <0x1 0x00000000 0 0x80000000>;
> +		device_type = "memory";
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&eqos {
> +	phy-handle = <&ethphy0>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			reg = <0>;
> +			interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-parent = <&gpio3>;
> +			micrel,led-mode = <0>;
> +			pinctrl-0 = <&pinctrl_ethphy0>;
> +			pinctrl-names = "default";
> +			reset-assert-us = <1000>;
> +			reset-deassert-us = <1000>;
> +			reset-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&fec {
> +	fsl,magic-packet;
> +	phy-handle = <&ethphy1>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy1: ethernet-phy@0 {
> +			reg = <0>;
> +			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-parent = <&gpio3>;
> +			micrel,led-mode = <0>;
> +			pinctrl-0 = <&pinctrl_ethphy1>;
> +			pinctrl-names = "default";
> +			reset-assert-us = <1000>;
> +			reset-deassert-us = <1000>;
> +			reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9450c";
> +		reg = <0x25>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio1>;
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		pinctrl-names = "default";
> +
> +		regulators {
> +			BUCK1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-min-microvolt = <720000>;
> +				regulator-name = "BUCK1";
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			reg_arm: BUCK2 {
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1025000>;
> +				regulator-min-microvolt = <720000>;
> +				regulator-name = "BUCK2";
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			BUCK4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-name = "BUCK4";
> +			};
> +
> +			BUCK5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-min-microvolt = <1650000>;
> +				regulator-name = "BUCK5";
> +			};
> +
> +			BUCK6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1155000>;
> +				regulator-min-microvolt = <1045000>;
> +				regulator-name = "BUCK6";
> +			};
> +
> +			LDO1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-min-microvolt = <1650000>;
> +				regulator-name = "LDO1";
> +			};
> +
> +			LDO3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1890000>;
> +				regulator-min-microvolt = <1710000>;
> +				regulator-name = "LDO3";
> +			};
> +
> +			LDO4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <950000>;
> +				regulator-min-microvolt = <850000>;
> +				regulator-name = "LDO4";
> +			};
> +
> +			LDO5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-name = "LDO5";
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	rtc: rtc@68 {
> +		compatible = "dallas,ds1341";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&pwm4 {
> +	pinctrl-0 = <&pinctrl_pwm4>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&usb3_1 {
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	vbus-supply = <&reg_usb_host>;
> +	status = "okay";
> +};
> +
> +&usb_dwc3_1 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
> +	assigned-clock-rates = <400000000>;
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	pinctrl-names = "default";
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x2
> +			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x2
> +			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x90
> +			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x90
> +			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x90
> +			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x90
> +			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x90
> +			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
> +			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x16
> +			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x16
> +			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x16
> +			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x16
> +			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x16
> +			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
> +		>;
> +	};
> +
> +	pinctrl_ethphy0: ethphy0grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21		0x10
> +			MX8MP_IOMUXC_SAI5_RXD1__GPIO3_IO22		0x10
> +		>;
> +	};
> +
> +	pinctrl_ethphy1: ethphy1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19		0x10
> +			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x10
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x2
> +			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x2
> +			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x90
> +			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x90
> +			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x90
> +			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x90
> +			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x90
> +			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x90
> +			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x16
> +			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x16
> +			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x16
> +			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x16
> +			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x16
> +			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x16
> +		>;
> +	};
> +
> +	pinctrl_gpio_keys: gpiokeysgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07	0x80
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2
> +			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
> +			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x1c0
> +		>;
> +	};
> +
> +	pinctrl_pwm4: pwm4grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x102
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x0
> +			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x0
> +		>;
> +	};
> +
> +	pinctrl_usb_host_vbus: usb1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x0
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0x166
> +		>;
> +	};
> +};
> --
> 2.43.0
>

