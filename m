Return-Path: <linux-kernel+bounces-394883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7698C9BB54B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688331C21916
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B9B1B983E;
	Mon,  4 Nov 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IO4sKDAt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MVIqYcB+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DF41B392A;
	Mon,  4 Nov 2024 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725382; cv=fail; b=S2GBgq0YE5XR6l6bXaR8g69Qsxyuk0LyBZazJkUjrdAX/frYHtQDWZN7etYfCNOk+h2TVf/l6f8KIsQPczOzQNjFRUalB88vgtUWRSQ+RCLNDj8BXWPgQbocnUlZdY4lI9C4X+WiaWsexcfZDz6sQdccW+0QrCxkvBwxarjuIZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725382; c=relaxed/simple;
	bh=cdCxzNQhNn7NbLUfhB5ee1TjTNhQyI0+EEq8gtIib1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tMJzP8u2kIXgh47IKSqa96RetdTL/k6R1VlAmaky6yxRU3DZyFQ3XDDvozeZzdlBZMFEoEtZsMWSV9yH+kWdLDUHzg0LQP/XpxovS3QsQN+igCkpcHdjwi+WhCxkzDIZJMZ2JFKUkMUMLjCgiHLMOW9t0rO2lv+CFtnWXZerqYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IO4sKDAt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MVIqYcB+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BjTTb024053;
	Mon, 4 Nov 2024 13:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TaR4FgmY8v80G4JQiA
	WmRM3Dhm/9N6iZYt+WrIj4UNU=; b=IO4sKDAtzmNJ1O/oHpEAPQPmpvzC/0Vff0
	bTnySyxrXjFHq+olXdES3ebqaUPLW1/D1IIm5dHGHxk93+fZLidDT8Gn3gkifC9T
	It8fAKVIrOlttiA8BUHWwmFB82ttP+C1ooGPGxn6QGsKsf5oBP7ryYqRExXs7cP9
	YoDS7VtW8bg30iXUracfB3lp/WcpZ/34LdhS+GoAVbilY9G/DV5rNZfI4YBdagKQ
	YrRgz0TdCSxR3ad0I1gLtbZDT/TjAT+7DCw3P5l1yTTx0vxL2meJUnzyr1SxL343
	C9JafXkz8dKMBHtPi+VuaF8j2F6GMMZBECL8tKSEvc2Q2DfCMt5g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nav22mw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 13:02:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4C9oL6008882;
	Mon, 4 Nov 2024 13:02:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahbytra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 13:02:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L05PQAB9Ko03wXn1g89Bw11AANNhDv8hBmCmU3jhHukDWNBUHebhF49W8YhP6Q/twFh7HayxISpEVsOgF1hJjQAe1JG1ZhUuTSlfux0lvbXAo1Np3ZwLPMj/3WMCsdz2hzJ+zBreGJO2U6iQvOP3NlaJi+v/6FHD23cAZCuXQIXsB2ikuxHLMivV4sojPovlJXutlrArwEGCQbbdHtovK6Y/sjA30r2HVQDeMLCG3rD2hOfCUlCq/Iv3kqi2eNSYj9NuA7t81jd0gkuRH/uRZbjAurnH2N3XhQvltrqsABIsCibteEHFP6uuF/2CRtU266Om9JC6sWFkzpVBmyn8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaR4FgmY8v80G4JQiAWmRM3Dhm/9N6iZYt+WrIj4UNU=;
 b=bA+JZR6QTsyDprQHPntH9/4H1ibshxh4FlupXAbKc1ZxMcvp4diDD3F1aQY+R62+MTfaSYu/ZAFUm4HtBVouqYf6u1IvhfAY9TRm8rvOmeUAaZS86W5QJNkM36DbzIxGSF4bsGVCB71lg5j2gVKavzXbVS+GbIeZyeN/HB3Z+005dS7zOmSqm/XJaPtqokHkgLiNgKbnXSwk3sxPWVcr+1gHRfICuwjYCcBSxKT2pnjVwCRLMmhcyVACbCecAuH9F/p/kDgwy8p+mL0Vd/3aSB86LRHPHWYNSXZ2VW0j33wPUTXGbsFh1jhgCQepE+cdSBgOjmsDq5HjqL+wF2QB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaR4FgmY8v80G4JQiAWmRM3Dhm/9N6iZYt+WrIj4UNU=;
 b=MVIqYcB+RYjUJQhuWxe85DzuXnussv0UXAPWgcOJc0nGU4KxHdyVr4zSz1BSxLwwvyNXohtttD7Gvwkuu/NRq9hjBbBQBoXNmKjYE9EkwBhKrzgpnd0uC0ZTxI4lZegfN15kU1bS9uG4sHAO6g+nPN+waGtKNIy3v6G1uPpUu/4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:136::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 13:02:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 13:02:24 +0000
