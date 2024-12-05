Return-Path: <linux-kernel+bounces-432572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02D79E4D22
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D70166997
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE1E198A31;
	Thu,  5 Dec 2024 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Swo701cX"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349219340B;
	Thu,  5 Dec 2024 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733374622; cv=fail; b=HBeGdYA2Anzz9l6Skh9joj+1+2Fh0Zbx4G5bizpFZksJ99/sRmr8LGVEVhewMG8TkbMN3R3ka/md1PHS8s8C/ce7aqA8NrUy/AH2l9K7tX40vTQ84WaJKZRhLhxLE1ezY4A+eRrGipMkuj0n0sonNx++SBJqavEgmlZuOg2EbTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733374622; c=relaxed/simple;
	bh=Ez54fTGxK0UJvEeE0KUM0ZXtC/kA23RXzKM+yGCtlJ8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Py7J4+of7FCsvUrvuh5+IQ5yGTgf8RUmTqzf3tFlzIU3L5+4d6sj7nH6il9D/yg/AKKouVDFZekcXYa5VyyZcXg/ROHCbC3W9u06xSvCL4JV5TeIIs4SuLvJdDgJxIRufncDGO0enL+/3OrzGiiYey6/BT9DfF4QkvjV9QVxKGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Swo701cX; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXku5ux98dpg0LPF8sqpR4JrC2eSV0qx3tICfbwNGZrMmnOEOfwPeZehjktYQu3uTZCstgqLfgHCcMAUsd+BNvi6dTjb0ByW/O4KzAYCAwdIMWUq+SITGDp343zUxf2/w1cwS82oD1ynkJtXm3ijpH8M65VILF7CF7+wfVHbI1PYv45H/XFh7+c7JqSUTCpcMgC/LfMqxT3ZQUlJpGrXxOG8QP/0i7dmtoKfrIJQCcagvCOQYfs+RFPMdcSPPLU3R1wKtvrB18jwkPZkmWCWHVzQptSGxDCP1Y8ty6k5p668PWq7SwGme81mBehtt++23cpyClaSJ7Uzod2N2MtiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmcP9hWTFku5uAfCWQR/HdQ8iAHQWY06a9BHnSJO438=;
 b=g/NY5UFgU+9mcjUR2I8+gN1NfMXW2R/+oSJolzbtU9vPInVYzIDczUKrUkxopEK849Jojz26bNpPQnAaGZQHR6iJdInbO2kL6mVw+PMJ/dAmNj0jthw8PKyqjw7zKOo6diZIjPyJ8LvcvK+T+ye/triaDckQwEN+AHQaMSKoOej2Vq6v4tGD8g+U11rTOEohRN5rPHVpb2/9Cl8s2RpSQOW2HJQJ1nAvSf3nvcUPHK5ZecfQlMpMczxFOBF24jHZZusSI/BNaoHbhE8JPWaJha/CZSeKZfX51O7tQTytYRzf2gagabrgtU4ALiy7e5v3vQF8cmGVqBf5j4xsMEbk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmcP9hWTFku5uAfCWQR/HdQ8iAHQWY06a9BHnSJO438=;
 b=Swo701cXH+9CPSRXuCu8OzpT3moqy+S5i+FHDJG8STkl9A1uzrV0/zAf5nSZmSjgyHyrVwez2cd4ChYy6EGFHaYbLKbaO2Mj8JsmvsFUI915GDrr8WxhfYdQY0+MJf2H1MebTDsdkMifO7y5pA9His0ogUT/HBbYUbGtUo2zOpfM0CAovM3056+McNcQ2PEHJOBzaGq3b4eyZUIEkwxM1Iy4X1w60s/BDdchcUKrEFtkWL7LESm11kz4g2nt7SWIEnEtaMBD+LV26tZ3/CGAPTHoRaTEVvba58wdl2O+nmdiX3n/zmip2X5QaR5NtD8xBu9UHdVm+NtQMuiQGZjx3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by DB8PR04MB6794.eurprd04.prod.outlook.com (2603:10a6:10:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 04:56:54 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 04:56:53 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v4 0/4] firmware: imx: secvio: Add secvio support
