Return-Path: <linux-kernel+bounces-556032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78313A5C00C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342CA176E60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268B2586EF;
	Tue, 11 Mar 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KL9EHCA/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JaPu7Xx8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0426221F24
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694596; cv=fail; b=SKbCtW3UcD+cEN27HPl8ew1RzXRNTkrv8T0kTYV6TtvM0escaZvxcGaJz8vNYsZ9dkdRjoMjMbl/y+I/CrwJFPoe+Flhh6z2ANKkkk+VIQnXqvEv2mDD33HGDoJ9VRZFRdJ+aWYV8N5mBxxigQi2UUaVUwXQ7hTc9zJmksvT2tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694596; c=relaxed/simple;
	bh=1gtVHWpeAcQzORHVSibRz285QJa2nSzq+z+uozQ9iig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lJt3Ol3GJJb85oYDRKOyqCyCUMMyDGQbOhUgsY3tb1p8UgEA+tlj2fdRQpkQmMo9juruBqA9UBfZJp53DLPWZewr8PlZV/4y7pYZf7G9xO+2xK9o+W0a011nnkr2vWdKtjcE2l50ls+uU724qxHQuHFhOAgJA2r2ySPepe1i1wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KL9EHCA/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JaPu7Xx8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1fvLU021401;
	Tue, 11 Mar 2025 12:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=PAuP8lA7TmJx0l0t7F
	/ZXxG/d7mV1LhJbstH49FyMaw=; b=KL9EHCA/HeDB9Dom6sgRprUFnSn3BvYbht
	GVoj12t06v8h+cNbJu/Io7A+QK9mv2HXVqvbDW8E467/M7mUsZTckII131/qqSk9
	r/cEEsl3jsyN6p1Ks3K1t33txfUg4YBMVBszHaiL+BWRcPm2+i+Yh6Y0MNoMQ2w5
	dSO3OQt/DMBAhKVVbCCI+yMEZaP/Ukwpj7bOe9iMxzP6U4uSQzzGVBrkr7Hj5ZcF
	y4y+IxxC8XVxCf1ngxaewUYdDmpxtvePKpR8z2X7kK7gwqNCM0u9Vr9hVSFkzfI2
	JcusAZI6PV+6hbBYv3pAo6+DA/j2fTj+T7GnumQ5IUo/+r8HRX3w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458eeu4n3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:02:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BAtph9021903;
	Tue, 11 Mar 2025 12:02:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458wmpdmmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:02:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M72dgbXeEC7HbB72gHoXXSdbPoAw67mWFED0cIvj3eHefUy2O+/+CopZv4KuRy6NLhbakDyWQIl1qFGD+qxLVIRb/1nOEp7KF3oiTobds9t78dV2LGVcSclF6a7dodqt2uuIbQ2wWq2dthn3Qy+LNxzTkpj8DJj3qRTti+tudDzQm/gjY0peQPM/YG395r0Gwr9a4pSbCT52DloMr6aplRejXl7oaOihHKQcSj2aVwP4UBNxVc3QU13Rziu5qykCSSJF91RgSUuny8lvmhhJgm16TCZcQpvce62AJogw1vX/FlqWcpH1gFVLJ4wO4AQr9CU+gghirYxk/Ckp/eK+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAuP8lA7TmJx0l0t7F/ZXxG/d7mV1LhJbstH49FyMaw=;
 b=iQGZ8Sg5f16XtdlV3lYReoJjmveenf0hU3LJwZtqpEHCYxzlHLbMK0q0d2SMkqKXTEsBK0uJaUoKt/oOJLvg3VZWRqZHaPCJVgqnN7Q25D7Gf5+ZIrqmn/lXFERSgaGWP5UZYmAFiZSfuQdFpAxs/BnaAST5LXVygFdvylJU+Y3/XKLdacpNrIRUTM2E3MoFE/QxhkMdoYqtsgPOgxWT6wOnC78aOw4GvW3C408OpqsIh72B7449cg9+7l3syo0v8YA28/Y6Pn1Li1BjSgpiqlTIfzhjUfWTb85qLx06NiYvLFqsd+buDqUfeardmxqsgASoBTqbVpDvFRPLuUlkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAuP8lA7TmJx0l0t7F/ZXxG/d7mV1LhJbstH49FyMaw=;
 b=JaPu7Xx8Bm8+PU6DSwR+J7kCN1IwdmmLrbRxgNOtNrIfQsGz+bSTr3wAOQrEwT4JCqQ+tyzUU7DEMg9uiaKStp6UiBPahLxUri4hzAIEIjkewE3cSDW35CAgm9mX3XlcDaYG77Ksmmqfd3PlLpY39Dvxr7veNvAgoHIF6ukNTR8=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MW4PR10MB6299.namprd10.prod.outlook.com (2603:10b6:303:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:02:50 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 12:02:50 +0000
Date: Tue, 11 Mar 2025 12:02:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/9] mm/madvise: deduplicate madvise_do_behavior() skip
 case handlings
