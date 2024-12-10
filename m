Return-Path: <linux-kernel+bounces-439117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9C99EAAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EA516252A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB74A230D2F;
	Tue, 10 Dec 2024 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="REIQXeJY"
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179B230D27
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820470; cv=fail; b=NUcdurVXsWmnb7lF0Mb67zAjjrRQ9x2AijuLUHeAZGSpN4+eIPJRQTsHG+DAFS3+Q/v4UOJv47vxofmiZalbeQHt0A8xAVsv1YRqenmIeWFnkZeusa7HN98HEhh2CF+nW2kbUkxkFShtPwYR9AQJoI/vIOXHgMxdSvrI8o+XPgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820470; c=relaxed/simple;
	bh=zljpKXOwp3re4fgFjke3D8dOdGe7f2FnEcSHNqX65Ng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fp8JNUANvesPLR6nLGK352+LDEa+8Rq28dt3O71l/8EKXc0ErKdbGG0Iq1OgrSEq9lgSPSWoR8BrpUoEekYE2hXdRBH3XGyA61BN0RNnTpqYD/+WSxCfjRQpXfXkao2OaVpvAyvm/Hldu8o0gt4JPgwqqDa2YnAs5f5Xj8l2iOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=REIQXeJY; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733820469; x=1765356469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zljpKXOwp3re4fgFjke3D8dOdGe7f2FnEcSHNqX65Ng=;
  b=REIQXeJYiqTGnMmxWV6+q2ROLf/X2BlLOthxsEd26Z6r6HgO5iAYejPo
   hjAbmLiUZ1EZ1/qx1I96fLTYbGc+DkNWEGowUYJ/vP1ZPGP4nUZtMHJJV
   yKxqonUvRTB9SnhrtGvR4MVJM+fCbbKNdE638qBexSyS9JRC6dNsh9Eu8
   RpbyEQ3FwyOfggsmWWTNU8g0aoxoSfzs1quRUj+SHL4rwiDSHIMrMOTZX
   alhcjJHV8kC2um81kAu+L14PwulbvoiXYRa9MAWsE51KKU1eOUWzzjqrV
   3CVwnXulUyHc90jxWhtgLUb6DsVY4EUgHx1wF1OBPmqAQQZk1bJGViDMm
   w==;
