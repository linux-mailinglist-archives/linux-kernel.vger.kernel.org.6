Return-Path: <linux-kernel+bounces-317101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 504DA96D935
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B901F2BAE6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7D519E7CF;
	Thu,  5 Sep 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="JcR5OZdP"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2094.outbound.protection.outlook.com [40.107.21.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD119B5B8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540239; cv=fail; b=J8gPQDalQsIeVtUtGPhA1e55yAGr7j6e/U0Q+X6vaBT/eLwbqa+tgpw2vi6R1E2p3C5BcE9rQg0pMis84d6x7maQDs4JGvdOH5yoth8yaLZmUYBAp/FHMIfluDuPcjbvxkQYpbBUTkVmb9h4xu1pIXkHvqxBs001dfObAFHTOAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540239; c=relaxed/simple;
	bh=lEHB2T4kwEVR0AyLMN4wYDhHjjppZHye8Ku1lQmIGmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PHaqVXzxYWoiLQNfxg9Zh7SEymBMau+LQSlzCOXBJdCT6oweZZf86iWwYyI9pv7Jx1x8iMt47xEOVVkSafcEASygsii1dS9+AWTn+8O3afG3Be0wiBSWWaMSSz0yHbz1xmdGqGdUMzsL8wIir6JEWryH4j9zgUvHI452qoP6B28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=JcR5OZdP; arc=fail smtp.client-ip=40.107.21.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoFVrd4ejnYrMheZ0G4GLt5+ZezH79vfRwqGz26PTVjVf6NHiRHPSiJXCgitzRnT6YLWZiysASWshgn4XYS9VVtDwvP3zQ+WUz5RWTqiNaWn1VmpXuMtoW9GdQ+Qv+74Eezzm3k+kRpJbYbQP8EKgAmeq1NKo/AfrcwjWv6Rhv4Nz2jtznMsSui5fX5YzIBjgI4zORCIYVoBMnAY2UJZ5XFo/cvfEP/LYKMJlQKTehGjDjqNBHVK3D3e6Sksq3imeEVZafeUCh3WjII7O/9V/0yZdjiPY/umheWKUDfK79T9Q2H/hJAfEVLxVZqS5OqWtxYkv2n5FLa50/Kjmtt/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA7OHq6WJYQt/7R22uiMApYLqnHH2EEcqfdtnpvUAzk=;
 b=SuohBPIhejl6bQ9CHq3+u4ImI/2caRe8PsAEwpiAx6lnBVM5cGv3Iasv8+JnmmPlPUQz4cB56gVVPIPox7o/HUBzUct7bjHdYdmBp1YuEn0qBX9sRO3ZQ2An0LHHDkjdXf9Yw5xdcuhqm9OnJUi9BS1rwJBgShZCKNVrjKFz4Po0EsXmiiS4bYuXjlWaSnIVL8xChdphZnvwxYvLeUXnIzjQ8BwtCmV2+rnd+YZ4FUBZOV1c2vOU8+HwJ+m0Ayyx36FcrC7izmHwVvURY9HpVy/YCi3XBycMtav9AiToGjPPkwxJto+0RXBDD9sToSIxzCB37/Gl0p+DHGe3w0LzgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA7OHq6WJYQt/7R22uiMApYLqnHH2EEcqfdtnpvUAzk=;
 b=JcR5OZdPnrFR+lEabBMTREb4DcOIHYVwaU/qxKdxnFBwLInwWcAlcR0hx1v9h3E6zUjMj2Vm82T4x5SeNjPakUXlYvG33cGYe/uJA2onY2srGen1Tln1ZPS8RQCKsqwmKqh5FDmJ4mb/5Rv/+KFMBSoSqBOVitrrz1r3uQjUYMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU2PR10MB7741.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 12:43:52 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:43:52 +0000
Message-ID: <3ccfb490-4924-47d9-ada3-22af95de8714@kontron.de>
Date: Thu, 5 Sep 2024 14:43:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 0/5] phy: freescale: fsl-samsung-hdmi: Expand phy clock
 options
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, dominique.martinet@atmark-techno.com,
 linux-imx@nxp.com, festevam@gmail.com, aford@beaconembedded.com,
 Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240904233100.114611-1-aford173@gmail.com>
 <0f9c3794-6bb4-41fa-8bc6-c00ecaf506a1@kontron.de>
 <CAHCN7xK_chbt3t2YkHRLmu+5wNg7KpDuJ0esLAMOav-2w5E4Uw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAHCN7xK_chbt3t2YkHRLmu+5wNg7KpDuJ0esLAMOav-2w5E4Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::23) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU2PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbf9a89-765f-4fb6-ba72-08dccda865d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHNsTXBxbHNmWVhDRDVxalNyRms0S0c1TkoyQlBkN3VrSEQvNzVQODQxcWYv?=
 =?utf-8?B?TUZ1b0N5akE4L0JieEVhZUU3cmd2T3VYS3RLdHhZL3gzamJmcFhzYkxiNjVv?=
 =?utf-8?B?dU1WbFhSRnJmZjY4T0xPUTBSUkhZZXYwM1YzWHk2UUdzbUdMRWp0SjQ0Y3pZ?=
 =?utf-8?B?QjhDWjhzdWtrSHVXMnBySmhyS0xXek9CZWhBc1dZKzdmM0tESEIwMXhyTUhY?=
 =?utf-8?B?ekxZYXFKTzZFOW5LUGZuVituRDJVaWpyMStHRGwyalBxeXlFTkNlZ0NjOG0r?=
 =?utf-8?B?WlNlTzVaVG15RlJvcGNHdWpmd2NBOGJ0aGt0TnM1em1yOEVqVEdJL1Q0b242?=
 =?utf-8?B?VFY0R0xud2syeVpDMUx0MzBteFByaDIxMkdPYlVBZlI4UFZscVFycXl1QnZn?=
 =?utf-8?B?VS9aTENLclBQanBHY2hqTmxZOHdRVVZybnZ1NHBuVm90UlZ3cVQ4RUxiSzBN?=
 =?utf-8?B?N1dtK3c5SGJwUnJDVS9WZ0hRMERPaUU0VXZucEpTVXBBMzdzV0tlYiszMFc1?=
 =?utf-8?B?dmpqVkx3bklHZk5ZaFVtQVdxbmpPd2ZyTXdPQ3pBekVLQ0J3eWRvdGt0amRQ?=
 =?utf-8?B?Z3hyYTI2ak4yc3pOaGVvS2V5WmpTNHJsRU5jNU9kaDBiSkFiNDRFbnptME1D?=
 =?utf-8?B?eXpmUjIyY0xCNU1kZ3ppdjlCeGphQnMvT0JWTHJjSm5mbUpzRS9xSSsvTWl3?=
 =?utf-8?B?R1drTUpGeUp3NEhzRUxUaFgrQ0xKUmUxUjUvUmtUS2ljbHJuUWhkSnFZaFRJ?=
 =?utf-8?B?T2FnWnV3eHV4WDd2N0Fyc200TjNPYTdZSzhSS3QrOTg4eVZNN0RJNlhjZlZw?=
 =?utf-8?B?OFVqcEVISUdzMEhsWWN1NmdBak5USUtsbXgzZXhFNkI4WkdOSUFPd1R5bjVU?=
 =?utf-8?B?M1NLWXA2RTFIbEllU1dMYVZKU1BUelJVamYwNTIyeUllRlBJQzFPWU5NSytR?=
 =?utf-8?B?d3Y5RDRBa3RwTUxXL2k0ZWJKTFNsWEhvaExHZkhZYU0yOG5CQ0x2Y2JBd1NP?=
 =?utf-8?B?M2tXSktkYWk1Sk44VUtRVUpoVXY2ZGxGQlNLcDBkNWpxQkUxWVlXQnRaS1ZI?=
 =?utf-8?B?MlNERWYvRVhVNDdsT0dtL0NwdXhYd3BUcFVyWnFSV1FSaXpoT3lvOUJqQkFC?=
 =?utf-8?B?RDlGdFFjQmYwcEVxU0QzK3lOb1ViZWtVaVZhZ3RkWkg5dGE5NXh2VGlBUWVs?=
 =?utf-8?B?QlJ0c1VRL0g4QzVPajVUNFVxelpOaG11RVZHRHQrTEVZS2JmcHkveStONFRn?=
 =?utf-8?B?U2RhRlorbTRFcy9zeE5ZTkxHeDhhMUpOTUJGbEcxUHMvcGJsWXA3Rmh4OE45?=
 =?utf-8?B?Q21ObjQ0MmovczJOYXdteG8rbzBZaE4wR2pua0p6cXVRZFg5NjIvSmlZZDdx?=
 =?utf-8?B?UkdzMUNwNGQvcHgwZmFFUTRCeHg3ZGZkanlQRXVXQzRHZ0htcEVqT3JQRHcv?=
 =?utf-8?B?VjVNMW9pRmFFUFZiU0RoMjZ3enQ1UlhQeUw3TERoOEJ3RVhMSFhJT2hyR05L?=
 =?utf-8?B?RkVvZWI1NW9keFV5cDF5U2h1cUFvalJ1R3M5dVlaMFVZS3ZjSDlUZnB3R2ww?=
 =?utf-8?B?NGNCdUREM1BrdGRZdWxCMmpHU2crMUwvRmw1aU5PWVY3Rm5Oay9naXdDUEU5?=
 =?utf-8?B?TitCdnBnWHNyOExzeFc4YjA5Y1hVVnY0b0Q4dDQ2WGl3UEx5LzV6WmNEeFhB?=
 =?utf-8?B?Z056VmVzaWxwbmJudXc0WUVWM2hDMXA3QjNraDhwOVh4ZDlnOFJyejNWbmQ3?=
 =?utf-8?B?RjFhQms2Qm1wVFloTEpES1V4NmFpS25mb2p6Nmx6SmltNWx5UU5ZZGFsZzIz?=
 =?utf-8?B?T1hPcDdDUmlEYzBDdEdaUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1l2dFZ0ekVyS0MydU94amRIZ084QjhQZVFVT1RnNStVUVVrL0tQN3JzSG1i?=
 =?utf-8?B?bVF1WHJYZ2tFdFZkeFhYcTZacUpTaDRBYy9PMkhmY1lIZDluK1RMZnk4MDlv?=
 =?utf-8?B?eU5uZ0xXeG5JK2kxYnFDTW1Ra1dRZGx0aE5BRmgzT3Jua2s4UHZKTTM3Y1Nr?=
 =?utf-8?B?MHN3MTR2TzFQY2JFRGZacU9wNW50L1paSHQxNGJjSXdWbEE1QkxFS2VLTXNw?=
 =?utf-8?B?VllyallxYnBOU0xweGsrOU11SWQwa3FBckdCRHBnWUxsUHZXbVVXQ0xhL0Yr?=
 =?utf-8?B?ZzdITkgyamdvdnNFOTZScDR6WTNZd0JzOEc1VUdEdEp0MVJGMUxNdnIxYWgw?=
 =?utf-8?B?Rnd4bWZZVHhld2dSWjg4TC9lLzlDR3FScW14bGl1TVRLczI3dDZicTcrM0Fx?=
 =?utf-8?B?YlNCSCtyZTd4M0dxaGIrTmxBcmx4bVlOSWdYdE9YOC9pcU4vcU1VK3QwbEFT?=
 =?utf-8?B?ZmlKamlLQWg4SVlSUVBVcFprWDVhQzRaUWtYTG5IcmYwNVVSK3M5U1QyUFZ6?=
 =?utf-8?B?MG1WSjhyclR3bVFPNldoM3c0dVBWenA1QlBNSnk4Qi8yMSt3Sk9xTi90UEc2?=
 =?utf-8?B?cCtkOWNKclgwQk1uRmk0UW5DcDdNeTY0TWNlZDMzcEt3RFlxYjg3Ukswc3Yw?=
 =?utf-8?B?b3pxV2xjVGVEY29kTnRUWm45cllvcUlyUmlJaS9jMGVlazZPMmd1QlljMFVZ?=
 =?utf-8?B?ZE9wZ2dVd1dRUGZVdHZ0Q0JoSUtWaVRLd2F4aHlhUWQ0ODhyWUo0QllieE1V?=
 =?utf-8?B?dEUwSEFSOHRlS3dJUkRFNEhGbGpYUjhtMTUxZXUwS25kRzJJK2xaVHVpQWRK?=
 =?utf-8?B?clRDeXVFVFhrazI3YmZ4cVpHRnEvdVNZSHRqaWhITEtqY2pLZStvT05uVTNI?=
 =?utf-8?B?TzJPY1dCbThEUUtMSUZjRGZHbXA1b1BiSld5VnVBdGU4QmpCSFZqK0svTXBO?=
 =?utf-8?B?c1luYkd5UkpqMzlhRlRLMCtkUUM3YU82K1NsdG1WTzBlcHY4R0VQVmU2SkJx?=
 =?utf-8?B?cGcvM1dLU3FWUzBodHYxNVc2eXNLeGwvanFLQ1ltY3gvcGc3eC9KSGoxR0hh?=
 =?utf-8?B?N3RQVEZHbzVuMTN3SmF1MUZzdUNxdjF0akQ2Nzl4MUxkUHBGY1Uyc0V6Z2Fj?=
 =?utf-8?B?dmZZc0ZKb2hhV2o0c1BEQXdvdjhUMXRhVzJibmRyQk9kWFJrSmsxOUc3UXRq?=
 =?utf-8?B?STBJeUI4cG92S2RlOFBmazd3ZTNOa2ZkYThBcVladWgxU0VQQmpYSWlQeUdz?=
 =?utf-8?B?aGF4bFJlUWRsUVJqZWhHUko1T20yM1FpZW9qN1QxTEJBS21KQStIenhsTnI3?=
 =?utf-8?B?VWMxWExqTzBnNTZrYUw5TmRRcXdqM0oxNXl2NDhRME1OSitVeGdSZFZacmhS?=
 =?utf-8?B?K3dGTTJYZHQ5U013T3oweEtORWRmb29EWDByMnJJcmluZUpVeUI5bzd0M0gv?=
 =?utf-8?B?c2J1T1dTMWVjOEhzcUpEYlN0T3RHUEM3M2xYNkhRY21JNi9pelRZMGRxTVRN?=
 =?utf-8?B?OXc5WGhybE1uZndMN002Y00wZG5oTTFwVjlOd0liL1g1d0d2ZUNucXE3RUNw?=
 =?utf-8?B?S21tSUszb1FDUjlieDgyOTlmeTJ5cmlaaEN1SThTNjVnN3lPSHpEWFZmZ1dG?=
 =?utf-8?B?SjJUWHZLL2FZbWlFeFl3ak42dmFua3Q3b2JsSWE2Q05PRUdHaG8wSWhnWCsy?=
 =?utf-8?B?WXN1WGtLVWgxWWhGcUI5YXZVdStTdGN5L04wSnFGM3JDUDdSN1AyYXEvZDFs?=
 =?utf-8?B?NlFoMjQzMCtaRzdySHBZN2gvUlVOdjlaYnF3TCt3RC9icXVXbTk4V2pUUFc5?=
 =?utf-8?B?OUlXd3EvVi9DaGNubys4ZWhrdjA1N1plK0drZlJXbG8zMVRXLzh2VEJYVFlK?=
 =?utf-8?B?Z2FkR04vcnd3cEVhMk5ZVndCVGs1S1FYS1hmaGdwaXQ2YWJ4WmRPUkVkaTJP?=
 =?utf-8?B?S2FKZFE1ajJuOC9NZUdwekl6MWVLRm9CZ0lQc3FVWGhNTGE0ak45SldBb25H?=
 =?utf-8?B?K0FVbmRtSUpPS0NRZktkaWJZZ0FtNVg2a0sycFl2dWRGS0w0d0VDek50bStN?=
 =?utf-8?B?emErUnVLUnhIU1hoeHpncjNLekxWN1l2WjRDTG5oM3BuSHJiemNNdDhMR3pN?=
 =?utf-8?B?eUtNWjdZaGpZMlFiREM3dmZQT1VmaWRjSGlyTGdnMXlXY1I4THEzczBEbkdw?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbf9a89-765f-4fb6-ba72-08dccda865d3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:43:52.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qflWl68CHWGQjGA3aT9+sbSs6chgvtAFqUs4gPF2mucarHO/MO0uQ1v6tNfFwUJ+wCaX1AVtEP/PsDShz08DGV99LpJL/VTiIr9MYDX/0dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7741

