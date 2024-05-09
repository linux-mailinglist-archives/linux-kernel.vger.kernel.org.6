Return-Path: <linux-kernel+bounces-173978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0EE8C089A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E5D284614
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D143BBDF;
	Thu,  9 May 2024 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gRMGHo6d"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51D376E1;
	Thu,  9 May 2024 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215546; cv=fail; b=JSZF1DbUGsImAEbX0d2F4kVLZPafMPsErjo6x/R+17pMXBs04umqhDMyLcWuwAkbqDiPlQ6/gGj1vwWM0pKLXjtNfIA+mgOXzDt97a2PEsQYA8MkthSsaRNK+qovIvcqRDlczLE971dES7VTYJyGlX8DsgPqQrbj610cU+QjoVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215546; c=relaxed/simple;
	bh=7ifINYCByfo5Rm2D01X9gpRbpguxgJzH/s1a2oalSGE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qZfdC6miqa0Edt8pZcJWLyRaZFoE0/lgFafepacLeHXpKapr5z35whRt/EvgWNFwUGp6MEq5gILwjL09cReCGxxN/7IuUM/dLme99zZT0tLZge16S1fLJjpA4c/gZv0eWrOqZWv1Nd8gOh+dfJfyzLACtZnZtezo1SmurMpZI2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gRMGHo6d; arc=fail smtp.client-ip=40.107.7.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ewv6KbmbWr2caoRLEj17PizqOnNwmO7LSHXhYp6fbJkAxOHISJcx+rzDNcsdpV2RevupHfeX3AcMERKOsTNoRTkZq+uWsu2wg8rfC9A/sOTm6yaTqx8P0BczJalnUwJgAXR0PmCvmXpc9njSZAwLrx3ddWeyii1PD13Rg7b4wXbfNKALxV2C9DflxV/v4rAgtBJDh8ybnoxCzDmo16i3A6GiXA3g6AiWB/4m3lpGaFPX8c8Y6+ALbTgbgMjTsTce3P+rHXCG+4715zdKkYUekHQXNJB6ZkNjXVs5erTZTISIoJIdqu5T3ladYUradpvzb5tw0z3OpZsq5eirERllvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZegWxIa1zIwZXyyTi83e83cwxK2CZBnVEV2ywdhASCQ=;
 b=Ow9BwA/3JN5RQj8EokaSNIVqX3rxV+YzZtvOr3gVLq1JAzbMcBezUrH2ZaJ4VTsbrTQ9B4rHATxO/Ym5zI5A7oxpsyFbC53LxBafri/4mcY3M3/hba7Bs6u8gCsRz5JTvJVD4It+sFxGot/vqBz7ZQzcTYj5aG7hD1RDAAsov5Dhr4ldbLVZtOMNrJr17jFwIgtDj8+KPUOu8LYhaqsqVYYz37kWZ3frPHmbqJ4VhVuaB2qv1CstXR2wgiXMR+iGR4n32g8WkZFT6wR12DNrIsdupqZkflpDhUSrfl37K67ALCoUmsLPD5VdvsP0vym0hK5HS9NhF6CyYBxSo2A+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZegWxIa1zIwZXyyTi83e83cwxK2CZBnVEV2ywdhASCQ=;
 b=gRMGHo6dryrGI4IMsvBT47tqUgQ2RWru2u3TUBbEKmj0apq0vtrdMj/5pItcoPWb06LE5R643xstqXyAqHHvPjqtaQC4Iy7ug8kVnfDpsMwdg9c2ViO36PbZvgGySq3HR+VKC00HyhopOKP1RqEXYqzFnAUK5LV9qUJGhBVpbwM=
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
Date: Thu, 09 May 2024 02:45:32 +0200
Subject: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
 bindings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
