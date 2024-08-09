Return-Path: <linux-kernel+bounces-281236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ECE94D4B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6A1B239BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623C1990C9;
	Fri,  9 Aug 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KKuQJAWc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NX6O8F+5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D61990A3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220850; cv=fail; b=DHzQHGRbh2cHDXBjV7a0KY9XrboFzUkoiu0WsQJhufF1rmVUaxQ0yCsrP5l1AIfKEoclUJjaeUrjxZpUWo5cQRWkoaH6ji9JKjEEpHllFqL6JNXh0wCuM/Cp4BeWhe1rBL70ea1FkPoxRr8b83NgmUuZ4MGRbQ8ZH0sGUfS0G5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220850; c=relaxed/simple;
	bh=7C09a5/OxBT56lSWMHCvGz4L3oiGdFMuQgIT/Yz/voU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K4A2KZG34LUU5yuwhny58682LTnLYSc3FipKV7mkdJcsodscRk7R7iq/N3hkko9E4ygwleBqRVANEA3HtP5wbEriFelmwDW03uLbQ2G+HPagidZVL9xbLD1pRzQaImmqks0hCpwipfNtRW9/kiq4IQh8rYHOBwOb7z4vIWpqtlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KKuQJAWc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NX6O8F+5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479FMTnm011350;
	Fri, 9 Aug 2024 16:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=2JofhuuP6tUXar3
	wBnTInLVdYltKioys5hVTNINTCNg=; b=KKuQJAWc2GjSmz/RaqR0h+tDvi5NRiJ
	gcwG1THFrftc5TFHN++eUsdK8GIVBVTJbnfwxMYm3OEOUAOKNTXjRo72EXQs0NT/
	V59wiY/YMBgPkULLhHQ7ePpgeIbHcIIgLBKacibwEbuC73C52irB7ZOFTLDwbbHR
	dUorKVeJI1qVq5zBtCA8GM5x9ahKOQrWL6+1eOQVius24YzO/Ba8Y/fBSum/SvP2
	3EyD912AWfgLwUfDxCGL7poQTwqIJc8xthfKq6UJtjvzf7q1ktoxc+JZjGAvV4I8
	RLty/mU4JkFdSbne5hYrLjgiVitFw0Bk2l/eX13Bbw39K0LW1/G7MYg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sd3uvcjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 16:27:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479FB4Ye023782;
	Fri, 9 Aug 2024 16:27:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0juva2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 16:27:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lv4+B4zu2FE+cgyNeyJSVsZQTawNZ/VnQDSgQHF/pB9rU/13P/BJZtnujHNdvycUJmmwgtp2sKUmk9KHxy0I0Y3fK9fIJeNF3Mr5TjUz9R6398ppueeY+OIe1ZX8L+js5GQKv8F7tzTXcoZkMjWurAjbue1R44DPSQxGJ7lrvMCBQk4kN53jmvaF/wGhHTRCr5ps9mgGJA5L/Q/f/MDvHuxzvnciIDjbWHg11Se6q/5v/NtoqVMXTvj5F2rI9Vc/frsypI9CUfAL5PlPwAmkP25QlQdwLt4eO2lagLMb+4lKa2Wsa45xeDLmgdAL6q/vpyDAV87LOGIzV5ARl15Bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JofhuuP6tUXar3wBnTInLVdYltKioys5hVTNINTCNg=;
 b=dgtLqnXpvO6ZP+gV5I5rmFJo/L+LGEHtp8FmmzZr8Jn0sHQZAjCY7Nhlncu5/iezq10hb2OoOxGFCyhn9ycQF8KGTTwp2f2GW17aXh8PwPUO8PUXX5Ds3DIIdgVvGWV55hLSH2Wegcp89sQ5fQUH1cnIFmsBHunyml9eWwh5HkyMTaG+unMpYSpta+FJv2l2tkPAFv+vObZQKpt64gb+Wj+v5eqUZT9BgFQOXqNxlbOAmnJatk/hsqlycCAx2rVXORUixVgwIracR73oBeOF61SfnkNcCFDN95mGijDaDcbeq1Qm8cP3gP27ulcxV2z7+v3/xnRhSOlnTh2wPRbebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JofhuuP6tUXar3wBnTInLVdYltKioys5hVTNINTCNg=;
 b=NX6O8F+5IymmqpaZ00KjQCYHcHbnPszWRnpwmCyYrPhL3T4Qh87ERMgllv0KYm3KRbApWEFSUtKlSlkPdk1UfGbYSentXy7JaLQYIFFtL7krIqfHmUwiuIgilpjTRJfxVnzR/GALTJCyC6B0LFiJ3pPU/DyyPnLkwOfbpKS/EBE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB6270.namprd10.prod.outlook.com (2603:10b6:8:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 16:27:07 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 16:27:06 +0000
Date: Fri, 9 Aug 2024 12:27:03 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, jeffxu@google.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 5/6] mseal: Replace can_modify_mm_madv with a vma
 variant
