Return-Path: <linux-kernel+bounces-204913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13068FF4ED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B4E1C27D76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7116A770E0;
	Thu,  6 Jun 2024 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ee77cTAA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12D50297;
	Thu,  6 Jun 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699655; cv=fail; b=uBPoqSPfHW84BbleeWXqcWD1Esg3S10LXWrFvkm2VQvlsOiwt26Y0X49/4++jzjFkxdWRIE7K3NuuTrmONHWOzDmtql/e46PwbIxy9D8GsJAfPOKBHEj1qH5mKIFuZbv6C6AYGgItUupq9dlhNNvR4+FQzGgnpzV1vjVEF7n+JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699655; c=relaxed/simple;
	bh=SoF4J4b49R7QVgft0SM3ujBwE1bg40X2lnpSns1oVPE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hQ1imII8yT+S5ONOGXQS4I1PKITTmIAVFfoaRey926Tm1SOtoZxutjRfIKWsQoP8BSi7GDB6TYoM9JtHXuiY9jikoBfhfyjq+ncEccKtVZox7hu7igIIRDQMicpN+ADMYLivyOp8UczdKzvOG4NDVYnIAoMokYwh9LK4vmgXGxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ee77cTAA; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz6hetCXcXIDuculHbY3CUvirnjLFJ42XeSsjaeSjd7w9309TIxwrR8uOKn/xbA9Lgp3c5j0/VokXU8lqFLdKvHgdDmEg9oYnB4/YwFvts2Ab65cFQN7koRdbCnNslbxxMuD1lXvWHCTS68fBW66brFkOi8tZx6x4yfcjuh/dCEjiwuQifUwy1Zq3sUXSt0joM6605QSiirtt0LzvkCcCbu3jN/p5XLdM1LrqyxvaRenubM+/qb2eVYRAl0dl8gOK91AYXXgEYuU8RO0EtK1aOY/tMFs3fmjQoySRxOjezULKgikiIBcLqeY3t+4DrOVe2yhTyOYIZQIH13AVuUeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ume8Q51eM0/Rqthlcf7OmVfHlC+49WE9UeAAdsMaNe4=;
 b=IyW6oOXDujvo4Yx5pjOWH4znu7mJbsNkQGeCNHtN/anJtTfpKZVx6IxkmUnb876VUmxxz/dmuLLNyKTL5Y0PehbudygBWE/UfxWjaDtKJMGdLp4LzB9YwDtmF+pdEOq679OrHFPXszrNs697tKDnfHriySXqN7Vt9gDeXroqxXo0RH5arbkrb4J7RCvO8GShabwRyLEq2cL1mxQ9N/I7M0b7eqv6dyclNXunhJEhcFHiJ4aAatoIG9vorfW644U642cn1Q2srNFpAu9U3CdHZBx2dKNTQWhNVVeqD2jscOudIai4K8sXtO2PA1AR7Cd7OQoSAv8/mCg961e3AA9mHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ume8Q51eM0/Rqthlcf7OmVfHlC+49WE9UeAAdsMaNe4=;
 b=ee77cTAAsd0IZaNZyICBDtrqJGFHixzAfJ7Tx9QxVSjdj/dj5bqyAUQv+eL0BmXBtVtOkzjoYNn0W+wGA8ZfS+72BMYLdGM3VhnT7vyzPdEJgpFpu3JyFkxJXd3Z4EtRQkEOLFrGjKq3VhBWCrqzLWU5+EGgkOUTouuTY3jnwys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 18:47:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 18:47:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Jun 2024 14:46:59 -0400
