Return-Path: <linux-kernel+bounces-288935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F4A954069
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8F628947F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF6478C93;
	Fri, 16 Aug 2024 04:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Z5u8q7hY"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24F142E60;
	Fri, 16 Aug 2024 04:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781207; cv=fail; b=sFmXnE9TBGC45cImPlKiEwIXFTLbR1CiiUmMWFbMxK9aRzWsO/Irg1cv1a0X5897Qdboywr+AoXhX0vUx82IXNYZQBtsmHhXHL3yg85hW6OAkihOUbefy9tW1i5ROvz+6EL3B70+R0absgUmgb81z903mjjT8eMrMKxW7Y/VzVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781207; c=relaxed/simple;
	bh=7jr2d3KjUOPLaX+/JhOqtZh44JIEMo0AAUMKJxWOaqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pta5K6rlS/KGR9shG86Mq4xA94WCPQzh7HEy88QxX4keKDbLZENgjgKbcL2scLmWG1qKqbCyYARh5XpaorW+cfshlJURSL8JQ/LJMPANfJqsUEgnoL8HDmk7Uw6Ux354yYRFuKb8xCe+8eknk2kDlrjGuKBiDDovYKUouIQWN/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Z5u8q7hY; arc=fail smtp.client-ip=40.107.215.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUMjzYFgtjfUGuJbPxwPysjXgcZWz79QL54Y1cDfzbmJKHMZjJQnAT2I0ow3B5hsiUfEFYtzmtK8JyIBaWzLI5S3HXvZrmqTjSw/O8qCVcW8dEBPU/6hIZdBF3fpzE1NKg/5mdgqtY2lsNBDuehyJFj2nRJOdoIrGvPhdlznUt1MMkN5CV4QwiqgPj4Bl3HM9hfkxXALPfn469xkNAwQsiggisO9BIUn/S4D1pSVb4MJq7DwujM3UgYFeXzVYqYA8q50NeJaW1CVgHFExl0vi0l+jjrcz+4THxtK1XXYgGBNL84RJWzIimo0thEwwugjWlUQ6Dg4wD9LHyGEyu1asA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jr2d3KjUOPLaX+/JhOqtZh44JIEMo0AAUMKJxWOaqw=;
 b=x5uD3T3lQuvx1kjzrhFDjy+OLQNQOXGfYQYVoaV+pfESyOBsT9rV/eSy+o7BZx459we4UgDC346oevkt1LsdOvfHvdTcn5Z6DE755RDQcDMM3dE6zo6xp80EjCfgEMOm7IJieJPsyLDX2Pulg0n3MFJVwhIv0EUqIFK39CeRQZVs++A5uljXwUYCOo2DhlOSVVO7/6EioFJq5bOCJPVuZ4O3vKW8IDQ0jNWTnLRMx8Bp2NenGy+LwyHS1GuvKRqU8Dgv5mtLqcEazprWQGtF38xVBzP6e5xUwXNUOecOI2TeOXt92AVIC0nKZgDVNRrw0w/5kJgjMnAHNEq9XhU0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jr2d3KjUOPLaX+/JhOqtZh44JIEMo0AAUMKJxWOaqw=;
 b=Z5u8q7hYDUE3gV1smEm/RTEagi0iqglB3xvdXADkGLFCPkM/P8K6UYHXJ+Q3SKJiSx5GJkqC0gBVQjwEuLtU7qSWPQrLlEA8hlwqHHwm7lwJr9JgE+/QkQQc0fZap70fqWtbGqZ3tHV502zR1pHrjHA7udO9LuOevZ8PZ3tXVWpaYfrcvfE6cCPvoXy3nuayNw88+lJZ5xnIvMDL059nbb8swrMVD7owfVI23renkgd78nUkQwnQOZk6EDZU7hPapxc4AsmTZmvCJ0PApntR31ijCt2BElDTkOSt+mLh0WNtY+/2BOEhC3ZZdbQgJu9nYqZn+wR2+6BJEyF09hmN4g==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:06:39 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%7]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 04:06:38 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "soc@kernel.org" <soc@kernel.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, "olof@lixom.net" <olof@lixom.net>,
	"will@kernel.org" <will@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"u-kumar1@ti.com" <u-kumar1@ti.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"joel@jms.id.au" <joel@jms.id.au>, "quic_bjorande@quicinc.com"
	<quic_bjorande@quicinc.com>, "lee@kernel.org" <lee@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "dmitry.baryshkov@linaro.org"
	<dmitry.baryshkov@linaro.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "Rob Herring (Arm)"
	<robh@kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v1 00/10] Introduce ASPEED AST27XX BMC SoC
