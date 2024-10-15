Return-Path: <linux-kernel+bounces-365430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC499E22A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EF41C23087
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4311DACA8;
	Tue, 15 Oct 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RDONsXzq"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD741D9A60;
	Tue, 15 Oct 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983140; cv=fail; b=FOXC1kh+fwNzvc6nAqdHC4/tj7uA5xS57e/Mz5RSZCfJdTazubRwYWKU3dN8P0J24Q65GccfH1k1AJbiWhvgmTf0E5XTN/86CP4VJ7RzP3Sqvq3U2CC3XGQBNBRE+1J9rqS/vU2G6zUmRaynRcJfrEiZPT0Jpm0p6qD4Yx0au/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983140; c=relaxed/simple;
	bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UDVpWXbWQ7XXCMigEMvuzrUweFHg8Kb74Jd7Kx7NwNdvHi4bMIgiKqdbBftfkpMZpT1i1io2Du62d+x5INa50Nnj9ytZ4VpPwXJMSGeb1eWI5Nro1Ky+YWk+hpz5luZpFQC//0hKEsvBanHnB14/4iaXGgesCje/Ya4HVlAmliA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RDONsXzq; arc=fail smtp.client-ip=40.107.247.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiY9/AUirsKO+93dkEnntxkWC1IPm6/L73J2f3Y7W00/R65CZq0FOEUnKiLnFmXkI0H+spL4dPod3YrBbywsk53Xt9TshLH5+zG14ItA74Y/9RgEwzTDfPRPJkHkfWJeqJnVvJbztTHcB2f8+2S2DrB9mMpjt6PcFt0dAgjWq48UMuTmUfLrDCoGxtOFsTAj3pgafkS2E3Mt/K8+iItHU0hWqOgocPYMxUTXZvbuQPGl11bvuInu9EiWdgQkDCNmx12boV3I51CSdgXrSm0FtnGiGKPHdPD2BCBkF4ZokFNLwZJhyjmvFPGiFvqZlaMMxe5kSR//FcUDx6jopK9Dwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=ydUG20sT669wdhh+FCQZ/SUVmCl92pc4EE2g6OuTK+Y7TsSsH2e4O3zHR6NPx5XPIqz/nb2gei9UFNZMquiD01Ss52gtE1uGgyLGgJ1bQUAQN4+hJ01RZWrRT/ok4DsqiOAI6J4UfqZq87b9CFtVV7I8j5G3tOPj3ffItsJGQPPPKJSPvlLSzniz0LVTSAkZtXXEZMFd7etOw99GXWJiurXRP1AaVbgE8JrNbuuQiHsqSnZWs6cPIiuPUNmas6o834M0e9VhVtLm4+/QyBMjDP96nB9uaCdctINZy9hLcIaNjxb121H1gmnkWt7wJ3TR3ci0J+EfROUF4nj2oSJPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=RDONsXzqJvvNc/Uk0gKM7+zJ4SDleFdu4ShB1Hhen6MahSsspACnQIsdh6c2Z87Oqzf40J57hnbiGPy0+2/J69p4YUP8M3yqnXf00r7N1uYqiorJ75Pq4VbSor8+P+ZjrekSMI6d5TEj1waVnKweCB9N9rWrhOLNsWzpCHQBbNDq/DUP0CH81K89aJ3/O4kbDE8LGzEGW9DcP9zu53+oU6rLYBspDa0lphSw2MhXNIfov+pWkBWEnltXV48NLf1cPemv3tt5+B0J7AH2/Ft6u0X3FXw+TV0Cl3eD/n8Yp9o578t+QCK4Apw5FJ4BPj7EqxvoEu3dGf6/fkhaFzKhYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB9223.eurprd04.prod.outlook.com (2603:10a6:102:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 09:05:35 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:05:35 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Tue, 15 Oct 2024 14:30:59 +0530
