Return-Path: <linux-kernel+bounces-270311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D7943E52
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2A52816C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8D14A4EB;
	Thu,  1 Aug 2024 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PWAuZbXV"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C014A0A8;
	Thu,  1 Aug 2024 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472388; cv=fail; b=lqqEO2ZUJoHmhVNMTGH7+saZQ95x8fJC5HcW266TJFZUXS8LdP2cBVkCLIl+pPYcRkXSavYmlxeVa3wOcBS4Es4rtpTYAdwxtkUdwii+z0ktro8reRsHW+cSmIUoCurFcMRopXPp6wnbxayZ7kau17ZRrk9ZQHgqIYCC6eHwmig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472388; c=relaxed/simple;
	bh=jYD/h6aLWBMp7mNKsk+luD/bkUTds3OEcufKkCLG/6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l8bCeY9Nuqb/ko/wQiW6U4wHGW2zE4vSEz2+8X+/UhZxXVPbxq/OfeEfUd7sIPMinbJ31ONb9gxW0pf8EzXzEsOqDncYXYq87kjG3ju1o7yVPoDHHaHf/UVOxG59pUaatKgCzicCVeOpc3MW1EsZEG7gt52GTEQdIHRxShZ/ZMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PWAuZbXV; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpMGtSKRtsI4EWPHGLNPmu2EDqxVGFqs3kRxN4ZLY4RMwapNFfoUAwmMWKjLsIgM1SE+8UeHGLPMuuLWiZAzaj2mZB9RVFMOF750VRL6Kg12o+pNy1RnxgyRfaaj7NX0F1S1ApuZqjVrY5JPXwjXFx4qDDHwtcg8RrV8hYId3YH6gag/atqVsag0QN1UMRGAuufZMj5UqEvMMzJKIVriaqzJlc9A4u8tZCPa40DnGHjENDQ+39XMf9AvV/MyuJUrhg7ojrS+x/eXaYm23kl7+5u+hcLPoYTBdwACrj1ykOf3OZOziOYdPWDGciA7LApd7kiylF0u/7OW84u3ctqc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYD/h6aLWBMp7mNKsk+luD/bkUTds3OEcufKkCLG/6o=;
 b=CfDTgsqWHiNIXkPRpTakkfHx2DuL3sCh7aNVJYPk3vrAQ7NbB0JYw0OYBcMY6X5ZAMkxfE4TazmuyggaONJqHT1MgBvmYBjltK7mBuM1JEjdew6dQy6ry1rccE2sZLn2DHxjr7UWYxuoVNXwSb/3lMhY3IoYHczcJBtxvjmU7hseuPSNibZnCVFp+nuIVhnllfs3r4wXoHzJeIiwaIYHaq5ObpJsk9VbAd0h3kkg9LYn24p0Dw4BwO5WdhqAN4XXjVUOOUERNyELGMsIGoF+Oke32uR+X9zBzNS+aNUN5zIJU/Xe1wUieUp8eQhZAb2Cn2Y93mQdLLgUzxURqDwulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYD/h6aLWBMp7mNKsk+luD/bkUTds3OEcufKkCLG/6o=;
 b=PWAuZbXVyOCZzIWk5+bY/dyBWDeUAPoLNEuMxgJTXX6n0FQ84/90GxQISd6ZtRzTdPOeb/qW4xcdSs4EZdkLrW0lh7h8VxBz+NAjupJCMiYDbeNCgaNEjS1y14f29vgcUpn5X8n45l0kNPZbDUd8YuftmbXRelFhI5Hhd6nVLUv/fsHDdq09O9/LUQrWAtK4vL/Ytw6P9W7vtpeb5FZjLX8TM9scQqCzvl5eS4O3+2mO2bjTKfCcIE1gl28BJKWn+SvtrGk96xYT6CIOpxum3V2taMU13vEoc/3Uxxus+U0VFUfRhmjitKTL0LcvJ6u6Nu8I1Ar1wSUvFSuJzUuvJQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9565.eurprd04.prod.outlook.com (2603:10a6:102:26b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 00:33:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 00:33:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli
	<luca.ceresoli@bootlin.com>, Michael Turquette <mturquette@baylibre.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] clk: clk-conf: support assigned-clock-rates-u64
