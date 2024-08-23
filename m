Return-Path: <linux-kernel+bounces-298315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4E95C5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977FF1F23C61
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE357137932;
	Fri, 23 Aug 2024 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CaEtgm55"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924867640D;
	Fri, 23 Aug 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395227; cv=fail; b=DvUsoe16D8FQy2Lkc04eGlkoSjSmLV90GbUYh97BvPxrkIHZV8LUAP00Jlg3VMGrdcHlMO1VTzKDd+MLU0JvZDrU+iaJQ9i1al5ZV3gOhCpau31MRpiUbtLDhU8NsG2l1+iO39hk2hzlFfY/mXydizJZz9mK9bgKe21ehwUgj24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395227; c=relaxed/simple;
	bh=VYTm+OknIWZt0b1HjpiD+UQmriQrxTmx7b0hlHt4nks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OD7mc3+3xpZze2xHwUmPVgRNlgV2xFqfFKuN7Q5GkZSlB9e48KjlIE6RPC88+div3VRwLcuN7XPniBemLeedlLcxDu6/i+Ity7TvSI4NBALreRZnFjViwerLgRvBZxx3683C14k1mYVykHtAwDxwoWhJbA8fOZNfOOIUCXk4MQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CaEtgm55; arc=fail smtp.client-ip=40.107.117.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hi9QsfXxhuEApRADGk2odI9MIoLKrj5i4WbdtKvY0JdIGhS19v26HGOwPMHg4mJVNHlRqN1eiu5/U6jenJpVJ+LsZr/JFDm7SAJyT/FK73JqI9NdtRqShCNtcE+Ogcv6dkzsQNhA38ZENaXyZPd5ULkpSCfLMCCbo89mDtE3iGFbXRaj/nqbkAxUG1A6MlldisEuNiNCjqo+rJscYoTK2WU8MzKB9dkWs9bfxEdDGF9MxZzk142fTLsA5yQ0bsSNiklvOVYAZXEoVZ2CP0lxtpwN+YdXscam1FaBJnzSoueomrYYdolNaRN8Qg8sQCr1kWmqAzqyOaMbOGVzc+m7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYTm+OknIWZt0b1HjpiD+UQmriQrxTmx7b0hlHt4nks=;
 b=JrRRNfcg2kNRDE2S14RPzW6hGLnuwL6IZ477fhpPK68IY0HQmr5dTJg4qFvrJh0T83tWoo9tTVd+RDSn/TZ00SzrUia1zvRQgPTPWsj6nVkZNdxOjXSHJ9yA4kek34zlxSuHLigfmuSorlIdc8X9DEx9IWlMTa3+ja/4ZSdZX2gVVvflJtmeuJMpGjc2Mu3vMiVuYMN4LoP1ppYG7xnYrTJQlNJ8UZacDZMOtg6PUjfF52pH9W2SivXQ6PWOmEPizjNCMsGhHVbtOfN9D2biDBignJIMsO6+qAwDN7ikBNbkaNswbODu2UfQpb6SJ1eRlTaQ3uVOE/eRjKW3hEQedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYTm+OknIWZt0b1HjpiD+UQmriQrxTmx7b0hlHt4nks=;
 b=CaEtgm55v+sQ6C55LpFNv+ZQqNYVb/NhHKFnUdSdEJmLSPqBYKJS4k6/0VdqnkISm9VDpnQs/ZcRqDFi6c3zFzvyUtabZUj6OnAd92MEkhaitR7JnJ1NJ72xfTn5eu6tX0PaK6M6tNvemBc16BxGptvzkvgWXwdkfVg0U8O09i5BFvyfdaytsEZUJgBvA+872S9DIUUSQQNUg0vPo4//vhJyg8wdhn09SDp9M0+McvTHs43UCmdXnjF9ih/B6V4JomaBT1PHGgOeL3GP2lo351GsWhZ+kgk9nKzYnOXXj/BPxcIhd7JT51vCrkBWNfrwBqo5gxqom0zw20e+4cOCdg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by JH0PR06MB6343.apcprd06.prod.outlook.com (2603:1096:990:18::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 06:40:18 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 06:40:18 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Prashanth K <quic_prashk@quicinc.com>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjZdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogQWRk?=
 =?utf-8?B?IG51bGwgcG9pbnRlciBjaGVjayBpbiBnc19yZWFkX2NvbXBsZXRlICYgZ3Nf?=
 =?utf-8?Q?write=5Fcomplete?=
