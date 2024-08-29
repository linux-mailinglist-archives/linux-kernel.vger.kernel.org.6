Return-Path: <linux-kernel+bounces-307692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE36965196
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A2D1F24BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D50193097;
	Thu, 29 Aug 2024 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ka1aKJpu"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869A18C016
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966098; cv=fail; b=NHfwAiuvhMD/9GCtLkf2sysNKi6dhxqP1obVZSSEM4792N8tahnPAqQ4ut4UtKeDMQb5wLzgODeQF8hI8yKWjnmoR8+foKsDE4TNSWo9EP0DdTWZMqCL3sQBz1C2sptEE98oNMhBv2C0yn7yCU87Shscly2ZTjsnoRdgX7albs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966098; c=relaxed/simple;
	bh=UiDcNDkPN6XID2EDxw+hsqrwbsBPgaVCvqRoeU9RYKI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=jBI1nLrFc17MdFmIpEaJ/z6MG/4ultjv15PBwWEOTttm0iTD11sTbXEW4NOnkSEVEtunXBn2syjl9sh2srbwdE9Nb2LwWqQ6yBZWSCITZ5MPEjkjJM9Acvhfji7YqCwaBSpmxUoeJx1POqBhiIHvcfALTv/R20ym4wOqkMwDyMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ka1aKJpu; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUX2qGbqeFUNKqi9A2fJhcYjv5lUNohgip9CxFcQQkQqOqVhckODevtHSEm4tBdCmIdT7WxfTvJv8NbFZeDaZI/9dQzkqpwJr9uz3eLB41kWdTFbQY7SOoMnXBx5CvtQx+KutMtI24hRZDY+RtzGThh6B5KF0dzmmfOC95nILCbaQG5WXUXbDUJWlEJmfsHovqGBCIwmvTKtGJw9UdnCEHm1cpsJMrwp49gUc/bdv7U3hybcC6+4UBS3l67ljE9exT2aEm+UM+QfZb+HFGMrDhL5ptmKjHBxK0oPLaujCEnTvVnEg/8G09m1mCaLDy0XBp8wBkvpCPXF6w+447yn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtteZUO4947jhBzsYUYSoc17Pp7vdqOtvhMK+e6cP68=;
 b=H8Noe959IFM2nix7jAjRIZwfDAnwjP5gfV3UNFDTH04tT49kkaY6aG8tqgJ8UpvlsIdq/B5eRpA4j5TNyG+Zv5PX7sEJn0/wd+eq2cnzy+E0peU8/mmUGnahUmWErxmNi6FwdR0GnJwkXExgOgAEMAi2Icdozt/qs3xnfQ9bDTiKru9c/L6EUVcbqsQbp95tRMAmKfVuySfFDTYzS7EEJPjfmj3K4BNQqjmBNa2mCM75QZJoALK97ApQrK5KE8rRCwlafh2RQgp/6yFgA60KQVNtnGRkI+u/kvBLNsjweCzuB5Y7NU8OqTPDfr1PdRaOKn2ed2Z6abzyjcrk8iFYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtteZUO4947jhBzsYUYSoc17Pp7vdqOtvhMK+e6cP68=;
 b=ka1aKJpu5p5qN2p1z/YHZ+phHaJ9fCr1m1ECBbHQ3LM4roPZosF/VtZH7alZZ/PLspPz7Xvi3c86S/pZQw+ByHWJwgo9KZe+Q0uLF2B3V2+bRhs+zETosLtz+jzLF8wzNWGZkHtiPN5l5oficPhiBXfDGNt5LXU+NN5KLKPAokiYq78ut+FiurNzdXGJGYZfqGZ73AaRceOJVGHyxmSlWgKvj09cZA9rJIXBOQdPVXvEklb0jEVBmV5tQI7YNnaYbNfOPCKRw2SNI6knIMzQ3kWAieGpkVvDe5pKcGqzsQNKkbQdcEpwvtBqs34L+l9rSTcPEj+x4yyiLcVL7CKxcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7560.eurprd04.prod.outlook.com (2603:10a6:20b:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 21:14:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:14:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 00/11] i3c: master: some fix and improvemnt for hotjoin
