Return-Path: <linux-kernel+bounces-540911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFBA4B659
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D083B0134
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5DF1E377F;
	Mon,  3 Mar 2025 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nf1USgFS"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A41DE8B3;
	Mon,  3 Mar 2025 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970505; cv=fail; b=aSJpbu9A8Hddrk0szQ8w+Q8HpxFEAUvKXsYIoX+iYUZyNykKYaMHmobEP5Rq4G8VFvw0ke52e5nXVpmnATV/btGY6ONjsfKLfTgFr0g0Xmivc1BBpS+sbaSTCOlrjs7yq2Hj36kFtqb203i4b3S+nk82j+hOBAEvNO5CC/xadXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970505; c=relaxed/simple;
	bh=6+6ZBTN4qmCvwd8Wc/oKQmV2SOEwC3R5KZFua5O3O2U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PB5HykuXsyJg9DEy+UjZw+hxMzws0FLbKdIFstmYs9huC7vcvpA64ZCRYdD/RfPQEfPcfJBIIuWLGePydAo+GbijmjoIW0hPDewMSUfTa/+gmljcQObDCbFubCaxe52fLGe10E5kKbmXcijXC1teCjJ10KOxUa2bhZoK0ysE5+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nf1USgFS; arc=fail smtp.client-ip=40.107.103.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0Lqq5LnjKvlsqWJZfCa/Nsn7Lqb0WUbttjEXlTOUl4oosOxXE2YoZsTM51V+gSMocaJz1lSQJ7HrQLkmIQa+H9KCZlcil3y70qTJXqYdGY1ZKjWLXYx5Q3q7xXEHH/ZeBGkrNYOHEhNT4mde4H99ADcrcymYlWZZD3bdUynn0IBw+NJA3uQOuBR6u45EIGwghlJ8Wmz+cmaFKc2TcWNtYwCvaoVMCk8kg44NyClvQrKhcYBsK8f+26pildT0baPJyAf20c4uNnv6LOtrOJPemSA21HnHqXl3pnU1JE8upQgAdEnmrThyWC+vlFpFS78yNXb88d1DL8r/EcXCChaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0URnfs1xyb+W4SHbq+XsmGBAVc4y4jZhI2YCpnW1Ps=;
 b=t3izbnL779biHOua+4vw26XEvhjH9hg6Ga8YQBn1PbOXMVv0+Yb5JWxUX2LvhNLI7dI/WuVHqz0PKJOl4+tvrB9EOTfwSM6ns4TyWtJBVLWsGqccai4hxISD5meNrO9J4h5D0Hmm/I545rQ9zBeS4DSvz7uXrMTpzGUSmCNdqjch1lCnAN1tNi48hkJK+K0+qIQ5WA7MjoYhxYEiak7NUnYL1Vvd8UfAGJDsLTPiLw4xmi/rrDa3y5BouJtsDO7SUhuBzV7MSyqcbBtiyELJKsz0cFVQZ4hMJk29vVyP8tHSZ+AeSxlX8TNq/EehfvINgPUYRoPK9Mfqjg/prnVo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0URnfs1xyb+W4SHbq+XsmGBAVc4y4jZhI2YCpnW1Ps=;
 b=nf1USgFS6RRnPQFtVsTQlycZNH75EJ5r+aJVdluLQ7XNpoZRsDsf42lQ1zZFSs7G2FIupsSJ0fBLsGiKc+VcOTB7gERqpz10ZiwRr4dWUmOXOizGZvlKOUiUtw3N4SQp/Ewpgu3DmHh/Bt/hj0AcV4TB6868KuSPlSj2pcLdBmP658oF8OprHC59jwRpKhYjbWMxUtozj9IGIZ+IWRsm7m+WwMmMJxwxyx6SjHuCmvpPrWxwuLz+EHxK68gff+WfkSLcFPTgz/17iwDOa/XDTk83pFayniEddSYNF/wV7E5Bp0pEpIjeG3f2bLEwAZLUnHr3tu1iwtdqO22+pFx4iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:54:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:54:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 03 Mar 2025 10:53:25 +0800
