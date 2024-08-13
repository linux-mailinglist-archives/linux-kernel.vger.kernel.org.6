Return-Path: <linux-kernel+bounces-284097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A682B94FCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214651F25B78
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D472557F;
	Tue, 13 Aug 2024 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iIbLcxZ3"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D949658;
	Tue, 13 Aug 2024 04:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523750; cv=fail; b=ryPMf3xIR4T8JtCcoll1y9tnTc4d91BWaaOwTvkRmf7LdmYbvTGBCIOzyC6VEsUn0NkpmrYjiTr0Wh8znAQq/ikEHOjAHkmkIHXuQuUk+R0zIL9sq1mjecEJ6lVG6buHTIUJ4yrv/imgbfavuA3sjF4Q8YOEfbqNXaDVi/ib3hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523750; c=relaxed/simple;
	bh=zyAVJdDN8Bd6gaEgaZOPaF3XGa9bXyZ1khkk1g9k2iQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sxSlrHaKiEL15WVBloxxsa3e3w8LWu6bWOPyebxlUXSU3IbTIekyubdBgd8ajSDnW6UzHGgWn7ZlULVzKitlXBxVXSTJPn76SL+YH/PluQzBBq+3sbqWGpMPcnwwvyI01VGQ6rnbYH03kWzKA7MXNFqVPMc5XIDPKIKIANMTdaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iIbLcxZ3; arc=fail smtp.client-ip=40.107.249.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWsdb0VXVSwvNtUYeNK7K8hfr4zYXd0sW/RsCRylF3eoggXqoTFie5jV53/jFrVyc4qwd9Nx3gDICBb46wdsCemMZbY6vDv6oyEtKJHn+19sdo8VAf0UCSaF2/GftZ16W+vVBRv1VFuA4E+9gQSHN1sTCngqZrBKBwJvWiJ57MTx1Op+W7sT4BsVO4QOHwLuQQSNfkf747Bit2Ai/elA3mMA/qVRw7RmndcZyDue3hvHDfWUpwa4mr6Hrlw76v/IrtJW3jKf5JRRhFfGmCfF/h0P4mJqiaH9qQNXdwx34ZB6NWdfEZ+FtCtepWkapc048t+sVAzVFPrrszB1dQWFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr+0ebNyDnqLuA46OrRehy8AcUHO++Xfwy52+dM0DGc=;
 b=WyLfrUvE2SDuU/7jKzdb4+j+nIiG+L83UL1JlN6c7zGZbp3uxfBzxs+VnFyv02HybMc0823zjpYGovCglUm19bmSE8HMH8gT5U7mYDY3+jF50MEaIvrJLHEouWEYefz9HPAYx5hgu9rwg2l6QmouyyQ0CAMcD7QW95JSYrx32YWf49ussPq+oIpcKlMLRA8joKh7FoaAA5kjTt/WhBbipWkuBjsnbFqmWdbkHvNDONmg8DxeLlgLVI+iHxWSptUlHSfE3H3jCAF1RPkN3Rf2Uz1QcFYBBfUDE+DhFNXno0elWg09/i/NvG08mMvnkNpKkQodyXnLdDKC5O2szYMm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr+0ebNyDnqLuA46OrRehy8AcUHO++Xfwy52+dM0DGc=;
 b=iIbLcxZ3T7v72JMf9GKLKH8ZhBtqmiIsmyWQE3SZZxgI0jYLyLPTfrMZq6j3Dx4JD+K9qrc71+CtfzAqP/SLXg/hnxD8n3UgjrRgiJ7jmV8JzCROYzpWP1dC34pFlirkg0o2LQ2iuHvf6YZCbgdcocndYeq8BaKV5TX2zlx5+cbsdH1xF71m0qnZ6BsyAFxhq6hY/T0OMqwRFuVH4wW2cSTa23pz+HUsqq6tfopew/rZVQPVZfcAmHGqGOCWmoRL4ikX92aNVYsC7c5q9LUrdK3OPoeHMZJlixlSoTg7XZc1XIQ9wXAD8N7HLPfjcuDuwy2Euu/tRjFewgTbZh7ocQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:05 -0400
