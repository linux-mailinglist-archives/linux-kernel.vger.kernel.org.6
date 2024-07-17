Return-Path: <linux-kernel+bounces-255617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3E9342F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8D11F23480
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F071188CA8;
	Wed, 17 Jul 2024 20:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gJMb6BQo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="voiaFBI4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD7F186E2C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246866; cv=fail; b=Tgp7b23lu5MiYZld39hxkJ9Fqa8hMl5STXryQpCBko0J7/BCYhHBKPNz6LBFuGsvf3kNF3BS2dMBUQ1NnWTnxTFul+yFzkPdKkWPgeoE/nhbu3b4I1N4Ys1h4D1WdOTEHp5ctGeB0YcGlFvF32YvqJxMWym8u8/cFUM9/4uCu/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246866; c=relaxed/simple;
	bh=ifX5J4u1vbCHvQsZvr5APMemaWJ0rns0q5T8KAO0MI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYcsxS/rLVJ44HKOhkr9T1qvctZ6oaPmf3uY05cvPQ1b88aL+6tqjV57RmGBb8fkPEG4ierPfkanMeWUDG3A9FTUOPJAs7Nao+MHsB/kfrdanlx5x98+zxmiRrwFLuhgCMULPWeBzwcialowBpvcEPfPFHyIOrLNAP27pl9DSEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gJMb6BQo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=voiaFBI4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJsQ5j016975;
	Wed, 17 Jul 2024 20:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=uZF6pfcItsFziTEqk2v7DiOKJeCOiZuix0/xFXNniOo=; b=
	gJMb6BQoVbVc+JPaQCTfcqCoeSkvW1mMMHOVtJARBkz4d2eAhQX8EZxKGb3iOXRY
	JXNmjOaTh79AZfj8G1G7FTdtgPz0hUB5d3TuT7tle5zmoyrpuOHlf7Nw2dYP511G
	Xpx+UuvcJ39pFuL3+JOKpg8X8DnRoMV+OYPK0SMAmU/nOXhOACVmV+RO0PFMkIaP
	CMU3HnrutPrk4ozPkLhBQgMemWSvEieUoBvHfEWUFMtx3nmbonjJYpAjLFnmEGa8
	b2IqMhIbZxzJRw16IWfqft7dYkdX9gyAvD+1aZlzG9oIDmQu20+dV2Bsgvu8ULVe
	vewvJ4VZ+h0hqlUT9QxXgA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40em3m033e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HIrJXn006940;
	Wed, 17 Jul 2024 20:07:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwey1fcb-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhRR4fCZ5aiLfxiXPvzhCSD9hLd38GqTlHpzfqW4Kt3SaojloB9nREGELs/Nbf1fyt2dh3Zg7hUw1LEVAyTMETrNc1Qdhpp54ii252p5tx4M27tvLqeiabxb2rZ9syb+IUKhm3eat1+jsXLe+84xW7DrSa252X6Vx24bsQRFYrK+bQKdrrBxvQOJh58ClUq9NnaXOTi7G34Tn1NzEt6ELVyUV158Xm7lvWxMIclY2OtrDgVa0ni5enZBdFJIFL52F5PG7Y+JIxev1tApUMmpCWqp0EXFXfMrRzF1xCdd+zN/rv81TprPTjk2DmLosO1VStbMQ4mKMrdWfsdFPkj0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZF6pfcItsFziTEqk2v7DiOKJeCOiZuix0/xFXNniOo=;
 b=CSWMKBgDJ+rQCUcR51s31PMI49ibdBHMdUBDs0mpoQPz+EggFwl1I+tGUZDHEZfsMgwyeEL8K8pJ1xyjRzxdb04vF/UaTlclj2qKaTcTeZ5AhYsRCH+2CMwXPWGn0JQQSh3B0gKuCmbovT3fl3t2RfYqC9bowTcBxdi8wQqNWdp4ydSLaxEK9SlL4lkzrCuScYQ6lwwyivEupwTA2pM3Ems+9it4N8PZhPISal+k27bI7QWXcHZjpfQBpCG730ANp1FIqx1o8UnyZYvt+luIQS6y4oeVwL8g2Y8WGGgRcCifOEr39y/PHq1NJZC/FL1PDkjuddG8sLcfv7DpLK7uJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZF6pfcItsFziTEqk2v7DiOKJeCOiZuix0/xFXNniOo=;
 b=voiaFBI4WpMUrVSqlTHz6tXWrM1SmW6cjkhEC2BZyB96DVIiTU0t6QPdVFPAU1eR87HYKs8QmBv4sGeqs+e7hsaDEjuH/6azBuxJyAPkoq8aHjoCg85oOW00rv697OF0b80zUNeOPiZTakjE1WjZ4KgGE8BwyXNbJHKurPHCluY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:25 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:25 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 05/21] mm/mmap: Introduce vma_munmap_struct for use in munmap operations
