Return-Path: <linux-kernel+bounces-339404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9C19864BB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455941C21337
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A4E47A76;
	Wed, 25 Sep 2024 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HCNGIVo8"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D81BC2A;
	Wed, 25 Sep 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281487; cv=fail; b=sC0ia4iPgO/p2pQqkNn510u0SL2FwYXlD3zsphzJYw4VmifEAbsaWVb/rOt2QpuxfGv30P5s+wfzVxmYOD+74TEKbZz9HlS9Nw2/FK5MfIyhz9e9kHm8K+8YAodIw1JfFTkNEiehY8swfOpFxY1lopysFcbnxMAmUS69isc53YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281487; c=relaxed/simple;
	bh=dVq4tlwcZxz3jlJuhTHCLp+4DkiDy2KflnIkt2boXPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gaPenO9HLw3TRBtHKMHuN+4nGOLc1F0+4pB2DD9PM6M1k5iPmHgRByGePHm/WtWCGWxxHbKVLwAuN+Vm9Me1yXyBAytGCDb7arUOFC2aji/JGELR7vCEtZDIbseuknIuS2sVk6ZjI9WwMCNSnwV2n+ikQXEd1sRR+rme9xnbdgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HCNGIVo8; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCz0Ht88VgC9MUAGHNyHARGX24xggAJKQwasD/vhiuD9G5QqNJTEjEVgMuXgSwo/HOz6hdr6CwVQMXrrtIgNGhqFZUMKwqcTBZ//EU5VFvkRJbnLkrvtBJPvkPV7RwR/JsAdXYsHV27GrRFTBadtCkv5K2WvBuf+MkGAert+rBHEbWuE+lpHVh0p6lMEQMfOMTwoeLZlrIJe1CF4i7j6FEFMkzLVrTn4VrPynntf3pDofom5LoSt5Ze+zXc923Xrr766dtc7PdL0+Y0O7lRuYTkJZjXrLe9FW/iEOgS9r54DXik6OBnh41Q9OqVMT4xsKIHaW+SQq6/rQHi/7nk2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgmDOI4PgVKHfR3t3IUFS9VOU8uZrgj93rzND9VlwfE=;
 b=WrXdvdSys7d2QFcJiMCktK8aKchB/JSiS711qlisRI0nFshb0r5KSCw+ANBY1ryRBr3ldNVrzHkIfnbaAY1KaasR4v2a9zI0l2co2Da3BRqh/umN8ENG8PnkzRHwMQ3zvxRFAZ9lgLYe4rAGEeeHWJ6mIl6Hw3Gye2VikoUZNjrMBHqde+Xp8zyLTN0v146T0Hug6Gq59Mzq7F1lrMNGZdQpV5VohlaI3Y7zQzwYXm16Pt7R28KkzBXDojULAH5s/GQ5glEqcL8YaJCMKWrlCzwYayYMrE2YTPCTzGCZCQR03kUJK0UlvlR3m4U+A/6gpcLXeUvnOH7crvFiVccYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgmDOI4PgVKHfR3t3IUFS9VOU8uZrgj93rzND9VlwfE=;
 b=HCNGIVo8grZyX3UXSV05+/6vJjYDbIGzWQIgSJtRPBPs7HF3lE7yEiDCsrouunzBYcDJQvoF/2SEg905iIaFpXwL7VC4F7KgLAiXLNScqvb9FC+AROMh5wlbpoe8mp9nxW+otJqIo1+ZGkYE2m0Yxg5qkrwT9kVSmaCV0Fb5TxUM/QcMyezrOIdbzeAjL2QrvtuKKoQ+RBlPLwH5mEtYI+bIjZcWRYdXbiW3k4W2u7PvpOy9H52Q13hx7/mBs1W9KaiEbszGWLL97e13UyXG8OAQlY9oWPJiQOZTbifuYS88QApVdmARDnneIc8uykkPF+IL1+VnG/aoOwbAKdFK/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10866.eurprd04.prod.outlook.com (2603:10a6:102:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 16:24:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 16:24:37 +0000
Date: Wed, 25 Sep 2024 12:24:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Walle <mwalle@kernel.org>, devicetree@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Petr Benes <petr.benes@ysoft.com>, linux-usb@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] arm64: dts: imx: Add imx8mp-iota2-lumpy board
Message-ID: <ZvQ5O553E0QFvced@lizhi-Precision-Tower-5810>
References: <20240924103941.1729061-1-michal.vokac@ysoft.com>
 <20240924103941.1729061-3-michal.vokac@ysoft.com>
 <ZvLXenqG/++AR4We@lizhi-Precision-Tower-5810>
 <20240924173714.qxxkhn6wscze7q5n@pengutronix.de>
 <87980643-44b4-4df9-9eb7-1583b5074bdd@ysoft.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87980643-44b4-4df9-9eb7-1583b5074bdd@ysoft.com>
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10866:EE_
X-MS-Office365-Filtering-Correlation-Id: 504cb938-fb26-42a4-d139-08dcdd7e8cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ty9GMERwRmduaDYxNXVISzNneHc3OGpmWW12NUF0bDl5c21HWkhQZXNTQU1h?=
 =?utf-8?B?Ly9vSW8yTXVocURUMFpPRk1Icm5jUng3aFRHRjBJQTVUMFlPdWdDNHY1dDhp?=
 =?utf-8?B?THhkTzAreXkySTNxUWJCbCs1QXY0eHJ2enBuUVE3aWlhY2N3eHdJMyt1UHV5?=
 =?utf-8?B?REdGeUMzRUdmREw4ZHlJQ2VUQW5HZGVPencrSDNsR1djTk10VExHOGNHNitP?=
 =?utf-8?B?elp0d0haOThkSVJXVU5EU1Y4cnZpdEcyK1FwQUVFdDVBeUxWcVZmMVhUN0di?=
 =?utf-8?B?YW8wYlFJemFCMXU1Mm9YT21kOUZSRHBPR2hBb3ZqbmNUbmUvcHlJWlJqWnNF?=
 =?utf-8?B?U1VrRFlKdFdaQkNEMUpzTHdKc2phT0R2alFIR3Rja0p6N01YbFBGTDdiUEEy?=
 =?utf-8?B?UC9zcmJPQ2VDdm9UWWl6ZjJ1b0Z2VGZjNHBxU3hwV3laK21uSURmV1JLM1JU?=
 =?utf-8?B?a2hFZXQ2RjhxMGVYTE92YjZONkhYT21LUjNIMUw1Qkhvb2d5RUFmOEhaWTdx?=
 =?utf-8?B?Nkd2Wlo2ek84ODdjcGF6VVBMSVpCTVhVSlUyVjA5a3FwQWVld2hXVzVKOGZX?=
 =?utf-8?B?SGhEdlJVZ3h6d0FJL1RBSHJsMzVleEU1ZU8weG1XakJScHJHWElKZUdMY0Qz?=
 =?utf-8?B?YWlsRzl0eGk5dVllWHlqLzU5WkVnMExKTTVSUDhENlJuWExIYzRkVDV5TmYz?=
 =?utf-8?B?OUpjRWIyOThxdk5Ha1lWdzg4NVhBM0FJQW15bFFJUHFiRVh4S0FXRFcvQUty?=
 =?utf-8?B?ZUhvWmdkcWlPSnNKTE9ibTF3eld2T2hGMVJkc09nUTVTN0hsUUJtMFQ3VTJJ?=
 =?utf-8?B?bjRHaUZhMkcxOXNEa1Y1MGltQzc1bGw2Z3YzK1k2RmN3eVc4d0g2R096WmF1?=
 =?utf-8?B?QkJrMmpoMnJNV0NDYUdUQUMwc2RmaEFqd2FNRDdiMGJsSnJMVDgrUTB4b3Fp?=
 =?utf-8?B?Q2pDTzV0eUJxc01mOGJPVFk4SFF1angranJTUE9wTTk4akRMYW1xdy9Nck44?=
 =?utf-8?B?K2RnV0VSa0ZGcWEwTWQ4c3U2MHZTenRLZFBGVTRMWENZMnhlUzZpc2NBMjZq?=
 =?utf-8?B?cTloVHZ5UmZ2NkRqWEIwSk1ydi9oUWdRbmJReWFBVytkSG1qZkN6MEN6dFVX?=
 =?utf-8?B?QW9WZkRkVVZPL044dk14TGowNWt1Y2laOHk3UlAxZHdURDZ6Z0pURnpDREVT?=
 =?utf-8?B?N3JlK0VGUXhwSy9KZFdoUWtJbm03T2NBZDdyaW80eFd4cW5sWWNobU5Ia3Jq?=
 =?utf-8?B?V2tRbXR5T2F1bmpiYXpWVWZabzdqQ3g3UmQ3ZjhucEU4aE9NM0NEeUhmcVpa?=
 =?utf-8?B?cHJzZTlkd01kNDNpeG43aUw5dVJKZkNRVzBuNUVaczE1dEhBNm45NDY3QUlJ?=
 =?utf-8?B?SzFMZkVPdnhaeFZmQStXZWtkSjJQSGJ6MHdjNXA1Slc3d1hnSHlGMGJzY0dy?=
 =?utf-8?B?REJCb28vRkFwVFNXdEo2U2wzZ2NHTG4zYUYwUUkvWUF0eG5jZEpzbTB2YTFO?=
 =?utf-8?B?Z09QNjhXaDdoZXdkSUszdUdUT3F3WUgyN0pldFJGWEtHSXhDdUdkTjNvTzdw?=
 =?utf-8?B?TjAyck0wMzFyUkFid0xCOW9sMmlHam5XcmQyTmlVYTFZOTBPRDdlUlMwUkhh?=
 =?utf-8?B?WEE1MEt4UGJLc0xleTdQeWhVZHVDZ1AzVUYzREUyOHpEbkplaCtNMHRQdWJZ?=
 =?utf-8?B?VXhKVnlveFQ2NkNYTEJ2cjcyWkE3cWRXNU42bWl0WEhTVDRMNVBjc01abTg3?=
 =?utf-8?B?NWxIZ3JvSUI2U1NzTVJDa1RIbVEyR1AySW4xUFovQnlub0wrZWJOeW5SelVN?=
 =?utf-8?B?M2sxckVVY05xWDVwbFBtUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1lmN1pwMVJiM2l4VXR0czJzSGRkOE1NSVJpekFBWThnclkyRGpPbFh2cjRZ?=
 =?utf-8?B?WmVxclEvU2VuTDFTTkF0YytYT3hjT3ZDdXAvUHZaZ3dHQ3lBYUFra1AyZlQw?=
 =?utf-8?B?ei9HSlA0T3ozL2F5NW9MT2wyZUN2QUVjeXhwU0tUaG5iOFlTYkhjcFJhYnRC?=
 =?utf-8?B?QmJUaHQxRlB6TkdGM0pzTVkwckVNWTI2dElsTWRWWWxGdnRLUVV2WCs5dU5E?=
 =?utf-8?B?M3A3Z28wUGJCOGpSaUM2T0lxMHhPMkljMGM0NnVYV1lCM0VBZ0EvdFlxRjR5?=
 =?utf-8?B?R0tiQkE5TXlEMmFiRXNzd0k0TGd0U2lOYi94VVA3Smcwb2J6SzYzc2NNZW82?=
 =?utf-8?B?c2dvakFIQVdCN09VZnFjaUJ5Ukc3R28ySG1Hck5aRlM0eVJMYnJreHkvaGdo?=
 =?utf-8?B?dUVzWkF0ZldxMmlDd1UwaU9yQyswTlloWkJGUkE3VFY2eFRVMnljRlFVT2NZ?=
 =?utf-8?B?YTJ2RWVldS84WllTRG9JWTd1R29xdENNYUtJSXhKUi9XV1J5Vit5Rm5ESW1r?=
 =?utf-8?B?RDFlRHY1TEdJSVJnOGd2ZHhRS1NzOHVtKy9hYldrcEsySElTdmZVVXIxOEpT?=
 =?utf-8?B?bnNvYSszRFlrRXEwKzVEeXR0anJCRWRFRXQ3Z05EVU9nWlhkN3RoVm9JaGda?=
 =?utf-8?B?QW1KMTQ3OC9WQXpVRUowM05EcDNmd09OUlB0Y3d6Rzh0UGtkVURGOCtoWkIy?=
 =?utf-8?B?aURERUVkd3FVbDJiaDd1dTkveXVENmEvdkptZzJTQ3lYMkhQU1A3ZkJiWWw3?=
 =?utf-8?B?TXJTdlhOZVFsVUVGekg2YzcyT2FvVWtqME5mSDFxODY1NERnUDA5dVpBWExR?=
 =?utf-8?B?azMwRzEzL3hIdHYyRFlldHh6Y0J4UjBJTjEvWU9KRml1aGlTUXRYdU9vZ01j?=
 =?utf-8?B?cFIxaEg1L055TzdINTNScVlmT0dYaGRWWXcyZjJMZUp2NzdEcmREa0lZL3NF?=
 =?utf-8?B?K285REVocTJ0Ty9wU1hHWEE2Z0lndmVFcVFaRDFtZVNqYU5SbFVPTUNUWC8w?=
 =?utf-8?B?QkxKck1jU2grUHp3d3JpbW0zZlVTMzFhWWV4YWE5b2tXMHFFL2RvRVA2MFE0?=
 =?utf-8?B?REJURWgwOEdiZXJHd1FFNG5mN2VpcDdaZE9BUWgvTW1LMTc5Si9KazhXUWxp?=
 =?utf-8?B?elE4TCtpWElLa1N1VDFpN25xOXdEbkhCNjhPTzliaWNsRGk0amM0b3VyYytD?=
 =?utf-8?B?UGtxbytacXNkMkRVVHd1UW1sVzV1Z0tyc0ZXdk9DSmJ0NjBMdlIwZkg2eWNN?=
 =?utf-8?B?STEvQjZaWmluMzJoYW5kUTlBazJUL3hkZVZnZUpTdndTbXY4MjFIRlRiR3VS?=
 =?utf-8?B?MXNibTF4Uy9ZdVFsdWw1Sjl5c2Yveno1cUlGMlQ5Z3d2SjRkUEcySFhvN0J6?=
 =?utf-8?B?WWliMks3alFHYncrTlZiamt4VThhMXdMQkZ2am84K3VCejQrNW0vQjFNN0tr?=
 =?utf-8?B?ZDJ4b0V4SE9qUGMvQ3FIS1ZPM1hJYTF2M3VrSVJ4WUVHV2NtaW5pUU1DL2h2?=
 =?utf-8?B?NE5DQnEyRHNvcXdZTWVvaFpwNDZiN29sZ05hU3h4aXBmYTBoVlhTQVJBZ1Nj?=
 =?utf-8?B?STg4RzA2bUVrZUVYWjRxMXpMWWR1V3lmSDlGR1dqbTdnQjhZNFFQQ29VQmV1?=
 =?utf-8?B?cGZVdEU3MkFpSlEvdlRORGRyYjdsL3h6dmVpOUFTeWNaUmdVcVRmMjNUSTVx?=
 =?utf-8?B?OXI2dFRFQ04vWUhvRmR2b2QzZzc2L3RaUGJjd3FHL2NqamxwR0NRZkpZZ2hZ?=
 =?utf-8?B?c0FNdnhKLytJV3VvdE0rcFB6dm5TcHF2ckZtMEhDTDZKOTNMTmVsaCtndEpH?=
 =?utf-8?B?bXJDK2txNXVkMy9PODRGU3BaejhwNlhadC9OakJtQnB4a1F3VEQvdTg5Wi8v?=
 =?utf-8?B?aTFzaElTc3ZhT2hBeUFBSExHT0hpeEtydXRjYU9qdlFIVndjVkppSkMzcnhG?=
 =?utf-8?B?TnkvZEtVbnJkem5Ob3hJZnd1QmJoSytyRzhaUW12dFAyWllZb2NyNk9YZFVK?=
 =?utf-8?B?YzlRTmtUMG1VT25CUEk3bWJpeXZ2eGJpR2txVkw5QUJmUmtiTTBPd3FTMXk0?=
 =?utf-8?B?WStRS2hKWS94bCtPUC9YOGhDN0MxNmN6TFB1M0QxSnlzMmQ5STlyTW9ZWjE4?=
 =?utf-8?Q?Caq4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504cb938-fb26-42a4-d139-08dcdd7e8cc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 16:24:37.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G51GK6btqokQ+oZViKrVxDd3jY1IK+/P7F74kNAwJIJ1NO6tySXyFjQk/ltZoFGVpt3z7xFmgHU4W6BKmm5AhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10866

