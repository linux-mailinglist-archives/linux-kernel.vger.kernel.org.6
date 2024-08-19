Return-Path: <linux-kernel+bounces-292581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48841957173
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE8B1C22C36
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5818951E;
	Mon, 19 Aug 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UBJsaj5W"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948F186E25;
	Mon, 19 Aug 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087009; cv=fail; b=dO6hRTxkjHn+w62NXVHq63ChB+XkoarXy5n+GList+tl6U+T9j2VL0u4BJmDQVChFxqmRPM5DSK2PTD65JHPJQaFRfUTvJF9ORJL6vSonz79nGhP9bLZHSGNPGI0wnoEqUyHN5zgC9QtilUtsD/6cf1cUSIsEFf2j5A6nFFpyaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087009; c=relaxed/simple;
	bh=m4NtZM9VIsyOSkEc+ihuv0N1hab5PfrvW2fXPh9HBDg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c9hJL0UNkUBiSARdiFbimlcv+2aUKeGkx1e+jHv7C1mfKQ5JolnfA6kWfsE1geNRQDInR2DTcug4mqeDkKAnzabjMwRsZI2KSCAWYic0BtFDdPX1z7ncVYZI2EoKHcBz32Q+mwN32PyaDcWTTQTxSqH7pAHTXxCIp3wepqA/0nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UBJsaj5W; arc=fail smtp.client-ip=40.107.249.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npo9EfQQ85Nzqhrom4lAgB+F6CsQ+4hJJsmltGvDbApp88zOwAf+pxSHj1LLc7JqVEwxeM9NiXT/rX4NBFHXRUt5BJ8kYpuDg0JQrSivHX6I6vSkjxaGIheVUg023Nhpn+VdMl6PefSLhTYd9lTavli57IWsDfQD61uOkgSjHdNXdlMyQZLIw7ttjXBWg/FYT9ygsJGegQ1HZTrKMSq6rThPwyOB0GqwHZeyTp0O783GBBtYk1T8G1MStcd/0qv8YIJZ00XA4akj59NlKS/veYq51+bIo6CrQ5Mg22JHXDI1NPgvrfzgfaH5a9wiTOM0lYBM65vx6Aqu3/NAWjSRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1oKzcpmSp01b8zMrdBx3aljJLB8Bdc5BaB94NrLfgU=;
 b=TfZRSfgOj32IdmpVR9tVbc+dtg6FEeJhnmdZ8bkBgYlhnUPO2NAx3q1cQBa7PUzgor3wwyKIW2M7FLXZTo7SqvUKwEwi9SyWMs0ZBd2Qll5gHEz3nKfT8BcvKsWPUUC/TYcCkRcYOKkEmXDcR0DPgGn03V46OMcsArWmjwgOzS3gJlPwLktegV0fNSq0MLlSuECMxLKbYM2nBENoKG4roKnmwLOVSSM5hZUQgN6QA3S6kuYO0IKf++kO+1uKkBsGNEziyBJsWXTE/7OcttUXtHmEH0e2aeDJB42ZMrRLFtWX4HXxj4thE8VJ5ZdcWlMAX8Cu2XftxwK/WqpNi1bU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1oKzcpmSp01b8zMrdBx3aljJLB8Bdc5BaB94NrLfgU=;
 b=UBJsaj5W4VDQWVzSrP1wwN7Lx8DTuBE/CO78C7XAsMhnKzyOYncf9Bpo5RIdAixpgGhncjx+NDFb+AeAV0RJulHUjrTlw0OW2YA3KzvW4R3tXAlc1478m/uDpmT6U+Xe0A5z6rbFaUTRKlkNAvKKNGpWc4Sl48dvpp0wkjAWZ1v9hpCsCnN8LjXSVUYgrRGu2XAByg0tZ9OBqiH8ETbq6pD/oe9p7WvH4R2cp441ml2nPz/1KfUkn/gv/sSc9nSrOdDOqtqYjxaL4Dmxs2SfH4WXVlGPSjrfxeEHh6gANhDVncsODUmQJa5eU2eBtuvBPItPJtowo+6dnXDHw12ceg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:14 -0400
