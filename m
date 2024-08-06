Return-Path: <linux-kernel+bounces-276456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF3949402
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153742847FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BADD200129;
	Tue,  6 Aug 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="jMBW/v95"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2097.outbound.protection.outlook.com [40.107.20.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD517ADF2;
	Tue,  6 Aug 2024 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956273; cv=fail; b=LrPwEgAQo4d9ry1QTdUuCaxIInSx2/2AltPkpSBt4JVqFVNzN8J9EkShjAlZrTdwzjhGn/h12f2vEmLxPSXJS7NBN0y+9JUi5ToZ9qTZiUDXfTTPEJOkpGE8cql6lPPqj+Fd10SKfG66S1uUEMHsf7zP/E7nDk31W1eX217pQ+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956273; c=relaxed/simple;
	bh=ayYrrZj0yfujAJNjGWXK7AVmJURhZZiY1OTkJxz63Hw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xp/QgCEmeuDZF4uRowux7XeSgpefvV3k44VDmjKof3HRdkJxVDL35/lGMt1IAYDcSDiFq0PZcIfaWB7hM5xb8nU9H1s15fEF3Z5Zr/+p7AqHXowt0tlT21zsNEFWj0syCjtG4MSKmueAuxZaM4bbfErZHe5Ri/2T4dRBQnWpfoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=jMBW/v95; arc=fail smtp.client-ip=40.107.20.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sP5F9jbIUfjeFelz1+h+6pqkjvojfs6XumIlBzuB5VhkwY0q02W5ADUUhxq0VKg+RvtRqN6dDNoql3dv6Qf/RuoP9M9V2Xk3gSxwfgD+zvHyxvFwQeTeV7Fsy2YG0ekiJI5JbYFpW1uT0TUJFjbzwMTRUm+1cMU/k5W29t3/w/hNO3kV062qKm8QDSutmjecOSdSkR0X9DNT5XloG57bgvNGwUZaqtUovIWgGpRS5OVZmKFVfsbObCR633h07mgo2MXWBeFapN9/TOUXMGCzGkK8US0JuAx0DD9npBcO2mvIs7Qu/sZGjVMAA5dg2qYVcLjrE5a1SN3SNP1XPLQD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XJbODOUWabd+wXSx4GWXHTOUHyedduvc2QSEMM8lOI=;
 b=ZhpwVlGSEtOywpgIUdZhMDyClvXw5KkOdwHlyfPZsTVvxg6r+yW84Hp4NqwJgFZid2hp15nQ6WIMXP/OT6Gn+fUv1VoU9b0uK3qE6q6bcbtGjuZBTTmxiX+PM9EMaYsToKCpGYuKKA+I4P3D1Yo90t5l4UOYeoxhw0ZfWUtt7q0gz51dekH3Jq0UUrmRnetfw5vyA+A50B6KCdQFUhf1k1pIarPPGJpJIIucwP3AGbyzmSNRMsRnRsnt6ElZaPK5YYKrUDxhPx/LZWN1I0eDuSMp2kt99QpP/3pDpDy6X8pxPhptZpyAMBQBaphvURw+NN0du0mmcvS655A0KmXjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XJbODOUWabd+wXSx4GWXHTOUHyedduvc2QSEMM8lOI=;
 b=jMBW/v95FWsrJALKYUNttqyXaK23HeYX29SAYh8aVoD00wl5FT/ZErA8IJRYzWt9y015+pTkqew5G6kAMMvNpKeqiEkJLnxpVahe3VPODi3c8TN9kXG5tNgntb/D6vGGXRKmnSSTH2qNqTawlinBv4ZtXC+v80tTF5R29mdVUAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB9PR10MB6548.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 14:57:44 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 14:57:44 +0000
Message-ID: <1615dd64-5daf-4832-9e3c-4a3f5572f258@kontron.de>
Date: Tue, 6 Aug 2024 16:57:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: Add support for Kontron i.MX93 OSM-S
 SoM and BL carrier board
To: Peng Fan <peng.fan@nxp.com>, Frieder Schrempf <frieder@fris.de>,
 Conor Dooley <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>
References: <20240729124450.118497-1-frieder@fris.de>
 <20240729124450.118497-3-frieder@fris.de>
 <PAXPR04MB8459728C46300E5507CBA6F188B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bf41ac18-f9a0-4d6b-9b30-264c9c295d35@kontron.de>
 <PAXPR04MB8459B99A43EA08ADED98DEA788BF2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <PAXPR04MB8459B99A43EA08ADED98DEA788BF2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB9PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: c65fde25-b6cf-4109-3302-08dcb62820b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmdtWWVBTDExdnQzeHRkVE1BQ0o2NTVscnRsOXVDY0trLzNUbkNTeURzc3dI?=
 =?utf-8?B?RjRSRU9COTRBQ3l2L0JmTmJsYWtsaFhaelFCdy9HSHoxUHAyM0YvL3BFM1Qv?=
 =?utf-8?B?NHNzVEsyMG1tQUpSVk4wL1F5RW92N2w4WTNWaHdPaFNUVkFJcU1zcWZHRWQ0?=
 =?utf-8?B?bjlGUXUyZHFlaDJyK2UyaEhrdmFXSkhJamIwdDRVb2JjU1VoSzZ1bXJtVHV3?=
 =?utf-8?B?OHF6WjIvSExnc3hha1YzM2QwM25RZ2hmZGFFT2FLdkdZbzdMWldVMU1ZY0d4?=
 =?utf-8?B?Y2txYUlVVTZHakJHM0dmWEl0MVFzY0cwMklwUUVLSzhKNzR3TS9odTMwWFNF?=
 =?utf-8?B?NTAvTE5iR2N0cEp0Tmt4S1NTQ21rRlVFZ3AvZXhiWTNTRml1dm1BTjlUcVhN?=
 =?utf-8?B?VkZGMlh1eG0xd1c2V3Vjb0ZqRWxCYk1zeGd5RWxPT0Z3ZGZ5V3RUa2RxYzY4?=
 =?utf-8?B?QXNDTmVIYlIvcUxaa2ZQZlBFQi85YkpvMmtqaEo5LzMvUmhrTU4wemJzaFVO?=
 =?utf-8?B?Yk1sbThvNEptVW1ncHFsYlJKdUF4cjk2cGdWaWNqR1pHT1BvOTlCUjRuMFVH?=
 =?utf-8?B?OFcwN1NpRTFWb0h4TzQ0OUpDaG1FU0VlWk40cWlBeFlDRlltakVtMytzb2Z4?=
 =?utf-8?B?Z1FIU01jZWlUMll0NlJqZ0hrWERsSU02YkZ6Y0pFRjg2M3lzTHVGWG1OM09I?=
 =?utf-8?B?WlBtMGhiZGplTWNqK0l6STlVR2lCS0pmVWY1TVFrK1g1eXlGakdvVDJoR3Ir?=
 =?utf-8?B?bGVvVm9KWEhhVHdYdWpOSG9Fb0FNRTRaazlldDIvUk1SNSthbDdSTG12aHN6?=
 =?utf-8?B?eTJYdjFsUHFyRGdjZjQrUUhmbGpDdnJQeStQN1JJTmhyd2lDL2orak1xbmx5?=
 =?utf-8?B?eTRNcGxDczF0UFJzUVFqWUFjalFKUUthQldzZC9PVkMxVmRCeTFVQ3loTEt6?=
 =?utf-8?B?aVNQUUdWMVdOQ1dnTitISUZlem5KVHEwb0RWVlpiNTFneUVCaW9wQ0RXcWZw?=
 =?utf-8?B?MDhzb1VKblFLdFlkMy9hVGNmU25ZOFBuSUtGbWZ6dUsrS2MreGR2OG5PNUk2?=
 =?utf-8?B?OGtSWGMzM2I0WndramEvN05vbzZJUTVoSS96SDdLemtsZ0w5NjdyOE8xRkdW?=
 =?utf-8?B?VWVBZjdFNVp1MlovQmdRckRDWDdNbTR6Sm9vUUNJMHYycWt5RmNOcXk0UUhn?=
 =?utf-8?B?RysvZEpIQzlMa1E4aHViTkh1dEJJaGNUSktzVTltUlA2bHRiMStWdDJucTBv?=
 =?utf-8?B?WXZRajBrdVVYVVI3TlpONHhGR0liL0dRYTI1TWN6Y0F3ZlZDWExSUGlXUjRP?=
 =?utf-8?B?cWFyaitRRzlGYXlUbnVoVVVRV2dROFVtQXpONStJbzZXUEZRWWJyTnE3YzM1?=
 =?utf-8?B?WlJhMEJ0TzZaSmRCRjlNSkkyN1E5YWszV1V6cUJnV2RrcW5UaTRSRk9rVlFJ?=
 =?utf-8?B?Z0tRd1ZqQUR3dFFRekVUbGRZZ1kyK0xVWFJtNkxDM3Bpc3NKRXpTZTJaVGJX?=
 =?utf-8?B?clczQjBHUkFWM015RDRTS3lCcURFRUE4K0FmYzRLS3d5SWppd3lVbksrVTBS?=
 =?utf-8?B?b3ZnWFNrelE0TjlOZGJlUmFHZHQ3WVR3VmdXOG5BM3hJRDlneEZ0TFF4TUYw?=
 =?utf-8?B?K3U4U3lBZkt5RTJQTjd4UGF2OUx1M3kzRXdZcU9valRHQjVqMEVJaDhoVWo2?=
 =?utf-8?B?K21neW5GSFFLb2hhbDNDWTVHclVUZWh3M05GbWk2c1JLNDRVN1NSbmVGVjR0?=
 =?utf-8?B?RXZudi9YQ0RGUU1SLzZpUXVYZkxlVHJweGJXOGlCUjI3cDBvRFo0cmZEMFY5?=
 =?utf-8?B?ckNpbDVxSE96T2MrQzJYZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3E1Q1ZYR1ZtMGUzWXNuSHo2STNoZ0piMEZXeS9ZVjVBc1BQSkQxZW9IOENh?=
 =?utf-8?B?aDJncy90QSt0NTYraVQxYkk5c0JWR0RqUlo5czVQZEkxb1M5RXRiTWhlbWNJ?=
 =?utf-8?B?RlZpYTV5eDZscENaWTlOaGZ4NHROWlNPb3hscjJudTFOcStoY2FmK2N5c2hi?=
 =?utf-8?B?S3RmRStHL1BsVHM2Z2Z2MWh2NndDSThXb3Q0NjRvU2tDbHhKR1dmYitYVTFU?=
 =?utf-8?B?eGdiZ2h2czdhcEZvNTc4WTNiWXl5ck41eEZDZkZUSjc0OVJwL2trVWlNYzV6?=
 =?utf-8?B?WVYvNXBSTWFNTnRoUUpsazBHbnpEVVhKNFAveGJPK3pRU2l1aS9yZUppaGdT?=
 =?utf-8?B?NkxTYlpiaVZNL3JiajdqMmJRS05Yb0hFcjVqOWFVdStTbFJqejBEMVY4ajhF?=
 =?utf-8?B?QVh6clEwVHA5QWhkZUwrUDhkZ0lTTDIyMUt3YkcyU0JhYWgvdEk4WFMzWU04?=
 =?utf-8?B?TjIzS0JjZnhQdHJGMUNFYzM5WEVBYkZFN2VmcUhjaW9MeVo2WnIwcG52QVNy?=
 =?utf-8?B?VzZ5Vm0wOTh1eG82VlhocW5mTHk0NzRlNUpNVEtEeEpWZnZZQ2dvNFpYc2Fh?=
 =?utf-8?B?MTJ2UGIrT1VnVm16QUNFcTdhb3N2ZERPM0p6WFRvTEEwZzl1NWlhYjdJczBJ?=
 =?utf-8?B?UzkzZUd5TmZvM2N6MlJtT3dSSVVmOU9BaTJGSXh0UndmSFBWTGswUmg0RzhE?=
 =?utf-8?B?V2lpMUo0NWFuY0x1dmMyTWkvSGN0WTkvTUxLVjdVRm1Dcmg3RmlNckJOUkRF?=
 =?utf-8?B?VGhqOEZhRXFSOUVNbVZKN21NMGJGYTY1VWlrTlNiQWJjYTgxUTAweVZxVFk5?=
 =?utf-8?B?N1RyWHNVQVJuNHEzY0RWRFBUYkN1aGJ1Y3EyTGtqYWoyd1Y4UmkveEwwSkhD?=
 =?utf-8?B?emhRaHRQeXFtQmZiaTlJN0Mxd0JwemlyNHZLa0taQVBRRzBvcGdSYU04Ry9Q?=
 =?utf-8?B?aWtHMDRhWlB2aWpXa3ZPZXpaQ1FBRWs4czVJNGRpQzZGaExYNWxFSWZHTk5x?=
 =?utf-8?B?R28zWkhsbDMxajk0azQ1RnN5YTlyTUY4TFcraWJ1WExmQXZ0UjJrWk81Tjd0?=
 =?utf-8?B?UnhRREFhc1JyRGMyMzVMaXNyblB0dHBPNjg4R1N0bTBKckpyRmJmOTVmMWgx?=
 =?utf-8?B?eWdyOTV2MUdVNjREQ0trZ0xrSnVOY3Nqc2tNRmFLa2dSVHRNRzQ5Tk9VU0VJ?=
 =?utf-8?B?cGM4L1lKRmtpZ2xEWDFLK0laVTNrb3RTSDJsc0JuU21EK3R5NVJ0UnZtLzVw?=
 =?utf-8?B?RTBJa1duTkJPS1QzRE9iTnJZNk9hVE9jZ1NvMXFkOHRuVy9uUzNsWXVGRDdw?=
 =?utf-8?B?Z1NBeFN5UTNsRnZLN2lraFBIQTVGV3Q5RDFrNVlFM3FGZE9jN0JvSkxFem5I?=
 =?utf-8?B?eXluTGNtbmw2c1VUeTRBZ2ZOSTROOThTVXZudTh4QWdsZllJeDFhbXBiUzVz?=
 =?utf-8?B?WGFYOXVxM1JKalplSTQ5UGtQekg2aXRLRy9UTnJzWEJYWTBSNElCd29tRGla?=
 =?utf-8?B?MW1BdVpJR1g1YmdzcU9USEZLL0ZMZmMvdU8rZ0p5YWgweDJxaXcxK1dWejRo?=
 =?utf-8?B?Ync0NXcwSnp5ZnVNekJJOUt4MWM5V0dpak5vQUc1R3dMQ1lZQW5GWWtBd2Vp?=
 =?utf-8?B?OCtocnJlODJGSm9nTFhrN2FVdHdZY0FYQk4yakZTTURKTy9jampTMlYzWU5t?=
 =?utf-8?B?OHg1bzIwUGg5b3JOTUZmVElXeitLNmMweXBQRENmOExhQjBJN1ZBVnZYdDl1?=
 =?utf-8?B?ajEyUDJVNzRKWG5sc1Q1bVAvY0lrRk1HSThRV1M2WlhhV0JVMCtOL0tUZXJw?=
 =?utf-8?B?dUNOb3M5VFhiekxBTFI3ckd4TDVuU0hZQStMak5vUjNBUitpcVNrQW1GU2pk?=
 =?utf-8?B?dW9ra0pReCs0Vit1SFBXYnl2WmdFeG50S0FpWS9jZ2NVWFZoRWNKU042OXk0?=
 =?utf-8?B?SkhkTkNhcks3MnY3YnVkUDhuRHRPOWsyNFFzOThQcDVIZld5cjRPSGFuanJt?=
 =?utf-8?B?b3FoK3JBdjQrTGVES0cxd3RucitwZHNOcmV1eEtHRkJWdmlIdUdQMVNGMDdD?=
 =?utf-8?B?UzVRRDJnZ3dXYUlMUkpnVjA4a0ZUcS90VHB4clhMTmd5S29DQjhRSTZBQlR6?=
 =?utf-8?B?SUh3WXcwUHdSVXd6NXBhd2NXY3Q0Z1Y0bFplQ0NDYkpHQmRIR2JxdThIVTZs?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c65fde25-b6cf-4109-3302-08dcb62820b4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:57:44.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: El1PMb+5PPwi8/uG0RsfVEFEiTdmXLgHmL5DsuWu4KeEhb4N7q/Yp4MZQrXErbPykUQ9wJsSn87xugPmedrYFpO/Fzqwo7qAEo6i59BXKzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6548

On 06.08.24 4:54 PM, Peng Fan wrote:
>> Subject: Re: [PATCH v3 2/2] arm64: dts: Add support for Kontron
>> i.MX93 OSM-S SoM and BL carrier board
>>
>> Hi Peng,
>>
>> thanks for reviewing!
>>
>> On 01.08.24 4:10 AM, Peng Fan wrote:
>>>> Subject: [PATCH v3 2/2] arm64: dts: Add support for Kontron
>> i.MX93
>>>> OSM-S SoM and BL carrier board
>>>>
>>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>
>>>> This adds support for the Kontron Electronics OSM-S i.MX93 SoM
>> and
>>>> the matching baseboard BL i.MX93.
>>>>
>>>> The SoM hardware complies to the Open Standard Module (OSM)
>> 1.1
>>>> specification, size S
>>>>
>>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>> ---
>>>>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>>>  .../dts/freescale/imx93-kontron-bl-osm-s.dts  | 165 ++++++
>>>>  .../dts/freescale/imx93-kontron-osm-s.dtsi    | 547
>>>> ++++++++++++++++++
>>>>  3 files changed, 713 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-
>> kontron-
>>>> bl-osm-s.dts
>>>>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-
>> kontron-
>>>> osm-s.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile
>>>> b/arch/arm64/boot/dts/freescale/Makefile
>>>> index f04c22b7de72e..c6e82dfe37576 100644
>>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>>> @@ -238,6 +238,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-
>>>> tqma8xqp-mba8xx.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
>>>> +dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb diff
>> -- git
>>>> a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
>>>> b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
>>>> new file mode 100644
>>>> index 0000000000000..2dfa2381f4691
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
>>>> @@ -0,0 +1,165 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>>>> +/*
>>>> + * Copyright (C) 2024 Kontron Electronics GmbH  */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "imx93-kontron-osm-s.dtsi"
>>>> +
>>>> +/ {
>>>> +	model = "Kontron BL i.MX93 OSM-S";
>>>> +	compatible = "kontron,imx93-bl-osm-s", "kontron,imx93-osm-
>>>> s",
>>>> +"fsl,imx93";
>>>> +
>>>> +	aliases {
>>>> +		ethernet0 = &fec;
>>>> +		ethernet1 = &eqos;
>>>> +	};
>>>> +
>>>> +	leds {
>>>> +		compatible = "gpio-leds";
>>>> +
>>>> +		led1 {
>>>> +			label = "led1";
>>>> +			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
>>>> +			linux,default-trigger = "heartbeat";
>>>> +		};
>>>> +	};
>>>> +
>>>> +	pwm-beeper {
>>>> +		compatible = "pwm-beeper";
>>>> +		pwms = <&tpm6 1 5000 0>;
>>>> +	};
>>>> +
>>>> +	reg_vcc_panel: regulator-vcc-panel {
>>>> +		compatible = "regulator-fixed";
>>>> +		enable-active-high;
>>>> +		gpio = <&gpio4 3 GPIO_ACTIVE_HIGH>;
>>>
>>> "enable-active-high" should be put under gpio property.
>>
>> Hm, alphabetically 'e' comes before 'g'. And I see a lot of occurences in
>> the tree where the order is like this. So I'm not really convinced it
>> should be the other way round.
> 
> I just take comments here:
> https://lore.kernel.org/all/Zm+Mu33s2+8G579d@dragon/

Ok, if Shawn likes it that way, I will change it ;)
Thanks!