Date: Mon, 4 Nov 2024 13:02:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <b5fcdae7-8918-451c-ab7a-de7136e5dbe3@lucifer.local>
References: <8e02f3a4-d498-401d-aaba-e53ed2ac6a3a@lucifer.local>
 <20241101234832.56873-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101234832.56873-1-sj@kernel.org>
X-ClientProxiedBy: LO2P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::31) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: b56d53e6-c4a2-46f5-3b15-08dcfcd0ed31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bjg5lRmmFBydi+luCjmiG3Xkr62Al/3uQw0u6CcVclu9bB1SW0yW1PhAuzES?=
 =?us-ascii?Q?+9ZmDw5ulrAMa/EJsYD11w+UG9qsE8KNz7CWIts0ZyIhAiOCzFevEGA2cue1?=
 =?us-ascii?Q?bs8UAkp+qla3CxT9Fu4WPQUi9VeLFMD7uTLL1qvRIAEFxUg8RDnUYGmmfrzr?=
 =?us-ascii?Q?+ziqhighQXFNziboCzKW+otFV2CuxqVtIOK4oHp79kvj15nXP1Blg8mA5ZbD?=
 =?us-ascii?Q?pxt9347cFR8EWUPNVLBUiXSmUDcswo1RyBXRPBhhuWZS2FpL26ge9bfAbl9f?=
 =?us-ascii?Q?6ExaGqqAIah7n2J3ppZu0JQ3NP/kP4Clysk9GSs+smd8wWFgX1r6ASZbGTe8?=
 =?us-ascii?Q?h9F8DeIJeWrvenVdMqgi4yD4Z1Q8Z9mV7RuA1JAVlItxwbLFmuw+y5znFZGf?=
 =?us-ascii?Q?fM5zBZ0e4lXJQE93v7BpJLRUaVq7/7rauTjtG7l+A8dlL8EUFWr7Drfn67Bk?=
 =?us-ascii?Q?BBpr8QqxVN6NV0gC2Qk6fE72DuU+bnz8CuToFj66SlsIe9ECPibmvE4NVxsG?=
 =?us-ascii?Q?ePx6fQfG86DV+qT2FCOcOy94ikwnUSIlScAuMQppEB72zW8B6qO23siKyVai?=
 =?us-ascii?Q?6cQ04EfuTUUZySnsCO+fsy5tWyJIsbwRaEu9MuW4gdoKUIN+YTMdz69MXX21?=
 =?us-ascii?Q?DjtiHsbRl7bMKULwOFKiPkyo735odg+t5hDi7ELkfiYBYb14KcRb9sF+CFXK?=
 =?us-ascii?Q?3c26qlh7AT4UgqHoHrQ52jb8GGRjvJpIDfOS3KPKUGNDez6nBIqmcG5WHqkm?=
 =?us-ascii?Q?qmfXw5kzB+c3mp4RG4GBKlZ4F4jcSGGkTWyaLUYvzdN1inrytPhwWa8RkoBO?=
 =?us-ascii?Q?brmkGTtp1Rh7bxV7rp49vWek/cI8eh1Mjo+RSgZb35ccNdJIDG8kyiawBjp7?=
 =?us-ascii?Q?LxmIT1tpkzrb64ZHu3GR4mIq475DK2Qq52EpB/1Cju1IvOUi0IOPpWtlLuOq?=
 =?us-ascii?Q?9h1ZJ747LY/raMFjymXOk1uDdtC+wjNbzOfWWUUmUkTk3zqXvkjwQwuLhjz1?=
 =?us-ascii?Q?UAXU1vKxNlr2e50ccgyxArjg3YTDmeyMvl0uBR9WmEM7njcPaJevk3pkxwEF?=
 =?us-ascii?Q?GbKsp7e72t9/CEaqQTXHxWyOmfwLowhxiSI1VcILebHtsxZ3ArxyC4E/VBXT?=
 =?us-ascii?Q?cystIiuMgEMxAM87XcAW7zvgXSLgaVeg88Ab6pMkdBMPCcj2soWScvMCy3e7?=
 =?us-ascii?Q?RZ5PP9jv3AVSJKuucIbHQHvYi6onqkz/kFU/G8xrwgwTmklFK9fT2MphoAAX?=
 =?us-ascii?Q?7v8+LZVIMfwcV15XYu31?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ut5cQIGcrbvIwToXCpuN8SxyWSTw2xRUSoAMAyRKT3lhfFEUk89hxUHGXwbz?=
 =?us-ascii?Q?jTZDH1xIzikvReXHbBdpuf6ounMpWOiCcn648YMDuomf8DPQ59NpFTl/KcPh?=
 =?us-ascii?Q?8cQJVNu+oI2D0mKNvmQ+NpEfHGbr88i1nQYFYLo7AaKZ9izmvQXXWaX3AWhD?=
 =?us-ascii?Q?VhsxKKCxn93KHX3ZWeT0FHZaJnuXHxRJRSWl1wfbT44gQ+S3lHwAf3je5389?=
 =?us-ascii?Q?7QodOno2hgwMuYJYVn1YwjhY0mhM55HIr+JoGV0MZgCRyqiW/yh1QdN4WpQR?=
 =?us-ascii?Q?wXqMun8/bOpSnXVheBV2VLRX2QxJ/4lTRmhxNtYK11NGlJzUrEi0y3IjELw6?=
 =?us-ascii?Q?rsjvYigLPXdkThtQGbykqE6r6H67VuNmYdxUFottl7zL64J9kai73LIjqAFl?=
 =?us-ascii?Q?O4QhxrkMK7Mh9CydDNhw3hCcRTccrN9nI3CUgY3NucVbk8Rx+bPk2CWmhleW?=
 =?us-ascii?Q?8cfBBxdoW93h6tIuPoqnBXg+Uz0b1rCl/xw+b3OqNMtcpLJAHWIqcSJWjgGi?=
 =?us-ascii?Q?CevEK/Ki4WyjF1z0mCwiawjI24uaEiNw+Rw5P54bkBIVXZZL2PjzwRexI27z?=
 =?us-ascii?Q?A+7bGCEUbD2F+ocZjuIEkbVysZGKqJSl2zFG+C261JVluXccJWj9Pm4+tqQd?=
 =?us-ascii?Q?cEJXainPSmgezc1eCZZkZnitMkhhwBjlZYXFAH22gDNPEp5S3prwzMZ6DRNj?=
 =?us-ascii?Q?1FTsfhNpKyOWqtZJKnr99rJHLsQiROjzg2ipc3hOELVz9MO94HxAkIr5vVSC?=
 =?us-ascii?Q?D8xRdmWJA6koR/FJSx4uKRmVjPSpsjvG+YdMWLEesfz/ebcrTp4ub+arwJEu?=
 =?us-ascii?Q?cmUnVG7EHcSVtOgvA+1fsnhq0CV5GSrJZE57W4I2/SNgcEMbX36HyM9q091w?=
 =?us-ascii?Q?IsLRh5Hh7fkpCuQyvnJeOymA6OIj8rMC68s0bnWroEeyoUcJoNMX62ulyuvt?=
 =?us-ascii?Q?/CjPJ9tFkSPFMzYYRRATNreK/dbt6HpD8KDaQ7O7tPaOeUzVjF3MJKej7y1r?=
 =?us-ascii?Q?hJXXKz2N+P75H5JzZy/j/DfwPaU7ESbSiMlm3pGfnGC4TLDg2GhOm5BTjFLG?=
 =?us-ascii?Q?kPJqn6fgfKYrpOPpw8TdUlV8rylroxKrvOqsuds+R3d4z2IvyMv/i724L4h8?=
 =?us-ascii?Q?v6mIR6d0K3NO2cELF0p9AGgIjttFiPJOAbMEw3c0YqVATEDTVnD5+lH9RjIz?=
 =?us-ascii?Q?lTy3MSTX/a2QI7UDaddczrI3+z6akoRSh58TsQ9iwa/hiiWfalTQLAXHXT0m?=
 =?us-ascii?Q?66Rx6ztOQ30MQZe6fwA3rLdgXQcywtoJ0swUH0Js3jZ7m8JPHpjc9iS8SU+/?=
 =?us-ascii?Q?zo4ppCkr04kDvhYJXcrJ/wAi27aDwvywqAHAJj9O0TUv4FrlJwXCFuKbsKxX?=
 =?us-ascii?Q?aIYlH2RpRBXbVL/dbeHCk0w+TVTqtapGZN2ZLw2wl+KCxolLLqGmaW+3tVll?=
 =?us-ascii?Q?kh9kr1JdnC9VLNiVv4fFCx1NJ3TtCPWpLsA+9gVHccyOsyzNjZkNiuM7F5aA?=
 =?us-ascii?Q?cucyMKxIH7WcfAR3rsfttgUZ9cdGWG5OXqKBbrG720rX9yImH+K5t180P9x8?=
 =?us-ascii?Q?z2G2+n3XZ16XaDi7+7LyBa0lB2SzZeyIwJMZuoshYi0lAhxTcKTmuTqL4grs?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MxJraTTmBxgESNwUCsqzbvKPSqPkioPqwsMMFy/S8uWY7bg170J1VXdyarnfJ/gbT01GL7JwAkkzblUSkCCuJSdbxt/2jeWm0/n3mUe0e0EOhJIXujy4lSS3mfqHkRvgo2vMirzrLjfv9YnkXY+zfQL/4YbJXZWevgfqijz6SjLlgqS3xWwnMOpMhGXqiP6DwBO2DAGho9cufI1BRoBaLwmGz+45PYJXZcNnRuRJxYs7ddOdf7JEUo2xK1bUZxS9J1LHtwuOwk4LqC83+dGcMi8ysZWdUuG96J2BF8Rn7AB5IuYhSw4e48B3YBEJNrX17L9giMUCzKtnNC0aOcZaBDzqAmtJF1YcuaBlJBGne70wcIZiKK/vACeIQP+PWvgjK3Si2vWIRMtfeN+SYcaoG+wLwHrA50w2h2YSJjawECTnOMr4rAxIPAd7eHkvt5BjhX+0itj5vyrbsqbQUgQMtZw3gjIs7xrVFeK+0Q0BOokph5OdjCZikxBZnaPJSXF14a6Vh4rRPDrqNOKzHiPmgwWxD7bxMSBwhukuF1bDR85p9K2q/Gy+yCXkPS2OF84idzM+WNxM2WTOblCna9mk8M1kFzDDUXVK5+weeQUocWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56d53e6-c4a2-46f5-3b15-08dcfcd0ed31
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 13:02:24.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxrNF6l41qRO6vD6NkBQ4R+SEIw0bd+Qhb5FrI19Mx6NCwfyZLqgOvepd5/HzA2KQ2namd16bgweFrRKGv/8KqUJnuFlzK5MLvQ6oYKGU3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_10,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040114
X-Proofpoint-GUID: HjWAWce5gNTguK6vOhrskUd-v18wdbWi
X-Proofpoint-ORIG-GUID: HjWAWce5gNTguK6vOhrskUd-v18wdbWi

