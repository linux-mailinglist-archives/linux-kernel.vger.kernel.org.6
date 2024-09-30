Return-Path: <linux-kernel+bounces-344561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853EC98AB59
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41ABC281858
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F7A1957FC;
	Mon, 30 Sep 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B9ACjArI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FYj7jgYY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458818C31
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718469; cv=fail; b=D9uWL2eynV6kBk2fEwmNaJ1KCI3nvwXg02Fyij+XFCAXihLbZPWK3FGJvptbRo5IBxEeoEU/9rryjpmbLBKQBvRjVBwCbWxnM4q9vhE91/pXNcoDor3BpdN5HO2s9UN2Xvu9jZzp45hP8lpieSOIAYVwa0c0uOHCuCQEybJ3qzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718469; c=relaxed/simple;
	bh=pSpklrrb0JmteAuNnqCA4WM0NSeeT8Jwqm2hydJ6P4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQEBFosMiZlaB8UaSb4z3HPktQClrBdDB9t3cKwUYSntUe6Rehf8xeNboC7wggf0kF3YZxDMefqL50PmMZCMwClqJGqdUeNMrYlSNRuJYEGKrkIqxQD91Kbzf1klckd6IfCL9swtRHEEdFtAv7m8Y1cBM9bOThzKvMXJU0vyFm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B9ACjArI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FYj7jgYY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UHBYZ9002689;
	Mon, 30 Sep 2024 17:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ZE9mWUi+AUSnU5t
	iaZx3ME1y1+S3nKdFLGc+1YHE+gA=; b=B9ACjArIYw0E7Z/YBvX+zZYwccuQyG2
	nQwuOeyPJmjjNp0W46ds43Y0Hj3F5B2nH03qR46Ht5lJwhP3Tr6BSRxisAu6YMeZ
	h26xHX4qc44gbrvfN9mDblfB2MFM1dwb6BilD+VgpeAMiWkwbO/pmk6lLJ7ULr9r
	r0ceFDJMr6P4rN4Rd2EmlewAotyKN4uQfLRxtYTwqGE7gEWVkQjgpNVimxhPOtjy
	Ly20VJjBptifgubQqJtzARu+BxlvInQgxSIxlk6zmYTtGScY6hZ5XruPsvDXcku4
	0wEpsXeA5Oz9x9cOFB51tNsZn7Wygup3SxI9UNQi/XnsQ0ztOZsE7oA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dsuy8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 17:47:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UHdrGd040534;
	Mon, 30 Sep 2024 17:47:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x886by94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 17:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXjAPV6NgoM8lnTQfAZ/J19jusOu2aBO7++LL8YopQfUTon2A/g1Qh0hnVtY59MKpMrfpoG/d8M3wGqnlUTdjJjfBmNC4tD0y5rYhsxJWrpm+ytFPjF5ukssSeoi5JDToyHNsIrI7N7mHy/r18WwVjMGYQ0im/+JamGQ8hFCCC047rrwm5i+h7BU2c7h8sOOVaMJDFQdnaZCShou9i/gdeYO9r9+2PnDzU+rOwx7RAkOtWwxsXX9+8grNpAEyJN66g9XeAOUMUJ50fD0rvM8hrqjItZnqsrYGMHKvHaEmXHEbWZbprawFZHGmR6wkaheahIlvF0j/ZMBgigaUHzgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZE9mWUi+AUSnU5tiaZx3ME1y1+S3nKdFLGc+1YHE+gA=;
 b=bEVkvWtQnbzr8LsZvNdw0RiDLY49gZm8BHdGCMYvIWwhxilSVFT3il5yGTJzDFDZOwP8ppV3vmTvB7dXIvTQ+COEOc0vYmDiohPEZ++DshBh491sdUkp7PbyPeSctmbaNjA9dCd7/DVl3qbtsmcnD01YnzLgol+nuqSgWPkbWtEeh0DhQFzYQpeBOJ8SlroxxSLDjFCcyHAZN8FOKfvmmxGzZ0QJ22LrxTEmsSV2voE3CN3FHswFPErgs94Di+CN0F8+SO0I1hxZd51ZQzX388lWoK741SNks0VW5sLTsvLQ8Q/aWByNxYvkFXbR+xoxdw3m1xviexxq5dskvEWf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZE9mWUi+AUSnU5tiaZx3ME1y1+S3nKdFLGc+1YHE+gA=;
 b=FYj7jgYYfUJHam64T0ecX/ueLYa5XhCidgRike7QdGPnlbgEJAftURPttPRt9HDYtNv4yfPjNquZUVQe0pvCkUS/3WgTmBxfJly9f3DDzd6mCq1m9+Dil+nZPULnzvBOp7VonSGpWKsCtN09QhiyyjHvLNeQxdEDR77wyaX4dbE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7160.namprd10.prod.outlook.com (2603:10b6:208:409::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Mon, 30 Sep
 2024 17:47:18 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 17:47:18 +0000
Date: Mon, 30 Sep 2024 18:47:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+d207c41e97001109b49d@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KCSAN: data-race in exec_mmap / vms_clear_ptes
Message-ID: <d45f5c9e-be61-457e-9a38-d8fdd5e942b1@lucifer.local>
References: <66fa55ac.050a0220.aab67.002a.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fa55ac.050a0220.aab67.002a.GAE@google.com>
X-ClientProxiedBy: LO4P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fa30d6-fc22-425c-afd3-08dce177ed84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y8SHo+EdEstZlWuQ6QZlFzdpOb97CwBQeiVbe57lnDSNUpfEDRqCsB662k5n?=
 =?us-ascii?Q?bToJgFF9c+ImDvpIXvxKGeqQUFbL/cMq9tD7Zx/thCsqoimF6nFwBIKActI+?=
 =?us-ascii?Q?EPoHHPdPw5TvluvFo8oMzMJeieLXHgT+ceL3UjBOlLu64ReFwE2feR502PyF?=
 =?us-ascii?Q?lHfVign3tv0ogYv48Bm1Ws7YNOd2/B0XHabTii/y99Ve3Ej7cXGdN8QI8HuJ?=
 =?us-ascii?Q?kHxd+aWUdibdOm+XEkX4zpDMRLVd5vjNdJpduOSBHISEFBEtPLyNlCacGIOu?=
 =?us-ascii?Q?+DB0Kt9VTtZol4gwiZEBlc/zx+KC2S9HJEI8CoA2z5qkZPu4iwqkJTdU+QmB?=
 =?us-ascii?Q?iUWAwT9kNTSbhUMSEvRdHGv6wix2+gvVlq4/4bKK+bYVQ6gt6UrIkWO8NdTz?=
 =?us-ascii?Q?2+omG5fzzv/7YrYFo2hla+Vw7fpNdwCe+oCGV7fPqrfPX0JVwabsP+7/mCYA?=
 =?us-ascii?Q?jvJ2dUK1VF+wEp941aw+xMtvB1krvT7wyMRowM+AMGj28yUu6FwwB9qfq157?=
 =?us-ascii?Q?VMZwsfzvQFZmjuVtVegDP/+0AnKo596qAEUQdnLl7yMWF70S+Vc/gJEH9pJN?=
 =?us-ascii?Q?C0U4/66vvjfpsqFm55LfDU+PL1ytTmPfDzoXOM5JL83p+oOZG7drWlOXuq1M?=
 =?us-ascii?Q?WjFjclRJRHIuAkcWt+Yw9ZfSOt7NGfqsnLDiNilT0KFaPJ/X5ecMhH+mtwjJ?=
 =?us-ascii?Q?1LLz0Q9x2YZgdyrCG+oANHxKkwcYmG0e1io/CavhMjJr8RNBFuYHz2ybEpmn?=
 =?us-ascii?Q?tfT+sxIEgd/yGJRVZFhra+q9xXb4xpTZIczHLdoGIl3ZNRxQctqbO2mp7csy?=
 =?us-ascii?Q?MzhvjtwTWHtCNqjtCps3B7XLbNMe2c1QjpE66iA6szsyT7ybZXNqjdr4W9k4?=
 =?us-ascii?Q?jxrPPZRWDFAGfjUsCU2VFyyh3VpVN/zqcUyt9qsRGoNlvA1NjKREiVoC/uC5?=
 =?us-ascii?Q?av2MI/efWjY+nx5OtDFIopz7RSEP9J0hZLz9xxWFDvUpaiGI1JH9Xa92O6H+?=
 =?us-ascii?Q?mPB/HL2NXF95e1yJIOwBHV4tudjFRibRuo/ftw9aRTyA+ylv3fOqrR5Rzkjr?=
 =?us-ascii?Q?Xru3vmIo1mwAQYWCdlwHwyu0yIJlWD0If1GnZxJ9KWgiI0H0OJ73rvHamUA+?=
 =?us-ascii?Q?HZ2IQ0mDYTv0ZW+3rl2BlsG7upPRQdazTohByNPaT8vAYWGXwTYQdhMtnurT?=
 =?us-ascii?Q?k8Pqm/qyG9zVGN6qJg/NDkZoN/k8/H29hiErLcx4bGFCLiRieAQWZdHOzAs?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VGn+2unIntE9bYdOXSuqBKjmbQBvOjfUNhaTA8JWCMNLLbYeQfyl+/n28+Td?=
 =?us-ascii?Q?i49OnC0Ks/N9iDL4x+OJf83/nx6AadhHLM/iULFyHg3DCGxbCiwsZp5z92aa?=
 =?us-ascii?Q?A+Y/FXABLJ2tTbD6QZsRYMw4Mex2le1RotWf7leR0b5gxXV42AgHiNQl4SYN?=
 =?us-ascii?Q?u/846Rx5+BpCYAWLrfdJBXz7qlgW5DtQXAxojY50e5LDx0kqDRk/5auWJjs4?=
 =?us-ascii?Q?ViWYRoF88OWCFbG2E9IRIJmh3WSYmlya4wx1cWfaZ8kZAB3gLP1JEAvcoTfN?=
 =?us-ascii?Q?YQFFx2SLGNbf9dZ3+tryuXOhpNwKz1ISPSFBXjpNAaPnz46HjJvsTZ7rIlAW?=
 =?us-ascii?Q?5qYZ3mYCUY3n4rjGqBtOuqdtKuPzvU9YTqE2IrYPYAars0UehRwBPFnWDggm?=
 =?us-ascii?Q?EMQCAH39/L9sVv9qZ9iZl2gqPja1OsvCi+mMQhpKCnWQ50fAsfv5Y8TYR75V?=
 =?us-ascii?Q?59kZlBGINpCBUbW91f8Oi5/qauh+dA//OqlYXeRMsxymAUJUmX3No1nKlz/B?=
 =?us-ascii?Q?oluqVLe4ZGJj1q6Op728DUPVQJB5akQDcdaXNRQ1pclY1TnEK+mrh4jH/zeq?=
 =?us-ascii?Q?3/cMtPPy7dHameQjN6jgOP8lb0DARwZKsoHLcbP2LX2XJmczbhgYsjRRyRVe?=
 =?us-ascii?Q?Q7+ft4qY+NUBYf+R98417yPScHfLbU9839DDBiTt3RBFazGoeGfIOUI0MBSr?=
 =?us-ascii?Q?ym5j208D5FE0m5C3q0QcD5xHTYZpfeLaESeijWe0UrdEJalRGjje9sgFm/JK?=
 =?us-ascii?Q?SWCQ1Z8XnXwK+mo8p/NmhNjrLY/I4N4jd4rPta3D5diFLV2WP8+eKtcQuhac?=
 =?us-ascii?Q?OEz6ubUCQrZw4zajFGJCln3+Kx82wScRRFZofzuvTO9xcJCvVtSx728Trz82?=
 =?us-ascii?Q?rAbJoJ8bAx0Hz7Z2+8qRdCXpYlozp8WWBhVRuB9APl3qPqH4MEBp8KpeefOs?=
 =?us-ascii?Q?I8djAd4pjXUYmpdJxlTNYEakLg2Pkgb5cr7jmEeqrT13CGaStyhc+0YNChYk?=
 =?us-ascii?Q?XPxiOKKaoUAnlFnco5OIS/GEoq+8JwAfNXQUi1sR5WhHz/99DX856onTiCP2?=
 =?us-ascii?Q?/uYWpGol74Wvb6iRzJVLNwLgTViiUxt80PjTfa8lwt7TEgwDB9Cst0ayd+v0?=
 =?us-ascii?Q?bsAT0Acqk1rNRsgNfDX074PzoQd6gxRjDjA0h6eQmJ8zLkPcbexwFv8Ej7zT?=
 =?us-ascii?Q?WBEUsBXXqnh13wZ56zEGsEl10m1YZbclH2B4R798K9j294Bhp1iriKLxU8k1?=
 =?us-ascii?Q?m6rH2FNxLwoLXoFtrFtsTGEsKwATUeUEau60bN+jRmP3Q15B9g/9FizI0/vT?=
 =?us-ascii?Q?i3anrnKjbI53qTyNlGIgN+x0+0/GzEPEaFxYIg45QEDHOpoaHIEgp+jhvn6y?=
 =?us-ascii?Q?zSWs5CFQigGoFPgNeTBNS514lreSrE6hczaawUz+aA8+KVFWtyE8UnGktXx9?=
 =?us-ascii?Q?oVoykmAZ23Gt/1B77mZtsISX45ICgwFFAsaiKVYbJQJkACt8HQ03SqfXGYYk?=
 =?us-ascii?Q?UkV3641IZkqqctr19NMU2behAuVuDyHXRnlrt0SYMNC+04BxvGLqziv1BXy6?=
 =?us-ascii?Q?jd7+TQXOH2bGtZ2QhMuHLD/nBHjttk4nBJtlm7FNu036c1shClk04XUnt8Ht?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nsLFadUZ5xy6FD9mNx2EQaTkcW/affGGltadPRnFUYTP8y+9MgRjVT3VdfV6cWT8DtUcegQ1fSTM1A8TLxhwDmu0rYqnmailj5VVFa8fRBHEq4Z0hlrJ49Tuk8thjvSihOnxL3iM3vkhu9swlQBKh5o+NPH5FEZ8KyMUtfs4BI+SVU9GJ35F1Wdjfb9lfiexWwHgYmTao7bOzXBG7RD8ZVxeDEBvoEmJOOzCbKV94Cptc30mIh/nE27JUTzLqZJfN+VDv8w1MDFVYY8krJSX0iMoGOopbYhRz5v6cOu1iV/IG/2n2rkyhaOGissVkes7k8OAo3BYkmu7OSijQspLXXL3R2mSlp6flFcqB0cRw55jLnkrbLMTNSl3TkTrRcSLIH5uQcNsyCCT7v/rUxg1aICLTgRcf3W+qUp9A0/FyEyAorx9ZZlMnsRxNBrWlpg1wqTdNBNrwddoaeSTL44gUW/xSvs/HfTEXMjtnmTvpjKJ3jwx2FhLBt4dK4qd5QOqLONi3zx/y3oQIS23byBtru2d24d/MW+KLBlotFXIY2CdaXcKAMXHIooL7yj23hRIrr1FGN2JTeLC5Z++DYXzeZrTUMa/4EjMmOzOD6eYTsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fa30d6-fc22-425c-afd3-08dce177ed84
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 17:47:18.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ca1SiTnsNPN7dnrhmPvBrJRENhP5G20dQupkEr8qhEfd6maVfuTwm0xBc6p/bsexTsFXaDrWB+y2KLkeCvlVfy3baMJq5M2CzE645Uellqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300127
X-Proofpoint-GUID: p6Gl-UeJX3aV1TMGuBkTd96Rjb01d4Kv
X-Proofpoint-ORIG-GUID: p6Gl-UeJX3aV1TMGuBkTd96Rjb01d4Kv

On Mon, Sep 30, 2024 at 12:39:24AM GMT, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e7ed34365879 Merge tag 'mailbox-v6.12' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15238ea9980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8bfe37bd3f5983d6
> dashboard link: https://syzkaller.appspot.com/bug?extid=d207c41e97001109b49d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c86c1297298e/disk-e7ed3436.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8313c0846b3b/vmlinux-e7ed3436.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8af10d85db09/bzImage-e7ed3436.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d207c41e97001109b49d@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in exec_mmap / vms_clear_ptes
>
> write to 0xffff888102fbaae8 of 8 bytes by task 3004 on cpu 1:
>  update_hiwater_rss include/linux/mm.h:2655 [inline]

OK so this sets mm_struct->hiwater_rss on munmap() via update_hiwater_rss() in
vms_clear_ptes()...

>  vms_clear_ptes+0x1a7/0x300 mm/vma.c:1088
>  vms_complete_munmap_vmas+0x170/0x480 mm/vma.c:1140
>  do_vmi_align_munmap+0x349/0x390 mm/vma.c:1349
>  do_vmi_munmap+0x1eb/0x230 mm/vma.c:1397
>  __vm_munmap+0xfd/0x220 mm/mmap.c:1600
>  __do_sys_munmap mm/mmap.c:1617 [inline]
>  __se_sys_munmap mm/mmap.c:1614 [inline]
>  __x64_sys_munmap+0x36/0x40 mm/mmap.c:1614
>  x64_sys_call+0xd32/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:12
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>

> read to 0xffff888102fbaae8 of 8 bytes by task 5494 on cpu 0:
>  get_mm_hiwater_rss include/linux/mm.h:2642 [inline]

...And a racing execve() is trying to read it.

This is a bit of a tricky race, as we downgrade the write lock to a read lock in
vms_complete_munmap_vmas(), which allows exec_mmap() to proceed (as it's under a
read lock), and update_hiwater_rss() is called against vms->vma->vm_mm which is
set to the old_mm and...

I wonder if we should just be referencing current->mm in vms_clear_ptes() which
would avoid this as will be the new mm that has been execve'd in (and presumably
do nothing)?

I don't think in practice this should have too egregious an impact as the
process is being execve()'d anyway, so I think we can wait for Liam to return
from leave to give his input.

On your return - Liam what do you think? :)

>  setmax_mm_hiwater_rss include/linux/mm.h:2672 [inline]
>  exec_mmap+0x2d0/0x440 fs/exec.c:1012
>  begin_new_exec+0xaf9/0x10b0 fs/exec.c:1280
>  load_elf_binary+0x63b/0x19e0 fs/binfmt_elf.c:996
>  search_binary_handler fs/exec.c:1752 [inline]
>  exec_binprm fs/exec.c:1794 [inline]
>  bprm_execve+0x4e6/0xc30 fs/exec.c:1845
>  do_execveat_common+0x793/0x800 fs/exec.c:1952
>  do_execve fs/exec.c:2026 [inline]
>  __do_sys_execve fs/exec.c:2102 [inline]
>  __se_sys_execve fs/exec.c:2097 [inline]
>  __x64_sys_execve+0x5a/0x70 fs/exec.c:2097
>  x64_sys_call+0x1277/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:60
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x000000000000022b -> 0x000000000000024b
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 5494 Comm: dhcpcd Not tainted 6.11.0-syzkaller-12113-ge7ed34365879 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

