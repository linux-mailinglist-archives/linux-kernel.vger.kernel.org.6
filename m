Return-Path: <linux-kernel+bounces-411133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8B9CF3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD13B34593
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B171D8A10;
	Fri, 15 Nov 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kw6lSqBH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vhhw+0St"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869611D5CD4;
	Fri, 15 Nov 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693807; cv=fail; b=TUTzS6ydtLOypwL0ExWRB5uUO04lBzONSZiWR45EkCmkTb8kfQXVfCn9CjI/XLVtiBHuD7Df3x8cdWMkiLBAq/xqormugo0Pi+iScLfidBM9KrmQSXy1RHEq9IZjqYqOFv9HNJp0+pEptEEAHh60ZR1OZuf9j4Yh1KQEhYhHCLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693807; c=relaxed/simple;
	bh=EUTQ9GY5F5gYOL4p3sUPwj7Rdmoybsni3tOlPzGRb3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pZpz215HFY9HLJ4t+c1B5gE2n5H1KiE6eUFyTUYp6Bsu1EGLAYthLDQIFKcT81BKBczfhFcJFSqYE6yOcNuQ3um4NTAogziRg62TKDdo4h0vhGwMGD5E9oCw8lBaSLi1OoaKubUM41BK9F5a/glnptuQ2Ov7sjiriDHhKnNki+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kw6lSqBH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vhhw+0St; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGN48F006019;
	Fri, 15 Nov 2024 18:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ar+l9ipffKcHysJhSg
	tAhYi68TuGG2m/4y/jUIVxZp4=; b=kw6lSqBHXun53CsQgNaHKNAsn9+PM5cTg4
	eW1CYz7A4xG9686NIweiwXXiQCmUfAS4/a6AF/SbUfoitRkpBvvFXpnyrtSqEJ1+
	+Vb5GhKbIL3E3BNeYsJ4N5Sbx+/q4x3ogk4ANUc55Np7vuE+yvD2DgtlkQ6+hV+M
	FRPSeAaiEGr9XVNMFqpcY1kot7eSQk2g3uDtT2pDSgRAiXwInV2VQixuDtkzUqHb
	4/9kTPtQ4zEJ8yuNfxJkaTQWrnHHG0rT+uf9IE1yznzt/2xcrLyzEloYrWupjhJH
	pFgscda/h1l/+VxTQ0xdGOypR34RuXkuLUwulTR45oWXll4WZveQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5kstn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 18:02:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFHSHAk001149;
	Fri, 15 Nov 2024 18:02:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6cvx0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 18:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9s70N+zKYJjPT/E04Cc559LUxKNpfobarFc4z3kFHgxOLGzchBLVVoaH3nBU5HTVLOJPalPTMuvYvoXRT28tBQAiczns8lOYog8B5VXnWxbR1EwVlCP0DZCJQhbSzaSZZB+TNLnm3iA61De5uXPoDHk2jrpu42Upv1QCkVmK8Iqz69ezCTvQFEjHKRFuSEvNyU45EmmccDnnGxNAzTLYM12XX02c9SiY3hq7qTUHZXFNLtwHqRYt2YU+KESjE8LQmwJpkjgBT+RILAfP4gmV0KY2IXxv00ngUe7yzYJjSLWCL12/WgU6Uy7uworr45q8ssrE7PAmYfrl6iCYZ0frQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar+l9ipffKcHysJhSgtAhYi68TuGG2m/4y/jUIVxZp4=;
 b=MFHKbfGY2vKUORcDwl2o5j2BMpj5Q2esu4KZEKzV9TBWCloWnmlf0S4Er22bPLUd05OEEEUfI9Wfnhn6k22uUspyAdzS0EsZqClPSC6rcyP3ogl2UDuKKn+s/dAZof0CS2hDAQzsJUKte7wusnxb7MhYtJjV6WKAgLPaWtrBTL2UXJ484awcyPR6pb60l5GR6rg815EIcnickQueFFyl3wXXX6D9DvFhezd60QzMcpFE5KyYplxgdt48uX/b41xs0hKSREqPlX8882YeLylpDHkTdBhHh5dPj7xPCHKodXGX7U5Nu5wH7ERkYbdDhEPyjzaDO3mibUJcVZ7nVvvhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar+l9ipffKcHysJhSgtAhYi68TuGG2m/4y/jUIVxZp4=;
 b=vhhw+0StpHo7zkJfQfE/tYMCmvuoz9jMw1xnrNw5cWjl2kDWXECdj8iz+hhO0G8ewMCreNUf+1/u9TOR4Im/JPDXdtdXPVh5fN8pJgDcDBThsH9iHLTHfJMaMFqJJ5aOuLybZ96xJKRKlcVsMtxZy0lRw/FNYfBOpitNwNUvUVg=