In-Reply-To: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
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
 daniel.baluta@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5da18fb3-c361-4791-1a91-08dc6fc158f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|52116005|376005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWtEVGlUbHlGYnRqVVVJM2p6dERvZFhsQk1LeGNrUkVpK3lQRFBReDdzaUxK?=
 =?utf-8?B?UVV3WDRnRzVCZFR1UzRrZGx1eEI0bUJJUDdxTTR1dE5KbEtyRUNWVVNiemps?=
 =?utf-8?B?RWdvdlYyZEYvSDNQbUhUVnNEVnRwYUt5U1ZGMUMxd2NSdmhnQk54NGkxUFlZ?=
 =?utf-8?B?L0I4akhDT1lCREUyL3RoZDZMTFNYUnBIdk5ZSTJvUHd3Ymk1K1ZuUlRUZWdN?=
 =?utf-8?B?a0NhZFZabnZKZUtXclU1ZElPcmlTdmVFYlBsK1NKNFJKekJWVlpnOGl6azM0?=
 =?utf-8?B?Q1pqM0hOLzJEUjlJY0c3R2ticnVWUWdZSUVBYXNReGRHS3V6TU5QRUcvSEdm?=
 =?utf-8?B?OGFkYVI1bWhNMldLcjZ0ejh5RUVUNC93empGdzhvT0pLUFNybi8vUmYvOHBp?=
 =?utf-8?B?S1VheTJ1TXVaVEFQTlZpcmhwNWR6dm45WVU4VFFDTG9ERnhpQTY2M211V3dq?=
 =?utf-8?B?Q0dnc05SZEZ2cmw2MlpJanFtWWJBVXJva0hrRmlRaXd4RW5UWndTa0Y4am5L?=
 =?utf-8?B?SnRiZ3ZKMUIrYVVqMnhObEpDNDM1Y0g1MC8xYmJvaDEzckU4YTFEY3ByVGln?=
 =?utf-8?B?aFVTbVR2NU8rekxJUTNRaWtPdVFKbkp0TXVPN3Jia3lpVHVEdGxlK0tYcnFT?=
 =?utf-8?B?VXRxTTkrOWFiaWNUZjRmeG43ci9oTkdkWUorWUVLUUsycnc2aUZTYW8xNU1m?=
 =?utf-8?B?SjVJVENqVldoa2xxanVFa0VjUTk4Mkh4Z2ZKZE9hamJmWVk4SVVMTkFtZFFD?=
 =?utf-8?B?V0xheWVtS3RFWVdWdW53U0ZsajR1NTFiUHVVbFM2cVMvTzVYN0lueHZIbUtX?=
 =?utf-8?B?cHVkdkF5UHp1RFpuZDdMcGROWi9haW9KaDU3R1J5K1FOcUxST21XT1NTN3pQ?=
 =?utf-8?B?VTdoSmJoYlhESmZ0ZWZMODJ0eGxaV3owSWM5NkQwa01WRm1HaGtFVklLelpT?=
 =?utf-8?B?b1ZEU3RzSGs0RG1aZCtEMUJLNzlmL2ZZZ1BRaTJ4bytXdnBITHQ2bS9uSUNh?=
 =?utf-8?B?czh4N1FNa1krYTU4TjZSLytLQVdBeHlDd3JrdTRWbjFwaFpOTHNhb0dmclBu?=
 =?utf-8?B?djY1aVJkandXSDVUWThTMHF3ZlJCVkRBUnVmMUNHZmZ4R1c2RVlJdmFHNlY2?=
 =?utf-8?B?Z3RSK0xHZWxiQmZ4OURvSnN4M0tkbVovTHFNdHpzTCt1Vm41amt6eGZZZUc1?=
 =?utf-8?B?N3JjaXNKT3cvWlJlVFhtRXJsbEtpSzU2b014R2crZ0FEMGRSZ3dZMTRUYlMz?=
 =?utf-8?B?aWwzZWdEZEpWRTVRSk1NdUVYcUZWWG5iMlZhVytRMmI0THNwNThRUE1UYXgx?=
 =?utf-8?B?TzdHcXp2V0MrLzEzenE0T2cxYnFjU0ZKanJQM0tKN21WWjI1dVVRTVloZTJC?=
 =?utf-8?B?WlhXVnlqaER0dTUvckVmRVBkdE1KcVFrR2FMOE56S0x5aXdidUJ1ZlF6bEwz?=
 =?utf-8?B?NHdETzUwNDYvQlRRMVZXOHh3MXZCZ1QvM3J3TDF5b2Zxb0dDakE4ZTJWTE5F?=
 =?utf-8?B?KytuVVB4b1ZCcElDVVpOeVZqb084Y1BMNk1GbXdwRXhmOTVXOUxJOTRCSUo0?=
 =?utf-8?B?SzZidUtFanU5akJqejYzNE40ZWRMdlBnc0syMWZWekVUUzMwcmpuUTRRaWdP?=
 =?utf-8?B?Y3Yyamd3RkhIV3Q5R1JvZ0hTczlnMFQwa2xDRVJrdFFUU1pxMVh6TXh2NG90?=
 =?utf-8?B?b1NZc1BodEJncExoaFE5QjZ2aXVRenY3dnJob2cvNUQyUTk1a2h5WnNCdHho?=
 =?utf-8?Q?RaFeyePpDgF+2OY1C8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0xteHZJOCs0OU9FUURoVXRaR1RJTWFiMmVTdkpTdWVnVmYycVB5VXVPblV1?=
 =?utf-8?B?QWl3RTVsdldSVXZyRUlkN2pBaDZFNDYvMHB4YjJuaXBuQ3hYTlRLRXh4dUhP?=
 =?utf-8?B?b3I1V0RlL201OVI2Nkt6WWRxUE9mVUhxRXdDVkpIcnE1UlVyTGpvT3BZcDVS?=
 =?utf-8?B?THlUa2xXVnd3YTd2YmwyMVZFZHdULzZhTU0yRnRRbmNSaDY0SzBtRFFRY1NC?=
 =?utf-8?B?MCtYVGR3cEVRRG5vanREclJrWXVnOGNQa3RPQ05waG1yOFljdVZCQldReDJO?=
 =?utf-8?B?dzBWdTg2TEZSTklKUEJvQmx3RndNeFlzNlU4MFJwMXpyVkZnbkREZlBmeGdx?=
 =?utf-8?B?SkpReHNmUXdiS1hOdWZJL1RGT0JkQVBvTEUxc2pQOUFzRGpwVUdXS1NoME9o?=
 =?utf-8?B?OHQyQi9DWjFFZ0lGa0UxYWU1WW04TytsQ1MveS9ic2hGWWxKQ0NaN2FDV0Uv?=
 =?utf-8?B?VmExRTlHb3pZN1EvUUpjTTVLSEdNRlJVSHJuWGl4SHBlSEtlSlZFU2hmUWgy?=
 =?utf-8?B?b2JKVG9lMm52am4xZ2dDWm5lNHVKTmx5b2hoZE14N2RORlp6QVo0SWVEekVQ?=
 =?utf-8?B?NlZMbHN0azl3R2VZQjVaYU9vaDV4UW1oU29vdmVETUlubGJvKzBlZFN1R2ZC?=
 =?utf-8?B?R0JJNFdvcWgwT2piYi9wd09ubUg4ZkhoQ2Y3bkZiZnoyTldJUjlTb2NwZml3?=
 =?utf-8?B?V21UZkdPa0wyeEUzUUF0TUNoYmtWbkp2SU9SS2R4NzFmK0VGTVVwQkZhNVlG?=
 =?utf-8?B?MzdHVktCejJ6ZWxlSjVPUWhmUVdKUU8rS3Z2N1gzdDZOTE1TeklhN285OUVP?=
 =?utf-8?B?QUt1TjRDK2RPaGZCdm1LakNkQUZNK2Izc0E4djdxVjNDUVlEcnpTUFk1MDZM?=
 =?utf-8?B?Q2x3L1FmZ3JGNVRWNG1NYW9lSkl0K29PWi9BMzlZUXlidHFtazhPbUwxczV6?=
 =?utf-8?B?K2dFTmtBZXN2cTNKSkY2eUdRa2ZEZEIyNGdoWDRrSXJRV1FaT29VR25zNGNz?=
 =?utf-8?B?MDZja1AvMjZJZFlVdmVoS0dZc3ladVNIMGRvblkrRkJ5ZXJYMm16eEZCcmtZ?=
 =?utf-8?B?b3pqd2xGeWJjQ0tHQk5WWVdGUGt4b0R1MFI1SXBydUE0VWNOL0tsODFVdnp4?=
 =?utf-8?B?Z0E4bFFEc3dzdTFaUU50RGNSMDZCMmJTdDBJUzlTckt2cEdLNnhuU3o2cHdx?=
 =?utf-8?B?ZDFXSk9hREV3K3FOYUtRSDhxazdZNFJFSllkMVBaSENuKzBTL1NJN24yUUpY?=
 =?utf-8?B?UmJQNmVZQjY1YnFOVmVnZEVwN2FQVkRnbThGM2ZodlozZFJsLzYvdjltOFdN?=
 =?utf-8?B?aU5sK3Rvazl2Y0FUSGJEVWNNWGtLUjBjblNSMEo1eWcwNUlqdmVTT0VDVkY5?=
 =?utf-8?B?OUI5QitMd3l0eFBkNjNFbmxIb2t1Qm9tcDNjYnNsT2VxcVZJZVFjNkJzcDhi?=
 =?utf-8?B?NjJmakZuMDJGRnljRkRXcDM5V0xJUFRTdER1YUhCc013c0pqYnRDMkEzTTNR?=
 =?utf-8?B?VFR2TDJ4c0xaUzVGRWJ3WnVCNVpyWFlIbkExZy94b1BCTnRDRGxlb3UyalEw?=
 =?utf-8?B?YlZTM29MMXZhbHdJQUdIa3VFSFdRR25pQXhEcW5RaGo1cm1yTFZsY2xzRXcx?=
 =?utf-8?B?NHRhSEt3RWg1SURRMXhQWHdYaS9zOFdWNngxWmoxdk8yUmN0NVRXVDdQZ05u?=
 =?utf-8?B?WW1FZFRrU0ZMcFdHN3p3WnB3Ni9GOHUvV3Z5Ui9HOGFNS2R1d3dTdzgvZFVZ?=
 =?utf-8?B?eDA5b2ZIbHRJMEtmblBJYU8wWlltS01xVk9nNEV6MXYwTVNLTVFxOGxTcEFm?=
 =?utf-8?B?cFBXL1AwV0FIYzFFOUZ5dUdxNHVHN1VDZ250UGp2YWM4RXZtSUJTYkhlQ2Rn?=
 =?utf-8?B?eG9UM0VNaVpyWjVCcE05bUdwa3RKZmdXRzc4aTl2b1BLa3VIY0sxdEV6TlN5?=
 =?utf-8?B?a1FEUk4yMDZzZlAxUWNFdStCNXFHRDZpaWJaSEdXRzdFNVB4Yjk2TlREdlY2?=
 =?utf-8?B?RE1FK0tlNitXaVhYVFAwKzR1NjZmRml0QWNxajVGNks1b0ZXWS9ZMjFDYXVJ?=
 =?utf-8?B?dUR5empXL241NGtacmY4UjUxV3pvbzVjVmg0RGhqRkhMSWdwT3BFeGRINEt5?=
 =?utf-8?Q?yMqlyfyuOmysLeCM0DXwko6MZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da18fb3-c361-4791-1a91-08dc6fc158f4
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 00:45:39.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4AxLtI2odJMYrAoPy3MSqb62RdVvlT3q8YkgwevqdWf/Um79ESyFnkvkNa0enuF8iMiI6YREPLEEWvjAV0Apg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273

