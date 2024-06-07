Return-Path: <linux-kernel+bounces-205216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC46E8FF990
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637D228751C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8ADF9FE;
	Fri,  7 Jun 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SAyuafIp"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD033EE;
	Fri,  7 Jun 2024 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717723727; cv=fail; b=jAVTU+EXFF1UkvvhYZgLFjzw7NUqbw08/+dTQhuFNhtyjVJs0SYZTL8zQgRqyqb+xhE6yi0OKDt8MPbFtgyxHZr471tWT1szlvnGoq+ugsYVbTrGGpCt9nnXYhPTsJHFbnJ0HSSCxeOlmYbZiv9D6YlJQlyZnCQ1sE957q20hsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717723727; c=relaxed/simple;
	bh=PTGmFIFiaGhBOg9C+BMmUKSu+hAwwHGtdygzrIZ4H5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fc7t4I+5+scNymAG9ZaZ4mNLR8/7jBywyKNWOZBeZpIxgmzI+an/zUljQA4f1F+FSWlGAR2qdOSYJI87siBOteeiYa/xWMmIjVrctvIW/2BB7QpI9QXel6aWcC9GA2eHN9dhMAXoZkyl3x6+0GS5Rl48vNj9zHwf/S1OTQWAPDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SAyuafIp; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRn2W18zGQMdV78+ZMf0BZiin/AAFoXVlOB6SrZxRVIESM7ueHOTuEN+sOU0A9QDBOQaiL8rtzG5PphxoTcNWMPmfmPo9dMo9/SOF2/2ufSGLooEWHeDSMDjjD+lNafyB7nT+v/5M6oqYuaDrVFwS8PpoUZrYAdrnlr4XkJ66CiaDfYU211diwFuu/yuMFo+nKTS2KCVV7X3Zii/EfL2L1bVpouIhhf9dyccqZENI9bmVGmXUJrNg0nXFJ8uwrBsvs0CZ4J3IOPatXttdF9rm+hKjch/rhJjMYAB72EtkZfxiyo4j015m3fSrLxRWjD8uLEgqMwlyPqe6KvwV9xj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTGmFIFiaGhBOg9C+BMmUKSu+hAwwHGtdygzrIZ4H5k=;
 b=VHtDn5YJhvhauDerWro4iNu0W3faVCoQdDGfTJRbYTO8/7KhvMbgB6pbEcc8QbDhTWodhQDh6kDX53pk8v6SnNdL5kFGI9+BpG4QAPMqBaVob0y+jO8yFkT4kRc21nZl/a1j9u1FpPUmIftdEamuBQWS17ryyiNSoQyksNyuYaf+ocpIijJU2a+TUCApvlsPSSCRUUyIsaX1zg71SUffr757vFnrC0waGR2qImIhQiE7Z8iskAelYvk2IhD+QfdN3BwRLIrn2d4Vm9nPxG2kSkAH57eGSexBf4lUzOKAbQdYhdRC1Oe4CnZFqmjbshhB7Y60Ej+C7SlL572mymY0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTGmFIFiaGhBOg9C+BMmUKSu+hAwwHGtdygzrIZ4H5k=;
 b=SAyuafIpTI0fu01MY87ag7L6dWAawVkIoUMyX+F64FipQaL6XEDhgS7QvmDbYJng+W1xqJ3z+FQJGDh9Zrvzz4VPTF5RRUkKKzi7MobXNHEg0eGqTF62dJ9gyZJXnNoCR3eaUTezVtXQZPbHdxI0Bjj0MxOKKPnoDaF2M3PKo3w=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS8PR04MB8326.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 01:28:42 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 01:28:35 +0000
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
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH 1/7] arm64: dts: imx8qm: add lvds subsystem
Thread-Topic: [PATCH 1/7] arm64: dts: imx8qm: add lvds subsystem
Thread-Index: AQHauEH+uWtNhufEvEuOQLlQzSS/pbG7gpwA
Date: Fri, 7 Jun 2024 01:28:35 +0000
Message-ID:
 <AM6PR04MB5941C0BBD0A64A9AFDD8EC5A88FB2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
 <20240606-imx8qm-dts-usb-v1-1-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-1-565721b64f25@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AS8PR04MB8326:EE_
