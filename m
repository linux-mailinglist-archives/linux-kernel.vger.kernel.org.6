Return-Path: <linux-kernel+bounces-374079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D54909A62A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482C6B23A78
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C281E47DD;
	Mon, 21 Oct 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FrGdJ9RF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BSapyodH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755B1E4113
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505992; cv=fail; b=GE/749IO7pyM9in3ChbyT5u9TkuKMvoGQyiQP0NFe6AWzT6VGXPnzqphmVHj63ovNYbl4H/4QVblQFW24v8W/D63bH9NP2MZZqW3KHftzafTe/hqI3PGhXg5ZWS7PtTxvFd2qU2q5J6uLLHN3KmRxMktMhBUsKO6VoqvzDfMc4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505992; c=relaxed/simple;
	bh=VULZfyJw3kkojdIhTqZUAswNTN32sLAIKH0EXzfSvh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ueNlE4E2+mvH/HMvUh+WI8bW9fwQPy2ji3X6+ZYwy469zXjhRKfKDOoawnEdQm/n5Owy7NkdaunUBxjk6Iu2+O3LfwBZnggNKH3wyIQqxDkiZtnwIcIEN7e7TjxzRf4xD/Pq+Gos3xPX6+Gu18OjJGugQaBfWaWWHNLsLmPEMfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FrGdJ9RF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BSapyodH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96bwr015867;
	Mon, 21 Oct 2024 10:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kepkPGG9xNT8IHJnE3
	RrYiRwWKWt8tdvusm5wUBM7nU=; b=FrGdJ9RFslr2FV8d7BkYKnWJYf+bGhzqWD
	eD9AC/dKiFZbWqADR0Py3xuC/ksY+AOViZjgjSH2A16HE1IADu40LgyFDc2jdgoc
	DcLL8dhvOC0x+WeKG1zpUt1loLdicQBIZnexH5zM5vkrZEkr6FXdMn1ChVqfhUcT
	vkxk7gsdOr/W1yHBOH4uVNFPqJGlf1W226OtdlZYbq+W3OmV1HrNQ9WWSaOnSBBq
	3N1GLY43fR8v0Q2u24kkzZS8B8GA5u802tO31kkdM059M5d78fbxKpuv3QX0mTcQ
	y95zezbcqlZuiQwQQEzIEjOzYTUIWTYrBzrqFUc3Nox03W+/13/Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asar8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 10:19:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49L9U7uF035251;
	Mon, 21 Oct 2024 10:19:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376vke9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 10:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Spy8qy4buzeh7Vo2nIMiWbSNSw6LIKc8akcag61y5giuvTSKvEN47TTLoAGQdcPL4+y3hnc4VLa60aMRhOjEYnJwL83AARdcItgyCAf8uCQwICs+hpYRss8qTaka9BpkogYOFPZmU/Vy36XwHkcyuBityOU1gR/NP3KugIduR9qOwrtzpXH/Nd4MYdBgOzE7veCPMX2LS80z3sC086y02DdpYHDKWUGAEFYADfFtdLQXI76BM2z4U8fIMaXO9qibqipNVgoxW3Znk5yDnDCzC0l42bxjWK0XBqXT64GPMLVIwH7xDf9Ot6939Wb07vDNHTqv/+vnkvWUqZWk8xd9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kepkPGG9xNT8IHJnE3RrYiRwWKWt8tdvusm5wUBM7nU=;
 b=sHXfdcmj8H1cUwNYoR8bkq6IXjPehSGZCAfRO1IDI/7DeKGNPNUY2OeCvcplyfsAn99zvXqE0aWFmum98EtFUyZd3SimGJcLsCLW5plHrUAveqT6zxEV7ebJSsPP6dyLnDBTeF2n/vjzCrhGMmlkccgLM38Wskfway9Qnuly5Bq291A/1ojd7BeHD1wNPWl6l+Gm1alPp6TL79FXA4N4Nv5tytkzKL/W0n2JI/mnSJt81iAqon/AIIxt57uFsFX6EYpPwr2WuTzs8zZpBz7uHTWgdhoyUBa2U2p7vJxskSS5wU4g6wJm2HDxqFS6L6r9hHmeKRNkZ5z6ebatUicOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kepkPGG9xNT8IHJnE3RrYiRwWKWt8tdvusm5wUBM7nU=;
 b=BSapyodHBvLF8vUKOoobyig7/fdmI7VEpSH/XEEIE0wMoDrv5jLntCMySwUIj7fKuS1WN8h1ovz0nhS+xe7cDTN5xwlETF/VLCFEvFxy5erLmvgIZovqW4WHUydUyAAz5vtDzhzWlLD3fAq1+9vMfhEIUUmrBqIQuIIMEL+6skE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6297.namprd10.prod.outlook.com (2603:10b6:303:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 21 Oct
 2024 10:19:22 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 10:19:22 +0000
Date: Mon, 21 Oct 2024 11:19:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>
Subject: Re: [PATCH v2 2/2] mm/mremap: Remove goto from mremap_to()
Message-ID: <adf4dbf0-f697-4467-8ccb-d35d4a67fb8d@lucifer.local>
References: <20241018174114.2871880-1-Liam.Howlett@oracle.com>
 <20241018174114.2871880-3-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018174114.2871880-3-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO2P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::25) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed92b04-452b-4dd2-e468-08dcf1b9d50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dqey0/ZnjvUU0g8HWZzsTL1TOOj2hmegAQ1i5Bzek+PLGh9YSLzSlbC2/MPx?=
 =?us-ascii?Q?2qveK7nBOe5iuBv9CaBvXTO91Mo0tCLMiUuf2hm6saF/KibPr3/QhFgGxHoP?=
 =?us-ascii?Q?wpUeUOpNYe8bmwnltg01Al/Nmzp9YvU7a+99r3yopsk6LcKM7xipz9NIF8tn?=
 =?us-ascii?Q?r99hkCooQxYBbnue9eTxtDzTtNEKeGVUfCvaJJAuUCpYUgxqKiqiTjGlHYOK?=
 =?us-ascii?Q?T9+I8Dl0f2S8VhZUue5kj88aMQeEDGyIHQCKwEht6RupkoJz/YqKw+hvrQuo?=
 =?us-ascii?Q?UIxuit+bBw5mpyIz4ZwtI7wA0Bya4JfEo4wu31Zhi8JCaBBgfU5nS/wNpIJs?=
 =?us-ascii?Q?0VsiqFr33eRjO/5BOC7NWvhUKch5SAj2+pyowFIrw3xUPQZcdP/sj73pXdrQ?=
 =?us-ascii?Q?VbeJyg6aRuLMmdBHUP3OMPiqccPlCdfK8lc+wyNYUFRvBidcYcj8t6J+txpv?=
 =?us-ascii?Q?wJLyvVA3uF66kHnAZz62Mnxu91NqvVR5i8UzAmn04o/t1WF9F2Rx1GLu/H20?=
 =?us-ascii?Q?tItZwRUs6Xo4HxuA3YLNyAOxoZqOTP65YCsdzFztn9Wmfm/0tsv62K0xGbcv?=
 =?us-ascii?Q?Crhnht/d7DajsSgH8uz7s08r3OETVt8b8244hl9gt/YRzNuMf4vhMUkRJf0k?=
 =?us-ascii?Q?hywTT/QOcwSZR8UP2mf2jJt6uppq1VOfblccHZ00nNNwY1LF6dGq5kMAageq?=
 =?us-ascii?Q?JphsPViHLFqQcLj+Z+z4scRxydDvZbJrXWlFpNq6vQhiomPxJuEdPvfCcHxM?=
 =?us-ascii?Q?Ly3hVo9+uuLhcwxcqt+lK/KpRE2ZS+p4s8rfbwBnCaH8tD141ZFRRJYbJG4b?=
 =?us-ascii?Q?eBV1BSAgc0UkKwcHCRMpfGjsIXHlIr5EA+a4aqv19fQSpWJcrk3TZ+EcimHW?=
 =?us-ascii?Q?5nYG4sO8jlQmdK/2z5puMjWwGbTJE/Uq4nC1x6gQVSFfBlLCou0vsSTr9hlX?=
 =?us-ascii?Q?9C7dWw13f0bNtlFwOvKmujTEprlLPLIbTfu0cvWqvgArsQ+rmmRmh6Mn+XFc?=
 =?us-ascii?Q?ijvlpvOv+yCvp0zTIulT7FCpfS5YV3+EoMcoKmzFM3M+74fIMj3+YSZeFwcI?=
 =?us-ascii?Q?X07nJygeK0e1Hex4Lix9MefJHlLenSiri0Hj4jWHgU7Bx9vCgIl9o1S5WJYl?=
 =?us-ascii?Q?IUs4exWy/fmP2xeM3C/BOHH7b3n2wxtl/AwizRUhfsPBxgXi0Q5eywPIcGXA?=
 =?us-ascii?Q?EdxdwK2SP7uxYzdUXr9cOMEQdKYWHUbSyyGKLW0SW9xEgaWbBsDEds+A4IxS?=
 =?us-ascii?Q?L2ubevBAVTyOBcIaqWqxrE+90PrTCIgWRrWkhSC4INAyWYpX0YLzEcMT/jMm?=
 =?us-ascii?Q?WvYo7UOzWAqH99ciGGogOslg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MvxmUc98CR+Z9mrgNTdMqn5zqSA1hzfL61f8udelcbZVFUKPO6uDvEEf6q0v?=
 =?us-ascii?Q?0Ll+bpnGp6fO7G6dwj89UR62xcvh9oj+DPv+OMQL4rjFeh1ZbGn82sWGQTn2?=
 =?us-ascii?Q?mQ3e9+VSJgXoStsdjFfPr7zktgY/9WkA3UuMtUS298FRBGiQgDPHZJ1py/rY?=
 =?us-ascii?Q?fFtokY66MnaJBd+pm4o7viri99Vzq/eyB+mcAg1khJ93H27a0pguUTOpoPxB?=
 =?us-ascii?Q?Zjks8jROAszyzFpZH76DKs/a4vLanGl1DnDfP/C8qnWVsX0imnfBFXeO7znJ?=
 =?us-ascii?Q?F5wdjBSOMHs6Gh0eCNLWSkGQoVDGqMGgTqXXPntCL69t/H+A1qqv9EuezzZ3?=
 =?us-ascii?Q?VB4WQe54E5WRTkgc3RCB8JLkxjYTRuomZEBbCDF/RmvoH4XmGpgfEe7XnTh0?=
 =?us-ascii?Q?aMWcGt9VUmpqEKIAwMAdDtQ1m3IRpaE5DnasgrBOYVjhf9pHgK0t8CM+UBPd?=
 =?us-ascii?Q?dZp1qRQwpfjGddCYlZE1lQ6P9ROx83b7VBtf+NzCAcIUMT/h4vO2c4Fl5eAW?=
 =?us-ascii?Q?671cl5LlxpeXIInYjKgDAjkIK+rocTv6PhprgcXOv5bX2gJJxmXssuLhFxt8?=
 =?us-ascii?Q?nFm3KcBIp2GZiVBvXfMZy3kcDytV0zur5GSzCnVefaxRjEmphc7tp4Cnniby?=
 =?us-ascii?Q?1Iocw0quBtNjPa5igBKZeuBBJiySPBG0yEeRTRrtUWLl8fSnkh4CYr4nB4Xx?=
 =?us-ascii?Q?FkHZ3lpWSBhwSpMv4KNbTgpaAAgY3kptfdX6K2x35cFgUtiL0ynLu0zquPwo?=
 =?us-ascii?Q?cfWLwUDnYMkgaRoteuJn+FJdBIxQ/T1f15L7kpbvDyMZ6goLgn1bTZt7/5YK?=
 =?us-ascii?Q?Q2hUz52nHxCvmvp8uChb8FZEWI/4ES5dh8tY0+lE4NAfzS+d1ivJzS+R/uyh?=
 =?us-ascii?Q?EK2LBt/fvOZBXpGsQwyi8LdH13g8JH9DxyGfP7XtWnpJets/XwbpWH2060wN?=
 =?us-ascii?Q?xopMMmW+R+3s/K7VWGPHz7zHpwDqzL1zfUmhXNppO2pelavQuAyT2l4HJzve?=
 =?us-ascii?Q?vcyp3wssngkahchX08ODcwSTw6/buK5OORqA5bGaUqJ9s9A33MFp4jFEIluu?=
 =?us-ascii?Q?7hoD4GHRHyF2GiT610ZQasqtUiy66oep8EAeL9XVeaVAANKD15P2lrxnyXhQ?=
 =?us-ascii?Q?NbT38dC7jTr9IK5V809GUkKIrnYQgY9JRlb6Riivr8qjh5BdgRmJC3v9QKOf?=
 =?us-ascii?Q?h0G8Sz5Mb6ZebsBG59Aun2DmkXRpKwoKvH0K5te7K2j/jZH6N6zGh5eRDTEd?=
 =?us-ascii?Q?+E4lf6sltJQjS11JBsXQHmXYQlY8kmry7c/nFwXqJ9TfEkE6fWaY8xuuKs1h?=
 =?us-ascii?Q?vCpejVbLL5sIL60l+CM2AM8TJb5u1Ih003YAHSVGP0j8YNDUNIfc7bogdlfa?=
 =?us-ascii?Q?MaKjqVNxZiCAMIip1+QpBs9Wt+2Lc0Sl055cMrZfMrEJ3Y+ghKYpt3kNzeiP?=
 =?us-ascii?Q?F0Ft6m4TYU5TO99M6ULP0erDncMiHu+HowpDGox2hSF11APsvLXyEkQiqskf?=
 =?us-ascii?Q?JcwmfmtRVHRpbFABea/ScyI6MvaClj6CyzqyP89vavqPYFQLrVbtBQyqe/58?=
 =?us-ascii?Q?t1VNB5lbQ0CW3k7coyAnszvl7FXKzAaiWBMfkE4vrtuXNiejOb7RlCIi6v3i?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I5QLGp0QVoOiB82Y5kUhOZrNqKLkp3PUdNgYP+sL8mTsVmkKKd9ynlG3IugNU6A0ejPfqVn9+MVJpW4pC+ZafhXDl4iFBhIWsdDTWIBlWXK60kNflUWO+WHqHldMstfrmOHDSnA0lFPvTsQbrz22LwMLd2BrUjYqPdOlaKADxSrcjtqGr0M2DvUz0gzi0JYBDHEWW+YHB5v8Ikls/mnXaZX+OYXWslO+g+6DJfywvNogCDFrpIxNWaOHJ6OASNianuYdSPkmTlmb8/kRW78oCmED+2og0TaBoySEMl5uJnv2TdXJY/XLCgSuP8GWKSuKWAILpwKcvUbfpfExDS8ABjarO0CgwIDch+bWoBJCib82eHG+r4Nz8tRKGZGdSws4bR4HkgV1DkXQubHhSmQHbgvP5Z+8uVSZy8/5W0WxnlBZ8EHTI/d65dxL2BRT/iNvWPDd15uN02cvOQOQgnQ8H/Map2M1FtcqkVHG0VnVVBSKMqcv+Z+BuTuCyepP5FcWECmr6jTWC7eoxFAcZ2iXu0Eb0lf0/d8LuxXzc1se7kQVBY+Q2G8P4IelzyqwJQLk2CoLb7Z6Goh3/4XnRx5K3Vf+dPg4pEsTyo9IHEe+zZo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed92b04-452b-4dd2-e468-08dcf1b9d50b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:19:22.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiHE67hM+zjePcgr7sWk0mLHpzirnSLuyvRzhLQVmKCDJNAPBnxCjuF3IbKwesQdTCs6OppRwtGDgBuxyC2+REaDfVKoVIzdtbz2WxOl7k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_06,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210074
