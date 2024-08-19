Return-Path: <linux-kernel+bounces-291687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36052956594
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1285283A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABF415B551;
	Mon, 19 Aug 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LITRnRnk"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEED15B12C;
	Mon, 19 Aug 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056006; cv=fail; b=Z+MtpejXOdpFFjouwKlOLUk3hUgFNzE3b5t0z3/A8bWawrfBy/uDSAJT2ptiOpuinMmrqJKULerlohMePItjoKs5/evO6wsevM06dQ+YeImtKOmAcd5Wm1G3ZEzr881QW0IEFjTsR5Hb9FzlZ8Wxq3G0m3XsjUOoXTbBwyIpDIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056006; c=relaxed/simple;
	bh=iXFtl5LDbl0Xevx+4yn/bYA53aMeLXEdQ0nHy5ci8J0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IgqieJhVtaNG634dcoD3CVPwLZtj8BT8mjeloanBP/8tCsLt/9Ld8bmjNZG4ERvyO+upaMOnIiIdPECCVzhgtZqib461psU1qcVm6Y0B0S53LaTxOwgmrmvRHVDd+zaJENf45wm/xiVjC25Zj+UJ3w3EAaDCqI8/LQ4T9aAN6Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LITRnRnk; arc=fail smtp.client-ip=40.107.255.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fabPGP+wKOE1YXKhhP61gf8iQIMLC9fDbkZpc2s3hKiYSkV56KGWwOiqmq7Y4RL4je3iAVRXfujNj42L2NyhTGQH2SvaPXvKPRheCvxxRKG7TIslGMXBuLrmQINTpoPq4qRYyQenq1kBhWSdQzXeEJnKXkaxegON8/CHmmkS5q9kqHiec5m1RN9CG1Yc4+ufAkbajOuLOgX7/zBvFer7Y3hbyWtw/bvNgfqWHLdW4G7csYxZpiO0UVujun2DP7LYC0O3skSWuCzHYfR2guLfvdFSKzq8G4m7PUE3zljrExNgxYEwaIptW5cbcxHQYTQkR6otUAhn1cQuDFdlg7Ynuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXFtl5LDbl0Xevx+4yn/bYA53aMeLXEdQ0nHy5ci8J0=;
 b=ra202HvPYrYvQe2uCFEWddW4RgmrjpPjlp2P10yD/p7yz/6ZChwEj0M7ssC3/TAMpDQxav+8c++iRYMbLHz2zY4b+JbX8b1ZtQ4H9+5KPzDAf5PCBVbXWmvq66Qsqas/RKPpfjyXqDQuebsV1XFvMxqtR0xMCmJ3bkVqYaLc1aDI0U6a1FOooGDO+63EsJ/enPECqEYVphLrV84YftAFHetyCZxEDTRp0qiulrx9xF08NR/KuIiP7xqvfjHNdurqfCpF438HGMiFG3FaQCADY1xpX351sSsQHgs7AL/CEgP0l+A6Io54EvoG3JWC5EQViBMFZK+2YxvKHKU3j+eAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXFtl5LDbl0Xevx+4yn/bYA53aMeLXEdQ0nHy5ci8J0=;
 b=LITRnRnkV8wIDNKgtImp6VU9Iyxl3xfQzIAZhacFR33gezzz0VcYQjbBk/uoXJwGujWC4gx6C/jDycmbh16iXRh3vQtGPDKU2FcK7tS6XGKKm16HOpMTurW+D+mK1iOyNtwKjQGgDVoeJooKf7kqsKQq7MNKbnYvL9h6/gM5mzVEfiFaPKvIFPfREUls8mzhzqHKRJPNtglPHuj12a8XJj/12GnZub/4IqyIeL4RhvdoDwxcG5sBwOfMeDz/XKImB0r634Qz7K7KrgdRSy/fPWyr89zjRExgDePvcFeEGsvCAHCkNbP6v00+VR43A+jBT2ANRS0xH9ArV0A2rCweyg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYZPR06MB6954.apcprd06.prod.outlook.com (2603:1096:405:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 08:26:41 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 08:26:41 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIIHYxXSB1c2I6IGdhZGdldDogdV9zZXJpYWw6?=
 =?gb2312?Q?_check_Null_pointer_in_EP_callback?=
Thread-Topic:
 =?gb2312?B?tPC4tDogW1BBVENIIHYxXSB1c2I6IGdhZGdldDogdV9zZXJpYWw6IGNoZWNr?=
 =?gb2312?Q?_Null_pointer_in_EP_callback?=
Thread-Index:
 AdrvzihtFNSOcxRwTAOIHI6tveAOMAABV00AAACqLAAAAoTOwAAAUcYAAAD4WnAAAUYXgAAAwgzwAIjopbA=
Date: Mon, 19 Aug 2024 08:26:41 +0000
Message-ID:
 <TYUPR06MB6217AEF9DD73C9424C7C1D07D28C2@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62177737F0054278B489962BD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081608-punch-coherent-d29e@gregkh>
 <CAOf5uwnsgcJjp1=RLa7qx9ScQY5rZvwX-Zu6BOqxBBhBCz+CFQ@mail.gmail.com>
 <TYUPR06MB62177BCD4AB43C19E38990D3D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uwm65Cw-V+td_=6QAGUF+Uisueqcm0z=1zFaNTisAJnSFQ@mail.gmail.com>
 <TYUPR06MB6217877B31A08356241CAB38D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081652-unify-unlucky-28d2@gregkh>
 <TYUPR06MB6217D1798DBC41C7DB2A1DEDD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
In-Reply-To:
 <TYUPR06MB6217D1798DBC41C7DB2A1DEDD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYZPR06MB6954:EE_
x-ms-office365-filtering-correlation-id: 50ebf4d9-0252-4e7e-808a-08dcc028a6fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZWhhWnFXU2wxYkdYTFhxdHJMdjNlVzJ5ekY5ZFJkL1NSbmNTc1hSUyt1a055?=
 =?gb2312?B?NkNzenZOUlo2UHQ5WmhhZkhQNVVseGJWMnJzT2lqUXIrY050bGt3VWF1cm9r?=
 =?gb2312?B?T0pRd0tXVWFKY2lJQzlydVNwU3IrbE5BNUxCalpQV2p1NGw4RDhIWnBpUWlX?=
 =?gb2312?B?cUtKSGp0ZndUUVBNR2hFcVlpcGVqb3JsVW5vZ2JyMjVTVUU1TE9NSTZmaXBH?=
 =?gb2312?B?R1lmbkd4L01aeFl4TG1oWnV5TGMxRGxBV3pUakZVVUdpZE9HeXBtc1Q4dTRh?=
 =?gb2312?B?OXFXQW1Zbi9rZlR6dENGOE5yd0lidWlabHd6clprTzJ4TDZNcTVHNkw2alVx?=
 =?gb2312?B?TjR2RStzTWptTDN5cHFxYk9vSXkvMFBHTU9HUWt3S2FCK3kvaUZ2c0tlNWVx?=
 =?gb2312?B?ZkNoZ3dXUGxxbDY5UndmcXlxOHkxc0I0TkNQa0JwR1VHdEhTSFQ5WlZTaERi?=
 =?gb2312?B?S0ZqWjYwUDFnQUlhdkdXZE9YaUVxVi9zK0hqOVRhaG9UaWZHdGwrUkxpZEhm?=
 =?gb2312?B?NzRFRG8vUEo2aCtDNnhtZXdDTUdINXNaUGROSTNpZHFZSXpqT3FMNnk0cFNH?=
 =?gb2312?B?YU95UE40LzF3ZTJhMnlhQmpOa0pkaFRMcCtlcndscjZLK1NmaGtMMURXRUxk?=
 =?gb2312?B?ekV3RXA1TkFJV0tnV2NydEQvak8yTlcwRWZBMmwvejdKK0xrRlgrb21wVnd0?=
 =?gb2312?B?Rk9GRlhxZ05ZK1lLbTBiYjRSUFNZUmxKb0VtQ01TWlhoL3N2dE9VcFNQbk1T?=
 =?gb2312?B?eHExOVdyeUlLUUpxbFBuVmZBNDFwMHZZT1k0cGZnbXJQd3hFeUE0RFFmZkVG?=
 =?gb2312?B?VG5leHFBdG5DODcxRStiS1E0VmVnbTNTZWx2TmdESGNhUEwzY3hXYUtoSEh2?=
 =?gb2312?B?VUdZb1o5VHFxU0c4TmlObTFZRlBrSFVvTDJUM2YyVEZtU3lVMnQyaGxGZWpz?=
 =?gb2312?B?bDR3azBVNWhrb3dsM2tnSVQvNmxoTSs3dmtQcE01VFBibmhCYlRoVjh2VENS?=
 =?gb2312?B?SFBwQzBkMGNNQjJVZTRYZEFmYVRmWm9GRmRnNUhpMGFFRjFzK2l0ZmVCL1hO?=
 =?gb2312?B?VGZlQlhJNzNKcHcxbmo5VTVueUlJOFBVWEdHWmJkLzNod1lCLzBMNklQSDU2?=
 =?gb2312?B?Y0txR1dwT0VpSXJ4NHpXZ2pPNEVnQW9XQittejJ3R3hXcGI4NmxTdWdDNUxZ?=
 =?gb2312?B?TFNLVVBQdzZGaWNDcExGbjVpQkRxeHE1ZTQva0xCTGJHWkxYcHcwV200SlhJ?=
 =?gb2312?B?d1YySFNxNDgxalhCL3E0UCtTa0Y4VlR2Um9PNVRMeUpiQlJaWXJQZFRZdkpI?=
 =?gb2312?B?UU9qdUk1Qkh5aCtiK0RlYXlheFhvOUdpbGFEOWxSaktXUXBPY1ZmMkw2d3F1?=
 =?gb2312?B?bFpUKyt2RzhqOW11WDRMdFp4UDJRUWR6enFKZE1naWptcDlnRVFLVENFQ0RP?=
 =?gb2312?B?SFNsTU9DY3I5UnRra0RsZm5EVUZ6cVJ1QitNM3ZtcWtOb1BVTVRsWnZ4WXJQ?=
 =?gb2312?B?SENuaFpYOHZJekV6cTNHdGd6Wno1emNGNDZ2bThlOWVhakJGRGtUUkJaOTda?=
 =?gb2312?B?MGxPMllRY1BZREF2THZYaW9nckk1KzNsUjJuTmRHQWhGazNkU1JvVmZqUmFt?=
 =?gb2312?B?NXFMVkFFcnlPcFYvaHBRSVpLVzdzdytmUjF2L2xBTFJDeUN0SFQzZmRrdXd5?=
 =?gb2312?B?bVdabHJPdnZBWUpCMmZNb0JQeHpBb2l5QXFUdzJsVkRUR2JSOWhLSWs1NE5H?=
 =?gb2312?B?UjJUaXRNQmZpWHlSQnNCVGJsalZ0N0F5K2xadll5NTQ3NjI1bVVrYk5lZWI2?=
 =?gb2312?B?cnZKbmN4TEl2ellUZHp1Ull0NlJxK3ZVZkpFV1J2VjdBWVZ2Ymk1UWd0TEdB?=
 =?gb2312?B?NGVkVnE5YXlDcm1ITDdkeldiY25POVdnWnlaL3hZd1VGZlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VDRLY0MvWHlhcllQT2hsUnNQc0FxRkxQbU1ZWVZITEp2b2VISlF4eXFtMUh2?=
 =?gb2312?B?WFJJZnoyYkp6Rmo1ZEoycHlPc2EyUEpOeFN6bHZEdVBzNS8vcDJHZDFudjI4?=
 =?gb2312?B?NWRYMmFjRkx6R01kSTdxRjZYNmxROExra3lvUlBjbFhURnpDbGVuTDd1Njky?=
 =?gb2312?B?MGJCVlp3ZnZWdUZNa0djUWxSdmlBTTJOSGNXZitXM2xyQkdhcWoxVUpNWDA0?=
 =?gb2312?B?STBEcWRSdnI5QWNIa09pck1raW95dkVKVEF0bXZFeHllQkhDL1ZnMXVKdlJG?=
 =?gb2312?B?Y2p0TUFqOENwMmJKL3VFMHhlWERXQm1Qa2dRU1pOZDN4YTZEVWRwT0FkZFpQ?=
 =?gb2312?B?cUZuUGNoSGwxbmErd3h4aFJMdFNKWVBYQ1RiZmVQZjg1R2YrY1lhbWRxNTRy?=
 =?gb2312?B?bVVuZzRGY2pURnFHYkY4eDNZWDVSKzlwb1JqUkVHMTFnd0F5SGJFWU1nUkJN?=
 =?gb2312?B?M0JJVjlRTng3d1FQVTc2eGJReUVNOG80NnMvVGs0allOUUlyekxjTExXbXpz?=
 =?gb2312?B?dTZNbGFDWEt0STBkQ1JnVDJoSmozSG4wL1JqbkdLT0NNTitmdnpWbXRSVVYr?=
 =?gb2312?B?SHlUcEFYN2NkZUV3SVRSMWxMRFdKQkREOU1CSkRMRnRwRndiN3lLMVFaamNX?=
 =?gb2312?B?UkQ0KzRFQ0liZ1FtU0R0SGJNd2NUQ1RXVWRDS3FCS2RmVDJxVUErZEZ3NENB?=
 =?gb2312?B?ZzhuemlsYTR0WmR0VzM1S1VYeXV2ME1UKzh5c0VxWFJJQjhTODgzalRaYm85?=
 =?gb2312?B?Zkl5cExRNXBsNDJsamx6YlpLaVhVeXNUTzc5c2tZSkNrc09yMUlmcFdEWisx?=
 =?gb2312?B?OE1Ud0c4c2dkaHI0M04rTmVBWmlJdzl0aU1kV29PNDZLcVlUNFh6ZjBXYmVX?=
 =?gb2312?B?MURtMlZzajdEUG5DazgxRjByNFU0QVA5RkxJbHA3ZlRiNjV1ZWVSVmZ2aVZU?=
 =?gb2312?B?V3g4QnB0OXRGdGhLZEJuZFFCTnkwUVh4TWduWXRWQ2UxNXZtK0J1YjJYc0VI?=
 =?gb2312?B?emUwV0JOYlVuSStRc084TVRETVE0QTV2YThoREh1MFFMNDQ5cUh4Nm5abTVx?=
 =?gb2312?B?T2hOb2NSbHRGbGl1ZGJ5Tm1TVERsUnRlWVRWT0ZBRjA3L0Z4Qi9aYXZrRVdw?=
 =?gb2312?B?Q3JsZEZPNmljZjV2K3hJa2V0dE1ocE1WbEZtc3N2Yk5tVHBkY3hDU3VUazdv?=
 =?gb2312?B?aWt2S1ZsRTZvYTFrbjRtOHk2bDhpWWJXM1N3NVB3TEdjTkRidWx4c2gyZHdI?=
 =?gb2312?B?OU8rc2NVdy9ScWZ2MkZJc3JzRTRhWC9ySXdmZ2NTV1VlS1NhZFB2bEQ0UE1W?=
 =?gb2312?B?Z3VZUytmbityMUNENGdSbUUwRDd5SFJmMVJaRFk4S00yc2RGQ1R0OTdXZlow?=
 =?gb2312?B?M2kxWXZ6NXdRcVBGL1p6c1lHTENtMDBhV0IyWkZwU0Uya3ZUajBZTEJQanZo?=
 =?gb2312?B?WFVGbVdKZEFjbE9STVBPTThWV0E1Y21abFZQRzc0bzkyL0Y5STNlYTRFOHVJ?=
 =?gb2312?B?UzJSSCtPWnhYbGN1ZkREdWZKUTdLdXhxVW1iRUxIaWluLzlTN1V6MWVscXFR?=
 =?gb2312?B?OE5TdnZucGZYTXcwNE50UWF1c3lTL2Jmc0d0TjNTMWg1TmpVTjhPYVJoajYx?=
 =?gb2312?B?VnUvODlodUR0WjdaVkd1emFJWDl5NHZHMmR2ZjY1STVTQlg4VEwwZlBxUGVP?=
 =?gb2312?B?SDA4TldzaTNOWHpLcXlwMDZxeitSTzdCWGw3bjIvWWY3NzVKTEpxK095R3dw?=
 =?gb2312?B?Ri9LRXhNSnFLWGNsV2FzNHd4anAxOHlnbDhKVG56WUNHTG1wejhXbXlwTkNL?=
 =?gb2312?B?U1F2SkJWSlpnV2dZVWQ1RklWMWFyWHYzS05SL1F3NmlxekVPOHZ6T2dhbDFq?=
 =?gb2312?B?Z1FPU3ZnZFlBSzVpTVNyTkpXN085VEpUSDN1RnFWTXkvbklQMnFIN0orc3hi?=
 =?gb2312?B?QUdrdlNHVjZLOG03WTNKZXd0ZW9YcWZyUUxtdlNnV2wralVVbGJnb29TVUJQ?=
 =?gb2312?B?UWRjK0prS0dMNVM5S0xVZDdXWHRPb3pwYk9JamxMeTNDV3NmUEhOcFdiWmgx?=
 =?gb2312?B?T2lWMTFzTWV0a3BNUklyblM0K1dvdUNRbFBxL2FoTlNadnFKZEFkOEVIaDlp?=
 =?gb2312?Q?l5lo=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ebf4d9-0252-4e7e-808a-08dcc028a6fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 08:26:41.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERJT3IuTaa6gz+e8hPWYX4lfYSM+qzjzUPkvq8ElwuQvpgD4cYiUmRf31MsmKpMag+dylPVh7oBFg8isXRP05w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6954

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPj5JIHRoaW5rIHRoaXMgaGFzIGJlZW4g
cmVwb3J0ZWQgcHJldmlvdXNseSwgYW5kIGRpZmZlcmVudCBwYXRjaGVzIGhhdmUgYmVlbiBwcm9w
b3NlZCwgaGF2ZSB5b3Ugc2VhcmNoZWQgdGhlIGFyY2hpdmVzPw0KPiBJIGhhdmVuJ3Qgc2VlbiB0
aGUgcGF0Y2ggZ2l2ZW4gYmVsb3cgYmVmb3JlLCBJIHdpbGwgcmVhZCBpdCBjYXJlZnVsbHkuDQo+
IEkgc2VhcmNoZWQgZm9yIExpbnV4IG1haW5saW5lIGNvbW1pdHMgYmVmb3JlIHN1Ym1pdHRpbmcs
IGJ1dCBJIG9ubHkgY29tcGFyZWQgdGhlbSBhY2NvcmRpbmcgdG8gdGhlIGNyYXNoIHN0YWNrIGlu
Zm9ybWF0aW9uIGFuZCBkaWQgbm90IG5vdGljZSB0aGUgZm9sbG93aW5nIGNvbW1pdC4NCiBJIGNo
ZWNrZWQgdGhlIHN0YWNrIHRyYWNlIGFnYWluLiBUaGUgcHJvYmxlbSB3ZSBlbmNvdW50ZXJlZCBz
ZWVtcyBkaWZmZXJlbnQgZnJvbSB0aGUgcHJvYmxlbSByZXBvcnRlZCBpbiB0aGUgbGluayBiZWxv
dywgYW5kIHRoZXkgYXJlIG5vdCBjYXVzZWQgYnkgdGhlIHNhbWUgcmVhc29uLg0KDQo+PlNwZWNp
ZmljYWxseSwgdGFrZSBhIGxvb2sgYXQ6DQo+Pmh0dHBzOi8vYXBjMDEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUuDQo+Pmtlcm5lbC5vcmcl
MkZyJTJGMjAyNDAxMTYxNDE4MDEuMzk2Mzk4LTEta2h0c2FpJTQwZ29vZ2xlLmNvbSZkYXRhPTA1
JTdDDQo+PjAyJTdDaHVsaWFucWluJTQwdml2by5jb20lN0NhNGIwNmU5ZGI3YmI0M2FiMWJmYzA4
ZGNiZTAxYTgzNiU3QzkyM2U0MmRjDQo+PjQ4ZDU0Y2JlYjU4MjFhNzk3YTY0MTJlZCU3QzAlN0Mw
JTdDNjM4NTk0MTYxNTY2NDc1MDMyJTdDVW5rbm93biU3Q1RXRnBiDQo+Pkdac2IzZDhleUpXSWpv
aU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAl
DQo+PjNEJTdDMCU3QyU3QyU3QyZzZGF0YT1wZGIlMkIxYjFxQjFxMiUyQlpOMDk2RDlqeE55dGZO
NyUyRm81MERQdDZwcTVtMVJVDQo+PiUzRCZyZXNlcnZlZD0wDQoNClRoYW5rcw0K

