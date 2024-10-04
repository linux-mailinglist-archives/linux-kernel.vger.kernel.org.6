Return-Path: <linux-kernel+bounces-350491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F28C9905ED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22961F2265A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28303216A3C;
	Fri,  4 Oct 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hfEYRHBp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="spZhEtnd"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9201B7E9
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051833; cv=fail; b=DT5jh/1NQTT0YKcA6/ZjIJNWOBnWTFrKn8mZ5JgiVSc1asoLhKVqHIiHLQqGkLGD5kJpVot7gXGFu4KIZ6QIhtLCqgnzFYIpK/ip24DOgNP681suZzIoEw0PiobUYq+AZ1r2vIY+borGdMQz5PL4jrfoLoAAz9SIa2bCOoAU2pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051833; c=relaxed/simple;
	bh=3gzGqzLCnVbjeA6pxfVo24J/YGpARIpD4rLSgoqC6to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Usaeqzoe4vLM6u/RHDS6duzb614H2cVHO3RVRj5xXP8mj22wPo/uyhvlQrQBWKWpqV9FmT6YhF7efFFu6yIFECMgr3v5Jc1F8WVSZ+IRS3A5dHRhXzxE7TjYuD/aDeicUsp9NBggxfQYTrMkB9P5iJSIFZnnBLQBr2dbHF5u9JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hfEYRHBp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=spZhEtnd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494DxwCw021805;
	Fri, 4 Oct 2024 14:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=L6ypl7BK5nJs7jH
	MDtiOwoy7xI8M5rJ45LF8TtrabqI=; b=hfEYRHBpGhU7S+cvqnJCB3CJH6oPD35
	Z9IOumKnJWUiudLdYus+EJiPKdoCCLginPIqK4Tm0Eiq3bwhkgTkHbxknS0a3R3U
	O9F9WBeOcc4Oog7gpQ0ST3CXZEbETEaDMPfjfGUHrCIQj5RmrIUeK55+9QbFVced
	j/qNLCYl93YrCtlyS4X86k9HhEg2nbdypxD5XQGBTYwU48pPp/QwlikFEdeKXw4z
	OWICctwRPnaizzLLZ8s6BohIVdIIUuLCDoljRYTBeLomFIuUW4S/KRT31rQZgbM4
	lyYVf+/dBrB3tyH1ni+AlyXEgNjgXbKAP00eYzW3WI6IOFv6t/SpKXw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4220491qrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 14:23:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494DJWfw038441;
	Fri, 4 Oct 2024 14:23:44 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422055brm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 14:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdAzIzZ5F4ccZawhjLbCgKN5Rk0gLARNHGcbDZA97AIq1l+DObA82L1YlbTfKM5XdC2/EiVSdcECGY7V60onTnLBxpJGUo3EWPK6UYDehjA/bdnqUjNvjh0eEHUwtJczWYulJmacY/PVAgo7EsJ+PVj/dfDBCZzK3Hj19/6jkAB5NqjHaF/8mb33c2kXyrwoph4PkgUx60bEfVZIW0eR8GOI80GT0o16JcdVkIC8o52zSnvSOsIO4dRZzrllUrD+4CDVip6T3E5kaRtWtrjRUerf1JCd1U1pTP/bIgu0XgOKAx5wk5SQAgpvaEfQs52wU5ESShnUC9jP63inMkSK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6ypl7BK5nJs7jHMDtiOwoy7xI8M5rJ45LF8TtrabqI=;
 b=vqA1rM+yDdnce0yP3WVXZqQu5rzfvK/27AoTOkwap7eyjcaXFaBu649xpMulIc/Vv89LxWMTxQoVwsZn5+Ky3etu4G3/OwQuA3LvLXyA8/4iGKp0IXiiZ41tYTroVC72ptHWYLADN+aJQtoCtp9SDxw3oUwWJggSLgH8i41erxt0BPa8pAPs33LWhK/Fs7Qd8hiWpXaCrxyfrhJB3QoxM5bd1dlW8v+ss53BiR2X20aer0ZR+Y+wfXENLG4xhaCy2l8B4hjzjTpvJN6Vj7+o7DYf2weQmpfD1A5au8PCg2J4Tn1k5v6stNUi/oVxdVf/P2vihlFxC8I3N+gALsXGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6ypl7BK5nJs7jHMDtiOwoy7xI8M5rJ45LF8TtrabqI=;
 b=spZhEtndw5m86pAj6BOH2vY1toSO2McFIMM/GoEGuORmEGVXUQwgNPyHv+O71wA0Z9laXkYMOCxxx4qm0fmMKxTeJrJWjqUArv4tHMaTPD4y+7AAxtnyzLye4KHJHqtkOV1Ti6lJVrZr5DAbw3qmBKOOV8COeqRJaUPWTJej+Xs=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by PH0PR10MB5564.namprd10.prod.outlook.com (2603:10b6:510:f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 14:23:41 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%7]) with mapi id 15.20.8026.019; Fri, 4 Oct 2024
 14:23:41 +0000
