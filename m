Return-Path: <linux-kernel+bounces-173977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BF8C0898
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E378B222F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AF538396;
	Thu,  9 May 2024 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k6ITCj6Y"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBF29A2;
	Thu,  9 May 2024 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215544; cv=fail; b=s147lDN3X3nRoKGJjWCyx/worbayB3+2DmrXXWJEUJfLPsZolu+Q875rKtmqNJ0YRI8zxsj7Hw5nUtwQ7o21QfHh/Kh00aPme2K6tmeHIU/bKSIBNj8Jdj7YWvV5N/Le/KtvPhDqXssJ0iRpddGNI00/jZ5/Z3DGf9FiFpL8xns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215544; c=relaxed/simple;
	bh=xnez9GeGkHmFoBmCSgX8cYtduKVfBlb8HE1UD/Um/Jg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YAjbntT2DcsAwBFE6Cs+GTfD8QvxKFQUhlPHrpYcfw1zSHI+Nbmy8n7PctJrlnvcXQEhnciPexlmM6qB1S5rErJa5OYBtb3VQTGRJOIUT5uVLM821YvkWI/46Qhhn+9Cq/gkcURvtJlBAvZNxGHrsyHOpz1w2h4gzU0UmEdHF/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=k6ITCj6Y; arc=fail smtp.client-ip=40.107.7.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwhDTl6RzvZQBcnb/M00GqCVndN0DHUINLrO+xGh6B87zdC5pVJhc67KGm7hHCVft4USawP0t/Xg/XFd+PCm70mj2tXF8fujaOoHCDo10KdcGw+xuX1UPr3d7+TJ4Y1CnkOWSE64prfJBd5ysSV3gOfPPh3XGDLbRRods0ISIdv4lrcXIg+oYFTMEJwMNJDAHD8B8+OKCHcfT28jqOzyhpIRJ4W2AnmFXiQNVVA5QNJz5V6l+TzFWommLNWDT/Xydh7YDgUQyS4QQOM6bAGGuxodIiu1t2IQMGj1ZaEFv/st4k0cU8fogMFpR1amxQBrhYiV8kdKhiOlT+v//p0oKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4vycOa415A+HhTY6XSOp9lZp/QrSVwBvgHQsgt94XU=;
 b=MkjKeqkzb8Bg85sATc/+KUMVyCJVTjQFZKvlSYKpDnpadwG+qua0IdV6sFUvB14ajupovdD9zgQwFgVTCRe+UqU4pUYVe7AR4A33hoLvLyBPD4XuULR09ESuSHLF3hQtEuvR3CU5mpWrlWn/3ofpUGtLMrwDFl5oO4tcslzSzd4cJ5bfJaod5pdrcj03hBdkeiglXrNpWPZZ1DzjNKExd/hhDAB9xAHguHX03UezMGEGgAkupmbfcrG/8L3iC/I3cjsM/qu4G1DRWfGIdnJv2Ca2nksFXOiR7H63Ee8tlEPEZUY5VgE3dInO2AL5Dbyu+9hSs/BdpE15NnBc848sqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4vycOa415A+HhTY6XSOp9lZp/QrSVwBvgHQsgt94XU=;
 b=k6ITCj6Yx6ZfyHi1CVGt7//W2Ysib0wmbg6Rvi3LwI2thLnD6h3i5n4jEi03LiTKdlCorZqtAp3EDYELD7+qVil7fn2c+n2nYnb7NvD/7VvlLTOAlzCYroqLMh9covHACIZhBEWVgga1vsh+T97V2CGSPeapbKpl1fmiYU7ctSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by AM9PR04MB8273.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 00:45:39 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 00:45:39 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 0/4] soc: imx: secvio: Add secvio support
