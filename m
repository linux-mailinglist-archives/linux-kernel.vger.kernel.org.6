Return-Path: <linux-kernel+bounces-367140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A8099FF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42720B232C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164AB16A94A;
	Wed, 16 Oct 2024 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XkR1Ikoi"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76E14F119;
	Wed, 16 Oct 2024 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729047322; cv=fail; b=tMuY8e4ZPzqEF0OkB7gRkAnLznKb7aUqJU+aIsNu49/3wYlO6ixI/Ot9JiKLOiC+G0hm7zSLAf0irqe8WpA/50Y702x0ArhnqBHcWlnYZdWRmI7y2OkImmWy5ZQYN4E7zEcylkL7JGtXNk/xJYvALYOL75t6fczyO2hWgI0Z78Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729047322; c=relaxed/simple;
	bh=SzS/hhW8maW1JBOZifHLoVCqjDYEwTOa3BdIOD4caT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=muLv7oX0OK2jylynFEXW57Tc6fjsBvDCYy1UhxCRE+IknPuC/6thzo2fKhFimRBXLrisoXwti6ptQmCpFlc1+iXREhe1mXwoUf/aA+Gw1yD+4+BjooP4vS3jqsvpmoDQDrz4atImVF+1i0qlVfS4yvRUZLjs0ywePJukGLwFir4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XkR1Ikoi; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NajLrcKf9bh15K1V5hGIiaY5r97k4HwETboTUqnvmWKOTPdH2V5yRvT5zILld+K9UZxubNnwPpyHnAQSysQEvvBuawiMGWXIkxdLlfSnL4Ttd14Vxy9oK81e47iEutkmFYEOPzeEr3vWh9QxX5Bvh6SW7+KB0JRaFGuh3gAW992s0WRYRKj+uh8yZiPNK/z6c4eXIdVzbAj/0SzDtPUlbROE2IKo/J0/782g0OyuDFbTCmootm2LJCZZEmOniBKZQRPZTsnZ0KjKVnT8Qx6YtHGbj1znYUyilT4TjQQcAHS63YhXQZySnOfzBmpUHxqm4LT2XCoHrVHT53AJDojS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzS/hhW8maW1JBOZifHLoVCqjDYEwTOa3BdIOD4caT4=;
 b=YtZ5tWJrbSR7Lkiv8Q5fYBVnVtKwERaDhvEag2HcB7UO7sAsvHjsv91R9I0QPjGXbjleEgc+Vfatq9YASG3hxWbbxs/K2AZ83amZipDID1Z+qc2nkzMAc8zAOFKMJULn9xJevFxwwFZDtjVec7sUtyQgjjNSMt+i1WvR4AeMl4p5y0wVp56s77a6mYXhLq/e5Jy9d1nZl7Wx+T58VUrhQcn7UH0XlA2sonJstG1gLQ+V2rkVvQ8VS+Ob1x6Y6oRJVh2S/ns5eQhHAI0ICcFa4BF2WECSE6tpAFTI1DBw6TaRIJQDC+I6Z8UWkRPkRL82NWuDhJlTxuvyMfFhEXb/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzS/hhW8maW1JBOZifHLoVCqjDYEwTOa3BdIOD4caT4=;
 b=XkR1Ikoi89jDWW3TOTa09xTwOh+7EE6q4EsVDpuF77le6EHC4IlsJl/lsftWip8s7/p2kI7CP0By1LqGgm14uDZQDeYYvSRl3kuVj80dOTx01OiyAd8AcXwMKRmgme5ianNwTd5X7IlYt5FE0Ojbn1ST2HtZuJ4r/qnsyhznIj12EG+nCPqGVWl5FjLbv6LJlmR418OYw+vpSVj2ohj5H28k4HnUK7vPphfUkf3731nFCQ8WE76JNM+bXSv4XulevE/otzeDf23aBc9VFVQO4ZBOUrJtFUE4fmCgD1czwS0tzST8lVGMfyk8iQKbw2eIUt15vpm06O/A0D1IBFMGvA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 02:55:16 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 02:55:16 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v5 2/2] clk: imx95-blk-ctl: Add one clock gate for HSIO
 block
Thread-Topic: [PATCH v5 2/2] clk: imx95-blk-ctl: Add one clock gate for HSIO
 block