Subject: [PATCH v2 05/12] arm64: dts: layerscape: rename mdio-mux-emi to
 mdio-mux@<addr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-5-4c428bd11160@nxp.com>
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
In-Reply-To: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=2156;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=m4NtZM9VIsyOSkEc+ihuv0N1hab5PfrvW2fXPh9HBDg=;
 b=z6f7c9clYizls7mOSCB9KRlzYApxYQYZzNEfL13+c5tbSF7rRyoGYgs4fm6buOF+gBoT5sXRx
 bTvr+3OzkEkBSvVh2vZrdwIq4creN/yupXK+z3fidCCxffOpxJijvhL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: cd14e503-21c4-4879-1315-08dcc070d67f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnpGVDFOdENRYnpybnpKRXJES0dFZ2JJalIvOTJkZjRvZjlnVU1jVjlSSUgr?=
 =?utf-8?B?bFZ5Q3diOHdSc0hxVUNPazdIWVlUMEU2RFo1VXZNREZYcG1mV3FDVVpKWkJB?=
 =?utf-8?B?eGhuZ2VzTldrSVZISW1RYVExOFhQMU00eWx4T3VJZ2RPNk5seWhYTHUwSVRL?=
 =?utf-8?B?dTloT1lVS3ZsN2hJT2dRRjRzN3N0cnR2OU4wM3RLWVIvWlp1bGh4b3F6WFdR?=
 =?utf-8?B?MTVxSUFXU1BmRHpxRXBzN2srMENSRGZCMHBKZ09SZ1lPNG9TQVAvOHg3WC8v?=
 =?utf-8?B?SlA3ZmZHNHg2b3h2T2hHNmNDYU9LK0J6UnVVdnpSUjEzRnJuVldZUGpDS0JJ?=
 =?utf-8?B?N3NvRk1uUTlnNjZEUHpDQjdzY0IwQ1gxRHE3M0xHRHFsaE9wbEhnNmE5Q3Vw?=
 =?utf-8?B?NVl5a012R1paUWl0bUF2NVBYUldEbmo2UTFpOHAydkZmczUxZWJVRkxiWjEv?=
 =?utf-8?B?eURUeHlGNnNBdlVCY1RFSmxGMXg0UzlTSFVCWmtMY3l6elY5QWZ1T003UTlI?=
 =?utf-8?B?Q2NNbFdJVDMvcHkyVWxkQXQ0TnVFdWZIYWpqRUwwbHdRRzhKRU5FaVExakN3?=
 =?utf-8?B?WXhwQnNFYmtqdVhwczlSWktlZHN0VmVId0ROcktRV0NWdkcrV1B2eDhHTVNI?=
 =?utf-8?B?djJzc2dEMmo4SmNZS005aFpmbDc3VDY0ZUxBdGhmZEdLMnQ1bys3RHozeGdY?=
 =?utf-8?B?SnpjRXA5cXYvdXYvUkFtTEU3SERnNzQ2dGRDWWM3SjFncXNYQ3RxeDJrbnZ6?=
 =?utf-8?B?WkFTY05OTjdIbC95NGRvV05SMlZsNXlTUnd2ZllOTGUwTzA0S3NjdVRrRFpT?=
 =?utf-8?B?cFowd0ZTOWlKVGZ6N2xWOVVRbFJ2YkJJY2hnQXdUOXlVL0E5WGlvVkVMdEEv?=
 =?utf-8?B?TDRheGk1NFNWTitRVXBVS3ZHYko4bXVIclIwOHlmVmF3dkNXd2VJTTFlRzEw?=
 =?utf-8?B?OFZzclc5TmUxNzlFbUJ2VzF6amtuNUVVbXBMVy96MXNaWU9xeFY3WEpjbExa?=
 =?utf-8?B?Y1hndzNtWlY1SWpNY3d1dnF3WC9NRkE1QkxYOHFSREtDRmlHY04wM251emd5?=
 =?utf-8?B?cUlWdDlhSmFDOXdCQURqeUNENHQ2ckdSWDFNTG9Pbzdtci9ndDUzVFRkZVk3?=
 =?utf-8?B?dkZ1S3duQjBSV3VWZlVPT1JhbEhOM3laWExTME9ZV0x5WXNWeWprRi80QmRx?=
 =?utf-8?B?WSttTElyN2pXM1A2OTUrRkhJRDY4bmd4cVVKZnVzL3pncm9rd0tHVVdrcDJy?=
 =?utf-8?B?T215VU5kUUkwYXZqSVE1WFhPeFNjcEFaNjFRbE55Nk41NlBjVHpGSDdUb2Vp?=
 =?utf-8?B?RkZ0U3R3dFh6bVhsWVlZcm41T1EyZVp0QU9WVjRVUUtOUVpVR1JoaEVJdm5v?=
 =?utf-8?B?aThsNU5IUFlsbVorVzhKdlJiV01lV0Z1YmJnOTBTVEw3aGU5cFdmTFdZWXZD?=
 =?utf-8?B?TFBRTm5FUE9sYURXTWFCNHZRS1lDRlQyakIrYzZTSWQ3OTdnZis4VVcwcDJO?=
 =?utf-8?B?a21zYWJVYUZjdVNtclpZd1d2alRTd0VVWVd3SVJIVUZ0bDlKNjNMQ2ZteWNp?=
 =?utf-8?B?ZFZIbVFjcTVyVTlwYjZyYUR1WHo3anZzY2lKK2IzOHFyenUzVnZ0aHUwVW9D?=
 =?utf-8?B?R0V2enNFQ2hUdEdzRWw3V05TbkxhQ0hkeFN3T1ptNU9CRDJYVlFaRXJ4bmNK?=
 =?utf-8?B?TDlyQlNjQ3dLM1F0VWtRa3YyZkg1Mkt6eC9DTi9zNG93SjIvSjlPSjErc2JT?=
 =?utf-8?B?K1daSUFKakMwdWVJcVRxd0xkVjRZZEs1YlB5amZqZ3RvWU1QRzNEaWg3RUMw?=
 =?utf-8?Q?Ccns+UsBt2gBo7gGUw2TtRVjLqw6WqRV9mfxM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTQ4U2hNR2JlNzR4TlNIZnBRcFdwenkvRnZQZDk4VjhpSUJsQ3RXZ2E0TXhK?=
 =?utf-8?B?WUdsVnhwMTBIMWYwRUdCekRkUGZLUERHeU9Xalp2SW5XNHFUWEduZm9IQ0VX?=
 =?utf-8?B?T0JTOXpaSFpKUUcxV2Q0YkZ0L28yZWNGVldTVGtmaHFEUHZNTnkxVEcxSVJr?=
 =?utf-8?B?b1UzVmJxbGdlRHB1RytETHJJK0Iva1FGN2NTNFpRWEtka2V4L3p6WktieXZn?=
 =?utf-8?B?MlFVWVJUejVZVFZNTk9xM1FyUjlVSFFmMmJrVk1IaHJITUVyMGN3SlloRTZp?=
 =?utf-8?B?RHNyWjh1YWt2aHJHaWtMRStkdGZUdTdML0FjeUFEcDB1WHdwUXB2ZkVyU3Yz?=
 =?utf-8?B?MncyWW9Hak5OYWxjK3p3cnozUVY3cHlpTkYzeFZmN0E1a2FJRUQwd3h5M1M5?=
 =?utf-8?B?SmlPMTFtcnBobGNlSUFBSlZqVTVuMlRnTTErandSeFhyeGFmc3EyeUczZUJU?=
 =?utf-8?B?Ykh0SkdiMFBQaktQSFVnUVVVVGFiZk5DZWxqTzZFTmowN3g1NHJlb0F0cSt0?=
 =?utf-8?B?NGt2c3ZOeWlmUTRrdkRITGlPekFXTEN4bytDVy9uK2ozNjlZWEM4dkd3am12?=
 =?utf-8?B?UEVMdHNzblR5VlYzMXVTb3BPZmk5WWhROHE0ZDNPRzRBQzA0NkNpZVlkcTZD?=
 =?utf-8?B?dVpRU1pzdmE0Y242RE8xWWN0WTlVNU9CS3NJU1orK0o3OGZ2aDYyZ1psYkxy?=
 =?utf-8?B?QithRmhjYlMwbklTckJ3V2x2a0xqenoxYVF5ajFiYXFWMGxwNHl1ajh3bTh3?=
 =?utf-8?B?NHQxUWVMNUpqSGc3SDJ4QVVIS2VDaGVVZThsRXBnb1VjM05hc3hBdVZ5Y040?=
 =?utf-8?B?WVpuL2ZXQkNHQjFncnFCeXdmc1NKNXNsam1nczhKdW01MU9LRjh1SlNOY1F5?=
 =?utf-8?B?dFlKV2RlblBXZWFYa0NIRE5EN2lnalU3Tnd2WXVnU3ExZWxFbFZRUC9rMU9t?=
 =?utf-8?B?YjBnbXo0alZlWjlGdjEwSDdLZEE3dGRVblJMTmFkd0VtZHJJMk9ZZHJ3b3Fw?=
 =?utf-8?B?NnVqR0twWkZiYllMdlNieW9KV2tzWXU4RHNUQzF5cm1DVmJ3eWExbklEN3d0?=
 =?utf-8?B?R0xqd0MvS2xzTHVMQk9Oc3VQeENpVnVJeVBBQm1adnhUNXBQZ2ROeC91bTZZ?=
 =?utf-8?B?cVNzVVZJTDhiNnoxWThQZDZITHliK1FzNVlVRzVTdjIwMUdsQjZrVVREaDJT?=
 =?utf-8?B?VW9DM3VIRWlWYzZxUnlDNWZBdzdic3NEeEhaV3QvbEEycFhkYnh1VEVtTzQy?=
 =?utf-8?B?eFUvSG40SUdhV0NZTGxwc3dBZFRTU0NwMjhINzkySzlkODVVRDQ4T2Q2eElZ?=
 =?utf-8?B?bmVQQk9IdElWdFNzMlFBaXNCZU82bzJLNTZPZzZIT1VTMDRaR0hLK3FQZE5Y?=
 =?utf-8?B?eDZpNTVhWGZjQ09lZDloZnZ0bWI1QkpmL1kvSHEwcUhjeUlzbzFHL0Y0aDJT?=
 =?utf-8?B?YktkSnBVTTRMYjJFbzVhYVpZZS9TSlFYY0FwTHU5dEM4K3NWZWJSSXlXdUpw?=
 =?utf-8?B?QkRpSVJxN1JPQUZlaXdvQmdwRXdMemhWVEttRlQrSVJwZGw4bTJJTkU2QmJu?=
 =?utf-8?B?bFNxMVYzcHlqSkFQTkJJRkhaWUczZU5SWStsVGIvbGxpckV6SGUyemI0OC9Q?=
 =?utf-8?B?a3JhTEZDOU1GMUx5c0Iwb1VWYzJyVWZoakVoaXQ4WW1vTVVib1F2UEl0ejJ0?=
 =?utf-8?B?UlBFNGJieWFQb2I3cDNKQmd4WFQwdEhwUitNeTErWlNLZDBYL1Z6WnpyQ1RH?=
 =?utf-8?B?OXFDcnRVVGFzZkFhTjE0Um9MbEhaM3IrbnVpUDFidkUzcGxULy9WbklROFYv?=
 =?utf-8?B?d0J3enYvd0wvMkVaS3ZEa3EvNkYvNkhjMDR1KzVEa1hpcHFTS2ZueFBIejBu?=
 =?utf-8?B?OXExVXlBeUtSQ0Y3ZEZjbHpqOHU1Y0dPM1VKbTVsUk80QW5lRVhaZkFrcFlO?=
 =?utf-8?B?UjR1TXlzQmc5eVhqcG02SHdUTkh4QWNybEhNZ2k1ZzN0UWllNFJsWldmeDcy?=
 =?utf-8?B?QXVlVUpEdlEyWUh6TkdINzVXT2t1UmN3Mi9wc0FRQzd1OVl3b0I3eDgxclRz?=
 =?utf-8?B?NkdnazVRWnkzeWlDQ3E4bjU5L0NVYk1ubFRmYkdPNGU3RmV4d043RXNONEVu?=
 =?utf-8?Q?2nwXtJqod15A/7wLhcWx5v3Ht?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd14e503-21c4-4879-1315-08dcc070d67f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:24.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR6sppYGrDLOkdlrgMsLLTrhnvpQrDjCazaqTAgP8mVITcSQFL6oj/UfFlAk+ELq98FTXiYDN6dsa9Vf5dsSrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

