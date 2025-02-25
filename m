Return-Path: <linux-kernel+bounces-531784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15726A444E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD4A3B7ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF04156960;
	Tue, 25 Feb 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UceB9CZh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RwWjVG2e"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD08156F3A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498407; cv=fail; b=UL6ZsNnRCxZvJANc4TsAb3hV1N/152Ti1DlbeenL13IwqkewI4uyO6V9Z9jymFy4WMRINHhPKrDXLGpM4+C5iKXtyW1yNMi3OWfnxk2FAMipaPIHFS7XxBUklJZZVAUtlYYqTimOd7NPFmzhT67xdWY+DnOHCCfLY9wXzhhHNRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498407; c=relaxed/simple;
	bh=7v/OER7nIGfOBJ6UT5+D+S2eJniUzVozTK2hzdDK3cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K/vi1zZKR4OvmlPvitpFp64E5d+uPjxj4Vm5vR5Stu8/8bvXCqMRAaVKhAPfOHtmWGmr3rczL/P1KpifA3eoUGdOywvbV1+ioRTQzVKglHbgxs/jftA6+YiiYBwTG0YSuWlbJbKpWraGrZHkc/HMi33s0VkZ5bWWhbJpjmzALpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UceB9CZh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RwWjVG2e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMa3G021287;
	Tue, 25 Feb 2025 15:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=CePBJQAXJiUFDCC3/m
	ch6zPcTmJjRHYhD9YeZwLWLms=; b=UceB9CZhopVCqdGlp0nYDHLByLUAXZT8xj
	6VT9IgxI9R5bR+m+cQVxvMypIoP11GMYs2xPNWGdZUXvMFsG4t68l3H7lx0uN+Mj
	OZ8oyS+sGOUlo1KGJHpvZrsL+UDYoos36FqWgu1XNGZVz39VfKWkWkFcyevyTw1Q
	5wFIXDaszWsFHM0vRcI9ZQnLmzthtmz2r+Y0JMep98QNJjH0NPSM6Az4p9ufnJlG
	I+52MU0W8AQqozan/gWqfKA/2FuCAa9jeWnTSh/NTyDmnwZVCnRDALyhA/ZpB91e
	n+ypa7pJm1a5DzWrLmsjnT+99UNFuf/P8NIsCraQiZbPsSU5fM1A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5ganhyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:46:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFJ16U012575;
	Tue, 25 Feb 2025 15:46:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51an9cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueN4QWaPvcd7bj3+tm6T2iQE3HC8zeRk0dXun/rLKcgcdldMNjI9KUopJpAoWn5PeVqSNLq37jG602w1sYAXC8TSPYsB5lycLLSlBQBB3MrixeD9vlu0XVrbrxNJcHF8YAwYRFwdMKbc+lzKHLMtANV9xLsmBQ70z61WZ1J36s7ILdsBTGGiGfpAhX3y6Mis2fZNsFDJBFGCKxOh+qTazsD4OgIRxmiueN5n7XOjAPzIyh+t/7kxYN/+kKZFqE/FolzFZTZraXbhMoPvnTTZFI0W5g1l4pGm1efcv1ZpyDg28Lv2HDNK5qAuyUQ8+yDpNae4IKciJ9YHmnFxRiqPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CePBJQAXJiUFDCC3/mch6zPcTmJjRHYhD9YeZwLWLms=;
 b=ASpermxO+rH0I4K19Da3H0cFxWnYAvYzIW6UbE4wtMijwi0hwllsWzdWw/JXAm11OCkpl4Rhn7KVggYBFzPTDoedpbcn0LPEC74Tkw+ESlM4mOe9kePPRg9wO/XN7tW5vGRRGt4wvDy4Xq28sMANBdfnNNH5T/DqaZ9STO4eDX5CzQiNoBJuH0ekzlTjxWZiHCGeDerAyhzH5Jsi74sxV9oQXBAGViQ8YbDlfF2umck2JH6rI7+6UBilaC94lWEh9NqG0nF5GWStSOyMhVDrt/UrFyt9ZMXAwLiwXrxXv5o26Ta+cyGh2Q365Oqf80pjJfm8WHcu2GAki/70W/zrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CePBJQAXJiUFDCC3/mch6zPcTmJjRHYhD9YeZwLWLms=;
 b=RwWjVG2eyUrgZDh1uL5RuEpU96mn8gkxU2HvAucM6RmEe+LF12qYnIcucMUfQxNPlMQyo6bA8pk3rEGgov/QR65Lz5yoVinusEKk8IwsYdTj1sNkrfrBIvgWGA8ZFvOE98wGhqzOy5KikHqQtLF5dql+m3gIA5cmguo4jZlUlVw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CYYPR10MB7674.namprd10.prod.outlook.com (2603:10b6:930:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 15:46:25 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:46:25 +0000
Date: Tue, 25 Feb 2025 10:46:22 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v2 3/6] maple_tree: use vacant nodes to reduce worst case
 allocations
