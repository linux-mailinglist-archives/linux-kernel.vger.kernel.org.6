Return-Path: <linux-kernel+bounces-577004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C3A71732
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A908016E996
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93FE2AEF1;
	Wed, 26 Mar 2025 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TzktxxxV"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012037.outbound.protection.outlook.com [52.101.71.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD791EE01B;
	Wed, 26 Mar 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994905; cv=fail; b=TvD81eJmgWCEFi36E7um8nDyily49CMBlbVhQ9jav5mgf/KpmC05PMjWEy9duNi8O4qgwoVu/kD68gA3SMUrBlHccoo0Z2jH0/ggARQgP1Q8n8jhlbB3PDEcxO1dulWzv/kKCGdvyfYogD183xGTTgfyDqANOhXUmrt4ZkSMJiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994905; c=relaxed/simple;
	bh=DRkDZg1VfpzhFBuixQT+JSk3xiHDgMICrZU2Rgis64E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hEQ/k+8aV+MXiSKevd83GWLEtV07jHzlJXVwRlww3BiJvMSlpATEZ/Lq/M23HoU2aDlXshl7yz8AB3hpv/Sx/FpNH6gQRNFiC2sCdYc07izo9hzwN7wmegrhSExZt8XrFuiDKN3LrKoO/2IbKWUTFnhnvGSHJZYagNBqhFHL5xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TzktxxxV; arc=fail smtp.client-ip=52.101.71.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stdiru7Aw+TOZpc1C09xPpMb6TEXTkef9Q6wZcjcBNREX6baJK9TP0+dlN+airhSFsFHt+TOz1o0P8XPa/gzLiuHNMQ7AcZKNfBYHaezXmKO1IxP7OUGiBxi8SLeFY+iaZOyf1P0W6AfjYvwXHN0h5G3LWlcpmhp5ajyEd+1DFrYWMepR0La4ndB7S88MdPs5UBsK/pJQ//khfxpR/PZPQZByzlvbg923CZ7oKcesW4xDea+mQMo9vEhaRmzR5NUAA8sf/d1Zb5YAVHKui3iCIqI61DoN5Co2mLnjqa3JkffhMFwA8c5Mk2391ilbCCU3puT90TUbCXKuawexjxzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ9glBG/Fa0FANTVAW4gygMrCec6MV9a5TSsfhDsytc=;
 b=GjIIFYbk7w00QRby8hl7lAk6ZgyUbwI0dduyW6cJwbtgw/p7gLrrGxBjmGIG0R1FNqmmOGpdyK/pW5RB5BY83REvUMSTAFNn3lVPjcWCAlkTo2TyCVQ75BL0jmY/LhVwzC6frBDkKiqFzXcrlVPx/yKVxyEahg8axylGKkjEuSfDLXa00Lz9wxtqJ/KDmIi7Yj2lhuDgloChZnkQ1TXtZnp13xYR/XSubugbh6t7FJtFxb8RxQiKDj63MMbkqyAlebOEZhL2FUWIXtVkTGoxYiV8Oeqlb6wR78J9Q9zWe0BsX6J0d3yvW5a1DBG1r2YwX1qQ7Gd6UKBjO4NSnnAtVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ9glBG/Fa0FANTVAW4gygMrCec6MV9a5TSsfhDsytc=;
 b=TzktxxxVbSF0/H0pAnke2bVMr66tA3W1h2zoSbVbJFpV0Qfwk8+MmbpzqGDdpEVR8IcT8PZWnfbMTPgFM3m5yr+aK/1Zk3w9iLMIGKMm66qNq2x2d7fkWCaA8VlhdSCFusi/Jdvbb7G+vAteBVnghrWwqGtzadi2Uq8ZF+xwpbyqKEVgeWwllV/Rmf/i3dmgnNLvVXXlgQLgd0MZhRD3gxvUeN+vZmERFStCHq74k+1T2zSwI2biamdiolXNTjL0Sa6zZ2uxrJIPbPdQkjIogiuxVZeVgTUU8fyhtqqNE/LeSFuNlpXOzOJD5smwfND3QcK19MPd64VrUaT+fi6qxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8855.eurprd04.prod.outlook.com (2603:10a6:10:2e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:14:59 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:14:59 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Thu, 27 Mar 2025 00:07:58 +0530
Subject: [PATCH v14 2/6] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-imx-se-if-v14-2-2219448932e4@nxp.com>
References: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
In-Reply-To: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743014302; l=3712;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=DRkDZg1VfpzhFBuixQT+JSk3xiHDgMICrZU2Rgis64E=;
 b=p47sOm2XIWO1bZZ7uCPcKpirvf/O00U0/qnYqYBdBMpLqZ+2x+pGlr5EdLa8hLxzQWYa9DBP7
 ArMCzvOs97MDcAZ9NdBFtPZ70Ae3jPrscNGiL0APNOQWSAp/Tl+Vruh
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DU2PR04MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee1a811-c3cf-49b9-5e4f-08dd6c6835ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHV5T3ZQTmlIWW1sRWxsbVZlZmRiR0FQcUJvK3BCdmZIUXFtMkdlUlYvUEVZ?=
 =?utf-8?B?SGdJNnR2SVF3Mm11WnNqQ3BMY1JVc21VZEJTb2ZNWFo4SVkyV1FrTnNwZEtq?=
 =?utf-8?B?aGZiYmUxaXZkUmljbHRzVmlUTmFXVjliRGRMYmppZk1ITFB1R0FOS2RyK0Z0?=
 =?utf-8?B?SUNqM3RIMmpyMHE3aC9jRHZDRjBYTmFBa28wTzFDNy90QTEweTVMWW1rUUlQ?=
 =?utf-8?B?V0Y4QURBUlZDSjUwNE91YTdtcXBGSExpbUZ4SzZMNkFPUVlNY3dHdHYzQzBX?=
 =?utf-8?B?dWUyd0NSTGRYby9yMnhRWU1kTmRYMkJUV01YUkt0MklGMnpVRUpIanFsQ1pu?=
 =?utf-8?B?ZGlTb3liNFFYTndyR2dXSkM4bVRQNXN2cFBhSytBR0xDRnluQTE0dTlNZFNX?=
 =?utf-8?B?bUsxaXBONjV4ZFJOZHNUYVU2QmpQZzMvOWxiUVhORThjUFJTSFpzZHdGWTFM?=
 =?utf-8?B?RS93SWpySVNyUlVaU0djai9iN3M2UWI3aUt0TVdDWDNlY0JtYTVyL0h6TTZV?=
 =?utf-8?B?Znhyb0FZUjV1V0JJdXRESk1QN2U0d0FFOCtDN1V0VytYWVFzYVNwdDM4SkxR?=
 =?utf-8?B?UFZKRm5yMmlZK25MOHl3cGtNK09SZDRUK1Z3aVo3eW5IVlY2bWdFazk1OWlO?=
 =?utf-8?B?ak1Ya1NKSlRuaGxnWGxqekxNWUdZQlBJUjVhWXNSRkJoc3NjOUFwUmE0Ky9k?=
 =?utf-8?B?TWhhZmpyK0pmb2l6aC9aTk1ma28veEgrOC96UjBiRG5MM1NvQ0xraTE4NHlu?=
 =?utf-8?B?MW0zT3FsaVh3QzQwbzJSTVh5MVZTUkVSYlFBSmFGWHpLRmRjZWVJSmxWUzRE?=
 =?utf-8?B?dUVnSjBPOUlVbXdmZzdVazBsMWV0bENBRTBSbkxyNlRnWWhkQ0IyRG1ZQ0Z0?=
 =?utf-8?B?R3JleGFjZEhNWExkNXdqcXlMNzdXMys4aUpjZnZEbmFSdWMxMFh1OVJuMFFn?=
 =?utf-8?B?Yis3b3kzMG1QOFllL09QampvbWVQc09BOVIyQ21oclVKYndVTFBWK3ZnUDVj?=
 =?utf-8?B?Qzl4S1MraTNDWCtTQ0RrYTFIL1lvQ3NrSVF3TTVmOHI1bEthemZtY2pFa1l4?=
 =?utf-8?B?WExpTmlybk43TjkrRksvTFRiL2pYUVdiWVp6WUg0Smxjbk1QUW9QbHFNZXdn?=
 =?utf-8?B?b2hKNkZGK1M2N2N4Lzd6K2N4TmV2M2JXMlA3STViTWVmUnhtanBxNUVzTDd1?=
 =?utf-8?B?c283ekNMYk9UVDFzdW00TjNGQnNSOHlsVlVCUEZ5TW9zVUVyRkxwNU5ybnRB?=
 =?utf-8?B?TzZCbm1scFdmeXdCOEw5QVQrOUJLTzE3cWR5L2lHVVdvajd2VXBSYVd2RGxN?=
 =?utf-8?B?VDlTR29RdFlMbWJBRGhjZ3lSNTNxWlcydEU1cTBRbXA4NVhOTXRCbXZ0Z1F0?=
 =?utf-8?B?SHp3VExJamlDUXdHdHZtVHJqcllYTE9WNnIrZERFSktIQi9Yd2lwSU4zTitB?=
 =?utf-8?B?czF4L05HdGtkbzJ3TG40VC9MazdwNFFQbmg1SXFYN0tPNnZrL1ErRmp2VTlP?=
 =?utf-8?B?dW9GeHhBOEUxM3NhbmFHQlBiRUVsU2dOT1lRY2tlNG5SbkZoZy90S1gwajRJ?=
 =?utf-8?B?bjVLdzRrVUk3L0F6TFZhcjI4aDJpUzhIRWpjcjVuM0ppbGdtYms2cDhIRGFL?=
 =?utf-8?B?ZEE3cXVxeWw2YVJISytESzVZZEtZTUVGRDVHVlZUSkJRd1RjVXgzMEJpSTE2?=
 =?utf-8?B?K3REZXkzQUs2TStTWHIwdTNFUGNWTkcxQnlZSVpaQVhDYkJETlhUUnNrc29v?=
 =?utf-8?B?bTJiSlhWYUMxcXZlWkhGVGRrRUJFZWxqVUdHbkJmZjRBdTB1bUJwV2VLUGhX?=
 =?utf-8?B?WlVabDErNlh0RlNucXNvQmJ3cmE3d1RlMC8zMUU4YS9taHE3Yk14aCtMTTM3?=
 =?utf-8?B?QU5ZeE9DYXh5RW5aQm9mY1hEY0pvNjNuaXZNZUp4cE5CWWxWME8vSTQ2SVQx?=
 =?utf-8?Q?YS+3SLdPc6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K09ETDluWFhXZmloaVBZY3oxcDg0MDZzYkZJN3JuRWdvSDVNTitwYitpMkZQ?=
 =?utf-8?B?aHoxTmE4OHp4TGNnQ1VHczVLdzNmRTFGSWRnVUp3TGlpUzY2MTgzZFFOUUp6?=
 =?utf-8?B?YTVTYXRGZldXdFBtSi9BRDhNNndvWTF1NHNraW9uUEovM2E5Ulp5L2l2RW5B?=
 =?utf-8?B?UTljTkZFZXVqbUJEYWZNY20vRTRqN1EwanlsdU45MHRaZUNRRlZlcS9CcU9h?=
 =?utf-8?B?bjBOb0tGellJeFF4Y2FpdGJpQnRIR0EwOVFOYjNFcXg5cEtBNVNhSFQ5bDBN?=
 =?utf-8?B?NHkvL2pKa0hyekJhT04xV0dUd29Scm9NYVJJN3VzY3lOZUdIT0dpUHVXTFd1?=
 =?utf-8?B?QUFidVNLTnlDTEpCVEtydVM2THorejNmV0xRN1I0U0NqM1hUbEg2bjdqL2hy?=
 =?utf-8?B?S3ovM2o0N1U0a2QxNmQwTlVrNXpJMmF4aVRSL2dodkYvZmRHV0RJMm5NNG4r?=
 =?utf-8?B?OTZOZWQ2YWhyYmppdWkrcHdXQVRJS0w1VFRqcVM3dGN1aXhDVGJGTHVBWFFi?=
 =?utf-8?B?aW9DcFBvakYvakI1azRQZmgrWXh3d1RiMGtuYUdiaW8wanFueHhUMmpHbXlD?=
 =?utf-8?B?WDVHK1Fac3pJdkdiSU83UnhES2ZsdCtuZUJ4T2xvWlYvLytSZzRBanhmQkg4?=
 =?utf-8?B?NE9UbjBVOUU5WnVKZlJVcUVlNmRaUkxGWUFZMllQakYvcVpFam5pVU1rdmZz?=
 =?utf-8?B?RS95UmRZZFBNbllwcWhzbnlKVGQzRk5lWlk0Mjc2Qk83SHAvUGpETmhPVkJQ?=
 =?utf-8?B?OWVGM0wvNERkVktsRDE1NXVVbnczbWNueWd1V0FmbnlsTUZpa0NNaTF5QU9Y?=
 =?utf-8?B?QjZOczJJSGFCWEhhMllzV2I5cjEyTW1NV242Y0dIMCsxTWVEZGdpMFFZZFpO?=
 =?utf-8?B?cG55Rmk3dEtpM3ZGZjlDTE5BZHcrcHQrTUh6NGkyMUxmTC9nU2pseE1yd0Fl?=
 =?utf-8?B?RE9YYVRGdFRzQkpFYlFsQ0tQRnM5cDBUb3JlTW1aN2ZGQlhWTGlpV3FJRllL?=
 =?utf-8?B?N2xmVkNCQ3lVY1hjSkxxa3RKQ0JyNENHaTZQY3JMSGh3OHNnUHJpN1k0a2ZE?=
 =?utf-8?B?MFB2M1BuSng5M2NqVXdsQ0x0TWFBNnplMm1Pc0tRcVdxZnBteFZuTWFKWUkx?=
 =?utf-8?B?UmtuVmRyR0JKUFVuMnhkeFI3VmJHblVaOHNVeXRZbGZFTWlNVVlmdzNuSWcr?=
 =?utf-8?B?dUZmRVUwdnUycUxCc3ZEb1RWRWdoSWtmM1RxRWdWdm5nbzg5UUNlR3NUNFZm?=
 =?utf-8?B?Q1Z4Wmt5MEoxdXB3VnVidnFISm56b0Uway9iWmtlWTBOM2xzMEpncHZReU9O?=
 =?utf-8?B?SjVGdTltYTR5ejBHcUNTYzNqYWlzSTB2ZDBzUzEyMWRVcXpQalFFQlA5WXZq?=
 =?utf-8?B?L1FkWTZvK0pYQm93WFVpUjRXNSsxMUVrYzgrOWdtMlpDZnROSXczcTBIV2lX?=
 =?utf-8?B?akgzU0l0UDRBejFjZG93TUgxekNMN0pSbFd3bUFiSXZtcHpERjREVEFRcFdt?=
 =?utf-8?B?dTJ3K3JvR2dncUozZHVMY2lpVzZ6WVZndHpHV1NvZWJ5dDl5dS8weEJ5TGta?=
 =?utf-8?B?d0E4YUVFL2VyTVVsT1h6UmkrUEtxcmF5NjcwM05zeGYzSXFBa3dGSUcrRmty?=
 =?utf-8?B?bm1URkRpQnpWOHZGV0dmMVE2bGo1MmVnaG9oS21JMXIxV3ZTNDlLMXNndG5p?=
 =?utf-8?B?L25OOEJTUlZZU2diZFI1UEpJZnFxUURHdFJuMXg1VjlFWXIyVHRqT0JlT205?=
 =?utf-8?B?VGlVWjM4NzZxeFFwNVB4dk5GUlBEMUNMRTRiNW1kK2ZkdG9tVVZrWDRaWTk0?=
 =?utf-8?B?UWFMbmIrbDh0a3E4REcyejlKQ21UM2J3SXZwcWlxbk8zaHlHRkRpUEZQMG5h?=
 =?utf-8?B?cGZPYmVaeFNTeU42Qk52SGgxV1RaSmV3M1FZZGoxa2srVkp3NjZtMGRmcWhP?=
 =?utf-8?B?TFdJZURFTXJ4SmFiTXJ4dW5sRFhDaXF5R3dXL2o4QUEycnlSVjVzRlZWbGg4?=
 =?utf-8?B?T2pkYXF1ekJRYXhsK2pxM29VSmhrcUR2Wi85QjR3UkxMcWpWbTg3YW1JejNq?=
 =?utf-8?B?UUZKSGdGLzhiU09Gb0F1VjgxSGNEaXhrUVVMT2VLNE9qUDQ4NG9RWkpKYVYw?=
 =?utf-8?Q?lTPiwl2rlfCrA3R+wlkVrl5NW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee1a811-c3cf-49b9-5e4f-08dd6c6835ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:14:59.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v86wdqdNPRbedKMoVD9nbjEtvukkp8vqqdYCppPWOGrXxhvIJzlFDhg0a9kaf8KGvdLjNK1rCwTVaRwyJkfWaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8855

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes from v13 to v14:
- No changed.

Changes from v12 to v13:
- compatible string is modified from "fsl,imx8ulp-se" to "fsl,imx8ulp-se-ele-hsm".
- compatible string is modified from "fsl,imx93-se" to "fsl,imx93-se-ele-hsm".
- compatible string is modified from "fsl,imx95-se" to "fsl,imx95-se-ele-hsm".
- Mis-understood the +1 from Conor. Hence dropped the Reviewed-by tag.
- Collected Rob's R-b tag on v7 (https://lore.kernel.org/all/172589152997.4184616.5889493628960272898.robh@kernel.org/)
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..fa81adbf9b80
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves(se) is based on the
+  messaging unit(s).
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-se-ele-hsm
+      - fsl,imx93-se-ele-hsm
+      - fsl,imx95-se-ele-hsm
+
+  mboxes:
+    items:
+      - description: mailbox phandle to send message to se firmware
+      - description: mailbox phandle to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    maxItems: 1
+
+  sram:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se-ele-hsm
+              - fsl,imx93-se-ele-hsm
+    then:
+      required:
+        - memory-region
+    else:
+      properties:
+        memory-region: false
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se-ele-hsm
+    then:
+      required:
+        - sram
+
+    else:
+      properties:
+        sram: false
+
+additionalProperties: false
+
+examples:
+  - |
+    secure-enclave {
+      compatible = "fsl,imx95-se-ele-hsm";
+      mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+      mbox-names = "tx", "rx";
+    };
+...

-- 
2.43.0


