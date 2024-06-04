Return-Path: <linux-kernel+bounces-201069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF238FB8EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7CA1C2143D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075C01494D1;
	Tue,  4 Jun 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="dYxJjLCx"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2090.outbound.protection.outlook.com [40.107.15.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B5149001;
	Tue,  4 Jun 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518522; cv=fail; b=LW+GJfUd8vg0mAGvO3YShZaSSL5F/UYQuoEd54CE+8QHXGEP3UXpUOAmb0GCPRObKuzRcJnEEGMX/5cK8KtnMq4nUqvFQ6vwLVcozzazvimhmgQ4HMLfdi4vhQ6TeyVQl8+4Qji3+9lKGfS1wNJatKsZEpdSVsrmuuqYo9+Sfl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518522; c=relaxed/simple;
	bh=s+ep4i54TEfu+NYg7YjImWv2zp1PvOg4WkKc+FZ/XUM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c+4DtCBI/u9+8OP4KeRmWEIR9bJwtWNs/8ykLGPXv41Wl1FP0gEpKSbHAFc6kcrql9khSrehCyZHSir+eywKVropDwUoOvxJF0bFsHmtuSIXZOHx11pKUXFWC80vaGDuHS1LX0i+SLOh8RldcvuxB9j0bvYrB1UKiOtH/sR7N6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=dYxJjLCx; arc=fail smtp.client-ip=40.107.15.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X96jDsq8qyE5AvnlLqjQz1OVZ3/nUNyydFrb471ISofPeczxU9RrxRalVpESxu9VRLKKWaCchdJ9eUepwdgDAtBfLY+gMKI3KYdvFTMrwBBIi4kZurGefiBwXKjtmxLCMS7/FYzvV6oTw7zu86V3HY8DlfUwShXCAMhdTC8A/NOzamvQLhz5cafPFAp3HJRVAt83Tef3N1qhFWiVqeK1bMZ/o3VA+wHeIEUG94l1020Wdw7XNFLmfKoaaTvuxo1+o7U0bhyOqbi4SeX8rPGmZwTW8MJFBuLVlajHe/blJ11eS/HHzCNP4Io7FEgQuo7sFKRwHspoh8mmk8sXSk0Hog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avE6P4xXZ4OckeDwpM23qjS1g2VVqeERRfjh8Z+9u4Y=;
 b=TxzckldAwveU8W2YOjBjWveQXHu4nRo5S7wO6HQ50jFQmnrvlwi30JnXvGP5GIYgmPRnUqsUjdaAGaUKjfvx6Dbbsxo1ddPJLPUHKhJWI77OxH/6q9KNnqL4iRxVncTyn5wlpoFBe96yvYuE/rmsRIhCV0zhvEjkVc6ReSjLBjZS2l3rpyOAqFzpWkINhYqDLYGtnAEip8clJ62Uop57FBl3ulArfRBuVlcx8eI7oDDU1C4XhLw1OdiNds/lgkLW38cgZ8sXjYh48uQ+Kbe9saOSnGdRFS/bFtMQSWg7z2ciC9KoZUXO1/uiJvZyn2DyeJD6jsnWg1a7cCACdrR4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avE6P4xXZ4OckeDwpM23qjS1g2VVqeERRfjh8Z+9u4Y=;
 b=dYxJjLCxAFjh3CXQ5gLeeXD/ls3lAcCWu5Uc8yCObozonK1UsPN6oPDO0wkwrfQ5JlMLSaceS71pMt3st2LfFmLDpAWcVBsvWvgyr11Z8gs5urbUjPhEkrm8kQGYjvTG6Xtj6msYKHWqMLx5LOzLFElA19JoIdTBN2/5Oj4jqxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 16:28:27 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:28:27 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Date: Tue, 04 Jun 2024 18:23:53 +0200
Subject: [PATCH 3/4] arm64: dts: rockchip: add mule nvram/rom to
 rk3588-tiger
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-nvmem-v1-3-b784260a36a6@cherry.de>
References: <20240604-nvmem-v1-0-b784260a36a6@cherry.de>
In-Reply-To: <20240604-nvmem-v1-0-b784260a36a6@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Farouk Bouabid <farouk.bouabid@cherry.de>, quentin.schulz@cherry.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: e0253dbb-373a-44cc-1324-08dc84b35cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHZxRU1yTkxPRng3N2kxYVhMdmVLS0Y5YzUrV001QW9CRjJxTzlGYkdEcnUz?=
 =?utf-8?B?aTgyRWdnbklSMnFYK2ZPai81ei9NbXNOOGdhK0tQVDFROUVSTjJSYTYwRWR6?=
 =?utf-8?B?US9CKzczVXFUN05oOEY1anovMWk4WkZPTHdGMTFBVitiVDFGMktyMDAxSFVQ?=
 =?utf-8?B?Njh0NjNxRWwrZkxzZUVJV1RKbVJCWGh4bFQ0OWZWM29zWUFqZmFiUnk1TjFB?=
 =?utf-8?B?UDBZeFVBbHphakdzRE9oSE9ydXdxay9ScHQrd1Q2WWZKZzduMkZiNHRJcVh5?=
 =?utf-8?B?aXhpQzZ3SURVY0lKUDNEdGtob09rZ1AxT21IcTJyWGxKcjBkVCtGbE9jMlh0?=
 =?utf-8?B?dEZRaUx2S0RxaXpwWkJuWXRHakN4QjhGMTluakd2TFo2cTVJK2cxSUFwWkkr?=
 =?utf-8?B?VExROFpHa2FmT3d1ZGpQWXV1L0JhZ21qMUJ6TkV2dW0wYTZjMk15UzRQNmE4?=
 =?utf-8?B?bnpocUoraEovcDFvOStkS0puR1M4ZFV4bnBUcUN4alZzMTNaTmFyV210K2Y3?=
 =?utf-8?B?YjNGNXZlRVFFOSt5SjNFaWFZNXNsWXdsSFpDZUFWcHBRTmhhNmdrTytmMkdr?=
 =?utf-8?B?a1ByaCtXQy85UmVTOFNNOG1MUHlocXpDNXc3Yjh4UTdGZmRySnkxYzFyeUZt?=
 =?utf-8?B?bUkwcGRJeERwRlQ4WGtOMHY3a1ZuT05jL2R6bC93c3JoNjFKWGlpMU1IR1Vr?=
 =?utf-8?B?c2JFUGFZdnN4VGlUd0xZTVAyOEtXSG5kOXBCVWkyQmh3VHRHMW5ZMVFnMWNT?=
 =?utf-8?B?YndTMnhONnZONVRqeFVBNXk4QWNvM2R5UERoSG8wQkNOK1QyOStUTW5WUnp5?=
 =?utf-8?B?RmNSWUxEd1BpUENDRDA1OVJmRXV6V2F2NjVjUU5OaHgvNnhLbWlQUmRMaS9R?=
 =?utf-8?B?YVY5bkJVeVhYREtmRk1vTjYvWGdKMHpDQ1d4QVA4ZFExTkloQkZ5a1FtYW9m?=
 =?utf-8?B?YjB0SFBIS0lmMUxLY0x4NWhsazczZGVKYjZkR1JOOHBlTkt4Wm51bVFUYTNI?=
 =?utf-8?B?Q3JTMzJkTzNkWG9FbzFHeVAxOFZ6T0hCbldtOVV3L0tPUnJTS1FIVnBidEYw?=
 =?utf-8?B?VlVFZWNpRFh6d2pPZWMxYXp2WU1jQXhqekNQOGRyYjV1UEtGNGZzcldCbGZm?=
 =?utf-8?B?RXFhWVRGMUpLRE13M2tYMHY3NVFQMmhFRk1QcjlGc0hTM0cwZHBUczdMMnFV?=
 =?utf-8?B?b3o2OWRKTjIzWDBCVFNMeW9SWWhRK2Z1UE9CeC9uNFV3WURmTjYzSnNhQUoy?=
 =?utf-8?B?aXB3OHZnVkV6MWpZblNKL0hidVZRN0RwaEk1TUJZaWJMTnBMclR4UHYyZUR6?=
 =?utf-8?B?NmRMalFVR1o2cmRlenMvWFZ6eU5RdUZ1OElNS2VZT21nV1Zybzd2QlpoRko5?=
 =?utf-8?B?ekhkcUFEbHhuQWtuanZpdU1FNC9DMHJnMFNUZm9RU0FkSHdKeXVjRzFpdE9P?=
 =?utf-8?B?Y0Z0bEtYZVd5bktyQUR3OS8yVkpCU2RoTFM3V2FvVjNKMlNZNllwdjAwaUlZ?=
 =?utf-8?B?S1hFREpBcHRWVzBQOVJEV2E4TEZKdjQzY2FHN1NaZmhTTnZBOEhWb0JCRFkw?=
 =?utf-8?B?KzRadlRSemxZeW9FT3ltNHVaK0lnRDVqanFBcmRneG1IcCsyOUNvbEx3SzBF?=
 =?utf-8?B?STV4L3ZHSkY5TnBBU2lveDhJalE5S2F0cGJGTDZRT3VhZHEyeW9pcEdKTGNU?=
 =?utf-8?B?TUxITmhuZ0ZKUStRT1dvbUx3NnorZ3BTOFdnMFFKZnZEYjdWSXRzeHpBSXdX?=
 =?utf-8?B?NEZPMXU2TVJVeDByQ3l5ZFpTK2Y3NnNxREZWTVlYV3RqRlJwaXNXZldoZ2xX?=
 =?utf-8?Q?ptQr2EhHH3YBfPlpKl7m77OYrDq1zAl2+N23I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDdlYWxUZDYvL2tGdExnRk1obDhlQy9SK2MrMUdjWk9DOHptbE5WemMyZTlY?=
 =?utf-8?B?RExvVXNaREFnN1hmdXVacFA1M25pOUV3Y0xDbDlXNUpycWlyUzRya0pLUmNi?=
 =?utf-8?B?YVJ4dXdJWVVCMjc5R3BvRTA1c0dmbElnNi80Nk1BRUZCZ25zaFFUZWtKeHFO?=
 =?utf-8?B?YkdMVEFSclAwdEF0Vzk2LytUVXRpdndQRCtJTVlZQThnNFlmUUgyR3hvdzNr?=
 =?utf-8?B?V3NMOEJVUDhzcEF5YU1wTlFDQ1dVeW1qOUF2dTR5L3RTdFNZV1NjNnBBUWIy?=
 =?utf-8?B?aFZnRUFvY1RjWFA3WWRFRGFoY1U2Zi9qQWFPa2NsVmxCaUozU3VSd3drSjVl?=
 =?utf-8?B?WWlNU3FQMUxGVGR1OTU5TkVWU05WcFlPazBtVjk4dVRPTzdVanMwWGY5eFlP?=
 =?utf-8?B?Tm5mb281NWVBR2FSYnE2emRLZzZVSktVZ0szbVp6N3RvcTBWWksrOGxFblZ3?=
 =?utf-8?B?dm42T0duYzcyWE5qbzVGNjc5Z0hPaVduMlRMN0FRdG9OR3YzcjcweTN6WHY0?=
 =?utf-8?B?L05iREh3bzZBV1N3SUdDQlBtQjM2L1p2ejhFTXJsUVBSdldsUFNGM2U1SGR3?=
 =?utf-8?B?dzRzQkE5YmVqRnVQcHRZZkdaWVhBRjdMTk4raTBzZzUrY1RTSXFjdGlZT0Rj?=
 =?utf-8?B?TXB4RzhqU1NCSEZaWjlwajEvSEx6emdlVDR3THBkUVJ3UlZFMWsrMkhSZ3ZO?=
 =?utf-8?B?UWFuN0NFTkZRNmhDNXBQTXBYWW9yN24yckI3RTNvM1BNTzdjb3VhcENTU1dy?=
 =?utf-8?B?QnJLU0lCbXVJT1VmV0NyMkg5Q242UGMvOVBhelZFaWF0MFJpNVF6OXB5NkMy?=
 =?utf-8?B?bWhONFc1WVJneFA2MFdMMS80UkJKUnFZcUNEc1NacEVONE5LL3JhSGtjdmt3?=
 =?utf-8?B?bEFySjRkY3loNlV1b0g4ZEt3NXJsaVNreXdURHdBem1rT1dNa05iaE1Oa05i?=
 =?utf-8?B?dnlQelZNTGtxM2Z2Q3ZFcnlXd3FhUFcxQ01ML1RaNFVIdkp6b1U1Y0c5aklO?=
 =?utf-8?B?VHR3MlhvZHhMdE8ySUpGdHpHOHZTMmZHR1ltMTNsYjJ3SFh6RmUrQUdCVEc0?=
 =?utf-8?B?Wnk3cVFoUEx4TXFwT0pSK21Ibjg4UmFKWVNlL1NIQW5zU3lCSzk1bFNvYm5H?=
 =?utf-8?B?SjUwYnNaR3oreEZLanVXcDlwSGNFWkJPbE0yRkExWm5kYmJLTlZjUjdNV1dt?=
 =?utf-8?B?OUw3RVM0ZC9iZlJoM3Y5bE1lVVloQ2NwYXcydlpFdDlBRFdzelBBQTYrbk1F?=
 =?utf-8?B?YTNPNTlSQzdzZEhhQkV2UmpvK0poUFJVZzlMakZTK1BXODRNdFRtZ3I5Sk1m?=
 =?utf-8?B?Y1hJTml2SkFSaThGSmJuOUkxdXNRVXpkbVRvdU9xUDlvOXhIM3FucHBkZlp3?=
 =?utf-8?B?RFEzZTYvdEIxTlltTXJ3TWNub21UaFpjUk1aNk9ZY0JEYzlCMHVvdVBZTDJJ?=
 =?utf-8?B?ZUU4VWpGUXMrOEhPUHlIUjlpTFcrL0pHUXgydWZMN2dBamlpUDdFZENwZlll?=
 =?utf-8?B?WCtGbkV4REljTGJsRkNJTjJYYVhRRkxoamIxMGE2dFdzaUl1Z1d5NWtVWTcx?=
 =?utf-8?B?ZCtjQWh1Q3c2aWZNWHI1V21YVnNMamx5b3N0Z25IU3czS2NiY1BSaWtON1JD?=
 =?utf-8?B?M3BMbDZ4aysxa1R6N3ltNGkwS2R1VERaY1RvN2NlWU1kVFkzc01CQ2ZWSVVE?=
 =?utf-8?B?UE5OQm44SGJRZExIb1BlcXF6dDBKNkg5ZVdWSjd2ZVZqa1FxZzN2eU1LYWh2?=
 =?utf-8?B?eFhwUHNJQjMyWkZYQzYvb0ZQdmh2eVZVTU5lVVJPNUEwcGU1ZFI4M2pnUzJy?=
 =?utf-8?B?bU1sVkRBeUQycXErRDFDMXg5L3lpeUFtd0xPc28wRThqbXJQU2NMbkhibDJN?=
 =?utf-8?B?Tlh2TnpvVVdaSksrcENjeTRBcm8yb281cFZuaEdaNUVNY1kzcmRJRnNkQ3l0?=
 =?utf-8?B?MXh2ZDFCeU0zOERzWERxeHNFbGxNMWw5aWN0dzRaY2pOcFVicHEzdFVaQXBJ?=
 =?utf-8?B?M1ByTEo0dVZkRmYvbTBzRXVJNExEWG8vRTBGUkZ1a0p1OExYZzlSc3laTWdT?=
 =?utf-8?B?YzR1RVRTUDUxVkdSdkpSeHR3TTZ3MVZ3bnBjRWlQU2pZeDRqQnIzWjZwWWRi?=
 =?utf-8?B?c2RzTk5HakMxNitoVGl6eE1oYTd2Y2JFQlJINXVheGtHejNmK1lyNnZYUTZn?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e0253dbb-373a-44cc-1324-08dc84b35cbd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 16:28:27.0474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rj1miQM2PTX9py9Ja4Ruu1Fo+UvbqqotSbqdquJ+P/EjhV4I5asBQG50kbi2gxRbI19QMufzN6iYS+PYXuht10Df5PNioN1QX8MrIvXMNHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893

Add mule NVRAM and ROM on the Mule I2C mux (0x18).

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 5ed7d51717bb..7418bf86a618 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -13,6 +13,8 @@ / {
 
 	aliases {
 		i2c10 = &i2c10;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
 		mmc0 = &sdhci;
 		rtc0 = &rtc_twi;
 	};
@@ -228,6 +230,49 @@ fan: fan@18 {
 				#cooling-cells = <2>;
 			};
 		};
+
+		i2c12: i2c@2 {
+			reg = <0x2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@18 {
+				compatible = "atmel,24c02";
+				reg = <0x18>;
+				size = <8>;
+			};
+		};
+
+		i2c13: i2c@3 {
+			reg = <0x3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@18 {
+				compatible = "atmel,24c02";
+				reg = <0x18>;
+				read-only;
+				size = <32>;
+
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					mule-variant@0 {
+						reg = <0x0 0x1>;
+					};
+
+					mule-bl-version@1 {
+						reg = <0x1 0x8>;
+					};
+
+					mule-version@9 {
+						reg = <0x9 0x8>;
+					};
+				};
+			};
+		};
 	};
 
 	rtc_twi: rtc@6f {

-- 
2.34.1


