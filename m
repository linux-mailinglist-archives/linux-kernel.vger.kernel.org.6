Return-Path: <linux-kernel+bounces-273822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F07F946E95
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D321C20CCA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2DF383A9;
	Sun,  4 Aug 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Gooxsx7l"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D9368;
	Sun,  4 Aug 2024 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774246; cv=fail; b=iszQVX4+nV8MsWNyZQ5SUR+yQTHAFIFWeoWU/VC2WFh1pV4dCxUlJk5OIVA2JiVxaJy61osJEA3NTwRzKWb8A9t32/Ey8xWf+1VQq8tfrDTH8rKz8GpL/on+0K/sZqAZzoMtrRidKnVcOTVG8Qa7nShcS6hNzGSSnTUo0Gj4Ei0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774246; c=relaxed/simple;
	bh=TKZ6PmWzrCSmYgzm8OnziGstOUFlEBmle6FCWeB/5qk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=axFjkTtqXM9NomaMpDHYBRzW63BGw33CRDWH4tCpNGYCTVzqWPQgOE/atAyYlt1CZvr4wmjLbdz7Ank6Y1eeX072BlW62Xg25E37OilPFGODR88tkQKEE+rrJWmoW3qs1ICXollNID5NdVjSHZ9Wworp26muIh2nOvSDP3rNMUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Gooxsx7l; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdyXGdwHMwD0/Shcug4dtWHwcrsIp//gEZXfiaiq5SLL+7u39QfhqkOs5Wb8EB8WIUu7MEKfzbeKLExANo7lKeUnZgBOP+0pPXN90qFnGVmeFW01Su04jzkwhR+sipposTaRp1Aa8SLhG3i+AsKP/slTqX3H8vJwtZ5xkf56HrzC29RwnOzbspNUoZkxngn5dg7KShAVFh3P2p8R0w+geCvMeEIHAYpd6vx3W0QeD0GJuOth+OuBUaxNVfz7XmEjBdwnoKNAlmRjRhfC6zQmxMObhbbbh2Av0I4iCSaTpuS8YZppxvPqqxjhRNwZCmiqKPb8T6s07Hbwk9kaIQR4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+mbIETU7uBwp53hcdxG8ERcv571mMNj3cbv19oHDtA=;
 b=l3OSW3Fy0oY3wd9Ej8OWw70vkn/EjOxcWs+KW0xrLXnHmmuU2h3ALooEU60f7Wm7iRR/groPTy1BBumkH6zafM/LO7Wm9qJUdDnbqM2oS3CSzaAgAEN0sz0o+roaHaGw/CmUczqEPgD6WvNZ57psH2Cqnh+iYrM+u7dSbY7q9MX1hLxsPXwIndSK8uaZyJ2r0zvl0jxJ2YQ9Ga7r+FV5JmgemTucA5DEzK7kgimB/Q8UumCJoExJoj+Irxg4gTWZr+OTU3/Y0TEUV98JwvVZNqHAqXzFeuS9LLrNIh34ssN+V1aRilIuFxy/cXAKAkKixB+y1UcXwnmxka566DDGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+mbIETU7uBwp53hcdxG8ERcv571mMNj3cbv19oHDtA=;
 b=Gooxsx7le69Z5jyLItXQFHypg+1dUxcVsNAusfXrRvIicH4Kn9OP3R7tijTvnkHn7f1wmpveqJfkS37QGDpxuIAw8CGKhkrTRiXNyv3Vc6z7Er4ESn8cpZcOdPtOFbHMl9JtNEHilyFWW74Wa83TKfF/o1SKxaIGA1EBgoZ6QI/35H/82PCD6CIAoAJbSyu4GVzwDLzQJTaYQ7NURTi98/Wx9rZ2HjnRhMGlJr7i6/qI8DVg8A53olsRuVz4zaVG+wdRa/OuR3bgBq/dz3cJY6ytt1SOqZPzUA+60hWCA/7qbdceoRD0c4w/XWq8uDd6gC3t4dBaAcBGuZ+YrHi6yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7413.eurprd04.prod.outlook.com (2603:10a6:10:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 12:23:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Sun, 4 Aug 2024
 12:23:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/2] clk: add assigned-clock-rates-u64
