Return-Path: <linux-kernel+bounces-296581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7887B95AC61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8F3B21791
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B3F38DD3;
	Thu, 22 Aug 2024 04:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Zum+R5SO"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010053.outbound.protection.outlook.com [52.101.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ABF22611;
	Thu, 22 Aug 2024 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724299680; cv=fail; b=LcoH1qOW7NddznbStjsOi+H8euDbCCK4mSASmkPAYmEOzzA+VuKkqK9OAUukUoIpBWPgRZL98rwO+05aKVeitpynh5lkPmQifL4G8Hjn5nOh7rHCYoD6uCkpR/4DsgUTpKtpIEDI5dziR5SLAkMH766kW/t66s/NGSfTbDfDbVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724299680; c=relaxed/simple;
	bh=gzMOAm5+DDxeg0DN6hfwnMxPCkBHeRAHdvUD17inKg4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JlfT0Q40TV+59S5BF+jJ6zq+10XgvULYQvuTPiBX3rjU9OIq9oDybSVOHBEOLWYlzMpjWsmszDrjfMen8FP9wjrnSTyZiK4Q8Y1ZMJy7/HhOaYthCAxYpJkP/HYU1jKV4L4fn/FKcahD7MFHbwTOWpW1fvsB7MKH34WMz/72xE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Zum+R5SO; arc=fail smtp.client-ip=52.101.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX1cPpcrWGI6fTtCsWugx9yNl/CWt1nIlvwByyYqgflJWK6WtR46ke/hR2XzG+/1uXKJqCyViKLEOWIX5Hnx007VJj2TC5eyGwJ6wfTw+BTdAlaud7oZ50uWqiUtgOUym0hWM6fhcMLJ/oHLm7ez/dbwlI7Uj4VyNMrK5+opmPWv6FD7yv7XIwTcZZIppAHhNP90NDfNdTdDRfbqL1EfzJgMBGavb3BIXqoVIBu0LD0s1FIO4l6np6if9QNGQGFcjz5hHqdHLZDgDgYZ5+icgFoWfib00yyKvKB8LdUQyR1yjVmsMuT5Q31jyc2yNlzCFUKqzXgk621Jx7CR1Plz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7hUWwSvqY9uKVz2dWMhzeK+sx8VxhYHDekKDvR3/Cg=;
 b=M96PKIS1S5p/FxdJqn4vRMrXddmp7Ela9vjxPoYqTxGzikqjhl3PcVMLy3N0HzXsRZVsdEK5BoVpib/TmeDVZSpoUrEbVQaakAsOAkvgHt7iLdzYPBpawjMtcNHGzxi0jgOlZ9ASRgeUqkY1o3U0d8Ah/ryWZc2ku+NZaP/QHqS9UzhcZmWgDnvWsxNKJdfG71gt+kX6M+cgFT21SJRVnUtz3qtyK/w4sHkS7VHF0KtLWoJ6hlSx7cUq27VZ9bLaHLx8ma5NsJmU7ryueKKnybdh7FLUidStulArCWuJ0lPMEKg0DXy4Gex2TOSIeagjt81S73uX4kLkMj7HW3tpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7hUWwSvqY9uKVz2dWMhzeK+sx8VxhYHDekKDvR3/Cg=;
 b=Zum+R5SOShh6PS3a19HYRD/4wE1rvYZ4nGxomBHC9ChN9D+a7rUUvy/McupliQLLpxbL3QDnd8SOrkhpD4uWGuQPBUVTocyuw8rGHkYYezGbGk479IO7CzkY1WMyjx1kh/PRt/7q6FF8BVJhPgFzrjzkPnCCIlQSTjBQ79GGM2t/HpsP9BdEqpqaVkdjjpJvY20DdcOCt4lnL2sR9MeZ+ryFpo9t7B4/40T3Jcbvf7mv5KzbVXtfKbkSGnXb0pl/L3GsoCc6HHo97Pad6Dps2VCsVzdRqgnbuD842xMLN+/U6TSDHc0XdukkruXcTBoVBYcL5NjT9oKur74a7e0n2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com (2603:1096:301:ee::9)
 by TYUPR06MB5910.apcprd06.prod.outlook.com (2603:1096:400:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 04:07:49 +0000
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83]) by PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 04:07:49 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Neal Liu <neal_liu@aspeedtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bin Liu <b-liu@ti.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v1 0/5] usb drivers use devm_clk_get_enabled() helpers
Date: Thu, 22 Aug 2024 12:07:25 +0800
Message-Id: <20240822040734.29412-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:15::24) To PUZPR06MB5620.apcprd06.prod.outlook.com
 (2603:1096:301:ee::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5620:EE_|TYUPR06MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: d110b07a-7ec7-40e4-99e4-08dcc25ffc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?czIT/TWqORo3O6xZdbB7lGsm4XI9VXuhbP8XRUMb+GKv+l8GIDi5MvS5xmXs?=
 =?us-ascii?Q?ksmgcHRdkXx0ugWu4YeFex3461D0Sm+yj5oS1xtVCq+zqWm3IlEQOkP3OK/u?=
 =?us-ascii?Q?/DP7T4GSCJ02rU8+UkD0S822N50gLa1CVc8UEd38Hn+OucnaKHNSs5gREDwl?=
 =?us-ascii?Q?/ETgDvZ1W0pZPBEOwmoFTW1VYffiQrVx6ra+UPl7nA0j9kC/cjCCK5T/JVCW?=
 =?us-ascii?Q?i8PV1hL4d1gS2cRqL4NaqW06LKuhQSN8/GZmfkNiuLcix5d7mPxmUNZceNGS?=
 =?us-ascii?Q?gGMDAPk3q/KOqSLPa/HEYFWtbk7q5FeF8YlNCkyCZ1ixvGUM7HREBScJ5fFT?=
 =?us-ascii?Q?kMVmNIOAUJAKK+ifm35TxOj4l+CVvgtt9rJycBXF5RnDEhqdSf9WkZZU6JTP?=
 =?us-ascii?Q?sL1HvQDPMwYelEa8l838CkvoeW6fRGBuQbUShHTvEq5+l62msgF18c6w8wmn?=
 =?us-ascii?Q?r3Ovbw+ctEtLs0WSZr6qTEPE8gbJIkS8Kfo4mnvK7uz/3l32TFZNtefCTJX4?=
 =?us-ascii?Q?bCxh/TncJ49UwuHL45Kwmz9/TpwaQZtT0o7RXvNdZ1urdfwD9C1EFdRbvZFV?=
 =?us-ascii?Q?iIPcffS/APLMm/ywfUmZgyT4sFa9hoaGiWVlAUHsCqQXhz+RhYFEVxcJRGq+?=
 =?us-ascii?Q?0l1/hSg+OUBtSVxFBDvUBe1HjTiCrHfq+Y872fYllAQLDkkmIgISVMMgaJq/?=
 =?us-ascii?Q?srODmJ33zQABKNQERjqi4xWuP19vdhhoc4HxBlQLWiFkDL2pYaADvWW553dW?=
 =?us-ascii?Q?2AH8McaIOOnBUQ0ko2W26kmxTe2i+ILF8vOB8ZgPfpgBzPfzlJsx9k7t//l3?=
 =?us-ascii?Q?sY3WURXTtYBDMlar6ruPqcCFHtRUssZVYQPydJ5brgRv1fUjIe36zJ66ckyY?=
 =?us-ascii?Q?5jRxa0gaTjD9BwZsGzORlm2BOOzmyEJY9IFwyDKO7ofM/e8VAow1HX/XNGDl?=
 =?us-ascii?Q?xJ27BEWpoAMM1qY2NxnjNwADvdmykP0QkbitlCx1piDdwC+lAnPlc3Bs8rlb?=
 =?us-ascii?Q?4gYHd+shNLfphXUrhsDAGSENXRWoQYDPdba6EPufEeZzADPw3oVxeQwYT6mp?=
 =?us-ascii?Q?Wqct5CcvsTQcrWtZUyd2VNkzQOEgP4TvERzWyE5GDPT3VeMcFdKN8Ann/hUV?=
 =?us-ascii?Q?aRXFGBIhiU5PMl3um+CcpVBXjLPKJgIsxWm+3+aVIZzCP5spTgG2JDUTWP98?=
 =?us-ascii?Q?4oAkuESLt7kvGKONprsbiPVCVE86zo0h/kUhIJgui1ShijJSp797liH6XbXu?=
 =?us-ascii?Q?87OvJSrs0ESvCrKcPSzz1bu/w6iEhOUIbwlMX/PU4kS+reve1+GSRTDYkvAb?=
 =?us-ascii?Q?zLN09PFwz3lObyaHkd0d6FJWRpj1brRf4UrKKAmNPgwYygW9cp7lhw92l7Br?=
 =?us-ascii?Q?aUB5Olx74NMpTd3QlesZPf5JmXiL+nxLNxpknDL3drMSnm5YzQKOErRmp3Lw?=
 =?us-ascii?Q?pPGd2n+3Om6LS6jLbcC3FT2u5gHZSAAq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5620.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tAKFp7uAENmkk+qpfhZ0k07vMrNmkBDU9TNe/xSAEJMOafi6eSan01AIC2YO?=
 =?us-ascii?Q?bMZ1cdJug2zTscDkcXYlpWR1aUqJio7qerunKvi/4fI00rJgeRVCi5Oo9k8/?=
 =?us-ascii?Q?ZRAUzrigaUbA+D4fyVSp/xNOswNBhkGhDQsEwgY3jFCrhMs6FEdPs7rox9oF?=
 =?us-ascii?Q?uyPasYCRpYMpjBbZ9sNhjdRZXsv1byLev7gsqeqJkHZ3zVBjkgh4IZvfXRKJ?=
 =?us-ascii?Q?lGTqfXfpjWCJUUusd0mPTFu+dCkSgAKJgP06D2XzF15t2fr8oiJdQEJDkKpK?=
 =?us-ascii?Q?u1GZ5NCNYs80fQp3dCAthU05ZDCaetpyH+wdeFP7V/kj6gYTN5uXneI374l9?=
 =?us-ascii?Q?KQ3kNMTf2yMeuuIg2/OUYY2ykE2RfOoRNJjXZUUzc4BWsUTVdFnX+iqeclKX?=
 =?us-ascii?Q?WlkAr4A8bbqsac206xLjF8HKtvyND5hGr8PX6HNWOGqzVpYGs+5ZY46phd97?=
 =?us-ascii?Q?/F5f5/5grcs2PZsvg/l4c6gPIkVWw1OCxVL8kwVUFoAG9zBtrzENviAQzONp?=
 =?us-ascii?Q?Dvdq5uHOhwWTqeQaXzR+fZRi0lMsFNZmeLEQpBu6ywU6JR26t66xd0v4zPNg?=
 =?us-ascii?Q?JdjfU5J3c9T1A41hEm2vv0RqHh/ThwARjOMQjmVJukZPYThbRGmb3Se5dRBq?=
 =?us-ascii?Q?uxEFqcZge4SD/RCZWQX46hZocy72Qs1e1P2ZMUe6iLnSlj1onHZoBvFtkV/E?=
 =?us-ascii?Q?NitRmm3UTRU6e7aJF+cYgW8X9bIGhgzGjmjiEcOY0PaPUH+Ot7fAEd+kbGAu?=
 =?us-ascii?Q?yJawB4Dv1aaajGvf/xuNB4KajxsIts3ePgrxzPQyB4jXlCEjDr9k4AyXonAh?=
 =?us-ascii?Q?i8bKt6mYlhaxNSIMXFICe5JR3a3+BVczkkSWS+pfK9dhrZ568VsZNo9aRcZ/?=
 =?us-ascii?Q?uvJNatP2tfEybxhd/R+znhVT4O+Rs+vNEe1fJvo6Bke0PFp6PLdAeOAovcqs?=
 =?us-ascii?Q?+5+YwVWZctST/oM/+oK0yKa9QRuTH5xqYw2mGoykr8K7zZhykoUTkTh6J22X?=
 =?us-ascii?Q?FJ1P0GR/zocQ1tJyoxcGg0VUk1qsmXsG09b73YQcazAgR/uBAbF3sfk/gWZe?=
 =?us-ascii?Q?H5ldTlHMshbYNuCvt/6TvZMZLmVndgHiMZHq0m4+FG4g6j7rnid2jd+jpQ4Z?=
 =?us-ascii?Q?tIflu1/VSjyg/tCWAmF1A+zHq1ejuR1sAoPOgMo/HdaxdbxWA+2Oo5anXdHZ?=
 =?us-ascii?Q?OiJ7u8WXcxRt3yXLeM7pfpSZuhuoRfnxdqp8WURvHwuQvgy5zKNGVJlRbGah?=
 =?us-ascii?Q?Vte4xDA84cb4STGZZjfq2++b2OTbIooHX7j1hDtNnaOGHuTw85hs//BJpp2Q?=
 =?us-ascii?Q?Yf8fblUPXDbixgVpGPX2ajtswXDaiUi7CNmKmpAI+Ygd6wJQB8NjUPM+j17x?=
 =?us-ascii?Q?y2cl9tfCjpmP0M4TOXj1rGvDhHfAQUCP3tFyvte0Z6uzBadiaWbgNcKazyG+?=
 =?us-ascii?Q?O1TOEekb9LYXnhPYfwDvt7uRRmVOINCW9ydzyEAVoaeGGfKl7vzUNDoHRwV7?=
 =?us-ascii?Q?jjqE+qZFwAxoRL5TNB4yiOgmanbe5DcCnpbxjo068Fy3B5pJdEsdRWKsPx02?=
 =?us-ascii?Q?vw8vVDjxdjx7r+w8QogDe1DV8ABFmnv2Nhsj9xex?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d110b07a-7ec7-40e4-99e4-08dcc25ffc63
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5620.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 04:07:49.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n75vT6D0Pz9NRBY8PVXHLt4gjz1osKwoi7MK9wBZTC+Wxf5uHEp2/UtQArAjChOSxYV65JPaoLtSv9VvDF+FOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5910

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
The files ux500.c, mpfs.c, and pxa27x_udc.c have incorrect usage of 
certain interfaces due to the lack of synchronization during the 
commit updates. These issues have been corrected in the v1 version.

version 1 changes
1.ux500: Incorrect usage of clk_prepare_enable() should be corrected to
  devm_clk_get_enabled().
2.mpfs: Incorrect usage of devm_clk_get_enable() should be corrected to
  devm_clk_get_enabled().
3.pxa27x_udc: Incorrect usage of clk_prepare_enable() should be
  corrected to devm_clk_get_enabled().

Lei Liu (5):
  usb: aspeed_udc: Use devm_clk_get_enabled() helpers
  usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
  usb: r8a66597-udc: Use devm_clk_get_enabled() helpers
  usb: mpfs: Use devm_clk_get_enabled() helpers
  usb: ux500: Use devm_clk_get_enabled() helpers

 drivers/usb/gadget/udc/aspeed_udc.c   |  9 +--------
 drivers/usb/gadget/udc/pxa27x_udc.c   |  6 +-----
 drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
 drivers/usb/musb/mpfs.c               | 22 ++++++----------------
 drivers/usb/musb/ux500.c              | 18 ++++--------------
 5 files changed, 16 insertions(+), 55 deletions(-)

-- 
2.34.1


