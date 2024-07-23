Return-Path: <linux-kernel+bounces-259966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0991593A08E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAF01C221CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C9152511;
	Tue, 23 Jul 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iP9/xEB/"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7714F9F8;
	Tue, 23 Jul 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738338; cv=fail; b=rSb8sSNh0trybZ02vlSk23R7lf3nkattCtggTkGWLx20g2IpZ2eRBjYpUUjvHxjGORdeEOm9BlCSdwNrdj6SZRuXCvrLN2ndSj9kWLN5W1Wrj7H7sqr5Bm33jqf9ZxwgFhMwAGYCse20thGCXoNrV81FNYIrhnNkczRN8LtlX/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738338; c=relaxed/simple;
	bh=nLn1IO2lgYsCFI63WXXaxNcRv/vJzrnFBkY0BwRFkOA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aqu95vqdeBizapjaJ2K3cRgU/SN3434I/nS3ZbD5XUktprTQGVnpn+hBQC6XVZlKKHieRJghD8UrT7p38j8+zxaWFcl54ZdTCoiN/vgpXsVCxCGIfJ9NqP1OFrJimXvFWEug57Umc6b1xQ23flSWmchM1CUcRoZ+9g02FZJ8Eeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iP9/xEB/; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7JLla/OnbX6bDDqgmJPr4Et3mIWmYWpzGdbQJ/bWliqyYUdKSXKQ6YujZppFIVZNnz3hy4qExK4jlkjfINPeKZHFJQpIKgQ+EuNniD8oqwsEGWokNZGQJIzidcr15Vgk9Ao69rnK3179T1mrpAIK34c4b7HeRjAM0UeH2tTruSQq8VYPoo4iYGZuY7R/QveWPIHU4/Udr0tFTNFxBKv3gYeYW19iL2K6vHWyHT33Rfh3e6+JAfWna/jOaGZjVdr62w+cvWYRmxuMIKXMXgUaVdtHNnbTSPa+saK9FtPZj+Q8uLSdbAfYDjTa60LriAEeOJTXq1AH3MQ3rZ6ztd31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWG7mWrTxYBbAdEy+g6NxTH9goXgNm17YnYBGQ8Ydk4=;
 b=Hh5GCdaDVa7olBJHDFoGIv6ApYYog0S5scXFCNqPOBabme3rUTSk14ZKYx/CNMu09/kdvlqX0Zu/PXS4quMlfs9gC5YyRlUOMAo7L6mjGFYzUhRKvxGnGZk0pCI/hv1bL9gwJsUkb6TwBHveAym8U+ymOYRDX1vhkVAv2LmU3NhEteEsOQBUJpRXUwDHVr1JSG9AnTkmH8BrTZsWpEj6txtb0iCjie9Tro4GENRvSoBLxjVlOP7J2frfGMxjRS/igOB5cZWmrHrrL33JePAKfjKAspyAwINb8P4PD7BxBQLwP4RtrddhWtdnwQuPNJpH98w+GUHVTI+qO5OqwWyquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWG7mWrTxYBbAdEy+g6NxTH9goXgNm17YnYBGQ8Ydk4=;
 b=iP9/xEB/wyigo50tMR5Bwwlxru/VJlRkeqhiEkLfw42YjcTfUWViRtADBmlObbURzHL233pAc6bfCniP7Qg2Hw9RPRhoVwFlQwlXocmRu0rkg4GIgXaRgW0hPhVkZz8L1owuo57ZU9EXYBMzKzuc8WBYlxGENPqSAcLlQZH+5V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by GVXPR04MB10993.eurprd04.prod.outlook.com (2603:10a6:150:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.31; Tue, 23 Jul
 2024 12:38:52 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::6d7a:8d2:f020:455]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::6d7a:8d2:f020:455%5]) with mapi id 15.20.7784.013; Tue, 23 Jul 2024
 12:38:52 +0000
