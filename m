Return-Path: <linux-kernel+bounces-250225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB3192F56C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DBB1F23665
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B345D13D52C;
	Fri, 12 Jul 2024 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EnqVzIxT"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96413D2B5;
	Fri, 12 Jul 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765400; cv=fail; b=Xrr5RyGosT1JRXXOfj2f0yysgH0SuJKpefNU5mEDFSpSHaTwrRRYmUKsiTvMQvzjinqXQipRDheKya1bmuIRAYoJdCCCavjaSFHWFBb2ETIZNgMVGa5VAbL2Pl4Fb1cZ7sQGci7G4ZP0tMdouRdRe0lJYu4wPVfATRoQJhqwRE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765400; c=relaxed/simple;
	bh=Lv7/BnXeTPi4qVq8xeex2H15P+16rBSgjNpb9WS3aXw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=enurZUqqOX59fX+pZ2GkQYTk85mY/JaPhwtLdjwATCzEN74LuPX6YgOUOzYwgSfoH4NRg1i6/m9bmhtrofIKnyVWqKwLM3InX1eYSUf/C3xCnUQ6u70l8Bld+gGd6mW4tl8KFEA42yKCARx95B3S2A2LKFGBFbpaIqFuvThtfsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EnqVzIxT; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW+PHAP3f0yF0SU6hiWADWEWvbwDhbDabBZaIdnGs2Dhzi8jj5/2K8yHQTPDko4KKmcTQF7HvSd4n8fxk336/7fOC72cl2xCSjruYQ6s+9DoResdV5d6Tf3Y68YfbPW6q6yFf2KxH4PUUwPxC3iWSdy13oqIGkSsP260HD+bdde2QX8lHdDesI14oqw/DZWFlhqNJ7AwF+DRKQ0H/iyvcs12pYdBDxKY9pVKEGlck+9tIEBwiSu+RXJ1uRgOrdRsT5kvgzCYE1N9Dp0ZoTxWd8tNk7TkB3QDL6JART2FTLfYvDQmQ15qxJgMLGz32r92qECgZYGf8bJCtV3DWOg48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB/JkepzNH+M2H8Eq/gB2f520ndI/kHV8eVEqXnUjhY=;
 b=u6Q6G1bruKgumu+DL1dMgyuQwM7HuDNuHbbycTGwQBlkOSpYkI2RA1AEYk6tVUCwbi3i9BNA3k1Nxya1yIFD8YijySTJ7O0Mk4GOLmPIxghMocRhgbFQvI+3LF/5Yy98NBieTxq7NdFK73XieUSJGL3+kgFE3vXh6p+qIj4XswzlIKkxg3AUdamhPNssm6e9ZjdTatMGtYYOSe7pYrFQWWo0nlV4YPO64vthtMG2LDHW+cgnDRcDvCd4HyRhK8BwSeUTs/ydXULIHJ9dwMozRSRzNDSMgKkg9EsgSt4tN/foRnEwcrMlwk8gYJvzjsNzzEwxWEkqVRaFazkU7QcMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB/JkepzNH+M2H8Eq/gB2f520ndI/kHV8eVEqXnUjhY=;
 b=EnqVzIxTBZIw+oTWT2V+VhweLQovM2hwtxqInop0rVXJ5J/rK/c/icNjXuFph2fmQtv0bdVvNOFU/pijwkO5khx1jUs7kGF2b95012acbhmlcrc6uHqrNh+baFYKtsTfaSXgdjvIAZk7uZyjSemZULc7HJAzlpheYgo98dw1bso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 06:23:14 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 06:23:14 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v5 0/5] Changes in v5:
