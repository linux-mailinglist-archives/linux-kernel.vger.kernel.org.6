Return-Path: <linux-kernel+bounces-437747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE29E97FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB046162AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AEB1A23BD;
	Mon,  9 Dec 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W1o+LzvK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GSoTPblw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0F1A23B3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752721; cv=fail; b=CMCYdHy/ei8m7ynZUYYES7gkmWn+gWAooujytN1LGgIfzA72XhH5C5WDVgC/nv+uHEzYvDJZ+25hhD/TzoVXPJsXos+bYY8X7F4cwdd1NR/+iCIdg5AQbyiv6zg/CRHvfW/crB/UJ9RZfHqsX519kWwwSlx0UqVDKCsMMbYETBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752721; c=relaxed/simple;
	bh=BRLAMshur36EqPnpddlLvWhzjkozRSrMFBYmtmgg1xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mRrOYYnKtCA+RjS88n9YIdSW1gD+d31k91UiGdV8aJ1K6FXGoSeiMiDrQ71X17bSnxKa0Y1hkKhbZmNn5x324tglm4aY8atgMxLMXzVCDDz1aMTY89bjUglZdX9bHDfUfLMzRIYgn6585Sal9O3vGaKQ10K6bYjGDbsR6+T9MTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W1o+LzvK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GSoTPblw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98fsur022563;
	Mon, 9 Dec 2024 13:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=y4skQCCJNdYJcpggBThEJtsvFPNsKTzEvYsk2gg3fFE=; b=
	W1o+LzvKfk8Utb4DR52MFQvkeon7oWt3pA/EN/dkTdiaWsBvGSV12HywSqUGeIDC
	Bh4BgIiJg1eDZvuSr5vF7PnJtpFXNTS7otaDVL6VKF16FgnnfSycBSWma+zfQMbP
	2HMtuLNB96JcU/ANdNkemfpDRLxIotpaIrnJtzsUNVU7yeOY6pI+kqOIHZ10V+ks
	+H96l28l6jDkPtoVID+Bzbkr+X3fJtXOsP+R4Wbq+KEhlGL+Uu5CVan0hRdAVvDO
	lc2vnWQBeqTCPFraEGlJ9Hfn38odpr1gnvBAJmFKtqfvISH05ZyXnfYgx6pegHcM
	1WB8wChX+mdwVDi4AAKEMw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedc3aba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 13:58:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9CWnw8021260;
	Mon, 9 Dec 2024 13:58:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct6wqry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 13:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iu2YUU1YYnTEKJkRyi8wUdOSIr1rSSvs6okWXiii+hsuPaeX1qIc94tbe/CNPc1/bK59d2aHirTklXSas1BUb0feIqSTAMBuw7gU7/NfqWlIxKQgjmalF1v9Z726MW4pkPIPYRWNeJvyuzFq1LMg9x7eZWBkxSmIVVg9kAGKNTAIXmdYgxJWAHHuplHFD69mhC8Xsmy+Xpxs0W9uULLSrUdyp28x27vDnxnhVvwixLHd1rnU8QTqfqbx0gj8VBumx2RMKWStVW8782048rmSEG8q2HnKbBEBjybxybvOQQIO5lyNpU6W9onp1XLMuqNd8V+nU13S6ts/4gq3UMaQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4skQCCJNdYJcpggBThEJtsvFPNsKTzEvYsk2gg3fFE=;
 b=dOutYbRbub4RTy/h5GtSbOyyCQYZiYpuZJdMuJKI+/UMNG8iNqA4qOr2pm9MLXNwHqpg+1Ig9Yn4H6jXQX+GyQy5s4q4fBw7gKxZpqLmoJmUIFJyV0vHeIScLe87B1E1L5b1ZQwgpuL/woVAMdG5SB9PxMGPXA5tAWi0dgi1OgeJuXB1u3AJIlUln2jU/EdzJdx6ATE7FSwmFNJesaRCaHFiXMxo5It2XkhY6C6h+JqUoTzu0seNryb3NfEh493PEtmH5TXFuivYQJnZy4QUTLlGgoiWluw2HwsL+Z0g4VQ185cZEWTV01x1DKMVTY4jFpajwh3MwUutPzlaErR46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4skQCCJNdYJcpggBThEJtsvFPNsKTzEvYsk2gg3fFE=;
 b=GSoTPblwa5wf+SY84ntmdkS/ZGJuBJQR8H0HVmLF/vCwIF1zE98V47fYzVTiqOYxwwo35jJWYM/UHNLRrqID2eWSXBpEXxeqPBg4r/ZqKKIqN+0jutkUUIlNEU5hshuSxzdxbti3K75cBNMSZXP31YYWwRZMZWJkr1vWAm5fvXs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Mon, 9 Dec 2024 13:58:25 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 13:58:25 +0000