Rename node name mdio-mux-emi<n>@<addr> to mdio-mux@<addr>.
Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dtb: board-control@2,0: 'mdio-mux-emi1@54' does not match any of the regexes: '^mdio-mux@[a-f0-9,]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/board/fsl,fpga-qixis.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 11b1356e95d5b..e850551b16acb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -211,7 +211,7 @@ ethernet@f0000 { /* DTSEC9/10GEC1 */
 };
 
 &fpga {
-	mdio-mux-emi1@54 {
+	mdio-mux@54 {
 		compatible = "mdio-mux-mmioreg", "mdio-mux";
 		mdio-parent-bus = <&mdio0>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index 25eb1d5a69381..736722b58e77f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -237,7 +237,7 @@ &fpga {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	mdio-mux-emi1 {
+	mdio-mux@54 {
 		compatible = "mdio-mux-mmioreg", "mdio-mux";
 		mdio-parent-bus = <&mdio0>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index 9178cd61c7869..556d8c5f3180a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -64,7 +64,7 @@ boardctrl: board-control@3,0 {
 		reg = <3 0 0x1000>;
 		ranges = <0 3 0 0x1000>;
 
-		mdio-mux-emi1@54 {
+		mdio-mux@54 {
 			compatible = "mdio-mux-mmioreg", "mdio-mux";
 			mdio-parent-bus = <&emdio1>;
 			reg = <0x54 1>;		/* BRDCFG4 */

-- 
2.34.1


