Return-Path: <linux-kernel+bounces-258395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99160938770
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDCE1C20AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8218D272;
	Mon, 22 Jul 2024 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WdO3yJPa"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C8611E;
	Mon, 22 Jul 2024 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721613544; cv=fail; b=qhb7wwZfwmGttgiePw80LZfJFaiwnQq9ZOmWvqkMW9vsv6DXuQrof2UsS4gnWzx5YMSLW66FtWgcWwdKJHmdTwdmA2GdfdflVzmrGIrvt1QGOT98ffHfNpT5v+8BVe0KkHcDqDqO6zmzyhGhSfrOdVLnC9+6iomp1uDAMSU9fx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721613544; c=relaxed/simple;
	bh=e5LGzF8Ols7tDSfBkGA+qdXZf5C1mQNxceiea9P2Css=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1fFRlQKJmJYYcCbSawzPv1qkft+EZk2/F/P6/GtDIOHoyj43iHsK/fCTye1RDgvcJ+9nv0KGaXFUgatP+D/Pf81hmHLYS5wq4bb4uzG3uDPZ0bJJZdCaccnYx6ibJoImSlTOJHgtjBoBLco+klrBNefZnA4X6YX2zA9Nxj6NC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WdO3yJPa; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZYIN1Eh/LrGmPjVD8wOSRu1oyX7L0/e8Sil4fhIV+73IeuYnWyQLdUf+0xDRWX7LZcyYyWwjcB87Dt2eiwP8/IznK/IC+DA/b5LX+svEG3mi7zzIptUQIrfgCxLPvL/dUA0paL4mNADEQ8j0W5kD7UrbGMaOabHivXnTzX22RcVrHhJV8DuQ61BchTxI7/30jKT18jWgbamGDlpomV2DNeIdwc0d2GNw+XUinpRFhwIUUeLjKaWoHFMbkOUZXDBXUPwABhETY2iTxMODZqYII9mvIeAf57h4DfL2asUvRbxhpbHVMdKS6D96vJCEQl14TlAl0hUqA2cvu+6TivPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5LGzF8Ols7tDSfBkGA+qdXZf5C1mQNxceiea9P2Css=;
 b=iRqBoWpBbDccXqyseu2CzsKOqLKH/m4a93vEGnJcQWqGtbsftOmt9vGxqKxwdHLZgGyrC5LDsMH2GBaN1KHUUOTyIarMz6hSMVjCJ2E7jRISOGKKnp/R8uDRBGcngBTFX3TkToCZLHyyyh1p50ZIt7LOT31jxm5d+aNJ2Tz3TIUyTrRQ21QAd5V0PpvG/AwGDmk/KXGuWM6355I7+LR8ZUomW0BMCSlQkeXvzu1qumj9wEmUkCgnmqWRhMqCLDEQSol1OyNaSBLi8Qahwnsnzz/9Cvph481SOV+dOY9PveVdDS2neDPy/ZOXqt2nBZrGGdhqp/eeuUiUMKsh5DsuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5LGzF8Ols7tDSfBkGA+qdXZf5C1mQNxceiea9P2Css=;
 b=WdO3yJPasycfD6uTvZRY19RJrC98yuOh99YsmVX+9seK69W0YI/9V6cQM4vIAt0z59DCfdQR9OjUoHmh61r2Be6XQ3W7W3SGTjRWmtEL4phJ86cgFrahTBggLQzgw/rbHNGse/dD0FWWeaelVVrdnHZr3Qcm9zcI3Bkg7+agqt4=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10716.eurprd04.prod.outlook.com (2603:10a6:800:270::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 01:58:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.7762.032; Mon, 22 Jul 2024
 01:58:58 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] arm64: dts: imx95: Add NETCMIX block control
 support
Thread-Topic: [PATCH v2 4/4] arm64: dts: imx95: Add NETCMIX block control
 support
