Return-Path: <linux-kernel+bounces-276394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66159492F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B94283BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB25017AE08;
	Tue,  6 Aug 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="cHTn2xI2"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2093.outbound.protection.outlook.com [40.107.249.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA618D64C;
	Tue,  6 Aug 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954454; cv=fail; b=fT6GqNjS3FgL6I2ffuXwvwmMVl6zrC8HKv3LQlw7AemW9kAbzghcpo9wPNLQK5ZnmuSLth2LKi5hg1C9qJaYXHZUY14uHzEUWpfOkkKdVExiV6deoMMkBwns0Pqf5Y2FKj9FBNG4Q1hGgP4P09dCTtoTVgFblsXGT9OJdQEVP00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954454; c=relaxed/simple;
	bh=q1LITArf13oDXReN1X1GPJz9MSXwH95r2LmRr13zV3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hFtcIaENV7Qchz5+yAunUJ65KORbSuLPihKIlvTTlu+y5ncHBzUzf5pZKNeNWmGCGt+Ps5t3e9BQZvTeILEVC/AzHsTRDQv0RIJJHwFdDOw4YkYwXEOqGSOyBiEtL4sX9PWafuwQcB6OMaKx+enOGwM109a6NjLYfn1Qhdch9LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=cHTn2xI2; arc=fail smtp.client-ip=40.107.249.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDnBC6RKVcT/66qASugnUH+5usz9FjkobyeKDlzhXV+ztlSsK+QuZ73HixXKDVQ+7NGMrYn0NxFhfnVuZRH9atIl5qIHYAqcnkIYFzPUdNTF8ii9LbXCHhoFfpmvE+ZzwAV/ocRMGwyTFkHiT0TrJ/pzAS1A+CuMBzgKoP/EBmooJjQDLc0kwDm+gzld9ki+zK//6xTgaMCj1PUZOWOjgmrRpBWNMCd7w5ir+GjCUe+JMJqTi7uYN/gJkOAzJqOR0v39sL9wVUzmhD+o0kGKS/PVWNwAuFTE8y7T2PBnWU/7wrpyOBnH1U5tSvOlz3EgDPMCjxNZp0BYG996m7A3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8Wxe/uvyWogunU4RwJ6ZXoPnw+JEBgE88Wwz+zq820=;
 b=uK50+KQJL6caa4rgYGX2J6tTtahm9EsmxCUXa5NeVIQR8h7ozT70VhA2BfcTq0klPHQcAHkURaNn8orO1fhEggNFJkecJCi+MmipnDRV4DkZgtHelHpVz1iA2MMSbBsTvtcZ1ZQJcyuRkdp0QKnN4Biymha3895af9zYVMc2H9bu+o5MRHzsuEFtSdm3Zk9eIdrsVLdcyaGLPvPVDhFJmkTaWexThKhMuHla98gEJ8Z8vJzsdpfktUsR2+FuQg88lUJbH063SRhFKG5bojFT0vm1U0oo8pW3haavmbT5qf7+zc9cJ0QsKXebRPMwvszJrxjqd3L7GL6XnXI4179H7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8Wxe/uvyWogunU4RwJ6ZXoPnw+JEBgE88Wwz+zq820=;
 b=cHTn2xI28X2+wMYUV90I512tuhqa/4htvlQ6p13+w1Zlp1xGWdLwRL/qPIRYSQOeS35zgYmOsxNWQ4l+k4vtOlF45JI0YZEXOpe6uBR8EZEFgtIasuuutQLCO1fxZqIAoFsme9FUIc4MhU5wXdGkhzkNTb+LoOz2Rr2yRBgdq3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PR3PR10MB3930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11; Tue, 6 Aug
 2024 14:27:26 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 14:27:26 +0000
Message-ID: <bf41ac18-f9a0-4d6b-9b30-264c9c295d35@kontron.de>
Date: Tue, 6 Aug 2024 16:27:23 +0200
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
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <PAXPR04MB8459728C46300E5507CBA6F188B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PR3PR10MB3930:EE_
X-MS-Office365-Filtering-Correlation-Id: bf67d1f7-8a48-4108-4d43-08dcb623e52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm4wcUNIOXc5OEtJVCtaSGVKbU9pWmlLZlV0RmJSa25hRzVPeXUyOG1jOFFH?=
 =?utf-8?B?Z3NId3FBQTRFMGltMzQyYXlETkdlNUFSSEIxUU5NSGY4OFowSlJ3czZUVG4y?=
 =?utf-8?B?ZDhYM3REMk51OWZ1M1dKKzhkK2E5ZzlyRGFqY0o3UnBPVG5oU2d3Mm81TW9L?=
 =?utf-8?B?SHlDZG5KejhKSWtGVUV1RDlUNmk4eVRHR0d1OU5mUTFTYnRwOWFyN0xtNkNQ?=
 =?utf-8?B?K0Y3NkFES1o5T01GVk9vYU5mc3VSSjNYOUtYRldmRXV1V3kxYTlQYUJoU3Jm?=
 =?utf-8?B?YjFUeVgxUEUyUGVWTzNIMC9nUlo1ZzdJazRkWHIzRy8zVHpkUWs1Tjk0Smpq?=
 =?utf-8?B?eTRXa0VrRjlJb2VrM2ExS1dacTAyeDdSZHRSaDFxb25VbG1lMW16b3U4R3Nj?=
 =?utf-8?B?M2FoQ1Bxam8wdFJvZlNFcWc3YzFUMk5pWlhMU3hLQVM5OUdzelZLaXk4cktW?=
 =?utf-8?B?Y0QrT0JHNEwzbDVIWXdhbVpvckVDby92VTRCRVNkWk83aCtlaGRIUGVBeE1v?=
 =?utf-8?B?V2lSMmNPZUluZmEwbFdvZGxVOWRwcDZQa2JVL1dMdXFBQ2p1NWFLeGZkN0V3?=
 =?utf-8?B?NHJXMWJwWnBkRE5ZLzA4aXJuWWpjU2R3eUtKY2hOZ0xDS0R6RFpXTTh3RGpE?=
 =?utf-8?B?UFNTdUJHYkhpa0F6eTRjaWZvaGVuanlEdVg4ajBhKy93cnpscU9JZTBvS0p0?=
 =?utf-8?B?ZXFQMUtKb2RINEt5NkdzV0FjcURISkJOUlg1Q2FkSWFreUZVdTUyTVphdTB0?=
 =?utf-8?B?TkZDeHFKUjducGFkemxpTGNXUG0vOTVxeFRmRG9scXdSaURNemkrUWxpUXkw?=
 =?utf-8?B?dUtqbU5ESWliakZJaWVDc0k2R05QUlpIV1lDa003a2h2amM5U2l2UkxYb3dC?=
 =?utf-8?B?Z0N5QW9ZbXVUVHJZa2JVQ3ljSmcyODAyK3p0aEwyeFM1ZWFLUjZSTW5ZN3FG?=
 =?utf-8?B?REpjMnNSbERhZ2E2ZGVoRVBBbDBkMlNXbXcvb1BmUG5MZFcyb3U1MXBvQ3Ux?=
 =?utf-8?B?bFM4SkNkTFdyZFZnakhnUTNsVy9NODFENUdxY2pOV2hKVzVHSHRMem1ybFRF?=
 =?utf-8?B?c2ZKMWk4QjZZQXoxYkMvSjRvMmFEbTNLR05MMngxeHBHd0M0ejBhSURQY2Qv?=
 =?utf-8?B?TzUwb3c4cDFBZS9tZzJzcTJwM3phUVozTmVJWS96N3VGOTBZYkhabjUwWWlC?=
 =?utf-8?B?eDJDU0RBRGpzL0dNYnRoM0s1QVRFU2lNYlBIaEQyTVV5T2huSEFlaThtbWdm?=
 =?utf-8?B?YzBqT3JIcnVVUW14dWdKV3AzNUVNd3AzeVA3ejh2cU9EN2IxSkxHbVQxRWRn?=
 =?utf-8?B?dGhPbUtaaVJ2Y2ZFMGovb3FkdzRaby9WMlAvdnFHa0lpSVV6TmFaeDkrZEdj?=
 =?utf-8?B?a0drZThQSzFWMG5KUHVjclhCdVFVZ05MSXhxb2s1dnpPSnEvMzlNY2JJejhP?=
 =?utf-8?B?Uis3K0VKUFlKZE5MQXArbGdzUkJoT1AxbUhBUVIvRDRrajNHeksxOVpmMnlS?=
 =?utf-8?B?ODhPekg2T3g0QlFWanFtVlpMSFZJWFdhdCtGdWFXa292SlExNnkvbDRUNjBX?=
 =?utf-8?B?eVZBcHh2YUZCdkdTU1pBa01TSjdxRHFJRWg4VitPdERoTlpqcHhNMXFGQUJG?=
 =?utf-8?B?K3JjZmhOeDlJdkE2RE5sUHNIQzZmaEdnYkZxbVhwNmpXUm9CVWNwSEJvd01N?=
 =?utf-8?B?bGVCaXpmS3J4UHV4YlBjeEZwcWxlckphWVNKVHU5KzY3KzYzVXprTE9JbHM2?=
 =?utf-8?B?Y2c2VDR1NVJPWldEcTl0R3BrdHkybWMwSDJCa0JydkgxL282b1JwSUVibjdj?=
 =?utf-8?B?aUdDR0o3WGhseVFqWUM2VFhoTG9BaDd1Rm1VVk1vRlpYWWFMT0dkdHdIeWps?=
 =?utf-8?Q?FwgcvgeWBVmCc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW1UeGNpNHkzcTVUOGg4anFYN3Vwd2tJUTgxZzQ5cXFsemdaamtzTVAzcTc3?=
 =?utf-8?B?bVV5aURlOFphTnRvWlFBUmMwcURoN1B2cEc5UTE0Y2ZJYVhLSWh1QlBtcU9X?=
 =?utf-8?B?eU4xTzRVWWUxTkVNRHBoQzhyYXdaak9UekttSzdBclFRTFpFeFBXcXJWTDVZ?=
 =?utf-8?B?L0FjNDY5MlRkd1hXYnlxZkdvQTRXdTZVQWJ4dmdkeTUxcW9FUnZJRksxNE9W?=
 =?utf-8?B?Nm8ra1BCSUtEYThyQkRpZWhWSnNzRmJHckFSSW9xU3EzZlJNYkpReTFBenhm?=
 =?utf-8?B?UVpqUTB4TEtXZVkybS9ZeDZxWW8zQi93eElRbWFLNXgyTkdIeFFVV0QwcGJM?=
 =?utf-8?B?bUZJUjBvWU9qc0kralNVUVBTRHNvVkVGVWJRL3dxRlBPREVZWm51OXVBeXZS?=
 =?utf-8?B?SmVYeWtUY082NFBMWUlrYzVOUk9TQTB6Vkg1d1gyMWIwRmNJcWZqWi9lY1Mr?=
 =?utf-8?B?OU0rV0tlV3d5SVZURkt6T1RTcmV2QVU4S29kbkV1TW80Yk5aVGFkMTVYeEt5?=
 =?utf-8?B?bCtBZ1Z0bU0ySUZPSnRkYVd2OW9RdzBZdXdJU0tLVzNDQU9qd1NtNk5jSUo2?=
 =?utf-8?B?MVhaemJJd3U2V1JYTlJXSnQ1UnZnYmc2T3dzTzRkNGJ4ZFZzTGI3ejVFREI4?=
 =?utf-8?B?YklkYlJXaWlNbHBxWTY0Ky9IOTUvNFYwNXBvNVBOaVIxWVIwamtuRlMxd3Vm?=
 =?utf-8?B?TkROS251OU9walBjT24vUmJLNGFTM0RDZkFvY1k0RnFra1EyNS9SSHBVRlB0?=
 =?utf-8?B?dm9sWTB6Q2RBOWJRWkluUmQxQXoya3Rxb3hRVVFCaWlTNS9kNmVXT1Q3SW9x?=
 =?utf-8?B?QURZN0ZGa1lpd2JGcE9lYmRKcG5hNHJnU1ZvbDVKSUhyT3YrZTJNMkh3ZG1O?=
 =?utf-8?B?amg0cTZYSE5HcGtJUUdwbkFkaVNHeXdlbkltUDdhekwya0xJQkpkL04vZ29L?=
 =?utf-8?B?cG5SZ201L0dmbWZaVE1VZmF1UENXSWpKTjBNSXJaTlc0UFRlc1J5Q21zWjZD?=
 =?utf-8?B?ZitMY2EydXFNbHF4SmJUYnBLQUpkdGxjVkd2Zzh6WCtGVXJtdDNuSnNyMGpM?=
 =?utf-8?B?NXp4QmwyS1Rrd3VwcUNuMlBKQmVSTUFwNFk5VXM3MUgrdnJSNS95eU81Tlgy?=
 =?utf-8?B?UW9JQmhMK3l4UlI2bTVlZnJleEppYUo4OGt3ZlpBMy94M2lUYmc5M0tQaWd5?=
 =?utf-8?B?TmZFOUVTbTdWZ2xWMjZHNUpCdXd4dDIvNTZIeURJdmx2S0FEQlB6a1VZcDFN?=
 =?utf-8?B?NkZHYjZYK3ZyZnlCa0NxNjRJZ0tlR243U0phbVhFMWhrV2svN3ljTWFlZDhx?=
 =?utf-8?B?NkY0VDU3cktLeEVqVzJxRWhycUlDL1UybzlpMkxmWlBXaERLdmNTcEVnWmY4?=
 =?utf-8?B?QmMyTkRsZ2dWbS81M25XeWw2cEVMbGVwRjlzSklRQ1BUZ2REYk56NC92VFEy?=
 =?utf-8?B?WXVjZVh5dkdVdmI5NHF1eU5BVnhoMWVGN0gwSEpXMFc5YzhFZXZ2VW1SMy82?=
 =?utf-8?B?cGJSUDhOd1oxUEFXK2FOdzZOWFJ2cFBjS1RhNTdSR2M0aERRd3EvTUxWR2hu?=
 =?utf-8?B?U0xMc2xHNzZ4WHFIWWdtdWhjZm5mNGk3M0pEbGlqcW9LUjh5ZVh0OEFnTzZo?=
 =?utf-8?B?ZzUvd1hvWEFGTCtyamxqUnVkbk9sTUNvcFZkLzZWOHdBQjhPN0drL0prdWhR?=
 =?utf-8?B?SVJ0LzRvYTFHSEYrOStsNmpIQkVJTWNJdEFtbk5EZnhyMEdGU3FPT254TjRt?=
 =?utf-8?B?VzNFcEJPbmxMa0RpMkhUWUdpMHlHWm5zTGcxTHp4WlZuaXZ0Y2hUOURxdVBj?=
 =?utf-8?B?TTJqSktBQWhsRTR2a0NVZ3Blck5UcDhyR1VGK1NWZGZFMFdGV2dhbEdPMW1l?=
 =?utf-8?B?QUZHWk9Ca2NzKzQySmxBQXk0SHZKa1RRc2ZGUk44R2d3S3dFVzBVT1c5bUxx?=
 =?utf-8?B?WTVmTnBQNnErN2dpS3hHK0VweHBXM3J4WWdFSTlGbTVCV1UrajJ2UWY3VWFD?=
 =?utf-8?B?L0NDdktoK0Vpa1VPK1l0eFVkNTBGaEh6QjloTEpVN0xXeDNhbTloZllBWVYr?=
 =?utf-8?B?WHkzSGFFQVRFTTl5emVUU0pKc1FFdkJXTVlCc0ZOQXhBdHBmZ2IxajBZVXcw?=
 =?utf-8?B?bVhWZ3cvYUJRZzcrSUZ6MGdiVUxuTlBCQzdVVEpwQW5IcWJwU0hBaUxHM1VX?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bf67d1f7-8a48-4108-4d43-08dcb623e52f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:27:26.6256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abM0jWeGNKAUMbF4cLshOQIuQTPpIEzITYj0KVCDwFy/8UiCDzp2tZZkhbpRzVeJhBmi/v3h4cMGQBlcH/t6uRm4r6ziKsDgxn1dLRWPgbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3930

Hi Peng,

thanks for reviewing!

On 01.08.24 4:10 AM, Peng Fan wrote:
>> Subject: [PATCH v3 2/2] arm64: dts: Add support for Kontron i.MX93
>> OSM-S SoM and BL carrier board
>>
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> This adds support for the Kontron Electronics OSM-S i.MX93 SoM and
>> the matching baseboard BL i.MX93.
>>
>> The SoM hardware complies to the Open Standard Module (OSM) 1.1
>> specification, size S
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>  .../dts/freescale/imx93-kontron-bl-osm-s.dts  | 165 ++++++
>>  .../dts/freescale/imx93-kontron-osm-s.dtsi    | 547
>> ++++++++++++++++++
>>  3 files changed, 713 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-kontron-
>> bl-osm-s.dts
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-kontron-
>> osm-s.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile
>> b/arch/arm64/boot/dts/freescale/Makefile
>> index f04c22b7de72e..c6e82dfe37576 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -238,6 +238,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-
>> tqma8xqp-mba8xx.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
>> +dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb diff --
>> git a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
>> b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
>> new file mode 100644
>> index 0000000000000..2dfa2381f4691
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
>> @@ -0,0 +1,165 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +/*
>> + * Copyright (C) 2024 Kontron Electronics GmbH  */
>> +
>> +/dts-v1/;
>> +
>> +#include "imx93-kontron-osm-s.dtsi"
>> +
>> +/ {
>> +	model = "Kontron BL i.MX93 OSM-S";
>> +	compatible = "kontron,imx93-bl-osm-s", "kontron,imx93-osm-
>> s",
>> +"fsl,imx93";
>> +
>> +	aliases {
>> +		ethernet0 = &fec;
>> +		ethernet1 = &eqos;
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		led1 {
>> +			label = "led1";
>> +			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +	};
>> +
>> +	pwm-beeper {
>> +		compatible = "pwm-beeper";
>> +		pwms = <&tpm6 1 5000 0>;
>> +	};
>> +
>> +	reg_vcc_panel: regulator-vcc-panel {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio4 3 GPIO_ACTIVE_HIGH>;
> 
> "enable-active-high" should be put under gpio property.

Hm, alphabetically 'e' comes before 'g'. And I see a lot of occurences
in the tree where the order is like this. So I'm not really convinced it
should be the other way round.

> 
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-name = "VCC_PANEL";
>> +	};
>> +};
>> +
>> +&lpspi8 {
>> +	status = "okay";
>> +	assigned-clocks = <&clk IMX93_CLK_LPSPI8>;
>> +	assigned-clock-parents = <&clk
>> IMX93_CLK_SYS_PLL_PFD0_DIV2>;
>> +	assigned-clock-rates = <100000000>;
>> +
>> +	eeram@0 {
>> +		compatible = "microchip,48l640";
>> +		reg = <0>;
>> +		spi-max-frequency = <20000000>;
>> +	};
>> +};
>> +
>> +&eqos {	/* Second ethernet (OSM-S ETH_B) */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_eqos_rgmii>;
>> +	phy-mode = "rgmii-id";
>> +	phy-handle = <&ethphy1>;
>> +	status = "okay";
>> +
>> +	mdio {
>> +		compatible = "snps,dwmac-mdio";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ethphy1: ethernet-phy@1 {
>> +			compatible = "ethernet-phy-id4f51.e91b";
>> +			reg = <1>;
>> +			reset-assert-us = <10000>;
>> +			reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +};
>> +
>> +&fec { /* First ethernet (OSM-S ETH_A) */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_enet_rgmii>;
>> +	phy-connection-type = "rgmii-id";
>> +	phy-handle = <&ethphy0>;
>> +	status = "okay";
>> +
>> +	mdio {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ethphy0: ethernet-phy@1 {
>> +			compatible = "ethernet-phy-id4f51.e91b";
>> +			reg = <1>;
>> +			reset-assert-us = <10000>;
>> +			reset-gpios = <&gpio2 18 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +};
>> +
>> +&flexcan1 {
>> +	status = "okay";
>> +};
>> +
>> +&lpi2c2 {
>> +	status = "okay";
>> +
>> +	gpio_expander_dio: gpio@20 {
>> +		compatible = "ti,tca6408";
>> +		reg = <0x20>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		gpio-line-names = "DIO1_OUT","DIO1_IN",
>> "DIO2_OUT","DIO2_IN",
>> +				  "DIO3_OUT","DIO3_IN",
>> "DIO4_OUT","DIO4_IN";
>> +		interrupt-parent = <&gpio4>;
>> +		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
>> +		reset-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
>> +	};
>> +};
>> +
>> +&lpuart1 {
>> +	status = "okay";
>> +};
>> +
>> +&lpuart7 {
>> +	uart-has-rtscts;
>> +	status = "okay";
>> +};
>> +
>> +&lpuart6 {
>> +	linux,rs485-enabled-at-boot-time;
>> +	uart-has-rtscts;
>> +	status = "okay";
>> +};
>> +
>> +&tpm6 {
>> +	status = "okay";
>> +};
>> +
>> +&usbotg1 {
>> +	disable-over-current;
>> +	dr_mode = "host";
>> +	status = "okay";
>> +
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	usb1@1 {
>> +		compatible = "usb424,2514";
>> +		reg = <1>;
>> +	};
>> +};
>> +
>> +&usbotg2 {
>> +	adp-disable;
>> +	hnp-disable;
>> +	srp-disable;
>> +
>> +	disable-over-current;
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +	status = "okay";
>> +};
>> +
>> +&usdhc2 {
>> +	vmmc-supply = <&reg_vdd_3v3>;
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
>> b/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
>> new file mode 100644
>> index 0000000000000..926c622d380ee
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
>> @@ -0,0 +1,547 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +/*
>> + * Copyright (C) 2024 Kontron Electronics GmbH  */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include "imx93.dtsi"
>> +
>> +/ {
>> +	model = "Kontron OSM-S i.MX93";
>> +	compatible = "kontron,imx93-osm-s", "fsl,imx93";
>> +
>> +	aliases {
>> +		rtc0 = &rv3028;
>> +		rtc1 = &bbnsm_rtc;
>> +	};
>> +
>> +	memory@40000000 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x40000000 0 0x80000000>;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = &lpuart1;
>> +	};
>> +
>> +	reg_usdhc2_vcc: regulator-usdhc2-vcc {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vcc>;
>> +		enable-active-high;
>> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> 
> "enable-active-high" put under "gpio".
> 
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-name = "VCC_SDIO_A";
>> +	};
>> +
>> +	reg_vdd_carrier: regulator-vdd-carrier {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_reg_vdd_carrier>;
>> +		enable-active-high;
>> +		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> 
> Ditto.
> 
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-name = "VDD_CARRIER";
>> +
>> +		regulator-state-standby {
>> +			regulator-on-in-suspend;
>> +		};
>> +
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +
>> +		regulator-state-disk {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +};
>> +
>> +&lpspi1 { /* OSM-S SPI_A */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_lpspi1>;
>> +	cs-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>; };
>> +
>> +&lpspi8 { /* OSM-S SPI_B */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_lpspi8>;
>> +	cs-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>; };
>> +
>> +&flexcan1 { /* OSM-S CAN_A */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_flexcan1>;
>> +};
>> +
>> +&flexcan2 { /* OSM-S CAN_B */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_flexcan2>;
>> +};
>> +
>> +&gpio1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_gpio1>;
>> +	gpio-line-names = "", "", "I2C_A_SCL", "I2C_A_SDA",
>> +			  "UART_CON_RX", "UART_CON_TX",
>> "UART_C_RX", "UART_C_TX",
>> +			  "CAN_A_TX", "CAN_A_RX", "GPIO_A_0",
>> "SPI_A_CS0",
>> +			  "SPI_A_SDI", "SPI_A_SCK","SPI_A_SDO"; };
>> +
>> +&gpio2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_gpio2>;
>> +	gpio-line-names = "I2C_B_SDA", "I2C_B_SCL", "GPIO_B_1",
>> "GPIO_A_2",
>> +			  "UART_B_TX", "UART_B_RX", "UART_B_RTS",
>> "UART_B_CTS",
>> +			  "UART_A_TX", "UART_A_RX", "UART_A_RTS",
>> "UART_A_CTS",
>> +			  "SPI_B_CS0", "SPI_B_SDI", "SPI_B_SDO",
>> "SPI_B_SCK",
>> +			  "I2S_BITCLK", "I2S_MCLK", "GPIO_A_1",
>> "I2S_A_DATA_OUT",
>> +			  "I2S_A_DATA_IN", "PWM_2", "GPIO_A_3",
>> "PWM_1",
>> +			  "PWM_0", "CAN_B_TX", "I2S_LRCLK",
>> "CAN_B_RX", "GPIO_A_4",
>> +			  "GPIO_A_5";
>> +};
>> +
>> +&gpio3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_gpio3>;
>> +	gpio-line-names = "SDIO_A_CD", "SDIO_A_CLK",
>> "SDIO_A_CMD", "SDIO_A_D0",
>> +			  "SDIO_A_D1", "SDIO_A_D2", "SDIO_A_D3",
>> "SDIO_A_PWR_EN",
>> +			  "", "", "", "",
>> +			  "", "", "", "",
>> +			  "", "", "", "",
>> +			  "SDIO_B_CLK", "SDIO_B_CMD",
>> "SDIO_B_D0", "SDIO_B_D1",
>> +			  "SDIO_B_D2", "SDIO_B_D3", "GPIO_A_6",
>> "GPIO_A_7"; };
>> +
>> +&gpio4 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_gpio4>;
>> +	gpio-line-names = "ETH_B_MDC", "ETH_B_MDIO",
>> "ETH_B_TXD4", "ETH_B_TXD3",
>> +			  "ETH_B_TXD2", "ETH_B_TXD1",
>> "ETH_B_TX_EN", "ETH_B_TX_CLK",
>> +			  "ETH_B_RX_CTL", "ETH_B_RX_CLK",
>> "ETH_B_RXD0", "ETH_B_RXD1",
>> +			  "ETH_B_RXD2", "ETH_B_RXD3", "ETH_MDC",
>> "ETH_MDIO",
>> +			  "ETH_A_TXD3", "ETH_A_TXD2",
>> "ETH_A_TXD1", "ETH_A_TXD0",
>> +			  "ETH_A_TX_EN", "ETH_A_TX_CLK",
>> "ETH_A_RX_CTL", "ETH_A_RX_CLK",
>> +			  "ETH_A_RXD0", "ETH_A_RXD1",
>> "ETH_A_RXD2", "ETH_A_RXD3",
>> +			  "GPIO_B_0", "CARRIER_PWR_EN";
>> +};
>> +
>> +&lpi2c1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_lpi2c1>;
>> +	status = "okay";
>> +
>> +	pca9451: pmic@25 {
>> +		compatible = "nxp,pca9451a";
>> +		reg = <0x25>;
>> +		nxp,i2c-lt-enable;
>> +
>> +		regulators {
>> +			reg_vdd_soc: BUCK1 { /* dual phase with
>> BUCK3 */
>> +				regulator-name = "+0V8_VDD_SOC
>> (BUCK1)";
>> +				regulator-min-microvolt = <650000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <3125>;
>> +			};
>> +
>> +			reg_vddq_ddr: BUCK2 {
>> +				regulator-name = "+0V6_VDDQ_DDR
>> (BUCK2)";
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <600000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <3125>;
>> +			};
>> +
>> +			reg_vdd_3v3: BUCK4 {
>> +				regulator-name = "+3V3 (BUCK4)";
>> +				regulator-min-microvolt =
>> <3300000>;
>> +				regulator-max-microvolt =
>> <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdd_1v8: BUCK5 {
>> +				regulator-name = "+1V8 (BUCK5)";
>> +				regulator-min-microvolt =
>> <1800000>;
>> +				regulator-max-microvolt =
>> <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_nvcc_dram: BUCK6 {
>> +				regulator-name =
>> "+1V1_NVCC_DRAM (BUCK6)";
>> +				regulator-min-microvolt =
>> <1100000>;
>> +				regulator-max-microvolt =
>> <1100000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_nvcc_snvs: LDO1 {
>> +				regulator-name = "+1V8_NVCC_SNVS
>> (LDO1)";
>> +				regulator-min-microvolt =
>> <1800000>;
>> +				regulator-max-microvolt =
>> <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdd_ana: LDO4 {
>> +				regulator-name = "+0V8_VDD_ANA
>> (LDO4)";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_nvcc_sd: LDO5 {
>> +				regulator-name = "NVCC_SD (LDO5)";
>> +				regulator-min-microvolt =
>> <1800000>;
>> +				regulator-max-microvolt =
>> <3300000>;
>> +			};
>> +		};
>> +	};
>> +
>> +	eeprom@50 {
>> +		compatible = "onnn,n24s64b", "atmel,24c64";
>> +		reg = <0x50>;
>> +		pagesize = <32>;
>> +		size = <8192>;
>> +		num-addresses = <1>;
>> +	};
>> +
>> +	rv3028: rtc@52 {
>> +		compatible = "microcrystal,rv3028";
>> +		reg = <0x52>;
>> +	};
>> +};
>> +
>> +&lpi2c2 { /* OSM-S I2C_A */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_lpi2c2>;
>> +};
>> +
>> +&lpi2c3 { /* OSM-S I2C_B */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_lpi2c3>;
>> +};
>> +
>> +&tpm3 { /* OSM-S PWM_0 */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_tpm3>;
>> +};
>> +
>> +&tpm4 { /* OSM-S PWM_2 */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_tpm4>;
>> +};
>> +
>> +&tpm6 { /* OSM-S PWM_1 */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_tpm6>;
>> +};
>> +
>> +&lpuart1 { /* OSM-S UART_CON */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_lpuart1>;
>> +};
>> +
>> +&lpuart2 { /* OSM-S UART_C */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_lpuart2>;
>> +};
>> +
>> +&lpuart6 { /* OSM-S UART_B */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_lpuart6>;
>> +};
>> +
>> +&lpuart7 { /* OSM-S UART_A */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_lpuart7>;
>> +};
>> +
>> +&usdhc1 { /* eMMC */
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc1>;
>> +	pinctrl-1 = <&pinctrl_usdhc1>;
>> +	pinctrl-2 = <&pinctrl_usdhc1>;
> 
> Same pad settings?

I will update this to use adjusted settings for the different speed modes.

> 
>> +	vmmc-supply = <&reg_vdd_3v3>;
>> +	vqmmc-supply = <&reg_vdd_1v8>;
>> +	bus-width = <8>;
>> +	non-removable;
>> +	status = "okay";
>> +};
>> +
>> +&usdhc2 { /* OSM-S SDIO_A */
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
>> +	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
>> +	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> 
> Ditto.

I will change this, too.

> 
>> +	vmmc-supply = <&reg_usdhc2_vcc>;
>> +	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>; };
>> +
>> +&usdhc3 { /* OSM-S SDIO_B */
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc3>;
>> +	pinctrl-1 = <&pinctrl_usdhc3>;
>> +	pinctrl-2 = <&pinctrl_usdhc3>;
> 
> Ditto.

I will change this, too.

Thanks
Frieder

