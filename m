Return-Path: <linux-kernel+bounces-327494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD0C9776C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C241F267AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB81D31A9;
	Fri, 13 Sep 2024 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="SvkJlMf3"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2C1D2F6A;
	Fri, 13 Sep 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193293; cv=fail; b=rdR5o92pMzSloMfu5u4aUerfKqgCFlk1Z/WDEgqrWNCCdXl32+dfUL9dE+CwkzzFOlg0KHfKEk1gcZrs2EOw16sWxJ1bbdASBiIIBkCw5iw/X5kp1eN/zUoLzzxAzVCmPB6lk8QCPhLW3Dv9QYXyB0AFA9IzoK4JPyyhyzJOMBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193293; c=relaxed/simple;
	bh=w395zds5duWlafo1zmvJgHCgx+L2S+1v7rszNZbj4yw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eXXlz+vDbUklZYA6jaZdIZBYMKu6XR7bgM+H/2iEc62KP2ozjtJn9kA7IZbYE7lfBkugUDjpARS7GvDtcj6KbQZL5ixgWwqeTUSQnvCVv9znpqcgCgYz1lsy80RCyusEhzOuRiNWIco87Tg3y4PfYpbt1XfJ1yJyS25NjuAoxDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=SvkJlMf3; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGE/xI6CZZQxl7hQtRU1C811w7qXtxIF0v9BQ0a2xxSVPSrrZz4UJIaaD4Thy+BUPx0NDOJVsrbjcduUVa6bhL74+RU1bfYHKnMtYkDb5vzbIpkDkCbMRtgn9Vaq4il0+XbrfBhu2mnMhhrUvCDXK8LWoTFdi+uaMWA1MVEXo12JK65QfdkGtjhAZfOILj6tlECpxxMpO3tPjB113JfC75Py8wKMSx4XSjpW/p3bLdooocjLGjStNOcbbPkQrd6xObInyWNQPX9pEKasGPqlskkrvJMzsDp6lfI0k6CdojWxkfO7x4BiypLL8TMVziPydKkl2ZHBSmscwRnbDNq4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w395zds5duWlafo1zmvJgHCgx+L2S+1v7rszNZbj4yw=;
 b=a+V/BL6A5qnPJZJIEuCPs6buolqhQx62k9xf5SE3R89FwglFyvWtdx+VRYQDQlamW+lE5Vpfyj9rlAPPZgr8rdxynEp5HfEys2nB3BrUvfDQa836NLGoCochketC7g4JaQFKuxcU3E4jvIQI+xI7IJJ9WFG7XA2D1T/r9RajAojNjvp0mbOE/VSg0miyLlrBo0UzKknrE/eEEcDXYADSu7x21G4rLk9lH/ZgNB5btO+TkRspu0YMV75x0ROVC/l1Zokj/ZiA8o923g6rKHdk6+3xvTaMf1OgIT0C707zT651WauRNS5KdHuknR/wMRNvYD2bpXiIPDhTepbbMwEC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w395zds5duWlafo1zmvJgHCgx+L2S+1v7rszNZbj4yw=;
 b=SvkJlMf3hLFUH6dv09/z+6Y4q72AxOvi9JAaqOWiBLzQH0HQJTdb5NPmuPH6q+ldd429pWAyxKTzTG+iPUNfG2/E9/1H78n/NsjqYJjpIFrIU+W756pyS4XCutjLPooQuQ3XkrbcG/+f7OvKeC6smp+1JgLq9TqzEgb0yL7siXNlp6KiaJawbrH1v1GvYtUYXgZG0RnQbtTvIaCbc5u4c4+tb7oddMI8uzTn/xa/b88h1vMzWu6y4mtau7nh7DYK5UVl0qmiOWvMPciuJXFZqeeUI6QuEJIyzgBHdtwzYB0JrCbmVQCyo7UuCe+JtfySCGe5OlaFlVQ7o/R/cbSw0w==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by TYSPR04MB7189.apcprd04.prod.outlook.com (2603:1096:400:478::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 13 Sep
 2024 02:08:06 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 02:08:05 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506 for
 CPLD IOE
Thread-Topic: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506 for
 CPLD IOE
Thread-Index: AQHbA0UHYnKTipIy9EyxznCx6Ypb1bJTa20AgAGQKZA=
Date: Fri, 13 Sep 2024 02:08:05 +0000
Message-ID:
 <TYZPR04MB5853B6611AF9AA5C3E5AE778D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240910054751.2943217-3-Delphine_CC_Chiu@wiwynn.com>
 <ccef1d90b9a7eb343e99afa2c6cd6ea7407b0541.camel@codeconstruct.com.au>
In-Reply-To:
 <ccef1d90b9a7eb343e99afa2c6cd6ea7407b0541.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|TYSPR04MB7189:EE_
x-ms-office365-filtering-correlation-id: c05ddee1-f3ae-4d66-7d4e-08dcd398e7a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekpya2FhSCtqTzNVMHk4enVHUDU1LzlodzZYajl3Z3ZTSVhnZjBldkg2bzhx?=
 =?utf-8?B?Q1h2ZzZiZ29CZEdOVy8wVDdIdisyNUFCekZuS2crWkpMV1hVRzNqcEZzL1pB?=
 =?utf-8?B?MTJKZjg3VGFvdlRVYlBCdmV0TzNnNmMvYXF0ZEZMRFFmM0lWc2N5OVhJdzZw?=
 =?utf-8?B?R2VnQ2FyL2FlcGNjUStueEFXdytwODVxcG5uVnYwZlRuNEFnOG1aV3hLdXVa?=
 =?utf-8?B?NXVwSGRkcnZ2SGNsckxHaTJtc245N2RVdXRPU1JGMnFjTU5QRmVOUTY2RmV6?=
 =?utf-8?B?RmFjSnk2ZTliVEZodmFrbXJuVEx5R1lPWkJBcDJoS21zTGRIRW1oMi9GMVVY?=
 =?utf-8?B?UDJtUXN6YytiOU5NWm44VDhPbUNFdDdOZFJVYVJXR2srSW9vNkdYc2tCcm8v?=
 =?utf-8?B?RDVBSzJ0VTJ2Zm9WdkU2ZDJmWkRGQjZheStyNFB3VmQ4SUFFRDFwSFJQVll3?=
 =?utf-8?B?QTlsTnFsblpzd3VvVkFMZHkwMVFIVTcyK0U3VDdMVzltOEgxM1NWRE4xTHJQ?=
 =?utf-8?B?elJpOWRLOXJSdFF3V1hIZ2ZybGlwcUQrd3dkYnlKcUpVazlHK0E3VlZ1dHFN?=
 =?utf-8?B?Qi9QenZrZzdxN1RneG9JNXZoSCszOWFpTDFuNksxbWZlZ1BDK1JkL3BVU1FI?=
 =?utf-8?B?UWxETXRTVDBNVDljdnlIWWVOT3JLS29ZY3pVV3kzL3ZhUml2czFBc2U3N0wy?=
 =?utf-8?B?dEYrNVcrcUtVMmRmd0owS2JZZGlDS0ZJV3JRT1hHUWdSRi9WN1dqeUZkMGxS?=
 =?utf-8?B?M0YrbDBhUjJpZk9RNFE0dFRLVFh2dE0vNVNGT1htOGNHeTZUUnZZQWluL3Uw?=
 =?utf-8?B?NGFnMmhkSkMvL0w2RnkwMHVyQnpVUzJlOTAveCtabnMvVXFrb3h3ZVh4Wmgx?=
 =?utf-8?B?RG04dE9RRmg3MHpZNEVXY1RiWEpuNy9NWGRIQVNMZUFYM2VGTUh5bk1Jd3py?=
 =?utf-8?B?c0hjM3NTVVM0UzNDMFJIdnIrQlMxYmROMWhVSExDd2RGcDJkZXVwejJZaGhq?=
 =?utf-8?B?RktWeW1qbTlPN3BIT011MVdrRXhxd1hRK3VyK0FwQUtSR3pDaXlia1pGODZ3?=
 =?utf-8?B?a01qZ3FNcUUxU0R6a0RhWjVrRHJQM0VsT09DWmptQTdYWVc5WS91QWk1Rm4w?=
 =?utf-8?B?TWdpV0h3NHhyUC82YTl0YUgzNmw0dVBjUGx4aGxhVXZzV21NNWxKNG1BZFZm?=
 =?utf-8?B?SDdBeHA0STNYajkrd3J4eStwYVdJUDBHcHhvQ21FdzVCWmFUV3F1UHRIOXBG?=
 =?utf-8?B?QmhHVHZ1VlJhK2lNbWdPSCtjcWRCWkNpa2dMVGJPVkJOeEp1Mi8yV2lYc0pJ?=
 =?utf-8?B?b2pyNGcxcVdvd2hrbVNlMzVBNytMMzIzREpNNUhxK0JXOEY3VmxIV0NzbEdQ?=
 =?utf-8?B?OHluWTNFbmtkYlErU293M2pta0RmZUcyVGF6ZCs5RWthTzJYQWQ5bGpaQlJo?=
 =?utf-8?B?bFRZNXN0clpWbmowVlFSN1pvTGFsbytLc3RXR0FsUVhlR0hnZTN6d0k0STYx?=
 =?utf-8?B?UjFLd0xKODFENXBjSVBmNFk0S2ZsUHNwSXZwRnZmSW9lUUhQaEhVc3RuR0dI?=
 =?utf-8?B?TFZ1dzlYZHRxaW4zM1FhK1REQzB2Wkhud3B1eGVLL0tSa3dqM2ZiNVp2Nzd6?=
 =?utf-8?B?eDJwd05md0h0SWJRdDdzL2Q1Mm1McFR2MlVpVkkvQlpvbjhmYVFsUkxrZGw1?=
 =?utf-8?B?bkJmS2RpUFp5TjdkTFZEaEs2REhrTDd5cDJRU21zalpqc3g3anRHeG9SV1Uz?=
 =?utf-8?B?MVg0SzNhcjEwLzhvY1hOeGtQZUovTHhQY0dBR3F1QTE2ekNnbFFOV3Q3UGZm?=
 =?utf-8?B?MzFaaVhDeitTT2M1czhtaVUwVzZueVV3ZUpsS2IxNzVOcUdCYVRVTThpLzBm?=
 =?utf-8?B?Yks2bUMzeE1WRGxBaEhPd3NLMk5FSXdXV2J2QzVybWtLNHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rjh6dFVucnE0T2x4ekdrVFBRWW9MQmxyOC94ZnhpbktmdGhhWC9lcFBxVWI5?=
 =?utf-8?B?cVB6U3FRMDhjUzRmTjVtbUFXTjliMkJZWS94cXM1QmF4SDF4MEd3d3AvY1Zx?=
 =?utf-8?B?dlVBRy9wUXRrTnQwUU1GQjMvZmVQb0R0cGNXRnk2aGhwc0lYb2gvZ1drK1Bn?=
 =?utf-8?B?ZFJVTmNSUkpVdE5kOGtkSXJ1bzh5Y1RSOGhZUDE5M3hhay9DeHZSbGdRd3Nj?=
 =?utf-8?B?djhXb2hqcDd4K2dHL0U0bm8xKzBMbkliSDhXMHlMTlpLTXRFeHNSV0dXc1Aw?=
 =?utf-8?B?aS8vWEpXNXRXaVhqc0FxUi9CQ2tFVGlzdWZTQU5LL1EyTnhUd1BSWVEzanZ0?=
 =?utf-8?B?Wlk4Sk5ndkZRczNKS0N1M0VYK3l1WWV1eng2QXR3bytKSTlDd01Bcmh0OVJG?=
 =?utf-8?B?ZS9kNGhtWWxFT05kUU5LWi8xdVlPYTcwUDRSYVVnc0dSNEtHakdWZmtuK0Vl?=
 =?utf-8?B?azJKc3lnSVp1enJXSDF5VHQrek5xcHJnQWhRbHExNmlOSy9XblZNYkt5NEd5?=
 =?utf-8?B?UnQ3RnJoUmJJQUVSaEprN3VrNXpENVlGTXNFSEpoSTJVem45WW1GM3dXbkZM?=
 =?utf-8?B?UU1sdVI3c2ZDRm4xcDM1ZTMwdGROeGcwR0xLeTE4allZNGpZeVp2MkZOTTJS?=
 =?utf-8?B?UE9WNjBucmxwcE01QnJaZDNLS2liUGUxMGZTVUhKVldGV1phNy94eUpKMjVV?=
 =?utf-8?B?VFNWc3o2UDBTblhGNSs4RXVia2w0VWxNVWdscTd1WEMvK2gvOGg5S2Z0bmR2?=
 =?utf-8?B?WDdXT0dvaDBIbDJ1OEV6b1doNzhLNlBic0NpQlNhSnNlYkxhV3pLb3ByaWFU?=
 =?utf-8?B?M2hUcnY2NEVtRmRRTmd0SVdVVWhVbWg1TCsrQkpneURLSlRra2lGeU9qOEt3?=
 =?utf-8?B?YTVhNGRySVVGeVNzZDNTeHFrRGRkVk8wQzRJMm9qR2ZXUDlTRGxNdXVJVGt4?=
 =?utf-8?B?WndpMUp1TFhuYlFRUGFQSWZvcVZOSktKUTZOaWd1c3praTlnUEJ1dXJkNjFV?=
 =?utf-8?B?Rks1TWkvMFhHNmZpM0Z3bFdFbERXaXNQMEJkRlJrWGNqUi9BK1JDUDV5bEJ4?=
 =?utf-8?B?STdOWXB3SXc3ZEcxdzBTL25uNTJyM0lSSm1naUFrSFl4MVREc3dWSlBXeHdl?=
 =?utf-8?B?Zll2OTNISVVLdmN0TW1mREJQd0VqeXAxTDBuUDBWa3FHblp4TTdhVFdWUHBY?=
 =?utf-8?B?aUk0Witham14R3BXT1Z6K0xTVXJ0a2J3U0EwclZhY3RBTDNGcVdOQm9zU1pz?=
 =?utf-8?B?SVdzWDBUbk5iNHNzaHpMZnNZZ3ZtejRLWHBZY3BKS0Jib2J6Y1N6WU51cldB?=
 =?utf-8?B?TXpqaWJzc1ZWUVdlWmhhWTZ3SHc2Uk9sN21tS3VJekJlTTlWNXEzYVE1Z1lJ?=
 =?utf-8?B?YjJhWHBhWmJtVGp4QlNzZlBsblJ3VGZuRUEvaVBTTTF3dktsTjdNZlI0a0Fj?=
 =?utf-8?B?MlN5MFdSVFFCYVJxQkdZcy9PL2JqaTlIOHBabVAzeWRXUmpHc1ZWeDZXNm5J?=
 =?utf-8?B?UlR1dWpTY3VpSWJ3dXQwVTZzRGVaWVVNWG00d3h6ZXduajFEYUFXbTNtVlc3?=
 =?utf-8?B?WGkwUEd4ZWo5dzl2V21QNmtoTjhwaURQRTZUQnRLWmFJSHU1M05WVktYTFls?=
 =?utf-8?B?WHNRejRhWUx5RzV2NGtJeFlLQTlUZDZ1S0xFKzlEWlEvRnM3L3VtYU0yM0JP?=
 =?utf-8?B?NlR4VUJIb3ZVOGM2RVZiOUlvMGEzcEF2bGdiRFJxcGRsYWY3MG01Vzc4L1Y2?=
 =?utf-8?B?SWxMRVJybHZDVGh0ZFhqVFFLUTZ2eE0zMklKK3pXYzNoSjRTeC9KbVkxaWpC?=
 =?utf-8?B?enh1T1JCL2l0YjZVRHVBcFVSL1F2ZUpmTGFRMCtyWHBmMENvMjBHWkNDOGlR?=
 =?utf-8?B?WG9keVhicmt5QjNhcTlTZEhZdUdrNUpubW9IdnJhU1JwalBHbEo3SmoxMDda?=
 =?utf-8?B?d01CWklhZXUyYjQ5c2F0OWFSdERpRzB1L3BxRGpVOFk5RFJDRTJTOVVucWp4?=
 =?utf-8?B?M1BCUVFCZ1dFMnNFaW5LL2U5MHZvOFVPMnhZRjcyWXFHOWdrM1NyUUE4Ulov?=
 =?utf-8?B?c3NjakJLMkVNb3hiRDNoREh2Zm0razBYNmxPZGZlZGRBRmtEOVRkK2FGeEI1?=
 =?utf-8?Q?a3UMBPo41Ayt79nF4ARG/bTLW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05ddee1-f3ae-4d66-7d4e-08dcd398e7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 02:08:05.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2Rx5yOazj/Jqw3eLBLX4Nzn+HSUenBdqUCn14nE2fvEpr2Mfb7ZS+Pu4UsEQYQToLf/kYRAP0AK36pCCj8YfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7189

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAxMiwgMjAyNCAxMDoxMSBBTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8
RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0
QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0
YW5sZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1
Lndpd3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3ps
YWJzLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxIDIvMl0gQVJNOiBkdHM6IGFzcGVlZDogeW9zZW1pdGU0OiBBZGQgZ3BpbyBwY2E5NTA2
DQo+IGZvciBDUExEIElPRQ0KPiANCj4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+IA0KPiAgW0V4dGVy
bmFsIFNlbmRlcl0NCj4gDQo+IE9uIFR1ZSwgMjAyNC0wOS0xMCBhdCAxMzo0NyArMDgwMCwgRGVs
cGhpbmUgQ0MgQ2hpdSB3cm90ZToNCj4gPiBGcm9tOiBSaWNreSBDWCBXdSA8cmlja3kuY3gud3Uu
d2l3eW5uQGdtYWlsLmNvbT4NCj4gPg0KPiA+IFdlIHVzZSBDUExEIHRvIGVtdWxhdGUgZ3BpbyBw
Y2E5NTA2IEkvTyBleHBhbmRlciBvbiBlYWNoIHNlcnZlcg0KPiA+IGJvYXJkcy4NCj4gPiBUaGVy
ZWZvcmUsIGFkZCBwY2E5NTA2IHRvIHByb2JlIGRyaXZlciBmb3IgdGhlIENQTEQgSS9PIGV4cGFu
ZGVyLg0KPiANCj4gSSB0aGluayBpdCBtaWdodCBiZSBiZXN0IGlmIHlvdSBhZGQgeW91ciBvd24g
Y29tcGF0aWJsZSB0byB0aGUgbGlzdCBpbiB0aGUNCj4gZ3Bpby1wY2E5NXh4IGJpbmRpbmcganVz
dCBpbiBjYXNlIHRoZXJlIGFyZSBzb21lIGJlaGF2aW91cmFsIHF1aXJrcyBvZiB5b3VyDQo+IENQ
TEQgaW1wbGVtZW50YXRpb24/IE5vdCBzdXJlIGlmIHRoaXMgc2hvdWxkIGJlICJmYWNlYm9vayxw
Y2E5NTA2IiBvcg0KPiAid3l3aW5uLHBjYTk1MDYiLCBidXQgYXNzdW1pbmcgZmFjZWJvb2ssIGZy
b20gdGhlcmUgeW91IGNhbiBzcGVjaWZ5DQo+IA0KPiAgICAgY29tcGF0aWJsZSA9ICJmYWNlYm9v
ayxwY2E5NTA2IiwgIm54cCxwY2E5NTA2IjsNCj4gDQo+IFRoaXMgYWxsb3dzIHlvdSB0byBhZGQg
dGhlIHF1aXJrcyB0byB0aGUgZHJpdmVyIGFzIHJlcXVpcmVkIGluIHRoZSBmdXR1cmUgdGhyb3Vn
aA0KPiB0aGUgbW9yZS1zcGVjaWZpYyBjb21wYXRpYmxlLg0KPiANCj4gQW5kcmV3DQoNCkhpIEFu
ZHJldywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KSSdsbCBhZGQgdGhlICJmYWNlYm9vayxw
Y2E5NTA2IiBpbiBncGlvLXBjYTk1eHggYmluZGluZyBpbiBuZXh0IHZlcnNpb24gb2YgcGF0Y2hl
cy4NCg0K

