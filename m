Return-Path: <linux-kernel+bounces-292583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5D3957177
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C62828256D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8283189919;
	Mon, 19 Aug 2024 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QltyYoRb"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F701898F0;
	Mon, 19 Aug 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087016; cv=fail; b=EJRpyUZYJ/ECf2JuI1PwTMvcNQQV7sb1GVtZ3EMZ0VyU/U3qkxn0IiOwWI/4l4tl9Hoe0uefPXBz51q8py9C9Cwfv5CXVSjbzmD1rklQJJKDy5noVDX8iSxiH7qNmQq61al68bwovkdHgMxiSianj+63FrX227UAhEr2csO5Cwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087016; c=relaxed/simple;
	bh=zyAVJdDN8Bd6gaEgaZOPaF3XGa9bXyZ1khkk1g9k2iQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DBLMaiCLxiWajXyEwx4sPQX5m72URRm7OYcQwEXEWzdkOcCURIsKWXG3AeRKUyg02lThlpyKbVa473eqnglhXdXmXAQrfeG7f7qBbOQ7qwtxi3FqaRlqy9o0JPHSknrXbfFcmnlsg7OcKoskrSnh3rMMWQZUhTsHEImBlRgW2GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QltyYoRb; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfpMzfIr3tMW7jK2R3x/lVEUx+B5Evzf5K2tVsUjpNEEs5z9ePrNA+WrIhG+XGtzfzZFTmruVJu/TYQQS1p+TIM5HsHreOnP/nDn0ZUxMUIp7pi28WT0gNFg96+JCjNp30rPjD2y7iL0VvnR2Q4XjFCUOkpyCskTPVxd15tEEPpbS1sMRm0cd98GD6CLWy2M7f2/Lf1CWhCIycQKUZTLAphkK1Pv+6N6J/7QNoNSNJ/MKIEo2C3qdHByPD54Yg+qjpJAvp6oGICT5O6aRrOz1t4qaWs5uEHxcyOahDIJInSiOXCUKwBmnuUwNq8mw1IiK/qWH4NXGJd2ajhUaTseVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr+0ebNyDnqLuA46OrRehy8AcUHO++Xfwy52+dM0DGc=;
 b=Ui2+G8C23pXW7m/CXzqRMMJYDh/2YPimJur86sstgwgdn6rdQEmmQx+M4qSw1dzbL6hTZesj0jJ1W39GUsZ0cp42FymV7X3ylj6/YFbXKsXZgNBBw2NcBhZa7ACSLJ+fHMyXhhuIk624Jam0oevEGcbdIaseJJEqM8oiYyCl42jeQfnM4mXGKCZmnAZLzJWa1zq8bs4C736YEXNis2XDuiWDk3gFukiSAOqUhZZCqWMdGPa/43pEQbKfAGQHGeNIl9XM38cjBk7D1VwvD7daEHXpfkmzSd/QTERAEvq3NkyjqV+7zRDC4C2HMZqOqMrJfjRfXxDy9OAg8oDaKzOp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr+0ebNyDnqLuA46OrRehy8AcUHO++Xfwy52+dM0DGc=;
 b=QltyYoRb7+gUMDypxy23kIPozJcfWXI7601KB9wvwO7xwbuOPjTssokWlsEC+GpyTzwCVkNy8ZLgb/QvQANgqGmgJNH+CcXXNlBnyxqv95Rh23C+oPta9Y9mk1NPOFd1/tnff7tR6WbGvLr+q9UHdsJVEPoc9ZZKDpBnzkHupKvPO94sFKiKoHJblfQdIwdHk6+0jfITa2JhxVEIXIuw6bHSBphMLbc4FZhsxbFdwNfDNsakYJPuhc84re4y/LjxRCT9keA5ljp1ogQfwfX69ESxluIW5BIA0KS55Dibfv45dNkpo/qG9JnrCaf5JSfqwD17yb2M2mWGFQo9Vvmm0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:16 -0400
