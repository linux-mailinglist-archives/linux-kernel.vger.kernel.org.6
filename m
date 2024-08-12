Return-Path: <linux-kernel+bounces-283481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4894F577
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A46C1C21126
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EAF187550;
	Mon, 12 Aug 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W1twcv31";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TDlqrTNR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356216D4DF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481901; cv=fail; b=K3K61h0U6O4rdhkftg0VbN8khIdfZmoszURnFkESmW9Hwd1fzcD8DJtX1F1pscB9LcSU8ELClp84hC4MPtsBc0EwOJivtWDgDnj54/K0lQpdZ7dhS/7gsZC+JHuhGyyVAB1wVPmakcLu2greI/CS7fuHDpoJJIZNF/XoE3AWm4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481901; c=relaxed/simple;
	bh=p0RABI9ZZKJPXxdH4NHAR1ds8ahG8rgB3laZtOjczYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dhgJD13ohss23OXGEtRBhs/EDnmghowC2+IZRVwR98TlhZD/fo/e95MDJHa8nBNyvfzdnf7hOdrOu7yzEcPbv9snSbH/2Ek80A0rc1FMFaLKHfLgzrnJT/0oOA0NtBjSzyaXyITP303JHRO5W9VYaOiroXvfATkkkesxxaxIz2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W1twcv31; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TDlqrTNR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CGXY8X015466;
	Mon, 12 Aug 2024 16:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=rfq5VDjD41u6mE3M/nOwp2ZWin/2HbR/A4oxxjbs5iw=; b=
	W1twcv31URDanDhU8+DCs0ttN8G557fa8kda08eG27ptNCD2+QKd8vnJf/PrHEix
	gzAXIKLqEB1GXKt+5j6Xa8328YpDKkOtIaANEayTWshMKsXqt0mhptDFePfA4BKv
	w9b+VE4faq3J3/GCVLOIlmVHTR8mg//UmlkvHhZoLf5Vm/z3dyoJ/JymvEDHOL1d
	aFqcAedVPvOT1Z4v+TFpYxjGGvxkj2R61Wd+cJ1NObx3mhvlrZpHzo5EINbF17Ft
	d993FaaJb+snAwY4hw4ZIyGqVNtceD+VUZeYaLiRF/qt7DhUaAiTjmT54/eVLu9k
	S5yLPWt/cz4ZQvTzHDTFtw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x03933a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 16:58:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CFOjNk003825;
	Mon, 12 Aug 2024 16:58:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8d7un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 16:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOGmmNFu+jTFEdBNdLu2zgRDwtW56siJqEAp1F2/LEA0KmA9Qgr+qFnVLZiAJwHqI4i19NH8vuAjMUgc+1U9Ml1I9NNJVhSjP5krcnW1yWc+12oJzSyEcilJ7v4XZ7rElctyl/2GzDmPmGR/w1RFhZ4U1c8QPS8pNaUQgHzjHkXaNwQviYHzlaWEDRNaFFXz7dXAebiIAf9FNfk8HgQv5ImYWFDJ7sXxDbETIxWnL9g380EiXq1+XRXlMruktwN4wvgFPfObAv7nLAMQrMrJmng3/XLI4OcBa+BWoeidsP5d+p0G601MoY/JJJYZd7ZHkd2YvmhTnoKR28Hx3w0y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfq5VDjD41u6mE3M/nOwp2ZWin/2HbR/A4oxxjbs5iw=;
 b=QytJ0u2SLoBj+O3LICNrzYsQFoXDMUyWi/tSEhLTaouW0V+c/LqcV7kDC9L7W6JTkLIbBY3b+Jb4f/FiAjq72rx7MFgDc7dLaN3ir1ofLBRyF2PE0B6vUMqfqukT+CkAd+gPVOvjENeBh+7id+bzouT1hAF8cQ6e6Jo+WeE3/kJ+eSEDie6ZKgd/w6KV8oVxgoZCfZ4F8gsLZGQAFagNrghy0OnVI4QmHu67QjDK+Wfpm/ok5ABqijYV2Q7LNFK28Rzm8qSAHx27FHQZ3ht+RgtmuAA9l1Th958IXLTPiOzCSw9QPdwC7zOk1gyNwVqx9rToOJ6TPGpLhvRlZJJaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfq5VDjD41u6mE3M/nOwp2ZWin/2HbR/A4oxxjbs5iw=;
 b=TDlqrTNRwl53FeB79+19kWz27e/DienxX9BPtH8wuSyV+cTNCp5LV4J8khW+UE/gm+TAoAsQWF1jL5eVUZbvfGIs7Gex+fU0MengaYH1GVNuOTABGO13JxExdYct1fRpEwkru+qsX+UeWYxmrIdm7uqgNdg/SPiwQBQspD0QKLU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYYPR10MB7567.namprd10.prod.outlook.com (2603:10b6:930:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Mon, 12 Aug
 2024 16:58:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 16:58:00 +0000
Date: Mon, 12 Aug 2024 12:57:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@google.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/6] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <ko3pjllsgufbz33hqvwdpdsyxvgrgzqiodxexnpcng3mssffeh@dfgfkqlg46xa>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@google.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	oliver.sang@intel.com, torvalds@linux-foundation.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <keescook@chromium.org>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-3-pedro.falcato@gmail.com>
 <n3v6ebfiwnk26rvxwtgkingmuduv7gla7kaiasjdvadbrpczlw@d3xjceezvgzc>
 <3hzwtm7jw25ng5gemkp42k5ypkfky25fxeevccnk2d6gcpft32@qwkwofgauqna>
 <CAKbZUD2VV=FOeGhCOb3o5CKBiaV+6JSPoDRwzV1-3t2hZX7rQw@mail.gmail.com>
 <ljhdwgkfzjgdehfjgvdxa4wyxx4d32kpqqz2pwjse65rasuaeo@nncsuq3ku53o>
 <CALmYWFvURJBgyFw7x5qrL4CqoZjy92NeFAS750XaLxO7o7Cv9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALmYWFvURJBgyFw7x5qrL4CqoZjy92NeFAS750XaLxO7o7Cv9A@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0089.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYYPR10MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: a432181d-842c-4058-e109-08dcbaefec2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VktDVFptRUovblFncFhEUjFYU1Q2eU5pcXRrQmVYZFZuaGdibUYzM0gydkl2?=
 =?utf-8?B?a1J3N0p3dnpEamVLYitLdmUrNXNGdFdZNHNtYk14Ujdqdzc3eER5dno5bS9Q?=
 =?utf-8?B?Y1BvMEtEQitVY0xXZTJtVkhXMTBYMTZJdUJlblFycFB2Y0FPTlNXTEhsbmxX?=
 =?utf-8?B?bXNKQ2VsaG1zWkFVRVZaeFBsYzlVQjZLakJhaGx6dkhBeitWaDNHYlg2bkxD?=
 =?utf-8?B?YzhnQks5OWE3Ym9LN2JTeGhWaEFLcWJDcWFFUjByUCt4VGU3UGVPVWM2ZTF0?=
 =?utf-8?B?UzhwV2FVelRpQmJ0SkhEOW8zcDRKdFNudHRqbFJxUHFRVHVqbWNZb2Y5MGJF?=
 =?utf-8?B?U1F4STJnWFlxaC9kWWtoMlNmRnlKRjNQSmNnSzZzTnBwZUMxdG96T2FtUWVI?=
 =?utf-8?B?czU2akJYVmlRaTkxL3ZNQ3lZd3IzbU9HVzEraTJxOTVGSGtUN0o1c1F6WXVx?=
 =?utf-8?B?U1VBQXBCSUN6SFc1K2dOb2xkNURPZHAvTmZGM0IxRFFnYVhmbnFER002NnRh?=
 =?utf-8?B?MDR3SW5tOHh3bVRXNWU2YjVRUThDeUJycnJvb0o3NXlhK09yWGw1bU1VZXNw?=
 =?utf-8?B?UnNHbnBPUmJrY20zL1l0dWRqN0dJMkp6SkZRcjlWYlE1Ulh3NDFxUnlnOGJo?=
 =?utf-8?B?M0R2OXJBK3d0WWFMSzVBdlBNNC9EdGRta2xrc05qU2tlWTM2NFRFSDJQdzhO?=
 =?utf-8?B?d0xOT2ZPOHZjYVMraVlJMkdESzZvcld0clMzM2hvQUc0U2pxWnZ4TXJ0YlIy?=
 =?utf-8?B?VmhBMEdzOU41a1RSWnBmM1ptcmp0UFZtMDZ1REJ0N2NxdDhYb1FDUnhlVy9r?=
 =?utf-8?B?aEM3RWZqYU5UT0k5TEpBN2RPTVhFNHhyaVVFM1luRWV2c2YyVkpsbzZmbDFj?=
 =?utf-8?B?blFpaHdiSkJtaWJRL0dmK20xTFpmb0Jodnl4YmlqRENTNHVkdWJPVHFCZjdG?=
 =?utf-8?B?d29YckNjdFdhemNMM2lxR3BLaEJTWUVnbFBFSmFVYzhLc1VKMDVvKzlWbTVS?=
 =?utf-8?B?MjhXYXF5bGdKY0MwbDkvdjRKTElMZDZxMEdjUTZkenhWUnpQelVWTlpTdU5B?=
 =?utf-8?B?VEN4RkZKd3RQNVNEVkpHcU12eUYwQXhMV0RKV0ZjcTFoSzNzQm9STTMwWGlS?=
 =?utf-8?B?MmJmRndaNjFFUUxxNGJraENwdEQrV3poNUxheXp3OFNkUUJsMmJEaXZCeWVD?=
 =?utf-8?B?ODB0Sm1tRVJud0FuNGVYRk5OTU9jcFlrL1NOLzlCMG9TZTU5U2RYTWVjbUN3?=
 =?utf-8?B?WnMvUyt5azZMMWJreW9iS1dYcFhuM3dvRWZOUTB5QXdMM1B4cGRrQmZGUWFL?=
 =?utf-8?B?R1N5Zk1zNWRlbWpUYWc4aCtvOU1ZTFlTaDJkcnRtSzRPQjBrYWhoQ3E1a2Ix?=
 =?utf-8?B?SVI5SWlLeFUxY09NYkNUTStxejRxWTdscGtra0NwTW0xaS9Mdy8raHFaaWhY?=
 =?utf-8?B?TENxckUwckpKeVN3M28zQXlJWE5XMDF3bFQzRVBGTlN3NUkrelFqbG4xTVVa?=
 =?utf-8?B?YU9jcWN5TkV0Mkc0eEs3Vkg4ckJaV2hXM2lqOUJ3RUJLenl3dE9DdE9oM05m?=
 =?utf-8?B?M2Yrd3ZaZHFRNFVJdWk4SGdXenNQM2ZNZGhJYmgzY2ZqbkZ3amUxT29xS1g1?=
 =?utf-8?B?L1JjRkhiOHBnbkJiWm00ekxjTnp1QUF3cmhKWEM5bWlPb2x4N3lJVnRtdmZU?=
 =?utf-8?B?YUFqVjZYT0VRRTZuN09GeXZETU5NZlhzRGtPb1VxY0k2TkkrUHdwRU5XYkV3?=
 =?utf-8?B?N083eEVLSWtrRW8wMll1d0UzQkZ5U2F6elpHOHVDd3E5Y1RIOEtaRURHaUsz?=
 =?utf-8?B?YWpBbTVGWGI3OHNHaW1oUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHBEUStwdUE0ajFQNVJwV09nZXIzMWw2VWdLQnk4TlZ2d0hUakZxd2NGU1ZL?=
 =?utf-8?B?eHpXT2lQTmhuU2JxcGxjcDBwbjlMQ21YMWViazFSb1ZaVEkwL1lUMVJxVkVP?=
 =?utf-8?B?UjVPTXZxZGwwZ0JVOG0rY1ZiZlE1SENrenZCWVBGbmU4b2Z3NmYyZ2JybGJ2?=
 =?utf-8?B?bkY3eFpZbzBEejBLNkhoMGtXWnJuZUt6MVd2YVlJMEpMWHU5aHRURkltQ2xE?=
 =?utf-8?B?TUhsYkpicDQwNE5wak9VM1cwSGJIbDJOcUdpRHJvcFZNWjhuWWltd2lJYkVX?=
 =?utf-8?B?MzRqVGlEczArNGJ6TVZEaTk1TTNoRFo3SndHR0ZrbTlQY0JlV01vd0RmUUtZ?=
 =?utf-8?B?YkdKRnUyRU5IaHNaNFlSaTJ0ZGRONG1PSG13R0l3UThnNmdhTzcxNjJmN0Fk?=
 =?utf-8?B?eVozcllac3NaSnRuNkd1enNrc294dXQvVHk5aFdhRkFCSTZZSXRGN1hxbjh3?=
 =?utf-8?B?Rm81L1BFUzFhdEVoVjJQMnVPYm94eHNzSi9BOWVhdUhWQU80cVdVV0QrMXdG?=
 =?utf-8?B?NnZjNmZLUFR5YXFhbEh3TGZmUW9WaGRibFoxSVB6VTJwNUtWQ0hRbitNaHkz?=
 =?utf-8?B?MDJtS2hleG9rRG5VMDVKRWNaTlkxRHRiRkgrc0dubmJQRjRtTDJEMnhHbEEz?=
 =?utf-8?B?VXFxSEVad0Q4YVBPK2tKQ2hHeExsZkZvK2FKbWJ5MFhiOUg0TkRxL3JEU1dT?=
 =?utf-8?B?LzJad0FjeExqTE14TW4wRVpsMzBzOXlSQUQxV1IwWGkrTEpweThBVFp6ZmxV?=
 =?utf-8?B?anUydytnZXFrcmdVTGlkSThIcXhmNkNmYkxKcEVFdlRORm9qc05PMHkyTDRE?=
 =?utf-8?B?Sm9zRnROejRFQzRLQW5KVXpPOGVIV3o0cDZISld5Z3JidmdvUmFvcXM4cVZK?=
 =?utf-8?B?YTYyQXN2bEhZbzNpYm16aTQvUWk1WkkrdmxEaXY2WnhGZUpvNmZoSWNtTk05?=
 =?utf-8?B?YUtkaUFibEVycm5aS2M5V3RxM2lzOHFsbEF5NTh3cHp6dEpFanpCZUtQbXU1?=
 =?utf-8?B?b1hQK0FLZ1Z3SjhVNzAzYVhhaVdsQXZ3WXMvQ0FuN0NOTHFtNGZ3RlpBSEt4?=
 =?utf-8?B?R2llamVsZk1md1FhbDFrYUdYTG5EbDZpSkxCSU9xbGF3bmhkMWZVVDZzeitL?=
 =?utf-8?B?YitrMitON3JhdXgybkIrQjQ5cTlOS3Q3anhpT2x0Z2J4Y2gvcG1paUxKNTla?=
 =?utf-8?B?SWZHZHVJeXp0MkpxTGN0UVc5MkprbWJFTkRPaWUwaERTOU1rN1ArMjVyMDA2?=
 =?utf-8?B?TWkxZHFuNlFqL1l6cWRvdXp1Rmh1dWlUSG93NjdTOE1BREtuU1hTaTNTTzA0?=
 =?utf-8?B?OFZVTDN6ZmhrUjNJVS8wUjYya25UK2l5Ryt1RGg1OWh1dHRBSWp6Y1JUNFBa?=
 =?utf-8?B?ZFo2YU1lNEI2bE1wSEFEbm91NUFiL0pxTHZOODVubXNLQ1VzVUxaM3RySmpW?=
 =?utf-8?B?QXpYelg2NDZLWXVHSktQOVk3K3ZPYXBmVEZmV2lFRVJ6K0ZLMVYvTzNSYjh1?=
 =?utf-8?B?VExZNE00di8xYVdsYmZtZSs1eXhDbGVwOGw1ZmxPUWgxbGVIbTNkb1RvN2FE?=
 =?utf-8?B?TjB6bWZMbG5EblZhcDhDTlZEWUYwb2lYV2hkRW90ZGdTVGZQQXJ1b0NHMWVZ?=
 =?utf-8?B?NjQrd3M1bXFHOFliNWVBZkltN1kxWThqSlM2N24rMXRhUzFuSGRoT1RudGR2?=
 =?utf-8?B?Smp5K014K3Q2Y3ZNeGs3Rmx0VGRQRnRVK2E4b3d0b095NUZJaXEwSXFubis3?=
 =?utf-8?B?eTFOUDdmT0NDMFR1RW5wZU5VWUI4dDJFcEdPclRZQ3NZcmMyQlE5VXdHMWsr?=
 =?utf-8?B?YTh0Qm5rVjQwOGNCZU4xRG1kc3plcnRzdzR1REtmSWRyVkZBZkhLcHRxSnJs?=
 =?utf-8?B?QzZkMVJxRHZSYXFiZktCK3ZEcTNoZXRPWmdjaGFJQnptQndVRzlaM1pITy9Q?=
 =?utf-8?B?ZTE5TFp3K1VPOVRJQ2N5SnNvbzZVY2diQUtBNEtrQ2JmallBQkxxUHplL05R?=
 =?utf-8?B?RG1jUWM3QnBZK056WndYNXB4VllUaUhzMzRwUmhseG1NMmZDQkM5aGRuV2lZ?=
 =?utf-8?B?NWRVY2hQOVVOYnRjNDFWY3FJcTcxUWxUM3dxWVV0K2ZJb1pjcnV3VDlhTmF2?=
 =?utf-8?Q?tqpac6VZ+oavG2Aq/sAXVOdDD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QWJzz6w2oIWR5CjJXB1sJ+MLgKamyuPUEyIeyGOGyTxrdv6aD7NajdtK5LXfPHIjJXhSqqBpm2Iyap+PFL7WiXMOlbCLPZpNLUiGKNxJsq7XimOuRP1r3kJmd0tUFGt1SLg4hglKOsdB2UCT61YvXpevbD94Dktx4YlLbz4Ym2QCFIke2+/S2IFGl0Zdv6HHMc8JA+wtbM1kcF/OHVpjwpJ9VTa8hqyx9S0X9IRR8Uum2B4uBCQYcsJYYpJ/yY89i+JHysaneTW/nEilSaY8ICdlEn4Yo0vcxu9q3bJqJNYMdskNWHrrt57GHRnbQJcAA1tV1TWTSrx8siri+azvnnbYc+r8Z0TP7vZJUNJgORmBUPmie7r1kQtqujz3PX/Jh7FBXczqTVCfIFYTnA7CF2Q8e0D3aSFrMyJHwyPZpSHdvsOvpAQJ4J0jiOxvsYpGtWb2XvhHg6QH4sgMkRA3Uhhb770AvtI13hMk81SaWBCiH8L8WXkQQSnElTh5qIVpZJx+Sm1W08dvgJw/3R8GVSLxx7ZEqOx5N4AhGv89O9lcFr1AoZRskn06OORz3zDLUmkSp8bl2jas1ld7tD8dbfzGMsASwuyj9GJXXIKa1ns=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a432181d-842c-4058-e109-08dcbaefec2a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 16:58:00.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXUhIwScOJmpH1eFMU5kQMswWThnt9KXaXFp88BOKvRCF+oNkQGOrzbyJO2U51yPSivy3iOVwEnKX/uwKfcfjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_10,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120125
