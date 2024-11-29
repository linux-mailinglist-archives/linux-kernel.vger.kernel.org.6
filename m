Return-Path: <linux-kernel+bounces-425321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8FF9DC07E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896C2164BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF36161311;
	Fri, 29 Nov 2024 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bt7wnB8Y"
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE515CD52
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732868796; cv=fail; b=u7riI8QfmZW/brcV3GqWjL3GbqWEk42NKqKxrlSW8Vh+iD6Ls6xBRx8REi4NywGYuKgBpunQAUP35UPXSLAOj3V4vaL6F4ShtfmMOkJHgEiK7kuQovduWl4LfDKg/QJQzwtKuksMZ9Wr7WHfD1RaPvtect8mNxqknmSk+xICk38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732868796; c=relaxed/simple;
	bh=ku4RNqaDfZ7Dy8J2bjhJl3q2q5nYbyamE4ghlO63V80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZoUK4Ok5KftoKszAZlihrC/X/hxf2ZY40e8i5ZThlgV0jObfyPR+2TOhhe7GG7gAZthfJBmqKCwGhxNyv7ehIOsnh326ieJBXveUUGjtPK4HPIRfKxiPd53i8l1T542Y5Oz4YDzEncmo6AxPiZKiIX6rzYUaIQwP7eJb4h3xBXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bt7wnB8Y; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1732868793; x=1764404793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ku4RNqaDfZ7Dy8J2bjhJl3q2q5nYbyamE4ghlO63V80=;
  b=bt7wnB8YJwPg2gFHfKUxzwZeykA9pNptGlRzn+TXQqgVXN8PZUv/C5aV
   C/Os/r1VJVQOf8xA2IGPtSAUTMqTVLcxmklD5kjqyMxWTTm2/fjNwauTF
   TYJ/j0qcYqXWnmZRdU8Ip+B/9oJwkC5XUQcrm12bGFvI36Ea/d38xnoJC
   kZiT0ewbN9caTTv2cEgz/H7ePT1E38MAhjjHn6TIbZAjBMoNrjNLAgiZ2
   8nZSdWWvJbG0HqBt/7mtiSPjsxTQoa/762ffE8bTVWbPQvGlsGVtXodaV
   lDNIj1jj8kgCamls+MB3cfBbp9/LdXn2lGtgca8hu6YQFu+5a024tPeBK
   g==;
X-CSE-ConnectionGUID: RtLy1BaURNeTRlMyxHdohw==
X-CSE-MsgGUID: CSECOJORTLySeBN/4RlzGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="138142455"
X-IronPort-AV: E=Sophos;i="6.12,195,1728918000"; 
   d="scan'208";a="138142455"
