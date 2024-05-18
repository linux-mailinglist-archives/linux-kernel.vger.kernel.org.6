Return-Path: <linux-kernel+bounces-182784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7238C8FD0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 08:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186DCB21A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992EBE68;
	Sat, 18 May 2024 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="BwNqRgbU"
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021011.outbound.protection.outlook.com [52.101.167.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3728F44
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716013741; cv=fail; b=TuFtbz+C1iOE5PSmwQhD+D4qpkepDZyynBGkZ+5CRueywFJnmDbJHyqW6XsEYOtGtCaX79inpYG5cUJBQZKuV1xKgh6JzUF6P5wtRHcZI+Txl6bwvh+iQXDQcmeXsIJcG0FtwoenJDUN0hrP3Q4yC83UioUyhriohhxgFS+pXJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716013741; c=relaxed/simple;
	bh=HEtxmTO6Q/CHqCIi3Z5giPLGLHHng/h4m2/pazJNLu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WHUNR3jhSsjEV0Nb75Yj96p8Sh23JImoA1AFJHszHvSDCaTOmepFTYPj1yIxZhgWm5mAWhecswFPlZoBtDH8+zThsUb8G3yOOhWDSILR5rhtPmy9fpTaslg/Cvne1jE94h4JgCksT5vjXcm24zkB90NfXV3ELowyqkx3icMlF48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=BwNqRgbU; arc=fail smtp.client-ip=52.101.167.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hakCEF+RdqbRc1TVjcrWGTwhmF6ZPYmOYQ/Kplx+BmVELzxQsWgkI8EDBfaJ2bHkromLEgMt+lXhoUWoa3ltJwsV/zN8fIEC6aoUXWInKJf2XOajljmdO8iZW/GKUTPNgxnY4laJcgVYce0nGPpNIXubQ2WCiP4Gj5E2IVPXaIhHWiGdo5H9tyd87oksGIP+2yibb2UcBfkuAUx4iQC0yYvOCIRMQ4GW4wNdgPnu1Lp7MpgqLOS2w8tGnAv7/vmbWGBlU5yoEoGKt5PG/ywG8w78vlNZ8jwNitdTb1DnYywiaZwk19PsZTswQxqMlHAjNivkCj3JVBY2Z2fwj5yWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEtxmTO6Q/CHqCIi3Z5giPLGLHHng/h4m2/pazJNLu0=;
 b=VcMTxXml8yrBu5XuhQ0B1DuO78XQysgVTIasBvGvVC/0vdhpyyRBQ2B1vR2iGextA02J7inBTmRhoAAfTl0ZCl01OQL5zvQnXovmEMy63EXpQQEC7Ref+cqDy+ZHFJuXgAg3yRSNThG+fjFa8JrFWZFawIOctV/HK156X6JoD6v5cjUjn6lhFpzaCVHToyQtvzt80w7CiFoMsVqA6XM4z0YiCDdiOC00WjuZsYwkY2J0y+TwtXV6Unhyo2HGZmMLNDMTsvrl8HKyPq1PwUnww28UPjCR13o+jc3R9aUZpuZKHwuxuL/5RvJVTSFnNnW4frPA/+866D8LYJ3mY/id7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEtxmTO6Q/CHqCIi3Z5giPLGLHHng/h4m2/pazJNLu0=;
 b=BwNqRgbUx9FrjCNS+Jjv8ZQNMoIYf42SfNtBVnR1iRYL5+FJZd6oOb9P0Yf69U9l40h6WgjO0U0X8uHPeSurUIEmoBTxQrc9u5m9xFc3vmOgtZ+JleVDWVfbEUBiaXgUH7FYGdzMQtZl3NCs+DGX4ayJYKZwP7M1CQatn6pxIvJaxdjfhvu8/OH6YOpqo38uwE3UuWgZkWlT6vxXQoGGpKK6gsHexHk8GRxa6LNOkKvhvRvN+Ii4s0ON73XiAasy8l/DexkTQXCBcDdZUiFcsPv1YQN6cR+Venw9EOogeG+fji9lgYYVhR4TNqFrEPRBfmKKHjCKT6f0gpQTQ+uOgw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2584.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Sat, 18 May
 2024 06:28:56 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e6d7:9670:c147:b801]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e6d7:9670:c147:b801%3]) with mapi id 15.20.7587.030; Sat, 18 May 2024
 06:28:56 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v2 00/20] Reimplement huge pages without hugepd on
 powerpc (8xx, e500, book3s/64)
Thread-Topic: [RFC PATCH v2 00/20] Reimplement huge pages without hugepd on
 powerpc (8xx, e500, book3s/64)