X-Proofpoint-ORIG-GUID: TQsIWo8wdcQ0dxsP1ZSSXQ4B9afZVhFS
X-Proofpoint-GUID: TQsIWo8wdcQ0dxsP1ZSSXQ4B9afZVhFS

* Jeff Xu <jeffxu@google.com> [240812 10:30]:
> + Kees who commented on mseal() series before. Please keep Kees in the
> cc for future response to this series.
>=20
> On Fri, Aug 9, 2024 at 12:25=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Pedro Falcato <pedro.falcato@gmail.com> [240809 14:53]:
> > > On Fri, Aug 9, 2024 at 5:48=E2=80=AFPM Liam R. Howlett <Liam.Howlett@=
oracle.com> wrote:
> > > >
> > > > * Liam R. Howlett <Liam.Howlett@oracle.com> [240809 12:15]:
> > > > > * Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> > > > > > We were doing an extra mmap tree traversal just to check if the=
 entire
> > > > > > range is modifiable. This can be done when we iterate through t=
he VMAs
> > > > > > instead.
> > > > > >
> > > > > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > > > > ---
> > > > > >  mm/mmap.c | 13 +------------
> > > > > >  mm/vma.c  | 23 ++++++++++++-----------
> > > > > >  2 files changed, 13 insertions(+), 23 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > > index 4a9c2329b09..c1c7a7d00f5 100644
> > > > > > --- a/mm/mmap.c
> > > > > > +++ b/mm/mmap.c
> > > > > > @@ -1740,18 +1740,7 @@ int do_vma_munmap(struct vma_iterator *v=
mi, struct vm_area_struct *vma,
> > > > > >             unsigned long start, unsigned long end, struct list=
_head *uf,
> > > > > >             bool unlock)
> > > > > >  {
> > > > > > -   struct mm_struct *mm =3D vma->vm_mm;
> > > > > > -
> > > > > > -   /*
> > > > > > -    * Check if memory is sealed before arch_unmap.
> > > > > > -    * Prevent unmapping a sealed VMA.
> > > > > > -    * can_modify_mm assumes we have acquired the lock on MM.
> > > > > > -    */
> > > > > > -   if (unlikely(!can_modify_mm(mm, start, end)))
> > > > > > -           return -EPERM;
> > > > > > -
> > > > > > -   arch_unmap(mm, start, end);
> > > > > > -   return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, un=
lock);
> > > > > > +   return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end=
, uf, unlock);
> > > > > >  }
> > > > > >
> > > > > >  /*
> > > > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > > > index bf0546fe6ea..7a121bcc907 100644
> > > > > > --- a/mm/vma.c
> > > > > > +++ b/mm/vma.c
> > > > > > @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *v=
mi, struct vm_area_struct *vma,
> > > > > >             if (end < vma->vm_end && mm->map_count >=3D sysctl_=
max_map_count)
> > > > > >                     goto map_count_exceeded;
> > > > > >
> > > > > > +           /* Don't bother splitting the VMA if we can't unmap=
 it anyway */
