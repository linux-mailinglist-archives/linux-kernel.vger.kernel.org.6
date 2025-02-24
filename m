Return-Path: <linux-kernel+bounces-528726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47426A41B78
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5679D3AE718
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F28F2566D7;
	Mon, 24 Feb 2025 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="M2/i5adZ"
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022113.outbound.protection.outlook.com [40.107.149.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C384FAD;
	Mon, 24 Feb 2025 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393761; cv=fail; b=Q1efM304b5TXO/f4CfG2TQXAKVD1z9ww6ejJqXUItFP+2eYl1x/bh1ucvXiANbC0mU4vZ+W4dDYI3IE/SigkOikm6qtiJfQu9Ek1uOuuoP2Pfglo6UkHREvfvCK42BwMQlFLBXOWPbJIN0u+D1ukW6M0mNq61A4u45t7RPLfTfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393761; c=relaxed/simple;
	bh=3NI3dKibZAT0hHaXQNOE/mF8Y5eObI+9XR7vc6DCcD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FJ7KCLNd2GSqSJ0rgxToHpJK9fWfuESZnb3jtOGabECU3jTMfFaz5L3crTnx9Xk7suxn/q8Si3tVGoJ6TIPGOnKx0UjtmW8R2DTpdwagjQiLC4JFK3j00dVs/LGwHAm6v3VYy6ocGsUKkW/smczOGo3FZGuHNxr5AZsLiFVfOs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de; spf=pass smtp.mailfrom=cyberus-technology.de; dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b=M2/i5adZ; arc=fail smtp.client-ip=40.107.149.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberus-technology.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLcjwUTYfGaSfyizcFSJTNfe/bb86yCXdE+oNM0ZmcJ4HeHjHOsFTpLMhdhtBW3v6xujRcRifdVcogNk/o4/IwQStLzAkkQq19+6jX9VC5f9h2EJuwm0yVuInJLWUnztPJnsp+n+byfQzuAghlOFhN/Xu6FQMcJx/Bo0Fi5MBIwUvKgc+uXgHx/pewQ5ElRuoAJZHbAEy5k/yjbSG4ftbKerpr6AZuesk0TqFeWFEwnMNtgY8xeBZAWjgeryJqe14sOjQFvSMe6dPn2PpSosOvtNwAT4OPgYFhNj3QBQlZCWYpcZN9ZIiDkINPM2LIkNvncGhwKED7fWR4xTp04phw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NI3dKibZAT0hHaXQNOE/mF8Y5eObI+9XR7vc6DCcD0=;
 b=ry0MycWOuGFhlLriOu+gvCOs9tCAv7KMb06GsceT+GCiH2Z9rKatJ54XlecSXVFdc63ofpedhK8t133oSR7rH/5w6OdllmVQnc/xMeIkT0dG4tisMWeiCHIyA6fhQao6SD0JwK0BQYORGUGXVbCiGQwfBUvTf19aHx4nZUfpa4fhWnfUV0oX69zNgee12WBHB3u0Ka4wdbWm19CyHLEyxJLWEHRnPx0JznM+LZkUJd4UBrawh2BZznpsgR1xXLOV45FW1ZlOHD2etaVZDGI/QMdvaaaMbiLc/SEIoT5xtczAQMKdfMB71ImHy5dJJPZiaeDrQe8/mvoD7CgUJxh7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NI3dKibZAT0hHaXQNOE/mF8Y5eObI+9XR7vc6DCcD0=;
 b=M2/i5adZjhAdH5z5ssu8iAwOl9z4Q34S0fuTK9M3msbh1n7BD+3eeYqZF9QnQQeOnGDJ/96ln/fYq2Y4M3cDJ1IJ8aNrM1oxxXNYe5pu7MCoxXpMeMPTahSlHdF1iYiOsatdlwyfyhv7QY3/kHqRufxbPwYl9fs+V0+rqGK+JNF5ql8dEVF2+9mVk/lQ9s6FqrTyhK4C3jlWDvmH2aimSShnLPCwwc1q+K5QT1yWEbLiH5YOSCxrA2PRWzY2j1mUk3qBPFZqDvXWiWtVXaiRLFCqBsd1EStVFfrv+vkFmBRbRORJXltsmLHgen0ixYBv22/ePz3Di0iIa4UPDNRTfA==
Received: from BEZP281MB2149.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::6) by
 FR4P281MB3623.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:db::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Mon, 24 Feb 2025 10:42:33 +0000
