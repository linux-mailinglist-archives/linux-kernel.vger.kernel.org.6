Return-Path: <linux-kernel+bounces-282130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3694DFF7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 06:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF871C20D11
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F41171C;
	Sun, 11 Aug 2024 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gca7pUwR"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B9E57D;
	Sun, 11 Aug 2024 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723350006; cv=fail; b=XcS+axmqOCFjOopmqQtC46gngddutTsMpozouHMa69ndsb9jMaplGZ7wCt7LW9lblNJnJSK2R83g71XOZ7wSz9tknS+GgNumO0Ae0MVXxeCKwx1oXXRkRa73eBcOKo+ucHb/KyaWuVITOEdA8oZiDp0T0Z5aDqop+rjrpyOQrMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723350006; c=relaxed/simple;
	bh=RAGDmrvKfvTTEzJsQgI/E0Otqe0HHzltuxfSf29GkwU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hXRZX2HuiUGrfW4qB+vjfGbv+T9n3uRz44m0yeH57HZSOUPYsf27xmQD0kDuuxrhhL2p9Baz2VSMkQvX5XnqVaMZ9n+4OtbA1+dDk+MS7PvMv726pTy4VpfjWJxuzOOCh0SUdkBx7132EnetG5e5WfWQbww1XUNOEg6Jfknac6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gca7pUwR; arc=fail smtp.client-ip=40.107.215.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAJaC6cSFkFHaFVTOG7KI9JiqhuGmZ7UsAs683mu0fumgMQG3e54mJpmnFX44A+n/G2wSXHtlGfKSFdOzt6aqZzYTw5Zr43jWwdHWAkvB4SCE/WwegFz3/AQchF+k21jodlnpDM/StEV2DGlbQMXwmaIvcmFGH8ibssmBgQrqOedCO4vObhPYHAoXRmluPjEAKY+HM/R25Ren/BAf1UNwz4Cyl0bVfSRfJvr8eXwZ+Flxhwh6pGigThWhYlcNjVpgctiR1nwDjqD5nPH80X4JRyFRu+G1TsHI8zzl4ECIX7HLrHsSo2PJeEHhFCrjMP7btMKp231tcODGbRd2xliLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAGDmrvKfvTTEzJsQgI/E0Otqe0HHzltuxfSf29GkwU=;
 b=ibGc9OozJuJWTWQCOmCTL2FH0a266Xp4OAZx1Z6KXF5deAK00Iez4qp543u9L+nrQjz27sI+EwlHTC07j33Xgf+kmW/ecdbQdxJOctruhca6C3WysTScD1epL1SMWvu299s3d8o13qDteufJjYJXAI8IPbTOpH8bYsZUEg9PQpkwj/7N31vOEdQQkHHeOopdJK2j94l7tiZEUEUNmF+BO9LtzsnhLX19INR1UNZ59PGT2Yk+5rs2xG6R2nVw1aWkkNJGlt59s5Cr8Zv378DKuuuFsJD5HnMhbY3b3wVrkKTLsEiKl0pF/jdxMljPmd57guxsSWg/Z8VVP90nN+HdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAGDmrvKfvTTEzJsQgI/E0Otqe0HHzltuxfSf29GkwU=;
 b=gca7pUwRK+OpgnDB4Z765Ww6OXKhFCJx0X0NFR2sd1/za5F9ZS5k6pmeH9b3Ep7KIC+UCJMEcWPN1KoREbDeORlFFDfh/vHhPm2FlLFLRVXtsw/CfRTLnPJZo3mDfvRQKaTStFHNcbC8deoei/RpTdQkmHfzldgz52zyEBA+k9zzGe1QttlAyfNpMwTV+MjcRlmZK11I1CgYaL9h/dFR6y5N2ovhsJdvIvhHdTMKgtC6/Sz94Rh6eC9T94lkmMGtdupuPClrM1l5+CfStlHXAO/qj2qlDYhSxAS1Gm9yluEP4gFVOc4a7E4jcKAJhY+WeBzgSQHinmVuqbaZJbgNsg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5439.apcprd06.prod.outlook.com (2603:1096:101:cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Sun, 11 Aug
 2024 04:19:55 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7849.015; Sun, 11 Aug 2024
 04:19:55 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>, "sean@mess.org"
	<sean@mess.org>, "alexander@tsoy.me" <alexander@tsoy.me>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>, "knuesel@gmail.com"
	<knuesel@gmail.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIIHYxXSBBTFNBOiB1c2ItYXVkaW86IEFkZCBkZWxheSBx?=
 =?gb2312?Q?uirk_for_VIVO_USB-C-XE710_HEADSET?=
Thread-Topic: [PATCH v1] ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710
 HEADSET
Thread-Index: AdrrpT4p2z6KppW7RYaY4XvOGYj0YQ==
Date: Sun, 11 Aug 2024 04:19:55 +0000
Message-ID:
 <TYUPR06MB6217A8E5ABC66AECA2598F69D2842@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5439:EE_
x-ms-office365-filtering-correlation-id: 3502595b-d630-41d3-aef1-08dcb9bcda9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?NHg4aHkxY0lidDBLbUlnS0xBUWlFRnhYVTg0MFkwbWNaMm5aOXdpTjdVWk1P?=
 =?gb2312?B?b0IzRWJnY1JTOCt0akxmQmFTVmZCWkdEZ2RnckxNN2hjYnArdUtMTXlsVWdE?=
 =?gb2312?B?RFlUR1N6NjVyeWZyNkYzRGV3VHJVY2dNcmo0V2ZaSVZzc2xaMXJhWWxKczRJ?=
 =?gb2312?B?SGZPeW1ZTTFaVFpyUmxON09jWDFBT21LZ3h1NHZnVDdIbk9wcDEzS1NYR0Yx?=
 =?gb2312?B?N3Z5UndHL3A0VW5ZTjZYOE41cnJaNTYxaUhJaHFEMWNzZnRYQ25Wajg3UEJs?=
 =?gb2312?B?NWRRdUljZjZ5Vng1MU5OUEdYQVR2bjRNSHEybXRGMThrdlJrc0FwVWZraDJI?=
 =?gb2312?B?ZmxqelBjOUJ6SDBPaXVGb1NWWUprbWZ5MHVBVEY2TXZON3lka1Vnc2VLS1RW?=
 =?gb2312?B?RytERHdaT2tXQ0JBc2RjZlNaaWluS2wvcUl3bk1senUydGpUMGUwR2M2Ykxt?=
 =?gb2312?B?YlpmSUpEZ09KK0VmKzg5T25LQ0xtelBMSDBPL3l3SVUvUGJUN1RDYlB3ZEpG?=
 =?gb2312?B?cVczMjFtMGJnZGEwV1FBM3hvdjZXbDN2NFdhem9kZHA5eFdJYmZ6Q0lVRXJ1?=
 =?gb2312?B?MmlIV28vOUY1dmhTSUZVS2tub1NXZFdka3Y5ZVlOZWhSenVncHEyNm04c1h1?=
 =?gb2312?B?QmZvVm96SXlnVzJlU3M4ejRUV3NDdDUrVENpdGhRWUZQblRtc0JOSDVONEpQ?=
 =?gb2312?B?MWo0dTdpRUpma0FLQjJaYWYyeklBR3VFWFRhUTJFazlwdUxCSmd6VmxCcG05?=
 =?gb2312?B?YmI3eWtoa3R1VTZLUjU2Z3hxVnpGeFljc092L2l4K1Z6N3hFcytaMmxMa3l4?=
 =?gb2312?B?YVFUR0ZxejF1bDRrY0taQlFZMU1mc280S0p6ajJWdSs1Q3NEOHVuYmNmNm1W?=
 =?gb2312?B?cFlLQzFxWitqSVVteTM3WTNaME5uQU9LUnJUMlZld0pJdVVDNXJrRXc0UUds?=
 =?gb2312?B?Mm5ad1BIamlIWDF4Rm1iNjdLSzgvV1FqQkxEMXE1a2NmTERPVFBBUUlQaS93?=
 =?gb2312?B?SDlRQjBTQkk0NTcwK3hWZmthM3lOeWk5RnNIbzVtcU5zOWpkQnRCR2Z1K1RE?=
 =?gb2312?B?MGU5ZVZZRWNTR0FnRVhDNmpHb2gzeExaVjA4cXRSNFZ0N1IyVVZSQ0liU1E5?=
 =?gb2312?B?U2hnU1U3SVFjbzQreUVoSlJ0TTh5aTZFS0haVm1GazRpWnlIRTZuRjI3VEww?=
 =?gb2312?B?Ylc4bHljM0hRek9WbExjcmhFdkVBcGJTNVA2amJFZnVibi93aitVVzFKSTFE?=
 =?gb2312?B?Z0FITEVNWTJuVGhyZkRMSGlOdDNacFFNcnYxNUtCT0d3RWFVUGNxOStBRVBX?=
 =?gb2312?B?dDRnQTYxRzFVeE1Na2ZxL2VyQzJlSGpqS05EZk5jNllBYXFKc3MwaUFIT1V5?=
 =?gb2312?B?bkpqTGpqZ0ZSaDdMY3hhMDJhd0d4QU15OHBSNzJKU0E5aUttN2hxa1lvL1RM?=
 =?gb2312?B?TGhRQ3dDS29yVmNxaFF5TUI1UmxCZ0dEQWJSODN2VGJoZm4yNkF3bG5lek9M?=
 =?gb2312?B?Y1BuRnoyKzk4U2RyYVdKdUxhNGRDaGNielhNeVhvZ0Frdzh0L2VXMnZjcmlQ?=
 =?gb2312?B?c0RqVE1DYmFEUWxLdkdHQnFDS2NYcXNvd2MzbTIwWTVMSXBZL0JxTTR5ZkFL?=
 =?gb2312?B?Y01ERGpZTlZKT0t6VXFGbDFGemhMTERHMnorSnk2Y1lYWjJLWnhTTDMyRFF3?=
 =?gb2312?B?K3NqTWtjSTE1M1ZlVkYxZXJvbStzLzFOdW1FRnJ5RHFwODhzSkd5Ymo2ejdW?=
 =?gb2312?B?RjR4aDdGd1hXYUZWTmMyQ0JrTlI2QjgwUlRBclFlMGg4YWZVeHdXMjNhL0d6?=
 =?gb2312?B?ZnMvYkhBSTBSWDBxbkl0QU9FS01pRUJNQzFUc3JraHAzZGZkOHl5d1Y1Z2lL?=
 =?gb2312?B?VjR0R1VKQWh1OERmLzJsaVJHK1NaTEN4QjdoeVU4clUxbGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SkdtazFrd05YVFRzTUlDVHFMQVhwTmxlZVpvQW80SnpRVDRkOVJtcGEvRElF?=
 =?gb2312?B?bFRubnpGdW5oZXVDQlhTNVlSb1VaTy9qdGV5OWNnTjJZYXluTys0bjJVZjlP?=
 =?gb2312?B?VCsza2ZlQ1N6bU1mTEJHTHNlZldFcmRWZkF5SVhqS0FZc0J3Z0dzRlQ5Tkgx?=
 =?gb2312?B?R0tMMm9Fcjd6U056Z3FsQk1hUG1aSTlteitWck5VMjNGYmFHeXdrQk1qalM2?=
 =?gb2312?B?SCsyV2hTRVhpTG5idm5sSmpubXZCM1Q0NUpBbHp4dnF6S1QyNnlmZTZTVFUy?=
 =?gb2312?B?cEh4MWIyRzRpUHFxZEtNNlV4WEp0MS9iem13Y0ZHSTk1Rm91MXg2WHdvRlpN?=
 =?gb2312?B?Sng0dzhhNGJXbTQ1TDlFTHhRbkZNSDZSSWFUamp1cHRBV1Q0bG5tWHBCQ2Jz?=
 =?gb2312?B?YmNEZTlSdkVVN2JCNXZqaGdISVA4REh5WWV3endRMG5NR0RudXExU2ZnaVRy?=
 =?gb2312?B?TmpqR3B1VUk1eTZ4a0hoRExLbUtaWmtTcDRBdGdrRm1ZOVQ3RkgwZlk5YVhK?=
 =?gb2312?B?cHEraHRORHR4QTZVNVlPbXBkcUhpemZEWFEwaGU5QWYrT1JWYmRHZWI5T1NJ?=
 =?gb2312?B?MnBuenFsUmMzQmk5b0FNWlM4SEMwbWU5R3ZoQVFUZlM4MzZZTStPMnFEaDNB?=
 =?gb2312?B?QldHeCs4RmI4VTNxeFpsbGpkRmJYSm9SRXBhT1lKRHRORklmZkdnbzVSMUVx?=
 =?gb2312?B?SEtrVVJkWjF5U2lHQldjWTVmVURodjdtVkhIaUk2ZVU5SGZCMkVMVnpUTGxa?=
 =?gb2312?B?am84bEZYV3RGQ2J1OXFiVkFUeVU5T3NBaGdEaWVuYmZrSDNIMXJpd0VCcmF2?=
 =?gb2312?B?YWkrbG1XeGt5UUUyd2JtTjZmMEgybWY2Umd0U3MzdmZYZVNvZTZiRFRLZVNN?=
 =?gb2312?B?SnVnM09pcEd2b3RVNWluaVptVGo1c2JkMnZ0TlhDUHN3OWF0eUpURERVQXNi?=
 =?gb2312?B?K3VBVFNubWdEaGNtY0FwVW9ONmZnNUxoeHRVUDBIQVhuaHVWbGRpSWJjR0RE?=
 =?gb2312?B?dnZBVndabTdvc1hOQSsraXMyWU5NYzNXRlptMWh2SkNBOUFla2p1WWtzeXNo?=
 =?gb2312?B?akUyRmVIUVVHQVUybklHSC80cGx5TFF4eEJ4ZlZ5QUpmNmwrbkJhOFZrM3V1?=
 =?gb2312?B?N1lKSm41KzFPc1I4ZDdRcDdGbHJKcUVtQUVBYVlVVS9MY1dyNUFrSGFXd0FJ?=
 =?gb2312?B?ZGNNSUJ1TytrZ3RyVjlENlI0QXRQdXdkRS9WZ1kvbER5UElMYUxHTmJSUnB2?=
 =?gb2312?B?Njl3VG9yRGdQZzdHRTFEWjVjQk1kTXVRdFI3YittSHhQTHF0bG9CVTA4bCsw?=
 =?gb2312?B?MWJEOGI5NHVDOVVCV1ZjMm11TXhUZTRYc1FMQ1F1eTZaa0NBck1ZdmJBdU1y?=
 =?gb2312?B?TGNta2NSRXlOMWZKeTJCZlJBY1RrVGU1QXBoR2ZMQ0J6UXFpK3FUdlVkYlVx?=
 =?gb2312?B?ck1JU0ZlS0pmZXVzaDVwcCtWV0JwRm5kaGZwYVV3dnRTVmpvYzV1d1FGb29z?=
 =?gb2312?B?TlpHUjd5OXhIalRvOWJqNmtPZy80SlJZWS9yNy85M3Z0eEVKbG5ZT2RIUEIy?=
 =?gb2312?B?NXFCVHQzNWJaK1UvM2praG4wTFlnUHVTb1oyalppM29QdEVkdmJ6QlRpSUFZ?=
 =?gb2312?B?Znl4b0dMVGZFZGdwZ1RLM1crVHFzVEdBWng5OHFaOEhDMFB0UlB6ZHVEc0xk?=
 =?gb2312?B?c0hoZ09kcE1hRmIrc0VDdmpsUWFIdzhUUWNvTnNFOVNwTU9HMlBJeTg0MGFH?=
 =?gb2312?B?ZGNwOUVQeEJ5UzBoSGQxWFJLN3FRbDdKZUhZU1FjTS9udFhFZ09uT0c5M1Qz?=
 =?gb2312?B?ajFsNVR5cXN1cW1TR090L3Zmb2V1V3NlTjBFdWVWc2g5OW54ZmEzQTVZcitq?=
 =?gb2312?B?QktFYW93ZEZiQlVQQ0xIOEo1VHdzR3ROQlJJaXoza2t5NnhnQ2pva2srdXRa?=
 =?gb2312?B?VjF4Vno0UjlqVWN3ZGRIbmtVYVhaSE1VaFV5WmtwTnRYcE5NOHhFU215K3Yz?=
 =?gb2312?B?bHRlMW5VQzBzUE51RFFpWFVHWkRXNkROY0hYS2RpaFowYXdpUFBpZ3E5VTFY?=
 =?gb2312?B?Y1pmRTI5T3R6M3prbE9wcUNFS0owRkRGRC9wMWNvRDN0ekdLc1FWRHZkemlT?=
 =?gb2312?Q?P+g8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3502595b-d630-41d3-aef1-08dcb9bcda9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2024 04:19:55.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YaJ6zHjFTc/7wgzXVvdm0VW+spKIOthwTwqUXLnFqefEv00sRuFi1PpB2QIv3n6kniylm4cVK2dl13KZCHpjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5439

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpBdWRpbyBjb250cm9sIHJl
cXVlc3RzIHRoYXQgc2V0cyBzYW1wbGluZyBmcmVxdWVuY3kgc29tZXRpbWVzIGZhaWwgb24NCnRo
aXMgY2FyZC4gQWRkaW5nIGRlbGF5IGJldHdlZW4gY29udHJvbCBtZXNzYWdlcyBlbGltaW5hdGVz
IHRoYXQgcHJvYmxlbS4NCg0KU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZp
dm8uY29tPg0KLS0tDQp2MToNCiAgLSBNb2RpZnkgdGhlIGNvZGUgcG9zaXRpb24gYW5kIHNvcnQg
YnkgSUQNCi0tLQ0KIHNvdW5kL3VzYi9xdWlya3MuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9zb3VuZC91c2IvcXVpcmtzLmMgYi9zb3Vu
ZC91c2IvcXVpcmtzLmMNCmluZGV4IGVhMDYzYTE0Y2RkOC4uZTdiNjhjNjc4NTJlIDEwMDY0NA0K
LS0tIGEvc291bmQvdXNiL3F1aXJrcy5jDQorKysgYi9zb3VuZC91c2IvcXVpcmtzLmMNCkBAIC0y
MjIxLDYgKzIyMjEsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9hdWRpb19xdWlya19mbGFn
c190YWJsZSBxdWlya19mbGFnc190YWJsZVtdID0gew0KIAkJICAgUVVJUktfRkxBR19HRU5FUklD
X0lNUExJQ0lUX0ZCKSwNCiAJREVWSUNFX0ZMRygweDJiNTMsIDB4MDAzMSwgLyogRmllcm8gU0Mt
MDEgKGZpcm13YXJlIHYxLjEuMCkgKi8NCiAJCSAgIFFVSVJLX0ZMQUdfR0VORVJJQ19JTVBMSUNJ
VF9GQiksDQorCURFVklDRV9GTEcoMHgyZDk1LCAweDgwMjEsIC8qIFZJVk8gVVNCLUMtWEU3MTAg
SEVBRFNFVCAqLw0KKwkJICAgUVVJUktfRkxBR19DVExfTVNHX0RFTEFZXzFNKSwNCiAJREVWSUNF
X0ZMRygweDMwYmUsIDB4MDEwMSwgLyogU2NoaWl0IEhlbCAqLw0KIAkJICAgUVVJUktfRkxBR19J
R05PUkVfQ1RMX0VSUk9SKSwNCiAJREVWSUNFX0ZMRygweDQxM2MsIDB4YTUwNiwgLyogRGVsbCBB
RTUxNSBzb3VuZCBiYXIgKi8NCi0tIA0KMi4zOS4wDQoNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3
orz+yMs6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4gDQq3osvNyrG85DogMjAyNMTqONTC
MTDI1SAxNjo0NQ0KytW8/sjLOiC6+sGsx9ogPGh1bGlhbnFpbkB2aXZvLmNvbT4NCrOty806IHBl
cmV4QHBlcmV4LmN6OyB0aXdhaUBzdXNlLmNvbTsgbWJhcnJpb2xpbmFyZXNAZ21haWwuY29tOyB3
YW5nZGljaGVuZ0BreWxpbm9zLmNuOyBzZWFuQG1lc3Mub3JnOyBhbGV4YW5kZXJAdHNveS5tZTsg
eHJpc3Rvcy50aGVzQGdtYWlsLmNvbTsga251ZXNlbEBnbWFpbC5jb207IGxpbnV4LXNvdW5kQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgb3BlbnNvdXJjZS5r
ZXJuZWwgPG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29tPjsgYWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZw0K1vfM4jogUmU6IFtQQVRDSF0gQUxTQTogdXNiLWF1ZGlvOiBBZGQgZGVsYXkgcXVpcmsg
Zm9yIFZJVk8gVVNCLUMtWEU3MTAgSEVBRFNFVA0KDQpbWW91IGRvbid0IG9mdGVuIGdldCBlbWFp
bCBmcm9tIHRpd2FpQHN1c2UuZGUuIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRw
czovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KDQpPbiBGcmksIDA5
IEF1ZyAyMDI0IDEyOjM4OjUyICswMjAwLA0KuvrBrMfaIHdyb3RlOg0KPg0KPiBGcm9tOiBMaWFu
cWluIEh1IDxodWxpYW5xaW5Adml2by5jb20+DQo+DQo+IEF1ZGlvIGNvbnRyb2wgcmVxdWVzdHMg
dGhhdCBzZXRzIHNhbXBsaW5nIGZyZXF1ZW5jeSBzb21ldGltZXMgZmFpbCBvbiANCj4gdGhpcyBj
YXJkLiBBZGRpbmcgZGVsYXkgYmV0d2VlbiBjb250cm9sIG1lc3NhZ2VzIGVsaW1pbmF0ZXMgdGhh
dCBwcm9ibGVtLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaWFucWluIEh1IDxodWxpYW5xaW5Adml2
by5jb20+DQo+IC0tLQ0KPiAgc291bmQvdXNiL3F1aXJrcy5jIHwgMiArKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvc291bmQvdXNiL3F1aXJr
cy5jIGIvc291bmQvdXNiL3F1aXJrcy5jIGluZGV4IA0KPiBlYTA2M2ExNGNkZDguLjRjN2YwZjlk
MTVkZSAxMDA2NDQNCj4gLS0tIGEvc291bmQvdXNiL3F1aXJrcy5jDQo+ICsrKyBiL3NvdW5kL3Vz
Yi9xdWlya3MuYw0KPiBAQCAtMjExOSw2ICsyMTE5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB1
c2JfYXVkaW9fcXVpcmtfZmxhZ3NfdGFibGUgcXVpcmtfZmxhZ3NfdGFibGVbXSA9IHsNCj4gICAg
ICAgICAgICAgICAgICBRVUlSS19GTEFHX0dFTkVSSUNfSU1QTElDSVRfRkIpLA0KPiAgICAgICBE
RVZJQ0VfRkxHKDB4MDdmZCwgMHgwMDBiLCAvKiBNT1RVIE0gU2VyaWVzIDJuZCBoYXJkd2FyZSBy
ZXZpc2lvbiAqLw0KPiAgICAgICAgICAgICAgICAgIFFVSVJLX0ZMQUdfQ1RMX01TR19ERUxBWV8x
TSksDQo+ICsgICAgIERFVklDRV9GTEcoMHgyZDk1LCAweDgwMjEsIC8qIFZJVk8gVVNCLUMtWEU3
MTAgSEVBRFNFVCAqLw0KPiArICAgICAgICAgICAgICAgIFFVSVJLX0ZMQUdfQ1RMX01TR19ERUxB
WV8xTSksDQo+ICAgICAgIERFVklDRV9GTEcoMHgwOGJiLCAweDI3MDIsIC8qIExpbmVYIEZNIFRy
YW5zbWl0dGVyICovDQo+ICAgICAgICAgICAgICAgICAgUVVJUktfRkxBR19JR05PUkVfQ1RMX0VS
Uk9SKSwNCj4gICAgICAgREVWSUNFX0ZMRygweDA5NTEsIDB4MTZhZCwgLyogS2luZ3N0b24gSHlw
ZXJYICovDQoNClRoZSBxdWlyayB0YWJsZSBlbnRyeSBpcyBzb3J0ZWQgaW4gdGhlIElEIG51bWJl
ciBvcmRlci4NCkNvdWxkIHlvdSB0cnkgdG8gcHV0IHRoZSBuZXcgZW50cnkgYXQgdGhlIHJpZ2h0
IHBvc2l0aW9uPw0KDQoNCnRoYW5rcywNCg0KVGFrYXNoaQ0K

