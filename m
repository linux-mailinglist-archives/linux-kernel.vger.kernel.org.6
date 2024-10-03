Return-Path: <linux-kernel+bounces-348931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127F98EDFB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860A01F22807
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D653155389;
	Thu,  3 Oct 2024 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PmHdNsBP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H4XFK+6V"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993F1422C7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954281; cv=fail; b=suChJIHvjBz6jKdfqglSusH4hNIdmUY/EdZXnHdj3u7vXlyTNPs23G3gUUuUhFAUJlDdYoK0vUOTVUz+FcMLOTKQYKIC04UJ33+vIiWph/qBfLoY//1Xw62ttOYL1sUqRhEijqwXjgAHh0EysF6KkKuePZVlFbIflAX3wt7vpBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954281; c=relaxed/simple;
	bh=GchRBT6Nn2l9wlmJiJgGnXg5kPO95s+6IZ2Ea0alHRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sK06uc2BJpp2cSK1mZgvgMFiAq0Fkd+Xlft0pfpqyiSMk2BTQtZQoN6Ap7MK85tcufAL7ylR/DfxApC9jc+tTSm8US03lzhJEpsgxezWCWfbM7b43QsnDOjUp84vp/3JgTNxPRNBiGUPYlK3cGzyRg8kl4iloQGrDPphP4Rjm+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PmHdNsBP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H4XFK+6V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4938tduQ009725;
	Thu, 3 Oct 2024 11:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=jC4euYFKPHfsqMY
	vPFAZVBwMmtMa8FNgqU/kdax5IH0=; b=PmHdNsBPd8OmSS+mli1hS6CbHhWl6V9
	GHlIYu4A+RW9tNzqczSxpf6g1WV2jqlgeBnr3b1GZKhYB5J5YfXR0IX+qNH8zOBV
	NwQAZijCcfaSf0mDOBCKeJnF8F7PZ0zSVqB5veftJrc05BsFd/W+xpNrypwNeWyr
	RblJsbAlWUwmkTxN9OsvncXKtWhEJG7r6agi76escZYC8B1p2Q4Btbe7+KAkoOhQ
	zG8DYMpJ+q41jtA+pxAkXQ19SZOqmU59H9RCac1yGzJ4HjDazEoyxrb3jtqJY2di
	MLKpfJuLOhU2Qn07uSPU+fp03dkY9iqmai9YvohbKD80bA04JFPUFrA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87dbs5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 11:17:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493AB2bS040531;
	Thu, 3 Oct 2024 11:17:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88a1sdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 11:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPpS0AreO7xcibn/vh1k3sSLoUdV4CUKDjFq3hln41yGfpA54WNRyHCsZLiSDvat2pUauWOud3YtR4J+E+JOC0H4lA/aUUNFvVEiumTjy4tOHsrqJtfFm4TKBw3xGu1BYDQoeGrYS57DsvPeSHJcRgYxQm4P6Z1U6nZhMpE4RRp0b5ElvAgAkGbI60Z3g0yX37hh85DKEyGyxro3Jvco7+3Ywz9PazE396srYhSEaBcJXOOOJ1YgvSshbAz2zo33Zq6InQRb/Vam4d7JJZ2lQM82bpNVMksouODRSP45kpSvb4c49LtHbXlrS+KENLrwdzgroRH+/OIOVi63/sC1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC4euYFKPHfsqMYvPFAZVBwMmtMa8FNgqU/kdax5IH0=;
 b=ZMuZrzS/KBjRTxd7w80OQnkYa7LTgdUxpD+8KA6jXCBfG2ZPVotMoek9SRPrSGQ7DHo8h5EInARXeKVvMMXiWLUZZ178g+s3dDxaK0YGiayhQGTr7I+hh5TpWk3mUk1rvXuZ/BrkfVcsNr2+pphZXSLZ8S4vfSLGTwKzl7TWKnXyhRyecBLVeEHPakWmTrvTpBCuSzgM7rw46A+WVacdjNobzweMHVGmz3F4ucO7jg8jPZMUvqK8Kp8idMEwhoAKK6zgN+6OKpQjkOJ2UWjDqQKfWzf+2CFB4TOIjL4Jt/acuBpWYUzmj83qmvsB6eVwtxFiSl0z1ssgN7/gfY0kQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC4euYFKPHfsqMYvPFAZVBwMmtMa8FNgqU/kdax5IH0=;
 b=H4XFK+6V1j12RMLFHaxrD4lZxoksIj8+Tm6k1sOf9W7fP8BbhtQY9lXTXJdot+HoeVYD+Bsu0ck3UPPl5U28M0FVF9UmZ3N2C6oQeJmsoLsgZyAxR5Pf016tNgSyshBpmmAnfZMtjIR0nCICnVFNdufADB37kBdtLnikAYHRHRA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7387.namprd10.prod.outlook.com (2603:10b6:208:42d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 11:17:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 11:17:38 +0000
Date: Thu, 3 Oct 2024 12:17:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <77bde7d5-6506-4769-8758-ca88bb244bbb@lucifer.local>
References: <20241003105143.2957-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003105143.2957-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f6f9dc-b33e-451e-427f-08dce39cfd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rXZ0WveEw0E/FPft2hwt4rW+qQYO/BHUsOjCJd+XSae2gpjHgThRv70+YdBS?=
 =?us-ascii?Q?ikv3u1F3TKmS3NQpx2e30YZp/tPN0ogycBLudHC0BSOclMkRWdttcZ9yReni?=
 =?us-ascii?Q?gFT+5GNYAhjFAPu3+Lvit0rAnpAWM0iMvaSqSwEGfPj0tQyCSNhPL9MLjwgt?=
 =?us-ascii?Q?1v8XdlF6fJW+6lhh28f+ZWqyFquOlwSi3WzNDU/e+Eq5yWvnBKrK/B7zYzZ5?=
 =?us-ascii?Q?IkTStS8AeUfNFHj+HbIUt2KMxHv9erlOJV7Co56Zb78sBisvztqxao0wHW7J?=
 =?us-ascii?Q?+NNoeLMsQGrIxjfnfYDGoR8yYh05WJCiiOqFEWmc8wLnr7Vh0EQP4CVvc0ep?=
 =?us-ascii?Q?HrPXSWgEqO9Fr+K/OFHwt8aPCh7SPcob988RpuyKQvVN/HTIt9ow8ZtaHhRR?=
 =?us-ascii?Q?n7buYv2WjuLv6J5SFbOtSAlWQ6EivX89xslXmVOyaReLOOReNOrvaCaHkOjJ?=
 =?us-ascii?Q?BPO6JTHGvtlV/LJr8/yl6K2Uyc6jOz3bmbncnjNNJYda2Dvy70EoFOUeGtx6?=
 =?us-ascii?Q?YRV6mrnDKJzzuo4vWznzbmZuKW8yK2Hi9grYxVT7wf4gV00zlWt6VLmHnH6v?=
 =?us-ascii?Q?aav+grnSzb6PTjQ+yHlKWog/cC0x8YjhNYk6na1opqIQ46OmoJK7sfPySr/9?=
 =?us-ascii?Q?X9A0WTdB2IdPjfRQwKlHDDAqfSfH7Fu5j4shnubin0mNdKIjNC7qwAnokOoD?=
 =?us-ascii?Q?7A0WjM29LrZ9ThlZU8SINJW3ugWF1o4Y2DQ+ZD40rPDLtNw8yBcTTUe5WJfX?=
 =?us-ascii?Q?3K+2Z/0mL2Ay/fb+ZQYklrb+BEQMe3y2VjcHHbHHJ5zPQbkOX5tWUIDkhxLD?=
 =?us-ascii?Q?bOEX9zZtA+9tpAF8mN5G5HJ2gAdwr/uMZnMYOTtik6UHFYTtQBaMVjin75QV?=
 =?us-ascii?Q?7mMmaf3RI63tsnKqsmtiacB6nLdXCeFmoSTEcNTEfHsKcK8UPkh9UwZf+yY9?=
 =?us-ascii?Q?e4icG8XG9lWchsPA9Rov1sPulPsY96HRf4tcrj7Hiok/5bqVbFZXF4V57EI0?=
 =?us-ascii?Q?o6qf3+M6iPdxpxO4mGptICPQ/FFhtQuWz65GDTIaTrRHPREXsKIh+ydVibCt?=
 =?us-ascii?Q?HropBJ/M9kY1pJYSVrXqhYILAMdszKB73lDEXr6DCOs4IYX6VoUXlv8r+Oyk?=
 =?us-ascii?Q?lLUHzMMtsi4H5qOXAQqbTlIkOzCgBW9M5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NmHNe0cWvfcqedDbwcVapNeqk0kb7wiQpN92SIOtqbaskvC9c4JjbwMWkvu7?=
 =?us-ascii?Q?gmc+/nrwyWFrSZ7VSqFYeSNG2YFF5PQLoM+qPNtH/wopEJ0jgj5nfmebAWIR?=
 =?us-ascii?Q?NTcXFFLxOSvJnwCxSzDYdfMG3KpE6WgEXGHfQSskgQ8xBeF3Q7fWri/pyYjz?=
 =?us-ascii?Q?XgjgUiIvJpGf5HrTuhFEwTs/5bKsXLhhvJA3vzJMBz80QoGPKP3+w0zLKpHx?=
 =?us-ascii?Q?PCGya/BDxrfCfB2xhetCwSlNhz8NpeGUFOR8NQCzg/BTSlRdVKrpXgJJ0XtO?=
 =?us-ascii?Q?MgjnqYcz52nWdwT9gGRltNJzqb28wGUgujM71y69AfY7Is+01+KHuUoNz7Yy?=
 =?us-ascii?Q?Lb/HAke2808OW1e24ZwO0TOw3tvVGXVVN5swrNds44PormI6Ho7bSs3UpqWE?=
 =?us-ascii?Q?DWMA9nRO929TdoIWOeaPs8+74q7PySRUysxSXclVOy7BbX7C52Yg8WVeKmIa?=
 =?us-ascii?Q?R7iiMwlt3602PWsJP43PMiLmznQoFvBMf/Es0heRvhaIwjByXJK9ahkfJ6zJ?=
 =?us-ascii?Q?28QKKHxsHxbg3FETykCNxeVI6eTLGXnMbRXDrQRczOM/Uz2I1nzGWU/j5WOl?=
 =?us-ascii?Q?xN3004SZGzfp8/UUz9aAOsDPJtSa2ujhi9p6+qtYczgpVqct5GvVTs0p4tOP?=
 =?us-ascii?Q?sGqjiLhe0HHPkZGzq2lpxf+DiCFX+p3p6VQSGCVSxtEHQ0L0otRATQvY6B7U?=
 =?us-ascii?Q?mEUNYU/qpwmM9sNbF1PY5ZiHEYAi3ylmaCrmOTUY8jBVWnLnuXuioaY4iN95?=
 =?us-ascii?Q?L0OlDplt/Z63T+cEfDFcqFf/wFgSa67rxovIyhi8QErNXI4ogkHBzQDYeTxk?=
 =?us-ascii?Q?M8zbhmrnUvDHhe7wzUrUOBjgay1btwYddoHUDKh5qCYQtcji9bymgmQ4VLH1?=
 =?us-ascii?Q?WzosV+sgN8uw8g1K97M86w5nPSVetRW2tKwaWlxpQD9LWiovlARw4lbbN9J2?=
 =?us-ascii?Q?pK/sTEB45qG2a2+gt1si64LhwT5iGgHFWG6qmC3km16Z1uxXoHgS4n/MQna+?=
 =?us-ascii?Q?pTCILlUVQMyyrWhBHahxVdIIExywznCU6F3m8cT+JEgib17C8+CY7r9ClNpO?=
 =?us-ascii?Q?2LFOvexUMH6LwJAK7bzgt9j+Mxl4iOZ0Cae+qBwvEq/mM+nNyd8s15AQ2xCm?=
 =?us-ascii?Q?vuuUOl8jT5CIVrV7ai/d+42bZQ9QPJM9IrOwqovKfWcqYq5TIXQS5cEPwZRL?=
 =?us-ascii?Q?AUst31DhNjWyDcRcwV5wlTL8MFGz1bQPawOJVtwehnUgx2inCGJOOxerWQl1?=
 =?us-ascii?Q?ZOSFMPCIbLDJpqYynplMJhxi18+PwbcrtY5klHm1HHOofwEw42YcAloS+37J?=
 =?us-ascii?Q?8cQZDWMCR2/G0Lloyj0Lvan2MZvTuFTtsnAwpHcLhfG1QJgYcUHEFMxQCTv3?=
 =?us-ascii?Q?zHLmIeBHjFTSYc3s8S6qilDfOcJwbn6JEVeQL1f+cLdGCtY+NwY/G+HKUjNo?=
 =?us-ascii?Q?42PKSECOxIsTbmKSwDr4Eh8N1IqH6A6tTWNlkdwudACcdasRUrsrhEme3Nmw?=
 =?us-ascii?Q?ZE9lgexSX3lFhwSBP2ba9XZO+DV1QZU2OMOcu7EnUtwePcbBJkC/SAU2FCDA?=
 =?us-ascii?Q?/FDS9eaglBb07rSTFQai2uHZmYpeKM3/ps9J8tfnw1sdHfBhIqoBYY0r01lI?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kXVU3kuHs6lcrnHeAzLMtWCpH3+FF1NG/8zgrJDHu4JI1a4e1nnZhf/AbUt3VetXQ3Jy3T8TmxYbDHBktbADhpcb5DclpRZERhH5hHE7HrBf1l4JePd9Sqq1VXWDp52VH/idBd5w+M0DbxMB9zhdtqhjQ53y4j1l7geUDqNb0zha25TSzlgZuC1sFjy2U2FlRgKTkLgR4mAYs1bj5NpwsFN93nxrWNHlPdjwLMg+w5vbxnsTqT/9pqx4HNAzb9UrkkDFucrJq9YpFKN1YLuvggBmAH5G5aSqjlLQzKnxhsXeuk2xHxpygCZIpEWHVlFfCYZVnqoXe0A+QZ4ij9mbq6f7cCXqQHju9Z0riTEgrpnMHuzFSFD3k9IQKNowlCTt76od1aaUWVozivHJQ01S+hJXsf7btLIyt56Iy4tKbU24IwXVQ09Sx9/g38of6is2wL6tnO+Vbqq/kWNiVu35qiqhERWbl5hGu9YhxSuA+L9NfxOg/oJLIoIEZspp+P+5KFb+x7CGbQ1jrNTfW91mACTIfawHGnyQ0VKE+X6VaxmeE8w0A8ymoYZm1TDEOHOLuh1KiDS2c6xnUaFiHvbsUqJzePMOy+SLiXLbSRjMMJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f6f9dc-b33e-451e-427f-08dce39cfd28
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 11:17:38.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GNIJEbgyG7LXZJNVxrYiLxYREiSwFeQ9R4WSDpKJ3ERiHn7oBctk6NYltYaNqOIWyXxXbOwmCECJFaWZZKzLuQSFQw/Yi7LQvyM33HRyqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410030082
X-Proofpoint-GUID: Q2IBhysKRvUgirucJjcLCq53TyRdCbqC
X-Proofpoint-ORIG-GUID: Q2IBhysKRvUgirucJjcLCq53TyRdCbqC

On Thu, Oct 03, 2024 at 12:51:41PM +0200, Bert Karwatzki wrote:
> Here's the log procduced by this kernel:
>
> d530839eacd1 (HEAD -> maple_tree_debug) maybe fix 2
> db8adf7c0a23 hack: mm: see if we can get some more information 2
> 7e3bb072761a mm: correct error handling in mmap_region()
> 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
>
> The "maybe fix 2" did not work, either.
>
[snip]

Thanks but oh man, that's disappointing. This is a really, really strange
problem.

Taking a step back, let's see if preallocation is somehow a factor here.

Please unwind all previous patches and apply this to the 1st oct next tree
- this contains fix attempts and further info.

Thanks! Lorenzo

----8<----
From 558ac3118b2861408a17993e4379f40046767fb3 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 2 Oct 2024 09:19:28 +0100
Subject: [PATCH] hack: set of fix, info stuff v3

Add some dreadful printk() hacks so we can try to get some more information
on what's going on.

Also various attempts at fixes
---
 mm/internal.h | 15 +++++++++
 mm/mmap.c     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++--
 mm/vma.c      | 66 ++++++++++++++++++++++++++++++++-----
 3 files changed, 162 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 93083bbeeefa..cd9414b4651d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1443,4 +1443,19 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */

+static inline bool check_interesting(unsigned long start, unsigned long end)
+{
+	const unsigned long interesting_start = 0x1740000;
+	/* Include off-by-one on purpose.*/
+	const unsigned long interesting_end = 0x68000000 + 1;
+
+	/*  interesting_start            interesting_end
+	 *          |--------------------------|
+	 *           ============================> end
+	 *        <=============================   start
+	 */
+	return end > interesting_start && /* after or overlaps... */
+		start < interesting_end;  /* ...overlaps. */
+}
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..cef827f4e3cb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1341,6 +1341,18 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }

+static void ljs_dump(struct mm_struct *mm,
+		     unsigned long addr, unsigned long len,
+		     vm_flags_t vm_flags, bool is_unmap)
+{
+	if (!check_interesting(addr, addr + len))
+		return;
+
+	pr_err("LJS: %s mm=%p [0x%lx, 0x%lx) [vm_flags=%lu]\n",
+	       is_unmap ? "munmap" : "mmap", mm, addr, addr + len,
+		vm_flags);
+}
+
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
  * @mm: The mm_struct
  * @start: The start address to munmap
@@ -1354,6 +1366,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, len, 0, true);
+
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

@@ -1375,11 +1389,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);

+	ljs_dump(mm, addr, len, vm_flags, false);
+
 	vmg.file = file;
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 	if (vma) {
+		if (check_interesting(addr, addr + len))
+			pr_err("LJS: mm=%p About to do unmaps for vms=[%lx, %lx), addr=%lx, end=%lx\n", mm, addr, addr + len, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
@@ -1388,8 +1407,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto gather_failed;

+		vma_iter_config(&vmi, addr, end);
+
 		vmg.next = vms.next;
 		vmg.prev = vms.prev;
+
+		if (check_interesting(addr, addr + len))
+			pr_err("LJS: prev=[%lx, %lx), next=[%lx, %lx)\n",
+			       vmg.prev ? vmg.prev->vm_start : 0, vmg.prev ? vmg.prev->vm_end : 0,
+			       vmg.next ? vmg.next->vm_start : 0, vmg.next ? vmg.next->vm_end : 0);
+
 		vma = NULL;
 	} else {
 		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
@@ -1413,9 +1440,32 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vmg.flags = vm_flags;
 	}

+	if (check_interesting(addr, addr + len)) {
+		char *special = vm_flags & VM_SPECIAL ? "special" : "";
+		char *has_file = file ? "file-backed" : "";
+
+		pr_err("LJS: Interesting [%lx, %lx) flags=%lu, special=[%s] file=[%s] addr=%lx end=%lx\n",
+		       addr, addr+len, vm_flags, special, has_file,
+		       vma_iter_addr(&vmi), vma_iter_end(&vmi));
+	}
+
 	vma = vma_merge_new_range(&vmg);
-	if (vma)
+	if (vma) {
+		if (check_interesting(addr, addr + len)) {
+			pr_err("LJS: Merged to [%lx, %lx), addr=%lx, end=%lx\n",
+			       vma->vm_start, vma->vm_end, vma_iter_addr(&vmi),
+			       vma_iter_end(&vmi));
+
+			mt_validate(&mm->mm_mt);
+
+			pr_err("LJS: Post-validate.\n");
+		}
+
 		goto expanded;
+	} else if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: Failed to merge [%lx, %lx), reset...\n",
+		       addr, addr + len);
+	}
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1441,6 +1491,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;