Received: from mail-japaneastazlp17010001.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 17:26:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4AvCxQohM4GPCyrSA97gWfo9kh20a35hmbqLQWzxv0+WgLPXafw4AcE8bf8Muu2IPuHMV3W/3IY1De6GuYfCgYCiLDR56UwMcmCj1oqmJ7/JoBNZK278+LjwyC56TMMl1RAvn1+4gOePaUFLwTDslmp8HjF5qdXbcztcB6pEKfUssu++et7r2hM6TBm7+kxhZBo00KuMbafZ1Q06wgdkwqg7NbQ+ep7tMCjyo8AhC6qTmtYSSj1elhA/6xuglcrG2ZMwxma0SBp5PZHKsoj4jnH6lSwSE+3ZV1Uj1H+Uz1zerHQ1iRsEFYfSiRMvGw2L8DyvqmD3NxQms5kT4ZmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku4RNqaDfZ7Dy8J2bjhJl3q2q5nYbyamE4ghlO63V80=;
 b=qMPpPCZ7Tl8U5zjlJu5QBbi/pIB4DhKAFIcT/14Xi8iBFF6qH4F1CG1dakPAIKvOlA+t4CADXLTwxFgDoXI/diJipDIJyx84/WIDpwajlyyQr9qNrAU476XPPBoVWFrJgeBmlU3Z/SrCVqr6QgCnQwHDXdjyy88uWCHYR06Iy4zMUDF0uVFEF8dQ4M3t19yGcmDwm37cu94jURUsUP0HuJv2AC5tfy53abBwHl4Cp8Miys7Ru1A6+FenAbDSgPdpX9UpsdMqmNFt3hT68q7sJun7D5U5s92cw1NEXDlVr8Kf+X7hZwoGH/0gHOSfeMnwheQDFXOf9R2Hnrx2BrB1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9617.jpnprd01.prod.outlook.com (2603:1096:400:194::9)
 by TYCPR01MB8785.jpnprd01.prod.outlook.com (2603:1096:400:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 08:26:21 +0000
Received: from TYCPR01MB9617.jpnprd01.prod.outlook.com
 ([fe80::9aa4:6568:4bc3:9477]) by TYCPR01MB9617.jpnprd01.prod.outlook.com
 ([fe80::9aa4:6568:4bc3:9477%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 08:26:20 +0000
From: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
To: 'Miaohe Lin' <linmiaohe@huawei.com>, 'Jiaqi Yan' <jiaqiyan@google.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: RE: [RFC PATCH] mm: memory-failure: add soft-offline stat in mf_stats
Thread-Topic: [RFC PATCH] mm: memory-failure: add soft-offline stat in
 mf_stats
Thread-Index:
 AQHbO9GsfRpNBfPhx0SQ9Pd6RQr5BbLI6bKAgAGBvVCAAFLKgIABctPQgAGyIgCAABUQgA==
Date: Fri, 29 Nov 2024 08:26:01 +0000
Deferred-Delivery: Fri, 29 Nov 2024 08:26:01 +0000
Message-ID:
 <TYCPR01MB9617A2CC29E34D10B6B85ACFE52A2@TYCPR01MB9617.jpnprd01.prod.outlook.com>
References: <20241121045504.2233544-1-misono.tomohiro@fujitsu.com>
 <c25e8ca8-5858-987e-6b1e-2e139d901dc5@huawei.com>
 <TYCPR01MB961779970E6BFA06BD4BF46EE5282@TYCPR01MB9617.jpnprd01.prod.outlook.com>
 <CACw3F51TiRZJMkze-u3a3E_3w65=PMhEUBaBQLUgNwRNuY6+3w@mail.gmail.com>
 <TYCPR01MB961770DF6F58C0D8A16185F7E5292@TYCPR01MB9617.jpnprd01.prod.outlook.com>
 <098640ac-f1c1-95b6-e367-a2673c3ceaae@huawei.com>
In-Reply-To: <098640ac-f1c1-95b6-e367-a2673c3ceaae@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZGY2YWEwZGEtOTMxOC00MGM0LThmM2ItMDE5ZjRhMDJh?=
 =?utf-8?B?MDljO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTExLTI5VDA4OjIzOjI5WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9617:EE_|TYCPR01MB8785:EE_
x-ms-office365-filtering-correlation-id: ef3c1a7d-f0bc-488e-6d1c-08dd104f80fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFZBTHlBSlRDUGJDR0Jpa3l2c0dxM05leFBWaVFYUW8rcEwzMHNZV0M0VW0x?=
 =?utf-8?B?WUJIbHZQN0RHalNVRzY2Mno4QWNGY2szaFl3L3cvcFV4UEs4WWRMMVFjOCs2?=
 =?utf-8?B?dEpYZWVlRUVkYVZTRmZPVWsrYlp3bXdCSGpkRVI2dWlaSmxVMkJWcmdYd2pH?=
 =?utf-8?B?d2JwcjlUTzN4SEFLZzV1UjA1bm92Q2JrV1lZN2tNNTdQaXFETUxsemRHZVBX?=
 =?utf-8?B?emJKZTg5UnEyWHBoaUhkd0hZendqZUVqRW5adWJoRTJ1UEpodTNBREtmbyta?=
 =?utf-8?B?OWI0T210UnJ2aldHUW90cGU1NmFVYnV1M3M3NlNtOUVPNTBCc2VzU0FFMTF6?=
 =?utf-8?B?ZnQ3SldwamdaL2pNWW9XRDJjVkVLWCttWFhpZFU1Zms4OTNyK1NBZGdtZVN3?=
 =?utf-8?B?OWFHcnFVZGw3enMvS0w2OG43VXZOOGZ5Ukw1OG9YTTVIVWRJVDRhMXhFTjJU?=
 =?utf-8?B?V3VLSzFoL3NQRmRzNGdpOWZyd2hNRXdZL3c0Ni9IbnVianFJUmd2OXh6MGtH?=
 =?utf-8?B?ektjaERpbXJyZ2FiR0dTL3Jvci9FVURjU2U3b2RnQnRCbFB0N1NWQWJKcHpv?=
 =?utf-8?B?SmlyazcvMG1MWDRPZjczQ3Y5TGlnbU9TY1N4TGk1KzZQeHZqU1lkSmw0c3ln?=
 =?utf-8?B?RUtpL0ZsWFUvMDhMc3FZYldIS2d5S2JKOWlmUTlKQW8xZzA5RFBUby81cTBQ?=
 =?utf-8?B?Y3Q4MW9ZYjBYeHNtZTRUQ0lKY1NPSGJDU01BY3FFOXhNV1ZnZW5za3EwTXhk?=
 =?utf-8?B?bGpNKzBaYU5Mbm8wV1BQR3VNMkUwdlplVVBOU1F3cjVGRHRnRE45RGpKdXJV?=
 =?utf-8?B?NVBCL091MUNibmJ3QzY3MXkxMXVmUG4rNXoraUVjcHBEdlNaMTJrZGxHYXNq?=
 =?utf-8?B?UTFMZnBNanZ3T1lxc3U1VlMxMlFOOWRuYVkyQUQ3ZVlpWkhqMHV3Rk5rYk1F?=
 =?utf-8?B?b04yZHZGdCt5akRYaGEydFF1VUtkaFNJOWtwbzZ2YnI5MnBtaTVzSmRjWUZV?=
 =?utf-8?B?UjlYQWs4bGcyeXZQUmxRZjdac1NhVldVU3NlbjRVYWRYdkZrYU5HMnY0WjQ4?=
 =?utf-8?B?RTBTY000VG9GSHppYktIMFNvWU1JVU9QVmRPelhhUzQ2dC95S3hiWUZrRjlY?=
 =?utf-8?B?MHN3dmU2N2J4aUVKeUQydmk3anlRaCtPd3B4ZFBZb1FPTm9WMjYxZHQwbGQw?=
 =?utf-8?B?ZFU0aEo5c0t1UHUwcXZlcmhrVzRWTm0xRVByUGthZDBmd1gwUEpWV1VKQ1JB?=
 =?utf-8?B?bXNEUjBlTnlwc05mdFk4UkRuamNCNk9SMGxiS2dBd1BRdUFEaCt0MStnZ2Ew?=
 =?utf-8?B?amZKdjFzOEtTZ1ZVYU5ZWXFjS3dKa3BNNlM1UkFvYlVoblZ4RzdETGxoVUJy?=
 =?utf-8?B?YXFCbXNvd05PWDdSRkxESmM3MFhtemI0WHpOZlQxS3NDaUlXK3pSRllpSUcv?=
 =?utf-8?B?YU10VlAvcE5DMW5JRXoxYi9mZnJ3ZCtabjY0QVZZRnNHYk5yR0ZGNmNCd05y?=
 =?utf-8?B?aS9QQk5YTncxZFNsTTN1dmQzeXlnY0YzR1hSRWlhNlpLdFR2V05kTDQ0eGtS?=
 =?utf-8?B?Rjh6cit6a3VFMkJrQlBaT0greGNSSXZIa3FKeUVwKzl3ZlRtdUVmQ2k5bWpi?=
 =?utf-8?B?M2lOWFlSTlZCN3JZZjdhTTJ3QmNMNEczSWxabWMwTURTbWQ1aml2S21OZ3Q0?=
 =?utf-8?B?UjhhTUhaVUVub0tUT0ZURDY1d2ZYYjc3QnVIUXpzVWFpMXM1RnFoT0VDZEZ3?=
 =?utf-8?B?YTh4UVBkVDZWRHdBRDVUcXRLbG83VlFsa0dMcmRrR29FT0xOdFZISUl6bGxp?=
 =?utf-8?B?STRabjR1UUlwdXVmczNVNGRzK3BsaWVFSXJOOGxOU3ZlRURxdTVUMUxlbnor?=
 =?utf-8?B?YWdMYW9HY2lOQ2lyamgvOTNFMW1JdG9ITHRvOXlPN1BTWHlvSDZDRS93L216?=
 =?utf-8?Q?DcI/2vY6VKL2+44xXaZ/RGZLS+QJ75H+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9617.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckhOVnNLY1c5N0RuS1VTTTJNeVYwWkFlQWNMbnoweU8weUlRQzNLTmc4N2dW?=
 =?utf-8?B?UzJITGFYQ3QxM3g3SGlTQkJEV3hMaXo5bEpON1ByZ3hoSE5aZ0VjbFBpMlZC?=
 =?utf-8?B?U1pmcm9WVGw2S1JpYm1iWHlJa2E5amVNNFR4Ym9Qd203ZWtQZ0pQVkhNQmsw?=
 =?utf-8?B?cG1zMElEQlZwd0FJelFXNVVkM0I2enREa0tWMFpDSjdlWkhxVEY1SWxzRkEz?=
 =?utf-8?B?K2NrTVZLTmNNK0FOWEI1eDN1UnFMWThoQlpwK29id2dKcm94ZWRjTG1Ud1dV?=
 =?utf-8?B?bnJnMGIxVkRrRytDbU04YlJSczRhTGpFbWk3bjNhS3pTZnNrYzlTR3BlQzh0?=
 =?utf-8?B?Zjd3eUtEMVdoc0g2cERod0RUZ2pCM3BXRFpSQkZqTmlFL1d1ZFppcDRWUFpu?=
 =?utf-8?B?WkhLbVlSNEFkRloyeDZJZUJMeEhzaWNxZmQ2cTUwdkxRSnZYZEVxN2x6Qysz?=
 =?utf-8?B?YnQ5N01pdVg1cy9xbHpwRm1KNnZoN1cwQmwyblJzd0hDT2xUL0U4SCtZcEov?=
 =?utf-8?B?VWI5ZTZOWW11RURDSXZQL1kwSnFyWlNPMDg3Z3Q4bVlnRTF1ZVB6MktmL2lG?=
 =?utf-8?B?eXhvSE9qUXd2c2lkcDA3Znc0RWRKZDcrM0RWdWdXVGVwV01UU2hGRkdacGhS?=
 =?utf-8?B?SXFqVmdBQ3J6alU0amVaSERGZDAveWJzTHJTNU9Ba2ZSY3I1Z2F3QU9FZ29E?=
 =?utf-8?B?OUpLNEhhalNka3BwSmowcHdFNXZrS2dOVXhPcE5Ma2F2N2ZSTTJ4SDE2TnZo?=
 =?utf-8?B?ZVZqd1NuQVhZOExVWG1aTmZpNGF0NjVNTFgyMm03MnJ5WTNBWlNNenJvNWJk?=
 =?utf-8?B?aEo3ajF4akN5NkhXekg0MVNKOWJ4K21uMFRXNmJlV2dqZ2ZzcnF2TnB5VVBC?=
 =?utf-8?B?eW9HMTc2dXZCUlF3TGM1eVIvRllMdmRMYksrWlVLdUhTWkRJMERCYWZCSHJX?=
 =?utf-8?B?bGIxYWhwWjQ2Q1FnVDcvVEF4N0dlNkh2SUxjekFwNksxMTdFUUREL0s1akNt?=
 =?utf-8?B?aEFFU2grSkxJa2pRNFMrYm9hNFVPcElKMEhLcHR1Y3Fiandod09nSVlZM2xS?=
 =?utf-8?B?OGpGMEZmZTI3c05zTjl3aXpFV3lxOFRiWDBjVVYvQ0RZd1BPMVZ3ZHRxNXY5?=
 =?utf-8?B?MGVGR3BHM2FqSlRuS0ZqdEV6RlJsM01RcnZub1dOK2lDd2piTWhMY3hvL202?=
 =?utf-8?B?Qm1kU3p3WWNEc3oxT0F4cEJWakFad3U5Q3k3YVhsSDgxSnUxcWVnV2E1TXZY?=
 =?utf-8?B?RThBZk9QZDZ2Ny9GRHdvN1EwNEcxbHZVR0NDdEgvdFBUK2JseEVLc29lUUJD?=
 =?utf-8?B?Nnc1RHNkV3A5akdGSCtiUEVNcTI1NkF5V0I3WjFEM1NEbEdnNmRqMkFiOHRa?=
 =?utf-8?B?UlprZW50b1hJbDRUc2JDcVFRVHE2UkV0MDcyY08rWlQ1Q3cxSHFaQkNqMUdC?=
 =?utf-8?B?Qm04STJtS1JkTmZTRFNrZ3UwdEFSQXBZL3grK1QwdlN4T1Q1UHRIa2R0VFh2?=
 =?utf-8?B?V1ZPMHBvc1JDaVJZSUhwdklab1BHQTdFT0hEYmgyTWhxZGN4dm5FWUJ4OHpP?=
 =?utf-8?B?bHpyVVBOK0xRMWNDRy9DLzJpcEdyVGM1QlJCT0lBZ1I1THFRMWQralptU0x0?=
 =?utf-8?B?bUExTE9ER0RwbFZha29ISFRCYldRbGJ6ZzFDano0Z043dVRtQjFkODlLUmRo?=
 =?utf-8?B?NHpXR1l5QU00dzBzSlM2bHZOU0xNZHhiZklSR1pWL2ZObENJR1BKUEk1bGU2?=
 =?utf-8?B?VDUwTDF6K1Q3bXdZbVhJd3FsTGlSNDhPZlUrWTdDTEM0TGY4MTQ0RDZ3eVp6?=
 =?utf-8?B?ckJSbVdPRTlaOFBmTmFiVnVLVzhoMDlUTkVITEVoREgxbnZnODIyVWxVSUNS?=
 =?utf-8?B?aXFvNlp5WkZGL2t6eEQyUytBK3cxajlBc0tjL1lGT3RlRTBWN2dMWTdIU2dB?=
 =?utf-8?B?dExXSTRyZXpVVWI3RG5KNlFFdG4waXZoR3U0cXpvOUpodjRxZGpmUWxvQldk?=
 =?utf-8?B?a21MNjV1cnJvS1hYUDU5alpQcEg3QjAwajlLS0p6WXpqQ2YrMURubVBDYzNV?=
 =?utf-8?B?N2ttTFRuL1ZsTktSMWU1dUVENXBHNXk5WnJENldCQ2laS1dEZmtMK3RkL21p?=
 =?utf-8?B?U3c3ZHY4SGtsY2R1NTdNYXVaTWJWVzVCeGNSdnYwdWxlMGdyUWp0eWNiTFo5?=
 =?utf-8?B?Mnc9PQ==?=
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
	iQeKU0PoXmKaSStRZiEL3+zbTNcNwsn7Gth2zZBzIejBBww1LBFX9gsxbbBg69do3p8MGy6pdYwLJNYmw7y4KC5WCUbiTRY08cZpqgp/qj+lB5w7G/6GfS9iEJvp3SFxlMRnkiWx0R3Wr6KBJaYrP3CuQK0ueHKs27wOAS4Y3TtBOTCwNXYVtL9pqUG58LbBBdVQO8pVBr2W9eNV+4ESJg6XKlEhx80ogyvScJjq8H6c3bos1T2WeNURcwsEnrmIdXFzkk9boTxlYEjdpqndoKIA38FGvQDqBMAVt0nP+O0NwihiB3y5o6vfWhsTRWHlfiIBo2dVfX0Yry5RArAAhf0pibEfb4v8VflHfBhYXjILncGObnCqAQvETeA5DOMQfkne0qv5U/kHt+1XFm0L/ijYWOWQS5VtaW7yTl5qDWbx9KxxzdAPAnxdNgTwAPZEhE+JGAmP+FqUSY9XNR0X0E3nsgedfKiq3yxzGg2rUOVoQU/A+ktdO1aSiJLiiiYMK1peiepAW73YxkGpEgq9fzjH/l7+LKF4NdgGJ0+1c0q6qE+GR42s/DeV635a86KkMZU9U00PuxAM0a3tcfToKWN+6TvYsyFz6e1+2dqIZlDMnmvM8k4sGu7DLodgBBz8
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9617.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3c1a7d-f0bc-488e-6d1c-08dd104f80fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 08:26:20.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2kSNgbwMRJBdk/WQO9/BFty8AmJgbSQpmoKyKwcJifORCMJhojwZz3O3uBV2+2VWS34rYe26Cb32QnNX6YoQDF5EtBFaquWvR5i8is+ApQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8785

PiBPbiAyMDI0LzExLzI4IDEzOjQ2LCBUb21vaGlybyBNaXNvbm8gKEZ1aml0c3UpIHdyb3RlOg0K
PiA+Pj4+IE9uIDIwMjQvMTEvMjEgMTI6NTUsIFRvbW9oaXJvIE1pc29ubyB3cm90ZToNCj4gPj4+
Pj4gY29tbWl0IDQ0YjhmOGJmMjQzOCAoIm1tOiBtZW1vcnktZmFpbHVyZTogYWRkIG1lbW9yeSBm
YWlsdXJlIHN0YXRzDQo+ID4+Pj4NCj4gPj4+PiBTb3JyeSBmb3IgbGF0ZSwgSSd2ZSBiZWVuIHN3
YW1wZWQgcmVjZW50bHkuDQo+ID4+Pg0KPiA+Pj4gSGksDQo+ID4+PiBUaGFua3MgZm9yIHlvdXIg
Y29tbWVudHMuDQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4+IHRvIHN5c2ZzIikgaW50cm9kdWNlcyBw
ZXIgTlVNQSBtZW1vcnkgZXJyb3Igc3RhdHMgd2hpY2ggc2hvdw0KPiA+Pj4+PiBicmVha2Rvd24g
b2YgSGFyZHdhcmVDb3JydXB0ZWQgb2YgL3Byb2MvbWVtaW5mbyBpbg0KPiA+Pj4+PiAvc3lzL2Rl
dmljZXMvc3lzdGVtL25vZGUvbm9kZVgvbWVtb3J5X2ZhaWx1cmUuDQo+ID4+Pj4NCj4gPj4+PiBU
aGFua3MgZm9yIHlvdXIgcGF0Y2guDQo+ID4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gSG93ZXZlciwg
SGFyZHdhcmVDb3JydXB0ZWQgYWxzbyBjb3VudHMgc29mdC1vZmZsaW5lIHBhZ2VzLiBTbywgYWRk
DQo+ID4+Pj4+IHNvZnQtb2ZmbGluZSBzdGF0cyBpbiBtZl9zdGF0cyB0b28gdG8gcmVwcmVzZW50
IG1vcmUgYWNjdXJhdGUgc3RhdHVzLg0KPiA+Pj4+DQo+ID4+Pj4gQWRkaW5nIHNvZnQtb2ZmbGlu
ZSBzdGF0cyBtYWtlcyBzZW5zZSB0byBtZS4NCj4gPj4+DQo+ID4+PiBUaGFua3MgZm9yIGNvbmZp
cm1pbmcuDQo+ID4+DQo+ID4+IEFncmVlZCB3aXRoIE1pYW9oZS4NCj4gPj4NCj4gPj4+DQo+ID4+
Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gVGhpcyB1cGRhdGVzIHRvdGFsIGNvdW50IGFzOg0KPiA+Pj4+
PiAgIHRvdGFsID0gcmVjb3ZlcmVkICsgaWdub3JlZCArIGZhaWxlZCArIGRlbGF5ZWQgKyBzb2Z0
X29mZmxpbmU+DQo+ID4+Pj4+IFRlc3QgZXhhbXBsZToNCj4gPj4+Pj4gMSkgIyBncmVwIEhhcmR3
YXJlQ29ycnVwdGVkIC9wcm9jL21lbWluZm8NCj4gPj4+Pj4gICAgICBIYXJkd2FyZUNvcnJ1cHRl
ZDogICAgIDAga0INCj4gPj4+Pj4gMikgc29mdC1vZmZsaW5lIDEgcGFnZSBieSBtYWR2aXNlKE1B
RFZfU09GVF9PRkZMSU5FKQ0KPiA+Pj4+PiAzKSAjIGdyZXAgSGFyZHdhcmVDb3JydXB0ZWQgL3By
b2MvbWVtaW5mbw0KPiA+Pj4+PiAgICAgIEhhcmR3YXJlQ29ycnVwdGVkOiAgICAgNCBrQg0KPiA+
Pj4+PiAgICAjIGdyZXAgLXIgIiIgL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL21lbW9y
eV9mYWlsdXJlDQo+ID4+Pj4+ICAgIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMC9tZW1v
cnlfZmFpbHVyZS90b3RhbDoxDQo+ID4+Pj4+ICAgIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9u
b2RlMC9tZW1vcnlfZmFpbHVyZS9zb2Z0X29mZmxpbmU6MQ0KPiA+Pj4+PiAgICAvc3lzL2Rldmlj
ZXMvc3lzdGVtL25vZGUvbm9kZTAvbWVtb3J5X2ZhaWx1cmUvcmVjb3ZlcmVkOjANCj4gPj4+Pj4g
ICAgL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL21lbW9yeV9mYWlsdXJlL2lnbm9yZWQ6
MA0KPiA+Pj4+PiAgICAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTAvbWVtb3J5X2ZhaWx1
cmUvZmFpbGVkOjANCj4gPj4+Pj4gICAgL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL21l
bW9yeV9mYWlsdXJlL2RlbGF5ZWQ6MA0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBU
b21vaGlybyBNaXNvbm8gPG1pc29uby50b21vaGlyb0BmdWppdHN1LmNvbT4NCj4gPj4+Pj4gLS0t
DQo+ID4+Pj4+IEhlbGxvDQo+ID4+Pj4+DQo+ID4+Pj4+IFRoaXMgaXMgUkZDIGJlY2F1c2UgSSdt
IG5vdCBzdXJlIGFkZGluZyBTT0ZUX09GRkxJTkUgaW4gZW51bQ0KPiA+Pj4+PiBtZl9yZXN1bHQg
aXMgYSByaWdodCBhcHByb2FjaC4gQWxzbywgbWF5YmUgaXMgaXQgYmV0dGVyIHRvIG1vdmUNCj4g
Pj4+Pj4gdXBkYXRlX3Blcl9ub2RlX21mX3N0YXRzKCkgaW50byBudW1fcG9pc29uZWRfcGFnZXNf
aW5jKCk/DQo+ID4+Pj4+DQo+ID4+Pj4+IEkgb21pdHRlZCBzb21lIGNsZWFudXBzIGFuZCBzeXNm
cyBkb2MgdXBkYXRlIGluIHRoaXMgdmVyc2lvbiB0bw0KPiA+Pj4+PiBoaWdobGlnaHQgY2hhbmdl
cy4gSSdkIGFwcHJlY2lhdGUgYW55IHN1Z2dlc3Rpb25zLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBSZWdh
cmRzLA0KPiA+Pj4+PiBUb21vaGlybyBNaXNvbm8NCj4gPj4+Pj4NCj4gPj4+Pj4gIGluY2x1ZGUv
bGludXgvbW0uaCAgICAgfCAyICsrDQo+ID4+Pj4+ICBpbmNsdWRlL2xpbnV4L21tem9uZS5oIHwg
NCArKystDQo+ID4+Pj4+ICBtbS9tZW1vcnktZmFpbHVyZS5jICAgIHwgOSArKysrKysrKysNCj4g
Pj4+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbS5oIGIvaW5jbHVk
ZS9saW51eC9tbS5oDQo+ID4+Pj4+IGluZGV4IDVkNmNkNTIzYzdjMC4uN2Y5M2Y2ODgzNzYwIDEw
MDY0NA0KPiA+Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tLmgNCj4gPj4+Pj4gKysrIGIvaW5j
bHVkZS9saW51eC9tbS5oDQo+ID4+Pj4+IEBAIC0zOTkxLDYgKzM5OTEsOCBAQCBlbnVtIG1mX3Jl
c3VsdCB7DQo+ID4+Pj4+ICAgICBNRl9GQUlMRUQsICAgICAgLyogRXJyb3I6IGhhbmRsaW5nIGZh
aWxlZCAqLw0KPiA+Pj4+PiAgICAgTUZfREVMQVlFRCwgICAgIC8qIFdpbGwgYmUgaGFuZGxlZCBs
YXRlciAqLw0KPiA+Pj4+PiAgICAgTUZfUkVDT1ZFUkVELCAgIC8qIFN1Y2Nlc3NmdWxseSByZWNv
dmVyZWQgKi8NCj4gPj4+Pj4gKw0KPiA+Pj4+PiArICAgTUZfUkVTX1NPRlRfT0ZGTElORSwgLyog
U29mdC1vZmZsaW5lICovDQo+ID4+Pj4NCj4gPj4+PiBJdCBtaWdodCBub3QgYmUgYSBnb29kIGlk
ZWEgdG8gYWRkIE1GX1JFU19TT0ZUX09GRkxJTkUgaGVyZS4gJ21mX3Jlc3VsdCcgaXMgdXNlZCB0
byByZWNvcmQNCj4gPj4+PiB0aGUgcmVzdWx0IG9mIG1lbW9yeSBmYWlsdXJlIGhhbmRsZXIuIFNv
IGl0IG1pZ2h0IGJlIGluYXBwcm9wcmlhdGUgdG8gYWRkIE1GX1JFU19TT0ZUX09GRkxJTkUNCj4g
aGVyZS4NCj4gPj4+DQo+ID4+PiBVbmRlcnN0b29kLiBBcyBJIGRvbid0IHNlZSBvdGhlciBzdWl0
YWJsZSBwbGFjZSB0byBwdXQgRU5VTSB2YWx1ZSwgaG93IGFib3V0IGNoYW5naW5nIGxpa2UgYmVs
b3c/DQo+ID4+PiBPciwgZG8geW91IHByZWZlciBhZGRpbmcgYW5vdGhlciBFTlVNIHR5cGUgaW5z
dGVhZCBvZiB0aGlzPw0KPiA+Pg0KPiA+PiBJIHRoaW5rIFNPRlRfT0ZGTElORS1lZCBpcyBvbmUg
b2YgdGhlIHJlc3VsdHMgb2Ygc3VjY2Vzc2Z1bGx5DQo+ID4+IHJlY292ZXJlZCwgYW5kIHRoZSBv
dGhlciBvbmUgaXMgSEFSRF9PRkZMSU5FLWVkLiBTbyBob3cgYWJvdXQgbWFrZSBhDQo+ID4+IHNl
cGFyYXRlIHN1Yi1FTlVNIGZvciBNRl9SRUNPVkVSRUQ/IFNvbWV0aGluZyBsaWtlOg0KPiA+DQo+
ID4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCj4gPg0KPiA+Pg0KPiA+PiBlbnVtIG1mX3Jl
Y292ZXJlZF9yZXN1bHQgew0KPiA+PiAgIE1GX1JFQ09WRVJFRF9TT0ZUX09GRkxJTkUsDQo+ID4+
ICAgTUZfUkVDT1ZFUkVEX0hBUkRfT0ZGTElORSwNCj4gPj4gfTsNCj4gPg0KPiA+IE9rLg0KPiA+
DQo+ID4+DQo+ID4+IEFuZA0KPiA+PiAxLiB0b3RhbCA9IHJlY292ZXJlZCArIGlnbm9yZWQgKyBm
YWlsZWQgKyBkZWxheWVkDQo+ID4+IDIuIHJlY292ZXJlZCA9IHNvZnRfb2ZmbGluZSArIGhhcmRf
b2ZmbGluZQ0KPiA+DQo+ID4gRG8geW91IG1lYW4gbWZfc3RhdHMgbm93IGhhdmUgNyBlbnRyaWVz
IGluIHN5c2ZzPw0KPiA+ICh0b3RhbCwgaWdub3JlZCwgZmFpbGVkLCBkZWxheWVkLCByZWNvdmVy
ZWQsIGhhcmRfb2ZmbGluZSwgc29mdF9vZmZsaW5lLCB0aGVuIHJlY292ZXJlZCA9IGhhcmRfb2Zm
bGluZSArDQo+IHNvZnRfb2ZmbGluZSkNCj4gPiBPciA2IGVudHJpZXMgPyAoaW4gdGhhdCBjYXNl
LCBoYXJkX29mZmxpbmUgPSByZWNvdmVyZWQgLSBzb2Z0X29mZmxpbmUpDQo+ID4gSXQgbWlnaHQg
YmUgc2ltcGxlciB0byB1bmRlcnN0YW5kIGZvciB1c2VyIGlmIHRvdGFsIGlzIGp1c3QgdGhlIHN1
bSBvZiBvdGhlciBlbnRyaWVzIGxpa2UgdGhpcyBSRkMsDQo+ID4gYnV0IEknZCBsaWtlIHRvIGtu
b3cgb3RoZXIgb3BpbmlvbnMuDQo+IA0KPiBXaWxsIGl0IGJlIGJldHRlciB0byBoYXZlIGJlbG93
IGl0ZW1zPw0KPiAiDQo+IHRvdGFsDQo+IGlnbm9yZWQNCj4gZmFpbGVkDQo+IGRhbGF5ZWQNCj4g
aGFyZF9vZmZsaW5lDQo+IHNvZnRfb2ZmbGluZQ0KPiAiDQo+IA0KPiB0aG91Z2ggdGhpcyB3aWxs
IGJyZWFrIHRoZSBwcmV2aW91cyBpbnRlcmZhY2UuDQo+IEFueSB0aG91Z2h0cz8NCg0KVGhhdCB3
b3VsZCBiZSBncmVhdCwgYnV0IHRoZXNlIGZpbGVzIGFyZSB1bmRlciBzdGFibGUgQUJJIGFuZCAN
CkkgZG9uJ3QgdGhpbmsgd2UgY2FuIGNoYW5nZSB0aGVtLCByaWdodD8NCg0KaHR0cHM6Ly9kb2Nz
Lmtlcm5lbC5vcmcvYWRtaW4tZ3VpZGUvYWJpLXN0YWJsZS5odG1sDQpVc2Vyc3BhY2UgcHJvZ3Jh
bXMgYXJlIGZyZWUgdG8gdXNlIHRoZXNlIGludGVyZmFjZXMgd2l0aCBubyByZXN0cmljdGlvbnMs
IGFuZCBiYWNrd2FyZA0KY29tcGF0aWJpbGl0eSBmb3IgdGhlbSB3aWxsIGJlIGd1YXJhbnRlZWQg
Zm9yIGF0IGxlYXN0IDIgeWVhcnMuDQpNb3N0IGludGVyZmFjZXMgKGxpa2Ugc3lzY2FsbHMpIGFy
ZSBleHBlY3RlZCB0byBuZXZlciBjaGFuZ2UgYW5kIGFsd2F5cyBiZSBhdmFpbGFibGUuDQoNClJl
Z2FyZHMsDQpUb21vaGlybyBNaXNvbm8NCg==

