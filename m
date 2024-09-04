Return-Path: <linux-kernel+bounces-314818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6096B973
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC41F2954D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4897C1CFED8;
	Wed,  4 Sep 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dEDoUw6q"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013034.outbound.protection.outlook.com [52.101.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608E1D1F7D;
	Wed,  4 Sep 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447356; cv=fail; b=hP0Xp8T6mPNFqgoMwAtvtxXtAO7pvgQomAlfplj61wKuzSyG5sxU676DjZTkuOCRTFVqRqxwdGgPkDsiEQrmwcqFeDePjc4+Lo8YZ9lA5VUStRxbGVx5rSfy04LdfHthHfiSIaOyW+uCwKAI+8OGaD6GgzGGojp0wuJPmgJpqWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447356; c=relaxed/simple;
	bh=yw4x+wzD8B1aARoOlXJtfvRhJDlksAuKO6KErYOVdSo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SGkZt2goBWdJjXnn0JNbQ9Fp9zIYTLo5HMQly9i5hvktD4l/1+noU/VHuSX4ZrOgNkSnBAoDj6ZmZYrRgS4mg6TC7jsbxue3dwolJWcrVkdrrukyYKVABLx0b3wAJ1jbcdkix6oeTyhBNH/9B7w+OY4kYtAaMxpF4lvWwS2nBCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dEDoUw6q; arc=fail smtp.client-ip=52.101.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGkQJRxw7bxsmQgs0pQejmXoRXr6Nk4bbC6JrLHxOCOB8rnpHCp7xZGORHP45QZAXM6tu2RtdWrO7obSYmo3brE1zHVU8i8mAUVMkeQoOefqhCiqFxOx13fxAeLo2cypqZet8RoYWCb9nLC6BaFJEW8e8NK3awoXfrGmeJwbWvNh2gpx+V6hzvrbYNLnsfttQIn12t5GpLZmgy2KW2huF89Xe8T9uSPZQdN6Lu9vyXiKAOzkCBV8PDSW5oFVGaftN/0ljhnNose9Neqd2d+9JdtIByKaMyYfuKMn39wJAFdW4pJrcRpDIMjHrC9eTGrVwI1PyqMzoBJkzH7qZQ4uNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbGtvy4PLt8Q29C48EG2I/+cgmMOjmP6xHlzSGPfVSQ=;
 b=cdFUBygGj27YzrDtuMfdg7y5vtTt9/9ChDzdzbT9M1IkM5ITm/VlaZXkIxHZqxPZSV2pRu+5KFyrn6OrMQm8dRxZH3X9TX/i2ufQ1EXgCfUjQzWj+RmCRJ276wEBYq1oFg9d8lL1tKxubhi2lxM1nZohL9BnsFefA2XhYpTi91/opY4ptvvw+1pTn7qSq6zwJhDthlO8o2DCaZMacsry84yQd32a8ZmZdin5Sd/yBaNH8FPbDcfDhNozuSyFnadH2hNICSficYvDeYLyLyZT2feMFGtauSsWhGs3gFhtVjEgLW3O5BDFKbFTEV3O3oXN1kwAleRxL75uk8F3v7QAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbGtvy4PLt8Q29C48EG2I/+cgmMOjmP6xHlzSGPfVSQ=;
 b=dEDoUw6qYi8nhP4pE2WjgqZOPl3CRjoqN6vjsaV35yMCvUiGplOHIDNb5JOzc5/R4r+J6ahqfRG/6Ci0TGACblMrNeSXaTNez83jJod9bc7GHB+tgyDJu7Lxb63XYqPzUU2/hE0XU616lCmONy+YtPTziR502GDY0Szlx0+01O3xXmXBns+VleTdQFAC89dxkpVHf/GdGLRYKAlwz9zGu4809ljySM/suwP56GeQ70+5Eck4FlEd/71BRcKJq0tEAkRdyNjBzKl4DnSv4vPFiTlRWT72mSdxiLBGBfQXpTuOc9w//lZR++XrrUmkoC4hVXJ2LTpRW+6DX3a2VLv8dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 10:55:51 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 10:55:50 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Wed, 04 Sep 2024 16:21:21 +0530
