Return-Path: <linux-kernel+bounces-572017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9EA6C57E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01BC189A11C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05A232384;
	Fri, 21 Mar 2025 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hGkME+YT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bxg1OKT8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51328E7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594104; cv=fail; b=PPcUP1QcLVty6p9fKPjulj1+uhTiWvelajeDFrEfwh4IuhNcPU0t1dS+QpLlCrhTcuU3cI2W+rwcauwVijhIdqOMTLEjz025Qav5tpv30Vn38RQj7k8QaxvsiaxIFZro7E7eDwVBBz62E+cHGPlr8aLq+5M8scjy7clSKQKOTRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594104; c=relaxed/simple;
	bh=SvsK9jXx51YzlmVHsffWn3ePjDmYtnjfrQCdKBnWjRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdPBB8ngRZj3BBTU3jhlvhFWcrQVnIB2yxRT2OsRxP4JP8tCvzpKv0Kyi8ZzlYHAcgbka+MRjgLjnql1HlocXZb9NNIwBZJHnLOYELbcqRtlat4c7v+RQ4KwIcFqMQGT02pgMqDdhp2w9JjeqEp3J5pQ74Kr/+EhgsmEQPEVO64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hGkME+YT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bxg1OKT8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKft5R021308;
	Fri, 21 Mar 2025 21:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hRydbeF3nYCukYj+F9/cqUlF7bgOKq+6Z2gmhd3ndeg=; b=
	hGkME+YTbBxyu/VIl+mWlBk5CHRsJh25Pv6R+5RPS+RM/CzkIRouDGS0QCrPF9hm
	WjBGwEQLV5qvn75OYH/5CTNGgxTB35U8dUROFCt8dqbpyoYRc8+uDjrMXTZXHLDa
	+sfQE3KT/6YFs2Gho7iGdJbc53Gu+FJYE8CFkHEdUc8cVbGrE0PA2h7alxmDga3L
	0BRoo00OttMo/KpSxbUQ2fpa5tsQWxZwcYuT3t619F6nTfIDxR51bZUkxqmx5+zt
	TEwM4wQWXwV4SfpxlXq7zhwBiwq7fDFdHTgsr+qfSGhVZHjqjufC79o7Bz9+JuZ4
	OV2Z1TbSWsTO7qGZZ9k/eQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8sgaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKr66b022339;
	Fri, 21 Mar 2025 21:54:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxcah0ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypVs+zS/CA2361awVjyuLtM4vd+JeitaZTQTs+Ke7KE5dDjT9vbq1lsWdvtAkFWyTnDEdcXtry6bwM4l7AswDSNw3auNcTupjq6RuZzud3MD8hdUv1SOLmi9/xsav1/8uDTi6xs5FRGOBauAOAmY/GDukE8jxNh4EVy5RP+dQy43gd+9r09eRB/8ilPF7BBZL/KnFh7Dh6LMoiiyA1xXq2tM8ViADZkih7s0vjbgayXvY826UvX3siFDHicT+d5/YLaLI5geG5ZxmXi85yPLN68pIrEFMYx7b1wtzRyvV9Ff8d/t79lPYdqx37RM0EJEIDV1sbklli5E6g9VekRy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRydbeF3nYCukYj+F9/cqUlF7bgOKq+6Z2gmhd3ndeg=;
 b=c1GSEHvJGjp8BDwXr110TDeh9VnnXhrQCYI6R+P/2U+w2Ccgr7tW9WAxEv23K5IkStqvE6S9XBZ8UmJW9eqmnlYbCQ59XooLevGomM2DO3Ai+UH8AM8DfpzzO3zfo7PLGjAmcGoZ2uqAH3KO+yYpdf6SHl4jwg89xcO/1Qa9x+Dk0ErUL+J6tDZr+kMFeUpuv2gzDYJWjew9TGhkGQHn9PLTj6ZutBdvMFoOwDNXiBGwc7V9C3PO11PD7PSh3E9UV25XsAgdH1kRjJH/flRKILihmeqRjGozV5tsJWOsTxky8pvNNytQIadYRg72OyJrwrbK16E3rmD9fb+SKJFnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRydbeF3nYCukYj+F9/cqUlF7bgOKq+6Z2gmhd3ndeg=;
 b=bxg1OKT8IRjlcvdOtPomXkAyE7bN7c9uvbExIY4n0o05X5teKN+TmoNmFyEdNhoraJjuji0Phye7kSEjnRPh/Mnnm7qe8pgDCoUnSEs01qawhMkMlHymctQXFYp83EM/2sF4RNTc9OUdm8+l+HiUbXvqp+5XSbDVNehPALdw/0k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 21:54:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:54:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/7] mm/mremap: add MREMAP_MUST_RELOCATE_ANON