On Wed, Sep 25, 2024 at 01:30:31PM +0200, Michal Vokáč wrote:
> On 24. 09. 24 19:37, Marco Felsch wrote:
> > Hi Frank,
> >
> > On 24-09-24, Frank Li wrote:
> > > On Tue, Sep 24, 2024 at 12:39:41PM +0200, Michal Vokáč wrote:
> > > > The IOTA2 Lumpy board is based on the i.MX8MPlus EVK.
> > > >
> > > > Basic features are:
> > > > - 4GB LPDDR4
> > > > - 64GB eMMC
> > > > - 2x 1GB Ethernet
> > > > - USB 3.0 Type-C dual role port, without power delivery
> > > > - USB 3.0 Type-A host port
> > > > - RGB LED - PWM driven
> > > > - speaker - PWM driven
> > > > - RTC with super capacitor backup
> > > >
> > > > Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> > > > ---
> > > > v4:
> > > > - Moved the iomuxc node to the end of the file.
> > > > - Moved the bus-width and non-removeable properties below
> > > >    the pinctrl-* properties in &usdhc3 node.
> > > > - Moved the fsl,ext-reset-output below the pinctrl-* properties
> > > >    in &wdog1 node.
> > > > v3:
> > > > - Dropped pinctrl-names property from &usb_dwc3_1 node.
> > > > v2:
> > > > - Dropped unused property from pwm4 node.
> > > > - Sorted all nodes and properties using dt-format tool from Frank.
> > > >
> > > >   arch/arm64/boot/dts/freescale/Makefile        |   1 +
> > > >   .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 423 ++++++++++++++++++
> > >
> > > Suggest use https://github.com/lznuaa/dt-format
> > > sort node. any issue, let me know.
> >
> > Thanks for the link :) would be nice to have this script to be part of
> > the kernel.

