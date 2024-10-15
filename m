Return-Path: <linux-kernel+bounces-365017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1B99DC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15FADB214C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0A8166F1B;
	Tue, 15 Oct 2024 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GQhUe9kF"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917A184F;
	Tue, 15 Oct 2024 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728959151; cv=fail; b=AvErhK88u3Erd4iWWsDBVxsh3QUj+0lFnAvbHVxucdYnujgAF0yVtGQcJARe1niJLrdPmFThV5S+uDYNn/cRl3rHdOy+teV+lntvDQkms+7lR7teC+CDNiNp2g06lXlZbEJxCU6iMowSkBfnMY0rC5p6vvQ60zFaqlb/1jPDg2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728959151; c=relaxed/simple;
	bh=LU9Vse6jp+WgM9AEri7L5hkvhucE6uYno07MO4fZqh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgTeDXH5Fv6ewHxQOj9uQ7chgEvGcI0fo9fe3vadLV44XseApGHwhjCzKqeDw2tpin27exz8dtq1k7rP7VCfk+FJ/VD4ctQwRbsY2ckeVzTxTvEao/WlC9IbP/7hIRg2Iv/Fc6PGt+ZCxOPnC2Ap14uhshyE75LiMeAae4c7GYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GQhUe9kF; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwQg+8DUrr+5180hKwTelQLF6mZ7jsTybiyfBX5AS9gljKbPUE4QU7T/pN8jjdeZH/HrTr4flFC9V4kK8inWiqEXDHiSZMSuybcqlNDBV43gOFQsVuri2fO6Jx1vTrmGxAedoLd0rp2Ie/o5CBom4LtUhV0yOJ0bLXeac8mHKm2eDQOYfvkwxHM705M51fQ2SeLqKTmb1haZQ4uPPr0gZvS+gOykqVdl05GeqDGx55K25MMrMVjnQjMYdmhadjvS2IVfHQ67ul1Q6vmMc5kLs6GTJ7qMhrAkql1cj4tCxwWtiuLsuXkziVi4+kULItWQbuirmGVS18mw9kS5djUf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU9Vse6jp+WgM9AEri7L5hkvhucE6uYno07MO4fZqh8=;
 b=ii4+HCj7GcA0xMMaLQIaqJGP5UckadbB4nx4XziguUT333DDNWNtZHdhN6VLVxDE7IckEavIuiJwSiEcdsllFKqFqXF22nLHc56qDbEMQouz4YSGzbGcpxP7o1VlZN9cvU9lombZ6nWjOG7Ruq1jQII8B0LaNj1AHt5KyUCw+h0QnGxMaL3Yo1al5sLfO8u4tNeNLjkUerFnCgLfSaL5S0QWWwOnDE19DikAIyjFmtcd4tCAJmzKBDDYo/pvcOvy7qblRQP9Z8ExWKo295PY32i2g/nmajpuUjaOunL9Rd1p8Tgu/BHgHxua3jhyWRn3+o0wGWFwWqXTNoOi1ZPkKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU9Vse6jp+WgM9AEri7L5hkvhucE6uYno07MO4fZqh8=;
 b=GQhUe9kFIIBn1rKb8U1MD9z3oZy2lTesBGYuqJfif/08OoHSpVqUfU/41Ut4keaAfd95i6MF4UIwe/ELGQmYT0M680FhJKrAYiMEqZeJh97A2dIpCmUl231wNYTvnOsiND3zYqa5brCUG63MMI7+toFBwtk60knsf28rw4CMEs8SH8InU0XE0b8hOPJ4nrANmzEVEvAI+9xoU861i/ddjPe0DxzsDWW/wgTGnGhYDd6zSUp3wwA4fwbaTegWdazfRM2TlANP2f+zmHlE525wr9rVRv0KYr7GLLs7AiJd2tKLfO9PgsyHEVYxIsl3cYh7CX1vtmaviozeEVmIeWT5Sw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 02:25:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 02:25:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Aisheng Dong <aisheng.dong@nxp.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] clk: imx: lpcg-scu: SW workaround for errata (e10858)
Thread-Topic: [PATCH 1/4] clk: imx: lpcg-scu: SW workaround for errata
 (e10858)
Thread-Index: AQHbHhfXcCGneoDf+E2/H05k1kIVPrKGTCmAgADJq8A=
Date: Tue, 15 Oct 2024 02:25:33 +0000
Message-ID:
 <PAXPR04MB8459AA95968436898B46267C88452@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com>
 <20241014-imx-clk-v1-v1-1-ee75876d3102@nxp.com>
 <CAOMZO5Ct1u6d8gnrSEbBW6b+sOdz3W=1oF0y21hdcUFdr0ymzg@mail.gmail.com>
