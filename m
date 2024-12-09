Return-Path: <linux-kernel+bounces-437565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69009E9524
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE401650EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54854234990;
	Mon,  9 Dec 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lh4Y69nY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IXUZg7cR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF485234960
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748847; cv=fail; b=XWcl2xTCkAeug19qTW8goLTbBE0T1AbX4Jfti8NXWpPhjoAbmwoG25snegNcerR0Fx1QG+YNYJ582xKs2m3ZQTMxIxu5JkdB+uzCQzCRKgcwa8mmHi3x+XU07MDnIbcPIRCtdoUVF4NSJT8889oGlxJ4lViMK97btvHTpLYTvDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748847; c=relaxed/simple;
	bh=D43bObrUywQY/iDAENAuMmWHKp6AYCNnPTKhiL+Vknc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VdcRwGDCL7N5clhZL3bKp/MnFMLRLGoXP60nN4uf+8xTltS4C7Oq0PiFjFXjeONVhEYxWHFaRKYWO37vWIqP5cxYp5QfWLFQKQxhWYxe/6F60v0T2BjiWKZaGlVObGSu1IRVL7Bw71npW1Clqvp7Ik4h3nYLSHPBPDRue7HPq1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lh4Y69nY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IXUZg7cR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98fuZF027224;
	Mon, 9 Dec 2024 12:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0ywm0NVNpQDf2PMahh
	FuZfs/d1GMxiQkjp1vm3qptgQ=; b=lh4Y69nYMIjc2amF7ck3NE00/3rIqi7Qkf
	nxgK7PZ9hlkZkzff7E4cQX3Ix1mV5zuTcXb+8qS38rDh9Bhy0PxUSVsHxV4fPNu8
	BaJQHWNsw7j50tOY3O6w76lICx3+afQQGwQyQCuvPTs8b91mFa28QoHyNNEBOQdk
	MnDkmp5qJokbpyDIQjz5jrcTqC/dQ755I+NcznMXqlwT7j16XQcXKnpliuXgHT8K
	GKMhJv3ac5TqUsp/m1/k4dPosdnVY5BZ/ER+vWIanRbbGlFfeq2HbpbTTtUmBx0s
	1g9QPDfsSlnFV4kluy5hoNhofPoGT4e6tzOIQYsZsuZVrARl99Kg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce8932su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 12:53:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9B0vET038161;
	Mon, 9 Dec 2024 12:53:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctdcxm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 12:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWPUkJIIrlkWLc4vUDK0hjYgBWzTWismAD1arTfTzj55WyfDTqSx3wVZc8Qr38hDkwvo6Z2f7vQJap9tqgSMT+tTcoP7zLCPUpaZyttXugKlKaUoXOFGpRknokF60sAcDDD5+OnB64PNlTe5CYjBUg/kcJTV7I69a0kY5RGX192aVYUYMfkbpuAkeaeSpMG7K3Jo6qDC2d8QMKVV6sQexR6h84m9y44kh0EVU6AYdK6zSQz1fYGTyh6nlzjDjew+AVJLlHXLEaIKl+o84D+o1N5idZcEIoS5yZfSukd60BK3f7fao67Hdhz3HT87gAti+VBmB9+hpAse1SjW4YoJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ywm0NVNpQDf2PMahhFuZfs/d1GMxiQkjp1vm3qptgQ=;
 b=fhUe6yHLEU9o6m4iA725sYA1E7dFVM9uLDTysSm6snyjmVeCGrNa+YANqvnNm3tWOL7H3lizV7hrORKkB/mLjO/o62TFygpMJDC0UHXX000jCwOm58AdN/VT6OLtK1NfnvowgyINOpMQ/V7G57u4kaPkrulT76B54EGhc4iMKHF6UoVzJk32wnTc1RlPYRmx4186vkv7GCMJWXEQ5t1mWm5Wt15EicAzq6SrrzDkcNqLuaSSmrOxlfUNpb1NIlrpq+03DXNRdBMJ2t1Pi2nLWdPFOYIXErm/uW411c8APJJEPZVW5VjOCUeNh7lI0kPXuxvDb13urjpH4bEKPSJPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ywm0NVNpQDf2PMahhFuZfs/d1GMxiQkjp1vm3qptgQ=;
 b=IXUZg7cRCdhOHXmhy5QX1Qsq/qNTD9CrxssgbB68Rg37lxs7W7ML1epI0h20AQiYjj8tGpM4sH4i35Yh37Myk0MTQmVIXE+1ehlfdwNtkfqY0x/iz89IbiMvw5EH0cqk5DOBSOne1mbzaUq48n+z9+1s2jS78PAm5s2mVa8RP/M=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 12:53:48 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 12:53:48 +0000
