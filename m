Return-Path: <linux-kernel+bounces-236512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2DC91E340
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2531C20E93
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DFB16D4C2;
	Mon,  1 Jul 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iF3a81Z0"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFCA16CD04;
	Mon,  1 Jul 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846234; cv=fail; b=JDkzwiJoL/aSEWdJY+d9frdG9QY9e2MuDJbjWx+hRDJbzo4OJMcIpm/XWKZpFVzwIUocJNmo3sywDcCZblqPcENYBMowqXOQ6o1kNODArZQQE+1Ki2TGSe/m5aLTE47DlX+PpvFQN3PYv1tsuTjR2dFKAVvt3MIWaNjAzEnCWpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846234; c=relaxed/simple;
	bh=7/YjXlfvKOECt/5G4KqFAsI9krhxF/Ct+VZv74w8jds=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QplBfv6daoCub8VkGZ5EDNjxxH7Bz3XvQPYYhUBHP6e/tvLq8U/6UOpGzwXIEDUm0Fd9jL6qpGLPaGMmbL/1ixsrT859+eA6j+fyQ5zjZOwtm7nYiuBNfK4f5vXuU5cFRCWegSGnDBAy6uExmhsK53g/n3SNf8u3nEU9avQXL3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iF3a81Z0; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQaCr+BWBcHsJw7ynV1Ir04qcPoiRzFDtwvx3lMzDFWIdCXnvbzTXKiiiizoxPAVkIOos2A/ebXtDGMNyfsnZzyCL8cDwl7Rdn7ItZV1vH0zIf/LKY2oog+XElp6by1z+8Gl0cegnBya4+WISmhf/o5JLgTDmfxQHYsr5h3vSWwJqFM2kfYDhh+w7KxsnG+PoHwpuCl55ku08CxX9L4WSuCD3LTRpFrGlbISUwEsY8yjdFvXWJMivoAB+4JHKm0spc+OQhXkjQovYAAyQJjUVITZbk6BtNmrP6xDT1JIntzIvThjoCvKPm4kOt0U7oijdG1AcD9k8vc0bS+DahmJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9EIEdg1uebR80MWEZ/T2nDjYAtVAFHc9DSu/GnO3PA=;
 b=Gv3rqKl5iUEKLCJku/O4sNaGReQeNIaBtqPb4hXXEIBTK8zdV8/VqveY1xi1ZjvWU6Gn2JP0+psaPQKADUiNuTT/fdUbLY/NXzJ32qXnSqUBKi89WJ6LV9LekzKk8UsmwX6rN1DbwgKwOFr/5mBCAMwqLgFz9OJkhlFmvxIV1arouMoumcKh0h7uQdQrzCLjJhDKvkr7wPErZ0OvwDxAOGAApHvXaWUket+5iESVmp5lXbkofgDDU3gvqbCqhMcul8NrWYG2/ida5c4Tj76ZiMNxwFWmTpqAiEufSYWoViVMvyXJVro9lAQijwQOBdo6+QgnsebHw/d/++gWOdD5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9EIEdg1uebR80MWEZ/T2nDjYAtVAFHc9DSu/GnO3PA=;
 b=iF3a81Z0yY+Q9z4bY2tIRGUZ2F/13EakE1r/65CI6gPK8xemBVJLGav+emy02u6budxElpi1o9hc554MkfMFFcQlbx9hbPBZ9KOC8wpbeHrytrr+kkmnKHcOMACEknadl3+Nz1tKioPcSp2Wx3PCv7i/ledBKVu18wkYkRwRu20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:03:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:03:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/8] arm64: dts: imx8qm: add subsystem lvds and mipi