Date: Mon, 9 Dec 2024 13:58:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <e9b3987b-8cbf-48db-ae70-ff9e2c0954aa@lucifer.local>
References: <6756d273.050a0220.2477f.003d.GAE@google.com>
 <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
 <CAG48ez1d60kH1W8uVvOh-+Vs8Jz5TX1a8LD+mh_O8_3HFHAx6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1d60kH1W8uVvOh-+Vs8Jz5TX1a8LD+mh_O8_3HFHAx6w@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e48d37b-5acc-4efb-82cd-08dd18598ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlFWRnNpRFMxUk9raml3b01tZGF5NlpLZGd0bGN2TXlSd3hnMWs4RVBBZlBw?=
 =?utf-8?B?aDY3ekhJdG95T2htNytSSDN6WTVJR05Bb1libDB3NFQ4WnI2K2FZNjdFQXpG?=
 =?utf-8?B?d1Q1UDB3ajFaWUt4bEgvaG1NY3h3bkV1TWFpcFFZN3JscnJQamdmUzVWM3Zo?=
 =?utf-8?B?ejhKQ1pZNTd2T1RhYW5vMER4d3ROODNOY09sZDZkTGNhc3NvWEMwWUNyWito?=
 =?utf-8?B?cDBITEhtbWNraG85eHVtS0tMSDVsYXFFQ0lQaktzZkp6RFUxUUl3cm9oU0JQ?=
 =?utf-8?B?QmVraWdUcVp1V1lySFhwbWt4YTQxbHAxSGVReDdzN2Ntb1ByQ25pb2Y5TnFD?=
 =?utf-8?B?WGJTY3VuVE02ZHA5WURjZEhyZUs4czRpdGdpOG9kTnV6eXIwQXdLNTgvc2Nj?=
 =?utf-8?B?THZ2aEI3UVB0eWVYZ3VWMGhyMXg2QzV1aS9zTzRkMCtZYk9XRXJHd2Niekhh?=
 =?utf-8?B?UUFaRlU0UDZ6blpLQmlKWWpxL2hSVTE4NnBUdTJXUm1XS0xUTitzdnFHWWJR?=
 =?utf-8?B?alVRbGpWUmZuRzhmczB1S0dhTVpxMTV4YUZpdVJtNU1KOFEwOWtQakc3aG9i?=
 =?utf-8?B?bFUvN0VkQjZBNnlnajd4QXpnU0s5N1pBZC9GbXNqUG9iLzl4a3J3K0FjNGZu?=
 =?utf-8?B?ejZvUDBoZno1bXJsMDhPVnlMa2d0R0ZjM1p6K09GUTBMMU5tQzRJZ1FEdGJR?=
 =?utf-8?B?QzdibkhGbFRpMnRDaEpZMnBNY01wSnVzZG1PR0VGYVlpRGI5bk14SWZkOHd0?=
 =?utf-8?B?dzdGVkYxS2RTR3RmeG5nM05veWZsSWJLUHJHQWJMb2VpNEQvT0NDMS9qbURo?=
 =?utf-8?B?REFFdEREbFNvZmRRdllXS0t1UHZXY3UxVWJBYXREdXBDdCsya1o3SVU0Y1lp?=
 =?utf-8?B?dEJJejJMS1MzRE5yUk1Od0ZOTEdUVlJ6SjNMaGV0U051ZHh5RTQ5NHBOSXhq?=
 =?utf-8?B?amNwRVpuVTRIL1ZqRXlGMzYwSXVnbWFkcUxXYytER00vN3hBSWxDakt4U3Fi?=
 =?utf-8?B?Y0FmRFYrWWsxeVQ4RGpXRnFvbnpsQjlFNHR2UEJ4aTVQSGhMcHVELzBQb29x?=
 =?utf-8?B?THlRUTNkc1U2UE5LYWtxNk5VbnZiQit0SXNSVFpsb291WHdxd2tSc0tzYnVD?=
 =?utf-8?B?N29kR0xLdlZUeGtEOXNLcWpCTHhyR2JXNmtoYlgyU0x0ZVRmU2I3Q1prRDg4?=
 =?utf-8?B?b2JJZWw1RHY0SnI1cGJQamlEVEIyTEl4d1p4OUpGeWRIM0xVdEhWUkxpaUk2?=
 =?utf-8?B?N3NaSXh4dHN5U01kbzZpdUd0RUxTKzY5WHNZMVNjc2FjcUNzVTdpNFpxTlZL?=
 =?utf-8?B?ZTB3Rjg0d3Z6czJoRFQ4TEQzVS9rQ3ozQkJjSUNYNGYvR1dFWFpxN3BMZm4w?=
 =?utf-8?B?NGxYU2d1V21kaXBEckRqL0JGVUxvdTVRd0l1eEYrQmJNRXFsbFl4a3UwK2E5?=
 =?utf-8?B?eGx4MXBTWUZsMGNlaS93QXh4MG5qdjFGTXNTVEZvdERLSjlOUEtsZHBKNGwr?=
 =?utf-8?B?bWdJaUc5Z0hKS0x6NFNyeWRhZVBPSWZsaDdneXdyQ2FsV2tWVHMySUlQRGdQ?=
 =?utf-8?B?eFlYYjBnTlNOeW5HTzhkZUJ0QW92YnFveHFpWVFHSWdROGd6TVcza2NLRzVS?=
 =?utf-8?B?MWtteDVIb2FZMjcxdmEvL2Z1OXdGNi8ySk5SdjRQQnJZSSsvVUlzeGhGQjNI?=
 =?utf-8?B?bmwyUndJWkVleXFMQ2l5Rzhwd1ZHRTRoR0hHNFBtdFp6OWdpR0xvMURNM25R?=
 =?utf-8?Q?4bBmy9Y6MkLP8OOO2M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0trMDFOelpaZDhwN2M4UlNsVUZ2T2NOY1JzdC8xbXprNUZSdkdFT29HWk1t?=
 =?utf-8?B?Vy8zZnpsSjVFcGN5a0dvemNWSkZuWUcrQlA2QVg1YzF2bWQyWnBEbnRjMzBz?=
 =?utf-8?B?TVR6eHdZZDg5ZmhDNzVEOWJUVmUwdTYwcnU3b2w2dVJwOEJDSUUyalNQVEZv?=
 =?utf-8?B?Q1pKUDBNVUYxTnN4Wk5oOWtocFo1ak0wVFAva1ZZdGhnRW1jQ3NiQUwzOEQr?=
 =?utf-8?B?OElaV3BlajRkZUg3VWpld3FDSTlaWHd3SGlISUVjaE5NR0J3dXJVZnZYVUxV?=
 =?utf-8?B?WFdJcURRRFkxZ1lnVlFnVXpXWEJFNUNMSlEwWGRkOENpUmQvYUsremlEZS9t?=
 =?utf-8?B?MHlIK3NkZ0dYVFJtQjRGdlk1Ni9qVWxnazN4R0cwNCtiTTcwdWtvb1hNYlBr?=
 =?utf-8?B?YXE2TDdCeHcxOUowUDRGSDVGKzhPL0dpS3lsdVpBbmNncmIxN0FaRGJnWThK?=
 =?utf-8?B?NXZoRUZUeXZTbXlyU0tnVmp0cEYyWDAvVWp6Q0JvK0Y0WG5uWUNiajlZaGR4?=
 =?utf-8?B?c242NDFYQ3FpQlkwZTZaWDZ2akY1LzcxOGFEVE9TeThMcWhtYWxWZDl0RjFC?=
 =?utf-8?B?TVZwWHhFY2N2WXh0ZlpjZ1V4UFgzVVlnU3orR2Q0c0sySVhsYXhWbVdFUlZv?=
 =?utf-8?B?bVU0VGtQZ2MwVEVUOVdHTEJtRXo2SThNV1FSMkk5N3BucDhYVkVqeThVOEp5?=
 =?utf-8?B?UW0vbmZUS1FmeEhyTkFSY1FMNE1oZVBhVlYrMXpIZ1V3ZWVMb3lrQjF2N05l?=
 =?utf-8?B?U2d2RUxjOFdrYXo0OThraUpnaXRqY014SEZjVERMaVZINXFrc2VWM3VUOVVt?=
 =?utf-8?B?OS8yOEdVL0RUNzRKZk5naGJvalhxSk9NWDFwbEVaMkR4bU1BbzV4YVYwQkZy?=
 =?utf-8?B?MDNXNDBQSi81MnhZOUNVT0JvQ09lT0EwdWdmRHExYjRqeU53RkdxbjB5eDhU?=
 =?utf-8?B?TE14ZS9wYXNRMEpnUU4wRFVFZWcxOGlXRDEzUGtoRndNTGFISXAzN3JUbDAr?=
 =?utf-8?B?RkZaSmIvUHdhYm81QnY4SURBL2pSUURGOTNnbC84cnFTdEdOZmlkc1U3Z1BN?=
 =?utf-8?B?MHFzcnlNaTR2b3VYLzh0VFpMSTdVL2pUbWdXVE41UUNhaDNlOWhwRkxseUhq?=
 =?utf-8?B?b1NubW9NUHl4aGdnQW9OTWpuZGNadGNyVHljQnFPL0tWeFBJUU93Y1pEUjg1?=
 =?utf-8?B?RldJU3Z6bTRNRm14Y1J1NFh6ckNYRmJiS0VUVHFKUmt4T1RkOENZekc5Vmo4?=
 =?utf-8?B?N0ovOFVoNWhFZCtGWnl6RkgyaGtZQ1lKWStoR2dVSENRQy9SYjlTbm5uYmF3?=
 =?utf-8?B?Y0N3dmtMQ2tORnRZZEVOSGpJWCtIdTRhU0dtbUtGTVdTMnByNHdjaCtoRVZ3?=
 =?utf-8?B?ZVZIWmZrUy83QVdXTDhreGxiT240SWlrN2pvU09nV214WXJWRUt2N0h1cklX?=
 =?utf-8?B?N2N1MHk0Z2tHNWVRMXNTVzdZQk5ZcjFJWjZFTUdPUjc3K2JCZDY3NEpwNkVp?=
 =?utf-8?B?V3owaEJKZDlxZ1NXQ0FwTTZ6dXREY3R1REVDeXZoUzcyZElweklGT3V6NUNv?=
 =?utf-8?B?TGNVZmx5bzdsVUtqcnFMc0xEOGFBQjJ4NlVqT2R5cWdUU1ZEaDVCaVcwTzJw?=
 =?utf-8?B?eDFyT3ZNS2M3b0tQREZOMk9tc21zVXNzR1pwTTVzN25Eclp4d3NKQit0Nmtv?=
 =?utf-8?B?dkdqRVRLVVUrMkVoRWU1V3Ard2N3UVVIVStMd0ZFajN3eGhaYllKNWd1aktE?=
 =?utf-8?B?eWtBWEd2YjdZSm5EdWh6UGE5RnNXTlVrOFFOM1lJYm9JaUt2S1huRDB6YWNj?=
 =?utf-8?B?a1ltWFRTUE5jN0YvdFVpWS9XN2ZJMEJTTngrMWZ0ZHZvTmdJUWFZZGtwYXZC?=
 =?utf-8?B?cFB3UTdGSTU5aWlSTDd4dzE3a2s2MEhjSkpiMnB5ZHVrMmljOTNxNWNCUjdM?=
 =?utf-8?B?SnNGY1hTcEVrYmVBa0tPdzFqL29JdHBjcHdGNk9idWJCLzJNdWlNcEd4Y1Q1?=
 =?utf-8?B?VURuVzM0V2p1NUpQdjE4dkNxVzR0UkVackhWeG1CWStPeFFhTzdNUXUrbDlZ?=
 =?utf-8?B?eStCNnJ0cFBGY2tveG8zVS9zS0FMUDh6YkJnRFNzK2tlRVEwQ2trYi9LRlF6?=
 =?utf-8?B?dXZIRVdNTWltNmQrNXNscVVMY1FqQmh5TDVtSlVMK0JtWlREZmh1WG1SeWtu?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v1QnKcCpBy/HSefwEyZKmgpxr3mX5EU+X8SHl0RDVnsFZ0ykxKz97WGr40/Sreittr9o1mUJe5LoqJdgWbSd+XqgiVZfp/iFOP9n/im2ddu9cL+7RY6TW/vuW5vvK/WcXQemBiXNGw2bBnnaC2zHzDIpdK+hl58bu9M6pXqM8zXc63qEFE04jLB5b7kPuADjNNiZDLrbMxMwwZJsVeg4zhJiTdC6bwqHUUfoQRHRLQEK4DAyGUVuhdBQj4ln7WnWa3IKFbEWf2bVT3xl2Z+GyVM+UjhnKLTS+1ixF4J94Rx1ybffE0CN+PaA60VhLARaDZZnMc16ybRGfHailmkZaYq/+V68fh5+aBQnPtm8M9h9SPP3wvDehAS/4iyhxaVuTfT0HGknK8nlwfVsWw+Zd//zNN0v1ie0+owHMZ+P2UnpL14HmDaMwXYm4ftAz/TKAAj3q5pfOo/1hbR4/o2r/R+qwzPvYJE6UjPN9RlIiOUgBrrvqyoH2c44zxdB7XLB9t0dCqJ/fOkxmAkK/IyausF1VJJ00fjaWD/LY6wMHhSkE/9e4fEX5TkvQN17GBRPS+gU7muPNpzKMQVPHZbhqR4EnG8bcWOyuNjxIhDAWpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e48d37b-5acc-4efb-82cd-08dd18598ce3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 13:58:25.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhpDgzoLOAyxJql4isekR4jmsEa2GCGNfuIrEhD81XHSRNCsx9ssC7BBBA5Ko/1RB4+jAsu0FYV/Zf7UyaQxrBKi7t1K6M8CLOC/PFeQF3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_10,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090110
