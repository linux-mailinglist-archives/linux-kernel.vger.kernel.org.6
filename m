Return-Path: <linux-kernel+bounces-408427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FBC9C7EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576B5283745
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758F18C91E;
	Wed, 13 Nov 2024 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UB49dMPF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ePNkyU9s"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93818BC2C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731540315; cv=fail; b=MXaDiAgwKz+Gj1ocZQxltmAQeNdHlaVNNfK6oyzRV7w7WVspWvYw4X8FWv87ebdRv/Lex709e7xLSPrfQSH3Mdwe9RfK+KhQ3OjAMGybuQ6Hfy4rGWlW90TfepqbiFZj3HoPTyG6Ju3FO7rC3lxJTBhQx31IOPB4hMmT+OkR5us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731540315; c=relaxed/simple;
	bh=Zu99iImvj9sygy/lTWLqilFZTWuv9+0cJ/Hm1zpJmCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gaIqx90v8meiQjRC+WvmWIIoQEsGPPetSffOzrbimvZUgKgeNOfpdEBM3YluNPP9FTsceRVP7IANyTM4/3d1/YG6MsW4HmBRPOB8Kydi1pSH7wpN2OK4g6csBHR4hBSKYOgETmyBHepldLgHPHnLPQYaQZSkQBWDTnKQZ+uv3Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UB49dMPF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ePNkyU9s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNBduU007960;
	Wed, 13 Nov 2024 23:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Zu99iImvj9sygy/lTWLqilFZTWuv9+0cJ/Hm1zpJmCc=; b=
	UB49dMPFNh+bGc+HVyORjrk7tLqoAENrxqufdeYw/FPU9Y/sFS8AFNd9CWAavgNb
	TH5CPj8ECfFfcRimN7e94g2fv8AD3xnbq31zUDYP/xBwSixJ8zbKyK4TbZ577l4y
	bRWSB97YHRyAz1ndg0idBrcshyRu1ZNjfBZWok8vjzKr9saZvmDqIz5y03Xbva6S
	cu0h04uVOAfVAD23I8jYLxYFToQ2MuXu+x/BogLsZb4j3OorJMhaF09zDIMWy7Kg
	RpCj8ogDTBqlpencydyJgp9BL0joY7mA3gKZ2hNPmjH8L6AMGBmF68kQlKX05NWv
	NDt+aK0szF37zNttwfG0tw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heqy5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 23:25:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADLgGIN035888;
	Wed, 13 Nov 2024 23:25:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6a1dg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 23:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAxB1oZvhYJKMxSsvHQBSniSwTFyK/BZYd4Le7hoEXrLcZOTzmhj+WhrTgWERoZCKmVSyIwL7eEvE+4fS6vGcRdBzYJnFWiyK0elyTJ8SwxyLsZOtQceYT+kv+pRX2Y2f1133YnFDIb8OBOfL/vDgG67R74vft5Hz5jZccd4yiXEopFurTjUd8ymUPHyOSwmfxTWyjTdzW+hUfQPEvHCSvLovz6pGKHK9fE7l4gAushHGIS5yyB8kZtFEITAzT/NUHZDAL9M3tcYx1mLnfQSaZqQX48AtzApgmrr+i+7xjbvtd1nnaq25MD7wOmTHhl65W8hLVAijZIJPZTMKtoQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu99iImvj9sygy/lTWLqilFZTWuv9+0cJ/Hm1zpJmCc=;
 b=BlawqG5YJKypgw6pTR63FaYrhQYPKMF1tq4lmy17txbBvBXdgqzrMjsjoCnPqxJQ6FVgVYTQ04wRmzzBDH3bHZt1htV5g4wPfYDQXktZwn9Zb2oKQjoT0Q4gVFhO3bAhnUh3/cZz+DFH4pr12sHHyG100V04X/bj2br9i0+m7Rdz8DmwOKXj30Say+Hm2lYY63edR/+KbdEEhyE8y1xPnLdzAd4Feb+Ebi1lZ7X/3gT/6x71setXWUAbN3YqoqgsgfOscg04X3bMGrnwzUKH6FkD/Oxxb/xinvYT0Aohqci+g30xI/5mIJ33/9E7E6ZV6qBO7MW7cVBaR85vocRPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu99iImvj9sygy/lTWLqilFZTWuv9+0cJ/Hm1zpJmCc=;
 b=ePNkyU9sv2x7wkkufYARQ83DCp8gKOLCxAKEACBUjkndP4N5kn4swjTfUIQFJGpNhZ1k80DpwGOzeaiyYwGrWsN0uf2xDmU2cgzWNfGTPTxaWs5otgv6YCht4G8+LGzlzHALfEz7cIKkBElWf113tyiHYv0lUTVx4OuNEcwn9vI=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Wed, 13 Nov
 2024 23:24:57 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 23:24:57 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Daniel Jordan
	<daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Topic: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Index: AQHbNV85xP8mG8bGMUONwn7IqXYau7K1jv+AgAANEACAAAlsgIAADSAAgAApGgA=
