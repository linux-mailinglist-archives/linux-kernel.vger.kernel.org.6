Return-Path: <linux-kernel+bounces-284090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BBB94FCD0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C411C2234C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6546236B11;
	Tue, 13 Aug 2024 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JGmcZcoq"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD23249F5;
	Tue, 13 Aug 2024 04:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523724; cv=fail; b=o1OxgVKlSx8ccFPic2BP+GJWjA1A+bAmaRq+aT7nXafDtFCuEnm3RTWRmqCxHQ89dPUJePyTDYXUd0OpY1mbhH5+H1O0GwAFQ6Gm2xEc2B+TPwq/KvbvfcWqYvc3CYmqL4Uu1yAi+vDh//r1aPavnZr6R63OnuQ6ZAawvgvclTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523724; c=relaxed/simple;
	bh=2gK7TrVeucZFkBI5LweCWKxZvjJoIwVAWePbXkA7cq8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PB1M6armGLX6bSTTD2SNh6twiBBahvR890jao//e9YyH2QFfl2J0DuKT0cTtJLWUFDwUWQV6XChzV0CbMcgpqpC3aH/u86fdMk1yiBPlL3vFC1HbEpdV8EF8J98PFXgaiv6/cP7DTiZkGn/vM3yJuf2yqiXguSLa9PjwGTvD2aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JGmcZcoq; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKGhD9WvT0koV9FZVGLDbEb3P+6e8OL741B9DcQpSeaciBGUA7m19TJ4cSWxSvquQw4h6VxmoOfx3Nz0bPOJmN4EHICw+IlKimDnmn1FJkWvanHkMHJGKgCUa+SsJeP2MWwHObGe1IpmDgq3DiaZeKXc1kImWHj7LmMdlOZjLoWW82m2xHtZltk1fjmF/BUHQWADrM+rETdnKQF6tVM/H86qkeF9IMZzziQNvTeo8snoOph7PIY0G9ByenpFCZK8wj9yFm3iYzxpG1GzXnJ1Uyj5u5+RrbSHFpcuJTxShwpdzOAAx4eT5c7/JLMiB9aL+nsHGEGUVCs39yr+Jpld0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWAsSUR+c07dRxyP0oMbglcQy6KOL2JK9aqXtvXMDNY=;
 b=VYIvggmpKcpjHp0+UZe3jc/5BHvI6hDb/m3uJSRhqMxsg8pSXPkc/iVZ53Mr8o+JJhq8OTaJzv6GMHfzAZsOQsb7swKs3CXz0bH6DQjFOKrD2axFaIMH0daTTxd9NNnSqsu2A0nS5Zq274ZlvEky85jN9ShNbj+u8clp/1PE7RHM5Qqs2427j2dvzEOhbVPhn4eBRyiie7keMqroZftTyKJ4ms4TIs336XyXsJmWUskeFbW1ITJAknPeHWj7npzszOoiP6evt/DF8EWXClJpuFhzgmJrLgxNCB9kkZqKqQoDJJB6gUszdc6a9XQu2Vzuz4O4UqROCi/KXVGbPuTldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWAsSUR+c07dRxyP0oMbglcQy6KOL2JK9aqXtvXMDNY=;
 b=JGmcZcoq5xvE4TKHJI0ovcqY6+fI4zYGoHepKq4mTsMhW/UYFL1TECZ/yer5RCviHGlZwq1URmohXvaLA4I06Xk6QicXGdkITal3Pxwqz26pUzXQFgfjZLJcAP9w/WEqphf2XNnkIZWPL+l01vR3H44DUgnSS+vmdPetQPO43Ftto6DLz3pmOtbOoZwHmtam6Kf70rn/gKjyiCn9WZ4ZpmHzHSMh7RNb8UpyNMYyKueC78eimtI+lTvz+36Qm+a2dXL7/hlRZwyOynVwjIItR8VehNseWUFnC6fE41FCg8U0gkovKsTS+5lQlsA092CtnvfhjL74ShEOOmdjtL2f7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:34:58 -0400
