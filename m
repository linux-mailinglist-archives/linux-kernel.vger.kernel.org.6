Return-Path: <linux-kernel+bounces-246079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89892BD5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1500B24790
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF1619CCE8;
	Tue,  9 Jul 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NI2KEith";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nPIeWbPi"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBA15B98F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536375; cv=fail; b=NPerWCn3k96xG6mczChhRbP0KpF1GwYt7QCfy8w2IVtgWD5oMEUSDO0Ru+veczh84tG109V8xoduDE7Dd8iTwSRrwKi61mrqyZlaTqs77PGYFuIe5ZPAlBkba+mHzLKRVCzZSOo2DWHri4mXrNyVgLnp227iUdXfB81kp/8m2mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536375; c=relaxed/simple;
	bh=STeg/HbNCPTsBo0lRkJFR5wmGmna9LGuXKREzaAIrDo=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OFG6UJWUqU3lvPMYh1Y1Ws45CqUPLmswIomISy8UDtnpTTso1kNkau6h8F/MDg+Z0KX6uZj/IjkVAfaEzJf+PHuGpvwWoKdhTPvgV+5n6rq+BWasBJTPmX+hWcaYDH1wqBtbbOZRIq0GG6GVQYqJ2rqrKdA7xgL1WJcvo188W0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NI2KEith; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nPIeWbPi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT3Mj022030;
	Tue, 9 Jul 2024 14:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=jGz1fktgmIS0skw
	rm6YZ27urrNJWy3lGOlTTP9Jlw74=; b=NI2KEithYDo3vZFjo3yeEc6phZb2ltp
	9GSzWs1RF8TV885Kp2Q4bOioDyKf25sD2DAUsXZCpfEF6mppHWtqh0dkZwwIg8Jx
	B4X/uJlzMDx+6O2iZo9YWCMaGwxMOV4lpV+04L+fNTGLfeFhu+7ooqJtRH13Vz+R
	Q2xPbrWVfzEyxJKUao3IupQd9Cyoo5aVopNP1PVwluMssHGIgD9Wmol/qz/vDZ+/
	mC9Rm84yssxHUP48YSCzfhO3KNPcLjRDUXLAM6ckXA2efkEFPTFFgJxSFOIJse0t
	OeCf29pPibWsTleFFxQUrsvupX+wrRb2hZTXDDVpHOohFyP8+6qc+QA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknn4a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:45:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469Eb3gL005764;
	Tue, 9 Jul 2024 14:45:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx2tws1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ/z6txV6iKAOtKNGX8HNtLJzw317KCsH3+ijBjXLc6foUWDCSg7U+ePUkOKzcZczg9e2CKpatiglV/gYcKG0L/obzU+jvUdUaAP0iPjAiXIpv+cbUDmEPwv3Vpg6fqiLrFb56reJpp0eeGskHbxXgvudUcC6J07qmg1uwqI7Q+KEXxBUk0a3MdT7ERFYxJwFPb+R8DIcEU8zXW00t2u8UErTjh0V6aX+8EZB4nN+CHGv5i+sZjGYtRXompvBYojK1tc+5SabXeO1tkcLOb+8V5Dl5ZRh1HcTiWLKZE/Ecx21yP25UCRd7zBEt0mIUEI8uTxcdWjtWBfUefur4JJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGz1fktgmIS0skwrm6YZ27urrNJWy3lGOlTTP9Jlw74=;
 b=KN6k2j7gTsgpLSeaFQaceIOgb1hDkFtJBCyjQTd9UIeWHmaBwT3fk/m0TI+zRMW+W9iIiPhcyWvHChZBxajj8/CiWwVGKaBURGdBnGfIwmaOIsEDM1A3XwVl2T6qzSWTdGqaNZF+ICdatWeZD7Iel2NH3GUrrPgHP+YsyT1lt070H0VxZc4K7wCN/2FHV38APBLzSVgf+qvRFBn8ACUR2cijOIV12hEHuthYKrh+XJ/mzIdgiLDTOnDLrMZzCrZ0btk2czeKpS+M/31QXLabBKY/mwlscgnZyTixbCBsIs/6nbAgKnG1xNm2KY10Iy8LrPkWZGxSGJUNDmWRang4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGz1fktgmIS0skwrm6YZ27urrNJWy3lGOlTTP9Jlw74=;
 b=nPIeWbPiR+8j4GYVURtWHoDsAOhitGXILJufIbrjQJXfocDz3/p+Hx141qjNXYJLp2HhrbEr+MWtwEKenIbtjFwIjdO6xtY98OB31unkCxC4aglCUzFVUes5Xy3jtek5q0FTc400mXLP1LBgi9fevzGu4XZqfZRM36VwL+Z6FPA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.38; Tue, 9 Jul
 2024 14:45:53 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:45:53 +0000
