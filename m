Return-Path: <linux-kernel+bounces-297881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324DA95BED3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494431C22F49
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9CE1D0DE1;
	Thu, 22 Aug 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKQ8utzl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qjM7W4vq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0121CE6E0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354791; cv=fail; b=fdDIU0jysIq7+Un/if2of0kQBb3mKh8/bwE8NTMxeOY8lfwGgj6adL/2qGo71/Ob7J83//0WltEJefxCGwV1EbY9eBC5pYrTUA+vIbLL8pzq5pFCEn/O0j3DOAKz2jxGfZ/nFBBAKh4oT+bit78B1+8wXmwGmhHMLwvxpdqn3OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354791; c=relaxed/simple;
	bh=VOUDrA/3pOEobvQHsjhY4Mw0X+i5TXp10gtl99DoZVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okQoukt4tktsKcT9/IJOvSdTHvp/WlEMg/o3FVZObTouCoxceLgG3Ft54h8TLCAtDucIzMnhHfB5FyphLyu4KLXrzl0YS0HbaHpM4c7TIXGN6A7HPFeX3+37hbFKO/MwM56NWx8izqjS/WbSCxTftn76GQuihdcADnTMDMD33vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gKQ8utzl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qjM7W4vq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMWus029723;
	Thu, 22 Aug 2024 19:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=WZRaFvqKhmeZGOgIn0cNM+Fo1hKAtKZhH+jC5oCYViw=; b=
	gKQ8utzlvjAp7q/BXzx6kIa/c8Y+gl431/Q/QT6iHmgi5C3CuW98YVjF49dgPQ1g
	7GCnTe+C89NyB7AlL2muRv8oqhS06nWO0H2fcIfCqvDX20v6CSEtw2yHw3NH4OJO
	3iv+SHeiLK8UbtDrCR2o8FoA8/cF+wgfE+6mZmWqGpiFPNi8oeQfLWKmicZqlLrl
	VKw3BaNko9hf0pfiUYbQmldCl9Egv3Y77xCpEJfj4RDtSHu/QGI6IXwKToBL4OSr
	VtPVdnWriuXMfwceTY9mUubPgEUdaLEvRQlokJ34YBcUxMK1PZwgGpJzx4kG4Bsu
	yu+PtoIFjVF8L425CoJlIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67jrq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJBvd028114;
	Thu, 22 Aug 2024 19:26:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bct87dg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/5RILsvsbkzSgFGAvLWuaqrqWSAo7zjJHWVfT2AECMZEIY/GusFJcRv1A++qJ6LCHPeAHCACas0u8Qc6TQUscu822L+p5vUB1DIbJPDLx+sQt1LQa9tm/sHh3+T+6T+ShVLpChEXp8tkarPr+VkRH0q6QxCGBEy4wLnpMiU14iqpR7kF0AEryp4gXLYm36KO+46zc/aprgJpyQXJfbBb+OLoFUybXcdvdIpUZgGJNxo6FvXP8TvT3DktFTC6mLnuxOQHWnWH2fEcJvnguAFGY/7GQFK5nl55nxmyaMlTZ0c7XeS502rb3Odud+slO1bsmJIvGMeV7jyL4eUKuxG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZRaFvqKhmeZGOgIn0cNM+Fo1hKAtKZhH+jC5oCYViw=;
 b=b67s7NdNglawLPDU+XXY15wLMiWKPIRtZijQzf4p0RPqo8CrXNg3iGhu9QxQCuW3BpE1vbnwNYkHcpYUWPjw4OMjWRGYqrk5pFzqRxh+TmcLBd9JAtIzZcZ2lDolMyiQMqjdQvzWMgFdlnKbIerAmXg3AkbROjQxP5a2OzCEeqbcH6E42bVPkReETJYv0+WX/M03bW0LlXO30CcvHwea1c0JdnL8Yh9Vlhg3QAWJYRPYr8zkckuqeHYtRMwmhElhBYWXdlK5XbLSY50qLJLP4t/8dctSjDuP5CQX4jddBvl4mjhWEQ17vAoQVg8xSrlQmlHIU5d8pO5HEdJRiF2vGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZRaFvqKhmeZGOgIn0cNM+Fo1hKAtKZhH+jC5oCYViw=;
 b=qjM7W4vqgKe2obWs4ZKZXwX6FRdhrcovjRMUXtz/2KMRpZ5my5PlefUxfXtTEoyep9zquE1JMmszgue075NiGE5TINcc7Kkwww+Ng6maTNQRPUPJrt7l8oAA6NkZ3FBybDQSQQgb0zXRFDr4oi9cpM4WMVpUJ8NFoD6xbsEgvLI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:06 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:06 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v7 02/21] mm/vma: Introduce abort_munmap_vmas()