Thread-Index: AQHaqIxtZis3HNlt1kaC437Gs4/T37GbyXmAgAC+vIA=
Date: Sat, 18 May 2024 06:28:56 +0000
Message-ID: <0dcd9649-fd48-495a-9cb3-88f8a4b3abb0@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <20240517190613.GC20229@nvidia.com>
In-Reply-To: <20240517190613.GC20229@nvidia.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2584:EE_
x-ms-office365-filtering-correlation-id: b930ef10-3f12-4fb0-1d09-08dc7703cb9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXovYU9aemJLZjRlU3ZmallHUkJ4MmEvdjhjUzNHbWJUMFB5Y1VuQXhtSVJQ?=
 =?utf-8?B?eTRpSGZkTzI1OXpGREdiUmhhUDJ3YzZ0YjZyMjRKWWNPbWpKNVFuV2lSUjRz?=
 =?utf-8?B?S2dCNWJNbXh2aUNwbStxU3ZsRUl6eXJsSFBmbC9INkM2bWFBK0ZBMnVIelpG?=
 =?utf-8?B?UWtXeHpCa0cxQXU0NndEWHF5V0lqYncrUExCMkZrR09xR0RrLzBEMENGQXdB?=
 =?utf-8?B?OUVvanQxNktPTEE1NkRNczI3L05XVDRYS3JDeWl1LzRlenFuY3BKeUpRZXcx?=
 =?utf-8?B?a2MyQTk3VVF1NEdLL1BUeDMyakNOVDVqcUd5dGhEWjlaMzNtK3NpT3RoYWFO?=
 =?utf-8?B?Mmk0SFJTSWxuSGZ2cXIvUERqMUdQUFNkanpDUzM1ZzRaZzlqMlExdzRhTy9C?=
 =?utf-8?B?WWdJdllYK1lBOExiT0VuOFhhSW1XVHpNSjk1KzFmc0NkYmFRMzBWR0pOVjZE?=
 =?utf-8?B?QlVmS1FBcTR0cDdEbERpdXQzZXdoempQVmZ2TkU2b0hEVi9RRHRPMjhIR2Mr?=
 =?utf-8?B?TUdxU0wxSDlFY3E5L3o0WGJMa1JEYUtlR2ZsZU0xU2RkQnpTc3dsdUlmYWlF?=
 =?utf-8?B?WDR4czhJTU9UenFOdUNJN05SMk5xeTkxWEtLWnVsUDB5bktLZ0RBMFJzL1pL?=
 =?utf-8?B?OWhwaVo0d3hyL0xZdVByMDd5d2w0bE14MEtWMXhkR3A3U0tnSS9JQVA5UlF0?=
 =?utf-8?B?WGZNVHRkMUhqdDF2WEpLU3lQdmoxSnhJYXIxSjZNMVduUVRtYVRGa0l5cGVI?=
 =?utf-8?B?Zk1YWlNJS0NjWUp1Q3pRcVhlS09aMmt2RGwrR1ZKZTJKakc3cTNXalNXOVBP?=
 =?utf-8?B?T2wwYS9wUDRoYStZWmgybkxVR2lhQ1Z0VStUdVp2NXFpNlZtdStCRmZ1ZUhu?=
 =?utf-8?B?K3NOU3YwTzErZ2Ezajd1Y2dpVlliNDN6b1lmNXNNMFdpcVMxajNDZVp2UjhR?=
 =?utf-8?B?S0hCM2lwaTBXdGV6T1dDZTE3cXNLK1pBN2V6SUhOUzlCaXVZZzlWOFBsdnhz?=
 =?utf-8?B?MHNQTU85TzMzdGFoTEgvZEEwa0d1MnpUa0wvMHU2a3FnZnFVa1pkTWlnMWhI?=
 =?utf-8?B?b2VzaDJRK0xEbHllZFZkeitaZzg3cWRRU0F5V3UvRFhPY3hIK2VOdHZoSTlH?=
 =?utf-8?B?cmFnUVhmUXIvTGNNa1RKVkx4aE1tZHMrdCtWRC84eHUvUEkxVkxGTFFUQStR?=
 =?utf-8?B?TG5xakg5TGVMSitTR2NZekVUQWR0MUhlQXgwOGVNOXR3K250bWJxcFRENVl3?=
 =?utf-8?B?Yk5XMVdqbnd6RW9vNUhYN2pVa2ZLcVNhZ2QzaGh1aVhxYXFnYVZZd2tVRWpU?=
 =?utf-8?B?NnZYSE1KcUNpSWthNFB6clQ1VlNYTW1SVW1qUnRqTEdtQUZDbFBrMk51QkI0?=
 =?utf-8?B?enRqdWo3elJ2MjFuSTZLcHpZMDhUOFZ5SWg1ZG5ON0JWUWhwcm5UOCtnek5Z?=
 =?utf-8?B?WWluNFI0Y29UQWtBS1V3MFIvRVhTOVNheFZYQTlBNnFFTHRWRkxCMGxOeFNr?=
 =?utf-8?B?UmxYRHp5WjNiZzFjNTJ5U3d4N3dqbVB3SVVBZEZnaFY5TjVtVkUwbksxQUlL?=
 =?utf-8?B?ZFBRMjdJcWhDVVVma0Y1TGRCNG5ZNUIzWWppU04wcEFrQ1JQR1NSZ2paUC91?=
 =?utf-8?B?cGRKMlgwVmJyL1ZOc2ZOTkZFRFB0c3VMK1RIZXpRL0lhZmVqZjlmSTB0Ny90?=
 =?utf-8?B?d1VDK1UrRThLZyt6Y2tqd2xod2UwRXRNdW4yTXJxcUV3WmcrcEVkbFlLcHhk?=
 =?utf-8?B?d3p3N0dySmpvbUpML2xLYk1VeldVQTcrZGtoUWk0QXBHWE12R1lBZVZHVklx?=
 =?utf-8?B?VUIrVHIrWVNwL2QxYTU0dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEx6ZDRNQ2doYnRqM3UwRHVsUU5VUEZ3L3cxSWpsVXdTMWlOeGVtSCtCbWVH?=
 =?utf-8?B?RFRMSWZKaDZVNW9lMWJKcEhEYmswbGZJTUJTUTUzWHQ1NkJjUlgvTjdjZ0Nh?=
 =?utf-8?B?SkpWcXBLb01WazZCcTZFTGV6Q1hUOXQzbkMvTDlXeDRnOEsrVmR1TGZlTktI?=
 =?utf-8?B?ekJkaWRIRlM3THVnRnJmSzFMbGVyZnFUcThHY1FlamVDeklTZ3hhVnhhRUtQ?=
 =?utf-8?B?dVBTUU8wcFJaZEdmaGVlVEZ2dlJsVjJpRUJMakFONDhnTWtSUG4vTjg4c0lq?=
 =?utf-8?B?TTU2L3FQenh4WEtMNE9abTVFb09GdEpNWUFRV2hJaTlsWHg3Q2kvQUp0RVRN?=
 =?utf-8?B?TUtRcW5RbW54M1RGT1ZmWUNneithcS83N1ZVZzEwenZ1RDJpam9NQUZDd1lV?=
 =?utf-8?B?V3NGdTFqcDdsM3BHTlZKNXZsamNHZ05HS25qRFdYOVR5QU5tTHl0NXdXV3NY?=
 =?utf-8?B?RXlpM3FiV09jM3Q4cHhxM21weG5weW13VVhndEgzYU5xUDFWOU5LVGRoY3dC?=
 =?utf-8?B?NWt0cmk5RkdMMnhLeTFHM3dBV09VM2llYTNzUms2bE5Ra2E1SVJ0K2tmTDEw?=
 =?utf-8?B?MXFwS3o0MUR2Y1RiVHQ2bDVUcTY2YmtwU2tHQ3R6cGhBdWtOcnNTYVBwUFFz?=
 =?utf-8?B?QzlBQ2xTeVhPNXBrVUtKQmFvUUQzNGdtMmR1eEhjYUVNd3BPV2p6MmFYQmJT?=
 =?utf-8?B?dzc0cUZHam9sWjFnM1paL0VrbnRTL2x4RnZ5MlREamdvZXNuTW1jdmp4Q1Nn?=
 =?utf-8?B?K2s0T1p6cUh3WG5pSkZKQ3grWmtiZWxDOG9LT01PejFpYjVYRVF2NlF5ZzdN?=
 =?utf-8?B?c1VmRXZUUm9ZU0U0N1pyM0w0YXp1MHFoRjdLS2FEamZYZkFabWNiN0tUSTFN?=
 =?utf-8?B?V0g3RDBwUTA4VVFDVFY2VzhWbU0zRnhUcEJ1K1RGUHJpRE5lZG9DUUptMDR6?=
 =?utf-8?B?NDBRZzdVZmZQQitXQzd1eHAzOTVDTzRwN2lZc2owVGRWNDJqc21jRWwzVnky?=
 =?utf-8?B?QnpZWitFOCtPZjJXeVAwdFR1UGZZTkc1a2YzR2VzQW1kVUgzM25scFhSRFJV?=
 =?utf-8?B?SXpGZER2ZVY4RDFQa0YwM0xIUkdnSzhWSVlPdXJ2QnpHbUJxeEpYVVhDcWhp?=
 =?utf-8?B?Syt2eHZpNGliN1I2L3FHaUY4Y1ZvRUxhc1lFL0RiUVBoVEFhNVRVRUVLM1FJ?=
 =?utf-8?B?ZC8ycU9Mb0crWWk0cENWK01LYWFxWXphcG9DVDc4VjVYbEk3Q3VrMXdnME1C?=
 =?utf-8?B?UFp1Z0dTRmNDcEw2S0R2cHVjMGI3Rjk2K1hwclQ0ZWZwM1ZwVlBCNTdhM0Mx?=
 =?utf-8?B?YkpRbmJuRTBPclZQTnM1MjJiWWw2NmNWbFFjVTMxdTc0OFhidjRFelpCYXZl?=
 =?utf-8?B?dWhvd3V6NmtlN05mMEFhaW56OHd0WW1oamM4UncyOEZsbUluSVFhdEk5NmZH?=
 =?utf-8?B?U2pyc0V3VWhoeE43ck9pRlR0OFVDMGZFK2M3a0Z1QXY3TUdoV1UrMHJDL3ZD?=
 =?utf-8?B?SWRqNVdXQ015MWhBUFdGUUs2QTArbHAxZmE0ZjMrL1k0VnQ3dFV0WnN4UUNj?=
 =?utf-8?B?amJZdWdKaTNtZ0prUnNnRHVTdjUvT3l0NFR2cUZHelprMHVLWTBtRGJ0TVlB?=
 =?utf-8?B?YXZKQ1RidE1iYkN5Vzk4eGRvSlVuU3oxYXlmR0RsSFJHQW8rMitZbjlVOUZB?=
 =?utf-8?B?a2NXR0FtM1ppbThWSEhobVBERm96Yjk2T1ZzRTJEMEdNclFPYjdVSDIxVGtS?=
 =?utf-8?B?d3VaNmcrb0xyWFA0eFQ3MTV5K2JHeDRScFkvUmw5M3ZwRDVHYzZGOUdFd25m?=
 =?utf-8?B?K1d4YVdaZ2toTXVFUFhRYzVpZ09NRDNyMm40dXdYaGtDa1JzblVJMkd1RS8x?=
 =?utf-8?B?MXNQWVVWOFg5M3ZsZHFwS0RmM25ZSzV6VXlZcGU3V0hpNENHVThTZDdoZi9j?=
 =?utf-8?B?WFBlUExmQUEra0RVTnV4ajV1ZGhSMDJsUGo0aFJ0UjdZM20vNmtLWDFzcmh1?=
 =?utf-8?B?NE5kelNjeWcveDZ1TjA3MDMzYUcvSzh5ajkyZ0hMcEdNR0FkZHNvckkyNTBL?=
 =?utf-8?B?RXVxQUI5WWV6RERaa3RqNGhCL0IxY3grc3FCK082Z1VxSVVNMklQdkUvUjBo?=
 =?utf-8?B?TGtMbWF1QlRWNEpMV3ZvVFlUbVJDSGdSN0NHTzl5NTlGNDhoSmRtakh2Mktk?=
 =?utf-8?Q?vijKoT6/jvrWWjRZODgl3NHYrXf2ZFsBvpsdAowcApaC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB4B94852FE9B043B3EE6EED606F12AE@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b930ef10-3f12-4fb0-1d09-08dc7703cb9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2024 06:28:56.4076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6m9MCAya48kbJ95fLaPkfeo1U+XwDDpMn7ElPmSGVhpOjKS2YwcPpZWfDtKqhs4U3wZMA40Wn3ItX17aOOBV7xwbPgbRbaVMzxPL2tnqpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2584