+		if (check_interesting(addr, addr + len)) {
+			pr_err("LJS: call_mmap() on [%lx, %lx) old_flags=%lu new_flags=%lu new range=[%lx, %lx) [CHANGED=%s]\n",
+			       addr, end, vm_flags, vma->vm_flags, vma->vm_start, vma->vm_end,
+			       vm_flags != vma->vm_flags ? "YES" : "NO");
+		}
+
 		if (vma_is_shared_maywrite(vma)) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
@@ -1467,6 +1523,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);

+			if (check_interesting(addr, addr + len))
+				pr_err("LJS: flags changed for [%lx, %lx) from %lu to %lu %s\n",
+				       vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags,
+				       merge ? "merged" : "");
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -1510,10 +1571,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
-	vma_iter_store(&vmi, vma);
+
+	if (check_interesting(addr, addr + len))
+		pr_err("LJS: mm=%p: iter store addr=%lx, end=%lx, vma=[%lx, %lx)\n",
+		       mm, vma_iter_addr(&vmi), vma_iter_end(&vmi), vma->vm_start, vma->vm_end);
+
+	error = vma_iter_store_gfp(&vmi, vma, GFP_KERNEL);
+	if (error)
+		goto close_and_free_vma;
+
 	mm->map_count++;
 	vma_link_file(vma);