Subject: [PATCH 5/7] arm64: dts: imx8qm-mek: add i2c in mipi[0,1] subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-imx8qm-dts-usb-v1-5-565721b64f25@nxp.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717699632; l=1751;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SoF4J4b49R7QVgft0SM3ujBwE1bg40X2lnpSns1oVPE=;
 b=hFIEMAwt1wHcDJzAwvDnbW5ZYGrZX1OvyYyxd28CCb1+YtTd0hX/SsNFymDboIXaXJh3ue7hM
 BSVsjB+0u+RDVtZlNWCUNKpv0y5rL19M7Up5iISoqaUbkWh0N1qaGlV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c574cf1-50fe-44f0-53a4-08dc86591f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmg0VnBZc1dwVDRtM3VWNHNXWTg5VDBUL3loSkZ1U3NIckc5MERKMDgrYVZX?=
 =?utf-8?B?OFNPd0ozcTNtWVlaaUxYcmpsS0VoU211SzAwaWlJK2NkdTROQURmN1ZZcFZx?=
 =?utf-8?B?eWl5UHBvaFdxWHh1OVJ0dFNWLyt1ZDh5SE9VdVdpY1ZURWVzVjMvd0lESG11?=
 =?utf-8?B?RlFZS2R4QkNqSGNPZERacnh1YTM0d2x4bUsvQllNd2VKRE42eHJiYkJsYUpV?=
 =?utf-8?B?dmlhVU5qS05ld2pOZ0YwTDd3b0FRdE9pZG5qV1NGSThrOEMweWRHdU9PVlVk?=
 =?utf-8?B?bC94RzN3REdaak5pYlJqem44QlMzd0RTaDhLMExoVFJScXhiU3FqTHUrZG45?=
 =?utf-8?B?Z1hISmV3Y1pRdGdnTkVUcmFlaTUvYWRnUzFCakcyRXR3MnlCeDh3T2VheVRx?=
 =?utf-8?B?aGI5K1Q1STJWTXBQNEZRMkJac3doNnc1TlNJbGhKODFaNVIyYnAxcHJyam5G?=
 =?utf-8?B?ckxwOVY1NUoxcldsbTVpTWJFSDJyMVpHL1Z5ZU1ZT1hMY1JzemtjUXVoZTAx?=
 =?utf-8?B?T01JYlV1ZDl4R0Z5M1JmREdIMWtGeHUvbng5ZU14ekVoVklCcjhLMlVmNzNW?=
 =?utf-8?B?b0NCWFNmVmtsVXBhTzJreFRrL21aeElSSkN5dEovTDRTcHhHckVBc3RTS29H?=
 =?utf-8?B?VlQ2SUpLdmpPRXEydy9XcnV5cy8zbUZrdk1oSU5jd091ckp0U0ljMk9QYi96?=
 =?utf-8?B?QlV4MVNCeU5yUjBSSDFFSEdvQXJ0TTh3V3N1V2lxQ2xLRHkzTmxwZW5wY0Rs?=
 =?utf-8?B?VENqK01VSWdGMHp5bzRxTTYza2RNdk9yT2tCOW9VTTIyRHMwNkQ1YlhIS3ZY?=
 =?utf-8?B?bjhVdEcwa2pOaERiV0pKMXdZYVk2WEhQbTFiSFFNcTA4Tzl6Q2psVXZoT0h5?=
 =?utf-8?B?YXBLd29Yelh5d0U4U09iZk9QVWlCREdEb3VhRVZPM21WOGIzbE8wbkZVcEEw?=
 =?utf-8?B?ZlpIM3puODlteWk2Y3hHNXkwMGdVNllJaVh6N0thaENYNVRnOG42NUtwK25X?=
 =?utf-8?B?cHJBUWdSQnlnVTkvK2svalhiblltTm55SWZuMUtORUJ5WXlsV1l2K095amZL?=
 =?utf-8?B?T1B5eVV2SkVwN3pTSERiTXZyblRWTS9vTDE4bXlzUnJGaTcxQUNmd0FsaVUw?=
 =?utf-8?B?cng2Y1haS2hsQUEwZlFQQmxPYjVjQWcyOTdsMnBJR29KTlRxaUh6dXBKaUlL?=
 =?utf-8?B?K09FbG9FWWFjKzVVV0gxMTU2MmluUEF2M2MwcWg4aExQUGgzUndFK2xGVzhF?=
 =?utf-8?B?OFFudHhOMmR3bEFHYUpTclUxQ0RJMEY0MWVoZlpWSzhoTkQ1WllKeVRCWm52?=
 =?utf-8?B?OFVWcXV1TlFFY0M2ZVN5TUQvR3NGRXlnUEhBU3J1T0dCTXNLckRuU2d2cXJH?=
 =?utf-8?B?MlY4c043UlJGZjhoWXFzWWlJcE8yRGU4VzAxYlN3eXdGeTdRQlJHZ2tDS2lv?=
 =?utf-8?B?MXNSanUzbEI2RE8xblR1TEMxV3VLQVRNMWNzWWVJL0Z6V2JrTHJFMDhGR0ZQ?=
 =?utf-8?B?dUFyaG9zUmpCRnBmWWdkc0VqajIwdVl5cVVsdEw4ZFpTNXVUYkwwVWE0dytx?=
 =?utf-8?B?Q0tlaUh0SENGUjdjRVVZdTJPVWVvTlhER2RJK2JQZUFVOWxyZDJmQWc5ZWVH?=
 =?utf-8?B?MFAweGZMdXFqU1FPTmwzdnMrdW52T0c2c283TlNOVkpqbEVYbXQrUzN6Qm03?=
 =?utf-8?B?NlpXdU1pYWZZMTNBOWlnWVNRNC9sVy9sb1NuQ3ArMC9RZk9aZjhPK2pIS3Jt?=
 =?utf-8?B?TWhERzVacituNnlLdVFEdXZvWjVBbW1KMWlCd0xPcm8vaE9tWEFVOGpXUldM?=
 =?utf-8?Q?Bt1hH4DZFqtLaWkDOjs9oO7ZT6xP+iHC/sgmw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2g3akJqOTZvZEdYUFRyamh1c0MyNVFiUGRMMFY3eEo4S3dYQmsrb2ZjaEdR?=
 =?utf-8?B?MGNqdzhDcklXM0pmMjBESzUwYVZ3bXQwcCtFTE9ZT1BwRDYwc0d1UW5obXhO?=
 =?utf-8?B?VXVtcEFmSDFtY0p6ZVlmdjBub2tLOXpvdDNCOS8ySXFaTHhZUjdqTlZnaGNo?=
 =?utf-8?B?U3lhOU1DQnh5djY2SWJUMklyOTMxMGt1ZGxzY3ZWSE1iUkt5clk0T2JSbitt?=
 =?utf-8?B?TDBlbzZMcGZiN0oxSTQ0WkI3WXhQaXRZR215RmR6WjNwdU1uUGJ0Z2lCY09m?=
 =?utf-8?B?UTFDT3Y0NmE5Z29ReDBreDhYOUpRMTd3OXgvbVVFSmNQRnpSL2FZcnYrbUdQ?=
 =?utf-8?B?MzFRWHNyZXV5clJQT2JWTW02TmxUakZhL3dLcGorem1sNTJpMEo2M3ByRXU4?=
 =?utf-8?B?VUJIc1FoRGlSY0F4Yi9BYWZLTnpUTGNuL2RwNnFhcmVtT2ovRWIvZXpkaEdk?=
 =?utf-8?B?OGNMTVJPbDN6T0ZZdHZaOTRzUDFiQUNhZlN1Rk1EeDJFYTljR2Y2RUw1VUJN?=
 =?utf-8?B?NGMyeG9TZVcwZURuS0ZYWm1HWHIzVHZqL0V2LzJQMSt5RXA1b3p1OFJLMG8v?=
 =?utf-8?B?T28wY3N4RjQ1K1p3L1VXUVQ3ZGwxZkJuaGZuNkRmSytwR05lY0d6d0psdHNC?=
 =?utf-8?B?R2xrU0pEZTMwT0VESjhjUEtxN0ZZMEUzeWIxZk96WEJad0ViUXNsYi9OdlM1?=
 =?utf-8?B?SVVwcFA0UUJkYUdnNnowNFUyYWNBajV1MXdKTHVQUTdyTUkvK1hBbTRwQ1Rn?=
 =?utf-8?B?SUFySHQzMHMwL3dSTW9YTkluc1ZYZEFYMUQ5NDFGM0RtdlBnUk80aWVXYTQ2?=
 =?utf-8?B?TTM5RzZlKzhLT2NWdmh0bkxvN2M5WmtNbnBmNVBRQTdkcUNiaHU2R28xMk5v?=
 =?utf-8?B?WU83SFFOTEpsQUlaK1dtTlZvRUlzazhWUTFTekcrVldsSVhDNmp2QXgrcHNm?=
 =?utf-8?B?L251M09kWDdQUHBZeUdMSEVYZHpCMmE4VGVuZGgzNStwc081T2VwN3BxRU5W?=
 =?utf-8?B?Z09qT2NzQXlHOEc4TDB6T1c1bzVaMHJncEJHOHNZU0pBQ1ZNRlQzVFpjNWVr?=
 =?utf-8?B?NG0rZURJOHBJdkR6UU9WRllxam9URzIvQWlZSkw4S25talZ4aDJRcnFqbjIr?=
 =?utf-8?B?VnVHS0MzdGJ0WHJqZm0wUXcxYmpDV1J2VG1HejNlSmk0bjRNL1J2ckRhMjBL?=
 =?utf-8?B?eGJLRlBsM1BydTFuOWJVVkFSaGdwMWtvMnB1WnpZK1Nkb1hVamdOd21jN3Rj?=
 =?utf-8?B?MkFMS0l5LzZoSkVzRHNVd3U2UjExQTA2L2tXWVhWUjJpRXlMOGpWaEdvRWQ5?=
 =?utf-8?B?L0tTWDN3cmhwcnplUmRDRitMbDNVaEEwWjVuc2R0N21GVnk1bGxuSzVyWkxS?=
 =?utf-8?B?bkR1cDhPZkpKbDhzYjZiZ0J2SnlIMUkrZlpYZlkwRmMrOHppTzlFVWNKVnJQ?=
 =?utf-8?B?TnFQb1VRUkx4dGFXSkFIMXBaaTNjeFZyRE5OdGFnbG1GYjJWSDhrU3Z0bjBK?=
 =?utf-8?B?Sm9BMm45SEhsMEIvbzd0TTAzYWZwVk1wMG93V1lMNm85WjVOOVNQTUpSUnVD?=
 =?utf-8?B?Smp3UzFrWEhaRGkzVkFXLzJxMEw5OEJXN3gxcVNYYXltcjEzOEFPcitzeC9L?=
 =?utf-8?B?LzRva3V0b1dSWSsyQ09BeTJZcnJYL1NXTFdCVUpkbmM5M1BJekJNNEdwTk1P?=
 =?utf-8?B?cVVlTFRZSDEvVTh4aE1VUXhWZzliU0tMY0N3eCs2YWRxeEExWTNFRjNPeEhF?=
 =?utf-8?B?NmVZdDR3dGR5VDJ6OURvN1k1Zms5YnN0SDFZMGprZ3A5b2pHM0QvTGVmdXFt?=
 =?utf-8?B?NGV5ZWpEdjR0QWViekZmZzI1SXdsZEFQc0NVVmFUUWpmVzBObk1Nd0tEQ2o1?=
 =?utf-8?B?WklnQmVTdDcxUWhkVmloUDU2VllSSTdQNGpCTTRTeDNkbEdFRExaa21vdito?=
 =?utf-8?B?QUhQWk56cWoyYUxZaEFwZUs4OXVYdy85ZVpwK3lRTlJHQzFQU2Z1emJ0eDdE?=
 =?utf-8?B?SkRqOFFTS3IvVzBnZUxzUlVQU1VqSmQrSVdET3dmRmtWK3dDS0h3WXk4RnZT?=
 =?utf-8?B?aFk3aG9RSHg0bmxrb21UQS9hYmlVdDAyQlF3ZFIzRlJra1lDeTZqWU5SZ0ZF?=
 =?utf-8?Q?/sx9zKiJooPrei+ONhaW2BBOC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c574cf1-50fe-44f0-53a4-08dc86591f7b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:47:31.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aByNmMUcwY0Kg102I+NXnkQ7nYJLtTCbMhu0FCYistHgNN/kKtok7Sa4MKJpKIPCOf9Hg4Rio9CvpA6gwW5JhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