Date: Fri, 21 Mar 2025 21:54:31 +0000
Message-ID: <48f1d8a43f58069f697a2daba285a1e3f02e2cbf.1742478846.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f82601-c580-43dd-29a0-08dd68c2ff5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NGZX1uOk2aITBduPe6bBJwhHK/gqEoZKj1mWFuNaYP81KuwjJk2B4F/lCIj3?=
 =?us-ascii?Q?BN8bZPAQmpuAl8wSvlqHHZMdLpXR00ovjHmAdI5Q02vieKWw2ais1RNcY47E?=
 =?us-ascii?Q?0GEwlWXfeWbnf9piwyh+LdPePfJUI6nuabiRxJ0ZTyuf4IAJ1CboTZrBh6Ae?=
 =?us-ascii?Q?9sHBHe5LnqrwcLtLnavCLFRgR4kiX0sXOQdxPREzfDsmNCHUVKgOJFW8P2Ag?=
 =?us-ascii?Q?kQet3KRBzIByEPOm0rQq3biIdEp9+bae8f91JVgV0xXifuubbCJ46iBMbTFc?=
 =?us-ascii?Q?0/uGoYQpnDPFrPtHuRwrEfd+XsG45wV7pPgb31KyfZn2EW9KlQFMl6mkcUp+?=
 =?us-ascii?Q?Cqw2nFhsrmsPF+1ktZi5TOSjq0f2qnOvAJ0H5m8bqukAvteZFjAdoKL2GEYf?=
 =?us-ascii?Q?dnlbrXrizwpFb3UJRjdxINeM0RyWFN34PIlOT/v9WcAU/Pt+BQFBGf7F/4Mr?=
 =?us-ascii?Q?ADOAuMT0X6Jmt/zRIr5zQMI8C02x2bPrlEXkiagV6CMOWdHk36yJbLX3Ybg7?=
 =?us-ascii?Q?rNsG7HLn0wHOU/69Lkn1YWq32/063ZQpvbAXWKh3Aq1fbmJzajwelYg8Mx7B?=
 =?us-ascii?Q?99DCAcjrDWZFwfVHHmxhoBkuqldh2F/OTEHPRJ/H7jIBL0kYqOxbLiJuzRU9?=
 =?us-ascii?Q?ey9qve8MIeSwt0NdGGFTEKyoGPkHn5LLAyuvlXx0VvETd5oOK071GKAHRMR3?=
 =?us-ascii?Q?hH7RZPhcU8i6UVsQah0NWLsobSOs9BJq7lBLjsa+4bSAffx0a1xWJ6MU+jRp?=
 =?us-ascii?Q?uDl9vFHeWeQL++O/KDzXWfLTciPgL+BfYHnnlGVOglylxad26M0lv5aArQYr?=
 =?us-ascii?Q?Rwqw2l2kD164Xa9Ks+dFHimBm4Q48Dlm6ISxFO3UKHwOrLKnWTBBZojQx6oe?=
 =?us-ascii?Q?n/esIR9h49yCWbftQuwILQQL08fvLgSdM4hQD1F+hgy8JQwc4a/JSdTY3xXu?=
 =?us-ascii?Q?QrgkQbcFwMTpQM2NUfVyrjcmtjBKr07sLLnonja3/ScGeBLYqzCjSwhsLnlJ?=
 =?us-ascii?Q?/3XAIxQ2EZP4a7WN2+/nvHK47Csv+tuvK6Qzjn9cq1jVy5v8bDks81tKAbhr?=
 =?us-ascii?Q?AG8cZQMw1xqlynxNKZdA9TYjDCf0hFNv3yY3+xsk0a2wlbM1ahwJ9AxJZWIa?=
 =?us-ascii?Q?uwrmKjHtOyUNL1ZK/vchbAr8iWUCEs/pPbMOqADkulyC1Nl+rWNJPEQBHJs7?=
 =?us-ascii?Q?X2Ws+Kx761X04Jg5RhqeLw5VYUJP2HNMuT59iPZYXSSx2he5QkIWEjZQtcbw?=
 =?us-ascii?Q?v5CqKI/+dZ810Piyc1r9DZQaImyw+hZLE9hkXPKT4t8S+Jmkz/mHtsYl58Xm?=
 =?us-ascii?Q?FbkjhLZrWJ4UWgoqs4NQKawNmgELjp567UUEftLFWoOJEZtyLaohOtCOoqMl?=
 =?us-ascii?Q?xbxZapUeqWMbDKvNRProH6OOAapW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ruKplwiE1XDa9JNAZp/WBHsnxpguI/vnQNS1LvLJiG22ReR2Yu1jq0i/FNq0?=
 =?us-ascii?Q?6R2yzH/wvDEt00MDWq6npnJKCwabLhuHcWRcI8kpZV5vxq1QDVWZARovsiTS?=
 =?us-ascii?Q?kM46HQXBKfVuphn8ihCssoHohDLs2zcLJe2to4iPXSfITBZ/KxgpKfHfRda9?=
 =?us-ascii?Q?hIu+FSYbifXDVZ5zbYIYUdd8qzXQxZzWULJy32C3KqYTKN44q++w3pQj4pcO?=
 =?us-ascii?Q?ttxsK3eS7OnKj1X52XaGnh6UCp/8leFwGIXDYK0+Vg1mQJ2ZV55o2LPZ4xkg?=
 =?us-ascii?Q?W+iYcSGhSkg9zMIiLamQh4PhsmgO4lyRJOJv2RbjIN8uNz3hlhYXdxhH/ncU?=
 =?us-ascii?Q?xofcy4EpgkgAgfAn87ewUlLviEOlhNxbwUZqaAUnieybjiaoxXhuxAz6d7Bz?=
 =?us-ascii?Q?Z8/FhhSb+FlJAS2C5BcIdjgxZ0K2mSIVJNWhbbw8dztc4g9qezQSjn7ig7Rl?=
 =?us-ascii?Q?BszeqiaHUulpZjj0PfahbtLj/C8ASCO0FAVOlp7i/t22rjKjyPwTYYwJYtFG?=
 =?us-ascii?Q?imwqtkl2JPDSdIWFPjNRX3ouORwcsgZgZwTsQhWH4CsJwvnGTB+K40jqj6Iu?=
 =?us-ascii?Q?u1UK/fIsTAmC7ujj+1UogfYcnu8Op/HlC/37IeHLEikJ7OnoXMR9mcYlipLT?=
 =?us-ascii?Q?Ee/zCM81sQhDFKO8ds1KvVj3t5/eJiF1Q51Y7J5TbC4KLpfRo1nb3wp5e3zr?=
 =?us-ascii?Q?3kVWwCsQXhX0O268llz0BA5sLtCUKy0IOJ6hB51pS9l9nXQyUca1P2xDV1zT?=
 =?us-ascii?Q?o8LPCP2jfy/zS/yDKn6x0GE3ctzu0zSEzlLXK/geC876YMV2m/PfOmrbvXyF?=
 =?us-ascii?Q?NGuGCjZRa6Bi96hjgML0s1siegN3T/xMb0dq0dml8pjKGZMuDAIHVkJ4r5Q0?=
 =?us-ascii?Q?QEAFijjAwTfTgDi4BgTe++Xu1iBtb6+PS9hc9K/x+SBmMkhdNwCosTeGw6oX?=
 =?us-ascii?Q?xtD7QMqRkpruVT3cHS6ssMNYdg6Pn4K7WsDe4UG+yPVq/CKKPW1ZNxiKxiQs?=
 =?us-ascii?Q?Vbdegn9vqQy3gRAAqSC5+wZFXd8r/xKKSAWNeko9Ddqpwe1goYlRj5/F3YKp?=
 =?us-ascii?Q?yshNLThR3xSPy0zULoFNWG4GhMlWe6JE/+N4iVYfjMnKEEu+gCpnI1uHCsFm?=
 =?us-ascii?Q?f8khAUR8DId8UAokd0a5UgFPbsjitlXeT0fQirJHi+Ywjb3n/dlkFbCLi7Ts?=
 =?us-ascii?Q?NBKb5Ui7l1e+8oJ2MOk7Blx5TbjRO/2MLhe+nWCMFhsvqyxwmu+TI+4eRBW5?=
 =?us-ascii?Q?oc5NXES3teufXjNbqaU2Fvgi7AKD1NOf0Dr3yNfpeMPHmxFvT5UyBUZ/Zi66?=
 =?us-ascii?Q?9VoDkZSj8EbQ7CCPYilI3kcV80DkFgarE0L9H8ajV0GYhOtGlok4QOuMo7zQ?=
 =?us-ascii?Q?bcNGWkDM9N4KKNsYgFPJQQL9IN1X/1EosJzOp94DQash5H3thMM0QKQ8oEpc?=
 =?us-ascii?Q?T427cRRkpYF8kfYbPvCvWi3eK4Qxi2CRQjd7UKUew+1pIbOBU5I/JrPtn2ML?=
 =?us-ascii?Q?ng3SLRL1539xu1m2riNgMzKT6t91xVMGF7umD+NIOm3P/e5tKQrH+pfxLZxH?=
 =?us-ascii?Q?p/1SBZL4xJErfvXZlYa63Z5LuodacRuNDO0yxcApUvTadsFEOIfqebSeLrux?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xi3MlH9Jf7p9Naw8wm2Vd8UMstK2lJwzySFtA2l7/mRgRzb0m+cl1AN2X3EW4RrD4cjk+rbc7udhjz0oCuvvZFVMDc4ga4tfqB3ex+/aA5iCefTPkqEE/iNvYkOULA2M+1YZKEtUFWyLP+026gDWim/XCCYlfD18jQYqWWKJSV8RfJ2kU4mKAbdJ0/Jbd+IDXnEDE1unZX2wn8esVP9JfS7qrx0MHkmewkHT6HFJdFM9siLkHGY/mbe6uuOx2Z4Hc8rhCU5G38MhyVZAqOplx/1Xynq9aFPW6Opt5KcZEctr+xbs6Qoq+kdg8s6rhYJBriNrsxxp2HpDwkpgi8iNd7MiH48qukLQ5tBO+/uAeelqWcF7arH9IaBzTTxzyzmm02lSxyNhCZWfBw1B/YPndNmu7AUY8PeoJQumrteeNCIYSL//aILzriosyw9KlBH4PMpoIVBnJpEX0KEj1FjvZgL+9/33tgmzk7XeK+M2r5K/4tILNC6GV1mU+DbHYj1NzDuIqcvRJ/DC9IBEY2Dw/krDc/WLeIrsOSQ+VeOIED319NwCiDT6HiQua+NLxCtqXXuEHxooj/H+rgAjdFZy8GrIke7DQp0LP4ZdIAHJCnA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f82601-c580-43dd-29a0-08dd68c2ff5a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 21:54:47.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nf/icU61oFxyOHnVhdqYvSZ2q/1yuTC3aR2CX4s2H03gI7G5eHwbLsAW7AsIsPVnsPhiOMz1RVi76og8op4Sp67e/+uMw/fd1eOMi2vxAbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210160