Received: from BEZP281MB2149.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2268:e9bc:a80f:9fba]) by BEZP281MB2149.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2268:e9bc:a80f:9fba%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:42:33 +0000
From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "willy@infradead.org" <willy@infradead.org>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: hugetlb: add hugetlb_alloc_threads cmdline option
Thread-Topic: [PATCH 1/2] mm: hugetlb: add hugetlb_alloc_threads cmdline
 option
Thread-Index: AQHbhGdjWeAtnKeFHUuk5+rD3de1V7NRxuMAgAAGtQCAAmPhAIACF0+A
Date: Mon, 24 Feb 2025 10:42:33 +0000
Message-ID:
 <cf53e173c1b7e2c5f801e4acaa0447c94f53051d.camel@cyberus-technology.de>
References:
 <20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de>
		<20250221-hugepage-parameter-v1-1-fa49a77c87c8@cyberus-technology.de>
		<Z7iFHkybeT4v8Jbo@casper.infradead.org>
		<eeb9d580a41cb314aba6ad21e751b506dc9cc434.camel@cyberus-technology.de>
	 <20250222184630.1f25865325eced9b0f37eb85@linux-foundation.org>
In-Reply-To: <20250222184630.1f25865325eced9b0f37eb85@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2149:EE_|FR4P281MB3623:EE_
x-ms-office365-filtering-correlation-id: 47b67f48-0ba4-436d-8a6a-08dd54bff243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?enBtbDZTOGdkdEdGM1pJQUc4OGl3MkVhcjB4dVphVE5WNm9YZGJrR1NGVXRx?=
 =?utf-8?B?aFNtck1XaFA2UnVSOVB5OWVjNmJPOXl6RVZKdlhnWDJxYkQzNUVCRENxdzkw?=
 =?utf-8?B?L3JNZDhwcEFyWVJwWFN3MlFhelMyQXVWTHVyMXVPd3EvekppL3BwTGpQM1NL?=
 =?utf-8?B?NERHZ1d6YUxtdWNsbXFjazNxaS8xV2hCZUttMldUdUI3cDhhSGRUaU8wZEcy?=
 =?utf-8?B?Q093bFlRTzNzVW5FZUs3ekhWOS9EUERJTnJieU1GNmxUVCsxak82czNqRTZ4?=
 =?utf-8?B?bytkMVdLOCtPV3pnRFZ4WVF4Vm1qYmc3dmxTSlRvaUZJbnhVekF6MWxnSDNB?=
 =?utf-8?B?NDdhTEdSNlZFbzQ3UXN0TEtmUzY3bkVVZXkyUklHWm40TFlwVWJsY0dqOGpP?=
 =?utf-8?B?R0Fubkt1amJRQzFiTGdrN0s2bWtqaW5jUkNIYURWREpRMHpMcUE5cmpUbmYw?=
 =?utf-8?B?c0NTYUQ3eTBIMXNvU1l2QnVOR2M3QTBIZ1J0MlZzNnRQNTNqb21lNVNML0Jv?=
 =?utf-8?B?cWttYkdwRUV0dkpZb0pSb2IrbXRsSVUvSCt6MTNNR0VOcnR1azZhZFFrWUlV?=
 =?utf-8?B?Y21hWlZmU3BLcEFDWmZTL0hvZ2RsME96QlBYTGhLWVg4TEZudGl6bi9Ucmoy?=
 =?utf-8?B?c3h1ZXYvL2xURzJZcHk1MGRGZ3NWMzNYeU1PZGs1SjRITHRsUEQwcG5XU3Vs?=
 =?utf-8?B?UW1DUU9uQ1QrdG84VjNMRkpWM2VhQ2x1RFZMVlVmUjA5S2NmT3o3ZDVPK0h2?=
 =?utf-8?B?aUJpLzM3Nmk0ZU5udmE1MGV5R3ZpTFVHQzRtVWQ0S0doeTNOR3d4YlRpZ0o4?=
 =?utf-8?B?TzNCWU0vZVFkbDQybDVuNmRUSUF1OVduc1NxeEhKYitXblR2SXBwT1RIOG9a?=
 =?utf-8?B?OEFod3lyeXVjSG5GNHFiL0xqbjhsMU5CZVNjbjZXWFdqSjFab0R3TlVuZ1pX?=
 =?utf-8?B?NVptMm9PWlRobnlnTVVMekRnMUh4NFRHemRzRGkrVThIUTE4RkVzOElSM1Zt?=
 =?utf-8?B?MXNYUmlpY2VkeCs4T29pT3RESDNXTTZrWFJNbE55UUs2ekV5QUI4UUdaYzVz?=
 =?utf-8?B?ZnJ1SnZtRVBHZUxIUjRVdHVwaURhTzlweGpUcGU1SVcxUUtwMituUnpjc0Rw?=
 =?utf-8?B?cjg5OXRMdm5keTYxcmNMZ0dablJqSGtjUjhrT1VHQWRjOW5FUllDKzlIVHRp?=
 =?utf-8?B?UVdWelpPNjRmOS9HYkFPeXlGMWJyOXFha2NNdU4ySWxUUDNNa1AxYjAvK2FQ?=
 =?utf-8?B?Z3p1a29ZdWt5Rjd6SnVSb3dsWnc3djRKOFR5NlRhR1hkN0FKNHhqVWFxTWRM?=
 =?utf-8?B?UzI5QnlxTXJHcVBqRk9TZG1iMFlMdFJPSUIzeWg1Qk1xSUQ4a2gxQm5hTHd2?=
 =?utf-8?B?VStJaDcwNmtJU1NsbUkwVjFPcFl3dEM3Sy9mSHkwNS92anFiWEN2ZTVKakJR?=
 =?utf-8?B?Q1Raa3ZvNG9nbkMreWFlcURzV3Q1QVlLL0M5OHJ4QzNSSHFkZ3Z2N0dkeE1P?=
 =?utf-8?B?RDkvZ0dtL0cybzFiWUI2OXNMQjcyQk9jdjVrcmlkVFhodWRTSDRMenh5L1hI?=
 =?utf-8?B?NzdiYXhiTHZDWlEzK1Y0Um9ISmVaNDdYTUJmMWtUTUp3eExjRnV1TTFNWktR?=
 =?utf-8?B?SXByWTlLd0lpYU80b0RDU2NKaDlVVUE3N1NoLys4d1FiNlRRNkR2TkM1YU1H?=
 =?utf-8?B?L2JHV08vcXB6aWlSOHM2MDByTG9lUWw0Q0pOMnI1anNZTStud2pXK2d5M1gv?=
 =?utf-8?B?UEdJMVdPUmNpbkFXMkJjT1d6YUhFKy9pS29XSXZadHo0aGRuQzQ1NVU2TVA0?=
 =?utf-8?B?cFNJTzJoZlZvdVBtOUdiY2pvajZBSVErS0h5NWFxQVJ0WENsdVRNcHIrUWVu?=
 =?utf-8?B?cm83OHN1OGRiTGRBdkt4K0ZvNU1SUXo0QTB6Ykc1V05tMWwwcXh1RUpZRlFG?=
 =?utf-8?Q?qYacqaMxEBXEkf7uakRSuVAFiFpMmyOO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2149.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWNISkFjZW5BeHZGU1RvMU1UOGdqREJyNXVNVWlkRVlCWkRETXNQWWtDT3VZ?=
 =?utf-8?B?STN4OS8wZHBRbVp4dnRsMlVXNUdmTmlHcXJQNHM5RHN3WXhJRDF1Z1lDK2Fu?=
 =?utf-8?B?R0w2TWg4L0cwaG1YNlMrL2x1M1B2NU1PVWdlNCtMRlJsSmRoM29aRVF6aWFw?=
 =?utf-8?B?Y0pzZ01MUXMrV3VLaGpjOWJBRmFFWFVsL1ZFV0NHYVhIMHlHMzFrL1B1NEJ3?=
 =?utf-8?B?ektuS2w5cVRoL0RsTEx2a2cwODlWVng0c3l4aVZNWEx3NENMc25qckhxUitG?=
 =?utf-8?B?ZUNreXZnL3pIbnVCSEFiZW9SdDlOVUtRS1NCNVcxTG9JOTllcnZhclA5S2Ey?=
 =?utf-8?B?MTU3bjFadFJ1V3p2UVdEYWhQVzZEU0JUSFlMc251WmQ5cklqSVJUT0ovT1h1?=
 =?utf-8?B?WDdJSmIrbloyRVNmWGxEU3BrMVdQSnFndzVwVHl3ejV4bmh0UGxlYnQ5bVY2?=
 =?utf-8?B?aXgzNW8rdW5XK1BUa1BiMm5vZjdpanFzbXhvMTY1dm0wbTQ4S1RBV0J3MmRI?=
 =?utf-8?B?ZGg1V3NpUnNKc25wYzFPSkh5VnNIdFNrNUdTRHJlYnkvQnZYd0crelNmb2lF?=
 =?utf-8?B?QjRYQnlzbFV2U0Zjc2pYUi9hUGVEZTFUZStwUUlCc0FsaERvQWVGTzFjT0tu?=
 =?utf-8?B?aS9EVzloT2dhaXI2eUdnVjRuZkJxdzhyWUZON050T3dDUU5kcjBkYS82LzhH?=
 =?utf-8?B?azg3ZmZ2MjV5c3BjY0gzMVZadVpFMDgvaGxRSjFaTVZNd0NpK3pUM1lnTVNw?=
 =?utf-8?B?L2cvd1hPYVEwZ1JHUTRFNXU3WlRLUHkvMDJLQXh6K2RWZ1dXRVY3Z0d1VEpj?=
 =?utf-8?B?RjdqeVNYZm1ycExSRkViMjUwTnN2Z3lYbmY5UnlkZEZzR0FLNjFvbXBzTWxM?=
 =?utf-8?B?QTR5NWJtMXo2VzVBdzQrei9hZjBOQWdyakh4Wkd6N0E0OXkxd2cvZThWUkJ3?=
 =?utf-8?B?MVEzR0Z3UVNxRkZIak9oTEpEV3VoZHFYQUxZQ1V6UkN6MlBpYytkdllmNFVG?=
 =?utf-8?B?NFpNbnkrNVZCdGZpTmdGVy9vVFJGWms3WjE1blhJbUZycXlIUlg2SWdxWFB3?=
 =?utf-8?B?OHlndzJCb01aeVFTWTdCSEhuUXlaWW4zSmZSb2dnMWRTSVUzYWpURE8rbkw1?=
 =?utf-8?B?Y20vZnRMVlBDa3Q0aURFZ0czN2hVQ0JQMXk1UHgrTDBDU3J4U0N5ZER5R1lP?=
 =?utf-8?B?dCtYeWdRZmlJSVNUNEFzSFJ6UThwUmltSFNTMDV4L1F5aFBDWDBIWW52QTZv?=
 =?utf-8?B?S3dJMVl4RGZVcmV5dnUzQUtKOWlzUWI2cTNkSWVsY1cybkVhd2JUekx0MEVq?=
 =?utf-8?B?VlZNUEpVbFdqUE4xcmxJcnBOTXpkYkZqNDJmNHBMTUxKVUZmbWlFcnpoZGtM?=
 =?utf-8?B?OXloSC9wdS9ncWUrVFFMcnA5YmxqeW1XTkVwbFNYTmR3bitWK0kxa2RMeTlK?=
 =?utf-8?B?YzVpWi9ONVNyQzZ5Nkw4NzFISDdwV3ZtRGtLQnU3UDJVNWVxRys4SldJeFVO?=
 =?utf-8?B?cWF5MVZHNWdmUG5IU1hhZjFqRno5Wjl6S21RSFVqQlNUbllDRGdlbnIrbVlC?=
 =?utf-8?B?N2hNWXdrUjR3bWlxSHR0azNLV05mZkIxbkRLQVFNakYrQlJlc1F3YlJDbG8v?=
 =?utf-8?B?Mk5xcXYrY0FjWGlQSHIzRjVHQlN4UjR3VFJEbUs3OE5TYkJtRDFTWFpOUFd1?=
 =?utf-8?B?VWl5RlFVWUhPOWI3NXBUQkpSekJhckhrQlIrUlpRbEtTYTdNWnp6WE9WUDBT?=
 =?utf-8?B?VXFtc3U2cmRsT1RtVnRkQ2tLcTRQSHdtV095WklOaDV0dWw4QjNVM1Y0Mjhj?=
 =?utf-8?B?UG5IVFI3NzBCL3NIdmZuRjNuWmJaNHhQYkVYQlRmcHAxUG5tVzF5bXErRVhu?=
 =?utf-8?B?dzFPMlA3UHp6S0tZb0RPRERzS200Skp0cm5jTUlPT3h4cG5ublFVOHlxZys1?=
 =?utf-8?B?OUpnN0xpTWU0Rm16bzlWd0p3SlVNQ09WbUhQamMrT1pVdUUwRW9jQyszQXFL?=
 =?utf-8?B?VVVuOWNtaThZcDg0L3VvZnBjSkFpa1hnazMrakUvWEFwNjUxVmFrSmVKc3hL?=
 =?utf-8?B?QUNQajllKzVSOFZORkFOOVBCaVZ3SmRQbTkwdDlFK2wwSnpWQTc3L0gvbXhZ?=
 =?utf-8?B?YTNPbnU5SzZzWkhrek9YL05wQkJnckpleVBTWEwreERZUnpFcTRQS2lFckpX?=
 =?utf-8?B?RHRwM3pSWE5uWitpZ3dYdC9mbzJoM09nVERKTXlqRXFPdVFwcHVLRGplWm45?=
 =?utf-8?B?NEJPQUhRUkY5eTd6VEZ0akQvQk5pSi9ZcktQSldYNVFSb1RaSVlGMmtkcnI0?=
 =?utf-8?Q?w7sb1neavdmooZQH6I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B2516A0CE472E4B99F0DC0034F1D7A7@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cyberus-technology.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2149.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b67f48-0ba4-436d-8a6a-08dd54bff243
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 10:42:33.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QO97IuMEErAufjQSgqbI8uqnyIsr8jGZ/Aiz7gpHOZCzOklwQJnFnF+Adnyfbegi/1BTb77ppabtr+/AWqz0Tnj/8pJhAh/oicIT1NFk8xc3vJPcyvNcS1Qr4Y364lsF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3623

