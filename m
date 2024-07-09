Return-Path: <linux-kernel+bounces-245413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA792B23C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2E6282A6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D1153509;
	Tue,  9 Jul 2024 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BM6f44gM"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D327462;
	Tue,  9 Jul 2024 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514277; cv=fail; b=hej4hrD6XZ9GrBKVsjG+fjQhhfJnWq9etoiXG4psheWl77PiOfJRdScblp+KJfp28ynhFb20eNqYSGqyRRCm3kYbqJ8aUkHNYpKDzHecIEjSSL1mXbswzvPqNdkZZeZLwEMzXqYsoZ4t3nbMZNsGARfJNwOSWNDyaWSOoQiARLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514277; c=relaxed/simple;
	bh=vYqHStx+QVeF8aEDO+ixbZVAolPfDLawTpdnOz9YijU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aSLhGHx+X4Hu4zjTC5YZ+TvqnikltuSJ28L4c5JwAFAxz+nnqwNoETpj3FrlkCTsWlptqodvLG8mA1AowfxJ+ha9iAy9GWz9sbycqujiOEc0eqGCUWKYPB1ytJSbu0KZlOc7NwPegH8J7HRLN+ZxVO1HDxeKbyZ2OpyxZfCsh+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BM6f44gM; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBLMkoS11z39UJ7c+ygmUF0HnNKdz0qIkZ1iIlLS+G01lemvXsGxuoZdoER/h+hvJV8tk9uzL/gHqMJpE8xiEHX06IqqM6zIYPXjVI1S/5+MJbEku1AO+oB2W4/fQSLajmyIrMNw03Qf98CqiHxfFwC0uRcOaLfmryWaOVG4iIj9mqttT25hCcpVJBarPRn1Q/x3BY/UTf7XmzLjH+cAqd9lUtheB/XEY/Gz+aME8/x3GJHS5706C+Ux9yx69E+KYwfRy/WUdyfJLMoxen7Fu2mBo0LtC6o2h1aYlsDrbwryaApPxgGgYAgMfnQIshDpKIl4YxtnDQVqEzSx56IE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYqHStx+QVeF8aEDO+ixbZVAolPfDLawTpdnOz9YijU=;
 b=mVF8uDMxFfmusHBWBllX1FWj15SyRu5cCWmTlP5jKeyobgN7IHi2l5SjDj8QZTpMpa/+Kla/OnFP7Vh/QWx+xm6E2AOZu5Ng6m2vCKUB9Ryto1r2WN/zMqKdrlfrvKaLyiXqZdWAZsEVbKu2IzBX3br5pgSavpC752rRJm2Qm1CMxhP2D9fEyW+0JuUB67YOb8vzwW4TJBYJnGl0T4hbns7wjjsZN5eN5tKGT41UYuiqVQg156HnuPnVa1fU5+ym/hVsZojBAFr/sXu9YAJJ6MFUSjGA5gM7VdJIdllOo1XxN/EkXfnaOEbERc8gM2B9SMZHR/0MFcL+xQzSE/dFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYqHStx+QVeF8aEDO+ixbZVAolPfDLawTpdnOz9YijU=;
 b=BM6f44gMBVKi/1jruBAtdsaGYyW2iV7eAPxTHVyklfV7/gfQuYjKkxyztwasv6UIt5EohxBpF7eQPl1NUI437j/zRoOayR+X+vpJXcL48SLc0+rv8jeYmdOEQrcIhxIJmC5K7LFWAuE88Rsvr407ZSiX0Jj9qbvj88u6CV/kyE4=
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by AM9PR04MB7490.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 08:37:52 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:37:52 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
CC: Rob Herring <robh@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Jason Liu <jason.hui.liu@nxp.com>,
	"dongas86@gmail.com" <dongas86@gmail.com>, "saravanak@google.com"
	<saravanak@google.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	"kernel@quicinc.com" <kernel@quicinc.com>
Subject: RE: CMA Regression issue - [PATCH v2] of: reserved_mem: Restructure
 code to call reserved mem init functions earlier
Thread-Topic: CMA Regression issue - [PATCH v2] of: reserved_mem: Restructure
 code to call reserved mem init functions earlier
Thread-Index: AdrN5nCIgybrvPp3QT6OipXmVetsBwDpYTyAABPCqrA=
Date: Tue, 9 Jul 2024 08:37:52 +0000
Message-ID:
 <DU0PR04MB9299F752D033336295BCA8C180DB2@DU0PR04MB9299.eurprd04.prod.outlook.com>