Date: Thu, 29 Aug 2024 17:13:57 -0400
Message-Id: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJXk0GYC/2XMTQ7CIBCG4asY1mKGnxbqynsYY6AFy8K2AUNqm
 t7daTdoXH6Ted6FJBeDS+R8WEh0OaQwDjjk8UDa3gwPR0OHm3DgEhSXNIj27sNMhWLWa28aB0D
 we4oOz3vpesPdh/Qa43sPZ7Zd/xuZUaDWmwrAAhddfRnm6dSOT7IVMi9KM1EUR1Vr76SBCpjWv
 0p8q6YogUp1deOVBYSuqHVdP41xePAIAQAA
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966082; l=3045;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UiDcNDkPN6XID2EDxw+hsqrwbsBPgaVCvqRoeU9RYKI=;
 b=t0Job+XVVBi6SNyklAV8bXNVJH3UT30lXz8xe/sNF6K4eEd6eTlrPW0F5ERGj5O1ftzm0Iudr
 zz4/K4nW22HD2zRZeb+IFcxeCyk2xwpC9h9NqtlhVOxBK3DU7D2t2sd
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
X-MS-Office365-Filtering-Correlation-Id: 67ec9722-e641-4395-6b04-08dcc86f9bf2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cElENU1zbDk4d3dBZzM5SGlEajg2RDJqUjI5N2hFZTJQaU9ZanlWcmZINGhH?=
 =?utf-8?B?VzZTNXRtSUVGTEgycFljT1RCUStMRGV0UjhnQ0pnNHdqMlhrWkp1SUk3MnJq?=
 =?utf-8?B?aWxpTHJ2ckRBYTdleVk2V29aRXFrdGtZV3lXenBTVUJMMU9LM2ZBbnFpVmxq?=
 =?utf-8?B?TXNtNVFxMGVRMmVxMmdmeFpoeHRlYnU1d0FtcVFsVzhhbjJXQzE2akl4RDJw?=
 =?utf-8?B?TEpCODRtcDlHbXVpUWlteG9MSGRQeklzUCtpL2pTejJaTEFCOVZqNVdNNWFr?=
 =?utf-8?B?QlBTbVBzMzRaSVdwZXhVWlZGMFBDUDBPYXg5T1VWTnlxVVNzaS9SVmozUGg5?=
 =?utf-8?B?aUk2dEszZnkzR1U0L0VNdjM1UFBYNVBhWjY1N0FBeW9ySkt0NmJWVU9PZ0Nh?=
 =?utf-8?B?UHF3cCttNkJ2WHd3aHhQQjdhUUVZazRSdEd0c2N4QmdLNWtERkJqcXphV3Vz?=
 =?utf-8?B?UFVDTmowU0JMbWFYWXpDWHErYVN2QTBMMlhXY1FNcXp0eURlVXZqQUl4WUJz?=
 =?utf-8?B?NkxyMldRcStsT3NZd1c0U0xuTmxiek84YVRMWTUvSXJsVlltODV5dWllaVk0?=
 =?utf-8?B?Smw3UFhLZzFDa2dTRDJSUDZJK0tsb2tERlU3TS9zdS92ZGgzS3dLYnBxMWRC?=
 =?utf-8?B?M1hrWlhvQ0YrdE5oSytSVit0czJjd1V6dkxLYWhaaHBieGFJK3dUcXVWWkpw?=
 =?utf-8?B?cGNvWUFOdzhDdExhN1Jjd0lrc202Ny9KZjBab2FFUlNac0t2VzBNL0VrME1t?=
 =?utf-8?B?L1RGaVZ0VHlWcWJMSEdVakYvcFh4M0pwR3lORGVwM0YxTUxiOVVWa0s3OWQw?=
 =?utf-8?B?N0JuUjI2OG5tSVNpYnY0RjlCeU9Jdkp3UjhBMEhHQzZrbjZzbHd0VUQxZzI3?=
 =?utf-8?B?NXdFRm41RjlGcXNRcW45aHR5WTlhNU95a1RrS1ZnSFdKMUFIK2o0VXlvSkxy?=
 =?utf-8?B?UlFuUmNZWk5zbEJvVVdKaTVnZWFoZit4NVNSUVJqQXhRSjcvdFpEKzZMakVJ?=
 =?utf-8?B?eWYzbVRsT1pUZ3J3aTMvVWFFU3NNcmJod21kdUFqU1RQVEdBMThrdFhDREE1?=
 =?utf-8?B?NzFPOXl6ZGpVL0VaWDZyemJOTDhCL2NtWlJvYjkzSlRBankrd1V0Y1RrU2RS?=
 =?utf-8?B?WWtGbTlXREZ4dUE5T0VxTitoZnBDSk5YeElSWFJUTFNyWnFkNGRjVWdFK3FD?=
 =?utf-8?B?VnhkYldSTXM1RWdpamlxOEVibytPQTZ5cHRjLys3cnMwanVWSHlCeGhTWDdo?=
 =?utf-8?B?UWV4WWFiazIyTGg0b1puczZuNVNxM0t4Z3hZRFdhUkZDMG14T21idlF3RFRW?=
 =?utf-8?B?dTNqSmhUWHNxNEV6UE1USWdQbzVPSGpTY3NCQzVhT2tRWm5RWTB5KzBkWFgv?=
 =?utf-8?B?TUVhdXFHS1FKc0ZrVi9DcnBJdmVtbWp5eitXVll1M0JWVHAvZTl3RmJiQUg2?=
 =?utf-8?B?aUpseWprKzJJVlpadk4zRFZmRFB0M0hoalQyZVdoT1RjOUg4OU8wRmdnY1JJ?=
 =?utf-8?B?RmpUbi9uUzVsUWh3YUZ0V3hvZEdBdmNiREttY2FKc3V0bEF3YWsyRUorV3Ni?=
 =?utf-8?B?eHNUeW5XK2VZT1J3Y3ovbjQ3U2hCRE9ZVjE4ZnRpNnZBcUwvejFadmZpR1NR?=
 =?utf-8?B?a0NrSzFnUkx6ZWt3UmgvY3NTTUM2MTNwaDN0QjVhM1RtVUhkN0FVZytvNmhy?=
 =?utf-8?B?K05rc1l5b2xWNHE0cDFiVVlRL2JUZWc1ZFJxRnYzKzllb3piSUx5RW1qWDhC?=
 =?utf-8?B?TnF2ZFpzeUQ1dDdYSG1ndXYzTWFLWlowRGRZRkJkeVRGZkd3T3NhQy9VZW1m?=
 =?utf-8?Q?YKiik9Ide7VSb0sJdxaELx78OHiHFG58hC6j4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UHI4Wk1ML05Jd29oS1NzY0FNcW5tbGpJTjlQbWZaYklmWUp6aWNtUEtBZlZF?=
 =?utf-8?B?aE1GRWNVeDAwRWhWTjJtTWpVZy81azVadVdvekhiWEpNWm1pN3RKVWdaUWRQ?=
 =?utf-8?B?eVE3TDg1TzE3OXhTd0w0ZWFIaDZMMXRnMUhiWmMrSE5USTljdGtXQy81dTF6?=
 =?utf-8?B?bHB0U202WWllbmtCQm1uYVQxNUZ2ZjluWjl1RXhrQU41QXZsVkRQYjJPQklO?=
 =?utf-8?B?YnRtRm83dHgra0VLVUllWVpnNlpLM01iNDRsRDU2bkZXNXBpSWROaHNhV1dP?=
 =?utf-8?B?ODM5VzRKSW42ODNIRmpDYU5QSE9GZXFaR3RmZGNod3ZJbXN6WFg1SmVtWG5j?=
 =?utf-8?B?SHZNTExpZFZJOFBsL1dIZEVWZEorMWdFKzBwL0VvRFUwTi9xVWgxUXhvclhJ?=
 =?utf-8?B?WUsvYmdwUjhRVnhvV2g4L0Z5eld3c0VvcTJ4OGh0ZlJMMVMxSWtaK1pzTmpm?=
 =?utf-8?B?Wm1aVElTRW1DWDdCOUc1bXRKeXplM2psLzFTdU9LZ0hSeXdMdjExMXdVTDhW?=
 =?utf-8?B?VDMrY0tsMndnNmJaRTVKRWtOY2NkQ0k2OHV6amRiR2xlTytoUjNKRG9Oajdk?=
 =?utf-8?B?MnFhc0FRTWZySDFFMWVQWG5tOUREeFd2VWQ0VWlOT2lkaW5lT2RkSTRvOFNh?=
 =?utf-8?B?cUNCRkpJZEpOUm9OYU9aYm85MG5zWHJmcTNLTFZ0UkNJL1FyejBHUHV6RUJk?=
 =?utf-8?B?b2ticGVHQzY4RGQ5QWVvZDgyb29LRm42Z2kxVVVxZmw4WEJnTEZLeFR6Nzdi?=
 =?utf-8?B?L2JqOVg1WmhZei81Mm5pN1FxczM1bEU0Q0JBZzBsc0dqbnkyaElNZitUNmx3?=
 =?utf-8?B?Yy9PSkxKc0FsbTBIVnVuTUJhQ3piczhsaTZSVkpEKzZ4ZEtLYkZPUFVyZXlu?=
 =?utf-8?B?eW1wRjN0WUVBcGlldC9LL1RjTGVZNkJ3UGRFSHBvcENXeTdsdUdQNFV4VVZV?=
 =?utf-8?B?ckhIQk1INVUzR1RkeTV4U2YzS1ZGL1d3SWh0bzU1dHkzZVdYNHl4S1VQYU9U?=
 =?utf-8?B?YkkwMitjN290WW1adGI0enBwSEEvY1Y1Uy9ZVGIzS09hZE13NmptS3JFWFhX?=
 =?utf-8?B?b0pIUUozZ0tadGZLVEtKZWdZQ0trbTFhQm5JRERaRnY2VGd4K3JNUGFxZmNN?=
 =?utf-8?B?aDdoeGFjdm1XTnZWTnpucW16Mmp1bHp1bHM2UlNHdDNmKzRiZ1FZc3JWenpa?=
 =?utf-8?B?bHRyNUQ4TkpDZ1JWQmZrTnkxeXpXRytNSUFlQURMQ3JxcGcxeHB0OEZhbTZk?=
 =?utf-8?B?NkFCb09kVFZLOXo3UmdHQ012MEE5VVprR3g1b3RUdEE1ODVpMFpHZDhKNHJo?=
 =?utf-8?B?UjRlVW9idmxCbGVCN3RBLzhwRmFGd0xRTkpWaTRRNnIweEN1eS9SOWZRUHc0?=
 =?utf-8?B?cHpRVnhrOVRqVDVmakxmSitkdGowMi9pNGxKYzNIMHJNeUhtZy9BOUxwUm9W?=
 =?utf-8?B?Y3FDZjJtQXZPL3B2R0FzNXV3d3JFaStoeUtYdE9HRzVDbmVrRUNScG0raDV2?=
 =?utf-8?B?S0Zlcmd4Wnl1WldNSVJOeEVUczV1OVVpLzB0aWYxb09xMEx2RWV6YlRucDl5?=
 =?utf-8?B?Rlc4djE0b3MrR0o0WVF6bTFJaWxzQWw4UWR6OGtzaTRWcXY2RmhXS3llZVdZ?=
 =?utf-8?B?NGsvOWhGQm5WdXdaY3lWNlNCekJ1c042c0FnSkFKaXdZd1VadXVxQXR2ejNx?=
 =?utf-8?B?VXpWOTVPVVNsaU16SDJ1RDJzYVNKZWVRdGV4VVdlR0FRV2diRlhwY0lwRGFt?=
 =?utf-8?B?YzMrSjNzdDY4Y3pJenJTTlh2djBJZzM2Q1UyTDUydWlsOTd2ckVBUU5OSFFj?=
 =?utf-8?B?WTYwQ1h6T1ZNL2M4WFVIM2JsYjE5SnFoSCtacDJhMVlsZWwvUHJLaUVaU1VR?=
 =?utf-8?B?VDdnaXpPRWl5aXUwWis4cHVBUW9McFVhblZQeWx5QjhQZGdrRG5HV052Ymdz?=
 =?utf-8?B?ZnQ5UVRISno4aXpCNWdvaHVRWDk4UkpGclpOZmJCYWhsQXRqa1pNc2xxcnFK?=
 =?utf-8?B?TDZyZ1gzaEF2Z0tJUDN0MWRQcWtaNXBZOHpkWDNyK2phS0tIWHlHUHRKaXow?=
 =?utf-8?B?YUZ6L0lFak5oQVdzNHRWd3VvN2l6dCtFUisrUVRRWmVCNUgwTENmcERnVDRp?=
 =?utf-8?Q?R+b/E+RgG8O2kD3x/EQZfFT0T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ec9722-e641-4395-6b04-08dcc86f9bf2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:14:46.4326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0hBsTAEZiBD3oF9YMA4pC9ZcjVH3JCDyryZ3X87hQi4A6IWT8Ebgm45U7JHymFM51GD3pnfnVJMShO1ufyKTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7560

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- See each patch
- Link to v3: https://lore.kernel.org/r/20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com