Date: Sun, 04 Aug 2024 20:32:54 +0800
Message-Id: <20240804-clk-u64-v4-0-8e55569f39a4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPd0r2YC/2XMQQ7CIBCF4asY1mJgILR15T2MCwqDJWrbgJKap
 neXdoPG5YP5/plEDB4jOe5mEjD56Ic+D7nfEdPp/orU27wJMJBMAafmfqMvJWnFjBRCOOZqRvL
 1GND5aSudL3l3Pj6H8N7Cia+v/43EKaMWaq04byH/nPppPJjhQdZCgqIqaIqCrJzTChClqFD9K
 vGlBCtKZCUttLxBq7XCopZl+QD8R/JpCAEAAA==
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722774785; l=1803;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=TKZ6PmWzrCSmYgzm8OnziGstOUFlEBmle6FCWeB/5qk=;
 b=f74oslerqx/ciR4o+AMRVnDxNRupOTkFnFg7lHd01X8wxhMe7k9Da4PQUoIE8jM61EX/Pnn8V
 xOdY99GtUasDVIaa5uCoyQ/XXckOi2Oad0hW5SnywVojZL1YudHZAky
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: abbffe5f-67cc-4207-ed0a-08dcb480516a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjVHN0h5eWNvMmpBTDl2eUpRdmgxM1Rxc0pCZ0FEM3hIUlhvc1lueStoUXdk?=
 =?utf-8?B?Q2kwWlNlT3dpNzlselNackJYMklieGhGTVBiL2VvMjVxUUFtbTA4cXVUZ29q?=
 =?utf-8?B?dmhveXA5eDJLajRiL2QwQWpEUTVka1VyS3g5aUszWUNrR0IyTzBQUEVoSmdj?=
 =?utf-8?B?eDR5d2pUNWt6UjhVbTl1QitnU3pWcjIvSlVUMW5zZkYramR6aFFFZlkxbmFo?=
 =?utf-8?B?ekhPWkNHdCtTdzhvd2trWm00MnJQYUxNT05pM3preUlKaWRkcTRmZjkvb3p3?=
 =?utf-8?B?eDF6SFM0Z1dvdFdoazFhL0JRUlNTQk4yOXlXRm9JTEVoREpOd1NWbi9jQjlP?=
 =?utf-8?B?MjdiRHkrdFJMYVdwSmJUcHEyWHNYbDJlSytndlgzeXdBSGlNald6ZjhoVVI5?=
 =?utf-8?B?NkxPdFdqTzRGbW84R3k5U0NaN0JpOWVoTE5SdEUyR0V6ZU1Nc21QaE1yKzZO?=
 =?utf-8?B?d2doMnFPL3FZeXExK2tRTXhXTzdnSURRZ1pMaCtFRGI3azljd20yUVJFOTEy?=
 =?utf-8?B?eS91QVpUVHFwdTZvc3Y2RUVUenRoMmVNaVJ4dmhJYml5N1JMeVl5ZE5GZ0gv?=
 =?utf-8?B?eFlobkhwTXp5MHUwcXBKMFVRWTR0VElORVdkTml3SjhLVzBjQlJFUU5ENGg0?=
 =?utf-8?B?VXpTQTduTXhFQnU3Uk5mZHNwSU91bWg1bnlXcW9GcHhLU2d5MlRDd09YdnBG?=
 =?utf-8?B?bElTMGpRbWpXdFlCZWFxTXUzNTVBUW4rZnpHNHAxUE8zbG1heW5QQW1PMEhp?=
 =?utf-8?B?anJMSko2a3gxdlRjQUwyUXlrMmRsNjBDZGJ2a3JkNG1NOVZWRmQwWHBLU3Q5?=
 =?utf-8?B?UkJ0bU4zYlBvZWFRY1ZwL3hadFJXS0E3M3pvamg1SzB3NlUwL2dRayt5Q3Fr?=
 =?utf-8?B?VUlsallHNHY4dmQ2am9walR2Z291TWVBR1BEV0lHaTBNdEZLSTFoK2daZkVO?=
 =?utf-8?B?NFRTY1IwRVJhUDZLcy9LTVZrYTZPTGF4YUJkVG9IYU0yV3BWaUN6ckQzeGh0?=
 =?utf-8?B?Q1N1RGw4aFVNWXVFelBWRUx6OXVpRkpPY0JBZzBhVW1xcUdENGdxVW1nWVhT?=
 =?utf-8?B?TlZCMjZTT3pKUkRueVVFU3h0SGpJOWhSN0w1NU1WRnZrMHRKMUkwYXlTNzRC?=
 =?utf-8?B?andnOXNqb21rbjVGTVB6eDZzNk9BS1FiWUJlbk52OHd5c1p6QzVmUitSemlV?=
 =?utf-8?B?SFc4aGIxbEhkZnZrSFRYQ1VuN2pzaXp0cG5vdFdjTU03UzdiY0Q0V25ra0xx?=
 =?utf-8?B?RHpDckpwajJCL2daTWxjNFZ1NUQyMDdONGkrM1BsUytvRmhTN0ZUaVdoeGFH?=
 =?utf-8?B?ZVRsc1k3TGN5WUxmTGNjdGRzUTNhb0hhOW12SzBkTVdtMlFXY0FNVVhhb09N?=
 =?utf-8?B?T0dsVWNaSUlFOVZHU2JXWFZ6MGE1QVNtZ3d2dU5sZ0c3cHNPcnNBSmtFR0ZV?=
 =?utf-8?B?YnBVRVRwYzgyeE0yZUZ4cEt4NUo5YkN5MUt3RklNbnJvQ3BzTmlFcFc3Q2dZ?=
 =?utf-8?B?elFZZzJEcFZNZDd2eWVVU1hlVHg0eG94U0QwWTNoOFc0QURFalJBd2VKcDJN?=
 =?utf-8?B?VGxJZ1A4SEF0ZEp2STBGY1RCWFV3ZVZMdk5selJreFhIS1JFc0RPdFA1eHc0?=
 =?utf-8?B?cFJJN3NqbzBuVjdEVGpaUzdKYTJIQ3N4Q3dvUkNRMzNabE91WGhQR0JsNU9X?=
 =?utf-8?B?cFVFcnBRQ1lTcmYzYmlSZU93M2J3bm9tYW5HenRMd21IOUZNRUlyMDhDUUVw?=
 =?utf-8?B?WmdMMEdHTEhXUHFlRkIyeFExQkxsc09mdUlIWFFOQ25DZ2FJQnFCUWltUjlD?=
 =?utf-8?Q?fZ/SWgZhev/t/y6+YwYg6HupfYBaYUmHINTmU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlFMVTdGNVRFeEg1SUlJV2dpN3g1RnVteTBjRzFRUjMzMXloVzYySEEvZXFT?=
 =?utf-8?B?Rmhnb1R6SFBob0hWSjNOT0JuUURiZG5jaHBFMWF5aFc0MldQMlZtemtuUkpX?=
 =?utf-8?B?MW5FbjNGZ2pKZ29EK2ZyN0xmbVh4eGxuclBjWEE4N3d0K1haUGFnajVjakI5?=
 =?utf-8?B?TlZidThkZGZibmtaQU4wemkxRExBMDRveHNjWEVZWXc0T1ZCQnlQRE84OWxm?=
 =?utf-8?B?cEZVNDRuU2IyRER2bW1PRDVVRXN3ZWhNeVhUQ2JIVDF3Q0IvZStPczBKckov?=
 =?utf-8?B?ZlI0NkQvaE1FanNWSnJqdmRmbWk2R0VmM1BpRUozZmlsQzJOdGp3OFI1TEth?=
 =?utf-8?B?MHVUSFgwajVUL0sxbVBWL1dZeC80dGpoaWdIN3VuNHRrcDRPbFhaWXIrbmEz?=
 =?utf-8?B?aW5YdXowMjRVcnpMa0JNQXJoSnc3eVdCV1QxZ3UwRjlITCswcEE1VXZMZVVB?=
 =?utf-8?B?MnpXclRMYzVadWxzc3FjaTRJd1FSTGYrZHlhb2JIdnNrUElVMXZyYXZ2UUF3?=
 =?utf-8?B?OWdqalJ5NUI1UWN4NEZsSjl1bmlxMTdDK2dla3hmUjZkclU2a2VUMzZ0cDRj?=
 =?utf-8?B?Q1g3QnU1K3FQbjJYMXNHN1FXaHVra08rUTArZFdTQ3l5M2lRdjc3V3dHSUNh?=
 =?utf-8?B?UG9tajlSbkNNWEdkQ0JoYzBRNEdXYTJBYi9odkFob0lLbVFEMlN1eW9QbCtw?=
 =?utf-8?B?THRJUWVjemJLRjVxdEtFU1pGcnlaaVM5ZVFmOXdsR3dKLzMzWlpIOGdVYTI0?=
 =?utf-8?B?S1FnZGhxajREU2c0SUJiUUVWMlAzSU5PVitkNXRkVVh2VWNNbm1sbnRVU0JS?=
 =?utf-8?B?NTh1RlU5eHFTdVcvK00zNEc0SENVQW45RjZ2aUNBeC8zNWlvTUZpU0N1Wlht?=
 =?utf-8?B?ODR6WDZWeGNQNGx5RXU3anRWNndlWGE5TDNaNXVETFlacWJDaCtlWHlORUVn?=
 =?utf-8?B?eW1pVzZ1cy9OVGtvRFcrYS93QWdiakZSNWZZRVN0Y201cjg2ZVdrSFZZZkp2?=
 =?utf-8?B?Z1pQUkRydGlmeFM5U2xGS0hPTXBaS3ZCR3JGWUhqNWxKYkN1NlJ2MEMyOCtk?=
 =?utf-8?B?TXhDWmFCYTl1NWJFMytuRW5uYlhidGl5T3hneXFUZENiTUxBRGk0M1AzVTJq?=
 =?utf-8?B?T0hXbFFhWFF0b29NalNiVHJqOHFHMkJ0QklXMHRuYUVZbDJxMlFKVmF1Q3JT?=
 =?utf-8?B?MjNZRlpYMm5oRkp3R3dYVVVDVmx5akNTbE5uZGhDcEY3SGNKUnp5MU9vOWdY?=
 =?utf-8?B?YkRXWTBySUlETnQ3MjA4TGFGNVNhN05LR2huVGpoaFhuL051em55aGxrNkdl?=
 =?utf-8?B?V3FBQVFrRGZSYi9ocG4vMDMxclI5OGtEdTZSZ1dHYmFqZEpKSHNTWVcwRlc4?=
 =?utf-8?B?Yy9xbFE4bk9mSndINFpMdjFDZDc1SnlKMzl3ZUxaMFdacWpjdzRPZ21LMVRX?=
 =?utf-8?B?aTZHRUQvMWo2UGZmR0FKNGZqdlFGajYxUjc2TXFNaTkyVTUyL29WbzEzNHM0?=
 =?utf-8?B?WisxcE1TM2l2c0Vydk93UkhCd3JHQ0lyMWNPY3A3MUZPWEVnaERaMG5XSGlu?=
 =?utf-8?B?UUd1Rld0Mm00VzdaS2N4QklSOUZPbGRsdXBCYzBxQ2ZBT0tBK3E5TGRiZVp5?=
 =?utf-8?B?cUN6QTBoTjQzTnQrZkZZcGZUdERvOVkrTDdHWmhEaW80YUROQWUxS21GdnJx?=
 =?utf-8?B?YzJjMzlKbHNuTExHNkp6RkdPUlZ4cXVDcTNGRTlvd2tvL0VNeEF6Y200YUgw?=
 =?utf-8?B?WW9nZVA3U0FEMGRGcmI1MlRZNktFM1JaT2NkZVl0S2R5N2VKbzBiRWRkMk5U?=
 =?utf-8?B?MVRMS3h5T3ZYMnUzZk41MGVqNFh4WmRubjhyaTcwRi9zM3JEQVBuV1llMkky?=
 =?utf-8?B?MDRLa2pGYWx5clhMU0U3Z0ROVDRoMzhWVmxodDlZeXlhU2o2ZkJCZDAwbVVq?=
 =?utf-8?B?UzlrUlFpRjd1TE5POVpDay9RT1BqZ0piRDF1SW9FU3h3cndkUXFoUzdPTHFH?=
 =?utf-8?B?OXBuL08xODE4allkeHdINnVFa0pMcm1iYlNZZGtHdThIZ3UvN1ptTE9JTUxP?=
 =?utf-8?B?Z2orUWswTjNzOUh1dW1KL2RybkdiaVpyV2ovSDh6eUo3QmZ2MFF1U2FGZEJo?=
 =?utf-8?Q?P61pw8ZTqaDOKmzNaO5ZegSHb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbffe5f-67cc-4207-ed0a-08dcb480516a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 12:23:59.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SwmRavVLotqu1BWdLgi6xl7LWhGgj9rIAWqxD6iWvW7inaOnh7u0ZKhM92oTNIRDGrb08gRSm2g5thgRSLCVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7413

