Return-Path: <linux-kernel+bounces-242598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B48928A4B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1362C1C23053
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58818166300;
	Fri,  5 Jul 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jXjZHlvE"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013049.outbound.protection.outlook.com [52.101.67.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E04615EFDF;
	Fri,  5 Jul 2024 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187783; cv=fail; b=WJvNnDlzThPNaLmUeKs2PaXKcyYJO0+LUjyTB3BMJ9cDQLcgZLpO+uksjNBZPtQZWb9nuC3CPzpBI65EN0pzIIbe01p6oED+6+2ppqNuAKxbXi6MuDq8dpG8ofo+uCYP8vVPeFe1nZ1SnbO1eEsiOVHagnFuSAOpY4gj21iyS54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187783; c=relaxed/simple;
	bh=Yzx1EiNB1XI5GYHldDmmN7vKHPasRxqhlyHvDvz2gtU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cRFTCvgGf+VLW9dbYTPNHi1bmj0JZVF7hgLnDlfev+Mv2h3nTV95aSq/Z2sbqyW1iXMf4ENCo7ofnD+X+cpuJbfGcwKf5DkVK5U11aUe3QT5G1ITA7a0TPYXiaTZ/YpkbRhg6tWZMskXZDTxpb7Wajbfs4qFBfEv9/NhI26yv3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jXjZHlvE; arc=fail smtp.client-ip=52.101.67.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW3B0TyyUTZvfzalSC9+la7Rv1Fz4xNCF+tcnenZ4QTZhCq6olO0kSqdRRaep+EQTqNeav+IxDOejnKuTfpU4tIQVK5WVtKWH9WtEk9mpm77tipPXZcNgUXuqC19JRfzFfVAp6CdUSiXB6oza6kM8weme//S61186KeZ6HaACTZCj/dCe44fRS8dod3TtcOaEgyWZo6wgZeI9oo67gRjCZuskVDgKKi5+cnpu9YrqoNISP1iK8TkXgNCX+uebv3L3thqBccxpNem37VVJzLUP/hWbbCvY2VhsyXcIrkn8ZsCcMe5MqhA5bznbIbK/95UC0Natwfl2T1DxMIXE+lz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPzh9uceNBt0v/S7ki1hRFC18MgLprUPAVZmnat0MGg=;
 b=c4l2HqfQqX5msOqxtUgiP//YqkIaveEqhuQeKX1vvVJnxyYlbpdhf0vgX2RRt6oIwO/6pgYqV+gnKugmzy8j69x4tw33cklfNcwwYpfN5dfMR6a9Rx1wybj0Ps2yt1+KjzBswf270UC0Ptp2rsIofGDwhiEdqjn2JB+6xh1DvPIwgi0ixsfo2quGO2g6FyS5iRfk1aIGDgYKhmIXoPiSrGINMzAnOgpMlcI9U5HN02VWs7jreQkl5/ZtwQ04zuRuG7/zcoa7IpU5O61J9eeIjmXfLUd4KfiZ7AUnjgfA7oovOtT+cBXl2ZAW82BeNPCMdB4ovZq52D6HpSiQqi5ksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPzh9uceNBt0v/S7ki1hRFC18MgLprUPAVZmnat0MGg=;
 b=jXjZHlvEWY6SyLWIlWtI5lVJ6keQWaXnpMjPyaA7NH69mAZUXPNx7GLfIqtLdrt62rSdLtrmRyTizScZrPEepQMp06T1/B0EX3eIb7blEFlxiZ8AgPGthlVF+4oD31kx8PVv4DHgDIDnNpKEPoWXRZfg2aGEk8plGiHDgyxN3s8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB9260.eurprd04.prod.outlook.com (2603:10a6:10:370::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 13:56:16 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7741.030; Fri, 5 Jul 2024
 13:56:16 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Fri, 05 Jul 2024 19:22:44 +0530
Subject: [PATCH v4 5/5] firmware: imx: adds miscdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-imx-se-if-v4-5-52d000e18a1d@nxp.com>
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
In-Reply-To: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720187574; l=34569;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=Yzx1EiNB1XI5GYHldDmmN7vKHPasRxqhlyHvDvz2gtU=;
 b=0l0xAa6sYpk2LAISxCHX4y8+C73df+/AAYgDLnJcAJH+O3FOUn3vCOQqsbjdJj9QAfiv/iFcm
 Mv/MrpWB3fjCQnaWW12/e2YxtlZUeeU7mx7cxFDnwQknLYW/dzo2pka
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5dbd1c-21ff-441f-6802-08dc9cfa3cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWxLVDJWWnRDQXh3SG02V25DWWJ3T09LWkNwWDJqM3NzL0JvdVkydm03TXBO?=
 =?utf-8?B?QWs0L0R4dTQwUVVPOC9XQWlFNjdiUk95ODdpSkFlek0zMHpqVEM1UWlySGJE?=
 =?utf-8?B?Q2NjUmNrbTZlWWdyRU1pNDJwM0l2Zkk3eGRxcnVVeHlEUHNaQ0xxY3pQM2lR?=
 =?utf-8?B?c0hRWTR3T2d0VmxiMEg2UW5FSm1kRmRSSjVZZ2tWaTR3Z05LZXJ0VlRsS3pG?=
 =?utf-8?B?aTMvalNmRFlSaHNiUlNrbjFTN1NMb3BxamRXanMvUXNNTTl5SzVCU1dDc2xy?=
 =?utf-8?B?Q3Y2Vk45dElaRFhZdVNpV05XZTFuQWgwMXZJTnJlUU1kb1Y1ZmlxaXlHbzRl?=
 =?utf-8?B?cDZ6S2lmdkNkandmMi9YUmpJd1BRbWpJU2FmSUh5dnV6V05qWkhhUDBNdEda?=
 =?utf-8?B?cjdIaDh3WGQzdGxJNnhDRGNzWkN1VjdUd3EwdWFyMVIvd2tNK29JeEhFWVVO?=
 =?utf-8?B?M2wwVmtLMnVUTVhJRzlqNVQvTjdrdHBXZDJqRHBUYXdOZkxueEpRM2RMMDBu?=
 =?utf-8?B?blozYWkxU1p2azhCRGRpNnlEUDhLYU5uWFU0WlVkU2hCbDdwcmhKSkNzMU1v?=
 =?utf-8?B?VUQzbENSVmpnNm1kUXhUYVhhU3NRTWErSWFiaUpmSm5kT0ViOWh3WVZxc2JG?=
 =?utf-8?B?dFVSQXpZSFpCUk5BTjVBZXYzMHlEYmZTaldndU9sbnc2RG5sS2ZSc1NFV3JC?=
 =?utf-8?B?WjBCRUEzdm9tM1d1NWpUbFNMRUdHK1RocXpjcjdGb0R1TnMrMXMxKzZCOXFJ?=
 =?utf-8?B?NGNJZGlxUll3YzJGTzhjSi96eWFRRHFjcHFoOW8rMVZCVTg5ZkJzcm5HWDRm?=
 =?utf-8?B?M2d2WW1JYmFFdFRUWVRVMnpVbUxFejNHc3Z5WDMwNlo3b0dhTlVZWVg3S2px?=
 =?utf-8?B?cTdFWmNVbUhBdnl4YVI3cmtZTmdMMTV1SENuT3ZlQWhRbVlmcWx6cjVTbElW?=
 =?utf-8?B?MWdveTROZzYwRlliWDFUVnJjazE3MDBDQmNoMk5saDVYSmFod212K1NITVMv?=
 =?utf-8?B?b1EvN0wzaW5jUVhVOHl6NHhsRitzM0N1WUs3UzlwZXF5Wk5Nb0h0d256bEVH?=
 =?utf-8?B?ZXVqYlN4L3Qvejl6Z2NQYTFUZmJ2Sm1menU0OThCWktFZFU2SXdselQwSnVR?=
 =?utf-8?B?MEtLY0ZWd3lJNWJJZ1VOZFlJTjliaklxSGNpbS95N0FJY3QxVVZ1cDZCLzJM?=
 =?utf-8?B?d1BseUpOUGREaUY2UTI0NG9HTGJnRzZCRllpMVRwRHJoRGdjTDVKb1ZsWThv?=
 =?utf-8?B?VlI3WUlpeFJuL2hQRTVEZ2N4L0NBcWxXOW5jd2Y1VzA5WVBWOFc3SVA0d2p2?=
 =?utf-8?B?RWxDNzhETDFoamFhY3l2WlltK2pPWXRmcTdpUXlBeWZnY01RQTArZENzYkd0?=
 =?utf-8?B?VXJiV0JRc0tLUFRReHhZQ2gvdTZiZVRrZXNlZFZhTDNKQXdmaG9qQnBEd1Q3?=
 =?utf-8?B?M25ITy9hUlJDVFBQUDRwQm5VVFdBajAvckxsWENWQlpnUWhNWjBRQkFMTEJu?=
 =?utf-8?B?TVY4Zjc3ejEra0N2TXhZTHNDdFp0a3lXNTBFMDliTWI2aEVFM3o3bFJQdjhz?=
 =?utf-8?B?K3JLakwwRmlpM1dvY21UNmlodDhaMEZQeTcvMmVhWjRHVHNyVTlJaTRodUZo?=
 =?utf-8?B?cEZJcEZqYW11VFhKRkpTSi9BTVhQZjBHOEMwNjlxR2Fxa2l6Y1hMandXckx4?=
 =?utf-8?B?U1VyK1VQWXY1ZDNKMCtkMVVlaDd5K0NEMi9zS2g1eFNCVDNFNHY3cnVMMXE1?=
 =?utf-8?B?Z1EycXhlS01lQWo5anJkYnY1RStXblgweGM2a01vSEo5NlFnYm0yeDRhSzUv?=
 =?utf-8?B?dzZ1WHVYSkVER0NjY29RbzlPdldjbEx5azAyeXdLZFJTSW85M005a3NsQlZw?=
 =?utf-8?Q?+5DnAWvs/O5+R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVZGN1MzbHI1TTIxZ25yOWIxcDdqbkNpZVRxT3p3cXhqV0dIek5xTUlOTDRz?=
 =?utf-8?B?ajd6QUh1ekVXd29nYTRiOVhNU2ZmK2hzbm9xcmpDbWFpNTF6M0Nad1ZWNkZT?=
 =?utf-8?B?ZjJDQjJhVU1xdmtWQ3F2VGxnUzVYRDRSSys1NkFSRXZxMnYvQS9pUysrMlJ2?=
 =?utf-8?B?RTA0N29YTlJqT09kQTBpY0ZHbTMwWTFzcnBLeWFaM0d4RDRzK0ZGTjdmWTha?=
 =?utf-8?B?cndVbmlRbWxjWDE1dlI1alMxMFNoSlF0S0dkVGNPd094ejNVK1U0Z3Ria1dw?=
 =?utf-8?B?VllRRXZ2eDE3eFZxTWxuZXFWOHVQaGFuUjR2bUVra2VtSllrczI0SG1LdWw2?=
 =?utf-8?B?N1VNS0E0UUlKb2RZRDNYUmR4bkRuM0duNTA0cmhYMTFFSGhXa0lrNmRHWm84?=
 =?utf-8?B?ZmRpL1JScTF4Wm5sWmFqenUrSzJ6cEVpQVhISWNvQ05TMy8veWV4OWlRdE1V?=
 =?utf-8?B?bFMwalIyTEVDVXRmbUxGc3NkU25YMEVOZDhBQ2Y4ZFVBVmc4dWdMa0taa05t?=
 =?utf-8?B?NVBtVlBwaWZxYTNPODE2UDhyNWFzMVVwZ0x4UEs0VjNTZ3liSGlTMys1SkhZ?=
 =?utf-8?B?NXkyZm5WL2pTUkRNNHR1QS82ZWVTT0M5VHMybFo5YkphYXRPWmhrUVNZdjZl?=
 =?utf-8?B?cWV5aDJha3cvUmc3Rjk1Um9adXFrV0VlU3htbkJra0tVYkx4MUozSTRiRnFm?=
 =?utf-8?B?emFKSlU1bEl6cXlvM2o5VGIzQmZxZ1NSSGk5eGcvVm5yMFdnRVVmdTYybTAx?=
 =?utf-8?B?YjBpdjFoUXF6TTgrbVpVN250cVVuajcyS3k2eU84NWJna1dRU2YyRXFHU3A4?=
 =?utf-8?B?cGZjNFJIR1R6bFp3aHZxWXhVRGhaMnhoQXRaQTArdXIrWjNxYy9SRHlqTlli?=
 =?utf-8?B?bzJVYzlCUTZqeGRFUjd1NU1QdnFLWG5HUUZ0MWhaQUtiU3dOV0ZKa1NrZUlq?=
 =?utf-8?B?cXg4dXV6d3ViNWJwbWU4Vzh1UWRLSGFKWEtUb0E1RU1SallEaFc5a21tblQ4?=
 =?utf-8?B?bTdrcXZMaFVET1VBQUFYRUhqTi9vUXdCdldDcU9Ja0pOVzFxb2NicE96S2lk?=
 =?utf-8?B?REZUUkNuOVpMU1dwYUN5UStoL3lGVzZYcHZlbVZxWG5LYm5uZDFEL0k2VFov?=
 =?utf-8?B?WVZ4S2JHdk04U1dSV2N5enN2OWh6TDVaYVZHOGYyZFhQUnFSQ0NxVWl4Q0dK?=
 =?utf-8?B?OVJwTFlxdEl4YXoyTFNoRlA1Z3hEWjhUTStZcHV1dXhmNnBZUThDd0NERTBR?=
 =?utf-8?B?Zlh3TjJjUC9GYlRnU1lJWUNXL2Y5Y214aHo3Vk94cmMzOVhYNzlkKy9OT3N1?=
 =?utf-8?B?Y2NZdHh1MXl6bGJRQ0cwV0FFenp1STNPMUJFOHY5eTNCUjFjSzBqRlRlVVFz?=
 =?utf-8?B?RERFVWJiMmpQS1ZMWDhOYjJtQ3V1RHkzZEVQTU8vZFI4KzJ6SC92cVJIUkVl?=
 =?utf-8?B?V25vNzMwQVlFWXg5emcwSGNzV0lwYStDa1lMRWNqdjdzY2ZXRE16MVRjVk5X?=
 =?utf-8?B?MUNiRWtkUXRvaCtOZnJIcld4Q1RQNjJONzcxcDZZVi9HRHoyeUUxOTNZa1E5?=
 =?utf-8?B?NllHd2dKdkVZckhiREw4clZNdUVtVDJiUmsvQThLTnFOSS8zeGxMMEZuLzMx?=
 =?utf-8?B?RnBORUsrQlpObEJvREpKTCthcWtWY0NDLzhrQ0RZdjRIUTJkNGNLR01Lc2x4?=
 =?utf-8?B?TkhFR01NZWNBTWVaQW9haHZ6Mm1ncFQwbHZJZGp1ZTJuVEt3YXhQNzdITW0r?=
 =?utf-8?B?ZVRjZndGM3lOaE4rSVN2VkN2SEtzeFdzU1FjRXhUTkZpSVM0NS9PM0VmZzht?=
 =?utf-8?B?cWFtazU0ejJtdllQR0g3aWdxemZ2dkRNSlI0cmJtQ3BJNC8rSHZVck1MdEo2?=
 =?utf-8?B?blpLTnp4NjlzbWliZ0NpZDVjY1BrL0l1aWg4Mk10UVJFY05sQjgwc21Dd2N2?=
 =?utf-8?B?dEtMWXNNbFV1OHkxL0dTenhNOEtManJmeVg1U2owU0tBQWZWU2I4ak5hQjAw?=
 =?utf-8?B?VkMzbTdsSTF4OWZ6SlRXeTcxZGQ5WUxwVUp3MGVrQjJhanB5NlE1U0xzbnUr?=
 =?utf-8?B?VVNlelR6eFlIeUFaemRtQmtNWG5oSWtzMkdFRjhxblJ1TnFCR2xlRHk2Zmt2?=
 =?utf-8?Q?1dogJ0jC9FVTP0fKe8/WDtMKt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5dbd1c-21ff-441f-6802-08dc9cfa3cf5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:56:15.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXeErWbwuan7prevp6EMqJYMOCfuT2RyEbpcqyG/vEsyjxhO50jl1ZTH7xXxsBl2C3RUdKJOUeIPf4+h2xX1ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9260

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
 Documentation/ABI/testing/se-cdev |  43 +++
 drivers/firmware/imx/ele_common.c | 192 ++++++++++-
 drivers/firmware/imx/ele_common.h |   4 +
 drivers/firmware/imx/se_ctrl.c    | 697 ++++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h    |  49 +++
 include/uapi/linux/se_ioctl.h     |  94 +++++
 6 files changed, 1076 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
new file mode 100644
index 000000000000..97a5b2ca115d
--- /dev/null
+++ b/Documentation/ABI/testing/se-cdev
@@ -0,0 +1,43 @@
+What:		/dev/<se>_mu[0-9]+_ch[0-9]+
+Date:		May 2024
+KernelVersion:	6.8
+Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
+Description:
+		NXP offers multiple hardware IP(s) for  secure enclaves like EdgeLock-
+		Enclave(ELE), SECO. The character device file descriptors
+		/dev/<se>_mu*_ch* are the interface between user-space NXP's secure-
+		enclave shared library and the kernel driver.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include]<linux/firmware/imx/ele_mu_ioctl.h>
+		 ioctl(s) are used primarily for:
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
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index b2be32550e9b..88169cd8f369 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -78,6 +78,149 @@ int ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg)
 	return err;
 }
 