X-Proofpoint-ORIG-GUID: F8RsljcggIrvs4X4mvsjYgLHrKyG0T5n
X-Proofpoint-GUID: F8RsljcggIrvs4X4mvsjYgLHrKyG0T5n

This flag is the same as MREMAP_RELOCATE_ANON, however it returns an
-EFAULT error should folios not be able to be relocated.

The operation is undone when this occurs so the user can choose to proceed
without setting this flag at this stage.

This is useful for cases where a use case absolutely requires mergeability,
or moreover a user needs to know whether it succeeded or not for internal
bookkeeping purposes.

If the move would be a no-op (could be merged, or folios in range are
unmapped), then the operation proceeds normally.

It is only in instances where we would have fallen back to the usual
mremap() logic if we were using MREMAP_RELOCATE_ANON that we return -EFAULT
for MREMAP_MUST_RELOCATE_ANON.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/uapi/linux/mman.h |  9 +++++----
 mm/mremap.c               | 35 ++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index d0542f872e0c..a61dbe1e8b2b 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -6,10 +6,11 @@
 #include <asm-generic/hugetlb_encode.h>
 #include <linux/types.h>
 
-#define MREMAP_MAYMOVE		1
-#define MREMAP_FIXED		2
-#define MREMAP_DONTUNMAP	4
-#define MREMAP_RELOCATE_ANON	8
+#define MREMAP_MAYMOVE			1
+#define MREMAP_FIXED			2
+#define MREMAP_DONTUNMAP		4
+#define MREMAP_RELOCATE_ANON		8
+#define MREMAP_MUST_RELOCATE_ANON	16
 
 #define OVERCOMMIT_GUESS		0
 #define OVERCOMMIT_ALWAYS		1