On Fri, Nov 01, 2024 at 04:48:32PM -0700, SeongJae Park wrote:
> On Fri, 1 Nov 2024 20:58:39 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> [...]
> > On Fri, Nov 01, 2024 at 06:50:33PM +0000, Lorenzo Stoakes wrote:
> > > Locking around VMAs is complicated and confusing. While we have a number of
> > > disparate comments scattered around the place, we seem to be reaching a
> > > level of complexity that justifies a serious effort at clearly documenting
> > > how locks are expected to be interacted with when it comes to interacting
> > > with mm_struct and vm_area_struct objects.
> > >
> > > This is especially pertinent as regards efforts to find sensible
> > > abstractions for these fundamental objects within the kernel rust
> > > abstraction whose compiler strictly requires some means of expressing these
> > > rules (and through this expression can help self-document these
> > > requirements as well as enforce them which is an exciting concept).
> > >
> > > The document limits scope to mmap and VMA locks and those that are
> > > immediately adjacent and relevant to them - so additionally covers page
> > > table locking as this is so very closely tied to VMA operations (and relies
> > > upon us handling these correctly).
> > >
> > > The document tries to cover some of the nastier and more confusing edge
> > > cases and concerns especially around lock ordering and page table teardown.
> > >
> > > The document also provides some VMA lock internals, which are up to date
> > > and inclusive of recent changes to recent sequence number changes.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Acked-by: SeongJae Park <sj@kernel.org>