Date: Thu, 22 Aug 2024 15:25:24 -0400
Message-ID: <20240822192543.3359552-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0210.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b148ec-7f5d-484c-565c-08dcc2e043ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xTv0v7D9RIzdzqhD6DGwmbwTb91fnz8kk0oBaOOgJDMBK2ub9Hg+goUVkupf?=
 =?us-ascii?Q?M4gPmmCTQ6M1u/iPIx6fc+ztjWexrQ+OPPxWt/rghGU3sqTVtO1mSxKEDXLp?=
 =?us-ascii?Q?x+RNT6OD7BoEACUWY31ssvizPFfKX6he9cbBb5ktFO0n0EADm1w2mDXL0sLS?=
 =?us-ascii?Q?7Ok7/uk37J+iujTRozwr+f5TwYDNLns74ydls3PMJpW8pWXY17RDb4pOg839?=
 =?us-ascii?Q?6SHBQ8J2DVt4tzXL6AhPxi0iqgOwJPB4RUTCx6C2ywwmbDKLJzQNYNVCztKu?=
 =?us-ascii?Q?OeYDli9GgifNXa0qbG682iFGBzyI8RTBxwUkuDLVowmZnSVMe/CEckyctTK6?=
 =?us-ascii?Q?OeXvDYPo3beq+Q6qH+SIHD6uHUxJ4zLCtMbxBShPScJlMzucOKHAndzeWGt9?=
 =?us-ascii?Q?iepKVZ0F+PS2HfAG9mHUh+gKjiLcS9V3VFqNUIWEAIcAZmzbdrCNFSOyYxiR?=
 =?us-ascii?Q?7KmSCqhFZ4JXg05JWas3WYaatf92CxTXFG8P2j+4PmTBSDYREivoPUNEK1ru?=
 =?us-ascii?Q?9rA796F5N3eXvN5Z6Tc2a9+E2wiJPzr7kQOsDQkwiVAdUG5MoyqqwxcJ+rRT?=
 =?us-ascii?Q?2mg/MHNEJ8ILY3lQv8z64d9L4Avo/a9rQ0eUKmMSroFSMdHgdENGWrm2L4Uq?=
 =?us-ascii?Q?F18Z9ZBo3YtAjGEOAWRLlzBfcou+mAVrG/jU4/8pK5DLRMTMHVrO561W9uL0?=
 =?us-ascii?Q?kEx7xMLs/rojmbsANiHOVYrMp3GpMVHajObbO3wPgtoO3w/oa3JAcJvSo9mo?=
 =?us-ascii?Q?fBfQLULuiUrNxXAVe+XcUNhlW1KjymHsHfNceWYmUXWv+kuSOOBVXRsj0eAx?=
 =?us-ascii?Q?dbHLkFE3Z/CKfTtLBcPtyFFvwDZVBKKSdJXkvLCGBfXsbH5qcyAWWnsLbUFT?=
 =?us-ascii?Q?nU7QsvSR9Uwq9jd4v79wOsLcGdh3kWI3pUp9esDFn9oFNin49izqqacojJMS?=
 =?us-ascii?Q?YHIn7sjrUAIFqfXkTiDx6mqyQh1NnQIkDoLn9UrCwbpipuOZruiFBDPUy9Hv?=
 =?us-ascii?Q?v/WB1PgxaDBjXlEbZU0UZSVNfE3mVFv4pQJPsoSrUjINkhOtwcmPEOnWpRR3?=
 =?us-ascii?Q?475ao2LnwDd6s+/HELWSoITSqGiItlHR9IEdCxw+5IKf2ewwGb0tU2aOCxE5?=
 =?us-ascii?Q?GPI8eKimqq4jZ66sazkd0M3eRXkyE4br4Z96OCQbKgx6bO0qE/BoUn0OfatF?=
 =?us-ascii?Q?GHQpbJMWS2cGzrOApZbOli/JFhz568L2XrnQvJeCIAmmePOrVWIS0f1RFHfz?=
 =?us-ascii?Q?MtFLpmvpVQxPnc3RoEf5vKbGCH/NCHR/QILrtjSTmJzu0XYG03Uzd0+n0Bmo?=
 =?us-ascii?Q?Bn6OH0pbueX2/gEg1VHEt8TB2jW3E1kbW8W+6yKhaw9rew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wO2xlB8Wa4SFdAKRQzSo+Fe8oajBTtu6YDdihygTnV0Mwccjy+0VCwI5ozch?=
 =?us-ascii?Q?Ml8TNIyyYLipqL0pR5Cyam95M6pE3C55f6X8QFoU32oqI3TEClpqTh3R0ulS?=
 =?us-ascii?Q?jtuKz0A8vqOCA7AJAEB5qwVZKvZp7PgFyw3dr9cJSgTVoA4xHtCZ99TVOU81?=
 =?us-ascii?Q?/URVzUaAXlfJTBcoqRFVDrc2h5u4Zprjk8oOp8ubDxG/zr8PAyt5Zxdr/GIg?=
 =?us-ascii?Q?DSdMsrFHF7E65WxJXFDOAERfqYcORb2f/DZi6GP1iLalPv8eKXJ7AUEBJ2eT?=
 =?us-ascii?Q?PC3BKnm7/zj90GLtwqncbrpQ2REMsqjL3rt3ZlzTdXbgSwQ7dVitjOLc2xu1?=
 =?us-ascii?Q?V4tzwvlzapaFv0GHc6hzf0y1lsH2F9xtYMxiAzVo3KA59z3VtzUjcvPmiFpH?=
 =?us-ascii?Q?0d4PT18RFOXRqsvcFg6VTko8pff+GUqaVtQ6dX+iXZ4S9qfzUpMj11NG28Iu?=
 =?us-ascii?Q?rOfHDxZbdV6pIU/6pFaeDm+AMBi7jXPA4O+qGh9yVdEke/hQT7GAHpa+w2fR?=
 =?us-ascii?Q?ym2MlVlmMh1lF4jOm7KZ6wUEhxbZdvWO/RCw3cVe226vkWbJOnEle/K2QK/A?=
 =?us-ascii?Q?C854HjG0gG3+4wFHQDI8f7E0qL2Dw9FjCIxtDEMJa5KgsedoX3S+MB7BdlSn?=
 =?us-ascii?Q?C8XJo3ijYcsIlcM8v99uAf30FnRohKfGyorpKKgLqnZAW9hPR+D2a4KejGOp?=
 =?us-ascii?Q?3gyNwk6VebkoBzqYt5UIl0/xLG/gmzYliqxQt7jIz8bqJjQpWtptee5/3Hds?=
 =?us-ascii?Q?8eq+hPRvPE8W9DYDBg8kZZWk1vnyslYRfJfHKMOpkmxSjxTNp640KfiunCBL?=
 =?us-ascii?Q?aRChnf/iTBEBQe0mAuk3h07rl7E3IvlvahEuQxy/k9zToXCYrobXgxodYCAy?=
 =?us-ascii?Q?OY/VRo1Uc4KAwngD/betjgHqSXEhZJIP6djG6Gldwl5T2HQqoYfjwmzAV2F9?=
 =?us-ascii?Q?vhMspFCowh1hl7FMglixTCLKuZSFEr0tUudYEMA072lGJVXdA92Rif2o8KNS?=
 =?us-ascii?Q?dGRPvJc87MsFbJlKZ4EzG866U6wzP7jV/ZmhEBGy3zulfybbazmzPcn8fh5r?=
 =?us-ascii?Q?BM37PKHdzgmUgv1uBZy2kGAfV1UQFi5g5WUt7qDvPzlBYnjeEgi3gExtKqD6?=
 =?us-ascii?Q?Dp8UxI+JituaSvSjEMDFaa2PReNVuLDBP7nEo17Wg362D5nzxHZtIwTVIGXj?=
 =?us-ascii?Q?fNlCW1i8RWK7jmFdOWoXUG60bRDdHt2W+r4h8aiEW63c/70fLeTn3yawf06S?=
 =?us-ascii?Q?kybprzqPnhO8qaAFF263ykb4qXjRdcjsdL7+dU/Ho8GbG0qmT45izvzBG0Sw?=
 =?us-ascii?Q?R9Y8gEtMdijIiaAzgZi2ib7XcOdVKrpxM2K8GKnfAIcTqoPhdVSn8u3TTBhk?=
 =?us-ascii?Q?VuP2rezJRJFLa16oph9HJ9d94CHJHpo+b/CiVdMWLnzvtMRPH9uOrXMdv21H?=
 =?us-ascii?Q?8Nhyj9wmgGIuIZXAH+NbhAEP0OtvEb7oCo3qka8L4zSVx7q5Uw91bucNlwol?=
 =?us-ascii?Q?lVLUr4EN/FWXYW/iclKKkmgTEjP+P40YKYcvXo6uChHRCvy3n3TZ9pR8JP3j?=
 =?us-ascii?Q?YhygfFWWFea7+7CiXN6vU5Wtw/z3zbjP0JOLQatHOADp5tnhERy3mNXeaquR?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	soKAiaZhohOoEd+jemYB+9M4civjdqm9PowouiAddtMFYPQPaSjjsCxyJRdRkBri3IvMt/MmRSFocpPCF0OdtXns3nQDpABTkfwsK2zQttUqh6PYXlA9dJY+p7nT6S4HMA7q6NVi5eiSW+wflCy4uEgvgoKDyFTUJWJlwU5heaWqIpyIwIZNDJ6GMg0Zs4k3u45tCSsjy9IMpVJwlXkCblDGtbCuIJQLlI+3fZ42zM9ya4lP4YRe42gChoGp02KfEpjFUazsUW8fpU399xyBzur1iDzAQIvKOFCwLxi72b7XL2Xs1kdjR6E4/3nreZz0R+xghQqYs76EKcYmn4clXuq/IibJiACZ94BkT9k/kVWoI/QSGrGO961mIR/wLI2gRgpQzAfZKkQNKlZfmK3RHh+rI13vRt1kyEUZkUaPeCkmKNnAccNkBk6oo1uyGskCrx2OMnK0VGEP2aByin53vR+1L8Nc34CSO/3O5yARcf49QGXq4acaLcyWFll14DQeBwc5zhnAXp8FfoDidoF1bzRiVMR6NPINGnXSxkORW5/y2fEcSnJVmGyRAS1J6kfm9xA9RUvsn3QyjrwYqIHBa1kvDcVNPTY8iovyFSkx5P8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b148ec-7f5d-484c-565c-08dcc2e043ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:05.7147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbejhqFJ5G62Ya5rg1btcmSORiq8rBW2Po7iRwGFCizdf7seSvwRMVRA5MKj+UdxK3ixZ3/u49TvvstdCM9U+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: qO4n_krSUpo-SGONhQuPymv_sdg4C2do
X-Proofpoint-GUID: qO4n_krSUpo-SGONhQuPymv_sdg4C2do

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Extract clean up of failed munmap() operations from
do_vmi_align_munmap().  This simplifies later patches in the series.

It is worth noting that the mas_for_each() loop now has a different
upper limit.  This should not change the number of vmas visited for
reattaching to the main vma tree (mm_mt), as all vmas are reattached in
both scenarios.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 066de79b7b73..58ecd447670d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -668,6 +668,22 @@ void vma_complete(struct vma_prepare *vp,
 	validate_mm(mm);
 }
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -834,11 +850,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
-	mas_set(&mas_detach, 0);
-	mas_for_each(&mas_detach, next, end)
-		vma_mark_detached(next, false);
-
-	__mt_destroy(&mt_detach);
+	abort_munmap_vmas(&mas_detach);
 start_split_failed:
 map_count_exceeded:
 	validate_mm(mm);
-- 
2.43.0


