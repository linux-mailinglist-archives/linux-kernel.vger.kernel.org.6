Return-Path: <linux-kernel+bounces-347446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A798D2DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8271C21BEE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5C1CF5FC;
	Wed,  2 Oct 2024 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LSYdwXMW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jUROVIDH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6061CF2BA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871221; cv=fail; b=ogFH5BagPYB97F5TJNIq+tEtW1W0T9/v5W0gzN58phZO1rAvKNnBtoYjtWEMTBByg2aMsiMFMpaLPiMWikV4yYtQkl0CKbQmNawymHCMomu3DQkfR2K8gaWpYxfmu2eiCyasDz6mD5yKQrDdxuBG/I6I3xL7wF0CxO+S5cxaHsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871221; c=relaxed/simple;
	bh=4OqsAHpxhNjfuXW3JUL91P28MmqEYsJnlmVuQK8w6Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tGLpDjnq5RZ4YwsD3vkASF7nCXfLbHFHPaKtVxQMHlY32ljJfqfY08U69DYytz4b1xYvCUSATyvn+nJfkZMKMdgtjqCyyr1Nx0XpoOqajM2MOcqTvU+RR1N6BMe6fw+g43bjNRVKoCsB2lLVFCv7GUovfG59yhYSAZ1uKXxREF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LSYdwXMW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jUROVIDH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4927faa0005341;
	Wed, 2 Oct 2024 12:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=fO7a74/ai8cJ0vx
	20YKXjDTVFvSlRaT10C/kq121L/w=; b=LSYdwXMWnAQR0mCqGrEFBOFvYvmgK8x
	IVimNaHN8Zc9BHQdVcnOAFLyR85JvSiQXu6wlhNuHhdkHVrNeWvF3tlmTxDcL3UO
	Htw3po1F32FH4V3zyigo70psuseXNDmRTgNW9IWX/VI1NKLTlUpMIdLsDYjRlyw5
	XUnEcJDZXvWnszxUskyIhhcCYjtKLeFenMYpO2SIlt9TuhQqAmtF+Hi7RRO9SYsv
	xTJhFWLmRuOtiM0YCp/EnXToS6ZAxtoE979DeiH0hOmKZFn8FY1BNoPiyDVkPR+7
	v7igfefX+BwiZ6WAFuIGwdlvmA177r2maHi3kGMosAr291o2kEso/6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d8w2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 12:13:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4929wqLx017401;
	Wed, 2 Oct 2024 12:13:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888rhxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 12:13:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggnd96wFnohvfMw3mMOYK9pbz6aFd/EDEtCbr0OVvc8pHwlxbLEkDFLSsSL6eoGHqccJYLEoU0AtAjnpswKmM1Qro+NMMb7XZ3q0JtnWjaGG6/bg6wOAfotGEWfhBgaCC1gsx2+Mhuj+ezdDtO6jvvyRRKLqx06k67Z/f/TA81SMvldty9DZn3kdUP6xa1um+NYpWHoOg7YJ0Bz4YnZ3t1PMjSiujc+6mhyBiXtI8NZjtiI17C0RYZT6qVagh+X892TkqYAg4c2CU9k3KNF1kquFI3VSbFuRqlZp2PihQaFKQSa5xMeb+2U8O2CC58noMMMTxBc2yGj97qEhimWm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO7a74/ai8cJ0vx20YKXjDTVFvSlRaT10C/kq121L/w=;
 b=h6YrX6ussv79zsFToFgQlUfK4UVBQ6uITunCUC4FXmg0xHSAX13pF/otVI24eSqhqSOLhXqx5EElSzBnB7Fp5cfEbVlaZ1xStTpe2CIgJC1BR3xzdbM16Kq/X/7ChwjVuXTFVgF7GGkmpwME9hFGwZpWWlRnOC7DT7ggjqvlvRF9t4o3UNM5fukDST7b5uSL4RYF8XiEF0+7ME4glh14P3RT4SeHCZPkRRfzOs6+HI2iBM9AZi0UJYZy/erNviV6SBgY/GUoS3+NaXVvxsLzmEJlKRi0/8YKDL39ekyrsiyYc7mk1h5bROpv4ad3J7yrTD7Vy175HdGscj8D/ebLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO7a74/ai8cJ0vx20YKXjDTVFvSlRaT10C/kq121L/w=;
 b=jUROVIDH/qgh1Waz5mnAvJgai5Y5gljZQQ3OhuvF0WSYYHnVgMn6W7pHC73E0Ndq20ZwMAeZWflaumfb1LqSFJisLGMTlkmiKQUEb7d1X6hPunZTIlFjaodVEfapFN+DMjREiI1SiwP3iSradBlMrUNtWqfbtYvyg/8krd+L7U8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 12:13:18 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 12:13:18 +0000
