Return-Path: <linux-kernel+bounces-311037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F8968433
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5FB1F21588
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02315142623;
	Mon,  2 Sep 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QOrDxLAM"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699213D260;
	Mon,  2 Sep 2024 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271847; cv=fail; b=qj/lsv/eUQW+Dq8wzRyYa3lFeQfxxGvCggVtWghOJfCe4hVcN9KjUITT8npHaPxXJsYV/dH8ZW6VHt+vinMcObaj0xbb5+uEtfcKA94Qt25O9YCnZJXg9IOWsILS6jVATbMkk9pDnPmlhw+QYX+WkMq15oT+UI3fw87BxpFKkUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271847; c=relaxed/simple;
	bh=9c8XwYhm5kvlJFhXyu6JtIvTD0DkSwTghzUbNXmQeno=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JZ2OF6zhLYyPULyCGwh+5hapZ+Dx37XmTd7pFJsRRrYWFUb8cPjDLiInsq4wDfi9okNe++/MfAIoGtYrH83GnYz+rFK+bFf0g0Y76lyRnpe+HfQcjEFJas9gfhnC6t9/fxAXhiOB2XQXQU1m1zGR9p51rvtrtjrNJUWPC9vm624=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QOrDxLAM; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaGSLWGwuLq8ZT/jhmAoVeUSdAfvf62TnxQXK15GS9liz62Ooy/GtQbjdiCiIndpWj7z+yLGNt4OGEER4t+uXO2TTzGdYEf1ss77Aa9af49NfKbGHl3aXvfxb6qbw9tUHk5J0G9XvubU+43UEVSRqOZN59HVuuLZPa59Cbx2MpEKpwJUJN53Q3zmjYOLE+ZZZ30OHTP3gFRrmbb10f4xIlLdm2ENpb70g1HV4Eel7SojRalvenwGNU71y/1lYfVg58vDbyLZ/wLRwlPpMI8sVYr1y30wlqm+rR9jS92ULIbiQFwpVAD1uiOAgpmnwnTGwY7+L8tswUX6ZhosRCDrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXXp6AWxkt/8VT8ysaqdRaNsxlkMeE0hMvpW2fB66H0=;
 b=Rh/vQeyP7G1UbzhyojLHJUmps89tU3blEKhxocvOn/O2ow1p4vO85Mi8zxmsvTFbusTMs4tIi4aa10kIrEDF23jDcO/hoIW2m6wh1yNSIrjnRatSlJU8Y0S0+10Xfb+UsxEPmFTcwW3zSbHKmmbOq2ML2ucGamdQ/Ir0Nwn3sMW0gKiYVFgujVttKjbnyTF3Ef9OEHNxVwcAl/6ZqeWHo/sdnbZmed0miBJhSXRomcZqITj0pT4po//1I17Ms9z8T2tFPf+5l/+v+TIFaX0HQlUz6Vmsd0Hf9zsxKAoDp03RvqaQhNnJk+Rtx82AbK/kHN0FLbT0rd5GepJcFk1heQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXXp6AWxkt/8VT8ysaqdRaNsxlkMeE0hMvpW2fB66H0=;
 b=QOrDxLAMi2t4y94BhbwYw75nFT5U53hF4hV+on5mN7LePKPAdXdlw1dVGZ1+X7dPNxkQUOL4t0jsJws7bVGNXT5zRMuQqTtzI4EJKt1XYOMx1s3XqGRFu7ayVie+yZu67Ka75hHSAGgAZ9vdW799q/mEMFOLKFwFzMagijhxpP6COZUHpuVWUFZ42OsdUQfqllttth18xocTLvxtbvsWCvcFEn5GakMX38/Hp5aBZiMFGdAIIkd9MbzFHhj23QPG+ZwI20FEHFQyRtxnHRlZcmOHS2019KjhV2pOFNtqadtaTeVSK1vpGjxbLMp7upSghIfCuoAScJ1uNAeGiozUpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8171.eurprd04.prod.outlook.com (2603:10a6:10:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:10:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:10:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Sep 2024 18:19:23 +0800
Subject: [PATCH 1/7] arm64: dts: freescale: imx95: set max-rx-timeout-ms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-imx95-dts-new-v1-1-a1f798f4f746@nxp.com>
References: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
In-Reply-To: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725272373; l=876;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Ae/5HixawuzT6tKqp+GLQZ8yZQ+B+M4UK9qykHcPCDQ=;
 b=kcITgRQSbAfAxqy4e2p7epUKs9k/MdkocjSeRT5yJrEAI9BcEkubc6tRS16OC9hErixpQwdy8
 FFycnh30/XMAU72PHlEUc9/+nyRyDR0wjeJ3S9RJm9xM/OCx66YDZl4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: b40740cd-4d4a-4493-e1d6-08dccb377f03
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGdCT0dqRXJuRm1IVmJjRG1HcVNKMEN4ZlRObWpJRFBsYmRNT1VmMSsvSXF4?=
 =?utf-8?B?R0hwWG9FS0ZpeHRWSE43S0NhVFplalhaSnh2L080b05TalJ1dTIrRjJVRitk?=
 =?utf-8?B?YnhMbGVIeDFBOUFsSDBCMkZXVHczTkh2MC9jVFE5dW9ZVFMxeFpXRkRHVG14?=
 =?utf-8?B?VmNsdWdBc0JJSFVocS9kdmtoc2hBdjYxbWhtOGEwYnF5eFN0YmlNcGo1TEhF?=
 =?utf-8?B?TXR4eWtHY0cwTzZxWm5iVFFzcnJTMEFQcVdGNkJ5Y0VXWE9sY1gvcnYxZHdR?=
 =?utf-8?B?TTJldDg1UGl0QjUzK2Z6OEpYRUhNU1hZOEZ0d3pNZXJUem5SbEZDK2VXQ3Jz?=
 =?utf-8?B?c3NZblpHOUxyTkZ6Qk9iTmRCQWl2cGhTa2Fta0MzVnFSMVloemU2eXZ3WE5I?=
 =?utf-8?B?Y2lUdmRkMmt0Qm4xUVlMWG1VOEdQNlA4WEl5eCswNGlwYlpZcVZKNjF5TWFz?=
 =?utf-8?B?alVXOTlFVktlWEVpanpkRzBFRVJVajRBUmoycEFlYTV4Tk9JT1htTGk0M0Vx?=
 =?utf-8?B?OVhFZ2dkNFNDZmdQSFByL0MvRUg2ZHZSM2xvMno3Nk9xcnJXdVJmNXl0ZlQ3?=
 =?utf-8?B?V2NGaGFpR1lmOFB0TUk1MG9PekJmK21sQlZyRExyZitpcTRIb3kxSW9oVXor?=
 =?utf-8?B?N0x4YXMwK2VqSG1SdHgzYXNqMXZoRE02QWFsbDhIMWMweWNBSzBuRHRhZjhH?=
 =?utf-8?B?c1crbmFCMzd1K0hkNlJmUVUzUWJuZUtLR1B4WUZJREhRblZQaWtsbUZDdWY2?=
 =?utf-8?B?NTU1TVBBV0dKN0dOWVJjaDhOcmtjSnJrUnVyeG1mb05qYmFjT1JFMEplWHJx?=
 =?utf-8?B?ay9jZ1RDbnF4QVVkMldOakJNanhUd3hDWEhVTTUyL1d3NmNUclhjUnVpMWdD?=
 =?utf-8?B?WWFpR05WU2crQ3lmU3dvZ2pER0U2Slg3YUxCV1lydXRlVkdKMHpuS095ckVr?=
 =?utf-8?B?QzV4RldEZ0VsQmUyS3V4dFVqaHl4NW4rbUxUaDFIZkowd0pqUnYrWUJRK3BZ?=
 =?utf-8?B?SjhFNnpIQTV4Tzg2a090VHY0cmVNU2hNOXkwQk9lR0wwQzU0Wm5Ib09sd2kx?=
 =?utf-8?B?bytTRUZucUxqR0FtU0tEL0xVbHVqNXpWbzc2bW8wN1pOZEUrM0V0THNYL1lR?=
 =?utf-8?B?QjNLK2R3N005QTIvU09jQmw1Z1hkSis5L0hiQzZBUHRBWUtMT0ZXQklwQ09G?=
 =?utf-8?B?TUlHbGRaVTc4U3ErcWVXRXEveDNpK0Z0Nk5RSXdxSk9tQTFzWVZlOVpvcHps?=
 =?utf-8?B?Nkp5UXpBVk1RUWlUT1kyWXN3UlQ1YTUrMlF5MGRoZWFIaGpIMnF2Q2t5ZTkw?=
 =?utf-8?B?ZTUyazJJMm5URElZa2ZpWElJa1FyRFZYRmt0N0ZLWWlMYUhmdEpZR01FVWJO?=
 =?utf-8?B?bkdBZ0luaHpmTmh4NlNuMSttcjI4bVJQZW5NaFhaK1h2Z2VtdmhQYTZYbUla?=
 =?utf-8?B?RjVkYzRYNkZUUDd3MDBJV1ZtbCtSUVBFb1JUbngxcVpqM3haUDR5dkdISWww?=
 =?utf-8?B?QURwQ0oxYVpHL0lzNS9oaVhLSTV6dEZNRTdNNTNoK2ZybHRoL3dvRDBpdlBB?=
 =?utf-8?B?UWhwNmM2TlNEcm1vSk1iRFdqVkdManBzaVUybWxqclJ5ZjZPZDRGWTlZdGxY?=
 =?utf-8?B?dTB4UHhXazQ3WVhYeWtWemhiYXJDM2RzaVRwL0c0ZVR4NVZkUGswNXNINnBB?=
 =?utf-8?B?VFNmcndLYldQdThIUGtlZ2l4YWlNWHo3WEhhZ3RNblhkWW9PVlJORWVyMGlS?=
 =?utf-8?B?R3FvVTJ0d2E0Qms2YzEwK1lSVkgxM0Z2bVNxb2J0RFBPenZHekFpdGp4dnRP?=
 =?utf-8?B?anBhQTdWM1RLQUU5cHdJR1grdC9FYzZGOXdGakdVTnhEZ0pmK0NvcUlEVEZv?=
 =?utf-8?B?MFFmLzNwQ1BZc0FkWjlzV1V5WUlxekZPTVFFSW5kUHZjb1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2tTTGNXTVNYb3gxVkVGNFUzUzk3TDgwTGxIU1JBRm9XWmxiT2psdkkrWGZS?=
 =?utf-8?B?OFkxNHJERzhYVU1vNlFkZzBXd2l5UFdxTGQ1aE5PY3ExUEZvZE5KYnliOG1U?=
 =?utf-8?B?S2RUSTJ4eEYzTE9DTHRlcmYvWGNxWnJORUs3RUo3dDEwVThjajdSUG5CWllh?=
 =?utf-8?B?T2tkY3M5emNScU5oaktlbnJWd2VsOWtRbndyTHRKQzBueWxoYVN0OVVXdWZk?=
 =?utf-8?B?K2Z6QXRkbkFhbHZhTmduNFVKZVRxdXhZSUlEUDNib3MzaU1RVklYZENNb1d5?=
 =?utf-8?B?R1NOSkxHMWlyZ21nMUpQN29VNnptaXk3RG5KdEVKUU93ME1oK3lBQlo3ZXNC?=
 =?utf-8?B?ZGN5VWFtakxucy9od0RSL042amFTTFZ1K3M2WG9RWE1yNG1xbkFXcHF6NER3?=
 =?utf-8?B?M1ZaTkdXOGc4cmthNnEvRkpSbitFaVAxdEg1Q1RKWE5yWmlsWGFCbXRUbTlQ?=
 =?utf-8?B?RXIyWVh0Vk9jQyt4a3dGYkx6YWF2aFFncTBHQW1Ja2pXQ3NqczkzM0o4ZTZs?=
 =?utf-8?B?NExqQnlUWm9ZNkV5aWNwa3VONjJmNGJLL242RVF2ZkI4RU5QMU5ZR0ZyMi9m?=
 =?utf-8?B?aW9VVlBEck44ZXRoNE1jVE4yVWdBV1VGakpKbjY0TmFqbkxINkhSYlZWcXZs?=
 =?utf-8?B?UEszR2pvRUZlQ0dVVU9RUlVJYmpySGRyVlMzUUVsUXlKRk1LRXlPNjlwbUl2?=
 =?utf-8?B?c0lUT1QzOGQ2L0txS1B1dkY1THVOYUlpRHZ1N29keHo3cERGWE5kOHVkZ2xr?=
 =?utf-8?B?MUl4RGJ4QWpFK25kcDI4VG10OW0xdDdlZDN5VEdCVTZoUlNmbUphRkp5cDRV?=
 =?utf-8?B?Wko2Sk03aXYvaDV0SUJEY3BMa0d1SlJ5ckZ5c28xOWNzR3FGek4vcnYza2NS?=
 =?utf-8?B?SXhWb2hzRU40eDZDUGFlWG1yQTlLMHFpQ2hsaDdJMnFpNnpzSE00d0tiK29w?=
 =?utf-8?B?bnNhM1dkSmpKMHN6SzdkVEtHWVYxbElxcXBaUFVCanFCSkdYY05ZR2lESVJz?=
 =?utf-8?B?dUZVelRzY0dFd0g5b0dPcXEvTnM2RWxqUldPWUhydzQ5R3hMRXU3VWZUdEdl?=
 =?utf-8?B?R2FYeTV2elYrNDRHRjRBR1l6YmVEMWdldFluejVVUmFKSTltYVRxUG1OeU83?=
 =?utf-8?B?VW9pR2x6RE9CTEhQckFhcmF0cXd0RFBiS3pjdXFrclQ0VitjSUwrVDhqUlBC?=
 =?utf-8?B?M3ErYXBLcVVCQzdDU0MreVpoa0thSFNvUWF0SHBvM2k1eXJXKzhYNW4vYkxK?=
 =?utf-8?B?OHlaM1RZOExuTDdCamRwYkc5aytPVkNBclFkVTZhalFYTmFIUk5vK0F1dkRi?=
 =?utf-8?B?VUZhVm5sRDRWSHJIeUVsRnlPMzhKSVhSZDVmY1g0RmthckwxODdHbjYxOWpo?=
 =?utf-8?B?UFZmVHZQV244dG1BelhqZDRmT3FZS2tDY2EzRjdMT1BCdjViNk9xNXl2REZ0?=
 =?utf-8?B?RWVlTDIxcmJWMmxPcGFuTUZZY0M1RDBtUGd5SXBvL3d6WStOZ1NrM3h4SnFk?=
 =?utf-8?B?RzA0ZjhNTExPZ2hRZ3lpNGg0cmVEY3EyTUdKSEo5SXIrS2IvOHovOWdOQ2xK?=
 =?utf-8?B?SE9tcWtic3h0MW85eWMreFJ3RTJrRHBRR0ZRZ1ZFTStTWnBHTjI0c2dlZmFk?=
 =?utf-8?B?Z0RNa0tSMHN1VHYwZjhUeDNpTllNU2lOUGZ3MzNDL3ozV05halNJUGFxZmFM?=
 =?utf-8?B?NTBCeFpzSXpnRlF2QUs4ZHdWMHN3UjBaN1ZJenh2WHI1VVpJbGJoZldKR1k5?=
 =?utf-8?B?cnhEOWxtcGRsaWFoWUVITU5nYzA4aUNrWkRHZFB1NnhZS1dHMXlMemhNb3NJ?=
 =?utf-8?B?UWZaS09NdXJZb2ZaSGsvblgyaWJyTTh0S0dLUVV1MTVyNlFpaGhkVnRaaXY4?=
 =?utf-8?B?UXJGUmJTMWtGZnZoektwSE9ja090T3JEc09MTGkxaGhWRzcxMUttSEw2WDFx?=
 =?utf-8?B?ME5kNjdLZExJMlJleEZwSENySHN2NkVoVzRGRjk3RVZhUFdzcktoM2JBUHNI?=
 =?utf-8?B?SnZINU9IV1ZmWll4Nmx0cjVVd0JCZlBTa2tXVWlZMitPYmhIQ2NNMWJCTHJ2?=
 =?utf-8?B?c3F6YVZ5VFVpQy9uWDlDWHpVWW9zcU9iaUo4amFCVFVYM3g2V3lROEwvSHpN?=
 =?utf-8?Q?l63wrnwFjuksbjvubyJDOAqp/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40740cd-4d4a-4493-e1d6-08dccb377f03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:10:39.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8evhjGQKVYBNfkOYgPNebJ1GalN9lm17FAYrC3x1UuFTFm+ssOsQsyoHw+SduyB0XG5WaApt2TQ53K5DCFheA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8171

From: Peng Fan <peng.fan@nxp.com>

With 'max-rx-timeout-ms' property added in 'Documentation/devicetree/
indings/firmware/arm,scmi.yaml', set the value for i.MX95.

NXP i.MX95 SCMI Firmware designation does not allow timeout, it will not
recover if the Agents use timeout design. So set a large value (5000ms)
here.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index ecdc6b7b5129..7880d3efbd7e 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -294,6 +294,8 @@ scmi {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			max-rx-timeout-ms = <5000>;
+
 			scmi_devpd: protocol@11 {
 				reg = <0x11>;
 				#power-domain-cells = <1>;

-- 
2.37.1


