Return-Path: <linux-kernel+bounces-518063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127BAA3894A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED8A3ABB20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF1224AFF;
	Mon, 17 Feb 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="eboeEHHw";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QazDXcIq"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A8223703
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810232; cv=fail; b=PfQhR/IDzNiMsYuHGVICN86mZHeCgEcUoFS5B0f9t8YsBXqlKk8o5vnGaLmzFEbwadj4P7LPI4CjVPmpmEG3pL6c58E1xD21Vzq5VkqVappWlVWR63prEsIzuSkhXwIQqoDowDuoe/dScKnCFTuublCY4O66XnrITzx3eGYzRcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810232; c=relaxed/simple;
	bh=Bhl8Styysq9VsgPimxerBZcPBs+gGbY7seWsFuFuaxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ijxVaZBoCLoQAOJHVRpZ/FdIKcsAKueiTyHMR4KJ5a1iKTL7hjllUkHeKf8UhBxS/0jnwoGopGpTDUyAC7EHG6N3vrqzrVXUSUorRkNlSVYbZ9C083d7a0t7ZtmZ2JSxCtkhZSNQMvfnJCHKagxKgh0ANy/cPUvWi14emdJ9gTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=eboeEHHw; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=QazDXcIq; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H9Q18s009635;
	Mon, 17 Feb 2025 08:36:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Bhl8Styysq9VsgPimxerBZcPBs+gGbY7seWsFuFua
	xk=; b=eboeEHHwafmWedvBoWe8zdwM/0KvljJdrz77Q0ryns8b9Etvjz7bDT1x3
	BLl7Q4wglpORVXoypIqwSJ/WJ2OvA7bdN70UNQPDwbNJIhxR9neaNlsQ40C0Ss+Q
	OfmNN6EW90of4rooGCoTVlzeVeulBYjtLX+uknR926G84E4uUQAnL5Rj7PTs0zM+
	m0/bcMq+deWRdhV4tWj9y8VO10T/zsHsB9QTZ/SntcHVBvY5Kcoopa0AfbkP1ebw
	4nStkMmbE+srK/aAlOR1i+NOi4fqM7KGtKwJZ7gSNJ1zdGh9Ru2w9AFACn/aOKXB
	o5Jwn39+qpAucsFmul9m0+y0oMxgA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011026.outbound.protection.outlook.com [40.93.14.26])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44tu4ev85g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 08:36:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUPZwHRKptWTdwDZ3jm/QLQ1vJlXr/jxu0c8el4lMzlEgZDXzkJdURCxxBcVto86OzKdsPJspj5jhgVH9fvjn3SW5lCu3y1R22VnjnvTZQ34geNjXz/outnuIJDIBVCkZAJAaiOVeYekwU0Lu7Y9E0bxsWCsIjwsUDmm02SyINpK7q3/Ugq55GWniqMzRKRJrNB+84Qwd0AWlsZ7io7fCSBxM9CgdytnHCypB/2CdjiRR4oE2gmsx8ZKzNSGszDoaXwx9LnBcwkYWKNFy5+k4U/ZRVHcSU0fpCFWwLiSbArCiZZyshPaNuRC6tFaGx6ty52DIrVfXRZDfShTrjPwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bhl8Styysq9VsgPimxerBZcPBs+gGbY7seWsFuFuaxk=;
 b=mBCp1SoNzHi8Po+5dwpg6LOuex9b2obLsI4yKo02I+4Pg7C03nqZRjBEpdGKaXkt6XljFKOagO06ILgLx4abeBLapziwaRlP0HSXra6UvheqodNcbxBY08Bh/MYZUYRIbFhLuC77U+olM0uBKaclJTjlJvThw9oAsc2MRdz4W8qb1nmC99KKMR+NwPLlbamaHkvqSx4iWHDOWPNcMEu2VAB3J4eajesjtebf1D1D7ZSNtGUL2VS1r1pGaGjQ6oOO59mfPScR+BsVJCHJA3SZ5afja5p1ArxnadKWk48VOvOfR8kzqi/IFfbDEWdZBfTWemq3BQDRTEFkwAza6YxL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bhl8Styysq9VsgPimxerBZcPBs+gGbY7seWsFuFuaxk=;
 b=QazDXcIqJ22Adp1iOuC6vegV1w49Aiq9MzD8f8sLO3H04cM6Cf2tAgDoXJcShu6rrpMcvrfgsnM3ZrdBp4XmnCd7GFaDMgpn95Yv89RxV9aP/dTA0bMDpHHMlXNPloVzwQwusTxGwmK+pI1v8xly1X3Q6qWv7EyIP9FhPrfqNrQwtqDwT8rK6NuLwavbklhsXP6XqQHjZQXVD34+GpcYyNeHVloWahE2fHwZ3pDbG/MBtFMU3NZCE9c94SimtOgvAq0gC6rIrwGcJQvvdT+l5svutY1q6uywjy4lR0JxZin4HWgqjG5jkbttTq5EsX0wFQNkeFgHApz7rRvRE9LPvQ==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by MW4PR02MB7234.namprd02.prod.outlook.com (2603:10b6:303:76::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 16:36:47 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 16:36:47 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v2] sched/rt: Fix race in push_rt_task