Subject: [PATCH 10/17] arm64: dts: imx8mm-venice-gw7902(3): add
 #address-cells for gsc@20
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-10-3494426aea09@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=2622;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zyAVJdDN8Bd6gaEgaZOPaF3XGa9bXyZ1khkk1g9k2iQ=;
 b=ee4al1+oM5iSfHWQvo9abriSqunRcNqWt9LiUTwa2LwAn0gzW+NK5uwxNRHfjsOomgahf3fCG
 +l3J3mey8W8BGIRyBQ9MwF+37CQ0iATomeR6HimxlOV4Ote8EbgcOLl
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
X-MS-Office365-Filtering-Correlation-Id: f6b8fe82-6aa4-4c34-bf1f-08dcbb516652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0lheVcwN0M1eTJvVEJ5VmZ3WFA4dSs3VTZUSmxrSE9YUFNyNTY3bVFZVVJk?=
 =?utf-8?B?bXllSUUxR1F5RHY1MWhMVkMrbDA1akVyekluckJpN05jdEVtOXZGZEpONjRJ?=
 =?utf-8?B?Y3NSTm56UjRZcFU4ak10eHdXOXU5aWgzOUtRNjBHc0RRckR1VTdCdXpOd0ZH?=
 =?utf-8?B?bkFVR3IvNkNWeXB6cVUxdEJwTTI2VnE5OFV5VFZBQU1xWDNKSWJlVU5GTzJt?=
 =?utf-8?B?cnVJSnVvZzJ4Z29XSHVJMlB5OVZkbmg4SkNxWCtMd0JTMnNWWVpYRzdIT0Fo?=
 =?utf-8?B?ZitxVUEyanJTQjk0WlcxTlJ1V25sZGVuekxBVFpDaGtNVHR2UlY3U3dzbVdl?=
 =?utf-8?B?RE8vL0VGUTlJUHF1STI2azNXSUNUY1pmdnlqbS9ETWtDeUM1THRzWCt5NkNv?=
 =?utf-8?B?OVQ0Wml5bXlMZUlRUS9LVUFmend1eWYyMjNMV1hXWUNPd0x2c1VxZ0pkVWpL?=
 =?utf-8?B?VkpPak1UejNTVUwwOU5hb2dZSnNUdWl3b3pvbDhJVE1KVU50SW1zUmh0QWQ1?=
 =?utf-8?B?ZFpwdWQ1dTh3aGFqb1F3KzhjcjhITHdpdE45RTFIY1Zoc2xhYjcrVUdEaW4z?=
 =?utf-8?B?aTI5d1pzOGVSSmpvNThRMmF2Qk12L2tXd1IrQWpxUE42V0tYOTU0Y1QxUUU1?=
 =?utf-8?B?YkFJOWNwQ1RaSE4zQVpJcUljb1pKNDRRSlkrMUwrTThRMG9NeG8rUHh2NG9j?=
 =?utf-8?B?Z0c3a3lxdkhpSi9UbG91OGRFaGJMZnRXS0NCM1FwS3Y3MUY2Q1EyVEo3bEpP?=
 =?utf-8?B?eWdlZkdQSUxxV1N0WTdOOGpBTUhsN1ZxTW5wemUxOGM2dEFsK3N2S2hzTFpJ?=
 =?utf-8?B?Z2p2U1VGTEFVSkY0UThLR1A2dTVndU5OK0FaNU9HRkdsaFB3d2RyVGRCSkNY?=
 =?utf-8?B?ZEFCYmZVdlgyajFhSGtXVHFjL0o1N2dsN0JTaG5qRU5IWW4raHIzcHJ1OGtP?=
 =?utf-8?B?N0h6cm1qbkQ3YmRFRHl4U3cyS2hnaXhyallnZHNyWUVQd1RZRXNRbW9ac0xq?=
 =?utf-8?B?eXkwdS83bEJvM3NGeWh6SVJwQmlVT21Rb1VnUEcyR1A2dHkwUzhqN2FOcUo5?=
 =?utf-8?B?LzFPc1dUcUU2OE1ZR3NBQnRlcTdFVzRxa0hhNC8wV1NnblJPallOYnl6R2xn?=
 =?utf-8?B?OENma21saHExL0tDM3JjSlpzVXhFUkdPckxDY3R3d01hUnI3aXY4bnNNVExi?=
 =?utf-8?B?bDI2N3FuVGtsSElxOXJZNFlmV3Y2eTQyMUw4SS9lV05PVmVQTUpaOEJUM1VV?=
 =?utf-8?B?ZkxYMHVjOWZiOUEyZHR4ZWUwZHhoNmRWbGtISWJmSjd0aysvUVlLK0hWZFFT?=
 =?utf-8?B?MkNTUktYZWRFNExyNHltOGc0L01iRzBSK05TSXErYkRvcEI1bDlrbVFsL2JU?=
 =?utf-8?B?a24rU1RKVHl6VEdEZ1I2S2dwSXpZamN3VHRkaGVqOVNpc3VIWE4vV3owQjdI?=
 =?utf-8?B?bDNOaWtpdzg2RnVWbkYrSldaRVIwQlo1UERyVEI5VVZ4ZFlvWU45cjZ0cGlX?=
 =?utf-8?B?Z2JrYXhDNmlTcXROeVdUL3dhbTBCeUtVdTNCVW96MnJLbDE4YzF0RW1MSDRZ?=
 =?utf-8?B?MUR0bnh6SUF3amJOd1JON2pScjUvSThFNzFpNldlM3drSDJMUTY0Nm5WMXho?=
 =?utf-8?B?QmNMbGpkZmc0WUMwSnVEWVBYOUlydmhDa3BJZXFiMkJwMEIrM0VkRi8yRGNU?=
 =?utf-8?B?RHFnYjMrcmdhcmpHOEFaSy9uSjF2ekVGUXNMRVEwTGdwWkNhS0dzcXpEQUVQ?=
 =?utf-8?B?K3hTdWpBWlo4clZKUnozVVlRb01XSUpmR1JzcVJxQml1ZGRLM1pDVlNrWldz?=
 =?utf-8?B?RGlBdTVlOGZIODhRQjYzaEROMmg4aENjZGZuYzBMYlpMVDZTSm1oOHJMVmVX?=
 =?utf-8?B?Tm1rM0o3d1JCcFVPTmU5UU9uNTVReUorUUZqZ0FwV0lMT2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1orOThNeHcwQzdpZHJGdmxJUEx1bXhtelhnNE04R05uU0w4TmN1RlNGNXhC?=
 =?utf-8?B?TVJRdE9jMUhQaWszUlVkT2RLaDVnTlh0YmUzWTVqVUhKcm9zL0JkZVAvZ2JJ?=
 =?utf-8?B?YVh4cVZ5amRaNnNvSXJnM0hYSmh1dEMrT1lFVjA1R2N0L0xrV3Nqa05hUWZU?=
 =?utf-8?B?WlMwb3JGVHp6N1dzbGFycFN5Q0dLdk4wb2phamxPM1kzNllhOFQwQ0Iwait0?=
 =?utf-8?B?ZzJZNnNWc2QxMGJWZklkRHVMSUFaYmN6YXM3UG8rdHJ1NWN0WGZqaE1hdlhH?=
 =?utf-8?B?bFoxL2lnaW9TRVE5bkZvWndPNnNQOGs4MkF5S2I4WnRQR1FSOTZsdUJXN3Bm?=
 =?utf-8?B?aGl1dG5tTDBqallnNllkUTQwaFZBak55TWFMdzBjbVREWnZpTFZ3TE9mY1ll?=
 =?utf-8?B?UlVlelNBa0EwUzF2L2hGWXlweVQ3aWRudC9ROHNTSVVRMkdyOTl2R0t0TUF4?=
 =?utf-8?B?aFBOK3p4SGZqS0p6R3M5Q2Z1WGZtTkJtYmNjMDJOTjVLNDkzaEpoVDhvYi9t?=
 =?utf-8?B?Q1lNbmhRZHltV081WHVwbGlTVlF3WXhYd1VjeGE4d0dCN3ZVTXBGUjB6K0Ri?=
 =?utf-8?B?ekFreE1zRFdCNXBhaXpib0J2VTZpK0J5SmRKcDdwZE9Ud000WE54amdRZ092?=
 =?utf-8?B?NXFSempxZ3hOMHBnUHVDV0t2dnNCTUhtRlFOb1NPTnZHU1lHM2Ntdk1SZVU0?=
 =?utf-8?B?N1gyOGRDZS83WldyeFQvTEFWM1BOTjllQmNQTzIweDBQY2VHbm02YmFFVzQz?=
 =?utf-8?B?QVBsYUt3RWJHdHpnU1FQQWVuVDNwSHNySE5KTUdnRnZpMUYraWVMNm1taDhF?=
 =?utf-8?B?U1RGKy9rc3lBS0xBRWVJZGdPT1VXNEd3VHlObFUvQ3FsU1hGeG1RS1pPRTBJ?=
 =?utf-8?B?SGc5eWtjUXQ4MDRsZWZ1UitOS1hsN28ydzhSNkUvWVdTcTZVYk5mK0J5SlBY?=
 =?utf-8?B?ZFdrNzMyYjBGVFRwc2ZKNW1aYTFpQktaS08xQkRxTm5WWjNWUGxWS04wNW1w?=
 =?utf-8?B?YmZkQVNSTkc5T25NS1JRQk9qVmJHaGlSQ1dPRjdBNnJRZWdwcmZKMkRINm95?=
 =?utf-8?B?VWdpMDRpNi9xSVl1QmdMaXFGTU1KWlIwRnNVbHlDcVB4L0tNbWoxZE55UnRW?=
 =?utf-8?B?WEt6Myt5eEU0d2RicnB1ZG5RaXBUa1d1SUxCeHlvZExWT2NMWlo3dWR5Uzhq?=
 =?utf-8?B?ZDd4N2lDZ1N1VDdjQ2FXYlMvYjJaZEhsRWtWdTE3N2VOMExVemNyZXhWZ2tR?=
 =?utf-8?B?eitaWXh0aDU0N0s4a0lUSjNEaDc5dUhuN2FnVzlTM2Uva0svVVZjZnA0R3U5?=
 =?utf-8?B?WG5pWGFmeFArR29UWXQzc2ZUS3paTExIVTI1aVNtMTBYT1lSWFdjeUpJRkJo?=
 =?utf-8?B?SThhT0hBZERyZnpBbk1PajhpaDAvckY1SzdnOXNzaFhRakVnYi9zc1RXTWRx?=
 =?utf-8?B?REZKUDRFUjVDanczbnJVM1BXVWZEa2FWeFZ2cFRwZE1iaTZBbXFwNXBxdjRE?=
 =?utf-8?B?OVJzd3NkUmRkazFiWEJIMHhadWhQVHBuVmEzcTBzeGhybHM5VEJMaUw2Z3Fl?=
 =?utf-8?B?enovaXNFdmwzZkQzanNZOXFCTS9tY0J2akplVFQxelgxMWVLQW16V2QyYzJm?=
 =?utf-8?B?RHowenJHMzVJTlJSdVcyVDBSMW0vbExYVVBLUTNyUzd0WnFLNjUrTzNWRENs?=
 =?utf-8?B?NGxUczM1RE0vakJqQ3l3UklvSFdyS0ZqRWVvdUhXL2ZGbHVndWpCVTVLT2M3?=
 =?utf-8?B?bFVzL3FPczBXUFEwdzFUVXhJVXVyWitJNE83VC9TdDNVN2c5U2xtcmN5WXpm?=
 =?utf-8?B?MEV0QXpCekxldU5Xd1oxMkV6OXp4d0JZMndvbUhIeFBwNFErZjE0VjhKY2tU?=
 =?utf-8?B?anYxUWV4L3dwcFM3dTlhUTc0bnZNeFlpVTdsdll0UDVjWW03VWtoWjJEOWU2?=
 =?utf-8?B?UklkUUp0UXRBa0ZvT0YwVzB4cG43OCt5Q0ZQUjFhNFpyTzBVVzYxbWNQZU83?=
 =?utf-8?B?UUZIQzI1cXpzU3BCZFhGRURpbGtqODZncm83T1V6c2tpT2gwOWw5ZVlDSURP?=
 =?utf-8?B?dXphSzM4dm1hdDdRNkZJbElYZ1lqVThjaXd2cnJwaXRDZURHdkhEQ3U2VGNy?=
 =?utf-8?Q?Sv19tBX0pyymsmv9/ycYtOpU6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b8fe82-6aa4-4c34-bf1f-08dcbb516652
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:46.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMwX6c6lc26rlw0xCzz1rsMThFi+/L6JkMbKtFdx39P4ybjQbe2Cfj8CKlXOxMMmUp9SMsC3NP0DF6c5BRj8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Add #address-cells and #size-cells for gsc@20 node to fix below warning:
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb:
	gsc@20: '#address-cells' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 2 ++
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts | 2 ++
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts | 2 ++
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 1d56f2a6c06a5..c11260c26d0b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -314,6 +314,8 @@ gsc: gsc@20 {
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
index 45470160f98f5..db1737bf637df 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
@@ -280,6 +280,8 @@ gsc: gsc@20 {
 		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
index ef951bc9f0dd4..05489a31e7fd8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
@@ -330,6 +330,8 @@ gsc: gsc@20 {
 		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 72004ab6bda55..0b1fa04f1d678 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -312,6 +312,8 @@ gsc: gsc@20 {
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";

-- 
2.34.1


