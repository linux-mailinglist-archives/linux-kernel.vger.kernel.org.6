Return-Path: <linux-kernel+bounces-424996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D909DBC33
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C26F1642D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593201C1F00;
	Thu, 28 Nov 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fbIZEKZa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oH89cRy3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B231AA1D9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732818956; cv=fail; b=T5LD2i+55dECVFsSbCIODK3dLIwF1k22j3HQJGSfGvx1KTJZEp58q/jibseQezQTlNDzjTlKrJVe0rbHj6GGQCDXwKQd/Hmhg5e793Oj8ejvVI867Ug5Pxsx6Rx8icvtEnHWYEf4c0EQo4H/QQejr1jNwk+ppl414vpV36/cLos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732818956; c=relaxed/simple;
	bh=p/g6MM5N3Osez6ujvZgAuAoAJxL/u2GatjhUWcB+8zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lghlV3uHkvXtenJac7/oStK+y7j0EKObQSziKMSpdbjVTH5e/QHC1j+FNWn9l1l87X2H4HY6/c/jUzwx7yTqgHZY7GNIMGXUWjKaEm2x6iB5GaAvjAGo7DTKDtBDHtfNj3PqTZv5x8TApNRkmJDHuZgzpVoTpTDvENjeUOkJhUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fbIZEKZa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oH89cRy3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASEFKIK029180;
	Thu, 28 Nov 2024 18:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=p/g6MM5N3Osez6ujvZgAuAoAJxL/u2GatjhUWcB+8zU=; b=
	fbIZEKZaTJeMe3sxIM6aagtfFwGuv0gkjtm/En1y5vc/vvCwXkfsvHfBVn5QGYiM
	7w+Gx0oleoK9aj4eIJAqyoZmi6DbhFu1mMQolSyZIgpdqv3mhF7kHy/uTRlmgjES
	El4Rs6QS/p8z/s9oMNbZI/ROtyMZvA6jewLnYQ4jHNT059y6gXszggHxlYzu47w5
	qfSxsuaVZ0OIyEtZHyfhsinKJBmwywQkoYjV1iVJqVLa8Z2bJ0ZV3P+YL2ZmXRxH
	V82b8mwNtF95SrWpg6DWz7/O5UgJpxzhP2XfIjwp7sXrLr8qQD1VxXt1TmQwFOvV
	MSBrsYgC66ntsfmm/vG7dA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xxa7bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 18:35:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASFjOg6027628;
	Thu, 28 Nov 2024 18:35:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 436704c54r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 18:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBj5B8bVuAXxuLjsugynGzqRAKTE1axYGolfcnA6vaRagwm3SFDDuGh9TiMFfCGiJHsh6gXc2WPJTZXkrDyxHZxbL5LFyqj1wJHqaPeW5pjRfQxFcHpefRed2YiQLRsi4cIndWXq2hO7ClKN9DgV19V5vuC65RoQMH9K/V3mOJS6us/oWSnv82mTpZrzgOvOLlOiHGQi3fifp/3MDcFHAti+b15oowiUWnEGYspPp7AYgc9VkmN5XqV6Xq8jJLFGdD10RM7F3OqxcL6nl5WiMdTNG5i/P1/yNVg7xrvW3b72t0dZw5FZoGm/3lCUMH7yQUT0hKhS5iMsZgkvG0GVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/g6MM5N3Osez6ujvZgAuAoAJxL/u2GatjhUWcB+8zU=;
 b=EBRBpiK8iPx+9kJbATTGQ6A//wTCgPyDupqNKcy7KE983yxxSSSE7MJeVIQo7YQAguJbvg60bFjdnAgWwH/litBosh0RrZOZ81Ad84vn1DQtPm4ZkojdhyE8WM7VmaF8NRU7qscGYddZeXPSk5DXWgqJIxdzotcs2xJ+eVhJWpJ3Bqpx65YPAHoqUpO06N1eIOr5oBTCdLKcijBdeT0cozwWGFU9sBHx1sGTzqHUNs5xM0mh6cvBfki+8+MnT3lh5tSGDqh5l/nljGRQdetnr3eAfyYZW+axHN5Qkl6+2LJhN5z8p18yzxsacVb7C5Pe3fTpRKXbay7CkBpeU4jxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/g6MM5N3Osez6ujvZgAuAoAJxL/u2GatjhUWcB+8zU=;
 b=oH89cRy3oPZwbYK1LEzlv9btMhEPVFnG4JCL871o4LNNo4Y1uL4/xYvskNy+Jn3h5oc9lDoQli6ZkqQ2bdivNLZLb8cL9oiYwmP/z6n7UEqGzYIQ8RIyd4f2xUT9UT/vdgOd3KSda+99xauvkdZd3KxcUzuIFbWSWkFeY4TcV8c=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6338.namprd10.prod.outlook.com (2603:10b6:510:1cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 18:35:30 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 18:35:30 +0000
Date: Thu, 28 Nov 2024 18:35:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Julian Orth <ju.orth@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
Message-ID: <7cde8a1c-28a9-41c3-b568-9198bc1ab662@lucifer.local>
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
 <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
 <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com>
 <CAHijbEV6wtTQy01djSfWBJksq4AEoZ=KYUsaKEKNSXbTTSM-Ww@mail.gmail.com>
 <03678794-2e09-4b93-aacb-90ca6ab36682@lucifer.local>
 <CAG48ez39-GaWbLYX77ZTJFW5oe0V7GS5MEQUaKSjYeCEDM0-vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez39-GaWbLYX77ZTJFW5oe0V7GS5MEQUaKSjYeCEDM0-vg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0257.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b59af83-a57b-4692-8c49-08dd0fdb6f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUZkN3cxNjd2SXpzWkZKcUE0eHk1aG5YNGsxQktQeTJMWmNzdHV0eUFvZUZX?=
 =?utf-8?B?K0s5UVZ6TzFlRnhnTmZTRGxBa2YzWVdNTjNjaEw3Q0ptTVNrWkd5dmVDRkx5?=
 =?utf-8?B?d29rVGx4RzM0SWtmRk5xN2tFMnJSQ0FYbmJzdjA4eE1NRzFmMTdzTEMxTWVZ?=
 =?utf-8?B?SElVeGRaOHBMdUhoL2NLWUdDRFdiTjFVUXBWaGpvRC9KclVpT1Q1Y1RqaXJB?=
 =?utf-8?B?U205MEM5bnFWa0VSV2lRaUl3czd4MkhkTzFCNW9yUEhXVXZtNDRZSVhGUTVp?=
 =?utf-8?B?ZFM2S0VOMVlQMUV5cWM2Y3FNZnpTYWdabkhWVWRKOWNQRDJ4a2x6YTRoQVhm?=
 =?utf-8?B?empxMkRGa0VKb1FEOHZKSkNDMXkrR0trNXByRTlvZUVidHpIaERIVWkzQVFr?=
 =?utf-8?B?YVlVdG9ESlJqZUo2cTJGdHV1ODdNVTZFaDJ2YU9McGE0WmlQZEdoRDA2OFJN?=
 =?utf-8?B?NGU3RVZUYStxSThEcjFucEdCaEpoVUVSUEpKUHVEak1lMVZIQWhBSjN4b2VN?=
 =?utf-8?B?NlVRQkx4U3A1dXVRdFNiOHJZUU5aQ1FEYmpRbWVMV2xhRldjUG5mc1dNUEsv?=
 =?utf-8?B?ZmRjczUwa0krUlpRSGxYT2NBVUhFcEtSSkFlbEFhWjU5Njk2bUZSbmVLZWhv?=
 =?utf-8?B?YVk4TnNBUmFyem8xY3Z4MGRieDVLTGZENzNEc1NqY2Z6UnBuUFJsVXJhMXJM?=
 =?utf-8?B?WnhqOGZUKzR2RjBNUWZPSWZScXlqZzdlZkFFenk0WEFjL3Jja0RPRU0rWnJM?=
 =?utf-8?B?V2UzSDVybGFkcUNsZnZNQU5CRUtNeUhwTzlUZVNyaG82RXJqZDdjbFNnTldW?=
 =?utf-8?B?KzB0VkwrdndpUnZNSmZNakV2QXhHcjdKSUNhZVE2ZEw2MnRoSFFMYU5XdzlQ?=
 =?utf-8?B?RlFhZG9pQkhnTDFiR2JDOWwvQjRBdGZDeDJhcXJOVDhkT0Z2b2ZqODBZS2pl?=
 =?utf-8?B?U1hHczZ0Q0t4RWNmZSt1Y2tWdEhxTHlpOTlNdTIyQ3liWkl6VGZYU0hwemFE?=
 =?utf-8?B?K25WcXdlbHJaakhySlZjbk8xWVdZK1NNcmJ6bW1WK05uSWQvSGFmcGVZVkdk?=
 =?utf-8?B?VUVsMUJ3RlB0b21UTnRDbVRDWU01emNINmZjMjBPbWJGazBETEY0NHJCSkNz?=
 =?utf-8?B?NUk3RlFyVitjb0RwQkhXa09Sd21UMWhQb0lGYUl4ek1GOUV0NGxHWnRBbEJ6?=
 =?utf-8?B?Qm4zZE1DYWVxbnRxZkkwcXZFYUhVVHNxaURnUzRaeGI1ZmZxM0hUVitLaUUr?=
 =?utf-8?B?cmF2eERqME9pU296WDBmMmN6SEFwWGtSV1VETEh1QVJGZHJZd1JHNndIV3lk?=
 =?utf-8?B?QktmOENrK1FobFIwQks0ZXczZGdjSDlLUXEzc0pvcFZCK1duaUZteHhQTjh1?=
 =?utf-8?B?b015U1pwZVBxQmtOeWJlSE9XbnRmSWYwOVhGRy9qN0JTNXpRL3o3OEo4bVlr?=
 =?utf-8?B?eDNKaTZyOGRxcGRkRHh0QnhSK2tLUUFWa3M3bzRyMW5WWGdMUmNicWl5aVRu?=
 =?utf-8?B?YjNKY2VTS2NOSlFJaEY0cm9BU0dXcDhVaWFUTXVFeUQ4cW9CT2RodXlQQ0FE?=
 =?utf-8?B?eldodS9waUxySTRsem9iK285WnMwNS85ekxTRGpoaHc5TmhHUTNpeEVJT3JL?=
 =?utf-8?B?cTdZVWdvNDBMYmlSQ3VLSkFHdi9DdzU5VDk2MFhZUFdJZEcrUXRESFV2VGNz?=
 =?utf-8?B?a0dYQU9ScTd5YW1iQTMzZnEvMHA4Mk16MVRBeTdyU2tmSGxZbG5tWi9vNElu?=
 =?utf-8?B?RWtJWkE4dUp6aURrMzVHTjEzbjRHcFhydUw0TnlVSTVDV2YxSWpRM3k0TmlL?=
 =?utf-8?Q?LQVayFqxIcWSIyb0CHk8k7Rs/GxK3Uyu3EMGY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVRkRlhJcTUzZHowNVB2NUFsUTBZbWtBNTRENFdHNTlCRmsvTzc5cWxodTVi?=
 =?utf-8?B?Vk9IWmN3c2V0MXBWeTZqVXBWUUdORGdQUkladFFrUnY5Nnc5bFFQM09saFQ2?=
 =?utf-8?B?Z0o3bTUycmwzeTdNTmRZOG5yazBPb3h4OXpmemlLZG5EQzFwUHMzcFBSa2ww?=
 =?utf-8?B?eHQ5aUQrejNhZGNLdE5SbGVWWlVuRGVZM3JYbEl0VEJoWWRzTnRZQlBNUXdQ?=
 =?utf-8?B?TzZFYk5CMHpDK2Rlc085QkJSNXBJN0V4NnRMano4aWluOC8ycjhIVU5mRTVu?=
 =?utf-8?B?Y0E1ZHJ5T010UmdyN0ZhTnRteCtJZGd4NGwwRG1qRlR2N0YyVjBmUHM1L2NN?=
 =?utf-8?B?bFdlUURTaWJaNkJhUzJFSXhhOFBLRkw2aXhIV2lPQU1wbmZTbkJ2N0hpbGov?=
 =?utf-8?B?TU5hMy9PUjVVc0QyUVZGb1N6N2xIUDJSaElpOWRmYUdNMlhRdktUVHFpWkUw?=
 =?utf-8?B?TlZNakR3a1JpOTRhT0dONUZoNzE2MFBoZkE3MXZrWVRadDR5VjJKWkhma0xV?=
 =?utf-8?B?VXp1eU1lc05OYUhSc0kvbDBBSkQyUlRCQnZ6TEU3WEYzNTRRS21sSkdZWWVa?=
 =?utf-8?B?Q29pTy9Ha0loaWs0QVM1SzFvOE1JcXZEc216aEI3cmJyRWhKV0pEc0dBMVFl?=
 =?utf-8?B?dCtKSnZrYkI4cld2T2Z2TDlIRUdhV082MWRJZG5zV3ZZNTZtVms5VDFhRzQ1?=
 =?utf-8?B?c0R5Q0VsaUd2OW96NDVIMG1leUpvaSs5d0FER3p5TExBWFNIcjdVT1lCZ1cv?=
 =?utf-8?B?L2lpTEE5aC80bzNKbjVTRExYRzJqck9ERmlxcUJKYWlFL3dhNGt0L04yV2NF?=
 =?utf-8?B?eWlLR3gvSTUyZXpLUjhVRjl5ellNUmtpbDNkbzZkMjVxNjJwejN6OTl4QTZz?=
 =?utf-8?B?aU1WT09obGFVL3BQSWQ5OHBCc3ArUGtJd0c4THc0NEpVSXZDVHliN3h0dS9p?=
 =?utf-8?B?TDhzTlduM0tVZjdHTjdpNFNhb0k2YWhqM0VsNnBVSkFuOURUL2JVdzhsRkpj?=
 =?utf-8?B?L3NSSUg3MXBGekx0TmMxb1EvZXllNUJTMmJlcklHYmt4aXRSOWZuU0NRZ0Ns?=
 =?utf-8?B?VVFHdml2RXBSWDFzODdEZTgwa09tb1dwYlhIS0RDZ0wydTZzN1VGeWdiOUhC?=
 =?utf-8?B?STduNGVtWi9XMFlqb2g3VEpjT0Zha2ZGQzNPd1lCMHVvcW01MTgxenVlVmtU?=
 =?utf-8?B?cU1DMHcyRTN3cFQvT0ZRbThic1Irckx3SDVWSkYvZ0lsZmM0QnRKODVQOC9y?=
 =?utf-8?B?YmY2N25VQjlJcEFjUjhuUWRyT3FqZTFlQ3RLc0RHbVBtZFJXYkV4a2ZncDI4?=
 =?utf-8?B?YldVdnZ0aXhIQ1NDajN0dXJWcHZEeDYrMGVra1d0S0hlT1p5MngwMUFxejZQ?=
 =?utf-8?B?WW9TQmJZcVM1MzFoREx2YkQ5UEhmN1BVRnZWMkZhcGg3Z29LdmtUNG9pTGR0?=
 =?utf-8?B?MVNyd2tBZ1Z3UlNzSUZCUk5udEJ0Nm1XZEt2QmxuK0FRdUEzZU9NRVJqbllh?=
 =?utf-8?B?ZHh3dmNITHFQN3FCRGx6U2E4akNxZ1FyNm1DbXBsd0hGTnFVc1hrVXFTcEdW?=
 =?utf-8?B?L2hDamxsVFFYS3FJUzUyblF5VURIclBjWkFLenE4RjhDSmtzb0h4cWVGZWFu?=
 =?utf-8?B?UDQwVjV2OXRkZy9UUlFnaFg4TmFVMk5YNUQ3R05LQk9PK0ZHbnBabmJjaStC?=
 =?utf-8?B?enZSSTFxeWVMRzM2RlljZHNGK3ZNdFV5K3hJRFNJb05pdGhESUxtQVFoNXRO?=
 =?utf-8?B?SVFNTWM3aWZ4MDFrK2M2cDFrRHh0UWw0NGtzUWExMjM0STk2OU5vRlIxY0lm?=
 =?utf-8?B?ZXNBU25ENDkrTWRJMTE2TXJpR0NiK1JFUWVZaURJamI3WGxiUVhrM1UyVVUx?=
 =?utf-8?B?d2lOcksxbllhS3RpcFBmcmdMTi84SXgydWlEVmZHRHpDRGp5Ky9wcmUvbVor?=
 =?utf-8?B?UmhPSnVDcEFTWU1oazZzS09zMFlicDlxa2JzM0NLVjBkcWlHaks1ZURWOUNt?=
 =?utf-8?B?OXBXUzFldWh1SlV6S1ZLS214UW9DS3JWUnNmc3BZWDNaSmJXdU9KYi84d1g4?=
 =?utf-8?B?UXNraXdzRDdKL3k4NTk0WjM3THNYdTFVODgwRnVhamxWK0JiQlJ5a2FEWjJo?=
 =?utf-8?B?SHA3NHFoczFmdkx1dzlRbVpCbEpSWWxoa2FYSEZRNWJGVnN5RkxnU21oQ0Zr?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fT7/1UM6+6XtWbG2MtKDp0r5bQWmP/hSEDkLs0aTMO2gpo8qbYYnoHxWZ+ndeyaQkAZtVaLvwP2QsjNuKih+eqpM2Ig6uXdqQsqlBOKcV3YuVutQfGsrrs1sXXulwJ48mtB8PVvBdVt+dCjUVcPsFfnvga75WnjtokLtUbCU4TecfkHvpCUBRzlXQ/r7ojff3OQSIRJlJ8NdpYA2QtBjYlQ/s/2d5T9KAkn6unsSbxS0AGSUkwqfbn8vfGMHondcgNXeJHZtYROql8DTOGh4lqZcwh1fzEaB/Cu7pByJhVorgw7gvIW8pH+H548svxdU5rc9ujXEW9qgddi3mSh9Qaba23Cxa6I1YhSZdzbmf/Sa9LC66yB1Q08+rUOLQP31VHbHe11Q14th9BlI0cYb2jRCQZJL+WZp88LD7lbJWROCDWAgqF63G579H219txprzrCMt3KTUmIKuYLC23+eOrYZODSz+d0qJ9mCEj8yVGIHQxf/5skZQ5ZUtfxMrlz/FHGapzs0WtfGtgMa7AFCWc/JPiXdZmUsbw0RVCpMIlXxG2Wdo6AouT5JlXvotKiCI6aYtmosjKRYeAlqNuARV0Y9dAio8U4Waqak3Iikxoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b59af83-a57b-4692-8c49-08dd0fdb6f64
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 18:35:30.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGdrUP/iAjljNlMagQ2JBPEMRUKjGS0Q++DNDgWyKZxk4hTBP7HreeqGZC6OefVbEFS24K4tVwgkps7a6qL4gv4EbRmKHpF/+2ekmeYmdro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_17,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280147
X-Proofpoint-GUID: _V9w2DalLOAyPIo0hmUOtx2lAMzifAFO
X-Proofpoint-ORIG-GUID: _V9w2DalLOAyPIo0hmUOtx2lAMzifAFO

On Thu, Nov 28, 2024 at 07:27:44PM +0100, Jann Horn wrote:
> On Thu, Nov 28, 2024 at 7:21 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Thu, Nov 28, 2024 at 06:58:21PM +0100, Julian Orth wrote:
> > > (Re-sending the message below since I forgot to reply-all)
> > >
> > > On Thu, Nov 28, 2024 at 6:46 PM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > On Thu, Nov 28, 2024 at 4:06 PM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > In commit 158978945f31 ("mm: perform the mapping_map_writable() check after
> > > > > call_mmap()") (and preceding changes in the same series) it became possible
> > > > > to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
> > > > >
> > > > > This was previously unnecessarily disallowed, despite the man page
> > > > > documentation indicating that it would be, thereby limiting the usefulness
> > > > > of F_SEAL_WRITE logic.
> > > > >
> > > > > We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRITE
> > > > > seal (one which disallows future writes to the memfd) to also be used for
> > > > > F_SEAL_WRITE.
> > > > >
> > > > > For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
> > > > > read-only mapping to disallow mprotect() from overriding the seal - an
> > > > > operation performed by seal_check_write(), invoked from shmem_mmap(), the
> > > > > f_op->mmap() hook used by shmem mappings.
> > > > >
> > > > > By extending this to F_SEAL_WRITE and critically - checking
> > > > > mapping_map_writable() to determine if we may map the memfd AFTER we invoke
> > > > > shmem_mmap() - the desired logic becomes possible. This is because
> > > > > mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
> > > > > have cleared.
> > > > >
> > > > > Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> > > > > behaviour") unintentionally undid this logic by moving the
> > > > > mapping_map_writable() check before the shmem_mmap() hook is invoked,
> > > > > thereby regressing this change.
> > > > >
> > > > > We reinstate this functionality by moving the check out of shmem_mmap() and
> > > > > instead performing it in do_mmap() at the point at which VMA flags are
> > > > > being determined, which seems in any case to be a more appropriate place in
> > > > > which to make this determination.
> > > > >
> > > > > In order to achieve this we rework memfd seal logic to allow us access to
> > > > > this information using existing logic and eliminate the clearing of
> > > > > VM_MAYWRITE from seal_check_write() which we are performing in do_mmap()
> > > > > instead.
> > > >
> > > > If we already check is_readonly_sealed() and strip VM_MAYWRITE in
> > > > do_mmap(), without holding any kind of lock or counter on the file
> > > > yet, then this check is clearly racy somehow, right? I think we have a
> > > > race where we intermittently reject shared-readonly mmap() calls?
> > >
> > > Apropos race, some time ago I reported a way to get a mutable mapping
> > > for a write-sealed memfd via a race:
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=219106
> >
> > Kind of hard to read rust code, but it looks like you're intentionally
> > trying to race sealing on the assumption it's atomic when it's not? That
> > doesn't seem like a bug?
> >
> > The intent of sealing memfds is you establish the memfd buffer, then seal
> > it and _only then_ expose it elsewhere.
> >
> > I may be missing something here, however.
>
> AFAIU memfds are supposed to also guarantee *to the recipient* of the
> shared memfd that the memory inside it won't change anymore, so that
> the recipient can parse data out of this shared memory buffer without
> having to worry about the data concurrently changing. udmabuf_create()
> looks like it indeed breaks that assumption by first calling
> check_memfd_seals() and then doing udmabuf_pin_folios() without any
> lock that prevents a seal being added in between those.
>
> That's also why we have memfd_wait_for_pins(), which ensures that
> folios in the memfd don't have elevated refcounts when a F_SEAL_WRITE
> seal is added.
>
> (I believe that's one of the major differences in usecases of
> F_SEAL_WRITE and F_SEAL_FUTURE_WRITE: F_SEAL_FUTURE_WRITE is enough
> for cases where only the creator of the memfd wants to prevent other
> tasks from writing into it, while F_SEAL_WRITE is suitable for cases
> where the creator and recipient of the memfd want mutual protection.)

Those being stupid can also be in kernel code... :) I mean that just looks
like udmabuf is doing something buggy and require a fix which is out of
scope for mm but perhaps worth reporting direct to udmabuf maintainers.

That makes sense re: F_SEAL_WRITE and further makes the case for making it
possible to read-only mmap() these buffers for convenience.

You'd also want to add other seals to ensure it's truly immutable.

