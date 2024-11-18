Return-Path: <linux-kernel+bounces-413085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCF19D1357
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405611F2349F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223B1BDAA0;
	Mon, 18 Nov 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="jQAlBrx0"
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E986F1B393F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940620; cv=fail; b=YpPiEftobLDgdFiZoGbRmAmp49BMTV6MLQXx2echhs8ocwxqasW3tA9/MUvzxKpVWR0ONWUzwfMpb955QVx2wfiFlxk2flvhZUU78cMXozfe+a58PO6irv/Sy7BJv4jGn9vAgCG47HqrHDsKrDaJgwx0aeOqMxqYtvSlV1rq8nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940620; c=relaxed/simple;
	bh=EkHX6LijXpVp8PnF3hdagKVy5Op7pRYUXJYtdKD16nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hd7TjwOfw0aSYeQgyWk1j/2oKKvngfYPuQsFnw2ZMyKYNzOMhuLZ1G7U5RIoXcKcYfLswe0X364EkRB64n0y24JzpiRELQ7WqsoK1JsbYkC+jrl2vb8Z5aCz4B88XD1IxobiIWPSCC+DSQlWfN0o9R6CG3W/pao1UNehHP26Fmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=jQAlBrx0; arc=fail smtp.client-ip=173.37.86.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1946; q=dns/txt; s=iport;
  t=1731940618; x=1733150218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EkHX6LijXpVp8PnF3hdagKVy5Op7pRYUXJYtdKD16nU=;
  b=jQAlBrx0pkBD1GFp2lDE23jqgh5AbcIXdlCG9EOJl4ytQjM8g6BDm1Up
   bDO8qkqwG0YdsZDHc5+Zox9LR/vvgsgO+ZJnGj1LdJ6npUiPUtmKEzlfV
   cjCTmnT6hXEbwTUsFXZ9fVpC+Fb6NrmwAjqTvftJ836/chUS8hGePJn2n
   g=;
X-CSE-ConnectionGUID: R2VvziSTTUOzFVexEtwtqg==
X-CSE-MsgGUID: 8o75/GDIQSaONqLJsN5NvA==
X-IPAS-Result: =?us-ascii?q?A0DRAwBCUDtn/5L/Ja1aHgEBCxIMQCWBIwuBclIHghKFH?=
 =?us-ascii?q?YNMA4UthlGCBCCFeoxxiywUgWoPAQEBDQJEBAEBhQcCFoo0AiY0CQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4YIhlsBAQEDEhERNw4QA?=
 =?us-ascii?q?gEIDgoCAiYCAgIOIRUQAgQOJ4VEAwGkQgGBQAKKK3qBMoEB4CAYgQIuiEwBg?=
 =?us-ascii?q?WyDfYR3JxuBSUSBFYMqPoQqg3SCaQSCQYUPJYETh2yJdpAVCUl7HANZIREBS?=
 =?us-ascii?q?wo1DDgrRiEsA4JHgjWBUoJGgRSDLoFeBTcKgwmBNDcCDQKCRXMfh2aBC4Nhg?=
 =?us-ascii?q?0WBGYFtghcdQAN4PTUUGwY9oz0+gWGCEpZTAUmvLQqEGqIjqjsuh1uQbppSi?=
 =?us-ascii?q?FOFWAIEAgQFAg8BAQaBZzyBWXAVgyNRGQ/YQIEzAgcLAQEDCZMBAQE?=
IronPort-PHdr: A9a23:HT76DhASGGkl6x7Ir1ZRUyQVXRdPi9zP1kY9454jjfdJaqu8us2kN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+hmG
IronPort-Data: A9a23:WmyBhauRl7h3fCCYohFcwARFBOfnVAFfMUV32f8akzHdYApBsoF/q
 tZmKT2AbviMNDOnLt4iYdy09U5U7ZCDx9BrHVQ+q3o2FX4VgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav656yEhjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGYjdJ5xYuajhIsvva+Esz1BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIwwLxJH3NPz
 sAkFRcfQC6Ol8+q366iRbw57igjBJGD0II3oHpsy3TdSP0hW52GG/SM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtJYH49tL/Aan3XfzReqV+RuqMf6GnIxws327/oWDbQUobaG5UOxx/A+
 woq+UypBU5Hc/Oz6AO++1WKn8vthgWmfpw7QejQGvlCxQf7KnYoIBkXU0ar5Pq0kEizX/pBJ
 EEOvCkjt64/8AqsVNaVYvGjiGSPshhZX59bFPc3rVncjKHV+A2eQGMDS1atdeAbiSP/fhRzv
 nehlNLyDjspu7qQIU9xPJ/Nxd9uEUD59VM/WBI=