In-Reply-To:
 <CAOMZO5Ct1u6d8gnrSEbBW6b+sOdz3W=1oF0y21hdcUFdr0ymzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VE1PR04MB7245:EE_
x-ms-office365-filtering-correlation-id: 375da646-7c59-4328-859b-08dcecc0a558
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0VEWWxOUlVZUXpDYWdXSU1vL1VIYUZhVGpjbGdZNmRzeXh2SkNjN0dGT3c0?=
 =?utf-8?B?UVd1dzgwZmV4YnI5cWRHdEN0UTlneXhqL0tvSXc0NU9yejcxUTdnMWtsbXln?=
 =?utf-8?B?d29SLy9YZ1VQZ3V5azJOWlBUcGpkVWlMeXN6YkFXNU1oRGZMYTh1MVFmNXk2?=
 =?utf-8?B?blRnUWRqZ3NiVVozay80cktHSGo2Q2RvMGErcndQN0hxNWVpQmo3Y2tSQ01V?=
 =?utf-8?B?QTdpa1pmSnZXejFGQSt2MFlPRk5hWjN2TVlVQWpJNzJPVW5hSVRHZEtnMEow?=
 =?utf-8?B?TGFPZEwzWlpNc0ZTbXVFMFEyS2dpZktsMG5FUTJMQSthOHdKU1ArbVI2UWQy?=
 =?utf-8?B?MS93VXBhN0lxR2kxd1lSVVVjWlJvL0NlQ3F6aEhtK2RnSXVmTFZaWjY5QWdv?=
 =?utf-8?B?eDB2Vkx4TjR6OFJHNFVFb0luVTcvOFI4ZUlEVEl1RURHYWhpVTYycTdiZDF3?=
 =?utf-8?B?L0xUeG5IR3lIRElwOEFvajFpY0ZIdTNMVE1OL0tNVGIvYjM4V3hYVndjdEh0?=
 =?utf-8?B?Wk5zRlJEVStuM3pEMlVmZkZ3b1Zzd05TNE9MMkM3dlpXUzd5a0k1bTRYVUFr?=
 =?utf-8?B?N3dYT2hIbmMwQXpLaVd3ZUpJNTB3ZUZFWWNXT2UxTnBBRnYxVytTS3p6UnI1?=
 =?utf-8?B?V0JXSjVMdlV0bmtuRDhtbTZ3OXdTYUppWXhFbjZKdlBuaWhrS3gxZURBTytn?=
 =?utf-8?B?R3kxSUk5VHViKy9zbXN5TnowY2d5a211cHJudUpEYm5FRkpzSVl1QVJFRGh6?=
 =?utf-8?B?K0NBRGVPcGNNSEJRZmNpNitBejd5dHE5eWZwK1U1NzlrMmJIR3JvcWsrL2xG?=
 =?utf-8?B?cTRhMjdrcVRBWWR3eGdCVFdibkV4d2ZMSytNVy8zS0Q1dXBBTmNsSFlXNUFk?=
 =?utf-8?B?SlZPckVoUjJwWEw0ZjcxYTlmUlhtWmlJZG5vanloS1A4Wm15ZkVBM3FTRDhU?=
 =?utf-8?B?TG5NSXV1ZjJ1QzJ4Mll6WFNFVDVCL3ZwV3o0YU4xZHFzNXROU2puUmxpYUVP?=
 =?utf-8?B?SG9QVzVDM3I2ZEtkcjZyWkVSVjVUdzA5UjV6ZjJ2K1pXU3puc3E4SlFJTXRE?=
 =?utf-8?B?SzFaaHM2UGhCTUg4SVVuTkVkanc3dkQxd1ZHZVR4QUtnalNrM1FOODBvV2g4?=
 =?utf-8?B?Q1YrNWNFSFAzdFBaajlzM2czQVZzRFBNaVk0Z2ZKcmZna2VQeVlsQ3VicWsx?=
 =?utf-8?B?eGZhMk5FV1JoRmo1Mm1xVXdvQkV3ZTl6dTcyelE4MHpqQ1g1emx6NWQ0RTc1?=
 =?utf-8?B?NWJzUWl0d2xhUjRkQ1ltYWRoaUlMRi92WWh3dDJXRU9sMVc4NW9vQ3k4THBI?=
 =?utf-8?B?T1QwVWRWMUwvSEZHdUhWbUY2blRvdEM0elF6OGlGUHkveE5TWnJKVlBUOW51?=
 =?utf-8?B?SEc3VmkwVmowRjh0QWNEWTl5alNHNFRyZ3VOU2YwenZBOVFQYjVwMEs4RHFN?=
 =?utf-8?B?eVdqVzliZER4Z3ZkMHBBd3RBbkVMQTl1a2Z6OWRFQnNQRktaN29lcW5tV3N3?=
 =?utf-8?B?S1E0WFErTURnUk9icmZMS3FzdlJXVHBMZzRwcFZER3VnSFdzaHFOSjNVcTEr?=
 =?utf-8?B?YzdGZWJqRzB1K21aWnhpWGREbHg2WE1QV3Fyd1hleWMvQUhJd1BETnlnQmxN?=
 =?utf-8?B?WkFWQUxxalNpeDVlYUZmaUs1RisvNElUS3NoQVF2cWxpZHg3cnpXLzhjMnVo?=
 =?utf-8?B?UHNvU0FmeHQ5cjdjeTFENXRxSlJOTUxCbko1MGIzcWlSanZFQlAyUUhtMndY?=
 =?utf-8?Q?W2L2elmwqKr/Kt864o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0x4eE9LOGF4ZXAweTNYV0V2dnBLSnNqVk84K0M3VTlKOURCcVdTczFodWhL?=
 =?utf-8?B?VWlHM1l5QmVWc1gvbDJ5Z3kvcU9tZ0EwZDgvd25RbnkwRFl3WXZTNVo0Rmx1?=
 =?utf-8?B?bHVrR0FJOXlyeHBBYS94S0xsZTZTajRGbGhpMHBvZ1kweGdFb3lqU3lWRXpz?=
 =?utf-8?B?ZnlINnNlYkRuUDI0cW1DZzVVY0NJbjg2YWRkSlh5VGRlZGYxaThDTXJPSDI2?=
 =?utf-8?B?TnVSTWlNcGs2eDJnVmV0MHVpMUZQdXpES0dEMVBjblR0NXcxckhpL0tHNmVa?=
 =?utf-8?B?ZzRHMVFacjhMWFJtMzJJck1aRUg3MFZ6cWIzcjJrUi9IcjFRUEJVZUM3THJG?=
 =?utf-8?B?Y1hKOWdFcitqK1pzMWx5T05QeUJkcWs1QzROSnVlb2hCeXlxd3Ezd1JpZUZY?=
 =?utf-8?B?R1dlc0l3Znk3QXBJTU91ZlVSQ0RMZDg3bHA5cHp1VlRrSDlLUER5OTlUL1V6?=
 =?utf-8?B?eE1ZYnJOSktRMWNTRHZGazRNU3BJYWMxeklDUXZuS0EvOEpyMUJXWStTLzM1?=
 =?utf-8?B?S09jeG1jbE80MEFreldFYnUrQStaUjg3VDNHNEpvZk42R0JtQTc2TUdmYzBj?=
 =?utf-8?B?V2trYzc2bzVMSWl4S055WFNsMkd4Q3BsNEh0RVV5cW1YN3RUS1pKcmZaNFpZ?=
 =?utf-8?B?R0V4ai9XNmZTV3E0amJsc2dlazFYWVZMb3k2TVJvb0M4Q1lCQlFLaXN1L3NH?=
 =?utf-8?B?NXJpc25XZXdYRElTVjBwU3VraGxSMDNjN3lrU2pLSnIxbk5RUzRkYXN3NDcy?=
 =?utf-8?B?OWMrbDN1UVR3cFY1bndjaCtyVER1SSsrZTF4aURvbUYvakx3WHZmemJmZ1Ir?=
 =?utf-8?B?Q1RzRkxvVkUvNnppdVBWcm5TcXNlRFNnK0NpemdtYkJTZnFTWVRuQmt0Mzha?=
 =?utf-8?B?c010NEtqRHUzenFDSXB3SHI4TElXYWtoVjliS0JOUG9jeGpJVTFBYVB2ZXpw?=
 =?utf-8?B?YVBtVmdWTDlTcXlIWjdRT1VmSERvUzgzZzJxalFzVXZyTzFCc1c4bk9sYTNY?=
 =?utf-8?B?QWIxVENIVkU4MFpReHpHTGVXRUltQTBFWnJYQ3VMT1lkdkRxUWZsaWJKSFkz?=
 =?utf-8?B?emFiNC9UTUtiV3NOU3IvT2NTZjVyL0hKUlg1ZmlyKzErMEtsMUV5TklVT2hi?=
 =?utf-8?B?VHR5cFlKbVp6ZVJQdVNqbzRRbkJXMlJUdVhuNDhSd3JaekpuV244UWxwYTgr?=
 =?utf-8?B?OVBiN21vQ0t0ek1MNWE1WVBrb2dGU0VJRERnMit5bG1Fbk1paElhQzhzczFn?=
 =?utf-8?B?UFJ5aXpSRWY2OTF3dGdZa3dqYjhsL1h4MEttS2t2RWI5WElWd2o0ekE4ZXVX?=
 =?utf-8?B?dlI2aW9RZ2lVbVpIWVVtUllIa1hsUkRTa2JyTWNJNVVqUzF4cGJ2YXBMSFNB?=
 =?utf-8?B?Wm9sNTFVV0s0S3EvVmVyZ0h6YTdYY0xLem5xWTVVL3E0eXVLYkVyMkNTUGJn?=
 =?utf-8?B?Mm82QXlIZEk0WFdxT1hkbjJzOVAwcStqYUtnMVpxbk9iYUd2TXdLR1gvSlZX?=
 =?utf-8?B?ZXNjYkN6N25aR3hGcnh4VWkrZXBYNmRhNFNhMTg4bHdwK0xnU2hqQ29Ud3A5?=
 =?utf-8?B?OWVaS0JwcXhtUTJONTFiU0hEVy9waTU5Q01GZGZtYUdhS0dMdWIxNGdsSlFP?=
 =?utf-8?B?YWJNcWQzcUxRNVQ2REtSLzg3NERBN0ZaRG1KUEZBNUVwcEdkRFcxbnpVNDJI?=
 =?utf-8?B?cmxSeWdaMU9tNDAwS3MwQTlSUWswK0thLzRqU0pLZ0hLNWx4L0JrVUE5T05R?=
 =?utf-8?B?MjdjVVo2bk16MjF0bGlXN0hKQ0MyU3dGbGhUMjhhb0NWd3kzRXlwbmFmY0M2?=
 =?utf-8?B?WXEvV2lVUml3WFc2OVlFSTViVmRoSHVXMU5uZmNkVDlMZ0YvbFhhMzU1ajlY?=
 =?utf-8?B?L0VhUEFPUGdZRzZRdHF6ZnlPcE1CZ2Myek91cVJ1d282anp1R2tPbmk5a3kr?=
 =?utf-8?B?RE9qZ0g0WXNvWFVJTGRxcnJ1VG9hWnJnd2VyKzZtbGVqc0k3dlRpWi9Nci8y?=
 =?utf-8?B?ZVJyTkFSdHlUMWNGbHh1WmRveVB6WkEzTXhJZzk1eVN2dGRPQ0FoQUNPSFMv?=
 =?utf-8?B?dnhsMSszSnpZVXpnckhtUUlSQ0xMM2w2MkxxVXlYMDhFVnBpbkpGbUdISHkx?=
 =?utf-8?Q?/bIg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375da646-7c59-4328-859b-08dcecc0a558
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 02:25:33.1126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHEwz/uW9lkWodB097N4/UASrREYMg6TefiAMS0clR1g2k3FRWrfXVt5Nnkeq6xAfMy0sh2roblUwFDlUMbAZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7245

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gY2xrOiBpbXg6IGxwY2ctc2N1OiBTVyB3b3JrYXJv
dW5kIGZvciBlcnJhdGENCj4gKGUxMDg1OCkNCj4gDQo+IE9uIE1vbiwgT2N0IDE0LCAyMDI0IGF0
IDY6MDPigK9BTSBQZW5nIEZhbiAoT1NTKQ0KPiA8cGVuZy5mYW5Ab3NzLm54cC5jb20+IHdyb3Rl
Og0KPiANCj4gPiArLyogZTEwODU4IC1MUENHIGNsb2NrIGdhdGluZyByZWdpc3RlciBzeW5jaHJv
bml6YXRpb24gZXJyYXRhICovDQo+IA0KPiBQbGVhc2Ugc2hhcmUgdGhlIGxpbmsgdG8gdGhlIGVy
cmF0YSBkb2MgdGhhdCBjb250YWlucyB0aGlzIGUxMDg1OC4NCg0KaHR0cHM6Ly93d3cubnhwLmNv
bS5jbi9kb2NzL2VuL2VycmF0YS9JTVg4XzFOOTRXLnBkZg0KDQpUaGFua3MsDQpQZW5nLg0K