Date: Thu, 05 Dec 2024 05:56:31 +0100
Message-Id: <20241205-secvio-v4-0-5c37cdc39573@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH8yUWcC/1WNSw6DIBBAr2JYFwMDRO2q92i6GHGsLPwEGmJjv
 HvRRNtmVm8y783CAnlHgV2zhXmKLrhxSKAvGbMdDk/irknMQIAWRpQ8kI1u5CXaFqFUaQxLx5O
 n1s176P5I3LnwGv1770a5bY+EFEaBMLksVAG65JJHrDuMeejQ93gb5im3Y8+2SoRfszqeR8kFr
 0RbE9RIDcK/pE5JSlGckkoSIRStpMpSo7/Suq4fivIiQgkBAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
 pankaj.gupta@nxp.com, daniel.baluta@nxp.com, silvano.dininno@nxp.com, 
 V.Sethi@nxp.com, meenakshi.aggarwal@nxp.com, 
 Vabhav Sharma <vabhav.sharma@nxp.com>, 
 Franck LENORMAND <franck.lenormand@nxp.com>, 
 Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Horia Geanta <horia.geanta@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9358:EE_|DB8PR04MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da9b2e6-d40c-476d-3978-08dd14e93c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEJvMU5ENklQRXZ2T0UrbHNUZU9WVjl4YnQ4QTZ2V3N1cEhwcmMyK0hvWWNS?=
 =?utf-8?B?T0tMa1BOWkJmdlNFZ0g4TFBMS2hqS3doSG14cEJUdExyRWw1Wnl1SUNiaWZ6?=
 =?utf-8?B?U09FYjlSQkdGZ3JaTzc3TmZaMjVFSzBlOGVzZTVsWlBKSXNGTmkzUC9KS3pR?=
 =?utf-8?B?TnhhNVFHUmZmUGkySFZlTU40QkFMWExlZXZQMFB3M0xucFdadEh3QU44VWlu?=
 =?utf-8?B?TGdlMnFSQ1VlVTlLbC9PZmRuaWg2MTBzSUpDUS92bGFoMWQxMlBKWkVpS21U?=
 =?utf-8?B?SnRRa01UNTBpR3Q4RU5uYXNNN3IyWmYyNlg5Rms0VmpKVExmUUR3Z2ZhQXE0?=
 =?utf-8?B?RzY4MENndWxET3dSSEM4YU9Udml5ZnRvSjZabUJDTEo3ckNOZkhrVXBBZ0tT?=
 =?utf-8?B?M1dvNFBESUtXKy9XSENybmxURU9JbllVdWZvRFVvRG9nalg2TVV0UEVvL3pn?=
 =?utf-8?B?TnlFTXVxZ0JLbHVXemwvbFdCVUdpTE1JUFYrV0g1UGVKTjhWTnQzeThKbmdH?=
 =?utf-8?B?a2xTZ2krNHphaVZEWTQvSlByV3ZBYnM4T0NQcklWOFlPR2kxUnplWmVnV01s?=
 =?utf-8?B?UExtSFU2L2JSbThTa1d3Myt3aDhaY0ZIUWtlTWNxRG5QblU3UHdLZlVxaU5J?=
 =?utf-8?B?MlFkcXNYMzh5VGhUZytzR2NtYlFLMHlYWUpMMldzV0RjcGF1S2dYWm9KUmNN?=
 =?utf-8?B?Mjk3TENPeDJYcFpNUVlyTWhVWFpqL29tbkVOeFREM1V3emxzNythSHZDYVI1?=
 =?utf-8?B?Vm04NXZWQTQyT0IwZWpPVHJuMmIyQ0s0UFc5SW5sWmVCVjZlWlMyZ3pPeCt2?=
 =?utf-8?B?c1duMTVWWkRLMVVNYmtlTUd2RDZQd1dBOG9aK2F3eFNHSGJ5S0FvT0h5RDRi?=
 =?utf-8?B?eVRCK0h5dGRpcjE5S3ozU1Y1QWZibUVhWkZVNXlxMHIreEtpR0liU0t3eDJS?=
 =?utf-8?B?Qm8zWmNUaURSRE5QYzd6S1NZcVlLajdHcE9TK1MrdDNzUERRb3pWMjFaR2ty?=
 =?utf-8?B?d1U5Z29sL0ZyOHdyY2pGYzFtN3RoRS9ZQXF6bmJMUTNmWm4xSDJ3U1gySURX?=
 =?utf-8?B?WGNtOUFXTlhQaW16TE0vWllFUjk0a2xsUTFXQWtDcDE5VjNIMkRPRWt3OWtv?=
 =?utf-8?B?NitpU2QvU1JqZGUrRElOQytOQ1RBbXBnOGlIbmpCZGZnNHNFQncrOUdwTGJ5?=
 =?utf-8?B?T2l6OTJwSmQxZmx0S2FyMW9Hemx2TVhSTWtOR3J1ZlI4YkM4RzdMcDVzUW52?=
 =?utf-8?B?S0RZNUpoVXNHYzg0YzhJS3JSZzF6UWJPK0gxTTFEbm85Qzk3dmFmSlNGSy9l?=
 =?utf-8?B?MVhmbmppT0dDMzVwRytyWFNNZW1yYjc1dmgrQkJYZktnZHM5NHg3SmhjcDIw?=
 =?utf-8?B?U0ZYaUo3aEpEYStoOFhwSXIzNXdrNXRkb0RGNHBlUDZ4NVEyaXI4VGpza20w?=
 =?utf-8?B?WVhOQWFUS0g4TTdaejFPY2hqaUdIOWJ3UTFLVWFHQUdaNThlbENpcFZabFBM?=
 =?utf-8?B?dEVNMHo4WDZHVDFuK2RLYStZWTRPMHc2V0Z6RERXTXNka2Q5clluYldhRFE2?=
 =?utf-8?B?N2p2OWpDSGtjTFFnZjVtbXlZTUE3RnBPWlVSNlhGK3pPQXI4Uzg5NDV2ekVG?=
 =?utf-8?B?RnlNaGE5SSs5cWdUWmM0SDNMMkYvaW03WS95ZHY2RlhHUmkxQXJHWDNHUVZy?=
 =?utf-8?B?UUpqSkk2QlpObVJBTXg0cmd4T1FjM1dLcTN4dEZBbFBENjdtQnh2MDJmQlFZ?=
 =?utf-8?B?dXUxK1NZcDBpZk5GK2ozdXFpUVg1VXBHNWlVU2ltTzhRN0ZsZlJlMFZXZlMz?=
 =?utf-8?B?SXB1eHJMRWpQNEdBQSs5TmdyYmF5Y0hJWWsrVXdPTXpodTJCcTdDSk9VU1o5?=
 =?utf-8?B?eG1OM0FKMFpkVGxaOHgwbnpIOGRpbTAxeDJoWXdmbVVtbXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0J1Q0p2QVNZVVg4K0RjdmJuNmRHVzhPK0pxYmZPY2Y4Q1dERlhhcGkra3Ry?=
 =?utf-8?B?a011eVRSaVhjazFTeFUzTVVVZEl6b2tBWmtGWDNsRG5uV1NnNVN4SlhLMCt1?=
 =?utf-8?B?dlJqVGJpcVgxWnF6OUtwQnZNVUJyOVlNdnRXSC9hdUs3Tms0ODFaeU5TQ2do?=
 =?utf-8?B?TEFySGFFWnRnMGFzZXdyc3Y0SG9Ua1NVNm4zNE9DQmZKMWNNM0kvNmkwbCtD?=
 =?utf-8?B?bCtQb0Z5cFBkYjI3RS95MUVvVVdQOHFpa01kcFVBaExZWHFORThHSWhxcjl1?=
 =?utf-8?B?NHdOS0ZReTBlZ2l4N1Z5WDE3VFlFR2ZjcjdTK0NOTnFnMmdMY2FwWnlDZ2cz?=
 =?utf-8?B?eGR1MW56Y2p1Tkw2OGtqd1pveVExc3hyMDdjbGppQm5QUXZLZHRVeWdLcUZr?=
 =?utf-8?B?UmQ2RGpDeUEyVlp1QmtpUGZ1R3hkMEhuR0ZHZkEycEtDYTRQRlZ1ZmVKUWR5?=
 =?utf-8?B?TzNQQTVOdmtHNG9zKzhld0s2dVdqd1N1cnA0eVY1dmgrTU1iVk5MUUppNGph?=
 =?utf-8?B?UXlGdXFXRlh4emdENllrMy9zS0FTT3hoL0V1V2xFSmpGVkR6aWkvbXM1akhT?=
 =?utf-8?B?K0JTMFU3QmRFUENGUUdKYmV1UWdlZ1VZSFFkMkwvb3Rzd013NHZhVVRTZ1Nl?=
 =?utf-8?B?MVJ2ekVFVmlSVzBuemFaSUNrRERrb1kwVU9YSGNaNm1LbmZ2MGJlTkxuV09S?=
 =?utf-8?B?MU9nK1VUR2diVitES3BKbVNONGh2VGRMMnVxbFRldTZJMGw1bCtKRmZmNzND?=
 =?utf-8?B?QUtsejJPMk82UmMxaHVpVU94OEowYXhYL1lBNjl0T1drOGRjcEZXVloxRGxS?=
 =?utf-8?B?VGRJVjBvRWJNaG9QMVk1eHkrdmpBdU5Ja1BVUDB5SDVJM3dBSHlFM3lmUm92?=
 =?utf-8?B?ZDRRNmhXeGgzOUZ3N0h3WVBydWM3Y1dtL0VlK0ZRTEdIVlZsRHlqaGIwQ056?=
 =?utf-8?B?Q0hVNU1oRDA2SGZmd2V5REV3eUk1SExvcEhXU1o3RXZSbFVtdDJzUTJMcDkx?=
 =?utf-8?B?dHhwS29sVHhoWnpuQUZDZFhiTDc5VnZta3UzMXBIRnZEZFhHL1dnWHl5N1hv?=
 =?utf-8?B?VmhiMkNvNnJkcUU5aUVJcVRVY2RETWFyZi83dk1JUGc0ZytXV2Iyc1FTWmRF?=
 =?utf-8?B?eWNDelJzQm13cTRwLzdsWS9NblJ0NTd5WllJU04vQUxhWHFaMGtCUVljcDZ6?=
 =?utf-8?B?QVplZWNldUYzT3FoMTNGT0VURGlRdlpreWNiRHM5ZUVrVnh4RzVUcFlOV0d3?=
 =?utf-8?B?MFRJYndOak9rcXlYMi91cW8wVFN0YVdXSHhrbzBQYXI1UkZSbGtKUnN5azhQ?=
 =?utf-8?B?aWdaN2UvREpJcFBoRGpsOTJnUFRYWDdqNW5hRlVtb1lXWllWUjd3Mlkxc3pp?=
 =?utf-8?B?cHp6YnJUMDdZTzJZdWdsRllyQlloNGJJUEhBYzhpaWQrcko5MjZxM3cxSFR0?=
 =?utf-8?B?RDhMQXVOOWJKUVQvWGRvdHBySWJsdlhFeVdHVXp1SHZkUzJSa1Q5TnJuc2VR?=
 =?utf-8?B?YmZDOTNjd3JIa29iclBkSWtuMkZnRnhNUTg2Z1pZVVZlYkNIZTR3c1lZWnZD?=
 =?utf-8?B?dTJGR0JMaitWRUQrTTRPOXRVU29LRE5qckt5eHNIWGJMdnhqUEUyQ2ppVTd4?=
 =?utf-8?B?TFJhcU1Oc3VJeEtMOGEzcjI4MnV1SjF2blFNN2FkZ1FkQ0tkOXU0MzQvYnho?=
 =?utf-8?B?MVNvVlI0WHZPRUIybi9tc0ZkY0hJdkI0M05MSEhGbGtaS2lvRTZFTjlsbUxZ?=
 =?utf-8?B?YU1sdGt4RUZ1anB2T1YzVUJucS9lV2pTaktYcVg4eFgyMEtkYTYwWkI1Z1h6?=
 =?utf-8?B?cjJDWHdHMmdXek5BZ3piT3l5OEtybFhLZWlLaW16Yms4MEFKb2gwellZQ0Vm?=
 =?utf-8?B?aERXYnFLRHNsUTl4emkrS3VRN0lpRG12aEttYi9zMDdubkhzbXFPQkRMbC9m?=
 =?utf-8?B?Q2VHbUVQUVZKRVRRZVdBbjJZYU9XNUFNWEI2YjVPKy9YcnpyN29uMEYzSFhG?=
 =?utf-8?B?NnB0SmVHeCs0aXJlaFVtMEcvcHNUc3JYSFVJS2IxWFFJNkpKbmtZODZyN09B?=
 =?utf-8?B?NzZ5VWZoK01TdlBpQXpZUjRyV3VHaHM4ZUZ0RG1pd0c0MWxjbkc0UHAvdnE2?=
 =?utf-8?Q?wzxbPL2XxbSkpiSkO3jD4DQCZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da9b2e6-d40c-476d-3978-08dd14e93c91
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:56:53.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+sGHOpZhu06etiOGti0d/EXqvlVbvAgIAM7YzVwpsHHM7YNZI2wt1nIU0cqhFc3/Tz8ZWW5Olu5SI7I74TC6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6794

