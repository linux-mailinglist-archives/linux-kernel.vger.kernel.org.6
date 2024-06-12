Return-Path: <linux-kernel+bounces-211052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D633904C92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8874C1C2261C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DDC168C1D;
	Wed, 12 Jun 2024 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MrPxPG8f"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48317C9;
	Wed, 12 Jun 2024 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176864; cv=fail; b=NmtBfZUEvIkLhUekP84sbVehKDFP1RHfzD/3ck8f+AF85wdr9tTCyyy08AV/jojlZZSNlspTS2tKqjh4bxg/5WRzWgJzJXOzQubOSwLeqwujrL5n425VAoASzbnwzMd0+XOYwlUN89rart0e6Afwthei7a7Zo5OYOfjBvXi4odo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176864; c=relaxed/simple;
	bh=4/xNYdrcG4g6Was4CWhnXD8ECi+vfSvGrdgrgbVJ1Tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fStgpzReCtamqQINzEB5MArmZS6utVXiUCqL8D4ishK4PsZ6kbNU1oMEKt7avE0aG+P2mZS9R2Is/w1W/XvuCBbv2Qrw6GWVlJ0R+358oQPR4hkL8RR+jbmmy3nqA49X2DCZiJCrFdN6aOdOMtDKJvdRNu8UMR2p+RV5Hs81tos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MrPxPG8f; arc=fail smtp.client-ip=40.107.7.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0ztKoGV2q4TZ540iEwAz7t/d/aYIhvNBRNk0pneMmeLx2G0dxGwQKkXRaWR66XnWk0EcN5uhTG3R5KqKo/yoxZd+OKeH3MGi54WFwnc1H3/VNRLIK1rh0i4a4DtOJRrvkkmXRcosUMEgCELLgG9nQ9XQxOSRcMtB0xXWO8QQfe3Xz9ByZCvJM0Lhe7JSYigNAfj9VLxrSQSF2XOselfZHoF5F4NLBMI8d61MdIHL9T61gAAKn8zDp3Bjn3u8DAbrIjHYqduy+uVGPhMDAoiWld1PE5fuR95vwr1FnGuwwaaYVWLtNo/37kRNApND3pza8YTQf1t7UlFe1d311p5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/xNYdrcG4g6Was4CWhnXD8ECi+vfSvGrdgrgbVJ1Tw=;
 b=fKlgmyoCIEBq33OvgSHIYJr/4pTbwMssoN1MEgj/SiX4qMfEuv5PFudTZ1UaTdnjwdZdJMSTj9VTax4OJnkg4ydth4f9zFRTdXYkv+hGl6IeKtzZ+o+SYqzzvZ2y0MqfAya/PtoaDsWe58nZOXgReCc1i6fu94McELQTNYu+F7p3uE1f977xUnPW67TFdvCyQsywKio39DdV4b5sHSaVP103/3wxTprvY3jho7s2nRpyzuAeMSdFUNaaqMERsRzOMc6Wcgp1eNIod2E8hHObIjO0+YE80LIjyRMvqauQFYixZ5qsJyuBwgBGz3e1EJBQyrJAIDgu005FiCyquYmqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/xNYdrcG4g6Was4CWhnXD8ECi+vfSvGrdgrgbVJ1Tw=;
 b=MrPxPG8fsOgahElmB5vAZblIfRU+UIjhBOgxm0uHk539As3ieKxttaKyzgPWGLXBb/pvSfpTlL81herUcF689elyrFSgfT+/rTrSfl+/YpIP1D0nC7xDCzDOBA/58EOGmgph9GrBiwq5aZSzvw7uLnhTuTSvdg4hiYvYkVKBdcY=
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by VI0PR04MB10735.eurprd04.prod.outlook.com (2603:10a6:800:269::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 07:20:58 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427%4]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 07:20:58 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Vabhav Sharma
	<vabhav.sharma@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Franck Lenormand
	<franck.lenormand@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Varun Sethi <V.Sethi@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Frank Li <frank.li@nxp.com>, Daniel Baluta
	<daniel.baluta@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device
 tree bindings
Thread-Topic: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device
 tree bindings
Thread-Index: AQHaoao39pBQHEfAAUy4qDe7xhnXL7GOZykAgC2EToCAACP/gIAH2UzQ
Date: Wed, 12 Jun 2024 07:20:57 +0000
Message-ID:
 <DU0PR04MB929983AB361DB081B44E7AFE80C02@DU0PR04MB9299.eurprd04.prod.outlook.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
 <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
 <750f5388-20f9-45a3-a1e6-ceac4b91329f@kernel.org>
 <AS1PR04MB9358A2457AF05553457DE9B0F3FB2@AS1PR04MB9358.eurprd04.prod.outlook.com>
 <1486a1b6-4119-4121-b6df-3da21d06add7@kernel.org>
