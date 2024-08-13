Return-Path: <linux-kernel+bounces-284087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6427794FCCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881BD1C22483
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F21CF8B;
	Tue, 13 Aug 2024 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V6axU1tz"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B028DA5;
	Tue, 13 Aug 2024 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523713; cv=fail; b=SaF93p8pp5GCy/TO+dkHp2yRf7sxMxtuKluzgfHyzCzfMPLF0EWj/Nfoqw/KcHS+kaENiednEqutj7lTYihUGMIPUHz+lNQ25QUHqgQN/g8TyznrQwbDj+v74Ohq38+Yz/eS69hXiZFsoVQlKibLOn7XD4kLyA1nryhMCkITGGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523713; c=relaxed/simple;
	bh=hFnfauz4dp5jpu8u3CLGvGLKnJ59E4kyRbv0BwF+nkM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=OlQSOEEGs6BaanJrUOKf/a55TWVa3J47KzSePJNTWf+E8EipDxrE7sQqqx1Cz0MKThvzT+r2NB5YvbpolhnM2CxsI6vWNrViD0DO9VeNr6EDK5Ze90aT8ftD+x5g3Imbci2wN2bC0LQSl5PsDDLe1C0kkg+IZs+N3IcOzmtBCBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V6axU1tz; arc=fail smtp.client-ip=40.107.241.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/lvWJ8k/mMecYwI4S4svLwVQvJ6p39qA13e5Y/E39CW22kVwCCmxVZvpITfD+a80pmkuT+bdXwRysi6XcsjrHxUXIRHiPBwKqo6JzdihTdbOlXkX4bMLx+m39/gK+WlSuBLzR/ijv9z8W1sxpzTRfoBMgNmCTsXkvSDQjOhQ7VvRPMNiwrp0/Pfm8H+Is2tgkmIsbLypOTC6G/Q8oHO9U6Z5igP7jjQw0ezfM3Y3l4j88aGqN+arn0KbNJxh2Dh/6kvj1RZ9J6iYWlTVVbmuErsoxxUIQBSa+PCQ2dQkINYWaKs8oCNfE81wEEk4bZZCNZeiDz7lN1L/fU55RDT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvXTQNcITrBTPQTA50UYChIiTwT5rf095f4PqLhYg2w=;
 b=K4mc71hIKciihFbRBhZiMgMfDzRvKrWbDokcvgbsqtevWF/3tjitv0GD/sgwoEOvObKhkP6UL5wiv0947sfLb66vxc89OKautm/XIiw/JTbvc87OmijkaFolioAIjSjz/tbRy9QdTxS8gyCu8TDbYfZPiPLog8TcI1idRNCvrSrUaJoH9ebdGTEEHso9a/oszdbwbJWk0xk9Qwd6iC/4Nq92nkibd3o5lNKsU+UtS4bgO8EBEYgFT5NFrMmDS5wkBlmPUM80vmYG0tRdFXKowN8NILMwz/w4Yx91hAB+jBQ4D7Wzxl67OkwUqjuWucpKHMH1Ctsmdue37QBkgXaUHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvXTQNcITrBTPQTA50UYChIiTwT5rf095f4PqLhYg2w=;
 b=V6axU1tz2Gl3u6/FuhNCeZmkB3bvE0gD5ERLgzhJ2rrHKDGMfqv17OPVzz9BQO83BMOzHoPZcdkig9iLFxtQakLzYq247wKpyQDvES3PwnpiemYuvyb3jnXy/WGQB1kByQUzYcACDAPCCu97P07wWe2km7uBPZ2VldIs0vQDaAMGWSqdrtVj/Jo3j4FcSO8hfhoU2k5qVOeQFgixCB38Sro4OcOvJzeCBULLJnof1aszPYtQvSlC2eTstnfy9+MTeY8z+9zVbza2cn606HIEvIRKXms52kjD2lvS+dEVjj1VUDijZH+DpxksIzSgpGtJyq2Zg/99dDshYFRqgdsx8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 00/17] arm64: dts: imx: 3rd dtb warning clearn up
