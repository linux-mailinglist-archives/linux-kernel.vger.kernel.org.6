Return-Path: <linux-kernel+bounces-249353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FCB92EA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A93D1F230D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CA3161B43;
	Thu, 11 Jul 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBelhbfr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G20MUZiH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB615AD99
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707429; cv=fail; b=hiQZCgaUBbr17PhpJHiCBxC9wL2xYbB3JxKTNYeFN4EO7WB+S+pG324HCvK2400F1YwL5M7hp3c/DaQy3V4QncUB4+vnAa+z1N84i3V90g13lOKpPxBspLTYb59iZQi4+UbZYvi80f9Wljld2SpDbxgYl5h688WTMkF5Zrk45ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707429; c=relaxed/simple;
	bh=LyMlPV4uIQ/rIJwg8Mg0XQCRpFVoJdtMnfbN30Eu2mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KMbXj4NNZ26MTka2cOQq9YqfZ10EaNjeqZ0E+q7/FWQJgJP2zcw93EtlJTuNT7mk7p4tBAOI69c/s4kkt2/qtA125rPJ9imfZeV+Gh226bGgYNiK8XOKlJ4BEpTbzvZ7QafuyUOj1pZ0aisIA/u+BVifxzUkOYZdYZZjo2Ctrpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hBelhbfr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G20MUZiH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tVui014047;
	Thu, 11 Jul 2024 14:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=9nAhPUd8miu52uM
	fuS9Qqx7LRT41kV5obhPLuTf3nVk=; b=hBelhbfryYMJj4hwDNKOeWgcaGN//am
	8z0Lc771fFrT4zTYH3ag499qwC4KrbNuqqxMzSGuqnHIbcgmpgQbt0+FMzUW8jeK
	SK/Z5HtVbYolHwVaA2SnGQRUsZ+A3cjKZO72Ve1iQqVOmUbUwIgUp4SDtp3kAudt
	bLakZN1V113TcCm3nwcML1A8XxE9OfcdGinqPFsu560G6gWYsL3dD91osdauX26r
	P7ZSe5xPPQL+t1febtvbYascoX2m36sKAtgTEb32ubTqoYpUH+jcZmPluvGB6wqd
	zwdH9aQub/frdKf5rVopERuYnDB5/vL/1bZFvfDrX9BrhyThVhG0iJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkchn3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 14:16:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BDH9sA010978;
	Thu, 11 Jul 2024 14:16:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5tc2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 14:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAbihLNhfMb9EMWqt0/DoO2VpPXZloZQtZu4cGosXsuck1KT72nEGIwDp0WnhJyws7aXb77VIeW43KD4A7xi4raWXfVLHh6/xd0ft/dZ44ild0XfURxd7++VzVUjO0oLdsyPSov1x5YjT008PVQAHIhUnRENyJFc9y0z1QdCOrKzbp3Ot+2BmViIrekksOJaLElnm8EC5YbrObIqxOrJvolhjqmQyj9KvfiRcxoDIHHgoUZjvQ4wopu8Pmb0yFhrFpoQeck2p3BhFDaientND85LTCSycRMyoUGR0yeNTeX14nEHISQR0HWVl5cnX6u9aznMvPTSaJAIGUzP3kbtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nAhPUd8miu52uMfuS9Qqx7LRT41kV5obhPLuTf3nVk=;
 b=PhWkOwzhREIrhas6gP3pcNxeJa/8KCjLrRK1lgvAA0WnJwdqrEfB+u70Xw4CQNGJCUbnCUqzzTbqp2rFHz7L7tvIj/Oj2TeX5ZvbnZ/yaUdNcAuzgEbT7VToLuoypngN5gjnnz9ckMFFkmfEdFAEfnzbqHOir8ripUunUWDgD3fB/uGcPKBzet7gEZq+FNUEH1oY4Hdmub4WjWOF/eBvKpuYfBLsjEw1gHKDppFCAPkpqgjrUH8KKMmUo9l3/X98FEARIk9KbWqLs3WRXYdYa6eHq6PBgsHV+lXT3j9yw4rZJ5DRji5YEmqhUxHgc6DRxHmgSKy2eSwW9xVbeqcKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nAhPUd8miu52uMfuS9Qqx7LRT41kV5obhPLuTf3nVk=;
 b=G20MUZiHDHMhh1rPMyrzi/2ray3sLOicUSXKqkAM0by1GhMo2u8qXj+PQKH/G7NLTd4tnEtKxKSg09yVCOJNFcUDsJefLKBVEpzez8wirvKu1JDTTLnMYJfZ2rD1Q9Bfb8bRLq6R10qF2zdYHAcFlGmxv7y3ZIesfEZ9ERZoHA4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6865.namprd10.prod.outlook.com (2603:10b6:208:435::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 14:16:40 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 14:16:40 +0000
Date: Thu, 11 Jul 2024 15:16:35 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 09/21] mm/mmap: Expand mmap_region() munmap call
Message-ID: <362d3286-07d3-43c7-84f6-1dfb6c2bbae6@lucifer.local>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
 <20240710192250.4114783-10-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710192250.4114783-10-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO2P265CA0468.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::24) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8f2d9d-5f8c-4136-f73e-08dca1b41514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SoC0rjJZo2D8E2S471DM/8/VlLnkFs9Rm/Twxq26OZszYiQC+GlPpE3D0NpV?=
 =?us-ascii?Q?5GteyWmmzIlLH6ZaYf9P8XwTn8FpgRe4XlQHTN/MHoCXJ0QSUJkOo2WHBaEU?=
 =?us-ascii?Q?uKMnpPuU6WHtNmRuFTACLMuyHpnFxVriLTeoddwMIyomifI9gMgNb/moQS94?=
 =?us-ascii?Q?09pB1zTtEsXRauk3zdc7pRURUhEUSJDADt0OLx4Zgov7ju2DQf1dsYTR32Ot?=
 =?us-ascii?Q?5v4R6EKETwY7ql7wpY+URQ8b54aizg9ihN8AHTXZgESArlaAdM8mqFUa57KP?=
 =?us-ascii?Q?2KIAHt29fmv3dgY7ggnndiNu/4vhsJ+v5NBgZIn9I0iXeth1+7v2rUeKlUGJ?=
 =?us-ascii?Q?tUdWdokHEelek1i5zpy36SJ8dkO6T3bgctYwt6Q6uibBoA21Q05gWEnyn81z?=
 =?us-ascii?Q?CjI4K2lypW+Kc56XCQabwAy56jG8p155lGyk79hyTh0DNU7sLOE9F3lTF36Z?=
 =?us-ascii?Q?x4Bua2sQHmfIoYEzA5urPq7rYal0lx2ryTSUUu04naIqvg5AmILy9CJKGRrW?=
 =?us-ascii?Q?mQTvZNL0/oC/umGIvhWASi0QlyioCUhw605dsci9fwzQe/MiQwHWKOtyo61x?=
 =?us-ascii?Q?/CaxigadQGgr+4o3CfsaEmncxZnBUfoCWLmyjbeg+NhccmIX4yWJ5Z+pTKvI?=
 =?us-ascii?Q?+1hVJLxshe7FWkOkGF3s0Hgt0v9QBz48Yhy9Y0Eilj6suATXpq76nLL+0bSw?=
 =?us-ascii?Q?h3f8Wa4sghH4zyIHVcIEIvHIZKhNWeTamJJ9Mjou4H3vqS8IPzRfs9jzZZkV?=
 =?us-ascii?Q?ELA+36Is5pBH6AfWl3x3Z8VoLMTvDlRYX8NzUcz+r8V35FVta4vo47t9lgZm?=
 =?us-ascii?Q?escqnnEOkyFJUQL5bFRJSwOqD01ImFR3Us0iLCleyIQRuLicnQeCOacmtwlF?=
 =?us-ascii?Q?3dPXGAYiGvXdovf0QME1HfAF5DsAiR4R2f62IPy/zbsvEhVR7AF9+zQfMge+?=
 =?us-ascii?Q?9Lei+9E1jjOwWJK3k59xwRaiifuVZYMnhn+44V/f8LlLmPmC3/1yubbc8SrU?=
 =?us-ascii?Q?d2HcfNVUDqraFr9JnfY879VlCs694XorrblzZVI6cPuqYOREUZf/gVEqIBSJ?=
 =?us-ascii?Q?+CP9VHcqD9RcW3J/MSfth+j+QYkPS6acu7ajOZqLvhachDjQgfm6pLdR9TpE?=
 =?us-ascii?Q?rb8sIea4wsEHx+EtYgYw5RyM+u19pLrrRPsTLi/0LS9RO6eAqIhmIIR59Z1a?=
 =?us-ascii?Q?cvtT5SuG7tZ+GkI23l4VICJxpdFu5w0GI+Lp2gUNKkSQH6jxQGs0Jfdh1Yr+?=
 =?us-ascii?Q?Jp0kJqzQ1Xy7csH9aOrjRkFiwMTXjYPZ/Uz5zh09Zhd69QAxlSbn/KqaEzvM?=
 =?us-ascii?Q?nJrMS5tqyBP+hsIGQJDUfg6w5sAVcfZkHkVKMciWuD0+Zw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6Pby5b2UkKSKIGQCIwpskfB74C2haLdDTTGA5kYi0X5qqKuKXwG4PmeH1+FT?=
 =?us-ascii?Q?++kuo111XshhAK021ef7hK6oxnRF02ZaXaRAq9f/0VuoBzucWM80R3FDXCF2?=
 =?us-ascii?Q?C5l8l1bMsiumDql6b9UetRROefVbsqHtO4Lep455M2DCHIiW5LyFXBdPgEQn?=
 =?us-ascii?Q?G6ymAE53+O7DNQcbzwIJauVzslLQT82Fcfn8/ZZF+CAD4hUQTWGaC3TqpyeJ?=
 =?us-ascii?Q?jZ+MsKinQ/Svz1T9PX+l7j2PPKlxCSfurZl69ti48GK+YdeiYo15IbO+A65r?=
 =?us-ascii?Q?xYhk6x/b0dYG8iUtu4HJjOT6N9UpSnDowACsJASoCx8Mcbk63g3N5SUqQOmA?=
 =?us-ascii?Q?ljsk6nvb0KamHURaOMY840lIEDCZZpfJwOcx4Cy2VsdkPAIliRyLyadV3Jb/?=
 =?us-ascii?Q?3UfbGORcylROpU7LwBMGiV3COE+eczjQCg9YguS4iyHg7/L0cx70GYGn0/mf?=
 =?us-ascii?Q?+kjTy9D3OKPDEdNdD1qAmUePOWDy+pW/uqR8ezNNqanok5aVq4S47ebcWQRa?=
 =?us-ascii?Q?IRwOSK3zY6aiCcO20kk5z4xL9A9+zC8qTmGIC+yfyAoyRZ/5ezAj7tfHLR0A?=
 =?us-ascii?Q?46K7cRrFGWez9Rg/YmQC8dIRCKHxmqyj7+HwFtaasnYdJx75BEe2zBBZ6561?=
 =?us-ascii?Q?/1LeiaRKWSsExY7pC4CQSYzAc/+WH8ETUagJe6ATrRiLLhyoYyRXO6QZTMjl?=
 =?us-ascii?Q?ylXUhE7zzaU9E8KtOdaFqTjwSMwVmEXmd/ASOt9RgHZHk5AdLmUVDd5sCffL?=
 =?us-ascii?Q?zZCB98/1qvwqIkcy9DCsjcFkV/yeXUvTqELKHXuWupz+0c3st1SOzis59dHX?=
 =?us-ascii?Q?46dPF9xwIv5yPKt7UHUUxzyf+1IxXGWrQSFEKSy4oKQZuqIH6mkVgy/jRu2S?=
 =?us-ascii?Q?LV7WP3MATObDqJ32Tz5umFiorKpJJmyE6C3C78guHhqU9cQ2H/y1p+54o4dC?=
 =?us-ascii?Q?y1iY4cuJK6Py7IBZj5RJywAKMHntJz1aMX6nGm41ou0/APNxFxNZH6gU6moS?=
 =?us-ascii?Q?xXz27Y+APzpMyPHxaCQTAiSl8PzgKMJQcne/+D0E0FIPxtBYvwbQGBKGCn3N?=
 =?us-ascii?Q?xuEEEVN8uY5rIRM4Kks6A9HprjHWM0KX8LPFJmzM5+yKOM9m1xwndU1WdpO+?=
 =?us-ascii?Q?f+CqESi8ZdYUhKXKLccgcVDB6wT6iTM5Da8BdKHm1INEViq/7ddMHMpRrSFu?=
 =?us-ascii?Q?NqT8s+qD57IsfPJwHpAf3BF/PZzUOsJOfC/r99q8WnRtPekKeVU2OJ57q4uh?=
 =?us-ascii?Q?eexk54Ihv/tY4SBbMZZOZi739+LPuoaCs1mcjzACqbQD2ZVLtF3zqZDD/oFV?=
 =?us-ascii?Q?RxqHEpjhhyKg2ENx1syriGLdShYqeQBs8tyoZac2lt1AedbQk5TxLcSiGDGH?=
 =?us-ascii?Q?nZdQLJOtyxC646d1PxC7294sqqgKxpNHtkQ+5wmC3oO422RdQml7dAtfHKDZ?=
 =?us-ascii?Q?p5U7MPQTWwjUET8LfuyQDV7ZI3Xwu/3utEUUZB9AIUObcWvXLiHy3sYk2rIk?=
 =?us-ascii?Q?gHivnqaA2A1rzS5NffBjZdw3/COSz2KMpcokvaEOxynhHN3OT2atXdbclM0/?=
 =?us-ascii?Q?2Tq+cPdvo2irVKEwkIXKkCCdIJXFKSDVrXpTmLOiV5J1nSM0rNK/Ui5XAkQC?=
 =?us-ascii?Q?cgOM/qTUKtV3tWk+e0QTMp/asLPv2WZ8KW/NAhuicxDsm0z9zItSCv9HQ6jv?=
 =?us-ascii?Q?w6+2tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	as+uVF7joq+sG6lQxsn00OWz8QgAk6FAtmnksfiqizigOFen+ucBnxCErRKEnkbVXCUUJoIM29337oUWy+5gh8t6qrbHazqlxUF6BCi4I4DH9U1qhS+16KUWQKIa1RoWbL06S2cksRsPBs2dW+YdzBAIr/gOLAULTUy37AFZXvoh/ztXrOyTuT9G46mOZTCEiRCvsopCLXR/K+MqHuXeV2vx1a/B1XyRo9PFKApUjQLWuuAAtVowt/W8599TNor0q4UTNZNk83F2YH3m+ug7e/OA/VoXGqPRJEpbwT3woINuYvzk6Q9byibL8ELX1ZQZC41Nn8TGmab5BwQI9Qk14EdEQ+Z8gxGmuJOuC6oQrqOnb5BBi7xRe4l9VdGe9JPurTJpoYDbc/MXY6nh13Cm8QPG2NtbaBnZzt6NfZoWaIkGVLQ+3Z5bH8yBb+9QIevAH7R9H9hocArmkGEZps/lEqoRs94MqEIXO/cJK7tEy7y77PuvU5GZcTWirgfmkB4ojxuN8p3HT8iZfkYo6Ykjq8nKDf1G9aMxxZnHiyA8AXmdTFRRgRFDfUPVEbzN16lAvURTI9dtxf5FmQQ74Xd4EDfxfew5ywL9e4jSgCZoXZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8f2d9d-5f8c-4136-f73e-08dca1b41514
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:16:40.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfLbyeDF2wA6XR14iEZz85xv7xhIyVVh58XDGVIisSpSTdcf+mcJL5VXZAmSA32v3PG7Ifrm6Enk6/OUCklVSPWA6twR8zV49yzED7mkY7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110102
X-Proofpoint-ORIG-GUID: snfDLU1K-5KeGqv808AnHDglOR8tpyjP
X-Proofpoint-GUID: snfDLU1K-5KeGqv808AnHDglOR8tpyjP

