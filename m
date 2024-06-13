Return-Path: <linux-kernel+bounces-212497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C31906203
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFA81C20F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FF984055;
	Thu, 13 Jun 2024 02:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XcuhvHG3"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905FD1756A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246092; cv=fail; b=Smu3PrZ8u68UvGdSqwR6nNgD1vKrwQLequ+wQ389P+QRhWrJsL3sQ/jQP7FGGfFTXOFmSp10Q3yN8zKjD7WB/RMFIOAmvUgxbi1rSgVQxwY/J5dXQRsqE37QZfwpqyZTb/w/O5+5YT104Fd6ZGXUgSxRFgpOo/eY/JZIjAInDyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246092; c=relaxed/simple;
	bh=a/DlWCNWzL1n69tPPTQqcKL2OMw3CxKPmR+b6QLRXNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqH0mc4WzrwspAiU/s+4W2mOXSEp4F+5nCmr1OZj6wEoS7EAmYThtPE1EJgshGrVW7/qc/oI0G3zyRE2Jwj9Mgdhi7ANOlP+P338rGvKxKOkB0rVUYfyoa9xg0g30/NIwSaxmsRvE9kCyzBUCk8xjF8hd5be9r7xJM5CB7rpTY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XcuhvHG3; arc=fail smtp.client-ip=40.107.105.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grsd6z1PtWM7xI/qj4gO6BY5eNfs7Jk3Pa4XQuxCzc1PgVQGg5lmvdG9/4yrwnOQEYDZ/7xjdBaiooeLlWT65oLAs1oDvJ76bwWjqCU62h8ygGV2at8o5Y7qQgyMlW+2PeNoEhKLAQlgTcbK2GY0xLBBV3snQiaBA/jV+e010bMH+/VT4ap6MHcKEjBHmSFbnwmMo9Ecdpu3FN+Ug0sCkdNw2Q1cQhJ6CBS2U6RMO+NuNfyymh1Cn6cWAv+j+V4r78A9+0vYsaUmRnm0oQ/8rU1idMiLT8XDJPfX+hT+AoluVvMnPmsnCm4fxTsJ+dW9El1aIC6OstoAvftLQUgcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+NWy42GqAC74vyIYF+B340QWpjncuTuhg7CE4oDUpM=;
 b=lNc/X3q5dHMjoT59PQsGCPWHxph+fMMNPKPBjqXo+AG7VqYHYNDq761VQ1SLKv4wFTfOba68xzVZfIXYV+XcKhwtBoKwfhAJ/D5P4iFSOK69iMn7v10uhNExjNjqPJWYoq7G5P2snjAGFpZzr+NMyb1dOcZflwgXmU+HkM+K1/gIyvREueMMzOWTZe2tkB8aiNamC6By0W8zD25johH2LMsXScpJxMogXy4X7Bo5rVXQ8aes3b7n31izKHdlmYdTK9mdhxlfZsheezB059WowW+jbKPMdndA/x64IEIyJ9lyncodzMCYwiltRwFccI4bshx35BK/yGXp9nQPxR0m/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+NWy42GqAC74vyIYF+B340QWpjncuTuhg7CE4oDUpM=;
 b=XcuhvHG3ewr7/60fujBHWOfMxrjyMMIo2NOYO1YNgPVSk/2LP2aWJVFUfHuoPyo3QXs2tSp4qbDZZYJcsCaFG2dxAaOrDTecEX+b5vGwjFdCC9/nRojy8RCQGs/yWHhsrKtnSqx4WyraMzhyvkYA0UWx2WCWzQYczey5Q/wIGbg=
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21)
 by DU2PR04MB8823.eurprd04.prod.outlook.com (2603:10a6:10:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 02:34:46 +0000
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123]) by AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123%3]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 02:34:46 +0000
From: Zhai He <zhai.he@nxp.com>
To: Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: "sboyd@kernel.org" <sboyd@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Jindong Yue <jindong.yue@nxp.com>, Christoph Hellwig <hch@lst.de>
Subject: RE: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Topic: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Index: AQHavKBGxUJQI1jHm0WeihrG1yRS87HEeMkAgAAvWICAAE1E8A==
Date: Thu, 13 Jun 2024 02:34:45 +0000
Message-ID:
 <AS1PR04MB9559D82F720BC9A64077186AEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
References: <20240612081216.1319089-1-zhai.he@nxp.com>
 <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
 <CAGsJ_4wsAh8C08PXutYZx9xV3rLRwLG-E6Mq-JgoSO5LA1ns=A@mail.gmail.com>