T24gU2F0LCAyMDI1LTAyLTIyIGF0IDE4OjQ2IC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiANCj4gSSdtIGFsbCBmb3IgYXV0by10dW5pbmcgYnV0IHllYWgsIGZvciBhIGJvb3QtdGltZSB0
aGluZyBsaWtlIHRoaXMgd2UNCj4gcmVxdWlyZSBhIGJvb3QtdGltZSBrbm9iLg0KPiANCj4gQXMg
aXMgb2Z0ZW4gKGFsd2F5cykgdGhlIGNhc2UsIHRoZSBzYWQgdGhpbmcgaXMgdGhhdCBhYm91dCBm
aXZlDQo+IHBlb3BsZQ0KPiBpbiB0aGUgd29ybGQga25vdyB0aGF0IHRoaXMgZXhpc3RzLsKgIEhv
dyBjYW4gd2UgdGVsbCBvdXIgdXNlcnMgdGhhdA0KPiB0aGlzIG5ldyB0aGluZyBpcyBhdmFpbGFi
bGUgYW5kIHBvc3NpYmx5IHVzZWZ1bCB0byB0aGVtP8KgIFdlIGhhdmUgbm8NCj4gY2hhbm5lbC4N
Cj4gDQo+IFBlcmhhcHMgaW4geW91ciBbMi8yXSB3ZSBjb3VsZCBiZSBub2lzaWVyP8KgIA0KPiAN
Cj4gCUh1Z2VUTEI6IGFsbG9jYXRpb24gdG9vayA0MjQybXMgd2l0aA0KPiBodWdlcGFnZV9hbGxv
Y190aHJlYWRzPTQyDQo+IA0KPiBhbmQgd2l0aCBhIGZhY2lsaXR5IGxldmVsIGhpZ2hlciB0aGFu
IEtFUk5fREVCVUcgKGNhbi9zaG91bGQgd2UgdXNlDQo+IHByX2ZvbygpIGhlcmUsIGJ0dz8pLsKg
IFRoYXQgc2hvdWxkIGdldCBwZW9wbGUgY3VyaW91cyBhbmQgcG9raW5nDQo+IGFyb3VuZA0KPiBp
biB0aGUgZG9jdW1lbnRhdGlvbiBhbmQgZXhwZXJpbWVudGluZy4NCg0KSSBjb21wbGV0ZWx5IGFn
cmVlIHdpdGggd2hhdCB5b3UgYXJlIHNheWluZy4gU28gZm9yIHYyLCBJIHdvdWxkOg0KDQphKSBj
aGFuZ2UgdGhlIGRlZmF1bHQgZnJvbSAyIHRocmVhZHMgcGVyIG5vZGUgdG8gMjUlIG9mIHRoZSB0
b3RhbA0KdGhyZWFkcyBwZXIgbm9kZSB0byBtYWtlIGl0IGZhc3RlciBmb3IgZXZlcnlvbmUNCg0K
YikgbWFrZSBpdCBub2lzaWVyIGJ5IHVzaW5nIHByX2luZm8gaW5zdGVhZCBvZiBwcmludGsoS0VS
Tl9ERUJVRyAuLi4pDQphbmQgYWxzbyBwcmludCB0aGUgbnVtYmVyIG9mIHRocmVhZHMgdGhhdCBh
cmUgdXNlZA0KDQpBbnl0aGluZyB0aGF0IEkgYW0gbWlzc2luZyBoZXJlPw0KDQo=