X-CSE-ConnectionGUID: WSJ0S4LLThO7WwQB2RFblA==
X-CSE-MsgGUID: +iTpoWnSTQ25Pp+0d6SsTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="50834169"
X-IronPort-AV: E=Sophos;i="6.12,222,1728918000"; 
   d="scan'208";a="50834169"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 17:46:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sd6cq0R9ywrBzOrzFgxLqzBvcoHWQVw1DYrnjpvwXiK9vb3vyGl38pZ83ekLmWjlkfHky0xvL+f7MABwh5ZakhW7FlZX9AeNLP3EF+Vp5O5K6iNItBNIZnzZohFZEUyCX/yX48zhV4jjnMcF+qatIbBkSEYB+K+Ytmel4QWsBPg/YLz929VUK+8Ado1WHs+sMa7+xs1dObjBJHgj2CcqAOn3+1ni/jvIoaKA4c/0Be3FooDg+++Tu78fIcZzIqGpd4fo91hZgzUYaoHQWWuCfA6MgW4SO3lq3sYiMto23EmSvXgYbXNynmDLG31Y5zR/EQcrr6KB2JFyxqcx3Y6UvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zljpKXOwp3re4fgFjke3D8dOdGe7f2FnEcSHNqX65Ng=;
 b=Iv/l+Rg1QglZVsEQbTw9icLW93uuAxqjL/huMv0CAnz7QuNF/29a2uqU4kKDGx733H2/gcwxWaEDKgY7RAV7+4RYhOEC50QUtQ0ZVNtl6HcawjC9uUuCaKw3tB/ca5KVKfefmUFSFtLk4Z22GWd7fyRcljcYmtR8ct95adBlrQTy4hIZSm8h7ueETZIooXdepVoVqgz7r7MxuR03TEQVXaSNmdhmtfCoyuzAo7PGklCC+H0aEFXSFi6b1oajqUK/nK8O8yo8pAyn1apRJ0kE0Gt6tBLinOanpAZLPTWXJgnRhX0UPG9fY+OB+xAZmrDdMc2bKMXkzCil5j2TA7SZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9617.jpnprd01.prod.outlook.com (2603:1096:400:194::9)
 by OS3PR01MB8572.jpnprd01.prod.outlook.com (2603:1096:604:19d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 08:46:33 +0000
Received: from TYCPR01MB9617.jpnprd01.prod.outlook.com
 ([fe80::9aa4:6568:4bc3:9477]) by TYCPR01MB9617.jpnprd01.prod.outlook.com
 ([fe80::9aa4:6568:4bc3:9477%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 08:46:33 +0000
From: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
To: "'jane.chu@oracle.com'" <jane.chu@oracle.com>, 'Miaohe Lin'
	<linmiaohe@huawei.com>, 'Jiaqi Yan' <jiaqiyan@google.com>
CC: "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, 'Andrew
 Morton' <akpm@linux-foundation.org>, 'Naoya Horiguchi'
	<nao.horiguchi@gmail.com>
Subject: RE: [RFC PATCH] mm: memory-failure: add soft-offline stat in mf_stats
Thread-Topic: [RFC PATCH] mm: memory-failure: add soft-offline stat in
 mf_stats
Thread-Index:
 AQHbO9GsfRpNBfPhx0SQ9Pd6RQr5BbLI6bKAgAGBvVCAAFLKgIABctPQgAGyIgCADB/tgIAFOgaw
Date: Tue, 10 Dec 2024 08:46:20 +0000
Deferred-Delivery: Tue, 10 Dec 2024 08:45:29 +0000
Message-ID:
 <TYCPR01MB96175844C1C9DD89BC16675EE53D2@TYCPR01MB9617.jpnprd01.prod.outlook.com>
References: <20241121045504.2233544-1-misono.tomohiro@fujitsu.com>
 <c25e8ca8-5858-987e-6b1e-2e139d901dc5@huawei.com>
 <TYCPR01MB961779970E6BFA06BD4BF46EE5282@TYCPR01MB9617.jpnprd01.prod.outlook.com>
 <CACw3F51TiRZJMkze-u3a3E_3w65=PMhEUBaBQLUgNwRNuY6+3w@mail.gmail.com>
 <TYCPR01MB961770DF6F58C0D8A16185F7E5292@TYCPR01MB9617.jpnprd01.prod.outlook.com>
 <098640ac-f1c1-95b6-e367-a2673c3ceaae@huawei.com>
 <83a8698a-fe11-42e2-8a4b-ea236721f93f@oracle.com>
In-Reply-To: <83a8698a-fe11-42e2-8a4b-ea236721f93f@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZDBlNDgwZGItMmE5Ni00NGQ2LWI0N2MtNGE4ZmM1YzI2?=
 =?utf-8?B?MmY5O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTEyLTEwVDA4OjI2OjUzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9617:EE_|OS3PR01MB8572:EE_
x-ms-office365-filtering-correlation-id: 876c5f8e-b947-44e7-3266-08dd18f72629
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QXA4ak8xYmczRkRhd0Zram9wN3NMWWhxeGYrYys1SEYyVEliaDQ2cUtrMTRv?=
 =?utf-8?B?QUFESG1uUVFiV3N0NGRmN0JVUDZyVmJCaVViMnpwUVByY3h4T2ZBYmhnQkIy?=
 =?utf-8?B?dFJXeENyUHI1QldYYkkvZFkwZnZqZkJwMGdjUGhSWUhMVk1KUVdPcU8wd3Zs?=
 =?utf-8?B?L1I3aUFaVUNNQ1JtMlIyYUtPSUNUZjZMRE93SDdrZGpVUWRYbElVaEtSQk12?=
 =?utf-8?B?SHU4b0J2NHZ2a3RFVC9Md2FvZUZoY1RxR1k1d01SemhYUnJqOXpxZ1FNa2lN?=
 =?utf-8?B?bFIweFp3WU9mV3E1dmdoYWJxNFJqL2FnZTBWRjhrclhUL1FRa0daMncyWDR2?=
 =?utf-8?B?RWdpS1J1VGRXSHNaRU9ZZzBCQ2JxbXBuSUIyV3lrc1lsMWk1NVI4NnZnU0ZH?=
 =?utf-8?B?ekkzWE1RTFRLLzlMV0V2SjJxajY5bzJnbUFXOHlWaUlyWUdONjk3V3hvbVIy?=
 =?utf-8?B?aHprVjB1TVdqWmJ0RnZlZXBUelJYS1dDV01CUVJsWHV1MFZ2N1lud2RWYmM5?=
 =?utf-8?B?RlZzQ2IzbDBmNGZEalNFZVJrMzNlUlN2NUk5M0t3QmF3UUhGUU1VNTF6c3gx?=
 =?utf-8?B?VXRvZzFEK3ZnMEZCSUJ0aFFkY01yQWY4NEJ3cWZFZjZjNC9UcFBPcVNraGtW?=
 =?utf-8?B?Q2VWa21rcnRtUzFLUFovd2JxaDJleFN1WnYvblV5MWIvZHhiVUQrRjFjSXRY?=
 =?utf-8?B?b1hzY1JPV0luZlhrS3BCUm03M0l4WXd4a0drVFhZem0rVUN2alE2QWExN01i?=
 =?utf-8?B?VlNhSlNCK0o1MXgzM1hHclJ0aVVwSWdNbTI3cXN2N24zdmhVR3pnWFNLSUxq?=
 =?utf-8?B?L2RJQWRFOFJNaiszY3dFQ2hPbnB1V3RnQjBsV0xVa0grcDJJUDlwZjFzVFVr?=
 =?utf-8?B?L0M2aUgvcHEwZVBOb3ArMjYrOUFwNjAwc0xrMkp1MHl0bjhST3NFWXlCVTZ1?=
 =?utf-8?B?d21QcEdIcFVnRmxVc0IyeFpoOS82aTNJMXduYUQ5U2lCWWpMcmhSKzF6N3ZN?=
 =?utf-8?B?NGhqbmtXM2wxTXVBL1FWS3MxTzlnVzY5dEpBdFVWdTFZU0toQ2F1SXZtUVNs?=
 =?utf-8?B?UHBRMjl1WlFEWXh2Mlo1aURveVB1TEZ2c1V0bjcvSCtpUG50Z0xsNStxMUo5?=
 =?utf-8?B?d1BuUWRQY1F6V0FwWUVkVmhtb1UvbVFUOEFYaUJGNTFxT1preUllZ3NYR3Zz?=
 =?utf-8?B?OXZEY2JaemZ0U0poK1l1MDFVNE53bXZRM0Z3cHpvY0Y2RGt4N0FWdnNZNHc1?=
 =?utf-8?B?MGc3Mmpjb25rTnd4SXFjSUFsUTQ5c1p4eTRJMDAwSTRGNk94aERyemppUEU4?=
 =?utf-8?B?aURSWm9yaGlMUnI3OWM0emxVOWNKMFM0WGs5aXkwQnVjOWNTZjVjRktDS3R4?=
 =?utf-8?B?KzdiNWk2VExQbGJ1TkxlTUZoNmJadytMYUdET1paVDN3NHpURDF6SW1sUUVV?=
 =?utf-8?B?RThTRmRnUS9uOFgvUTdReFZRWTFYUFhmMHYyeVFvd1RzMFd2Vmk0eHBJUVlQ?=
 =?utf-8?B?NVdSS0tzOG1va0FJb1hoSHNXVnluTWxEMDBYOTVkSy8zOFg5OURWYmJJNXFk?=
 =?utf-8?B?Z2Nadm5rbjM0RThiTXlIeHd6SXRsanBQTStXNUVESzZ6Y1pXU2JReHBzTlhy?=
 =?utf-8?B?RFpkWkVtdGdiV1VvOFhOUzNwSjZPSXcxc0tndldKY0NRc3Y3RWFZRWpybG56?=
 =?utf-8?B?WE5MOE15QTFGNjVZZmxVbER6em9FTVpWd05rbEQ5dWNFSlhQaDRUTmJMdWc5?=
 =?utf-8?B?RlA4eGdkWUUyaUVQRUhnWU43c2VzMzdvWm4wSFZRS0F5Wmd1RmRKYlF1ZzBq?=
 =?utf-8?B?V3ZjTmR0QnIrOERmNUIxamQ2K0ZGVnQ0WWJCSEJrU3hrL1N0QUgrVHJlVDdj?=
 =?utf-8?B?STFCMlREY2xXMyt1a0tlNVA4VGxMemxsN2pPUU9DbitBdVQ0aFU5dW9HNENR?=
 =?utf-8?Q?PEJgvKSMluo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9617.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFliOXJ5TjZEeVRZZDRuRTJKM29JWWsyMmYzSW1iVUJidzRSL2RqeFQ1N0Vl?=
 =?utf-8?B?b3BJaUM4Z0phZ0t0VTNWaTduams1WWg2R0F0RXBkZXdXNjg5WVArckhLNTNQ?=
 =?utf-8?B?MmlVZGJyS0dEYjNNT1dvMjBTMkorSlZLdVZBWE5GNmtYcVBuNUVKVVRrelRj?=
 =?utf-8?B?dDBSQ3lTQWU2QVR2T2NScTZ5RTNNNmN0ZW9nNDQ2bmEwRUtVdVJKUW5Pa01z?=
 =?utf-8?B?dzdTQjFEQjg1elN0bE5XMExIa3pKaXhGN1VvZWQ4SUN5T2N4cW1rdDd2WTRE?=
 =?utf-8?B?blRjQVFGMCtvMlhVUkN5OXk3ajUvZnZjVmRRQm1wTE1IN29hV3dKWm9HeW5u?=
 =?utf-8?B?d1R6d3VENVBFcmlrek4vYzdXbFZpWmJiMVJhbEMyWktzMU8yTWQ2Tk9TbzYw?=
 =?utf-8?B?T2VOaE5DcXZFanBBc04zRHJPdHFzb0JWZkdXTzNEWnNwOVBRNEl6Ny8rOTlV?=
 =?utf-8?B?SUV6T09mc0FvYVptRTlLZkVRaEJhQUhXOTd3eS9aNEEwZ3lSbkdBTmhCNjVI?=
 =?utf-8?B?VUtzYkJXY09lK2tVRXlZM0QzcnBZNko0V243RFBPSUdGd3pnK3U0OTJaZGp3?=
 =?utf-8?B?OXpaTVUweWNCbXN6a1NQSDZGTW1tZVRTdUR5VlRXZFFVSnByZGJTeWJYN2Nn?=
 =?utf-8?B?dzlPcnd1ZUsrdnZKdXdET2lxYktkcFZONEpGMU9FMXFHRUhhL2U3a2xBT1FW?=
 =?utf-8?B?emVFUld6V2NkbmxHV0tLZlU2cTVoN2hUY0J1Q0M5S21jMnJ4aTNvN3k3eWhU?=
 =?utf-8?B?czdEU2s1Uy80cUwzQUlsYVEyWEd1d1AzcmJ0dXlscWpmcENVL2l1cFczcXR1?=
 =?utf-8?B?eFU4SkZHK2ZQSU9vQmRCTHpSYzVsM0hCTUJ1T0JjUmY4SmRqbHRyazJyeDh2?=
 =?utf-8?B?NUtmTzZaWGNZc1VLZ29KOG03YUw3ZzdNUlp3L0VBbzVrdW5URG9zR01HaUt2?=
 =?utf-8?B?VzUrNHp5NGNKaTBmMk44UGxTREl5ZlJmd1MyMCt6dnhzSnpFSHVLTVBTZnBt?=
 =?utf-8?B?Y2F2cjUxbEY4U29sa1krNE1YUC8yZDJ3N2tXbG1Lc1pzWktyTzdqeHRpZEpQ?=
 =?utf-8?B?UzJGNzhkUlhveVNyNXczSTYxNnc0M1RLQmYyWFJsamNmT0R3V2tzSWhvd3Qx?=
 =?utf-8?B?eWNhOWZTdG5vdHNQSVNRbGtoZC91Z0xGdTA3SGlqYVd6RmdRSUNDRzdJejRV?=
 =?utf-8?B?MzhoT3FMZTRuTnJSWUtvZ29RaFN0ejhSTFB4TE02aWVFbm43NEFwbGdFVGRT?=
 =?utf-8?B?OHdqdmlkZ2VKQ2YxMzBTQmx0Um9OeHlFQkdJTmJLVUVJMmE3eG54MWxLNEEw?=
 =?utf-8?B?NkNMT2MxRmxjZXpUclllSVMzeGtCTzQwK3YycEpncjM0Vi9uT2lLWnd0TVdJ?=
 =?utf-8?B?ZFpwMUZiMmVCV2xqMXkwRHNLRlRPRUUvNGo0TzRzbVR0YUZsVFM2aEF6VDhh?=
 =?utf-8?B?Q3Q5YmZ3YWdTRDVKM0MzZFhsTldnSFRVL3V0OFZsVk8vV21kRFdXTzAyQVFT?=
 =?utf-8?B?QUNxUmF1dmlQQnhnTUdKUGFub1hoVmx6QUN2Uk0vcFFPOWVjSi96NEdZVTU3?=
 =?utf-8?B?REFuWWM2N1JjdkhZSDFCb0VuL2hwRjFWQTN0SXIva1M3WFI3OFhtSjlyL1RE?=
 =?utf-8?B?Z2xqcytaT0dSdmZSeHNxN0VINmlGSFRqdGVPWU1FbFF1aTUvVkdqWmk1OG01?=
 =?utf-8?B?S2hodWI3UjM3VG1kQjFxbVNOaldLZFpTNVRCeE9BaUpRZ3pmbm13REFWcEht?=
 =?utf-8?B?VlR1dmg2OVpmYXdmTzBXSTM2cWp1TU5xMDJ1bytxYTRoY3VGUkFDMkN5U1JX?=
 =?utf-8?B?T2ErZ3g1QmdQYm5HRm03dVV5b0ZLbGxWQ2FDWlFqTnV4QVliUG1rWk5JVEl5?=
 =?utf-8?B?ZW5MdXN4M3pnUXVHaVRqMkNCZlJiTEQzcG5naVdWeGIxSUt1ZTBZL2FxM3Bu?=
 =?utf-8?B?RUwxOXZTa21xWVN6R2JFWDIwbDFMK09yTUNxenVIclZEUkR6QmV1bE9SWEp6?=
 =?utf-8?B?Z3BqZ0M5Y3dUeStWK041THhNWUJHWGJSUEc5dFZBQ29rdXJrRlZ1aTZQbU5P?=
 =?utf-8?B?ZkF3T0dPWGsyUER2OC9kZnJyTXk5T081UHBlaG5oclNnUytZdGMxWDczQjJI?=
 =?utf-8?B?djIxdkhtKzFySVRiS3hEbFViUHBaK01tRmNGUUJLOU5qQ0R3VUxLNHg3R1VJ?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T+TyuKf2R2zLxIv4CWoogNFZ7EnyUfuX/f05kglK0SeWGsrfzJUbd0i5wKiSW0ragUw0uE5wSHTet6EtzBCk0iLwmgidtaSZuvgj0vx5So/hbcWeAIdERQ5vcteZ+EIJ98qj/Od7PNLLxsrPtdzWUgR7PZlGzvOLvx0i5F83aJ4yNWDaUw5QybHWOl6LM4rejF+ZXByGAaxlPqhSL5jZSLv8N+UIIux55OcqrRJqrHt/lc6a9ds6juYGvovu5QnVUdldTo8Nq6fYOw/PrZMses5PzFvSOZ9/wbIVDSFgUMrqG19q2GzLwVc3+GlhsjTharCRzbqT0ylqkUAebvE+zh+lONlAWjJwa/aUnqtlYRtaqdvuyBM3qOLaB8yiVhhyQMi5AA3I8Rx3iRBxBXTsMowLjsex8ZeJynK8CJf0WWzkWhrYGidJnccPxy6jsQI3oVobu/TeWwstoGyC4NEDNL4OfyfqPQdjZDeOjTf2utKwjcXCFR2RkpBmCcffr9+buokZS4vcD1iA59kF/rOlO1CX6ZfIM2i8MYOfhI29FqxAwan5lD/EnUU6UQIW8giixaVN1GALUh1FvwfKpzA4Bk+5kCMk8YQOE9LCwAQ2Ndc25Z+BbmgrRv0tfjD555+j
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9617.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876c5f8e-b947-44e7-3266-08dd18f72629
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 08:46:33.2387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0WEDWySyBvmam9wI0uKEJKF0y3BSOvDunuBFh38Q1aJngpE5Q1keLKCwRY4p5JqR5nH4pCAHCQlz5DdwtPlCnHoLT4iDuR7DnXheYvbPvJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8572

PiA+Pj4gQW5kDQo+ID4+PiAxLiB0b3RhbCA9IHJlY292ZXJlZCArIGlnbm9yZWQgKyBmYWlsZWQg
KyBkZWxheWVkDQo+ID4+PiAyLiByZWNvdmVyZWQgPSBzb2Z0X29mZmxpbmUgKyBoYXJkX29mZmxp
bmUNCj4gPj4gRG8geW91IG1lYW4gbWZfc3RhdHMgbm93IGhhdmUgNyBlbnRyaWVzIGluIHN5c2Zz
Pw0KPiA+PiAodG90YWwsIGlnbm9yZWQsIGZhaWxlZCwgZGVsYXllZCwgcmVjb3ZlcmVkLCBoYXJk
X29mZmxpbmUsIHNvZnRfb2ZmbGluZSwgdGhlbiByZWNvdmVyZWQgPSBoYXJkX29mZmxpbmUgKw0K
PiBzb2Z0X29mZmxpbmUpDQo+ID4+IE9yIDYgZW50cmllcyA/IChpbiB0aGF0IGNhc2UsIGhhcmRf
b2ZmbGluZSA9IHJlY292ZXJlZCAtIHNvZnRfb2ZmbGluZSkNCj4gPj4gSXQgbWlnaHQgYmUgc2lt
cGxlciB0byB1bmRlcnN0YW5kIGZvciB1c2VyIGlmIHRvdGFsIGlzIGp1c3QgdGhlIHN1bSBvZiBv
dGhlciBlbnRyaWVzIGxpa2UgdGhpcyBSRkMsDQo+ID4+IGJ1dCBJJ2QgbGlrZSB0byBrbm93IG90
aGVyIG9waW5pb25zLg0KPiA+IFdpbGwgaXQgYmUgYmV0dGVyIHRvIGhhdmUgYmVsb3cgaXRlbXM/
DQo+ID4gIg0KPiA+IHRvdGFsDQo+ID4gaWdub3JlZA0KPiA+IGZhaWxlZA0KPiA+IGRhbGF5ZWQN
Cj4gPiBoYXJkX29mZmxpbmUNCj4gPiBzb2Z0X29mZmxpbmUNCj4gPiAiDQo+IA0KPiBUaGUgZXhp
c3RpbmcgImlnbm9yZWQsIGZhaWxlZCwgZGVsYXllZCwgcmVjb3ZlcmVkIiBhcHBseSB0byBVRXMg
d2hpbGUNCj4gInNvZnRfb2ZmbGluZSIgYXBwbGllcyB0byBDRS4gVGhlIGRpZmZlcmVuY2UgYmV0
d2VlbiBVRSBhbmQgQ0UgaXMgdGhhdA0KPiBldmVuIGEgcmVjb3ZlcmVkIFVFIHBhZ2UgaGFzIFBH
X2h3cG9pc29uIHNldCwgYnV0IGEgc29mdCBvZmZsaW5lZCBwYWdlDQo+IGRvZXMgbm90IGFuZCB0
aHVzIGNvdWxkIGJlIHJlLWRlcGxveWVkLg0KDQpIaSwgdGhhbmtzIGZvciB5b3VyIGNvbW1lbnRz
Lg0KDQpJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCBQR19od3BvaXNvbiBpcyBhbHNvIHNldCBp
biBzb2Z0IG9mZmxpbmVkIHBhZ2UgKGFuZCB0aHVzDQpjb3VudGVkIGluIEhhcmR3YXJlQ29ycnVw
dGVkIHRvbyk6DQogIGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL3Y2LjEz
LXJjMi9tbS9tZW1vcnktZmFpbHVyZS5jI0wyMDYNCkFsc28sIHVucG9pc29uIHdvcmtzIGJ1dCBj
YW4gb25seSBiZSB1c2VkIHZpYSBkZWJ1Z2ZzIGJ5IGh3cG9pc29uLWluamVjdCBtb2R1bGUuDQpJ
cyB0aGlzIGNvcnJlY3Q/DQoNCj4gDQo+IFNvIGlmIHdlIHdhbnQgdG8gZmxhZyBDRSBwYWdlcywg
dGhleSBzZWVtIHRvIGJlbG9uZyB0byBhIGRpZmZlcmVudA0KPiBjYXRlZ29yeSwgc29tZXRoaW5n
IGxpa2UgLQ0KPiANCj4gL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL21lbW9yeV9mYWls
dXJlL1VuY29ycmVjdGVkL3tpZ25vcmVkLCBkZWxheWVkLCBmYWlsZWQsIHJlY292ZXJlZH0NCj4g
L3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL21lbW9yeV9mYWlsdXJlL0NvcnJlY3RlZC97
b2ZmbGluZWR9DQoNClRoaXMgbWFrZXMgc2Vuc2UuIEJ1dCBhcyBJIHN0YXRlZCBpbiBvdGhlciB0
aHJlYWQsIEkgZG9uJ3QgdGhpbmsgd2UgY2FuIGNoYW5nZSB0aGUNCmN1cnJlbnQgSS9GIGZvciAi
VW5jb3JyZWN0ZWQiLiBJcyBpdCB3b3J0aCB0byBjcmVhdGUgIkNvcnJlY3RlZCIgZGlyIG9ubHk/
DQoNClJlZ2FyZHMNClRvbW9oaXJvIE1pc29ubw0K

