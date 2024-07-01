Return-Path: <linux-kernel+bounces-236514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A9891E344
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58541F22B19
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0286516C875;
	Mon,  1 Jul 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LWXtkWzP"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264C16D4E2;
	Mon,  1 Jul 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846238; cv=fail; b=L/gm0aBphqDs0en5vQ5TK6jRELexlg3KBGDEtAoZYwdoAJ8BEjMpD9R76+CXz1T/XI78pjR21RQPWu5V/jR/t0CrZMVqRvrFG1g8f9bHzuBml5BV+5q2obcFU1VDduAnkBm2KlQPl9uP/weNCDqlPXi08Rb5tXn4GYopnJV0ZJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846238; c=relaxed/simple;
	bh=XCUDXz6P6qoQoUmf7K0bLTg1SJKxzmluB5QhvEptooE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JPOmZ3A8aSU/MnOjPO7ab7nKp05yRTQ/ENa1UuQLmxmPShrTACgZiI7jR6kn5yKPo7jERGFdOEVb5oGwTfFrgz0+E7Yv8PLYWwLQTRLd1NuLEwUHhVcABzQ3WXm9FA3e05SjUK97wSuup/ooWh5w1oOSk7puWWJusAFcuUvOboU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LWXtkWzP; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6/qfmNk8y5nfjXEM4mMUopNOnvWF6zwkOcZPAcO2xYWlrHMdbyRaut+zWoT3UC9bxVee7TRzr5utoqXJZyT1MPzcI23qL5ifHwkki35kdZDzw2JmGh/9gMiBw3V8MlUIPNgyvxAG8NG+94hfY3yFwUTa5nsJRO+tL5StWro+a1wwEiJKBJS1ZIkN0SRhkCLULTXCBRAQRkqomLzuwFGNLdGZoCjvY3fPPnjqXVtS3uuYe8nDavdJ5jEDXWHxCXecXp0AMl8dV5IZu9t76Ibktk9g3afBQFCw/nbcNYxqn/oyjO+ZjmSAQpdRxm+4b9hu1UUnDi+/H5mcLmrLkXaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ/gvaWHQBm6sY2AeA8959U2nGfe75xQ7uoNYRMEoK4=;
 b=Sr4BG5oASn8S5dQm+YiaO63SXdfkekoF02nb0iPojfsl/03tr1GS5s0ijP/FHlmXCNfpxvQA7stLKBZCr/S1inkxojKlfJkx9AFnwG4CMSMN9vhioVp5G8j2PUGkSl5o/+bs0i6tgiCEVhY3jzKcH05q5/FtOyEgbU8N3MLD7dY3Xgu04BS9WiOB2A1u5N5AORhQ/hnvnLiAoTp0jU4eGsL7SeTU4in+Gm1dH0VzKSWlJHWRFUve9c/oYLhPiSUTVA8D3fsCLGE5ho4yHtCVI6ZEECulbiHE+Iw8f8CeP+mwWEWTm7G6K5jWp2o5yuPTtnmbAUChYSNut8jsLSj62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ/gvaWHQBm6sY2AeA8959U2nGfe75xQ7uoNYRMEoK4=;
 b=LWXtkWzPXeibYxKCBe27MTHoFvpE22DjV7ik6BwnwX3kqHfPC++AAFz1ZkS7E0BHPIFj/5Md2/IcTOixnbV2rx2lwH/1Lt9PJPgPJGDBMfSZaDs2iA39yGYTYpwdTsL4aCmYNfRypUucQS/23tIIO5WOx08xlWxnJwXQYvOBhQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:03:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:03:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Jul 2024 11:03:28 -0400
