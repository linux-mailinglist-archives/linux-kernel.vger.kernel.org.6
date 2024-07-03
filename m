Return-Path: <linux-kernel+bounces-240001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C59267CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63781C24E59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0560187549;
	Wed,  3 Jul 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XyeAzVUo"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E691862A6;
	Wed,  3 Jul 2024 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030109; cv=fail; b=R43dURG/VXa1OEjB2Y60AzBCtOIJ90FADRCJYt47rWgVwgnj+oaYLnSjBzkhx86Y0w+jCHRM5PBPaKYKRKhf3wBg49zVkKGTHZ8oYbsGuvAWn1+fiWf6M6AUNMIPCke5acy4ieEVjaxWKdhXo6eOiOpV1RYSieHUnuJ08sk8+6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030109; c=relaxed/simple;
	bh=qW1hSFXT1qGrZSRciF7udZ1srolOq6juGxpnZygHLzI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AGMQJ/IjINBTd0mdGovwe1ZtfJxz9PoQc16hTMWm7EKyPVwqpoUp/1mXyIcJaq2y7/c1AfZZR8TFCZGJRBUi/3ZVs7eGsl7gpj1kEPn3IONqm47MGrF8D6nMe5XAJEAgacHL70WSyovaJKf1oI5A5bKd0o4u2w2wzLGndirkLE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XyeAzVUo; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0n8ghIxFNqReS8eGAZ6VXJhZaVu65+dm63vQnfxEl8Asj6y2LW/KhM1YD9i9wm1G5V52KAik8IMaHAi645uuCU5MyLiDdNluQByh/XolBNxBbXkExL2++LdQgutFMwPMEpMekxwZ7U+L5QsqWAPQ4KufVInQmHhAgxBCyEJo1RzFg2xl7t6cpWci2fq455PyoRj8YxCmFqa0XoEKtEDhlY2MvbwWKUj8SAjzjw1vZkNVQOHHAVUDBn4hpG5BUpKtvcAoA70Lp/mAZbw1kMJkMyR3G6Y5mRixBCjExLEx1t666jNceIrI0XnZjz0iC83r+wU25wXMIQxE6PyV4k+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WFoiVMxzk63U6c2g8X8aE/EZVcqit6RvXoTMGmiOJk=;
 b=l6tGUDxZdzGLW9xAmWvsXIXD3SeRDY0tqpruDrln7wt8cEHmESVIk0dGDUpkcWkyz61SdrXYNPo/PScgauYFPKTjEnoewxZJSDsMwbBy4AkuVepD70T6KoF0zDO/1ZQTmTMEVHEKK6UWOF+oEBE49vBr/HdFd9GeAE7XfOv/jzV47XwiNS+sVTvLq3TkP3C49EgPwYZxYfK61CADLDiAp6g65ZbAquobjlC4nSB1vcufGAKdYFBgiECt79JeJwihROgk9X6j6GExTJBwJdQwSW5I1MSsWz8UWBqo38S1py0PF6kwEraPm+FoVmAoUt5NfRN7wXLzgkhjMjY3B4LJeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WFoiVMxzk63U6c2g8X8aE/EZVcqit6RvXoTMGmiOJk=;
 b=XyeAzVUoeh0u1EtVGqCpy0JBgK561OMH5J2I/RDCu4Gs/uXM8macJUDUQOPHET7+/uf1+5+KkzFrA/zpwQNIb3nxmF0Q1P6CZJDvMZkygpVc/j8QPr1Gf67KdHDwdjwUWrDtVpGI4eIkf5tgFERaSvWcMFoSeIpHiO04LSu95QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 18:08:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 18:08:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Jul 2024 14:08:11 -0400
Subject: [PATCH 1/2] dt-bindings: soc: fsl: Add fsl,ls1028a-reset for reset
 syscon node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-ls_reset_syscon-v1-1-338f41b3902d@nxp.com>
