Return-Path: <linux-kernel+bounces-368472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F199A1024
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DA21C20A69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08520F5CD;
	Wed, 16 Oct 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cFD1Dek9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c9iFlwS6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447321DA26
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097790; cv=fail; b=BHPIX3ibk8OcLMfPHU6AcV6E0x88FYeBHGVqtC3ugUxDHithN5eW+dJ2j9ZNx1XwZIp/7rh6GFtEU7qu0izc7sT6s9WfOdBICiEsMSWGkJiluK2aTltKEz0d6UyUw/Y5ecK6bO1FleurIbyl3DMUyP1TIiHy+CiDG++dzSDVblA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097790; c=relaxed/simple;
	bh=opHupX9lPPjcDKzQQzKKdXTRJ7ccBcV2IhquSx2ReLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lo5tym7p/rKTcESiNteDQwrJn0ILFS/edEe0LpC8AFQKgSV3oX8ncgZ2WOLGz0608NPkJpEfX338LSAXu6Re3plwwiS/ANFZrJSpRMdos93QoLOiNEwrv7kOwtI6tHVmBbSYZSF/1T/BrqA+3QAVfmYEo1zkLNnmbeWOV63/qnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cFD1Dek9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c9iFlwS6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGBfq8017824;
	Wed, 16 Oct 2024 16:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=USZ4R0cZ+Pi1OXet2b
	xikH3rcJBMw7YrsLca7oCDCbo=; b=cFD1Dek9owt18X8iqVNBU18d7p1L3LQRm9
	5L9c8wohl4Bh+mtpG8uSlRXs9JTRsLpPU/1vaHRpdnIwsRfbeSTYA4MA+W+2zJh6
	1GxpfNV3Fhy5r1+eU0JOYlXnzt2ocztGS1BXSRZtjDXTnDAOyP+Lwsi7GFcWj/pD
	W33Q3iZUOeQjY3XMr9an9haiDnz8ZnxLlPPt2fbNZf3+XV0yC628qFbIxLSczYg+
	LC68K3sHv8n7hNTjxIkCZSX4efh/JRGN3zVN2DALUJTbRTK8ENqiH/iempej2gyK
	4tKCMRgsXV9CsjPfQLGGQUDBJckmqU0L9ka75bHU/4SsVN7sKRgg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhckxs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 16:56:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGlCg8013907;
	Wed, 16 Oct 2024 16:56:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj93je4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 16:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgr/c7/FaHAbi3xDu2q2LEtNmWwH5a6cRiWK0xKQl212P9/vnzH/82FYY498Fsjni22aflCfOFjAKbC1YA9S8PxDP40F/Lc0ii4LuElGQmcerXF5oN5ia77mjZFF6f/BKxAakAKYkgh3KxFmDRxVB9Vb0yQdBB+zx+6apwLjsKF0Dv9DgPkJJU1gh5qoaHkPhbeR7pwt+70eS56R+EG8/oUiMJA+Lw1Vrc55bIPzOmp38kryKi6zNyE0sJT4lF4ugrIgiG94pqfihiWcqYRS4b+SYxmqoWOUbKg9wv6rZnjRkN1KlZ/FQyYL03kMgHdAV3BS7YvTgDqSzKvkuG3zOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USZ4R0cZ+Pi1OXet2bxikH3rcJBMw7YrsLca7oCDCbo=;
 b=PGH3pz5iJOdCXl0w3YBOryhLHJ2hV7Z7+4uhG7vGcH7PhoLdSuS1CrswCfpBCr8FgzpdNM7gcvK0oq5T72FwQOjdesYjlTTTYewDpYN+mFEEeGgUWH77WbPcPyr8TjRA0tyccpErN54eGQNk2kJAfhIG8khgCchF63Dr9aabXgIWfyNwmdwYQmF74XQVWDsPck2r24T0KYWI0CNeAmDxfedpkpACSBP+cvBeO6XxO5kEIMvpGWr8p2uDbry5Qi/BgV9+bqJttdD4rK5zivjcRGuADp0dO66nU1q+riRpeqeM1iJiHqQC9cQx2adzNdyYjO2TXdPyeaqwzEVyeLuagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USZ4R0cZ+Pi1OXet2bxikH3rcJBMw7YrsLca7oCDCbo=;
 b=c9iFlwS654P2jlg/unoTajT7rZBNSqo/lPNOYvsZP5BqLG+BpIcxJRd49esUCsK630P6M8ILgQa5es/HjpEEYWGwsEHW5PR4zIEWkavBWiEhst+WoSheO4FV5nZihPOiL/oII282lyGtTPlQVwZ1CkFyQd3p4+weZJHXfhGPVcQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ2PR10MB7112.namprd10.prod.outlook.com (2603:10b6:a03:4c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 16:56:06 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:56:06 +0000
Date: Wed, 16 Oct 2024 12:56:04 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm/mmap: Fix race in mmap_region() with ftrucate()
Message-ID: <4vhras6zlrv73di2fran4lwk3yhtm4uwgr34oitxvqtdm2j643@cowbnzlcyv2o>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>
References: <20241016013455.2241533-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016013455.2241533-1-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0070.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ2PR10MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: db85d130-65fc-427b-ff32-08dcee036d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C85BBXsV1rymUP8UKxqy9RCasAvhyP/uZeTiBBe1cilLo9Lwty7QeJTMvzTv?=
 =?us-ascii?Q?lWKfb9sJbILLptHHpV3oLcsZzkSr13O2WCHm1TsCMaytUAdlDeMO6tdg/0JS?=
 =?us-ascii?Q?1S6w5maPktH2/86vuxm5jqK0HbMBHfTXjmszga7uWXUW4TsPVr9z3db8oxo8?=
 =?us-ascii?Q?pDaznBimUKkh9OTrzHaEDo7oLc1SSsSVolQfzTW24/VwJFgpEiTRh+a4q+5Z?=
 =?us-ascii?Q?p68AabmRdBXWR6pIFN88m7NRdDFhkStDsF0n9wCqU6utw+3j3KIiPJUYwy/o?=
 =?us-ascii?Q?RxssxEpm+v5dXa3hlQBcfwLxtsJ79vcUhyOcbWqnr890Lr5kKVVKCueyC1To?=
 =?us-ascii?Q?QpRCqWLVghc1RauKssNLQXnPu4UazbPUAsRjnHB9lfZlb3v+UTquvwy+Z/XS?=
 =?us-ascii?Q?nihihdr9hGzwxBpWEeqzKRLnZ3Ij6mHBibaVL36DlqdAEUGOn5nJIdVggfVk?=
 =?us-ascii?Q?P2Y1C1B4dVv/5umzS0IwlVnTSGzMU/n+fIqisV/izlAxnvzzPKBdlzmq9qJK?=
 =?us-ascii?Q?QcXTo5dCN/90EM8+4UOYIjvxroPMdKVFzeUOZhQ7sBd3oL5ZCirwh6zqgyVc?=
 =?us-ascii?Q?9F0+e6Ryr3Xt7xKW2ERLt+AePM8ITKlEpzdruBmS/t2BWqidzVhEf83xt8lr?=
 =?us-ascii?Q?JuMLU9Ke9AqNqVKxmT/hJgGwCbvllA14l8ZkcynSZmS+POHiZViEL9JlppRe?=
 =?us-ascii?Q?RiEpKovRjAkCv9ErHbV4tp40GAkyQse9+NCqUoroR8nC8HA6DAXNNr87ahL0?=
 =?us-ascii?Q?EjOdjVNM1iScKbxgpVJdBS6R44qwSjJf/kW5uUGyJrkwMdE8/mK3woqywXQS?=
 =?us-ascii?Q?lhJN8Rt83t3i5Mtv8cow8Rmj9hTbuBL2crHeDOAgqFW0A8hR0HfzApQdefxa?=
 =?us-ascii?Q?1IEWd8gA7/sI/OMa1K70djF93pIJtXUz+2y8D4M0HaRWc1JA35R45Jo86CuE?=
 =?us-ascii?Q?tBCUfLgMPmRAHrctQ352TGuN5ndlhcJllIwf8doUQr9StSGhpAYzFLnTHHKl?=
 =?us-ascii?Q?EIBN9yD0rD4TlIn38mqaMjR6boLcHLWm/pl/VjkwPZgR6S+LOsw9Ip5O4l+n?=
 =?us-ascii?Q?YZlfcbMi/0msMYrLl37HvCqDAnPMQ/qDrMOtuNz9OT1HhhAAyqavCSy18Y93?=
 =?us-ascii?Q?24iNAz4VWqIDgb6O2jqHVDiQyN2hnIwtKNd/ZbopiT4E7vEsFcGCVppoCoxA?=
 =?us-ascii?Q?VxKQV74/U0tPqvemApk8RZm+wsTxIpODoz9kFGMcETf4WLXdX55C54RW5Gl5?=
 =?us-ascii?Q?rEoOouCQtbRp7sL4H/92hLk1Q7IHdDSi9ssKgDTjPbF/qkVSLRhUhfcVrChD?=
 =?us-ascii?Q?7aE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHoiN7e9X9IeIEzRXT+q+s4Nifal+tl4qiqy9Xdr+zICxTPAvd4/2ePnJg9P?=
 =?us-ascii?Q?eA3mlmnTu1DoDaNzzkcDs2nNV9z9t8EMfw506fr7TZxFZgpX28UDHxDSlCQ7?=
 =?us-ascii?Q?GFISzDaOnBtb0R9aPHGuE7hU+fHvAxIlH5N6MeX0u7S3KVDOcefXkwdPX8L2?=
 =?us-ascii?Q?pWMn8N6F6oH9b639IkvjzPxwV1zoH9V2Ipx2hh8rg2eT5cC1FttxUrWpRT2c?=
 =?us-ascii?Q?ByHf/QdUJyFC63BHC6Rsq+8PI40JvZ5aNmlwp+uVSuT7UOV56I+0p4jbBuWI?=
 =?us-ascii?Q?nCyTKvOfIqEQbtHxA3Rl1A7XqVQ3k3Z/IBxw+WgS0bqB/bdWtXYb+mrGogsX?=
 =?us-ascii?Q?6QZ5SxqoqfBaBP2plAqhRlE09gaLRzOUtUFyTRGBacgskbEGlRCSY4duWn8i?=
 =?us-ascii?Q?0tbmdJeKJ11MhP3icOyufV5i16Ko6/Wgwrf43KQtwa4z+KgxM85IhlY/0URQ?=
 =?us-ascii?Q?dUnhXDV4BHtF9poiO11RaIytz+HCm0m016OKT4qD2Z86XCydb4kjQv2rDCLx?=
 =?us-ascii?Q?VwlZ+6E9EHlicZrMvQ2CjnAWbu0KnmYXyeHsV12+mY5I5tTeUvfnx2Y55CCV?=
 =?us-ascii?Q?utUs8HLBChe4+pPtGlR/fwQklVbKJprOuQ1ake7E5bD2U5+QdjXaGTE+6z2l?=
 =?us-ascii?Q?q5Zu9uTMJirX2NWQW0Xo1T9RtsmGeTtI9IePKP2RvVcAQKF7BZFU+BSZuK8N?=
 =?us-ascii?Q?/Xp1RIfM4tFVi3zSYdxyzJh/6SDDeb2HRDvsDtJwBAojfDttEwZ2e104hZVW?=
 =?us-ascii?Q?GfndjfdBXhebDoVk6JfHYvO7FiKZPNT9oBgyiVt+q1Kz61tMehgPXOF6w0Ss?=
 =?us-ascii?Q?JI3kiyxWfY6ip8EF8bHUJdoLGyLrqxCG3qGpJx6pKEKtsoQSVZTs5FSMaMFI?=
 =?us-ascii?Q?zL11+m2ePdTItIIXkmgid4fFF9VOp4XAq1ZpoGTrMZIu46DsaUwk56zL6H6r?=
 =?us-ascii?Q?Kvbb4Ix8nagjfLktrrHoOfNbAI3CYYu8FbJ+37tMl82M5XDmBr69GZnhkFj7?=
 =?us-ascii?Q?azQUpEiMAF56rRh5rV43+OImp4SF4PIdDUtU29KDhQfkI/QDU9DM55B0Ljn9?=
 =?us-ascii?Q?UaojJ2RnRl6tb9hpMSgqOliLBDDJcwbzq9VnAlgsA/eRXYPONfEWZOcQGI36?=
 =?us-ascii?Q?tGpy0eMoOgSk4Kej+sNNS02HHotQDUF7o9tb2/ZDxtZKj+EFdze3bUsiCQYC?=
 =?us-ascii?Q?RPNxasdTS1jV3X6cs72lUYcQWPmScPPE/83++9EYZwubEf/of0fRDjnhmE5X?=
 =?us-ascii?Q?Vbfh1KOl7O+plbFhM4VafwmXpyHKNjYBBcTrQRvDfv7HrxH+yYAZjy/Vc/42?=
 =?us-ascii?Q?L2Hq6eaImL5VoJYYsfPEFvTb4RXNBz7xGEKRg8k8XU9f91DHQwFAWSkJkGVD?=
 =?us-ascii?Q?s+yku5Nh6Nu9UxIu8Y8P9hDTAfmEHVFs3c8O7gfWVD45fRcRBa0mPULe1m0n?=
 =?us-ascii?Q?Se2cmIpGwlmAh7VZKAfp0TcRQrQdZFF3v6b2FExd6ze+esgRlhXPJczka5Fj?=
 =?us-ascii?Q?o90QYdAI/H9WSvyxJI2vsDNOKCIgHg5UvtScyQn5U59TAUTf8mo/94ldHmMr?=
 =?us-ascii?Q?tyN6/McfACxbhF47DfIytPd5xYr4vscZcr9tt1giWWZ/duVXg9kadSVkzYLc?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qekIoWmdEdyBo8XBd1KZSTwOytCM+IO6GtfFsPREJOa2KHvZI5Z+YTtWc59X2nyvWcbKzwt+oN12MGLa20b/VjGGiw5/XXeZJ8qeUH1rMKOoLU70ilMuElcdX0X+elovsiwqtGB/mDRCS/mvxfVsYQyjA8JPCqbThJTQPDAy6LMat5tFNgFs2E+f8ioAFSDWVtYpcRYIAwxFQq1ed8tf4t0iSh2g/oKaLyk+X5jfo2vyLSWq7WD7Tf4l2R+Q8HysW3smIi494kqpR0kCt9kVYqIml+1YLW3hRQZ6WQzbaG9lEEq0DLr1raIaVNartmislBRNPxpiHfw17ElmkEM10F/9Cjk/yuEfFNj2oNTOGmjk/5kyL6oOQtvcerc/LNet7iaOyakJY8/wBrWUGIz/onY7MBbOhJR9LYrgDj06y+xd4Zk9PPRiwM0GwDW3ct3ZF0k8pCvjMRalG4qfrjR7tPePghrc5FXMIUAK051ZNC2u5cR4DXn9u0wxpknbhQSKHfr0OGUPUPbrRnn38xyBRmMS6P7e8/5m0APTMGsMsJ36TFOaH9Uv95szICjzn1pY3kZXXn+r4pv+14nHPpFrHQhjRxXUmby6LoIJy6uL47Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db85d130-65fc-427b-ff32-08dcee036d31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:56:06.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElONtyNQoo1/Rki9goDKwDsuRC25bAUMwAEnM0lcaWSAR+kOYNSKS7WmAS9DQFmMYOwdLPpNQIlvD/5sRDcpxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7112
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_13,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160108
X-Proofpoint-GUID: GwAboDYMaX5d2HPbdb3dXSC6J8vgrq3v
X-Proofpoint-ORIG-GUID: GwAboDYMaX5d2HPbdb3dXSC6J8vgrq3v

This should have been a hotfix as it needs to go into v6.12

* Liam R. Howlett <Liam.Howlett@oracle.com> [241015 21:35]:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Avoiding the zeroing of the vma tree in mmap_region() introduced a race
> with truncate in the page table walk.  To avoid any races, create a hole
> in the rmap during the operation by clearing the pagetable entries
> earlier under the mmap write lock and (critically) before the new vma is
> installed into the vma tree.  The result is that the old vma(s) are left
> in the vma tree, but free_pgtables() removes them from the rmap and
> clears the ptes while holding the necessary locks.
> 
> This change extends the fix required for hugetblfs and the call_mmap()
> function by moving the cleanup higher in the function and running it
> unconditionally.
> 
> Cc: Jann Horn <jannh@google.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> Link: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> v1: https://lore.kernel.org/all/20241015161135.2133951-1-Liam.Howlett@oracle.com/
> 
> Changes since v1:
>   Updated commit message - Thanks Lorenzo
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..a20998fb633c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1413,6 +1413,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vmg.flags = vm_flags;
>  	}
>  
> +	/*
> +	 * clear PTEs while the vma is still in the tree so that rmap
> +	 * cannot race with the freeing later in the truncate scenario.
> +	 * This is also needed for call_mmap(), which is why vm_ops
> +	 * close function is called.
> +	 */
> +	vms_clean_up_area(&vms, &mas_detach);
>  	vma = vma_merge_new_range(&vmg);
>  	if (vma)
>  		goto expanded;
> @@ -1432,11 +1439,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  	if (file) {
>  		vma->vm_file = get_file(file);
> -		/*
> -		 * call_mmap() may map PTE, so ensure there are no existing PTEs
> -		 * and call the vm_ops close function if one exists.
> -		 */
> -		vms_clean_up_area(&vms, &mas_detach);
>  		error = call_mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
> -- 
> 2.43.0
> 

