Return-Path: <linux-kernel+bounces-306787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6006F964393
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03061F231E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D6192B83;
	Thu, 29 Aug 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="O1tY+8vo"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2045.outbound.protection.outlook.com [40.107.215.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384618C03D;
	Thu, 29 Aug 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932488; cv=fail; b=QJKSG3PdpdQcZfvCZUENUBkhdd4LVWiZzUoftewRQstNWtm3eE6E3jWrGaSvB3uzg1aPnucA3GCXvySnji3xB6jXyCnRf33BkZqL3STh+tCu3iHqlghCJ/fPEKlNevpPoxgw1nuM8br2uLvDxWznN2ajNEdrCRHQs65Bfq8ors8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932488; c=relaxed/simple;
	bh=Zh3xIclALRntGm1nUo4hZVd+mBsiDcdf7kcLW0PFDYc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WgKAf6Sj1MRbFetTyRHZ/Byow3Eui0HUQkTRoeGnoRIlhZaUwbhxnsaCzlgxGbqQrnY9BlpuNW6rZxAfvpnpOozimshuQK71fhwKXgIrTqlkX9pXaEkIl1wvhKlt4fKVkltkEKpI9tge+1HJRhg1q0WWmqgnsC5tbGC3oescz8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=O1tY+8vo; arc=fail smtp.client-ip=40.107.215.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvpZMfbHt0Sfq8JlGojy+pow9g6MDQJz8j5YKFq+QuD1kFxYNqrsuPJPB+pY2RQOKHF1IiA43UOeuUVOuogUREcb/92A5Qw7E23n1t73Z71RB30S3jWHAqsyJ+lVY1t54bFEO+H5apKk/lw9d519u2pKu7wKev/OSl7Ci298Hp4qibspTqwWvq1AjVvfXrLXTG7fD6bnsgvTvhofdhKZKofmeA1v3tLQfgeRnH9PCuA0lEoZp71UngDYgwb3pFUTjBaabHeUS6h4weJzYV4ZJuuRis87iln8j1B4xq6OZdglP5kEOMd+QSMwHd+IhY1z4oBxn5GKiWLbXpWz6B9tWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zh3xIclALRntGm1nUo4hZVd+mBsiDcdf7kcLW0PFDYc=;
 b=l1oDvtYoNWNREA8yrlfSgOCtIAakmNoicyJLSObOnM88M3455OWDmYM1rxUsBlq0o6VmkJ7ZfABRdz9NEX7CuHBPk/M+x/iVpcRB09hg2yf+2Uj/Y9lEnnS1fFkt8iaPS17GTBgGxgwZt6473JzDb8GPoFAPZlUGYm+NJRec9Icl4RvVbQGls7xc2LclH4yBfNm9ybz6lG7YP38hU4tixav4lYmGhMVo4Zan/V/HAPhuMeN56ET6sOZVXUSC65LYJBz/lXUviR4ZJ6ZKQKFzs/8S/4svW7WEKC+YCVKgDMBa1tXXuEqMy8h+NGvW4/K8nG/VK1BQPGwpLh1mW2enCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh3xIclALRntGm1nUo4hZVd+mBsiDcdf7kcLW0PFDYc=;
 b=O1tY+8vomnrRFWvCZAJVskCtWQ/pKFgw8hqBkJS0iao9kCfj1/bhfuqQjRDEoHm6i7R7QAtslECSwNeWuQlRRpG/NI0JVv0EIyhy+Cz3vgznf2AXNB23nfLm9G6lCph7BmUhwVxdyWJVJ6tgTvox6FyLnI2H97ctoxR7D5GoZiNPSl2UI1+lwNbTXvOUm3zLMrABIvF4BWq52BwSPL/Am2ZG/oMLMGj/ydmIHYqHjdy20uTnYKzfd+D2oarh/8vmozknWy/hew3PJucJTt6nwymFHgWP5jorrOwIdK4RQglIayk4m6j9C9aka7D1bxZ1K+z/BeuqkjNtuH5BmpQv5w==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by PUZPR06MB6005.apcprd06.prod.outlook.com (2603:1096:301:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 11:54:40 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 11:54:40 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Prashanth K
	<quic_prashk@quicinc.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Subject: [PATCH v9] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Topic: [PATCH v9] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: Adr6Cd+UUO/sbS6xR4e70mPa/mlHZg==
Date: Thu, 29 Aug 2024 11:54:39 +0000
Message-ID:
 <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|PUZPR06MB6005:EE_
x-ms-office365-filtering-correlation-id: 21d03c0a-cc85-4fef-8720-08dcc8215d08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFFTVDhuSFpsUHVVVEFybTRVblRHWFBsc3REYkk3R0ZyZTRoYlZHUFFKMzBr?=
 =?utf-8?B?VWxzM0FROWJXejdaalZlMkJHbHYyQzFaR0N1MndTR3ZwdDVvT1daeWtoYjc5?=
 =?utf-8?B?dG5jblBtSGZjUWhMSFpsVnp1anBUMEZlRGQxdCs5SklQa3JJd3RJSWxuRnJV?=
 =?utf-8?B?Q0tKWTJuZEtBSE56cWFnQWhHNWtlSXRsTENucmFhRGtRM0dEMldNMEJqc2ZR?=
 =?utf-8?B?QlVoM1JwZnlMSGJZQklwL1UyOHJJeDQ2Z2JYa01TWUM5cm40NzlFTTk3NHBz?=
 =?utf-8?B?M2d5VkxKUldGdzhTSmZJR3JVQUVBWGo5MXBtbTBnQ2RBQVgzcjVHSUlSQXNW?=
 =?utf-8?B?WVdCZzlCUnpEMlg0eFR0aFJ4SkhUdVhMRi9mSEwwc2dXZ2lGdG8zQVhocVgz?=
 =?utf-8?B?Y0NkTXJPKzZlWFdvMnRHaGF2d0taSkc2YzMwdHN4U3QrTFpPRUlXbWJNaytk?=
 =?utf-8?B?R0w0RUdkOUhwQmpmSjdiR0p3QUZaM3kyTk9LTGJ3ZHRMRHlpbGVITS9RSFVj?=
 =?utf-8?B?eGMwMUMrS1ZNQzk1RXdDQm5XNDlnV0MydHVUYVdaK29QKy8xSklnTStjK3dk?=
 =?utf-8?B?V0t2SWJqMXN6MTlJUWZ4NE0vNGRTY0IxbFhtZ3o1Ky9mR1ZwOHRKc2tQL1pO?=
 =?utf-8?B?dnU4cTlxV3g2Q2swSkgvWTZMQ0ZRSnJjRnVIaWZQRnFHRk1EOHFZTlA1VWtN?=
 =?utf-8?B?MGVZdlRtNHlWa1o2TFZScGo3RHZzamtVQXBDdHh5NlllV0FBcjhtVjNpR0J1?=
 =?utf-8?B?UEhiSDJIeUE5bW5nd21tMWZpYUl6NFRWbnBzRHd4aXJFdjlGNFdjaDZ5dlZj?=
 =?utf-8?B?bnE5bkMrbnJGTVAwMjhyL3ZQeWNxNU5kNnJwZlNiTzBONmg5bU5zdHdFOVpx?=
 =?utf-8?B?emNwVTJKRERIemRnOFliS2ZVbkJVbGltdHM1ZFpJSkJJOE0wNXNHSUxlbXNO?=
 =?utf-8?B?NVlMNXlwbnlmaEFkMXJJejZwV3hUWjZxWEcwV0d5RDF6cWNHZUtMNjIwdm9T?=
 =?utf-8?B?V0xSVW5WUUZnb0J2aUJFdTVEN1kwVEJiT1lQNHJpR0RWU24vZ1FuYjJYRVdZ?=
 =?utf-8?B?Z25XU2NVc3F3QnAvbnJDOFpjYy9HYW1pZHpCUE9VcWpnQjM3RkRJdTlDVHJC?=
 =?utf-8?B?YlhOUUVobDBDRGZBVk1PbTlHUEczMUJmTERqa0hWRzVFbVFXWndIMWlldnl6?=
 =?utf-8?B?V3RibFBSYjh0QkdwY01WYmh1Ukk0V0tWSXlwWWg2VTNLcjhKbmR1UlZuNTN3?=
 =?utf-8?B?cGFFYjhON0crMVZKMklPM2FMbnd6YkQvbjk4MG95NXhkQlRIb090R2V2c0tY?=
 =?utf-8?B?ck5aM21OV3Q4VXNWRVFHbFFjR1JQUy9STHhpSW1IZy93YUlVOFJXckhPMkR0?=
 =?utf-8?B?dFRSbU1iUmFEQzJzTEU5Y01JRGZ5Mzg0bFQvcW9TVkRrOVQwL2p6ZlNkbVFr?=
 =?utf-8?B?ZWJhSlNSWE4vV0tlYnJyaC9DZEhtSmU5QjJXdTVYcGt3T1d4NlFtK3ZQSU1F?=
 =?utf-8?B?US91dEYzZXBpMWFCenl2dXZUWVhNSW1HSXhsZTVCcGVDMDVhbWNiaVNpczRD?=
 =?utf-8?B?NWlVVVdUVkRHaVVMeVhlUlhoQS9JZXdxVUdiVGJBQ1Blc1Y2UXpLdkc2Ukhl?=
 =?utf-8?B?K1dpSXE2R0hKN0tOMC84NUZRcFJTWGN4bHRyamtseTlOQ1NjejdHZk5ONzkx?=
 =?utf-8?B?aDBsQ1J6WWppSFRteUhTNThnZXFBaElSL1d6NHFmR2hXeXUxcStINmpMWTdE?=
 =?utf-8?B?RjdvTWI3UEVVZEM1bFl3R3ZRMEtwako3SE5zMTFqNnh0WTJPNXlkb3hBMjEw?=
 =?utf-8?B?MHh2ZWtYUW14TGNKYnhTaHgvaHNuRW5Hc0xpUWtzSGoxVU96SThkNGhESjFt?=
 =?utf-8?B?QUlJeE90ZWpLczZYdXFNZi9vWWtUc3JIMHprOHgvYTdMY2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RG5BbXJ5cjh1Mi9lUkFxNXNXc2ZaNzRzcDl5WjQ1a001aVJWd1lSMmVnTWR3?=
 =?utf-8?B?MUZoclFsRFlYVStRb1VmOXZsT1BONWo2WmhGb3pndW0xaDllcXBWSDc4Ukth?=
 =?utf-8?B?eitMMVlRS1A0bkJJWm50UHMrUE04WlBDa09yRlI0STJUVEVQVVFOam5IeWpl?=
 =?utf-8?B?WENtVktaOUU5Vjg0SEY1Z0NmeDZ6WkxJaTl5L2lUWmhWakgvR3dQYk9xN25o?=
 =?utf-8?B?amxrWnI0d25zVWxvbTZTb1JaQzU4eHQyNEM0NU9nMHN6ZE15MnA3RTVSbldY?=
 =?utf-8?B?RTA5NDFDRVg3R2xWdU54QWkvSWUzeVNUWnhPMng2bUxOa1ZOTnZSbTI1MTgy?=
 =?utf-8?B?SUJ6TzVveERWOGg3YkcycGlZTmhGMExIUUQvY3AyWmtOT2JOc3FYdW05eWVn?=
 =?utf-8?B?VFJMZ3NXMGhOU1piUU42cytIWXRRRzBuc3JNV1UzVzRlWmxLaE5CKzl5TkJh?=
 =?utf-8?B?S2RMdHNVWWhvdkZvTU1HTHlyY25aSFovWUFpVXliN1B5cEN4NTVTTTNTM0tY?=
 =?utf-8?B?OWYzclJiS3NSTEpLT0RTdUQ3T0duZzdGTkNYTExzTlFKRjRmWDhycHp0eUpW?=
 =?utf-8?B?SlQwL01NcUVZS0hRelVFS3ZxMi84NllXSlJHdmtoZTFLUzA3TnlYZ2dlbVZx?=
 =?utf-8?B?TVpXNWVtZUVJU1FiOVdMK3kxZ05TcXljNXc0VnA1ZEZpQWNQdU9PR3R3OW5J?=
 =?utf-8?B?K3JLWHloUWtLVTgyRWFXZFZTM20vbmxSK05GMktmT2JnTXlGMW5RTzIvb1Ir?=
 =?utf-8?B?a0lGN3FZRGxiek9tQkt4QWZDZTlsTm8rSHpjYWVleURBMHlsZFlpOVhBU2gz?=
 =?utf-8?B?VmhsV0RXQTd1cUxQRDRYNmdWTGRRSllOOUp5dC9Idm1EZWloeHdzU292QWJI?=
 =?utf-8?B?N2Q5b0FHeW1uL3hhM2NWRE14TWU0enhsaFlTM2VPTDIzaTllVW1pSnVBQzF3?=
 =?utf-8?B?TS9PaGZEOFIxYU9ldUNmM1dObWZKakhYdjBDczBLcTE0WXg5WDF2anNpNFRR?=
 =?utf-8?B?Mnp0M0IxNUlqWHJMRGJCMndYNkpyVkVUOTQ2cVZlUzd0cHlDakg5bFh6VTdl?=
 =?utf-8?B?SkUxeVdvODVYazVqRjJseE81aW9yYzVkTW11RWlUNVBZTjZEc1ZzaC83SVYx?=
 =?utf-8?B?MWR5cUh5K2JURFFpRUx6blN3dEE5b0JobHVzUVRHbldJVnd0V3Z4cThsc2hP?=
 =?utf-8?B?Umd2M1ZUcGdERi9VOHNqOGg2bndOMFRUYzliVjBVRXorNmdiL2V4SkphcElo?=
 =?utf-8?B?cnY2SVMwZkZNZXhxSHdvZ0Z4REEwKzZZem5pYmNnNmpRMmx3cVg4U2NNcitN?=
 =?utf-8?B?ZGNWdnh6RFgwUVBQekoySExHYVZveWRDQWM1TGROZlpwYUdEdVJjSWhMS2pi?=
 =?utf-8?B?MUtQc0ZSVVU3TWZaNjNlRWdVRDIveDR0aTlxck42UzR2TW9xdGRVazlhSDdq?=
 =?utf-8?B?WEdRcGo4VjdXakxIZ3JKaGpUdUpodVRtYXpzUTRoa20rV2ZlQlFHaXRDL3F3?=
 =?utf-8?B?b0ZKL3FaOVhqaWJVZ2dIWkdSZzlqak5IV2JKRFNBZWI5bzhHSDNYRGlXQ3J6?=
 =?utf-8?B?ZjZUSUh0VGE0R21VVzlrK1QrSVA3ZUt0UUhMN1BBY0tQVTlrSUpOTERUbzJU?=
 =?utf-8?B?RGp6WStKQzVTY3F0K3VYUEQ2anZGZHN6aTFFZnpHTzJ1ejJmSGJ1TjdVWU13?=
 =?utf-8?B?YzdvVTA5VFpCWmVnK1Rmd0hOV3NaMXg5OG5qL0M0WHBDdTNsaklHaTEraGVQ?=
 =?utf-8?B?TXRDUmRGd2FmQmhjenVqdWlnOE9RY0lSUmtJQ1EwVW9CTHlzbFhIY2xCZjd4?=
 =?utf-8?B?VVlKQ2t6VDBzY2tFekJScVBKY3lkV0p6UkVqVklwMnNQWitiRVdkVWJZbmV0?=
 =?utf-8?B?ZDBIQkhka091dEo2dk42VGVsaGI2WFBaTkpncU1qQm1VUU1DRGd6OWt0aEN4?=
 =?utf-8?B?T0puL2NGY0xIMnpCcjlVZTc1clhXYjVyVU1OZnhmcERqbUhmQmlvRXZuRjU1?=
 =?utf-8?B?YVdWS3V3OGdpTGlqR2VnUEY1QmZoU01CSjVrNmdIVVRSZUVISmtPazBvcnBL?=
 =?utf-8?B?bWdCb1dhak1Eb0RYY2NqR2M0Z3gvNVFMNzFqY2lzeGNIcDE1UmpOUUhqNjhB?=
 =?utf-8?Q?rbfU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d03c0a-cc85-4fef-8720-08dcc8215d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 11:54:39.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uaS6gVgqK1TiviraQ4ScBehys6JZtBdtxXRtLk9BpTiYAEH9+AAcVDaBTv4lDbjWgYfloJD6ZrYtQdUXeB3YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6005

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywgd2hlbiB0aGUgdW5iaW5kIG9wZXJhdGlvbg0KaXMgYmVp
bmcgZXhlY3V0ZWQsIGdzZXJpYWxfZGlzY29ubmVjdCBoYXMgYWxyZWFkeSBjbGVhcmVkIGdzZXIt
PmlvcG9ydCwNCnRyaWdnZXJpbmcgYSBnYWRnZXQgcmVjb25maWd1cmF0aW9uIGF0IHRoaXMgdGlt
ZSBhbmQgZ3NfcmVhZF9jb21wbGV0ZQ0KZ2V0cyBjYWxsZWQgYWZ0ZXJ3YXJkcywgd2hpY2ggcmVz
dWx0cyBpbiBhY2Nlc3NpbmcgbnVsbCBwb2ludGVyLA0KYWRkIGEgbnVsbCBwb2ludGVyIGNoZWNr
IHRvIHByZXZlbnQgdGhpcyBzaXR1YXRpb24uDQoNCkFkZGVkIGEgc3RhdGljIHNwaW5sb2NrIHRv
IHByZXZlbnQgZ3Nlci0+aW9wb3J0IGZyb20gYmVjb21pbmcNCm51bGwgYWZ0ZXIgdGhlIG5ld2x5
IGFkZGVkIGNoZWNrLg0KDQpVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVy
ZWZlcmVuY2UgYXQNCnZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMWE4DQpwYyA6IGdzX3Jl
YWRfY29tcGxldGUrMHg1OC8weDI0MA0KbHIgOiB1c2JfZ2FkZ2V0X2dpdmViYWNrX3JlcXVlc3Qr
MHg0MC8weDE2MA0Kc3AgOiBmZmZmZmZjMDBmMTUzOWMwDQp4Mjk6IGZmZmZmZmMwMGYxNTM5YzAg
eDI4OiBmZmZmZmY4MDAyYTMwMDAwIHgyNzogMDAwMDAwMDAwMDAwMDAwMA0KeDI2OiBmZmZmZmY4
MDAyYTMwMDAwIHgyNTogMDAwMDAwMDAwMDAwMDAwMCB4MjQ6IGZmZmZmZjgwMDJhMzAwMDANCngy
MzogZmZmZmZmODAwMmZmOWE3MCB4MjI6IGZmZmZmZjg5OGU3YTdiMDAgeDIxOiBmZmZmZmY4MDNj
OWFmOWQ4DQp4MjA6IGZmZmZmZjg5OGU3YTdiMDAgeDE5OiAwMDAwMDAwMDAwMDAwMWE4IHgxODog
ZmZmZmZmYzAwOTlmZDA5OA0KeDE3OiAwMDAwMDAwMDAwMDAxMDAwIHgxNjogMDAwMDAwMDA4MDAw
MDAwMCB4MTU6IDAwMDAwMDBhYzEyMDAwMDANCngxNDogMDAwMDAwMDAwMDAwMDAwMyB4MTM6IDAw
MDAwMDAwMDAwMGQ1ZTggeDEyOiAwMDAwMDAwMzU1YzMxNGFjDQp4MTE6IDAwMDAwMDAwMDAwMDAw
MTUgeDEwOiAwMDAwMDAwMDAwMDAwMDEyIHg5IDogMDAwMDAwMDAwMDAwMDAwOA0KeDggOiAwMDAw
MDAwMDAwMDAwMDAwIHg3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6IGZmZmZmZjg4N2NkMTIwMDAN
Cng1IDogMDAwMDAwMDAwMDAwMDAwMiB4NCA6IGZmZmZmZmMwMGY5YjA3ZjAgeDMgOiBmZmZmZmZj
MDBmMTUzOGQwDQp4MiA6IDAwMDAwMDAwMDAwMDAwMDEgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgw
IDogMDAwMDAwMDAwMDAwMDFhOA0KQ2FsbCB0cmFjZToNCmdzX3JlYWRfY29tcGxldGUrMHg1OC8w
eDI0MA0KdXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0KzB4NDAvMHgxNjANCmR3YzNfcmVtb3Zl
X3JlcXVlc3RzKzB4MTcwLzB4NDg0DQpkd2MzX2VwMF9vdXRfc3RhcnQrMHhiMC8weDFkNA0KX19k
d2MzX2dhZGdldF9zdGFydCsweDI1Yy8weDcyMA0Ka3JldHByb2JlX3RyYW1wb2xpbmUuY2ZpX2p0
KzB4MC8weDgNCmtyZXRwcm9iZV90cmFtcG9saW5lLmNmaV9qdCsweDAvMHg4DQp1ZGNfYmluZF90
b19kcml2ZXIrMHgxZDgvMHgzMDANCnVzYl9nYWRnZXRfcHJvYmVfZHJpdmVyKzB4YTgvMHgxZGMN
CmdhZGdldF9kZXZfZGVzY19VRENfc3RvcmUrMHgxM2MvMHgxODgNCmNvbmZpZ2ZzX3dyaXRlX2l0
ZXIrMHgxNjAvMHgxZjQNCnZmc193cml0ZSsweDJkMC8weDQwYw0Ka3N5c193cml0ZSsweDdjLzB4
ZjANCl9fYXJtNjRfc3lzX3dyaXRlKzB4MjAvMHgzMA0KaW52b2tlX3N5c2NhbGwrMHg2MC8weDE1
MA0KZWwwX3N2Y19jb21tb24rMHg4Yy8weGY4DQpkb19lbDBfc3ZjKzB4MjgvMHhhMA0KZWwwX3N2
YysweDI0LzB4ODQNCmVsMHRfNjRfc3luY19oYW5kbGVyKzB4ODgvMHhlYw0KZWwwdF82NF9zeW5j
KzB4MWI0LzB4MWI4DQpDb2RlOiBhYTFmMDNlMSBhYTEzMDNlMCA1MjgwMDAyMiAyYTAxMDNlOCAo
ODhlODdlNjIpDQotLS1bIGVuZCB0cmFjZSA5Mzg4NDczMjdhNzM5MTcyIF0tLS0NCktlcm5lbCBw
YW5pYyAtIG5vdCBzeW5jaW5nOiBPb3BzOiBGYXRhbCBleGNlcHRpb24NCg0KRml4ZXM6IGMxZGNh
NTYyYmU4YSAoInVzYiBnYWRnZXQ6IHNwbGl0IG91dCBzZXJpYWwgY29yZSIpDQpDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KU3VnZ2VzdGVkLWJ5OiBNaWNoYWVsIE5henphcmVubyBUcmltYXJj
aGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQpTdWdnZXN0ZWQtYnk6IFByYXNoYW50
aCBLIDxxdWljX3ByYXNoa0BxdWljaW5jLmNvbT4NClNpZ25lZC1vZmYtYnk6IExpYW5xaW4gSHUg
PGh1bGlhbnFpbkB2aXZvLmNvbT4NCi0tLQ0Kdjk6IEFkZCBnYWRnZXQgcmVjb25maWd1cmF0aW9u
IGRlc2NyaXB0aW9uIGluIGNvbW1pdCBtZXNzYWdlLg0Kdjg6IFVwZGF0ZWQgcGF0Y2ggc3VibWlz
c2lvbiBkZXNjcmlwdGlvbiBhcyBzdWdnZXN0ZWQgaW4gdjcgZGlzY3Vzc2lvbi4NCnY3OiBSZW1v
dmUgY29kZSBjb21tZW50cy4NCnY2OiBVcGRhdGUgdGhlIGNvbW1pdCB0ZXh0Lg0KdjU6IEFkZCB0
aGUgRml4ZXMgdGFnLg0KdjQ6IENDIHN0YWJsZSBrZXJuZWwuDQp2MzogQWRkIHNlcmlhbF9wb3J0
X2xvY2sgcHJvdGVjdGlvbiB3aGVuIGNoZWNraW5nIHBvcnQgcG9pbnRlci4NCnYyOiBPcHRpbWl6
ZSBjb2RlIGNvbW1lbnRzLg0KdjE6IERlbGV0ZSBsb2cgcHJpbnRpbmcuDQoNCiBkcml2ZXJzL3Vz
Yi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKy0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyBiL2Ry
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQppbmRleCBiMzk0MTA1ZTU1ZDYu
LjY2ZDkxODUyM2IzZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X3NlcmlhbC5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0K
QEAgLTQ1MiwyMCArNDUyLDQxIEBAIHN0YXRpYyB2b2lkIGdzX3J4X3B1c2goc3RydWN0IHdvcmtf
c3RydWN0ICp3b3JrKQ0KIA0KIHN0YXRpYyB2b2lkIGdzX3JlYWRfY29tcGxldGUoc3RydWN0IHVz
Yl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KIHsNCi0Jc3RydWN0IGdzX3BvcnQJ
KnBvcnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQorCXN0cnVjdCBnc19wb3J0CSpwb3J0Ow0KKwl1bnNp
Z25lZCBsb25nICBmbGFnczsNCisNCisJc3Bpbl9sb2NrX2lycXNhdmUoJnNlcmlhbF9wb3J0X2xv
Y2ssIGZsYWdzKTsNCisJcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsNCisNCisJaWYgKCFwb3J0KSB7
DQorCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZzZXJpYWxfcG9ydF9sb2NrLCBmbGFncyk7DQor
CQlyZXR1cm47DQorCX0NCiANCi0JLyogUXVldWUgYWxsIHJlY2VpdmVkIGRhdGEgdW50aWwgdGhl
IHR0eSBsYXllciBpcyByZWFkeSBmb3IgaXQuICovDQogCXNwaW5fbG9jaygmcG9ydC0+cG9ydF9s
b2NrKTsNCisJc3Bpbl91bmxvY2soJnNlcmlhbF9wb3J0X2xvY2spOw0KKw0KKwkvKiBRdWV1ZSBh
bGwgcmVjZWl2ZWQgZGF0YSB1bnRpbCB0aGUgdHR5IGxheWVyIGlzIHJlYWR5IGZvciBpdC4gKi8N
CiAJbGlzdF9hZGRfdGFpbCgmcmVxLT5saXN0LCAmcG9ydC0+cmVhZF9xdWV1ZSk7DQogCXNjaGVk
dWxlX2RlbGF5ZWRfd29yaygmcG9ydC0+cHVzaCwgMCk7DQotCXNwaW5fdW5sb2NrKCZwb3J0LT5w
b3J0X2xvY2spOw0KKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwb3J0LT5wb3J0X2xvY2ssIGZs
YWdzKTsNCiB9DQogDQogc3RhdGljIHZvaWQgZ3Nfd3JpdGVfY29tcGxldGUoc3RydWN0IHVzYl9l
cCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KIHsNCi0Jc3RydWN0IGdzX3BvcnQJKnBv
cnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQorCXN0cnVjdCBnc19wb3J0CSpwb3J0Ow0KKwl1bnNpZ25l
ZCBsb25nICBmbGFnczsNCisNCisJc3Bpbl9sb2NrX2lycXNhdmUoJnNlcmlhbF9wb3J0X2xvY2ss
IGZsYWdzKTsNCisJcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsNCisNCisJaWYgKCFwb3J0KSB7DQor
CQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZzZXJpYWxfcG9ydF9sb2NrLCBmbGFncyk7DQorCQly
ZXR1cm47DQorCX0NCiANCiAJc3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KKwlzcGluX3Vu
bG9jaygmc2VyaWFsX3BvcnRfbG9jayk7DQogCWxpc3RfYWRkKCZyZXEtPmxpc3QsICZwb3J0LT53
cml0ZV9wb29sKTsNCiAJcG9ydC0+d3JpdGVfc3RhcnRlZC0tOw0KIA0KQEAgLTQ4Niw3ICs1MDcs
NyBAQCBzdGF0aWMgdm9pZCBnc193cml0ZV9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3Ry
dWN0IHVzYl9yZXF1ZXN0ICpyZXEpDQogCQlicmVhazsNCiAJfQ0KIA0KLQlzcGluX3VubG9jaygm
cG9ydC0+cG9ydF9sb2NrKTsNCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9ydC0+cG9ydF9s
b2NrLCBmbGFncyk7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIGdzX2ZyZWVfcmVxdWVzdHMoc3RydWN0
IHVzYl9lcCAqZXAsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQsDQotLSANCjIuMzkuMA0KDQo=

