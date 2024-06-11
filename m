Return-Path: <linux-kernel+bounces-210390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A8B904312
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3717328923E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93D7E112;
	Tue, 11 Jun 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dKddQxoc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZzHLyPvm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63CA76041
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128956; cv=fail; b=YIRZyPAQZSBNwljhsmTk7CK3FxjQw4edObIo4wgXGHhEqIdBnjospW1daBr+ATSiHv7WqhkUcmt85LeKto1EFT1e9sGWGUJX+U15h889WPxf4g7IP1tyRkVqMPk7kyG64YK2OfWBaW0PgOGaJiZFttntRpp3TVD3hvnHcag9FUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128956; c=relaxed/simple;
	bh=FZbbCVp2xmUqjfEDyOWWeA2fOZisLyjGHCKSMqf8hsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9aq1YJbDYhmZUmXEeYuIPm+hQzZk43aUNFTSfI6CXHXaQ1NXK5mf8ixUZBpL0/kUZ/B3nxPGq1pZ1n2T2/ILWcs/o9iFYcWV6UqdphvANM7jUl6qj7KUyb1UDP7OWNxR+9JsdeJQI3GUeMdauiKYfV/qyeewLgjBWvou7uuptM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dKddQxoc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZzHLyPvm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFp4FI008957;
	Tue, 11 Jun 2024 18:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1CE3IuI4PAGwam9D7DPMVIooyKeYHM5LTcACzMyc2Bs=; b=
	dKddQxocf0eRaue5OeGtxqlfZfbvntIuI4ATAesd0u3pztv0mBtv7zvFh7pyJslw
	7HBkGv47bF3XV8k87WUqG8G1Ij6TfQdvuGq2aK/kJisvI5Y7Cr8rbrMqK9RFHndB
	wqW4+qPmrlDfbc0tX/p5IeZx9GKXMwjM5vNe8zH0G6A2Ym9IuiqJPd+3eb9tx24J
	BSEtZVDJUOoeGuRHwcTkNmsHlv1WK57WvND4fuvg8qtBX+SXi3GFA8SbNq8VkV+Y
	+yWZ2RJM0aUJGQGnUQJYL0RCO1TrPdPQoiycHPCW6tuTkTsS/weuCN7/f/PG5Qj5
	nRcrkf/CbwzT3Bzntwem/w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh195evu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BHqgIW020424;
	Tue, 11 Jun 2024 18:02:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncauv0eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji9OEqeju9+DIdbsFU9raFd4N/NASL6Ps1m5o/oGjeScx47F52cZybgX4QjvVGx+K4Df+wSIfw3dRxGkx8Z009PxcFZdW9eMm8r+Mb6AqteaJjau2NslkZww7ruiyGjrmlpNnphgHJNXKOoHIvF8PPnG+sqHjDNT1l6e1jsmZrmylnjh8tRoR++heB3aljDcRYXs8Bfsdupku7iyOmawGRU6banXmFaoVNjeHpcHh7c1iDaYKSIxkXX6BuF18NU8nUqlimA8cQAwfyQ/7xspzdbgQKXLbpPz06TLtE2BDMSjx6qy8G6SgN+PEqrEqb+hkm2GC5PsswBGIgRTr93o4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CE3IuI4PAGwam9D7DPMVIooyKeYHM5LTcACzMyc2Bs=;
 b=AtChKCKlxNil8t23IrwTQqS9tduUfp8gdgRDC2gj21JCS6rf9OSLh4tmHKHSS+Slrem3yLdycawFdfA57Py4MGxCvWcC4bgKI4N5K+R5qfkbRzgV40Np156brkhMjFwzfZcxcY9Hb8tORIUE7KuDtE3Rzt7fboRc6UnSLircCOMv69H4Be99sKbLpGzJ2ufcOIYGaoLm84y37Hp6iwzvtwCxFNXEytPwgWwTbnl4KBPVhH7phQ1OK+lP3DbK3D/a3KuAaoMaj7GVkSlib3ASMx+NKznGiRZhwRk0GcPxK6WnnAGRiJeb1JOZ61NQeUPeATAZyPq1WA3at68jhs0k6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CE3IuI4PAGwam9D7DPMVIooyKeYHM5LTcACzMyc2Bs=;
 b=ZzHLyPvmwc1MeSQjGnvBbUNF/qiS8zT0o0LFoZ1zG3W+1UgmATUrAEZvKMXboiBPumENuMC4avFWNZIe0hEql6LT4aDtEDBXeYj11e2l6Wc1Tz8ZGXZahKjt2S5pIP3a05qD2gFL3FtmptenRMBMoiAu3qw8Ty/zFCzbrHQbbBo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6154.namprd10.prod.outlook.com (2603:10b6:510:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:02:20 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:02:20 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 4/8] mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