Date: Thu, 09 May 2024 02:45:31 +0200
Message-Id: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKscPGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwML3eLU5LLMfF2LxOS0RCMLYyA0VQIqLihKTcusABsUHVtbCwCD7cC
 LWAAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Franck LENORMAND <franck.lenormand@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Varun Sethi <V.Sethi@nxp.com>, Silvano Di Ninno <silvano.dininno@nxp.com>, 
 Pankaj Gupta <pankaj.gupta@nxp.com>, frank.li@nxp.com, 
 daniel.baluta@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>, 
 Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Horia Geanta <horia.geanta@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: AS4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::9) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9358:EE_|AM9PR04MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: b9232096-4ec3-4bd0-57c7-08dc6fc158c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|52116005|376005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWVFK0NkcTlwOTQzT1YzS2Rla2pGN3I1WWdmTUI2UTNodGwxZ1llZnZpTW9G?=
 =?utf-8?B?VVlNQ1Z6djN2S29BTUhpQStPTlpuVmFCdEFnWDJNSFU3TjhWY09BNDZpbW5W?=
 =?utf-8?B?azRkci9PMm9vdzI0cTFKRjZkNkxZOVROUDNteXhWREh1SjEvNHM2SzNPZ2N2?=
 =?utf-8?B?Zkl6dHIrV25Ickd0cXNjL3dpVkd1bjBGVW9MZ05JUXZtTkNWeDAydUhsaSsy?=
 =?utf-8?B?bVA5Zk9Lb0ZsaXdFKzZvTnk5WWlIK0RDQVNwU01JeGxDVGJwdXBRQ0xhRVha?=
 =?utf-8?B?eGl4dHNER2x0S0JQczcxSllOYkJNRVRUemR3WitBSE1xeGFieWlHSVBmeFN2?=
 =?utf-8?B?N2VUNmwyeG41aDhyKzFXTGNZemtOcHU3NUF1b3hkRU9qZHEwcWdEN2JNUE9K?=
 =?utf-8?B?bjZyTDExTG9HWFcza2oyUWgrQ25OeVN4SkJScGV3cWY5Yi8vTC8xNFNuMEJJ?=
 =?utf-8?B?Vlg4Y0FKWGtmdHpYaVlieXVEVnA2OWcwa3dTLzZyQld4U29CdXdIVDVhNENZ?=
 =?utf-8?B?cDEvNWhqRWZ2TDA5TStFRUxIMlZTbndOSlFpbmZmTXgyUUlKdisxcll5cHlF?=
 =?utf-8?B?VGcvQUlLbHByMkFvQ0JiSUVjb0tFN1NpT0U0c0U4K3hob0FuckFvcTJJVmsv?=
 =?utf-8?B?ZVVDc2ZWSzQ0dmRMKzlDcmY0THh4aGZNaVM1OGZacTlYc3JJYkVpNmI2OEJ1?=
 =?utf-8?B?ZmtCQnlFTURFb01Pa3BlanhYdm5Ya2h4akpvSG5CQTNpaTVoM1ZDdlpRRm1y?=
 =?utf-8?B?MDY3amxEdnhBNlg2eG11NnhZUXMyVEplZFNENGgzQVoxR3V1bzZEQUZiOVNq?=
 =?utf-8?B?T3BWZ1M2cjMrQkd2ZDhscXU5cEZRV1o2akhaNnBMQnp3RFpIMG53bEdMcW1E?=
 =?utf-8?B?MEtFakFJVDZ6WVNqQVR0MlZ6ZkFUdkVka0M0N0htS0hqM1VUY0FPa0FHQWtQ?=
 =?utf-8?B?VTBRZmFnUWI1bG9VNmVQNFlUSGlnSWlUUSttYjNnTHJtWnZFemF6NjVFdThq?=
 =?utf-8?B?NlpJaVhuUkMwaVhCMnRXeXl4MXVLaktpNWx1b0cxam5BYlhkSUp6MHZNNVpo?=
 =?utf-8?B?Lyt2Tks1MmlVcHAybGNJWXVNbVdvRkJvT1R4akl0ZVFrTkxKUFlDbU1NUlZX?=
 =?utf-8?B?YlFPZ2Fya1d6RXlmRUNwQ1RscXpIRDhFTGh3UWpzNzFoNUV4OXlqUEpZYUtS?=
 =?utf-8?B?RG82V3dvMEk5YVJvaEVyMFJZaG9XeU5YNCtPL3k0VHkvSnY4emJZT09JQjVs?=
 =?utf-8?B?TVk1RlNxNGhnQXhocnJVNzA3YUxXMCtPZElERURnUXU4RG5weG5oejlUSUdx?=
 =?utf-8?B?N0xWWkRzOVpGenBGdHh0aG41bU95MGtrRFJqU2VsQjJhamM5aWxDMHIwL2Nr?=
 =?utf-8?B?V21qNyttMlAweXI4YmUyWnJMSXFiZ3Y1MTIrQVY3WDBtdy9KaTFYejB0azBq?=
 =?utf-8?B?dFhrVlg1aGw2WXIyNDFBZktKd0YybWRORUplZUY1cGpiRTN0dm9sTWRGZ3Uw?=
 =?utf-8?B?ZVk0Rit0K2VLTVBGeFB4TVM4bVJJWW8rSXordXlmaVFpN0IrSDY2czVmVnV3?=
 =?utf-8?B?NFBMVURsWXp3OHd0bGhWbjZDT3NBMjY0MW5QRVl3L0VCRzc2ZTQwZktnc1Rk?=
 =?utf-8?B?UWZ6Y0R5RTJHZWpZL2RUL2pHV2VDbVJIOGkvZUNkSUM3QWJ0RG9VYzZGL1lx?=
 =?utf-8?B?SDJKNGNmbURvanN3a2hLT2R0WmxmVDF1MDZyekU5T0FneStVSGt2UHNhNFFs?=
 =?utf-8?B?UWxzd1pSaTdtQjA2ckdZa2lSUjViTTBDblljYlYwdjV6K1l1V0JZYzNCVmRo?=
 =?utf-8?Q?Beoh3ugAgp9GUormLFwtzLUfmNlkiDBoQYj90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmlOWGpXV0hNSU1JSkpxczlmS1VvN2F6N0VTRVhyOWJFVXBOclI4L3NFRmg3?=
 =?utf-8?B?WnFzTnFtWEJlZXBFU01HQmhkbmxNWmphMUtqSnFlZWN2RUlsRmhNTHc0aGMz?=
 =?utf-8?B?UE5mZS9McExVQm5ETWl3eVM2WWlnRUZhcC8rNUhSKy9DMm1qSnIzc2JuQmtu?=
 =?utf-8?B?TVBwOWVQOGk1SGNuM0lGV2MrNVVyTFF6dnN1RUcwRWJYcGpsc0REVmc5cG1h?=
 =?utf-8?B?UlhmUGZIbTFVamFCRjhwcDUyOGtreGVqSUlpQ0cyOEd2NE1VRHRsWTh5Witl?=
 =?utf-8?B?b0VsbE1ZK29RWWE0cE9OVzViMDdLZmkzU2dkVUtoSVNLa0F3WDVoWUYySDNF?=
 =?utf-8?B?aEN0dHp6ZWFmZVVSaVV0MDJHY0hEdVVQUmNVV1p1SkJFdVFhLzVkZGJvK0Va?=
 =?utf-8?B?UHVrM0RZTXVhVjFTZ0hKREVnV01aUzFtaGx4Z3RBdEJKR0tsK3NCTkVlUGxN?=
 =?utf-8?B?eHdNSlJtT2xnelBOcHMzZTArYlFtMDhYa0tVOUluakRYVEw5NmhEODIvUkZm?=
 =?utf-8?B?MXQxTVMwR25LQi9EbGUxcVd5V3hJU01qSEVwNXpSNS9oV0xFekJKNkZtMGtJ?=
 =?utf-8?B?S0xkMXozMGpIK2xSSVdCRjhjR2RNa2h0SkJWcUgwN2dtTEpINnpWZkxqZ2J5?=
 =?utf-8?B?ZFY0T0FMQzYwcHlWZFhNSHUzQjRmeGNQWU01dk5zczRidC81UGV0bXlpbnIr?=
 =?utf-8?B?YXlPM2s5NmduU1hiV1dSd3ZJN0J2UXVhRjAweUdnaS9kdERYZE9hdDJjR01a?=
 =?utf-8?B?VU1xVUtmaEpaa004OStVa1djQVNDRjRvTFhMRnF5NGdhNjdKSmZnd2p3Y1ZY?=
 =?utf-8?B?dzlCSlBKZ0E2a0srbUNoUEFJUG5JRzRvTzNQcWR0R2FZTDV5ZkJaVGI1SjVP?=
 =?utf-8?B?Wjhhd3czc29HMDVWMlcveTJTSnFSUTlIYnIvZHdyRkdNZHVkemt5Yi9LMStQ?=
 =?utf-8?B?NytDMGRvMmhiTXZBUWsrbFhKNzVzeVZGWTU5cy9yM0xsVWhPVVIzMldTZzlR?=
 =?utf-8?B?SWpEdDlTVjJJanhVN2dac1A3cU96MW5hdTFRZHhWS2swcnhBSzNvT2NTSitK?=
 =?utf-8?B?eHp0ZngrOEpNcjNuNWtTZGx0enBmTkZKUU03RjZTaWFqTGwxUGE5RTBncE5M?=
 =?utf-8?B?M2xqekNXOGJ3VGtlYnNZcDNVWjhxUUQ2U3pmZlRVR1c0V0hwcm9vOVhnS2xu?=
 =?utf-8?B?VE5iMCtZM2xvWTlaS3lBMGoyN0M3aENPMXU5MytqSWN2RDlzY0pZUCt0MWsr?=
 =?utf-8?B?RXZWYTV1MmhTVmFkWWV2TytEeDRMYlg3N0sxNkZWRXZOYVAwRERYNkNxT00r?=
 =?utf-8?B?c3Fqd1ZqTlhidnl2SE1DWC8rKzFxWEtWemVVQWd3RGsrSk8xdkZoRGV1ZUlG?=
 =?utf-8?B?d1Q0OC93emRVZ2FIRWtCeHhoV2lQR1dabjMvc2ovTVFwQVhGVDdsc216RE5I?=
 =?utf-8?B?YU0yS1c0Q0NIbkJ2ZlFQTjhqdjdjSDB2cmdQQWhYMkszMjNHY3ArTzlkVC8y?=
 =?utf-8?B?bjF0Y0ZJS3BQa2xPL2xxSXBzek4zKzUxVHVNOEVKc3pOR20xUWhwNkFEZnVI?=
 =?utf-8?B?cVRqZXB3cUtOcTJUT0RQazFMS0k2b3hMYzFoK1Ird0ZCNlNFTlBtM3Brajd4?=
 =?utf-8?B?YnducGJtQm5ZTzZidHRUMTNONWlUb0krRUJUbE1lWGFkVnBaa3RGN2pHa2Rw?=
 =?utf-8?B?Wmt0SmRVeWJNMmdzVUlxZTlzZkZYUjIvRmgzNGhOSFk4NU1pWXFnR2VvdnZ4?=
 =?utf-8?B?V2dzdm1aRDFmOVlhRFljVzlPbU9ETUo1SUExWlB1dW16dmlhMy8rSDZrc25k?=
 =?utf-8?B?UkZlQU5pdVJ3OEozbFZtVk14TkJHc3F2SFhiRVFVTmNzOTIzRG41bis3NnM2?=
 =?utf-8?B?UXhSTWxBdFJ0aUhjZTFSdHZWYzIwWEw2WFhRdjNpdVRCVm5RVnRSMUs2d0FF?=
 =?utf-8?B?ekxVS2dvdGRQc0ErWXBKOFJRVEhJcUp4YUphWGtKV3l6V2ZlaFZYRDdycnZV?=
 =?utf-8?B?ZmlCdkxPSlpkQmVGVks0VFdQbXpuUytoSUZTeXQrWG5FYVJlNXFKM0JKVm1S?=
 =?utf-8?B?RlpQbnI5UEtSOTlYSThjMDZJaDFiOU5KUWVZQnlYN2ozczJZZ2dGWkpNTXNL?=
 =?utf-8?Q?V3BnUaQZBTK1Aj4Eah/IxiMIY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9232096-4ec3-4bd0-57c7-08dc6fc158c2
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 00:45:38.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wN0c6RgJ6hq42+2Q1AVlazwRHAEwgskr2PDtxSW1dqx+3ifTnwOqvvHlfyBGLrrUC4yqrzAfFp3SKzVWDsVgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273