Subject: [PATCH 03/17] arm64: dts: fsl-ls1088a: rename gpio admin_led_lower
 to admin-led-lower-hog
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-3-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=902;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2gK7TrVeucZFkBI5LweCWKxZvjJoIwVAWePbXkA7cq8=;
 b=MwpoaBtC5fJQa5xQ5nvGqiBm2zGKG2CUSYH14fZ5kNwg7mnzBZWLjc55VB9+GZe8Va7zM6u0y
 ighcwiUp5ebDkPaFjJ4lZu7LhvbSjVOxKgQbTkIR0ldZ8n7P28nqkP6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a6605f-f124-4d9f-e64e-08dcbb5156a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c05UMjl4bkN0WER2cTBDUWtYaXFCZFZnUWRIMGN5WDFKdXZTWVdvMlJKT3Ro?=
 =?utf-8?B?MkZURVFkS2pZRVh5eHVYS3pXbkxoRCtBWFU5bXBLSGRRUk43RElFVnRMV0Y3?=
 =?utf-8?B?K2hzbHVOSnZzSUZzR0lQcitDbmRjbWUzZ25Gbk9jZ0E5L05kcE1xMElXVjZB?=
 =?utf-8?B?cUxIWWxUeVVVN0g2UVhkRzlDdkNiRmZ4SisvRnd4bFh4dFJxTTh3ZFl5MEQx?=
 =?utf-8?B?RjVaZlQrQlBjOXVhMk1henE3UU5CbHNlSFRZZ2NMRWp5VWxlTFhQYVJLVkxh?=
 =?utf-8?B?R0J0ZFc2d1NlcW5idVorSEI0cjNpSWFQRVRtUm01ZzhPczBtOUNuOXFicUdR?=
 =?utf-8?B?SFFjaDFqNUxEb3c1NU0xTGg5WFg0OVFTcTh5bEd4dHpML2QwQWlRd3B0WVJT?=
 =?utf-8?B?dGJCWjNhWW8va2sxaTF1TDdCeGxaT2lNcW9NVVI2SDlKczhkMEhjVW1TSzdq?=
 =?utf-8?B?cUFTUERLcEI3Ykd1M3pmREllaG9zR0VpM0FsYjNvaW03Q04zSzVIRzlYdFNs?=
 =?utf-8?B?azlnVUJFODVtSW1IMDZUZ0YwRGlOeTB1NVJJRWtxZWZQNy9tQzROVTRJbVVp?=
 =?utf-8?B?RHR3RVp3d1BkR2RSQmcxY3B2ZTk5TDB4UVV1VGFaRmRwS2t1cjBCa0Jod1NY?=
 =?utf-8?B?ZHZkUjNmN2ZLUmxYVFJka2RDZ2JXaVA5c0tHTkRNTFpscE91NFY2L1RwcnVW?=
 =?utf-8?B?b0pZd252dU9XYmpUT1pRRU1iRlBldFJ0cnhNenVHRFBGTXJ6bUNFNnlzVFB4?=
 =?utf-8?B?VlVKZ3M0UEdRTnNBelNSMTVUVGg2VkppVXZmR0EvemUrMm92SW4zSlNKdzZZ?=
 =?utf-8?B?VkJRRDBrNnpWM1dVT0dMTUl4dHozR2RaTnFYbTUrTVplQktXbUxYRWx4Smxh?=
 =?utf-8?B?Uy8vVGp3Y0RiWDdjZHFuK01DeW5ZcTd4aTc2dWIrcFJuakk0WHhhdDdvK1M4?=
 =?utf-8?B?M3NKdUFaUWI4YUhpSmI1djJaNjk2akJPMHVvKy82bVhDNVdJSEpsazc4NHdE?=
 =?utf-8?B?QTlZNy9mSVp0U3VJYlVQcWphVElENHJoSWxWRU1GRGx5OGVPQXZXekt2UlVt?=
 =?utf-8?B?SzBhYTcwdXhlMHRtaWl4dUFscmVUMFA2N2pRZ0RHT2JJNFp4d3VZY2dYQndN?=
 =?utf-8?B?b3lLbnhzWHozZ2hMQjc5aldoZTF1T01sRVAxZTJwSkNjbzFoNTkzazlTUjh6?=
 =?utf-8?B?YkxTWGY2dEFHY1RBVk5xcnB5TENYZ0pmanBTMHNpMVROZ3Rjcm94RUtQZzFt?=
 =?utf-8?B?NGh4U3k2VkVVKzJIVUZNeEsrWllscnpNNlZaZjR3THduL2s2bjdqSmk5UW1O?=
 =?utf-8?B?UVF0R0xTbkpvWE5saitzVjU4UFE0M3NyakpNS2J1d2RML0hMcSsrOUJBVmMv?=
 =?utf-8?B?QXRVY0lGNzlqakd4Q1Fmb0NLcDJlYU9IS21ZbUhJZjQ1QjY0cHNZbmpGdmZi?=
 =?utf-8?B?cGFPM05KdXlXbCtqN1JHc25hQTJjb2xRZjNxNklMT0grNmJ0RkZISVB5czNS?=
 =?utf-8?B?UVNCMVlNZ0U0RjE1a2NIUzZFenVsTGdYTGx4UlJGUUZlNlU1b3lhUy9NeFFS?=
 =?utf-8?B?aWROVzZMWkFKVEJvRFJpSkZ5TURseUM3QTNIaHRETWZrUjFUbmd0bkE3YWJi?=
 =?utf-8?B?YjErWm1BS3FOZWZXM0YybnYrM1U1N3h4U0dsdjBKWkM5UFN6Nm5PcjYxSmUw?=
 =?utf-8?B?aTg3WVhjYWk4OVIrdkIyZThNNEVmMWphTzc5MEYvSGZQVUZsTWdMVXl4TXp5?=
 =?utf-8?B?LzdQamJPWFVtWm1BcFh5UUhyRkU1d2ZmZEtwQTltdU1VNCswcHcvaWtxR1F1?=
 =?utf-8?B?YS90bmZaV1BaQmxKRmNHYXRCUitRcU5GdjhpY3RrSXRzNWJqRWFwSncvVHdH?=
 =?utf-8?B?Z2tLeEpXY1B6TXloZ2pvOUZqKzRweTB2bkUzakdaUXJWS3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDdzNXVJKytnT1BZZHIyTFRIa0pZRHhlV3ZVVEE1Z1p0SXdaZ3dIQzh3UEta?=
 =?utf-8?B?cVBvUEUrb1FTSEVkcEFaTHh0WUhGbEdiY1lPdkYrRjNKZWppSjJ4SHV1aWNu?=
 =?utf-8?B?eUNFNEJxM0JIOHlIUDRGRTdob1VPd1EvampwYXNqbUFCWkxqS1UxNzNkNTBq?=
 =?utf-8?B?UURPQkFxSEsxamMrWFROaFVTOWxucGxOZTNZUkIxMkREV3BUSGNkT0tPR2di?=
 =?utf-8?B?R1A1YWhrU1lCelpoNlIzWlNiQlFUZ0Q2alRKSkRGUUF3dTZweEkyT21xSHh1?=
 =?utf-8?B?WlVMUmQ5YXliMlN5OUQ4UW91NE9IcEpIdURyTnZDaTVralA3Mm1admV6RXpY?=
 =?utf-8?B?bXlNMzI3dGxNVHFvV2lDTGZBTTJ0RDBXcmkyTWJWdFBoelhMN0huOVh5WUQ1?=
 =?utf-8?B?d0R3cHdUUTE5SHc1V0htVmVLcWMvWkswVkJlbVlWVnJ5VnY0MU1iL0Y0M0E4?=
 =?utf-8?B?SjR3aXh4WXlOT0JLZ1JpWGNxbkpJbC9MU1pEMEVPVkVld0dCQlVTQ3dMV1B6?=
 =?utf-8?B?MlNRYlJYek5oTk14Z001MHFyUlBKYUdMdXBJVEFGZ2t5MGRKaHFUUGdMeHE3?=
 =?utf-8?B?c1FsK2ZWMldsZnhoa1NUUkc0Y1NsalhMdmVFL0xHU3l3aEdSeXZubFJtd3hC?=
 =?utf-8?B?KzJNTi8vMDdLUkxjYmc1ZUxkS0h2a3dpMGM3c2trLytrN01ETjhaaDgxemRV?=
 =?utf-8?B?M2JYdmZrbGtkc1A3TVljM1Bod2xTR0w2U1FIbHh0VzZnaUxLdm5EMUF6c3VW?=
 =?utf-8?B?Nms1UmtUZVpRV0xOTElITy9ZSjNLRDdQMnZlWTVOSEZMUDVXcDJTWXBhenVW?=
 =?utf-8?B?S1kyY3QyajdBQWJuWXhLMElkOEJOYzNWc2F4ZG1FSWlzdnZ3Sy9Ed1o4eFg2?=
 =?utf-8?B?TUE3Q3pEU05POGtTTTY0NVVLbmE5ZVQrZUNIZWcyTnQxRTZiM1RuRjdyTnNv?=
 =?utf-8?B?SG5FY1FnYnp3V1g1VmoxWDFwZWNhRWFNcmoraElPOXRUa2tzU1dmemxaU0xu?=
 =?utf-8?B?dzE4dnpZSEhqS1ZldnNLZEcyL1ByMHR3azd3YUZ0S01BRG5IckJTZTFraExq?=
 =?utf-8?B?L3U2dnc3anc0a3Y3TXRIbFlOcy9iZzNOTFd3VGxkeEVWcVQ4dzdZR1RidWRp?=
 =?utf-8?B?RkkvREZGS2diNUFhaVNoWGU1eWVzUE1mcGRTWDJwa3RmTTZhQUwwbStBR3l0?=
 =?utf-8?B?cXU1SHhOWDJYM0laanFuSUhSRm1OMEgySUI1bWFDUGMyMkc4c0NQbWJFSDZU?=
 =?utf-8?B?OGcrNDN4UzRlQmk4Q0RPM01kNkpJRHZsSk5zekFaUW4xVFFiTCtEbExEMDFl?=
 =?utf-8?B?bWdMRlpnT2poNGludld6cWdFR0UvRkVaN3RSaUVOQnk5TFdEWmJLVmJOK0dp?=
 =?utf-8?B?ejVyS1c3WmxpQ3lOYXdUbVRvQmQ0REJMaXBTRmZiU25ZZ0tLeHpDbk1BanVa?=
 =?utf-8?B?R1RQa3BvaG5tSno4RDI1MmV5WDZvOTNZMFpCZEFEMnlYSDc3ZnNNblI5TXhZ?=
 =?utf-8?B?cWo4dkJNWGczV213d2ZRUk9hMk9TcFZUWTlGUU1JVldEMUNNc0U5aHQ2TlUz?=
 =?utf-8?B?OTByRllEdDRGck9sZzJIeGxWcURzTXNjcXdFT3pGUHZMcFZWbWRlVDRrWGVq?=
 =?utf-8?B?V0p6bnIrSzZlWmhKNFVtMUdkVjZtMVh0Z1B2ZVJMaVlwQnJQMDdFMExxMEl6?=
 =?utf-8?B?elpwQjlIL3NsVHNIQTN1SER5bU1KU0ZnRXdyZUNTK1hHS2tyVXo4L2JCbHZV?=
 =?utf-8?B?bW5mdTBFYnVGbWgyVzRaNXZmMGxTVHpUOUNqOU5LcEZCb2NSOWdsNC9IeEVE?=
 =?utf-8?B?V3dqV0R1T0pqSWk4ZGNHWmRoNHhmMTQvZTRweE41TG96bXVUTHBMYTdHSDhM?=
 =?utf-8?B?Y3hsZjByZ2x5UVZ4RnpUelgyL1EvbU9HUFUxdVhhblp2Zjh0UXlBSWJrUU9x?=
 =?utf-8?B?UW5oVE1PeGZXc1UwTnBoYkJiS1JqSWgzQW1EUVg5Q3pFZk1DcHRZZHVoUThM?=
 =?utf-8?B?OHRCWU9tNlNHQTE0SXVjRE5GN1QveUZIMG5xRFE1T0wxMnFmWG04aDJrT2Zz?=
 =?utf-8?B?ajBsR3ZzVnpmS3BPMjZDYURGWTR1UjJFa2NVa1AvV0tVcUlHOWFtNGs4UmFm?=
 =?utf-8?Q?A8lKwauXnMAdd2HGaCrFMWVcz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a6605f-f124-4d9f-e64e-08dcbb5156a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:20.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4frAuun+9+HEugRId0e+GikXGS/iLonRNxFhjtuVlZWPbHXhytsU2EWJxd4Bzl1vEPaM2BdgwSxmyU8MPVv9lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Rename node name admin_led_lower to admin-led-lower-hog to fix warning:
arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: gpio@76: 'admin_led_lower' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index d4867d6cf47cd..57f2082143c8a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -220,7 +220,7 @@ sfpgpio: gpio@76 {
 		#gpio-cells = <2>;
 		gpio-controller;
 
-		admin_led_lower {
+		admin-led-lower-hog {
 			gpio-hog;
 			gpios = <13 GPIO_ACTIVE_HIGH>;
 			output-low;

-- 
2.34.1