Thread-Topic: [PATCH v1 00/10] Introduce ASPEED AST27XX BMC SoC
Thread-Index: AQHa30uF0np0rPVCvEWxq1tD4p2I8LII+5GAgAAGyICAIEPl8A==
Date: Fri, 16 Aug 2024 04:06:38 +0000
Message-ID:
 <PSAPR06MB4949E84E4B4CF39991FCF9BE89812@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <172199921352.1507193.4411331020670815695.robh@kernel.org>
 <241ceb9b-b29f-41fd-8987-2feba2e5e08e@kernel.org>
In-Reply-To: <241ceb9b-b29f-41fd-8987-2feba2e5e08e@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR0601MB5510:EE_
x-ms-office365-filtering-correlation-id: 7558dfbc-e94e-401d-a030-08dcbda8d39d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlhBQ2l0aWRhOFlnbjgxUlFWTlZOU3I1Ujg1MGM2Mm45VkY2ZnRqNEJNQVBU?=
 =?utf-8?B?NEFieWVsUVMxSzQ3RGdEYVFBZnNvVWFGUzBWUmlKSW41K0hYM3M2YjJ4R0k4?=
 =?utf-8?B?TnVjY3Qwb21uaklYZmdBZmlxRC9uSHBaWmhpaUdPOGZ6NklrSENnNW1pbjBu?=
 =?utf-8?B?eGhySUJVbE40NlBNSjVNZTZSQjJZeEVKRFlVTm5WYldFTHZ5dzNkMENUVDha?=
 =?utf-8?B?RVBMWXlmZkNZOGZYSkJtTHYxQTRrLzk4YVdrc0RYWk9pUjZIVXEzOEZoNHVE?=
 =?utf-8?B?QmJEdXJOQWlJWWlTVE16eG43OXhlS2M4TDcyRlJxQnF0L1k4TUM1aXUwUWc5?=
 =?utf-8?B?bFhLM3FaU0k2eW5PYlNWYmFjUjRYQXBVR3dRdGVkWlRnYmFSbG45RTlhVm5w?=
 =?utf-8?B?MzlzYWZtUEw3d3NxMVRzNFhuUS82SEc4UTkyTXRYZ0VlNDAyUjJuejZBT1pi?=
 =?utf-8?B?ZXgxNnl3N2l0VHZVQUUwbVp3NzJrbFFTcVl2cXEwK2QyNlpWa0NUeUNwdXNq?=
 =?utf-8?B?U1NpWGQyTzFOL2UwWGhZcnl4ZTJFRng2NDBpMUsrRmNnQWJ3QW1nQ3Q2dUwx?=
 =?utf-8?B?S25XOSt5SiszT2dqdmkvenhHWmtrQjVQVXpxbXd1ZHhKN09vSTFwVDRtVjY0?=
 =?utf-8?B?ZjVod09URzdxVnFVODUxUUtKV2NITXg2V2R0L3NCUE9FTzBpdEZMRjE1aTh5?=
 =?utf-8?B?TVhSdFpXa3lqbmcraFFIcTNiMEdOVm1DTmJKT1MrakRGam5CMkNDYStJM0lY?=
 =?utf-8?B?aUw4K1V4cmw2YVE1MUphNGg4MjhCZWVzb1l5TlRWNklYQUdpK1k0eVZ4WmlC?=
 =?utf-8?B?QWVXckhDWnNOUlBxK1I1Ry9telQ2Z2lUUENsZHl0QVBocExEa0lEWkJISFVJ?=
 =?utf-8?B?UE9uc1M2dlBIMWZVVGVydUdLZVhGTk5vQ0s1dEFzT2xFZzMwcWdQdUlHUmYw?=
 =?utf-8?B?RW5Kek8yNHZGQWQ3aXNwVzZLckZPMHZYTFVpSXExaHk3NHJLM014d0RVQlUv?=
 =?utf-8?B?K3BPTG0wOGcvZWRrT1JCNTNuN2tmM2dHRVFCUVlJZE1lQmJhY0hiWkxmdHYy?=
 =?utf-8?B?N2tPUDUvemZrSzZNNFVaQ2RBcmlPdnJZNGpjUGZvUzNoVVRBN0tyUzdYSjVj?=
 =?utf-8?B?VmJEU1NoRVBGdTI4MFBvcUFGekZNNU9WOE5IMGZkeTVUQW9NbUNmSDI3bzZz?=
 =?utf-8?B?K2ZTY2VnU1UzUmh4QTVhbG1ia2lkaFhGaUZzb0pqNnpRVi9rcHA2M1hJeWRp?=
 =?utf-8?B?YXBuL2NEYXJrUzJsZ0R3a0dXa25Lamx4L1RXekN4ckZ4M1IwaGZ0R1BNS25R?=
 =?utf-8?B?bHh5V0VPbG54WC9wSFB1NlcyZytXZWpOQXFnQk54NmtkVkdta0FTOVZKOGN6?=
 =?utf-8?B?R0ltcllaL1djYmhOdjNVbk80a29mUHQ2TjVpU0xQSmppRFNGWW9WNDdnMmRF?=
 =?utf-8?B?OFFZbVVGM2FWRFdrN2JNajdDVHJPdXRqUENLcUhCSVF5YWZ2Q0dGQ2lqTFF0?=
 =?utf-8?B?U3lud3FEMWFsNEJtZ3dxbUY5NUlzS0FRMTdhTUNmbnZCWG1NZDdFV3A4T2Fl?=
 =?utf-8?B?UkhPRzlwSWtXckdiUU9vTEo1bjVQL3BxTm4rT2JEQW1admxVZ2NBL1pLSTdM?=
 =?utf-8?B?ZkpIVVBSbmZHNmlDZ2dpNTlYZDZhRVdzSWFqR3UwVG9mUEJVQzhjUFlhNklk?=
 =?utf-8?B?L0tJbDRrNUY5cHJVMEpIOXlUQzhqMDMvSUROcExFNGZYN1lGTit5TDhTRVRO?=
 =?utf-8?B?RWl6WHZBVnFPaCsxT3k3SktyeWJJekJwb0VlTXJ2WWNaOTUwRjIxdGhvblNo?=
 =?utf-8?B?eEtEOG9xOWg2Z1M0N3lwdmVPRGpqUmtWNDJBTG1leWlhemhzNFlKaFcxd21J?=
 =?utf-8?B?NHNkTXpBRUNuRnFNVHljMmZFWlZmTjNQZFhuM0hra3hTRmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tk0wY1RoSXVNK0c2R0cxVXBXZjFUdVRNMUwvZlRmVFZOakpualhuMG56SStV?=
 =?utf-8?B?NDV4dDdvVHVPeGZFeE82WW1kKzRPSXNtaERuYW9KM05FM2tDUE9lQ0hhQStr?=
 =?utf-8?B?cHVFNW1JMklpS21IQ2V5c0lseSs2YzhCY0hvV2MwRVc3eUtOUUN1UjF3a0xR?=
 =?utf-8?B?NzlvUnlyRkNCU1Vua3FjQlRVNGxBbTFkbkFUNXdYbXg5UzhpME9lZW5TaHQr?=
 =?utf-8?B?Y0xVMEt6Ty9maEtJMkFSRTJGdW0zR29pSFJoQkVMMFh5U2l6SE1rUUFCUVc3?=
 =?utf-8?B?enFrZVg5eENNdEZIMExBMlpyQXNQQ3dYRDl2SzdpQjNJSHJYcmtxdjd0M0Fp?=
 =?utf-8?B?S3FWdVprc1kvTHVURERrb2hNam1BUCsvN0lvMEZFc0NYelUvMnVlTnU0TTVy?=
 =?utf-8?B?bTZDbmRCT3pYZDR6OXV2ZEw2SHgyb21pYTMxSzkza3VmSTZmT0tNbWFtNU9F?=
 =?utf-8?B?VWZBZzVad2s3R0x1MUFWRVZyTFQ3OFNMT2tLRXVHMzVyUTV5eS95dHVadWt4?=
 =?utf-8?B?NkZOVXdtczM1dXBmMTRlNDZnNzh1Z3ljdERjM3I4eUc3alNUaVhjMEdSNjV5?=
 =?utf-8?B?VWU1blRETDlETzhPYnhTZU9CS0M2VGY3T1EyVitnbDNhZkRyeG9obkJ3S2pM?=
 =?utf-8?B?MVo1YTRTeStqREZLTFAreTE3ZUtIN2t0QTc2NTVOYVVWc0tqMVhSdUl3MmNH?=
 =?utf-8?B?T3h1OXpFS0NudFU3QnI5bGVQR09FNUw4c3ZZY2d4TTdTdlkzSkxLQUlZbGVT?=
 =?utf-8?B?dDJBT0dUMjkyQmIzL3dTTE1RMDFCZGpVLzlZOTRIczZxMDBzQ0MrSjV5ZmtV?=
 =?utf-8?B?K1RhMEp5SnIwLzBkakhvWURoYmFQNUd6a25vQ1Nkc0tDRW9oY3lGOC9PdXhZ?=
 =?utf-8?B?dTVzVmJzYkVQTkxlZmhtdTZMOXl5U2toU0swbEw5TEdFS0JuSWhCeGRkVjFS?=
 =?utf-8?B?QVZmREV0RmdyMGY2UmZ2cXBMT2Nxb3hXamRXa3pBeElpR05pVDRMSkluRXg5?=
 =?utf-8?B?dWtaR3Fvc09ESllhaW81b3JNVk1OYXJBTk85dDNVVFZJMU5oRmJrazArWlk0?=
 =?utf-8?B?TzdMcVBQTG5XQ1JWS0c4QW1WQ3BncmZQd1JwQWdwZkJjM0x0S285WHlGNTA1?=
 =?utf-8?B?Wkk4OC92QU5RdUxKYlFTaUtaUVFMdys0aEZ0SFJVOHp6ZHlCYzc5NjJTNGE5?=
 =?utf-8?B?SVB3Y2s5aVcyZ0I3dlFCSFQ1aEgrVjZnVkhVbHdHeDZCUTJIZ3FwenYrM2Ja?=
 =?utf-8?B?MDF6VVA4VHhHR2tZSFpJMUowQ0V4c0doblF1cVlCQjBvcEV2YUpIK3FsWXhR?=
 =?utf-8?B?VGJ5SDMzMURKZzQ3R1oyRDIvVEM2RE5NWjRKQzRGeXYyU0VlMkJlbzhkUW9L?=
 =?utf-8?B?Tzk2ZkI5enlYTGFneUVKalVKNlozSVlZdFkrQktHcEtzK1VybXBHUlpkdGhU?=
 =?utf-8?B?YnlBWEs0dFlkQmhYa29jSVdhK01VbEI1Qy9NT2RCaUN5RkhNb1p3eFo0UHhT?=
 =?utf-8?B?UmZpb2RUSFdaQ0paMzViWVpjUnBDdUdvUnpZcDN2TFZ5SkJwQkVvb1g3RmRN?=
 =?utf-8?B?R0ZkMGdRNWFVSU9WeWV5YnBnb1FlR2Z5bmdSMER3NmF5ZnIyVTdJVEdBNFBE?=
 =?utf-8?B?VkJ1bERSZGlsWmJJOXZiVFZkckI0eTFVRDBNVG9haXFCR0FaL0J4dEF1R0ZY?=
 =?utf-8?B?WUo3Ylg1cENVVmROalpEK3lENHhFUWlNUk8xOE02dmdMRWlqU05uMG5iNDZH?=
 =?utf-8?B?c3d4K3Z3T2pBVlFZOGc5aGl6Z2t2ajlSZmZ2MVhET2tlSW9ycnB2RUZ3Nzlt?=
 =?utf-8?B?WXJaMm5zeXQ0TGpkK3d1S0F1SFVYck9xSnMvdHEzQ2lVRFZVd0VwUEhrK3Iv?=
 =?utf-8?B?czdUbStEbE44L2M2L3pSUndnT0lMQTY1TkpOQ2I0UEQ4QVJtVXNENTNGbTVI?=
 =?utf-8?B?dXEyM295bC92QU5WVDFrVFFwUmRtTlQxTGVIdVZwSjdFMDJLME1QUXFIVVZ5?=
 =?utf-8?B?VUtCQVA3cDgyOGU5cjVmT041bHRGTVlCaFlaVGxMb0tXL1ZpOVVIU2VqcWdh?=
 =?utf-8?B?c2RmVjRXMUxGdkNJQWJxZjFzakJqMFV3Nm8rWTNaNSsveDQyMnZpTVE5LzhI?=
 =?utf-8?B?aGFzYzVMK3VqckFRcFRyNWU0U05Ka2psb2h6cndjRTBpL2JCTVZhTWNXQytw?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7558dfbc-e94e-401d-a030-08dcbda8d39d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 04:06:38.1874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WrHparH9kLCOii1ss2kcsmyGt66ZsWOxZp70VfDk/iNpS9ITbD05H17yD8Ezl/hek+AXQTZzEZALiB63n4JraazktHFGav8XgIAYA4BfAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510

