Return-Path: <linux-kernel+bounces-387414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6919B50E7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A8C1C22AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF47209699;
	Tue, 29 Oct 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H5EXhkba";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z6LpSetf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D9205AA3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222966; cv=fail; b=Ul4IS1BsJaMpYJfpA55SVFKi7SHIndGdUyowfh55xZXvx/gLTmg1g/bB3O+UlHXr/iGz6z/VeR1p34uJ6iINTGdWNKiahQAh9shDK//Wb055YDqUwJ/9ewsvdmHWCm5rn7QSA09dhanloukcplqr3Xqvg45kHOPFpELx/fVWHOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222966; c=relaxed/simple;
	bh=+IL3hIIf/aybjYJziMoWsC6wZG+tmk3n9iDr4nDAh1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KhwVhE0LW4Xz5fzpZggiQuWY8QvlU1kspo0lt35JDMH2Ps82ImPjnzF4bAj+Yj4YCWZPuRHeSEZgSvApneHVxtZoO013qWubbB1aOobqX0S4ytcQNejZ+aBJThhJEz7JghlQ6M6dbCvlTS2+Xp0pv9bO16hkjSFtuuEVf7g3tuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H5EXhkba; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z6LpSetf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfat7028619;
	Tue, 29 Oct 2024 17:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IBX2Wq57jmeVsupTBe
	7ouUIq9MurluHdkpcDK43iNcw=; b=H5EXhkbaGhjPsdf+AwXYrbmBy29ShFpFIs
	v4NZM7w42wW/EjkmAbPCCwE0zRiwbZyyV9DLvtKzvEBEolDHmxBsAJXGt89nT/2f
	lC2D/AkbNTYOasVP6fwceCoICHpEJVt14B/0bfCrE8ERympYnIjTY1gpgvwNjqWz
	xaQS3+AFC9g6nErBIC5tMqB29h40PzqibGNLj9P3qm8GN55GudkhTOG+tZBtwk0p
	2N+we1+KCP6JVgflsKmC3GcirMOvA1vQexXD2VWBRkKL1uxY0ywrDn0YoSZ5XXTH
	65h15yT0VEwlfD2JNbWF4MOFSWcBxwzdoWWq5mWHO0/JqyzYrgwA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqe2qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 17:29:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGUJfC004774;
	Tue, 29 Oct 2024 17:29:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2ukqm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 17:29:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNtKjIRivn0Uc3PXriWK+i59Gx17+yfE1BU8BRcWSPRxgTop9c/N2GiMpRotZv5K2ZO/yTpLqTRmR1SJEWD2s36bgARqUUIOH9gnoZIQtryCgqouDayDEvcF0DNMgS1QbINBW6ocKuWt6rb5/81s+RmydJbc14LjkaJe8ZxK2V5UGjFcfx0Ws8v1GYLpgFZ7n17sp+x7aaAeL5Pz+0PdWBm6CN9GFKXDpQSdvYd3mYGN7U55JoFuatMWrvCGWW0lzSxBsH9DhCS8pNNqIemLk+KmAfhr/+1bhAG0houzbO9Rj6JRp1hjRTbw21AzG9KIGhKWV8Gk7x+G55dYC9gzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBX2Wq57jmeVsupTBe7ouUIq9MurluHdkpcDK43iNcw=;
 b=lHZnuWEuJOFvfPIxJSPTOHSa8qoldjt9WLLvtmM9XZ3nJWYRVQFhcYmkHLghjq8GcsOWCLi/ESePucBiIrts6jy8zW6zJlWRo4zqsiqiYQty3jUP/3zk86LMJRa7IjNGJeoMAQKVlzD4Gz7teAPO6M2/ry8xk+jMMHNRLYz2hR0OHBYTbfx7oUIwdk9t2yF3I4vWbR2RrW9HDZ9BRICuE8DYDYD6H2Sjcrb5E+PFRcKTDvC/BhLeyhfU0pmqu4S8op+yWJ8YIholE/IIYfwJFSt41wq5teGXTbgriW7p5IL6b5C8T2o78aF8CuYnZ9zVDdB524WtQOq+wOtGEworaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBX2Wq57jmeVsupTBe7ouUIq9MurluHdkpcDK43iNcw=;
 b=z6LpSetfmuEGoYO5Jv1LJnAdqwOQHK0mlHIZf/n4B1ymSQ4LRduD5XjM+bLQq7DHeZ9G5Ejmj4tQmwuHNZiVAVcaXDQ2SXQ+s07i4JvDeH0Kk4Ygg9Bd7wmszg6HVwwQzkGhGeN4GyHOfLac4g9ydzcrYtOI0KNTt+9OkgGcZ4w=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:28:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 17:28:54 +0000