Date: Wed, 2 Oct 2024 13:13:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001023402.3374-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P265CA0323.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|LV3PR10MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: b665e67e-49c4-4c17-04a0-08dce2db99be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s8Y6cT+ITARSLVF0QDK7R4dg+j3XiRw1lY9BxGsrtyQV3FkmkhAWQBn/cxLS?=
 =?us-ascii?Q?st961tt7g95ECaxfYzNSECxtvyPBilCrm8Mo9mFt+N1vVe8T+wq2MOZNXIox?=
 =?us-ascii?Q?26ve0jbcvrqhZwndIj49zcIuNuFQRLEdUXTHFM1/dX/gXy/BQfLY4dECyPHm?=
 =?us-ascii?Q?veuZosALlAwsSSMLwbURJ1fuFRhHVbkXbWnFTS4rkY+qq391ndol12P1aXZP?=
 =?us-ascii?Q?0+yfmUWKlAVLtNfjPuIIQCLRgLlS4oLz9l0X2mN8TQRsfFb6rlEshaofx48l?=
 =?us-ascii?Q?oD3VPOYGvxZ/LcDtey/57GyJTyAe9aXs5m+ClljKm7MteqrJJUYSA3H5VwdV?=
 =?us-ascii?Q?U+0vGT+45U6GsZdq+rpcYjDfAU9gYvdHD1IAIMEuLVfu8DycF0YB2a5c75tP?=
 =?us-ascii?Q?eYL3l9rxFqN75DI8gWYev7sdzpiZmSRTwFcYlUJp/yP/w3fQz6U7K1cE4qGG?=
 =?us-ascii?Q?SrCxipOE5li3nQPKfpzrvc7Qf5ufcYbqE9RPPG9/cs1OTwkMgFFcT11R2BN+?=
 =?us-ascii?Q?G/MjJAO/HEyd3gHJc1bGCoFcWXN0/AvgRILftG27gSyXKk7RjNJrrOu32WoB?=
 =?us-ascii?Q?dDOniNZUrtepfidXh/VHSSeM/XnhE07EwkuPkp5UjeCpJ0MiOpht6Mc1dJDj?=
 =?us-ascii?Q?lWTRwluYA19AGgGFRzw2uaWy9SlJtar9t9lbBggPw+sT8MuY437VCvMrtsqZ?=
 =?us-ascii?Q?uS/+DiZuvKMX5ht2g78/tClSL6//0zdqohYwc8IqEoSEYLpQ6Aab9+3AMlAI?=
 =?us-ascii?Q?i7km1kMi7LJ4maPuhtaWKktDFxu3UxQEv16OuD7Lf9s81UWdCnGbkF8qfpFF?=
 =?us-ascii?Q?fSccYWlTAdEopIMzr90DG4Ai3dSY9BzZyH0tfk0quULQN/G0jmQY7CnH3qkk?=
 =?us-ascii?Q?Z6Y3fA7OpWPW3qRUFaPnsU2NDpH9dYq3bocz/FY1tPn6urnOtPp2yZHVcQP3?=
 =?us-ascii?Q?GaNvoGqjS/YnZ0yjnLbw7uOkwokYJZa9BvRsLtoLIQL6a4D78iiViPIdKtvT?=
 =?us-ascii?Q?CjYA7Vjk0s0J24MV7nOyDzfblzSNc3M117c2spwlMOAdGARoggXLdulj25Qo?=
 =?us-ascii?Q?TXtHgs7i//IyZSgrao0XnwuyxfadawZvKy2EvCKDjJySoSdpzFzMYHIerYeY?=
 =?us-ascii?Q?s36v4V5iJT9wwcwuiNeOg4q2Bt4HP1kkBfXKA55jdXgx8VufyZOsAZF8uoWi?=
 =?us-ascii?Q?dSKMH6I8vPVZrMZlM4ro9xfSsUdJNPw0XSQGe5CJHWEgwf95YliwmCwS+N70?=
 =?us-ascii?Q?IHIYmXsHgjbYPwaYJPUwjqV/z+chkEAbVNqU3rG+sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8Pz8+7FC/Syfcyf73i+uO7qA/DmdmKjU5By5cxEGAEos+3GG68cFA7+rThE?=
 =?us-ascii?Q?igFZ3qRgAXxASmV0dl9d4OdH/hpYZCAR8TvPqG2S5bDXu/gmCPtU2AKtdvCd?=
 =?us-ascii?Q?jS4FEQe5D6q8fuR38eTWeKe02y3p52Jd/TBNRLi0wboNuUWtZN/2b5WfhmsC?=
 =?us-ascii?Q?HohtXWau3FK6NDy2X6l4Do1e86V9nx9LJ72d3XGfH96FXfeVcESM6ZlBS2qx?=
 =?us-ascii?Q?oEOVJ7tRhQWoqu8MzCMdSGJ6Z0YHqmRxe15b+n+wqH2j/PCNFaLPlcJXI/12?=
 =?us-ascii?Q?kYbUSwzXW4MzQI71CCW6y/VIUvaQxJJGOqdhYYScYSln6guou4rBKD3Yo8Ks?=
 =?us-ascii?Q?LVej/O0q2c/DACq4Z+uXV0OI9pAoD6XxD19bTM0P1RoAltHDzEkyS93zbdSO?=
 =?us-ascii?Q?MWus9qA3BAoHLWVniKvOCyiM6PTnFj6dDffTgwK7cdbFRkdeaL9tco4V0igG?=
 =?us-ascii?Q?rXET2djGEfXFyTo0x69zBVPNc8CG5Ny2rabfFrAHkYOZe71aFv45c7DnJhT8?=
 =?us-ascii?Q?BlJJ6JlWBEY7ez/9oUbD9tmr+lN1plfMBZlaJMTJGgJplyyguUkWIN0m+Y42?=
 =?us-ascii?Q?xvQO4mSGvEormMMKprMbGADyYG7xmEw3xGYzvyeiQnL9jsX4BEYn40Kvykzr?=
 =?us-ascii?Q?+tYJpRxcHpVaPx18lisAEXtj7iXnC8+MXwy6tQJ5Ot37mLVp0R9GCTAcrUR2?=
 =?us-ascii?Q?PPjcM+prtjpDdkS1E08Y5Uh7fHGNU2BPkaDIya1lydw4FcdcCC0AxKpsPx8f?=
 =?us-ascii?Q?RUU1cBoOFxh9qLT7/WPi2aE/V95t/QQcINtUGEf2LWiWKIUtsOxdHi3/JYb8?=
 =?us-ascii?Q?62RV8H41ouHbqdCGNWyB8xfYsPDK1GOUFQcYmerqFrdaMQVEMTl42z5mqgP4?=
 =?us-ascii?Q?JYP9KePk/jYLks20IkCDEkRdBakW7DuJezUI31mAk7rWvGLe0aIDhknPzvdA?=
 =?us-ascii?Q?Hr8p604sYykVwtmyT8rJcOTHw5jj9KyAZyfR6lkvqtBuC655ApMHyIDjqMWk?=
 =?us-ascii?Q?2pcuYMkGR/Vrj2oeRANfjeFq6mQb7JIjNXDCvDM0BpvvKJ5Dvxuq0UTomVSj?=
 =?us-ascii?Q?QMMWN1c5zy2GfKn4RbcF0jNUjvVXz9tDsf2xIwHEUkYAVNgZUwWy9xQcmJpT?=
 =?us-ascii?Q?yXNQYbwZH6CnrHRhuOU29EEqOF8cvCVGU/Xf/lgiPKDeWIHFfR8qYS4IATAs?=
 =?us-ascii?Q?ZjilI5k6bl4vjP/y1juiQrmDUNiu5HJJEdHTbACmAO6EG0gTGsxM/yalp/6j?=
 =?us-ascii?Q?y/MdjV5I1xhzR21nsK8LgGPAvPAV8kUVcRKV9xGDjHhIh2QgxlrcZAobAnPW?=
 =?us-ascii?Q?IvyQVmM6OaXylGjNmFRO7EsImsQ0wGvP553UWcncENh2En/FPbEEJMuoGdDm?=
 =?us-ascii?Q?wVKUJv5PwpQQRmqKlr56qWY6wlGhvco5jLbhd3rwhzkEPJAcgKCwWnCWfs4R?=
 =?us-ascii?Q?QxM2Dq3Okkq1Ga7KjwCnx/EFpCYrsOo3SUf4WjLyPUYlmHt1qBRt6oWBvvl8?=
 =?us-ascii?Q?BqiJwj0NsXr7Tk5j6x27jhFhRE607M9FJF6hm66hrEUsBhmcWEU6rH9SQAca?=
 =?us-ascii?Q?WjfP/Xhwp5mzEqjeL3aI6jdFeLX8x7Jz08SpgdacrLtjZdJPWtvU5U1+skjY?=
 =?us-ascii?Q?+MRBzrihp+wbfllWidiCPQaN2cGv+MNxqp7kh9gm36f4yTX59MCj8IFqkqP0?=
 =?us-ascii?Q?BpF/Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jONj/chXZ8OircUL9eHyTvgrQdg215f0O5OFt6HM1FU7NZUZblap+YDPFrkEa55irel0Y7No1ILaZKiIu2+JaSH5DwgMPpyxZ1je3zWWx+FDjPcT5c0wtC1EKO4emdksmMRf0/eDB+VrgYoFdqhhRDMZAAG+klElE6pUVgztIddYSqjJf/R1Ul3zvC93Q7CxFhtRoayXT6BdzIT2TRchCZoyu0kkRrW0CXHEg/BTNZx8dhbnQo1rveRh8rkF57TXoLiwacCnt49lJrzE41fChKipXOP77BIZl1/eFiZqthYWqubhnK6hzMFQhfOgx0fOnBg9UXiq0jVSGAWfU4yyRsIbqFSZ7D8FNWPcXNSXubFmfuS9wYswS79VxOOw7sAvS1kFII6vHwGOuaMvHzTL9bzcVLtP8G/Kox08yoQgIUPWvEyV6ee+b+vRGoaDkG25/MjChMjJ+WhXwlb1jbjcGJWB/ndA3WHIAF5Bz3mO8u3kIbdEpnPALC9ARYblNYf7OasOCA42bKboYAGIMMzBjCi0du7JXuMoJZinu+4knnFl3x+4YqupOsOTgzk9Vmtp3q6kVFUQDsGHEhQCE0m1ANfDA2QXwpbLAyAp8G9Ys/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b665e67e-49c4-4c17-04a0-08dce2db99be
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 12:13:18.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yudU6o2xZGqivDqxA3eeYGF60B5TryZEtuGliMqYyjSj9L62BL+JXjwjbBuEEDS6nA341M/DrhDki2dBI3aPMymbg1G9UvjsVMjs+1Y6Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020090
X-Proofpoint-GUID: fWgUvd7546VDIq5QBlBGDm59PVVmgujs
X-Proofpoint-ORIG-GUID: fWgUvd7546VDIq5QBlBGDm59PVVmgujs

