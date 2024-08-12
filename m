Return-Path: <linux-kernel+bounces-282649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACEE94E6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C7A1F2115A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2FD152DF5;
	Mon, 12 Aug 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZSHtvBh6"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE91537A3;
	Mon, 12 Aug 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444751; cv=fail; b=h4wu2Lu+B78ccOfwEQuy64rWTxyO8nNUwFAdr2tcpCfW44DH9QIgM0kag1eF62sL4d0oSC7JK9nqstmt8L3gCZFj9jQRPuzvJwutpSPKFB4GHccAhOWHYgTxrLon1B926tZSk9kEmBYQ9TUTOUt2kWigvcpvdyGaQjxD5JFJNWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444751; c=relaxed/simple;
	bh=FKWs6KyRKwvDjDgykdmRZJlqQMp99lKDakDNFESBmM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KBBxkWHJacgfbAePiLAccbC9L5B8zBBeEZhYj9R1VFYKLq1RPbBwJ4Dqn+aIU1ehcNpBdRUWdll69QQfbjSql0Poq6GgLH6hWqHpz335gPAKpBRbRc39JGRrCWUmIY7CUqIThX/60StN425v8V4G16s8cRAyktnFYez0ODGKEAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZSHtvBh6; arc=fail smtp.client-ip=40.107.247.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1AdCZ+oQgahWCmbDzAEpf8WerM6INVtZt1Kduu7bEv5fL7hMfVs4QYTd/noo/5ZJLXNA87N3dF+arDblSjzXhBbsZwM8wUmXiM2g511gveEejlK89PDvhd0gw/AkjJU0FOgXqUQzs32dxrCYeRLwaIJti71SQGs7pJG8Fq+Gau4esRZ0c88GyQNVpDS7banbcHZ1wCUNqiTbZuGEz5BbMPFSoWAkwQ3NqL5rEmlH5W1isZX3ZKR0zoH4MWzrFlop3KT/Srf7bCBzUObvOEEEsh2Dy/iXgcf//nAFQ4aLbCBRu6lwhaT+MNgq950qY6r7F91ayrsBno6SiuXVSvvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKWs6KyRKwvDjDgykdmRZJlqQMp99lKDakDNFESBmM8=;
 b=Nycasd8WtZrYPys33nydij6KB2EH7KyPWzW+Bz5UCHUM82CgK6SbkVT1suzlnWlfJyizk/Hh8H7SNlkpByeKX8OF1TQXX253Gnu6O2ZzJh6mGhz5F1yaS1d1JXpKhrir52+YhXZRIfXNf8/QT6VHBoGF68bR59tBVoSACpyjWi9/ImZT296vaHAjt5FVsMnL00MItBMZ7w2h+uG1Y2cqqieXWupIKP8PrDj7uwCbekopVhUkU/QSy+HBumlCPzf3HADPBGVz25xnbuaGSrOQqTZxfpha0sNbKOuBTGPK8I9fI4nfycs1s+MG4v0zCx6A1RXDAXEDSi4PeBUj4XE9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKWs6KyRKwvDjDgykdmRZJlqQMp99lKDakDNFESBmM8=;
 b=ZSHtvBh6V2DvqsGvJnB4g2pUZZ6NQa9nIgSPuc1mr53nJRN0Fi+ZwRh6OmPtloSBvNiPODtFaY32aIe+r5JqGsgwNGumGr/8OSR9S91ymGPV2+U4nXi8yml+XuNQqKLER+bJjOm3VrnbSIjVkcA0hacfVn3d2C5cMeilJdSf/jfVUHVMAT/LUx8bSp6+VDwr+T+0T4Q+BVpmMfNfbedhWm5FArOBmF9MA/CeUfbrloCqNvgulOjoe0bzHi6aV/kthVqjpzPYIJTfozAewgw1kH+aTArmkmgJ+Axljzb8BdKVAepeCAcFCo6SXaseYxuDVy6AydzClrWXd5WS7wLn6g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10274.eurprd04.prod.outlook.com (2603:10a6:150:1ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 06:39:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 06:39:05 +0000
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
Subject: RE: [PATCH v2 RESEND 0/4] add NETCMIX block control support on i.MX95
Thread-Topic: [PATCH v2 RESEND 0/4] add NETCMIX block control support on
 i.MX95
Thread-Index: AQHa4VhnGQ3HS4wAAU2h5IUb71/J2LIjPhvg
Date: Mon, 12 Aug 2024 06:39:05 +0000
Message-ID:
 <PAXPR04MB851069B02D5B71BC7AADD38988852@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240729012756.3686758-1-wei.fang@nxp.com>
In-Reply-To: <20240729012756.3686758-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB10274:EE_
x-ms-office365-filtering-correlation-id: 9593dd38-bdeb-4d5a-d71f-08dcba997622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZVVWR2dmYmp3YUE4dWVlOE0wZVMrT0VEN0dRMmE1a1lUZHBUZWQ1QjlFVGdK?=
 =?gb2312?B?eWpxUnY5RDlxVlNscW1CUXplejVSTnRySk8vWTNmU1BlRHFCUkRidndkbTNJ?=
 =?gb2312?B?ZGZkckNENjBWUmtGQUlQaWpFMjFvNmM0WHM4MWxkZTN1L1BlaVlIaUJHL2lR?=
 =?gb2312?B?SGNqQ0JhV2xEVTFFRUk1RjlSNDRiRXluN0huRjBESXIyQVF6STIwOHBuOUJs?=
 =?gb2312?B?S1k5NFd4Rjh1bG0rM1E3SXJvLy9KaithUWRERU5xODMrSzhyMUhyM2tCbXlX?=
 =?gb2312?B?ZmxrNVZVdHVGY1c0TTdmdWNhalBYU1cyaHVhLzIrOUt5akRGM0xibm5Hc3VB?=
 =?gb2312?B?MCs3ZkpRTjhmY2Ewc0kzbFF2SDZjZFA0a0FMOVU5dHNiYVU2ZUZLNjgwWEpj?=
 =?gb2312?B?dk0xb05MNmVBdUtLV2ZpbElZTVNLME41VGV3T3pmc3ZVWElpZTByNW52Q3Iv?=
 =?gb2312?B?UWc5ZVUwS3BpT2tTQzcreGFZZERoMlpCU1d2QzdORTJOWEliMzA1elZRcWJ1?=
 =?gb2312?B?aFlmbG9KYStTLzJKeWZycitsQlM0WmREVlRtY2FYa1JxNHA2T3FOUE0rNFpI?=
 =?gb2312?B?YlRkZUlyK0JHb2NXZjU0eGpwN3l1ek1WNDBZaUVpZWNER2dDalR2dk1VMnFS?=
 =?gb2312?B?Q0FGdmI3OHkzZndQcHhHeUNKVGtOZlpPZ0ZlVURaZmZYSm1BZGIxazgvanBM?=
 =?gb2312?B?WTc4UE9hOVZ6eERvWEx4MVQxYTRRWFZMMzlVSTdMQzdkTDdKUStVU3hjZ0sz?=
 =?gb2312?B?UjdudTM5Q3N4c3RVbjlvNHlaS2Zzbmd2eUNGME9QaDRzbzJ2OG1SY09GQzAv?=
 =?gb2312?B?RjdNTFJHYXZWc0xxZWpQNS9yTEJvcXNtUk4xY3VUaElaQ0J4c0t0NnY4WndH?=
 =?gb2312?B?VDJvYmM1dTd6UmRnWVBPNlVsQkg2MHRkU3NsZmgwM0NITnR6UTE5RGx0NTI3?=
 =?gb2312?B?VHpYa3lNWjhWcGd6VEV1cGJZSkw4SEpZVFg4RTNBc1dYNEVQTkNhMkpld1gy?=
 =?gb2312?B?QWFaSzhpbnBlZU1JUWxteGJkNlJReDZXYWpYMUpuVzE1b05WREtmTFgxaVYx?=
 =?gb2312?B?MWZ2NWhreVlTS255b2dlQzdXZEVUQlkvU0UwbnBtVzVQZU8yZlZvRzdJNGZr?=
 =?gb2312?B?ZHlCSDgyUzJlaDQzY3Y4ODZuTW5jdlVXbEkwaWNIVU9jV0w3dHhPSThqZ0VC?=
 =?gb2312?B?MEc3UjdwbVIzUjdBVmQ0aCszVlhSMGdaR1FTVWtYeExoZ0lGQXo3cU4vcDVs?=
 =?gb2312?B?SElsMTNVSVhCeDk2VVhsQnZ5ZVl0Lzg4TDJ5bENlLy9rck1uRE5jYUhHUk1U?=
 =?gb2312?B?UXRWR2JXVFd6SjAvLzVuOEdPdHBiQmFIUUFZY25FV2VwdEJQbFE0ZGxRZWs0?=
 =?gb2312?B?L04xVU1CVXZFeFZMS05sSXlIV3l2eExQKzUyVUs4ZlB3T291VldjemJKUHRO?=
 =?gb2312?B?RXJFdDNKbTZhZEIzL05KTDZrc1YwdEhvZ3hSbEZoU1lOZnVic0Z1cGZHa0tn?=
 =?gb2312?B?MURPMGFQSDB4OElyV3ZhSTBqYzJNb2FCb0MxbHJoZm1QbDF1ZzRWd0R2VUx1?=
 =?gb2312?B?WGZMNHdYS01EcS9FbDRWMldHb0U0Ukx6cnBaak0rRGNFMGFSUnNYdXlPMDR5?=
 =?gb2312?B?alk2OEo1UVlkYVdCaWVlOEQ1dzRScHVnL0pJcmpvZHdkUTAzaGZpV1lrMVdR?=
 =?gb2312?B?b1o4RDREZTd5cVJnYnJTL1VGQ2NVMVlxejYzcWxuYTFaczlOTTJuRGt4RXFP?=
 =?gb2312?B?bjZJL1Q5elBWc3MyeE9ZdGYxcTM5dWtERGVpNVZuS0VOdEpmOUY3YWpOVVVZ?=
 =?gb2312?Q?rBhvQw34/V9qwIfGO6orVQPcYomE6sFZWUk70=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SllVcXZ6dUVxWEg2emw0ZTNkWVBFWnBYMmpIVnNwWmsraFMyTm9JV0dUSW94?=
 =?gb2312?B?TXdadzlpYXZaK0J2M0dEV0JhQTFSaGdEdjlkeTFsR0N3Z0lmMUYxNHJmRUFx?=
 =?gb2312?B?eVE5TVZzT3p5K3Y2Q1ZzYzBSOGN1cnZweWpEQlZMdVVsVTF4TXhzTG0vckZM?=
 =?gb2312?B?R1NCblBMR2tRK0VkcEY0aDBUSVpWaGkyK2xzZm5TaHdtZWR5cG9BVHNnMjh4?=
 =?gb2312?B?Z1M1QVBGcHVCbGpHZGwzdkt3cTFPODN5QStjcndRRGt2OUp3ZXRhK3pRdkpj?=
 =?gb2312?B?RER2TWxhODRyOE5rM0srZU90UTgyQ3RUYnhGNGFWaDZRdUdWOWVYeUUydWwr?=
 =?gb2312?B?cGwyejRwZ0w3YjVIdkNmbkdIL3JLZUwyY0tPYXZNU1ZFSWNrOGNOK1JDLzY0?=
 =?gb2312?B?L2pndUNuN1pLWHRuSDcydkRBMVlRVEgyUW9Kc3A5Njl3K09SSkkvRndJSnRv?=
 =?gb2312?B?OTlJdFJrTjI3MVR5dWI5RGRVZHV0cUJDUCtJQjY0bFZ1TVhRZlFCNVlQc2Zz?=
 =?gb2312?B?a0hzZm9WSWVSdExvV2Q4bVV2V3NpdnVac0Z3MnJtVXJNaXJMK0Ryc2VlU3lG?=
 =?gb2312?B?NEVUTGdzZkhYRUhIOHA5QmRZYjJrMHBIYWxiZGg1d09lQjEyOVFNWkFFYTVm?=
 =?gb2312?B?VVA0V1BvRzYxdmZNS3ZjRy9oWXZMVzlQNDdpYmVhdzl0T0xraUNOazVIZU5v?=
 =?gb2312?B?aWpieE1BZkdkQk93emw2SDVxdTJDZTZkakdUY3hXa3NwQmZxQkJZQTBlRjEw?=
 =?gb2312?B?ZlN3WnJMcUg0TzRHbDI2RXp0eDZCUythR3o3TEdDQnoxanVBSjIza1lzakZN?=
 =?gb2312?B?bk9UbExmcjFzMjFzVHpQVmVoa08yamZta1NJZStzd2c4Y2tRZGtXb3h6Q2lj?=
 =?gb2312?B?dnZGN1dEVFV6TGkwVi85WlUweDlIWTc2RUpWRHhkRnJZTng1bnI4ZGd4UzNw?=
 =?gb2312?B?NkZIOXQ5NXEweWdQQWgza2MyaVQ5UjFRcU9aeWpSb1htbVdHVG1SY3ZWM1Rn?=
 =?gb2312?B?Zi9NdUU3bTV1UFpjclkrWlg3a252SUJtejFTYWNSRENLQk9TSDNNdEt4K0sv?=
 =?gb2312?B?bWFaYlBidjdrZi9JSWhGaldleEdtTU12cmpxRXNqWFdieGpSZWRJN3R0WVpD?=
 =?gb2312?B?QzAvbUhMMHJ6OCszemJENlhEaUN0NStHVENCL3E4bllLelhqRWczbW9oY1lO?=
 =?gb2312?B?RzVFSWw5K0NtMjRKdlByaUYzOWo5Qkc0QTc1ZWpEMjVSNFNxQW85ZTVHSkxn?=
 =?gb2312?B?MkFucUJoOS94cW0xcGRRSzV6WWM0RFJHMUlmNUVJUXYrUEFlcm9xdEJJRGo3?=
 =?gb2312?B?UzFwQk9MeUpmVmhrK1EzWFFBNXh2MzY2YVpoakpOK2tLNzdESUw5T3Jzc2t1?=
 =?gb2312?B?ZEI4OXdyOTZwdEtqM2JZUTNISnhmRlVTQlZoUWMzbFMraTBweTRRbWoxR1My?=
 =?gb2312?B?NU5RdG5lV1lEb3R3YU80OWVEbzRrUkMyQ0RJZjJIejJuKzFpaDhPTVJSMity?=
 =?gb2312?B?RE1IeTF6S2JObEtKTExmRlk0dGNJRDdPZlRrR3VyQVpXdDF2WXMyU0lmbGkx?=
 =?gb2312?B?OVArSFFybjFlcFNkTjdXK3pNNHhqWmVRb2xVM2RsZGw5K2pWM0dHQVE1WC9i?=
 =?gb2312?B?R2o2TlRIVUdhWXRpb01RWG9xOXpRY3UyK2pibmY1SGF6a0FPdURkUG9GOGpS?=
 =?gb2312?B?Rlo3WGtOL1l4cS9BZEVxTVpnelZRcGF6NkFSTTBqZzkycTQ0TmlzcGpTajlS?=
 =?gb2312?B?eTRKRGF1cUZQb3p5bkVadFgzOVpHUFVQV3pQamk1cStidEJwZUYyY3ZpS2V4?=
 =?gb2312?B?ZTVYVnhjQVlJUmVlZDI0WkdlazFxckVEM1BnNm42cVNXb2NDZE9SYW1Zalpr?=
 =?gb2312?B?Z0FpeVp4WlpiNCtxM2VqbEJWZzM1VjluNDQya0xkcTFpNkczUW1BbnptNXcz?=
 =?gb2312?B?SGtta1FKaEs0dktheFp4bGUyTlRtTnp2TEJDaHJZeFBySjhjSURhSkZCcDNC?=
 =?gb2312?B?M3VLK29pVG10K1daeS91ZkVSRFV5NjVxSnpYVDJwb1ZQR1Jpd2xxNE41Tlhw?=
 =?gb2312?B?NnVvTEpYb1hsbjR2eGhuckFhY2RwRHIyNHVzaThxMHhUZ2JBVmpBUEdLYXl2?=
 =?gb2312?Q?q+1Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9593dd38-bdeb-4d5a-d71f-08dcba997622
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 06:39:05.4247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+FitwB9zxvAVGMy06oxQ9bNged3NNnIXkvHdOXGO40vewwklwpaGn+rqDdR1yGlfHLVcCpUsVlEE9L2yYfeGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10274

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZWkgRmFuZw0KPiBTZW50OiAy
MDI0xOo31MIyOcjVIDk6NDENCj4gVG86IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBr
ZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWls
LmNvbTsgYWJlbHZlc2FAa2VybmVsLm9yZzsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+
IENjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRD
SCB2MiBSRVNFTkQgMC80XSBhZGQgTkVUQ01JWCBibG9jayBjb250cm9sIHN1cHBvcnQgb24NCj4g
aS5NWDk1DQo+IA0KPiBUaGUgTkVUQ01JWCBibG9jayBjb250cm9sIGNvbnNpc3RzIG9mIHJlZ2lz
dGVycyBmb3IgY29uZmlndXJhdGlvbiBvZg0KPiBwZXJpcGhlcmFscyBpbiB0aGUgTkVUQyBkb21h
aW4sIHN1Y2ggYXMgTVFTLCBTQUkgYW5kIE5FVEMuIFNvIGFkZCB0aGUNCj4gTkVUQ01JWCBibG9j
ayBjb250cm9sIHN1cHBvcnQgb24gaS5NWDk1IHBsYXRmb3JtLg0KPiANCj4gLS0tDQo+IFYyOg0K
PiAxLiBQYXRjaCAyIGlzIG5ldyBwYXRjaC4NCj4gMi4gQWRkIHJtaWkgcmVmZXJlbmNlIGNsb2Nr
IG11eCBmb3IgRU5FVEMwIGFuZCBFTkVUQzEgaW4gcGF0Y2ggMy4NCj4gTGluayB0byBWMToNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNzA5MDczNjAzLjE5Njc2MDktMy13ZWku
ZmFuZ0BueHAuY29tLw0KPiBMaW5rIHRvIFYyOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNDA3MTAwODQzNDUuMjAxNjY4Ny0xLXdlaS5mYW5nQG54cC5jb20vDQo+IC0tLQ0KPiAN
Cj4gV2VpIEZhbmcgKDQpOg0KPiAgIGR0LWJpbmRpbmdzOiBjbG9jazogYWRkIGkuTVg5NSBORVRD
TUlYIGJsb2NrIGNvbnRyb2wNCj4gICBkdC1iaW5kaW5nczogY2xvY2s6IGFkZCBSTUlJIGNsb2Nr
IHNlbGVjdGlvbg0KPiAgIGNsazogaW14OTU6IGVuYWJsZSB0aGUgY2xvY2sgb2YgTkVUQ01JWCBi
bG9jayBjb250cm9sDQo+ICAgYXJtNjQ6IGR0czogaW14OTU6IEFkZCBORVRDTUlYIGJsb2NrIGNv
bnRyb2wgc3VwcG9ydA0KPiANCj4gIC4uLi9iaW5kaW5ncy9jbG9jay9ueHAsaW14OTUtYmxrLWN0
bC55YW1sICAgICB8ICAxICsNCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1
LmR0c2kgICAgICB8IDEyICsrKysrKysrDQo+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDk1LWJs
ay1jdGwuYyAgICAgICAgICAgfCAzMCArKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2R0
LWJpbmRpbmdzL2Nsb2NrL254cCxpbXg5NS1jbG9jay5oICAgfCAgMyArKw0KPiAgNCBmaWxlcyBj
aGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspDQo+IA0KPiAtLQ0KPiAyLjM0LjENCg0KVGhlcmUgYXBw
ZWFyIHRvIGJlIG5vIGZ1cnRoZXIgY29tbWVudHMuDQoNCkhpIEFiZWwsDQpDYW4geW91IGhlbHAg
YXBwbHkgdGhlIGZpcnN0IHRocmVlIHBhdGNoZXMgdG8geW91ciB0cmVlPyBPdXIgaS5NWDk1IEV0
aGVybmV0DQpkcml2ZXIgZGVwZW5kcyBvbiB0aGlzIHBhdGNoIHNldCB0byBiZSBhYmxlIHRvIGdv
IHVwc3RyZWFtLiBUaGFua3MhDQoNCkhpIFNoYXduLA0KQ2FuIHlvdSBoZWxwIGFwcGx5IHRoZSBs
YXN0IHBhdGNoICgiYXJtNjQ6IGR0czogaW14OTU6IEFkZCBORVRDTUlYIGJsb2NrDQpjb250cm9s
IHN1cHBvcnQiKSB0byB5b3VyIHRyZWU/IE9yIHNob3VsZCBJIHdhaXQgdW50aWwgdGhlIGZpcnN0
IHRocmVlIHBhdGNoZXMNCmFyZSBhcHBsaWVkIGFuZCB0aGVuIHNlbmQgYSBzZXBhcmF0ZSBwYXRj
aCBhYm91dCBEVFM/DQoNCg==

