Return-Path: <linux-kernel+bounces-336911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0EB984276
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F3B282981
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349CD15688C;
	Tue, 24 Sep 2024 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="nnJGwFjh"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2088.outbound.protection.outlook.com [40.107.117.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC015382E;
	Tue, 24 Sep 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171072; cv=fail; b=ALQBDTJcltozZaJOMa35ajhaIxMHY1MTk8S3/LBajdS9ARmXPy7xmExbMVAq0i8MkOlFJ5WAqmHsiyxgcJsNVEnD9lZ7DGK/iH8Jo4rzt3W9nCyIFp8BSzchYs+oFI315Y8f1GGbb6RWn41Frmm0n413YYVzvjFiE4R7//Zg+ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171072; c=relaxed/simple;
	bh=dVAGrtkGiqoSAwY8iFxmRuNCm871oHx1xLBnuawE3LU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tqLzsqD2X5B3My56EdC/xAL8ZSxFYjxd09gEfTURUbZUOGBKyc8BRNRq4jQX0GURig2pVW2RpMRCb2jGKyyzrrUj+QD+U0YCyCx+N4xBfKIVqYKxFu01yYQ6POCuJtPLQNT+leyuQpAl4cu2Q+N5bTuc2dJ2XzH/DV97zEaO33s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=nnJGwFjh; arc=fail smtp.client-ip=40.107.117.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMwPKmy57fQ7AucT0Iy3pYbaFOKg2nFcYTKxzvsJNCD7ht5pM7iaY6XZ/mBcXLGlY+x8+FbyNKh8jz3e4Wtw+EOzsGXttx8fJv88OUjCdSjRolp6zfswZ3jBgNIB+be/xxYMw7Q6eBGDveCFSyywtm1IUX/+lN0St67gNp/CXWQg6gUy7ZmVpDJKlb3iFUW4AU5Z9t2kGuAyyK0bcc4N+CpF2W8mVb/MOQhS3kPf4OW2AFvqlJaC81mq3Tq96N5FuEvFKnrl+vA54dJ3/0hAMql5A17waENJDhVDCKW1Y/IMAWBMkG3YUB1yi4uI58Aq7v3P/qwcRR73BycHL52LVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVAGrtkGiqoSAwY8iFxmRuNCm871oHx1xLBnuawE3LU=;
 b=Dm1b+BeDfPqodCGLYPPTtn4a5iDVV1PMn/Jk1SY5sM8HChG3hi/0boKmI5zG/t17hXj6gG6ZJ55skX+WDPlYK3D5ylmS1XU4dYexhgKuTQxZyor1b1mSS/EscgNM99ac35wSNalKX/ayBEkJV5eVTPw2oOc5zl540AHDLkd4PgMjsrADbMKfGLVtvs3QZCs2HfyeIwDh1TnPPPGs4MBHcdMDGnBtygOX+nxsBDkH932g0k5RyCsSBAadS4TQQnB7f+V4HPS66AnJEvD1giPcz9lB4zMQBFFZhaJS8lbRIfB2YFL4JcoXlDQjLgJ+oduqwNnE9PmKhjvQ6gUHNNP+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVAGrtkGiqoSAwY8iFxmRuNCm871oHx1xLBnuawE3LU=;
 b=nnJGwFjhWENBSlZmNYkgE5/FAGugkChJ9v3gJprOHzqxYyEiLOgXuoYtEsunvrWMn8jtXf4m5Mem8hOWINO4Epqk6aT1NonuO3HreTDp1w+OZeO5h9RghXYbn0FG1+o/5ghNvtTQGR5rxTUCxsm5aAYh/+egd7q0+pEeDGfjFaa+Fb59c3CSBVECx19aeppBdyT7oP8xKyIjQ5W7UPqkUD6pk3XfVYT4Jo4/9YHOUj7oxYgu8N40nt7tL6olCNvGdD4hnpzBgisRUMbxNeVha0BSt51TfQuxUmwfH2gtO6Z9jjQTS0coCcYOZimP5qfedHxre3UAEMFquvu80+JCVw==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SEZPR04MB6756.apcprd04.prod.outlook.com (2603:1096:101:f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 09:44:23 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 09:44:23 +0000
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
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: Revise quad mode to dual
 mode
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: Revise quad mode to dual
 mode
Thread-Index: AQHbA0A9ZqA88+oZRUmuiwV6jivwbbJTbSKAgBNY3eA=
Date: Tue, 24 Sep 2024 09:44:23 +0000
Message-ID:
 <TYZPR04MB5853E0C06B8A019CF1115166D6682@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910051350.2580971-1-Delphine_CC_Chiu@wiwynn.com>
 <215e32abc38011a5e265d91340292234ca157ec8.camel@codeconstruct.com.au>
In-Reply-To:
 <215e32abc38011a5e265d91340292234ca157ec8.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SEZPR04MB6756:EE_
x-ms-office365-filtering-correlation-id: 3f067b2f-4a43-482f-3490-08dcdc7d78b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vk5HdlhhcW9ueG1ENC9ocWlnTXFpNW5NMGxJVlU3N2kwdUdsVGdOeDhwM2Fa?=
 =?utf-8?B?ZGQ5dXV1ME9PUlp5eU93U2hiSUgvTWJ1Vng5elNwcGJxdkk2UUNRNm1wNld6?=
 =?utf-8?B?R1ZIc2tuMEhFdzU1QjdsNnVnbmtTRmtYbS9hMTNrRFN3eHNIbXF5U2hWMDl3?=
 =?utf-8?B?aC91T2ZaYTBqSVpqdUFxMUNGUGNJWTV1cDhkS1NRY3hjMU00MDI5Q081a2lx?=
 =?utf-8?B?SzFCTnA0VDBsc3gyZjE5MWQ5TDhiSTYvSTRaTWh0RXRCRTZQNzdjUXdmUUg0?=
 =?utf-8?B?QTJXc1VhOFZFTnJ2djNZMXdLVlRhbFVIc21seStMUDBNWm0ycDA4SUs4L2ZV?=
 =?utf-8?B?a1NUQXZVeDhtR0x5anFQSE1KU0NoSW16RHBNTnpURzJweWZseXAwandkbmxn?=
 =?utf-8?B?L0pKOEpBYmFPVDNDdW1uWFFEZEhVd3gveWovNFlwNHB1SitINVFDRllMTEJw?=
 =?utf-8?B?aTdhNllDYXh3N09weitVUWd3V01ENW05VEVldEJ6VSs5TDczNURSaE1xNThJ?=
 =?utf-8?B?aFozVVlOQkE5UlpBRWJpWHE4R1k3TlR2TnREVzRWc3FDVG1hRnF4TDlFc0cr?=
 =?utf-8?B?NDNIZTZhVnU4QzNMZ0t1WEZiYkwxekVpK0E2c0w5aDl2VkJOU0NNaGxxdXVN?=
 =?utf-8?B?ODc2NVMzVG5NdEw3bzlzOTJvVFdwU2MxT3BINVNaS0U4bEdMZUlDd1dVTVZP?=
 =?utf-8?B?UExxZHhjMjVnU2VMUHVRNlVTY045dE1tQkgxTXBBM04wMnJmRjdsTzJRN1BD?=
 =?utf-8?B?OGkyY013UjVNVWRsSVFmNW56WEF6NXdZbTlHa0F1UDZ4NEc5Ykw4SzJEUGtT?=
 =?utf-8?B?dncxdTgvdFIzbmw1aCtYbDhySkplZnpGT2ZZczY0R3plNnRtOXJ3azl1aXcy?=
 =?utf-8?B?a3JmZ2pmS3ZxN0VpMi82UlhoSThkYWR4bTcvK0U3TWdTdnpoaFNJaUVkYVNt?=
 =?utf-8?B?RDhuQUVuMytiVDQ3S01XZGw1VkJLRFNxKzlIVDljNnpyTVY1NFRvaUdrTWtY?=
 =?utf-8?B?MXF5SUZPMStZUTIrT1FJQTc4WHNoMXc4Q3Mvek1IU0s1QURwVlJtWVFJY0FR?=
 =?utf-8?B?TVNPamVoVmc1aEhrSVI1ampJa2NhdGYvSnQrL0xSTVhma0dxbzJoTk80NzZW?=
 =?utf-8?B?VnlDV3FqLzJMZTNVSWpCalVlY1RsUHNvdkpNZnVYNW5QdE9TU2k0RHBqQXlk?=
 =?utf-8?B?bFJvTXBEcmx0dXBpeFN2ZUxpcUhxTXJJVE9MeWFVbTQrSER6SVpuN3VKM1F5?=
 =?utf-8?B?cC93NHoxenBHRXVoUG11eVNOU0tqRXhlVVBxQklMVnBPWmpGM2tOcGdHREtF?=
 =?utf-8?B?OGRtTjVpT2d3MEFYeFZvZFltS2w1UUF5WTgxZENMOGpuODZSYzUrUUpLenhB?=
 =?utf-8?B?QzlleDQ0dXVYWm5RdkxRY0RJR21oUENzTEQ2SmovaVRBWCsyZTZ0UGttbDFF?=
 =?utf-8?B?RVduTkJRTmsrcTMwNW5iN0p6T2V0Tk1mM2FmVHVCNEViVEN5dnhJN0ZEUlU5?=
 =?utf-8?B?d2dmUlRHcDl3bGhReEVtQTVlVDBOaGNERUhQbWVVWUs2SjYxejY4QW05bWF2?=
 =?utf-8?B?WDhwSWtCVS9TRnpyZ1lnL0djYXU5TlYvTWJoVUQ1TGhKdG1uUEh2WFRxN1pJ?=
 =?utf-8?B?RStyUmR1cjlnS0YxYjBKZ24xRXlVOFYzeXVEYUNnZVNUU1YvSEg5a0cyYllj?=
 =?utf-8?B?QktaOFdmK0Y1NGphVGNqVmV4dVJBMlpsTlk5M3hzTkZ6bXl3dVZieklrcTIr?=
 =?utf-8?B?RG9hdjgzY3dObGx3U1laMEFpNEtRR1B0ODRtbVIxZXQrMUd5VTY5UURleXBP?=
 =?utf-8?B?SzhDNVMrM2RCYnJVWHFsY3JCV3NsODlhZUVsNXBhdjhuME9kK0FVckY0QXVu?=
 =?utf-8?B?ejNaS0JhaThaOWQxU0dHZlM1RndXdHJSQ3R1d0dmV0poV0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elVueFkvRElyZlB6a1NBL1JxUDVQRCtUdFc4Y0x3Z0hlNHo2dEtuSE5aZVho?=
 =?utf-8?B?NWkzUVZ5MzYzQkUzUjNiaTl0bk9uajg3REZkblhBTXpJWk1zYXJBWEJKR3Rp?=
 =?utf-8?B?UE9HeC83bVNDZEhQQkRweTNNaHQ4cjFBRE4wakRWY3htZldESU5GMzZlZ3d5?=
 =?utf-8?B?blp2L0NGbW1id25aNlE1dURQM2hzNEtvVzZvM3VPdVNnZjBPd0NkVmQvTEU4?=
 =?utf-8?B?czRjYkZ6V2U5Rk1zcmY0cWVjL0NlQkF6YkhYbktuR2JHb1haM3RHUkxkZWxN?=
 =?utf-8?B?U3NEZlY5R0Rjb0hLQ292MVFXWFViTkdYQmFDajZnQU1kRXZJOWM5ZEpoM0dW?=
 =?utf-8?B?d2NuVkEwVFNaRDFmM0ZUcnVDclFTampOVDc2SkRTVERnVXREMGV2ajMwMUY2?=
 =?utf-8?B?YnFieGdBWjJpQW1FSDl4NktPb1FaREl1TjcwUFBOaGd3anhPT25vc1RBd0Zr?=
 =?utf-8?B?NnNVZjVwVjdlMkNlNmxsM0syVmI2bGtORkh0RmM2Qkw1bFBJZDNjbGh6UjY5?=
 =?utf-8?B?eFU4MCthWTRxdEtKc1RzbVZuUDlncENUeU1zYU51WmtpelQ4SnNiZ01Da3NO?=
 =?utf-8?B?Ri9Renh6TUZPcDlWdVQzN0ppMllaVkMyN1VzWFNjVVJsY3VGMlZxSGN5OHlj?=
 =?utf-8?B?bDJzSmo4em9aNStkeDFIMHlBOUR5b1A4R0trWFdOUDlHN25Sc2Y0TS95VzZF?=
 =?utf-8?B?RFo0WFFrOXcvcExidWtpSFgyRUlkNGRhd3BvRXI4WHVqa0RlcGJGODB1NkJP?=
 =?utf-8?B?Z2xoMnY5V0s4c2sxTmlJeXpnSlF3aXphRCsvL2tZMEhlNlZTb0FJV3NZaW5j?=
 =?utf-8?B?MFhUZERXell1VWF5bG1lWFhvbGkvQ2dGdjFjOVpEZTlNRmdNYUVPZWQ5UFVN?=
 =?utf-8?B?ZmVTY29kQmlMTjFCVUl0TWJXUVlmOGdqVGh5clk5b0Nkbk42NGMrZmpsaExu?=
 =?utf-8?B?YnVMT2ZIblhUUGdtdXBLVGQxNGRPRGxmRFhNZGtPQkpOOGVOd0l3ZVBHZDlP?=
 =?utf-8?B?SGw1M3ZHQmViWVhJRk4zQTFtK2Q2TStSTW5TU2o0dzhBdmJrN2hrR3ZOSURv?=
 =?utf-8?B?c283OC9rbE5RSllSeStwZFYvdHdGcVhuTmhQejZMZ29uNFFINjR6Z29mVFlY?=
 =?utf-8?B?QWxGK3hyNUV2WVkzNnlWV3Z1S1R4RFE3UzBpdittMmtNM1Q1T0ZadzlNYjhj?=
 =?utf-8?B?L3NVSXQ3WVZMVzZFdmFhUFZMQmFzVk04TlpQeUVIUDU3NENVeWFaSWUxK1Vw?=
 =?utf-8?B?Tko5N2Vwd1ppbFRHRHR0cllYbjhqTEw5VDZoY0xtd0xBUXRRQVRNU1pieDRX?=
 =?utf-8?B?eFhLdWF3UHpTRVlRZlo2cGwyTFBCSFJ5VFQwNW9Va1JrMDhpWmY4WkZPdVZM?=
 =?utf-8?B?R3pvdVlGNWxvT1BBK3dpL2FSdVp0Vm5Kb3RVSXRtNER0UTY5V1NpREI3cHlM?=
 =?utf-8?B?Q0ZkQXFhbWJNeHJDejU1Tk1TbSt2T0xqd3ppajlrT29XUGtOK21JUUdqOHZ0?=
 =?utf-8?B?RE4xbE9ENWQycFVoTEtNZW9uWXRoL29qM2JnOXlRbDBmWERBODAvVnJvSHZN?=
 =?utf-8?B?RkdwcmZpT0R0YjBVcWFNVElRUUNkZ05Va2RiY3gzMlJxaHFNc0hvYWJmeS8z?=
 =?utf-8?B?QmRpb3ovZ0ZldWlZbkJQZlhROU0rMGVPbHJ6TXJjZDhiL0t4bVd2MllXb0J5?=
 =?utf-8?B?bzFlN1pFamNBOEEyc0oxNjdrWk5TNUZBaDdzcTcwZktrRWRUQ0kweGxLOWpw?=
 =?utf-8?B?dHBKZlJpcDhRNjd3aHdSM2RiM3ZneDBHRFZOSHoza1RCVitCVjVESnFNclZx?=
 =?utf-8?B?UVdRb1N0d004TTlqcDZldTNFV0FqOEdxa3dZdjcwY3RIdnBpYTN3V1ZURHpk?=
 =?utf-8?B?c0dLaG9Qd3MvcEF6dHROakNiajMvdDRhNGFOUzhPS3YwK2srcXFWS2wzOEFT?=
 =?utf-8?B?OHE0MTc4K0tVUFk1aENtYmRMak42YTZaYXg2UWJLRGh1Mm45azA0MFlvQzQ2?=
 =?utf-8?B?TitpOVdwcklqNmZVY3grUmYrbDhrTGNNYUhGclFIay9ISHdRa2pBTVIwWlh5?=
 =?utf-8?B?UGlLd3lmUG8xcE5YQVBQMm4xK0Iyb2JzU2Y4QnZUSVppWmRzNkVtT09JNzV3?=
 =?utf-8?Q?WC2+LfY91mFEt5edJbilw010/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f067b2f-4a43-482f-3490-08dcdc7d78b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 09:44:23.3390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4/9lV9PCJCTLQRCqcUMPI0DxYDudDD0bTqCCn1EGusT0psA/LVZMJOsEZNZ23+lVrUlR47Ld29H37QXFbc6eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6756

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAxMiwgMjAyNCAxMDoxNyBBTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8
RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0
QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0
YW5sZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1
Lndpd3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3ps
YWJzLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBBUk06IGR0czogYXNwZWVkOiB5b3NlbWl0ZTQ6IFJldmlzZSBxdWFkIG1vZGUgdG8N
Cj4gZHVhbCBtb2RlDQo+IA0KPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4gDQo+ICBbRXh0ZXJuYWwg
U2VuZGVyXQ0KPiANCj4gT24gVHVlLCAyMDI0LTA5LTEwIGF0IDEzOjEzICswODAwLCBEZWxwaGlu
ZSBDQyBDaGl1IHdyb3RlOg0KPiA+IEZyb206IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5
bm5AZ21haWwuY29tPg0KPiA+DQo+ID4gUmV2aXNlIHF1YWQgbW9kZSB0byBkdWFsIG1vZGUgdG8g
YXZvaWQgV1AgcGluIGluZmx1bmVjZSB0aGUgU1BJLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Umlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndpd3lubkBnbWFpbC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogRGVscGhpbmUgQ0MgQ2hpdSA8RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPg0KPiA+
IC0tLQ0KPiA+ICAuLi4vYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlv
c2VtaXRlNC5kdHMgfCA4DQo+ID4gKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdHMN
Cj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2Vt
aXRlNC5kdHMNCj4gPiBpbmRleCA5ODQ3Nzc5MmFhMDAuLjMwNzNhZGU2ZDc3YyAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1mYWNlYm9vay15b3Nl
bWl0ZTQuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMt
ZmFjZWJvb2steW9zZW1pdGU0LmR0cw0KPiA+IEBAIC0xMDUsMTUgKzEwNSwxNyBAQCBmbGFzaEAw
IHsNCj4gPiAgICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiAgICAgICAgICAgICAg
IG0yNXAsZmFzdC1yZWFkOw0KPiA+ICAgICAgICAgICAgICAgbGFiZWwgPSAiYm1jIjsNCj4gPiAt
ICAgICAgICAgICAgIHNwaS1yeC1idXMtd2lkdGggPSA8ND47DQo+ID4gKyAgICAgICAgICAgICBz
cGktdHgtYnVzLXdpZHRoID0gPDI+Ow0KPiA+ICsgICAgICAgICAgICAgc3BpLXJ4LWJ1cy13aWR0
aCA9IDwyPjsNCj4gPiAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDAw
PjsgLSNpbmNsdWRlDQo+ID4gIm9wZW5ibWMtZmxhc2gtbGF5b3V0LTY0LmR0c2kiDQo+ID4gKyNp
bmNsdWRlICJvcGVuYm1jLWZsYXNoLWxheW91dC0xMjguZHRzaSINCj4gDQo+IFRoaXMgaXMgYSBi
aXQgbW9yZSBkcmFzdGljIHRoYW4gY2hhbmdpbmcgdGhlIGJ1cyBtb2RlLg0KPiANCj4gQ2FuIHlv
dSBwbGVhc2Ugc3BsaXQgdGhhdCBvdXQgdG8gYSBzZXBhcmF0ZSBjaGFuZ2Ugd2l0aCBzb21lIGp1
c3RpZmljYXRpb24gaW4NCj4gdGhlIGNvbW1pdCBtZXNzYWdlPyBGb3IgaW5zdGFuY2UsIHdhcyB0
aGUgY2hpcCBjaGFuZ2VkIHRvbz8gT3Igd2VyZSB5b3UNCj4gdXNpbmcgdGhlIDY0TSBsYXlvdXQg
b3IgYSAxMjhNIGNoaXAgdGhlIHdob2xlIHRpbWU/DQo+IA0KPiBBbmRyZXcNCkknbGwgc3BsaXQg
dGhlIHBhdGNoIGluIHYyLiBUaGFua3MhDQo=

