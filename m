Return-Path: <linux-kernel+bounces-312307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D222E9694CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530FA1F246B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EE1DAC4E;
	Tue,  3 Sep 2024 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vk8Vu9OA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367991D67A8;
	Tue,  3 Sep 2024 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347357; cv=fail; b=ZL5d81PlGVzDDo6sPgv/bJnt0DB09knQiN/qTtUlEQf/HYDwbVLBAkRW1DpS5vfnUlvrsrbmNmeRaQVlIBsLMx4otxQcrgqa66mypcKbOIQ7SOyQ04EJZTidSbnNLvmLdaLe031EXWaytFhq2c1Kc8PQ8jMGtch2ZP0+C0M1ZaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347357; c=relaxed/simple;
	bh=nvP/Z+rCPMhlTH5S/iqBfLUS2swaGru+WNFCuHfvKuw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Hcj3o09qbfKi6GR7iopJtxaK1ab4hJIc1WbJDsfal826GSAFTIXjAq+cLyaEvAdsyuzU9CA9L/9HbW5JkbVUfe8rw4eFjQKpAq7n6loNWcjNWjmTIHHk14mQ9IqaaQw82TWIlgxN4u8m1L2asvUkWceTDHSveQNaGKg50VsGuqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Vk8Vu9OA; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tv7s4ZJ6X8DxBhJiNd6QhYHwDMXB1lySPNP3F2+Wg/rvJNnUG8vMs/TFNmbmu6IZIBMaFa1a6B1En3fE09UMzWvKhcKcyKVt8UzRKmYX/iaPHfMI98vJdjQr/VSEuhl2tnB+nmvxkmXgLdilf1wF+nNDEkhLPjq78xPV++RgrE/lkl/VoSH58FaJZZtocbzeCgMQmZeSPIy1nZWQXyCB3rCWXW5Yxsqhvdm7bBON/liaWk/n83p9ny4a06caYvPtPhEq82XwzucU7sge42g68Mgzdge2zXuzXRVGGaqNC3s07WZcqUa2n2J81cVuMLMUHBWn7+9bjk3v1sYZxr9mlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFYdnIftNb6EmSTKPe2WBvrftuWHy+K2KeZBsTQltr4=;
 b=VRtfcmA64Yj38rU12GNWHxQxedz4EeJ7oV2F/Lu1XMLb6DjXw0xgxBX1s8PpBvC+fhb9b1Vi9Tcdj4rbH8LnNNfaUkOvMeJJy3y86CYYixyDBs/ZS5ey2Wgwj866FrliIm2LDhrwb+RIyixmFf4BXNpI4wyVDr2lf2rwjEY50um5yytZutWohMUoASenxpNErZgMceH03vOOipwlA4H8WRxc4g+vPRj6faEa5Y5SSzRzlNvveNxC2D4mefSomFsEAFS1vCEkYE3AG3aH59JL1aralw4ROWUKGiXx/PwBcSKgd75Z3rFMkAJdL728VH/GVqvAdsGUc3JiBlInYY9TwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFYdnIftNb6EmSTKPe2WBvrftuWHy+K2KeZBsTQltr4=;
 b=Vk8Vu9OACea2PeWUzxNa6/BfmvDocIllY0Y5U7L+/Bgi07nk/S5Q343kNd3jypA3u07rzRMksJKnVCdM1TzDtOYol95FYik7TpvBBubgtvo2esPcCYdxd6TJUKgkmkFFUnLyopql6fSfQqcEPf2h5C/xhgXLZrJ5BEDXP1cpoEfJssCjfZkuZW4j10zRvBOLG/azP6h+MHJ0yjHt3zNSpm2ul0RiBrDFJNomNSG/2L+cWK7yfJ5yhVW3wSCl+cNZVYPd695TAWyyNSk4fFXu49nMlVBB3z5J7fi2w2se45Mh7Y9e1bJ37mXujLGbs1HOnFlR+GrNyS0KNEkkG3Iddg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:09:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:09:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Sep 2024 15:17:49 +0800
Subject: [PATCH v2 4/7] arm64: dts: freescale: imx95: add anamix
 temperature thermal zone and cooling node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-imx95-dts-new-v2-4-8ed795d61358@nxp.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
