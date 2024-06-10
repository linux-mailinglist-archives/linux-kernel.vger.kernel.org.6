Return-Path: <linux-kernel+bounces-208873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62458902A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1A51C21CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DCA5B1F8;
	Mon, 10 Jun 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahaqLuA7"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C2D142915;
	Mon, 10 Jun 2024 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052418; cv=fail; b=MuWyCRs3mDL+ZP5YN9G9lo4ke/57XvL8cutDzVglC3wZAVzn8mhVBWMseuyKpzZLie8BK8/mLidiekKFvFxZUJnSCiL9CPW4hamfMveG5aZkoxCBOQeeBudOtfxNjcPlbLfUCarbPJXeytbq3PNoSw3JnagKuTyz7qGbW8Khr/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052418; c=relaxed/simple;
	bh=dCwtPi/8EJVcD5gh2DMUVEwQe5fEGO87oefK9gHe6mU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lSC7q+FcW7ALrd6kuS5JlJhfs0KU1CyPi0TlEGtgJJkdOz3H4PChu92Z/mSHK0mFLr/h2iZ7dX0f/rqW8ws6yZ77A5mmz0ssEzLKrwhispZfWKp0JWJ+9mEwvndTuPqhPtdeJJ/gcsyrPkDcEuN03QAw2TlAAuy2v1mPe7Zree4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ahaqLuA7; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyabbG/CtyYYs28X68Ydtqkcev7OlOiagv1n7+VSt65Zu6RRn2+2B2E9GySbBmgO+rjITyl/0aBF72Pw7LGLec4HxTmFz51Zjw211fed2J0C3lhCaUJvcHh3ac9Fz5gNudabkRtmSvpRL067TxnVNNoX5qyz37NYACN5U00PzODgp5qV4ob0SmaA4du9lixAawbzsiMaMrJOKYX5oyUlXdiBx8fsyrEA1J0J4UyfURmmgtxgwzIBCT8MNqvrz2XZkp4JDljPnC9UNEy6SE3O3M6tkaikinx/g/MQZehWLS/Z/RyMv9F2eO1qTguDEmqMVr+06BG+ofcynPfuUXvt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8G5qpoFp5Q8onqriaQOrAEkvT0GxrBUnT872PX/0Qk=;
 b=Uh5e4VQ95EWeSl3my9VZFj9F+2x9FmeewOcFw3wo+URZLkMFciqtqzI2xWzsw0HqSX2vFjArdC/VEQxtFwJeyCj2lBbZPBvE4H7PbrS6WaoAP2M1jT5zsaxla9J9sjV0gBqeVdYJMU80vPF2F3fIAEf2sCjuZwG2gtFpVd0uv45CiM0o7i7iMde6hNS01MkL4iSloiJgb/O322LdXY/Fhynm/G00fpqVsUsdcXglxHdLv0wRlOR7j0ZDm42XoBg2tujQeutHZyShAzpzGX2T0gPTZU+qNHyHK9tzd0PiRgEPe1PtoIGlQ1E8Mu7KXPgk64knsJdgwBjsny+gjQCZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8G5qpoFp5Q8onqriaQOrAEkvT0GxrBUnT872PX/0Qk=;
 b=ahaqLuA7dFVv70aI7NVJuWX5cwMzvvMyP84e070dxX1CNpNG82FOeK89N3VowWeolIdYI/oKP3sYAMSdh01lyp9yqLVdLxdMtlnwba+/GT+iKxechvrlDIptJFC/UaHEkzfFytFtBNIf4em2o03en/Kbf3iB1CpVts1Pa5ceeIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:46:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:46:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Jun 2024 16:46:22 -0400
Subject: [PATCH v2 5/9] arm64: dts: imx8qm-mek: add cm4 remote-proc and
 related memory region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-imx8qm-dts-usb-v2-5-788417116fb1@nxp.com>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
