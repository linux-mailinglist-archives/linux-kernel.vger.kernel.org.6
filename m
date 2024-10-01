Return-Path: <linux-kernel+bounces-346273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD1198C222
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABAF1F257D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C11CB518;
	Tue,  1 Oct 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OFLycSlm"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013043.outbound.protection.outlook.com [52.101.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306991CB331
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798625; cv=fail; b=QoWKTuI/TYHiKC9/vwIbiodUUgTVeh/W1ZZ3D2Ts3tYgygMW/bAchNFk4ldY0bE4asYuOJGcUeVNt8jWRSrWZ7Aretzgbq5PN88DpuhzR3RTarp0ve2+6f+9yE6Du8J93TFgm+eMDyjOMd+sHgnz9NBjrpUrj+ea9uuZINHUZt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798625; c=relaxed/simple;
	bh=mlCSC0VaHU0gag3oDLASEUXde0oQXAqLaFA8VZFk1O8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pYIkqn+ymnBBoCadW2Os/NQaYJqBKbPgIaL3oZq6/w6dAXq1OGFeYvJmyaBb+bXCKzepu5pekm+DOBFHTSUZOroLbQfnTPw9/vrRsfV9Q4FY/WGZJrgf2Bp3upkeCWcovkOlpkotBpp82k7jdvW+YEfoLr139MBRil7U3sfV8Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OFLycSlm; arc=fail smtp.client-ip=52.101.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTmQYAesZj9bO1XhpXUdPQ3wHq11Ye6r+ICC+8K0URiVn2YIcGL19C3+ugkKn1FbN3tl+thvEbXhyqVfcMgXvfNL6Gd2NDq1awutHFIP+Qpv1nPpfUluFkMxKwWRNF0Ngmbl0X8SxwUBPYKwrFzwruKoFo6rOnpUgwRxLhPw5p8ssAjeF5pzF8tNGoq7Bx1YOlVxMJC/O8uSsbyQhYawSlWDL89IQtseqpPxU9r/lOEGP2aODYHGhZChuUNEbahkVQgaqmdZ6VwejqxO+B4f4oEzA460pFXsyqKCfnw+0SFkkaia7VZULx++DFKBXYG6++h6bZcL3t4Bk8ohKyud7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNlnoBuNCW/sQt1dCN12m568rUIM6SNKoMlIERg3C+Q=;
 b=KPi3OPTyXMs7/UTWTDPypL5jkGHLWv1gtKzn8YG7mcEitkgIoHEWZI2WxCksk0MJh7Vrf63fKeICWNFtST2eXudcA4uclJ+wFDKW+jzsuYum+nK5cfpq9A5FlVs2fq8yKpAmOV+7EM/N67Ams4AhEFcSIdNhI3KWNOg6/Cu2KnsUVkn2CM7HunpG/ay6y4Zk/KjN4dAeTCj6bXQ8Tpq0X5cs+vGgtwO3oV/fWxrpVyzfWFA9QQHeOoKvFsWSknve+mxI5XGIlejDnLeyh/h/pz0D8JYPIU1bE34VzqO6I57dJqR3EWoMggP/cNK8dG3dGJPV3NgFeK8DN1omF9oGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNlnoBuNCW/sQt1dCN12m568rUIM6SNKoMlIERg3C+Q=;
 b=OFLycSlmIuW+ej/B0GKGONK5tyF4FY3sc5LTJRb8I9gO/fX3iSktubHVRqtWk7h7aXYgkSfI36k51psp3m+vmScPGoJ6Qi5NY2bmNkeyozDfQRnPdJ4a/HsoJFEsLC5A+zWKLwVSKEembyxc/HIQ0uesGXx3jsq26wopZXdbyp08W3F/D+5VnOPYgMOfNXaYKqhdFafKTKIJA9Hy+KvGG+egLfhKvwsw4plDE7Mf94iwWydNfr0CZHIWfc2qdQ2fl7QRo/fyX71m1AW6RvoYfbRvAaD9gLJ2tQPUX90/aoeRfANeVYS+FvO5MgrDVbJFbW2s3YtcjbrAuR0LCJkWGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7879.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 16:03:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 16:03:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 01 Oct 2024 12:02:50 -0400