Message-ID: <skp4dvg6h4otefmknyrg3jabqpwh4ixdi6zq645ij4wc3phmep@nzi6piu4gkk7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, torvalds@linux-foundation.org, 
	jeffxu@google.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-6-pedro.falcato@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807211309.2729719-6-pedro.falcato@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::33) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 042745ad-1c7d-4db3-6ca8-08dcb8901ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EYNKNcKQsTexarYU093agyZArwueK80kKlsy7v/hYTkWz90vcPEhum2H243J?=
 =?us-ascii?Q?6NQunv/Dy8D/2DwkWnM/lOLLL3r8x6fT6V3qXe77OtRQRcyAOliIWOX1H/Zp?=
 =?us-ascii?Q?YfdKqfsVvMk4O8P7E/u1s3D1xW8xjbmfEL3tUPc91c6V3ogOnznx9AJd4bXi?=
 =?us-ascii?Q?biig3slZLX5fDKNo780eO8P1sfI2wFAkTU8yMjLYVNjEVT1Zo31URNgi98M0?=
 =?us-ascii?Q?ii1KgmAGRndqJOdy40SDj88/SKXspxjc+kkEr2e3o5sd8tdIcNvyfoWSFh6k?=
 =?us-ascii?Q?a5OMIpMzK+KhVT/K18YAKTBfyQt3eKg3rR4oSqkdRiKS16JZ+VjXBRpN5uCf?=
 =?us-ascii?Q?t0TdLK4t5maxTSsNiZMULJrFzsa6E/urBwPU0D6pAsAkktwuIXV68q/1NrF6?=
 =?us-ascii?Q?JP9fELeZ80d/Gh43WdAS5qW84MhBGedUtu4s+8P+6iTeTG5wJXU2rR/Ssk5R?=
 =?us-ascii?Q?cyzu5QH57kdTUdBGZA1inbI++Efl8wpHCDtwp6oJEkyGCOXmjae5YfyHFlgW?=
 =?us-ascii?Q?nrsjjPnC2yqqz240pI9SZCFd4iDwDu18QJboCJVlIaOuN4QFsZkzbR8K240d?=
 =?us-ascii?Q?tTANeENwMpuCYy7ZRI720BFJrrQwa2RTWgjHRjX8nipoyUuAeq7TLRKSAZ8L?=
 =?us-ascii?Q?BcTIX30tnprVJPZaqBnTG2QnDUuR1GSkIuQyWbbd0P8ABrNFUEH7M0gUPjZx?=
 =?us-ascii?Q?INUYN3AmzQIULOIePKEqgboPhWXq8el5V+lulMUeWCWcBuJ2r1y+qAekSv86?=
 =?us-ascii?Q?iHEtzhb+FId+xH9zuzf1iYATugYE39/oaTp9M1m5GjCMj/LYq5OJsbMyNlDZ?=
 =?us-ascii?Q?NJv4aX+2l8vh3Bv2O29fzgdy1R8xyc1oz3YkgZ1ajZ6CkZkM5bPT8QAfW2Hp?=
 =?us-ascii?Q?b0/NGfnAgr6ei7o2fJGtuPHo5fi2EvxZaDNOwNtpb33asc3mRJE1iqS/YUrG?=
 =?us-ascii?Q?nalTLCT2dPq4S7g8sF/urhQpD3nSpnmr/r7ZwkingwKt4ZZ+3PFAwo4A9V75?=
 =?us-ascii?Q?+Dm/6sETdcqm4AgFFDnfBms9KpFxkl6t4UepB2yZ77OXkAZ7SDXSN6FquIcw?=
 =?us-ascii?Q?YPTtcMMbi6eHj0BzlIlzPhqrpHY1aVsWlR9myyNoTcCFLSusf0tbUqIZ/RSy?=
 =?us-ascii?Q?EzOVzcwp+ECwP7M2n0JavL3agDpB7mZuxnouI+9FkjVE8maNugevxS6c0Sw/?=
 =?us-ascii?Q?CsVCXsoEL/ioERZ6MVjAKLfm94Xy4cJWxkZFDVdFmc8PlHUu4qpO2riNLq3O?=
 =?us-ascii?Q?Bd2JN1Z56kYdgZfKN5xZR+Zx45pe31H84KFs/JZO1OKA6Ht3vxOswYXF/W/I?=
 =?us-ascii?Q?i4Y8hzSp4HfUKqjprovdYtnAfwk1fgxgZ4gfTv46aZoryw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tlB9QSYm5awVYdLxiXWeukHRUxXS7f36bDMJNsmlbxmjbYVn1QGsIBVr5W8c?=
 =?us-ascii?Q?j3dEQohkGJV+/s+Fda+8+01m/0HLsUv0rTMzSgYntRlXOdmf346IFehniICz?=
 =?us-ascii?Q?8ckuKIO6h6lJjEadY5V9mn+tKDQkLG7wpSuLET/AhmuBuGftmEljk6nxQQPc?=
 =?us-ascii?Q?3j07ZCz2fLAd3UOczUQ5nnZHWdDd5mIk+MjVrXDqDSwUIBJ4Y0DdAXNy9wnk?=
 =?us-ascii?Q?4/z8YASEVxdzzS9bogyCr24a/4YMtzuFUDeobZq+l5zk2k1ktO6xJeM+qMxQ?=
 =?us-ascii?Q?EGkbbu0a9HRAOQ+TYraZl0/Io8IOeglLOlTCQQT7o1PTfgqznNZzniSbC4C7?=
 =?us-ascii?Q?JoTmbnaqDHDEYoXqCyPXsG18H3v1Sje/B9QpaBgFDJxeYL8QgrJEa+iY0JzM?=
 =?us-ascii?Q?qyvwYj0ZY8dT2IY2LeL/f8svADXF7Yvxj1sSaWk0qTTGAex7tm12Q/bwl6K2?=
 =?us-ascii?Q?bz3PsoDwboxh9ehpvoodD/vgUzg6BvJ3ZYvkBX+ZxuXDWsWd4TBdDu0mj7Wy?=
 =?us-ascii?Q?3aybbRY+wtScBAL/vgDbZb1WD1wCuj+fv3vt+6bXauchz8lWDK5aXKf6pLcI?=
 =?us-ascii?Q?rSUGt9945YAYByxCzXNMPW4riOW6A22VPQ63f3Gf69+/D6tEEXEmKQ85/vvu?=
 =?us-ascii?Q?0fJLT+Zvalj4y99NznweB4AvTM9B4+mCXHkpOh/w8H9GWjrrvlh4dycL02Kr?=
 =?us-ascii?Q?lKGPitjDf39g6CI8l/OWYLVdGObtrk7CWlK0J/MzLM0RGfzMvBBdqG6dbBMy?=
 =?us-ascii?Q?6M5TMREbbkLkKiBFsEc727Ns8WmXdrApuu5GkxEpMthLLY1jnVnkhFcHbcUo?=
 =?us-ascii?Q?4qA2NfP/WvbD7ZTkJXdfcOBj+kwQpN3MAxcw+3/GfSwR9q+ZoBK9bgZORUkD?=
 =?us-ascii?Q?w8aJ3gGERoPpis1kUHm+Usmb4xBMXC2gdnlsl+CSsb60vJlNeOOvKo8GEIiq?=
 =?us-ascii?Q?8aGzJLV8hbxdwnwxq4Xa+pEw7xW0ZapqX7R+Bjc61iVngTC65XSS2/Qoey/F?=
 =?us-ascii?Q?kWu1/ZNagepl/rsfcXc+f9R3jS3Ix3jBsV4iqz4LR8DkhBfQFHDvkcbkZdYV?=
 =?us-ascii?Q?vGInzszHPnEz2Fp4bSmz5ad5UJ9qKVAPKuNUvrBRoiT+O8XuFPnksAlVp1G8?=
 =?us-ascii?Q?UEtg0Nk6IctO+td0CROfFIHNSarRg+mf1N0XfPElEj/QvUjvPyUp27Vis1WK?=
 =?us-ascii?Q?R462njqIh2N0zu2kjWV0jsVFpR8ijGTGGbYiRwCyN7TF06v4psv14eAwmT3U?=
 =?us-ascii?Q?+NWIKnNJb5SUyCS/08FbQB21/GQkv7g7zjqfYkZz+oZB5x1Tu6V4ymi8qCpO?=
 =?us-ascii?Q?C9cv9RoYhIW6JOAGnApjIewzB5g0Gwld+zfyx6NbbiAB1SpTlDTmm7FoEN9n?=
 =?us-ascii?Q?pKqJ5b8iq4p+LsXhRqvo2KmKOk5HbNSBTe7GLeOxbq0KSbXkJG/SCNCGqpvp?=
 =?us-ascii?Q?yCBu/EzA4ZemZmrHZdB3ZAdahVjb/JIAozciIM7mYya1OA+xab/I+XkdD/hn?=
 =?us-ascii?Q?uZ8mZ4EIazon+vO8eyjty0ZJGB1pyvNDMTK+bRZGdhfHFm6ailyuW3k094NB?=
 =?us-ascii?Q?fXrKixXRQ5kmnpj9QFLYN1BIPFuhZ0gM5i4ADUKjMv41m8SWOJ/4TMqL/e8P?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FkiOtU6eDCgebzS+GwWG4kDvyCc687ZQWgwbX6pmV2HSBISovvvPkYGuf+QwPp9vcfDcS6hWlrrDbujHyEHCEU4rnk656MGkvLVN/DFm301pOa6HxL+vbWbgmXM1COP2Pap+ujGZ9djue4KFaFTYiC0z0yB8d1pRPaq5/h8N7rhfacLr4fy+E9TvSI8gQX8O5csfGss6dI/7kfho8cKFY+t0Hcu7Td8sw/Z2N9fpj4hzlkSFtRoFV5EsuCcNKyuiJFwOYLD0HisPp0flGooTL6CySn4HJ4ZYEicy0CsDg1qTtPr2hLEc62khznR61xU0CihyRXB36FtmM40tIuoJfuwHYUHcYrttwe2jZrB9/BeJN/dWvPuqacnLW6yv63/RVay6emRhoT2ojxGWY4X9syAqNmhK6ALQvNuwQntnmkFBkAPa8oEnHQcHvoKAPLMxIsHtdA035BdWjFJuIUdk+ORogUYDwpLfJx5I6/zJfmuYc0mdSWJApAiWGvxoRcQaPwYmpT55q9Gx1JjKZd48hE+pGt2YCKvd0k7yYUPDzH2CqRodQHd/7BE+uCiAriRP3K6SXZSGhslYqa0A6BLNv1dBytbhF/3Q2zCLS83XEK4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042745ad-1c7d-4db3-6ca8-08dcb8901ba7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 16:27:05.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAZxj9WvEddsQqjv8c0BIBL3it6D35XR37bfkuYta1Z+YacRPhU24iP7icgfGIRSdzYE9jxBztFEO5N7k4Xtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_13,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=484 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090118
