Return-Path: <linux-kernel+bounces-355501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8157999533C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE0B27E56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B831E0B95;
	Tue,  8 Oct 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S0sc6oP+"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A591E04B7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400737; cv=fail; b=MLsbZCrd5BDs3T/8Jh80j71MBp5nQq2gR2S50HSyz9u0HdtIl+97BjsfhHI8dwKz3kyGxB0ULmdProxgLq6l8GNq4GP+UdwpsXd0/6SQ26mVIPcigV/Hmg57VLkb21h6hnaNXx7WK14gp1YfZ88NFKmusFnfO5HsCgFRxEmKwr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400737; c=relaxed/simple;
	bh=DM49R5v8+YMNDR9//TMHOLBKzBjtV69ySuusFjVM3qY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=vAZOrXokIsqANpteRhQ2twXbpiFrpoHdByhg8yDpdI6Vm5pbiNR6cwuIXp0t3rGsdi8WjCFk5kQrYjez28bjNGfMaqp3h2TvyRjT5ElEt/mRC5UXxpSNvahpixu8MqPz2u281AP7ubGtF05sNbRz/YHykgIRIbI6X9LkZLfCoCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S0sc6oP+; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGreRLiFMWsTP2plL6yEGXGK2OMRE/WOj5M4zmOfgrawzjqy9h/tKvFOHmsRarN4wzNjbUr3HwIr0vc54WEXJUJ1nMjmmCTTUv5gd9EHRFEcJM4qv68omoBYN5yAc+j7lUXVX9rxkUNTei8jmGCLtB2ntifBheRUHEaa1yf0pabExgKetgskufYIVGR0hMqIzAvBHP8oEyZ6I7n+3PCJMjN/1O0Sw98u506eDS3IFb0lXSn9pZeD93+qzaFSlB71MlsDDEkPLEGtf6v9Y9f3XEXNyMbf/g9el+Hoh4InEW8TObCo/3sSuHLxOfZNNsHDRZ8sCiwp7TObdhluz7Wf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08TqXfMeHDz+1O9efCr97YY0qpO561DtJ9QcljgnDAw=;
 b=ARwXktwgsQdGZFloA04YHGUl17okMYFF2oyugjB+IO2o2xpBRw1I2aZDypsCTJyTRPw/e5ygmrNtY0Y8R37zyyifK7Ab8BCJe6t/Z5zrFWv+7fRf75g4BR4bOt7T361nRQ24r2xirLhJRC47V2r+fJWfxLmDzCbZPSY3bbW4rxWdcvdEKYsoiEHbpYFnCZFgENQZJtXTdUp3AtibZ63feeawCBEydQfbYckFz/SciJXxoqVFnCcTvRB5pfy4osM7j6ZTFz1uA5IryXLBu+wjrgiMt5249XpjpYvPliPvsvMieb/mctol0bxJpUik+yGlDu4UJeFdshskFU2LbkgJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08TqXfMeHDz+1O9efCr97YY0qpO561DtJ9QcljgnDAw=;
 b=S0sc6oP+IiLDsmXL7w/UOdobBdHR2y3beiar0Hee0BJBRjAk36UriAGXAGU5Yik5xGybKXx0jPEa1KjtkNGNnfK7G10lcf5/sUbjsfoEuz3kPHLNzkeGoA/A0Wf7akDizIhNgKrflEoEXgDyg5vIoR/a8jdJFZ0k5claPReXE7h1blaO9sp3ea1Mb0GpeGjhg5bofOJ1MLZ4KGJ3TVdHIJ/gMSJFhc049tEeRKiHMzoY7Hp8ly7eNNR4hQlzpNYjySIokNKjbvosdS7xkEpyhjzyMCbaOHf9X+BFA6nsttealP6Cl/m2GUNdYJT//Ji9HNiKEJAIeMJh3dPq1IAEOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 8 Oct
 2024 15:18:50 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 15:18:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 08 Oct 2024 11:18:25 -0400
