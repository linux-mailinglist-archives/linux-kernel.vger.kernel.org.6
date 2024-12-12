Return-Path: <linux-kernel+bounces-442989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49DC9EE515
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F5A166BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B291F37CB;
	Thu, 12 Dec 2024 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UFP3FOca";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ABDDnmqm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6B290F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003143; cv=fail; b=LH9Wfae2Bt/DCGApsUBSuqbVSsUi69LFTYrDT4szGW/Mmk6kXKECnJ9fUzaEg4EB6tdkI7eM39qHwGpDJMxwwGaDvep9KeYCbncaaoh774pMyKzAeZgUbf2s0ery5hljE8XZbR4rLv16HC4GSmAyKufjrQBATsDTKbCccOIPDSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003143; c=relaxed/simple;
	bh=iTKZZMhA8oqFncnGd3N2lOymmMjhSK64A5rFdwl1xT8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DiZIFmjIFZ7PgGpTOUNl6UsWbn+E7RPUqI5Ud2nhMrvQC48EN9FGaHZoHMplxRLti0ubhww0+eRcxmjkgE72XACanbzXK7TOEFigPS8UDh2IHyuTrFDkVv7z1D1qbCh1+8i8WatYaVDE5sCttgkEk3NEnQkrCjQSQSYuXOk6UGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UFP3FOca; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ABDDnmqm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC1u0qR013283;
	Thu, 12 Dec 2024 11:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=B6oe+Pq6rU9NwlYR
	MwQMj6eFcGdpaIE2gIl+GxD8STo=; b=UFP3FOcaEhHVbEnYoQeOsRjFV4WjXtOv
	qA734pFX9douXGZdF9zygWB/VWwDA1OPoj9kOeVcMR2Qx3d7ZzKMLe0GJPKXnfzZ
	eAophfjUzevEGF70xrN7af7y8E5ywa3135W/4RsKhz+aVLDLG0GgFWklsMqJid/f
	VF6tPlTB0BGOpngcCx1H6KTz+tdCRK11igL3MVGEiIIZLqGEWWxut08YTEWUtxfY
	rzK62QUpIA70+UsCcTlK/YpnXqMt1wPpyflMgNpV2HcE6W9+JMYMPPwwMjre1/Pu
	XYynNRY293pPUiEI2hnvBETa07XXp4VlhMiDZ/F7Nycu26BQm6HgtQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9atxcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 11:32:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCAlWjw038005;
	Thu, 12 Dec 2024 11:32:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43ccthkrg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 11:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzaLQ5c2VQ7FGVObHHX0PPmNiY4NbfakXwLhmjK3/0sQx8HNFbV7+JqvgrfDoD+ajS1GgWbbImdBb3BNFY5zIpwxTxQGxpSwK/ltW/QBAJYZa6sAmA094CiXIz3zTMFqDZZvz0eIEUtIT5py9iQfZ0GEjxCuIAOvis0koS/yoljgB1zJxRaC8aflsLq0i/r/hV5pcmqni0Tt5zHtoXxLkbAUNrEAwZdCTBv4Eqsv0j59xENV1RY8K8rq0t3RIFdMA9r6548bsC/h+bVBwUDRx9IPN0YJZi/ia3RRpRziEzjLEIW5ll6RbrfoHEbg49PvrLRkCmS9/ckldbmYJPWBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6oe+Pq6rU9NwlYRMwQMj6eFcGdpaIE2gIl+GxD8STo=;
 b=RyXHPT5XDeemPLivn8PtZCM8aQa/WaL4N49K9Yf84N+1VDMa9TvDkqCPBz4iAbG/YwzZMOBVZF6iG1516/i7JCLEUPmeVBSbDMgyniuPeMXsCxr/uyO+9OM507OhV+s6LvyNBlq72a9Cv1dsLOue5ibiOf5dneoHRQVspD7NeY32+9GeSidD4+3dc27fsHf9qH4ixwE4O3PMSrN2cnl8TWUCtLK/pMs4G8f7n5MxmkAVrRZTkAtjvNVrXRC5+ob3Fg5z8maDI74yTt97sg1I74j3A9NyHr4nUrh0aiB189HVEs0qmrFpwl0B8CYFBxVwQHGdgJaCCZUksEJiEdYt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6oe+Pq6rU9NwlYRMwQMj6eFcGdpaIE2gIl+GxD8STo=;
 b=ABDDnmqm13G3kZ/bQv5LizOKRx5pPitMMJCzgolJOnblV3s3QIFrP07Fyy1uG5GXu9W1jewxMtKu1l9ljjip+owGYtqokfloES68NVvyuTO34QZDUJWkQz9EaUZ14mUKt4UfynleTwmvOU60g3/DYJGsW4N/jcTkkbVr+Ksu7LU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 11:32:02 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 11:32:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: add comments to do_mmap(), mmap_region() and vm_mmap()
