Return-Path: <linux-kernel+bounces-301628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 965F595F365
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0512DB21117
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2173A187FFC;
	Mon, 26 Aug 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gG+zC2X8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WJtMiRXq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E431FC08
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680766; cv=fail; b=gRZbUC6YejKSb1DYTLocN0ZeprThj8Z7PsdutxnVq9sP5dF6ZzpyfmfVV/TKmx1ybDsjQ4+FT4LHC7q3sh1MWrOXk2Qesutr7QwzuB6e+isKl5//oUitcVWeGS7fOleirCSL6dvN3nP8gzifaXhP8wYM8+4d7STYi0mtcicIeag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680766; c=relaxed/simple;
	bh=9yEQtc51C6zPkK4SpLEDl1X54/TV4RpEp5f40lwt6po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tyq+k/+lENJbAZmVCpv5QiDy3548jK8sal5R0EwS/EiCaaIUX5CURgeDuvLzlC7PVITU1751B1jA+pwol472XqMP/6JnCTtwrTbONI/8Qot4KnElaAL2Hx+DnYjUcX9F7ZM+2mQQxIlmjWarJ1leBblt9Nhf0Lun2Fzco3eHRz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gG+zC2X8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WJtMiRXq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QDvr6o015425;
	Mon, 26 Aug 2024 13:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=261tchGHNXsViNE
	+4BpZl/adIViRN5dyen3gDGfb8AU=; b=gG+zC2X850PGRPSDk4Y922PA/xO+Ku3
	TIqEDWh/5pL/6Q49T2bYKr5mT0NXTz59xvAqA36RZfAw0L2m8WsxLzcbAEitH9bM
	+YEHXgu7wQRI3UDXyi5l8zO0+AbJrtnndycENU4oDyDUESEknIgUTHfAsiUoVZcH
	sMtiH8/ULv11tVE7yWCRIi6BFD4Mc2+8kdDbjKBxGN97rc3RHVJowAA0M7Bskn7P
	5+2GSYsfZCrNFGYVzc9IdPq5LdKu8F2U6ACZXwlU+cYx2VJRQ8mJPYR0c8zzv/Gf
	JzuLOjzrvjoyIy4qGpmSR46OChyuKoFOIa8zMqiJG+OS8CNBflPQLXA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177nw358a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 13:58:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QDhqMu016852;
	Mon, 26 Aug 2024 13:58:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5r18sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 13:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpmpS3l4C1u1t6nNFFH9mAi2xczG5Qw62ALOhfxQ7uunZ3/dIJ2GgHL6ardvnRqCcKa4gw8s5Ofn+x6CD5g5iA8h5Rk28bSj5Iqb2/S+gTlmv4CK1PLnKylLXxypdMTBs4nk0hTjlPyI/yc5Ww2Yq21H/kZs+zINaoENt/LYSGPFRmil/+PPPBzJpfsOpKjGeNqvjOPfy2/uNsvkeu7voQIBEWJ6RMigWzrwiZdPB6+rtzVS+MqNIGAo/Vg3alrV5zRLJ0RNVRI7baMlz9A9RytFI7ggTfWwtZzzTtB5F2tJ2iGGFCmw4xBY2kR7/5fvXn0DYyD0ZDdKUNqBx2g/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=261tchGHNXsViNE+4BpZl/adIViRN5dyen3gDGfb8AU=;
 b=Z11adTQmeopRZG4ic4xcLGvqx9pcxKRB4J+rYtDs+VjhBcH5OWFsEovzIHdE2HDOcg1mksOcs1OoeZN1KO6hTHLgCEjZ8PHndeV0yi7EniEZY6gr7fnEARcCGynHK4z7m/OfqbkZEKQrCmZDzCmOpJKuzHivqD2SO2iBykEf1Xjc0pDkKTPmn9Na2mBGQDR1FhvLU7Er9swbOoGXrrNoSG8RM7dL+ynFYojHP0dExtDqyladzE1dsiwjba4EiHzfOv4ZcZjB7wwqAxVXZ323PLdlsB0x4z3OZnlmNOQmJZHKCSQEkegYOB+VWbHcS91aBPmasveo/7yEFzb1Wvun9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=261tchGHNXsViNE+4BpZl/adIViRN5dyen3gDGfb8AU=;
 b=WJtMiRXqUHhXkJPJ4jg3RqXNweG2L78dUGx8bHXHOOc8o0CckVRmco6WhNwUjYKq/1Q0fexaAvPBzUPQ/fyco6kzfIrCp7yV7dwW4h2Zr4CaYcuh1Iz3U0xSnGwopd8+A9csNUsJ5GITVcDqmOUwOCorEtqHR1Weo0tvkSQlhDo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB5824.namprd10.prod.outlook.com (2603:10b6:806:236::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Mon, 26 Aug
 2024 13:58:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 13:58:14 +0000
Date: Mon, 26 Aug 2024 09:58:11 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bigeasy@linutronix.de
Subject: Re: [PATCH] x86/mm/pat: Support splitting of virtual memory areas
Message-ID: <5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nam Cao <namcao@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	bigeasy@linutronix.de
References: <20240825152403.3171682-1-namcao@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825152403.3171682-1-namcao@linutronix.de>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0472.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c019d1-1481-41ca-7ecb-08dcc5d720ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+hpD6Yq/Z7fhs7tyhb87LBfylXhT9sQzt7Yhe0gd2UBS5a6LRhTKw+wDZoNL?=
 =?us-ascii?Q?gWN+sbOFgxQJ0isGZiICOaK5Nwl2sKsSodaS3ndiW4rBtmk+MPgNUNec31MS?=
 =?us-ascii?Q?HagWYWya0y0x3ySeTBxNUKafMAjtlmwA7xy+tnh0OWA6Hft2ffINe8sebUxC?=
 =?us-ascii?Q?4san8DcRvGw9tzSIiqSbrY7cxZzjx0luypqa3WSRi85ompf12LilyO9yrRqH?=
 =?us-ascii?Q?Ch2drlRFaQgju7+J+KYlNaS9ACSgw6O9tPrsRfAj6p/jlyGfKeLxzLQAfvmV?=
 =?us-ascii?Q?pNDlee98wNwy1/KjI7+RI9b+Wb+3V9chNb9uJXAvG0JmU6gMNSQd32EThBCt?=
 =?us-ascii?Q?TQHJ6z6Dc6MRRjxuMuTHQX//p5B+k7260kkuZogmX73SkWBMNGKbRkWDA3T0?=
 =?us-ascii?Q?+zbALKbOJF6tZqeri/Af+fGKEZTwJLuMF2X2GbDOgvskihDibVCZmJaFTVv9?=
 =?us-ascii?Q?yW4DjZ5Mn2LGrOAOQwfkU2me0WmyVrwwA4u+/uQgfL0vvjmS3pzcxK1Bognm?=
 =?us-ascii?Q?swpRKM7RIQ6E7W6XYHOCxdrfc5hnM0Z9QEV5K8nYNSXlv42BrFIp7ryvROLG?=
 =?us-ascii?Q?6lrXOkWBtBzPVN2pfK9Or9rD3g2+81Wmv6+zLBXTIbwrqfwpwSFAl5/Af4VU?=
 =?us-ascii?Q?nfhTnRsvZoYPPyxmrHrBZZVhIGxBrqYusC2+C+HNlBsDBiPVX6R2HQfFFx/c?=
 =?us-ascii?Q?GYT+7kvEkNClyON1mJtVcYxtxiaYlllJF/Ry58V1jAv3/jfpDSjoxu2F+KTy?=
 =?us-ascii?Q?xxeKWFj2zS6+VHi8+1aAao8izTFP/f29sZXHnK/OJnMpclIFIQi7cUlnSEs5?=
 =?us-ascii?Q?/MvY37ARUK/XZj1RwyxF7PGa6t6o5wjzwxUSpxlP79w2KbXtsTxW4XOduXGp?=
 =?us-ascii?Q?wKDVtYjWZOI1V0dWP0v+TRt9LxRnEIrOw4SmxRtAy1m6WiPeLSDYy6iJWA1X?=
 =?us-ascii?Q?TWqJ51fGsWFoqaCKYU2bDsV/nCZpsz2DbWFgWxrkyr52UtL+cKuLrD3gy3TZ?=
 =?us-ascii?Q?yoSQqRfiZIc587GwLbi6bF+EwgoMWbCM6TYTJWFX1yJC33DZ9OXg3u+TWLJw?=
 =?us-ascii?Q?3r2+jIxvBU2T8FVu9TDYGBHG5PLu7xA8CI41azuIFpVeCjNzymf6l6GnREcT?=
 =?us-ascii?Q?Udlc8u/yKlzdbK2UQ7E/xiOD8xCEN8Q/TDszo7KdOJ5yicpl9YNQuWLBusnW?=
 =?us-ascii?Q?Nv2ONT78IE1mvuS07C8m0GDLDHvRAbabMUHbj5tgFiwozMZbWghqwEMdDPyr?=
 =?us-ascii?Q?EOQnlFqMSvFM+8WGwRtdopkjd4NnrEtCpegFQr/lOzvUxrdDOzUs+X82GtGc?=
 =?us-ascii?Q?fY2g/vUp7M+x0zmDGU1+w+cgOL/AI9oc9Ni7D8NT6AbXTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kX1FfkxksFV8KaX9Niz853brUNSXZrVx3iR8cySwgzwcu9mobOpzhVM9k1Mu?=
 =?us-ascii?Q?7/UbrGautx6CCoOYarUzdLN2xjNsfTitwaeMK7jMt+ZMZhABiKg615cgcvI+?=
 =?us-ascii?Q?DorDql2RoV9qGbYgEgW7TQW2wfBfO8vP4o8kKx/rHvcr1oD5MykcrX2jGDbS?=
 =?us-ascii?Q?KCI9AsF8Ra6V751KzLW5/jbI3MqGm7nDfCC8v10/U3RyBYXGWNxaRqcvwMdP?=
 =?us-ascii?Q?2FCEsdGMMiJyMRDI3ba7Iq30VqAjhxfIz1UHgobP8JjI1Kl4TBdQYp/GC3h0?=
 =?us-ascii?Q?nXaxuwwQN4FRwSucAbBPUehpsQWSxppxxy7VesK4UelYGUmn7e9sddwjzHOt?=
 =?us-ascii?Q?scK5Oc89J9VyZO/gvo6mGlgkrBospBxSe6HV8rq3RG9a5T6r+uKjQBa7db9y?=
 =?us-ascii?Q?CdzIIxQ7IngmnOLJ7bKMMpD7ylalJd6AL7S6I2Ng/rJ6paspFOcWgEDz6mgJ?=
 =?us-ascii?Q?FSQnclXiwMRv76BkOYta6OpWv5S5uj1ZnmMpgn6bkE3zB0aNXzYGHPseraGp?=
 =?us-ascii?Q?J1rm+FxnYk9L47LsCteSZXNBHOgiN2+tlMReKhb0jGEZRVaMhos1ltjkamwa?=
 =?us-ascii?Q?w20Rg0FhNgCWSoCkf4dqg4j3RatGVwvSuwQkLWJOr8bGGIKs3J6IksHPmrFr?=
 =?us-ascii?Q?A1KlAUm/LRXTx/JyWKaKgXiXK7Eju6uhpxEPF2LL7/UoPuuUQFDHu+zcsWj5?=
 =?us-ascii?Q?YNtXULorLHHrtFP5HKEsddslSFqEY70TMhtqlZbCjtt2lOUCEMkbMEAh4YQP?=
 =?us-ascii?Q?vo1EPtSKl7sMgCa0wjnNvbUV4qvHGkHaVmkDSf7NXWCyYQIunV1PN6yDhKlC?=
 =?us-ascii?Q?IcQjBNDYDAbccVn1DL3AEeDv+BFTVRl4dg/Jnc1FI8d31OK/4Z/5nHOKneoC?=
 =?us-ascii?Q?ksRpRPzZOS4WnmZ5JE281ODZoiCCg/bDG/JrVki2vWmwMD5mX9iC6hjoqkMU?=
 =?us-ascii?Q?TWwA+cvyh6v7A8tsv2yvi3Ui/U5WyPeTTH4dOcBxUr0uYCse93xwyZnFBKTl?=
 =?us-ascii?Q?gmqZRhvQsrxxAdNxtZitRCUzbf77cFgdYep1vC9bc9ShB5D0B/hx4eEakVKJ?=
 =?us-ascii?Q?cKMCir/0I9HgSCppMBIsRoO5HxpVshTLbMd+bBGJ9lDHHO5obYDfz77rJzST?=
 =?us-ascii?Q?UhABoq20z+auGp8ebQI0awPNb4n7TmxXFrRh2oTZjE0b84NOyGBSfLoVhfne?=
 =?us-ascii?Q?IExxnUa9za7l2SSYDteUjsPMsJN3xZJ8oS1dV6ATBAlN+3CvQwpNaoTDuY4G?=
 =?us-ascii?Q?rq/qZq/TnQhAQ4B+WAqdz5csfbz4Zq9O5E4EVnBkOFSFqmiSbagg8M4WJ++e?=
 =?us-ascii?Q?Z9sUAxjCd3yrkoJpgRc6mCWsmwIk+jUqKWZKzzKO8zW19GQHzn4wMFNe5QCZ?=
 =?us-ascii?Q?iTjVf7VYz0NM0y3gHSx92l8QfuJbgySWP5gOanQhFrdlhEOzlIAaC/zsTf7W?=
 =?us-ascii?Q?nDWjp+VvjsUtvnuFlXc7G1rY3826VTJF4RQraHyejDVhVFjx4wGAloijiGgF?=
 =?us-ascii?Q?NTyR45N0BVXpvEKAbjq0obHBr//r4yWVhsShusIifSziLfFqq9pb2vB5KsNd?=
 =?us-ascii?Q?uNHG1NKiExRx1IFyJuS+UEVeo4wBvWmqhcnJugdw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	adWKPLkbNO4m8kMrize+Clr4q2g1V8m8wR/sKPNRp/o9dYd4DHiCX0Mnes3Zqq3Csb/tfPxxlteAehphN3rhy0o19XXR3zPoIzhGyK1jtqPbBdgS59sjKpeoq+eorNXu0L1Q19bACoNYDHivQhf7guyJwVHTCT2fZnVM0NWQW+kAxdMQ+eT47CcK5vTds1b+QJm2vIdNTkbp5t2xQTL6fDGrLTLKuZSPmcX3f5RUAW1BmXA4gBrKISXwQymAEid0c55p+flpj6yhfaGl1dsOE9mWGBJrEpDIgWe/4xIPIWoj5Prhryj0BE9OJJ3PAKHqBjILuBSCw3xrVIj+B86wKLBoYp6RnAGvLBB2I9CRtKT6zgNNSIsVZloLtr4WZtJkxMEmRHGJILP+zmHHwR8qWJZweUuiJLJG1/WycZp6WSHcUWJ8XlgLMTrf5RxlUsnGF6qa1wqfNrISQbrFFJai9tSitb9uPqjzP2xdnWUdMQi3ciFq6wFBGl0s7fd2aX+c78R5nThbxdaezdfsWXoTqMPGjqbdaU8Gi4ZgaXsyeQV7iAfYqur5BqHDZjE9xXHPFm4eALmSwG3pVqQB4mkn3Qklvi1RagdlaWAci3xeAmE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c019d1-1481-41ca-7ecb-08dcc5d720ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 13:58:14.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCA/HpVqpxg+RWbJbtbczPlHj8BTf+8go0QhqWvGf0HQCF32wdZihvhXjrqVCdcskaNJ+f1wXRu0ytxL4Wk2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_10,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260108
X-Proofpoint-GUID: LhpRwL4vLlHbp2eJjHT8EpQzcoBnu_C7
X-Proofpoint-ORIG-GUID: LhpRwL4vLlHbp2eJjHT8EpQzcoBnu_C7

* Nam Cao <namcao@linutronix.de> [240825 11:29]:
> When a virtual memory area (VMA) gets splitted, memtype_rbroot's entries
> are not updated. This causes confusion later on when the VMAs get
> un-mapped, because the address ranges of the splitted VMAs do not match the
> address range of the initial VMA.
> 
> For example, if user does:
> 
> 	fd = open("/some/pci/bar", O_RDWR);
> 	addr = mmap(0, 8192, PROT_READ, MAP_SHARED, fd, 0);
> 	mprotect(addr, 4096, PROT_READ | PROT_WRITE);
> 	munmap(p, 8192);
> 
> with the physical address starting from 0xfd000000, the range
> (0xfd000000-0xfd002000) would be tracked with the mmap() call.
> 
> After mprotect(), the initial range gets splitted into
> (0xfd000000-0xfd001000) and (0xfd001000-0xfd002000).
> 
> Then, at munmap(), the first range does not match any entry in
> memtype_rbroot, and a message is seen in dmesg:
> 
>     x86/PAT: test:177 freeing invalid memtype [mem 0xfd000000-0xfd000fff]
> 
> The second range still matches by accident, because matching only the end
> address is acceptable (to handle shrinking VMA, added by 2039e6acaf94
> (x86/mm/pat: Change free_memtype() to support shrinking case)).

Does this need a fixes tag?

> 
> Make sure VMA splitting is handled properly, by splitting the entries in
> memtype_rbroot.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  arch/x86/mm/pat/memtype.c          | 59 ++++++++++++++++++++++++++++++
>  arch/x86/mm/pat/memtype.h          |  3 ++
>  arch/x86/mm/pat/memtype_interval.c | 22 +++++++++++
>  include/linux/pgtable.h            |  6 +++
>  mm/mmap.c                          |  8 ++++
>  5 files changed, 98 insertions(+)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index bdc2a240c2aa..b60019478a76 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -935,6 +935,46 @@ static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
>  	return 0;
>  }
>  
> +static int split_pfn_range(u64 start, u64 end, u64 addr)
> +{
> +	struct memtype *entry_new;
> +	int is_range_ram, ret;
> +
> +	if (!pat_enabled())
> +		return 0;
> +
> +	start = sanitize_phys(start);
> +	end = sanitize_phys(end - 1) + 1;
> +
> +	/* Low ISA region is not tracked, it is always mapped WB */
> +	if (x86_platform.is_untracked_pat_range(start, end))
> +		return 0;
> +
> +	is_range_ram = pat_pagerange_is_ram(start, end);
> +	if (is_range_ram == 1)
> +		return 0;
> +
> +	if (is_range_ram < 0)
> +		return -EINVAL;
> +
> +	entry_new = kmalloc(sizeof(*entry_new), GFP_KERNEL);
> +	if (!entry_new)
> +		return -ENOMEM;
> +
> +	spin_lock(&memtype_lock);
> +	ret = memtype_split(start, end, addr, entry_new);
> +	spin_unlock(&memtype_lock);
> +
> +	if (ret) {
> +		pr_err("x86/PAT: %s:%d splitting invalid memtype [mem %#010Lx-%#010Lx]\n",
> +			current->comm, current->pid, start, end - 1);
> +		kfree(entry_new);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Internal interface to free a range of physical memory.
>   * Frees non RAM regions only.
> @@ -1072,6 +1112,25 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>  	return 0;
>  }
>  
> +int track_pfn_split(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	unsigned long vma_size = vma->vm_end - vma->vm_start;
> +	resource_size_t start_paddr, split_paddr;
> +	int ret;
> +
> +	if (vma->vm_flags & VM_PAT) {
> +		ret = get_pat_info(vma, &start_paddr, NULL);
> +		if (ret)
> +			return ret;
> +
> +		split_paddr = start_paddr + addr - vma->vm_start;
> +
> +		return split_pfn_range(start_paddr, start_paddr + vma_size, split_paddr);
> +	}
> +
> +	return 0;
> +}
> +
>  void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
>  {
>  	enum page_cache_mode pcm;
> diff --git a/arch/x86/mm/pat/memtype.h b/arch/x86/mm/pat/memtype.h
> index cacecdbceb55..e01dc2018ab6 100644
> --- a/arch/x86/mm/pat/memtype.h
> +++ b/arch/x86/mm/pat/memtype.h
> @@ -31,6 +31,7 @@ static inline char *cattr_name(enum page_cache_mode pcm)
>  #ifdef CONFIG_X86_PAT
>  extern int memtype_check_insert(struct memtype *entry_new,
>  				enum page_cache_mode *new_type);
> +extern int memtype_split(u64 start, u64 end, u64 addr, struct memtype *entry_new);

I think we are dropping unnecessary externs now.

>  extern struct memtype *memtype_erase(u64 start, u64 end);
>  extern struct memtype *memtype_lookup(u64 addr);
>  extern int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos);
> @@ -38,6 +39,8 @@ extern int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos);
>  static inline int memtype_check_insert(struct memtype *entry_new,
>  				       enum page_cache_mode *new_type)
>  { return 0; }
> +static inline int memtype_split(u64 start, u64 end, u64 addr, struct memtype *entry_new)
> +{ return 0; }
>  static inline struct memtype *memtype_erase(u64 start, u64 end)
>  { return NULL; }
>  static inline struct memtype *memtype_lookup(u64 addr)
> diff --git a/arch/x86/mm/pat/memtype_interval.c b/arch/x86/mm/pat/memtype_interval.c
> index 645613d59942..c75d9ee6b72f 100644
> --- a/arch/x86/mm/pat/memtype_interval.c
> +++ b/arch/x86/mm/pat/memtype_interval.c
> @@ -128,6 +128,28 @@ int memtype_check_insert(struct memtype *entry_new, enum page_cache_mode *ret_ty
>  	return 0;
>  }
>  
> +int memtype_split(u64 start, u64 end, u64 addr, struct memtype *entry_new)
> +{
> +	struct memtype *entry_old;
> +
> +	entry_old = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
> +	if (!entry_old)
> +		return -EINVAL;
> +
> +	interval_remove(entry_old, &memtype_rbroot);
> +
> +	entry_new->start = addr;
> +	entry_new->end	 = entry_old->end;
> +	entry_new->type	 = entry_old->type;
> +
> +	entry_old->end = addr;
> +
> +	interval_insert(entry_old, &memtype_rbroot);
> +	interval_insert(entry_new, &memtype_rbroot);
> +
> +	return 0;
> +}
> +
>  struct memtype *memtype_erase(u64 start, u64 end)
>  {
>  	struct memtype *entry_old;
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 2a6a3cccfc36..8bfc8d0f5dd2 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1502,6 +1502,11 @@ static inline int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>  	return 0;
>  }
>  
> +static inline int track_pfn_split(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	return 0;
> +}
> +
>  /*
>   * track_pfn_insert is called when a _new_ single pfn is established
>   * by vmf_insert_pfn().
> @@ -1542,6 +1547,7 @@ static inline void untrack_pfn_clear(struct vm_area_struct *vma)
>  extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>  			   unsigned long pfn, unsigned long addr,
>  			   unsigned long size);
> +extern int track_pfn_split(struct vm_area_struct *vma, unsigned long addr);

Same extern comment here.

>  extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
>  			     pfn_t pfn);
>  extern int track_pfn_copy(struct vm_area_struct *vma);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0dfc85b209b..64067ddb8382 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2486,6 +2486,12 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (err)
>  		goto out_free_mpol;
>  
> +	if (unlikely(vma->vm_flags & VM_PFNMAP)) {

It is also a bit odd that you check VM_PFNMAP() here, then call a
function to check another flag?

> +		err = track_pfn_split(vma, addr);
> +		if (err)
> +			goto out_vma_unlink;
> +	}
> +

I don't think the __split_vma() location is the best place to put this.
Can this be done through the vm_ops->may_split() that is called above?

This is arch independent code that now has an x86 specific check, and
I'd like to keep __split_vma() out of the flag checking.  The only error
after the vm_ops check is ENOMEM (without any extra GFP restrictions on
the allocations), you don't need the new vma, and use the same arguments
passed to vm_ops->may_split().


>  	if (new->vm_file)
>  		get_file(new->vm_file);
>  
> @@ -2515,6 +2521,8 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		vma_next(vmi);
>  	return 0;
>  
> +out_vma_unlink:
> +	unlink_anon_vmas(vma);
>  out_free_mpol:
>  	mpol_put(vma_policy(new));
>  out_free_vmi:
> -- 
> 2.39.2
> 

