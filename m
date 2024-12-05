Return-Path: <linux-kernel+bounces-433723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC699E5C2C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD96D287A25
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B742B224AF6;
	Thu,  5 Dec 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c33WNS/K"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9F226EEF;
	Thu,  5 Dec 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417499; cv=fail; b=NINMUjs9vtHCkd0+Z5+SklvhC4bFGSRawbZFfu7+i3b9eFfhe6cjhY2dnP6VilV6siLH8UC6yrf+7IqfDVpP/y+eUZagDMRKwPcR9cMmCPaOZwbKfJnhrHvOBEvYNLIJVVeitgVHFQJZsvJ6FaNEbc32QtBDl0Y3/hazkeWKwr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417499; c=relaxed/simple;
	bh=a+/tdvfNrna1Hxq1r+zVZqlrUGxbeu/wyD9Dmoa9nNQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CLmEjek3MV8vskEVtOGjrZncLgSO4VtDjiCMf5j8cx2TWk7FtFTOsEmXUAfnIx1TajvU6Ab7FiOcewleaiGDhU9oXurhG76rWhLkkWAEXZh6xHzsv5h3lokxGm1h8allPKKKJDKhKI4jNO7tX6/aRApqYMyVWjXPYoxjb5hyDP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c33WNS/K; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euZUYETpnlbVgx1Y/ZiNbk5O6UqVw0ChMtXX4xBNusWgLPxsd+iYAH3sa6+vHnhvMAD0wVlUv70FbNCjuHc+oX1ZUHp1yxxucFAdddgTKSPlZvULWAB5JSMWfmOazv1yTDxRPH908qVN/YTFvSAIfd+SXQSQTxzZZele+x2UHV4DjwsIJ4GMaMXOKmCeQBHVxNXtUHepjKFaZywXa6z5BDHbx5Hr+wy0OLogu2Noz6UwVYGAGq7Z8B37JdCjBwCLK/FSzKc/eWpQtKPH7pb55ambjcHZ0XRuaaJdCmz/ejODzK8cA3NFrXHGRxfIEuDkm9IfJCPRW5rThwDuilmUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLDBtNfni/M0yr6E6A9udqNvO4y+WKxsbN6N+QmozXQ=;
 b=Rq5+DQ+Bs3e8/yEGLDMFgOE8fkCu+bnXwy0UEemwLNoDgYBkRpScjL5DL8eFIEG5QfsdIMfLiX97Ytlws/yUXv/o0ju7h0ITc4TA0joq+JhNjsvn3p2PlSjlNGoyYsXSyXgTqqZ6wcqzZu+Kl1aUrW/+BOymyCGkMQ/z1CvrwbcL4sx9grnt9f5KOL7uUquCAgAc9YYl+EYdB5Ej5vurMEl8uWF+NSpbj2blxdd3sQApI7CnHNeCKhJq8g6wINlVjZo1dMPeSNTIaeAGg/31RYr5xdCRUQIlFGKcvhO+jhPhuT9DnOGlz5Hl7ogiN3sZpbkPkp+Ob8blQ1s43uXkGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLDBtNfni/M0yr6E6A9udqNvO4y+WKxsbN6N+QmozXQ=;
 b=c33WNS/KfisrULUGfVAvZeFW0GbE6Uhql+OUdrhu5OzKPJkwYsqC9RI9nVb3imWD58idRpjtCwHMJ1uJMuTXuXYOHvf78f1A1W2HWESWL48tnuhuRXpes28SZ4RjN1ClPXBOSxLkY/JDRFrvBSsFthTpDyO6CF+LZWFE8Dveh92TpFdbsT5IV4+TpxncqlfApCDxJUA44RwypLgjSnrT3alLEuu7br5K1NXBZl8CpoUxatxh7THFKQTLlVda/42lIr7eCgRYH1Pbl3i7ioY7uP4/v5P471VaLC5Av9+eEvFGcIrM/kjVF6G7d50RV8twA2Uka8fqi2+VdtDkOaXKrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.13; Thu, 5 Dec
 2024 16:51:34 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 16:51:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 05 Dec 2024 11:51:10 -0500