Subject: [PATCH v7 5/5] firmware: imx: adds miscdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-imx-se-if-v7-5-5afd2ab74264@nxp.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
In-Reply-To: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725447104; l=37517;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=yw4x+wzD8B1aARoOlXJtfvRhJDlksAuKO6KErYOVdSo=;
 b=mFmUwm/e33VErd3UQPN6YnC8mwM/Gr8W7cjjJftYnChV8OHorf4qVZMWOzjD0eXqwA0ExTOIj
 g9O/AoUmVvvAD6yrRF6YbSggG9k5SsRB8MH77PbU1KvcrwTHap9T6u3
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DU2PR04MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 512a2a19-4bc4-434c-a2a6-08dcccd023e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzZCRVVjRkpoZThZdm91aUZtUm5iVXM3QVFXa1lqSk5Qcml6NWMwM1JVN0JY?=
 =?utf-8?B?NG1QMnlxQjNUWERYS1hnTlN1Vks3T2JFajBsQmRCVWhWNnJYOTR5d004Z0R4?=
 =?utf-8?B?NlhkSWVwUm16QjRDeUppRS9DRjI0Y3BhTXp1TGhLbGdqbEp3T1FFREduMGZo?=
 =?utf-8?B?SnE3VkY1UWI1ZlQ3TGU5VlNrZVNxbWR3YXA5enIvTEtKTWQ0OUdyd0hxR0Ni?=
 =?utf-8?B?MlBFSVRvbURSWDhRcTUxdTlPMThFQlZ0OFU2ZEx0OGVtWTY5UDE1Vzl1WmlK?=
 =?utf-8?B?dGl5QjJSYmd5ZWpSMWhTaVpRSmh1bnE2YUd6V3cweWVFR1g3TkNOZ0VkMUYr?=
 =?utf-8?B?blVaUGx6UW1IK2dEeEkvRTNuUXo0ZzMyT0dBcHJOcWs3SnRBNDh1UUJaQVow?=
 =?utf-8?B?ZHZydXB6cDE4bE9YMzFxMHdVRDUrZUFUVkt3cnFRWmdVNmNPSWxmc3ZJUGlR?=
 =?utf-8?B?LzVoK25zWGR5bHpNS3FZOUdJWXVEZzh1WlUzQlFoNTdVQ3EwWlFMV2VJOGdp?=
 =?utf-8?B?RkZTV1QwVUtKaDRSaEEzWjE0V1VxdWpEWXNJTzBTQmI4MHhwd0xmbWxxcE5P?=
 =?utf-8?B?NjY1QjlLTklEMlpVMlNRdThqWkVZcGJPWjNKQzBkSGhXZjRrblp2WUZSdFEw?=
 =?utf-8?B?ZVdnQmRtOUdadWJDQnBzcFluMzNkcHBNTTQvQnd2K0VXemxjVVdRb3Q1S1Rh?=
 =?utf-8?B?U09uL2pRVjRWSTdkUFBCVDIrV0M0RktYRTN3REZyVWI5UzczNTBPRFhUUzFF?=
 =?utf-8?B?NVFQcEtGU1Z2c0tlZEdPYXRRd0JNMTNLSVVoS0tMMFZhWlQ4WmdPNzhQMEx5?=
 =?utf-8?B?cFVDUnNnK1k0ejVtRzRtcktXUGxVTElBaFVwTWI1cGdseWd5eHVMZjZ3bU9z?=
 =?utf-8?B?aVJhQ3hjbXkyWHRNQXdabDFnU3pid09uYTEwb3I4OExmcUNMdVBDbGt0dng5?=
 =?utf-8?B?WDNBWGp5RVJxcElUS3RjRWEzUmduL0gzQVZCb20wM1VkS2lsaUx2clBDbitl?=
 =?utf-8?B?WFpPRGFqWDUrZ2lMMXB0UEVzdkhCK0g5YVB5ZTNJN3lsWldHVjZpbGlQcWdV?=
 =?utf-8?B?Y0tJcTNXNDloNmhjczlOVXcwRnBhRUdDc2FGK1B2dGpIM2l5b0djQUhEVmQ4?=
 =?utf-8?B?WWt6UTkvazJQVW9jZkJtUUFnWkw2aDNRU2dnZDZBQXJ0ZTNUbWZ0UTVtSWxU?=
 =?utf-8?B?cW1Nc3JvSm5wRWQ0NGlUS0sweEFpR01CTzNwbjVwY093N1hjeXJyTHpQNGVG?=
 =?utf-8?B?aWZoWHB5MXZ6QkV3dXV1cnFoNU9GWnY5bXVPQmUzeG9udkdDMnduNGlhSk9k?=
 =?utf-8?B?UXVXNGhzSW5YbDR1QWxBYi81djduTndWRVFRc2xUQzhNUkY3a0NVQzdtcU9P?=
 =?utf-8?B?eW55SmR6Sll3OW8xd2lkbmoyMUhBamM5MVJ0TkhMT1NXcDJFaWhoajZSckxY?=
 =?utf-8?B?R2k0YTV0UEhMdEpDSFhWMzk1aStCb29qdVUwZ2dTaXV6a0I4c2JaTlhzcHo5?=
 =?utf-8?B?UkVWaXFERks0RFZkU1pSaHJVci9KZm9KUWNLU081VERzbVlwV2c0WWdHMkFF?=
 =?utf-8?B?aFhFdlh4dXpNb1lGOUNPUzhwTDJvYUJiNElLUGtZbkhPWnB0c0lydTcvVGhO?=
 =?utf-8?B?TUtDL0Z3NkdRRllpSGd0Q1RXSEMzVWxWQVA5TXEyaW1FK2x3UlRMYm45VU42?=
 =?utf-8?B?ODVaYnBSUE4wTVNSZm5WRUc4TWlqYm1rc0NoSmVPSzhtbjJVTEdJSkFzcHNi?=
 =?utf-8?B?bEJvazVnbnZMbmZIMUhrenN3OE5VbjQxQStPOHY5Tm4yaXhGeFZiSDkvWW1D?=
 =?utf-8?B?TmkvTFozOU1LVnNVc2lnZDRmUUJiOFowK2NNNXViMHNZSHYyYlpOSEVUWXdF?=
 =?utf-8?B?azAvMDBjamw3NVo5emRLdUVyZGhvYWUxcjdHNzlhaHJnVm9rTVM4a3FISXRn?=
 =?utf-8?Q?PAouxKW1alk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZElpS1RXQ0Q3SjNSNVBLRk5EeUpDWWdOcVhJT1BYazRiTm1QR2pQMXNEQzlR?=
 =?utf-8?B?WVRRQlFVdW8xVU5ielRLZTRYeUh6OFpxeFY2enV2TVBSMlRkVGtUVUVRc29w?=
 =?utf-8?B?TlBCOWdGNzR3NXJVMVp2RFZpZHNsbjBrMWRRYnVPQXpzL3BpZENrcDdtYjl2?=
 =?utf-8?B?Njl1dzJWcTQvVXlQL0JPMk9JYkEyblY2dHBLNmViMkxmU3J6aXdzaVQwQ3ZT?=
 =?utf-8?B?WWpPdVN5ZURCVEhzelhWZ0ZsVVA5LzJVNFNRT0pmM3dCWUtvVjVoQ1hxdEVK?=
 =?utf-8?B?KzdpZktYOXpWVVdwcXlIY2JjUkw3aFIrYlcwNUdhRjh0YjNuSGhPVDVHS01M?=
 =?utf-8?B?ekhlTnNsRU83TUw5WW52M2lBUVNHNkxpVUxFOVQrU3d4THgwS09xMk1vTXZW?=
 =?utf-8?B?T09uMDJnQXp3RzQyakRGYUdDanc4OGdPZzdwZXRVQnFJOVNlc2Eva2VOODV3?=
 =?utf-8?B?Q1lCazk3T0oxdHBXZnRicG43aVBsZnZQYXFhTkNISUxWR2FZOEZHQXYvTDJN?=
 =?utf-8?B?dUZhZ3BxcXBvZDJveURVVWwxc2FIdGh4WWlycUY5bjk2d1BmU013L2pPcjdJ?=
 =?utf-8?B?YTFDLzRVZHg1UElJUUl5cEd2NFJFcmJaelRDTmM1NUpVeGYyZlIvbWdQTUsz?=
 =?utf-8?B?MTVuRDNqZlRqZ0JDVEt3QUNrck9uMzNwS29IQm1jbTVYUURQRXdySjF2cVNK?=
 =?utf-8?B?c21YNk5FQUYzdVVmWGI4azYrL082Um44RzRQaXRiY3kyL0kyUGVKWHBWajYz?=
 =?utf-8?B?RnZRaTR1Tmx6L2VYcVlYZEpSQ1c3MXZkRENhS0RHRkdnT0pEWHpHSFZuUWhQ?=
 =?utf-8?B?YUJmRkN2YjZoK0NLOHgzSE00OHVJai8xWGxnUkQwQ2N4aE5CMmUwT2JSY3FP?=
 =?utf-8?B?WG9CNVYzU2xPRFFXNCtXWmd2OUhXS1R2TUtKR2loL3BxNGp2emZFN2M5N1Rp?=
 =?utf-8?B?VnB6Tmx3WmdFQ0k4ekFHVDZ5V3AxcmlhWnJGbUlqeFF1RlhsMFB6eTBtTEpS?=
 =?utf-8?B?OGxYYkRFQnZ5ZHYwV3ViV2pXSUFhZlRHSjdtYVNtL25jT2hFYWNKeGhNUVZy?=
 =?utf-8?B?NWRPc3BpUitwWldUVFl2bktZcUVib2lIZEhKOUZlSnpUd2djMm1QeE94NXZG?=
 =?utf-8?B?c0xtZ2FmejJYelM0RkpEb09JSGoyd2tOb2Y0MGhEMWxWUCtYWXpzM2lHa3Bw?=
 =?utf-8?B?L2hKY0ZvVSt3R2c2NGxJQ0dJNFRVWkttWEZZY1lDQ296UlE2S3BCazZIaVRu?=
 =?utf-8?B?RWphWnd1dUZvZi9yY09VNDBKTHZUQnA2bDdlNGErRGpUeHhERUtBOWlKdnF0?=
 =?utf-8?B?T3h3Y1lzeWRJbFlhUlZwWW1nb0NhMi9DTXNkcjIyUlg0VE0rN281MGphdVNl?=
 =?utf-8?B?U2dRelJySnVjdkttVW8yb3RzOEZwWHlKbzdsNXVaVmhEeEowTmxxUDNFOWdh?=
 =?utf-8?B?WkpOMlZCUEMybisyNTFGN0lzaGVMN2QzcnBXblloTThYNTJQdStHT0srb2U5?=
 =?utf-8?B?ck9BREZTU0dHOGorS0l2eFlmTDU2NTRlUlN0MlV5aEhqejNJKzRUK3Zpdmkw?=
 =?utf-8?B?UXVxY2R6SkhRaFIweDBEWWxBZUcrVG1pT2hWQnY0Q1l1cnltMGtqb1RnOVA0?=
 =?utf-8?B?blV1WkRZUllZYnNGcisrNHZWUUtVNmdCQTdSaTVmS2Zia3FNU3UxZGJiUktV?=
 =?utf-8?B?OERUR3h5RGdrQkFaV25HOFB6Y2hCaHJ3NEUvdkpETVVyL0tDMW5HNG1GcjNj?=
 =?utf-8?B?VCtmRVRqWVBaa25mTlhUTmlWT3huRTJEWGdvOUwxdmhNcXRzeHNDWk5oUEFN?=
 =?utf-8?B?cXltQktteDU0eTFKVVVKdDhWYVU4dnRLdnZDZ3diZEtnekliMzJuMEtmK0dY?=
 =?utf-8?B?dHVKWFpiQVBXY0dMYk44UHNNOWo5Unltcm0yUjZHNFlLUHh2bFc5b2RjaUNG?=
 =?utf-8?B?WmRvRGJhb1lVVkt0YjBCVDNueFM1OW44LzNoNHNFaHNGV0Q2LzBUeS9FcnA1?=
 =?utf-8?B?QkZqcUU5VWJYQkROaG9ZOXRKNE1ZdCszUkZRNXhBbHhUWENHbTYyNVFaLzdm?=
 =?utf-8?B?ZUozNktqQ08velRJTDVlRDRIWDJCanlDdy9lOWVkR0ZpdHZDWTdrSlJycUU5?=
 =?utf-8?Q?jTHJQrnUKBW8pFakmR2cIMcnS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512a2a19-4bc4-434c-a2a6-08dcccd023e9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:55:50.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpX9Csxip5wYW1gV8+AqaBQqpf7NTJx5s4rTOUteMoY/iJ9YR0bzCx57Ejry0uWtRPtb0p+AtvqUUcrYjFCiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583