SGkgS3J6aywNCg0KSSB3aWxsIHNlcGFyYXRlIGNsb2NrIHBhcnQgaW4gdGhlIHYzIHBhdGNoIGlu
dG8gUnlhbidzIGNsb2NrIHNlcmllcy4NCg0KPg0KPiBPbiAyNi8wNy8yMDI0IDE1OjA5LCBSb2Ig
SGVycmluZyAoQXJtKSB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgMjYgSnVsIDIwMjQgMTk6MDM6
NDUgKzA4MDAsIEtldmluIENoZW4gd3JvdGU6DQo+ID4+IFRoaXMgcGF0Y2hzZXQgYWRkcyBpbml0
aWFsIHN1cHBvcnQgZm9yIHRoZSBBU1BFRUQuDQo+ID4+IEFTVDI3WFggQm9hcmQgTWFuYWdlbWVu
dCBjb250cm9sbGVyIChCTUMpIFNvQyBmYW1pbHkuDQo+ID4+DQo+ID4+IEFTVDI3MDAgaXMgQVNQ
RUVEJ3MgOHRoLWdlbmVyYXRpb24gc2VydmVyIG1hbmFnZW1lbnQgcHJvY2Vzc29yLg0KPiA+PiBG
ZWF0dXJpbmcgYSBxdWFkLWNvcmUgQVJNIENvcnRleCBBMzUgNjQtYml0IHByb2Nlc3NvciBhbmQg
dHdvDQo+ID4+IGluZGVwZW5kZW50IEFSTSBDb3J0ZXggTTQgcHJvY2Vzc29ycw0KPiA+Pg0KPiA+
PiBUaGlzIHBhdGNoc2V0IGFkZHMgbWluaW1hbCBhcmNoaXRlY3R1cmUgYW5kIGRyaXZlcnMgc3Vj
aCBhczoNCj4gPj4gQ2xvY2tzb3VyY2UsIENsb2NrIGFuZCBSZXNldA0KPiA+Pg0KPiA+PiBUaGlz
IHBhdGNoc2V0IHdhcyB0ZXN0ZWQgb24gdGhlIEFTUEVFRCBBU1QyNzAwIGV2YWx1YXRpb24gYm9h
cmQuDQo+ID4+DQo+ID4+IEtldmluIENoZW4gKDEwKToNCj4gPj4gICBkdC1iaW5kaW5nOiBtZmQ6
IGFzcGVlZCxhc3QyeDAwLXNjdTogQWRkIGJpbmRpbmcgZm9yIEFTUEVFRCBBU1QyNzAwDQo+ID4+
ICAgICBTQ1UNCj4gPj4gICBkdC1iaW5kaW5nOiBjbGs6IGFzdDI3MDA6IEFkZCBiaW5kaW5nIGZv
ciBBc3BlZWQgQVNUMjd4eCBDbG9jaw0KPiA+PiAgIGNsazogYXN0MjcwMDogYWRkIGNsb2NrIGNv
bnRyb2xsZXINCj4gPj4gICBkdC1iaW5kaW5nczogcmVzZXQ6IGFzdDI3MDA6IEFkZCBiaW5kaW5n
IGZvciBBU1BFRUQgQVNUMjcwMCBSZXNldA0KPiA+PiAgIGR0LWJpbmRpbmdzOiBhcm06IGFzcGVl
ZDogQWRkIG1haW50YWluZXINCj4gPj4gICBkdC1iaW5kaW5nczogYXJtOiBhc3BlZWQ6IEFkZCBh
c3BlZWQsYXN0MjcwMC1ldmIgY29tcGF0aWJsZSBzdHJpbmcNCj4gPj4gICBhcm02NDogYXNwZWVk
OiBBZGQgc3VwcG9ydCBmb3IgQVNQRUVEIEFTVDI3MDAgQk1DIFNvQw0KPiA+PiAgIGFybTY0OiBk
dHM6IGFzcGVlZDogQWRkIGluaXRpYWwgQVNUMjdYWCBkZXZpY2UgdHJlZQ0KPiA+PiAgIGFybTY0
OiBkdHM6IGFzcGVlZDogQWRkIGluaXRpYWwgQVNUMjcwMCBFVkIgZGV2aWNlIHRyZWUNCj4gPj4g
ICBhcm02NDogZGVmY29uZmlnOiBBZGQgQVNQRUVEIEFTVDI3MDAgZmFtaWx5IHN1cHBvcnQNCj4g
Pj4NCj4gPj4gIC4uLi9iaW5kaW5ncy9hcm0vYXNwZWVkL2FzcGVlZC55YW1sICAgICAgICAgICB8
ICAgIDYgKw0KPiA+PiAgLi4uL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC1zY3UueWFtbCAg
ICAgIHwgICAgMyArDQo+ID4+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAzICsNCj4gPj4gIGFyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMgICAg
ICAgICAgICAgICAgICB8ICAgMTQgKw0KPiA+PiAgYXJjaC9hcm02NC9ib290L2R0cy9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2Fz
cGVlZC9NYWtlZmlsZSAgICAgICAgICAgfCAgICA0ICsNCj4gPj4gIGFyY2gvYXJtNjQvYm9vdC9k
dHMvYXNwZWVkL2FzcGVlZC1nNy5kdHNpICAgICB8ICAyMTcgKysrDQo+ID4+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2FzcGVlZC9hc3QyNzAwLWV2Yi5kdHMgICAgfCAgIDUwICsNCj4gPj4gIGFyY2gv
YXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+PiAg
ZHJpdmVycy9jbGsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+
ID4+ICBkcml2ZXJzL2Nsay9jbGstYXN0MjcwMC5jICAgICAgICAgICAgICAgICAgICAgfCAxMTY2
DQo+ICsrKysrKysrKysrKysrKysrDQo+ID4+ICAuLi4vZHQtYmluZGluZ3MvY2xvY2svYXNwZWVk
LGFzdDI3MDAtY2xrLmggICAgfCAgMTgwICsrKw0KPiA+PiAgLi4uL2R0LWJpbmRpbmdzL3Jlc2V0
L2FzcGVlZCxhc3QyNzAwLXJlc2V0LmggIHwgIDEyNiArKw0KPiA+PiAgMTMgZmlsZXMgY2hhbmdl
ZCwgMTc3MiBpbnNlcnRpb25zKCspICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPj4gYXJjaC9hcm02
NC9ib290L2R0cy9hc3BlZWQvTWFrZWZpbGUNCj4gPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtZzcuZHRzaQ0KPiA+PiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkL2FzdDI3MDAtZXZiLmR0cw0KPiA+PiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL2Nsay1hc3QyNzAwLmMgIGNyZWF0ZSBtb2Rl
IDEwMDY0NA0KPiA+PiBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNs
ay5oDQo+ID4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC9h
c3BlZWQsYXN0MjcwMC1yZXNldC5oDQo+ID4+DQo+ID4+IC0tDQo+ID4+IDIuMzQuMQ0KPiA+Pg0K
PiA+Pg0KPiA+Pg0KPiA+DQo+ID4NCj4gPiBNeSBib3QgZm91bmQgbmV3IERUQiB3YXJuaW5ncyBv
biB0aGUgLmR0cyBmaWxlcyBhZGRlZCBvciBjaGFuZ2VkIGluDQo+ID4gdGhpcyBzZXJpZXMuDQo+
ID4NCj4gPiBTb21lIHdhcm5pbmdzIG1heSBiZSBmcm9tIGFuIGV4aXN0aW5nIFNvQyAuZHRzaS4g
T3IgcGVyaGFwcyB0aGUNCj4gPiB3YXJuaW5ncyBhcmUgZml4ZWQgYnkgYW5vdGhlciBzZXJpZXMu
IFVsdGltYXRlbHksIGl0IGlzIHVwIHRvIHRoZQ0KPiA+IHBsYXRmb3JtIG1haW50YWluZXIgd2hl
dGhlciB0aGVzZSB3YXJuaW5ncyBhcmUgYWNjZXB0YWJsZSBvciBub3QuIE5vDQo+ID4gbmVlZCB0
byByZXBseSB1bmxlc3MgdGhlIHBsYXRmb3JtIG1haW50YWluZXIgaGFzIGNvbW1lbnRzLg0KPiA+
DQo+ID4gSWYgeW91IGFscmVhZHkgcmFuIERUIGNoZWNrcyBhbmQgZGlkbid0IHNlZSB0aGVzZSBl
cnJvcihzKSwgdGhlbiBtYWtlDQo+ID4gc3VyZSBkdC1zY2hlbWEgaXMgdXAgdG8gZGF0ZToNCj4g
Pg0KPiA+ICAgcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiA+DQo+ID4NCj4gPiBO
ZXcgd2FybmluZ3MgcnVubmluZyAnbWFrZSBDSEVDS19EVEJTPXkgYXNwZWVkL2FzdDI3MDAtZXZi
LmR0YicgZm9yDQo+IDIwMjQwNzI2MTEwMzU1LjIxODE1NjMtMS1rZXZpbl9jaGVuQGFzcGVlZHRl
Y2guY29tOg0KPg0KPiBLZXZpbiwNCj4gSnVzdCB0byBjbGFyaWZ5LiBMb29raW5nIGF0IHRoZSBw
YXRjaGVzIGl0IHdhcyBxdWl0ZSBvYnZpb3VzIHlvdSBkaWQgbm90IHRlc3QgaXQNCj4gd2l0aCBk
dGJzX2NoZWNrLiBGb3IgYSBuZXcgYXJtNjQgcGxhdGZvcm0gd2l0aG91dCBhbnkgbGVnYWN5LCBo
YXZpbmcgMA0KPiB3YXJuaW5ncyBpcyBhIG11c3QuDQpBZ3JlZS4NCg0KPg0KPiBDb25zaWRlciBE
b2N1bWVudGF0aW9uL3Byb2Nlc3MvbWFpbnRhaW5lci1zb2MtY2xlYW4tZHRzLnJzdCBiZWluZyBp
bXBsaWVkDQo+IGZvciB0aGlzIHBsYXRmb3JtLg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KDQotLQ0KQmVzdCBSZWdhcmRzLA0KS2V2aW4uQ2hlbg0KKioqKioqKioqKioqKiBFbWFp
bCBDb25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQrlhY3osqzogbLm
mI46DQrmnKzkv6Hku7Yo5oiW5YW26ZmE5Lu2KeWPr+iDveWMheWQq+apn+Wvhuizh+ioiu+8jOS4
puWPl+azleW+i+S/neitt+OAguWmgiDlj7Dnq6/pnZ7mjIflrprkuYvmlLbku7bogIXvvIzoq4vk
u6Xpm7vlrZDpg7Xku7bpgJrnn6XmnKzpm7vlrZDpg7Xku7bkuYvnmbzpgIHogIUsIOS4puiri+er
i+WNs+WIqumZpOacrOmbu+WtkOmDteS7tuWPiuWFtumZhOS7tuWSjOmKt+avgOaJgOacieikh+WN
sOS7tuOAguisneisneaCqOeahOWQiOS9nCENCg0KRElTQ0xBSU1FUjoNClRoaXMgbWVzc2FnZSAo
YW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxseSBwcml2aWxlZ2VkIGFuZC9v
ciBvdGhlciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2VpdmVkIGl0
IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWlsIGFuZCBp
bW1lZGlhdGVseSBkZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHdpdGhvdXQg
Y29weWluZyBvciBkaXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhhbmsgeW91Lg0K