Message-ID: <45ce499d-27a8-45ba-9644-67cfb73e489a@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310172318.653630-4-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310172318.653630-4-sj@kernel.org>
X-ClientProxiedBy: LO2P265CA0403.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::31) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MW4PR10MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c8f9d1-584b-4150-72a3-08dd6094a55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+cyuc2G4erjdh6coekiveIsVcwoKuwI5884jnZGaUARIy6gvbTfOw8cRe3hZ?=
 =?us-ascii?Q?7yheA6Q1nTWBLvxrZD6HxQ+wamAekWqmPviQsSmP0fsK0m4/uxGtZ6f7n/Ad?=
 =?us-ascii?Q?yqpHXSi/9CvkpmhXSK2g9XpXtaj/3JOKzmwMtL942HP1t8g6kKuzLK3HuqUR?=
 =?us-ascii?Q?qlP0TAosqYSWouyG43N6DW2GfO9Sq6HC34hpC6WCyRXYts1lG+eKmSrEmi2u?=
 =?us-ascii?Q?TBnWuoz3AbkGis53N0YLOuE7DyD/y4ynfMqVkSHpfHBSYLbnW4E2j3C9YWYz?=
 =?us-ascii?Q?Ea6itBItmgqSF5L24wsHi4QApLSGIo/n5l5Y6Spge6V1u1OEm1fWFyY3Xnak?=
 =?us-ascii?Q?OWIdNOPGAeOD/jh+lKe+IhiIKT8OeZWtILmrFd6eh6Lvf9Da4ODnBBk97QFp?=
 =?us-ascii?Q?WQVTVdR1Ysk23g5kmqRzIvaL0DipIZgBnBusIG9hYBQz0+RcbsfZmkXsmeeJ?=
 =?us-ascii?Q?e6NdgF6PpkvZt37smJT/aHqcvv1ENxAtJK+QvjmFH92kYLF9iKf4t6u/3WjQ?=
 =?us-ascii?Q?u9uKOs7sh37hL+GmJayPol1PU89pwjX5XrSussIJrGYhTQfSFS2v6wYyMBwz?=
 =?us-ascii?Q?QG5liDAeSLYvjubCGS41mDLoa40M/Np2nOx9X6b2giAmAqMoBWKIjMc5KSfR?=
 =?us-ascii?Q?nvjYIvwopJYySXw2MW8y2VAIjTtm2F6ny3KhPoT39oUEUW5lCxx23C7v8FZe?=
 =?us-ascii?Q?R9kNG1xraIOz4KhseBPQydXYYQnWI74H+BMDkF6SKKzoZmebKrEImGnYYd+p?=
 =?us-ascii?Q?Gwt7ICnL9XCf0TQyyBB9KvpC3qBSXLFIbY/N8165X2U6W7JFxQ3FF+XGv0ow?=
 =?us-ascii?Q?TRL5Vvw1WwaO5FYJ0OUzllxCrXBrJPpc2w4ptopVR+tNa9c7jAI+oTmWSj2X?=
 =?us-ascii?Q?LUTkp1cRlDsCRudfdM2Sr1lKelFIL/1CxvaREVzdiZ5nRm2KbgWjX2GL28Z+?=
 =?us-ascii?Q?yQr51izDSG+89Tr2kn0VyYLOSoOEg4YNiO5qb8w2EpvKaeN0xRcm0u8k9OUZ?=
 =?us-ascii?Q?UrcqAk9txpjQNwYTVkJYl43E10OolpHbm0kbByUcUr8Ee+1mCUyuHnW6WXev?=
 =?us-ascii?Q?sFAOhUFLbpJLZTHDI7KQjOsLEBZekx7+rCEPz2DjNnA78ZHpZYoUb2LZ1fmx?=
 =?us-ascii?Q?7xGjjo9OiJPh8reZCF8yLdi/+ybjqotr20qx0jxaJWnyBmwuotXeQN5bzKfX?=
 =?us-ascii?Q?wILiI9+I/OH6LARcx+2XzDOEnNGDe7VJjEcnm+xnJyl3bgGwq+MyeDo6NpfP?=
 =?us-ascii?Q?Dssx6mXo+SCDLx8Zh7c6TMN+P6Vi/K+dDcpmw8cqK6N3kbM7pEi3f4sjbwsv?=
 =?us-ascii?Q?s6vMKwzk3YNRFU6h/TwJYe92UM3nHX7QQpuXrIRyKsPALSt345QbDmeBcoi1?=
 =?us-ascii?Q?TDeTi2LEGGZJk6rHL6QwYBD3gAYU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SUO5/cjX335HItahmgnN+hAFm8scGHY+4wAfz7e9WLdJUwpWehXbH4T/kIqu?=
 =?us-ascii?Q?i4FwVvmQ51POgFLWCpzGpODUmLf+VQZegqZTFvYMOR3Ujc1D0VfuUlW7fk78?=
 =?us-ascii?Q?DHYXMzDJxcKh06nT7zuz79i0gBk9nSeAJ23MEqPJ+Vj5CYAorG4ctRA7X7Pa?=
 =?us-ascii?Q?QqCpF2WzNfvsCTX4HuQ/OiKi7l1A/mRBFAOB2vJk9VriTAITx7pwgEcNplsT?=
 =?us-ascii?Q?UB/fRZ4I9TVWgW8UFVqy4QFZwds5xtRGsbNQ9AmH4VwwNQ7/hVQdJ7n8YNv+?=
 =?us-ascii?Q?LcHH8B361G9F+YYcF+DsbrCk9zE5qHSX5Tj4cugWHgMNUncsyNHlSE+/opSl?=
 =?us-ascii?Q?9P63Wdnk6wNK+713NL5jbD1HdHJAAc7vXuwsZT7BhvRnV0M/xy0BcYq5YMI/?=
 =?us-ascii?Q?TmXfMdPpEYNmLOel72WjlXeednfkenVICK/Ngqy1kEjmuhIefZP2wdEIqRrR?=
 =?us-ascii?Q?5E7xGpUj+cIZoQUVrlMV/THG0EH2H+TLUxTbd6EJ5KRNJkkJL9mXxA4/h0Vo?=
 =?us-ascii?Q?zYgP4iHvL0sC9U55g1EQkqlKVNZfpQGERNWwHzqLbFKNY1fcs1NOd8wZBMtx?=
 =?us-ascii?Q?J1tGOq9t0kMs5QQ0CsfSePprXkMYGfclGQkudFkM9svICT+p2DO0dqCugbKB?=
 =?us-ascii?Q?+cyUmR843DyaqWv/Sovo8u7me7tKPcpGGdspGZyMYky6wmfOzJsPQ8CcsSql?=
 =?us-ascii?Q?bA2Xb+TwxfljBL469oMblg+s/00tGtpbvkRZt1V85v59v0En2OySBetARuvE?=
 =?us-ascii?Q?qdcMk8EB9riBUNhh62/UW5ngQCKrYMqW7r6a5gABkrgVItNFp1NVwv9oW+7u?=
 =?us-ascii?Q?O8IBq6BXB8ahZR+bxR1eVpWjuDsDU5MqIliEWwUfcMpMRUJRwZpSIN1SCuSl?=
 =?us-ascii?Q?fxi/ROskWwQBrB/xjE1gz/FeSL0iXbYR3RcHmfaVmh0tkIxpJOF6BGGu/0C0?=
 =?us-ascii?Q?yjHAGGoHMhflt5NUPTCMhxRZfe34Qt26b/OMojew9yKlvM0suiKCbBXns10+?=
 =?us-ascii?Q?6D6K4qmPQhPY+/p23UUNrGVyYzPuG70JSa+yb8Y15Y3Fnj3rPzfcxmlc0+HG?=
 =?us-ascii?Q?rxMogR+o91AP5XbckhiQA3wS/lLOSJBjC6GtWi2Jfroetol0KMO0tcpWjg3i?=
 =?us-ascii?Q?2y/xRydJmkcS46JQHR7PeqiN7jbAwuAIo1WtVFHO/8llGU9HvbTCj8VJjTzo?=
 =?us-ascii?Q?Zml1RyD/UD4N9MUfUfRVsX+hzpvp2kTJ6q5gj96/qpjLdN4ZfdcTe08uFLC9?=
 =?us-ascii?Q?eLvoOQ3uQli2tdc/qDgMsdNYthpdpHx3BwtCwXD+A+LFEiRaQXfSH/3fNxN3?=
 =?us-ascii?Q?nmTckl+lyK7aaG7MPXwEffAfMWn1mAOuiuXE38+mFgaw/LYSHwyJsI+kv34z?=
 =?us-ascii?Q?37upyizvJcYwM5iHt9BZrnFKsiSwfr2ctKKceUX6hTkVqdh+9L9awYTnoSmd?=
 =?us-ascii?Q?9Er/oitBQ6ujXI+XqArb6WOfGTFam24OyvvQFhyE8Bc1q3AtcUgn0FfrsA2I?=
 =?us-ascii?Q?ISa51NmeM84tfEBQ0trOPc6hwxGJH/OHND9CON23aFmiLbF+I33a5tZgEa3r?=
 =?us-ascii?Q?0q6EqjEMZ5s/BLTT6sGilDadNXfN4DEO1T/IUf/ILbWwXe2VjVsiSpwKr/Y2?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8EoWmXRycxNAh9p+2bvBwu7ku3qaEgOIwFI7mBdG6rEq53YBrJ09AjyB1o0IgVq7+P5+PZ5fS0pwFMPBMjpeP8bq25nh6gA6amTtaN8uEoH7SSxk5OrnwbYllXTBnpVQn2IONo7Iao0fuWhz4HD5IYs9m3Ko5tTHS9asMMgL2P/mVU4/wwwpGq88gWicbq0Gsru1OBuB6Ck8zHBm2+kbVFuccvJWgQ65yLM8BhF0D0pGsEImNk0aSoXoma1BAj5J5UBk+mbtIL+fjEoPuppg+VLOdLjTsTAeCd15f6wL6ecUTMtmRrOFhc6wV22KbfmR0duSLjKhEZk2Iz+0OeHjUhxuUl2M/yQKP5t6EGD5l7BZe21/a0q/n5kBExonCb2qhMsvtrJN+/MFk06mU8RDWj+HKCUeCPj5INjrD3H3zs/1W4/zXwh4lZm96wqF4lC1ClXmEB5xsG+AZgv6eH9UY1MIaYSeu6HhcL9S3t7rBPFZX6aoDWWhtWFn/gKVVLwpu1LVOWMts5206qo5iStDZTL/kWfNXi+iEGpAbdnb7kj/heWFNIFNrJuvhz6X6/LEsfraw6rGxr9YrXJxpsy8TQa75o31Vn4t4Fck6tHMyAE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c8f9d1-584b-4150-72a3-08dd6094a55f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:02:50.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEes9VtqplkU6D/b5L7pO48Do0UmUmLLofk7pHXMKerfTjlO1wHP4hsDKFR5rah8XHi8h6/9Dqc2IyZOFf06aaQksqOGLJrLQB5by7ti2K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110078
