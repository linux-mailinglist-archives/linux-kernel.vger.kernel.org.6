Return-Path: <linux-kernel+bounces-379070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CF99AD93C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCCC281E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9810274068;
	Thu, 24 Oct 2024 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kWs15jBi"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB550285;
	Thu, 24 Oct 2024 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733356; cv=fail; b=gavRDqLIWRBv6EtjbhePZkdINI6ZwAiuQQu9tC/F5w92R7srRCFGIRWwWXAr6lcf0c5CXF8kP25qOkpT2MpJjd0kTxO6J/qy3mv0322VPh0Dn7pzvODdbS26KIFrbjh803SbQU2oq70T4/qEaYdzvXss+5CiPE66TgLCaNhvDy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733356; c=relaxed/simple;
	bh=4HlHseHeUoJtlPnBp98veK19343bHtBdrgpN4fmVp8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G7iASWZv0IgYZn9GJ/Xj0D+1Qe2wx6uR+IGwU/q4HE2rkPq+ROgfHFhfbWtiUPJCQBeGL+ZaYYup2Vr9zLCwG9xAz+6CP1P+nzVL98QsyAXibTXXDhOu7+771miyLGBAB1tgCEQbPvh5KtdKflhOXsorI2ZuLOuGotKgkPlLULQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kWs15jBi; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/bTlZrWO1bPXjpgLE494IVFot/624kxMoB28pi/8mK0iLOOg0f3BO3TjUrObgHZFj7bhvRer0bLaOx2hsDoYVtjSGM6kMqw4ORLTXMYmRBH/dwalXJyuvU1Z3iS3SGXFe9Aie1EgtBDEMEI+P5a7nC6DdO6qdmF+/Vdj9MPoWZpIkzkQ57wHdaZr4Aazp6okUN/xtvg727e2LkTDrcx9kwX2Yk7D1JPJWUvs+RIe0QQ5uV+DJpubNmFvp86qwwDhqBqxOMDuXZ7G3QJxXVlg4ASEE5kSIgOK8RD6gu3Tw4YX7ePX5y5V6dr59yTo+Ok/7X7iwzYxY9xm6gz6+p4tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nZU3p9jDFsE1cwlZ/01prinpvdwb5iD7o/F4a4CTfg=;
 b=WhZxoF2ZuaO3GMgBJq6ng5sozFK3GQwQ4O7qV+arq04ISmtFLYw7bNh24AjDKTfX8jPMXWDB+oPMljvx0q2ff4cU9Zq2GmcLcqsYWdQR6Pv3qcsDLNltBqcvWaUZWr+6qZP6KhMI8dF0Sru5k31Tv4fe9Kbf0g2DTRdEhBGVSxc7tUq3cXrZyepfuVWV6lpF50OvvciOS+4NHsmvathdSc7/dr/uGmU5W15bAO+KKOWbV+Euv1qsO3G/dx6XBNjrLcJAzzbxLRMYHK5UQ7ACfIJ0xpA7qt0eGJZ1sWz2afDhTBBdDm+4/RgDJZFaSBBJFJcDygbCqRgAS6Q55Bo9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nZU3p9jDFsE1cwlZ/01prinpvdwb5iD7o/F4a4CTfg=;
 b=kWs15jBiSR9PZ8bKqJmrlwvW9IKHp77UoxGY2YozxcalQ1W4gd6ThdV/HSHEgAAHJ5gRhZaeqhyLW9KTooso4C7yHdXvxrVoX7wzWmF7Csn0t1eC9YKkvGuC31qgCh+UtyTMiLV+pFwMV4t18aZvdhCOx2OVjgTo1uPOCTBOrqsthR3Lbrb7xFvQf61rTxML7IGpx0xNxW5QURSwFnEVQOnml3EsD1XhY6Pm1t290Lau/SKOXwqXfEl+GYn0BRk9gFpJJqSzn0vFfLZntf28q3oNfqUpZKdSyR4pgclQ1i2Kon9P0mdYJjExDM2fSSNHjVuD4ikrVyShUSvC0vI/Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7262.eurprd04.prod.outlook.com (2603:10a6:800:1ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 01:29:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Thu, 24 Oct 2024
 01:29:08 +0000
Date: Wed, 23 Oct 2024 21:29:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mn-bsh-smm-s2pro: remove undocument
 property 'clocks' for audio-codec@18
Message-ID: <Zxmi3Sb1IIua14Rq@lizhi-Precision-Tower-5810>
References: <20241023221112.1393280-1-Frank.Li@nxp.com>
 <CAOMZO5AL9nFHbcLe9HP8Rf99UBX-Pk76xc1zU8TaLgA1tgNH-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AL9nFHbcLe9HP8Rf99UBX-Pk76xc1zU8TaLgA1tgNH-g@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0083.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad068d2-403d-4a15-57f4-08dcf3cb4158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUZSNW5LZGFLeGYwTHJVbWhwcEdIdW9iWVVMaitiQ0NGT3R0Y09kWUVaeDZD?=
 =?utf-8?B?elU1V0FnSjNkZUFFS1ZCcDhjOTBiZ0dBNGtCMlZrazJBY2Y3bVY3cmZlNHN0?=
 =?utf-8?B?WTgvbHVFcFY5d0lWaC9idXB2cjA5MzU3T1NhaWlDQ0N3S3dGMEhMZVcraXNy?=
 =?utf-8?B?V3p4RWliL1o1SmVoeUxRVEpTUjRiRG1VaE0yVFhqZk55YkxVMW5BZTkzcFFr?=
 =?utf-8?B?OTc3eE9sMVV3UFJFYUdtT2NXL0lSZGJMNkFQVWxtVDdQNk1nRnpkZENGdVFW?=
 =?utf-8?B?Vkd1a3BVK2xPejZSS1ZiTTBmcWoyYzBLbmVITE9jaE5GU2twYTFpK1JzWW5o?=
 =?utf-8?B?Vk9acmNmSzc1WlZZYlh0RElWcGVFTldteHhQWElyUUZpUWRiU2tjaFM4RjFj?=
 =?utf-8?B?dmpiWGNVTFduemg2RXJaZTRLblVBWDBLam50SCs0cnZIcGkrMzFIS251YmhB?=
 =?utf-8?B?UERvSWdhbmJOUEQ1OHI4clZOUWFQVjF2d0RNNm9rMGRQTUl0OEx1U1J3cFRi?=
 =?utf-8?B?am5GcHB1bkZXKzdqcStPaEpUNTZpVEpPWU1JVFhoVW5vUThlTUUxY2taRGxi?=
 =?utf-8?B?N0Zsck5VVzdHZXNlRHF3TFVxRUxSMjFBaUNIWEZmV29Jc3plc3phZi82Z1Ey?=
 =?utf-8?B?eEF6dVQvVFpLQWxPZ2p3Mk0yMWRVM1Q3QlEzS0ppalp4NDZqZldDcGU0Y3Mw?=
 =?utf-8?B?YXhuU3F2dlpwMWlZeGNnSk5sUzZ4SnRXUG1uSXcrVVhHMlhwSVN6eGh6QVJE?=
 =?utf-8?B?ZitlZmVWcGR3Wk9VNFR1ZFF5WXZEVWJFZ01mRWV3RHovSHRkOHZUNFhlUURS?=
 =?utf-8?B?S0VsZTdHSmxQL0QzZG41WU5ad1pSMzB1SXhBQ2x1RXVkdGU5dGhtenhiL1Bs?=
 =?utf-8?B?ZnhWZDdoNjRmZHF5MEx1UnpIRzlrdHNveHI4S3RRWHQzSnZqaEx3ZXk5VnVp?=
 =?utf-8?B?YzVrK1lRTlc0azY0ejBDQ2JyZ3dyWS9yb3EzRnVmbDB0c3NaSlJvbDZWTy80?=
 =?utf-8?B?dVl1bEhxNGx3U0lVdGo3Sm9YeVp1bE91aXVOTUpJSDgyY0FSTjFLZ0dnT0x3?=
 =?utf-8?B?eUhRc2tFRmFLMzlabnlUL202dDE2azF0MXdBN3F5V2VhRmkvaWpxV3d1dmpY?=
 =?utf-8?B?VDRTSFNWU0RYZWVUMG5ZZ3RuRkxCK28xSVBHeDhsUWNvcHFzbFdlZ0JBd1VW?=
 =?utf-8?B?TVZaL0NCS2pTenNDTHlrM21oN3lXNGh4UllUZEJOaVdBSUVhKzhzWTVVRVNl?=
 =?utf-8?B?S1ZaVmVsLzBVMFVsaGFzcmNSYTcyUitSdWQ3cjYrS3ppbzdzR2FHNGZRbWJG?=
 =?utf-8?B?QUx4Nk1TWFJUS2VHTmhobmVmMFRTazF0UGRGcE9ydko3T0R4WWpFMEJTZUwr?=
 =?utf-8?B?Z2Z6SDFOL3Z3T3Zxb3Y1SXdzT1lsanZncGhJdzQ3VVVhOFk0QjN5R1dEbEpJ?=
 =?utf-8?B?WEszdFNBekV1aUlISWZwREx4WGp6RjBmcTFQaEMzSUtPODBIbXkzTnNvVjJ4?=
 =?utf-8?B?Q3pIUkR4MENFQzlCT1gxTHk1U1A3bTFIWjJoZFlCNko0NU44S3dxTzlZREVR?=
 =?utf-8?B?QzExVU1MOVhpdEFVOGJjcTNtZzFETmFiWEdTTS9ieEhiUURTYjd0TFRBN3do?=
 =?utf-8?B?cExFbEdWTzdJTHJBQ2JrV1U2MU01UkRjRzhDSlBienU4bVlBYUxaZE9QMEpr?=
 =?utf-8?B?aTJ1MDhIUklSQ2RiZm1BWE9xWEVRem9LQitZSkwrTXJnZUF6clJiU2pxdXNo?=
 =?utf-8?B?TEFRQlkyU2MzTkdsclRETmcyYllycno4L0diZHUySlNQZlRsVzBZbTdTTzlu?=
 =?utf-8?B?L0ZkTU05L1AwK080b3B3MzFORFdKdmp0MWJDU3pJTWRHVmZVYWl3MG5MVitO?=
 =?utf-8?Q?xGXOIKAQsM5Rb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnh2cmovaFlleEFPNWNCYlVtQUhlM040TENIdU9qRy9zUHpFOFBMUG1SUVBp?=
 =?utf-8?B?V0FmUkwvOVk3a3NxRE0vbUVQSEFnZGx3d1NiMEorTnQzWGFKZU9mdDJrNTEv?=
 =?utf-8?B?MGhvaXpXK3RJczlud0VqRUtERTJFNjRlbGhxWG5lTWh5ZWJxMlJ2UkY4YmR3?=
 =?utf-8?B?bWgvUDR4MnFPSHVQNE1ibFFpV2wzWGFKMXVrT1NkSGp5QzR3Qm5CblloZDdU?=
 =?utf-8?B?Uk9uQzcxS1dyM082cFR4WGxPeXNId0dRRzRjVURVY0JhL0dJN0VJVWtNQ0oz?=
 =?utf-8?B?M2ZFMDVLcjEzNGtreDM3ekxFRmRtMk5LSHQ3Mmx2blhVd3g5dzVIVEVzOGdj?=
 =?utf-8?B?ZFdBYWZhNlQ0cVRKVFBXSndJWS9vakZzTmhUcCttbGdtVXpkdlRRZVVrSlha?=
 =?utf-8?B?a2p2b3BXa2JrSmg5cUdSUGxTd0hvemFJcXFQRzlFMDVLaDkyN2d4NnllSWlT?=
 =?utf-8?B?QjFqOU94NUw5NHN0dTlNU0pRbjRhMWRQNlVQSjFrUytpUmtWUitPdDZTc1U2?=
 =?utf-8?B?MWtoM2tDbHJIQU85SFBtb0liSVZlcW5ZcmZ2eWdlbDQvazZvdkQrb09lSmpU?=
 =?utf-8?B?b0tlWUt5c1dUcFY1aC9QSjdjQ3B0aGpvUGJGMFYwellNWFYwdkQvMUFtMHJk?=
 =?utf-8?B?WllWby81UVRvRmdnY0tENlRlYTFKNnVjQXN3SlltOUZJRVFRZURsUkFkUFcv?=
 =?utf-8?B?WWp4cWc1ZUJuR01YSStvWUFudmdiRGhaMXdHcWgxVC9nNU12dVJvTzBNbEZQ?=
 =?utf-8?B?R2NhMG0vQUVqU0F1aXhpVTNGYWNGRjNOeEdySXhUUkZnUUN4L204cllkWEdX?=
 =?utf-8?B?WWpxUWNnRDEvWWZOaTZaSk9MWUdCYWQvSGFyL3htNUsrWGc0TVBXZlFDNHlO?=
 =?utf-8?B?QWxKY1JkWjlBdjNPTHcxUktzWWpqUFkzallUSXpSODVFVU1JbUZJQTdZd0wy?=
 =?utf-8?B?Z1A5enBmU215aEppR2dtMGZQV1hMbEoxNjV3Tm9HUklLNlJZU3dFSW96L3No?=
 =?utf-8?B?c1Y0dXM4UGw5a21ZYk0xNHk0Q1c0czM3a044SXhuMGlTTUZWMGtDT09DcGs2?=
 =?utf-8?B?akxDRVB3Z282WGdTTWd0RDZ5d3VZMW1BMU9yRUJKQlVJbXVJZS9WQXBGclB6?=
 =?utf-8?B?eGtXeGRWMGw1T3NYaVZjVkRnRWtrbUs5MFVPUTBFMzRmWVFnS3d2ZVFGZEx3?=
 =?utf-8?B?UUJCVEFzNENITTBnSk1wZVlPQTVheGdWdGQvSzNZTHpGdVdIZG9tYzFzWEIw?=
 =?utf-8?B?OUMyYTJNWWtublVEUVBoL3drWEtFU0FaQzhBWUhyT3RNKy9xOHhteEJySllK?=
 =?utf-8?B?N0Vod3h4Qk1MSyt4akJwQkNva3BMUW82NU5DY0ZxblF6YXBYTTVJMkoxSldo?=
 =?utf-8?B?T2d4R1d4ZDNQeVhSOTBsd3lGQ2lMY05KZ2ZkTWY0Rjhrc09DR3VTUlUzZHU2?=
 =?utf-8?B?MVpoTGtkWXl4Mmw5NUpMRGs5TURORi91RFN6ZEYwZFZrdElxZUk0d1NHRkYr?=
 =?utf-8?B?bUpzQk5hVnlrZ2Zhc2FRbFZCMGl3czBWeW5DZVRYeCtIZU9uUldEdFJaM0o4?=
 =?utf-8?B?UEFNcTNieFVQeWx3eG9BSE9uOXZNZTIxU3lOb1I5eTMxeHN5TVhsN3hjSGlL?=
 =?utf-8?B?aGRmUmNsZkp0R1JQWVA2VHhXN0dnVzBuUGdneTY0Y1BVTG5MU2N2dUNmTVdW?=
 =?utf-8?B?RUJxQ0I2R09SckxvaVUvSEhCQlBhQUcxVlgyNFoxWVYvS1BTK2NRY0JlUmtB?=
 =?utf-8?B?dWVyS29nQUh2MkhFMFd4cGYwUHpnZWYwblJzZytxbTg5b3ZxWEY3M2ZjRCtO?=
 =?utf-8?B?WVZxREx0RU9SdTJhSW9HRnJHMFdlR3M3bU5CODZRakFYQk4yNWlqK0xjb2R4?=
 =?utf-8?B?YlVsRkZHK3NlV3NhSUIzQlNPS2FSbVBadTBuNm9EV2VpY050QmRLYXhNakRm?=
 =?utf-8?B?MzhpV0xTdGN6RDZmZmcrdWlFTjYvSVB4alRxMmcyMDFKVFgrQUVWR2krVnhZ?=
 =?utf-8?B?LzYwYm9MTU56emE5TkUyZzhETW13aWZ4Um9zQjYrY0hCajhVMHRHdlhWSk9T?=
 =?utf-8?B?K1FyTWVJdUxkYUVicStPR1p3WVkxVjZ1T1dieDdzaC91SzhJV043WVJnU2h4?=
 =?utf-8?Q?F03Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad068d2-403d-4a15-57f4-08dcf3cb4158
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 01:29:08.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYB3kSj0rVH01gpALVPAAjYrPbyGcCeUNfM7799qYW9Lw7wIcJ0OQsZrqPk4Sl0dYG+zq0EA6wBqmtkP0MJh1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7262

On Wed, Oct 23, 2024 at 08:44:56PM -0300, Fabio Estevam wrote:
> Hi Frank,
>
> On Wed, Oct 23, 2024 at 7:11 PM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > Remove undocument property 'clocks' for audio-codec@18, which compatible
> > string is 'ti,tlv320dac3101'.
> >
> > Fix below CHECK_DTBS warning:
> >  audio-codec@18: Unevaluated properties are not allowed ('clocks' was unexpected)
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> I have already submitted this change:
>
> https://lore.kernel.org/linux-arm-kernel/CAOf5uwmg83-TVQvbNOCnzBh9JdQAC=5hpgbCeT-6qJ=+YBrssg@mail.gmail.com/
>

Thanks, next time please cc imx@lists.linux.dev.

Frank

> I am waiting for Michael to test it.