In-Reply-To:
 <CAGsJ_4wsAh8C08PXutYZx9xV3rLRwLG-E6Mq-JgoSO5LA1ns=A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9559:EE_|DU2PR04MB8823:EE_
x-ms-office365-filtering-correlation-id: 344f1c5c-6c10-448d-22b4-08dc8b516365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|366010|376008|1800799018|38070700012;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHVWdno2a0hvRDRDZk9nbHBLM2hOTWtQTzNHVnNtbkoyajBCNFRWSFZQb2VW?=
 =?utf-8?B?UVphMG1IT016azdVQnhESFVSTThieW8wd3VieS8zU3VOeXVhOXo0Z3M4dWlF?=
 =?utf-8?B?dlYxb2d4dHIrbzJPYUVHQkkvWjJXWmNCNUFWYXlwVno0WSsxTitnMkRFUzBZ?=
 =?utf-8?B?MXUzaXBBcnYvNDRVV05pcXJLK3pHTVNuK01JdU5aTEYxTyt5YXBVcGIzQ3B1?=
 =?utf-8?B?K3EvSlJtTUtCMmZ6YVBudHNzT1YwR2xON3RKZHRNemdqeG84UUNsWXJFd09u?=
 =?utf-8?B?ZDlUNytjeGlzMHpwQk0rbldwaFZjMjN5cUNhdmVGRjdrTURrVzJzV2xCeFg0?=
 =?utf-8?B?OW0yeWsvcDl1dDNscEZLWkpBaXFISytEcDVCZnZpT0o5c1dPLzhybU0xUGdZ?=
 =?utf-8?B?b1FFNFRPbkN1TWVCcmtpMGdpdVA2cUh1RExuN3ppVUxIYms5ZnU2amxzSFNC?=
 =?utf-8?B?cnlqb1V0NnhML3RJRnludUIxUGdEeHo3dzR1OERMNTFyVkhZZ1hISnlNVm9I?=
 =?utf-8?B?cGVicGtuSlhpQjVIeDBkQUlzTG1MSTlUaXFlbFMwZHI1SEFJWm4yYlNQY1Q2?=
 =?utf-8?B?YTE4cGFnSlVHZG1McGZvL01BVXZEalFLb2c4RVNFWm1zQXdiTzlYYjhZemtQ?=
 =?utf-8?B?YUhUMXJYZ3czK2dYOThPbk52eHhWM1p1M09OcTBaa1VvOUNlWnhiS3l5Nzgy?=
 =?utf-8?B?Z1B1aWpwVmtpblRLRiticVVONk8vb0Rxc0g2aE1YWVk2REZ2WC9oZjRQQ2dv?=
 =?utf-8?B?UUY5S3JhMWpWNjMvOWhlSlV3OWIzSS94QWZvMk9wZlhEQTNoWUlOcC9xZS9G?=
 =?utf-8?B?S2tBVUs2V0tJT3YzdFhPTWsxNThwVU1IcWhQQkZlNkk1dThHc1VDUVlUWkdS?=
 =?utf-8?B?NFBkRWN1ZGNxWHp3V2tBdUlVVWpwYktkTEUwWVFwYjVCcTNvVlJnQ05HU2xX?=
 =?utf-8?B?NU9ERUtFdmxZdzFMTmJZWTBpcWtMaEszdjR2RHA5emN1V0FJZXE0OEE4MnZh?=
 =?utf-8?B?SWRCdUJybDRBZS80MHBPckFEaDNDRmtFUGVock9lNXEyQno1MzA0K0NSZ0pn?=
 =?utf-8?B?cnp3MzV2Rlh2RjVSNEdxMUtWT3VNUENuR0cwTEJkeFg2NGpZZmJwRks3MWdV?=
 =?utf-8?B?MzluZ2R4OW5mNzhQb0VyMmtheUFyTjZpUFg5cEFvcHVFSDhUK3VoYXE1WTE2?=
 =?utf-8?B?MVFTQThWakVsT1hJVGtsbWFhN2JKdHAvZ2FJekNCdWZ6OW9xbkJWMUZvQmJL?=
 =?utf-8?B?RHhXT0g5T2ZOM1YzVTgxZnJiK3I0UzRKRkVuZEN5S0RjMUJnaC9FTjlseUll?=
 =?utf-8?B?Q2VJM3NoSXlMejNJakoweHBlREVwTkcyMWtnUVVGc0hza2wrNTFFVkdxdUhz?=
 =?utf-8?B?TDgyYzk2cGJtcjBNcmZTY0dmcGRaQTZxdUp0QXBhb3hYM1huSkQvRldjcnZj?=
 =?utf-8?B?aklPTGJnMjZNdnBaVjlkL0JYRElDeFpUazkxYXJ1UTYrK3REOWxHbTE5TC9T?=
 =?utf-8?B?Ri9WVG1jUFFFMDB0SGRPWklDQnlJMUlpQnRlZ3U0Y241ZzVwd1RMejhJMzdx?=
 =?utf-8?B?bEdOeEVjZWJieFd0SndsaHNoZUc2TlNHVUJ6LzJGbG8xS2ErNkF4L2VXRi9h?=
 =?utf-8?B?STZjYU8veGFuL1NvYkVpNDhTMFlmdmRJbE9ScHZZaGNPakhsbFdHUzQzK3g0?=
 =?utf-8?B?c0xYb1p3bHoySE1xSE95aW9vNUtlL3lWbnR1REo2N083YXVkcXZkN2p0ejZ2?=
 =?utf-8?B?azFYT0VDSFk3RU9YcG1HOStOTThZYlJpOXMzdVhRU0xaUmVNNEFTdjYwaVg5?=
 =?utf-8?B?VVVJRXV3U1RoZEF2dU0xbS9yWVhydEhUV3dvdGRabXQ1RThCeERrWStYKzds?=
 =?utf-8?Q?K58fWu6qS+WHx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0N4d29Ga2RJL0plaEVFdUQ3NkRZZXZScEE2TUx6bTVvRHNIdEZKdWs0blYr?=
 =?utf-8?B?dDJ4R1E0MVFCNkIzL1B1VTh5UU96eGVnY1VtUnN2d09GSitKKzJrOEtzWWFl?=
 =?utf-8?B?bXJjM0JtRG1KUy8xZGp5bDQ1ZmlNRjYvWHZpMVNIWDAraHBiYVM1ZGx0ZEdI?=
 =?utf-8?B?SURNcDlseElmUmpHTXUrOHU5QzJLQnhydS9ROEs3R0pURUFjeUN5anJHTzJa?=
 =?utf-8?B?eUJIU3ZWYklNOXFyb2t1T2E4a0dKUFBPbzRaQUJjRjNxejUydFNNZmhTd2NE?=
 =?utf-8?B?Y044amUvRUlaY2YxTDB4L2NndkpUY1NUUGFJdmp4cmYyREhWWXNOV0hZUTVa?=
 =?utf-8?B?WnNJeEZnSzAwVFAwSWE3R1J2cTdtdlJITWZHa1AwMmZDR1FmTW9MNlRNcFF2?=
 =?utf-8?B?Q3RzazV4L1NSZjYxY0MwcnRqczZxNnA2MlpZTW8wR1R2ZnZ4WkhNZW0rdCsr?=
 =?utf-8?B?cEY4V1hUMVpRN0xBem1PaktRR1EyWW4wcEdWNjg5Mi9zUnVwL3loYWNZeUxo?=
 =?utf-8?B?aTljOGhtWlBLcW5ySldvSVc0R0hVaFZ4N2VQbXRXTFlSZlZWbU5aMjFwQWMv?=
 =?utf-8?B?RWcyVm0veEhTM0ZnbFNUMzd1ZklFSEwycGpiMkZjcERhalFiSURyUDZINmgv?=
 =?utf-8?B?bXp2L0ZJbmF3amZjK3BJVDE1SWZxbHg5SzdobkhzWjFGdSs0UUVEajN3L3Bw?=
 =?utf-8?B?RG1wQSt0elIwYi9naHpSaG4vTTlKN3QvbWhSbnFlbUFLUUZmL0kwbjhiQUFX?=
 =?utf-8?B?cm5haWtzZmZSWVl6aU00OUtYRXFTenBFTXdPd1AxL3VaM0VJRjFRRnNhSDFp?=
 =?utf-8?B?NlVUeGhHbWY2cmRiK3cyMEhXRGNsYVgvbStlSnd0cExxZjZ2ZFlKeVZOTXkx?=
 =?utf-8?B?cDZBeTI3K2JqYjRlaStOM2F1UlY3eVRwUDVRV296RnNkSGJNNmhvYTZBOGhQ?=
 =?utf-8?B?VkR4T3YxUk1nL3lZaWpWQWZHZHJpSnZZNzFRb3M3WHM3WUwvY01TQ0M1Nkxn?=
 =?utf-8?B?ZHVvSWcvWDdKVEZLK0hsNEJZcG1VR2UvRHc1VlBCZllCVk90cThwUGR3V29R?=
 =?utf-8?B?U3kxL0V0TEk0VEZYMVBYNWNtVUk5alc4MlprZGluZW4reWQ1YXFrZnRJRXZq?=
 =?utf-8?B?WENLV2M3NmdCUVJjMDMrakNNbDAyQ2pyTWwyMFZ0SUt4SXM4cnNOaGd3MG4x?=
 =?utf-8?B?a2hHOEk3OG0zM3lZZFp2NU9wUmFLdnc1RVdwSENQWjh5RTZydjNnbWJuc2xn?=
 =?utf-8?B?ZmlZNzNlZTJLTFZZS2xobXd3WllDdzFTRVRuV05UZkc3dFcrdE9JSEYzU2Iv?=
 =?utf-8?B?U0lXazAvSVpNK2hlcmtxcWZrNHBLWlFENzR4NGlRK3grVVI0Qk1pSUFBZWZh?=
 =?utf-8?B?eXRLUXpLejV3bXFDQ05vMXhHMEQ0WnpXeXJYeG1QaWRVemJZdzMyWHJ1QkNS?=
 =?utf-8?B?emVZekJuZWtYcitrbFMxbXhiRzRXbkVtT0NYK0w4anlhSjRtcng4R0VVb3BP?=
 =?utf-8?B?SkJqRGdPQ1ZXT3BWcTNjNlB5MTU1cFhzWDNPWWxwTWhBYzRMeXFWc0NLWTRT?=
 =?utf-8?B?K3FvYmNRSDQzbXF3SW4wdVo4WkxzZGI2bnJGQ0R5NHRhNm15U3lhemFQQ2pP?=
 =?utf-8?B?WUVvTHppUUlDN0RPdVM5d1BlbzV2YWhkY1Y3UnVuSklXb09RbUoxaDdHZUph?=
 =?utf-8?B?blZDRHJtM1ppQkdRZTBkTmcyLzU4c0tQYi9PMUVMeHZPZm90NlhsOFI3U0RE?=
 =?utf-8?B?bVVVNVpHc2lZYysvVEZaQ0IzV3p2MFhORlhtOE1tREJiRTRIaDkveStNTzBO?=
 =?utf-8?B?QkFCVk9JcStkWmtIZUYvaWNYcW40N3NQYTRBSFFjYnUwSHcyV0VTWFlyUzJG?=
 =?utf-8?B?d2Z5RWVvOFJaUWlwNnptRDVta21qMms2SDNXRkIyTzBjZ3NjSjg4OXNvTHdi?=
 =?utf-8?B?b0pMZjByV1R6dFRUNVVHUThVa0xETkY5RUhnNkhQN3FzUVJRSzd6Ui9GWjVB?=
 =?utf-8?B?MGVNaGc4UzBQVlBCN3h0Snd6d0psdDhBQklYTFVZMmhUeXlKS0pKVzlaWnlO?=
 =?utf-8?B?YzBOcWtKUnNxRFlndlpOZTFWWnRoQUJYQ09kZjhpQUlxOWRrT1EyYVBwMmRw?=
 =?utf-8?Q?Px1g=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_0110_01DABD7D.4CD96C10"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344f1c5c-6c10-448d-22b4-08dc8b516365
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 02:34:45.5681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXHpqVoP9V33FNZh9HQJS7UaeT2EVZtlEwzopUdWnsmrE7uxZHDniSIHZWxwnbxA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823

