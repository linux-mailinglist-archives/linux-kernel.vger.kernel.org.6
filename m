Return-Path: <linux-kernel+bounces-333116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4562597C418
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC92F1F22C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785414EC44;
	Thu, 19 Sep 2024 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="CRrSvfoY"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C818EAB;
	Thu, 19 Sep 2024 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725691; cv=fail; b=XnKqMnlU6oebiW3Ve464lH7p5VwxTMlH4ivosaNRz0rAd/spGRmkPb9QKN4UbA/2NO7J3HYslJ62u3dBj0pp2hgsPpsVSldIPtN+3fRs+Vswih3KVEMehb1GwqXZN5kNpt/ghOwSHujle/4CaIMY2QnTL4W0EiGS/MRU9ehX/xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725691; c=relaxed/simple;
	bh=hz4aXPfyPn5ifDECOsVlZnvyAlOW4DWV4aXuD6uENDo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eAv17ob158ejDnX1/w7f1p04iVvjy8bXKt2SZcMdlVfpYrWY8q1Kuki1wme/O78SElhPmZcG069PVcBUBVUQ7BWnrXLfhjrl+F8sAcasQfvdbYsv0p6PneVFCPEcACd5/UZ7gsX96jPB/WycKr2DYiPduczsZGmHDD6SECNXsHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=CRrSvfoY; arc=fail smtp.client-ip=40.107.215.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRDYgX0a3b1QXASqecxINwN6LrwCdxeYeC+meE4AyG1TPGMQmKvw6L/Hktnr8efs4zHUtyY4pBnBOm0TZGHPruNEHJH9HwiJjQUxWgGuez6olrUrkMxbByQDqiEdfcBFUHeOS35vwLJTh0fxCZt8gIIn5CkCLkBRRqilMKNOZzUBH54i2sJamQPFUAgt2SdWRqGiDP4AR1vY2OVTiknWA6wYczaxXmdVVOCnWCHkfufjMochF5IrNGtUfHIB4vSFEm2SEQeVKnXpza9ajqKSbMbztFzeX+jJCiVjGIwev60bRt9jC3TttIAZANkrbJ/VkmiGyD0zD7VSN1jvaY9OPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hz4aXPfyPn5ifDECOsVlZnvyAlOW4DWV4aXuD6uENDo=;
 b=Qf6Snu2wcrp5/yPT4rQ6j34eL4MjzQfcIJBnaixTHg/avbvDh5G21UjpW+NnwsrUlIaPpdyVCsnB2kLbgNnafhlpFZzD15vc8p+ptplrRY/OeBMxiDv+vjbqIcCMuCheO6paDWoGMzyIQ5mueZFTud1NMKy7oIxUM5Pv+JHDh7wQ65UIeshnmX43Xz4WKoZFAmLHpxufV5bU1DzG7VPZMcXgj8TJT18/sXF4fUxN550zBLBzn5mJBNxnUOwnJi02jFgm0uBfcsEdC+z7+ZvkhttniEJ23yq507tr29bUb6hnrlaTMf0IQdHU6cBSHDvmz08ChI5fJz0vgWeL9pP1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hz4aXPfyPn5ifDECOsVlZnvyAlOW4DWV4aXuD6uENDo=;
 b=CRrSvfoYeB2BnuGGTDi6vxKz2bR71HSn5i/GcWJu9DMf1woq/Xtg7F6ol/Av44DWCpFpmPdyl+G0I7841cC/h/z7ojxGOKLVGW2cT0l4ksVIabdyRN74TL/kzwsNptwYiQYeA4voLhX4JvHIQihs2P42DJCj7NrwlchcDcCI0b42iisciBSZnvkixBaBvkKaVgHk0UbPsD6RHGfUwLwl+QUlpKhn2wTuV9nwC23Li/sVLGARjJaCRrN1NdTajmXv4Bzd5YLKR/GAGhsH/GlljBtT8SFdmtiBMbSxXD4NJ/qyM+uIzhv98x7fnnGMoqN/cURR9F5Doh3HXzJ2U0dThg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by OSQPR06MB7155.apcprd06.prod.outlook.com (2603:1096:604:295::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 06:01:23 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 06:01:23 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 2/4] dt-bindings: Add AST2700 bindings