Subject: [PATCH 2/5] regulator: pca9450: Use dev_err_probe() to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pca9450-v1-2-aab448b74e78@nxp.com>
References: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
In-Reply-To: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733417480; l=5056;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=a+/tdvfNrna1Hxq1r+zVZqlrUGxbeu/wyD9Dmoa9nNQ=;
 b=SYZYkK/PEqkwMefZC7ZooIhhLiJ/UCY8lzC4yOl4E83iuDh923XrnTWkcwNCeTGLkAShsBAta
 IGSacrTzwH5D5LKTDq2HfaIRE/0vAfbCkanfgs+DT4z7IisWh0BTZQt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: e59cf302-1fd8-4f24-6375-08dd154d1344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djRwOEZLMzlaMjBuQVYzdUQxUXR3MjlCa0cyUzJRZTNDblZiQm9kVEUwR1VR?=
 =?utf-8?B?UGcxVSs5Yy8xOVJDNW1PTU9DMlRDV0JJdUlnTW1QYWRsdE9wc3lpSGpqNkZB?=
 =?utf-8?B?RWQwTHZRUEo4Rmlsb200Z1ZSRW1CZ0xZa3hQOGo5ck9rTG5pYm02WlYzVWF2?=
 =?utf-8?B?SG5DdjJSN2dJTkxVWGE1a3kzYWZQS0hnRFdzVGNxTVBtWWRaUmN6bHhWTkxF?=
 =?utf-8?B?RTk0dzhFcms4OEZzMlpNa05YVzR5R2p3YVRIQVhzUDdHTUhueFRweFREcUhM?=
 =?utf-8?B?QzVtWGtvSmFNK3BSZld5QWZpU09QUytjUjBnT3ZYNmZmU29QMyt4US9vNloy?=
 =?utf-8?B?MEhNS2xyLy91YjZGRGNMSDI0VDVPVS9rWG1JNUZsOTAxNmRzVldwc1JSVTBj?=
 =?utf-8?B?NkJtOTNTQVYyN3dHRkhqbm0zNzZRdlRtZVhOdHdRSk5POWl0L3ZYbmJWS2Zp?=
 =?utf-8?B?NW5NUVN6QlBCVkZ6a1JQUk0ySVQrb2RsNkR3MzBrTE9MTGxGd1Q1R0xSOVVK?=
 =?utf-8?B?Z1V4dCt0TFRIRDkzTGN0YWJLem9GdmEyd3ovK3ZRL21tUzlvZ3JuN3RGdHkw?=
 =?utf-8?B?aXZHbEVzMlBvOGJWaytoVE5BVElHcnJIY1h6YjZEbVNES09IRERKUUdDMHpi?=
 =?utf-8?B?UnBzWW1wV1k1d0FMR3ZHVlBMSEF6RTZQNC8zRkhiMmZuWGJLeDZyTmZrclpB?=
 =?utf-8?B?cVBZVzh3N1pic0hBUFJrTExFRXRhWnBWbzdrSGdZUCtDM0lsamliNkZVK09n?=
 =?utf-8?B?MERtOGhnQnY2VklGQUNUd0M0Z3JPKzh2cmQ1bGFRTDdZaXZubTlFSWgyU2kv?=
 =?utf-8?B?TlNVdHd5RmwrNkJPZWdhV0ErR1hGTUpra2xHOUF2K1QwVGU5T01wQWZHZGQ1?=
 =?utf-8?B?cHdXTTM0ZzM2ZERZMVpGOXlPL1YrWmJENzBQbVpBM1Y5eVFTZnlOcS9nellU?=
 =?utf-8?B?aTlIVjJxYmVPWm00OEFxb0MrSU8wOUJ5cmU0WkZWL0poVFF6QkJ3QWtiMGlm?=
 =?utf-8?B?SjZFK0crVVZMSkY5a1BuMEF1eGkvVUlJMmhodUI0MWtQZUdPQmlKUnZ0dHpn?=
 =?utf-8?B?UkZiOCt6RGJNQk5ScnlBcWNsUGx0dUhtLzY3TmVDZHhSdTkwRFVQSE1FMGRo?=
 =?utf-8?B?NWpWUWFOUU5CYjBFUEU3a0wzVkQwcnh0cU1kNGZxZFhHcHhGdGpEYXNTZWwx?=
 =?utf-8?B?NUhFak1wdzNtT0V4ZWo2c1BuajZkOVVtWTNYNE42THJmUDFIRzBYMVFmVzRz?=
 =?utf-8?B?a0xoK3FQQUJyODgyeHRpSG4xUXhTV3hDUlQxN3l4bWJaS0gzd3Vqb3I3SG45?=
 =?utf-8?B?Z1FyVk9TekF4K3hZMjliN2FLMDQxd0xEK3dvNkw5Rkw4bEVyY2ZtWDdBelpm?=
 =?utf-8?B?WWd4SEFrcGlmR01UNEl3ODh2SmRsNmpHYno5VmQvN0ZCalBUKzU2UHk4SDRD?=
 =?utf-8?B?S2FOeFVTVHlpTmdZQ2JSL1pPVzZSZjNyUE9CT0NlMDVpVFNhNm9VUzZwT1dH?=
 =?utf-8?B?cU5MY3FRUWU5UjhBYkd4RlBJL3Y5TGRLcVBxYTFBSnlCVkl4ZVJnaVowM01v?=
 =?utf-8?B?VzdhTGdTMlYwVWVINXh3TnF3aklhQU00eEU1VDgwUFIvdzhnT2RWdXN1VkJ0?=
 =?utf-8?B?MnpuZythYVd0djhiVUxWNmVuNnA1N1dzcXp6T1BibjBtei9kVUFiQU8rRDdx?=
 =?utf-8?B?T0Jjd0xtazc4T0NydmRWbGtZeWFOKyttN1dWTUJMSFVzK0ROUlBSMTB1VktE?=
 =?utf-8?B?QVI0RTBTUXJ0bGw1MHNIT3FrWFlsdXBQMVl5V1NNbC9LN0Y5YzJoOE5XNGhw?=
 =?utf-8?B?Y1R3clc1VVZDSWxrMFNQY0g4Vmg4cFVPeDR1eDAwbGtxODc4c2NxbVlRaDlX?=
 =?utf-8?B?NDRIUkc4bDl0a1BiU2dHQ0g4aWdLeDJYZUJLNGdzbjRSclBHdzdpK1RxN2pF?=
 =?utf-8?Q?Doz+AerXSo8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rngya2ZBSU5zVDdqZEozZno5b3ZiNldQMVZHQWg2c1U5bnN5M3N6bTRiNzhC?=
 =?utf-8?B?S3RBM3pGVE9SVm0vMFlaVDdIY1dueHliZFVjcUp5QTJzdW9KUmpDdHBFYUx4?=
 =?utf-8?B?cHhFTFl1ZGpqaWZUSXdhNloxVEx6MStzMjZsaDRpbUIxUnRNNGNwcDk0VEdu?=
 =?utf-8?B?S0RLKzQrQlovZW9DV0t1a0IwYlBvanQzV3VDVlFjN1FJYXBpM3lrTU5EY25V?=
 =?utf-8?B?U0orekN4a1pMQVgwY1gyaG9XWC85WjR6STc1a1VVR1NTZHF5RjdGdDlFVHU5?=
 =?utf-8?B?TTBKVzhNczNYbHoyMHlKZTBsZmtVOU9BRXVjZzZoSEFrT1ZkSXVCK21DRFhX?=
 =?utf-8?B?bmZ3dDJGa1BIaFNHdHlrTHlNalVNWHZWYlNDVVluMExPNHNBMUpDZzhaNWtV?=
 =?utf-8?B?OUhSRU9tNnUwZzNPUkxnVkdaeTBzbWNKc1U2VkVZbm4rUHRrVzdRS2xlZ1pT?=
 =?utf-8?B?d0dhbHdlQkxLazFKaEFKYTdDU2tDOUoydFU1R2c0angxL3ZIdUo4WnJhanpN?=
 =?utf-8?B?bFMyeHowcXhiclI5RUpkeHArdGM4eVNuVXFSTmxuMkJKMlFVZUkwR0R2K0Uy?=
 =?utf-8?B?RnR2Z1ZLUnloSXpqeE9tVWdIcnJGbk5UT3h0aEx4ZWkxOWRhMFgyNVZ0OCtx?=
 =?utf-8?B?NlQ3cmx0RGZMRnlXV3NBL0lsN1BENVlkQnFzajdLaXRDWjYyZjd4WXhrK2dp?=
 =?utf-8?B?c1JvOWMzNEoweGVTZzE1WXl2OXU0SHpZNlJ3V2JQOUl4V3RjRjFXU01LQWt1?=
 =?utf-8?B?QS9LVElnVnNrclYxbkNjSE0xZG81SjFTUk00MFRwdFlPVGc5L2N3cW1mb3RW?=
 =?utf-8?B?L284TU80ZUtnRTBBUjFsRG1uR1JnMGNXY01RRS9pWTA2Qk5zWHdRL1I4Y21n?=
 =?utf-8?B?UEhvUVBnZDBHaFhmNTVxUnF4OURCUVdhcGJhNEwvOUw2cGJDbllhZHV0Wkpv?=
 =?utf-8?B?cGZtKzNld1pPckRvNG9sM0dwTG5YNllNeGM2WkFaT0xQQ29SVzAxUTF6WUJj?=
 =?utf-8?B?c3MvcDlUSkxhRi9EeFpZd2p2T1dQK0FoajF0V3BxRVhYeWIxQU5yMUR2Wk56?=
 =?utf-8?B?ZTRpcEFDdG1jYUJyUVNYbjhTQll0ME5CRkRMYTVaY1BkdXBCZHFvbnN5dXZF?=
 =?utf-8?B?cVZXWlp2VTdoVWVXS05MQ0pzSGhhdHNYbXlMVFdBcGZIVWVVYWcrT3BaRXdE?=
 =?utf-8?B?REpSMlUyc25NRjBPL3lHT3pycitaYXRZVVI4Z2k4VzNDOTM0L0xBN0R4dnBO?=
 =?utf-8?B?NW81NFlZWDBlbWE0azRLQU1FdHBOTEtRTE5IZHFZVjlYY3ltU0x0R2RzalRC?=
 =?utf-8?B?NFAyYzljUHZpYklueFJxR0ozdXdJOHNHQ1N6VU1pSDd3YmxXblRoQjRNRXQ0?=
 =?utf-8?B?dlpvOGVZdnB6bHZqSUpoL0NFUmdmSkxVRTB4V2xKZ1ljVlJPNkt2RDNFd2Ri?=
 =?utf-8?B?QmNhTlZ4MDRQK0MrL3VSMXd5MkVORjMwMmwzSnpaMkZHT2QwS24xd1V1UHRH?=
 =?utf-8?B?clF5eFA2YktQRktiNXB4WEVnQzVNeWFLN0JYaGxvbHZ5cHNvK3cyUTNvdHpl?=
 =?utf-8?B?aXFTWkkyS0c0Rmd1VGtVNm4wRlJyQlovZmI2Uld3bnFRU1hsOTVUZ29IWmtz?=
 =?utf-8?B?T2p2UVNUVjgrWTMwMFpleEErNmtBSVl4UGhTcWxRL3l5VWVQNjRJUGtxRkdq?=
 =?utf-8?B?bWpGSm4vRDlVMmpNNGYwa1VHeFJ4ZFJDbFFpbm9hU0R5NXJOaUpRa0w4Tzc1?=
 =?utf-8?B?ejRoYi95OGtNbEpxVGM5dFY4MWpCZlc4UXR2NHlLLzZ4UmY1clY2TE1uSTRV?=
 =?utf-8?B?aVBGczJuSGFUR3NjeEJqTXBCK1hGRk9od0g5VlcxaEVubHpmaFBjd2NwTHZ3?=
 =?utf-8?B?YVBtaXJlamFIVDB3WTlPanZOZWt5TWswT2V4RWxuM3V0M1lramkvY24wMk95?=
 =?utf-8?B?Sk9aaFRST09hMWVNaEhVMG5kb1FkYnJ2TUk2bWR2bFROSUgzQ0w2bkJWTWpL?=
 =?utf-8?B?VEpMaHEzbDFiTGtBcVhFWXhzQ29BSFIzcXNoRTZwK1hzaGhhY2NUdlJIT21N?=
 =?utf-8?B?TW1DaGUycU1rd0xwYU1PeTZieE52VmR5ZnI1Nmh5RnNIR1lxN1NYNVNneEVG?=
 =?utf-8?Q?Q544KuSp+yfXtZVB7q8aTeQDZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59cf302-1fd8-4f24-6375-08dd154d1344
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:51:33.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Phmuumb5fWrRD0RqXTm4P2Jqp/Lt7lf33XkOhW7btMTgVcAll681YXW83Ox4BYD2Pc290A7hF3Bm9fE/4tQROg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7511

