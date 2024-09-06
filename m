Return-Path: <linux-kernel+bounces-319213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3596F95D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1921C21287
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB11D54D6;
	Fri,  6 Sep 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Th7jbDG5"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F11D47B7;
	Fri,  6 Sep 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640263; cv=fail; b=mG9KvBpiyCgpGJ506fYT2XTy84ItQ4ELiBk/z3Mqc96vNA9uiYWfZSUYsRLAgjF2apeWSJpL0heu04uP3q60xWIPUNxRXk11l4JEA/geTivW68AbwNP2nukYs+yKifBtizYSJ7a8fR6oUksad1dw6ojGhTu7Ri84N8xWjkMNmYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640263; c=relaxed/simple;
	bh=OqCbEUzuE4T3rIePR+tm5vsCVk9EgAOhr0RnQgNI8YA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m8bkUMuqo+5GOLuUTc388GrSALiy27d274mOiztv8eabGFJYLms4e8No4MMowBJSt5WufhmirERJv/2/DNJFFy7YrHMVvke0bd/nCEv9EabbOq2e+LMlE+wAWWcicdpKVIGdd+b4n42NfKGCUIZHnIHmkmoaLmyCWwWHDWxrYlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Th7jbDG5; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1pMgC+YcZ5EW6g8U6kpo1sDLiOww5dIjm3LMVFCBjANWwfdRKrKJj6KGSAYOWlOUOOwVaD37N+MaXbtoYWPU7dfoJkDAboIej/tuBpJn4H/f/N9TMVymoNUIoJBeZDY8KAFUiRPbI9FcX9Yj+lhQnzhNHaDwCzZPaGQB3CYbBNCGvfqp+KqUJSk66QPa5HCkZO1IGnyOK9KSThenQiGXe4iePwEKUJvpd1rCCpDLFNs7pjSh6yWFlVyQCJoEah76+tJ5alcPvAEwncmND08hHYb14S31tTxglcPZn98IpsxTqIwDryu//6iRIlC9JJye8RNbVHvgOg6RaGzD6QvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1k2OidQaHAXcsu5LAg151l4XuFwaAcxreDyaPLNuRA=;
 b=O78m+7WuYy4/uwva/RXTIgATt5yutH/8SVWSHCEwyIg5jSVNxDh9KDYU635YRGbBV6Q3Zl7wILDcq8zh/hhgJltAZ4XjTBBnlrAS0UsU9PlQtAHD0yIa9zAGuXSz4eAhePhLaFbnR2Ya+i0aLEtA5dwta4zm/6q7ClxMOXSxTO1T3R0ydmeCnEZpZ14FdB3djsNKBqSOj4cKdHPzwy79lzSsBtUsfLdCQ1+V1IV6CnSKmppih+qLXFbTkSco3cgnvT3RUYbsEG7fdsbAfhR1yhm5bQXBB6TS2b64Q9Pqm8xiX7fwl0HP7RVFLIs7S935oetV8j4S5tXwQJPqziaGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1k2OidQaHAXcsu5LAg151l4XuFwaAcxreDyaPLNuRA=;
 b=Th7jbDG5AzrBcoEqDhDm6GX5ad8cvup8g6sBINVI1a4sM4Ijfk4UIDrkPATpOYAL/3PDcT9/Ot61ztdPcuMlnas+X4FVcMX+5GpbLJ8vvOEexCX5EiiqxY2BU0gFRVCOgBnFUqi1mxmJlkTor6STvVSZzYL9pIjnxcvkIdyHDhs8U8blAX0uPzLbmqTdqP39uy1kwOfWC8XISTD7hdbKVPIDfPl0tUvdGqt2trnku3P5TtwRKqT+c3y6kBp4Uuu95wHeDbtdiWTX6fnWeFgE5S/E1/jYZKFIXUytmk9c/C4aGEVqOi/i7L8zM4lrh58t+jr6ELWRR77OZItdjB2wyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8405.eurprd04.prod.outlook.com (2603:10a6:102:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 16:30:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 16:30:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 06 Sep 2024 12:30:38 -0400
Subject: [PATCH v5 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-dwc-mp-v5-2-ea8ec6774e7b@nxp.com>
References: <20240906-dwc-mp-v5-0-ea8ec6774e7b@nxp.com>
In-Reply-To: <20240906-dwc-mp-v5-0-ea8ec6774e7b@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725640246; l=1944;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OqCbEUzuE4T3rIePR+tm5vsCVk9EgAOhr0RnQgNI8YA=;
 b=/UYymoHjkfEXSwUAe+RXX8a+NNWppPVHgmvE6TAXrbKIm2xqTkIejh2UyPOXpaAfqNdGVKyWZ
 uAYzf6P+lhFBybZJIgQQdT4qaGcA3aEpjRMCMEO+lDB7hPA6dI3s+3u
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: c339bb61-14a5-4cfd-9d80-08dcce914984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3krOTFWVlJiczBsY1NpVmN5dnVHVWtkaktCSG9hS0l6c25hWHEzVVpUcXBy?=
 =?utf-8?B?SmVHUzhKM0E2YXd4bmUvS3k1T3J3TkdFOXBGN1VPV3RJVURiVGJ4S2hiTVlm?=
 =?utf-8?B?dmNNSU1qcjI4aWJDY0FGckRabEcrektuajNZTlFJN2srd2F3OTZpVUtiZFpM?=
 =?utf-8?B?bEVDeExWZ3N0VktIb0NoWWk2Wm1sMXFlMWNxL01xNUlPN2V0SThwNG92SDQv?=
 =?utf-8?B?angxN1FycTRURE8zY1B1UmhXallJVE5lWkg1SVdUb3RTT1BncVNNOEZJcS9i?=
 =?utf-8?B?MkRFNkNzYXQ4OUgvMzRUV2lHNVV1SFJMT3haOS9ybjJnMjNpbGx6NWlCUHlQ?=
 =?utf-8?B?UGgydXB4bXliNlRJUFBZWFhWREdBSXQ5WEtKMlovR3dJU1Z1ZnplTG9rdlYy?=
 =?utf-8?B?REd5M3M1WmtFY2xvRWg4TEdsbFhSOWZ1RnB0M0lFaWwzQXdGSWRlQkNYcStP?=
 =?utf-8?B?QmZUZkQwWkRuN2cwZllybVZ3MnczK0JFWWQxMGNPaHhSNW82MFc2Y01iVkpy?=
 =?utf-8?B?NkRWZjUxSzdxbWlpeWp0Skx2cjlkdEUzKzM1UTRIK1JFM0tWMEpzMk9RMDJ3?=
 =?utf-8?B?SEUxb2EycVk1T1JWdUtkS0ZQTlJDMlFSVzBDZlhYejM1UTRrVDR1RU9WSW5R?=
 =?utf-8?B?VUVSOUNpd0Jqa3QzamU0S3d6SnRLNW4xRHYvWnI0amNvaU4zTmVHTkZSZUxR?=
 =?utf-8?B?QWVCRFRHc2prU3dTMTlRdjdCbTk1dnpqRUNjcllGVEhCN1ErUWpYcVlRdkF4?=
 =?utf-8?B?cGJ4SzZVeDVDanFMNEVPeldFYTl6SGlLN1NEdjZEMk83UHRzcUwzZjMzakdj?=
 =?utf-8?B?elpTWjJxc0hFSHVOZEoxN0h2QkJoVktkdTMvd3RqSzc2c2hhcGp2dHNSajNh?=
 =?utf-8?B?Tmx4WkRQeXlxVks3aHRiUU5TRjAvRndiYmllS1IvV0ViM3RZSXpQZzk5SVo4?=
 =?utf-8?B?V2l1aDdLTTJkWUlQam5mUENpdW1ySmRHdlpTek5taWxzbSs1S0F6K3YzUk1T?=
 =?utf-8?B?eHFXRHlseks2OHM4SndsZzBWdktrMGx5ZFB1b0JuOUEycVRBMStyVzB2cHhr?=
 =?utf-8?B?ZEd3MURLc0xiU0ZueE9hSGlVZXNiT0NucEpJeDZKYjdoVXJlTmJXOVhOR25Z?=
 =?utf-8?B?dDAwYUwySlZPL0txOFg2ZDFYRnBYdnhiM3hiWVFuZEVFZWZWTzFLYmVzYTlG?=
 =?utf-8?B?ZWNxbFYvaG03dGZyQjQ3L0dwL2paNk51aFJjeEtESEFHTzJIMlVhT3pReVFV?=
 =?utf-8?B?M284UC8rRGd1SnVWUXhHd0hLbG52aEQ1VmNFUEgrZDlJTjVPTmtQNzJuN2R2?=
 =?utf-8?B?bks2bmRQeUhkMTNzengxK09PTVdDMVZPbnplV0lxSXRTLzkvSDhtdGxWalZU?=
 =?utf-8?B?Z0dXcmM1bEFBcVMwK1hBS0p2ZmZzUVgrYk13RUd3SFVCbHJmc2RLZC9ha2Nr?=
 =?utf-8?B?T0JKMFdJbjI1WWk0a0E2eTF5Z2ZRZ0NuK2czcmcraFpFU2MwdUN0SWM2U1Q0?=
 =?utf-8?B?WEN1akU0K2VCbm5pYi9TdlVZZmloYlNnSDVFeVYyczZnNmt1REFpc2RORFdO?=
 =?utf-8?B?OUdzRExGTXF4R0xmcUc0UzQ2OWYvT2VNb2pmQ21LNTExZlhobldpMXcreU9C?=
 =?utf-8?B?Qit3L0x1c09NenI0V3hTMEZNR1Z4NXNUNDBxZzhoRnU5NmVTamQ4ais2MkhY?=
 =?utf-8?B?c3l3UjR3elZ2RmlKUjV6Mm1HUE1tdi84cmlNNGRNeHF3THlhL1B3V0ZaU2hz?=
 =?utf-8?B?WkRzcUlZVG4wV3Z4UTZvTmZwQzFScHZQTUs5STFEdnlVUGZUSWY3Q2JncFVp?=
 =?utf-8?B?Yml6TUFib0tFNlQxb01qN2x0YU9pdkduS3BiQ05oN1dsalJrcDV6WlVYN0Rs?=
 =?utf-8?B?b0R1UVVsQWs2K09BSHhUdUptUlNtMS9YUVdoZXVUdkl0TWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW0yQTA4YkI3QlNPOGMyd0VFdjhpcm5HSGRqdjdEcHB0ZG9SYTBzR205Q3lq?=
 =?utf-8?B?amVPSmZwb2tqOUluMnBsYnFpWVRwZUErUUV5WWcrWlplUXkvdGkybERBdHAy?=
 =?utf-8?B?aXBsZ0lOZnNQUzA1M2xmRkZnbzg3R1BsYVk1Qyt6Z1YyNEhQQ0tUR0J6YWhi?=
 =?utf-8?B?NFd0ckU0QzFVc1EzQ3ZVa3ltU1IxL2ZwUjBqK1BBeU9CVVAwYnNGalh1QnZl?=
 =?utf-8?B?dlZHRWNOcmh2OWpEZVVZbXk3NS9FNFlqSmg4aXZvSDc2TTd1TDBzMS9FMHhK?=
 =?utf-8?B?dzlFUnNHV1ArSTNvUGU2T0x2WnFnZzlVTjdyWlg5Nk1WMFRBSSt1SjRDdlJo?=
 =?utf-8?B?SFNldHVCZGhkNTEzdFU0cDFtY1dDcW14bWljTkFsczd4eXZGMlIzOFF2UURH?=
 =?utf-8?B?NDFhMERQN2dtd2tmMFhndy96bk83RlMrTU14M29VcW1wS0VMOCtxNmpHeEFO?=
 =?utf-8?B?Sy80QTV1SUdHRXplZFI2NEdLUmUzcVpFRnY0bWlTNDlEU3REYzNvdy83UURl?=
 =?utf-8?B?QXZYQUU4UXV2a1dhL3NlWTRNajZuSHVxZU5RMkRaL21OQWJMNTlCc1hFazc0?=
 =?utf-8?B?eGpIZW5yTStzc3VUNUlrcDUvYVhiNGF0d0FoZDMyL3ZzQi9Id1paQVliK3pM?=
 =?utf-8?B?M2sxbnNOU2N1VG9veWt4TzhuNGFWVzdlTnVmUmJxVERISHJIVFJwdFpqcTFn?=
 =?utf-8?B?MFI3anVMY29oMDg3a0dyYUc0ZkVBUFFPRDF1TjR2ajBKZmxxQ3Z6amVWckc2?=
 =?utf-8?B?WURWVlE2NzM5MEJLTkVveExtc3FmUFFkVEZtUFpKL0VEUzhWV3FVRmJzbEpi?=
 =?utf-8?B?bWNSZHB2bmJ2QSt1ZnIySDlTMWt3SWUyQUx1UHNGR29iZ0MremFIS0tjbVRt?=
 =?utf-8?B?ellweTh4SzRSTUJiOWdNVnk5eUVQUmpUaVdYdUcvYXNhNTBNaW53a0VXa3E5?=
 =?utf-8?B?UEVOVTRRMHJldllGYmQxZE1mTXNRVU5QSjRWaFNQekNObCsxVFNFcFU0Y3o5?=
 =?utf-8?B?bWRweU9RSk56d2RabkJlcVpzbU9mVmFFV2NrK0NuaHUvNHdKc1duWnRMUlBu?=
 =?utf-8?B?THR2cmY1c2lvbXJMcXpHVk1DYXVsSUI1MjhYWFJSWk5kNmNSUW56ZWVIWnRZ?=
 =?utf-8?B?dE95cjJjOCtRcURrSmtXZmo3S1kwcFhQRXduMTJiYzdZUHdEdjZYL2ZXRG8r?=
 =?utf-8?B?OXZhY0Z2SHBUd3pueXJzVFZEMEpUWHJLMnV3QWlDR2NQWjh6SGRIWWVzRzF5?=
 =?utf-8?B?VXRNVTRKQWtQY0wyTHRUQWE4aEdPZ3liQ2k4emVMRkdUVksvSnhYTC85Z2Zp?=
 =?utf-8?B?RnlnK2FsU1BpaFduQlNUNkRoMHVJVGRKS1gyQTBQZzF1UGRZV25TYzU5WXYw?=
 =?utf-8?B?ak9zRFlBVSsvK1haNzFndW1idVJEakNDc3Z5cnFBWG8raXJLTHpvM3VXRFF3?=
 =?utf-8?B?YjNLV2NpSzNhWXcwaDBkVkFVci9jNHZLckh2eVpTTURJMWRtOEtKaWZoek42?=
 =?utf-8?B?Mld1MXVVTjFnanhxTnlHL25jYVZ0Q2hFd0QwYnlVQlphM29OUEtHWU9BZVd6?=
 =?utf-8?B?MEttc0JGQitnZG9FWklBU2JYcFNpUW1IQjRnMTJOWnJFYXpHQTF2Z1RxK3Ru?=
 =?utf-8?B?elpWeFhRNzU5SURpeVlYMDNaN3lHTDV1ZVF5bStrYlJ2dy9oczVxSGhWdGRz?=
 =?utf-8?B?Vy9NZHJJRnM0V3ZESEJGb2Ntek5FM2hSb01ZUUlobU1DZ0NFbWZ3OFRUZi80?=
 =?utf-8?B?WlRkT3pDODJSeEFjNm9TeFdkcmpxWWRnWE1YVDlRYmpSd2VKTnJHaDNDaFI5?=
 =?utf-8?B?YjhzZ1MyNjduOUtIakpod3dGS0dLMlhaQXVvZC9maVNsMjBKNmZlSWJXVzRw?=
 =?utf-8?B?a3BXZGFDM2UwQ2F4b3loUjhpTElSREtJZFE4QVlQL2RZVGt5WmdramJsVzBP?=
 =?utf-8?B?OXQzUHJSdmdLZHliYVpCWkoxZHE0YzBFYjNmSUVQbFMyYTgweEd6OUlFcnNq?=
 =?utf-8?B?d1l2bUNaRVlRTjlNd1FQcHBJNFo1Uk9SanhhS1dIdDNydmV4NG96bEp0YTNi?=
 =?utf-8?B?WW9BNDdYNmd1azRSYU52NVFHSk8raThxVUozWEFQZmxOdFh3TXJYblRYdW5O?=
 =?utf-8?Q?pERr3OVkfS4jrS2yciphA7I/y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c339bb61-14a5-4cfd-9d80-08dcce914984
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 16:30:57.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfRVrV+cfT+OrcVwJHixo2yqqNFUO2Fbr+7EYbVOTdVc3t2xZeFlJMUTZ4OUBYy8hk8+S0gjoYyNHiK8n6jINg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8405

Add 2 software manage quirk properties (xhci-missing-cas-quirk and
xhci-skip-phy-init-quirk) for xhci host.

dwc3 driver have PHY management to cover both device and host mode, so add
xhci-skip-phy-init-quirk to skip PHY management from HCD core.

Cold Attach Status (CAS) bit can't be set at i.MX8MP after resume from
suspend state. So set xhci-missing-cas-quirk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
- fix the wrong when rebase
- drop Thinh ack

Change from v3 to v4
- rebase usb-next

Change from v2 to v3
- rework commit message to descript why need set quirk.

Change from v1 to v2
- use {0}
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 8b88649b569fe..cfb59f6bf5dde 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -145,6 +145,17 @@ static irqreturn_t dwc3_imx8mp_interrupt(int irq, void *_dwc3_imx)
 	return IRQ_HANDLED;
 }
 
+static int dwc3_imx8mp_set_software_node(struct device *dev)
+{
+	struct property_entry props[3] = { 0 };
+	int prop_idx = 0;
+
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-missing-cas-quirk");
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-skip-phy-init-quirk");
+
+	return device_create_managed_software_node(dev, props, NULL);
+}
+
 static int dwc3_imx8mp_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -207,6 +218,13 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto disable_rpm;
 
+	err = dwc3_imx8mp_set_software_node(dev);
+	if (err) {
+		err = -ENODEV;
+		dev_err(dev, "failed to create software node\n");
+		goto disable_rpm;
+	}
+
 	err = of_platform_populate(node, NULL, NULL, dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");

-- 
2.34.1