Subject: [PATCH v3 4/7] firmware: arm_scmi: imx: Add i.MX95 CPU Protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-imx-lmm-cpu-v3-4-7695f6f61cfc@nxp.com>
References: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
In-Reply-To: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740970413; l=10156;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=TG6cyB/8wHRcrxt99BRqhHciWmEXUxMEAzTx8rHy51Q=;
 b=d8wVvJs/0StNyFKNZaWQfD6fjdDf54X4tlI6oKDOv7HKZvWvV6Dc4uc7H97M0splaHDrDJq9W
 v37XyQt0pEODFjCNPeRLtL85U3hhDvhkY8bvsqdcqEq67+H+JoryJUD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: c7183e8a-0155-4f70-36ae-08dd59febfae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWx4SW9vaEd0NTFOWXA0QnhHam1qMEdIWWhNeFN0eVR1cnB4ZnNjRzZFTG9X?=
 =?utf-8?B?cG5ybS9kRllUTnlqRjZvZzVRbTY0d0FOL29Xdzl3c2NMUEs0anZhOEZnbXMv?=
 =?utf-8?B?K0ZqaXMweTVWYjdpa0RCcVR1K1ZLMUFtOXBjYkxlV0x4MGx2aGJkRUVQYWlE?=
 =?utf-8?B?RmRaSzU1VUZtditSRFFEdGZRdW1Ucnd5UzlpZnh0SkVvZ1Irb0RQSlhkM3pY?=
 =?utf-8?B?SEN2bFh4UHV3cVhPUFpuUHA3U0NEeCtXTXFjZEVjYWlxbzhHQWovYWs0c1d1?=
 =?utf-8?B?TEdERTlCL2Z6d1d1V3dpS2wwbmVvQURxUi96V2k4Tkp4RU1pQnVlTmxlK2Ju?=
 =?utf-8?B?NDcxM2p0aVp2T0R2eU1vakMwbHh2b2ZuRFRZMmpzWkpFaUtGekZsdmJZWkNL?=
 =?utf-8?B?LzhKbFpRNU1xVnNwRnhieG45TlRYc1hlYnlQUGVnN0dObkwyZ1YrbUcvQW9N?=
 =?utf-8?B?TEIzV3RIVDFFVURCbmR4TnM0UTB5WXhPaFFmcmhmNHdGck5GekxzNzFybGI1?=
 =?utf-8?B?anpTTGROK2QvcXBOS3pyWnladUJzWUIrKzZObERXZHhhMGJmcWJ2ajBJZkNR?=
 =?utf-8?B?VXNsdGhJOFNJS3NkVFdoaXRPVHdRUDJBNFhLVjkzU0ZFRVI0Q3ZlMC9ZQnRl?=
 =?utf-8?B?bUlieUo0eTBYQUdhZW9HeGdvK2RjTFdMUUN1eXVad0F1UjQzTjZjeWU4cjBO?=
 =?utf-8?B?Zi9CUWZIa0NSQWEwZFMvYkZwQkU2SVhDWEZYQVVJZTl6alk5QnNMeWZtVmZ0?=
 =?utf-8?B?NHliZHJRMExXR2pqckF0VUxMVGpIa1JSVDhUQlljUy84QTh2UzZoNUJ0QXpz?=
 =?utf-8?B?a1JWZEhkSytEcjE5V0NENERLUm1qV0JMQXY1VU9RemhqbjZ0ekw0TlRRWUFJ?=
 =?utf-8?B?eE9OajUzdk5lZEE3SmdmaWZuZ2JsT01yNitHcEQwRVEvaVhBbEZUQnpOamVY?=
 =?utf-8?B?QlBJSkp4L0c5WlRSMExyT0RLOS9tWVl2NzhxTFpjNm0wd0dIR0FGV250QVdo?=
 =?utf-8?B?R25INlBXQXRRS2dQdGNHeGVJWnFMc0ZFdW9qU0k3VGhLMG1sdTRudlZCNnR6?=
 =?utf-8?B?eVNuS1RkT2JBMko5Um1hUndVTG9HRXVFR2h0SWcvNFhGT0Vqc3R6cHNuK2dV?=
 =?utf-8?B?Z2RoalhyU2xNL3JobHFxTy9tTFN6dWs1WWtMTTNSbFVmeXhvV3JObzBGOVQ0?=
 =?utf-8?B?U1JYVTRnZHpuczFzK2dVNDFLdzUzK3FqMklxeFZyYms3U09oRTBWelVDQUR2?=
 =?utf-8?B?TnI5OFdFNUN0OElHcEpUVHZHUlF4NDBtcmJ2Y0dnb3p3Zk9od1BWTHkxQTZK?=
 =?utf-8?B?dnNzVldkUDVXb1dTZHRHZUk5MjNOUEw1cjgvdXN5ZUxsRmJ3QWMvbDBjMzZy?=
 =?utf-8?B?a3FTQjUra1YvbDlZcy8rSmNtUUtrV2hzTFIyMDYxV0U0RzRYdG9pTU1YU0Rh?=
 =?utf-8?B?RmtRU2NWKzJBeWtPWlFxaTJqazUzc3Vkci9ibkdoQlpNRHROQW5GdHZpOXZQ?=
 =?utf-8?B?ZEoyRnN1dzMwQmJtL2N5SXl1dWlmS1o1b09BVVFjNm1qYm1McWJIWXdNY05v?=
 =?utf-8?B?ei96b1lwZ2lPYVVPOWlLcTVFNzRkTjdpRWFiTHQ2OFZaeUFIMC9ua25HeFFE?=
 =?utf-8?B?dmVmNUNmbXZnSXg1Y0JHN3lqV3YzeEhCZnhvWWFBYlZuSFJid0dKRmhHdVhE?=
 =?utf-8?B?aXhzbzk3aUpuWlA3OUszV0ZjUUx0YWJXWGhlZEt5K040RUdIdEoyM3ZoR0xI?=
 =?utf-8?B?clFic2l5UG1qSWtSR2s5TjJxVmJjbE5KVjFWdzJpQnUrR3A4THdkSlFEaW9Z?=
 =?utf-8?B?a0Fjdlg5S3JYZzlMOUhSZVBjME13TndQZVAxRlhBZ3oxeWVGRzhuS0J6dkpP?=
 =?utf-8?B?NmJYUlZyc29rYS9iK216U0YrUDZZdGI1MGFWZnlqam1hNmtBR3dseFFtbmZM?=
 =?utf-8?Q?kZZD2D2ZvepytVndTu4qnYcqX8yyUUkd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW8rRzF5bW5adjk1ZUxpeFhoenNGYUN0WGdDSnJOYVE0WWk5QkZGSGg3YmVP?=
 =?utf-8?B?bnRzWFJBVGRaTHlvMm1CeDlma2FDOVRRd1Q1SCtjaGczV0VFaXd4NWVEZkJK?=
 =?utf-8?B?L3NtNDFtcE55U055dFdrc2o0dERzVTNwdmRGZzRsQ3QrQ0pLdVNEL0Jkb29I?=
 =?utf-8?B?UlpCdDdpYmxRbUEyZHp1NTVBUU5IdXhXVHBDU0tPYTdUR0FMaXRMNkZiUXk4?=
 =?utf-8?B?VSsrY2JIY09UQjI1SVEySyswcG5sSGc2eWl1MVRCVkxTd3cwdllrb0Y1OUpm?=
 =?utf-8?B?ek9rc1RqRHc4ZnlmR2E5UDl2RXAraWQ3MG5UcmtTeTBHbzhrQUZZMEdDYUQ0?=
 =?utf-8?B?djRVMFlrbTNBUzg2WnkzcElMQklHcjB2N0Y1UUpQUFVBOFJ3MlV6eUg3b1h4?=
 =?utf-8?B?NGNNZDRmb0RuMXRIaElCdk1NT1BPZ2c4MUZsRnM0MFUySU9pUGgvelV4UnZW?=
 =?utf-8?B?RHRUbVVHdGFyNVRnQU9Mdkx4MjE2dXhqa3pmTXpOeElUYVVuaHNEam4zVlht?=
 =?utf-8?B?QnhPTklHcjJxV256S21NSjhlWlJST0dlTWMwcUwxNStsMVU4ODlMdmZoc3hO?=
 =?utf-8?B?RFU3Q1V5eFVieHE5T0lVK1ErUVg5MldNVzJlNW9hTmlkMW5ERU9WNzFZOS82?=
 =?utf-8?B?eWZVeWsyRURwbFluLzI3Z3Q4ckpuenlzek8rQUF0MkxaYWdiR3hkc2pPeVJW?=
 =?utf-8?B?Z00zeGFrYlJKc0U0cE9LdzR6dGVxSVN3bXpWVURKVjFmbXg5WnJpRzJWOFU1?=
 =?utf-8?B?VXJBWnNGd05Rd3VMK2V2bGtzb3NBaUZoajZ6Rmo5eGF1eGV2MUdhMTg5Y1ly?=
 =?utf-8?B?UUZ5eStxR25ZTlVaNW11Nmw1ZytYY042TWJjSVBCRkpIYll0aGZXbE5PSTdL?=
 =?utf-8?B?WUpKZm0wcytmcFVTVjk0R3NMTkNJeGJkNE9pR1lwbG9yUy9Wcm1GM3BSKzdJ?=
 =?utf-8?B?SkZLMkNxZmovVmo5S3JEaVJrdFdWMzFtRllDcjZ0bXA5RzFZUDF1N0hLeHZG?=
 =?utf-8?B?eE1uazBXd3dTSmJTbDRrcktwSndsR2VnMHlRclFjWkNpREV4YWNaUkYxYytO?=
 =?utf-8?B?R05DSlQrcEVWOG9ITDhwSXJjVHJwRjNZejZyeE94OWJxbmtGb0ljSFlsWkRD?=
 =?utf-8?B?TVFTNytwZGYvYXY1aXhBY2EybWVaZ202bUEzdDl3M1p3TXJoOGdMWGRyb0Y0?=
 =?utf-8?B?amd4dmloWWJEOWp6QXIrRElRUUFxeDV4WGk2VlB6Mm9hY0drR2dVVUNnMVd2?=
 =?utf-8?B?ckkrU3NKa0RWTDZkeXpvUldWY3I1bGp4ejdhRVRGMWxPam1Rclhmang0SWhv?=
 =?utf-8?B?YVJQdmQrc0MwcHF6eDljQ2ZkVnUrWW81NUh5dXN5SXg3cUtMR1BRakVCa1hW?=
 =?utf-8?B?RGcrMkJYL0VSdXBSQnE5cnJQcUpybW1tem9vOGtMOFBBOUFDd1ZXdGo5UEls?=
 =?utf-8?B?ajVRMmh4SHlQQThGQWVldWl5c0RiZWh4Wk1YOWI2YUpHTU1iQUl4UWJ5VDY2?=
 =?utf-8?B?dWozU00xczZMUlN4eFlPRmQwNGE2S1ZqdUJoQWcxMkY1bERjMW5CaTRUWS9K?=
 =?utf-8?B?OHh0Lzd1OUFZalRNMVRwOUR5aVEwaWh3RDFnRjcyY0ViZzR2RWJVTXcvUG5X?=
 =?utf-8?B?MWFpRGNyWkFjUmQwaHdHczRqaG9NbkpzR0JOM0x1MlJKVVZBNjlGV0dwdERL?=
 =?utf-8?B?Q21KRXFPaDA2UUFZQjkrMTZpNndoaEh3SUYyWWJQdTZ6N2gzYVNHdTU1Rmh4?=
 =?utf-8?B?Yk1OZGtjNk84N1ZKWG40ZlpTWkRNYWhlTmVqYnE0R2ZrYU9QdGNiRU44bm5i?=
 =?utf-8?B?MXY4OW43aDN1UHZrY3VUdldITlM0SEN0ai9KYWdOcHo5MFMzUWFab1g1QnU4?=
 =?utf-8?B?dW14a2FRblllYXY5RlN1bDFTUFREZENNQ3VQb2dPTjc2UnI3WjNJcmNTRWZO?=
 =?utf-8?B?N1dUaW9OdmNlZ2JqZjZSTklyQ2pnWldrOENSQjZaNVcrVUtFQ3loQXh5cEZo?=
 =?utf-8?B?SEtZSmlkNzl3TW12UldGRDFPRklWdVRJM2hnYUdwVGdxNWxPWU9uQWpRdlZM?=
 =?utf-8?B?anRtczQ5RXV5VENRVVVJY2dKZ2Nrc0pVamJ1TUg5d1NlT2lWQ0dLVnVJWDl1?=
 =?utf-8?Q?n+pVjmQqSvKS+KxI0a112qoYY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7183e8a-0155-4f70-36ae-08dd59febfae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 02:54:43.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Df9BAbdGdSUxk5PY6hn5RAu5B0zXCPd9TAVrKCy5Omtdnk7/cdjYrqWuQBiH0tY9deYsJkUes/ssyX2YRgrhmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308