Date: Fri, 12 Jul 2024 11:49:55 +0530
Message-Id: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAvLkGYC/1XOTQ6DIBAF4KsY1qUZ/qWr3qPpggBWFmoDDbEx3
 r1omojLN5nvzSwo+Rh8QrdmQdHnkMI0liAuDbK9GV8eB1cyokA5CFA4DDNOZdphwwGEAM2claj
 sv6Pvwrx3PZ4l9yF9pvjdqzPZpv8WAlVLJhgwVVYYqbgm0t3H+X2104C2jkwrR1ntaHEFdY602
 gimz44dTpL668yKM8rR1nkjLDdnxw+nQNSOb/eoAwBPWkOqP9d1/QFQuT/dSAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720765211; l=14479;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=Lv7/BnXeTPi4qVq8xeex2H15P+16rBSgjNpb9WS3aXw=;
 b=YeLmFggWzZOKl8ACDv4EVH5D4ANXnqwx8LCaoI6Z477WDzO7FYuw4FrHy3dcXEZeB3ivHNyn8
 0nQ5Qris+p2CvOx8eC25M1P8RZOH3ZJlnXX6aiTTTYC1XFTCNJaAcZV
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcc6a52-bb51-4413-ef0c-08dca23b1c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm4reUY1aHlMeSs3eFIrcDU0VW9ZZTFwaTJiZWVDTE5oNTlBanQ2dlJ5VUE0?=
 =?utf-8?B?TUNtd0JRNWdGa2M2SlhWTlJaZ0dBU3Zxai90RzRDQmdKbU9rdkNFNkpaamh0?=
 =?utf-8?B?VFU1N2s0WFlaTU41VEpFS3ZlLzlnTEpycktwMEdUNklaK1kxVVNwK0lqY0FK?=
 =?utf-8?B?NGxlTGd5RTA0NEUrOVRsVFVuUVpxUDlJbDFSRTZYK0U5Ryt1OGRqNFVYS1k4?=
 =?utf-8?B?RldZbGVidWJZVmxSYXRXK3htcEZFbVRtYkcxdGJTdXhoYkNJOVNwK1ZuZTVh?=
 =?utf-8?B?WGhqS1dIdTZ6T0F1SitmSTJQdzRsSlgreTdZcWY0WHRtL1RDOTJvN3hxZG95?=
 =?utf-8?B?dXhOb05OZTVzaUdrQWkwVVlLdjBqSFdpeFl4SmI2dFNtSytqVmxuZXlSWXhk?=
 =?utf-8?B?emNldTlkZVBuQlZrY2prNE5DeFErVnc0OWF4cVpxUURRbnlSZjFuU25jUjFG?=
 =?utf-8?B?RzZqbno4VTZTQVVlWkY4VkRlejNGT0lEek5JVEpkMHhrdmZlVHhCNi9LMzhF?=
 =?utf-8?B?U1ZSbHBvMmROakRKUU1GRU1mT0YyY2JMRDBmbDN3WXk3QjZmMGVDTldFMURy?=
 =?utf-8?B?U3JuRGFHQUVDWStiNUo5MElKYkRaVlpOZ014U243MEoyYWRQSGtYM2t0R3dk?=
 =?utf-8?B?NU1CQUtrMWZKb2hFU0RaekoveGVtdFdrUnF6c2FvOG5xSDZLYXY4c1pkQnlO?=
 =?utf-8?B?ZUNXQjQ0RkxyYXBzcC9UdWxrMm1DTk9WNUNKQUEwanR0NFNCTVMxNk9uTlFq?=
 =?utf-8?B?NVVVMVBKUFRvVHhvNFFZdGZuM3U5WTR3T09ZVlY4SE50UG1iOGhnK3hTdXAx?=
 =?utf-8?B?RzU4Q0FnRHpLL21mNGI1dnJvY2M2cTZ4ZVVTb3A5QXgwNFJyQ2FMWHFBaDB5?=
 =?utf-8?B?V2tKUy9acGhaL20rVUVhdDh1S1ZuZ0tENitYckdJbVpodGtYeklNWXVhVFdW?=
 =?utf-8?B?amRWRmxJU3Iwc2QydkJEamJ5QU12UDBWSjV3dGxoQUhYTnZJVnpvZVo1ekp6?=
 =?utf-8?B?MERleU9GalRaNjJHTDhjei8xeXUwUWs4OEI5MHo5Z3oxWHhZNGwvMkk3cm1Z?=
 =?utf-8?B?anJZakRsR3EzN0lOVEJWU1ErMEFOaE5Ha3BaM040clJGRVRRd3VEVk9SK3hT?=
 =?utf-8?B?NTUxbzV6WGZtNkNLbjFWNUptemJIcVkvOUQyT3hnRnA4QnNabUhtbGxDcUk5?=
 =?utf-8?B?MzlYdlRzWmNFeEp2endSVGRFblhNQzA5SGlJK2VNZUp2NUNLQ3gwRVpUQ3pm?=
 =?utf-8?B?aFVlQlgxTGZIRy9WejJqQmdsMjZESTBpeG82dlF3NUNqaVVMNE1GaHloYzZo?=
 =?utf-8?B?ZTh1cjZFTXIyWElzaGRLa1dleUdqd1VaN0hCVE93WkJ0dytGVTFTanNXZ1lN?=
 =?utf-8?B?MDdZeXVpNmhoT0tBa3FnR0pkUGtKVm9ZWXd1bnllWkdxZVlkQ0g0MTN0Wm4z?=
 =?utf-8?B?QnA2aGdGNi9pYml4RFlwa082UXRXRnpGQ2Y3dDdhdFV5RzZhQWJLT2U5R3U0?=
 =?utf-8?B?Z3ZmUE9PYkd5RjZRK3RTa2x6TGZsWDBWYlFYZkNGUDd5TDFHQVBkWUd4bTYw?=
 =?utf-8?B?ZlZEeTQ4c2JuODRLMzFVdXp4YXg1a25nUEZ2TTVIcWxzY0hyWnRITXE3S3hY?=
 =?utf-8?B?OURKd04zUnlXMmx3UXRwNzhoTktaL2I1OGpYWFp0OU1jZkkzSkxYL1NpR3ox?=
 =?utf-8?B?cEZVdWxDQ21pdmhNaU9pSzF2TDBUQ3JNb0ZSMnBuT3VhWmZrMGlPcVp6UWFF?=
 =?utf-8?B?NjIyN2ZPdVlGZDhmSnovZ2lyTHVZTnJqR0tkdC8rOVh5aG5aTVFQUWZVTXBD?=
 =?utf-8?B?c3JSZjVYcm0zZURZU0RONTc2anB4eTNNRW5ENngrRjJWbFpyc0Z2eDNqWmJW?=
 =?utf-8?Q?NzQ4pGSAUBLPr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1BZWjlvMmhzNmFMNm1VbUx6L2NkeU5uNng2TW13NThHSno3MDFMYVJ6b1di?=
 =?utf-8?B?V0ZPZC9QRmk2THdpcFB5aG8weUxTUDJpUEJocytrZWZ4RmZXMnJUR2pxR1Iz?=
 =?utf-8?B?RjVPTnpUQVFjYWgrYWtGUHIza1ZRbVpveVNtTWNsbzMvalFHNUZ6OFd4UTdK?=
 =?utf-8?B?K29CV0RnRGlsUHRpeE5aZW8rZ3YrQTltVForaGxmSEtOOVVGU2dBdW0vdkVG?=
 =?utf-8?B?MTYwTWhPQVlXWFFuL21oanQ1R3NuRWgzU25QOGkxUEVXRjV0blRZVG5UamVF?=
 =?utf-8?B?NE9KNHpRTkM2V1M0MkwzMEgvVDFYS0FGdTJ4c1d4YzVJVlZOS2ZZRHdMRmVz?=
 =?utf-8?B?eTBRckZNanZGRVpUZVFvK2dIa09ET05rUFh4T0h4Z20rd1VqemR2OWZ3VjNW?=
 =?utf-8?B?WG9iS1phNFNrdEhmTktyR1VjR3JidHFjOEpQZFBHYUlUL29GaTFlQ0JKaGdN?=
 =?utf-8?B?dG1rd3d4ZGNWSm9DUHpJY1VQQkZLVEE3dFQwVkZwK3ZlaDIwLzB3Mmt5NkVI?=
 =?utf-8?B?QUZUTHpVMUt3MThZbnpveFZjaTVoTUUrNHJtWXVwVlB6TFBDL0pNVTJVUVFo?=
 =?utf-8?B?QmI0dHJRbnllMmtvbVVEQjJ1RStEVTFEZWVkTXV6bWMwSThtVUZnSjBNaGRo?=
 =?utf-8?B?WVdkQkRvdXVBcy8yc2E2cFRmbTdLYmJGS0tFbHZFeEhuaXFYTzl6aXp4cjRK?=
 =?utf-8?B?R3k3TFQvUmdjWHp0d2cxdElXeEJ6eEJMelVPeVE4bTBoQ21JL29veWV5MDhw?=
 =?utf-8?B?MDU3ek10NDJETGQ0d3FoVW1sdXl4cWlYUVV4eHJWVVhlS09yR3d3a3R4MlRS?=
 =?utf-8?B?UGcwbzlncVhIWjJOQ1BOc2FwUDJrd0NpdDJmS1ZCOHNTWEp3MkVnb0FRK2VT?=
 =?utf-8?B?dDdTdmZkT2hzbW5VTlNnR2ZFd2hmaGdLNUNpa0JveFNubUluNDU1cFNYUkxv?=
 =?utf-8?B?YjRnM0t4YVBJSTIxRGtyU1hFQ1BySHBqbjk0MmFCY0RRYzA3N2Jud2tHK2pl?=
 =?utf-8?B?YkJpTTB0bThnWW1COXdqZzJMSEVyS01zT0ZTNjhFVTJEejAxUDJxc3A4Vkt5?=
 =?utf-8?B?ekRRS21XUFdiL1NEZ29wY1FhczFZbGVaWXlhZWR3K0NRWkhMVC9QMEtucG5B?=
 =?utf-8?B?dU9rN3pTcWZjUEJGRFRWWDB5UnhJVEkyYUNMWlVvemVpREdrS1BGcmduRVQz?=
 =?utf-8?B?QW5WTFAwSTdQa05SYkcrTHJDby9ocjFUSFpjbm0rdno5TUR6SjZZK25ncTVa?=
 =?utf-8?B?QXdtb1Ivb1hsVzZhclE4TURva1VTdHdQbUZ3cUdjbVF2M0t1VnFZYWRqZno3?=
 =?utf-8?B?K1BJV0ZVNkVzK3ZZVk9Wcm5zeDVKb2JnaitadnlUY3h1MGZmaWhqWEdONy9u?=
 =?utf-8?B?eGVFaW4yMTROMzQ4Y2Z0VkNkd3dqTHRNK21mN1dadEt1ektBVCtVUG1lQ0tu?=
 =?utf-8?B?VndOTjRPZXJ6ejdKZVV2L0tvZjRSay9NTjd5ZUlCRStrSXdoVFVQR0duMFkw?=
 =?utf-8?B?TFd5SVRacTFEMmlld0VSTWdsMERaUEZETkxMSHF5UmxWeG1kMXRGVzFobTI5?=
 =?utf-8?B?WUpoZFZUWEtabU84VGdJTzNzcUh1dkRCUDJ5THEwUlJYN1BKUmcrTnl6SzFB?=
 =?utf-8?B?R0tiSXdJT2k2Uy82UDRYU0I3eGtXZ1V2ejNtVmh4MURlTS8yakJUOFVEdkFV?=
 =?utf-8?B?YTBZVWRrTjRFSUhhRHF0OXVkYW9EeHQ1MTl0eE5XVlZIY0pWbW5CczlULzFF?=
 =?utf-8?B?VlBzcEo1ZEh1S2Q1SEJwTnZvdkdpbmFKRTFjUldyK29CaHQzQUJIUGZjK2tK?=
 =?utf-8?B?eTZPVjFtcVFHWVdKd2NFVE9TY3kxampGNXpSZWc5eXBTc3hQV0pab1hRUjI5?=
 =?utf-8?B?elV6U1ZPd245Mm8xbGRPd2Jjak1tUitSdm1WUUdCQmExM1ZiZ3VFZXY5THlN?=
 =?utf-8?B?MXVHcnJPZUpXclM1c1UzUmZ0ZCthZk56MWZYQzR1Y1JZRTZYbml5VWM2YjN3?=
 =?utf-8?B?U0xqdk1yaHZ5MCttNlpPaE9zaUxXSVhRenU4SUpLQU9NdTkzRzkwZXJSTkhs?=
 =?utf-8?B?N3JWT0dSemllb3NjZzFzVzlFSlJ6b0RETVplbUJnRXhpZnk0eTlrbDdWdHoy?=
 =?utf-8?Q?005R2PU28OB4C6t7xJc0IWTyx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcc6a52-bb51-4413-ef0c-08dca23b1c2f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 06:23:14.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GD27Ym8b4xgYbXFmBSc+rE3tWrrP4E6af+MM0E3jgbQC7iXhZQuhnkzOCMkebTuxByQitl8U/kJskjBqRtGttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