Message-ID: <sjugioveqmkfqwnse5j6tnnlcz6qk5sfvcqf4isqozu3hn4vc7@2ldyqovzngwo>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
 <20250221163610.578409-4-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163610.578409-4-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::14) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CYYPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: a31cb89c-9d6b-4492-12d1-08dd55b38f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?plVoG29VduRa6q5nudHb0qIUnVanXK7osjs8EFxRMOspJrwmSUuBdoySjpPo?=
 =?us-ascii?Q?Kk2Sor9gMrAEIqBUFfswoucgQfgUJEwo1iPupCL1aLwyohePyBze5TroaG3M?=
 =?us-ascii?Q?3PUuoNsh786NiLn7KKyW2CYPfbOeW2cGTwv5EJ4j81/xObGK2591AARm92Hu?=
 =?us-ascii?Q?VJly7fA9BjrWgHt94U8SxvF82AauvIyRgjWT4ZYdyftNSQ7FkE/qUEf1nxRe?=
 =?us-ascii?Q?ecuzNx9CHs9U356tSaoWQbJr4+S9nRHWIbH4cBd/TREjyneO8GIed87gsMyj?=
 =?us-ascii?Q?Jk+FDhlt3bbvTZS29gxf7LmW6+oLR4BTosh+rS0VbNrjPtDjlWWxtJBPp07H?=
 =?us-ascii?Q?FTifXMWCaYpvJ1IPjrhHBSVo/dx+3ZlgAcRLpIrYARvV4fX3YO4WbFD98Ywv?=
 =?us-ascii?Q?Vf3uq36anPtg/HPe767ylY045BdUoCxjrk4OY6//WUNLp7tQp4hZuRUjV03w?=
 =?us-ascii?Q?ZHOkWii6WbFViS2vQU5KtHLBA2sh4PwrseJAh+VIq5ws6lB0Fl76/1QYzP+4?=
 =?us-ascii?Q?YBcn8AAPHruxXi3Zx8iHgIJwaC207zfZhI0YHgT1Bg8fI7zijaywFRQNVHFN?=
 =?us-ascii?Q?HfM+9h/LTyIqzgtoR8eZxppgrRyqIGr+XJ/+ZNJlJYdbmrnXztebbfQWlChy?=
 =?us-ascii?Q?MRA+prG5z0nqX9hOmNxIX49aznK70sDj6ilJAL9YYrq0chF30UjQk3gGw7Q7?=
 =?us-ascii?Q?3JUziQerQExKxa9IU+yKeM2eNWmfy0LjcjALCzAWI+dZLdqseFe+ZeqlJ9Um?=
 =?us-ascii?Q?qIYcXzvfiBJwkaXKX6xsNFFmMkkr5tTBnPkxsxp18zoJALUdY5J1o7u2oURm?=
 =?us-ascii?Q?DK8e6RZZA0CBEwD74KqoPX/4mHvZbgSRW/HYzvu60M0PKJlWKW/KruwsOQQ2?=
 =?us-ascii?Q?eaOmAPSjNMw6F1O46rDq4eW+oIE31DNGDb1ICYTg6r5ikpCtr8QdCekAkRWa?=
 =?us-ascii?Q?H2min+R3euXwWaIfFCHjX6qk330xufCIzzkBPT188erhUpr20hHHMEcexCDl?=
 =?us-ascii?Q?u2M/0/sPYwokgFODrXWuT1bGKd6jHqrhw8ZE4TZuKVo4EwAlONGGrIXqlcCh?=
 =?us-ascii?Q?KXFEl57c2L2Kq2gSVi9Ha9UKuAf94L/10Jm+J02dLjCPveBxUzANDdwJQ4Wk?=
 =?us-ascii?Q?qfqBEEZ3s0fJTEL972MMxh3f29HhGgLOq2gS0t+wvFp3HMUwz9FiPH6CzFr1?=
 =?us-ascii?Q?pNgzs2CbsWcOYGYYehc+T+RQqK3HE0752Sij68DGffnchjwBayRPSOzkBoZ6?=
 =?us-ascii?Q?F52+mi/AP/FLPVV4oqQl8aPGBVBxT/btWhwt4Y4sgNVs2a+opx9TnEcwK9hp?=
 =?us-ascii?Q?lBHp3muKYJXTAu0LEm8v1TuF2QToBz+0dmfWYaQr82omsXgjVvIlYWbBQuR8?=
 =?us-ascii?Q?TtAXI9bnUcMdEckvnqhieSvYsK6P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?etMcxPG6zoOJNnck+NN+hTFU7yOFsfa5L7iu5TYw1X/xd0+l0mGHLG1v91Hl?=
 =?us-ascii?Q?CLHSUixwcV2b/y0/nmfmC00cMhFcbAVSS5cFo3/FLnWiN5fFqcvA+jYb5BFd?=
 =?us-ascii?Q?Te83wZWjxyrIs23d0ZmbTYeOiEN/6JntV9nboHIN1zvrItg9yvzpt1GAKwtL?=
 =?us-ascii?Q?jZmmk61cARdPg4NDxVdVd8dByL15WOctkBMn+BU4N5J9TRBIQC/svw6Dh2WG?=
 =?us-ascii?Q?ErAxrJSTF3pCsTVKfG7mzHLUrDP1IMARUcmA99GnghuupJw1PdtxwseqX1DD?=
 =?us-ascii?Q?itjIjxfFu4tJYV9ENmjUEzMPIFuSkpcHpJ51ILuJqIUlUeaCn3U6jXyHsgmB?=
 =?us-ascii?Q?tPstvhZ/bePbGqGA0DGTfqv5QHQA9EgqmXjbqbo5qZq1tl4pBGwDV/o0Y3mY?=
 =?us-ascii?Q?hQMbkmPNDi0bPG4HuLs0Hxy8NlPBPN87N3Ov1lL96AVYepexH1xx37+6RQz9?=
 =?us-ascii?Q?q/T9Ig16ZRfJZ2QOR+AqkAef6OhmUU9lHWnQLLoIhdJMLbu8GMe0g0bvb1J8?=
 =?us-ascii?Q?rI5jE9uZo+/92IubmNMstdiYCNvP5Xsmadnuczkcu5Imgzym5t8Wf9bafM+X?=
 =?us-ascii?Q?fUaeK1O/rBV3CWgAO24R5nOj4jzxNGWIUIbDwoBXCvJ/+lxfRJfE+g3fIrg2?=
 =?us-ascii?Q?CdWCbOyvFTHaBV0yQ0HhYciRrIrmBzdIURhTeDUlQ/OZRK16wSHfErAYNRsx?=
 =?us-ascii?Q?ednxYyVlppJoehXAQiz3qK+XEqmgPGEE4xcH3A04EQg1uk+iiFlvP2yeWp1D?=
 =?us-ascii?Q?YLTCqH9SOuhg7MH58KtE2Tw7dPC6iJFuH8q/R9LTXnjQYBEFcC4rP4d18rHQ?=
 =?us-ascii?Q?xzD3qHs8QeIg9xkUYg7BRUt2YJVVtPSNnYeORlrewT6XI8hiY8RiQCcqIL5w?=
 =?us-ascii?Q?Xc56IBLYGUt0kGl/kEoRUNrH8Q71sq+c55r54CHTvoQIkeFSO9WYdXU7rrmV?=
 =?us-ascii?Q?nxXN1nVNQZc7VKfiW4hG2XrYzRTx50VvQNSQpoDEEl3x1ixJ26cxq384ja3x?=
 =?us-ascii?Q?Bc2EOMHxLYO1jFpEJgrff4q5VCc7XdJf20q7lvqSeGStLyG5sJRWHF+YkqZD?=
 =?us-ascii?Q?I2tYxeOS9hi9DJL8SZ5AarmWrrHGohDINqcowwC92nXAfhNc7ZaGQSFsEYho?=
 =?us-ascii?Q?p7SlpGKZdlCAJcFDlJUdjxs6HhE+uMDUkfFZVgqokTIjCYvaSo++dfRpR5RK?=
 =?us-ascii?Q?1ZB1TBUaZVJlyPC5v4s7Qj26RJFGgulVSH+vPagETMTA5vUO/bWFZ4ejU4C2?=
 =?us-ascii?Q?5tJp0kF1GndBpogkyEKOCvBYZZLm+p3jkBLPCv0w+m9ue4j/AIcp9U/YpJG9?=
 =?us-ascii?Q?a6JL211V5bV7mDY2ZVZ+a0uzcSLpGKnwNQODJ9FV2hpnHweZ5qIvcfvt2ws4?=
 =?us-ascii?Q?VjB9jm1FmZm5aGNPtiiqPAVGpdymML3GijK29UjW4Jw5PQZ7SylEZ21FRSwp?=
 =?us-ascii?Q?qNXY0O1wUOyFzq3nY0/ElU3xLvtR4QuNkI3vFpzqWNr4Nkg08oyNDVYwW2xl?=
 =?us-ascii?Q?fCd3NEtRQuCTx9OH9md0ioMGTim1Ylz3YjIHyVjNvh9aVGXQUYaR7rHVm/Zv?=
 =?us-ascii?Q?zei+BGP1bBVwegxuMypJtSEIIjIExWS8YTRbLA0Bd1zmz9CCo75ltEBpRrCO?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G87ILiaxzsPVXi/InltcwY4gA9Y0iIhQQ32t5tLfzuDIumnp78jwgECm3Oj0UMcL3nmbMmXxEYRhK2DFj00uo6IEUgCs0gAmjo0wbcW3x/TCIIJd/KMhR769o0DZQXoQvWLq1Eq577hfJAYTwQpNVwIpmn6HOwiNe2wYcNo1+C69H92jtQJZ58x/N0ArYiF5H2A6yLEYl7LlNhg8qenVlzPLoo0MKjaWyVLN1Le0bSfS8LmUBOxFpK2FSeJQ+tfkPfO7cJ8RnN7prsw0fAACfOFTIAFTPQmZqruIBy4tbMhYZYy3VnhHhnlDZyUhI3rSToVFoJCC7cWdG/JRNVYEF4h+ePlVxY4/S6uRhIXhZpczpIHUsCvY+unVd0vEiGMikUzjO3fUTlCGM+JpJ3GmRH4Q7CsdKMgz7kRidkuOepeY4aNvdX8aOwWcf7Bx06zJr12+SX1fqz8/40jgkGhKKYa13M1GEwFvzt2AOQzDXs7ve2AUz2xnBi2rfac/lWS5Z4xDc3Sofy9KloEcCuOj1ihqQyfagfL4C6Sh1MS9FjSmn003UDlITyWRmhiEc4cvHAwlEsO8L1zHSxOnXwmtuSQmruVd7wkPEBmOCnJh3zM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31cb89c-9d6b-4492-12d1-08dd55b38f6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:46:25.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47LDRPi91t+ePmDS81cPz6dUPIxQnD6hYbHYWFxcE9i+San0rhejW+AVq0UFcazkj3SjidHj8SbqeTw1LKaSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250103