Date: Tue, 29 Oct 2024 17:28:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <2759d754-9bd7-4bc0-a4a3-42f733fb2596@lucifer.local>
References: <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
 <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
 <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
 <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
 <ZyD5iXikMzotl9mU@arm.com>
 <da15a72b-c1de-427b-a764-0ebbdd3f6a8e@lucifer.local>
 <ZyEL0s_qiyAYURR2@arm.com>
 <a050599e-6d43-4759-b08c-d37c0d28ce0e@lucifer.local>
 <ZyEVHy-767RfFwh_@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyEVHy-767RfFwh_@arm.com>
X-ClientProxiedBy: LO4P302CA0003.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB4519:EE_
X-MS-Office365-Filtering-Correlation-Id: 13669993-4b71-4ffc-37a6-08dcf83f292f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Wno3cjvTDJGi63sUpfZzXHnY6NreKaDghJm60/1o9f9h2X1y7RwY4txMFBl?=
 =?us-ascii?Q?jvW8IALvH2zNzTnu/bjUobd+jzeV/KPbtoVM/yyuT4sIf4+G7BHgQ8l7Ka9j?=
 =?us-ascii?Q?WaZ4AHFaEkgKa2sYmW1+l18hZolErGmoH1qSMxx0tX3Tz49fBa+dj6llee9v?=
 =?us-ascii?Q?0TpBZ010Ez2azo8GFNRSMhDzDWsaXTtZIsrwqZlHVjUCHgK8YqarPkUSzbZ/?=
 =?us-ascii?Q?N6vAtYnknqEo6F98XHBXmIY+aZRia31IkJQHrSYFJhMwkxrqPxcudt1jTzD2?=
 =?us-ascii?Q?NKfjJBPfZeai1HRQEFF/viNv6ocj3soDh8PU9CBU2nnZv7i8S6k9TJcTCObE?=
 =?us-ascii?Q?BJtYaRlfznSKYg3n3HEkWdDJBoalY7ojjRkZxS5KKsd8JkOHGYau/usII3pz?=
 =?us-ascii?Q?g2XVGa6DVWvASc6BbaVDSrpXmrUis9t6V1i2HWgRV5dSCz5HJgaQDjmXoaZ3?=
 =?us-ascii?Q?3XidgLoL/wMjpoE3q933irBQfcbXNzh0gheKzVzJ65oPcjQGqk/P5ShUyKat?=
 =?us-ascii?Q?wTW+BYBuYgHBg7cut+WB8Y9EuNsfTLNTv3wPuoVjyIhipS8+hs24lnVc+N47?=
 =?us-ascii?Q?qVIuJUZrPoq6bc5+Q14M1D3X90/VSQnlM7rg5aRm3e973m7aauXhdj3xF5ly?=
 =?us-ascii?Q?8kSRW7NMQp5pAcKwmgIpQZFjO/vrFjfUe1dHeCXH6FnPOu8f/izb46HAgLme?=
 =?us-ascii?Q?aVmFgRvO8YB21C8FlOhJHOLOZqgDlZFVyU4gKwyOx4MBrpsX9EFQCARHdqQ3?=
 =?us-ascii?Q?d6mh/97D/K7Ie87qiKtAS9M3CZ1CbjieacdtsiypOaCHro0w/uhRhzFVJNxP?=
 =?us-ascii?Q?OVH3MSQCFVmo1sjSNPyl3/rKI9XukJJBwMK7fjhqQRJYvxTjMLssAx60GWzd?=
 =?us-ascii?Q?aVraY5TMrD3KE9NQXMhV/D6XUr55dCm1haOOgnLI2BtNGkATrPZy8wQ6Yq4z?=
 =?us-ascii?Q?A8+4+Bn+G4ESbTaa1MwthG8tH0jE/7y4A7NDQXwo9VDGV9F2aOrnqYdrE6PA?=
 =?us-ascii?Q?9LBs2xt9WKqYbuxiEoN5QPP6l6ATEFUW4L5l6CBou3HbA2ovx8R+lOlzH9PW?=
 =?us-ascii?Q?grV0jiyoGB6+oo6/Nnk9XXlfM2es0Iy6vWsmmOuidAgHLPS4RAoqphcDbmNd?=
 =?us-ascii?Q?4zJmgWLqlzCMGzdM/6XsEpLJRg3OFC6O3Ic1Hh4dYRpx1umwuc+3PXhaqFYc?=
 =?us-ascii?Q?Evl7IXTVgUF/Nceshv2rhinU70QR5gMCj0NhK+uRY1bxT9xeFbCob0rBUy8w?=
 =?us-ascii?Q?TXBEqN9JSn14qnC/y4huJonCgbZeRJQ5GnuGIxCn0FSfZeNT+MeOMrY3eMPT?=
 =?us-ascii?Q?w5LJrTdVW+LkQnQXcSSAtoVM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EGboDDkBeoXKVOpwoXJrmMm9z56D7GDFCGtkpU8R2Bi4QYn0FFSu4UvHWh++?=
 =?us-ascii?Q?jxjtAFktZtMtxb0W4okAJSnEoAHLSO0Yjxr61Q0UDAZDyoRjVC64TnKRkx9G?=
 =?us-ascii?Q?LFFdXh7fmWOY1JL0/DuPlBR1mokDMeXiZzqB3jL0SGFWzRkObbwMeNOCNZW3?=
 =?us-ascii?Q?YI4QoBJs3O7r20engbyb3LIZ29FAzPjVrfIL+VSiWypfBohRQU/9Si93b1jM?=
 =?us-ascii?Q?QdrP8TSlByHtVISxz1Braw39DQ7UwXVhqcFt1K25S7PWFREsTIwYDD3mhkYP?=
 =?us-ascii?Q?cwR5A+aPr7iNt+uJ+0bwFfnVOnqbbmpG7KCVU7MKRT278VXnmpt/hV8GmM/+?=
 =?us-ascii?Q?Vl9gFmlEsk0hY9kwi42myf1vTbkd7NShMEvKrp8yC9wZYnFOwQWCeSC0Z7q9?=
 =?us-ascii?Q?0ObuN3lOjjhrozt/ULImkD564g3g5UVCEx1T8PTb1hJ5QRVpvb4MUT7GtX0z?=
 =?us-ascii?Q?KiesNqiJQKUxTTrQj/VtQu6E8MExFiJ2cTzkuAOoF1EW3EcdMmc7i63zQb01?=
 =?us-ascii?Q?N4WdIUP3bdNLzfBpEAb6KO7zG6JxZ4w1Jj2JIn+7sl80ihQv0pw1oKZ5gjej?=
 =?us-ascii?Q?FO5Ib/5dcxMpc+4WStz25qU77COtOgbDEorBcUjBU44NE97kuvWQbId1xiq5?=
 =?us-ascii?Q?CJicCXudHGcdHcsEVz5Gi3ri0G5DS6SB1vFjz1SDCoq8FFwnElklKGJ4zO/H?=
 =?us-ascii?Q?H/s2ZeK5OPB8N1lkYQMcsdBtxG7lz33XO53bCzbg4uOKkndNK+hZKPW35dp9?=
 =?us-ascii?Q?gG2OUexvYb8qd3uAHapZJBnmykuZ9mzqxELuf3gFikX3+f3TDufGXJ0L3wgh?=
 =?us-ascii?Q?mav5SHsq3DOmWl2aG5rj9YYpEW3onexgr2gQoBEuuLGlKIb9+0PfrxO4iLux?=
 =?us-ascii?Q?bQupcjbAc8RZUOzAfO3HumPoo82iqsOHFvLnr4AvUKCozzYNxoiLyRh6Xs9h?=
 =?us-ascii?Q?nS0FRf7ZDIHdBS5i9CwQjTEHO7xVzkRzHeDRlPEQ570RL/aHRRW8dOrvOkSC?=
 =?us-ascii?Q?XGD8THDl8jxGFQT+1jmgzdlsQsenyqGr2XfrifYGWzVaejUkcFr9TfmIqZcj?=
 =?us-ascii?Q?VHnkMwk+2bkQ6tnY9VLo0qGjWxoaZ2nHiR1FRri+RQxXpDcGEJlZuS02O4Bf?=
 =?us-ascii?Q?UiRMMRsy75xNnOblWx1NbEoawWrSBQxThE2HkDcvRTBNB7qHVRzM0HFijlnc?=
 =?us-ascii?Q?GY3635tdFPuCRcyo4HpJT0SPkLqqhh7BoCdVr31kKzah3QTfe15XbYx9isLz?=
 =?us-ascii?Q?L2j08klZ3j7QjAXUFZ91oeZsmL5UktzeLk99jEWsSkYsBTeHrf0uS7bPwXjw?=
 =?us-ascii?Q?/LPmPGJeLZjhknW235govS9mhg3/raZ0yiLxumUhIv+zy0nP5L5WJA/PQ0is?=
 =?us-ascii?Q?kYChxR9g9Qtd22LtKyyRDu9Vf02GmoLw0lupCBwi06zhaDf78FgPjqXn8TCC?=
 =?us-ascii?Q?Xzj6vrA2YGSSjnt4QT1iJUFFdRLopB4vvBQRG0j7ukYuyq742Q0OFymao6iO?=
 =?us-ascii?Q?4fGESIlrV60vTDlnlajc/PFUhkg1jeRCOJbLKQr7+F6lfsWeP9hw9R6xwhHP?=
 =?us-ascii?Q?i7O69PK54evNma3/p/SzP5ZI+UfH6AnAb2oQJ2OQRwMCmujkLJL/FImorMCC?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CnK8Fo5N+yf15zGMFZOzOUbvhRGsAQFOLtjxTLZMQENWSPMuo4JYw+rI3IprvyuVFml3O26FuJeTTIllWXbntVa4MxaNNb2haHAwLdjf5+Zc4T4IbkJGBxExKUkpJn5LGbk5XObeZ2zhbhUzWlnDE1VVUEMx88GkV0xYLxMdjgxs6LcpK9l+PxhOLgDUk2uGKeyGOudjeB7+6pRrjY3uLhmJGpzMzmNNvbftKobKgXPaEd1uZ76OYvjix4jbPdaeAvr/sRk3oR7OoGN3W6M166BvPuW5IbcwZAGVZ0rGiwA6catlR2geAdl71mAbBFjm9/Zgh+pZ4HTw3mfURLLjRnjWkLhj6t1B/UBB6S4eIpRm9J15zMT0BmLn41FypPM52mM9qLdRlWBz+uaxQIjl4fq7EzurGtjUalX36zmyNbqLfPhnMzFBBT84UEu9b6BkhiwRNGmPnmmmw9W4GMWtDjmt056S8pxwLfmMhuPb7BQjpC9N4/X+xj+wEbnd2nU9oErl01Og2RdUOzoF8c6yh34r9yrKztOHlCyXHeT7eLIyvV2TgRODutfJLUOp9Set+aDQiKvcZp+QI8NQkjTj0OHO8bzqMVKtlMoLPTukQUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13669993-4b71-4ffc-37a6-08dcf83f292f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:28:54.0334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qm4tYPYNDrHN+7fvkjmmvVO6rNLxNYhZ4KFOtTi4f/+KEI6qks+9wa1BOBcnLSV5vjPUip6cUNxZV6f0PDZiYeXzUlztTzUIyH5EEGkKV+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_12,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=967 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290132