In-Reply-To: <1486a1b6-4119-4121-b6df-3da21d06add7@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9299:EE_|VI0PR04MB10735:EE_
x-ms-office365-filtering-correlation-id: 54dce5b4-bf42-4c78-f0ea-08dc8ab0348c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230032|376006|7416006|366008|1800799016|921012|38070700010;
x-microsoft-antispam-message-info:
 =?utf-8?B?bC8xQ3VKZXdYU2dlNGd4OXVCYVg4REZONDFRRFdCTHRwTEdXRVAreXNiVEhB?=
 =?utf-8?B?MEd6b2dwTEtDT3BkeDRkUkhrYmpuMzM1WTVJM1YvTEozOWdoY21BcU4vUGhi?=
 =?utf-8?B?UEdvcU9ZUFVtS0E0TjdLU1d2L1ZwZ0xNVG5xM3JubDJSbU5CRVNsWHpoVGFR?=
 =?utf-8?B?SERTV1BDamNOZHd6YUp1NmtHR3VPbVMzdnFtdDlVc296TkVyZGsvWXViMnpt?=
 =?utf-8?B?aHZEWmdPQXpTQ2I0YlNtalduTkh1dlUzOTZQOXhRdGRSTzdMWVJpU2FBSWN3?=
 =?utf-8?B?c2tvTS90YUNOUFA2OGp2SEFrWHRjV1p5NTRPbHQ2RitleTc5Y1lQMTg3U0lp?=
 =?utf-8?B?Yk5EUGNhTk9ZMlNGWVVybVhabmI3eExjOVpGbzlxME05Qjk5a2lZMTBNNWlu?=
 =?utf-8?B?aUp0Y3h4bm1aM1ZQeXlmem0veklndEJhSnp3V3BvWWxXTytWVmI3VmVSb2E3?=
 =?utf-8?B?MmVBNEh1eTdQa3hZSlptQTdyRDg0Ni9iclY5VjRXN3N4Z0pCeFZmcDlwelB3?=
 =?utf-8?B?VDZ5OGNVMW1EQWlkS0NlenowQ3ZyczJpMWxTM1RLUEFtWmhob0NXSnlCRkRW?=
 =?utf-8?B?QzJUOVhIMzhHUUp1Vk95blNRenI4cVFEYjVJbG9PSU9WOXpZZU4wOEZRTko1?=
 =?utf-8?B?UzNKNm9LeXpQRU0xODJsclYzWnZFcHNZQ1FHb2V5bGFMdXZRRzBNQlVYd3lv?=
 =?utf-8?B?OEtWaUtUWjNtMCtFNlIyRlZTVWlqMTB1QUcybk1oRC94RDRVZzBjdXRDZmFY?=
 =?utf-8?B?VU15KzF1bVJ2S1E1M092RFJOQVR6NnMwcVRkWm9zT2NkZ0NmT200ZjRwODk0?=
 =?utf-8?B?NVBiaWd2S3VscEErdlJOelh5bmNSc1p6R0RZQ1dZayt2dDBjN05zdk52L3Fv?=
 =?utf-8?B?d2NWbzN0VWt6bXg5RHBxRFdpblA1cTdmRWlIaTVqZUdzcjBBZ01DQktzWXVU?=
 =?utf-8?B?OFBtU2VFbENScU52eFh2UmlVWEFCNzFDT1FzZnA0U1V1b1pvaU1oWnJVbnJj?=
 =?utf-8?B?R1k0Q1A2Zy9GZDlLcHJ6UDkrQjlQN2tINHFpZzBMdWVKd0pmbG5zamNDQ0l4?=
 =?utf-8?B?aXByUnFWTWhMaDlsLzVwSENBc3lNVERuZWJ4MldnOUJZS1JzYWdQVi82ZHRK?=
 =?utf-8?B?K1NZUU82azNtS3hKSmJYL0c1WWdQeUxOTGVvVXpwU1J5aXo5eDFpME5hQnZy?=
 =?utf-8?B?R21pNnZwL1pqT3p2YSs1Wi9zMmZZWHM5c1pudm9jR1lwNmhaNktTNXp1RmJL?=
 =?utf-8?B?MHhFVnNRS2lVTVE0NlFLZWs5SE9qMytwM2hmczZiQkFkRFZXQk9EYmtCbUtu?=
 =?utf-8?B?c3U2d0VYcHl5V0VLUHF4M3QrQXZXcDdleDNlSlI5V3dYYVBPNWNlRXMvekc4?=
 =?utf-8?B?STJncUtEMFZ3S0VPbDhrN3pQR2wwZ3ZnMlVGR2Zuc2U2SDJ3MmtGNWRwOVBI?=
 =?utf-8?B?Sjg0aDBsd0ptNytOTDBVazM3c1Nta2x2MmEyRjFqL3ZpclVRYWNVZTQ2YXZo?=
 =?utf-8?B?MHNaSnlDM1hpZWV4cHFtTUh2d3l3NEZjSlpQWGhQd0tUTkZJNTd4ZlFWYVRC?=
 =?utf-8?B?dFlSRktRR2xTUVhoTFI0WWNVRmhtdGNYUC9WUitZaFdQbk4vNDdWM3VKa0pW?=
 =?utf-8?B?VytmNWIrSlVuejAwSTBnaVZoREVCMmx2b3BzeklGZWhhSmdOelZJUFZ2d3hL?=
 =?utf-8?B?bEdrcnV4RUFkRDBEd0lnU044QjNaMmRRNUtjbVRjSmJoVTJJZ2dLb3dsY2dt?=
 =?utf-8?B?UXU4KzFPZ0N5Ni9HMTFEOUNQWVYwaGF1UlA2NlZVcXVha1FNd0dFRHBMaDJK?=
 =?utf-8?B?aEZKekh5cmI2OVU2QjcwUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016)(921012)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUtCZXV6dHlhM0RJTGlSWDBlRXd6R1o5OHpMYVBmS1M4bGp1NkJFS0lLaHc2?=
 =?utf-8?B?U1NUaFVFM2RSTjdyMDdtejg3OEtiTjJZTWlXZnAvdDhqRnZxZnVxYjhqMHhy?=
 =?utf-8?B?YWEvRXlEMTBnSDlBdHgxYWpJUzI3T2g1YzBYcHB3RUZZcWdjMlZydDBqeFZE?=
 =?utf-8?B?QUFJcmN3VWxnZXJ1clBhMXhJNmR4a3Q1TkJpYy9ER016M1RJTldXcUdadlhN?=
 =?utf-8?B?c0t1b2piNEl3d0krL21PTXE5TFhXeWh2eTcwVlhDb3h3L3YwRDh1a2NSeEhK?=
 =?utf-8?B?b2dkZ1ZBUEJkOHJNMzZoMHk4NXRoUkxib3JsNTVrS2FUY3c1SW5maFJxNlEr?=
 =?utf-8?B?aGtYU2p1aERlalR6aHhOSXdlYVEwY0FzVGUxSklDTGhoLy9CV2orei9qVGZ0?=
 =?utf-8?B?RG9Mc3lrWnoxSW40MmwzRnY1bVNMTm9ld0s5L0tpZ2QyUTBOUnJhdkJ1TDhG?=
 =?utf-8?B?L2R5SlZNRThqNGxIKzUxU1RGcEpvZUh5bk0xdlVNQkJiaFNnanhRZVpSVE9i?=
 =?utf-8?B?V2t6a280bVZlbjdCMXZSdUNLV2Z3ZGptaFZVQVgwY0p6SlgzZFAwV29RekxR?=
 =?utf-8?B?ZjMzcmd3VkNoanRzbHMvdEtGSTJKbkhRcSt3U3hLaTR0UlVPeVZHbnFzQSt0?=
 =?utf-8?B?MVc0Z3FEWm1FZG8wUEpDZnNrS0J1NEdlZUhkdUJGUzRHODRtMFhyUzAyNkxR?=
 =?utf-8?B?MzloK0FJZTVlSWpWWUlNbkFEQXlmaUd3eURrb1hBR0laTTYvbnFrYVJqS1Ry?=
 =?utf-8?B?RHhLR2srZW5YOHFtTXo0Y0RlTEhTVkhzeVpwa1FWcmVBODMrMmFSU3QzMWZK?=
 =?utf-8?B?aVZESHM5MVBtZVg0SnIzQ0xxRFdIWmZBUVUweFF0TW55b2JCOFAxWWJ1dDlX?=
 =?utf-8?B?Y3lUcGRNTHlMMU9PelhzY0srRi92N3M0UG82V0pmdXJVY3Z5RGtiTWpWKzRz?=
 =?utf-8?B?bEFYUjhMaGJNbUwvUXNQa1hMQWg1MUdEbXdwNStFSDFEdkUrYU0zdkFjYXkw?=
 =?utf-8?B?T1JBM1JvUDFLRVgzSmFvT0N5VHl1ZnVzZGZvd29rU1RQWExCQVJiVmp0ZkN5?=
 =?utf-8?B?ZVZmamV1Qk1CRFo5T01jQWVMUEtwYmhRbFRQNFpma1ZPM2VnNkI3Ujk1UkF5?=
 =?utf-8?B?c1pya0c0UDMrTHpUNTFuQXdRRmZMLzZJYm1SYzVIcEtLT1pTR0o1VUY5OVVj?=
 =?utf-8?B?dFlaRnY0NkFJcjNHUVNLYXYzTWNuQnVRWnVxVFR3OUcya3ZNbDdzYjNwNnRS?=
 =?utf-8?B?QkpwL24xQXN3c1FlTmdVdkJ6dDJBMzJlZkMxRlRWMTR5SHM1MkIwVHhISXNI?=
 =?utf-8?B?NSs1QTY1bUhOQkw0UFM5NFJXWVRPclcwMXEybXNGUmwvKy9PN1JlbG5hR1lr?=
 =?utf-8?B?SHV6OXQvYVFEWjQ3azNaOVlYK0t1M3RTaGhWaEhkWFF4a0xVNm5QeXpxbDht?=
 =?utf-8?B?SFh5ZG5lMTRuc3FPN2FiNmFyMDhUZHRrb3owb2UvS3J0ZXVnTXlRdGtDWWxH?=
 =?utf-8?B?OEtadEVONnU2UjViSjAzYzFvOGZjYzNpWEJVRzFadjEvVWNTWTYyZU9GLzVV?=
 =?utf-8?B?QUVKczA2dG9PUjVEejVVcUVWT0JrVG5mWEdHWHNTWVhIYitod21YZ21yNERz?=
 =?utf-8?B?T1BjOW5ja09Zc2NrKzkzK0d6ZzVKNzRYaDVQNkFjVmkvVzVySHBqY0ViOVQ5?=
 =?utf-8?B?cW9RZjZBbS8yamdZWXZWQWYwOTlnRTNWMFRxZS9nekNMMFpGd0Rpd1hwMitK?=
 =?utf-8?B?dDY5c3R1WnZoZDhqOFM2dFZnRkJKV0ZBU2tobVZWUFM3ZWplTit1V3RweTdV?=
 =?utf-8?B?enIyR25qSTBTWm94Vi9IRFlNMmY0d0czRVBETS9DU1FnNjBtUk9kdGx5YVZT?=
 =?utf-8?B?bzEvZzlQOEtrNnQvejR4WVkvWlZPTFZNNkJ6YUZudFVDMHJpak1NaWQ3VmFi?=
 =?utf-8?B?dVFSU2ZWUG1kQ1ZXVVNXTFh2em82UldFVk1wUXpCcjFRK1BRT1IzQlZIOS90?=
 =?utf-8?B?TU5ZM0xTRmpCdE5hdnVuZFUwcXR1RWZWWXppSUtQcUVOYWsrNjVxM3ZVSm1C?=
 =?utf-8?B?aGRPTUk0dXZYS0IwbE5jRWxETjBnYStCblpYZnorVmpUQjl2a1o2QnJoSjNq?=
 =?utf-8?Q?/tcADwgpvlA+00Mdz9gQfpN/E?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9299.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dce5b4-bf42-4c78-f0ea-08dc8ab0348c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 07:20:57.9826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQfa98xBwSoE00fzqbrkMyltYrrrkmj8mGeJ9L97SJ4uZeBXR9okOtQivQLuHYJzehj7tGqNxFocc/Dnx5V/aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10735