Subject: [PATCH v5 1/6] i3c: master: svc: use repeat start when IBI WIN
 happens
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-svc-i3c-hj-v5-1-480ab8aed849@nxp.com>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
In-Reply-To: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727798616; l=3646;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mlCSC0VaHU0gag3oDLASEUXde0oQXAqLaFA8VZFk1O8=;
 b=o4Imjvf6RbsxwWO49VEa9Ge5hfkUkRRdLcqLeuRT6N21mSzVn4OpUy+pJG6L0rBXQUvszRKK8
 T4cBxqle4xaAd1SfeyqCD4daB5MrbOxGrYSnle6mFobtNDTbX2x7Gz3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf691f3-0a2b-49ef-5a73-08dce2329d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0g3ZUtqVi9ZeUg2SGlNaFgwUk9OYkZQdk1VbHovSG9EWGMybituZVZzVXc5?=
 =?utf-8?B?ZXF5TkQyRk5BckNlWEU2dGFzU1BzNjc0VTZUQnBDNTIrRG56ckF6ZDU1MmJK?=
 =?utf-8?B?ejB4S0VveTFhbjdJS1dEZWV2T05sNk5RSXp5V0tqQWN2WFprUm90eHE5TlJD?=
 =?utf-8?B?TThZdkIybTdpSU9veUsxbTlmVExDU2pMTWdGM1UvUCsvcnh3aXZmWllaa0Rn?=
 =?utf-8?B?UzVuQ01pbU9Idzl3Z25NUDBwZmFsOWdMRTkwcEZpRHBZSUFQY2UwMXZRc080?=
 =?utf-8?B?MmlERWdGMzlhd1N6cE1NV010L3F5ejB1TlFRQkNBV3dOT05sTTRhT0NxQnNO?=
 =?utf-8?B?cklNYmc3anoxdjh3NHRCcVZiOG0vMHoybGJPQ1pZdS9lU0RZWHJUaExOVkEz?=
 =?utf-8?B?Yk1mRVFlWVB2SnVTazIydlNLMURaQXRXaWFXUEZ3b3A4R2h4ZGkvL2JjL0Vn?=
 =?utf-8?B?ZGNmSmRsZnptT1N2RUxSbkUrVTZ0cGJPVmYxd3V3eTIvc2EyQ09ybFcyTmY1?=
 =?utf-8?B?OXB5NGoyZUdPdE92cjIzeEY0V0pUaHBHY0Q3ZXVsT2VSakVaRUkxVmNlVys1?=
 =?utf-8?B?M0VIdlpPcWlmZ0pvWWo3dE9CTlhaN05jM2ROaHc2UmRCSllLc2NyanY3Sk5Y?=
 =?utf-8?B?dk5WQjh1bXRZYklyYnhhYlBCbmZFMmxLZjJnNzlIVm1hRlJtbU85cTZEQXNI?=
 =?utf-8?B?bTRsaHVKNmVnSy9QT0d4a1lIUmwyUjFCZkpqZzkvdUNyc2pBWlpNYkJnZ2dM?=
 =?utf-8?B?OVVTRWc3bkFBWU9oS3lJOG9lc1B6T3dJUGJJOVRFWGgxR2RGQ2RjZFZaMmpt?=
 =?utf-8?B?dUVhQkxadnJCNnhVR09qdGFHZ0lKOS9UZ21kcXIzMktvc2JBTHZCQnVyckxK?=
 =?utf-8?B?eGhWMlNTQ0EvYjlLSFhXT29ZT081UTRqTFQ0Zm5xcENQUmZoSTdWcFRsaDFH?=
 =?utf-8?B?Q0xjUFdqSlZ0Y2ozZkhhTFY1STVmTmxHRlZPRy9zdERTTXBzdVk0OGtDRW5D?=
 =?utf-8?B?OGVTT1lLdFlpTm01STNOVWxoMjBjWFBXRXV2WkFtclJlRHdMTWpsTkdCMDRW?=
 =?utf-8?B?Z0tPa2hYZ1RmNUtPVlNJcDdwdWR5eVQ0RTgza3hPbVRFN1R2UUJabjVVenVX?=
 =?utf-8?B?R3lNajdpakl2RmphbUljbDhhc05meVNMelZFUGZ2YU5HSU1QU1EvWWhiNUd1?=
 =?utf-8?B?RzZoNElmREY2RE84dW1wOFBmOFVHZnp4UEJSVk8rcDZVWGprOEFDQVNJTmsr?=
 =?utf-8?B?ckxROHhZazdLNnZ3czMrUW5XNFJlSjlyS0tRdWttUTdkTkc0L2tlOU1xZVV2?=
 =?utf-8?B?dmxjR084T0gwSmdLU0lZTGh2SWxHcVZScDJiMVZJQk5JOHR5YWhvV1VtK3BE?=
 =?utf-8?B?UkdSVmd1RVdsSGNaQ0JiZnhwYzhvSFZNZmY4L2tyK3RHc2toOFgxSXBzdDI5?=
 =?utf-8?B?MUhETCtNQ2poSFhMQ0JHS3VKUFppMG90cG1PQzN3b0R3bkVGdmZ5WURoczkr?=
 =?utf-8?B?QnkxTUUvU29ubFJCZUFoOFVteTdyT2hrTXU4bGY3RnhqcFZreHFHRXVZMGgr?=
 =?utf-8?B?MTRJbzQyWXU3UVdhT1YxSUhRNzZtOXRXa3R1ZWFCYkVBTlRZNEdWdUQ1Y05m?=
 =?utf-8?B?dlpnd2hQN0VNaDhrMGllV2NxakxLSk9VNkFwUm1hT205VDRWOFF5bnBSOHVm?=
 =?utf-8?B?dzhuRzFlVXVBcjRTUXd3LzdMRUJaSFZIS1hwZk9TUmlIRjdrQ3Y5Y1B6MVgy?=
 =?utf-8?B?WFF3MjhzR3ljWTRseVdnR0xkamQ0aXdKbkJZS1I5N0pnV2xWSk5aZ3Vsc0Rs?=
 =?utf-8?B?dHBMdVlCc1hrSnFuS3hxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czU3U1VZeE5CUXM5QmFlbGdGM045bmVJZFRQT2Z0d2p4QVEvd3FmVmgwN0Vi?=
 =?utf-8?B?YWJIWHN3anZEaWxyL3U5TUpZQkRaeCtFemN0NUQ4UE9TemQvaGtZU0xyT3o1?=
 =?utf-8?B?ZW1jZGxMSTduODk0ZXB4TnJka0Y4eDFuZXpXWTVpeWJ6Z3RFcURndEdaL1Ba?=
 =?utf-8?B?bnhOL3d4VDhhY1I4Rzl5M1BLalpDK1p3VVh1VVdsZkZYazBIcWNkbGR5ZU9O?=
 =?utf-8?B?WGhwNU5GYXNkcUZKQSs4enpjZzZ3cnhPR0pJNTRxYmR3cEVDRTB0N3VGeURh?=
 =?utf-8?B?bFdTcjkzTXZRU3gvOEtjRUYwTlpZRk13eVNTSDZTYXMzQi85TEJUZzBwYUd5?=
 =?utf-8?B?RnkzMEptd2dDbGoyMWF6M0RzT24vbGR4bHZxZXp6TXQxNlhlRjVJWlRwcG1G?=
 =?utf-8?B?bWtjdTNyTnJZYmFCSWFGT1FMckh6YTF1S1ZpSmt2WmJrSVVINy80bGE3MG9i?=
 =?utf-8?B?cWJkc2JBV0FHelhGeDB0SGczVG14R1hveWRIZ0lsRDhTVmxuWXk0ekJmSGl2?=
 =?utf-8?B?ck1UM25RUC9KTWdOQXl1ckFNSldQL0NUSERXUThvREJOZWxhRlYxR2JuRjVG?=
 =?utf-8?B?dzZMeWRTZkE4UXdpWEJWcnMyZllBQ0FCMERoSlZiMFVQa29IVkd5M2RzVjFX?=
 =?utf-8?B?bXZhVzRhbnpNRDZOclJWL2NxRHZZcjZ4YnMyUXc4djZyb0kwTjZ5N08xMGRr?=
 =?utf-8?B?dExhZE5WSTB2ajdNQzZtQXBUSUJ2ZXNHdGZXVkRIRVk5dVVvMDNmMVArUjZZ?=
 =?utf-8?B?anZ6TE9TanNESERKY29tQmRBNVRsRzA0cTZDdmtiY2lURjkwZ1hiTWlGT01a?=
 =?utf-8?B?aEJ4dzJzSktrY21UOHh1Zjd5YXlpb3ZIalR1NHQ1TWI2cWgwTUtSQ0xWRmFo?=
 =?utf-8?B?TGZEYThud1M3NGtrY3JITkw0SHFkNTVTRDRXOGdpK3NRSnZkZ2RvUEViL3Yw?=
 =?utf-8?B?S3FRaFZrTFpqeHhRL0oxOGZ5bnRmYU9DVlhpODI3K3djK3dNNmlMamk3OEVU?=
 =?utf-8?B?Rm9xNUZyeU5ZN0x0WC9HUlRiYjdXTVZBRzJnTGo1eFhCSTF3bEYzaFN4YXUx?=
 =?utf-8?B?M25oV1hjYmhYQ05RTHFTcndUK2dXUmhCOW00T29GMWl3WFJkSUtsdnI0WFg3?=
 =?utf-8?B?ZlVTUit6TnNKand5aDNCVzZsdHMzK2d5Q3R1cDlXN3hmOFc3Z2FtUUp2T0xM?=
 =?utf-8?B?UVlHM2xBMDdNSnVYNCt6OGV0ZXA0U1pIdnFkd0Qvd09VQmc3ZWY3RUs0T0JY?=
 =?utf-8?B?eVJ6S0ZSYWFaeVZvSFg1c2RwSlk1eDdjUlpENEZSWmVTT0J2ZzNHZlZBYUxx?=
 =?utf-8?B?YkhoNUx3dDAzL1pRV01Ra2RkVVdmOXBIdkozdnpOYTVSYTVFY2RYLzZQMGh4?=
 =?utf-8?B?cHUzbU1PWVdrOHg0eDJCWHpKY3J0c0JtUUtXQ0pFSTJNeUloVURvR050cXJV?=
 =?utf-8?B?UjVYYnBjSXRxSFBpNlJKQjlDR2dGOElaRWhLZzArcTFXU3ZpTUlVN0tydS96?=
 =?utf-8?B?TUlZYWVaZmdiR01xcEV6YnVzUk9JOXM2MldhYThsK0JrNGROOW1WTmZRa2Z1?=
 =?utf-8?B?dzM3aXZ2eVZYdkVIWVNWRmtENVMvZGhUelRHM2tuVFVJdkhFQ3pTemtuWnpG?=
 =?utf-8?B?Wkdmb0NpZGMwN0kzc1gwRjk0SzNhWVFic1FybExNMkVSSHR3bGt0ejRLWWxN?=
 =?utf-8?B?RVVQUUtNSHcrQXhZZzl4VmI5enRTWnF3Q25LL0dSV2xkdlJJV3I4VlhkUmhP?=
 =?utf-8?B?eWRZMHhtQS9DVDRuSkxPVmFqbXpCcXYzRHJGSGR2c1psUmhlUkgwaXRZM3pW?=
 =?utf-8?B?TFM5UXU3Zmh5NklQUVBIb3lkTG5Uak9kSzV6Z3dqZWUwOHErWXVrR3MwS1Bv?=
 =?utf-8?B?KzRhWVowaHh6bSt5V0N4OWdVYkxnVjBEYzZIVCtNVFJIWTRaaEN6NG1YSjgv?=
 =?utf-8?B?RWxmS0ZGeXZpVVZpMFVaR2FHSCsrTTRYQkNyOFVCaDVsMEl6MmdXb1g4VjJW?=
 =?utf-8?B?Z2FnbTFONHJYa2E4SmFBS3JaQ0lhOUd3Wkh6cVozNkYrckVXbHphNnpqSFBQ?=
 =?utf-8?B?UXd4TSs3aFdxSTBUSGZNeTV4d0pTYm5uRzZzNVpqSFQ2UkZIazZDZzdnUkU0?=
 =?utf-8?Q?qZFo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf691f3-0a2b-49ef-5a73-08dce2329d5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:03:39.6720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b50/mPtJFIPD5o0qHxWgtFfenYli6R5eN7jrpVqzLmKzf9Y0ifbA/kBwpeRt0mg8oduKcE4CEcybMZsgvlY1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7879

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
index a7bfc678153e6..7cd3ce2643f1a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1163,6 +1163,24 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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
@@ -1196,24 +1214,6 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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