2/5
- updated the description of mboxes
- updated the description & items for mbox-names.
- updated the description of memory-region
- move "additional properties: false" after allOf block.
- removed other example except one.

4/5
- Corrected the indentation in Kconfig.
- info members:mbox_tx_name & mbox_rx_name, are replaced with macros.

5/5
- Replaced "for  secure enclaves", with "for secure enclaves"
- Replaced "user space" with "userspace".
- End the line "[include]<linux/firmware/imx/ele_mu_ioctl.h>" with a period.

- Link to v4: https://lore.kernel.org/r/20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com

Changes in v4:

1/5
a. Removed - from EdgeLock Enclave.
 
b. Removed , after "Each of the above feature,"

c. replace "can exists" with "can exist".
 
d. 
-messaging units(MU) per SE. Each co-existing 'se' can have one or multiple exclusive
-MU(s), dedicated to itself. None of the MU is shared between two SEs.
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
 Communication of the MU is realized using the Linux mailbox driver.

e. 
-All those SE interfaces 'se-if' that is/are dedicated to a particular SE, will be
-enumerated and provisioned under the very single 'SE' node.
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
 
f. Removed ",". Replaced for "Each 'se-if'," with "Each se-if'.

g. removed ","
-  This layer is responsible for ensuring the communication protocol, that is defined
+  This layer is responsible for ensuring the communication protocol that is defined

