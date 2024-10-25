Return-Path: <linux-kernel+bounces-382052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9479B086C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9D1F23FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB6615ADAB;
	Fri, 25 Oct 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jjMHeqyR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gv/Yr5UX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F021A4DC;
	Fri, 25 Oct 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870517; cv=fail; b=BzKtm8foiuN6h58Sqpyxdy/kQEr9xfJrdGdmQZNTKEjhgq3pIPon8ICY2u65XI+hWmz0PlRCiQx2GuM7he6ZeBB2SRfXuuHKGHpwHappRZvUMgEL+K8/la58bfF3A1/VvyOknwXA9LtiYFIeC0zbgVVpke674tmNdNnw6BoDoQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870517; c=relaxed/simple;
	bh=ID0NCmc0ZONNTf2A3WFAOlGYhXTXYlWkZ5C5e80WFUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LsNyaG/cQQaoMfPcBO4Cwq20Q4qa+Xrwx9qIUn/JPSWoGMoLEkm7h5/BqdChyRW2tIEav2UDhCAVwZcBpp/QGFOuLhz8o+1L1fDgTe6n1g3cVrHrDKlGw1geAs9p8v5vfIJv8iDGlFn48hlUTNtgYNeV5r46ZQqFg1ySZjenlac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jjMHeqyR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gv/Yr5UX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PEta7d028752;
	Fri, 25 Oct 2024 15:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7jJVYsdo4Ted76v1hA
	8V7iU55s8yRFpWIJaKOTchN5I=; b=jjMHeqyRYBEqSN5pP6mtak04bMPMaUuWBF
	5mE1IrgJaW5IJz4HtMkzNJCaUOX1DN5QYIGjEEnMIhkMsWNzi/RLFxCj4qmBlrz9
	CgJMhi2ZxaAFb3LKT5dYJ9y786dtP7IaVxzJ/V6aEpOMF9TySCoO/hr+gSi9S5j/
	Y3vpt1W2ofSt3Es0BbN94e+HD5j12mRNezu7Y5+LW/FSWTv7QdvUEvI42fWMuODX
	alpiQydxz4aNi2NWdtoGKsTNZSroGAFC2njK+D93Py4o5xB7qZVYjVQdBLz/Sblp
	boLQssCUsie+//uEzBwwNbXjmSvGtTdKSkPzu06oFM9JLQsbtdgw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3ma82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 15:35:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PDx4cs039113;
	Fri, 25 Oct 2024 15:35:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh5vscv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 15:35:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6Qbp7s++Lta+jUNwPHcuhTOGi/gDHh9DuCGTYQ3E7RJjvX68GP5iz7hw9e2EYqvzd7jw2Yt6wr0UQzcU4KpuVaFoQBJdOJOuBRXJn5YDB7H95ArLHLoof9ouriV6iHXhxyI0LagcKp22gYoFK5Lh7dv9iV4CMUX7gtE73RWO2ALKakH9vkQ5qUC7zS9Upwvr520bZCg3w8UvoUrFjK1A2vE/DgIjWmedbpH58c2TETsNshBzIDyEd2V9OqBAChFMMl6g0c47EORF2A6I+IEO14OlHsPQysTzQNJV8kAqWziYkDyyJjo+0O3qcaXU7L5K+ALFGHYzelBXwAvr9Eh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jJVYsdo4Ted76v1hA8V7iU55s8yRFpWIJaKOTchN5I=;
 b=HfkVXU43FvEp4S7Fbj8vvLIvD7Wi4lmVkRX2hKuM6OG88ar39PjNBe3OBWbwYt280TC2DkIEBWB/1qU4aIJOsAKZAODQJEzCMKl9YsjNrWnRjppUI9QuEWlgkbN9rbaQjNFfU/ikOQC5xHtL37ovk3beE3rpPt2gEqxJubcse3AY7er+P2da67ihwPl9xcbDYyijNgOvpNFdJZhjUb8dj5hsE5m/kr9MSwbUK1EA+Mgqh5gFRb+m/E2f7RSClJGjHs9+e2y4ZJrjanUzitDvPq9ArB0EbI+YfJ4v8g0kHMWTaagUB0BDxS6XYU6Us570MgCWf4KQ9YLu+heTc25txA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jJVYsdo4Ted76v1hA8V7iU55s8yRFpWIJaKOTchN5I=;
 b=gv/Yr5UX2/SQwNWTKQ8pHEn4G/aqeqWy62YVnMop3G0md0nSTs1lto44XLh8bF2SRPpXJbYd2bWqHrIYLGRSjk6ZQbXhChXIhisiGdCMBx6Sh0X7BwLhs4W+l0O7deMTDe5Z7nlNaHtUQRmspe9CYiDfsjmLNFAAx7U8dnZuK10=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO6PR10MB5619.namprd10.prod.outlook.com (2603:10b6:303:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 15:34:57 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 15:34:57 +0000
Date: Fri, 25 Oct 2024 16:34:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+0ca979b86eaec7337a89@syzkaller.appspotmail.com>,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in
 vms_complete_munmap_vmas
Message-ID: <1a171810-20ec-40ec-ba08-88d068243cda@lucifer.local>
References: <671b7fb2.050a0220.2e773.0000.GAE@google.com>
 <832afb0c-98b7-4d29-8436-1ff6a65133b8@lucifer.local>
 <967f3aa0-447a-4121-b80b-299c926a33f5@rowland.harvard.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <967f3aa0-447a-4121-b80b-299c926a33f5@rowland.harvard.edu>
X-ClientProxiedBy: LO4P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO6PR10MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 1802775b-4d7e-401c-8462-08dcf50a9449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lgKpfbA6tK8Z4t/2x9WP0QCpDlLayReK1VdCW+zWYJ2cvoriADMTj9IhouBA?=
 =?us-ascii?Q?kIINOlB3sA0GLyiQ3BhagdvXhrv9Rg22lBC0GAbd7ij9hqgrLU97gbxxzriJ?=
 =?us-ascii?Q?CIpl1N7t3vlrKVmgH2N4cYK+wX4umZcT4yv564YeIJs0yGz5tJFMTaOJhSqP?=
 =?us-ascii?Q?WASyhmQr1RTX5HiYcgpKOplrV1Qu6TjHq73zJ9CwefLPJFLrmJwz26mYWdBj?=
 =?us-ascii?Q?Xfyl8Z2B4aEIAy4CQey+a6wA1NzU5xXcmBzJ3475kIRyomR95bV16Wlp15LI?=
 =?us-ascii?Q?4a9vqCouUuXPQ+Yy0Wr4gvrihSWL27A2pbj3wXE+dUd7cQFHUS9pAgDQgS62?=
 =?us-ascii?Q?v+GlOoB5MZAKX8CkFvM/ltSSTJ3JGK9Jp9Gps37cIcg9drVOl+rqMtPudxH1?=
 =?us-ascii?Q?poBCAxfDh2j1V7t2/iIlLYHsVVlqg6v5Yt4V05+cvyy3AjIHJFUxghm9++HM?=
 =?us-ascii?Q?rl4G+p+kJB5a1Pet3s9GglfwFhPIjJDsMFr0PN0sCk86dXEVKOjJcYyee2La?=
 =?us-ascii?Q?rPZiuYkmh6PlLaSGMDDy8/t01fJROGxZhl4WgZyUnh7ZABf795j7LI8gugPy?=
 =?us-ascii?Q?ChGh+lAYdHPtE12CLbl2VlGd66Avk42KMCJLaCPLgncmuqCYWmoscxgt4b4g?=
 =?us-ascii?Q?woKeLLBEfyltNBknoiqnnMVn0TQN4oTwiGbtSOUC4npsqAtN/rg2XKMwAeqP?=
 =?us-ascii?Q?sYUTS5XzOEGSYIGGNh/Dth/W/1CBLXQqZtmd3NbkZcUTNf+9PPaDHa3SgCkO?=
 =?us-ascii?Q?wP2BKbqJ0B6Ha76aUOLcIWixXnog04H0C/4+4eIZ9VPujr9A82ISl6I+jh8S?=
 =?us-ascii?Q?J+lBJytP3OA3N8VfbSoCwtiVDC9hA9OmI6lmqOeKgcEUXLojFtGYHq4RoG14?=
 =?us-ascii?Q?bALwqI/2v6QMVLdb2AEBohcPPEMhCwoKrwDF6kSjBgGPvtv0IlEzI+LU6ltQ?=
 =?us-ascii?Q?2YjL6vruKscMgWbWlJYGnDUO0M+3R69ZSj1T9bC5yS1wwRcdK/yW0kyv3V+k?=
 =?us-ascii?Q?ofwsmWtvW0jWVAUnC7LK+c46XasB3DlQh0lVSCtJWgKUw7GbvuxeR4E51uKE?=
 =?us-ascii?Q?YydTW9l5kL7wfk9rjpLKLw8YoMyyq/uFvMZex8UBSrv8sMTTx6xT033GpI7S?=
 =?us-ascii?Q?pc6IYm15aFYejjk7X3l17QjEKDFX6UiOBP3iXROWmmMqtVxuy9k3muRceglE?=
 =?us-ascii?Q?DLXD0mPLw23Ei/7GlCrGpsPBHzcDlbUijjGh14awjUm6Dna/gbSb/SDmBMbS?=
 =?us-ascii?Q?hutl73tLIKPUDvZSas2iWFGNmF1jVyxTtolRLOpf8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?107i+9ZVnHNi4zwG4XLcH4JijT+R0q53E9K+nLf0USm/gADrgAc+TIWgJ4xB?=
 =?us-ascii?Q?uZDOPkargc6CO+p9bobPOKEt9LCUeQlhq0We7iJJThyi8xSqbF3h8HDBwo2M?=
 =?us-ascii?Q?gAXfGSyQ0hWGSZ0TdbQiNKySi0IT4fQFiJDmjhkvSNxj8u+A7fLt5GsrV8QR?=
 =?us-ascii?Q?5r2yAB4wKspDfIVMTe7hLAezOt6D+Zmd7ZVbDt34qVQ7I5YsPHFJimqA+J5e?=
 =?us-ascii?Q?aWEIrOVzPUfokELbM/52su77frCNkdS3L3R89SwvtPRGOJwCDNOFt9L13/e4?=
 =?us-ascii?Q?nzpvQ2twYcRqumB7ZhvHNufx3zJFCgQ3c97rcYe01zFt9XekgTdAsZ0MN7Ay?=
 =?us-ascii?Q?CClqLDIGJn+jT4VuHR0qRtRD/4Zc3ypOiMvaBvJcweWBtVFMVaqDswnoBWhr?=
 =?us-ascii?Q?SHQwF5nY2/Lcb145g59yGllzGKqwpqUJKVP7+r4gsqP/BtvUJuZMo0lt1OsJ?=
 =?us-ascii?Q?Eat1VqlecqrXWwpah/j23E0xNCTaGE6w5sE5x3TOM5oM0bxvnrR3uH0O7Xxb?=
 =?us-ascii?Q?M+rLyI9lDL+aPrx8W4xWfyAF5dFt9ocVORPfDJeMV76r6nqN7bQMHVcrYSuz?=
 =?us-ascii?Q?//t3nweFIQHkKgTXf9v7+/5mY3rkaE/kqB/hHqu84Jhb2s6wgSe/P+sNuBzS?=
 =?us-ascii?Q?mOXWex4HUBkfih2D7Lh7xLdYaM3lwQx6H5gNvnPqursrW++7I2JxGK4r95v/?=
 =?us-ascii?Q?kyKvhg5QScmNg6GURdlp9YjzJal/yJB3jAV2D1u3YrrI9A4U1ypbr9xCZSO5?=
 =?us-ascii?Q?2OGdnVlWdd9Qpmr29cQjBMVA8cJ5JN2+1LNep9E+jWXTGdxSgA6T4YTHdZ98?=
 =?us-ascii?Q?mFCR0C+LXd+ITd6MWxjlJxiMMPbw9dOS7LaWpclUSqVkZGwsvnu/afjX1tX/?=
 =?us-ascii?Q?/eWoxgZ1A7XbMeM12i4KKzdmE9qcecZ2J+DbZHQrBzSkkMNn6WddmvManL/x?=
 =?us-ascii?Q?hfxGb7QjSj51//BMHV3zjUeaCfsSKuuL5GSypSaD8oPuMMwPzhsCFuhNF7Qe?=
 =?us-ascii?Q?O7nKrDLY/Hq8Dq5zPfyoLk7ldCZfl17/DcPDB4nzurGvjj9xFLW8XCo9uhnQ?=
 =?us-ascii?Q?WhB0EgArxDvOYJWX1Cph+41GJr2htnc9cxnjaVKT/WlC2OGhswur244HNzFH?=
 =?us-ascii?Q?s1mtQA6X7x6Q3++kHRWIdvmIiqZekHykwlD9d4qgBRu/jni+Qlk0t3Sm/DO8?=
 =?us-ascii?Q?T3/gWi4AErWd1N/8NEvgK2crFoJcs6iOfOwZ+SUSWfL2qJ/Q20+x0geQVf3S?=
 =?us-ascii?Q?Ao3g7r7T2yaarMBdlRJkMrff1M454MhoTMI4/xKaQGjxYzIQFf1EbKSCDFKh?=
 =?us-ascii?Q?acSSPR1WiNSX8V+3EYiyPE5OSYFeizqb9LIK0guMigQmiwDwLtC3uSRs408c?=
 =?us-ascii?Q?6xjj2v/bonTayXs34IyDAxRgNAhcUmC5KVSEeJAVZOhaGIXa2dqlvKgF5gLh?=
 =?us-ascii?Q?2Nlj+23wlXnBBuvNFBTSK9HYOZRFCxgS1cFlQyldL91sAxTlosCpyfJGThqk?=
 =?us-ascii?Q?DJY5MfNmiw7+JbfzdQmvOIOc331SKL0sPCNUEWW40NJwMDxHF83LiaU+hZy8?=
 =?us-ascii?Q?pBBv2Eyt2z1KF8hx42XEOBsn9J/QgaN33YqYsqbMa9S779ZJP2C/FieBhD32?=
 =?us-ascii?Q?FrEPKAt2aetGmD/Jzi3uXscRqTxdZTtkLTWuDZsEl6KVNZnVZG+UbnumgyfT?=
 =?us-ascii?Q?PbrB4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O4dzzrAkilHyoOyUuo6+Ve/0cTGLVs8x04ITphmfYOy7jlrXyJOKlN1lYiHA32n1Vg2I8JonM/qU8Omz6OMvHE4TO62cC/S28az24io90MoqalU1z0n2wpOTqas+siq96iXNRjLNz6GcNKJsowKoOlNGBQVTVZP2SgwsogDLNC6Acs35VHK65rmk23Bbbd9e2PaaGdkq7b1dCbbF3gf/ELMOhOWmEm1bhmA+3r/wS8R4g1Mokclg2iQh1isLp7AkmbFTQYM86ql0csOQooZCuK6cpM8PX26uaOs5J1zIMAm/m2dE/RRTE+1d/vrom/ey6pq2873Ifvjk0DUel160zCEv9DdLXI+FniPHwLgPkE8uh6i1xEI7dI13VCRlSfz/eepRGwWiuOZMFaKNQMpPDYLyamXI77bHyLU10w/2/kJYVYt/ODnDSinIhfJ9oKkUiQFmr3/txAlXi+V+UFhmF0TIyuAdqEYga/9W4OV7hLi2K9TpiaaXSIUvPG4dTdQYDgS9S7JHrS+kNJpH+tWLV4EH/a7DivNDt9oy/CHYKdlLfb1O6TRQ5DhDsARcZPCmlK4UCrTnC82nVHIMzlb9l8tcPtUPznBnJfwHhTi9D7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1802775b-4d7e-401c-8462-08dcf50a9449
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:34:56.9759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ns9v3Ngpv4ilDjQWc9Nos1iISe/aZ0lgi6oISlHTo0MZGMaunIP/uAZVydPaZL/fkhhdr5lrZ+RVQdYRzNIOx2ivAL5toOQJFvXpmTliMqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250121
X-Proofpoint-ORIG-GUID: fBYHDbQBLzFJNK-BMfoFVnnoSA0_GJ4H
X-Proofpoint-GUID: fBYHDbQBLzFJNK-BMfoFVnnoSA0_GJ4H

On Fri, Oct 25, 2024 at 11:13:33AM -0400, Alan Stern wrote:
> On Fri, Oct 25, 2024 at 12:37:36PM +0100, Lorenzo Stoakes wrote:
> > On Fri, Oct 25, 2024 at 04:23:30AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    c6d9e43954bf Merge 6.12-rc4 into usb-next
> > > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=139f225f980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2bb21f91d75c65
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0ca979b86eaec7337a89
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f225f980000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/3bf4a453ec2f/disk-c6d9e439.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/e4a2db2a5d95/vmlinux-c6d9e439.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/8eb8e481b288/bzImage-c6d9e439.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0ca979b86eaec7337a89@syzkaller.appspotmail.com
> > >
> >
> > Isn't this just the same thing as [0]?
> >
> > Again I think we're just happening to hit a stall in the unmap logic rather than
> > this being an mm thing.
> >
> > We retried that one a few times and it didn't hit any mm code after the
> > first time.
> >
> > Greg mentioned there was some weirdness with the dummy usb hcd controller
> > in [1].
>
> For what it's worth, that weirdness has been fixed in 6.12-rc4 by commit
> 5189df7b8088 ("USB: gadget: dummy-hcd: Fix "task hung" problem").

Hm, but this is pointing at a commit that should have that? Strange.

I do wonder if the fact CONFIG_DEBUG_VM_MAPLE_TREE is enabled (and by the way in
the mm- stack cited) is a factor here, because that is a very very significant
slowdown anyway.

And I wonder whether it might be a good idea for syzbot to not set that flag
when doing known-time-consuming things, or at least should up the RCU stall
limits?

>
> Alan Stern

