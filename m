Return-Path: <linux-kernel+bounces-547652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CB0A50C01
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDB9189555A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1F255252;
	Wed,  5 Mar 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LlvRI7p+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TZ4eRQQ6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7E255E49
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204551; cv=fail; b=SbYHym7p8h8wT7rSxDWdR57b8TKZYnQ9f6KVQ+FD+k8f5MTDKkGLhNPDdNHD3UBMm7ww6F3SIcTx06NT2f+V5AcR7drsgXkZYMCAL9dyGV1yKnm+lNYQA/ZUUOrZfCv6teHRbFzkCZYeVBRICuC5Sa8wt5NT/HiQZEFizVg2gZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204551; c=relaxed/simple;
	bh=v3SUMhfvoCI7VHngy5xJeQxwcKJUzakn4iHUT0C4fZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AJEe5lG+H3iuIQDi691XhmtiwWOSXWUtVxwQTVaoAl51bBu2TzN5StqGk2rn4DrLBpbvjDQfjO+3THxJ6X2vIth+wqrtdcbnke0PEqpznepcsHQvi4pwuumHDivWv2Lzvyg7+40ZBOS0kbRjGpZGR1lcz+Jmz83uJTnZ9gym8ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LlvRI7p+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TZ4eRQQ6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMmbP002645;
	Wed, 5 Mar 2025 19:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hr4lZxeb6ejf80Se3b
	2otVU3tnk5ZsVrwlCXwyo4J3Y=; b=LlvRI7p+cZgXS2oXJ0Th2PE0e2CiEduWJF
	hFVbfdezCc3z3x8kSEcqZ8HGwFUZcV5h6w6nbYOStnoqH4DMy0RAMheTFQnuqwHW
	p3a19sTyxN4pTXwRWuMzTnDQ1CYDNfsdrsi9lZBQev7E/PZDdKakEaYcTJYsDN2x
	0K+C2xEYAUH7ixQuzfhxACynGUwYcEOkX33kTzSzJ6lQaD6qRXwRg51fgX87ZZYr
	B9YieOybs4+bXdKUOa/IfaqQJxzzp+FZ2nY+j0XzZ0qTRg7HCw2rvGGtqi89Wbpn
	xE332GSCYfIYSfOgq6DxAAG3tYHpcDsjMOscF+3EvNEeWvwSdu1g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hgjp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:55:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525J9DfP039108;
	Wed, 5 Mar 2025 19:55:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbkb7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:55:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPdb7Qd7noAE/QgREqGPHzdRrJQTbsA9CrYzL4EYiUBPY2HboAFAU84bce/zYgzL2NiUjcty124iqJ9IND+ktUl4J98H/8EsiIDdv7QBqzws82J4MhH8lqeQRUnFHpPUtFndVj+dYgKFr9c6+6nUKhh6tOYWCFa/1mq4sy9r0JrZjf3kgdaculk04l9Pdtu43IcodUD5llT3YxXoszAqYh17Y51lKH5/K1NX2wQD0XRHsJEZqioyufpxhMGGoUI8uYU6MbNDV8KIfGXP7Mi4mfUlFSMsWom+r1AKGiFyINF52rLtzLx5Wcn3nqkQw/NfUaKUDdGA1zzGuZfDLSRYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr4lZxeb6ejf80Se3b2otVU3tnk5ZsVrwlCXwyo4J3Y=;
 b=B2vgmVUnnElKio8JatBxLbJQxgyEPvN3DaLB+hMwX8jGAnNsn2NNRyxsskzb6gzcmYBuVqa9pTgVmFzXNNKgMKl4cDpE8T1c9xb+hW+W/iYQLtYh1tpn8zYol6s19tgnmqD5o4qF7ojkBQUdTDdqcn4A8AlnoZf2gGhW0wK1p23FDsX3TvARpHDMYDWfVv1C7tOZuzH0d10fLsKF52xxk4NM3neZqtG+8Umy/1T1FVaArBxkmPRMILqghkdY7RaGhuqVCYgj+xfsStEf/2ocMD8L2/Rlpe+7gGfiBYGLPaMuAN76Vpkx3fZnzSJGHe0VP/NMIPgKeLKFe7WjduZsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr4lZxeb6ejf80Se3b2otVU3tnk5ZsVrwlCXwyo4J3Y=;
 b=TZ4eRQQ63uMDNBnHWdiXHxmIPNFbzNRNS9y82ZXciLA0JvRhZI5tuCq4jsRhwmL3Ms1/kxq4RaQfpxMa4qp8XAzoVmEQKGXga06qrLSRplFVXUiR3m66yIFm7qHyzw9m3Kq66y+DZlYBbPz8ZFKEO5lxiZpp3LBmj0BLmOMVoyc=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BY5PR10MB4164.namprd10.prod.outlook.com (2603:10b6:a03:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 19:55:35 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 19:55:35 +0000
Date: Wed, 5 Mar 2025 14:55:32 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm/mremap: introduce and use vma_remap_struct
 threaded state
Message-ID: <lffq4njcyyigtghs6tqanjz2uur2qmqcrxln5leksry2j37auc@4kdp57bpjohy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <665d51a5bf1002e84d76733ab313fe304ff73f65.1740911247.git.lorenzo.stoakes@oracle.com>
 <pvhatbfbdi2ehl7lza6yoxaorfvknqcdocc3yrdjxzgkuayser@uwqhf67ofatq>
 <42f2ee64-1365-480e-9368-95184a4cd807@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f2ee64-1365-480e-9368-95184a4cd807@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BY5PR10MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb37131-e0da-4426-aa27-08dd5c1fb189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?51ZjiQg5zIeY1Bz3KnSFRyVoDYjpVCpq5WFuYzqHsgIHcTpAzSdhcZ6VGJkl?=
 =?us-ascii?Q?v48DJ63izeMAvNMFHZOo4pMMzIoau8kzN16+NifCru8ePYxOVrXFc/cEt75R?=
 =?us-ascii?Q?GW+Bdei/wp/mJ5ghyUUzvhhU5hPBwUVcYAYu9UM4UMkV065OMcIZlZGY1TE8?=
 =?us-ascii?Q?WO4CfNBBGvVET5sr5/J+novxAF2TOZlUVmYCOoccauIvl2PrkspR1tMJ9xyj?=
 =?us-ascii?Q?MbBK9BRGkuu6orZKNTPZCZpMRT2VdHd2UeP3saQ8CnTKSTcB8S3tcRfH4e16?=
 =?us-ascii?Q?zRVFMk1j5JTdK5DUpZzLytOk42vNzvCzPsTlv9mt2uxhx8IrhqoJDYBRK3ir?=
 =?us-ascii?Q?zirfS+e9u58g+5ttk7n7+IY/pTWFj7qVf1pspGol14JvD4e9GG9OUpBb6zQg?=
 =?us-ascii?Q?egIPN5Fw7AkO18R1LDF65QsUA8r5Oa+jfCAYXhPTfglgrEf4AujSFLn270zG?=
 =?us-ascii?Q?EYX5I5K8qQO9KvO1OtqTZNPv5qnk4CQCZF9ZG7XP9jpj/9F1UWJCpPaMoC0t?=
 =?us-ascii?Q?1DHxQ/GMMuP+R9pF9IErc9ua0ibGVJtLxg9jWf8WNrAgBIinOLHs+RHSQmio?=
 =?us-ascii?Q?WT+btZTgOhKyxTDMAywiCMKZB+jW3+y9cgRV3Nfbg8Rvmx9lveCfbk+aDhSN?=
 =?us-ascii?Q?SQDyM66ot46SGPAMgYb0vM9Hc6Ib82bbNDYAemccJvTYf28teQiRmMbKirXN?=
 =?us-ascii?Q?z6ulxBMqXhQOmCDjk/PmzRwJqh57GrhqsADVSllQoSwIaEpJurPEqyMeLCll?=
 =?us-ascii?Q?SbOkU+0fDXV9zjYJgEBkeGv2Kbiu1oHrlhK0jjWdSUlTqVdst+jsGM1yqk35?=
 =?us-ascii?Q?UCIpPAStnbzwA70VVnmrff8N4CxMrXFtvp4cQawCBRouCXjDIQecrFzbJspb?=
 =?us-ascii?Q?sC5T7sQaVAZDpv7aGw80h/R+B4ecW7RvQlYoMVEa+0mSQDUWkEtG073FT85+?=
 =?us-ascii?Q?5mYUQkCVol5+HpBuO1eQbwUbGhZiioxmLJQwA5aaQaj4fgZL7X/t3e4XMN+p?=
 =?us-ascii?Q?czDuattrunBJYBJncOMCO6eXWSfkuI4Qj4gleyait9U5U5ML4wrSJM5dVUur?=
 =?us-ascii?Q?tAvj39q8AaYxnhr59YimtHx20Y8TucVFQWBQoVNze76/XJ2ZOhOB3q3YmTVv?=
 =?us-ascii?Q?r0ini5RK8aozKR7vgH3Y6p8TXdzpOmqhwMXVH66hFlVD9AhvqgH0JU4UxFHX?=
 =?us-ascii?Q?TfmFKkwI4d/TDFKei0H96mU/9jACM5Dfcpn13Yn/aRQUVafkq4p1aaX/viS5?=
 =?us-ascii?Q?ZDUVHyqUv9q5avtrL3MneRG94F1/vAs9lAXFVrm18/9iyKXUk7a7HjnatKr1?=
 =?us-ascii?Q?TedUqRq7GDmxBjXYlq4HTPu8+zjuhlFBRXfz7q3LlyduKpfWujmYYQkQjfD9?=
 =?us-ascii?Q?3abqZ7qui3nrtNhUvb69Yx/s22oO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iVKfpZMG1ZEbapK38J2vsgaIA7uLoJ/drmcMVbUTyN3opW/2CjRoyavTLbwK?=
 =?us-ascii?Q?OTBG5TSpezA9eZxwixpZmQEVvGEV33/zbtIBy1/pxdC0ExGJ9RkiljhroObe?=
 =?us-ascii?Q?Cp0Q1eVDElvw9Hf6YPnFL437DTEjgqfg9AfqarkKxLSQR/ky3x6uMDofJJtA?=
 =?us-ascii?Q?VgtKa8CGksQ0qO93b3Lbc8gkl9tnGPg3lhXjT1fSzx6A+9PaKOu6P2TVRxyN?=
 =?us-ascii?Q?2Vy8KrpVd8GjwSlFD2BBTE0DVMzJunQ68/xs52Oxl6AQJTRj8+1ME6VI3a12?=
 =?us-ascii?Q?b0eHrlivEgQI77iXWvPybDkZoYs7b+kXwZqfcvA0JR9VrJ9mQ6F9HqKzXSki?=
 =?us-ascii?Q?yCQZPVC6O70G4YPodHZWIGRafuRTnJkdbVJF7IaQEa15xEpDgcr/N1zFC7CX?=
 =?us-ascii?Q?g5G0ldDKiL5vqnOzof9DqFPo24L/HMLFApoJ2+F+0zbbfIrsd7Qwiqj70yxO?=
 =?us-ascii?Q?S/ys+1zRlLTdk1NPTYOJlOl7utaP49nicBSZYRsscYkG/7eB7LhEBkTGsi4I?=
 =?us-ascii?Q?xRwAItgnHSoniNEcOyIapBG1aJRNxwMcebDwtqdxEj1RMYxxTd6crQ4gAHlZ?=
 =?us-ascii?Q?1yl/tWXeSyeKZeYZFqEBMVmF7elYnxUMnE4lMOA8Wb3//ynDPn1fIGmIiR/M?=
 =?us-ascii?Q?Cd10yr9gb90FAkq/w4FvvbtHPBFHrE6jLY9Ve8GwEVSvrd4IGIsBBzBE8/fY?=
 =?us-ascii?Q?K+UlOOzmEaa70EpmKXBcZLLiei8GefW4JRHKS22c2gg8ZysDtpc4TVqyYiDn?=
 =?us-ascii?Q?vH0kCWo9UmFKNPWEQhbmRuqMSBDu4/PVJKYty7lgMLm55x6TqsRwmwO2xLKW?=
 =?us-ascii?Q?vso5/sNVcOtJeRu7mKjTxTw+hkYWWHHu+qcRh0PQEzfyNPJnQXxTEc1c5GbU?=
 =?us-ascii?Q?TjwQCC9mmvx/xdd2iUBU1jhPzTJ+beiPLEcCcjP+CsvJAJHInsfjZ25hBUmE?=
 =?us-ascii?Q?LTF415yXBygJtaCoEitFio+bzJ+I3L0KA4DlfeqrMtLMn49AwK28z6Wflo+N?=
 =?us-ascii?Q?PLbSwGCtC0nBDjpfgWngi0VXMKf2BkBVOu9ZLaLZ5NV/WiDuq1xtjBXnY1K/?=
 =?us-ascii?Q?LhMtur/Yb0zI7BCtz6+IfqT42Lhx5c/o3CA0/5zoOxBG/Qbv2gKvC7tMcnES?=
 =?us-ascii?Q?93H8G/hKW88i637D08WY59vEhitqVpjSgt1GfONeunIbb/RjaaTomf+P0wpF?=
 =?us-ascii?Q?2UXtSnnbbwtT5/dFRudeXDSbOPSdcSJJhAcFchmaBex1J5kXr88y35CYs1Qr?=
 =?us-ascii?Q?bwMFyYaULRyeXJhiOdQNU+aHvumVRb8FIVtjaRgKZcUODmgTaHBTkVLz3lln?=
 =?us-ascii?Q?EyuSGOnhlhCXIlaTbApL/5z/4QNb2JERQk9r2uuOGf2OqcroM3GnyY0HL9+f?=
 =?us-ascii?Q?zvbZKa+7lErFGMmhMg7A0pqVU8GY+ZCHxvlvm7VFekE6aZfEyAaJupp1uMJZ?=
 =?us-ascii?Q?cRSr8KuHkZ7l0d2P3qQOqKpyWSEpN+Hw6sMIPmXG4GwLASkKnxMsf6altJMQ?=
 =?us-ascii?Q?Xuvbr33cwueLuV4xbb8ra2xB6DaijVt8aW4yWHL6u5flxQgkEX+3LVBZelpe?=
 =?us-ascii?Q?r2SLkUtwgJwRp86e14Z5BmukrJB3RxKH9bvttw+/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FPd1tVPMZUkK9RhF2H3FBkMghw/VYTLMdJMFrGfPgIkTHUjtwLibQ/1ipIVC6JGdoLBgPqSWLGNH7njbseSnNsklFL3oh/wzWJB0kX7IyclQITNo4fqvwhYkmu4GS9Wc4jdLwQ09flP5eYR7Tg1euY8E8WyuA/wm0ZSCJakpTvJjxmHNnONHT8m3BlyiVcxlVWfXltJkh7IARv4GXCMXS7n88EFcS8AhvxUaig8E5sFBFP38ijvAQ4eFHvDDYqQGm718azSzfT+zCiLl3NzMInwX2k3H4AShGYUymuWG0pzR5uPPqR0rwSZx4Pc8BG1zYfkYMjV8IJdddukdVR+m6qY84mHw5P5bZhQs656sEBravMZMyIIRUy6H/fkO8+824+1jS+JxUDAyh16GTb9flNEgbWbPkUh9ty8oegMvSPFlQDFjvB7jxBmuTzSJ/ghLAYoR0SHW9PlKHQQRLxZ5/0prmbIuH7bq8xJTu6OYu/OJdkc8fWVPtqh+7LMVUWSV3bh/eyRE9ebaGE/HM7Zds1KNT5unvHlUMUShR6mbgBXocnpMxvU0/iQqrN+v5InZA/3LihT38/HZ95JLqxs6gostolryNlMQz1zgURJjXkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb37131-e0da-4426-aa27-08dd5c1fb189
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:55:35.1252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nY8ArCuK1rxIA7TFtsdeZ3FnW3wnsfb0zHjOy6YzXq2ep4NH5M7hOVcK58GLr8+ClYtbhFjUvAkkLBHNT33Nnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050152
X-Proofpoint-GUID: Rg7TnfiXoebhNJp4rSuvH_KLiLEkGYMX
X-Proofpoint-ORIG-GUID: Rg7TnfiXoebhNJp4rSuvH_KLiLEkGYMX

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250305 14:43]:
> On Wed, Mar 05, 2025 at 01:52:10PM -0500, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250303 06:08]:
> > > A number of mremap() calls both pass around and modify a large number of
> > > parameters, making the code less readable and often repeatedly having to
> > > determine things such as VMA, size delta, and more.
> > >
> > > Avoid this by using the common pattern of passing a state object through
> > > the operation, updating it as we go. We introduce the vma_remap_struct or
> > > 'VRM' for this purpose.
> > >
> > > This also gives us the ability to accumulate further state through the
> > > operation that would otherwise require awkward and error-prone pointer
> > > passing.
> > >
> > > We can also now trivially define helper functions that operate on a VRM
> > > object.
> > >
> > > This pattern has proven itself to be very powerful when implemented for VMA
> > > merge, VMA unmapping and memory mapping operations, so it is battle-tested
> > > and functional.
> > >
> > > We both introduce the data structure and use it, introducing helper
> > > functions as needed to make things readable, we move some state such as
> > > mmap lock and mlock() status to the VRM, we introduce a means of
> > > classifying the type of mremap() operation and de-duplicate the
> > > get_unmapped_area() lookup.
> > >
> > > We also neatly thread userfaultfd state throughout the operation.
> > >
> > > Note that there is further refactoring to be done, chiefly adjust
> > > move_vma() to accept a VRM parameter. We defer this as there is
> > > pre-requisite work required to be able to do so which we will do in a
> > > subsequent patch.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/mremap.c | 559 +++++++++++++++++++++++++++++++++-------------------
> > >  1 file changed, 354 insertions(+), 205 deletions(-)
> > >
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index c4abda8dfc57..7f0c71aa9bb9 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -32,6 +32,43 @@
> > >
> > >  #include "internal.h"
> > >
> > > +/* Classify the kind of remap operation being performed. */
> > > +enum mremap_operation {
> > > +	MREMAP_NO_RESIZE, /* old_len == new_len, if not moved, do nothing. */
> > > +	MREMAP_SHRINK, /* old_len > new_len. */
> > > +	MREMAP_EXPAND, /* old_len < new_len. */
> >
> > Can we fix the spacing so the comments line up, please?
> 
> I've had review the other way before :) But sure, I mean I actually
> agree. Perhaps I was following stuff I already saw in the kernel on this,
> but yeah let's align this!
> 
> >
> > It might be worth having a MREMAP_INVALID here and init to that, then a
> > VM_BUG_ON(), but maybe I'm just paranoid.
> 
> Sure can do.
> 
> >
> > > +};
> > > +
> > > +/*
> > > + * Describes a VMA mremap() operation and is threaded throughout it.
> > > + *
> > > + * Any of the fields may be mutated by the operation, however these values will
> > > + * always accurately reflect the remap (for instance, we may adjust lengths and
> > > + * delta to account for hugetlb alignment).
> > > + */
> > > +struct vma_remap_struct {
> > > +	/* User-provided state. */
> > > +	unsigned long addr; /* User-specified address from which we remap. */
> > > +	unsigned long old_len; /* Length of range being remapped. */
> > > +	unsigned long new_len; /* Desired new length of mapping. */
> > > +	unsigned long flags; /* user-specified MREMAP_* flags. */
> > > +	unsigned long new_addr; /* Optionally, desired new address. */
> >
> > Same comment about the comment spacing here.  Might be better to have
> > user_flags?  Since we have the passed in flags, the map flags and the
> > vma flags.
> 
> Sure can align.
> 
> We don't pass in map flags? We set map flags to pass to get_unmapped_area()
> in one place. Or in a final version, it's in one place.
> 
> We don't set map_flags in vma_remap_struct either. In fact here we only
> have one flags field, which is commented as such here.
> 
> I'm not sure about user_flags, I feel like that's confusing, mremap_flags
> be ok? But then that feels somewhat redundant in a struct literally all
> about an mremap?
> 
> It's fine this isn't a big deal, mremap_flags?

Good point.  I have no strong opinion on this either, feel free to keep
it as flags.

> 
> >
> > > +
> > > +	/* uffd state. */
> > > +	struct vm_userfaultfd_ctx *uf;
> > > +	struct list_head *uf_unmap_early;
> > > +	struct list_head *uf_unmap;
> >
> > ... sigh, yeah.
> 
> Well, better put here right?
> 
> >
> > > +
> > > +	/* VMA state, determined in do_mremap(). */
> > > +	struct vm_area_struct *vma;
> > > +
> > > +	/* Internal state, determined in do_mremap(). */
> > > +	unsigned long delta; /* Absolute delta of old_len, new_len. */
> > > +	bool locked; /* Was the VMA mlock()'d (has the VM_LOCKED flag set). */
> >
> > bool mlocked ?
> 
> Sure will rename.

Thanks.

> 
> >
> > > +	enum mremap_operation remap_type; /* expand, shrink, etc. */
> > > +	bool mmap_locked; /* Is current->mm currently write-locked? */
> > > +};
> > > +
> > >  static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> > >  {
> > >  	pgd_t *pgd;
> > > @@ -693,6 +730,97 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> > >  	return len + old_addr - old_end;	/* how much done */
> > >  }
> > >
> > > +/* Set vrm->delta to the difference in VMA size specified by user. */
> > > +static void vrm_set_delta(struct vma_remap_struct *vrm)
> > > +{
> > > +	vrm->delta = abs_diff(vrm->old_len, vrm->new_len);
> > > +}
> > > +
> > > +/* Determine what kind of remap this is - shrink, expand or no resize at all. */
> > > +static enum mremap_operation vrm_remap_type(struct vma_remap_struct *vrm)
> > > +{
> > > +	if (vrm->delta == 0)
> > > +		return MREMAP_NO_RESIZE;
> > > +
> > > +	if (vrm->old_len > vrm->new_len)
> > > +		return MREMAP_SHRINK;
> > > +
> > > +	return MREMAP_EXPAND;
> > > +}
> > > +
> > > +/* Set the vrm->remap_type, assumes state is sufficient set up for this. */
> > > +static void vrm_set_remap_type(struct vma_remap_struct *vrm)
> > > +{
> > > +	vrm->remap_type = vrm_remap_type(vrm);
> >
> > The vrm_remap_type() function is only used once, maybe we don't need
> > both set and get?
> 
> I sort of felt it was neater to have a separate function but you're right
> this is a bit silly, will inline!

Yeah, we can move it externally if we need it.  Thanks.

> 
> >
> > > +}
> > > +
> > > +/*
> > > + * When moving a VMA to vrm->new_adr, does this result in the new and old VMAs
> > > + * overlapping?
> > > + */
> > > +static bool vrm_overlaps(struct vma_remap_struct *vrm)
> > > +{
> > > +	unsigned long start_old = vrm->addr;
> > > +	unsigned long start_new = vrm->new_addr;
> > > +	unsigned long end_old = vrm->addr + vrm->old_len;
> > > +	unsigned long end_new = vrm->new_addr + vrm->new_len;
> > > +
> > > +	/*
> > > +	 * start_old    end_old
> > > +	 *     |-----------|
> > > +	 *     |           |
> > > +	 *     |-----------|
> > > +	 *             |-------------|
> > > +	 *             |             |
> > > +	 *             |-------------|
> > > +	 *         start_new      end_new
> > > +	 */
> > > +	if (end_old > start_new && end_new > start_old)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +/* Do the mremap() flags require that the new_addr parameter be specified? */
> > > +static bool vrm_implies_new_addr(struct vma_remap_struct *vrm)
> > > +{
> > > +	return vrm->flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
> > > +}
> >
> > These five might benefit from being inlined (although I hope our
> > compiler is good enough for this).
> 
> Hm, I thought there was no difference when placed in a compilation unit
> like this?

I think it's up to the compiler, and I'm not sure it changes unless we
force it anyways.  Feel free to leave it.

> 
> >
> > > +
> > > +/*
> > > + * Find an unmapped area for the requested vrm->new_addr.
> > > + *
> > > + * If MREMAP_FIXED then this is equivalent to a MAP_FIXED mmap() call. If only
> > > + * MREMAP_DONTUNMAP is set, then this is equivalent to providing a hint to
> > > + * mmap(), otherwise this is equivalent to mmap() specifying a NULL address.
> > > + *
> > > + * Returns 0 on success (with vrm->new_addr updated), or an error code upon
> > > + * failure.
> > > + */
> > > +static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
> > > +{
> > > +	struct vm_area_struct *vma = vrm->vma;
> > > +	unsigned long map_flags = 0;
> > > +	/* Page Offset _into_ the VMA. */
> > > +	pgoff_t internal_pgoff = (vrm->addr - vma->vm_start) >> PAGE_SHIFT;
> > > +	pgoff_t pgoff = vma->vm_pgoff + internal_pgoff;
> > > +	unsigned long new_addr = vrm_implies_new_addr(vrm) ? vrm->new_addr : 0;
> > > +	unsigned long res;
> > > +
> > > +	if (vrm->flags & MREMAP_FIXED)
> > > +		map_flags |= MAP_FIXED;
> > > +	if (vma->vm_flags & VM_MAYSHARE)
> > > +		map_flags |= MAP_SHARED;
> > > +
> > > +	res = get_unmapped_area(vma->vm_file, new_addr, vrm->new_len, pgoff,
> > > +				map_flags);
> > > +	if (IS_ERR_VALUE(res))
> > > +		return res;
> > > +
> > > +	vrm->new_addr = res;
> > > +	return 0;
> > > +}
> > > +
> > >  static unsigned long move_vma(struct vm_area_struct *vma,
> > >  		unsigned long old_addr, unsigned long old_len,
> > >  		unsigned long new_len, unsigned long new_addr,
> > > @@ -860,18 +988,15 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> > >   * resize_is_valid() - Ensure the vma can be resized to the new length at the give
> > >   * address.
> > >   *
> > > - * @vma: The vma to resize
> > > - * @addr: The old address
> > > - * @old_len: The current size
> > > - * @new_len: The desired size
> > > - * @flags: The vma flags
> > > - *
> > >   * Return 0 on success, error otherwise.
> > >   */
> > > -static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
> > > -	unsigned long old_len, unsigned long new_len, unsigned long flags)
> > > +static int resize_is_valid(struct vma_remap_struct *vrm)
> > >  {
> > >  	struct mm_struct *mm = current->mm;
> > > +	struct vm_area_struct *vma = vrm->vma;
> > > +	unsigned long addr = vrm->addr;
> > > +	unsigned long old_len = vrm->old_len;
> > > +	unsigned long new_len = vrm->new_len;
> > >  	unsigned long pgoff;
> > >
> > >  	/*
> > > @@ -883,11 +1008,12 @@ static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
> > >  	 * behavior.  As a result, fail such attempts.
> > >  	 */
> > >  	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
> > > -		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n", current->comm, current->pid);
> > > +		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
> > > +			     current->comm, current->pid);
> > >  		return -EINVAL;
> > >  	}
> > >
> > > -	if ((flags & MREMAP_DONTUNMAP) &&
> > > +	if ((vrm->flags & MREMAP_DONTUNMAP) &&
> > >  			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
> > >  		return -EINVAL;
> > >
> > > @@ -907,99 +1033,114 @@ static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
> > >  	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
> > >  		return -EFAULT;
> > >
> > > -	if (!mlock_future_ok(mm, vma->vm_flags, new_len - old_len))
> > > +	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
> > >  		return -EAGAIN;
> > >
> > > -	if (!may_expand_vm(mm, vma->vm_flags,
> > > -				(new_len - old_len) >> PAGE_SHIFT))
> > > +	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
> > >  		return -ENOMEM;
> > >
> > >  	return 0;
> > >  }
> > >
> > >  /*
> > > - * mremap_to() - remap a vma to a new location
> > > - * @addr: The old address
> > > - * @old_len: The old size
> > > - * @new_addr: The target address
> > > - * @new_len: The new size
> > > - * @locked: If the returned vma is locked (VM_LOCKED)
> > > - * @flags: the mremap flags
> > > - * @uf: The mremap userfaultfd context
> > > - * @uf_unmap_early: The userfaultfd unmap early context
> > > - * @uf_unmap: The userfaultfd unmap context
> > > + * The user has requested that the VMA be shrunk (i.e., old_len > new_len), so
> > > + * execute this, optionally dropping the mmap lock when we do so.
> > >   *
> > > + * In both cases this invalidates the VMA, however if we don't drop the lock,
> > > + * then load the correct VMA into vrm->vma afterwards.
> > > + */
> > > +static unsigned long shrink_vma(struct vma_remap_struct *vrm,
> > > +				bool drop_lock)
> > > +{
> > > +	struct mm_struct *mm = current->mm;
> > > +	unsigned long unmap_start = vrm->addr + vrm->new_len;
> > > +	unsigned long unmap_bytes = vrm->delta;
> > > +	unsigned long res;
> > > +	VMA_ITERATOR(vmi, mm, unmap_start);
> > > +
> > > +	VM_BUG_ON(vrm->remap_type != MREMAP_SHRINK);
> > > +
> > > +	res = do_vmi_munmap(&vmi, mm, unmap_start, unmap_bytes,
> > > +			    vrm->uf_unmap, drop_lock);
> > > +	vrm->vma = NULL; /* Invalidated. */
> > > +	if (res)
> > > +		return res;
> > > +
> > > +	/*
> > > +	 * If we've not dropped the lock, then we should reload the VMA to
> > > +	 * replace the invalidated VMA with the one that may have now been
> > > +	 * split.
> > > +	 */
> > > +	if (drop_lock)
> > > +		vrm->mmap_locked = false;
> > > +	else
> > > +		vrm->vma = vma_lookup(mm, vrm->addr);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * mremap_to() - remap a vma to a new location.
> > >   * Returns: The new address of the vma or an error.
> > >   */
> > > -static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
> > > -		unsigned long new_addr, unsigned long new_len, bool *locked,
> > > -		unsigned long flags, struct vm_userfaultfd_ctx *uf,
> > > -		struct list_head *uf_unmap_early,
> > > -		struct list_head *uf_unmap)
> > > +static unsigned long mremap_to(struct vma_remap_struct *vrm)
> > >  {
> > >  	struct mm_struct *mm = current->mm;
> > > -	struct vm_area_struct *vma;
> > > -	unsigned long ret;
> > > -	unsigned long map_flags = 0;
> > > +	unsigned long err;
> > >
> > >  	/* Is the new length or address silly? */
> > > -	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> > > +	if (vrm->new_len > TASK_SIZE ||
> > > +	    vrm->new_addr > TASK_SIZE - vrm->new_len)
> > >  		return -EINVAL;
> > >
> > > -	/* Ensure the old/new locations do not overlap. */
> > > -	if (addr + old_len > new_addr && new_addr + new_len > addr)
> > > +	if (vrm_overlaps(vrm))
> > >  		return -EINVAL;
> > >
> > > -	if (flags & MREMAP_FIXED) {
> > > +	if (vrm->flags & MREMAP_FIXED) {
> > >  		/*
> > >  		 * In mremap_to().
> > >  		 * VMA is moved to dst address, and munmap dst first.
> > >  		 * do_munmap will check if dst is sealed.
> > >  		 */
> > > -		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
> > > -		if (ret)
> > > -			return ret;
> > > -	}
> > > +		err = do_munmap(mm, vrm->new_addr, vrm->new_len,
> > > +				vrm->uf_unmap_early);
> > > +		vrm->vma = NULL; /* Invalidated. */
> > > +		if (err)
> > > +			return err;
> > >
> > > -	if (old_len > new_len) {
> > > -		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
> > > -		if (ret)
> > > -			return ret;
> > > -		old_len = new_len;
> > > +		/*
> > > +		 * If we remap a portion of a VMA elsewhere in the same VMA,
> > > +		 * this can invalidate the old VMA and iterator. Reset.
> > > +		 */
> > > +		vrm->vma = vma_lookup(mm, vrm->addr);
> >
> > You say it invalidates the iterator, but this doesn't change an
> > iterator?
> 
> Yeah there used to be one, didn't update comment, will fix.

Thanks.

> 
> >
> > >  	}
> > >
> > > -	vma = vma_lookup(mm, addr);
> > > -	if (!vma)
> > > -		return -EFAULT;
> > > +	if (vrm->remap_type == MREMAP_SHRINK) {
> > > +		err = shrink_vma(vrm, /* drop_lock= */false);
> >
> > It is not immediately clear if we could have a MREMAP_FIXED also
> > MREMAP_SHRINK.  In that case, we would try to do_munmap() twice.  This
> > shouldn't be an issue as do_vmi_munmap() would catch it, but I am not
> > sure if you noticed this.
> 
> I think this case is pretty subtle actually. The logic already looked like
> this, only more hidden.
> 
> So we:
> 
> 1. Unmap the target area at the new, shorter, length if MREMAP_FIXED.
> 2. Then remove the 'extra' portion in the source that we are shrinking 'off'.
> 
> E.g.:
> 
> 
> |--.------.---|         |--------.---.---|
> |  .      .   |   ->    |        .   .   |
> |--.------.---|         |--------.---.---|
> 
> Implies:
> 
> 1. Remove the delta from the original:
> 
> |--.---|  |---|         |--------.---.---|
> |  .   |  |   |   ->    |        .   .   |
> |--.---|  |---|         |--------.---.---|
> 
> 2. Unmap target area:
> 
> |--.---|  |---|         |--------|   |---|
> |  .   |  |   |   ->    |        |   |   |
> |--.---|  |---|         |--------|   |---|

Nice pictures.

> 
> The reason we do this is because MREMAP_DONTUNMAP might be set, and we
> start by doing a _copy_ of the VMA, then move page tables, then finally, if
> MREMAP_DONTUNMAP is _not_ set we finally unmap the original, shrunk VMA.
> 
> I mean this is all very very insane and maybe we can just like... not do
> this haha.
> 
> But a future thing, perhaps.

Right, thanks.

> 
> 
> >
> > > +		if (err)
> > > +			return err;
> > >
> > > -	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
> > > -	if (ret)
> > > -		return ret;
> > > +		/* Set up for the move now shrink has been executed. */
> > > +		vrm->old_len = vrm->new_len;
> > > +	}
> > > +
> > > +	err = resize_is_valid(vrm);
> > > +	if (err)
> > > +		return err;
> > >
> > >  	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
> > > -	if (flags & MREMAP_DONTUNMAP &&
> > > -		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
> > > +	if (vrm->flags & MREMAP_DONTUNMAP &&
> > > +		!may_expand_vm(mm, vrm->vma->vm_flags, vrm->old_len >> PAGE_SHIFT)) {
> > >  		return -ENOMEM;
> >
> > nit: whitespace here is a bit odd to read.
> 
> Will find a way to fix, I agree this is a bit horrid.
> 
> >
> > >  	}
> > >
> > > -	if (flags & MREMAP_FIXED)
> > > -		map_flags |= MAP_FIXED;
> > > -
> > > -	if (vma->vm_flags & VM_MAYSHARE)
> > > -		map_flags |= MAP_SHARED;
> > > -
> > > -	ret = get_unmapped_area(vma->vm_file, new_addr, new_len, vma->vm_pgoff +
> > > -				((addr - vma->vm_start) >> PAGE_SHIFT),
> > > -				map_flags);
> > > -	if (IS_ERR_VALUE(ret))
> > > -		return ret;
> > > -
> > > -	/* We got a new mapping */
> > > -	if (!(flags & MREMAP_FIXED))
> > > -		new_addr = ret;
> > > +	err = vrm_set_new_addr(vrm);
> > > +	if (err)
> > > +		return err;
> > >
> > > -	return move_vma(vma, addr, old_len, new_len, new_addr, locked, flags,
> > > -			uf, uf_unmap);
> > > +	return move_vma(vrm->vma, vrm->addr, vrm->old_len, vrm->new_len,
> > > +			vrm->new_addr, &vrm->locked, vrm->flags,
> > > +			vrm->uf, vrm->uf_unmap);
> >
> > I see where this is going..
> 
> ;)
> 
> >
> > >  }
> > >
> > >  static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
> > > @@ -1016,22 +1157,33 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
> > >  	return 1;
> > >  }
> > >
> > > -/* Do the mremap() flags require that the new_addr parameter be specified? */
> > > -static bool implies_new_addr(unsigned long flags)
> > > +/* Determine whether we are actually able to execute an in-place expansion. */
> > > +static bool vrm_can_expand_in_place(struct vma_remap_struct *vrm)
> > >  {
> > > -	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
> > > +	/* Number of bytes from vrm->addr to end of VMA. */
> > > +	unsigned long suffix_bytes = vrm->vma->vm_end - vrm->addr;
> > > +
> > > +	/* If end of range aligns to end of VMA, we can just expand in-place. */
> > > +	if (suffix_bytes != vrm->old_len)
> > > +		return false;
> > > +
> > > +	/* Check whether this is feasible. */
> > > +	if (!vma_expandable(vrm->vma, vrm->delta))
> > > +		return false;
> > > +
> > > +	return true;
> > >  }
> > >
> > >  /*
> > >   * Are the parameters passed to mremap() valid? If so return 0, otherwise return
> > >   * error.
> > >   */
> > > -static unsigned long check_mremap_params(unsigned long addr,
> > > -					 unsigned long flags,
> > > -					 unsigned long old_len,
> > > -					 unsigned long new_len,
> > > -					 unsigned long new_addr)
> > > +static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
> > > +
> > >  {
> > > +	unsigned long addr = vrm->addr;
> > > +	unsigned long flags = vrm->flags;
> > > +
> > >  	/* Ensure no unexpected flag values. */
> > >  	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
> > >  		return -EINVAL;
> > > @@ -1045,15 +1197,15 @@ static unsigned long check_mremap_params(unsigned long addr,
> > >  	 * for DOS-emu "duplicate shm area" thing. But
> > >  	 * a zero new-len is nonsensical.
> > >  	 */
> > > -	if (!PAGE_ALIGN(new_len))
> > > +	if (!PAGE_ALIGN(vrm->new_len))
> > >  		return -EINVAL;
> > >
> > >  	/* Remainder of checks are for cases with specific new_addr. */
> > > -	if (!implies_new_addr(flags))
> > > +	if (!vrm_implies_new_addr(vrm))
> > >  		return 0;
> > >
> > >  	/* The new address must be page-aligned. */
> > > -	if (offset_in_page(new_addr))
> > > +	if (offset_in_page(vrm->new_addr))
> > >  		return -EINVAL;
> > >
> > >  	/* A fixed address implies a move. */
> > > @@ -1061,7 +1213,7 @@ static unsigned long check_mremap_params(unsigned long addr,
> > >  		return -EINVAL;
> > >
> > >  	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
> > > -	if (flags & MREMAP_DONTUNMAP && old_len != new_len)
> > > +	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
> > >  		return -EINVAL;
> > >
> > >  	/*
> > > @@ -1090,11 +1242,11 @@ static unsigned long check_mremap_params(unsigned long addr,
> > >   * If we discover the VMA is locked, update mm_struct statistics accordingly and
> > >   * indicate so to the caller.
> > >   */
> > > -static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
> > > -					unsigned long delta, bool *locked)
> > > +static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
> > >  {
> > >  	struct mm_struct *mm = current->mm;
> > > -	long pages = delta >> PAGE_SHIFT;
> > > +	long pages = vrm->delta >> PAGE_SHIFT;
> > > +	struct vm_area_struct *vma = vrm->vma;
> > >  	VMA_ITERATOR(vmi, mm, vma->vm_end);
> > >  	long charged = 0;
> > >
> > > @@ -1114,7 +1266,7 @@ static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
> > >  	 * adjacent to the expanded vma and otherwise
> > >  	 * compatible.
> > >  	 */
> > > -	vma = vma_merge_extend(&vmi, vma, delta);
> > > +	vma = vrm->vma = vma_merge_extend(&vmi, vma, vrm->delta);
> > >  	if (!vma) {
> > >  		vm_unacct_memory(charged);
> > >  		return -ENOMEM;
> > > @@ -1123,42 +1275,34 @@ static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
> > >  	vm_stat_account(mm, vma->vm_flags, pages);
> > >  	if (vma->vm_flags & VM_LOCKED) {
> > >  		mm->locked_vm += pages;
> > > -		*locked = true;
> > > +		vrm->locked = true;
> > >  	}
> > >
> > >  	return 0;
> > >  }
> > >
> > > -static bool align_hugetlb(struct vm_area_struct *vma,
> > > -			  unsigned long addr,
> > > -			  unsigned long new_addr,
> > > -			  unsigned long *old_len_ptr,
> > > -			  unsigned long *new_len_ptr,
> > > -			  unsigned long *delta_ptr)
> > > +static bool align_hugetlb(struct vma_remap_struct *vrm)
> > >  {
> > > -	unsigned long old_len = *old_len_ptr;
> > > -	unsigned long new_len = *new_len_ptr;
> > > -	struct hstate *h __maybe_unused = hstate_vma(vma);
> > > +	struct hstate *h __maybe_unused = hstate_vma(vrm->vma);
> > >
> > > -	old_len = ALIGN(old_len, huge_page_size(h));
> > > -	new_len = ALIGN(new_len, huge_page_size(h));
> > > +	vrm->old_len = ALIGN(vrm->old_len, huge_page_size(h));
> > > +	vrm->new_len = ALIGN(vrm->new_len, huge_page_size(h));
> > >
> > >  	/* addrs must be huge page aligned */
> > > -	if (addr & ~huge_page_mask(h))
> > > +	if (vrm->addr & ~huge_page_mask(h))
> > >  		return false;
> > > -	if (new_addr & ~huge_page_mask(h))
> > > +	if (vrm->new_addr & ~huge_page_mask(h))
> > >  		return false;
> > >
> > >  	/*
> > >  	 * Don't allow remap expansion, because the underlying hugetlb
> > >  	 * reservation is not yet capable to handle split reservation.
> > >  	 */
> > > -	if (new_len > old_len)
> > > +	if (vrm->new_len > vrm->old_len)
> > >  		return false;
> > >
> > > -	*old_len_ptr = old_len;
> > > -	*new_len_ptr = new_len;
> > > -	*delta_ptr = abs_diff(old_len, new_len);
> > > +	vrm_set_delta(vrm);
> > > +
> > >  	return true;
> > >  }
> > >
> > > @@ -1169,19 +1313,16 @@ static bool align_hugetlb(struct vm_area_struct *vma,
> > >   * Try to do so in-place, if this fails, then move the VMA to a new location to
> > >   * action the change.
> > >   */
> > > -static unsigned long expand_vma(struct vm_area_struct *vma,
> > > -				unsigned long addr, unsigned long old_len,
> > > -				unsigned long new_len, unsigned long flags,
> > > -				bool *locked_ptr, unsigned long *new_addr_ptr,
> > > -				struct vm_userfaultfd_ctx *uf_ptr,
> > > -				struct list_head *uf_unmap_ptr)
> > > +static unsigned long expand_vma(struct vma_remap_struct *vrm)
> > >  {
> > >  	unsigned long err;
> > > -	unsigned long map_flags;
> > > -	unsigned long new_addr; /* We ignore any user-supplied one. */
> > > -	pgoff_t pgoff;
> > > +	struct vm_area_struct *vma = vrm->vma;
> > > +	unsigned long addr = vrm->addr;
> > > +	unsigned long old_len = vrm->old_len;
> > > +	unsigned long new_len = vrm->new_len;
> > > +	unsigned long flags = vrm->flags;
> > >
> > > -	err = resize_is_valid(vma, addr, old_len, new_len, flags);
> > > +	err = resize_is_valid(vrm);
> > >  	if (err)
> > >  		return err;
> > >
> > > @@ -1189,10 +1330,9 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
> > >  	 * [addr, old_len) spans precisely to the end of the VMA, so try to
> > >  	 * expand it in-place.
> > >  	 */
> > > -	if (old_len == vma->vm_end - addr &&
> > > -	    vma_expandable(vma, new_len - old_len)) {
> > > -		err = expand_vma_inplace(vma, new_len - old_len, locked_ptr);
> > > -		if (IS_ERR_VALUE(err))
> > > +	if (vrm_can_expand_in_place(vrm)) {
> > > +		err = expand_vma_in_place(vrm);
> > > +		if (err)
> > >  			return err;
> > >
> > >  		/*
> > > @@ -1200,8 +1340,8 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
> > >  		 * satisfy the expectation that mlock()'ing a VMA maintains all
> > >  		 * of its pages in memory.
> > >  		 */
> > > -		if (*locked_ptr)
> > > -			*new_addr_ptr = addr;
> > > +		if (vrm->locked)
> > > +			vrm->new_addr = addr;
> > >
> > >  		/* OK we're done! */
> > >  		return addr;
> > > @@ -1217,62 +1357,65 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
> > >  		return -ENOMEM;
> > >
> > >  	/* Find a new location to move the VMA to. */
> > > -	map_flags = (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
> > > -	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > > -	new_addr = get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_flags);
> > > -	if (IS_ERR_VALUE(new_addr))
> > > -		return new_addr;
> > > -	*new_addr_ptr = new_addr;
> > > +	err = vrm_set_new_addr(vrm);
> > > +	if (err)
> > > +		return err;
> > >
> > > -	return move_vma(vma, addr, old_len, new_len, new_addr,
> > > -			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
> > > +	return move_vma(vma, addr, old_len, new_len, vrm->new_addr,
> > > +			&vrm->locked, flags, vrm->uf, vrm->uf_unmap);
> > >  }
> > >
> > >  /*
> > > - * Expand (or shrink) an existing mapping, potentially moving it at the
> > > - * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
> > > - *
> > > - * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
> > > - * This option implies MREMAP_MAYMOVE.
> > > + * Attempt to resize the VMA in-place, if we cannot, then move the VMA to the
> > > + * first available address to perform the operation.
> > >   */
> > > -SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> > > -		unsigned long, new_len, unsigned long, flags,
> > > -		unsigned long, new_addr)
> > > +static unsigned long mremap_at(struct vma_remap_struct *vrm)
> >
> > I hate this and mremap_to() names.  I don't have a proposed better name
> > for either and maybe it's just my experience with mremap_to() that has
> > tainted the view of the name itself, but I find them not very
> > descriptive and abruptly ended.  I guess move was already taken.
> >
> > I also have the added baggage of parsing "at" to potentially mean
> > "doing".
> >
> > mremap_inplace() seems equally annoying.  This is the worst bike shed.
> 
> Haha well yeah it's a bikeshed but yeah I agree, it's horrid I agree.
> 
> I was using the _at() only in line with the _to().
> 
> The 'in place' can kind of conflict with other references to in place which
> is used to differentiate between the case of us having to
> get_unmapped_area() and move vs. not having to.
> 
> So I feel like we're stuck with this...

Yes, I agree.

> 
> >
> > > +{
> > > +	unsigned long res;
> > > +
> > > +	switch (vrm->remap_type) {
> > > +	case MREMAP_NO_RESIZE:
> > > +		/* NO-OP CASE - resizing to the same size. */
> > > +		return vrm->addr;
> > > +	case MREMAP_SHRINK:
> > > +		/*
> > > +		 * SHRINK CASE. Can always be done in-place.
> > > +		 *
> > > +		 * Simply unmap the shrunken portion of the VMA. This does all
> > > +		 * the needed commit accounting, and we indicate that the mmap
> > > +		 * lock should be dropped.
> > > +		 */
> > > +		res = shrink_vma(vrm, /* drop_lock= */true);
> > > +		if (res)
> > > +			return res;
> > > +
> > > +		return vrm->addr;
> > > +	case MREMAP_EXPAND:
> > > +		return expand_vma(vrm);
> > > +	}
> > > +
> > > +	BUG();
> > > +}
> > > +
> > > +static unsigned long do_mremap(struct vma_remap_struct *vrm)
> > >  {
> > >  	struct mm_struct *mm = current->mm;
> > >  	struct vm_area_struct *vma;
> > >  	unsigned long ret;
> > > -	unsigned long delta;
> > > -	bool locked = false;
> > > -	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
> > > -	LIST_HEAD(uf_unmap_early);
> > > -	LIST_HEAD(uf_unmap);
> > >
> > > -	/*
> > > -	 * There is a deliberate asymmetry here: we strip the pointer tag
> > > -	 * from the old address but leave the new address alone. This is
> > > -	 * for consistency with mmap(), where we prevent the creation of
> > > -	 * aliasing mappings in userspace by leaving the tag bits of the
> > > -	 * mapping address intact. A non-zero tag will cause the subsequent
> > > -	 * range checks to reject the address as invalid.
> > > -	 *
> > > -	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
> > > -	 * information.
> > > -	 */
> > > -	addr = untagged_addr(addr);
> > > -
> > > -	ret = check_mremap_params(addr, flags, old_len, new_len, new_addr);
> > > +	ret = check_mremap_params(vrm);
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	old_len = PAGE_ALIGN(old_len);
> > > -	new_len = PAGE_ALIGN(new_len);
> > > -	delta = abs_diff(old_len, new_len);
> > > +	vrm->old_len = PAGE_ALIGN(vrm->old_len);
> > > +	vrm->new_len = PAGE_ALIGN(vrm->new_len);
> > > +	vrm_set_delta(vrm);
> > >
> > >  	if (mmap_write_lock_killable(mm))
> > >  		return -EINTR;
> > > +	vrm->mmap_locked = true;
> > >
> > > -	vma = vma_lookup(mm, addr);
> > > +	vma = vrm->vma = vma_lookup(mm, vrm->addr);
> > >  	if (!vma) {
> > >  		ret = -EFAULT;
> > >  		goto out;
> > > @@ -1285,62 +1428,68 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> > >  	}
> > >
> > >  	/* Align to hugetlb page size, if required. */
> > > -	if (is_vm_hugetlb_page(vma) &&
> > > -	    !align_hugetlb(vma, addr, new_addr, &old_len, &new_len, &delta)) {
> > > +	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
> > >  		ret = -EINVAL;
> > >  		goto out;
> > >  	}
> > >
> > > -	/* Are we RELOCATING the VMA to a SPECIFIC address? */
> > > -	if (implies_new_addr(flags)) {
> > > -		ret = mremap_to(addr, old_len, new_addr, new_len,
> > > -				&locked, flags, &uf, &uf_unmap_early,
> > > -				&uf_unmap);
> > > -		goto out;
> > > -	}
> > > +	vrm_set_remap_type(vrm);
> > >
> > > -	/*
> > > -	 * From here on in we are only RESIZING the VMA, attempting to do so
> > > -	 * in-place, moving the VMA if we cannot.
> > > -	 */
> > > +	/* Actually execute mremap. */
> > > +	ret = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
> > >
> > > -	/* NO-OP CASE - resizing to the same size. */
> > > -	if (new_len == old_len) {
> > > -		ret = addr;
> > > -		goto out;
> > > -	}
> > > -
> > > -	/* SHRINK CASE. Can always be done in-place. */
> > > -	if (new_len < old_len) {
> > > -		VMA_ITERATOR(vmi, mm, addr + new_len);
> > > +out:
> > > +	if (vrm->mmap_locked) {
> > > +		mmap_write_unlock(mm);
> > > +		vrm->mmap_locked = false;
> > >
> > > -		/*
> > > -		 * Simply unmap the shrunken portion of the VMA. This does all
> > > -		 * the needed commit accounting, unlocking the mmap lock.
> > > -		 */
> > > -		ret = do_vmi_munmap(&vmi, mm, addr + new_len, delta,
> > > -				    &uf_unmap, true);
> > > -		if (ret)
> > > -			goto out;
> > > -
> > > -		/* We succeeded, mmap lock released for us. */
> > > -		ret = addr;
> > > -		goto out_unlocked;
> > > +		if (!offset_in_page(ret) && vrm->locked && vrm->new_len > vrm->old_len)
> > > +			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
> >
> > It isn't clear to me why we only populate if we are locked here.
> > Actually, I'm not sure why we keep holding the lock until here or why it
> > matters to drop it early.  The main reason we want to drop the lock is
> > to reduce the mmap lock time held for the populate operation.
> >
> > So we can either drop the lock before we get here once the vma tree is
> > updated, or we can unconditionally unlock.
> >
> > I think we can simplify this further if we just keep the lock held until
> > we downgrade here and populate if necessary after it's dropped.  That
> > is, shrink just does nothing with the lock and we just unlock it
> > regardless.
> >
> > I'm pretty sure that we would struggle to measure the performance impact
> > holding the lock for the return path when the populate is removed from
> > the critical section.
> 
> I'm in agreement that this is a horrid and weird mess, and I stared at this
> a long time myself.
> 
> But I feel we should defer changing this until after the refactor series as
> it was an existing eldrich horror changing of which would sort of sit
> outside of 'obvious small fixups/safe moving around/etc.' that I limited
> myself to here.
> 
> Let's definitely come back and address this.

Ack, yeah.  Shouldn't change locking from a known mess to an unknown
but-maybe-cleaner mess in a refactor.

> 
> >
> > >  	}
> > >
> > > -	/* EXPAND case. We try to do in-place, if we can't, then we move it. */
> > > -	ret = expand_vma(vma, addr, old_len, new_len, flags, &locked, &new_addr,
> > > -			 &uf, &uf_unmap);
> > > +	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
> > > +	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
> > > +	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
> > >
> > > -out:
> > > -	if (offset_in_page(ret))
> > > -		locked = false;
> > > -	mmap_write_unlock(mm);
> > > -	if (locked && new_len > old_len)
> > > -		mm_populate(new_addr + old_len, delta);
> > > -out_unlocked:
> > > -	userfaultfd_unmap_complete(mm, &uf_unmap_early);
> > > -	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
> > > -	userfaultfd_unmap_complete(mm, &uf_unmap);
> > >  	return ret;
> > >  }
> > > +
> > > +/*
> > > + * Expand (or shrink) an existing mapping, potentially moving it at the
> > > + * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
> > > + *
> > > + * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
> > > + * This option implies MREMAP_MAYMOVE.
> > > + */
> > > +SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> > > +		unsigned long, new_len, unsigned long, flags,
> > > +		unsigned long, new_addr)
> > > +{
> > > +	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
> > > +	LIST_HEAD(uf_unmap_early);
> > > +	LIST_HEAD(uf_unmap);
> > > +	/*
> > > +	 * There is a deliberate asymmetry here: we strip the pointer tag
> > > +	 * from the old address but leave the new address alone. This is
> > > +	 * for consistency with mmap(), where we prevent the creation of
> > > +	 * aliasing mappings in userspace by leaving the tag bits of the
> > > +	 * mapping address intact. A non-zero tag will cause the subsequent
> > > +	 * range checks to reject the address as invalid.
> > > +	 *
> > > +	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
> > > +	 * information.
> > > +	 */
> > > +	struct vma_remap_struct vrm = {
> > > +		.addr = untagged_addr(addr),
> > > +		.old_len = old_len,
> > > +		.new_len = new_len,
> > > +		.flags = flags,
> > > +		.new_addr = new_addr,
> > > +
> > > +		.uf = &uf,
> > > +		.uf_unmap_early = &uf_unmap_early,
> > > +		.uf_unmap = &uf_unmap,
> > > +	};
> > > +
> > > +	return do_mremap(&vrm);
> > > +}
> > > --
> > > 2.48.1
> > >