Date: Tue, 13 Aug 2024 00:34:55 -0400
Message-Id: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG/iumYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0Mj3czcivjyxKK8zLx0XfOkxBQLIyPjREMjCyWgjoKi1LTMCrBp0bG
 1tQD/MNDPXQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=3626;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hFnfauz4dp5jpu8u3CLGvGLKnJ59E4kyRbv0BwF+nkM=;
 b=7AIazUp8nopJq0SDMVeUB0kdm2waDw9IOpCJhgDosbDgf11mJDwbHanCZ0OEtyuR63vcluPBC
 baSttiKe8zaDj5O31b3nDmSEShhh5yK+6gEpaUZNvltvzaLCgA3UjV1
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
X-MS-Office365-Filtering-Correlation-Id: 4b67f492-05e1-42cc-5246-08dcbb514ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzZ6aUx3SW82SzErd014MS95NzVqUHYyTFo1eE1lSGJ6VmtUa0ZxUjk2eWFH?=
 =?utf-8?B?cy9QRHk3S3haZmF2OWVyK0M4eFBRaCs4SU0yT3BpTW1sazlodHoyWDAyS1BO?=
 =?utf-8?B?NDBKQnRPbjlBQTE1ZmdwM0xKVGJ1MlJFdUl0VXVsNFY3WXpyTHN3U0F2Q3Yw?=
 =?utf-8?B?eVc2eHRObW1Zb1h5SzI1ekRvMW90bXRSRUhzNVJ4RU1OejJrZ202dC95Z2x5?=
 =?utf-8?B?U3Y2RHo5UGVUSTdFaVJFYmJLRUUrVXVwblovTGRJL1FWcHp6SXpoSVFuMzVS?=
 =?utf-8?B?eFMwVWJJc05YOHJvQnJVaTZlajdPTG5JK09PWkdhbjFEZko4dENmS2ZYYmwy?=
 =?utf-8?B?VG12OHVSWUlRZUxqR040MDRBOUl0bEFMOWQrWjlrc0tJRTE5NlVSeVJvVUVv?=
 =?utf-8?B?S1NGL1UvYmV0N0VKdFhrbjJhUTlvRCtsS2FJanUzbnZQRGpidXJReXAxblVT?=
 =?utf-8?B?M1BVWXdSRTlWTE1oS1pPZ25RSy9uR2pwcitGTG1WSEZ3NVhxU0NTZ2ZYWk1O?=
 =?utf-8?B?enNPY1EwVE9FYmxmeFhxTnZSNEx0dUtrMFVtM2x4b3hqZWQ1bUVlamQ1cDBC?=
 =?utf-8?B?ZzYvU3FFdW41YWlSdnJ4UWxYOFFSNDI3MFNiMks2OEJYbEtiNHV5Vm40NWJM?=
 =?utf-8?B?NWt6ZGRUR0VGM0VneVI4b093TURCVTh5c01uSGlvOTJOMXN2NW9ETlVyYWpU?=
 =?utf-8?B?cXRpZk4wcndaMFVjbklSRGhsMFJKOFliMVpKQnlqS3BuOTNwaTEwQUJSdnpl?=
 =?utf-8?B?OTR4Ly9QVzU2RDJDTzM5Z3FIMnY2WnJJdDJlK2R0QUFNeTVtazd4UlA2RFVy?=
 =?utf-8?B?Q1lrUU5zVXhCRzRocGxiT0pFOWdkcno1dkxXVnM4R2xXdkhEd3MrSzNTZ1o4?=
 =?utf-8?B?VFltZ3EwditZSFVBcThUeHRlRUdzbmZLdzVlTmxWVUkxcGNTZXhGUDdVZ2M3?=
 =?utf-8?B?UEpXaTFkcnVxWlY0djVqc1NTa3g1bGNxbk5GQXBySzRPYzFheUdTQlRHTGZo?=
 =?utf-8?B?Y25wdFRBVjdUOWVqcE9tTDBWbzFMcHpFV3hQVjhvNE44WUJBbExTOE1Oa2RI?=
 =?utf-8?B?SGRISDlxQ1diSnJLYTVYUE11VzFSYlZjY2NQa3ROMkUrbXdLaEZ0d1EvNWww?=
 =?utf-8?B?SHpZSGJXUFMvVjY1bC9KOFVROUFOZ2RRdHpBejB4cXJBeXJ5Y0VZcGFoQnYz?=
 =?utf-8?B?WmpuaXJjZ0VneTBZeDdjOGNGZS9WcGVsamhxZFZlMGRkWC9YRFlsNXhoWFRv?=
 =?utf-8?B?TTgyN3duTmdWM1lzNk5PcTB6bTJ1UWZHUkZwd2puNnFFZUxXK2VYdzhVU09J?=
 =?utf-8?B?b2hqTUxwOFhrS09USkZvU0J0V0JnUEorRkkvNUMzTnoxcXNSRGZLM3dhRTNw?=
 =?utf-8?B?TlRaYXhFWHlmN0JFSHQzY2RYU0ZFbXR3RmhlUFFpM0dhQ3NGYXBpY0tWeElr?=
 =?utf-8?B?LzlBNEh0ejNnMmlNa3d4WFhhY1NjTFFkNXlEK2J4Wm9udEpqMTNFZ2VQWGJu?=
 =?utf-8?B?NEJRSHNnSW0ralE0VWNhZWxnRHliakZUL2JmV2VRcVF1VFpMUGtsYm0vcjhx?=
 =?utf-8?B?TGNkM2FMejB5dG9POXZHZ0hXNEF4SmZuUDRWQVI2djdGNEZ5d1ZJMkppZnc5?=
 =?utf-8?B?V0NLMWVMTlhRVUl3Z0hHR0J6M1NGVnJveGQ4M1F1M1M0cXZUUDRzM2RLc1Fz?=
 =?utf-8?B?TFlUMmZpWDNPWVcxNmp3dWFqUE55UFpWdURJR1BsUWtUeGE4SUp5Mit3c2JX?=
 =?utf-8?B?SXRsc0pYejROU2pJdExnU2ZKeFJGRzVOa3BmYU1weGt2YXUwMWFSSDcxeDEz?=
 =?utf-8?B?VUc4RGtRcW1QYmRKSWRSeXJub2hncS8wQk5uK2x0N0dFcDJSOXV1ZDJpNysv?=
 =?utf-8?B?WjgzOW1mcWtSaTlWOW1RZFJyei9kempzMDlzUEpjOEtaenc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2dqWWowMDlqaE8xdmh0VVptSG45NFNMVEsxbGtRMGhlN1MvTWZRUmJWa25W?=
 =?utf-8?B?ZHQvQlNqWUZPTDY5NEVRaXUzalhWNVB2YlNnNVo2Q0RRS1BQeENkRmFZaVhT?=
 =?utf-8?B?eTNzRnlRSW1LL21idkJYUENtK01Oa3E4TVRuOXR0Tjl2d29CTkdpSkx0Ny9J?=
 =?utf-8?B?c2ZwUjNkMEFOTjV5UXZ0RmpCY0dDU2IwYitROWlSUmhSU25Lb2ozblluZWJj?=
 =?utf-8?B?OUNXN2ZXRXdrbWl1WjkwMTFuQ3lOTmVBWk51aDhhWnlPaGdaL3loVzlETVIw?=
 =?utf-8?B?V3hwN0x5QkhkbStZNFhrSmFlcFdOYytLTHBYdzFWMHlwVG1SVjdLRkVNZDI5?=
 =?utf-8?B?azE4RDlyQWszV3I4QXU4Y0w1ZktWNm9acGxkYjdKeWZMSVdYK3FBSFRveTdz?=
 =?utf-8?B?cHpuUFZSQWd3ckhETFJPSXdPZndnMmRMdGtaeXJxaHhwV2NuckRzRUpZbEFj?=
 =?utf-8?B?N2NMTUJ6Vi9Kd2VGUkFMVHVQMXkvUWtzTnAvSjkvUzVKSnAwdGZBbFptZzhn?=
 =?utf-8?B?NDJGUkRCdjFFd1htOGFpTkY1WW1OMzJLeUNIMWNUTVQ2NVRVM3Y0cWpLOHlP?=
 =?utf-8?B?Y0c5ekw4MjNaU0RJd2JkRTBoZnk4YnBSa253WkswNysvdGJBb0pTaUF4dEZU?=
 =?utf-8?B?TnZoZC9EZjFBcWRYVkRYUmEyZ2lxRStoVTRXQi9WaExlYUJrYkhtSEZwVEFR?=
 =?utf-8?B?em10eklNUjJnemx0WXRueWh0QWk2UGRNVEw5bDB2QWR0NldJQTRtdlVkOU0x?=
 =?utf-8?B?TnFrMDcvTFNWSVFYYUhaV2dONFlQKytjTHhwVWo4NjlnZHRFRnhTN243MEZl?=
 =?utf-8?B?TS9JWDI0MGNLMVVock1VbS9rcmc5OHVtblVieXNJMlcxYmRSck12ZyswNzBt?=
 =?utf-8?B?QlpNcFZxTnFObEVDVVVIc2doVEIyM3JpWllTZzZLR25mYTlwZ1hSU3RhRHM3?=
 =?utf-8?B?Q2xyN05pd0ZKOC9SWW40MzFiaHBnUTZMYStGMzh5bytLWHlpT090TlNhVGk1?=
 =?utf-8?B?RWdxeGVUNEpJMTBFUzBtNml2UEQ5K3ZuSDRFZUNCRUYrV2dXL1hZT2wrRnZ6?=
 =?utf-8?B?cCs0cHhvK3M1VGFvd2pTanI1bHRsYU1mTzVDM29kbXU5MUdITGtSK2dBaGZH?=
 =?utf-8?B?UWk3Q2VuUnNSU3RXY3RMSFE3SU00Ty9YWFo0MzN0YzEyYm9CYkwyTDN6bGpG?=
 =?utf-8?B?a25CVnJOMEJ4V0dzY0FabjhCeDcvQjYwbVc2L0RDdmI5eEFhMDdSVUxtMEhl?=
 =?utf-8?B?cmFFMTJVTEthK2xlaCt1N2F6NVFrTzJVNjNzSnJ0OG1vbWVUWkhacXlwYnpD?=
 =?utf-8?B?SEV1dzAwSWp2U1FNelRlTktWalZIb0pDSE4vWUFsK2JCN3AwV3JMeVdqb0ZU?=
 =?utf-8?B?V1d0aHl2eE9vZ2tYMThFWlJFRFR6d0g3dC91bWkwYitNS2NWT3llaWFTQzV0?=
 =?utf-8?B?NXdKQjFCTlN0NjFPM1VOZkh6UElsbTVVWWQzQXYzWHd5cys0YUg3cXczR2FH?=
 =?utf-8?B?ZnZLcDAxdlhjZFJkQTNhdlNwL0dYTWovUlNLZWVCZ3BxaUdZdmsyZmU4RGxD?=
 =?utf-8?B?Zld4T0dFbFk0cFpZNmYzdkJXbTVROWNiQmhmeitRTXRLSytVaWFYckk1bEVG?=
 =?utf-8?B?S0pRN1FGbWhINDFDQWo5N3dzQ25nR2RHZ3lGVDRPUk5sd2VjVi9qcDhGTk83?=
 =?utf-8?B?UGs0SzY0cGZ6dEpud0dtVk9jNXhPT21qajBveFV2SCs2dnE2STM3OCswVmU3?=
 =?utf-8?B?aEkxbjVPdyswam9aZURZMmY3bUNialZIT0FMSHhTN2R2ZW5zd1RTRUVibHNo?=
 =?utf-8?B?UkVjNHlQbmpCUW1COGNhZ0kxdndCcG9VSnp5ZHdXdENUaFlGS05DSUQ5am1K?=
 =?utf-8?B?SGVvUjIzQUx2UXJYbjExVlBoV2I0ajF6enlFTEU4Z1dZcWdKM2lvZXVibHZ6?=
 =?utf-8?B?amJ1RWtodEtGam1GdytDN2xsRXh5aFVvYmxHUkcwZjdWcDBDRUF5aUl5TkpV?=
 =?utf-8?B?ZldZS3UwV0h2cjE4UlpOUFI3azBRcEIwdW1Ic3RzS3NtZUkwQXgyNlM0RDQ2?=
 =?utf-8?B?L01qbDI1a3hWelRZc0k1MGloTlY4bDVsVWVYbmxxMmQ4YVR2SUpXS2lHZG5t?=
 =?utf-8?Q?wgImaFt/K0weDgGp0fji6+a+c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b67f492-05e1-42cc-5246-08dcbb514ff0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:08.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpE0DHpRdAYbnLMq/uzvgQ9WjWY+peAQ8R4/hYcBSDv5/TAW97NOv4niVk1yFArixvBENDKnd2s4Ky9HStN8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (17):
      arm64: dts: imx8-ss-img: remove undocument slot for jpeg
      arm64: dts: fsl-ls1043a: move "fsl,ls1043a-qdma" ahead "fsl,ls1021a-qdma"
      arm64: dts: fsl-ls1088a: rename gpio admin_led_lower to admin-led-lower-hog
      arm64: dts: imx8mm-venice: rename rs485_en as rs485-en-hog
      arm64: dts: imx8mm-phygate: rename uart4_rs485_en to uart4-rs485-en-hog
      arm64: dts: layerscape: remove undocument big-endian in watchdog
      arm64: dts: fsl-ls1012a-frdm: move clock-sc16is7xx under root node
      arm64: dts: fsl-ls1046a-qds: rename mdio-mux-emi to mdio-mux-emi@54
      arm64: dts: fsl-ls1028: add missed supply for wm8904
      arm64: dts: imx8mm-venice-gw7902(3): add #address-cells for gsc@20
      arm64: dts: fsl-lx2160a-tqmlx2160a: change "vcc" to "vdd" for hub*
      arm64: dts: imx8mp-venice: add vddl and vana for sensor@10
      arm64: dts: fsl-ls1088a-ten64: change to low case hex value
      arm64: dts: s32v234: remove fallback compatible string arm,cortex-a9-gic
      arm64: dts: imx93-tqma9352-mba93xxla: rename hub to usb
      arm64: dts: imx8mm-beacon-kit: add DVDD-supply and DOVDD-supply
      arm64: dts: imx8mm-beacon-kit: reorder reg-names cec and edid of hdmi@3d

 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts       | 12 ++++++------
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi           |  1 -
 .../dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts | 12 ++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi           |  3 +--
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts        |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts      |  6 +++---
 .../dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts   |  4 ++--
 arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi           |  2 --
 .../boot/dts/freescale/imx8mm-beacon-baseboard.dtsi      | 16 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts      |  4 ++--
 .../freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso    |  2 +-
 .../freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso    |  2 +-
 .../dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso    | 16 ++++++++++++++++
 .../dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso |  2 +-
 .../dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso     |  4 ++--
 .../dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso     |  4 ++--
 .../dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso    | 16 ++++++++++++++++
 .../dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso |  2 +-
 .../dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso     |  4 ++--
 .../dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso     |  4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts   |  2 ++
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts   |  2 ++
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts   |  2 ++
 .../boot/dts/freescale/imx8mn-beacon-baseboard.dtsi      | 16 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts      |  4 ++--
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts   |  2 ++
 .../boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso  | 16 ++++++++++++++++
 .../boot/dts/freescale/imx93-tqma9352-mba93xxca.dts      |  2 +-
 .../boot/dts/freescale/imx93-tqma9352-mba93xxla.dts      |  2 +-
 arch/arm64/boot/dts/freescale/s32v234.dtsi               |  2 +-
 30 files changed, 132 insertions(+), 36 deletions(-)
---
base-commit: 6dd6ca44177f8413f10dbf63b17acbca99beae7d
change-id: 20240812-imx_warning-7bad8223a128

Best regards,
---
Frank Li <Frank.Li@nxp.com>


