Return-Path: <linux-kernel+bounces-412934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E988C9D1172
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BBE2848FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73B194125;
	Mon, 18 Nov 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CKi/sZiC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XPbb9vVw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6551A19D88D;
	Mon, 18 Nov 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935298; cv=fail; b=p0bmqNf/qrm7QIAcOxgSZvEFiT03G2Wf2xoGfxzcM9/2T3d0HoE58Od89qycsfopO9bdgbRtQo5DkOG5iqW+nY0zp0LKJGVeu/Y3U4aTvn/pvyBL7TmF0ze+lb6HTWKcy+YhlGycDf5cxnimXL/m3veewihhrDbmMGsrVIbVvso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935298; c=relaxed/simple;
	bh=R5Mg8jjiVGQymL/l7tnZBo4zj43hWPQFgnbdBzvL/C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VjqMqupM4iiHtrFntnUMnP38xHHsz4fy5pUJhNcHn7wfE4m+oLRYJA6FKrrVXlH6hGJ7h2hAnvEueETI74Fj433Fb+WmsTvHma3/8+Ow2+pYTVsi5idYbcGJfcEBubTWqDkDDquzTLrpZn3fjYWCKUqKNhqxQkmb/nsom+PPSzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CKi/sZiC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XPbb9vVw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8Qbd3001088;
	Mon, 18 Nov 2024 13:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=anLx56LEcbvdYvnu8l
	VyXlEGsxkhNG3WT3NFzsGfY0w=; b=CKi/sZiCH63iuUiQNmx/lEEJk4T0EzKYZP
	yF2GHDs5TrzqcWR+kho1Angx06xf68VQ5omb3TfCVyH3MeQILOYzjkZJBIhs3I08
	k82n/640wn/5EfD7nB9iXcxWqeR2NURTvStz9o4KSxzqhoOa55iWlPhMA17UfvU/
	Roj1iW89Pv+avgFLHscxEZ7XmIpGzFdrfzLD0WgpjBxNakl8JeF13f7KVM/AaSKu
	W7SrQ30BsFaOX7wdntaOdtWawq9nG0qFbtmv+qB0p3CK62fwz0z+PdyDL3FkR4mP
	O0u7t98RR4/aLpbjQLJ/ZIawodDy7u3pEDH9acGXziRJx2hdHoXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyyampp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 13:07:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIBYuLo037203;
	Mon, 18 Nov 2024 13:07:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu79q8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 13:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9YHETltKN41D1QsEwXWBMTnpg7X5Gh0I10gpwNwrj8zFfsnS3kU5lbZOtYQvNvRAPJx1WebloXRuHtLU8ieqra2lO6j7WfELS8aQK8PzcaT64+5f8MSO8WfQwjXnFBZ30T1is9ThzLub55e3wwnfrCqoG8zNY9SqA56dIsfz5y9NPgcnjHaaa8smuivqGjjVCLyrKN19MfqM4L5ZgeKDXvj6PNVqLuw7F6aNV+VCnJI2tL4eCli+LvAIfWrTD6XlAqKJQNucrmd2/hLJy2LLAV75nQqMDn6FB1b25pLvJMTnQeOA96gMvaDH1tUR2wykEj0L2grCJ4F4snL3Yxi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anLx56LEcbvdYvnu8lVyXlEGsxkhNG3WT3NFzsGfY0w=;
 b=JHzcM7RA7hlzjjMiMlWObSH1aQw4OP3oxk/u6bdqtrIuQp7ahRp2aRq40g8H8GJ5b7vhbReLQwQyazQSeJApS7snBOwAwYKib+sC1sfuLjumHiq+8NWxkL5h9MVJ/YatQFMDE+2ajMYC8xYMi4sYbzY+j7RUF0h6tLCIo3ofwlNMMuet/Hl6DCfleFUUKzKJiqQbo/vk40zqYzLSlRXCBxysZbRMrZYxrYN065ctDHaxNwTu14bLiV9rkeTLeMBDP1VbFUNroO5eYWLNQ+odC31H+prA5vP+/f//oeXARds7Lk9zsBmMBcjpnbPCP2wMbhrFCEZ/28Rq/O2gOfo+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anLx56LEcbvdYvnu8lVyXlEGsxkhNG3WT3NFzsGfY0w=;
 b=XPbb9vVw32BXFFeZW8Mf2G8NT+/QMUCq+I2vRc6wdPQV56BnXh5hA9/MQ3c9D7W57QD+DBKSQVvZCHHWMq47yq+N1QMUT+XWSDgW4V/7xLIKpxZkLyPjQ9wVe9kdquR0druFm+RX3n2SkLgGDyX7FBCyc4P9S/0T/wGFdDjd2IE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 13:07:25 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 13:07:25 +0000