Date: Wed, 17 Jul 2024 16:06:53 -0400
Message-ID: <20240717200709.1552558-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: a27bc2e4-c53d-41a1-eb90-08dca69c12f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Bxb8YUMllyaObAwzYDXTHQNyI8wmnCRUCx66bQ/dP2YLNazlv4UyRL+OoZ5n?=
 =?us-ascii?Q?RQrMmjLoBbtkzfGf8/r6p/6N0ISV9ETQ7IUciWNDJBj1P+735BD71dh/XDxz?=
 =?us-ascii?Q?OGQV7lroW++EVMu9O4RM0uC0y5vSDeeJkeX8jTq/i4hh8D992/YgKwHfjGYC?=
 =?us-ascii?Q?kSx3kaUUH+jUuwmxiavgbbPbbynxKfigelegQjMvlc5xeCTxYpkV4XhOdeej?=
 =?us-ascii?Q?gafFZtVb1tq2Mh3R6FByRdHfaEiS8dRiEdWQUgwGe5rHEfdCHXV2evcRlP2z?=
 =?us-ascii?Q?SsnJKByHmZjMUpZZqWRD1kAqKQM9zNpSLS0pJZrgmLuDko3ximjHvshrf+Ha?=
 =?us-ascii?Q?A6wPX3tsVWzPGIhBrDT6QOAwJbd1ntH4JcFlheowQL3/M6nexBE/qIGmDx42?=
 =?us-ascii?Q?yJU/dKDq5L1zjcsxTrkOrwvThuTJq2Bp61ml4e9XzUaqvYf0EWQJNvLp0zmj?=
 =?us-ascii?Q?HVqlGXnqZR8h4qVrcyn4X/B7VJ2xzvFfmtO9zv7s5Wuj2N0IXszG0c6u1iou?=
 =?us-ascii?Q?zmFdhCS5V9WHaWBu5xmfbhXB39Km0sXVN8iuuoX35T55ZjU1PeZeZBA2D1Pv?=
 =?us-ascii?Q?WZHv9GfCUZNHYOe6Hhxi3UE0/EHOxr5LqLPiAzV7TnzLbq7idWoPQrQcEBnE?=
 =?us-ascii?Q?PV4DCnUmYs6bTvMT9YZnKO00Aay+oSGq0Tfv5dN+V33kUfDfhFxRUnddLp5d?=
 =?us-ascii?Q?rkhtWQODJi+gDFjYs46s4Ey/Uy9DpjWT2059fTSnya0bUCfEluMBGVE81rSe?=
 =?us-ascii?Q?wwQFYEKmB6j6okFqIEt3T+ckF4FChhXu85snV7DKoCd891MI4SzI4d0KZrI9?=
 =?us-ascii?Q?Dw7TrQPIXhRLdQvZR7H395P+2xs/fzeLb5O+aS8a0EcmhJ6GC0vtis4qdPoh?=
 =?us-ascii?Q?8D2DTTPDzz8nyShowH368aIpRHE3qhd31c0xP+3FLePoc+g/1hekl5whTW+o?=
 =?us-ascii?Q?wST8fvQJPDPkwYiCpz/+yw8ndkNh4wj9ybdSE5yUmoSYqVanrmz7l903hs/Z?=
 =?us-ascii?Q?z5c4M4RatodLgtF1FaHuQwC7XgDhvS3mvKxr8qywRmk8yi/FrLn52rARJ18s?=
 =?us-ascii?Q?a20lI666mUpND1j31l4Ec3qF5+dlujMTfjtsYIJbmISHmg0q8mBuFiLeOKsG?=
 =?us-ascii?Q?/cBOuTedvUufN+VwxmP4CqGk1++RO039rZJxVmjPyo6wLcJohv8BL1nWx2br?=
 =?us-ascii?Q?2sCmYZ5VSrZ6kX1d+u5+ouRqlSoh5YmvHmtUpvI8pVeg1D7/K0eSDgvLUxWp?=
 =?us-ascii?Q?01ZJSSvGKi/tD8Oc8BpUxq2ZwtZYp9EaQl2iraqhSmeXOjKGNSOyo+glR16Q?=
 =?us-ascii?Q?k94fg9gDVZfB4L4bPU9sKMGLAuqQpe+BSbeHmDdEqDyj+A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Cd7pERAF4HhhZ4isPqapwnb/RNKrToyx26Vp9n4HOJs42HMR9v3AxrQwtRnE?=
 =?us-ascii?Q?H0ZkwnKvGs/5wco2ZsFppBbK1oVit3ikZTUcJGxDL4rNSdEZWcQHMYL1wv8d?=
 =?us-ascii?Q?AliRzYJpPWMuaWVTnFcNTO35+oRCxkbjp94v97ZVcDaq7FO71KMg2JQPmQe9?=
 =?us-ascii?Q?+RcnyUSYRIHkK9Y7T8cReeo0+MF1kr8ClFaAV0kBkJ3hAjSTRymisrtBPGRx?=
 =?us-ascii?Q?BzBKZGyNx3ZIwysf/vmtHcFFYo1ycqI193JjLcBhjCTikaVeyjP3r+3YTWIi?=
 =?us-ascii?Q?uC+x+ieWpTchrTYpuEezBUDO5nWu4LJLvc5z4zC714hpHQv/S3F+pilNWcaZ?=
 =?us-ascii?Q?ipowi6aeZv6UdAMztaQxZLXKEc0G3GevMpWhAwUFBYGcKIG+8B91hgn3BDL4?=
 =?us-ascii?Q?2j1AensabwEAxPQoGkVgtjInB/Uq/BozD7FxVCw7d5QvsZiAzLE0rI4j6MKv?=
 =?us-ascii?Q?OjAp/n0MzP3rjhbTse8VqvH654eqp/34iZGg0389tL+oibS/Otc6WOqK1jIS?=
 =?us-ascii?Q?za2DphbyqX8aYq0ic4DP6aZicjX/1Vs45wN2uGIj+Y/2P1lj3B6ZQzjdFw+N?=
 =?us-ascii?Q?aG73dLofFEq2GxPOOmvBAOL2DLL11tOaLZ6nEzU+8OSHER++MHfYM3nK9x64?=
 =?us-ascii?Q?/Zlm0/EVFpbJwJ0qNC7nLIksxLeJVANPY1sc/9NHJXBcRsO22g5fIn7i/0Zh?=
 =?us-ascii?Q?CcnUKgk1Qnh9SxvYUstQ50bnYyreXBCK/PQgkAdGahbg46WM1HYjc0Js7aPz?=
 =?us-ascii?Q?Kr/QfTw6Jz4riAbaCI/9QXX8+YXD2VCf+jtd+GeZvgodsJvzriEVvAQQKuS2?=
 =?us-ascii?Q?UAyS4cAm7/CmxZcVxMJQKRUydKjl7Q791lqb4DTt0ISqrz8SG5MDBGX/qHHw?=
 =?us-ascii?Q?UAG3bIHdan4Rx4mrJvDUo/8RhvqNn7NCTuVFzfsMhSh0hJLeCWRHLGA7mC89?=
 =?us-ascii?Q?TVz60pzFD6okJ5krDCHWrSrKZfEugT9z0QcjFHGBBj5B3WR8FcDVO8nllOAv?=
 =?us-ascii?Q?7LrwgkY0C8YW4wrTFBN0BXIh3j0D2/q4cTxnqmhcbdtzXacivXJdFA4b5zA7?=
 =?us-ascii?Q?Kx35+pm8dhUQfkYSA1tBKjcX02RkmFYxgfoSnRlnPthjPAU8UEbSPG0hDb66?=
 =?us-ascii?Q?+hx0MvgzdnA1HiSYmx19YOe5autHG1DLNh5Pt87WdJWbZuk0Bxe3jW1ALa00?=
 =?us-ascii?Q?QmD/aToxc92hh2v+wu40pmtwDpcW6BBaCP1nkXpjSlwqDrE8u5HdIo1JbCz+?=
 =?us-ascii?Q?B10/JbOjmK/xTodKuAEsWuu9zTJdn62SZkqMSYgbRpThUhslSjfgYtMVq9Lt?=
 =?us-ascii?Q?mL4HHB3vClXp4QIwebrCE/RpsgnUMGympB4u18/TY2IH+jcxN+DzHXm0ArOA?=
 =?us-ascii?Q?xHyas+NtqG5W/JM2wslWLtTZmPwU9DSy2SH+EBwhHvKs/k38bdc2FEZpe8IB?=
 =?us-ascii?Q?dwhFnr72MZ8nFxMEh/hJ0QegL/ifixDGZDFC7n0N+W73ewKaHLki/5Yy0PUJ?=
 =?us-ascii?Q?wivkVr5tyhlSEhqCYnWIhFzwwXGjgOIt4TuxVqZCsDJDJUvTnH3MMsCl7Hno?=
 =?us-ascii?Q?i6seuvVxzg6htAFJB3szB+R737HHoJ7+vOCQ9UAD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OU13lqNopdZ/4hgG7v5xLiamO9xUJ9mVtgKMfQozVkKhLTCRez6et//n2cq+VE1+F+plogWkVJK7BgMmcBe52KmsEOPbWX4rQIYzSlcynqEVerCkx6bQJ8siVOzvc/zqWyOo/pWKHYYBuBixKmrGhlQzKBZrtccOdUbot+1Nk1Xq+YXgujm/ltB+aH8hszPKMFVRM1Jols1ZReopC+LK/gQoG3gzzGZ9kWev9WhZLRCxB85sHwW5Y20ajqcQIn/JliqTbvYN373IiB49kJZnif1H5l4mrzb5RgthQs0EGHoLdjQiMOpHAOCWB4OWr3rm7gWkfMySa+xNPnxNHIAmrhYM1hS8QLAfCj10knTaMa6D/+zNsLuCphQV9PXEn+gI2cuYyGbAEqgEYkiipeT8qzBWK4cRAGDIvqk/hLND7lknwK52eyUBPUXyu3++mqRn5t1Ua0KfR6o+KHDXo65KTeO3fww2IuXjEvySZBPxWYFZeGY/EiauBKJTE4XFZOWIKHE9HxER8HNAE1J9TUClfcphYkpsPMh1PfPKlVicmum0kxpfqotubY4oAKaF0vQ70PR+3fasL1bekWPDUglJRRp3kT0jdL/8+DRBMNOQ1dE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27bc2e4-c53d-41a1-eb90-08dca69c12f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:24.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTyE1rSR2WX2ugtLGbkscImFa+GoWakwaJ+2eqDlwZHGNps68iGfR8B6KVDc/Jr0vX/5X8thCuB/sF4fWdzjNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-ORIG-GUID: xuuZ5_ra5CKDlYTId5vGajqy8BfQ9eIO
