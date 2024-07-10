Return-Path: <linux-kernel+bounces-248369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F02D92DC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBFF1F25466
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FB14F9DA;
	Wed, 10 Jul 2024 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HrG/Ncc5"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98AC77F0B;
	Wed, 10 Jul 2024 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652569; cv=fail; b=iOymkjvorVatG5cArFubKVhLqQzcBnto4yn/kL6mpkUNOeMZ+HqJK8I6ClCRgGW4SUag5eot7Qbi9MrpAnoC3sOq3r/PCXaU+u6hgcsjTZdWhg7msH6CW+2H6g3i5v/sWPwgTw5S/P58QcAyA5qBuBAoZCJQ8CQfcPx7S4N3kyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652569; c=relaxed/simple;
	bh=7/3AxkkPdSRtks8+KJh8hgb1hKintacqROWipW5VGyU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TmffsIuJDp4DoO3VlatTHlqxSnDGtChZnsZX0dwQukaHK7H1u6Tt3uKzDIIhF7TdhhzTcExoQIzXh4IGcEEfNbA/kj2FKKhrnjJ7C/P3vbQ1xPXn4KKy6vCT5+6UYUGVQ8PvuHrGYJnfXTpJH+Xf0QBCkG4or2QM2MrDWZw5eWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HrG/Ncc5; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyG6VLs+IabV+KkODcXK0DwRHMIFrRqPc16/97N/BcLTrRHvJL652h13939ujQpPKuKIlW+qVjhVJRuD0TDPO5h5BYJAdxErFq11XRtwOCptlya82961kNb7ltXCimIumF+13Ag1ktuVJFWSavz/mahBLvRIiY6iPye/kkXmIrBhy7U+67973BVjeU4nNuscVJ80BXrctcTasssA8uFyCxAdC53yPkbQBeT6X0jpgs2eX48SxCCDh19nhQwSn5GH1he3wMjcJRX/II32ftZwDxCBosxiQI364gaOydsiBH5hPOBXNKsj8QTG6/0Izs6gAON+vhNUhayqG40ET+qoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFUWwpuaAL9AMQprfrdTI9kLrr4PB/ep8VNt33hNnrE=;
 b=LYfAqQLZoznmNfXviCJBQ+GAQxXdLfg5Jg2UJp0232qjrONLBgPediTt2mSFYYNzmDn/f5kiv1RgtOeKVT+V+EAGApwbQpQPuCMMfDjn3RZRpNWnWa2f/3xIMj3A1d9MIwcr72pCRAYm3FAdF5Qf0yKFKlVSzd18h04b0BXwF+T2JLyg4FXJpkdWgQjCT95cO7jPyt3eEcDtRqUTinj3jRnRkgWZTbYBGZmwsxRAyJlqIkhbPH9Y+w4ZSK0w/0X//Sl2SZzuYTeQrBFZRfgsDo56MSmFyHVs3er17anSsUdg6SF1oVnYjkbrXAi8pa+HMkrnz/dOZlJyFiglVyFeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFUWwpuaAL9AMQprfrdTI9kLrr4PB/ep8VNt33hNnrE=;
 b=HrG/Ncc5MBkjMkTA/4knFXetM/wsT9m4HnxZGW3VNjhVIHl+Uj8ngnw2ABef+WN1WdlXYL+MN5KJedrST7B+nfhxgXTwxP8igK9jvOxutbJwIewzrqd36qT/kFH889KqY5yPjUZvaGHOpMnNCTPPR+k+2+RkDZUIJNoONsSvR8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10751.eurprd04.prod.outlook.com (2603:10a6:150:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 23:02:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 23:02:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] usb: dwc3: add fsl,ls-dwc3 glue layer support
