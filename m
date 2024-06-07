Return-Path: <linux-kernel+bounces-205222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10328FF99D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDFD1C213D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ABA11184;
	Fri,  7 Jun 2024 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VbOywmzV"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2062.outbound.protection.outlook.com [40.107.103.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABCDF53;
	Fri,  7 Jun 2024 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724129; cv=fail; b=CkOoEETk807wEPdIlWe/SGdV1F8xmbJujtjXzGhNL1io6S0dC+hNjl1cW46EbE2QfUmD8cWeMKQCxKbfUfpGZPKEX+sXHH/cSnNTwIiI2J5izIoGZEjW2sGeK9Rt/TFByrgvz3JSgiJVk8Pe55rOSfdx1ghnLvUmVLXz1VQyPMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724129; c=relaxed/simple;
	bh=pLY0oT6e68SOhGmaqf6E6uZjz5b+lyoK3atMJXsPO6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jFc1KOnIutHQnms89DuJhGOGSxwE80KBK7FNTmL+tObvO9a+J+Pa6cpqy0wiZjw1BpfDYivnJCo+hRL5kM1grwFU2IfP1F6Lyw3ytxV+ybagdhixLImfSINukwYFf6PqM3bgkiY2LlF042AruP9JbMket9FYKTuWgrvBwQ+3EwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VbOywmzV; arc=fail smtp.client-ip=40.107.103.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHER6psVWNTdYJP9hZtiCxQQy4pwp8Ntn2UThPtP9Qz4BIpKx84ZdLCY1nKNxgUI7c5hNO+5jQBk5TNleb/w8LAbqCZrIrFUR4qF/XYkzspWBSlKSslk7jlzh3wJzH1Y8TYpwQl94LCPTOeMp9uDmvsEuz0vVabrc2Pi8Ef4W6sPURblF3PqjKnOqYqQDcde9GHCIRi4r5YEsJYy3ph+l3tEB6ZyLZapEAdtTq6/d28Dlw08b+WKtoyqCAJC3N3imiHGMXW9yRP1xXJqh6qp9/d5+kHjqINP3pA6Uq3sZeDlvbdLCyxWZdEjaztWU3vDik6SYaqcXQWeW4BMl06SIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLY0oT6e68SOhGmaqf6E6uZjz5b+lyoK3atMJXsPO6I=;
 b=LUPCPrLLkIlXo/T05+CqnBNGodZDVgxXVorRoD4bz9HqN+so/rszKXBi2qxggrxFYoJPRsNJWxGvex+IKszobLvYe9GM61z5ntCkHfkzY5Ae6QmWHU6vfePJktPrRszsrFY36+N6BAWldmWL1ArnYuV1YP84hZUUNHYonQBuJQeZ/XuJwY7jzM4tZpI3uORBgl115nPqb9AOb91KPkEbmVcPe7MS3FewrNhMpqqrFH7tlrC4KIMWqaJ4JCVrWHgKTqq3Lm1k6BJhBoR2O45kKq/H5f8JuMS2439vhbvL5/TPqROCge/OAu5NHfMKoWUopjyuZyYNwtdhuoi+DMHKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLY0oT6e68SOhGmaqf6E6uZjz5b+lyoK3atMJXsPO6I=;
 b=VbOywmzV0trkkic/GAj1XqjAjpasVLl03I5/wKrXviiG7Rfw86PYtsPolyG7MGwvl7HTWFZjs5ILwL4Ryy9egYunAIKW3C7YZXFxNdevCzjF9VEuHpAarhP2F9ebMW4BloqN5DukiReHAY8WLD4sgGwol2Fg+B+UeaMuIVpAWMM=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 01:35:19 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 01:35:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Aisheng Dong <aisheng.dong@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 6/7] arm64: dts: imx8qm-mek: fix gpio number for
 reg_usdhc2_vmmc
Thread-Topic: [PATCH 6/7] arm64: dts: imx8qm-mek: fix gpio number for
 reg_usdhc2_vmmc
Thread-Index: AQHauEIuMd/3WRMFqEG/PJQ2MVK83bG7hU2w
Date: Fri, 7 Jun 2024 01:35:19 +0000
Message-ID:
 <AM6PR04MB5941AB7F1B89DF218DDAFC9E88FB2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
 <20240606-imx8qm-dts-usb-v1-6-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-6-565721b64f25@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|GVXPR04MB10451:EE_