Date: Mon, 01 Jul 2024 11:03:26 -0400
Message-Id: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD7FgmYC/3XMSw7CIBSF4a00jMVwKS8duQ/jQChYBn0IldQ03
 bu0E2sah+ck3z+haIO3EZ2LCQWbfPRdmwc7FMjU9/Zhsa/yRpRQRgQR2Dejeja4GiJ+RY1PhvO
 Kamc5FSijPljnxzV4veVd+zh04b32Eyzv31QCTDAXXFLQgjnKL+3YH03XoCWU6AYD2WGasVSKg
 QQQTsMvLreY7XCZsbLGlERIZcF88TzPH1YLNt4kAQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719846224; l=4681;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7/YjXlfvKOECt/5G4KqFAsI9krhxF/Ct+VZv74w8jds=;
 b=lhROHnNXnBBVTNLxKc/UnM0tSzDQoSlXMjh1MFuAzbbCv3nszX36YiKKLeGDebbPRa4LzrKRB
 wd6LYcI2pIqA9tNgBkXSU/EH8FvBZzMn8Ti82DcxE9hQIAA125y01kG
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
X-MS-Office365-Filtering-Correlation-Id: 4286af41-1e2d-4e55-ec74-08dc99df026e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b25LRlJRWnJTdmFka2Rkem1uS1RCVThoRDdTMXcyNms2aVZCSDNVeGVXemxY?=
 =?utf-8?B?eXRtc0xwUU5aUDlqK1dzd3k1UmxjYlg0WTRYUjczVVl1UHVtZVdhQVBiVDJU?=
 =?utf-8?B?c1lGd2hXdjJOMEFyM2g4dmwyK1JsRUpPa1BveXQ4eWtZSS9SZm5sbFRURjlY?=
 =?utf-8?B?UGVybjg2ZGVxZGpJODNsU0FYSmxlVE0wYk9IbXBpMkxPcFA2Ui9USnFMWmFo?=
 =?utf-8?B?UzR2dExGUG5QRHlEbWsrdGsvc1RaY1hZajVMbUpVVTBJMXg1TkxXY2c1cU8z?=
 =?utf-8?B?VDgvamdheTU4SjMzeGFNUzF0V3hRRGx6eWtSQ2Z3Q2crdVYzMUYxLzBnUHN0?=
 =?utf-8?B?Y05nMzBEU2VwVGwyRVhPWlRRQ3NHN0g4UDk0VDMwMTB0WC9wRktqczIxVU5o?=
 =?utf-8?B?Wmo3VEJ3enRESGVNU0ErQllBanIvalpPUytjMThqRGptUGdtODZweGtZWG80?=
 =?utf-8?B?NFFvekV0WWxiOVh4VGdjUDJBOGxnamVGRzZmbnZNQmE5b2pTRjFIUFhaQldw?=
 =?utf-8?B?c3QvQ1QwUzg2TG1tRjRJTG9yUlBUVEIzeFpGdUpqZUQzd0xMTXJNdEZWdGRr?=
 =?utf-8?B?QlNvbFk3cTJpZExub0p0TEdlUmRIVmowYnphaHZKMFdDdmIvM1k2bUkyTEJO?=
 =?utf-8?B?Q1Y0Vno5OE8rb3dwMVd0NS90MElNSVVVZks5UGhhVENFcVZVZTBvcmgrdDZW?=
 =?utf-8?B?ME95b2ZaSUJ5SGhoanNMMnYrZ2lhU1F4V1RZRkcyWXk5bnA0YVJMZUFCT2tt?=
 =?utf-8?B?b0c5bklhc09BNFJlclFCbmJkazF2MU5YL2hTTlpiaVZzWkJGVFVOWW9DNTRL?=
 =?utf-8?B?cUszNmJHY1YzUDFXenhFaXJ4YVZIVjdZZ014SnNRbmNFdnRkeVRuSE51dFBT?=
 =?utf-8?B?LzV2VktVbTZ6UTVMNVppNkQ5OE93d3d0OCtWdzVVUUozOGtlVXp5VkM4aXNG?=
 =?utf-8?B?anZaZnF3VTVGdFFPT0EwUGd4SncvVktOT3Z6aXViOEVyM2x6UHB4aDFuMDRP?=
 =?utf-8?B?b0k2a3ZlTXUvWVVYUU1sK3hGcGxiR3hzbEUzeUhydDZrYmpGV0FibnpQWko4?=
 =?utf-8?B?SzB6a1FNZU9OMXAveXBsREptZytpSDV3TDNLcVhjM0krZytRZy9ZZmZwOXpa?=
 =?utf-8?B?RytsUFNodStvbTZ4c1IzY2tUbmZVMHFwWDlqbVNibHpxSVpuNEo3NXFUSlBi?=
 =?utf-8?B?ZVh2cUk1NmZKdWpZWHdxWGZSUEcrQktCRTlXL2E3U3hPM3RQZlRBZ1FGdkk5?=
 =?utf-8?B?dDkvNmlMNTdvVnp0L2M5aEduWWE1Nk9CdUNwT1FPWmpuZ0N4TDk0ckQ0OUVE?=
 =?utf-8?B?RzBpdEJ3ZDROMURqRWJmZW5aMitjeDJkc3pPYiswaXVHWnZjTnExZFNJSWdC?=
 =?utf-8?B?TDFtcnpmVlNFSGE0MjRPSEF1YTYwYnNGczQ3TVR0Z3cwVzkvL3Rya082d21J?=
 =?utf-8?B?WVoxU2RLWVYwcHJ6ZUZNc2VoYkRJZys2OTFMUmhwOGdFbXFuQTFFaGpFdTBX?=
 =?utf-8?B?dWltWHpaTUdldGMxQk9YVkgrcW1wOC9ONGxWNFMyQ2ErQVhvNEQ5c3RNUzI2?=
 =?utf-8?B?SWIzN3R3NUx4MERxN0ZIQWVCVFoveXpJNGJ5U0RPOG8yYW9Ndm5IZ0dBak4z?=
 =?utf-8?B?dngzMHQ1ajEvc3U2Tlg3M0V5Y2VtUjZtbWJ4THZDNkprMGhzZ0tIb0JCMnl3?=
 =?utf-8?B?aFF6ZHlFeEsyYVk5WmxmbnlPak11eUIvNklVeGlqUU5qZ3hEWnJNNTlsK095?=
 =?utf-8?B?L2hwVWIyRExFNTVES05FZ2pZbHNrUWRwdmo0VWkyc3hSWkxhKzFoNHoxQnFX?=
 =?utf-8?Q?kd0/WvnjlTXikiIoBtWCYpt1i9l39bS6o6OOI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmRHRWlmNzZBNmNrV1FCVGRmREpQSlk4aTdDRFhhM1pUNVZzOWlvQSszaTBT?=
 =?utf-8?B?VjhUNTA5djl6SEo5WEl3bWFOV0sxd2tDVWhRTmtzMGJYNUpCQURLdmdmcXhJ?=
 =?utf-8?B?UWc3a0M4NVViMEg0c1RkSUNQTUtLc0JqdDJSaVQrWWNJcFZCckdUdlk5elhv?=
 =?utf-8?B?ZGdObEdiK0p3YlUxTmQrdGhEa0FXcU9iOGN4OXc1SWRaTDhlOE1mWjZybW9M?=
 =?utf-8?B?dENMWEdkTnlvM1A0Q0t6ZGhCQkdrNkZuTjJwUmp4WE5USFlXTncvLzZKTjBy?=
 =?utf-8?B?R0RPT0tjbHQwWWNpZkQ3Sm9LcUhoV0xlL2VtSFBJT2NCRlk3NlFxdG1zUTRI?=
 =?utf-8?B?amJVWWQ5U0QrckJTUnNsazF6M1NzdzYxSWx6OUJsVFdUU3p5RWVrWC9jNHp0?=
 =?utf-8?B?eXp2alAzbkNpK2NVdytnUTI1L2I0VG9FUTlCQ1BpNWRacXdNeUdyMFBJRTEw?=
 =?utf-8?B?TU1JeTlIN0VGakhMZ1hCMVlhN1R5eHova05IK2lqQVZLR3NXTDZQZktRd2Z4?=
 =?utf-8?B?OTBqUytMMWc3VDVvLzc3cXByMWZVUG5kajR0Ui9hZ1RLdXRCYlNmYXpqMjhq?=
 =?utf-8?B?NmdzUFRZVkV4VGNBb0lqVmZIYThQYUdlVG9LMXMxYjVMS2tMdXowUHpGVVRU?=
 =?utf-8?B?ODByTFc5NW5rK2lFOCtUKy9HSzhvUFVMdmF4TUZTSFFYZXdEdUU0bWhDbno2?=
 =?utf-8?B?YnFDQ0FPLzEzTVVWT0ZyOEMzWmJEdndOQWJRamJhRjU1OSthUGZKQWphR2gy?=
 =?utf-8?B?WE1tVDlqa0h6dHFpUGVaRkFUKytWWDlJT3VtWi9FdGZMZVl4Y2Noek1CWHd0?=
 =?utf-8?B?MzhMQW1od2RUdnhZTVNGdmQ0eXdpYnlaTFhZY291cHJOdlVGekYrOW9RbWRT?=
 =?utf-8?B?d3ZkTDNvaWZTdnpYeFozTk4rZWZmNmdpSnQ0cmxjWjFNRTdjSGdxdUlHbEJO?=
 =?utf-8?B?WWszQzd4TEJHbDhMazgrbWdWZDIwQUIxUElSTCsza1lGSlovYWdlSG1BbzlZ?=
 =?utf-8?B?bWwyVGJYNnZKekJ2RmtMWGxiNjl6cUQ1YklWSTZmaUtqVHduUmZZQ2YrU0dj?=
 =?utf-8?B?UVhDdU52dDRFUlZRajBTSDdwZnBBenZSdUg4M0lGSFlvdEdlQ1hranFheFp1?=
 =?utf-8?B?TG9mbFAyWlhzckFwcXhVN0V2aEtlOHpKUnVXQnNXUnJEaGlZZzZ1RlRxTzdt?=
 =?utf-8?B?TDNxeFkreU1pemI4UFJpRURtdUVSZW9sR0RNUmpGeTUvbUV5ZEZoNUVLYVFk?=
 =?utf-8?B?QTgvMWJMZTZudW5PRThkQWVjdmV1U1VpNkxzQXZHamJCaVhpNzg4WGUrb0pO?=
 =?utf-8?B?dG9hRjkrem5GZVd0WFhNdlZvdEUydDZpbFNrZzZjY2ZaRlRlU2xFaVIzQWZ0?=
 =?utf-8?B?RmVFSnk2bm0rdjF5OHJGR3JMWFV1RHIyVGRjTVVqVHRkcWVvMnJjYm5hQnRR?=
 =?utf-8?B?dzVmbDB4UmRhT2pZRkM3ZFNUZGk5cEF5bVJpendNdllQOWxNbk84VGVtZ1NP?=
 =?utf-8?B?SG5zZUk1dlJKZFk5dWdJTXdtNzFtV2VhdFRVY0VDZVo1Ni8wTCtRQU04U1FE?=
 =?utf-8?B?cUgybXl2MVFIamI2RnNpWDFBM1JsYnNxb3QySWJlb1R4aVUzVXExbkZVS1Vm?=
 =?utf-8?B?S3ZqdDRvZXpVTnlnbmRQU24rSzEycCt3Rk5sdEZVUWtaVGNUaUdMajc0TSsr?=
 =?utf-8?B?T3lzdnNVMDU2V0VoTXdOdGJGS2lrZ3JhQS94V2lDVUlacXNQcjF1TUtrdVZP?=
 =?utf-8?B?ckJWT2Z4cGh2eVR6SkVkYVhPOVVmQVVVaEtqTWlXTjYxNndsNHgxcXR2emRn?=
 =?utf-8?B?bm5oT2ZuYXRlSDl1ZWFiRTZCRXhvdExGSTlPM0dEZlMvWi8rTHVTcWdHTjZY?=
 =?utf-8?B?YVpHazRUM2oxY0tyUlNEU01pclZWVTZWRFJTMTIrMzVoRUdsRG5PSThHRTY0?=
 =?utf-8?B?TDZsc1liODYvaW1IYUpQVm5RRzVLYzUyUjg5dTYzcldKa0g1K1hnVHpXQTdK?=
 =?utf-8?B?ZDhZYkIra1FaUmtiUXRiQ0FXWUhjQmRjUGFYQXFvY2RRNG9YMlVHK3phYXVM?=
 =?utf-8?B?aDNIZCt1SFdVT0lCbFBVeU1OSC9zaDZaaWlLOXZCK3BVUjR3Z0oxVGo0QVVB?=
 =?utf-8?Q?Euow=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4286af41-1e2d-4e55-ec74-08dc99df026e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:03:47.8210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTX6GhdwYswXkrN+HrXoKXGUmtNNenAGETss0YTxx5Oe7nX/IXW4bW2uvbHfhqAInn/47EPp7DtR3ecSouLuXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166

