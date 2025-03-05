Return-Path: <linux-kernel+bounces-547516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800A7A50A55
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC419169588
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568F3253345;
	Wed,  5 Mar 2025 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GBG6e8xq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z/AmAJvJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120F253F07
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200765; cv=fail; b=mK+yFSTDjKK8P2NYWKICmj13xU5gdoB4vo2PKUwg+b0p3D2VxxDojbKj3SO/iWrkiotB6bJbeO2ljrLQk6I9q0kJzl9mQmNb1SWSDKbzyESbz7AoGrqNbAbhEAZ7uPAzn3qfapGispIG3qpTvZvc4g6xXZZe04oDU3u3FeFzPo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200765; c=relaxed/simple;
	bh=hxEkOI5kOyupn7Nycl5q1Cgfo28E+H9AVMR85ZXHYP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K2dY9F2Z6EjTcxpp5OzplMt8x7m5cdL7Sd92aNI6ILBvE0HnGJ9annOwVsX2sed3sepZdAhapiQsxz/lJQkhmIGoDec8cECZeFHrH10VA5EfiuI83IKWgvbSl45jhfHlH4dS9kTLMbvKjQVuC4tk6UMC2iCssHNHHaOWbl0fmJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GBG6e8xq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z/AmAJvJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMf5D019556;
	Wed, 5 Mar 2025 18:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zilieHDo6l+wjc/qCs
	SnBAISq+VEIiqbkq+tpccPY2g=; b=GBG6e8xqpayanwsDpLUQWY7XRDR2frLQeq
	CrHvTCoQCD618IHaex6n4FBHtSuW7ZoHkWydwtK1g8ENX373Ivt2FqnjOWHtCezu
	5qnJDLcX8q6MuiSAGajJs8c2Y8j9eengurMayq01H/Q8/dlrY3rJWrPtHOJcpqiI
	0onIHd3WGDaGP1zGFHos/Z1fWoD31rgavzZyKK1jF3wUa1YCJIDMzJrq70f0RXYg
	mULiQragFcX//m2Iqpm8wP0OQ2mmK1PLg7igPeMyR06fVxEnBGuoL19SJBWj3dSO
	Cg+9ZfOfjLMDmM+Jbjb9sCW98hj1PcWdefJcGYDvdLDnQshL1Wyw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uaw09kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 18:52:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525H92RW010911;
	Wed, 5 Mar 2025 18:52:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpcbpm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 18:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vB+QpXOYTriA4eIl42OJNz/qlYYiDSIstlafD2hBd7JMMoA1YmNLYflI5pzLrKRk9mnQt+N8n2YP2OsXOpGPFegYNSxjNKqom3m8uWkjIHFafwWUfiyt0rpCKRmj6xcr071g1x5HJfbUYhxpA6bf9T+K/LkinACoGDKptawf4slnFYcQGpPnxTA2pCojLdYac7SymHv6TeL3KUCd/Xf9BovDbZ9nhtJ7mQa5mUgK6gFfKZovUDBLhtRcZSZifj+8Wjh7zGIM0wqtMU7u7d7GtMsVXgldLSKk73uDHbQmVoqMkubI13gLEGqE73a9JOU31I8QsA5xPF+R/BCgNgKfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zilieHDo6l+wjc/qCsSnBAISq+VEIiqbkq+tpccPY2g=;
 b=cfzbBz0SnP9PLFxt/uSm7e9Tlp+lQiMW+t7lYY+Oup3PHvxmQP4f2uGEOaid2QLcfqx7xli0NVBbLYonIo02k/q8BgYdXF2X36K3ig+Ni2m6Ckss6lCs4aCyB5zQHpW7WGTK126Snx0QLsYiEtuTTCBhXlAdok+W4HbmnudP36r2bNL/ZYvbBkA+uAYn0i+PRkTTZTclnlk9vT8/rZGZ4tgJNW+HNPbzgtOkiLLF7MdfFtRSX377wFoAD7fbuccz76xKzhA0bwMCtZxip3OgPPma5neIXICbqSxLdOjdNfaBV+4+l2o/klN3EOW6QkIm3J0ej/Ts3jgVTyxJEqa8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zilieHDo6l+wjc/qCsSnBAISq+VEIiqbkq+tpccPY2g=;
 b=Z/AmAJvJ9OeRmGt52GanXWnc5oiYKmj2BpHPjxqJxVQfUMtENC+jkSyIDUbbhuvJcuvar6njH3ep9xp3jQJp+dYAQB085KUBlOZF95l3tWdSNipJ9E5/QlPAo6fp4OEuMHZCooLDwctDYglLclgCUM1arM6JbQ6e3197BVMzSw4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BN0PR10MB4998.namprd10.prod.outlook.com (2603:10b6:408:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 18:52:28 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 18:52:28 +0000
Date: Wed, 5 Mar 2025 13:52:10 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm/mremap: introduce and use vma_remap_struct
 threaded state
Message-ID: <pvhatbfbdi2ehl7lza6yoxaorfvknqcdocc3yrdjxzgkuayser@uwqhf67ofatq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <665d51a5bf1002e84d76733ab313fe304ff73f65.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665d51a5bf1002e84d76733ab313fe304ff73f65.1740911247.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BN0PR10MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2d8780-5195-4ebb-e7d7-08dd5c16e043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2g5qpyGNidjukGNxwctTZcUKNvexlJZYPq2UD+HIEDIfA5eZV9YgeMQk1RLm?=
 =?us-ascii?Q?AVEIpGPyfjZXsyN1oyFLS/zbq+qGxgv61LsGsSaARnfAH/JRZEYZVYURS3li?=
 =?us-ascii?Q?O5xhVl5tLCdUJvK8HgEKwFIJFh0Zp9aLN8UgQHxBbgao4/Vd/CMa2umPUGYL?=
 =?us-ascii?Q?4QwiwHN7p1TiyZ6tWcx/WUniaOLru2pRbjDmEP4Rh3ZCUftmUR4l1Tea+57K?=
 =?us-ascii?Q?3oc5YtBsVeUwNYhAyXjX9fvfeTvm+uFENpPn1M8scaf7Vm9JXuY+MmJJZX+e?=
 =?us-ascii?Q?1xdxL0Ym5aRcbDgMpsCA3xQXIWP3teGhzISd2fCJAWmMu/GVyDPP19CYf5cg?=
 =?us-ascii?Q?50sruBdcNd4vzlfPS1mpppRqfjWKGuit2PjfBe7uZMb6DGZMzlEsz3ZTr4nB?=
 =?us-ascii?Q?8oF8EGOoD886vjgqfBwcNpg9rfskkXZJDNVeIegYqCjRT8+6Xy5rDJaxliuo?=
 =?us-ascii?Q?LaaDtt7gnn5tCYrHu1/5iWJdWlOZdm4TPoagj4nmmqD4CZFg3GKBlNyIa/fF?=
 =?us-ascii?Q?YJQ6B4EmYNFeiFhXnkFLjNEUP0tmkK15tJsl3Z8Z7Hvo4Jh+3cTtCUQVWvhJ?=
 =?us-ascii?Q?Rw4voxq8HQ69MFHv/pfJuck+PW17u1/Ne6KEJSax1b8UJmtE5QvxXHCeE2J3?=
 =?us-ascii?Q?hHMa/loWVxCdW1IV8xRm9QHpFa/4Ql6Sucnt4xKmC1xjvZ7k873C6ZAPBiPa?=
 =?us-ascii?Q?IJLUrqMg6Atfy74QBqgvnArrCOK+udDYuU3HXRiEwqxTjhU9WoRz31iPZV+I?=
 =?us-ascii?Q?CO2BpXkK+BRBRBvwI8x/TgMxa17IeYeFwD49AORUtXcLKGQp1e/DLY5bqubh?=
 =?us-ascii?Q?fl30Je9GPqgfwKOJl+NRFw6jkJMz6yntNEEwND9zjYJBNFrqHQWoQezo3Bh+?=
 =?us-ascii?Q?QlT9bd3e7cmatsgUdwhC4Ty4swguEXIMFoaxApbW9dQcoLZDOV16NlJDHXRg?=
 =?us-ascii?Q?vZKiRqxVGhClIsls7Wr1Qq2xupRLIfYd6PVDZGlPt0fi0JKOjSfi0oXcSjcE?=
 =?us-ascii?Q?Evqb3XsgQv45F4JUnTk8aSMiOJczBLeEmAm0Lf5nydYoyx0NJ2oNI45ldfYG?=
 =?us-ascii?Q?EitlGXWu55X7c3pc1YdJr8GbsJa6k6u2GSym/Wwq6q6SsT96ANDUPB/8M7gf?=
 =?us-ascii?Q?f1BVeh/myf0Ly+39sGLIU/uUcYJRzgAF0OaDT4XMDnvFSPC31Pl3uPzpX5Uh?=
 =?us-ascii?Q?dNYbVpv1lC3JFcWx1bJs7YBuzJoe59PO1mOWY7rvzvyKMMoKZI4ddDH1yHrp?=
 =?us-ascii?Q?SoXzsSgJitCgjMXMTtJQytFkoLDokDGd6WkqzqN1r07ia/ikdGx87qBq6Umy?=
 =?us-ascii?Q?9Nkj8FdpNLxpMaTvQcQUjE9N+WFua7kX4Gmy+BzKXmCzw7EeI+pzauVbacls?=
 =?us-ascii?Q?BeuWR+446tYviTU53OLPJjIpwRKm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sEgu4knpKO/HuVechAx0mD5jcPDebXT7oivm1odPQ11SgXh3ageIFhsjLJLJ?=
 =?us-ascii?Q?poGQBGAd/q+LX49WxztqA+PXNifdDOIH+3Qk2J4WPZ7wuEaHWCFLayw6E/U1?=
 =?us-ascii?Q?r7Op2efqljvT51OUyZ6qCa5RkD141awj36gdPUB0ren0jkeb2A0zGXxw6YiQ?=
 =?us-ascii?Q?zbfqro827AE0+95YwrgkWZpbtlJRaIaLeVrS+i5SMO8DykGCWyIzW1gnWOJZ?=
 =?us-ascii?Q?JFZ1MkOkyJofIVtqH7tnudkNb27o3TQu0Yw6vjNwJBq2Pi0evA4Grz20oDZW?=
 =?us-ascii?Q?Eru6LfxMBBCYaSw9xN8kpHEuVZOOTWMj+QqM2gzH+9IYPpVdbRI6DLHb1WZ8?=
 =?us-ascii?Q?/EnnOTb9XnNGSKOBIF5GNoVmJ1lADaDTPEHR5CzR0rsefp0HLpHNq++eyi4h?=
 =?us-ascii?Q?2SgiK0s80cP5t6xsP98xxfjFt0PYoSUA/++xrtR6ilLsm6iIbckAAEOJdU90?=
 =?us-ascii?Q?Bb8b0MXUMnt/O0FCrruC2OuMURBhdygHJyjrWH4Aeq4o0o8Oo1Gf9l+ZBCC2?=
 =?us-ascii?Q?SJN55eohwvI7Vr/qWaYMCwhRQaXYyG4GNjwj/+aVxF6x/2JH2/kZR8kF1+Ss?=
 =?us-ascii?Q?sNOIjky9i87rGIlYNvql1daO6I804FSjLqUCsVWFIVjf00LTXAHo623sq8tU?=
 =?us-ascii?Q?gJBtD/gJPlbXRMbtjppAaBgf1D6s2Rq/bOhxwmMKA6hjnUPJLYByXfRid92V?=
 =?us-ascii?Q?fRBZNM2WiD55qMtoLzG6wt7CZWFHSsCRpkdXiKMRN0/shUgPks84/NtvZK0b?=
 =?us-ascii?Q?J61JiOF/BgKYdCX/VdRyTxTcIj3HR5Ykzah9rlBdQxYRqLZHIHhqR09eG2cL?=
 =?us-ascii?Q?w4ubNldTHR3OztUWk8lDW9ZVS1tY0tBSHHGM/e1yopfHJpesWWumyzn/jSY5?=
 =?us-ascii?Q?TMoobf13UBEKBj9XzmMGkOHJUwf/BC1aZYteNwC7f2yaXFnPXSrWsvEQpsVh?=
 =?us-ascii?Q?HuIZ0QxT+nxlfAQXMAhJQ9sqwmuRPAX+2WYuxDVpeM449h/1JlolSWhxZLsN?=
 =?us-ascii?Q?kcW89rup8v+gfAsKMG6HbBS5hYs5EQ0R1xavsE3yokpqKNopWEsjsKBgQo61?=
 =?us-ascii?Q?BTlSPMKOGLTR8iA3KPwsuqQ9spVhiG/wi9h/pqk4/6mlxmQ3e9LhPk4qwtYq?=
 =?us-ascii?Q?vqG5OFR9Ge8xAbETdEfc67LFkyqJJjqACck0okskCCp2v2u3drLpaS/QzKYC?=
 =?us-ascii?Q?rR2hblKFsHjyLNSotiONIYbe+Fg4OqDQwb9ohoDuLaCD9mZ6mzSXlUdGTTR/?=
 =?us-ascii?Q?pK2vTI1Vh47fwTq2IQIHYDaNcz7Uch6Cp0T49NfR3swFxKVxgb3HEpjHvseq?=
 =?us-ascii?Q?6d9u+Mhwr4cdk+daXB3Z20LYVV9xitDSlELLrAbEqX+Q8tX+HM2NPKf/5C23?=
 =?us-ascii?Q?fcs3cT6erBL+DJ/B5ToHuTha7QnxUeDmokdy2wyAcaZgb4WYeEnLZXJH5gjD?=
 =?us-ascii?Q?ZAj06UhJvSeC2PQsW9mlHtAZxkrOCaxkSwZLcGvb1nlntjjUFdV7JvoDU5bU?=
 =?us-ascii?Q?7KMkNiEumNRHL1pLp0oU0WqzS6mGldKHqM1E3SlCfmtT31qPS8O30t2nVyiT?=
 =?us-ascii?Q?T9GEMsU095FPLIwRRMrUGyr0UE7w+Y+6EjDF2XdU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lXNcb1+O/3YV/nsKgZLkESOACADGJmr5Ww4TqYKJFNvlsO08PNnAin7A7N5hEHyiDbQEnUxIRUDlkvRSjkF6/wv2Np7OQlHhk3wCIULmtJZAN44JWLSxI5V++qIDT85JVvwW5M2rVCOjYMP2tg/L1izdL5fiI46UUWngNmZhYNF30klyo9kNxWGbUvbuPbDvuyukJmVr4Mn7XiP9GXZR7bgLhjMBA0JSGNHDFXA8Jt2/WCMVqvOERRC2jNkVniXTSFijDh35gldbXODL78kbahAYyEhwVgaB2nn7HhT6B6HvanXjm3khap8NC9yBStNQ3f1W1wyiOMmqaJXIjDfUQKs6azFgX6YR38kAgDUqZmXiW8VRySATkQPMQ/eDrVo3bUAAA+j9oE8M3KMY/7oNkrmH8nWDkjx93CA/TXXR1Xbh04z22Xjxyv6uTJUO0pHXQo9oL2ivRQYy7G6dv+caBhprUTpTpdWa3kTDNCdLTSXnu7nytDazHEA4y271z2PnXWdECsgH9ZlNGIVGuFANZ4tyypbBd6aMT0v2r6wfsn+HR7QSiOIYxol+Ae0mItAKVYW1E6uGsUca1w9zTJXIyvvpADy/bu3YfOEUHZ4zu0Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2d8780-5195-4ebb-e7d7-08dd5c16e043
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 18:52:28.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4S/F+MdrcloTi6u1Bm6T1gd6TEGdWSENire0NSlZR6LBFsYmQuU2DDlMwv5YM0eQltl/uSQKNHMQ+pc6hRp6sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050144
X-Proofpoint-GUID: VMpdrt5kTlkHwtFfJbH4G-_kEJO74FJ7
X-Proofpoint-ORIG-GUID: VMpdrt5kTlkHwtFfJbH4G-_kEJO74FJ7

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250303 06:08]:
> A number of mremap() calls both pass around and modify a large number of
> parameters, making the code less readable and often repeatedly having to
> determine things such as VMA, size delta, and more.
> 
> Avoid this by using the common pattern of passing a state object through
> the operation, updating it as we go. We introduce the vma_remap_struct or
> 'VRM' for this purpose.
> 
> This also gives us the ability to accumulate further state through the
> operation that would otherwise require awkward and error-prone pointer
> passing.
> 
> We can also now trivially define helper functions that operate on a VRM
> object.
> 
> This pattern has proven itself to be very powerful when implemented for VMA
> merge, VMA unmapping and memory mapping operations, so it is battle-tested
> and functional.
> 
> We both introduce the data structure and use it, introducing helper
> functions as needed to make things readable, we move some state such as
> mmap lock and mlock() status to the VRM, we introduce a means of
> classifying the type of mremap() operation and de-duplicate the
> get_unmapped_area() lookup.
> 
> We also neatly thread userfaultfd state throughout the operation.
> 
> Note that there is further refactoring to be done, chiefly adjust
> move_vma() to accept a VRM parameter. We defer this as there is
> pre-requisite work required to be able to do so which we will do in a
> subsequent patch.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mremap.c | 559 +++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 354 insertions(+), 205 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index c4abda8dfc57..7f0c71aa9bb9 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -32,6 +32,43 @@
>  
>  #include "internal.h"
>  
> +/* Classify the kind of remap operation being performed. */
> +enum mremap_operation {
> +	MREMAP_NO_RESIZE, /* old_len == new_len, if not moved, do nothing. */
> +	MREMAP_SHRINK, /* old_len > new_len. */
> +	MREMAP_EXPAND, /* old_len < new_len. */

Can we fix the spacing so the comments line up, please?

It might be worth having a MREMAP_INVALID here and init to that, then a
VM_BUG_ON(), but maybe I'm just paranoid.

> +};
> +
> +/*
> + * Describes a VMA mremap() operation and is threaded throughout it.
> + *
> + * Any of the fields may be mutated by the operation, however these values will
> + * always accurately reflect the remap (for instance, we may adjust lengths and
> + * delta to account for hugetlb alignment).
> + */
> +struct vma_remap_struct {
> +	/* User-provided state. */
> +	unsigned long addr; /* User-specified address from which we remap. */
> +	unsigned long old_len; /* Length of range being remapped. */
> +	unsigned long new_len; /* Desired new length of mapping. */
> +	unsigned long flags; /* user-specified MREMAP_* flags. */
> +	unsigned long new_addr; /* Optionally, desired new address. */

Same comment about the comment spacing here.  Might be better to have
user_flags?  Since we have the passed in flags, the map flags and the
vma flags.

> +
> +	/* uffd state. */
> +	struct vm_userfaultfd_ctx *uf;
> +	struct list_head *uf_unmap_early;
> +	struct list_head *uf_unmap;

... sigh, yeah.

> +
> +	/* VMA state, determined in do_mremap(). */
> +	struct vm_area_struct *vma;
> +
> +	/* Internal state, determined in do_mremap(). */
> +	unsigned long delta; /* Absolute delta of old_len, new_len. */
> +	bool locked; /* Was the VMA mlock()'d (has the VM_LOCKED flag set). */

bool mlocked ?

> +	enum mremap_operation remap_type; /* expand, shrink, etc. */
> +	bool mmap_locked; /* Is current->mm currently write-locked? */
> +};
> +
>  static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
>  {
>  	pgd_t *pgd;
> @@ -693,6 +730,97 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  	return len + old_addr - old_end;	/* how much done */
>  }
>  
> +/* Set vrm->delta to the difference in VMA size specified by user. */
> +static void vrm_set_delta(struct vma_remap_struct *vrm)
> +{
> +	vrm->delta = abs_diff(vrm->old_len, vrm->new_len);
> +}
> +
> +/* Determine what kind of remap this is - shrink, expand or no resize at all. */
> +static enum mremap_operation vrm_remap_type(struct vma_remap_struct *vrm)
> +{
> +	if (vrm->delta == 0)
> +		return MREMAP_NO_RESIZE;
> +
> +	if (vrm->old_len > vrm->new_len)
> +		return MREMAP_SHRINK;
> +
> +	return MREMAP_EXPAND;
> +}
> +
> +/* Set the vrm->remap_type, assumes state is sufficient set up for this. */
> +static void vrm_set_remap_type(struct vma_remap_struct *vrm)
> +{
> +	vrm->remap_type = vrm_remap_type(vrm);

The vrm_remap_type() function is only used once, maybe we don't need
both set and get?

> +}
> +
> +/*
> + * When moving a VMA to vrm->new_adr, does this result in the new and old VMAs
> + * overlapping?
> + */
> +static bool vrm_overlaps(struct vma_remap_struct *vrm)
> +{
> +	unsigned long start_old = vrm->addr;
> +	unsigned long start_new = vrm->new_addr;
> +	unsigned long end_old = vrm->addr + vrm->old_len;
> +	unsigned long end_new = vrm->new_addr + vrm->new_len;
> +
> +	/*
> +	 * start_old    end_old
> +	 *     |-----------|
> +	 *     |           |
> +	 *     |-----------|
> +	 *             |-------------|
> +	 *             |             |
> +	 *             |-------------|
> +	 *         start_new      end_new
> +	 */
> +	if (end_old > start_new && end_new > start_old)
> +		return true;
> +
> +	return false;
> +}
> +
> +/* Do the mremap() flags require that the new_addr parameter be specified? */
> +static bool vrm_implies_new_addr(struct vma_remap_struct *vrm)
> +{
> +	return vrm->flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
> +}