Date: Wed, 13 Nov 2024 23:24:57 +0000
Message-ID: <CFB8E54E-0E12-438C-AD10-F8D2AF2755E5@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
 <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>
 <6397d90f-1236-40e8-af8f-d89174ea1d11@efficios.com>
In-Reply-To: <6397d90f-1236-40e8-af8f-d89174ea1d11@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|SJ0PR10MB4688:EE_
x-ms-office365-filtering-correlation-id: 2ae38555-96ad-43b8-3fef-08dd043a634b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NysvR0hLWThNTHFrbkdHRnhJN3V1TEVZVmFXM0Y5NGdOV3lyamZ0cjhmMysx?=
 =?utf-8?B?amlZUkp4OHNUbndUNm5yY21paFd6M0U1RWJDWHJQTDNyN2MvaUxqSXlZVFY2?=
 =?utf-8?B?N0R2M1BsTGJVQkE5eWZ3bmhsbXNOVktFSmMvWVJiUThUNWpCZThBVXNmanpY?=
 =?utf-8?B?aXZjUndnTWloMFFjNjdIdXR4VG8xeWVjL0JxaitJRmpKeVVsRTRIb0N4ZkpH?=
 =?utf-8?B?Q2hraDR4ank2L09vVGhuc3RWYzRKMm9iaUhkOG4rMTFiQkdkc3ZvNWdjbVFF?=
 =?utf-8?B?SVhGYisrMEFoVEpyeksxSVdJOWRVWllFQ2tlak96ekZpZXJ1b3N4UC8wUVcv?=
 =?utf-8?B?cEo0ell2bE5wdVlQSVRLVWNVdE9FeFllQTNvWHJjVjB2NXB5VDRwdGdxbVEy?=
 =?utf-8?B?V09uRDdkWDR1YmVwd2o5aExBM3FEbUN6WlVmNHExUnBjd1pCZzhzdVJFSjlu?=
 =?utf-8?B?R041V1pLRDY1aEhtUDFvYTN0bDRIdTgwc2Vud1F1SGN0THJyajY2VGpsSTBw?=
 =?utf-8?B?L3liRXVSUjlsTThsNzJ2akVhMU0xRmhXSzFuU2VYTlNPTVBYTmNHNkZiZDlC?=
 =?utf-8?B?c24xN1lFQktSMjhZZWY1RG15UlpSeXNrOHVYRHM0Nmp6R010c0hoMlJobDQ3?=
 =?utf-8?B?Q1lZdHpUWEc2L2cyNFlqelN4clVkc0JQcW1ScWlLZlEvc3NvMjArNTNHRHVr?=
 =?utf-8?B?TlRZTG5URVl3OU5nQWFxWHhLbHZTUkgvUjBxWUUvK1U5aXBVZmNqUms3RU1W?=
 =?utf-8?B?bkt4eXhzQ3ZUdEJSNE45b09ka2czYncyclI4cGdWNitkaTQ1Vmc2eHh0eG1n?=
 =?utf-8?B?emlCVnc5dnZGZkxUYUxTN0hKUld4ZDh0aU9mZlFkUXBsczVVSHN2WlcwL3Y3?=
 =?utf-8?B?cmNjNU1JK0RaNWpsZHNQZzZ4OVU4S2NFWFU5VGlVQ3ZRRFhhZGYrOVpxY24x?=
 =?utf-8?B?ai9OdlZNYmpjN0xYNVVDNVFVMUg3THVtMklNUFFNNktQSmhJK0g0a3dNZWtO?=
 =?utf-8?B?S3lEcUdXNkgrVW1FcTViMnlSelR6eTJ0TVU2OFZxeURhRXgxWGhDTTIxclBI?=
 =?utf-8?B?RVp4N0d1MDBWbTFwdHpKQmZUSTZyaysyWFB0ajR1OWFVYlk3blNERTcxUGZK?=
 =?utf-8?B?bFllMWFKaVZoUHRLbFM3YVYvWXNsSkFJL2hWRURMcUsxWTVlU0NycFQyQmxD?=
 =?utf-8?B?QS94YnlrM2ZITXZMNXNNNkorQktnRmJ3MU1YSlJEeEtVVURpblFOSklEaVpm?=
 =?utf-8?B?Q3FTMWV5ZS9oOENtNjROa0VvWlM4eWZzMkxSVXkvOFJuTXpNVFF3VUkyUFd5?=
 =?utf-8?B?U2hLZmJTYTBPT0YwYVR4bElBWGJlR1ZoUFlKbVcyWFE3SUpzNW0yd2NDZWEw?=
 =?utf-8?B?UWcra2lpbXE0RFJqcHR6RGQ2M3RxRHp5cEF3T0xSTXluNGNlaG5BbEhqcnBG?=
 =?utf-8?B?RFZrRWNISWIvR0o1TndYQnZnaGxXRkZmTERKaGlzalZYUXZvSmdiZ2hCNFJU?=
 =?utf-8?B?VzNSbGpoQ3g3bW1uU2g3MlQ4R0pacDJEY2lDcUxIWExpK01hdDkzaEhPOWxP?=
 =?utf-8?B?ejlGZFJSQ3J3REs0czhCUXVKNGxkN1gzRWlIUzFjSkdEWlRrZnNRQ2RTM2dz?=
 =?utf-8?B?cE0vRFE0djRTUFM5dHBuNWtoSFo2YVdZbTBtb1hGampoTE9XTkZrdXp0a2xH?=
 =?utf-8?B?Y01FekhZcTZqejlneEtRb2tiaHlWUjNjek0wYjNQNzV6ZDRPNzQ0d2tqc2l3?=
 =?utf-8?Q?LVEerDDaVHqqJq9/lvlA9rx/fpuCsVuhK5ikVas?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjRNbWtBUi9vVVpOL3BseVBWQnlHWlBMV3VmNjJoQW1SQkUrZnRJdndXQXhq?=
 =?utf-8?B?bXBtRE95Z3dUWUFYNnQzTGZOaHRTdWJhcStabEd2dzA0akN5R08yNTVWTHB3?=
 =?utf-8?B?WmVNZ0dJcDFveHM1MlcwNDJsZjhaNVVSWWZxaWV2RXBrYTdwbHR5YjZiVGlW?=
 =?utf-8?B?VXh3MExXcFBhcktOZHhlSXpTRllCUmtaelZ6TmxVaGYxOHdwcHVIQWhabGZC?=
 =?utf-8?B?eXdUQTNQNndtcFczbkIySi9MM00xQzdka1U5NFo3Y2NPR0RMbmoxVW5YUmw4?=
 =?utf-8?B?RW9GZERZYXdIK0ZPZ0tXSnNtOUtWQm85MU5zb1huRWRRaU5rSTU0TTBHQ2Rl?=
 =?utf-8?B?YXJCRks0VzNLV00vWXBFR3p1bEtXaUk0MGthT3drWU9OTjh4d0ppV05IUm93?=
 =?utf-8?B?cFdiSFY5TkpiL3VYT1paQjN4RHc4SEhHWXJlZ0s0TzVMQUhNYlB4OWcvYkU4?=
 =?utf-8?B?bkNNbFdCMWw1d2V2ZFFqdnFsQnhTOHlJcktZSmdrc0hCdVZjUmJJRGVxVUhS?=
 =?utf-8?B?bnIybnpYa2UwYWRDeUJxT0tsQXlsQ2grWGVGM1VUcFB4ZmV2QmVVNW9KRW52?=
 =?utf-8?B?aXZGc3JpUitGN2FsTW80a3dpMW8yNDlCWE16SEU3WmpLMVIrVzBnY21oWkhC?=
 =?utf-8?B?ZFJIZE9ieVlRV1Uza0QvNndkVzhMQzhVVkVoSlZXUFIyd2ZPNkdaYVlkaWNT?=
 =?utf-8?B?cy9HbDRrcDJKZ2xONHlLeEFsaU5wNUxWbzRGUGwzWEFJc1RWZjROeEVYajZD?=
 =?utf-8?B?cDEyYk5NaUphem93dVpRWVJTU210aW1zbjg5V29weTB0UkdTcU9GdW9UUXJz?=
 =?utf-8?B?blZHOE14TkJBYnQwRTVsWG5LTHBMRk5PaE80K1ZtRDFSZm1YRWY3c3l2VHk1?=
 =?utf-8?B?QXREekpiUTEwaDdpcUN3RklDaysxUytFZDBZYitrK0hmL0h6R1IwTFlTczRR?=
 =?utf-8?B?Y1RWWG1pTzdXS00zTkw5WUdnb0lKdC9iWU1YeDlYRTZ6eXpqZVpGUFl2a0NG?=
 =?utf-8?B?NVNhYmlVY1I1amVpMk85SWlwSEh1Skd5bW9Xc2tXNUNmOVNnRDlGVkpuL0cr?=
 =?utf-8?B?Q050NXNKdE1zRElVYjZ6YW1uRlNvMTJsaHhKYTVHVEQ0dmVDZjdRcnowdkZM?=
 =?utf-8?B?VzF2ZXRZZGdybXFiWkwwWmdwcHZVSlJudVEzMndxZDZzS0hFSG52SXhtSlBH?=
 =?utf-8?B?UU90eHE1aUtTYzB5QzB3L1BvNWVSelIxaUx5M2duRDlxYWl0TlZsdC9yYVRh?=
 =?utf-8?B?SXNpaHF3eU5CY3pFVFg1bk9tSk9PdzVMWmk3TWYxRitkMGpzL0RvUVZ0N1NL?=
 =?utf-8?B?cE5VQjdGTDR3dVBsUlFsTlh3QUI3UjA5SFhEUnJWYjdCOVowYStMRG9FalVR?=
 =?utf-8?B?Q00rN3BzbTZuZU10dVo0blRNNVFRM2VTWDMwR1NoM1M1K3ZtYXhjM0lvNXYx?=
 =?utf-8?B?VWFDaVlXSy9GVVVLUXNxR1JiYkRhU1BsSGZOTWlJTzVEVGxxbkJNbkMvK0Ni?=
 =?utf-8?B?ZWFzUmJPWGUwT0NDYmkzZFBicVA4ZDAwTHdONnJtRjlrdE40dTVCQzIvNGJM?=
 =?utf-8?B?akJvbENnbzdaaTh4ajZ0SDRpL3dqYTdhcmdKcWRmdkxxc2JYalZ4K045L08z?=
 =?utf-8?B?eDdONCtPcHFJTVhBaG5zOFNtb0NiVWtSV01kUnI1OHo3N1JvOVV4cGJzMG5C?=
 =?utf-8?B?NXc5NEhPVEk3S2JzZTNTS0NXaTE5Q3pRbGRHVTNXcUgyYmltNUVOREhMRjJl?=
 =?utf-8?B?bFA3ZGtWUk1NOEFoZkkvOTJiR0E5aUpEMno0MXVMYlJHd3JLVjVBdWVUNW5G?=
 =?utf-8?B?aTNFc0tCa3paUExxRVE5UGtuMkJtOWFGYTFkNXhvSHhUSDVLQVJsNWRNUkNi?=
 =?utf-8?B?VjB3U3pqTjVOWnY2V0JUQkFTVUNGUm5lTWswMDJvMjFZSlNDUnkvbkZzelNk?=
 =?utf-8?B?ZWYxbzkzR1ZnME4rVTRpM2JJYVBGOEhFK2ZyQU9XTUNCckt4aXozdHhmYWRI?=
 =?utf-8?B?ZEM2KzdWdGZKUFlVd3pVbEZYT3Z1NkJXVnNJTS9KYjE4bzRYRllaekJzWmU5?=
 =?utf-8?B?ZFdFTUlzN3F2anRIcUJMb3NwMEtNUWV6VnVNQkh3VTNUT3dEdnlnTlBiWndD?=
 =?utf-8?B?dkdFK2M2UG9Pd2JKanNqeEFNWVk3bkFkZDY4WWVVYWJMcnRPQkZ1SWJNSWtG?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED22458517D19C43B9668288A58B2787@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	70vGTdYwtuLooCisHETzIkg7Xaz++vxH2md+2nkMxvSBSMlUwn5POPgDIuoyzWTI3sWV3MAJBgvyjCUkJ17w0XomWJ377tc/Zau9F13acEYxzBTxb+cQrENjdRhnHi9+YPusCDRt0DUqzBCJZk5o3uaH/dSz9yDRFZwlmrvkZdCSeL6fTsWbwiLRWdJLifnar049/yvGzJhs0zfcLPU9GAUowp5e4yQwsej9V3yZgmVtpmQZHWwNS5IWKyPkJzEhRshqI/W09+kn6HCsT+sO1sEq+Ua463SJVQ+3TAohfsv6e+lyjsScUzdmq9V99+Yv1f59Iqd0Dx7GuNURgzoWMuGSV4fnS2WVcqgRuwKiKcMUJh++0o9E8wv0MM9hUd/Keiy6S1oz2fMamHcPaONe1TPJmUo7n9QKZbcmM83+R2z+felVKxwDb5B4mkXm1pgpD383fSoSk7l+qR/rJjL/iy7VDIU2kofANJXDjJIPdaAkg2VyayKEjo6V4dwPF42oYpA2SmHL/QoQKdH4TyqDTFMOtRLliRir40f/t/7U+Mpc/k0OgMxJJ8HBd0Oi6m0YyTFE8Qlcubzqi6Z3LQ/pPge5bgeR+7v63o/Tmpl9X9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae38555-96ad-43b8-3fef-08dd043a634b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 23:24:57.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJZllzxDYxIDpRDqy4i5ZRF9rvv5qy/4Eqh6evM8tlyq0KEKZ+WBNNZCiXsm2EXz9YaeG4/8D03Wf6kt5qte6RSmjbNyM08Y7QmXbWEjP6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_15,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130188