Thread-Topic: [PATCH v6] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: Adr0Om++URnaGaVeQfyA+J7u99KqHgALztYAAAgn/bA=
Date: Fri, 23 Aug 2024 06:40:18 +0000
Message-ID:
 <TYUPR06MB62176043F3E6D6B6675301D3D2882@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62171A7BF25AB6963CBA07FED28F2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024082251-grief-profanity-b0da@gregkh>
In-Reply-To: <2024082251-grief-profanity-b0da@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|JH0PR06MB6343:EE_
x-ms-office365-filtering-correlation-id: 9500b526-97a3-42d3-9ff4-08dcc33e740f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZU0zbnZhK2NDTnlOQXVhUm9WMTNyZWdacjdVbm9QRk5HRmZLc1oveEZFWXl2?=
 =?utf-8?B?RnFoM1Z2V2pFbUxrRlc2OGRmUDd2eUlpbDdoTkFkb3A4NCsxK1huR2haNFJi?=
 =?utf-8?B?VEJTb2xXOUFPeUprUlIwdDhsb2p6NlB2YTBpa2Erc01QbXpqYmlVeHdJRzdK?=
 =?utf-8?B?UXJrU2lxVVd3OVdPc0VuNHFhTXQwQ1lDcDYyWUxEWFIzQnhzNnNDSTNHZkRi?=
 =?utf-8?B?YXd6a3hSSjZpbzN5NEN0ZHowQm1hTTF6NFlJL3d2UUNPYVhKaU1JS0IwbUJM?=
 =?utf-8?B?STNMY2NESVBKeGRPbDFZYStVVDNmcjZCYTZPbDVna0Z3b1F4SXFyKzdJZ2E2?=
 =?utf-8?B?QWJuYkhMRXJvNnNBdTNEOUVFL1p5R1d2NEZiZUc3Q25MZ1lHR1E2aVUxNDNt?=
 =?utf-8?B?aE9PUlZqcHI1K013MXBtYXRRQ1FEMkpZTWhuRzBGU0FoNmJITlBIZldVa2lD?=
 =?utf-8?B?OW91dER4T0p4QWl4ak95bmZ4amF1VHBPRkxCS2lndWc1Rjg4Wi93VHdQdThz?=
 =?utf-8?B?V3hITzlVNXhpTC9YeElBQlVlZHJxb1BteTc5aThUNi8wcURHM0cyS2xNalBE?=
 =?utf-8?B?MXFFMjNyellOZ29aajRDTmFDQTFsckVOY3RCNDB5V1hYWFo2M3F0MGlVL1N2?=
 =?utf-8?B?bVJIdm05UXROcFZsOUVaa0FEZE9aY0pxQlN1Zk42KytEaGdRek40MC9QcXJu?=
 =?utf-8?B?akdtTWJnUkFIWEsrUU9GWEpRR2hHVlBrOUZIUG5zdFl5R2hjTTh5V1pteHJt?=
 =?utf-8?B?RHMxUWwrK1RYdGJXWHNpaTRHYTFwalVSWERiaGlYVGJsUGwydS9IYWVucHNG?=
 =?utf-8?B?dlczbVU5Z0RHaHpJNXQzZGpoVkRyNkxnRWVnSjBqY2c5Y0FuV3VMWlJaSmdp?=
 =?utf-8?B?V2Q4V1BCbGtJb3FLOWNkV21OZzFaTkVxaUl1SUc4VVJ4R3FjT1dMcEFhSkVB?=
 =?utf-8?B?RHpMR3pEQ25tV1VCUER5eEFIUWJsVmZYamM0blp3R256RHZuMGxWQmVKMGxY?=
 =?utf-8?B?VEdqbnIvc2oxeVExUGU1YklrRW1XeHBIOFFmc2pnZ2o3NUdSN0JYdDNlaXEy?=
 =?utf-8?B?TXVPVGRsZEJWREFRNkc4cm9BeVBxN2d0WnZUWkhzSHRPMTlOY0ppZzBkNEFG?=
 =?utf-8?B?MS84eUxwZ2Uwd2s5VFN5bm9JMkJtVUtReHBCcFc0blA4ak9WNkQ4TXpFUVFS?=
 =?utf-8?B?WEZKUCtOYzk0a1BUcHAwc2pVZ1REWVBxODVLcVpnckNyV1NqRWJlN0ZYb3FK?=
 =?utf-8?B?QmU3TWxraTNXbzJaR05xc1lITnJyellxK0NMN3kyNE1WWUpBSjdsK1c4YnBD?=
 =?utf-8?B?OFJZYzUrZVBFWGxOcnVLTENFUDVnbUgxeWhhWjdWbUt3bGZQS1lFWTZrODNM?=
 =?utf-8?B?a1h1MmxhaU56TGgvUEhCYWhIaUF2RjdNem9EWG9lQjRUNXViNmlsM0pjZ2ll?=
 =?utf-8?B?Mm1EN1FsaXVOZ3JjN211SHpHK3IzYnN4aTA5L2o3Q05xZW8zdXg5YTlxai9F?=
 =?utf-8?B?ampqRGRPMERvbEpHVkc3NktibFJmOGNrMUxJTUQ4dE8vVGpRZUdkVW9qWU9l?=
 =?utf-8?B?ci9tSVZid29pZGUvNnNHemV5ejBEaG1JYkZGMlE3aUw5eXd4NXV5MzhodXpm?=
 =?utf-8?B?NzFjVUpMNFRJb21XYWJJcktVY0FiZmszekpSSTNrMVBZNUswcUxqamNaRHRG?=
 =?utf-8?B?eW9ETDJ4aEFIbG5acWkzenlkT244dVB3K09yY2VNYU95ZHFwaFVKczJmVDhv?=
 =?utf-8?B?dE5JcnE4UG1KSHZleUNKNDQyaTlON0xVYmFTM21hVjFQUVVxYVZMRERNZ0JL?=
 =?utf-8?B?N2swYzNSSUNkNDJXbW1lTVRMQThzWi9nOWVvTjhQaEJwYmxUUkc4bDMwazRN?=
 =?utf-8?B?czkwSlJrbCtwNE0vUlczSHlzY1l3N3p1WFpnR1krd0JhT2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVhiUHY4SlErT3lqL1BINmppQ1NGcVkyUFV6K2hpcWxta0l5Z3hiVjdrNHZL?=
 =?utf-8?B?aUtxMVpZVE4rSE1kNGdtQ215dzBQWUZzRjNFN29Va2NTbWJKcWRKRVdyNXE4?=
 =?utf-8?B?Y2o2TVpySm1PRWhmcDVwMWdXLzUzdjZCOENCMU9CbXBURXdyZEJWZlhJZGY0?=
 =?utf-8?B?MkRtWDg4dGtSOVBKUzF4d2FUc1Q0OERBL0tUa1hqWUVZTGNtQS9KVGh6Y29L?=
 =?utf-8?B?cFZaS0tUQmpaUndTanZNZVZiRzZBaXRPL0MxODJIbzJjeUdYMlpYMkFMam9o?=
 =?utf-8?B?Qmx3Qzg1cEZGNXNUQkVla0dnVjFwbkpRenhTZlRMSHcyNGxJdUFnb25xNFQx?=
 =?utf-8?B?WWdmWVJQbmdXWWZuM2dYcm1QMTZLQ0ZpNy9kT1NHTU9UcHcrM3IxRVFkSkZk?=
 =?utf-8?B?UVk3cmJPWjI5eTducHFtMlFXdWwxeWFQVitMWjJVRVZYcE1adXUveFM4c0g3?=
 =?utf-8?B?MzdVazZ0bEU0NEkvKzNzNlEzdVNtZ3R6bG9ZWEJDRzdQSml6elJjelNZS1J5?=
 =?utf-8?B?TDdQZXFuOElWT1phc1JYeGlpL3lUd3ZmVHJsYno0YmtPT1VPUmVkSi80aHdo?=
 =?utf-8?B?ZS9paHNmVGZGMjB0MUxHaWJtS1ZtSHUycVVhN2lkaTF6cTFpbnNiQlBPVzFR?=
 =?utf-8?B?RTBtajgxWVRNZ001Q2lSU04wNmptMzVna2NTSEFjTGd3bEdMbkFFVSt5WUt3?=
 =?utf-8?B?aWRkWHVRU3dlazhSQy8yR09ZYmEyV2o2ckN4dVR3V2tmNjROTGtSQldpaXUz?=
 =?utf-8?B?TU1oczRKMVRTVWt1U3VHa3p5UmFsRzhvRFpBQVRjQ0NLNW83RGh5WDVpYWdS?=
 =?utf-8?B?bjh6bGFBN1k3ZkIwVHpTc3JtNlp4WTJlSVpuTWVGTXNoaWsxeGNsN2tpaEFr?=
 =?utf-8?B?MG13QVZabXAyTm0xZlljVmlGMVkySmdiTURKSnFGZlZsaDZ3RERDQlc3bGNy?=
 =?utf-8?B?SXAyeGxWV1dRbkdJMXFySkl3RlVYeWlYUnl2UERtOHJZVmFLUDNnY0o3RWll?=
 =?utf-8?B?K0F3amoyUklWLzlyUFo1dUV3M2ZGT09kNFA3dE51TmJEZ0Fja1FzM1F4UFhB?=
 =?utf-8?B?Z0p4bHNTTk5IQzNVSTg1cTVOUDE0NWRHSmxuZnBYMVhHR1pzcjVCRWliTG8x?=
 =?utf-8?B?eUVPclYxVFFUeUJSTExsaXpwOTFvZmF5dnpWUUIrVWl4TTNISS9hZitnRUx5?=
 =?utf-8?B?cG4vdDg5cUNON2RieE93UFJMVDkzNExxZEN4MlVlMTNWRmNEM253V1YzWHFj?=
 =?utf-8?B?ZlRwdkpOUXAyQjJJUTBibWRzdFpEeThHRE1mYzlaN3dZVW9sYkZBd3JWYmxV?=
 =?utf-8?B?cEhLV1dpeGJmM1l0SmlCM0hWT1d6VWlwQVdzdk84YXkrdzczTmlCWXY0QndM?=
 =?utf-8?B?b1VlQVdQbC9qWnQ4MUVFMWNQSXVjNUJGSCt2S2htQVVwWkZ3c3ZlY1BXQlhx?=
 =?utf-8?B?RlFxZHFoS1BoTTdEYURGc3pvUldwRDJKVTVXdnY0bVFlYVNpVEptcVcyZ1RW?=
 =?utf-8?B?Zy9uUmVPVkE2QXROYXlqRWVGSkcrem80L3JZSVpPUDhoVzU5K3VZb2xMYUZn?=
 =?utf-8?B?VUVJelVMaHhEWEVZTjRNYTB0TWJkUzcxUkFtZE5SdHlUSUlia0JOak9PN0dX?=
 =?utf-8?B?R2t1R013SUdqMnB0cW52anFWSWpUOHg5K0wwaExsUzNJeE8rV2NRVVZHTml4?=
 =?utf-8?B?NkNIOGRqZ3dEOWx2U1NkWmRjeWN1MHJUOHpxVVgwT3ZZTkNmZHhtMTAxZDlt?=
 =?utf-8?B?enY3RjhLcFJDL205ZEJlM20rb2JnbEdHSDBNSmtrVjV6RGVzODU1YUJReFpZ?=
 =?utf-8?B?VTI2UmtOakdrd1BDT1AvTFZhZHpnWmhSS2tTcEo2enFRdkN5RXRVSm1NdTZS?=
 =?utf-8?B?Qy9Tc2RwcEtSME5EN3FvbHNZdGdnZ1VhSHZjMlg3QTdxTGVmdGxSV1QxaE5D?=
 =?utf-8?B?ME9nSk04eG1TeU43emJqT0VvK0lQcm5JWWxsdzBLOWpyYkFuemdrS0Z1NCsz?=
 =?utf-8?B?M2loNExxTkFOTlNzWWJ6bnFGbERWMzdVblU4enExdjFna0sxWUxkaVZseWlE?=
 =?utf-8?B?bWVBZHIxV2VPcjQvR25qd3NicjhwcGdhWWp2VE9ORngwazA2VjhqVFZ3V0J0?=
 =?utf-8?Q?NLRg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9500b526-97a3-42d3-9ff4-08dcc33e740f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 06:40:18.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzrWwULaI4lTfkEnrGsnIM1ENs+FI9zPYY3pVafZSnA07Vb6PbBX9RAJN1OWSMlUY1SJmTwPUyZfSoLEXKU77Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6343

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPj4gRml4ZXM6IGMxZGNhNTYyYmU4YSAo
InVzYiBnYWRnZXQ6IHNwbGl0IG91dCBzZXJpYWwgY29yZSIpDQo+PiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8u
Y29tPg0KPj4gLS0tDQo+PiB2NjoNCj4+ICAgLSBVcGRhdGUgdGhlIGNvbW1pdCB0ZXh0DQo+PiAg
IC0gQWRkIHRoZSBGaXhlcyB0YWcNCj4+ICAgLSBDQyBzdGFibGUga2VybmVsDQo+PiAgIC0gQWRk
IHNlcmlhbF9wb3J0X2xvY2sgcHJvdGVjdGlvbiB3aGVuIGNoZWNraW5nIHBvcnQgcG9pbnRlcg0K
Pj4gICAtIE9wdGltaXplIGNvZGUgY29tbWVudHMNCj4+ICAgLSBEZWxldGUgbG9nIHByaW50aW5n
DQoNCj5Zb3UgbmVlZCB0byBsaXN0IEFMTCBvZiB0aGUgdmVyc2lvbnMgaGVyZSwgSSBzZWVtIHRv
IGhhdmUgbWlzc2VkIHY0IGFuZA0KPnY1IHNvbWV3aGVyZSBzbyBJIGRvbid0IGtub3cgd2hhdCBj
aGFuZ2VkIHRoZXJlLg0KDQogVjQ6IEFkZCBjYyBzdGFibGUga2VybmVsICAgICA+PiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KIFY1OiBBZGQgdGhlIEZpeGVzIHRhZyAgICAgICA+PiBGaXhl
czogYzFkY2E1NjJiZThhICgidXNiIGdhZGdldDogc3BsaXQgb3V0IHNlcmlhbCBjb3JlIikNCj5Z
b3UgY2FuIGFsc28gYWRkIHRoZSBGaXhlcyB0YWcgYW5kIENDIHN0YWJsZSBrZXJuZWwsIHNvIHRo
YXQgaXQgY2FuIGJlDQo+YmFja3BvcnRlZCB0byBvbGRlciBrZXJuZWxzIChzdWNoIGFzIDUuMTUp
IGFsc28uDQogICAtLS0tLS0tLS0gIFRoZSBhYm92ZSB0d28gbGluZXMgYXJlIGZyb20gUHJhc2hh
bnRoIEsncyBjb21tZW50DQoNCj4+ICBzdGF0aWMgdm9pZCBnc19yZWFkX2NvbXBsZXRlKHN0cnVj
dCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgDQo+PiAqcmVxKSAgew0KPj4gLQlzdHJ1
Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsNCj4+ICsJc3RydWN0IGdzX3BvcnQJ
KnBvcnQ7DQo+PiArCXVuc2lnbmVkIGxvbmcgIGZsYWdzOw0KPj4gKw0KPj4gKwlzcGluX2xvY2tf
aXJxc2F2ZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KPj4gKwlwb3J0ID0gZXAtPmRyaXZl
cl9kYXRhOw0KPj4gKw0KPj4gKwkvKiBXaGVuIHBvcnQgaXMgTlVMTCwgcmV0dXJuIHRvIGF2b2lk
IHBhbmljLiAqLw0KDQo+VGhpcyBjb21tZW50IGlzIG5vdCBuZWVkZWQsIGl0J3Mgb2J2aW91cyB0
aGF0IHlvdSBjaGVjayBiZWZvcmUgZGVyZWZlcmVuY2UuDQogT0ssIEkgd2lsbCBkZWxldGUgdGhp
cyBjb21tZW50IGluIHRoZSBuZXcgcGF0Y2guDQoNCj5CVVQgeW91IGNhbiBtZW50aW9uIHRoYXQg
eW91IGFyZSB0cnlpbmcgdG8gY2hlY2sgd2l0aCB0aGUgcmFjZSBzb21ld2hlcmUgZWxzZSwgcmln
aHQ/ICBQbGVhc2UgZG8gdGhhdCwgYW5kIGRvY3VtZW50IGhlcmUgd2hlcmUgdGhhdCByYWNlIGlz
IGF0IHRoYXQgeW91IGFyZSBkb2luZyB0aGlzIGV4dHJhIGxvY2tpbmcgZm9yLg0KIEkgZG9uJ3Qg
ZnVsbHkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLiBBcmUgeW91IGFza2luZyB3aGljaCBsb2dp
YyBpcyBpbiBjb21wZXRpdGlvbiB3aXRoIHRoaXMgb25lLCBjYXVzaW5nIHRoaXMgcG9ydCB0byBi
ZSBudWxsPw0KICANCg0KPj4gKwlpZiAoIXBvcnQpIHsNCj4+ICsJCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCj4+ICsJCXJldHVybjsNCj4+ICsJfQ0K
Pj4gIA0KPj4gLQkvKiBRdWV1ZSBhbGwgcmVjZWl2ZWQgZGF0YSB1bnRpbCB0aGUgdHR5IGxheWVy
IGlzIHJlYWR5IGZvciBpdC4gKi8NCj4+ICAJc3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0K
Pj4gKwlzcGluX3VubG9jaygmc2VyaWFsX3BvcnRfbG9jayk7DQoNCj5uZXN0ZWQgc3BpbmxvY2tz
LCB3aHk/ICBEaWQgeW91IHJ1biB0aGlzIHdpdGggbG9ja2RlcCBlbmFibGVkIHRvIHZlcmlmeSB5
b3UgYXJlbid0IGhpdHRpbmcgYSBkaWZmZXJlbnQgYnVnIG5vdz8NCiBCZWNhdXNlIHRoZXJlIGlz
IGEgY29tcGV0aXRpb24gcmVsYXRpb25zaGlwIGJldHdlZW4gdGhpcyBmdW5jdGlvbiBhbmQgdGhl
IGdzZXJpYWxfZGlzY29ubmVjdCBmdW5jdGlvbiwgDQogdGhlIGdzZXJpYWxfZGlzY29ubmVjdCBm
dW5jdGlvbiBmaXJzdCBvYnRhaW5zIHNlcmlhbF9wb3J0X2xvY2sgYW5kIHRoZW4gb2J0YWlucyBw
b3J0LT5wb3J0X2xvY2suIA0KIFRoZSBwdXJwb3NlIG9mIG5lc3RpbmcgaXMgdG8gZW5zdXJlIHRo
YXQgd2hlbiBnc19yZWFkX2NvbXBsZXRlIGlzIGV4ZWN1dGVkLCBpdCBjYW4gYmUgc3VjY2Vzc2Z1
bGx5IGV4ZWN1dGVkIGFmdGVyIG9idGFpbmluZyBzZXJpYWxfcG9ydF9sb2NrLg0KIGdzZXJpYWxf
ZGlzY29ubmVjdCguLikNCiB7DQoJc3RydWN0IGdzX3BvcnQJKnBvcnQgPSBnc2VyLT5pb3BvcnQ7
DQoJLi4uDQoJc3Bpbl9sb2NrX2lycXNhdmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCglz
cGluX2xvY2soJnBvcnQtPnBvcnRfbG9jayk7DQoJLi4uDQoJZ3Nlci0+aW9wb3J0ID0gTlVMTDsg
ICAtLS0+IHBvcnQgPSBOVUxMOw0KCS4uLg0KCXNwaW5fdW5sb2NrKCZwb3J0LT5wb3J0X2xvY2sp
Ow0KCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCiB9
DQoNCkFmdGVyIGVuYWJsaW5nIHRoZSBsb2NrZGVwIGZ1bmN0aW9uIChDT05GSUdfREVCVUdfTE9D
S19BTExPQz15KSwgdGhlcmUgaXMgbm8gbG9ja2RlcC1yZWxhdGVkIHdhcm5pbmcgaW5mb3JtYXRp
b24uDQoNCj5BbmQgd2h5IGlzIG9uZSBpcnFzYXZlIGFuZCBvbmUgbm90PyAgVGhhdCBmZWVscyBv
ZGQsIGl0IG1pZ2h0IGJlIHJpZ2h0LCBidXQgeW91IG5lZWQgdG8gZG9jdW1lbnQgaGVyZSB3aHkg
dGhlIGRpZmZlcmVuY2UuDQogQWZ0ZXIgdGhlIGdzX3JlYWRfY29tcGxldGUgZnVuY3Rpb24gaXMg
ZXhlY3V0ZWQsIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUgaXMgdXNlZCB0byByZXN0b3JlIHRoZSBw
cmV2aW91cyBzdGF0Ze+8jA0KLQkvKiBRdWV1ZSBhbGwgcmVjZWl2ZWQgZGF0YSB1bnRpbCB0aGUg
dHR5IGxheWVyIGlzIHJlYWR5IGZvciBpdC4gKi8NCiAJc3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xv
Y2spOw0KKwlzcGluX3VubG9jaygmc2VyaWFsX3BvcnRfbG9jayk7DQorDQorCS8qIFF1ZXVlIGFs
bCByZWNlaXZlZCBkYXRhIHVudGlsIHRoZSB0dHkgbGF5ZXIgaXMgcmVhZHkgZm9yIGl0LiAqLw0K
IAlsaXN0X2FkZF90YWlsKCZyZXEtPmxpc3QsICZwb3J0LT5yZWFkX3F1ZXVlKTsNCiAJc2NoZWR1
bGVfZGVsYXllZF93b3JrKCZwb3J0LT5wdXNoLCAwKTsNCi0Jc3Bpbl91bmxvY2soJnBvcnQtPnBv
cnRfbG9jayk7DQorCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBvcnQtPnBvcnRfbG9jaywgZmxh
Z3MpOyAgIC0tLT4gSGVyZSB3ZSB1c2Ugc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSB0byByZXN0b3Jl
IHRoZSBzdGF0ZQ0KIH0NCg0KVGhhbmtzDQo=