X-Proofpoint-ORIG-GUID: rhcFOpq13kQI0rcTAmrm7vkFJlnq670X
X-Proofpoint-GUID: rhcFOpq13kQI0rcTAmrm7vkFJlnq670X

* Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> Replace can_modify_mm_madv() with a single vma variant, and associated
> checks in madvise.
> 
> While we're at it, also invert the order of checks in:
>  if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma))
> 
> Checking if we can modify the vma itself (through vm_flags) is
> certainly cheaper than is_ro_anon() due to arch_vma_access_permitted()
> looking at e.g pkeys registers (with extra branches) in some
> architectures.

Doesn't this also allow for partial madvise success?  If you pass a
range across vmas, then it will fail once it encounters an mseal'ed vma.
This change should probably be reflected in the change log.


> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/internal.h |  6 ++----
>  mm/madvise.c  | 13 +++----------
>  mm/mseal.c    | 17 ++++-------------
>  3 files changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 90f50f3c4cf..3f9a5c17626 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1373,8 +1373,7 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
>  
>  bool can_modify_mm(struct mm_struct *mm, unsigned long start,
>  		unsigned long end);
> -bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
> -		unsigned long end, int behavior);
> +bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
>  #else
>  static inline int can_do_mseal(unsigned long flags)
>  {
> @@ -1387,8 +1386,7 @@ static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
>  	return true;
>  }
>  
> -static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
> -		unsigned long end, int behavior)
> +static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
>  {
>  	return true;
>  }
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 89089d84f8d..4e64770be16 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1031,6 +1031,9 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  	struct anon_vma_name *anon_name;
>  	unsigned long new_flags = vma->vm_flags;
>  
> +	if (unlikely(!can_modify_vma_madv(vma, behavior)))
> +		return -EPERM;
> +
>  	switch (behavior) {
>  	case MADV_REMOVE:
>  		return madvise_remove(vma, prev, start, end);
> @@ -1448,15 +1451,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  	start = untagged_addr_remote(mm, start);
>  	end = start + len;
>  
> -	/*
> -	 * Check if the address range is sealed for do_madvise().
> -	 * can_modify_mm_madv assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm_madv(mm, start, end, behavior))) {
> -		error = -EPERM;
> -		goto out;
> -	}
> -

Funny, this check stopped populate madvise operations.  The new code
does not, which is probably better and fine.

>  	blk_start_plug(&plug);
>  	switch (behavior) {
>  	case MADV_POPULATE_READ:
> @@ -1470,7 +1464,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  	}
>  	blk_finish_plug(&plug);
>  
> -out:
>  	if (write)
>  		mmap_write_unlock(mm);
>  	else
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 4591ae8d29c..6559242dd05 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -67,24 +67,15 @@ bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
>  }
>  
>  /*
> - * Check if the vmas of a memory range are allowed to be modified by madvise.
> - * the memory ranger can have a gap (unallocated memory).
> - * return true, if it is allowed.
> + * Check if a vma is allowed to be modified by madvise.
>   */
> -bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, unsigned long end,
> -		int behavior)
> +bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
>  {
> -	struct vm_area_struct *vma;
> -
> -	VMA_ITERATOR(vmi, mm, start);
> -
>  	if (!is_madv_discard(behavior))
>  		return true;
>  
> -	/* going through each vma to check. */
> -	for_each_vma_range(vmi, vma, end)
> -		if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma)))
> -			return false;
> +	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
> +		return false;
>  
>  	/* Allow by default. */
>  	return true;
> -- 
> 2.46.0
> 