x-ms-office365-filtering-correlation-id: 46c503bf-f543-4af3-75bf-08dc86921787
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?K0VnbU9Ud29acE96djFydExlZzR6czkwUnYydXpFazZSZk54SldkR3NQUzR5?=
 =?utf-8?B?MTNhdVg4RzFHYlh4L1dLUUoxdVNLbnFjamF1RGNFUjlpaG9hZDlhcDVqSGpW?=
 =?utf-8?B?VlhjY2dNYW00Tk5IeEhrQkVWSlU4RG4xN3ZWWVd1WkRta01hR3hDZFhoRk1T?=
 =?utf-8?B?ZlF1b0R2dCtUSnNDZWE3ci9yZlo1dHhGZkxiK3l4cGd5ZERKREpIc0d3aEFW?=
 =?utf-8?B?N2FpZS9SWWI4ajNrZjdGY1lyRGgrTUhRRjJvYmVrTWJHaU9Na0tINHBWTUlT?=
 =?utf-8?B?b1BPSTBPTW0xQzgxRnBZbExJY0F2Y280NmVIdjllRTYycnVLaU0vYVNtYWdW?=
 =?utf-8?B?bEFsaGlxeHZGWU9jODBKNk5JNTUvcnRaWEdVSllwNEJ4ZFdPOHJ4cy9vVFd3?=
 =?utf-8?B?VTIxZy9YL2kyMGhhK1J1Rkc4djZYdnNDNVVhQjROb0dpUDFjRWVvbXdIbnIw?=
 =?utf-8?B?RmRQeEszWTYrVVFZdCtaaVNHVVY2cktDalMxS1NSRGxMci9VRDdMYmt2cWpi?=
 =?utf-8?B?OHZmK1lGWWNsVFNHL2NXRVJleFBCV3lTS1kvSUFTN3QxMUZVNFE1KzN0TW9w?=
 =?utf-8?B?NWJlWE0rS0pGb3Vzb2txM25nNjNibWJuY1hrRm0zQStZdFdGekR2a1FnUjMz?=
 =?utf-8?B?Znp4UUJkK1BRSzNHajd1cklNVjhkbWptd0gyQzlwUmxnb0VrdW8vNzhxb0tZ?=
 =?utf-8?B?VTNCNHBJM2lDNjBEbkRXUVBNMFRpbldST2dQYndoN0xwL2tCWXNTUGgyd1cv?=
 =?utf-8?B?NHhDemhaM3I4M0lZQ1V2Q25sQi9QR21ta2FUbWVINkZvZjliRWNndWxoaVlQ?=
 =?utf-8?B?dno5WVFyQW5mNUx3Wk9vK2RyT1VjZnpaSitCWTh4WG1rMmt0VFkrOFNSblhD?=
 =?utf-8?B?enFiWVhrc3lBM3RZYnIyRkxTVGxROVl4RktyMU01d1ZRbTl6S2xsQXYwOFpS?=
 =?utf-8?B?VTVuak81WWljb3MwVjNsMFFtSnQvZGhqRnRBNGxUdnY3WjBWOWM4S3VsNk9q?=
 =?utf-8?B?SWhhNGdRV1paOHJBR0pkMFVXY1pjUHpyR1RXY1l4OGxzckF3UEVsd21aVEV2?=
 =?utf-8?B?aVFZdXU4Mml2eUpoUGJrVC9KOU12MWlFYWttWGd3MUpEbS9NVmd4NUs4WWxi?=
 =?utf-8?B?TVlhUVBlbWlNWUZoRktiRTVKWEVvWC9jKzJvQkZwRFQzaU9vS2RvMm02QXZK?=
 =?utf-8?B?REEvdDQvWWVYT3gwQmFJWHc1ZVhCQWVJNXNUVG9ZSHk2UHd5cDNOUGNNZmE0?=
 =?utf-8?B?bjRWV3I4SnVNK2thdW9pUlh5RjdydHhqVzhiRmJYcHA1STZKNnlDZitiek0x?=
 =?utf-8?B?Ni9HWWFyM2s5NW16bXBiRkZLY3p2MnQ3SnI0OWhmeGI4cGNzOTVtUFJoL0ht?=
 =?utf-8?B?WjIxVVA1NXdLNEZTcFFCNGVzU1dBZlUxQ2NSM0dBLytNekNxTEhuMis1Zjhr?=
 =?utf-8?B?dC9saXl4ZTdMaEpmKzhsQlIrcW1ndXpmWVQ4TW95djZTVmoycGxycm9WU3Zm?=
 =?utf-8?B?MzFWdkQzMFp5SmF0RGxGeGRRODRXSkRwOFYxNzMxbFhrdDRpbUhWS0xvVkxp?=
 =?utf-8?B?Rm5qTXdzUkNEdW9GeTNad0dGS0plWlhvTzlvQmxxMUFucGtWd08vUVd4OVha?=
 =?utf-8?B?LzN1eFVKclpLaWZ2aml4bk9CV1Znckhwbis0OWMyd2w0NXNWUU9PWk0xRzVs?=
 =?utf-8?B?aHlwczMyelpGd2IzNmdaV3JDYWVpKzRadXBLMkNVNnFWTjVXVGgwci9sNFVD?=
 =?utf-8?B?ZldPRVQ1TE9oeUw3eENsNWtSL3VwYjdkK2QvT3JsaXY3V3BrdXlXNnlCSDU4?=
 =?utf-8?Q?fjs7GtQYm2eabJH3ZpIY1gzcCC3JtifYcSfJo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUNiMlJpN1NRUm1senhJdE5oQjI4ODhVSnlwSlo1a0dwVllNYVcySFZONURL?=
 =?utf-8?B?Y3NnYWJDaDMzNmhCM05vNFFWZUJVUHpNK3hydGFYeThjRjNEWWlIZVJQSENL?=
 =?utf-8?B?WjU1M3RKamREbm12SVB3OFY0WEtYMUhRaWlkaThlRXRaZlhnVUNMTjBzRGht?=
 =?utf-8?B?ZUxXZHV4aGNtbGdsTk0xdThPL1gwR1p5NmhteXhndFEwS1BBZWU3SDQrMEg2?=
 =?utf-8?B?L2ZwODVja1c5Z2xDeGRWWmVvSGJMY2ZsTVBhOWNOZS9WSTlHQmhxQ1NQaFB1?=
 =?utf-8?B?YVBtMk9FdXlSb0IzWVhJejVLbzNtbDBHSHI5dkNOc01WcFhtclV0KzZ3ZDho?=
 =?utf-8?B?K1dKbGdTMkJKMXJtS1FFcnZwSDMzQ0hiM3lHTkJ5SWxRM0tGRS9mYitEU0tH?=
 =?utf-8?B?YVVRZys4MzEzbGxEbnAxdUhLUENNUFUrUURWb1RSZlZJWmRNTzR2ZW0zYkgv?=
 =?utf-8?B?Vk9ZdkhFeU1QSDFjRnl5MlRwdXY2NXFPeEhsTldsWlZ2YU5CdE5NVnZSYzBZ?=
 =?utf-8?B?OW9IZEZ3VjREalF5TEl1OVh5b0pQUk5zeU9PZTVBZU83SkRjN0UwVHE2aUdE?=
 =?utf-8?B?VGxZelFRQ3NuNHhZRC9QRUluM3p2b1QrWEVsRHdlRlZwNUIzdXF0N0hrSHVV?=
 =?utf-8?B?SXNiMW0yRDRFdW5Kc1phR1Y5QSs1OFY3d2h4aUJTbmIyd1Q1ZjgwR3dWMVRC?=
 =?utf-8?B?aThvVDRWazhGVmFBVnd2T01FSG5RTzZseFpSSCsvUTFrWCthN1pldk5ycnFz?=
 =?utf-8?B?OUgwUkM2MmZ2Um1ncVd6NkJ2WnhEbncwaFVtMm5ST2NYSis3VngxNHlUY245?=
 =?utf-8?B?T0N6NTE0ZGJlcnVGR2h6cEx0OUxaUTc0OWFiZnNPWkdOTTdQcnVNRWVMS0pU?=
 =?utf-8?B?K25wVkRkYVJiV0dnMWk4Nms4UXhrTE0wNmhLVEZzTytRaWVhS0g1bzlGMU1H?=
 =?utf-8?B?U0xzWWdhODBEemhGczE2emhPOUluTzBkc29xYXpoYy9wRHo5bVc3c2lieFY0?=
 =?utf-8?B?dEc2RzlhbG1FK3NQSEJxVjh4dnRqYW50NWowUDhiU3cvaFRIc0dNcXc2dHBO?=
 =?utf-8?B?am8rbjV2b1JHa205dDgzelFUOW9uczRPdXZ4eTRNakQ2aFQ0UE9vTFZ0eVpI?=
 =?utf-8?B?aFN4WFE5OVRBcGtlQnRQWlBTMnFtSEEwcmVCT2VwUmpONlZUL1Z4dXVtazJk?=
 =?utf-8?B?OEsvQTVoQVZOSU1odXZKVWEvSHZacWpXUFdvMmZYN2RyUFNUbWxFQWVUWmVJ?=
 =?utf-8?B?REw1MGFvTERrYjQxeExJbkhPUDVuR2pHYXZGSXMwVWgxcHM1ZHF4RmlkRjZO?=
 =?utf-8?B?NmU2WWlCQ2kxd25ERmlHLzR2R0FyTFZPSE8zclRBWTBrcFhjeFdEOE91d3Zp?=
 =?utf-8?B?ejY3K0NIUHR2RHcxcm1nYWk0Z3VDY1dtMllCeUdXbEpqY0c5bElSSnZYMTJG?=
 =?utf-8?B?OU5HN2w0dTIvSjZCL0RVaVZpMmJncHpRMnBHMktMQUhyY1pxL3BVVjRQbm5z?=
 =?utf-8?B?SlVPSGpTYVRJMS94dElMRElEZGcxL2NneVVheitqZGcxd2dlaENGQnNqWi84?=
 =?utf-8?B?M2VsU0RkeXcvcFRDa2krczJLNmtUOE9VNmQrOU56eEQzdTRDaUloNllVVFhS?=
 =?utf-8?B?SXJIUnl3YzR1eTV2RE5uWS92cEpIOUxydFRxRFY0ampEbjlpMTg2WngyMVFC?=
 =?utf-8?B?aThzVEsrRHgwNGI1RVN6UUt3SU5FTUN1MDUwaE90dHBDVEd4TzIydHh3cjRn?=
 =?utf-8?B?VEEyc012Tm4vNUxFZUVZWVR2Y1Q5Sm9nbzd1RitndHp6MDNaVWIxMEdlb09v?=
 =?utf-8?B?bElCbTdwdkVweXVMUklYLzA3Y1BGVzFjaG1NMFBlVWt3eFp0NUpLUkd6WDVX?=
 =?utf-8?B?MjlrcXFzbWwvc1lURGdGci9MZ1RsNGVOTGRPeDZESjlRZHNHaEdpV0FlQzd1?=
 =?utf-8?B?bml3SlBHSVFoYWdtS1lCVUljQkhweVcvTnZ2eVV2ckptaEs5c21uR1p0cERy?=
 =?utf-8?B?N0Z0ejVHdUhjTlY5RlNhRDhQWjBrWVBDM1F3OWhwTEQ2L0doN2dxYUNkQm16?=
 =?utf-8?B?RjR3eDF0OGpEZmhleTJwbmFTNHNVWGl4K1RqUWJyQUxTRGR6TzMyUzZrRVhJ?=
 =?utf-8?Q?LuGY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c503bf-f543-4af3-75bf-08dc86921787
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 01:35:19.7577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3gYpil59Qn8iTDGKbktRaPVveiaffXylixOJUko6CqZPtJnYXOMRNwy27H44cfO5VIr56SzX/nnZFeMus+65w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10451

PiBTdWJqZWN0OiBbUEFUQ0ggNi83XSBhcm02NDogZHRzOiBpbXg4cW0tbWVrOiBmaXggZ3BpbyBu
dW1iZXIgZm9yDQo+IHJlZ191c2RoYzJfdm1tYw0KPiANCj4gVGhlIGdwaW8gaW4gInJlZ191c2Ro
YzJfdm1tYyIgc2hvdWxkIGJlIDcgaW5zdGVhZCBvZiAxOS4NCj4gDQo+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnDQo+IEZpeGVzOiAzMDdmZDE0ZDRiMTQgKCJhcm02NDogZHRzOiBpbXg6IGFk
ZCBpbXg4cW0gbWVrIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8RnJhbmsu
TGlAbnhwLmNvbT4NCj4gLS0tDQpSZXZpZXdlZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo=