Date: Mon, 9 Dec 2024 12:53:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
References: <6756d273.050a0220.2477f.003d.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6756d273.050a0220.2477f.003d.GAE@google.com>
X-ClientProxiedBy: LO4P265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 6474d376-d94f-4824-a1dc-08dd1850862a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EdH1ensMZ0mUjsMn8aVGVSUFEJ8ofYcGRD3F6g1iq2iNFZxjhVz45eyWzZAg?=
 =?us-ascii?Q?ZC0twzvk2qhxwJOt2/bYLM92X29bELPyHLGFWdL4Tcjwdxc7IN3pD+US2nPT?=
 =?us-ascii?Q?tMMM189cvHoFH6o+zddFWUjPVlES0+sqpzTurHIeerVfDkgDQ2HQL8uM3I2n?=
 =?us-ascii?Q?SYkYDjjyn9dP78wOVWSjm+JDUu4AMvhcQ/72PfBWHesB7QKDsvroamGFxpl1?=
 =?us-ascii?Q?rcK7G40oRAYyqXaExgKJlWK5Kle4W0ctZ2/az/xHyGx3g7f8ZrJHmbYG/+79?=
 =?us-ascii?Q?p3oTMVr8RQMpicfh2zk6kU0awlDGiEWQojGh+AA7cib150wAAcaQnQOFU148?=
 =?us-ascii?Q?PKJT5RWnD3eH1pEol0p9vI+G8kXGDMA12QuSjtbgWr/UCnONN1v5XyY5yIrL?=
 =?us-ascii?Q?lukwubmtsy5OusZMbpAdtR5ieUlrSQYOxz+qWxnhb33pZFDfaUN5iYmlMPBH?=
 =?us-ascii?Q?Fx0sXpsnlj7iWRSQ6PIJvrg9em+vZVdv8nNBIR6PeuKyBdRpYlxyA3GwnzfV?=
 =?us-ascii?Q?GIF8mph9VdUM13LbJowM5F3d+GwQ7KZQtum9MdOls1+bQokgIIWiTuRsCczs?=
 =?us-ascii?Q?x7BkqU/8N1Vd7ltDVkRFnOb9oMvrnKOjrxKnAqc+CuI/TGvvZglFGhw51BT/?=
 =?us-ascii?Q?1HlPl8EE6B3e604Uu+4tFE5JQ0pt7be5zkDLv2TbQbzdXI7cSuuG3JXNXEiD?=
 =?us-ascii?Q?JPBtZN7mMW07B28Rv2LsIZ63Is91A9RODwFjRSxuFXlRmdLxBfnZtWvj2sRJ?=
 =?us-ascii?Q?tH3Ab+ZJtfqpLTpa8sSQKNa4WR/1zcHL6M8XvstJ9srAZ8hb2pNV24xHglbW?=
 =?us-ascii?Q?KBnicHWTqTEVeHDZxn/NuGTGO5mIJX2nwB0c8uL6nEOX40c0Y2UpulqtzEAk?=
 =?us-ascii?Q?oARZLs5pXZ98c3N0PPO5NCLRRy0fEEMjVZrV4SdHw+gM2P/3CRVmLcKQcO39?=
 =?us-ascii?Q?jpt5lKQTKAFosRudB6CuuZhbQ94CqxWmEuUEmjrcKnXVf02yp84Spf4H89pp?=
 =?us-ascii?Q?spRNX7+U0BFjneiJjxuJRCBYO6URwzEb4mduUA0LOZ6ukrZU+dt8lpk3gG7P?=
 =?us-ascii?Q?+jJs1B9Bf6Bzc+vxmv+cFD6ZtANOx3+f9FoAq8xcbth53Acrkq9zp4EgSN9C?=
 =?us-ascii?Q?M2hYzVF1MJcpUPDbReFpxAmSnuQMI821SzlpF/P0JKqVR2Y9EovPkLPBro2a?=
 =?us-ascii?Q?eixijGX39PUEpTjQLPJMNo0SE5LleLHOLJbRKCPjBNIaf44xXYNLWkcrJvvK?=
 =?us-ascii?Q?trRq/a1VF9rz5/6JkrOhintZq4FIA47yGCssTs9wJMKpgkOcrsKg7TSxfaeq?=
 =?us-ascii?Q?Moo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jhUleGCKBKuHZOpkNNGoTbK0OFfrZaYiGjyqbHKjb1fPgu+9jkZs5IaIiA/V?=
 =?us-ascii?Q?Umk9m0hhm2Owm+4jkC5x3Gvp4/LByY4u3kobGuENhP2H6iHJ/7KxGZrQWaRC?=
 =?us-ascii?Q?oHXyxGq0FwLEQmDGWfEzdhBgaLlDgWF/uFgm3lhwS8vYdOPAIEszXRTW7O6R?=
 =?us-ascii?Q?OVrQIZunpy9sGjavukqHnz9qMlcMKwKCjxVDD6IrEi+SiFxfa07cv3Py1Q5H?=
 =?us-ascii?Q?w8suev4r4GDQiDIPfVMRAsKCsTnCrCqe/5JkFl3EWxhQ3XkjaOWAAMSVoTxb?=
 =?us-ascii?Q?/aKVlDYjiRmilL+w7mkY0MDPZXWPMbb5mkHHDSdR7SxMM8tJNjXBRJ3NuAZR?=
 =?us-ascii?Q?ryZ0puckewcUzNOvYy3uydDpXUIhL+NeF9aZ1L5T5/zoMZnBA37mshAOZn4M?=
 =?us-ascii?Q?mrt8U8f4aiYBc1489vkrGlW5aa2qqEtHbIj6XOuPwp5y5IhWDLodzS29eO2I?=
 =?us-ascii?Q?+T6BVkdm1sDrExM2pYttnnIgtu5n9MVOdwGnmuQcdlIqdELd/cWZuNNKNNBq?=
 =?us-ascii?Q?qbDbzQbXDGknna9C3p6sHbdaEk0Q0ihd0U69TiFPqPuID+vHZCsoM00i7RlK?=
 =?us-ascii?Q?rRa5ZKDg9Ee6fqDQHtoSQFr7qPmI6JM/kZ6u2Jk14z6mdLO840EEeKmj82f7?=
 =?us-ascii?Q?i6qBixPkNaNVH3ckPgEUlDYL9oRcU39Ap5LpusCee5FDgwXXCRdyVL9ELgmL?=
 =?us-ascii?Q?IsWiGCdyk/V0zUDfwpL3zSR+Wtpgb5xtMQ7mO3Ro4bMb8SCJOltiZbfSjNK7?=
 =?us-ascii?Q?DdvV7O3+IhCe1ViZCDjUD3PJqsibZJ5/zOJuc4OZDQs9RiVGyPmYjqlYjJaK?=
 =?us-ascii?Q?FzyHwEUyQSu7m+7TYjEsaYqhaixm1IrB1G2+9QI6CwrCjvIgkRkZqLiQnnFc?=
 =?us-ascii?Q?+snqBK/88+SECVc3rEcIbhSM8Od1YOXMgt1gzPVr08DBlDDaRkY7k0C/tIma?=
 =?us-ascii?Q?j0GW8GQWsD4dW8Ld65LjC+KcwGu2L9kHm+ys/J5dPIApF9dl2gMmWTmHyxU3?=
 =?us-ascii?Q?ykZqMQqwH83hIsKSt9VoIoy/IisrUdTv6SGI2xn4QA/lA4kLHUMlY/SiouGU?=
 =?us-ascii?Q?EPTSCMkvN3twEj3SuLdDUQRSkKZePWNIoQOUDiAsf/NG5NernVUTBpw+9zgj?=
 =?us-ascii?Q?RveJTIf+/r026Dr8iswwjLrJZPlmMCvK13ywbxMo5BStrUH3fgNsuLMChvet?=
 =?us-ascii?Q?xTFE9RF4IXa56E+cUlhvvAgmn5nHZDiq24fRgwD/1EL9CtoTqQxNS3UiO1P7?=
 =?us-ascii?Q?uj7K4ALJUe/jO37vQ7gTwdL8BmZ1oLrYb0+ExvzsJBuZeEe7DESid+Sfw/RA?=
 =?us-ascii?Q?5EqU12qxUqd6gOkDDCURBnsZeWLgBEWLvA5/kHzjiN0bT+qtd23NizPGCyaa?=
 =?us-ascii?Q?9Pd6zy+2K9qcg9Y/H+2NjQZXvw3Na+3eEUIiE2tvEO5PR0UPMYDKjE4sNNir?=
 =?us-ascii?Q?5CE+yoYSME0d/vYKDFs+bT//EI/Mb/CirkCj/bUQxiKRdIQqYLXVZe///83y?=
 =?us-ascii?Q?OS7xkvp50sGxKyDrokicUCxq77OAU3hTYNs7c6TIb/phXyDIRxTLcbKAWDQ2?=
 =?us-ascii?Q?in4tRmWqpExG8ayWv4HMI5Iw8pW874AU6IqDQCkM+Nz2ftqLkSAOD1dV+fQe?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TnAmqsUCeXqW5YqdFArVn86tsITIlk3AyeIMZXzUmVmBkOgVlKaVQaVsUNOZzJEDYj4Ey796SP7vjjvRn5Faxt2TrErz5bR/iwDHaLRuv2XvrmUjzWbnnQcLqlzEtsfXIudj70IlkW5xfuUZ6ivJYE3Ts4FT/LLX3EBwRYmGHcK3HMEWrC0D0+XI8noNenY7QYUCcg6j9B1PkMJ1oEF7BgMFi2kf60wCHlgooDO4MY702IkCa5b1I+yh18SqHSxFDuSaOR+U/TO7u0DdyNLj6rqbUnfLpjnbzoNvvxqSVn4b/hmGM844IF99eaZZlvQbsluBXgWO77w9YXNBO4JoiIAUTUCxzx5/VAP04WU5Q4S3G4F/UQO2okdo6XKHD5C1D2Ga+WhAbEW4+tKaaOwX1A2uJblcYV0BV34sMZbpx9V86oVxl0oWjfy+Sd4qO4N+dEVtKfsACG4mL3TNEgP/l6dhulvZ+YIyLBtBu/fR5eJxLFdDjYd60L/W7lUoX3n/vMRPcJYFrwICbL6kh2gg9VKUn7678vWoGA5gW3sROFkdAW+Na4rFc+taPhjLP7ktGZZyEvCQOa9InvR+q0+shGf+nU60lttb0neT4Tg2PW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6474d376-d94f-4824-a1dc-08dd1850862a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 12:53:48.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzqTDRfN/oj4pneEizqu8KWFL5gKe3Z/poyIk7GPWWvbY3+m7w2CYG7M9v/8OWcfb0MM6FN3O5F4+TdatuWgGC1xObVTtPW7Hvk1wXeurfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_09,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090101