Received: from MN2PR10MB3374.namprd10.prod.outlook.com (2603:10b6:208:12b::29)
 by MN6PR10MB8048.namprd10.prod.outlook.com (2603:10b6:208:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 18:02:44 +0000
Received: from MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348]) by MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348%3]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 18:02:43 +0000
Date: Fri, 15 Nov 2024 18:02:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matteo Rizzo <matteorizzo@google.com>
Subject: Re: [PATCH] docs/mm: add more warnings around page table access
Message-ID: <61f84216-75fa-477b-a9df-6f24476ecd8d@lucifer.local>
References: <20241114-vma-docs-addition1-onv3-v1-1-ff177a0a2994@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114-vma-docs-addition1-onv3-v1-1-ff177a0a2994@google.com>
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To MN2PR10MB3374.namprd10.prod.outlook.com
 (2603:10b6:208:12b::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB3374:EE_|MN6PR10MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: c862d196-ba74-4291-380d-08dd059fb3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c0uc/k+530RGhwnC816LTe5ONqvETVjr+/U5S3PluUHenaTI0Uh3Nb+PndkU?=
 =?us-ascii?Q?XIrEk8qz8o3v3D/XyEUuW3GbflkqvFtBWt3uveRVPA0xEooyR95JE6tWC4KS?=
 =?us-ascii?Q?7LPFWhzmIIIpfxyjNigWFfZbElXyNkXRXy6PSiAZZzSaXwCYKZl5uCpP5W56?=
 =?us-ascii?Q?UU9i7K/LxqT0axRutJPGVy1Lkcs8b51Xr/vaOLJaHTmN9mEgw0QrO1R8oWtT?=
 =?us-ascii?Q?vjBMwaS48ecy6OI4WtyyjRnjf7k0haCkUnQkY7Il8VnAAWxGxHQX6+Mwu+qu?=
 =?us-ascii?Q?pHfc2BO3iTyFGFVOgWPlAtF9vlvCwGZmBwpTeHFPBjLkDego1uiHnh36c3Ej?=
 =?us-ascii?Q?a1SecMhy2cNwbyYcCjM81Nufk338dLf5mTMcPeaW1boyChF5rxjAsFSLaeOi?=
 =?us-ascii?Q?On8C9n9YSt3ygbPCc3XA2bUvUVomukGrj65ww3ijHMqxtXide3ujWmMutKiH?=
 =?us-ascii?Q?D0sc9Q0ato+UZZjeXZeB9dKVg7wpqlS3DXzG52w+K3J9IaMyO353MorQy8Cn?=
 =?us-ascii?Q?zRoTqyeTzwl6jxRJctPwr7QDk27ZKRcMM9vtGOpA3WuH0Sv6Z7ch0u3ikFIX?=
 =?us-ascii?Q?WGCea+cKSoxrXSQikYmiawXBvnrkGHzlbknUo8flC4Z6h4Y3u4xv2d8YYESx?=
 =?us-ascii?Q?g1G7ySZ0/ibUplQSNv7iI29KyeKvSCrzeTnuPXenDMjjOPnoI7/07Ltgv0Zi?=
 =?us-ascii?Q?H09kOPt9icXfFU5wijT/QB1rxbqjwSITP2SinvnCSE558kyLZnwiTXJlNKLy?=
 =?us-ascii?Q?O0hT/8vXIO1FgURg8EiWYxRQMLlo+V2j//SBez2EW+Z5/mrRfvlIp+RrgP44?=
 =?us-ascii?Q?qUQMYlW/pHUnJppvPH9Ud4e+9JUNVdFxWUTSoBwRu/5QHYM9zKAhRotEy2ON?=
 =?us-ascii?Q?i0unPIXLMpE3QKe/4ndjFWp/PaYb+1pA2gghG9MnEVAb2n1yN03grYP8A6xF?=
 =?us-ascii?Q?Lip/4vgmqlDmuKcLNvqgEpMWgyDtxYrSeeQH9X3Tr3deZgpi5Udqhokky4tB?=
 =?us-ascii?Q?hFLEhBfRUzRrKfz4cgxE/6Pg7gPCXuwqVBKsLBZIqh49Wl2lu2YALbTvVO3W?=
 =?us-ascii?Q?4aI5Z/fB5cyRjxz/wZGlbiK0XLVPmWXxvSu4TCXWqSyth0bjMurpSl9RBfv8?=
 =?us-ascii?Q?nN7i+BRWxw2R1gJ+Wn04xijwFzmY1Xy9oj8CgrZR/kInNpmwdpKPsjJEoWvH?=
 =?us-ascii?Q?asc0umyTBsPjcUYK9i5G03zgG8Vbyklb58pmEvpq0GNIyopY3KbmlOkhP26P?=
 =?us-ascii?Q?AUENPDGOUllBi1coV7BZcBUGoiIHD9wDlXxPZQFSz5CL9YYsH/faOXhPNE2s?=
 =?us-ascii?Q?8VI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3374.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xyx2My+LMoH43cVM/Ypwx5XHqkNFTM2lUdFLspKtORTVEMxaODR89CUrNwR3?=
 =?us-ascii?Q?HsjjMVfw0sQncZ4usQW92FVgNZYA/TLyw2m24Zcj73EYDv83eniH3US+b8XJ?=
 =?us-ascii?Q?FcaCOlcx+19OH/nBNqvVAraocJxQi8R4371ajnVmlQNuVMGVQr/QYvF5xkik?=
 =?us-ascii?Q?3Xmj/S2Z73cT8dcLPIR4TZ0TS81205RqBVSQNj55aZhzLQVD4fKjgL68Tvpc?=
 =?us-ascii?Q?VP2YObYLc+ubuuEB1nXHONERWZW/aiJyxkDcLUo7FMmO6XoeJ275yVSc0Yep?=
 =?us-ascii?Q?OiqGYPb5seTWJbnHFkbvuFPlV5VL2wvNA+bvUL1d/xT5+F6JMNYHt0m8k5+A?=
 =?us-ascii?Q?sDnJr60hr6wA63QtUjA4UEneZ4+FhMrVbHTFdJgyyCvcODqXFTljof5jd7qf?=
 =?us-ascii?Q?urkwXEpuSqcGO9+3QrnMJVsMs529pJoBr236k4ArR1I2mQZQGYYglK2AZhnZ?=
 =?us-ascii?Q?NLzpIfu451jU4cqFZNz2UkDMU2mHHelwHhaJQ8DaBi719rl7xtAKHeakhNAZ?=
 =?us-ascii?Q?Rp7Hx7RmZudYSJSU5SQ4cbOgS82dS99Q1wZnY1V/pp8uOobhRawX4o48nt51?=
 =?us-ascii?Q?K0ZApr/RvedVIc7EJNcR3xwkkvivFj8hLdxlcRU0M9ZG5gx/GTh6pZxj9lfv?=
 =?us-ascii?Q?g002V9wCpln3An1gEEjNHEqhWRh8/j9cfcLLTCaTh8Ulienb7+rX1O9K0ib4?=
 =?us-ascii?Q?8tsIboUyUjZsR87Xjc1LS75hNHZHZHM6cERxI4z0Z8g6GIW6ZW7Uj4B+NZNR?=
 =?us-ascii?Q?bwY0BtKDfH9mRIEk4KpEAC8Ew6FUJm/g3f9eaY35EOsaOUP+Tx27vdqup/X2?=
 =?us-ascii?Q?lmYeE5xPZ4sVLLTuThTHuQPWYNdZ2C9QUTF0oPjgTdN1BuWWPT4po7RYC3BM?=
 =?us-ascii?Q?lWeUxfvywkucdAGOKn6yuQpBejwVRurKG2/XTYePxu4zQUUeHlDKgy8XOlG5?=
 =?us-ascii?Q?MnzrOpi0kFB8l8Z4B4tpvZnfUHgjc/aijf7uSFc2mpZFkTrwdxVR6mdpNs56?=
 =?us-ascii?Q?2dTme93pkQIGAAQ+6mLGCPnscH5rMWWrbxueHVRm78kUiMW+JU3/21Dsvlq6?=
 =?us-ascii?Q?TdyASgr6SKc2kZk1b3k0nhh1ALmEsJtLwuytxwtHARwr/+h/nmkj4b66WqtM?=
 =?us-ascii?Q?8eItnJVliusM50YP5lEeCf/ssH6SjtCbLozjN/wSuJrLscIGRNSKCJndcxcu?=
 =?us-ascii?Q?0v+srjMwEvMydHdatjq4f/KAmdFuyb1krhGMa539GUSEw+La9L7NUtKE4zJO?=
 =?us-ascii?Q?QgQcb+0c/9bhNX+QnWOMW11dqZbe1zFglof9BEJVVIOo28rtmLDhcmmBjT2c?=
 =?us-ascii?Q?tP//3W44hsU0NfPSW7qib2ONpX0aIYm9PibNMnGEWxlsorvYD4mPpGIVHXQ7?=
 =?us-ascii?Q?fyzqTirueE/dKeLLM74cW0WhuwAR56Rg0rLBkCZbmH0WRu9bxW+pslrpC3RW?=
 =?us-ascii?Q?8NoJKW3OM3vcHE7/L1Ikn1BYWTjbAH40t2lc7WoaH6gnF4gYv6pBaFmkcExd?=
 =?us-ascii?Q?Q1hwa4SYACnxgmAOagy7WfzrMrpOJJWCTxFc8sdoswcATBq7afFXsoC5OXxf?=
 =?us-ascii?Q?BwLuhC6By0krHfjY2IRJGDcqnEvOOdqkkLSw3EBAF4iOjYrOh4QnSuepiIF6?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IY3FzoAJQIBcRRZnHdAEoUq9mvkgJP/Bv6WZSQPhK2nYezT40HVemUZKyGW7kVMpw2shuHmlOFzwHKV6YwrgpsGyg+LVf5E7A8f7KRV0OAb4RnIOctMRkv4Y6WAPbjZt+ATrN8WuTfRsQcSEC8ziwgd8FVhlBWWQ4AAxag4jzgVeK7axroDqJ9Ya2dkgjtgS75xysCG8Swcn1aCLehXwjC3mCCdJedPx9aOmNQukZ93cizkhMoGeMHY+wMBLqYgIqOk3A6N/ks7CqDe73eEPvjE4HU7rkjs0xfC5AFVzIVme66V0FW5zF8748dNbLL6575b4DDkd66Of1AyX1iGKZNxXLwGJa/VX4lwaspfFHgqLTdJJ2Iv+THxry65I/K4Drs8YBa/6KRqxq4ObODEWgRjnXvJetVxoLdWLejAEqgM5PhqDCXizCmMT5Ah6uVK3qVP8ZDzD+a8WtQJWr19cPDKhgGtfXr5+U3mXTV/XsVY38U04kqwgEBMoh++6d5StCVyb0Pvq+NrJXkJbAYqUB3Xr91SaTfrgXEMJ3imSBnEpofPvEkl8/W9GsOp0MZJmMYsluvoOyrd6Z9ec4S7U7HkX5zGdpaR4qka+GAp6ApA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c862d196-ba74-4291-380d-08dd059fb3e2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3374.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 18:02:43.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcjLe5/MBzdJwxDEwoQXW8UqSjP9yuUdlRlvsJpekSFISLM6M67YWWGa/pk+q+tnWaER202l5OPj2kC9EOXzHz0GCNTEa9qhzFnVQUQdJrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_04,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150152
X-Proofpoint-ORIG-GUID: ueQJPJLpJZaQxKpp1LN0tpASyCZxmILS
X-Proofpoint-GUID: ueQJPJLpJZaQxKpp1LN0tpASyCZxmILS

On Thu, Nov 14, 2024 at 10:12:00PM +0100, Jann Horn wrote:
> Make it clearer that holding the mmap lock in read mode is not enough
> to traverse page tables, and that just having a stable VMA is not enough
> to read PTEs.
>
> Suggested-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Jann Horn <jannh@google.com>

Have some queries before we move forward so would like a little more
clarification/perhaps putting some extra meat on the bones first.

Broadly very glad you have done this however so it's just sorting details
first! :>)