Date: Thu, 12 Dec 2024 11:31:52 +0000
Message-ID: <20241212113152.28849-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e149c1-f086-4fdb-52a1-08dd1aa098b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ib7vUANmZnvwfCk4lc+qUz2GOeTwFIW8s+/saZ9lBHzcLxxXFzc7SvD1RLwa?=
 =?us-ascii?Q?X0ZK7BJNTB/nMSn1Np3i03nLxGffNDsA0ITYnu1011oCjfblmbY75F03boEX?=
 =?us-ascii?Q?8ul05FIxx2tUEaJdqz7GbDh7Do1Cm7Chl8hUtidbqG4a+mTTITSXOkwJr95+?=
 =?us-ascii?Q?VHE96C8YXTnUEk09CD3DIQbFxKWFx/ksV51hWUk3agPD+3ZgOKqa9ICJMvP+?=
 =?us-ascii?Q?PAbAIQOKGJnBmAF0wC0cIuqVSKWsHI1R2MpsNmpDwR6SPT0jnQK4hzVVUOWY?=
 =?us-ascii?Q?vPR8lSgN+2s9ArosSWcX1V8mneDciRwMtRcRfkeoudqlq2Ns9lBVo2kLkXpD?=
 =?us-ascii?Q?5cDkkZFEJC/1CX9tpIPmqsCNPsiym6xRYuY/ByGoer2sMLkou2AI/bO8USKJ?=
 =?us-ascii?Q?fpedOD0xb2Vnqi57AEbqk49YkPMgBcx65bHWpqc1LP7vDmNf01MdXTvh9AX4?=
 =?us-ascii?Q?F8xJmyK9qwq7c9xglvIJvGww4/YKruznySfgaEnTxkR7SNxYLRRXXenTf0ax?=
 =?us-ascii?Q?UeQZ6gCANJGPc9eKpi9s2IjJXK+X70BDzGbWQfFimTXndWkLKtSKoVjoGb4I?=
 =?us-ascii?Q?MPXjeKHhs/uZ3wjncNN/iBEYMg0sLd0GErX/ewf2q1K2R8il/i/XN4lBuSBK?=
 =?us-ascii?Q?lWwi/DwTS4fDTHBLcJiy5ii+L4i+yRUI6vWxPIRHzkAlGM6BgDSiax644k+7?=
 =?us-ascii?Q?XojzzSzmcgTLG3ZjbsEmFuFjY/Fw2+WrWJy4KAsPrWrBY6zHLYsBuGvkDXCc?=
 =?us-ascii?Q?tL2ggH2Dufa325nmlwxisq7176vd5cjd0c7DKcSknIqJkvRoXB3HtEotcILh?=
 =?us-ascii?Q?RF7E2n5w0X9q7yuFDPxd2uT+t6Az8li8KYgG6E7vKlGYl6eSAqgTG5hcy91M?=
 =?us-ascii?Q?Ycng6e6WKDRv6XpW3/LnwKozQvG1LXOPnWVbul2KhbKjeHy0vVBDlDu8UJml?=
 =?us-ascii?Q?2729hHi7SOUSdpnnT/82VxgXPgXdnGLZEM9eXGAarv8otAFGxVCM+l2St2cl?=
 =?us-ascii?Q?KmptGCr49cXSgPhR9g9bd+1mtxesF4iDZ+V+YVp8/nzxhQmLO1vJt7rsELUv?=
 =?us-ascii?Q?leczDAWt2uOmWRCWjAUAtNecyF+RU+8r/d6S784iWCZ7tuo4NRJKZV7APQW2?=
 =?us-ascii?Q?DfWIp0t1ebeMYXCm7oO0K+0fKVJMtmzAk13xtFipNixDgrQHRDhjFYtDFRtE?=
 =?us-ascii?Q?aMKTdzDYnmMSYRw3jDsYdxZZVmwP04jRTvCF5P/R0HMi+TcVNLdTf46VxLbw?=
 =?us-ascii?Q?d8xbaykjXXWM9ZCzMV/4hjk5nJFkCLjxCOqY9FdaIYDoH9WpSS0h/i/H+1k5?=
 =?us-ascii?Q?NBnLkg4DBDS+ytajh/IDjZJR9hpKAwaphywjpb2wUjclvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpLw/JAnPy6ZkqQlTsL91jG3kqt2oxfHHEe2O6Onkx9Kz/ObnH69qqqwbDhK?=
 =?us-ascii?Q?SGRYJAhbXJ3yyeQS0QoMI31NcSNqcfk/F2qoAeMOWdZsUT5Iaux81la5fShy?=
 =?us-ascii?Q?lTgKzzGFMkqOjBrYLeUabwjSBw0DjXuLBzkfd609s1VfRx86+TlrTAV4838p?=
 =?us-ascii?Q?LS/sUraBfK+7+NaFMWT6Dju6K4S9jbZ4kB3TLUzsvnJ4SO+fJJeNcHR9qMNI?=
 =?us-ascii?Q?/XgUp5p0Bgmp9GkLP6PEbtWvmNdg1KCoHFojaUel29MFCayJStFGkwipV0+G?=
 =?us-ascii?Q?ZzchqCbNFuxRbbgmeQw0gYR3//NWdoUOb1G059nCOQnI8afH+L6Y+eMBeeRS?=
 =?us-ascii?Q?X6xR9MyMoK+hMN5JO6CX7j6Ds6qfDJZautV1z03D91108zfhdILCaHs+ovTN?=
 =?us-ascii?Q?TQAqw0SnVa7MBKYR5FM5jUnRvibZAFDO9k1ISv8GhXClUSBuTzdNeBnvCXCN?=
 =?us-ascii?Q?2WJ1pA9antXzANbMQC/Wq66g6Q2DgqF5GFlB7XBUMXrosTehSRe7Mvu8H4SE?=
 =?us-ascii?Q?qZk9ps2/wtRyYjaLXzNg5g1mLckULi8BesQrgWPmwXzsN4d0mTA1nekR4g2+?=
 =?us-ascii?Q?BL7qpFRx5nlC2cW4TZhvJ6H5IqqXCnB07ni2r+z9ibDAzGkL2t0ZLqvG5CIV?=
 =?us-ascii?Q?t6AtaPgpPCYMdtNdrUR/tNOjKxV3LxAaP2wK4LSd/fyPNjp8MS3XNgRBzdpU?=
 =?us-ascii?Q?dt8zSDrlEWjMES/lgk9Ght5EC09RFTDG0BcReYe+7CDxaTAePlRaiyTbwIGx?=
 =?us-ascii?Q?m4I6G47qLZQAOX/Cwq2oGHplYCvpkfAlpbEgUOKdRjdZTiu2sRW9fQpXiMiQ?=
 =?us-ascii?Q?tOLb2KSRonYqKV32GZfHzYvGkMTF28UsFjmWHJiO7dCOSzpYEHHYbwK12U8u?=
 =?us-ascii?Q?4CIfVLoaCt28i9N36bWqHbTvnQsHLwnFrzcO3WuBZz7S1Mq346olfi+c78vX?=
 =?us-ascii?Q?hwL7b7RylK+Hg2ibARm+cAKp+AADcu4eO/UlqSX7tli8MhcmzDneLKIXMxfi?=
 =?us-ascii?Q?Ybd4L/RS/ufPgurmrtfEfObaysYB992nphPoCfK6hVTPqU1+SeDCDQfz0RVJ?=
 =?us-ascii?Q?PyiRX6cXZs+b7XO1O7a5/YmStTklDnXbt7BAsk+w6GYF+A+ndLKmqyJ/EfEB?=
 =?us-ascii?Q?Rt4EIljH93QlP1Np2Rgg6KZ/Psgqc+kW9hPyGqCiFR5CzoLBpDIO0Jy0rXr5?=
 =?us-ascii?Q?rWkrmz3LkU9TjshcOb9owvCnB3ENbsfuFn9riYaYd9+crr0wjeQfaOseZ3cG?=
 =?us-ascii?Q?5o5bSFR6Y0bA2yGzU8W1UOtfplzFI5acjZFZnGUbwjHYVdmTLF5bYur/r3Hu?=
 =?us-ascii?Q?JRbIiO2hMq7iCTv9bb18zhq+HVAeZqabBOc10bjK/b6YhDCH9eyX3lglsnbb?=
 =?us-ascii?Q?Y2S2lIM+B6A+KG7Xb7rSloFcufGVS7La/bDAMRJSCt3EwKUd1YFwDbkHufFH?=
 =?us-ascii?Q?tknNEY+CNDqUVuS1sCplJesluZc6w/OMgWtor1qM0UAUCDw3GuzJ3TEiE1Eg?=
 =?us-ascii?Q?X8rllJ7xyTLfZUG7I/cR63/29BnjFe4VnzPJSS8jQHw/GJTPTuRw+g+z89xq?=
 =?us-ascii?Q?ayyYgEZGzIUsYq2uflDnzaVvJ6w+H78BjgW0pFYb4c8wqJj3gpnEpPG22dDh?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S2R/v8vN75fH3eBqV/bPwaGfjZs1v0BF89s02SMYSyk+6npQDH5YRgY50534MBxNitDOQTEaXM3VkPU/JTLMErjrBOl3CMDQLZEZrJAuUpu5c3E91cv4fCuFSCyVixvw8r1WBebqRlYvlHkNfnxsmaPbTPyOU8j0IhVCU76OPwjZ2LUeEpKKsxJX7Spr+HQqSO5jZnniDOabHl6xilsRJiwTdWgWnDPwmXjcGMr7KKRM0a+Dawjo46JoHwqYWL4oJiZKmIBxgL9HtF6OoeHhSKAGBH34kX0DMwQ7MH90rZrDMCDq9F3dcQBizdLNbFlNqVbQ5/2tfii1VFwOEFbIwWdrwRJurWOn8gWz2qT6tssw86OhD3LGgzO2UPRql8KtByhAYobwqlqr1qQinEM9AoJjsKfWaKBv1TWF2321LO3BHDTGvzFOXSXkYG2+7RLfq1Ef5LCTRsztF3daOR9K6/wHCHy3VKB0arK+HpZbUW+shJ0yEZU51leFTfp0Fs9YsxYerIwDiCcuVrt0CBuMqaMH0GyK6fjPibZWgNqjLxBQxHGl6icYQQAdAPRaNpJ4T2jwe2PXHuY9XtMtbHLhKnyGNWQ1ibafnMvMFGfiezk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e149c1-f086-4fdb-52a1-08dd1aa098b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 11:32:01.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gv6G25/sU97baRygxS6wqDHvVLrUMhknxpseERYzpOYdn49sZGClzgSLIY+wQhBrrNgZgeklonb323R/AmU8/PuaTYw35anCKvMfIfsyy3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_06,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120082
