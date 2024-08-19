Return-Path: <linux-kernel+bounces-292451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97309956FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84721C224A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D6217C9AF;
	Mon, 19 Aug 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXhZYmXb"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175317A59B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083345; cv=fail; b=QvZ83J9dn1Ueck+lnBm4vCEBms4bQskHrM12FgBgYCB/3Gpzaze/RwR2KGhS1Xd+vDtenfbFlBIdDQ989fWsLj4qDEoBWOFqn2VbJPnpTnFZ0J/FeYilx/HXxoa9A6vthfwk2VXfzukEarqCpjgwg/m7tDssD+B+8oYoeS7WGPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083345; c=relaxed/simple;
	bh=EgTA/bzPVGwsyEemXX3hWkQUEBTDZOU6gFrO4erNl9A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sMjFIpuYj3e2s+UnbaKxNL7+9OfUaQv0P7cJRVj5NMY7e4CMMfV0KxcKSMbBmbTaHg7aM2ewIyLOYZl7xeBfSwcIKAGxxAfPiGGsqosdK/uj0pYgtNQBbGeRp9TpayudNcfKblA04HRV7aT9cMqGaQygOSvxtuJvolAHtXNJEOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mXhZYmXb; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctQ0csCh7jlZ2GGofr0z7q/TZdv3lqqyVJ47ZjZlWtpVR9jQlPMX34FK7v/wJTNobp4u9OGeLIg9JCcAx44jCUckIXGVySIfm+OY8iiJ9NsSUhuLmFAJQBDjeKPnD1qTMThrCH/SKmKAp79a2dpFFVfR25rkrgeEoJA1LH/2Y3rIvXpgbT4iOKoDYEjNZcDQmTFGbneqIjsBh1OGFClXuuwJdsmQgpM4O9ciRNb9gWHcAwhcd69iqvkVzImCEcbgZ0uulXtA6IZXiqQM5KDawsnC610d3v5FWvDaLohTjJueML/eExc6i6RJLhbGMvT6wU7v58BhtDKeVVvssm96pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZHzogEyoKA0FrCgQ8jcF7EjjYfhLpLTAtbn8jWUYd0=;
 b=tcxdAw4f4CUFIq9bFaa+Z0p0lIPUddq86drQQaYv/eYm4VQtAhw68hBJ8txmd1ex/fEd1SESzzXrg6+ImN3/apmDWX24INnOhPW+V6f+Q9EiERb+ydZjQ2nB+oh+m4UXHDMpdrCSB+XJZLxGzVxBDLbVES9Zfhy4NoQ3OnXvEKT/hCByqJBcqfyXsa436Kb9s+78EIHfkj3GUR6+0BVX6bQIDy/AAyBFuLffhtTLO6CzPmrlRbNrVzhVTrMN9cr8QVM9JrxSt4YSGDpNkaaDi//FDX1HKDobC+a6W/3h2qimlmicu2jH/n8v4CXl7C3xyDoES2Aocsn2E6CCDGnyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZHzogEyoKA0FrCgQ8jcF7EjjYfhLpLTAtbn8jWUYd0=;
 b=mXhZYmXbRp7usO6DxBGlPS/aYf3dpuVRLjOaErNv8dMV0ePfdcpMD6DpXP6XY1ElHcrbjYs3OU/nBjSTHJuF1QtKDTU4VlDPMp01DC4P2HOsD16Z2CZpYmAApqDhFvWrC+5nqjeXEJuf4/8VH6y7AlzGkfgP9dV8LFq4GxOG7HJtfnHtPDuQt/6ix01JjlLQEScyopqQnft8OXSxxM+PyXVnQweTYhjj3e7xgx1qwIdVI0E7B7shlEjGqQoRuJbKedWEyjcdiN7jyFbZcMvzsTNA/6WgYGKmpo7LE66ezYF+LF7k8tjMOhAMtGZkyHtGY/1ITvdJ5JRMKkwbGw9CHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:02:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:02:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 12:01:59 -0400
Subject: [PATCH v3 05/11] i3c: master: Fix miss free init_dyn_addr at
 i3c_master_put_i3c_addrs()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-i3c_fix-v3-5-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
