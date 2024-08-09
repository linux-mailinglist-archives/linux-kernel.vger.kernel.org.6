Return-Path: <linux-kernel+bounces-280329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D794C8D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A139E1F21D25
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962FF18638;
	Fri,  9 Aug 2024 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kZwhbg4X"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8180E28E7;
	Fri,  9 Aug 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173635; cv=fail; b=ZkPdvAzVQdHCyptzTCmvbRs7gEJMvtSV3/ad/jjguht/sFDnyl11aZLwlakm9L6whxuxeENTpZEKXTCV05MXhXeAbPzdEI3WxJFR7Dd3+NDpppNav4wAS8wWUnypBMqtRw7Nx+kpFtfbwGw81AI24RrPDLh8xar8iEdxTXA31LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173635; c=relaxed/simple;
	bh=lGHaED3yLDSzrp/L8G7H5MX3ioUAZrfDOEjVX6Pi5/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RtBljx5ON5ZGdtbg6cVj2obCAvmvfb7xzXhUdoc8hsdvx5tNBVZjjHBPeUlhsKDtYsPls8QSqEZgc3QP4Y3PY6m08EcmoNOXrzR3BcKqJpbchXShtTr+qZRwkqEYCsLIVgFA1iImL9K/h998GTf7KxWSLAufw5fp82f2cRxPnXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kZwhbg4X; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgxG4OPWpdaIVGbiwJYBd3IE7LJCGOXPqOoVPZyOFIWluDLqOkDRFywaumYhemrmWbvVCGSpG6/q++g1F2Ebd00GHEB2MkSG49fhlifg+uG6mrVoNtF9o/gba7bcsu1D1S2XJSdVUMY8duxrYGC4zgZaK5nRr+fDYwgz7QLV01tg8SEVHfyK1Cha6eDUjBPEtOltVIUz52ZkGYu550VNi/CE+NBlr9KHTQjsTQ/2jU9flSttNAwUf8QWOwaC3Mco8hf3FUBIdk/nY1Pkp6jc5ksO4nru8ApBQ6zUmIvmQgrEPpsnXTg5O7KnikejMdZITVlAD6Jhr2o2HA8XgFNXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGHaED3yLDSzrp/L8G7H5MX3ioUAZrfDOEjVX6Pi5/Q=;
 b=JLoVGphndt1czVJoiQybYE05aDDVhna5jfU2QYGsRD5kSMhXrkHRbBxdjhrNcmmBlJbDOfVVBEUGdh5zBDCid8soNkUw5oLpVDNpiNW29pPvfsk4av0qo4YqG35XA0KpmB/U8qw8n9KFe8Z1b/cdRIPj5rwiO32i3lMNmF6Ow1Ss4Tu4okfWqCBicktW9eWX/bAjJvWLlSQZ9BrK0wItGqKfTjK1y4DAheFDR22Xq+Y8Xt9mme7I5LNFrThIJSXeEcoykBWuRaZLBQ45m6ibPvtBmG5s7mGD9xBExpS1nWGKYPTpXSloNrq+9PuYyos638+LKoXRdxA1DoNYdZ0gwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGHaED3yLDSzrp/L8G7H5MX3ioUAZrfDOEjVX6Pi5/Q=;
 b=kZwhbg4XO1Uolj2H6zCyDrBmxcz8mP54rUL+c7uozia+4ifZNNmWWNMBD9wPwLL59Wt9EU/zYj2QZYhc18SYxdsqNUgFSKApLSM0ukJEQWOcExlSGZvdsqoff7Lop5aZ7Y1eTbfulgf3LGoEdfvliYEpvdjFsQX3pl6FEw2Y/gx8kNpgr4egzv0u2u6mKbv6AIyzJvRyb1KACjNVVas/CAH6hmPcLuWRgAx8WQ1dvic0aabqJt41rIj3Q6iOV3PvAbseyuLaQMl0LhCTxvNS/Mh3u7hNutLKSvKtBzpCnZUmml/X6Y6PU6ygGK4ypiyR0MO4CSq9/WIHZxjUlxHIMw==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU4PR04MB10719.eurprd04.prod.outlook.com (2603:10a6:10:580::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 03:19:51 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 03:19:51 +0000
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
Thread-Index: AQHa5mkyoyhloa/0yEC8gnGLDGMVHLIdylsAgAB9KyA=
Date: Fri, 9 Aug 2024 03:19:51 +0000
Message-ID:
 <DB9PR04MB84614604CD9292D2626FDA6888BA2@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240804-clk-u64-v4-0-8e55569f39a4@nxp.com>
 <20240804-clk-u64-v4-2-8e55569f39a4@nxp.com>
 <6bc191590c1a5b7fa3ef991d6b7e327b.sboyd@kernel.org>
In-Reply-To: <6bc191590c1a5b7fa3ef991d6b7e327b.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|DU4PR04MB10719:EE_
x-ms-office365-filtering-correlation-id: 9bd669ad-fe21-464d-e02e-08dcb82221a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFQ3b2p0NGJtVjR0aG5FU2ZvZXRyZXFXcXNlMDN3NlgxcnVvdFZEMTM2K2RP?=
 =?utf-8?B?c080NkxIS2lWNk9vWjdkV2tFcDlrTy9WbndpQjN4ZW81aWYwNGViTC9EV1Ns?=
 =?utf-8?B?TlFzRWpwVGJPa0taUGNmbng1a0E1cHpDNmM0T1R3MEdpeFJnMnNRMTlFT1pN?=
 =?utf-8?B?UEVJRnkxRFYrSzRNQTdKTVdNTDNIdFZWVkF4dDFJY29uYi9WR3k4c1dGbXhV?=
 =?utf-8?B?djJQTk8zWi9SaXc1M3FMTUdnUTY0cnN4blF6R09jTEk3NEdCSCtZRTdoc1RE?=
 =?utf-8?B?Z2ZaT1VMdVQwc0ppOVZETzcrSEhhaEtYRUQwUHA3S3ZBODJONWhHV2E2UTRr?=
 =?utf-8?B?cEtjNzdkeFlOWlpIcGpDaThaTXJMR0thTGtCMGxqOC95MkYyTHpPdFlTQTFr?=
 =?utf-8?B?SzRPb2FMQVNSZU5nbDFMbXFzMEpWc0cvTEEzNUtVY0c3ZWw1UTI0NWQycmhu?=
 =?utf-8?B?azVsZmxmN0FRMUs3TkZiK3ZFZWh3ajVqMjQ5c3laM2F3U3dyVDErVWRON1Bi?=
 =?utf-8?B?SllIaktRUmlQVFhHc0tLSnlwT21TZ0N2ZUFENUtkN0VwY1I4TXl6RUtyZ05q?=
 =?utf-8?B?U0I2K3NYWWF2V3l1elZFS1dMeEg3NFdLbmNqOFZaRzg4Q2w5MzAzNW9QcDRw?=
 =?utf-8?B?UkRhdnJTK3FjM3NoQWJad3ZacjdJN3dtcHVoZW5IdkI3MXF3aTJrdmxUWnlm?=
 =?utf-8?B?MWJiQXBpQW1xMmxMWHBXR0lXNFNpM0wwZndlYmVRMUNzWk5TR2NXdC9GQmE0?=
 =?utf-8?B?NWIwc2xZbnhQaXl1RzZVckIwRUdMMDRiYmJJVHdxWUpWem1WVzVqYzU1S0cy?=
 =?utf-8?B?bnFrY25rdFp6SjZVWGhJUTlieHBUVXpCMHYvYWxwL3VSdGZRbjhiRUhiRzFJ?=
 =?utf-8?B?NE9Ra3FVNlhjYW4xRHhIQS82Y2htamU1aHVCZVFMWXNvOE1BckRLWm53bDJN?=
 =?utf-8?B?SXJ1cEU0c1JtenYyRkFrb1RObyszMElBdFlDRzlzWVhUc1AvQ1R1OWF1aTd1?=
 =?utf-8?B?d0FpV25KcUhBQ1lPUSt0QU9SSW1RTWxNWVFNbmh2dzVLWXhtZE9wNVR5NW9N?=
 =?utf-8?B?a1V6REFuZ0xPVTk5Znd1UllHNmpCa25LSlhRRkhCQ0tWdk4wL2E1eGM0N0lj?=
 =?utf-8?B?WmhuUW5LeVhHcHZsZ2dRT2ozT3dSSFNpMTY3aVpUK1ErZDkvNk5RbWVrSFZT?=
 =?utf-8?B?aFR3eXVmZGVCM3ZIZ1RiT0RNOFE1bXQvK3BYdGNOYm52amlOeFNlWGdJUTcz?=
 =?utf-8?B?bG00Z1pUR3JRbHpPTGxsVjZ1RTkvQjNpZmk5VzVwK1B3bG1GeTdjRjBvbGxj?=
 =?utf-8?B?TzgvUHhsTUlCckZQa2paZHJOU0Y0YnZCaDFsWWtJMUF1Z0loR09sWjdiNzYr?=
 =?utf-8?B?ajRTaUNXaG1sYTJpNEJueWZRYXhQN2UyMXg1Wkp3ckVIVnB3OHZoK01aS2Fy?=
 =?utf-8?B?aWVhWUd0WTRBTWVvcGE3SjMxUTczT2JCa1J6MHNJOFJjV3FibGVXeXBIbWhD?=
 =?utf-8?B?WVNSR2RuR09VSmtNeUVYV3kzMXJFc2ZjREhNVDdmZWdWYy9XeEhSRzJCUDl1?=
 =?utf-8?B?aXBpNTY2SkhKYUZrMVUzWFZLYS94Z0ROY3I3NC9sTW53ejcrWWE1WVBMRE5L?=
 =?utf-8?B?MWZXcGk5bUc4dmdMcDFrWTRrNkFsOXlwcmVuNC9Sb0cxNHVxSWhDaHY1cHd4?=
 =?utf-8?B?cENod09ZS3o5UmF1RzJoa1BKZFFrS1p5SERQVVZ3bmduRUZVQnQ5cUhOMGJs?=
 =?utf-8?B?djZSZHVNNW9rRVdzUC9DNVlNdFVnUGgwVEJ2ZkpCdkk0ZjVOd1hJMTNIeGFk?=
 =?utf-8?B?Kyt3OGc1SVNNam51cjBReXNHQmRkYXJuVGxpQ1pLbVNmMTlobitNYUMyMSsx?=
 =?utf-8?B?YzZXVFJLMXpFNEx0UHFUd3F0OXF6UlNCWGQxYWppSzZoWGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVpVenFFYkdZeEErd0JSQkVoem1FRUtseWdUMFdqM2tSYm9rbk50L3J4eWZW?=
 =?utf-8?B?b3Y0TjFlWUgzMm9ubnJ3K0VYNXlCT0I2clVVdThyR1ovZGhQQURTTUcxZXJO?=
 =?utf-8?B?V2hLWnYzV1lneFNOYmpPVDRpcll1RzQ4RlZBSWdBVThvMEgrUlU3Z0M2TFA5?=
 =?utf-8?B?OWhDQ2RuZmVwS20veDl3dVFRUUJjeWVnWWFWR055VEdTZFdzRDhnaVVtVTI4?=
 =?utf-8?B?azlJNCsvTTRUUGFOWTdpai9jY0xYUGxsVFNnV3hwa1ZCSlFVSkVIcythc1Rs?=
 =?utf-8?B?aSthSWpjNmg2WS93NWNxdWJ6ZExiVjFOeFZFOEFkOUlWcE5mVWptV2Q2ak9n?=
 =?utf-8?B?cmVuM3FFNmc4VHdKK04zbDBQN3h4K3p2Q2h6T29CTUQ0NHVDa25jVlhFamxy?=
 =?utf-8?B?RnNNTGgwb0lGQU1EZERtbjEvd3BDY0R5YS9jbnZRclV2bThJWU1kMzBleHFK?=
 =?utf-8?B?QjB0Z1hNRjBKemtpeG5uM01lSTZQb1hLQkxneFBtdEpkMXc4Ym1RVW5RK2Zz?=
 =?utf-8?B?d0NnQlVWemptcHZOcUtZZ2RXWFdzcngzU1pwdGJTYXZyaHRDVGR5S05xMEh0?=
 =?utf-8?B?aE8zaGlzY0E4cm1jTHltbjNlaGx2aERNNnVKdVFtMFFOZ3VYdWJHUHZoOWgr?=
 =?utf-8?B?ZkZFUE9iK0tlU2JkYmNlUTlURnZCeW9kRENGa0JxWE9MUCtmelYrZHcyTmMz?=
 =?utf-8?B?SlIyWmE4QWZtVTRUYlduK0F5M0p5dHBld1JURHZxREhsaCtFa2g4aW1HbG1x?=
 =?utf-8?B?L1hBR2VHOG9JU1hMS0FWZW5GY0I2cHhkN2dOc3JtNTZ4dElaRzBCSEwraDNN?=
 =?utf-8?B?RnVGUTVrUHJPYm9PZWlPcTNxM1VtK2FzY0lybGQ0cm9Eald4SzVObW5Lb29a?=
 =?utf-8?B?VGFMOVZpejZrN01oMWNmSENldTNURUltUXlxcXBCYjQ0RkJOMlhtY1lPemdP?=
 =?utf-8?B?bXBMd05ibU1FeHdIMHNLT1NMV28zWE9wYkNEUElMSU1KRlZNNXBWK0tUVTlW?=
 =?utf-8?B?UXB4Yk5SdEwrRTh1RUtUNlhML0pXWHVJZVZrNjN2WDdYK0czTTJ3MGFZcXdK?=
 =?utf-8?B?a2FJNmZySlpFdkZ1em5GMXVxcnl4eWlhRFVDYTJPaitOVjNaeENraXZ4Vjhi?=
 =?utf-8?B?UjZtTXRQcjYydzdmaTVvNUNCT2p2OGF6WGNqS0I0QS9FOTIwaTltOW0zaUM5?=
 =?utf-8?B?bnZ3ZGkraEFKS3diVmovdFhYTnZRSzk1Z0J4WkNSdUM3d1hqLzhxUGNlRFUx?=
 =?utf-8?B?TlU3aVZ5N1V1MjU1ZmM5bmo2MlhtQ3I0R3Y4c3kvQUQvMWVzMlN3R092Zkx3?=
 =?utf-8?B?V2s1ZnBaZGRvVGU1RWJOa1VLQ3hSQStLRUd2cWpZWFJtdjVPL3c5bWZhcUxk?=
 =?utf-8?B?TDJoNTl2MzdXQnNSNDZOWnc1b3hTV1Z0Zm5jT2VrbzNvTnUrdlQyRGIya2N2?=
 =?utf-8?B?MjFSSjQyN2tPYWtNc1hRV3hibjNuaGgvMGZnRk4yVDk5OHlZRmNPcjZtS3g5?=
 =?utf-8?B?U0NybWZDWmorazRRTzJzejZnazl6UmgxbUhpbDd3ZzRYamMzNjkvZzZWTzdv?=
 =?utf-8?B?cmhrR2xyemQ5NXlOV0l4bGdUVjF2QVgwaUtIeGhMWmFmN0NET0JBQ2REbUVz?=
 =?utf-8?B?Y0FycjlYalhGL0dpVFpabno4NGJCekdJcU5yOGJ2NEFtdmVLc2plL2FiT3E5?=
 =?utf-8?B?L0hsUkxpOUF6MU96anRReHNEL21mMmc3b0hzYmdaekpzdE5pRUtQQ1VoVFh3?=
 =?utf-8?B?UnFNUXhVUnByNWdseTVoTTBSc1Vra0ducURvWlpHQS9xcFd4cnlVNXdVVnlp?=
 =?utf-8?B?RzhWYktVcW1PVks4bC9pNElCN3NIUHIreG1Ka0dJbmZVdTVNQUpqczRlSkww?=
 =?utf-8?B?cjUxdW1peUhvMVJqVzNta1FaRzJtcjdxdVN3ZDhLTnRxYzdzWklBbWdwUnl2?=
 =?utf-8?B?dWhGWUlnT2prRGM1eVhFRGFiYlZ0SDZvVE5acjRkampiUklCSkoyMzN3alNu?=
 =?utf-8?B?RFNFL051OU1FanlCd3lLVXRtYXlaeXBKcmUzendQZVBTcmVxdWJhdVhUdG8y?=
 =?utf-8?B?dG1Nei9JTE9EUmN0d3VsV01yaHBVaVUzY3BNeTRvQk0wNHptT09wMzZIY3Y0?=
 =?utf-8?Q?pkc8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd669ad-fe21-464d-e02e-08dcb82221a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 03:19:51.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kWU5IQl1KNjfsdGHmh8izoU0p0gxcd8GnclFgPmPstIwNxtLoYL/QvR9JJD3iyAwoAwFjfl+AXL0z84VKDu5FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10719

SGkgU3RlcGhlbiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvMl0gY2xrOiBjbGstY29u
Zjogc3VwcG9ydCBhc3NpZ25lZC1jbG9jay1yYXRlcy0NCj4gdTY0DQo+IA0KPiBRdW90aW5nIFBl
bmcgRmFuIChPU1MpICgyMDI0LTA4LTA0IDA1OjMyOjU2KQ0KPiA+IEZyb206IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gaS5NWDk1IFN5c3RlbSBNYW5hZ2VtZW50IENvbnRy
b2wgRmlybXdhcmUoU0NNSSkgbWFuYWdlcyB0aGUNCj4gY2xvY2sNCj4gPiBmdW5jdGlvbiwgaXQg
ZXhwb3NlcyBQTEwgVkNPIHdoaWNoIGNvdWxkIHN1cHBvcnQgdXAgdG8gNUdIeiByYXRlDQo+IHRo
YXQNCj4gPiBleGNlZWRzIFVJTlQzMl9NQVguIFNvIGFkZCBhc3NpZ25lZC1jbG9jay1yYXRlcy11
NjQgc3VwcG9ydCB0bw0KPiBzZXQNCj4gPiByYXRlIHRoYXQgZXhjZWVkcyBVSU5UMzJfTUFYLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvY2xrL2Nsay1jb25mLmMgfCA0Mg0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzcgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IFRoYW5rcy4gSSdkIGxpa2UgdG8gaGF2
ZSBhIERUIG92ZXJsYXkgS1VuaXQgdGVzdCBmb3IgdGhpcyBhcyB3ZWxsLg0KPiBFaXRoZXIgeW91
IGNhbiB3cml0ZSBpdCwgb3IgSSdsbCB3cml0ZSBpdCBuZXh0IHdlZWsuDQoNCkkgYW0gbmV3IGlu
IHdyaXRpbmcgS1VuaXQgdGVzdC4gSWYgeW91IHdvdWxkIGRvIHRoYXQsIHRoYXQgaXMNCkdyZWF0
LiBUaGFua3MgaW4gYWR2YW5jZS4NCg0KVGhhbmtzLA0KUGVuZy4NCg==