References:
 <DU0PR04MB9299C3EC247E1FE2C373440F80DE2@DU0PR04MB9299.eurprd04.prod.outlook.com>
 <5c363e91-581c-4d33-ad5a-154da915b3fb@quicinc.com>
In-Reply-To: <5c363e91-581c-4d33-ad5a-154da915b3fb@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9299:EE_|AM9PR04MB7490:EE_
x-ms-office365-filtering-correlation-id: 3b9d84f2-fde3-4a0a-7d1b-08dc9ff26c4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?MmJwaWdybnRRazBvd0lxcGJZMXZ5WGloZExidEphaUhHWXNKV3EveWduZmZL?=
 =?gb2312?B?eXR0bkRKNHRkUktKcFhNeWxyWkUyRnduYmVJZzUyejdKUWFQUGFTQlc0YXZS?=
 =?gb2312?B?RFlDWS9QN01XMTdLOFJDS1R6TTJTMEJaUzZZMjdFMUFndHBxTGpnbkdpbFBh?=
 =?gb2312?B?UW1RNldMUWozeUcwTE96WjdmVm4wRjJYTzYzZHpUamhGNG13MVlqZ05ZR29J?=
 =?gb2312?B?ZXhrNUMzeDdjTE4rdGhkdERvYS8zeFZGMDRpZDR4ZFRZcmJpWWNnczdyZFpK?=
 =?gb2312?B?Vzl4aFVyczQxWVJKZ3VzMmxRNWhNY2lqZnVvYldZNnJob0J1MHN6WCtXOWZD?=
 =?gb2312?B?RCtwOXBtdm9xc3l2ZXdwWUt3S09kaTN1V3JxbW1EbGZmSXB3MEFNL0NwSEZO?=
 =?gb2312?B?MkRucWVzQnRxWlo1Uks3NHVhQTdsZ2ZmT0xFM1VIWGtEcC9kSjNyY0xyR0xh?=
 =?gb2312?B?YUcrRXovT0tLazhpUXBOUmJENTV5Z0x4MU9qV09DbU9laGUzQUxsZG1rR0Iv?=
 =?gb2312?B?enVqT091SmVheU81UEJFRG1GOTZpT3hhQlpsLzhSUUNST0o2QjJBLzJsVzZT?=
 =?gb2312?B?V0RCTzdsR2FLLzJVUTRCbmF3Y1AxVWU1N0sxSnNyU0pmSE5HRUFoS01wSGxU?=
 =?gb2312?B?L2N0UVhYa1RKZzBkOEVuVkxHczdJMjdmWnloNnRtZWZDS0VNYnA5WXF5OW1q?=
 =?gb2312?B?ZnB1RUtidDkzWmlCRkJzYmZHbUtsQUk5Y1B3azhUOTMzWTFPbDg4SEtuZXRn?=
 =?gb2312?B?WkRZNmpLSkVhSzNzak1RUS82YmJWUk9XRUJkYWovTm9kTzFheFA4OUlQUVBz?=
 =?gb2312?B?MkV0K2Q3YzAxMFdkUFdKN01wSW9VQ2l0QzV4b0RMN3NCZTFDd0pBZHNUN1Ry?=
 =?gb2312?B?ckVkQ095RlkzS1pRU0hJMDZjSjloSFo0dlpWQjlBd1c2dHFrM2dxcHNCZ3VW?=
 =?gb2312?B?eFhEY1BpVnVCOStLMHhrUzZqUkJiYW9mWTI5eFdsM1JPV1ZTY0labzE4TUtw?=
 =?gb2312?B?SndPQ2N5c3lidkpSYklNbkNMWVhGUUhYYVF5N2RjYU1NaVhJbkVveWt0cEp0?=
 =?gb2312?B?Ny9rdDRhZ0ROL2JDWVI3bHlGbFE2UjZTdldNU2lVejB0bS83WFlDYXhVN2Q4?=
 =?gb2312?B?a0wxTVBiMzlWVkpxb1hzNGZGRDNEeEQvYit4OFVyUk1UTWJISHNFTGlGc0xW?=
 =?gb2312?B?amtOc1J0YW5SY3FZSUdVOVA3REZ5SU4xTlpIbXc0RGIzOHdDbVNGUEQxTTV4?=
 =?gb2312?B?WGcyeDlFZFBsRTVWcUVCOVhUZlhDUi9jZG1Oc0pmWDRsN2xLTFVldHF1M2Fu?=
 =?gb2312?B?TmlhMEtUb256dFRMckRtcHNWOEVwWi9KNThLWURkWnRFRUpqQ2lkUTJFTWZq?=
 =?gb2312?B?MVdwN1hId0YzOUhSTmcxN1gxYWYrQ1Jac0F5MXVsZmxSZW14YmpVTTB2OHZX?=
 =?gb2312?B?Ry9rQTJPVi9vR3M4TWRPRCt5Q1BERkhzbU1VRlJON1pwS3Fjc0tFRlBUTVk2?=
 =?gb2312?B?cXAzV09kT05IRVNPWm5lVUNqMzc0akJsSVJkYUxaMDN6cGIyV2hUcGt5dDN4?=
 =?gb2312?B?WE9OY3BybjVPTVpPNEZHZ2VjeFg1NWdOWmxFVHM1Sy9OdlgvYW9YNGdTMUFY?=
 =?gb2312?B?NFk0ZGJDbFJ5VlUxMWRzNkI5dENpY2s3VUljQTJqamlYRGRLdFY4SWF3Wi9G?=
 =?gb2312?B?QzJlQWc1MmJRZ2M2c21EVWZob3lJWjRCTHhrQlEzMmF4YjR1WVR6RmQ2N3VH?=
 =?gb2312?B?dERETDV5b281L08vOUlmNWtWQitsaURUQkpmaUFNUEZoZ0NSYmNUTGVrNm5R?=
 =?gb2312?Q?q3QHEyZW3W0DvmsKw8ZZRCfeMdpthWBcm8bWY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZUNrRVB0eW5KNmpxd2NGaFZJWVp2ZlZJOFVnNWovekdQVnNmV2g1OTYyZVdi?=
 =?gb2312?B?djh6ZjBPYnFUSStKQ3c0UncySW12N3RRYUFoTTNzYkIySmVaSDhjL1ROZUdV?=
 =?gb2312?B?TU9wc0RsRlRGSmM2ekJhNzRlSGpJSDZuaE1oQzVRb0dGYUlickNEdlFhVmg5?=
 =?gb2312?B?RlVnNGxCVWRsbHh1d084c01xcldZUk42QzM5bTdJaWpnSTF0L3V0V1FLMFE0?=
 =?gb2312?B?ZlczS3VhTVpaeVRxTWI3VnM3VzNDWkZxM3NPNGVIYXZFOENiblhONWUvbFM5?=
 =?gb2312?B?VFYxRjROVFlLVDg1c2VnVWNhOUtFc0hHemNEQklrYnpBWVByK0NlWmMxbzFE?=
 =?gb2312?B?cTZHdkRTMlc2U0ROenRPdE5aVm1DZWVONHpRQi9SZ0tsT1dsZ1FlUzVTR3lj?=
 =?gb2312?B?U2NBNllBQmpmd2RFWVVvYXhkZk43eDAxdHdTank1dTJjR1ZybWw5cWdzNVJv?=
 =?gb2312?B?RzFWbHN6MnRrVG9iS0Y3SFM2eEVkTnRpbTFvcktlbWVrWTZUL29MZXVYZitG?=
 =?gb2312?B?KzN0NDlXT09iS2tFd05rVllvRnBTalZBQjVlN0hLc2Flc0dKbmx6c1l2eWts?=
 =?gb2312?B?dUVEbnpLRFh3dkhkUTVTSDV0QWZ3S1dGQVI2YUtCQTBUODdTVFk1bHExd0ty?=
 =?gb2312?B?a2VyVFFWSmtlTlcxR1hPMXE2YXh0WmhhamZQOStwRHpOMjV1dzNIaFhpQ3Fq?=
 =?gb2312?B?VE04aitsOU56OTFBR2pnZitUMHUvYTFMVWpMUkdjL0tZK0MvTW5GTk5WZWtS?=
 =?gb2312?B?bWF0ZlN4NjlGd1QxYXN6Y1d5elNMdFJleTNDZ0t0YmsvVnl6V2RLSjNweWo1?=
 =?gb2312?B?Rm5NL3MxNGwyV09TWXA0aTFhekZKZStRUTNRa2s1OFN2elgyWnlHQmNFVFZs?=
 =?gb2312?B?WXdKR2gzTDVnSW9WaUtENklUTnYzZ3ZXOEloZnplNWlTb1JlbkwyRDdrUVpF?=
 =?gb2312?B?NGpjRlZVYW9PWXh2WExwcUttUm5INVIxaEVEVmovbGJiUUZJbFh2Um54VGsw?=
 =?gb2312?B?Sm8xcnJ2eFBaalhnSVpNQzhnV1kzMkp0UTJpV3V6Y0FkNEJCdDlKTlBnQW5p?=
 =?gb2312?B?K3JobHlBSHdIcStqNXZqY2ZOa3IwL0NIbDJud3pnRlpvYy82d1p1OExPWW9a?=
 =?gb2312?B?SDU5c3kycTZTSGFhWTRqcTIxZS9VOWpTR3hsUE9zN09lVVNLWjVuOTVSK3NY?=
 =?gb2312?B?a2xQVnFqK0c2dVJWUEFGdmZ3OG9yZU95V3RTdEIrcjYrUnQwNU9BUzFiTmJX?=
 =?gb2312?B?YkFMQTUvenVlTVh3emMzbVRobjRXRng5K2RFVWZnWWFsMVVxSmdEM0tKeEZV?=
 =?gb2312?B?MlFmOEFub3NvdDR5dlR6TFM3ekY4dXdxZEZLTWkrdVRudUdVQlFnSU8ySEFU?=
 =?gb2312?B?YVBvajM2RjBVWkNMbElWWS9tVzdXeHZWR3crMDVnRGszUmpBZkl3bUlGTFpV?=
 =?gb2312?B?bGsxVjBuekVtajhYU2pJUll5b0lzNFlXNENYOVE5VUdSNUtnY0t3Y2lPNDRC?=
 =?gb2312?B?bCtSVXZtaXNGUTlNTGIwdXZPRURMTVJHYU1pdnBWN1ZKK2diNnVQSVg3eWUr?=
 =?gb2312?B?ZnVYbW1EMUpiR211a0lVSGJJS0RudEprNTlEL0RLb3I2ZHdjNjhsaDYrbHNY?=
 =?gb2312?B?Z01kbFFTU0N1TGdiMzJqK3FtVWhjVnAxbWNqb3ZOeFQyN0lncDBYN1k0MTZR?=
 =?gb2312?B?RUZPcy9xYlppUE9HTWw5UHlyNldGaVpSYlZZQ3dFalRFeGQzdi9hNTRuRm9V?=
 =?gb2312?B?UFg2REcvZDdkMjdjcHo5cldFNVpRSVZ2RHUwN0FLNmpmWjl2RGgrM3VXekla?=
 =?gb2312?B?QXpPTmcwMkIwSEgzWXpzYWxYZlprY3N6SkZIbndKOXZJKzgyMDhPWjFzQ1ov?=
 =?gb2312?B?bFc5QnlCN1JZV1UrOE9PcDRyajVTd2xYWHIzb3VqRmcxaWZUK3Z0c2U4endN?=
 =?gb2312?B?bzNZUUlobllhZnJ3bm9BYnRYVzYwNU5Gc3hCV1FpNUhBMEZQbkpzZVlINFZO?=
 =?gb2312?B?MFNxVXJ1R0wvQ01kUTNRUDZ1T0lneHIxMUhUaVhmTm1uZjhHN0MvVU9QSFl0?=
 =?gb2312?B?bS9IZG9DZStFeURzVkl4cVJFYm5YY3N0NE9Tdk9rU3M2OWhaNzhCbm1vbTZm?=
 =?gb2312?Q?LkEX1d3s9LszVC2hZfHZWae2q?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9d84f2-fde3-4a0a-7d1b-08dc9ff26c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 08:37:52.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQszSPxr9+f3Zdd5WhasfqWdhCYDUNIeVfMOPGCycbxTpZf9ca93/XiNl69Fq4Rs5j1gV/FzretmmcmNr7uEbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7490