Thread-Index: AQHbHtfpjZZy/SJ/zU6Ngbj5eEQy1rKHiNGAgAEdXxA=
Date: Wed, 16 Oct 2024 02:55:16 +0000
Message-ID:
 <AS8PR04MB8676A91F9594FDB5DE93703D8C462@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1728977644-8207-1-git-send-email-hongxing.zhu@nxp.com>
 <1728977644-8207-3-git-send-email-hongxing.zhu@nxp.com>
 <4963051.31r3eYUQgx@steina-w>
In-Reply-To: <4963051.31r3eYUQgx@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DBBPR04MB7930:EE_
x-ms-office365-filtering-correlation-id: ab75e3f0-0a22-4c4b-9285-08dced8df685
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y09NRTFqVzU4ZGRieFlUbFU1RWZORk9WZThJaUJ3WkJBTi90bkM3cW5UM3pj?=
 =?utf-8?B?bTZYRGhEcWRZUC9VYVNkQS85VDB1Umpua2diUUs0aS8wbTRhV3Y4K09hNnFz?=
 =?utf-8?B?VlJpYnVaMkVHN2JNaUZuZnloaC93cEMvSkU1R2pPRGZ2bEJGSTRmTXFQemFp?=
 =?utf-8?B?VDlmUUlzSDgvVi9JRkxsUFkzR0M0R2s0bVJGRDFVWXNZKzAzKzMrNnE0bWdo?=
 =?utf-8?B?UHkrd2FFRWFBa1NFMS9mQ2RGcTFYdmswSTBQZWdHaFoyRHNPSUNzNmNBSnpP?=
 =?utf-8?B?U2V4TzZUSVJlS1hmM0x1UnJqOHQ4UGJqL25wa0NxbGtPUkZhRW1MV1BIdHh3?=
 =?utf-8?B?VU5ySE0wWnRTVlJidTVIUGVjNjVVdnBobEpNUUk2T0RrMFVIUnIrVWFUUUVJ?=
 =?utf-8?B?WjlrYUZ4Mzd5ZFBSdHY1Ry9kRVRaMGI1Q0Nwckx6aXBmMjNqQUUrbGtrVmtN?=
 =?utf-8?B?Z0pZajBQcFJJS3YwQXN5OE1lb3JQU0x2TTZIdmlCTkV1OVJObHRrUW5ScFZK?=
 =?utf-8?B?Z2VwZjUrSmFOTkQrZEpOb3I5QXlKSm1PTXpvQURLaXd2T3lWbGtZcFNhRXB5?=
 =?utf-8?B?TmUzL2hwaTdGWFNuOCs5SkMzWndhUWpDQ2doSUdXZERGVVJKcGlWYnJXVENO?=
 =?utf-8?B?NURyVStKczZ1KzVMMWpaWXBwMTFpNTEydGgxZ0JmTExIZGt3eHZVcmZVNFov?=
 =?utf-8?B?eDJEVE52YkdBSGRLdDNnRkg4YXI1c2JJWlN3TmtqTHFxR1lpWm5Cd29pOXQ0?=
 =?utf-8?B?b3lQVWNXVHpQajVUdE1RelkzMVpuZXNJRktNdWI2VnBPTklWT0RTV0FzM0Iz?=
 =?utf-8?B?NklBRzE2N1NrcWo4TjNuKzBnVkJES25ZVmU3T3JBYjZUS0pOSGpNMVp1S0du?=
 =?utf-8?B?S1Y3cEM3Si9XNEJONHhCTTh1Qk15MWJVa1IwbDl5all2YWhhcXM1WXcrTVNE?=
 =?utf-8?B?WmtIemlRZG5oc3o5bnpIaW95V0lkLzhTdjU2a0xBa21qS1NlSFpYWkNva3Vi?=
 =?utf-8?B?Y1czOFR6b3NOby82anIvNVI4ZDVSSHh4QjFSaExCS2crNmpZT0llRjhxZUo0?=
 =?utf-8?B?eGkrdUFUM09EUkd1dlA1eEVldFVtNER3NENLK0ZVSHVTMDFVdHc0Uy9uTmZ4?=
 =?utf-8?B?TXFhVmtMQWJrSW5qc2pmanloVElUdmZSd3RJVC83MThNTEY1aGNNUjMvdnp5?=
 =?utf-8?B?eUhlaGxNTDRDVlVFSCtlUVJHM1BDSXJOL2thQktEWDVDa1BHblpEcHJjUWd2?=
 =?utf-8?B?clM1OC8zeXgranloUmRDU0lOZ2w2MUhBdzRUa1hnSldKY2IzVm5FZFYzMTJn?=
 =?utf-8?B?b1pKdmw4Q1o2TFUvdDRwb2lBZytyZ21kOVBHa0dMZlJ4QzZERW5HQTBlMGRm?=
 =?utf-8?B?bzlJODFWdXhXdmE0WkE5UTlzbFVQdjZyNEIrN3htWDVjSE5ucFJBZVFQYWlq?=
 =?utf-8?B?T2hLVDZuMmxjYzlHUHE3N2tWL1NRWFNiRWtQdkZhYjB5YmdUYlRmWlpjNHRU?=
 =?utf-8?B?UFYyRm1BSEFyaHVHWi9OVDg1OFRwZndKcGE4QW5ERDhsWmMwOXZLMVlZaG9m?=
 =?utf-8?B?RDFPWkIvQkdCUGY3dTJ1ZHh4bWppVi9UMFNUR0FZUGkvK3V6SllrZTdMcVYy?=
 =?utf-8?B?U0hUMlRHWXhHbldXSXM4VG5JNHdWUTlFOEwveHg5bGYrSXhRTGxnd280OW5X?=
 =?utf-8?B?VDVSNTl5OUs3VnBuU1QwRWwvUlJjbzBHY3FYeVpZSWpwNTZrWUgzVVRpcUwx?=
 =?utf-8?Q?vjG86I5YToiDswfRQo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TU1QOXhhZjJ4aHRMeDEzZW9tc2Rvcis3cnB2OFBmcW51b0JKdUVhS012NFJt?=
 =?utf-8?B?NFltZklzR0NpSnNzREhkUmhsZXlOZ3FRcjVmN3BVamR5S0x5MTJicjlnM0ZS?=
 =?utf-8?B?NEdJOEgzMW1MRnc4dGNNQ2FOV2dXVFZZM0JJU0kwdVhDZmp5eUhXRWU1RkRw?=
 =?utf-8?B?OVErUUxPREcvVWRDc1Qza3ZyQVhjTkI3VHhBVUt6M0FvNTZHTklZOUYxK084?=
 =?utf-8?B?VmdQbzlNVUdqNjVWMGgrK0FHUUlRU1BQTjVPZjZrZm4yNlo4VjArR3hybXho?=
 =?utf-8?B?Uk56NUxwMUJ3UU1ONTZqOXhLUFBDQi8yd0N2YkdIMmpMMkJCUlpWOHVla1Qr?=
 =?utf-8?B?dkx1SGFXeGM4U2dVbEtiOGFzUjJuRVlqbmdNeEprQUZiZ3FOL0JKd3FIRXkw?=
 =?utf-8?B?UXFDS2VOUkZ3Zlh6VU9GSnNpNk16SXFCZGpjZ0FNaDNOMytzL3NKL0NuSFlj?=
 =?utf-8?B?N0wxc0J6am13V1BCcWtKcGRxMHJyNkhSbTNlSW1BYmlhMDEya1ZPSE9zczVZ?=
 =?utf-8?B?bHhuUmJZTU9SWDJHb2M0U3g3anRHYmpaRjFWTkk1NzNIdWpyN0xIVjdDRUJB?=
 =?utf-8?B?a3NmdnhhRyt5Y3V6VjVyMmp4N0lnQjVhZXhWNUtRSlJZem1sTEY0SkNuTE9n?=
 =?utf-8?B?KzA4ajdLb2tVTC9qVUVLL0JCSXlOREYvTHhMZTdPN3B1bHZ5Sm53QUhjN3dD?=
 =?utf-8?B?U01jWk0zUFZ3Yk9xdFc5RDVtUlVLWVkzMHV1R1d2VTVwb0kxTjZnQ1FpbXFx?=
 =?utf-8?B?eXFHNnlaY1ovaWxpeTlMNHZkQXlEWWZ3Yk84YVYxUVRoTFRlbW5nQTZMSG5r?=
 =?utf-8?B?bW5iL2N6VUk5Z1MvSmJyeEFycHRqclEvMnlVY3hWRVdwQjB2cC8wbjg1TzlX?=
 =?utf-8?B?Y2M2Q2p6TC9ZNUVGdVhWamFoc21CRnRTZ2cyc1A5UTFFQ0V5bEN4SE9YcGhr?=
 =?utf-8?B?b3lIclF4NHpQZkJjQmw5bnJMdGdOUHhOc0VxU2wydXNJeVVVTVVOZGxYU0hw?=
 =?utf-8?B?TGRON3B3RFZuZkR0OFhYMDRlazBtYWR6U3RUOHF5dDRYNHpVcGV1MWJRdVlr?=
 =?utf-8?B?OTVxcUk5cW4ycVhKa2Z1RWJpYUNlVVJlMVNLekM5ZGNUeUhpM2tYZHByRlRn?=
 =?utf-8?B?Mk1iaGtmdVZweXJSdGpzWDNMZ0JyRFM3dmxUY3UrQ01mcUd3QWZSbVRXUEVk?=
 =?utf-8?B?MnRlWjBBQ2U0SkREc3dVdXNHemtCY3ZKVnRBSFBvdEs4SThPQjlQL3llV1VV?=
 =?utf-8?B?WE5aaUhnTGQ2SDBObkk1bGNaemZWWWwyZDNXQVpYNWxQOGlRUGNYVWFtVndw?=
 =?utf-8?B?RFpyNk9DRCtGbHNOZDRKY3VLZmp0c1l3akY5eGRyM1AyYkRLWWR0bHVvWVJH?=
 =?utf-8?B?VHJ3K0RGOXpremc2WS9uWDh6a2F5SFNKSnNRRTJWOUJrN1hoVzZhMkFnNk9o?=
 =?utf-8?B?QmFFWGUyRVlEQ2ovWE8wOEZGSGNDMDF6eEtaOEVnY2NZc1FVaVpmMWxUak5J?=
 =?utf-8?B?VG80cERQWFhwV044eFZEbGwvaVRCUmxqM1lKMEVUTmZ3ZklTSjVlc1hUUlJa?=
 =?utf-8?B?c2dub05peCswNEh4Y0RyVGFqWWJRMmZ6aXA4VUNROGMwN25iY3FGblI5aDNt?=
 =?utf-8?B?S2U0YVVwV0VSV1lQdGRLTU8zcUkreTAwTTVmWE9pMFhNcmh6cmV1REVIM2R5?=
 =?utf-8?B?QmtCdEhDa0t3cTRXSHNTWlArdHQzSktRamdEMHVjVEswYUhVMVZtMG9Oc292?=
 =?utf-8?B?cFR5czI4WktyYUo3NTNDbnpHZnc5ejFqRWhRTkF0dVFpUVk1d0tTVVB1RWNX?=
 =?utf-8?B?djU0YlhzWDRUR0E2alcrRkJSMVNmMHpXa3NWMXBDb0U1T09uS2NmU3lpbm9s?=
 =?utf-8?B?Vlh1N1BmcmovSElPYVQxbkxzbEhadFFGeVp5SXRKaVUxdnNRYmlGUVA4cFNL?=
 =?utf-8?B?b2NPT0RhK0p0Y1p1YlVQWlgyc3hqbkgrTmhiTFRjNTZlQTZDbVhvWE9CSWd3?=
 =?utf-8?B?cmxZSXo1TkQ2ZCsvZWNPK25MOG5KRS9NazhWVzYzaS9tdTljU0Y1NU5uSTB0?=
 =?utf-8?B?SEk3eE45bG5GYXUrVUlDL0tFejRLRm1SYXRvdkVRYk9INFNOZHo3Qklqclor?=
 =?utf-8?Q?WnkBb3YYn3wBtb2ByR8HXG20h?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab75e3f0-0a22-4c4b-9285-08dced8df685
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 02:55:16.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmeOYQbh9qPq2lzukWQHdp66cz7z6Yld7RCcZV2TnSpFpQ4jsfwvocNRxAedA2ErHiNRoJjNsxIFf8Tunh1LYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930