X-Proofpoint-GUID: cR3yOJjufo1Kcba5LerEgkELVTcwYhtV
X-Proofpoint-ORIG-GUID: cR3yOJjufo1Kcba5LerEgkELVTcwYhtV

It isn't always entirely clear to users the difference between do_mmap(),
mmap_region() and vm_mmap(), so add comments to clarify what's going on in
each.

This is compounded by the fact that we actually allow callers external to
mm to invoke both do_mmap() and mmap_region() (!), the latter of which is
really strictly speaking an internal memory mapping implementation detail.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/util.c | 17 ++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index df9154b15ef9..61260369f034 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -277,8 +277,62 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
 	return true;
 }
 
-/*
+/**
+ * do_mmap() - Perform a userland memory mapping into the current process
+ * address space of length @len with protection bits @prot, mmap flags @flags
+ * (from which VMA flags will be inferred), and any additional VMA flags to
+ * apply @vm_flags. If this is a file-backed mapping then the file is specified
+ * in @file and page offset into the file via @pgoff.
+ *
+ * This function does not perform security checks on the file and assumes, if
+ * @uf is non-NULL, the caller has provided a list head to track unmap events
+ * for userfaultfd @uf.
+ *
+ * It also simply indicates whether memory population is required by setting
+ * @populate, which must be non-NULL, expecting the caller to actually perform
+ * this task itself if appropriate.
+ *
+ * This function will invoke architecture-specific (and if provided and
+ * relevant, file system-specific) logic to determine the most appropriate
+ * unmapped area in which to place the mapping if not MAP_FIXED.
+ *
+ * Callers which require userland mmap() behaviour should invoke vm_mmap(),
+ * which is also exported for module use.
+ *
+ * Those which require this behaviour less security checks, userfaultfd and
+ * populate behaviour, and who handle the mmap write lock themselves, should
+ * call this function.
+ *
+ * Note that the returned address may reside within a merged VMA if an
+ * appropriate merge were to take place, so it doesn't necessarily specify the
+ * start of a VMA, rather only the start of a valid mapped range of length
+ * @len bytes, rounded down to the nearest page size.
+ *
  * The caller must write-lock current->mm->mmap_lock.
+ *
+ * @file: An optional struct file pointer describing the file which is to be
+ * mapped, if a file-backed mapping.
+ * @addr: If non-zero, hints at (or if @flags has MAP_FIXED set, specifies) the
+ * address at which to perform this mapping. See mmap (2) for details. Must be
+ * page-aligned.
+ * @len: The length of the mapping. Will be page-aligned and must be at least 1
+ * page in size.
+ * @prot: Protection bits describing access required to the mapping. See mmap
+ * (2) for details.
+ * @flags: Flags specifying how the mapping should be performed, see mmap (2)
+ * for details.
+ * @vm_flags: VMA flags which should be set by default, or 0 otherwise.
+ * @pgoff: Page offset into the @file if file-backed, should be 0 otherwise.
+ * @populate: A pointer to a value which will be set to 0 if no population of
+ * the range is required, or the number of bytes to populate if it is. Must be
+ * non-NULL. See mmap (2) for details as to under what circumstances population
+ * of the range occurs.
+ * @uf: An optional pointer to a list head to track userfaultfd unmap events
+ * should unmapping events arise. If provided, it is up to the caller to manage
+ * this.
+ *
+ * Returns: Either an error, or the address at which the requested mapping has
+ * been performed.
  */
 unsigned long do_mmap(struct file *file, unsigned long addr,
 			unsigned long len, unsigned long prot,
@@ -1016,6 +1070,29 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }
 