The tampers are security feature available on i.MX products and
managed by SNVS block.The tamper goal is to detect the variation
of hardware or physical parameters, which can indicate an attack.

The SNVS, which provides secure non-volatile storage, allows to
detect some hardware attacks against the SoC.They are connected
to the security-violation ports, which send an alert when an
out-of-range value is detected.

This detection is done by:
-Analog tampers: measure analogic values
	- External clock frequency.
	- Temperature.
	- Voltage.

- Digital tampers:
	- External tamper
	- Other detectors:
		- Secure real-time counter rollover tamper.
		- Monotonic counter rollover tamper.
		- Power supply glitch tamper.

The on-chip sensors for voltage, temperature, and clock frequency
indicate if tamper scenarios may be present. These sensors generate an
out-of-range signal that causes a security violation to clear the
authentication and storage keys and to block access to sensitive
information.

Add linux module secvio driver to handle security violation interrupt.

The "imx-secvio-sc" module is designed to report security violations
and tamper triggering to the user.

The functionalities of the module are accessible via the "debugfs"
kernel.The folder containing the interface files for the module is
"<kernel_debugfs>/secvio/".

Get status
Reading from the "info" file will return the status of security:
- Fuse related to security tampers.
- SNVS readable registers.
- DGO registers.

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
Vabhav Sharma (4):
      dt-bindings: firmware: secvio: Add device tree bindings
      firmware: imx: Add SC APIs required for secvio module
      soc: imx: secvio: Add support for SNVS secvio and tamper via SCFW
      arm64: dts: imx8q: Add node for Security Violation

 .../bindings/arm/freescale/fsl,scu-secvio.yaml     |  35 ++
 .../devicetree/bindings/firmware/fsl,scu.yaml      |  10 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   5 +
 drivers/firmware/imx/Makefile                      |   2 +-
 drivers/firmware/imx/imx-scu.c                     |   4 +-
 drivers/firmware/imx/seco.c                        | 216 ++++++++
 drivers/soc/imx/Kconfig                            |  11 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/secvio/Makefile                    |   2 +
 drivers/soc/imx/secvio/imx-secvio-debugfs.c        | 274 ++++++++++
 drivers/soc/imx/secvio/imx-secvio-sc.c             | 595 +++++++++++++++++++++
 include/linux/firmware/imx/ipc.h                   |   1 +
 include/linux/firmware/imx/sci.h                   |   4 +
 include/linux/firmware/imx/svc/seco.h              |  69 +++
 include/soc/imx/imx-secvio-sc.h                    | 216 ++++++++
 15 files changed, 1443 insertions(+), 2 deletions(-)
---
base-commit: 93a39e4766083050ca0ecd6a3548093a3b9eb60c
change-id: 20240508-secvio-8acfa2838385

Best regards,
-- 
Vabhav Sharma <vabhav.sharma@nxp.com>