> > > > > > +           if (!can_modify_vma(vma)) {
> > > > > > +                   error =3D -EPERM;
> > > > > > +                   goto start_split_failed;
> > > > > > +           }
> > > > > > +
> > > > >
> > > > > Would this check be better placed in __split_vma()?  It could rep=
lace
> > > > > both this and the next chunk of code.
> > > >
> > > > not quite.
> > >
> > > Yeah, I was going to say that splitting a sealed VMA is okay (and we
> > > allow it on mlock and madvise).
> >
> > splitting a sealed vma wasn't supposed to be okay.. but it is Jeff's
> > feature.  Jeff?
> >
> Splitting a sealed VMA is wrong.
> Whoever wants to split a sealed VMA should  answer this question
> first: what is the use case for splitting a sealed VMA?

If we lower the checks to __split_vma() and anywhere that does entire
vma modifications, then we would avoid modifications of the vma.  This
particular loop breaks on the final vma, if it needs splitting, so we'd
still need the check in the main loop to ensure the full vma isn't
mseal()'ed.  Splitting the start/end could be covered by the
__split_vma() function.

>=20
> The V2 series doesn't have selftest change which indicates lack of
> testing. The out-of-loop check is positioned nearer to the API entry
> point and separated from internal business logic, thereby minimizing
> the testing requirements. However, as we move the sealing check
> further inward and intertwine it with business logic, greater test
> coverage becomes necessary to ensure  the correctness of  sealing
> is preserved.

I would have expected more complete test coverage and not limited to
what is expected to happen with an up front test.  Changes may happen
that you aren't Cc'ed on (or when you are away, etc) that could cause a
silent failure which could go undetected for a prolonged period of time.

If splitting a vma isn't okay, then it would be safer to test at least
in some scenarios in the upstream tests.  Ideally, all tests are
upstream so everyone can run the testing.

Thanks,
Liam