Date: Tue, 9 Jul 2024 15:45:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 16/16] mm/mmap: Move may_expand_vm() check in
 mmap_region()
Message-ID: <0998f05b-9d5f-4b24-9030-22421e1dd859@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-17-Liam.Howlett@oracle.com>
 <8fbb424d-a781-4e61-af7a-904e281eba8c@lucifer.local>
 <e5ldsusdn3som7wn2rw76wtrhnlrxk3vkyk3iyimh6qv3ptvwu@24zfmamllev6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ldsusdn3som7wn2rw76wtrhnlrxk3vkyk3iyimh6qv3ptvwu@24zfmamllev6>
X-ClientProxiedBy: LO2P265CA0480.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::36) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: bed6e7bb-8209-4577-862f-08dca025d525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gfCuIg8Wa/6gqWQMbeHz+CxGXelmVW5FtjW+H3tk3RJ6GmH9kd0J71M1bxkP?=
 =?us-ascii?Q?V4Y5HSgCljZEldAMIrIr6bBvWhjnW7yCJCC5fDzY4wl/U0lC0XHxO33MVd4A?=
 =?us-ascii?Q?wDL5cmygojwrwY9SFssngDoBxFqIXZHxLAwJZYc5IYNMV+0Xuc563LKnDNMY?=
 =?us-ascii?Q?zhbh0QZx8ZYB7hNEjNaqE8ZfqDziPoBHZuDMRM+LacpI8y0APn0c+yolk7sd?=
 =?us-ascii?Q?TxPF8uY2C1wKMuq0keG4Dfha1U5Le2OI2sBWc4ED0A1wMumF7mQk6oN5x3Wb?=
 =?us-ascii?Q?czyp/SmXGZu3VAg3FR4njTWHhCHpb6gy0FxnNlzsk7fXnQkzp7Ak9yVmGSM9?=
 =?us-ascii?Q?rsdHIT0iQDCRiFy12wE6gXRzhb3HwrdVCjdou7rUIYClDocEjUFWBqzbfbUb?=
 =?us-ascii?Q?RYmkPsW88ALKs87ogQzIFl/BPlrd3xIr4gCLFq5+uC35kepDFjkNYhJAUWmQ?=
 =?us-ascii?Q?zSSNR6o5iiICeOQoMx/l7zOBVVgea7cP4DkahWrs2c+lheHhDKO84b5vZ3sY?=
 =?us-ascii?Q?9OEtMZu2BQit4nLwMVJPp/9PX1O8AlHddfmpheA4g6eId3zbsMkleJyMrCAs?=
 =?us-ascii?Q?LJGJMNI5ZM39vjyJSUPsW97f6OI7gaCHTFG5q+Qp6i6g3IRrmZs/fF46GVG6?=
 =?us-ascii?Q?dt4U/8Uu+l7TqcnGuOulq6/gS2/vu89j4voUIxO8Uu6HxqJ88GPrBjBT+VJ1?=
 =?us-ascii?Q?BpUtlPJNG7D2jcHplJkBASPYl4HwGrqXxY8RfZnbhdDTkVsvShIbm4HNCYqe?=
 =?us-ascii?Q?0WSRwxgvf1gU8rn78HBL81DQogVlHsH5JMqDe7KibogatELq1DNKpRqdsyDU?=
 =?us-ascii?Q?4jY190t+BkqZpwQak9THTL7LpF/mY2bexq9DRgL42pWViBp5k8XFezRq7Fnh?=
 =?us-ascii?Q?fEixvm1zbjs1SaRNXUnB0y4GRrExkDkxRjFdcUrEINtnQJ2qzPXPIwKGlaJl?=
 =?us-ascii?Q?bQF+pb+q9umMzehPhhZhE9LAIOsaJrx3898SKE9F4Ez0Cbc2Zoef3h3z7gxO?=
 =?us-ascii?Q?XRsqRCv0XxsVKSvNIr6RiAeRg4FkDO4WeI8rq8Enkg9/oDt2TW+9ClY8xWnI?=
 =?us-ascii?Q?QrrOupkGJK2J33M5he2DQozzOlmhxn3nkqq27vnQhy6LanuXbHtjgab3/UAA?=
 =?us-ascii?Q?0hhx2gdCDqsIIHVyVYeC6RK6AB17OUaVE5Urx6KeheRjPaVc6hlJ20AkiTQE?=
 =?us-ascii?Q?idGTJyniNj8PIcz5hTwj+m4k+Z/97E9f8Hg7ZVc+YOaNOGaxSIZSfbsILb/L?=
 =?us-ascii?Q?Wi1frXr6okjKKsapPZ5Z8D+c4Yq4oALIty2ud2/KKGuik8g10E4DKxm49PaP?=
 =?us-ascii?Q?Prp61bffzW+hxZgybnyzsBcA9Ttv2np9DiJlC/M+qdWKPg5YLKZzHy+ZK11m?=
 =?us-ascii?Q?lAVMiKE3tklpKXZgIvHI5WGxOLDo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K0JXFq+2F+T8R62efZ0IQ/iFhXaOi6rYXTyMrv2uPoW8xOlS+259RaTn8AgM?=
 =?us-ascii?Q?DKLrH4+gFtYlAVcXK3khCuZNEOpUs86GoG3UJ+Et8be2B+1qsFNKt/6Ub06V?=
 =?us-ascii?Q?W2Wab7yQbSYBwQGFoGR+w++dlufqrHiId262jaM+SK+q6PaHyXhs/gid6ChD?=
 =?us-ascii?Q?YfNNNSSAfk2rAZX9DgEEdsmnfv9oju4QtTnsS3D0ZJlzs+PlkO9rBgiQBOFO?=
 =?us-ascii?Q?Ch4wxd/6nC7xh7x3U0tyQbMHQDvvRBT9EGU8+TGxpwl0J/ZHHa6kD+z/p6Bn?=
 =?us-ascii?Q?6xgLhXx0hga1ctHpX2icYDzToMJOC/u0KE/5q8eJHEZMX3t3PUy9A4DHBm+Y?=
 =?us-ascii?Q?9nQcgzr+WXxLl7xpE7IgOZy+Km5adfIS8qHFre1mzIjSDi42kqgAHtil7yDL?=
 =?us-ascii?Q?VTysdLppxfZYOb6O85fMnkxp7lykQPhOI9d9aHDdHn4PitKjUHzMnghSMKEx?=
 =?us-ascii?Q?ZY/fXNPuKrDMX4FSAdfHu/d3RYlDNpAjhIX7t5n0/csoWOnkOIAljt9bFHoT?=
 =?us-ascii?Q?vZ2k/Ip3+ZOIOwkfSSCGDy3EajbbehX9qr+m9RP40QWuvTOGoIfksr2HuONY?=
 =?us-ascii?Q?79cJiz14QVjHXE0KjtJxRBEYZbkninE0C++6bykLR7ksavnd8YBS54FjUgTz?=
 =?us-ascii?Q?OyFHy9O3nmtK869FVylLeOEU3G+kT+JWWnYH+MM1Tuc3YK0RR+FbgPNfbrS2?=
 =?us-ascii?Q?7qNLhxANx+LgFyATvjvtvJZuGCKbVFqnV54L9qaIz30/5glJpbpSdjslwBdp?=
 =?us-ascii?Q?RospHyK+H/n0+6a3ZwAfV1MsSj+4JrCYMcqhutVfFQ3NUFMygIvbj1iR2RXS?=
 =?us-ascii?Q?XEW1nkuNA3f3mirzsdtY+qo8ZJKXgWrS30mi9laIv51rfMUSzIfTOFHDiWyo?=
 =?us-ascii?Q?cWr8GPI4uLgti/LRJAvpCEEwym7UAP4a3RzLWIoFyGpI4anTpObaSs2XfetN?=
 =?us-ascii?Q?cM4nOYyFx18NkTbXY98W8d+YAwgBdjjWr4CLs/8kLv0X38kyapOojMzeL44I?=
 =?us-ascii?Q?eegNhWUL9c6kreddUH1XFS7xL1O75vG3WCEFTqEdbA5rMGVEpIeTDraOkaS0?=
 =?us-ascii?Q?Y0cMkS8qMylHzDKvRMIjrxCtJLhes7C5uE0wLfTRFNPkDr615n/EYVBZIGlZ?=
 =?us-ascii?Q?XK4xi2Yrz9Mxlg2shCGspxfGXXkydrHVQhHItNI0GhWSkmr2j9WKDAptW86Y?=
 =?us-ascii?Q?kuGxc7v2yiIU4Xb+DGDm0mUhqfEEvSFdpZybbNolK5zAyNy0VoMZHbCbPA3e?=
 =?us-ascii?Q?9Rs7f2ioy1wmhxC6l/Siw7p5Fc7rPcBp+SpJ9zBn7JnF7h37ob3gaqF+cx2Q?=
 =?us-ascii?Q?X2Xka5/k3MpCnU+5wA3wEGe4DsZK0DjGV3K+KtU2cCCqToUOJvm9Nz/8iOQa?=
 =?us-ascii?Q?lOkCHviu6VxUCOX2iwPljpXbYr3RT7VpL0K4diX25sghBA4L/KkIfdpS2H4u?=
 =?us-ascii?Q?YLoQ9BTWTnqShW9qEQLp+dJ7KkxAUnyLG0xazKX1sNKpxGsMWD9Pm4Q4ARky?=
 =?us-ascii?Q?cA9TXxSmb2KJGpKV7OE/qsJFW6Aw/fd5ExNaCMOn4Xub3TbpMF7jgFOnEaHB?=
 =?us-ascii?Q?41rKV+kXesqXFjHH9SxRgB79bl8CzYhp4EbU3v6CVcAQ1RONmWZdiSNXO6mn?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3L8+hxGNC9G/u8gW/+dZXxK2upVeqiSBfTTV03dL1a8rGaMFlOoRj45am/xfCiy/UwneIdA7lMQBoJStiFZ/AqPimwx4CPCEAicLpH7XbLTVuYOWeDbUMqZ3ujEvKUyxAGpdMxrt3hrnlzcBKxhZEhAzG/0cBHsIIK6OKZ3ZfVqOq7dg0RclDuLF3YtJSiJQI1jKIvjcZE0EOq3Th8+ElksZIADxO3xh3U13tZDJzGbC6la7Tksf7aSP+oE/XfoxLsq3nAIWC5K70nSGVMiqKali7yBOSfARRJs2cLyULHb1PQDuGclGUCS3WkpW4XfYlD2rR4KiH70AeK0MTFXhZoEVNoQVK+w4P2hyE7PRIa/uyEuHwhDY3rZXhLG4ft0jZm4gtgAtBpAjD9jjTitKWlZl9PDHVTFRv+mQsmrsOsnNiKk4wQSaBMUv2hS7vzWTcbyxXP30QJ+RZbHjgPQanlBQepU+WOaRqOztlihDNuO4KHVuxvJ6vNZTM6ct/SEoaloD4DoMHfMznUxuIT6pHHVNbFxZGBvILEA0UwpkZSYCYBNLZoq4KJRuprz6kHRxwAJse2yls0LMbWwSlQU5arbtH3B8IFQVuAbzYFZSYFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed6e7bb-8209-4577-862f-08dca025d525
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 14:45:53.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OKvFWZetCWqZt749I7zy+uCrB0Fv4QAnnDJkmeSBca6vB1IvVMDeYOv2Y9bhuhZgVB2SgSTQKk382E3O0PulsM1oIR2aERBoIV03vH38aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090096
X-Proofpoint-GUID: 2n5tTXYw2PlY1OuSf5dq-GqLuYkyivs-
X-Proofpoint-ORIG-GUID: 2n5tTXYw2PlY1OuSf5dq-GqLuYkyivs-

