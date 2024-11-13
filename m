Return-Path: <linux-kernel+bounces-408230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A979C7C60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91198B24E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1085204923;
	Wed, 13 Nov 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MN0uD2Yp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eB/BRz/V"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C11D204012
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527457; cv=fail; b=gH5Q4j5wML90PlRNwaFFz5WGStspz9hIYjO3wQ/Z095nWtAoaqdCCj37SLGjQZJqL2WshQADLB38a7ExFhf+A7495IpQ2cyzCstJCYewX1M2N4QQfMdubtV/u7ZnZJkKhDSlKl9DEZk5h2pVdozePUHymrkREh5CVy3Qk9aGVPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527457; c=relaxed/simple;
	bh=7pE3cTiOyuwm55hcVj9hUwozV6t3uOlvfGT4t2V2NAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D4LxjJHTS8v2WVd9TDzKZsx6Q7or7oDSvjCE4YqPq6/Jy65Z+HgrRL6/UQDvsv028NsZj79JQeFwpst5J7APvnpd2PVoNg0eNw72xaR9Tvzlj60ehrWptMCKzFp2JKPCkbrjbUIQqCmtY7vXz63S6Ur3HpK+yuyAzolg9nHhpDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MN0uD2Yp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eB/BRz/V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBhP8010071;
	Wed, 13 Nov 2024 19:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7pE3cTiOyuwm55hcVj9hUwozV6t3uOlvfGT4t2V2NAM=; b=
	MN0uD2YpPWR4EfusKuKaaRB0/7mz75/zdTiqqCf0dLQ9Pdnfnt2bdpLKeZA9HXiu
	yXojKkcTMRgBZr3qMZuGcqpQtwlKLIbYKeuj3BfcgU+HcUexvSfmcisUOHECsL5U
	qkzjzl82iHYwWAoWvRe5bR4jsZutB2990E7qfE+Rk8UzCS1XKgBhBkVRjfuM0JFB
	Zq7EPjwbBb4Bw/EU7gaWSrvtEbgYG7XqwLbFHNclAHr1pbdUG2bC8EdrzL96OME8
	ONDRQ6OMKAIFMYUl1nyPbD2jv4sdivIfBBzOLgANwvj8XFBsG1ppkyQ7vP3qsEET
	a9n/hU1EylrdXC3JXqiYBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kbysua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 19:50:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADJ1DkW025914;
	Wed, 13 Nov 2024 19:50:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69t98g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 19:50:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syYbPbIOp+oTtMlx5uw9yTK1np51GyqUOLjWqqwzegEIRTsFC8LVv0Hxl8Nv7YjFj1MC4/DHGAla4apDHQZmVXod0+zvTC8xPzuowrKIIngrNxeGzAaOdm/4Ku7m9nDy0kzhzWXNq6SoQRG/rl/A7pw3VFXAXxC0owZCLsictjE5KQtSng2jlmqzv3ykLgaQWAYEhKNrZSv4W/VBe6Aq7XGYZ4vlnji61m1mDyRRQcJXDtfnIGsWlsFKnTo+uSczxrcY6SpTd3DpbdNldLuHR3YTILMlOOQ2htDFg6cfSB9qgcqAXJIX8zgHUyXeEmC/z0BAUNO5qYnUJD4ZwWaYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pE3cTiOyuwm55hcVj9hUwozV6t3uOlvfGT4t2V2NAM=;
 b=un4Hd1Y2MoHPSzyAPP4/pv/QedN4cPu3m5A/64djLhFPDsn5qLeCRrwrUtsWPc3iBCP9UbdeShhxUJ8+Umm9f6+u8i18Zu2u/2PnBKwAoj4KKCpYFrJmNpw2OP0wb3VIg0qT3ndiyEJa8J7L4R844670yKYfyx64KSGEiMTnsdh3Jx3nT/sFnq4XdoKevTvHghhGSsTTct73jWeHjpTTNMmRiyRO/rfNElJgcq4Fjhffeo8cYlQ5CdS9l2chIPmhFtHs5aA433qu8Mw3LdfKlGrRNjcoJ7r1bLPyFQUJ9xQdo02LVLsKiak5H1XXg2gQLSaoYgIn0edVQ0FhJr9zjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pE3cTiOyuwm55hcVj9hUwozV6t3uOlvfGT4t2V2NAM=;
 b=eB/BRz/VX7G8yTorRRTk98ucSuYQYTf+3DT7woNPkuv3rQCcggTjAjKHaaqosrjScPRtKUA82jBddbwKN3degKY6OjCDfIcn4TAIYciK1lBrXxwPe4qcmhes9eOrhwrthG8jFMbvBYbKuOqDZcNBbyic9RMPbvNyTH05A+QMJ4M=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by CY5PR10MB6093.namprd10.prod.outlook.com (2603:10b6:930:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 19:50:37 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 19:50:37 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Topic: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Index: AQHbNV85xP8mG8bGMUONwn7IqXYau7K1jv+AgAAQ1YA=
Date: Wed, 13 Nov 2024 19:50:37 +0000
Message-ID: <41887DDE-453B-482A-83DA-DD95F5C92D34@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
In-Reply-To: <20241113185013.GA22571@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|CY5PR10MB6093:EE_
x-ms-office365-filtering-correlation-id: e8be5d6b-503f-4dcb-9b56-08dd041c723c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?czlGcDl1dFRNTjh1N2Npa1ZBbHdWYUJ1bldmQTVHeG1mOGRkNU10djNlRzc4?=
 =?utf-8?B?UjlxSGJ1SHVNcVFPUUZkYkVZMzdrcGJ5eUMrdE0rM01EVkl3RDZPVmRjS24z?=
 =?utf-8?B?d3JybkZvN1haZHdUcU9BcCtmM2FPM21WdE9PR1dOMGZPY3R4TnBhcVVQRlRH?=
 =?utf-8?B?a1R5dGVhcVozbmNzUmNqWkdjNHJEanlocEltVFl6blI5NDRoNXErV2xhdDFY?=
 =?utf-8?B?UUVzQzRjUkQvbTVocmVmeEJraW5uWkZrK1VYdm5EZzdtZDdFRjdmWWkxbjZL?=
 =?utf-8?B?ZmU5emkzVUR2cXhJRnlNNlBGK0tCZlFKSE1hVUw0aG91a3FRc2JRc1hScUV4?=
 =?utf-8?B?ekRyb3hkMTlFa1hZaVRmVW50OEVlWm55bHE0akJWa051cm42MkpjZXdXbU1z?=
 =?utf-8?B?VlJ0UHB3bEdubVRvRlF3dmM3K3UxWU9JNk5yVmUrWXlwUXBBNklTUE5GbUEz?=
 =?utf-8?B?Mm5oSDcxRnBSZndYa3c3MTlON2YveVZ5a1hmbkFTZlhUMmpuWXJhWjJBMUV2?=
 =?utf-8?B?SkRhKzBRUWdjUnpqaHhyQXpDUXV6WnF3VVZXaVFncmpPN1lNN1dLRTVQTUNW?=
 =?utf-8?B?b0IzK1dRK1E4eTQ1cjFpU3VhaFUwY05hWHc0b2kvSmJlM0diam9hczAwWUl1?=
 =?utf-8?B?Zk1URlNNVU5iMVpEbUdvTTludmFJL1lSbXBoTHpSWDUrSXZYblBGemQrMkJB?=
 =?utf-8?B?MTU3VUZ2Z2JieU9YTVk4MDdmUXlBSmhsS2o3ZmpNbUZjbGhoWUxJWG5qdW52?=
 =?utf-8?B?aEg3NTd1eGZmUGQ1UjBzMC9VNlRkNWxZaUJGeTlSajZtb3k1Ukp1NVZNU1Yv?=
 =?utf-8?B?Y2x0TXk0TjR1bktzZGNzaVl3NmROb3JDMTIwc2Y3c09BdmVhZTl0WDJzaHo4?=
 =?utf-8?B?WnpZUi9KZWk0ZTlodlZWbnIweURmUUlkSUJlZ0VqYncrdjY2SmhuT3czcUFx?=
 =?utf-8?B?Y0pwZU9yQTNyZE5Qa29FV1JzaG53WDFpZDhwSlRZNHpzblg2M2ZFbGMwRGFV?=
 =?utf-8?B?dzlxOGtsWVIxQ3dJNVhjMThXOXNDUXVuNlVlNlBSa3p2WHJYRTY2V1RCaGdO?=
 =?utf-8?B?V2MrZXM3MldScndjd2NweFdBbnp4cVR2VlVyazRHcFQ5djhzWi9QbHdRblgr?=
 =?utf-8?B?UEUxSzdHQTdNcDZPRmY1WElxZTR3WE1ObUQ3b2Zkd0Z3amJZR1MvQ1hRMUg5?=
 =?utf-8?B?NDROTjVoVzZVU1JnbTNTOTY0SmlaTGpTSEdPMlNaN1Fjcmc3Q21ydWU0ZVpF?=
 =?utf-8?B?c2pzd3hqVmx5UmFFQUZaNVJWTGp4ditHSzZLNTVjSjREdmNaSDBRUE0wSGgy?=
 =?utf-8?B?SU1vMHRrWUVPbGVpcER4L1pWVUttTnk5cThNVkJpdkZiUXRVejhPSUtoMC9J?=
 =?utf-8?B?SGpMcDgxd3Bkc3YyZjZEOEM2TUlSclh6YUpiL0JRWC90WlRvVDlOVTVzYVRC?=
 =?utf-8?B?QUJqWkYrODBaV1NDbFEvTWRSekQ0TlB6eCs2RktOYUU0TFA2cXc1R1NoMkhE?=
 =?utf-8?B?SzRFN2hVdGlvMXZrQytjcy9abmJQWHZ2bFZYOVhmeVlhWUFaU3FhZU1MYWwy?=
 =?utf-8?B?L3V1RHRyTll1ZXdKVXU3d2tMcmRoenpaaEtzclE2SHdwTEJSRkM2eGZhUUps?=
 =?utf-8?B?WkVWSGsxT0NydUpVQ0dSN2MxZjBVM0ltdGF2NnNHdDM3Sks3SXlYcmhiV25N?=
 =?utf-8?B?RHBoUEUyaE8zWnFZV0VMN0UxTkx3NUlUTEhsckphbTY3RHdiNFNkWlJ5VnFa?=
 =?utf-8?B?THIyNHlQNkRXcUNFMGt6SEpoamFDT0VlNEVoQjVKdlczT20rSXlvWFVaSGk2?=
 =?utf-8?Q?QtPDjFQtSIjTUSqYCsQqqTd11AJpdopHO5U2s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkRJQ0pHQUNNNGNNL1hadHpPbmxJckx2aUxxcjBFNU9YOTVubmVTU2hCQkR5?=
 =?utf-8?B?N09teWZxMzNiTzRYc0VuVDZRYVhYZWE0OE5xQWt5RDVxWm5rOVlkaHozSk13?=
 =?utf-8?B?TmpwM2VuOGJvazF3VEpzQW5uTUpnWGxKY0R3eXNjOG13MWxPSjdvWWJ6VjdI?=
 =?utf-8?B?RkppNnZGbXZSOFdaNmI5dEE0bWNiang2RzFONkJESmpoeHpMRHpWZW84VFp6?=
 =?utf-8?B?QVhUclVwbStrTUFaeWZPdU0zMTMyNWlVVUlXcWJMeWJyOEFyRkdYbmtiTlVS?=
 =?utf-8?B?cDRqMERJNHRqMXRmU2VRd0QyRElhWFFKMUNFRE9sc0dsaVBQYmtJZXluYjJO?=
 =?utf-8?B?d0dwWmdEdVJudE56S2JzY1d5Sk5PMWRoT0VYTG1ObEptaWlHTWRiTDkxdldv?=
 =?utf-8?B?eFk2WjNHZHkyQ21rZVdvOGtUZkZIVU1NZUxWVmtRWGtXNG5XbERjTU9Td21O?=
 =?utf-8?B?SXA3ZTlWMEtlTmM5ZEViRzVtV3JxMnhtUWk3anUwR3pEbEVUV2dHOWRTVG1N?=
 =?utf-8?B?OTRzYnlQdC9XOXdjaWgvbHBzdzl6QkdhSjhDMm1KL2t3YlI5cHJ6WVVyT3N4?=
 =?utf-8?B?ZHhkNlZ6UEFOc01zM3VKZ2VOYnA3VTF1d3lhSjdpMXQ1VzRuK0g0OXVSOHZL?=
 =?utf-8?B?MHZSNnR3NTc4dXA5V3BtdGd2VXRWOUFJcDFRSTlWY0NCN0hWMlR0YjRUL21q?=
 =?utf-8?B?SWJoSVMwQi9HUUNQVUo1UU1kZXArMzlBbzJNZ1FhdkcrRHdpdU1XNG9ybGV4?=
 =?utf-8?B?bGZEMUIxeEQvMkJ4TCtmN053QTBLemZkUWhmRXN6YXdzaVBab3BLbE9EdEQw?=
 =?utf-8?B?aG1wK21yQU01Wk1PZlNJTmFPODBobEVtYXgwdW5kQzN5eVJBOWRtN2lJV3M0?=
 =?utf-8?B?NGhjenN5Q0kzM1VuSFpvYTFyQXc3ZXVoWVNlQTFDWSt5ME5IU0JYQ1NFYUZG?=
 =?utf-8?B?TW9vSGVmaGlCWmlrYjlTQmpPSWJmbFZ6TkhnNE5STkYzVDdQaE9FMnNGTWNi?=
 =?utf-8?B?aWxtN2UrNFB4bEVOQmMzUTZrTVRpT0dQWnEzWFdRZlZxYU9vYTV6emVKZjBj?=
 =?utf-8?B?TmhGSDRJOXE1cTI0cDUvc3pTQTVFOUY5dUZpbStKVDlRVzVBWnRzSXpzMDJx?=
 =?utf-8?B?TmtDQ21FWGJkOElUZEhtZ2hBMDNiZDQ3b0ZmVXg5ZU5rUGF0ckVudmovWUtB?=
 =?utf-8?B?djBXVkFoZ2hkY1J3b2hlTjI2M05iSmtEVlRyM3c5QlRkZEw0Z2kvMmt5ZWJU?=
 =?utf-8?B?cFFMOHpndk1GSGVkd2Nlb1hXK3MyR3g2bmtNdG1qT0hxWHNtMWNZbU9tQ210?=
 =?utf-8?B?N2dUUU5zbkJPZW84SXNrU0QvTXdyNDdJbzd0MTRzTTBnUDBHYWtGTUpCYmMv?=
 =?utf-8?B?WWJIemMvb01aSVBxUCtrSEpzL2xWYjgwWldGWFcvWTREZmpPcFBvT2taeDVn?=
 =?utf-8?B?Y01VcE1ZUVQ2bVJESHRheWIyVU5mMC9rRkFHV1VSQ3FFcmFUUVdEZExWVm1w?=
 =?utf-8?B?Y3FMazRnN2RyYnRnMUFCL0JrZWRlSWtDSk9abkp0eWhpY1NlaGhSMWtrQ2gw?=
 =?utf-8?B?YWVCSmZ3bnM5S3VLQ3dpUTdLc3haazRIS3hMRWY0NDVnSm5LTHNUTUpSLzRH?=
 =?utf-8?B?Q3RPeHJGanRtS2hoQ09TWGJvZ3daVzVENjFYeWZRWGRoQ3k4azVvblRoRisr?=
 =?utf-8?B?c08yOTU2Vkk3UjJVUlp2WUVkS2h5TW5EdXRuL2dlUEoxZEtUaStUMEFkL1hz?=
 =?utf-8?B?c3F1dENWaFUrRklEVHEyU3RiV1REVUZxKzdzTWJFdElQSE1xR3FNaVpVTFFG?=
 =?utf-8?B?NVk0M3JVRDFNN2tobFhrSDJXcmp0TGNnUkpMd3JrR3ZTNWpNYitCV21sMldu?=
 =?utf-8?B?U3R0REFMQy9xaU82RzU1aGw1UHRWeTdGNnJUSkM4RU9uZ3p6OTdWbzYybTFp?=
 =?utf-8?B?N2UrWk9PMXZrYjNjOG5vRjlQLzZmdUJ4Qm5MT2Y5YU8ycGhtTkFQVXlNQktm?=
 =?utf-8?B?WkFNSkhheWw4NkRETjVYOGsvL21kYTY3YkFLUVpjYkk2YUR2UmxhVjdza0ZK?=
 =?utf-8?B?YlZRRit3QXhWaGQ5OWR6OHRlYitzRThRR1RPa0k3eFh4eUhkUXAydzBVY1JV?=
 =?utf-8?B?UkZ4ajJ2VEtGVTNMVmUzbndVMkIzUldsVlMraW1aZmJUOGRSSGM2OWdOOEpF?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02BA9830C6AA3240BD55B8C7BC0A946E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/sjq6mBLXy6xGJbKbYghsBx8uOp78BbxCl0mJ5IPIhH8rwuTclvDSCynhsjMXQnhXjT/iyZ/e7t4pxnr5Uw9vPjEE9OdOR4VF0tZKbATxKK639ewulY6uaEfzkZdV/1xypJCioJTt+4CrCGlilIffkjL0Bn2nLCsbw4m3TK0nTTxH8AIyCJpD2+TEmDgu6gYcpVynnnog6haC2n/ABnJbua3Y8mHgcjVLD1BHFCbXYsNtS+pA/2thCUoeTIVegs/tuczRIHmqBuurY0kTIY+bgYoW7f2SpmxWHUimaI2miFKrYgjgpkx5WcRc1tZNMZL/7WB83O9g5ymyWpknXCtOfKDzWC8yFDQrELl8IwqIqpEHXO/QeFqPvQi46BgI+ZX8OYdIcrL0ZWE8jiuEvsA+3wE3+UZpPshUgfrSK09PRQYW/vtIl7QPO96iEBtYgdBRw3dqV0/a4vqyuQS1SWfLqnSg7sPoJj5H/zjfwztWVzh/0J9qJO6MgWOeqzHx/fIvyLYHtlMX9ohuDLkppvkRDNEKrppS1De7bZyzahKDk5T1zDzLL8vz5Yev0GOdGPLIuBafOQLV+ACCXq1/4PujnLi6etI9rqOjH3/rlxHzgE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8be5d6b-503f-4dcb-9b56-08dd041c723c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 19:50:37.8018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+xAYHWINlCiZyi5DBeIpq+GgDDdzeH11/eoWsUdnCBdFH2R1OjlzLD4WXx9jIB5qfkIqBVkDZgUOL868QqiTuyW+7DpgV7Hn2Jd2owdfEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_12,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=843 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130163
X-Proofpoint-GUID: X_zJn1R57o-seEKjIN2GbnUdKjwQkxG4
X-Proofpoint-ORIG-GUID: X_zJn1R57o-seEKjIN2GbnUdKjwQkxG4

DQoNCj4gT24gTm92IDEzLCAyMDI0LCBhdCAxMDo1MOKAr0FNLCBQZXRlciBaaWpsc3RyYSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBOb3YgMTMsIDIwMjQgYXQg
MTI6MDE6MjJBTSArMDAwMCwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4gDQo+PiBUaGlzIHBh
dGNoIHNldCBpbXBsZW1lbnRzIHRoZSBhYm92ZSBtZW50aW9uZWQgNTB1cyBleHRlbnNpb24gdGlt
ZSBhcyBwb3N0ZWQNCj4+IGJ5IFBldGVyLiBCdXQgaW5zdGVhZCBvZiB1c2luZyByZXN0YXJ0YWJs
ZSBzZXF1ZW5jZXMgYXMgQVBJIHRvIHNldCB0aGUgZmxhZw0KPj4gdG8gcmVxdWVzdCB0aGUgZXh0
ZW5zaW9uLCB0aGlzIHBhdGNoIHByb3Bvc2VzIGEgbmV3IEFQSSB3aXRoIHVzZSBvZiBhIHBlcg0K
Pj4gdGhyZWFkIHNoYXJlZCBzdHJ1Y3R1cmUgaW1wbGVtZW50YXRpb24gZGVzY3JpYmVkIGJlbG93
LiBUaGlzIHNoYXJlZCBzdHJ1Y3R1cmUNCj4+IGlzIGFjY2Vzc2libGUgaW4gYm90aCB1c2VycyBw
YWNlIGFuZCBrZXJuZWwuIFRoZSB1c2VyIHRocmVhZCB3aWxsIHNldCB0aGUNCj4+IGZsYWcgaW4g
dGhpcyBzaGFyZWQgc3RydWN0dXJlIHRvIHJlcXVlc3QgZXhlY3V0aW9uIHRpbWUgZXh0ZW5zaW9u
Lg0KPiANCj4gQnV0IHdoeSAtLSB3ZSBhbHJlYWR5IGhhdmUgcnNlcSwgZ2xpYmMgdXNlcyBpdCBi
eSBkZWZhdWx0LiBXaHkgYWRkIHlldA0KPiBhbm90aGVyIHRoaW5nPw0KDQpNYWlubHkgdGhpcyBw
cm92aWRlcyBwaW5uZWQgbWVtb3J5LCB3aGVyZSBrZXJuZWwgY2FuIGFjY2VzcyB3aXRob3V0IHRo
ZSBjb25jZXJuIG9mIHRha2luZyBhIHBhZ2UgZmF1bHQuVGhlcmUgY291bGQgYmUgb3RoZXIgdXNl
IGNhc2VzIGluIGZ1dHVyZSwgd2hlcmUgdXBkYXRpbmcgdXNlciBtZW1vcnkgaW4ga2VybmVsIGNv
bnRleHQgY2Fubm90IGFmZm9yZCB0byB0YWtlIHBhZ2VmYXVsdHMuICBGb3IgZXhhbXBsZSBpbXBs
ZW1lbnRpbmcgIHVzZSBjYXNlIGxpa2UgcHJvdmlkaW5nIHRoZSB0aHJlYWQgc3RhdGUsIG5lZWRz
IHRvIGJlIGRvbmUgaW4gdGhlIGNvbnRleHQgc3dpdGNoIHBhdGggd2hlbiB0aGUgdGhyZWFkIGlz
IGdvaW5nIG9mZiBjcHUuIA0KDQotUHJha2FzaA==