In-Reply-To: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725347874; l=1453;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=eaohBRB2Fb4PfzYBAS7o5j/hhfFB2BYaokXf8EKWkPE=;
 b=io3JuInVSGHYoylThjZqAUZwboxcq2IYap+PFFbFqIK6C8Rw3tdZ0CU7W37XoKBZRu1xCLVWf
 sJz8gEOoA50AUt2VDIrEQE6yPAzAcU/8ZOP/9MwlpBPOv2K2yvEIlhd
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e5e182-66f3-414b-66cb-08dccbe74fdc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXErbEcvb1RMbS9SK3RuM3Y3UFpaTWZuRFdOSkN5R1pHS0FVVENId2NOMkZC?=
 =?utf-8?B?SDFJdUFNMHR1M0QvY3Fkd09OR094S0Z6ejgzN09qQTd2Z2xPdHByUDhuVnlT?=
 =?utf-8?B?a3Z6d3huVnN1MW5yMGN2TkFEQlJKUU1qbmQ4RnhOdE50bHR0TmpGakNQS3dV?=
 =?utf-8?B?c1F3cGJDcmNBT04zUmpoTWs0cGhmaExZMG1DbTlpc042NFpFRzZXNit1RW16?=
 =?utf-8?B?YUJUdklvSjNVbGoyd1c5NDdnTjU0Nnlld3FKeGhVeXRIMmtPVkRoVnRwZ29H?=
 =?utf-8?B?NkNKS1l0SzNPbjFqRHd2Qkx1SllLWEZxUWhBZGJ3V2tHRVNFUVp4Vi9Ea3g3?=
 =?utf-8?B?SW9EOWJnNkFEcjhRQzN5d2djRmp4c1NyNFZZcWszVDRUeEVaUUFzOXRGU2Nw?=
 =?utf-8?B?L3VtbXlCbUJzZk1ZdFI0dVdQM21wcFNMSWJ2dXpTb3VPeUt2OE4zc3pGRTNS?=
 =?utf-8?B?RnhQSG10OVJCdTJmbVZRTnptTFlFWWZ0TDFZUzVsZXlLeHRnSE1pSjc5MUxM?=
 =?utf-8?B?UHFSK2wwZzl1NUdpY3VURGJ2U2hxVjNBRUZ3bFBSaXF2WkhwTHdUZVdNV29Y?=
 =?utf-8?B?SkhGWnJ6NEN4cWp5dlJ1Z09zMW5Mc2REbzNLdHV5Q3ZnTWxMTDVwMDFiS0pp?=
 =?utf-8?B?aXdnTHJzM0EzTmZLVSt6QzlJdk1Kak43ZVZhZXVnaW9QNVU3SWxlZXFEeGxV?=
 =?utf-8?B?SjB1emtIdUplRWF0eXhYZ2ZNNjVla3BPdXdlaUlZc2JQelZZOVh4ZlpsUnNE?=
 =?utf-8?B?R09kMmJhRjcyaVhoRnNlTmtMbG5Ccmw3TFpqRXNsRlNlU0RNTmxWQ1pZVGh3?=
 =?utf-8?B?Q0czWE5jTTFyL0pKUEYzV3kxMlFjMi8xRitQZkx6aFB0OVozMzNkR2VZb0RR?=
 =?utf-8?B?NWJIYnJPVHFtVjgwMWwzbG1Fa1RDdDlDMFRsaVBxNHJTN1dQaGJLcTRNSkJo?=
 =?utf-8?B?MVY1a1ZiandzSTZCWU9la2JhQVo3dXZoMjMzM0hOSFN4cVNZREpDTnI4L3pE?=
 =?utf-8?B?ZHVnbFcwN1lWQVlTUEFjV256cDN5cDBYazhmUjB5MkF0emxGTnNhSnJJYUZk?=
 =?utf-8?B?MTFKNFIwc2pUWTY3Y3YyZkNJOWxkK3A1SzdVajR6Yk5YcEhtWm5xd2xqRVN1?=
 =?utf-8?B?N3FMc0tlcDMzM2pxQWF6NHc5UExLSXBTVWUwbmxSTnNtaEtoM2dETzc1alpQ?=
 =?utf-8?B?RlIrS2MveVlxbzRMdlluRzVEV0tPSzNlN0J3KzhydFd1SHBRSXAyckVlcFY2?=
 =?utf-8?B?c2ZHdXVxeTZjUjA3eFNhRS9IODdNSmM3VkNqY0d6bXYyc1FQYS8yNlQzNGx4?=
 =?utf-8?B?TG1TbzZySllqSTBtUTM3M1VScFdtM1QyODJ0NkVOWTAydzBic1FZVE8zQXor?=
 =?utf-8?B?Y0tqN0Y1YkhyYndNdm85bmtuWUxsYk9LNG5xTVpRb2VtbjVJdUtMQ3kweUxp?=
 =?utf-8?B?eGU0eXZlVDFmazBXWU50S0VzeWRXbVJjNm1lZ3lLeWM2eU1mMVhzeE91aUZR?=
 =?utf-8?B?RHJaR0hrUDZBeHl3R2lsdGlacUIyU3V0czNCa015Z21lVmxNdC9weGhRTUV5?=
 =?utf-8?B?RFIrcy9MRGN4cDdyYlF6a0lhdkdWRlllT0pCOUVNOHJNbHB4TjlkazJvNFRS?=
 =?utf-8?B?LzhiWmtMS2NjYjZya3VWZzBLRVRZSTlQWVFLbTZiUDNpT09nWlRtOTFOdE53?=
 =?utf-8?B?TE16eXVYRmRPdzg4NnFzTER1Vmg4MTVjcHZWWDBob0NHYUM3L0pRTXFXRzRZ?=
 =?utf-8?B?cmlIdStiZUJVV3h1aXVPSnVacEdBNGJFUGNYMEZuRHk1WjkydGx2N1UyOWZp?=
 =?utf-8?B?ZGsvRVVsMnpqUDdvNjlFbUNkdUdISjB0WVR5WnZTZ2NHcXh2UEFzNVNTY0Jj?=
 =?utf-8?B?bmpmQnhtQ3hJZ0xERnVCL1YzR2R0YWNxcXBHWGNTdmZNb2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmhhcXBKdS9NUm9zaUdTMXczUGxTMEFKUWExNXJSK050MVVuWFBNSFhwTHV0?=
 =?utf-8?B?bjRIU3ZMYkdaNVgwZkVrOGh2TjhHRFRQSStvdTBPbjlnbUpzRENueGc0MEg2?=
 =?utf-8?B?Y3V4RVVHTGlBbXd2bnRmY0xHOFVvcFg2RTlQZ1FRc3M2VGlDdTVXcm9HRm9w?=
 =?utf-8?B?SVBxZEQ2aitlTTh5NFNNT1orVE9hV09RUjFxZm9JMXpOQ0hvV3lDQ1NIL3ls?=
 =?utf-8?B?TXV4RGErb01sT2xFZldCVDZvcUNSaUVOWXRlYjYrdGNVY0F2T0JGN1FCZXph?=
 =?utf-8?B?anFMOW5XWmgrQTF4ZGpwL2xBRFFzK2crbzN6SHVBcWV1c2hJa1JGYXViVE9t?=
 =?utf-8?B?bUFsdmFpL2JibTlaOERlZFM5cXJRN1g4NDBoQUc1OG5HdEVrbVpYWW51UG9a?=
 =?utf-8?B?STlFTzRwL3l0cTJXM2NLMUMwZ1Bla2doYkgyN3JDTHpVUlZiRlVLTGF3Ritx?=
 =?utf-8?B?ajlkcEc3Vlc3SWMrK0JhV0ZwaG1MOXNKSWJrZ0xvTlg1aFRHWDNUNEJZZVBl?=
 =?utf-8?B?R2I5SSt1Mk8xanFHY0hDbkRYTk1xblcxTGVsSjFwMjZtQ2NqSSsrZ3NxeWdG?=
 =?utf-8?B?Q0lEWmMrNzE5cjBMc1FIZW05UE5nd2grTGpBeHJ0QWV1bUtaMEJyYWhmekdy?=
 =?utf-8?B?UTJDd0xrOXU0ZXZUc2ZwUzROeWNKTHFhQThzODJxY0JtSFhYTUY3blp0WFQ5?=
 =?utf-8?B?aVFWbG51Vit0OGczTWl2RGFGMFFkWTk0N011TWR0QUlVNFg4QTYrY1RLWXNw?=
 =?utf-8?B?NGwwRmhnN1pYUUs2TkVCdG41LzlvQ2JTcTB5dTZUL2Y4dG9ySVBQSWRlM056?=
 =?utf-8?B?aGRyYktqcHF4NnNFdmM2MmRBeno1RzViYXZvMWJVakM0YkRpaHhmSk81Nk1T?=
 =?utf-8?B?ZXRBblAzTVBnM1pkUHZhM2Vod3piUnZGd3NjN1YyVUROTDZTQjg4cGhDSFZD?=
 =?utf-8?B?RjlLeHJGRExLR3BlZXRjL1FBRHFQYXJ5WWVuTU9wMk96a3ZyRXhMZnIrM1RD?=
 =?utf-8?B?ZUd6Ky9YVGtSRzl1eGJOMzdiZ2dZeEVrbHJhLzVpM0Fxb1hYL3BSQ2FnSzBM?=
 =?utf-8?B?WS9YNjVCd2hNam0rRnlJbEIvR2xlVFpwTHdOZjlLUkZSeTN1TXdPOE94K2ov?=
 =?utf-8?B?SFhiSVFDbEszNmtzTDBZQkdDOUVPNW55RC91RkNGUkdlSmxvVFRheW80OTFm?=
 =?utf-8?B?b0haMFoyUVU0MEx5OVF0bjJ3WXBqdG9uTXhCYTdCR2tXajVJUEsvbVNadWlO?=
 =?utf-8?B?NEZwMmZBUFBUTTFCaUdBVG5YRGcvRDA3emRkcGJHbGVvLzFydlJvenRPRnFZ?=
 =?utf-8?B?MTAyUXlsbDBONkJGdTMvM2lwM0sxdnN3bVkzSjcvU2VjMjdPUlp0cGNpVEV1?=
 =?utf-8?B?SS9hTjVHODc0eFFpeVVvVzlOSWRHa0toTmVUZVllRWwzUERYWjMzWG92OUdz?=
 =?utf-8?B?a2ltVnFQRFl5MFM0bHBDNG9lUXRRUXptc1E3eTd5bnRicnNwU1A1alo3c2la?=
 =?utf-8?B?WXRlbFN2MCt6SHdFQnkxNkhqZ2xwSXBJRWVtbWtJVWY1TVFncWhlZVBscnNk?=
 =?utf-8?B?T3ViaWNZaDdOckw5aTBvbUVPVU1CdUpHYnM0cGFBYjQ0OUkvdlRUSHY0c0lk?=
 =?utf-8?B?cVpTN0pkTTJWa3BSQk5mWXkzdis2RVN4bWE3SjhCUUR6R0pXQmpWTXBGYnYr?=
 =?utf-8?B?MC9WUTYrdXpBWENNSDNvcEgxdUpEay9hNnlPQVlqcktsY1FLeFdURFFXek93?=
 =?utf-8?B?aGFVTHF4a3dQK1pORnMzMmd0OURtM2krWUFONktzY2FVd2Q3aHl2Z01hcDRq?=
 =?utf-8?B?WElobEI3dVRTMlNQMUd0YTE2YVNSbWl3dWV0SkFxY1d2emU1SlJTZ01WM0xs?=
 =?utf-8?B?VHFZbTErK015RnVxeThzaXgrdDZncGpPMEN1b2NhSHRhTGxzNnVtMzlOQXUz?=
 =?utf-8?B?Y2lCNTdTcFBSaTlpekxjeEVZMGo2UW1qQlZzZXNQWEZKZG9LT1hDWmJaUkxT?=
 =?utf-8?B?RjlsVk0rNVc2cXM1Q1ZDT251alRxd1FSZTZzdnd1T1JMRVdTeFdhRm92YjZ4?=
 =?utf-8?B?ZmROczhPN0dRRHhpVnNHL1ZhZjVhMTAxbWpkMnF2cGo2K3VRWkxPWEF5Z0NI?=
 =?utf-8?Q?rHDHltPQ/EXAHkdsREo5y5Qkn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e5e182-66f3-414b-66cb-08dccbe74fdc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:09:11.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygYaIs5cntoYQj+9frr1SfSQsjCjHgnyTj6uW8Kw5yrJ1/Sht1GXWWbG0y8nVJTut41UiTTVQPxIE+lfEje8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

From: Peng Fan <peng.fan@nxp.com>

i.MX95 has two on-chip temperature sensors, one is inside anamix block.
This is to add the anamix temperature thermal zone and its cooling
device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 2cba7a889030..d031b9548aaf 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -372,6 +372,38 @@ map0 {
 				};
 			};
 		};
+
+		ana-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&scmi_sensor 0>;
+			trips {
+				ana_alert: trip0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				ana_crit0: trip1 {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&ana_alert>;
+					cooling-device =
+						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
 	};
 
 	psci {

-- 
2.37.1