+/**
+ * mmap_region() - Actually perform the userland mapping of a VMA into
+ * current->mm with known, aligned and overflow-checked @addr and @len, and
+ * correctly determined VMA flags @vm_flags and page offset @pgoff.
+ *
+ * This is an internal memory management function, and should not be used
+ * directly.
+ *
+ * The caller must write-lock current->mm->mmap_lock.
+ *
+ * @file: If a file-backed mapping, a pointer to the struct file describing the
+ * file to be mapped, otherwise NULL.
+ * @addr: The page-aligned address at which to perform the mapping.
+ * @len: The page-aligned, non-zero, length of the mapping.
+ * @vm_flags: The VMA flags which should be applied to the mapping.
+ * @pgoff: If @file is specified, the page offset into the file, if not then
+ * the virtual page offset in memory of the anonymous mapping.
+ * @uf: Optionally, a pointer to a list head used for tracking userfaultfd unmap
+ * events.
+ *
+ * Returns: Either an error, or the address at which the requested mapping has
+ * been performed.
+ */
 unsigned long mmap_region(struct file *file, unsigned long addr,
 			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 			  struct list_head *uf)
diff --git a/mm/util.c b/mm/util.c
index c1c3b06ab4f9..b7dc6fabaae5 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -587,6 +587,23 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	return ret;
 }
 
+/*
+ * Perform a userland memory mapping into the current process address space. See
+ * the comment for do_mmap() for more details on this operation in general.
+ *
+ * This differs from do_mmap() in that:
+ *
+ * a. An offset parameter is provided rather than pgoff, which is both checked
+ *    for overflow and page alignment.
+ * b. mmap locking is performed on the caller's behalf.
+ * c. Userfaultfd unmap events and memory population are handled.
+ *
+ * This means that this function performs essentially the same work as if
+ * userland were invoking mmap (2).
+ *
+ * Returns either an error, or the address at which the requested mapping has
+ * been performed.
+ */
 unsigned long vm_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
 	unsigned long flag, unsigned long offset)
-- 
2.47.1