From: Peng Fan <peng.fan@nxp.com>

This protocol allows an agent to start, stop a CPU or set reset vector. It
is used to manage auxiliary CPUs in an LM (e.g. additional cores in an AP
cluster).

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  11 +
 drivers/firmware/arm_scmi/vendors/imx/Makefile     |   1 +
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c | 276 +++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  |  10 +
 4 files changed, 298 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/Kconfig b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
index 1a936fc87d2350e2a21bccd45dfbeebfa3b90286..b5f13d0e40155e485f4d1696e9550645d888ef44 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Kconfig
+++ b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
@@ -12,6 +12,17 @@ config IMX_SCMI_BBM_EXT
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx-sm-bbm.
 
+config IMX_SCMI_CPU_EXT
+	tristate "i.MX SCMI CPU EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System CPU Protocol to manage cpu
+	  start, stop and etc.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx-sm-cpu.
+
 config IMX_SCMI_LMM_EXT
 	tristate "i.MX SCMI LMM EXTENSION"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/vendors/imx/Makefile b/drivers/firmware/arm_scmi/vendors/imx/Makefile
index f39a99ccaf9af757475e8b112d224669444d7ddc..e3a5ea46345c89da1afae25e55698044672b7c28 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Makefile
+++ b/drivers/firmware/arm_scmi/vendors/imx/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
+obj-$(CONFIG_IMX_SCMI_CPU_EXT) += imx-sm-cpu.o
 obj-$(CONFIG_IMX_SCMI_LMM_EXT) += imx-sm-lmm.o
 obj-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c
