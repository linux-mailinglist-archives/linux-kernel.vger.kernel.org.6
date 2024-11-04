Return-Path: <linux-kernel+bounces-394313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909DC9BAD44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEFE281D42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC0E18B491;
	Mon,  4 Nov 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uFHMs8ig"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42F15B97D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705931; cv=fail; b=u+7ATZtgnvbaSL779woEoWzX699nNRlily7Wi2KM2MpKmdNGWRhzA6ZYxhMjI+0sJK2dx4fTCVfoP+Fq+Ae+88TGAxYaIRrYP1DsG4KNKIg029YRLf2J6awDkHWI2hLJDhhqQ4V0R2UQDlyyZFTMJ6ldlPPqe3zHucoxEZ0OR0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705931; c=relaxed/simple;
	bh=b6oblxpmjGKHQavWghNoX7J4ITrADTRwaNx28BO9hHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SkPj2yGMttHuqONY0IMKi/TMGWdR2Bp3uVpDQ5gra3ZwSHXOpv6Ee44uayW9qfPgh7UJO26gjbul/vHMPv+wULkl0pmizSB4ikknGsP8fsS0aEWADASpfF5s2Vwcx/i3sv2PHJURV4ipIuBD0VMn8K4fs9PRiKWZy9i9/FzqD0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uFHMs8ig; arc=fail smtp.client-ip=40.107.249.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJG+XBI3J6AaM6x074ddK7tEAMzMcELNZRNNf9pHKa31IqBvZl2+kI1N8HPt/BHImLqLXq0PFMuKe8S8taK531kHsahcVQLrKi+6bQD93jqfnGUce52KV7hqHc7VoFyoJfBjtMoANsqxFTF+np6h8q0TE/edUhxEnJ037WufW13ceY09J/A2boxaSNj70JuTQTzP343H4Z2WAuFkjm9HZze0WkH+Q3ESLZlCsZ1MP4BIabBDhGsKHaBU6ABt9f2tvT5I0I+9xLzmoD1/NhhUbNrBqAQXQHiokHhVv/2Bfdbdmh8OidI8salUk1IwPQKqiU78UIC8MDm2AQzSofxn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6oblxpmjGKHQavWghNoX7J4ITrADTRwaNx28BO9hHI=;
 b=IruyZRxA2BHE5vZRepqkYEcLJcA1EBVl+2N54uAThlDSLJssnV5/QXGbrXiacXd5H3khuxeHClBgu9zPeyZ/m2tg0v2AbjlEnYil6bvWX37FG23QwIXoXp41d2vdIAsucMj+Sjq2rqbkmfaesXx5toY18Ennced+A3zCF9E/AK+1FkuRIzZB2KW/ZcRQgdX4teI3NGfXZNMbj7bSdYqVYvhNl+//w6qj4IwVURx/4rqs8QjtCTE1IQUQJLor0jQZ1JjsX0iSOx06/pccc9NWMKgVVuwKBRGrWQ0q4LMiLvR0cRARSlxcn5iGWmST5b6xJ94sv3C8f9IehtFYV/29RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6oblxpmjGKHQavWghNoX7J4ITrADTRwaNx28BO9hHI=;
 b=uFHMs8ig0SFBWxAdWRNZ2RPE55hApqI82aEO3rnhFvqxWHziA8lUfFWEVKWXhCrkWqKKJSU5RpXJ8PlaA3+M1UZ22p9cT0Orf2Lunw4Ha/1YV6V776y8e/0v9i2sNCXyUMNd/QUS9SVFCZCN69CERANJNOgN34SqO8emM+T2e42mITpLSkd4WSEuLLV3DSdwP/mSpUxNWjUEMedUQk2vzRxg3G9WZ7GKEzZ4GJlwt/jCVNNnfav9XSqsafF61mSeeXM84nTIgMfcSyDI/XeK7CynPBF8ItTaWgrcvUFQC5XrDAF4M+CFqoLGvXvIc96XRYZ4XBoveESTSs8asdhZ/w==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7566.eurprd04.prod.outlook.com (2603:10a6:102:f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 07:38:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 07:38:45 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC: "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
	"wahrenst@gmx.net" <wahrenst@gmx.net>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>
Subject:
 =?gb2312?B?u9i4tDogW0VYVF0gUmU6IFtQQVRDSCB2NF0gc29jOiBpbXg6IEFkZCBTb0Mg?=
 =?gb2312?Q?device_register_for_i.MX9?=
Thread-Topic: [EXT] Re: [PATCH v4] soc: imx: Add SoC device register for i.MX9
Thread-Index: AQHbK2HqSs3rPN6zi02O4jrU9ZWFDbKmvvwAgAACrrA=
Date: Mon, 4 Nov 2024 07:38:45 +0000
Message-ID:
 <PAXPR04MB96443FF2F5F1B493FD8303E2E2512@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20241031065438.3912960-1-alice.guo@oss.nxp.com>
 <Zyh3KkEQ7ZFY9870@dragon>
In-Reply-To: <Zyh3KkEQ7ZFY9870@dragon>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PA4PR04MB7566:EE_
x-ms-office365-filtering-correlation-id: b97b7e09-1ed3-4cd3-f22e-08dcfca3b697
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?QVRka2FOWDg0R1VwdkJHWVYrZUVGWk8yelpTcCszOVZNUUsySDNsOHNCdjhh?=
 =?gb2312?B?a1FSODlyU2RGNElSaVdrd25MVG1vb3B1NTRoU1NzV1J2MmV2b3JhM0FkQ0VC?=
 =?gb2312?B?cDRpaHNBWUdUb1J1V1BWcERlUDVkcWQyZjROcWJwOHNKYURqTkNqMHFWYVUz?=
 =?gb2312?B?M3VYTHJ3NVF4NjNjcmovcnBvTkczOVR1V0MzQk1XaTBZaW1Vd1B2ZmNtNVhx?=
 =?gb2312?B?ejVnRk1Vd3lJVHgwbm52RjRrL0pTSGVkSUFvMk5Gc1ZnUFN1UjZ5VHpQR3hv?=
 =?gb2312?B?aVNyMmV2QlFjcDdIOCtWWHZuNjlMQTFCc2JWMjA0ellvWHl3VUVXKytyRWo0?=
 =?gb2312?B?QldiaFVaeUx5RWRsYTF5dGhrUzRSaVFYQ2Q4dTZHWVRpK3JJZ0NrTHNWd3Vn?=
 =?gb2312?B?bUM1N2oyZEFYY3pVQ2NnWHI1eG0raDAxdWErZExMOE1neGpKaUEzMVRkZWlI?=
 =?gb2312?B?K011cUlmQkNzbzc1SVZ0alFIU2Ruc2w3TTc3a0lZZWZyak5YZEJEMVpGSENK?=
 =?gb2312?B?aU5xR1F1TUlqa0EyVjJCUGJIajVxVTNJbHlUbnRTV2pvWG1rdkVkdnIrQW45?=
 =?gb2312?B?NUJNMGUzb1UxOUpHakcyNFJGWTh1YStyenZWMGlKV01OZGdHYXhORmhVc1FU?=
 =?gb2312?B?MVZrZEFnQm5vWUd3a2RKcGNRN2VTRk9hd1I3c2hzUEFNNldrNmZHV0FvYUlO?=
 =?gb2312?B?OWtJbkcwTURRSWRJcVNqTGlXUzl2SDhUUlRKWjZ0TDNWRndOcGhSbWt0ajd3?=
 =?gb2312?B?dnl3eCthOU9JMmdOdFR4enByZXBNTHYvWkc0SmNHbXBwcTRSN1ZZV2NyNnV2?=
 =?gb2312?B?T0NTZElQSE9mZjRlWm1RRHlGWVFINnRRZ3JENFQ4L1JIRWtVZExEU1o2ZS9H?=
 =?gb2312?B?dlNkUkxGREYyS21XMmVQazlBTGg5bksxMDZqTENORVFnQlBGRjRJS2hrZ3ZD?=
 =?gb2312?B?bkpSZTk4UnM4U1BLaXcvbFlrZzFyRTVxaUxmRGJUemFtY0xEWkdFQmZkMW5u?=
 =?gb2312?B?Z201aU1YUTl5KzIxQy9TVTdxRENiaTNZV1VLcWlHQVhXRkJna2JrWnp5c3J3?=
 =?gb2312?B?dEFyaEZ4NmMrVDlMMXV2cjRiU0Qwd1lYdS9kcThDSDRqQkNpbW9jWWlYeHdk?=
 =?gb2312?B?S2JuTkJzdzFYYmJxaFc5SHQzQ1VlRHdmb0JwblJHNmJTbGl6ckxpQ2ZPMXpI?=
 =?gb2312?B?NlZiK2J0cVVvRnBQQ3R1M1lUcU15clp6d3NNVFVueWNoQ0crSkFMNjNQckp0?=
 =?gb2312?B?aEdycGFGUkNDUGhmK1VJRlNvckk2WTNsOWRQNG4reHhGYnYxVGV6MEx6NC9r?=
 =?gb2312?B?QlZjNDEwU2h3Mk5yMEZkZm41cWxxVjIrVThjNFh3RS9Ramo3VWY2Y2FXRkpw?=
 =?gb2312?B?eFRYWExNcEp2TG40dm5FV3dTNVBlZEM5bjdIaExJa1FTV2t6MjFGeWNSOG9L?=
 =?gb2312?B?M0dGREVpWm1ia0dvUHhLQU9uZ0lwRXlVNTlnWmMrU0c0cFBMRkxISkgzUzAx?=
 =?gb2312?B?dzZ1cGpmMzZTUEQ5UmJHb2xlSXRKdndTdGxlZDhhWWZMVkZxNWJhZDdPNFBa?=
 =?gb2312?B?d2N0SG1aRDhRcndpR2lLM2MwdmZiK3BjQlk1REF1blVHTmd6UElWa2g2K0pE?=
 =?gb2312?B?T0YyMG5leENtaVlPWVh0RlVMVGJiL01IYlBVQmdjUFc3UitwZDFMc3d6dUJu?=
 =?gb2312?B?THptK2MrQXp2cXlPdll1YWpIZjN0Qkk1bFRvaFJNU1pGeGNLVUsrdVYvN2JG?=
 =?gb2312?B?V0RndjZBS0xFVG04NVN3Mk1mU1UxRWcrSS9HYVNPcDlzWlJ3ekVKVEd0OUhv?=
 =?gb2312?Q?zMLrtK7G4MP5BnExZGoPWbxcGWPFWQkRhCHZA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dy9oZ2N0czZZU1RWdWl5RWFwRUpQNjZraGMxZlluOVYycUlhRGc5OGEyTkRu?=
 =?gb2312?B?TlBVaUl4RGVjcUorR3BxZFlNejZUVXhlNnpUcEI1RmxNVzZLSkZLZTNxL0g0?=
 =?gb2312?B?ZG1SOGE5eHRrak9yaTdUQUVQRkQ0Y0RNWmFaUllUMHRIZExxOHpRa0xMN1cv?=
 =?gb2312?B?UUtSaDJ0bi9UaC82SDJWVm5WKzdLejBjUXhwN0NKb056Q0hoMG1VVDlKZER6?=
 =?gb2312?B?bnlhenRJU1Jab2xHcDZGaFU2akpLemlBeDVHa1JBZEhFRzBHODM5MDBmd3Va?=
 =?gb2312?B?N1paVEhwWmoxSjVuTElKQlBtdXJGaXlhS0xKbzVpNktCcm1HRVhaNHBIaUpH?=
 =?gb2312?B?YUFYYm1YaXh1Ky9mZUtYT0M3UW1xV3ZiZVF3c3NTSitoNzVxWUdENFc4SEZx?=
 =?gb2312?B?bldIQUNTMklYYWRjWmdzUzYzbGZVa0ZwYzV0bWhDTzl5OU1wamFqUU90TnJw?=
 =?gb2312?B?YnJCT3I3RGIveUlSSnorSll3eVdtUHRTOFBWbVJWNzVKVklrQldSN0FmUUtQ?=
 =?gb2312?B?MS9USlM4WDFTb0RURTVqZ09xYkdmaUNHTGxoZG9NRy9UdmFzSDJFZExhYjdR?=
 =?gb2312?B?eU5QbDR6bFUrWFNIbWI3ZHZNMm1EK295SzZOUFRyVm0vcEJ5Zm51VXFBaFJh?=
 =?gb2312?B?UXR0YkNsVUtBdkxwRlJmOXlqWUowa2dJaHpRTi9oQTNJaW1ZZDhGUFNDMUxQ?=
 =?gb2312?B?OElQOGR2eGxJV2l3Um1pWGZiZmZ4dWgvUElUVWowNW1aU2IwSzhOTXdaa3Yy?=
 =?gb2312?B?OGo0ZDlIRk5FRnkxOXZLVzdNTW5TSVZScy8xMlYzMUprWFdMeEN3b2ZxSlda?=
 =?gb2312?B?c28rSVlieFd4V2xTc0NXS2lheldweDI3Wlg0Uk9GYmZkNXJhQTJWRVQycDYz?=
 =?gb2312?B?ZWpscVE2ZmZveEVQRDZzcWdsSVQxZS9RTEhlMDJ2QmVIdXh0WlpRVjFlTjh4?=
 =?gb2312?B?MnhiSGsvL3Rod1RrU0w5QUl4NFYvanNMdEhzcnZkYUdYL2Z4SGUySXByeXhz?=
 =?gb2312?B?UUNYd0pxZjlaTlFGTXR1djYvUHJSMmhCZk1NeGxrbTlhUWRHS3FDZzJKaXZq?=
 =?gb2312?B?N2xPcHlSVUY5bmpUZjJIWUFuc05kQk5jYmJJS3FQUUhiVDdwNlBoWjZ2MXI2?=
 =?gb2312?B?aHd2QS9ueUFjMmZ3cHA4MW1yMW45N043Um4xYk9RUlVjeEVmcVRQOVhuaFBh?=
 =?gb2312?B?OTBkajVHRkt4R3g0c1NhV2NCU0F4OWR6dy9ZWXFyYzRsTHVlYjRHTGlnMnVE?=
 =?gb2312?B?YXJxV3pETW53Y2JuNk1id3pCU1VHT3EwOVZtYWxIQ1FJc25MWHl6ZlQ2Y1RO?=
 =?gb2312?B?V2syTjRaa3BFZUpnckZVUHUvRm5JdllJRE5KY1N0U0k1RW1YUmV6dXZtdDBW?=
 =?gb2312?B?cUFRZnpnZmFDZUswb2V0aE1MdUszZHl1a3k0R2pOY3dPeEFXMGVpTmxucGhE?=
 =?gb2312?B?SUgzU0VMZWduT1VpNzQyd2NHMUJLWURQcnBVUjNtM01qTkxBQUV5K3U1S3U0?=
 =?gb2312?B?WmRqUmlucVVXdHJIejBQdnVOVnhRTWU0S0hDaDRod2ZoZzdpVXB1ZjlSNEdQ?=
 =?gb2312?B?WDBkbFRzUDE4SU02em55V0cvdjdYQlBVYUpnVDZXWXE2ZnZGU1J0K1VnYTYv?=
 =?gb2312?B?a1hNRlp5OE15ZWpsT2lTNW45V0k5YVlqL2pYL3VraDhPVTlrL29GMHMrSVZX?=
 =?gb2312?B?dXFwY29pZWh0T2t1VVRKUUgzMmQ5T3QwV25MK3RqNWZPdndma09CdE1PVHBt?=
 =?gb2312?B?dWdHR2ZMWmZLU29DbWZXWDZNZFpqWXBoK29CZ0xlcnl1dG1jeW91c0FCTUJl?=
 =?gb2312?B?ZGlPUThTZXJGeDVNK3hQenI5OFEreUQzZU5SUkQxNGVPRE1aWVlUdVNNb0sx?=
 =?gb2312?B?NHA5aGhxdERXbFpQU0JGOGJRWEtoYUJBUVBFKzdhTkxPcGY4bE5RNmZkc1o2?=
 =?gb2312?B?Y2FEV21lWnQ3dmVhUlpqSFVraXVwN3FZRWpERVdUclUwT1YzVjZMbUNKVnhF?=
 =?gb2312?B?d1ZxQ0ZJazFJL2oxVDJPakJzVy9JeXlDS2VjM0djSHl3S25pT2RtcXJOYXpK?=
 =?gb2312?B?bnFqbGhwM0xyQldQUVBLWDQvcWxsUXFNeUV2US9BaUZNYjRacTNPRWcyN2ht?=
 =?gb2312?Q?VfxQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97b7e09-1ed3-4cd3-f22e-08dcfca3b697
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 07:38:45.2774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3BEVurlSO1kWxhC50rBD4t28/FO873FXckN//NIMjcF8Q88LkaLSjSgnBAiuQkgJQRKRjosJAlEV5y7Ie2KiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7566

DQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IFNoYXduIEd1byA8c2hhd25ndW8yQHll
YWgubmV0Pg0KPiC3osvNyrG85DogMjAyNMTqMTHUwjTI1SAxNToyNw0KPiDK1bz+yMs6IEFsaWNl
IEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiCzrcvNOiBhbGV4YW5kZXIuc3Rl
aW5AZXcudHEtZ3JvdXAuY29tOyB3YWhyZW5zdEBnbXgubmV0Ow0KPiBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZl
c3RldmFtQGdtYWlsLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBbGlj
ZSBHdW8NCj4gPGFsaWNlLmd1b0BueHAuY29tPg0KPiDW98ziOiBbRVhUXSBSZTogW1BBVENIIHY0
XSBzb2M6IGlteDogQWRkIFNvQyBkZXZpY2UgcmVnaXN0ZXIgZm9yIGkuTVg5DQo+IA0KPiBDYXV0
aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xp
Y2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVw
b3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0IHRoaXMNCj4gZW1haWwnIGJ1dHRvbg0K
PiANCj4gDQo+IE9uIFRodSwgT2N0IDMxLCAyMDI0IGF0IDAyOjU0OjM4UE0gKzA4MDAsIGFsaWNl
Lmd1b0Bvc3MubnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiAiYWxpY2UuZ3VvIiA8YWxpY2UuZ3Vv
QG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOSBTb0NzIGhhdmUgU29DIElELCBTb0MgcmV2aXNpb24g
bnVtYmVyIGFuZCBjaGlwIHVuaXF1ZSBpZGVudGlmaWVyDQo+ID4gd2hpY2ggYXJlIHByb3ZpZGVk
IGJ5IHRoZSBjb3JyZXNwb25kaW5nIEFSTSB0cnVzdGVkIGZpcm13YXJlIEFQSS4gVGhpcw0KPiA+
IHBhdGNoIGludGVuZHMgdG8gdXNlIFNNQyBjYWxsIHRvIG9idGFpbiB0aGVzZSBpbmZvcm1hdGlv
biBhbmQgdGhlbg0KPiA+IHJlZ2lzdGVyIGkuTVg5IFNvQyBhcyBhIGRldmljZS4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IGFsaWNlLmd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+IA0KPiBBIHNp
ZGUgbm90ZTogY291bGQgeW91IGdpdCBjb25maWd1cmUgeW91ciB1c2VyLm5hbWUgcHJvcGVybHkg
dG8gbWFrZSB0aGUNCj4gYXV0aG9yL1NvQiBhcHBlYXIgbGlrZToNCj4gDQo+ICAgQWxpY2UgR3Vv
IDxhbGljZS5ndW9AbnhwLmNvbT4NCg0KTWF5IEkgYXNrIGlmIEkgbmVlZCB0byBzZW5kIHY1IHRv
IHVwZGF0ZSBteSBTaWduZWQtb2ZmLWJ5Pw0KDQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBHdW8NCg0K
PiBUaGFua3MsDQo+IFNoYXduDQoNCg==