The tampers are security feature available on i.MX products and
managed by SNVS block.The tamper goal is to detect the variation
of hardware or physical parameters, which can indicate an attack.

The SNVS, which provides secure non-volatile storage, allows to
detect some hardware attacks against the SoC.They are connected
to the security-violation ports, which send an alert when an
out-of-range value is detected.

This detection is done by:
-Analog tampers: measure analogic values
	- External clock frequency.
	- Temperature.
	- Voltage.

- Digital tampers:
	- External tamper
	- Other detectors:
		- Secure real-time counter rollover tamper.
		- Monotonic counter rollover tamper.
		- Power supply glitch tamper.

The on-chip sensors for voltage, temperature, and clock frequency
indicate if tamper scenarios may be present. These sensors generate an
out-of-range signal that causes a security violation to clear the
authentication and storage keys and to block access to sensitive
information.

Add linux module secvio driver to handle security violation interrupt.

The "imx-secvio-sc" module is designed to report security violations
and tamper triggering to the user.

The functionalities of the module are accessible via the "debugfs"
kernel.The folder containing the interface files for the module is
"<kernel_debugfs>/secvio/".

Get status
Reading from the "info" file will return the status of security:
- Fuse related to security tampers.
- SNVS readable registers.
- DGO registers.

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: frank.li@nxp.com
Cc: pankaj.gupta@nxp.com
Cc: daniel.baluta@nxp.com
Cc: silvano.dininno@nxp.com
Cc: V.Sethi@nxp.com
Cc: meenakshi.aggarwal@nxp.com
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>