Thread-Index: AQHa0qchSzfgU8nz7USVNt0vdVW+g7ICDq7A
Date: Mon, 22 Jul 2024 01:58:58 +0000
Message-ID:
 <PAXPR04MB85101CDD4328223C6E2A81E188A82@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240710084345.2016687-1-wei.fang@nxp.com>
 <20240710084345.2016687-5-wei.fang@nxp.com>
In-Reply-To: <20240710084345.2016687-5-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10716:EE_
x-ms-office365-filtering-correlation-id: 6df75374-387b-435b-d444-08dca9f1d9c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?djI3NENmMFJGbVlXRFEyYnhXQjl5UG11WVU2V0kyNUVCZ0hqUmt0UWNxejQ0?=
 =?gb2312?B?K3N3U0xHeC9oUmxrdVN1UFI4L2o0ODNqT0tueWo2WFljVUVPQkoyUkxvSUN0?=
 =?gb2312?B?L20xTzRIWlVwSXBxcFo1bERpQ2ViNzRnQnVVaS9Ocm9GL0thcHFnREJJS2hG?=
 =?gb2312?B?QmRmZzFpKytCbkwrRitoRnZjRElJYTNQeE5GdW0yZ2RPN0g1dWRweWEvR3lT?=
 =?gb2312?B?Z3hvREN1OGlRdy81Mmlzcm9tWExTYjQ3VlZ1SEVrdVBsN2F4K2tocmdmdWdK?=
 =?gb2312?B?Tmo0c1NVdWZNNUhEbS82VWdXdzZtYk40NTBldjZra0R5dC9ndWpCRXlxTXkr?=
 =?gb2312?B?UENwWTlqMnMyZ1BjTVZkOWFMVnVpbnFuRmNnOFA3VkgrcGk2ZG50RFBJcnZU?=
 =?gb2312?B?VkhHeVNVek1CQnFLVXV0aXdnaGFmd25hMjVNOGlEYzZZUDNZcDZQdDNWQUND?=
 =?gb2312?B?dDR3anJvS2tVZGViQjhabTJIdVRMUnRVVmhBdEprSmo3WDcxSTRHcVY3SS9s?=
 =?gb2312?B?YUFNWjFOcjVvTEk1THVUWjJvT1VoRnJNRkhOdXBxbmEyTUhZQk0rRTN4UzZR?=
 =?gb2312?B?anZwMURjdWFnZ2toeHlhTW54dTNZL3hBRGpBalhsdmx2TFdxWW9qRUJmc3Y5?=
 =?gb2312?B?K3RJRjJaNXBsRlVvNkFsRTd6SXhlN2RVZ0RNZS9tZFIyTTVVenZBVjZRMVN3?=
 =?gb2312?B?SUdPUHovMjhQQWdOYUdlZWxGVk9pbnYvSm1FRmZYUFpDVnVYMUFLRjNBdStj?=
 =?gb2312?B?NXVFVEsvM0h5SXZWMVBUemxEZGFBeDlZUStPNDhKQkRRdWN0eGZTTFFKM3Q5?=
 =?gb2312?B?Qktsc3puK0xqbHM4dS9HbVQ2OER5M2RiS2ZjWkNFak1RcmQ2VmxBVWhVeUJr?=
 =?gb2312?B?bnBJVllTc1dKcy9sRG9QUkErSTBna2o4WGlkV1k5ZitEaG5mM0QvTjFlNlpZ?=
 =?gb2312?B?VVkvY0RSNFZMYVlvRi85bU8wd0VqNTkxREtFdnlwZmxIN01RbHFCRUw1QXJU?=
 =?gb2312?B?UzdQd3dZMEM5UkloVkQ1WjUwSk43b1pXY0kvMHdYVURCNTgxdEIyVG9ucllN?=
 =?gb2312?B?U1NOMmxFb3J2MWgxTjl4QW1TSWdUTlZHZUdyb3BhNUkzOUZNQ3RQeWpBWUpq?=
 =?gb2312?B?RWM3V2NxRkFCb1FQV09zdXNma2VkTXR5ODBIRk45NGJwSy9YQm5Oam9DYnVn?=
 =?gb2312?B?Z0hyVWZ2bGlHTE9JRXFMM2c3WlVlaE0yL2ZwVXc2c2EzK2xqN05CMzBVclJM?=
 =?gb2312?B?N0FsZldJamRRYlRvMU1zakVwbGVrRlpBSzlFTnIzMXlBQUdkY2JCQTNkbWlN?=
 =?gb2312?B?WERyeXVuQmErRWZUM3NVUVB0eUpKSmxRMTZsbENKdzhDQVhEM045cGRJdW9u?=
 =?gb2312?B?VFNmWmZVSlBCRDBqOUFLbCtLQVNzN1FOdEsyWlgrL01qM0FXMlZyWGFDVHdk?=
 =?gb2312?B?Vnl0Z0xhbDIza1VaWTArN0g0MVJFZ2dVVWxlTWdWUTM2aE1DOERjeDJZVDJt?=
 =?gb2312?B?MmZJWEY2YXE3NjduNzBDcGMwVWhOc3hIWnFXQUJJZjRjbmdoMjJ2dE1POVA5?=
 =?gb2312?B?NUN1RUtld2V6MHBNVDNaQzZtOWM0WDdObWFxR2JyRFcyS0tNQ2xZaEJtNEtZ?=
 =?gb2312?B?N2VmbEoyUnZJTmxQK3BtczR3Z0pnWExUbmdIV2drZHlxaFBzTFhXay81Z1Vx?=
 =?gb2312?B?MnN6cXl5S2d4VDlHMXQvUnBKb0l2QWlwbEkrQkI3N2hiTUE0VGdidlY1OWdw?=
 =?gb2312?B?R2pNRlZobklXS3N3SkVzbVdHYk5zb3JYcjhJNjlZM1BJd3R0VGFPeFJhbXRE?=
 =?gb2312?B?b0dLNUREV3V2OUdmeEFRVXRvL2V1YTlVanNyREVYWW1xTWFDd3VaY3h4Q1Bo?=
 =?gb2312?B?T1RaTXFZQ2tuQ3ZraytIVUVFWXF3MUN4eWhTdWRXSEM4L3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?amhmNnBnd0szZ2xuYnZCTEIvamhqUGlFaVF4TllaWEIzMHNIemdFRmwzUmJS?=
 =?gb2312?B?MU1HeUp3SExNd2psVEhBVERyMlloR2w3Snh2L1N2MUs5NHZKMU9TcThPaHpp?=
 =?gb2312?B?ZE56b0x3V1FUZDQyQ0lJSWFOWmdETHM5Ky9yUVVNRHpvVGRtTVBjS29EZEFP?=
 =?gb2312?B?MysvcEFRU2lsWko5TUFMT2dKOWVoYTBEc0RaaHZMY21sUnVvY2lKRjViMWp2?=
 =?gb2312?B?NzRVVWJ1YUtidlFJcEdQT0FjVzZmNDQ3dVcwUnhQbFlxd3RDbE80UFZpbkRx?=
 =?gb2312?B?UWxScU4xQnFNblk2VHh0RURpcHNZamhMZXRRVXUySElaQXNVVzlTSytPUTRU?=
 =?gb2312?B?UGE3cTV3QStYUTQ0cGxmVUU4WHFkcmg2TTcxZlo4dm94TGJPNi9NRnl0OVpI?=
 =?gb2312?B?K1ZiaVpoeEg4UVNBM2NtNUgyaFZ2bkNrN0tpNnQ2aTBHVy9QdHoxYk0xNFNx?=
 =?gb2312?B?eUVLTituM1ZaVkJaV29rVWVtMzF2OTFPLzQ1UUNYTDJMMWdCRmF3NjN0QUVP?=
 =?gb2312?B?Y0RKbERHVzdlZG5Ob1lFdkYrUTJQcUhiTFlmZDB1cmhJRjViMks3eHVlZ0hD?=
 =?gb2312?B?RkZLVWk4a0d6aVErVnAwOExRV1gyQktTQ2RGa01lekVNcWFJZTlGdFJHNUpi?=
 =?gb2312?B?ZWlTSVd2ZEEzZkhTb1lQWjN5ckJiUXE3SGNOK0R4WHdYVDJ2bEIydUJmYUhv?=
 =?gb2312?B?MEVkVGkvdFJINHlYQm9Zc3Y4SnhFOVUvSzV5MCtMK1JudlBTZFRtQVdtSmRW?=
 =?gb2312?B?TUZDYnBLMktNUXpYODJ3d25tbzVJRE5OeVpHL0FqRGNibVlhQUFqOTZkSjNO?=
 =?gb2312?B?akEzRitVanFSU3FSZmpYRW4vaExwN2IzeGZXdlNyUWc2ZW1SRDFNTjcvYzBI?=
 =?gb2312?B?MXlpdmtKZ2FqMlNVZ0tJL290ODZsSDZSSnRnM2x6U0tsSGdObGtFQzlxa0ZY?=
 =?gb2312?B?aU52MFRTdW1aUXR4QWRRSWFraElEODR5b1VBMWJVcjJad25FUThzMFl2RDha?=
 =?gb2312?B?amVJZHJOMzVkVHVvZHB3Yjl5UEE0M3A3all2MSt1UHFtYWhPTGdkTWJ1MUN2?=
 =?gb2312?B?djl3M3ozQ01qZGRTS2ZCUmJRNEplbVEzcTZWK0lzdjZiQWtzRk1KNCtqRFFh?=
 =?gb2312?B?aEdDclBiYjZQQ1pYNnZPYkk3Y2dwUWg0VmR6Ykw1OTJIZzhTaVlTbzN0anZV?=
 =?gb2312?B?V2l3Q2tNcnVxd1hRRHdsUjVSZ3Fsa0I2UzExSUUvOGZMa09TWDVnVC9UeERS?=
 =?gb2312?B?RFFHM08xQjZOYndBTDc3NUE0QUxCRDJKaEZEZGN1Yyt6b3prMmd6MFJwR0pK?=
 =?gb2312?B?VUVMMzdxMUtDcDdvZU84WEtUdFVpUTVqYmdMN3hmdUcxOUQyUVJkZGpGei9E?=
 =?gb2312?B?TEhHelYrODJuSnluUEJVWko1aExRTzkvemVmdnQrTE5VV2FNWEgxM21sNER5?=
 =?gb2312?B?bkR3NlRucE81dDZubWpIQ082YmpLbi9Hb0ppZkRqTUdrOVJSSTFaQWFIMVc2?=
 =?gb2312?B?UzlZU254YjhYa0h6SjhTQ2l6N1ZyYkhmS0J2NXU3c0UyYTVZQWlaUDRGZWlH?=
 =?gb2312?B?UXMzbEgzK2RNVFFCcFd3MVVQMmhDM3hQSC8xd0V0RmdEQktHQ3pGQXFZd2dO?=
 =?gb2312?B?UkllQ3JuMXA5NDFpb2F3L1NVSitQcEx2dUNwdFZMVkVhOWVZcXB6RmdqSzA5?=
 =?gb2312?B?ZERwS0hCWDBZODFKeDQ4TTY5OGRIY29yT3lTKzlZUkNmYllHdW1jNjN0bmtQ?=
 =?gb2312?B?aHJ0eFkwalBlTlNYaFcwUEdmekRRdnBKZHJwRHgxTjF2YjMwUWJQY2xRSzYr?=
 =?gb2312?B?Zmd5TnBaMXhsaVdVMUtKSXpNWEJOYng5eWFNK0JVYmVuS2lpWDlnR0tZSkQ3?=
 =?gb2312?B?VDZ5RThMQTRXL3ZINE5hNEVKTWFFbkQ4ZW9YcCt3REhsbThJd1Rpdmo5bHNq?=
 =?gb2312?B?NzZXRDhtcmlrQVd0Z3FlN2x5eDF6VGI5azVGbXdlY3JFTXpIc0Uya3JOWFcz?=
 =?gb2312?B?ME5GUVE3NnQ5Q3hMTXowd2YvQm5vQUdxckYwZlloL0F6dmJNc0RpcVJYRHZ2?=
 =?gb2312?B?VFVlSHBDSUk1dXVJZElqTjRmZ0pJRkNEQnFnRWQ5b3c2K2pOajJPdlZ3V1JK?=
 =?gb2312?Q?W71s=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df75374-387b-435b-d444-08dca9f1d9c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 01:58:58.5376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIwiwaQS/NHIgAyOfKO+zGCOZyk2ojrLFW76cbSKwp0ShCgpYVnBfdbLELk53zjKO7o/dnJrSNzCGz05tPQPXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZWkgRmFuZw0KPiBTZW50OiAy