X-Proofpoint-ORIG-GUID: tE329kAYSoEbeXE0xyF18ui33NP4dHFi
X-Proofpoint-GUID: tE329kAYSoEbeXE0xyF18ui33NP4dHFi

On Mon, Mar 10, 2025 at 10:23:12AM -0700, SeongJae Park wrote:
> The logic for checking if a given madvise() request for a single memory
> range can skip real work, namely madvise_do_behavior(), is duplicated in
> do_madvise() and vector_madvise().  Split out the logic to a function
> and resue it.

NIT: typo :)

>
> Signed-off-by: SeongJae Park <sj@kernel.org>

madvise_set_anon_name() seems to do something similar, but somewhat
differently... not sure if you address this in a later commit but worth
looking at too!

Anyway this seems sane, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Note nits!

> ---
>  mm/madvise.c | 53 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 23 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 611db868ae38..764ec1f2475b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1640,6 +1640,27 @@ static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
>  	return true;
>  }
>
> +/*
> + * madvise_should_skip() - Return if an madivse request can skip real works.

NIT: 'real works' sounds strange.

I'd say something like 'if the specified behaviour is invalid or nothing
would occur, we skip this operation. In the former case we return an
error.'

> + * @start:	Start address of madvise-requested address range.
> + * @len_in:	Length of madvise-requested address range.
> + * @behavior:	Requested madvise behavor.
> + * @err:	Pointer to store an error code from the check.
> + */
> +static bool madvise_should_skip(unsigned long start, size_t len_in,
> +		int behavior, int *err)
> +{
> +	if (!is_valid_madvise(start, len_in, behavior)) {
> +		*err = -EINVAL;
> +		return true;
> +	}
> +	if (start + PAGE_ALIGN(len_in) == start) {
> +		*err = 0;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static bool is_madvise_populate(int behavior)
>  {
>  	switch (behavior) {
> @@ -1747,23 +1768,15 @@ static int madvise_do_behavior(struct mm_struct *mm,
>   */
>  int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
>  {
> -	unsigned long end;
>  	int error;
> -	size_t len;
> -
> -	if (!is_valid_madvise(start, len_in, behavior))
> -		return -EINVAL;
> -
> -	len = PAGE_ALIGN(len_in);
> -	end = start + len;
> -
> -	if (end == start)
> -		return 0;
>
> +	if (madvise_should_skip(start, len_in, behavior, &error))
> +		return error;
>  	error = madvise_lock(mm, behavior);
>  	if (error)
>  		return error;
> -	error = madvise_do_behavior(mm, start, len_in, len, behavior);
> +	error = madvise_do_behavior(mm, start, len_in, PAGE_ALIGN(len_in),
> +			behavior);
>  	madvise_unlock(mm, behavior);
>
>  	return error;
> @@ -1790,19 +1803,13 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
>  	while (iov_iter_count(iter)) {
>  		unsigned long start = (unsigned long)iter_iov_addr(iter);
>  		size_t len_in = iter_iov_len(iter);
> -		size_t len;
> -
> -		if (!is_valid_madvise(start, len_in, behavior)) {
> -			ret = -EINVAL;
> -			break;
> -		}
> +		int error;
>
> -		len = PAGE_ALIGN(len_in);
> -		if (start + len == start)
> -			ret = 0;
> +		if (madvise_should_skip(start, len_in, behavior, &error))
> +			ret = error;
>  		else
> -			ret = madvise_do_behavior(mm, start, len_in, len,
> -					behavior);
> +			ret = madvise_do_behavior(mm, start, len_in,
> +					PAGE_ALIGN(len_in), behavior);
>  		/*
>  		 * An madvise operation is attempting to restart the syscall,
>  		 * but we cannot proceed as it would not be correct to repeat
> --
> 2.39.5

