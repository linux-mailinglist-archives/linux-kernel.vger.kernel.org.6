Return-Path: <linux-kernel+bounces-443175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6289EE862
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEFF1884879
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF4E2147E5;
	Thu, 12 Dec 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="KSa9uqHp"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08902135BA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.152.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012486; cv=fail; b=USgm7Uo4JYncaMsRSdWakypAnrq/F4+En6lAsYeZ1XDLL17A0TM983hS7YYhmfuF/Tci/fROgLwEUs0CYdyB8H95JnPTfihs7K8en8l0Ol+v3770tZxLA9w/ruru2ePlO+axP0Cdcrxq8vHbQ7RDOyDutiQBPC7xEfQo0wSisTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012486; c=relaxed/simple;
	bh=4o0p0WhMCYj+UoYlhedgwQ564PUqMpJMm0WcA5iIX/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=khtc9sAVkjj6p9aJDXqtcv42659fsk/Ki5XyglHJqvaLnAW2KLj/c5YRk5/ehabfPNEFiOGvE+1r80PkE09BLfA1XalRCfnFVB1AG1Ne+ygZHtnBKFXKGqg1C0aU86ep7VvLdaiQw595ugC0Q9di79/iELDVTxpR91zaKBt7DK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=KSa9uqHp; arc=fail smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Received: from pps.filterd (m0355089.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCBndJL028871;
	Thu, 12 Dec 2024 14:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=0Ufso5PpnhgMFsGyGZao0H9UG8y7NXTl75ueOwfr1ts=; b=KSa9uqHpUwIa
	pn5X4pXgN9UeoMAjHNwzLieuSkCooXTpLqDgNRG1FUSxrdp3cF3GDmItAr9MXVJv
	ncG8j1Yeka8OgqpxSAlobWXw5dNha1/MnP0kFWNOk7e6twLqAr92oEjbrk7fJWDH
	AEILWsVbR6/jK3M3nNjKXvYjsBZcp5E1JjkVyio7r2LRaqQ/LuH+v/bAXwf+xRhL
	VS+LJ9gBaSzy4grlNfuoztoTTmi6JmCmJBJ7u5C/efoPEY9jxSbPGv+Kb9Bh1BD9
	BuTjjQ71fQ7kfEiixtQM4mJgxoK/wV7SGkYlFzEtrERRFdhiT2nOZNZ1t8+9MZnI
	d3fLFm4tWw==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 43d2wmtret-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 14:07:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+QmhKGiXniJU+2pJ/7bSX/ure6VBAMfMQYt/kplg2feiV2rt0PTtursrlMj78YyOEkKfvUkqJjS6PrfPgVepcdhfOSCjLNohmTPyEYHaLGtVF12cMuHJazhq7xOVweG2tCif7CGQ4BaXip2wherSeXNj0ualTskWxigKc+VrJbFHmOwSYC1FKDPTzJ7oKjP0dy+rIWkQT0vOBXvZ9O3WakBXW7mT7LkLgfGiU3ggSsbVvn1LkLJN4EEwrZc+BJ6JG+7nax2s6rF2tLiBBSsmIEqpOE9GoqyGAJZ12c8OYm6ZgGhPWdQaDiIXLnpVSFfuI6vpieGJoXpXSsdqFAg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ufso5PpnhgMFsGyGZao0H9UG8y7NXTl75ueOwfr1ts=;
 b=ibugO72GFtgmMAZgvXR2qHmtXZ6fzyPoQUAVL8E94o0AL7Zk5G8ACeliwVMO69eeWP9gZlR09QpZDDlpiiCBDuSlxnBarReviWPskjgnYoxW4uJCHrLG4fxljlKiBoTK4ovZ1CgtbAT7jrpVUjN7OkpNiQ/Rd3ql8yqkOcvRVmJ2tX6LfJd4oiiGLRJxR7AQ0PToyZoL8imoJsY81Od/1GKzB9ECJPV57+qTayBJIqsciFjNUqlKtR2kCf2nDkB5Y7W57afGQgnhVM28VXJ8Z4NnVT1SzDOLhxXVevfVXBKnYNodedQXv768NLRWyaoH2ZgaxLbKky3sclozrhsocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from TYZPR03MB6192.apcprd03.prod.outlook.com (2603:1096:400:130::9)
 by SEYPR03MB6458.apcprd03.prod.outlook.com (2603:1096:101:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 14:07:32 +0000
Received: from TYZPR03MB6192.apcprd03.prod.outlook.com
 ([fe80::54ac:ace0:dab9:cf27]) by TYZPR03MB6192.apcprd03.prod.outlook.com
 ([fe80::54ac:ace0:dab9:cf27%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 14:07:31 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Hao Ge <hao.ge@linux.dev>, "surenb@google.com" <surenb@google.com>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Hao Ge <gehao@kylinos.cn>, Ben Greear
	<greearb@candelatech.com>
Subject: RE: [PATCH v6] mm/alloc_tag: Fix panic when CONFIG_KASAN enabled and
 CONFIG_KASAN_VMALLOC not enabled
Thread-Topic: [PATCH v6] mm/alloc_tag: Fix panic when CONFIG_KASAN enabled and
 CONFIG_KASAN_VMALLOC not enabled
Thread-Index: AQHbTJ8v7FDRfLEMUEKI2gjVi5+lzw==
Date: Thu, 12 Dec 2024 14:07:31 +0000
Message-ID:
 <TYZPR03MB61923B28E4307CDD21BADC5FB33F2@TYZPR03MB6192.apcprd03.prod.outlook.com>
References: <20241212070320.133419-1-hao.ge@linux.dev>
 <20241212072126.134572-1-hao.ge@linux.dev>
In-Reply-To: <20241212072126.134572-1-hao.ge@linux.dev>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6192:EE_|SEYPR03MB6458:EE_
x-ms-office365-filtering-correlation-id: 8d3f25b1-4c5c-4f80-f868-08dd1ab6520b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?B+V1SXrBnPpGt1/v17eNLYl3/lGDk9R0tvwfOYUiHlBZaPYGo20lhHMdnX+/?=
 =?us-ascii?Q?XM1kHvUKXlUuUZafu1s6JPFjRb4cu0fVrO28dWyXEmI8o4xK4mQGf1q5KUsh?=
 =?us-ascii?Q?iI/AfZfmDbhzVUNHXmnwfABYd75xgjWPaBPdLuxdRT2lV6QyzIyEHqKb/Gi2?=
 =?us-ascii?Q?tcBAYRFZUS8OGPXfwEWIKipkBbzD7LLMN/E/o3ia4V/55Ce2zmBXXXZcFJrJ?=
 =?us-ascii?Q?ICTLSny9uaiZosycGHd98TkHODtpuuV+zqMOE1rg6ElUQ5sShQ7nMObga5Gz?=
 =?us-ascii?Q?fuXkGzaAYJ9xqOJm7ghx042fwLlNNgMN4prlRm9PLYgcfUHVxE8YQx58MYE/?=
 =?us-ascii?Q?h34aDh1cR71Z6NStdi/hvbpKFy+DXEzHQ3qZximGxQmbbSr0VMHVUtof3R9s?=
 =?us-ascii?Q?UmxCTVU5Ow1bHRlYGo4620Ogq98CmcMHAthCzBz8t3Jj0V+WGgBiEPfw1bGj?=
 =?us-ascii?Q?NWU0l8kr4ido6IvHJjhIvqawoFw/l8C3ZN3LEzbskd8CG/NDeV8L5cpkT8nD?=
 =?us-ascii?Q?FE1jtIOVubyFt8wi70Ras1AJz6FyYxSNMqltMfS7NT5GAP4DDXq+t/iTIZXQ?=
 =?us-ascii?Q?HOLADV/VhpVAdwD9WOv2NpC7sk+4hO/L1qGOCHsREuiZgbU6KGT1PfK8q6rG?=
 =?us-ascii?Q?7qXAXs4MNMA0MPvUqhJq8FtMYCZef7VgPz/8H4944YY9P1qe6guSbSkfe1Id?=
 =?us-ascii?Q?1aZK3OVQvzOJn+xeOic+Bkj8Um1yfcpgLixkBQMzwwWuL/q8rccjBORwpK56?=
 =?us-ascii?Q?MmN2QpzSzeHJ6ux6LRw+3a+T1edOk/nFUCI9OG1gdPM3z2ltmQ8HnrDhD9oF?=
 =?us-ascii?Q?Wg04e7hZsEeikn+Ma8/gteiTr7bEVd/WDeTLKwKaD/WDUZRhrUJIGFN/M2Jf?=
 =?us-ascii?Q?zN9HPg9pgrQCjTxOPik4VTl+w/IpamcZ8/lL0a6tX3oEIoWhpeFCnODGH2Jx?=
 =?us-ascii?Q?SlAd/FuRPFKYRs87pZobomcS2L432jlabqmUSeOSdofJwyiR+Pp9XWwMeS9S?=
 =?us-ascii?Q?qSX6w81Lm//IUshT4VgwXMzLpGD9xoHLYbaOanSiDJEgycNxZn+SF+zQI4Na?=
 =?us-ascii?Q?PIzHofi7mpxTrEZIgWzM5E1Z3Xv2WXqgpQEmJel4aozTGV/jZDXV+FbwkZFV?=
 =?us-ascii?Q?vTyOidu7KVreHneLiV9SCVRDIhM1K1wdVR1jzXTlCN9xfNejk/llJMrboZ0f?=
 =?us-ascii?Q?TA/2bKTvf2I8PHBmv5iclh5+67kzhgFTPjGbtvpHsOr1sihalUPfaqTfMMQj?=
 =?us-ascii?Q?zegQeK3XQIUlbMo0QrBKmnNR+epdmEylzlpzdyTHT84zwdfNnp4WnLfaC3Bc?=
 =?us-ascii?Q?cuc2p0mqz2/gejjwMa79XugIFAsKWVpaP549Myjuw8/miBig3LsDrVKHqylD?=
 =?us-ascii?Q?E2vr9APmy8hATCcy76PTmRuRg69vPXaCN6VIcLK0yo73qyRhrvPGe+meWDCg?=
 =?us-ascii?Q?gnzo4xDyRGgdBOznm61RLrxVBcjytUrh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6192.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?taVL/chhAYsX1oK8+srfdD3ujR9ytLb0QYiPr5KELvbnM9RhXt1otNsaT/f3?=
 =?us-ascii?Q?xkAf9qN7I4HgpsayCkancnFvCh5QPIGbFa+x3UzBb52FrKxk14i33nMzVkdT?=
 =?us-ascii?Q?JPMTSaO5xDQEm/8rWqrXBL3n0tWEPn4PgHeSNlD0rXi/1Do/JlRfY5t2E8E8?=
 =?us-ascii?Q?SMaX7QOlNOMfDGtMjwaQ0cTicqOHy/EcTQLLZxg1A2KW7ziB3A/snvSm301j?=
 =?us-ascii?Q?nIlze0ZbLG1jJUc2EKREJJ6qT/exQumzDj4bTLEMyWaVHHKd0h5rZggb5Rvc?=
 =?us-ascii?Q?CEq2qyAa/BILAfawjaRdMSC+xkgERhRJOnTteA+GTC0Yl7mMvwXg4jwfHKyh?=
 =?us-ascii?Q?QUgk2Ppnqmxy+P8pI7AbORBB15NILRdrRdrHwIOnlmmhtUaMj7IbGEK/JwGX?=
 =?us-ascii?Q?We7GOanaJjK/EeUCZq602yRzAELq4/atDHhNJC2TmiHkLD7jtgemvz8d63/b?=
 =?us-ascii?Q?foZ180hf8gbmYQMrstgKQzYCRCyeQHeJLZlbO6yZ8mepXdMYN1uTB5z0MPPx?=
 =?us-ascii?Q?RP2+0W7xnSDSfoOeAz9rPK1kzfnQSK+ACZX/wwnWD3S0RJStLMnsXduHuD25?=
 =?us-ascii?Q?ngVNFB0TNWuC9JUKxegyPtRP06/bkMBaKQyzxoLAbhcOi6QaBGXruVqb/8Qb?=
 =?us-ascii?Q?S5z3K0IayN4nN19/yrGIyQnpT5jU7WCybbAXkES4r+/7CeLPV5S4VgCrZSBt?=
 =?us-ascii?Q?oOp14RatjGVUOHyVPAo3YriapKP8zEkpaUA43YY8x+6N7uIolqxV1mwdX6sa?=
 =?us-ascii?Q?wGwTVU1WqSV4dyveqoOHSdHFMn+/6IMyt4UwyjZenL+4TJDTnwGhXa4K8QFs?=
 =?us-ascii?Q?nmtBrBwIgovYesc42tpEIdHBW7+PH31D0jg6FCBHq3wW6EXstuGyATxlt3wi?=
 =?us-ascii?Q?FVBR8TJlKzicj+5FX908sUrW7mzz056Dg5SQG3AKCm2FiQrRKIJGzCw05/PA?=
 =?us-ascii?Q?RIHkeLY0tHWvT+pI/iQuTeuLlG7mOEtByija62l1YD9yCxtNzu8/IRbCr4jt?=
 =?us-ascii?Q?pouWNG3CsPSmKB5bssW3ybgS3kxmy4HcfHb7T+H/tnPjLzF4XEdFxXhzR/1F?=
 =?us-ascii?Q?gDrRxvV6S+Qak8lsHbzmn8KFXDpey+MiKrCEUxPbUs/hCKk8LH+72t8M85GA?=
 =?us-ascii?Q?jaVcTbiuCxEYN56tOVOlp69enJ7wDFWbw9ZEFcj7058+1mnj6d/w9HpVMbwB?=
 =?us-ascii?Q?UfaAAHmwQPDBShZe3L4Nxo26W9CcV5o8SEUuswE3gu4IU7A7DpkL8PHF6FPj?=
 =?us-ascii?Q?G0uqWDXNviwmwhaEHtOgtws2nHbA8H5dyARf0uT0M+ld+xr+p7nXa/B5SapB?=
 =?us-ascii?Q?tPce/8GBjU7yB96hzTqYJUhMSCRUxXt7J7k13VBkaQ7RWKkUBjDOCmt0fEyR?=
 =?us-ascii?Q?45m25Ldu2KLJEbw/M8ERMdgJTHUyrfjyRgcVy/XQjZH3HH7w3gFkZjOMNZeG?=
 =?us-ascii?Q?8Z2FdX12H0W3Dz0HpMIkZCylbB2ip3v6Q8SFcTPZ84g56+Jit+yEkWnWm7lT?=
 =?us-ascii?Q?lqGUA4VAxw+zF1vWiI2SkItsLGzNOhLdJdhVYCPynVxglITGza127lGCT25V?=
 =?us-ascii?Q?wqRfmOov6uOv7Zs0pwpWZiIY4gvN58mCWkVEDagB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6192.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3f25b1-4c5c-4f80-f868-08dd1ab6520b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 14:07:31.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gudaczMlsweaFFKSa7iRQw3pdeU/Wk3LkvRNP+ZjQbCfnUA1pTq/w9S64z3K9mf1JdetJPK9eYzjHUGA5PTqFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6458
X-Proofpoint-GUID: UB8Vn49hh_cgsPVqvYrukVsn3j4BPncc
X-Proofpoint-ORIG-GUID: UB8Vn49hh_cgsPVqvYrukVsn3j4BPncc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=906 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=-20 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120102

> -----Original Message-----
> From: owner-linux-mm@kvack.org <owner-linux-mm@kvack.org> On Behalf
> Of Hao Ge
> Sent: Thursday, December 12, 2024 3:21 PM
> To: surenb@google.com; kent.overstreet@linux.dev;
> akpm@linux-foundation.org
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; hao.ge@linux.dev;
> Hao Ge <gehao@kylinos.cn>; Ben Greear <greearb@candelatech.com>
> Subject: [External] [PATCH v6] mm/alloc_tag: Fix panic when CONFIG_KASAN
> enabled and CONFIG_KASAN_VMALLOC not enabled
>=20
> From: Hao Ge <gehao@kylinos.cn>
>=20
> When CONFIG_KASAN is enabled but CONFIG_KASAN_VMALLOC is not
> enabled, we may encounter a panic during system boot.
>=20
> Because we haven't allocated pages and created mappings for the shadow
> memory corresponding to module allocation tags region,similar to how it i=
s
> done for execmem_vmalloc.
>=20
> The memory for module allocation tags is allocated on demand, therefore w=
e
> need to allocate shadow memory on demand as well in MODULE_ALIGN
> blocks.
>=20
> Here is the log for panic:
>=20
> [   18.349421] BUG: unable to handle page fault for address: fffffbfff809=
2000
> [   18.350016] #PF: supervisor read access in kernel mode
> [   18.350459] #PF: error_code(0x0000) - not-present page
> [   18.350904] PGD 20fe52067 P4D 219dc8067 PUD 219dc4067 PMD
> 102495067 PTE 0
> [   18.351484] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [   18.351961] CPU: 5 UID: 0 PID: 1 Comm: systemd Not tainted 6.13.0-rc1+=
 #3
> [   18.352533] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S
> rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   18.353494] RIP: 0010:kasan_check_range+0xba/0x1b0
> [   18.353931] Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 dd 0=
0 00
> 00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 c2 0f 84 c1 00 00 00 <48>=
 83 38
> 00 74 ed 48 8d 50 08 eb 0d 48 83 c0 01 48 39 d0 0f 84 90
> [   18.355484] RSP: 0018:ff11000101877958 EFLAGS: 00010206
> [   18.355937] RAX: fffffbfff8092000 RBX: fffffbfff809201e RCX: ffffffff8=
2a7ceac
> [   18.356542] RDX: fffffbfff8092018 RSI: 00000000000000f0 RDI:
> ffffffffc0490000
> [   18.357153] RBP: fffffbfff8092000 R08: 0000000000000001 R09:
> fffffbfff809201d
> [   18.357756] R10: ffffffffc04900ef R11: 0000000000000003 R12:
> ffffffffc0490000
> [   18.358365] R13: ff11000101877b48 R14: ffffffffc0490000 R15:
> 000000000000002c
> [   18.358968] FS:  00007f9bd13c5940(0000) GS:ff110001eb480000(0000)
> knlGS:0000000000000000
> [   18.359648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   18.360178] CR2: fffffbfff8092000 CR3: 0000000109214004 CR4:
> 0000000000771ef0
> [   18.360790] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   18.361404] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   18.362020] PKRU: 55555554
> [   18.362261] Call Trace:
> [   18.362481]  <TASK>
> [   18.362671]  ? __die+0x23/0x70
> [   18.362964]  ? page_fault_oops+0xc2/0x160
> [   18.363318]  ? exc_page_fault+0xad/0xc0
> [   18.363680]  ? asm_exc_page_fault+0x26/0x30
> [   18.364056]  ? move_module+0x3cc/0x8a0
> [   18.364398]  ? kasan_check_range+0xba/0x1b0
> [   18.364755]  __asan_memcpy+0x3c/0x60
> [   18.365074]  move_module+0x3cc/0x8a0
> [   18.365386]  layout_and_allocate.constprop.0+0x3d5/0x720
> [   18.365841]  ? early_mod_check+0x3dc/0x510
> [   18.366195]  load_module+0x72/0x1850
> [   18.366509]  ? __pfx_kernel_read_file+0x10/0x10
> [   18.366918]  ? vm_mmap_pgoff+0x21c/0x2d0
> [   18.367262]  init_module_from_file+0xd1/0x130
> [   18.367638]  ? __pfx_init_module_from_file+0x10/0x10
> [   18.368073]  ? __pfx__raw_spin_lock+0x10/0x10
> [   18.368456]  ? __pfx_cred_has_capability.isra.0+0x10/0x10
> [   18.368938]  idempotent_init_module+0x22c/0x790
> [   18.369332]  ? simple_getattr+0x6f/0x120
> [   18.369676]  ? __pfx_idempotent_init_module+0x10/0x10
> [   18.370110]  ? fdget+0x58/0x3a0
> [   18.370393]  ? security_capable+0x64/0xf0
> [   18.370745]  __x64_sys_finit_module+0xc2/0x140
> [   18.371136]  do_syscall_64+0x7d/0x160
> [   18.371459]  ? fdget_pos+0x1c8/0x4c0
> [   18.371784]  ? ksys_read+0xfd/0x1d0
> [   18.372106]  ? syscall_exit_to_user_mode+0x10/0x1f0
> [   18.372525]  ? do_syscall_64+0x89/0x160
> [   18.372860]  ? do_syscall_64+0x89/0x160
> [   18.373194]  ? do_syscall_64+0x89/0x160
> [   18.373527]  ? syscall_exit_to_user_mode+0x10/0x1f0
> [   18.373952]  ? do_syscall_64+0x89/0x160
> [   18.374283]  ? syscall_exit_to_user_mode+0x10/0x1f0
> [   18.374701]  ? do_syscall_64+0x89/0x160
> [   18.375037]  ? do_user_addr_fault+0x4a8/0xa40
> [   18.375416]  ? clear_bhb_loop+0x25/0x80
> [   18.375748]  ? clear_bhb_loop+0x25/0x80
> [   18.376119]  ? clear_bhb_loop+0x25/0x80
> [   18.376450]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags populated are=
a
> calculation")
> Reported-by: Ben Greear <greearb@candelatech.com>
> Closes: https://lore.kernel.org/all/1ba0cc57-e2ed-caa2-1241-aa5615bee01f@=
candelatech.com/
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Thanks for the fix.

I encountered this issue recently and confirmed that this patch fixes it.
Feel free to my add my tested-by.

Tested-by: Adrian Huang <ahuang12@lenovo.com>=20

-- Adrian

