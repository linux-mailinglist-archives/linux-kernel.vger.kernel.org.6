Return-Path: <linux-kernel+bounces-395229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 011539BBA94
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB67B21154
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603981C2DB0;
	Mon,  4 Nov 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YfBIXl+9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tYQxvX2a"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78B1C232B;
	Mon,  4 Nov 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739159; cv=fail; b=WcaYXZ3SNhdvf1EC90gEbmaIx75wpSiEHJS+lIHIqzBL88/7nT9eM97j5Ty6VLr+6Xp8Xqk4tUIhE/MPl/xe9ifjTMRqPWhlKQWpILmuyEvHxU2e+myjtJ1jApf8GCmdeo2Qn/4dagbSEcJ57ZT63abgWWJm1Fb+ZyTeng0Nz08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739159; c=relaxed/simple;
	bh=DeX013zp+Kd9U81mSCqHEwxjj54yZWHsbWfw1DLQIiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ughfNtMMrXJDl9rAa5Um4NCbNCzlRa7ElmL0tD+gXMEQs43Br1uKq/gCyscfOM5m8cWINr7lR9U5m9Zbiap1VKCcR2c9YlBq9Gf4OgU1BZ5jkxB1FgiapXWOoFOGfkSyI0+IHVfdpp9NlSChqogghVmsoZgqR5vTvxXaUI40QKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YfBIXl+9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tYQxvX2a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GMdxe021534;
	Mon, 4 Nov 2024 16:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5lVZ5bneA0nw053XHrC7LPlbX2sCV8yUV2w1SV3qIrg=; b=
	YfBIXl+9zpf4oLCTFgNW5en3mu/dhsP4qPR5c0sHfne3ln+AxNoAtDdoF6ICsE7y
	Vh/J2/lI0LILNRG0Hw9ITnPty1DoM6n6qLwItYsybzUSX+w/YwZg6FQ5nrDvcC5J
	FpJ2QQmd87KC0icuXkxgmOO59a09x93iSx0C5NFB4b7nrqcx8LJacYjB6+bgjRrz
	hkueuj1spUokmgr/loSsR33q1iO8cPVeQLG1GzB8a0OxuhZMumOCWlkRn9tEdk99
	GUCY6NWTZvkhUNxmo68FAt1VIOMWL1VQf/Vxbb65bt2B/+k/Dw8k7jv5dCkKsjw5
	r0RReMxqvayS44Nm8R0L7w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nanyu9bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 16:52:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GlgeG009324;
	Mon, 4 Nov 2024 16:52:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahc9tsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 16:52:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UabnEChh4FcbHyueTj5ye4r1e+vFqvSJ0QTgnF29zMUBVtwjFDZEezgowWZa6OZBWQdfRMx8gulCJJMf8aCMlyeN0jfOZk5o9qH9XFJ932/cAkIZX1gIaEX1rXJECkAFAp2Z2/Se+NoPlHV4+0ZSh2Lpo4FNl1QCsGo2n+IT8j3ChpPDuHWCTv/L2q0ksnS7xIA2CGT56g5u4Xcjdzk0riPLAsumn3A20jDAMt1Ud6oGIU+P97VHA/xZIyrA2yWfQTPL/fZh/rwoOLLALSdObY074JbGYLZ8DByWtpW1jsz28imLu0zG1gKw4GP5HGSN9UuC8MbEok+qLDIWj/+Njg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lVZ5bneA0nw053XHrC7LPlbX2sCV8yUV2w1SV3qIrg=;
 b=O+8UcV+eipOL0BNlU1WlfHFafTNxuZxSBh3BK1x8n/xdJeeNLWyrcxKd+2gZeIXyFyFtDAbbIbmp1Z1BpRm/eg3g5KLUkhat+vYYj/e/Blun3sETyPKpsC94pQ3nSv+eSusD9aIUetP3TccCrZw7jPRhlUPv0s3yduuRKZalRg6eUEDxSO+Ou2iPMKz+UhgjmR1+SbCnwNRp5KJJlOWQKK1QTZOkvnIyF7BJEtSddbvaAeUMxVdm0X9Klk4AlfVtvAAt+crYkFLHMDMCP6CtcNdbCSjNaRUPeUK2jhHlKFmX1LG4Kq/LDT69+OfOitVkWXi0vfgS+Jj5nr1HSB0K+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lVZ5bneA0nw053XHrC7LPlbX2sCV8yUV2w1SV3qIrg=;
 b=tYQxvX2ajoTUU/y1sACmCtpGoyS68QDvGfBFgoo63kRstT/oJoMEJGe9FUGe5eSZLDr/xcV7DOmnKvVtaUp3F5dY4cVuq9CYaXvk4QhsEYKZ2y4teBWdYi745gZxeiZY+r7LpJSkFEm7VUVd40HBl3E3vB6cOLePbZvgkIB75Ug=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB7078.namprd10.prod.outlook.com (2603:10b6:510:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 16:52:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 16:52:10 +0000
Date: Mon, 4 Nov 2024 16:52:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <e41dcb48-b59e-4d70-98f7-da18fafba31b@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAH5fLggUZJpmSd7F_k5bVKs0-ErK_74-zpWgMyWHX4vcSM-8Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggUZJpmSd7F_k5bVKs0-ErK_74-zpWgMyWHX4vcSM-8Lg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0543.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a3468f-a96c-4514-8c57-08dcfcf10602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHA0S1RwTG5lUVFjd25BSHVMd1I3eFkwREVYcGZ5MERvakNUVDBZaEIzOWg4?=
 =?utf-8?B?dVNaTFI1SGxLVUJRYUphQkRFSmZjU3BxSGpBUzFtOHQxZExTS0t3ZldyNTB2?=
 =?utf-8?B?Z002UHJZVzFSeE1yd0t4SVd1Y0JIQS9tT0NxbnJoMWRaNW9TZ3ZSdzQ1THVN?=
 =?utf-8?B?K1VERDJWQ2Q3K1VuUEJBNVA5Qy9GaVJTaG1KWnlHdU5iY3BSdHhkTGkwWjRV?=
 =?utf-8?B?V0dpcDdsYzFBUTFYOUp5VGRZdjFsMFV0TjZHYWFmaTlrdk4xb0piSGE1YldG?=
 =?utf-8?B?ZFlVQXZOMWNmWDBLeDh5NnREY1pYR0FaTnVnZmh2cGFkMXdUcVZEallrOE53?=
 =?utf-8?B?dzdIWWlLcHhSVmwvSTZEdnhrZDRPZEsyOUFaRnF5Rlh2dk1sV1I3OTN0L2ho?=
 =?utf-8?B?WTVFSGRmanRsdDBQWVF6RnBzUmUyTGxCOWRjOUlNbjlrOW5HQ3FpZWc5eDZo?=
 =?utf-8?B?NWdOOWlvMGdMOTFNKzVIQlMvZjkvU0RPdFJpcml1M2V2eTZXU1F2a1dOUjVh?=
 =?utf-8?B?TGtHUXB1VG1BYlhaSnkvVEZYTnUyS2Z3enhNMFAwNkVreWFKN0RrVkNCUmM5?=
 =?utf-8?B?WElLbHd4MXJrQkhpRUtiS1JhaG9hSm5zbzNQT2dZTE5hSVJnazFZV0h3UW0r?=
 =?utf-8?B?ZDRXNHhFZmVybmlRVm5wUGszaDc0bTdZdExyNmdPYzdGV3JwOXU4Nm1sVC9y?=
 =?utf-8?B?M1pWS3hONXNvRW0rT0tUQUxpL0drYzBUeUY5ZndlV0t1dTRTNzVxSUhycmlK?=
 =?utf-8?B?a1dUcGVMbnp1aTlnR2pVVkIyU0tEaDlsZzdrTExEN2N0Q0lOcGhrVE9YMWZV?=
 =?utf-8?B?ZjZhT054MFVJUW5YUVVvQUxaVTRrcDRBNEZvRzZMRHpKV21aVnR1YW9FeGxN?=
 =?utf-8?B?V3QxSEdGRGNyYTMranJkMVAva3J4dVpWYVNWTHE3My9BcXFWTDgyb1lWWHRj?=
 =?utf-8?B?eHFpaUdJR3VoT0gxTVdISmJjQkhqcnR5MWdTRzZJeCszaC9aTGRGa0dWdEd1?=
 =?utf-8?B?dXRlN0NoaXNjLzk4c09tT2kwdkRYUG5aTmhqc1ZOWUlXKzVIU2YzeUVVNlh4?=
 =?utf-8?B?dkNGWStjNyt2bHAxa29vYlhrMVNndm45RmVHb3dHZG5FRE0yVFRNeC8xWTJC?=
 =?utf-8?B?VlgwT2Fpb2FvSVc5M2pxV3MvQmJuMzg4Q1NUSjFkdVFmT1pENjlZYjVraXZm?=
 =?utf-8?B?ekF6M3N2c1NIeVhYUGdwRW81VVhXdUJGMEVWSUtxc0gwY1gzcWVDdXRVMmxN?=
 =?utf-8?B?N0M2aUFvVlJSQmZhSGFhbGhCQ1VvYTdwc09ETkoyZi9BZlRFdWhxZGsvbjBi?=
 =?utf-8?B?SHNUZnJrMVpkdmF2QXVWMW90YXhmKzRmbkx6R25CVDNqeXNTcEhuRXdvNjg3?=
 =?utf-8?B?cGw0TnAyWUR4WUNOdXVtMGxWTWRlblBlQkNLSlovY0tjKzBPMHp3aUxNWENB?=
 =?utf-8?B?L1pzdXh5UDlXQzFQd2JwWGlOTWFQcmdDb05rYjAwNDZqaGpGSjkwVkE2eDlI?=
 =?utf-8?B?Q2dNUkxldHZLL0psN2Q1UDZzdFdzbXZhOENUb0p4VVVRWlZoRWQ5TEVUUlJQ?=
 =?utf-8?B?UkpTaVZMc2VtTkQ5VTdwMCsvVUxNWUt5Z2hPMUZmcUhTbHVVZjZSRk5VdXV5?=
 =?utf-8?B?RUJRVzNrMnFvb0tZeE5ENytLWWpJeDJEZjVYSms4bHphYXBCV0gxbnRFQ3l2?=
 =?utf-8?B?ditXaGtpbEhaMVNoVU0xOHRTQnJ6QlMwUWhhWklaYVp2ckdQNE5LSE8yWGxy?=
 =?utf-8?Q?ccNL6fd+jjB7q8VBfeMmTrVNhIcEoawbFPQvrjT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aytHTURiMVBxem5tNTZKdWlhcVRseHhQVlFjQUZmZGJXb1pXSFZzRElXTUox?=
 =?utf-8?B?VUkrMlZQczlUZ1ZkcG03NDNJMFZER2hwaERXZHVvb3M5RzBPOEhXRytYTFBp?=
 =?utf-8?B?VGxlcUZoNkh5eGhzTFZxWnNJR29yQWtPTnJqNzBONXNWUVRTeXJ4L3JSWjdh?=
 =?utf-8?B?eVF0TmxXbUxGVlYyT2VPL2wxWGZ0cUNINWRRNEFneFlSWnp5MmJqQnVIZkZm?=
 =?utf-8?B?NThVbVZTZ3RTZmpXTThRUFk1b1BEaVF2WkVXNWxjeEtiOEU1OHhsdFFmUUtH?=
 =?utf-8?B?SlQrRUVSUnBpOW9wVlJ0eW54TFY1RXBiUzVWWDhLNW4zc0plaHNIN1VYNHpB?=
 =?utf-8?B?ajRPVzlwaDhSNzQvTTE0TWkycitVSW5WVGtOLzFLZGx2SktZVlU0NmtuWEox?=
 =?utf-8?B?dTdKSytZc2M3NEdQekptRlUxOE5BVWV3aERIZ0Y5b0UvUUhVckxndDBPdWR5?=
 =?utf-8?B?Q1dNOTJnTHJlalk1aSsxK3RKbDFRQ0xoSzhYVW5NMTRjRklZb1NET0s5Uy9Y?=
 =?utf-8?B?ZGlHcTFCMUg2MC9iZityUHM2UzBrRUZhSWJZblJCTTJSV2tVTldFaGNvT0pv?=
 =?utf-8?B?Sk0vc21reHU4MzFJY0U4aUl4S2h2b2xiQS9zaVlkaDBvcHJib0Vya0VEWi9H?=
 =?utf-8?B?MzhZcDJURVBUVDErWmVmNXRpZnFxWFArUkg4eHE1NU9DdyswUFozNjFNa3hX?=
 =?utf-8?B?YW5oc2JTSnJZQ2Z1U2c4UExqalQvdkRvOU5wZ2V5UGREVjYxRVRiUWVNdGNU?=
 =?utf-8?B?cjQ5d1RNZzdyd0J4OGFZaXc3SHMrRmJ3VmdoZ2VWaEhpR05hVWtZbTVtcVB0?=
 =?utf-8?B?L2JjSDdNSy9ra3lvYXJQK2VvZVBadWJiNnovRFZOcnI5akNhOGZtdWsyT0VD?=
 =?utf-8?B?SUluNlpqWGIwb3o1TXhnQ3J5dDBPMCt1eWR6VlY4dzJqcW0wR2FXWGt5SXQ5?=
 =?utf-8?B?WU5CRk82MzdxenlJMUZ0SGJ1cHVlWmxCUXJqK0FPOFloU3h3dEROS3c4UVNT?=
 =?utf-8?B?RFErTytKOEFKLzZ1UmpYbEcyM3czeGZYbS81ZXVlYVB0R3VuV24zRGUrWUtO?=
 =?utf-8?B?NkdFMzR6VklySHBGODVzWVl0OHNvYXlkcXFsMkk2WlFBK1BMK1Bkb0Q1dGpR?=
 =?utf-8?B?SDdvNjMrSFhkc0pzS3ZEUUdGTk1NM09taHlqSU9KSGN3eU90UTVFQldzN0xO?=
 =?utf-8?B?dzYwZVJwRGt5dHh5RVl4eFc1bmxOT201S1lkNVdBRDRnTEJMY3c4UXRlVEdr?=
 =?utf-8?B?eVdyRE9nSXl6NFJVRU9UQ1M2MVJXeEl0bVhzeVEzazJaMW42Vkg4SzV2RkM0?=
 =?utf-8?B?eElSMUhldE1aMnAwN1BRNmI1dGhVSXBjaURvT1k2QmM5MzRHTmFmaHVZVGww?=
 =?utf-8?B?cUxVcTRxQ0k3bnpXVWZyT3FwN3JVWFhwZTVsZytXdklaSEZZVHdEcndGMlJw?=
 =?utf-8?B?UmRScnFGMTdJMWxpTGYySWpscWh1akoxM1g3Y2REcEVrN3JDcHJMOHBsZTRB?=
 =?utf-8?B?Rkh6dXBlYzJSKzQ5RTUrRW9BcE9jMXhUYlFWa1hUWW5UQU5MbnRjTXd3RzRt?=
 =?utf-8?B?Q2N3VVp6WVJpRmhJM2RyUFhpVlFsdEl6VkVkcXlCRTBESzVhbUNObWhUSUgv?=
 =?utf-8?B?QVFhYmo3NzBEZ1VKUFl2RFN6U05UNDRPamlzTktjSnJVQldUKzVMdXUyaEV1?=
 =?utf-8?B?WDF2SFBqUHg4VlgvNzY3K2RLSms5a09nUSs5bDBnMjNzeU5FcW9VTldUWVJa?=
 =?utf-8?B?eWRHNWJ1bE5tWGFvMDhkNDh2MFlXWFlMS0xOOUVlZTZ3VHFpWEY1ZlpzTVpn?=
 =?utf-8?B?VEJlZFZnQS96TmxTWklVQ3dtOWM3Ukt0R1A1b2F0MnJJSWlVZ0xWeFF1ZnBn?=
 =?utf-8?B?S2x4T29UVmFqTHJNdFNtdkpGMUgyQjJNd0FRUzlmWnhMaGo4QnJ2T1R2Y201?=
 =?utf-8?B?b3VBeWRtTEM1VXB2UEhaaDNPWTBjOWw4OHZQRFc3Y21abThSRmdKU3pOektv?=
 =?utf-8?B?WXk4TzZ3d2g1YmVOejNEVXoyNEo3M2Z2akZIbjlBaTJidDQ5TU9RR1FTTmZw?=
 =?utf-8?B?UjVpeUJWQUFTaVNKZVI3bElSeVdZNmJaZ2VGR2ZyT0dxYVY4bTBETFRYTm5q?=
 =?utf-8?B?TmlrWVBlNjRYSURsYXZ2TFBkaXNaZzRmZXNBRmtSVmZ5d3JkWnhiMVB5VmlF?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tsv3t1pT7aKTN6PFR5z+A21+b5b5m1Cil93eyNkg3mZknvXjNgzg6f19QgDNKqVqrmdotWZrdoB+iuaiuJ7oeT/sw9+RXVHRCs5eE6cAp5rWJVYvJqEee4LTnrmeS/KdvwWAg37u4QoZ8Dp7dTeR3TcyzzPQs2usS4hq8iKIHXU0eSjYtY26VNt2u6Ox732YP4HxnIbjG2Hy3HPZyHcc/GGt8YB+In2zZ2/Yku5SiwDA8vG2AKcWVkPD0LcZrgA5S+jS/N0YKksPdSIEI9MitEU2qR8+oYx9DxBMCG+jg7o6Fn2xQ8TYZRYqzWJsXu+ZCtouTlby2BpFGkqp50UrMiFCPd38kOlIllI28sd45V4Ubi3UCXsIr/aSXJyZr8hSQ7dGj0uauAYLb9B5DdLHCu1g4tbiLOk20ZtY1WYZmeIomgSNNy2dCxcMaAnQV0onok/dssLDhn0dPnPO6gRuqvwVgqfLtWBZ3OrO2WAloS/WGw21hEE2Cb5GbVEuaNcUqE7EnBR3nXfgSBEnj5B+KbhVHBY4obODF13I72JvTPvcSnyvfAQtUF9gUX6syrIFIVX7veRr0ftWqguOlYuZa9bNDVrBpZUEzHjvLvVSVvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a3468f-a96c-4514-8c57-08dcfcf10602
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 16:52:10.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNZcFudG8EEFGZtTZkLux2IoDBSWj928IyZLU5sGG8m7Vp5BXUJAR5KVpy08HyaMOlpAQJJ3fd8Vm557A0O2UjfblTWASAaLtv0yMP+i43Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_15,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040141
X-Proofpoint-ORIG-GUID: eD4WvTQ6rI--GqOh3W85zupBV_3kJw6G
X-Proofpoint-GUID: eD4WvTQ6rI--GqOh3W85zupBV_3kJw6G

+cc Suren, linux-doc who I mistakenly didn't cc in first email!

On Mon, Nov 04, 2024 at 03:47:56PM +0100, Alice Ryhl wrote:
> On Fri, Nov 1, 2024 at 7:50 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Locking around VMAs is complicated and confusing. While we have a number of
> > disparate comments scattered around the place, we seem to be reaching a
> > level of complexity that justifies a serious effort at clearly documenting
> > how locks are expected to be interacted with when it comes to interacting
> > with mm_struct and vm_area_struct objects.
> >
> > This is especially pertinent as regards efforts to find sensible
> > abstractions for these fundamental objects within the kernel rust
> > abstraction whose compiler strictly requires some means of expressing these
> > rules (and through this expression can help self-document these
> > requirements as well as enforce them which is an exciting concept).
> >
> > The document limits scope to mmap and VMA locks and those that are
> > immediately adjacent and relevant to them - so additionally covers page
> > table locking as this is so very closely tied to VMA operations (and relies
> > upon us handling these correctly).
> >
> > The document tries to cover some of the nastier and more confusing edge
> > cases and concerns especially around lock ordering and page table teardown.
> >
> > The document also provides some VMA lock internals, which are up to date
> > and inclusive of recent changes to recent sequence number changes.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> [...]
>
> > +Page table locks
> > +----------------
> > +
> > +When allocating a P4D, PUD or PMD and setting the relevant entry in the above
> > +PGD, P4D or PUD, the `mm->page_table_lock` is acquired to do so. This is
> > +acquired in `__p4d_alloc()`, `__pud_alloc()` and `__pmd_alloc()` respectively.
> > +
> > +.. note::
> > +   `__pmd_alloc()` actually invokes `pud_lock()` and `pud_lockptr()` in turn,
> > +   however at the time of writing it ultimately references the
> > +   `mm->page_table_lock`.
> > +
> > +Allocating a PTE will either use the `mm->page_table_lock` or, if
> > +`USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD physical
> > +page metadata in the form of a `struct ptdesc`, acquired by `pmd_ptdesc()`
> > +called from `pmd_lock()` and ultimately `__pte_alloc()`.
> > +
> > +Finally, modifying the contents of the PTE has special treatment, as this is a
> > +lock that we must acquire whenever we want stable and exclusive access to
> > +entries pointing to data pages within a PTE, especially when we wish to modify
> > +them.
> > +
> > +This is performed via `pte_offset_map_lock()` which carefully checks to ensure
> > +that the PTE hasn't changed from under us, ultimately invoking `pte_lockptr()`
> > +to obtain a spin lock at PTE granularity contained within the `struct ptdesc`
> > +associated with the physical PTE page. The lock must be released via
> > +`pte_unmap_unlock()`.
> > +
> > +.. note::
> > +   There are some variants on this, such as `pte_offset_map_rw_nolock()` when we
> > +   know we hold the PTE stable but for brevity we do not explore this.
> > +   See the comment for `__pte_offset_map_lock()` for more details.
> > +
> > +When modifying data in ranges we typically only wish to allocate higher page
> > +tables as necessary, using these locks to avoid races or overwriting anything,
> > +and set/clear data at the PTE level as required (for instance when page faulting
> > +or zapping).
>
> Speaking as someone who doesn't know the internals at all ... this
> section doesn't really answer any questions I have about the page
> table. It looks like this could use an initial section about basic
> usage, and the detailed information could come after? Concretely, if I
> wish to call vm_insert_page or zap some pages, what are the locking
> requirements? What if I'm writing a page fault handler?

Ack totally agree, I think we need this document to serve two purposes -
one is to go over, in detail, the locking requirements from an mm dev's
point of view with internals focus, and secondly to give those outside mm
this kind of information.

It's good to get insight from an outside perspective as inevitably we mm
devs lose sight of the wood for the trees when it comes to internals
vs. practical needs of those who make use of mm in one respect or another.

So this kind of feedback is very helpful and welcome :) TL;DR - yes I will
explicitly state what is required for various operations on the respin.

>
> Alice

As a wordy aside, a large part of the motivation of this document, or
certainly my prioritisation of it, is explicitly to help the rust team
correctly abstract this aspect of mm.

The other part is to help the mm team, that is especailly myself, correctly
understand and _remember_ the numerous painful ins and outs of this stuff,
much of which has been pertinent of late for not wonderfully positive
reasons.

Hopefully we accomplish both! :>)