new file mode 100644
index 0000000000000000000000000000000000000000..7fa9a89d825396de00ae666f525e8d6a2d2aed18
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System control and Management Interface (SCMI) NXP CPU Protocol
+ *
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+#include "../../protocols.h"
+#include "../../notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+enum scmi_imx_cpu_protocol_cmd {
+	SCMI_IMX_CPU_ATTRIBUTES	= 0x3,
+	SCMI_IMX_CPU_START = 0x4,
+	SCMI_IMX_CPU_STOP = 0x5,
+	SCMI_IMX_CPU_RESET_VECTOR_SET = 0x6,
+	SCMI_IMX_CPU_INFO_GET = 0xC,
+};
+
+struct scmi_imx_cpu_info {
+	u32 nr_cpu;
+};
+
+#define SCMI_IMX_CPU_NR_CPU_MASK	GENMASK(15, 0)
+struct scmi_msg_imx_cpu_protocol_attributes {
+	__le32 attributes;
+};
+
+struct scmi_msg_imx_cpu_attributes_out {
+	__le32 attributes;
+#define	CPU_MAX_NAME	16
+	u8 name[CPU_MAX_NAME];
+};
+
+struct scmi_imx_cpu_reset_vector_set_in {
+	__le32 cpuid;
+#define	CPU_VEC_FLAGS_RESUME	BIT(31)
+#define	CPU_VEC_FLAGS_START	BIT(30)
+#define	CPU_VEC_FLAGS_BOOT	BIT(29)
+	__le32 flags;
+	__le32 resetvectorlow;
+	__le32 resetvectorhigh;
+};
+
+struct scmi_imx_cpu_info_get_out {
+#define	CPU_RUN_MODE_START	0
+#define	CPU_RUN_MODE_HOLD	1
+#define	CPU_RUN_MODE_STOP	2
+#define	CPU_RUN_MODE_SLEEP	3
+	__le32 runmode;
+	__le32 sleepmode;
+	__le32 resetvectorlow;
+	__le32 resetvectorhigh;
+};
+
+static int scmi_imx_cpu_validate_cpuid(const struct scmi_protocol_handle *ph,
+				       u32 cpuid)
+{
+	struct scmi_imx_cpu_info *info = ph->get_priv(ph);
+
+	if (cpuid >= info->nr_cpu)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_imx_cpu_start(const struct scmi_protocol_handle *ph,
+			      u32 cpuid, bool start)
+{
+	struct scmi_xfer *t;
+	u8 msg_id;
+	int ret;
+
+	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
+	if (ret)
+		return ret;
+
+	if (start)
+		msg_id = SCMI_IMX_CPU_START;
+	else
+		msg_id = SCMI_IMX_CPU_STOP;
+
+	ret = ph->xops->xfer_get_init(ph, msg_id, sizeof(u32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(cpuid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_cpu_reset_vector_set(const struct scmi_protocol_handle *ph,
+					 u32 cpuid, u64 vector, bool start,
+					 bool boot, bool resume)
+{
+	struct scmi_imx_cpu_reset_vector_set_in *in;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_RESET_VECTOR_SET, sizeof(*in),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->cpuid = cpu_to_le32(cpuid);
+	in->flags = cpu_to_le32(0);
+	if (start)
+		in->flags |= le32_encode_bits(1, CPU_VEC_FLAGS_START);
+	if (boot)
+		in->flags |= le32_encode_bits(1, CPU_VEC_FLAGS_BOOT);
+	if (resume)
+		in->flags |= le32_encode_bits(1, CPU_VEC_FLAGS_RESUME);
+	in->resetvectorlow = cpu_to_le32(lower_32_bits(vector));
+	in->resetvectorhigh = cpu_to_le32(upper_32_bits(vector));
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_cpu_started(const struct scmi_protocol_handle *ph, u32 cpuid,
+				bool *started)
+{
+	struct scmi_imx_cpu_info_get_out *out;
+	struct scmi_xfer *t;
+	u32 mode;
+	int ret;
+
+	if (!started)
+		return -EINVAL;
+
+	*started = false;
+	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_INFO_GET, sizeof(u32),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(cpuid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		mode = le32_to_cpu(out->runmode);
+		if ((mode == CPU_RUN_MODE_START) || (mode == CPU_RUN_MODE_SLEEP))
+			*started = true;
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_cpu_proto_ops scmi_imx_cpu_proto_ops = {
+	.cpu_reset_vector_set = scmi_imx_cpu_reset_vector_set,
+	.cpu_start = scmi_imx_cpu_start,
+	.cpu_started = scmi_imx_cpu_started,
+};
+
+static int scmi_imx_cpu_protocol_attributes_get(const struct scmi_protocol_handle *ph,
+						struct scmi_imx_cpu_info *info)
+{
+	struct scmi_msg_imx_cpu_protocol_attributes *attr;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		info->nr_cpu = le32_get_bits(attr->attributes, SCMI_IMX_CPU_NR_CPU_MASK);
+		dev_info(ph->dev, "i.MX SM CPU: %d cpus\n",
+			 info->nr_cpu);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_cpu_attributes_get(const struct scmi_protocol_handle *ph,
+				       u32 cpuid)
+{
+	struct scmi_msg_imx_cpu_attributes_out *out;
+	char name[SCMI_SHORT_NAME_MAX_SIZE] = {'\0'};
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_ATTRIBUTES, sizeof(u32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(cpuid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(name, out->name, SCMI_SHORT_NAME_MAX_SIZE);
+		dev_info(ph->dev, "i.MX CPU: name: %s\n", name);
+	} else {
+		dev_err(ph->dev, "i.MX cpu: Failed to get info of cpu(%u)\n", cpuid);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_cpu_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_cpu_info *info;
+	u32 version;
+	int ret, i;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM CPU Protocol Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	info = devm_kzalloc(ph->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = scmi_imx_cpu_protocol_attributes_get(ph, info);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < info->nr_cpu; i++) {
+		ret = scmi_imx_cpu_attributes_get(ph, i);
+		if (ret)
+			return ret;
+	}
+
+	return ph->set_priv(ph, info, version);
+}
+
+static const struct scmi_protocol scmi_imx_cpu = {
+	.id = SCMI_PROTOCOL_IMX_CPU,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_cpu_protocol_init,
+	.ops = &scmi_imx_cpu_proto_ops,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+	.vendor_id = SCMI_IMX_VENDOR,
+	.sub_vendor_id = SCMI_IMX_SUBVENDOR,
+};
+module_scmi_protocol(scmi_imx_cpu);
+
+MODULE_ALIAS("scmi-protocol-" __stringify(SCMI_PROTOCOL_IMX_CPU) "-" SCMI_IMX_VENDOR);
+MODULE_DESCRIPTION("i.MX SCMI CPU driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 2a96fc29cb6f4dd1e4c29e0aaaa614ae9783da4a..27bd372cbfb142b6acb0b1cf4b82f061529d0d45 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -16,6 +16,7 @@
 
 #define SCMI_PROTOCOL_IMX_LMM	0x80
 #define	SCMI_PROTOCOL_IMX_BBM	0x81
+#define SCMI_PROTOCOL_IMX_CPU	0x82
 #define	SCMI_PROTOCOL_IMX_MISC	0x84
 
 #define SCMI_IMX_VENDOR		"NXP"
@@ -89,4 +90,13 @@ struct scmi_imx_lmm_proto_ops {
 			    u32 flags);
 };
 
+struct scmi_imx_cpu_proto_ops {
+	int (*cpu_reset_vector_set)(const struct scmi_protocol_handle *ph,
+				    u32 cpuid, u64 vector, bool start,
+				    bool boot, bool resume);
+	int (*cpu_start)(const struct scmi_protocol_handle *ph, u32 cpuid,
+			 bool start);
+	int (*cpu_started)(const struct scmi_protocol_handle *ph, u32 cpuid,
+			   bool *started);
+};
 #endif

-- 
2.37.1