Subject: [PATCH v4 2/8] arm64: dts: imx8qm: add lvds subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-imx8qm-dts-usb-v4-2-03cdbc8c44b6@nxp.com>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
In-Reply-To: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719846224; l=3746;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XCUDXz6P6qoQoUmf7K0bLTg1SJKxzmluB5QhvEptooE=;
 b=8YjjQbrwhs5x6qxIblDyBqOLXSvOZC+m6WaTYlzgCmi8Hyoiwn02SWlvu1d2r+5C0Sb1Ii7JJ
 QhwRkMQ+VabBg3MM3d+mowYL71pculjOvSMxerYGz5u04D8xgJ4DhOq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: d41c94d2-792a-4f7b-ffab-08dc99df0678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MStDczZTWWlJU1F0Ky9QLzlJazNmK2luT2Nnb2loekVJNHdHNXF2U09SZTlV?=
 =?utf-8?B?MVFzQjJFMDNUNWFnM0RncXc2cnd5TFFyUXJJK2hKUFM5KzM1K09kZmJoZjRK?=
 =?utf-8?B?RktoOUw1L0luUk5DdTU2NDFnYXhRbnpwcFNLWEM5NlpHZ0dWL0EraVozVkl5?=
 =?utf-8?B?THB3WFltWlRYNnRnS0hZU0J1TGZtUVlNd1FxQ3BBQnJRcVgzT2pvSDRTd3B5?=
 =?utf-8?B?MjM3YTJIU1ozZCtrQjBPMEtJMUZEOHJGSzZ0NXNDcUNKbEhibjc5TVhpUDg3?=
 =?utf-8?B?cFVGR1hHMDJYOERWOVNaTUU3MjFRTzkwSk9rRTlzR0ZSOGlhUTFLK2cyeDJ4?=
 =?utf-8?B?dzk5VVlRTStuZFRxTUV6bUFidlZSYWhSZXh1by9LaE9kNWxIM2d5M1gwUU94?=
 =?utf-8?B?M0xhMTJQVEQ5NUxBZzg3aFFQTCtiQjl3ZFY1ZWlzWXE4cTdZcVc0aXRJMUpK?=
 =?utf-8?B?a0I5S0NJTmJuMFE2Ynd5bmRNSkQ3ZzVjOHNuME4wMnlvR2x3UWxZU3Q5Y3A0?=
 =?utf-8?B?ck9DeE9RSll6TFphNHFFTUdJUkdaNXgxbTI5OEVvWjA0K2tyRU50NUhaMEMr?=
 =?utf-8?B?cXBmVlhNU3dyMXFnaWV5R1pCRmhiS09TZmNNbWZPZmoxZ0N3bHFDZFVqV1pB?=
 =?utf-8?B?aXkzOXA3ZW0yem5MSzRYRWR5OXhjNFdvTVIwVVNvalBReGpUblU2NkxoU0Fk?=
 =?utf-8?B?WVNtZ1R5ZCtuZnBaMGJFSElTY2VPc1lUUU8zNjhTOEl1YW4wbXR6WVZhMXp5?=
 =?utf-8?B?cHpHa2Jibm12VHJmUUd4YW1MWDE1dSttazVDQzJ3R25yc0V3MTNIeE9XNGJJ?=
 =?utf-8?B?eW44cFNUaTFCODVjdFR2eDRkQVBlSnpsUnRVZVk3M1l4NG9NRzdpaStWREdz?=
 =?utf-8?B?YlNRNlVBbVo4R3VSejZVVnV2RjZuRHM5elNJeGEzNHhxMWozOXRuYjVUVWtC?=
 =?utf-8?B?SExyWElaY1ZZOCtvNktjWnFicnk1aWt2ajg1OVQxR1pYVE84TW1ISk9vSDls?=
 =?utf-8?B?cUw4RHR0a2haZGFGWGtFb2F0alhxYmI0dXV1YTI3U29lSWd0NkwxT2ZFeTk2?=
 =?utf-8?B?T0czQVcyZ29Vc1FsSSt0bVpydCtueU9vWWpSNkIwZE1sdm5aZGNPaFArWTlr?=
 =?utf-8?B?dEY2TkdBYmg0eE5EMjJDcWtCZUZFRjJnOUxiS0RwOXc1dUg1elZwaExhN3dO?=
 =?utf-8?B?NSs2NnR4M2JuYVcydVVCRnFhWE9wRWpRclN4T2pLQ2RibWxmdXZGbjNaK1VU?=
 =?utf-8?B?R0dLZ1FTZVlyNTJ4NDk1LzF4c0tJc0ZzOW5pSWJETmk3c2ZVRTVyd0tLOEJX?=
 =?utf-8?B?QWhJQU90L3RkR01qTkFyTWVOOWZqRXVyS1pZWks0ZENWZW5HWFdLaWpxUnF1?=
 =?utf-8?B?dFBuKy9WUkRYRmIrRjhZYzUrZk1velpUS1lVNUR1QWl3Q3QwMFkwYlpkaHZO?=
 =?utf-8?B?Tk1rVU1wVHNyb2lNM0w1dTkxa1RvZmRMWXZRd1hYL2RRRGl0WmZlNkU0alY4?=
 =?utf-8?B?OUhsMVAvUmJqVlhodWxEaVdzNG9nQkVnRnBVbjFLd2JMbzR0aFdQcVNUVVps?=
 =?utf-8?B?TEZhbWFnc2E4VHZPZUM0Nkllc1NvdC8xS2o1c21Ha25LTnZZQ1BqSTFHTEZO?=
 =?utf-8?B?N2tRRXJuZURlUVh6SE5tZnZrU0p4SzNuNjM1Mjc2Q0VqRGJLVDhicGlGZTRk?=
 =?utf-8?B?bUYvKzQxMXhBbWtJdjk3SGxWaWFpMHVyaGpBdkhta2dYbzY0aDAzSjVyOEcz?=
 =?utf-8?B?NEVyeFptYmtDR2preEkyeDh5aEp2Q2NnQ3VZNVVUT2FnN1kyTHRKL2J4SUZh?=
 =?utf-8?B?YmhtbnJ3ZlBIOW9ndm1aWStlNDFrY2h3c3FJSkZIdU1QeEVDRnVkRUZYSzQz?=
 =?utf-8?B?RGFxN1JYSnJJUWpoVG1LWE9KOFozeXJ0UVFUV1hKaDZqMnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THVtei81SjNtSTVESGpZbjYwSEJOY2dYYVRKcjU3RW1KZkF3NTVqVU9YbGFh?=
 =?utf-8?B?TzM2eHJlSVZ4dHFLT3d0QVd1Zzd5VVc3RkVuZlhUVU5mTzZQYllnQ2QxZlJH?=
 =?utf-8?B?WEpvaW1WMnU3ZjF4a0ZPWFJzei9abXJYVzhXY2VOS1ZLMTdScnMxQUpIOXBD?=
 =?utf-8?B?MVM2U1o1cHFCelJJbkpWRHBQM2dJeW1WY3BSU1g0NkdVa2IwSWFHOVlyS0hz?=
 =?utf-8?B?R0h6RFRuN0VQM0xkRWRVK3pQRWJQV3pMT1NYYUFMNWVBWUNCWitqNzNFam9U?=
 =?utf-8?B?M2tIelhDY3NLRjQxbllPOEZ3SkN1em01b2VaUzQ2Wko0SFdaVUxuVm0vdWV6?=
 =?utf-8?B?TGV6dUdRUXQ4QnhHcjhDNldqSWFaZkhZUnZVZFVqMXZMRE5rakZMdHZSR1Jh?=
 =?utf-8?B?UGpUQnVXazEvTk9EZDJQaGFUSzl2cXROczIxeVVQdmszS1ZLdXV5bzEwOXVx?=
 =?utf-8?B?dXd1WER5T3AxbndXUHlSMDZ5VXJiVkcrUkcrS2d4VXBRMGtONVZhVWpuK21a?=
 =?utf-8?B?NEJVL252TXVUdTBxMzZpWlNPdnBibjRBVEU2WFk1YUN5YXBGcUF0b3NOYmN5?=
 =?utf-8?B?UFFpNVovM1pQS0VVTGx6Z2ZlY3AxMXU0NXNDQWlTOTZaZEptV053bEp6WXpw?=
 =?utf-8?B?M21iTHZaRm9uWUs1ekU3U0xENHROY1NzNTZiNEt2UzFxK05QcG5nWFRBWXQ0?=
 =?utf-8?B?RGZVN01YcHdYUEFwVnE0dEFkSkM3VFFWU0JxZXRnTlROQmZFVU13K3hZSWw5?=
 =?utf-8?B?Z05WNUlBL2lGaXNKWXNVdmp3a2M5aysxZmxScjNibkJJWlhjSmh6UllmS0pJ?=
 =?utf-8?B?Q29hT2hBeDFnOXJDY3ByUHh6Y3ZLUVY3V2NSa1ZIWFZKVzRNZjByZWpoZ2w0?=
 =?utf-8?B?Q3BReGpScDBzNGRQa3U1K3dQNG5zdHp2QU5QamNmd05LRHFDS3Q2VEdxSDNs?=
 =?utf-8?B?L2dCektiVjAyQzRGdVIxQTMxTFhnOWpsSWtBQXdYK2xyTkhiREtlZ2F3ZkZq?=
 =?utf-8?B?UnhUWWFKS2doOGZZUFAxUzhIVUd3TFVqdVhON1ZYYlZ0djVDd0R0WnprbThy?=
 =?utf-8?B?TVJHT3E1NzlvcXZwU0lYeURaem53dTJqR09xNUJOdTdaZlJUa3dTbnNmZS9I?=
 =?utf-8?B?S0o3SGc2TnpsemFNRUNjTTdram5udTZKUTBPZWtMUDJPL1JoVkZJVVlOU0xJ?=
 =?utf-8?B?ZE8yQm9MMHo2M09aeFhsNklZR0p6L25YWW9odDZYNjEyLzEyb3FsQ1pZdDl5?=
 =?utf-8?B?bERkREZnQktWYVZWRVArNkJMMFVLb1FnR0VpZktLdDdydmtJeTZmcnVmNHpQ?=
 =?utf-8?B?dlNOQmx1RmtjSEFLVStQdlQ1Wm5tSG1KNGNDQkk4ZHNBZzhSZnhCaStEOGNx?=
 =?utf-8?B?UG1BSDhNY3ZYdE5sQUhXOWNWT2twdldvUDdYM2YrMzllaS9HcFBsNHFQQkR4?=
 =?utf-8?B?NHNNUlAvYStSNmQvS3lFYUl1dmFYZ1FQZmRRZkdFY1hzS1ZYc3R6UHhlQmFH?=
 =?utf-8?B?dDhqQ1o1ZXJXbFk1ZThVbGpORXNRLy9zYzdhV1BOR3Z4QVRFNmNkNC9UKzBh?=
 =?utf-8?B?RVh3eXNsb0lTVXpQZWxHc2tUeVFyQW9leHhPcjBMeHJMSmpieE9jNUorMGs0?=
 =?utf-8?B?eVloS1U5ckxCQTVDRHJCVGdNMUFWL2VDd0w1WlA0TGdacDcwRzJudnZoc3hu?=
 =?utf-8?B?K3luY29KVEI5V3pNR05NNU8zQmlnU1JOMHBhdjNqT2tpc09yeDZnUERrL2Jv?=
 =?utf-8?B?MmgraVp2WVF0RnAxM0FyUldvVW1MSUJFU2IvQzlwdS9qTDg0OVRaeHgrL2Jj?=
 =?utf-8?B?aXZZVFpCbWk3QlU3Y20rdWlGYUJSMlVCR2N2cXFCN2tneFFlSHlnd2NlR3Jj?=
 =?utf-8?B?S2pBSmJOOTkwUEtQOUNpZS90azg1TVFMOE11MkpYZDd6c05kQS82MVpCYmxk?=
 =?utf-8?B?VW4rS2lZRGI1NWtqZlVwcnVsb2tyUXZ0T0x3UnhXNmpHUngrd2dzZy9IaUgx?=
 =?utf-8?B?eUJjQ3F6M0h1aVZqVFJIa0NLbzdFM2F2ekRUUkhYVzRRYXBUYzNJeGtxQk5k?=
 =?utf-8?B?ZExMS084K2s1azQ3RWNjcXhGSE81Y0ZwWHlGUDRjdUp4N0tQTEUva2o3MGdm?=
 =?utf-8?Q?CaWk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41c94d2-792a-4f7b-ffab-08dc99df0678
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:03:54.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPOndftoM4UUO27MaocS58jrbh9InmJBWo6JDCHfHoONGDJ4Pnjd8olo2Ci9zkLNGoV751Mvj52obZLndePKJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166