Date: Fri, 4 Oct 2024 15:23:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <d07c85a3-d1b6-48e7-9e98-bb533bb73417@lucifer.local>
References: <20241004093546.3232-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004093546.3232-1-spasswolf@web.de>
X-ClientProxiedBy: LO6P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::8) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|PH0PR10MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a03e358-851a-4cc5-d473-08dce480250c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qs3dq0FmISSgTQg8QAjcg6tpuAJI/eFgGB97VVlDBC43RmWUdc6NUlPLVcDL?=
 =?us-ascii?Q?zOe4p1sIDDCMnYUgxs1YS9RWHNx5vBP0Thr/ELJwGi4APUdp9FzOJzfOBHyc?=
 =?us-ascii?Q?tZlB6LWa3OGQKKM++B6wyRb5OUH0Ki59gLf5sayGoi+mHACJqhEhBZtM/Kgy?=
 =?us-ascii?Q?WaVkGpsFX8hPxXvSqKbT1094z7iNCCX0pz2dh++29F9KqoMVaf5FmnianzbV?=
 =?us-ascii?Q?deAd4c5TqQkCvRFIbUC1j7wvav17ublZ/HDfK5h2GfBAd3mX0NrvJSY6LYbP?=
 =?us-ascii?Q?rvhev4kg4QoMsO/o2J9qgPfLXkdtl4Lfut3apGB7SH/zUp0qHXUnKQRq9rSU?=
 =?us-ascii?Q?r5detLNsK6gcgSOr0ERPl2GxkAfkvxVCYxkl3HuvtKUniauPhAtn2KMumZXa?=
 =?us-ascii?Q?u90k+8dG1IOpznHddNNGbqlW0mnvMWiJOxUwXjrRi+sguqyUx7ben7d/r78d?=
 =?us-ascii?Q?b6LW/+3xKcF2prn9YdMJtm6xHLgp/tg/6izDzsJLJ9Zvq10CHpqa94h8hgAU?=
 =?us-ascii?Q?LcB6Q11uEvniyQt2UHzRBUwa7yr+YD0BDE5cYRSrG48eJingxkxL5PJemmis?=
 =?us-ascii?Q?ivk2HRv88RuwMDTnpz036Cr1pE/QtBOCvR4C9iq07gl2bEy2mIs5OReDV3J+?=
 =?us-ascii?Q?ZtvgR7+50cuwIkw6D6rbkvid74jCpreUBv2AZldqlEBhk4znvV5kAQLH8T6B?=
 =?us-ascii?Q?pyzOXpCdp92EqobV8NtOOesQM5VRaHU/t9R1Q1oMmBfZ4v9erXZok7Gz2bSN?=
 =?us-ascii?Q?V27nrQFT/rQ17H8+pS2nkYdnndkHD3kU6l4qjIanKJf9QlDIiOPT28HEKFIe?=
 =?us-ascii?Q?Ry3l7LV+VbQt5rHwDub9wc9bsURbxqGLhzw0gGQSaLdLLQi5OufOz+xK50/6?=
 =?us-ascii?Q?kr8XDqp9TN8ZuoaseNRvl28RwL20S503vIRr/a+QvPHo7C5VIjhU9snXXA8E?=
 =?us-ascii?Q?/xkmBWjRjMwTCKVTXaEVZ633qjf1mlXolhQBX7kERy6AuKAV3IfPwPPBWwX/?=
 =?us-ascii?Q?nb2tOSI6MDBcrqP0VxurXsUbVkTTlt6ZcnIs9KUUfX56FF9gqTaO9h2fHJcj?=
 =?us-ascii?Q?FXGDy+PZPYITHdY0btivpmx4GIAmy30VVX4YjLAyjGLwFFiqiR403iguOila?=
 =?us-ascii?Q?Q9BRgIDf0JNCMKxoV5DL0BbyvHiUKuad/njQ0kR6oWBJCLASWmIW1QSkPtAa?=
 =?us-ascii?Q?6rOTpk2SmUecf0t276WYxJjVL4NZh01O+LVJsrWx2srxGus8rPKgrJy2YnPU?=
 =?us-ascii?Q?RqQT0JwE/aDcYGvNv030KD6AeTwi9Rs482hD8IidIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c1kFDRUz5M+4TJDsdm+uSXPOd2/T4sK9aCakdIE8GlYpJD3qyvARUXY8dkVs?=
 =?us-ascii?Q?qD8SuQPDLb7wF5aUcJoAc+U6PuxuClvJeyW1sKg3Gl5NF33qjnbgklvLkNLS?=
 =?us-ascii?Q?AuQJz4bcgiOKZa/GaxPQ8FyiUVyZSCRGsi4YyshiY5n3CvNlV9RqJhPmJLNk?=
 =?us-ascii?Q?TXg8UB2EUuVpmtcC0Ptl5M/kD7qgbpc2s9JiiNK2uWABCa2pvZpOqfJLFuYC?=
 =?us-ascii?Q?qH97vtWLImKro7bcoB6LWzk/bLGmMOhp+FJZ65GRtShl0651VLUn99RFRZvh?=
 =?us-ascii?Q?20aYv3j9CXpceldRIP7mm19ku1DFGooNTyPm85W60uAR/zI2fPdyf+3uHFbh?=
 =?us-ascii?Q?1sQhByk+f3sRxxKlD1e+HlmlNjxfo9GYRL+q7ZAD83pplEF0sJd6kzMVvFJB?=
 =?us-ascii?Q?OP+TnDulfrIKjr+i+VmTW8wIetpaJmB4ulX5uTfEE8i854YLLeakgJWMdsBd?=
 =?us-ascii?Q?G/CZmORKEg1k82Gj4sGrGRojNhJ81zjSb79+GOn1MfLnPZBrhEMCIw369Vg7?=
 =?us-ascii?Q?m222PCSeJHiNpVDxgMCvz8QJh73RXWWJORCgxESXQvMRuE4f/9uI4PyvGSjX?=
 =?us-ascii?Q?q44a0cCv6ALDt+JbYulbbEu8i6qtCtfqp03c3EE0TZDGoqjcxVpmSL+Gl2Tm?=
 =?us-ascii?Q?0AexofqluMy/kMM9J43s8VnAOMfmVHmZeOOIV9AIWTlyq53taLyadixzoIrg?=
 =?us-ascii?Q?PAKnzIJEwwd35AOJC/CIK5vvBYwSskNJZLriIrWaYKUDyum7zktHOjwvWFto?=
 =?us-ascii?Q?kgnzAKVRc8jnIBlE7ZbrxgwQgu536dMwzHZ9D4FCO/yyMkJjht248CwV2RWC?=
 =?us-ascii?Q?0AKxpD3r1Tadv7QlfDr9gseI+Fod1+U+9JxVbXFI0uJtOXCq7ScRS5nYNKlF?=
 =?us-ascii?Q?Xj8/76kKEEWedRK+ZDplW9+eaYd27zBrW8Q31VYYogFYhffp8zYxXfL5sptU?=
 =?us-ascii?Q?8lQmc5olPwnloUWKTO3bOXBIiYJh50TsWIZD8hBnP9xb20Q0soSxYANryM3j?=
 =?us-ascii?Q?QuaFpMHeH6WeuuQFb6r7demY6CYqWI4iCx9oH5DOnCLt48PJXdRQ+4lJmEu9?=
 =?us-ascii?Q?P7j5nOMdrHDWlXOwkuYVjEt7MdVEuIauogHbTm0dAsk5RHKEoKNCGYltXHmg?=
 =?us-ascii?Q?a4bFScsOt6WSZbZPPXpp0bQEYycGzKNtnndFyHT75QiL/AQRXwZDXaUkNOm1?=
 =?us-ascii?Q?oKZVBcqTqJb/9OwekK8DpwlnP7dKDYnqaObTm5/60/UPwVLlKgGj/Z1f3QqS?=
 =?us-ascii?Q?EwAHPvbKYYIjxHzj3YEkKi3YTqUHk3oBAU8xPv4kzzl5bExiRz7hDidVMBk1?=
 =?us-ascii?Q?Mv4F+if7w4fBnJXpthg6oCj3XqN2pEbzjIli+jKaVD1VIAsJSf5ZV4qfzvss?=
 =?us-ascii?Q?JsRSYde11KVV/XGXjzhNKyt/ugNaxMTJ0B+JUFK3FwnoGYzkLdktsM0d/NHo?=
 =?us-ascii?Q?MqVt1UQ/JOjy0qTvh/57ipKe+0DL7LFRt7E/RADhiqtmuITgMAx3CtzQeTPr?=
 =?us-ascii?Q?uewWaE5CDUieDgQS0DIvxfxsqmuyr8casAxdJiEEzWUOFX59a1RUCnnb8eVa?=
 =?us-ascii?Q?w+9N7YfQRopkBrTXDbT5p0+deGz+Vrs4k5VgENr7OryMbxgYZjicMhBwdXMH?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JFgNtbS3yRBw7FjN3/kcWQhLNUX5bDiRBsYIFXTq3rrNa+CSKuwsXmpJw9jxdkwvS332RzARiQ8hcf3Ad/AHkmc/kbmHjqsDsKT2byOE2BzY1sPMW7EYVsUHTHs9KjxEPpvAWTvGKjWelj3EFA8+kKxGMh7MjEG0txhbTKkFDgMQHlDN3K50fHL76YCkLGPwFxVUuQ9ldUZlvJZnGYBxlITreTj6EdeTXrYvLqXStzC8wi7E3VHQQ6UrpIiKCHcyYOnNPt4+WWb7tW9y1+L2wNjDbkPjqFKnhpd/f+455xy5eKMy4xqIAKslgaNXe3fwB/lfEb6lJq80yuakhiCj6FyAOU0rSd34LuY9sNCXOLfYewjps1RzTgocmjgUJj6vfkzj2Jwc/09btwDZbuWtcDcMXkQl0KloZMpq0cZyZ1+98EbQnDsC7p3tZJ1UeMNkmevRI94afMws1s5YchW8gOZoINm2jOBlBZcX1tMEEmTU0my3W/iR/aZ88AIFveE/+c73GkKxWgCNuHbH+T2MuKK2HVWYhl+Bs1gDgBsY8WUxfhfYPt8fUs0LvITtzAOlETZwhun53zI237wehNlHyMQBiN/Jo6nbO6Dto69EAik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a03e358-851a-4cc5-d473-08dce480250c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:23:40.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0xgQhWWaSFXqK6hLiJk+Jrb5Z+xh/dMniy2QNPe2w+Lkf9DFGtcPMsEzUwZn/r4p8U4mJ9QhOz6HtG+xceW2aIfFsNbuNBfHb+3wNRVQeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040100