i.MX95 PLL VCO supports rates that exceeds UINT32_MAX, and the
i.MX95 System Controller Management Firmware(SCMI) server exports
PLL VCO for SCMI Agents to configure. So introduce
assigned-clock-rates-u64 to support rates that exceeds UINT32_MAX.
And introduce of_property_for_each_u64 to iterate each u64 rate.

The PR to add assigned-clock-rates-u64 to dt-schema has been merged:
https://github.com/devicetree-org/dt-schema/pull/140

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v4:
- Follow Stephen's suggestion to simplify code for patch 2. Thanks for sharing the
  detailed code
- Note again, patch 1 and patch 2 is not relevant as of now. Just for
  simple for reviewing and know the history, still put them in same patchset.
- Link to v3: https://lore.kernel.org/r/20240730-clk-u64-v3-0-4d2b19edaa6e@nxp.com

Changes in v3:
- Add R-b for patch 1
- Rewrite patch 2 to avoid duplicated code. Patch 2 not use code from
  patch 1 now, but since patch 1 is a helper, so keep it.
- Link to v2: https://lore.kernel.org/r/20240729-clk-u64-v2-0-ffa62ee437e6@nxp.com

Changes in v2:
- Follow what Luca did to of_property_for_each_u32 to write of_property_for_each_u64
- Link to v1: https://lore.kernel.org/r/20240621-clk-u64-v1-0-d28a611b2621@nxp.com

---
Peng Fan (2):
      of: property: add of_property_for_each_u64
      clk: clk-conf: support assigned-clock-rates-u64

 drivers/clk/clk-conf.c | 42 +++++++++++++++++++++++++++++++++++++-----
 drivers/of/property.c  | 23 +++++++++++++++++++++++
 include/linux/of.h     | 23 +++++++++++++++++++++++
 3 files changed, 83 insertions(+), 5 deletions(-)
---
base-commit: 233a3e45c39db1e52061f3b6bbab9c630845dfad
change-id: 20240621-clk-u64-70c4333f0f80

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