Subject: [PATCH v8 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-imx-se-if-v8-1-915438e267d3@nxp.com>
References: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
In-Reply-To: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728982877; l=6679;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
 b=u+8NDXlnVE7athGjzhrM5LJk6qkb4yx+XAWXSln9eLk47fEqSzrKRUSryd+r0oIYZQTInMVVD
 Mvjrch8YcckAboplriwhB928jikXwawOuqMH0cKafkiAvWRLYpGtCXq
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA4PR04MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 614c56a8-9794-4446-cfa3-08dcecf88784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkFMWFdBVFR2V2Zablc4NWdjeWFTZnBFMGZ0M0FWZHlGblNJbXo2VWlvSUpL?=
 =?utf-8?B?U2R5b1grSHhPcVBHNzc5dXNGUjV0N3dXNlRmd0JVTzZPcUdsV3R0L3NOS3RK?=
 =?utf-8?B?T3FaMm5xM2kyWi9oSnkzMW5RRFdxVDlaUHN2K1NLY2RLeTBVK0RVS253TTlC?=
 =?utf-8?B?ZHhJQStDUVh6bS8yU09RRk1zY0VNVXZYQzVIU1kyS091Y00rNXgxeVppcnkv?=
 =?utf-8?B?cVUrZ0Uzazl1Wkg1MndKWitHS3dJRGZjZkQxQUhZVU1IWTUwbnMrcWZYN2hI?=
 =?utf-8?B?ODdkNzZrdjBEV084RVR1c2RETHlpRUVUcUxvUkdyWGtFSERxY2MwSTdycU93?=
 =?utf-8?B?eUJkemJzQk1hZVpRQ1ZVVzdTM1NtZHhPazFrUVd5U0tVVFhnWDM5Nm0yYmZD?=
 =?utf-8?B?TElsYld0ejZZSm10R21vUm1WTFpkOFBkUmE1YW5pckFQSFNlZnNOWXh0WnFM?=
 =?utf-8?B?eUlzRHhXZnBlaExPWFdocXlENUVDQXVLNmFYUkpETE9MUFNGeTR2dzJWOTU3?=
 =?utf-8?B?WnUxeHc0Q1pxRTFqUUY2RG1LTkFsUTFCaEg2RE12UjlFTDdTMW9EVC8yVEFs?=
 =?utf-8?B?S0FnMFptRmhjQjJvZkNsbUd4ZHA1bDNVZTNkN21na21CeFhtNnA3NFpNaTdP?=
 =?utf-8?B?MXV3L1JVd0locWI4bCtxaUw3Uy9XVVFIZDZ1OGU4R2d0RGJNNkFPdVpjZXVH?=
 =?utf-8?B?dVVwckpFZXlIQnBsZk95ZWt1c1c2R296azQrcjZzRW5YVjBKUDNmNHNYRUps?=
 =?utf-8?B?SGliVWJBNG9qU015NlM0cVNoWE9nM1pYS2dkcWlobndzcWNTaGdCam9nOHBB?=
 =?utf-8?B?bnJxNTFOb2NpbXBXYld1M21hWUlhbEE3Q0lRMi9Cck9nOHhSb0pBOHlGMy9T?=
 =?utf-8?B?MzdHNjJvNWRwS1c0eVJFcEc1VnNFR1F6S2g1QnhjYVVlcDU2TURhUGNUTnNL?=
 =?utf-8?B?dUw5RS9GaHF5RFFPK3ltU0pQenkxdFp1MnRuTjRpT0M4WTU3YWFYRkxlc3FB?=
 =?utf-8?B?WXNkbEdwcDkvdjRONjlRN3hwU05jamJBVXZEcGQxOFF2SXVEN3VwaTBDamRZ?=
 =?utf-8?B?dlppM1BDWjI0RFMvZEw0WlVMWUc2RjRVTVR6eFBVWUEwNUJpc0IrM05tQms2?=
 =?utf-8?B?M2RHT2JHVSt5aWZ2Znd5bGhMcmVWeERJT2krNlVsK2o4bVh0d1BZMEpocDVv?=
 =?utf-8?B?ODlzWHdhdVdqKzNQNkYrb0ZzdkJ0dHVWbXV1Q1lFNGUzUVZVU3lTelNzTWdu?=
 =?utf-8?B?cE1nQmtHUjJ6M2QzeEwycG9HQXIvNXZZK1ZacCt0WHJDanJ0amtNaXNrWURu?=
 =?utf-8?B?dFN2c1l0VFVuSUMyWklVaVhSMkhBUzVwYXhkUHgzOEF2WXFLUldqZ1FHK01a?=
 =?utf-8?B?WjZYYjVjS3N6UGV0UEw4cVdDYXJvMW1XcTRBclRVajVBUTVQMVozR01kMXNw?=
 =?utf-8?B?T1hsd090Q0ZGckFiYTFvVktPWEU2RE1iWEtZL0xqOXA0b2l3NU5tQ1ZtVGp1?=
 =?utf-8?B?QXcxQ2J6eU5zSDduRXBMSnNUS1AweHlrdkRaa2NlRFNqYk5Gcno4cGNlSXBr?=
 =?utf-8?B?a2xYUEJ5cXp6Nk1YNnBkK1pLSTVudWJYM2xWRGJRRXZsYWg5QlFIT2s1Sk5T?=
 =?utf-8?B?S0Y4bFU3SmUyaGpBNk5IWkQrTVFYYTVXRXlNSGEvaExXdVFOY01lbWRhc1hq?=
 =?utf-8?B?bWZNR1J3dCt5L2F1SGx1WGVoOEk0anQ3UTM2Zk55Vi9aSUFhMERXRHd1OHBQ?=
 =?utf-8?B?bW9uNGs1dWlOSTFJV3VjQ05UWW1PaFpLQ1dCcXMrVnBKbkp3cHRiQUhKNkNu?=
 =?utf-8?B?RTVlbDJJek5BNGRlK2Fqdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlV6SjMxTS9DMkNzZG9FUzdnMEpqeVFoS0RtWG5Xa0d0eXkzNk9kNlBseldr?=
 =?utf-8?B?VTdlQkd4L0tSWGtjWXRpb3pVM2hJN0NVbUV1eTF6ZEdSVlh2dEdXRXBRWXdl?=
 =?utf-8?B?NGs2T1h3a1M0d05qT0NTYmNtYlJ4NTROOENISDVSWXVtWmJKcndTclFSelZo?=
 =?utf-8?B?TklSMnVxUEhWdXkxdGpmSEJKNzBLa3RNSlBxZlVucmlxNm5hUGpJb3U0dHVs?=
 =?utf-8?B?WTFqOElZUXRJR3docDg5VmVudmV1TWRRWWEyc1VWZi95Nk9aMTM4R2JDTE96?=
 =?utf-8?B?Ylh4TkVsYm8zRnFpYkdmVVI1S2VDNllGVmZMUFltL3VkeXdKZXd4bC9GSndC?=
 =?utf-8?B?WGwwSkRNRFd0cEtONXhaMExrRDJLa1diMkRyQkJiejlMd0dSVGtkK2VVMC8y?=
 =?utf-8?B?V1Z3U2huOTQzaFRhYXFxaDFHZW9tNWdiOFZNMWptaGxDYXErVnNTUnBqU2l4?=
 =?utf-8?B?R0VhQzNUWEFJQzVuQ2FxVFI2dHBCNXlyamN0UXhBdzlMTk1jdlFQWkhxTWNZ?=
 =?utf-8?B?Ui9KWWxHclRackNJZGp0UlNGUkpOQ3pxOVlwSFgybWpPbWUrNXJCUUJvSUxn?=
 =?utf-8?B?THNIMDhlQkZNOUdFZlIzN0ZEaG9FZjg5d3NyNVZuUFFySW53R1BtOUd1bThm?=
 =?utf-8?B?SXV1RldhcDNZcCsxRmhwV3hEeEl0NHF2dy9Lc2tmOHI2ODZUcTR6V3NDY2Vj?=
 =?utf-8?B?TFJxdGZIL3RGZ2hoWUIzaGFXNks1M1NPRkNGdW8zYnpOaFZ4RGRGUVNYdDky?=
 =?utf-8?B?VHhsTjNVM0hHRDE3UXNBMytDdTh2YklKalR4TElWVU4xWnovUkRwb3h5b3V1?=
 =?utf-8?B?S0tDSDdRdTRYTHpFL200QVdtZENjMVhubWp3c3IzczFGQXJjTkdwQksxVkkx?=
 =?utf-8?B?NUZCN1lGd21CZlZrWk9GcXNOd3Bnemwra2RJY09wWUdEVzM0RkhmQTZ4NlUv?=
 =?utf-8?B?K2dldStIRk1qcHdpL0kwV05ab2gxNUdWRTVEQ0RNMCsyODNBQ1JNclF6OExF?=
 =?utf-8?B?WC9QUXNqc0hxZDBWNFZIODBwWXVUclJKNnN6a1l1dUxvdGFranBkQjRSVHJ6?=
 =?utf-8?B?OXh2UmlybFRMbGtVenV4YVR6Q0hySVdKRGpRQmdpZllZQUZ1alJIV2JqanBR?=
 =?utf-8?B?b3BodGRMa2Z3Z2tORWdnbmY5b2tZNGx3RUlra2tLZ09zTWczbVIyNHFNbURt?=
 =?utf-8?B?UDhSMEIxOWxSSkE2K1FQZkcyT2ZSMDFwTGVOZkFoeDBNcTUreFdsZnA4SXZM?=
 =?utf-8?B?TGdWYndnSmZDTWdoeVdyWGs0ekt5VnRXY2tQblMvVGRjRm9JcUh0cWZ0dW5k?=
 =?utf-8?B?Qy9ZV2dUK3VMTDVxRzFURDdzS3FvbGJtTlYwK3ptNkEzMmUweFFESkttcTdM?=
 =?utf-8?B?MU1ZVUN5VGxuU2Z1UkhZMll4QmZsTTRlNlVEdk94blQzMTNxOTlCRnQrUEVP?=
 =?utf-8?B?elYwSWdTL3lQTktkVGNkNWhNU01WMU9Bc3pla2RoakNqdlNDRStjUUtYL05q?=
 =?utf-8?B?bFpzbFhwK0poVTlwN2drVENxTzBSY1VWNHdJMy9ER0NWZHdSY0I2VXJMU0pI?=
 =?utf-8?B?bTZwMVFQSElkU0pQUG4xQnNadDlUNEs5eVhOUDcrb25xYlR2YWhKcXFnOENO?=
 =?utf-8?B?R1hKTjZSWGg2OW0vRGJsVmV3TVo3Q2Z1Q2J6ZXNyZm5qWDNLMFkwRmxob0o1?=
 =?utf-8?B?R09BRExoK0FCY1ExeStDVmVsSWpPMUJsMW9waVlKMldhYmRPZWY2bVlNSkxI?=
 =?utf-8?B?MXoxYVJVUWNORUNrOXRBaU5tM1pCckhnMExBYTl1a0lqaW4zVXFjcXc3b1Iw?=
 =?utf-8?B?NnpOUG85YXZXSDcrSkJ3aDhrT1ZtbjB3TndzUnNpRTdFbHhhS0pTNlhJYkZr?=
 =?utf-8?B?YThaOXZrelVSODAweHI5ck82NlllQXJxbGtKRUJ1cjR4aGQ1dEFVUXpUSm0y?=
 =?utf-8?B?amF3QzhkS2VOT241Tzd6V2dacWpzd2VXSzlQK3Q1SUdDUE84REZMeGtFNVVy?=
 =?utf-8?B?dFFRTUlOQ3M3NUNOdWppWEl3dVV4a2dHbEMrZXZDK3BNL3RXM29XZEdzdHRx?=
 =?utf-8?B?ZnJ6eVEzYjRzUFdUNFh1cEZ4eVYwOGQyQTBiYjhObFZRZm1qS2lOZFg1dXh0?=
 =?utf-8?Q?jz9yya//CVLvGIEVotn8w4WZo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614c56a8-9794-4446-cfa3-08dcecf88784
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:05:35.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jEapWi1WoUKkP2X2xqJ5EPbdcglHNyxdgStp0avvXtQTj+5SzGvvAK66XmNiqY/b8mKk8kI+nA2LCKxh03lMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9223

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for Secure Enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst       | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..a3a95b54a174 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,124 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock Enclave, V2X etc., creates an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exist.
+
+NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
+Communication of the MU is realized using the Linux mailbox driver.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
+
+Each 'se-if' comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the messages to be sent over an MU.
+
+  - FW can handle one command message at a time.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over Linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.34.1