X-Proofpoint-ORIG-GUID: NjJ3s-D42mTdAAr4jU9UnaHdlXYkMMPW
X-Proofpoint-GUID: NjJ3s-D42mTdAAr4jU9UnaHdlXYkMMPW

DQoNCj4gT24gTm92IDEzLCAyMDI0LCBhdCAxMjo1N+KAr1BNLCBNYXRoaWV1IERlc25veWVycyA8
bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjQtMTEt
MTMgMTU6MTAsIFByYWthc2ggU2FuZ2FwcGEgd3JvdGU6DQo+Pj4gT24gTm92IDEzLCAyMDI0LCBh
dCAxMTozNuKAr0FNLCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNp
b3MuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiAyMDI0LTExLTEzIDEzOjUwLCBQZXRlciBaaWps
c3RyYSB3cm90ZToNCj4+Pj4gT24gV2VkLCBOb3YgMTMsIDIwMjQgYXQgMTI6MDE6MjJBTSArMDAw
MCwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+Pj4+IFRoaXMgcGF0Y2ggc2V0IGltcGxlbWVu
dHMgdGhlIGFib3ZlIG1lbnRpb25lZCA1MHVzIGV4dGVuc2lvbiB0aW1lIGFzIHBvc3RlZA0KPj4+
Pj4gYnkgUGV0ZXIuIEJ1dCBpbnN0ZWFkIG9mIHVzaW5nIHJlc3RhcnRhYmxlIHNlcXVlbmNlcyBh
cyBBUEkgdG8gc2V0IHRoZSBmbGFnDQo+Pj4+PiB0byByZXF1ZXN0IHRoZSBleHRlbnNpb24sIHRo
aXMgcGF0Y2ggcHJvcG9zZXMgYSBuZXcgQVBJIHdpdGggdXNlIG9mIGEgcGVyDQo+Pj4+PiB0aHJl
YWQgc2hhcmVkIHN0cnVjdHVyZSBpbXBsZW1lbnRhdGlvbiBkZXNjcmliZWQgYmVsb3cuIFRoaXMg
c2hhcmVkIHN0cnVjdHVyZQ0KPj4+Pj4gaXMgYWNjZXNzaWJsZSBpbiBib3RoIHVzZXJzIHBhY2Ug
YW5kIGtlcm5lbC4gVGhlIHVzZXIgdGhyZWFkIHdpbGwgc2V0IHRoZQ0KPj4+Pj4gZmxhZyBpbiB0
aGlzIHNoYXJlZCBzdHJ1Y3R1cmUgdG8gcmVxdWVzdCBleGVjdXRpb24gdGltZSBleHRlbnNpb24u
DQo+Pj4+IEJ1dCB3aHkgLS0gd2UgYWxyZWFkeSBoYXZlIHJzZXEsIGdsaWJjIHVzZXMgaXQgYnkg
ZGVmYXVsdC4gV2h5IGFkZCB5ZXQNCj4+Pj4gYW5vdGhlciB0aGluZz8NCj4+PiANCj4+PiBJbmRl
ZWQsIHdoYXQgSSdtIG5vdCBzZWVpbmcgaW4gdGhpcyBSRkMgcGF0Y2ggc2VyaWVzIGNvdmVyIGxl
dHRlciBpcyBhbg0KPj4+IGV4cGxhbmF0aW9uIHRoYXQganVzdGlmaWVzIGFkZGluZyB5ZXQgYW5v
dGhlciBwZXItdGhyZWFkIG1lbW9yeSBhcmVhDQo+Pj4gc2hhcmVkIGJldHdlZW4ga2VybmVsIGFu
ZCB1c2Vyc3BhY2Ugd2hlbiB3ZSBoYXZlIGV4dGVuc2libGUgcnNlcQ0KPj4+IGFscmVhZHkuDQo+
PiBJdCBtYWlubHkgcHJvdmlkZXMgcGlubmVkIG1lbW9yeSwgY2FuIGJlIHVzZWZ1bCBmb3IgIGZ1
dHVyZSB1c2UgY2FzZXMgd2hlcmUgdXBkYXRpbmcgdXNlciBtZW1vcnkgaW4ga2VybmVsIGNvbnRl
eHQgY2FuIGJlIGZhc3Qgb3IgbmVlZHMgdG8gYXZvaWQgcGFnZWZhdWx0cy4NCj4gDQo+IERvZXMg
dGhlIHRhcmdldGVkIHVzZS1jYXNlIChzY2hlZHVsZXIgdGltZSBzbGljZSBleHRlbnNpb24pIHJl
cXVpcmUNCj4gcGlubmVkIG1lbW9yeSwgb3IganVzdCBmdXR1cmUgdXNlLWNhc2VzID8NCg0KUHJv
YmFibHkgbm90IGZvciBzY2hlZCB0aW1lIHNsaWNlIGV4dGVuc2lvbi4gQWx0aG91Z2gsIHdlIGhh
dmUgbm90IHJ1biB0aGUgZGF0YWJhc2Ugd29ya2xvYWQgdXNpbmcgcmVzdGFydGFibGUgc2VxdWVu
Y2UuIFdlIGNhbiB0cnkgdGhhdCBhbmQgZ2V0IGJhY2suDQoNCldoYXQgYWJvdXQgcHVibGlzaGlu
ZyB0aHJlYWQgc3RhdGUgaW4gdGhlIHNoYXJlZCBzdHJ1Y3R1cmU/IEl0IHdvdWxkIHJlcXVpcmUg
dXBkYXRpbmcgdXNlciBtZW1vcnkgaW4gY29udGV4dCBzd2l0Y2hpbmcgY29kZSBwYXRoIHdoZW4g
dGhyZWFkIGlzIGdvaW5nIG9mZiB0aGUgY3B1LiBIZXJlIGhhdmluZyBwaW5uZWQgbWVtb3J5IHdv
dWxkIGhlbHAuIFRocmVhZCBzdGF0ZSBpcyB0aGUgb3RoZXIgcmVxdWlyZW1lbnQgd2UgYXJlIGlu
dGVyZXN0ZWQgaW4uDQoNCj4gDQo+IERvZXMgaGF2aW5nIGEgbWlzc2luZyB0aW1lIHNsaWNlIGV4
dGVuc2lvbiBoaW50IGZvciBhIHNob3J0IHdoaWxlIGluDQo+IGNhc2Ugb2YgaGlnaCBtZW1vcnkg
cHJlc3N1cmUgKHJzZXEgcGFnZSBzd2FwcGVkIG91dCkgaGF2ZSBhbnkgbWVhc3VyYWJsZQ0KDQpZ
ZXMsIGJ1dCB0aGUgcmVzdGFydGFibGUgc2VxdWVuY2UgYmFzZWQgaW1wbGVtZW50YXRpb24gZG9l
cyBjb3B5X2Zyb21fdXNlcigpLCB3aGljaCB3b3VsZCBnbyB0aHJ1IHRoZSBwYWdlZmF1bHQuIEl0
IG1heSBiZSBvayBoZXJlLiBQZXJwYXBzIGl0IHdvdWxkIHJlcXVpcmUgZGlzYWJsaW5nIHBhZ2Ug
ZmF1bHRzIGluIHRoaXMgY2FzZT8gSWYgdGhlIHBhZ2UgaXMgbm90IHByZXNlbnQsIHRoZW4gdGhl
IGhpbnQgd291bGQgbW9zdCBsaWtlbHkgbm90IG1hdHRlciBhbmQga2VybmVsIGNhbiBza2lwLg0K
DQo+IGltcGFjdCBjb21wYXJlZCB0byB0aGUgb3ZlcmhlYWQgb2YgdGhlIHBhZ2UgZmF1bHRzIHdo
aWNoIHdpbGwgYmUNCj4gaGFwcGVuaW5nIGluIGNhc2Ugb2YgdGhlIGhpZ2ggbWVtb3J5IHByZXNz
dXJlIHJlcXVpcmVkIHRvIHRyaWdnZXIgdGhpcw0KPiBzY2VuYXJpbyA/DQoNCldlIHdvdWxkIGhh
dmUgdG8gdGVzdCB0aGF0LiANCg0KPiANCj4+PiANCj4+PiBQZXRlciwgd2FzIHRoZXJlIGFueXRo
aW5nIGZ1bmRhbWVudGFsbHkgd3Jvbmcgd2l0aCB5b3VyIGFwcHJvYWNoIGJhc2VkDQo+Pj4gb24g
cnNlcSA/IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzEwMzAxMzI5NDkuR0EzODEy
M0Bub2lzeS5wcm9ncmFtbWluZy5raWNrcy1hc3MubmV0DQo+Pj4gDQo+Pj4gVGhlIG1haW4gdGhp
bmcgSSB3b25kZXIgaXMgd2hldGhlciBsb2FkaW5nIHRoZSByc2VxIGRlbGF5IHJlc2NoZWQgZmxh
Zw0KPj4+IG9uIHJldHVybiB0byB1c2Vyc3BhY2UgaXMgdG9vIGxhdGUgaW4geW91ciBwYXRjaC4g
QWxzbywgSSdtIG5vdCBzdXJlIGl0IGlzDQo+Pj4gcmVhbGlzdGljIHRvIHJlcXVpcmUgdGhhdCBu
byBzeXN0ZW0gY2FsbHMgc2hvdWxkIGJlIGRvbmUgd2l0aGluIHRpbWUgZXh0ZW5zaW9uDQo+Pj4g
c2xpY2UuIElmIHdlIGhhdmUgdGhpcyBzY2VuYXJpbzoNCj4+IEkgYW0gYWxzbyBub3Qgc3VyZSBp
ZiB3ZSBuZWVkIHRvIHByZXZlbnQgc3lzdGVtIGNhbGxzIGluIHRoaXMgc2NlbmFyaW8uDQo+IA0K
PiBJIHN1c3BlY3QgdGhhdCBpZiB3ZSBwcm9oaWJpdCBzeXN0ZW0gY2FsbHMgZnJvbSBiZWluZyBp
c3N1ZWQgZnJvbSBhDQo+IGRlbGF5LXJlc2NoZWQgdXNlcnNwYWNlIGNyaXRpY2FsIHNlY3Rpb24s
IHRoZW4gbG9hZGluZyB0aGUgZGVsYXktcmVzY2hlZA0KPiByc2VxIGZsYWcgb24gcmV0dXJuIHRv
IHVzZXJzcGFjZSBpcyBhbHdheXMgZmluZSwgYmVjYXVzZSB0aGUga2VybmVsIG9ubHkNCj4gcmVz
Y2hlZHVsZXMgb24gcmV0dXJuIGZyb20gaW50ZXJydXB0IG9yIHRyYXAuDQo+IA0KPiBCdXQgSSBz
ZWUgdGhpcyBuby1zeXNjYWxsIHJlc3RyaWN0aW9uIGFzIGJlaW5nIHZlcnkgY3VtYmVyc29tZSBm
b3INCj4gdXNlcnNwYWNlLg0KPiANCj4+IFdhcyB0aGF0IHJlc3RyaWN0aW9uIG1haW5seSBiZWNh
dXNlIG9mIHJlc3RhcnRhYmxlIHNlcXVlbmNlIEFQSSBpbXBsZW1lbnRzIGl0Pw0KPiANCj4gSSBz
dXNwZWN0IHRoYXQgdGhpcyByZXN0cmljdGlvbiBpcyBqdXN0IHRvIGF2b2lkIGxvYWRpbmcgdGhl
DQo+IGRlbGF5LXJlc2NoZWQgZmxhZyBmcm9tIHRoZSBzY2hlZHVsZXIgd2hlbiByZXNjaGVkdWxl
IGlzIGNhbGxlZA0KPiBmcm9tIGFuIGludGVycnVwdCBoYW5kbGVyIG5lc3RlZCBvdmVyIGEgc3lz
dGVtIGNhbGwgZm9yIHByZWVtcHRpYmxlDQo+IGtlcm5lbHMsIGJ1dCBQZXRlciBjb3VsZCB0ZWxs
IHVzIG1vcmUuDQoNCkhvcGluZyBQZXRlciBjYW4gY29tbWVudCBvbiB0aGlzLg0KDQo+IE9uZSBv
cGVuIHF1ZXN0aW9uIGhlcmUgaXMgd2hldGhlciB3ZSB3YW50IHRvIHBpbiBtZW1vcnkgZm9yDQo+
IGVhY2ggdGhyZWFkIGluIHRoZSBzeXN0ZW0gdG8gaG9sZCB0aGlzIHNoYXJlZCBkYXRhIGJldHdl
ZW4NCj4gdXNlcnNwYWNlIGFuZCB0aGUgc2NoZWR1bGVyLiBBRkFJVSwgdGhpcyBpcyBhIHRyYWRl
LW9mZiBiZXR3ZWVuDQo+IHNsaWNlIGV4dGVuc2lvbiBhY2N1cmFjeSBpbiBoaWdoIG1lbW9yeSB1
c2FnZSBzY2VuYXJpb3MgYW5kDQo+IHBpbm5lZCBtZW1vcnkgZm9vdHByaW50IGltcGFjdC4gSWYg
dGhlIHRyYWRlb2ZmIGdvZXMgdG93YXJkcw0KPiBtYWtpbmcgdGhpcyBtZW1vcnkgcGlubmVkLCB0
aGVuIHdlIG1heSB3YW50IHRvIGNvbnNpZGVyIHBpbm5pbmcNCj4gdGhlIHBlci10aHJlYWQgcnNl
cSBhcmVhIG9uIHJzZXEgcmVnaXN0cmF0aW9uLg0KPiANCj4gQW5vdGhlciBvcHRpb24gdG8gY29u
c2lkZXIgaXMgdG8gdXNlIHJzZXEgdG8gaW5kZXggYSB1c2Vyc3BhY2UNCj4gcGVyLWNwdSBkYXRh
IHN0cnVjdHVyZSwgd2hpY2ggd2lsbCBiZSB1c2VkIGFzIHNoYXJlZCBtZW1vcnkNCj4gYmV0d2Vl
biBrZXJuZWwgYW5kIHVzZXJzcGFjZS4gVXNlcnNwYWNlIGNvdWxkIHN0b3JlIHRoaXMNCj4gZGVs
YXktcmVzY2hlZCBmbGFnIGludG8gdGhlIGN1cnJlbnQgQ1BVJ3Mgc2hhcmVkIGRhdGEsIGFuZA0K
PiB0aGUgc2NoZWR1bGVyIGNvdWxkIGxvYWQgaXQgZnJvbSB0aGVyZS4gSWYgcGlubmluZyBwZXIt
Y3B1DQo+IGRhdGEgaXMgbW9yZSBhY2NlcHRhYmxlIHRoYW4gcGlubmluZyBwZXItdGhyZWFkIGRh
dGEsIHRoZW4NCj4gaXQgY291bGQgYmUgYW4gaW1wcm92ZW1lbnQuDQoNCkludGVyZXN0aW5nLiBI
YXZpbmcgcHJlIGNwdSBzaGFyZWQgbWVtb3J5IG1heSBub3Qgd29yayBmb3IgYWxsIHVzZSBjYXNl
cy4NCg0KVGhhbmtzLA0KLVByYWthc2gNCg0KPiANCj4gVGhpcyBjb3VsZCBiZSBhIG5ldyBBQkkg
YmV0d2VlbiBrZXJuZWwgYW5kIHVzZXJzcGFjZSwgZS5nLjoNCj4gDQo+IHN0cnVjdCByc2VxX3Bl
cmNwdV9hcmVhIHsNCj4gICAgX191MzIgc2NoZWRfc3RhdGU7IC8qIGluY2x1ZGVzIHRpbWUgc2xp
Y2UgZXh0ZW5zaW9uIGZsYWcuICovDQo+ICAgIGNoYXIgZW5kW107DQo+IH07DQo+IA0KPiBSZWdp
c3RlcmVkIHRvIHRoZSBrZXJuZWwgd2l0aCB0aGUgZm9sbG93aW5nIHBhcmFtZXRlcnM6DQo+IA0K
PiAtIEFkZHJlc3Mgb2YgcnNlcV9wZXJjcHVfYXJlYSBmb3IgQ1BVIDAsDQo+IC0gVGhlIHN0cmlk
ZSBvZiB0aGUgcGVyLWNwdSBpbmRleGluZyAoc2VlIGxpYnJzZXEgbWVtcG9vbCBwZXItY3B1DQo+
ICBhbGxvY2F0b3IgWzFdKSwNCj4gLSBvZmZzZXRvZihzdHJ1Y3QgcnNlcV9wZXJjcHVfYXJlYSwg
ZW5kKSB0byBoYXZlIHRoZSBmZWF0dXJlIHNpemUNCj4gIGZvciBleHRlbnNpYmlsaXR5Lg0KPiAN
Cj4gVGhhbmtzLA0KPiANCj4gTWF0aGlldQ0KPiANCj4gWzFdIGh0dHBzOi8vbHBjLmV2ZW50cy9l
dmVudC8xOC9jb250cmlidXRpb25zLzE3MjAvYXR0YWNobWVudHMvMTU3Mi8zMjY4L3ByZXNlbnRh
dGlvbi1scGMyMDI0LXJzZXEtbWVtcG9vbC5wZGYNCj4gDQo+PiAtUHJha2FzaA0KPj4+IA0KPj4+
IEEpIHVzZXJzcGFjZSBncmFicyBsb2NrDQo+Pj4gICAtIHNldCByc2VxIGRlbGF5IHJlc2NoZWQg
ZmxhZw0KPj4+IEIpIHN5c2NhbGwNCj4+PiAgIC0gcmVzY2hlZHVsZQ0KPj4+ICAgIFsuLi5dDQo+
Pj4gICAtIHJldHVybiB0byB1c2Vyc3BhY2UsIGxvYWQgcnNlcSBkZWxheS1yZXNjaGVkIGZsYWcg
ZnJvbSB1c2Vyc3BhY2UgKHRvbyBsYXRlKQ0KPj4+IA0KPj4+IEkgd291bGQgaGF2ZSB0aG91Z2h0
IGxvYWRpbmcgdGhlIGRlbGF5IHJlc2NoZWQgZmxhZyBzaG91bGQgYmUgYXR0ZW1wdGVkIG11Y2gN
Cj4+PiBlYXJsaWVyIGluIHRoZSBzY2hlZHVsZXIgY29kZS4gUGVyaGFwcyB3ZSBjb3VsZCBkbyB0
aGlzIGZyb20gYSBwYWdlIGZhdWx0DQo+Pj4gZGlzYWJsZSBjcml0aWNhbCBzZWN0aW9uLCBhbmQg
YWNjZXB0IHRoYXQgdGhpcyBoaW50IG1heSBiZSBhIG5vLW9wIGlmIHRoZQ0KPj4+IHJzZXEgcGFn
ZSBoYXBwZW5zIHRvIGJlIHN3YXBwZWQgb3V0ICh3aGljaCBpcyByZWFsbHkgdW5saWtlbHkpLiBU
aGlzIGlzDQo+Pj4gc2ltaWxhciB0byB0aGUgIm9uX2NwdSIgc2NoZWQgc3RhdGUgcnNlcSBleHRl
bnNpb24gUkZDIEkgcG9zdGVkIGEgd2hpbGUgYmFjaywNCj4+PiB3aGljaCBuZWVkZWQgdG8gYmUg
YWNjZXNzZWQgZnJvbSB0aGUgc2NoZWR1bGVyOg0KPj4+IA0KPj4+ICBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjMwNTE3MTUyNjU0LjcxOTMtMS1tYXRoaWV1LmRlc25veWVyc0BlZmZp
Y2lvcy5jb20vDQo+Pj4gIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzA1MjkxOTE0
MTYuNTM5NTUtMS1tYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20vDQo+Pj4gDQo+Pj4gQW5k
IHdlJ2QgbGVhdmUgdGhlIGRlbGF5LXJlc2NoZWQgbG9hZCBpbiBwbGFjZSBvbiByZXR1cm4gdG8g
dXNlcnNwYWNlLCBzbw0KPj4+IGluIHRoZSB1bmxpa2VseSBzY2VuYXJpbyB3aGVyZSBpdCBpcyBz
d2FwcGVkIG91dCwgYXQgbGVhc3QgaXQgZ2V0cyBwYWdlZA0KPj4+IGJhY2sgYXQgdGhhdCBwb2lu
dC4NCj4+PiANCj4+PiBGZWVsIGZyZWUgdG8gbGV0IG1lIGtub3cgaWYgSSdtIG1pc3NpbmcgYW4g
aW1wb3J0YW50IHBvaW50IGFuZC9vciBzYXlpbmcNCj4+PiBub25zZW5zZSBoZXJlLg0KPj4+IA0K
Pj4+IFRoYW5rcywNCj4+PiANCj4+PiBNYXRoaWV1DQo+Pj4gDQo+Pj4gLS0gDQo+Pj4gTWF0aGll
dSBEZXNub3llcnMNCj4+PiBFZmZpY2lPUyBJbmMuDQo+Pj4gaHR0cHM6Ly93d3cuZWZmaWNpb3Mu
Y29tDQo+Pj4gDQo+IA0KPiAtLSANCj4gTWF0aGlldSBEZXNub3llcnMNCj4gRWZmaWNpT1MgSW5j
Lg0KPiBodHRwczovL3d3dy5lZmZpY2lvcy5jb20NCg0KDQo=