> ---
> @akpm: Please don't put this in your tree before Lorenzo has replied.
>
> @Lorenzo:
> This is intended to go on top of your documentation patch.
> If you think this is a sensible change, do you prefer to squash it into
> your patch or do you prefer having akpm take this as a separate patch?
> IDK what works better...

I think a new patch is better, as I'd like the original to settle down now
and the whole point of this doc is that it's a living thing that many
people can contribute to, update, etc.

For instance, Suren is updating as part of one of his series to correct
things that he changes in that series, which is really nice.

> ---
>  Documentation/mm/process_addrs.rst | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
> index 1bf7ad010fc063d003bb857bb3b695a3eafa0b55..9bdf073d0c3ebea1707812508a309aa4a6163660 100644
> --- a/Documentation/mm/process_addrs.rst
> +++ b/Documentation/mm/process_addrs.rst
> @@ -339,6 +339,16 @@ When **installing** page table entries, the mmap or VMA lock must be held to
>  keep the VMA stable. We explore why this is in the page table locking details
>  section below.
>
> +.. warning:: Taking the mmap lock in read mode **is not sufficient** for
> +             traversing page tables; you must also ensure that a VMA exists that
> +             covers the range being accessed.

Hm, but we say later we don't need _any_ locks for traversal, and here we
say we need mmap read lock. Do you mean installing page table entries?

