Return-Path: <linux-kernel+bounces-264239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE7C93E09F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64504B2146E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65AF12EBCA;
	Sat, 27 Jul 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BAC5m4O+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ODB3/+ZI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F31B86CB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722105938; cv=fail; b=Ch+UolTJ3nDmjK/bRCVA/VwaqLEBDMbSp3Vwx+pvHTVIaq/QkINCzYHtvxENlv1PQozguGeggGr0sPDrLKO9dbpGX/qABM8MR/EFE3JKlQZn//zwJMIkYcCze33WLMSItaXqb5aZbdXZKH6jUYqINNTr70jM1tJQxBoPQBY1SrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722105938; c=relaxed/simple;
	bh=Xm0Wj4dcg0bncO0FEzvp5PJJyqZEqESD/iyKC/86eeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BzMPoVe3Y5r62o93XhLKmQ7S8nmY40qjYFJN3Q2EZPKCKyP9hAGuVjubObT6J1wrAyGKmIgR9bZ8LPelIObdXLvhXFOxMtwboKtF+DkGfDQVfUluG4pm8sP2UnArKTByPdfsxf8J3oP5ys4VGMQ1kLIuT2A+TQoRUMmIV26RKAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BAC5m4O+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ODB3/+ZI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46R51EjT008611;
	Sat, 27 Jul 2024 18:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ddtuoaVFyFW+00D
	Vf1096L6uIcMpFN85ay2yKhE7X78=; b=BAC5m4O+uYhIG9s/dU0+m44SCoc/BH4
	PYV4sJUEFAMjC/j7r9oMsZ5BqYbhF1vP6w0e8RQkQ4NViqVw4SfxbS6bh3rvXzcZ
	5DdTBe3yiULWjF69kvQ27JenDTyn6ectLpuODBiaFX3YtVKOkuJXcoNzXne4wOuf
	LhSIGlb4HDSGtSHoukd91H4vsBS7GNPaqfqWV2L1Mb7GbrwrkStUJnk6b+oQFkZB
	pyg9cGw569h+BMTmh0D3zO6bHK8c3hil2Li4RJPG43S+SwCWMUAvgw6Bm0kIxH/P
	tDNQjj4tocNeC3XawoLx5YYQw5dpTvSVZb3h/Y/8sDqDfAm6Z6SSPSw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfy8hjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 18:44:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RHH4bU030845;
	Sat, 27 Jul 2024 18:44:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40mqbbp62j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 18:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kksfDsxo0sXVsPmmLyTiv8devW0P8Y4FwV/YcjZn9jmOtX0ntMwzCHG3TQS5JdBN1ACtLQp6ELZFH48dSj+7a91oLigZ4A9akcnC4IKTY3fjRryVqXMyYdLw7a/F2KLuqx4khdwuNd2tmqUokeqWZX+DAB3V2hjaFT9tCTKnS08M1aP51VnpunjqpLl9DEbMW0c961xXEBqfNWKTOaZoZ7w9CORaANOU/76J5bgS9LC6Cr/OOsThW2yBiEMxGsPHF2vmI1CuOOlV9nXckxxJgDTJ01wu+nNXpoZ8syp82Dut38ryD/scizjdOgumjcfWEWwf5mxVK91fYCRhGucqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddtuoaVFyFW+00DVf1096L6uIcMpFN85ay2yKhE7X78=;
 b=DuZouVYmTAw5sfcgBJgrAlpcPWdXyMxVw2EL8zvv3gO0Ka0ktoaeJ75JzXl03xSlAZ2NXBLgS7YQaEO0lTtv+3Dy9fFbhW1RI/DzByW48eXL2Az/hIRFA911uqW/waMkSMZuErcqtiNxE+O0drnZl86CAhgGL5Bm/Jk1rB14V08cpazH8GtTeJoPtUpcAUJknzsF32T5lUyioGLU7ZRJuGjy8HFeF0V3K9S5pX/xUi9k3TULA5O10JxouOnYp+KRjBQtq0x//0OEpF3LvdpMOhyiaiyHpHu94n9qhWRv7Mq9j7aYzPW9DNW63OkD3QCrf8GYwjoGnJORbuaPRB+mbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddtuoaVFyFW+00DVf1096L6uIcMpFN85ay2yKhE7X78=;
 b=ODB3/+ZIIGHLCE+kWHra8bC/bn62DFurmIPMRQU6pbQWpp/HbhbdG44+WnTwzp3pV17Kxev3dhXvJqxmaHmz8wyvyhR88OMet/J7J+6CGcIc+dKMfY+8FDISht4MdlVAy8NWjcy9kuHIgbfbfsoIYI2h27QuikcaJzGrmU+xRcw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BY5PR10MB4354.namprd10.prod.outlook.com (2603:10b6:a03:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Sat, 27 Jul
 2024 18:44:12 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Sat, 27 Jul 2024
 18:44:11 +0000
Date: Sat, 27 Jul 2024 19:44:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <5882b96e-1287-4390-8174-3316d39038ef@lucifer.local>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <2f1be7ee-2d70-4dd3-bfa2-1b94a4fc5a66@lucifer.local>
 <CAHk-=wj9GLHpMo=ikVYzXtnNBpFwG3YeCZHfWndj5_xm=19szg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9GLHpMo=ikVYzXtnNBpFwG3YeCZHfWndj5_xm=19szg@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::30) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BY5PR10MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d02714a-8cb7-47f8-f9a3-08dcae6c1b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iJ5HlOXWxloYKEdOpzU/J7XtgfA4GIR+6s+VIcRiaKs9E1Dh3v6IZHz7spUv?=
 =?us-ascii?Q?5fcWkoLs26HU9C371nB7mbVjnWE+USZGpWI/fPr1QkxZkHmzqZXVkQILrFL2?=
 =?us-ascii?Q?Yhu2hYDkS2Rgn19t3cJGr9ECCxbX22iR70YbU+yGMuDE1vi/sXKA8g1KunjA?=
 =?us-ascii?Q?HM+qH2WSVJlRJm8c3q5lQ839RcCQD3ghE1QZX8DnYzUxfukzRhbhUXOdi0cX?=
 =?us-ascii?Q?qyBp3u1BrKYdwZRdxrPBPNh7xLNnxr6yhk3PAwLdWPOR6bhKzoIt8YNDWyVY?=
 =?us-ascii?Q?bMfQPrSSjSDAk0XTaZIlkGkeyGMmanKigcTKvNe9IYPbgpUkdSRiP9RqJDZv?=
 =?us-ascii?Q?JggT6vs+lS9G6bbmjYjO8nBb2TWAtrv9ZpwFn8k+mBmncR8gO6D3l5do6PNy?=
 =?us-ascii?Q?qc1DEqYnEuifT52GcNgaeGI3UMTsl2rllB6NOLES/5oJorlPuSD8UBtnbU49?=
 =?us-ascii?Q?OlCBqzNwGRwM/NPGhu00I53XZx8tMZrFAtg/Wbu/+39/heHEjJEeLthIFREd?=
 =?us-ascii?Q?faQl6JdrsUse71h20ty//aS9uJ+y72bdpdBAxD6iNp7QJq2FEYDnup2ApGo+?=
 =?us-ascii?Q?Fy08xW67nxTpd2RVW0cQtLznvHLLqkl1grRJlMfCjxGMXfIb27rnlKxkFY6i?=
 =?us-ascii?Q?P1X6k+E700RQmv1a0NRhssp22t2QSba1R7hbV1iKF1OX37BVjV9kjOnqX3ck?=
 =?us-ascii?Q?fXQ1jQCpsH1dCnFX3553k+ez/fNh+mF+P4KdDBszwJiIguZdW+Xrz3tSSaFP?=
 =?us-ascii?Q?8yK2FVKU1BZobcyk+98BJrYPwTfukpbFFnZ2QPbt37fz0VQkHpkEe1RLb+7/?=
 =?us-ascii?Q?nhQCBcV3NSA+MQaq9DjEV2EA1LB0XeLcQKRNr8RTP+XXMFIjmE86Tk7N/V6P?=
 =?us-ascii?Q?UMVlRoxx9FTBq5n7G3Ioe9t04nVRQls51+2RKj4dcKKhRlx1ljuNssHFwl6q?=
 =?us-ascii?Q?cuM1Cg8t04+a/6S6eSfezkPKyvaecvrXi3auvPhuwWQwKsqDV+vzV7i71UmI?=
 =?us-ascii?Q?aPmCMn1Mn5a3GrBnjOR6y/pyoIoe0QqhHDu+Lclet3B4dXWuIfKG63gqs4lH?=
 =?us-ascii?Q?AvBoDx/gOUWbZVC6wDo5rUnnnSIYIe3jKT8g0ygZa8aBCHPEQXlBgE0jNqIC?=
 =?us-ascii?Q?a17q46fH8yTjFAMxKe/gVj3R3LfRgW7KwrqVbp0UlRQl1++Al+u61rIJvre5?=
 =?us-ascii?Q?OP4r46IaGA7YHIKt1q34CODSSI/EYdnBh5wOS2NiA7ExdLSuaqXdjYndA9+r?=
 =?us-ascii?Q?WQvwIcVwCofjz01sXRmn4MP9shy40sh/TRc1diEoyNPOZA8bXeUhZNTJaXhB?=
 =?us-ascii?Q?NK3HpJhJKnT6H6byOTJlU1jhyHHVRtlCHatyelZJpPo8MA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CHtYr/NzJ6PmLz+xxRfxFzzGzusENuVX+DSLh2RzedYewQU906UN2wuQfM4k?=
 =?us-ascii?Q?9pYOR7au8IKbgXSvpJpTV8eYneXmGyOb2bgBb6TFRgEQxu/pyaecotg+NEjI?=
 =?us-ascii?Q?SyMrnCoXcbSDmyYLWwgui/fArO123elebxt4EHlSJFCZ98DNP9ifSljB2zsS?=
 =?us-ascii?Q?HXQFBoaMhrVH3WPJpguWjQWm+hB0/trTkKsr6NylWMYpQj1LpLydmI/YFzWx?=
 =?us-ascii?Q?3lMLVeRHEmxnm8ozEEsHd4xncSox19z6M67zKSEmYi9r0kAGAIhCRynaYcBX?=
 =?us-ascii?Q?Cf44ik6UN7rmV0b2E0J0pPWg0smHNncsGkq1CQJs/eU5LcXKsSzQyGFdtEe/?=
 =?us-ascii?Q?QPWd/nDz/GzEk8hRIm1DyJYYi+3ht846jwrh3YRROU3pPgS6nsv705OGCi0H?=
 =?us-ascii?Q?nmohg+h5vy0v7We70nzT09BEAFIFbalKrnwmrrfbiNANUx/68RF6tIgPXEil?=
 =?us-ascii?Q?4x1xmbSLEAsJKGyH6Pp/NAA9zcN3ttJ0Sun3cBtowciQDRV1ZrWw/9H+5vKJ?=
 =?us-ascii?Q?JK9inEFdXMqW0I72RcfQXZeTz4u3Lsh3FS29foWj3noMFxci3/n0FR/MVFO4?=
 =?us-ascii?Q?/WqBcKLHp3sddtmXxcO7//tz+xz9n2pYZLuQCVEQ11eX5BoNt822ue95dzIV?=
 =?us-ascii?Q?N7fiffztcovYZ7k0MG673LxSvfwmjTDxBky39ysEVuFJq+fHtRpJDiH7FjvK?=
 =?us-ascii?Q?uugcAj188MtEwrzmsShyJ6fEOeCujKL14AWFNToE69S5Reip8aHSP/308fuf?=
 =?us-ascii?Q?pPIoHqJp8CGcagBhbprQvcsqDipIb5EWrsQRUVkdiT2HSQALpO5Qj4VxUHkn?=
 =?us-ascii?Q?bqX+xDOsyXKX/wwahVuTDKUfvI7tmhFW+vLAkq5/F7Mvaf/0o5NB2Ye2Xq7B?=
 =?us-ascii?Q?kvLIuLqIBIVDZ/2BWIknMTNM2gzSFV4EEwqTaKWuAzTHAFZqdUgSP2aHoJOO?=
 =?us-ascii?Q?0ZNjxP+3uT9lbOPjnWIPACOBIif4QuTuvyIdqcJ1aEU+T9pi0sVI+XZP0N4y?=
 =?us-ascii?Q?Zz2pySSEGLFyKIK9utnSxlod6JPtM4027m0prh0+G/Zc1iYarYJFTX7Ej8Fd?=
 =?us-ascii?Q?1tKyw9BwjIWUqc3dBcb+n6PXEOnUTOPO2D9D92iGwfExdopl0UKjKQHGNE8c?=
 =?us-ascii?Q?L22CBveJ5bWWcY2EagRHOHG9PPPiN9sHWbwa50LCmkH5xOlSb5y0/SustHJ8?=
 =?us-ascii?Q?9Drnl6hNo86j3e0bMMXj1KqDUobzu9kw1xVVXqOZfzP4Wve+XevjEtDplz+j?=
 =?us-ascii?Q?TnGx+hG9jPWg30Behb81F4WXCyGar23+IPlSlkp0Np5/yv1YLw04SWgyK8CT?=
 =?us-ascii?Q?PFh04wx5o6qNmfsUPgG5sEDqYZddS07QOa2lQePOn96Lj6V5BloajdTP2LPw?=
 =?us-ascii?Q?OJ7YgTGdqGuoMioh270Pw9vknv3aywVAQiHHQJhuWAuBYzOXLmz4Y1Xiw4oF?=
 =?us-ascii?Q?1HET/lHbb8uk70JlANfaVqQfsZndy1s+t40DY+OktGwNzK5Vdzlcc3p/1y6h?=
 =?us-ascii?Q?xhHJJTn2/6t1NMxzkJBCYwV6EGuQSCV95UX++95NHQST6AUIPiF/hb8PcIje?=
 =?us-ascii?Q?24a5FqnL3k4EI3SPVa/E3h7lXEHOPtGDcCxE1+9+bnOxRNNCFyc7fhORjE/S?=
 =?us-ascii?Q?uxVruKm9kJ+bHRG/dFCPk0KDo1GMnFBrdJ/P//nVrn3O+A2nh56NlgJT8cVH?=
 =?us-ascii?Q?yIOMWQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qpNRDUFZrU8xqUEhk+pcDvGwpG4Oed9n5a3o91we3Vcan/a48ACMm9gvCjl0HuyCHnh7GL7x6PyiYx2JquhfE4QnDC6kd3546N9YpEfv/u37LRkyNdzQP65s53CKyGfIzHoRakKhmD/1WAS5e39WJuQJLJWRH6YG0FqfjuWEdIHNhdfFcdIgEC45cvDcl4g5I4VwiaixwP6UESXlfEyn7uAzEy3+DLHfAgHsIPu5KbsItR366e4sAEasK/j49YouRsqK+MQb1dNQphT30wuyTLMRC0uvXPhjtuGVyfNPBY20Gtqyo+hzHIGfybjRotL1cLHt6yp+bVvIQvIbIYPXnI5rL1TekeYddQgm93PAK9MxkzdA8aRTBGkumheXmm/7X+sTDAdADuG+T5WZESfCHTJHrkOJLyXoTGDiKEzmRw6o/eTlo5uPqW+2+fwqVzIrEpPyFvjutExDZQtmkVTHpW3ik5oiDgVvsaT2HcTGo4x45tQyuVS2cSDQn7IgRHG43BOI4va0zWEk4eXbYJNkoiRqg7J1XaExJ6lPZcnCesW+KEP1sCiFbAGh4W4b6wHxhBc2B64XKouL8ZMUEuEWkjUcQC7KtQbh2P6tvCOveAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d02714a-8cb7-47f8-f9a3-08dcae6c1b15
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 18:44:11.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJKdX0ET7K4Z0+bAxVQsXhmnfdr8X9i3F1DLjLRsdPZURRQEf2WUbXmJ/Sj6ck4UQ2QApQN5mvQItwZGhmxIPUihmgTRJTc0XvpNfZddh3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407270129
X-Proofpoint-GUID: igc-gfHKKqFSF6BKIgpCxHduRj5ytCLK
X-Proofpoint-ORIG-GUID: igc-gfHKKqFSF6BKIgpCxHduRj5ytCLK