x-ms-office365-filtering-correlation-id: 9d1be711-59e4-4167-6655-08dc869126a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bW9nbDNTTTN4NnNMeWI0b3VIc29WZnpDOWg1MGVobzhsdmV2RklWMG1NNXI2?=
 =?utf-8?B?THBQeVVFQlBOTnFLaUxRbUU3NDlRVVZvYnNla0FyMVh3S29NeFpiRGoxbk13?=
 =?utf-8?B?OEFrV1NyTmNXazk4S0R5blNUL0pSYnU0Q3dGcUsrNzAzaHJ6REJwSU1mczdt?=
 =?utf-8?B?MGpxTjF0dWJJTUZwS0d5WXpRK3dIeGliSTl6akZ3Skp5NURzcklQWGtKcU8z?=
 =?utf-8?B?dEdlMlROUm5YZm4ycTJQWFNLOFlFMzBOZThvbjhFQkU5QlRPd3FxY0syV3pN?=
 =?utf-8?B?V2VkdlFtdkQyY0JKZnYrYjlGc0oxRkZvMURYNG52WDJrcE91UGZGT3JGNFlH?=
 =?utf-8?B?aUErSEtXL1g5TTlEQW1oRFQzVy8zS2xwc1VhSXJCSVNYc0cyQ0hVV2RmY3VH?=
 =?utf-8?B?YXRlVm5TUnF5MExZZDV0ejJoeFRSOHpXajlwYlNkcFJQaUJLYU5OY1VqWTdP?=
 =?utf-8?B?OFZkdlZCNDJodDEzdDlYbkFxMW5DUGhoMjFQLzdnSFRwYUFTcFlHU0ZJeWcx?=
 =?utf-8?B?SFVZNHhNY0dxMEV3UURxMU5sb1VaUGlZOVJmZ3FRWmZCaWlxZitYWDcvdkVk?=
 =?utf-8?B?dWZXUzY4YzBHSDhFWWVRZ1ZremVISis1M29Md2xXaVJLNnA1UjBRYVJRNy9l?=
 =?utf-8?B?M1NVczFBbXl2bmtaNmlqWnZ0a3BVOWpyZ0FhSnpUSjVXeDhCUG5ZV1JoK25B?=
 =?utf-8?B?ZjhkS3ZiM1NFQ0l0T1pOeHpqZzk3L3hzNHhwTWIzeUJkd1ZyVTdIQkRDRDFh?=
 =?utf-8?B?R1JJWkp2ZkFHN1hYempBRkEzbjYxaW56WG9rSjY0dk9jd2ZVSTI2TzZQRzND?=
 =?utf-8?B?dk45dUV1a2dZQS9JeUF3MDBWQ2VNRmkrUU00bFcrZ3IxODM4UzM3aENzSHNB?=
 =?utf-8?B?WXBUVkR3S3dtcDljbS81RkhyVVcveDk4a1FjOFNMR1AxeENSNXFnMHBHcEky?=
 =?utf-8?B?eUZvVVlRRldIVWNabEE4YW1udEJ3bngreVMxempWVm5GZkF0VWM3VVNURkRy?=
 =?utf-8?B?aG9yUmV4VzNIeldXdzRPYkdXMnBCZHRhZTFaMTI2ZzkxWVBKc2xGandibFFl?=
 =?utf-8?B?c25ib1RsU1BnRnBvRG9RZFlXdCttbkFJRkQwL2pJTVloUkNWSEhGcW10aVdn?=
 =?utf-8?B?NE9KVHlicVZzcHhTYnpDYThYTERWOXBuUVdzL2lpUFIrYTN3bnBKWnR0M3RN?=
 =?utf-8?B?akthcUhHQVBubVJ5VEtQbUxDeVNvenhvZHVtOUpqSERCQW5yMDQySFVNNDZj?=
 =?utf-8?B?VmM2cXRVcE9EKzVGamdIK0hKcWcvbkRaNVZLcWRpd05SajREWWdzU0lwVVlI?=
 =?utf-8?B?NTZ1ZmVQdXJJalBqZ2lWOWx2dWsxZ0VLVVkrNGZMbmZQaWRMM1M4dmhHTGtB?=
 =?utf-8?B?RFdFMk1pVkhUSkV3NmxPVXV4RU5UQTV4czRCTTVUNm1yU0NjTU1ZcjhpdHI3?=
 =?utf-8?B?RTluUW9jK1ZwVE5PSzZKWDZnZHJQTUtCOEh6ajN0eUk5SzhKTFJsY3JSL0ND?=
 =?utf-8?B?eG1aQWpqWlNrQk1VWnlDRmlBd2dvQUJ4aVd2VURSbGwyd1hyVXhtaTdVSWZx?=
 =?utf-8?B?cUdUZ0ViZ2RJTDJGaEJPd2JtTHA5NDg3Z3cyQmFaQ2hHaVNFVzRTc3JRWFNx?=
 =?utf-8?B?ZGl2cytvK2hJOHJLZEJvenJyVm5QTlFGTkxmK2w1cEN6cFNsNEdqVUFSbUIz?=
 =?utf-8?B?ZW9WVDFrbDB4L0QyVzhYT3A2WHVSa1p0QllVRFBKamc3ZGhBTlY3WmVaQ0hM?=
 =?utf-8?B?T2xFV253YndCL0RRYzJ5REZXMDAwQjJTbkRIeFJVMGdFVEJPbGdBZm80VW5T?=
 =?utf-8?Q?I5QwWZz32+6iYapAkb8etS1zccwPDxNsnhN5w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVZOdmZzalAreXVSMTllZ0J3MDBNb0ZWTzBHcXRkdW5BektvRU5HRXhhVmZq?=
 =?utf-8?B?WWY2MDRRMWhCM0VCTXQ4N3lDYTgxM0NDeHNvQUo3dHFIVjdFVE95MHVPMEFv?=
 =?utf-8?B?RDk4YTJoQVF3K3lDTW4zUWtueXp4czZWZjZuQzhwaVFKSlQvTnZLN3FvTTZW?=
 =?utf-8?B?Tzg5N05mR1NBWFhiWGcrZUk2blFlN3pMWUtMSUgyZ0hURGMxREZDY285dzFI?=
 =?utf-8?B?dVRaTmtoZkVDUDZ0Y2VqakZrdmh0SHdFRGI4S3RxMW9Nay94MndRMm9jUmlx?=
 =?utf-8?B?T0lUWHNESWxPK0ZqajNlSTVpTk5TUnVoRE9LejFKOU1IaW9kVzUyK3gxV2da?=
 =?utf-8?B?V3c1N3k0SUNFdGVVVndwbjZRbFJuUGNLdTRsR2NuRS9HV21KZ0pBQWdPaFdw?=
 =?utf-8?B?d3hxSmw0Snd1Y1AvbHNCdzBnZHh0eFU2VzdnVFNmdnJQMDB4blpmZGd3SVlC?=
 =?utf-8?B?RGM5TVVlYmlhVGQxWlcwRHJVYjdPWmV2Q20vbW0rcWw1UlRyQVhpOVFUWURV?=
 =?utf-8?B?RlhjRmtuZXYvMEZYckNLZFBTL1lEbnpsOUlyeU1RRUZkNWZKUU91ZlI3UmVk?=
 =?utf-8?B?dk9lM3E0TVlUU2loZ0I3RUNXQzE1VGxrVCtET0RHeGlxTm1pOG9YODg2Ry9H?=
 =?utf-8?B?dlMrbUdLU1JWYTFQUmhBQjNiOWFjUzJNZUYycmtPZ0RRZVZwTk0rVDUzUzQx?=
 =?utf-8?B?QkxpOG5xT2wrbGtnVHk2K2VMK0psSUM1WW0rSThXYUx1UDJzZU9oV013eGpn?=
 =?utf-8?B?L29oNkhPa1B2RWlNaFpkcnozWU1hNS9FRFZXSGZQaXUzUjFCL2h5cUR5ZGRi?=
 =?utf-8?B?SVRwWWtjL1VmbHhlSXBHa0FIbzFWNS84Y0ZsQmtGUS83bHMzdVpsMTQ0R3My?=
 =?utf-8?B?eDZIUEtQaFBBaFRFVll5bk5nVm5GcDVkODd1elNJbkZlZnRERmM1M2IvZzNo?=
 =?utf-8?B?M2dZamtiMEE2VUhOdW1kU3dKZ3VHNWFhY1hsYzFSc0ZYL3hHK016QlB0SFNn?=
 =?utf-8?B?UGtCaURFanB6ZWw2U05BWWVwQU9DNFNLWFN6bzE2eVAwVjJpdzN1NVppNHN1?=
 =?utf-8?B?REhBWS9WSjl1SlB0UWg5WEU3MHd6WUxaYzRPcFlYNE9DVER0b1lla2s5OHY4?=
 =?utf-8?B?S1VaZkd4T1g3eGpzUU5NN1dJa0NqZnJyY2JOUjhTOUZQWmQzRTJ1cy9YVllU?=
 =?utf-8?B?RjgwUUU4T0pGUjc1bHVVYkpDZk1tUkU1MjY2RFNNSjV0UkprdXd1SXNJdXE5?=
 =?utf-8?B?STJzTW90NEFoWXVHcmtySmowOXBXT2pWckNNRytjSXNIRjJyTFVvbmRqd2lv?=
 =?utf-8?B?UklDUjhDVXVzUEgwVm01UkNKblRBMGlWKzY3SlNxK2pBdFBYY2pvUmd4Tkln?=
 =?utf-8?B?YnFmWGRYV3krNVkzOVZRcjM4K3RaZVNLN3g3ckl6QU1mRHpqR3VnYkN6VEgx?=
 =?utf-8?B?ZHhoMlZoQVBHR28wb2FLbys2OHZzYWVXRkxkbEtmSDQvbCtZRlBzb3ozYzF4?=
 =?utf-8?B?NWZRcDU5ZkNGenZ0RndINUZpWVhpUk52bmgrVXo3czA4aU1tMGVvaVNBRm1K?=
 =?utf-8?B?Y3FOUWQrUGxPSU1rSzVSTWJSS0RnTG1qTjlTMFF5ZGg5U0ZYVUg5TXR6eDJS?=
 =?utf-8?B?Qk1rZWdXYlNjVmtJaEJHbSttclVCMzNhc1FvNGFXb0pyMm4vK3dPZ2R3OU5x?=
 =?utf-8?B?RUpSVHRiMmR5YmluNDBEY3FqZmx0ZEU2QURWTU5FNnhFK1pVSUwxTVlVYlVB?=
 =?utf-8?B?NkhLRGU5MkpaT2p6WXZzSldnaUFqdnY5bUFJKy9zT0JNR25LOXJidmJKMlM4?=
 =?utf-8?B?SENKU05uWXgraU9wZjI5aHdxL01zaXZmUWNQRVdZc255dXBCbzBJUkQxRmdV?=
 =?utf-8?B?bHc2b2g4WThXNCt1UVBaaTVUUEtEbmt0OHVZdkhiOVFjandBYWZHR0xWeExT?=
 =?utf-8?B?d2FYWHBCM09IdnhVaFI0dGJlb3lzQy9kNVF5aWpxTm92RmxML05qUmZ2dWVO?=
 =?utf-8?B?dDA2bTVHWFZ2c1F6blNWeTlnVWUyZjhlSjdXVVVCZGw2RFkreVN3Y0FTbEZa?=
 =?utf-8?B?aGhOanBDUUxjcDJJaXdRYS9yaHZacmc4UUp0YzZBbEoxdVdUc3ZaMDF4QWlk?=
 =?utf-8?Q?MEX4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1be711-59e4-4167-6655-08dc869126a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 01:28:35.6136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEjaxwZ/qsNSs4Ll67sDK62p7Bf7Dtt353XfeKrVUCmNA50py3tKQWzvFFpczmy61YfX6oJkD/oS6f9rdvg4Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8326

