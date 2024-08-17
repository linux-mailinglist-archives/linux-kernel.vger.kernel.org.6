Return-Path: <linux-kernel+bounces-290517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E61195552D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A602E1C21805
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 03:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1575754648;
	Sat, 17 Aug 2024 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J3HoAvNg"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50F101DE;
	Sat, 17 Aug 2024 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863895; cv=fail; b=XteXY0tsNT9VE7+JM77U907jDiD5Xa3yX2qhoUh5AiQCZbWDXUuqER3SzzUS3u6K/URlIeeKuWMVzn6cTRc3jGUJnZum89gt87ac2XqrHYMcx10j4Y5jNHXNgWOIUgJ98Q5q5HMZm2wYuyLOL248+17phqhuzSe2DU3k60usWLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863895; c=relaxed/simple;
	bh=ols2w6edC7LPVw5Hig7McU28CFu4uJJMVaCMNtpwx74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPx6W10FI6Cz7Bf2SZfYoQcJaOZq7S2WG8pM5zevKigsQrRT3I9VRBS+eWnCdFtx6lxbHAoCCk9MRHTP7D8zwtXjmYqOkDFYeIqcCIvp+xzMl0qYhYNXVObwrX2Ve/bUt5GeYeIca9OI0ns/lHvkalXD4kCREL4i8TQPfe+QJ7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J3HoAvNg; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2zCHKaaVoDKC2dPYx09sPmGmAcqL17PdmTjMb2relOpB58gvlKUt/kaPotpQkt31ML9dJlesuEGdr1Dpnmfhtol/DVKFFvygcdmEPhxDX24GRVM/HFwdjIgWpoN7Gs8OWtLcNqO4++J2Q+bmX4fosz99flrJFoGuUN3chCfQP342/NIio+/nmxgM0u9i/fKPY9K2+h9FeMN+KTRChnQo7nVn/R1QC4bADBdMHqMRjhMWJEh20+Zlce7h4Z4aio7TXTcNkOy08NDv3tWilTRrn+ZYB4jTrL0k0k6zjPF5ripxaM4uV1UJAW1EfcHxbie4pDE09Ixu6BwpvqkpvTgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ols2w6edC7LPVw5Hig7McU28CFu4uJJMVaCMNtpwx74=;
 b=bC86yUn8V7NyRnxm/oMQDQdWk/p1Pacbhtu6XPHeiuk/43Y327Igs3uHpmHGAE2kJTY8Klm1COWjwF7LoC30sR3sacRElyNrairC4nnVbBboLd7fe/2+wwTPjKSvwKx9Sg51t4fyXfO8aovbZrpynKqtuqvCZoCroPiG7FJTk/NXQBhU34/r+kBk43GJdAlvxrd0eox4S1nMD6NNBJwS9eMsuSHANxs92TRIZZcG2U4Vfq2I+v6mJQQLUbbpi7fvqWFdMdu5+buICeKSFJ1v3jF2eb/9ENxcC0OKg3XgOMuDU+MWY/IalPElo+EEnS+2yx1onvdY/krQC5f+AAgKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ols2w6edC7LPVw5Hig7McU28CFu4uJJMVaCMNtpwx74=;
 b=J3HoAvNgMMuW23nu0N0DXbGIHUS9IlBTeJYAQUo54tKDUB4SVb/g7PNxa+Cr9s3p/34P/eMf84+ZEOEUXSgnTCuxTf2wxlY9Ys5V9umRObr1RDArf91fv+cRuwxI2ihps2zRbizHWCXH3PObPC42VTRAEYumYnjkakB2QtF8W9WC6o8OutJRx9PfhvDqAfx3bd9B3Nl4BcUmipZ0eqJIERokruOOP3kFAgjS/tfNE1+FT01rmgX3Fy6p2PxebMqCOx6L49oEQlHELWmf4Q8F7gUAamavN35ECf64IpDE79UhWRGEgxAv8pmhs2verrKNWXFvZTc+T9Za4fTtGla15A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB10008.eurprd04.prod.outlook.com (2603:10a6:102:38b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Sat, 17 Aug
 2024 03:04:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7875.016; Sat, 17 Aug 2024
 03:04:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli
	<luca.ceresoli@bootlin.com>, Michael Turquette <mturquette@baylibre.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] clk: clk-conf: support assigned-clock-rates-u64