Or do you mean to say, that if you don't span a VMA, you must acquire a
write lock at least to preclude this?

This seems quite unclear.

I kind of didn't want to touch on the horrors of fiddling about without a
VMA, so I'd rather this very clearly say something like 'it is unusual to
manipulate page tables wihch are not spanned by a VMA, and there are
special requirements for this operation' etc. et.c otherwise this just adds
more noise and confusion I think.

> +             This ensures you can't race with concurrent page table removal
> +             which happens with the mmap lock in read mode, in regions whose
> +             VMAs are no longer present in the VMA tree.
> +
> +             (Alternatively, the mmap lock can be taken in write mode, but that
> +             is heavy-handed and almost never the right choice.)

You kind of need to expand on why that is I think!

> +
>  **Freeing** page tables is an entirely internal memory management operation and
>  has special requirements (see the page freeing section below for more details).
>
> @@ -450,6 +460,9 @@ the time of writing of this document.
>  Locking Implementation Details
>  ------------------------------
>
> +.. warning:: Locking rules for PTE-level page tables are very different from
> +             locking rules for page tables at other levels.
> +
>  Page table locking details
>  --------------------------
>
> @@ -470,8 +483,12 @@ additional locks dedicated to page tables:
>  These locks represent the minimum required to interact with each page table
>  level, but there are further requirements.
>
> -Importantly, note that on a **traversal** of page tables, no such locks are
> -taken. Whether care is taken on reading the page table entries depends on the
> +Importantly, note that on a **traversal** of page tables, sometimes no such
> +locks are taken. However, at the PTE level, at least concurrent page table
> +deletion must be prevented (using RCU) and the page table must be mapped into
> +high memory, see below.

Ugh I really do hate that we have to think about high memory. I'd like to
sort of deny it exists. But I suppose that's not an option.

As for the RCU thing, I guess this is why pte_offset_map_lock() is taking
it? Maybe worth mentioning something there or updating that 'interestingly'
block... :>)

Or am I mistaken? I wasn't aware of this requirement, is this sort of
implied by the gup_fast() IRQ disabling stuff?

Please expand :)

> +
> +Whether care is taken on reading the page table entries depends on the
>  architecture, see the section on atomicity below.
>
>  Locking rules
>
> ---
> base-commit: 1e96a63d3022403e06cdda0213c7849b05973cd5
> change-id: 20241114-vma-docs-addition1-onv3-32df4e6dffcf
>
> --
> Jann Horn <jannh@google.com>
>

Thanks for this, your input is hugely appreciated both in the review and
now this, you're a gem!

Cheers, Lorenzo