MDI0xOo31MIxMMjVIDE2OjU3DQo+IFRvOiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRA
a2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBzaGF3
bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFp
bC5jb207IGFiZWx2ZXNhQGtlcm5lbC5vcmc7IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiBDYzogbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFU
Q0ggdjIgNC80XSBhcm02NDogZHRzOiBpbXg5NTogQWRkIE5FVENNSVggYmxvY2sgY29udHJvbA0K
PiBzdXBwb3J0DQo+IA0KPiBBZGQgTkVUQ01JWCBibG9jayBjb250cm9sIHN1cHBvcnQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gLS0tDQo+IFYy
Og0KPiBubyBjaGFuZ2VzLg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDk1LmR0c2kgfCAxMiArKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OTUuZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LmR0
c2kNCj4gaW5kZXggMWJiZjlhMDQ2OGY2Li42ZTg2YWE5OGI0MzEgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LmR0c2kNCj4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaQ0KPiBAQCAtMTE4OCw1ICsxMTg4LDE3IEBA
IHBjaWUxX2VwOiBwY2llLWVwQDRjMzgwMDAwIHsNCj4gIAkJCXBvd2VyLWRvbWFpbnMgPSA8JnNj
bWlfZGV2cGQgSU1YOTVfUERfSFNJT19UT1A+Ow0KPiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gIAkJfTsNCj4gKw0KPiArCQluZXRjbWl4X2Jsa19jdHJsOiBzeXNjb25ANGM4MTAwMDAgew0K
PiArCQkJY29tcGF0aWJsZSA9ICJueHAsaW14OTUtbmV0Y21peC1ibGstY3RybCIsICJzeXNjb24i
Ow0KPiArCQkJcmVnID0gPDB4MCAweDRjODEwMDAwIDB4MCAweDEwMDAwPjsNCj4gKwkJCSNjbG9j
ay1jZWxscyA9IDwxPjsNCj4gKwkJCWNsb2NrcyA9IDwmc2NtaV9jbGsgSU1YOTVfQ0xLX0JVU05F
VENNSVg+Ow0KPiArCQkJYXNzaWduZWQtY2xvY2tzID0gPCZzY21pX2NsayBJTVg5NV9DTEtfQlVT
TkVUQ01JWD47DQo+ICsJCQlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZzY21pX2Nsaw0KPiBJ
TVg5NV9DTEtfU1lTUExMMV9QRkQxX0RJVjI+Ow0KPiArCQkJYXNzaWduZWQtY2xvY2stcmF0ZXMg
PSA8MTMzMzMzMzMzPjsNCj4gKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjbWlfZGV2cGQgSU1YOTVf
UERfTkVUQz47DQo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArCQl9Ow0KPiAgCX07DQo+
ICB9Ow0KPiAtLQ0KPiAyLjM0LjENCg0KS2luZGx5IHBpbmcuLi4NCg==

