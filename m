Return-Path: <linux-kernel+bounces-250863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6FC92FDC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3ACDB21B91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6231741C8;
	Fri, 12 Jul 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="neKsav5K"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D0175564;
	Fri, 12 Jul 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798862; cv=fail; b=ug35LZenioaKjs5EMYSfn5zTcFmZghgn0w21yQAG/pCWgkgGV3lLcO16IMr0xwOpFAChGNzMjoJFCCQNpu131CDbYZRDFwpxg6gg8L0t2164AOwsFyiT/q9CCH/KADaF1ssqhNHHWMq9KWG5Fkkr661BT+4uFyn447p0WnYb8eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798862; c=relaxed/simple;
	bh=LZF8fiRnNfUEj0/JG74LN2cwxbM6N8hCxC0T75KalPE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GmHE2jzCyDYl0TiJAIUPgxstA32yBm0osAjeZ245RIJTn7tN20iRQ4WPv7I+VLY9Jvklt/+p8nJbBjRH5Awq5YH1jZDc4ppv8Tm2nYcdSfEWTNyEIRbnj+dZXEh1teYvtEOgpyRcePznOVIyMXRiR9FgClMcuqD4+HW5KqwKgpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=neKsav5K; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQtv4FBxdHlSmlxMzxuTav0ydzRDlYgUabr1ALzgBVVjeRYYJXzMk9H+6Ou+PTJFz04148iPVbZrNrGG3YTenzYupwedzBg/v8kj03SYvCy6rp3VAR80ihaqtaEeLREgbxX/s/qkaJ+8dWKf0T/77Yua+qkA/+EQDb9KzHaqO5gPE7u8QILINROBKQtu1fDNP/mI4FdQejbfhAgsmkdWfHCYotqqLzZx+TqTeWYouKbd2lJxOeYnx5oH7yLP2YPHfivxVSxlYPHtW+dt4RkYjJdKcJ+P9TSE8bKFVkEAWW3d9DnvZ1MxMYeWXBLPS3pMhjgAt4B44fUZtE7LrgzpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB2TN56YA6B2HFvGdRxxQfGotLFBN47dmzc4O7jlKXM=;
 b=cT8bC8Q/V7qpERFHYJ1Pwco3AD/3Ugr6J2rByXmGm0wTauQOK4qZlYac5Msk9DQdoso6oL+GzopqC4II5jE2maWs5szO9R6JuYwyAaU1HyaqrzSI+9G4fR0l4pCp262CKl4W2VzXngJXI3uIy0keacQk/Z/OwfR9UuZMOAGCNyNU5Yb/Qql3FAl9ceJEPDnINpD+33oywrk6YK0V0iXnUImNRGjyjbGsG8MuyGtThD9dZGA5SbW5rAAGXvv0z/ZHmVJ9oc5xQhXlplE1uVpBUk+jp9vDgTRnUd+pJmBxyQ0HD/HTl0nFpGghH/6gAYO6ymRHmKgNI/Z3SB+umOxtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB2TN56YA6B2HFvGdRxxQfGotLFBN47dmzc4O7jlKXM=;
 b=neKsav5K4E109bgYqwhF+C4LhnrObcWzykcEbGCcPdkei6oSkDlLmuYKARnrQcoNvtovK8+CaoKucowyTCQvmJXxzH9taNdREObcn0F7jAHw/nI/GwAlFHkGV/yd7KaX4vSd2V1jiussJgwajm3nnKE2Kk14wzGCkgWRnR4t/9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9803.eurprd04.prod.outlook.com (2603:10a6:150:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 15:40:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 15:40:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Jul 2024 11:40:29 -0400
Subject: [PATCH 3/4] usb: dwc3: core: add a core init flag for device mode
 resume
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-dwc-mp-v1-3-295e5c4e3ec9@nxp.com>
References: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
In-Reply-To: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, Peter Chen <peter.chen@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720798845; l=1856;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HDrRGCYGDwol4RWWe1IyBNwBksEIqTK/O4gYUc10XcQ=;
 b=dTuD710yiij6BtutucldXRLgymp/G1IPzLfJEl9747mFaSdIBXCD5juypswY0CkHmDpGjI+cd
 BFjuQ43vp0eCqCvsHXr0PlTBDAiO76Vf5S8XA4VEhXNwRxjIi91kddW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 914973b3-a8d5-4246-723d-08dca28906e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHJwS0NKa2FyTzJJTUwxclpva2FycGxUMkFwS1E2REFsVURLYzNqS2ttNDV2?=
 =?utf-8?B?TEhsNzBVSEVubHJBaVRMZDlZeVN5RnNTUkFTaTcvK3ZZcXgxVVN5dCtFaXdT?=
 =?utf-8?B?a3JWT1c2U3lhby9Xc1ZRYmFDQ2s4Q29HZ0pRcDNpRkpLUWxTeEFJUEp2b0J2?=
 =?utf-8?B?U3Fxdi9wcGN3WXFIT1lNN3U1OEhMZFFyMW5MN3RiR0phSnNCellRaWZNb0Vp?=
 =?utf-8?B?WUdsZjdTaTBSeDZiYTM5cE9tM1FscVB1OTEvenhDcXYxK0xIMGtubVQ5NktK?=
 =?utf-8?B?eHp3ZUZRajExK2E1eUNkcDhxRkF1NHlBTUlrUXBBTklhbjhwOTlINnNQWHEx?=
 =?utf-8?B?d2dLcVl4R3ZFRjV6RC8reGpjOG01MlRFWnBkeXJzVmVTYXZjZzR4U0UxOU9l?=
 =?utf-8?B?OGE4NklPT3RPbmE3Z2RlaWhxcSs3cUsrOVdQV3FoeGlNYWw2YUVEd2NRMHdY?=
 =?utf-8?B?RGRDUVozUEgvTVd5NHlPbmw1MU0yZHVROXN6bmdTMm42WGc5S1lTSGVZZDBj?=
 =?utf-8?B?cHhKZTF0MTRkZ0lVb0VXc1FVVkdtZzlOenV4ZFhOaTQvLytXYjhqMDA2TWV3?=
 =?utf-8?B?VnBEOE5Rc2VQNDM5akU1OXk5ZElMTVpFREw1cEVOUjZ1YW5xdkhTZ2x1U1dj?=
 =?utf-8?B?cHN6UUw0STZmQXZjd3hWQXBJNkpWd0VxYVlhaXNabFNzWkw0SHliWkk4dnJl?=
 =?utf-8?B?QlRoMk9xbm1EaXBSODlBUHdOekhiei9NVVIrZW1mRlNhbzZRMDdsUmxYNm9B?=
 =?utf-8?B?NVVOYmZXZ3VrSU94ZWlMT0ZEcXA5NVlSbTFhWGlVV1huZm4yQ29zUFltR1VS?=
 =?utf-8?B?U2VOYWxFQWRBVXVjUENjSVdwMlgwZEhXNjNpRWoyS3d1Q2grLzZzT1I0VFlQ?=
 =?utf-8?B?U1JnZmJtUTErSHpBUFJUTC85VUpIc2tGUXFQSjR2RGFVUG4wd2xiSjBvVDc3?=
 =?utf-8?B?VTRlY3NpRHhlL2x1Tm9BRjNERTZhbGFJZ1dCR21QR2RQMjhOVDlXbWRqS1JF?=
 =?utf-8?B?SWJLb0VCZ3poME5oTUpCYXVIQm13YUJMQVNJRGJhdUdlTWlQdDZRdW52Znhu?=
 =?utf-8?B?bFJXVWE0YkkrelhPUEtEdDRwWnNDWUdtYjV5SUc4NHRIUHE4clg2K094V2Qx?=
 =?utf-8?B?eWt4OXhvMERHT1hDYlF1QnZtNkpqRGZuREIxUVNGV2VsUnJScGlsd0FyYThx?=
 =?utf-8?B?WHh3LytCV2tCTk1Oek5yVjVuNERYNStndCtHb0ZIRXR3NGFGWENDZy9KTTFs?=
 =?utf-8?B?TE0vbnR4cXROL2RtbHZRVG5jcUVyR1BDcHNLb2JLSHNSbmM4UllMSWFZdTBH?=
 =?utf-8?B?MkNIU3JqWk9SR3M3MDFyczBHRFJ0MHZTV1Ywd0ltcHJGSFNadnVIY2JxVE54?=
 =?utf-8?B?Z0NaRk1KQytzOTdvNHNKZ3pxeDFwV2U0ZmhCdWowYy9tdFZzUGZxZy8vZE5q?=
 =?utf-8?B?dGdKUStCb3pVSHRsNXFGTkRGOXEzQm1FNFpoblpORFhOVHAvdVZ5ZlN6K1Ja?=
 =?utf-8?B?RGdDZURPZnRRR3RPb3hVdlkyS3I3UzJOUzZHUkNrZUUrWThKUVV4M2RVdHd5?=
 =?utf-8?B?anczaC9OQTdHVVVzRFVWRlZmaW9IRmdaWFpYajROaXNqRFE5a21wM216c3BX?=
 =?utf-8?B?aXlyS2tWZ2NuRXpGT1lOZ3BYMkdmd3NqcCs5VnArbkdIRjdVVVpheWZCc2Rv?=
 =?utf-8?B?TWFqWllRRDVqNk14YVNwcWtUOUZtcXRkeHJLQkUyWVNhUTdrWjVCNWNkWjZ5?=
 =?utf-8?B?QjRURytxTVF1d0RnUFNwN2NBVWhuczRaZHJCOTNZUkw4Z2ZyQWNycHk5WmRs?=
 =?utf-8?B?MXYwa3ZNVklyL2V4Nlk4c0lBUTVsdUpaVE9LWFFVTEN5Mm5vUUNSd3BhNzNM?=
 =?utf-8?B?c2hNV3hqQzMraXFESWV3ZjVnRXB1Y0xUUEl5VTkyTzVMa0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjRrMjBQdGgzZ1ZtZkx1dWJSZDlzcVlXbGpOTDh5NkVPNmFEY01hQk9vUGlq?=
 =?utf-8?B?czM1SVZDRGZLYys1TTA2TFd1S0VOelljNTM5SmtNVVV1ZFByZHVRYzlTTmZ5?=
 =?utf-8?B?OXZHT0JuMk1PZldEclFnYkxXbjNHcWhMQ3ovcVVaWHBrbUw3VXhWRzlWZVI4?=
 =?utf-8?B?TC96RUNhZ1A5by9vRUVLQlpJdXNqT3VLUXM5dDlHR0hCTlVTUFlJQzFGL09C?=
 =?utf-8?B?Nlg2YzBkY0pnNFMyK1I2bVlPVlJFTlQ3bTVIQ1RUc2ZkSUVySTFBV0d2ZTdI?=
 =?utf-8?B?aG9oeGdHMm5tSEl5THRwbVc5eFllYXNRT1h2c2dDS0xwTThJTzJMSU1jdSt1?=
 =?utf-8?B?UFA5SzVjUlhRWjZZa3c4SnRaUlluMTZ5S3Y5Z3Y2clFZcStkOVByZnBIRGVT?=
 =?utf-8?B?WEJBdDE1WXlRZWRGMDBTQVJueElFbjJudkthSUZWUkxqOHRFL0t0NFIrcWxz?=
 =?utf-8?B?akNPUld2aWQ4U2IzRXM1bVJpWHdGbkFCMkVnNEVwaTQ5ajRhTGhkcE1qWHlO?=
 =?utf-8?B?UDVEalBqdUo4K2hHS3Q0VmZHY3d2L0xoRnJ1YXo5YzFRSFExUVNqdlBsSDFU?=
 =?utf-8?B?eUd2TFpJOVMweDhjSU0wbFZ1cy9LbUt5QjBSV0pOUDlBb2RYY0lxanpvS1hG?=
 =?utf-8?B?bkVkZTdtbW1hVXVCVUFyMjlvcituRmplM1IyaDNpc1NMUXFFcmdkM0ZSMlJi?=
 =?utf-8?B?Y2p2RnZ1SnZ2dHJlZ2h2MmRqWk9OM0xpTGxDc3Vkbk92Rk9vbmhXRmhGOXZT?=
 =?utf-8?B?MnRhb0hvNXVFdjcvRnVvcTBwVXFtdm1aRlJkdzNWMG1FNUdjaTFkUWxFSm1B?=
 =?utf-8?B?ZVRWNk5KM2Irc21BQzZVNHhXS3N5cERFZGpRNUQrU0s5SmQ2REYycTVBSGpR?=
 =?utf-8?B?RFYxV0xydjVWYm81TG94R05SWnA1RXpvNkJRN2NkQmUyRHVMMEpuLy9RM2Vo?=
 =?utf-8?B?M1dpeVFJWjdPRjZVRmpDMWZPSUFIR29ndmY5dkRrOGhIVVNOSXF2cmQ4Y3RL?=
 =?utf-8?B?YXNVeU5ibGw2RGVQZlNvQm5TMHBQbk8zSU5TbTFRdDljcUJDekFSeThwTExr?=
 =?utf-8?B?V3VTRUJwb3V5bjY0WVVodG03MXQ2T3N0M1R4dlZLVHhad0NSQlpydUJ4ZTlU?=
 =?utf-8?B?MFZZc2pjYVl4WjBYWERxbjVxc1JwckpKT0NMT3dwL3NIN1FGaERkUExXUE5N?=
 =?utf-8?B?bmZBT3Mvd0g4ejVGR1Iza2xjSzJURXIzQ0prYldRWDJ0SUc2NHQwbFN1UFUv?=
 =?utf-8?B?T1NHOVNVSUFhWkJDUU9wREtWVzgrNG9PajdGNHY0SVlEa0VMaVZmTTlENVJ0?=
 =?utf-8?B?Rk9pNGJ0MlBWVlI2SjBYeXZGWndVOVpWblFJdWl0Yi9VZi9FQ0ZNZ0VJK3Nw?=
 =?utf-8?B?QVFOWFFYRHZFSEE5cWkvY1RBeXBoQzl0V0t2aDhtcWlXeUNpbEcvb09qaWls?=
 =?utf-8?B?c3lTYjkvb09ITDk2N2NDR1VZay9mR0NhVmwyMEZrUEx3cXJJVm9sUGNNbTRZ?=
 =?utf-8?B?ZXNGcURTZXNTL2gyMWhTT2VuM1c4aDBCQk05eE5Ib29TVDRLam85Um0vbmdG?=
 =?utf-8?B?MXZkamZCYkVqdE9HNlBQb2dGcGJhYkN0N2dEejZMRVJvTGhGRFpUbDkyQVlC?=
 =?utf-8?B?ZVRhRW1WOEFncmUyOTRKN1N1T2ZrL3ZyVWVYVkppMmpmQVI4L3lqUFhyU1Rk?=
 =?utf-8?B?NTYzQ0czQm82Mk5odDg5MUx1SlZWRkIzb2hYcjduNk5mRkpUZFlhOXBPQVlt?=
 =?utf-8?B?cUZTV0RVRnM2RTh0ZE40dVlvdEFxaXNjSjF0SzdoejdpYUJFSndpNHJJMFY5?=
 =?utf-8?B?SENaNGdlbXhzUUQ5UE42b004VWJEbkpoaVB2aHFnYSt0dXh6Q25oUzJtQUFz?=
 =?utf-8?B?Ujk4aUFPNThwdFJ5RFQ3ZThDQ1VmNFIxdDhKWmNBaGxrbjU3T0l1Ym5zYUV4?=
 =?utf-8?B?a3J4VWtYeDNkNDd0YzJGRUQ1YWFkRjM5cGlQbTdYVjFyQWtocUUveWZXY0Fi?=
 =?utf-8?B?bDduaUpDOWJkTGhjbXZnQWF6VjNSUGlOdjhQa3Npa1FKa2xkZy9XMmdDWkFv?=
 =?utf-8?B?bEhxbUFxOGtYdThZU3NDZDVBS2FPS29XS3FRQkI0eUQwOGYwVG1UQlFyVXdP?=
 =?utf-8?Q?Jmrg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914973b3-a8d5-4246-723d-08dca28906e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:40:59.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zYy44mx0Qf9/n/64Wmp3hCLlxSV8x7nOxlNs98Z9cmnNZbeG3rjat+5fZ0rFOMzDwS1FkwfdwsCzWXb/CutAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9803

From: Li Jun <jun.li@nxp.com>

The runtime resume will happen before system resume if system wakeup by
device mode wakeup event(e.g, VBUS). Add a flag to avoid init twice.

Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/core.c | 13 +++++++++++++
 drivers/usb/dwc3/core.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 734de2a8bd212..d60917fad8c52 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -950,6 +950,8 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	dwc3_phy_exit(dwc);
 	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
+
+	dwc->core_inited = false;
 }
 
 static bool dwc3_core_is_valid(struct dwc3 *dwc)
@@ -1446,6 +1448,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
 	}
 
+	dwc->core_inited = true;
+
 	return 0;
 
 err_power_off_phy:
@@ -2375,6 +2379,15 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
+		/*
+		 * system resume may come after runtime resume
+		 * e.g. rpm suspend -> pm suspend -> wakeup
+		 * -> rpm resume -> system resume, so if already
+		 *  runtime resumed, system resume should skip it.
+		 */
+		if (dwc->core_inited)
+			break;
+
 		ret = dwc3_core_init_for_resume(dwc);
 		if (ret)
 			return ret;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1e561fd8b86e2..8a4bfd9a25b19 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1195,6 +1195,7 @@ struct dwc3 {
 	struct clk		*utmi_clk;
 	struct clk		*pipe_clk;
 
+	bool			core_inited;
 	struct reset_control	*reset;
 
 	struct usb_phy		*usb2_phy;

-- 
2.34.1