IronPort-HdrOrdr: A9a23:v8waSaqDI7cnQBNmTnVJKh0aV5tXLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6H/BEDhex/hHZ4c2/h2AV87NDOW9ldAX7sSnLcKpAeQWhEWl9Qtmp
 uIHJIOcuEYYWIK6foSpTPIbOrIo+P3sJxA592uskuFJDsCA8oPnmUJbzpzUHcGODWubqBJba
 Z0k/A33AZIDk5nFvhTaEN1ONQrjue7567OUFotPTJiwg+Iij+j9b79FDal/jp2aVly6IZn21
 Lo1yji6Iuek9zT8HLhPmnogKh+qZ/E8J9uFcaMgs8aJnHHkQCzfrlsXLWEoXQcvPyvwExCqq
 iPnz4Qe+BIr1/BdGC8phXgnyP61iw11nPkwViExVP+vM3CQi4gAcYpv/MdTvKZ0TtlgDhP6t
 MM44urjesPMfoGplWk2zH8bWAsqqNzmwt4rQdctQ0EbWJUUs4gkWVWxjImLH5HJlO41Gjie9
 MeUP01I51tAA6nRmGcsW91zNO2WHMvWh+AX0gZo8SQlyNbhXZj0iIjtYYid1o7hdoAoqN/lq
 /5G7UtkKsLQt4dbKp7CutEScyrCnbVSRaJNG6JO1zoGKwOJnqI8vfMkfkIzfDvfIZNwIo5mZ
 zHXl8dvWkue1j2AcnL2JFQ6BjCTGi0QDyowMBD4JpyvKH6WdPQQGC+YUFrl9Hlr+QUA8XdVf
 r2MJVKA+X7JW+rAopN1x2WYegaFZDfarxihj8WYSP4niuQEPyeigXySoemGIbQ
X-Talos-CUID: 9a23:EAXqnG7yYr71Glf+KdsszhQqBNIkSUHh8VDCDXG1GUt1V6GMRgrF
X-Talos-MUID: 9a23:xfRUEAmA/Swj7pORB15UdnoyM5g1pIuCKXk2mLIgou2mLgotHSm02WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2024 14:35:48 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTPS id BB83A1800022E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:35:48 +0000 (GMT)
X-CSE-ConnectionGUID: C5CmWcMTTiu3lFKcizyYjQ==
X-CSE-MsgGUID: Nsz+7vgPTtmY3WylSs9K+g==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,164,1728950400"; 
   d="scan'208";a="40314147"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by alln-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2024 14:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glui9cVic29MRpGaWw1G52N54hkgo48+/qH3/VfgIvhAxJlhpG7NGbAs7F6IPFP0JPfxQlThVpzw7nN5JRoDmnOwZK4LBfXZJUPx/Hb/G++9nxoNXpI793PvWgY/csNy4jUtdKr3k5JOINQz7KhRFVlIm6oNpewt49KZf/HSXj7TQpBT79lbivfRPoou263gwVqpBSJWFv+JXVZhgF6mOs+hQSWeLnEwKAcXZi8yR/mIRNmN4kMOnsa7zV8b8BUfZdgbHb2KbC1UB8AeI/oxX+7FesB7T/RMCjg6NNadxCXdDS5EfdissoLCVDk2Tud39uc5LJaEBx64afJmqZytRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkHX6LijXpVp8PnF3hdagKVy5Op7pRYUXJYtdKD16nU=;
 b=FV8kbyVQByZopHnTwlrTtkxJ+TmnEVY4k5bC/uhN4UeYkg4p4DdzxrjQlrquwUJjtTckoQhCEETCE7+QC5p8Pt7K9xK8bjixddIj/ongmX5QHx9O6uIQLxJATOcxqWYLoNsE/bVl8QmUOqccpG4NJPbLVP7h9VVfwnyRLk8lYvhqhdzQgtt8KZF8YARJTFMTa/9coJjAIGToabz+ii/CFqc+CVfrcVBb1Pdmx+cK1m0PzqhiSHYrpjjJ8Vj5LDpjBKgKIx+LYWK9wL+HNruAk9StImQQCK60LVrLgUrREwlZ4NuhkQekcKiXqGkKraxqirKbR7Q9oiqLn3Joa4SfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 14:35:45 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 14:35:44 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hans de Goede
	<hdegoede@redhat.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, Klara Modin <klarasmodin@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danil Rybakov
	<danilrybakov249@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Topic: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Index: AQHbNeKxizzLej0qw02u6pHMIY1jfA==