PiBTdWJqZWN0OiBbUEFUQ0ggMS83XSBhcm02NDogZHRzOiBpbXg4cW06IGFkZCBsdmRzIHN1YnN5
c3RlbQ0KPiANCj4gQWRkIGlycXN0ZWFyLCBwd20gYW5kIGkyYyBpbiBsdmRzIHN1YnN5c3RlbS4N
Cg0KaXJxc3RlZXINCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54
cC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLXNz
LWx2ZHMuZHRzaSB8IDIzMQ0KPiArKysrKysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0uZHRzaSAgICAgICAgIHwgICAxICsNCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMjMyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0tc3MtbHZkcy5kdHNpDQo+IGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLXNzLWx2ZHMuZHRzaQ0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAwLi5lYjgyMDhjZGRlYWY5DQo+IC0tLSAvZGV2
L251bGwNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLXNzLWx2
ZHMuZHRzaQ0KPiBAQCAtMCwwICsxLDIzMSBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjArDQoNCkdQTC0yLjAtb25seSBhbmQgTUlUPw0KDQo+ICsNCj4gKy8qDQo+ICsg
KiBDb3B5cmlnaHQgMjAyNCBOWFANCj4gKyAqLw0KPiArDQo+ICsvew0KPiArDQo+ICsJbHZkczFf
aXBnX2NsazogbHZkczBfaXBnX2NsazogY2xvY2stY29udHJvbGxlci1sdmRzLWlwZyB7DQoNClR3
byBhbGlhcyBuYW1lPw0KDQo+ICsJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPiArCQkj
Y2xvY2stY2VsbHMgPSA8MD47DQo+ICsJCWNsb2NrLWZyZXF1ZW5jeSA9IDwyNDAwMDAwMD47DQo+
ICsJCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJsdmRzMF9pcGdfY2xrIjsNCj4gKwl9Ow0KPiArDQoN
ClJlZ2FyZHMsDQpQZW5nLg0K

