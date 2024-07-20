Return-Path: <linux-kernel+bounces-257973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D49381A2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884271C20DBC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A721803D;
	Sat, 20 Jul 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="S8XG5LlU"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022113.outbound.protection.outlook.com [52.101.66.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DE13B597;
	Sat, 20 Jul 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721485178; cv=fail; b=D/5nnDwUGHtA8lSBax37p/YUDwO/rjdXHx09sZiVBiOhfxQFH+BvJenCePqUnAWF/0/T80o1NjBN8OsshNLYUppfBb6s/6JMTuBr+xrSNclvAYoKZequlDZFhW7aK5XosxqumU0cSUh30M8Tu5VEubrsXYM7e3AcE40uNJqgVeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721485178; c=relaxed/simple;
	bh=ybyjDVoSNjKtSNsQxgJ5pXYFX4OhJhrGN6ivBF5a+rM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eI0K9vnef/KlysteF7ji0ZIlz/1RRLfbZQcrguzAETSVYWayzL7mweEO2DbSll/OFcXg50kPzJVyz/VwxJ3c95cD2mi2PZm/GM25gomzLXkFasKOPX7HSOLSQGPlKL4ilg+6+Nrsb/uZ6db4CS083q5TWFKg1ZjWVeuE5prqlsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=S8XG5LlU; arc=fail smtp.client-ip=52.101.66.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3Y6nWn8ymm8DVc+Sb0qE6gn66V/5xo0m/hJPvAvnyVeZca5ED1aNfI3/xjlcxSm35+o4XoHToQuNQs+HSpZXnpChlVEiNNIY58+5/F1+Nt1DfDCS4601rSvNyCuidB3XnH3+hLa0EanFXFwsrKI/7arxFFoHOs3fhwHDBtT0YdDqaQ23B15VPkMZusFZlI2CjONLevliNYr8NIZ8PT5P5Aht/75YsI8+VaJv1W+3yqatE8a1Jzg5+RlyjnJFnYgRC1SGpUUpxzsRKXQMmunBFQdh4EzzJQ8GoLrF5ccsN/VhfRXO1fKe4PbJ4WSu/xQSrhbh9nucD96bKLIv7P+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZvsUHDZA8RNKvihZtEhaYsycYah4HLgLtgb2EkqA28=;
 b=duKoQBCufpF+LewyiEuRHCVQO4M609i8z5Jvam+RrceLs4YQXNlzviuEyFJl+AvJi6E7dbUCG1g4yjIXTD1755/wIIBYQEvuUjF2NhflGqjHGz3bT5irljfD5B/v8qXMpDwRt22VQUbE+W6FLGlbTsvtLt7xAsCtp38v/EKwT52eX5xEzEBCXTcvnDew1Gq4c8af5yATFNnZs2hNquC4EpPostPUky1mCF3jDll1cS5Su82IdLptg1EBdAQEJ1FCTxRaHddmjMnRWIdm71L8Sax00DzQt4aOJnBjcZtlB7D8+ozvroBCQNQ3/Mlm7th3Y8MvSmC6m2ja7HbijwmlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZvsUHDZA8RNKvihZtEhaYsycYah4HLgLtgb2EkqA28=;
 b=S8XG5LlUMKz3aJQhdlnTdrAdYWlEVm5mDW86a1npimmbQLPbn9wMkRuPoOBy05sbOYcak9mwhpblNRzKHy16NBIfUJ8Fa//QvG9rMoGLUk9MopxrVuWwRpmYLLnUYBAniMqdWNXhUnT86GwwFHfERKXR8sPxPT2vUcuVHrmxo28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI0PR04MB10299.eurprd04.prod.outlook.com (2603:10a6:800:238::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 14:19:28 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Sat, 20 Jul 2024
 14:19:28 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 20 Jul 2024 16:19:20 +0200
Subject: [PATCH RFC v3 3/6] dt-bindings: phy: cp110-utmi-phy: add
 compatible string for armada-38x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-a38x-utmi-phy-v3-3-4c16f9abdbdc@solid-run.com>
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
In-Reply-To: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Konstantin Porotchkin <kostap@marvell.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI0PR04MB10299:EE_
X-MS-Office365-Filtering-Correlation-Id: b30e3525-f845-46bc-b70a-08dca8c6f761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVptaSt5c01GQytDTmFnSjJXbm1BS25ZY3FVMGdhL0NCL0FWd1pLZ2laQTYw?=
 =?utf-8?B?YXJwb1BBVCtrbVJzbzBKUTUwSVVJZXUwNVlQVzFoS3RzU0ZPa204dUUrMzAv?=
 =?utf-8?B?ZHZNTjU2aGJhNDBHcnpPN1BmclMxa3ptY1F4MVE0bStnMVBTUi9sak1PYkRU?=
 =?utf-8?B?b2w2aTVaNWZVSFY4TU5HRTA3WWlLb1o4S1c0R1U2bmsyQ24vdUNxY1hhZnFG?=
 =?utf-8?B?UUk1M1cwTDc1cVVhNDlHYzhuekVlUkw3L2dWVGlXUVBOZ0hRRjZhVmFlbG9V?=
 =?utf-8?B?TDI0OGxHS2lsajlVK09MR1hIYW9vTFBCZkZjbTFhaEtKbnFIQnBNczNaMGt6?=
 =?utf-8?B?WGFGdVZYR1dKeXQ1RCtPaWxZSGtlazVNNDJpTCtBeGdzRy9RRW9IbGhWQ3Jn?=
 =?utf-8?B?MytHNmMxL1o0dnVybWpJVVpPcXpwMEdhRDNidnFUMUtRRkI4OGZVYVE2TWlW?=
 =?utf-8?B?c0czeVQ1aXlkNjhlRzkrMjdnWEZaQ1BKSzZsNHdQQzdKNVFZR0lKbUVzVmtZ?=
 =?utf-8?B?SVlRSzZpUjYzRytNOVpmSjdvZVBvRThQZlk2RHVBNWJUb1F6eFNvRm95TTFG?=
 =?utf-8?B?WGZjT01XbXlIM1Yvejd3K2NqNitJZ2xOR0F2TVRjTWZGTnJCdjFCNDBmMC9V?=
 =?utf-8?B?VVYyNnNWSnZhYmhMYTlGRUNleFJWYklWTlRJRkMzMGQ0dG41L0Q0aE00RUp0?=
 =?utf-8?B?aWZlZnZ4WlcvNlhsODVqcWNFN251K2UyRVJOWDZBVkVwRE1OU2w1ZlB1dGVY?=
 =?utf-8?B?UUpxNm85R0E3UnUreTFLbFY3eVEyKzNpZ3JSaVh2MmhFWnZmRm83ZFQyZDZQ?=
 =?utf-8?B?VlVyMHpQSnIxWlFoSVlXNzdHeUpFUW9SbTFvaE1WRktZaVljYTlwam1uZE43?=
 =?utf-8?B?alJMRXB2ck1PeEtGMTBNdDBJN0tuUDZDdkFsRDZteXl3dkpqWVJDUkZKZTI1?=
 =?utf-8?B?NmxNZXZFcjA4enErODBoaFFtTnhyVWVEZDFDbXFQSmtsUkxsMFg3K21nYzEx?=
 =?utf-8?B?a3J0SE5ZL0l1M2lBTlAzcEZQWDgrR2lIM0hwSVRYL3phN0NGUFhLZHlMWHdp?=
 =?utf-8?B?RVE2U1ZwWUhmOWlXSDh5T0lJRmJTT1dGQ21SVCtlUE1NcHYwOXN2dnZQU3lV?=
 =?utf-8?B?TEZrQ0NtZENSVjB6Tmt2Mk40dlBHbUI0N0NLaXFQQW5mQnp3SDd4VVd5bHFH?=
 =?utf-8?B?d2VPYms0SmkwbmxtVS8yTkFLR2RpT0oyWUZXbnZ6TW1DZ0N2dC9Ed0lza1V3?=
 =?utf-8?B?blI2eDNxTEgrQ3ZTbWFqWXJTUWFyaDZFY0xCUFBzd0tnOHpBK2xSZURLK29T?=
 =?utf-8?B?OWpBYWtaQ1h6NkVCQ2xGZHN4aTk3QU5GbEVZZ0RPc1N2V1JZYmdraFZkRlU0?=
 =?utf-8?B?NzY5UEU3SUNQK292YWtJUVBNbDdqcTR2RUZlMTdKSzZ5aDBzMUoydWpIQXVF?=
 =?utf-8?B?L0Y5bVVoby9zQUR3NWlaUC9DMUVvZ05peHVQK3ZVTUdiTEV3cFh4U2JkS1RR?=
 =?utf-8?B?cnlBUTBMYW04S3NMQU1OajdtNFF3SWdLK1dHbTFKcG9yaHNiU3FiU2xmU3o1?=
 =?utf-8?B?NFV6OFM4MFBMT1lkVHRjNENCcWdYR2ZqQjZFMkI0bXRQb3lONWxqa3FLcnJw?=
 =?utf-8?B?bmNwS0ZML0RLZjlZSk9VQmpsbnRMRlVZNWZFT3dmcTh4bFRrb1ByYm5CZFJt?=
 =?utf-8?B?OGkvVk0rSnBXTU01aTUrT2d4bUhmRnluSjRPTmdncnFNNnlMVGp6WW43Sy9k?=
 =?utf-8?B?dm1ycDBITGZQU21Qdkdxamg1YU03WVY5OEZOU1JDNnZ1bTdiSVJxKzIrcDFJ?=
 =?utf-8?B?N2pWMjRVUkNLc1NQYTFZaHhPWmxZUVFOTGR0WHhUbXNSY1dJVHAwTWtTSzJu?=
 =?utf-8?B?dk1uTDJ1R3lrN1AzZGVCcCs1c1FHTU5tZWJvVWtoRWpBQTRadmRhWGxEZWNH?=
 =?utf-8?Q?sZOk0cg5IVI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1poeUZnK0JYYmN1SlF5eDIzNngveEk0d05VYmtJSUhIL0pPRGlXL3NwZEQ2?=
 =?utf-8?B?RHV2VnFVYk5BRnVLcVJSbS9iNE1peVkxMEp4ZUtGRWJncll4TU13ejFhV0lM?=
 =?utf-8?B?M3dyQ2IyUXFScU1FWnJ3RGhtL01ITzliVmZqamxJWUpUeDdyTDdncC9ETUpS?=
 =?utf-8?B?Ylk2V3p0aG5BUVR3L3F4ZXVMS0FsSFMxeWZRQUpGd0VsWFFuNlBiSnFPT3hx?=
 =?utf-8?B?UEdKenRIdmNoVVVubmYzdnRKdVF1YllWaGxhL3Q2RWdGTC9PTnZ2aTZIQUhD?=
 =?utf-8?B?LzlLVldDMkgxdnhVbW1nbzJoYjFueXFwTVBwRXh0SXY1d291K1pHOUQ0ZTZP?=
 =?utf-8?B?TkdiRzVxQWpPZWR2d0R6TGRkdytTbk5FMldJREhvY25NKytCMmMrQmdsbm90?=
 =?utf-8?B?TXR4aWNzMmxZbU1kYzhXN01uYXJKdktteVJxVDk3eXpkS3RFSjVVd0kxL2VL?=
 =?utf-8?B?bXJaOXVhOW1zS2RFYnNaNTVhNDJQVWN6YVZieUg0eFcrMHNPMUtjT09YYkkz?=
 =?utf-8?B?Z21Za1AvdThhMWhXWG91amdST0pnV1dTSFBBRndFUXMzKys3MGhJVktUblBx?=
 =?utf-8?B?K0NERTI4dGMvOFc5Y2ZDc2FiKzNuNHlySVZWSkE3L21lb2lmSzRHVU81VDJw?=
 =?utf-8?B?VXFReFJBQlRnY0wvOUo1eUR0ai8wOUp6STRKSkFyczZ0ajhmamNGWXdyM3o4?=
 =?utf-8?B?Yk9WS2YrTmt4M1o4TFppaW1DRkZRU1UyVFVubjRVdy9kd2lxU0x5S1dQY1FV?=
 =?utf-8?B?aHV5Qlc2M2RpV0QwODlnbHh3TEtJWWhXWjdKWkxlcXEwY3NoYnR1aTRYSHVW?=
 =?utf-8?B?YitVNERzbXlqeEc1QTdKWWh0ZExybTF6TVo0S0xsMzlpbXhacW1iYURrbWUw?=
 =?utf-8?B?eTgvMXpmMUZ6L3cvbk1jVURIQURKem1sMFVIRDZGRlN6V3VRU1lnanVOdnhk?=
 =?utf-8?B?R1JQM0lFZndRMCs0L0ZtbldBanNBRWFuZ2lvWDFzUndSZHhTaEJsd2ROWVFK?=
 =?utf-8?B?ZGJTOUVQNEdYbHlGbVNKMmxKdjIxZ05lOC8vN3kxKzIyVWpaNkdCUGVDekoy?=
 =?utf-8?B?eTUvcjl6dWx5aUJsOXBvNi9iMHFFdWw0cVNCdXhQdnozN2RkOUYzQjQvNVAr?=
 =?utf-8?B?VEVXSG55M1g0UXhQRm04d25WR0d4dnZlQkE5SGVoREVWZDc5eVhRSVo0ajVw?=
 =?utf-8?B?Y0RTamVMV0ZqdXBKYVAxZFEybkxKTmlsSUkwTDhRMUhXY0loUXoweVR1Tjkz?=
 =?utf-8?B?OFRBeUpiQW9vdVo4ZUxidlZ3RnZiOWl2STN1RVNWV0tWRGVEVFJ5c3RBdk9h?=
 =?utf-8?B?WnM3ZWt6S0Zsb1NDR3BFRjNISUY4WCtiWExNekN0L0NHZ1NmR0hDMERxRE51?=
 =?utf-8?B?N04vSVQrL2lvNXFtNExrZllia3ZBOXFDMndGT2xrNk1pKzB5Z3NWejZaNU9Y?=
 =?utf-8?B?bmMrbDdOTmlLd3FqekY0dTNBbllQOVJzd3puS1ZWN09lZlpQbFB1UXA2NzJN?=
 =?utf-8?B?NUlRZk02K1JDL0lQVExiZHR1MkRnT0RIVVkyRGxGUVAxNVRvTUpTZHNnOVFB?=
 =?utf-8?B?bGh3L0tLblgrNWg2c2RYYk9wQ1FxdGhkTk9PMUlXbXpVeGVxRElLSkFQdVdH?=
 =?utf-8?B?d25GanhwSiswcThyV29HWUFLZUpoSWN6Y3BUTUdKcnkxSWE0WXhhb0dRRHVo?=
 =?utf-8?B?RWVEbTZoUSt4WTBOdGZQQk41Y1hWdG1RY1RHbk42NXI2WGFNNml1aCs1ZzRN?=
 =?utf-8?B?Q0UxazNITWFZZTVVL1NFTjBqMHI1cHBGV0JVZG9Sei9icWVUMHZ6NUNVTDZn?=
 =?utf-8?B?MEVoMElXb2oya2VZRGtWNU5CMUdHNXdNSGliTng1eTlNdkVjTk44b1FOSE5z?=
 =?utf-8?B?ZU9QMys2NXRYbjROU0UwOWdvaVpNYlJzMEFMNXlXTFhEZTdSMW51Q1pqcWdG?=
 =?utf-8?B?bk83M0pKSFR1ay80QmpWRC9YaUs5MXk3cGVOS3RwS3ZtOFVMK254d2h3R0xG?=
 =?utf-8?B?Ty8xUUdZWS9DaXdZdi9wbWRxWEl1UXk2TVNYbE9YK29Pay9LZlZscWwzYUVr?=
 =?utf-8?B?TE9DN21pL3VROHUvaWFENGdJWSs5MHd0ckxFVXRSdTVXZGkveVN5ZytwRWpm?=
 =?utf-8?Q?zqik44jgQXdUz7XKKx3pbxVBc?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30e3525-f845-46bc-b70a-08dca8c6f761
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 14:19:28.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWPMMdShXJj6yQjlIC5CzI49SL7pd86O0Wwuxusk3uwDdxDPRW4pLLthisUeVxZIEITu2lQ/8v+vxEiowa2mlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10299

Armada 38x USB-2.0 PHYs are similar to Armada 8K (CP110) and can be
supported by the same driver with small differences.

Add new compatible string for armada-38x variant of utmi phy.
Then add descriptions and names for two additional register definitions
that may be specified instead of a syscon phandle.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../phy/marvell,armada-cp110-utmi-phy.yaml         | 34 ++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
index 9ce7b4c6d208..246e48d51755 100644
--- a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
@@ -23,12 +23,36 @@ description:
   UTMI PHY1  --------\
                       1.H----- USB HOST1
 
+  On Armada 380 there is an additional USB-2.0-only controller,
+  and an additional UTMI PHY respectively.
+  The USB device controller can only be connected to a single UTMI PHY port,
+  either UTMI PHY0 or UTMI PHY2.
+
+
+
 properties:
   compatible:
-    const: marvell,cp110-utmi-phy
+    enum:
+      - marvell,a38x-utmi-phy
+      - marvell,cp110-utmi-phy
 
   reg:
-    maxItems: 1
+    anyOf:
+      - items:
+          - description: UTMI registers
+      - items:
+          - description: UTMI registers
+          - description: USB config register
+          - description: UTMI config registers
+
+  reg-names:
+    anyOf:
+      - items:
+          - const: utmi
+      - items:
+          - const: utmi
+          - const: usb-cfg
+          - const: utmi-cfg
 
   "#address-cells":
     const: 1
@@ -38,13 +62,14 @@ properties:
 
   marvell,system-controller:
     description:
-      Phandle to the system controller node
+      Phandle to the system controller node.
+      Optional when usb-cfg and utmi-cfg regs are given.
     $ref: /schemas/types.yaml#/definitions/phandle
 
 # Required child nodes:
 
 patternProperties:
-  "^usb-phy@[0|1]$":
+  "^usb-phy@[0|1|2]$":
     type: object
     description:
       Each UTMI PHY port must be represented as a sub-node.
@@ -68,7 +93,6 @@ required:
   - reg
   - "#address-cells"
   - "#size-cells"
-  - marvell,system-controller
 
 additionalProperties: false
 

-- 
2.43.0