Adds the driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like
EdgeLock Enclave from:
- User-Space Applications via character driver.

ABI documentation for the NXP secure-enclave driver.

User-space library using this driver:
- i.MX Secure Enclave library:
  -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
- i.MX Secure Middle-Ware:
  -- URL: https://github.com/nxp-imx/imx-smw.git

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 Documentation/ABI/testing/se-cdev   |  43 ++
 drivers/firmware/imx/ele_base_msg.c |   8 +-
 drivers/firmware/imx/ele_common.c   |  36 +-
 drivers/firmware/imx/ele_common.h   |   6 +-
 drivers/firmware/imx/se_ctrl.c      | 790 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h      |  52 +++
 include/uapi/linux/se_ioctl.h       |  94 +++++
 7 files changed, 1010 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
new file mode 100644
index 000000000000..3451c909ccc4
--- /dev/null
+++ b/Documentation/ABI/testing/se-cdev
@@ -0,0 +1,43 @@
+What:		/dev/<se>_mu[0-9]+_ch[0-9]+
+Date:		May 2024
+KernelVersion:	6.8
+Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
+Description:
+		NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
+		Enclave(ELE), SECO. The character device file descriptors
+		/dev/<se>_mu*_ch* are the interface between userspace NXP's secure-
+		enclave shared library and the kernel driver.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include]<linux/firmware/imx/ele_mu_ioctl.h>.
+		ioctl(s) are used primarily for:
+			- shared memory management
+			- allocation of I/O buffers
+			- getting mu info
+			- setting a dev-ctx as receiver to receive all the commands from FW
+			- getting SoC info
+			- send command and receive command response
+
+		The following file operations are supported:
+
+		open(2)
+		  Currently the only useful flags are O_RDWR.
+
+		read(2)
+		  Every read() from the opened character device context is waiting on
+		  wait_event_interruptible, that gets set by the registered mailbox callback
+		  function, indicating a message received from the firmware on message-
+		  unit.
+
+		write(2)
+		  Every write() to the opened character device context needs to acquire
+		  mailbox_lock before sending message on to the message unit.
+
+		close(2)
+		  Stops and frees up the I/O contexts that were associated
+		  with the file descriptor.
+
+Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
+		https://github.com/nxp-imx/imx-smw.git
+		crypto/skcipher,
+		drivers/nvmem/imx-ocotp-ele.c
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index e3e570a25e85..ae200ce64100 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -68,7 +68,7 @@ int ele_get_info(struct device *dev, struct ele_dev_info *s_info)
 	tx_msg->data[0] = upper_32_bits(get_info_addr);
 	tx_msg->data[1] = lower_32_bits(get_info_addr);
 	tx_msg->data[2] = sizeof(*s_info);
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_GET_INFO_REQ_MSG_SZ,
 			       rx_msg,