Thread-Topic: [PATCH v2] sched/rt: Fix race in push_rt_task
Thread-Index: AQHbfkBfYddWMH4YgUah/vjK71klNrNLqruAgAAMfAA=
Date: Mon, 17 Feb 2025 16:36:47 +0000
Message-ID: <D7C6B8EE-7AFC-4F1E-8A59-E9573658146C@nutanix.com>
References: <9C390C10-8741-4992-8E29-303C907C8C00@nutanix.com>
 <20250213175435.114441-1-harshit@nutanix.com>
 <20250217105007.45ba8cb4@gandalf.local.home>
In-Reply-To: <20250217105007.45ba8cb4@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|MW4PR02MB7234:EE_
x-ms-office365-filtering-correlation-id: be66cc26-01f9-41fd-077e-08dd4f71459b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?azRHdDJxVy9HS3FjZ0I1OGU5OXhYZW9UZ2xHdGJ5NjJ4ditkcTgrd1hUWURY?=
 =?utf-8?B?aE5Mb3gyZjA2VTB1cnNZU2ZpZ1NjTnlnQ05xQmxFTWpJK1Fkb016Y2JWbGtF?=
 =?utf-8?B?TXN2ZTFYVjJUa3JIbXVpak1aS2k3Y0JZS0djcjd1aTNEaUdJYzZDa1VFSklt?=
 =?utf-8?B?blVrRVc0SHdLSkxOeHA1SHArcDM0UW1NWDdFenFTK3FGM0JHSzdyRE8weWpN?=
 =?utf-8?B?NVFsMHM1MWhwMzJiblgyNzdkekxpMW1PcWR6VEUrQUluNHlpZDlEcG5mOUU0?=
 =?utf-8?B?SlRHY1BYbnMzWkRvVUxMNTVHYkNBYkc3RDdleEpkb05CY2txNTNBUUpoZ1hB?=
 =?utf-8?B?SUozN3BGZmphbkxzYXF3NDZYb0xPak5qTWNKQlljMDl6empJMzdxMi8rY01j?=
 =?utf-8?B?WEUxMml4UmR3a0J2OE0zazFqb1plRGhjUlpRMW51QU1ObmJvV0M2dWxZSGJI?=
 =?utf-8?B?aWJ5MjZhVXltMkFxcU0ydzN2VjNuV05tMXRESGQ3aU9tMkQwN2lZd1NLNFRR?=
 =?utf-8?B?dDI1dCtKRHdjUjZVTXpBSTBWdk9lU01VTVYzeFFhZWF4Y0JiUTFSOVJ2clh5?=
 =?utf-8?B?dnhDRE1aSmV2NkhrR0pkWUcxSEVmUFJCZytZVUMzelpFVitscjl2WTkrNjho?=
 =?utf-8?B?MGNYbEZlYWtMQ2VMOHlCWXpDdGI2djJuUXZ3bFVsWkpKSHN0cXE5Nk9kNURF?=
 =?utf-8?B?Zk0vN0cyLzAxQXJrbHRFLzBCcThuUU1tYllCOGQweXRPN2VhM2RVbzRtMlkz?=
 =?utf-8?B?WmNhM2k1cVdIZ3d6dmI2a0VGQWkzb0FuWVhxY2grWStJNytlRXkrZ3pMVnJH?=
 =?utf-8?B?RmNjeTgyWUxabnF3QWJ4RWU5TWZLNnkzMUROYXFFekdDdEo5TmwyakN5MmE0?=
 =?utf-8?B?TlNYdHdTSjJmcFh4U3I3U3hEVUlxcEJqY3NXUFlnK3ZmT2EybnljMy9abDhx?=
 =?utf-8?B?YkwySjVYOHBlc0g5VkhzYm9rRHVyamd4bXl0RXZ1aUZ1ajFpdjdMOFVwMmxr?=
 =?utf-8?B?QldmeEpuekl1TUJDNnNBWmtrWjkyeXB2ZnB3STcwUzhYanpCeUc3Y2hpek9l?=
 =?utf-8?B?c0N6L2lJRjAxNzFickZ2WTk1akZiM0NQeTB5ekg5U1ViTCtmU0ZveWNSaGND?=
 =?utf-8?B?aDJWZUtvNktydzRDalNncDF0T3NScm80cWU3WlBZc1ZrYnlPbTNiNGlkdHMz?=
 =?utf-8?B?dVJFakt2c2FOWHBIZDkxVDBBOEVreTZOQzlvY2NEU05PZzVwdE14TFpjUjBN?=
 =?utf-8?B?bldqSDN3Qkc3QzYzdDJ2MU9tTUsvSmpDNkpkMThxYkIyZWhUeHhmNkpuUXBR?=
 =?utf-8?B?cVJKKzlpdG9xeUd3S2JNTjNESUxYeUwvem9vYW5iNXl3NGtEZFBlelU0Y0Nh?=
 =?utf-8?B?a3FZMXRyMXVqOWo4SVk4alkzdCtPNHp0bkt6L2gwcDFUSGRvemo1dWZEWWdF?=
 =?utf-8?B?bHJjSFJHeEE3N0tzK3NzYkppanVGaGQvY3RzdVVjTTdHVjBTeDExT1k2OEtX?=
 =?utf-8?B?d1FTNlhZdmsrUS9YL1FOQ1c4QXloWU1HcXE3K3JqcnA1OFV4NG1oNGd4Yldi?=
 =?utf-8?B?NzhIUUxMYmVkL1NWSFFmU1RCY01tb3p0SFpWRGlXTXZXSXpVWHFCZlNTbnlm?=
 =?utf-8?B?L0x5SllzZWFPeTRUUlZkSExEUjFGUUNDdEhoQThGZzNDMUpjbGd1Zlc4MXJ0?=
 =?utf-8?B?bmlnYlh2ZFIveTdvL3BFZjlUOCtUWVFyaW9vS1EwQW9zazlRRFhVWGtKYjUz?=
 =?utf-8?B?Y05zSjRteGRuREtiUHpYV2dyajk5L3ZGcUpBU1JFY0N3Tm5KVkRpbmZFNW8w?=
 =?utf-8?B?dDBoUDcvckF5d3lKZHRTcURmWGROeG95akU2eVVVSS8xQXhqUjFnLzFUZ1hG?=
 =?utf-8?B?QXBCdjNHYnhiR0ZpK1VkRjU4elVWTVVjdUVlNHFyVXNFOU44V3p5NXlUUEVT?=
 =?utf-8?Q?gCm8fpv+HBkpCPL3PV5nqUan173rERJ/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEowbStNZ0xSZVcxMngyaUpiemdTRFhMNW9VQ3B3aXlnNVkrYjB2OUw1cXVF?=
 =?utf-8?B?QmRRM0IxWnpuL21WNC9zd3M5dWVTZ29sVXhnTXd3NGJnQXhWODBSaUZBbzJK?=
 =?utf-8?B?N0s4ZDBmeHRoOUd4RlVSWUtNTEJydmwxQ0htTWU3RW1YQm9La2Y2dkNsK2Nw?=
 =?utf-8?B?d0RiWjl5Y0hkelh6TzBodEt5UTE4YkZMQytuYk85ZHBFRUV6d21EWWJITnhP?=
 =?utf-8?B?b05KRnFteU5wcVd0OEwyaDYzL1FnY0RCWGJNcnRlZy9xVW9iWXhDaXhlbGp0?=
 =?utf-8?B?cUNqTnQzR1d4R2pXeVlqYXRtU01aUU1vc3JNdCtRcUR3VVlZcVg1akJrelh1?=
 =?utf-8?B?a0ZwdmpzWmdwNmRVYjEySXFPc1lTbzRpc0R2dWhxejVnL2VsY0xWYS8vY3BW?=
 =?utf-8?B?YzNNd3dWamYwcVhDSXM0WUN4bWs0UisybW1uM1FJY2ZLZ0J6NzhJRUxhQldO?=
 =?utf-8?B?ZXhjN1Zhak5keFdJcmVjbVRPcFB0eGVqSFRUZlBGQmZTcTA1TFdKUzBRL0x0?=
 =?utf-8?B?cnloR3N5K1B2QXRteEhHbGpNaHcySDJ3UHVGTDJDVFVOR0VXc1RjSG9Yc2Ji?=
 =?utf-8?B?SVhPQUpkNnl1clc0WC9KOURMTUYra0hTTGM2aTRoTUJDY1RDL1B6MUV5Y3pS?=
 =?utf-8?B?L3lNSThvdjVRQ25xSS9LcWNjUWJuVVVDOWczVitvUTNwUDFZOXlFNzZsenFk?=
 =?utf-8?B?UHdIMW5WSFA1V2JMaEQyOWdqcFNmOW5uSnB1MFBSVTdyYU43Ti9qcGV3OWps?=
 =?utf-8?B?UzVsTFl1YWt0eGI4QTNEV0s1ZDdkblJiNEk1ZHZrSWVCcmNTN04xMmxlMENr?=
 =?utf-8?B?M3Z2ZTBrakhKMmlPNWpGbGg0amFrVjFFNG9YeEZwNjg4WG1ETGZ4MG02NkRC?=
 =?utf-8?B?bnZvS2U0cGZIcFdtRGxSa2lieTdZRS92OGhPMnc1YUN0eEtVNEEvNElwOFB6?=
 =?utf-8?B?K01LOGlha3VGS0t4cSttUGt5TDExUUpHeVhDQXE5V1NvN3ZxMEhpOVRXY0RR?=
 =?utf-8?B?dktCZ0dpdFhiZ0FwczVrTWxUanl5d3FMN1hvcE14eHI4Skx1T2MwTW40Z0xK?=
 =?utf-8?B?bis3bnRva2R0QStiNS8vanRPV1pVNjIvaTAwZnBxWjAvTU9UZFA5UjU0cG1p?=
 =?utf-8?B?TWh4bzJ6ZGxacis3Z3N2b213ZjQxQmNzQ2UrMEpKeGZjTnFSZGFIOTNXZXd2?=
 =?utf-8?B?am9MRTJTM3NWL3dORDBLQU5UL0laUHJ4dmVpNGVSdXh4S2tqcDBhZnVoNEpo?=
 =?utf-8?B?bjZsZnBrdXJGUkl1aTFBZkJrSUZLMUw5UXExbnpGZjY3emM2QUY1WVUyU1Rt?=
 =?utf-8?B?WXYxZjlaMnZaNHArUFBDcTRBcFQvQnUrUEEzWXVPS0ZhQWovY0EwdFlKNUZL?=
 =?utf-8?B?dDFpa1FOVFNOR010U2g5b3RVaUFBVG5SQTA2amI5S0Y0Tml6NG9uWjZZSEpO?=
 =?utf-8?B?ZS9NWHN1TEdRUzBkMFdzY2hjVGJpa0xBY1lZWnIwcTF0elhWU3VUdDRMRkdB?=
 =?utf-8?B?UjUwYjlaUEp6OFBzSFlXa1dUVGcvQTdmQmp0ZkVBY2k2Q0ZXc1VxVlJQSEtv?=
 =?utf-8?B?VlVvRkUvKzFuWEpjYVBJY1RSMlB2anc4TXVicllrWjhPZ3FQMmU5YSszbG9L?=
 =?utf-8?B?eUJwN1M1OVFxYjl5bnlDekp5YitKZFlESnU5OTZZcEkxZ2VuS2EvUXV3NnZW?=
 =?utf-8?B?NE5ja3I2NmdueWxpTkxmbmxBZ3ZKZmNTWElQQnlsd1BOaTdsMThnNUI2SWpK?=
 =?utf-8?B?bjFXQXJRUGpnQ1dpTGlKR2RsTWQ2RnpIN2dRY3h3OG4xbnhCcDVqaEw4MjNF?=
 =?utf-8?B?S2xGd21BcVdiQ3FWTWhUNTA4TW9VNU42RGVRQXQzSjNNU1lxY2NtS2VUNnV6?=
 =?utf-8?B?N0VuZHZtMzhOQkEyV2dCNUxnd3VHblp2MllDUUdndDEzNC8wbjJOZk9OVnFs?=
 =?utf-8?B?VXlzSTFvSW5ubUpkcVBFUnNjbElzYmNBWjZkbE1HdStNZ3V4MUZLRGF2SXB0?=
 =?utf-8?B?NXQxOStLOEJGRVhKbTUzZTBDSGl1V1NLLzhsK3M1aXA1TGZXR096R254QlhW?=
 =?utf-8?B?WWxyRDdEcm5vUDF5N0tCWWx1Ulp0U2VXTXJQZXJZS1ZFSWxMdlRsbjEyU1lx?=
 =?utf-8?B?eWFRNWJJT2dXZ2U5ckJaalNzVWowT05tOE9kS0pXMzN0Z1pEWkpRTHdTM2pq?=
 =?utf-8?Q?JiITG4ME48h8k2iHZ5BeL79R0yIbpr/BmVa3dT56quNG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F095DF93AD6009459F9EA1EBBA7E189B@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be66cc26-01f9-41fd-077e-08dd4f71459b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 16:36:47.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkAzN00xnkJLcfbmrLyLcJlLghhT6mHVCwotRzFPR+6RVIUWwv1WjV9+n2RgtQUMTJJVv4Ec6nP4BdNYz1krwno7iASoyjdYuZVVZ5qMqNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7234