Add i2c node in mipi[0,1] subystem for imx8qm-mek.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 80cb834d56bc2..cdcd5993cc69f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -388,6 +388,24 @@ &i2c1_lvds1 {
 	status = "okay";
 };
 
+&i2c0_mipi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mipi0_lpi2c0>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c0_mipi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mipi1_lpi2c0>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
@@ -660,6 +678,22 @@ IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
 		>;
 	};
 
+	pinctrl_mipi0_lpi2c0: mipi0_lpi2c0grp {
+		fsl,pins = <
+			IMX8QM_MIPI_DSI0_I2C0_SCL_MIPI_DSI0_I2C0_SCL      0xc6000020
+			IMX8QM_MIPI_DSI0_I2C0_SDA_MIPI_DSI0_I2C0_SDA      0xc6000020
+			IMX8QM_MIPI_DSI0_GPIO0_01_LSIO_GPIO1_IO19         0x00000020
+		>;
+	};
+
+	pinctrl_mipi1_lpi2c0: mipi1_lpi2c0grp {
+		fsl,pins = <
+			IMX8QM_MIPI_DSI1_I2C0_SCL_MIPI_DSI1_I2C0_SCL      0xc6000020
+			IMX8QM_MIPI_DSI1_I2C0_SDA_MIPI_DSI1_I2C0_SDA      0xc6000020
+			IMX8QM_MIPI_DSI1_GPIO0_01_LSIO_GPIO1_IO23         0x00000020
+		>;
+	};
+
 	pinctrl_flexspi0: flexspi0grp {
 		fsl,pins = <
 			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021

-- 
2.34.1


