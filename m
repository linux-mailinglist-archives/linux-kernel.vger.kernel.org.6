Return-Path: <linux-kernel+bounces-307698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0870496519D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4131C22C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571D1BB6B8;
	Thu, 29 Aug 2024 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dh6WkxuI"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC211BAEF1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966111; cv=fail; b=lDVjTOHdMORK2sQEOdCFsGJpFc4rns/kGEmBGRGm68Dou4/Ddtbo/cvLMFwBUgQPH5vRJQrKsdCTThf1ASUPFT1EDrH1JOhQJNcnu5bwA8Hx4HqhL3voeqYuzmRMhtY+paHcxm6Ef3kNZSVsthqrI2LI4xoGucucJqNam+pmOFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966111; c=relaxed/simple;
	bh=qoRJEaDC8+N7UD0gElr8zzFjuK4hIVhisZJn1vsj63I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sDtmSQSUL0pk7Twl+++CbGvgrqzeF2XeAT3YaZKYaJQOnyGgOsEIlbvoLyKsqd4qT+CxB4b3CxmNWaiK5DLcX+aDucO827ngWsMEI/uh9Eu3WS+D6DFuehXEfsvFC+W8larl0JXGrFM311+eFYhpScoABbuxxfxmIzE/F1CZIi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dh6WkxuI; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZAtHgw8nc9DdHp31vwQUEw6+Hc541LHQBjBgyoNpWCmNB0y06gsfTorv6lTrhZKy24224nQ0Vo1zd4FElXmhodT7Rh/u04yJBfbEvZqoAQbpl8VxLj+mnpQwGq5FXGr/ybi+KOPgnzTLMv49Br2BWLZ8gjO54S2Qyx035fy7ZCZQ6WkwrneeLK0W8F8Ca6Zsr4eiQOMD8qO4HKRllt81iytkT/rEoO6l/suzrMzwOQsn5PqtRUnJUiLxsIOdBZCeT7vhNlcaG2RN8RYgTft2yKJyMAmXG6fc1gfP4Ttc45PwsLrmoXzuOBHIrCFxepo8XCQsCbTMS+vdlpen69pFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uyx+TpP5xfbE3/AGBE1UbCF/0NSSEri7MUmkmrHirSs=;
 b=Y9+/G4oVx2XzW2Do6ZPVD6eFDpk76I/UkH/eByXv6l+awDsZiKHPrOMr7Q/bWF/5y29gBmZQOszjlk7wuHLJ+3XuKPyN0rYsRDI4kTViI4vMxTNFNBQ6U3EXMvXD4a/fSiBMgnhbUOXkpxPUhXJqBHJOvW566iB30X1YZt40O8WXD3G7XVHyXMp6KFxvDiLKVFl20TsCXQLmwsO89XILiEyIWILV5oFjCh4DSEQaI7bJe2tjetKQlzJiuPkFG+aq7L1yWhYj3yaRFgJ7AVInBjhcKvRVHf/HW5dA5L9Cb8aJd6yl7fhqk44dTZ9pctc8NwnjR20VQFAX8etbJdK1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uyx+TpP5xfbE3/AGBE1UbCF/0NSSEri7MUmkmrHirSs=;
 b=Dh6WkxuIABVTFihQ9u1vQPLkBo4FBv9pSKYhZM+w/HdsvCvCboLve7ywEJWTugKK0Micd2N5CjgaJOB+mgB3/2DKg6sAExLdPM5DjOnWgFH3iwng8gsZDgdKwbC63Ru11LkP2TOm2FehAaNkv1ttWnbEGK3LHd6WzZ/mSK/gBnstHwf6kL+29HUD4yrhCS/NGcNSFyQo0D72t4tu529fB9v8lo5bS5p8JwrN31zy51GJ4pv7hIWq4HvYNi85aXZuvBw2f6ayo47g2VzniBZ7QmtL85yGDucllB1S45nUOj0B5iIqtaydWG5dIX6to4UtwsjQazLxXNDBNw5Ox8siLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7560.eurprd04.prod.outlook.com (2603:10a6:20b:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 21:15:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:15:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:14:03 -0400
Subject: [PATCH v4 06/11] i3c: master: svc: use repeat start when IBI WIN
 happens
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-i3c_fix-v4-6-ebcbd5efceba@nxp.com>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
In-Reply-To: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966083; l=3646;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qoRJEaDC8+N7UD0gElr8zzFjuK4hIVhisZJn1vsj63I=;
 b=c/nYztxEZCygiNF55pTkPl7g1jp+0wK+QHV+VrvuzVHhrUuK16zWNzRXqRyGvpyZCNIj4qQNC
 ldDjtCA3SfZA3rKxSl28TJYXV/0vvWCVtIg1hjIB2UJWGHS9doLFpaz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: df60bbe9-194a-4290-82f9-08dcc86fa77c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VC9ZRVVpWFBOc28rcnduelpIMVJ4Rkl3NDk1VW5oT29CTHNzVUx3YU5VR2Jt?=
 =?utf-8?B?TTdVdTFVWXBhM21rVXR6RTF6TVNNckVraVU0QVhoYUtaczNUWHFOa2JKak50?=
 =?utf-8?B?MlNJSG9ERjdOeWM5Uzcrb1dWaU5obnNwVmplcUx0bmdpbjBBclA1SXNHTC9V?=
 =?utf-8?B?NU92RFlGazFFaWhaRjRLSVpPYUVUbHlDenJBc1RCMXpNTlArVndPTEQ2Y1My?=
 =?utf-8?B?QnF6Wm9BVXZLSnF4VUJZN1B1QmliNGNnWC9jaTdBcXFyRFdsc01iazlvOGdI?=
 =?utf-8?B?MDkwNXNoczlDVGtYMVZPeG9zZlozTE9kTG9KYmd5cGt6ekVyY294OEhFUFVo?=
 =?utf-8?B?bHRBR25pUGlJT1hqdVZlWmc0NEEwSHVtZEN5ZldtSEpMaE15Skh5aUl0am9Y?=
 =?utf-8?B?WGdDRURsdjJtR2QxZVJvN2x2UE1hWWpQQW9Rb2ZNSzRPOXYzZlU3RThCZVM3?=
 =?utf-8?B?aStTTHFMWXBLdDFaanV0T1h6cWRIR2RUQTA2OXUwUlJFbVZRcC9pQnZZVmNI?=
 =?utf-8?B?eU5QeE40UE5nS2psU0d3RnFhdmxEQndQL2l0NVhYSTBNTTRWRW1RNWYwMEVB?=
 =?utf-8?B?bWhVYjMzSlhsbC9SNXBLQTROK3c0K2tWZjM1OVFmRHg5WGYreE0wUWs1NTZk?=
 =?utf-8?B?bXQxR3FTTkZZcmh0OTlDK0c0ZkRUMHRoUVVDV29mZ3F1RDZvdGZQcVF5N0N1?=
 =?utf-8?B?d0VzSEJqc3hXdlRrUFB1Um9paVIyOEw3MDdya0h5Z0lscXNIWWpuUEs2c3U3?=
 =?utf-8?B?QTVhclV5MVBKa0wzNUxhN3lwUzI2VnhGb0hxK24vTFZFSTlBYWw3SU00UDZG?=
 =?utf-8?B?ampCaDdsVGNGc0RCTW5IMUhTN2lYOHBwaFBMc1YyeU1LYVpLWXlTL0tjM0tm?=
 =?utf-8?B?MTBWL0ZGckhxeW03cUZ1ODN3dzQrd1hyaVZqWXI5N3pwQnVCTDNHeDdMR2Ex?=
 =?utf-8?B?MytUbzlsWmY5NElyeXRUWWNQbGZvd3hkbUtBcnF3eWI4bmJLUmxRLzVZV0lw?=
 =?utf-8?B?NU1wUGlMbHJmelRGY0FrYWF0ZFNhd0NJSzVvaFRjeWRHZWw3UU5xcE5YaXov?=
 =?utf-8?B?dG1uRGhVZzRpUXVOR2R4WEdFa2hyOFZERGdHcTNQSWF3SWtRakVrMHpTUi9C?=
 =?utf-8?B?WFBpSTNoU2ZXZUdWYTFUKzFoN3hOR2cxZ1lpanBLb2tMMDFjdzdJK0M4RWN2?=
 =?utf-8?B?RzR5N1NFd3NlejBGNE52Mnd6SXZ0dDVJMSt5d1c3bGJYM3laWHBnUjZra2tX?=
 =?utf-8?B?WTN6MXBDL0l2VDFhTElqUC9heG1aZFZQMlpvM01zMnI3bXNDOGhvM3hPTUM5?=
 =?utf-8?B?ODlLdFJyWEx3NTBOdHNMbzNReENscnNqMlpISytpbkNRMTN1UHliTnRmeEdh?=
 =?utf-8?B?Y21lNzUvaW9wbnJmLzFUU2Z5cEk1WDZIZWMxbjJHdzF3dy82M3djdHozemcy?=
 =?utf-8?B?OG4vSzM4b1lERFI5Yzh1Nng4WjNQR0hoYXVWV3A0bWV4QnlRdGI0ZDV0NHNk?=
 =?utf-8?B?a1B1dzUyMWd3dkNGd2hETEVjK3ZXQ0IxRVlRSkR5TlozRHk0a0hBdWFuR1ZB?=
 =?utf-8?B?emNQQklKQUZOZk5CdEs2N295bjRTQ0EyRHdEMkF3Wk96QVR2OVNUeTZrMndr?=
 =?utf-8?B?VzREZ1UxTWJiczlrYW5pQWU0b1VIcmwwcTJpdjBIWDBRUFowS05Pb2x3VkJB?=
 =?utf-8?B?WVR2SjhHeWRmU2Y1a0tFN2NWTnRVL0JCdXlGT2NGcEJ1S0NRVm5tZXJMNnBV?=
 =?utf-8?B?WEIrREYrZGhDWmNPN3dQbHhOSGJTVGkwZ3EvbXNsSXhPbklndEY2RVVQYnVh?=
 =?utf-8?B?UHZHOVcvUFFQWk5aWjh0Ny9LS2RGNzBBSGJCWHF0aXRHb1dGZldaSncrSWpt?=
 =?utf-8?B?QjVZaVova3NpOW8rNHlDNjh6ZFRjdnI2U1BIMC9wai9Ja2c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NUZnRlRrRWJwQXdCOFlUVWxnNHhlZUJGbGJYYzRPdmpzVmhBUnVuZjVSL0JQ?=
 =?utf-8?B?Z3M1TDcvUzNLZlZhL2hCMjkrNlRUM2FPSEdJbGI0Q3Y0TjVsc2JKU2k5Qkll?=
 =?utf-8?B?clBhWlRGNU13cmRPeGJpOSsvTzcwdDVKZlZOSDllTjRZZjQ0V241ZEVoWnV3?=
 =?utf-8?B?R3prVjNqOUtBVnlzanlENlF2WUQvQ1RyTTZZT2J3TW5NVWMycGhjL0YvMDBK?=
 =?utf-8?B?MGRhNGM4clpsQlJ3NW9tcW9XaFF6d2JFTzZhRGIrQ0VmdDdwSlBoVldFa20x?=
 =?utf-8?B?dHhIOVZPWWRsQWVObWF3NUh5RXBBejJZUCtkZFZUbDg4bit6eW1iZjFzeHI4?=
 =?utf-8?B?OUx1L1A2Tm1Ja1krYjlFTlhGMkQxTnlEU2hpNzJFenNhV2E2VHZaN2w5S3Bh?=
 =?utf-8?B?VWRud2dSTElKVjNnYzRXejBLcGZJS05uS1lGY0hBY1dYZVJYZjAzU2JmOTZ6?=
 =?utf-8?B?R25jUnBkaDJjVjNXaE5UMnFTdkltaXFOQ1NJcVN0aUJtSjViZnl5YVdNckth?=
 =?utf-8?B?QndWdllyc0R1c0VacUg3YnRISXZzZWd2VlowSG9yN3F4WkdYbW9JZ2lXM25L?=
 =?utf-8?B?cmZRT1ZGL0lUWnR6RTk0MFpRZzFGRFVXSmNiaUhiYTJEZjZZR3lUQ2RYSHZG?=
 =?utf-8?B?WmQzMVRxLysrOGF4MW02VVpDMGRRZXJjeUlhc3ZxclRna3daNTBvcjNDTi8y?=
 =?utf-8?B?S1NEaFJWM2cwSVVxWkQyT3BUaE56WlBFQTh2VHJkeGNhK05vTFAvOExRUGEr?=
 =?utf-8?B?OElvbTNVUDJuZmVqQnJzYU1MT2tzU3JHRk8xbmtVbEFLbVJoNWF2M1IyczhL?=
 =?utf-8?B?T1JwdHZBckpQSW5UV1ZLS2VOMEFNOFJWSjJ2UEwvaU5jOTR6V2E4djNuMkZT?=
 =?utf-8?B?ZzV5dmhCdm5kVDRtOVN3ajZJVzQ2Mm1rSXppQUZJMjRwTDh6Tm5xM3RkalA2?=
 =?utf-8?B?UjdHa2owR1RFMUxWbGNwWkdHOU44TE0xb0ZKOVdQT2JMTHNQb2FpZGR0YU90?=
 =?utf-8?B?VWJHQUJCS09nZlhRdVk1dlhEZ2NaMlNYRW1KSUluU0FRWVNrQkVsZ0lyOCtH?=
 =?utf-8?B?VmJOc29lbTZWQUxhZXBVSjgwdVZTY2lwRHdzUExQU0dBcnpzNzNkSWltM1NQ?=
 =?utf-8?B?RE1abG1TTHIzdjBPWTArSmdRdUJ6NE8rbmJ3dGJIc2RDM3hmckdZKzZRSlB5?=
 =?utf-8?B?STRnQnpDRVpkQjI0N1JHMGUxMTkyN05NU2VKME9XcmpCMkUxeUp0amdrdmxS?=
 =?utf-8?B?ckppSzlSUjhFbEtBaVB4cmdwek5UUWVYTlVJSVh2bFVCbTBLWk5DdXpxVmxW?=
 =?utf-8?B?VFF2Q3pSN1VtbTJrZWc4dmd5WTV3K2FvU2NSc291K0haRFNWU1VQWW5Ia2Nz?=
 =?utf-8?B?d1FLZHlGNUk4ZHNkdDBuNEZuYXYwNEFwWTZaRlpyTGdPNXBEOWVsL3ZIMzN3?=
 =?utf-8?B?UjhUdXJtaHYrcDg0eGVRZHNKaHAvY3AvM1FmM1ovN1A3d2x1b2l6WE5yUmJV?=
 =?utf-8?B?blhaT3RKVmtYU256MERUMGNuSU1iS2tWd0s3MG0xdFQ2cm1UTVN6dFhadi9V?=
 =?utf-8?B?V0l6T25BNy9EMXdzK1oyL3FNNHAzMVdJYm5PSkVRSG5CZDNrVHZ0cTJ1b096?=
 =?utf-8?B?OEk4TTNSaW42TEtSM3VUZWEveEp4Z0ZJY1FMeXBYVTdOeEZpR2NEMUl2aEhl?=
 =?utf-8?B?eGtDUVZmZHpzcGtWbDh5c08yV1NkMExGOGRmQWwxb21IV3QvRGs1dzF2TW9s?=
 =?utf-8?B?dEdXVVJiZTR2VkZ6UnRnQk1VMGRScFBDUmJ2RkNpR0hPb2c3ZFYwMjR4ZlhZ?=
 =?utf-8?B?WHd2bEEvS3ZmYWFVY3RYeUE0NzY3RDJqdHB0TFd1NGJmTWVSbjRsb1FESWpi?=
 =?utf-8?B?M3QzclhjcE0rL1dJd2dSSGFmWWFrb3c1OVpiZ3hZY2VGczZzdzFTMUMyeEhh?=
 =?utf-8?B?U3RQTiszQ0o0SjRGWHdtRGlhRU54NGZ5ZWtieE40aUFQMjYrTmc3SUZjWmxT?=
 =?utf-8?B?T09wUDkwd3dJTkNKWW5wWVlZOC94VE1HcmhpbmtFVXoxM01iMDVydC96TWo2?=
 =?utf-8?B?NXJvcjdkUHhOcmRkYW85Y1Nua2xBWXZQRGpYTzA2dFpsVWE4Zlc2VGVCV0RS?=
 =?utf-8?Q?GxjZspESBInWL3yDZH0QNQhKy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df60bbe9-194a-4290-82f9-08dcc86fa77c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:15:05.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X7JZFknLS++0EL/jME30IKXe6KQ+FPsN+HnggV5WK1gR1e8GuSsuwKJ9KAQAkcxr+FWNzchTpGd4U1tzsDz7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7560

There is a possibility of an IBI WIN occurring when addressing issues, even
when sending CCC commands. Most of the time, returning -EAGAIN is
acceptable, but the case below becomes highly complex.

When a Hotjoin event occurs:
- i3c_master_do_daa()
  - i3c_master_add_i3c_dev_locked()
    - A dynamic address (e.g., 0x9) is already set during DAA.
    - i3c_master_getpid_locked()
      - Another device issues HJ or IBI here. Returning -EAGAIN causes
        failure in adding the new device. However, the dynamic address(0x9)
        has already been assigned to this device. If another device issues
        HJ, it will get this address 0x9 again, causing two devices on the
        bus to use the same dynamic address 0x9.
      - Attempting to send RSTDAA when the first device fails at
        i3c_master_getpid_locked() could also fail when sending RSTDAA for
        the same reason.

According to the I3C spec, address arbitration only happens at START, never
at REPEAT start. Using repeat start when an IBI WIN occurs simplifies this
case, as i3c_master_getpid_locked() will not return an error when another
device tries to send HJ or IBI.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- add miquel's ack tag
---
 drivers/i3c/master/svc-i3c-master.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 71a9359c5c794..ad999a1346686 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1099,6 +1099,24 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		if (ret)
 			goto emit_stop;
 
+		/*
+		 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a
+		 * Frame with I3C Target Address.
+		 *
+		 * The I3C Controller normally should start a Frame, the Address may be arbitrated,
+		 * and so the Controller shall monitor to see whether an In-Band Interrupt request,
+		 * a Controller Role Request (i.e., Secondary Controller requests to become the
+		 * Active Controller), or a Hot-Join Request has been made.
+		 *
+		 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, issue
+		 * repeat start. Address arbitrate only happen at START, never happen at REPEAT
+		 * start.
+		 */
+		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+			writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+			continue;
+		}
+
 		if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
 			/*
 			 * According to I3C Spec 1.1.1, 11-Jun-2021, section: 5.1.2.2.3.
@@ -1132,24 +1150,6 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		}
 	}
 
-	/*
-	 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a Frame
-	 * with I3C Target Address.
-	 *
-	 * The I3C Controller normally should start a Frame, the Address may be arbitrated, and so
-	 * the Controller shall monitor to see whether an In-Band Interrupt request, a Controller
-	 * Role Request (i.e., Secondary Controller requests to become the Active Controller), or
-	 * a Hot-Join Request has been made.
-	 *
-	 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, return failure
-	 * and yield the above events handler.
-	 */
-	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-		ret = -EAGAIN;
-		*actual_len = 0;
-		goto emit_stop;
-	}
-
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else

-- 
2.34.1


