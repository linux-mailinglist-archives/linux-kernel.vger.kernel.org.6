Return-Path: <linux-kernel+bounces-242861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C44C928E09
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6A91C21CAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680F8146003;
	Fri,  5 Jul 2024 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ED1+kjU+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e480neji"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71842AE6A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720209668; cv=fail; b=F85UJmJ9Zt2lYSq7kLUnAy7pZTXfjaGVkl0OeN+YC7QbNTcNdZr6pzF1ii/qQiaJjJ/IdzTQJJYUVVuSB3+jnDLe/K6teuHoKy9AerZvA3bPyfoSeaw3n7zKiuoBsBk/ibRi1loHQw136QY7vvzbgDWmJPmgQ6Z0YbMJ2BxFbGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720209668; c=relaxed/simple;
	bh=kDkthdHiAZf/0Yz63TBOz69t4Y6lXwV7zJ85YWD4ekM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CDB2EOdfjXTpZpwovttuS352Zm7ErGLEm+qkFEcoHsVTERf1G+imNJdnBHfI504iMTOq3xZn5Uu3d37U9X2GZgvjH7XGrgNPOtU0nbY+M0SOvCRksCZ4X6K7F/qHnz7kvAGOwqYPGUxMPy0R9a5MaiIkZcRFjg7L9JzB29v4FP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ED1+kjU+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e480neji; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GNc4j026093;
	Fri, 5 Jul 2024 20:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=tM8+Jairsk1wU/r
	xvRYesVheEFSfhSHAUI3nyEd23DE=; b=ED1+kjU+7veioqNHxzj4P0wFk5ZN/Tv
	vGIWgDLvrDdbU8GYgqljE5+lsG35e7ltIIR1LRBpA1dYIrk1m++PVgdC9/N6EZtT
	MtLSxBmxAyeqAnR8S1Px9EeZn5+lqNJiMd01o+TFcWHhBuCr+WNY81fTIEGv1m+U
	8r8oHVVz68NR84AtBpiJdrJf0/oszGPG8jRgtSkVOyxgsOOqu5wLMw9P0oTUgyHg
	JLnW8aDmtECqxF5LlgIho3T6zJiEv9Xuzk5jATLjHVYIYFiEHwMQI2THgsATNCa+
	Q4eULg5dX7aOlWc3h6IU+Rnb6JsKTDPRQfRKYdsM0LsRyuoSJTXKzSA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsvc47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:00:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465Jck49035736;
	Fri, 5 Jul 2024 20:00:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbecpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZCsoiuYyWdmhOiA3qnKmxGd7y1atHeKQN7Sj4BYCAK6YRM4te5cNhfGvzDRfiNBg/XlyMIZxwZHE2FLSl8z9ZjonUdAJayYFil5gSeq2XDTDcOpPaCtRC8yC84TdvYRB4n4Wlrp30rZkL9ME0e2sxZEiNzlFVfsV9eNpstbDRYE1G1DcqVyj+6ZgHagK407qTz9Vcvzfpy2MlzC1/kTAXSXstPWaMj6wa1/XLIZSyiz4k15zzOPJzey7OBCfHbXYzIUtbFopbZ455kSfdzHOytla/+FUrV4d+luiYG67rg6opoTwavdnutVhkTxsCEkp8MkUDpNlxQzGa5wjSZkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM8+Jairsk1wU/rxvRYesVheEFSfhSHAUI3nyEd23DE=;
 b=PDh7CWyP4uNE7DhTl24iA38Q/OqVsznFMayV7zEb3Leqryy2fo1GzrPcTcTUrIBLtgtxVZ14tr4PXVgQ1M+rjWlrBKxWFa8fgL5zHXdyT1c7HHk82rcLsBFXnfrx6zxvzaNcl60dlGob/d8pr/2pFr86t0Udt/mZzDELzYel2+VDFpDCzpCzjL0+QkdBdUnQGdmcyQswSKrYedhVg/VeYiPplIsnoptLeSBBJyL7chJ3C7Ae6k/dArfq/WDechiDyU2j1LfZQQjmw0oZ6lrbf9IsvoFH/3runJV5S+VopNIuEdfRzz7l3XbEfYBBQx70YsAoRK11p+OLXfTDHRPxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM8+Jairsk1wU/rxvRYesVheEFSfhSHAUI3nyEd23DE=;
 b=e480nejiQoLPSuMTou32pLIeNWKrr9a2mzAr11mfPgRaFlCuC4i09Npqc/3cSbUVuXjSKkV0UXeeJq73x8jcXcXV7da/3xsoBdsOCjEd0+ODBsQfYJINbbqWRBXPqG03EhP6U+mb502ElScHyf4rUle+7fjqyK64ribc0mKSBz0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB7664.namprd10.prod.outlook.com (2603:10b6:806:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 20:00:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 20:00:47 +0000
Date: Fri, 5 Jul 2024 16:00:44 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 08/16] mm/mmap: Inline munmap operation in
 mmap_region()
