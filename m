Return-Path: <linux-kernel+bounces-440112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3FC9EB8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B032833AB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF84204686;
	Tue, 10 Dec 2024 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ikt2ePzA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TBsAE9G6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4448633C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853898; cv=fail; b=oc7ntc2jTo1H5SxdZ5YGC6x0JwKBSJD6+0cmd7+MId+6dVh0IjXzUYzNgZ5L7L+2sXGkV5eIQT4cch8hJfzTNXhrsJNZ26n2oapZMWyKV9cgHmFi2u1o1NoHvrDDqjknpIiyI61N+GNmNECOz77AhLT2HRtOVJK2jdMLuDcLjWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853898; c=relaxed/simple;
	bh=yUTkEyxLAIHHnVxXiPXm5DTiDjOwAxH07UHawkXHyRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dauoZk5gEMvTLmsQY9rCToe/d75pWLo+nArjm54JPdAhYdHWVLz+GUI3HqP/eUWj1CvaXeaGthLc+GGP4oR/GznFR1lQF9ft1QAdVrcErgUCXl1cZ6B6tFWuU6k8CRmwWNBA0+kR9aVWG7n28xnoxAsRL6pYiRJZtvKOuuP6MIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ikt2ePzA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TBsAE9G6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAGQkBZ007121;
	Tue, 10 Dec 2024 18:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=nS1mlMmXP5hyPnGNuV
	FomFdCS8GmeHJC96TYqbOJVtA=; b=ikt2ePzA0LpUjXOvTQclLsRK1MaPRpEHvS
	3l0wv4Q9uguO5+g1JJPzwDNNHm1hRlHMVu63rUEZGIHmkzvSpx5caJ2oXqH071pX
	AnTukqV4HAlzGWBDWxbIy35d6OBRaHNCZUxXFvm+9KlaMUFidrzNun1ZKUsLaN76
	Jc1XQsHKG8RAuzHqGya13h8k5GQMHjH3mZg+jnYxv+Zd7jA8Fpw2WC9gQXyh4uT6
	uIKyjbAfa5S8OdAhz+mqVRo7z9UxTWxUnWWIB9qxDhyVi7d9pm5GYJd5hf8MtKG0
	rRDq39iY7X5SJsR9PTrLuWjL+Q/O/TlCSWIkRRfD5+sRSOxoB50Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s3k8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 18:04:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAGkGv3020608;
	Tue, 10 Dec 2024 18:04:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8nrya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 18:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIWzgiy5jGqeI1yW4ExEzHppaVPOFr8j7EZL5W2iATG0O/gmDUujt0Mf+495WA3RI3HF/I6N6n10njrzLm4mZ9oTtGdelBypqlAb8tN1dfTuYNIQdLMhoF6zfbKV8BBxo9oQVpJf72+suSTShXQ6MrLw2bOCGrnqV9/TBpwZxFqNB6Zl1fI7uZkqmePOPon4n+DX4XcBvpuFZJmgZTDKi4vCrseUMm5UzgBodxmqaeCOEgM9u0nBJKNRP+s3MofM3qaRNiblMWKxIY+PqC4arO7akDD7Cg46qpklFxrpoIMoZqmavgimS1aK+VeCVmnDUbc0124O7O/e54ZACeiBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nS1mlMmXP5hyPnGNuVFomFdCS8GmeHJC96TYqbOJVtA=;
 b=JL6jC9SvejpJLGnkmovT7BntlnTNaM/zkK7XgKXU/ZfMA6VhHcBPTT4RFZ9zkk71b5FvFykcxF9BFM+QhkfwWPHhP6qjU35vbQd8Ak/sfXSgddyEUqedVULMYcOE86lbe99Mz7E6jdOv5kgCcqtfn/7ykd44IK/olXUDGHxTH16YmaoupQS56EbX0xT6/WlDXgIep7Rk5EBMqAVADwUz9O0YbMqadaLvO3zqhlyx9nI6JWBKTOO1Jr7TjAeyGDR/koPrFAThbXy+NegY/WngaG0IScALUpmMRq62WnNrDv05n7Sy/bmlDJGhwk9b/EhOL3VoyRbAZctab35nQCSuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS1mlMmXP5hyPnGNuVFomFdCS8GmeHJC96TYqbOJVtA=;
 b=TBsAE9G6dWhBU7r4jhoaGpw0xZPGX9z7p0CXwzUFouWzKDz6W/xO8UxWTSB4O1ASicSlOvYcJqNzWbBnyABEz4cPcN41hcNyXmjxmrcQpH6jbwDPJoPCKCqbGdO7NzL5e6HScX64lacMB6qhFgmFXq1ynH/cC2D5tnYWdDjjgJQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by LV3PR10MB7961.namprd10.prod.outlook.com (2603:10b6:408:21d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 18:04:42 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 18:04:42 +0000
Date: Tue, 10 Dec 2024 13:04:39 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in mas_preallocate (2)
Message-ID: <4zkc6urzxtcmcfchuv26lrieaug74u4l3tbvpyryawklnlxa3p@lrs2nm5vq2kl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <wx7x2qzdmadbdjy363jqz6nsfcnr3tougzlvb3oeomlqxjf6fl@dygmglqiqyx6>
 <6757abe2.050a0220.2477f.005d.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6757abe2.050a0220.2477f.005d.GAE@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0074.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|LV3PR10MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c9002c-1cb3-4453-1cb5-08dd19451f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HDDrLYeNTyi1r7I4l7v55feHL0tcdAd94jJVXLZdikZblMqYEMGnshH5GiDK?=
 =?us-ascii?Q?tA6LKwmiGh8Oruq8aUPAgWt7qmLatP7wvW+4esiBVQLQ/5CNq1iuJQp0eK3y?=
 =?us-ascii?Q?1WwWgchG05O65tgE0VIJQYnyLPZaeOr85WnPNHY9SjQuoy8EV4Pf/XNcQ8oP?=
 =?us-ascii?Q?MJD/tmKoZsQWiDfn6hIJ84tJX/6if70FnFpcG0dsY8j85YHQ0jxksedYHvmd?=
 =?us-ascii?Q?eEwcWcEePyQ3LtmmY0QPKxSomQSPLn/8sCaF2FeDbsDBbxaChP1sQLYF2i5f?=
 =?us-ascii?Q?SGJ1fbQNVkvUAO9WXqeC83S9Dpz3pZtrOlhmOvXZhr5+Or6sVNW4lDJy68v5?=
 =?us-ascii?Q?lsD/jGXdkS2Hj9ZfC/qYBzpb/YA5hzFGNprnTzoDWfh2idKyHKLzxNEJMIs9?=
 =?us-ascii?Q?RCtahOKK1/rm+MytBdEM5qNnc6tSkIPsAMIEH8N6EeVQR80g6V9w/4OZ0z53?=
 =?us-ascii?Q?ox5K1WhpfzT2itYo6rdAZrX5DZhUlvb2cYHtFLv6ppXd8CnoP4sDXlRiEGud?=
 =?us-ascii?Q?Vi12k3i9Nxj+AqBUNOwaDSAfviSDi2cvBGsk5jtJiHSM8gR7Xk3oMj7tk8Ke?=
 =?us-ascii?Q?j7hMwPv2dW27OPC807C9RLYV7w/FMQ6ZElbr66mzJZzxO0KKvEiOcx/8BPLk?=
 =?us-ascii?Q?7Ox4/PDg/eCHV2i8xJn20BS3pzOiVMiubdtmJ2mv4gZSYG4seKPIsPssqK4e?=
 =?us-ascii?Q?ZkXrw85V6J/2J0SelZkprReArRyifmqTFuEe8vkjieoP2v8QrsHK9s7zc/4j?=
 =?us-ascii?Q?eSGcMHy4sO9cHoY+PidwI0PJU7mpYQZM3NEXK7ulzuzdSIgzuMjm6iWORYHp?=
 =?us-ascii?Q?r790FWJYA25Kl+5kX/m/ZH22x1guxha2rtQSVqJOxmzBP9v6m3vzMABw9rF7?=
 =?us-ascii?Q?Cx17+K21EvRqkcj93n3YbkWBUtEfSQ20a/CRzFtE7utJp+crUuZ4GSJ82y47?=
 =?us-ascii?Q?IHsnNZSNBv0qGz1KootRYT0ICFESbjng+vWP2QydIrt9huA8N6H9Kr1JjC0b?=
 =?us-ascii?Q?RYaI+6AOrNFY5LsTSNENpqWtwcVwMdUIIyskO2O3CZiR42aaG4cWnuOvMZ6m?=
 =?us-ascii?Q?56gFr1pUKgwsehu3k/CwWs6bveO76YOyjZyumZ/yR3h7+gkZhpwn2WQbFDVF?=
 =?us-ascii?Q?u3017/PpAo3KF7STPXAPzmpyLozI1PNksVWYVOg1djRGCkrLtPJyVto4XnKj?=
 =?us-ascii?Q?t36r9Nh6n1aJqL6UpRUnnUbGqVIYmG78qxl7nEdi5e9+JfyI9oTBEQvB5Jta?=
 =?us-ascii?Q?d3FkT/dE8KRazJbrm8XS1q70DWD09GpDA7x/3OIbbNuc+Y23hLHaTxXLgRsI?=
 =?us-ascii?Q?QzzZRpYRWzO9BB5fEdtGvE/EY5H5UNf2QcVMoS3M0DPZuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qv4RCztHSlNy2gWtofNaWxIBasKiLcAzHiod/TyApbM5wA1UeCx5VJTOXyW+?=
 =?us-ascii?Q?kpwfT+VeJYgFr91TnIMl7IvG2cA0XcAn2lL9ENwAJKu03khnCBsjtjTKDY33?=
 =?us-ascii?Q?MYjv8k1QvEmDkQuxzRPPcR94YW1wK4EeQR5EIWG3lrn3ZcS0huQbjXC6NVvq?=
 =?us-ascii?Q?xVyZUyHbsK6HTqaVwlXVGBtGZLrxzWAaDLtllNtq/7Fdy4NblH0OO+GDzyuW?=
 =?us-ascii?Q?DRp/LE44Qwl+dWArDjvo8hVTNfwftuFMIcuSFie0TqiXUcwalNsjLKmoA2aD?=
 =?us-ascii?Q?jahR1r4LxiPNQKza5d3rojuM9ug38kjJSoiHtSobGxu989oKtaHK3l4n7KA4?=
 =?us-ascii?Q?C5A4lkG8DxsLqxkav2yeTN7KAwB5Q/Xhzn0P4f1qNpurSPLG26u6wUodBTPp?=
 =?us-ascii?Q?p8AY7/DtMjVyWwkoDrUYcGBIC69i2tkZUXC5FXKIt2FnfS6LhWbqgFi6mJrw?=
 =?us-ascii?Q?6JUgP6N80NCz49kkutsQ9An7DkDw2za7pLglE7/m4yvpkpPJh7a8NrWBnaxl?=
 =?us-ascii?Q?cuZkEEA/3azIrETn7nDoOgSA1Ac5l7euAkZrEv0hAzVeqZnIX+bDnmfwX7Qg?=
 =?us-ascii?Q?8EDRMf8nfQm20+wc3f79Xz06wdX9rmor66iahZo3OjLExLO79rUdL2yyGuuO?=
 =?us-ascii?Q?Y1uC3M2xBHGTVIRER5fhv9rDquRaRNyXoJU61ehoztSSQXeYfDLVdEWRmQUe?=
 =?us-ascii?Q?fVgXU+CgZUd0hpcWDt9jJdFlz44vGRhhYXhyXdNfTM7gHwyGX8c3ZmTKutBA?=
 =?us-ascii?Q?Nqp1WSu/yH23xCQq73wUL/SExxNmewMKTpj9+UCgU3MXBHEl2nmtZBN+cW++?=
 =?us-ascii?Q?2sd35+XIcWjGpjuzjhF/N/4/YD5RzGs2fFxjhRNwQ4pN7Ls955b863QOoaAt?=
 =?us-ascii?Q?X4+fxTwv4LHnqk6q2dlD1z5ZViwN31fDMC9f0PP7tBWYSDWOJJqQUCgga+PH?=
 =?us-ascii?Q?SOxMSC4zaJeaxC34Y5PFccR6b808j8JSe2Z9VOZ73ikLT/MPQB41v0/QPvzh?=
 =?us-ascii?Q?qYEZccxhHFHQLCw0WeCTz91KK6L9sTJTlzATzhaYgsuyPypX/pDL3c2c74HB?=
 =?us-ascii?Q?CGtAfm3lv2jZQP+wdnkj0ig2i5P5jsUCWOlAF91sanPCDMU6gX1CP155l0q7?=
 =?us-ascii?Q?mlV7a0P2v/5Ex7s9GipV7AjZOwet2Xd50O5CtjvRGTZW4OoTKf+n6Q7siTxl?=
 =?us-ascii?Q?0bqmqMDFGfKVC2ax31gqtDbsfE2ybTmuYjB/NTvAY5LogGdJetf3PYqZe+q2?=
 =?us-ascii?Q?t2TI1RxSQEd1kYtTg4cu+/rOT0F+swnIvge+9uskyjtOx2pJP+/uEgNlDsvu?=
 =?us-ascii?Q?P2lV2E73St+ZzJLcCJR5aUTbYeEBMRXlThBzF0Nh8SJnTg1Nruvije8OM8iO?=
 =?us-ascii?Q?Al122JCtjq07w+hPTyu/xwZkGSXoEbiU42bq23erCI1XtOypLomJ486NWWs1?=
 =?us-ascii?Q?Zhqym4X5T4kGQpW8GNiQIeNpTHcLUZwuiQmL0qbbrekYTPUEIWB2Q7ByLLTm?=
 =?us-ascii?Q?z9hrBQIG5RNn7U9dvXMzqXvbaC20etKAjSQ5KB9GWlbVUGc3GKMDh0YA6mqO?=
 =?us-ascii?Q?I4guK/O+lpQOO2GQ6E2Lmwb2W4VGSWIqZvl5COrx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wao2YK9YhX5sfMlBAeOWYxBcRglvIUQrhbtzF4/dvXD5uILVk2HkwQRStB5lrpdwd1lTa75Alb2IvsXk62A446PpOzaA+Gxn4iY+pQyxHDEmAHGZttioEBrwgQSTnvYgjYE+oGySNDure5kbjbxUNTeToRDpIh9XCldsNMYtua1h9gQm0mwRHxZ2ElTLpVxlY4aRzDp4OhMvHMOxn+fdcOdAxEKGKeYHKoB1+pMdo0QhyLtdC1awzkXyKa/dOFsvpqPFk0TbZX6q5Tmt3KeKMwDJx2nDQwsNbTn3nvK9ER+mLnG6s3rlZzqdx+L7Evfqg0gc+qnBzONhwhoKEy/Czp7N89N8hevHzOytBoX23RkXpqGSYgGOmg3JOeZOnMpr6cg6rCYiN62MoOkzbeQq/mwkPqwrPWeXkj3OLF4uLPTRIDGbwnpvUE6p+zGfgXTZYlckX3NH4xEaW8ViV33OsV4xeONj7SJOChY0Nn2gjdN9VSeQNYLLYUbxKYjbafjlY62SjNIYduIgL9A8JKUpxVCriBEjaVv6u1W2QfsYDtQL1Bv7tL6z+tEw2v30JSog1/pG4T/OGlAW+SH3ulV9necYp7BcX8YVuOeMn+bBvt0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c9002c-1cb3-4453-1cb5-08dd19451f3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:04:42.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl7GM0D9kELYQ1hyypllqgPQ5eOR4ICffRMiz/VS6EndHllfVfInNYXilXX35BcI80RGvGpisklQPxnm0K4hhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_10,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100133
X-Proofpoint-ORIG-GUID: iq9I_-A0PXAkuTR9sJ0OvCAq8DJ7rDlr
X-Proofpoint-GUID: iq9I_-A0PXAkuTR9sJ0OvCAq8DJ7rDlr

* syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com> [241209 21:48]:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: rcu detected stall in corrupted
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 	(detected by 0, t=12997 jiffies, g=15009, q=2022 ncpus=2)
> rcu: All QSes seen, last rcu_preempt kthread activity 12997 (4294963490-4294950493), jiffies_till_next_fqs=1, root ->qsmask 0x0
> rcu: rcu_preempt kthread starved for 12997 jiffies! g15009 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R  running task     stack:25624 pid:17    tgid:17    ppid:2      flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5369 [inline]
>  __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
>  __schedule_loop kernel/sched/core.c:6833 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6848
>  schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
>  rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
>  rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> rcu: Stack dump where RCU GP kthread last ran:
> CPU: 0 UID: 0 PID: 6541 Comm: syz-executor Not tainted 6.13.0-rc1-syzkaller-00172-g6e165f544379 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5853
> Code: 2b 00 74 08 4c 89 f7 e8 8a 0a 8b 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
> RSP: 0018:ffffc900042ff080 EFLAGS: 00000206
> RAX: 0000000000000001 RBX: 1ffff9200085fe1c RCX: ffff888025bf8ad8
> RDX: dffffc0000000000 RSI: ffffffff8c0aa9a0 RDI: ffffffff8c5f98c0
> RBP: ffffc900042ff1d8 R08: ffffffff942a0887 R09: 1ffffffff2854110
> R10: dffffc0000000000 R11: fffffbfff2854111 R12: 1ffff9200085fe18
> R13: dffffc0000000000 R14: ffffc900042ff0e0 R15: 0000000000000246
> FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe0e0053440 CR3: 000000002d710000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  </IRQ>
>  <TASK>
>  rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  page_ext_get+0x3d/0x2a0 mm/page_ext.c:525
>  page_table_check_clear+0x4b/0x550 mm/page_table_check.c:74
>  get_and_clear_full_ptes include/linux/pgtable.h:712 [inline]
>  zap_present_folio_ptes mm/memory.c:1510 [inline]
>  zap_present_ptes mm/memory.c:1595 [inline]
>  do_zap_pte_range mm/memory.c:1697 [inline]
>  zap_pte_range mm/memory.c:1739 [inline]
>  zap_pmd_range mm/memory.c:1822 [inline]
>  zap_pud_range mm/memory.c:1851 [inline]
>  zap_p4d_range mm/memory.c:1872 [inline]
>  unmap_page_range+0x376a/0x48d0 mm/memory.c:1893
>  unmap_vmas+0x3cc/0x5f0 mm/memory.c:1983
>  exit_mmap+0x288/0xd50 mm/mmap.c:1263
>  __mmput+0x115/0x3c0 kernel/fork.c:1406
>  exit_mm+0x220/0x310 kernel/exit.c:570
>  do_exit+0x9b2/0x28e0 kernel/exit.c:925
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1087
>  get_signal+0x16b2/0x1750 kernel/signal.c:3017
>  arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f479f176197
> Code: Unable to access opcode bytes at 0x7f479f17616d.
> RSP: 002b:00007fffa52fadc0 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
> RAX: fffffffffffffe00 RBX: 000000000000199b RCX: 00007f479f176197
> RDX: 0000000040000000 RSI: 00007fffa52fadfc RDI: 00000000ffffffff
> RBP: 00007fffa52fadfc R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007fffa52fae80
> R13: 00007fffa52fae88 R14: 0000000000000009 R15: 0000000000000000
>  </TASK>

This stack trace is significantly different than the one pointing to
maple tree code.  It rules out the vma tree being the issue as we are
now being interrupted in page table clean up.  It doesn't rule out the
tree checking taking too long and causing a timeout.

A C reproducer would help, so hopefully one will be produced by the bot.

Thanks,
Liam