Date: Mon, 18 Nov 2024 13:07:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, minchan@google.com,
        jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/5] mm: introduce vma_start_read_locked{_nested}
 helpers
Message-ID: <12322f85-44fd-4b03-ae9d-81d42b977d32@lucifer.local>
References: <20241117080931.600731-1-surenb@google.com>
 <20241117080931.600731-2-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117080931.600731-2-surenb@google.com>
X-ClientProxiedBy: LO4P123CA0432.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: dd78bda6-9699-4bc1-5393-08dd07d1f23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JW+Q8yD6thkxdjtaDNG62U1P/3Re3wCHtzBs83thscXuakQAI8Ug7LJKy7M7?=
 =?us-ascii?Q?JwfJO5IdzkMp1ebDQ2/6TsMt7/czHRjoUOb4xZhYXwZue/Po76MaVV0b75DR?=
 =?us-ascii?Q?pIGOoSvA8UqGV4SWrnq9u4oHwLtRUz5O0T8DyJxCgd/JQnKrcH8o+ZlKzweO?=
 =?us-ascii?Q?vv1TuTpsbuP/EJr/H0rsk1vKFdXSfV87s67mz1Ul8sVQVAJaLPr+snPrJtrv?=
 =?us-ascii?Q?qOBjXVFIv7RGVunXZzbjugMRUDTtxtnkMk8+8DA1OSZPT+d4X9KnURvNk8FV?=
 =?us-ascii?Q?BynIn+0Cno02zBYl8MgdJeqO/WgT+w0f5mi6hIwHykfg3JdegPGEv03Kl0LB?=
 =?us-ascii?Q?c5BuIJTTjPedRv7Dxg5WYCwFOq+R1ySjAAtk9EkZ5kHJwWLctjLZcO5PZ/wg?=
 =?us-ascii?Q?Hj86HYVga6SkZDcX66UdZVnNiz6+3ozX1Ga7cKDXmsrug8umMtHDvyGfd2UG?=
 =?us-ascii?Q?cPlR1PHcaJCVx2ofCjImDCQgU+7Ihrj0nw3zlmGxqLIRzbm3/81n6lLZ8oEE?=
 =?us-ascii?Q?F/Xouu+ErB5Y1X6rm52xaBn1rRLbpbA0fH0eZYNijPL5odVgwyZEqOqIzRGT?=
 =?us-ascii?Q?AEAx60s0v5Hz5aAT1oPo+M3/YD99N58ZWdgjloKZTBryctTQEPmHeX/UARkJ?=
 =?us-ascii?Q?vVbrR5VcrKk1nlXKGuhYz3exDv/o4/m61OOlGzSjXjt3mYkrPgh9XtVgeqrt?=
 =?us-ascii?Q?NBl/p37x2F1st8oFK2JCk/Ac9Kc7u15hUk5c50I6xj86M1yiaPmHBgTjsEjI?=
 =?us-ascii?Q?i2YSnQjYMS0qd+3EW/xUgYlHR0RzqxcCfk0OVK3mmEJs15eXznCWjMsEpYeI?=
 =?us-ascii?Q?mGxrMyFbWfsMoZmyHnCjztZB0kIGxZqTNYVAv5eOkocn73AEtAulAOWgJ4zp?=
 =?us-ascii?Q?gHVx/xHgCZfo2gFOXFCjY8z9IXb3jhxcSLrLu/STNOL3vH6naKutreR2f017?=
 =?us-ascii?Q?52XON/1prI9ewv3iPVRQ0hBL3+JGRrv8u+UTVEZ3sa4cYY4fqVzlkIZpLD6D?=
 =?us-ascii?Q?JgDEZL1htXhUQgkhWO1y9DI+alYV0271tWHmQ5ELpibdQ4lFMlP8rScRqjes?=
 =?us-ascii?Q?CaqQMvWeC+sgThUk3Y5bIoLu6JXblPqFAZzBpjd7eYoIbBvdzG1PRyhL94Dy?=
 =?us-ascii?Q?r4CtCIHvGny4wzYgyBXSw9XNnpRKCvIJ6s0mpXxaQyN+JBy6KLKw56p9Mz6p?=
 =?us-ascii?Q?GDDygFpVzXIfjIct5VcwQXdwe3OylVX0KBdVPPQGbEaRRBeXfsfaJXqo5thS?=
 =?us-ascii?Q?u2FFpQCJr3FCTm/FlLTrA12hGrIlXVFMMkm4oADrBDP7YWEUJp6qguQ8mej/?=
 =?us-ascii?Q?yLA5cWznVfDurW3VbHml9s2R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MhDs/kS7/ayH7Xq2D94Noa6euhGuGqSEx6Bm7HUeOIjzsulkxE+/lUfzgfdp?=
 =?us-ascii?Q?5UetJaxtVjzYdfo5bC91nfgjQPoqNF3rjzAVy00Df7TGn9Ehhe2XFDAmKy7M?=
 =?us-ascii?Q?3p51g7J3TIjBfTsAMGfz3Ddb5YnWbTPxDfSPx6pKoNQvJt4K8J0R8+SrO9zi?=
 =?us-ascii?Q?Hk7NtWafQYpLA8O52BtwmyzNhXA64gtC691d857jAvmNcnpZTx2dYAa3xpyJ?=
 =?us-ascii?Q?5w/6IF+mSJdyF7i10uGo4eCKzmfYCnVCg5WMITH1lnkmt9qtCyvmAbtICinm?=
 =?us-ascii?Q?+PFDmrzaoSwOQi+VBYwajMqkU00uL2Q2ZvopMUtIwW+1tBglSNZc8Uzj+CZk?=
 =?us-ascii?Q?KcFy6BbL4aQz+wWGrZFz1ZOILbaICzQ7Nhvg8UojjFLwxhJ+E5VD5vV+Ze9J?=
 =?us-ascii?Q?Y2GXouuKrRRyldQx2V0ixZIMAbBnnODiLHe2wxJjJrPr/B/iaDjITdJooNiM?=
 =?us-ascii?Q?oOHxKgFCzYN9UE7wBELoY1F2YWnWTcMBgQ43yci1JNKzIkr9UnTGTH9xyrUw?=
 =?us-ascii?Q?FE95rgH/xMMpdXa+gjoK30jS1lWqrPRXXrqQrwzbJuKkCzUWKaIeWO+W7JSQ?=
 =?us-ascii?Q?twqnsHc/hUrbeAk+XEI7Ex26SaaMdmGFrIA2OOlufDrIImPRl8N67ch71mZG?=
 =?us-ascii?Q?9XJmsz9Dqk74OMsArknAWhVRIai9jSVnchHzPDwDw+Q0AP+dyhkWl6dLkvxt?=
 =?us-ascii?Q?lIlkOjL1Ohe3SjZ5CXq6UczG5eOK8Avze2TAL8yWP8ZOAvfranLFsa7NCuVd?=
 =?us-ascii?Q?DtnNURIKHdAbROVgfLtZZ/Jq6QhUKjo/RGdC+wnG0R3/5d7cDu9v4sOHnyiA?=
 =?us-ascii?Q?Npc9aXqPwpgY9GPKm+P8rgk1BSqYQUu73V0WC7tDescPuY4107ryrNFfcEar?=
 =?us-ascii?Q?aN+HePqCWVCjFrck6K+txAp1fj6xeItmB/kS2S2aDljBCCVvMKTJu3SKRc+A?=
 =?us-ascii?Q?PmBcGP4i6FjcRydaG0cUMMl/hjIRMPIfIqgktgUCH+n/OMUvPNzKzOulMBUR?=
 =?us-ascii?Q?8++3Rw7O62csKhh3XM5mWH9Z5PUoBpNbTC0RtsSQ0xwg5Gm6y1GVdK/KL8OC?=
 =?us-ascii?Q?aivqx2//1H3hoHNFB2YnBblgIAEUva6/M6K69hJppbn37Y5ips4P8zcUjWKB?=
 =?us-ascii?Q?sqvhazX4eL9FMcAba9N4cSG5EjXl5AYhqmk84A6yZW5OaDHB8TWwwid5i/oE?=
 =?us-ascii?Q?MKAsJudp39P/XrpdJ6SsJB3W6a7JMqGA/4GpSt74ZsRYzxhPtyx5FxHjYcCy?=
 =?us-ascii?Q?JU3H9UHP8cplDQzXaWvxkFWD7QX0qVx1H5bEiJ7iG6EVMsM3krL/2RrDkl+A?=
 =?us-ascii?Q?wlm4Z3NREqV55NEK4NjvzmQEdKk6pgL8YpPdeFOjrrIFqD6YJWhK/4Ea+gbm?=
 =?us-ascii?Q?Ek0dnD+vurxeZKQXaHNSCcAVPikmraAnRe5o5QDZcR5uUHzzx5MXMCK2/U5n?=
 =?us-ascii?Q?j3K0/xn85Lry/pWitmZRmAaoUhl4krVY9pxDIcDrW1NYXDmwIBkylsFqZjDV?=
 =?us-ascii?Q?Uj2sdurbyCDNdUTtTKaLztsdUY993q6g8g9PX3IMiKw8QU/M6E109ltZLdBp?=
 =?us-ascii?Q?u5DRdQeUE/9QiGnbvpdplLgjsA/vI+xUYiJOScBVKVQBzlartOPaP2iMnb9n?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7HhndNPZ6rS0WFodhy/2mNDWLSn7P8JYTlNWQZKqpVbwZAn1p7Ob0vWYCUUzHmgr8a2O4R5pPnBx6a6GkRa+pKLLDHR3PfouOhQtYmf8p0bYfOnV2wYyV97rSkOTE+mJGCcm73CPHmz1jA5f+dIpGXinmUfrG85Zox76kq8o5T4XZJAqN9onrn0Ai1cs2kSf2Uq73YRGpkgojzXLg0koUFUGp72cTiSCSzk57heD0H8KntKu7DMcFtvM+8+9KAVpTyAnleFqAlfYyqUg9jKr8kTu+on3lC0syAZ/RANV+KzMIZy0XueWUgB1vPIytf59UnRW3ZnPh8Ikk5JYp8N5gL9J6IodLSJZWAEF80iswDuooHn2QTocSKxl5N3ZvhS8KEliJl7NonpdtFNV32pWcEu+vGFa8yiVzMcnW9Ti2+q3IaZS6sDiVWTfwlxtHPMWjwomPAtpskhUcRaFTE6Mrizaig1jUCXIsvnvALASqjDAOXooKpYEBgy+BTbdeDynCECD65LDkrapVWhKcy8YwBZyHiKjd00LuZOSvG6QEDrKh4dH98IU2JRkd7ZUd+/y7HZP0xqRIXE1Laku7WYgRnQeDtlRBGmdXosHGbx5qXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd78bda6-9699-4bc1-5393-08dd07d1f23d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 13:07:25.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MO/JYnOaPxodDK970SJZqrYEv8hL3RlFBRg/M6UD5OvxTc45Wt7msHigbcl7ZTK/TM54qE+gTYVfwzx9dk9Mm52vk0XSdIJt+stzJoeUqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180109
