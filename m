Return-Path: <linux-kernel+bounces-409813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79BC9C920E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966F52812C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A292019993E;
	Thu, 14 Nov 2024 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="m9vDp4dg";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="dGchHuwh"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F61D18A931
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610896; cv=fail; b=b6gHfRnVJv2+Etvo0rEJpCUuZxo7uyBE7aeSEO/RZwUgvRsuk6Hj04AwiSAz73JCvpa5QQicMLIVnmWPWFYHDBxErpT4hC4c4zKiTI4nDbNGifJ8HNpEuCRFCaUmXMHpmkYcMyzM2dSMsdSq5B7RlGDuQ9LdKuJgtw3izJwZUSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610896; c=relaxed/simple;
	bh=hP7TzrjHDiIxVT6CV/MmzOIMVfqZfioNvMK0ggHl6uE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BbZa5uu26HHXXKp1ysqLKsrtRaYRZYZ3y+3VNhp0HHAtDFyEJNjVKwEwxnedTWIIwij9r4on7ufX8L3X/oyWDdxC0qO1v+VyTiBEj/TLEPUAnoRYAfKR3Kbx2UxrvLiAZn1PRPFjZ6Kr3N0Eu2uGxYqblfRHQBpGqzLaefBxbGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=m9vDp4dg; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=dGchHuwh; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECN04f018019;
	Thu, 14 Nov 2024 11:01:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=hP7TzrjHDiIxVT6CV/MmzOIMVfqZfioNvMK0ggHl6
	uE=; b=m9vDp4dgWLu4ktBfqgN1i/HhM7NYI+nvkEE4STwX3S8GU4VGtCh3NPwWv
	6J7yp5Dz84k+N8Wcb0weoXBQn9JbXjXDbdlDc15C8fx9WlLOA7kIpXqEKVWV6EP2
	AWMYRsh8aIqHRVSZFB7vAyqTSQ6wJqpnYpeQIKlVmguan/0tz59kSDkeMH/T9Oaq
	Eqi5xr+4URDe7GMiqryn/IRFq34EEC+o3YEHHO228xwxT33EtZXwk20alyFGSkWg
	XQGzAS1JcVmyca8MxmqSs7h0Mm7G5KqCD49a2JNZS+r/c1dOsT4t57MwGKHAPiVU
	c+XXmJl+NLNgkfJoouSg1pUHdzM/w==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 42t65cwh38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 11:01:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhBT6wVnoS5s93ZBj3RfKgQ6ZVtpPtmbBJmqSRZ2GGHuh/FjadalQP627xCdd03SS+6mIW+ceUbOgZqHaGGg7f+BL92nhsnpLJwyHzz3qeNLWEjyjZ5QIMQkVcWW3sd7iXzVWa9UYDFEiX9Ks6vnrOOCMTXSQ2/3Od32WLyW+H5jeWkpmQh5qSKkrW9++GaBr5yPiu0THgGm3Hc2XtI9/iEb+Mjep8m9Kup5QlMfNJaGaAfoTyCjP3a/UVKVRq2RAaB8XU+gV00aeJ7Y8xT4uI34wRXhL56zKNOcwa7z3ua/YgojihTDWRswlitH+cO+evybB6QK62jQ77n1rYjKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP7TzrjHDiIxVT6CV/MmzOIMVfqZfioNvMK0ggHl6uE=;
 b=tuqRf5JgYQQIhFPO9NJkJ/Db4XCunDeGhVVU5B6+tjPvBv1ni0+YHZrfwhVuxcADzjfewQLI6RZiSk93l5pykHOWKmWquppSSwcKhUCjhf8ldlnDa6atmox76083Htya/GmiokRutA3Es+P6nIBNI7EbJ2sci0tmaJVQc1K5JbI8WjKVXKgTQjl7i4JE9Zt3zRQ4DWqH/rua1iniIwBpqr6+fM1P1/u2KGeCRNuA0D0xNtkghxYqvra6nSsQUr943iGQtX5B/LYiBgrTY3vtuO0KsBaRUeRvQYQ7XNQQut+cN/Q4yEQP1HC8Zr5wDTVL6T1877//lGsEq2aOw9CdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP7TzrjHDiIxVT6CV/MmzOIMVfqZfioNvMK0ggHl6uE=;
 b=dGchHuwhWpnxN7SNb1vl/RfybxJ4VC06wFUV5lBaEW/KL/zZUZp1Vg43xBg6xVHTcEaiRMuMSMBkClXqCDHjFjxrz8Y0ETGnax6dcAeZMy2ahkefoVXLWoq21+aphyzsrZ7JGMKyi5OccRog9JR9yh5h9xEdXO4BdWX7+WdpjEFSNnopZgrYgcFeQ/fve2O1S8e3hPpi6W8BraJnzDzGXRR435dXww9qn0lRCq+SKTriTpLn8jjqpCSWhhTuoJDZP/zncjnaUptss+N/M8CTRm+HErvMdz8CgwCLhWtUVU4MzF55yQ7clmqM6e5VEYNrSDMS6gkt7D6otbeC44+TfA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by MN6PR02MB10776.namprd02.prod.outlook.com
 (2603:10b6:208:4f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 19:01:14 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 19:01:14 +0000
From: Jon Kohler <jon@nutanix.com>
To: Phil Auld <pauld@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel
 Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: hoist ASSERT_EXCLUSIVE_WRITER(p->on_rq) above
 WRITE_ONCE
Thread-Topic: [PATCH] sched: hoist ASSERT_EXCLUSIVE_WRITER(p->on_rq) above
 WRITE_ONCE
Thread-Index: AQHbNrLrY3stAApnuEyg1Y5+VpJwEbK3INSAgAAA4IA=
Date: Thu, 14 Nov 2024 19:01:13 +0000
Message-ID: <0C4B7BAD-04EA-4F60-B6D2-A7B2C14E52B7@nutanix.com>
References: <20241114165352.1824956-1-jon@nutanix.com>
 <20241114185755.GG471026@pauld.westford.csb>
In-Reply-To: <20241114185755.GG471026@pauld.westford.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|MN6PR02MB10776:EE_
x-ms-office365-filtering-correlation-id: 4ef0f811-252f-48fa-2c52-08dd04deb614
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFhHMkJ1SHB5ZjRDWFE2QVd6UUJWK0RvU2V6bG1pMVJNemhpeFlmSWhKR1Zo?=
 =?utf-8?B?R2VLb3VKbVRPWEFFRDJkYlFMSXhaZlFaY0JMcHFXMXM5aGV1OHFSL3R5bkl2?=
 =?utf-8?B?a01MWmxQdnVITVlHMEVNRFArZkx6cnQxc21uTitjeUFQU01CU2JSMEQxUnhW?=
 =?utf-8?B?QVNISzc5V3BNZGRXUVdDNm9PZkJFNzNlNGx0V3RidC91UnN5WDRzZ3doNW5H?=
 =?utf-8?B?K0p3UUtpTWZCMFNQV2VKTXVrOGIrZ25ZRU14V3dGUmtNSk5XZmNGdDdzeE9R?=
 =?utf-8?B?dEo4Z1ZUYk0vc3J3Z01adE1qaU4wLzVMOVFIbVlPTnQ4Sm45WXhMYkVsS1JP?=
 =?utf-8?B?OTlSWk5OOHBDWFlZTy92VEZ4MUo0VDl6cTBqa1A0UHhZeWZlQ3VFV2RxWTM3?=
 =?utf-8?B?VGYvSWVzN1VtY1NqaFBpMzQvOGRzdkFXUloxTVU1M2dEL0Q3SmcvNTE4OWJr?=
 =?utf-8?B?N3Fvbk9XQlFMMTg2NkZweHNON2xOTTlSY1B3NjdFdVdFVHlmL1JiUU5udnF4?=
 =?utf-8?B?L2hWVTFxRnJlKzgrTUkwelZsa29DYmc0dFhIZGpkK01lL04ydmtEall2dWVH?=
 =?utf-8?B?NWVEeVZhRFVkRzFReGIreE44VnJDZWpYMTFnTzBDWWkwZjFpSW8xa3NPMVpv?=
 =?utf-8?B?ZGZtVmJ2NTM3emxVRTMreS9ENEFDYWFmNHVPd3c1RGVYWm1SOXFoYmpIN3pr?=
 =?utf-8?B?UmhjVzZ1T1Bib0picEhmcnNERUQrNVgrWXlBTnByOTh2cm1ORHRwS25ud0hX?=
 =?utf-8?B?ZThGRHl2dWFOcmlZZGp0UGd6NVJBQlRrYUFPZTNSOGk5d203NlRMbzBaeEpK?=
 =?utf-8?B?L0lRYnh0QzdOTmp0Z2MwT1BUZVl4bFBqUmcrblN5U3djazB2QldISmpQdnh6?=
 =?utf-8?B?WmVEYS9vQ2ZZU3NsNC9CclByQmw2VUJvWEN2a1V2czRtUjJFUSsyTkRiV05H?=
 =?utf-8?B?NCtRNzFzZUt1aFNKaFpBZUE0czdBWjh6TnVMM1VLOW9yVEhrRTk4eXlQK3d5?=
 =?utf-8?B?N1prZndsSE1GQzJMQzEyamR3RjgzOTFLcUZMaURhNEtrSGRrTFQ2eVY2cW1k?=
 =?utf-8?B?azlJVU1VZVpqbE13cFRuWGpBSDZ4Y044bHlCcUozMDIxNkxWcHhQbHJhNG53?=
 =?utf-8?B?alUzaloxeVk0Uys5QmcwUm04cTA0cmYzRDltbloxMjNLQWlVSTUvUjJydzRl?=
 =?utf-8?B?Y2EzVVNjTTR6N205d3dIUFB5TzN3UUpFc3lmSjVhMHVnWlVrQThxRXVFTWI5?=
 =?utf-8?B?MG9QOTBZb2VEdmVueWxQTFBXemF2K3JWTVVuYlNoUHdpS1NKamZYT2VHbWdS?=
 =?utf-8?B?UVp5U1N2clpjaDJXWmxjUnFHNDd6YUFCeFBySWdrSHZVWWUvdTlTMUFwYjJK?=
 =?utf-8?B?RStjTHVJQWxvOFY3T1YzaGFkZjk4eHBwWUZreTFjWmdmVE9YQnF6aURaclNz?=
 =?utf-8?B?OWh2NDJjM1l2bFgzVEpYUVU2bUVMVWxHbzlZV3l3UmNOT3MzZThqZTZFNXNL?=
 =?utf-8?B?dm5Oc2dEVXl4UFpib1hhZlZCaXIyL3c3NE16dWk2RWxmdGU1MkhuVTJVV3kw?=
 =?utf-8?B?VEFTRzBWYkY2TjdDa0R3V2ZnZFhqZEFSQnlOMnB5SU5VdkZrTGdsVHR3MnJQ?=
 =?utf-8?B?TTdZekVtU1hWTVJ3djJ5YXZVSEFHaVlCUlN1WXAxeGx4Z2dYb3lIT3d5MW5H?=
 =?utf-8?B?Q1UreC91U2JsRGg1L1lvdTZpVUhKcjRXNS9sUWxUZXBJK3VOZDE3M2NPeDU0?=
 =?utf-8?B?U2xZTUtYcUZ5UmhZYmh0aDdIaXNlcTljQmwrbGtwai9XZjByTmdITlBHNVRW?=
 =?utf-8?Q?fd1zbbxqCZWAR3Jb36Xn8jkx0Z5l86xjL6Crc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkpOVUovZnJCZkF5ZWdVRndJbWd3bWJBZ0pHNWYrcFlicXlOWTE1Nlh0THcz?=
 =?utf-8?B?N3oyVEp0WlpZVXNOTHRBd0dUQnBIbVpxTytqMXY4MDhXTDQzY2E2N09SNmtM?=
 =?utf-8?B?WmZ3L3hKditMM1Ivbzh5UDNaY0dMOXJEU3grTmptTkJUb0tYOGQwYUI0V1Ra?=
 =?utf-8?B?Snp4ZXRNUTRKSmNHbmI3N1I4KytUWE5SNjk2STNDN01iRU9uOFZVMXlmaVRJ?=
 =?utf-8?B?eTlRbGJVaFN2b3l0T0RtNEs3TnkrVU1Wc1FCVWpuS1A2OHZESzh4QkkyMks0?=
 =?utf-8?B?Z0Vqc1BOM0RIMmlzTkpXbVdiMnViSHpFUjloRTFGTklKRitHL0s0bEV3TGg4?=
 =?utf-8?B?VmlCYnUzVTNiZEdWak90S1cwRExhMk9ESktXMUdEMG5CQ0ZGNUZaK3JhVUNH?=
 =?utf-8?B?dllKeHRXN2QydFNZOEY4ZG5GNHNBMFpORnlsb2RUeFgycW03eVZHQWZrRWJH?=
 =?utf-8?B?SVNaQUQxaUtXL0cwYlU5TXFCQTF4YU1QTlhWblJBZHZtMzhiZy9mS0p3ODBn?=
 =?utf-8?B?aXJ6OG5ZVFlwS3dHVFJ0QXpoT1RBMzdMdE5GN0EwYVdKU0Q1SDNPcWlDOWtQ?=
 =?utf-8?B?SGZVS1dXd2tGZ0FEWEtGNnA0dUUwSEJKOVRITWE1Tk04NjlUN1JQSlA5MnRi?=
 =?utf-8?B?QjFGSzdLSGRielcrL2lDQWtyUm82REJmTnA0cUtHU0V0QUhpNnRscW1KYWFB?=
 =?utf-8?B?RVVieGVXVHR2bGc2azc4Nm02MDFsT25kellVaElYNzE2R0FCL0hjMUVMMVF6?=
 =?utf-8?B?SkJvQUxQamtCa21vU0JsNUNLeHhzSUE2TytWTDZuRkJ0Uy9HVXdzTHRnaHQz?=
 =?utf-8?B?OHYvUWRDZmhFS2d5YkFOSVR4N2dqYmh2UUE2Ukl2NkJ6a3ZLWDJxbk5XWXRJ?=
 =?utf-8?B?RXZxN2x1SGlVMkRsdURRcDhSUG91aWw5MHhQUTczY0Q2V0kweUFKbUhVQk4x?=
 =?utf-8?B?ZTZjLzRBdUF4cjZnZGlEMmVkRTh5UzZqdWhMaFhwYlBTb3VKNkJBRDBuN0xx?=
 =?utf-8?B?ZWc4YWliS0FDNWpEYVROT3lIS0poVzkzNWY3U1NjU3dOaitrOEd4L3QxQTAr?=
 =?utf-8?B?Q1VZL1lteGNYT0VQNTBIYVhNNnIxZDUwcS9xTUZvNGM1L3NWUFpqME9HYm0y?=
 =?utf-8?B?ZDFVL3BvU2dMZ2pLNUdHRHY0ZmoyUVpySUhhTEh4b0NTbU03M2NXKzBTTXBT?=
 =?utf-8?B?NzNHUDlGVGpSNld6dm8raERzazFKSWRJTWpYM3UybkIrYzdUbmZma2c5eGNt?=
 =?utf-8?B?aDFUc1BPQ3pCVXI1RVgyT3ZtY0dCTWk5dUd6K2hHcmxYTmhoM3lvNTdtU0lH?=
 =?utf-8?B?ckxvc0xzMDhkd2VIelFHOTAyWnVRcVJtRVhrZ21pTFZkRW91UXFxdVhiRWxn?=
 =?utf-8?B?bm0yWi9PWk5qTjFTS0xMZndHbnJydGtwQ25wNDVoTXl5aG1tMWx5R1E1V2hP?=
 =?utf-8?B?VGg5YkI1ODAxb1NNbzhpZmM4RXVzYW1ySzU5eFlJSUhFaHpNd2t3VndzV0Fr?=
 =?utf-8?B?c3BxdEw0K0dHeW5rMkRSVnFGbCtUeFVpcDRMemIzdkYwNVM4aG92bzNrcDhl?=
 =?utf-8?B?eFR3bWFoQTBSVVpreVV0enNqNlJocjFlclkxUjNKOFdQc1RlSzk5ajJXaTBQ?=
 =?utf-8?B?dFBGb3g4K3NDaFp3elYvbHFnZ2ZPNkZ5bXJXbm9RVVVkTjFXcURiYlNQMjRa?=
 =?utf-8?B?V3VFek55Szl1eWVRNHg3Snp6c1NTeWdlb3BhNCtieHJ1cHNUbFpxbk8yaUt3?=
 =?utf-8?B?aXcvU1oxZ0F1OHEwRUR2Zzg5dnhFWU1veUtiTWNubHM3UG1qWVlEdVZDQXRw?=
 =?utf-8?B?N081N2VHRWNBNG5UYWc1ejg5OTh2MDJ0VTlTSzFQaW91YkxqUEpqakxaRDls?=
 =?utf-8?B?ODgzSnhqQjlHQVFGT24rSnFTN2N4SFZ5VStIWVMzR3JRbk5aaXVITkpXR0h1?=
 =?utf-8?B?c0VBeXgxWHhQVElCejYxVVBoWDFHWGlzSGtUSm9XNzNKYlAwRVV6YnI2Y3Ji?=
 =?utf-8?B?VUFPQ0NSL1RlWElYY0g2cTlhQkR3UThSTzQvNG12OUl3djhRWlMrbjBtZkx3?=
 =?utf-8?B?dWRzV2k4dnFYVmFSakIwM05OU3I3OFZMOVo4MVR2RjdHZ3VMdDVIYldDL21N?=
 =?utf-8?B?M00rdkQ4aDJyUUo4VDlFT2pYcnFmK3Q2N2VIUzJmZXhQWVBFanhUdHFzL211?=
 =?utf-8?B?WEVwc1JZZ0c5WnRQNHZ3N1JtdDF0d3dOaEpYNi9NREF3S2VQTEhHRkhNMGRZ?=
 =?utf-8?B?Nk1Qa3VNOUNCbEUvVzZZOXViK0pBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27D99EAF259C874292F1D0031577912F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef0f811-252f-48fa-2c52-08dd04deb614
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 19:01:13.9988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNN1Jo7ofodVxIu5XUQZZcxnH+Z8e0ragL5tux9mvPFmD5PGaEoTEgijk0x2XsY1nOwPSgPXf/rm2Ptd4fjX7Hzls9GFJyH33D2Lfz4lW2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10776
X-Authority-Analysis: v=2.4 cv=LOM0Q4W9 c=1 sm=1 tr=0 ts=673648fd cx=c_pps a=iOysuCQqHAn0ffzU2nlaNQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=OzaymcDKMH39rIhS7Q0A:9 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: 5UxCW7HeAth-isEUfdRz3-nmghFxxGB0
X-Proofpoint-ORIG-GUID: 5UxCW7HeAth-isEUfdRz3-nmghFxxGB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDE0LCAyMDI0LCBhdCAxOjU34oCvUE0sIFBoaWwgQXVsZCA8cGF1bGRAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJT046IEV4dGVybmFs
IEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIFRodSwgTm92IDE0LCAyMDI0IGF0
IDA5OjUzOjUyQU0gLTA3MDAgSm9uIEtvaGxlciB3cm90ZToNCj4+IEluIHthY3RpdmF0ZXxkZWFj
dGl2YXRlfV90YXNrKCksIGhvaXN0IEFTU0VSVF9FWENMVVNJVkVfV1JJVEVSKCkgdG8gYmUNCj4+
IGFib3ZlIFdSSVRFX09OQ0UocC0+b25fcnEpLCB3aGljaCBtYXRjaGVzIHRoZSBvcmRlcmluZyBs
aXN0ZWQgaW4gdGhlDQo+PiBLQ1NBTiBkb2N1bWVudGF0aW9uLCBrY3Nhbi1jaGVja3MuaCBjb2Rl
IGNvbW1lbnRzLCBhbmQgdGhlIHVzYWdlDQo+PiBwYXR0ZXJuIHdlIGFscmVhZHkgaGF2ZSBpbiBf
X2Jsb2NrX3Rhc2soKS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogSm9uIEtvaGxlciA8am9uQG51
dGFuaXguY29tPg0KPj4gLS0tDQo+PiBrZXJuZWwvc2NoZWQvY29yZS5jIHwgNCArKy0tDQo+PiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBk
aWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2NvcmUuYyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMNCj4+
IGluZGV4IGExYzM1M2E2MmM1Ni4uODBhMDRjMzZiNDk1IDEwMDY0NA0KPj4gLS0tIGEva2VybmVs
L3NjaGVkL2NvcmUuYw0KPj4gKysrIGIva2VybmVsL3NjaGVkL2NvcmUuYw0KPj4gQEAgLTIwNjYs
MTYgKzIwNjYsMTYgQEAgdm9pZCBhY3RpdmF0ZV90YXNrKHN0cnVjdCBycSAqcnEsIHN0cnVjdCB0
YXNrX3N0cnVjdCAqcCwgaW50IGZsYWdzKQ0KPj4gDQo+PiBlbnF1ZXVlX3Rhc2socnEsIHAsIGZs
YWdzKTsNCj4+IA0KPj4gLSBXUklURV9PTkNFKHAtPm9uX3JxLCBUQVNLX09OX1JRX1FVRVVFRCk7
DQo+PiBBU1NFUlRfRVhDTFVTSVZFX1dSSVRFUihwLT5vbl9ycSk7DQo+PiArIFdSSVRFX09OQ0Uo
cC0+b25fcnEsIFRBU0tfT05fUlFfUVVFVUVEKTsNCj4+IH0NCj4+IA0KPj4gdm9pZCBkZWFjdGl2
YXRlX3Rhc2soc3RydWN0IHJxICpycSwgc3RydWN0IHRhc2tfc3RydWN0ICpwLCBpbnQgZmxhZ3Mp
DQo+PiB7DQo+PiBTQ0hFRF9XQVJOX09OKGZsYWdzICYgREVRVUVVRV9TTEVFUCk7DQo+PiANCj4+
IC0gV1JJVEVfT05DRShwLT5vbl9ycSwgVEFTS19PTl9SUV9NSUdSQVRJTkcpOw0KPj4gQVNTRVJU
X0VYQ0xVU0lWRV9XUklURVIocC0+b25fcnEpOw0KPj4gKyBXUklURV9PTkNFKHAtPm9uX3JxLCBU
QVNLX09OX1JRX01JR1JBVElORyk7DQo+PiANCj4+IC8qDQo+PiAqIENvZGUgZXhwbGljaXRseSBy
ZWxpZXMgb24gVEFTS19PTl9SUV9NSUdSQVRJTkcgYmVnaW4gc2V0ICpiZWZvcmUqDQo+PiAtLSAN
Cj4+IDIuNDMuMA0KPj4gDQo+PiANCj4gDQo+IFRoaXMgbG9va3MgZmluZSB0byBtZSBhbmQgaXQg
bWFrZXMgc2Vuc2UgdG8gaGF2ZSB0aGUgYXNzZXJ0IGJlZm9yZSB0aGUNCj4gd3JpdGUuICBBIHF1
aWNrIGdyZXAgc2hvd2VkIHRoYXQgdGhpcyBpcyBieSBubyBtZWFucyBhIHVuaXZlcnNhbCBwYXR0
ZXJuDQo+IGF0IHRoZSBtb21lbnQuDQo+IA0KDQpJ4oCZZCBoYXZlIHRvIGltYWdpbmcgaGF2aW5n
IHRoZSBhc3NlcnQgYmVmb3JlIG11c3QgYmUgdGhlIHJpZ2h0IHdheSB0bw0KZG8gdGhpcywganVz
dCBmcm9tIGEgbG9naWMgY29udHJvbCBmbG93IHBlcnNwZWN0aXZlLiBJ4oCZbSBoYXBweSB0byBm
aXgg4oCZdGhlDQpvdGhlcnMnLCBvciBkbyB5b3UgdGhpbmsgSSBzaG91bGQgbGV0IHRoZW0gc2l0
IHRoZXJlPw0KDQo+IA0KPiBSZXZpZXdlZC1ieTogUGhpbCBBdWxkIDxwYXVsZEByZWRoYXQuY29t
Pg0KPiANCj4gDQo+IENoZWVycywNCj4gUGhpbA0KPiANCj4gLS0gDQo+IA0KDQo=

