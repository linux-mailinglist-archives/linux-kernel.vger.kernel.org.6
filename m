Return-Path: <linux-kernel+bounces-510028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5F9A31761
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0E53AA76E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DD126D5B9;
	Tue, 11 Feb 2025 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="d0ntusoI";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="V1PkPTG5"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38E265CB3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308135; cv=fail; b=SegsQZoLUxZfXvr0CWE3gpboq37NGOlroHHAFQcqsK0TRGD/PpKSSzPcoz2zs293wGrDrI1iCpQM98GaKAsj05yl0j+kScFVxFvwueqmuhm5m8/AyM4I1C/ehHd9inSCKmaJqoy3VS3RbQC8QvqlExAytkFeN5TG5eYUROMPLUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308135; c=relaxed/simple;
	bh=NCaR8k122YP+ycys6W3d+zqbNHWClu+NiuKwEQ+VZmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VHE67KOPYBoiD4UgmXp9GcE8erMxfHs/JGFgFvbYPY4sao/6yJVEfoKb9KWYjgCkWkEW8dWvSR0J7twLG78oz43nYwJL9YPsQcF4qZuRCjIIjG/mfL7LyKdY/JvP+QZHTbtvS9dYgJ2Arr99iXMyqSQyeYOc1f5j56iyxay7AUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=d0ntusoI; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=V1PkPTG5; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BJi3sh028051;
	Tue, 11 Feb 2025 13:08:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=NCaR8k122YP+ycys6W3d+zqbNHWClu+NiuKwEQ+VZ
	mI=; b=d0ntusoIJf275ics+BGeHpw3GSoZY2PMwC5LCy+IyPQKrG/rj2pbk/QMV
	iJdJvxY8S11uuVRhrwyrkq1YA13+WCI1FMXqgfn/feU6PdTbKZbZ0vhKo0ySF5QH
	QBi5F4GIfatKQMGNpdjZSA1iqtkjHdTIYzTxagcuGlDKNUlqUw+qpiA8cm2QIw2S
	qlFKsJm0IHTwIxFUP3FQJtPsSKgqkc3dpQkJyAkPPjov0Vw6daTwMsB2Uquj3yTn
	hFBF1YIV1Q+nFw4K1pIB4a93EcP9RslLKuj8VtnsBzFh9l+wPa+JeJabwi85yi7C
	B1XKeC8jwhyQedtI0ygQUDjvIcAMg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44p7r6y05d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 13:08:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yp8VrFt9BpEg8Yj5Pc7K56h/wVBaW45Y+UUKAsM0D1iNU7xlFDjwt5F6brLprcFLqyxWSOjQkz3ExUVU0Ar4URq0DT3D8VBuM2BagJTq0r/+2+d+UpFAAk5cgQqwo8xnbZnmMhWFBEY4HZLrz4amZ/+3lMM2vpLM3GDBCYDZ5qxRqAmOyQutnBM5d3PlAsx2svc/x7tHlsRiHGMU8T23f57/61MG9JS1Po2KnPai95/hQuzwNNbRlwhxEyzSHqHZ27mrW2Jvyo+cfOThJuT5I6xJuB42eMvSFjF+B7PIcxGZn6gnj1tQ2u1q6i8QWqKYqvo/cgRX5/3pojWaHmP+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCaR8k122YP+ycys6W3d+zqbNHWClu+NiuKwEQ+VZmI=;
 b=Sfz6IQE+ufmbs3RbOGYJZLevrhh2DKkAlZGoMfpxVNekcbypqu/n2BvzjB62mtCgJ2MJEZDWA6gh/2+sDbRYa0Ef8PJqC2ao2WSk6bACMP4l7iqIt3EvgbcUCkVVyRUiVm6TsZUtpJ8d3dF7MNEWmL1eciHJMNmHdeRJBnVOKOkG7Ua4Q2g8MSZbU0XPZYkoJAj+NBdiCp8oKHmzMNHBXQngDSVsqHrFpot65JB2r+QsChk7HXNUSWkhCHIX+tzazZ7mzGMAQV0Ws4W/bEPWRa4fUiN8aZ0Z10PgXioph6LxuVe3+881UJ0OGRg0tgGnbdu0zwd7HU0mB815s7RneQ==
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
 21:08:22 +0000
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
x-ms-office365-filtering-correlation-id: dafef007-ebbf-4f49-adb6-08dd4ae037f5
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2ZBRjNmZEwwa08wa2piMndqOExlYXd2dW5lVjZaV3V1c1dCc3pjYW5JSXI2?=
 =?utf-8?B?YVY1OTQ4TXNDWlZnMHhBbnAzeUtvWmo4UDh0Q2RJT3ZQbnRLdWdEbEh0OGJR?=
 =?utf-8?B?MGg3bkdlYTdNRFVnTWs1L0g1b05jVGdqNXZqVXArMU4vdldQanNRRi9zWENX?=
 =?utf-8?B?Mk1Ba2dXeWEvSlVZeEZJNVcwQ0lSOGRuc09ickp3MUg5dTVScWJQRVZ2Njl4?=
 =?utf-8?B?blN6WEhMSFgwSDlxNlYrZllkUnlITDF4ZENZbElLdnVzN3YwT3lhUC9QL0RQ?=
 =?utf-8?B?RzFtTUlxVXV2dzNraTlSK08xMmRxRE5yeWlMQzNBYXZGMWVSZUhKN2tpNFVW?=
 =?utf-8?B?cXc4a0hpb3plY2taUmJHZ0UxRXFPekp0NGlxRyt1YzNVVklEd0sweTFrVXd4?=
 =?utf-8?B?TmxjVEdpTFUyOU9BVXpCNFZhR2hvVWNBdmw0WlR4U0toSFI4MTB0RjFERE95?=
 =?utf-8?B?M2RZV2pOSXRqSFV0VUd2Tkh4RzRaYlNVaEppQWJRK0xmb3o2TUEydnZQNHlk?=
 =?utf-8?B?UEpYd055Zmt0VFh5Qk9lSDFwVlE2RWVId2U1ekU4cklSK2dPRUJEN2xjM2NO?=
 =?utf-8?B?SElsY2Z4YjFLTy9Na1Znc1RiVEQrZWtzamN4K2J3ZzlTQjJ4STNscHM0N0Mv?=
 =?utf-8?B?Vld1NTBJNXlsSW9GQ0hweEh3TEhPN21JNi9la3FzRDNwaWFZRkpWWGVaUFN5?=
 =?utf-8?B?d3VQS1R0ZXMzMDduK3pHSE5sWkh2dGlndno1YnYvbktrKzVpMU01TC8yMFBz?=
 =?utf-8?B?YVdsNFBlL0wzQnB0bERPZm0ybFExWEhIVVBubHZyQkRqVU1NalhoT2JjRndt?=
 =?utf-8?B?ZTNwN3ZUVndBbVlPei9XOW4yWktBK2lZMFR4Qit1YXkvQ2ZOLy9OTkREY0xn?=
 =?utf-8?B?NUZKYUE4V1kwcEhvVTh2enU3WDVtQWowNC9HQUYzemo3blIzUlZpZ2prbzRL?=
 =?utf-8?B?SDZ0UU42cDhtM1J0Szl2dm1HenArTGh6VVI0ald0TWFrRjhIL0xuUzZNQWYv?=
 =?utf-8?B?SUxORTN1TDdsSEpZV0l6MVc0Z2RtZFJYM3dneXN0Nk5sVFJVVlFHdm9Gc3cz?=
 =?utf-8?B?TE9QamRsSXljUkw1aitBL3kyNGY0Qm9ZbHJ5WG1xTW45MUx1Vk9CMzBqejdh?=
 =?utf-8?B?bnhYNUVjWGNMRlJ5R2pkZklMZU9VUzJuVzk2M1NlbGh4UjBTR2pTMk5lVlBX?=
 =?utf-8?B?YmU1TmVXMjNsd0tpMTZzam9VRWpTdCtmMWlFTXRZeXFtc2lvUVRuQUt3bTFK?=
 =?utf-8?B?YitlRmdqcnlPbEtRbXdZeXUvMlBFNGlhazVJNVhiM1AzSzhVQ3hqc1BhcXR3?=
 =?utf-8?B?TmJiWk1RK1V5VnZ1QSs5U3QrdXVjVWNwby93MmxxQXNkbVZFYzRWb3o5Nlpj?=
 =?utf-8?B?eTJGL2poaVBSLyt0UnFWdUZuVUtGVnNpbzc5bG9rTEptWHAvMlN0UkVkVGQ3?=
 =?utf-8?B?NXAzV2U0T3hxWnUwZ3lVeEIzYXdIdk80QmFuVjJhVnd6WFRxVDVNSWhqdUYw?=
 =?utf-8?B?QWFwWUJiVThLd3JXZlpNcTdVdUN6eWZLZVl3ZjJGN2pXcUVsU3NpOW54cVlS?=
 =?utf-8?B?czJVcU41S1RHZlZiYjViWmI0WXRBbFF5WkNyandRRGc1ekZpRmJYcXR3NTk4?=
 =?utf-8?B?Q0Z5SE5jQjIzM3VvcGpBdkhPL21tVnVPOWhGQlFBdXFEM3M2VTB1d1NyNWVZ?=
 =?utf-8?B?UzdoUEZhd3RzM0F3dGc4WlN5d0gyVXpteGZsWWk5dkFKelBrbWQ1SEMrVktH?=
 =?utf-8?B?TmdrYkpWMmhSdXdHQzBucEhkZWpwMnI5T293Yzh3RFBjUmNodVo0M1krQnZh?=
 =?utf-8?B?UWNjbmttYzJ6bDZIdGlJSk44QzlMYnAyb3NKaGUwa04yczBZdmc2dno2Zjhz?=
 =?utf-8?B?ZGlHbzNyL0M5UndVb0JSUjc2dEhYUG9QcTVLRHZubzcvclQ4a3l4aXd2Wlk1?=
 =?utf-8?Q?qEyA29C5nqdZsaXjHxzjBVeh9uX5AXoK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckwrTmROclcrdGlQNlRQMzNhS0JtajRlYXBLOFJGMU9oc2s2STJhaS9jOXBK?=
 =?utf-8?B?MVorOXRYUzI3Z2pjSzJpSGFueGxDMWdXa3VZUHVtU0V3dXg3MHhxZ2NNM0Ft?=
 =?utf-8?B?djB2VVRaUDVwNWtVclFSSjhWdzVSVS9wZ3V1YVRVdDQ2bnp2aVlBTlQzWnhi?=
 =?utf-8?B?YkVHaGsxMVJPQkNVVk92OFFsS0RaeTkwRVlTbUp1ODc2ejhMaThqTXdiRHIr?=
 =?utf-8?B?akxDaGtvS21XYmpQcEZUdUw5T1JxVGtyZ0h0ektLL1VKZUZ4S3BqUFk0N2Ny?=
 =?utf-8?B?QVU3alZaMFRMRVlpU3E2YUEvSUxZcXpZNWo5aVpsWVJWbStLdFBLSDNCUERB?=
 =?utf-8?B?bndsOXBud0htaWtnMGpmWU5sc1IycENpcU1zT0VqZTRJZkNkaVZ2RkhRN0Nj?=
 =?utf-8?B?ZXpHMFdHNnI2aUdLTUZGSVhDVklCSHpxUktOVnJjOWNoaGNSSkRVMVBRTmdY?=
 =?utf-8?B?dW1ZZXdhYXlRU25NV3JhMVYrRUIwRm13NzVnK1JabmhwcnNlUmJBMFlVT1Z4?=
 =?utf-8?B?aWNta2JzVTdCNU1xOHZHM2J1c1JkckIrczJvUDB6VTFzM3RDbi9kYUNRSVNn?=
 =?utf-8?B?aXA5bXV2SURQV20wcnI0N2tHSk1Gd0lianNqRkdYZ1IzTW90MGZQL2dQUER5?=
 =?utf-8?B?aCszeVhDTzBwdnlKak45RXl4RUFCSmFNeExHWkpUbFF4cXdUVDlWc3UycFB2?=
 =?utf-8?B?SUJMNHhaVlRndVkxNlp0SVVZWWoyWlliR0RLY3pSb09qRy84eXoyR0NqcThF?=
 =?utf-8?B?d1o0b0ltRHNaSTJZbU5YdEs0MUU0bkt4a0w0eTAxWjcwajRZait1VnI2QWkz?=
 =?utf-8?B?WXFheVdGT0RkU25BWTZXeW92WHN5aHZ4cFVUTnp5R2tDNSs2ZjdyTHJCbjVa?=
 =?utf-8?B?M0V6cWVaY0QzVmc3dGxpWmQzQnA2UEJzRU5CMk92bHFVaFFwaitrdUViQW9D?=
 =?utf-8?B?b1BHT1lpNTF1VnZxVVVUQVlzY0JVV3hmcjIvL0JKbmhaamYzdXRiZXNFMlU4?=
 =?utf-8?B?Y2JSenR2SGdjVmk1WGU2V0FDbEUwY0dLZGxOd2xmODdRWU5xZVYzTlIxbWN2?=
 =?utf-8?B?aVFMODRjN0UzTGJ1N0pjcEV6WUFiNndFRHFmaE1pRi9sNzJxZ1BIY0tFVi9U?=
 =?utf-8?B?eFE1cEszb3gzaE5ydXVET3plK1Z4T056RmFpbFNmZklSZnM0N1dnWERLbm9J?=
 =?utf-8?B?Z0x0bVVDZkJvQVhWcGhhME5DenhkN3A5U2J4NURBZGYveVZqNXZBUTRWNHRQ?=
 =?utf-8?B?VnNwV0w1b0Z3ZGxKQ3JPbHo5RW1tdWE0UThBOFdGalkxL0tqNVZpSkZjQUls?=
 =?utf-8?B?ZGxUbEh1R3VKR1duU2VqWFZMMXJ3cFUxeGcvRkQwem5CaUQ2MVNEYlVySWJT?=
 =?utf-8?B?UXlUK2xYSGdOL1pXbzdTOElNOTcxelZCcHNTRUR5MmpoaW1Wcmp2U2ZQOVVo?=
 =?utf-8?B?R2VFRXpiMkhoaFpmOXRXU2V5bEFPNlFmdVgyYXZKWDBUUG5Gbmo5Vy9ybWtp?=
 =?utf-8?B?UUhmZG1UVE5HSSt5Tmd1bGtWb2hzRWtYdlZCTHNRWDYyVHRkbmQ2MkZEQVNk?=
 =?utf-8?B?L2FTd3ZBd0NnYUl6QWVCSm5USE1ja1cwbnpwdWduZE8wNEgyTW81Rnc3UDg1?=
 =?utf-8?B?UG8rU2w1ZEFVSnpZa01aRkF1eWgxRVBaUFJ0VVBON0sxVTBUSHJkTVBkNllW?=
 =?utf-8?B?TktKbUhIcjZPMk9yUXI1eHZLRVRTY1UyRER0NnE1WUZobFJvN1VTMWt4K1BU?=
 =?utf-8?B?WjBkaStFYTRYQkJkRmZId1pQMWxvTGtoU3A2VTRVYlk2L2NicTdLWHlYb1h5?=
 =?utf-8?B?c1hsWklkVm16eVZLY2Q1ZFQzVnpKKy9GYUROQ04weUxTRTYrWDUrbGFPRkVl?=
 =?utf-8?B?SHoxMExwWk51a291dUxwUDJib0hOZEs1MnJ0bDMzZFIwQm5wbEl0a0NFVnNa?=
 =?utf-8?B?Zmlld2Z0TmxhT1gzSGZOYWVLMlpvb1RnajNwTzhmcnlZSEs2MEUxT05iWlRj?=
 =?utf-8?B?cW9RQTNMS002UXAwTGVyOFZVOEI3dy91ZHBPWXEwbExrSGtzSkxveFZDUTZk?=
 =?utf-8?B?N0JCY004UlFqTnZvd21RSytGYlNEakYxb0lrVFp5Mjg3eDdGZU5kNzdJcHJF?=
 =?utf-8?B?STVJeXZPZDdTcnIvWnJLL0FYUlFGQUNxWU1UaW9XdERsZEsvREJVSTdFSmpX?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A57241FFD161641B24112A33E892D7A@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dafef007-ebbf-4f49-adb6-08dd4ae037f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 21:08:22.8357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2JVtSOWHkZKvB4z7R/lHfx+t8Oo9RfAdBYV9C+2PQ+gFkfeCovE/fvwyqGwR67c7ESm3v1IElG9KrOJ+z5pUGyoh6N331ZRJScn4kulfJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9903
X-Authority-Analysis: v=2.4 cv=C/cTyRP+ c=1 sm=1 tr=0 ts=67abbc49 cx=c_pps a=sGbpJkUcFVeWJOR+0qTsNQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=meVymXHHAAAA:8 a=64Cc0HZtAAAA:8 a=NsMYafbshvsK72VilBsA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: ZVQFwnRHHA_kUggNG6-DGR8ByVVCSMN0
X-Proofpoint-GUID: ZVQFwnRHHA_kUggNG6-DGR8ByVVCSMN0
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