@@ -150,7 +150,7 @@ int ele_ping(struct device *dev)
 		goto exit;
 	}
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_PING_REQ_SZ,
 			       rx_msg,
@@ -206,7 +206,7 @@ int ele_service_swap(struct device *dev,
 	tx_msg->data[3] = lower_32_bits(addr);
 	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
 						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
 			       rx_msg,
@@ -268,7 +268,7 @@ int ele_fw_authenticate(struct device *dev, phys_addr_t addr)
 	tx_msg->data[0] = lower_32_bits(addr);
 	tx_msg->data[2] = addr;
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_FW_AUTH_REQ_SZ,
 			       rx_msg,
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index a06d7015d3f1..9114c3594567 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -18,16 +18,18 @@ u32 se_add_msg_crc(u32 *msg, u32 msg_len)
 	return crc;
 }
 
-int ele_msg_rcv(struct se_if_priv *priv,
+int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
 		struct se_clbk_handle *se_clbk_hdl)
 {
+	struct se_if_priv *priv = dev_ctx->priv;
 	int err = 0;
 
 	err = wait_event_interruptible(se_clbk_hdl->wq,
 				       atomic_read(&se_clbk_hdl->pending_hdr) != 0);
 	if (err < 0)
 		dev_err(priv->dev,
-			"Err[0x%x]:Interrupted by signal.\n",
+			"%s: Err[0x%x]:Interrupted by signal.\n",
+			se_clbk_hdl->dev_ctx->devname,
 			err);
 	else
 		err = se_clbk_hdl->rx_msg_sz;
@@ -37,10 +39,11 @@ int ele_msg_rcv(struct se_if_priv *priv,
 	return err;
 }
 
-int ele_msg_send(struct se_if_priv *priv,
+int ele_msg_send(struct se_if_device_ctx *dev_ctx,
 		 void *tx_msg,
 		 int tx_msg_sz)
 {
+	struct se_if_priv *priv = dev_ctx->priv;
 	struct se_msg_hdr *header;
 	int err;
 
@@ -53,7 +56,8 @@ int ele_msg_send(struct se_if_priv *priv,
 	if (header->size << 2 != tx_msg_sz) {
 		err = -EINVAL;
 		dev_err(priv->dev,
-			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			"%s: User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			dev_ctx->devname,
 			*(u32 *)header,
 			header->size << 2, tx_msg_sz);
 		goto exit;
@@ -62,7 +66,9 @@ int ele_msg_send(struct se_if_priv *priv,
 
 	err = mbox_send_message(priv->tx_chan, tx_msg);
 	if (err < 0) {
-		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
+		dev_err(priv->dev,
+			"%s: Error: mbox_send_message failure.",
+			dev_ctx->devname);
 		return err;
 	}
 	err = tx_msg_sz;
@@ -72,24 +78,26 @@ int ele_msg_send(struct se_if_priv *priv,
 }
 
 /* API used for send/receive blocking call. */
-int ele_msg_send_rcv(struct se_if_priv *priv,
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
 		     void *tx_msg,
 		     int tx_msg_sz,
 		     void *rx_msg,
 		     int exp_rx_msg_sz)
 {
 	int err;
+	struct se_if_priv *priv = dev_ctx->priv;
 
 	guard(mutex)(&priv->se_if_cmd_lock);
 
+	priv->waiting_rsp_clbk_hdl.dev_ctx = dev_ctx;
 	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
 	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
 
-	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
+	err = ele_msg_send(dev_ctx, tx_msg, tx_msg_sz);
 	if (err < 0)
 		goto exit;
 
-	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
+	err = ele_msg_rcv(dev_ctx, &priv->waiting_rsp_clbk_hdl);
 exit:
 	return err;
 }
@@ -135,7 +143,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 	if (header->tag == priv->cmd_tag) {
 		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
 		dev_dbg(dev,
-			"Selecting cmd receiver for mesg header:0x%x.",
+			"Selecting cmd receiver:%s for mesg header:0x%x.",
+			se_clbk_hdl->dev_ctx->devname,
 			*(u32 *) header);
 
 		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
@@ -144,7 +153,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 		 */
 		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
 			dev_err(dev,
-				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				"%s: CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				se_clbk_hdl->dev_ctx->devname,
 				*(u32 *) header,
 				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 
@@ -155,13 +165,15 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 	} else if (header->tag == priv->rsp_tag) {
 		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
 		dev_dbg(dev,
-			"Selecting resp waiter for mesg header:0x%x.",
+			"Selecting resp waiter:%s for mesg header:0x%x.",
+			se_clbk_hdl->dev_ctx->devname,
 			*(u32 *) header);
 
 		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz
 				&& !exception_for_size(priv, header)) {
 			dev_err(dev,
-				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				"%s: Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				se_clbk_hdl->dev_ctx->devname,
 				*(u32 *) header,
 				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index b05d62090337..dbfb425b7f98 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -14,12 +14,12 @@
 #define IMX_ELE_FW_DIR                 "imx/ele/"
 
 uint32_t se_add_msg_crc(uint32_t *msg, uint32_t msg_len);
-int ele_msg_rcv(struct se_if_priv *priv,
+int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
 		struct se_clbk_handle *se_clbk_hdl);
-int ele_msg_send(struct se_if_priv *priv,
+int ele_msg_send(struct se_if_device_ctx *dev_ctx,
 		 void *tx_msg,
 		 int tx_msg_sz);
-int ele_msg_send_rcv(struct se_if_priv *priv,
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
 		     void *tx_msg,
 		     int tx_msg_sz,
 		     void *rx_msg,
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
index 82b9fcf25535..247a8dc10c8a 100644
--- a/drivers/firmware/imx/se_ctrl.c
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sys_soc.h>
+#include <uapi/linux/se_ioctl.h>
 
 #include "ele_base_msg.h"
 #include "ele_common.h"
@@ -191,6 +192,696 @@ static int se_soc_info(struct se_if_priv *priv,
 	return 0;
 }
 
+static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int err = 0;
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != SE_IF_CTX_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 *)arg,
+			   sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: User buffer too small(%d < %d)\n",
+			dev_ctx->miscdev.name,
+			cmd_snd_rcv_rsp_info.tx_buf_sz,
+			SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
+	if (!rx_msg) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	tx_msg = memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
+			     cmd_snd_rcv_rsp_info.tx_buf_sz);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	if (tx_msg->header.tag != priv->cmd_tag) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = ele_msg_send_rcv(dev_ctx,
+			       tx_msg,
+			       cmd_snd_rcv_rsp_info.tx_buf_sz,
+			       rx_msg,
+			       cmd_snd_rcv_rsp_info.rx_buf_sz);
+	if (err < 0)
+		goto exit;
+
+	dev_dbg(dev_ctx->priv->dev,
+		"%s: %s %s\n",
+		dev_ctx->devname,
+		__func__,
+		"message received, start transmit to user");
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(&dev_ctx->se_shared_mem_mgmt);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     rx_msg,
+			     cmd_snd_rcv_rsp_info.rx_buf_sz, false);
+
+	if (copy_to_user(cmd_snd_rcv_rsp_info.rx_buf, rx_msg,
+			 cmd_snd_rcv_rsp_info.rx_buf_sz)) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+exit:
+	se_dev_ctx_shared_mem_cleanup(&dev_ctx->se_shared_mem_mgmt);
+
+	if (copy_to_user((void *)arg, &cmd_snd_rcv_rsp_info,
+			 sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->miscdev.name);
+		err = -EFAULT;
+	}
+
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/*
+ * File operations for user-space
+ */
+
+/* Write a message to the MU. */
+static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
+				size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	dev_dbg(priv->dev,
+		"%s: write from buf (%p)%zu, ppos=%lld\n",
+			dev_ctx->miscdev.name,
+			buf, size, ((ppos) ? *ppos : 0));
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != SE_IF_CTX_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (size < SE_MU_HDR_SZ) {
+		dev_err(priv->dev,
+			"%s: User buffer too small(%zu < %d)\n",
+				dev_ctx->miscdev.name,
+				size, SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	tx_msg = memdup_user(buf, size);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     tx_msg, size, false);
+
+	err = ele_msg_send(dev_ctx, tx_msg, size);
+	if (err < 0)
+		goto exit;
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/*
+ * Read a message from the MU.
+ * Blocking until a message is available.
+ */
+static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
+			       size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	dev_dbg(priv->dev,
+		"%s: read to buf %p(%zu), ppos=%lld\n",
+			dev_ctx->miscdev.name,
+			buf, size, ((ppos) ? *ppos : 0));
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != SE_IF_CTX_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = ele_msg_rcv(dev_ctx, &priv->cmd_receiver_clbk_hdl);
+	if (err < 0) {
+		dev_err(dev_ctx->priv->dev,
+				"%s: Err[0x%x]:Interrupted by signal.\n",
+				dev_ctx->devname, err);
+		dev_err(dev_ctx->priv->dev,
+				"Current active dev-ctx count = %d.\n",
+				dev_ctx->priv->active_devctx_count);
+		goto exit;
+	}
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(&dev_ctx->se_shared_mem_mgmt);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     priv->cmd_receiver_clbk_hdl.rx_msg,
+			     priv->cmd_receiver_clbk_hdl.rx_msg_sz,
+			     false);
+
+	if (copy_to_user(buf, priv->cmd_receiver_clbk_hdl.rx_msg,
+			 priv->cmd_receiver_clbk_hdl.rx_msg_sz)) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+	err = priv->cmd_receiver_clbk_hdl.rx_msg_sz;
+exit:
+	priv->cmd_receiver_clbk_hdl.rx_msg_sz = 0;
+
+	se_dev_ctx_shared_mem_cleanup(&dev_ctx->se_shared_mem_mgmt);
+
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
+				u64 arg)
+{
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_if_node_info *if_node_info;
+	struct se_ioctl_get_if_info info;
+	int err = 0;
+
+	if_node_info = (struct se_if_node_info *)priv->info;
+
+	info.se_if_id = if_node_info->se_if_id;
+	info.interrupt_idx = 0;
+	info.tz = 0;
+	info.did = if_node_info->se_if_did;
+	info.cmd_tag = if_node_info->cmd_tag;
+	info.rsp_tag = if_node_info->rsp_tag;
+	info.success_tag = if_node_info->success_tag;
+	info.base_api_ver = if_node_info->base_api_ver;
+	info.fw_api_ver = if_node_info->fw_api_ver;
+
+	dev_dbg(priv->dev,
+		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
+			dev_ctx->miscdev.name,
+			info.se_if_id, info.interrupt_idx, info.tz, info.did);
+
+	if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy mu info to user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+static int init_se_shared_mem(struct se_shared_mem_mgmt_info *se_shared_mem_mgmt)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(se_shared_mem_mgmt,
+							typeof(*dev_ctx),
+							se_shared_mem_mgmt);
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_out);
+	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_in);
+
+	/*
+	 * Allocate some memory for data exchanges with S40x.
+	 * This will be used for data not requiring secure memory.
+	 */
+	se_shared_mem_mgmt->non_secure_mem.ptr
+			= dma_alloc_coherent(priv->dev,
+					     MAX_DATA_SIZE_PER_USER,
+					     &se_shared_mem_mgmt->non_secure_mem.dma_addr,
+					     GFP_KERNEL);
+	if (!se_shared_mem_mgmt->non_secure_mem.ptr)
+		return -ENOMEM;
+
+	se_shared_mem_mgmt->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+
+	return 0;
+}
+
+static void cleanup_se_shared_mem(struct se_shared_mem_mgmt_info *se_shared_mem_mgmt)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(se_shared_mem_mgmt,
+							typeof(*dev_ctx),
+							se_shared_mem_mgmt);
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	/* Unmap secure memory shared buffer. */
+	if (se_shared_mem_mgmt->secure_mem.ptr)
+		devm_iounmap(priv->dev,
+				se_shared_mem_mgmt->secure_mem.ptr);
+
+	se_shared_mem_mgmt->secure_mem.ptr = NULL;
+	se_shared_mem_mgmt->secure_mem.dma_addr = 0;
+	se_shared_mem_mgmt->secure_mem.size = 0;
+	se_shared_mem_mgmt->secure_mem.pos = 0;
+
+	/* Free non-secure shared buffer. */
+	dma_free_coherent(priv->dev, MAX_DATA_SIZE_PER_USER,
+			  se_shared_mem_mgmt->non_secure_mem.ptr,
+			  se_shared_mem_mgmt->non_secure_mem.dma_addr);
+
+	se_shared_mem_mgmt->non_secure_mem.ptr = NULL;
+	se_shared_mem_mgmt->non_secure_mem.dma_addr = 0;
+	se_shared_mem_mgmt->non_secure_mem.size = 0;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+}
+
+/* Need to copy the output data to user-device context.
+ */
+int se_dev_ctx_cpy_out_data(struct se_shared_mem_mgmt_info *se_shared_mem_mgmt)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(se_shared_mem_mgmt,
+							typeof(*dev_ctx),
+							se_shared_mem_mgmt);
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_buf_desc *b_desc, *temp;
+	bool do_cpy = true;
+
+	list_for_each_entry_safe(b_desc, temp, &se_shared_mem_mgmt->pending_out, link) {
+		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr && do_cpy) {
+
+			dev_dbg(priv->dev,
+				"Copying output data to user.");
+			if (do_cpy && copy_to_user(b_desc->usr_buf_ptr,
+					 b_desc->shared_buf_ptr,
+					 b_desc->size)) {
+				dev_err(priv->dev,
+					"Failure copying output data to user.");
+				do_cpy = false;
+			}
+		}
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		list_del(&b_desc->link);
+		kfree(b_desc);
+	}
+
+	return do_cpy ? 0 : -EFAULT;
+}
+
+/*
+ * Clean the used Shared Memory space,
+ * whether its Input Data copied from user buffers, or
+ * Data received from FW.
+ */
+void se_dev_ctx_shared_mem_cleanup(struct se_shared_mem_mgmt_info *se_shared_mem_mgmt)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(se_shared_mem_mgmt,
+							typeof(*dev_ctx),
+							se_shared_mem_mgmt);
+	struct list_head *pending_lists[] = {&se_shared_mem_mgmt->pending_in,
+						&se_shared_mem_mgmt->pending_out};
+	struct se_buf_desc *b_desc, *temp;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		list_for_each_entry_safe(b_desc, temp,
+					 pending_lists[i], link) {
+
+			if (b_desc->shared_buf_ptr)
+				memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+			list_del(&b_desc->link);
+			kfree(b_desc);
+		}
+	}
+	se_shared_mem_mgmt->secure_mem.pos = 0;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+}
+
+static int add_b_desc_to_pending_list(void *shared_ptr_with_pos,
+			       struct se_ioctl_setup_iobuf *io,
+			       struct se_shared_mem_mgmt_info *se_shared_mem_mgmt)
+{
+	struct se_buf_desc *b_desc = NULL;
+
+	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
+	if (!b_desc)
+		return -ENOMEM;
+
+	if (b_desc) {
+		b_desc->shared_buf_ptr = shared_ptr_with_pos;
+		b_desc->usr_buf_ptr = io->user_buf;
+		b_desc->size = io->length;
+
+		if (io->flags & SE_IO_BUF_FLAGS_IS_INPUT) {
+			/*
+			 * buffer is input:
+			 * add an entry in the "pending input buffers" list so
+			 * that copied data can be cleaned from shared memory
+			 * later.
+			 */
+			list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_in);
+		} else {
+			/*
+			 * buffer is output:
+			 * add an entry in the "pending out buffers" list so data
+			 * can be copied to user space when receiving Secure-Enclave
+			 * response.
+			 */
+			list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_out);
+		}
+	}
+
+
+	return 0;
+}
+
+/*
+ * Copy a buffer of data to/from the user and return the address to use in
+ * messages
+ */
+static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_shared_mem *shared_mem = NULL;
+	struct se_ioctl_setup_iobuf io = {0};
+	int err = 0;
+	u32 pos;
+
+	if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed copy iobuf config from user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	dev_dbg(dev_ctx->priv->dev,
+			"%s: io [buf: %p(%d) flag: %x]\n",
+			dev_ctx->miscdev.name,
+			io.user_buf, io.length, io.flags);
+
+	if (io.length == 0 || !io.user_buf) {
+		/*
+		 * Accept NULL pointers since some buffers are optional
+		 * in FW commands. In this case we should return 0 as
+		 * pointer to be embedded into the message.
+		 * Skip all data copy part of code below.
+		 */
+		io.ele_addr = 0;
+		goto copy;
+	}
+
+	/* No specific requirement for this buffer. */
+	shared_mem = &dev_ctx->se_shared_mem_mgmt.non_secure_mem;
+
+	/* Check there is enough space in the shared memory. */
+	if (shared_mem->size < shared_mem->pos ||
+		round_up(io.length, 8u) >= (shared_mem->size - shared_mem->pos)) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Not enough space in shared memory\n",
+				dev_ctx->miscdev.name);
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/* Allocate space in shared memory. 8 bytes aligned. */
+	pos = shared_mem->pos;
+	shared_mem->pos += round_up(io.length, 8u);
+	io.ele_addr = (u64)shared_mem->dma_addr + pos;
+
+	memset(shared_mem->ptr + pos, 0, io.length);
+	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
+	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
+		/*
+		 * buffer is input:
+		 * copy data from user space to this allocated buffer.
+		 */
+		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
+				   io.length)) {
+			dev_err(dev_ctx->priv->dev,
+				"%s: Failed copy data to shared memory\n",
+				dev_ctx->miscdev.name);
+			err = -EFAULT;
+			goto exit;
+		}
+	}
+
+	err = add_b_desc_to_pending_list(shared_mem->ptr + pos,
+					 &io,
+					 &dev_ctx->se_shared_mem_mgmt);
+	if (err < 0)
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to allocate/link b_desc.",
+				dev_ctx->miscdev.name);
+
+copy:
+	/* Provide the EdgeLock Enclave address to user space only if success.*/
+	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy iobuff setup to user.",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+exit:
+	return err;
+}
+
+/* IOCTL to provide SoC information */
+static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
+					     u64 arg)
+{
+	const struct se_if_node_info_list *info_list;
+	struct se_ioctl_get_soc_info soc_info;
+	int err = -EINVAL;
+
+	info_list = device_get_match_data(dev_ctx->priv->dev);
+	if (!info_list)
+		goto exit;
+
+	soc_info.soc_id = info_list->soc_id;
+	soc_info.soc_rev = dev_ctx->priv->soc_rev;
+
+	err = (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(soc_info));
+	if (err) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy soc info to user\n",
+			dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/* Open a character device. */
+static int se_if_fops_open(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
+							struct se_if_device_ctx,
+							miscdev);
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err = 0;
+
+	priv->dev_ctx_mono_count++;
+	err = init_device_context(priv,
+				  priv->dev_ctx_mono_count ?
+					priv->dev_ctx_mono_count
+					: priv->dev_ctx_mono_count++,
+				  &dev_ctx);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed[0x%x] to create device contexts.\n",
+			err);
+		goto exit;
+	}
+
+	dev_ctx->status = SE_IF_CTX_OPENED;
+
+	fp->private_data = dev_ctx;
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Close a character device. */
+static int se_if_fops_close(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	/* Avoid race if closed at the same time */
+	if (down_trylock(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* The device context has not been opened */
+	if (dev_ctx->status != SE_IF_CTX_OPENED)
+		goto exit;
+
+	/* check if this device was registered as command receiver. */
+	if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {
+		priv->cmd_receiver_clbk_hdl.dev_ctx = NULL;
+		kfree(priv->cmd_receiver_clbk_hdl.rx_msg);
+		priv->cmd_receiver_clbk_hdl.rx_msg = NULL;
+		atomic_set(&priv->cmd_receiver_clbk_hdl.pending_hdr, 0);
+	}
+
+	/* check if this device was registered as waiting response. */
+	if (priv->waiting_rsp_clbk_hdl.dev_ctx == dev_ctx) {
+		priv->waiting_rsp_clbk_hdl.dev_ctx = NULL;
+		mutex_unlock(&priv->se_if_cmd_lock);
+	}
+
+	se_dev_ctx_shared_mem_cleanup(&dev_ctx->se_shared_mem_mgmt);
+	cleanup_se_shared_mem(&dev_ctx->se_shared_mem_mgmt);
+	dev_ctx->status = SE_IF_CTX_FREE;
+
+	priv->active_devctx_count--;
+	list_del(&dev_ctx->link);
+exit:
+	up(&dev_ctx->fops_lock);
+	kfree(dev_ctx->devname);
+	kfree(dev_ctx);
+
+	return 0;
+}
+
+/* IOCTL entry point of a character device */
+static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	/* Prevent race during change of device context */
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	switch (cmd) {
+	case SE_IOCTL_ENABLE_CMD_RCV:
+		if (!priv->cmd_receiver_clbk_hdl.dev_ctx) {
+			if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
+				priv->cmd_receiver_clbk_hdl.rx_msg
+					= kzalloc(MAX_NVM_MSG_LEN,
+						  GFP_KERNEL);
+				if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
+					err = -ENOMEM;
+					break;
+				}
+			}
+			priv->cmd_receiver_clbk_hdl.rx_msg_sz = MAX_NVM_MSG_LEN;
+			priv->cmd_receiver_clbk_hdl.dev_ctx = dev_ctx;
+			err = 0;
+		} else {
+			err = -EBUSY;
+		}
+		break;
+	case SE_IOCTL_GET_MU_INFO:
+		err = se_ioctl_get_mu_info(dev_ctx, arg);
+		break;
+	case SE_IOCTL_SETUP_IOBUF:
+		err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_GET_SOC_INFO:
+		err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_CMD_SEND_RCV_RSP:
+		err = se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
+		break;
+	default:
+		err = -EINVAL;
+		dev_dbg(priv->dev,
+			"%s: IOCTL %.8x not supported\n",
+				dev_ctx->miscdev.name,
+				cmd);
+	}
+
+	up(&dev_ctx->fops_lock);
+
+	return (long)err;
+}
+
+/* Char driver setup */
+static const struct file_operations se_if_fops = {
+	.open		= se_if_fops_open,
+	.owner		= THIS_MODULE,
+	.release	= se_if_fops_close,
+	.unlocked_ioctl = se_ioctl,
+	.read		= se_if_fops_read,
+	.write		= se_if_fops_write,
+};
+
+/* interface for managed res to unregister a character device */
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
 /* interface for managed res to free a mailbox channel */
 static void if_mbox_free_channel(void *mbox_chan)
 {
@@ -226,6 +917,7 @@ static int se_if_request_channel(struct device *dev,
 
 static void se_if_probe_cleanup(struct platform_device *pdev)
 {
+	struct se_if_device_ctx *dev_ctx, *t_dev_ctx;
 	struct device *dev = &pdev->dev;
 	struct se_if_priv *priv;
 
@@ -247,6 +939,14 @@ static void se_if_probe_cleanup(struct platform_device *pdev)
 		priv->imem.buf = NULL;
 	}
 
+	list_for_each_entry_safe(dev_ctx, t_dev_ctx, &priv->dev_ctx_list, link) {
+		list_del(&dev_ctx->link);
+		priv->active_devctx_count--;
+	}
+
+	devm_remove_action(dev, if_misc_deregister, &priv->priv_dev_ctx->miscdev);
+	misc_deregister(&priv->priv_dev_ctx->miscdev);
+
 	/* No need to check, if reserved memory is allocated
 	 * before calling for its release. Or clearing the
 	 * un-set bit.
@@ -254,6 +954,87 @@ static void se_if_probe_cleanup(struct platform_device *pdev)
 	of_reserved_mem_device_release(dev);
 }
 
+int init_device_context(struct se_if_priv *priv, int ch_id,
+			struct se_if_device_ctx **new_dev_ctx)
+{
+	const struct se_if_node_info *info = priv->info;
+	struct se_if_device_ctx *dev_ctx;
+	int ret = 0;
+
+	if (ch_id)
+		dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
+	else
+		dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
+
+	if (!dev_ctx) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	dev_ctx->status = SE_IF_CTX_FREE;
+	dev_ctx->priv = priv;
+
+	if (ch_id)
+		dev_ctx->devname = kasprintf(GFP_KERNEL, "%s_ch%d",
+					     info->se_name, ch_id);
+	else
+		dev_ctx->devname = devm_kasprintf(priv->dev,
+						  GFP_KERNEL, "%s_ch%d",
+						  info->se_name, ch_id);
+	if (!dev_ctx->devname) {
+		ret = -ENOMEM;
+		if (ch_id)
+			kfree(dev_ctx);
+
+		return ret;
+	}
+
+	sema_init(&dev_ctx->fops_lock, 1);
+
+	*new_dev_ctx = dev_ctx;
+
+	if (ch_id) {
+		list_add_tail(&dev_ctx->link, &priv->dev_ctx_list);
+		priv->active_devctx_count++;
+
+		ret = init_se_shared_mem(&dev_ctx->se_shared_mem_mgmt);
+		if (ret < 0) {
+			kfree(dev_ctx->devname);
+			kfree(dev_ctx);
+			*new_dev_ctx = NULL;
+			return ret;
+		}
+
+		return ret;
+	}
+
+	/* Only for ch_id = 0:
+	 * - register the misc device.
+	 * - add action
+	 */
+	dev_ctx->miscdev.name = dev_ctx->devname;
+	dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
+	dev_ctx->miscdev.fops = &se_if_fops;
+	dev_ctx->miscdev.parent = priv->dev;
+	ret = misc_register(&dev_ctx->miscdev);
+	if (ret) {
+		dev_err(priv->dev, "failed to register misc device %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = devm_add_action(priv->dev, if_misc_deregister,
+			      &dev_ctx->miscdev);
+	if (ret) {
+		dev_err(priv->dev,
+			"failed[%d] to add action to the misc-dev\n",
+			ret);
+		misc_deregister(&dev_ctx->miscdev);
+	}
+
+	return ret;
+}
+
 static void se_load_firmware(const struct firmware *fw, void *context)
 {
 	struct se_if_priv *priv = context;
@@ -396,6 +1177,7 @@ static int se_if_probe(struct platform_device *pdev)
 	priv->success_tag = info->success_tag;
 	priv->base_api_ver = info->base_api_ver;
 	priv->fw_api_ver = info->fw_api_ver;
+	INIT_LIST_HEAD(&priv->dev_ctx_list);
 	spin_lock_init(&priv->lock);
 
 	if (info->reserved_dma_ranges) {
@@ -408,6 +1190,14 @@ static int se_if_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = init_device_context(priv, 0, &priv->priv_dev_ctx);
+	if (ret) {
+		dev_err(dev,
+			"Failed[0x%x] to create device contexts.\n",
+			ret);
+		goto exit;
+	}
+
 	ret = se_soc_info(priv, info_list);
 	if (ret) {
 		dev_err(dev,
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
index 95050d3c7c88..08a5818aeaa5 100644
--- a/drivers/firmware/imx/se_ctrl.h
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -13,6 +13,7 @@
 #define MAX_FW_LOAD_RETRIES		50
 
 #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
 #define MAX_NVM_MSG_LEN			(256)
 #define MESSAGING_VERSION_6		0x6
 #define MESSAGING_VERSION_7		0x7
@@ -29,6 +30,7 @@
 				dev_of_node->full_name[strlen(NODE_NAME) + 2]) : 0)
 
 struct se_clbk_handle {
+	struct se_if_device_ctx *dev_ctx;
 	wait_queue_head_t wq;
 	atomic_t pending_hdr;
 	u32 rx_msg_sz;
@@ -45,6 +47,48 @@ struct se_imem_buf {
 	u32 state;
 };
 
+struct se_buf_desc {
+	u8 *shared_buf_ptr;
+	u8 *usr_buf_ptr;
+	u32 size;
+	struct list_head link;
+};
+
+/* Status of a char device */
+enum se_if_dev_ctx_status_t {
+	SE_IF_CTX_FREE,
+	SE_IF_CTX_OPENED
+};
+
+struct se_shared_mem {
+	dma_addr_t dma_addr;
+	u32 size;
+	u32 pos;
+	u8 *ptr;
+};
+
+struct se_shared_mem_mgmt_info {
+	struct list_head pending_in;
+	struct list_head pending_out;
+
+	struct se_shared_mem secure_mem;
+	struct se_shared_mem non_secure_mem;
+};
+
+/* Private struct for each char device instance. */
+struct se_if_device_ctx {
+	struct se_if_priv *priv;
+	struct miscdevice miscdev;
+	const char *devname;
+
+	enum se_if_dev_ctx_status_t status;
+	struct semaphore fops_lock;
+
+	struct se_shared_mem_mgmt_info se_shared_mem_mgmt;
+	struct notifier_block se_notify;
+	struct list_head link;
+};
+
 /* Header of the messages exchange with the EdgeLock Enclave */
 struct se_msg_hdr {
 	u8 ver;
@@ -61,6 +105,7 @@ struct se_api_msg {
 };
 
 struct se_if_priv {
+	struct se_if_device_ctx *priv_dev_ctx;
 	struct se_clbk_handle cmd_receiver_clbk_hdl;
 	/* Update to the waiting_rsp_dev, to be protected
 	 * under se_if_lock.
@@ -77,6 +122,9 @@ struct se_if_priv {
 	 * still processing. (response to a command is allowed)
 	 */
 	struct mutex se_if_cmd_lock;
+	struct list_head dev_ctx_list;
+	u32 active_devctx_count;
+	u32 dev_ctx_mono_count;
 	struct device *dev;
 	struct gen_pool *mem_pool;
 	u8 cmd_tag;
@@ -96,4 +144,8 @@ struct se_if_priv {
 	u8 *se_img_file_to_load;
 };
 
+int se_dev_ctx_cpy_out_data(struct se_shared_mem_mgmt_info *se_shared_mem_mgmt);
+void se_dev_ctx_shared_mem_cleanup(struct se_shared_mem_mgmt_info *se_shared_mem_mgmt);
+int init_device_context(struct se_if_priv *priv, int ch_id,
+			struct se_if_device_ctx **new_dev_ctx);
 #endif
diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
new file mode 100644
index 000000000000..c2d0a92ef626
--- /dev/null
+++ b/include/uapi/linux/se_ioctl.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef SE_IOCTL_H
+#define SE_IOCTL_H
+
+/* IOCTL definitions. */
+
+struct se_ioctl_setup_iobuf {
+	u8 *user_buf;
+	u32 length;
+	u32 flags;
+	u64 ele_addr;
+};
+
+struct se_ioctl_shared_mem_cfg {
+	u32 base_offset;
+	u32 size;
+};
+
+struct se_ioctl_get_if_info {
+	u8 se_if_id;
+	u8 interrupt_idx;
+	u8 tz;
+	u8 did;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+};
+
+struct se_ioctl_cmd_snd_rcv_rsp_info {
+	u32 *tx_buf;
+	int tx_buf_sz;
+	u32 *rx_buf;
+	int rx_buf_sz;
+};
+
+struct se_ioctl_get_soc_info {
+	u16 soc_id;
+	u16 soc_rev;
+};
+
+/* IO Buffer Flags */
+#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
+#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
+#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
+#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
+#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
+
+/* IOCTLS */
+#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
+
+/*
+ * ioctl to designated the current fd as logical-reciever.
+ * This is ioctl is send when the nvm-daemon, a slave to the
+ * firmware is started by the user.
+ */
+#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
+
+/*
+ * ioctl to get the buffer allocated from the memory, which is shared
+ * between kernel and FW.
+ * Post allocation, the kernel tagged the allocated memory with:
+ *  Output
+ *  Input
+ *  Input-Output
+ *  Short address
+ *  Secure-memory
+ */
+#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
+					struct se_ioctl_setup_iobuf)
+
+/*
+ * ioctl to get the mu information, that is used to exchange message
+ * with FW, from user-spaced.
+ */
+#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
+					struct se_ioctl_get_if_info)
+/*
+ * ioctl to get SoC Info from user-space.
+ */
+#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
+					struct se_ioctl_get_soc_info)
+
+/*
+ * ioctl to send command and receive response from user-space.
+ */
+#define SE_IOCTL_CMD_SEND_RCV_RSP _IOWR(SE_IOCTL, 0x07, \
+					struct se_ioctl_cmd_snd_rcv_rsp_info)
+#endif

-- 
2.34.1