X-Authority-Analysis: v=2.4 cv=O+nDvA9W c=1 sm=1 tr=0 ts=67b365a2 cx=c_pps a=GnUjYDbtZuq/T0BoTQNfSw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=meVymXHHAAAA:8 a=oZzFQrkaBgjRdr75k7YA:9 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: geMzaQCZiaGWWv9om8Rs1vyExdyq2rIR
X-Proofpoint-GUID: geMzaQCZiaGWWv9om8Rs1vyExdyq2rIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

SGkgU3RldmUsDQoNClRoYW5rcyBmb3IgdGhlIGluZm9ybWF0aW9uLiBJIHJlYWxpemVkIG15IG1p
c3Rha2UgdGhpcyBhZnRlciB1cGRhdGluZyB0aGlzIA0KdGhyZWFkIGFuZCB0aGVuIGxhdGVyIEkg
c2VudCB0aGUgcGF0Y2ggYXMgYSBzZXBhcmF0ZSB0aHJlYWQgaGVyZSANCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvMjAyNTAyMTQxNzA4NDQuMjAxNjkyLTEtaGFyc2hpdEBudXRhbml4LmNv
bS8NCmFuZCBpbmNsdWRlZCB0aGUgbGluayB0byB2MSBhbG9uZyB3aXRoIHRoZSBjaGFuZ2VzIG1h
ZGUuDQoNCkkgaGFkIGFsc28gYWRkZWQgYSBjb21tZW50IG9uIGlzX21pZ3JhdGlvbl9kaXNhYmxl
ZCBsaWtlIHlvdSBzdWdnZXN0ZWQgIGhlcmUuIA0KVGhpcyBzZXBhcmF0ZSBwYXRjaCBhZGRyZXNz
ZXMgeW91ciBjb21tZW50cyBhbHJlYWR5Lg0KU29ycnkgZm9yIHRoZSBjb25mdXNpb24uDQoNClJl
Z2FyZHMsDQpIYXJzaGl0DQoNCj4gT24gRmViIDE3LCAyMDI1LCBhdCA3OjUw4oCvQU0sIFN0ZXZl
biBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPiB3cm90ZToNCj4gDQo+IA0KPiBGWUksDQo+
IA0KPiBZb3Ugc2hvdWxkIGFsd2F5cyBzZW5kIGEgbmV3IHBhdGNoIHZlcnNpb24gYXMgYSBzZXBh
cmF0ZSB0aHJlYWQuIFRoYXQncw0KPiBiZWNhdXNlIHRoZXkgY2FuIGdldCBsb3N0IGluIHRoZSB0
aHJlYWQgYW5kIG1ha2VzIGl0IGhhcmRlciBmb3IgbWFpbnRhaW5lcnMNCj4gdG8ga25vdyB3aGF0
IHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoIGlzLiBJJ3ZlIHBpY2tlZCB0aGUgd3Jvbmcg
cGF0Y2gNCj4gdmVyc2lvbiBiZWZvcmUgYmVjYXVzZSB0aGVyZSB3YXMgYW5vdGhlciB2ZXJzaW9u
IHNlbnQgdGhhdCBJIG1pc3NlZC4NCj4gDQo+IE9uIFRodSwgMTMgRmViIDIwMjUgMTc6NTQ6MzQg
KzAwMDANCj4gSGFyc2hpdCBBZ2Fyd2FsIDxoYXJzaGl0QG51dGFuaXguY29tPiB3cm90ZToNCj4g
DQo+PiBTb2x1dGlvbg0KPj4gPT09PT09PT0NCj4+IFRoZSBzb2x1dGlvbiBoZXJlIGlzIGZhaXJs
eSBzaW1wbGUuIEFmdGVyIG9idGFpbmluZyB0aGUgbG9jayAoYXQgNGEpLA0KPj4gdGhlIGNoZWNr
IGlzIGVuaGFuY2VkIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSB0YXNrIGlzIHN0aWxsIGF0IHRoZSBo
ZWFkIG9mDQo+PiB0aGUgcHVzaGFibGUgdGFza3MgbGlzdC4gSWYgbm90LCB0aGVuIGl0IGlzIGFu
eXdheSBub3Qgc3VpdGFibGUgZm9yDQo+PiBiZWluZyBwdXNoZWQgb3V0LiBUaGUgZml4IGFsc28g
cmVtb3ZlcyBhbnkgY29uZGl0aW9ucyB0aGF0IGFyZSBubyBsb25nZXINCj4+IG5lZWRlZC4NCj4+
IA0KPj4gVGVzdGluZw0KPj4gPT09PT09PQ0KPj4gVGhlIGZpeCBpcyB0ZXN0ZWQgb24gYSBjbHVz
dGVyIG9mIDMgbm9kZXMsIHdoZXJlIHRoZSBwYW5pY3MgZHVlIHRvIHRoaXMNCj4+IGFyZSBoaXQg
ZXZlcnkgY291cGxlIG9mIGRheXMuIEEgZml4IHNpbWlsYXIgdG8gdGhpcyB3YXMgZGVwbG95ZWQg
b24gc3VjaA0KPj4gY2x1c3RlciBhbmQgd2FzIHN0YWJsZSBmb3IgbW9yZSB0aGFuIDMwIGRheXMu
DQo+IA0KPiBNYXkgYWxzbyB3YW50IHRvIGFkZDoNCj4gDQo+ICBTaW5jZSAnaXNfbWlncmF0aW9u
X2Rpc2FibGVkKCknIGEgZmFzdGVyIGNoZWNrIHRoYW4gdGhlIG90aGVycywgaXQgd2FzIG1vdmVk
DQo+ICB0byBiZSB0aGUgZmlyc3QgY2hlY2sgZm9yIGNvbnNpc3RlbmN5Lg0KPiANCj4+IA0KPj4g
Q28tZGV2ZWxvcGVkLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+PiBDby1kZXZlbG9wZWQtYnk6
IEdhdXJpIFBhdHdhcmRoYW4gPGdhdXJpLnBhdHdhcmRoYW5AbnV0YW5peC5jb20+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBHYXVyaSBQYXR3YXJkaGFuIDxnYXVyaS5wYXR3YXJkaGFuQG51dGFuaXguY29t
Pg0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBSYWh1bCBDaHVuZHVydSA8cmFodWwuY2h1bmR1cnVAbnV0
YW5peC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBSYWh1bCBDaHVuZHVydSA8cmFodWwuY2h1bmR1
cnVAbnV0YW5peC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBIYXJzaGl0IEFnYXJ3YWwgPGhhcnNo
aXRAbnV0YW5peC5jb20+DQo+PiBUZXN0ZWQtYnk6IFdpbGwgVG9uIDx3aWxsaWFtLnRvbkBudXRh
bml4LmNvbT4NCj4+IC0tLQ0KPiANCj4gWW91IGNhbiBhZGQgaGVyZSAoYWZ0ZXIgdGhlIGFib3Zl
IHRocmVlIGRhc2hlcyksIGhvdyB0aGlzIHZlcnNpb24gaXMNCj4gZGlmZmVyZW50IGZyb20gdGhl
IGxhc3QgdmVyc2lvbi4gVGhlIHRleHQgYmVsb3cgdGhlIGRhc2hlcyBhbmQgYmVmb3JlIHRoZQ0K
PiBwYXRjaCBpcyBpZ25vcmVkIGJ5IGdpdCwgYnV0IGlzIHVzZWZ1bCBmb3IgcmV2aWV3ZXJzLiBG
b3IgaW5zdGFuY2U6DQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOiBodHRwczovL3VybGRlZmVuc2Uu
cHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19hbGxfMjAy
NTAyMTEwNTQ2NDYuMjM5ODctMkQxLTJEaGFyc2hpdC00MG51dGFuaXguY29tXyZkPUR3SUNBZyZj
PXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1RVFBWaE5nSDcxNi16VV9rUG10ZTM5bzN2R0ZWdXBu
R21tZmlWQnBxOVBVJm09WUhuaHFZMVVhVmVhaGdvVktWV3VNYUN3LVRKUVFnOVNkaGlmMzRXcXN0
Y0hYWWVfc1VIZml4NUlteUp3eUlIbCZzPWxoZlhxQkxrZmV5eUtMWHFQQUJtWXVRWklxQ1p6SHgw
LWRRazJpM2s0OXcmZT0gDQo+IA0KPiAtIFJlbW92ZWQgdGhlIHJlZHVuZGFudCBjaGVja3MgdGhh
dCB0YXNrICE9IHBpY2tfbmV4dF9wdXNoYWJsZV90YXNrKCkgYWxyZWFkeSBoYXMNCj4gDQo+IA0K
PiBOb3RpY2UgSSBhZGRlZCBhIGxpbmsgdG8gdGhlIHByZXZpb3VzIHZlcnNpb24uIFRoaXMgaGVs
cHMgZmluZCB0aGUgcHJldmlvdXMNCj4gdmVyc2lvbiB3aXRob3V0IGhhdmluZyB0byBtYWtlIHRo
aXMgdmVyc2lvbiBhIHJlcGx5IHRvIGl0Lg0KPiANCj4+IGtlcm5lbC9zY2hlZC9ydC5jIHwgNTQg
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IDEgZmls
ZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9ydC5jIGIva2VybmVsL3NjaGVkL3J0LmMNCj4+IGluZGV4
IDRiOGUzM2M2MTViMS4uNDc2MmRkM2Y1MGM1IDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL3NjaGVk
L3J0LmMNCj4+ICsrKyBiL2tlcm5lbC9zY2hlZC9ydC5jDQo+PiBAQCAtMTg4NSw2ICsxODg1LDI3
IEBAIHN0YXRpYyBpbnQgZmluZF9sb3dlc3RfcnEoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrKQ0K
Pj4gcmV0dXJuIC0xOw0KPj4gfQ0KPj4gDQo+IA0KPiBPdGhlcndpc2UsDQo+IA0KPiBSZXZpZXdl
ZC1ieTogU3RldmVuIFJvc3RlZHQgKEdvb2dsZSkgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+IA0K
PiBQZXRlciwgY291bGQgeW91IHBpY2sgdGhpcyB1cD8NCj4gDQo+IC0tIFN0ZXZlDQoNCg==