X-Proofpoint-GUID: W1hDyjzqsDia-Lq6J9HTios5zTyXo7Zb
X-Proofpoint-ORIG-GUID: W1hDyjzqsDia-Lq6J9HTios5zTyXo7Zb

On Mon, Dec 09, 2024 at 03:20:19AM -0800, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f85fc0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=2d788f4f7cb660dac4b7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.

Points to this being racey.

>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/vmlinux-feffde68.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdcc9cb/bzImage-feffde68.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000080: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000400-0x0000000000000407]

This doesn't make a huge amount of sense to me, the VMA is not 0x400 (1,024)
bytes in size... and the actual faulting offset seems to be 0xdffffc0000000080
which is 0x80 off from some KASAN-specified value?

This would be vma->vm_file. But that also doesn't really make any sense.

But I wonder...

I see in the report at [0] that there's a failure injection in vm_area_dup() on
fork:

[   73.842623][ T5318]  ? kmem_cache_alloc_noprof+0x48/0x380
[   73.844725][ T5318]  ? __pfx___might_resched+0x10/0x10
[   73.846687][ T5318]  should_fail_ex+0x3b0/0x4e0
[   73.848496][ T5318]  should_failslab+0xac/0x100
[   73.850232][ T5318]  ? vm_area_dup+0x27/0x290
[   73.852017][ T5318]  kmem_cache_alloc_noprof+0x70/0x380
[   73.854011][ T5318]  vm_area_dup+0x27/0x290
[   73.855771][ T5318]  copy_mm+0xc1d/0x1f90