h. removed "-"
-  - FW can handle one command-message at a time.
+  - FW can handle one command message at a time.

i. 
-  Using these multiple device contexts, that are getting multiplexed over a single MU,
-  user-space application(s) can call fops like write/read to send the command-message,
-  and read back the command-response-message to/from Firmware.
-  fops like read & write uses the above defined service layer API(s) to communicate with
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
   Firmware.
 
j. Uppercase for word "Linux".

2/5
a. Rephrased the description to remove list of phandles.

b. Moved required before allOf: 
+required:
+  - compatible
+  - reg
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
 allOf:

c. replaced not: required: with properties: <property-name>: false.
   # memory-region
-      not:
-        required:
-          - memory-region
+      properties:
+        memory-region: false

   # sram
-    else:
-      not:
-        required:
-          - sram

d. Reduced examples. keeping example of i.MX95.
e. node-name is changed to "firmware@<hex>"

3/5
- node name changed to "firmware@<hex>".

4/5
- used sizeof(*s_info)
- return early, rather than doing goto exit, in ele_get_info().
- Use upper_32_bits() and lower_32_bits() 
- use rx_msg here instead of priv->rx_msg
- Moved the status check to validate_rsp_hdr. Rename the function to "se_val_rsp_hdr_n_status"
- typecasting removed header = (struct se_msg_hdr *) msg;
- Converted the API name with prefix imx_ele_* or imx_se_*, to ele_* and se_*, respectively.
- Removed the functions definition & declaration for: free_phybuf_mem_pool() & get_phybuf_mem_pool()
- removed the mbox_free_channel() calls from clean-up.
- Flag "priv->flags" is removed.
- Converted the int se_if_probe_cleanup() to void se_if_probe_cleanup().
- Replaced NULL initialization of structure members: priv->cmd_receiver_dev & priv->waiting_rsp_dev , with comments.
- Removed the function's declaration get_phy_buf_mem_pool1

