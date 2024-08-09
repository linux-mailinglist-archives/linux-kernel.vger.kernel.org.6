Return-Path: <linux-kernel+bounces-280381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0117F94C9D0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CB81C2239A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F916C845;
	Fri,  9 Aug 2024 05:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="dqu843Pc"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038234CDD;
	Fri,  9 Aug 2024 05:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182444; cv=fail; b=Qt+gQthLhaYxIaSR8dX52byhTYZzoqvgEqP25dIQqYTkmUuRAtcCPHoX7H+CeKkC7PE5hBzls8N5s4mTN1DLXgHRDZhu8h9w62Tp6XB8ZsUVR2gE/4lVXUaOwTjxoyeoof22J3pmIbJG3XAFZCF2USqQKDCp0ojG/k3MS7Dp6YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182444; c=relaxed/simple;
	bh=fdVxFCijdGW2hLVzS2R/sjctGsvDpCCXNiCaU7hOEfc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FV0/VIp5nqpHK1J4ogvKu5ZtJ1p1Tz/XAGq1Q2p6sqk9uExFOm9rD9dNuAhvLNn3AZD/gxO3tk/foBXu1PT/auZCJv6XzaLLv/0+HxRwdfI2Hn/oRKP3lnoyvFfPy5qiaHXKNVvH/4D14TSslyqHSVyZUQveukbXuKgEqBR/Gvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=dqu843Pc; arc=fail smtp.client-ip=40.107.117.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5Mos8CmINZJSzc21W/h6anGaJWs88vu+W7R5PW0KC8zfnigy8Zj8tEXPqiQHgy/kfNK4yVstBNq3FD1mm/cG2GXyPiPuYiIrELyfG9idqcIa8EJAsO7qhVfWOg0IBjRlcoUTI4YH2FotxAuBMM9BRKxLLd5WUzLfcWmdwlpeQZb56fRP2NiV26ICorZDBbfIctBophwB10OVKYMRJHFDk1F8MOqj8OuaiWNpCdxRJszBBQEDr575J7bGVg+UV3XN+Eaa3izCYvasKrPWbD9CRo3/FQWVW9cMGYclkxdk85c2YnhNV4DDHvzxZMPEMQ7U85xT9xUannTRH2WO/g+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdVxFCijdGW2hLVzS2R/sjctGsvDpCCXNiCaU7hOEfc=;
 b=g8+UcX7XBwjwWrUkzkiYRrK/vLodkTWeKnSZ2rnccnTrmiSzUAKT6UUo3AEn9hu22wvZeuvIacBOsfeMgrIwiQPLHEGsK3EHN+YsvaGtZPCN2GEu39TLOrLr7cGyQX9uUs6WsbTi1RXhhIBIbZaLqSXLaVuoHk/nC000oTvR77qeT/u0jT7w83BQfIdaVF/caK9iSyDTo0+0g9SRV+2sQpdBdzWfz2GT5wmfzFUvIen2jBM+k/stff/qf8f9i1yPPJn5n4lTliGBsYAL5gEQIJe0aHfmnRm+x/1xPzeNjUJuOJBfw8+eonGNrJCY6ttcGPF4UziwF+9Vge0WuA8yMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdVxFCijdGW2hLVzS2R/sjctGsvDpCCXNiCaU7hOEfc=;
 b=dqu843Pc2lR8aI9JbMAHCrvA2xbgo5g+/2LtRL5ZBQKj020+ff4IjekbwSDflIVP/urdGRVmbicaW5VtNmvkelyhexH0viukG6i4YZ+jmT6WKbw8QRfTAiiMEeMUin8xQDjmJb+OawvbtRapqg/9LedDPoM6p7px6Ojh04p5LATNneAFT9I4FjpHHvDw+FF7Fndbj8mo7FFq7Sjapu+vJodsR7G/QtdXqow8OmumziyQUJK6w7dIBShQu+R1LmrZ2fX+qjYF+QO2tmqUVatiDWhzdeS6AK7q9hI/20V5oJcxreTKXsnUdGDAeUgatA4kwp3EbljAKUnHtqZhkW0eZg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by PUZPR06MB5650.apcprd06.prod.outlook.com (2603:1096:301:fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 05:47:15 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 05:47:15 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Lee Jones
	<lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Topic: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Index: AQHa6WjvtGERsBjdbUe0s1M0hUJcKbIdCjAAgAFhFjA=
Date: Fri, 9 Aug 2024 05:47:15 +0000
Message-ID:
 <OS8PR06MB75413728F0FCEE022B4B4F5BF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
 <14ef9485-54ba-402b-9b90-5f10c1523d4e@wanadoo.fr>
In-Reply-To: <14ef9485-54ba-402b-9b90-5f10c1523d4e@wanadoo.fr>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|PUZPR06MB5650:EE_
x-ms-office365-filtering-correlation-id: c579ae33-b3c0-4f39-4efa-08dcb836b944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjdCay9KeTdoUVJCbDlRaTJKanV5UnB0eVRzWTZlTXYzR0RzZWFxamdhT3U0?=
 =?utf-8?B?TnRxVit2Y3lyVTVzR0t2ODZIRjdhaFYrbVVkbFlmSjl1MFo1aGNpVDVTck10?=
 =?utf-8?B?YzRpaExDYTdBWitDZDBwS1ZPQWVpbStpU0FQV0s2aFNyK0pFZ2RPbVpYWndD?=
 =?utf-8?B?ellUaTI5ZVR1VmdDY1g4NEtacXpJWFlvejRHazFDT1M5VWN5TTNjbzUzenM2?=
 =?utf-8?B?VzRSdWl4K2M5ZDN0ZU5DSGRjckgyZU1BZWtaanA0RFY4YU9GQ1dTdlFobUd0?=
 =?utf-8?B?OEJRUnJYdnp3TzhqcU1hNzRXRmUwK09aZGJEelVtU0ZrS2VLUUcveU9SVnhL?=
 =?utf-8?B?SCszejJqMjBKNEZVNnJxc3VGQ29HRnR4eFF4SXdiR0hVTEZ5VjdyL1VDbUxV?=
 =?utf-8?B?WEhPbHQzRHkzMzZmMForTEZzTTg1S3l3WnRhV0lpaHlZMWxnYVByOVBkdXpQ?=
 =?utf-8?B?RHFsamxQdHlFMkNxZUJUcnFhaTdSaHczblFMSGpHbGlMRi9hQyttVE9kOWQx?=
 =?utf-8?B?Lzd6azVzWEJ2eWZrSHZoRE9jSGJ5NEpIYzRIYVVsd2R6SW1OdkNrTm5Ya21P?=
 =?utf-8?B?UWFMZ2lVZlFZYm5GeDh3eWhQb09MQmgvZXBKM3BxWDdQSVpBdG5BSFhUVVU2?=
 =?utf-8?B?b1luemFyWE9jbzNqSjBqUUVlUnZYRmVXUGtBTU9lVjFzclNGd2IzNGJ5Zmtk?=
 =?utf-8?B?UStMSHcvb0hNbTRiTXJtOUxva2xrUmk1Nko1Mkk4ZGsrS3ZBWS8wQnA4enNv?=
 =?utf-8?B?SWVpNkpqSG9Qc0huQ2xwOHM4aUp1UnZNdS95b01mS3NmbEJ3eDNNbzkzNCtI?=
 =?utf-8?B?bHNlTG1Fait5ckVXQjdCczlQUHZZUy9WMWhrbkFhY0MvNmZSd1JTcUdOZDZy?=
 =?utf-8?B?UVExanB3cnlxS1ZTM0pIcWZZZm51MHkvczlWNW90aWNmOFRQRUxST2FnRno4?=
 =?utf-8?B?eUFieFVnWDJvQkFpSXZqSlc4aWlvd2VERWpxeDFWLzQxc0pKdUtWYzRJSVQ4?=
 =?utf-8?B?SmRUS0d4Vmh4TkJLZE4rVUZXV2hQdlJ4VWlQenVXbVJFQXEwc1RPbHd2MTlD?=
 =?utf-8?B?eGtqUWxqaFFGcW1oSG1pRkhQUDJEK1BlcmJlRUhDb3Z0dVNuejRCd0pSdW9k?=
 =?utf-8?B?MHF3OVpaUTNMeEVDY0NMM3NqUVl2OTE2bkJseVVMS2lLVW1MZ1Q2NFlNSkx2?=
 =?utf-8?B?WlZibzUrcnhDSkpGTkg4VUttbDJMSUVFVlZJc3RUWDlxMzk0ZldHVHhHVHRn?=
 =?utf-8?B?TlFkVlhJRjQ2K3JjbmdaSXZMV2FwM3RIWjhMdU9QVjlHemNVVlF5K2NNRHRZ?=
 =?utf-8?B?Skt3Tnd6U0N1Mk94S0svR0E2dlpiVG9RWk9GRGs2MmZQYitNcFFhQ2d1clQx?=
 =?utf-8?B?REJRSURIYmxiWFZnNzhIUFo1NitNejVvUWhGaFI5c3FoQ3gvNXQ1bE4raHh3?=
 =?utf-8?B?eG1KYUpYODBkdXRJM2tHMlBtWEdlUCt5Y0VmazRJTGJvMkVOU1EzVTdIeklM?=
 =?utf-8?B?bWpQMnlINDR0ejRHcVJadWg2L1NzY0lNdlF2VlJLUzdLN1AvNkExMjQweE1z?=
 =?utf-8?B?L1lYWFkvaGFWNGI5OVIrMWsyeGp2U1FKaHlWT2hraGFFN0FxbFZGVUR3UmtX?=
 =?utf-8?B?VngvQk9oRHpxVGQ3czFjSTdVVHcxaVNtTUdZTG9BWmI3eU5RR3VxSEVrOG5m?=
 =?utf-8?B?aFpHdGhLQWRKMTc3SVA0Wi81K1dnajBvSk9NdjRZbjFoKzVqdkpXMjRUMEE0?=
 =?utf-8?B?M29QenpBRzlpMkY0aHdIQzRlNDNUTTYwais0MS9JMDk2MkEzQThRdUMyUTFt?=
 =?utf-8?B?VDRQS3MwUlI0SEZBVkhOR1pkSkNxbGFEazdjTnl3RmFUOHVWbHQ4TUFobkN6?=
 =?utf-8?B?TmUxeFd2M09NdkFZT1pPdzdsamw2ODR2MGkzU1pSV2o5dmlUZldKZnhWWnN4?=
 =?utf-8?Q?i2tHIqX1LJw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU4zTjlUY0xMeTlWalRUc3FVUWRBRkYzWGExVXg0S1M3SGVwN3ZwcGdpL1hS?=
 =?utf-8?B?bi96SDZTM0U4MXpXSHZHWWFzLzJzT3VjaDVFZEoreDNUSjJLcmJtd3BjMkhy?=
 =?utf-8?B?N051VlR3U3M5WjVDU0dnOHlVeHpySDZReWF5dEl1VUE2NGE2Mzk1ZXcrKzlT?=
 =?utf-8?B?WGxIZEtrNjFKemFtU21wTGlsRkNQVUFXQ2FWeXFqK1RKbzJiclprMXJYcTdP?=
 =?utf-8?B?TUFtNG4vT0FRNll0bXBOeTc4S3FGM3B0aUVmWVBCM3lUS1FPWE9yQi85aEFH?=
 =?utf-8?B?M0JUQ1dUQXlSa0RlTnRDQ01MbVp6SU5jTVpyVSt4ZnVTSG54V1BDR05FZFlJ?=
 =?utf-8?B?c1R6bk9RbVVXb0l0WGVwNEtDSlVGQWh5ZXgyNFpOdUJuM0dtdk1HRFp3MFdX?=
 =?utf-8?B?ckxCQkJkdUR0S3hTaGNtbkVjMXpnTkhObW03OC9BNXZOMnRMbnZzVGhRc000?=
 =?utf-8?B?WS9iYXVSdHRoQldOK1ZkR1NEMGpJK2U5aFFVQ1JDM0crcC9kN0xaeThIYlNX?=
 =?utf-8?B?aDcwUHkrVmM1a3c5MlpvT3BLbTlCTDhyZFF1L3poVUFxVlRoNWVlV2tDbS8z?=
 =?utf-8?B?UkVLRkxYamV4RUxwdHNtQnpMbWxNYVgwVEdNd3A4S3lwQkk5MUZPbkNtQ1pr?=
 =?utf-8?B?azdJTFpXNHJPQXFLZmdXVllwVGtBSUZxL1NFREl0dFVibnAweERtU3B3Umo3?=
 =?utf-8?B?byttdm1KZnphbldPMERUbk5YUUN4MkRFTWNkLzZTRHk1bEw5OGo3bExHc0tO?=
 =?utf-8?B?eVI5WmROZzhFTS9sWWVCZUNFb0FUeTVIa3ZOeGxLcTdSR0U1SFdibmJMbWp0?=
 =?utf-8?B?bi9wN3JZOUNXbEtQMDRXaUVENW5kMXBteXRmZVRtMGRhK2k3Um9hL0o5UWkz?=
 =?utf-8?B?QUFoTWhvN2pXZ2pmMjBQWmd6eWtKclcrbUM5alRVR25IRHg0elFGOEdQMVI2?=
 =?utf-8?B?OEV5UEs3MTRuRVJPNXZrWHlNMTRGeXFodEg0WThJTmlNdEFzVDhtTGJRNHNm?=
 =?utf-8?B?MnpGS3FDMFdnaURSOVNTNHdKNHZjaTMvVjN3TFdGQ28vSWRSb3h4SjR2blBE?=
 =?utf-8?B?YzV5SVI5bEF5ZFBFT0lkTkpXR3lDSXVTOS94MHRJeFJKNjQxTVI1OTdWUFl1?=
 =?utf-8?B?K2xWUUdZbURRYW5wUDQ0U3lyREtCMkNiQXVWVlRGZHBwSXBRb3cwR3JzVWp2?=
 =?utf-8?B?dVFDR0Q0bVJOdlZzT2NNZnl1MDhuSFpoYzlYcXpaV00vRVlKbzdRZklTNS9v?=
 =?utf-8?B?STBGSjdjZmhuMzVoRnBSdmU1a2djMXpHY2VmQ3V1VTIxM0pVODVHYVcyUnQ4?=
 =?utf-8?B?YURERklla1A2Mm00K0tBWkpXd2dCYVpEWWhBSlpONmFYYXpNRDcwZlllR095?=
 =?utf-8?B?V2w2RmR0TG9mSEQ3djhKRDVrZ0tBbTFzM2tBQy9EdUxZazlPbjhTK2pXckM3?=
 =?utf-8?B?cmQxVVZzcTNUWUpCYnFtbGJVTWJFcWJSQ21RdWg2WDFacExqaCtIaEQ3NzV6?=
 =?utf-8?B?TFlpTU9sTmltRUJ1SS8waVhyOHZ5RlpLVkhZWnJ6ZmhaYnZHaXdkVFgzeU1T?=
 =?utf-8?B?Vko1cTBiODd1aXZIQlFjOG0wSzBEMUIxNFdobEpVSWFYYnJBSTJVdkZIYlk3?=
 =?utf-8?B?SGhiUExpQ1FELzRFb3Z4TFNzSDVkRWEvYU9ZS3d1amxycitIdGFjQzgvQnZW?=
 =?utf-8?B?VmQ1RDFkYWNrNDlodDRMclVLWFduSzAxZkZyRTFEWllYVCttc3NETGgvQVg2?=
 =?utf-8?B?R2hXZkJjZWwvZHZ1TUFuNDdDN2wzQzBkKzc4b2x4Rjk5QlRQTVRERlBYb3ZL?=
 =?utf-8?B?MkNaQ0RzaXhOYVd6eWYrWllrM0hVVitvWHdwSnRNcjVVdnp1V2hlZThnUFVY?=
 =?utf-8?B?M1l3Z2JFbGJ1U3FGVHVFdm44NmNsTTlTL2JpMlNyT04xU2plL3p1UmFuK0tU?=
 =?utf-8?B?T1RoTnVkRVNuMWlleTBEelZKMG5BRVRZbHVJSTNSOHNKZUNjbHk4RThpWlFx?=
 =?utf-8?B?QjNvdXYrYXVHT2Y4MmxUWTV3Tmh0ZHk3Y05lS1VGR25pS1kyYm1lN2FyRkJI?=
 =?utf-8?B?U0tjRURYTFpKd2tqWGtrMkRJRTRVVVNqaTQ1SmYvQ1dJWXVwem9GWFM2ZW94?=
 =?utf-8?Q?tpDwO8OAzQ4pykxZpNfc7Yii7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c579ae33-b3c0-4f39-4efa-08dcb836b944
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 05:47:15.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KyjhGwXUN99ev25wd34sPJJSl+0x+/V/Y+g5z0vZF4GYh2ha+wfJLIAMz2dn/bo8lOsvJfU0YC0+PcsKb+9ailEJWAC1Cs3RMRBecjHF04g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5650

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPg0KPiBMZSAwOC8wOC8yMDI0IMOgIDA5OjU5LCBSeWFuIENoZW4g
YSDDqWNyaXQgOg0KPiA+IEFkZCBkdCBiaW5kaW5ncyBmb3IgQVNUMjcwMCBjbG9jayBjb250cm9s
bGVyDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0
MjcwMC1jbGsuaCAgICB8IDE3NQ0KPiArKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxNzUgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtY2xrLmgNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+
ID4gYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmZhY2Y3MjM1MmMz
ZQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2Nr
L2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4gQEAgLTAsMCArMSwxNzUgQEANCj4gPiArLyogU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAqLw0K
PiA+ICsvKg0KPiA+ICsgKiBEZXZpY2UgVHJlZSBiaW5kaW5nIGNvbnN0YW50cyBmb3IgQVNUMjcw
MCBjbG9jayBjb250cm9sbGVyLg0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQg
QXNwZWVkIFRlY2hub2xvZ3kgSW5jLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpZm5kZWYgX19E
VF9CSU5ESU5HU19DTE9DS19BU1QyNzAwX0ggI2RlZmluZQ0KPiA+ICtfX0RUX0JJTkRJTkdTX0NM
T0NLX0FTVDI3MDBfSA0KPiA+ICsNCj4gPiArLyogU09DMCBjbGstZ2F0ZSAqLw0KPiA+ICsjZGVm
aW5lIFNDVTBfQ0xLX0dBVEVfTUNMSyAoMCkNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0VD
TEsgKDEpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV8yRENMSyAgICAgICAgKDIpDQo+ID4g
KyNkZWZpbmUgU0NVMF9DTEtfR0FURV9WQ0xLICgzKQ0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dB
VEVfQkNMSyAoNCkNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1ZHQTBDTEsgICAgICAoNSkN
Cj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JFRkNMSyAgICAgICAoNikNCj4gPiArI2RlZmlu
ZSBTQ1UwX0NMS19HQVRFX1BPUlRCVVNCMkNMSyAoNykNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19H
QVRFX1JTVjggKDgpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9VSENJQ0xLICAgICAgKDkp
DQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9WR0ExQ0xLICAgICAgKDEwKQ0KPiA+ICsjZGVm
aW5lIFNDVTBfQ0xLX0dBVEVfRERSUEhZQ0xLICAgICgxMSkNCj4gPiArI2RlZmluZSBTQ1UwX0NM
S19HQVRFX0UyTTBDTEsgICAgICAoMTIpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9IQUND
TEsgICAgICAgKDEzKQ0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUE9SVEFVU0IyQ0xLICgx
NCkNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1VBUlQ0Q0xLICAgICAoMTUpDQo+ID4gKyNk
ZWZpbmUgU0NVMF9DTEtfR0FURV9TTElDTEsgICAgICAgKDE2KQ0KPiA+ICsjZGVmaW5lIFNDVTBf
Q0xLX0dBVEVfREFDQ0xLICAgICAgICgxNykNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0RQ
ICAgKDE4KQ0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfRTJNMUNMSyAgICAgICgxOSkNCj4g
PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0NSVDBDTEsgICAgICAoMjApDQo+ID4gKyNkZWZpbmUg
U0NVMF9DTEtfR0FURV9DUlQxQ0xLICAgICAgKDIxKQ0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dB
VEVfVkxDTEsgICAgICAgICgyMikNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0VDRFNBQ0xL
ICAgICAoMjMpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9SU0FDTEsgICAgICAgKDI0KQ0K
PiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUlZBUzBDTEsgICAgICgyNSkNCj4gPiArI2RlZmlu
ZSBTQ1UwX0NMS19HQVRFX1VGU0NMSyAgICAgICAoMjYpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtf
R0FURV9FTU1DQ0xLICAgICAgKDI3KQ0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUlZBUzFD
TEsgICAgICgyOCkNCj4gPiArLyogcmVzZXJ2ZWQgMjkgfiAzMSovDQo+ID4gKyNkZWZpbmUgU0NV
MF9DTEtfR0FURV9OVU0gIChTQ1UwX0NMS19HQVRFX1JWQVMxQ0xLICsgMSkNCj4gPiArDQo+ID4g
Ky8qIFNPQzAgY2xrICovDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtJTiAgICAgICAgIChTQ1UwX0NM
S19HQVRFX05VTSArIDApDQo+DQo+IFNvIFNDVTBfQ0xLSU4gaXMgMjgrMSswID0gMjkgd2hpY2gg
aXMgc2FpZCB0byBiZSByZXNlcnZlZCBpbiB0aGUgY29tbWVudA0KPiBhYm92ZS4NCg0KQWN1dGVs
eSwgSSBrZWVwIHJlc2VydmVkIGlzIGJlY2F1c2UgZGF0YSBzaGVldCBoYXMgcmVzZXJ2ZWQgYml0
cyBmcm9tIDI5fjMxLg0KSWYgeW91IGhhdmUgY29uY2VybiBhYm91dCBpdCwgSSBjYW4gcmVtb3Zl
IHRoZSBjb21tZW50Lg0KT3IgYXJlIHlvdSBwcmVmZXIgYnkgZm9sbG93aW5nPw0KI2RlZmluZSBT
Q1UwX0NMS19HQVRFX1JFU0VSVkVEMjkgICAgICAgICgyOSkNCiNkZWZpbmUgU0NVMF9DTEtfR0FU
RV9SRVNFUlZFRDMwICAgICAgICAoMzApDQojZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUkVTRVJWRUQz
MSAgICAgICAgKDMxKQ0KI2RlZmluZSBTQ1UwX0NMS19HQVRFX05VTSAgICAgICAoU0NVMF9DTEtf
R0FURV9SRVNFUlZFRDMxICsgMSkNCg0KPg0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLXzI0TSAgICAg
ICAgICAgICAgIChTQ1UwX0NMS19HQVRFX05VTSArIDEpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtf
MTkyTSAgICAgICAgICAgICAgKFNDVTBfQ0xLX0dBVEVfTlVNICsgMikNCj4gPiArI2RlZmluZSBT
Q1UwX0NMS19VQVJUICAgICAgICAgICAgICAoU0NVMF9DTEtfR0FURV9OVU0gKyAzKQ0KPiA+ICsj
ZGVmaW5lIFNDVTBfQ0xLX1BTUCAgICAgICAgICAgICAgIChTQ1UwX0NMS19HQVRFX05VTSArIDQp
DQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfSFBMTCAgICAgICAgICAgICAgKFNDVTBfQ0xLX0dBVEVf
TlVNICsgNSkNCj4NCj4gLi4uDQoNCioqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5
IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0K5YWN6LKs6IGy5piOOg0K5pys5L+h5Lu2KOaI
luWFtumZhOS7tinlj6/og73ljIXlkKvmqZ/lr4bos4foqIrvvIzkuKblj5fms5Xlvovkv53orbfj
gILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmL5pS25Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu26YCa
55+l5pys6Zu75a2Q6YO15Lu25LmL55m86YCB6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzpm7vl
rZDpg7Xku7blj4rlhbbpmYTku7blkozpirfmr4DmiYDmnInopIfljbDku7bjgILorJ3orJ3mgqjn
moTlkIjkvZwhDQoNCkRJU0NMQUlNRVI6DQpUaGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNobWVu
dHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJpdmlsZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlkZW50
aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxlYXNl
IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVsZXRl
IHRoZSBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlzY2xv
c2luZyB0aGUgY29udGVudHMuIFRoYW5rIHlvdS4NCg==

