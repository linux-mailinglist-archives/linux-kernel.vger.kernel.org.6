Return-Path: <linux-kernel+bounces-371489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02649A3BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11BE1C21C12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED3201259;
	Fri, 18 Oct 2024 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="BF0mmadz"
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA81D54C5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248089; cv=fail; b=WLurS+p5EYJ9dkstQYIFW1CLGCJGYZAbUIqSGM2x69zTLLts/2kz7+yFBHfyYtrcamaJ/UByf0yNKqHxEDm6/r9kYdxjn5maNcysoeO3e9ey3Av2J+3Ros1hRLmMXH0S3rzdwim8Ckz+TkpYAoxpYC12L0a7mBHWAZRItcX7Jwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248089; c=relaxed/simple;
	bh=ro9fjkpkH3w/ouSHekn21o06mn2yyPD+5yp4HVkMA5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hRhMCpl1c0Fwb4Q1eShIIJm8FVlJxIpGsHya8FRb2owJDAOl7u5kNcV+yGpXTkANeKjLDnOYrF4AMG3IL/TiN+QGfNmasit9MTS5+pak48SiF2lg14PP2/CriT+OO7AS2yFuqfMGeZMzggiIFoWRsrjTPv4JjZQgBIHhoO4UPUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=BF0mmadz; arc=fail smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=846; q=dns/txt; s=iport;
  t=1729248087; x=1730457687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ro9fjkpkH3w/ouSHekn21o06mn2yyPD+5yp4HVkMA5k=;
  b=BF0mmadzYh6bIP/F+yQv5DqAJ9oMbhqUxMTpYUL3sarOf9vR+aneAUUB
   YDxoYpXHc+nla4bl6K0+CqxVkl6xwiS8A2xd0xzgx+VFyKCcO3wveP/Hy
   u51drCsrDmT7J/fFObAzNGMuE3D8MA+ts/lIw88CfyFTS3hp39z3RqV+3
   I=;
X-CSE-ConnectionGUID: PmD4/LybScCeE03VWpvhHA==
X-CSE-MsgGUID: tcasd55QQn6OoVDnBpH8GA==
X-IPAS-Result: =?us-ascii?q?A0DTAABlOhJn/5H/Ja1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEXBgEBCwGBcVIHdIEehR2DTAOFLYhFMJ4UFIFqDwEBAQ0CRAQBAYUHAhaKD?=
 =?us-ascii?q?QImNQgOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQcFgQ4ThgiGWwEBA?=
 =?us-ascii?q?QMSERFFEAIBCA4KAgImAgICLxUQAgQOJ4JfgmUDAaNGAYFAAooqeoEygQHgH?=
 =?us-ascii?q?xiBAi4BiEsBgWyDfYR3JxuCDYE8C4JHMT6EKTGDRIJpBJIFhCNXD4JWg3UWi?=
 =?us-ascii?q?WKRPwlJexwDWSECEQFVExcLCQVoiE0KgxwpgUUmgQiDCIEzg3KBZwlhiEKBD?=
 =?us-ascii?q?IE+gVkBgzhKg0wcgU8FOAo/gk9qTjcCDQI3giSBAIJRgSUEBYM+fB1AAgELb?=
 =?us-ascii?q?T01CQsbBj2yc0GXb0mvIAoog3KhRAYPBC+DchONAZlGmHeodgIEAgQFAg8BA?=
 =?us-ascii?q?QaBaQM3gVlwFYMjURkPji0WFssMgTMCBwsBAQMJjhsBAQ?=
IronPort-PHdr: A9a23:cCR9xxXuPVI1vNutDeMTfI/dPcnV8K3PAWYlg6HPw5pUeailupP6M
 1OauLNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QcPs=
IronPort-Data: A9a23:iQlnq6xi33Adtd5ettp6t+dhxyrEfRIJ4+MujC+fZmUNrF6WrkVWy
 mMZDzjQOvmNMDemLot0aovj80xXsZPdmIBlTAtlqlhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCKa/FH1a+iJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 IqaT/H3Ygf/h2csazJMt8pvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJHkzEdFf3vd9Ompl+
 NFAcw4ydg6Dp8vjldpXSsE07igiBNPgMIVavjRryivUSK52B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2cPnWjOX9PYH46tO23j2blYSxegFmUvqEwpWPUyWSd1ZC3b4eMJ4LbGJs9ckCwu
 mnP5GikXygjMoK4zgSp9Fi0pr/gtHauMG4VPPjinhJwu3WXx2oOGFgVWEG9rP2RlEGzQZRcJ
 lYS9y5oqrI9nHFHVfHnVBG+5XrBtRkGVp8IQ6sx6RqGzezf5APx6nU4cwOtoecO7acebTcrz
 VSO2djuAFRSXHe9Eyr1Gmu8xd9qBRUoEA==