References: <20240703-ls_reset_syscon-v1-0-338f41b3902d@nxp.com>
In-Reply-To: <20240703-ls_reset_syscon-v1-0-338f41b3902d@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720030099; l=2033;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qW1hSFXT1qGrZSRciF7udZ1srolOq6juGxpnZygHLzI=;
 b=MTiSzFBxSNm434D/zLyYbzCcRQjVC/il5xA9QcpXOMD/3Hn18CgV2HpwjrgCnhzz5WfC4RRFv
 3CoWWXPKgYwDMgDM0FMOjdyxROay4FycpuW+8WN/9LbJ/hQqnAyxBY/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0274bf82-b700-4493-54d2-08dc9b8b21b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjFWNGwxZVp1RUxLMngrbDNxUGxQNWR0RnhZbzNSb2krejB5ZGlNTE90K2E5?=
 =?utf-8?B?OG5CcGhlU0liUWQyeWdxb0doVDlvK3c2eWo2d3FhT2xMdDF5L2dmdDRQMXhW?=
 =?utf-8?B?ZnVDWnplcUlSdVQ1YkpSM3ZEQkdPVThPOCtvOEtQck5vTllmVUYxcDN2Qmln?=
 =?utf-8?B?YXVoSEhNMVkwNFBXR2hGczM2VW5lSm40eW5rZ2QvaWlBdGpOMzRRVkZHVmJS?=
 =?utf-8?B?bU1VcWZ0eUFNVktsMEZKdGNITGEvcnpaSHVsdDFnWEFNTzJBcEVBdW9sUGpr?=
 =?utf-8?B?bmtiNnh1Znl2TG5wcUNncm5jRXZBeS84UmMrejk5dlR3VXZ2bXE0UW1tUjhQ?=
 =?utf-8?B?NDU5MkVOQTBsV2hyR2QwQ1UwMFJRQjNOMDZpUG05bXRQR3lLRjNSWGxxVUd5?=
 =?utf-8?B?MUUvLzNBelYxZnRROUhSVTE3WmdoQW1vTFdHeUx4SWl5OWFTUTVHQzE2VWkr?=
 =?utf-8?B?NjIzVjdpOGpLY2RpUXhBV1kxeFI0WHVNejE5NENZRTZoZFNrZHZtaW94SFZs?=
 =?utf-8?B?dkF2ZGs3a0l0ZUplcVlBOHAwL002OVQrS3c2LzR3Yi90bW5JRStFekt5ektD?=
 =?utf-8?B?RE1ienpBY0xxb1Yrd0ZyRmFLUzJWUms0VFdnM05RL0N3Q1ZsdCtEWGxTNXZT?=
 =?utf-8?B?dEpPRUN1MjhVMzh4OU9IeTVNbzYySjU5RUczVnFZTDZnb09LdXpRRUl1R1V3?=
 =?utf-8?B?Y0IyRTdiYnlJYWk2dURDbUFQSWlCQlJkM3hrRFBPKytUTGcvT3VuSkRoQWY2?=
 =?utf-8?B?QVpCV3hjeUd1MDdMelZCWW51NkUwbzB3WkQzTkxidzhpQkp6SDF4U2s0UE9Y?=
 =?utf-8?B?NlNMUVVMSFBCME5mTnhIOGtKMm5qL3hPUkV1UXlVOUlwajJXbHowc0Z5WXc4?=
 =?utf-8?B?VGgyVHdqRVdnbk4xQkk4QU1pdVJHWFhNZERENm5ZTWNURGVQMElEUkVud2px?=
 =?utf-8?B?WHR4WHBGbkZBamkvSHlOT2RlR09XSDhQV3ZGQ3U0TEo1UEdrNHV1MmhCNlJu?=
 =?utf-8?B?cVBiWWlyM2ZOUGVqSGVNRThLeGpuS0VUZ2xLL0VlcVA4eHBjM0lOaGtiYXhQ?=
 =?utf-8?B?cG1nQ09zY1Nnc1A5YlBQYXBMNHJyU0c0UEVScWpMSU1qL2hjdHJFUFMzRXRG?=
 =?utf-8?B?Z1I5WmtLT2NTWEdBZkRUZ1Jiem5MNHdoQ3dHYS9VcC9WcUhSNTh2SkNubklM?=
 =?utf-8?B?cFdPdklQTjNEUnJHNW1TTDhOUDF3UVh3a1JqcEFHbGlubi9Wa0JicDRVU3Fl?=
 =?utf-8?B?QXpySVBrSG95dXhuNWNxa3hWdkF0SUJoMlFObWVIMGRIcTVacE5COXBnWUp5?=
 =?utf-8?B?alVaTEFhY0dEWEl0VWdkSGppNUNqL1R6c3V4YlkyeU9tNWZVa2QrVmtNWnRw?=
 =?utf-8?B?WGVuMWlQVDhsNEVNNTF3RHRuRUdBd2JENmJ3cEk4ZXdZK01xc0YzVmxTaXdY?=
 =?utf-8?B?bm1XLzJpWDVLUHNpUXlIYXlHRit2NUlacWlZSW1wRFhNaDNWU2lrTzkvZUQy?=
 =?utf-8?B?d3Vta0FsTXVNTkpLR015RHpqekhzZytBakFmQjhaSVJjWXZSMndpek1sYjVC?=
 =?utf-8?B?ZnpFaGNLLzBRVTFjSmRNS3p6eTVVTVhOa1RMRkRzc3p3VzU3SEVBaEYxVzRG?=
 =?utf-8?B?bmR2NS8yVkd6Yk14VjZvZmx0VkJ2N1hqMGNxZmRCN2JQelMrcUlZTmxOaVY0?=
 =?utf-8?B?MDF5SUo5bXJXdFBYTjNpQS9Jckp3SFgyWmJDSW14bGJQclI0ZlUxb2RYVkti?=
 =?utf-8?B?Zm9RcCtEVGU2OFB2eFN4YmQxcnNBdW1YMEl4Y1hZeG8rcVozSm5CaE92ZStz?=
 =?utf-8?Q?C+Np3s+KRj+6Pzk+nrAj5IF6xOWLWwvYL5dK4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amY1K3BPQ1VOcDEwdWRRN0Vseml6ak9YTFRjSDZreW9keUFnSzUxQnd6czNC?=
 =?utf-8?B?K2swTFJUUkxEbGQ5TzdUZUFCZjZ0T0NHZ25XUklublY0SjZySlFHazFZMzNQ?=
 =?utf-8?B?SlFaU2tHZ1pLZGMza0pNWlg4bVNLRXYzR3RxR3NmMXNHanNPQ2xLanV6K3hJ?=
 =?utf-8?B?ZzQ2V0tncWhCeFdKcnFtK0NMRmRlWFpHT0NiN3VWY0hDc3RsUUZzR2RSMEZQ?=
 =?utf-8?B?ck85NGE4OWdLRzZ0YUN0N0JyNmowK0kwK083Wk9heGljMm5iQjV4a0VDOENF?=
 =?utf-8?B?ejdVTnN2V3dURDFTTy93aWFUWU5adFhTS09MTHMrQWFBVGlkMDFQS2JSYzMy?=
 =?utf-8?B?bHF0Y2RvNEdnNGkxUmovZEpna2plbmhiNERCMUNHWXVlc3J1WjIwZlAzQmsz?=
 =?utf-8?B?SHZkL095Slk2RHJ3eVRjc0xLMzMxdktXdE1MbTdQTllBT1VpRkVNQU5rZHZG?=
 =?utf-8?B?NmszQWJsemJTNWVhdzMxeWliaFU1L3FJSkR6bUdYVzJLUTgwQUtmTlYxQXpk?=
 =?utf-8?B?OFlJVDA5RmdKU2MxUUtMQ0g3b2dNS3d2b1hReStPVkx5TXFpRVJnSjNWbzR6?=
 =?utf-8?B?RWJ6Y2RGTWhkNUh3TnV4aU5NcEpqWWJtS3paUnpXUXh5NTVGVlRBZHFsSy9D?=
 =?utf-8?B?RStFNklVSG13RDljSUxuU0JmU1JqUGpSbzlZaXdpNEl1ZFFZZjJZWmdLNkI2?=
 =?utf-8?B?T1AvbGpIdEpaV2RCQWV0NVl0czB5anozWFQwQzlpNVJkdlBNOFJ6QUlzT05L?=
 =?utf-8?B?djZHbFNrK1BRb3ZOeTA2YUpPOXJEOWprSjdQSCtJODFtczZCWUo0SXVhRncz?=
 =?utf-8?B?OXZOeVlONmNiT05XMEJWWVJITXVkQTEzdDBDMkh3aUZHYW9vd1BxVWk1RG5E?=
 =?utf-8?B?UTNvZVhPR0xzUnFjZmdkZkluWHFIUWdnUlhabGlqZm41L1psWDNUKzlLelFN?=
 =?utf-8?B?YVBvOWdoVjlabk8xZjluQ2dtWjlhWDcveG9nRmNHakZtc01TbEcyQ1FKTWFK?=
 =?utf-8?B?Y0V6cDBjZFdzUFQ1eU4yZnJ6OGNWL0x4MitCQ0NIenRlWHkxa1VuTmJGOTgw?=
 =?utf-8?B?MllxemlpVGVYT3JjQmRIalY5bXpqQkRVNXZManFDUUFwdXVYcWZFZEV1UXEz?=
 =?utf-8?B?TVYwczAyVTVYTVl3OFYxbFYxRUsybFdiaFYzOFYyUHFZYldOc2dJb0g1YlFK?=
 =?utf-8?B?bU45dVNvVGVCQzJ5dXBQaDdVR2NYUkxsVUR2c2dEVnBvbDUzNnhwUTd1dkdY?=
 =?utf-8?B?VDdNWkVYZTZZcnBDL25OSlpiY1RYTU01ZGREVGFvbGVvNUFFVmxyT29XK21p?=
 =?utf-8?B?SS9aVnVZeXFwYjNJRFBZWFVEWkF6dnVHL3RTanJCUW9YbzQ0eGNNcXpoelE3?=
 =?utf-8?B?b0hSbHpZL2I2M3NMWEtPSVNlSEJTelp6ODhyV3NrTUNwang5MVE4MTFHS25x?=
 =?utf-8?B?NlhuSWJNc3d4RW9ibnUvcEgrMkxrZXdmT1FoaE9INHFUK2c1SjFZYXJCbkUy?=
 =?utf-8?B?aFBSVTdUcHh2UXcxcFhSN3RGWVZ4Nmp2dVNMNWo4M0VyUjk2WFdpNWZvQkJY?=
 =?utf-8?B?VDlac0FnN0dxNmFCWDlOZWhjb2VxZVV3Z0h0VmFJcExoYmtZRjV5ZFdOL1hl?=
 =?utf-8?B?UVlmQnFHbkd0YUhkVEQzR3Y0d1A2WjFWdkxaV0JoYnNEcmdDV21OVm9Mamdl?=
 =?utf-8?B?SCtidytDWnRRTXp4RElQU2loQ1RJT1RyK0IvM0dUWGpBa2NSNy9VZGVyWlRa?=
 =?utf-8?B?NmlVRXBSVnZsNW12U3RqdjFKZGg1WUltMHBNaVp4QWdRNWgya0pZalRHWnNy?=
 =?utf-8?B?RzF2WG5TV2o1TEpYNm5hbkd5bHRON2tneUx5UWN4NllzM2QvM2RtL0dHcDlo?=
 =?utf-8?B?VCtuR1VKbEJYandGWDk3YnpXN3NJTyt2VDJFa1htZ1dpV1BJcmNHa1I1azZs?=
 =?utf-8?B?U3ZKaXA5TmNzbXBNMDgvUzVROVZxc0hsN2dMWDVXcSt5dk9HdjdEd1RzRk43?=
 =?utf-8?B?OVlSbTN2eU1CQWcwRmJpM09oa2ZEMXJSTnM2OEppMWduSVdBdGFJZnhPOWhp?=
 =?utf-8?B?RUdHN0VWUWZxV25qNmxlWUx0OUREb0ZTUE4zZlJQMllXZ2JvZTJtaHJTb3NL?=
 =?utf-8?Q?PWMcs6vknFsMrcf3aTMiy9L5i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0274bf82-b700-4493-54d2-08dc9b8b21b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 18:08:24.8932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtTuy1WKP1iny3iDLnkGP4KKWP8tyQ8yBSnD6eZ9/WoB4SagJmPdcyd01GrL8E4JjbzZQjiw2Y+xk8dzlleWfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111