It depend on how much people like and use it.

>> The script follows the rules in [1] I'm just used to have
> > common properties like pinctrl-* in front of the device specific
> > properties e.g. "enable-active-high". But this rule is not part of [1]
> > so I can't blame the script.

I just write it. Not 100% align order-of-properties-in-device-node yet.
Some propertiy need special treated. Thank you provide the feedback.

I push change, enable-active-high and gpio will after regulator*.

Frank

> >
> > Regards,
> >    Marco
> >
> > [1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
>
> Thank you for the review Frank & Marco.
> I quickly went through the file again and found another few properties
> that could be better ordered according to the kernel documentation [1].
>
> > > >   2 files changed, 424 insertions(+)
> > > >   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > > index 9d3df8b218a2..aa26a50b7bb4 100644
> > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > @@ -171,6 +171,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
> > > >   dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
> > > >   dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> > > >   dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
> > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
> > > >   dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
> > > >   dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
> > > >   dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> > > > new file mode 100644
> > > > index 000000000000..9eb58e818dc7
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> > > > @@ -0,0 +1,423 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright 2023 Y Soft
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "imx8mp.dtsi"
> > > > +
> > > > +/ {
> > > > +	compatible = "ysoft,imx8mp-iota2-lumpy", "fsl,imx8mp";
> > > > +	model = "Y Soft i.MX8MPlus IOTA2 Lumpy board";
> > > > +
> > > > +	beeper {
> > > > +		compatible = "pwm-beeper";
> > > > +		pwms = <&pwm4 0 500000 0>;
> > > > +	};
> > > > +
> > > > +	chosen {
> > > > +		stdout-path = &uart2;
> > > > +	};
> > > > +
> > > > +	gpio_keys: gpio-keys {
> > > > +		compatible = "gpio-keys";
> > > > +		pinctrl-0 = <&pinctrl_gpio_keys>;
> > > > +		pinctrl-names = "default";
> > > > +
> > > > +		button-reset {
> > > > +			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> > > > +			label = "Factory RESET";
> > > > +			linux,code = <BTN_0>;
> > > > +		};
> > > > +	};
> > > > +
> > > > +	reg_usb_host: regulator-usb-host {
> > > > +		compatible = "regulator-fixed";
> > > > +		enable-active-high;
> > > > +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
>
> The enable-active-high and gpio should go bellow regulator-*.
>
> > > > +		pinctrl-0 = <&pinctrl_usb_host_vbus>;
> > > > +		pinctrl-names = "default";
> > > > +		regulator-max-microvolt = <5000000>;
> > > > +		regulator-min-microvolt = <5000000>;
> > > > +		regulator-name = "usb-host";
> > > > +	};
> > > > +
> > > > +	memory@40000000 {
> > > > +		reg = <0x0 0x40000000 0 0x80000000>,
> > > > +		      <0x1 0x00000000 0 0x80000000>;
> > > > +		device_type = "memory";
> > > > +	};
> > > > +};
> > > > +
> > > > +&A53_0 {
> > > > +	cpu-supply = <&reg_arm>;
> > > > +};
> > > > +
> > > > +&A53_1 {
> > > > +	cpu-supply = <&reg_arm>;
> > > > +};
> > > > +
> > > > +&A53_2 {
> > > > +	cpu-supply = <&reg_arm>;
> > > > +};
> > > > +
> > > > +&A53_3 {
> > > > +	cpu-supply = <&reg_arm>;
> > > > +};
> > > > +
> > > > +&eqos {
> > > > +	phy-handle = <&ethphy0>;
> > > > +	phy-mode = "rgmii-id";
> > > > +	pinctrl-0 = <&pinctrl_eqos>;
> > > > +	pinctrl-names = "default";
> > > > +	status = "okay";
> > > > +
> > > > +	mdio {
> > > > +		compatible = "snps,dwmac-mdio";
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +
> > > > +		ethphy0: ethernet-phy@0 {
> > > > +			reg = <0>;
> > > > +			interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> > > > +			interrupt-parent = <&gpio3>;
> > > > +			micrel,led-mode = <0>;
>
> The micrel,* is a vendor specific property. It should go bellow the reset-*.
>
> > > > +			pinctrl-0 = <&pinctrl_ethphy0>;
> > > > +			pinctrl-names = "default";
> > > > +			reset-assert-us = <1000>;
> > > > +			reset-deassert-us = <1000>;
> > > > +			reset-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> > > > +		};
> > > > +	};
> > > > +};
> > > > +
> > > > +&fec {
> > > > +	fsl,magic-packet;
> > > > +	phy-handle = <&ethphy1>;
> > > > +	phy-mode = "rgmii-id";
> > > > +	pinctrl-0 = <&pinctrl_fec>;
> > > > +	pinctrl-names = "default";
> > > > +	status = "okay";
> > > > +
> > > > +	mdio {
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +
> > > > +		ethphy1: ethernet-phy@0 {
> > > > +			reg = <0>;
> > > > +			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> > > > +			interrupt-parent = <&gpio3>;
> > > > +			micrel,led-mode = <0>;
>
> Same as above, micrel,* should go bellow common properties.
> I will send a v5 with these fixed.
>
> Michal
>
> > > > +			pinctrl-0 = <&pinctrl_ethphy1>;
> > > > +			pinctrl-names = "default";
> > > > +			reset-assert-us = <1000>;
> > > > +			reset-deassert-us = <1000>;
> > > > +			reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
> > > > +		};
> > > > +	};
> > > > +};
> > > > +