+	if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: mm=%p: About to validate [%lx, %lx) addr=%lx, end=%lx\n",
+		       mm, vma->vm_start,vma->vm_end, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+
+		mt_validate(&mm->mm_mt);
+		pr_err("LJS: Post-validate.\n");
+	}
+
 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
@@ -1530,6 +1607,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	perf_event_mmap(vma);

 	/* Unmap any existing mapping in the area */
+
+	if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: mm=%p: About to validate [%lx, %lx) addr=%lx, end=%lx\n",
+		       mm, vma->vm_start,vma->vm_end, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+		mt_validate(&mm->mm_mt);
+		pr_err("LJS: Post-validate.\n");
+	}
+
 	vms_complete_munmap_vmas(&vms, &mas_detach);

 	vm_stat_account(mm, vm_flags, pglen);
@@ -1594,6 +1679,8 @@ static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, start + len, 0, true);
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;

diff --git a/mm/vma.c b/mm/vma.c
index 4737afcb064c..06e7a0a18aed 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -223,7 +223,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		vma_iter_store(vmi, vp->insert);
+		WARN_ON(vma_iter_store_gfp(vmi, vp->insert, GFP_KERNEL));
 		mm->map_count++;
 	}

@@ -598,22 +598,34 @@ static int commit_merge(struct vma_merge_struct *vmg,
 				adjust->vm_end);
 	}

