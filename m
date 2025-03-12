Return-Path: <linux-kernel+bounces-557870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C67EA5DEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36657ACEAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F924E00B;
	Wed, 12 Mar 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="v2z0/uqi"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A77124C668;
	Wed, 12 Mar 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789521; cv=fail; b=UWr/uuCtf99lsgnoJdJe8d8ZLnJOucLdTt6A32Drmo+vRLu7/eC4e0Aze74lnK7iAmklvR4jPBHPrdqeE3s6PQPTs4qG+MEVroB5NY6nMzQLIbUczVVxgi+/fJfWoGfhGSTkXCqqijuBXsLEO6e6y4lqOFIYSwqRsgiulIlzZOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789521; c=relaxed/simple;
	bh=Avg2uBet6we0NXyFa/kolgZrPPS63Yhw4v3grqsbJYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JU5lzA326CYJq4tfTSdQMOr8SELzc+PcLLaiW5IQg6BdbLb9anvNMEsGOg5s1BBO/66XXAJnOxPVhmjYpaxEDIPE6YRS6F+qDxp03xrLprp4CkQVN0gDFtUch6355iAehgl5n6tkf4DZKTK/NDVVbXVgkrsCCimf+v1rbv0X80s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=v2z0/uqi; arc=fail smtp.client-ip=52.101.46.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvjFzb7H51QofHyYj75ofoxId2cOl53kPDGRiD/j8y5xNa6ZcSxnWMZqxAdpJ0Kb7UKmqwrGyD0Nrtd2C/xPsZsVSiKcembx0LJ5tklgmFj99jkiY1l7xlDRAlw0H5q1JbDky/w9vXAyVzF8ZTBJhGZ0xkomHtx04MS2pBLgv4g5cNN4Sc/XhTF9fAW+3nryHdbQzb8TsNb0f1FG0EcsXAWXxj0adlpVvhDk8Yp0AO1LWfX0JN/Uc+smHBC10cJiOSZyVjay+amIZPXg4K0uqg/Qiaxjz/hiDHhLk4TRx/aJBTxmdQLCcoTNjshrur7hZFwOUcCWfngXvpH8UjJ9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avg2uBet6we0NXyFa/kolgZrPPS63Yhw4v3grqsbJYk=;
 b=M7WV1d8T3+AJeASprPkjafUlhbXzJPZjlkwLZ8u52eMlhmpwO/U/SxZiMqrFAB6wytBp9xtfkg2Slv+P3vN1Q6YweFjqigjGJKSGi4nhNDb55fRqwSuvqn+nKvUwcqO2txSWYQBbFP4aPBZoBfHQTAGxCZL7wkdOw1g23tJY5krVxNNKhmf3HGlSCUaph4hpzHRkGkXybdZcoFdcnF3z2BPxfieLePRM4o9dSbgf9/4K4n209YZ2+6FxP5Ulj1fFEOnGCLhzGZpAVL4VvWKdMBlcbbNjfQ234R3vXgZZEg4mFziLYGLK4/1W3LnRszoANc9fzuvrGpjs1QhSfd7wyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=einfochips.com; dmarc=pass action=none
 header.from=einfochips.com; dkim=pass header.d=einfochips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfochips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avg2uBet6we0NXyFa/kolgZrPPS63Yhw4v3grqsbJYk=;
 b=v2z0/uqiSWnjFrhZ8M3GH/3HQc8EG0IJSf/xI8OIXGoKlAUokwiYd0/z4YZl3UPQ/uTM7U+0hUL2uL5FAPqtUPGALskR8s8jhQsEUvQri97L0Qt95ehWpRrw90rr/7rScd6KmgVc/3puX13hzgV/wsk6DVZcjbDEZV6T4cLb5Ts=