X-Proofpoint-GUID: WNen1synps5uXpzYLOIRUGlTlsI67qbR
X-Proofpoint-ORIG-GUID: WNen1synps5uXpzYLOIRUGlTlsI67qbR

On Tue, Oct 29, 2024 at 05:02:23PM +0000, Catalin Marinas wrote:
> On Tue, Oct 29, 2024 at 04:36:32PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Oct 29, 2024 at 04:22:42PM +0000, Catalin Marinas wrote:
> > > On Tue, Oct 29, 2024 at 03:16:00PM +0000, Lorenzo Stoakes wrote:
> > > > On Tue, Oct 29, 2024 at 03:04:41PM +0000, Catalin Marinas wrote:
> > > > > On Mon, Oct 28, 2024 at 10:14:50PM +0000, Lorenzo Stoakes wrote:
> > > > > > So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
> > > > > > MAP_ANON.
> > > > > [...]
> > > > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > > > index 4ba1d00fabda..e87f5d6799a7 100644
> > > > > > --- a/mm/shmem.c
> > > > > > +++ b/mm/shmem.c
> > > > > > @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
> > > > > >  	if (ret)
> > > > > >  		return ret;
> > > > > >
> > > > > > -	/* arm64 - allow memory tagging on RAM-based files */
> > > > > > -	vm_flags_set(vma, VM_MTE_ALLOWED);
> > > > >
> > > > > This breaks arm64 KVM if the VMM uses shared mappings for the memory
> > > > > slots (which is possible). We have kvm_vma_mte_allowed() that checks for
> > > > > the VM_MTE_ALLOWED flag as the VMM may not use PROT_MTE/VM_MTE directly.
> > > >
> > > > Ugh yup missed that thanks.
> > > >
> > > > > I need to read this thread properly but why not pass the file argument
> > > > > to arch_calc_vm_flag_bits() and set VM_MTE_ALLOWED in there?
> > > >
> > > > Can't really do that as it is entangled in a bunch of other stuff,
> > > > e.g. calc_vm_prot_bits() would have to pass file and that's used in a bunch
> > > > of places including arch code and... etc. etc.
> > >
> > > Not calc_vm_prot_bits() but calc_vm_flag_bits().
> > > arch_calc_vm_flag_bits() is only implemented by two architectures -
> > > arm64 and parisc and calc_vm_flag_bits() is only called from do_mmap().
> > >
> > > Basically we want to set VM_MTE_ALLOWED early during the mmap() call
> > > and, at the time, my thinking was to do it in calc_vm_flag_bits(). The
> > > calc_vm_prot_bits() OTOH is also called on the mprotect() path and is
> > > responsible for translating PROT_MTE into a VM_MTE flag without any
> > > checks. arch_validate_flags() would check if VM_MTE comes together with
> > > VM_MTE_ALLOWED. But, as in the KVM case, that's not the only function
> > > checking VM_MTE_ALLOWED.
> > >
> > > Since calc_vm_flag_bits() did not take a file argument, the lazy
> > > approach was to add the flag explicitly for shmem (and hugetlbfs in
> > > -next). But I think it would be easier to just add the file argument to
> > > calc_vm_flag_bits() and do the check in the arch code to return
> > > VM_MTE_ALLOWED. AFAICT, this is called before mmap_region() and
> > > arch_validate_flags() (unless I missed something in the recent
> > > reworking).
> >
> > I mean I totally get why you're suggesting it
>
> Not sure ;)
>
> > - it's the right _place_ but...
> > It would require changes to a ton of code which is no good for a backport
> > and we don't _need_ to do it.
> >
> > I'd rather do the smallest delta at this point, as I am not a huge fan of
> > sticking it in here (I mean your point is wholly valid - it's at a better
> > place to do so and we can change flags here, it's just - it's not where you
> > expect to do this obviously).
> >
> > I mean for instance in arch/x86/kernel/cpu/sgx/encl.c (a file I'd _really_
> > like us not to touch here by the way) we'd have to what pass NULL?
>
> That's calc_vm_prot_bits(). I suggested calc_vm_flag_bits() (I know,
> confusing names and total lack of inspiration when we added MTE
> support). The latter is only called in one place - do_mmap().
>
> That's what I meant (untested, on top of -next as it has a MAP_HUGETLB
> check in there). I don't think it's much worse than your proposal,
> assuming that it works:

Right sorry misread. Yeah this is better, let me do a quick -v4 then!

Cheers, sorry pretty tired at this stage, was looking at this all last
night...