Use dev_err_probe() to simplify code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/regulator/pca9450-regulator.c | 73 +++++++++++++----------------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index caeeed433165c..0b1f099fdd5ee 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -932,25 +932,20 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 
 	pca9450->regmap = devm_regmap_init_i2c(i2c,
 					       &pca9450_regmap_config);
-	if (IS_ERR(pca9450->regmap)) {
-		dev_err(&i2c->dev, "regmap initialization failed\n");
-		return PTR_ERR(pca9450->regmap);
-	}
+	if (IS_ERR(pca9450->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pca9450->regmap),
+				     "regmap initialization failed\n");
 
 	ret = regmap_read(pca9450->regmap, PCA9450_REG_DEV_ID, &device_id);
-	if (ret) {
-		dev_err(&i2c->dev, "Read device id error\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Read device id error\n");
 
 	/* Check your board and dts for match the right pmic */
 	if (((device_id >> 4) != 0x1 && type == PCA9450_TYPE_PCA9450A) ||
 	    ((device_id >> 4) != 0x3 && type == PCA9450_TYPE_PCA9450BC) ||
-	    ((device_id >> 4) != 0x9 && type == PCA9450_TYPE_PCA9451A)) {
-		dev_err(&i2c->dev, "Device id(%x) mismatched\n",
-			device_id >> 4);
-		return -EINVAL;
-	}
+	    ((device_id >> 4) != 0x9 && type == PCA9450_TYPE_PCA9451A))
+		return dev_err_probe(&i2c->dev, -EINVAL,
+				     "Device id(%x) mismatched\n", device_id >> 4);
 
 	for (i = 0; i < pca9450->rcnt; i++) {
 		const struct regulator_desc *desc;
@@ -964,13 +959,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		config.dev = pca9450->dev;
 
 		rdev = devm_regulator_register(pca9450->dev, desc, &config);
-		if (IS_ERR(rdev)) {
-			ret = PTR_ERR(rdev);
-			dev_err(pca9450->dev,
-				"Failed to register regulator(%s): %d\n",
-				desc->name, ret);
-			return ret;
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(pca9450->dev, PTR_ERR(rdev),
+					     "Failed to register regulator(%s)\n", desc->name);
 	}
 
 	if (pca9450->irq) {
@@ -978,29 +969,24 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 						pca9450_irq_handler,
 						(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
 						"pca9450-irq", pca9450);
-		if (ret != 0) {
-			dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
-				pca9450->irq);
-			return ret;
-		}
+		if (ret != 0)
+			return dev_err_probe(pca9450->dev, ret, "Failed to request IRQ: %d\n",
+					     pca9450->irq);
+
 		/* Unmask all interrupt except PWRON/WDOG/RSVD */
 		ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_INT1_MSK,
 					IRQ_VR_FLT1 | IRQ_VR_FLT2 | IRQ_LOWVSYS |
 					IRQ_THERM_105 | IRQ_THERM_125,
 					IRQ_PWRON | IRQ_WDOGB | IRQ_RSVD);