IronPort-HdrOrdr: A9a23:Q+Crq6l9zxgg6q8sEtEVkzWULaPpDfNQiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtj/fZq9z/JICYl4B8bFYOF/0FHYYr2KnrGSsgEIfBeOt9K1tJ
 0QPJSWZ+eAd2SS4fyKhDVQVuxQv+Vvk5rYxds2rU0dMD2CApsIh2wWe2Trd3GeBjM2eabRf6
 Dsn/av0gDQAkj/Gf7LfkXtMdKzwOEjvaiWEiIuNloM0iXLpzWu77LxDhif2Tkjcx4n+90f2F
 mAuTbUooG4vd+G6jK07QLuBpJt9+fJ+59mPoihm8IVIjLjhkKDf4J6QYCPuzgzvaWG9EsquM
 OkmWZjA+1Dr1fqOk2lqxrk3AftlBw07WX59FOeiXz/5eTkWTMBDdZbj44xSGqd16NghqA57E
 t45RPei3NlN2KYoM073amRa/herDvynZPlq59Js5UQa/pFVFYbl/1uwKocKuZzIMu90vFlLA
 GrZ/usuMq/tjihHi3kl3gqz9q2UnspGBCaBkAEp8yOyjBT2Gt01k0C2aUk7z09Hb8GOtF5Dt
 7/Q+9VvaALStVTYbN2Be8HT8fyAmvRQQjUOGbXJVj8DqkIN3/EtpayudwOla2XUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO9hzWWm2yUTnk18kb7Zlkvb/3QqbtLES4OR0Tutrlp+9aDtzQWv
 61Np4TC/j/LXH2EYIMxAH6U4k6EwhWbCTUgKdMZ7ujmLO9FmSxjJ2vTB/6HsuYLQoZ
X-Talos-CUID: =?us-ascii?q?9a23=3A3DqubWgsxqVpU1uFZSizs/jBOTJuSnjxkDD0MkW?=
 =?us-ascii?q?DAk1kZeXOd2CI5qNEup87?=