Subject: [PATCH v7 2/3] i3c: master: Extend address status bit to 4 and add
 I3C_ADDR_SLOT_EXT_DESIRED
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241008-i3c_dts_assign-v7-2-96ec93d1f34c@nxp.com>
References: <20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com>
In-Reply-To: <20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728400720; l=9439;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DM49R5v8+YMNDR9//TMHOLBKzBjtV69ySuusFjVM3qY=;
 b=Y/5zhBvg8X6/Qsayadwo5NAKGThxoscxMRhH+p4wkb8KLg+9IwTPxgB5IvDzYkMViMwicvkBc
 aEgBOYryRubDxlAQ21oYyKlQGt/iMC68Szt/8mE1L4gZR772P74L46N
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 75433974-652d-4c6e-05ad-08dce7ac835c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZXpkZlNTNER3dkxTUGd2Rm9sSm83czkyK2ZOc2xZMmlSZE0xVkU1bHJqcTRD?=
 =?utf-8?B?dFhabkcwNTRjNTdhMGFTMWoxdGRCVXorVS84Y3VCNmdOYmUwbU5oSFczUWpi?=
 =?utf-8?B?NzlNTUZuZS8rOFhiWEpoeVNWd2c0dzZ3VzV4MEg2dU1jSUNaZks3alYycGZh?=
 =?utf-8?B?SUxNSDZmdFJ3YjNUMjZMdnFha1dxZGtmYjhWaXRmNDBGY2l3dmQzUnI4cVRX?=
 =?utf-8?B?UGRKRHE0dUdUN2Vyd1pDc3QwUTZ5emNMRGpYcWZQNlZ6TkZkeVRJcVBVSmRk?=
 =?utf-8?B?RERFUG1LMWVOcUkxMFFlMzRZU0RyOEYzM0thL1FzRWN0dFQ3ZFEyTXNkdytS?=
 =?utf-8?B?VHR4dE0xQlFYNkI5bXd6czJDOWpqTnpwYkdxUVlNK1h6SDc5Q2pWVmJWN2cw?=
 =?utf-8?B?enZtMUdlRzlOaFNwckFKOXEvREJjY2Y0N1ZtRkR3Z3pHd3F6VytBazRyMno2?=
 =?utf-8?B?dTFvcjZITERqQ0JITVJVSGc5R2tocWVzb2ZrdHdLS2Z3NXNOdDBWdnNWMkYz?=
 =?utf-8?B?aXllR3h0aGwzRzZWVTJha2kzTlFKQ1pJTlpZNG1RanFISmcwMjQybks5V0xm?=
 =?utf-8?B?MHkxUEd4WFZQZWJ4NEZRSVFFTC9kNlVob283VUtzL21sMnJCQVhvUGJHMWhj?=
 =?utf-8?B?SU5GK0NwVjgrbjVTdWxKVktUZG5PekV2RHk0WEkyZm1rU2V5Z3lROXFiZ2VU?=
 =?utf-8?B?bVMrNWF4U2dwcC9sVTRIaVNmSmZwUnhFUjJNTGp2OTdzVUFNZThoTFRMbkRV?=
 =?utf-8?B?aGZXWGNqWFJEbndFZUEvK0xwRzhDQmhhYTN1SGR1TUVQTFhEMW4zZzAzcmRl?=
 =?utf-8?B?eXdaSGRaNytpRnZNazRTWWNSQzV1NG00MGs1M0JGdDJFUWhMR2l1ODh6cEdj?=
 =?utf-8?B?YWpoOTByWVltVTFVWkhCbnd1bHNoUkFhb3RmM1RhbDV1V0hHZm56S3pFdzh1?=
 =?utf-8?B?ZVFRSzlPd2xacDVzWlRYbE4rd1F6QnhmTG9MTmo4d3dnejErSkU3blpRV0o3?=
 =?utf-8?B?dzE4VDBNMnRQLzllT2cxeGowYjZBQTVNOEdIWVlvTmlmZGEzVVJWWWxIWExF?=
 =?utf-8?B?K1JDMHFUazJ0c2kxT1FiNzlFL2xsOWlFRFNVVTBTRkM0cCtkMWJ2aDJERUJ6?=
 =?utf-8?B?c2FFWW1VTSsvLzlzclNHTEhadnAvWm5mdlJCYkhMbTRyN0YrQzZKUkFmUmhw?=
 =?utf-8?B?dURXa2JqY3BWOG4xMHhGb2x5UnltQjRPSzdwdWZPVndrN01yMXJjYkF1bW0w?=
 =?utf-8?B?Nm16SVlTYUVNSnNwY3hXSTI3aFNTOEVBUWhDSkdxeDFNcUNmQTk1dUNpSHB1?=
 =?utf-8?B?NFZyRGRqTnVkenlPNDh4TWdQdHJoUTBZdndSeGJIU0Y2bm96cXRSVVd3U0hx?=
 =?utf-8?B?LzR2bzI4SkhhMW9oaUZwSktEbUhlYU5EbmNzdzBpcEh5bm1jaVc0NEMraVp4?=
 =?utf-8?B?dW0vcjdDUFhTR3RoY2RGaGNWQWJUV1lIaEpBMlpoWEc5c3c5dU50czNZMWR0?=
 =?utf-8?B?N2lOZ3ZnYmYrMEdaYVF5dUw2ZUV4SllBRmxxNkVrbVYrSUdPcXY0clBxWTF4?=
 =?utf-8?B?OXJ6aXN4YzFpaitzMURxeEgwd09VZG9Rek9DK3h2WWdHV0YweXhCT1NMd3Qx?=
 =?utf-8?B?cnE2K1o5ZlV6YVgyT3JCUHJlRUR6eWZMS0dPTU9IdVQ5N0lPKzFZcCtqZ2kx?=
 =?utf-8?B?d05FWXZhTVBDZ1gwa2hRTDhxRkVOSkdzUFJNWll6OEx4NTkyQ0hIVi90OEYw?=
 =?utf-8?B?VG5rMlFPaS9KUmlwbFViZWovRFZZQ09wNk8wYUl5cVgwTGlLM2JFNGlrSUtC?=
 =?utf-8?B?NUtrVm5GMkhldGVkR3BSdz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d1ZsMFh2KzFsVGVHT3Erc25aYlBicHBBUE1zNmFzUCtLUEtyeEFPTDNBa2V3?=
 =?utf-8?B?YitBbTdnS0tuSXpDZFpvLzlpN2dJcnFsdTY0a09VYm16bFdNL0J5Q05razhB?=
 =?utf-8?B?MG9oZTVkR3dCRlBBb2Y1bFhwRXFCNWxhU3lkT2FXZlppalRyT09zZDZ3QW1F?=
 =?utf-8?B?SnNTbk02TWc5VFhtUFZIbEIwRHNPR1JFVFZ2RTVpc1JTb2Zmd0NLQnJzNDcv?=
 =?utf-8?B?U3NWNTRsYkd1MHhtcW1saGFLN05VemFrQS9tYVpXb01neXVQQzFoRTVCOWFL?=
 =?utf-8?B?YzE3dDZVSGV3YUhiNWdUbktrYjlWWS9zZFNUYnBnWUVFUFp3RlB1YzQ0RVpn?=
 =?utf-8?B?bjB2Q3cyMWVuYnNYSFdma0NyQ25PeERkZWZkQk5SdlRaMC9lWGd1ZjBrZkFa?=
 =?utf-8?B?Z0tnL2EyNHZHNTJtK2RzTDFJZHNMNE5RSUxnMnZUZDNWRElZSHAzeGVSaW5t?=
 =?utf-8?B?WkgxMTR0ME1Oc3VaWVNHQjNsQ3JNM3pBZm41UldId01uaGJrSEF4WFRuRUJE?=
 =?utf-8?B?VlRJZ29PejE5YWpSNVFQS2hONWxSOHZsQlB2SnJoUjhOOTdpUmtoVkhTU1da?=
 =?utf-8?B?RmJna3lzOGVxQU9PRW5PSlZZTmMwYWpRcVhJUUNHL3ZXd2pmRDE4cnc4ZGR2?=
 =?utf-8?B?UWFFV0xYQzlsVmI5UjlDbk4yOWUzcEJtN0lhTlowV3dxWkZKV3RXUi84OFVv?=
 =?utf-8?B?MVBzSjFDZGlTTVlpWWxCZ1pkWkZQc2hUSzdCUDFRWHVtbW55YU43Uy8wV0hq?=
 =?utf-8?B?MmQvQUh0VFZEMlFYb0R1d2JJZlk3NmRpa2doemtTYkFSUlp3OEErNHQxcTVX?=
 =?utf-8?B?a0Q3dkpLZGx1S2RpZkdnN3BwRmZWQW9PNHg2TWtNK0pvQjM5UTZaV0ZuTG1t?=
 =?utf-8?B?SmlnRTJwWGpoVnM0MUFFT3BlVnJGcFphTTR4STQxOVF0b0srUlNBWlhnMGNT?=
 =?utf-8?B?ajRFcWpPWWVRUEVJYm9jclNiRFlmTzlydTRYeFd5QjZxajViSCtQYVYyOXd5?=
 =?utf-8?B?RmRlcElmeDRnOGJpVWpHdlJBSlpnTDZibkYxVjlSM1NMeU1wNWlLVzhEeEZu?=
 =?utf-8?B?SWFTWUFzOWRnMTdxUDFrRDB4bzhPZFFacldlNk0vY2ZXT2xzVjM3Rm0rRSt3?=
 =?utf-8?B?aTVTWGNWVkJGbnQvTGZhRnBnQU9uWU9RbGczU251NERUSmgybGFyQmFCanhK?=
 =?utf-8?B?NkExS0dCSWVwa1hhQTRBaUdYS1JEZXdONURrWEJOSTBGRmhQQStmSDBoWTlk?=
 =?utf-8?B?d29rUEZxY2JwQjlGQU5saWUzbmVsK1dqK3RnRlZqM3hSM3R3OVhUaWVOL2di?=
 =?utf-8?B?Nms2bHFUR0lFamRUTlBEZE81cVNEK2lTaS81YThJaWR3Z2UrUVh6SHVWa2hp?=
 =?utf-8?B?R0lZQmZrcnFnb09weFpXSzcrcDdsSGN0MWRFdGdhaStjMGgxay9RRjUwS1lB?=
 =?utf-8?B?d2NEK1dyTzB3YUl5Yzd5c1FjeGQzWmhYS0xaS055NFcrQXB4NURLTlpTa20z?=
 =?utf-8?B?QUcvR2wvN3UvcWo5VEFzMnVTYTdJQXFOTzVlMWUxbzhqbUhnVXdWL3ZmUVVm?=
 =?utf-8?B?R0VWSWtrbWwzVGJkUUUvUmdkU1NIeHdHckVKVU84NXp4b2dWZFFDRHpwUWgx?=
 =?utf-8?B?K2FOYkZmbm1uTXh0bU1udWVURWJPODYwalVHbEJvcXd3SHdSZCtmeWhubGJJ?=
 =?utf-8?B?bGVoVEMySjZvSVdQSzhrbVI1OGsvVWZzekhDVVdEQ0xwSEVROHdLb1c4cDFB?=
 =?utf-8?B?dVhoeVc3aHJJMDYzeXRQemNERHMwQUdKMUtGM1dEUGtPa1VGcU0wTEZGRGg0?=
 =?utf-8?B?TWpjd0JTSGhhNHhXQU52RjlFQmM3cHc4c1dGTHF1em5WQmMxOElvSEFVWFI1?=
 =?utf-8?B?ZXA5cFRkZkdUYmFkWFVWbm1VTkhnZ2dKRTVoT2p6MHJObWpwVjEyWmV5eGo0?=
 =?utf-8?B?SDE1eW1TTVRGUHBvOExBYnRJMElqR1d2RDRtL0ZSSTlMVWdVN1lBTi9iT0NZ?=
 =?utf-8?B?STdOYmo5V2h2a2VXeVZKR2JVaDZ3VVc5OHRoUU93ZlBrQjFSakEzallub3dM?=
 =?utf-8?B?eU1tQUpYSEhqejNZTmc1M1gwSTdRK2RsNFBjMktYZGRac0VJYlhxazFoZXpL?=
 =?utf-8?Q?1LwU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75433974-652d-4c6e-05ad-08dce7ac835c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:18:50.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wbt7H1okrLvUtjQKUkve1STdF9THYaOShL/9FHvedbXdSQB81BuERBg7eRXqmtRwLybTqbePVKdlqXwg/0Fysg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9151