-		if (ret) {
-			dev_err(&i2c->dev, "Unmask irq error\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
 	}
 
 	/* Clear PRESET_EN bit in BUCK123_DVS to use DVS registers */
 	ret = regmap_clear_bits(pca9450->regmap, PCA9450_REG_BUCK123_DVS,
 				BUCK123_PRESET_EN);
-	if (ret) {
-		dev_err(&i2c->dev, "Failed to clear PRESET_EN bit: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,  "Failed to clear PRESET_EN bit\n");
 
 	if (of_property_read_bool(i2c->dev.of_node, "nxp,wdog_b-warm-reset"))
 		reset_ctrl = WDOG_B_CFG_WARM;
@@ -1010,20 +996,16 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	/* Set reset behavior on assertion of WDOG_B signal */
 	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_RESET_CTRL,
 				 WDOG_B_CFG_MASK, reset_ctrl);
-	if (ret) {
-		dev_err(&i2c->dev, "Failed to set WDOG_B reset behavior\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to set WDOG_B reset behavior\n");
 
 	if (of_property_read_bool(i2c->dev.of_node, "nxp,i2c-lt-enable")) {
 		/* Enable I2C Level Translator */
 		ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_CONFIG2,
 					 I2C_LT_MASK, I2C_LT_ON_STANDBY_RUN);
-		if (ret) {
-			dev_err(&i2c->dev,
-				"Failed to enable I2C level translator\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&i2c->dev, ret,
+					     "Failed to enable I2C level translator\n");
 	}
 
 	/*
@@ -1033,10 +1015,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	 */
 	pca9450->sd_vsel_gpio = gpiod_get_optional(pca9450->dev, "sd-vsel", GPIOD_OUT_HIGH);
 
-	if (IS_ERR(pca9450->sd_vsel_gpio)) {
-		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
-		return PTR_ERR(pca9450->sd_vsel_gpio);
-	}
+	if (IS_ERR(pca9450->sd_vsel_gpio))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pca9450->sd_vsel_gpio),
+				     "Failed to get SD_VSEL GPIO\n");
 
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :

-- 
2.34.1