5/5
Changes to Documentation/ABI/testing/se-cdev.
a. Removed "-" from "secure-enclave" and "file-descriptor".

b. Removed "-" from "shared-library"
 
c. Replaced "get" with "getting".

d. Added description for the new IOCTL "send command and receive command response"

e. Replaced "wakeup_intruptible" with "wait_event_interruptible"

f. Removed ";"

g. Removd "," from "mailbox_lock," 
 
h. Replaced "free" with "frees"

i. In mailbox callback function, checking the buffer size before
copying.

- Link to v3: https://lore.kernel.org/r/20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com

Communication Interface to NXP secure-enclave HW IP like Edgelock Enclave

Hardware interface of the NXP Secure Enclave  HW IP(s) like EdgeLock Enclave,
V2X, SHE etc, is based on the Messaging Unit module that enables processing
elements like ARMv8 core, RISC V core, within the SoC to communicate and
coordinate by passing messages (e.g., data, status and control) through 
these interfaces.

The NXP i.MX secure enclaves hardware interface kernel driver, is specifically
targeted for use between application core and NXP secure-enclave(s) HW. It allows
to send/receive messages to/from the secure-enclave.

Patch-set adds the kernel driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave,
both from:
- User-Space Applications via character driver.
- Kernel-space, used by kernel management layers like DM-Crypt.