SGkgS3J6eXN6dG9mDQoNCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwu
b3JnPg0KPiBTZW50OiAyMDI05bm0NuaciDfml6UgMTU6MDgNCj4gDQo+IE9uIDA3LzA2LzIwMjQg
MDY6NTgsIFZhYmhhdiBTaGFybWEgd3JvdGU6DQo+ID4+DQo+ID4+IE1pc3NpbmcgU29DIGNvbXBh
dGlibGVzLg0KPiA+IE9rLCBJIHdpbGwgdXNlIGZzbCxpbXg4ZHhsLXNjLXNlY3Zpbw0KPiA+Pg0K
PiA+PiBTbyBubywgdGhhdCdzIGp1c3QgYWJ1c2Ugb2YgRFQgdG8gaW5zdGFudGlhdGUgZHJpdmVy
Lg0KPiA+Pg0KPiA+PiBOQUsuIERyb3AgdGhlIGJpbmRpbmcuDQo+ID4gSSB3aWxsIGRldGFpbCB0
aGUgZHQgYmluZGluZyB0byBkZXNjcmliZSB0aGUgcmVhbCBoYXJkd2FyZQ0KPiANCj4gU3RpbGwg
bG9va3MgbGlrZSB3YXkganVzdCB0byBpbnN0YW50aWF0ZSBkcml2ZXIuIFdoeSBpdCBjYW5ub3Qg
YmUgcGFydCBvZiBleGlzdGluZw0KPiBmaXJtd2FyZSBTQ1Ugbm9kZT8NCj4gDQoNClRlY2huaWNh
bGx5IHllcy4gQnV0IFNDVSBjYXNlIGlzIGEgbGl0dGxlIGJpdCBjb21wbGljYXRlZCBhcyB0aGVy
ZSdyZSBtYW55DQpmdW5jdGlvbnMgYW5kIGFsbCBvZiB0aGVtIGFyZSBhbHJlYWR5IGFkZGVkIGFz
IHN1YiBub2RlcyBpbiBTQ1Ugbm9kZQ0KZm9yIGNvbnNpc3RlbmN5IGFuZCBoYW5kbGluZyBwbGF0
Zm9ybSBkaWZmZXJlbmNlLg0KDQpJIGd1ZXNzIHNvbWUgb2YgdGhlbSwgZS5nLiBydGMsIGNvdWxk
IGJlIHBhcnQgb2YgU0NVIG5vZGUgKHJldXNlKSB3aGlsZQ0Kc29tZSBjb3VsZG4ndC4gZS5nLiBw
aW5jdHJsDQpEbyB5b3Ugd2FudCB1cyB0byBvbmx5IG1ha2Ugc2VjdmlvIHJldXNlIGV4aXN0aW5n
IFNDVSBub2RlPyANClRoaXMgbWlnaHQgbG9vayBhIGJpdCBzdHJhbmdlIHRvIHRoZSBleGlzdGlu
ZyBzdWIgbm9kZXMuDQoNCkJUVywgZXZlbiB3ZSBjYW4gcmV1c2UgU0NVIG5vZGUgZm9yIHNlY3Zp
byBmdW5jdGlvbiwgd2Ugc3RpbGwgbmVlZCB1cGRhdGUNCmJpbmRpbmcgZG9jIHRvIGFkZCBleHRy
YSBwcm9wZXJ0eSAnbnZtZW0nIGZvciBzZWN2aW8uDQpQbGVhc2Ugc2hhcmUgeW91ciBzdWdnZXN0
aW9ucyBjb25zaWRlcmluZyBhYm92ZSBpbmZvcm1hdGlvbi4NCg0KZS5nLg0KaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC90
cmVlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9maXJtd2FyZS9mc2wsc2N1Lnlh
bWwNCiAgICBmaXJtd2FyZSB7DQogICAgICAgIHN5c3RlbS1jb250cm9sbGVyIHsNCiAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteC1zY3UiOw0KCSAgICAuLi4uDQoNCiAgICAgICAgICAg
IHJ0YyB7DQogICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy1ydGMi
Ow0KICAgICAgICAgICAgfTsNCg0KICAgICAgICAgICAga2V5cyB7DQogICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy1rZXkiLCAiZnNsLGlteC1zYy1rZXkiOw0KICAg
ICAgICAgICAgICAgIGxpbnV4LGtleWNvZGVzID0gPEtFWV9QT1dFUj47DQogICAgICAgICAgICB9
Ow0KDQogICAgICAgICAgICB3YXRjaGRvZyB7DQogICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9
ICJmc2wsaW14OHF4cC1zYy13ZHQiLCAiZnNsLGlteC1zYy13ZHQiOw0KICAgICAgICAgICAgICAg
IHRpbWVvdXQtc2VjID0gPDYwPjsNCiAgICAgICAgICAgIH07DQoNCiAgICAgICAgICAgIHRoZXJt
YWwtc2Vuc29yIHsNCiAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNj
LXRoZXJtYWwiLCAiZnNsLGlteC1zYy10aGVybWFsIjsNCiAgICAgICAgICAgICAgICAjdGhlcm1h
bC1zZW5zb3ItY2VsbHMgPSA8MT47DQogICAgICAgICAgICB9Ow0KCS4uLi4uDQogICAgfTsNCg0K
UmVnYXJkcw0KQWlzaGVuZw0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