------=_NextPart_000_0110_01DABD7D.4CD96C10
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Barry Song <baohua@kernel.org>
> Sent: Thursday, June 13, 2024 5:37 AM
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zhai He <zhai.he@nxp.com>; sboyd@kernel.org; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org; stable@vger.kernel.org; Zhipeng Wang
> <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>; Christoph
> Hellwig <hch@lst.de>
> Subject: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
> device-specified CMA memory is not enough.
>=20
> Caution: This is an external email. Please take care when clicking =
links or
> opening attachments. When in doubt, report the message using the =
'Report this
> email' button
>=20
>=20
> On Thu, Jun 13, 2024 at 6:47=E2=80=AFAM Andrew Morton =
<akpm@linux-foundation.org>
> wrote:
> >
> > On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he" <zhai.he@nxp.com> =
wrote:
> >
> > > From: He Zhai <zhai.he@nxp.com>
> >
> > (cc Barry & Christoph)
> >
> > What was your reason for adding cc:stable to the email headers?  =
Does
> > this address some serious problem?  If so, please fully describe =
that
> > problem.
> >
> > > In the current code logic, if the device-specified CMA memory
> > > allocation fails, memory will not be allocated from the default =
CMA area.
> > > This patch will use the default cma region when the device's
> > > specified CMA is not enough.
> > >
> > > In addition, the log level of allocation failure is changed to =
debug.
> > > Because these logs will be printed when memory allocation from the
> > > device specified CMA fails, but if the allocation fails, it will =
be
> > > allocated from the default cma area. It can easily mislead =
developers'
> > > judgment.
>=20
> I am not convinced that this patch is correct. If device-specific CMA =
is too small,
> why not increase it in the device tree? Conversely, if the default CMA =
size is too
> large, why not reduce it via the cmdline?  CMA offers all kinds of =
flexible
> configuration options based on users=E2=80=99 needs.
>=20
> One significant benefit of device-specific CMA is that it helps =
decrease
> fragmentation in the common CMA pool. While many devices allocate =
memory
> from the same pool, they have different memory requirements in terms =
of sizes
> and alignments. Occasions of memory allocation and release can lead to
> situations where the CMA pool has enough free space, yet someone fails =
to
> obtain contiguous memory from it.
>=20
> This patch entirely negates the advantage we gain from device-specific =
CMA.
> My point is that instead of modifying the core code, please consider =
correcting
> your device tree or cmdline configurations.
>=20
Because we enabled secure heap to support widevine DRM, and secure heap =
requires security configuration, its starting=20
address cannot be specified arbitrarily, which causes the default CMA to =
be reduced. So we reduced the CMA, but in order=20
to avoid the impact of reducing the CMA, we used a multi-segment CMA and =
gave one segment to the VPU.