Extend the address status bit to 4 and introduce the
I3C_ADDR_SLOT_EXT_DESIRED macro to indicate that a device prefers a
specific address. This is generally set by the 'assigned-address' in the
device tree source (dts) file.

 ┌────┬─────────────┬───┬─────────┬───┐
 │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
 └────┴─────────────┴───┴─────────┴───┘    │
 ┌─────────────────────────────────────────┘
 │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
 └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘

Some master controllers (such as HCI) need to prepare the entire above
transaction before sending it out to the I3C bus. This means that a 7-bit
dynamic address needs to be allocated before knowing the target device's
UID information.

However, some I3C targets may request specific addresses (called as
"init_dyn_addr"), which is typically specified by the DT-'s
assigned-address property. Lower addresses having higher IBI priority. If
it is available, i3c_bus_get_free_addr() preferably return a free address
that is not in the list of desired addresses (called as "init_dyn_addr").
This allows the device with the "init_dyn_addr" to switch to its
"init_dyn_addr" when it hot-joins the I3C bus. Otherwise, if the
"init_dyn_addr" is already in use by another I3C device, the target device
will not be able to switch to its desired address.

If the previous step fails, fallback returning one of the remaining
unassigned address, regardless of its state in the desired list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v6 to v7
- always use i3c_bus_get_addr_slot_status_mask() in i3c_bus_get_free_addr
- ((unsigned long)status & mask) in i3c_bus_set_addr_slot_status_mask()
incase status bigger than mask;