X-Proofpoint-GUID: xuuZ5_ra5CKDlYTId5vGajqy8BfQ9eIO

Use a structure to pass along all the necessary information and counters
involved in removing vmas from the mm_struct.

Update vmi_ function names to vms_ to indicate the first argument
type change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |  16 ++++++
 mm/mmap.c     | 138 ++++++++++++++++++++++++++------------------------
 2 files changed, 89 insertions(+), 65 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..9d0f4d1bebba 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1481,6 +1481,22 @@ struct vma_prepare {
 	struct vm_area_struct *remove2;
 };
 
+/*
+ * vma munmap operation
+ */
+struct vma_munmap_struct {
+	struct vma_iterator *vmi;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct list_head *uf;		/* Userfaultfd list_head */
+	unsigned long start;		/* Aligned start addr (inclusive) */
+	unsigned long end;		/* Aligned end addr (exclusive) */
+	int vma_count;			/* Number of vmas that will be removed */
+	unsigned long nr_pages;		/* Number of pages being removed */
+	unsigned long locked_vm;	/* Number of locked pages */
+	bool unlock;			/* Unlock after the munmap */
+};
+
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 0d03fcf2ac0b..1ed0720c38c5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -500,6 +500,31 @@ static inline void init_vma_prep(struct vma_prepare *vp,
 	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
 }
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	vms->mm = vma->vm_mm;
+	vms->start = start;
+	vms->end = end;
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = 0;
+}
 
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to altering
@@ -2603,81 +2628,63 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 }
 
 /*
- * vmi_complete_munmap_vmas() - Finish the munmap() operation
- * @vmi: The vma iterator
- * @vma: The first vma to be munmapped
- * @mm: The mm struct
- * @start: The start address
- * @end: The end address
- * @unlock: Unlock the mm or not
- * @mas_detach: them maple state of the detached vma maple tree
- * @locked_vm: The locked_vm count in the detached vmas
+ * vms_complete_munmap_vmas() - Finish the munmap() operation
+ * @vms: The vma munmap struct
+ * @mas_detach: The maple state of the detached vmas
  *
- * This function updates the mm_struct, unmaps the region, frees the resources
+ * This updates the mm_struct, unmaps the region, frees the resources
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-static void
-vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct mm_struct *mm, unsigned long start,
-		unsigned long end, bool unlock, struct ma_state *mas_detach,
-		unsigned long locked_vm)
+
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *prev, *next;
-	int count;
+	struct mm_struct *mm;
 
-	count = mas_detach->index + 1;
-	mm->map_count -= count;
-	mm->locked_vm -= locked_vm;
-	if (unlock)
+	mm = vms->mm;
+	mm->map_count -= vms->vma_count;
+	mm->locked_vm -= vms->locked_vm;
+	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
+	prev = vma_iter_prev_range(vms->vmi);
+	next = vma_next(vms->vmi);
 	if (next)
-		vma_iter_prev_range(vmi);
+		vma_iter_prev_range(vms->vmi);
 
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
+	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
+		     vms->vma_count, !vms->unlock);
 	/* Statistics and freeing VMAs */
 	mas_set(mas_detach, 0);
 	remove_mt(mm, mas_detach);
 	validate_mm(mm);