To: Jonathan Corbet <corbet@lwn.net>
To: Rob Herring <robh+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

Changes in v3:
5/5:
- Initialize tx_msg with NULL.
- memdup_user() returns an error pointer, not NULL. correct it by adding check for err_ptr.
- new IOCTL is added to send & recieve the message.
- replaced the while loop till list is empty, with list_for_each_entry.
- replaced __list_del_entry, with list_del.
- Removed the dev_err message from copy to user.
- Removed the casting of void *.
- corrected the typcasting in copy to user.
- removed un-necessary goto statement.
- Removed dead code for clean-up of memory.
- Removed un-mapping of secured memory
- Passing se_if_priv structure to init_device_context.
- Updated the below check to replace io.length with round_up(io.length).
	if (shared_mem->size < shared_mem->pos|| io.length >= shared_mem->size - shared_mem->pos)
- Created a function to cleanup the list of shared memory buffers.
- Used list_for_each_entry_safe(). created a separate functions: se_dev_ctx_cpy_out_data() & se_dev_ctx_shared_mem_cleanup()

4/5
- Changed the compatible string to replace "-ele", to "-se".
- Declaration of imx_se_node_info, is done as const in the whole file
- Remove the unused macros from ele_base_msg.h
- Remove the function declaration get_phy_buf_mem_pool1, from the header file.
- Replace the use of dmam_alloc_coherent to dma_alloc_coherent
- Check for function pointer, before calling the fucntion pointer in imx_fetch_se_soc_info
- Removed the unused flag for SE_MU_IO_FLAGS_USE_SEC_MEM.
-  Removed the unused macros WORD_SZ
- instead of struct device *dev, struct se_if_priv *priv, is used as argument to the funtions:se_save_imem_state, se_restore_imem_state, imx_fetch_se_soc_info
- Removed ret from validate_rsp_hdr.
- changed the prefix of the funtion: plat_add_msg_crc and plat_fill_cmd_msg_hdr.
- indentation correction for info structures.
- remove the check for priv not null from se_if_probe_cleanup
- Removed the casting of void *.
- se_load_firmware function is corrected for not freeing the buffer when allocation fails.
- Checking if get_imx_se_node_info() can return NULL, in se_if_probe()
- imem.size has type u32. return value from se_save_imem_state() will be assigned to imem.size in case of success only.
- removed the flag un-setting in case of failure. priv->flags &= (~RESERVED_DMA_POOL);
- removed the function call for devm_of_platform_populate(dev);
- Checking for not-NULL,  before calling the funtion pointer se_fetch_soc_info.
- Removed the checking for reserved memory flag, before freeing up the reserved memory, in se_probe_if_cleanup.

3/5
- Changed the compatible string to replace "-ele", to "-se".

2/5
- to fix the warning error, replaced the "-ele" & "-v2x" in compatible string, to "-se".
- Added an example for ele@0 for compatible string "fsl,imx95-se"

Changes in v2:

