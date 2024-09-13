Return-Path: <linux-kernel+bounces-328374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8E6978294
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0ED1C22009
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD2F101C5;
	Fri, 13 Sep 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CSEl2KeY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DkLGET88"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68794C153
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237935; cv=fail; b=SMBRUsWMyekA8Qgq9SOvNHbqbTgmIVdiOo6nAQCMjKKkU7xsWAGKNpz9hgQJFZ1dFWPhBppFN8IWNKwBLVoEet405D1zXjysC2sAC/0wYcx8wEKlZOTZnQxelR7wBb9euBU9qfp1ZYJ0fygf+FQ/+GybhjTOLPUJFwaMfdZn2oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237935; c=relaxed/simple;
	bh=TURR3l3lRBJlIpsamNLGg0MJiV+bIhSFFUJaRzdsD0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L96mmsOHSQjMuoSo+YqDLxaarky7z7qM4dflwVQvC6donUmvQOHuLCBZ8p28tAMn13Gg2l2mzGNYgAd5dJWtIiWqIegUuxbOff8KjwG24YyyKMZFIlYFsas+ktifv29mxd8dw0/qqhs0BOEzD8vlsNAbQksYrJdQAygy4x2po6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CSEl2KeY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DkLGET88; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YL57008400;
	Fri, 13 Sep 2024 14:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=CMqC50zzsJn4ORZ
	C5WJ8l0J88pXrrZephNxkCWOQZms=; b=CSEl2KeYDodF89Y97Kj1/LWZh4OfrWn
	TZPILq9kNTeQyeV7jk39rjmBTPdXJ4bZItDv3kyl1v6w0PQhwXUzs4XxAiu6wON7
	HRXNelT5DCvQcd5KUTP2nd8KMlhd+5rmhNfC2l2l86oeXmQMd94qKdbfExsF7omZ
	sA07t6BF4AYA7b1DmTcy2L5tt3Bl9EtItYlrFbGDFEaa1615kfwpT/5XbHSPLtSS
	RdwMkLKh3k8/k3xsQqj7mTXq3PP73C1yQa6Ae+H+l0n5a/yxrL3PWhxv9LyVvUbu
	rtFlI0x7agysbeIpTcgD0AzYpRBde9eXEReErNhSDYxolyI4sqQWggg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrbdser-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 14:32:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DDuEPT019845;
	Fri, 13 Sep 2024 14:31:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9k90gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 14:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ics7M4YMI6/PMmgM2MPUNQnSzBSXl7t+e4W37jqBkqLFXqwPhXfzfKqfBmk6Zrql09oBwHKbbnwrPE0wqL9GZE2mqdWkninp9niUE/pYr3EMk3YMRApv1FXNSIW3vsJYgjjXy5n6AF09jLRLcWapR2+1+uQ0jng3HtlFP8EQ1Y+HiMrwRSVlwqcWrybhfnZfkuWFuevesIflinXZYXUwPaq00WWXEbY92rWHaMzDmC429EJbn6nF8oyAUPrX8RzTiadUT9N6JQAUwtpMjv9cZoXX5GWjyZ6MaWZhIv1mDlp8bGgF7M+3an8PYe0jOAYkfqpzF1CnNaTq/OcLKhw/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMqC50zzsJn4ORZC5WJ8l0J88pXrrZephNxkCWOQZms=;
 b=CnELoiQLn9pTnrY8JNoFEBUbJJ96ZwFuH3Mxokq10CfLYgiNyOeKfwpPIPyx8VaVfJdI+ohQJBu1EGSC3XBUBZqPrMVM87zruE0eEdrNhXW5c3r2Za3LIgpfmLbqfeeW79uRA7EgEhQIe+IF7Qn/pk0+DxGS5QUbZgWHgTqECNMAOdLMdECA9p8d7/i6KZGQYyBcw645D7FFrk3p04EadsRDGruuO+VcpW+U4hCxOxaB3H9k+tXL2Gvk2bO2pRUnOeKWXYSBokJnwzX5p4dI5ec2m6DGYEuJle2xiSt8Te7ja0BMqIO/4lUH5up3MOoHXts2duWnMAdTzXMq+/YMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMqC50zzsJn4ORZC5WJ8l0J88pXrrZephNxkCWOQZms=;
 b=DkLGET88TLQdZXYViJhkrHQ/ph4QBVpNVUhpm7ZLC4QpBV5IwWRRUgQzokjA2FJzoTHY3RLoOpfcOpv0dzbzIm/F1kA8vMynv7VdbkShpkXk+92eIHRBM7O7b1OQA/5Z8pRmcdn4nJJE9yrbfUjz/n1dHlQ9XwodWbLKhCdUHCQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB4934.namprd10.prod.outlook.com (2603:10b6:408:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.10; Fri, 13 Sep
 2024 14:31:55 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.024; Fri, 13 Sep 2024
 14:31:55 +0000
Date: Fri, 13 Sep 2024 10:31:53 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/madvise: process_madvise() drop capability check if
 same mm
Message-ID: <k4euomzfssryq7r3tglsvk372d4vj3nd52ge6hjmgoozvjubww@jvqup75daqsv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Shakeel Butt <shakeelb@google.com>, Suren Baghdasaryan <surenb@google.com>
References: <20240913140628.77047-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913140628.77047-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cebe39d-a377-4688-825a-08dcd400d103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WSsdLWvBJWl++hD4rzrS+e7+t9DGl11ZSwzHf0aVuhyHPrk5klLlarU3oQKZ?=
 =?us-ascii?Q?9u6cQuBOfah5al3zBKfanoOfPMEc9KJnWq6W2EeDCadNFgRkcee39I0f1Gm+?=
 =?us-ascii?Q?VebrN0XrwVLOIfYjSZr1IEeIpEaSkIoAePW73xfEWXkllf3D3KyPIqq2YJJr?=
 =?us-ascii?Q?ixjNhH2z0MtLIJZQ7aFicl5KAsS9rJqJZDmbOqIuJ6YrbU9euTEOVdi3Rv4H?=
 =?us-ascii?Q?fxNE31eMQWxraruHVCeFkKR1Kb3dIVGaCifCCASW6ic+wQCmjI1DDB+2vab8?=
 =?us-ascii?Q?dneGKZ19OGtIHH8XkwK8V3mJ0Q4FtFpB7o8UgrKP05dlK9LYfDpq3glQZSEh?=
 =?us-ascii?Q?LzmlAPWdmzC4i/jtOJF2AgOtpQihAdF1rspYH9RSt6wU/Gkjz1l4TaG4rPdJ?=
 =?us-ascii?Q?VEZipNi3khbmitXzqIMIUCTvOinZ9jsPqwZTf39KdmSRz7BuBUKsXGRuxD1L?=
 =?us-ascii?Q?IUwpCPeJjFG36S23mcZ1x7gYU/14vrTz3YWerHZJvG8+ewtTS5Ua5Y9mwlNU?=
 =?us-ascii?Q?XFYLfvG1i1kYTlQTJE5WLi+csmMeGvSGMMrxQKoIozfx2AAbflwsqmYFcGGs?=
 =?us-ascii?Q?BSFzC/p2PycOfZF1oPwwCfQBZtbQzQjWQlOqH44+ZWnXE3MqzZBtHl3aCp25?=
 =?us-ascii?Q?SaUmQ36Q13P5PrIsXKb/MdzvGwZnb16Ql5Dz1muj1E0PsX4PNXfqmODfQOPB?=
 =?us-ascii?Q?vT3JjZVBBz59USIO0IygLcT7NM3xCbYyCJOP99un6ifivwfiCS/iAXc4/j9+?=
 =?us-ascii?Q?9Ns33E7uQXdpTBmmceMJI6RpkI3h3Apda9Br+fUPoWSbwWuntBnhvf0w4Rcc?=
 =?us-ascii?Q?6oMvIZ4CedjW1GXmRt3rFL9T3ZfkN3msH7dNviILNNP+V98W9cX9cdoAcheV?=
 =?us-ascii?Q?zRfl875e47nOeXT2WeT9kvaRNAc4XB+/n+x/mKw0PwPmKW35DwLUXlKVppTo?=
 =?us-ascii?Q?Fkl5OlM4LEf/EDFd2irasFsGqS130ipggFGSt560Rk5HjrZ+7Px2AQOvx5Bg?=
 =?us-ascii?Q?GWsm4y0A4GuHiA+SUiibHBDPJcP4wYz0R/RXM/4K2j+prV1sHyCU9zZ/1BO7?=
 =?us-ascii?Q?8oI64GciNwauDHApJ6/rK9ljlgpuVHHeGJUv5/BrUdPlBe+4PWotfc1c1erd?=
 =?us-ascii?Q?GO2Kb2OTzJu2gUFzrjgtH+5YY3O3Uu8pgozI4AYg6hHbM3CeWsG/nplCYZf/?=
 =?us-ascii?Q?rmZwjGaVOuXuu92KoErTIqEHQBklWxBBfq2oBxdmIqhnGOT/JyVoItASbmeQ?=
 =?us-ascii?Q?0DnmxsJ9+U98RtaWbZlVGG9A574Nia//Se0Qu85Ppj8PqHH3sgJ/uPxu203M?=
 =?us-ascii?Q?NYeq58LdT7OgDhofC5pdsI7V1uWi+1g/T5UNcmr++UeF6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q+fqaPl5Bl1jEdJZQQV2zH/Z6SlQkAwamq631qggj31SgkLuAGsYpEBw1Z+e?=
 =?us-ascii?Q?N8LMUbbPA4qZ6aD3FMv5tVNwWCEPU0Iy+fZ6M0NNk6q93iFgK9HsoTFKOmhy?=
 =?us-ascii?Q?B9Z1Xfhj+l/+L9tNAqKAog6lZm256+F4M81x/YtMWJh7ZhV4ERw+AdE6Tyg3?=
 =?us-ascii?Q?NgKvAHlgWTJX5+/GIxew2mLKmE8IRl8+/TsRYO8DYdTNZy6a/PHxnH2/hDRJ?=
 =?us-ascii?Q?WvgkpwYyP0RwzKauShEzGRtU7rpua8wN8vasLw7ZY6kEm5d4svphoOK6bWL+?=
 =?us-ascii?Q?nbT0Gd+aOo/Iis8qWYqknry0BPFTdis+S24vhxCgwrNh2hz8DooPmW7jRsyT?=
 =?us-ascii?Q?bJhkG33l7+j5UbnRCfZTicHCXDwfPK0HLzbX2zapEJYgTQ54ONFaBI1PF0q/?=
 =?us-ascii?Q?m12VrASefEbYnXYmASnU9rcyeOhrB2q4S6/qmgst6cJn4EGXZp5szTpp4zE9?=
 =?us-ascii?Q?3ak918LdhmKbiNYhL1y0OyCkQ7yNTUFrwxu/t4MV9vg1A2tWg5Pu+QEMjkMA?=
 =?us-ascii?Q?L6OlkcOLYzjZ50vxjMpIGEQeDEaT7mZ/qI6/u9T1nq2fF5plHEz1pw++Cefg?=
 =?us-ascii?Q?S+3TEaQLYDG5Bra4E0KCLdf0+uACvl21qYWK8nBBEZ10N+L/NLPjW7doJIUo?=
 =?us-ascii?Q?oIeNQLaOLjKdKJA9gLrBz4cgF6pn2TyyS3BkXSAP5Kt61veoHsyqYW9bGwqP?=
 =?us-ascii?Q?7WfYtVujmGpBYk9nBsqBzbdyaTwfh2dOqT5S7foeuuo0MNWkQBBbmo66EACP?=
 =?us-ascii?Q?GGYIsqybXvIVDUFRkWCly6BXpOWI1PMaWKzWmrK7IACQ+zZr7/BdLowrTsaA?=
 =?us-ascii?Q?yFFU3Wl15h352MyWmkGLS/+0fXHX8RAD98B6kRw6e1L49PvAcD3aNABE7pzG?=
 =?us-ascii?Q?MfFNS0NhD2A3sWk5hmHW2nlsqBGnbKtYNI/oUHEdxxs97WREMddoDbzunvt7?=
 =?us-ascii?Q?qF6/IAFo/dD1W0X8ajwV95fTVBS/JuchbScwxK8i/Zgvx+q6pYfYTaOt7CLs?=
 =?us-ascii?Q?gjdUcuT6u9OjgJIoi2oNNYVDNFfo5XTFNAu2gZzr3v16+jRQvj0EQ5OiJWCj?=
 =?us-ascii?Q?FAtzLnUL+hLSpbBNEBsWbMWADwie2P6KbKloyKCzEnAmHnlWwuD7YZj6Qz6Y?=
 =?us-ascii?Q?8wSq+6slDgG/O5Q23zMUtryPz/n6u2s0BjIspCZr3HMrnhPSiO5mu3g5kjfJ?=
 =?us-ascii?Q?TRPiSRmsK4R38NYKK1f36Lqi4mhZ8CPBLh/EpVBOfZ2x3Dk8oS7hDcmsRdx9?=
 =?us-ascii?Q?koV9/omq+/g/HWfIP6ZTcZbQ5nSnyd9kYcuPjl0yLRnsVf9K3CA1d/EBX0U0?=
 =?us-ascii?Q?nVBhQzCf/s65BFxVpeiluj/woWUKEVm7a+nqzUDRxkzLoLq0trtcxsnLPo88?=
 =?us-ascii?Q?iRkiF+96gxYEeDZGmXE2iBqOfaHdcZQZ16kRX6srJIMyxP2qFszXaXJRJNC8?=
 =?us-ascii?Q?iZ4+jR5FFeRuOt/N+tKjEcbq5TYxuMtmFgUbS3iLc57++jtgvXzVMldH1I4Y?=
 =?us-ascii?Q?hqOF8bUBneV7q2amie2axt1n903hx3/repDQJ1isOHa+MUIARveSaepid/aN?=
 =?us-ascii?Q?QnE5Wx5jQKUOD7h6Ai/eofw/5+NuF7iDHiDLpuBi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i+66BLJcxCzlCT3Wgvad+rHwNpjKiVVvAGW3nY+uspJxd4otygH4KfynSjGTm0/NPe3eNur2jJgheH+DGW42cV+pf/HsTk0F721848UiXljrT6wNBE/UNdSCa3H7UYuDiB+J4tmFdBql8xwLl3hXWmrE1SFYJfSZ1pjuLwSKm/QHttSKYo3w1qclEmloTzJ0jdbrLe9fSeET3Yfe4fm401Kt7dm7WgiEcwciE5fkQd5Zg6Yc0LVk2705suAL+68RNvCfRHRouTjDIBSxWMhnKY8mBEZaAHGmJBtOCPR7rlLioSEDwZgyBenINNiEoC1yY5IywngJPTZGwu3bITTroiUp8KE4TV+hoAtf7YqWyDMGmvDTPtmphLQcslkYGS+FcP4o0lMYTciTUSN91FMo03ByfylrjJ+r4LaPPWiOICdUc5l2gosAD4cMOKqTDIozeAWUg6EC+sRHJBgOwNaiNuGNm6S/CITcj8Sr4ZQD6jDdJ6HULf7qZCqrq4dMNXYVRCU1RutV9tUXLG+EVDrn6riE4oX8Aavt5yObaVYHOC7THX10oMiDlk13b2rI7gHwPaEuxi5n7L/auzA2MhvFWZeM+1efkeQ7k46k3aKWzYQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cebe39d-a377-4688-825a-08dcd400d103
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 14:31:55.2652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4UxhjjSfryirkfzJPIW+JAPOD7U/8Q5+ptO/wNHV42tigmNTh5DheJrRnKOIjEuCDoM51wuHDcmSp+J5kxHDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4934
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130101
X-Proofpoint-ORIG-GUID: Vrn4BhQt2KOdEfvX4XfYL6xzjh54mFQm
X-Proofpoint-GUID: Vrn4BhQt2KOdEfvX4XfYL6xzjh54mFQm

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240913 10:06]:
> In commit 96cfe2c0fd23 ("mm/madvise: replace ptrace attach requirement for
> process_madvise") process_madvise() was updated to require the caller to
> possess the CAP_SYS_NICE capability to perform the operation, in addition
> to a check against PTRACE_MODE_READ performed by mm_access().
> 
> The mm_access() function explicitly checks to see if the address space of
> the process being referenced is the current one, in which case no check is
> performed.
> 
> We, however, do not do this when checking the CAP_SYS_NICE capability. This
> means that we insist on the caller possessing this capability in order to
> perform madvise() operations on its own address space, which seems
> nonsensical.
> 
> Simply add a check to allow for an invocation of this function with pidfd
> set to the current process without elevation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Probably needs a fixes 96cfe2c0fd23 tag?

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/madvise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 4e64770be16c..ff139e57cca2 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1520,7 +1520,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  	 * Require CAP_SYS_NICE for influencing process performance. Note that
>  	 * only non-destructive hints are currently supported.
>  	 */
> -	if (!capable(CAP_SYS_NICE)) {
> +	if (mm != current->mm && !capable(CAP_SYS_NICE)) {
>  		ret = -EPERM;
>  		goto release_mm;
>  	}
> -- 
> 2.46.0
> 

