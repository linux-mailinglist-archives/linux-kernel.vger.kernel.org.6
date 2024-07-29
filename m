Return-Path: <linux-kernel+bounces-264935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA993EA58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B421C213D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7823CE;
	Mon, 29 Jul 2024 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hD/f0+pq"
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7818F44
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722213526; cv=fail; b=QiOZi4D4iPNI1XpzcLxUUNWlMTepyEaVy2VHFMAFO8mtP2806Mn33L0k6q5ymR0VImuF+tQ3uHwW4MrIZAW9zTZoaG9WHnjBGCZjzqp32X9FYJWit65sHXSt7HVRQPi/hvDTOw+QF2H7OL07H835jwpvryQz31oiaqXOsVoDPnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722213526; c=relaxed/simple;
	bh=aw2Q2iONNCNe9XlzU47P51mELfqLYTsRwIr0nDsdW9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C+5yVg8HO2eD4odQtR7Xjp3aZAmXISc3u04bGDZLb79oacXpfl14NdTSR/ih35AAwH68SMwxcyDAClUc6+6ml/XJpw3NhwNJUjaSAFPk1UKe9RqPPcpVECiCZdRSWxyHgGgY5NfrBb1YItfSddz24ZaK3vm4V7wXmjXOKA/9GjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hD/f0+pq; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1722213523; x=1753749523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aw2Q2iONNCNe9XlzU47P51mELfqLYTsRwIr0nDsdW9Y=;
  b=hD/f0+pqokVA5SrruS93oLJSa9pZxtxNS5DGILeYQELxZO5776XyTZAu
   6QNnqL0fA/GPpjud1k2u52Y17nBBLP5o494qjdWJFzoHY8wF4riLl4D2R
   jg55/gfuDzmG6ZPaJiYWsmkhWleq2lqIBIawHMD8CXc0CKG05Y3PYoOyc
   tfL7BytJ4t/qoC0wo0P4+WFHkXn9ue73QCJ3J78Hb38mrZvd8QwXovOj2
   Jo08DlIWCSszGwjZaqGPJRWNZ280pXyX8AWcT5IZ6vmBREHuT3WLKB2Wr
   2opjw5/ufuMHhMpx2RVl67dJ+F0O6g0z2/4Tp4Qkd6+K5BBxFcNw5SAYG
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="127267732"
X-IronPort-AV: E=Sophos;i="6.09,245,1716217200"; 
   d="scan'208";a="127267732"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 09:37:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNYuVS/VVzzyVa00zW/DmfxZ93uu1/w/D9y8k3Wpd0EsclhIi0M8MvccjOyaNJE7kN9Hx33027tScb7vJoXCBEubhyApfFBLjKQHxzp+4brMGZz2snw+xYun7YxugcjrQb2wy+2zaUddJCS0Z5EEbbAiE1b0AgeQH/wSLUyyW8nxZLv8+Z84FYOIW0d5FqGlMIHNNt66J1oPskO5NA3PN6IfaAGnrSQ0IatXXvcn2FlgnIIY1OdCCnWXBkU/C4JZCsYQYE9vS14anYWAyHalo8hQ6yk5h49xpZkh8DHJOCToxnkds7C9VEixyfH273nAMtQDFT754ZvnI8uio/LFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw2Q2iONNCNe9XlzU47P51mELfqLYTsRwIr0nDsdW9Y=;
 b=I94ABbMehLx/eaqzT+DNLgqCiOCP5sxNMSmyOxiRZA5xltLrSIToJ1sFWJagv6nCuNvWCrGER+GDiOjU/TxjK/W6nUdyieS3GNqSvHQmBAe1DNQMvV+Be5gUpfFFXHs0eR3xqcJzuiaI3jwc4/sjLJyov2TkQrZ05m9cJ6Y2bGA/+Hkt7YieOzlBsbZ2ZqOaIKTLrfkpZe/UHpWOVFRGImtpFwJw7uPwbIPo4KhAeGt1ibCEvj8XlyTwU/LHdUtys8rStiwWf5BaY8TB4f8Qz/2KaymanDWzI0C1FnciDPTa6dfmHOUhwPC0qDTuVs/67+p4aB/OQYkw9w8dQMMhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY4PR01MB12635.jpnprd01.prod.outlook.com (2603:1096:405:1e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 00:37:27 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 00:37:27 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Michal Hocko <mhocko@suse.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar
 Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>
Subject: Re: [PATCH RFC] mm: Avoid triggering oom-killer during memory
 hot-remove operations
Thread-Topic: [PATCH RFC] mm: Avoid triggering oom-killer during memory
 hot-remove operations
Thread-Index: AQHa3zgpkku48clQz0iGM14ekjFxLLIIuvWAgAQlj4A=
Date: Mon, 29 Jul 2024 00:37:26 +0000
Message-ID: <fd6e84d5-9dba-47fb-a39e-1f7f0995fdf5@fujitsu.com>
References: <20240726084456.1309928-1-lizhijian@fujitsu.com>
 <ZqNpwz5UW44WOdHr@tiehlicka>
In-Reply-To: <ZqNpwz5UW44WOdHr@tiehlicka>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY4PR01MB12635:EE_
x-ms-office365-filtering-correlation-id: 1c9846a4-8c19-496a-62d3-08dcaf669e9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z00yUGlIVUxUQUNHclBPZUtZeFdpdnhiVVdxRDV4OEZMdGphcWppeU9xR3lz?=
 =?utf-8?B?OURsSXRsREpTbXlhdWhQSGVkV2RkcnlBbjJxVHpWbXd1MUhnc3o1c293K3JV?=
 =?utf-8?B?MHhjdDY2aUorWEZwT1pSYVlFeFlMQko3NFpZYmIwMUxmeGlhNGxpNHdDMkZC?=
 =?utf-8?B?amYweDBSOEl2NXpQU2NvS2hETlJHcjBQMjJiZllqb0FSK0V0czE0LzM3bjBW?=
 =?utf-8?B?QlVFdW1lM1dRZlZaS0hIQ0Nma1FGdWJjZFcyRWh2ejFXMUI5TFo5cmE0S2po?=
 =?utf-8?B?L2IzZ3V0VnpmTTVURFppKzlhNXZlbnVBd0tLcC9YZ3dRaG1WNTVZaHAvWDZE?=
 =?utf-8?B?M1FpeGsrNW9OME9nVklRZzVlKzBpdVRhcE05YkNNZ3FPeDA2bG16cHhGWEQ4?=
 =?utf-8?B?MmZyTXFKQldiMjk4d09XVGZKczYzaEFtZlBvV2Y4R0dTWHBvbWNCc24xNWFw?=
 =?utf-8?B?OTJRb0VEQnVEMFRIRHJ3OTFNcEhINkZVTncwNW81dElXbGx4NERBMjRYdWhF?=
 =?utf-8?B?TWhSb2JGZzQwS3BrOWV4WTRHdEI5a0V6cHJHMytmUWpSMlY3SmdEMEhtazZL?=
 =?utf-8?B?RVhqWlQyMHpiZktMeXgxdkw4VjdaVGh0bVRlcnZxa3RhdzkzVTRZVmlJdHpK?=
 =?utf-8?B?b1BQUHQvYk1RNS90d2FhYUl6UzdiaGcrbEs4VUVOaG1tb2FDeE91VHFwZGQx?=
 =?utf-8?B?ZjcyRGgyOFVXUEcvbjNMYnY4MkFoaHNmWGZTM0c1UFB6ZnI2KzN3ZWlqSTl6?=
 =?utf-8?B?dEdLaTFMYXIvRE1xYmR4blAwSG5WMlNQM3hLeXNvUjMzSnllalVFOEZlZC83?=
 =?utf-8?B?ZHJyQzVTRzF0dzBqemtldzEyZ0xoNzJFT21vbS9XVHViM01vcGxaN084OUNn?=
 =?utf-8?B?T01ubVB1V0JWbUdaUHk3UmNQMG1RQ1E0aStQSi83SDhuaXE1aUtmenptTkVj?=
 =?utf-8?B?Q1lNbXJHZ2dDRnlkWkdURGZSOFpUZUtTTVRrN1Y5RlBSQVg2RXVRZmxXVWhR?=
 =?utf-8?B?SGVaNUNEWUtjZUpKeHcrV3FqNHBRcW5rQ05yQUVuZk9TdTNndFd5eHdHaGJK?=
 =?utf-8?B?NmhRN1lzTDYveHJXSnljUVVjR1B1TWh1UU5janBTa0lkaUpUTFF2ekxCU1lO?=
 =?utf-8?B?VWtWOE5ESHZxbys3Zkc4cTJ0Z1MzNW1NMkRIeXhIczg1cjY3dytWTVlZOG5Q?=
 =?utf-8?B?SEl1U3dUT2dLYkYvUkxHR3Bna04vM2RnSlR1eEhiMFpEY2dMalM5a3pncDlv?=
 =?utf-8?B?RTlRV0RZOEo1STZMWVkvOHdsUXpHZ2pLcUNvcG5ENWZBYWVmcW9PRTA3bTly?=
 =?utf-8?B?dDlBVzVaVnNNei9IamJXWFVsOGVZWVJzbkYxdGNITWJPSWlGSG5xQ2t1dFJD?=
 =?utf-8?B?M2VKUU85SWdvd1l5SkRLWFZENExQV3FLZEtDRGpwS3dwRVhqc2p5aVNNdjBl?=
 =?utf-8?B?VC9wUmE5d1A4Sk1naXU5U1dGc3hjVGdKaUhTaFo0MnZCcTdjRkdObDVvLys0?=
 =?utf-8?B?UDdsZDFzUjhaQWUxbDc1amZIMlBmU2ZmUVlDUkNtbDd1MmhRKzdqRUxNNHho?=
 =?utf-8?B?dGRKakM1QlA1ZXhJdGhMUnpCTURnQXNCbUM3T1ZXNC80MTFIWXJDa2g3TmVD?=
 =?utf-8?B?OVRqQjFxQllJMjB4WXRQQU03b2tFYTFqNVcyeHEyYmZZRVN4K01mamczQ1E2?=
 =?utf-8?B?azVGZGFyUTJzUkR3V1BnM0dWaGo3YWluZi80OTFlbEpWQjlBWDRZWi9LVFNI?=
 =?utf-8?B?bzhRNkJ0NmlvblpWbk5sN0dFbGtzQlR4WEp5YzJROE5icWowNmRUSHlzYUpm?=
 =?utf-8?B?SGtOY1N4NTc2bUhhSjFqbmNNREZSWlROVFZkbkFucUdQcjE5WGxxR1lVUXRm?=
 =?utf-8?Q?jbK3UFrAGguWx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VU5tRC9rQzR6VWxLMW1XRTgrcHo1YnVhWHJGaldyZlc0cmtOUlloSVpUSUNM?=
 =?utf-8?B?WXlFKzF2TURIMGovclcxVC9iWWNFVW0yR05oUVhDQVNuK09acUgrYVhSWHhy?=
 =?utf-8?B?S0ZwNFFPNS95dWpNSmZSMzlnVjdva1ZXdUpZZEs4a1FvS1RpVlRHclRRSjNC?=
 =?utf-8?B?YlhBVk5WR0J4S0ZNcDU5YTZQV0FlV2VPbjA0Ynk4V0kwd2EzVkliTGc2QWFL?=
 =?utf-8?B?c0hiYWtoVkNEOGNSN1VNTkVGdGJTclp2OVZ5c3R5S3pPZVhGN0prMUFzRlFJ?=
 =?utf-8?B?a0lNVEl0Vm5EUVR4bmlmUlVGRldZTkZXcjlqazZoc01aYTV0R1dySUpVSW1V?=
 =?utf-8?B?cE1Vd0VtUHdZRzdmbDBJWXM5UGszMkpNTGVrTnBRZjB3SWNCQkNURVF6ckQz?=
 =?utf-8?B?eG82VjdzaE1mVW9najFtNXBGVlJFZURubmR0T3FFSDZHTUR2Q3ZqdmlFTkRS?=
 =?utf-8?B?bkVFQm5nTXllV3BWUytaL2owMnJtZXA2WFVTaHRlbnhVTmJMWU1NeDZDa01B?=
 =?utf-8?B?RDhlVWFGaTRhNUdqNFdiTDZ2Y0NXbzAvKytUYTMzVFdZV2NvRTBtRUNEZkZa?=
 =?utf-8?B?eFpSN3dpbTN3d2RRUVkva1Nxa2lHWXQ3ZFVtUmI4bWFzRXlONVRYUlZEZzBY?=
 =?utf-8?B?NHNESkQrU3Nod0VvRmlnb21odDlNWGtXT1FaOUhBemtadFgxUUZkMUwvdHI4?=
 =?utf-8?B?QW5QWTgrSG1ZNkdRUjFEbWdBeW1Mc2VhUG9lQ0E3WkNnZ04vWFVhWVFNLzhE?=
 =?utf-8?B?L2Noa25tSHBxb2FXL01IRWE5Y0dVdXdVQzRVZG9sTWJ4OFg0d3Qrem5RdWNz?=
 =?utf-8?B?Q1VuMWNnVEdYSEdyR05pbWJnK1R2UWpZTEdmUDZEL0hzQURmZmJYOVg1T1pD?=
 =?utf-8?B?VktRVWl1UkpYZVJKSVJBOERnU0V0REF5LzllNlpKOXhlVWlvTklsZnk2cGZK?=
 =?utf-8?B?WTl0ZTYvaDFoc3I5TXdmSVJoWU0vWDl1YnBFeVBTZGFJZzY2a1FHeGh5UWNZ?=
 =?utf-8?B?Z3Jtb3h0VDVrb2czY0N0YUZsVVpkUzdaNzZ0c2M3WDZ2bG9FKysrQkhLaW1T?=
 =?utf-8?B?S0ZQQUFvK2JuMDcxa0ZXSEs1MUdBOUpkMjdWQWx0U1IyNDI3dUpQalM1Y1VG?=
 =?utf-8?B?MzZWTVNreElYWDhIWFdGUXE3bEVNMjU0dEdRTldJNmNoVmNVVkN3STVrNmhz?=
 =?utf-8?B?aWlLNHBDK2FiOXdFZ0dSSFV0OE81NzNzWnRXcUJidXAxcTFZbmdUNWc4S1Zy?=
 =?utf-8?B?bmlHV3p3QzFndHdaQ0w5N1VCanFVSzJiU0RYc0JCKy80MzZRNEh0SUNGQWVB?=
 =?utf-8?B?S1ZLbTN5aG1wSEFWc3JpUzdFclM4cCt4di81ZFE3TUhuVmdITnowZmFtd2Rj?=
 =?utf-8?B?RjQvOHVoSlBzaFc4R1FDRE9PWHlPSDQ3U3IyajBNSzJsQUlKOVk0MStLazNP?=
 =?utf-8?B?OVg1Z1BFaWZobkFhcVF4Q0J5dVh6Mms3SEhha205UEZpYlc5VHdHSzdWMWhj?=
 =?utf-8?B?eWpzN0M4L2o5dkRqZXkzRGVpZ2tLejNmamlVQ1RyTDczcjlSSHFZSi9Cdjhx?=
 =?utf-8?B?eFhUelBhN1FnU0JYYU80VVZhWVJmVEl1UGtzMm5SWjlTWVU4NEwwMXpncDJw?=
 =?utf-8?B?ZVhVa1cyNnZVY3JMMDE1Ty9iaWQ2TGNxQkxMZzI1OFkzRm1UZGpUVU5wM1Fa?=
 =?utf-8?B?VWk4UG90RG5mc2RIeDUybmQyc2lXbUx1OHVJblJpay9WaERUU2hRQnFCV2M3?=
 =?utf-8?B?Y3FlaC9NUTlhUEx5R3dGcjNJenJWQkVkNEk4dGpDdHdIdG1HTE5WTUl2OEhX?=
 =?utf-8?B?VDdyU1BIVTZuUjFtTS8rbEdsS2t3YnRPY2ppdGNxSUgzRWQ0TStmbkhtUTBS?=
 =?utf-8?B?QWhzbHFqU3FRaGJ4Nnh4ODc3TC8vNFdtRzllc1QzSjBwS2IwWG9ZUVRIMWNq?=
 =?utf-8?B?eHNuVm5qUGdRSzlpemFEVTJRQjA5WXZrTkxpQXZIaHdDekxESjJTbUVkWHZk?=
 =?utf-8?B?ZDJ3YWUxSkRhQ2QvYnA2cWE2TnNtODR5MjlkTis1em1Yd2NYVDF4NHRhK280?=
 =?utf-8?B?aUtRTWNXU2RQeXVLVnZZQXhOVnZjUkJVQjZwOUVhWHZsYmZZc29QUTExVWdp?=
 =?utf-8?B?Nk1UNm1BUkk5NnpqY1htR2h6S1AxNUxPdk5aS0Z2WVZYZmJkNWg5V2JRTDNy?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A93FC6062E9D614EACB7DC3A5B1A5C34@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8X6UsCvIrnOcGvQ5rlYDMwt6a6b/BolerTWOrbudubDQj4ELhLKJaSljbfCf/vSM5eTSMtZrAvb1+M3a3gL5EbNxjhcwh49hcnKuGq20xECQfiM/fzvl3uXdyom0s8h0gBWC1X19cznkCu7z8YRwwm21oMzb75snIE+d+ep/CJGxBcbNbUzRd0Jj3dlAAi0d6HgZHmHiaNAsYe9Xf8UeRr/vp8KvL+Uynx5bYvE1uudvSuG+0amcjxlVG7OaGZvOMiefITX9Q870eN57ld2FC3fvmHfBdxbUb6qkW/hDWczteshPWTVpQOv/FoWj7/8zr4iop9nOJA50DkSzJqIb+JqBcEavG5MkOmG68W/YVSi9kRUg/amxDpG5CeiPzYsgGOnbf4ix+bVUsXBbjbyELNnkxolL+sS7s2FijbjwiTVm4QHjewoXeKNSrApCjLXFS/kDJt/Z6ng11v5ioJn7gwTioo9yPbCvVATsvoGzjBZrdh1yA3X7QTRLPQaIppPTrKurD52dh2deiupcj1usVvutXE9QEKqXlbCUVzx0wwsQvR9IO7B9gXgZuSJHLAlcfoNwQgi87/ksmIFpswrszTOO2VXpWqBlS/Zb7rjxv8SHqDYwTl0ieWq9oS2fzJE3
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9846a4-8c19-496a-62d3-08dcaf669e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 00:37:26.1886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQcxvZNFvrq+4pFnvKQNkhqmMQYPYvFr6aJ88bhujF2qLwAebbV5qHcDQZTqYWWuui0+mjUzcxlDxjEZmRG4rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12635

TWljaGFsLA0KDQpTb3JyeSB0byB0aGUgbGF0ZSByZXBseS4NCg0KDQpPbiAyNi8wNy8yMDI0IDE3
OjE3LCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+IE9uIEZyaSAyNi0wNy0yNCAxNjo0NDo1NiwgTGkg
WmhpamlhbiB3cm90ZToNCj4+IFdoZW4gYSBwcm9jZXNzIGlzIGJvdW5kIHRvIGEgbm9kZSB0aGF0
IGlzIGJlaW5nIGhvdC1yZW1vdmVkLCBhbnkgbWVtb3J5DQo+PiBhbGxvY2F0aW9uIGF0dGVtcHRz
IGZyb20gdGhhdCBub2RlIHNob3VsZCBmYWlsIGdyYWNlZnVsbHkgd2l0aG91dA0KPj4gdHJpZ2dl
cmluZyB0aGUgT09NLWtpbGxlci4gSG93ZXZlciwgdGhlIGN1cnJlbnQgYmVoYXZpb3IgY2FuIGNh
dXNlIHRoZQ0KPj4gb29tLWtpbGxlciB0byBiZSBpbnZva2VkLCBsZWFkaW5nIHRvIHRoZSB0ZXJt
aW5hdGlvbiBvZiBwcm9jZXNzZXMgb24gb3RoZXINCj4+IG5vZGVzLCBldmVuIHdoZW4gdGhlcmUg
aXMgc3VmZmljaWVudCBtZW1vcnkgYXZhaWxhYmxlIGluIHRoZSBzeXN0ZW0uDQo+IA0KPiBCdXQg
eW91IHNhaWQgdGhleSBhcmUgYm91bmQgdG8gdGhlIG5vZGUgdGhhdCBpcyBvZmZsaW5lZC4NCj4g
ICANCj4+IFByZXZlbnQgdGhlIG9vbS1raWxsZXIgZnJvbSBiZWluZyB0cmlnZ2VyZWQgYnkgcHJv
Y2Vzc2VzIGJvdW5kIHRvIGENCj4+IG5vZGUgdW5kZXJnb2luZyBob3QtcmVtb3ZlIG9wZXJhdGlv
bnMuIEluc3RlYWQsIHRoZSBhbGxvY2F0aW9uIGF0dGVtcHRzDQo+PiBmcm9tIHRoZSBvZmZsaW5p
bmcgbm9kZSB3aWxsIHNpbXBseSBmYWlsLCBhbGxvd2luZyB0aGUgcHJvY2VzcyB0byBoYW5kbGUN
Cj4+IHRoZSBmYWlsdXJlIGFwcHJvcHJpYXRlbHkgd2l0aG91dCBjYXVzaW5nIGRpc3J1cHRpb24g
dG8gdGhlIHN5c3RlbS4NCj4gDQo+IE5BSy4NCj4gDQo+IEFsc28gaXQgaXMgbm90IHJlYWxseSBj
bGVhciB3aHkgcHJvY2VzcyBvZiBvZmZsaW5pbmcgc2hvdWxkIGJlaGF2ZSBhbnkNCj4gZGlmZmVy
ZW50IGZyb20gYWZ0ZXIgdGhlIG5vZGUgaXMgb2ZmbGluZWQuIENvdWxkIHlvdSBkZXNjcmliZSBh
biBhY3R1YWwNCj4gcHJvYmxlbSB5b3UgYXJlIGZhY2luZyB3aXRoIG11Y2ggbW9yZSBkZXRhaWxz
IHBsZWFzZT8NCg0KV2UgZW5jb3VudGVyZWQgdGhhdCBzb21lIHByb2Nlc3NlcyhpbmNsdWRpbmcg
c29tZSBzeXN0ZW0gY3JpdGljYWwgc2VydmljZXMsIGZvciBleGFtcGxlIHNzaGQsIHJzeXNsb2dk
LCBsb2dpbikNCndlcmUga2lsbGVkIGR1cmluZyBvdXIgbWVtb3J5IGhvdC1yZW1vdmUgdGVzdGlu
Zy4gT3VyIHRlc3QgcHJvZ3JhbSBhcmUgZGVzY3JpYmVkIHByZXZpb3VzIG1haWxbMV0NCg0KSW4g
c2hvcnQsIHdlIGhhdmUgMyBtZW1vcnkgbm9kZXMsIG5vZGUwIGFuZCBub2RlMSBhcmUgRFJBTSwg
d2hpbGUgbm9kZTIgaXMgQ1hMIHZvbGF0aWxlIG1lbW9yeSB0aGF0IGlzIG9ubGluZWQNCnRvIFpP
TkVfTU9WQUJMRS4gV2hlbiB3ZSBhdHRlbXB0ZWQgdG8gcmVtb3ZlIHRoZSBub2RlMiwgb29tLWtp
bGxlZCB3YXMgaW52b2tlZCB0byBraWxsIG90aGVyIHByb2Nlc3Nlcw0KKHNzaGQsIHJzeXNsb2dk
LCBsb2dpbikgZXZlbiB0aG91Z2ggdGhlcmUgaXMgZW5vdWdoIG1lbW9yeSBvbiBub2RlMCtub2Rl
MS4NCg0KVGhpcyBvb20ta2lsbGVkIHdhcyB0cmlnZ2VyZWQgYnkgYWxsb2NhdGluZyBtZW1vcnkg
cGF0aCBvZiBvdXIgb3duIHRlc3RpbmcgcHJvY2VzcyB3aGljaCB3YXMgYm91bmQgdG8gbm9kZTIu
DQoNClNvIEkgZXhwZWN0LA0KLSBvdXIgb3duIHRlcyBwcm9jZXNzIGZhaWxlZCB0byBhbGxvY2F0
ZSBtZW1vcnkgZnJvbSBub2RlMiB3aGljaCBpcyBiZWluZyBob3QtcmVtb3ZlZCBpcyBhY2NlcHRh
YmxlLg0KLSBvb20ta2lsbGVyIHNob3VsZCBub3QgYmUgaW52b2tlZCB0byBraWxsIHByb2Nlc3Nl
cyBvdGhlciB0aGFuIHJ1bm5pbmcgb24gbm9kZTIuDQoNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LW1tLzZhMDcxMjVmLWU3MjAtNDA0Yy1iMmY5LWU1NWYzZjE2NmU4NUBmdWpp
dHN1LmNvbS8NCg0KDQo+ICAgDQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9saW51eC9tZW1vcnlfaG90cGx1
Zy5oIHwgIDYgKysrKysrDQo+PiAgIG1tL21lbW9yeV9ob3RwbHVnLmMgICAgICAgICAgICB8IDIx
ICsrKysrKysrKysrKysrKysrKysrKw0KPj4gICBtbS9wYWdlX2FsbG9jLmMgICAgICAgICAgICAg
ICAgfCAgNiArKysrKysNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWVtb3J5X2hvdHBsdWcuaCBiL2luY2x1
ZGUvbGludXgvbWVtb3J5X2hvdHBsdWcuaA0KPj4gaW5kZXggN2E5ZmY0NjQ2MDhkLi4wY2E4MDQy
MTVlMTEgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L21lbW9yeV9ob3RwbHVnLmgNCj4+
ICsrKyBiL2luY2x1ZGUvbGludXgvbWVtb3J5X2hvdHBsdWcuaA0KPj4gQEAgLTMzMiw2ICszMzIs
NyBAQCBleHRlcm4gaW50IG9mZmxpbmVfcGFnZXModW5zaWduZWQgbG9uZyBzdGFydF9wZm4sIHVu
c2lnbmVkIGxvbmcgbnJfcGFnZXMsDQo+PiAgIGV4dGVybiBpbnQgcmVtb3ZlX21lbW9yeSh1NjQg
c3RhcnQsIHU2NCBzaXplKTsNCj4+ICAgZXh0ZXJuIHZvaWQgX19yZW1vdmVfbWVtb3J5KHU2NCBz
dGFydCwgdTY0IHNpemUpOw0KPj4gICBleHRlcm4gaW50IG9mZmxpbmVfYW5kX3JlbW92ZV9tZW1v
cnkodTY0IHN0YXJ0LCB1NjQgc2l6ZSk7DQo+PiArYm9vbCBpc19vZmZsaW5pbmdfbm9kZShub2Rl
bWFza190IG5vZGVzKTsNCj4+ICAgDQo+PiAgICNlbHNlDQo+PiAgIHN0YXRpYyBpbmxpbmUgdm9p
ZCB0cnlfb2ZmbGluZV9ub2RlKGludCBuaWQpIHt9DQo+PiBAQCAtMzQ4LDYgKzM0OSwxMSBAQCBz
dGF0aWMgaW5saW5lIGludCByZW1vdmVfbWVtb3J5KHU2NCBzdGFydCwgdTY0IHNpemUpDQo+PiAg
IH0NCj4+ICAgDQo+PiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBfX3JlbW92ZV9tZW1vcnkodTY0IHN0
YXJ0LCB1NjQgc2l6ZSkge30NCj4+ICsNCj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgaXNfb2ZmbGlu
aW5nX25vZGUobm9kZW1hc2tfdCBub2RlcykNCj4+ICt7DQo+PiArCXJldHVybiBmYWxzZTsNCj4+
ICt9DQo+PiAgICNlbmRpZiAvKiBDT05GSUdfTUVNT1JZX0hPVFJFTU9WRSAqLw0KPj4gICANCj4+
ICAgI2lmZGVmIENPTkZJR19NRU1PUllfSE9UUExVRw0KPj4gZGlmZiAtLWdpdCBhL21tL21lbW9y
eV9ob3RwbHVnLmMgYi9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+PiBpbmRleCA0MzFiMWY2NzUzYzAu
LmRhMzk4Mjc1MWJhOSAxMDA2NDQNCj4+IC0tLSBhL21tL21lbW9yeV9ob3RwbHVnLmMNCj4+ICsr
KyBiL21tL21lbW9yeV9ob3RwbHVnLmMNCj4+IEBAIC0xOTM4LDYgKzE5MzgsMjIgQEAgc3RhdGlj
IGludCBjb3VudF9zeXN0ZW1fcmFtX3BhZ2VzX2NiKHVuc2lnbmVkIGxvbmcgc3RhcnRfcGZuLA0K
Pj4gICAJcmV0dXJuIDA7DQo+PiAgIH0NCj4+ICAgDQo+PiArc3RhdGljIG5vZGVtYXNrX3Qgb2Zm
bGluaW5nX25vZGUgPSBOT0RFX01BU0tfTk9ORTsNCj4+ICsNCj4+ICtib29sIGlzX29mZmxpbmlu
Z19ub2RlKG5vZGVtYXNrX3Qgbm9kZXMpDQo+PiArew0KPj4gKwlyZXR1cm4gbm9kZXNfZXF1YWwo
b2ZmbGluaW5nX25vZGUsIG5vZGVzKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgb2Zm
bGluZV9wYWdlc19zdGFydChpbnQgbm9kZSkNCj4+ICt7DQo+PiArCW5vZGVfc2V0KG5vZGUsIG9m
ZmxpbmluZ19ub2RlKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgb2ZmbGluZV9wYWdl
c19lbmQodm9pZCkNCj4+ICt7DQo+PiArCW9mZmxpbmluZ19ub2RlID0gTk9ERV9NQVNLX05PTkU7
DQo+PiArfQ0KPj4gICAvKg0KPj4gICAgKiBNdXN0IGJlIGNhbGxlZCB3aXRoIG1lbV9ob3RwbHVn
X2xvY2sgaW4gd3JpdGUgbW9kZS4NCj4+ICAgICovDQo+PiBAQCAtMTk5MSw2ICsyMDA3LDcgQEAg
aW50IF9fcmVmIG9mZmxpbmVfcGFnZXModW5zaWduZWQgbG9uZyBzdGFydF9wZm4sIHVuc2lnbmVk
IGxvbmcgbnJfcGFnZXMsDQo+PiAgIAkJZ290byBmYWlsZWRfcmVtb3ZhbDsNCj4+ICAgCX0NCj4+
ICAgDQo+PiArCW9mZmxpbmVfcGFnZXNfc3RhcnQobm9kZSk7DQo+PiAgIAkvKg0KPj4gICAJICog
RGlzYWJsZSBwY3BsaXN0cyBzbyB0aGF0IHBhZ2UgaXNvbGF0aW9uIGNhbm5vdCByYWNlIHdpdGgg
ZnJlZWluZw0KPj4gICAJICogaW4gYSB3YXkgdGhhdCBwYWdlcyBmcm9tIGlzb2xhdGVkIHBhZ2Vi
bG9jayBhcmUgbGVmdCBvbiBwY3BsaXN0cy4NCj4+IEBAIC0yMTA3LDYgKzIxMjQsOCBAQCBpbnQg
X19yZWYgb2ZmbGluZV9wYWdlcyh1bnNpZ25lZCBsb25nIHN0YXJ0X3BmbiwgdW5zaWduZWQgbG9u
ZyBucl9wYWdlcywNCj4+ICAgDQo+PiAgIAltZW1vcnlfbm90aWZ5KE1FTV9PRkZMSU5FLCAmYXJn
KTsNCj4+ICAgCXJlbW92ZV9wZm5fcmFuZ2VfZnJvbV96b25lKHpvbmUsIHN0YXJ0X3BmbiwgbnJf
cGFnZXMpOw0KPj4gKwlvZmZsaW5lX3BhZ2VzX2VuZCgpOw0KPj4gKw0KPj4gICAJcmV0dXJuIDA7
DQo+PiAgIA0KPj4gICBmYWlsZWRfcmVtb3ZhbF9pc29sYXRlZDoNCj4+IEBAIC0yMTIxLDYgKzIx
NDAsOCBAQCBpbnQgX19yZWYgb2ZmbGluZV9wYWdlcyh1bnNpZ25lZCBsb25nIHN0YXJ0X3Bmbiwg
dW5zaWduZWQgbG9uZyBucl9wYWdlcywNCj4+ICAgCQkgKHVuc2lnbmVkIGxvbmcgbG9uZykgc3Rh
cnRfcGZuIDw8IFBBR0VfU0hJRlQsDQo+PiAgIAkJICgodW5zaWduZWQgbG9uZyBsb25nKSBlbmRf
cGZuIDw8IFBBR0VfU0hJRlQpIC0gMSwNCj4+ICAgCQkgcmVhc29uKTsNCj4+ICsNCj4+ICsJb2Zm
bGluZV9wYWdlc19lbmQoKTsNCj4+ICAgCXJldHVybiByZXQ7DQo+PiAgIH0NCj4+ICAgDQo+PiBk
aWZmIC0tZ2l0IGEvbW0vcGFnZV9hbGxvYy5jIGIvbW0vcGFnZV9hbGxvYy5jDQo+PiBpbmRleCAx
NzgwZGYzMWQ1ZjUuLmFjZGFiNmIxMTRhNSAxMDA2NDQNCj4+IC0tLSBhL21tL3BhZ2VfYWxsb2Mu
Yw0KPj4gKysrIGIvbW0vcGFnZV9hbGxvYy5jDQo+PiBAQCAtMzU2Myw2ICszNTYzLDEyIEBAIF9f
YWxsb2NfcGFnZXNfbWF5X29vbShnZnBfdCBnZnBfbWFzaywgdW5zaWduZWQgaW50IG9yZGVyLA0K
Pj4gICAJaWYgKHBhZ2UpDQo+PiAgIAkJZ290byBvdXQ7DQo+PiAgIA0KPj4gKwkvKiBob3QtcmVt
b3ZlIGlzIG9uLWdvaW5nLCBpdCBnZW5lcmFsbHkgZmFpbHMgdG8gYWxsb2NhdGUgbWVtb3J5IGZy
b20NCj4+ICsJICogdGhlIGJlaW5nIHJlbW92ZWQgbWVtb3J5IG5vZGUuIExlYXZlIGl0IGFsb25l
Lg0KPj4gKwkgKi8NCj4+ICsJaWYgKGlzX29mZmxpbmluZ19ub2RlKCphYy0+bm9kZW1hc2spKQ0K
Pj4gKwkJZ290byBvdXQ7DQo+PiArDQo+PiAgIAkvKiBDb3JlZHVtcHMgY2FuIHF1aWNrbHkgZGVw
bGV0ZSBhbGwgbWVtb3J5IHJlc2VydmVzICovDQo+PiAgIAlpZiAoY3VycmVudC0+ZmxhZ3MgJiBQ
Rl9EVU1QQ09SRSkNCj4+ICAgCQlnb3RvIG91dDsNCj4+IC0tIA0KPj4gMi4yOS4yDQo+Pg0KPiA=