Add subsystem lvds and mipi. Add pwm and i2c in lvds and mipi.
imx8qm-mek:
- add remove-proc
- fixed gpio number error for vmmc
- add usb3 and typec
- add pwm and i2c in lvds and mipi

DTB_CHECK warning fixed by seperate patches.
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: usb@5b110000: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/fsl,imx8qm-cdns3.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/cdns,usb3.yaml#

** binding fix patch:  https://lore.kernel.org/imx/20240606161509.3201080-1-Frank.Li@nxp.com/T/#u

arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: interrupt-controller@56240000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#

** binding fix patch: https://lore.kernel.org/imx/20240528071141.92003-1-alexander.stein@ew.tq-group.com/T/#me3425d580ba9a086866c3053ef854810ac7a0ef6

arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: pwm@56244000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/pwm/imx-pwm.yaml#

** binding fix patch: https://lore.kernel.org/imx/dc9accba-78af-45ec-a516-b89f2d4f4b03@kernel.org/T/#t 

	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: imx8qm-cm4-0: power-domains: [[15, 278], [15, 297]] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/fsl,imx-rproc.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: imx8qm-cm4-1: power-domains: [[15, 298], [15, 317]] is too short

** binding fix patch: https://lore.kernel.org/imx/20240606150030.3067015-1-Frank.Li@nxp.com/T/#u

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Fix kernel test robot warning. 
If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406290945.3KbIuqTZ-lkp@intel.com/
dtcheck warnings: (new ones prefixed by >>)>> arch/arm64/boot/dts/freescale/imx8qm-mek.dts:64.22-68.5: Warning (unit_address_vs_reg): /reserved-memory/memory: node has a reg or ranges property, but no unit name
- order node by address in reserved-memory.
- Link to v3: https://lore.kernel.org/r/20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com