Date: Tue, 11 Jun 2024 14:01:56 -0400
Message-ID: <20240611180200.711239-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611180200.711239-1-Liam.Howlett@oracle.com>
References: <20240611180200.711239-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0305.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f1402a-2155-4a4b-3041-08dc8a40a291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IZWQtD5kQlhJUsPOlgzIsgtvkz0NKZH9Tyq/8EvJPci6PB/6mR34EsYBd8fy?=
 =?us-ascii?Q?34WDCS0N1tyntIjC19u8USN9miiDX6CmjUFNI+Cuz75I+L4Mf6in12nAo21B?=
 =?us-ascii?Q?MggX8sDQ8EIdmbDMZKaiqpABm0vN+53zYRtIW96ycd+DQ9iY+fzCPBuPyKye?=
 =?us-ascii?Q?T/aw48Ew5kLUBqkYf7kTQN6/0Q32tysc9igz8Bm+mjhUb0x7fZSCCbSfJaaj?=
 =?us-ascii?Q?CFvX9pK9hu8KmBnaZER2387Fu8iRbjDzR7HfiKMobWt0y1irbromQ0wfXNqq?=
 =?us-ascii?Q?NOqfxauBYqDUvYIanqe85C0u+XZF16Rndp5aog1rdSl/WlkGEtFYUGxe3X0J?=
 =?us-ascii?Q?bQg/pnpzvbZVz8/VGPvgGVc1CapxqZ0WBdDip/b6uUO/K55XcxwWEEUKo7E7?=
 =?us-ascii?Q?Awzd1IbOBpKNrpcQWHGhPYsQafQNtT7nEOfLb3fK1yWIBwqUWtUQoUR6OnmF?=
 =?us-ascii?Q?+sYTIrBHLxw6/XcQwfR7Z221/Lp2Kf7ocFSSKxiQFIQyEVK7xYfdHe7uRmA6?=
 =?us-ascii?Q?4e9jXKF+tvvfNKrv6XKsL9m1YcJ0PF/xPJTKNVVvJsy/zvgqT/gL3wBkjQ83?=
 =?us-ascii?Q?2keM3jd0d0Y49fVfkVl2EyCfxtA/Z7drIs1fGOR43qbcuZFW00uYS+SZ+Q+H?=
 =?us-ascii?Q?iU7CAk88gudLS3CjFuwtd3MFP2geXIzeQKfTGLcMg3sxh+ux6omH4K7EB5K0?=
 =?us-ascii?Q?aAh+1W9MkjiEmcw0ohj3fW2B8P6QWIHEwITje8ZrTj8h6WHsytcfZwgyLyyM?=
 =?us-ascii?Q?RCLoJ8MWwlaQDfOR55N3/1TpMOqTTIj3klOm2mG55bptGaMClV6phmEsi0wI?=
 =?us-ascii?Q?+dLQcPzceAAYr7cm764H+6pH4dAlmstPp0Z4mK0LwsHyfmA/tnOqwwwsbrLm?=
 =?us-ascii?Q?8enuBgP3e1oZPOjZVKslKDm3dsD5xmaDNyCjue/HZJFSGhwgfl7QZwv9VKMB?=
 =?us-ascii?Q?0fQsoDvbiKORyqN2JN0eehfdvNN83FHwekCarrjAaksREbKPJrlVqFP/4uK+?=
 =?us-ascii?Q?JczTujaEhqN+qbfHVgC0yywWWUuCPTs7umG9B0LtmUIc9K0pisuTPsVm+Nn9?=
 =?us-ascii?Q?D1TS2Xo6BsqL6y6tJYu3iAwuCI23gLwfV95mZu1mg3oQISnZBkNf1YvVaKLL?=
 =?us-ascii?Q?8HLaSTDdxUejT65hRzfwODGPfcPsAyKEIs8j8QSok7gZ3OllEb2qrumFApvW?=
 =?us-ascii?Q?1Ptu18cwgI84wmMxrz1SSIrKfyOUjIybz4zV6bmEnDrQAr+47I/sWMbGI2Hr?=
 =?us-ascii?Q?6mGoRtvyy4xl7CcdmMZLbsIFptcS1UOy3dFb9urWSyvhP6/WylFh2Al0FIHW?=
 =?us-ascii?Q?i/HWpbMj75Z1twhhJfQwHgu0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uWq+BxStc9h3bb2E1yZxRsMi7XYeG0puVjjmIcT7bNcL4Zev2vhNVokMN4As?=
 =?us-ascii?Q?4f0ZtHYP4Qoy8d2HzRYmU0FKaNS5wRHR+rFl/AFefs+EW+farf15LP64Mzxi?=
 =?us-ascii?Q?XZppo0l3plm20l3TJChfNuOPeb4Z5hgowr8kcZ2hLXHFaxwQdT1FIFVJM6cC?=
 =?us-ascii?Q?huS9hIUH2qaGfDpPXxEY1NkPb/PDVXTqX+g7KBZfFathsxh2rhuX39YYkum/?=
 =?us-ascii?Q?cWXwF0P6kIeEhGMcj6PIXUT1/pK20JkFNc+DiXawZWoDNOzPJ8yyc6rQioPc?=
 =?us-ascii?Q?J//vYlbGkuT3IZWxEcKTgK8kC8ciEdoiAx4v1CMc73MgFpdVxBMel8Kgt+0X?=
 =?us-ascii?Q?W7Zh5aTFquVP+Zn+0AN/3RTLXSBb7VIiCZQkKsJGIE3TmU3NhwC9LD4ib1ZJ?=
 =?us-ascii?Q?3clf+6nP1pzEZihyv7503cqdanJcO43oN/9AUWcIVyaIeK/jGiFVsq7Rcggi?=
 =?us-ascii?Q?3YJhAjsWVDt6gUMP4Z8UkvLZnAe57406PCuiqWIoBVMhDErs54B81FS9/QqQ?=
 =?us-ascii?Q?Ppo26qq/Pdc2tnBHQ5spIe7hNowMHmicPbgjlpIGZun1W0jP95di5lgpLTTI?=
 =?us-ascii?Q?sfR9LBU1r+BUY7og8/kx1IbUXRIZ0/Omt/8W4PVGht8EBejoZL1LdgXAJbpf?=
 =?us-ascii?Q?hj3vUZHbkNwBn7qNR4IytpkkpeSSGszZ7tlwN6KEbt7lJnTCM2nB12XmLnLM?=
 =?us-ascii?Q?AnUFxrMtOp5jTANPR+4JEDdN/W6OQLY6sGdHvBO9RhcDK6CU6w/9BZjhjK4F?=
 =?us-ascii?Q?YcISimkQa5Ou5WhiI/TA6XxR9xlF6eX3F7fsOnTick4CUoWqFT/mLznVfNNJ?=
 =?us-ascii?Q?GaGVTLr7Ca88acb/WDDqHFLIpehyRavT963pQUe3K4zGJ/73xdUlOSulee28?=
 =?us-ascii?Q?oyDxurT7HegI0OX0SQLpZlBFYylRFKgst7NZQui+JfwK8JaHG2UUytKzmyrz?=
 =?us-ascii?Q?tbHq7Kx7RphAJboEkhXF4YFu+k+f5pYIPiTqANsaydVqPHHvCaJrzBLNnflD?=
 =?us-ascii?Q?fTVxT2VjUyTPjLVCFh6ru322828Ka8n2/JSYa8Sagdp5B06OcerrkkR0RJOH?=
 =?us-ascii?Q?SYRIUkkla5CdMmjkDFK5wQYl52FnpEtV/EWhVT7S/u4/S7vnuYXpOfcaC+8O?=
 =?us-ascii?Q?+VL6BLOwn1y1/nSn83vzeTdPgELNFWa3aNNI5N7H5s8FE3V1rP9pDNCzxOsG?=
 =?us-ascii?Q?NXLe11DUnGXMHmbnSk5nMmvrz1JceQbTgdicied/1Iyv8Ejla8CbIr/SX2js?=
 =?us-ascii?Q?+Qgk4AJ1o1eCp4ceWUoJD2IRrKjGa1SOLGnMwM+e2QNYVaQh4NqXJbJ+iR/O?=
 =?us-ascii?Q?wbYqWsch3OlzlhKPmeZNvvn2Ir/EBfBPXNvDfFmp5wmXlzbYG0NCJGnF0yIZ?=
 =?us-ascii?Q?GkFvPhxvAw/2ebrz8KEaJbiuIW/MzDLKKSjfgctfJztD283VKQAKZZ31vCu8?=
 =?us-ascii?Q?pCaHQMVaD3V9f53njILKU+RvTv+3haBUcU+x+fD17Xl4+Icrw8qP+nYXNFeG?=
 =?us-ascii?Q?VvAaJm/TOjfGWRU2oPYylGnP4nx8GYBuOtFdi/mXVcJoIVWIbhk52Ctue9q8?=
 =?us-ascii?Q?kkdCUOV7aTgRj8/IVjRLMX8icMCACGCjtYDvExu0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	N4O5JWR6vQsjdtjZ4AojFWNGfm7IScEPpd8T0Ieto9kGGAaDRx8zLOgjS2uOc84uxAXAnUTPtFIoWJOfsPlL4ilinZTlUes+nPI9sblr5O0GE1JiDqrJxsD6hLbvH+w9gUWB7kOrNdOZX/27hn2pVXLN8/hiCQ7IXjDIg1EHlzZGr9fyzNE9u8pnpElKji71JeJBH+ckOI/EPAgXMy7mgW/6zNqCOW43MD5repZJ7CJONtE+L4wA4LJEkQpnLat37oex+fcyDjDLpumTrN4EL+oIpAEHkZqqvKUj7sg4RaCdG1yXVubl7WxVd0OLnT0u980yDiI25zx8wEDNi7zAzbNzBWaTDh3TfU5+Zhefxpdf86DU00SsO4eBP9j1SP70fYjt+V4NQA4Hv4NDWBP+H8HljTEX1ktP3lincl+8Xm+owgsNKHtucEA9HU8O9XyDuKhmhngBN/Pe44hlErxoCuFt6FRFRtFr1XRHwAiDuKRFqzXrEa/CFpXLK8AQ6zuzgYPHT8ZRijxzig9/Jq1O/wjAI5qaZS2rvD1aFo/MWeC/qzwYgZPqdkaZB4798sRVpkUUTFZE31nV8tpPb9ZAMZmEtnwXfgSpmVey4cYsXWM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f1402a-2155-4a4b-3041-08dc8a40a291
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:02:19.0457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHpDA7eJiy7yPJ9KOA2iwWuOjbWz93fvLNr9QgpeYn+bxYv1LnGRmY+dGQgn+jXCo6a/hlok3jkXVBT3XljhLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110123
X-Proofpoint-GUID: M9ZE3rJwkCJL9Z6J70tyD8w-ZqPzaMBe
X-Proofpoint-ORIG-GUID: M9ZE3rJwkCJL9Z6J70tyD8w-ZqPzaMBe

Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
detached maple tree for removal later.  Part of the gathering is the
splitting of vmas that span the boundary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 82 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 01bef2f7af2e..fbd36a8cb031 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2615,32 +2615,29 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * for removal at a later date.  Handles splitting first and last if necessary
+ * and marking the vmas as isolated.
+ *
  * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