Changes in v3:
- Fix build warning
kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-master-Remove-i3c_dev_disable_ibi_locked-olddev-on-device-hotjoin/20240814-234209
base:   41c196e567fb1ea97f68a2ffb7faab451cd90854
patch link:    https://lore.kernel.org/r/20240813-i3c_fix-v2-10-68fe4a050188%40nxp.com
patch subject: [PATCH v2 10/11] i3c: master: svc: wait for Manual ACK/NACK Done before next step
config: x86_64-randconfig-161-20240817 (https://download.01.org/0day-ci/archive/20240818/202408180012.ifcIOjgX-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202408180012.ifcIOjgX-lkp@intel.com/

- Link to v2: https://lore.kernel.org/r/20240813-i3c_fix-v2-0-68fe4a050188@nxp.com

Changes in v2:
- add help function at i3c: master: svc: manually emit NACK/ACK for hotjoin F
Add below new fix patch
i3c: master: svc: fix possible assignment of the same address to two devices
i3c: master: svc: wait for Manual ACK/NACK Done before next step
i3c: master: svc: use spinlock_saveirq at svc_i3c_master_ibi_work()
i3c: master: svc: need check IBIWON for dynamtica address assign

- Link to v1: https://lore.kernel.org/r/20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com

---
Frank Li (11):
      i3c: master: Remove i3c_dev_disable_ibi_locked(olddev) on device hotjoin
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_INIT
      i3c: master: Fix dynamic address leak when 'assigned-address' is present
      i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()
      i3c: master: svc: use repeat start when IBI WIN happens
      i3c: master: svc: manually emit NACK/ACK for hotjoin
      i3c: master: svc: need check IBIWON for dynamtica address assign
      i3c: master: svc: use spin_lock_irqsave at svc_i3c_master_ibi_work()
      i3c: master: svc: wait for Manual ACK/NACK Done before next step
      i3c: master: svc: fix possible assignment of the same address to two devices

 drivers/i3c/master.c                | 100 +++++++++++++++++++++--------
 drivers/i3c/master/svc-i3c-master.c | 122 +++++++++++++++++++++++++++---------
 include/linux/i3c/master.h          |   9 ++-
 3 files changed, 175 insertions(+), 56 deletions(-)
---
base-commit: f2b9f0aeff2b3bb0446c955f0d8fac7659644c75
change-id: 20240724-i3c_fix-371bf8fa9e00

Best regards,
---
Frank Li <Frank.Li@nxp.com>