Received: from SA3PR04MB8931.namprd04.prod.outlook.com (2603:10b6:806:381::22)
 by SA6PR04MB9300.namprd04.prod.outlook.com (2603:10b6:806:41b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:25:18 +0000
Received: from SA3PR04MB8931.namprd04.prod.outlook.com
 ([fe80::f323:b482:8b18:af1d]) by SA3PR04MB8931.namprd04.prod.outlook.com
 ([fe80::f323:b482:8b18:af1d%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:25:18 +0000
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland
	<samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Min Lin
	<linmin@eswincomputing.com>, Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Yu Chien Peter Lin
	<peterlin@andestech.com>, Charlie Jenkins <charlie@rivosinc.com>, Kanak
 Shilledar <kanakshilledar@gmail.com>, Darshan Prajapati
	<darshan.prajapati@einfochips.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia
	<a-bhatia1@ti.com>, "rafal@milecki.pl" <rafal@milecki.pl>, Anup Patel
	<anup@brainfault.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [External] Re: [PATCH 04/10] dt-bindings: riscv: Add SiFive
 HiFive Premier P550 board
Thread-Topic: [External] Re: [PATCH 04/10] dt-bindings: riscv: Add SiFive
 HiFive Premier P550 board
Thread-Index: AQHbklgRgQTFZBJrh02jn1nr33adDLNvd3sAgAAW/AA=
Date: Wed, 12 Mar 2025 14:25:17 +0000
Message-ID:
 <SA3PR04MB893109C2F7D6DB3B0499B0AC83D02@SA3PR04MB8931.namprd04.prod.outlook.com>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-5-pinkesh.vaghela@einfochips.com>
 <f6601929-3d1e-49ae-8120-c3005f99e57b@kernel.org>
In-Reply-To: <f6601929-3d1e-49ae-8120-c3005f99e57b@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ActionId=e19e35d8-71fc-4d79-80da-75a96a024300;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ContentBits=0;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Enabled=true;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Method=Standard;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Name=879e395e-e3b5-421f-8616-70a10f9451af;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SetDate=2025-03-12T14:18:07Z;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SiteId=0beb0c35-9cbb-4feb-99e5-589e415c7944;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=einfochips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR04MB8931:EE_|SA6PR04MB9300:EE_
x-ms-office365-filtering-correlation-id: 6855a7b4-f98c-4071-6344-08dd6171b6a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFBxbFF5eVZla1h1RGJxZkZSeWN4SjZTUit1aWVYTXJnTUxBbFhQeGRLWis2?=
 =?utf-8?B?NkNNZEVHekdoR2h4clNqT3AwekRhMmZ4ZEFsc1VNaHZvZTMySStvc3dOOHVY?=
 =?utf-8?B?WnRaSXhBREU1SWFkWW9kNWU0QVRGWU00SnRTTWRsS2ZSaFlQbllUQzdtMTJU?=
 =?utf-8?B?YUxWbExhV3d6V0V1TG9veFR1OXRNRklabHI2TmZlYmNGMlYvWlNPNTZ4NTFD?=
 =?utf-8?B?YkVKOTIxRVRHRnJ0R09qSzdJS09qZ2o5VTZ6MG9qYi9QczhoazdRbFFXMzZh?=
 =?utf-8?B?TU9HM1QycEV6QmUvN3lRK0lZZUdDbi84cVRWR0dVU2JSNU9mVmhHZGFEUnVm?=
 =?utf-8?B?M1FteEN3cDZmcFVTTHYvLzN0RXZmRWFHa3Z2Q3gwTmF0b1llYkVWU3UyQ1Vh?=
 =?utf-8?B?TGgvdHFERE5aQ0NzTUNnY3NQdS83OEFudEVnNkd6K1NzZXhNWS9PV2NOa0Z1?=
 =?utf-8?B?OFVPYmJPV05zdFl3OEY1MCtzcmdQY0tCbWtVTnBKUEVpZTVpYS8rVnJqYWUx?=
 =?utf-8?B?MWx1bHc4dm9wYlBBU2xyQVpqcWFyU2RTQmFTb2hEMDAyZTEvTW9BSHNveWJY?=
 =?utf-8?B?cDBybXd0TkhXbEYrTkRLcFN1bi91bGJCcjBxMGVrK2dvMnNvclA2TDhNckx2?=
 =?utf-8?B?amxGQ1J3KzZOeEh4L29IVHdpaTM0bkN5ZUdKYThrcWhHK0JGdEVlcmVGcU5y?=
 =?utf-8?B?ZjVkN2tnYTYva3RxcnBvQVRTL29YajlUYkNMZjU5bFdOQVlhWTJGZGRQb0c5?=
 =?utf-8?B?eUdxOG5HaUVwang4L1kxRU1aQ0dVSkFPUGJjUG5HaUs5Y1ZpZzdQVDhScTFm?=
 =?utf-8?B?clVldk43VW9TcDBKbGMwTnRZNjQ1WDg0UGxpRkhrUWJ6V2RkbDhiYkdQWWZj?=
 =?utf-8?B?N1Jta1IxZFFPS24wM29aUFo3a1NVRE5GU2NrcUlKY05iRDFaQUhCSGhQOEJN?=
 =?utf-8?B?ak94bEJaL2FPTnQzNkV0YXd2SXo3M0FwQkZWYyt1TVRORy9DQjJldHJNVFhy?=
 =?utf-8?B?RmhaUllJdXE3YXJkcEFCbW1JUTRad2o0ZnFrdlNlbU1tdXdnWm1KdXhsckw5?=
 =?utf-8?B?SmRsK09wQlZjSDZVeDh0N3Y1TnhpelFFM3ZVTElvZ01GLzRaOWlwekZGZlpP?=
 =?utf-8?B?UDVDampFaEhNdk9mek9aZlNXMEF4Y2FFNndpTGlVRkdRT2t5VFZjTnMzMVcx?=
 =?utf-8?B?YVh5TkdUZlhkTkJFYUVRWUNCYjBBbjl0WXM0a2RjNnJpY1dvaFVvZXlTQU9Z?=
 =?utf-8?B?NGRKNFRtSkRmUWs0amF5bVR1VXFhM1F2cm80L01ZUS9Bd3gxTDNpcExVaEJN?=
 =?utf-8?B?cWtxQkJuNzdra2lpRll2T2NSejhuK0J5VGs4YitlVUhZaXhnVGlNYnlCcnFv?=
 =?utf-8?B?RnV4QXdRMnl3NEh1N2VYQXZhbXpUZGgvY05DY3h0YjRqUHNVU1M4Q3IzMmt3?=
 =?utf-8?B?bCtrdG1ZSzZvQk1heDFlNXhEQ1NrTWlJUVcybHA4YUdyd2duVUdtWTlrQ0pU?=
 =?utf-8?B?YXRJck5ncnd5K2xFd1lMZFN1UUFkTDMrMlV0V1RzVFlMSElQUmF3Mzl0cFB1?=
 =?utf-8?B?cHVNOE5meTN1dVlGblhBY3c4ekhtWGZpS2RJYkZ0SFlVaGNxSW94RWJkUU1N?=
 =?utf-8?B?R0tHSitjN1JkU1l0Nk44enFSUUNEbHFzYk1UMkZGNDRzemcwSnc1elRuaWdi?=
 =?utf-8?B?RG1lYjMxTEp3azBnYzV6bWFLYUU4b2xsczFaYUpEaTNLdDhMNnAvaFNVNmho?=
 =?utf-8?B?c29MUnhRTlFDS1orQW15ZU54cGVYR0s5YlBrdVVCOUplVzNCYXVQaWpORm0r?=
 =?utf-8?B?WU5WWloxbGw3SDdMVzhBOTJCQ3JRbGl2YU9mZjZuUnpBRWJkdGROTldseGdX?=
 =?utf-8?B?d2crQ1Q4cmhyVzRrQk13cHJJRFM2cXllVFR4clMzckdLZGtyWVdORVFPUWJn?=
 =?utf-8?Q?Vb6h/KaxNIqCPZ9h/TaMoDYzPP6A2rT9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR04MB8931.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEoyNTI1OXNWUkQyQzRmQll4WWo5U3ZRSHZCREpHR0pzWkM4SGJlVXlmS0FB?=
 =?utf-8?B?YndidW9qZmtROWtkZFN0NFZ6UTlMd2R4Zm55WWk0RGx4NFdpWE1oQWRzcmQw?=
 =?utf-8?B?YkNOdlZoK1JPemdyUlBBbmZnaHJTdFRKdFdPcVdTQjlJdi9RNWpzNy9rUjlv?=
 =?utf-8?B?dmJDQjFadjUrWEIwWXdjSDlSa1hDdkhmLzJSc0NDOTdhdVliZzVlcmlOYlpZ?=
 =?utf-8?B?LzBVeFdlMzlNaldhMDNTSnVjenM1d0lmRGFrQkhOQlFod3Z3c09IbUtaSkNr?=
 =?utf-8?B?Wk8vcGhPdUxyWlFnSENzbENiVGhKN0RoeTV3YUdIekRHTnN3bk1OeVM5ZUhr?=
 =?utf-8?B?SVhYL1diUDVtMmFxZmxBSitzVWVTZW9GdXVXQXZ2OFBIenh6aUhLMThoZW9N?=
 =?utf-8?B?NFRqZjFwRTlqano4SzhtTllMdUFYN2tlSzlkMmQ1Tlp2RW1OTGRkMWMxN3h4?=
 =?utf-8?B?MGJTc3l5cVU4RzgwK2kzTWlzekh4R1B1disrSXpBWGt5VHY3SnNwaDZKWEhF?=
 =?utf-8?B?dW0xNEtRclBlVnFGT0I1Y3FITHROdmlnclRtV1BIeHluUnNvNEw5TE0yNEZI?=
 =?utf-8?B?ZDhJcjFMdmFxZ3o0Vy90YUlpMGlHaG5VQzdVVjcxclRyTndnUWlEM0dvazJD?=
 =?utf-8?B?bGk3ZURmVXdCOEkwV0tid3dyNVJOWTJVUzdSK0x3SkhWWU01Zmk5OURSbE95?=
 =?utf-8?B?UElITFE2TUZNNDhWbFJCbFJsTUkrR2xqOWgvamNkaENCei9sTW1Qb01pdFp6?=
 =?utf-8?B?Wno2Wit3MXFiODlsTzVTN0dzRXE5M21nbTF3SkUwRHdBSU9tSy8zeUFVV2xO?=
 =?utf-8?B?dXZjMTNNV0w2UDVTbDdzRlpoODM5RS8zc0w0SFNXZFhaMitGcFN3dmNPZVhJ?=
 =?utf-8?B?WFJ6TTFZMHp2NjZPYVAzVEZWNW1kdzBxVHdHVXRyd2ZUZGdoUTZHMFBKNFA5?=
 =?utf-8?B?b2t2WkFSTng1ekxOdllGNUtzeWFRSlhhbjd0RE9MWFRtUWVZTnpWaGE5QWRn?=
 =?utf-8?B?RzVWamJiTForZGtUSUU4ZXIzRVlRSDYvSlJzZ1doaGx6akpJbVdFRlY0TVZh?=
 =?utf-8?B?cUdHTUlMeU5XenBJQUFveVpqRnBzUk5xbWlZY041WmtQejFtdzNUSisvZ01I?=
 =?utf-8?B?UVRDMVl0Y0J4L1FBVmVmeDI4bllEY1NObEJ0aDczRFhpL2FLN08rczFzajIw?=
 =?utf-8?B?aExITW5UN3ZEbVRSS3hzOWRRK3BrdTd2SlVHU2tNUXNEdFdmeGtIV0FtZER3?=
 =?utf-8?B?Vk5GMkdNb1hqR01mT1VtWkFsRm40dWhtWFJvTm10dmhYZkVCSlhZZHQ2OUtK?=
 =?utf-8?B?M3FvVnpUOHVieXFuZWFJOFJ4WUpHLzRsSUJJQlFyNVBIYWFveFBwQlhoNE9V?=
 =?utf-8?B?NktCbldOdjg5OWdQd3dCYjI1ODhWZHJ5Tlh6emVEOE5EYjFrTVN1dlQ0WU85?=
 =?utf-8?B?MndFUVoxYjVHTTlZTWxaMWVaZjRyU2VucUsrQ0FOQWtScDNxWXJyN2xWcFBa?=
 =?utf-8?B?Q3BINy9GMDFUZjRsLzQ5RFh1d0FxNjlIc081cW04TXhzWXF3TFZJRzJLR0pT?=
 =?utf-8?B?aWZLaWZadHdrZlpPNmN2RHdqdWQyRE9xOENWRGwwMEFvMlNMUTJGVXB1dmJC?=
 =?utf-8?B?TkZZaXpiYmUyTUQ3L3BWZ3BTQjlVNnNRVzJGMkN1WU5Cc0NYQnFqdldBdldV?=
 =?utf-8?B?YUhYbE9xRFNvbHZWMTZ4bTRZM1hWTlp6bXcyY1EvRnlvMk9CWGZJRWtKMXBE?=
 =?utf-8?B?WjF5R2FBeEN6UXI3Z1UxZ0twN0xuK1BqRmh3TFh4ZTZtUi9tUzVuR29MNklD?=
 =?utf-8?B?U3lReDFTa2lSUHdGL1lKK0RlK1p4VzYxaCs2QVEwcDRQdUlndVp0SjRkeW4v?=
 =?utf-8?B?K21LYmVsTHRmQy9aSUZCc1F1cUZCdUE1eVRXQ0dGNjFTNTQ0WkkxYWttRVVh?=
 =?utf-8?B?UURISExDQzg0ZXdRVGN3aiswaXlsSk9hOEk5cUdtNEo3RWNKVWpyc1FoeFhY?=
 =?utf-8?B?OXR0TVlJaVZKUEM2eWZxaDk3Nlp5bkpEdXZzcUZBd040amZsdjN1TSswUXV1?=
 =?utf-8?B?QTBSWkttSEZ3eTV3b3FpQ0Vqc2l4OC81K3dwand5OGdUTThTTVk1ZjNsV0dx?=
 =?utf-8?B?TGJaN3Rmb0xtWEFnTzlTVFpPQTFPYnpVQkRoSmhQZWRRZExoMmpnVVM3WkVu?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR04MB8931.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6855a7b4-f98c-4071-6344-08dd6171b6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 14:25:17.9696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0beb0c35-9cbb-4feb-99e5-589e415c7944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XXqHYcE1SHH3XtGC4nzKF9TIYy5/XyoJG1oWXyrlro1TFYOinZf+Da5cjFCrUUT2vScwdu0LRn69kA9ctvkVN8nVnoG9Qz9uY0kUnHPTHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9300

SGkgS3J6eXN6dG9mLA0KDQpPbiBUdWUsIE1hciAxMiwgMjAyNSBhdCAxMjo1NTo1MlBNICswNTMw
LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOiANCj4gT24gMTEvMDMvMjAyNSAwODozNCwgUGlu
a2VzaCBWYWdoZWxhIHdyb3RlOg0KPiA+IEZyb206IFByaXRlc2ggUGF0ZWwgPHByaXRlc2gucGF0
ZWxAZWluZm9jaGlwcy5jb20+DQo+ID4NCj4gPiBBZGQgRFQgYmluZGluZyBkb2N1bWVudGF0aW9u
IGZvciB0aGUgRVNXSU4gRUlDNzcwMCBTb0MgYW5kIEhpRml2ZQ0KPiA+IFByZW1pZXIgUDU1MCBC
b2FyZA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpdGVzaCBQYXRlbCA8cHJpdGVzaC5wYXRl
bEBlaW5mb2NoaXBzLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogU2FtdWVsIEhvbGxhbmQgPHNhbXVl
bC5ob2xsYW5kQHNpZml2ZS5jb20+DQo+IA0KPiANCj4gVGhpcyBSYiB0YWcgYXBwZWFycyBldmVy
eXdoZXJlLCB3aGlsZSB0aGlzIGlzIGEgdjEgYW5kIGl0IHdhcyBub3QgZ2l2ZW4gb24gdGhlDQo+
IGxpc3RzLCBzbyBJIHdhbnQgdG8gYmUgc3VyZSB0aGlzIHdhcyBub3Qgc29tZSBibGFuayB0YWcg
YWRkZWQgdG8gc2VyaWVzIGJlY2F1c2UNCj4gc29tZW9uZSBzYWlkICJ5ZWFoLCBsZ3RtIi4gV2Fz
IGl0IHJlYWxseSByZXZpZXcgYXMgaW4gKnJldmlld2VycyBzdGF0ZW1lbnQgb2YNCj4gb3ZlcnNp
Z2h0Kj8NCg0KVGhlICJSZXZpZXdlZC1ieSIgdGFnIHdhcyBhZGRlZCBiZWNhdXNlIHdlIGhhZCBh
IHRob3JvdWdoIHJldmlldyBvZiBhbGwgdGhlDQpwYXRjaGVzIGZyb20gU2FtdWVsIEhvbGxhbmQg
YmVmb3JlIHBvc3RpbmcuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGlua2VzaCBWYWdoZWxh
IDxwaW5rZXNoLnZhZ2hlbGFAZWluZm9jaGlwcy5jb20+DQo+ID4gLS0tDQo+IC4uDQo+IA0KPiAN
Cj4gPiArDQo+ID4gKy4uLg0KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlO
RVJTIGluZGV4DQo+ID4gMjVjODZmNDczNTNkLi45MDFkMGUwYWRiMjUgMTAwNjQ0DQo+ID4gLS0t
IGEvTUFJTlRBSU5FUlMNCj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+IEBAIC04NTcyLDYgKzg1
NzIsMTIgQEAgTDogICAgIGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAgUzogICBNYWlu
dGFpbmVkDQo+ID4gIEY6ICAgZHJpdmVycy9uZXQvY2FuL3VzYi9lc2RfdXNiLmMNCj4gPg0KPiA+
ICtFU1dJTiBERVZJQ0VUUkVFUw0KPiA+ICtNOiAgIE1pbiBMaW4gPGxpbm1pbkBlc3dpbmNvbXB1
dGluZy5jb20+DQo+ID4gK006ICAgUGlua2VzaCBWYWdoZWxhIDxwaW5rZXNoLnZhZ2hlbGFAZWlu
Zm9jaGlwcy5jb20+DQo+ID4gK006ICAgUHJpdGVzaCBQYXRlbCA8cHJpdGVzaC5wYXRlbEBlaW5m
b2NoaXBzLmNvbT4NCj4gPiArUzogICBNYWludGFpbmVkDQo+IA0KPiBJZiB5b3UgYWRkIHRoaXMg
ZW50cnkgaGVyZSwgdGhlbiBhZGQgdGhlIHBhdGggZm9yIHRoZSBlc3dpbiBiaW5kaW5nLg0KDQpU
aGFua3MgZm9yIHRoZSBmZWVkYmFjay4gSSB3aWxsIGFkZCB0aGlzIGluIHYyLg0KDQpSZWdhcmRz
LA0KUGlua2VzaA0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