diff --git a/mm/mremap.c b/mm/mremap.c
index bb67562a0114..f104147cd66d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1352,14 +1352,18 @@ static void unmap_source_vma(struct vma_remap_struct *vrm)
  * is being moved to by updating index and mapping fields accordingly?
  */
 static bool should_relocate_anon(struct vma_remap_struct *vrm,
-	struct pagetable_move_control *pmc)
+	struct pagetable_move_control *pmc, int *errp)
 {
 	struct vm_area_struct *old = vrm->vma;
 
 	/* Currently we only do this if requested. */
-	if (!(vrm->flags & MREMAP_RELOCATE_ANON))
+	if (!(vrm->flags & (MREMAP_RELOCATE_ANON | MREMAP_MUST_RELOCATE_ANON)))
 		return false;
 
+	/* Failures are fatal in the 'must' case. */
+	if (vrm->flags & MREMAP_MUST_RELOCATE_ANON)
+		*errp = -EFAULT;
+
 	/* We can't deal with special or hugetlb mappings. */
 	if (old->vm_flags & (VM_SPECIAL | VM_HUGETLB))
 		return false;
@@ -1368,10 +1372,6 @@ static bool should_relocate_anon(struct vma_remap_struct *vrm,
 	if (!vma_is_anonymous(old))
 		return false;
 
-	/* If no folios are mapped, then no need to attempt this. */
-	if (!old->anon_vma)
-		return false;
-
 	/*
 	 * If the old VMA is a child (i.e. has been forked), then the index
 	 * references multiple VMAs, we have to bail.
@@ -1379,6 +1379,13 @@ static bool should_relocate_anon(struct vma_remap_struct *vrm,
 	if (!list_is_singular(&old->anon_vma_chain))
 		return false;
 
+	/* Below issues are non-fatal in 'must' case. */
+	*errp = 0;
+
+	/* If no folios are mapped, then no need to attempt this. */
+	if (!old->anon_vma)
+		return false;
+
 	/* Otherwise, we're good to go! */
 	return true;
 }
@@ -1402,7 +1409,10 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 	struct vm_area_struct *new_vma;
 	int err = 0;
 	PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->old_len);