SGkgQWxleGFuZGVyOg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFs
ZXhhbmRlciBTdGVpbiA8YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbT4NCj4gU2VudDog
MjAyNOW5tDEw5pyIMTXml6UgMTc6MTkNCj4gVG86IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBr
ZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBhYmVsdmVzYUBrZXJuZWwub3JnOyBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBz
Ym95ZEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IEhvbmd4aW5nIFpodQ0KPiA8aG9uZ3hpbmcuemh1
QG54cC5jb20+DQo+IENjOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtY2xrQHZnZXIu
a2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsga2VybmVsQHBlbmd1dHJvbml4LmRlDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi8yXSBjbGs6IGlteDk1LWJsay1jdGw6IEFkZCBvbmUg
Y2xvY2sgZ2F0ZSBmb3IgSFNJTyBibG9jaw0KPg0KPiBIaSBSaWNoYXJkLA0KPg0KPiBBbSBEaWVu
c3RhZywgMTUuIE9rdG9iZXIgMjAyNCwgMDk6MzQ6MDQgQ0VTVCBzY2hyaWViIFJpY2hhcmQgWmh1
Og0KPiA+IENSRUZfRU4gKEJpdDYpIG9mIExGQVNUX0lPX1JFRyBjb250cm9sIGkuTVg5NSBQQ0ll
IFJFRiBjbG9jayBvdXQNCj4gPiBlbmFibGUvZGlzYWJsZS4NCj4gPg0KPiA+IEFkZCBjb21wYXRp
YmxlIHN0cmluZyAibnhwLGlteDk1LWhzaW8tYmxrLWN0bCIgdG8gc3VwcG9ydCBQQ0llIFJFRg0K
PiA+IGNsb2NrIG91dCBnYXRlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUg
PGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsu
TGlAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xrL2lteC9jbGstaW14OTUtYmxrLWN0bC5jIHwgMjAg
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDk1LWJsay1j
dGwuYw0KPiA+IGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5NS1ibGstY3RsLmMNCj4gPiBpbmRl
eCAxOWE2MmRhNzRiZTQuLjI1OTc0OTQ3YWQwYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Ns
ay9pbXgvY2xrLWlteDk1LWJsay1jdGwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14OTUtYmxrLWN0bC5jDQo+ID4gQEAgLTI3Nyw2ICsyNzcsMjUgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBpbXg5NV9ibGtfY3RsX2Rldl9kYXRhDQo+IG5ldGNtaXhfZGV2X2RhdGEgPSB7DQo+ID4g
ICAgIC5jbGtfcmVnX29mZnNldCA9IDAsDQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBpbXg5NV9ibGtfY3RsX2Nsa19kZXZfZGF0YSBoc2lvX2Jsa19jdGxfY2xrX2Rldl9k
YXRhW10gPQ0KPiB7DQo+ID4gKyAgIFswXSA9IHsNCj4gPiArICAgICAgICAgICAubmFtZSA9ICJo
c2lvX2Jsa19jdGxfY2xrIiwNCj4gPiArICAgICAgICAgICAucGFyZW50X25hbWVzID0gKGNvbnN0
IGNoYXIgKltdKXsgImhzaW9fcGxsIiwgfSwNCj4gPiArICAgICAgICAgICAubnVtX3BhcmVudHMg
PSAxLA0KPiA+ICsgICAgICAgICAgIC5yZWcgPSAwLA0KPg0KPiBBY2NvcmRpbmcgdG8gUk0gdGhl
IHJlZ2lzdGVyIExGQVNUX0lPX1JFRyBoYXMgb2Zmc2V0IDB4YzAuIEhvdyBkb2VzIHRoZSBEVA0K
PiBub2RlIGxvb2sgbGlrZT8NCj4gSWYgdGhpcyBpcyB0aGUgSFNJTyBibG9jayBjb250cm9sIEkg
d291bGQgaGF2ZSBleHBlY3RlZCB0aGlzIHRvIGNvbnRyb2wgdGhlIHdob2xlDQo+IGJsb2NrLg0K
Pg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KaS5NWDk1IEhTSU9fQkxLX0NUTCBpcyBhIG1p
eCBvZiBraW5kcyBvZiBzZXR0aW5nIHJlZ2lzdGVycyBvZiBIU0lPIG1vZHVsZXMuDQpGb3IgZXhh
bXBsZSwgV2FrZXVwIGNvbnRyb2wgb2YgVVNCLCBBWEkgbWFzdGVyIFFvUyBvZiBVU0IgYW5kIFBD
SWUsIGFuZCBzbyBvbi4NCk9ubHkgTEZBU1RfSU9fUkVHKG9mZnNldCAweGMwKSByZWdpc3RlciBp
cyB1c2VkIGFzIGNsb2NrIG91dCBjb250cm9sLg0KU28sIG9ubHkgdGhpcyByZWdpc3RlciBpcyBj
b250YWluZWQgaW4gdGhlIGNvbW1pdC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEFsZXhhbmRlcg0KPg0KPiA+ICsgICAgICAgICAgIC5iaXRfaWR4ID0g
NiwNCj4gPiArICAgICAgICAgICAuYml0X3dpZHRoID0gMSwNCj4gPiArICAgICAgICAgICAudHlw
ZSA9IENMS19HQVRFLA0KPiA+ICsgICAgICAgICAgIC5mbGFncyA9IENMS19TRVRfUkFURV9QQVJF
TlQsDQo+ID4gKyAgIH0NCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
aW14OTVfYmxrX2N0bF9kZXZfZGF0YSBoc2lvX2Jsa19jdGxfZGV2X2RhdGEgPSB7DQo+ID4gKyAg
IC5udW1fY2xrcyA9IDEsDQo+ID4gKyAgIC5jbGtfZGV2X2RhdGEgPSBoc2lvX2Jsa19jdGxfY2xr
X2Rldl9kYXRhLA0KPiA+ICsgICAuY2xrX3JlZ19vZmZzZXQgPSAwLA0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiAgc3RhdGljIGludCBpbXg5NV9iY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KSAgew0KPiA+ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+IEBA
IC00NDcsNiArNDY2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgaW14OTVf
YmNfb2ZfbWF0Y2hbXQ0KPiA9IHsNCj4gPiAgICAgeyAuY29tcGF0aWJsZSA9ICJueHAsaW14OTUt
ZGlzcGxheS1tYXN0ZXItY3NyIiwgfSwNCj4gPiAgICAgeyAuY29tcGF0aWJsZSA9ICJueHAsaW14
OTUtbHZkcy1jc3IiLCAuZGF0YSA9ICZsdmRzX2Nzcl9kZXZfZGF0YSB9LA0KPiA+ICAgICB7IC5j
b21wYXRpYmxlID0gIm54cCxpbXg5NS1kaXNwbGF5LWNzciIsIC5kYXRhID0NCj4gPiAmZGlzcG1p
eF9jc3JfZGV2X2RhdGEgfSwNCj4gPiArICAgeyAuY29tcGF0aWJsZSA9ICJueHAsaW14OTUtaHNp
by1ibGstY3RsIiwgLmRhdGEgPQ0KPiA+ICsmaHNpb19ibGtfY3RsX2Rldl9kYXRhIH0sDQo+ID4g
ICAgIHsgLmNvbXBhdGlibGUgPSAibnhwLGlteDk1LXZwdS1jc3IiLCAuZGF0YSA9ICZ2cHVibGtf
ZGV2X2RhdGEgfSwNCj4gPiAgICAgeyAuY29tcGF0aWJsZSA9ICJueHAsaW14OTUtbmV0Y21peC1i
bGstY3RybCIsIC5kYXRhID0gJm5ldGNtaXhfZGV2X2RhdGF9LA0KPiA+ICAgICB7IC8qIFNlbnRp
bmVsICovIH0sDQo+ID4NCj4NCj4NCj4gLS0NCj4gVFEtU3lzdGVtcyBHbWJIIHwgTcO8aGxzdHJh
w59lIDIsIEd1dCBEZWxsaW5nIHwgODIyMjkgU2VlZmVsZCwgR2VybWFueQ0KPiBBbXRzZ2VyaWNo
dCBNw7xuY2hlbiwgSFJCIDEwNTAxOA0KPiBHZXNjaMOkZnRzZsO8aHJlcjogRGV0bGVmIFNjaG5l
aWRlciwgUsO8ZGlnZXIgU3RhaGwsIFN0ZWZhbiBTY2huZWlkZXINCj4gaHR0cDovL3d3dy50cS1n
Lw0KPiByb3VwLmNvbSUyRiZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUlNDBueHAuY29tJTdD
ZDZlZWJjMTA1OTYNCj4gNDQwYmViOWEwMDhkY2VjZmE2YTI1JTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwJTdDMA0KPiAlN0M2Mzg2NDU4MDc0OTAzMjA4NTUlN0NVbmtub3du
JTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBdw0KPiBNREFpTENKUUlqb2lWMmx1TXpJaUxD
SkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzAlN0MlN0MlN0Mmcw0KPiBkYXRhPWR3Wjhq
OXlMSXIwaDFhTzBxWllFOXhqTXJRVlhzcjFpYm9hNHdETHdtc3MlM0QmcmVzZXJ2ZWQ9MA0KPg0K
DQo=

