Return-Path: <linux-kernel+bounces-510026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1090A3175E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C502188D75B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D788D265CB9;
	Tue, 11 Feb 2025 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="eAxFV+Rf";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="V1PkPTG5"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2A265CA3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308133; cv=fail; b=t0VE3za/nAeOdMwJXLCif/XbOqRAa4yMUC6RbQ0DAM9wCyslot3pmAkGi6sZMuV1CFg49ozi+tDOQRKnA96UbC54Z2xiFw5Y2ZFWIMAHFSo3dGxuHKhsaxmRRIF7pA9/SSUI12n3AEuQTyNdPk3f8O2jFyP4dzSAasdVrYgDLBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308133; c=relaxed/simple;
	bh=NCaR8k122YP+ycys6W3d+zqbNHWClu+NiuKwEQ+VZmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GAY19qOrtYznY2LyQlhR4nD3YzgtCdLpV2WmqXf80Mob+hTArzBKhLWP2TAU3O9fVWiSKvlFHuP1idFQvCBNNIhXmnRnuaamZZk3WTSdbNrhLp+gZMICBgVTQjs6/y0QCBgaJOZC6VZ7u8sG+8Y03kB0pyDJ0X7Q/t5/C1gnebI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=eAxFV+Rf; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=V1PkPTG5; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BJi3si028051;
	Tue, 11 Feb 2025 13:08:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=NCaR8k122YP+ycys6W3d+zqbNHWClu+NiuKwEQ+VZ
	mI=; b=eAxFV+Rf2E5aZwtX1vmaL1i3hTsu+6FXJ20pVYBgA1s2vuvgRimhVujlk
	uw1DuD59scCky7UDfxYxKKrtqeikqw8xBBDqYbVfXU/4+817En4MaawKpztewWWQ
	Slhukarl6fhxgKuGE0PdZw4/bHMD4JKKIJY2H3iQJTgueJSFsug3QcmrgzelxEtP
	ype6fWS/YO1SdXC7v6NJHemDmLZI2IXYXwAaUQi5ln1Yx+c3JGFpCYxOZekx11MR
	iuOnw00Qc0MTIgaOyFgoqciRBSlwDY0Ix4oLpMvkG4lbB9K739E5n9zLezb6YK5x
	EKWWna578OW48w0n+opGCcgd8R4RA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44p7r6y05d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 13:08:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfiY//b2bLtc5RE9uD67wUUwj0uNPswAD6d+JhWZ78J5baKnEBZBW9DF6NjfYvELzkwlkYeWxKn4J/4g2V06pI8mCGu+0LY1oVMDUuPSmXhy1MNWT9Pxh+H8Fn86Q0w2L6tuyn8gJWiHrxaF4wjBJqeYNL0/Lx97h3hPPnmyORSduEsrtcfibLG+uj4+EHO3nlSJeLkYgdBD3lhYeu5mlyW4D0QxM0KDsYu4gLUXzYGDzczPZ3oGNVALv9rnXjXsnh6H8LVfuO5UDfaZ2XjH8AXHpNAgMTux45WoUvFDYFluRR9uE2y8Hwa4dZZ2gRSB1ihqzX5JWxcA4r8hQhfyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCaR8k122YP+ycys6W3d+zqbNHWClu+NiuKwEQ+VZmI=;
 b=q2JnkP43A2ZgMAylO5YBaiNo7ub4RNU94ssY8cZNiN6PpVcqkWZdu/zS0DNom5foa193QmpfSGVsHKbdWf6JpKt1QNPoZ9mhPREVk9jPJwiitHCg9w+sA8DSMucte7wZ64Ebd3FSsTnmj9S4LhhVzOI97a/5bnN0n9bO4L4CaslnoJ4ls1YRXQytwC/3sdcUP1KkK0nU44lB77cF1IMAXodhu8+eMgIDcVdAB7yl+pXb+uEbOBq19HKsxQDeIyXCw7ykKd4dAGZm6ktsRYyzi23t3iVKa80gnbPko2JYqM/ypia2BQzWUTR+SXcqlUxCq9LbbcPn4SU1qr8OLj3FaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCaR8k122YP+ycys6W3d+zqbNHWClu+NiuKwEQ+VZmI=;
 b=V1PkPTG59HysWARbv0qf0TK8eIyEtfTLXoDdROyKTSBxj1T37ca4oi0SccgVTXu0WhyLsStr/cm3CW/7KuPdLWEY6xcxOkYonMuuEm8AL72f1g5NUUourz2zQquuqW2hPtL5TWM92WsSXC14brVPEZsnCT9Go5iZydeSChLrR+f8JXGx6cxds+W9hZqtOq9lRnE3ReSyz+r5YE6eVLAAl6xkJbfOMZVMSkf4olls+cscaYEA0hXmBXONDYUN83i0txg7t2OcQ2ZQ8j7wny02s4EDTZ9m1NtTXXOPko3aiCqK74FvpQtA/3tmIkrGCkjUn6VEz9X+dDu1TqY0fmTQxg==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by CYYPR02MB9903.namprd02.prod.outlook.com (2603:10b6:930:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 21:08:23 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 21:08:23 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin
 Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jon Kohler <jon@nutanix.com>,
        Gauri
 Patwardhan <gauri.patwardhan@nutanix.com>,
        Rahul Chunduru
	<rahul.chunduru@nutanix.com>,
        Will Ton <william.ton@nutanix.com>
Subject: Re: [PATCH] sched/rt: Fix race in push_rt_task
Thread-Topic: [PATCH] sched/rt: Fix race in push_rt_task
Thread-Index: AQHbfEho1rhvhyIioEiWYCFUudvdzbNCNeyAgABjZQA=
Date: Tue, 11 Feb 2025 21:08:22 +0000
Message-ID: <10861916-F001-4AF7-B512-9FFD0D883941@nutanix.com>
References: <20250211054646.23987-1-harshit@nutanix.com>
 <20250211101137.5824285d@gandalf.local.home>
In-Reply-To: <20250211101137.5824285d@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|CYYPR02MB9903:EE_
x-ms-office365-filtering-correlation-id: 8e12eb28-45e3-406c-20c7-08dd4ae03832
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjNxSUdPTWRhUGY4VW8xMjJMT0hrSmQwL2sra01uRS95VzBBdDZtaE9SbGVn?=
 =?utf-8?B?cm9hR1FybUdTVHFuME9QbHBGaUVTM2VLK0VJN2gvVnBaSzQ5QkZhdk5nZ09p?=
 =?utf-8?B?MmNONTlDdFBrOHg4YXRsMnF1NGlVcHBKVUkraGErMkxvUUFibHo0VHhEeWly?=
 =?utf-8?B?TzdLSHV5UnpIUk05WFFyVGcrOGwxdHNkaW1BZEpyT3h2enh3VlNPOUNpc0Nv?=
 =?utf-8?B?ZCtHdUdZaUJqeHV4V2FJb0VGRTFPVnVOMll2ZUxBQ3FDSDdJRlhEdXoyRFVN?=
 =?utf-8?B?N1dzbEx0L2l0K2dPQk84dzBmUlVlNWo0aVVCcFY0SkpZWlIwd09tSUFHMTlj?=
 =?utf-8?B?K3ArUWpLLzBLQlJxMU5mVFpnS2JZMEI5LzFXVERMMzlFL3FST2RGNEtkZ29Z?=
 =?utf-8?B?SFAvc2liSTl1NkRjTFVKZ0tlQk5rQlBYQ3Fuem1xTkFYZXdWRlpwMWppWldx?=
 =?utf-8?B?N2gzWTI0WjFXL2xRQXRaanJuR0dIVTNZUDNqNWt0bE5NdmVZZEwzNjRQWmZp?=
 =?utf-8?B?MjJrQldhcXJIOVhpZnpiazVrUHlPT29vaE9DaytVNFUwNDdoTGRGL2tGMDJy?=
 =?utf-8?B?M2psWk1uNFFzbnJjd29HZFp2bE1XZ0YvNUU5YmdjalFPcHZibUV0ZndxYk95?=
 =?utf-8?B?Ti9QTGFaditYV292Rmsxc0RDU2dUVGUwbStRMnNzMnVwYjJwWExqVG43aU1O?=
 =?utf-8?B?aS9xYlJKY3QyOFc4ZVovekJ3SXE3RU9VN2ZBdWJRYTJXWEt6dDkvUlF1UlIr?=
 =?utf-8?B?NnFUZXdiRkNKZzJya1NTemhLRUFadURBbnBYeFpQQTVTM0Z0bFIvclJoRUNG?=
 =?utf-8?B?SzVFWHBMWU9vOGdVd0VNbGdLUUdJTHZsSHpEOWZ5ZDBiRWluTVRDNHhZR1la?=
 =?utf-8?B?OEE2Mm5SNWJaWFZlVGtKa1lkWGR2VlRIbyttU1Fzb0h1THJicEphem5NWS8w?=
 =?utf-8?B?YVIvaGh5NHJGbmdzSjhxMTJMUTYrYkMyZDF5SmVWZTFPQmZzTk5CckVJSjVY?=
 =?utf-8?B?aDduNFdBM1Z1RlFMM3Qxc0ZvS3NyeXFUZVF1T0dKZ0hHcmRTdkFuanFqSkla?=
 =?utf-8?B?amFCR3N6QmlFR0xURFdGQnJiUkRGdCtXNVUwZGdKQ2YvZzg4Q2NjWTBEMlZK?=
 =?utf-8?B?ZnpqVGFqOGpsb3FrRFloNzBhTGsxZXNGRUVpRi90cVBCMlF3UGFkVUlmVmVu?=
 =?utf-8?B?ZkRVaVY4dkhQeHAxTCtyeFhRa1plSHU5S2laM2kyQmVGbXNvREFPSG1YbXVn?=
 =?utf-8?B?TGNuZE5qZGtKWktldXJUY3NCejBUaDh4aUx0Q2laWkdVOGhhNGJmMEtmUmxi?=
 =?utf-8?B?NTNLZ2ZSVUY0ZEdBTHNKNDU2aERVL3BUTStPZFlDWHVoSTg2enZEQnczZDFE?=
 =?utf-8?B?Y1ordG1Ib3Rpb2FLTmRaMFJOS3JZUFoxZ1NWdzVVVmpyZFNsODBWY0tEMHRX?=
 =?utf-8?B?WVJtRVFoRTJsUkNFODQ1QVN5Y2U2VStFc1ZZcWNxcDVVSDloQ3o5YktSVmxB?=
 =?utf-8?B?QzlhNFdaTDVHbU9vN1NmRkxmdXBPYlVmZEFLbGRaQW1zYnpCMWxabmtLNFZu?=
 =?utf-8?B?QTU2ajQwS0VGWkVmOGV5clM4SWFtNi83MC9HNnNEQXhhZ3MwWHUxMlZiTndL?=
 =?utf-8?B?aTFIdzRWRS9mMngxemI4Q0dZdmg1UUVxSzYxYW5ZMEhpejFPYzJ0d0k5bFJz?=
 =?utf-8?B?dFdVR1cySFRtdTdmenI0a3hyeHdJZTZmT2Q3bklLaUpOSmMrTmdZRTZ5R01r?=
 =?utf-8?B?alRuc1dJeklBcjlyamFkU2JjWW8zNWhGSHpvY1lWRHoxVlF0dklIUi9wNGdq?=
 =?utf-8?B?eWNSejdwS3JMeVd1Q2RBNUcrcmJuR0c1aWhvYjN0bXc5anhwNjRpazdFOGxY?=
 =?utf-8?B?MUlITW9DbFg4TnkwSURJTm11eHNqOUN4RXhRSWFETTF2b0Z5U0N0UEtEQzM4?=
 =?utf-8?Q?G0oCFEcQpsMoHkuueKec6uvsNSk2eV5L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWxRV0FScUlqazFtUGE1SmFoRnVxSFRkSlNsNFZxR1FzYWtITUc5S05UVGE5?=
 =?utf-8?B?UW94dkNIWThGR1lYQTRWcUdPbXdyZm5pc25KVWgrc0NVNnB4bGVCMHlSSXF2?=
 =?utf-8?B?eTRORkFKWWRVenZhZ3Zib24wV1VVNk1KR2g5U1JlT2JzZTJkVE5MRzNIUUNt?=
 =?utf-8?B?VCs0d1c3WnNyUHdscjlQQ2daV0FoSzR6WmtPdkhJVHg0bkZjY0h1Y3BDR2E1?=
 =?utf-8?B?a2dVZjRCSzRDR0Q0S29uYWJhK2hkQ0lWYkJIL3UvUWg3NzZkTVlNMENvSS9a?=
 =?utf-8?B?T2ZYRnBwVlpIY1QxSzVwYkxjcUpYbWp0SFY4QVI4OGNVc3hMaFRYdkRTdE1E?=
 =?utf-8?B?dU1icjB2bFJXSTNSSjdsRFRacEY1ZTdaMFBpdE1hbkhIVHQrbUp4ZHJCMVlh?=
 =?utf-8?B?MDRjWnBkZ2hXNGNPVFc4bEszYkVidHViSGNidTRDeThGQzQ3RjNDVDZVQXBX?=
 =?utf-8?B?R0o5bWswUDhsME1Oa3IrMWhyaVZVZXdlQTQ5WFJPYnR1WVp2SURWeDBqRUFq?=
 =?utf-8?B?SzhvVDgvUEwyTkY2ZC96OGZPNWhiSm5WUkNLTnc5enpKTWZEMkZoSUhzeGE1?=
 =?utf-8?B?ZFRpWG9UQ3YvZmd2U0pNSEVQWEtKbVdoRThVcDJNL0s2SmY1aTJuK1lMK1B4?=
 =?utf-8?B?UDMycEdobzJqem52N2NYU05nS3RzMmZjYXBSSGNSbkVhUVVtWHBEREdzQTdW?=
 =?utf-8?B?VjI2MUxwOEppWlV1WHFVOHFhQlpPNVQ5OFh3Nm1ld2hPZ0MyNEF3YVFiWWVP?=
 =?utf-8?B?MGxzS2xocHpVTGNBUTVYSVZBa3JrdUxpMkVLMVlXekNsQzlJeUgzS1IxOHJ0?=
 =?utf-8?B?SjlQb2ZYaWYvSFBWSnY0eGxEajduRENGVnVzdC9KUWhoeU5KWWRuYUNvSWgv?=
 =?utf-8?B?dHZERlRNNEVleDNybkNVd3hzY09VZWdoOTlmQUl2SC94ZlUrak50bDY3OFFo?=
 =?utf-8?B?d0cxOG5kTWpRSHNDeDBLODJSNE5lRUVUZFAxbWQzZW82cVV1TVdnbFh6cXdL?=
 =?utf-8?B?OE0zRDhNNWR6aXh5MzZtT1diUGh0WmNvNUxnTElvdnB4d2ZvNlRGclhSRERM?=
 =?utf-8?B?bG9lTTUrSGhmM3o1T2NrU0wyZmZXK0JyU2ZxeDJRb1hpaTcxbXlPaWUwbEJS?=
 =?utf-8?B?dVNrdnQ0S3lpbmdCZEtVdlVQUUVWcWF2SGhHVGlHUXpiRkduQzFZTGs3Z1Zx?=
 =?utf-8?B?bmZ5OVE5NW5kU1l1Q0RjZXFYUjhyTEJyS2kyc0VLalVkRjVxUUVjWnlBOWIw?=
 =?utf-8?B?bm5nR1dwVGNrN1QxNEtyZXhocXVzV2RaVTV4aTVjZDZEWUhqaGxwUVJ2UllB?=
 =?utf-8?B?OWdHb29qKzNHTEFLMjYySnNoTWZsYjVpcGtvS2pkY0NBUCt3QmUxd3BMOTVC?=
 =?utf-8?B?SHl4ZzZZMEVPVkFkRk9mOGQwa0FVWVVpSjNKeUFVekJ0aG9URFh3N1pya21h?=
 =?utf-8?B?b1pxR2NsTGduQ0l3OUVocEsyMCtDa3lldG1xZTJSei9RTFV3TTdSWjk1TEdz?=
 =?utf-8?B?RjhjTVIvODgzazBEMXgzcEFINWt2SFlOMkUvamFaM2traHZETE1HSWwvZVl5?=
 =?utf-8?B?SnJ0Q1JyOWxYMWRrejU5dVVub3dwRjdyRkkvSVNIVVc4TXlzWXh1bDVubXpY?=
 =?utf-8?B?VXFmZ200YjJpVnJmdkJsQlN3SmtwNXRJbER3eFpIWVlJclNYeTVyUGV0VXVX?=
 =?utf-8?B?eGVZU3hPek9kejd0TE5mcGFIb0lNN1R1YkhSUjZOM0xwRVI5YUc2Mi9JNjJQ?=
 =?utf-8?B?RGJZM0FjVTMxSVFhcUpZSzRSS1B4R1gzYjlqYVVJWHlQVzBtak4raWdWZHJI?=
 =?utf-8?B?a2QrNzhTekVHQXF5b2cva3dsTWJmVVordjJRWVRVaTZYTnRhUmVwSW8vZWFW?=
 =?utf-8?B?clVWb3RsM2hWenlDcDEwYU5jeEExZ3JMSGlTVFNEcEtRWk5VNEhnellYL1M4?=
 =?utf-8?B?dWNCOGdVeUJxc0s3THA2WW02eWora3g1QkgrNFdJS2k1NE5lcElvT09ubmJs?=
 =?utf-8?B?OHNBZmhGYzdKSlh3emNQaU1JSllmZHFpOFVvczM2anZpL3VMeXVSbXRLQ0xJ?=
 =?utf-8?B?NWZUVmZKa2R1aEk4NXhDOEdCZDBwbmt0UGljTVBqQmRieFZVU2FIakhBRExn?=
 =?utf-8?B?Q0ZiMU8vYW9HNHR5QXRiazN0VVZycERwY3dQcTdCMFd1STVQRGpuMU81S3Rz?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <150FAAB763C9A34185627197A72079B0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e12eb28-45e3-406c-20c7-08dd4ae03832
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 21:08:22.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJsatL/rEZ7BGGe3oYo1BS2NZXf7dprksEgW73rQ6L5ezl2bvbxLFuoxCj3pwSW4xhZbLBN5XXd+86GBTG5ZC3HPUfL5+ED4FvO0ThXqLYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9903
X-Authority-Analysis: v=2.4 cv=C/cTyRP+ c=1 sm=1 tr=0 ts=67abbc4a cx=c_pps a=sGbpJkUcFVeWJOR+0qTsNQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=meVymXHHAAAA:8 a=64Cc0HZtAAAA:8 a=NsMYafbshvsK72VilBsA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: i6ZgDy49NpoQQKKkSQyuWa19OYuCTs1k
X-Proofpoint-GUID: i6ZgDy49NpoQQKKkSQyuWa19OYuCTs1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_09,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gRmViIDExLCAyMDI1LCBhdCA3OjEx4oCvQU0sIFN0ZXZlbiBSb3N0ZWR0IDxyb3N0
ZWR0QGdvb2RtaXMub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMTEgRmViIDIwMjUgMDU6NDY6
NDUgKzAwMDANCj4gSGFyc2hpdCBBZ2Fyd2FsIDxoYXJzaGl0QG51dGFuaXguY29tPiB3cm90ZToN
Cj4gDQo+PiBPdmVydmlldw0KPj4gPT09PT09PT0NCj4+IFdoZW4gYSBDUFUgY2hvb3NlcyB0byBj
YWxsIHB1c2hfcnRfdGFzayBhbmQgcGlja3MgYSB0YXNrIHRvIHB1c2ggdG8NCj4+IGFub3RoZXIg
Q1BVJ3MgcnVucXVldWUgdGhlbiBpdCB3aWxsIGNhbGwgZmluZF9sb2NrX2xvd2VzdF9ycSBtZXRo
b2QNCj4+IHdoaWNoIHdvdWxkIHRha2UgYSBkb3VibGUgbG9jayBvbiBib3RoIENQVXMnIHJ1bnF1
ZXVlcy4gSWYgb25lIG9mIHRoZQ0KPj4gbG9ja3MgYXJlbid0IHJlYWRpbHkgYXZhaWxhYmxlLCBp
dCBtYXkgbGVhZCB0byBkcm9wcGluZyB0aGUgY3VycmVudA0KPj4gcnVucXVldWUgbG9jayBhbmQg
cmVhY3F1aXJpbmcgYm90aCB0aGUgbG9ja3MgYXQgb25jZS4gRHVyaW5nIHRoaXMgd2luZG93DQo+
PiBpdCBpcyBwb3NzaWJsZSB0aGF0IHRoZSB0YXNrIGlzIGFscmVhZHkgbWlncmF0ZWQgYW5kIGlz
IHJ1bm5pbmcgb24gc29tZQ0KPj4gb3RoZXIgQ1BVLiBUaGVzZSBjYXNlcyBhcmUgYWxyZWFkeSBo
YW5kbGVkLiBIb3dldmVyLCBpZiB0aGUgdGFzayBpcw0KPj4gbWlncmF0ZWQgYW5kIGhhcyBhbHJl
YWR5IGJlZW4gZXhlY3V0ZWQgYW5kIGFub3RoZXIgQ1BVIGlzIG5vdyB0cnlpbmcgdG8NCj4+IHdh
a2UgaXQgdXAgKHR0d3UpIHN1Y2ggdGhhdCBpdCBpcyBxdWV1ZWQgYWdhaW4gb24gdGhlIHJ1bnFl
dWUNCj4+IChvbl9ycSBpcyAxKSBhbmQgYWxzbyBpZiB0aGUgdGFzayB3YXMgcnVuIGJ5IHRoZSBz
YW1lIENQVSwgdGhlbiB0aGUNCj4+IGN1cnJlbnQgY2hlY2tzIHdpbGwgcGFzcyBldmVuIHRob3Vn
aCB0aGUgdGFzayB3YXMgbWlncmF0ZWQgb3V0IGFuZCBpcyBubw0KPj4gbG9uZ2VyIGluIHRoZSBw
dXNoYWJsZSB0YXNrcyBsaXN0Lg0KPiANCj4gTmljZSBjYXRjaCEgQW5kIG5pY2UgYW5hbHlzaXMu
DQo+IA0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9ydC5jIGIva2VybmVsL3NjaGVkL3J0
LmMNCj4+IGluZGV4IDRiOGUzM2M2MTViMS4uZDQ4YTljYjlhYzkyIDEwMDY0NA0KPj4gLS0tIGEv
a2VybmVsL3NjaGVkL3J0LmMNCj4+ICsrKyBiL2tlcm5lbC9zY2hlZC9ydC5jDQo+PiBAQCAtMTg4
NSw2ICsxODg1LDI3IEBAIHN0YXRpYyBpbnQgZmluZF9sb3dlc3RfcnEoc3RydWN0IHRhc2tfc3Ry
dWN0ICp0YXNrKQ0KPj4gcmV0dXJuIC0xOw0KPj4gfQ0KPj4gDQo+PiArc3RhdGljIHN0cnVjdCB0
YXNrX3N0cnVjdCAqcGlja19uZXh0X3B1c2hhYmxlX3Rhc2soc3RydWN0IHJxICpycSkNCj4+ICt7
DQo+PiArIHN0cnVjdCB0YXNrX3N0cnVjdCAqcDsNCj4+ICsNCj4+ICsgaWYgKCFoYXNfcHVzaGFi
bGVfdGFza3MocnEpKQ0KPj4gKyByZXR1cm4gTlVMTDsNCj4+ICsNCj4+ICsgcCA9IHBsaXN0X2Zp
cnN0X2VudHJ5KCZycS0+cnQucHVzaGFibGVfdGFza3MsDQo+PiArICAgICAgIHN0cnVjdCB0YXNr
X3N0cnVjdCwgcHVzaGFibGVfdGFza3MpOw0KPj4gKw0KPj4gKyBCVUdfT04ocnEtPmNwdSAhPSB0
YXNrX2NwdShwKSk7DQo+PiArIEJVR19PTih0YXNrX2N1cnJlbnQocnEsIHApKTsNCj4+ICsgQlVH
X09OKHRhc2tfY3VycmVudF9kb25vcihycSwgcCkpOw0KPj4gKyBCVUdfT04ocC0+bnJfY3B1c19h
bGxvd2VkIDw9IDEpOw0KPj4gKw0KPj4gKyBCVUdfT04oIXRhc2tfb25fcnFfcXVldWVkKHApKTsN
Cj4+ICsgQlVHX09OKCFydF90YXNrKHApKTsNCj4+ICsNCj4+ICsgcmV0dXJuIHA7DQo+PiArfQ0K
Pj4gKw0KPj4gLyogV2lsbCBsb2NrIHRoZSBycSBpdCBmaW5kcyAqLw0KPj4gc3RhdGljIHN0cnVj
dCBycSAqZmluZF9sb2NrX2xvd2VzdF9ycShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIHN0cnVj
dCBycSAqcnEpDQo+PiB7DQo+PiBAQCAtMTkyMCwxMyArMTk0MSwxOCBAQCBzdGF0aWMgc3RydWN0
IHJxICpmaW5kX2xvY2tfbG93ZXN0X3JxKHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgc3RydWN0
IHJxICpycSkNCj4+ICAqIEl0IGlzIHBvc3NpYmxlIHRoZSB0YXNrIHdhcyBzY2hlZHVsZWQsIHNl
dA0KPj4gICogIm1pZ3JhdGVfZGlzYWJsZWQiIGFuZCB0aGVuIGdvdCBwcmVlbXB0ZWQsIHNvIHdl
IG11c3QNCj4+ICAqIGNoZWNrIHRoZSB0YXNrIG1pZ3JhdGlvbiBkaXNhYmxlIGZsYWcgaGVyZSB0
b28uDQo+PiArICAqIEFsc28sIHRoZSB0YXNrIG1heSBoYXZlIGJlZW4gZGVxdWV1ZWQgYW5kIGNv
bXBsZXRlZA0KPj4gKyAgKiBleGVjdXRpb24gb24gdGhlIHNhbWUgQ1BVIGR1cmluZyB0aGlzIHRp
bWUsIHRoZXJlZm9yZQ0KPj4gKyAgKiBjaGVjayBpZiB0aGUgdGFzayBpcyBzdGlsbCBhdCB0aGUg
aGVhZCBvZiB0aGUNCj4+ICsgICogcHVzaGFibGUgdGFza3MgbGlzdC4NCj4+ICAqLw0KPj4gaWYg
KHVubGlrZWx5KHRhc2tfcnEodGFzaykgIT0gcnEgfHwNCj4+ICAgICAgIWNwdW1hc2tfdGVzdF9j
cHUobG93ZXN0X3JxLT5jcHUsICZ0YXNrLT5jcHVzX21hc2spIHx8DQo+PiAgICAgIHRhc2tfb25f
Y3B1KHJxLCB0YXNrKSB8fA0KPj4gICAgICAhcnRfdGFzayh0YXNrKSB8fA0KPj4gICAgICBpc19t
aWdyYXRpb25fZGlzYWJsZWQodGFzaykgfHwNCj4+IC0gICAgICAhdGFza19vbl9ycV9xdWV1ZWQo
dGFzaykpKSB7DQo+PiArICAgICAgIXRhc2tfb25fcnFfcXVldWVkKHRhc2spIHx8DQo+PiArICAg
ICAgdGFzayAhPSBwaWNrX25leHRfcHVzaGFibGVfdGFzayhycSkpKSB7DQo+IA0KPiBJJ20gd29u
ZGVyaW5nPyBDb3VsZCB3ZSByZXBsYWNlIGFsbCBvZiB0aGVzZSBjaGVja3Mgd2l0aCBqdXN0Og0K
PiANCj4gdGFzayAhPSBwaWNrX25leHRfcHVzaGFibGVfdGFzayhycSkNCj4gPw0KPiANCj4gSSBt
ZWFuLCB3aGF0IGNoZWNrIGFib3ZlIHdvdWxkIGZhaWwgYW5kIG5vdCBjYXVzZSB0aGF0IG9uZSB0
byBmYWlsPw0KPiANCj4gTWF5YmUgdGhlIGlzX21pZ3JhdGlvbl9kaXNhYmxlZCgpLCBidXQgSSdk
IGxpa2UgdG8gcmVtb3ZlIGFueSBvZiB0aG9zZQ0KPiBjaGVja3MgdGhhdCB3b3VsZCBiZSBjb3Zl
cmVkIHdpdGggdGhlICJwaWNrX25leHRfcHVzaGFibGVfdGFzaygpIi4NCj4gDQo+IC0tIFN0ZXZl
DQo+IA0KDQpUaGFua3MgU3RldmUgZm9yIHRha2luZyBhIGxvb2suIFllcyB3ZSBzaG91bGQgaWRl
YWxseSByZW1vdmUgYW55IGNvbmRpdGlvbnMgdGhhdCBhcmUgDQpzdWJzdW1lZCBieSB0YXNrICE9
IHBpY2tfbmV4dF9wdXNoYWJsZV90YXNrIGNvbmRpdGlvbiwgaG93ZXZlciBJIGFtIG5vdCBzdXJl
IGlmIGFueW9uZSAoc2F5IHR0d3UoKSkNCndpbGwgdHJ5IHRvIG1vZGlmeSBw4oCZcyBzdGF0ZSB3
aXRob3V0IHJlbW92aW5nIGl0IGZyb20gdGhlIHB1c2hhYmxlIHRhc2tzIGxpc3QgZmlyc3QuIElu
IHN1Y2ggYSBjYXNlDQpwaWNrX25leHRfcHVzaGFibGVfdGFzayB3aWxsIHN0aWxsIHBpY2sgcCBh
Z2FpbiBhbmQgdGhlbiBpdCB3aWxsIG1hdGNoIGFuZCB3aWxsIHByb2NlZWQgdG8gZG8gdGhlIG1p
Z3JhdGlvbg0Kd2hpbGUgdHR3dSgpIGlzIHRyeWluZyB0byB3YWtlIGl0IHVwLiBNb3N0IGxpa2Vs
eSwgc29tZSBhc3NlcnRzIGxpa2UgIXRhc2tfb25fcnFfcXVldWVkIGV0YyB3aWxsIGJlIGhpdCBp
bg0KcGlja19uZXh0X3B1c2hhYmxlX3Rhc2sgYXMgc29vbiBhcyBwIGlzIHBpY2tlZC4gSWYgd2Ug
Y2FuIGJlIHN1cmUgdGhhdCBw4oCZcyBzdGF0ZSBpcyBtb2RpZmllZCBieSBvdGhlcnMNCm9ubHkg
YWZ0ZXIgaXQgYmVpbmcgcmVtb3ZlZCBmcm9tIHB1c2hhYmxlIHRhc2tzIGxpc3Qgb2YgdGhpcyBD
UFUgdGhlbiBpdCBzaG91bGQgYmUgc2FmZSB0byByZW1vdmUgaXQNCmVsc2Ugbm90LiANCg0KUGxl
YXNlIG1lIGtub3cgd2hhdCBkbyB5b3UgdGhpbmsuDQoNClJlZ2FyZHMsDQpIYXJzaGl0DQoNCg0K
PiANCj4gDQo+PiANCj4+IGRvdWJsZV91bmxvY2tfYmFsYW5jZShycSwgbG93ZXN0X3JxKTsNCj4+
IGxvd2VzdF9ycSA9IE5VTEw7DQo+PiBAQCAtMTk0NiwyNyArMTk3Miw2IEBAIHN0YXRpYyBzdHJ1
Y3QgcnEgKmZpbmRfbG9ja19sb3dlc3RfcnEoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBzdHJ1
Y3QgcnEgKnJxKQ0KPj4gcmV0dXJuIGxvd2VzdF9ycTsNCj4+IH0NCj4+IA0KPj4gLXN0YXRpYyBz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnBpY2tfbmV4dF9wdXNoYWJsZV90YXNrKHN0cnVjdCBycSAqcnEp
DQo+PiAtew0KPj4gLSBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnA7DQo+PiAtDQo+PiAtIGlmICghaGFz
X3B1c2hhYmxlX3Rhc2tzKHJxKSkNCj4+IC0gcmV0dXJuIE5VTEw7DQo+PiAtDQo+PiAtIHAgPSBw
bGlzdF9maXJzdF9lbnRyeSgmcnEtPnJ0LnB1c2hhYmxlX3Rhc2tzLA0KPj4gLSAgICAgICBzdHJ1
Y3QgdGFza19zdHJ1Y3QsIHB1c2hhYmxlX3Rhc2tzKTsNCj4+IC0NCj4+IC0gQlVHX09OKHJxLT5j
cHUgIT0gdGFza19jcHUocCkpOw0KPj4gLSBCVUdfT04odGFza19jdXJyZW50KHJxLCBwKSk7DQo+
PiAtIEJVR19PTih0YXNrX2N1cnJlbnRfZG9ub3IocnEsIHApKTsNCj4+IC0gQlVHX09OKHAtPm5y
X2NwdXNfYWxsb3dlZCA8PSAxKTsNCj4+IC0NCj4+IC0gQlVHX09OKCF0YXNrX29uX3JxX3F1ZXVl
ZChwKSk7DQo+PiAtIEJVR19PTighcnRfdGFzayhwKSk7DQo+PiAtDQo+PiAtIHJldHVybiBwOw0K
Pj4gLX0NCj4+IC0NCj4+IC8qDQo+PiAgKiBJZiB0aGUgY3VycmVudCBDUFUgaGFzIG1vcmUgdGhh
biBvbmUgUlQgdGFzaywgc2VlIGlmIHRoZSBub24NCj4+ICAqIHJ1bm5pbmcgdGFzayBjYW4gbWln
cmF0ZSBvdmVyIHRvIGEgQ1BVIHRoYXQgaXMgcnVubmluZyBhIHRhc2sNCg0KDQo=