Subject: [PATCH v2 07/12] arm64: dts: imx8mm-venice-gw7902(3): add
 #address-cells for gsc@20
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-7-4c428bd11160@nxp.com>
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
In-Reply-To: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=2622;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zyAVJdDN8Bd6gaEgaZOPaF3XGa9bXyZ1khkk1g9k2iQ=;
 b=27DLFqOwtyW+5pGCyOGI5a4YE0rvCWIBP2xkAOSoLdgAMKSoyGbGm6sOVye+zsdY6uH/9qxxp
 w01OPv1goI3BGbrViqXIGOQ0yrmGr8TvuNyjBn3rFFFK8bWY9u1eXiO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: f012c5da-633d-406d-83cc-08dcc070db05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1NuQ0llcENaaWpNWEZsaTFjODdJeEhlL2ViMENBODkrZE5aTENFSm9TT0E4?=
 =?utf-8?B?azlNUFdML0tpSHlHclQ5d0xMbnU4VmNpaGs1M3ZTSGRHVStwM0JmbnlpMkRT?=
 =?utf-8?B?SkNraVlsSVpab2tmYWpuYll6RXBpV3JYVlVIVThsbzlwNDVadDFGVEY1ZzE3?=
 =?utf-8?B?Y1A3cHU0MUFNeTJzWGpmU1BqeXhOM0QxTEhuVDFCaVYvcTcwdW1UUjRYQ1N5?=
 =?utf-8?B?Z3dyWTAydEVMbHpSZkdKcGZLbi9NVjY3eXBiYnl4MVowR2QzSVM4c0NPWnlD?=
 =?utf-8?B?cHU4WnpzNWkwYzZhOTAwcnFMTzJkY0dnMHRYWm04RTJpcUNqR3Q2WDlNU3VW?=
 =?utf-8?B?RlBEakcycFJuMXV4aWMySzVneDhYbkx1ZEhkK3pkVitlQnhXWWh6emdqQUsr?=
 =?utf-8?B?blFrNUtEY2h6eTVjNlAzOSs2Y0ZnNmpuYXdoajI1SllhMko2dmxoc0ovL0lp?=
 =?utf-8?B?dzVLaDRrb0hJUEliVEphSTFicnYwZWRMbEw2Z3pOOVcrS2tGMUtad0FWYWpt?=
 =?utf-8?B?eDgwRjF3Vy8rc1hEWHY3NHNobHR3aWFneU5BU0RzRURmMDg4VndEM1lwT0M4?=
 =?utf-8?B?UkxSdUIzMWhqeVhRQzhTM2p6OVJGU2o3NW55aXVyaVNnKzlkRDBCL2VHM3JW?=
 =?utf-8?B?Kzc0eUc1ZTZ3dlROZE9NcmRDbVRQK1VvM2U3eW5YeDhvZlptVUwvNUJIY2t2?=
 =?utf-8?B?bG5PQTRCTzZDNDBaTm1ZajJDaXJ2aFhrcWJWTElrcTdXWDg3OVlVeEdVb0Za?=
 =?utf-8?B?U1RtQ29kRmZsRzFTc0xzeCtkRWZuRjVXUHpmYVlOY1lQeWxWZVBkSnhGanZj?=
 =?utf-8?B?UG5lYUd2UkROYWtmSkR2emtWQlF1Y2Z4dkxYMFpvb1BoSHgzNWllNGFsVG0z?=
 =?utf-8?B?VkVsU3BZQktodmNSLzlDOVZwNjFGbjd4VjY1d2I0QjAxVEIwWExIR0NHV1I4?=
 =?utf-8?B?NFRSR2pjRWxvVTF0cUl5azJzYS9DNDZyTVM2RVZBN0xsZENVSFp2a05OcmJ5?=
 =?utf-8?B?MnM4OStIMTBIR01KcXl0TXNRbTdneTV0VFc5VkNhbkhZQ2dMQW95QlhvMXFC?=
 =?utf-8?B?TUlrSGdoeGp5Q0doam9ERnJ3a1dhR0NjUFNhZExvUnpGV3gyZndhTUpzZ2Na?=
 =?utf-8?B?OTF6TFNMZ1BWRm83WldhKy8vR0RZbjdFSUVCS3VBa2hFMTZUb0M0WnhTc3N2?=
 =?utf-8?B?YXErM2N1YVV0VDJVMFpyOHFpQW5KcXFCSWR6ZTM0aW9obGRLdWJaMlF5b3Jn?=
 =?utf-8?B?Y05TYnNaeHh6MkhYVVZJNlUyV1lERExvaVpOaEdWTlQ5eWJWRnVGVHE5Rmh5?=
 =?utf-8?B?dWZ5SUppdkxIRlgvRitDb3lNcHlacS9UeTZtRkNUUzhCcmZYNThWL2NVSmRz?=
 =?utf-8?B?MHBGZXI2S0hzUUhWaUpLWFVvNjJzTWhlNlZWSi9tQmNZOXBVQUEwNmtYUlo4?=
 =?utf-8?B?MUZtS0x3WXhrdVJZY3pZRzNUMThJQnBaY2NrcEE5eGU2ZFNsdlladUJBWVpE?=
 =?utf-8?B?VFZMNENpRU1wSGljYi9aUzg1NlcxaTl3ZEUvVE9LcEtmRE1ER2J3azlDam5n?=
 =?utf-8?B?VFFBenk4N0lrdUpBNXpyT2F5VUNMWXpwTTJKelpaN3ZsTXl0TTltMGROSVI4?=
 =?utf-8?B?SFhsYUVybEg5UEpwZS9RRm1ySU9qN052S3oxUlFZckhGT3hGZnFxalhsL3JW?=
 =?utf-8?B?aVdoNWdvZ3NvWUtvRkh0VU8vNFVpT2d6UDJlS0lOaTRtZEIxVmNXOXZZOERF?=
 =?utf-8?B?SU5aZUhBRHBxaHVrVnQzS0JrSkVXVHhpTDNVd1ZNbjNDN2MxYzdrQmNGM0d3?=
 =?utf-8?B?VGZ5d1NmenQwS3BoOXJlMFpMOU82cGVzeWxCNFBGQ3NPTWlsYkJaTFhPQVh0?=
 =?utf-8?B?Z0sxTDc0elE1a3Q4bXVGL2RVbFM3endqQS9TTTZVQ2hiVGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEhHaFFQMldqUWFwdVQwenkxZW9KTmtxMUozcjcvNlhySEVrNlVsN3NEUUpD?=
 =?utf-8?B?MGY5eElUZjM5bTlROWVldTJyTUFvVFVWaDBZOVNVL0pJSzdvZUk1dGtsSVQy?=
 =?utf-8?B?TDVYS0NCSm9oSzV3ZEppTWFrYy9vbGgrNDJFVytYLzJXdHRWbkxtUHJXRkVw?=
 =?utf-8?B?OEdiMFNaQ0F5MjU4ZFlaVEZzYU12UE5KM0pqckVpSXF4czN4QnlqOUM1cTRS?=
 =?utf-8?B?VmNYSUV3dlZWTjhFb0xKMlRXOTY3RU1QaTI0cWEzMzVhdzFtY0NaZlBiM3VI?=
 =?utf-8?B?aWdnOFhlUmJack51YktrbU43RllaSFU0bGJ6cVZ4NTN6eE1Sb2k1eTFZQlFK?=
 =?utf-8?B?am1pT0ltSGg5MXp6aDdQOFJYa1VldDNTRXVadSszcEJkSVFEYkJ3Zml4WXZh?=
 =?utf-8?B?ZHBmV3U2THdlREFjZDBkaHNtWVNlaWs3RkYyR0tWUDY5c0o5dFhuTHlRc3I3?=
 =?utf-8?B?QllWNHVzU0JyNDFiVzBaS3FxckNrUXFaei9TdXUySDQza0ZCZlZxTzNSZStu?=
 =?utf-8?B?UEEycjNjajR5dUJUZlNoUFdhVjVGb2ZvcFNzMjAzOWxiRE1IbW1PM0Z6TUxW?=
 =?utf-8?B?d21SNXR2MXE3VndNQnlaMHpvMG9udTR5M0Z5ekNEY0l2OEJLRWhvRXVCYVZu?=
 =?utf-8?B?clp5UU1ySmVWS2R5NWtnZlVKb0xqbmZRbnBMUXkwVWc5bFB0aDI3a1E0Tmln?=
 =?utf-8?B?RklsMG1janpEMGhEMkhBRWxyUWJuWGxITGViNXYxR2FlRW02bkZCWkJwVHp1?=
 =?utf-8?B?SSs3ZmZtRXRnRzUvMzVXM3NsQlpiTkxGVG5XK1A4dm8vbElrUW9zSFB4QmVM?=
 =?utf-8?B?N2ZtLytzaTIxaTJCZ1huZ2ZnZ0VqdWVXMVErc1UrTS9WMjBKNDRnMlVvcENm?=
 =?utf-8?B?YTRGaUVkcW1McXdWeE1mNi9EdmlJTFdSUnFocDBRNVRRam9PUDNUZEpXQk5M?=
 =?utf-8?B?M202OG5YQVl6cThjMEp6VGF4cnBTWU5JODlBdVpSOCtGU3AwSnFub2ovUEUy?=
 =?utf-8?B?NmtRc0FpRGNENzJBRENudUk1eVR4d01iWlFoU2d6ckdSS1dJWTc4RjBxaElj?=
 =?utf-8?B?eENYa2l6QUlCeVdhTTFjc3BtUmlJZVlGSVp3UmptUlBueFBaVThIN3RaUG9o?=
 =?utf-8?B?T0grN1dhYzZheUxNaXJja1R0cnBsemxnbkNzdmVBSUozaGR0aHJWNDJaclEr?=
 =?utf-8?B?Z1JlMUFJcGVkL1Y2OE1NckJFSjRwdGhnVUJ5aDdoOU5HODdwZHppbVhYMWI4?=
 =?utf-8?B?aWlNT1hUNGhFZHYwWFFwVTVEUzdRb3pKTU93bkNjckZaZXdNRjhNYW80QnVz?=
 =?utf-8?B?bzZldklhaXVmQWJ6UG5XWCszenkxL1VXLzlzVS82cy9TcnAyZjdxbkF2aG5l?=
 =?utf-8?B?VUxIYjlLT3gwOFErVHRvQkk5TjZIc0N1L1ZsQmVIOS9hNUV1bG1kQlJwLzR3?=
 =?utf-8?B?eEY4MW43UjVrbldnM1B5dTVUVng2MElVb0RHUjQvWHFod28rSFNEWkdXUHQr?=
 =?utf-8?B?b3NrdFN5eVdhOExLbEdFNW1nMUxPYnpMTlpOa1lKbHQ0d1pLOEV3cTROQ2RS?=
 =?utf-8?B?VU9KdWRYdmtLMm9nT3VwRk1ZTGI0Zk5yM1B1bWh5MFF5clNocXYvZTJrZ2RE?=
 =?utf-8?B?MFJtWnVJWHRQZlNKSDJPU1YrRG5JVkhaald3d25LcEI5bFdQRXQrVmprem1V?=
 =?utf-8?B?Y3FRWVNSNzIwSVpFZ0Fvc09BTTNsT2lFQmdxZHd2WFovMEtqS2F1R3dHTDYr?=
 =?utf-8?B?QXFJOG9jS2NMTi93QUgvdW9IcWpUM0NrMUFWT3AxSkFDR3BFV0NiMTdsYlB3?=
 =?utf-8?B?eDVrcys3R09VbGpRRnZ4dFBlUWluZ2Z0Sm5OVGp2NVo4QUpDcVZHZzA3N093?=
 =?utf-8?B?MFpUd3RhdkxPTzI3SkxPbnhJM1ArTWZZZkZkbjhHVEt2czNYeVgrZVdrcXZm?=
 =?utf-8?B?TDBNd1dGVmhFK3RRQmpPTWExa29PRVBWcFc5YnNGOHZJcUFKRUI3V1hRcmF6?=
 =?utf-8?B?dUd4OUE0dGNQYWhlN0s3TzlUME9iWTI4TzlXYlB4VTRENnVsRFBheGFyYW43?=
 =?utf-8?B?U2lGenF2SWFrRTlqNUU1TTJNeGxmcUQ4WkRQMnVGdHB1OXVDTUdCVEdqWndj?=
 =?utf-8?Q?8JtNaJj6mavLVVfifKt9GL2bD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f012c5da-633d-406d-83cc-08dcc070db05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:32.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLG6b2p5A2FAPRbUsRC2JQ5NaVBKtSDhyYZAM9J8Kj0dQkOwwfTJ+wJAOKtVzCydc/78iVgH4BB2vAw0enQwkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

Add #address-cells and #size-cells for gsc@20 node to fix below warning:
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb:
	gsc@20: '#address-cells' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 2 ++
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts | 2 ++
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts | 2 ++
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 1d56f2a6c06a5..c11260c26d0b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -314,6 +314,8 @@ gsc: gsc@20 {
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
index 45470160f98f5..db1737bf637df 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
@@ -280,6 +280,8 @@ gsc: gsc@20 {
 		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
index ef951bc9f0dd4..05489a31e7fd8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
@@ -330,6 +330,8 @@ gsc: gsc@20 {
 		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 72004ab6bda55..0b1fa04f1d678 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -312,6 +312,8 @@ gsc: gsc@20 {
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";

-- 
2.34.1