PiBGcm9tOiBPcmVvbHV3YSBCYWJhdHVuZGUgPHF1aWNfb2JhYmF0dW5AcXVpY2luYy5jb20+DQo+
IFNlbnQ6IDIwMjTE6jfUwjnI1SA3OjEwDQo+DQo+IE9uIDcvNC8yMDI0IDQ6NDEgQU0sIEFpc2hl
bmcgRG9uZyB3cm90ZToNCj4gPiBIaSBPcmVvbHV3YSwNCj4gPg0KPiA+IFdlIG9ic2VydmVkIGEg
Q01BIHJlZ3Jlc3Npb24gaXNzdWUgb24gTVg4TU4gdGhhdCB0aGUgQ01BIHJlZ2lvbiBmYWlsZWQN
Cj4gPiB0byBiZSBzZXR1cCBieSBybWVtX2NtYV9zZXR1cCgpIHNpbmNlIHRoZSBmb2xsb3dpbmcg
cGF0Y2g6DQo+ID4gZjJhNTI0ZDllZjViICgib2Y6IHJlc2VydmVkX21lbTogUmVzdHJ1Y3R1cmUg
Y29kZSB0byBjYWxsIHJlc2VydmVkIG1lbQ0KPiA+IGluaXQgZnVuY3Rpb25zIGVhcmxpZXIiKSBb
MV0gQW5kIHRoZSBDTUEgbm9kZSB3YXMgaW5jb3JyZWN0IHBhcnNlZCAoZS5nLg0KPiBub24tcmV1
c2VhYmxlKSBkdWUgdG8gTlVMTCBub2RlIHBvaW50ZXIuDQo+ID4gQmVsb3cgaXMgb25lIGxpbmUg
Ym9vdCBsb2cgdGVzdGVkIHdpdGggdGhlIHRhZyBuZXh0LTIwMjQwNzAzIG9mIGxpbnV4LW5leHQN
Cj4gdHJlZS4NCj4gPiBPRjogcmVzZXJ2ZWQgbWVtOiAweDAwMDAwMDAwNTgwMDAwMDAuLjB4MDAw
MDAwMDA3ZmZmZmZmZiAoNjU1MzYwIEtpQikNCj4gPiBtYXAgbm9uLXJldXNhYmxlIGxpbnV4LGNt
YQ0KPiA+IE5PVEU6IGFjdHVhbGx5IHRoZXJlIGlzIGEgcmV1c2FibGUgcHJvcGVydHk6DQo+ID4g
bGludXgsY21hIHsNCj4gPiAgICAgICAgIGNvbXBhdGlibGUgPSAic2hhcmVkLWRtYS1wb29sIjsN
Cj4gPiAgICAgICAgIHJldXNhYmxlOw0KPiA+ICAgICAgICAgc2l6ZSA9IDwwIDB4MjgwMDAwMDA+
Ow0KPiA+ICAgICAgICAgYWxsb2MtcmFuZ2VzID0gPDAgMHg0MDAwMDAwMCAwIDB4NDAwMDAwMDA+
Ow0KPiA+ICAgICAgICAgbGludXgsY21hLWRlZmF1bHQ7DQo+ID4gfTsNCj4gPg0KPiA+IFRoZSBy
b290IGNhdXNlIHdhcyB0aGF0IHRoZSBDTUEgcmVnaW9uIHdhcyBpbml0aWFsaXplZCBhdCBhIHZl
cnkgZWFybHkNCj4gPiBzdGFnZSBzaW5jZSBhYm92ZSBjb21taXQgaW4gcXVlc3Rpb24uDQo+ID4g
VGhlIGNhbGwgZmxvdyBiZWNhbWU6DQo+ID4gZWFybHlfaW5pdF9mZHRfc2Nhbl9yZXNlcnZlZF9t
ZW0oKS0+ZmR0X3NjYW5fcmVzZXJ2ZWRfbWVtKCktPg0KPiA+IF9fcmVzZXJ2ZWRfbWVtX2FsbG9j
X3NpemUoKS0+b2ZfcmVzZXJ2ZWRfbWVtX3NhdmVfbm9kZShOVUxMLCB4eHgpLT4NCj4gPiBvZl9p
bml0X3Jlc2VydmVkX21lbV9ub2RlKCktPl9fcmVzZXJ2ZWRfbWVtX2luaXRfbm9kZSgpLg0KPiA+
DQo+ID4gVGhlIHJtZW0tPmRldl9ub2RlIGlzIHN0aWxsIE5VTEwgd2hlbiBjYWxsaW5nDQo+ID4g
X19yZXNlcnZlZF9tZW1faW5pdF9ub2RlKCkgd2hpY2ggZmFpbHMgdG8gY2FsbCB0aGUgcm1lbV9j
bWFfc2V0dXAoKS4NCj4gPg0KPiA+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSdzIGFscmVh
ZHkgYSBmaXggcGF0Y2guDQo+ID4NCj4gDQo+IEkgaGF2ZSB1cGxvYWRlZCBhIGZpeCBoZXJlOg0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA3MDgyMzA2MTMuNDQ4ODQ2LTEtcXVp
Y19vYmFiYXR1bkBxdWljaW5jLmNvbS8NCj4gDQo+IFBsZWFzZSB0ZXN0IGFuZCBzZWUgaWYgdGhp
cyBmaXhlcyB0aGUgaXNzdWUuDQoNClRlc3RlZCBpdCB3b3JrZWQuIFRoYW5rcyBmb3IgdGhlIGZp
eC4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo=

