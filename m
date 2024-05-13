Return-Path: <linux-kernel+bounces-177528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC448C4037
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527672841A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D1A14D2BF;
	Mon, 13 May 2024 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TLaCRnlv"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28814D2B6;
	Mon, 13 May 2024 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601405; cv=fail; b=aG+aA1iE6m0eFVEf4pjaIPU2ahfhHue4Iy55jMukPF4/jdPEM1jfI4Nad/ejz96cMe5Vyv55WVD4hhm7VdvX7AY3Sfi2yMLoSXk4nesgaw5LgK6jvu+McVQ2FJOfajcX6yJkXjhlUedxvvog8+0RjoWoGMV4S24elvF1o19kHRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601405; c=relaxed/simple;
	bh=7Z2vMPIubdgwfD8uHMk1uq4+DQ9JP3kZWp0T++GrsLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kD6IuetfiuIwbtVwTRpMCUAPCM5PqdjRyIuqQxNTmLlc/9tYiFU2MQxutrqqKazm65Up4Wks/FxeUjr3+Kda3BjW/n4UO+TmFub29H+HlKUlxxyepfV8eccSWQ+NNJb8GmOukeTo699AvWZLL8GU4+xsbQOngZGQAX7P+PyMOYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TLaCRnlv; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFCSchSzYooiP3j1lwKdjBoRPb2E6LJe1LxNgex5a4TR02CQ9HvzN0v5cGRfMXLNnvbgp5TYEob+wMx1hQXNK8vihDuXa6lmDaydkl0sT22rObd+apMRgqfzZgXR25asdPYAHIC3DoGQvgATF9Y+9LlSlRr8cPGA9MAnMAHuP2rBmh7aQb2z/BsdSIE34EK5GGUjYD2dx+75tY8qgoJ5uqTMcJ5EZT4Hog20gMQ6jpIgsaJ+0jbwPZIPH25Jk2XpHYc7KEx1WJD13kfyxO7QAFxb9Sl2Oe1asRnb5Ds0vxd1U26f3YuqVPJxdyy/vISbj/ZJWksLb/zSJPMCJ5qzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Z2vMPIubdgwfD8uHMk1uq4+DQ9JP3kZWp0T++GrsLc=;
 b=af09Lopix4WXd7pgkRDsAS2tgJUtFY/G9byxNfSmGgk5iSxIeCvaL5dooCUqFZkESngwSUqfV4Sc9bsi9nvTNHF8Cc2pbOtbkzvsmvnAvSOCcx4lIRWB2thD1I64nhy8FHVVp95KS7c6bNeokVTK1ABSYbiYjryPqVmJe+unxzvrq5RBJCAwfsP+PTQP1Bc9LJYDe9P22BbOJ36xYXerX8r2caHf4hnWTjoH6D+RcBHydOHz7cgHAIS7d7imEshzEHt92myAU2CnZUfRJS6/6m8IunY2HPQj19zJhJpXY7PPFTkq/qJc48jrPgu26tzRuJw2heJnAhfqCgLxzcE5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z2vMPIubdgwfD8uHMk1uq4+DQ9JP3kZWp0T++GrsLc=;
 b=TLaCRnlvXT+RviqK8wI/lMA70pURK/6hyVdNHjbNsnVOoR8bolnYEvDLgU/TOfxmuc8GMiMNRm9b2P09B0SF+ikKDahxb9wy2BE0YxgkJqHkxc4PiFzhAbpxSbjWmmOZpKVSFUbLU0s8lFvA71/YADDTsNbW1Ib9sUbLbjI9TdI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA1PR04MB10205.eurprd04.prod.outlook.com (2603:10a6:102:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:56:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:56:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@linaro.org>, "S.J. Wang"
	<shengjiu.wang@nxp.com>
Subject: RE: [PATCH v2 06/17] clk: imx: pll14xx: use rate_table for audio plls
Thread-Topic: [PATCH v2 06/17] clk: imx: pll14xx: use rate_table for audio
 plls
Thread-Index: AQHaoroQ6PSYf3TEVkiF8uztlG2FhbGVEa4AgAAB2vA=
Date: Mon, 13 May 2024 11:56:39 +0000
Message-ID:
 <DU0PR04MB94177DBC771E19F1BE9563BA88E22@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
 <20240510-imx-clk-v2-6-c998f315d29c@nxp.com>
 <cfceb49f-ffe9-4473-9877-ed92ab0ace1a@prevas.dk>
In-Reply-To: <cfceb49f-ffe9-4473-9877-ed92ab0ace1a@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA1PR04MB10205:EE_
x-ms-office365-filtering-correlation-id: 783b670a-a20b-46f1-c0a4-08dc7343bfc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009|921011;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWF4TVdySjJwRVgxbmRVOTFSK0VjanUraWRhSk5rWGI3TG1RbGJ2S3lrT3k3?=
 =?utf-8?B?a2lZbm85SGw4dUFNMUEyck5ZMVgrOWI0a0ZqRDduajR4d1h4bDI5UFlSeUpk?=
 =?utf-8?B?bWZkc2w5d09mdkQxWFlTd2Y1QytLbk82SUxEOHVTbjB4Y1pzaVJENTVjRC80?=
 =?utf-8?B?R1ZRSnY3Ky9zbkVrR1YyS25nVE1WNGpwcEhKRE53R0MvVllKVzltaGFxNDVF?=
 =?utf-8?B?TksrenFMUEQ5Sk1LOXY4SWE2MU9leDBxVEpQSjdKSE0zMWNvYi9OS01KNUtC?=
 =?utf-8?B?bGtsY3N6a3Y4VUdCelJJZThsZUlHSlRmZkkxQm9qTHczY3o5L25LaHZYcmtt?=
 =?utf-8?B?UlNXQXJRcWd6VHpQT0ZEeHhqcHhPc0JGVzIwdHVvaEE5dXVoK2srMno2Q1FY?=
 =?utf-8?B?YXJZK0RJYWV2T2x5eGJTQVoyTFZlNmY4SERsWmJEOXAxVU5OZDdpd3lZREUy?=
 =?utf-8?B?cEdldklmWWNYbnRGV0FnanpDeWJaVXFDZ0w4ckMrMXg2R1JrSm8xd04wRW1K?=
 =?utf-8?B?R2VpODRrWVRIckRkUmRETFdyZ0NiQkRrNE9jdWpJdXlSWEk4Y3hPLytNNHZF?=
 =?utf-8?B?Umh0ODhVcWdhU0NzdEFpUnl2V2dRM0QzSnhNNFMrUnJRN0hScmRiN2NYNHdr?=
 =?utf-8?B?Wm54VUZqVGVpcFNCSHpXYjc3a2RST3J1cVp4Skc3WU9PdjBBZ2NIckxGS1A0?=
 =?utf-8?B?Yjhwd2Fhb2lzaTE2VmJ1dG9jTVFqcDU1TkY0M3ZhbEpWRnlMZlF0ajdYQms0?=
 =?utf-8?B?OVRhWGdRK3Jid010TjNobE9XU0xVTnFVL003cWs2UHc3cUF2cW9XYU42N0FP?=
 =?utf-8?B?YjRqdjZHaXRsNnlqT1pzcnMveGtBclIyVWtyNXpReUJnZXpETEgrUEsxZm1q?=
 =?utf-8?B?Y0hXeGJiS3RnM3NPMWVUVGdCVDhpek85TGMxK2lEQTVMRGF5VWdLNERycjJz?=
 =?utf-8?B?OU02b1YyamtqaXpQNjBKUnVWY0VaVjB4Nld6UnJZd2pXTkN5WmJZcmFJTk1h?=
 =?utf-8?B?cWZEcVZReHMxMnZLQm9HWVpWa0N3SHVDN3g2QWs1a21hWXREWGw4OXdpaTRm?=
 =?utf-8?B?ampBUlp0UTRkUkJQWkJqa0lmcGVmbjJ0emFRNkh0Rld3YTgxYWhOSzlXcXhk?=
 =?utf-8?B?R2F2U1NhcGV4bWZsVmtGQS9DWXdVbEpKYjJ1VnlRQ0h0MncwRUV0a3Y5WG9h?=
 =?utf-8?B?TTZ2eExKaEM3Q1loM0pYOU1qL0cwdE5XUnhHenhBMHZWeTdsUGF5czY4d2I3?=
 =?utf-8?B?UDdJK2I3R2trcngxRUIyeEhRWVlMeU1MWDNjNFI5enV5alFReUpoYmsxVW8w?=
 =?utf-8?B?OVhEaklYS3dhbCtrNkZCaWk3NU8rbHFGVkZSVUpmRis5ODhYem9kWm5NQmJH?=
 =?utf-8?B?aDcrQURXV0tjdHJhNldoWnpkZnVhSktJaUpJRXRiYjZtamNYMVJrMnVGQUF5?=
 =?utf-8?B?UlVCbWF6aG1SNVh2YXNyZkFuanlUdE5JYXBpRVM5eFJEckE5QzF2NGdTZFA0?=
 =?utf-8?B?aXpVdU8zMEJ3bTJZMnZzZUdCS0UvNHpURk1kQTN0bE1YVEJjSTJlWXVjd1hi?=
 =?utf-8?B?VVJvaStwblhlQmRIOGxYQmdDVmFKeGdUUGxRNXJCUEZkdlNZcEh6KzNwYm5I?=
 =?utf-8?B?QmlSSis2UEFEME1QczJhdWVwNUFuSmdPT2FTVWVSNVFsTXRSN0oxRVZ3VXhv?=
 =?utf-8?B?aWFBN3FzVVZKSnZkallsYW9qZWgyVklKZHBZVFYwVUF5KzNmdEhsRTI0NGtO?=
 =?utf-8?B?RHlaMXpoT3pSOTA2YXlJaDZXVjgwcklZaU81Z1RqM2hJRHdCUWEzSWpPMkJ0?=
 =?utf-8?Q?2JH8LELdwgpKTQkGC7A4OzG9+9fKo5aqC/VMs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDJLVDdiVTJ2S3lseXFuVUdZK0JEeDdDMjZMNDRFQVNMdGRaUDRXY2crTU9U?=
 =?utf-8?B?ZDQ3Y2ZlMFRTekJ2NlpnR2FFV2RuU0hsb1lDMW1aT2VlKzFlSzFOSDQvNzV2?=
 =?utf-8?B?SDg0ck5oYkpHQUZGUS93MlNacUNMZnowYllER2tsZ3I2RTZYWFU0NGJkbGFL?=
 =?utf-8?B?VXlkOWpKMmJVTFpUeWxqa1VMZzJ1ZDJaSFl0MmJLbGcxSk0wTlF1YkpLYjhD?=
 =?utf-8?B?NCszV29XSVJySlNEUzJPeU1kWHJHYnRiZ216clFObENDTkF4Z3ZtOEt2VENl?=
 =?utf-8?B?YXhaQno3TzhYOE5mRG1tbjRnTjEzaDJPQ0QzQkNEM3N0UXVRYjRZM1NUMlpQ?=
 =?utf-8?B?LzhCVFdjUk1lcmtnU2VGOUczOThFQ2ZJU2xYSmM4UFczdnRBZFJEakVqRkcv?=
 =?utf-8?B?QmpjbUdZNjZTVGFiZm5pWUlkTitNeW15bXpweFkwcmxMYmdFY3BjeGVFVURa?=
 =?utf-8?B?WHBHeWNCWktQb3BFVXZMRW90M3BXK1ExWEVMeWRhd2lTREd1NjZlUmZTWUVr?=
 =?utf-8?B?WGlWUkt1SUVQK0lnVnpRK2FhQ0o4Yzk1R0lWalNnd0NOY042U1h3VjlGc3BG?=
 =?utf-8?B?QnkxQ0xueGhUTVB5clJQbXB5NEoxQlhTbTdvQTM3WlRjcTFxMDQ3TGV2UWw5?=
 =?utf-8?B?ZVlDL0pJUFZFN1NHdy92dHRJcHN6amdVeEYvSmVrV3BBK1Z4UXVGM1o1UnM2?=
 =?utf-8?B?OEN3bXhYaUx2cEFOMy9hYTVhcndTNXZCRi9qajR0dEpTZnkzakpYb3BDd3lS?=
 =?utf-8?B?ODZ6ZmhYUTlaTFIyejFpakRBTktxV0NUbTNRRi9OMDQrRm9ISEtJL1IzUHVZ?=
 =?utf-8?B?bXZ4M3JoSmd4azExRVRtOUp1d3AvSnZKanREL0t3NnlsWWVKb0Jpb0FYbU1v?=
 =?utf-8?B?Z2lYeWdaSjFNMHNrUU5XTFJmd0htbXVaMWwvY1NFSXhPWXhTWC9jM0xlMEoz?=
 =?utf-8?B?c2FvYUtnYzRKVjlGbjJTMTFNNStXOEhqcDMzSXZRUDZnS0ozekxuc3R0L3Jt?=
 =?utf-8?B?WkhSdXdOdXhJai82TFZTWnJmOStaTmMzYkxwT1R1MGV6QmJyUEpmUEhVckpa?=
 =?utf-8?B?bFFsYkE3K2FoUU16L2Y5MWcwejZiOWdEY0lBeFlyeWRRc3N4anRXWis0cjl2?=
 =?utf-8?B?YnhtZ1Vxamt6TlBvR3hDNDNGNGhCcXVhYjRiOGlUanZtN0c4c2o1UHBSY2hN?=
 =?utf-8?B?M0phWG9uUExQeE05SkhZSFFjOHp3bCtmcXZhOXNLcDVtTldsVmhrdTZRTFhN?=
 =?utf-8?B?N0JJNFpUb1V4SzdSVHQ2OVltUjZLRVNZVHlQTHF3cklNVytvUWNwN1dxbFl0?=
 =?utf-8?B?SDViYkFqOXVZL2JXRVk4V3NSamtHUXp2STNZeGtlVlBRdnFYalUxZWNrMXNM?=
 =?utf-8?B?NHQxWWhBYzA0MUllRVUyMFpOR0pablV4RzFlVGdxMjJXVERITVRyRE9PTEZ3?=
 =?utf-8?B?ZWFWVWY0WmY4YUEvcVF4aXU5WVJUaHJSQXNsSTBCNFFWaWZZYytBRHJ6WVZ2?=
 =?utf-8?B?bkFiZ01pZU1vMjA4eUNnWC9DTHpPdm5iR3dvbjQrMjJIZlJFMnBMaHVld3l0?=
 =?utf-8?B?cVVPbTNXL2xOUyswN0VSMW85Z0FRRGV1RHNzQzkvV1UyeHhJcm1kZEQxSDkz?=
 =?utf-8?B?N2xMS2VmakpDMGcrMjAydHdlcEF3NmpLbDhUb3crbW10dEsrS2VlcVFRMHE2?=
 =?utf-8?B?Y1RyU0xXNzl0SHdTTVp0bFBxMXc1WUhtVnczYlJUNzNnZHJQTm5ZaDVNVURK?=
 =?utf-8?B?MjhwS2RsUHp2Z0QzZ0F1QkRrcmF6dlQ5NCt1Ui9UdHRkT1JZczhnaXM0WVVB?=
 =?utf-8?B?UnZhOGRzT0FXU0kzS05HM2k3Rk1SSzQ4djlOc2VUaWY3aFNDdksvUTNxT0ZK?=
 =?utf-8?B?Z2EzaGNNa2xyN3Q3NVhabHZacVVHQ2k0L3RXUmxZdjhEZFArSTdyMENQVXV5?=
 =?utf-8?B?c0p6THhKUGVuWDZKYldMbnhlY3ljK3QrUDBWZ0JHb0xESGVlQmlvWGNmaUho?=
 =?utf-8?B?VUZ1Um0yQlhsK2o4N1FKQnpNNm5IUFlSRXBNTmhFZEl6bW1RN0VtN3hrM0Fs?=
 =?utf-8?B?SXJBSDY4MU9uZUlWekRqUjliaXdaZ21ueitYVlhyOEJTUDI0RWQrS0hRS1R6?=
 =?utf-8?Q?/sZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783b670a-a20b-46f1-c0a4-08dc7343bfc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 11:56:39.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgWRp5hQXVT+s9qnic4Mo0TkmAAGJ2bjpuKZFv8G5YEDsfIlMR9EjwHVBeXK6FXq3GLNnAZBn6I2GO+LOUPjRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10205

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA2LzE3XSBjbGs6IGlteDogcGxsMTR4eDogdXNlIHJh
dGVfdGFibGUgZm9yIGF1ZGlvIHBsbHMNCj4gDQo+IE9uIDEwLzA1LzIwMjQgMTEuMTksIFBlbmcg
RmFuIChPU1MpIHdyb3RlOg0KPiA+IEZyb206IFNoZW5naml1IFdhbmcgPHNoZW5naml1LndhbmdA
bnhwLmNvbT4NCj4gPg0KPiA+IFRoZSBnZW5lcmF0ZWQgY2xvY2sgZnJlcXVlbmN5IG1heSBub3Qg
YWNjdXJhdGUsIGZvciBleGFtcGxlIHRoZQ0KPiA+IGV4cGVjdGVkIHJhdGUgaXMgMzYxMjY3MjAw
VSwgYnV0IHJlc3VsdCBpcyAzNjEyNjcxOTlVLg0KPiA+IEFkZCByYXRlX3RhYmxlIGZvciBhdWRp
byBjbG9ja3MgdG8gYXZvaWQgc3VjaCBpc3N1ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNo
ZW5naml1IFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogSmFj
a3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLXBsbDE0
eHguYyB8IDExICsrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1wbGwxNHh4LmMN
Cj4gPiBiL2RyaXZlcnMvY2xrL2lteC9jbGstcGxsMTR4eC5jIGluZGV4IDU1ODEyYmZiOWVjMi4u
NmIyYzg0OWY4YjcxDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1w
bGwxNHh4LmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLXBsbDE0eHguYw0KPiA+IEBA
IC02NCw2ICs2NCwxNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wbGwxNHh4X3JhdGVfdGFi
bGUNCj4gaW14X3BsbDE0NDN4X3RibFtdID0gew0KPiA+ICAJUExMXzE0NDNYX1JBVEUoNjUwMDAw
MDAwVSwgMzI1LCAzLCAyLCAwKSwNCj4gPiAgCVBMTF8xNDQzWF9SQVRFKDU5NDAwMDAwMFUsIDE5
OCwgMiwgMiwgMCksDQo+ID4gIAlQTExfMTQ0M1hfUkFURSg1MTk3NTAwMDBVLCAxNzMsIDIsIDIs
IDE2Mzg0KSwNCj4gPiArCVBMTF8xNDQzWF9SQVRFKDM5MzIxNjAwMFUsIDI2MiwgMiwgMywgOTQz
NyksDQo+ID4gKwlQTExfMTQ0M1hfUkFURSgzNjEyNjcyMDBVLCAzNjEsIDMsIDMsIDE3NTExKSwN
Cj4gDQo+IFNvcnJ5LCB3aGF0PyBUaGlzIHJlaW50cm9kdWNlcyB0aGUgdHdvIGVudHJpZXMgdGhh
dCB3ZXJlIHJlbW92ZWQgaW4NCj4gNzJkMDBlNTYwZDEwLCANCg0KSSBvdmVybG9va2VkIHRoaXMu
DQoNCmNsYWltaW5nIHRoYXQgdGhpcyBwcm9kdWNlcyBhbiBleGFjdCBvdXRwdXQsIHdoZXJlYXMg
dGhhdA0KPiBjb21taXQgdmVyeSBjbGVhcmx5IHN0YXRlcyAoYW5kIGl0J3MgZWFzeSB0byBkbyB0
aGUgbWF0aCBhbmQgdmVyaWZ5KSB0aGF0IHRob3NlDQo+IGVudHJpZXMgYWN0dWFsbHkgcmVzdWx0
ZWQgaW4gb3V0cHV0IHZhbHVlcyBvZiAzOTMyMTU5OTUgYW5kIDM2MTI2NzE5Ni4gU28NCj4gZXZl
biBpZiB0aGUgZHluYW1pYyBjb21wdXRhdGlvbiB3b3VsZCByZXN1bHQgaW4gMzYxMjY3MTk5IChp
dCBkb2Vzbid0LCBpdA0KPiBnaXZlcyBhbiBleGFjdCBvdXRwdXQpLCB0aGF0IHdvdWxkIHN0aWxs
IGJlIGJldHRlciB0aGFuIHdoYXQgdGhlc2UgaGFyZC1jb2RlZA0KPiBlbnRyaWVzIGFjaGlldmUu
DQpvaywgSSB3aWxsIGxldCBTaGVuZ2ppdSB0byBjb21tZW50IG9uIHRoaXMuDQoNClRoYW5rcw0K
UGVuZy4NCg0KPiANCj4gUmFzbXVzDQoNCg==