Date: Mon, 18 Nov 2024 14:35:44 +0000
Message-ID: <ZztQwLpoZDZzbi6O@goliath>
References: <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com>
 <ZzTk5kyPa5kUxA+f@goliath> <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath> <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
In-Reply-To: <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|MN0PR11MB6134:EE_
x-ms-office365-filtering-correlation-id: e392daed-81d3-4943-3aef-08dd07de491a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFJNdGZPT2YwRTNzRjRtRGkydkVCRzR4SUx0Z2dnTFFFYm5FTEZPUXJWbEVv?=
 =?utf-8?B?cDEzTmE4ZXFYbG1sK3A3OENmbXdac3hYQjVrSW9KdWZtUitxOEJuRDJoNlFP?=
 =?utf-8?B?NXc4THZ1UWxKV1hBZmtRakJTbDRSYWlWU0NkdVp0S2NFRElQMXozT1dPeThr?=
 =?utf-8?B?KzJOYkQ0TUQwazNkdTJzWlRJdVQwSjJDWlpobmFKTUxhY2ZIMlM0UFNxaW1P?=
 =?utf-8?B?NFJCTWIvampBMHdaVklEL2FzMGxFNWZTbzNYeHRqTlFWaVViS0VEaDlUV0pp?=
 =?utf-8?B?Q3RRK1JhRFZnS05VLzdCaFhMWnRjSTF5ZTlpa1JRcmVpdG5qaURBdFdLVE8w?=
 =?utf-8?B?UHlmaDJqWTJPU3VOZXp6VjVsUDNmckRtaUNod2RDUVA5ZHR4U2dOM25SS1pu?=
 =?utf-8?B?RXV5dUlLWWUxbzh4ZFlGRjVpRlJ4SmUyQzNaMm5iQW1zWUNROVc5ZkJEdmc2?=
 =?utf-8?B?SjNsd2hvVjdkMllXblMyMnpRSDdxUDJVV2VEaHRjQWZGS3FmdHFnT2Q0UnpW?=
 =?utf-8?B?Z1VVL3hXakRzSUs0TTFUUUN0cFVVTWR2MEpTcWhxYmI5dkg0UmhvSm9jdVBt?=
 =?utf-8?B?VHlZT1Bia2tFN0krczN5MnBtdFFQRUszRVNjUURUTUhZWFlneTJxbUQ5MzZK?=
 =?utf-8?B?aDg1d1RZZThSWTVWQzJBbUhCd2Q1eFRzRlhMUnJOYjBXWmcxS2ZVTXM0azl5?=
 =?utf-8?B?TFVHU1NIMmVIRkczN1VROEo3Y1M2cmxQRWt4Ujd3UzlDdzQwSGVDRHpZTVp0?=
 =?utf-8?B?ekVWYjBiM052THllZ3B5bzBNVG5tNzFpUEdZNUlwMXV5MHBURTUzV1VPS2h1?=
 =?utf-8?B?eUppL0hZU3VCallnUWJPbnMySWQxRnZtejAzZ1FzWnptYTBZTnNhTlZpMDFJ?=
 =?utf-8?B?Q3l1VVVxY3NHZGZIcVVON3FtSk1pcFROc0haWnFnM25KRVNrNGxrWXExeE9n?=
 =?utf-8?B?TDJUeEhxZnhoekRxTU8xUW5CeVplNHRXNnUvTkpvd3RhVTk2aC9DcWE3elp2?=
 =?utf-8?B?eVR4dXpXTTZJa0VWdytVc3BpVzhDZEJaUUpoZ29hYk9mNDE2aEhJOVpqd3Ru?=
 =?utf-8?B?QlZWMWVTSDliQ0hYcENKaVl4VUdNLzZlcjhhc09mdTUvQUY4V3V0YlZBcjMx?=
 =?utf-8?B?UitHU251REdEUE4yWDkvZ2xKcnlXUVhDdG8wbTdCaWJDcmdYQ0RlcWxVQ0s2?=
 =?utf-8?B?Ykw3b2NaMjE3akZaYkNIMnhsdmhxWlpvTlNFbWV5TlVXY0pMSHhBQk5ZMkg3?=
 =?utf-8?B?RjdRbGdsVm1rQ2RMRnFqQUxmVGlxdnd1emdEL0Zhb1puNjJwZ2d3ckFDbDZv?=
 =?utf-8?B?b3M2V2FaRWppUlZkUEpLZUhhV09nQUl1Tm5jUXI5R0xCV3dFYk1nRDBac3JG?=
 =?utf-8?B?aTE4dFJBSEhwQ3Z1OGkrTWJIbFhheHJ2SVN6OVVQRnJQb1hEdk4reVVPamFV?=
 =?utf-8?B?MjIzaUhBWGQ3Qi9wVU5PVFBSc0o0TlBKOGVLeTljOWljWkFOdGllektXSjc2?=
 =?utf-8?B?Szdrd3pGNFgvdTdFMFlwMXd3THhNOWh1aGM5ajh3bHczSHJBeDU0bnMyZ3lY?=
 =?utf-8?B?R3hDVTczRjM1U0NTYVl1aVkrNWIvWGhVSVVIdG0vMWErSVp6bHFyUnhKOEFK?=
 =?utf-8?B?Qzk1bStJS1J1OVdyVU5LYmtJSGZTSjFUd1NROEJpZDRDdk5tc0hhUkx6TGhV?=
 =?utf-8?B?enNKM0FXQ284Z2N6TnJud0dhTWhHYUdJZS9vUWFnc0NFUWtFTWRyQ0ZLTlhK?=
 =?utf-8?B?ZVpYcm1FSnRGN1g4RlptMXpHa2ZQVzdodmQ3QlJYNG0rSEdhZ0hMVC9UQkJv?=
 =?utf-8?Q?Ed84lQhB96d/lWAvip80zIUmuOuub2WpXvpTY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHlxUlEvRlJoaGw1YTNiS01nbzdkblZGTXFvYldGTSthKzdHS1FYdlFZSGFm?=
 =?utf-8?B?c1hxb3NWUytTckYvS3NyTDdnK1QyRjNXT3ZHU2F3bTNWZG8wZDNkODN1U1Zt?=
 =?utf-8?B?aERGQ2pJbFExMVJvTEtyOVZWVnhSM1I4bDBrWDcvWWxHTG1QSW5wV0FvUEt1?=
 =?utf-8?B?YWhSTXNYVmVxLzV1OEtpeFlvRXpWSkhSaDlZVTRVL2xNUGRBNkZ1U2JYaUE3?=
 =?utf-8?B?TUVLQ2RlY0F4MnV4RkhnbG43NmJqbkQ0RE53em1GNk0vNVlvNy8weHRhK2pt?=
 =?utf-8?B?UVZ2akNTRS9tZmM2by9nQ1hZRDNKbjkzK3Nrajc1cUZJdDhXV2M1OUZpL3Vj?=
 =?utf-8?B?L1dpenJQenQyYjdVVG4xSk0zYVpJeVorSitMYllMaHk1aTdudFdLdVZTdGN0?=
 =?utf-8?B?TW9QVnFuMCszclIyWW9tZFEvb1ZiM1JlSHpZOExGYVNzK2laVGcxcGlvNHdG?=
 =?utf-8?B?M2xHOGt1SnNNaE1NYnlrYnRBa203cXJ2ZFNVMWlQYXFpenFEbDdUY2VnakFT?=
 =?utf-8?B?RTVZUVpzemZJRjIvc2V5Wldaa2IzL3NPOXlvcUpWWGpjUS93dnVSU1RuQnRI?=
 =?utf-8?B?REpncEJVZUdaam1BYmFxNTBIVkQyRWlkSmpFaDloRWtOOThJWk1URERKMDFu?=
 =?utf-8?B?UU15OExWNlNvS1krejY3N2VoYk43QUdubVZuOThWODFOVXI2RHNlWk53ZDJk?=
 =?utf-8?B?K0dmRm1iMkZDeURHMFh2TFpnVGo5MjNxbVNlaGdLWTU3VXZyVGZHeGcxdXdS?=
 =?utf-8?B?SnYrMlY0cTZzbkttbHF2TTFhdXlaZmJhVnJHYWhYMDVxeDh3YTdJVnRJR1pT?=
 =?utf-8?B?bk00cGJ0T0RJcEZJRXp6bVdNajBRK1NhTWY4SmNUVExFNGp5aGFOZXVnamwz?=
 =?utf-8?B?YnJvWTdzSUJWT2wvUkpnSkN6M1JWRURobUt2aUwwL25VZmlDNmcvRjlIYmNT?=
 =?utf-8?B?TFdnaDJGcDB2YXBvYVR5ZUhsT1kwZkNzcmdnVkh2NnBLV3pSQTU4YUlpb3N6?=
 =?utf-8?B?bnF6aWk5SXZFemwzN3RLS0ZYTWJOV3BoWkxQRzNUbC9YZEdrNFVEczVPQnhL?=
 =?utf-8?B?Q0VTUTNwQUNZV3FqRXZvN0kxSTNsMFA1T2hlSUZycC9ZL2JZM2NTMnhpSDhZ?=
 =?utf-8?B?d2krakcvcjgyUWVaN2dET3pVMk5QL2lYK3dLVFpXakhkSXRiekhQY21TVUFF?=
 =?utf-8?B?N1EvZFFWeHhaSVBFOGQ4K1JnWXhmT0V0cVlpSzF5aHRXa04wV28vbXB0SWJO?=
 =?utf-8?B?dkI2Y01lSGkvdmZVMFN0ZEMxK2xJSVBLNVkxQ1Zac1lDRXBnUzZ5bGN5c2kx?=
 =?utf-8?B?TXFBdkppMExLK3ZhMHRVZ0RmV2x2WXM2Mmtoc3VuYUF3eVBmcXo0cU1ZbG9o?=
 =?utf-8?B?dCtKcUlGWGQyZlE4QnhxdlVyS2VTc2J0T1c5S1V5bXl6UHJkNlZvWGpuN3hq?=
 =?utf-8?B?OXBOOTB1QlVQWjRaemJWUzhvdzJsWDNDN0RUTG4xSTNSVjRCQlZOTFlFRitE?=
 =?utf-8?B?OXJabjZUNDB6ZmRxVW9DcFNoQ2V0WGtyWUk3QURwMVdON2tMakFqZ05lTElj?=
 =?utf-8?B?ZFFtTUFsRUE5WG9LWnVZRGRhWkRUS3pOSnREdDBxOFc0T1d4SnZpRDkyVUtU?=
 =?utf-8?B?WWdvTndHZ21zc3NBeFZ0Z3A3S1lLQzZpNlduOS9QNi85MDJuV2swU0pPVGxr?=
 =?utf-8?B?Q09zWUhVTVNvQ0RycXVmNG1ydmhKN3lMQUJoQ3ZJaE1uR2piN1NFcUxlc2Z2?=
 =?utf-8?B?eFdWNUtqNXh6UlRpVWdHRThUQmphdkI4ZWtQY0Q2T09sMmtRcUZIUVNrUFdr?=
 =?utf-8?B?N2RkeHg0Y0pWSXlLRmZHNkcxcS9BOG05YXJZZDljc3JzTVpXUUtyTFZNU2FX?=
 =?utf-8?B?QjI4N3ROYUhUd3hJOW9YNHF3UGNTZnhyTUQvcnc2M3ZJSEZlR1RCZ1RqM01a?=
 =?utf-8?B?ZlBnZ295anI1cnFxMU5lMG9YTTNXR2pPV2ZaMTZ3SG9lKzN0UzFncFluUEx5?=
 =?utf-8?B?QWhjYWo1QnBYellLaTRmckw0c3dENHB4aWtqUXpURGlFQTBhMHB4TmlOY29R?=
 =?utf-8?B?ejQ5MVR5WnZKRHdBUXFoekZxVHFNUDBHS2ZuOXlaT2NRSkhySWpqRm80bE9W?=
 =?utf-8?Q?SBSCJNDu77nPkhgS/sF9O8YkQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <508424E57067254F8F117AF55F939616@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e392daed-81d3-4943-3aef-08dd07de491a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 14:35:44.6346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMUSXCRem1uJQujauq5Pd0T7ATzsMyHuL/bG+hSBuf2uAayDzQxTOb156OVOycm6nnWuB4cxKGhHL2L7sCiwZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com

