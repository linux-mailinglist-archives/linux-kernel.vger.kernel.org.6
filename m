Return-Path: <linux-kernel+bounces-260046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA793A216
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747951C22623
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7C153810;
	Tue, 23 Jul 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N3tfdbfT"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324B15099C;
	Tue, 23 Jul 2024 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743008; cv=fail; b=ATug1Q4b0BEIfFPqxVqTgp46wtfbpUWbYhTKSJUMyEDYgNaA6dI4z18B7lDqKe7rxqtMoc6jECS5Jb3I1MNoiITOHjULNXLG0PKnXEgyKta3EMIbYyrSB4x7DIn9fkEAsMU9SZGAqn79VOOaj90dRsSijGb4ltkowXk1MPmatZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743008; c=relaxed/simple;
	bh=20/djNjOSG+p686R+mo666CfgDpoOeTouSa6uYLOM+I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bl+WPkNyVlAcYrRLDG6sSPG6B/xf3wE3EhIxn0aa1LA9B6NDSYEBJZw6ylBBavvEKVsyT6dTykZbJa+Jm39miIJDsEkWQvfM8uf1fdRxgYFXm9neYAYxSHaeaJcSHfDDGbPZA3tE1lh3ulAiA+VMfEEj1aVw7FYdCgOSd76I5c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=N3tfdbfT; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6ov6bFBzi3SPQ6GCyvBt/gcZGGjQTGrS18r7Kheud7Wnz7Xt/cBgFOlORCffs8x+YjOeC/ixyGWZiSwYVRmuMLzXpF5iV/mue9kHf10rGuo24LwcLFz07N1k15lNCEljHVW+ghCJQyY9YB3BN9/4RkC5erXWbeKJCYFMMOVjCh1yqMajic4aKyZA5gsFsp8nc3bskwK1QuYJUwiB7yrJG7/yFBs9bZG5Zj7UawfR5l57CktbwlZxdW5HeDSrJ17LKHfZlqzoH8isYTLdJWbTqZXeK7dwMu23u4MFK01HgKQVzZrzPu761a81PT3oKszvIJaFEnvmUHBiYSGSAxAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVA8geJotX+g2RihaKvclY/9L1qrWDPk45B+UCRrlBc=;
 b=L4s7K1jXpHjyrt0eK5en4ja0t3n0cbzVl8r6RO4+I6Ok5ac7AQZQZdBM+RY+4W3L/hgjYy6feimsEAXUdW0h8T8VBo6B80N7KJEElu9qmxherL4yd9MFFuIE/acB4yU41ND0FcIyKepnpIraot3WT7ce8+gholpY589EGbDiOSFlmYm/cJYaVp49MFaGC7nloCQJkRVA9B3NpEkEzhR7kZm7PHTkZ/ovEpsz0cAOBdsZ5XYf5VSzQtwogudB0iLZ4HMjJXBfuWGmQ/z3CdvIvu77T1b5d3OKxh+Ve/1P9UEUfOrdiTCtSoikBDaNCeOLjX3zgLHAiFKq8VUse0X5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVA8geJotX+g2RihaKvclY/9L1qrWDPk45B+UCRrlBc=;
 b=N3tfdbfT4J1Eu9SSMLJ5+oUjSspsMVkv2ns/mbc35kIdjTZYTlBrvdjbci4ING2mjWCJY1lMAb3PtprX/JZbT803vJJNVXwkd0TL4ssl+hTu3nUQtwlJAq9Lf1QKrLtO8svIDszQE0x+PmFoZ1b8G1aJc487zW1zjBlTscM/yBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by DBBPR04MB7611.eurprd04.prod.outlook.com (2603:10a6:10:1f4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 13:56:43 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::6d7a:8d2:f020:455]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::6d7a:8d2:f020:455%5]) with mapi id 15.20.7784.013; Tue, 23 Jul 2024
 13:56:42 +0000
Message-ID: <87c53abf-080e-4e70-b5e2-b38ef9443983@oss.nxp.com>
Date: Tue, 23 Jul 2024 16:56:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: s32g: add the pinctrl node
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux Team <s32@nxp.com>
References: <20240723123720.1088067-1-andrei.stefanescu@oss.nxp.com>
 <b4985dc2-73e5-4917-9015-f891938c8880@kernel.org>