Changes in
- Add imx8qm-ss-mipi.dtsi to overwrite mipi lpcg clock setting
- Fixed order in imx8-ss-mipi0.dtsi
- lpcg arg0 have to use clock indices, insteand of index, so keep current change
- lvds1 and mipi1 keep current file name to algin exist naming conversion
- Link to v2: https://lore.kernel.org/r/20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com

Changes in v2:
    Changes in v2:
    - split common lvds and mipi part to seperate dtsi file.
    - num-interpolated-steps = <100>
    - irq-steer add "fsl,imx8qm-irqsteer"
    - using mux-controller
    - move address-cells common dtsi
- Link to v1: https://lore.kernel.org/r/20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com

---
Frank Li (8):
      arm64: dts: imx8: add basic lvds0 and lvds1 subsystem
      arm64: dts: imx8qm: add lvds subsystem
      arm64: dts: imx8: add basic mipi subsystem
      arm64: dts: imx8qm: add mipi subsystem
      arm64: dts: imx8qm-mek: add cm4 remote-proc and related memory region
      arm64: dts: imx8qm-mek: add pwm and i2c in lvds subsystem
      arm64: dts: imx8qm-mek: add i2c in mipi[0,1] subsystem
      arm64: dts: imx8qm-mek: add usb 3.0 and related type C nodes

 arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi  |  63 +++++
 arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi  | 114 +++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi  | 130 ++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi  | 138 +++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts      | 278 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi |  77 ++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi |  19 ++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         |  27 +++
 8 files changed, 846 insertions(+)
---
base-commit: 9db27bc55bd8363570c5a259ff4dc77bd6a0b2cd
change-id: 20240606-imx8qm-dts-usb-9c55d2bfe526

Best regards,
---
Frank Li <Frank.Li@nxp.com>


