Return-Path: <linux-kernel+bounces-409810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD0F9C9206
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB426B24008
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05895199E92;
	Thu, 14 Nov 2024 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="L9oZKE3k";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="lDjoOtvW"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3717588
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610777; cv=fail; b=QmUCfzYV5ljaDAaZqkZyC1MTAaIHbPdq+/wJ7KE94LeL7r3DFYjCE1Mi+li3AvM8vdnnfygmKniymkYd5RVWa7a4juOa5SzQ9NI9EnkE8Tn8sn85H74pB+NGQN8l8ustrQ7BbgWAGhZ4uLh6UdrxDH6luk0A5zncuJNQ7phzuMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610777; c=relaxed/simple;
	bh=DVa41kmJsFC9bXNA6/UtF3SkTT0tmRzKi6Q7dII2HqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pHjp+2lcSNSFIkbYZAX0g/iryAtuKZf+V6uylBMzs0oQuuTv1yfofqSpXLxKYQBEF0EDBbn0lzG/VQKAYHSf/qvvmZAvsRRjico2rzAnUB7ofoKq3x60jtZlQzogHJZDY0Z3XSD3q1Oc3LQefx0zp6gq4dYXYcQ6vO9O04hUVFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=L9oZKE3k; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=lDjoOtvW; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECO3t5006822;
	Thu, 14 Nov 2024 10:59:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=DVa41kmJsFC9bXNA6/UtF3SkTT0tmRzKi6Q7dII2H
	qU=; b=L9oZKE3klYaILPqeTcahw72J/kAnux7XOqWvvlD/nif6rJsxnydWqhZSQ
	2rY1unYhKpdIGZtlteA9WPXDRh47rJqvvkLk6xyzS6CbPl3Kmba8mNjF0VK1rFmF
	laLyGtLucjfq5byXTjg4nB70hurrGEllVHTRNylXb1xPvzHO3rCsoI0gKIiV0USR
	j17xtnDjVAa+AuOAz4mEJnn9XvNC9RNtlg0wHbCUkntioTc4SuNZDbbWyGoITYu6
	isf9D66NvxWVIq2m+X0DcmUVH8CMBkGrwPVBoQi8IBIa8rmA4fOhOVqyCNfDv2Ol
	duAfk7VIcbjmiuvmVcAyoVovT+aXA==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010000.outbound.protection.outlook.com [40.93.6.0])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 42wdx6h870-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 10:59:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKLdm5GXqfAIbIBAjq0Ui/N4qex3rv00Xhb5rgrgZnRVYPPqR5So0akBpTo1HuN4PBnXJf6naoebqCFk1M952AF2RXuRgcmUoLIsf3lfF4GOTJ6RgknJT5U/PxBK7ypo4ez0q5psRQcODFj62fxSGHve+YL9/zWn1Jh0/WUXrlbrwHzA43lvbpVSUE/gusDoKthgajJ1uT8vaxr8KsH4Ydv/cEpGogKnW04YrS3kjvKb5fMdoEI/4dLn+qKZFJJ8fRBw6tkGYTU7UtDCS+2wTPD+KoUmiKm6FjRyn+J7oOolQ+ZP0C965zkFwneUDAJnIIHIW4FSvDQnKRcrUakJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVa41kmJsFC9bXNA6/UtF3SkTT0tmRzKi6Q7dII2HqU=;
 b=HYKaLC13aGwL2sOhOH3xHpYpFG+1dlDzZWIMO8/LEmPHp6Us2ONlNQgEBevEyt/WB109YETucfJfZDlhOTxnPD3LHXaMV8kLkRp5LC1H7ojCqPzoJaUyggrQZhREXwUxHR8zEC/765KA1V3VsZhJ+BmC3HQBQ5j6IwdMOEKSRLWlY0slVN2sG7E5gQzZDdS/UkK/vUPjHt3FKvkKhIoyYA6rYa3n3wZIXyjSoUJ6HYnjaR9dDpo6ORqyK9fwEbv1f1EyJsFhTKNk1eS5LHI3AhqOxopFaauADp6cnxWvEwJbaZjJjXavywl9VA5yWiGe8BKblH16yGhjAlsV2VORNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVa41kmJsFC9bXNA6/UtF3SkTT0tmRzKi6Q7dII2HqU=;
 b=lDjoOtvWlSCmz4fEHODEtqBTd3kRJ88ZhIuM09wgQIk6p7LUjZYiRrxyL4Qp99yAfKtFQE6uX4EXfAQTgPaplJUZGFR8ba2CKPuyU69nr3k7Xmn2IESSqBN/aE/+vpRDfUDqG3TaGKSvcurQk7/TeH9YSN6T/CijYDSO3rZgLGJobE/0ANq1EZ3E90q/4cRYw5wia4PpqJ8HWD9dimBHiHRSr07icsSFNg9afvFrOrwGo6J069aW6t1aaXqe2ZZo/silvWPR9o3xEUzQzJi4QpAT0eJ+xQt8NzWUW8zTPOq3W0Mu/L8FrmtBNwgY4SCgJgt26mU7H3fCetwE+ECyUw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by BN0PR02MB8304.namprd02.prod.outlook.com
 (2603:10b6:408:15b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 18:59:15 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:59:14 +0000
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
Subject: Re: [PATCH] sched: add READ_ONCE to task_on_rq_queued
Thread-Topic: [PATCH] sched: add READ_ONCE to task_on_rq_queued
Thread-Index: AQHbNq5nba4S9Xi5pkOriC7mRP6LJrK3H0eAgAAB54A=
Date: Thu, 14 Nov 2024 18:59:14 +0000
Message-ID: <6A546A91-A80E-4D4C-9898-5EB792E19635@nutanix.com>
References: <20241114162128.1818680-1-jon@nutanix.com>
 <20241114185215.GF471026@pauld.westford.csb>
In-Reply-To: <20241114185215.GF471026@pauld.westford.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|BN0PR02MB8304:EE_
x-ms-office365-filtering-correlation-id: 87ac76df-8d4f-43d5-d84f-08dd04de6f0c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWJhNFVsWm80OC9FcXE0QWRmeHBUeDdtSFBiVDZBbWFqZmJpUmZDZ2ZrcVFY?=
 =?utf-8?B?RXRURHNkbVQwR3pvRHk0dzZqWlR5YXpGd29vME5yQy9XUlBXTWsyNkZ5d2ZR?=
 =?utf-8?B?ajJSOTA3YmNxdG1tSlBIWUNKeE8xVnZENTFLT3VlVzR5NC9pcURISW0xNjls?=
 =?utf-8?B?Q0RYRmpLQVU4TDJVWFIxaUYwaXl3MHRqbTFwWlkydzB6L2U2TWxQRm9LNU5y?=
 =?utf-8?B?UFA3Y2ttZ253TEk2a2dVWGlMT0F5amlubHRkbnlnUjdic1R5d1cyTjNJcGNn?=
 =?utf-8?B?YXg0YWpGUVF1TTBBUndVclpoT01BY25WY05LNDNFaGlmZ2JTY2Z0Q2VnYjFV?=
 =?utf-8?B?L0MrRll5RElubG9QRS85ZzNUalloVnB6YVRKaVFnWDBDMHdLZ0lDTEg1K0FC?=
 =?utf-8?B?dzg1TkhRVUY3V2FLNk9RaDdNY3VvYTU3ZHhmTXg1RWRVcnhtV3hXQ0xjK2xx?=
 =?utf-8?B?cVBHRkNOcTVOQWVrSFNSTFlXQ1ZrcHIrZDFSZytNOWJMVW1xZ2tsQWNJR2NE?=
 =?utf-8?B?YWFsdzRoNjhEcSszTGJ4Tys0RjVkZUZJUUUxbENNR0ViYy85L2dma3htZm5M?=
 =?utf-8?B?RitUdE54dHRGWHJjR1h3KzBrSUFQdWRzY2dpOCt5eUtjeDRFZUFZWTdZdWFJ?=
 =?utf-8?B?NmlzaUZJMk02QmNia0hHQjNkL2JGVHRzSk12WWRJQ3hSSVRXL1Rab3ZsZDc3?=
 =?utf-8?B?LzZkS3k3ZHBzZHRyQnp5aUIxWVYrRUEvMkc0TWZwWjBkOWoraklVYml5R29G?=
 =?utf-8?B?ejdaTTh6bzZVRTZFdW1zcXVvckhHMmFyZzFCMHN6ejVYQlYzY2JqN25zSjNI?=
 =?utf-8?B?emFNTXlFU2IvMWRrOUFFSE9vY1hMYUx1Rlk0SG1pdXY2aHhOYkpZazNXUm5M?=
 =?utf-8?B?ZEs4RGw0OVhpRXc2cUlGZGJ1ZTFQNkV1MUVFVnpMMkpWZHhNRWFKKzVOMmZL?=
 =?utf-8?B?dFZETFR4aGczOTBtcHVvSHJjcUtsWUtiRE9HYjBWcG1uZUNBYi90eW1sTnhR?=
 =?utf-8?B?RWF2SDZzTTRQR0dvNmNJbkVWTlR6cFB6UDhOamhDbzE4SWJiZVBJemJpK0t3?=
 =?utf-8?B?eXhyWUNzOFBBT0x6UlhSYktJVlUzU2V5endvQ1ZQVEt5UHJJeitVTHl2OEJi?=
 =?utf-8?B?WWg0VE1HYm9hQXdvZHdCcEF1bzduM3RyK1NtWGxlVHIyVG5KekRNV0RJdW5C?=
 =?utf-8?B?NmxjQzlLa25vUlY4eURqejc4aDh1bmpHUDUxc2Q0NmNFMXJ3cUFjZDZ3Nzd1?=
 =?utf-8?B?RmhTVWtxNm0yWHc4QkVZRU05akUydERrRWtKdUVSMmlOdklZdWwxampMNXZy?=
 =?utf-8?B?b01wcnhCK3JubkZBK0JSR1g3MWVEdjN2WGZrcUhmS1FFVFNiaHlVTWVBTkxw?=
 =?utf-8?B?UHpDc3VkTENnSnEzcCt2UnhKMUdORlI1SUNHQm9yZHBiblpjVDJjNTdkQXF6?=
 =?utf-8?B?Mm1PeVNrUzc1WDd4MTZFRHFreEx3MW1zeHQ1ZEJsSHZuNDkyQjRYOXN5enll?=
 =?utf-8?B?bkNEbEdqMEthZCtMdDVOdERQczg2S095Z3ZrdkNiRExGZXE4YjZXdWFWSk1w?=
 =?utf-8?B?KzQza08wWENib2trWFQ1SDhibzhUOFVUelB2VXVuVTRTYkpaR0twUGZUVXV5?=
 =?utf-8?B?S09uUlFwZ3RkYW8yUjBLODg4cDl3THlKekNIZVg3ZzNKWHRnSU0wZnlKYTY4?=
 =?utf-8?B?T1dTdFA0MDZ1c1JmWUluSFk2cjJPbUo0YVlQTEZ4eVl5SldnZWZvQmlhRkdX?=
 =?utf-8?B?V3Y2TENURzF2MzJvUHNTTDJhT25pL1ErQ3lRQ3VBeVBXSWZqQ3FFcXFWeDMw?=
 =?utf-8?Q?Z9jMkXsywiu1JMQhd7Xn3oXnO+ajDhBv/y/oQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U21HTExPRzJSY08vWCtwdS90aFFSaGRiU240QjhDUjlSOG9Sb0dtdXNBNEdG?=
 =?utf-8?B?ZWJGYmtWZkNRV0w1b2FFUk5GVTdPaTVFZUNzWGQzaHZ0LzVsc3lzcDRXcGpN?=
 =?utf-8?B?YmFuT0NBSTZvYm9paFpwOW4yVXQxd3gxcUhjeTl6ekdrUldsbEtDUTdnbmtM?=
 =?utf-8?B?QTQ3TWZNWGE1MVhXYXlkbHhPUXE4WUpCYS8yZEsrS2cyS3NGYVhTNlZaRmZj?=
 =?utf-8?B?RlJZZkF1U2ljZ0loNG9mUURobWVGSUd4MkxsTGsyNDdzWW12QW1TKytXNVdQ?=
 =?utf-8?B?K1hNVy9qMUoxajdMUDZrd1piVUhCU09vYVZCRHhRbFJ0eEpGcGN6M0duYXcx?=
 =?utf-8?B?bm1CbWs2MjA0RFc4T0VVV1lEbUl3Vk9WdEJEaU5sTW90YVYxQUpUSmpNbmUx?=
 =?utf-8?B?WEFZN2I2Z2dpSTRqbm5FdjFEVWFuQ2twZjl0M2NRdXpXaGNiN3lnbVJscmFq?=
 =?utf-8?B?VnpZcTQzQkJxR08zekwrbzcwbmVBREc4NVNYZ1ZnWkp0eDZ3RDlMTnE3ajYy?=
 =?utf-8?B?eUtad0QwZ1BscS9Rbk1wQ1lBekJ4N2FhOGRGQTZReSsxN2FTMmNFZjZnaVZP?=
 =?utf-8?B?eUhRdEpOMnk4eXVhVXhKY0Y5YTNsM2k1Y3pMRVNxbTV4VktvMGNxQ0pVenJ1?=
 =?utf-8?B?SHQ3eEVFYmJ1dzh3aUlWMnFvMW10OThyVjYxcUo1RmJzeEJFQlFBQ0tnWTRm?=
 =?utf-8?B?NHd4dnVuU1NZaTdOdVdIclFKaFZnVVgyUmdxMmpKdVJvVFM2RS91MGEwSXlk?=
 =?utf-8?B?ZXRIbDZzMjRCMkZCUzhsaEl1czdZV3FPR2lPNGxHbkZFQW1aa0lNa3pHWXFu?=
 =?utf-8?B?YUpKVlcyNjMrWkpkZ0RCRmt6Q1lFTmtGaGNWVm1XWmVXd0Q0djJVVzhDSkVQ?=
 =?utf-8?B?S3hhWnhlSUdHVml0OUE1K3F2ZXhvL1RhcEdDU1JuV01Ed3hZS0lBWFVHNjEv?=
 =?utf-8?B?R3dDcG82QXhzTGdxLysvdGJtdkxkUkFvNmpDampVUFV3UHFheGI1WStWdmFC?=
 =?utf-8?B?Wk10ZzVpZ0lyYWtUQ3lqdEtZQXoyanhKRmxiV2FVb3hLZFJvSkxqMnprcjkv?=
 =?utf-8?B?VTlHbHljb1prYTVBbERsd2VUT0MydmZKazQ1cXFuZSs4Y2NyTVk5MjJhRkpv?=
 =?utf-8?B?QTF2T25mc1JDWk1BWmFHTC91cnllenExblRqZXlXT08rNXlSUEV3c1Y2RnlJ?=
 =?utf-8?B?akNNcWVNTHZKem0wZExTckI0SXVaRW5ucVNrWTBDR1FvTWF2cTdxWGE2bGpE?=
 =?utf-8?B?My9NSDl5WXp0eDBoNGVJdVNjRjdJZXBtVFA2VXRkM1FNSVQyN0V5OWdNWU1q?=
 =?utf-8?B?c2tNVDNMSEJxMlJ0Y0U1Um5FL21YckhIeDJ6WE5YSE5FWlNIRjZYVytscFpu?=
 =?utf-8?B?bnFNekdUZkdNTU1aemQ5K1QyVWU4ZFdCb2t4dkZZa0tDbGJ2b2pGVnZPZ01P?=
 =?utf-8?B?clpWVmRzUGU2VEthUkhuUVlWRm90bkRvQWlKWnVvM1RqdEkxWVBWMDg0QTc1?=
 =?utf-8?B?MGN2a1V4cjJCazFUK041cUlOV1F5eFhtOTYzeDVqMEhqZW0xNzYwakRUUnRE?=
 =?utf-8?B?QjhUYzZCL2VQR0VScGo5dHY1Z3Njckd1TnB0VjE1MXNZUmtwd2NVaUR3dXA2?=
 =?utf-8?B?WUxxTXNqQ2w5VGVDSFhiaFdkdmNNQXpObWxhc2QyMHNZQnRwTlpiNGdxdlRa?=
 =?utf-8?B?OUxvMy9UY2xMU3pUVDdqdURlZlB5M01UMkl0eUxCSmZIc2JmTy94UmI1RUNH?=
 =?utf-8?B?NXFkSk5CSExYRVdwdURyKzFBc2c1VFh1NWNucmV3L2FjVmF4RG8zM3VlbTY1?=
 =?utf-8?B?bitLMkxMVk1NNDBtU2lPUFFoR0crSGhPQTVpeTUxalpUUkRwQmw4RzN2NjIx?=
 =?utf-8?B?SmFtSmtIMm1UbGhMQUxmUEszQXI0SEg3WCtNbTZ1TFZjc0kwbzh0YVQyOXo3?=
 =?utf-8?B?a2M3REdSUEh3ME56RVJicU55eTBTZUdEalNsR004eGZ3cHNKRENwR21Paktt?=
 =?utf-8?B?RzlNSVk2MmtKZWx4dnlCRG1UN3pQUjA5MFhvNGQzWXIrZVVobTJRUW9COXNI?=
 =?utf-8?B?d012NENyMlg4SFJOTU9rSzQyVHBodmh5QVZLYUhlVXFnUlU0L2hBcDNZQ0Q2?=
 =?utf-8?B?bXRGSmE3UTcxTDdwVlFUVk9DanFtSzM0TGdWSVJPZGZBNjkxZ2VtUjRvYkha?=
 =?utf-8?B?RmN4UXlGS2NDNWZEd0xVU3U5eUY4TlpWdEV4T2xjZzJUNVNCcExGWW1Pc3RV?=
 =?utf-8?B?RGt6NlI4NWlXTkZFOFhMd0I4SkdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76383205F660464DAF474E36BB2C6584@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ac76df-8d4f-43d5-d84f-08dd04de6f0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 18:59:14.8296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryJTeaRlcg6uL4E4dklwQQGL6ovTCXv855bFStkifw2VL0ahelAp2gXettEwogW3tN/bJg4QKZTCVgo7UdkL7bhQD2qeRAN59xD55EqAsuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8304
X-Authority-Analysis: v=2.4 cv=XIpiShhE c=1 sm=1 tr=0 ts=67364887 cx=c_pps a=GHJUnOcs406mhZkDzxAeiQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=Ys0tfplDDKajKcny3_kA:9 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: yJHtwbUps4AEoPaW5mkesAa9v_VGYm7k
X-Proofpoint-ORIG-GUID: yJHtwbUps4AEoPaW5mkesAa9v_VGYm7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDE0LCAyMDI0LCBhdCAxOjUy4oCvUE0sIFBoaWwgQXVsZCA8cGF1bGRAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJT046IEV4dGVybmFs
IEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIFRodSwgTm92IDE0LCAyMDI0IGF0
IDA5OjIxOjI4QU0gLTA3MDAgSm9uIEtvaGxlciB3cm90ZToNCj4+IHRhc2tfb25fcnFfcXVldWVk
IHJlYWQgcC0+b25fcnEgd2l0aG91dCBSRUFEX09OQ0UsIHRob3VnaCBwLT5vbl9ycSBpcw0KPj4g
c2V0IHdpdGggV1JJVEVfT05DRSBpbiB7YWN0aXZhdGV8ZGVhY3RpdmF0ZX1fdGFzayBhbmQgc21w
X3N0b3JlX3JlbGVhc2UNCj4+IGluIF9fYmxvY2tfdGFzaywgYW5kIGFsc28gcmVhZCB3aXRoIFJF
QURfT05DRSBpbiB0YXNrX29uX3JxX21pZ3JhdGluZy4NCj4+IA0KPj4gTWFrZSBhbGwgb2YgdGhl
c2UgYWNjZXNzZXMgcGFpciB0b2dldGhlciBieSBhZGRpbmcgUkVBRF9PTkNFIGluIHRoZQ0KPj4g
dGFza19vbl9ycV9xdWV1ZWQuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEpvbiBLb2hsZXIgPGpv
bkBudXRhbml4LmNvbT4NCj4+IC0tLQ0KPj4ga2VybmVsL3NjaGVkL3NjaGVkLmggfCAyICstDQo+
PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4g
ZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9zY2hlZC5oIGIva2VybmVsL3NjaGVkL3NjaGVkLmgN
Cj4+IGluZGV4IGMwM2IzZDdiMzIwZS4uZGJiZTVjZTBkZDk2IDEwMDY0NA0KPj4gLS0tIGEva2Vy
bmVsL3NjaGVkL3NjaGVkLmgNCj4+ICsrKyBiL2tlcm5lbC9zY2hlZC9zY2hlZC5oDQo+PiBAQCAt
MjI3Nyw3ICsyMjc3LDcgQEAgc3RhdGljIGlubGluZSBpbnQgdGFza19vbl9jcHUoc3RydWN0IHJx
ICpycSwgc3RydWN0IHRhc2tfc3RydWN0ICpwKQ0KPj4gDQo+PiBzdGF0aWMgaW5saW5lIGludCB0
YXNrX29uX3JxX3F1ZXVlZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApDQo+PiB7DQo+PiAtIHJldHVy
biBwLT5vbl9ycSA9PSBUQVNLX09OX1JRX1FVRVVFRDsNCj4+ICsgcmV0dXJuIFJFQURfT05DRShw
LT5vbl9ycSkgPT0gVEFTS19PTl9SUV9RVUVVRUQ7DQo+PiB9DQo+PiANCj4+IHN0YXRpYyBpbmxp
bmUgaW50IHRhc2tfb25fcnFfbWlncmF0aW5nKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkNCj4+IC0t
IA0KPj4gMi40My4wDQo+PiANCj4+IA0KPiANCj4gVGhhdCBsb29rcyByaWdodCBlc3BlY2lhbGx5
IHdoZW4gc2VlbiB3aXRoIHRhc2tfb25fcnFfbWlncmF0aW5nKCkNCj4gcmlnaHQgYmVsb3cgaXQs
IGFzIHlvdSBzYWlkLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBoaWwgQXVsZCA8cGF1bGRAcmVkaGF0
LmNvbT4NCj4gDQoNClRoYW5rcyBQaGlsIC0gbm90ZSwgSeKAmXZlIGdvdCBhIHYyIGNvbWluZyBz
aG9ydGx5IGFzIEnigJl2ZSBidW5nbGVkIHRoZQ0KYXV0aG9yIGFuZCBjb2RldmVsb3BlZCB0YWcg
ZnJvbSBvdXIgaW50ZXJuYWwgdmVyc2lvbiBvZiB0aGlzIHBhdGNoLg0KDQpJ4oCZbGwgZ2V0IHRo
YXQgb3V0LCBidXQgaXQgd2lsbCBiZSB0aGUgZXhhY3Qgc2FtZSBjb2RlLg0KDQo+IA0KPiBDaGVl
cnMsDQo+IFBoaWwNCj4gLS0gDQo+IA0KDQo=