Content-Language: en-US
From: Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>
In-Reply-To: <b4985dc2-73e5-4917-9015-f891938c8880@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::11) To AM9PR04MB8487.eurprd04.prod.outlook.com
 (2603:10a6:20b:41a::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8487:EE_|DBBPR04MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ee00b9-d3f6-4f89-1503-08dcab1f479c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTJyY25CdU1OanlaY1FsS2VpMnlGRHJUMXBqaWRyZlRKTlBKS1JYSVdoamd6?=
 =?utf-8?B?ZW5acmtMV2d5eXh3OS9JQlIxMHB6MEFVTUpaY0RsYkpiUVVyVEhDTUdMd0VB?=
 =?utf-8?B?TkwwTVRsNFUvTVpqdWlqeW1DSEkxQVByazJvWExucFRZTmJ3Z1JRajIvYnFY?=
 =?utf-8?B?aDJKOGdYeDlVMVJ5anhhWUxZS0trRHJBOTJZeE96VUN1dVJUQ2ZsdnNIUUx1?=
 =?utf-8?B?dy9GeFBDLzM3UXpiUmw3VVN0cnpXazRFQlYxWkNDN0JZRTN0ZVNKZktGYXZE?=
 =?utf-8?B?cUtsaCszbTc5YU93QzA3Y2x6TmNUb1pFZ3lLd244QVVRdWNNRE5VajRiV2g1?=
 =?utf-8?B?VXY4OVdWdnh6WXU0RTJPSDByRVpYM2Z6bUhPWDNlMC8xaGZZcnlyOGFReG4x?=
 =?utf-8?B?enFzQ0ZDbEhpdC9TZVhMV0JPeWkrYi9rVnBrMGFDYUc2U1BhM1h3WVJCMmpn?=
 =?utf-8?B?eXl4VXJBekg4U1BTUlN0T0MrcjRRcmRoV1dmdldHQlN5T1p3cW5jZktzcVkv?=
 =?utf-8?B?VHhvanZCQXVHOVplbDVNaVBvekRnSUYya3JhQ1QwUGNQbjJVZmJUK25YMG15?=
 =?utf-8?B?ODJYR1VFNFBWN3dFblprdVY0NjJJVG1pTEw2aWsvYVRkNlA1NVgxZGRKdkFO?=
 =?utf-8?B?ZEd3bExEanQvVGd1RzhpWnVvczlSVllRdTMwaWhuWlJSK3lLMVoxcDltVWxu?=
 =?utf-8?B?NkM4amJxNGcxUHh6cTVxdkJ5ZXdsVzdacUg4R0pNYVl6VXNlWnlTR0Q3Ukpl?=
 =?utf-8?B?bXYzZFNjVnByM1U5bEhIbHFoVDhVcnM4WG5TZzIyMWV3TFp0MGt4ZzZVV2NG?=
 =?utf-8?B?ZFFxR0MzT21lamVLUHA2MUREWFZXR0c4NVFHL2RwNnhEUDE0eWtrNkZCQ1ll?=
 =?utf-8?B?NGhuYS9FMGVjSFpLRzF2cmQ0R0F4T2FyMWhNOVRxZmpUUzYwS2xkNGpXdVNX?=
 =?utf-8?B?Vml5VW5KWURUK1BkR1NvUlJWUXlrUXpCRStCNnFyU0J4UUh0N3ZYT0YrTEgr?=
 =?utf-8?B?TlVSSlVqdnFiWDNSMllCS0lMc1VOby94TVZ5WUJjdy8vQThQVUpMT0NpU0JE?=
 =?utf-8?B?S0xhdmxjNE5UbTRVNElLMDlrSnIybzc3bHpZOFg0M09EcDJDaVhCdjdRVDVQ?=
 =?utf-8?B?T2hEVVRFZkV4Z08xbVZIL0tUV3BnVGlxTzZoQ29UdVlpVEd5N2w1aS9ESy9m?=
 =?utf-8?B?WDAwSDJWMEtmUVhFSDVVd3EvYXY3VXdETi94aHFwMHBKYisyS3VCMGRudEhX?=
 =?utf-8?B?NFV2aUFlVVFBdEx0R0U1N0NUbUloQ3dTZkYyOE5DT2ZBVHVDNUxOKzVJci9N?=
 =?utf-8?B?MDBBbStUdGlsejlOZUIxWGVMS1FIN3UvRDVTSktjTVBwME5WUmFhdHc0WEg4?=
 =?utf-8?B?V0hadktQZURTQWFZUnhoQnZIOGdJM0JHamxJbG90T3lHeWxSUWNuRjRwT0Rr?=
 =?utf-8?B?Yy9LaUhoUVQ1UG5wV1VVMGlFQnNlbTBCNUR5WDZKRTZDeTRsbDZpcW05LzFx?=
 =?utf-8?B?S0g0K1FFeGZkQWt6QmVPQlZXaElPcThTTzNpT2FJalErYS9UdUo4WTBLT0ND?=
 =?utf-8?B?Z000SWxNa010UTZrS2xBRFNYdGI0eDhnaG4wR0NRZWZxc2Q2QmZEWHlaTFhK?=
 =?utf-8?B?b2dnNHhPb2VtUi9rVUs5bjIzR3VsOFlpNEVvVnhQcmtCclZlYzNRcVIwUjlC?=
 =?utf-8?B?TGpQT0hJR2xueTlUMUgrRUNUTlhneEozdWI0dVJMVlZhR0g3MVlRYXVwRldS?=
 =?utf-8?B?MHJiaW85RC9qMEVHaFE3Szg0aU5xbHM3aXVsSmQ5NEZEOXBtbzc1dzZrbC95?=
 =?utf-8?B?QlJ5QWQrYnhLYXQrSldKcFZGREpwcXFmbGo0TmVEaFZPakpMZ0FNVTNWR0l1?=
 =?utf-8?Q?ta93qqiDHB0BH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8487.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWRYMVlJZXd0d3pMS2NmNmx6TGRRVTlrY1FER0hJbkFHQXl5bHUrckFjUzA2?=
 =?utf-8?B?UGlONDJaNE15U2xRaGdyRVM3d1UrY0VveE55bmoyamJ1U2tXeFpzWVpQZXAy?=
 =?utf-8?B?cDRBY0xPZStLLzMvVU1hSW0xUVhyUS9KRWVXSm5KS296TkVYTmR4N0lyMjM4?=
 =?utf-8?B?RFVDbE9yb0hxWm5oNllQaStjL1dtT0VHNW9MSlNpYnNYMXVsdzVEVlF4QTY2?=
 =?utf-8?B?K3h5a3lQQVVaaXhtQlpYWU5XY2xaei8zVkRyS1NjdkVFUDMvRFVvWndJSnVO?=
 =?utf-8?B?OHZKVHdNa3lwR2pBMnRMQjFLNUVBSWE1U2ZTR0IycFVjSUZmanR1V21QdHpS?=
 =?utf-8?B?YjRzTUdGbVhpWEFFWXVTeks2TTFKUnJ1UmpCc3lXVzJRa1hPN2VycS9xUy9D?=
 =?utf-8?B?dUQ1elNIZzBab2o2TTBuQW8xTTF4bWw3eVZFSGpSb1FpWFBPNDRHeGtUUlZr?=
 =?utf-8?B?VHlrNk1JNEtFZCtQN1RqZWN4MmRvb1VIYmd5T2VMUVJMencreWU1RDN6NnBB?=
 =?utf-8?B?TmI3RWEyWmRwdzhzVVd2S0xvS2p0MzBFdlhEUkNSV1BGK1dJckdtMDNia1Rl?=
 =?utf-8?B?R1puUzI2UHdGZlBrK01NUnJKT2ZWcWIvSnd4dzFFRXRTQll1amUvNHl1SFp1?=
 =?utf-8?B?MGpnQXg1NWVqeisvcE5Xc2pQODFYRlRkK054ZkFydGRJREticHdDZ3AwUVVU?=
 =?utf-8?B?ajJRZVh5SEVpcm5UbkNueXpETmdhZW1xYTRLR2VUMUpxbURlazNDSU1ZNDlX?=
 =?utf-8?B?c0hLamJLQlJwUGV0dHVRbHpOck8rVXdoSjk5ZzN2YjR2VEdZRVUrTXdDdWQx?=
 =?utf-8?B?Q0R6aFQzRzNjRXlTOGc0dmFpZGtQdlp2UnI1R1NOeW93NWdmUDVFMzBnY0VY?=
 =?utf-8?B?TkdMNUMwcWo1M2ZaeTlZRHR6V0FXWEhQUzFBK1N2Uis2TnJKbWllNkxRU0No?=
 =?utf-8?B?UEtQWDBScVJ1L0FxbDJDZjE5ZEtRU3Y3RXgrWUl4Y1J0YTc0SFRkODRQYjR4?=
 =?utf-8?B?NVhZN1ZFa0hQUnNyOUZkZy9GUDY5UDRaK21WZmg2MGxhL0c1ZTg3d1B3dm9x?=
 =?utf-8?B?WnhNdjNQenF0eE9OTjZUMEVCdnJ2QnR5UmovdDVyczNrRTNVejBKbFdobEVm?=
 =?utf-8?B?YWdVbC9LMUZkY21kSlR2SXZ4RW5vTm9RQmdiRWpXdTc5cWpOMGFXWG1ucGw3?=
 =?utf-8?B?czJuVHVNc1Y4SzZ0dk5zWSsrWVpLSHNOdFk5MGt1NGp5L01NZWsxbWNLNlRs?=
 =?utf-8?B?YURFYk1yTkRZOXY2eDhrSjRidHFudUNMV1lHTFRxV2FUOUo1ZWxHMHFDVWZH?=
 =?utf-8?B?TVVYT3h6c0UvRjJGeFU3ZkRpakJLVFVxaXpRRFNLVnNPdk42RGR2alpXbkxq?=
 =?utf-8?B?MVNtem0yMDdGZUxMWnNKdEJPTGg3M3dJeStKZFR0bDRpSFBnZHJjbVdDNTd2?=
 =?utf-8?B?MTFKOGx5V2J1SkE2WHFyOFl3QUIwanpCN0cwUUQwWU9HMW1NZHdrY0dHeHFz?=
 =?utf-8?B?Vkp6bkd0RUkvT1lFNUp2NVpwa3ZiMXJ4ZG1EQ29pcDdkVWdwMDRaUFllOUxW?=
 =?utf-8?B?aTV5azJmcGxXZnJuZ0RsVFd1VkI0cGt1MUd6MXA0YXdwV3NEUzVXdVN2UlJR?=
 =?utf-8?B?bWFmOCtRdHJvZFJHL0VxSWMxQTNqbDlzeTd1ZjZ6LzdtUzRKNklySldkaHRm?=
 =?utf-8?B?MHF0OVkxZm5URVBuQUN6aytqQTZPZmJXT1RKVFEzSjdBOEtLZnRiNElyelp2?=
 =?utf-8?B?TzdqRXgvNDBHR1N6YUViNUJYUmVLZmRWcVJXL0tGVnk0UjJSdkN4d3hJMDk5?=
 =?utf-8?B?ZEQxdHBMMzc3bEFkTDZMK2dPbm1RMk9FdDg4NTA5TUxMSHAxT29SZ0NFUzJv?=
 =?utf-8?B?b2s3dGxTMGFxRlpwajVjRk1LMFRFTERreG5BSWh1OXNCRzlTLzVPVzBwK2V3?=
 =?utf-8?B?QmtEcHJaOThVcjQ1QTFUQkdPV3E1eThITzBHang0UDMrVyt5aVhQV0wwQTJC?=
 =?utf-8?B?NE9ucWVjaVdFNHI0eHVIbTAyZ0JhMktDbmRPSXFWQjNINGN0SVhsWGZxRUI3?=
 =?utf-8?B?K1NLbU1pQURQMkJ6MDI5MzRvZk04YkNXQ0JjOEhoYSt5NUsyUWhWa2piSFRQ?=
 =?utf-8?B?VFBWVG9iV2JzaGdkclQzaTdGNUhuNktadjFwaEVKbFZya0VrRzdLS01LamhG?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ee00b9-d3f6-4f89-1503-08dcab1f479c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 13:56:42.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15LDJEuVGWL/BKU4eacJpU08D6AVchBG60X4u66aW2To2nzYu/Kif9JMy48coNXS+xypMwvOrbLd9FFKyHpQ9YEq5FukiDwBtrUIf8+mVSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7611

Hi Krzysztof,

Thank you for the prompt review!

On 23/07/2024 16:38, Krzysztof Kozlowski wrote:
> On 23/07/2024 14:37, Andrei Stefanescu wrote:
>> +			status = "okay";
> 
> Where did you disable it?

It isn't disabled anywhere. I thought we should always have it enabled since most of the
other drivers will rely on it. Should I add it here disabled and enable it in the
board specific .dts files (in this case: s32g399a-rdb3.dts, s32g274a-rdb2.dts and
s32g274a-evb.dts)?

> 
>> +
>> +			jtag_pins: jtag_pins {
> 
> Underscores are not allowed. Please follow DTS coding style. The
> mainline one, not NXP coding style. Several other places here have also
> issues, so be sure you read if carefully.

Thank you! I will send a V2 with  "jtag_pins: jtag-pins {" and
all the other subnodes renamed to "jtag-grp*".


> 
>>  	timer {
> 
> Best regards,
> Krzysztof
> 

Best regards,
Andrei