+ * @mas_detach: The maple state tracking the detached tree
  *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
+ * Return: 0 on success
  */
 static int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+		    unsigned long end, struct list_head *uf,
+		    struct ma_state *mas_detach, unsigned long *locked_vm)
 {
 	struct vm_area_struct *next = NULL;
-	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
-	unsigned long locked_vm = 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2679,15 +2676,14 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		mas_set(mas_detach, count++);
+		if (next->vm_flags & VM_LOCKED)
+			*locked_vm += vma_pages(next);
+
+		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
-		if (next->vm_flags & VM_LOCKED)
-			locked_vm += vma_pages(next);
-
-		count++;
 		if (unlikely(uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
@@ -2712,7 +2708,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, 0, 0);
+		MA_STATE(test, mas_detach->tree, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
@@ -2732,6 +2728,48 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	while (vma_iter_addr(vmi) > start)
 		vma_iter_prev_range(vmi);
 
+	return 0;
+
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+	abort_munmap_vmas(mas_detach);
+start_split_failed:
+map_count_exceeded:
+	return error;
+}
+
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+static int
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock)
+{
+	struct maple_tree mt_detach;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+	int error;
+	unsigned long locked_vm = 0;
+
+	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
+				       &mas_detach, &locked_vm);
+	if (error)
+		goto gather_failed;
+
 	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
 	if (error)
 		goto clear_tree_failed;
@@ -2742,12 +2780,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
 	abort_munmap_vmas(&mas_detach);
-start_split_failed:
-map_count_exceeded:
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