Date: Wed, 10 Jul 2024 19:02:21 -0400
Message-Id: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP0Sj2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MD3Zxi3ZTyZF0Dw8RkA+M0Ywsji0QloOKCotS0zAqwQdGxtbUA+3Q
 89lgAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720652559; l=1438;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7/3AxkkPdSRtks8+KJh8hgb1hKintacqROWipW5VGyU=;
 b=y8vg8Xj+8W9pbx/FjvagNE82lpk9vqns5vFgfsDHlBnjvSzUjrj59HOVdlOcDEpowStdNO2VB
 SZILBolTbAQBMnwlr/CbsCf4TSLgtrKfvlUroA5v9kcQR7erATrl82t
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10751:EE_
X-MS-Office365-Filtering-Correlation-Id: 65be52aa-f55a-4991-e46d-08dca13467a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXowYmN4dFdtYWk4dFUwN09McW10c2N5VXY3eUNLUThZdVZhT1lza05uUjRN?=
 =?utf-8?B?YUJqcDFTVWpINnUrQ2huWTFCZEhiL3pEY2cxQTJkY1NoUm0yRmR0ZHJjaUFF?=
 =?utf-8?B?YU5abFNNdkYvT3VuNDMzbk5OU3kwcEQ4NkprLzBXSU9QZVdRdlJEekZKYUhu?=
 =?utf-8?B?RjYwKzdyQ05UZ1IxRmRFdlE5MVBuSUhtTWVBek1ITzlBWU1KSTFFTEFHcTdO?=
 =?utf-8?B?UmJJbmJYTXlsdHRsQUl2cFErV0VJbVBBWVJacW4yRkJXNDA2TlZaSUR1V1J5?=
 =?utf-8?B?ZFJKUDBybWtvbmpuMmo1bDNWQk1tOXdFRXlrZ2VDTzlaTHVtZDVHb3doSi82?=
 =?utf-8?B?SDFYb1ZQRXdIbXk0Y0RXYkdTaTY1UmxyWm1WK1BNOURPbm5hMnYxUHBoRnEv?=
 =?utf-8?B?aDIrelNkYzFhaGFwbmJGc1lIZHUrcUN1Qlh1SkMwVFAzdlA1Y204RWhvdGFx?=
 =?utf-8?B?QzdnSU96QzZBSFJ2ckpkeWtScng4eVExc2dsQlp0eStRSlFqbU82b2VCeEk1?=
 =?utf-8?B?MzgwYUsvUCtTNUNxNDgwbWE5NFdzSGd4cytYeE00SVg4TkJYandsUUhOSTd0?=
 =?utf-8?B?U005dEsrZ1B0eGY5aXY4Qm5BUVM2ZFZNVU9VakMzMTNSRTlkMkFZOVJ2dTJU?=
 =?utf-8?B?MmZxbm5oMGFzQ2daZVpNbEFKZkx0OVdSaWwvcWp1c1lJS3VHNVRqVzg4RkFu?=
 =?utf-8?B?Yzhib0puSkNNRlVDZmI2cmp0cjNHWml6djh6RC9kV3JKeEFndTNJUmYzM09G?=
 =?utf-8?B?VUlTSHl0R29EZ0ZTNEV3SzFFbjlQakxUYmNtTjNTZlFuUEpDVldObUVFeGFn?=
 =?utf-8?B?U2F6S2NsZm5WN2FTbXVkNUhDYkpxUjZMeXI0NW9tYmNZcHNTR2s5aVRZSy9m?=
 =?utf-8?B?N0V6MS9lWW4zT2cwcnEzMTFnaEs5Y01kc0lhdlFLVHFOb3ZGeHRqdmhxMUc5?=
 =?utf-8?B?VUhFbnRGZmw4aExsV253YXhmeGlKYWtRckx0UmJHSEg2RzBXR0p6QUZyTGU1?=
 =?utf-8?B?TklCY2pwbWdTOWRJZkh3N0NEdnhDMWZiMGtVTU1CWFlMMEEvTVJ0Y0ovWE1W?=
 =?utf-8?B?a3I3QjZOMVFlcFlTc3ZxVjFCb0p3czRLSnE1Ukp4TXJYcUhaeEpnQXBKb0FN?=
 =?utf-8?B?dmc1T2hTTzhINDNnbzVBOW94YmV4cU9wSmNjQ2M0MXRjSzVrdmRRRXRmeTlX?=
 =?utf-8?B?WUlFUitTaUV4Ym1ZakhocWRPVHlWc3Q0MnhJMytXTVpiTlMvYldPS0xSZWhS?=
 =?utf-8?B?elBDUHFNSVkxMkdZYzF1VXNJV2haS0hlRWF0ZmRtVEZFQ0NNVmtONVZRRGJR?=
 =?utf-8?B?b2M0d1dWQk9Sc1pnM2ZIWW93dFFVbHpVSFIvMzdWNUYyaHN2SmY0Q29ZMTdi?=
 =?utf-8?B?OXVsaHZvcEVBTy9LZk0wSzIrN2VrTDVJZFdnRDNrZUkzeUZzck4vcFgvaXJs?=
 =?utf-8?B?Z05yb29BVDFjanV3L2s1R3pIdC9yRTUzYmhoa0VpSTAyallxK2RENGErTTJq?=
 =?utf-8?B?aEZCVW1yNHNjdVZKRU41cEQ4c2p6U2tPK2R5a1NzeldJTDhpNHFEOU1kdm5w?=
 =?utf-8?B?ZDBnN3hrTGlGK2ZLZ1haR1JidFQraG1MNHFIS2ZLNlZWeExOQVAwWnBHQzV6?=
 =?utf-8?B?ZDcyZDBKVEhKeGJCSGdQZ2pUZHJLRXpyUmM2c2ovYk10aSswN0x5WnZVTzRp?=
 =?utf-8?B?UTlWcUhISUFBUkNxd2ZWZEV5YWVDT0dLbng1S3drdWp0Q1k4QzIrYUVkc0tL?=
 =?utf-8?B?bjF1V3h3enBLSXJhOVpsQndKNVpIam9jTmNmbDBaY05jZHBQcDBhOE5PNXNy?=
 =?utf-8?B?Z1hJR0xacmxSLzN5bEJ3MkR5S28xNGZtVHpZb2FzV0xnK082amhzaUVDVWpN?=
 =?utf-8?B?Z3o0M3VHZWdJRVRQWXBTbDBlSmpzTGIrU3FlREpEWGVGRlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3RPbzNIaHZQR2pxT0xqZjlGZFE0Nm9HM08zeUMyWGNwMCs3N2pVMUhIR29Q?=
 =?utf-8?B?OWlacUpVNVhCTnE5TWNyaFhScFFreTY0YWRpRk01MFVaWUJZWituNGhPSXc1?=
 =?utf-8?B?dzRCKytSWXpRNnpsWGlqTUNIc0dDRThOY0NhQnQvYzJFeDkwSGpPYmxsUTly?=
 =?utf-8?B?WTdPWmdQYk5GcE9INXpCd0NYVEo3endTTlBmVGtNT21SWE1BWnBBNlN0TXRp?=
 =?utf-8?B?cmdFME56eDZ2ODJKSGI2L0ZMZk91MjdRQ0NwRlZpRTNaL2szWDZET2k5aVVk?=
 =?utf-8?B?ajFjcXlLMm9EVGJjV0o2bzluM0lnVCsrUit6dWQwMlZVbVk0VUxsc2IrM1Rm?=
 =?utf-8?B?cUliMUFxWUVnMVVGelUzSXd5OFZjTVgyakkxQW5XQlBYeUU3empyYlpXQWZF?=
 =?utf-8?B?VnkrTnd3RlpHQnBqVmNMa05SWktWbi9LQW1JQlhNVnRibzBES0Y2Wk5XU1dp?=
 =?utf-8?B?NWlnSEErNlVyay9YMzY2dU9lNTgzYm5TNk1yeDdpWjdVTXlsSzBCUnZQVGtK?=
 =?utf-8?B?OWpXYkI4MlpDc1l3a0RaM2REYlRTVmZyanF2Rnh4cGtTLy93TFZRbnFXSG9N?=
 =?utf-8?B?NXpmckQ3UG5GMmpYVkFMZk9rS1gyOW5JMW9jd3ZpTWQvS0kvRk1PTG9HV3ln?=
 =?utf-8?B?K29HT05LVUdhWnJhUmFpZnVkNGx5YmQxU1pjMGVEb1Q4U21KbkNlVVdQN0lG?=
 =?utf-8?B?enB5ZzM0azE5RWUzTng2MzdBaS9LcDJNVGowNXZYcmtaTXZTQzJFZkNqL3FM?=
 =?utf-8?B?eWtlOWJmaWIxVExSbDFrMjdnN1FEOWpIRG9NVUJISS9lejhNdXliM1pGY09q?=
 =?utf-8?B?MFh0TlFKUkVjS3U2bGZna2Vpc2JjR2o1cG9HY2E4UWhVczhpQnRqYi9JMFc1?=
 =?utf-8?B?TU1UeGFIeEM4MkFPQ3NOMEh5cStRRlV2UHBRMFpUbUVoeEtLZmUvYUZuWXZx?=
 =?utf-8?B?blJhc3VRU1dIUkJWWWtuc0tZOU9Lazg3a1pNSzkyMFpudmxCUFJ1MngwNzdz?=
 =?utf-8?B?Tm9CN2Y5ZkVSbmFhazJTRzJ2aUxrMmMwUlNUQ0V1ZFl0Sk8xSkEvQ3A0RHZB?=
 =?utf-8?B?cFhiSDkrU2JHL1Y5TWVnMG9IZGtyN2Z5Z3VSMXcwS3FnMjJVRGdNaFM2dWZm?=
 =?utf-8?B?Z3U3bmZIU2I3bFBoWXowTzVDQlRJTlB3V2FtcGRIMEFZd2RQUE1ZeHVyM09P?=
 =?utf-8?B?NnJsVU1Yb1Z0QWE5bVh2NVE4ZFk1dUpEY2Vac3FKNFlaZ1NDSk8zVm9EWm9o?=
 =?utf-8?B?TUZNcDZ3WlRGWUVFelAzYmhvVDVaTWF6VkVTVUVEa3ZhSE4wb25yNVlXWVdj?=
 =?utf-8?B?Zmhxd2ZNbFBVaVY5MnF0QVZmVmxLU3pBb1VrTnljQXFQU1oyQ2RxTTA0ZkEz?=
 =?utf-8?B?M1Y2bmU0QkpncTB3czhyRDJYcTkrTXpCMHBZNnBXRnJ4bUZ1SUkyNWUwTkJG?=
 =?utf-8?B?Sm1wZExTT2x4Ni8vMXpaVjVEUld4QmRFUExOSGRxM1E2RUM2Y0YxMEVOMytu?=
 =?utf-8?B?bXFJRnJBckEwWWNwOTZ2cGVITHVubTErSDVyWk9qdksyMHd0MXdLSklKb0Nq?=
 =?utf-8?B?bHFCYWFiWGNNcFNKTXpmbnd4U1VhRG9sT09pcXgrNmhOY3FSaTFWaXVDOVZ2?=
 =?utf-8?B?eVZxN1dvYUFtT0hSbzhMVEZFN3JyRkdjamovU0diaVVXbzNjZGh5TlhDY1Jp?=
 =?utf-8?B?Ukl4SzZWQkFhRm5hMDNKckhFY1dVcGx2VWNxKzZYdU5rdXdUUlJVYURaVldN?=
 =?utf-8?B?aE1HcTJ0RlZVZ1BuQ0VTbWRTSGdBTWFkQnlDcXJwT3dLcS8rOTZza0lmU2Fm?=
 =?utf-8?B?SFF5MGQ4YkVYdXhDdnpwaTJtYThZZW1qNFg1L3J5VVduR2NESUhnZDlGQWlp?=
 =?utf-8?B?RW0yV1Z2SkhLcG90NkF6cjN6ODZKUlpER25XSG14ZDVJTy92TU9vaG5QSldQ?=
 =?utf-8?B?QURYbXBIRHkyMzZZbzM0NjR1eWZBUDgrS3BBUDdkaElEYUNjdktXdkM4RGVY?=
 =?utf-8?B?UHpnSVlWV1RESGV4RHhWS2Jrck4vR0Njc1d1VUJWNG1ESS9PYUkvSTJnbmZ5?=
 =?utf-8?B?bkR4TmNwMDl3cFVWUW4vUDM2RlR6VWlnZ3dQbFE0dXlESjdUbFRnb2JPcmJy?=
 =?utf-8?Q?0npUe3mv4dHf0QrudRORWx5BH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65be52aa-f55a-4991-e46d-08dca13467a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 23:02:43.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZ6hUD8PvpKRD3kTtWzGGtxzlerkuP+o7sjdqy6YWE7uTLutEUMwaOocvXgPZJr349MXoTdXl/C08nK3fV2L0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10751

Add freescale layerscape dwc3 usb glue layer support.
Create binding doc for fsl,ls-dwc3.
Add compatible string fsl,ls1028a-dwc3 in dwc3-of-simple.c
Passdown software managed node property snps,gsbuscfg0-reqinfo.
Update dts to support dwc3 glue layer and enable dma-coherent.

Based on usb-next

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      dt-bindings: usb: Add fsl,ls-dwc3.yaml for layerscape usb3 glue layer
      usb: dwc3: of-simple: Add compatible string fsl,ls1028a-dwc3
      arm64: dts: layerscape: move dwc3 usb under glue layer node

 .../devicetree/bindings/usb/fsl,ls-dwc3.yaml       | 50 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     | 43 +++++++++++--------
 drivers/usb/dwc3/dwc3-of-simple.c                  | 22 ++++++++++
 3 files changed, 98 insertions(+), 17 deletions(-)
---
base-commit: e60284b63245b84c3ae352427ed5ff8b79266b91
change-id: 20240710-ls-dwc-01ac03f3828a

Best regards,
---
Frank Li <Frank.Li@nxp.com>