X-Proofpoint-ORIG-GUID: soFoQd9cbxgspOn_aAFyqFgjCPZkHG4k
X-Proofpoint-GUID: soFoQd9cbxgspOn_aAFyqFgjCPZkHG4k

On Sun, Nov 17, 2024 at 12:09:27AM -0800, Suren Baghdasaryan wrote:
> Introduce helper functions which can be used to read-lock a VMA when
> holding mmap_lock for read. Replace direct accesses to vma->vm_lock
> with these new helpers.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM thanks:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h | 24 ++++++++++++++++++++++++
>  mm/userfaultfd.c   | 22 +++++-----------------
>  2 files changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fecd47239fa9..1ba2e480ae63 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -722,6 +722,30 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	return true;
>  }
>
> +/*
> + * Use only while holding mmap read lock which guarantees that locking will not
> + * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> + * not be used in such cases because it might fail due to mm_lock_seq overflow.
> + * This functionality is used to obtain vma read lock and drop the mmap read lock.
> + */
> +static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
> +{
> +	mmap_assert_locked(vma->vm_mm);
> +	down_read_nested(&vma->vm_lock->lock, subclass);
> +}
> +
> +/*
> + * Use only while holding mmap read lock which guarantees that locking will not
> + * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> + * not be used in such cases because it might fail due to mm_lock_seq overflow.
> + * This functionality is used to obtain vma read lock and drop the mmap read lock.
> + */
> +static inline void vma_start_read_locked(struct vm_area_struct *vma)
> +{
> +	mmap_assert_locked(vma->vm_mm);
> +	down_read(&vma->vm_lock->lock);
> +}
> +
>  static inline void vma_end_read(struct vm_area_struct *vma)
>  {
>  	rcu_read_lock(); /* keeps vma alive till the end of up_read */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 60a0be33766f..87db4b32b82a 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -84,16 +84,8 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
>
>  	mmap_read_lock(mm);
>  	vma = find_vma_and_prepare_anon(mm, address);
> -	if (!IS_ERR(vma)) {
> -		/*
> -		 * We cannot use vma_start_read() as it may fail due to
> -		 * false locked (see comment in vma_start_read()). We
> -		 * can avoid that by directly locking vm_lock under
> -		 * mmap_lock, which guarantees that nobody can lock the
> -		 * vma for write (vma_start_write()) under us.
> -		 */
> -		down_read(&vma->vm_lock->lock);
> -	}
> +	if (!IS_ERR(vma))
> +		vma_start_read_locked(vma);
>
>  	mmap_read_unlock(mm);
>  	return vma;
> @@ -1476,14 +1468,10 @@ static int uffd_move_lock(struct mm_struct *mm,
>  	mmap_read_lock(mm);
>  	err = find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap);
>  	if (!err) {
> -		/*
> -		 * See comment in uffd_lock_vma() as to why not using
> -		 * vma_start_read() here.
> -		 */
> -		down_read(&(*dst_vmap)->vm_lock->lock);
> +		vma_start_read_locked(*dst_vmap);
>  		if (*dst_vmap != *src_vmap)
> -			down_read_nested(&(*src_vmap)->vm_lock->lock,
> -					 SINGLE_DEPTH_NESTING);
> +			vma_start_read_locked_nested(*src_vmap,
> +						SINGLE_DEPTH_NESTING);
>  	}
>  	mmap_read_unlock(mm);
>  	return err;
> --
> 2.47.0.338.g60cca15819-goog
>