On 05.09.24 2:35 PM, Adam Ford wrote:
> On Thu, Sep 5, 2024 at 2:49 AM Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
>>
>> On 05.09.24 1:30 AM, Adam Ford wrote:
>>> Currently, there is a look-up-table to describe all the clock options the HDMI PHY
>>> can use.  Some of these entries in the LUT are using a fractional divider which does
>>> not have a well documented algorithm for determinging values, but the the integer
>>> divider can use an algorithm to calculate the integer divder values dynamically
>>> beyond those listed in the LUT and also duplicates some of the entries.
>>>
>>> The first two patches do not do anything functionally other than simplify
>>> some of the register accesses and de-duplicates some of the register look-ups.
>>>
>>> The third patch adds support for the integer divider and uses it whenever the
>>> clock request is an exact match.  Otherwise, it will use the LUT as before.
>>> The rouding is still based on the LUT if the integer clock isn't an exact match.
>>>
>>> The forth patch updates thes set_rate and round_rate functions to use either
>>> the fractional clock LUT or the the integer divder mechanism to determine
>>> which ever clock rate might be closest match.
>>>
>>> The last patch removes the integer divider entries from the LUT since by then
>>> it'll be comparing both the integer divider calculator and the closest value
>>> in the LUT.
>>>
>>> In my testing with a AOC 4K monitor, I was able to add 4 entries in my modetest
>>> table.  I do not have an HDMI analyzer, so I just used my monitor to determine
>>> if this series worked.
>>
>> So I tested this series and it works fine. With Dominique's patch to
>> allow for 0.5% deviation for the clock, all the 24 modes of my monitor
>> and 30 out of 42 modes of my HDMI grabber are working now.
>>
>> I still have some issues with LCDIF underrun errors on modeswitch with
>> v6.11-rc6 but these are unrelated to this series.
> 
> I was comparing the LCDIF driver from the NXP downstream and the
> mainline, and I noticed the panic threshold values are different in
> the NXP downstream for the LCDIF3 which generates the video for the
> HDMI.
> 
> The downstream threshold states the default low value is 1/3 and the
> default high value is 2/3
> It appears the mainline matches these values [1].
> However, there is an option to override the defaults and change the
> values to 1/2 and 3/4.  I don't really understand what these values
> do, but it might be worth some investigation to see if playing with
> these values helps or not.  The notes in both versions state the panic
> isn't designed to trigger an interrupt, but to get the Noc and QoS
> modules to handle it.

I will try that. Although I doubt that it is related to the thresholds.
This should be relevant in cases where bus priorities play some role
(high load, conflicts with other peripherals, etc.).

In my case the target is basically idle and other peripherals are not
used. Also it happens only when switching modes or turning on/off.

> 
> Either way, it's unrelated to this patch, but my monitor doesn't
> always sync values from the LUT, but sometimes it does, but I can't
> tell if we have an underflow or not.

You can check by reading register 0x32fc6024 and see if the second bit
(UNDERRUN) is set.

> 
> adam
> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/mxsfb/lcdif_kms.c?h=next-20240905#n350
> 
>>
>> Thanks Adam and Dominique for the great work!
> 
> I enjoy puzzles.  Reading through the tables and looking for patterns
> was fun.  I did spend some time trying to understand the fractional
> divider stuff, but I didn't make much progress.

I tried myself and I made some further progress today. But I'm not quite
there, yet. The goal would be to be able to calculate some more table
entries. Let's see.