DQoNCkxlIDE3LzA1LzIwMjQgw6AgMjE6MDYsIEphc29uIEd1bnRob3JwZSBhIMOpY3JpdMKgOg0K
PiBPbiBGcmksIE1heSAxNywgMjAyNCBhdCAwODo1OTo1NFBNICswMjAwLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOg0KPj4gVGhpcyBpcyB0aGUgY29udGludWF0aW9uIG9mIHRoZSBSRkMgdjEgc2Vy
aWVzICJSZWltcGxlbWVudCBodWdlIHBhZ2VzDQo+PiB3aXRob3V0IGh1Z2VwZCBvbiBwb3dlcnBj
IDh4eCIuIEl0IG5vdyBnZXQgcmlkIG9mIGh1Z2VwZCBjb21wbGV0ZWx5DQo+PiBhZnRlciBoYW5k
bGluZyBhbHNvIGU1MDAgYW5kIGJvb2szcy82NA0KPiANCj4gVGhpcyBpcyByZWFsbHkgYW1hemlu
ZywgdGhhbmsgeW91IGZvciBkb2luZyBpdCENCj4gDQoNCllvdSBhcmUgd2VsY29tZS4NCg0KSSBo
YXZlIG5vdCB5ZXQgdGFrZW4gaW50byBhY2NvdW50IHlvdXIgcmV2aWV3IGNvbW1lbnRzIG9uIHYx
LiBJIGZpcnN0IA0Kd2FudGVkIHRvIGhhdmUgYSBnbG9iYWwgcGljdHVyZS4NCg0KQ2hyaXN0b3Bo
ZQ0K

