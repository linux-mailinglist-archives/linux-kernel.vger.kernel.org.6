Return-Path: <linux-kernel+bounces-260067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E89793A286
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1352E285669
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BD215443F;
	Tue, 23 Jul 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/Nw5SWr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SGxRn2Mc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478615358A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744298; cv=fail; b=YrgNF5eg6g7sVqe32CKFkFtQQt3xFSEwVMhfgEJ8VnEs28CO4XazGXC4TDhs7EiCi07uALW4on05gp+XpDNCu33n2R0XWRNZuJGFRZSlWdP8f2Y3WXKOyxlXqBPw0eEqAOefpYKyS1lexUSMNOSj9VDxxhQ1QDbltyGjphvVgcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744298; c=relaxed/simple;
	bh=o9HoAlmD700uxm74R50h+2K8sQTfvO+Ty6u2GLx2t8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LwCMNTDmnqD0J0dIv+CO3H0Iy97wUDc0kziFIa14FQpF1wJSAqhQkSkfilY/YV6qOYOLgu/anmxv36DCe4qLNI3O3jutMBViwC/YyBz/AKjx9eCR7LGuci8dCFitua33ShWKobtJgHVYVJ+0ioQRna/tFxKwjBZonOkx3qH5cD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L/Nw5SWr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SGxRn2Mc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NCGTX3010076;
	Tue, 23 Jul 2024 14:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8T6St7O5lk21I5A
	OKOS1wWQLICFZGkUGtgpylJGdUPk=; b=L/Nw5SWrFRYL50Rk6bq15bSYlfli4Ic
	wRVXBuU1ET4YZx929z71W4afykLkFs3cM9N0GHXutoRIM/w54WbodQ15gJ6lDmL9
	CdkmAcSeVKfJPzi//lrEdhzGTuuEjGhsQNqimvykKaTYk+HCumGCPb6lDEu4r6yZ
	B3Flzj72m7MhDUD8Q/n6+lx/lpQ/UrZ5UZCFNz1EmxA2BcZW/cfy9ZE8l5S3H1hA
	IvE2WQLLwAo3KSxD1OrRgUTYLzqYwdw5eVP70Ulwrqf21AoSLU4T9aN7p2LHwaki
	7LPXhGSP709byUZ5qDb33EPYHIdgTJbcp/kkE9y3fVi6lq77IUVXWEg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcreq9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 14:16:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NDZx3H010953;
	Tue, 23 Jul 2024 14:16:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29r8hc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 14:16:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QT54LcFnBGOc7QY+MF7DdOb0jk4kiD3Ey3t3mFoXbeBSoJoG7/BzboJ7HlEFFXQogcedQpC9h2q/3acdwQNr94imjykHAdut8yPlOAFRiwlX6QYoLla2Sy51VROuWkj4GFrnzhtIq1kU2iej/VIF5wmZ4S0sDAZx3TQEMV0bGfRdX4UKnzqWxdlbHCAigvPH8st3suePoZm6ZHQks2ole8UtRbMX1kXcGQ6I/olvbVIjGbONTc2aa0aptl3porGVJ6gidkhSqfDJVHc+mKybDGlAVfZrBlxOpjktNRcJN3qoUznFuk/5R6I3XYnIVJ4osYpElyq4drvrDorjjUf9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T6St7O5lk21I5AOKOS1wWQLICFZGkUGtgpylJGdUPk=;
 b=puZjZJhZvoJsCfXl+Mf7Q7O3J4vrdHoCV1XIT+jCYkA/fBRxPgf0XMsyGsugd/FUUh1yrCzv3hdiy6I/hFS0MmCmW6p+kaFoGgrMaC1sZ9F23P630we5X2eQMG5gauymtd0gwWBfubhYsib3MZo/e0336nXrJkhccE5AgRmU0EVws+A+raJhFgj74ErW2StUY5kKAtAgdZMTd07waYfYSFn6sI8z0WOzZnvruPssvfkuS3yfI4r//1ALgB2f/tkcQgBnsJJUw4BUm/GmMdoi5BWFY2F/SnhqGzmwvtnE3Yv2g5gxPuLK9zYJKSYQKkvbsZ3joEf/+ICLMojDvb6TLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8T6St7O5lk21I5AOKOS1wWQLICFZGkUGtgpylJGdUPk=;
 b=SGxRn2Mcv02HNulRE5zhJyHN1elyi1KP3YzwNr04EyhsKGVQQT5KckY1ZwL14v7VT/UUyNpL/QdyQXzvi7NKjS17nzshqEtu2n9SA4GRka6bXzGFLsTzIdr0XhqDq9ViDgx3J2nJl5H9k+9TEjUloIS9t7oGkuoHDGYwsam3Pm4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW5PR10MB5761.namprd10.prod.outlook.com (2603:10b6:303:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 14:15:58 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 14:15:58 +0000
Date: Tue, 23 Jul 2024 10:15:55 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v5 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <onro3fbguuhy2r3o2isb3acalujp2xf65orxreuxuxeyfjtc7f@4aev34wc5pvb>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Jeff Xu <jeffxu@chromium.org>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
 <20240717200709.1552558-15-Liam.Howlett@oracle.com>
 <0928cf11-ccf9-4065-8768-4216916c6223@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0928cf11-ccf9-4065-8768-4216916c6223@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW5PR10MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7fc3b0-f149-4cb0-0888-08dcab21f91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5WCeY5eZnsPFEsiz83GK+nZzVZ0iN6NZjtfTBjejizo141K4iylGCbxJdCzZ?=
 =?us-ascii?Q?DkLgg2GhtbCYm6r7qIwytzJy2JvQHYXYoyATKwKefDRspuppm7mXxNfHO4Kc?=
 =?us-ascii?Q?flGJwjp5UHkd9WUDbSJI6ivNW/OohVlq93s1IIf3jLJ8XY/RiAkGp6inL8rW?=
 =?us-ascii?Q?r9nu9yVV+gb5N5pMnZLyZ/HHSfWDe1aiaAPJuXVzgGqcXSDDVHabYFUQOZ0V?=
 =?us-ascii?Q?4k28Z89f+lqVISlI8//yt9wrfEYvdb8IxDXsekv9PTsquVhQKaueBNBi+USz?=
 =?us-ascii?Q?1rG3NGI+G1owW3TriUDdElUys4Y1Ja+bL5mu91kROmY8uKxa9APjRXNLqxEj?=
 =?us-ascii?Q?8sL5vOuGivVaI2ysTyUPaHhE+Yi8WjxFcofWyR4gkgNT6/g2WHrAey/UDjqB?=
 =?us-ascii?Q?jlDsTBpg2QQyxyYgwV6ArM/3E51IWVCN3sEUn/0qRPUxomkJvj9dzChdOah+?=
 =?us-ascii?Q?psMaUJ9rQf3NjCm9PVsTyZX4jDPJ7DOEkpkaWDwJGoKgCLnh9J/E6ruWjTHX?=
 =?us-ascii?Q?U5VzmqE5xzC00Q7ia6Ig3XphhPdl/PPtWXDMyfO7HjYCEQypj+SAMsDxxmsn?=
 =?us-ascii?Q?LI4HC1FeNLbOv20/suvZcBJdHjyrPvVdGYvqV4bVM6lssBB5bATbOuwwkS+9?=
 =?us-ascii?Q?jEs5NijwPTt7F9EbOm0V79FIP6v3cauti0pLJXbHEPU4BsyDRb2a1DhwmHWo?=
 =?us-ascii?Q?mfHWBEjWyJzag+ZgI7HMKCwVEJyP36DDm6nUCAZqqGFmKdk4kt2hXFJqn2bn?=
 =?us-ascii?Q?WAXaO2m45C/7M/AsDAhj/Ku9l8rTg7dxfrzVx/DDlx2VmX6ggC411UE1Au4E?=
 =?us-ascii?Q?J7yj7bD9G2U0tROlEkbPbsImOs/VN5tQi3fRi6yhiKQ2hEsJQ3YCRyhaC/s2?=
 =?us-ascii?Q?9J7ta6MS0+7GauiWYWGvDi3yxh2B/Lmudxk1Uid2IpwWriabjDpG3e+C9fK6?=
 =?us-ascii?Q?z0YZ1Oh970Ryko5cJ98ErA1GxW/dUGehQGBxg2vMcsxpS5DcffwQrrMBsx1Y?=
 =?us-ascii?Q?7tqYCVv3YTZYX7mw9TugnCnFIzu3Nj/TP7036t2uPPaxVt1YWCU1iIcnjcMi?=
 =?us-ascii?Q?uG9Jsx36DQNrPvLfEQRYFozPS0eGIKAVQJ6g37WvTF1hdjF+IDoYnTmJCa66?=
 =?us-ascii?Q?cINB/mCqALyqYQqXkYuNWw5IYKqeTu9tvsViBLifoQKxxwgiimCzvPXNBoIa?=
 =?us-ascii?Q?/oAmwp8kcoMiV1y8OHmjWdW3zxBRldciNsOqazoWu21gRNvDPa9jbVuFLUc/?=
 =?us-ascii?Q?RVLrifBGG6PTJDM3WuOQJYpHuVMbEt4uh/19YOHjbsDSeRaN3X27ByunCVj3?=
 =?us-ascii?Q?UUTSLTCA9XPbES8zmte5pnLVNenYj91KHHyVjznmf7gnUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C/7+S8VaAIVwLbWnUi7hACttxPrTm79AN1pJ4rZRnK8dGfoK8SdEnDeBq98t?=
 =?us-ascii?Q?NpQfh7zifvr5TaOmJU+GzwJTsOMjAI0nZR3UsG+1OMTouU5aseWJdu8wbBA3?=
 =?us-ascii?Q?Af2jASLTDiPjEvndkOJS7dv00QedLV/zDRGmbr/XBV9xM3qtoLfBMMUlzhNF?=
 =?us-ascii?Q?v8wzWX5se9YdE+n+RxFQ6LiV7YAAS20WGh+WtXj1TZY3qioOn/jKUR2WKwk1?=
 =?us-ascii?Q?DQUXQfis2LBBOfWQ8xKlvdSlSkDseCkPH0McljbmTPHVoqDLpwC68NFStjpY?=
 =?us-ascii?Q?KDCFDcm06N9TW9pgR4tvCZbYipP1uwrjKrgI5VPl4mRQB9O763ZJz26rwkUF?=
 =?us-ascii?Q?mfS4RRZjoV/DA3ScWDpqS1Lop1bJIpI2PhnHv3z6SjwxSa7aylR8xyPRB59N?=
 =?us-ascii?Q?B0EgIA8V85HiIh97GxKENDU9q7479qhMkP1xvWZ364ikYJ5+Epm+lK5y2Krl?=
 =?us-ascii?Q?Lw/FugdyQidk2pQ2Lz51d5D/eVhODMyr0FvuWtPbofH3CJHL/u3+ovTRDiBG?=
 =?us-ascii?Q?SHLlsuOPpybMwtMsfnKDdDbZAM8kxFS5ZV4cl+qPvNBQyuuAJ22wWE52Q9y3?=
 =?us-ascii?Q?uwyNuJN23o/y/HX0LvKoNbSEgT0sYH6kO6jr0PszaSxog1cQOX/4daj7DSev?=
 =?us-ascii?Q?m9FUodAsig2GGFKosz/uiewb9QxL7LRmzYH87By1/17gCgl0k8efNJHJJltv?=
 =?us-ascii?Q?aeXHiNXUAeADmvTj6HkSpWg104eD606OkjZiRV6LMEXHxT3LEEp9uzVmpyxJ?=
 =?us-ascii?Q?GD9bqy/Ylr7SXWqBWMqXCIuCt/LZKSXarVswU2x4Q/iH9AIrHYnkTqnJbXZS?=
 =?us-ascii?Q?cyy6tHYKkP6cwBqY23bB7AC6Wv1lK14CKrkPS9PzKc7NlH++YYqaTcqMIAho?=
 =?us-ascii?Q?QqF7CJ0N23LcFAq33G5GNeZhkWWPsuNF7Db9KXGa7/JTpZGuvZtUUA8widfV?=
 =?us-ascii?Q?LADZ1jvTFFJes6R3nlgbwuPWs19SH92/Gu3bLhoWTrBWUrqbUcg6UQ+nNwN+?=
 =?us-ascii?Q?y9w2wMTvcKeIN4NscngXy4TuZBqBG7O0zACkX11fU/U57EDSSbuQRSOXEJ5S?=
 =?us-ascii?Q?EPAQ0KMhD0yagw4l2JJRPuN30Luf+JZ4Lv7EfZHDusKrcrHZiAjX60xXw400?=
 =?us-ascii?Q?XcTVt7QDSMivX4gzeiH5kSIcuLZhkC7lnay262K+Js+UIktL2Xvk/cG0Ep89?=
 =?us-ascii?Q?rSnaiQpbBaEwGMxNxLHM6+ynaK0vzTJuT3jUlWO/jLgyk4Z2Lb9OYA3emQX0?=
 =?us-ascii?Q?2x0zho2Fv6lYLgMebQ7X16iyqSNNUw94npVcjdJGi/11AxI6eWQE4K0UJw/H?=
 =?us-ascii?Q?T9aoiHMwTj68r3eQva/erE9peJ+jQqelsR/HagOvZdsYVpK9B98ObDMPXYGK?=
 =?us-ascii?Q?hUiQvihLSwEBmDXSaQai7LmtoLDzaimHmqrLq2Da3/G3t9zEqsUswsNd5/OO?=
 =?us-ascii?Q?kgeeLBJSxfzO6MHgcTBcfk7jjNNVEKqvZQKI2dqLClulp7/zTPpCm0HeQEvu?=
 =?us-ascii?Q?HU7l6IBQUIhKQbRtYeQYGVPDoziVJNDVyGylInWpyRlb8VrjoAJQ92fKl4e9?=
 =?us-ascii?Q?3bB8E9k7uY+7IkBr4NClN2o9hQFMa2/W3WkMWb9O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	obAhCCqS9Ypo4nEQe9qs9ezPYUU8B0mS6Ud8dxpdT5SeKaf2zH8fkTKu4X5AQi9aUXpdn3pjtgb8RVgliTeetquNx3vGCNbo3jOf4dhWas/2rgJlbdaMhRzvEMSY9xBUeR5jZHLdaoNUXnzrKoaR7JtRMsuddqcrE5jeTaYl3f30AWWH0V2cCTzQb2Bo/SPuonV8STr087MPEi6pqj14EBBLnFGrljZ5bzNexTKbcZelFw6il/tN4mpZl/tnl4q0zwBZrIhUyqCVfwjd59oYVZvy0kJTubXhvZec0X1LOwQ+XAyJYlSSrk9sogL3H/LIskbWkhiqBu/jmtk3DtZE+etBYSw+eHglrMs29dLYVSOnzub1miuypJermwGLV5pzBy3J7zyigQj+W50bTXUxVGZnKhXuw0DqXK9Lsau4hHi7VQVXpIKqNPnaH8bkgFgjk7iNxB19l8r3/+5n6QonFK3HiWzKZich2m1l5RRtB/6OR46H7snaHptqUM5crOTX9Bemz1ZvvaieM5OTDJOt35iXRIbkkULkLiLEy7HcxD7PYe/1DBN4yf7l+WwmMfraIwBYAgNUN2hhuW+Wi8r6UlelsnKAhC0tBhxS3o3YbX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7fc3b0-f149-4cb0-0888-08dcab21f91e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 14:15:58.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dm0MIo5T9VLCdn/mMUHd2qG7ZJ6rS9qdtE2nm3u0bEZM8wUX5s0PjYDqiuVujG+s9kxuUSdliiRbAXQMnPdjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_03,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230101
X-Proofpoint-GUID: eTOSiGJNnjEmq5eq6pcKbwOWAjUMCiBQ
X-Proofpoint-ORIG-GUID: eTOSiGJNnjEmq5eq6pcKbwOWAjUMCiBQ

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240722 14:43]:
> On Wed, Jul 17, 2024 at 04:07:02PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Instead of zeroing the vma tree and then overwriting the area, let the
> > area be overwritten and then clean up the gathered vmas using
> > vms_complete_munmap_vmas().
> >
> > If a driver is mapping over an existing vma, then clear the ptes before
> > the call_mmap() invocation.  If the vma has a vm_ops->close(), then call
> > the close() function.  This is done using the vms_clear_ptes() and
> > vms_close_vmas() helpers.  This has the side effect of needing to call
> > open() on the vmas if the mmap_region() fails later on.
> >
> > Temporarily keep track of the number of pages that will be removed and
> > reduce the charged amount.
> >
> > This commit drops the validate_mm() call in the vma_expand() function.
> > It is necessary to drop the validate as it would fail since the mm
> > map_count would be incorrect during a vma expansion, prior to the
> > cleanup from vms_complete_munmap_vmas().
> >
> > Clean up the error handing of the vms_gather_munmap_vmas() by calling
> > the verification within the function.
> >
> > Note that before this change, a MAP_FIXED could fail and leave a gap in
> > the vma tree.  With this change, a MAP_FIXED failure will fail without
> > creating a gap and leave *a* vma in the area (may have been split) and
> > attept to restore them to an operational state (re-attached and
> > vm_ops->open()'ed if they were vm_ops->close()'d).
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/internal.h |   2 +
> >  mm/mmap.c     | 119 +++++++++++++++++++++++++++++++-------------------
> >  2 files changed, 76 insertions(+), 45 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index ec8441362c28..5bd60cb9fcbb 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1503,6 +1503,8 @@ struct vma_munmap_struct {
> >  	unsigned long stack_vm;
> >  	unsigned long data_vm;
> >  	bool unlock;			/* Unlock after the munmap */
> > +	bool clear_ptes;		/* If there are outstanding PTE to be cleared */
> > +	bool closed;			/* vma->vm_ops->close() called already */
> >  };
> >
> >  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 20da0d039c95..0b7aa2c46cec 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -170,10 +170,11 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
> >  /*
> >   * Close a vm structure and free it.
> >   */
> > -static void remove_vma(struct vm_area_struct *vma, bool unreachable)
> > +static
> > +void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
> >  {
> >  	might_sleep();
> > -	if (vma->vm_ops && vma->vm_ops->close)
> > +	if (!closed && vma->vm_ops && vma->vm_ops->close)
> >  		vma->vm_ops->close(vma);
> >  	if (vma->vm_file)
> >  		fput(vma->vm_file);
> > @@ -401,17 +402,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
> >  }
> >
> >  static unsigned long count_vma_pages_range(struct mm_struct *mm,
> > -		unsigned long addr, unsigned long end)
> > +		unsigned long addr, unsigned long end,
> > +		unsigned long *nr_accounted)
> >  {
> >  	VMA_ITERATOR(vmi, mm, addr);
> >  	struct vm_area_struct *vma;
> >  	unsigned long nr_pages = 0;
> >
> > +	*nr_accounted = 0;
> >  	for_each_vma_range(vmi, vma, end) {
> >  		unsigned long vm_start = max(addr, vma->vm_start);
> >  		unsigned long vm_end = min(end, vma->vm_end);
> >
> >  		nr_pages += PHYS_PFN(vm_end - vm_start);
> > +		if (vma->vm_flags & VM_ACCOUNT)
> > +			*nr_accounted += PHYS_PFN(vm_end - vm_start);
> >  	}
> >
> >  	return nr_pages;
> > @@ -527,6 +532,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> >  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
> >  	vms->unmap_start = FIRST_USER_ADDRESS;
> >  	vms->unmap_end = USER_PGTABLES_CEILING;
> > +	vms->clear_ptes = false;	/* No PTEs to clear yet */
> > +	vms->closed = false;
> >  }
> >
> >  /*
> > @@ -735,7 +742,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	vma_iter_store(vmi, vma);
> >
> >  	vma_complete(&vp, vmi, vma->vm_mm);
> > -	validate_mm(vma->vm_mm);
> >  	return 0;
> >
> >  nomem:
> > @@ -2597,23 +2603,31 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >   *
> >   * Reattach any detached vmas and free up the maple tree used to track the vmas.
> >   */
> > -static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> > +static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
> >  {
> >  	struct vm_area_struct *vma;
> >
> >  	mas_set(mas_detach, 0);
> > -	mas_for_each(mas_detach, vma, ULONG_MAX)
> > +	mas_for_each(mas_detach, vma, ULONG_MAX) {
> > +		if (closed && vma->vm_ops && vma->vm_ops->close &&
> > +		    vma->vm_ops->open)
> > +			vma->vm_ops->open(vma);
> > +
> 
> Unfortunately I think this is broken. While in theory this should probably
> be semantically correct, I think drivers get this wrong.
> 
> For instance, in the devio driver, usbdev_vm_ops assigns custom VMA
> open/close functionality in usbdev_vm_open() and usbdev_vm_close().
> 
> usbdev_vm_open() simply increments a 'vma_use_count' counter, whereas
> usbdev_vm_close() calls dec_usb_memory_use_count(), which, if the count
> reaches zero, frees a bunch of objects.
> 
> I've not tested it directly, but it's conceivable that we could end up with
> an entirely broken mapping that might result in a kernel NULL pointer deref
> or some such other hideous, possibly exploitable (at least for DoS), scenario.
> 
> Also since this is up to drivers, we can't really control whether people do
> stupid things here or otherwise assume this close/reopen scenario cannot
> happen.
> 
> I think the fact we _might_ cause inconsistent kernel state here rules this
> out as an approach unfortunately.
> 
> We can't simply do what this code did before (that is, leaving a hole) as
> this might require allocations to clear a range in the maple tree (as you
> pointed out in the open VMA scalability call earlier today).
> 
> However, as I suggested in the call, it seems that the case of us
> performing a MAP_FIXED mapping _and_ removing underlying VMAs _and_ those
> VMAs having custom close() operators is very niche, so in this instance it
> seems sensible to simply preallocate memory to allow us this out, and
> clearing the range + returning an error if this occurs in this scenario
> only.
> 
> Since this is such an edge case it'll mean we almost never preallocate,
> only doing so in this rare instance.
> 
> It's ugly, but it seems there is no really 'pretty' solution to this
> problem, and we don't want this to block this series!
> 

I will add a patch to this series that will preallocate to leave a gap
(as we do today in the impossible-to-undo failure cases).

Suren suggested I keep the change in its own patch so people see why we
cannot do the Right Thing(tm).

Thanks,
Liam

...