-	bool relocate_anon = should_relocate_anon(vrm, &pmc);
+	bool relocate_anon = should_relocate_anon(vrm, &pmc, &err);
+
+	if (err)
+		return err;
 
 again:
 	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
@@ -1440,6 +1450,12 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 
 			do_munmap(current->mm, start, size, NULL);
 			relocate_anon = false;
+			if (vrm->flags & MREMAP_MUST_RELOCATE_ANON) {
+				vrm_uncharge(vrm);
+				*new_vma_ptr = NULL;
+				return -EFAULT;
+			}
+
 			goto again;
 		}
 	}
@@ -1794,7 +1810,7 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 
 	/* Ensure no unexpected flag values. */
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP |
-		      MREMAP_RELOCATE_ANON))
+		      MREMAP_RELOCATE_ANON | MREMAP_MUST_RELOCATE_ANON))
 		return -EINVAL;
 
 	/* Start address must be page-aligned. */
@@ -1810,7 +1826,8 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 		return -EINVAL;
 
 	/* We can't relocate without allowing a move. */
-	if ((flags & MREMAP_RELOCATE_ANON) && !(flags & MREMAP_MAYMOVE))
+	if ((flags & (MREMAP_RELOCATE_ANON | MREMAP_MUST_RELOCATE_ANON)) &&
+	     !(flags & MREMAP_MAYMOVE))
 		return -EINVAL;
 
 	/* Remainder of checks are for cases with specific new_addr. */
-- 
2.48.1