On Wed, Jul 10, 2024 at 03:22:38PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Open code the do_vmi_align_munmap() call so that it can be broken up
> later in the series.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 49b3ab406353..a1544a68558e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2916,6 +2916,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	struct vm_area_struct *next, *prev, *merge;
>  	pgoff_t pglen = len >> PAGE_SHIFT;
>  	unsigned long charged = 0;
> +	struct vma_munmap_struct vms;
> +	struct ma_state mas_detach;
> +	struct maple_tree mt_detach;
>  	unsigned long end = addr + len;
>  	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
> @@ -2948,10 +2951,27 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(&vmi, end);
>  	if (vma) {
> -		/* Unmap any existing mapping in the area */
> -		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
> +		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> +		mt_on_stack(mt_detach);
> +		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> +		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> +		/* Prepare to unmap any existing mapping in the area */
> +		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> +			return -ENOMEM;
> +
> +		/* Remove any existing mappings from the vma tree */
> +		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
>  			return -ENOMEM;
> +
> +		/* Unmap any existing mapping in the area */
> +		vms_complete_munmap_vmas(&vms, &mas_detach);
> +		next = vms.next;
> +		prev = vms.prev;
> +		vma_prev(&vmi);
>  		vma = NULL;
> +	} else {
> +		next = vma_next(&vmi);
> +		prev = vma_prev(&vmi);
>  	}
>
>  	/*
> @@ -2964,8 +2984,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vm_flags |= VM_ACCOUNT;
>  	}
>
> -	next = vma_next(&vmi);
> -	prev = vma_prev(&vmi);
>  	if (vm_flags & VM_SPECIAL) {
>  		if (prev)
>  			vma_iter_next_range(&vmi);
> --
> 2.43.0
>

LGTM

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