In-Reply-To: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718052391; l=2953;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dCwtPi/8EJVcD5gh2DMUVEwQe5fEGO87oefK9gHe6mU=;
 b=AL51iU9t628NDgrn3X6MlN7DGmrOt3LofQEQdQCcNLgxLhlxGuH33QHMy21Cn1ckn/0heH0rr
 uXWDsvAOJB0CUdV58ab6eJmR/xJfNpSXMzUXEOGcYOiv58C8XpMzJ1S
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: 8330e461-40e2-494b-9790-08dc898e74db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0NjTnBjY1BydjVTRXcrZXBCaHA5NjFacUtndytkbExXbEt0b3A4WEVKK1l3?=
 =?utf-8?B?M0c2elREMTRmUXA2QUlaaFlGNVJMVDVPY1pzWWJCc2x1eU1hTzZLVnp2cFYw?=
 =?utf-8?B?cTRTWXFVYmNVL1FHSEFzOFRQalZwVm5hSDgrSDIwVTdVbUl2MFg0SXJKTm1a?=
 =?utf-8?B?U2FqS0YyYWpPamZEVXpFVWZJa0VIc2IzNkE0L2NkTm5McmljWDYrWFRWYlVY?=
 =?utf-8?B?R00rdUgxbSt6Nm5mc3JBaDBpa1NNS0diSGRyS2dsaWs0VzdOaFZqWGdYTkI1?=
 =?utf-8?B?a280OHZ0V2NsOUQ3b0tuRFNneTFuOFE3b3V5OThHWU0wWHI0cmU0TEdJckdK?=
 =?utf-8?B?VHp6OEJhL2d0cFpRSzFtUFplRHkrOHFTZ0paVGg3RThSRE5qbGVBK0t3Sy9U?=
 =?utf-8?B?akQ0dlB4SGhUajRUQTVnNWdiV3g1VmRHVjV6d01BcUZZR3pweUZkc0hlditY?=
 =?utf-8?B?U25aaVlIMkE5REZwR2NLTEhCdkp1YVhRS2JiSklZblFtMC9QM3pIWE5ZSHA4?=
 =?utf-8?B?ZnJhUUw4Y0c1ejhreC9FRmxadEdia1ZQREI4eWlKSUljWFlPMmFWU2RzaHlN?=
 =?utf-8?B?cHhmRXpEY0xuK3ZwTFlkR0ZoMnVBSVIvYkxWNXhyZG94KzM0eUpEbVhiNmpW?=
 =?utf-8?B?M0tYVlByQTQybGgzWGxWb0JSTEZ4UFQvR2oydHVpWE9FaGVjeVBLakZhQ2hK?=
 =?utf-8?B?VC90TkxoRU9NVk9KYVQxMjVncFplQjh4alVCajZJSElQYVpLMTY5Z256dlUw?=
 =?utf-8?B?OWMrVThQQ201c0NEcHZnKzNndHl5VFZOTG9hLzh5YU53aTA5WTJxU1Z2MkpV?=
 =?utf-8?B?QmFqckY4S0dYVXE0YTJkaml4MzVaYWRCcDN3SmZKY2tPclZaNlVJNThZK2M4?=
 =?utf-8?B?NjhJcFhxYzlaZGxpMEJxSFo3OG5ZdkxMZWVZc0Q4Q1ViSDNyYytOaTU5RWNH?=
 =?utf-8?B?MDFtb2RBRWE1ODZFdVkxQjNUZHFTMEFrU3NCN1FVNFZNdEpzQkV0UTRQeWhl?=
 =?utf-8?B?R3RCSGN6OEdqdG5PWmU0N21mMXk4M0t0MWl6bHo3VzFBbnVtdU0yTU8vTFRm?=
 =?utf-8?B?dENLaENUdFFDdmNobU5tZk9VS0I2MDJack13VnFVYjNTMCtiWUxmaFNzY2tF?=
 =?utf-8?B?TXh2azZ2ZTd0WXlSODRPSmFEL3VKZm5uRzdJV0ZzUnFRSDQrTlpWdDQ5RXV5?=
 =?utf-8?B?dlIvQ3lDNGcwVmpPRHdxUEVzTkNGTGFZR1BmMllIMFREc1IrZGtueVA1Y1Nn?=
 =?utf-8?B?aWhndkp5czZGM1JVK2VvbU5kMzEyNFkxajk5ejlxei9Kc1JnemJJWDQ0YUpX?=
 =?utf-8?B?SHZ2QjMyRVg0NGozdzdrTEg2WGlBdnVoQUZSUEE3bkVRUXIyeGw5ek44UkNE?=
 =?utf-8?B?WFFpbWhGTlVralVYT0hCNjVpRTY4aFFuSUMyNEg2ZVVZMUZQYlRxTW5vS21q?=
 =?utf-8?B?ODc5cUo1dFVsL1NuMEJkVmZ2TnBOWWI5cmF4YnBXcFpQblM0QkJIN1RKbGt4?=
 =?utf-8?B?eEthdGdPZDhkclNUSnNOMldkVEU2ODd0LzBmRStJZTBUenZsTThhNlpORVVr?=
 =?utf-8?B?b3ZXVWQvR3pPcWVMRXc3T3NQTUhuREMvbHFENnpNekxPdXBZRzYyM2FoRkRa?=
 =?utf-8?B?UmRpbEtKVmhXc2xYSmgvd21qOVRSVnBCZUM5Y0ZTbnBCRVBHTTNMVERQTHEy?=
 =?utf-8?B?OWRlNzRCTzZMTFZBcjNkdTR1ZVpnaVRHRGhoK0F4RjhxaGxkY2FBTnRsRmVr?=
 =?utf-8?B?QUM5WXVjT1ZkaXRKaExQVGVsL09LQTlyNU1odnlyQmh4aTZNYVJxQmhRRXZm?=
 =?utf-8?Q?2ohAaKegup+vEAC6HcLVaQ4F9r+fGDLi3aTQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWlONXY2bEZ1Z2tQcFRQWGR2OGo3Mk1DOGRkWnNZcVhtL0IwcGhGZGZaRzNI?=
 =?utf-8?B?c0g5UXU0Y1hCYnp5UTdOK0lvZ09yMGhjTXlOVUhtWDIxUWRieHdyNXdncVpk?=
 =?utf-8?B?RDh4eHBmaGxHRSt1KzQ5bmtXeittRFA1OHZYTGJ1Wk9FWWQyNEI5WXhMVWF1?=
 =?utf-8?B?dHRJKzNlWkZuMlNlQ0VtZHVwMmpqRHBCNFRUU2t1K255dThWZkxqeU94YjNm?=
 =?utf-8?B?K29CWHhwOWlXTzduWXF3dEd1UFQrNFRzTkY5QmtwcXBFbjlwWDIvRFJuU3J1?=
 =?utf-8?B?YVYrb0N2SkZ6RUtYaE8vdUxsSDE4bGpLK21hZE9IUG10b1BFQ3d1T25iTTdF?=
 =?utf-8?B?U1FwdWRoZE1WRmNRL0N2ZWUxbUJoT1A3TXdkZ1BoRU1adkI4SEVvN3BocU4w?=
 =?utf-8?B?aFhnZlBoN3dybkh6MDYweXMxZUJPSGZ3c1Z3TjhVQTZtZTRuWUtYZkNXaTN1?=
 =?utf-8?B?cy8rMFJsOEs2dUhDRnlHMnZDN3BGNjN3dVh1Z0g5WVRRd1ArSndwUGNvRGV2?=
 =?utf-8?B?SmRCZGN6QUMvWUt3cS85NVl5Z1R1OUdaenNrZmpKVStuWkZDRzR1TW1LejZv?=
 =?utf-8?B?bTgrS09kU2hOVWRyWDFNS3ZuazdHSkhPUVFnN2RFMmhycHloYVI0dFZmM2pK?=
 =?utf-8?B?SkxuUWdPYU1ZcCt2NUVSZmtrcXJzbXJUQmJSTnVwR3FleWoxQUN2UTgyWkRw?=
 =?utf-8?B?VWI0RFF5S1VMM0oyMU1uMkdJZGpFaWJpT2RsOHdnNGtQZmdXUVRwMnZoV1dF?=
 =?utf-8?B?RmV5ZlRVN0grWXZaUHlkeEFqaUFpYmRrVTBxQXMxMGpqOHByY0lpZVhoZ3pw?=
 =?utf-8?B?U2dqeGw2MGxTUmlCMzEvWU1yOW9Jd1hzemZvSitLd0Z3ZkFSV0MwTytNdllF?=
 =?utf-8?B?MzY0QXJzdHM2VjNxRmR0RlNrYTFRRUhZY2ZSek9JWThQUEx2MWVXOEUrNmZW?=
 =?utf-8?B?ZlFlWEtzMnNBQjBMSm8vaEJ1N3RuMHE4Q1NJS0t0YllEVmlRazBpUWdKMFFu?=
 =?utf-8?B?MWJGaHc3NENxRStCSjJuUTUzY25wcXdSQW9CRk8rVkNISXBmaG5zeFo5M0Jn?=
 =?utf-8?B?aEY3aEc2NnlsaXVLM09KWnRCdGtabUpBdXNjUk1EdURSSDRxL01tdld2Nkhq?=
 =?utf-8?B?aGtDc1JvOEo4M1RzdlBMYnRUN0NRQzFxejVvcXlSRmpuR0RkUW5tbStMZEVU?=
 =?utf-8?B?UlBXUm0rblN3ajB1cG5SSWRtdWMzcTdaV01SeGVLVnRDNG1JenloVUJMZVFO?=
 =?utf-8?B?L1BJb2czTm5IWVZOeDNuTmhCbnJlTGkyWWpNN3dmZDNpL29Xalp4Nmh6bHY1?=
 =?utf-8?B?S3RINnNwZmdJMWJ6Ymlnd2FyMHBqYkJ0RXVkalo5V1FTNnJjVkR6dVM2QmdR?=
 =?utf-8?B?cDN4ZlkwcDBIbzRSSXJ5ZG1zZUJZOUd6M1Y1Tmk3REdTK0Rmc2NSL09Ed0ts?=
 =?utf-8?B?UVM0QXlWWkVwVUNyN0w2OVlXODlHSXVpRm01R1NUSERVWkNVQnN5bFhwemNT?=
 =?utf-8?B?aElzdGZYbjlCZTdnK0ZVTnBnM09NN3BtLy9Hc0FMQjMyVzJCUXFwOHFMc0tE?=
 =?utf-8?B?Vndlb3pxTUovcnl1R3BnclRmNWMvR2hiaXptSFB6emQ4VmtMZFczT2t0TmQ5?=
 =?utf-8?B?OFpGQlRPZzBROW5HMHJ0V1Nka1ZGcFlyUUt5YkJtQlpYWVl3cFNaSTlDbSs4?=
 =?utf-8?B?U3lueU1WWHl5cUpEMXgyTW1rOVhMeEFuSVM2SXc0UndQbmlvUlpKVjNpeVdC?=
 =?utf-8?B?UGNHNFhTTUdHaGtLU2l6QVBxd0wrbFRRRTVwYTJ2SHplcmdibE1tUmxTN0tI?=
 =?utf-8?B?VnBpYzJnd01qTjlhblR6bmw4VXpJRVRIb2ZCRm5qd05sMmsvY09JcTZBNlJE?=
 =?utf-8?B?eWo3cmV1dU0yY1haMnN1Z1hmaDJjZUpSZzlDWnhHK3RWRlhzK0FWeTR2OURp?=
 =?utf-8?B?QlloS0RJZERWWlVjdkVsQVNsZDVkemp4cEM2TlFBd250UnphcDdEeUZxb0Vk?=
 =?utf-8?B?NEQrWVZwNWUzcHc4cmVyWFBYLzlENUMreWpwQ3lHU2lhVnB4WSs3cm9ObCs5?=
 =?utf-8?B?MHRvc1pmWFBNZi81N2tWNFhvYk9kbnlDUDZzK1ZVQ0dkY09pTk1xYnpIV0Zr?=
 =?utf-8?Q?xOAM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8330e461-40e2-494b-9790-08dc898e74db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:46:51.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/Auux0EoIrOudDsD1tgU76VNcY0gLjMsv3aLPMEYCJbX8egd9FdhOtjr9ouhtt2UIr+aLn35o0W4870cPIohA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376