Thread-Topic: [PATCH v3 2/4] dt-bindings: Add AST2700 bindings
Thread-Index: AQHbCBhUQ+ayLz0D00qz0gJFvBN4g7JaMBwAgARxxVA=
Date: Thu, 19 Sep 2024 06:01:23 +0000
Message-ID:
 <OS8PR06MB754148AD165538D3D6B6C3DDF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-3-ryan_chen@aspeedtech.com>
 <b9bf19af-0c3c-4622-9124-a66d9df649b2@kernel.org>
In-Reply-To: <b9bf19af-0c3c-4622-9124-a66d9df649b2@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|OSQPR06MB7155:EE_
x-ms-office365-filtering-correlation-id: 5a0b3c71-236f-463c-7661-08dcd8707d8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0JyRHRoNnFPRUtoSk0xK3drandpb2NsczR4T3kzSTBEeUpodEorTUI4VjZC?=
 =?utf-8?B?Qy9CUExiYzNtckJNK2FEVUlwQzBPN3o4bDB2eGp2YS9YcHFCTTVOWXoyZGFS?=
 =?utf-8?B?UE9TRGVES2d2V3ZFUFpVOW5CdzgzMTUzYTY3WHlQQWR4dVBNTmo3SkJzbWE2?=
 =?utf-8?B?OTcxRHl5Q3lUbmdyOWtaZ2g1U001ZEgyYXlaZXJrSHJ2RVhoZVp0bWU1UTh2?=
 =?utf-8?B?Nmp2OUJJSWl0S2NVNHN3MnhadmdMK3JpaENXOFlmcEFLV2ljQUk4cm5VYjJX?=
 =?utf-8?B?ZE4vU1lyWDdsRE9yUE95T3JCcGxRSHZiTnBpK3Y2eXVnTHdtazYzRklpUEZp?=
 =?utf-8?B?a2RobEdPLzJXVzZ1MzEwaDBuZjhDa1BBSDVIMEM2dk9GbXV3Z2xwKzVpRkVG?=
 =?utf-8?B?TkdPWjltK292QXF3YW81cEVKdkh1QWw5UTROVDlQZ0o5ZXZvdm9IM3NUSVZo?=
 =?utf-8?B?YUhaV1k3OCtoZmFEZjFkTHBkYURxYkVFMU04T1lmYVE4OTY2NmhYQi94eld0?=
 =?utf-8?B?bVNPN2MzcE5BU2ZmdVhoc2lDRm13ZEh6S3MzR1J0YzlCOWpNaDJCUzZYS3VB?=
 =?utf-8?B?TzdqaDFsOUtVUjYvWUdmc00rem1meDBtdVd2UloxYXVYNjFRcUlPRFdGOUEz?=
 =?utf-8?B?N2FTVjRRMWdWT3VZSkJPMmh3cHZhWFNyZUFZbkVsVkZGcGFlRGhVNHZDcUpp?=
 =?utf-8?B?SlZkaTBTQTR2aE12UU1RaVRNSmF0aVI0WnpZbFNxbCttdnY4Y081TThKbkxE?=
 =?utf-8?B?VWZkWkRJV2JmWXd1MnNnemFEcEJlYlhzMmg1amhjMTh3RUJhNHo0U2JGMFNK?=
 =?utf-8?B?SlE0RFllQWhIaGk1aG81Y1RQRHNUejA0UEhwY25jYzErQmRjSWtzNTNEK2ds?=
 =?utf-8?B?RUU5TFE5T1JzclpuNFpCbm1HMW1jYm84YU1JcnZiY2NIbWFTR0NOZTJadFNs?=
 =?utf-8?B?cEVZcW1FU1l3WHREY0x1eE1GenlESzNtT05YNWF0ZmVTeXRoMTJsU2ozRG16?=
 =?utf-8?B?bmlaQkVTdHIvYVl0YVdJcUs0SExMekVzeGE0em4yeUxkNzBNV05jeE5mZWRP?=
 =?utf-8?B?Y0hBOU1sdzNJQ1E3QUNtMy9WQjZoUng4VG4rU1RjNUFJMk4xRFVPZlNadlBJ?=
 =?utf-8?B?cEg3aG01dHpCdXN5a3YwNEhuNjNiRVdleDBzNkxXYkl4VmhBS1Q0dFhiSVVP?=
 =?utf-8?B?MXlmQkNZeDdjNEo0THlVZzlCd0l2WXA0NnR6dzFBNUI2SGJ5cmJqTFZ2R0I5?=
 =?utf-8?B?SnhNemM3ZWYzNmlJVFROakx5NmkrNW9HYjhSN1FGSERxeWpvRGNvZnY2WmRY?=
 =?utf-8?B?b2tqWmp0a2ZRWnFSbTRtVXpNb243T1U0bzdLWE9EbVlOS1J0UmdnTlpzZ0xo?=
 =?utf-8?B?QXM0WXVEblY5MXpMeGVGaXVvSXE0L1VLK3lraGpxdWN4T293cllEMDl5MEdB?=
 =?utf-8?B?SHhRWldnZ1QwQkdUbkUrMWwrV25tWWVhVU1VS2tEL2pVTlQxaU9pZmJWSTho?=
 =?utf-8?B?bUh5WlhPZUtsaE9CbzJQYnJyRDAzV2lOYVRTcFdoUW5NZEJWNXFmYkhtUVpt?=
 =?utf-8?B?L0J2WkN5STN4M2dBQ202T1RhQ3pEWHNvcHZNTUNrK3ByNnc0RVcxdFZHckEw?=
 =?utf-8?B?K0NDVmphNjdZWWJBTTBUVTZmYXVxVkE2L1lpalM5cGRHZGM0UUJLbE8rTWE1?=
 =?utf-8?B?QlA0NElQanIwRFJMQXlmanBQL3BQRUE2amYvRk90bkJjU1YyaFNNTVFOblRK?=
 =?utf-8?B?TmVaL2lqRXIwNnJkODAwKzc4YlBHcHRuUklwYkx6RS9ZUEZ6RUhFdVA0NTBU?=
 =?utf-8?B?SERNdG1UUzNqeHJZTnlGaVArZUJGZ3ZtZDlpcVdrRlBwWHJBZS8vUHI4VWJt?=
 =?utf-8?B?ckxPOFFocnM2alloTGdPcEN4bTNyS0VhaE9YbjgySTFoTHh2aUVKVVNXOHA5?=
 =?utf-8?Q?0IQ0Y3eI+WU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkVlTUJaTVNENFptQ25ESlBnbThqVmZkYlZKZFZlamk1Mmtjai9idUxkWDZN?=
 =?utf-8?B?byt3L1pZMG1uQ1dQNndaWGpJNU5CK1RNeVhuQXpzSlVOZk1zZFBpajVWOWUv?=
 =?utf-8?B?RFl3bk1hQitSM1pieEl4ZzJZMnc0VG1oV0pyZzEyYWYraE5MVFFDRXlUQTdY?=
 =?utf-8?B?ZVFaSEdUaEJDUUd0VWxGTElJVnk4UHhITGE0ZjZ4MTJkRExZTEs5NkNMSlVN?=
 =?utf-8?B?TDVYYzFLeDFqMWYzTDNqSTBnZ25EajJtZ2RxZkZXWDdiZjhpQWpTelJaRHg3?=
 =?utf-8?B?cjVWcUY4TUNSMEdvVUpCMTBsWHY4SU1TYzNsVU9vdCtxbnAwbjFTMzMwOTNF?=
 =?utf-8?B?dGpuRGEvZWhMNEljMkVPbXBxRFlFRTB5cENLVHJRckFDR3g1ZktOeWFZL1hm?=
 =?utf-8?B?YmlLSGhCODRkeDFmNVN1Y0NZRmpiSkZxUmpmUS92WmxHRlRKSnZpU1lDS1B1?=
 =?utf-8?B?MTR0cUNEcUJJT2U2VUVxanpWNkc0MkFQK25hOUs2LzhWaG1ubm5wRC9Ud05J?=
 =?utf-8?B?UFJhWWl6ZlhOaWw2dFVmMDcvM0w5TnJYRlhCVDl3QmttOENCRHFieXVoWWY0?=
 =?utf-8?B?WW5qbDQycXRNbnBVbGpmNkk4U21tSE02bnY5NklxQWU2eHZmalJvZXF4Y3pF?=
 =?utf-8?B?bnlZN1lSb2o2dUZYVVdVbmtoQ2NBZXRxK2ZlNm5Xem1VeDNHd3dmcXVpemtL?=
 =?utf-8?B?SXFvZHJXWnFXM3grVTB0TXFJWkxSUGZkRjVyeUUvNFo3alJ5QWlaOEtqdHVi?=
 =?utf-8?B?YnZ5UXRWUU5tU1YveWFOMzEyMDNFNjMxRGY5UngzZmdDQld3YStrVGZuR0Zh?=
 =?utf-8?B?L25hd3RoTm9MVk96YUFpOUpFTjJOakFrZUFjSUZLTnlGc0ovM3ROTmVySzN5?=
 =?utf-8?B?NFhXUTBTaVJvdEwyWDVuM0EvRnFKenFTR2d6TzE2ckFmeGpYTE1PYzFiQjFD?=
 =?utf-8?B?bWpZTTBIbG1lZ01ZWTBOZ1VCTUpDVEF4RGsxUmdFL2YzRUtQejNhRnJYdXRp?=
 =?utf-8?B?eEI2SFYycUpCcFJvMEUxYTJJanZnT2Nobkh0anRrdHkwOUVOdTIzZmdBdHh3?=
 =?utf-8?B?QTZLUk9xT0M5NjJ3eG9qTHRGMm9jR05MSUxOeldlWjBWYm5XSUxnc2REa1Jw?=
 =?utf-8?B?ZEtibGFEZTF4SzZtM0RVbm5ZM0UxaU5ZbTI2aGNDMSs3ZGxVUlVQaEVxQUl4?=
 =?utf-8?B?OXNKNjR0QlBCWVRBQ2FLSTVidE8yczRNWGhQYVY4R1hmekx4UUgzSHFBVlZX?=
 =?utf-8?B?MXZjQkpUOWV5dlg0NHlBdmFMMzhCckpSc3lEM0x1OWlHek5nZDRIQUhCdCtN?=
 =?utf-8?B?L3V1WHByQVc0N3dnN3VZeEdtTzdORnlYek5xNVpZUjZnaHc2VWdvenQ0NXdi?=
 =?utf-8?B?TStaNHc2enNKTks4U1M3TWh0anBSSEhtS0ZnR3UyWis5cTVnM3cyTE42ZEs2?=
 =?utf-8?B?UjgxWVR5N3NSRWg4YnZRdU1zK2ZoUGZTc3pMRXVUTEVQQkZRbzF6UEdBRmt6?=
 =?utf-8?B?UCtPcDg1YWw1Sm85K1p0VFF3TEl3ekRYRWdrcWl5UHNiNzVYbXBaOEFwRkNt?=
 =?utf-8?B?QXF2a1pDTC95ZmczYmpvUC9lTmNGbzRWYk15YlNnYVJZSGV3Q0NJZ1UwQlJQ?=
 =?utf-8?B?UHg5SE4vbFkvZFNLazc3WkVQQ2pFTDVHY2dKcVNKSDVhUkJlNVFNa3lHWFRM?=
 =?utf-8?B?M21kSFVrMEozOXdkMGRRODF3SGZxZ2wyWk1zYXJ4Tml2Q0h6dlV6QTFJcitV?=
 =?utf-8?B?ZU82R3c5ZG5GRERRSXlmeER5K0ZCdURCVU5kdEdjMzJDTjdpaktQWlN4VDhO?=
 =?utf-8?B?SFdMZjR4RjVZWU5rdUE5SDZ1VXlJS3lyMGh4R29GZzJMeC9uQkVsWGxJYzdC?=
 =?utf-8?B?NWpwd0lPWW5RYjZ2WDFGeDF4UDZ4dzlmRVluRHdpQjhBYWQ5LzJERTd1c0gv?=
 =?utf-8?B?UWp1T3g1b0JHQnV2bmNXZjdKZkI5NmJiQkNpTlNYQTRnWk9ZTzZyemFwcXph?=
 =?utf-8?B?SmlOZFBLK0lYNDJnVFlSY1J3Um8vS0NTVyttV2lTbTI3a1l2MmVYdy90eWhR?=
 =?utf-8?B?Z3JCcjJiZGN6a2dWY3ZSSlVVeGUxSk9Tci9iSGFoL0FVSlRJVTlTZFBYSTVP?=
 =?utf-8?Q?XIIySdyS2L/YUrp7rVWqFWjdB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0b3c71-236f-463c-7661-08dcd8707d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 06:01:23.3882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkP49DFBmfsK8OS4ZZkPhjMRr/S+m2cePPZc0Exspa/i0QOCeAq09r0aKXqzjHbPs/djvrGtnQvd234R4AZf9as66CQOm95M9Eug7i7d4PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7155

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvNF0gZHQtYmluZGluZ3M6IEFkZCBBU1QyNzAwIGJp
bmRpbmdzDQo+IA0KPiBPbiAxNi8wOS8yMDI0IDExOjEwLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4g
QWRkIHJlc2V0LCBjbG9jayBkdCBiaW5kaW5ncyBmb3IgQVNUMjcwMC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtY2xrLmggICAgfCAxNjMN
Cj4gKysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9kdC1iaW5kaW5ncy9yZXNldC9hc3BlZWQs
YXN0MjcwMC1yZXNldC5oICB8IDEyNCArKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMjg3IGluc2VydGlvbnMoKykNCj4gDQo+IFRoaXMgaXMgc3VwcG9zZWQgdG8gYmUgcGFydCBv
ZiB0aGUgY29tbWl0IGFkZGluZyB0aGVzZSBiaW5kaW5ncy4gWW91IGdvdCB0aGlzDQo+IGNvbW1l
bnQgYWxyZWFkeSwgZGlkbid0IHlvdT8NCg0KU29ycnksIEkgbWF5IG1pcy11bmRlcnN0b29kIHlv
dXIgcG9pbnQgaW4gcHJldmlvdXMuDQpJIHRoaW5rIHlvdSBhcmUgYXNrLCB5YW1sIGFuZCBkdC1i
aW5kaW5nIGhlYWRlciB0byBiZSB0aGUgc2FtZSBwYXRjaCwgcmlnaHQ/DQoNCj4gDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAw
LWNsay5oDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Jlc2V0
L2FzcGVlZCxhc3QyNzAwLXJlc2V0LmgNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0
LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4gYi9pbmNsdWRlL2R0LWJp
bmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjYzMDIxYWYzY2FmNQ0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNs
ay5oDQo+IA0KPiBVc2UgY29tcGF0aWJsZSBhcyBmaWxlbmFtZS4NCk1vZGlmeSBmcm9tIGFzcGVl
ZCxhc3QyNzAwLWNsay5oIHRvIGFzcGVlZCwgY2xrLWFzdDI3MDAuaCwgaXMgaXQgb2s/DQpIb3cg
YWJvdXQgdGhlIGFzcGVlZCxhc3QyNzAwLXJlc2V0LmggZmlsZSBuYW1lIGlzIG9rID8NCj4gDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