Add irqsteer, pwm and i2c in lvds subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi | 77 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         | 10 +++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
new file mode 100644
index 0000000000000..1da3934847057
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2024 NXP
+ */
+
+&qm_lvds0_lis_lpcg {
+	clocks = <&lvds_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_4>;
+};
+
+&qm_lvds0_pwm_lpcg {
+	clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>,
+		 <&lvds_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+};
+
+&qm_lvds0_i2c0_lpcg {
+	clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
+		 <&lvds_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+};
+
+&qm_pwm_lvds0 {
+	clocks = <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_4>,
+		 <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_0>;
+};
+
+&qm_i2c0_lvds0 {
+	clocks = <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_0>,
+		 <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_4>;
+};
+
+&lvds0_subsys {
+	interrupt-parent = <&irqsteer_lvds0>;
+
+	irqsteer_lvds0: interrupt-controller@56240000 {
+		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x56240000 0x1000>;
+		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&qm_lvds0_lis_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_LVDS_0>;
+
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	lvds0_i2c1_lpcg: clock-controller@56243014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56243014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds0_i2c1_lpcg_clk",
+				     "lvds0_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
+	};
+
+	i2c1_lvds0: i2c@56247000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x56247000 0x1000>;
+		interrupts = <9>;
+		clocks = <&lvds0_i2c1_lpcg IMX_LPCG_CLK_0>,
+			 <&lvds0_i2c1_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
+		status = "disabled";
+	};
+};
+
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 61986e0639e53..1e8511e8d8577 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -560,11 +560,20 @@ clk_spdif1_rx: clock-spdif1-rx {
 		clock-output-names = "spdif1_rx";
 	};
 
+	lvds_ipg_clk: clock-controller-lvds-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "lvds0_ipg_clk";
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-gpu0.dtsi"
+	#include "imx8-ss-lvds0.dtsi"
+	#include "imx8-ss-lvds1.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
@@ -576,3 +585,4 @@ clk_spdif1_rx: clock-spdif1-rx {
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
 #include "imx8qm-ss-audio.dtsi"
+#include "imx8qm-ss-lvds.dtsi"

-- 
2.34.1