X-Proofpoint-ORIG-GUID: ttopiIVxNS4x0BYzdGxjQl57g72yqP62
X-Proofpoint-GUID: ttopiIVxNS4x0BYzdGxjQl57g72yqP62

On Mon, Dec 09, 2024 at 02:52:17PM +0100, Jann Horn wrote:
> On Mon, Dec 9, 2024 at 1:53 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Dec 09, 2024 at 03:20:19AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17f85fc0580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=2d788f4f7cb660dac4b7
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Points to this being racey.
> >
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/vmlinux-feffde68.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdcc9cb/bzImage-feffde68.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
> > >
> > > Oops: general protection fault, probably for non-canonical address 0xdffffc0000000080: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > KASAN: null-ptr-deref in range [0x0000000000000400-0x0000000000000407]
> >
> > This doesn't make a huge amount of sense to me, the VMA is not 0x400 (1,024)
> > bytes in size... and the actual faulting offset seems to be 0xdffffc0000000080
> > which is 0x80 off from some KASAN-specified value?
> >
> > This would be vma->vm_file. But that also doesn't really make any sense.
> >
> > But I wonder...
> >
> > I see in the report at [0] that there's a failure injection in vm_area_dup() on
> > fork:
> >
> > [   73.842623][ T5318]  ? kmem_cache_alloc_noprof+0x48/0x380
> > [   73.844725][ T5318]  ? __pfx___might_resched+0x10/0x10
> > [   73.846687][ T5318]  should_fail_ex+0x3b0/0x4e0
> > [   73.848496][ T5318]  should_failslab+0xac/0x100
> > [   73.850232][ T5318]  ? vm_area_dup+0x27/0x290
> > [   73.852017][ T5318]  kmem_cache_alloc_noprof+0x70/0x380
> > [   73.854011][ T5318]  vm_area_dup+0x27/0x290
> > [   73.855771][ T5318]  copy_mm+0xc1d/0x1f90
> >
> > I also see in the fork logic we have the following code on error path:
> >
> >         mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> >         mas_store(&vmi.mas, XA_ZERO_ENTRY);
> >
> > And XA_ZERO_ENTRY is 0x406.
> >
> > Now if _somehow_ the VMA was being looked up without XA_ZERO_ENTRY being
> > properly accounted for, this might explain it, and why all the !vma logic would
> > be bypassed.
>
> You fixed another issue in this area a month ago, right?
> (https://project-zero.issues.chromium.org/373391951,
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f64e67e5d3a45a4a04286c47afade4b518acd47b,
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=985da552a98e27096444508ce5d853244019111f)

