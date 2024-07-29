Return-Path: <linux-kernel+bounces-266312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F033493FDFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A7028394B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848D418D4C7;
	Mon, 29 Jul 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QiaYKWRb"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB42189F50;
	Mon, 29 Jul 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279618; cv=fail; b=YTT7/5yFuPopxn0lNMmuqIFMLoVcjoiU2SOx3AHXWy5cIx779gL2kX3uS6ed27S0BX1YZ3ZJluCo+wigSGYhZ9Y/nl5NacBJ/ujwg8IW4oxZxZHAiHPRbZVBYueL8o5Rp4cxUW8QpAfDF0ND/FiawMO9iT2SpJSvtrpYZutIsAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279618; c=relaxed/simple;
	bh=HjAHggPqTCDggtBgc9q6c5xaUSzEeIGobzeK/LJ4XLo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hKtV+3rHs+f9H7ZPtAJ30XQXF+orJy3B6Vjt0CMM6+5JRZnk6W0Fz0NxJLLJHawqK5UUWPUKE02DVcRG1+fp/NA6xC/h+ZUzbui0g3EIlgfWb9sb4zePlLDpJSWrnltLqZQy6OjhgC0cdWvnA9BeYQPjqcEOYUmc0CSyYGm3kfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QiaYKWRb; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dy24IWfDswpgbVGrMJek7hEoAa9FNTJUYBZD7f10gS4gjrF29XmwCns6KQzwzHINAJPIspeK5g2QMN58tJDpu8Eurlz1tgAqyJA7cZvDALxd3vsBQV+cFX/blltvWlkUiY0hOMgslH/Yp5AcfnChHzIAbxjXwf9bHYBI8OrOw2WiLErzi5hsETXl1pwYMDYfR/Bpa7ptZd4Z0OFEtPXxoKqCxzDp3Y+vSEz2D86hevmPu9bJq81mxhk2aM6dVoEJ0UmbjM5FravLSpsa0bHnpagM/XBT1knrcxdmdQR3L0YqKrXugXV51ku8pWbEG2vLyAFuELNU6MBZ6VeDvpDcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEJG/yQOZyJWnLP8HiZTNkCB5u61Gq67p/LN4EBHW1g=;
 b=nS0ybpcl0hRLt/u1TGzEDMBec/Kh0gDM27QnGf52/g9+Yiq/pMwZfgbsd6sho1JNbVrjGD7iSJFZwTOsfTc/90JycENpzNtikGreXYOtAJa5dOdqlGIxWjKKbK0Z+fu9n7R+u/TekI27RiUC61jwCxzkOC4m+V+FcTyswqKlBHBmfIzqEb/ICfLCENvmFihcOOIoYkrfA/2jkeLXsOdSvNlfPqkLEyV8sf1Hzi6Zk5d8RHigaxlF8JdngKOu0xClnqqmYSEDuTfyTMzdYEKxxXwg4trjREHjhvUq/+pOlNdi10A1Df8zLnViP4QdhvCE+4iUfeX7TL6jdntZAIULUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEJG/yQOZyJWnLP8HiZTNkCB5u61Gq67p/LN4EBHW1g=;
 b=QiaYKWRbQdfjxJ/ysxeEjiD+xsCY9jpQeCt91meGeqfW09iN249EeKio+NHlCvs5OjGSRtrqWA8dlsm2zbaBJmoGiRbQLyVqQ9j7wE4PbJKEwjgWNQI5r+YJ9tR23Y4J5XK10g7sKcnPkNcoJZ9TUexXv3ME+kVqShdtj/IzLamm565pxc4/ADZMMShbyhyKhsB6kblCumt0lvnBY2XczP3YK9BaU9CGsJKsoYWcCwNSWjetunwLLDpqleJS2mWvXy1qNdo/YoOvgn+NZH8JethQV4RVCv5jpZfUhfLD05yPevbSmVQhnuSiGb4iNlE/I93eOywhnRrK5Xs5i5fc3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6939.eurprd04.prod.outlook.com (2603:10a6:10:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 19:00:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 19:00:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 14:59:30 -0400
Subject: [PATCH v2 08/10] arm64: dts: fsl-ls1046a: remove big-endian at
 memory-controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-ls_warning_all-v2-8-942d80ddd441@nxp.com>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=1595;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HjAHggPqTCDggtBgc9q6c5xaUSzEeIGobzeK/LJ4XLo=;
 b=PGr9G/14EzEC9+Ksisay9Vm0SgcnwynzGApR1fvprcd6x9NIp8bp9xHCkI8qnEKm1Ger06AIe
 SV2K/hB472AAIqDRXKH3Y/5Q9MpkvEKke3f+0cXQfT012cujl4eQjBH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af60286-650f-4ca2-5e5e-08dcb000aabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk5LZVg4eVJxNG8zV2NKbXQ1Ty9oVXdzMUpUT3VTSG1iTVRpL2ZQaHBNNzgz?=
 =?utf-8?B?YW5XY1FqeU83bmd4NFk0N05OcVRvb2RnOUhqVUw2VFRFWUVpM2hhTWdscmFa?=
 =?utf-8?B?ZzlFUkhRbUNZbFpwQlVwZHVvaWpjSzArbEdLenExbUsxNjQyRTE5QmNyWnZt?=
 =?utf-8?B?Q1RXaUdsRC9yQVVadHAva0VlSHJLRExOSGNpa2ZNRmljOGNhdk5COE1OemlM?=
 =?utf-8?B?NStVMU83a2FveGdFMURZZHAvYkZNMzBRcWFaeHlpTnhkdVdlNGRPUU5DQUhU?=
 =?utf-8?B?NTYxeG1MNGNYbFJwaVk0dnhuOXhxT2FkNjlEVC9HMEFZbHZweGZVSGoxT0R6?=
 =?utf-8?B?MjRXaFNwaHlVMmY2V25yOUtoODJNSlZORWxZRVVlUCszcVNUZ1NXdFlnTFNP?=
 =?utf-8?B?UVpwa2Y2b2VoR3gva0xabDBjcXU1SG1JU21tREVaZHRyZ0RGbkt4UFpSMitL?=
 =?utf-8?B?K2plU3daTTJMQTROSUMwZjJvd2RJYW4vVGxKaWhaa1JFaVhOMWJhc3FneHRO?=
 =?utf-8?B?OEU3S2xKY0poYUtxL0ZFNFJoTkZNckNlTjdUbWQ3L3h4VTFzaGV0VmI4MTl1?=
 =?utf-8?B?VzBqNTJyTGo1YzIzWHdFTjRHUDFNN2pEWW1OV2o5S1ZJTTRDRTdGMEhpYnVM?=
 =?utf-8?B?TkN5RXVxQVNLcG1MNDkyYXRoN01TcG9kcWlaSW9ubUtGRE5DakNaekJFQVBh?=
 =?utf-8?B?V3NZcVNiOW1wRjFhcDcwMkd0Q1Rnb09zK1g1VW1DQVJzc2dBb091SFEvd0JQ?=
 =?utf-8?B?MUk1VlhvL2pIbEM1UGQ4RS9MTGhFNzdsUTIydHRCdDFvaHQxQWF0NWd4ZHY3?=
 =?utf-8?B?ZGFKNUFHSnJrRVlKSTdiRFkrdkszdmFWT1d5amF3a2EvUDFVcW9UNnYrdXNB?=
 =?utf-8?B?UDZJTVNLT08yV2ZmcDB6d1FKY0RIazArQWVTUmx4b3dSU2Z4Y0ZVYUlyamUr?=
 =?utf-8?B?emdCQ1A1M0RqcDVnNWh4M0Uva2taMzRBdUJIWmN2VEdDN2ZUem93U1ZCcHlt?=
 =?utf-8?B?eXJBc1lCOFZNQmlNK3ZIS1RqbG1XdVdCY0Q5YkF6LzRFYlF0bXNwN2pVK01L?=
 =?utf-8?B?RHQzaE9NNGp2YlZuUFk2WEdHRHMxSGVOZkYrZXFpalBBQWF4S2o1MG1kMnBN?=
 =?utf-8?B?TFNBQXlJb00yLzJUQ3RyRG5SWUVVanovOElNT0gzMXNQMTlOY2hMQ1FPUWVL?=
 =?utf-8?B?d0ZDYnYrM1Y4THp4clBhcXBSWFNGUTQ5V2lTZUFWbmhyYXFyY2RwTWE4M05B?=
 =?utf-8?B?SVJkSVZSSldPaXJQbWFSSE5SSjE1ZEVJMU5lVzEvRHpSSHpEOFVOdTVXVDFD?=
 =?utf-8?B?TGhwRnlETEdTRGEwV2RNS0xqcnhzM0tDQkkzcitqbTNPMlFQcktEYTZyRi8r?=
 =?utf-8?B?TDhUZEJmRWNJMWhuNGtyQWRFUXM2OFBrM2ZOUTd5MGY1Mk9rM0p3dnZXSnh5?=
 =?utf-8?B?ZmtpRGgrdldiNjFndktEaFJnc2NjOERnMVFBTUNFSlRBd29jaGx4Q2YwLzhC?=
 =?utf-8?B?ZXRsd1gzVHMvTGtGNHo4aURuaHJoTUwyRnp3U3B4UE9PL2dJRnhoSG5USXA0?=
 =?utf-8?B?WVN2YWpvdjVGcU9BeHJ5ZDc3Slk2dktzU3NnOE9hYWtuYjhHV2ZjSzFQdXNT?=
 =?utf-8?B?alJFcnRBeVJHQzVwSEV2dmN4enV5S3FnNzFKQzMzMUNUdHp4cjl1SWNjU3oz?=
 =?utf-8?B?aFVNblZYVVV3K1lvNnlHVGtjSDhVZ2FDVjBOTDl1amJWUlZYbThSY013c2Mx?=
 =?utf-8?B?TlFXNnJYYXBFamxQeUp6SnQ2amM3eGQ0SVJCOUFaR21EM0FoSldHbkE0Ri9W?=
 =?utf-8?Q?7cB3K2L0Y+Br7QJ/GfDxxOlpQuESxi3DxaHio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGFIR1dTOTBwNUJGOFFXTVJBRFI2QjRCSDR4MnZPSStzQjU0eFpkOVhXWm02?=
 =?utf-8?B?NFF1ZTM4NjlVMEVJN3ZQaDhJVmZmbWVNcHNGWlRtenZvMnQwTTB2L1lhSFFr?=
 =?utf-8?B?eThtQ3M4QXV1REVYZGRPbEpBdWR1dmRXY09RdllBS3RNTjFJWXFqUlFMaEtx?=
 =?utf-8?B?dVRONUZjTkVKVllzY1pFeUpTSTc5MytJdHNXbW8wNVJDS2hnNXkzNFJGYVQ4?=
 =?utf-8?B?UDgyY2s4cUJJUkRCa240WTFrYXc4Rm5GTURMQjNRR0Q4USsrQVlrclhVbWVG?=
 =?utf-8?B?Ym0vU1ovRmdhdldEUHVERGhJSksxTmNLM0kzV25VbEJHOG5DZWdUaVUvWFZQ?=
 =?utf-8?B?TGdxMDBpUFVqcmxWVW52T1JFbHZBUEhDbXlSMkRsWmYwUmNzMi85Z1FOSXYr?=
 =?utf-8?B?UFdVYmw5OGtadXZmRm0zZlhwemdEQ3B3aEp2VzNBdGtua2sweEttTXRaRnNj?=
 =?utf-8?B?Nk91YkxuemR1R1ltRjNFYkxBYXBKLzc2d1ZUdHh2MVFPamQ5ZVVyd1V2TzZv?=
 =?utf-8?B?d0pUVE0yQUtGNVNwQWJKbjBhVm40WDgvbGM0UmI1UW1mcWlTNjlUVXZndERZ?=
 =?utf-8?B?SUg5b1FiSVR1bnl0RldFT1g3eWJZaVNWT0UvZ2k5MnBUNFdHcG9qd1F2bmtI?=
 =?utf-8?B?Wlh6Y0hjRjYrNU9sWnRFVWJGWFdPOE4yaGFKNEdvdFNjNnN4enBNbEhiUFBH?=
 =?utf-8?B?MjV4dklxMDFRUy9YTGZxMVAzRjBLNmQvM3p2U1RpcFE5UTg3MU5VQWc0djZq?=
 =?utf-8?B?UFhXSSsrdFZWdFJ1T2MxY1RpRVNvUkg4ZjB1VmlTMU56QldBSTVzK3MwMG9M?=
 =?utf-8?B?U3d2TDJTTTQxcXRMdE80WGdzNjZCb1dYaUFGK1k2enkzNDhjcDF1blhxVTlZ?=
 =?utf-8?B?MEhOSUhHRHlMNk54a3FlZWMzL3dwaGtXeHgxWlI0cHRRQy9CZUQvcnh0L2d5?=
 =?utf-8?B?Q1hjcW10OUNuNlkvNWZRSU5sUFkzWEl4MVlnV3JBS1JYdVpGZjAxbDZYcVVr?=
 =?utf-8?B?Lzh3QWFBdEExYy8xR0xYb2lFTWRyZFgzTElWaGFDSGpxR3lPbXVxN3BnWkR4?=
 =?utf-8?B?RDNodnRNQ1lQUlQxakFPbUlUZFhRbmJmSTVzK3dFdzBKcS9rRlg4Wk93aEcz?=
 =?utf-8?B?eXRaWW5ramVNT1FXRzlrY1BrZENkV1dmNmdCMURON1VHK085TnZpWkE1eU11?=
 =?utf-8?B?eGo1WUdUU3lCNDlXbTQ0am9PQTNUTndTVFdUL011Z1BwdVpjanduNmc5VFRV?=
 =?utf-8?B?dXltRktPUE4yb1N2WVBsQkE3aG9rQVJBc3pGVVZlc05oYWxqNW1mRHJqbVNX?=
 =?utf-8?B?ckQyZDgremR5U0VlNlFFTkF2TDNNOUdmRG9BY2hLT3lwakVrMVNVT25jejh5?=
 =?utf-8?B?bXJBM2RnQjV2SFA5S0d1MUIrbWFHUUtlRGdXcllPd0xMeVZyT2J4bWhSTkNh?=
 =?utf-8?B?K3FkWWJYTUE2RG1yY0hTMm1wRzBiUFNFT0tYQkowU2w2R0xzc3ljeE04QXNK?=
 =?utf-8?B?TjJ0MjZvS2k3amQvZjJmQlVuL0ZQMkdFdThNejU3Wk1IM2Q5UkJkNjFRMkpl?=
 =?utf-8?B?eFNuWE5rVTZjWjBLcUtNVUdQVHI3eG0xb1hJcWZQOFpnQmYwalk1Wk9EWmdT?=
 =?utf-8?B?RVllZFRjWENlSU9uMHZQQzZkbHZ6Wmc0NkpTNlJaNDRkWkdMbEtuREhwNDRD?=
 =?utf-8?B?VmxhYk1mV1NBRXllWUZZUFp6ZTVjZklnekl4REUyejE2bXMxTnBPaiswRzBJ?=
 =?utf-8?B?TkpoRGN6K2lBYlU0cVAxWUdoK3crdWk4SDlDS3JkT2NpU0tyd2tTUzc0ZkVu?=
 =?utf-8?B?dDlFeEM5MWZEczBwbXBHbVFqOURSQ1pTTkxXUXRKbjQ0VFpXRkYveGIyWVRH?=
 =?utf-8?B?VFZYK3duQ1JJWnVpUHVqM0IvcmE2TFRaMFdpbTNuOGtWVXhXdWkrNU1VUjB0?=
 =?utf-8?B?V1I0L2g3T3VoOGRxTkEwakZCaVRuNkx6Ty9Rb0RvZVZpTlFhUDBsVFludDNH?=
 =?utf-8?B?QXJkK2FwbEZhSjk1MmRJS1R5TWRyNm5ZaHVaUzNYMzJMdmZkS1VzbmYzdWxR?=
 =?utf-8?B?UTBJVmF4WktXTDF0Z1hIWlBVa3NTSFg3Y0pvcEFaSHFVL0R0OVczN1R3dDFS?=
 =?utf-8?Q?1a5UytRIdKYmrgXO7h63gWj40?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af60286-650f-4ca2-5e5e-08dcb000aabe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:00:09.1486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03pJEEPOEfg5LXh6+z0tqqvSJxu2H+haBcCm8c+96zHCr0x8RL0I0h1vnKrNwiXQ4Yk3FHSj3XioSMiXFpULVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6939

According to binding doc fsl,ddr.yaml, big-endian is default setting. So
remove it to fix below CHECK_DTBS warnings.

arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: memory-controller@1080000: 'big-endian' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ddr.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 58daf3f1d6373..cf92badc66558 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -438,7 +438,6 @@ ddr: memory-controller@1080000 {
 			compatible = "fsl,qoriq-memory-controller";
 			reg = <0x0 0x1080000 0x0 0x1000>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-			big-endian;
 		};
 
 		tmu: tmu@1f00000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 41a1f4f2f880e..e33c04a8ea3f9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -282,7 +282,6 @@ ddr: memory-controller@1080000 {
 			compatible = "fsl,qoriq-memory-controller";
 			reg = <0x0 0x1080000 0x0 0x1000>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-			big-endian;
 		};
 
 		ifc: memory-controller@1530000 {

-- 
2.34.1


