Return-Path: <linux-kernel+bounces-311035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3896842D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0C628149A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E2113D51C;
	Mon,  2 Sep 2024 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OoalH+K/"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76C13C9DE;
	Mon,  2 Sep 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271844; cv=fail; b=l6FDMOxtLk+8qlAFDOxs7AEEv9lFdiyg+gnsFBb7IFXCa62X3GVQZzbKn8bFiUXKg2uvcotb5/gToDb7X3FlscNNqmM4yurmJMv0EZ8M5XSN3VX6+42z5fOrgUowAVD+H/XvZJURQAu6/PFqVoeKyN97e9JdosX7cChHp44CXRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271844; c=relaxed/simple;
	bh=6GDbBg1QwNUcbjBto9nRfvGrnk0Qj+id7l2pxFXk5Nw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=EQtzUEP3FTfecmo303poTwhbqHE3NFN5euBcAQrSNVKFyX/k3qH8347oofnP3iztGbhKeVle11XNQCRP8n1Guvt550MulPioFuZAFgPOdBUSS+IUBxkBT6GapTmhC6Sute+QvA2qHAY4zQMyWDY1O5u+35RLZr8s1R5APUTNazs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OoalH+K/; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRPJXHPa39YyXoi4FR2TUNYCDCtP9xggNp5BzrqDkwfOvv/RaFTngfGkrgUsIUpreQuArW9uC96LxidOlLkAbAcECsCiRaMi+LZ6mwKB+gna+VY48cs0pyQg4yoENVLXyPCRbgJsSjGGtDq5sFvV2qwsZDO91O4zWSlmnwLUfbuQ/1gqruoYjiXzUtko01L0fHOCOtatJkQIs7XLrinqkTuSomdAekmYmjBbtAShY1hiIty0ptv0XRGS+j09nQAle3d8u1upldKzxCHmboRWk/0MsNHvIPVA5Ig7ycHILjtOM7fBeNs+tXBfMpt61pA5MFYC9T/K6wyuWPJ4B4ufsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Arg3WDs8lhNnZkB/oBElsdVAbkOGyMFnIAcmv0ZDJF8=;
 b=C8U7ouYF++M0CZTEUZzzDJLN6mcbS3aaaTGNPhh0rz19GX2Rm1oMSm29kugpB3zd4U5bxEekZlnCGcPWwseQ1bs9d7TS+OkWhXb1zqNJrs+0wX1oQO34FPqG5WGen9L2KqMcxiaFLdKwm+cUs3Eh/XUTXImJlnLnJejMmXEmbNR5xpRhSlEqlz0EXso0aGWRnfyusvA3ZGJQIJlSaC6Gtkou2pB5jzDIfXqGmq+I33WtUut8dTzdU4KRTJDOiZ/Cgs7OcshPzTVwdGj+IeVSvpYb2f0I2e8t4dnCngWZBnHt7KGs/UCefAiCmADeO6j/4Nj8kz3GPQ6Lzl1ECI9uMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Arg3WDs8lhNnZkB/oBElsdVAbkOGyMFnIAcmv0ZDJF8=;
 b=OoalH+K/iMLL/OiXsm41/G5WLZLfCR4dEr3R3VM/D49aEC2AUbuDwItRIW/I5NacUvHLOJoP33t3BlRzMNxv/sE/64DxuXPBhOcPG1S8WHDVunrb/w6APNjeUzNZwZL6mbm9IunrRr0RLFdk7yFLwbYc8d3Wxs2iDPUQi/7UbxUzK2BvXVeOhVNoDB+eg2iIXuRhaj/fawyfaVrxbyzdlbCQKkr8sCL5tB0wL48W9iGnR2kr3rGTwEkZ3ixLEZUmNb15f80mU7DObJ2pGokhbRfA4ZHl5uCmV1Vl/NgdP7oeqcPj29ZsK3n9J/+0cYrw0ggdCryqBnZJt2/dgfmIrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8171.eurprd04.prod.outlook.com (2603:10a6:10:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:10:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:10:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/7] arm64: dts: freescale: imx95: add various nodes