On Tue, Oct 01, 2024 at 04:34:00AM GMT, Bert Karwatzki wrote:
> I just noticed (via a bisect between v6.11 and v6.12-rc1) that this patch
> (commit f8d112a4e657 in linux-next tree) leads to a severe memory corruption
> error under these (rather rare) circumstances:
> 1. Start a 32bit windows game via steam (which uses proton, steam's version of wine)
> 2. When starting the game you the proton version used has to be updated
>
> The effect is the following: The updating process of proton hangs and the game does
> not start and even after an exit from steam two processes remain, one of them at
> 100% CPU:
> $ ps aux | grep rundll
> bert      222638  1.7  0.1 2054868 87492 ?       Ss   23:14   0:01 C:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimental\files\share\wine\wine.inf
> bert      222639 99.8  0.0 2054868 2380 ?        R    23:14   1:01 C:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimental\files\share\wine\wine.inf
>
> When trying to kill those processes with "killall rundll32.exe", these error happen:

[snip]

Starting a new thread because lei is totally breaking with all these dmesg
logs and I'm struggling to be able to reply correctly.

Sorry to make it hard to follow everyone but there we go.

I have tried to recreate the exact series of anon mappings and it is not
triggering for me, so unfortunately I'm going to have to ask you to try
something else.

This does sort of hint at it being maybe an unusual code path with a file
set (possibly...) - could you try the below patch on fresh next 1st oct?

You can grep the dmesg for 'LJS' and just provide that if it triggers,
mostly I want to see if this (unusual) code path triggers. There shouldn't
be any spamming.

Thanks!

----8<----
From 3218f9fae67b8314434445b4939f1cff964da88b Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 2 Oct 2024 13:04:55 +0100
Subject: [PATCH] ljs: add hacky log output

---
 mm/mmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..f927744e6384 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1464,9 +1464,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
 			vmg.flags = vma->vm_flags;
+
+			pr_err("LJS: HIT CASE [%lx, %lx) orig flags=[%lu] flags=[%lu]\n",
+			       vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags);
+
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);

+			pr_err("LJS: HIT CASE POST MERGE [%lx, %lx) merge=%s\n",
+			       vma->vm_start, vma->vm_end,
+			       merge == NULL ? "false" : "success");
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
--
2.46.2