Thread-Topic: [PATCH v3 2/2] clk: clk-conf: support assigned-clock-rates-u64
Thread-Index: AQHa4l1Yljy663ip9kiNHIBBK5YVuLIRa/CAgAAjoRA=
Date: Thu, 1 Aug 2024 00:33:02 +0000
Message-ID:
 <PAXPR04MB84593920DE71BB042664BF9388B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240730-clk-u64-v3-0-4d2b19edaa6e@nxp.com>
 <20240730-clk-u64-v3-2-4d2b19edaa6e@nxp.com>
 <08ed1ae35b69e11e69ce178af41c77b0.sboyd@kernel.org>
In-Reply-To: <08ed1ae35b69e11e69ce178af41c77b0.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB9565:EE_
x-ms-office365-filtering-correlation-id: 5de724e5-b11e-41ee-21ef-08dcb1c180e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnF6a01tMWVuN3RJaVFwaGRoOFlFMUl2S2hBV21MTkNSbFI1MGlSUHJWWmg2?=
 =?utf-8?B?c2pJZldFOTMybHhRYWptNVpJbVZTY052TFhiVFkyUEkvaU1NZ3U2d1VMenND?=
 =?utf-8?B?QmdOUDc3RlNEeXQ2b1o1bmJWaGF2Mnd1Z1NKeFBjUU9zMFpLZnNBUVdkalhn?=
 =?utf-8?B?SXo4M010OE5yZ3Jub0hXMmVJeEsrQko2L1VSMUFwZEZpWThLYi9jajNQVSta?=
 =?utf-8?B?blh4dFMvUVBsd2h4S1o2NGlSdVZBQW5KSUlTais4YWxwaldLZFNqQUFLeEk5?=
 =?utf-8?B?a1YxTThpMTNwME0zNkhtUFM3alJ0RzFlYWRtNTV1QldRRHZXdFVoazZ2RDBs?=
 =?utf-8?B?ZHNTQXVlZFZXU3RJRmdRNTByR3RHZmpxdVJ4L29QUjNxOGRzUEQwOFlwKzFH?=
 =?utf-8?B?bWkvcnMwdFdLMm1ON1oxZFBTMkRGZDhhOHBoZUV0TXNXL1Z3ZTlySnVSTGlJ?=
 =?utf-8?B?d3NPTEJkd2hlZGZXUHZ0NDNXclMxVGFaWHhmLzBUaVdodHFzdUpDQVVxMVFF?=
 =?utf-8?B?aFloOXViNlVvaWRHSTlaSTk0czRYaGtXRWJneGVRSmc4U0t5M0VmSUpJMnFh?=
 =?utf-8?B?YU95ZVlZUTdrNVU0bnBLSytjS2NSaHpHZmN1Q29HNnRPa1NGeXlHdTh5bTBC?=
 =?utf-8?B?UHNrVk43TlliMHQ2c25ONWN0cUdVTGlERGFmSkFlMzRkZ05QcVF0a0dnUzFy?=
 =?utf-8?B?V2F1ZVY0QmdYanRtVDlhTHl4Ui9YVklmYTZjbk9ETzBtUkNBbmM1aTlmcm9u?=
 =?utf-8?B?S2FwT1JiWHF0bllYaGgyMm1QbHd6dzhRKzhnakdFQVVxM2N3RHdnOWpRck9O?=
 =?utf-8?B?aWUwdVMwKzdjellncXllREdobi9mWE5TbjdEUGNpMVJPcTBvN3JTcmJ1SkVV?=
 =?utf-8?B?UTU1UTU3R3R3OVNRenZrU1lEM1hxZEo3MGJ5ZHR2UnVXQlJpV0hxVFlWNE5j?=
 =?utf-8?B?SFQ3M1hOSld5U3NhNjJqZWcwd0dpQlBRWGxJcnRTbFlhalVaVUR5MUdTRkIv?=
 =?utf-8?B?QzlFWndqdzdHanFQODZ4Rk5ia3p3ejN6UnNPd0Vkd08xcGlnYkRHVlhpZHV4?=
 =?utf-8?B?K0svKzVFa1R2SnUxY3dKQVdBUlFzL1hBU3E0aXUyREhrQ1RBS0xla3dKUExs?=
 =?utf-8?B?Ky9razJJUGp2VDVlU05IcGFMVGMvam9tdTNIOWpTSmFiQ1o0aGhxV2xjSUtk?=
 =?utf-8?B?TUxXY0RZOFlNM3RlUlU0VE5iTmp0RVpWUHNJRzJuekM2ZkJVMytzcnk1a2Rm?=
 =?utf-8?B?OGhUWHM4aGFMMkNpZDVRMjdBZ1p5RlhWaWI1VDFiNWs3K3hzczVldlpkOTVv?=
 =?utf-8?B?cXg1dURoL09iREdIWjNpY0dMTFhMV2VoK0g4OXhHamZ1WkxrMkYyQlFmT1JB?=
 =?utf-8?B?WUZnOUlSMGNpKzEwSVRnY2thMmZsY3luUk1GS0lab0NFbXJtV3h5aDlRYm5V?=
 =?utf-8?B?T0Jpbkg2Y3FpcEF5dlZkMWtkckxYSEtJUFl0RU9IWkttZ0p0WWNXQjZad3M3?=
 =?utf-8?B?UmFURDBQNFQ4MHFHaUg5Mkp5R0t2R3Y1dVovdjZSWEorR2dhNlNqRTRqMWp1?=
 =?utf-8?B?TlkxTXVPbyt2RmNFVTBnUnQxQWhzeHdhN3NvOUhqanNTYXB2Y29BK0FlODJC?=
 =?utf-8?B?SUtNSFlRaUNKV0ZUa2hEWVdNMExJTUljZTc4OFpKNEVQazRTVmlQdkorNnYx?=
 =?utf-8?B?cmZPZUh1WFNvV1Bhcm14bzRsZnQ1MmJqVFFJb3phZVFFSTBPRDRjSFM3amd2?=
 =?utf-8?B?OW52WmM3ZFk0azVvdDNNcmN4dmhKODYxMVVwVHA4anYrQ1ZnR21wSFlucVI1?=
 =?utf-8?B?UUhXbjZQMkw2VFJCSi80S0IyS0VPZHVoTXZlR3hlK0ZLaG1IdGY5Q2NNY0t4?=
 =?utf-8?B?UjhUM3pNM1VPcVE1bUVBanEvS0h2a2NxRW13czVsdGhQL1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3pya3V4b1JkRVAxQUZWbi96QnNwRjZSeXZ5VkxTZlNtWXQ4ZXhiL3V1bGRO?=
 =?utf-8?B?Tk9VUEQ2dW1DTWJWYjZBaXR1RXRxZUUxYTRxdlpmb0pBNXE1TkdabUtTSnI2?=
 =?utf-8?B?b1NsTUFDbjl6M3I3bFVmSXlIL3NZQ0JpTVo0dldQNHd2UVB4a2lRWTF4U0Q2?=
 =?utf-8?B?SWkybFF5Mkd2azZHcDF1WnJ0RmJReElSa2RtREdzWm9uaXdabW1BWU9Oc1RR?=
 =?utf-8?B?OG1CREM5R0dlOFZmWEhkMW9qZ29ETWtoT25xSXFvb1FEWHZxOUpja0YyTng0?=
 =?utf-8?B?UnRRcXRaV2hhUGR6NldoVDl3bVZ1bFdtdnBZcTNBVGkxcW52alhqUW1FSi8z?=
 =?utf-8?B?Z2lJUThNSm9Qcm5sY096Rm15c2R0R3pZZjQzbTN6bGRzNzN6UXpwMmZCRkwv?=
 =?utf-8?B?WStPSmc5Zm9neTdlOXZhNllycVB0SkVSMUEwaWhZVTJlYkFodTIycXErbDMy?=
 =?utf-8?B?SzA2ZzhRbTAvU3ZRVTVlakthaDcrbzI1dlZvb3BCOVNRK3N0REx3NTlxYldw?=
 =?utf-8?B?TmFZUzVUZnVTL0ZMRTFJOXlBYWw2OVJmbmIyRFh5TTRiSVNqK0JVelJTczRW?=
 =?utf-8?B?ZGFIZ2ttZWt5VWVURGNwa3RUMEwrODRRMlI1QzVRYzJMeXNtdllxQmNyc3hK?=
 =?utf-8?B?M1gvS2ltNDVReWtsOFBmdWVhOXV2SHNtY0c4NXJPampJQW1pUWF1ZGNNejdE?=
 =?utf-8?B?aFMvWEhXQ0N4ZEtXZ3gwMWlybmJzSE4wRWo3dHJkNElxNlJET3B0MnlrdHFk?=
 =?utf-8?B?R0E3cG8xY01LNE1GdENJU1FuNnVsQUJPU3JJd0RNcm4rcE1JNDlpZ215SDFX?=
 =?utf-8?B?bmg1SU84YnF5TWhLY0UzNXE0cGtRMUFvcE80eng2bUJZcVZSaTJVTEpEUFpr?=
 =?utf-8?B?TklGaStZRTlxb21LS1FpYUFMRWpQSkRmSkRSRm4yNGltRFZFclFjcmIzOFdO?=
 =?utf-8?B?QTh6d2xVRjYra3luZ1hxcXpaZlZNQkhFdFFzNGZYNVV2NkNEQUxrbmZ6LzFp?=
 =?utf-8?B?RDhQZDd5QkxwUXFzWFljRmcvQ0pxMXB1YVlwaHdGSXZJOStFN1pNb3RVbk9W?=
 =?utf-8?B?NFRuRTd3Yjh3a0RKNUp3ajFtYTdKZlJyYkFUUy9ucDdVa0JCNlNsRDBqc3dY?=
 =?utf-8?B?OW5pd3Z6ai9QWWdYeUdwQzRkZ2Q2SDEwOEMwbnp1T2h2TXVkeG0zbGc4MWpx?=
 =?utf-8?B?OUhDWjJkRWdSUEg4bjB1TEJONTIveEVRNSs3RGFoMUlDWUgxU09QbTVtOUd2?=
 =?utf-8?B?UU82V2VJWkdHSnc0RnRtYzBxemxBVHg1djFmejBwOFk3bTlLRmJBNzNHdnNO?=
 =?utf-8?B?OUMraC9UcUFIWXp5aE9uRHEwZlk1VUdDaUJMYTNWczZ1TUxPMGttK1BmYWpZ?=
 =?utf-8?B?dTRvZmQ2YkN2Y2syUGpwb2g0VVplUzJQN0VRaFNQTHlmSWs3VW1tZW5LSUJ4?=
 =?utf-8?B?bklreTNXRGtmT3dlNEJnVzhuUFFQcXZVM1QvME9DMVR2bEc1WG9aamQrSGp6?=
 =?utf-8?B?a2dwWnZ2dVhTSkFyWWM1NDlQck4xdzQ0Smtxa2hGQXBnaGRmaFlwclRCL015?=
 =?utf-8?B?eDlOcFFha3VLbEhnVm1nbHE1dEtSTnluekttcDVjMzF6RnZxc0hYemo5VzB3?=
 =?utf-8?B?NzVPL0l2dlo0VzNGUFluZFNQUUtZS0FVRFZjcXJkS2l3bUlKYW95eHRHdTJZ?=
 =?utf-8?B?VHZLekh0VUZjN3hLQitVSHMvRlE4QXJSU09ySy9kc1F5L0Yxd1JEYUJSMldK?=
 =?utf-8?B?eW00RS9MNnNUUkZLWjdOYXcrNU0wajNSaEpjQWF2WjVkaTE3ekYvSHdJams3?=
 =?utf-8?B?eE9Ub2NIZDgwVUhCK3NiUlNRQ0N6MU1TN256SEtaL2s5cXFickVoVE1QeGZk?=
 =?utf-8?B?eG1pUFVEaU1ZQlZycFpVL3NmNzF5MXFLeDBQd2NnQkdsbDdiTDdMbHFxditz?=
 =?utf-8?B?NGZvbnZJeUFJUVdRbDdLZVIreldoQnlpVE1FZXo5NGVPWmdNbjdFQkZmVkhs?=
 =?utf-8?B?UjV1V2l1cVhVT284ZHBmbXFnNnNzdStHMXE3TDZEODFtZ25IY1M3SkRhQWNC?=
 =?utf-8?B?WnBKK0sreHg4ai9kMjFkR054Z0N5dS8xN2NTK3FjY05ZcUlyelVXeG1tc005?=
 =?utf-8?Q?368Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de724e5-b11e-41ee-21ef-08dcb1c180e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 00:33:02.8934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lV5pWBmVjLVXxwtniatG9Loh+bgVlPjW+2AngoUJSt0r+T51VH/UXJ7r+Xv3cI5yHwdv85q8siwSZadJXT3Sig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9565