-	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
-		return -ENOMEM;
+//	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
+//		return -ENOMEM;

 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
 	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);

-	if (expanded)
-		vma_iter_store(vmg->vmi, vmg->vma);
+	if (expanded) {
+		if (check_interesting(vmg->start, vmg->end)) {
+			pr_err("LJS: mm=%p expanding to [%lx, %lx) addr=%lx end=%lx\n",
+			       vmg->mm, vmg->start, vmg->end,
+			       vma_iter_addr(vmg->vmi), vma_iter_end(vmg->vmi));
+		}
+
+		//vma_iter_store(vmg->vmi, vmg->vma);
+		if (vma_iter_store_gfp(vmg->vmi, vmg->vma, GFP_KERNEL))
+			return -ENOMEM;
+	}

 	if (adj_start) {
 		adjust->vm_start += adj_start;
 		adjust->vm_pgoff += PHYS_PFN(adj_start);
 		if (adj_start < 0) {
 			WARN_ON(expanded);
-			vma_iter_store(vmg->vmi, adjust);
+			//vma_iter_store(vmg->vmi, adjust);
+
+			if (vma_iter_store_gfp(vmg->vmi, adjust, GFP_KERNEL))
+				return -ENOMEM;
 		}
 	}

@@ -956,6 +968,12 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
 	}