From: Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>
Subject: [PATCH] arm64: dts: s32g: add the pinctrl node
Date: Tue, 23 Jul 2024 15:37:20 +0300
Message-ID: <20240723123720.1088067-1-andrei.stefanescu@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:208:154::37) To AM9PR04MB8487.eurprd04.prod.outlook.com
 (2603:10a6:20b:41a::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8487:EE_|GVXPR04MB10993:EE_
X-MS-Office365-Filtering-Correlation-Id: 190798a6-e55f-4c53-5a48-08dcab146832
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVl2QnpMWExONEtaWWgzZ2EvNGlPb1g3U3ZRLzVvTGhBVjBqSlNCbFhRY001?=
 =?utf-8?B?bkovREc0MHFRZ3lUQ3RKRzBnSEgzc1ZSTzZmRTVqa2ttOHhTMEVLaFA5KzNI?=
 =?utf-8?B?NWM1dFFWV3ArSjZTRW5QRUxxREhrWFRvcE90UXFGWXV5YThmMGtUVUNCbHlW?=
 =?utf-8?B?NXVxY210TWNVWWZ3dVhaVXZJRXBSMThNSWIwelNTWUwzbWlhQmJOdFdPOCt2?=
 =?utf-8?B?b0VXdmxEMEZ3NHpvbk0yaVhFN3JaYWVJblYxakNpZzhFT3BXcEpNMWdGaUY4?=
 =?utf-8?B?cFVmNVhvaUNPblp1Q1J1b1pydjFEYjA3Q1NDeFR1SFcvczNWTTlPcCtsdVF6?=
 =?utf-8?B?QlFwRHhOODlCMjhmd1NsYnVZOTZSVmlLMFBkTWd3eW5Eb1RjcmExcDU2endN?=
 =?utf-8?B?RGdUb0VrUlFkVFlpR2xvRkJLWm9xOTlPTnFSRExBS2FlUk5rUDlIYm9SRWlV?=
 =?utf-8?B?VFBOSElsTzlBNzRHOC80YWpsRi9JZktOWWZwMjRIbCtFbUJWcVplL0VhNGk5?=
 =?utf-8?B?dEFhaUhPdEZqbVpUbnNQalkzQWN1S1J2RGozMWEzd0Z0OUpvcXppL3Z1OW51?=
 =?utf-8?B?L3hnczFiYU53aWRoL2xodzBJMjZ3NWxCOXpaZkdxQ2c4NWJYZjBDd2p4SEtE?=
 =?utf-8?B?bHNyLzJrRnpvQ29rTEttNExrNEM0UlU3dFc1MndXWkNNaFZOSFBLVFoyRlJh?=
 =?utf-8?B?bUVYNGZyakRFSldjMFdoM1hEcE93N0RGSDVmU0VzcVMvdmU3L0lXSzVEZDJP?=
 =?utf-8?B?b1NtUzhqQnpMcEYyaGJ0WHZIWDU4WkU3NGJVYjVEM0NDUGR0d0RjK3BTZ1du?=
 =?utf-8?B?NUpvWGwvc3Z6bkNtWGpOK0VGYlVUWnBBQXY4YWY4L3lPeTRyMGc3N1hpb0Ez?=
 =?utf-8?B?WCtpNHdUUWl0N0M2V2pYVFZaaEoxR0x6NDNlNkp6UG5mQTVLVnhXVGdzYzZX?=
 =?utf-8?B?OHUrVjFFcDgzQWIwaFoyMTdtajRkWEVkM09FYW9UNlZ0dDhlQ00xcUFmRUZh?=
 =?utf-8?B?NHJDMUZFbVBlM1Nlek5UVmkvTkpXaVBVWEVBa2pnK2F2YTkvcFhwdmo0eHBs?=
 =?utf-8?B?a2Y2UTFoZnJPM0RkNlkrZGo5S1JQMklYeVdYRzVkZU9NYmV4L2pqTkZsK3d5?=
 =?utf-8?B?LzBhM1BJWCtyVG5tR2xLcVIreVZuZUlwckloODFzcHArWENLMWQzUGxoR2Vq?=
 =?utf-8?B?eTQwTHhZcnVsUnpGNEU1TnJ5ZXNUcERlQzNySUtNbWQyeVk3d0pZMlhybkRR?=
 =?utf-8?B?THJ5RWJEZ0RpeEt2ZitQY2xPQVFDcHlvd01KbytzbWI4L2VUSEdBNEdWYnBK?=
 =?utf-8?B?WG8wV2dzd0tpRTZMdDk5UlBHajVRckFuOG1uWTA0N1R2SDU2d3NDTFZGbzRZ?=
 =?utf-8?B?NURxRXNHVWZreGdpV3RhcHBVMXR0Y1EzeXpqQXMwNGNrakY2eWpVNU1XM1Bi?=
 =?utf-8?B?SHJwVVVuM3BhTGtpRHBjSnI3VkZLbzVZRDJnaVFIcG1saGh5b3RrVjljSzJR?=
 =?utf-8?B?RzB0cUVVYXFuTWJyOFdjcHRpQXdpTHZReXl2djZVaEppVVdkNTVYTjJxbk1E?=
 =?utf-8?B?VkZ1OUM4M01PY2JRN3BlUGZvd0dTbWlBaEdSQWY2WWgyRFhJQTFBZHcvTW0r?=
 =?utf-8?B?TjhnUFhOaitMSDZ0bnlEYkpoV2tiRGtrNEF0UU9ZeFVhWnlHUm1sTDJibHBJ?=
 =?utf-8?B?OGg4VXp2NEJUOFpsWGVkNEtUSlovUEpqSVgvMHdZQ2FBVlRiNW85MmxicTQ0?=
 =?utf-8?B?UGpQR2d5aFMxOHU3MldNU0xNSHlKMURVS2dWRjYyZWVncks0QnhJZzZsMHly?=
 =?utf-8?B?YkZRdGdHNjBLc0pjSC9xOTdRVnJDTjNNOCt1bW5OdXR5aFZ2aFFVT3hPSmF1?=
 =?utf-8?B?OHkxNGxoQnZIYUdnaWlZaUJibjd6T0Q5V2E5OHArckJLL3NvMHlZWmVncHZq?=
 =?utf-8?Q?9j6BhTGqu1A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8487.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDlaQWFYMXdVNVExdndkRUZROHZQM25scU9zQUd0eU53ZEdMMHNlTFRsTm1W?=
 =?utf-8?B?L2c5bHNQWlNKS1V0M3h0dmwvUXk4K2tIb0tSL081WFZvYmJsZEhDUEhhQXY2?=
 =?utf-8?B?cXJEYmNQRk9GK2xBRk9nbXpzWGF1OFV2QTdqeUhPZXhQNjNVYysxZFUzNkhs?=
 =?utf-8?B?ZWMreFpIdDR2NkllZ1Rhajc0N29lMlJTei83T0hteUpCMkFYWTAwNGVhU1NF?=
 =?utf-8?B?N1ArSGtZUkx2RitCR1RJeXRML3Y4QWx6OVZZNUVDTGI1MWJzRlZVcjJiQzVG?=
 =?utf-8?B?b3ZDcmR1bGFOd2lUaThaZU9iUkxSK2I4aEVWbGovUzBaT0poamtWZXpIZGdN?=
 =?utf-8?B?T29TZjNlSVVsWURORWF1QjRtNkVEZFF6SmFreDdGcFBNQmRFRmxTemhFY0k0?=
 =?utf-8?B?SVJCRnBmdGZBRk9CZ0RzazhwUUVXeStTWFdYblVxRGNjbnVmcG4vRWIwNXp4?=
 =?utf-8?B?UHVLWityRDdtWmpWUzRXajdWdVF1UStCVVQxWSthVmxaMkRhaC94Q3Rab0ds?=
 =?utf-8?B?czlKMG16bjV0aHVMQzVjZkVHMVFnTWpiNWY2dWF6RlJUTm9sQXFNa0dCeG5F?=
 =?utf-8?B?WGZQWTUyMkJPRVZ6dkF2VUY2MUFYS1ZBUnpQbnRTQThwUXgzN2NiMmNYSnZC?=
 =?utf-8?B?NFM4enRUYk03S081c2dRNkFTRC9ZM3huMnhFcVlrZDFWTWdPbHMyQ2k2Y1RM?=
 =?utf-8?B?MzgrUy85NGl5amZhN0RNbDkvc1F2WENCdXFEaldGZWpQZlpUUWd3aXUxd2tY?=
 =?utf-8?B?SVpCd1dOR3pUT3R4VE0zQXBhSXQzZzd1UUpFaUt0UzhSTlN4cFFEZW1uR0Q3?=
 =?utf-8?B?NGE2QW9KNmFxKzd1LzFLSzdzb3h2RmloSlFVVG9mVmhWdTA4bU51YW5NVjl0?=
 =?utf-8?B?V3JOaFpvakVTM2Q2MU40TTc3U215c0ExUVJRVE9hWGhuVFdZWHIvSFhlTm9V?=
 =?utf-8?B?T2Z1dnMyZ2g4Q3pVMEhiQXhvWE8reHBKTEUwWCtpUm5neDQwdG1lemJwcGUy?=
 =?utf-8?B?RkNaa2E5TTJiaFdTWUJiYVFIZk5abmxtSms4b0lhV3lIcFdWc203ajY5cG5v?=
 =?utf-8?B?RFN0dHd2d2p1K3RES1piMXRSMzczUzh6UWM3NTJzTnh6RDBBZSsyTkxmSit0?=
 =?utf-8?B?NThGU1NTNitQakVQK00vSFNnRG9HTndyUXJDT2F6c2tIdktvb3BnZU5Pd2No?=
 =?utf-8?B?ZVNCV1VzM2N3VmZVUUhsUWNoOUM0SUg5b0FodDhSQWZNSkw2UE9rblpiMFVI?=
 =?utf-8?B?Rk0xSEJQTFFFTmgyOXdYYlQvelVXY2lOMmNTbEY0eUZPa3lOUTRkSHNHemVD?=
 =?utf-8?B?RmVqQnB2bVNlcVhtbFp0MHFoVms1V1hWenVSeHlQSFB0Ymo0dVl5RmxjZnBp?=
 =?utf-8?B?UmY1WFRMVHJCTE0wK09maVlNNnRWT0lQMjZiS2k3T0IvU3padkpLcERXUjNY?=
 =?utf-8?B?R2orOWlDSThBRUZlRW5SVU1HRkllSHBvK21mS1lvbXFLUTRmM2kvQ3hzOVZn?=
 =?utf-8?B?aUpCSTVwczhDUkxETDhrWFFSbFJGMElkRC9PQlZVNVpXK3VpQTIrSWUyeHp4?=
 =?utf-8?B?V1VmQ2pzeXh6cjBiZkVGS3ZxTEpjcVRtQzdTY21VTHdyVkU4Wi9oTEFuazND?=
 =?utf-8?B?ZGk0d2RZWXN1ekh3cFFLQTZDcWE3Sm5PeWd1TjNLTTBRVTdtVGhUazZpSVNV?=
 =?utf-8?B?YjZkdVR5Mmx2MEtqZmtMNkpYbkw1eVI0SDRZMlhEZndaSTlpZTVNMVVKbjRs?=
 =?utf-8?B?cDl3NU0vNmdMY2l2Um94SUlINVdLYTUrRW92cHd2Nzd1WGkxTG9IN1VMVG9X?=
 =?utf-8?B?ak5Vb3pUWS9IbnlRSkxjSUZrSTVjOEFGNHViNzlBTGtxV2ZpVEdtSVM3MkhN?=
 =?utf-8?B?a2cyV0pjWHA5ZnorbWtHcENzT1F3ek84NkhwcHl6aXlmdzFtVjNlRndmU2Yv?=
 =?utf-8?B?KzZ0OHF3K29hd015QWZuRUJsN2V5Mkl0NnVWK09ZQ3pqWUMvYm03aCt5bmZq?=
 =?utf-8?B?bExuMzNXTVl1MGhzZ3lqOGUyYnBYRC9ydzN4KzZ2RkR4eDJsMVlzQWJaTmNK?=
 =?utf-8?B?Wk1vMFNJZWFIMldSUWJXd3c3RWwzUnNKS09ESmowcmt6OWtFRmZEb3cxWHFJ?=
 =?utf-8?B?blVRK05MdUgzOWl1T2MyVXVlUlpWaTd5SEhUMGlabXdYMk12clR4VHZQOCtv?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190798a6-e55f-4c53-5a48-08dcab146832
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 12:38:51.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAhwY1xOBLx9U7cb9kZu+V+9NeupiQnxhJF+wEg7gLTe6NClu4+ikRqYoCpsRZsoQMXe1bcslfhJfYObLnSQjH/Dl7t5iElbCwRnPEb31oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10993

Add the pinctrl node in the device tree in order to enable the
S32G2/S32G3 pinctrl driver to probe.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 51 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 53 +++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index fc19ae2e8d3b..b31f6857640b 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -159,5 +159,56 @@ gic: interrupt-controller@50800000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 		};
+
+		pinctrl: pinctrl@4009c240 {
+			compatible = "nxp,s32g2-siul2-pinctrl";
+				/* MSCR0-MSCR101 registers on siul2_0 */
+			reg = <0x4009c240 0x198>,
+				/* MSCR112-MSCR122 registers on siul2_1 */
+			      <0x44010400 0x2c>,
+				/* MSCR144-MSCR190 registers on siul2_1 */
+			      <0x44010480 0xbc>,
+				/* IMCR0-IMCR83 registers on siul2_0 */
+			      <0x4009ca40 0x150>,
+				/* IMCR119-IMCR397 registers on siul2_1 */
+			      <0x44010c1c 0x45c>,
+				/* IMCR430-IMCR495 registers on siul2_1 */
+			      <0x440110f8 0x108>;
+			status = "okay";
+
+			jtag_pins: jtag_pins {
+				jtag_grp0 {
+					pinmux = <0x0>;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <166>;
+				};
+
+				jtag_grp1 {
+					pinmux = <0x11>;
+					slew-rate = <166>;
+				};
+
+				jtag_grp2 {
+					pinmux = <0x40>;
+					input-enable;
+					bias-pull-down;
+					slew-rate = <166>;
+				};
+
+				jtag_grp3 {
+					pinmux = <0x23c0>,
+						 <0x23d0>,
+						 <0x2320>;
+				};
+
+				jtag_grp4 {
+					pinmux = <0x51>;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <166>;
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index c1b08992754b..7a8c6c943706 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright 2021-2023 NXP
+ * Copyright 2021-2024 NXP
  *
  * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
  *          Ciprian Costea <ciprianmarian.costea@nxp.com>
@@ -218,6 +218,57 @@ gic: interrupt-controller@50800000 {
 			      <0x50420000 0x2000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		pinctrl: pinctrl@4009c240 {
+			compatible = "nxp,s32g2-siul2-pinctrl";
+				/* MSCR0-MSCR101 registers on siul2_0 */
+			reg = <0x4009c240 0x198>,
+				/* MSCR112-MSCR122 registers on siul2_1 */
+			      <0x44010400 0x2c>,
+				/* MSCR144-MSCR190 registers on siul2_1 */
+			      <0x44010480 0xbc>,
+				/* IMCR0-IMCR83 registers on siul2_0 */
+			      <0x4009ca40 0x150>,
+				/* IMCR119-IMCR397 registers on siul2_1 */
+			      <0x44010c1c 0x45c>,
+				/* IMCR430-IMCR495 registers on siul2_1 */
+			      <0x440110f8 0x108>;
+			status = "okay";
+
+			jtag_pins: jtag_pins {
+				jtag_grp0 {
+					pinmux = <0x0>;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <166>;
+				};
+
+				jtag_grp1 {
+					pinmux = <0x11>;
+					slew-rate = <166>;
+				};
+
+				jtag_grp2 {
+					pinmux = <0x40>;
+					input-enable;
+					bias-pull-down;
+					slew-rate = <166>;
+				};
+
+				jtag_grp3 {
+					pinmux = <0x23c0>,
+						 <0x23d0>,
+						 <0x2320>;
+				};
+
+				jtag_grp4 {
+					pinmux = <0x51>;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <166>;
+				};
+			};
+		};
 	};
 
 	timer {
-- 
2.45.2