Message-ID: <dkxzq7z6j4u7tmxlsblmupd4la4375z7zkr6mz2vqcfgkswshu@s6ekojjylkxe>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-9-Liam.Howlett@oracle.com>
 <44d6b910-8778-44cf-b432-4d0f112397f8@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d6b910-8778-44cf-b432-4d0f112397f8@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0195.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: e20a8c44-95ed-429f-a720-08dc9d2d292d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fDenPYXmKooscYFp/bt49NEb6EkpZ6elO/fZABsmS/3mDtPYlhD5KSPBpJmP?=
 =?us-ascii?Q?avE4t5UtFqCHjMrdIYXi7MTkBHtgBEG+KduLZDJYm9LEK5uUB3MguLUi3fz0?=
 =?us-ascii?Q?HNhacURd8MtVSsjs1Vql9+VrmEVtKm+QbAWWidcsGqmeSjSd6GHp4yaEzVIC?=
 =?us-ascii?Q?x3MwSQV/hevnQcEC7mW0s+ByDi0xZUabpw2n+Upf64UfnRbK7slBM+sofNJG?=
 =?us-ascii?Q?Lj6lMbKHLei8npqm63ODzI7PM+EIwVx6UEFGYymgwOqDNUd5PXt+TLTdn/e6?=
 =?us-ascii?Q?uyfOhFVcDjMQtIKIrdWzRM41MqiyBrA9/pDIkPJm2eaYUHKnfEUsky8j41Xv?=
 =?us-ascii?Q?bSC2GG5XUDacXD0qwfWt10wCKzqXb0ctIE/L/4/Eh/+m5544MQeQDPTjjt1T?=
 =?us-ascii?Q?kOgqhKfRxC6UyJE4i0Z2zPEWRGUn7PzVC9HT85JRCtXkqq2jUhFcxAeCr3fC?=
 =?us-ascii?Q?sHlhxy5fTPqYX3OY3SqoHDnce8SEIhO1g8hxzgkWKkvUF3+PMZpLHj9YmPgG?=
 =?us-ascii?Q?y9/cGxm1q40KCqLbIAetlRzO5UrdbDH17A143VxACZcyaNw49i5ejPaOw6BI?=
 =?us-ascii?Q?pg1BYoRkfv23tV8nSj6BaFQITf82FKt9SPEeTgH/GcPZZAQ9PFFKu+vfzhnp?=
 =?us-ascii?Q?55ka3GusMwtK7EZkEoN4S0wOQpcZLYGsP3XHHCKiXVzrBqsNwlISRxf+ryfG?=
 =?us-ascii?Q?33q6hlyWr853B/JyV7Dyg/DQSuRBIGRO0DmP2v+XvgZVU8jKWNZYPz3jSDii?=
 =?us-ascii?Q?Mpj3G/XE1NkuvENLVbVf55MijFuOcd/G/1FusJH0szUJdg9s7H/IxUdczy03?=
 =?us-ascii?Q?gr3DvAukV0i7eV9KaaYp7m2XaibZu1XaxFZ82IOkVjKOx03oO4x4GZr2NdhQ?=
 =?us-ascii?Q?GxkUTTJBqThGa5X29od4Mn41LrNEFZ2bho2FmoWBciEEwJXVYZeKkA2KmOkw?=
 =?us-ascii?Q?WcElxTByAajChypdREW7JCrZK5cPJYV0g6RdN+618DSj+c7YG3Fyo2Wbq0HF?=
 =?us-ascii?Q?BQHYCaZjcsKnNDbUB67PaGKsE+NwV9Y3PjhRQCPnlaoz44HU5tAUWZCkx/Rn?=
 =?us-ascii?Q?/00c1O2o7Npn0rcapNJV/yldj2HKOwQ74pCcSTYVdy/f1asB93/mhSMeOy7k?=
 =?us-ascii?Q?hB2CvT5eNX1m8Ub6oVHlDNz9brzlkYbPUVL1Zws4Gc14ynNjLyw0scm7PUot?=
 =?us-ascii?Q?RW5NQUc+dx/wPz5vNv0E1nbZlLoQXYivhT7DJX2ZjB2SHOw+hOJVPqHPYWIw?=
 =?us-ascii?Q?p+MczMJiYyIRW9642OCD+uTsBG0D7LPxP1QqfEjl2dfnZVWO9oiRgyNKpYWQ?=
 =?us-ascii?Q?cTlLnzHjraVnUrjh3IbCpwcWuFS6fnHPWzegETbminfAIw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jAC3OXPefM+P/k8BpWbQbjTQGbYwU/QS/4cazt/1ZAOt+ptXpTNyd6JPJ5+o?=
 =?us-ascii?Q?bKpM1f2gVzCX1hkHpCwYBs6o74+R1BPcpHwE7d4JGdtjar8hPRS0YHLVY1iP?=
 =?us-ascii?Q?qWVgkt497iLzs6+pE++JOfxhiXwrbziakXIBDVslq26VfVWkqwCT3i+zl5pb?=
 =?us-ascii?Q?qay7mWa21GfEVzQV2DbsVoG01HaH/o3LyDLtknuzLk6ZVnHiiA25QpBXDhVu?=
 =?us-ascii?Q?Xwt3rbz3MJ/iO9UP113YiqbVyXFitJshRm5BO4iDv52T6Ehjze8VhE/z6bQN?=
 =?us-ascii?Q?vXWfixUKiNMaeGx2RFQG2C73oXOZ4evGGl48rsCkODAb8bdV2jZlEZ+vCv5O?=
 =?us-ascii?Q?WChDrQBtrRlarRsQd2hj60j/3nVm4zoekmx+X2NCsKv4/Ud9C48sEEC2oiHa?=
 =?us-ascii?Q?YXtbXsmxeJP0xyR0DwKgi/yonXiFOIVOt2uamSy4ZFnPpkw3HNKNKDpjRUrV?=
 =?us-ascii?Q?gbuHhDqzcZ2pq69b/tACvFgHca3Hu0/VIS/doAUQXksc3/dFmXZu61as8jFM?=
 =?us-ascii?Q?oV779vDDmJbJAMbNqzzyIh0QKZN7IylmhKI21vOeYkXyNpOppk25bg+3g6FW?=
 =?us-ascii?Q?MB/vW3r0ZBn7WmwtXkm7X8pb8fFYnKBDK1k0DWKRWggLLHKOM/flE08ikoIe?=
 =?us-ascii?Q?HsQX8NHbhOHMpKgbi7iJiaJyHpsZQi3EQh9M3d/z3J0o+arNR9ue0mBQ3t5a?=
 =?us-ascii?Q?ymNc22MyLVr8v3TBq+xMmAdzW3apecp4OLUQO1OXzfgx6Eb6zrrVwErzZUaG?=
 =?us-ascii?Q?tMEkPk15sa6ZADSDGJHH3jcXnQkXAuPArmKeaILrOXkLBaMMudMGEf698KK9?=
 =?us-ascii?Q?wgL1geTeBqoRd6QZWHMJJBvbGxrzN5LQaLHFqbCK7zECB1Ef9uB7FWH+XeID?=
 =?us-ascii?Q?26JIvPaUhPdDNQdhI8FKz+sMOO215pTzxJJSMFmh2j6XhfwFL+1QdBv4WXUz?=
 =?us-ascii?Q?EbQ3IE15eIRDb1DZpHljUPxeMLt5AJIEfeCjRkCAJ6xfG3jh1VZWgYtWHnU/?=
 =?us-ascii?Q?BeB6ttLkBm4yiu5OGrcZPAB3MlsYhP6r9dKBlMAIK3gyO2EjQinWc6Qpa1kB?=
 =?us-ascii?Q?/Iufz/aqKHkiWrzULWlNqwOqNrnpsJKHHNdhGrnLxs/3va3p6SmnKkMMr1oh?=
 =?us-ascii?Q?1iIOP2jOIpclyMn69g1NuLFclk/tPbSVuuGXzy+rCKWapr+G3UGETrn/REQh?=
 =?us-ascii?Q?M7eAEnae8Af6wOCHhDu93YGKfZOlS/LgS67jRi3Sl9BxY25kTGgdvWwwVnKI?=
 =?us-ascii?Q?vyBlnXCkKZRZ0l1MLHcj2cJliZdRJKeviV4Ay8/hI2TWceOhwsZGBumNt+jv?=
 =?us-ascii?Q?m47r1+bJnU1Uc+e7eFU62f8f/TuYQHPZQoj/v+wkBGIK6MhxYo7jIQ2B714B?=
 =?us-ascii?Q?0IhRco8VBUokjcvxLMOrhRTCJDDMNMM2kMYXv6QSQbn9jJmkpt245dELmEfk?=
 =?us-ascii?Q?cAAsrQuSqkDVgqaVIACeAm9ihxIktsslTOXgsI/E974DgYVPyfSYPSvU7xkE?=
 =?us-ascii?Q?K4uFiHCQB7jHH4VlvjZwbf2NYr67ItZHIjMt55XZ2wVsGaehlbyUESieyAaZ?=
 =?us-ascii?Q?0qq9rdIQPrfCMSoAtximqF2JpLCYwbq8Pt6L1uZ0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YfAHdqu/na92kuHpwkT2F+03ZY0gGtF2L6kCfX9KC7sMIvrkKTwbiKA3WVhnfpOqXhRYISB+xlDHoxDIByHciUh3hDA1C1LxPYL1/GDeuxcZOKDDFK/Gy1dtm4JxDDX2SeZTceVBm/vlB6tRyLc2wCo1DylZF+2fmoy7wGLxiJtrvJoJuY6uUvHdi4TgLO2RPJNJ0Kw+dX69cKX2mvKXLPu6Bdr6rUTJzhqyJU3Qn6GbuMKGUtBYVxAelFXYkA3xMnTpdeXlQgvQF0VWol7OANRBDnFIJH78Oz+90FmQ1evY4BJj+6wGbgTY4LS9zNSVbNgolxzk4WoIayMFTT7WPPG4JdzO5MHVagNCeS6xBy1yohd8b4WK9PCjDwGwvqZU4O5xqSD/esDsoEev0Qd60gATXOlJXVQiTe8hFc1iDHJLFcfxBSBJlicq387Knj5ISLJ2qmqx8YJbGWktov1LgmBmB2UNY0Yff8m6e5H0uXh22ZOs0roocJr5ROXP0k+dYByDVGi754mXXKo6kxUBl7ao2y/bEUjH5Oe84b6cn0f4ghn7HblTxS11jF9JzsTaQOr2h9FGgaM5pVNIBKiWXhGEXky8iP0WSKSkAsxB7Pw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20a8c44-95ed-429f-a720-08dc9d2d292d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:00:47.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64BYs2qQdOOo952ZEMqetX9Wyq0JfGLDkl4OQggMlLmC44JJlPfK9O5fAFUwLnmreTumZQrYxmNmgqKLSdGKYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7664
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_15,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050146
X-Proofpoint-GUID: l3z66Fq-PHxj9cJIqaLLAdVjtdVmftpK
X-Proofpoint-ORIG-GUID: l3z66Fq-PHxj9cJIqaLLAdVjtdVmftpK

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 15:40]:
> On Thu, Jul 04, 2024 at 02:27:10PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > mmap_region is already passed sanitized addr and len, so change the
> > call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
> > checks.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 8d9be791997a..e9858ca8bbd4 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2937,12 +2937,20 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  			return -ENOMEM;
> >  	}
> >
> > -	/* Unmap any existing mapping in the area */
> 
> This feels like an important comment, I know 'find the first overlapping
> VMA' below alludes to it but whenever I've read through this function this
> comment has actually been quite useful to know what the intent is.
> 
> Could we reinstate it?

Ah, sure.  I am going to have to move it around and it sort of loses its
meaning a bit once we gather and complete it (and not actually zero the
tree)..  I'll try to keep it with the correct code block.

> 
> > -	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
> > -	if (error == -EPERM)
> > -		return error;
> > -	else if (error)
> > -		return -ENOMEM;
> > +
> > +	if (unlikely(!can_modify_mm(mm, addr, end)))
> > +		return -EPERM;
> > +
> > +	 /* arch_unmap() might do unmaps itself.  */
> > +	arch_unmap(mm, addr, end);
> > +
> > +	/* Find the first overlapping VMA */
> > +	vma = vma_find(&vmi, end);
> > +	if (vma) {
> > +		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
> > +			return -ENOMEM;
> > +		vma = NULL;
> > +	}
> >
> >  	/*
> >  	 * Private writable mapping: check memory availability
> > --
> > 2.43.0
> >
> >
> 
> Other than trivial point above, LGTM.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