These five might benefit from being inlined (although I hope our
compiler is good enough for this).

> +
> +/*
> + * Find an unmapped area for the requested vrm->new_addr.
> + *
> + * If MREMAP_FIXED then this is equivalent to a MAP_FIXED mmap() call. If only
> + * MREMAP_DONTUNMAP is set, then this is equivalent to providing a hint to
> + * mmap(), otherwise this is equivalent to mmap() specifying a NULL address.
> + *
> + * Returns 0 on success (with vrm->new_addr updated), or an error code upon
> + * failure.
> + */
> +static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
> +{
> +	struct vm_area_struct *vma = vrm->vma;
> +	unsigned long map_flags = 0;
> +	/* Page Offset _into_ the VMA. */
> +	pgoff_t internal_pgoff = (vrm->addr - vma->vm_start) >> PAGE_SHIFT;
> +	pgoff_t pgoff = vma->vm_pgoff + internal_pgoff;
> +	unsigned long new_addr = vrm_implies_new_addr(vrm) ? vrm->new_addr : 0;
> +	unsigned long res;
> +
> +	if (vrm->flags & MREMAP_FIXED)
> +		map_flags |= MAP_FIXED;
> +	if (vma->vm_flags & VM_MAYSHARE)
> +		map_flags |= MAP_SHARED;
> +
> +	res = get_unmapped_area(vma->vm_file, new_addr, vrm->new_len, pgoff,
> +				map_flags);
> +	if (IS_ERR_VALUE(res))
> +		return res;
> +
> +	vrm->new_addr = res;
> +	return 0;
> +}
> +
>  static unsigned long move_vma(struct vm_area_struct *vma,
>  		unsigned long old_addr, unsigned long old_len,
>  		unsigned long new_len, unsigned long new_addr,
> @@ -860,18 +988,15 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>   * resize_is_valid() - Ensure the vma can be resized to the new length at the give
>   * address.
>   *
> - * @vma: The vma to resize
> - * @addr: The old address
> - * @old_len: The current size
> - * @new_len: The desired size
> - * @flags: The vma flags
> - *
>   * Return 0 on success, error otherwise.
>   */
> -static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
> -	unsigned long old_len, unsigned long new_len, unsigned long flags)
> +static int resize_is_valid(struct vma_remap_struct *vrm)
>  {
>  	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma = vrm->vma;
> +	unsigned long addr = vrm->addr;
> +	unsigned long old_len = vrm->old_len;
> +	unsigned long new_len = vrm->new_len;
>  	unsigned long pgoff;
>  
>  	/*
> @@ -883,11 +1008,12 @@ static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
>  	 * behavior.  As a result, fail such attempts.
>  	 */
>  	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
> -		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n", current->comm, current->pid);
> +		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
> +			     current->comm, current->pid);
>  		return -EINVAL;
>  	}
>  
> -	if ((flags & MREMAP_DONTUNMAP) &&
> +	if ((vrm->flags & MREMAP_DONTUNMAP) &&
>  			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
>  		return -EINVAL;
>  
> @@ -907,99 +1033,114 @@ static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
>  	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
>  		return -EFAULT;
>  
> -	if (!mlock_future_ok(mm, vma->vm_flags, new_len - old_len))
> +	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
>  		return -EAGAIN;
>  
> -	if (!may_expand_vm(mm, vma->vm_flags,
> -				(new_len - old_len) >> PAGE_SHIFT))
> +	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
>  		return -ENOMEM;
>  
>  	return 0;
>  }
>  
>  /*
> - * mremap_to() - remap a vma to a new location
> - * @addr: The old address
> - * @old_len: The old size
> - * @new_addr: The target address
> - * @new_len: The new size
> - * @locked: If the returned vma is locked (VM_LOCKED)
> - * @flags: the mremap flags
> - * @uf: The mremap userfaultfd context
> - * @uf_unmap_early: The userfaultfd unmap early context
> - * @uf_unmap: The userfaultfd unmap context
> + * The user has requested that the VMA be shrunk (i.e., old_len > new_len), so
> + * execute this, optionally dropping the mmap lock when we do so.
>   *
> + * In both cases this invalidates the VMA, however if we don't drop the lock,
> + * then load the correct VMA into vrm->vma afterwards.
> + */
> +static unsigned long shrink_vma(struct vma_remap_struct *vrm,
> +				bool drop_lock)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long unmap_start = vrm->addr + vrm->new_len;
> +	unsigned long unmap_bytes = vrm->delta;
> +	unsigned long res;
> +	VMA_ITERATOR(vmi, mm, unmap_start);
> +
> +	VM_BUG_ON(vrm->remap_type != MREMAP_SHRINK);
> +
> +	res = do_vmi_munmap(&vmi, mm, unmap_start, unmap_bytes,
> +			    vrm->uf_unmap, drop_lock);
> +	vrm->vma = NULL; /* Invalidated. */
> +	if (res)
> +		return res;
> +
> +	/*
> +	 * If we've not dropped the lock, then we should reload the VMA to
> +	 * replace the invalidated VMA with the one that may have now been
> +	 * split.
> +	 */
> +	if (drop_lock)
> +		vrm->mmap_locked = false;
> +	else
> +		vrm->vma = vma_lookup(mm, vrm->addr);
> +
> +	return 0;
> +}
> +
> +/*
> + * mremap_to() - remap a vma to a new location.
>   * Returns: The new address of the vma or an error.
>   */
> -static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
> -		unsigned long new_addr, unsigned long new_len, bool *locked,
> -		unsigned long flags, struct vm_userfaultfd_ctx *uf,
> -		struct list_head *uf_unmap_early,
> -		struct list_head *uf_unmap)
> +static unsigned long mremap_to(struct vma_remap_struct *vrm)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma;
> -	unsigned long ret;
> -	unsigned long map_flags = 0;
> +	unsigned long err;
>  
>  	/* Is the new length or address silly? */
> -	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> +	if (vrm->new_len > TASK_SIZE ||
> +	    vrm->new_addr > TASK_SIZE - vrm->new_len)
>  		return -EINVAL;
>  
> -	/* Ensure the old/new locations do not overlap. */
> -	if (addr + old_len > new_addr && new_addr + new_len > addr)
> +	if (vrm_overlaps(vrm))
>  		return -EINVAL;
>  
> -	if (flags & MREMAP_FIXED) {
> +	if (vrm->flags & MREMAP_FIXED) {
>  		/*
>  		 * In mremap_to().
>  		 * VMA is moved to dst address, and munmap dst first.
>  		 * do_munmap will check if dst is sealed.
>  		 */
> -		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
> -		if (ret)
> -			return ret;
> -	}
> +		err = do_munmap(mm, vrm->new_addr, vrm->new_len,
> +				vrm->uf_unmap_early);
> +		vrm->vma = NULL; /* Invalidated. */
> +		if (err)
> +			return err;
>  
> -	if (old_len > new_len) {
> -		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
> -		if (ret)
> -			return ret;
> -		old_len = new_len;
> +		/*
> +		 * If we remap a portion of a VMA elsewhere in the same VMA,
> +		 * this can invalidate the old VMA and iterator. Reset.
> +		 */
> +		vrm->vma = vma_lookup(mm, vrm->addr);

You say it invalidates the iterator, but this doesn't change an
iterator?

>  	}
>  
> -	vma = vma_lookup(mm, addr);
> -	if (!vma)
> -		return -EFAULT;
> +	if (vrm->remap_type == MREMAP_SHRINK) {
> +		err = shrink_vma(vrm, /* drop_lock= */false);

It is not immediately clear if we could have a MREMAP_FIXED also
MREMAP_SHRINK.  In that case, we would try to do_munmap() twice.  This
shouldn't be an issue as do_vmi_munmap() would catch it, but I am not
sure if you noticed this.

> +		if (err)
> +			return err;
>  
> -	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
> -	if (ret)
> -		return ret;
> +		/* Set up for the move now shrink has been executed. */
> +		vrm->old_len = vrm->new_len;
> +	}
> +
> +	err = resize_is_valid(vrm);
> +	if (err)
> +		return err;
>  
>  	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
> -	if (flags & MREMAP_DONTUNMAP &&
> -		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
> +	if (vrm->flags & MREMAP_DONTUNMAP &&
> +		!may_expand_vm(mm, vrm->vma->vm_flags, vrm->old_len >> PAGE_SHIFT)) {
>  		return -ENOMEM;

nit: whitespace here is a bit odd to read.

>  	}
>  
> -	if (flags & MREMAP_FIXED)
> -		map_flags |= MAP_FIXED;
> -
> -	if (vma->vm_flags & VM_MAYSHARE)
> -		map_flags |= MAP_SHARED;
> -
> -	ret = get_unmapped_area(vma->vm_file, new_addr, new_len, vma->vm_pgoff +
> -				((addr - vma->vm_start) >> PAGE_SHIFT),
> -				map_flags);
> -	if (IS_ERR_VALUE(ret))
> -		return ret;
> -
> -	/* We got a new mapping */
> -	if (!(flags & MREMAP_FIXED))
> -		new_addr = ret;
> +	err = vrm_set_new_addr(vrm);
> +	if (err)
> +		return err;
>  
> -	return move_vma(vma, addr, old_len, new_len, new_addr, locked, flags,
> -			uf, uf_unmap);
> +	return move_vma(vrm->vma, vrm->addr, vrm->old_len, vrm->new_len,
> +			vrm->new_addr, &vrm->locked, vrm->flags,
> +			vrm->uf, vrm->uf_unmap);

I see where this is going..

>  }
>  
>  static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
> @@ -1016,22 +1157,33 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
>  	return 1;
>  }
>  
> -/* Do the mremap() flags require that the new_addr parameter be specified? */
> -static bool implies_new_addr(unsigned long flags)
> +/* Determine whether we are actually able to execute an in-place expansion. */
> +static bool vrm_can_expand_in_place(struct vma_remap_struct *vrm)
>  {
> -	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
> +	/* Number of bytes from vrm->addr to end of VMA. */
> +	unsigned long suffix_bytes = vrm->vma->vm_end - vrm->addr;
> +
> +	/* If end of range aligns to end of VMA, we can just expand in-place. */
> +	if (suffix_bytes != vrm->old_len)
> +		return false;
> +
> +	/* Check whether this is feasible. */
> +	if (!vma_expandable(vrm->vma, vrm->delta))
> +		return false;
> +
> +	return true;
>  }
>  
>  /*
>   * Are the parameters passed to mremap() valid? If so return 0, otherwise return
>   * error.
>   */
> -static unsigned long check_mremap_params(unsigned long addr,
> -					 unsigned long flags,
> -					 unsigned long old_len,
> -					 unsigned long new_len,
> -					 unsigned long new_addr)
> +static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
> +
>  {
> +	unsigned long addr = vrm->addr;
> +	unsigned long flags = vrm->flags;
> +
>  	/* Ensure no unexpected flag values. */
>  	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
>  		return -EINVAL;
> @@ -1045,15 +1197,15 @@ static unsigned long check_mremap_params(unsigned long addr,
>  	 * for DOS-emu "duplicate shm area" thing. But
>  	 * a zero new-len is nonsensical.
>  	 */
> -	if (!PAGE_ALIGN(new_len))
> +	if (!PAGE_ALIGN(vrm->new_len))
>  		return -EINVAL;
>  
>  	/* Remainder of checks are for cases with specific new_addr. */
> -	if (!implies_new_addr(flags))
> +	if (!vrm_implies_new_addr(vrm))
>  		return 0;
>  
>  	/* The new address must be page-aligned. */
> -	if (offset_in_page(new_addr))
> +	if (offset_in_page(vrm->new_addr))
>  		return -EINVAL;
>  
>  	/* A fixed address implies a move. */
> @@ -1061,7 +1213,7 @@ static unsigned long check_mremap_params(unsigned long addr,
>  		return -EINVAL;
>  
>  	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
> -	if (flags & MREMAP_DONTUNMAP && old_len != new_len)
> +	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
>  		return -EINVAL;
>  
>  	/*
> @@ -1090,11 +1242,11 @@ static unsigned long check_mremap_params(unsigned long addr,
>   * If we discover the VMA is locked, update mm_struct statistics accordingly and
>   * indicate so to the caller.
>   */
> -static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
> -					unsigned long delta, bool *locked)
> +static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
>  {
>  	struct mm_struct *mm = current->mm;
> -	long pages = delta >> PAGE_SHIFT;
> +	long pages = vrm->delta >> PAGE_SHIFT;
> +	struct vm_area_struct *vma = vrm->vma;
>  	VMA_ITERATOR(vmi, mm, vma->vm_end);
>  	long charged = 0;
>  
> @@ -1114,7 +1266,7 @@ static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
>  	 * adjacent to the expanded vma and otherwise
>  	 * compatible.
>  	 */
> -	vma = vma_merge_extend(&vmi, vma, delta);
> +	vma = vrm->vma = vma_merge_extend(&vmi, vma, vrm->delta);
>  	if (!vma) {
>  		vm_unacct_memory(charged);
>  		return -ENOMEM;
> @@ -1123,42 +1275,34 @@ static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
>  	vm_stat_account(mm, vma->vm_flags, pages);
>  	if (vma->vm_flags & VM_LOCKED) {
>  		mm->locked_vm += pages;
> -		*locked = true;
> +		vrm->locked = true;
>  	}
>  
>  	return 0;
>  }
>  
> -static bool align_hugetlb(struct vm_area_struct *vma,
> -			  unsigned long addr,
> -			  unsigned long new_addr,
> -			  unsigned long *old_len_ptr,
> -			  unsigned long *new_len_ptr,
> -			  unsigned long *delta_ptr)
> +static bool align_hugetlb(struct vma_remap_struct *vrm)
>  {
> -	unsigned long old_len = *old_len_ptr;
> -	unsigned long new_len = *new_len_ptr;
> -	struct hstate *h __maybe_unused = hstate_vma(vma);
> +	struct hstate *h __maybe_unused = hstate_vma(vrm->vma);
>  
> -	old_len = ALIGN(old_len, huge_page_size(h));
> -	new_len = ALIGN(new_len, huge_page_size(h));
> +	vrm->old_len = ALIGN(vrm->old_len, huge_page_size(h));
> +	vrm->new_len = ALIGN(vrm->new_len, huge_page_size(h));
>  
>  	/* addrs must be huge page aligned */
> -	if (addr & ~huge_page_mask(h))
> +	if (vrm->addr & ~huge_page_mask(h))
>  		return false;
> -	if (new_addr & ~huge_page_mask(h))
> +	if (vrm->new_addr & ~huge_page_mask(h))
>  		return false;
>  
>  	/*
>  	 * Don't allow remap expansion, because the underlying hugetlb
>  	 * reservation is not yet capable to handle split reservation.
>  	 */
> -	if (new_len > old_len)
> +	if (vrm->new_len > vrm->old_len)
>  		return false;
>  
> -	*old_len_ptr = old_len;
> -	*new_len_ptr = new_len;
> -	*delta_ptr = abs_diff(old_len, new_len);
> +	vrm_set_delta(vrm);
> +
>  	return true;
>  }
>  
> @@ -1169,19 +1313,16 @@ static bool align_hugetlb(struct vm_area_struct *vma,
>   * Try to do so in-place, if this fails, then move the VMA to a new location to
>   * action the change.
>   */
> -static unsigned long expand_vma(struct vm_area_struct *vma,
> -				unsigned long addr, unsigned long old_len,
> -				unsigned long new_len, unsigned long flags,
> -				bool *locked_ptr, unsigned long *new_addr_ptr,
> -				struct vm_userfaultfd_ctx *uf_ptr,
> -				struct list_head *uf_unmap_ptr)
> +static unsigned long expand_vma(struct vma_remap_struct *vrm)
>  {
>  	unsigned long err;
> -	unsigned long map_flags;
> -	unsigned long new_addr; /* We ignore any user-supplied one. */
> -	pgoff_t pgoff;
> +	struct vm_area_struct *vma = vrm->vma;
> +	unsigned long addr = vrm->addr;
> +	unsigned long old_len = vrm->old_len;
> +	unsigned long new_len = vrm->new_len;
> +	unsigned long flags = vrm->flags;
>  
> -	err = resize_is_valid(vma, addr, old_len, new_len, flags);
> +	err = resize_is_valid(vrm);
>  	if (err)
>  		return err;
>  
> @@ -1189,10 +1330,9 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
>  	 * [addr, old_len) spans precisely to the end of the VMA, so try to
>  	 * expand it in-place.
>  	 */
> -	if (old_len == vma->vm_end - addr &&
> -	    vma_expandable(vma, new_len - old_len)) {
> -		err = expand_vma_inplace(vma, new_len - old_len, locked_ptr);
> -		if (IS_ERR_VALUE(err))
> +	if (vrm_can_expand_in_place(vrm)) {
> +		err = expand_vma_in_place(vrm);
> +		if (err)
>  			return err;
>  
>  		/*
> @@ -1200,8 +1340,8 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
>  		 * satisfy the expectation that mlock()'ing a VMA maintains all
>  		 * of its pages in memory.
>  		 */
> -		if (*locked_ptr)
> -			*new_addr_ptr = addr;
> +		if (vrm->locked)
> +			vrm->new_addr = addr;
>  
>  		/* OK we're done! */
>  		return addr;
> @@ -1217,62 +1357,65 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
>  		return -ENOMEM;
>  
>  	/* Find a new location to move the VMA to. */
> -	map_flags = (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
> -	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> -	new_addr = get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_flags);
> -	if (IS_ERR_VALUE(new_addr))
> -		return new_addr;
> -	*new_addr_ptr = new_addr;
> +	err = vrm_set_new_addr(vrm);
> +	if (err)
> +		return err;
>  
> -	return move_vma(vma, addr, old_len, new_len, new_addr,
> -			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
> +	return move_vma(vma, addr, old_len, new_len, vrm->new_addr,
> +			&vrm->locked, flags, vrm->uf, vrm->uf_unmap);
>  }
>  
>  /*
> - * Expand (or shrink) an existing mapping, potentially moving it at the
> - * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
> - *
> - * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
> - * This option implies MREMAP_MAYMOVE.
> + * Attempt to resize the VMA in-place, if we cannot, then move the VMA to the
> + * first available address to perform the operation.
>   */
> -SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> -		unsigned long, new_len, unsigned long, flags,
> -		unsigned long, new_addr)
> +static unsigned long mremap_at(struct vma_remap_struct *vrm)

I hate this and mremap_to() names.  I don't have a proposed better name
for either and maybe it's just my experience with mremap_to() that has
tainted the view of the name itself, but I find them not very
descriptive and abruptly ended.  I guess move was already taken.

I also have the added baggage of parsing "at" to potentially mean
"doing".

mremap_inplace() seems equally annoying.  This is the worst bike shed.

> +{
> +	unsigned long res;
> +
> +	switch (vrm->remap_type) {
> +	case MREMAP_NO_RESIZE:
> +		/* NO-OP CASE - resizing to the same size. */
> +		return vrm->addr;
> +	case MREMAP_SHRINK:
> +		/*
> +		 * SHRINK CASE. Can always be done in-place.
> +		 *
> +		 * Simply unmap the shrunken portion of the VMA. This does all
> +		 * the needed commit accounting, and we indicate that the mmap
> +		 * lock should be dropped.
> +		 */
> +		res = shrink_vma(vrm, /* drop_lock= */true);
> +		if (res)
> +			return res;
> +
> +		return vrm->addr;
> +	case MREMAP_EXPAND:
> +		return expand_vma(vrm);
> +	}
> +
> +	BUG();
> +}
> +
> +static unsigned long do_mremap(struct vma_remap_struct *vrm)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	unsigned long ret;
> -	unsigned long delta;
> -	bool locked = false;
> -	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
> -	LIST_HEAD(uf_unmap_early);
> -	LIST_HEAD(uf_unmap);
>  
> -	/*
> -	 * There is a deliberate asymmetry here: we strip the pointer tag
> -	 * from the old address but leave the new address alone. This is
> -	 * for consistency with mmap(), where we prevent the creation of
> -	 * aliasing mappings in userspace by leaving the tag bits of the
> -	 * mapping address intact. A non-zero tag will cause the subsequent
> -	 * range checks to reject the address as invalid.
> -	 *
> -	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
> -	 * information.
> -	 */
> -	addr = untagged_addr(addr);
> -
> -	ret = check_mremap_params(addr, flags, old_len, new_len, new_addr);
> +	ret = check_mremap_params(vrm);
>  	if (ret)
>  		return ret;
>  
> -	old_len = PAGE_ALIGN(old_len);
> -	new_len = PAGE_ALIGN(new_len);
> -	delta = abs_diff(old_len, new_len);
> +	vrm->old_len = PAGE_ALIGN(vrm->old_len);
> +	vrm->new_len = PAGE_ALIGN(vrm->new_len);
> +	vrm_set_delta(vrm);
>  
>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
> +	vrm->mmap_locked = true;
>  
> -	vma = vma_lookup(mm, addr);
> +	vma = vrm->vma = vma_lookup(mm, vrm->addr);
>  	if (!vma) {
>  		ret = -EFAULT;
>  		goto out;
> @@ -1285,62 +1428,68 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	}
>  
>  	/* Align to hugetlb page size, if required. */
> -	if (is_vm_hugetlb_page(vma) &&
> -	    !align_hugetlb(vma, addr, new_addr, &old_len, &new_len, &delta)) {
> +	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	/* Are we RELOCATING the VMA to a SPECIFIC address? */
> -	if (implies_new_addr(flags)) {
> -		ret = mremap_to(addr, old_len, new_addr, new_len,
> -				&locked, flags, &uf, &uf_unmap_early,
> -				&uf_unmap);
> -		goto out;
> -	}
> +	vrm_set_remap_type(vrm);
>  
> -	/*
> -	 * From here on in we are only RESIZING the VMA, attempting to do so
> -	 * in-place, moving the VMA if we cannot.
> -	 */
> +	/* Actually execute mremap. */
> +	ret = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
>  
> -	/* NO-OP CASE - resizing to the same size. */
> -	if (new_len == old_len) {
> -		ret = addr;
> -		goto out;
> -	}
> -
> -	/* SHRINK CASE. Can always be done in-place. */
> -	if (new_len < old_len) {
> -		VMA_ITERATOR(vmi, mm, addr + new_len);
> +out:
> +	if (vrm->mmap_locked) {
> +		mmap_write_unlock(mm);
> +		vrm->mmap_locked = false;
>  
> -		/*
> -		 * Simply unmap the shrunken portion of the VMA. This does all
> -		 * the needed commit accounting, unlocking the mmap lock.
> -		 */
> -		ret = do_vmi_munmap(&vmi, mm, addr + new_len, delta,
> -				    &uf_unmap, true);
> -		if (ret)
> -			goto out;
> -
> -		/* We succeeded, mmap lock released for us. */
> -		ret = addr;
> -		goto out_unlocked;
> +		if (!offset_in_page(ret) && vrm->locked && vrm->new_len > vrm->old_len)
> +			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);

It isn't clear to me why we only populate if we are locked here.
Actually, I'm not sure why we keep holding the lock until here or why it
matters to drop it early.  The main reason we want to drop the lock is
to reduce the mmap lock time held for the populate operation.

So we can either drop the lock before we get here once the vma tree is
updated, or we can unconditionally unlock.

I think we can simplify this further if we just keep the lock held until
we downgrade here and populate if necessary after it's dropped.  That
is, shrink just does nothing with the lock and we just unlock it
regardless.

I'm pretty sure that we would struggle to measure the performance impact
holding the lock for the return path when the populate is removed from
the critical section.

>  	}
>  
> -	/* EXPAND case. We try to do in-place, if we can't, then we move it. */
> -	ret = expand_vma(vma, addr, old_len, new_len, flags, &locked, &new_addr,
> -			 &uf, &uf_unmap);
> +	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
> +	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
> +	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
>  
> -out:
> -	if (offset_in_page(ret))
> -		locked = false;
> -	mmap_write_unlock(mm);
> -	if (locked && new_len > old_len)
> -		mm_populate(new_addr + old_len, delta);
> -out_unlocked:
> -	userfaultfd_unmap_complete(mm, &uf_unmap_early);
> -	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
> -	userfaultfd_unmap_complete(mm, &uf_unmap);
>  	return ret;
>  }
> +
> +/*
> + * Expand (or shrink) an existing mapping, potentially moving it at the
> + * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
> + *
> + * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
> + * This option implies MREMAP_MAYMOVE.
> + */
> +SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> +		unsigned long, new_len, unsigned long, flags,
> +		unsigned long, new_addr)
> +{
> +	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
> +	LIST_HEAD(uf_unmap_early);
> +	LIST_HEAD(uf_unmap);
> +	/*
> +	 * There is a deliberate asymmetry here: we strip the pointer tag
> +	 * from the old address but leave the new address alone. This is
> +	 * for consistency with mmap(), where we prevent the creation of
> +	 * aliasing mappings in userspace by leaving the tag bits of the
> +	 * mapping address intact. A non-zero tag will cause the subsequent
> +	 * range checks to reject the address as invalid.
> +	 *
> +	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
> +	 * information.
> +	 */
> +	struct vma_remap_struct vrm = {
> +		.addr = untagged_addr(addr),
> +		.old_len = old_len,
> +		.new_len = new_len,
> +		.flags = flags,
> +		.new_addr = new_addr,
> +
> +		.uf = &uf,
> +		.uf_unmap_early = &uf_unmap_early,
> +		.uf_unmap = &uf_unmap,
> +	};
> +
> +	return do_mremap(&vrm);
> +}
> -- 
> 2.48.1
> 