That's for ksm/uffd though, neither pertinent here.

>
> And we came to the conclusion that MMs whose VMAs have not been
> completely copied and might have XA_ZERO_ENTRY entries left should
> never become visible to anything other than the MM teardown code?

Well if we came to that conclusion, it was wrong! :)

Error paths at play again. I mean I think probably the slab allocation is 'too
small to fail' _in reality_. But somebody will point out some horrendous way
involving a fatal signal or what-not where we could hit this. Maybe.

>
> > > RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
> > > RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
> > > Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 39 10 00 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
> > > RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
> > > RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf80000
> > > RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 0000000000000000
> > > RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b642
> > > R10: 0000000000000003 R11: ffff88801cf80000 R12: 0000000000000080
> > > R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4ca0
> > > FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000020000140 CR3: 0000000040256000 CR4: 0000000000352ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  __anon_vma_prepare+0xd9/0x4a0 mm/rmap.c:199
> > >  anon_vma_prepare include/linux/rmap.h:164 [inline]
> > >  uprobe_write_opcode+0x1a95/0x2d80 kernel/events/uprobes.c:516
> >
> > Here we find the VMA via:
> >
> >         old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
> >
> > Actually one unfortunate thing here is... ugh god.
> >
> > I think there might be a bug in get_user_page_vma_remote()...
> >
> > I will check in more detail but I don't see anything that will prevent the
> > mmap lock from being dropped before we perform the
> > vma_lookup()... FOLL_UNLOCKABLE will be set due to the &local_lock
> > shenanigans in get_user_pages_remote(), and if we get a page after a
> > dropped lock and try to vma_lookup() we could be racing... :/
>
> Hm, aren't we holding an mmap_write_lock() across the whole operation
> in register_for_each_vma()? I don't think FOLL_UNLOCKABLE will be set,
> the call from get_user_pages_remote() to is_valid_gup_args() passes
> the caller's "locked" parameter, not &local_locked.

Yeah I was just about to reply saying this, that code should be cleaned up
a bit to make clear... But yeah it's the bool *locked of the invoker, and
can't be &local_locked.

So yes this rules out get_user_page_vma_remote() as a problem, which is
good, because I wrote that :P