Thread-Topic: [PATCH v4 2/2] clk: clk-conf: support assigned-clock-rates-u64
Thread-Index: AQHa5mkyoyhloa/0yEC8gnGLDGMVHLIqiIcAgABOskA=
Date: Sat, 17 Aug 2024 03:04:49 +0000
Message-ID:
 <PAXPR04MB8459AF6361C6A99058E36C3C88822@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240804-clk-u64-v4-0-8e55569f39a4@nxp.com>
 <20240804-clk-u64-v4-2-8e55569f39a4@nxp.com>
 <679c72b4ee50f66054a90aebe391b4c9.sboyd@kernel.org>
In-Reply-To: <679c72b4ee50f66054a90aebe391b4c9.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAWPR04MB10008:EE_
x-ms-office365-filtering-correlation-id: bdca7b80-8546-4598-b3ae-08dcbe695b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXJQWG9Qd2UrRlZadFZnMnJIdGdiOUtOaldTV3FOVTFFTmY1R0EvK0hwVHh0?=
 =?utf-8?B?OXFaOWp2bllBTTJXODA2SEh6c00yYWdZeGpzcWo4aGo1RC9MY1Zza3lXV3B0?=
 =?utf-8?B?bmczbi9QQzRkMFhiVHl5RjdBTnIxUjhkb3BlN1VFeE1SZXE1Y3M4UXRpeUl6?=
 =?utf-8?B?T0ZpSURWQXdkbXJwZStpQlhoVXgxMzBVczd2NEhEYldwVDZ1cFVlWjVtKzhn?=
 =?utf-8?B?eVJCZlN6Z1Z5anh5Ykp4ZGtPNmpZb2ljUTYvbWJQbGRsTi8zYUpIMUZsVDZF?=
 =?utf-8?B?SEtlTG82bGRQQU1BbnlQK1kweU1MSGtUZG12UlpTWE4wSVlPc0kxTlFveGc1?=
 =?utf-8?B?MG9RTGpoR1BZeHk1dHZ5OXp4K3B0czNObStnZ1A5NVl3WkozNzhKbUxuajl2?=
 =?utf-8?B?QUlzUWhGY0ZmNk1wRHhNNnFvMXRZR3dMaGFac2wvUDVlalQ3OUFuUjBxdzYv?=
 =?utf-8?B?dkV1WndHUmxUazljWGdMZlhERVZGMGFvQ25uUXVVeTBhN2FKOXFUSS9wNXpI?=
 =?utf-8?B?Q2Q5dzNESUJnN1ovakZDZ3p1S3paYXc5N3NJNkxCZ1JwVGxuanArcVNxN1Fv?=
 =?utf-8?B?YXNzUFRKVkE3cFpTaWxLQTEyazZHRnpBajdLV1NyamVtU090SG1NZm5ZeC84?=
 =?utf-8?B?N3kzT3RqWnY2clEwRzZHRzdielBmemJrUFpHRTFWR0c1ZVhDQk8rNVhsVGho?=
 =?utf-8?B?a0lIdGxjTTZvVk5lWVFKcWNQN1o3ekI1M0NjcFhGbG1FZjdDVEN6MzlwQWlo?=
 =?utf-8?B?MlZuMWdJbmtsaksrb3A0SVMxalpuTnpwZmxWTS81Z0hqY1ZSMnYxQ0pRNzFn?=
 =?utf-8?B?M1p4Yk5WblRDemJoWnpkTHpuMjF5L0Z2TjdXRnMyZUNGYXN2blQ0VFRUbFg4?=
 =?utf-8?B?NFplT0tXdThTdTVkUTJxOTBRUXVxOGJaNnFaSmViMnJYTGNsSW9iMjkwdlBI?=
 =?utf-8?B?eFQ4MW8wZWdQL2daVG50MVBjMjA5cVRJdzM0cHBjMnZDaGpncG1SdnFSQlZZ?=
 =?utf-8?B?UWZDQktWbmQ3WXpKQ2l6OWg4c1JHY2FCUElCQUlnb3c4bCs0TUhvZHBXU1RY?=
 =?utf-8?B?VFpUL1VNclVOMm1oRGRtbjB2UjVPZzRmcFMySlFHRVdkR1lSVUt4UXR3cm5k?=
 =?utf-8?B?N3oyUmtBK2pTdjNDc1NKbHV0eThQd1JYZ2p6TU9pNFRjeGV1aG9xK1ZwSVY3?=
 =?utf-8?B?YjRmcVBWaE9Nd2loZ0tGSFZSK0xQL1VEc1FDWUkzMlZFQ1Z3d0RBN0ZmRFlV?=
 =?utf-8?B?Ky96VXBESFg5WDNjd2tpZmhsVkpBQzBnVUNTYVpRK2JwcVBjRkF0NjFoZUN4?=
 =?utf-8?B?RVB1OFUwYk1rOXZUeEJXaDhwMEFEMVMyRTNESXdMWmpNemh1ZGkvYVZCOVZZ?=
 =?utf-8?B?SEhHUVhRcHg3c2o5Mm5QcTREODg5ZlgwZHFJYTJxeG85dmZXT1dVSHVXT1g0?=
 =?utf-8?B?QUFOMldyU1cxaE9aT000djRGSENYMEljZXlGSHVCNnRvaFR1bHFXWTBtNm9t?=
 =?utf-8?B?ekRjVFJuaFU2dnlDUVExM2lMWGZYNFlUTmhIUkY0UHR0dVBMcDRKU2hEZ25n?=
 =?utf-8?B?WitpQVlsQ0JvVTRid1ZDbkgrRXpCalpmdjNKOTNGbE9JUGJmdWJObGhpS28y?=
 =?utf-8?B?T28yNFZISzNKRTB4ZXJtR1JzTXVZWDkrR2QrUmNPMEgwaFdWZ1FnZHNpQXcx?=
 =?utf-8?B?TXZBRThMaHFxYStTNytJbURYbjJyZGN2OUIrbzBnWEF3UnhLTy9BK016Vzk5?=
 =?utf-8?B?S0UyWUF6WWUyM2NZWnN4NWMwZHlUVjJGSjFHcjJsTjUrZkRtWTRnSFkwelpL?=
 =?utf-8?B?UDFUb0U3emx0UTRVaisyUW81cXhIYTdBQ0ZBdUFyQkh1eW1IT3JqeE41V3Jj?=
 =?utf-8?B?bURmVXpPMWNQWWlPRWhIT2hXV2ZwaW5sSk9HSXhKWnM5NGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?endWZVdzekE4V1BVcFh4VmZuTXI1RmVJOXJhWWZCdFd4cy92ZVhQaE1TTTQz?=
 =?utf-8?B?MFdicmV6VFJabDF0SDlVYUpxMFN5dU83R2phSVhUb1A5SHpPTUVJQ3FQTGo2?=
 =?utf-8?B?MTRzQ1ZEcHNoSFNHaS9CQ20rdi9kazRKTTdBWGpYTWZPNVlETGxVWm5jZXd0?=
 =?utf-8?B?eUUzQi9YOWlPYWdhN2FJSXVqUTBBb3czcGpySG9WSEtrTWRWN2VmVkxrQ2Ns?=
 =?utf-8?B?VFhpSDhNY2s3dlpORlljVVcwRk5rcjhSQU90b1lldWowZTcrTU1abHlDWmx0?=
 =?utf-8?B?V2s3QlA1Nm9uN0pDTndXdnRxeUwySTJUM2RmV0lGMHh6bFJXSHlIRUhSVVY2?=
 =?utf-8?B?bk9jaEFkSUk5YTI2SFp3Tng5MUpsOWtFM0hkK3pvNnBldUErVnlob1lxMXZh?=
 =?utf-8?B?QmlqR041WVBvRmVIM1I4Sng0RllMbTJ0UHQ0UW5kQzNFRmRaTUNiM0VicSt1?=
 =?utf-8?B?T0wyT3F3d2hFMW9TRUtOZlNLVlFhbWJZVDZXaGR0Y0JzRnM5bkVCS0twdVoz?=
 =?utf-8?B?Q2lWQWp3VnZVbFFNaE1neC9lbVNWS3ZhaldDRjE0dmFDMjFaeDlvajY0NmZP?=
 =?utf-8?B?RWRkTFEzeGtCcTRUaFNBbEFzRS9NdHh3bTJtOXU5RWdnZXV4K1N2MGMyYkdq?=
 =?utf-8?B?aHRLbkd4RS9LUStXUzBJYVc2VktGQ1BuWmNFY05mTFZkMHFVY05RTVR3ZW1s?=
 =?utf-8?B?ODNld3ZkbGw1YVFtKzVPVk1kUHE0MWZUTCt3NmZhczNwV1o3VjErOGlnMFdY?=
 =?utf-8?B?NEVoOG51aEtGNFdET1J4d2krRUF5SjB6TTkreDVOeDQrM3ZXb0REdk8vY05K?=
 =?utf-8?B?NE9ERFM5SGtVTFdjQ29EWXBXVDhDRGNJR2ppUFVqZlQwUnRQb2poSDVPUUJr?=
 =?utf-8?B?UXo1aW5UUjZ0dVVEMmZpY3BaNTRlc3Q5eVU1RktNWVphVjExMk5BZUc3dzZL?=
 =?utf-8?B?OERoWDJKeDZHNWdscXFFWFNHOHNuZHBmTEtGblZLZERaWmxTejNueE1LNUw0?=
 =?utf-8?B?eVF3Z2RWYW5nZFBoUzREQkpHbE54SlR3bkNoRFRYMlVVZ0VKeGdYWkJmSm1R?=
 =?utf-8?B?RERWUXZmNVZsc0o3VjdUcFB5Njl5RnhyNi9ta3J2NDRESWxyV3hiSmRRVVhQ?=
 =?utf-8?B?TmFkNk1rSTJMdjN2bzJsUHhma0RybGR1OGFZRjhsblpNV0cxWm9pUnBYZFRV?=
 =?utf-8?B?NXJLMGZVbjJKSVlpcXpsY01SbnpxWDQzOHBwUy85YkkvaisyVFN1a2VBMlIr?=
 =?utf-8?B?T0poUkh0QUJodmNtbHFLVW1aQk01ZjBkTm9sbjJtY2lWVEx1ZERMK2xOY2Rs?=
 =?utf-8?B?ZlBEYURDcVRiRDJteklMOVNaaVY0ZHJtNkZURVlmejRyWTdFL3ZDaEgwSlZN?=
 =?utf-8?B?OXY0YmhnUUZwa3F0aXRTS09CaEhTMm5USXlQNEVZSUdzSkMyRlMwM1BiM0w1?=
 =?utf-8?B?TlhBL2ludDdMNFAwTnU1MldIQmdvZFp3em1Nb29jWExudkxrTFlaRmdUY1Nx?=
 =?utf-8?B?MjNJcEU0bExhUlQ5d2hVbDJxclhSNEJCdWhpa0g4M20wSWlnV3A1VE5pVXQy?=
 =?utf-8?B?V09ja3NrRmEzVDFSVFBmNUhOQmhMR3hYamVUeHRIM0xZWnpKbGxLNmZqWUFn?=
 =?utf-8?B?UkNnN3lacG1XTktQdXVUa2U5WjdJOUhGU2U0NzhMNjhQYTFQM05HbnF4eEUx?=
 =?utf-8?B?Wm1lODREeGtvR2hBY2YzblRjN3h4dzRFcXNvNmRaMk1UMUpGQTBFblhSMTFj?=
 =?utf-8?B?Tm02ZUZsTGpGVTYwOXN1QUNmQksrSDV5Kzd0cGlwdXYrYWZzL3VMc0RtUUJq?=
 =?utf-8?B?VVI0NWlBeUFaNW9mM1pLNndneXRJUE00Y3IreDFWMzQ0ek9qTFFzWWJtWURE?=
 =?utf-8?B?NDNLTVo3Y2N0SzEvTkRGVGxQU2YrOEptV0toY0NXcXFCTGdmRzlBNVlvVFdO?=
 =?utf-8?B?Q0VDMVFaSWpoWnQ0Ui9aaWtWYXpWME5kQmI2L1pyYUlNbUpOd1FIVjNER3Iv?=
 =?utf-8?B?MnBMVHdFc243cUt4amFoM0pZRzRKV2dLY1Jrc0dYQjVBbHNNSnpRdGV5T0Jl?=
 =?utf-8?B?RmxJZlNhMVM4a2VvY2VQQnVJaHVud1o0S0llU3cyTEtXREd6eWJtTjdKM3Vn?=
 =?utf-8?Q?Luec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdca7b80-8546-4598-b3ae-08dcbe695b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2024 03:04:49.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYKj3jqTaa/dYY4BQ6Icb1qeeFnVXu9VfqLpxuWvt/+QG0W/COG0tCjM6st2dslnm2O6Z9ePEAHCoDLWivgZHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10008

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvMl0gY2xrOiBjbGstY29uZjogc3VwcG9ydCBhc3Np
Z25lZC1jbG9jay1yYXRlcy0NCj4gdTY0DQo+IA0KPiBRdW90aW5nIFBlbmcgRmFuIChPU1MpICgy
MDI0LTA4LTA0IDA1OjMyOjU2KQ0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
Pg0KPiA+DQo+ID4gaS5NWDk1IFN5c3RlbSBNYW5hZ2VtZW50IENvbnRyb2wgRmlybXdhcmUoU0NN
SSkgbWFuYWdlcyB0aGUNCj4gY2xvY2sNCj4gPiBmdW5jdGlvbiwgaXQgZXhwb3NlcyBQTEwgVkNP
IHdoaWNoIGNvdWxkIHN1cHBvcnQgdXAgdG8gNUdIeiByYXRlDQo+IHRoYXQNCj4gPiBleGNlZWRz
IFVJTlQzMl9NQVguIFNvIGFkZCBhc3NpZ25lZC1jbG9jay1yYXRlcy11NjQgc3VwcG9ydCB0bw0K
PiBzZXQNCj4gPiByYXRlIHRoYXQgZXhjZWVkcyBVSU5UMzJfTUFYLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+IA0KPiBUaGUg
cGF0Y2ggZG9lc24ndCBjb21waWxlIGJlY2F1c2Ugb2YgbWlzc2luZyBzbGFiLmggaW5jbHVkZS4g
SSBhZGRlZCBpdA0KPiBhbmQgYXBwbGllZCB0byBjbGstbmV4dC4NCg0KSSBkaWQgbm90IG1lZXQg
YnVpbGQgaXNzdWUgZm9yIEFSTTY0LCBidXQgYW55d2F5IHRoYW5rcyBmb3IgaGVscGluZw0KaGFu
ZGxlIGl0Lg0KDQpUaGFua3MsDQpQZW5nLg0KDQo=