I also see in the fork logic we have the following code on error path:

	mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
	mas_store(&vmi.mas, XA_ZERO_ENTRY);

And XA_ZERO_ENTRY is 0x406.

Now if _somehow_ the VMA was being looked up without XA_ZERO_ENTRY being
properly accounted for, this might explain it, and why all the !vma logic would
be bypassed.

[0]:https://syzkaller.appspot.com/x/log.txt?x=17f85fc0580000

I mean the weird thing for me here is that mtree_load() has:

	if (xa_is_zero(entry))
		return NULL;

So you'd think it'd pick this up, but maybe if we're not actually holding
the right lock we get a partial write/race of some kind
and... yeah. Anything's possible then I suppose...

> CPU: 0 UID: 0 PID: 5319 Comm: syz.0.0 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:anon_vma_compatible mm/vma.c:1804 [inline]

This is in:

static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *b)
{
	return a->vm_end == b->vm_start && <-- this line

This suggests that either a->vm_end (offset 0x8 into the VMA) or b->vm_start
(offset 0 into the VMA) are being null pointer deref'd assuming the compiler is
specifically referring to this _typographical_ line rather than the expression
as a whole.

> RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
> RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
> Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 39 10 00 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
> RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf80000
> RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 0000000000000000
> RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b642
> R10: 0000000000000003 R11: ffff88801cf80000 R12: 0000000000000080
> R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4ca0
> FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000140 CR3: 0000000040256000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __anon_vma_prepare+0xd9/0x4a0 mm/rmap.c:199
>  anon_vma_prepare include/linux/rmap.h:164 [inline]
>  uprobe_write_opcode+0x1a95/0x2d80 kernel/events/uprobes.c:516

Here we find the VMA via:

	old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);

