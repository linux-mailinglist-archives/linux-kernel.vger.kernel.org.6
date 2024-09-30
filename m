Return-Path: <linux-kernel+bounces-343578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096A989CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE711F2251A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E60817B506;
	Mon, 30 Sep 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IteZ2HRq"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2085.outbound.protection.outlook.com [40.107.215.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D7165F1E;
	Mon, 30 Sep 2024 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685248; cv=fail; b=jBEV4xMt/BN6g48BT3+0mra0nL4nTrEftjKeQYopLBN3FJtLm6XCMp8JK+x3MWQou9Fg2BYDxaapXZb8GCqfK8Gg22ZpDyAOCnHpTccEeF6MLrBoo5p4lfnJOLu+4Njp9+z1lazotOgjA86r7zX56JG8yOyeZTej97yULg0DK5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685248; c=relaxed/simple;
	bh=7KRPq7vKVZpIlIjrOBfseI1qWAXTvxiXquPxtily6S4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CqpjaVB+SiQH4eEDyaDpd6qK9g754Ld5OQcztPDON5Mj3vdRXCkv/OubLtxRBwXIEaRjlaqDB7lr4VwQJ8XkJ1mDOaVdqf0si3gvmkMtwG+36Ahipv5ia/33pIv737MVSm0EqFOoJf0uxGRC4+uPPBsbSim9QBDPb1HmpIeEYxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IteZ2HRq; arc=fail smtp.client-ip=40.107.215.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRDbgFIziRzpR/NGVG3sxD1i8JFbb52rTPidA66bJyDUlWimVhvhxH56AyYw2j8g7bl897j+gs5XqhhMorStLWKytys+AMYvVvoqndfmzlyZpXF/uNkrxM+3vk8tn/G83Ka7kdDjgv3JNn7PRhu6MbpCpS5A7mtB/KbwU05Zc1OcruADz9JYIpgU+zmXv5XSB5Y/UrPbrEVq/X6xxaRCSE6PQSLJjzIZcsK8QxQO1LwZT0+SwlMCi2TrjLaELqOPqDg5iK5rM9ITJzQtwC3PSlsNk/lep6isxAZPthftYKPkmkeSjEAb8VhC1jAHwrrzi8AXx8nRYTP7SkERCxNOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KRPq7vKVZpIlIjrOBfseI1qWAXTvxiXquPxtily6S4=;
 b=D8Dxr5KkzTGJ0LFU/1Oo4zYti7nKp6OPpeEUFxfLu0exZDJsuqkbDUqtavTBgNdM/+Jyf+Ey7WybagCIq6aUk+KZME2RGf+otFx533vh280yhN0L55k7hGg13DIrvEk9dypFne9zX0wZ2/YjpN4eiQumBJ7WWn0RMSkz9dMs3Tt3pHO8JobJkqwWI8vnzhSnQUUleiQhyJtpdWOMxh0Zwe9SB+VuL9U5LZnyJ/RUA2ZRPNqiowAtuzc0DcCdY+v64LUGUhpplcnCQfLvhNtblO08B6Powt1jV04fALszcddLeXCmd9WQ6lSsGIelMG4qArGnS5Nc9bW8YGwxfdcfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KRPq7vKVZpIlIjrOBfseI1qWAXTvxiXquPxtily6S4=;
 b=IteZ2HRqOjvNaKMvWkeg+rJW0SoIaofZYkrvxYqgjRVQZC25XKi/lUl4ljjS7p5aA0X9VQsUlYjh5WnnaM3kuR0dAYzSvtA+UQewyyDtHfCOrViF1/lCeWd3HLQMmSKgcbpne0OJ8nni/Kc9vlJmRhhlgv10Ir6OrYeg2ubzRFYCBItOVTw2TO2RK0REkJWzgGA6uf8WI5PoRDzIqDR8CRM9gsmUHKPWBKJNYj32ZZtglJH3bouoFrh4YtrOOOCxViIRMLLng55OIkPBPKo4evYdTZKYoVAI3cK6Vf6hQnS5HMtLrR1F46497B2r5uwGnA4t875fYzcUIpmNXLb/rw==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by KL1PR0601MB5446.apcprd06.prod.outlook.com (2603:1096:820:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 08:34:00 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 08:33:59 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>,
	"mmccarthy@mcintoshlabs.com" <mmccarthy@mcintoshlabs.com>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>, "cyan.vtb@gmail.com"
	<cyan.vtb@gmail.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIXSBBTFNBOiB1c2ItYXVkaW86IEFkZCBkZWxheSBxdWly?=
 =?gb2312?Q?k_for_VIVO_USB-C_HEADSET?=
Thread-Topic: [PATCH] ALSA: usb-audio: Add delay quirk for VIVO USB-C HEADSET
Thread-Index: AdsO+FBn473lP8g0TTuwq9xMocctZwEFvBiAAAEBdoA=
Date: Mon, 30 Sep 2024 08:33:59 +0000
Message-ID:
 <TYUPR06MB6217248944269F9AB9B411EED2762@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62177E629E9DEF2401333BF7D2692@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <87cyklk1pi.wl-tiwai@suse.de>
In-Reply-To: <87cyklk1pi.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|KL1PR0601MB5446:EE_
x-ms-office365-filtering-correlation-id: 6aa2fcf5-b1b7-463f-532a-08dce12aa1a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?TlkybUlQZzUzT2RWN1JpNllxVGxqVHM3UE12NXlxZGRnN2VLV2wycWw5QlpT?=
 =?gb2312?B?cmVFMElwNG15NUN4WkpIcXo0eE53RDcvTGpaWlRKam41L1JBYUJTTnQ4NU5V?=
 =?gb2312?B?djRLWUs5NCtIaCszeitKbWlJUCtISm4ycldxK3Vld3U4eUNES3ZPTEE5bHZu?=
 =?gb2312?B?V0JmSlNvTk1wSmhjQjVEd3NnajRCRDVlK0s3Y0h1MDBFeFdKT2pUc3Z6VWYv?=
 =?gb2312?B?cnlVazFKOTByMzRqQTQzS1Z0TTAzNTVSNlFsYzhHK2c5bDVGMUdkaGk5K1Zv?=
 =?gb2312?B?bzVRTC91dE9BbUFCT0RNbG1jemNCTllnR2REcjJWUkNvVS9ZUjZ1QTFzNXdQ?=
 =?gb2312?B?NDVYL0dYUG9tdm83ZlQxZ2o3TVp0Z0h5V1lwMkh6NWJNb0NVS0RiYWJjWEJE?=
 =?gb2312?B?VVM0M0RCbDdlMzlvRVlTZWFjWWhGdzY5UzhUWkRXUnZibmJHQ0pIMk9HTXFm?=
 =?gb2312?B?VXAvMW1FM21lRC9kS2lWVWFzaUFCMDd2ZHo2Zk1vU2hja1o3T3JOcnpZbXpM?=
 =?gb2312?B?QTBkM21aWDNIdGtxUlFWWXJPSFhzajdpMnVQbzhiWVV5djI0QkZoc2FqV2lh?=
 =?gb2312?B?S0YxNkd3SDlMMWRqcGJJOHlVRjF6Q3VGeEJOZ01DYzhianpwUldnUXBPRVhY?=
 =?gb2312?B?QVBCZVdXZVkxQ1JOVDhOR1cyZ0xObnlpbnZxcVA1bkFzY3UyVE1vTVArVVpZ?=
 =?gb2312?B?Vno3M3dlR1lrZzZGQ2lUOHNqWTdYNFpRSFd6eVRvemVlK0kySlFndkpWbHBm?=
 =?gb2312?B?T2VZZ2RLRXJCQXl0L3VFWkdSamI2NjdFVlArTFl4Q2RMeVBvUkdxdWRWVjgv?=
 =?gb2312?B?am52SEZuTkEyT3pmWlVGc2xHRVBCcUdNM0hxUm5HNXYwT01OR09PVmQxSHRH?=
 =?gb2312?B?ZmpiMUY0Y2RCSzBOSmI3eXBBWTVsK0UzMDdOUTJPVFNoQ2U3MFhVTkN2enJQ?=
 =?gb2312?B?dmN5R3JmL2ovMStCcW5iRlB2aExvaE4weUExUk51QkNMN2NxaklueUtjQmpQ?=
 =?gb2312?B?Z1dZNVZpMlVFU1ZrZ0EzRXNFZE04Z0hLcm1XNzJjSThnbis4QTczc0hmRFp2?=
 =?gb2312?B?NEpCbTZxMnJuU3pQajlhc3hyYXE3TTNidlhIV1JDTkVaN1YybCtaSFhkQk1F?=
 =?gb2312?B?cjVBVDRFYUxHYUpOSitPTjVGdVJuNU0yQ2dGWEUrcW9VNW9HNjRSTW91R1Bz?=
 =?gb2312?B?VzFJUFhzdUY3aW9ZbTNYYVdTZ3E2QW5kOTVmeUw5QktvV1o2UldwdmVOazFn?=
 =?gb2312?B?MFNoZzREbkJDK3NxSS91ekx0ZjNNaHJiNXQ5aWgwSTRid241M0tUa3MwMWdm?=
 =?gb2312?B?YUYyaG1VYWRJc1FoWm4zeEFLTUNKSlVWdGswVGNENDBPWTNNeXFWRDNwT3dP?=
 =?gb2312?B?by91VHlTMTBiRTY5dXV0eEZLdGx5MFd0Z29FcytuL05wTVdkc0pYaUdyeStZ?=
 =?gb2312?B?TGtSdGF1S2JJakFJMDljOFlVVXd4U1lyZlZaODhWQ1JKYnRFbi9IVUFHaERu?=
 =?gb2312?B?WHplWjFBSUF2T0FpWVlMSE8wQ2NCZkIwY2lsWFpvbWNDQlRJamdqK3ZQUEpo?=
 =?gb2312?B?QTUxMnBEK3ZINEVuMEVBdnR3dzFleW41NmFlQjVwZnloakZSYzA3K3lXdGV3?=
 =?gb2312?B?dG1naGJXbzF0dll2dFlpWmFuMjRrVTVTWGZrdmZBcVJCQTdvMkwxVTZrdlJw?=
 =?gb2312?B?NXNMV202cWRLQmVRNlYrVXZrSGYrWUJHZVhGUnBYc2hLRDBmVXd4aVZTa0l1?=
 =?gb2312?B?cit6eGo0WWoyRFlMaFNrUjBZOGZCRDlTS0tTOWlrbnc1OUtEdVQ0aUg2b2ph?=
 =?gb2312?B?TmhSVjRqSytFSTFCQnNVK2VDdUgzaVMzMXRqVDZyZVl1QVpIanpNVmxaRWRj?=
 =?gb2312?B?VE4xUlUvTnBXRyswd3dRaWNaQjVkWktPUTQwdGZGbDhtblE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q3ZzUU1kZXdYUUk4REF3N25BQXh4S1Vabkx1amFrSTJLSmFwL0lreUpDN0Vx?=
 =?gb2312?B?M1JDZTJPRW5vcDRYSFB0ZjNsV2puSHVmOXRSSWxmd0x5WlduZG1pRjFNc2V5?=
 =?gb2312?B?elUxc3lqMXQ3OE5IZUZZeWhMV2VyOFNJR1pNR0p0bHVWNjgyNWN2SkFJTkJr?=
 =?gb2312?B?M3haZ1F1Q3hpQUhvanpDR3ZKazJKRGVFWkRsOTFFL0k5dEdJc21pVExXTHBU?=
 =?gb2312?B?WmJtNUJ0K0M4M2IrK1JUd3l1V0szajlTUXp4Y2Vralg4TEYxNUc2VFFzTHpU?=
 =?gb2312?B?ditPcmwvcElwMUhMZmNFbUYxendlTWhvY0crK3lvVXNsaUgzSlN6MVI5Wk9j?=
 =?gb2312?B?bytnc2Z6L0MrMWErL0VlWjBHOEZEZllFMEJIMWd5Q1doazNWNVhLQ2s1UHlU?=
 =?gb2312?B?ZWlHWWR4aWI5UmNQc3A2ZU9kNFFUT0NzMDBvQnhJS01WNmVzQ0RlZ0Jqd0Vp?=
 =?gb2312?B?Z3FjL0k2OG9ENWQ4ZU4rY09IV0s2ell1ejNOYUgxVFFQSlMwTUt0Wkl3Nlhv?=
 =?gb2312?B?WGt4MTdKbjVmWXd2djRHd2pNWmNPMGE2Zkh5OUhsT2JUTlg0M0pwTkphdGlB?=
 =?gb2312?B?R212ZlltcUM3MG9TejV3Z3F3OStQRk9TWFY3cmsyUWRCMWk0cGJKZVl4RSt1?=
 =?gb2312?B?QnBYeGQrSmVXd0lVTFVDRUI5bTNsQzhKcG1XaitZc3doNmJMTVN2YTYybER2?=
 =?gb2312?B?M3hWUFFqbnNEczNsa0VRRlRBdnNWOWhRRHZ5K1JENFZVQ0dOcEZWeC84SEsw?=
 =?gb2312?B?RGUxR0QrcFNsUFVNUTVRbEVKMlhBY090WmxSWVlTcWlERE5ueFVHVU5YME1p?=
 =?gb2312?B?REY3bEdLNXMrZzlaajc0TzdFeTN4SzdaeS9tUlU1OHJPTXc5c3M5ampaUVRG?=
 =?gb2312?B?S1hJOVJLY0EwTzB0c0t5T0JITjBVTE1vNGRlVGNHSzk0OXczNDY2dTg3MjFO?=
 =?gb2312?B?VFMxM2pGNDFWQ1ZrS1pPM3EwT3djYkpuUXpsNkpPaHNCdlRGQk9CY2RPREVQ?=
 =?gb2312?B?bTkzVUZGRlltVy9LOVpsMURoL2EzYlJhWXh5ZWdyV1pRMXNDNkFkZDF0L01x?=
 =?gb2312?B?ZXBBcUhrUGxXWnVTeGlMZGF0bVNqTVkvMGJNTjdrMjlueEljSDAxaE9yR3d5?=
 =?gb2312?B?YnZRaUE3WmZwemU1cnJSWWJzVjNBR1BBNEd4ZUd2K0FJYmtmbkJXWjN3VkdT?=
 =?gb2312?B?SDdLMmlzUC9Mb3FoMHd2Umo1U2V4Sk9SalhwTmFUamhqcE5FeUtUdEtFRmpK?=
 =?gb2312?B?M0tkMlRpSEdCOGRpdG1pWjhFK3hBNEVhMnpmcFk4eW56Q1dXek9FWGZXK29B?=
 =?gb2312?B?L0hZZVI2aDlYMEhib1BpbDdraFpVWDRMazF0N05TWExXKzJyUTg3cEkycFRo?=
 =?gb2312?B?WUJmbXdFR01QeEJnOU4xUEY2R0NRT2plSGhrU0t1OEpwZUsvNDVVSnNqaEdl?=
 =?gb2312?B?NHBOVnNJYko0ZnVrc3Y5M1V6R1ZsdmREeHIzaE9rbTBuNjdwTFN5enBNYWJN?=
 =?gb2312?B?NThMcG9wWVpaVVdWUFFFQ1l2OTJOY0drRUVYY0VoZ05TNzFQaGlLRUxHZHQ3?=
 =?gb2312?B?dDJkSU8veUNvOWhSQ3AzcVlNUUxsaEFUbVJOSElxeWVhNXRQL1c4eURBNFJI?=
 =?gb2312?B?ZkZTTmxUbGVkL2EvN3l0UDdOeDVlcjFGYXJsaVpmTXdPaHJNTHEya1J0cGtQ?=
 =?gb2312?B?OEg1ZDVBSlM5RU1XUnFsNXFwREMwMm5sS3o0UmlvbTk4NnVnWmV1dmpJdjBk?=
 =?gb2312?B?aDhQaUh2MjZ4Yy9LRXlHZVhvMVBBNXV0Z09nQjhZOG12RUFNSHh4RTFQOW9v?=
 =?gb2312?B?NmVYdkdQaTlBK3NZVTQ0Z29MaGRDQ2llQ2p6bnVOaTRnUXFCTy9zSndJNjNW?=
 =?gb2312?B?OG1ValFXbmdrTHB6N1YxRjlOakIrSUVpTzEzc1BGc3A4ZnR5cUtxdE5pT1lj?=
 =?gb2312?B?QnZ6eGpIb1RBMTNETnVQVEVNcXU1WmE5bUE2cmNBdHNwTWxmV1k2REhvbEkr?=
 =?gb2312?B?WmR2S01reGdreXhEVkVtdEFmR0hBRk8xNkdXU29SVjhBY3NBWmQ0NlYzMGF5?=
 =?gb2312?B?T3JDalluRU5ZMDJuem4vcmUyQ3hrVlpWT2ZmZktHODMvV2RlaEJ2Z3pUYzVM?=
 =?gb2312?Q?/pow=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa2fcf5-b1b7-463f-532a-08dce12aa1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 08:33:59.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/pzN6XWjjiUMObPdwzmCETOQKim+TsNI9wUVkQ2ws/7qGx+DFO9279uj5gsR5r0pn701LygWURrtRuvS4CqBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5446

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCiANCj4+IEZyb206IExpYW5xaW4gSHUgPGh1
bGlhbnFpbkB2aXZvLmNvbT4NCj4+IA0KPj4gQXVkaW8gY29udHJvbCByZXF1ZXN0cyB0aGF0IHNl
dHMgc2FtcGxpbmcgZnJlcXVlbmN5IHNvbWV0aW1lcyBmYWlsIG9uIA0KPj4gdGhpcyBjYXJkLiBB
ZGRpbmcgZGVsYXkgYmV0d2VlbiBjb250cm9sIG1lc3NhZ2VzIGVsaW1pbmF0ZXMgdGhhdCBwcm9i
bGVtLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBMaWFucWluIEh1IDxodWxpYW5xaW5Adml2by5j
b20+DQoNCj5BcHBsaWVkIG5vdy4gIFRoYW5rcy4NCiBPSy4NCg0KVGhhbmtzDQo=