In-Reply-To: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724083326; l=1049;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EgTA/bzPVGwsyEemXX3hWkQUEBTDZOU6gFrO4erNl9A=;
 b=245C5SaZoRsMaZrnL72wzR8YXU0UPxmAMih2qbDLqUW+N8dWcW9+yw4j7b/PpjNRkf+9/C9P7
 9ZCCLqKjzLCCoe2iFOoW7pZlxW17gi4tieq2tX04cV4u+/H1LWhMPSr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: eb21c79a-4dc2-4c8b-0317-08dcc0684e39
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SnpFZ0Y1TmZESVJyR0ZwMit6Vjg1VWlDM200MThhMjNmSGVFUDVScWxZaGhp?=
 =?utf-8?B?ZGczMUo4aWp2L1BYVUQvZncycUxDc3dpVW5iaWd2MXZFSzlHTVhUWGxyVmYz?=
 =?utf-8?B?M1VTR0FGZXJ4cHpBbk01Sm5UeUI5am9KWnFLQko0SG5uTG9xTUZ6KzJHcnYz?=
 =?utf-8?B?TlRBSHBlNjFZN3FkN0RCU2E3S09DVjZoV1F1dDBJYzdPUy9YWU9WcDBxQ1l2?=
 =?utf-8?B?L1lNK3MxVGszWkdjbmZHc2ptWDRhMnkxTEd2cnRZTHFveDEySm9VWlVGaHJw?=
 =?utf-8?B?MFh1aDdkZ3ZsSWIvYk0wcmVHVDBGMW0zQ3FDelVGQ01Hc3ArQ3NFRjk1bUFt?=
 =?utf-8?B?VXVtWmJia2tPK0NGNVNMN1BmRlNTdUNVcW85VTBWK2pRdEFPR1FnTm9JVjBU?=
 =?utf-8?B?emNnM2dNWmJlWTEzcWIzWFRIS0dPSk80Z3hjR3d3SURCNmU0SXVDT1lXSnVm?=
 =?utf-8?B?YmpNNHJwc0p1UVZicEplako5MnpmUTFnb3ZLTjlpa3UyTVExOEtpQWpQNXN0?=
 =?utf-8?B?dlhsUTlzV0pxMVBkR3FxaVRIVWRhSWhNU3hwSjNRTU1qU01saGJxSG9RYUQ4?=
 =?utf-8?B?NXMveTc5ZmpJOStVQ0c4bVp4M01XLzczNmtLMDkxZVdPSUdYa2tlU3BTY0tG?=
 =?utf-8?B?Znc3N0ptZS9JSWVwREp1ZURYaW9ybU1lNU93VU1YdEJOcUJUMVl4bVBZM2U1?=
 =?utf-8?B?cTN0VDJDYjFyNThrYWFmRm5wOHpKMy9BT2ZYbVFBTVM1cUJ0eHhoSUEwR2s1?=
 =?utf-8?B?bTkvdHYvSW9KWENJV1ErMjQxcnp5a3RRVGlWeDYwMytWa0VITTNCQVNwQ3RG?=
 =?utf-8?B?TUJuK3I2MFZzb05LYUFoQmxKSUhOOExIemR1Ry9SYXd3bURaQVBjV3NwZ3Z2?=
 =?utf-8?B?QjRISjRqOUUvaE9XdzhCY25RdjBBYUpZTU9ZdERDSmtqQkRsWW0zT1Y3Nkgx?=
 =?utf-8?B?bkRWM2xRNWxzcmc5eG14MTVOV0xJZGZVTyt6RHd4NnlVYmRMOE9SakFFelNk?=
 =?utf-8?B?SEVaWjloWjMrZDBiTWVudGNxYVpQTFJDZDc1RnkreDVrVEp0VFI5L2dXdFFT?=
 =?utf-8?B?SUFSUFhHRnRueGFsNEp0NmcwK1d1V0laN0pJY1RURUtXMGVNSlRBQW9aWkla?=
 =?utf-8?B?eklQWjhZbG1wWTBGWGJ0SEFvU1RoNVVpNnd3cWdVQVpUNlAwM2pUdm9RQm0y?=
 =?utf-8?B?TUZEc0lkQlRUMGZSZ2d1YUJCcjNOb3g1VEdROE1TMnZReUJ2dmFseFhpVmlD?=
 =?utf-8?B?aGZBZlUvQS9GS0pFa3p6VSt6ZVAvNkdkUTFDZURjalpENE1vdVlYSU95YjJa?=
 =?utf-8?B?ZUhOdlg4dithVUdLbDV2d3Evd0kzVVRhRmJBMFJ1VmtRWnJ4WDQxd2o0MXcy?=
 =?utf-8?B?V3ExSVlRUnIrMnJnSXEydndNTHM0ak8wWldPbERqdGhwQWg0RWpBMkhCOFpq?=
 =?utf-8?B?Tk0rS0hUVTRPcWtPQldQWWJObjRwSFc0THVHWnRkODdSWm5rWnlMaUt4a0No?=
 =?utf-8?B?WFpMRllLalVtUjYyNHM1aUZjYnkrVk5tVHc3bVkwbFAxV1FrNnI5R2dKOEhx?=
 =?utf-8?B?M3VPQ1o5STNiQ3EzT3ZoU3J6VUlLcENDdFAvT2ZJVWFxRUFOTWZadGNsbWxL?=
 =?utf-8?B?WXNDb2VPSGJHOTNvYXNUZ2o4OWVLeXZPSGFNOEF3TWIydnBEaDBaSVArMHhT?=
 =?utf-8?B?UC9iNDBuU0xFQSszM05hdWVvejMzZWlrMlBMNkhqK3ozTU5hYXBXS3E3TXNm?=
 =?utf-8?B?SlE0YXNTM3pjSUxqYVRCaXV0VnEzclRkZ0xPMDJkNnd0SFdLN1cwQzV4eDJt?=
 =?utf-8?B?YW8vd2hUZzluRDA2MUdyZ0ZIS1JIdDE4UTB6OXFodzZBWlk4bWFRTmxqMDhY?=
 =?utf-8?B?N2NORkV5dDlZRlFaTHZSQkhnUUN5RXQ2akN6Y2ViM3h3bHc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZG9ZbUxDckpPdU9WMnM4Q1AzR2tkcHlSMnEvYTV3dTBxWWNUb1FCZ0Q4TFZL?=
 =?utf-8?B?Vk5BL3doUHNRWlYzMUJ5a1RJSjJ5WWtMT0dhN0UwU1pOamdFcldON29JNEdo?=
 =?utf-8?B?K2JEV3RteUxlYnFGWEV1R3JSQy9zSE1vbzd2ZnhubEg4NG15WVpCU3Q3OVhZ?=
 =?utf-8?B?aW56cXUraEpqUUd0WmpRMndZd28xM0RMM0YxZitOQTNpaWFJdzc1WE84dDhN?=
 =?utf-8?B?eUVlaUhPSlFLb3U0ZTVuNDg4b3orZS9BWlhOa2NCSXFWWmc1VHRBeXBYYjRw?=
 =?utf-8?B?QTVYZzNHV2dtNS9lNnpXVnZlQXVEdUVTWk90OGs4U3RITFpseUZMek5Mb0tF?=
 =?utf-8?B?YVhLeWlEOVZqMDBKTlpqZEdjcHZjSnFLejlWMitWV05GbHl3enJEOWVNRjNL?=
 =?utf-8?B?eC9UcVVUUTZlMmZ2MWovWUdRdGY2cjNyM2VIM1ViYnAweXB1Vllac05DNjBz?=
 =?utf-8?B?NVZkSmFJZnViRFBkQ2drd3ZybDZHT2pjZlkxQ2NyZlhxOW95Wm1KU1dYR2VQ?=
 =?utf-8?B?enVaaTYwQ2RMajJKM29aMjBTQUFkT2J2L1ZqTVlDZnVvV3NOK294bHBFZ2NB?=
 =?utf-8?B?VVNEQ0x5MlAvcDBqRjgvc05GektiZEZpZngwNk5WM1Y5NmlTQjZHVm1leWRX?=
 =?utf-8?B?Um51djZYNXkrOFBCUmMxWHlWRWNGeGZPaGg2azZDcE5nK29RUTFBeXFVTjZa?=
 =?utf-8?B?Wml1LzdTdkxPVWpqbGZTR1VGOW5qbkdBWlg3TU0zQjFmTGNkL0M1MjhWajBv?=
 =?utf-8?B?Rit4aEM3TDJGSVhrRUdqMDlRdG9CR3ljbW5taG9SaXBBSWsySndkREZ1aTh4?=
 =?utf-8?B?c2dpTlRRTGk0Tms3TzllK3BmamQwR2tMbkI2R1RKRUhGUlA2SDFFcHFQeWVU?=
 =?utf-8?B?SmxKelp1RVMrWWVYaEM5UThMalZUODNrSzRJVUlFcjRhR3VxU1B0dWNMbHha?=
 =?utf-8?B?UmxkRks2Y2xJalJqZmFTaVRzZXFHdThUeDhHSE1xK3VxYXErcGN2cUdZY1Mz?=
 =?utf-8?B?M1BFd1U4RzFGN2N5d3dBNU5Cd1RNb3prYmhneHdNS0JuV3VGWk5hQUkyYWVx?=
 =?utf-8?B?K0R3akxsYmR5RzNsRnBlckxtNk5UVjBHU1RWdThoZElaWDd4WTBtcHNZYW1E?=
 =?utf-8?B?WFJFYlJUa1ovQVRyZG9ybENZRm5WWEhDVUJQbTNGV3dWNFU1V0xFSE53bHBz?=
 =?utf-8?B?UEhRSnZ5QVRsdDQybjNMbW1RdFExNzd5WXJoSnVwU2Z4ZC9zSjZpK0IyTXgw?=
 =?utf-8?B?TnhnK1hwZjdud2pYWVd1SG91QkpwRkd5NS95cllwUUJCWFlBSWwwTFJVRzJq?=
 =?utf-8?B?dnVaMlQ3N052Z3c0NzRVaXl0aVYrbFlNK0todVFSU0NUQ3gwSnY1REJvN1VN?=
 =?utf-8?B?MTF5by9kOWRaZ1pEM0Uvbm5aMG1tMlIvRURsRHVUbi9jK3FSRlRad2tVOHgv?=
 =?utf-8?B?NXZvcjFLYkJBQmRhc21uVkVsZG8wVnZIYktrT2NqTnRSNlhyUkp1MG5pM2pa?=
 =?utf-8?B?RDVQay85amZlZHJVM0Q0Ym9MM0J3WFpLZUl2UVBTSHBFQ2VaTjlOTThpZGdD?=
 =?utf-8?B?RmtkREtmcGJXQnJjM3FmRmJnRUFZYTlBbVdtcEc0N0FTcDBFeUpKYzJBbDBJ?=
 =?utf-8?B?RTBtbmkvN1VYbjVYSG5FVEhUaHo3NWVGK0lPTFB2QWdPKzg4ZG0vY2FNY28v?=
 =?utf-8?B?WHZWSExaUXIzMUlLS0dTa0xmb1VuaE0zQ3RsZlJDV1Mvd1ZkbXVjREo4bTJW?=
 =?utf-8?B?ZkszRWhhNEtqbGJiSVNSN2JWVEFaaGMrMHl5UEVrUzEyWHlOdkQxRUV6czlZ?=
 =?utf-8?B?L29OVm44TGtoSGNNQlM1M2x0RkV3TkpkcUlzc2haOFRVY093R2FqeDhPYWdW?=
 =?utf-8?B?TXFwUVBlLy9vY3VGaHl6S3dGSUM5aXRCT1F0bUVnSHBNN3Z0WDczKzR4R3Jh?=
 =?utf-8?B?VmYwOTVHRG92UXJ3dU4xblg2SmczU3ZDbXkzeWMzQldhZ21WL3JVSVBiRUo1?=
 =?utf-8?B?a2JyM2hmVEZFaDFOeWRJMFJ4Z1hBSUVkbEhxUGRDdU0zTkdGMG50RFNFdzJD?=
 =?utf-8?B?Q1gwTWtxdUlxNnhUYnIrbU5jckg1enY2enU3dUpkS0VoQnFJaGw2WjFldUda?=
 =?utf-8?Q?cwWgjQX23M7pUZsAcij/8QtsE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb21c79a-4dc2-4c8b-0317-08dcc0684e39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:02:20.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1n3lxORKPN+KR31KAHetuU4WfJ1/wSDzQZ0LtuKmiTJEdIV1AwzxIGbZ0PdBMS+UaDaQb3wjpfQ4fFhd24wVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
                                      ^^^ here check "init_dyn_addr"
	i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr, ...)
						             ^^^^
							free "dyn_addr"
Fix typo "dyn_addr" by replacing it with "init_dyn_addr".

Cc: stable@kernel.org
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index c8eaeada54781..65642e5afdcfb 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1442,7 +1442,7 @@ static void i3c_master_put_i3c_addrs(struct i3c_dev_desc *dev)
 					     I3C_ADDR_SLOT_FREE);
 
 	if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
-		i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr,
+		i3c_bus_set_addr_slot_status(&master->bus, dev->boardinfo->init_dyn_addr,
 					     I3C_ADDR_SLOT_FREE);
 }
 

-- 
2.34.1


