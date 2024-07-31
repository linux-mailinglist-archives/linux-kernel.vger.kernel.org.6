Return-Path: <linux-kernel+bounces-268805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60452942979
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846B61C20965
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1631A8BE9;
	Wed, 31 Jul 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="n4Cx3i2z"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2042.outbound.protection.outlook.com [40.107.117.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE77443169
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415595; cv=fail; b=pYxJzSwWLDUUPrJzRRIndCyLp21eGdoMD4b31dn709rFBgma14LNXee3UuGwchZDP0UYYIo1PY6ia/JpM//UbVWOY5kPoJ7v4pHYWn5PziPyMGuTAZsgXe3aU0bT8QuEBSjPmfVdxrRflj/gyB2juniUBT8RDkHBDMw/w0ZldQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415595; c=relaxed/simple;
	bh=gN6FgOXlYOdeF4Kz+Fu9+ePViWhUBCAud3FCgFZJ8Dc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rOjkwwMMrnwWo70A41t7CS07JIMZ/EHkMiEBXOr3jgRmA93lAggftbLAcLdlyiBKs3HpgMXqoFaAvuFtZSKLPA3PmJNnUVCX31ic3tTZUOu45zuZhkpVS7OTUGFumOQQCHD1nTE/w9llnZ3+up9N1IZERzQpj7leBJB12U0eKCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=n4Cx3i2z; arc=fail smtp.client-ip=40.107.117.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDR0eisWPY7JhSq1TgQ0pmOMw2W7ZIdl9H45sXezJqSCfA7m7BtPiiGtNK0iGjo9K/mAzVqGRvsfZHdjOcwzbX9/nelSI+OMNRZDbA/GLNPX0gYDKfCNpjoD+BSbQuTWOsMAwjHw6eIJFxmPS0V9Ddx/S4VuMZ12P+t8mpiqJEeAjJyM9pLwOfBUgoNZhi3kT4ZJWZ4iTL7QHpMCB7THEvAUjwEO+OYENFz/TaOcnnYVGlqXWpoGXvXEMadShpLKuq6vf7EfUpPHqeWwdMmJoQ9pCmqWPtaxkqdKabrmg6NVxhYvC4Z/w6wyY+FNsxxB+RLfddxidvRxWnVF/e973g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN6FgOXlYOdeF4Kz+Fu9+ePViWhUBCAud3FCgFZJ8Dc=;
 b=tZckNvJf+/PPpVm82fDwwDlyVoJevZ1yHEPMuARyYhnxhSucbOZ/HT2OQU6vNRL8arMRYIVg2JsOtPbe2oIhEyjAloW9T+Og6MiX8fsZTZiJJeQYfiwwQNMj+3TjmPHiVysHMEsi5RHyDpTnItyZxHrjHQNiNBAL9wQU0+smW/escyhG6I9dK/eWW7IDOiJAVt64CMYldK9NIydcKoeKZ0JVRlzjl+Xkqb3xfnCD11jGUuVVXT0Bca3U9hO5YeU0wQIur4CEups+ZUglBT+O71Pk9RLl7UNHnjjrFpcrnHnsniixuhbWXRMXUZAsUX9BQzN8dNM9BY+9q8eEPd7HTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN6FgOXlYOdeF4Kz+Fu9+ePViWhUBCAud3FCgFZJ8Dc=;
 b=n4Cx3i2zBA7QEC8Fjwu5sSR6+7M2qmDSGDEFX6l3GHOUrv/B+h/1am9urgJnqiDy87RFfzOwyPtjv7RGRsh1tOub8O53irUtiLEdlVEWXfTirxevaCS3WlGJSuN0bguidYWT2a/s2nflEBphIUsoH9Nidn9PVGascRiB7hRFUQFzalEqkWYS3CxrQ1qNWoNYBmijq63rkR9LOsu/scYCS8BRPIPN3m63McFaMfTrbYSBldSTTGOlcKxWhXtF0eRarDG0H4Zd2xAeQd5UpcIrNxZo3ChxSVL6Sbc63V+KRjFcgQVxbqyewQxMVhVs+lqEUdXnnvOO3BDEEN36OHEr4w==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by JH0PR06MB6317.apcprd06.prod.outlook.com (2603:1096:990:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 08:46:25 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 08:46:25 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVkIHRo?=
 =?utf-8?B?ZSBhYm5vcm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9u?=
 =?utf-8?Q?e_as_UVC_camera.?=
Thread-Topic: [PATCH v1] usb: gadget: uvc: Fixed the abnormal enumeration
 problem of mobile phone as UVC camera.
Thread-Index: AdrjJNj29VsAs/ObR7ym5N0VtlAoXAAATxHg
Date: Wed, 31 Jul 2024 08:46:25 +0000
Message-ID:
 <TYUPR06MB62176DB2198FF5E5AF5825DED2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB6217A8530C44FD14D0ECA18CD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
In-Reply-To:
 <TYUPR06MB6217A8530C44FD14D0ECA18CD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|JH0PR06MB6317:EE_
x-ms-office365-filtering-correlation-id: 8fa4712f-4a5c-46cb-431e-08dcb13d4336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUdqcGNVNFBwdklwNXNldVVmQ3RGcWhxV1lnSUNxU1I2UzZWT1pPMHVxdlhW?=
 =?utf-8?B?aHZzV3hGdDBicFEyTHBGODFPbi8yZmJERld5ZGU5Um9lUTN5aWxKQ2RsU0FC?=
 =?utf-8?B?bTZyaVlpb2tpeGgvb082K1VDK2x5VkdVMGx3cGFmMkJMK2RoOVRSbWZUdlJX?=
 =?utf-8?B?QUlRTitocXpxZ281NEdwRnNMZUFHWjQzcncrL1NUZ0UrU2ZMaExGOWhkU1Mv?=
 =?utf-8?B?M3pTU3I1S2pQSGFRNElmNXBaWndhTVpqT0QxN0lBZFlaTVNNb0RwcENuL3VU?=
 =?utf-8?B?WFNPemxERksya3I2M0lKTTEzUVBmdHY1M0tpS09abVhLUUdCVHJsVkg2QU0v?=
 =?utf-8?B?dkNkU2MzaDhjV2RpeWdrUGVUOVZFbmNvd3AyelRGcHYycWUyRlREM2VZWFA0?=
 =?utf-8?B?T2d3VjdQb1lGQVhKVFVabW8vY3NWYnBCV1JDbjFwTHRmWDVITkcxSVJNVmY0?=
 =?utf-8?B?d3kxbjRaU2lKZGVQWklvbm1QY204WDhmRmhIdk1obko2VHk2a3lvdVlmR29t?=
 =?utf-8?B?TUN5QnVrUzVIc3I1aUY4L2FOcm0xaTVTajlTMUwzZmtMN2VCVDBWTUdPSkFn?=
 =?utf-8?B?RWtpUHBmS3JSV3p4TjFPVEFManJpelFKaTRhQUVGNDlJbm1NbWVBTE05NS9V?=
 =?utf-8?B?ekYySGNYRzNidStWKzIzUENuS1dhUm9aejgzMjdVdkZxaVlaSFdpZ3VTU0pt?=
 =?utf-8?B?UnNoQi8yT3RlSURqQnJ1OGJNVEdQSi9OVnVIY1R2bC9ObjRaZ2gyRWM5bGNh?=
 =?utf-8?B?UlBLYTBYeWw3WXRQVThGaWp6MWtlRDNTSTY2MVBkL0I1bjVqZHRmSUxrdmZ1?=
 =?utf-8?B?QkFvQ1pZaStoK1p1QWhNZndUeE5PMUdRaHNWcFdwL2p6YzJTQkNmMC9QUzIr?=
 =?utf-8?B?OE45STdUSi9zcTFnYUpUejZOSzZQdmRSZTBLRXJRUUVlNEZsLzZoeFdDalli?=
 =?utf-8?B?VCtsY09iSVdXdDlvYlBJU3VZK3ZDSWtRY0RwSnpCL2dUUmRTSlhnSUFMYVhO?=
 =?utf-8?B?WWtSQ3RSRTFSZHA0TFdkT0I5Z0p2VTVoNXZvbzdMaDVIdFo5SGhNU25wdVYz?=
 =?utf-8?B?dEc0NkRBUkthS0ZHOERoV1l0R0E5T3lKU21XTURVWHlsM2ZpM0tCdFZiN2F2?=
 =?utf-8?B?WkVZeTcwVnhqNVFzQ2VZSkNQRlNEaDNCdVhLQXBJZUtsMGZZOTI3NG9GZDl3?=
 =?utf-8?B?Q0J0M05pV2Evd0N6YmJ1ak1KdDcwNi9MM2JSQmthTWlPUDdmbXRxSXlWUnVz?=
 =?utf-8?B?ZzYwcE9reFdadlZJRFpiOUc4d2N5ZUw0dkpGdmk4b0J1RnpVRzhPcjVMWjZi?=
 =?utf-8?B?V0grWUMrUFROTVE1YXo3U3BwY1JkZ0xUd3dNbisrRTdBKzgwbWdPQm0yYlZO?=
 =?utf-8?B?MUpWb0FaOHdGanBSOURiMXRxNVFoR2ZMdW9UL21CZmpGWmpnZzgydk9ZSFl6?=
 =?utf-8?B?MW5rdHZ4amJiaTRGT20zMHQ2K3JpTzFlUHJtTXBLM2diZVFFd2hneGs2aWM1?=
 =?utf-8?B?cVZPS3FYYzBYQzdZZzc4UXdZbkE2VUxIMm5IMm5CMC9RZFFQNzN6VGFJNGxN?=
 =?utf-8?B?eGdYb0dQU2ZuSndkTTZEUXQ4cmU4V3hnUjVMNTFDY0FlQ0hyU3ZsTVZPek5k?=
 =?utf-8?B?NVBPd2xDK2hWQllLd3RwMDNOK1lKNFlXcFRpWEEvMkZIOXpBTUViamZZSDJ5?=
 =?utf-8?B?MHVHaDhjSUVDcDVYWlhFc0FKVHpVRCt3M0VETVNaOVdDZDZIZHVLcy8wYXdP?=
 =?utf-8?B?SElhR3NUcDMyQzFHQlJtcmJYejRhQ1duODloRHFhSi9NUVdIVzRPSTBlNlEz?=
 =?utf-8?Q?FjVwNAif5A8vFpcvJIN9oAcXnqtjpe1V2FF+s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3gvS2svMGFtak9JSWtTc2NlR0xHSG9FL3hmY1dxb0YyVzd5b1JkeVFnM04w?=
 =?utf-8?B?amZZZHFMcW5pdyt5cWlOeURyTlQvVHl0Y1lobzQrUHFHL3plemJWUXhDS21B?=
 =?utf-8?B?b1cvRzhGZmwxT1c0MWdabTBPYUl4R0pVUnJqRDJNU1FhRmFjS28zcmY3dTBQ?=
 =?utf-8?B?ZzJ0Vk9YbXBmVlNjeCtwQWJPWW1RU1lkVGlXVU0yZ0FHYWo0L005WENHUFR1?=
 =?utf-8?B?dE8xeE1vM0hWbTFwc3VUL0k4a2NsdSsyVXBQOHV3eGQrSEQ5Yk9aZzFrVFp6?=
 =?utf-8?B?VDlrVDA5bE1hSCsrUEpyeW5ZdVRzMDl5MVU0bHNTdmVkd25lL3V3bGhMdUsv?=
 =?utf-8?B?cmh2WlNlWEJBTGJmZVdiZU8zTjdIR2tNMDQ4NzJNb1o0OTBEeENSV0VSREtz?=
 =?utf-8?B?MHlvSThVZkZZN0xvR1pXQVhJM254dmFSMzlaNTdWK0g1K2tVSFNHVnhHWGpM?=
 =?utf-8?B?WFlUQk0wN0hoSUczZGtJL3dGL3RyT2hQUDRmWmIvdENxcWJnMXo0N29RbmRW?=
 =?utf-8?B?cmRXWVJpdTgzbk1lR2crbmoranUvSGVrRStvVXB5Z2c0NkxldXhwU1QyNHZk?=
 =?utf-8?B?a0NSTC9ubTBRQXpPdGRKRmlxb0kwUjc1b082aFZDYW1nUkJ1V3Z2UEdCY2lz?=
 =?utf-8?B?akM2MnN1bWRVdEdGWDgybi9HVnVjdEZ3Q3Z4T2hNMkZ6VExPSWVTdFkxNEFa?=
 =?utf-8?B?emF2OWtRWEYyQnBUcG9wekptK29yVnFaRkhZOTFHbjlSa2hxdXpWei91ZEZY?=
 =?utf-8?B?aWJsSEhaaEhqcG5kakwxSUlKbFJTdlVla0hkcHFPQUpiWjBveTR2Tk1qVTJ0?=
 =?utf-8?B?OXVZOHZ0aXpLaGJKeXpoVDB2OENuRDRvKzdDRFAwWTE3OWVFZTI2aDlPOUlV?=
 =?utf-8?B?NDlUV2d4T2REbzExQklEOGo0WkV5Wnd6TDU0cnh1cUN2ZHR3RjJKN1dZUmFM?=
 =?utf-8?B?SFBYUXBsOVltRDNQdkhkSTh4Qk52SXp6Vkx4MFJ4VjFVejRodEJxV2wvTmJB?=
 =?utf-8?B?MHI2bzFjQjN2d2UxMGUzV28rVXM2M3A0NVF2Wm9lNEYyaXQ0UFNNYjZEYTN6?=
 =?utf-8?B?eHJNYm5PWkoyUktzWFUvdmpIR2YrdTVwblg4TkpINkN5Rnc4Nm9IM1hlNFA4?=
 =?utf-8?B?c2VEb3NjYU1ab2dONVZad09XanFNNFgxWlhQaVJGQVR0Y3R1anphTUdFWUlL?=
 =?utf-8?B?ait1c1UxSExsWUlBOUZYZUpybmFWMVZhWlpmQlBtTkhSeXRlcUxTRW9Sczl3?=
 =?utf-8?B?WTJsS0EzVG5hOEMrNzdzR3E1R2lYLzhiWXk0VDBMM3hzTnRPa2VYWi9OaThV?=
 =?utf-8?B?dFNhVWxOVEJsZ1p3enpzbzJLcHAyenE3MlJLVmZjWjF4TGdMUXNXdXdoRm13?=
 =?utf-8?B?Y2s4YkJCSThvU29kd0NLT1B2VTlHOHpTNXFNb21IMWlUV0o2NS9rNlhOZ01I?=
 =?utf-8?B?RXlVSk1acXJRTGNLZkhadzRDRGJLblVxcTcyZkI0WEdiYVNQRDdacTFKbE9m?=
 =?utf-8?B?MjJqcC84cythYUtDZ2NDL2RtUDRYL1M4VWdTNm8wajBIb1g1REhDVzliNzBN?=
 =?utf-8?B?Rnhvc3NBNHZ0WmhpU01LeUNCMkw4dVl6OGF6MGFnaGYrTGQwOHJveitVRFpQ?=
 =?utf-8?B?Ui91Z3pLYVZxNE1PV1k1aEVNcFFUVHBJZjB6MlhRV0prdUFJMmZMM0F3VStv?=
 =?utf-8?B?MlN5TmVkVEVQSVZEUmJyN1dJL2tPZW5Vc1UxZnIrTXB3aFc4bld6NUI1RkV4?=
 =?utf-8?B?alZhZlErV0RtdDJsdTRqZlVqdG52em9rb1Rpb0FQdnZGalNISnh4Y1NpOTVF?=
 =?utf-8?B?a3hFMHpBNC9qdUREY0dIblNKeDlEcWlxQitISnV0emZyc0R0VlkyY3g4bUVm?=
 =?utf-8?B?cVkwMGNQY2ROWVRDSmJ3L1hQajFjeVo3aEdLSFE1SHEzcWRBaHlQaTN1Tmc5?=
 =?utf-8?B?SE5Dd1MyVFhtb0pLaFZIVTc4UnlpK0pEUHZiL25qNm5qN3RNd1I2aVcyNFUr?=
 =?utf-8?B?QlkyWHJCVjRCL1ZPZ3BMZTlObm8yOWdSZk9QdGE0U3lxWVkrZVVwVnI5M0cy?=
 =?utf-8?B?NWI4QXJvaVJkZ0pBMTRvRWZCSTlkY3NPaUhXSUE4Vjd5R1hiQ242d1ZHdVEv?=
 =?utf-8?Q?JiX8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa4712f-4a5c-46cb-431e-08dcb13d4336
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 08:46:25.8482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxBRSLE2+aPPZa31KrTXY/qWbyk4CPYc1QJRItYsBm7l+Wx/+QtWz8PF7ZKFCl4Ss18Fufoc58FXhXCLvS7Ucw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6317

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KVGhlIGZvbGxvd2luZyBhcmUgYW5zd2Vy
cyB0byBzZXZlcmFsIHF1ZXN0aW9ucyBhYm91dCB0aGlzIHBhdGNoOg0KDQoxLldoeSBkb2VzIHRo
ZSBkd2MzIGNvbnRyb2xsZXIgbWF0dGVyIGhlcmU/ICBXaGF0IGFib3V0IG90aGVyIGNvbnRyb2xs
ZXJzPw0KIFdlIGhhdmUgdGVzdGVkIHRoYXQgYm90aCB0aGUgZHdjMyBjb250cm9sbGVyIGFuZCB0
aGUgbXR1MyBjb250cm9sbGVyIA0KIGhhdmUgc3VjaCBwcm9ibGVtcyB1bmRlciB0aGUgdXZjIGZ1
bmN0aW9uIGNvbWJpbmF0aW9uLg0KDQoyLldoeSB3YXMgdGhpcyBzZXQgdG8gYmUgdHJ1ZSB0byBz
dGFydCB3aXRoPyAgV2hhdCBjb21taXQgaWQgZG9lcyB0aGlzDQpmaXg/ICBTaG91bGQgaXQgYmUg
YmFja3BvcnRlZCB0byBvbGRlciBrZXJuZWxzLCBhbmQgaWYgc28sIGhvdyBmYXIgYmFjaz8NCiBT
ZXQgdG8gdHJ1ZSBmb3IgY29tbWl0IHJlY29yZHM6DQogaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9ZjI3
N2JmMjdjZjVjZDU2YmNkMWM0Yjk1YWUxNDBmNjE2ODBhNmU4Mw0KIA0KIEl0IHNlZW1zIHRoYXQg
dGhlIGZfdXZjIGRyaXZlciBsb2dpYyBpcyBvcHRpbWl6ZWQsIGFuZCB0aGUgY29kZSBsb2dpYyBp
cyBtb3JlIHJlYXNvbmFibGUuDQogDQoga2VybmVsNS4xMCwga2VybmVsIDUuMTUsIGtlcm5lbDYu
MSwgYW5kIGtlcm5lbDYuNiB2ZXJzaW9ucyBhbGwgbmVlZCB0byBiZSBzeW5jaHJvbml6ZWQsIA0K
IEZyb20gdGhlIGN1cnJlbnQgcG9pbnQgb2YgdmlldywgdGhlc2Uga2VybmVsIHZlcnNpb25zIHdp
bGwgYmUgY29tcGF0aWJsZSB3aXRoIEFuZHJvaWQgMTQgYW5kIG5ld2VyIHZlcnNpb25zLg0KDQoz
LldoYXQgdXNlci12aXNhYmxlIGNoYW5nZXMgZG9lcyB0aGlzIHBhdGNoIGNhdXNlPyAgV2hhdCB1
c2VkIHRvIHdvcmsgdGhhdA0Kbm93IHdpbGwgbm90IGFzIHRoYXQgd2FzIGFkZGVkIGZvciBhIHJl
YXNvbiwgcmlnaHQ/DQogQWZ0ZXIgbWVyZ2luZyB0aGlzIHBhdGNoLCB0aGUgd2ViY2FtIGZ1bmN0
aW9uIHdpbGwgYmVjb21lIG5vcm1hbCwgDQogVGhlIHdlYmNhbSBmdW5jdGlvbiBzZWVtcyB0byBi
ZSB1c2VkIGZvciB0aGUgZmlyc3QgdGltZSBvbiBBbmRyb2lkIDE1Lg0KDQpUaGFua3MNCg0KLS0t
LS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiDog6Hov57li6QgDQrlj5HpgIHml7bpl7Q6
IDIwMjTlubQ35pyIMzHml6UgMTY6NDYNCuaUtuS7tuS6ujogZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmcNCuaKhOmAgTogYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgb3BlbnNvdXJjZS5rZXJuZWwgPG9wZW5zb3VyY2Uua2VybmVsQHZpdm8u
Y29tPg0K5Li76aKYOiBbUEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVkIHRoZSBhYm5v
cm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9uZSBhcyBVVkMgY2FtZXJhLg0K
DQpXaGVuIHRoZSBwaG9uZSBpcyBjb25uZWN0ZWQgdG8gdGhlIGNvbXB1dGVyIHRvIHVzZSB0aGUg
d2ViY2FtIGZ1bmN0aW9uLCB0aGUgcGhvbmUgbmVlZHMgdG8gYmUgZW51bWVyYXRlZCBhcyBhIHV2
YyBjYW1lcmEgZnVuY3Rpb24uDQoNCkJlY2F1c2UgdXZjLT5mdW5jLmJpbmRfZGVhY3RpdmF0ZWQg
aXMgY29uZmlndXJlZCBhcyB0cnVlIGluIHRoZSBmX3V2YyBkcml2ZXIgdXZjX2FsbG9jIGZ1bmN0
aW9uLCB0aGUgdXNiX2dhZGdldF9kZWFjdGl2YXRlIGZ1bmN0aW9uIGlzIGNhbGxlZCBkdXJpbmcg
dGhlIGV4ZWN1dGlvbiBvZiB0aGUgY29uZmlnZnNfY29tcG9zaXRlX2JpbmQgZnVuY3Rpb24gdG8g
c2V0IGdhZGdldC0+ZGVhY3RpdmF0ZWQgdG8gdHJ1ZSwgd2hpY2ggaW4gdHVybiBjYXVzZXMgdGhl
IHVzYl9nYWRnZXRfY29ubmVjdF9sb2NrZWQgZnVuY3Rpb24gdG8gZmFpbCB0byBjYWxsIHRoZSBj
b3JyZXNwb25kaW5nIGNvbnRyb2xsZXIgcHVsbHVwIG9wZXJhdGlvbiAoc3VjaCBhczogZHdjM19n
YWRnZXRfcHVsbHVwLCBtdHUzX2dhZGdldF9wdWxsdXApLCBhbmQgdGhlIFVTQiBjYW5ub3QgYmUg
ZW51bWVyYXRlZCBub3JtYWxseSB1bmRlciB0aGUgdXZjIGZ1bmN0aW9uIGNvbWJpbmF0aW9uLg0K
DQpBZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLCB3ZSBtZWFzdXJlZCB0aGF0IHVuZGVyIHRoZSB1
dmMgZnVuY3Rpb24sIHRoZSBkd2MzIGNvbnRyb2xsZXIgYW5kIHRoZSBtdHUzIGNvbnRyb2xsZXIg
Y2FuIGJlIGVudW1lcmF0ZWQgbm9ybWFsbHksIGFuZCB0aGUgd2ViY2FtIGZ1bmN0aW9uIGlzIG5v
cm1hbC4NCg0KVGhlcmVmb3JlLCBtb2RpZnkgdGhlIGZfdXZjIGRyaXZlciB0byByZW1vdmUgdGhl
IG9wZXJhdGlvbiBvZiBzZXR0aW5nDQp1dmMtPmZ1bmMuYmluZF9kZWFjdGl2YXRlZCB0byB0cnVl
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBMaWFucWluIEh1IDxodWxpYW5xaW5Adml2by5jb20+DQotLS0N
CnYxOg0KICAtIE1vZGlmeSBkZXNjcmlwdGlvbiBpbmZvcm1hdGlvbi4NCi0tLQ0KIGRyaXZlcnMv
dXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jIHwgMSAtDQogMSBmaWxlIGNoYW5nZWQsIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2
Yy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMNCmluZGV4IDQwMTg3Yjcx
MTJlNy4uNmQ2M2JlYTE0MjExIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0
aW9uL2ZfdXZjLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jDQpA
QCAtMTEwNyw3ICsxMTA3LDYgQEAgc3RhdGljIHN0cnVjdCB1c2JfZnVuY3Rpb24gKnV2Y19hbGxv
YyhzdHJ1Y3QgdXNiX2Z1bmN0aW9uX2luc3RhbmNlICpmaSkNCiAJdXZjLT5mdW5jLmRpc2FibGUg
PSB1dmNfZnVuY3Rpb25fZGlzYWJsZTsNCiAJdXZjLT5mdW5jLnNldHVwID0gdXZjX2Z1bmN0aW9u
X3NldHVwOw0KIAl1dmMtPmZ1bmMuZnJlZV9mdW5jID0gdXZjX2ZyZWU7DQotCXV2Yy0+ZnVuYy5i
aW5kX2RlYWN0aXZhdGVkID0gdHJ1ZTsNCiANCiAJcmV0dXJuICZ1dmMtPmZ1bmM7DQogDQotLQ0K
Mi4zOS4wDQoNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZyA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IA0K5Y+R6YCB5pe2
6Ze0OiAyMDI05bm0N+aciDMx5pelIDE1OjI4DQrmlLbku7bkuro6IOiDoei/nuWLpCA8aHVsaWFu
cWluQHZpdm8uY29tPg0K5oqE6YCBOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBvcGVuc291cmNlLmtlcm5lbCA8b3BlbnNvdXJjZS5rZXJu
ZWxAdml2by5jb20+DQrkuLvpopg6IFJlOiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVk
IHRoZSBhYm5vcm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9uZSBhcyBVVkMg
Y2FtZXJhLg0KDQpPbiBXZWQsIEp1bCAzMSwgMjAyNCBhdCAwNjo0ODo1N0FNICswMDAwLCDog6Ho
v57li6Qgd3JvdGU6DQo+IEZyb20gYzQ2NDU1OGE3MGUxY2EzNmMwZTRiZDBhMTIxZmI1MDU2NWI0
NDYxMCBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogTGlhbnFpbiBIdSA8aHVsaWFu
cWluQHZpdm8uY29tPg0KPiBEYXRlOiBXZWQsIDMxIEp1bCAyMDI0IDE0OjIxOjUyICswODAwDQo+
IFN1YmplY3Q6IFtQQVRDSF0gdXNiOiBnYWRnZXQ6IHV2YzogRml4ZWQgdGhlIGFibm9ybWFsIGVu
dW1lcmF0aW9uIA0KPiBwcm9ibGVtIG9mICBtb2JpbGUgcGhvbmUgYXMgVVZDIGNhbWVyYS4NCg0K
V2h5IGlzIHRoaXMgaW4gdGhlIGJvZHkgb2YgdGhlIGVtYWlsPyAgUGxlYXNlIGZpeCB1cCwgYW5k
IGFsc28sIHByb3Blcmx5IGhhbmRsZSB0aGlzIGJlaW5nIGEgbmV3IHZlcnNpb24gb2YgYW4gb2xk
IHN1Ym1pc3Npb24gYXMgdGhlIGRvY3VtZW50YXRpb24gYXNrcyB5b3UgdG8uDQoNCnRoYW5rcywN
Cg0KZ3JlZyBrLWgNCg==

