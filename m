Return-Path: <linux-kernel+bounces-358656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2599820A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BB01C20865
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4788D196450;
	Thu, 10 Oct 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JX0M+Ihs"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2066.outbound.protection.outlook.com [40.107.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720517C22F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552233; cv=fail; b=TX2CYRtZpP/ni+raOIRnRAvye/A6iR7m6QIbrT3q0s0SgVIF06/XC9ba6AFsjGccdc/sYwG7ZZYPku1JTtXJZ29uAOtD+mvILzekA4he2+4c2Bp/rBGlUceMzO4YwtbPFOqxTFLuCOHvS257J2ANJa77N0vtSZN6LSusMvIbvy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552233; c=relaxed/simple;
	bh=fgj7rcDdvWP20Q0pnol4ZZ40PeACInFzqrS3FrinNrg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fsKDh9c5rFRlVb5n+F0c/8GjWl4blvD27z5nGKuD3jxGCVc//aWe7NdgE+45CX4895CQQz0FIIERlnoBRHBKcyDMVcrkcdxFHM9u5s3drbKPZN7jMj388VmAQCD4venkaaSDmBJoAUgSQZwNlGwXTxfJxEsY69ibYxxsE7Jn958=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JX0M+Ihs; arc=fail smtp.client-ip=40.107.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOZIJGmYiQTXm+9v1P4oyuZRb8pgseY6A8NQLJH32tttgYz9EaSzOQbiOpbLjebG+BKMphqYnE2CQcru5lY5DkDFXYNlEE8muqwDvYw5Q62+uenYXWQgwzvNlAuPdS2ziOIJvwIwomV9Idkvp/ZoSd7owwgxqsDOzOzhRrArDhI95MN3G6NGXtkb51GT70sRe7ThyuwVbOyD8neUBQIz9qW0NQ1SrefBQxrUVP2UQxL6IrG812jsOTJtOA+5geqbRGHk/i1z+PgpQxR4HU7D0bOI80IzePmo4LzX1mNXMg/tMUaHms2/o4I88bTgL9A8Fwutd+gRB2KQuQrBDrZg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgj7rcDdvWP20Q0pnol4ZZ40PeACInFzqrS3FrinNrg=;
 b=OC8dQiu8crAQyIIxCZ/0fDRNbfkZwWc5tUQ0NgfGdRTm7iw6ao6IXGFewiT1HvAGxBfS6IiPe4KysphyJ+MUSCTZpOoKM2A0pKBHN7P642kggQYBEpYCq96qCHA29JUMd0Q9v2I53+7qdWUO74KPM8C12iKdJhk2Es+TbMPPtXk7WFwdOzq6e07zV3jEwAaIZAhyIFvsJBVToqQ8AMGHsFGbulzQRb+O8W0qPIgC+v0JIt3N37MCsw0/y6l+Gexfhr/Zyc0tPl32hUpzFEPbrkJEpZBOYBOTntR+lajp6qxjeDTFGLq4BRBWZNBasgc60abiqRzVuHOHtgXcLqUC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgj7rcDdvWP20Q0pnol4ZZ40PeACInFzqrS3FrinNrg=;
 b=JX0M+IhsyU/RIfR5U2Rf84EClHvtE1vzNKd+BvpliUXHwZv38xrg2Uq54xMpZsDv+6C7Vq9ssIcNKAt5SzsPY1YBmOBC9HGff1O8+ShFgFSRI0rZAkGg75hTrRRqu3J2KwLFcZVcdf7GDpcZxhDWuMn3ncs1FZdCvnCR/ewS7kVyeKK5XlWJPS1fA+IywJvDMhRbFmyZ+Q7lS1IS4jTtLaZ51J/VKbkTZHQEqgO27hQbNmC9jkuCElOpmkoY7n0P+Ot/X4flf6e+v7rGYkPmSz6Jza5VQyDjVJwbIX8NvB8R4zw4BFRlkGvXaIEvv1u3LnpkaerqdH04AswMKeNHBg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5413.apcprd06.prod.outlook.com (2603:1096:101:64::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6; Thu, 10 Oct
 2024 09:23:47 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 09:23:46 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "jikos@kernel.org" <jikos@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
Subject: [PATCH] apm-emulation: Make use of the helper macro kthread_run()
Thread-Topic: [PATCH] apm-emulation: Make use of the helper macro
 kthread_run()
Thread-Index: Adsa9OiGcd3RTP2YQQm2CQR+YLTpTw==
Date: Thu, 10 Oct 2024 09:23:46 +0000
Message-ID:
 <TYUPR06MB62170C727B3C58B906A9ED11D2782@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5413:EE_
x-ms-office365-filtering-correlation-id: d533c755-fb56-4604-f515-08dce90d3e50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZTY3MUI1bXlqRmRGbm4zWmlUT1ZWbDdRcTlxUlFZdlNDb1FaQ1lLTlFpYlJC?=
 =?gb2312?B?ZFlWSnpVSHp3YVVwSWZaaWZFNUJHSVVmbitVa0ZRbUZRSEtzSENMUDUzTjQ3?=
 =?gb2312?B?dEJiSXFkUFZnWnZSenNmNUZrN3FzdHFDbGRQSVVoNW1aQ1V2QWJ1Y1c2eXBE?=
 =?gb2312?B?RHBrWXdmWHpFTUNJcDR3ZXNYQ2lkVUw2TTVPcGMxMGM1VWN4em9UNm5FMXAx?=
 =?gb2312?B?bkxpbE9rN3RxZStMdXpwdGdpNWJIRjJ4WjR4YkZWZkcwOUc1ZDVOQnplQjhq?=
 =?gb2312?B?UUdOeHR1eG9qWkMyRitRRXJCeW91VGNwY1BXb2EweTEzWDNIMFhoZ08rclRK?=
 =?gb2312?B?SnBjeW9ua3lKbkhzcnNKR1BnbStVdVZ2Zkp5Mi9TemtNOGxxRWw1QUpoVnlz?=
 =?gb2312?B?blRaTEIrakpZbUVmcmsvWlpvdlgyV05kbUJDUXEwZWo4Z3YzMVpKZ3pHRGtz?=
 =?gb2312?B?SVRhSC9MVWFUejhzQy8zQW11cVk4YVNxbHFVUDNESWkvN0tOcy91V1ZuYnhL?=
 =?gb2312?B?VlNpcG41NW9WUnZia1ZFZll4VUtNWU4vR3lFOHhzMHNkNE1LWXlwYTYrdjlP?=
 =?gb2312?B?ZW5PY1E5ZUZ6anhGQnZqajdSbCsrN0drODZCTTlQdThJYXlLOG8wcTlaTEhC?=
 =?gb2312?B?VFFPV0FBanIvdmNaakg0SndBaUM1WHpmR0RmTDAwTVRRQWZmOGJkMmJpS3p0?=
 =?gb2312?B?ejRRZEtRcDhHRExIaDY3VEZCcVBKVE9CcjU2U2pFYjFhWVFJNUd0RHpKbDRI?=
 =?gb2312?B?ekdOZ2Ztcmw2ZVl1WjRYTTR2dFpwcmJQSmNGV0EwbWpJTnhJUVY1a3VwTUJ3?=
 =?gb2312?B?M2ErZnU3Nzl4aXk0U1p1ZlVSUUZ1R0VVZ1o0NlVtbmNzUGl3MmthUSt5em9a?=
 =?gb2312?B?K2hRV0JCc1Q4czgrbjduMUxycFFuZ1JyWnkzQWNIV3I2dHZzdm53ck95NitT?=
 =?gb2312?B?aFk4WFI1Mkx0bm5UUS8zWUthUlo1T0NUMkFLMU4zN1J1Wm9sMisxOVZnaGR2?=
 =?gb2312?B?Ni91OFBTajRPQlR5TE5UR0NtNzJFWCtPdkpUOFB2bmpiNERsREtPRWNHaHNh?=
 =?gb2312?B?Y3BTYllSb3BXNldsV2UyajdBSS9yVXQ4UW1mZThkb21lL1pUUkVqd1dxemlz?=
 =?gb2312?B?dnFTaVRaNERZUHBWOVhDaUpmcllWaXcvT1FHRkJ2dlVpVit5RlFYT0NpalRR?=
 =?gb2312?B?K09IYUJJWmhQcmpmK0I5YlFSQ2syRmYyUnpXbFR5ajFkNTdGRzdXTW5Xa1hq?=
 =?gb2312?B?SEVINERqTUtvR3ZmTERuQitjNmJ0ejRyWFF0L0Ixb0FmTS9QNENKVThaK3R2?=
 =?gb2312?B?M3I1Y1V2U09PaGl1WG1ybnRZOSt5SnVqazdiSVNRdFZTbE00VVYrbFRiWGtE?=
 =?gb2312?B?NkFETjVqalNTTFYxdGhMZm5naHZDaVdHSk9QcXN5NjVHY0tVUXlnTUtQQStQ?=
 =?gb2312?B?OENGZU9QL2ljS0pIbXFvY3ZtYWRCQ3F5WUNDOTdBZ3E5Q3QvaTFLTFlmK2xJ?=
 =?gb2312?B?VURTK0lIanBVeSswcFBuSWxKZzQ5L2l1cHRFNVl6cUdlSVY3RFdoaU9jd1dK?=
 =?gb2312?B?Z3FCTzE3YlRBMGtMaVBrcE5rUGJUU0VMT3ZKQ1MxTms2azJYUEkrbXhRQ3ZY?=
 =?gb2312?B?NURTaUIxcDFNdk1OVGFabHV3Z1JOYnc2V0JpV0VGWmlRc1pranN0UUdON3dS?=
 =?gb2312?B?VEU2K0wyZGVOcWNMS0J0Tk0yZnBnODN3UmpsdzgzeWthTEtYRnhERXlHZWNE?=
 =?gb2312?B?b0FBK29TdGNFUS9QMUxkWG5qSGNSS1YvdjU4cmxBRnMrbDJ0bFBucUdoc1Y3?=
 =?gb2312?B?QlMrbW5iU0czeHZneFFCQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?QSsxWWJxSkwrTEhmbWloY2ZvWFVKSTdMUzh4ZWFhU0EyZS9haS9iaTZ3WEJC?=
 =?gb2312?B?ZC9FVUR2TFZPV1VVNmRoOC8vc1V4Q3dTZmt5TG4rd1Exd2ZWeWM0bVA4Wkxv?=
 =?gb2312?B?TFgxUFNzOG5wTytyZVQ0Qjhud3VTZmJKRGZmWStrWGhvMVNsYko1NE1EdHJ6?=
 =?gb2312?B?bXoxT1lXSHVRTVpEeWU1N09TZThLc3hFZTdCeXl5bVZtaVBGemtDVFY0RXBr?=
 =?gb2312?B?SFNsaGZtWUlFTUw5R0h3TlpxTUdVN1FKZ1dBbFhHSG9WT0p4N3pWNDBYbmo5?=
 =?gb2312?B?OEoxM0lZNHpsN251MUNBMisvNzJKcXJpbUZ6UGVjc045bmFsMURCdU1mOE01?=
 =?gb2312?B?R2lrZ3ZUVlZDUVZQc2FSZFNsTmdNMlB4eFFZSk1aZjY4TGc5cm9hL0wyYWJB?=
 =?gb2312?B?akpoQXYrQXplVkhzN1ZQUkhmcllGQkMyKzhQWkVwMTUzOHpoNTVkaXZWN1d6?=
 =?gb2312?B?MkdScHlueG5VeThrTTJ2dEoxaXR3QStsRmlPZW1JajFvZERpQUxreWY1WENu?=
 =?gb2312?B?UEs1bVNPb3R0b3g2OThERTVPWCt0SEpXcHFTdFVBK2gvOFR4RVVpMFlvVHZj?=
 =?gb2312?B?WlpIZ0FvM1JWNmNrWTBKdVpTU2JjUkZDM1k2ditzeG1IcUxWUzBKYnlOcTlK?=
 =?gb2312?B?b1YxcFV3SVYvWlNOdTZqdGpQMDhuTUZldC9yb3RMd2xsejBLd2RKMzZsUVFp?=
 =?gb2312?B?YTViaWVPanNNZEFueHdXeFdxRVdmbXBKamw3L1dTcHpIZklWazBva1htSncy?=
 =?gb2312?B?ZDV3a2MvdFZrcXJRYmF2V0w0Y210WlIyajF1eGsrSmlvNUJuQThjU0ZIUnBB?=
 =?gb2312?B?UnVwd1FPdDlYYlNoQm9kaGdKTFh5dXJUOGVIUm43WE5GNlpoY1dkbHYxajVv?=
 =?gb2312?B?TDNLRFp0NVF3M0tUK0RZQXRCR2dXUHU5M0t6SjVZQW9sVGVJWElFenB1aUpu?=
 =?gb2312?B?Q2k0UkVLT2d1T3dFMGFaQ0RGcnFHMFR5M3djWlZETlFMbGJJOHFtZEJBQXNW?=
 =?gb2312?B?NlQ2R1NuWlNiWjhML3FodGdIWHEzRmloVEFRcUgvSTlpUW5SY2xTNDUzTldL?=
 =?gb2312?B?ZkhoaHltdHJxbHR4ZTcrenVkSVQxVElJeWNxVk9kS2RqNW14WGpNZnl1TlRL?=
 =?gb2312?B?S1dTa1c2TW95L2l1WHFJTkRxNlIyNDNPNy9OekRrRWNuZitpR1BBUXRKS2g1?=
 =?gb2312?B?aWphakVKUy9JbE0reTRpUkllcFJkczhVSGEvR2w1aUluNVNUSW51cjRsYzBs?=
 =?gb2312?B?REFSMVk4bFkvcndGOGo4ZVphZmh6QWU2Mk4yQ1RwZkVVSUhzNGdlYTdSL0ln?=
 =?gb2312?B?c0ZmL2J5SVIwU1E0Nm42alJaazRYa0R5TzNTSlZBVFQzYkRKcHNWbjg2YkRQ?=
 =?gb2312?B?R2tVK1FvQit4U2d3NGp5eEV6WDcyL0N6Ni90bUcwMllUYW1US2lOdStNRlBD?=
 =?gb2312?B?TUZUUWFlMjZPZFhCYnpVQ0dUQkZ3L0RpMldsNGF2ZDRVTnF0RU4yeU5XelFt?=
 =?gb2312?B?MEU2K0RpRTA1Y2ptbU5nKytBVWdiTGkxTC9QV2daKzVvSGdMUytTSGFqNk1P?=
 =?gb2312?B?Syttamx3YmRndmhOK2YvdVRRN3lVNExVamo2YkJhc3RMeDBJNWN0blIzby9k?=
 =?gb2312?B?UGFhcFpCdlB3YmFNb3ZYNy9VZnlYc1BOUitMUkxGOE4xTnVEY29STGtvdmJ4?=
 =?gb2312?B?VVJpaUltY2ZxMlFpMkFVL2R5WGtGRFUzMGcrd09vLy9pdlVsZnBhcWZRakln?=
 =?gb2312?B?bWlaL2IyL29RclhxQ2Nnd1BkWlo0TXA0bGd4cVZaTjlHV2dnZ3g2TkpJZXY2?=
 =?gb2312?B?R1kyWW9Uc1dEWTNjNm44Ly84NnJRdnJwdkRoSTJTRVNpTTg4aHNPenVGTkRr?=
 =?gb2312?B?UDVYS3haQ3prSW1RR1V1OUdubmJVV25GMTVQMHEwU3NtRW9aU3dEalZEQVdp?=
 =?gb2312?B?aDVwbmpPSE5SSmRhQnovdUlvVnVMSFZwSFdqNUNNdmxDUUZDUWVYSDJWMlpX?=
 =?gb2312?B?bkpGM2VjUFhyRXQ2RXBvTzc2bXhUWk9PMm43QlU4em5ZTEY2QzU1YWJ1Qnk0?=
 =?gb2312?B?N0ZPVHRTRUFnWWRySkMzaUhNYnJCQk9qbkw2TGwxeW5GTzh6MUI0cmN3Yzhv?=
 =?gb2312?Q?gtjc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d533c755-fb56-4604-f515-08dce90d3e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 09:23:46.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLhN/F1H1FtY3L93laQRSzd5rE8aodXvGXuo0BmsDMCdLkCBRpiv3TB5FUTpWIELjklBI9nT/lHbVaYCP7eXcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5413

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpSZXBhbGNlIGt0aHJlYWRf
Y3JlYXRlL3dha2VfdXBfcHJvY2VzcygpIHdpdGgga3RocmVhZF9ydW4oKQ0KdG8gc2ltcGxpZnkg
dGhlIGNvZGUuDQoNClNpZ25lZC1vZmYtYnk6IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvY2hhci9hcG0tZW11bGF0aW9uLmMgfCAzICstLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2hhci9hcG0tZW11bGF0aW9uLmMgYi9kcml2ZXJzL2NoYXIvYXBtLWVtdWxhdGlvbi5j
DQppbmRleCBlNzk1MzkwYjA3MGYuLjNjMTgzMzcwYTVkNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Y2hhci9hcG0tZW11bGF0aW9uLmMNCisrKyBiL2RyaXZlcnMvY2hhci9hcG0tZW11bGF0aW9uLmMN
CkBAIC02MzYsMTMgKzYzNiwxMiBAQCBzdGF0aWMgaW50IF9faW5pdCBhcG1faW5pdCh2b2lkKQ0K
IAkJcmV0dXJuIC1FTk9ERVY7DQogCX0NCiANCi0Ja2FwbWRfdHNrID0ga3RocmVhZF9jcmVhdGUo
a2FwbWQsIE5VTEwsICJrYXBtZCIpOw0KKwlrYXBtZF90c2sgPSBrdGhyZWFkX3J1bihrYXBtZCwg
TlVMTCwgImthcG1kIik7DQogCWlmIChJU19FUlIoa2FwbWRfdHNrKSkgew0KIAkJcmV0ID0gUFRS
X0VSUihrYXBtZF90c2spOw0KIAkJa2FwbWRfdHNrID0gTlVMTDsNCiAJCWdvdG8gb3V0Ow0KIAl9
DQotCXdha2VfdXBfcHJvY2VzcyhrYXBtZF90c2spOw0KIA0KICNpZmRlZiBDT05GSUdfUFJPQ19G
Uw0KIAlwcm9jX2NyZWF0ZV9zaW5nbGUoImFwbSIsIDAsIE5VTEwsIHByb2NfYXBtX3Nob3cpOw0K
LS0gDQoyLjM5LjANCg0K