ls1028a has a reset module that includes reboot, reset control word, and
service processor control.

Add platform specific compatible string to fix the below warning.

syscon@1e60000: compatible: 'anyOf' conditional failed, one must be fixed:
        ['syscon'] is too short
        'syscon' is not one of ['al,alpine-sysfabric-service', ...]

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/soc/fsl/fsl,ls1028a-reset.yaml        | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,ls1028a-reset.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,ls1028a-reset.yaml
new file mode 100644
index 0000000000000..31295be910130
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,ls1028a-reset.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas//soc/fsl/fsl,ls1028a-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape Reset Registers Module
+
+maintainers:
+  - Frank Li
+
+description:
+  Reset Module includes chip reset, service processor control and Reset Control
+  Word (RCW) status.
+
+properties:
+  $nodename:
+    pattern: "^syscon@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - fsl,ls1028a-reset
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  little-endian: true
+
+  reboot:
+    $ref: /schemas/power/reset/syscon-reboot.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - reboot
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@1e60000 {
+        compatible = "fsl,ls1028a-reset", "syscon", "simple-mfd";
+        reg = <0x1e60000 0x10000>;
+        little-endian;
+
+        reboot {
+            compatible = "syscon-reboot";
+            offset = <0>;
+            mask = <0x02>;
+        };
+    };
+

-- 
2.34.1