-	if (unlock)
+	if (vms->unlock)
 		mmap_read_unlock(mm);
 
 	__mt_destroy(mas_detach->tree);
 }
 
 /*
- * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
  * and marking the vmas as isolated.
  *
- * @vmi: The vma iterator
- * @vma: The starting vm_area_struct
- * @mm: The mm_struct
- * @start: The aligned start address to munmap.
- * @end: The aligned end address to munmap.
- * @uf: The userfaultfd list_head
+ * @vms: The vma munmap struct
  * @mas_detach: The maple state tracking the detached tree
- * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
  * Return: 0 on success
  */
-static int
-vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf,
-		    struct ma_state *mas_detach, unsigned long *locked_vm)
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
-	int count = 0;
 	int error = -ENOMEM;
 
 	/*
@@ -2689,17 +2696,18 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 
 	/* Does it split the first one? */
-	if (start > vma->vm_start) {
+	if (vms->start > vms->vma->vm_start) {
 
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
-		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
+		if (vms->end < vms->vma->vm_end &&
+		    vms->mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(vmi, vma, start, 1);
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
 	}
@@ -2708,25 +2716,25 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vma;
+	next = vms->vma;
 	do {
 		/* Does it split the end? */
-		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
+		if (next->vm_end > vms->end) {
+			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(mas_detach, count++);
+		mas_set(mas_detach, vms->vma_count++);
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			*locked_vm += vma_pages(next);
+			vms->locked_vm += vma_pages(next);
 
-		if (unlikely(uf)) {
+		if (unlikely(vms->uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
@@ -2736,16 +2744,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			error = userfaultfd_unmap_prep(next, start, end, uf);
+			error = userfaultfd_unmap_prep(next, vms->start,
+						       vms->end, vms->uf);
 
 			if (error)
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-		BUG_ON(next->vm_start < start);
-		BUG_ON(next->vm_start > end);
+		BUG_ON(next->vm_start < vms->start);
+		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*vmi, next, end);
+	} for_each_vma_range(*(vms->vmi), next, vms->end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -2754,21 +2763,21 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
-		vma_iter_set(vmi, start);
+		vma_iter_set(vms->vmi, vms->start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, count - 1);
-		for_each_vma_range(*vmi, vma_mas, end) {
+		vma_test = mas_find(&test, vms->vma_count - 1);
+		for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, count - 1);
+			vma_test = mas_next(&test, vms->vma_count - 1);
 		}
 		rcu_read_unlock();
-		BUG_ON(count != test_count);
+		BUG_ON(vms->vma_count != test_count);
 	}
 #endif
 
-	while (vma_iter_addr(vmi) > start)
-		vma_iter_prev_range(vmi);
+	while (vma_iter_addr(vms->vmi) > vms->start)
+		vma_iter_prev_range(vms->vmi);
 
 	return 0;
 
@@ -2804,11 +2813,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_on_stack(mt_detach);
+	struct vma_munmap_struct vms;
 	int error;
-	unsigned long locked_vm = 0;
 
-	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
-				       &mas_detach, &locked_vm);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
 
@@ -2817,8 +2826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
-				 locked_vm);
+	vms_complete_munmap_vmas(&vms, &mas_detach);
 	return 0;
 
 clear_tree_failed:
-- 
2.43.0