Date: Mon, 02 Sep 2024 18:19:22 +0800
Message-Id: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqR1WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwMj3czcCktT3ZSSYt281HLdtKQki8Rky7TkREMLJaCegqLUtMwKsHn
 RsbW1ANSLSsJfAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725272373; l=1120;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6GDbBg1QwNUcbjBto9nRfvGrnk0Qj+id7l2pxFXk5Nw=;
 b=H3P1ueOaaq18zw3VpAFEH5RhlpD4V10TWmX8AOiOoRN4shgKDcHm45vJT1WW9TwlmT4xoJpOZ
 hgrHUf7VYV/AuHo/2lhdeEKhntAuHt1VVmUhLt0d5CKicez7UIB9lNb
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
X-MS-Office365-Filtering-Correlation-Id: d4b100ba-e8f4-4e4e-dd37-08dccb377ca7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUY4U0dlaUxQeFI0ZDVtKzJ4UWNodmZWczVhQithQ0xCOEpnQjk1NHZ0VnZW?=
 =?utf-8?B?NVNvYXVndktSek9QYjNHdkhMcE8xTTlLUkpoUFRVd0Y4TGVibW1yL1hXSTJL?=
 =?utf-8?B?UktKblFRYzVKaUZoL3lEOTFpL1p0QzNmRXhKYW0yTTBUYmZkSnk3bm5nRXJU?=
 =?utf-8?B?ejMwbE4wT280TjBhcS9sVUo5bkhPZC9xUmNUU0ZmNStaTXkxbXg2UEVDN2V6?=
 =?utf-8?B?cmJkN1N3d29pZTQwWTlqMnpQRFMvdWZzYXQ2b0k4djRDNExHSklkaXl3SE56?=
 =?utf-8?B?QmVJdzEzS0Vvb1REcTMyWmxtTkdIK1c0TTFWMyt2Q3o4WnRYVEgzcXFxSkda?=
 =?utf-8?B?bnRYb1pCK0Nqalc1Tnk2KzM4MEFQS2FjeFRkcHBZWlYxS2tWT0tSK21yVWNo?=
 =?utf-8?B?OFhIZGVFbWlnV0lYVmtOV3hOSWpBcHUxYk54WERKc2lBSzQxUWJvVEthaHo2?=
 =?utf-8?B?SUhicWN4dmwweWlzSysxdnJ4VTNoQmJic2Q1NmlGeElOSG5PVXM0VjlTTEsy?=
 =?utf-8?B?czUrVGR1ZzRhTTNVeURlQ1kraUFrcjhGRHNWSmtxQit5bWd1YkVVc2FlcHlU?=
 =?utf-8?B?cE0vb2ZaM0Q5dksreU5URFdZZjE3amtuRkRWdTFRRkRzZUJQK1gvMHdrVExh?=
 =?utf-8?B?azc1d05nUFJnTGJ6bFZpZW5yYTdpNmo1VjlSZVNSTHIwSEdsNUkxNnNzdEpB?=
 =?utf-8?B?b3pZcnpqdDNqSEpsdFNMQUZQdlc3c0N5T0dqVDJVWFlPRExCb0xxTnBnZEhU?=
 =?utf-8?B?TFpKbWZxeXAvYUZlVXo1MGdDYktYaWs1VU13cEtzY0p2Q3Jmbk5EWThJS00r?=
 =?utf-8?B?WkZhUVNiS25raXVhZ0Y0djQ5b2ZPTFRIUWJRV1lMSndiaXNSUmlRak1FRzda?=
 =?utf-8?B?UjdWaG1qM0tUdjlVSC9aYkRoUERIOGpMWFB5ZHFyL3ZwNEhZSklHa0xKVk1n?=
 =?utf-8?B?VjN2bkNNaTk0WHJqRFpRTlNZcWQweXdYM3BRM1ZjblBBUm1VdkpSeVY0Ulkz?=
 =?utf-8?B?VkZPczdtc0F6TVFMSSt4M2UrOEFhQys1ZHB4TFY4dzVkQVh1UXVlMTdwc3VY?=
 =?utf-8?B?aXlXaTEzZHUzbURaRFVLVnA4eDBrb3dHMGtkcUp4ZWZHck1QRnhMUEtobFVM?=
 =?utf-8?B?NUd3K3hKb2UrZkpXVHBibmtxS1RqVW9Ccko0ZENRaDE4RlV5V2VPMVhyQUtq?=
 =?utf-8?B?ZUt5OHg3WmlpbTFKMXlMWGJpRHJXWEh1ajFLSlhiR1AyaWFsb2EwQXRxZ3lL?=
 =?utf-8?B?aktta0RGb1ZIZ3h0YlNnWGh3eDg0Y3FIa1o0SERsdGFqaHNYVDVxdFJ3eG11?=
 =?utf-8?B?amJxR3JSY3lYUDBaa3BTdUY4eFhNZjUyVWNydWk0NktKQmlyYkNRNng4eEIv?=
 =?utf-8?B?YUlpWGxVWU1pYXJ6TGhlSnJBVXBtaUs1TE8xU2IrUXZkdE9vTEpzOXFVU1Na?=
 =?utf-8?B?azVsNGc3YkJ0TStBdmR1bzV6OFE1YXBROThLbTJmRmdBMlIrL3Z5Q1FTbXk0?=
 =?utf-8?B?SEl0ck5QOG1vL1k1MU8wcDd4ZkRoRUdtSit2aEpMOWpSTkZ2a1UxTm1vS1pX?=
 =?utf-8?B?TnNBYjhPS0VSeDBSVjd5Wm5OcGErSEJoNllFZGlKQk1PZU8zWitpTzdVTWJx?=
 =?utf-8?B?enNEVkZ0UmFmSXNPSVRONmFmeTFLTlRDa2tkWllQdFFGZWFPeFJ2azNiV0Vx?=
 =?utf-8?B?SDhJRGhnTWJJUTFLMUMrRTRyakR0TzhuN29KMXRDb3hzRlJjNlB5aEwzYVVD?=
 =?utf-8?B?RWk5Qll6NitJOE9YRlJPaGs5UTJCMWRrQUFwSW1OMFlKQ0QrbFZGbTJHNjlN?=
 =?utf-8?B?MGNKU3p2K2Y3TjBlekhwYzJwdXFyNXZOcTBmN1FGN2V2RXlybjJ3Mm11b1RH?=
 =?utf-8?B?c0V1UEZCYkFyZ1ZSNG1Mc3VzNkxtZXpLbERaQnR6UEF3cXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clhZY0MvTy9zQU4yZExidm9GMVBlVlprUkFmYnBTb3dQdndVeUVGa3MzeXNm?=
 =?utf-8?B?bDNvTEdtTEkzaHBNdHlQZWZLYnQvaEtTcXpGWUpUTHlBcS9vT3hUTUhxZlVr?=
 =?utf-8?B?Z2QxZkIzL1hRdHR1K3dOZWF3U3hJUVNKMGE2OUFwanZQbThhc21CRE53OHBN?=
 =?utf-8?B?bUFCVkJKMFJDdEhZcXBCcFBWQXpUTEhnejhxSHZFdlI0Tnk2eUVLWnQwbUZv?=
 =?utf-8?B?aklybTdVUS96MUM3Qkx2cjU3eHduZnlVQzZjaDdKSzVkdzZkbThtS0lDQUpI?=
 =?utf-8?B?dGFwbDJvQzI5RG1TYXUyMlFKYkJzS0tWSWxnU3BnM01EbVZKSlkxaWw0UzVW?=
 =?utf-8?B?ZzBDRDAvaFM5L2YxVEV6cFVibWdteXl1Y1Bvb1FmVC9MTExRZFRkZlBIY2t6?=
 =?utf-8?B?aHRnK1o2VlJiKzNQMWhPU01jSUdaWVJYcDFGZkdIdkZvV0pyU1NPUk9KTURI?=
 =?utf-8?B?WUhTNmtVSm5iWE16UWF2Qnl0aU42WkFJeWc1cGk0U2MwV2h1MG04ZnZxUDY0?=
 =?utf-8?B?cTN3ZUlicTdVbUYvblhkRjhGUzc5cGJxTkdOT3VrNUcxL1JxOWo0eEZDWHVk?=
 =?utf-8?B?Q0pydk5ILzM1ekJzSHVPNURTQ2xGcUJnMDl3cWVlZEdzYzhOVUZTaGxqcDNv?=
 =?utf-8?B?Zjk2S3dVcFNOZHRaU1ZNdmVuWlFYdDhTNHpCR3ZJVFJDSWJzVEVFTUNVUGFy?=
 =?utf-8?B?bzBadGNXRVRCSlRKWVQwOGNQdHQwbVlrbHJudm9KMFJtM0xMdlBFemx2OW5y?=
 =?utf-8?B?bllMUVg3T0VCSlRSVjFvTUU0blovTmtNbU9abFZSdFdxQ0F0aHdTY0VmY3k5?=
 =?utf-8?B?dk9QaWVucnh4YmVlMW9IcWdsZVMwSTc2blhqS25vUzRHZG9peEJaNUcrQXBU?=
 =?utf-8?B?Ky9KZ2JDOEo5Zm1ZR2JRRXBqSEF1aG5HUkpHdEIvcUZkQmg3d3Qrd2trcHM1?=
 =?utf-8?B?S053WlJqeXhpL3Jmc1hhbHN1eHZjRzFPOUdoUUxneS9nRW1TMlZsNFAwaW1I?=
 =?utf-8?B?RlVCZzhWMWIxQWpYU0VScnMwWExHL3QzZFE0Ky9YRitGNEJ6RHZMN2VNRWZP?=
 =?utf-8?B?QTFYUGtTZU56dnpsSEx4Y1g0bXg4dWptT0RnakNzZ0JLbWl1YUpNUld5WVVD?=
 =?utf-8?B?MFVtYmFYV3VVRHVMcXlDU1FidFpGNHZuQTJ0WlA0aWgrUm9HWXY1TjR4Ukxk?=
 =?utf-8?B?SEprSUVOTy9NVG05cGdabXVQVnRaZ1pJT20ya0JJSUFIOU95YW54SjFFZFVC?=
 =?utf-8?B?SUV0S3ZLaStrZ2pOYktyMjQ5TzFSU1hGUVJsWjl2VURRcWx6VHBwNXNjZjgy?=
 =?utf-8?B?QTJvQUovS0ZLS01PL2s1WGdVcnFRTHJGcHBRKzVvOXF4L2FBMlAzckY2Rkpl?=
 =?utf-8?B?Mk9SOGpiN3ljRG4vdmpQUXg4ZkRDSGtHOWlNRDk4bnN5OHYrekoxL2lva1Aw?=
 =?utf-8?B?NXpOZEMzNlRhUnU0a0IzYUpIUk4rY2hPc1E4RkxhVktqWStGM2lRelFQQTJz?=
 =?utf-8?B?dk9mdmtBYkQ3Qk9kcUlYRW13YUdxeklFZHdlbW1xNFY5dERLSURLN245RGlp?=
 =?utf-8?B?UG92cms4U2tGeUFITDFwYkplRDk5ZDJ5ekFuc2NBZmYxR0pQQUNoVXQyM3F3?=
 =?utf-8?B?b2xsd3ZCWlZyNlBZMndhczREcDdnaktSTEg3MXpHalhkaFJsSyt3WHNSSUR5?=
 =?utf-8?B?T3VzbytmU1lXb29NM2pzWlFUL24wU3RGVHRNY29yanRRR0FXc0RGdWxZcnZ6?=
 =?utf-8?B?TDZvcXk2bDdrQkNEK0xQRlVoY3FHR2dpOTBBQmhWRlRLODMxK1RjQUxldDJX?=
 =?utf-8?B?SVNDWk5VaDkreTZFeU4yZXhOSXFiNXJPbFNualFCWEZOYU5IdWZkcVE0Mk9v?=
 =?utf-8?B?RHR5SUNHbUs1cU9hREZPY2JEZlhNdDluSjJaZmN6czByVGltVE5QUFdTejRP?=
 =?utf-8?B?MGVFNXJGZXRHUnhnSnFIYzdvMVNmbDMrZlh1dkRHbmVWY2E5SjhraVFJakZu?=
 =?utf-8?B?eWx1UmNrNU9XZkR5aUtMQzZ3OW1tMlFzRFVZQnRVS01PM0xwVnRnNktpRVk5?=
 =?utf-8?B?aEJibmVnSlJJMHdKcnpNM1d5RFFKZGJHYXNNbHY1dlpxMVp0bkJuOWNaWWVi?=
 =?utf-8?Q?gRxguReCeqpNkn6Dg+QXOPVkH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b100ba-e8f4-4e4e-dd37-08dccb377ca7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:10:35.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kwa5nBXz1sTmiIBWeqVhalruBJGK2sQBW+YES3h6zKDAMJgN3KKxMpocs+516SZ7/D1d5vn+Sx5pjqy92Fa/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8171

Per scmi binding doc update and i.MX extenstion supported, add the nodes
in imx95.dtsi.
Enable cpuidle for A55
Add anamix temperature thermal zone
Add lpi2c[5,6] i2c nodes and sub-nodes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (7):
      arm64: dts: freescale: imx95: set max-rx-timeout-ms
      arm64: dts: freescale: imx95: add bbm/misc/syspower scmi nodes
      arm64: dts: freescale: imx95: update a55 thermal trip points
      arm64: dts: freescale: imx95: add anamix temperature thermal zone and cooling node
      arm64: dts: freescale: imx95: enable A55 cpuidle
      arm64: dts: freescale: imx95-19x19-evk: add nxp,ctrl-ids property
      arm64: dts: freescale: imx95-19x19-evk: add lpi2c[5,6] and sub-nodes

 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 86 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 69 +++++++++++++++++-
 2 files changed, 153 insertions(+), 2 deletions(-)
---
base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
change-id: 20240902-imx95-dts-new-fbb8ac9fca18

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