Thanks :)

>
> > > ---
> > >
> > > REVIEWERS NOTES:
> > >    You can speed up doc builds by running `make SPHINXDIRS=mm htmldocs`. I
> > >    also uploaded a copy of this to my website at
> > >    https://ljs.io/output/mm/vma_locks to make it easier to have a quick
> > >    read through. Thanks!
> > >
> > >
> > >  Documentation/mm/index.rst     |   1 +
> > >  Documentation/mm/vma_locks.rst | 527 +++++++++++++++++++++++++++++++++
> > >  2 files changed, 528 insertions(+)
> > >  create mode 100644 Documentation/mm/vma_locks.rst
> > >
> > > diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> > > index 0be1c7503a01..da5f30acaca5 100644
> > > --- a/Documentation/mm/index.rst
> > > +++ b/Documentation/mm/index.rst
> > > @@ -64,3 +64,4 @@ documentation, or deleted if it has served its purpose.
> > >     vmemmap_dedup
> > >     z3fold
> > >     zsmalloc
> > > +   vma_locks
>
> This is the "Unsorted Documentation" section.  If the document is really for
> the section, I'd suggest putting it in alphabetically sorted order, for the
> consistency.  However, if putting the document under the section is not your
> real intention, I think it might be better to be put under "Process Addresses"
> section above.  What do you think?

Well, at the moment it's sort of a WIP thing that we may want to put under
another section, was just putting there somewhat arbitrarily for now.

I also wanted to avoid too much debate about what to put where :P

But absolutely, ack, will either sort it there or put it somewhere more
sensible, thanks!

>
>
> Thanks,
> SJ
>
> [...]