Change from v5 to v6
- fix version number, should start v5
- change to I3C_ADDR_SLOT_EXT_DESIRED
- remove _ext function and direct use _mask function
- rework commit message and comments according to Miquèl's feedback.
- change mask type to u32
change from v3 to v4
- rewrite commit message and comment for i3c_bus_get_free_addr()
---
 drivers/i3c/master.c       | 65 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/i3c/master.h |  7 +++--
 2 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index dcf8d23c5941a..e0962a17de7f0 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type = {
 EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
-i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+i3c_bus_get_addr_slot_status_mask(struct i3c_bus *bus, u16 addr, u32 mask)
 {
 	unsigned long status;
 	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
@@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 	status = bus->addrslots[bitpos / BITS_PER_LONG];
 	status >>= bitpos % BITS_PER_LONG;
 
-	return status & I3C_ADDR_SLOT_STATUS_MASK;
+	return status & mask;
 }
 
-static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
-					 enum i3c_addr_slot_status status)
+static enum i3c_addr_slot_status
+i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+{
+	return i3c_bus_get_addr_slot_status_mask(bus, addr, I3C_ADDR_SLOT_STATUS_MASK);
+}
+
+static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 addr,
+					      enum i3c_addr_slot_status status, u32 mask)
 {
 	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 	unsigned long *ptr;
@@ -369,9 +375,14 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 		return;
 
 	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
-	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
-						(bitpos % BITS_PER_LONG));
-	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
+	*ptr &= ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
+	*ptr |= ((unsigned long)status & mask) << (bitpos % BITS_PER_LONG);
+}
+
+static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+					 enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STATUS_MASK);
 }
 
 static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