+int ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx,
+			void *rx_buf,
+			int rx_buf_sz)
+{
+	struct se_msg_hdr *header;
+	int err;
+
+	err = wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr != 0);
+	if (err) {
+		dev_err(dev_ctx->dev,
+			"%s: Err[0x%x]:Interrupted by signal.\n",
+			dev_ctx->miscdev.name, err);
+		goto exit;
+	}
+
+	header = (struct se_msg_hdr *) dev_ctx->temp_resp;
+
+	if (header->tag == dev_ctx->priv->rsp_tag) {
+		if (dev_ctx->priv->waiting_rsp_dev && dev_ctx->priv->waiting_rsp_dev != dev_ctx) {
+			dev_warn(dev_ctx->dev,
+			"Dev-ctx waiting for response mismatch (%s != %s).\n",
+			dev_ctx->miscdev.name, dev_ctx->priv->waiting_rsp_dev->miscdev.name);
+			err = -EPERM;
+			goto exit;
+		}
+	}
+
+	dev_dbg(dev_ctx->dev,
+		"%s: %s %s\n",
+		dev_ctx->miscdev.name,
+		__func__,
+		"message received, start transmit to user");
+
+	/*
+	 * Check that the size passed as argument is larger than
+	 * the one carried in the message.
+	 *
+	 * In case of US-command/response, the dev_ctx->temp_resp_size
+	 * is set before sending the command.
+	 *
+	 * In case of NVM Slave-command/response, the dev_ctx->temp_resp_size
+	 * is set after receing the message from mailbox.
+	 */
+	if (dev_ctx->temp_resp_size > rx_buf_sz) {
+		dev_err(dev_ctx->dev,
+			"%s: User buffer too small (%d < %d)\n",
+			dev_ctx->miscdev.name,
+			rx_buf_sz, dev_ctx->temp_resp_size);
+		 dev_ctx->temp_resp_size = rx_buf_sz;
+	}
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(dev_ctx, true);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     dev_ctx->temp_resp, dev_ctx->temp_resp_size, false);
+	if (copy_to_user(rx_buf, dev_ctx->temp_resp, dev_ctx->temp_resp_size)) {
+		dev_err(dev_ctx->dev,
+			"%s: Failed to copy to user\n",
+			dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	err = dev_ctx->temp_resp_size;
+exit:
+	if (err < 0)
+		se_dev_ctx_cpy_out_data(dev_ctx, false);
+
+	/* free memory allocated on the shared buffers. */
+	dev_ctx->secure_mem.pos = 0;
+	dev_ctx->non_secure_mem.pos = 0;
+
+	dev_ctx->pending_hdr = 0;
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+
+	return err;
+}
+
+int ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
+			 void *tx_msg, int tx_msg_sz)
+{
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_msg_hdr *header;
+	u32 size_to_send;
+	int err;
+
+	header = (struct se_msg_hdr *) tx_msg;
+
+	/*
+	 * Check that the size passed as argument matches the size
+	 * carried in the message.
+	 */
+	size_to_send = header->size << 2;
+
+	if (size_to_send != tx_msg_sz) {
+		err = -EINVAL;
+		dev_err(priv->dev,
+			"%s: User buf hdr(0x%x) sz mismatced with input-sz (%d != %d).\n",
+			dev_ctx->miscdev.name, *(u32 *)header, size_to_send, tx_msg_sz);
+		goto exit;
+	}
+
+	/* Check the message is valid according to tags */
+	if (header->tag == priv->rsp_tag) {
+		/* Check the device context can send the command */
+		if (dev_ctx != priv->cmd_receiver_dev) {
+			dev_err(priv->dev,
+				"%s: Channel not configured to send resp to FW.",
+				dev_ctx->miscdev.name);
+			err = -EPERM;
+			goto exit;
+		}
+	} else if (header->tag == priv->cmd_tag) {
+		if (priv->waiting_rsp_dev != dev_ctx) {
+			dev_err(priv->dev,
+				"%s: Channel not configured to send cmd to FW.",
+				dev_ctx->miscdev.name);
+			err = -EPERM;
+			goto exit;
+		}
+		lockdep_assert_held(&priv->se_if_cmd_lock);
+	} else {
+		dev_err(priv->dev,
+			"%s: The message does not have a valid TAG\n",
+			dev_ctx->miscdev.name);
+		err = -EINVAL;
+		goto exit;
+	}
+	err = ele_msg_send(priv, tx_msg);
+	if (err < 0)
+		goto exit;
+
+	err = size_to_send;
+exit:
+	return err;
+}
+
 static bool exception_for_size(struct se_if_priv *priv,
 				struct se_msg_hdr *header)
 {
@@ -99,6 +242,7 @@ static bool exception_for_size(struct se_if_priv *priv,
 void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 {
 	struct device *dev = mbox_cl->dev;
+	struct se_if_device_ctx *dev_ctx;
 	struct se_if_priv *priv;
 	struct se_msg_hdr *header;
 	u32 rx_msg_sz;
@@ -114,8 +258,50 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 	header = msg;
 	rx_msg_sz = header->size << 2;
 
-	if (header->tag == priv->rsp_tag) {
-		if (!priv->waiting_rsp_dev) {
+	/* Incoming command: wake up the receiver if any. */
+	if (header->tag == priv->cmd_tag) {
+		dev_dbg(dev, "Selecting cmd receiver\n");
+		dev_ctx = priv->cmd_receiver_dev;
+		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
+		 * as the NVM command are initiated by FW.
+		 * Size is revealed as part of this call function.
+		 */
+		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
+			dev_err(dev,
+				"%s: Msg recvd hdr(0x%x) with greater[%d] than allocated buf-sz.\n",
+				dev_ctx->miscdev.name,
+				*(u32 *) header,
+				rx_msg_sz);
+		} else
+			memcpy(dev_ctx->temp_resp, msg, rx_msg_sz);
+
+		/* NVM buffer size are not known prior receiving it from FW.
+		 */
+		dev_ctx->temp_resp_size = rx_msg_sz;
+
+		/* Allow user to read */
+		dev_ctx->pending_hdr = 1;
+		wake_up_interruptible(&dev_ctx->wq);
+
+		return;
+	} else if (header->tag == priv->rsp_tag) {
+		if (priv->waiting_rsp_dev) {
+			dev_dbg(dev, "Selecting rsp waiter\n");
+			dev_ctx = priv->waiting_rsp_dev;
+			if (rx_msg_sz != dev_ctx->temp_resp_size
+				&& !exception_for_size(priv, header))
+				dev_err(dev,
+					"%s: Msg RSP hdr(0x%x) with different sz(%d != %d).\n",
+					dev_ctx->miscdev.name,
+					*(u32 *) header,
+					rx_msg_sz, dev_ctx->temp_resp_size);
+			else
+				memcpy(dev_ctx->temp_resp, msg, rx_msg_sz);
+
+			/* Allow user to read */
+			dev_ctx->pending_hdr = 1;
+			wake_up_interruptible(&dev_ctx->wq);
+		} else {
 			/*
 			 * Reading the EdgeLock Enclave response
 			 * to the command, sent by other
@@ -132,8 +318,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 
 			complete(&priv->done);
 			spin_unlock(&priv->lock);
-			return;
 		}
+		return;
 	}
 
 	dev_err(dev, "Failed to select a device for message: %.8x\n",
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index 5ef775a42ab3..7b1c6bfc138b 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -17,6 +17,10 @@ uint32_t se_add_msg_crc(uint32_t *msg, uint32_t msg_len);
 int ele_msg_rcv(struct se_if_priv *priv);
 int ele_msg_send(struct se_if_priv *priv, void *tx_msg);
 int ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg);
+int ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx,
+			void *rx_msg, int rx_msg_sz);
+int ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
+			 void *tx_msg, int tx_msg_sz);
 void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
 int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
 			    struct se_msg_hdr *header,
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
index e6503e8c8839..9746e6aa1488 100644
--- a/drivers/firmware/imx/se_ctrl.c
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sys_soc.h>
+#include <uapi/linux/se_ioctl.h>
 
 #include "ele_base_msg.h"
 #include "ele_common.h"
@@ -200,6 +201,608 @@ static int se_soc_info(struct se_if_priv *priv,
 	return 0;
 }
 
+static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
+	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int err = 0;
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
+	scoped_guard(mutex, &priv->se_if_cmd_lock);
+	priv->waiting_rsp_dev = dev_ctx;
+	dev_ctx->temp_resp_size = cmd_snd_rcv_rsp_info.rx_buf_sz;
+
+	/* Device Context that is assigned to be a
+	 * FW's command receiver, has pre-allocated buffer.
+	 */
+	if (dev_ctx != priv->cmd_receiver_dev)
+		dev_ctx->temp_resp = rx_msg;
+
+	err = ele_miscdev_msg_send(dev_ctx,
+				   tx_msg,
+				   cmd_snd_rcv_rsp_info.tx_buf_sz);
+	if (err < 0)
+		goto exit;
+
+	cmd_snd_rcv_rsp_info.tx_buf_sz = err;
+
+	err = ele_miscdev_msg_rcv(dev_ctx,
+				  cmd_snd_rcv_rsp_info.rx_buf,
+				  cmd_snd_rcv_rsp_info.rx_buf_sz);
+
+	if (err < 0)
+		goto exit;
+
+	cmd_snd_rcv_rsp_info.rx_buf_sz = err;
+
+exit:
+	dev_ctx->temp_resp_size = 0;
+	priv->waiting_rsp_dev = NULL;
+	if (dev_ctx != priv->cmd_receiver_dev)
+		dev_ctx->temp_resp = NULL;
+
+	if (copy_to_user((void *)arg, &cmd_snd_rcv_rsp_info,
+			 sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->miscdev.name);
+		err = -EFAULT;
+	}
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
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_if_device_ctx *dev_ctx;
+	struct se_if_priv *priv;
+	int err;
+
+	dev_ctx = container_of(fp->private_data,
+			       struct se_if_device_ctx,
+			       miscdev);
+	priv = dev_ctx->priv;
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
+	if (size < SE_MU_HDR_SZ) {
+		dev_err(priv->dev,
+			"%s: User buffer too small(%zu < %d)\n",
+				dev_ctx->miscdev.name,
+				size, SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+	tx_msg = memdup_user(buf, size);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     tx_msg, size, false);
+
+	err = ele_miscdev_msg_send(dev_ctx, tx_msg, size);
+
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
+	struct se_if_device_ctx *dev_ctx;
+	struct se_if_priv *priv;
+	int err;
+
+	dev_ctx = container_of(fp->private_data,
+			       struct se_if_device_ctx,
+			       miscdev);
+	priv = dev_ctx->priv;
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
+	err = ele_miscdev_msg_rcv(dev_ctx, buf, size);
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
+				u64 arg)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
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
+/* Need to copy the output data to user-device context.
+ */
+int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx, bool do_cpy)
+{
+	struct se_buf_desc *b_desc, *temp;
+
+	list_for_each_entry_safe(b_desc, temp, &dev_ctx->pending_out, link) {
+		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr && do_cpy) {
+
+			dev_dbg(dev_ctx->dev,
+				"%s: Copy output data to user\n",
+				dev_ctx->miscdev.name);
+			if (copy_to_user(b_desc->usr_buf_ptr,
+					 b_desc->shared_buf_ptr,
+					 b_desc->size)) {
+				dev_err(dev_ctx->dev,
+					"%s: Failure copying output data to user.",
+					dev_ctx->miscdev.name);
+				return -EFAULT;
+			}
+		}
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		list_del(&b_desc->link);
+		kfree(b_desc);
+	}
+	return 0;
+}
+
+/*
+ * Clean the used Shared Memory space,
+ * whether its Input Data copied from user buffers, or
+ * Data received from FW.
+ */
+void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx)
+{
+	struct list_head *dev_ctx_lists[] = {&dev_ctx->pending_in,
+						 &dev_ctx->pending_out};
+	struct se_buf_desc *b_desc, *temp;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		list_for_each_entry_safe(b_desc, temp,
+					 dev_ctx_lists[i], link) {
+
+			if (b_desc->shared_buf_ptr)
+				memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+			list_del(&b_desc->link);
+			kfree(b_desc);
+		}
+	}
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
+	struct se_buf_desc *b_desc = NULL;
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
+	/* Select the shared memory to be used for this buffer. */
+	if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
+		/* App requires to use secure memory for this buffer.*/
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed allocate SEC MEM memory\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	} else {
+		/* No specific requirement for this buffer. */
+		shared_mem = &dev_ctx->non_secure_mem;
+	}
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
+	if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
+	    !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
+		/*Add base address to get full address.*/
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed allocate SEC MEM memory\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
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
+	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
+	if (!b_desc) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+copy:
+	/* Provide the EdgeLock Enclave address to user space only if success.*/
+	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy iobuff setup to user\n",
+				dev_ctx->miscdev.name);
+		kfree(b_desc);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	if (b_desc) {
+		b_desc->shared_buf_ptr = shared_mem->ptr + pos;
+		b_desc->usr_buf_ptr = io.user_buf;
+		b_desc->size = io.length;
+
+		if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
+			/*
+			 * buffer is input:
+			 * add an entry in the "pending input buffers" list so
+			 * that copied data can be cleaned from shared memory
+			 * later.
+			 */
+			list_add_tail(&b_desc->link, &dev_ctx->pending_in);
+		} else {
+			/*
+			 * buffer is output:
+			 * add an entry in the "pending out buffers" list so data
+			 * can be copied to user space when receiving Secure-Enclave
+			 * response.
+			 */
+			list_add_tail(&b_desc->link, &dev_ctx->pending_out);
+		}
+	}
+
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
+	int err = 0;
+
+	/* Avoid race if opened at the same time */
+	if (down_trylock(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* Authorize only 1 instance. */
+	if (dev_ctx->status != SE_IF_CTX_FREE) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	/*
+	 * Allocate some memory for data exchanges with S40x.
+	 * This will be used for data not requiring secure memory.
+	 */
+	dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx->dev,
+					MAX_DATA_SIZE_PER_USER,
+					&dev_ctx->non_secure_mem.dma_addr,
+					GFP_KERNEL);
+	if (!dev_ctx->non_secure_mem.ptr) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
+	dev_ctx->non_secure_mem.pos = 0;
+	dev_ctx->status = SE_IF_CTX_OPENED;
+
+	dev_ctx->pending_hdr = 0;
+
+	goto exit;
+
+	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
+			   dev_ctx->non_secure_mem.ptr,
+			   dev_ctx->non_secure_mem.dma_addr);
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Close a character device. */
+static int se_if_fops_close(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
+							struct se_if_device_ctx,
+							miscdev);
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
+	if (priv->cmd_receiver_dev == dev_ctx) {
+		priv->cmd_receiver_dev = NULL;
+		kfree(dev_ctx->temp_resp);
+	}
+
+	/* check if this device was registered as waiting response. */
+	if (priv->waiting_rsp_dev == dev_ctx) {
+		priv->waiting_rsp_dev = NULL;
+		mutex_unlock(&priv->se_if_cmd_lock);
+	}
+
+	/* Unmap secure memory shared buffer. */
+	if (dev_ctx->secure_mem.ptr)
+		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
+
+	dev_ctx->secure_mem.ptr = NULL;
+	dev_ctx->secure_mem.dma_addr = 0;
+	dev_ctx->secure_mem.size = 0;
+	dev_ctx->secure_mem.pos = 0;
+
+	/* Free non-secure shared buffer. */
+	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
+			   dev_ctx->non_secure_mem.ptr,
+			   dev_ctx->non_secure_mem.dma_addr);
+
+	dev_ctx->non_secure_mem.ptr = NULL;
+	dev_ctx->non_secure_mem.dma_addr = 0;
+	dev_ctx->non_secure_mem.size = 0;
+	dev_ctx->non_secure_mem.pos = 0;
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+	dev_ctx->status = SE_IF_CTX_FREE;
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return 0;
+}
+
+/* IOCTL entry point of a character device */
+static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
+							struct se_if_device_ctx,
+							miscdev);
+	struct se_if_priv *se_if_priv = dev_ctx->priv;
+	int err = -EINVAL;
+
+	/* Prevent race during change of device context */
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	switch (cmd) {
+	case SE_IOCTL_ENABLE_CMD_RCV:
+		if (!se_if_priv->cmd_receiver_dev) {
+			err = 0;
+			se_if_priv->cmd_receiver_dev = dev_ctx;
+			dev_ctx->temp_resp = kzalloc(MAX_NVM_MSG_LEN, GFP_KERNEL);
+			if (!dev_ctx->temp_resp)
+				err = -ENOMEM;
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
+
+	default:
+		err = -EINVAL;
+		dev_dbg(se_if_priv->dev,
+			"%s: IOCTL %.8x not supported\n",
+				dev_ctx->miscdev.name,
+				cmd);
+	}
+
+	up(&dev_ctx->fops_lock);
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
@@ -237,6 +840,7 @@ static void se_if_probe_cleanup(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct se_if_priv *priv;
+	int i;
 
 	priv = dev_get_drvdata(dev);
 
@@ -256,6 +860,17 @@ static void se_if_probe_cleanup(struct platform_device *pdev)
 		priv->imem.buf = NULL;
 	}
 
+	if (priv->ctxs) {
+		for (i = 0; i < priv->max_dev_ctx; i++) {
+			if (priv->ctxs[i]) {
+				devm_remove_action(dev,
+						   if_misc_deregister,
+						   &priv->ctxs[i]->miscdev);
+				misc_deregister(&priv->ctxs[i]->miscdev);
+			}
+		}
+	}
+
 	/* No need to check, if reserved memory is allocated
 	 * before calling for its release. Or clearing the
 	 * un-set bit.
@@ -263,6 +878,74 @@ static void se_if_probe_cleanup(struct platform_device *pdev)
 	of_reserved_mem_device_release(dev);
 }
 
+static int init_device_context(struct se_if_priv *priv)
+{
+	const struct se_if_node_info *info = priv->info;
+	struct se_if_device_ctx *dev_ctx;
+	u8 *devname;
+	int ret = 0;
+	int i;
+
+	priv->ctxs = devm_kzalloc(priv->dev, sizeof(dev_ctx) * priv->max_dev_ctx,
+				  GFP_KERNEL);
+
+	if (!priv->ctxs) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	/* Create users */
+	for (i = 0; i < priv->max_dev_ctx; i++) {
+		dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
+		if (!dev_ctx) {
+			ret = -ENOMEM;
+			return ret;
+		}
+
+		dev_ctx->dev = priv->dev;
+		dev_ctx->status = SE_IF_CTX_FREE;
+		dev_ctx->priv = priv;
+
+		priv->ctxs[i] = dev_ctx;
+
+		/* Default value invalid for an header. */
+		init_waitqueue_head(&dev_ctx->wq);
+
+		INIT_LIST_HEAD(&dev_ctx->pending_out);
+		INIT_LIST_HEAD(&dev_ctx->pending_in);
+		sema_init(&dev_ctx->fops_lock, 1);
+
+		devname = devm_kasprintf(priv->dev, GFP_KERNEL, "%s_ch%d",
+					 info->se_name, i);
+		if (!devname) {
+			ret = -ENOMEM;
+			return ret;
+		}
+
+		dev_ctx->miscdev.name = devname;
+		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
+		dev_ctx->miscdev.fops = &se_if_fops;
+		dev_ctx->miscdev.parent = priv->dev;
+		ret = misc_register(&dev_ctx->miscdev);
+		if (ret) {
+			dev_err(priv->dev, "failed to register misc device %d\n",
+				ret);
+			return ret;
+		}
+
+		ret = devm_add_action(priv->dev, if_misc_deregister,
+				      &dev_ctx->miscdev);
+		if (ret) {
+			dev_err(priv->dev,
+				"failed[%d] to add action to the misc-dev\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 static void se_load_firmware(const struct firmware *fw, void *context)
 {
 	struct se_if_priv *priv = (struct se_if_priv *) context;
@@ -431,6 +1114,16 @@ static int se_if_probe(struct platform_device *pdev)
 		ret = 0;
 	}
 
+	if (info->max_dev_ctx) {
+		ret = init_device_context(priv);
+		if (ret) {
+			dev_err(dev,
+				"Failed[0x%x] to create device contexts.\n",
+				ret);
+			goto exit;
+		}
+	}
+
 	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
 		 info->se_name);
 	return ret;
@@ -471,6 +1164,10 @@ static int se_resume(struct device *dev)
 {
 	struct se_if_priv *priv = dev_get_drvdata(dev);
 	const struct se_if_node_info *info = priv->info;
+	int i;
+
+	for (i = 0; i < priv->max_dev_ctx; i++)
+		wake_up_interruptible(&priv->ctxs[i]->wq);
 
 	if (info && info->imem_mgmt)
 		se_restore_imem_state(priv);
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
index 4be2235d2170..b49346372746 100644
--- a/drivers/firmware/imx/se_ctrl.h
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -13,15 +13,62 @@
 #define MAX_FW_LOAD_RETRIES		50
 
 #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
+#define MAX_NVM_MSG_LEN			(256)
 #define MESSAGING_VERSION_6		0x6
 #define MESSAGING_VERSION_7		0x7
 
+#define SE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
+#define SE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
+
 struct se_imem_buf {
 	u8 *buf;
 	phys_addr_t phyaddr;
 	u32 size;
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
+/* Private struct for each char device instance. */
+struct se_if_device_ctx {
+	struct device *dev;
+	struct se_if_priv *priv;
+	struct miscdevice miscdev;
+
+	enum se_if_dev_ctx_status_t status;
+	wait_queue_head_t wq;
+	struct semaphore fops_lock;
+
+	u32 pending_hdr;
+	struct list_head pending_in;
+	struct list_head pending_out;
+
+	struct se_shared_mem secure_mem;
+	struct se_shared_mem non_secure_mem;
+
+	struct se_api_msg *temp_resp;
+	u32 temp_resp_size;
+	struct notifier_block se_notify;
+};
+
 /* Header of the messages exchange with the EdgeLock Enclave */
 struct se_msg_hdr {
 	u8 ver;
@@ -80,4 +127,6 @@ struct se_if_priv {
 	struct se_imem_buf imem;
 };
 
+int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx, bool do_cpy);
+void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx);
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