4/4
- Split this patch into two: 1. base driver & 2. Miscdev
- Initialize the return variable "err" as 0, before calling 'return err', in the file ele_common.c
- Fix the usage of un-iniitialized pointer variable, by initializing them with NULL, in ele_base_msg.c.
- Fix initializing the ret variable, to return the correct error code in case of issue.
- replaced dmam_alloc_coherent with dma_alloc_coherent.
- Replace the use of ELE_GET_INFO_READ_SZ, with sizeof(soc_info).
- Replaced -1 with -EPERM
- Removed the safety check on func-input param, in ele_get_info().
- fix the assigning data[1] with lower 32 address, rather than zero, for ele_fw_authenticate API.
- Correctly initializing the function's return error code, for file  ele_base_msg.c.
- replaced 'return' with 'goto'.
- Use length in bytes.
- Corrected the structure se_msg_hdr.
- Moved setting of rx_msg  to priv, into the function imx_ele_msg_send_rcv
- Will add lockdep_assert_held, to receive path, in v2.
- corrected the spacing at "ret  = validate_rsp_hdr"
- FIELD_GET() used for RES_STATUS
- Re-write the structure soc_info, matching the information provided in response to this api.
- The "|" goes to the end of the previous line. 
- Moved the locking and unlocking of the command lock to the caller of the function.
- removed the safety check for device private data.
- Structure memory reference, used to read message header.
- In the interrupt call back function, remove assigning waiting_rsp_dev to NULL, in case of response message rcv from FW.
- do while removed.
- replaced BIT(1) for RESERVED_DMA_POOL, to BIT(0)
- The backslash is removed while assigning the file name with absolute path to structure variable.fw_name_in_rfs =.
- Update the 'if' condition by removing "idx < 0".
- mbox_request_channel_byname() uses a "char" for the name not a u8. Corrected.
- devm managed resources, are not cleaned now, in function se_probe_if_cleanup
- Used dev_err_probe().
- Used %pe to print error string.
- remove "__maybe_unused" for "struct platform_device *enum_plat_dev __maybe_unused;"
- used FIELD_GET(), for  RES_STATUS. Removed the use of MSG_TAG, MSG_COMMAND, MSG_SIZE, MSG_VER.
- Depricated the used of member of struct se_if_priv, bool no_dev_ctx_used;
- Moved the text explaing the synchronization logic via mutexes, from patch 1/4 to se_ctrl.h.
- removed the type casting of info_list = (struct imx_se_node_info_list *) device_get_match_data(dev->parent);
- Used static variable priv->soc_rev in the se_ctrl.c, replaced the following condition: if (info_list->soc_rev) to if (priv->soc_rev) for checking if this flow is already executed or not.
- imx_fetch_soc_info will return failure if the get_info function fails.
- Removed devm_free from imx_fetch_soc_info too.

3/3
- Made changes to move all the properties to parent node, without any child node.

2/4
- Use Hex pattern string.
- Move the properties to parent node, with no child node.
- Add i.MX95-ele to compatible nodes to fix the warning "/example-2/v2x: failed to match any schema with compatible: ['fsl,imx95-v2x']"

1/1
- Corrected the spelling from creats to creates.
- drop the braces around the plural 's' for interfaces
- written se in upper case SE.
- Replace "multiple message(s)" with messages.
- Removed too much details about locks.

Testing
- make CHECK_DTBS=y freescale/imx8ulp-evk.dtb;
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-se.yaml
- make C=1 CHECK=scripts/coccicheck drivers/firmware/imx/*.* W=1 > r.txt
- ./scripts/checkpatch.pl --git <>..HEAD
- Tested the Image and .dtb, on the i.MX8ULP.

Reference
- Link to v1: https://lore.kernel.org/r/20240510-imx-se-if-v1-0-27c5a674916d@nxp.com
- Link to v2: https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com

---
Pankaj Gupta (5):
      Documentation/firmware: add imx/se to other_interfaces
      dt-bindings: arm: fsl: add imx-se-fw binding doc
      arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
      firmware: imx: add driver for NXP EdgeLock Enclave
      firmware: imx: adds miscdev

 Documentation/ABI/testing/se-cdev                  |   43 +
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   |  111 ++
 .../driver-api/firmware/other_interfaces.rst       |  121 ++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   14 +-
 drivers/firmware/imx/Kconfig                       |   12 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  251 ++++
 drivers/firmware/imx/ele_base_msg.h                |   93 ++
 drivers/firmware/imx/ele_common.c                  |  450 ++++++++
 drivers/firmware/imx/ele_common.h                  |   48 +
 drivers/firmware/imx/se_ctrl.c                     | 1193 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  132 +++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |   94 ++
 15 files changed, 2592 insertions(+), 3 deletions(-)
---
base-commit: b63ff26648537a5600cf79bd62f916792c53e015
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>