X-Talos-MUID: 9a23:y9j9EQazkoh6GeBTqzTlnz0/af5R5fqJD34hl78em5mrHHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Oct 2024 10:40:16 +0000
Received: from rcdn-opgw-5.cisco.com (rcdn-opgw-5.cisco.com [72.163.7.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id 9ADA0180001F2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:40:16 +0000 (GMT)
X-CSE-ConnectionGUID: d0+3tD45QVmm060mgv3j2A==
X-CSE-MsgGUID: VftqmyFdTX26iEY1r4dt2Q==
Authentication-Results: rcdn-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.11,213,1725321600"; 
   d="scan'208";a="18461572"
Received: from mail-dm6nam04lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by rcdn-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 10:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPsc3Qpe1LH04cVOxn/9yBsSqZametb4V+daz3CNWEMT8hURFC1wu7m5VfUa19CWI/S6nhM7NcPiUX+ke1pYy5obu+zRku0peB/AG6ow81gzEOhGaaAHhHCipvxC0Jdudczs7s9bMglOSLoZYl3fA3vGCrU2XtKQIn+OaMzLm11ZuxD190Dch7+F32bs/GK4Hk1eVFqB2W/k/VrFp9ZKb4Eq+Jm/ZZRys6yVRkQkJNmtnK+0k7+11axHTz9NkkfSipyvyXa8mFz1mJLjeLlN34SB7SKKjpFMXZexvri8Gybah4V6Ix47Rn2gdSk5IPP1hYMk7qSZaHo8fXnTLgtKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro9fjkpkH3w/ouSHekn21o06mn2yyPD+5yp4HVkMA5k=;
 b=rjwtskyjxhhb+//yXeXz3iFFx3Zm3GVtDvsI3qTuo5TaoSX3AqO59n8Q8M+XMkF/vS5qEaJ1jp4qaQgGW4BLux+CAREDWXnq7SRGx4JkraOOd6dpd9BhJeu50ErldhCZ4Et5A1oH0KCIIjfv5oWEK9L6I8ALZgMXTFJxeXgxrVpxuwU5u97IiE34tTJLDHul6jwHppbKRgbsJYB6dVJEQ4t9FEELETwddlfFw6u5DKtJ1nVODiDPQ24FZ1ki/qADG+WFeG4UV9LlGSkOY0TKSk8Cr+6gjz4JyEbMMEiryI39BXtMNEYlrVX6/bOkh/vW/FjwrdlvUT/K/K4X8mk+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CY5PR11MB6367.namprd11.prod.outlook.com (2603:10b6:930:39::13)
 by SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 10:40:14 +0000
Received: from CY5PR11MB6367.namprd11.prod.outlook.com
 ([fe80::a96b:f32a:2d2c:c7b1]) by CY5PR11MB6367.namprd11.prod.outlook.com
 ([fe80::a96b:f32a:2d2c:c7b1%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 10:40:14 +0000
From: "Bartosz Wawrzyniak -X (bwawrzyn - GLOBALLOGIC INC at Cisco)"
	<bwawrzyn@cisco.com>
To: Vinod Koul <vkoul@kernel.org>
CC: Kishon Vijay Abraham I <kishon@kernel.org>, Swapnil Jakhade
	<sjakhade@cadence.com>, Aswath Govindraju <a-govindraju@ti.com>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, "Daniel
 Walker (danielwa)" <danielwa@cisco.com>, "Bartosz Stania -X (sbartosz -
 GLOBALLOGIC INC at Cisco)" <sbartosz@cisco.com>
Subject: Re: [PATCH v2] phy: cadence: Sierra: Fix offset of DEQ open eye
 algorithm control register
Thread-Topic: [PATCH v2] phy: cadence: Sierra: Fix offset of DEQ open eye
 algorithm control register
Thread-Index: AQHbGaUCINkyft+830Oqn0+qPmJsW7KLFrSAgAFKO4A=
Date: Fri, 18 Oct 2024 10:40:14 +0000
Message-ID: <06c52602-9f70-4412-8d1c-9247b20215e8@cisco.com>
References: <ZwN+8xpOl4+Ggaha@vaman>
 <20241008171000.2665935-1-bwawrzyn@cisco.com> <ZxEmCWsViATsffE/@vaman>
In-Reply-To: <ZxEmCWsViATsffE/@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6367:EE_|SA3PR11MB7527:EE_
x-ms-office365-filtering-correlation-id: f2ded47c-7682-475e-6b75-08dcef614007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TTVtVVRyMDArWUxPWXQwdXB5ek9McE8xeTVLUm5HVHIwOWxMQWNVSlNiYkVU?=
 =?utf-8?B?a0RqUmgwMWZoNjNiNnVETVBkWkpRVnhScjZIR0pqWTZSZUxDWGxLWitYNVhq?=
 =?utf-8?B?MlNSRnpzYlpRZVB4WlNlaE5IK3FuQnIxMisxVVRwRlIwWnpPUFFqeURmY0Ev?=
 =?utf-8?B?KytSZmRkN1FRTDBVeUZaSmlWZEtXdmVaNFBodHIxeUtDQkJGeTN1eGY1ZUdC?=
 =?utf-8?B?MVpReks1bjRKdmpOUVp0Z2ZTZ3FaZDRyYWFXdHA4QXJBcHdLcXlORjNKVTFF?=
 =?utf-8?B?S2ZXZXRmQ1plbU84R3ovNkI2b2lKT0tUak1zV3RWT2liZ3JQcVZMeU5EeHBW?=
 =?utf-8?B?L25tMUlkcEdsRmN0QjZVT1c2aVpOUjU4SXhtQ05DR2J1S3QwcFdST21Rb1h0?=
 =?utf-8?B?aGNEL1dOUjJxTnR4eVlhTXB6SFkwVUdsdUcwdVJYY0JtQnJGTnpyWm5OQ3g0?=
 =?utf-8?B?aiswM0VJYkJsclFOSXFudkJSeTZic2liTi9FREM3YVlZTmtrbkI5MTJVUloz?=
 =?utf-8?B?VXpVRDZoSzcwb0NXdGlqNEY0MDEzQXNyaTRIS1dzcHQxUFNRZTNXc05pN25Z?=
 =?utf-8?B?UlpTMXowbHRIR0UvZHZPekcrUmZoSHBuY1JzSzlwajQ0Vm1mZGtHVW1QOVc5?=
 =?utf-8?B?NzFWK2NJRUErVDRpZHZ6Sld4M2NJdVlkaUlWckppdVhKL2huenY3M3d0aUJz?=
 =?utf-8?B?MUF0TWozVjlzWFVwVjAwbnNtaVdNK0xvdEhPVExKV2taYWVTWWVrNk9zVW9N?=
 =?utf-8?B?VGtuYzVKRWl3OTU1VzM0M3piUjIzSUwyS01uRmpPd0JxbVFmdlRrZGpoRkxy?=
 =?utf-8?B?dXBxTm5zamwyWEZNVS8zRmM1ZFdUeVc5WjhSR0tzWkloUmhTQlgwd0dreE5k?=
 =?utf-8?B?RzBRM1BDbU9qQkRBclhjSGo3SEtqVlk5UGFXWVBHNHVEUW9JWmVHV1NLeEFU?=
 =?utf-8?B?VEk1UTM1dUdhZlhid2o0ZkxxVWpIeitGd0ZhdTR3MnhvOWVpYld4d2RlUEVX?=
 =?utf-8?B?Q2hCWTFPT0RMRlNleWgvd3hLU0pZTzlUdkxrcTF1YnZPYVZ5MjJlVVRHanU1?=
 =?utf-8?B?MFVXNlhrSjdvSVBhbDZmMUlmdXFRQ0g4QmtyNnlrQ3hkVTMvbElKN3lIdnE1?=
 =?utf-8?B?R3p3QW91SVVTMi8zSDcwNEZLZ25xYmJ6TXEzNTArZmVlV2h6ZFJybU12aHZ2?=
 =?utf-8?B?bnRiZzQ4Z0NpcTdVS1UwZGhhN3dwUFo5Z2twT0tFY0lhdTJUSE4wTVg4Zno0?=
 =?utf-8?B?K1pEZDlKMzhUdXJQWkJGTyt3SUkzVGVaUkpPRm5QbnVlN1NybitsZDFJVklU?=
 =?utf-8?B?WTdWRDIvamFOUjZqVnVqNkVuZFQ3N0xJNHMrdmgwWnpaaUhOZXJ5WndLYlds?=
 =?utf-8?B?aGhZbzI1NlpmaFIxM1UyUjQ2S29VWFVkdit6VnppR2R3WFJnZm1IRk5PVUFu?=
 =?utf-8?B?Q3hxNUc3bGlmNkVWWW42M3J2L0xML1NmZGRINmVUblVnWFpMdGlPa2FEeE95?=
 =?utf-8?B?MmowbXF4QVN6N1pDdlNaM0ZLVWkxMkZjazFJdmQxVFpGVE1ZVXJkby9McHVG?=
 =?utf-8?B?VmtNN05leGJxU09uNUdGN3YwNy9vMndGd3FMLzViRmMxZnVCMFYvNVRzcVdv?=
 =?utf-8?B?SXRhQ3dtc3V5NHBvSklyUHEyNGlrUHJibEZmaWdyUTlQb3pUMjYxQ1JSMnlu?=
 =?utf-8?B?VktZendkd3ZPdEtTQXYyT3JRaDl4MTMwZ2Izb2prRXFEWGhwWmJGSGdiU0lW?=
 =?utf-8?B?dmhwaFROUERNbjJQcXdvbTB2OW5mR3hUbFd4eXJLc0Z0ZEhSc3M3WnpsRVF4?=
 =?utf-8?Q?XtMZjRxXqXuczYPDd8m2uP6w+nykFuS2DpiS0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6367.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTRlMm4zQTJWbTUzUUdIMnJSS1FYV0thVWlBNnoycWlWZEx4VGhXam9MVXhn?=
 =?utf-8?B?a1lSN245bkNMSjBpblVVVDZRdnd0bE1MVVNlTU9PQ0U0TGtpTnBGcUhPVWZ3?=
 =?utf-8?B?MVBJNXJHcUM3VjdINUVPUFlxNU1KT1Jib01yWU02VS9EUzNNbkh2bkV6cGdQ?=
 =?utf-8?B?WE9OMVNEZkw2b0xnbVJvaDNhSHRjVENmVTdQeXJoMk1EekErMFZ1c0tqNzJ3?=
 =?utf-8?B?R2pleHcvNHNRckNQU0l0UnYyMlNuSnVJYWFyRVVvZVorcVUrbGtrS05DRUFJ?=
 =?utf-8?B?d2FYT2F1bkpJbjllb2VxT0RHdUZvZDNEWDlLcWpSa3ZPUy9OSlBBck9vRlhq?=
 =?utf-8?B?cW1qUjBKdFdDNFp4dVVzdk55Y0J5RmdFWVRnMCtyZ05aT2o2VXN2UVFYM0RM?=
 =?utf-8?B?SHhaNU1RcjhBbGJZTGNIRUdFR0ZvL0Y5WEpsdlVGTFg0R2I0S3daSW5SbWhT?=
 =?utf-8?B?bTlzQXJUQ0Zuc0VTblludUlWQTV5R0Z0Nk92WGdweXhHK2ZmbllVcW16N2pw?=
 =?utf-8?B?UHFVL1FjcTBBNXJ1czR6K0VyWDIva2FuMXNvbjdsMTdzc2ZGV1lyRnI0UXVT?=
 =?utf-8?B?dDZrSDFMZ2JEUlB4ZVZvQ2swY29VSllTN2oxYks4ZDRtc3QvTUgvV2RKSUFD?=
 =?utf-8?B?VUdEdEl5dXNNWmhTOXBHdDhhSGV5ZG1wYXVkQ1NwTWhKb3RMdUlwVzBOcUxJ?=
 =?utf-8?B?OUhDS1R6MjV4cmZGR0ZSUlNmcVc1SkJsdFlkeXFsem1OSWpxYUtKRXNuSUM5?=
 =?utf-8?B?dDJLUTY5RUtMQ1d4TzdRT0RVT1VGbUVmY2FhZVJnSU9XbXRYSHhnYUZGSm5T?=
 =?utf-8?B?N0RVa0puTEgvMzJEbVl6eW1sQ2xUQ1pMMlhid0FBWlQzSVQzUmdxRGhLbmFh?=
 =?utf-8?B?YzNLVUYyOFROTlM3b2VVS0Z2aTRORGhkSDh4bS9UOExGWXYzN0dNZUcrcEkv?=
 =?utf-8?B?RUpUanlGYThnQ0MvZVkyenBjVGpsYkVvU1ZQVXF4NVRXT0Z6czZRWG5ZWGV1?=
 =?utf-8?B?UDE1TjZMbllSckU4cDN2SWhZTzZkRHUwNmxyWW80TjdpWkpyTGJ6YlNDWUJw?=
 =?utf-8?B?clVjK0FIUTVEaXVBY3NRSGlnNEFNM1RBSlpITklKTEV6d2c3UEFMQTA5dW5U?=
 =?utf-8?B?YW1ycW9pT3g2dzl1R3pYYVF0bU9kZDhYbGlrSk9zZ0p3Yzl1MjFxSVNDdmNq?=
 =?utf-8?B?VEExR0RlTWVpK2hZTkVHOWd1TURqT0Eybm9kcVVjaWpnVFhNMHl3OXJXN2h1?=
 =?utf-8?B?cFdYdDlVVjV2Z0VzMU44WndoVlNaT1hWYUlMOG8zRWdwd24vRDRGeHFrUnor?=
 =?utf-8?B?UkVhck5lb0dNdXQrWkp1M3lpZi90TzRJNW8zRXpHc1Q0c1pVcTJQRXVJTW9y?=
 =?utf-8?B?UU5sQ0JPNG5Cb253KzM3cE8vbXViZ0dQbFpXTXc0dU5YSFhkSDVqNTFUeklr?=
 =?utf-8?B?VUFzWDZ4eWtvd1JHTTNJeWdLSnZHVW1vdVA3c1ZscXZoS0pJTWp2Q0hzaEdi?=
 =?utf-8?B?M2ExbjRjSFpKdXVETlcrNDg2RUNJM1UrOHZQV1AwcGh0WFV0UXYrWkg1ZFJO?=
 =?utf-8?B?eFRVMDB6OWJDeGFqS21STFM5RzRUSzZKRkt1VlVVNWVqYjdHMWZYdG5JSW01?=
 =?utf-8?B?ekxXeXAyQXFVS1d6cCtzWWsrUW1nK2J6WkdiNmJkT2RNREkwTnBTcU1EbTlD?=
 =?utf-8?B?ZWFCK3VzWnlVakwvOWY0MWVUSUdnaDFtdTdPTWNENnVwcW1HM2gvRWdXNkxN?=
 =?utf-8?B?cGtJbXdBUnBpUWlTOGdlNzIzNHRoNk5uclhYWFp3VTl6dVpmdkpwMUMweWJm?=
 =?utf-8?B?N0ZERWhNMURSeGY3Q0pQL2hMdnNudTJUenhZNnR3UEZFSzMvOHR4czZPSjhr?=
 =?utf-8?B?SlFoa1NpSVpIbkYxcmtCNGcyTnlET1FZZ0RUTE4yTVNBM3JZR3RtdVIzK3NO?=
 =?utf-8?B?eDhMdytkVm9wM0tCVmJNRUZTdlR2dnhHT3F5ME55OTRpTzhxcTl2MXJlRkt4?=
 =?utf-8?B?ZHZ1d0V2eHFrcDRPMEVEclJBYit3bGZjeTE5eE5GTkhKM1oyY202Q2lITXJR?=
 =?utf-8?B?Ty9Zb042aElDVXJ6b3N3TVZhOEF6UmZZRlQ5T1N2eWYzcFZYWTdPSTdiekJV?=
 =?utf-8?Q?W5/kTow52Vtga5YnuJwtXb8jh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC5A597C928AEF448A2D3A696BC0F573@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6367.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ded47c-7682-475e-6b75-08dcef614007
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 10:40:14.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njYeNZVyH8NycK7Vw2tcTohALsv3g5MtcYRaj73JpK/iRJUEj0VfmrLW37ire5UKdQepHC1yBsqIEuqzYEqF3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7527
X-Outbound-SMTP-Client: 72.163.7.169, rcdn-opgw-5.cisco.com
X-Outbound-Node: rcdn-l-core-08.cisco.com

T24gMTAvMTcvMjAyNCA0OjU4IFBNLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBPbiAwOC0xMC0yNCwg
MTc6MDksIEJhcnRvc3ogV2F3cnp5bmlhayB3cm90ZToNCj4+IEZpeCB0aGUgdmFsdWUgb2YgU0lF
UlJBX0RFUV9PUEVORVlFX0NUUkxfUFJFRyBhbmQgYWRkIGEgZGVmaW5pdGlvbiBmb3INCj4+IFNJ
RVJSQV9ERVFfVEFVX0VQSU9GRlNFVF9NT0RFX1BSRUcuIFRoaXMgZml4ZXMgdGhlIFNHTUlJIHNp
bmdsZSBsaW5rDQo+PiByZWdpc3RlciBjb25maWd1cmF0aW9uLg0KPiBUaGlzIGRvZXMgbm90IGFw
cGx5IGZvciBtZSBvbiBwaHkvZml4ZXMNCj4NCj4gQ2FuIHlvdSBwbGVhc2UgcmViYXNlIGFuZCBy
ZXNlbmQNCj4NCkhpIFZpbm9kLA0KSXQgc2VlbXMgdGhhdCB0aGUgVjEgcGF0Y2ggd2FzIGFscmVh
ZHkgYXBwbGllZCBvbiB0aGUgcGh5L2ZpeCBicmFuY2ggDQooMmQwZjk3MykuDQpUaGlzIGlzIG9r
YXksIGFzIGluIFYyLCBJIGp1c3QgcmVtb3ZlZCB0aGUgZW1wdHkgbGluZSBmcm9tIHRoZSBjb21t
aXQgDQptZXNzYWdlLCB3aGljaCBJIHRoaW5rIHlvdSBhbHNvIGRpZCB3aGVuIHlvdSBhcHBsaWVk
IFYxLg0KU28sIFYyIGNhbiBiZSBkcm9wcGVkLg0KDQotLQ0KDQpCYXJ0ZWsNCg0K