SGkgU3RlcGhlbiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvMl0gY2xrOiBjbGstY29u
Zjogc3VwcG9ydCBhc3NpZ25lZC1jbG9jay1yYXRlcy0NCj4gdTY0DQo+IA0KPiBRdW90aW5nIFBl
bmcgRmFuIChPU1MpICgyMDI0LTA3LTMwIDAxOjU3OjU1KQ0KPiA+IEZyb206IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gaS5NWDk1IFN5c3RlbSBNYW5hZ2VtZW50IENvbnRy
b2wgRmlybXdhcmUoU0NNSSkgbWFuYWdlcyB0aGUNCj4gY2xvY2sNCj4gPiBmdW5jdGlvbiwgaXQg
ZXhwb3NlcyBQTEwgVkNPIHdoaWNoIGNvdWxkIHN1cHBvcnQgdXAgdG8gNUdIeiByYXRlDQo+IHRo
YXQNCj4gPiBleGNlZWRzIFVJTlQzMl9NQVguIFNvIGFkZCBhc3NpZ25lZC1jbG9jay1yYXRlcy11
NjQgc3VwcG9ydCB0bw0KPiBzZXQNCj4gPiByYXRlIHRoYXQgZXhjZWVkcyBVSU5UMzJfTUFYLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvY2xrL2Nsay1jb25mLmMgfCA0Mg0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzcgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9jbGstY29uZi5jIGIvZHJpdmVycy9jbGsvY2xrLWNvbmYuYyBpbmRleA0KPiA+IDA1ODQy
MDU2MjAyMC4uNjg0ZTBjMDczOGIzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1j
b25mLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGstY29uZi5jDQo+ID4gQEAgLTgxLDExICs4
MSw0NCBAQCBzdGF0aWMgaW50IF9fc2V0X2Nsa19wYXJlbnRzKHN0cnVjdA0KPiBkZXZpY2Vfbm9k
ZQ0KPiA+ICpub2RlLCBib29sIGNsa19zdXBwbGllcikgIHN0YXRpYyBpbnQgX19zZXRfY2xrX3Jh
dGVzKHN0cnVjdA0KPiA+IGRldmljZV9ub2RlICpub2RlLCBib29sIGNsa19zdXBwbGllcikgIHsN
Cj4gPiAgICAgICAgIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgY2xrc3BlYzsNCj4gPiAtICAgICAg
IGludCByYywgaW5kZXggPSAwOw0KPiA+ICsgICAgICAgaW50IHJjLCBjb3VudCwgaW5kZXg7DQo+
ID4gICAgICAgICBzdHJ1Y3QgY2xrICpjbGs7DQo+ID4gLSAgICAgICB1MzIgcmF0ZTsNCj4gPiAr
ICAgICAgIHUzMiAqcmF0ZXMgX19mcmVlKGtmcmVlKTsNCj4gPiArICAgICAgIGJvb2wgcmF0ZV82
NCA9IGZhbHNlOw0KPiA+ICsNCj4gPiArICAgICAgIGNvdW50ID0gb2ZfcHJvcGVydHlfY291bnRf
dTY0X2VsZW1zKG5vZGUsICJhc3NpZ25lZC1jbG9jay0NCj4gcmF0ZXMtdTY0Iik7DQo+ID4gKyAg
ICAgICBpZiAoY291bnQgPD0gMCkgew0KPiA+ICsgICAgICAgICAgICAgICBjb3VudCA9IG9mX3By
b3BlcnR5X2NvdW50X3UzMl9lbGVtcyhub2RlLCAiYXNzaWduZWQtDQo+IGNsb2NrLXJhdGVzIik7
DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChjb3VudCA8PSAwKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgcmF0ZXMgPSBr
Y2FsbG9jKGNvdW50LCBzaXplb2YodTMyKSwgR0ZQX0tFUk5FTCk7DQo+ID4gKyAgICAgICAgICAg
ICAgIGlmICghcmF0ZXMpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9N
RU07DQo+ID4gKyAgICAgICAgICAgICAgIHJjID0gb2ZfcHJvcGVydHlfcmVhZF92YXJpYWJsZV91
MzJfYXJyYXkobm9kZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiYXNzaWduZWQtY2xvY2stcmF0ZXMiLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJhdGVzLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDEsIGNvdW50KTsNCj4gPiArICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAg
IHJhdGVzID0ga2NhbGxvYyhjb3VudCwgc2l6ZW9mKHU2NCksIEdGUF9LRVJORUwpOw0KPiA+ICsg
ICAgICAgICAgICAgICBpZiAoIXJhdGVzKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PTUVNOw0KPiA+ICsgICAgICAgICAgICAgICByYyA9IG9mX3Byb3BlcnR5X3JlYWRf
dmFyaWFibGVfdTY0X2FycmF5KG5vZGUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImFzc2lnbmVkLWNsb2NrLXJhdGVzLXU2NCIs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKHU2NCAqKXJhdGVzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDEsIGNvdW50KTsNCj4gPiArICAgICAgICAgICAgICAg
cmF0ZV82NCA9IHRydWU7DQo+ID4gKyAgICAgICB9DQo+IA0KPiBDYW4gdGhpcyBiZSBsZXNzIGlu
ZGVudGVkIHNvbWVob3c/DQo+IA0KPiAJdTY0ICpyYXRlc182NCBfX2ZyZWUoa2ZyZWUpID0gTlVM
TDsNCj4gCXUzMiAqcmF0ZXMgX19mcmVlKGtmcmVlKSA9IE5VTEw7DQo+IAlpbnQgY291bnRfNjQs
IGNvdW50Ow0KPiANCj4gCWNvdW50ID0gb2ZfcHJvcGVydHlfY291bnRfdTMyX2VsZW1zKG5vZGUs
ICJhc3NpZ25lZC1jbG9jay0NCj4gcmF0ZXMiKTsNCj4gCWNvdW50XzY0ID0gb2ZfcHJvcGVydHlf
Y291bnRfdTY0X2VsZW1zKG5vZGUsICJhc3NpZ25lZC0NCj4gY2xvY2stcmF0ZXMtdTY0Iik7DQo+
IAlpZiAoY291bnRfNjQgPiAwKSB7DQo+IAkJY291bnQgPSBjb3VudF82NDsNCj4gCQlyYXRlc182
NCA9IGtjYWxsb2MoY291bnQsIHNpemVvZigqcmF0ZXNfNjQpLA0KPiBHRlBfS0VSTkVMKTsNCj4g
CQlpZiAoIXJhdGVzXzY0KQ0KPiAJCQlyZXR1cm4gLUVOT01FTTsNCj4gDQo+IAkJcmMgPSBvZl9w
cm9wZXJ0eV9yZWFkX3U2NF9hcnJheShub2RlLA0KPiAJCQkJCQkiYXNzaWduZWQtY2xvY2stDQo+
IHJhdGVzLXU2NCIsDQo+IAkJCQkJCXJhdGVzXzY0LCBjb3VudCk7DQo+IAl9IGVsc2UgaWYgKGNv
dW50ID4gMCkgew0KPiAJCXJhdGVzID0ga2NhbGxvYyhjb3VudCwgc2l6ZW9mKCpyYXRlcyksIEdG
UF9LRVJORUwpKTsNCj4gCQlpZiAoIXJhdGVzKQ0KPiAJCQlyZXR1cm4gLUVOT01FTTsNCj4gDQo+
IAkJcmMgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMl9hcnJheShub2RlLCAiYXNzaWduZWQtDQo+IGNs
b2NrLXJhdGVzIiwNCj4gCQkJCQkJcmF0ZXMsIGNvdW50KTsNCj4gCX0gZWxzZSB7DQo+IAkJcmV0
dXJuIDA7DQo+IAl9DQo+IA0KPiAJaWYgKHJjKQ0KPiAJCXJldHVybiByYzsNCj4gDQo+IAlmb3Ig
KGluZGV4ID0gMDsgaW5kZXggPCBjb3VudDsgaW5kZXgrKykgew0KPiAJCXVuc2lnbmVkIGxvbmcg
cmF0ZTsNCj4gDQo+IAkJaWYgKHJhdGVzXzY0KQ0KPiAJCQlyYXRlID0gcmF0ZXNfNjRbaW5kZXhd
Ow0KPiAJCWVsc2UNCj4gCQkJcmF0ZSA9IHJhdGVzW2luZGV4XTsNCj4gDQoNClRoYW5rcyBmb3Ig
d3JpdGluZyBkb3duIHRoZSBjb2RlIHBpZWNlLCBsb29rcyBnb29kLg0KDQo+ID4gKw0KPiA+ICsN
Cj4gPiArICAgICAgIGZvciAoaW5kZXggPSAwOyBpbmRleCA8IGNvdW50OyBpbmRleCsrKSB7DQo+
ID4gKyAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgcmF0ZTsNCj4gPiArDQo+ID4gKyAgICAg
ICAgICAgICAgIGlmIChyYXRlXzY0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJhdGUg
PSAoKHU2NCAqKXJhdGVzKVtpbmRleF07DQo+IA0KPiBQbGVhc2Ugbm8gY2FzdHMuDQoNCnN1cmUu
DQoNClRoYW5rcywNClBlbmcuDQo+IA0KPiA+ICsgICAgICAgICAgICAgICBlbHNlDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmF0ZSA9IHJhdGVzW2luZGV4XTsNCj4gPg0K