T24gTW9uLCBOb3YgMTgsIDIwMjQgYXQgMDM6NDk6MzJQTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtv
IHdyb3RlOg0KPiBPbiBNb24sIE5vdiAxOCwgMjAyNCBhdCAwMTozMjo1NVBNICswMDAwLCBEYW5p
ZWwgV2Fsa2VyIChkYW5pZWx3YSkgd3JvdGU6DQo+ID4gT24gTW9uLCBOb3YgMTgsIDIwMjQgYXQg
MDM6MjQ6MjBQTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBO
b3YgMTgsIDIwMjQgYXQgMTI6NDA6MTZQTSArMDAwMCwgRGFuaWVsIFdhbGtlciAoZGFuaWVsd2Ep
IHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gQXJlIHlvdSByZWZlcnJpbmcgdG8gTFBDIEdQ
SU8/DQo+ID4gIA0KPiA+ICBJIGRvbid0IGtub3cgdGhlIGhhcmR3YXJlIHdlbGwgZW5vdWdoIHRv
IHNheSBmb3IgY2VydGFpbi4gSXQncyB3aGF0ZXZlciBkZXZpY2UgODA4NjoxOWRkIGlzLg0KPiAN
Cj4gVGhpcyBpcyBkZXZpY2Ugd2hpY2ggcmVwcmVzZW50cyBwMnNiLiBJdCdzIG5vdCBhIEdQSU8g
ZGV2aWNlIHlvdSBhcmUgdGFsa2luZw0KPiBhYm91dCBmb3Igc3VyZS4gWW91IGNhbiBzZW5kIHBy
aXZhdGVseSBtb3JlIGRldGFpbGVkIGluZm8gaW4gY2FzZSB0aGlzIGlzIHNob3VsZG4ndA0KPiBi
ZSBvbiBwdWJsaWMgdG8gbWUgdG8gdW5kZXJzdGFuZCB3aGF0IHdvdWxkIGJlIHRoZSBiZXN0IGFw
cHJvYWNoIHRvIGZpeCB5b3VyIGlzc3VlLg0KDQpIZXJlJ3MgYSBjb21tZW50LA0KDQovKiBJTlRF
TCBEZW52ZXJ0b24gR1BJTyByZWdpc3RlcnMgYXJlIGFjY2Vzc2libGUgdXNpbmcgU0JSRUdfQkFS
KGJhciAwKSBhcyBiYXNlICovDQoNCldlIGhhdmUgZ3BpbyB3aXJlZCB0byBhbiBGUEdBIGFuZCBJ
IGJlbGlldmUgdGhlIGdwaW8gbGluZSBpcyB1c2VkIHRvIHJlc2V0IHRoZQ0KZnBnYS4NCg0KU28g
dGhlIHBjaSByZXNvdXJjZXMgYXR0YWNoZWQgdG8gODA4NjoxOWRkIGNhbiBiZSB1c2VkIHRvIGFj
Y2VzcyBncGlvIG9mIHNvbWUNCnR5cGUuIA0KDQpJJ20gbm90IGEgcGNpIGV4cGVydCBidXQgb24g
dGhlIDE5YmIgZGV2aWNlIGJhciAwIHdlIHVzZSB0aGUgYmVsb3cgb2Zmc2V0IHRvIG1hbmlwdWxh
dGUNCnRoZSBncGlvLA0KDQojZGVmaW5lIElOVEVMX0dQSU9fUkVHX1JFU0VUX09GRlNFVCAgICAg
ICAgICAweEM1MDU3OA0KDQpUaGUgY29tbWVudHMgc3VnZ2VzdCB0aGlzIGlzIGdwaW8gNi4gSSB3
b3VsZCBzZWVtcyB5b3VyIHJlYWN0aW9uIHdvdWxkIGJlIHRoYXQNCnRoZXJlIGlzIG5vIGdwaW8g
b24gdGhlIDE5ZGQgZGV2aWNlLiBNYXliZSBvdXIgZHJpdmVyIGlzIGFjY2VzcyBncGlvIHRocnUg
cDJzYg0Kb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCg0KRG9lcyB0aGUgb2Zmc2V0IGFib3ZlIG1h
a2Ugc2Vuc2UgdG8geW91IGluIHRoZSBjb250ZXh0IG9mIHRoZSBwMnNiID8NCg0KRGFuaWVs