On Sat, Jul 27, 2024 at 09:26:43AM GMT, Linus Torvalds wrote:
> On Sat, 27 Jul 2024 at 01:08, Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > 62603617./drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o.pre
>
> Heh.
>
>   Longest line is drivers/.../ia_css_ynr.host.c:71 (27785kB)
>
> yeah, that's a single line that expands to 27MB in size.
>
> And yes, that line is one single min(...) expression with arguments
> that are then in turn macros with other nested min/max arguments.
>
> See also drivers/staging/media/atomisp/pci/sh_css_frac.h.
>
> On my fairly beefy (admittedly more cores than single-thread) machine,
> just generating the preprocessor file takes just under 20s.
>
> Building the object file is actually faster at "only" 8.5s for that
> one file, because it uses the built-in preprocessor and never writes
> it out, and most of the actual preprocessing result is trivial stuff
> that gets thrown away immediately.
>
>               Linus

I attach a patch which addresses some of the worst culprits here including
that staging monstrosity. Changing the sDIGIT_FITTING() and
uDIGIT_FITTING() macros affects a ton of other related drivers so has an
outsized impact.

Another big one I tackled is the NET_SKB_PAD define causing slightly hidden
nesting, we can just replace that with a dumb #if and get rid of that.

I also moved MVPP2_SKB_HEADROOM to a clamp_t().