X-Proofpoint-ORIG-GUID: FFOMnFaHTvuCJlT2ywCgie29S2vvkEgw
X-Proofpoint-GUID: FFOMnFaHTvuCJlT2ywCgie29S2vvkEgw

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
> In order to determine the store type for a maple tree operation, a walk
> of the tree is done through mas_wr_walk(). This function descends the
> tree until a spanning write is detected or we reach a leaf node. While
> descending, keep track of the height at which we encounter a node with
> available space. This is done by checking if mas->end is less than the
> number of slots a given node type can fit.
> 
> Now that the height of the vacant node is tracked, we can use the
> difference between the height of the tree and the height of the vacant
> node to know how many levels we will have to propagate creating new
> nodes. Update mas_prealloc_calc() to consider the vacant height and
> reduce the number of worst-case allocations.
> 
> Rebalancing and spanning stores are not supported and fall back to using
> the full height of the tree for allocations.
> 
> Update preallocation testing assertions to take into account vacant
> height.
> 
> Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
> ---
>  include/linux/maple_tree.h       |   2 +
>  lib/maple_tree.c                 |  13 ++--
>  tools/testing/radix-tree/maple.c | 102 ++++++++++++++++++++++++++++---
>  3 files changed, 105 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index cbbcd18d4186..7d777aa2d9ed 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -463,6 +463,7 @@ struct ma_wr_state {
>  	void __rcu **slots;		/* mas->node->slots pointer */
>  	void *entry;			/* The entry to write */
>  	void *content;			/* The existing entry that is being overwritten */
> +	unsigned char vacant_height;	/* Height of lowest node with free space */
>  };
>  
>  #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
> @@ -498,6 +499,7 @@ struct ma_wr_state {
>  		.mas = ma_state,					\
>  		.content = NULL,					\
>  		.entry = wr_entry,					\
> +		.vacant_height = 0					\
>  	}
>  
>  #define MA_TOPIARY(name, tree)						\
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index d7dac3119748..ef71af0529f4 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3542,6 +3542,9 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>  		if (ma_is_leaf(wr_mas->type))
>  			return true;
>  
> +		if (mas->end < mt_slots[wr_mas->type] - 1)
> +			wr_mas->vacant_height = mas->depth + 1;
> +
>  		mas_wr_walk_traverse(wr_mas);
>  	}
>  
> @@ -4157,7 +4160,9 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
>  static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>  {
>  	struct ma_state *mas = wr_mas->mas;
> -	int ret = mas_mt_height(mas) * 3 + 1;
> +	unsigned char height = mas_mt_height(mas);
> +	int ret = height * 3 + 1;
> +	unsigned char delta = height - wr_mas->vacant_height;
>  
>  	switch (mas->store_type) {
>  	case wr_invalid:
> @@ -4175,13 +4180,13 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>  			ret = 0;
>  		break;
>  	case wr_spanning_store:
> -		ret =  mas_mt_height(mas) * 3 + 1;
> +		ret = height * 3 + 1;

ret is already height * 3 + 1, you could add a WARN_ON_ONCE or such to
ensure that's the case here and it's not missed in updates to the code.

>  		break;
>  	case wr_split_store:
> -		ret =  mas_mt_height(mas) * 2 + 1;
> +		ret = delta * 2 + 1;
>  		break;
>  	case wr_rebalance:
> -		ret =  mas_mt_height(mas) * 2 - 1;
> +		ret = height * 2 + 1;
>  		break;
>  	case wr_node_store:
>  		ret = mt_in_rcu(mas->tree) ? 1 : 0;
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index bc30050227fd..d22c1008dffe 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -35475,12 +35475,85 @@ static void check_dfs_preorder(struct maple_tree *mt)
>  }
>  /* End of depth first search tests */
>  
> +/* same implementation as mas_is_span_wr() in lib/maple_tree.c */

Is this needed then?  At the start of this file we have:
#include "../../../lib/maple_tree.c" so I would think you could use the
one already defined?

> +static bool is_span_wr(struct ma_state *mas, unsigned long r_max,
> +				enum maple_type type, void *entry)
> +{
> +	unsigned long max = r_max;
> +	unsigned long last = mas->last;
> +
> +	/* Contained in this pivot, fast path */
> +	if (last < max)
> +		return false;
> +
> +	if (ma_is_leaf(type)) {
> +		max = mas->max;
> +		if (last < max)
> +			return false;
> +	}
> +
> +	if (last == max) {
> +		/*
> +		 * The last entry of leaf node cannot be NULL unless it is the
> +		 * rightmost node (writing ULONG_MAX), otherwise it spans slots.
> +		 */
> +		if (entry || last == ULONG_MAX)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* get height of the lowest non-leaf node with free space */
> +static unsigned char get_vacant_height(struct ma_state *mas, void *entry)
> +{
> +	char vacant_height = 0;
> +	enum maple_type type;
> +	unsigned long *pivots;
> +	unsigned long min = 0;
> +	unsigned long max = ULONG_MAX;
> +
> +	/* start traversal */
> +	mas_reset(mas);
> +	mas_start(mas);
> +	if (!xa_is_node(mas_root(mas)))
> +		return 0;
> +
> +	type = mte_node_type(mas->node);
> +	while (!ma_is_leaf(type)) {
> +		mas_node_walk(mas, mte_to_node(mas->node), type, &min, &max);
> +		mas->end = mas_data_end(mas);
> +		pivots = ma_pivots(mte_to_node(mas->node), type);
> +
> +		if (pivots) {
> +			if (mas->offset)
> +				min = pivots[mas->offset - 1];
> +			if (mas->offset < mas->end)
> +				max = pivots[mas->offset];
> +		}
> +
> +		/* detect spanning write */
> +		if (is_span_wr(mas, max, type, entry))
> +			break;
> +
> +		if (mas->end < mt_slot_count(mas->node) - 1)
> +			vacant_height = mas->depth + 1;
> +
> +		mas_descend(mas);
> +		type = mte_node_type(mas->node);
> +		mas->depth++;
> +	}
> +
> +	return vacant_height;
> +}
> +
>  /* Preallocation testing */
>  static noinline void __init check_prealloc(struct maple_tree *mt)
>  {
>  	unsigned long i, max = 100;
>  	unsigned long allocated;
>  	unsigned char height;
> +	unsigned char vacant_height;
>  	struct maple_node *mn;
>  	void *ptr = check_prealloc;
>  	MA_STATE(mas, mt, 10, 20);
> @@ -35494,8 +35567,9 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
> +	vacant_height = get_vacant_height(&mas, ptr);
>  	MT_BUG_ON(mt, allocated == 0);
> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>  	mas_destroy(&mas);
>  	allocated = mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated != 0);
> @@ -35503,8 +35577,9 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
> +	vacant_height = get_vacant_height(&mas, ptr);
>  	MT_BUG_ON(mt, allocated == 0);
> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>  	mas_destroy(&mas);
>  	allocated = mas_allocated(&mas);
> @@ -35514,7 +35589,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> +	vacant_height = get_vacant_height(&mas, ptr);
> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>  	mn = mas_pop_node(&mas);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
>  	mn->parent = ma_parent_ptr(mn);
> @@ -35527,7 +35603,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> +	vacant_height = get_vacant_height(&mas, ptr);
> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>  	mn = mas_pop_node(&mas);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> @@ -35540,7 +35617,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> +	vacant_height = get_vacant_height(&mas, ptr);
> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>  	mn = mas_pop_node(&mas);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
>  	mas_push_node(&mas, mn);
> @@ -35553,7 +35631,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> +	vacant_height = get_vacant_height(&mas, ptr);
> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>  
> @@ -35578,7 +35657,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
> -	MT_BUG_ON(mt, allocated != 1 + height * 2);
> +	vacant_height = get_vacant_height(&mas, ptr);
> +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 2);
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>  	mt_set_non_kernel(1);
> @@ -35595,8 +35675,14 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
> +	vacant_height = get_vacant_height(&mas, ptr);
>  	MT_BUG_ON(mt, allocated == 0);
> -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> +	/*
> +	 * vacant height cannot be used to compute the number of nodes needed
> +	 * as the root contains two entries which means it is on the verge of
> +	 * insufficiency. The worst case full height of the tree is needed.
> +	 */
> +	MT_BUG_ON(mt, allocated != height * 3 + 1);
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>  	mas_set_range(&mas, 0, 200);
> -- 
> 2.43.0
> 