+	if (check_interesting(start, end)) {
+		pr_err("LJS: mm=%p About to merge [%lx, %lx) to range [%lx, %lx), addr=%lx end=%lx\n",
+		       vmg->mm, start, end, vmg->start, vmg->end,
+		       vma_iter_addr(vmg->vmi), vma_iter_end(vmg->vmi));
+	}
+
 	/*
 	 * Now try to expand adjacent VMA(s). This takes care of removing the
 	 * following VMA if we have VMAs on both sides.
@@ -1108,8 +1126,13 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		if (vma->vm_ops && vma->vm_ops->close)
+		if (vma->vm_ops && vma->vm_ops->close) {
+			if (check_interesting(vma->vm_start, vma->vm_end))
+				pr_err("LJS: mm=%p Closing [%lx, %lx)\n",
+				       vma->vm_mm, vma->vm_start, vma->vm_end);
+
 			vma->vm_ops->close(vma);
+		}
 	vms->closed_vm_ops = true;
 }

@@ -1179,6 +1202,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	struct vm_area_struct *next = NULL;
 	int error;

+	if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+		pr_err("LJS2 vms->start=%lx, vms->vma->vm_start=%lx\n",
+		       vms->start, vms->vma->vm_start);
+
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 * Does it split the first one?
@@ -1202,6 +1229,11 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 		}

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) split START of [%lx, %lx)\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       vms->vma->vm_start, vms->vma->vm_end);
+
 		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
@@ -1217,12 +1249,24 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	for_each_vma_range(*(vms->vmi), next, vms->end) {
 		long nrpages;

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) UNMAP [%lx, %lx) file=[%s]\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       next->vm_start, next->vm_end,
+			       vms->vma->vm_file ? "file-backed" : "");
+
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
 			goto modify_vma_failed;
 		}
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
+
+			if (check_interesting(next->vm_start, next->vm_end))
+				pr_err("LJS: mm=%p vms=[%lx, %lx) split END of [%lx, %lx)\n",
+				       next->vm_mm, vms->start, vms->end,
+				       next->vm_start, next->vm_end);
+
 			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
@@ -1295,9 +1339,15 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 #endif

-	while (vma_iter_addr(vms->vmi) > vms->start)
+	while (vma_iter_addr(vms->vmi) > vms->start) {
 		vma_iter_prev_range(vms->vmi);

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS3: addr=%lx, end=%lx, vms->start=%lx\n",
+			       vma_iter_addr(vms->vmi),
+			       vma_iter_end(vms->vmi), vms->start);
+	}
+
 	vms->clear_ptes = true;
 	return 0;

--
2.46.2