I noticed a bunch of xfs stuff that's slow too, but tracked that down to
<linux/bio.h> which I see you're covering in another thread with Willy.

There are other bits and pieces, but this seems to cover the most egregious
cases.

This patch reduces preprocessor-generated output for allmodconfig from
102,966,525,841 bytes (!) to 102,764,954,617 on my system, thus saves
~200MB of generated output.

----8<----
From 02f844f0a623645134732aeb96f635558050d104 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Sat, 27 Jul 2024 19:10:01 +0100
Subject: [PATCH] minmax: fixup call sites generating egregious macro
 expansions

Adjust code that results in a combinatorial explosion of min()/max() macro
expansion, resulting in significant build performance degradation.

Simplify by using constructs that do not result in the preprocessor doing
this.

This code should have no functional impact.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  2 +-
 .../staging/media/atomisp/pci/sh_css_frac.h   | 26 ++++++++++++++-----
 include/linux/skbuff.h                        |  6 ++++-
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index e809f91c08fb..8b431f90efc3 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -23,7 +23,7 @@
 /* The PacketOffset field is measured in units of 32 bytes and is 3 bits wide,
  * so the maximum offset is 7 * 32 = 224
  */
-#define MVPP2_SKB_HEADROOM	min(max(XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
+#define MVPP2_SKB_HEADROOM	clamp_t(int, XDP_PACKET_HEADROOM, NET_SKB_PAD, 224)

 #define MVPP2_XDP_PASS		0
 #define MVPP2_XDP_DROPPED	BIT(0)
diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h b/drivers/staging/media/atomisp/pci/sh_css_frac.h
index b90b5b330dfa..ec6cc818f3c6 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
@@ -32,12 +32,24 @@
 #define uISP_VAL_MAX		      ((unsigned int)((1 << uISP_REG_BIT) - 1))

 /* a:fraction bits for 16bit precision, b:fraction bits for ISP precision */
-#define sDIGIT_FITTING(v, a, b) \
-	min_t(int, max_t(int, (((v) >> sSHIFT) >> max(sFRACTION_BITS_FITTING(a) - (b), 0)), \
-	  sISP_VAL_MIN), sISP_VAL_MAX)
-#define uDIGIT_FITTING(v, a, b) \
-	min((unsigned int)max((unsigned)(((v) >> uSHIFT) \
-	>> max((int)(uFRACTION_BITS_FITTING(a) - (b)), 0)), \
-	  uISP_VAL_MIN), uISP_VAL_MAX)
+static inline int sDIGIT_FITTING(short v, int a, int b)
+{
+	int fit_shift = sFRACTION_BITS_FITTING(a) - b;
+
+	v >>= sSHIFT;
+	v >>= fit_shift > 0 ? fit_shift : 0;
+
+	return clamp_t(int, v, sISP_VAL_MIN, sISP_VAL_MAX);
+}
+
+static inline unsigned uDIGIT_FITTING(unsigned v, int a, int b)
+{
+	int fit_shift = uFRACTION_BITS_FITTING(a) - b;
+
+	v >>= uSHIFT;
+	v >>= fit_shift > 0 ? fit_shift : 0;
+
+	return clamp_t(unsigned, v, uISP_VAL_MIN, uISP_VAL_MAX);
+}

 #endif /* __SH_CSS_FRAC_H */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 29c3ea5b6e93..d53b296df504 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3164,7 +3164,11 @@ static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned int len)
  * NET_IP_ALIGN(2) + ethernet_header(14) + IP_header(20/40) + ports(8)
  */
 #ifndef NET_SKB_PAD
-#define NET_SKB_PAD	max(32, L1_CACHE_BYTES)
+#if L1_CACHE_BYTES < 32
+#define NET_SKB_PAD	32
+#else
+#define NET_SKB_PAD	L1_CACHE_BYTES
+#endif
 #endif

 int ___pskb_trim(struct sk_buff *skb, unsigned int len);
--
2.45.2