Document the secvio device tree bindings.

The tampers are security feature available on i.MX products and
managed by SNVS block.The tamper goal is to detect the variation
of hardware or physical parameters, which can indicate an attack.

The SNVS, which provides secure non-volatile storage, allows to
detect some hardware attacks against the SoC.They are connected
to the security-violation ports, which send an alert when an
out-of-range value is detected.

The "imx-secvio-sc" module is designed to report security violations
and tamper triggering via SCU firmware to the user.

Add the imx-scu secvio sub node and secvio sub node description.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu-secvio.yaml     | 35 ++++++++++++++++++++++
 .../devicetree/bindings/firmware/fsl,scu.yaml      | 10 +++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
new file mode 100644
index 000000000000..30dc1e21f903
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-secvio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX Security Violation driver
+
+maintainers:
+  - Franck LENORMAND <franck.lenormand@nxp.com>
+
+description: |
+  Receive security violation from the SNVS via the SCU firmware. Allow to
+  register notifier for additional processing
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx-sc-secvio
+
+  nvmem:
+    maxItems: 1
+
+required:
+  - compatible
+  - nvmem
+
+additionalProperties: false
+
+examples:
+  - |
+    secvio {
+        compatible = "fsl,imx-sc-secvio";
+        nvmem = <&ocotp>;
+    };
diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
index 557e524786c2..b40e127fdc88 100644
--- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -129,6 +129,11 @@ properties:
       RTC controller provided by the SCU
     $ref: /schemas/rtc/fsl,scu-rtc.yaml
 
+  secvio:
+    description:
+      Receive security violation from the SNVS via the SCU firmware
+    $ref: /schemas/arm/freescale/fsl,scu-secvio.yaml
+
   thermal-sensor:
     description:
       Thermal sensor provided by the SCU
@@ -197,6 +202,11 @@ examples:
                 compatible = "fsl,imx8qxp-sc-rtc";
             };
 
+            secvio {
+                compatible = "fsl,imx-sc-secvio";
+                nvmem = <&ocotp>;
+            };
+
             keys {
                 compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
                 linux,keycodes = <KEY_POWER>;

-- 
2.25.1