Add two cm4 remote-proc and related memory regions.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 93 ++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index c024be33fbcce..dbd478af2e474 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -31,6 +31,68 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		vdev0vring0: memory@90000000 {
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: memory@90008000 {
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: memory@90010000 {
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: memory@90018000 {
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table0: memory@900ff000 {
+			reg = <0 0x900ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: memory {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
+
+		vdev2vring0: memory@90100000 {
+			reg = <0 0x90100000 0 0x8000>;
+			no-map;
+		};
+
+		vdev2vring1: memory@90108000 {
+			reg = <0 0x90108000 0 0x8000>;
+			no-map;
+		};
+
+		vdev3vring0: memory@90110000 {
+			reg = <0 0x90110000 0 0x8000>;
+			no-map;
+		};
+
+		vdev3vring1: memory@90118000 {
+			reg = <0 0x90118000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table1: memory@901ff000 {
+			reg = <0 0x901ff000 0 0x1000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -133,6 +195,37 @@ sound-wm8960 {
 				"LINPUT1", "Mic Jack",
 				"Mic Jack", "MICB";
 	};
+
+	imx8qm-cm4-0 {
+		compatible = "fsl,imx8qm-cm4";
+		clocks = <&clk_dummy>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu5 0 1
+			  &lsio_mu5 1 1
+			  &lsio_mu5 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table0>;
+		power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
+
+		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
+		fsl,entry-address = <0x34fe0000>;
+	};
+
+	imx8qm-cm4-1 {
+		compatible = "fsl,imx8qm-cm4";
+		clocks = <&clk_dummy>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu6 0 1
+			  &lsio_mu6 1 1
+			  &lsio_mu6 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev2vring0>, <&vdev2vring1>,
+				<&vdev3vring0>, <&vdev3vring1>, <&rsc_table1>;
+		power-domains = <&pd IMX_SC_R_M4_1_PID0>, <&pd IMX_SC_R_M4_1_MU_1A>;
+
+		fsl,resource-id = <IMX_SC_R_M4_1_PID0>;
+		fsl,entry-address = <0x38fe0000>;
+	};
+
 };
 
 &adc0 {

-- 
2.34.1