Changes in v4:
- Modify description of NVMEM controller handle to be used by snvs driver.
- Modify the type of argument1 in copy_to_user() in imx_secvio_sc_ioctl().
- Modified the type of argument 2 in copy_from_user() in imx_secvio_sc_ioctl().
- Modified the type of variable as static for structure device, platform_device.
- Export the API imx_scu_secvio_init() to be used in SCU probe imx_scu_probe().
- Link to v3: https://lore.kernel.org/r/20241107-secvio-v3-0-ea27f1e9ced4@nxp.com

Changes in v3:
- Dropped [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree bindings.
	- Reuse SCU node to prove secvio driver asynchronously.
- Dropped [PATCH 4/4] arm64: dts: imx8q: Add node for Security Violation.
	- Removed explicit secvio sub-node within SCU node.
- Create seperate secvio platform devices.
	- secvio driver probe asynchronously.
	- SCU driver keep going and finish the probe first.
	- added new function imx_scu_secvio_init() called within imx_scu_probe()
- Link to v2: https://lore.kernel.org/r/20240509-secvio-v1-0-90fbe2baeda2@nxp.com

Changes in v2:
- used b4 to add the devicetree list.
	- Added all necessary to/cc list.
- Link to v1: https://lore.kernel.org/r/20240501053205.1737248-1-vabhav.sharma@nxp.com

---
Vabhav Sharma (4):
      dt-bindings: firmware: imx: add nvmem phandle
      arm64: dts: imx8qxp: add node for nvmem property
      firmware: imx: Add SC APIs required for secvio module
      firmware: imx: secvio: Add support for SNVS secvio and tamper via SCFW

 .../devicetree/bindings/firmware/fsl,scu.yaml      |   3 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   1 +
 drivers/firmware/imx/Kconfig                       |  11 +
 drivers/firmware/imx/Makefile                      |   4 +-
 drivers/firmware/imx/imx-scu-secvio-debugfs.c      | 274 +++++++++
 drivers/firmware/imx/imx-scu-secvio.c              | 619 +++++++++++++++++++++
 drivers/firmware/imx/imx-scu.c                     |   8 +-
 drivers/firmware/imx/seco.c                        | 216 +++++++
 include/linux/firmware/imx/ipc.h                   |   1 +
 include/linux/firmware/imx/sci.h                   |   9 +
 include/linux/firmware/imx/svc/imx-secvio-sc.h     | 216 +++++++
 include/linux/firmware/imx/svc/seco.h              |  69 +++
 12 files changed, 1429 insertions(+), 2 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240508-secvio-8acfa2838385

Best regards,
-- 
Vabhav Sharma <vabhav.sharma@nxp.com>


