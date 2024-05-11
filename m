Return-Path: <linux-kernel+bounces-176406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02878C2F58
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 05:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DCD284682
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 03:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13936AFE;
	Sat, 11 May 2024 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sr4ZkJsu"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A417991;
	Sat, 11 May 2024 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397682; cv=fail; b=o7xiX4QCYcbDOuvb4gWsqhA07lmLC0lAUV5rq7ADhBtaogmsmRFwsZjKFtCY64GQqplZX5+MDFilSJQuGrC2urHzIjc2Dd3yXnLL0YPsQzetHsoAxcQ73NV7zHM1Nd1ijOmc0yS+ix3QqteNfl3FUTAbLBqSAyLWWOuntVvqvD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397682; c=relaxed/simple;
	bh=7B2xMJx8bQxfNjvt3G9ybO7Qft01GoFGoZy2yK1tBAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mgv8k3c68KY7IYhcWuNoeYhK3S3l+wLPcegWChvsOMQ81MTu0WbEiR1Kr4H+5n1HcpgBpXxyRHnfE6O+qq1LNlMv+PDRgzfaKnQ/kUAHtkuPEKZ4T7WkyflBV9CfXM+YvsNOw0HFJhSOxNPEi+U7mJBvBM7l13b87rOpXUNrInU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sr4ZkJsu; arc=fail smtp.client-ip=40.107.6.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPFjYMoMJQCfMvgpLB42PvII/o9Ba0MEzfh4VQSaU1s/vwyyOBXSPmwGEMkRGYhnuRvPZhUBnbhKb/aeDbw+Vhoa7hISCx7LovfYTPa8yP13DNm/zSOiqbODNQHvaxFKoHWL2SY/msNddZipgL0pIHXmmtoVjk5h2ljYjO36ca87rMnUNtTGUrBA3jldeipMvP/6OEpRc8ncgQasE92A4KXwtYUSJWpDPduXyI332J1eHraFis45AIgnXJUE0XJc7YdfVyEKHBPQ7h4xq7SZuTry6AltWE/52TfBP6ehOMcjeWgtaPe/S1byESb4fVL2o7f0vGiQrghfdgWFUywOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7B2xMJx8bQxfNjvt3G9ybO7Qft01GoFGoZy2yK1tBAo=;
 b=cyODhclk9Jc7z9KJC6LpkdTGWCqOv4Opc95/U3ad7iDBX+Tpccj+DoaYJNGoyHoaMtEPKdMiNb5e1C/HQLiQ7O+fKeWp8L8wOjM13IMxnnZntXNtfY0PgGKvmjoCVEZxIzMKFJA/DIFF1wfATJegaW3N5xHDyBniN4GaCcwVCIwHHlK3jX3mS+AQXoN5FrdJcgvpMValoIKTAu5DzPWtXTFOtE9Uu6oCOg99k7mPeMZ5n+UCVOrvFqY9UzEozPheuKdaJxub5s3m3KuXGM6MZFtba+0eVb0o/gSSjjo9PcXtHdiX0cC6Rvez9aIlGA+d6kYkV5jYE7Q0eO0M9w8jfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7B2xMJx8bQxfNjvt3G9ybO7Qft01GoFGoZy2yK1tBAo=;
 b=Sr4ZkJsufar3Z4EiUh1BWO4srxx5i3aaA074MET+OEsV0ds4keOL0hbyADkCejiV+xnMCIxImETI3f3oDqAkSBO7oqd2iH7c9UA6GNZAP4P61YAaW2BiypLYzNlJPah5U1HoB6dqbaGzcoL54SUxs2TiJNhsmHSfzumJ8spZmMU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8493.eurprd04.prod.outlook.com (2603:10a6:10:2c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Sat, 11 May
 2024 03:21:16 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.7544.048; Sat, 11 May 2024
 03:21:16 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "conor@kernel.org" <conor@kernel.org>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	Frank Li <frank.li@nxp.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v4 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Thread-Topic: [PATCH v4 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Thread-Index: AQHaodhTFnfN9aOwlkulOU2Uq0srNbGQnJ2AgACw0cA=
Date: Sat, 11 May 2024 03:21:16 +0000
Message-ID:
 <AS8PR04MB867680B2F3D9AD83D0C100348CE02@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1715234181-672-1-git-send-email-hongxing.zhu@nxp.com>
 <1715234181-672-3-git-send-email-hongxing.zhu@nxp.com>
 <20240510153849.GA308062-robh@kernel.org>
In-Reply-To: <20240510153849.GA308062-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DB9PR04MB8493:EE_
x-ms-office365-filtering-correlation-id: 26f1cf1d-b36c-4802-66b7-08dc71696b4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?L2hHL1pPMG53dnVSVnd4cUltWXNZYk1xS0J2elRIYThoWFR1VXBmcVEyZmNW?=
 =?gb2312?B?Wkd3UmNVYnNFT3pETFdCNUowSnpMT0N0V0U0LzVJYmN0VU5mR0Vkb0M1Z0xK?=
 =?gb2312?B?R1NwdWdsOHc0bUhVR0Y2NEtiRkRjMzNJdWQ1RTRYUUdmZXkwRzZhU2wwL251?=
 =?gb2312?B?VFI5TWZ4Yk4rZmtyZEFsQjFXajYwUSszTnhLSjZXcHYxUVBJcFhhV1VIM0ZC?=
 =?gb2312?B?U2QzeDNiZlZuWE1paVBLL0tlVnJwTzBudTlJWUJ5ZCs2SVhaU0hXK2pWNHNz?=
 =?gb2312?B?Z2JJVUptK3I0ME9sK2lXeWFCRzVNYWlNTlVwOFZGNlNqaEQzT2xxT0Z6QVI1?=
 =?gb2312?B?VFp3aUl2VlRrN2htZkdRNkhWcysyOVhpQTBleGs4QWVUUDhnaU9SWjlZaEpK?=
 =?gb2312?B?ekF1ZnA1WnlOVlh6d0JhbTNWK3JYMFdGaUJ5OW9idWRMTk1lOThSUU9sSVgy?=
 =?gb2312?B?a1dsYzdvUjNLREVPMVQrUjFNZnc0YmZ4d0Myd1JWUmxmVldKKzI1c2t0ZHUy?=
 =?gb2312?B?UFc1cGYrc252L2Z5UzNMSS9JZDNwNVJVZThSbCszVDFFMlBValJPT3h4VG00?=
 =?gb2312?B?bno3UTlrczNXYjF0b1gwQVJ0RVE4cEs0KzBxQUZ0TWpRSWtrWTZWWXdOMURK?=
 =?gb2312?B?ZGkwRkQ4aWpoOUZ5NDdlcDBkR3QvOHMrc2x1RERKTEhsVVBnYlI1L1diRmY4?=
 =?gb2312?B?MjJLK1lQU2NjbVRoUlA2RkxTLzBJNzArTGZsMElrWGZZb1dyK0huelh2bjd4?=
 =?gb2312?B?anllUWgrd2x6dXA2cERRS0lLZGYvTHR5Z1k1WXRndmVvUGRUWkZCUlFkSlJy?=
 =?gb2312?B?dm8xTkRoVXpubzhYclBhdm8weU82T2FVV2xoeWc2dno1WUh1TUpzbGErOERJ?=
 =?gb2312?B?cmlqc0dQcXlGYVZGL2kyMi8vTUk4ME1sbG5YNldZZ1NjZGRHS3lzRFFZMXZl?=
 =?gb2312?B?ZXlOeDQ1R2E3dFFLdTBWbVk2Ritpc1dFamF1MkpVa3gxZmVUQ2U1SUtYazll?=
 =?gb2312?B?T0k2Z3IxTEIyaTFoc2pmMTIwYlFIeUNuOWlXTjdFa1BSdVd2dUNWZlBJeHdK?=
 =?gb2312?B?RTBYVjVsWjg5UE1XSzZtZDNlMm1jeGRtb2tiY2NmWWdxVXNzN2oxVFR4YlVL?=
 =?gb2312?B?QjZXODE5bEdsSEFYS2JwM2l0NjVSZzN0UmlmVm5pWDNYa3dFMkpqVlYyYzV4?=
 =?gb2312?B?U3h1STlxcUpFSStsTVR2cms3Z3JjUFNJcDlWbFduYzdaS3RySEd1ZjEyV0w4?=
 =?gb2312?B?aEJkLzd0bVhzTjlQajR0YzN1a1E0MDBSem9pRnJWSlZDVHJIdFFiYlJVM0x5?=
 =?gb2312?B?SlIwSCtsVVd1WlRUWGpQUkUreWUzd3hRL0hGaGZ4b3kyRC9nSFZkRmluOWVr?=
 =?gb2312?B?WWY0QWtFc0lhMjRxL042UmJudUtzZ3paQTZveVNscHI0YmVCcm9zV0IyTENk?=
 =?gb2312?B?U0RQSFNuWGtKelVZdkpaK2tMb05QanBvSVVQOXNFVWVGTHIyL01rMGZYd1Rn?=
 =?gb2312?B?WVY1Wm9lKzRJU2FqWEFFN0MwQlZCeXhuQ1dTUzJaSmYrN0xaeFc0NVdCdEI3?=
 =?gb2312?B?ZFFHTjU3eE9uTTUvOFFnci9xUkJ4ZUxkWVE5OTM2VndRYUlmMnVVWEZXeWdW?=
 =?gb2312?B?d1kyMDRoK1ZzODRpeDBJdFdYRE1oTFlLeERGaHAwVlViQXhKZFVXZ0hxY1l3?=
 =?gb2312?B?bVFBUUswWGJzQnZFcUtqdzN1Y0VDMC9wb0daRklQQm5rV2NFK0YxVHJtRHZx?=
 =?gb2312?B?eUtWTGQ5MVhjSVdHWWkvbWVNdmhqaHlYZXNpelppM2J6REM5dDV1a2RIWHg2?=
 =?gb2312?B?RFhXUDlqQlJuY3lPNTBTZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bUNFa2pFTnQ1UzJwZEJGOVNXYlhWcHVvaWlHM1RsYjJvdkZ3b0FVSzFhSW0v?=
 =?gb2312?B?UDZpS3JIbkRZM3VYZnM4SUtiSGVvSnJZb0dPcDNKTnd4Si80eUNtcm1RaHZz?=
 =?gb2312?B?bmVHMjlrdmF5YWNQV1FUUVh5R2VtZnZMRVNVTzF3UjI5L0NFYUR4aFZUOGJo?=
 =?gb2312?B?Z0l5YXE3NFBsdDBaWnhlTnFpbVBieVJJOG44WVlMZkNYdDFDdjN1SDAzdHpV?=
 =?gb2312?B?R3kxK1NpMGdIamQ3SDNyTlRJWDZ5K3lLZmIrcjJjVmFReElFRE5DYWcxMGRq?=
 =?gb2312?B?LzFyTDNLNTdyaUQ1WFBWQkhDQ21jQzZuTDZsS3pZb2hQaWNaQ2FHQ0cyR3RQ?=
 =?gb2312?B?VlpMQmIwdkpwM1BHSTBhT0lmWHFCaGV6TlhwSmhGdVpFbzNlVGkrWjZXNzMw?=
 =?gb2312?B?Si9LeFhUakp0M29TSHIwN0dORVA2VGZQUXJTYy8xalY1RitoOTRXUFQrWTdH?=
 =?gb2312?B?UFRMWUgrbnVVQ21hS0FncU84RVdnNmlIYWFBaWJ3VTZqd3ZtOTFpZGVVT1dy?=
 =?gb2312?B?WUZhL1A2R1hBa3IwQnN0T1daMW1yYktOTUpwS3Z4MVZxL3VxeVh5bGFtdnc1?=
 =?gb2312?B?N1pLU0x1NWUvenU1aHhjdzNxakszN3l0K0pPMDFmOVNBRkZHZG92QkdrNWUr?=
 =?gb2312?B?NDBtN28rczBzeGkrNkpKOURYWXhpWW42d2pta0dXbVhTQ0VTMVI2enNZNVkx?=
 =?gb2312?B?S3o3RXVGVTVQNzN6dzR3UEwydHhldytVNkdRRW1LL25CR2FIb3I2SE1NWGJC?=
 =?gb2312?B?OFVBNUt4djEwSjcvZTRITU0rdUl0ZVlROURtZy9zUGV0MGc1MnhEZjhFOU02?=
 =?gb2312?B?NkFlaWdwekxkRlFqdmZxVXNJSWlmTXgyUnREb3pnSkViV2N1TndVQ0RlM01s?=
 =?gb2312?B?czZ2MjUrcSt2UnZRREU5eGFtNXUyeUJYUksyYWl2ajkxSy83Q3JJbmpUN3N4?=
 =?gb2312?B?SWRGSElZS3QrajlqeTMyZU15azFlUlJQeDlGbHlVa2thZHNPWXNGSFcraUFh?=
 =?gb2312?B?c2ZjNXpjR0wyWmZTMno2SXZqR1NCYUNnQ1ZBVGlkN2d2RndoTDk3c1F4YlZi?=
 =?gb2312?B?NFlJbklCeHhwclUyZzlhVUtDVjlKRXBmYWhSSlFiUnltNlNQWUc5cUkzWVAy?=
 =?gb2312?B?eVE1alNaR00rRzhIeW5xT2RleENxNWpBYlR1MVlaQnRsRHNMeVdTRkwrcFBD?=
 =?gb2312?B?UEQwZ0Y5T0xpbTREOUVBOFF6Y0dOTmVsbjFjbkg2M2NsR0lNUWFtNEF2U0pu?=
 =?gb2312?B?QnQrZ1o0a2x6bFpCVEZtREhZT2N1NDNoYWNiMGRpckV6WTFZYXpLa3NyR21j?=
 =?gb2312?B?bVpXUVEzQk84cXFmekpxTTNEZFNZQ2FEZGRBeFpyWXBLQ1lFeklNeFJyNGFq?=
 =?gb2312?B?VllVaU9HeVVFV2ZoK216eTh5cWY3UHNhc2xTTDk5RjA3dE1MVXg3akJwRkpB?=
 =?gb2312?B?MmFPa0xOSXYxTkMwQ1Voa0wzNndUcUVTSGpqVGd1L29uOTVzOGJiZ3FMUDFk?=
 =?gb2312?B?R0pyTGswK2NnSWQwVVE4aHIrQVZ0TmlkRkRac3lVaDhQdnZub0p3WUxqdGw2?=
 =?gb2312?B?ZFlJQ2FzTDZQSG43WUpJN29aZHgrc055TmNwZzBNbnc0c2JmSnZyc1FRL2dU?=
 =?gb2312?B?TDlMOC9KUVZxbmltQTJGQ0d0YTJjT25McWthQ0lLMkJVMUJGM016T3NNRU5H?=
 =?gb2312?B?SXRYT3BiT1d5NmRDSmFRb3NMNitxZGpteWZrelA3cjE3ZktsQkRueGRzd01E?=
 =?gb2312?B?NnhVS2xWbG53cnp1TnFsVVl6L2VpNk9sSE5hcE14Z3NNWjJHWU1uYjVvOVZK?=
 =?gb2312?B?MFpIWVNoY1pEa1hneDlRSURjQXF1Zm9DMXVualJLdzhFZjMxQk43MXBkc01R?=
 =?gb2312?B?ckltYWluSC90S2RtcnRiVXd3UnJTbGo4TkswUWladGRFcDhvY2lsc3JKbFZY?=
 =?gb2312?B?VUdsRVd4MTNtN254bVpjSW04VXNSUE5mazZNZnh6TFJGM2w0L2g4RzN6MGFT?=
 =?gb2312?B?UmZLN2d2WjBadDRMZWdaUzMyQVB4V2htL3o5aHUrZStXMy9OdldSelBoK0tN?=
 =?gb2312?B?K0dFVUhuMzA3dHJOVjhkdnNveVQyZENiekZRZUxnaTkxRDJPVWtVVDB6dnRO?=
 =?gb2312?Q?JOd02U4fZ/NOWmnurmJ8Adz5o?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f1cf1d-b36c-4802-66b7-08dc71696b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 03:21:16.4968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOIZ67uOYbG5wm1LwMXUsglxjyU+Tgpn2kx6+RVwwWeKJPPSAmuehHkUL6vFo2nVfrGl+k6vWYcV2WMEWsmI1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8493

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOo11MIxMMjVIDIzOjM5DQo+IFRvOiBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogY29ub3JAa2VybmVsLm9yZzsgdmtvdWxA
a2VybmVsLm9yZzsga2lzaG9uQGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRA
bGluYXJvLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBjb25vcitkdEBrZXJu
ZWwub3JnOyBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBpbXhAbGlz
dHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi8zXSBkdC1iaW5kaW5nczog
cGh5OiBBZGQgaS5NWDhRIEhTSU8gU2VyRGVzIFBIWQ0KPiBiaW5kaW5nDQo+IA0KPiBPbiBUaHUs
IE1heSAwOSwgMjAyNCBhdCAwMTo1NjoyMFBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4g
PiBBZGQgaS5NWDhRTSBhbmQgaS5NWDhRWFAgSFNJTyBTZXJEZXMgUEhZIGJpbmRpbmcuDQo+ID4g
SW50cm9kdWNlIG9uZSBIU0lPIGNvbmZpZ3VyYXRpb24gJ2ZzbCxoc2lvLWNmZycsIHdoaWNoIG5l
ZWQgYmUgc2V0IGF0DQo+ID4gaW5pdGlhbGl6YXRpb24gYWNjb3JkaW5nIHRvIGJvYXJkIGRlc2ln
bi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3BoeS9mc2wsaW14OHFtLWhzaW8ueWFt
bCAgICAgICAgIHwgMTQyDQo+ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTQyIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9mc2wsaW14OHFtLWhzaW8ueWFtbA0KPiA+
DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BoeS9mc2wsaW14OHFtLWhzaW8ueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9mc2wsaW14OHFtLWhzaW8ueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5lODY0OGNkOWZlYTYNCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9mc2ws
aW14OHFtLWhzaW8ueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTQyIEBADQo+ID4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjIN
Cj4gPiArLS0tDQo+ID4gKyRpZDoNCj4gPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ID4NCj4gK2NldHJlZS5v
cmclMkZzY2hlbWFzJTJGcGh5JTJGZnNsJTJDaW14OHFtLWhzaW8ueWFtbCUyMyZkYXRhPTA1JTdD
DQo+IDAyJTcNCj4gPg0KPiArQ2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0MyYTNlNTVjYzE1YzQ0
NjUzMDRlYjA4ZGM3MTA3NGMyZiU3QzY4DQo+IDZlYTFkMw0KPiA+DQo+ICtiYzJiNGM2ZmE5MmNk
OTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODUwOTUyMzM1Mzk5MTA3NCU3Q1Vua24NCj4gb3duJTdD
VFdGDQo+ID4NCj4gK3BiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkMNCj4gSTYNCj4gPg0KPiArTW4wJTNEJTdDMCU3QyU3QyU3
QyZzZGF0YT1mQlhmVTdOTlBqNTdtbkkzVlhSM3ZSMjUwb0o3a0pyTE5qWQ0KPiA1VzZtTDBzaw0K
PiA+ICslM0QmcmVzZXJ2ZWQ9MA0KPiA+ICskc2NoZW1hOg0KPiA+ICtodHRwczovL2V1cjAxLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4g
Pg0KPiArY2V0cmVlLm9yZyUyRm1ldGEtc2NoZW1hcyUyRmNvcmUueWFtbCUyMyZkYXRhPTA1JTdD
MDIlN0Nob25neGluZy56DQo+IGh1JQ0KPiA+DQo+ICs0MG54cC5jb20lN0MyYTNlNTVjYzE1YzQ0
NjUzMDRlYjA4ZGM3MTA3NGMyZiU3QzY4NmVhMWQzYmMyYjRjNmYNCj4gYTkyY2Q5DQo+ID4NCj4g
KzljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODUwOTUyMzM1Mzk5OTE3NiU3Q1Vua25vd24lN0NUV0Zw
YkcNCj4gWnNiM2Q4ZXlKV0kNCj4gPg0KPiAram9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzANCj4gJTdDJQ0KPiA+DQo+ICs3QyU3
QyZzZGF0YT1uMDFkVkxvSWFIaW1seWFRVFUxaFV3SVVOdm1ubzdZVVZucmprVFpLNVRRJTNEJnJl
cw0KPiBlcnZlZD0wDQo+ID4gKw0KPiA+ICt0aXRsZTogRnJlZXNjYWxlIGkuTVg4UU0gU29DIHNl
cmllcyBIU0lPIFNFUkRFUyBQSFkNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0g
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ICsNCj4gPiArcHJvcGVydGll
czoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgZW51bToNCj4gPiArICAgICAgLSBmc2ws
aW14OHFtLWhzaW8NCj4gPiArICAgICAgLSBmc2wsaW14OHF4cC1oc2lvDQo+ID4gKyAgcmVnOg0K
PiA+ICsgICAgbWluSXRlbXM6IDQNCj4gPiArICAgIG1heEl0ZW1zOiA0DQo+IA0KPiBOZWVkIHRv
IGRlZmluZSB3aGF0IGlzIGVhY2ggZW50cnk6DQo+IA0KPiBpdGVtczoNCj4gICAtIGRlc2NyaXB0
aW9uOiAuLi4NCj4gICAtIGRlc2NyaXB0aW9uOiAuLi4NCj4gICAtIGRlc2NyaXB0aW9uOiAuLi4N
Cj4gICAtIGRlc2NyaXB0aW9uOiAuLi4NCj4gDQo+IA0KPiA+ICsNCj4gPiArICAiI3BoeS1jZWxs
cyI6DQo+ID4gKyAgICBjb25zdDogMw0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAg
IFRoZSBmaXJzdCBkZWZpbmVzIGxhbmUgaW5kZXguDQo+ID4gKyAgICAgIFRoZSBzZWNvbmQgZGVm
aW5lcyB0aGUgdHlwZSBvZiB0aGUgUEhZIHJlZmVyIHRvIHRoZSBpbmNsdWRlIHBoeS5oLg0KPiA+
ICsgICAgICBUaGUgdGhpcmQgZGVmaW5lcyB0aGUgY29udHJvbGxlciBpbmRleCwgaW5kaWNhdGVk
IHdoaWNoIGNvbnRyb2xsZXINCj4gPiArICAgICAgaXMgYm91bmQgdG8gdGhlIGxhbmUuDQo+ID4g
Kw0KPiA+ICsgIHJlZy1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0
OiByZWcNCj4gPiArICAgICAgLSBjb25zdDogcGh5DQo+ID4gKyAgICAgIC0gY29uc3Q6IGN0cmwN
Cj4gPiArICAgICAgLSBjb25zdDogbWlzYw0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAg
ICBtaW5JdGVtczogNQ0KPiA+ICsgICAgbWF4SXRlbXM6IDE0DQo+ID4gKw0KPiA+ICsgIGNsb2Nr
LW5hbWVzOg0KPiA+ICsgICAgbWluSXRlbXM6IDUNCj4gPiArICAgIG1heEl0ZW1zOiAxNA0KPiA+
ICsNCj4gPiArICBmc2wsaHNpby1jZmc6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogUmVmZXIgbWFj
cm8gSFNJT19DRkcqDQo+IGluY2x1ZGUvZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaC4N
Cj4gDQo+IEkgY2FuJ3QsIGl0J3Mgbm90IGluIHRoaXMgcGF0Y2guIEJ1dCBpdCBzaG91bGQgYmUu
DQo+DQpIaSBSb2I6DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQpJIHdvdWxkIG1lcmdlIHRo
ZSBmaXJzdCB0d28gb2YgdGhlIHBhdGNoLXNldCBpbnRvIG9uZSBwYXRjaCBsYXRlci4NCg0KQmVz
dCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KIA0KPiBQbGVhc2Ugc2F5IHNvbWV0aGluZyBhYm91dCB3
aGF0IHRoaXMgaXMgZm9yLCBub3QganVzdCByZWZlciB0byBoZWFkZXIuDQo+IA0KPiA+ICsgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+IA0KPiAgICAg
ICAgbWF4aW11bTogMw0KPiANCj4gPiArDQo+ID4gKyAgZnNsLHJlZmNsay1wYWQtbW9kZToNCj4g
PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBTcGVjaWZpZXMgdGhlIG1vZGUgb2YgdGhl
IHJlZmNsayBwYWQgdXNlZC4gSU5QVVQoUEhZIHJlZmNsb2NrIGlzDQo+ID4gKyAgICAgIHByb3Zp
ZGVkIGV4dGVybmFsbHkgdmlhIHRoZSByZWZjbGsgcGFkKSBvciBPVVRQVVQoUEhZIHJlZmNsb2Nr
IGlzDQo+ID4gKyAgICAgIGRlcml2ZWQgZnJvbSBTb0MgaW50ZXJuYWwgc291cmNlIGFuZCBwcm92
aWRlZCBvbiB0aGUgcmVmY2xrIHBhZCkuDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55
YW1sIy9kZWZpbml0aW9ucy9zdHJpbmcNCj4gPiArICAgIGVudW06IFsgImlucHV0IiwgIm91dHB1
dCIgXQ0KPiANCj4gZGVmYXVsdD8NCj4gDQo+IFJlYWxseSwgdGhpcyBjb3VsZCBqdXN0IGJlIGEg
Ym9vbGVhbiBmb3IgdGhlIG5vbi1kZWZhdWx0IG1vZGUuDQo+IA0KPiA+ICsNCj4gPiArICBwb3dl
ci1kb21haW5zOg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1zOiAyDQo+
ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0K
PiA+ICsgIC0gcmVnLW5hbWVzDQo+ID4gKyAgLSAiI3BoeS1jZWxscyINCj4gPiArICAtIGNsb2Nr
cw0KPiA+ICsgIC0gY2xvY2stbmFtZXMNCj4gPiArICAtIGZzbCxoc2lvLWNmZw0KPiA+ICsNCj4g
PiArYWxsT2Y6DQo+ID4gKyAgLSBpZjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAg
ICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAg
ICAgIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBmc2wsaW14OHF4cC1oc2lvDQo+ID4gKyAg
ICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNsb2NrLW5hbWVz
Og0KPiA+ICsgICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IHBjbGsw
DQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGFwYl9wY2xrMA0KPiA+ICsgICAgICAgICAgICAt
IGNvbnN0OiBwaHkwX2Nycg0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBjdGwwX2Nycg0KPiA+
ICsgICAgICAgICAgICAtIGNvbnN0OiBtaXNjX2Nycg0KPiA+ICsgICAgICAgIHBvd2VyLWRvbWFp
bnM6DQo+ID4gKyAgICAgICAgICBtaW5JdGVtczogMQ0KPiANCj4gU2hvdWxkIGJlIG1heEl0ZW1z
PyBtaW4gaXMgYWxyZWFkeSAxLg0KPiANCj4gPiArDQo+ID4gKyAgLSBpZjoNCj4gPiArICAgICAg
cHJvcGVydGllczoNCj4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgICAgY29u
dGFpbnM6DQo+ID4gKyAgICAgICAgICAgIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBmc2ws
aW14OHFtLWhzaW8NCj4gPiArICAgIHRoZW46DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4g
KyAgICAgICAgY2xvY2stbmFtZXM6DQo+ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAg
ICAgICAgLSBjb25zdDogcGNsazANCj4gPiArICAgICAgICAgICAgLSBjb25zdDogcGNsazENCj4g
PiArICAgICAgICAgICAgLSBjb25zdDogYXBiX3BjbGswDQo+ID4gKyAgICAgICAgICAgIC0gY29u
c3Q6IGFwYl9wY2xrMQ0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBwY2xrMg0KPiA+ICsgICAg
ICAgICAgICAtIGNvbnN0OiBlcGNzX3R4DQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGVwY3Nf
cngNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogYXBiX3BjbGsyDQo+ID4gKyAgICAgICAgICAg
IC0gY29uc3Q6IHBoeTBfY3JyDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IHBoeTFfY3JyDQo+
ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGN0bDBfY3JyDQo+ID4gKyAgICAgICAgICAgIC0gY29u
c3Q6IGN0bDFfY3JyDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGN0bDJfY3JyDQo+ID4gKyAg
ICAgICAgICAgIC0gY29uc3Q6IG1pc2NfY3JyDQo+ID4gKyAgICAgICAgcG93ZXItZG9tYWluczoN
Cj4gPiArICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJvcGVy
dGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2lteDgtY2xvY2suaD4NCj4gPiArICAgICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9jbG9jay9pbXg4LWxwY2cuaD4NCj4gPiArICAgICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9maXJtd2FyZS9pbXgvcnNyYy5oPg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL3BoeS9waHktaW14OC1wY2llLmg+DQo+ID4gKw0KPiA+ICsgICAgaHNpb19waHlANWYx
YTAwMDAgew0KPiANCj4gcGh5QC4uLg0KPiANCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gImZz
bCxpbXg4cXhwLWhzaW8iOw0KPiA+ICsgICAgICAgIHJlZyA9IDwweDVmMWEwMDAwIDB4MTAwMDA+
LA0KPiA+ICsgICAgICAgICAgICAgIDwweDVmMTIwMDAwIDB4MTAwMDA+LA0KPiA+ICsgICAgICAg
ICAgICAgIDwweDVmMTQwMDAwIDB4MTAwMDA+LA0KPiA+ICsgICAgICAgICAgICAgIDwweDVmMTYw
MDAwIDB4MTAwMDA+Ow0KPiA+ICsgICAgICAgIHJlZy1uYW1lcyA9ICJyZWciLCAicGh5IiwgImN0
cmwiLCAibWlzYyI7DQo+ID4gKyAgICAgICAgY2xvY2tzID0gPCZwaHl4MV9scGNnIElNWF9MUENH
X0NMS18wPiwNCj4gPiArICAgICAgICAgICAgICAgICA8JnBoeXgxX2xwY2cgSU1YX0xQQ0dfQ0xL
XzQ+LA0KPiA+ICsgICAgICAgICAgICAgICAgIDwmcGh5eDFfY3JyMV9scGNnIElNWF9MUENHX0NM
S180PiwNCj4gPiArICAgICAgICAgICAgICAgICA8JnBjaWViX2NycjNfbHBjZyBJTVhfTFBDR19D
TEtfND4sDQo+ID4gKyAgICAgICAgICAgICAgICAgPCZtaXNjX2NycjVfbHBjZyBJTVhfTFBDR19D
TEtfND47DQo+ID4gKyAgICAgICAgY2xvY2stbmFtZXMgPSAicGNsazAiLCAiYXBiX3BjbGswIiwg
InBoeTBfY3JyIiwgImN0bDBfY3JyIiwNCj4gIm1pc2NfY3JyIjsNCj4gPiArICAgICAgICBwb3dl
ci1kb21haW5zID0gPCZwZCBJTVhfU0NfUl9TRVJERVNfMT47DQo+ID4gKyAgICAgICAgI3BoeS1j
ZWxscyA9IDwzPjsNCj4gPiArICAgICAgICBmc2wsaHNpby1jZmcgPSA8SU1YOFFfSFNJT19DRkdf
UENJRUI+Ow0KPiA+ICsgICAgICAgIGZzbCxyZWZjbGstcGFkLW1vZGUgPSAiaW5wdXQiOw0KPiA+
ICsgICAgfTsNCj4gPiArLi4uDQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0K