However, under our memory configuration, the device-specific CMA is not =
enough to support the VPU decoding high-resolution code streams, so this =
patch is added so that the VPU can work properly.
Thanks.
> > >
> > > ...
> > >
> > > --- a/kernel/dma/contiguous.c
> > > +++ b/kernel/dma/contiguous.c
> > > @@ -357,8 +357,13 @@ struct page *dma_alloc_contiguous(struct =
device
> *dev, size_t size, gfp_t gfp)
> > >       /* CMA can be used only in the context which permits =
sleeping */
> > >       if (!gfpflags_allow_blocking(gfp))
> > >               return NULL;
> > > -     if (dev->cma_area)
> > > -             return cma_alloc_aligned(dev->cma_area, size, gfp);
> > > +     if (dev->cma_area) {
> > > +             struct page *page =3D NULL;
> > > +
> > > +             page =3D cma_alloc_aligned(dev->cma_area, size, =
gfp);
> > > +             if (page)
> > > +                     return page;
> > > +     }
> > >       if (size <=3D PAGE_SIZE)
> > >               return NULL;
> >
> > The dma_alloc_contiguous() kerneldoc should be updated for this.
> >
> > The patch prompts the question "why does the device-specified CMA =
area
> > exist?".  Why not always allocate from the global pool?  If the
> > device-specified area exists to prevent one device from going crazy
> > and consuming too much contiguous memory, this patch violates that =
intent?
> >
> > > @@ -406,6 +411,8 @@ void dma_free_contiguous(struct device *dev,
> struct page *page, size_t size)
> > >       if (dev->cma_area) {
> > >               if (cma_release(dev->cma_area, page, count))
> > >                       return;
> > > +             if (cma_release(dma_contiguous_default_area, page,
> count))
> > > +                     return;
> > >       } else {
> > >               /*
> > >                * otherwise, page is from either per-numa cma or
> > > default cma diff --git a/mm/cma.c b/mm/cma.c index
> > > 3e9724716bad..6e12faf1bea7 100644
> > > --- a/mm/cma.c
> > > +++ b/mm/cma.c
> > > @@ -495,8 +495,8 @@ struct page *cma_alloc(struct cma *cma, =
unsigned
> long count,
> > >       }
> > >
> > >       if (ret && !no_warn) {
> > > -             pr_err_ratelimited("%s: %s: alloc failed, req-size: =
%lu pages,
> ret: %d\n",
> > > -                                __func__, cma->name, count, ret);
> > > +             pr_debug("%s: alloc failed, req-size: %lu pages, =
ret: %d, try
> to use default cma\n",
> > > +                         cma->name, count, ret);
> > >               cma_debug_show_areas(cma);
> > >       }
> >
>=20
> Thanks
> Barry

------=_NextPart_000_0110_01DABD7D.4CD96C10
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIhTTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
MqAfBgorBgEEAYI3FAIDoBEMD3poYWkuaGVAbnhwLmNvbYEPemhhaS5oZUBueHAuY29tMB0GA1Ud
DgQWBBRnNp0/tSrFNJlgS+ZRdCT+c5yRQDAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhed
BzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnBy
aXNlJTIwQ0ElMjA1LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9j
ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9u
UG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9o
dHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUF
BwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBD
QSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVj
dENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtp
Lm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNlcjANBgkqhkiG9w0BAQsFAAOCAQEA
ggGwWe/YcZgJiMbIhUsSO/bYD09itDFnYO+uQqGwvPalRuHk3rA6pXfNb4DoA+gFZLgVDHNul0YA
oS8u+LYHUwXe/tP1HZvoInRRnUjPCP7o3uoQFcX2Ay0pVz3AoByHaFAqF3zCCsAdDhTksMPZu2eQ
oapJc06m3ZaIBpjT6aVZOXnRFVcHUjaMAZrpm2jqv3jJt58kP0dRsCrfKUkeTflak885rGuUypZC
j9tjOii+7/qAsUR/JqMZADUo2cD+PvCwHZRPpj0x1b5Ain8/3mRDTCaa7mMOUApMdd7De9fNjosF
LLTdnTiUXO+gnVgwXLvMOhuHTI6aWS+Z9pD1tTCCCDgwggcgoAMCAQICEy0AC58oXPwK6O6UsbsA
AQALnygwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJ
BgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQI
DA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhw
MRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yNDAyMjcwMTIyMzNaFw0yNjAy
MjYwMTIyMzNaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMw
EQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYwFAYDVQQLEw1N
YW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGY2NDU5ODCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOFpbP807BLOCF4Zt9RudYkITj3hHgHYcWcIYUiT
PmR5wym2ussl7jezDSHHlEvPmzhgdSx/PVPpYcv80hjMDHFw3aoV0qyOU+W/pOT2oCL/7S/fHWUe
2Sahoup+MvYXycNdoONBohwwdCcWt71fxvxzsCq0XtnkUdgoTXFlZb53vhD3rAHvP/QhY8jLGvMa
I/xK5kFNYIC5EBH5m+atfPB7qERZIUU9nCacRfJVAZpkK0j8L1YBjG28Xm9OcDdgQAsOVRFdkFxk
3YVjHiSmGfDmd8QdvPJrlIDb/mdVXR/FGSl95J16mkithq2e3DBNOJtWrxxj3XDkmXpr9iAUGpEC
AwEAAaOCBFcwggRTMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUua
klY/heaKboS14X4CAWQCAUEwEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/BAQDAgUgMAwG
A1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZIhvcNAQkPBIGG
MIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBGTAL
BglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4GCCqGSIb3DQMC
AgIAgDAOBggqhkiG9w0DBAICAgAwUQYJKwYBBAGCNxkCBEQwQqBABgorBgEEAYI3GQIBoDIEMFMt
MS01LTIxLTE5MTUyMDcwMTMtMjYxNTA0MDM2OC0zMDc2OTI5NDU4LTk0NzgwMjA7BgNVHREENDAy
oB8GCisGAQQBgjcUAgOgEQwPemhhaS5oZUBueHAuY29tgQ96aGFpLmhlQG54cC5jb20wHQYDVR0O
BBYEFDrgyxq3zDcnhNi/Mb2VXLlr7Mn3MB8GA1UdIwQYMBaAFFiVYO5OdO9lIqq97RmpK3qOF50H
MIIBRgYDVR0fBIIBPTCCATkwggE1oIIBMaCCAS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJp
c2UlMjBDQSUyMDUsQ049bmxhbXNwa2kwMDA1LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2
aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2Nl
cnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Q
b2ludIYvaHR0cDovL253dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0
dHA6Ly93d3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUH
AQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29u
ZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
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

------=_NextPart_000_0110_01DABD7D.4CD96C10--