On Mon, Jul 08, 2024 at 04:43:15PM GMT, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240708 08:53]:
> > On Thu, Jul 04, 2024 at 02:27:18PM GMT, Liam R. Howlett wrote:
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > >
> > > The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
> > > call, so use it instead of looping over the vmas twice.
> >
> > Predictably indeed you removed the thing I commented on in the last patch
> > ;) but at least this time I predicted it! ;)
> >
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > ---
> > >  mm/mmap.c | 36 ++++--------------------------------
> > >  1 file changed, 4 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index b2de26683903..62edaabf3987 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -400,27 +400,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
> > >  		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
> > >  }
> > >
> > > -static unsigned long count_vma_pages_range(struct mm_struct *mm,
> > > -		unsigned long addr, unsigned long end,
> > > -		unsigned long *nr_accounted)
> > > -{
> > > -	VMA_ITERATOR(vmi, mm, addr);
> > > -	struct vm_area_struct *vma;
> > > -	unsigned long nr_pages = 0;
> > > -
> > > -	*nr_accounted = 0;
> > > -	for_each_vma_range(vmi, vma, end) {
> > > -		unsigned long vm_start = max(addr, vma->vm_start);
> > > -		unsigned long vm_end = min(end, vma->vm_end);
> > > -
> > > -		nr_pages += PHYS_PFN(vm_end - vm_start);
> > > -		if (vma->vm_flags & VM_ACCOUNT)
> > > -			*nr_accounted += PHYS_PFN(vm_end - vm_start);
> > > -	}
> > > -
> > > -	return nr_pages;
> > > -}
> > > -
> > >  static void __vma_link_file(struct vm_area_struct *vma,
> > >  			    struct address_space *mapping)
> > >  {
> > > @@ -2946,17 +2925,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	pgoff_t vm_pgoff;
> > >  	int error = -ENOMEM;
> > >  	VMA_ITERATOR(vmi, mm, addr);
> > > -	unsigned long nr_pages, nr_accounted;
> > > -
> > > -	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> > > -
> > > -	/* Check against address space limit. */
> > > -	/*
> > > -	 * MAP_FIXED may remove pages of mappings that intersects with requested
> > > -	 * mapping. Account for the pages it would unmap.
> > > -	 */
> > > -	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
> > > -		return -ENOMEM;
> > >
> > >  	if (unlikely(!can_modify_mm(mm, addr, end)))
> > >  		return -EPERM;
> > > @@ -2987,6 +2955,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  			vma_iter_next_range(&vmi);
> > >  	}
> > >
> > > +	/* Check against address space limit. */
> > > +	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
> > > +		goto abort_munmap;
> > > +
> >
> > I know you can literally only do this after the vms_gather_munmap_vmas(),
> > but this does change where we check this, so for instance we do
> > arch_unmap() without having checked may_expand_vm().
> >
> > However I assume this is fine?
>
> Thanks for pointing this out.
>
> The functionality here has changed
> --- from ---
> may_expand_vm() check
> can_modify_mm() check
> arch_unmap()
> vms_gather_munmap_vmas()
> ...
>
> --- to ---
> can_modify_mm() check
> arch_unmap()
> vms_gather_munmap_vmas()
> may_expand_vm() check
> ...
>
> vms_gather_munmap_vmas() does nothing but figures out what to do later,
> but could use memory and can fail.
>
> The user implications are:
>
> 1. The return type on the error may change to -EPERM from -ENOMEM, if
> you are not allowed to expand and are trying to overwrite mseal()'ed
> VMAs. That seems so very rare that I'm not sure it's worth mentioning.
>
>
> 2. arch_unmap() called prior to may_expand_vm().
> powerpc uses this to set mm->context.vdso = NULL if mm->context.vdso is
> within the unmap range.  User implication of this means that an
> application my set the vdso to NULL prior to hitting the -ENOMEM case in
> may_expand_vm() due to the address space limit.
>
> Assuming the removal of the vdso does not cause the application to seg
> fault, then the user visible change is that any vdso call after a failed
> mmap(MAP_FIXED) call would result in a seg fault.  The only reason it
> would fail is if the mapping process was attempting to map a large
> enough area over the vdso (which is accounted and in the vma tree,
> afaict) and ran out of memory. Note that this situation could arise
> already since we could run out of memory (not accounting) after the
> arch_unmap() call within the kernel.
>
> The code today can suffer the same fate, but not by the accounting
> failure.  It can happen due to failure to allocate a new vma,
> do_vmi_munmap() failure after the arch_unmap() call, or any of the other
> failure scenarios later in the mmap_region() function.
>
> At the very least, this requires an expanded change log.

Indeed, also (as mentioned on IRC) I feel like we need to look at whether
we _truly_ need this arch_unmap() call for a single, rather antiquated,
architecture.

I mean why are they unmapping the VDSO, why is that valid, why does it need
that field to be set to NULL, is it possible to signify that in some other
way etc.?

Regardless, I think the change you make here is fine and shouldn't be a
blocker for your changes at all.

But agreed, I do think expanding the change log a bit would be helpful.

>
> >
> > >  	/*
> > >  	 * Private writable mapping: check memory availability
> > >  	 */
> > > --
> > > 2.43.0
> > >
> >
> > Looks good to me generally,
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

