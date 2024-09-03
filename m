Return-Path: <linux-kernel+bounces-312540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19B9697E2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BE728A5EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D8D1C767A;
	Tue,  3 Sep 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="IOmILd6M"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2101.outbound.protection.outlook.com [40.107.247.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858C1C7661;
	Tue,  3 Sep 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353577; cv=fail; b=hprMJI5CWzRu5mKgXJQ8NAzLYp2t29FtdRligSKoOqlRhPkmbaJHNMPWfDjE/sFNC/FBByRsbAJIY5ZzWu2OZZMWTjFlwDe39nkzv9z60+DplzF+3Mt8SONW65IDcI0t0SodARbSFJrx3l8MT0wlDgTJ2Vg+AU1bk6m0c1ZFQTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353577; c=relaxed/simple;
	bh=AQMtHTvNl1XkI6NqLIfTnK8pXX0kw5I9pBszllh40sc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kb51dO1FzU1/S9jau7NUZ5j8+wDV3mBSgVLvq9K/3RoEcHBcG0lyre739y117u+gFHaggbmwoPjxueB2HmgR3ql6ElBc8oj3/AYNkpBxwVOwjhcfgtkLy4QemVTRBB6MDldgbQp+dAl0jeC6ENbNIWYnMtqgmGuT72PSvCdVxes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=IOmILd6M; arc=fail smtp.client-ip=40.107.247.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ar5GAtzZpbyuS1m7qiyy8BIZnwkA6nWDcNtuBskQnAgf97GZZSya5R1ae6K1MtwVjTGRUI7+97qPnrnhCwuhhb543atEEV5RqeLfHQifceuYiqDrFNhbZKPiVkn5HQ3qHmFo3dMhJZtS5z0zL2YbnpJGT0zul4Qxm9blrXMmKrJFmpcif14efkPB8UUYT2N/XXDc8KzE6bCle7rMAkAstmVDNtmkthReojR1u8qxavl8ld9G214sn+yU7pGjjcoBbsCPSz92tUFPQBJieyJAHV09A0v50vHkK2NXTxdeP8esBSDJ+XrvEAS9xHnASGdU0sWEdibOmCqF7IXar5Taxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7APYmvdIoGeS13p0iRUQkBaePhDQP52r+sj8v5H3A4=;
 b=hepWjJcmKd4FXxmk4macvCAJ9Jm9mVqXSOa6bqwtAWmtmqWohvFKrmvEuzExq4jFBZa5dYGZarjFTN20Z5MdchXhIyCjN2UghOPhmQo1bwWkIkMCz2kY9PAszbN1om8awdei7+S37HFDVl1RgDGdhATuYiCpIAyue7izAufFxNMs4ITXDwNhtDtzkD3mNljx251n/00V3RKAMQiPXnziiGKR5PdjfsrkjUedAZemkH/ZPj77tRrrX8EVUW1G2ch0TQCUxfwipxocujr5mPIfff0/EGKSlZ6up2PmwPKpJnf4iU4BRBQZXnKs4qNBGysonlOmyAxful6ZIJyKhMUTMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7APYmvdIoGeS13p0iRUQkBaePhDQP52r+sj8v5H3A4=;
 b=IOmILd6M/VhiG9xrhGIewrBz6lNJRWjOtawyey8l1K1n6jcIL2zy++uUAdoCYOSF/K/nUktYMNm+voFFsFf2ksviSlI2tg64GjobhidiDcSyNqg7XDXn4w/Yu58Vsq6VYrCMD2yHzpOATP6ik54vstJ/JlDfG/br0OoSzDkEESc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM7PR10MB3336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 08:52:50 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:52:50 +0000
Message-ID: <6e01f802-f27c-4d3e-9313-5158dd13494e@kontron.de>
Date: Tue, 3 Sep 2024 10:52:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add support for Kontron OSM-S i.MX8MP SoM and
 carrier boards
To: Shawn Guo <shawnguo@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor.dooley@microchip.com>, Fabio Estevam
 <festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, imx@lists.linux.dev, devicetree@vger.kernel.org,
 Frieder Schrempf <frieder@fris.de>
References: <20240807104137.558741-1-frieder@fris.de>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240807104137.558741-1-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM7PR10MB3336:EE_
X-MS-Office365-Filtering-Correlation-Id: 915dfe80-ad54-4dc5-fb16-08dccbf5ca2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0RCM0M0NGlCdGJWTkN5dnRXc0pTQWZsb1R2MG9WZ3RYUDc0cDExUjVCWFlx?=
 =?utf-8?B?aHB6a2U1MytIeE5NMzVicCtnZ2ZrSTV3M001THZmSk9vSW05SXhkOFN4UEFU?=
 =?utf-8?B?SC9mVnhaL2dOVHMybkdUUFZLQVRpdjd5RXVBV3Vxamt4ZGd5aWpVRCtTeFZH?=
 =?utf-8?B?U2I3T1NkdVpnZ2thTWRpeGhNcnpaRWE2KzJoOFZiZ2RtN0hIMVpjUzRiNDZH?=
 =?utf-8?B?WXYzdERRS1M1Tk5nQUZ0d1Bmc254ZWYxWTRZZzlqSHBpaEpPeVpSdE4yT2Vq?=
 =?utf-8?B?NEdOVHh5M2tNNmdyQkEyVFYzbXRLS1ZtVXBzdVE5N1BLdGZiVW5nS1Voa3hp?=
 =?utf-8?B?UG9ZVmJaZGUzRStGOFFKU0lNV0U0ay9jU2pjUkxieldPenVyLzB1TDJhOGRJ?=
 =?utf-8?B?d2IzTncvNUNSUGtyWEkyb2Z2KzlMOFhTZko4RXpGWTdXWUtOVEg2TXNqMi9J?=
 =?utf-8?B?ZDJBOHZYcWlwSERMeitubGFFNTBBQmZWalhOU084MFNVckw5UTc2dno3bitk?=
 =?utf-8?B?V0RTT08rUEQ0RFRaSktmWFJWQnhPNTN6NHZ1ZmdUdmEzTUk1VWhuaHM1MlRx?=
 =?utf-8?B?RTcrNmp4MlpWQXV1UUYrZnhXVWJhVFpZRGtybm84ZnAxSUw3THJ4Qnk3UHBH?=
 =?utf-8?B?U2I1ZWxpZ2JEL3RtZW9OemlzWUVKbnFTSm9vTDNUaE83RWJabnRTTW9hNnFo?=
 =?utf-8?B?NVh4eXpRWjhvcW8zcXBZUy9PQkpCSUNLa3N6ZmlqREFiU0NYUGxsRngzalhZ?=
 =?utf-8?B?aWd3RjhyMFZzb09iYXE1eklqemdMQkFIS3NoYVhza0NpS2NEdzZ2RXdEQXV1?=
 =?utf-8?B?Slo3bUdWSTVBQ25waUI2bDdiblhpcGNVcTNobUFyYWtHUGxiYWpTVUhMUmgz?=
 =?utf-8?B?VDkzM0ZKT1YveFc3anF2UjNraGF2U3VCVkp5QmJ3eXVtS3dsdUpJaGZqRHE3?=
 =?utf-8?B?K2s2TXgxcld5b0w3Rk5kRXI5R2hqNHBDMklWakw5b1BkVUhkZ0h1dGFWSlUw?=
 =?utf-8?B?dFlYWDFjMHUxMmY5bXV5Ync0WTFTZ3YwMndPbU82bExjMUQrWFpSblk2U0pO?=
 =?utf-8?B?c3AyN1dWaGFUQ0ZQOTk3NWFPaEhoK3VrdnlJdGJjb29mb3pOZTNOZ2JDeWhz?=
 =?utf-8?B?SGFLRTlvUS9pUlUzUE9ydW5pWVJtZHVyR2hxOW5PdmJzc2xqSWhBVGVjN2NZ?=
 =?utf-8?B?TVM0VlVFRC9YVHVnOTc3R0dTSGFyWGN3V0NvV3FqR1Z4ell0SVVxRTA0clZI?=
 =?utf-8?B?RmxzaGU4ZUFDQTFyOWkvaGFNNHkweG5mSzJlL2syeTRQaUoyaFZQMGZYZzEy?=
 =?utf-8?B?OGc4blJrN1gvZTFRSWZBbVhXb0xDZFhYdzM1aFhwZG5nZlZmQUNJbFVWbEpS?=
 =?utf-8?B?MDBnak1DSlRGbnluRG9VOHl3d0FYQzl6cDh0OHIzekJEOXhlSnd6ZUp3b1Vn?=
 =?utf-8?B?TjZhZnNEVkJGS1lYUTh4eWZOSE9KeURqNmdHZ2pQc3FTbm1wR1pEYk1kdmRp?=
 =?utf-8?B?djJNdWwzMjVHOVg2L0J1VVd1Q3VVelVMQVByMG5rdzdycTlrQUl6ZkZxVlVx?=
 =?utf-8?B?NlUvMnh0L29rVmlvRzd4MkNMaURNelVRQ010eUs5bWtBWVU1ZUtEdUxzRnZp?=
 =?utf-8?B?R0RyeU9DcGcxQnlQcGFZWHdmcEtub0pSM0tNa3lBdkJPRnFyUmM2VFgwQWJk?=
 =?utf-8?B?UTRIR0xyNGJpTjB4VzV5c2VRZURvMlNFMjhCb3R5R3JzR29FLzVRbi82Nnhw?=
 =?utf-8?B?dkEvYUxCWWdYZDRQVnFOUXVsVXZmRGJEY1hGcU1lZS9BbSswK0VCckt6dlRU?=
 =?utf-8?B?em1ZVVRHTUo0WmszV1Uydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkttejlGdlBSY0d4TS9RTkhGRFhBd2llS0hqQW9ST3N6bDE5WElRTEFNQU5I?=
 =?utf-8?B?L0xES1ZnVjlhTVE2eW5LdGZUY0xFSVVoeWhuaEc4a09xSGV4Z0pVMGJvTzk5?=
 =?utf-8?B?S1RGWVpCK0RUeW5uTE4rdzJkVDIzME9MSWt5TVpITmhuakt3M2wrclRRVCtr?=
 =?utf-8?B?KzNDT3pzWHNoSEJDMnJzUkY3UjVKL0VrakN2cDk1V0FzaWZ0SnoveXR6dU1p?=
 =?utf-8?B?OGFvOTJLQ3VabE9oQU5JQ2k2MktHakM5UFh0eWd2bnl4MjNBQ2ZpRU1tQTZx?=
 =?utf-8?B?RlJtN0xSRnF5dXhFOTZ6c2IxZmJLYlF0cHZIK2F3bDBiWHlMZ3gxVldFMHZt?=
 =?utf-8?B?Mi9KWW40a242eEpFQVhvd1REMnJVTWJrelV1WXh4QVhBSVBKRVhEYnhES1o5?=
 =?utf-8?B?TmZjSm9ML212dUhmSHhXV1NScStHK0R5YmJaNEJoMUdWY0FDREsvaDBiVmZI?=
 =?utf-8?B?bkJLbTlCOXRIZGtwekFJdW02QXFaSlQrc3pTU084d2dEWUFnbk0rRFBvTDFw?=
 =?utf-8?B?ZXo2YlpKQ0NHcnorb1ZHMkU1amVlVW83WDUwVFg4NklhWWVMTk1aeFRCVDg2?=
 =?utf-8?B?RFYzaEgxMUhWWE85UmdUc3lyQWFOQ1loeElhWVBtVG5FNzZQWVRsOVEvbnFN?=
 =?utf-8?B?TkU3azVUTlFWbzJ3UGpCaVNtK0ZNM0VPc2JySFhPVlZpdTMrUmxpbXgvT3J3?=
 =?utf-8?B?Rlc4L0dJd1J2LzBCdE82S3EwWFNmbWVBNmdjRDlJa1VvWTZJaTVtVm5kY2R5?=
 =?utf-8?B?SFJvZ0I2ZFFZUGhLM3VCV3JUL2JKUzFPZ1BPNFNQRGxBRWRaa1BuVUNDdXd2?=
 =?utf-8?B?RmJzczlsRElXQy9lZHJQenJWMEhzRVhPK25aMkI4THFyaW8wTTkvczYxLzZW?=
 =?utf-8?B?QUlGTWU1a2RLUnBxT2tHU2I5eGJ1Y2EzczZncDhYTUlPZ1U5QXdOTzdqRTlj?=
 =?utf-8?B?SHBKcWpvTEM3UVJTY0VBK0ZFTVl0WFB2QU12MmJXWmxrVGEyNlluZjNpRXV5?=
 =?utf-8?B?NEZWWHhwMjdta3BoRFAwdDUyWGxFa2FKeFV2R2gzODRkK0VoVjdNbWJrZzVv?=
 =?utf-8?B?WHI5bkU5akNLVmdSdlBhY01aMXFOa1FvZXJIZ1RKREhGTmVvYm5XUm9TQ0Mx?=
 =?utf-8?B?Y3d1djFUc0FYQ1c3QU1UNDZjRFpqTWQrdkgwNFZKRGtGQWZ5RGFzamh5OWxh?=
 =?utf-8?B?dFVJeDNwMjdTenpSWUtPcXFGU0ZWM1hxTFVmVGtUVnhHOUg3Rk5CQ2hQWGRC?=
 =?utf-8?B?eUhkSzVyeDJaUzVKMVl3dWlYYnlXRXM0dXk5ZERUcXkzZXdMelVTR3Q2Myto?=
 =?utf-8?B?ZlVEMEgrR0RzdUVBK2tubUZnMHN6NTZkSW5kZURVYjRHNzhIQWJONlpDR0xN?=
 =?utf-8?B?TURiRkVzSWdqSlZSOTVkdyttNUtTdDd6c2tKYWMzV1c1MHlSV1FDVmJIblJy?=
 =?utf-8?B?c3ZaNEhrQ09tTkMxVWZUN3drczJYaEhrM1RaR3h3N1pxWEkweVNMOGNldUll?=
 =?utf-8?B?OHZxdTJrL01GSW5oUjBrNGtSaDEwYW1UNjdRV2tqNmV1bWVHOUlBQUJXS0xM?=
 =?utf-8?B?YjMyQ1hBN1YzaEJWRXRFN3JwVStEWDRvOFJ2NncxUmxSK2xaZjArbEZtbHY0?=
 =?utf-8?B?czdnK2lqY0krRjc2SEwyZzRkU1I4cmx6eUJEKzJ4bmRLaGs0ZC8yL1ExV3Rh?=
 =?utf-8?B?U3g1QnVGaWtmczdMRHBWdkY4Wk5wam1ZV3d5OEJMV1RKOHdlOGRNa21oNXdX?=
 =?utf-8?B?WHhVaXRkVysvSHJDOVA1ZDh6Y0R0Z2Y3eisySWxRdnFpcmxQc3UyRDVhakZr?=
 =?utf-8?B?REdGWTRWZklLdGgwaS9CUVgxdUNDTWJMU3dnU2M5ZUtVWXBaUkM3RmU3NC9X?=
 =?utf-8?B?NCt2cGVUMjFLdzNhcU1rRGprdVAwSjRxN1lKWTBtWHYweUhFVG56YWtIWkxC?=
 =?utf-8?B?aDRyLzZiaDBvNTRVZ2p0WmVKSDcwVDltRmQ4WHFUOXkzdVdyRkZIdlVvOEhJ?=
 =?utf-8?B?MWh3d3dTRDh6cEVWYnp3b05EdjgyTDZIbUhUMEJiME83RjliM2tuL21sQzF4?=
 =?utf-8?B?Zm5jTUdYNWtyUzRtbyt3RWVwVHVQamFaeUhRR1lFL0NIeFdHeVB6TWlFeVB4?=
 =?utf-8?B?cm96bHBsTi92U20waEMyTXZXdjRYVk1ybTcvSVBSZ2FLaGJyUVN5SHh1akFN?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 915dfe80-ad54-4dc5-fb16-08dccbf5ca2a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:52:50.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1btZ4p1R6MRwJ8CYqbkjCuHDvnZq2zF7qe5CENmu0ebrOzqtGHlyR0/EIsGDUuwbN9znTZByxgvtxrkj3dwEj4xxvdmytYyxYY3VizrgxJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3336

Hi Shawn,

On 07.08.24 12:38 PM, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Patch 1: board DT bindings
> Patch 2: OSM-S i.MX8MP SoM and BL carrier board devicetrees
> Patch 3: i.MX8MP SMARC module and eval carrier board devicetrees
> 
> Changes for v2:
> 
> DT bindings (patch1):
> * Add tags from Krzysztof and Conor (thanks!)
> 
> SMARC DTs (patch 3):
> * Fix GPIO labels
> * Add support for TPM chip on SMARC module
> * Disable PWM in favor of GPIO5 on SMARC carrier
> * Enable LCDIF node to make HDMI work
> * Add support for GPIO expanders on SMARC carrier
> * Remove SPI flash as its removable and should be in an overlay
> * Add CAN regulators to fix transceiver enable

Just a gentle ping to ask if this can be reviewed and applied?

Thanks
Frieder