@@ -383,13 +394,44 @@ static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 	return status == I3C_ADDR_SLOT_FREE;
 }
 
+/*
+ * ┌────┬─────────────┬───┬─────────┬───┐
+ * │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
+ * └────┴─────────────┴───┴─────────┴───┘    │
+ * ┌─────────────────────────────────────────┘
+ * │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
+ * └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
+ *    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘
+ * Some master controllers (such as HCI) need to prepare the entire above transaction before
+ * sending it out to the I3C bus. This means that a 7-bit dynamic address needs to be allocated
+ * before knowing the target device's UID information.
+ *
+ * However, some I3C targets may request specific addresses (called as "init_dyn_addr"), which is
+ * typically specified by the DT-'s assigned-address property. Lower addresses having higher IBI
+ * priority. If it is available, i3c_bus_get_free_addr() preferably return a free address that is
+ * not in the list of desired addresses (called as "init_dyn_addr"). This allows the device with
+ * the "init_dyn_addr" to switch to its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise,
+ * if the "init_dyn_addr" is already in use by another I3C device, the target device will not be
+ * able to switch to its desired address.
+ *
+ * If the previous step fails, fallback returning one of the remaining unassigned address,
+ * regardless of its state in the desired list.
+ */
 static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
 {
 	enum i3c_addr_slot_status status;
 	u8 addr;
 
 	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
-		status = i3c_bus_get_addr_slot_status(bus, addr);
+		status = i3c_bus_get_addr_slot_status_mask(bus, addr,
+							   I3C_ADDR_SLOT_EXT_STATUS_MASK);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status_mask(bus, addr,
+							   I3C_ADDR_SLOT_STATUS_MASK);
 		if (status == I3C_ADDR_SLOT_FREE)
 			return addr;
 	}
@@ -1918,9 +1960,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
-		i3c_bus_set_addr_slot_status(&master->bus,
-					     i3cboardinfo->init_dyn_addr,
-					     I3C_ADDR_SLOT_I3C_DEV);
+		i3c_bus_set_addr_slot_status_mask(&master->bus,
+						 i3cboardinfo->init_dyn_addr,
+						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
+						 I3C_ADDR_SLOT_EXT_STATUS_MASK);
 
 		/*
 		 * Only try to create/attach devices that have a static
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2100547b2d8d2..6e5328c6c6afd 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -298,7 +298,8 @@ enum i3c_open_drain_speed {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
- *
+ * @I3C_ADDR_SLOT_EXT_DESIRED: the bitmask represents addresses that are preferred by some devices,
+ *			       such as the "assigned-address" property in a device tree source.
  * On an I3C bus, addresses are assigned dynamically, and we need to know which
  * addresses are free to use and which ones are already assigned.
  *
@@ -311,9 +312,11 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_I2C_DEV,
 	I3C_ADDR_SLOT_I3C_DEV,
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
+	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
+	I3C_ADDR_SLOT_EXT_DESIRED = BIT(2),
 };
 
-#define I3C_ADDR_SLOT_STATUS_BITS 2
+#define I3C_ADDR_SLOT_STATUS_BITS 4
 
 /**
  * struct i3c_bus - I3C bus object

-- 
2.34.1