X-Proofpoint-GUID: ws4DiknRoo89gkh2h9m9P-DuHgHQLiFQ
X-Proofpoint-ORIG-GUID: ws4DiknRoo89gkh2h9m9P-DuHgHQLiFQ

On Fri, Oct 18, 2024 at 01:41:14PM -0400, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> mremap_to() has a goto label at the end that doesn't unwind anything.
> Removing the label makes the code cleaner.
>
> This commit also adds documentation on the function.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

This is a nice cleanup, thanks!

Other than nits below, LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mremap.c | 46 +++++++++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e781ec4573ca..4c79ab92eb8f 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -887,6 +887,20 @@ static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
>  	return 0;
>  }
>
> +/*
> + * mremap_to() - remap a vma to a new location
> + * @addr: The old address
> + * @old_len: The old size
> + * @new_addr: The target address
> + * @new_len: The new size
> + * @locked: If the returned vma is locked (VM_LOCKED)
> + * @flags: the mremap flags
> + * @uf: The mremap userfaultfd context
> + * @uf_unmap_early: The userfaultfd unmap early context
> + * @uf_unmap: The userfaultfd unmap context

Nit - these are lists of userfaultfd_unmap_ctx rather than contexts. But I
mean, the naming around this is generally not great and not your fault so
not a big deal.

> + *
> + * Returns: The new address of the vma or an error.
> + */
>  static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  		unsigned long new_addr, unsigned long new_len, bool *locked,
>  		unsigned long flags, struct vm_userfaultfd_ctx *uf,
> @@ -895,18 +909,18 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
> -	unsigned long ret = -EINVAL;
> +	unsigned long ret;
>  	unsigned long map_flags = 0;
>
>  	if (offset_in_page(new_addr))
> -		goto out;
> +		return -EINVAL;
>
>  	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> -		goto out;
> +		return -EINVAL;
>
>  	/* Ensure the old/new locations do not overlap */
>  	if (addr + old_len > new_addr && new_addr + new_len > addr)
> -		goto out;
> +		return -EINVAL;
>
>  	/*
>  	 * move_vma() need us to stay 4 maps below the threshold, otherwise
> @@ -933,31 +947,28 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  		 */
>  		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
>  		if (ret)
> -			goto out;
> +			return ret;
>  	}
>
>  	if (old_len > new_len) {
>  		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
>  		if (ret)
> -			goto out;
> +			return ret;
>  		old_len = new_len;
>  	}
>
>  	vma = vma_lookup(mm, addr);
> -	if (!vma) {
> -		ret = -EFAULT;
> -		goto out;
> -	}
> +	if (!vma)
> +		return -EFAULT;
>
>  	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
>  	if (ret)
> -		goto out;
> +		return ret;
>
>  	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
>  	if (flags & MREMAP_DONTUNMAP &&
>  		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
> -		ret = -ENOMEM;
> -		goto out;
> +		return -ENOMEM;
>  	}
>
>  	if (flags & MREMAP_FIXED)
> @@ -970,17 +981,14 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  				((addr - vma->vm_start) >> PAGE_SHIFT),
>  				map_flags);

Unrelated to your change, but I'm really confused as to why we're doing
this even if MREMAP_FIXED might be set, then ignore its return value if it
is set?

Would be way nicer to do something like:

	if (!(flags & MREMAP_FIXED)) {
		new_addr = get_unmapped_area(vma->vm_file, new_addr, new_len,
					vma->vm_pgoff +
					((addr - vma->vm_start) >> PAGE_SHIFT),
					map_flags);
		if (IS_ERR_VALUE(new_addr))
			return new_addr;
	}

Anyway one for another series.

I'd say the 'ret' variable is badly named now, but it was badly named
before so there's zero delta on that.

>  	if (IS_ERR_VALUE(ret))
> -		goto out;
> +		return ret;
>
>  	/* We got a new mapping */
>  	if (!(flags & MREMAP_FIXED))
>  		new_addr = ret;
>
> -	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf,
> -		       uf_unmap);
> -
> -out:
> -	return ret;
> +	return move_vma(vma, addr, old_len, new_len, new_addr, locked, flags,
> +			uf, uf_unmap);
>  }
>
>  static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
> --
> 2.43.0
>