X-Proofpoint-GUID: 50YJQ-kEsz3Q0txkcFJ3Ednx_KsE2qMZ
X-Proofpoint-ORIG-GUID: 50YJQ-kEsz3Q0txkcFJ3Ednx_KsE2qMZ

On Fri, Oct 04, 2024 at 11:35:44AM +0200, Bert Karwatzki wrote:
> Here's the log procduced by this kernel:
>
> c9e7f76815d3 (HEAD -> maple_tree_debug_4) hack: set of info stuff v5
> 7e3bb072761a mm: correct error handling in mmap_region()
> 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
>
> Again it took two attempts to trigger the bug.
>
> Bert Karwatzki
>

Hi Bert, please try the below fix.

It fails a couple tests in the test suite so this might not be stable but
it fixes my repro, be good to confirm it fixes the issue for you.

Thanks!

----8<----
From 07485683fcd3d8d22996d82bdbde0e3647f2349e Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 4 Oct 2024 15:18:58 +0100
Subject: [PATCH] fix

---
 lib/maple_tree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 37abf0fe380b..fc221a9f23f2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3527,6 +3527,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }

+// Return whether the node actually contains entries at or greater than wr_mas->mas->index.
 static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -3696,6 +3697,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	struct maple_big_node b_node;
 	struct ma_state *mas;
 	unsigned char height;
+	bool r_populated;

 	/* Left and Right side of spanning store */
 	MA_STATE(l_mas, NULL, 0, 0);
@@ -3737,7 +3739,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 		r_mas.last++;

 	r_mas.index = r_mas.last;
-	mas_wr_walk_index(&r_wr_mas);
+	r_populated = mas_wr_walk_index(&r_wr_mas);
 	r_mas.last = r_mas.index = mas->last;

 	/* Set up left side. */
@@ -3759,9 +3761,12 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)

 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
+
 	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
+
 	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_mas.end)
+
+	if (r_populated && r_mas.offset <= r_mas.end)
 		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
 			   &b_node, b_node.b_end + 1);
 	else
--
2.46.2