Actually one unfortunate thing here is... ugh god.

I think there might be a bug in get_user_page_vma_remote()...

I will check in more detail but I don't see anything that will prevent the
mmap lock from being dropped before we perform the
vma_lookup()... FOLL_UNLOCKABLE will be set due to the &local_lock
shenanigans in get_user_pages_remote(), and if we get a page after a
dropped lock and try to vma_lookup() we could be racing... :/

Let me look into that more...

>  install_breakpoint+0x4fc/0x660 kernel/events/uprobes.c:1135
>  register_for_each_vma+0xa08/0xc50 kernel/events/uprobes.c:1275
>  uprobe_register+0x811/0x970 kernel/events/uprobes.c:1384
>  bpf_uprobe_multi_link_attach+0xaca/0xdd0 kernel/trace/bpf_trace.c:3442
>  link_create+0x6d7/0x870 kernel/bpf/syscall.c:5399
>  __sys_bpf+0x4bc/0x810 kernel/bpf/syscall.c:5860
>  __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f137e97ff19
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f137f7e8058 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007f137eb46080 RCX: 00007f137e97ff19
> RDX: 000000000000003c RSI: 00000000200012c0 RDI: 000000000000001c
> RBP: 00007f137e9f3986 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f137eb46080 R15: 00007fff36be56b8
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:anon_vma_compatible mm/vma.c:1804 [inline]
> RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
> RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
> Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 39 10 00 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
> RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf80000
> RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 0000000000000000
> RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b642
> R10: 0000000000000003 R11: ffff88801cf80000 R12: 0000000000000080
> R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4ca0
> FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020002240 CR3: 0000000040256000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess), 6 bytes skipped:
>    0:	df 41 80             	filds  -0x80(%rcx)
>    3:	3c 06                	cmp    $0x6,%al
>    5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
>    9:	89 ff                	mov    %edi,%edi
>    b:	e8 10 39 10 00       	call   0x103920
>   10:	4d 8b 37             	mov    (%r15),%r14
>   13:	4d 89 ec             	mov    %r13,%r12
>   16:	49 c1 ec 03          	shr    $0x3,%r12
>   1a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   21:	fc ff df
> * 24:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1) <-- trapping instruction
>   29:	74 08                	je     0x33
>   2b:	4c 89 ef             	mov    %r13,%rdi
>   2e:	e8 ed 38 10 00       	call   0x103920
>   33:	49 8b 5d 00          	mov    0x0(%r13),%rbx
>   37:	4c 89 f7             	mov    %r14,%rdi
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

